/*
 * Created by aimozg on 09.06.2022.
 */
function amfUnwrap(amf, path = []) {
	if (!amf || !amf.__traits) throw new Error("Malformed AMF object " + path.join(".") + " = " + JSON.stringify(amf));
	function unwrapObject(amf, path) {
		let object = {};
		for (let [k, v] of Object.entries(amf.value)) {
			path.push(k);
			object[k] = amfUnwrap(v, path);
			path.pop();
		}
		return object;
	}
	switch (amf.__traits.type) {
		case "Undefined":
			return undefined;
		case "Null":
			return null;
		case "True":
			return true;
		case "False":
			return false;
		case "Integer":
		case "Number":
		case "String":
		case "Date":
			return amf.value;
		case "XMLDocument":
			// return amf.value;
			throw new Error("Cannot load XMLDocument " + path.join("."));
		case "Array": {
			if (!amf.__traits.strict && amf.value.length === 0) {
				return unwrapObject(amf, path);
			}
			let array = [];
			for (let [k, v] of Object.entries(amf.value)) {
				path.push(k);
				array[k] = amfUnwrap(v, path);
				path.pop();
			}
			return array;
		}
		case "Object": return unwrapObject(amf, path);
		default:
			throw new Error("Cannot load unknown type " + amf.__traits.type + " " + path.join("."));
	}
}

function amfWrapValues(object, path) {
	let result = Array.isArray(object) ? [] : {};
	for (let [k, v] of Object.entries(object)) {
		path.push(k);
		result[k] = amfWrap(v);
		path.pop();
	}
	return result;
}

function amfWrap(object, path = []) {
	if (object === undefined) return {__traits: {type: "Undefined"}, value: null};
	if (object === null) return {__traits: {type: 'Null'}, value: null};
	if (object === true) return {__traits: {type: 'True'}, value: 1};
	if (object === false) return {__traits: {type: 'False'}, value: 0};
	switch (typeof object) {
		case "number":
			if ((-1 << 28) <= object && object < (1 << 28) && Math.floor(object) === object) {
				return {__traits: {type: 'Integer'}, value: object}
			} else {
				return {__traits: {type: 'Number'}, value: object}
			}
		case "string":
			return {__traits: {type: 'String'}, value: object}
		case "object":
			if (object instanceof Date) {
				return {__traits: {type: 'Date'}, value: object}
			}
			if (Array.isArray(object)) {
				return {
					__traits: {
						type: 'Array',
						strict: Object.keys(object).every(k => k.match(/^\d+$/))
					},
					value: amfWrapValues(object, path)
				}
			}
			if (Object.getPrototypeOf(object) === Object.getPrototypeOf({})) {
				return {
					__traits: {
						type: "Object",
						"class": "Object",
						members: [],
						count: 0,
						externalizable: false,
						dynamic: true
					},
					value: amfWrapValues(object, path)
				}
			}
			throw new Error("Cannot save object " + path.join("."));
		default:
			throw new Error("Cannot save " + (typeof object) + " " + path.join("."));
	}
}

/**
 * @param {ByteArray} ba
 */
function amfLoadSOL(ba) {
	// based on Minerva SOLReaderWorker
	let result = [];

	/**
	 * @param {ByteArray} ba
	 */
	function readHeader(ba) {
		let pos = ba.position;
		let tagTypeAndLength = ba.readUI16();
		let contentLength = tagTypeAndLength & 0x3f;
		if (contentLength == 0x3f) contentLength = ba.readSI32();
		let type = tagTypeAndLength >> 6;
		let headerLength = ba.position - pos;
		let tagLength = headerLength + contentLength;
		return {contentLength, headerLength, tagLength, type};
	}

	/**
	 * @param {ByteArray} ba
	 */
	function readLSO(ba, header) {
		let sig = ba.readUTFBytes(4);
		if (app.debug) console.log("sig=", sig);
		if (sig !== "TCSO") throw "Missing TCSO signature";
		ba.position += 6;
		header.filename = ba.readUTFBytes(ba.readUnsignedShort());
		if (app.debug) console.log("filename=", header.filename);
		let amfVersion = ba.readUnsignedInt();
		if (amfVersion !== 3) throw "Unsupported SOL version " + amfVersion;
		header.body = {
			__traits: {
				type: "Object",
				"class": "Object",
				members: [],
				count: 0,
				externalizable: false,
				dynamic: true
			},
			value: {}
		};
		let amf3 = new AMF3();
		while (ba.getBytesAvailable() > 1 && ba.position < header.contentLength) {
			let name = amf3.readString(ba).value;
			header.body.value[name] = amf3.readData(ba);
			ba.readUnsignedByte();
		}
	}

	while (ba.getBytesAvailable() > 0) {
		let header = readHeader(ba);
		result.push(header);
		switch (header.type) {
			case 2: // Local Shared Object
				readLSO(ba, header);
				break;
			case 3:
				header.filePath = ba.readUTFBytes(ba.readUnsignedShort(), true);
				break;
			default:
				throw new Error("Invalid SOL Header type " + header.type);
		}
	}
	return result;
}
