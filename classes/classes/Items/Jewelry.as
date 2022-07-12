/**
 * Created by Kitteh6660 on 08.29.14.
 */
package classes.Items
{
import classes.Stats.StatUtils;

public class Jewelry extends Equipable
	{
		private var _effectId:Number;
		private var _effectMagnitude:Number;
		private var _perk:String;
		private var _effectDescription:String;
		
		override public function get category():String {
			return CATEGORY_JEWELRY_RING;
		}
		
		public function Jewelry(id:String, shortName:String, name:String, longName:String, effectId:Number, effectMagnitude:Number, value:Number = 0, description:String = null, effectDescription:String="", perk:String = "")
		{
			super(id, shortName, name, longName, value, description);
			this._effectId = effectId;
			this._effectMagnitude = effectMagnitude;
			if (effectId) {
				if (effectDescription) effectDescription += "\n";
				effectDescription += "Special: ";
				switch (effectId) {
					case RINGEFF_MINLUST:
						if (effectMagnitude > 0) {
							effectDescription += "Increases minimum lust by " + effectMagnitude + "."
						} else {
							effectDescription += "Reduces minimum lust by " + (-effectMagnitude) + "."
						}
						break;
					case RINGEFF_FERTILITY:
						effectDescription += "Increases cum production by " + effectMagnitude + " percent and ferility by " + effectMagnitude + ".";
						break;
					case RINGEFF_SF:
						effectDescription += "Increases maximum Soulforce by " + effectMagnitude + ".";
						break;
					case RINGEFF_MP:
						effectDescription += "Increases maximum Mana by " + effectMagnitude + ".";
						break;
					case RINGEFF_HP:
						effectDescription += "Increases maximum HP by " + effectMagnitude + ".";
						break;
					case RINGEFF_ATTACK_POWER:
						effectDescription += "Increases melee damage by " + effectMagnitude + " percent.";
						break;
					case RINGEFF_SPELL_POWER:
						effectDescription += "Increases spellpower by " + effectMagnitude + " percent.";
						break;
					case RINGEFF_PURITY:
						effectDescription +="Slowly decreases the corruption of the wearer over time. Reduces minimum libido by " + effectMagnitude + ".";
						break;
					case RINGEFF_CORRUPTION:
						effectDescription +="Slowly increases the corruption of the wearer over time.";
						break;
					case RINGEFF_WR:
						effectDescription += "Increases maximum Wrath by " + effectMagnitude + ".";
						break;
					case RINGEFF_R_ATTACK_POWER:
						effectDescription += "Increases range damage by " + effectMagnitude + " percent.";
						break;
				}
			}
			this._effectDescription = effectDescription;
			this._perk = perk;
		}
		
		private static const SLOTS:Array = [SLOT_RING_1,SLOT_RING_2,SLOT_RING_3,SLOT_RING_4];
		override public function slots():Array {
			return SLOTS; // don't recreate every time
		}
		
		public function get effectId():Number { return _effectId; }

		public function get effectMagnitude():Number { return _effectMagnitude; }
		
		public function get perk():String { return _perk; }
		
		override public function effectDescription():String {
			var desc:String = super.effectDescription();
			desc = "\nType: Jewelry (Ring)" + desc;
			if (_effectDescription) desc += "\n"+_effectDescription;
			return desc;
		}

		/*public function get sexiness():int {
			switch(this.name) {
				case "Demonic mage tail ornament":
					return 4;
				default:
					return 0;
			}
		}*/
	}
}
