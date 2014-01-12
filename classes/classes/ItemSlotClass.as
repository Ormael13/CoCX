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
		private var _itype:ItemType = null;
		private var _unlocked:Boolean = false;

		public function get shortName():String{
			if (_itype == null) return "";
			return _itype.shortName;
		}
		public function get longName():String{
			if (_itype == null) return "";
			return _itype.longName;
		}
		public function get value():Number{
			if (_itype == null) return 0;
			return _itype.value;
		}
		public function get id():String{
			if (_itype == null) return "";
			return _itype.id;
		}

		
		public function setItemAndQty(itype:ItemType, quant:Number):void
		{
			if (quant<0 || quant == 0 && itype != null || quant>0 && itype == null){
				CoC_Settings.error("Inconsistent placeItemWQuantity call: "+quant+" "+itype);
				quant = 0;
				itype = null;
			}
			this._quantity = quant;
			this._itype = itype;
		}
		

		public function emptySlot():void
		{
			this._quantity = 0;
			this._itype = null;
		}

		public function removeOneItem():void
		{
			if (this._quantity == 0)
				CoC_Settings.error("Tried to remove item from empty slot!");
			if (this._quantity > 0)
				this._quantity -= 1;

			if (this._quantity == 0)
				this._itype = null;
		}

		public function get quantity():Number
		{
			return _quantity;
		}

		public function set quantity(value:Number):void
		{
			if (value == 0) _itype = null;
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
			return _quantity>0;
		}
	}
}