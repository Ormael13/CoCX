package classes
{
	public class ItemSlotClass extends Object
	{
		//constructor
		public function ItemSlotClass()
		{
		}
		
		//data
		private var _quantity:Number = 0;
		private var _itype:ItemType = ItemType.NOTHING;
		private var _unlocked:Boolean = false;

		
		public function setItemAndQty(itype:ItemType, quant:Number):void
		{
			if (itype == null) itype = ItemType.NOTHING;
			if (quant == 0 && itype == ItemType.NOTHING) {
				emptySlot();
				return;
			}
			if (quant<0 || quant == 0 && itype != ItemType.NOTHING || quant>0 && itype == ItemType.NOTHING){
				CoC_Settings.error("Inconsistent setItemAndQty call: "+quant+" "+itype);
				quant = 0;
				itype = ItemType.NOTHING;
			}
			this._quantity = quant;
			this._itype = itype;
		}
		

		public function emptySlot():void
		{
			this._quantity = 0;
			this._itype = ItemType.NOTHING;
		}

		public function removeOneItem():void
		{
			if (this._quantity == 0)
				CoC_Settings.error("Tried to remove item from empty slot!");
			if (this._quantity > 0)
				this._quantity -= 1;

			if (this._quantity == 0)
				this._itype = ItemType.NOTHING;
		}

		public function get quantity():Number
		{
			return _quantity;
		}

		public function set quantity(value:Number):void
		{
			if (value > 0 && _itype == null) CoC_Settings.error("ItemSlotClass.quantity set with no item; use setItemAndQty instead!");
			if (value == 0) _itype = ItemType.NOTHING;
			_quantity = value;
		}

		public function get itype():ItemType
		{
			return _itype;
		}

		public function get unlocked():Boolean
		{
			return _unlocked;
		}

		public function set unlocked(value:Boolean):void
		{
			if (_unlocked != value){
				emptySlot();
			}
			_unlocked = value;
		}

		public function isEmpty():Boolean
		{
			return _quantity<=0;
		}
	}
}