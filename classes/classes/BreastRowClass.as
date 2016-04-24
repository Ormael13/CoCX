package classes
{
	import classes.internals.Utils;

	public class BreastRowClass
	{
		//constructor
		public function BreastRowClass()
		{
		}
		public var breasts:Number = 2;
		public var nipplesPerBreast:Number = 1;
		public var breastRating:Number = 0;
		public var lactationMultiplier:Number = 0;
		//Fullness used for lactation....if 75 or greater warning bells start going off!
		//If it reaches 100 it reduces lactation multiplier.
		public var milkFullness:Number = 0;
		public var fullness:Number = 0;
		public var fuckable:Boolean = false;
		public var nippleCocks:Boolean = false;
		
		public function validate():String
		{
			var error:String = "";
			error += Utils.validateNonNegativeNumberFields(this, "BreastRowClass.validate", [
					"breasts", "nipplesPerBreast", "breastRating", "lactationMultiplier",
					"milkFullness", "fullness"
			]);
			return error;
		}
		/*
		0 - manchest
		1 - A cup
		2 - B cup
		3 - C cup
		4 - D cup
		5 - DD cup
		6 - E cup
		7 - F cup
		8 - G cup
		9 - GG cup
		10 - H
		11 - HH cup
		12 - HHH cup
		13 - beachball sized
		14 - ???*/
	}
}