package classes 
{
	import classes.GlobalFlags.kFLAGS;
	/**
	 * Class to make the measurement methods taken from PlayerAppearance globally accessible
	 * @since  19.08.2016
	 * @author Stadler76
	 */
	public class Measurements extends BaseContent
	{
		private static var _instance:Measurements = new Measurements();

		public function Measurements()
		{
			if (_instance != null)
			{
				throw new Error("Measurements can only be accessed through Measurements.init()");
			}
		}

		public static function init():Measurements { return _instance; }

		public function footInchOrMetres(inches:Number, precision:int = 2):String
		{
			if (flags[kFLAGS.USE_METRICS])
				return (Math.round(inches * 2.54) / Math.pow(10, precision)).toFixed(precision) + " metres";

			return Math.floor(inches / 12) + " foot " + inches % 12 + " inch";
		}

		public function numInchesOrCentimetres(inches:Number):String
		{
			if (inches < 1) return inchesOrCentimetres(inches);

			var value:int = Math.round(inches);

			if (flags[kFLAGS.USE_METRICS]) {
				value = Math.round(inches * 2.54);
				return num2Text(value) + (value == 1 ? " centimetre" : " centimetres");
			}

			if (inches % 12 == 0)
				return (inches == 12 ? "a foot" : num2Text(inches / 12) + " feet");

			return num2Text(value) + (value == 1 ? " inch" : " inches");
		}

		public function inchesOrCentimetres(inches:Number, precision:int = 1):String
		{
			var value:Number = Math.round(inchToCm(inches) * Math.pow(10, precision)) / Math.pow(10, precision);
			var text:String = value + (flags[kFLAGS.USE_METRICS] ? " centimetre" : " inch");

			if (value == 1) return text;

			return text + (flags[kFLAGS.USE_METRICS] ? "s" : "es");
		}

		public function shortSuffix(inches:Number, precision:int = 1):String
		{
			var value:Number = Math.round(inchToCm(inches) * Math.pow(10, precision)) / Math.pow(10, precision);
			return value + (flags[kFLAGS.USE_METRICS] ? "-cm" : "-inch");
		}

		public function inchToCm(inches:Number):Number
		{
			return flags[kFLAGS.USE_METRICS] ? inches * 2.54 : inches;
		}
	}
}
