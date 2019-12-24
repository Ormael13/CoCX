/**
 * Created by aimozg on 09.01.14.
 */
package classes.Items
{

import classes.PerkLib;
import classes.Scenes.SceneLib;

public class Weapon extends Useable //Equipable
	{
		private var _verb:String;
		private var _attack:Number;
		private var _perk:String;
		private var _name:String;
		
		public function Weapon(id:String, shortName:String, name:String,longName:String, verb:String, attack:Number, value:Number = 0, description:String = null, perk:String = "") {
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
			desc += "\n\nType: Melee Weapon ";
			if (perk == "Massive") desc += "(Massive)";
			else if (perk == "Large") desc += "(Large)";
			else if (perk == "Small") desc += "(Small)";
			else if (perk == "Staff") desc += "(Staff)";
			else if (perk == "Dual") desc += "(Dual)";
			else if (perk == "Dual Large") desc += "(Dual Large)";
			else if (perk == "Dual Small") desc += "(Dual Small)";
			else if (verb.indexOf("whip") >= 0) desc += "(Whip)";
			else if (verb.indexOf("punch") >= 0) desc += "(Gauntlet)";
			else if (verb == "slash" || verb == "keen cut") desc += "(Sword)";
			else if (verb == "stab") desc += "(Dagger)";
			else if (verb == "smash") desc += "(Blunt)";
			//Attack
			desc += "\nAttack: " + String(attack);
			//Value
			desc += "\nBase value: " + String(value);
			return desc;
		}
		
		override public function useText():void {
			outputText("You equip " + longName + ".  ");
			if ((perk == "Large" && game.player.shield != ShieldLib.NOTHING && game.player.findPerk(PerkLib.TitanGrip) < 0) || (perk == "Massive" && game.player.shield != ShieldLib.NOTHING)) {
				outputText("Because this weapon requires the use of two hands, you have unequipped your shield. ");
			}
		}
		
		override public function canUse():Boolean {
			if (game.player.hasPerk(PerkLib.Rigidity)) {
				outputText("You would very like to equip this item but your body stiffness prevents you from doing so.");
				return false;
			}
			return true;
		}
		
		public function playerEquip():Weapon { //This item is being equipped by the player. Add any perks, etc. - This function should only handle mechanics, not text output
			if ((perk == "Large" && game.player.shield != ShieldLib.NOTHING && game.player.findPerk(PerkLib.TitanGrip) < 0)
			|| (perk == "Massive" && game.player.shield != ShieldLib.NOTHING)
			|| (perk == "Dual" && game.player.shield != ShieldLib.NOTHING)
			|| (perk == "Dual Large" && game.player.shield != ShieldLib.NOTHING)
			|| (perk == "Dual Small" && game.player.shield != ShieldLib.NOTHING)) {
				SceneLib.inventory.unequipShield();
			}
			return this;
		}
		
		public function playerRemove():Weapon { //This item is being removed by the player. Remove any perks, etc. - This function should only handle mechanics, not text output
			return this;
		}
		
		public function removeText():void {} //Produces any text seen when removing the armor normally
		
/*
		override protected function equip(player:Player, returnOldItem:Boolean, output:Boolean):void
		{
			if (output) clearOutput();
			if (canUse(player,output)){
				var oldWeapon:Weapon = player.weapon;
				if (output) {
					outputText("You equip your " + name + ".  ");
				}
				oldWeapon.unequip(player, returnOldItem, output);
				player.setWeaponHiddenField(this);
				equipped(player,output);
			}
		}


		override public function unequip(player:Player, returnToInventory:Boolean, output:Boolean = false):void
		{
			if (returnToInventory) {
				var itype:ItemType = unequipReturnItem(player, output);
				if (itype != null) {
					if (output && itype == this)
						outputText("You still have " + itype.longName + " left over.  ");
					game.itemSwapping = true;
					game.inventory.takeItem(this, false);
				}
			}
			player.setWeaponHiddenField(WeaponLib.FISTS);
			unequipped(player,output);
		}
*/
	}
}
