package classes.internals.race {
import classes.BodyData;
import classes.CockTypesEnum;
import classes.PerkType;
import classes.internals.Utils;

public class RaceUtils {
	function RaceUtils() {
	}
	
	/*****************************************************
	 * Functions creating functions for `RacialRequirement`s
	 *****************************************************/
	
	// Most racial requirements are made through function composition
	// Example.
	// "fox ears" is composed of 2 parts:
	// - argument function that returns ear type
	// - operator function that checks that argument is "fox"
	//
	// argFn = (body) => body.earType
	// opFn = (value) => value==Ears.FOX
	// checkFn = (body) => opFn(argFn(body)) = body.earType==Ears.FOX
	
	/**
	 * Parses operator definition.
	 * Examples:
	 * ```
	 * parseOperatorObject("blue") => {
	 * 		name: "blue",
	 * 		operatorFn(value) {
	 * 			return value == "blue"
	 * 		}
	 * 	}
	 * parseOperatorObject(ANY("red", "blue")) => {
	 * 		name: "red or blue",
	 * 		operatorFn(value) {
	 * 			return ["red", "blue"].indexOf(value) >= 0
	 * 		}
	 * 	}
	 * parseOperatorObject(6, faceTypeToNameFn) => {
	 * 		name: "cat",
	 * 		operatorFn(value) {
	 * 			return value == 6
	 * 		}
	 * 	}
	 * 	```
	 * @param op Operator definition. Simple value means "equal", otherwise should be operator definition object
	 * @param nameProvider A function `(value:*,...rest:Array)=>String` to generate `name` field. Default is simple toString.
	 * @param errorContext Prepended to error message, to help debugging
	 * @return `{name:String, operatorFn:(value:*)=>Boolean}`
	 */
	public static function parseOperatorObject(
			op:*,
			nameProvider:Function=null,
			errorContext:String=""
	):Object {
		if (nameProvider == null) nameProvider = function(input:*):String { return ""+input };
		errorContext += "["+Utils.stringify(op)+"] ";
		
		var operatorFn:Function;
		var name:String;
		
		if (typeof op === "object" && op && "operator" in op) {
			var operator:* = op["operator"];
			switch (operator) {
				case "any":
				case "none":
					var none:Boolean = operator == "none";
					var anyOptions:Array = op["options"] as Array;
					if (!anyOptions) throw new Error(errorContext+"Invalid operator");
					operatorFn = none ? operatorNoneFn(anyOptions) : operatorAnyFn(anyOptions);
					name = (none?"neither ":"") +
							Utils.mergeSentences(
									anyOptions.map(Utils.varargify(nameProvider)),
									(none?" nor ":" or "),
									", ", false
							);
					break;
				case "lt":
				case "lte":
				case "gt":
				case "gte":
				case "ne":
					var compValue:Number = op["value"] as Number;
					if (!isFinite(compValue)) throw new Error(errorContext+"Invalid operator");
					operatorFn = operatorCompareFn(operator, compValue);
					name = {
						"lt": "less than ",
						"lte": "at most ",
						"gt": "greater than ",
						"gte": "at least ",
						"ne": "not "
					}[operator] + nameProvider(compValue);
					break;
				default:
					throw new Error(errorContext+"Unknown operator");
			}
		} else {
			operatorFn = operatorEqFn(op);
			name = nameProvider(op);
		}
		return {
			name: name,
			operatorFn: operatorFn
		}
	}
	
	/**
	 * @param argumentFn `(body) => input`
	 * @param operatorFn `(input) => boolean`
	 * @return `(body) => operatorFn(argumentFn(body))`
	 */
	public static function composeOpArg(argumentFn:Function, operatorFn:Function):Function {
		return function (body:BodyData):Boolean {
			return operatorFn(argumentFn(body));
		}
	}
	
	/**
	 * @return `(input) => options.indexOf(input) >= 0`
	 */
	public static function operatorAnyFn(options:Array):Function {
		return function(input:*):Boolean {
			return options.indexOf(input) >= 0;
		}
	}
	/**
	 * @return `(input) => options.indexOf(input) < 0`
	 */
	public static function operatorNoneFn(options:Array):Function {
		return function(input:*):Boolean {
			return options.indexOf(input) < 0;
		}
	}
	/**
	 * @return `(input) => input == value
	 */
	public static function operatorEqFn(value:*):Function {
		return function(input:*):Boolean {
			return input == value;
		}
	}
	/**
	 * @return `(input) => input < / <= / > / >= / == / != value
	 */
	public static function operatorCompareFn(operator:String, value:*):Function {
		switch (operator) {
			case "lt":
				return function (input:*):Boolean {
					return input < value;
				}
			case "lte":
				return function (input:*):Boolean {
					return input <= value;
				}
			case "gt":
				return function (input:*):Boolean {
					return input > value;
				}
			case "gte":
				return function (input:*):Boolean {
					return input >= value;
				}
			case "ne":
				return function (input:*):Boolean {
					return input != value;
				}
			case "eq":
				return function (input:*):Boolean {
					return input == value;
				}
		}
		throw new Error("Invalid operator "+operator);
	}
	
	/**
	 * @return `(body) => body.data[slot]`
	 */
	public static function argumentSlotFn(slot:int):Function {
		return function(body:BodyData):* {
			return body.data[slot];
		}
	}
	
	/**
	 * @return `(body) => body.player.hasPerk(ptype)`
	 */
	public static function hasPerkFn(ptype:PerkType):Function {
		return function (body:BodyData):Boolean {
			return body.player.hasPerk(ptype);
		}
	}
	/**
	 * @return `(body) => ptypes.every(ptype=>body.player.hasPerk(ptype))`
	 */
	public static function hasAllPerksFn(ptypes:/*PerkType*/Array):Function {
		return function (body:BodyData):Boolean {
			for each(var i:PerkType in ptypes) {
				if (!body.player.hasPerk(i)) return false;
			}
			return true;
		}
	}
	/**
	 * @return `(body) => ptypes.some(ptype=>body.player.hasPerk(ptype))`
	 * */
	public static function hasAnyPerkFn(ptypes:/*PerkType*/Array):Function {
		return function (body:BodyData):Boolean {
			for each(var i:PerkType in ptypes) {
				if (body.player.hasPerk(i)) return true;
			}
			return false;
		}
	}
	/**
	 * @return `(body) => body.player.cockType(ctype) > 0`
	 */
	public static function hasCockOfTypeFn(ctype:CockTypesEnum):Function {
		return function (body:BodyData):Boolean {
			return body.player.countCocksWithType(ctype) > 0;
		}
	}
	/**
	 * @return `(body) => body.player.hasVagina() == test`
	 */
	public static function hasVaginaFn(test:Boolean):Function {
		if (test) {
			return function (body:BodyData):Boolean {
				return body.player.hasVagina();
			}
		} else {
			return function (body:BodyData):Boolean {
				return !body.player.hasVagina();
			}
		}
	}
	
	
	
}
}
