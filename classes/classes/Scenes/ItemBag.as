package classes.Scenes {
import classes.BaseContent;
import classes.ItemType;

public class ItemBag extends BaseContent {
	public var Slots:/*int*/Array = [];
	public var SlotCaps:/*int*/Array = [];
	public var SlotCount:int;
	public var itemTypes:/*ItemType*/Array;
	private static var itemIdToSlotIndex:Object = {};
	
	/**
	 * @param itemTypes Slot item types. Must be unique (except null/nothing)
	 * @param slotCount Number of slots, 0 = same as items in slotDefs
	 */
	public function ItemBag(itemTypes:/*ItemType*/Array, slotCount:int=0) {
		this.itemTypes = itemTypes;
		this.SlotCount = Math.max(slotCount, itemTypes.length);
		for (var i:int = 0; i < itemTypes.length; i++) {
			var itype:ItemType = itemTypes[i];
			if (itype && !itype.isNothing) itemIdToSlotIndex[itype.id] = i;
		}
		for (i = itemTypes.length; i < SlotCount; i++) itemTypes[i] = ItemType.NOTHING;
		resetState();
	}
	
	public function resetState():void {
		for (var i:int = 0; i < SlotCount; i++) {
			Slots[i] = 0;
			SlotCaps[i] = 0;
		}
	}
	
	
	/** item type stored in slot */
	public function slotType(slot:int):ItemType {
		if (slot < 0 || slot > itemTypes.length) return ItemType.NOTHING;
		return itemTypes[slot];
	}
	/** slot for item type, -1 if no item */
	public function slotForItem(itype:ItemType):int {
		if (itype.id in itemIdToSlotIndex) return itemIdToSlotIndex[itype.id];
		return -1;
	}
	/** current number of items of that type stored in loot bag */
	public function itemCount(itype:ItemType):int {
		var slot:int = slotForItem(itype);
		if (slot < 0) return 0;
		return Slots[slot];
	}
	/** current slot cap for item type, 0 if no such item */
	public function itemCap(itype:ItemType):int {
		var slot:int = slotForItem(itype);
		if (slot < 0) return 0;
		return SlotCaps[slot];
	}
	public function setItemCap(itype:ItemType, cap:int):Boolean {
		var slot:int = slotForItem(itype);
		if (slot < 0) return false;
		SlotCaps[slot] = cap;
		return true;
	}
	/** try to remove items from loot bag, return number of remvoed items (0 if no such item) */
	public function removeItem(itype:ItemType, n:int):int {
		if (n <= 0) return 0;
		var slot:int = slotForItem(itype);
		if (slot < 0) return 0;
		n = Math.min(Slots[slot], n);
		Slots[slot] -= n;
		return n;
	}
	/** try to add items to loot bag, return number of items added (0 if no such item or no place) */
	public function addItem(itype:ItemType, n:int):int {
		if (n <= 0) return 0;
		var slot:int = slotForItem(itype);
		if (slot < 0) return 0;
		n = boundInt(0, n, SlotCaps[slot] - Slots[slot]);
		Slots[slot] += n;
		return n;
	}
	
	public function saveToObject():Object {
		return {
			Slots: Slots.slice(),
			SlotCaps: SlotCaps.slice()
		}
	}
	
	public function loadFromObject(o:Object, ignoreErrors:Boolean):void {
		if (o) {
			if ("Slots" in o) {
				// new version
				Slots = o["Slots"].slice();
				SlotCaps = o["SlotCaps"].slice();
				while (Slots.length < SlotCount) Slots.push(0);
				while (SlotCaps.length < SlotCount) SlotCaps.push(0);
			} else if ("Slot01" in o) {
				// old version: "Slot01".."Slot30", "Slot01Cap".."Slot30Cap"
				for (var i:int = 0; i < SlotCount; i++) {
					var s:String = padStart(String(i + 1), 2, "0");
					Slots[i]     = numberOr(o["Slot" + s], 0);
					SlotCaps[i]  = numberOr(o["Slot" + s + "Cap"], 0);
				}
			} else {
				resetState();
			}
		} else {
			// loading from old save
			resetState();
		}
	}
}
}
