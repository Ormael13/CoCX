/**
 * Created by Ormael on 17.09.18.
 */
package classes.Items
{
	import classes.ItemType;
	import classes.PerkLib;
	import classes.Player;

	public class Necklace extends Equipable
	{
		private var _effectId:Number;
		private var _effectMagnitude:Number;
		private var _perk:String;
		
		override public function get category():String {
			return CATEGORY_NECKLACE;
		}
		
		public function Necklace(id:String, shortName:String, name:String, longName:String, effectId:Number, effectMagnitude:Number, value:Number = 0, description:String = null, type:String = "", perk:String = "")
		{
			super(id, shortName, name, longName, value, description);
			this._effectId = effectId;
			this._effectMagnitude = effectMagnitude;
			this._perk = perk;
		}
		
		private static const SLOTS:Array = [SLOT_NECK];
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
	}

}
