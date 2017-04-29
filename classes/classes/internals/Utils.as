/**
 * Created by aimozg on 18.01.14.
 */
package classes.internals
{
	import classes.*;

	public class Utils extends Object
	{
		private static const NUMBER_WORDS_NORMAL:Array		= ["zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten"];
		private static const NUMBER_WORDS_CAPITAL:Array		= ["Zero", "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten"];
		private static const NUMBER_WORDS_POSITIONAL:Array	= ["zeroth", "first", "second", "third", "fourth", "fifth", "sixth", "seventh", "eighth", "ninth", "tenth"];

		public function Utils()
		{
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
		
		public static function formatStringArray(stringList:Array):String { //Changes an array of values into "1", "1 and 2" or "1, (x, )y and z"
			switch (stringList.length) {
				case  0: return "";
				case  1: return stringList[0];
				case  2: return stringList[0] + " and " + stringList[1];
				default:
			}
			var concat:String = stringList[0];
			for (var x:int = 1; x < stringList.length - 1; x++) concat += ", " + stringList[x];
			return concat + " and " + stringList[stringList.length - 1];
		}
		public static function stringOr(input:*,def:String=""):String {
			return (input is String) ? input : def;
		}
		public static function intOr(input:*,def:int=0):int {
			return (input is int) ? input :
					(input is Number) ? input|0 : def;
		}
		public static function numberOr(input:*,def:Number=0):Number {
			return (input is Number) ? input : def;
		}
		/**
		 * Performs a shallow copy of properties from `src` to `dest`.
		 * A `hasOwnProperties` check is performed.
		 */
		public static function extend(dest:Object, src:Object):Object {
			for (var k:String in src) {
				if (src.hasOwnProperty(k)) dest[k] = src;
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

		public static function num2Text(number:int):String {
			if (number >= 0 && number <= 10) return NUMBER_WORDS_NORMAL[number];
			return number.toString();
		}
		
		public static function num2Text2(number:int):String {
			if (number < 0) return number.toString(); //Can't really have the -10th of something
			if (number <= 10) return NUMBER_WORDS_POSITIONAL[number];
			switch (number % 10) {
				case 1: return number.toString() + "st";
				case 2: return number.toString() + "nd";
				case 3: return number.toString() + "rd";
				default:
			}
			return number.toString() + "th";
		}
		
		public static function Num2Text(number:int):String {
			if (number >= 0 && number <= 10) return NUMBER_WORDS_CAPITAL[number];
			return number.toString();
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
		
		public static function rand(max:Number):Number
		{
			return int(Math.random() * max);
		}
		public static function trueOnceInN(n:int):Boolean
		{
			return rand(n) == 0;
		}

		public static function validateNonNegativeNumberFields(o:Object, func:String, nnf:Array):String
		{
			var error:String = "";
			for each (var field:String in nnf) {
				if (!o.hasOwnProperty(field) || !(o[field] is Number) && o[field] != null) error += "Misspelling in "+func+".nnf: '"+field+"'. ";
				else if (o[field] == null) error += "Null '"+field+"'. ";
				else if (o[field] < 0) error += "Negative '"+field+"'. ";
			}
			return error;
		}
		
		public static function validateNonEmptyStringFields(o:Object, func:String, nef:Array):String
		{
			var error:String = "";
			for each (var field:String in nef) {
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

		/* None of these functions are called anymore
		// lazy(obj,arg1,...,argN)() = obj[arg1]...[argN]
		public static function lazyIndex(obj:*,...args):Function{
			return function():*{
				while(args.length>0)
					obj=obj[args.shift()];
				return obj;
			};
		}
		// lazy2(func,arg1,...,argN)() = func()[arg1]...[argN]
		public static function lazyCallIndex(func:Function,...args):Function{
			var _args:Array = args.slice();
			return function():*{
				var obj:*=func();
				var __args:Array = _args.slice();
				while(__args.length>0)
					obj=obj[__args.shift()];
				return obj
			};
		}
		// lazy2(func,arg1,...,argN)(args2) = func()[arg1]...[argN](args2)
		public static function lazyCallIndexCall(func:Function,...args):Function{
			var _args:Array = args.slice();
			return function (...fargs):*{
				var obj:*=func();
				var __args:Array = _args.slice();
				while(__args.length>0)
					obj=obj[__args.shift()];
				return obj.apply(null,fargs);
			};
		}
		*/
	}
}
