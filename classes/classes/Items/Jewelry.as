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
		private var _extraEffectDesc:String;
		
		override public function get category():String {
			return CATEGORY_JEWELRY_RING;
		}
		
		public function Jewelry(id:String, shortName:String, name:String, longName:String, effectId:Number, effectMagnitude:Number, value:Number = 0, description:String = null, extraEffectDesc:String="", perk:String = "")
		{
			super(id, shortName, name, longName, value, description);
			this._effectId = effectId;
			this._effectMagnitude = effectMagnitude;
			this._extraEffectDesc = extraEffectDesc;
			this._perk = perk;
		}
		
		private static const SLOTS:Array = [SLOT_RING_1,SLOT_RING_2,SLOT_RING_3,SLOT_RING_4];
		override public function slots():Array {
			return SLOTS; // don't recreate every time
		}
		
		public function get effectId():Number { return _effectId; }

		public function get effectMagnitude():Number { return _effectMagnitude; }
		
		public function get perk():String { return _perk; }
		
		override public function effectDescriptionParts():Array {
			var list:Array = super.effectDescriptionParts();
			list.push([10, "Type: Jewelry (Ring)"]);
			if (effectId) {
				var desc:String = "Special: ";
				switch (effectId) {
					case RINGEFF_MINLUST:
						if (effectMagnitude > 0) {
							desc += "Increases minimum lust by " + effectMagnitude + "."
						} else {
							desc += "Reduces minimum lust by " + (-effectMagnitude) + "."
						}
						break;
					case RINGEFF_FERTILITY:
						desc += "Increases cum production by " + effectMagnitude + " percent and ferility by " + effectMagnitude + ".";
						break;
					case RINGEFF_SF:
						desc += "Increases maximum Soulforce by " + effectMagnitude + ".";
						break;
					case RINGEFF_MP:
						desc += "Increases maximum Mana by " + effectMagnitude + ".";
						break;
					case RINGEFF_HP:
						desc += "Increases maximum HP by " + effectMagnitude + ".";
						break;
					case RINGEFF_ATTACK_POWER:
						desc += "Increases melee damage by " + effectMagnitude + " percent.";
						break;
					case RINGEFF_SPELL_POWER:
						desc += "Increases spellpower by " + effectMagnitude + " percent.";
						break;
					case RINGEFF_PURITY:
						desc +="Slowly decreases the corruption of the wearer over time. Reduces minimum libido by " + effectMagnitude + ".";
						break;
					case RINGEFF_CORRUPTION:
						desc +="Slowly increases the corruption of the wearer over time.";
						break;
					case RINGEFF_WR:
						desc += "Increases maximum Wrath by " + effectMagnitude + ".";
						break;
					case RINGEFF_R_ATTACK_POWER:
						desc += "Increases range damage by " + effectMagnitude + " percent.";
						break;
					case RINGEFF_SOUL_POWER:
						desc += "Increases soulskill power by " + effectMagnitude + " percent.";
						break;
				}
				list.push([50, desc]);
			}
			if (_extraEffectDesc) list.push([60, _extraEffectDesc]);
			return list;
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
