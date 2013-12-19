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

			if ((value == "" || value == null) && quantity != 0 && CoC_Settings.haltOnErrors == true)
			{
				throw new Error("Item name set without a value!")
			}

			_shortName = value;
		}

		public function placeItemWQuantity(quant:Number, sName:String):void
		{
			this.quantity = quant;
			this._shortName = sName;
		}
		

		public function emptySlot():void
		{
			this.quantity = 0;
			this.shortName = "";
		}

		public function removeOneItem():void
		{
			if ((this.quantity == 0) && CoC_Settings.haltOnErrors == true)
				throw new Error("Tried to remove item from empty slot!")
			if (this.quantity > 0)
				this.quantity -= 1;

			if (this.quantity == 0)
				this.shortName = "";
		}

		public function get shortName():String
		{
			return _shortName;
		}

	}
}