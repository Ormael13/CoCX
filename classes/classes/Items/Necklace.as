/**
 * Created by Ormael on 17.09.18.
 */
package classes.Items 
{
	import classes.ItemType;
	import classes.PerkLib;
	import classes.Player;

	public class Necklace extends Useable
	{
		private var _effectId:Number;
		private var _effectMagnitude:Number;
		private var _perk:String;
		private var _name:String;
		
		public function Necklace(id:String, shortName:String, name:String, longName:String, effectId:Number, effectMagnitude:Number, value:Number = 0, description:String = null, type:String = "", perk:String = "") 
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
			return desc;
		}
		
		override public function useText():void {
			outputText("You equip " + longName + ".  ");
		}
		
		public function playerEquip():Necklace { //This item is being equipped by the player. Add any perks, etc. - This function should only handle mechanics, not text output
			return this;
		}
		
		public function playerRemove():Necklace { //This item is being removed by the player. Remove any perks, etc. - This function should only handle mechanics, not text output
			return this;
		}
		
		public function removeText():void {} //Produces any text seen when removing the armor normally
		
	}

}