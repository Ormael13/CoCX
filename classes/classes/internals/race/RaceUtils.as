package classes.internals.race {
import classes.BodyData;
import classes.CockTypesEnum;
import classes.PerkType;
import classes.internals.Utils;

public class RaceUtils {
	function RaceUtils() {
	}
	
	
	/*****************************************************
	 * Functions creating functions for `ConditionedRaceScoreBuilder`s
	 *****************************************************/
	
	/*****************************************************
	 * Functions creating functions for `RacialRequirement`s
	 *****************************************************/
	
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
			switch (op["operator"]) {
				case "any":
					var anyOptions:Array = op["options"] as Array;
					if (!anyOptions) throw new Error(errorContext+"Invalid operator");
					operatorFn = operatorAnyFn(anyOptions);
					name = Utils.mergeSentences(anyOptions.map(Utils.varargify(nameProvider))," or ");
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
	 * @return `(body, score) => operatorFn(argumentFn(body))`
	 */
	public static function composeOpArg(argumentFn:Function, operatorFn:Function):Function {
		return function (body:BodyData, score:int):Boolean {
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
	 * @return `(input) => input == value
	 */
	public static function operatorEqFn(value:*):Function {
		return function(input:*):Boolean {
			return input == value;
		}
	}
	
	/**
	 * @return `(body, score) => body.data[slot]`
	 */
	public static function argumentSlotFn(slot:int):Function {
		return function(body:BodyData):* {
			return body.data[slot];
		}
	}
	
	/**
	 * @return `(body, score) => body.player.hasPerk(ptype)`
	 */
	public static function hasPerkFn(ptype:PerkType):Function {
		return function (body:BodyData, score:int):Boolean {
			return body.player.hasPerk(ptype);
		}
	}
	/**
	 * @return `(body, score) => body.player.cockType(ctype) > 0`
	 */
	public static function hasCockOfTypeFn(ctype:CockTypesEnum):Function {
		return function (body:BodyData, score:int):Boolean {
			return body.player.countCocksWithType(ctype) > 0;
		}
	}
	
	
}
}
