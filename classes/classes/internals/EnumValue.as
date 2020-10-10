package classes.internals {
/**
 * Usage:
 *
 * public static var Types:/!*EnumValue*!/Array = [];
 * public static var FOO:int = EnumValue.add(Types, 0, 'FOO', {param:"something"});
 * public static var BAR:int = EnumValue.add(Types, 1, 'BAR', {param:"anything"});
 *
 * This, however, causes error "%s is not a compile-time constant" when you use it
 * as a function default value, for example.
 *
 * Solution A:
 *
 * public static var BAZ:int = 2;
 * EnumValue.add(Types, BAZ, 'BAZ', {param:"everything"});
 *
 * Solution B:
 *
 * //noinspection CommaExpressionJS
 * public static var BAZ:int = (EnumValue.add(Types, 2, 'BAZ', {param:"everything"}), 2);
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
