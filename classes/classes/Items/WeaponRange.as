/**
 * ...
 * @author Ormael
 */
package classes.Items
{

import classes.PerkLib;
import classes.Scenes.SceneLib;

import coc.view.IconLib;

public class WeaponRange extends Equipable
	{
		private var _verb:String;
		private var _attack:Number;
		private var _perk:String;
		
		override public function get category():String {
			return CATEGORY_WEAPON_RANGED;
		}
		
		public function WeaponRange(id:String, shortName:String, name:String,longName:String, verb:String, attack:Number, value:Number = 0, description:String = null, perk:String = "") {
			super(id, shortName, name, longName, value, description);
			this._verb = verb;
			this._attack = attack;
			this._perk = perk;
		}
		
		private static const SLOTS:Array = [SLOT_WEAPON_RANGED];
		override public function slots():Array {
			return SLOTS; // don't recreate every time
		}
		override public function get iconId():String {
			return IconLib.pickIcon(ownIconId, "I_GenericWeapon_"+perk, super.iconId);
		}
		
		public function get verb():String { return _verb; }
		
		public function get attack():Number { return _attack; }
		
		public function get perk():String { return _perk; }
		
		override public function get description():String {
			var desc:String = _description;
			//Type
			desc += "\n\nType: Range Weapon ";
			if (perk == "Bow") desc += "(Bow)";
			else if (perk == "Crossbow") desc += "(Crossbow)";
			else if (perk == "Pistol") desc += "(Pistol)";
			else if (perk == "Rifle") desc += "(Rifle)";
			else if (perk == "2H Firearm") desc += "(2H Firearm)";
			else if (perk == "Dual Firearms") desc += "(Dual Firearms)";
			else if (perk == "Dual 2H Firearms") desc += "(Dual 2H Firearms)";
			else if (perk == "Throwing") desc += "(Throwing)";
			else if (perk == "Tome") desc += "(Tome)";
			//Attack
			desc += "\nRange Attack: " + String(attack);
			//Value
			desc += "\nBase value: " + String(value);
			return desc;
		}
		
		override public function canEquip(doOutput:Boolean):Boolean {
			if (game.player.hasPerk(PerkLib.Rigidity)) {
				if (doOutput) outputText("You would very like to equip this item but your body stiffness prevents you from doing so.");
				return false;
			}
			return super.canEquip(doOutput);
		}
		
		override public function beforeEquip(doOutput:Boolean):Equipable {
			if (perk == "2H Firearm") {
				if (doOutput) outputText("Because this weapon requires the use of two hands, you have unequipped your shield. ");
				SceneLib.inventory.unequipShield();
			}
			if (perk == "Dual Firearms") {
				if (doOutput) outputText("Because those weapons requires the use of two hands, you have unequipped your shield. ");
				SceneLib.inventory.unequipShield();
			}
			return super.beforeEquip(doOutput);
		}
	}
}
