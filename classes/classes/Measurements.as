package classes 
{
	import classes.GlobalFlags.kFLAGS;
	import classes.internals.Utils;
	/**
	 * Class to make the measurement methods taken from PlayerAppearance globally accessible
	 * @since  19.08.2016
	 * @author Stadler76
	 */
	public class Measurements
	{
		public static function footInchOrMetres(inches:Number, precision:int = 2):String
		{
			var pHeight:String = "";
			if (CoC.instance.flags[kFLAGS.USE_METRICS] == 1){
				pHeight = (Math.round(inches * 2.54) / Math.pow(10, precision)).toFixed(precision) + " metres";
			}
			else if (CoC.instance.flags[kFLAGS.USE_METRICS] == 0){
				pHeight = Math.floor(inches / 12) + " foot"
				if (inches % 12 > 0){
					pHeight = pHeight + " " +  inches % 12 + " inch";
				}
			}
			else{
				pHeight = Math.floor(inches / 12) + "\'"
				if (inches % 12 > 0){
					pHeight = pHeight + " " +  inches % 12 + "\"";
				}
			}
			return pHeight;
			//return Math.floor(inches / 12) + " foot " + inches % 12 + " inch";
		}
		public static function numInchesOrCentimetres(inches:Number):String
		{
			if (inches < 1) return inchesOrCentimetres(inches);
			var value:int = Math.round(inches);
			if (CoC.instance.flags[kFLAGS.USE_METRICS] == 1) {
				value = Math.round(inches * 2.54);
				return Utils.num2Text(value) + (value === 1 ? " centimetre" : " centimetres");
			}
			if (inches % 12 === 0)
				return (inches === 12 ? "a foot" : Utils.num2Text(inches / 12) + " feet");
			return Utils.num2Text(value) + (value === 1 ? " inch" : " inches");
		}
		public static function inchesOrCentimetres(inches:Number, precision:int = 1):String
		{
			var value:Number = Math.round(inchToCm(inches) * Math.pow(10, precision)) / Math.pow(10, precision);
			var text:String = value.toString() + (CoC.instance.flags[kFLAGS.USE_METRICS] == 1 ? " centimetre" : " inch");
			if (value === 1) return text;
			return text + (CoC.instance.flags[kFLAGS.USE_METRICS] == 1 ? "s" : "es");
		}
		public static function shortSuffix(inches:Number, precision:int = 1):String
		{
			var value:Number = Math.round(inchToCm(inches) * Math.pow(10, precision)) / Math.pow(10, precision);
			return value.toString() + (CoC.instance.flags[kFLAGS.USE_METRICS]  == 1 ? "-cm" : "-inch");
		}
		public static function inchToCm(inches:Number):Number
		{
			return CoC.instance.flags[kFLAGS.USE_METRICS] == 1 ? inches * 2.54 : inches;
		}
	}
}
