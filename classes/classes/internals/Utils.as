/**
 * Created by aimozg on 18.01.14.
 */
package classes.internals
{
import classes.*;

import coc.script.Eval;

import flash.utils.describeType;

import mx.formatters.NumberFormatter;

public class Utils extends Object
	{
		// One hundred because with math you can craft 0-999 yes i'm a psychopath who typed positional manually don't @ me
		public static const NUMBER_WORDS_NORMAL:Array		= ["zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten",
			"eleven", "twelve", "thirteen", "fourteen", "fifteen", "sixteen", "seventeen", "eighteen", "nineteen", "twenty",
			"twenty-one", "twenty-two", "twenty-three", "twenty-four", "twenty-five", "twenty-six", "twenty-seven", "twenty-eight", "twenty-nine", "thirty",
			"thirty-one", "thirty-two", "thirty-three", "thirty-four", "thirty-five", "thirty-six", "thirty-seven", "thirty-eight", "thirty-nine", "forty",
			"forty-one", "forty-two", "forty-three", "forty-four", "forty-five", "forty-six", "forty-seven", "forty-eight", "forty-nine", "fifty",
			"fifty-one", "fifty-two", "fifty-three", "fifty-four", "fifty-five", "fifty-six", "fifty-seven", "fifty-eight", "fifty-nine", "sixty",
			"sixty-one", "sixty-two", "sixty-three", "sixty-four", "sixty-five", "sixty-six", "sixty-seven", "sixty-eight", "sixty-nine", "seventy",
			"seventy-one", "seventy-two", "seventy-three", "seventy-four", "seventy-five", "seventy-six", "seventy-seven", "seventy-eight", "seventy-nine", "eighty",
			"eighty-one", "eighty-two", "eighty-three", "eighty-four", "eighty-five", "eighty-six", "eighty-seven", "eighty-eight", "eighty-nine", "ninety",
			"ninety-one", "ninety-two", "ninety-three", "ninety-four", "ninety-five", "ninety-six", "ninety-seven", "ninety-eight", "ninety-nine", "hundred"];
		public static const NUMBER_WORDS_CAPITAL:Array		= ["Zero", "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten",
			"Eleven", "Twelve", "Thirteen", "Fourteen", "Fifteen", "Sixteen", "Seventeen", "Eighteen", "Nineteen", "Twenty",
			"Twenty-one", "Twenty-two", "Twenty-three", "Twenty-four", "Twenty-five", "Twenty-six", "Twenty-seven", "Twenty-eight", "Twenty-nine", "Thirty",
			"Thirty-one", "Thirty-two", "Thirty-three", "Thirty-four", "Thirty-five", "Thirty-six", "Thirty-seven", "Thirty-eight", "Thirty-nine", "Forty",
			"Forty-one", "Forty-two", "Forty-three", "Forty-four", "Forty-five", "Forty-six", "Forty-seven", "Forty-eight", "Forty-nine", "Fifty",
			"Fifty-one", "Fifty-two", "Fifty-three", "Fifty-four", "Fifty-five", "Fifty-six", "Fifty-seven", "Fifty-eight", "Fifty-nine", "Sixty",
			"Sixty-one", "Sixty-two", "Sixty-three", "Sixty-four", "Sixty-five", "Sixty-six", "Sixty-seven", "Sixty-eight", "Sixty-nine", "Seventy",
			"Seventy-one", "Seventy-two", "Seventy-three", "Seventy-four", "Seventy-five", "Seventy-six", "Seventy-seven", "Seventy-eight", "Seventy-nine", "Eighty",
			"Eighty-one", "Eighty-two", "Eighty-three", "Eighty-four", "Eighty-five", "Eighty-six", "Eighty-seven", "Eighty-eight", "Eighty-nine", "Ninety",
			"Ninety-one", "Ninety-two", "Ninety-three", "Ninety-four", "Ninety-five", "Ninety-six", "Ninety-seven", "Ninety-eight", "Ninety-nine", "Hundred"];
		public static const NUMBER_WORDS_POSITIONAL:Array	= ["zeroth", "first", "second", "third", "fourth", "fifth", "sixth", "seventh", "eighth", "ninth", "tenth",
			"eleventh", "twelfth", "thirteenth", "fourteenth", "fifteenth", "sixteenth", "seventeenth", "eighteenth", "nineteenth", "twentieth",
			"twenty-first", "twenty-second", "twenty-third", "twenty-fourth", "twenty-fifth", "twenty-sixth", "twenty-seventh", "twenty-eighth", "twenty-ninth", "thirtieth",
			"thirty-first", "thirty-second", "thirty-third", "thirty-fourth", "thirty-fifth", "thirty-sixth", "thirty-seventh", "thirty-eighth", "thirty-ninth", "fortieth",
			"forty-first", "forty-second", "forty-third", "forty-fourth", "forty-fifth", "forty-sixth", "forty-seventh", "forty-eighth", "forty-ninth", "fiftieth",
			"fifty-first", "fifty-second", "fifty-third", "fifty-fourth", "fifty-fifth", "fifty-sixth", "fifty-seventh", "fifty-eighth", "fifty-ninth", "sixtieth",
			"sixty-first", "sixty-second", "sixty-third", "sixty-fourth", "sixty-fifth", "sixty-sixth", "sixty-seventh", "sixty-eighth", "sixty-ninth", "seventieth",
			"seventy-first", "seventy-second", "seventy-third", "seventy-fourth", "seventy-fifth", "seventy-sixth", "seventy-seventh", "seventy-eighth", "seventy-ninth", "eightieth",
			"eighty-first", "eighty-second", "eighty-third", "eighty-fourth", "eighty-fifth", "eighty-sixth", "eighty-seventh", "eighty-eighth", "eighty-ninth", "ninetieth",
			"ninety-first", "ninety-second", "ninety-third", "ninety-fourth", "ninety-fifth", "ninety-sixth", "ninety-seventh", "ninety-eighth", "ninety-ninth", "hundredth"];
		public static const NUMBER_WORDS_POSITIONAL_CAPITAL:Array	= ["zeroth", "First", "Second", "Third", "Fourth", "Fifth", "Sixth", "Seventh", "Eighth", "Ninth", "Tenth",
			"Eleventh", "Twelfth", "Thirteenth", "Fourteenth", "Fifteenth", "Sixteenth", "Seventeenth", "Eighteenth", "Nineteenth", "Twentieth",
			"Twenty-First", "Twenty-Second", "Twenty-Third", "Twenty-Fourth", "Twenty-Fifth", "Twenty-Sixth", "Twenty-Seventh", "Twenty-Eighth", "Twenty-Ninth", "Thirtieth",
			"Thirty-First", "Thirty-Second", "Thirty-Third", "Thirty-Fourth", "Thirty-Fifth", "Thirty-Sixth", "Thirty-Seventh", "Thirty-Eighth", "Thirty-Ninth", "Fortieth",
			"Forty-First", "Forty-Second", "Forty-Third", "Forty-Fourth", "Forty-Fifth", "Forty-Sixth", "Forty-Seventh", "Forty-Eighth", "Forty-Ninth", "Fiftieth",
			"Fifty-First", "Fifty-Second", "Fifty-Third", "Fifty-Fourth", "Fifty-Fifth", "Fifty-Sixth", "Fifty-Seventh", "Fifty-Eighth", "Fifty-Ninth", "Sixtieth",
			"Sixty-First", "Sixty-Second", "Sixty-Third", "Sixty-Fourth", "Sixty-Fifth", "Sixty-Sixth", "Sixty-Seventh", "Sixty-Eighth", "Sixty-Ninth", "Seventieth",
			"Seventy-First", "Seventy-Second", "Seventy-Third", "Seventy-Fourth", "Seventy-Fifth", "Seventy-Sixth", "Seventy-Seventh", "Seventy-Eighth", "Seventy-Ninth", "Eightieth",
			"Eighty-First", "Eighty-Second", "Eighty-Third", "Eighty-Fourth", "Eighty-Fifth", "Eighty-Sixth", "Eighty-Seventh", "Eighty-Eighth", "Eighty-Ninth", "Ninetieth",
			"Ninety-First", "Ninety-Second", "Ninety-Third", "Ninety-Fourth", "Ninety-Fifth", "Ninety-Sixth", "Ninety-Seventh", "Ninety-Eighth", "Ninety-Ninth", "Hundredth"];

		public static const MAX_SAFE_NUMBER_VALUE:Number = 1e300;
		//returns logical XOR of two values without much fuckery
		public static function xor(a:Boolean, b:Boolean):Boolean {
			return a && !b || !a && b;
		}

        //returns n-th bit of the integer
        public static function getBit(x:int, bit:int):Boolean {
            return Boolean(x & (1 << bit));
        }

        //sets n-th bit of the integer
        public static function setBit(x:int, bit:int, setTo:Boolean):int {
            return x & ~(1 << bit) | (int(setTo) << bit);
        }

		//XORs n-th bit of the integer
		public static function xorBit(x:int, bit:int):int {
			return setBit(x, bit, !getBit(x, bit));
		}

		// curryFunction(f,args1)(args2)=f(args1.concat(args2))
		// e.g. curryFunction(f,x,y)(z,w) = f(x,y,z,w)
		public static function curry(func:Function,...args):Function
		{
			if (func == null) CoC_Settings.error("carryFunction(null,"+args+")");
			return function (...args2):*{
				return func.apply(null,args.concat(args2));
			};
		}
		// returns same function that doesn't crash on too many arguments
		public static function varargify(func:Function):Function {
			return function(...args):* {
				return func.apply(this, args.slice(0, func.length));
			}
		}
		public static function bindThis(func:Function,thiz:Object):Function {
			return function(...args2):* {
				return func.apply(thiz,args2);
			}
		}
		public static function formatStringArray(stringList:Array):String {
			switch (stringList.length) {
				case 0:
					return "";
				case 1:
					return stringList[0];
				case 2:
					return stringList.join(" and ");
				default:
					var concat:String = stringList.slice(0, -1).join(", ");
					return concat + " and " + stringList[stringList.length - 1];
			}
		}

		/**
		 * @return input if it is not null or undefined, otherwise defaultValue
		 */
		public static function valueOr(input:*, defaultValue:*):* {
			return (input === null || input === undefined) ? defaultValue : input;
		}
		public static function stringOr(input:*,def:String=""):String {
			return (input is String) ? input : def;
		}
		public static function intOr(input:*,def:int=0):int {
			return (input is int) ? input :
					(input is Number) ? input|0 : def;
		}
		public static function numberOr(input:*,def:Number=0):Number {
			return (input is Number && !isNaN(input)) ? input : def;
		}
		public static function objectOr(input:*,def:Object=null):Object {
			return (input is Object && input !== null) ? input : def;
		}
		public static function valueOrThrow(input:*, errorMsg:String="Missing value"):* {
			if (input === null || input === undefined) throw new Error(errorMsg);
			return input;
		}
		public static function ipow(base:Number, exp:int):Number {
			if (exp < 0) {
				exp = -exp;
				base = 1.0 / base;
			} else if (exp == 0) {
				return 1;
			}

			var result:Number = 1.0;
			while (exp > 0) {
				if (exp % 2 == 1) {
					result *= base;
				}
				base *= base;
				exp /= 2;
			}

			return result;
		}
		
		/**
		 * Solve the arithmetic progression.
		 * For startValue=1, increment=1, return N such that 1 + 2 + 3 + ... + N = sum
		 *
		 * General form: return N such that
		 *
		 * `sum = startValue + (startValue + increment) + (startValue + 2*increment) + ...`
		 * (N total items)
		 */
		public static function solveSum(sum:Number, startValue:Number = 1, increment:Number = 1):Number {
			var a:Number = increment;
			var b:Number = (2*startValue - increment);
			var c:Number = -2*sum;
			return (Math.sqrt(b*b - 4*a*c) - b)/(2*a);
		}
		public static function floor(value:Number,decimals:int=0):String {
			if (decimals == 0) return ''+Math.floor(value);
			var base:Number = ipow(10,decimals);
			value = Math.floor(value*base)/base;
			return ''+value.toFixed(decimals).replace(/\.?0+$/,'');
			// no risk stripping 0s from 123000 because that's the case of decimals=0
		}
		public static function round(value:Number, decimals:int):Number {
			if (decimals == 0) return Math.round(value);
			var base:Number = ipow(10, decimals);
			return Math.round(value*base)/base;
		}
		public static function formatNumber(value:Number, options:Object = null):String {
			var nf:NumberFormatter = new NumberFormatter();
			return nf.format(value);
		}
		
		/**
		 * Format number with sign and at most maxDecimals digits after the dot.
		 */
		public static function formatSignedFloat(value:Number, maxDecimals:int):String {
			if (!isFinite(value)) return String(value);
			return ((value >= 0?"+":"") + value.toFixed(maxDecimals)).replace(/\.?0+$/,"");
		}
		public static function boundInt(min:int, x:int, max:int):int {
			return x < min ? min : x > max ? max : x;
		}
		public static function boundFloat(min:Number, x:Number, max:Number):Number {
			if (!isFinite(x)) return min;
			return x < min ? min : x > max ? max : x;
		}
		/**
		 * Linear interpolation from v0 at t=0 to v1 at t=1
		 */
		public static function lerp(v0:Number, v1:Number, t:Number):Number {
			return (1-t)*v0 + t*v1;
		}
		/**
		 * Mimics JS Object.keys
		 * For non-dynamic objects and/or getting all defined properties, set reflect = true
		 */
		public static function keys(o:Object, reflect:Boolean = false):/*String*/Array {
			var r:/*String*/Array = [];
			if (reflect) {
				var desc:XML = describeType(o);
				for each (var node:XML in desc.*) {
					var tag:String = node.name();
					if (tag === "variable" || tag === "constant" || tag === "method") {
						r.push(node.@name.toString());
					}
				}
			} else {
				for (var k:* in o) r.push(k);
			}
			return r;
		}
		/**
		 * Mimics JS Object.values
		 * For non-dynamic objects and/or getting all defined properties, set reflect = true
		 */
		public static function values(o:Object, reflect:Boolean = false):Array {
			var r:Array = [];
			var ks:Array = keys(o, reflect);
			for each(var k:* in ks) r.push(o[k]);
			return r;
		}
		/**
		 * Mimics JS Object.entries
		 * For non-dynamic objects and/or getting all defined properties, set reflect = true
		 */
		public static function objectEntries(o:Object, reflect:Boolean = false):/*Array*/Array {
			var r:Array = [];
			var ks:Array = keys(o, reflect);
			for each(var k:* in ks) r.push([k,o[k]]);
			return r;
		}
		/**
		 * Append all values to target. Return target.
		 */
		public static function pushAll(target:Array, values:Array):Array {
			target.push.apply(target, values);
			return target;
		}
		
		/**
		 * Concatenate into single array.
		 *
		 * If only 1 argument provider, concatenate its contents:
		 * `concat(A, B, C) === concat([A, B, C)`
		 */
		public static function concat(...arrays:/*Array*/Array):Array {
			if (arrays.length == 1) return concat.apply(null, arrays);
			var result:Array = [];
			for each (var array:Array in arrays) result = result.concat(array);
			return result;
		}
		/**
		 * Concatenate into single array, omitting duplicates.
		 *
		 * If only 1 argument provider, concatenate its contents:
		 * `concat(A, B, C) === concat([A, B, C)`
		*/
		public static function concatUnique(...arrays:/*Array*/Array):Array {
			if (arrays.length == 1) return concatUnique.apply(null, arrays);
			var result:Array = [];
			for each (var array:Array in arrays)
				for each (var el:* in array)
					if (result.indexOf(el) == -1) result.push(el);
			return result;
		}
		
		/**
		 * Returns flattened array with elements from all sub-arrays in a single list.
		 */
		public static function flatten(src:Array, dst:Array=null):Array {
			if (!dst) dst = [];
			for each(var e:* in src) {
				if (e is Array) flatten(e, dst);
				else dst.push(e);
			}
			return dst;
		}

		/**
		 * @return src.find( el => el[propName] == propValue ) || defaultValue
		 */
		public static function findByProp(src:Array, propName:String, propValue:*, defaultValue:* = undefined):* {
			for each (var e:* in src) {
				if (e[propName] == propValue) return e;
			}
			return defaultValue;
		}

		/**
		 * @return src.filter( el => el && el[propName] == propValue )
		 */
		public static function filterByProp(src:Array, propName:String, propValue:*):Array {
			return src.filter(function(element:*, index:int, array:Array):Boolean {
				return element && element[propName] == propValue;
			})
		}
		/**
		 * @return src.map( el => el['propname'] )
		 */
		public static function mapOneProp(src:Array,propname:String):Array {
			var result:Array = [];
			for (var i:int = 0; i< src.length; i++) {
				if (!src[i]) continue;
				result.push(src[i][propname]);
			}
			return result;
		}
		/**
		 * @return src.map( el => ({ label: propname ? el[propname] : (""+el), data: el }) )
		 */
		public static function mapForComboBox(src:Array,propname:String):Array {
			var result:Array = [];
			for (var i:int = 0; i< src.length; i++) {
				var el:* = src[i];
				if (!el) continue;
				result.push({label: propname ? el[propname] : (""+el), data:el});
			}
			result.sort(function(a:*, b:*):int {
				if (a.label > b.label) {
					return 1;
				} else {
					return -1;
				}
			});
			return result;
		}
		/**
		 * @return src.filter(el=>el).map( el => mapping.map(prop => el[prop]) )
		 * if keepNulls = true: src.map( el => el ? mapping.map(prop => el[prop]) : null )
		 */
		public static function mapToArrays(src:Array,mapping:/*String*/Array,keepNulls:Boolean=false):Array {
			var result:/*Array*/Array = [];
			for (var i:int=0; i<src.length; i++) {
				var el:* = src[i];
				if (el) {
					var mapped:Array = [];
					for each (var prop:String in mapping) {
						mapped.push(el[prop]);
					}
					result.push(mapped);
				} else if (keepNulls) {
					result.push(null);
				}
			}
			return result;
		}
		/**
		 * Deleting obj[key] with default.
		 *
		 * If `key` in `obj`: return `obj[key]` and delete `obj[key]`
		 * Otherwise return `defaultValue`
		 */
		public static function moveValue(obj:Object,key:String,defaultValue:*):* {
			if (key in obj) {
				defaultValue = obj[key];
				delete obj[key];
			}
			return defaultValue;
		}
		/**
		 * Performs a shallow copy of properties from `src` to `dest`, then from `srcRest` to `dest`
		 * A `hasOwnProperties` check is performed.
		 */
		public static function extend(dest:Object, src:Object, ...srcRest:Array):Object {
			srcRest.unshift(src);
			for each(src in srcRest) {
				if (!src) continue;
				for (var k:String in src) {
					if (src.hasOwnProperty(k)) dest[k] = src[k];
				}
			}
			return dest;
		}
		/**
		 * Returns a shallow copy of `src` ownProperties
		 */
		public static function shallowCopy(src:Object):Object {
			return copyObject({},src);
		}
		
		/**
		 * Returns a deep copy of `src`
		 */
		public static function deepCopy(src:Object):Object {
			var dst:Object = src is Array ? [] : {};
			for (var k:String in src) {
				if (src.hasOwnProperty(k)) {
					var v:* = src[k];
					if (v is Array) {
						dst[k] = deepCopy(v);
					} else if (typeof v === "object" && v !== null) {
						dst[k] = deepCopy(v);
					} else {
						dst[k] = v;
					}
				}
			}
			return dst;
		}
		/**
		 * Performs a shallow copy of properties from `src` to `dest`.
		 * If `properties` is supplied, only listed properties are copied.
		 * If not, all ownProperties of `src` are copied.
		 *
		 * @param properties array of property descriptors:
		 * <ul><li><code>key:String</code>
		 *     =&gt; <code>dest[key] = src.key]</code></li>
		 *     <li><code>[dkey:String, skey:String]</code>
		 *     =&gt; <code>dest[dkey] = src[skey]</code>
		 *     <li>object with properties:
		 *         <ul><li><code>skey:String, dkey:String</code> or <code>key:String</code></li>
		 *         <li>(optional) <code>'default':*|Function</code> to provide default value.
		 *         If function, called with no arguments</li></ul>
		 * </ul>
		 * @return dest
		 */
		public static function copyObject(dest:Object, src:Object,...properties:Array):Object {
			return copyObjectEx(dest, src, properties, true);
		}
		/**
		 * @see Utils.copyObject
		 * @param forward if true, use <code>dest[dkey]</code> and <code>src[skey]</code>.
		 * if false, use <code>dest[skey]</code> and <code>src[dkey]</code>.
		 * This option is useful when you have one set of descriptors to use it in both directions
		 * @param ignoreErrors If assignment throws an error, continue to next property.
		 * @return dest
		 */
		public static function copyObjectEx(dest:Object, src:Object, properties:Array, forward:Boolean = true, ignoreErrors:Boolean = false):Object {
			if (properties.length == 0) return extend(dest,src);
			for each (var pd:* in properties) {
				var skey:String,dkey:String,v:*;
				var def:*,hasDefault:Boolean=false;
				if (pd is String) {
					skey = pd;
					dkey = pd;
				} else if (pd is Array) {
					if (pd.length==2) {
						if (forward) {
							dkey = pd[0];
							skey = pd[1];
						}else {
							dkey = pd[1];
							skey = pd[0];
						}
					} else trace("WARNING: incorrect copyObject property descriptor "+pd);
				} else if (pd is Object) {
					if ("key" in pd) {
						skey = dkey = pd.key;
					} else if ("skey" in pd && "dkey" in pd) {
						skey = pd.skey;
						dkey = pd.dkey;
					} else {
						trace("WARNING: missing 'key' or 'skey'+'dkey' in property descriptor "+pd);
						continue;
					}
					if (!forward) {
						// we can't do it in the assignment below because of the check
						var tmp:String = skey;
						skey = dkey;
						dkey = tmp;
					}
					if ("default" in pd) {
						def = pd["default"];
						hasDefault = true;
					}
				}
				if (skey in src) {
					v = src[skey];
				} else if (hasDefault) {
					if (def is Function) v = def();
					else v = def();
				} else continue;
				try {
					dest[dkey] = v;
				} catch (e:*) {
					if (!ignoreErrors) throw e;
					trace(e);
				}
			}
			return dest;
		}
		/**
		 * @example
		 * [ "a", "b", "c" ] -> { "a": true, "b": true, "c": true }
		 */
		public static function toSet(src:/*String*/Array):Object {
			var result:Object = {};
			for each (var s:String in src) result[s] = true;
			return result;
		}
		/**
		 * @example
		 * [ {id: "a"}, {id: "b"}, {id: "c"} ] -> { "a": true, "b": true, "c": true }
		 */
		public static function mapPropToSet(src:/*String*/Array, propname:String):Object {
			var result:Object = {};
			for each (var o:* in src) result[o[propname]] = true;
			return result;
		}
		
		/**
		 * @example
		 * [ [key1,value1], [key2, value2], ... ] -> { key1: value1, key2: value2, ... }
		 */
		public static function createMapFromPairs(src:Array):Object {
			return multipleMapsFromPairs(src)[0];
		}
		/**
		 * @example
		 * [ [key1, value1_1, value1_2, ...],
		 *   [key2, value2_1, value2_2, ...], ... ]
		 *   ->
		 * [ { key1: value1_1,
		 *     key2: value2_1, ...
		 *   }, {
		 *     key1: value1_2,
		 *     key2: value2_2, ...
		 *   }, ... ]
		 */
		public static function multipleMapsFromPairs(src:Array):Array {
			var results:Array = [{}];
			for each(var tuple:Array in src) {
				while (results.length < tuple.length-1) results.push({});
				var key:* = tuple[0];
				for (var i:int = 1; i<tuple.length; i++) results[i-1][key] = tuple[i];
			}
			return results;
		}

		/**
		 * Convert a mixed array to an array of strings
		 *
		 * Some string lists (color lists for example) may contain strings and arrays containing 2+ strings.
		 * e. g.: ["blue", "green", ["black", "white", "gray"], ["red", "orange"], "blue"]
		 * With this method such an array would be converted to contain only string.
		 * So the above example would return:
		 * ["blue", "green", "black, white and gray", "red and orange", "blue"]
		 *
		 * @param   list  An array with mixed strings and arrays of strings
		 * @return  An array of strings
		 */
		public static function convertMixedToStringArray(list:Array):Array
		{
			var returnArray:Array = [];
			for (var i:String in list)
				returnArray.push((list[i] is Array) ? formatStringArray(list[i]) : list[i]);

			return returnArray;
		}

		public static function escapeXml(s:String):String {
			return s.replace(/[\n\r'"<>&]/g,function ($0:String,...rest):String {
				switch($0){
					case '\r': return '&#13;';
					case '\n': return '&#10;';
					case "'": return '&apos;';
					case '"': return '&quot;';
					case '<': return '&lt;';
					case '>': return '&gt;';
					case '&': return '&amp;';
					default: return $0;
				}
			});
		}
		
		public static function num2Text(number:int, maxnumber:int = 10, onehundred:Boolean = true):String {
			if (number >= 0 && number <= maxnumber && (number < NUMBER_WORDS_NORMAL.length)) return ((onehundred && number==100) ? NUMBER_WORDS_NORMAL[1]+" " : "")+NUMBER_WORDS_NORMAL[number];
			return number.toString();
		}
		public static function num2Text2(number:int, maxnumber:int = 10, onehundred:Boolean = true):String {
			if (number < 0) return number.toString(); //Can't really have the -10th of something
			if (number <= maxnumber && number < NUMBER_WORDS_POSITIONAL.length) return ((onehundred && number==100) ? NUMBER_WORDS_NORMAL[1]+" " : "")+NUMBER_WORDS_POSITIONAL[number];
			switch (number % 10) {
				case 1: return number.toString() + "st";
				case 2: return number.toString() + "nd";
				case 3: return number.toString() + "rd";
				default:
			}
			return number.toString() + "th";
		}
		public static function Num2Text(number:int, maxnumber:int = 10, onehundred:Boolean = true):String {
			if (number >= 0 && number <= maxnumber && (number < NUMBER_WORDS_CAPITAL.length)) return ((onehundred && number==100) ? NUMBER_WORDS_CAPITAL[1]+" "+NUMBER_WORDS_NORMAL[number] : NUMBER_WORDS_CAPITAL[number]);
			return number.toString();
		}
		public static function Num2Text2(number:int, maxnumber:int = 10, onehundred:Boolean = true):String {
			if (number < 0) return number.toString(); //Can't really have the -10th of something
			if (number <= maxnumber && number < NUMBER_WORDS_POSITIONAL.length) return ((onehundred && number==100) ? NUMBER_WORDS_CAPITAL[1]+" "+NUMBER_WORDS_POSITIONAL[number] : NUMBER_WORDS_POSITIONAL_CAPITAL[number]);
			switch (number % 10) {
				case 1: return number.toString() + "st";
				case 2: return number.toString() + "nd";
				case 3: return number.toString() + "rd";
				default:
			}
			return number.toString() + "th";
		}

		public static function addComma(num:int):String{
			var str:String = "";
			if (num <= 0) return "0";
			while (num>0){
				var tmp:uint = num % 1000;
				str = ( num > 999 ?"," + (tmp < 100 ? ( tmp < 10 ? "00": "0"): ""): "") + tmp + str;
				num = num / 1000;
			}
			return str;
		}

		public static function capitalizeFirstLetter(string:String):String {
			return (string.substr(0, 1).toUpperCase() + string.substr(1));
		}

		public static function lowerCaseFirstLetter(string:String):String {
			return (string.substr(0, 1).toLowerCase() + string.substr(1));
		}

		public static function mergeSentences(sentences: Array, lastDivider: String = ", and ", divider: String = ", ", lowerCase:Boolean=true): String {
			var mergedString: String = "";

			sentences = sentences.filter(function(element: *, index: int, array: Array): Boolean {
				if (element) {
					return true;
				}

				return false;
			});

			for (var i: int = 0; i < sentences.length; i++) {
				var s: String = sentences[i];

				if (i > 0 && lowerCase) {
					s = lowerCaseFirstLetter(s);
				}

				if (i < sentences.length - 1 && s.slice (s.length - 1) === ".") {
					s = s.slice(0, s.length - 1);
				}

				mergedString += s;

				if (i < sentences.length - 2) {
					mergedString += divider;
				} else if (i == sentences.length - 2) {
					mergedString += lastDivider;
				}
			}

			return mergedString;
		}
		
		/**
		 * Converts an input to string, trying to stringify objects either with their `toString()` method or `JSON.stringify()`
		 */
		public static function stringify(input:*):String {
			if (input is String) return input;
			if (typeof input !== "object" || !input) return ""+input;
			if (typeof input.toString === "function") return input.toString();
			try {
				return JSON.stringify(input);
			} catch (e:*) {
			}
			return ""+input;
		}

		//
		/**
		 * randomIncrement(3.14) = 3 + (1 in 14% rolls)
		 *
		 * Return x or (x+1); P(x+1) = x-floor(x)
		 */
		public static function randomIncrement(x:Number):Number {
			var i:Number = Math.floor(x);
			if (Math.random() < x - i) i++;
			return i;
		}
		
		// Basically, you pass an arbitrary-length list of arguments, and it returns one of them at random.
		// Accepts any type.
		// Can also accept a *single* array of items, in which case it picks from the array instead.
		// This lets you pre-construct the argument, to make things cleaner
		public static function randomChoice(...args):*
		{
			var tar:Array;

			if (args.length == 1 && args[0] is Array) tar = args[0];
			else if (args.length > 1) tar = args;
			else throw new Error("RandomInCollection could not determine usage pattern.");

			return tar[rand(tar.length)];
		}

		/**
		 * Same as randomChoice(), but places the picked items into an array.
		 * Accepts any type; Can also accept a *single* array of items, in which case it picks from the array instead.
		 * @param unique If true, will pick unique items (works well with duplicates in the provided array)
		 * @param count	 How much items to pick
		 */
		public static function randomChoices(unique:Boolean, count:int, ...args):Array {
			var tar:Array = args.length == 1 && args[0] is Array ? args[0] : args;
			if (unique && count > tar.length || count < 0) throw new Error("Wrong randomChoices usage.");

			var ind:Array = [], res:Array = [];
			var i:int;
			// find unique indices
			while (ind.length < count) {
				i = rand(tar.length);
				if (!unique || ind.indexOf(i) == -1)
					ind.push(i);
			}
			for each (i in ind)
				res.push(tar[i]);
			return res;
		}
		
		
		/**
		 * Pick a weighted random item.
		 * Weights <= 0 or NaN are ignored.
		 * Weight of Infinity means "return this value"
		 * If no suitable item, return null
		 * @param {[][]} pairs Pairs of [weight, value]
		 * @example
		 * weightedRandom([
		 *   [1, "ketchup"],
		 *   [5, "mayo"],
		 *   [14, "cum"]
		 * ])
		 * // would return "ketchup" with 5% chance, "mayo" with 25%, and "cum" with 70%
		 */
		public static function weightedRandom(...pairs):* {
			if (pairs.length == 0 || !pairs[0]) {
				return null;
			}
			if (pairs.length == 1) {
				if (!(pairs[0] is Array)) return pairs[0];
				// imitate spread
				// 1st argument could be the list of pairs
				if (pairs[0].length != 2) return weightedRandom.apply(null, pairs[0]);
				// 2 options here:
				// pairs = [ [weight, value] ]
				// pairs = [ [pair1,  pair2] ]
				if (pairs[0][0] is Array) return weightedRandom.apply(null, pairs[0]);
			}
			for each (var item:Array in pairs) {
				if (!item || item.length != 2 ) {
					throw new Error("Invalid weightedRandom item");
				}
			}
			return weightedRandomBy(pairs, "0", "1");
		}
		/**
		 * Pick a weighted random item.
		 * Weights <= 0 or NaN are ignored.
		 * Weight of Infinity means "return this value"
		 * If no suitable item, return null
		 * @param pairs Objects to select from
		 * @param weightKey Property name indicating weight
		 * @param valueKey Property name indicating value to return, or "" to return whole object
		 * @example
		 * weightedRandomBy([
		 *   {chance:1, value:"ketchup"},
		 *   {chance:5, value:"mayo"},
		 *   {chance:14, value:cum"}
		 * ], "chance", "value")
		 * // would return "ketchup" with 5% chance, "mayo" with 25%, and "cum" with 70%
		 * // removing 3rd arg would make it return {chance:1, value:"ketchup"} objects
		 */
		public static function weightedRandomBy(items:Array, weightKey:String, valueKey:String=""):* {
			var sum:Number = 0;
			for each (var item:Object in items) {
				var weight:Number = valueOr(item[weightKey], 1);
				if (weight === Infinity) return valueKey ? item[valueKey] : item;
				if (isFinite(weight) && weight > 0) {
					sum += weight;
				}
			}
			var roll:Number = Math.random()*sum;
			item = null;
			for each (item in items) {
				weight = valueOr(item[weightKey], 1);
				if (!isFinite(weight) || weight <= 0) continue;
				roll -= weight;
				if (roll <= 0) break;
			}
			return valueKey ? item[valueKey] : item;
		}
		/**
		 * Normalize array, making sum of its elements = norm
		 * @param array
		 * @param norm
		 * @param key If non-empty, then source array is array of tuples/objects. Normalize their `key` properties
		 */
		public static function normalizeArray(array:Array,norm:Number=1,key:String=""):Array {
			var sum:Number = 0;
			for (var i:int = 0; i <array.length; i++) {
				if (key) sum += array[i][key];
				else sum += array[i];
			}
			if (sum != 0) {
				for (i = 0; i < array.length; i++) {
					if (key) array[i][key] *= norm/sum;
					else array[i] *= norm/sum;
				}
			}
			return array;
		}

		/**
		 * Utility function to search for a specific value within a target array or collection of values.
		 * Collection can be supplied either as an existing array or as varargs:
		 * ex: 	InCollection(myValue, myArray)
		 * 		InCollection(myValue, myPossibleValue1, myPossibleValue2, myPossibleValue3)
		 * @param	tar			Target value to search for
		 * @param	... args	Collection to look in
		 * @return				Boolean true/false if found/not found.
		 */
		public static function InCollection(tar:*, ... args):Boolean
		{
			if (args.length == 0) return false;

			var collection:*;

			for (var ii:int = 0; ii < args.length; ii++)
			{
				collection = args[ii];

				if (!(collection is Array))
				{
					if (tar == collection) return true;
				}
				else
				{
					for (var i:int = 0; i < collection.length; i++)
					{
						if (tar == collection[i]) return true;
					}
				}
			}

			return false;
		}
		
		/**
		 * Sort the {@param collection} according to natural sort order of the value returned by {@param selector} `(value:*)=>*` function.
		 * @param descending Sort descending
		 * @return A new collection, {@param collection} is unmodified.
		 *
		 * @example
		 * sortedBy(
		 *     ["a","quickest","brown","fox"],
		 *     function(s:String):int { return s.length; }
		 * ) -> ["a", "fox", "brown", "quickest"]
		 */
		public static function sortedBy(
				collection:Array,
				selector:Function,
				descending:Boolean = false):Array {
			if (collection.length == 0) return [];
			/**
			 * array of `{ v: original collection element, s: value to sort on }
			 */
			var selection:Array = [];
			for (var i:int=0; i<collection.length; i++) {
				selection[i] = {s:selector(collection[i]),v:collection[i]};
			}
			var flags:int = descending?Array.DESCENDING:0;
			if (selection[0].s is Number) flags |= Array.NUMERIC;
			selection.sortOn("s",flags);
			for (i=0; i<collection.length; i++) {
				selection[i] = selection[i].v;
			}
			return selection;
		}

		public static function rand(max:Number):int
		{
			return int(Math.random() * max);
		}
		public static function randIntIn(minInclusive:Number, maxInclusive:Number):Number {
			if (minInclusive >= maxInclusive) return minInclusive;
			return Math.floor(Math.random()*(maxInclusive+1-minInclusive)+minInclusive);
		}
		public static function trueOnceInN(n:Number):Boolean
		{
			return Math.random()*n < 1;
		}

		/**
		 * Shuffle the elements in the array randomly. Returns the array.
		 */
		public static function shuffle(a:Array):Array {
			// https://en.wikipedia.org/wiki/Fisher-Yates_shuffle
			const n:int = a.length;
			for (var i:int = n-1; i >= 1; i--) {
				var j:int = rand(i+1);
				var x:* = a[i];
				a[i] = a[j];
				a[j] = x;
			}
			return a;
		}

		public static function validateNonNegativeNumberFields(obj:Object, func:String, nnf:Array):String
		{
			var error:String = "";
			var o:Object = obj;
			for each (var field:String in nnf) {
				var keys:Array = field.split('.');
				if(keys.length > 1){
					o = obj[keys[0]];
					field = keys[1];
				} else {
					o = obj;
				}
				if (!o.hasOwnProperty(field) || !(o[field] is Number) && o[field] != null) error += "Misspelling in "+func+".nnf: '"+field+"'. ";
				else if (o[field] == null) error += "Null '"+field+"'. ";
				else if (o[field] < 0) error += "Negative '"+field+"'. ";
			}
			return error;
		}

		public static function validateNonEmptyStringFields(obj:Object, func:String, nef:Array):String
		{
			var error:String = "";
			var o:Object = obj;
			for each (var field:String in nef) {
				var keys:Array = field.split('.');
				if(keys.length > 1){
					o = obj[keys[0]];
					field = keys[1];
				} else {
					o = obj;
				}
				if (!o.hasOwnProperty(field) || !(o[field] is String) && o[field] != null) error += "Misspelling in "+func+".nef: '"+field+"'. ";
				else if (o[field] == null) error += "Null '"+field+"'. ";
				else if (o[field] == "") error += "Empty '"+field+"'. ";
			}
			return error;
		}
		/**
		 * numberOfThings(0,"brain") = "no brains"
		 * numberOfThings(1,"head") = "one head"
		 * numberOfThings(2,"tail") = "2 tails"
		 * numberOfThings(3,"hoof","hooves") = "3 hooves"
		 */
		public static function numberOfThings(n:int, name:String, pluralForm:String = null):String
		{
			pluralForm = pluralForm || (name + "s");
			if (n == 0) return "no " + pluralForm;
			if (n == 1) return "one " + name;
			return n + " " + pluralForm;
		}
		public static function repeatString(s:String,n:int):String {
			var rslt:String = "";
			while (n-->0) rslt += s;
			return rslt;
		}
		public static function trimLeft(s:String):String {
			return s.replace(/^\s+/g,'');
		}
		public static function trimRight(s:String):String {
			return s.replace(/\s+$/g,'');
		}
		public static function trimSides(s:String):String {
			return trimLeft(trimRight(s));
		}
		public static function padStart(s:String, length:int, padChar:String = ' '):String {
			while (s.length < length) s = padChar + s;
			return s;
		}
		public static function padEnd(s:String, length:int, padChar:String = ' '):String {
			while (s.length < length) s = s + padChar;
			return s;
		}
		public static function tieredBonus(stat:Number, step:Number, tier1:Number):Number {
		  var tier:Number = Math.floor( (stat-tier1)/step + 1 );
		  var offset:Number = step*( (tier+1)*tier / 2); // Calculates sum of tier boundaries
		  return tier*stat-offset;
		}
		/**
		 * Format a string, replacing `{expression}`s with text.
		 * <pre>
		 * {expression} - evaluated and converted to string
		 * {expression;format} - also apply number formatting:
		 *   d - integer
		 *  +d - signed integer
		 *   f - float
		 *  2f - float 2 decimals (or any other number)
		 * +2f - signed float 2 decimals
		 *  2F - float at most 2 decimals
		 * +2F - signed float at most 2 decimals
		 *   C - capitalize first letter
		 *
		 * Examples for formatString(pattern, {power:5}):
		 * "{power} fire damage" -> "5 fire damage"
		 * "{power*10;+d}% strength" -> "+50% strength"
		 * "{power*0.5;+1f}% fire resistance" -> "+2.5% fire resistance"
		 * "{power;1f} fire damage -> "5 fire damage"
		 * "{power/10;1f} fire damage -> "0.5 fire damage"
		 * "{power/100;1f} fire damage -> "0.1 fire damage"
		 * </pre>
		 *
		 * @param pattern
		 * @param context Objects containing expression parameterss
		 * @return
		 */
		public static function substitute(pattern:String, ...context:/*Object*/Array):String {
			const substitute:RegExp = /\{[^}]+}/g;
			const fmtPattern:RegExp  = /^\{(.*);(\+?)(\d*)(\w)}$/;
			return pattern.replace(substitute, function ($0:String, ...rest):String {
				var fmt:Array = $0.match(fmtPattern);
				if (fmt) {
					// fmt = [match, expr, sign, decimals, type]
					var expr:*         = fmt[1];
					var signed:Boolean = fmt[2] === "+";
					var decimals:int   = fmt[3] ? parseInt(fmt[3]) : -1;
					var type:String    = fmt[4];
					var rawValue:*   = Eval.compile(expr).vcall(context);
					if (type === "C") {
						return capitalizeFirstLetter(String(rawValue));
					} else {
						var numValue:Number = rawValue;
						var sign:String     = (signed && numValue >= 0) ? "+" : "";
						if (type === "d") {
							return sign + numValue.toFixed(0);
						} else if (type === "f") {
							if (decimals >= 0) {
								return sign + numValue.toFixed(decimals);
							} else {
								return sign + numValue.toString();
							}
						} else if (type === "F") {
							return (sign + numValue.toFixed(decimals)).replace(/\.?0+$/,"");
						} else {
							trace("[ERROR] Bad substitution " + fmt);
							return "(Unknown formatter " + type + ")" + numValue;
						}
					}
				} else {
					return String(Eval.compile($0.substr(1, $0.length-2)).vcall(context));
				}
			})
		}

		private static var PF_NAME:Array      = []; // stack: classname+'.'+methodname
		private static var PF_START:Array     = []; // stack: start time
		private static var PF_ARGS:Array      = []; // stack: args
		private static var PF_INTCOUNT:Array  = []; // stack: # of internal calls
		private static var PF_COUNT:Object    = {}; // name => total # of name()
		private static var PF_INTERNALS:Object= {}; // name => total # of something() inside name()
		private static var PF_TIME:Object     = {}; // name => total execution time
		private static var PF_DEPTH:int       = 0;
		/*
		That probably requires an explanation so here's an example:

		foo() {
		  baz();
		  bar();
		}
		bar() {
		  baz();
		}
		baz() { no tracked code }

		foo.Begin    : PF_NAME = [foo]          , PF_INTCOUNT = [0]      , PF_DEPTH = 1
		  baz.Begin  :               └push      ,       +1───────┘└push 0
		               PF_NAME = [foo, baz]     , PF_INTCOUNT = [1, 0]   , PF_DEPTH = 2
		  baz.End    :   check, pop─────┘                           ├──add to left
		                                     PF_INTERNALS[baz]+=────┘
		               PF_NAME = [foo]          , PF_INTCOUNT = [1]      , PF_DEPTH = 1
		  bar.Begin  : PF_NAME = [foo, bar]     , PF_INTCOUNT = [1, 0]   , PF_DEPTH = 2
		    baz.Begin:                    └push ,          +1───────┘└push 0
		               PF_NAME = [foo, bar, baz], PF_INTCOUNT = [1, 1, 0], PF_DEPTH = 3
		    baz.End  :        check, pop─────┘                         ├──add to left
		                                        PF_INTERNALS[bar]+=────┘
		               PF_NAME = [foo, bar]     , PF_INTCOUNT = [1, 2]   , PF_DEPTH = 2
		  bar.End    :   check, pop─────┘                           ├──add to left
		                                     PF_INTERNALS[bar]+=────┘
		               PF_NAME = [foo]          , PF_INTCOUNT = [3]      , PF_DEPTH = 1
		foo.End      : check, pop──┘                             ├──add to left
		                                  PF_INTERNALS[foo]+=────┘
		               PF_NAME = []             , PF_INTCOUNT = []       , PF_DEPTH = 0

		PF_COUNT:      foo=1, bar=1, baz=2
		PF_INTERNALS:  foo=3, bar=1, baz=0
		 */
		private static function shouldProfile(classname:String,methodName:String):Boolean {
			return true;
		}
		private static function shouldReportProfiling(classname:String,origMethodName:String,dt:Number, pfcount:int):Boolean {
			return dt > 100;
		}
		public static function LogProfilingReport():void {
			var report:/*String*/Array = [];
			for (var key:String in PF_COUNT) {
				var s:String = "[PROFILE] ";
				s+= key;
				var pfcount:int = PF_COUNT[key];
				s += ", called " + pfcount + " times";
				var pftime:* = PF_TIME[key];
				s += ", total time ";
				if (pftime > 10000) s += Math.floor(pftime/1000)+"s";
				else s += pftime + "ms";
				if (pftime>0 && pfcount>0) {
					s += ", avg time " + (pftime / pfcount).toFixed(1) + "ms";
				}
				var pfint:int = PF_INTERNALS[key];
				if (pfint>0 && pfcount>0) {
					s += ", avg " + (pfint/pfcount).toFixed(1) +" internal calls";
				}
				report.push(s);
			}
			report.sort();
			for each (var line:String in report) {
				trace(line);
			}
		}
		public static function Begin(classname:String, methodName:String, ...rest:Array):void {
			if (!shouldProfile(classname,methodName)) return;
			methodName = classname+"."+methodName;
			PF_NAME[PF_DEPTH] = methodName;
			PF_START[PF_DEPTH] = new Date().getTime();
			PF_ARGS[PF_DEPTH] = rest;
			PF_COUNT[methodName] = (PF_COUNT[methodName]|0)+1;
			PF_INTCOUNT[PF_DEPTH] = 0;
			if (PF_DEPTH>0) PF_INTCOUNT[PF_DEPTH-1] = PF_INTCOUNT[PF_DEPTH-1]+1;
			PF_DEPTH++;
		}
		public static function End(classname:String, methodName:String):void {
			if (!shouldProfile(classname,methodName)) return;
			var origMethodName:String = methodName;
			methodName = classname+"."+methodName;
			var t1:Number   = new Date().getTime();
			PF_DEPTH--;
			while (PF_DEPTH>=0 && PF_NAME[PF_DEPTH]!=methodName) {
				trace("[ERROR] Inconsistent callstack, expected '"+methodName+"', got '"+PF_NAME[PF_DEPTH]+"'("+
					  PF_ARGS[PF_DEPTH].join()+")");
				PF_DEPTH--;
			}
			if (PF_DEPTH < 0){
				trace("[ERROR] Empty callstack, expected '"+methodName+"'");
				PF_DEPTH = 0;
				return;
			}
			var dt:Number = t1 - PF_START[PF_DEPTH];
			PF_TIME[methodName] = (PF_TIME[methodName]|0)+dt;
			var pfcount:int   = PF_COUNT[methodName];
			var pfintct:int   = PF_INTCOUNT[PF_DEPTH];
			PF_INTERNALS[methodName] = (PF_INTERNALS[methodName]|0) + pfintct;
			var args:Array = PF_ARGS[PF_DEPTH];
			if (shouldReportProfiling(classname,origMethodName,dt, pfcount)) {
				var s:String = "[PROFILE] ";
				for (var i:int=PF_DEPTH;i-->0;) s+="  ";
				s+= methodName;
				if (args.length>0) s+="("+args.join(", ")+")";
				s += " " + dt + "ms";
				if (pfcount > 1) {
					s += ", called " + pfcount + " times";
					var pftime:* = PF_TIME[methodName];
					if (pftime>0) {
						s += ", total time ";
						if (pftime > 10000) s += Math.floor(pftime/1000)+"s";
						else s += pftime + "ms";
						s += ", avg time " + (pftime / pfcount).toFixed(1) + "ms";
					}
				}
				if (pfintct>0) {
					s += ", "+pfintct+" internal calls";
				}
				trace(s);
			}
		}
	}
}
