/**
 * Created by aimozg on 09.01.14.
 */
package classes.Items
{
	import classes.ItemType;
	import classes.Player;

	public class Weapon extends Equipable
	{
		private var _verb:String;
		private var _attack:Number;
		private var _perk:String;
		private var _name:String;

		override public function equip(player:Player, output:Boolean):void
		{
			if (output) clearOutput();
			if (canUse(player,output)){
				var oldWeapon:Weapon = player.weapon;
				if (output) {
					outputText("You equip your " + longName + ".  ");
				}
				oldWeapon.unequip(player,output);
				player.setWeaponHiddenField(this);
				equipped(player,output);
			}
		}


		override public function unequip(player:Player,output:Boolean):void
		{
			var itype:ItemType = unequipReturnItem(player,output);
			if (itype != null){
				if (output && itype == this)
					outputText("You still have " + itype.longName + " left over.  ");
				game.itemSwapping = true;
				game.inventory.takeItem(this);
			}
			player.setWeaponHiddenField(WeaponLib.FISTS);
			unequipped(player,output);
		}

		public function Weapon(id:String, shortName:String, name:String,longName:String, verb:String, attack:Number, value:Number = 0, description:String = null, perk:String = "")
		{
			super(id, shortName, longName, value, description);
			this._name = name;
			this._verb = verb;
			this._attack = attack;
			this._perk = perk;
		}


		public function get verb():String
		{
			return _verb;
		}

		public function get attack():Number
		{
			return _attack;
		}

		public function get perk():String
		{
			return _perk;
		}

		public function get name():String
		{
			return _name;
		}
	}
}
