package classes
{
	import classes.internals.Utils;

	public class AssClass
	{
		//constructor
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
		
		public function validate():String {
			var error:String = "";
			error += Utils.validateNonNegativeNumberFields(this, "AssClass.validate",[
					"analWetness", "analLooseness", "fullness"
			]);
			return error;
		}
	}
}