/**
 * Coded by aimozg on 29.09.2017.
 */
package coc.view {
import classes.BaseContent;
import classes.GlobalFlags.kGAMECLASS;
import classes.PerkLib;

public class ButtonData {
	public var text:String = "";
	public var callback:Function = null;
	public var enabled:Boolean = false;
	public var visible:Boolean = true;
	public var toolTipHeader:String = "";
	public var toolTipText:String = "";
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
	public function disable(toolTipText:String=null,toolTipHeader:String=null):ButtonData {
		this.enabled = false;
		if (toolTipText is String) this.toolTipText = toolTipText;
		if (toolTipHeader is String) this.toolTipHeader = toolTipHeader;
		return this;
	}
	public function disableIf(condition:Boolean,toolTipText:String=null,toolTipHeader:String=null):ButtonData {
		if (this.enabled && condition) {
			disable(toolTipText,toolTipHeader);
		}
		return this;
	}
	public function applyTo(btn:CoCButton):void {
		if (!visible) {
			btn.hide();
		} else if (!enabled) {
			btn.showDisabled(text, toolTipText, toolTipHeader);
		} else {
			btn.show(text, callback, toolTipText, toolTipHeader);
		}
	}
	/**
	 * Adds a Soulforce requirement hint, and disables if player has not enough.
	 * DOES NOT apply any scale modifiers
	 * DOES NOT decrease soulforce if clicked
	 */
	public function requireSoulforce(cost:Number):ButtonData {
		toolTipText += "\nSoulforce cost: "+cost;
		if (kGAMECLASS.player.soulforce < cost) {
			disable();
			toolTipText += " <b>You are too tired to use this ability.</b>";
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
		if (kGAMECLASS.player.lust < cost) {
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
		toolTipText += "\nLust cost: "+cost;
		if (kGAMECLASS.player.wrath < cost) {
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
		if (!(allowBloodMage && kGAMECLASS.player.hasPerk(PerkLib.BloodMage))
			&& kGAMECLASS.player.mana < cost) {
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
		if (!(allowBloodMage && kGAMECLASS.player.hasPerk(PerkLib.BloodMage))
			&& kGAMECLASS.player.fatigueLeft() < cost) {
			disable();
			toolTipText += " <b>You are too tired to use this ability.</b>";
		}
		return this;
	}
}
}
