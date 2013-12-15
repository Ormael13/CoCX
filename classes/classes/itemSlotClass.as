package classes
{
	public class itemSlotClass extends Object
	{
		//constructor
		public function itemSlotClass()
		{
		}
		
		//data
		public var quantity:Number = 0;
		public var _shortName:String = "";
		public var unlocked:Boolean = false;
		
		public function set shortName(value:String):void
		{

			if ((value == "" || value == null || value == undefined) && quantity != 0 && CoC_Settings.haltOnErrors == true)
			{
				throw new Error("Item name set without a value!")
			}

			_shortName = value;
		}

		public function get shortName():String
		{
			return _shortName;
		}

	}
}