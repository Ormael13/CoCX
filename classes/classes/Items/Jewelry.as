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
		private var _buffs:Object;
		
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
						effectDescription += "Special: Increases maximum Mana by " + effectMagnitude + ".";
						break;
					case RINGEFF_HP:
						effectDescription += "Special: Increases maximum HP by " + effectMagnitude + ".";
						break;
					case RINGEFF_ATTACK_POWER:
						effectDescription += "Special: Increases melee damage by " + effectMagnitude + " percent.";
						break;
					case RINGEFF_SPELL_POWER:
						effectDescription += "Special: Increases spellpower by " + effectMagnitude + " percent.";
						break;
					case RINGEFF_PURITY:
						effectDescription +="Special: Slowly decreases the corruption of the wearer over time. Reduces minimum libido by " + effectMagnitude + ".";
						break;
					case RINGEFF_CORRUPTION:
						effectDescription +="Special: Slowly increases the corruption of the wearer over time.";
						break;
					case RINGEFF_WR:
						effectDescription += "Special: Increases maximum Wrath by " + effectMagnitude + ".";
						break;
					case RINGEFF_R_ATTACK_POWER:
						effectDescription += "Special: Increases range damage by " + effectMagnitude + " percent.";
						break;
					case RINGEFF_FIRE_R:
						effectDescription += "Special: Increases fire resistance by " + effectMagnitude + "%.";
						break;
					case RINGEFF_ICE_R:
						effectDescription += "Special: Increases ice resistance by " + effectMagnitude + "%.";
						break;
					case RINGEFF_LIGH_R:
						effectDescription += "Special: Increases lightning resistance by " + effectMagnitude + "%.";
						break;
					case RINGEFF_DARK_R:
						effectDescription += "Special: Increases darkness resistance by " + effectMagnitude + "%.";
						break;
					case RINGEFF_POIS_R:
						effectDescription += "Special: Increases poison resistance by " + effectMagnitude + "%.";
						break;
					case RINGEFF_MAGIC_R:
						effectDescription += "Special: Increases magic resistance by " + effectMagnitude + "%.";
						break;
					case RINGEFF_LUST_R:
						effectDescription += "Special: Increases lust resistance by " + effectMagnitude + "%.";
						break;
					case RINGEFF_PHYS_R:
						effectDescription += "Special: Increases physical resistance by " + effectMagnitude + "%.";
						break;
				}
			}
			this._effectDescription = effectDescription;
			this._perk = perk;
		}
		public function withBuffs(buffs:Object):Jewelry {
			this._buffs = buffs;
			return this;
		}
		
		private static const SLOTS:Array = [SLOT_RING_1,SLOT_RING_2,SLOT_RING_3,SLOT_RING_4];
		override public function slots():Array {
			return SLOTS; // don't recreate every time
		}
		
		public function get effectId():Number { return _effectId; }

		public function get effectMagnitude():Number { return _effectMagnitude; }
		
		public function get perk():String { return _perk; }
		
		override public function get description():String {
			var desc:String = _description;
			desc += "\n\nType: Jewelry (Ring)";
			desc += "\nBase value: " + value;
			if (_buffs) {
				desc += "\nSpecial:";
				for (var key:String in _buffs) {
					desc += " "+StatUtils.explainBuff(key, _buffs[key]);
				}
			}
			if (_effectDescription) desc += "\n"+_effectDescription;
			return desc;
		}
		
		public function countSameRingsEquipped():int {
			return game.player.countRings(this);
		}
		
		override public function afterEquip(doOutput:Boolean):void {
			if (!game.isLoadingSave && this._buffs) {
				game.player.buff(this.tagForBuffs).addStats(this._buffs).withText(this.name);
			}
			super.afterEquip(doOutput);
		}
		
		override public function afterUnequip(doOutput:Boolean):void {
			if (this._buffs) {
				if (game.player.countRings(this) == 0) {
					game.player.buff(this.tagForBuffs).remove();
				} else {
					game.player.buff(this.tagForBuffs).subtractStats(this._buffs);
				}
			}
			super.afterUnequip(doOutput);
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
