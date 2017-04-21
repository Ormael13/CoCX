/**
 * Created by Kitteh6660 on 08.29.14.
 */
package classes.Items
{
	import classes.ItemType;
	import classes.PerkLib;
	import classes.Player;

	public class Jewelry extends Useable
	{
		private var _effectId:Number;
		private var _effectMagnitude:Number;
		private var _perk:String;
		private var _name:String;

		public function Jewelry(id:String, shortName:String, name:String, longName:String, effectId:Number, effectMagnitude:Number, value:Number = 0, description:String = null, type:String = "", perk:String = "")
		{
			super(id, shortName, longName, value, description);
			this._name = name;
			this._effectId = effectId;
			this._effectMagnitude = effectMagnitude;
			this._perk = perk;
		}

		public function get effectId():Number { return _effectId; }

		public function get effectMagnitude():Number { return _effectMagnitude; }
		
		public function get perk():String { return _perk; }

		public function get name():String { return _name; }
		
		override public function get description():String {
			var desc:String = _description;
			//Type
			desc += "\n\nType: Ring ";
			//Special
			if (_effectId > 0) desc += "\nSpecial: ";
			switch(_effectId) {
				case JewelryLib.MODIFIER_MINIMUM_LUST:
					if (_effectMagnitude >= 0)
						desc += "Increases minimum lust by " + _effectMagnitude + ".";
					else
						desc += "Reduces minimum lust by " + (-_effectMagnitude) + ".";
					break;
				case JewelryLib.MODIFIER_FERTILITY:
					desc += "Increases cum production by " + _effectMagnitude + "% and ferility by " + _effectMagnitude + ".";
					break;
				case JewelryLib.MODIFIER_CRITICAL:
					desc += "Increases critical chance by " + _effectMagnitude + "%.";
					break;
				case JewelryLib.MODIFIER_REGENERATION:
					desc += "Grants regeneration of " + _effectMagnitude + " HP per turn. Effect doubled outside of combat.";
					break;
				case JewelryLib.MODIFIER_HP:
					desc += "Increases maximum HP by " + _effectMagnitude + "."
					break;
				case JewelryLib.MODIFIER_ATTACK_POWER:
					desc += "Increases attack power by " + _effectMagnitude + "%."
					break;
				case JewelryLib.MODIFIER_SPELL_POWER:
					desc += "Increases spellpower by " + _effectMagnitude + "%, applies additively."
					break;
				case JewelryLib.PURITY:
					desc += "Slowly decreases the corruption of the wearer over time. Reduces minimum libido by " + _effectMagnitude + ".";
					break;
				case JewelryLib.CORRUPTION:
					desc += "Slowly corrupts the wearer over time.";
					break;
			}
			//Value
			desc += "\nBase value: " + String(value);
			return desc;
		}
		
		override public function useText():void {
			outputText("You equip " + longName + ".  ");
		}
		
		public function playerEquip():Jewelry { //This item is being equipped by the player. Add any perks, etc. - This function should only handle mechanics, not text output
			return this;
		}
		
		public function playerRemove():Jewelry { //This item is being removed by the player. Remove any perks, etc. - This function should only handle mechanics, not text output
			return this;
		}
		
		public function removeText():void {} //Produces any text seen when removing the armor normally
	}
}
