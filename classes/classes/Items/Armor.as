/**
 * Created by aimozg on 10.01.14.
 */
package classes.Items
{
	import classes.ItemType;
	import classes.PerkLib;
	import classes.Player;

	public class Armor extends Useable //Equipable
	{
		private var _def:Number;
		private var _perk:String;
		private var _name:String;
		private var _supportsBulge:Boolean;
		private var _supportsUndergarment:Boolean;
		
		public function Armor(id:String, shortName:String, name:String, longName:String, def:Number, value:Number = 0, description:String = null, perk:String = "", supportsBulge:Boolean = false, supportsUndergarment:Boolean = true) {
			super(id, shortName, longName, value, description);
			this._name = name;
			this._def = def;
			this._perk = perk;
			_supportsBulge = supportsBulge;
			_supportsUndergarment = supportsUndergarment;
		}
		
		public function get def():Number { return _def; }
		
		public function get perk():String { return _perk; }
		
		public function get name():String { return _name; }
		
		public function get supportsBulge():Boolean { return _supportsBulge && game.player.modArmorName == ""; }
			//For most clothes if the modArmorName is set then it's Exgartuan's doing. The comfortable clothes are the exception, they override this function.
		
		public function get supportsUndergarment():Boolean { return _supportsUndergarment; }
		
		override public function get description():String {
			var desc:String = _description;
			//Type
			desc += "\n\nType: ";
			if (name.indexOf("armor") >= 0 || name.indexOf("armour") >= 0 || name.indexOf("chain") >= 0 || name.indexOf("mail") >= 0 || name.indexOf("plates") >= 0) {
				desc += "Armor ";
				if (perk == "Light" || perk == "Medium") {
					desc += "(Light)";
				}
				else if (perk == "Medium") desc += "(Medium)";
				else desc += "(Heavy)";
			}
			else desc += "Clothing ";
			//Defense
			desc += "\nDefense: " + String(def);
			//Value
			desc += "\nBase value: " + String(value);
			return desc;
		}
		
		override public function canUse():Boolean {
			if (this.supportsUndergarment == false && (game.player.upperGarment != UndergarmentLib.NOTHING || game.player.lowerGarment != UndergarmentLib.NOTHING)) {
				var output:String = "";
				var wornUpper:Boolean = false;

				output += "It would be awkward to put on " + longName + " when you're currently wearing ";
				if (game.player.upperGarment != UndergarmentLib.NOTHING) {
					output += game.player.upperGarment.longName;
					wornUpper = true;
				}

				if (game.player.lowerGarment != UndergarmentLib.NOTHING) {
					if (wornUpper) {
						output += " and ";
					}
					output += game.player.lowerGarment.longName;
				}

				output += ". You should consider removing them. You put it back into your inventory.";

				outputText(output);
				return false;
			}
			return super.canUse();
		}

		override public function useText():void {
			outputText("You equip " + longName + ".  ");
		}
		
		public function playerEquip():Armor { //This item is being equipped by the player. Add any perks, etc. - This function should only handle mechanics, not text output
			game.player.addToWornClothesArray(this);
			return this;
		}
		
		public function playerRemove():Armor { //This item is being removed by the player. Remove any perks, etc. - This function should only handle mechanics, not text output
			while (game.player.findPerk(PerkLib.BulgeArmor) >= 0) game.player.removePerk(PerkLib.BulgeArmor); //TODO remove this Exgartuan hack
			if (game.player.modArmorName.length > 0) game.player.modArmorName = "";
			return this;
		}
		
		public function removeText():void {} //Produces any text seen when removing the armor normally
		
/*
		override protected function equip(player:Player, returnOldItem:Boolean,output:Boolean):void
		{
			if (output) clearOutput();
			if (canUse(player, true)) {
				if (output) outputText("You equip your " + _name + ".  ");
				var oldArmor:Armor = player.armor;
				oldArmor.unequip(player, returnOldItem, output);
				player.setArmorHiddenField(this);
				equipped(player,output);
			}
		}

		override public function unequip(player:Player, returnToInventory:Boolean, output:Boolean = false):void
		{
			while(player.findPerk(PerkLib.BulgeArmor) >= 0) player.removePerk(PerkLib.BulgeArmor);// TODO remove this Exgartuan hack
			if (returnToInventory) {
				var itype:ItemType = unequipReturnItem(player, output);
				if (itype != null) {
					game.itemSwapping = true;
					if (output && itype == this)
						outputText("You have your old set of " + longName + " left over.  ");
					game.inventory.takeItem(this, false);
				}
			}
			player.setArmorHiddenField(ArmorLib.COMFORTABLE_UNDERCLOTHES);
			if (player.modArmorName.length > 0) player.modArmorName = "";
			unequipped(player,output);
		}
*/
	}
}
