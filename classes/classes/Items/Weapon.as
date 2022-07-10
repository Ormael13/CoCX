/**
 * Created by aimozg on 09.01.14.
 */
package classes.Items
{

import classes.GlobalFlags.kFLAGS;
import classes.PerkLib;
import classes.Scenes.SceneLib;

public class Weapon extends Equipable
	{
		private var _verb:String;
		private var _attack:Number;
		private var _perk:String;
		private var _type:String;
		private var _perks:Array;
		
		override public function get category():String {
			return CATEGORY_WEAPON_MELEE;
		}
		
		public function Weapon(id:String, shortName:String, name:String,longName:String, verb:String, attack:Number, value:Number = 0, description:String = null, perk:String = "", type:String = "") {
			super(id, shortName, name, longName, value, description);
			this._verb = verb;
			this._attack = attack;
			this._perk = perk;
			this._perks = perk ? perk.split(", ") : null;
			this._type = type;
		}
		
		private static const SLOTS:Array = [SLOT_WEAPON_MELEE];
		override public function slots():Array {
			return SLOTS; // don't recreate every time
		}
		
		public function get verb():String { return _verb; }
		
		public function get attack():Number { return _attack; }
		
		public function get perk():String { return _perk; }

		public function get type():String { return _type; }
		
		public function get descBase():String { return _description; }
		
		override public function get description():String {
			var desc:String = descBase;
			//Type
			desc += "\n\nType: Melee Weapon";
			if (type != "") {
				desc += "\nWeapon Class: " + type;
			}
			if (_perks) {
				desc += "\nSpecials: " + specInterpret();
			}
			/*else if (verb.indexOf("whip") >= 0) desc += "(Whip)";
			else if (verb.indexOf("punch") >= 0) desc += "(Gauntlet)";
			else if (verb == "slash" || verb == "keen cut") desc += "(Sword)";
			else if (verb == "stab") desc += "(Dagger)";
			else if (verb == "smash") desc += "(Blunt)";*/
			//Attack
			desc += "\nAttack: " + String(attack);
			//Value
			desc += "\nBase value: " + String(value);
			return desc;
		}

		public function hasSpecial(perk:String):Boolean {
			return _perks && _perks.indexOf(perk) >= 0;
		}
		
		public function specInterpret():String{
			var result:String = "";
			
			for (var i:int = 0; i < _perks.length; i++) {
				var spec:String = _perks[i];
				if (i > 0) result += ", ";
				result += WEAPON_PERK_NAMES[spec] || spec;
			}
			return result;
		}
		
		override public function canUse():Boolean {
			if (!game.player.weapon.isNothing && !game.player.weapon.canUnequip(true)) return false;
			if ((perk == "Large" && !game.player.shield.isNothing && !game.player.hasPerk(PerkLib.GigantGrip)) || (perk == "Massive" && !game.player.shield.isNothing)) {
				outputText("Because this weapon requires the use of two hands, you have unequipped your shield. ");
				SceneLib.inventory.unequipShield();
				return false;
			}
			else if ((perk == "Dual Large" || perk == "Dual" || perk == "Dual Small") && !game.player.shield.isNothing) {
				outputText("Because those weapons requires the use of two hands, you have unequipped your shield. ");
				SceneLib.inventory.unequipShield();
				return false;
			}
			else if (game.player.hasPerk(PerkLib.Rigidity)) {
				outputText("You would very like to equip this item but your body stiffness prevents you from doing so.");
				return false;
			}
			return true;
		}
		
		override public function beforeEquip(doOutput:Boolean):Equipable {
			var temp:Array = perk.split(", ");
			var temp2:Array = ["Large", "Massive", "Dual", "Dual Large", "Dual Small"]
			for each (var temp3:String in temp2){
				if (temp.indexOf(temp3) >= 0 && !game.player.shield.isNothing){
					if (temp3 == "Large") {
						if (game.player.hasPerk(PerkLib.GigantGrip)){
								break;
							}
						}
					SceneLib.inventory.unequipShield();
				}
			}/*
			if ((perk == "Large" && game.player.shield != ShieldLib.NOTHING && !game.player.hasPerk(PerkLib.GigantGrip))
			|| (perk == "Massive" && game.player.shield != ShieldLib.NOTHING)
			|| (perk == "Dual" && game.player.shield != ShieldLib.NOTHING)
			|| (perk == "Dual Large" && game.player.shield != ShieldLib.NOTHING)
			|| (perk == "Dual Small" && game.player.shield != ShieldLib.NOTHING)
			|| (game.player.shieldPerk == "Massive" && game.player.shield != ShieldLib.NOTHING && !game.player.hasPerk(PerkLib.GigantGrip))) {
				SceneLib.inventory.unequipShield();
			}*/
			if (game.flags[kFLAGS.FERAL_COMBAT_MODE] == 1) game.flags[kFLAGS.FERAL_COMBAT_MODE] = 0;
			return super.beforeEquip(doOutput);
		}
	}
}
