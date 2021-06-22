/**
 * Created by Ormael on 04.06.21.
 */
package classes.Items 
{
	import classes.ItemType;
	import classes.PerkLib;
	import classes.Player;

	public class FlyingSwords extends Useable
	{
		private var _verb:String;
		private var _attack:Number;
		private var _perk:String;
		private var _name:String;
		
		public function FlyingSwords(id:String, shortName:String, name:String,longName:String, verb:String, attack:Number, value:Number = 0, description:String = null, perk:String = "") 
		{
			super(id, shortName, longName, value, description);
			this._name = name;
			this._verb = verb;
			this._attack = attack;
			this._perk = perk;
		}
		
		public function get verb():String { return _verb; }
		
		public function get attack():Number { return _attack; }
		
		public function get perk():String { return _perk; }
		
		public function get name():String { return _name; }
		
		override public function get description():String {
			var desc:String = _description;
			//Attack
			desc += "\nAttack: " + String(attack);
			//Value
			desc += "\nBase value: " + String(value);
			return desc;
		}
		
		override public function useText():void {
			outputText("You equip " + longName + ".  ");
		}
		
		override public function canUse():Boolean {
			if (!game.player.hasPerk(PerkLib.FlyingSwordPath)) {
				outputText("You need first to learn fine control over flying swords to equip this one.");
				return false;
			}
			return true;
		}
		
		public function playerEquip():FlyingSwords { //This item is being equipped by the player. Add any perks, etc. - This function should only handle mechanics, not text output
			return this;
		}
		
		public function playerRemove():FlyingSwords { //This item is being removed by the player. Remove any perks, etc. - This function should only handle mechanics, not text output
			return this;
		}
		
		public function removeText():void {} //Produces any text seen when removing the armor normally
		
	}
}