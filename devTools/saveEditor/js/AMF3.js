/* global ByteArray */
var AMF3;
(function () {
    /*
uint8 - BYTE - readUnsignedByte - U8
int8 - CHAR - readByte
uint16 - USHORT - readUnsignedShort - U16
int16 - SHORT - readShort
uint32 - ULONG - readUnsignedInt - U32
int32 - LONG - readInt

readBoolean : moves position by 1
readByte : moves position by 1
readDouble : moves position by 8
readFloat : moves position by 4
readInt : moves position by 4
readMultiByte : Reads a multibyte string of specified length from the file stream, byte stream
readShort : moves position by 2
readUnsignedByte : moves position by 1
readUnsignedInt : moves position by 4
readUnsignedShort : moves position by 2
readUTF : reads based on assumed prefix of string length
readUTFBytes : moves specified amount

NaN (FF F8 00 00 00 00 00 00), Infinity (FF F0 00 00 00 00 00 00), and -Infinity (7F F0 00 00 00 00 00 00) are read in as 0

*/
    var debug = false;
    function trace() {
        if (!debug) return;

        //var str = '';
        var arr = [];
        for (var i = 0, l = arguments.length; i < l; i++) {
            //str += arguments[i];
            arr[i] = arguments[i];
            //if (i != (l - 1)) str += ', ';
        }
        //str += '\n';

        postMessage({
            type: 'debug',
            message: arr,
        });

        //dump(str);
    }
    //var ERROR = trace;

    function WARNING() {
        if (!debug) return;

        //var str = '';
        var arr = [];
        for (var i = 0, l = arguments.length; i < l; i++) {
            //str += arguments[i];
            arr[i] = arguments[i];
            //if (i != (l - 1)) str += ', ';
        }
        //str += '\n';

        postMessage({
            type: 'warning',
            message: arr,
        });
    }

    function ALERT() {
        if (!debug) return;

        //var str = '';
        var arr = [];
        for (var i = 0, l = arguments.length; i < l; i++) {
            //str += arguments[i];
            arr[i] = arguments[i];
            //if (i != (l - 1)) str += ', ';
        }
        //str += '\n';

        postMessage({
            type: 'alert',
            message: arr,
        });
    }

    /*function traceByteArray(ba) {
        trace(ba.position, Array.apply([], new Int8Array(ba._buffer.slice(0, ba.position))));
    }*/

    /*var temp_count3 = 0;
	temp_count4 = 0;*/

    AMF3 = function () {
        //--------------------------------------
        //  Public Vars
        //--------------------------------------

        //--------------------------------------
        //  Private Vars
        //--------------------------------------

        // The raw binary data
        this._rawData = null;

        // The decoded data
        this._data = null;

        this.readObjectCache = [];
        this.readStringCache = [];
        this.readTraitsCache = [];

        this.writeStringCache = [];
        this.writeObjectCache = [];
        this.writeTraitsCache = [];

        //--------------------------------------
        //  Constructor
        //--------------------------------------
    };

    AMF3.prototype = {
        // AMF marker constants
        UNDEFINED_TYPE: 0,
        NULL_TYPE: 1,
        FALSE_TYPE: 2,
        TRUE_TYPE: 3,
        INTEGER_TYPE: 4,
        DOUBLE_TYPE: 5,
        STRING_TYPE: 6,
        XML_DOC_TYPE: 7,
        DATE_TYPE: 8,
        ARRAY_TYPE: 9,
        OBJECT_TYPE: 10,
        XML_TYPE: 11,
        BYTE_ARRAY_TYPE: 12,
        // Added in Flash Player 10
        VECTOR_INT_TYPE: 13,
        VECTOR_UINT_TYPE: 14,
        VECTOR_DOUBLE_TYPE: 15,
        VECTOR_OBJECT_TYPE: 16,
        DICTIONARY_TYPE: 17,

        /**
         * The maximum value for an <code>int</code> that will avoid promotion to an
         * ActionScript Number when sent via AMF 3 is 2<sup>28</sup> - 1, or <code>0x0FFFFFFF</code>.
         */
        INT28_MAX_VALUE: 268435455,

        /**
         * The minimum value for an <code>int</code> that will avoid promotion to an
         * ActionScript Number when sent via AMF 3 is -2<sup>28</sup> or <code>0xF0000000</code>.
         */
        INT28_MIN_VALUE: -268435456,

        EMPTY_STRING: '',

        /**
         * Internal use only.
         * @exclude
         */
        UINT29_MASK: 0x1fffffff, // 2^29 - 1 : 536 870 911

        // Simplified implementaiton of the class alias registry
        CLASS_ALIAS_REGISTRY: {
            DSK: 'flex.messaging.messages.AcknowledgeMessageExt',
            DSA: 'flex.messaging.messages.AsyncMessageExt',
            DSC: 'flex.messaging.messages.CommandMessageExt',
        },

        type2Name: function (type) {
            switch (type) {
                case this.UNDEFINED_TYPE:
                    return 'UNDEFINED_TYPE';
                case this.NULL_TYPE:
                    return 'NULL_TYPE';
                case this.FALSE_TYPE:
                    return 'FALSE_TYPE';
                case this.TRUE_TYPE:
                    return 'TRUE_TYPE';
                case this.INTEGER_TYPE:
                    return 'INTEGER_TYPE';
                case this.DOUBLE_TYPE:
                    return 'DOUBLE_TYPE';
                case this.STRING_TYPE:
                    return 'STRING_TYPE';
                case this.XML_DOC_TYPE:
                    return 'XML_DOC_TYPE';
                case this.DATE_TYPE:
                    return 'DATE_TYPE';
                case this.ARRAY_TYPE:
                    return 'ARRAY_TYPE';
                case this.OBJECT_TYPE:
                    return 'OBJECT_TYPE';
                case this.XML_TYPE:
                    return 'XML_TYPE';
                case this.BYTE_ARRAY_TYPE:
                    return 'BYTE_ARRAY_TYPE';
                case this.VECTOR_INT_TYPE:
                    return 'VECTOR_INT_TYPE';
                case this.VECTOR_UINT_TYPE:
                    return 'VECTOR_UINT_TYPE';
                case this.VECTOR_DOUBLE_TYPE:
                    return 'VECTOR_DOUBLE_TYPE';
                case this.VECTOR_OBJECT_TYPE:
                    return 'VECTOR_OBJECT_TYPE';
                case this.DICTIONARY_TYPE:
                    return 'DICTIONARY_TYPE';
                default:
                    return '?';
            }
        },

        // Reads the amf3 data
        deserialize: function (data) {
            this.reset();

            this._rawData = data;
            this._data = this.readData(this._rawData);
        },

        // Clears the object, string and definition cache
        reset: function () {
            this.readObjectCache = [];
            this.readStringCache = [];
            this.readTraitsCache = [];

            this.writeStringCache = [];
            this.writeObjectCache = [];
            this.writeTraitsCache = [];
        },

        readData: function (ba, internal) {
            var type = ba.readByte();
            trace('readData: ' + type + ' : ' + this.type2Name(type));
            //trace(this.readStringCache);
            switch (type) {
                case this.UNDEFINED_TYPE:
                    return this.readUndefined();
                case this.NULL_TYPE:
                    return this.readNull();
                case this.FALSE_TYPE:
                    return this.readBoolean(false);
                case this.TRUE_TYPE:
                    return this.readBoolean(true);
                case this.INTEGER_TYPE:
                    return this.readInt(ba);
                case this.DOUBLE_TYPE:
                    return this.readDouble(ba);
                case this.STRING_TYPE:
                    return this.readString(ba);
                case this.XML_DOC_TYPE:
                    return this.readXMLDoc(ba);
                case this.DATE_TYPE:
                    return this.readDate(ba);
                case this.ARRAY_TYPE:
                    return this.readArray(ba);
                case this.OBJECT_TYPE:
                    return this.readObject(ba, internal);
                case this.XML_TYPE:
                    return this.readXML(ba);
                case this.BYTE_ARRAY_TYPE:
                    return this.readByteArray(ba);
                case this.VECTOR_INT_TYPE:
                    return this.readVectorInt(ba); // Vector.<int>
                case this.VECTOR_UINT_TYPE:
                    return this.readVectorUInt(ba); // Vector.<uint>
                case this.VECTOR_DOUBLE_TYPE:
                    return this.readVectorDouble(ba); // Vector.<Number>
                case this.VECTOR_OBJECT_TYPE:
                    return this.readVectorObject(ba); // Vector.<Object>
                case this.DICTIONARY_TYPE:
                    return this.readDictionary(ba);
                default:
                    throw Error("Undefined AMF3 type encountered '" + type + "'");
            }
        },

        writeData: function (ba, node) {
            var type = node.__traits.type;
            if (node.__traits.hasOwnProperty('origType')) type = node.__traits.origType;
            //trace('writeData', type, node);
            switch (type) {
                case 'Undefined':
                    this.writeUndefined(ba);
                    break;
                case 'Null':
                    this.writeNull(ba);
                    break;
                case 'False':
                    this.writeBoolean(ba, false);
                    break;
                case 'True':
                    this.writeBoolean(ba, true);
                    break;
                case 'Integer':
                    this.writeInt(ba, node.value);
                    break;
                case 'Number':
                    this.writeDouble(ba, node.value);
                    break;
                case 'String':
                    ba.writeByte(this.STRING_TYPE);
                    this.writeString(ba, node.value);
                    break;
                case 'XMLDocument':
                    this.writeXMLDoc(ba, node.value);
                    break;
                case 'Date':
                    this.writeDate(ba, node.value);
                    break;
                case 'Array':
                    this.writeArray(ba, node.value);
                    break;
                case 'Object':
                    this.writeObject(ba, node.value, node.__traits);
                    break;
                case 'XML':
                    this.writeXML(ba, node.value);
                    break;
                case 'ByteArray':
                    this.writeByteArray(ba, node.value);
                    break;
                case 'Vector.<int>':
                    this.writeVectorInt(ba, node.value, node.__traits);
                    break;
                case 'Vector.<uint>':
                    this.writeVectorUInt(ba, node.value, node.__traits);
                    break;
                case 'Vector.<Number>':
                    this.writeVectorDouble(ba, node.value, node.__traits);
                    break;
                case 'Vector.<Object>':
                    this.writeVectorObject(ba, node.value, node.__traits);
                    break;
                case 'Dictionary':
                    this.writeDictionary(ba, node.value, node.__traits);
                    break;
                default:
                    throw Error("Undefined AMF3 type encountered '" + type + "'");
            }
        },

        /**
         * In AMF 3 integers are serialized using a variable length unsigned 29-bit integer. The ActionScript 3.0
         * integer types - a signed 'int' type and an unsigned 'uint' type - are also represented using 29-bits in
         * AVM+. If the value of an unsigned integer (uint) is greater or equal to 2^29 or if the value of a signed
         * integer (int) is greater than or equal to 2^28 then it will be represented by AVM+ as a double and thus
         * serialized in using the AMF 3 double type.
         *
         * integer-type = integer-marker U29
         *
         * @param	ba
         * @param	value
         */
        readUInt29: function (ba) {
            var result = 0;

            // Each byte must be treated as unsigned
            var b = ba.readUnsignedByte();

            if (b < 128) return b;

            result = (b & 0x7f) << 7;
            b = ba.readUnsignedByte();
            if (b < 128) return result | b;

            result = (result | (b & 0x7f)) << 7;
            b = ba.readUnsignedByte();
            if (b < 128) return result | b;

            result = (result | (b & 0x7f)) << 8;
            b = ba.readUnsignedByte();
            return result | b;
        },

        writeUInt29: function (ba, value) {
            // Represent smaller integers with fewer bytes using the most
            // significant bit of each byte. The worst case uses 32-bits
            // to represent a 29-bit number, which is what we would have
            // done with no compression.

            // 0x00000000 - 0x0000007F : 0xxxxxxx
            // 0x00000080 - 0x00003FFF : 1xxxxxxx 0xxxxxxx
            // 0x00004000 - 0x001FFFFF : 1xxxxxxx 1xxxxxxx 0xxxxxxx
            // 0x00200000 - 0x3FFFFFFF : 1xxxxxxx 1xxxxxxx 1xxxxxxx xxxxxxxx
            // 0x40000000 - 0xFFFFFFFF : throw range exception

            if (value < 0x80) {
                // Less than 128 - 0x00000000 - 0x0000007F : 0xxxxxxx
                ba.writeByte(value);
            } else if (value < 0x4000) {
                // Less than 16,384 - 0x00000080 - 0x00003FFF : 1xxxxxxx 0xxxxxxx
                ba.writeByte(((value >> 7) & 0x7f) | 0x80);
                ba.writeByte(value & 0x7f);
            } else if (value < 0x200000) {
                // Less than 2,097,152 - 0x00004000 - 0x001FFFFF : 1xxxxxxx 1xxxxxxx 0xxxxxxx
                ba.writeByte(((value >> 14) & 0x7f) | 0x80);
                ba.writeByte(((value >> 7) & 0x7f) | 0x80);
                ba.writeByte(value & 0x7f);
            } else if (value < 0x40000000) {
                // 0x00200000 - 0x3FFFFFFF : 1xxxxxxx 1xxxxxxx 1xxxxxxx xxxxxxxx
                ba.writeByte(((value >> 22) & 0x7f) | 0x80);
                ba.writeByte(((value >> 15) & 0x7f) | 0x80);
                ba.writeByte(((value >> 8) & 0x7f) | 0x80);
                ba.writeByte(value & 0xff);
            } else {
                // 0x40000000 - 0xFFFFFFFF : throw range exception
                throw new Error('Integer out of range: ' + value);
            }
        },

        /**
         * The undefined type is represented by the undefined type marker. No further information is encoded for
         * this value.
         *
         * undefined-type = undefined-marker
         *
         * Note that endpoints other than the AVM may not have the concept of undefined and may choose to represent
         * undefined as null.
         *
         * @param	ba
         */
        readUndefined: function () {
            return { value: null, __traits: { type: 'Undefined' } };
        },

        writeUndefined: function (ba) {
            ba.writeByte(this.UNDEFINED_TYPE);
        },

        /**
         * The null type is represented by the null type marker. No further information is encoded for this value.
         *
         * null-type = null-marker
         *
         * @param	ba
         */
        readNull: function () {
            return { value: null, __traits: { type: 'Null' } };
        },

        writeNull: function (ba) {
            ba.writeByte(this.NULL_TYPE);
        },

        /**
         * The false type is represented by the false type marker and is used to encode a Boolean value of false.
         * Note that in ActionScript 3.0 the concept of a primitive and Object form of Boolean does not exist.
         * No further information is encoded for this value.
         *
         * false-type = false-marker
         *
         * The true type is represented by the true type marker and is used to encode a Boolean value of true.
         * Note that in ActionScript 3.0 the concept of a primitive and Object form of Boolean does not exist.
         * No further information is encoded for this value.
         *
         * true-type = true-marker
         *
         * @param	ba
         * @param	value
         */
        readBoolean: function (bool) {
            return {
                value: bool ? 1 : 0,
                __traits: { type: bool ? 'True' : 'False' },
            };
        },

        writeBoolean: function (ba, value) {
            ba.writeByte(value ? this.TRUE_TYPE : this.FALSE_TYPE);
        },

        /**
         * A value greater than or equal to 2^28, or if a signed integer (int) is less than
         * -2^28, it will be serialized using the AMF 3 double type
         */
        readInt: function (ba) {
            // Symmetric with writing an integer to fix sign bits for negative values...
            return {
                value: (this.readUInt29(ba) << 3) >> 3,
                __traits: { type: 'Integer' },
            };
        },

        writeInt: function (ba, value) {
            if (value >= this.INT28_MIN_VALUE && value <= this.INT28_MAX_VALUE && value % 1 == 0) {
                // We have to be careful when the MSB is set, as (value >> 3) will sign extend.
                // We know there are only 29-bits of precision, so truncate. This requires
                // similar care when reading an integer.
                //value = ((value >> 3) & this.UINT29_MASK);
                value &= this.UINT29_MASK; // Mask is 2^29 - 1
                ba.writeByte(this.INTEGER_TYPE);
                this.writeUInt29(ba, value);
            } else {
                // Promote large int to a double
                this.writeDouble(ba, value);
            }
        },

        /**
         * The AMF 3 double type is encoded in the same manner as the AMF 0 Number type. This type is used to
         * encode an ActionScript Number or an ActionScript int of value greater than or equal to 2^28 or an
         * ActionScript uint of value greater than or equal to 2^29. The encoded value is is always an 8 byte
         * IEEE-754 double precision floating point value in network byte order (sign bit in low memory).
         *
         * double-type = double-marker DOUBLE
         *
         * @param	ba
         * @param	value
         */
        readDouble: function (ba) {
            return { value: ba.readDouble(), __traits: { type: 'Number' } };
        },

        writeDouble: function (ba, value) {
            ba.writeByte(this.DOUBLE_TYPE);
            ba.writeDouble(value);
        },

        /**
         * ActionScript String values are represented using a single string type in AMF 3 - the concept of string
         * and long string types from AMF 0 is not used.
         *
         * Strings can be sent as a reference to a previously occurring String by using an index to the implicit
         * string reference table.
         *
         * Strings are encoding using UTF-8 - however the header may either describe a string literal or a string
         * reference.
         *
         * The empty String is never sent by reference.
         *
         * string-type = string-marker UTF-8-vr
         *
         * @param	ba
         * @param	value
         */
        readString: function (ba) {
            var ref = this.readUInt29(ba);
            if ((ref & 1) == 0) return this.getStringReference(ref >> 1);

            // writeString() special cases the empty string
            // to avoid creating a reference.
            var len = ref >> 1;
            var str = { value: '', __traits: { type: 'String' } };
            if (len > 0) {
                str.value = ba.readUTFBytes(len);
                this.readStringCache.push(str);
            }

            return str;
        },

        writeString: function (ba, value, writeRef) {
            if (writeRef === undefined) writeRef = true;

            // Note: Type is not encoded here because writeString is used for multiple types
            if (value == '') {
                // Write 0x01 to specify the empty string
                ba.writeByte(0x01);
            } else {
                // Get actual byte length, sometimes foreign languages require more bytes
                var b = new ByteArray();
                b.writeUTFBytes(value);
                var len = b.length;

                if (writeRef) {
                    if (this.setStringReference(ba, value)) {
                        this.writeUInt29(ba, (len << 1) | 1);
                        ba.writeUTFBytes(value);
                    }
                } else {
                    this.writeUInt29(ba, (len << 1) | 1);
                    ba.writeUTFBytes(value);
                }
            }
        },

        /**
         * ActionScript 3.0 introduced a new XML type however the legacy XMLDocument type is retained in
         * the language as flash.xml.XMLDocument. Similar to AMF 0, the structure of an XMLDocument needs to be
         * flattened into a string representation for serialization. As with other strings in AMF, the content is
         * encoded in UTF-8.
         *
         * XMLDocuments can be sent as a reference to a previously occurring XMLDocument instance by using an index
         * to the implicit object reference table.
         *
         * U29X-value = U29. The first (low) bit is a flag with value 1. The remaining 1 to 28 significant bits are
         * used to encode the byte-length of the UTF-8 encoded representation of the XML or XMLDocument.
         *
         * xml-doc-type = xml-doc-marker (U29O-ref | (U29X-value *(UTF8-char)))
         *
         * Note that this encoding imposes some theoretical limits on the use of XMLDocument. The byte-length of each
         * UTF-8 encoded XMLDocument instance is limited to 2^28 - 1 bytes (approx 256 MB).
         *
         * @param	ba
         * @param	value
         */
        readXMLDoc: function (ba) {
            var ref = this.readUInt29(ba);
            if ((ref & 1) == 0) return this.getObjectReference(ref >> 1);

            var xmldoc = {
                value: ba.readUTFBytes(ref >> 1),
                __traits: { type: 'XMLDocument' },
            };
            this.readObjectCache.push(xmldoc);
            return xmldoc;
        },

        writeXMLDoc: function (ba, value) {
            ba.writeByte(this.XML_DOC_TYPE);

            if (this.setObjectReference(ba, value)) {
                var strXML = value.toString();
                strXML = strXML.replace(/^\s+|\s+$/g, ''); // Trim
                strXML = strXML.replace(/>(\n|\r|\r\n| |\t)*</g, '><'); // Strip whitespaces
                this.writeString(ba, strXML, false);
            }
        },

        /**
         * In AMF 3 an ActionScript Date is serialized simply as the number of milliseconds elapsed since the epoch
         * of midnight, 1st Jan 1970 in the UTC time zone. Local time zone information is not sent.
         *
         * Dates can be sent as a reference to a previously occurring Date instance by using an index to the implicit
         * object reference table.
         *
         * U29D-value = U29 ; The first (low) bit is a flag with value 1. The remaining bits are not used.
         *
         * date-time = DOUBLE ; A 64-bit integer value transported as a double.
         *
         * date-type = date-marker (U29O-ref | (U29D-value date-time))
         *
         * @param	ba
         * @param	value
         */
        readDate: function (ba) {
            var ref = this.readUInt29(ba);
            if ((ref & 1) == 0) return this.getObjectReference(ref >> 1);

            var d = {
                value: new Date(ba.readDouble()),
                __traits: { type: 'Date' },
            };
            this.readObjectCache.push(d);
            return d;
        },

        writeDate: function (ba, value) {
            ba.writeByte(this.DATE_TYPE);

            // Convert numbers to dates
            if (!(value instanceof Date)) value = new Date(value);

            if (this.setObjectReference(ba, value)) {
                // Write out an invalid reference
                this.writeUInt29(ba, 1);
                //ba.writeByte(0x01); // Flag
                ba.writeDouble(value.getTime());
            }
        },

        /**
         * ActionScript Arrays are described based on the nature of their indices, i.e. their type and how they are
         * positioned in the Array. The following table outlines the terms and their meaning:
         *
         * strict - contains only ordinal (numeric) indices
         * dense - ordinal indices start at 0 and do not contain gaps between successive indices (that is, every index is defined from 0 for the length of the array)
         * sparse - contains at least one gap between two indices
         * associative - contains at least one non-ordinal (string) index (sometimes referred to as an ECMA Array)
         *
         * AMF considers Arrays in two parts, the dense portion and the associative portion. The binary representation
         * of the associative portion consists of name/value pairs (potentially none) terminated by an empty string.
         * The binary representation of the dense portion is the size of the dense portion (potentially zero) followed
         * by an ordered list of values (potentially none). The order these are written in AMF is first the size of
         * the dense portion, a empty string terminated list of name/value pairs, followed by size values.
         *
         * Arrays can be sent as a reference to a previously occurring Array by using an index to the implicit object
         * reference table.
         *
         * U29A-value = U29 ; The first (low) bit is a flag with value 1. The remaining 1 to 28 significant bits are
         * used to encode the count of the dense portion of the Array
         *
         * assoc-value = UTF-8-vr value-type
         *
         * array-type = array-marker (U29O-ref | (U29A-value (UTF-8-empty | *(assoc-value) UTF-8-empty) *(value-type)))
         *
         * @param	ba
         * @param	value
         */
        readArray: function (ba) {
            var ref = this.readUInt29(ba);
            if ((ref & 1) == 0) return this.getObjectReference(ref >> 1);

            var l = ref >> 1;
            var arr = new Array(l);
            var isStrict = true;

            // Associative values
            var strKey = this.readString(ba).value;
            while (strKey != '') {
                arr[strKey] = this.readData(ba);
                strKey = this.readString(ba).value;
                isStrict = false;
            }

            // Strict values
            for (var i = 0; i < l; i++) {
                arr[i] = this.readData(ba);
            }

            var val = {
                value: arr,
                __traits: { type: 'Array', strict: isStrict },
            };
            this.readObjectCache.push(val);

            return val;
        },

        writeArray: function (ba, value) {
            var arrNumeric = [], // holder to store the numeric keys
                objString = {}, // holder to store the string keys
                l = value.length, // get the total number of entries for the array
                numElements = 0,
                key,
                i,
                isSparse = false,
                isAssociative = false,
                // Find the numeric and string key values
                strLen = 0;
            for (key in value) {
                numElements++;
                if (!isNaN(key) && key >= 0) {
                    // make sure the keys are numeric
                    arrNumeric[key] = value[key]; // The key is an index in an array
                } else {
                    objString[key] = value[key]; // The key is a property of an object
                    strLen++;
                }
            }

            // Sparse arrays will have a different number of actual items but length reports different
            isSparse = Boolean(numElements < l);
            isAssociative = Boolean(strLen > 0);

            // Array tag
            ba.writeByte(this.ARRAY_TYPE);

            if (this.setObjectReference(ba, value)) {
                // This is a mixed array
                if (isAssociative || isSparse) {
                    // Dynamic object, no classname to write
                    this.writeUInt29(ba, (0 << 1) | 1);

                    for (key in value) {
                        this.writeString(ba, key);
                        this.writeData(ba, value[key]);
                    }

                    // Since this is a dynamic object, add closing tag
                    this.writeString(ba, this.EMPTY_STRING);
                }

                // This is just an array
                else {
                    var numLen = arrNumeric.length;
                    this.writeUInt29(ba, (numLen << 1) | 1);

                    for (key in objString) {
                        this.writeString(ba, key);
                        this.writeData(ba, objString[key]);
                    }

                    // End start hash
                    this.writeString(ba, this.EMPTY_STRING);

                    for (i = 0; i < numLen; i++) {
                        this.writeData(ba, arrNumeric[i]);
                    }
                }
            }
        },

        /**
         * A single AMF 3 type handles ActionScript Objects and custom user classes. The term 'traits' is used to describe
         * the defining characteristics of a class. In addition to 'anonymous' objects and 'typed' objects, ActionScript 3.0
         * introduces two further traits to describe how objects are serialized, namely 'dynamic' and 'externalizable'. The
         * following table outlines the terms and their meanings:
         *
         * Anonymous - an instance of the actual ActionScript Object type or an instance of a Class without a registered alias
         * 				(that will be treated like an Object on deserialization)
         *
         * Typed - an instance of a Class with a registered alias
         *
         * Dynamic - an instance of a Class definition with the dynamic trait declared; public variable members can be added
         * 			 and removed from instances dynamically at runtime
         *
         * Externalizable - an instance of a Class that implements flash.utils.IExternalizable and completely controls the
         * 					serialization of its members (no property names are included in the trait information).
         *
         * In addition to these characteristics, an object's traits information may also include a set of public variable and
         * public read-writeable property names defined on a Class (i.e. public members that are not Functions). The order of
         * the member names is important as the member values that follow the traits information will be in the exact same order.
         * These members are considered sealed members as they are explicitly defined by the type.
         *
         * If the type is dynamic, a further section may be included after the sealed members that lists dynamic members as
         * name / value pairs. One continues to read in dynamic members until a name that is the empty string is encountered.
         *
         * Objects can be sent as a reference to a previously occurring Object by using an index to the implicit object reference
         * table. Further more, trait information can also be sent as a reference to a previously occurring set of traits by using
         * an index to the implicit traits reference table.
         *
         * U29O-ref = U29 ; The first (low) bit is a flag (representing whether an instance follows) with value 0 to imply that
         * 					this is not an instance but a reference. The remaining 1 to 28 significant bits are used to encode
         * 					an object reference index (an integer).
         *
         * U29O-traits-ref = U29 ; The first (low) bit is a flag with value 1. The second bit is a flag (representing whether a
         * 					trait reference follows) with value 0 to imply that this objects traits are being sent by reference. The remaining 1
         * 					to 27 significant bits are used to encode a trait reference index (an integer).
         *
         * U29O-traits-ext = U29 ; The first (low) bit is a flag with value 1. The second bit is a flag with value 1. The third bit
         * 					is a flag with value 1. The remaining 1 to 26 significant bits are not significant (the traits member count would always be 0).
         *
         * U29O-traits = U29 ; The first (low) bit is a flag with value 1. The second bit is a flag with value 1. The third bit is a
         * 					flag with value 0. The fourth bit is a flag specifying whether the type is dynamic. A value of 0 implies not dynamic, a value
         * 					of 1 implies dynamic. Dynamic types may have a set of name value pairs for dynamic members after the sealed member section.
         * 					The remaining 1 to 25 significant bits are used to encode the number of sealed traits member names that follow after the class
         * 					name (an integer).
         *
         * class-name = UTF-8-vr ; use the empty string for anonymous classes
         *
         * dynamic-member = UTF-8-vr value-type ; Another dynamic member follows until the string-type is the empty string
         *
         * object-type = object-marker (U29O-ref | (U29O-traits-ext class-name *(U8)) | U29O-traits-ref | (U29O-traits class-name *(UTF-8-vr))) *(value-type) *(dynamic-member)))
         *
         * @param	ba
         * @param	value
         */
        readObject: function (ba, internal) {
            //trace('readObject');
            var ref = this.readUInt29(ba);
            if ((ref & 1) == 0) return this.getObjectReference(ref >> 1);

            // Read traits
            var traits;
            if ((ref & 3) == 1) {
                traits = this.getTraitReference(ref >> 2);
            } else {
                var isExternalizable = (ref & 4) == 4;
                var isDynamic = (ref & 8) == 8;
                var className = this.readString(ba).value;

                var classMemberCount = ref >> 4; /* uint29 */
                var classMembers = new Array(classMemberCount);
                for (var i = 0; i < classMemberCount; ++i) {
                    classMembers[i] = this.readString(ba).value;
                }
                if (className.length == 0) className = 'Object';
                traits = {
                    type: 'Object',
                    class: className,
                    members: classMembers,
                    count: classMemberCount,
                    externalizable: isExternalizable,
                    dynamic: isDynamic,
                };
                this.readTraitsCache.push(traits);
            }

            // Check for any registered class aliases
            var aliasedClass = this.CLASS_ALIAS_REGISTRY[traits.class];
            if (aliasedClass != null) traits.class = aliasedClass;
            //trace('Object Traits', traits);
            var obj = {};

            // Add to references as circular references may search for this
            // object
            this.readObjectCache.push(val);
            if (traits.externalizable) {
                // Read Externalizable
                try {
                    // Is this a Flex AMF message?
                    if (traits.class.indexOf('flex.') == 0) {
                        // Try to get a class
                        var classParts = traits.class.split('.');
                        var unqualifiedClassName = classParts[classParts.length - 1];
                        if (unqualifiedClassName && AMF3.Flex[unqualifiedClassName]) {
                            var flexParser = new AMF3.Flex[unqualifiedClassName]();
                            obj = flexParser.readExternal(ba, this);
                        } else {
                            obj = this.readData(ba);
                        }
                        // We will attempt to read it as an object or die trying...
                    } else {
                        obj['??? Warning: Externalized ???'] = this.readData(ba);
                        ALERT(
                            'Externalized object (' +
                                traits.class +
                                ') encountered. Any data parsed after object will most likely be incorrect.<br>Saving this file after opening will most generate a corrupted file.'
                        );
                    }
                } catch (e) {
                    ALERT("Unable to read externalizable data type '" + traits.class + "'  |  " + e);
                    obj['??? Warning: Externalized ???'] = {
                        value: "Unable to read externalizable data type '" + traits.class + "'",
                        __type: 'String',
                    };
                }
            } else {
                var l = traits.members.length;
                var key;

                for (var j = 0; j < l; ++j) {
                    val = this.readData(ba);
                    key = traits.members[j];
                    obj[key] = val;
                }

                if (traits.dynamic) {
                    key = this.readString(ba).value;
                    while (key != '') {
                        var value = this.readData(ba);
                        obj[key] = value;
                        key = this.readString(ba).value;
                    }
                }
            }

            var val = {};
            val.__traits = traits;
            val.value = obj;

            // For use in a different function
            if (internal) return obj;

            return val;
        },

        writeObject: function (ba, value, traits) {
            // Write the object tag
            ba.writeByte(this.OBJECT_TYPE);

            var v2;

            // Write Traits
            if (this.setTraitReference(ba, traits)) {
                // Write trait flag
                this.writeUInt29(ba, 3 | (traits.externalizable ? 4 : 0) | (traits.dynamic ? 8 : 0) | (traits.count << 4));

                // Write class name
                if (traits.class != 'Object') {
                    this.writeString(ba, traits.class);
                    // Anonymous class
                } else {
                    this.writeString(ba, '');
                }

                if (!traits.externalizable && traits.count > 0) {
                    for (v2 in traits.members) {
                        this.writeString(ba, traits.members[v2]);
                    }
                }
            }

            // Write Object
            if (traits.externalizable) {
                // Write Externalizable
                try {
                    if (traits.class.indexOf('flex.') == 0) {
                        // Try to get a class
                        var classParts = traits.class.split('.');
                        var unqualifiedClassName = classParts[classParts.length - 1];
                        if (unqualifiedClassName && AMF3.Flex[unqualifiedClassName]) {
                            var flexParser = new AMF3.Flex[unqualifiedClassName]();
                            flexParser.writeExternal(ba, this, value);
                        } else {
                            this.writeData(ba, value);
                        }
                    }
                } catch (e) {
                    throw Error("AMF3::writeObject - Error : Unable to write externalizable data type '" + traits.class + "' | " + e);
                }
            } else {
                if (this.setObjectReference(ba, value)) {
                    //} else if (traits.count > 0) {
                    if (traits.class != 'Object' || traits.dynamic == false) {
                        for (v2 in traits.members) {
                            this.writeData(ba, value[traits.members[v2]]);
                        }
                    } else {
                        for (v2 in value) {
                            this.writeString(ba, v2);
                            this.writeData(ba, value[v2]);
                        }
                    }
                }

                // Write closing object tag
                if (traits.dynamic) ba.writeByte(0x01);
            }
        },

        /**
         * ActionScript 3.0 introduces a new XML type that supports E4X syntax. For serialization purposes
         * the XML type needs to be flattened into a string representation. As with other strings in AMF,
         * the content is encoded using UTF-8.
         *
         * XML instances can be sent as a reference to a previously occurring XML instance by using an index
         * to the implicit object reference table.
         *
         * xml-type = xml-marker (U29O-ref | (U29X-value *(UTF8-char)))
         *
         * Note that this encoding imposes some theoretical limits on the use of XML. The byte-length of each
         * UTF-8 encoded XML instance is limited to 2^28 - 1 bytes (approx 256 MB).
         *
         * @param	ba
         * @param	value
         */
        readXML: function (ba) {
            var ref = this.readUInt29(ba);
            if ((ref & 1) == 0) return this.getObjectReference(ref >> 1);

            var xml = {
                value: ba.readUTFBytes(ref >> 1),
                __traits: { type: 'XML' },
            };
            this.readObjectCache.push(xml);
            return xml;
        },

        writeXML: function (ba, value) {
            ba.writeByte(this.XML_TYPE);

            if (this.setObjectReference(ba, value)) {
                var strXML = value; // value.toXMLString();
                strXML = strXML.replace(/^\s+|\s+$/g, ''); // Trim
                //strXML = strXML.replace(/\>(\n|\r|\r\n| |\t)*\</g, "><"); // Strip whitespaces, not done by native encoder
                this.writeString(ba, strXML, false);
            }
        },

        /**
         * ActionScript 3.0 introduces a new type to hold an Array of bytes, namely ByteArray. AMF 3 serializes
         * this type using a variable length encoding 29-bit integer for the byte-length prefix followed by the
         * raw bytes of the ByteArray.
         *
         * ByteArray instances can be sent as a reference to a previously occurring ByteArray instance by using
         * an index to the implicit object reference table.
         *
         * U29B-value = U29 ; The first (low) bit is a flag with value 1. The remaining 1 to 28 significant bits
         * are used to encode the byte-length of the ByteArray.
         *
         * bytearray-type = bytearray-marker (U29O-ref | U29B-value *(U8))
         *
         * Note that this encoding imposes some theoretical limits on the use of ByteArray. The maximum byte-length
         * of each ByteArray instance is limited to 2^28 - 1 bytes (approx 256 MB).
         *
         * @param	ba
         * @param	value
         */
        readByteArray: function (ba) {
            var ref = this.readUInt29(ba);
            if ((ref & 1) == 0) return this.getObjectReference(ref >> 1);

            var l = ref >> 1;
            var ba2 = new Array(l);

            for (var i = 0; i < l; ++i) {
                var b = ba.readUnsignedByte();
                //var b = ba.readUnsignedByte().toString(16).toUpperCase();
                //if (b.length < 2) b = '0' + b;
                ba2[i] = b;
                //ba2.push('0x' + b);
            }
            //ba.readBytes(ba2, 0, l);

            var val = { value: ba2, __traits: { type: 'ByteArray' } };
            this.readObjectCache.push(val);
            return val;
        },

        writeByteArray: function (ba, value) {
            ba.writeByte(this.BYTE_ARRAY_TYPE);

            if (this.setObjectReference(ba, value)) {
                this.writeUInt29(ba, (value.length << 1) | 1);
                ba.writeBytes(value);
            }
        },

        /**
         * A Vector is a dense array of values of the same type.
         * The maximum length of each serialized Vector is limited to 2^28 - 1
         * items (some 268,435,455 values).
         * Can be sent by reference
         */
        readVectorInt: function (ba) {
            var ref = this.readUInt29(ba);
            if ((ref & 1) == 0) return this.getObjectReference(ref >> 1);

            var l = ref >> 1;
            var vect = new Array(l);

            var isFixed = Boolean(ba.readBoolean());
            for (var i = 0; i < l; i++) {
                vect[i] = {
                    value: ba.readInt(),
                    __traits: { type: 'Integer' },
                };
            }

            var traits = { fixed: isFixed, type: 'Vector.<int>', class: 'int' };
            var val = { value: vect, __traits: traits };
            this.readObjectCache.push(val);
            return val;
        },

        writeVectorInt: function (ba, value, traits) {
            ba.writeByte(this.VECTOR_INT_TYPE);
            if (this.setObjectReference(ba, value)) {
                this.writeUInt29(ba, (value.length << 1) | 1); // Ref | Len
                ba.writeBoolean(traits.fixed ? 1 : 0); // Fixed Length?
                for (var i = 0, l = value.length; i < l; i++) {
                    ba.writeInt(value[i].value);
                }
            }
        },

        /**
         * A Vector is a dense array of values of the same type.
         * The maximum length of each serialized Vector is limited to 2^28 - 1
         * items (some 268,435,455 values).
         * Can be sent by reference
         */
        readVectorUInt: function (ba) {
            var ref = this.readUInt29(ba);
            if ((ref & 1) == 0) return this.getObjectReference(ref >> 1);

            var l = ref >> 1;
            var vect = new Array(l);

            var isFixed = Boolean(ba.readBoolean());
            for (var i = 0; i < l; i++) {
                vect[i] = {
                    value: ba.readUnsignedInt(),
                    __traits: { type: 'Integer' },
                };
            }

            var traits = {
                fixed: isFixed,
                type: 'Vector.<uint>',
                class: 'uint',
            };
            var val = { value: vect, __traits: traits };
            this.readObjectCache.push(val);
            return val;
        },

        writeVectorUInt: function (ba, value, traits) {
            ba.writeByte(this.VECTOR_UINT_TYPE);

            if (this.setObjectReference(ba, value)) {
                this.writeUInt29(ba, (value.length << 1) | 1);
                ba.writeBoolean(traits.fixed ? 1 : 0); // Fixed Length?
                for (var i = 0, l = value.length; i < l; i++) {
                    ba.writeUnsignedInt(value[i].value);
                }
            }
        },

        /**
         * A Vector is a dense array of values of the same type.
         * The maximum length of each serialized Vector is limited to 2^28 - 1
         * items (some 268,435,455 values).
         * Can be sent by reference
         */
        readVectorDouble: function (ba) {
            var ref = this.readUInt29(ba);
            if ((ref & 1) == 0) return this.getObjectReference(ref >> 1);

            var l = ref >> 1;
            var vect = new Array(l);

            var isFixed = Boolean(ba.readBoolean());
            for (var i = 0; i < l; i++) {
                vect[i] = {
                    value: ba.readDouble(),
                    __traits: { type: 'Number' },
                };
            }

            var traits = {
                fixed: isFixed,
                type: 'Vector.<Number>',
                class: 'Number',
            };
            var val = { value: vect, __traits: traits };
            this.readObjectCache.push(val);
            return val;
        },

        writeVectorDouble: function (ba, value, traits) {
            ba.writeByte(this.VECTOR_DOUBLE_TYPE);

            if (this.setObjectReference(ba, value)) {
                this.writeUInt29(ba, (value.length << 1) | 1);
                ba.writeBoolean(traits.fixed ? 1 : 0); // Fixed Length?
                for (var i = 0, l = value.length; i < l; i++) {
                    ba.writeDouble(value[i].value);
                }
            }
        },

        /**
         * A Vector is a dense array of values of the same type.
         * The maximum length of each serialized Vector is limited to 2^28 - 1
         * items (some 268,435,455 values).
         * Only Vectors of serializable types can be serialized.
         * Can be sent by reference
         */
        readVectorObject: function (ba) {
            var ref = this.readUInt29(ba);
            if ((ref & 1) == 0) return this.getObjectReference(ref >> 1);

            var l = ref >> 1;
            var vect = new Array(l);

            var isFixed = Boolean(ba.readBoolean());

            // Vector of Object is like an pure object, it's got a traits defining it's type
            var className = this.readString(ba).value;
            if (className.length == 0) className = 'Object';
            var traits = {
                type: 'Vector.<' + className + '>',
                fixed: isFixed,
                class: className,
            };

            // Check for any registered class aliases
            var aliasedClass = this.CLASS_ALIAS_REGISTRY[traits.class];
            if (aliasedClass != null) traits.class = aliasedClass;

            // Store traits somewhere
            for (var j = 0; j < l; j++) {
                vect[j] = this.readData(ba);
            }

            var val = { value: vect, __traits: traits };
            this.readObjectCache.push(val);
            return val;
        },

        writeVectorObject: function (ba, value, traits) {
            ba.writeByte(this.VECTOR_OBJECT_TYPE);
            if (this.setObjectReference(ba, value)) {
                this.writeUInt29(ba, (value.length << 1) | 1);
                ba.writeBoolean(traits.fixed ? 1 : 0); // Fixed Length?

                //var type = traits.class.substring(8, traits.class.length - 1);
                var type = traits.class;
                if (type == 'Object') {
                    this.writeString(ba, '');
                } else {
                    this.writeString(ba, type);
                }
                for (var i = 0, l = value.length; i < l; i++) {
                    this.writeData(ba, value[i]);
                }
            }
        },

        /**
         * A Dictionary is a map of key-value pairs, where both the key and value
         * can be objects (i.e. keys do not have to be strings).
         * Keys are matched based on identity using a strict-equality (===) comparison.
         * Only Dictionaries of serializable types can be serialized.
         * Note: while the Flash Player may attempt to keep integer keys as integers
         * at runtime, on serialization these integer keys are serialized as Strings
         * using their base-10 representation.
         * Also note that this encoding imposes some theoretical limits on the use of
         * Dictionary. The maximum number of entries in a serialized Dictionary is
         * limited to 2^28 - 1 items (some 268,435,455 key-value pairs).
         * Can be sent by reference
         */
        readDictionary: function (ba) {
            var ref = this.readUInt29(ba);
            if ((ref & 1) == 0) return this.getObjectReference(ref >> 1);

            var l = ref >> 1;
            var dict = new Array(l);

            var hasWeakKeys = Boolean(ba.readBoolean());
            for (var i = 0; i < l; i++) {
                dict[i] = {
                    key: this.readData(ba),
                    value: this.readData(ba),
                    __traits: { type: 'DictionaryItem' },
                };
            }

            var val = {
                value: dict,
                __traits: { weakKeys: hasWeakKeys, type: 'Dictionary' },
            };
            this.readObjectCache.push(dict);
            return val;
        },

        writeDictionary: function (ba, value, traits) {
            ba.writeByte(this.DICTIONARY_TYPE);
            if (this.setObjectReference(ba, value)) {
                var l = value.length;
                this.writeUInt29(ba, (l << 1) | 1);
                ba.writeBoolean(traits.weakKeys);

                for (var i = 0; i < l; i++) {
                    this.writeData(ba, value[i].value.Key);
                    this.writeData(ba, value[i].value.Value);
                }
            }
        },

        //////////////////////
        // String Reference //
        //////////////////////
        getStringReference: function (ref) {
            //trace('getStringReference', ref);
            if (ref >= this.readStringCache.length) {
                WARNING("Warning: Undefined string reference '" + ref + "'");
                return {
                    value: '??? Error: Str Ref #' + ref + ' ???',
                    __traits: { type: 'String', missingRef: ref },
                };
            }
            return this.readStringCache[ref];
        },

        setStringReference: function (ba, s) {
            var refNum;
            if (this.writeStringCache != null && (refNum = this.writeStringCache.indexOf(s)) != -1) {
                this.writeUInt29(ba, refNum << 1);
                return false;
            } else {
                if (this.writeStringCache == null) this.writeStringCache = new Array();
                // 64 limit copied from BlazeDS, not Adobe spec
                //if (this.writeStringCache.length < 64) this.writeStringCache.push(s);
                this.writeStringCache.push(s);
                return true;
            }
        },

        /////////////////////
        // Trait Reference //
        /////////////////////
        getTraitReference: function (ref) {
            //trace('getTraitReference', ref);
            if (ref >= this.readTraitsCache.length) {
                WARNING("Warning: Undefined trait reference '" + ref + "'");
                return {
                    value: '??? Error: Trait Ref #' + ref + ' ???',
                    __traits: { type: 'String', missingRef: ref },
                };
            }
            return this.readTraitsCache[ref];
        },

        setTraitReference: function (ba, traits) {
            var refNum,
                json = JSON.stringify(traits); // Convert to JSON to make comparison easy
            if (this.writeTraitsCache != null && (refNum = this.writeTraitsCache.indexOf(json)) != -1) {
                this.writeUInt29(ba, (refNum << 2) | 1);
                return false;
            } else {
                if (this.writeTraitsCache == null) this.writeTraitsCache = [];
                // 10 limit copied from BlazeDS, not Adobe spec
                //if (this.writeTraitsCache.length < 10) this.writeTraitsCache.push(json);
                this.writeTraitsCache.push(json);
                return true;
            }
        },

        //////////////////////
        // Object Reference //
        //////////////////////
        getObjectReference: function (ref) {
            //trace('getObjectReference', ref);
            if (ref >= this.readObjectCache.length) {
                WARNING("Warning: Undefined object reference '" + ref + "'");
                return {
                    value: '??? Error: Obj Ref #' + ref + ' ???',
                    __traits: { type: 'String', missingRef: ref },
                };
            }
            return this.readObjectCache[ref];
        },

        setObjectReference: function (ba, o) {
            var refNum;

            // Clean object and return it to a normal AS3 object
            // TODO: Create a hash of the object and store that instead
            // https://github.com/apache/flex-blazeds/blob/master/core/src/main/java/flex/messaging/io/amf/Amf3Output.java
            /*
            if (objectTable == null)
                objectTable = new IdentityHashMap<Object, Integer>(64);
            objectTable.put(o, Integer.valueOf(objectTable.size()));
            */
            var oClean = this.cleanObject(o, {});

            //var json = JSON.stringify(oClean);
            //if (this.writeObjectCache != null && (refNum = this.writeObjectCache.indexOf(json)) != -1) {
            if (this.writeObjectCache != null && (refNum = this.cacheIndexOf(this.writeObjectCache, oClean)) != -1) {
                this.writeUInt29(ba, refNum << 1);
                return false;
            } else {
                if (this.writeObjectCache == null) this.writeObjectCache = [];
                // 64 limit copied from BlazeDS, not Adobe spec
                //if (this.writeObjectCache.length < 64) this.writeObjectCache.push(json);
                this.writeObjectCache.push(oClean);
                //this.writeObjectCache.push(json);
                return true;
            }
        },

        cacheIndexOf: function (arr, o) {
            for (var i = 0, l = arr.length; i < l; i++) {
                //trace(arr[i], o, arr[i] === o);
                if (arr[i] === o) return i;
            }
            return -1;
        },

        cleanObject: function (dirtyObj, cleanObj) {
            for (var key in dirtyObj) {
                var val = dirtyObj[key].value;
                if (typeof val == 'string' || typeof val == 'number' || typeof val == 'boolean') {
                    cleanObj[key] = val;
                } else if (Array.isArray(val)) {
                    cleanObj[key] = this.cleanObject(dirtyObj[key].value, []);
                } else {
                    cleanObj[key] = this.cleanObject(dirtyObj[key].value, {});
                }
            }
            return cleanObj;
        },
    };

    //////////////////////
    // Remoting Classes //
    //////////////////////

    AMF3.Flex = {};

    var UUIDUtils = {
        UPPER_DIGITS: ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F'],

        fromByteArray: function (ba) {
            if (ba != null && ba.length == 16) {
                var result = '';
                for (var i = 0; i < 16; i++) {
                    if (i == 4 || i == 6 || i == 8 || i == 10) result += '-';

                    result += this.UPPER_DIGITS[(+ba[i] & 0xf0) >>> 4];
                    result += this.UPPER_DIGITS[+ba[i] & 0x0f];
                }
                return result;
            }

            return null;
        },
    };

    // Abstract Message //
    AMF3.Flex.AbstractMessage = function () {
        this.clientId = null; // object
        this.destination = null; // string
        this.messageId = null; // string
        this.timestamp = null; // number
        this.timeToLive = null; // number

        this.headers = null; // Map
        this.body = null; // object

        //this.clientIdBytes; // byte array
        //this.messageIdBytes; // byte array
    };

    AMF3.Flex.AbstractMessage.prototype = {
        // AbstractMessage Serialization Constants
        HAS_NEXT_FLAG: 128,
        BODY_FLAG: 1,
        CLIENT_ID_FLAG: 2,
        DESTINATION_FLAG: 4,
        HEADERS_FLAG: 8,
        MESSAGE_ID_FLAG: 16,
        TIMESTAMP_FLAG: 32,
        TIME_TO_LIVE_FLAG: 64,
        CLIENT_ID_BYTES_FLAG: 1,
        MESSAGE_ID_BYTES_FLAG: 2,

        //AsyncMessage Serialization Constants
        CORRELATION_ID_FLAG: 1,
        CORRELATION_ID_BYTES_FLAG: 2,

        // CommandMessage Serialization Constants
        OPERATION_FLAG: 1,

        readExternal: function (ba, parser) {
            var flagsArray = this.readFlags(ba);
            for (var i = 0; i < flagsArray.length; i++) {
                var flags = flagsArray[i],
                    reservedPosition = 0;

                if (i == 0) {
                    if ((flags & this.BODY_FLAG) != 0) this.readExternalBody(ba, parser);
                    if ((flags & this.CLIENT_ID_FLAG) != 0) this.clientId = parser.readData(ba);
                    if ((flags & this.DESTINATION_FLAG) != 0) this.destination = parser.readData(ba);
                    if ((flags & this.HEADERS_FLAG) != 0) this.headers = parser.readData(ba);
                    if ((flags & this.MESSAGE_ID_FLAG) != 0) this.messageId = parser.readData(ba);
                    if ((flags & this.TIMESTAMP_FLAG) != 0) this.timestamp = parser.readData(ba);
                    if ((flags & this.TIME_TO_LIVE_FLAG) != 0) this.timeToLive = parser.readData(ba);
                    reservedPosition = 7;
                } else if (i == 1) {
                    if ((flags & this.CLIENT_ID_BYTES_FLAG) != 0) {
                        var clientIdBytes = parser.readData(ba);
                        this.clientId = UUIDUtils.fromByteArray(clientIdBytes);
                    }

                    if ((flags & this.MESSAGE_ID_BYTES_FLAG) != 0) {
                        var messageIdBytes = parser.readData(ba);
                        this.messageId = UUIDUtils.fromByteArray(messageIdBytes);
                    }

                    reservedPosition = 2;
                }

                // For forwards compatibility, read in any other flagged objects to
                // preserve the integrity of the input stream...
                if (flags >> reservedPosition != 0) {
                    for (var j = reservedPosition; j < 6; j++) {
                        if (((flags >> j) & 1) != 0) parser.readData(ba);
                    }
                }
            }

            return this;
        },

        readExternalBody: function (ba, parser) {
            this.body = parser.readData(ba);
        },

        readFlags: function (ba) {
            var hasNextFlag = true,
                flagsArray = [],
                i = 0;

            while (hasNextFlag) {
                var flags = ba.readUnsignedByte();
                /*if (i == flagsArray.length) {
				short[] tempArray = new short[i*2];
				System.arraycopy(flagsArray, 0, tempArray, 0, flagsArray.length);
				flagsArray = tempArray;
			}*/

                flagsArray[i] = flags;
                hasNextFlag = (flags & this.HAS_NEXT_FLAG) != 0 ? true : false;
                i++;
            }

            return flagsArray;
        },
    };

    // Async Message //
    AMF3.Flex.AsyncMessage = function () {
        this.correlationId = null; // string
        //var correlationIdBytes; // byte array
    };
    AMF3.Flex.AsyncMessage.prototype = new AMF3.Flex.AbstractMessage();
    AMF3.Flex.AsyncMessage.constructor = AMF3.Flex.AsyncMessage;

    AMF3.Flex.AsyncMessage.prototype.readExternal = function (ba, parser) {
        AMF3.Flex.AbstractMessage.prototype.readExternal.call(this, ba, parser);

        var flagsArray = this.readFlags(ba);
        for (var i = 0; i < flagsArray.length; i++) {
            var flags = flagsArray[i],
                reservedPosition = 0;

            if (i == 0) {
                if ((flags & this.CORRELATION_ID_FLAG) != 0) this.correlationId = parser.readData(ba);

                if ((flags & this.CORRELATION_ID_BYTES_FLAG) != 0) {
                    var correlationIdBytes = parser.readData(ba);
                    this.correlationId = UUIDUtils.fromByteArray(correlationIdBytes);
                }

                reservedPosition = 2;
            }

            // For forwards compatibility, read in any other flagged objects
            // to preserve the integrity of the input stream...
            if (flags >> reservedPosition != 0) {
                for (var j = reservedPosition; j < 6; ++j) {
                    if (((flags >> j) & 1) != 0) parser.readData(ba);
                }
            }
        }

        return this;
    };

    // Async Message Ext //
    AMF3.Flex.AsyncMessageExt = function () {};
    AMF3.Flex.AsyncMessageExt.prototype = new AMF3.Flex.AsyncMessage();
    AMF3.Flex.AsyncMessageExt.constructor = AMF3.Flex.AsyncMessageExt;

    // Acknowledge Message //
    AMF3.Flex.AcknowledgeMessage = function () {};
    AMF3.Flex.AcknowledgeMessage.prototype = new AMF3.Flex.AsyncMessage();
    AMF3.Flex.AcknowledgeMessage.constructor = AMF3.Flex.AcknowledgeMessage;

    AMF3.Flex.AcknowledgeMessage.prototype.readExternal = function (ba, parser) {
        AMF3.Flex.AsyncMessage.prototype.readExternal.call(this, ba, parser);

        var flagsArray = this.readFlags(ba);
        for (var i = 0; i < flagsArray.length; ++i) {
            var flags = flagsArray[i],
                reservedPosition = 0;

            // For forwards compatibility, read in any other flagged objects
            // to preserve the integrity of the input stream...
            if (flags >> reservedPosition != 0) {
                for (var j = reservedPosition; j < 6; ++j) {
                    if (((flags >> j) & 1) != 0) parser.readData(ba);
                }
            }
        }

        return this;
    };

    // Acknowledge Message Ext //
    AMF3.Flex.AcknowledgeMessageExt = function () {};
    AMF3.Flex.AcknowledgeMessageExt.prototype = new AMF3.Flex.AcknowledgeMessage();
    AMF3.Flex.AcknowledgeMessageExt.constructor = AMF3.Flex.AcknowledgeMessageExt;

    // Command Message //
    AMF3.Flex.CommandMessage = function () {
        this.operation = 1000;
        this.operationName = 'unknown';
    };
    AMF3.Flex.CommandMessage.prototype = new AMF3.Flex.AsyncMessage();
    AMF3.Flex.CommandMessage.constructor = AMF3.Flex.CommandMessage;

    AMF3.Flex.CommandMessage.prototype.readExternal = function (ba, parser) {
        AMF3.Flex.AsyncMessage.prototype.readExternal.call(this, ba, parser);

        var flagsArray = this.readFlags(ba);
        for (var i = 0; i < flagsArray.length; ++i) {
            var flags = flagsArray[i],
                reservedPosition = 0,
                operationNames = [
                    'subscribe',
                    'unsubscribe',
                    'poll',
                    'unused3',
                    'client_sync',
                    'client_ping',
                    'unused6',
                    'cluster_request',
                    'login',
                    'logout',
                    'subscription_invalidate',
                    'multi_subscribe',
                    'disconnect',
                    'trigger_connect',
                ];

            if (i == 0) {
                if ((flags & this.OPERATION_FLAG) != 0) {
                    this.operation = parser.readData(ba);
                    if (this.operation < 0 || this.operation >= operationNames.length) {
                        this.operationName = 'invalid.' + this.operation + '';
                    } else {
                        this.operationName = operationNames[this.operation];
                    }
                }
                reservedPosition = 1;
            }

            // For forwards compatibility, read in any other flagged objects
            // to preserve the integrity of the input stream...
            if (flags >> reservedPosition != 0) {
                for (var j = reservedPosition; j < 6; ++j) {
                    if (((flags >> j) & 1) != 0) parser.readData(ba);
                }
            }
        }

        return this;
    };

    // Command Message Ext //
    AMF3.Flex.CommandMessageExt = function () {};
    AMF3.Flex.CommandMessageExt.prototype = new AMF3.Flex.CommandMessage();
    AMF3.Flex.CommandMessageExt.constructor = AMF3.Flex.CommandMessageExt;

    // Error Message //
    AMF3.Flex.ErrorMessage = function () {};
    AMF3.Flex.ErrorMessage.prototype = new AMF3.Flex.AcknowledgeMessage();
    AMF3.Flex.ErrorMessage.constructor = AMF3.Flex.ErrorMessage;

    // Array Collection //
    AMF3.Flex.ArrayCollection = function () {
        this.source = null;
    };

    AMF3.Flex.ArrayCollection.prototype.readExternal = function (ba, parser) {
        this.source = parser.readData(ba);
        return this;
    };

    // Array List //
    AMF3.Flex.ArrayList = function () {};
    AMF3.Flex.ArrayList.prototype = new AMF3.Flex.ArrayCollection();
    AMF3.Flex.ArrayList.constructor = AMF3.Flex.ArrayList;

    // Object Proxy //
    AMF3.Flex.ObjectProxy = function () {};
    AMF3.Flex.ObjectProxy.prototype.readExternal = function (ba, parser) {
        var obj = parser.readData(ba, true);
        for (var i in obj) {
            this[i] = obj[i];
        }
        return this;
    };

    // Managed Object Proxy //
    AMF3.Flex.ManagedObjectProxy = function () {};
    AMF3.Flex.ManagedObjectProxy.prototype = new AMF3.Flex.ObjectProxy();
    AMF3.Flex.ManagedObjectProxy.constructor = AMF3.Flex.ManagedObjectProxy;

    // Serialization Proxy //
    AMF3.Flex.SerializationProxy = function () {
        this.defaultInstance = null;
    };

    AMF3.Flex.SerializationProxy.prototype.readExternal = function (ba, parser) {
        /*var saveObjectTable = null;
	var saveTraitsTable = null;
	var saveStringTable = null;
	var in3 = null;

	if (ba instanceof Amf3Input) in3 = ba;*/

        try {
            /*if (in3 != null) {
			saveObjectTable = in3.saveObjectTable();
			saveTraitsTable = in3.saveTraitsTable();
			saveStringTable = in3.saveStringTable();
		}*/

            this.defaultInstance = parser.readData(ba);
        } finally {
            /*if (in3 != null) {
			in3.restoreObjectTable(saveObjectTable);
			in3.restoreTraitsTable(saveTraitsTable);
			in3.restoreStringTable(saveStringTable);
		}*/
        }

        return this;
    };
})();
