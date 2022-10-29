/**
 * Coded by aimozg on 29.09.2017.
 */
package coc.view {
import classes.CoC;
import classes.ItemSlotClass;
import classes.ItemType;
import classes.PerkLib;
import classes.StatusEffects;
import classes.internals.Utils;

public class ButtonData {
	public var text:String = "";
	public var callback:Function = null;
	public var enabled:Boolean = false;
	public var visible:Boolean = true;
	public var toolTipHeader:String = "";
	public var toolTipText:String = "";
	public var labelColor:String = CoCButton.DEFAULT_COLOR;
	public var extraData:* = null;
	public var draggable:Boolean = false;
	public var slot:ItemSlotClass = null;
	public var slotType:Function;
	public var iconId:String = null;
	public function ButtonData(text:String, callback:Function =null, toolTipText:String ="", toolTipHeader:String ="") {
		this.text = text;
		this.callback = callback;
		this.enabled = callback != null;
		this.toolTipText = toolTipText;
		this.toolTipHeader = toolTipHeader;
	}
	public function hint(toolTipText:String,toolTipHeader:String=""):ButtonData {
		this.toolTipText = toolTipText;
		this.toolTipHeader = toolTipHeader;
		return this;
	}
	public function enable(callback:Function,toolTipText:String=null,toolTipHeader:String=null):ButtonData {
		this.callback = callback;
		this.enabled = callback != null;
		if (toolTipText is String) this.toolTipText = toolTipText;
		if (toolTipHeader is String) this.toolTipHeader = toolTipHeader;
		return this;
	}
	public function disable(toolTipText:String=null,toolTipHeader:String=null, text:String = null):ButtonData {
		this.enabled = false;
		if (toolTipText is String) this.toolTipText = toolTipText;
		if (toolTipHeader is String) this.toolTipHeader = toolTipHeader;
		if (text is String) this.text = text;
		return this;
	}
	public function disableIf(condition:Boolean,toolTipText:String=null,toolTipHeader:String=null, text:String = null):ButtonData {
		if (condition) {
			disable(toolTipText,toolTipHeader, text);
		}
		return this;
	}
	public function color(color:String):ButtonData {
		labelColor = color;
		return this;
	}
	public function icon(iconId:String):ButtonData {
		this.iconId = iconId;
		return this;
	}
	
	/**
	 * Associate custom data with the button.
	 */
	public function extra(extraData:*):ButtonData {
		this.extraData = extraData;
		return this;
	}
	public function forItem(item:ItemType):ButtonData {
		text = item.shortName;
		hint(item.description, Utils.capitalizeFirstLetter(item.longName));
		labelColor = item.buttonColor;
		iconId = item.iconId;
		return this;
	}
	public function forItemSlot(slot:ItemSlotClass):ButtonData {
		if (slot.isEmpty()) {
			text = "Empty";
			hint("");
			labelColor = CoCButton.DEFAULT_COLOR;
			return this;
		}
		forItem(slot.itype);
		if (slot.itype.stackSize > 1 || slot.quantity > 1) text += " x"+slot.quantity;
		return this;
	}
	public function applyTo(btn:CoCButton):void {
		if (!visible) {
			btn.hide();
		} else {
			btn.show(text, callback, toolTipText, toolTipHeader)
					.color(labelColor)
					.disableIf(!enabled)
					.icon(iconId);
		}
	}
	/**
	 * Adds a Soulforce requirement hint, and disables if player has not enough.
	 * DOES NOT apply any scale modifiers
	 * DOES NOT decrease soulforce if clicked
	 */
	public function requireSoulforce(cost:Number):ButtonData {
		toolTipText += "\nSoulforce cost: "+cost;
		if (!CoC.instance.player.hasStatusEffect(StatusEffects.BloodCultivator) && CoC.instance.player.soulforce < cost) {
			disable();
			toolTipText += " <b>Your soulforce is too low to cast this..</b>";
		}
		return this;
	}
	/**
	 * Adds a Lust requirement hint, and disables if player has not enough.
	 * DOES NOT apply any scale modifiers
	 * DOES NOT decrease lust if clicked
	 */
	public function requireLust(cost:Number):ButtonData {
		toolTipText += "\nLust cost: "+cost;
		if (CoC.instance.player.lust < cost) {
			disable();
			toolTipText += " <b>You are not horny enough to use this ability.</b>";
		}
		return this;
	}
	/**
	 * Adds a Wrath requirement hint, and disables if player has not enough.
	 * DOES NOT apply any scale modifiers
	 * DOES NOT decrease wrath if clicked
	 */
	public function requireWrath(cost:Number):ButtonData {
		toolTipText += "\nWrath cost: "+cost;
		if (CoC.instance.player.wrath < cost) {
			disable();
			toolTipText += " <b>Your wrath is too low to use this ability!</b>";
		}
		return this;
	}
	/**
	 * Adds a Mana requirement hint, and disables if player has not enough.
	 * DOES NOT apply any scale modifiers
	 * DOES NOT decrease mana if clicked
	 * @param allowBloodMage Do not disable button if player has Blood Mage perk
	 */
	public function requireMana(cost:Number, allowBloodMage:Boolean = false):ButtonData {
		toolTipText += "\nMana cost: "+cost;
		if (!(allowBloodMage && CoC.instance.player.hasPerk(PerkLib.BloodMage) && CoC.instance.player.hasStatusEffect(StatusEffects.BloodMage))
			&& CoC.instance.player.mana < cost) {
			disable();
			toolTipText += " <b>Your mana is too low to cast this.</b>";
		}
		return this;
	}
	/**
	 * Adds a Fatigue requirement hint, and disables if player has not enough.
	 * DOES NOT apply any scale modifiers
	 * DOES NOT decrease fatigue if clicked
	 * @param allowBloodMage Do not disable button if player has Blood Mage perk
	 */
	public function requireFatigue(cost:Number, allowBloodMage:Boolean = false):ButtonData {
		toolTipText += "\nFatigue cost: "+cost;
		if (!(allowBloodMage && CoC.instance.player.hasPerk(PerkLib.BloodMage))
			&& CoC.instance.player.fatigueLeft() < cost) {
			disable();
			toolTipText += " <b>You are too tired to use this ability.</b>";
		}
		return this;
	}

	/**
	 *
	 */
	public function drag(slot:ItemSlotClass, slotType:Function):ButtonData {
		this.draggable = true;
		this.slot = slot;
		this.slotType = slotType;
		return this;
	}
}
}
