/**
 * ...
 * @author Ormael
 */
package classes.Items
{

import classes.ItemType;
import classes.PerkLib;
import classes.Player;
import classes.Scenes.SceneLib;

public class WeaponRange extends Useable //Equipable
	{
		private var _verb:String;
		private var _attack:Number;
		private var _perk:String;
		private var _name:String;
		
		public function WeaponRange(id:String, shortName:String, name:String,longName:String, verb:String, attack:Number, value:Number = 0, description:String = null, perk:String = "") {
			super(id, shortName, longName, value, description);
			this._name = name;
			this._verb = verb;
			this._attack = attack;
			this._perk = perk;
		}
		
		public function get verb():String { return _verb; }
		
		public function get attack():Number { return _attack; }
		
		public function get perk():String { return _perk; }
		
		public function get name():String { return _name; }
		
		override public function get description():String {
			var desc:String = _description;
			//Type
			desc += "\n\nType: Range Weapon ";
			if (perk == "Bow") desc += "(Bow)";
			else if (perk == "Crossbow") desc += "(Crossbow)";
			else if (perk == "Pistol") desc += "(Pistol)";
			else if (perk == "Rifle") desc += "(Rifle)";
			else if (perk == "2H Firearm") desc += "(2H Firearm)";
			else if (verb == "Dual Firearms") desc += "(Dual Firearms)";
			else if (perk == "Throwing") desc += "(Throwing)";
		//	else if (verb == "slash" || verb == "keen cut") desc += "(Sword)";
		//	else if (name.indexOf("staff") >= 0) desc += "(Staff)";
			//Attack
			desc += "\nRange Attack: " + String(attack);
			//Value
			desc += "\nBase value: " + String(value);
			return desc;
		}
		
		override public function useText():void {
			outputText("You equip " + longName + ".  ");
			if (perk == "2H Firearm") {
				outputText("Because this weapon requires the use of two hands, you have unequipped your shield. ");
			}
			if (perk == "Dual Firearms") {
				outputText("Because those weapons requires the use of two hands, you have unequipped your shield. ");
			}
		}
		
		override public function canUse():Boolean {
			if (game.player.hasPerk(PerkLib.Rigidity)) {
				outputText("You would very like to equip this item but your body stiffness prevents you from doing so.");
				return false;
			}
			return true;
		}
		
		public function playerEquip():WeaponRange { //This item is being equipped by the player. Add any perks, etc. - This function should only handle mechanics, not text output
			if (perk == "2H Firearm" && game.player.shield != ShieldLib.NOTHING
			|| (perk == "Dual Firearms" && game.player.shield != ShieldLib.NOTHING)) {
				SceneLib.inventory.unequipShield();
			}
			return this;
		}
		
		public function playerRemove():WeaponRange { //This item is being removed by the player. Remove any perks, etc. - This function should only handle mechanics, not text output
			return this;
		}
		
		public function removeText():void {} //Produces any text seen when removing the armor normally
		
	}
}