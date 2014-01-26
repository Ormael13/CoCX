package classes
{
	public class PerkClass
	{
		//constructor
		public function PerkClass(perk:PerkType)
		{
			_ptype = perk;
		}
		//data
		private var _ptype:PerkType;
		public var value2:Number = 0;
		public var value1:Number = 0;
		public var value3:Number = 0;
		public var value4:Number = 0;
		public var modDesc:String = "";
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
			return (modDesc != "") ? modDesc : _ptype.desc;
		}
	}
}