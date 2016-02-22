package classes
{
	public class StatusEffectClass
	{
		//constructor
		public function StatusEffectClass(stype:StatusEffectType,value1:Number=0,value2:Number=0,value3:Number=0,value4:Number=0)
		{
			this._stype = stype;
			this.value1 = value1;
			this.value2 = value2;
			this.value3 = value3;
			this.value4 = value4;
		}
		//data
		private var _stype:StatusEffectType;
		public var value1:Number;
		public var value2:Number;
		public var value3:Number;
		public var value4:Number;
		//MEMBER FUNCTIONS
		public function get stype():StatusEffectType
		{
			return _stype;
		}

		public function toString():String
		{
			return "["+_stype+","+value1+","+value2+","+value3+","+value4+"]";
		}
	}
}