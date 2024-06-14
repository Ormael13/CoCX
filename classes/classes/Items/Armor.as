/**
 * Created by aimozg on 10.01.14.
 */
package classes.Items
{
import classes.PerkLib;

import coc.view.IconLib;

public class Armor extends Equipable
	{
		private var _def:Number;
		private var _mdef:Number;
		private var _perk:String;
		private var _supportsBulge:Boolean;
		private var _supportsUndergarment:Boolean;
		
		override public function get category():String {
			return CATEGORY_ARMOR;
		}
		
		public function Armor(id:String, shortName:String, name:String, longName:String, def:Number, mdef:Number, value:Number = 0, description:String = null, perk:String = "", supportsBulge:Boolean = false, supportsUndergarment:Boolean = true) {
			super(id, shortName, name, longName, value, description);
			this._def = def;
			this._mdef = mdef;
			this._perk = perk;
			_supportsBulge = supportsBulge;
			_supportsUndergarment = supportsUndergarment;
		}
		
		private static const SLOTS:Array = [SLOT_ARMOR];
		override public function slots():Array {
			return SLOTS; // don't recreate every time
		}
		
		override public function get iconId():String {
			return IconLib.pickIcon(ownIconId, "I_GenericArmor_"+perk, super.iconId);
		}
		
		public function get def():Number { return _def; }
		
		public function get mdef():Number { return _mdef; }
		
		public function get perk():String { return _perk; }
		
		public function get supportsBulge():Boolean { return _supportsBulge && game.player.modArmorName == ""; }
			//For most clothes if the modArmorName is set then it's Exgartuan's doing. The comfortable clothes are the exception, they override this function.
		
		public function get supportsUndergarment():Boolean { return _supportsUndergarment; }
		
		
		override public function effectDescriptionParts():Array {
			var list:Array = super.effectDescriptionParts();
			// Type
			var type:String;
			var name:String = this.name.toLowerCase();
			if (name.indexOf("armor") >= 0 || name.indexOf("armour") >= 0 || name.indexOf("chain") >= 0 || name.indexOf("mail") >= 0 || name.indexOf("plates") >= 0) {
				type = "Armor ";
				if (perk == "Light" || perk == "Medium") {
					type += "(Light)";
				}
				else if (perk == "Medium") type += "(Medium)";
				else if (perk == "Heavy") type += "(Heavy)";
				else if (perk == "Light Ayo") type += "(Light Ayo)";
				else if (perk == "Heavy Ayo") type += "(Heavy Ayo)";
				else if (perk == "Ultra Heavy Ayo") type += "(Ultra Heavy Ayo)";
			} else type = "Clothing ";
			list.push([10,"Type: "+type]);
			// Defense
			if (def > 0) list.push([20, "Defense (P): " + def]);
			if (mdef > 0) list.push([30, "Defense (M): " + mdef]);
			return list;
		}
		
		override public function canEquip(doOutput:Boolean):Boolean {
			if (!this.supportsUndergarment && (!game.player.upperGarment.isNothing || !game.player.lowerGarment.isNothing)) {
				var output:String = "";
				var wornUpper:Boolean = false;
				output += "It would be awkward to put on " + longName + " when you're currently wearing ";
				if (!game.player.upperGarment.isNothing) {
					output += game.player.upperGarment.longName;
					wornUpper = true;
				}
				if (!game.player.lowerGarment.isNothing) {
					if (wornUpper) {
						output += " and ";
					}
					output += game.player.lowerGarment.longName;
				}
				output += ". You should consider removing them. You put it back into your inventory.";
				if(doOutput) outputText(output);
				return false;
			}
			else if (game.player.hasPerk(PerkLib.Rigidity)) {
				if (doOutput) outputText("You would very like to equip this item but your body stiffness prevents you from doing so.");
				return false;
			}
			return super.canEquip(doOutput);
		}
		
		override public function afterEquip(doOutput:Boolean):void {
			super.afterEquip(doOutput);
			if (!game.isLoadingSave) {
				game.player.addToWornClothesArray(this);
			}
		}
		override public function afterUnequip(doOutput:Boolean):void {
			super.afterUnequip(doOutput);
			game.player.removePerk(PerkLib.BulgeArmor); //Exgartuan check
			if (game.player.modArmorName.length > 0) game.player.modArmorName = "";
		}
		
		
		override public function getItemText(textid:String):String {
			if (textid == "legendary_fail") return "You try to equip the legendary armor, but to your disappointment the item simply refuses to stay on your body. It seems you still lack the right to wear this item.";
			return super.getItemText(textid);
		}
	}
}
