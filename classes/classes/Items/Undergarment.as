package classes.Items 
{
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
			desc += "\n\nType: Undergarment ";
			if (type == 0) desc += "(Upper)";
			else if (type == 1) desc += "(Lower)";
			else if (type == 2) desc += "(Full)";
			//Defense
			if (armorDef > 0) desc += "\nDefense: " + String(armorDef);
			//Sexiness
			if (sexiness > 0) desc += "\nSexiness: " + String(sexiness);
			//Value
			desc += "\nBase value: " + String(value);
			//Naga wearable?
			if (type == 0 && perk == "NagaWearable" && game.player.isNaga()) desc += "\nNagas aren't restricted from wearing this type of lower undergarment.";
			return desc;
		}
		
		public function get armorDef():int {
			switch(this.name) {
				case "spider-silk bra":
				case "spider-silk loincloth":
				case "spider-silk panties":
					return 1;
				case "dragonscale bra":
				case "dragonscale loincloth":
				case "dragonscale thong":
					return 2;
				default:
					return 0;
			}
		}
		
		public function get sexiness():int {
			switch(this.name) {
				case "spider-silk bra":
				case "spider-silk loincloth":
				case "spider-silk panties":
				case "dragonscale bra":
				case "dragonscale loincloth":
				case "dragonscale thong":
					return 1;
				case "fundoshi":
				case "fur loincloth":
					return 2;
				case "latex bra":
				case "latex shorts":
				case "latex thong":
				case "stockings and garters":
					return 3;
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
				if (game.player.isBiped() || game.player.isGoo()) {
					return true; //It doesn't matter what leg type you have as long as you're biped.
				}
				else if (game.player.isTaur() || game.player.isDrider()) {
					outputText("Your form makes it impossible to put on any form of lower undergarments. You put it back into your inventory.");
					return false;
				}
				else if (game.player.isNaga()) {
					if (perk != "NagaWearable") {
						outputText("It's impossible to put on this undergarment as it's designed for someone with two legs. You put it back into your inventory.");
						return false;
					}
					else return true;
				}
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