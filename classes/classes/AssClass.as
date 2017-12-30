package classes
{
import classes.BodyParts.IOrifice;
import classes.internals.Utils;

	public class AssClass implements IOrifice
	{
		//constructor
		public static const WETNESS_DRY:int            = 0;
		public static const WETNESS_NORMAL:int         = 1;
		public static const WETNESS_MOIST:int          = 2;
		public static const WETNESS_SLIMY:int          = 3;
		public static const WETNESS_DROOLING:int       = 4;
		public static const WETNESS_SLIME_DROOLING:int = 5;
		
		public static const LOOSENESS_VIRGIN:int    = 0;
		public static const LOOSENESS_TIGHT:int     = 1;
		public static const LOOSENESS_NORMAL:int    = 2;
		public static const LOOSENESS_LOOSE:int     = 3;
		public static const LOOSENESS_STRETCHED:int = 4;
		public static const LOOSENESS_GAPING:int    = 5;
		
		public function AssClass()
		{
		}
		
		//data
		//butt wetness
		public var analWetness:Number = 0;
		/*butt looseness
		0 - virgin
		1 - normal
		2 - loose
		3 - very loose
		4 - gaping
		5 - monstrous*/
		public var analLooseness:Number = 0;
		//Used to determine thickness of knot relative to normal thickness
		//Used during sex to determine how full it currently is.  For multi-dick sex.
		public var fullness:Number = 0;
		public var virgin:Boolean = true; //Not used at the moment.
		private var _host:Creature     = null;
		public function get host():Creature {
			return _host;
		}
		public function set host(value:Creature):void {
			_host = value;
		}
		public function validate():String {
			var error:String = "";
			error += Utils.validateNonNegativeNumberFields(this, "AssClass.validate",[
					"analWetness", "analLooseness", "fullness"
			]);
			return error;
		}
	}
}