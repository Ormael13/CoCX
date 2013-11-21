package classes 
{
	/**
	 * ...
	 * @author Gedan
	 */
	public class BoundControlMethod
	{
		private var _funcToCall:Function;
		private var _shortName:String;
		private var _descript:String;
		
		public function BoundControlMethod(func:Function, name:String, desc:String) 
		{
			_funcToCall = func;
			_shortName = name;
			_descript = desc;
		}
		
		public function ExecFunc(... args):void
		{
			_funcToCall.apply(null, args);
		}
		
		public function get Name():String
		{
			return _shortName;
		}
		
		public function get Description():String
		{
			return _descript;
		}
	}

}