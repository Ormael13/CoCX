/**
 * Created by aimozg on 18.01.14.
 */
package classes
{
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
		public static function lazy(obj:*,...args):Function{
			return function():*{
				while(args.length>0)
					obj=obj[args.shift()];
				return obj;
			};
		}
		// lazy2(func,arg1,...,argN)() = func()[arg1]...[argN]
		public static function lazy2(func:Function,...args):Function{
			return function():*{
				var obj:*=func();
				while(args.length>0)
					obj=obj[args.shift()];
				return obj
			};
		}
	}
}
