package classes
{
	public class PerkClass
	{
		//constructor
		public function PerkClass(perk:PerkType,value1:Number=0,value2:Number=0,value3:Number=0,value4:Number=0)
		{
			_ptype = perk;
			this.value1 = value1;
			this.value2 = value2;
			this.value3 = value3;
			this.value4 = value4;
		}
		//data
		private var _ptype:PerkType;
		public var value1:Number;
		public var value2:Number;
		public var value3:Number;
		public var value4:Number;
		//MEMBER FUNCTIONS


		public function get ptype():PerkType
		{
			return _ptype;
		}

		public function get perkName():String
		{
			return _ptype.name;
		}

		public function get perkDesc():String
		{
			return _ptype.desc(this);
		}

		public function get perkLongDesc():String
		{
			return _ptype.longDesc;
		}
	}
}