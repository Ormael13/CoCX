/* global Int8Array, DataView, ArrayBuffer, error */
/**
 * @author Gabriel Mariani
 *
 * http://www.adamia.com/blog/high-performance-javascript-port-of-actionscript-byteArray
 */
var ByteArray;
(function() {
    var fromCharCode = String.fromCharCode,
        pow = Math.pow,
        //max = Math.max,
        debug = false;

    function trace() {
        if (!debug) return;

        var arr = [];
        for (var i = 0, l = arguments.length; i < l; i++) {
            arr[i] = arguments[i];
        }

        postMessage({
            type: 'debug',
            message: arr,
        });
    }
    ByteArray = function(data, endian) {
        var t = this;
        if (data == undefined) {
            data = new ArrayBuffer(1024 * 1024 * 5); // 5 mb max size
            t.length = 0; // we track this since the arraybuffer is 5mb
        } else {
            t.length = data.byteLength;
        }

        t.position = 0;
        t.endian = endian !== undefined ? endian : ByteArray.BIG_ENDIAN;
        t._bitBuffer = null;
        t._bitPosition = 8;
        t._buffer = data;
        t._dataview = new DataView(t._buffer);

        // Add redundant members that match actionscript for compatibility
        var funcMap = {
            readUnsignedByte: 'readUI8',
            readUnsignedShort: 'readUI16',
            readUnsignedInt: 'readUI32',
            readByte: 'readSI8',
            readShort: 'readSI16',
            readInt: 'readSI32',
            readBoolean: 'readUI8',
            writeUnsignedByte: 'writeUI8',
            writeUnsignedShort: 'writeUI16',
            writeUnsignedInt: 'writeUI32',
            writeByte: 'writeSI8',
            writeShort: 'writeSI16',
            writeInt: 'writeSI32',
            writeBoolean: 'writeUI8',
        };
        for (var func in funcMap) {
            t[func] = t[funcMap[func]];
        }
    };

    ByteArray.BIG_ENDIAN = 'bigEndian';
    ByteArray.LITTLE_ENDIAN = 'littleEndian';

    ByteArray.prototype = {
        resizeBuffer: function(capacity) {
            var buffer = new ArrayBuffer(capacity);
            new Int8Array(buffer).set(new Int8Array(this._buffer));
            this._buffer = buffer;
            this._dataview = new DataView(buffer);
        },

        getBytesAvailable: function() {
            return this.length - this.position;
        },

        seek: function(offset, absolute) {
            var t = this;
            t.position = (absolute ? 0 : t.position) + offset;
            t.align();
            return t;
        },

        readBytes: function(length) {
            var pos = (this.position += length) - length;
            return this._dataview.slice(pos, this.position);
        },

        writeBytes: function(value /*:ByteArray|Array*/) {
            var arr, i;
            trace('writeBytes', Array.isArray(value));
            if (Array.isArray(value)) {
                arr = value; //new Int8Array(value.length);
                //arr.set(value);
            } else {
                arr = new Int8Array(value._dataview.buffer);
            }

            for (i = 0; i < value.length; i++) {
                this.writeByte(arr[i]);
            }
        },

        /*deflate: function(parseLimit) {
		var zip = new ZipUtil(this);
		return zip.deflate(parseLimit);
	},*/

        /////////////////////////////////////////////////////////
        // Integers
        /////////////////////////////////////////////////////////

        readByteAt: function(pos) {
            return this._dataview[pos];
        },

        writeByteAt: function(pos, value) {
            this._dataview[pos] = value;
        },

        // Unsigned Number
        /*readNumber: function(numBytes, bigEnd) {
		var t = this, val = 0;
		if (bigEnd == undefined) bigEnd = !!(t.endian == ByteArray.BIG_ENDIAN);
		if (bigEnd) {
			while (numBytes--) val = (val << 8) | t.readByteAt(t.position++);
		} else {
			var o = t.position, i = o + numBytes;
			while(i > o) val = (val << 8) | t.readByteAt(--i);
			t.position += numBytes;
		}

		t.align();
		return val;
	},

	writeNumber: function(numBytes, value, bigEnd) {
		//http://jsfromhell.com/classes/binary-parser
		var t = this, bits = numBytes * 8, max = pow(2, bits), r = [];
		//(value >= max || value < -(max >> 1)) && this.warn("encodeInt::overflow") && (value = 0);
		if (value < 0) value += max;
		for(; value; r[r.length] = fromCharCode(value % 256), value = Math.floor(value / 256));
		for(bits = -(-bits >> 3) - r.length; bits--; r[r.length] = "\0");
		if (bigEnd == undefined) bigEnd = !!(t.endian == ByteArray.BIG_ENDIAN);
		var numStr = (bigEnd ? r.reverse() : r).join('');
		t.writeBytes(numStr);
		t.position += numBytes;
		t.align();
	},*/

        // Signed Number
        /*readSNumber: function(numBytes, bigEnd) {
		var val = this.readNumber(numBytes, bigEnd),
		numBits = numBytes * 8,
		_max = pow(2, numBits);
		if (val >> (numBits - 1)) val -= pow(2, numBits);
		return val;
	},

	writeSNumber: function(numBytes, value, bigEnd) {
		this.writeNumber(numBytes, value, bigEnd)
	},*/

        readSI8: function() {
            var val = this._dataview.getInt8(this.position);
            this.position += 1;
            this.align();
            return val;
        },

        writeSI8: function(value) {
            var val = this._dataview.setInt8(this.position, parseInt(value));
            this.position += 1;
            this.length += 1;
            this.align();
            return val;
        },

        readSI16: function(bigEnd) {
            var val = this._dataview.getInt16(this.position, bigEnd);
            this.position += 2;
            this.align();
            return val;
        },

        writeSI16: function(value, bigEnd) {
            var val = this._dataview.setInt16(this.position, value, bigEnd);
            this.position += 2;
            this.length += 2;
            this.align();
            return val;
        },

        readSI32: function(bigEnd) {
            var val = this._dataview.getInt32(this.position, bigEnd);
            this.position += 4;
            this.align();
            return val;
        },

        writeSI32: function(value, bigEnd) {
            var val = this._dataview.setInt32(this.position, value, bigEnd);
            this.position += 4;
            this.length += 4;
            this.align();
            return val;
        },

        readUI8: function() {
            var val = this._dataview.getUint8(this.position);
            this.position += 1;
            this.align();
            return val;
        },

        writeUI8: function(value) {
            var val = this._dataview.setUint8(this.position, parseInt(value));
            this.position += 1;
            this.length += 1;
            this.align();
            return val;
        },

        readUI16: function(bigEnd) {
            var val = this._dataview.getUint16(this.position, bigEnd);
            this.position += 2;
            this.align();
            return val;
        },

        writeUI16: function(value, bigEnd) {
            var val = this._dataview.setUint16(this.position, value, bigEnd);
            this.position += 2;
            this.length += 2;
            this.align();
            return val;
        },

        /*readUI24: function(bigEnd) {
		return this.readNumber(3, bigEnd);
	},

	writeUI24: function(value, bigEnd) {
		this.writeNumber(3, value, bigEnd);
	},*/

        readUI32: function(bigEnd) {
            var val = this._dataview.getUint32(this.position, bigEnd);
            this.position += 4;
            this.align();
            return val;
        },

        writeUI32: function(value, bigEnd) {
            var val = this._dataview.setUint32(this.position, value, bigEnd);
            this.position += 4;
            this.length += 4;
            this.align();
            return val;
        },

        /////////////////////////////////////////////////////////
        // Fixed-point numbers
        /////////////////////////////////////////////////////////

        _readFixedPoint: function(numBits, precision) {
            return this.readSB(numBits) * pow(2, -precision);
        },

        readFixed: function() {
            return this._readFixedPoint(32, 16);
        },

        readFixed8: function() {
            return this._readFixedPoint(16, 8);
        },

        readFB: function(numBits) {
            return this._readFixedPoint(numBits, 16);

            // SWFAssist
            //return this.readSB(numBits) / 65536;
        },

        /////////////////////////////////////////////////////////
        // Floating-point numbers
        /////////////////////////////////////////////////////////

        readFloat: function(bigEnd) {
            var val = this._dataview.getFloat32(this.position, bigEnd);
            this.position += 4;
            this.align();
            return val;
        },

        writeFloat: function(value, bigEnd) {
            var val = this._dataview.setFloat32(this.position, value, bigEnd);
            this.position += 4;
            this.length += 4;
            this.align();
            return val;
        },

        // 8 byte IEEE-754 double precision floating point value in network byte order (sign bit in low memory).
        readDouble: function(bigEnd) {
            var val = this._dataview.getFloat64(this.position, bigEnd);
            this.position += 8;
            this.align();
            return val;
        },

        writeDouble: function(value, bigEnd) {
            var val = this._dataview.setFloat64(this.position, value, bigEnd);
            this.position += 8;
            this.length += 8;
            this.align();
            return val;
        },

        /////////////////////////////////////////////////////////
        // Encoded integer
        /////////////////////////////////////////////////////////

        readEncodedU32: function() {
            var val = 0;
            for (var i = 0; i < 5; i++) {
                var num = this.readByteAt(this.position++);
                val = val | ((num & 0x7f) << (7 * i));
                if (!(num & 0x80)) break;
            }
            return val;
        },

        /////////////////////////////////////////////////////////
        // Bit values
        /////////////////////////////////////////////////////////

        align: function() {
            this._bitPosition = 8;
            this._bitBuffer = null;
        },

        readUB: function(numBits, lsb) {
            var t = this,
                val = 0;
            for (var i = 0; i < numBits; i++) {
                if (8 == t._bitPosition) {
                    t._bitBuffer = t.readUI8();
                    t._bitPosition = 0;
                }

                if (lsb) {
                    val |=
                        (t._bitBuffer & (0x01 << t._bitPosition++) ? 1 : 0) <<
                        i;
                } else {
                    val =
                        (val << 1) |
                        (t._bitBuffer & (0x80 >> t._bitPosition++) ? 1 : 0);
                }
            }

            return val;
        },

        writeUB: function(value, numBits) {
            if (0 == numBits) return;

            var t = this;
            if (t._bitPosition == 0) t._bitPosition = 8;

            while (numBits > 0) {
                while (t._bitPosition > 0 && numBits > 0) {
                    if ((value & (0x01 << (numBits - 1))) != 0) {
                        t._bitBuffer =
                            t._bitBuffer | (0x01 << (t._bitPosition - 1));
                    }

                    --numBits;
                    --t._bitPosition;
                }

                if (0 == t._bitPosition) {
                    t.writeUI8(t._bitBuffer);
                    t._bitBuffer = 0;

                    if (numBits > 0) t._bitPosition = 8;
                }
            }
        },

        readSB: function(numBits) {
            if (!numBits) return 0;

            var val = this.readUB(numBits);

            // SWFWire
            var leadingDigit = val >>> (numBits - 1);
            if (leadingDigit == 1) return -((~val & (~0 >>> -numBits)) + 1);
            return val;

            // SWFAssist
            //var shift = 32 - numBits;
            //var result = (val << shift) >> shift;
            //return result;

            // Gordon
            //if (val >> (numBits - 1)) val -= pow(2, numBits);
            //return val;
        },

        writeSB: function(value, numBits) {
            this.writeUB(
                value |
                    ((value < 0 ? 0x80000000 : 0x00000000) >> (32 - numBits)),
                numBits
            );
        },

        /////////////////////////////////////////////////////////
        // String
        /////////////////////////////////////////////////////////

        /**
        Reads a single UTF-8 character
        http://en.wikipedia.org/wiki/UTF-8
        */
        readUTFChar: function() {
            var code_unit1, code_unit2, code_unit3, code_unit4;

            function error4() {
                this.position -= 3;
                return error1();
            }

            function error3() {
                this.position -= 2;
                return error1();
            }

            function error2() {
                this.position -= 1;
                return error1();
            }

            function error1() {
                return String.fromCharCode(code_unit1 + 0xdc00);
            }

            code_unit1 = this.readUI8();
            if (code_unit1 < 0x80) {
                return String.fromCharCode(code_unit1);
            } else if (code_unit1 < 0xc2) {
                /* continuation or overlong 2-byte sequence */
                return error1();
            } else if (code_unit1 < 0xe0) {
                /* 2-byte sequence */
                code_unit2 = this.readUI8();
                if ((code_unit2 & 0xc0) != 0x80) return error2();
                return String.fromCharCode(
                    (code_unit1 << 6) + code_unit2 - 0x3080
                );
            } else if (code_unit1 < 0xf0) {
                /* 3-byte sequence */
                code_unit2 = this.readUI8();
                if ((code_unit2 & 0xc0) != 0x80) return error2();
                if (code_unit1 == 0xe0 && code_unit2 < 0xa0)
                    return error2(); /* overlong */
                code_unit3 = this.readUI8();
                if ((code_unit3 & 0xc0) != 0x80) return error3();
                return String.fromCharCode(
                    (code_unit1 << 12) +
                        (code_unit2 << 6) +
                        code_unit3 -
                        0xe2080
                );
            } else if (code_unit1 < 0xf5) {
                /* 4-byte sequence */
                code_unit2 = this.readUI8();
                if ((code_unit2 & 0xc0) != 0x80) return error2();
                if (code_unit1 == 0xf0 && code_unit2 < 0x90)
                    return error2(); /* overlong */
                if (code_unit1 == 0xf4 && code_unit2 >= 0x90)
                    return error2(); /* > U+10FFFF */
                code_unit3 = this.readUI8();
                if ((code_unit3 & 0xc0) != 0x80) return error3();
                code_unit4 = this.readUI8();
                if ((code_unit4 & 0xc0) != 0x80) return error4();
                return String.fromCharCode(
                    (code_unit1 << 18) +
                        (code_unit2 << 12) +
                        (code_unit3 << 6) +
                        code_unit4 -
                        0x3c82080
                );
            } else {
                /* > U+10FFFF */
                return error1();
            }
        },

        writeUTFChar: function(rawChar) {
            var code_point = rawChar.charCodeAt(0);
            if (code_point < 0x80) {
                this.writeUI8(code_point);
            } else if (code_point <= 0x7ff) {
                this.writeUI8((code_point >> 6) + 0xc0);
                this.writeUI8((code_point & 0x3f) + 0x80);
            } else if (code_point <= 0xffff) {
                this.writeUI8((code_point >> 12) + 0xe0);
                this.writeUI8(((code_point >> 6) & 0x3f) + 0x80);
                this.writeUI8((code_point & 0x3f) + 0x80);
            } else if (code_point <= 0x10ffff) {
                this.writeUI8((code_point >> 18) + 0xf0);
                this.writeUI8(((code_point >> 12) & 0x3f) + 0x80);
                this.writeUI8(((code_point >> 6) & 0x3f) + 0x80);
                this.writeUI8((code_point & 0x3f) + 0x80);
            } else {
                throw error('writeUTFChar: Invalid char code');
            }
        },

        readUTFBytes: function(numChars, doTrace) {
            var t = this,
                str = null,
                chars = [];
            var endPos = t.position + numChars;
            while (t.position < endPos) {
                chars.push(this.readUTFChar(doTrace));
            }
            str = chars.join('');
            return str;
        },

        writeUTFBytes: function(value) {
            var chars = value.split(''),
                l = value.length;
            while (l--) {
                this.writeUTFChar(chars.shift());
            }
        },

        /**
        Reads a UTF-8 string from the byte stream. The string is assumed to be
        prefixed with an unsigned short indicating the length in bytes.
        */
        readUTF: function() {
            var len = this.readUI16();
            return this.readUTFBytes(len);
        },

        writeUTF: function(value) {
            var startPos = this.position;
            this.writeUI16(value.length);
            this.writeUTFBytes(value);

            // With UTF characters, the bytes can be longer than the original string
            // We write the bytes, then subtract the guessed length earlier
            var utfLen = this.position - startPos - 2;
            // Here we overwrite the original guess length
            this._dataview.setUint16(startPos, utfLen);
        },

        /*
        In SWF 5 or earlier, STRING values are encoded using either ANSI (which is a superset of
        ASCII) or shift-JIS (a Japanese encoding). You cannot indicate the encoding that is used;
        instead, the decoding choice is made according to the locale in which Flash Player is running.
        This means that text content in SWF 5 or earlier can only be encoded in ANSI or shift-JIS,
        and the target audience must be known during authoring—otherwise garbled text results.

        In SWF 6 or later, STRING values are always encoded by using the Unicode UTF-8 standard.
        This is a multibyte encoding; each character is composed of between one and four bytes.
        UTF-8 is a superset of ASCII; the byte range 0 to 127 in UTF-8 exactly matches the ASCII
        mapping, and all ASCII characters 0 to 127 are represented by just one byte. UTF-8
        guarantees that whenever a character other than character 0 (the null character) is encoded by
        using more than one byte, none of those bytes are zero. This avoids the appearance of internal
        null characters in UTF-8 strings, meaning that it remains safe to treat null bytes as string
        terminators, just as for ASCII strings.
        */
        readString: function(numChars, simple) {
            var t = this,
                b = t._dataview,
                str = null;
            if (undefined != numChars) {
                str = b.substr(t.position, numChars);
                t.position += numChars;
            } else {
                var chars = [],
                    i = t.length - t.position;
                while (i--) {
                    var code = t.readByteAt(t.position++),
                        code2,
                        code3;
                    if (code) {
                        if (simple) {
                            // Read raw
                            chars.push(fromCharCode(code));
                        } else {
                            // Fix multibyte UTF characters
                            if (code < 128) {
                                chars.push(fromCharCode(code));
                            } else if (code > 191 && code < 224) {
                                code2 = t.readByteAt(t.position++);
                                chars.push(
                                    fromCharCode(
                                        ((code & 31) << 6) | (code2 & 63)
                                    )
                                );
                                i--;
                            } else {
                                code2 = t.readByteAt(t.position++);
                                code3 = t.readByteAt(t.position++);
                                chars.push(
                                    fromCharCode(
                                        ((code & 15) << 12) |
                                            ((code2 & 63) << 6) |
                                            (code3 & 63)
                                    )
                                );
                                i -= 2;
                            }
                        }
                    } else {
                        break;
                    }
                }
                str = chars.join('');
            }

            // Fix ™ entity
            //str = str.replace('â¢', '™', 'g');

            return str;
        },

        /////////////////////////////////////////////////////////
        // Boolean
        /////////////////////////////////////////////////////////

        /*readBool: function(numBits) {
		return !!this.readUB(numBits || 1);
	},

	writeBool: function(numBits) {
		//return !!this.readUB(numBits || 1);
	}*/
    };
})();
