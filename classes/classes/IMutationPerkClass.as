package classes
{
	public class IMutationPerkClass
	{
		//constructor
		public function IMutationPerkClass(perk:IMutationPerkType, value1:Number=0, value2:Number=0, value3:Number=0, value4:Number=0)
		{
			_mtype = perk;
			this.value1 = value1;
			this.value2 = value2;
			this.value3 = value3;
			this.value4 = value4;
		}
		//data
		private var _mtype:IMutationPerkType;
		public var value1:Number;
		public var value2:Number;
		public var value3:Number;
		public var value4:Number;
		//MEMBER FUNCTIONS


		public function get mtype():IMutationPerkType
		{
			return _mtype;
		}

		public function get mutationName():String
		{
			return _mtype.name(this);
		}

		public function get mutationDesc():String
		{
			return _mtype.desc(this);
		}

		public function get mutationLongDesc():String
		{
			return _mtype.longDesc;
		}
	}
}
