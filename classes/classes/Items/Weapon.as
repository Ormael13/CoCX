/**
 * Created by aimozg on 09.01.14.
 */
package classes.Items
{

import classes.GlobalFlags.kFLAGS;
import classes.PerkLib;
import classes.Scenes.SceneLib;

public class Weapon extends Useable //Equipable
	{
		private var _verb:String;
		private var _attack:Number;
		private var _perk:String;
		private var _type:String;
		private var _name:String;
		
		public function Weapon(id:String, shortName:String, name:String,longName:String, verb:String, attack:Number, value:Number = 0, description:String = null, perk:String = "", type:String = "") {
			super(id, shortName, longName, value, description);
			this._name = name;
			this._verb = verb;
			this._attack = attack;
			this._perk = perk;
			this._type = type;
		}
		
		public function get verb():String { return _verb; }
		
		public function get attack():Number { return _attack; }
		
		public function get perk():String { return _perk; }

		public function get type():String { return _type; }
		
		public function get name():String { return _name; }
		
		public function get descBase():String { return _description; }
		
		override public function get description():String {
			var desc:String = descBase;
			//Type
			desc += "\n\nType: Melee Weapon";
			if (type != "") {
				desc += "\nWeapon Class: " + type;
			}
			if (perk != "") {
				desc += "\nSpecials: " + specInterpret(perk);
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

		public function specInterpret(perkList:String = ""):String{
			var temp:Array = perkList.split(", ");
			var specTrans:Array = []
			var result:String = ""
			specTrans.push("Stun10", "+10% Stun");
			specTrans.push("Stun15", "+15% Stun");
			specTrans.push("Stun20", "+20% Stun");
			specTrans.push("Stun25", "+25% Stun");
			specTrans.push("Stun30", "+30% Stun");
			specTrans.push("Stun40", "+40% Stun");
			specTrans.push("Stun50", "+50% Stun");
			specTrans.push("Bleed10", "+10% Bleed");
			specTrans.push("Bleed25", "+25% Bleed");
			specTrans.push("Bleed45", "+45% Bleed");
			specTrans.push("Bleed100", "+100% Bleed");
			specTrans.push("LGWrath", "Low Grade Wrath");
			specTrans.push("MGWrath", "Mid Grade Wrath");

			for each (var spec:String in temp){
				if (specTrans.indexOf(spec) >= 0){
					result += specTrans[specTrans.indexOf(spec) + 1];
				}
				else{
					result += spec;
				}
				result += ", ";
			}
			return result.slice(0, -2);
		}
		
		override public function useText():void {
			outputText("You equip " + longName + ".  ");
		}
		
		override public function canUse():Boolean {
			if ((perk == "Large" && game.player.shield != ShieldLib.NOTHING && !game.player.hasPerk(PerkLib.GigantGrip)) || (perk == "Massive" && game.player.shield != ShieldLib.NOTHING)) {
				outputText("Because this weapon requires the use of two hands, you have unequipped your shield. ");
				SceneLib.inventory.unequipShield();
				return false;
			}
			else if ((perk == "Dual Large" || perk == "Dual" || perk == "Dual Small") && game.player.shield != ShieldLib.NOTHING) {
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
		
		public function playerEquip():Weapon { //This item is being equipped by the player. Add any perks, etc. - This function should only handle mechanics, not text output
			var temp:Array = perk.split(", ");
			var temp2:Array = ["Large", "Massive", "Dual", "Dual Large", "Dual Small"]
			for each (var temp3:String in temp2){
				if (temp.indexOf(temp3) >= 0 && game.player.shield != ShieldLib.NOTHING){
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
			return this;
		}
		
		public function playerRemove():Weapon { //This item is being removed by the player. Remove any perks, etc. - This function should only handle mechanics, not text output
			return this;
		}
		
		public function removeText():void {} //Produces any text seen when removing the armor normally
	}
}