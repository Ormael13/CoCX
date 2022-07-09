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
			this._effectDescription = effectDescription;
			this._perk = perk;
		}
		public function withBuffs(buffs:Object):Jewelry {
			this._buffs = buffs;
			return this;
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
				game.player.buff(this.tagForBuffs).setStats(this._buffs).withText(this.name);
			}
			super.afterEquip(doOutput);
		}
		
		override public function afterUnequip(doOutput:Boolean):void {
			if (this._buffs) {
				if (countSameRingsEquipped() == 1) {
					// Last item of that type is being removed
					game.player.buff(tagForBuffs).remove();
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
