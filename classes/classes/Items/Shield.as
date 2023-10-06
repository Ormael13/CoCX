/**
 * Created by Kitteh6660 on 01.29.15.
 */
package classes.Items
{
	/**
	 * ...
	 * @author Kitteh6660
	 */
	import classes.ItemType;
	import classes.PerkLib;
	import classes.Player;
	import classes.Scenes.SceneLib;
	import classes.GlobalFlags.kFLAGS
	
public class Shield extends Equipable
	{
		private var _block:Number;
		private var _perk:String;
		
		override public function get category():String {
			return CATEGORY_SHIELD;
		}
		
		public function Shield(id:String, shortName:String, name:String, longName:String, block:Number, value:Number = 0, description:String = null, perk:String = "") {
			super(id, shortName, name, longName, value, description);
			this._block = block;
			this._perk = perk;
		}
		
		private static const SLOTS:Array = [SLOT_SHIELD];
		override public function slots():Array {
			return SLOTS; // don't recreate every time
		}
		
		public function get block():Number { return _block; }
		
		public function get perk():String { return _perk; }
		
		override public function get description():String {
			var desc:String = _description;
			//Type
			desc += "\n\nType: Shield";
            if (perk != "") desc += " (" + perk + ")";
			//Block Rating
			desc += "\nBlock: " + String(block);
			//Value
			desc += "\nBase value: " + String(value);
			return desc;
		}
		
		
		override public function canEquip(doOutput:Boolean):Boolean {
			if (game.player.weaponRangePerk == "Dual Firearms" || game.player.weaponRangePerk == "Dual 2H Firearms") {
				if (doOutput) outputText("Your current range weapons requires two hands. Unequip your current range weapons or switch to one-handed before equipping this shield. ");
				return false;
			}
			else if (game.player.weaponRangePerk == "2H Firearm") {
				if (doOutput) outputText("Your current range weapon requires two hands. Unequip your current range weapon or switch to one-handed before equipping this shield. ");
				return false;
			}
			else if ((game.player.weaponSpecials("Large") && !game.player.hasPerk(PerkLib.GigantGrip)) || (game.player.weaponSpecials("Massive") && !game.player.hasPerk(PerkLib.TitanGrip))
					|| game.player.weaponSpecials("Dual Small") || game.player.weaponSpecials("Dual") || game.player.weaponSpecials("Dual Large") || game.player.weaponSpecials("Dual Massive") || game.player.weaponName == "Daisho") {
				if (doOutput) outputText("Your current melee weapon requires two hands. Unequip your current melee weapon or switch to one-handed before equipping this shield. ");
				return false;
			}
			else if (game.player.hasPerk(PerkLib.Rigidity)) {
				if (doOutput) outputText("You would very like to equip this item but your body stiffness prevents you from doing so.");
				return false;
			}
			else if (game.player.shieldPerk == "Massive" && !game.player.hasPerk(PerkLib.GigantGrip)) {
				if (doOutput) outputText("This shield requires use of both hands. Unequip your current melee weapon before equipping it. ");
				return false;
			}
			return super.canEquip(doOutput);
		}
		
		override public function afterEquip(doOutput:Boolean):void {
			if (!game.isLoadingSave) {
				if ((perk == "Massive" && game.player.weapon != WeaponLib.FISTS && !game.player.hasPerk(PerkLib.GigantGrip))
						|| (game.player.weaponSpecials("Large") && !game.player.hasPerk(PerkLib.GigantGrip))
						|| (game.player.weaponSpecials("Massive") && !game.player.hasPerk(PerkLib.TitanGrip))
						|| game.player.weaponSpecials("Dual Small")
						|| game.player.weaponSpecials("Dual")
						|| game.player.weaponSpecials("Dual Large")
						|| game.player.weaponSpecials("Dual Massive")) {
					SceneLib.inventory.unequipWeapon();
				}
				if (game.player.weaponRangePerk == "Dual Firearms" || game.player.weaponRangePerk == "2H Firearm" || game.player.weaponRangePerk == "Dual 2H Firearms") SceneLib.inventory.unequipWeaponRange();
			}
			super.afterEquip(doOutput);
		}
	}
}
