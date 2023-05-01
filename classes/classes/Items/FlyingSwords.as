/**
 * Created by Ormael on 04.06.21.
 */
package classes.Items
{
	import classes.ItemType;
	import classes.PerkLib;
	import classes.Player;

	public class FlyingSwords extends Equipable
	{
		private var _verb:String;
		private var _attack:Number;
		private var _perk:String;
		
		override public function get category():String {
			return CATEGORY_FLYING_SWORD;
		}
		
		public function FlyingSwords(id:String, shortName:String, name:String,longName:String, verb:String, attack:Number, value:Number = 0, description:String = null, perk:String = "")
		{
			super(id, shortName, name, longName, value, description);
			this._verb = verb;
			this._attack = attack;
			this._perk = perk;
		}
		
		private static const SLOTS:Array = [SLOT_FLYING_SWORD];
		override public function slots():Array {
			return SLOTS; // don't recreate every time
		}
		
		public function get verb():String { return _verb; }
		
		public function get attack():Number { return _attack; }
		
		public function get perk():String { return _perk; }
		
		override public function effectDescriptionParts():Array {
			var list:Array = super.effectDescriptionParts();
			//Size
			var desc:String = "Size: ";
			if (perk == "Massive Two") desc += "(Massive (set of 2))";
			else if (perk == "Massive") desc += "(Massive)";
			else if (perk == "Large Two") desc += "(Large (set of 2))";
			else if (perk == "Large") desc += "(Large)";
			else if (perk == "Small Six") desc += "(Small (set of 6))";
			else if (perk == "Small Two") desc += "(Small (set of 2))";
			else if (perk == "Small") desc += "(Small)";
			list.push([15, desc]);
			//Attack
			list.push([20,"Attack: "+attack]);
			return list;
		}
		
		override public function canEquip(doOutput:Boolean):Boolean {
			if (!game.player.hasPerk(PerkLib.FlyingSwordPath)) {
				if (doOutput) outputText("You need first to learn fine control over flying swords to equip this one.");
				return false;
			}
			return true;
		}
	}
}
