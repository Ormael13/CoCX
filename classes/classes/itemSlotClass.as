package classes
{
	public class itemSlotClass extends Object
	{
		//constructor
		public function itemSlotClass()
		{
		}
		
		public function CopyFrom(source:itemSlotClass):void
		{
			this.quantity = source.quantity;
			this.shortName = source.shortName;
			this.unlocked = source.unlocked;
		}
		
		//data
		public var quantity:Number = 0;
		public var shortName:String = "";
		public var unlocked:Boolean = false;
		
	}
}