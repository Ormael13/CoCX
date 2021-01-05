package classes.internals {
/**
 * Usage:
 *
 * public static var Types:/!*EnumValue*!/Array = [];
 * public static var FOO:int = EnumValue.add(Types, 0, 'FOO', {param:"something"});
 * public static var BAR:int = EnumValue.add(Types, 1, 'BAR', {param:"anything"});
 *
 * or
 *
 * public static var Types:/!*EnumValue*!/Array = [];
 * public static var FOO:int = 0;
 * EnumValue.add(Types, FOO, 'FOO', {param:"something"});
 * public static var BAR:int = 1;
 * EnumValue.add(Types, BAR, 'BAR', {param:"anything"});
 *
 * This will populate Types array with EnumValue's like that:
 * Types = [
 *           { value:0, id:'FOO', param:"something" }, // Types[0]
 *           { value:1, id:'BAR', param:"anything" }   // Types[1]
 * ];
 *
 * Scarse arrays are possible, but beware of the undefined in the array when iterating!
 */
public dynamic class EnumValue {
	public var list:/*EnumValue*/Array;
	public var value:int;
	public var id:String;
	
	public function EnumValue(list:/*EnumValue*/Array, value:int, id:String, properties:* = null) {
		this.list = list;
		this.value = value;
		this.id = id;
		if (properties) for (var key:String in properties) this[key] = properties[key];
		if (list[value]) throw "Duplicate enum value "+value+" of ids "+id+" and "+list[value].id;
		list[value] = this;
	}
	public static function add(list:/*EnumValue*/Array, value:int, id:String, properties:* = null):int {
		new EnumValue(list,value,id,properties);
		return value;
	}
	public static function findByProperty(list:/*EnumValue*/Array, propertyName:String, propertyValue:*):EnumValue {
		for each(var p:EnumValue in list) {
			if (p[propertyName] == propertyValue) return p;
		}
		return null;
	}
	/**
	 * Parses input string as index or enum constant name
	 */
	public static function parse(list:/*EnumValue*/Array, input:String):EnumValue {
		if (!isNaN(parseInt(input))) {
			return list[parseInt(input)];
		} else {
			return findByProperty(list, 'id', input);
		}
	}
}
}
