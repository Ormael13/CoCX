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
	// "fox ears" is composed of following parts:
	// - argument function that returns ear type
	// - operator function that checks that argument is "fox"
	// - name function that converts ear type to readable name
	// - phrase function that composes complex requirement into readable phrase
	//
	// argFn = (body) => body.earType
	// opFn = (value) => value==Ears.FOX
	// checkFn = (body) => opFn(argFn(body)) = body.earType==Ears.FOX
	// nameFn = (value) => Ears.Types[value].name
	// phraseFn("eq", Ears.FOX) => "fox ears"
	
	/**
	 * Parses operator definition.
	 * Examples:
	 * ```
	 * parseOperatorObject("blue") => {
	 * 		nameFn() {
	 *      return "blue"
	 * 		},
	 * 		operatorFn(value) {
	 * 			return value == "blue"
	 * 		}
	 * 	}
	 * parseOperatorObject(ANY("red", "blue")) => {
	 * 		nameFn() {
	 * 			return "red or blue"
	 *    },
	 * 		operatorFn(value) {
	 * 			return ["red", "blue"].indexOf(value) >= 0
	 * 		}
	 * 	}
	 * parseOperatorObject(6, facePhraseToNameFn) => {
	 * 		nameFn() {
	 * 			return facePhraseToNameFn() //"cat face"
	 *    },
	 * 		operatorFn(value) {
	 * 			return value == 6
	 * 		}
	 * 	}
	 * 	```
	 * @param op Operator definition. Simple value means "equal", otherwise should be operator definition object
	 * @param phraseFn A function `(operator:*,value:*)=>String` to generate `name` field. Default is BodyData.defaultPhraseFn.
	 * @param errorContext Prepended to error message, to help debugging
	 * @return `{nameFn:()=>String, operatorFn:(value:*)=>Boolean}`
	 */
	public static function parseOperatorObject(
			op:*,
			phraseProvider:Function=null,
			errorContext:String=""
	):Object {
		if (phraseProvider == null) phraseProvider = BodyData.defaultPhraseFn("",null);
		errorContext += "["+Utils.stringify(op)+"] ";
		
		var operatorFn:Function;
		var nameFn:Function;
		
		if (typeof op === "object") {
			if (!op || !("operator" in op)) {
				if (op is Array) {
					trace('[ERROR] '+errorContext+"Array provided not wrapped in ANY/NONE")
					return parseOperatorObject({
						operator: "any",
						options: op
					}, phraseProvider, errorContext);
				}
				throw new Error(errorContext+" Invalid operator")
			}
			var operator:* = op["operator"];
			switch (operator) {
				case "any":
				case "none":
					var none:Boolean = operator == "none";
					var anyOptions:Array = op["options"] as Array;
					if (!anyOptions) throw new Error(errorContext+"Invalid operator");
					operatorFn = none ? operatorNoneFn(anyOptions) : operatorAnyFn(anyOptions);
					nameFn = function (): String {
						return phraseProvider(operator, anyOptions);
					}
					break;
				case "lt":
				case "le":
				case "gt":
				case "ge":
				case "ne":
					var compValue:* = op["value"];
					operatorFn = operatorCompareFn(operator, compValue);
					nameFn = function (): String {
						return phraseProvider(operator, compValue);
					}
					break;
				default:
					throw new Error(errorContext+"Unknown operator");
			}
		} else {
			operatorFn = operatorEqFn(op);
			nameFn = function (): String {
				return phraseProvider("eq", op);
			}
		}
		return {
			nameFn: nameFn,
			operatorFn: operatorFn
		}
	}
	
	public static function slotPhrase(slotId:int, expr:*, suffix:Boolean=true):String {
		if (suffix) return parseOperatorObject(expr, BodyData.slotPhraseFn(slotId)).nameFn();
		return parseOperatorObject(expr, BodyData.defaultPhraseFn("", BodyData.Slots[slotId].nameFn)).nameFn();
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
	
	public static function checkSlotFn(slot:int, value:*, errorContext:String=""): Function {
		return composeOpArg(
				argumentSlotFn(slot),
				parseOperatorObject(value, BodyData.slotPhraseFn(slot), errorContext).operatorFn
		);
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
			case "le":
				return function (input:*):Boolean {
					return input <= value;
				}
			case "gt":
				return function (input:*):Boolean {
					return input > value;
				}
			case "ge":
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
	 * @return `(body) => body.hasBalls == test`
	 */
	public static function hasBallsFn(test:Boolean):Function {
		if (test) {
			return function (body:BodyData):Boolean {
				return body.hasBalls;
			}
		} else {
			return function (body:BodyData):Boolean {
				return !body.hasBalls;
			}
		}
	}
	/**
	 * @return `(body) => body.hasVagina == test`
	 */
	public static function hasVaginaFn(test:Boolean):Function {
		if (test) {
			return function (body:BodyData):Boolean {
				return body.hasVagina;
			}
		} else {
			return function (body:BodyData):Boolean {
				return !body.hasVagina;
			}
		}
	}
	/**
	 * @return `(body) => body.player.hasVagina() == test`
	 */
	public static function hasCockFn(test:Boolean):Function {
		if (test) {
			return function (body:BodyData):Boolean {
				return body.hasCock;
			}
		} else {
			return function (body:BodyData):Boolean {
				return !body.hasCock;
			}
		}
	}
	
	
	
}
}
