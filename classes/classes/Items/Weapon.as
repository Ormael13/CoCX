/**
 * Created by aimozg on 09.01.14.
 */
package classes.Items
{
	import classes.Player;

	public class Weapon extends Equipable
	{
		private var _verb:String;
		private var _attack:Number;
		private var _perk:String;

		override public function equip(user:Player):void
		{
			if (canEquip(user,true)){
				user.weapon.unequip();
				user.setWeaponHiddenField(this);
				clearOutput();
				outputText("You equip your " + longName + ".  ");
				equipped(user);
			}
		}


		override public function unequip():void
		{
			wearer.weapon = WeaponLib.FISTS;
			unequipped();
		}

		public function Weapon(id:String, shortName:String, longName:String, verb:String, attack:Number, value:Number = 0, description:String = null, perk:String = "")
		{
			super(id, shortName, longName, value, description);
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
	}
}
