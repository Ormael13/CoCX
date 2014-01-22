/**
 * Created by aimozg on 18.01.14.
 */
package classes.internals
{
	import classes.*;
	public class Utils
	{

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
		// Basically, you pass an arbitrary-length list of arguments, and it returns one of them at random.
		// Accepts any type.
		// Can also accept a *single* array of items, in which case it picks from the array instead.
		// This lets you pre-construct the argument, to make things cleaner
		public static function randomChoice(...args):*
		{
			var choice:Number;
			if ((args.length == 1) && (args[0] is Array))
			{
				choice = int(Math.round(Math.random() * (args[0].length - 1)));
				return args[0][choice];
			}
			else
			{
				choice = int(Math.round(Math.random() * (args.length - 1)));
				return args[choice];
			}
		}
		public static function rand(max:Number):Number
		{
			return int(Math.random() * max);
		}
	}
}
