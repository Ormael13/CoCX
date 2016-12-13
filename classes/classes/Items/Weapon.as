/**
 * Created by aimozg on 09.01.14.
 */
package classes.Items
{
	import classes.ItemType;
	import classes.Player;

	public class Weapon extends Useable //Equipable
	{
		private var _verb:String;
		private var _attack:Number;
		private var _perk:String;
		private var _name:String;
		
		public function Weapon(id:String, shortName:String, name:String,longName:String, verb:String, attack:Number, value:Number = 0, description:String = null, perk:String = "") {
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
			return this._description + "\n\nAttack: " + this.attack + "\nValue: " + this.value;
		}
		
		override public function useText():void {
			outputText("You equip " + longName + ".  ");
		}
		
		public function playerEquip():Weapon { //This item is being equipped by the player. Add any perks, etc. - This function should only handle mechanics, not text output
			return this;
		}
		
		public function playerRemove():Weapon { //This item is being removed by the player. Remove any perks, etc. - This function should only handle mechanics, not text output
			return this;
		}
		
		public function removeText():void {} //Produces any text seen when removing the armor normally
		
/*
		override protected function equip(player:Player, returnOldItem:Boolean, output:Boolean):void
		{
			if (output) clearOutput();
			if (canUse(player,output)){
				var oldWeapon:Weapon = player.weapon;
				if (output) {
					outputText("You equip your " + longName + ".  ");
				}
				oldWeapon.unequip(player, returnOldItem, output);
				player.setWeaponHiddenField(this);
				equipped(player,output);
			}
		}


		override public function unequip(player:Player, returnToInventory:Boolean, output:Boolean = false):void
		{
			if (returnToInventory) {
				var itype:ItemType = unequipReturnItem(player, output);
				if (itype != null) {
					if (output && itype == this)
						outputText("You still have " + itype.longName + " left over.  ");
					game.itemSwapping = true;
					game.inventory.takeItem(this, false);
				}
			}
			player.setWeaponHiddenField(WeaponLib.FISTS);
			unequipped(player,output);
		}
*/
	}
}
