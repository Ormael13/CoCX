/**
 * ...
 * @author Ormael
 */
package classes.Items
{

import classes.CoC;
import classes.PerkLib;
import classes.Player;
import classes.Race;
import classes.Scenes.SceneLib;
import classes.Items.ItemConstants;

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
		
		public function get attack():Number {
			if (!CoC.instance || !CoC.instance.player) return _attack;
			var player:Player = CoC.instance.player;
			
			var baseAttackBonuss:Number = 0;
			var multiplier:Number = 100;
			var bonus:Number = 0;
			
			for each (var ie:ItemEffect in effectsFlagged(IEF_ATTACK)) {
				switch (ie.type) {
					//------------------------//
					// Multiplicative bonuses //
					//------------------------//
					case IELib.AttackMult_RaceTier: {
						multiplier += ie.power * player.racialTier(ie.value1 as Race);
						break;
					}
					//------------------//
					// Additive bonuses //
					//------------------//
					case IELib.AttackBonus_RaceTier: {
						bonus += ie.power * player.racialTier(ie.value1 as Race)
						break;
					}
				}
			}
			
			var attack:Number = (_attack + baseAttackBonuss) * multiplier / 100 + bonus;
			
			return attack;
		}
		
		public function get perk():String { return _perk; }
		
		public function hasSpecial(_special:String):Boolean {
			return perk.split(", ").indexOf(_special) >= 0;
		}
		
		override public function effectDescriptionParts():Array {
			var list:Array = super.effectDescriptionParts();
			// Type
			list.push([10,"Type: Range Weapon"]);
			if (perk != "") {
				list.push([15, "Weapon Class: " + perk]);
			}
			// Attack
			list.push([20,"Attack: "+attack]);
			return list;
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
		override public function getItemText(textid:String):String {
			if (textid == "legendary_fail") {
				var itemType:String = _perk;
				if ([ItemConstants.WT_PISTOL, ItemConstants.WT_RIFLE, ItemConstants.WT_2H_FIREARM, ItemConstants.WT_DUAL_FIREARMS, ItemConstants.WT_DUAL_2H_FIREARMS].indexOf(_perk) > -1) {
					itemType = "firearm";
				} else if (_perk == ItemConstants.WT_THROWING || !itemType) {
					itemType = "weapon";
				}
				
				return "You try to equip the legendary " + itemType.toLowerCase() +
						", but to your disappointment the item simply refuses to stay in your hands. It seems you still lack the right to wield this item.";
			}
			return super.getItemText(textid);
		}
	}
}
