/**
 * Created by Ormael on 04.06.21.
 */
package classes.Items
{
	public class MiscJewelry extends Equipable
	{
		private var _effectId:Number;
		private var _effectMagnitude:Number;
		private var _sexiness:int;
		private var _perk:String;
		
		override public function get category():String {
			return CATEGORY_JEWELRY_MISC;
		}
		
		public function MiscJewelry(id:String, shortName:String, name:String, longName:String, effectId:Number, effectMagnitude:Number, value:Number, sexiness:Number, description:String = null, type:String = "", perk:String = "")
		{
			super(id, shortName, name, longName, value, description);
			this._effectId = effectId;
			this._effectMagnitude = effectMagnitude;
			this._perk = perk;
			this._sexiness = sexiness;
		}
		
		private static const SLOTS:Array = [SLOT_JEWELRY_MISC_1, SLOT_JEWELRY_MISC_2];
		override public function slots():Array {
			return SLOTS; // don't recreate every time
		}

		public function get effectId():Number { return _effectId; }

		public function get effectMagnitude():Number { return _effectMagnitude; }
		
		public function get perk():String { return _perk; }
		
		override public function get description():String {
			var desc:String = _description;
			return desc;
		}

		public function get sexiness():int {
			switch(this.name) {
				case "Demonic mage tail ornament":
					return 4;
				default:
					return 0;
			}
		}
		
	}

}
