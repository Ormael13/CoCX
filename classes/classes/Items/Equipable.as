/**
 * Created by aimozg on 09.01.14.
 */
package classes.Items
{
	import classes.Character;
	import classes.CoC_Settings;
	import classes.Player;

	/**
	 * Superclass for items that could be equipped by player (armor, weapon, talisman, piercing, ...).
	 * Subclasses should override "equip" and "unequip" methods. Optionally, they could override "equipEffect" and
	 * "unequipEffect" methods that perform additional effects on player. By default, they do nothing.
	 * Overridden "equip" and "unequip" should call "equipped" and "unequipped" if equipped/unequipped succesfully.
	 */
	public class Equipable extends Consumable
	{
		private var _wearer:Player = null;

		public function get wearer():Player
		{
			return _wearer;
		}

		public function canEquip(player:Player,printReason:Boolean):Boolean
		{
			return true;
		}

		public function equipEffect(user:Player):void
		{

		}

		public function unequipEffect(user:Player):void
		{

		}

		protected function equipped(user:Player):void
		{
			_wearer = user;
			equipEffect(user);
		}

		protected function unequipped():void
		{
			unequipEffect(_wearer);
			_wearer = null;
		}

		public function equip(user:Player):void
		{
			CoC_Settings.errorAMC("Equipable", "equip", id);
		}

		public function unequip():void
		{
			CoC_Settings.errorAMC("Equipable", "unequip", id);
		}

		override public function doEffect(user:Player):void
		{
			equip(user);
		}

		public function Equipable(id:String, shortName:String = null, longName:String = null, value:Number = 0, description:String = null)
		{
			super(id, shortName, longName, value, description);
		}
	}
}
