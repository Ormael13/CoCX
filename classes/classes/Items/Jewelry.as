/**
 * Created by Kitteh6660 on 08.29.14.
 */
package classes.Items
{
import classes.Stats.StatUtils;

public class Jewelry extends Useable
	{
		private var _effectId:Number;
		private var _effectMagnitude:Number;
		private var _perk:String;
		private var _name:String;
		private var _effectDescription:String;
		private var _buffs:Object;
		
		override public function get category():String {
			return CATEGORY_JEWELRY_RING;
		}
		
		public function Jewelry(id:String, shortName:String, name:String, longName:String, effectId:Number, effectMagnitude:Number, value:Number = 0, description:String = null, effectDescription:String="", perk:String = "")
		{
			super(id, shortName, longName, value, description);
			this._name = name;
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

		public function get name():String { return _name; }
		
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
		
		override public function useText():void {
			outputText("You equip " + longName + ".  ");
		}
		
		public function playerEquip():Jewelry { //This item is being equipped by the player. Add any perks, etc. - This function should only handle mechanics, not text output
			if (this._buffs) {
				game.player.buff(this.tagForBuffs).setStats(this._buffs).withText(this.name);
			}
			return this;
		}
		
		public function countSameRingsEquipped():int {
			return (game.player.jewelry === this ? 1 : 0) +
					(game.player.jewelry2 === this ? 1 : 0) +
					(game.player.jewelry3 === this ? 1 : 0) +
					(game.player.jewelry4 === this ? 1 : 0)
		}
		
		public function playerRemove():Jewelry { //This item is being removed by the player. Remove any perks, etc. - This function should only handle mechanics, not text output
			if (this._buffs) {
				if (countSameRingsEquipped() == 1) {
					// Last item of that type is being removed
					game.player.buff(tagForBuffs).remove();
				}
			}
			return this;
		}
		
		public function removeText():void {} //Produces any text seen when removing the armor normally

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
