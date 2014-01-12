/**
 * Created by aimozg on 10.01.14.
 */
package classes.Items
{
	import classes.Character;
	import classes.Player;

	public class Armor extends Equipable
	{
		private var _def:Number;
		private var _perk:String;


		override public function equip(user:Player):void
		{
			if (canEquip(user, true)) {
				user.armor.unequip();
				user.setArmorHiddenField(this);
				equipped(user);
			}
		}

		override public function unequip():void
		{
			wearer.armor = ArmorLib.COMFORTABLE_UNDERCLOTHES;
			unequipped();
		}

		public function Armor(id:String, shortName:String, longName:String, def:Number, value:Number = 0, description:String = null, perk:String = "")
		{
			super(id, shortName, longName, value, description);
			this._def = def;
			this._perk = perk;
		}

		public function get def():Number
		{
			return _def;
		}

		public function get perk():String
		{
			return _perk;
		}
	}
}
