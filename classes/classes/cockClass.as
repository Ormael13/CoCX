package classes
{
	public class cockClass
	{
		//constructor
		public function cockClass()
		{
		}
		//data
		//Cock length
		public var cockLength:Number = 4.5;
		//Cock thickness 
		public var cockThickness:Number = 1;
		/*Cock types
		0 - human
		1 - horse
		2 - dog
		3 - demon
		4 - tentacle?
		5 - CAT
		6 - Lizard/Naga?
		7 - ANEMONE!
		8 - ugliest wang ever (kangaroo)
		9 - dragon
		10 - displacer
		*/		
		public var cockType:Number = 0;
		//Used to determine thickness of knot relative to normal thickness
		public var knotMultiplier:Number = 1;
		public var pierced:Number = 0;
		public var pShort:String = "";
		public var pLong:String = "";		
		public var sock:String = "";
		
		
		//MEMBER FUNCTIONS
		public function cArea():Number {
			return cockThickness*cockLength;
		}
		public function growCock(increase:Number):Number {
			var amountGrown:Number = 0;
			var temp:Number = 0;
			if(increase > 0) {
				trace("growcock increasing..");
				while(increase > 0) {
					temp = 1;
					//Cut length growth for huge dicked
					if(cockLength > 10 && cockType != 1) {
						temp /= 2;
					}
					if(cockType == CockTypesEnum.HUMAN && cockLength > 17) temp/=2;
					//Cut again for massively dicked
					if(cockType != 1 && cockLength > 24) temp/=2;
					if(cockType == CockTypesEnum.HUMAN && cockLength > 40) temp/=2;
					//Start adding up bonus length
					amountGrown += temp;
					cockLength += temp;
					temp = 0;
					increase--;
				}
				increase = 0;
			}
			//Decrease
			if(increase < 0) {
				trace("growcock decreasing..");
				while(increase < 0) {
					temp = -1;
					//Cut length growth for huge dicked
					if(cockLength < 5 && cockType != 1) {
						temp /= 2;
					}
					//Cut length loss, horses lose slower
					if(cockType == CockTypesEnum.HUMAN && cockLength < 10) temp/=3;
					else if(cockLength < 10) temp/=2;
					//Cut again for massively dicked
					if(cockType == CockTypesEnum.HUMAN && cockLength < 4) temp/=3;
					else if(cockLength < 4) temp/=2;
					if(cockType == CockTypesEnum.HUMAN && cockLength < 6) temp/=3;
					else if(cockLength < 6) temp/=2;
					//MINIMUM LENGTH OF 1!
					if(cockLength == 1) temp = 0;
					//Start adding up bonus length
					amountGrown += temp;
					cockLength += temp;
					temp = 0;
					increase++;
				}
				//Cut down thickness if disproportional
				if(cockThickness > cockLength * .33) cockThickness = cockLength*.33;
			}
			return amountGrown;
		}
		public function thickenCock(increase:Number) {
			var amountGrown:Number = 0;
			var temp:Number = 0;
			if(increase > 0) {
				while(increase > 0) {
					if(increase < 1) temp = increase;
					else temp = 1;
					//Cut thickness growth for huge dicked
					if(cockThickness > 1 && cockLength < 12) {
						temp /= 4;
					}
					if(cockThickness > 1.5 && cockLength < 18) temp /= 5;
					if(cockThickness > 2 && cockLength < 24) temp /= 5;
					if(cockThickness > 3 && cockLength < 30) temp /= 5;
					//proportional thickness diminishing returns.
					if(cockThickness > cockLength * .15) temp /= 3;
					if(cockThickness > cockLength * .20) temp /= 3;
					if(cockThickness > cockLength * .30) temp /= 5;
					//massive thickness limiters
					if(cockThickness > 4) temp /= 2;
					if(cockThickness > 5) temp /= 2;
					if(cockThickness > 6) temp /= 2;
					if(cockThickness > 7) temp /= 2;
					//Start adding up bonus length
					amountGrown += temp;
					cockThickness  += temp;
					temp = 0;
					increase--;
				}
				increase = 0;
				return amountGrown;
			}
			if(increase < 0) {
				while(increase < 0) {
					temp = -1;
					//Cut length growth for huge dicked
					if(cockThickness <= 1) temp /= 2;
					if(cockThickness < 2 && cockLength < 10) temp/=2;
					//Cut again for massively dicked
					if(cockThickness < 3 && cockLength < 18) temp/=2;
					if(cockThickness < 4 && cockLength < 24) temp/=2;
					//MINIMUM Thickness of OF .5!
					if(cockThickness <= .5) temp = 0;
					//Start adding up bonus length
					amountGrown += temp;
					cockThickness += temp;
					temp = 0;
					increase++;
				}
			}
			return amountGrown;
		}
	}
}