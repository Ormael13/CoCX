/**
 * Created by aimozg on 09.01.14.
 */
package classes.Items
{
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

		/**
		 * Called on attempt to equip item.
		 * @param output Print "equipping" scene to output
		 */
		public function canEquip(player:Player,output:Boolean):Boolean
		{
			return true;
		}

		/**
		 * Called after item succesfully equipped. By default, does nothing. Should add perks/effects/etc.
		 */
		public function equipEffect(player:Player,output:Boolean):void
		{

		}

		/**
		 * Called after item succesfully unequipped. By default, does nothing. Should remove perks/effects/etc.
		 */
		public function unequipEffect(player:Player,output:Boolean):void
		{

		}

		protected final function equipped(player:Player,output:Boolean):void
		{
			_wearer = player;
			equipEffect(player,output);
		}

		protected final function unequipped(output:Boolean):void
		{
			unequipEffect(_wearer,output);
			_wearer = null;
		}

		public function equip(player:Player,output:Boolean):void
		{
			CoC_Settings.errorAMC("Equipable", "equip", id);
		}

		public function unequip(output:Boolean):void
		{
			CoC_Settings.errorAMC("Equipable", "unequip", id);
		}

		override public function doEffect(player:Player):void
		{
			equip(player,true);
		}

		public function Equipable(id:String, shortName:String = null, longName:String = null, value:Number = 0, description:String = null)
		{
			super(id, shortName, longName, value, description);
		}
	}
}
