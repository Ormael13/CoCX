package classes
{
import classes.internals.Utils;

public class ItemSlotClass extends Object
	{
		// storage types (for determining stack size)
		public static const STORAGE_NORMAL:int = 0;
		public static const STORAGE_PEARL:int = 1;

		//constructor
		public function ItemSlotClass(storageType:int = STORAGE_NORMAL) {
			_storageType = storageType;
		}
		
		//data
		private var _quantity:Number = 0;
		private var _itype:ItemType = ItemType.NOTHING;
		private var _unlocked:Boolean = false;
		private var _storageType:int = STORAGE_NORMAL;

		public function clone():ItemSlotClass {
			var other:ItemSlotClass = new ItemSlotClass();
			other._quantity = _quantity;
			other._itype = _itype;
			other._unlocked = _unlocked;
			return other;
		}
		
		public function setItemAndQty(itype:ItemType, quant:Number):void
		{
			if (itype == null) itype = ItemType.NOTHING;
			if (quant == 0 && itype.isNothing) {
				emptySlot();
				return;
			}
			if (quant<0 || quant == 0 && !itype.isNothing || quant>0 && itype == ItemType.NOTHING){
				CoC_Settings.error("Inconsistent setItemAndQty call: "+quant+" "+itype);
				quant = 0;
				itype = ItemType.NOTHING;
			}
			if (quant > defaultStackSize()) CoC_Settings.error("Setting item quantity greater than the slot's maximum stack size!");
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
		/**
		 * Remove at most `count` items.
		 * @param count
		 * @return number of actual items removed
		 */
		public function removeMany(count:int):int {
			count = Utils.boundInt(0, count, _quantity);
			_quantity -= count;
			if (_quantity == 0) _itype = ItemType.NOTHING;
			return count;
		}

		public function get quantity():Number
		{
			return _quantity;
		}

		public function set quantity(value:Number):void
		{
			if (value > 0 && _itype == null) CoC_Settings.error("ItemSlotClass.quantity set with no item; use setItemAndQty instead!");
			if (value < 0) value = 0;
			if (value == 0) _itype = ItemType.NOTHING;
			if (value > stackSize()) CoC_Settings.error("Setting item quantity greater than its stack size!");
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

		public function get storageType():int
		{
			return _storageType;
		}

		// returns the stack size for the current *item*. That means, 1 for dynamic.
		// See also: `defaultStackSize()
		public function stackSize():int {
			return _itype.isNothing ? defaultStackSize() :
				_storageType == STORAGE_PEARL ? _itype.pearlStackSize : _itype.stackSize;
		}

		// returns the default stack size for the *storage*. Works for "nothing",
		public function defaultStackSize():int {
			return _storageType == STORAGE_PEARL ? ItemType.DEFAULT_PEARL_STACK_SIZE : ItemType.DEFAULT_STACK_SIZE;
		}

		// get available space
		public function roomLeft():int {
			return _itype.isNothing ? defaultStackSize() : stackSize() - _quantity;
		}
		
		public function hasRoom():Boolean {
			return roomLeft() > 0;
		}
	}
}
