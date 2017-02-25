package classes
{
	import classes.internals.Utils;

	public class VaginaClass
	{
		public static const DEFAULT_CLIT_LENGTH:Number = 0.5;
		
		//constructor
		public function VaginaClass(vaginalWetness:Number = 1, vaginalLooseness:Number = 0, virgin:Boolean = false, clitLength:Number = DEFAULT_CLIT_LENGTH)
		{
			this.virgin=virgin;
			this.vaginalWetness=vaginalWetness;
			this.vaginalLooseness=vaginalLooseness;
			this.clitLength = clitLength;
		}
		//data
		//Vag wetness
		public var vaginalWetness:Number = 1;
		/*Vag looseness
		0 - virgin
		1 - normal
		2 - loose
		3 - very loose
		4 - gaping
		5 - monstrous*/
		public var vaginalLooseness:Number = 0;
		//Type
		//0 - Normal
		//5 - Black bugvag
		public var type:int = 0;
		public var virgin:Boolean = true;
		//Used during sex to determine how full it currently is.  For multi-dick sex.
		public var fullness:Number = 0;
		public var labiaPierced:Number = 0;
		public var labiaPShort:String = "";
		public var labiaPLong:String = "";		
		public var clitPierced:Number = 0;
		public var clitPShort:String = "";
		public var clitPLong:String = "";
		public var clitLength:Number;

		public function validate():String
		{
			var error:String = "";
			error += Utils.validateNonNegativeNumberFields(this, "VaginaClass.validate", [
				"vaginalWetness", "vaginalLooseness", "type",
				"fullness", "labiaPierced", "clitPierced", "clitLength"
			]);
			if (labiaPierced) {
				if (labiaPShort == "") error += "Labia pierced but labiaPShort = ''. ";
				if (labiaPLong == "") error += "Labia pierced but labiaPLong = ''. ";
			} else {
				if (labiaPShort != "") error += "Labia not pierced but labiaPShort = '" + labiaPShort + "'. ";
				if (labiaPLong != "") error += "Labia not pierced but labiaPLong = '" + labiaPShort + "'. ";
			}
			if (clitPierced) {
				if (clitPShort == "") error += "Clit pierced but labiaPShort = ''. ";
				if (clitPLong == "") error += "Clit pierced but labiaPLong = ''. ";
			} else {
				if (clitPShort != "") error += "Clit not pierced but labiaPShort = '" + labiaPShort + "'. ";
				if (clitPLong != "") error += "Clit not pierced but labiaPLong = '" + labiaPShort + "'. ";
			}
			return error;
		}
		
		/**
		 * Wetness factor used for calculating capacity.
		 * 
		 * @return wetness factor based on wetness
		 */
		public function wetnessFactor():Number {
			return 1 + vaginalWetness / 10;
		}
		
		private function baseCapacity(bonusCapacity:Number):Number {
			return bonusCapacity + 8 * vaginalLooseness * vaginalLooseness;
		}
		
		/**
		 * The capacity of the vagina, calculated using looseness and wetness.
		 * 
		 * @param bonusCapacity extra space to add
		 * @return the total capacity, with all factors considered.
		 */
		public function capacity(bonusCapacity:Number = 0):Number {
			return baseCapacity(bonusCapacity) * wetnessFactor();
		}
	}
}