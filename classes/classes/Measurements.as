package classes 
{
	/**
	 * Class to make the measurement methods taken from PlayerAppearance globally accessible
	 * @since  19.08.2016
	 * @author Stadler76
	 */
	public class Measurements extends BaseContent
	{
		public static var useMetrics:Boolean=false;

		public static function footInchOrMetres(inches:Number, precision:int = 2):String
		{
			if (useMetrics)
				return (Math.round(inches * 2.54) / Math.pow(10, precision)).toFixed(precision) + " metres";

			return Math.floor(inches / 12) + " foot " + inches % 12 + " inch";
		}

		public static function numInchesOrCentimetres(inches:Number):String
		{
			if (inches < 1) return inchesOrCentimetres(inches);

			var value:int = Math.round(inches);

			if (useMetrics) {
				value = Math.round(inches * 2.54);
				return num2Text(value) + (value == 1 ? " centimetre" : " centimetres");
			}

			if (inches % 12 == 0)
				return (inches == 12 ? "a foot" : num2Text(inches / 12) + " feet");

			return num2Text(value) + (value == 1 ? " inch" : " inches");
		}

		public static function inchesOrCentimetres(inches:Number, precision:int = 1):String
		{
			var value:Number = Math.round(inchToCm(inches) * Math.pow(10, precision)) / Math.pow(10, precision);
			var text:String = value + ""+(useMetrics ? " centimetre" : " inch");

			if (value == 1) return text;

			return text + (useMetrics ? "s" : "es");
		}

		public static function shortSuffix(inches:Number, precision:int = 1):String
		{
			var value:Number = Math.round(inchToCm(inches) * Math.pow(10, precision)) / Math.pow(10, precision);
			return value + ""+(useMetrics ? "-cm" : "-inch");
		}

		public static function inchToCm(inches:Number):Number
		{
			return useMetrics ? inches * 2.54 : inches;
		}
	}
}
