/**
 * Created by Ormael on 04.06.21.
 */
package classes.Items
{
	import classes.ItemType;
	import classes.PerkLib;
	import classes.Player;
	import classes.Scenes.Combat.CombatAbility;

	public class FlyingSwords extends Equipable
	{
		private var _verb:String;
		private var _attack:Number;
		private var _perk:String;
		private var _element:int;
		private var _count:int;
		
		override public function get category():String {
			return CATEGORY_FLYING_SWORD;
		}
		
		public function FlyingSwords(id:String, shortName:String, name:String,longName:String, verb:String, attack:Number, value:Number = 0, description:String = null, perk:String = "", count:int= 1, element:int=-1)
		{
			super(id, shortName, name, longName, value, description);
			this._verb = verb;
			this._attack = attack;
			this._perk = perk;
			this._count = count;
			this._element = (element == -1)? CombatAbility.TAG_PHYSICAL: element;
		}
		
		private static const SLOTS:Array = [SLOT_FLYING_SWORD];
		override public function slots():Array {
			return SLOTS; // don't recreate every time
		}
		
		public function get verb():String { return _verb; }
		
		public function get attack():Number { return _attack; }
		
		public function get perk():String { return _perk; }

		public function get element():int { return _element; }

		public function get count():int { return _count; }
		
		override public function effectDescriptionParts():Array {
			var list:Array = super.effectDescriptionParts();
			//Size
			var desc:String = "Size: (" + perk;
			var suffix:String = ")";
			if (count == 1) desc += suffix;
			else desc += " (set of " + count +")" + suffix;
			
			list.push([15, desc]);
			//Attack
			list.push([20,"Attack: " + attack]);
			//Element
			list.push([25,"Element: " + CombatAbility.AllTags[element].name]);
			return list;
		}
		
		override public function canEquip(doOutput:Boolean, slot:int):Boolean {
			if (!game.player.hasPerk(PerkLib.FlyingSwordPath)) {
				if (doOutput) outputText("You must first learn fine control over flying swords before you can equip this one.");
				return false;
			}
			return true;
		}
	}
}
