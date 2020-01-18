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
		public static function bindThis(func:Function,thiz:Object):Function {
			return function(...args2):* {
				return func.apply(thiz,args2);
			}
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
		public static function objectOr(input:*,def:Object=null):Object {
			return (input is Object && input !== null) ? input : def;
		}
		public static function boundInt(min:int, x:int, max:int):int {
			return x < min ? min : x > max ? max : x;
		}
		public static function boundFloat(min:Number, x:Number, max:Number):Number {
			if (!isFinite(x)) return min;
			return x < min ? min : x > max ? max : x;
		}
		/**
		 * Mimics JS Object.keys
		 */
		public static function keys(o:Object):/*String*/Array {
			var r:/*String*/Array = [];
			for (var k:String in o) r.push(k);
			return r;
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
		 * [ [key1,value1], [key2, value2], ... ] -> { key1: value1, key2: value2, ... }
		 */
		public static function createMapFromPairs(src:Array):Object {
			return multipleMapsFromPairs(src)[0];
		}
		/**
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
		
		public static function rand(max:Number):int
		{
			return int(Math.random() * max);
		}
		public static function trueOnceInN(n:Number):Boolean
		{
			return Math.random()*n < 1;
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
		public static function tieredBonus(stat:Number, step:Number, tier1:Number):Number {
		  var tier:Number = Math.floor( (stat-tier1)/step + 1 );
		  var offset:Number = step*( (tier+1)*tier / 2); // Calculates sum of tier boundaries
		  return tier*stat-offset;
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
			PF_INTERNALS[methodName] += pfintct;
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
