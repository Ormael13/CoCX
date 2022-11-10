package classes
{
import classes.BodyParts.IPhallic;
import classes.CockTypesEnum;
import classes.GlobalFlags.kFLAGS;
import classes.internals.Utils;

	public class Cock implements IPhallic
	{		
		private var _cockLength:Number;
		private var _cockThickness:Number;		
		private var _cockType:CockTypesEnum;	//See CockTypesEnum.as for all cock types
		
		//Used to determine thickness of knot relative to normal thickness
		private var _knotMultiplier:Number;
		
		//Piercing info
		private var _isPierced:Boolean;
		private var _pierced:Number;
		//Not yet, sweet prince. PiercedType current has no uses. But it will, one day.
		// private var _pierceType:PiercingTypesEnum;
		private var _pShortDesc:String;
		private var _pLongDesc:String;
		
		//Sock
		private var _sock:String;
		private var _host:Creature     = null;
		public function get host():Creature {
			return _host;
		}
		public function set host(value:Creature):void {
			_host = value;
		}

		/**
		 * @return string description of errors
		 */
		public function validate():String {
			var error:String = "";
			error += Utils.validateNonNegativeNumberFields(this,"Cock.validate",["cockLength","cockThickness","knotMultiplier","pierced"]);
			if (!_isPierced){
				if (_pShortDesc.length>0) error += "Not pierced but _pShortDesc = "+_pShortDesc+". ";
				if (_pLongDesc.length>0) error += "Not pierced but pLong = "+_pLongDesc+". ";
			} else {
				if (_pShortDesc.length==0) error += "Pierced but no _pShortDesc. ";
				if (_pLongDesc.length==0) error += "Pierced but no pLong. ";
			}
			return error;
		}
		
		//constructor. Default type is HUMAN
		public function Cock(i_cockLength:Number = 5.5, i_cockThickness:Number = 1, i_cockType:CockTypesEnum=null)
		{
			if (i_cockType == null) i_cockType = CockTypesEnum.HUMAN;
			_cockLength = i_cockLength;
			_cockThickness = i_cockThickness;
			_cockType = i_cockType;
			_pierced = 0;
			_knotMultiplier = 1;
			_isPierced = false;
			//_pierceType = PiercingTypesEnum.NONE;
			_pShortDesc = "";
			_pLongDesc = "";
			_sock = "";
		}
		
		//MEMBER FUNCTIONS
		public function cArea():Number
		{
			return cockThickness * cockLength;
		}

        private function cockDR(curLength:Number, lengthDelta:Number, threshold:Number, bigCock:Boolean):Number {
			if (lengthDelta > 0) { // growing
				threshold = 24;
				// BigCock Perk increases incoming change by 50% and adds 12 to the length before diminishing returns set in
				if (bigCock) {
					lengthDelta *= 1.5;
					threshold *= 1.5;
				}
				// Not a human cock? Multiple the length before dimishing returns set in
				if (cockType != CockTypesEnum.HUMAN)
					threshold *= 2;
				// Modify growth for cock socks
				if (sock == "scarlet") lengthDelta *= 1.5;
				else if (sock == "cobalt") lengthDelta *= .5;
				// Do diminishing returns
				if (!CoC.instance.flags[kFLAGS.HYPER_HAPPY]) {
					if (curLength > threshold) lengthDelta /= 4;
					else if (curLength > threshold / 2) lengthDelta /= 2;
				}
			}
			else {
				if (bigCock) lengthDelta *= 0.5;
				// Modify growth for cock socks
				if (sock == "scarlet") lengthDelta *= 0.5;
				else if (sock == "cobalt") lengthDelta *= 1.5;
                //No DR, shrinky is shrinky!
			}
            return lengthDelta;
        }
		
		public function growCock(lengthDelta:Number, bigCock:Boolean):Number
		{
            var increase:Number;
            var increaseTotal:Number = 0;
			if (lengthDelta == 0) {
				trace("Whoops! growCock called with 0, aborting...");
				return lengthDelta;
			}
            while (lengthDelta != 0) {
                increase = lengthDelta > 0 ? (lengthDelta < 1 ? lengthDelta : 1)
                    : (lengthDelta > -1 ? lengthDelta : -1);
                lengthDelta -= increase;
                //apply an inch
                increase = cockDR(cockLength, increase, 24, bigCock);
                cockLength += increase;
                increaseTotal += increase;
            }
            if (cockLength < 2) cockLength = 2;
            return increaseTotal;
		}
		
		public function thickenCock(thickDelta:Number, bigCock:Boolean):Number
		{
            var increase:Number;
            var increaseTotal:Number = 0;
			if (thickDelta == 0) {
				trace("Whoops! thickenCock called with 0, aborting...");
				return thickDelta;
			}
            while (thickDelta != 0) {
                increase = thickDelta > 0.1 ? (thickDelta < 0.1 ? thickDelta : 0.1)
                    : (thickDelta > -0.1 ? thickDelta : -0.1);
                thickDelta -= increase;
                //apply an inch
                increase = cockDR(cockLength, increase, 6, bigCock);
                if (increase > 0) {
                    if (cockThickness > cockLength * .25) increase /= 2;
                    if (cockThickness > cockLength * .33) increase /= 2;
                    if (cockThickness > cockLength * .50) increase /= 4;
                } else {
					if (cockThickness < cockLength * .15) increase /= 2;
					if (cockThickness < cockLength * .1) increase /= 2;
					if (cockThickness < cockLength * .05) increase /= 4;
				}
                cockThickness += increase;
                increaseTotal += increase;
            }
            if (cockThickness < 0.5) cockLength = 0.5;
            return increaseTotal;
		}	
		
		public function get cockLength():Number 
		{
			return _cockLength;
		}
		
		public function set cockLength(value:Number):void 
		{
			_cockLength = value;
		}
		
		public function get cockThickness():Number 
		{
			return _cockThickness;
		}
		
		public function set cockThickness(value:Number):void 
		{
			_cockThickness = value;
		}
		
		public function get cockType():CockTypesEnum 
		{
			return _cockType;
		}
		
		public function set cockType(value:CockTypesEnum):void 
		{
			_cockType = value;
		}
		
		public function hasKnot():Boolean
		{
			return knotMultiplier > 1;
		}
		
		public function get knotMultiplier():Number 
		{
			return _knotMultiplier;
		}
		
		public function set knotMultiplier(value:Number):void 
		{
			_knotMultiplier = value;
		}
		
		public function get isPierced():Boolean 
		{
			return _isPierced;
		}
		
		public function set isPierced(value:Boolean):void 
		{
			_isPierced = value;
		}
		
		/*
		public function get pierceType():PiercingTypesEnum 
		{
			return _pierceType;
		}
		
		public function set pierceType(value:PiercingTypesEnum):void 
		{
			_pierceType = value;
		}
		*/

		//{ region Getter/Setters
		public function get pShortDesc():String 
		{
			return _pShortDesc;
		}
		
		public function set pShortDesc(value:String):void 
		{
			_pShortDesc = value;
		}
		
		public function get pLongDesc():String 
		{
			return _pLongDesc;
		}
		
		public function set pLongDesc(value:String):void 
		{
			_pLongDesc = value;
		}
		
		public function get sock():String 
		{
			return _sock;
		}
		
		public function set sock(value:String):void 
		{
			_sock = value;
		}
		
		public function get pierced():Number 
		{
			return _pierced;
		}
		
		public function set pierced(value:Number):void 
		{
			_pierced = value;
		}
		//} endregion

	}
}