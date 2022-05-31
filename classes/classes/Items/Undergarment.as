package classes.Items
{
import classes.BodyParts.LowerBody;
import classes.PerkLib;
	/**
	 * @author Kitteh6660
	 */
	public class Undergarment extends Useable //Equipable
	{
		private var _type:Number;
		private var _perk:String;
		private var _name:String;

		public function Undergarment(id:String, shortName:String, name:String, longName:String, undergarmentType:Number, value:Number = 0, description:String = null, perk:String = "")
		{
			super(id, shortName, longName, value, description);
			this._type = undergarmentType;
			this._name = name;
			this._perk = perk;
		}

		public function get type():Number { return _type; }

		public function get perk():String { return _perk; }

		public function get name():String { return _name; }

		override public function useText():void {
			outputText("You equip " + longName + ".  ");
		}

		override public function get description():String {
			var desc:String = _description;
			//Defense
			if (armorDef > 0) desc += "\nDefense (P): " + String(armorDef);
			if (armorMDef > 0) desc += "\nDefense (M): " + String(armorMDef);
			//Sexiness
			if (sexiness > 0) desc += "\nSexiness: " + String(sexiness);
			//Value
			desc += "\nBase value: " + String(value);
			return desc;
		}

		public function get armorDef():int {
			switch(this.name) {
				case "spider-silk bra":
				case "spider-silk shirt":
				case "spider-silk loincloth":
				case "spider-silk panties":
				case "cow girl bra":
				case "cow girl panties":
					return 1;
				case "dragonscale bra":
				case "dragonscale vest":
				case "dragonscale loincloth":
				case "dragonscale thong":
				case "drider bra":
				case "drider panties":
					return 2;
				case "ebonweave corset":
				case "ebonweave vest":
				case "ebonweave jockstrap":
				case "ebonweave thong":
				case "rune thong":
				case "rune jock":
					return 3;
				case "HB shirt":
				case "HB panties":
					return 4;
				default:
					return 0;
			}
		}

		public function get armorMDef():int {
			switch(this.name) {
				case "ebonweave corset":
				case "ebonweave vest":
				case "ebonweave jockstrap":
				case "ebonweave thong":
				case "rune thong":
				case "rune jock":
				case "cow girl bra":
				case "cow girl panties":
					return 1;
				case "dragonscale bra":
				case "dragonscale vest":
				case "dragonscale loincloth":
				case "dragonscale thong":
					return 2;
				case "HB shirt":
				case "HB panties":
				case "drider bra":
					return 3;
				case "drider panties":
					return 4;
				default:
					return 0;
			}
		}

		public function get sexiness():int {
			switch(this.name) {
				case "spider-silk bra":
				case "spider-silk shirt":
				case "spider-silk loincloth":
				case "spider-silk panties":
				case "dragonscale bra":
				case "dragonscale vest":
				case "dragonscale loincloth":
				case "dragonscale thong":
				case "fur loincloth":
					return 1;
				case "latex bra":
				case "latex shorts":
				case "latex thong":
				case "ebonweave corset":
				case "ebonweave vest":
				case "ebonweave thong":
				case "ebonweave jockstrap":
				case "stockings and garters":
					return 2;
				case "rune thong":
				case "rune jock":
				case "cow girl bra":
				case "cow girl panties":
					return 3;
				case "drider bra":
				case "drider panties":
					return 4;
				default:
					return 0;
			}
		}

		override public function canUse():Boolean {
			if (!game.player.armor.supportsUndergarment) {
				outputText("It would be awkward to put on undergarments when you're currently wearing your type of clothing. You should consider switching to different clothes. You put it back into your inventory.");
				return false;
			}
			if (type == UndergarmentLib.TYPE_LOWERWEAR) {
				if (!LowerBody.lowerGarmentDisabled(game.player, perk)) {
					return true;
				}	else {
					outputText("Your form makes it impossible to put this on. You place it back into your inventory.");
					return false;
				}
			}
			if (game.player.hasPerk(PerkLib.Rigidity)) {
				outputText("You would very like to equip this item but your body stiffness prevents you from doing so.");
				return false;
			}
			return true;
		}

		public function playerEquip():Undergarment { //This item is being equipped by the player. Add any perks, etc. - This function should only handle mechanics, not text output
			return this;
		}

		public function playerRemove():Undergarment { //This item is being removed by the player. Remove any perks, etc. - This function should only handle mechanics, not text output
			return this;
		}

		public function removeText():void {} //Produces any text seen when removing the undergarment normally

	}

}
