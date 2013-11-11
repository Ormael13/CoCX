package classes
{
	public class keyItemClass extends Object
	{
		//constructor
		public function keyItemClass()
		{
		}
		
		public function CopyFrom(source:keyItemClass):void
		{
			this.keyName = source.keyName;
			this.value1 = source.value1;
			this.value2 = source.value2;
			this.value3 = source.value3;
			this.value4 = source.value4;
		}
		
		//data
		public var keyName:String = "";
		//v1-v4 for storing extra stuff.
		public var value1:Number = 0;
		public var value2:Number = 0;
		public var value3:Number = 0;
		public var value4:Number = 0;
	}
}