/**
 * Created by aimozg on 09.01.14.
 */
//No longer used - equipping Weapons and Armor is now handled by the inventoryMenu
package classes.Items
{
	import classes.CoC_Settings;
	import classes.ItemType;
	import classes.Items.Armors.GooArmor;
	import classes.Player;

	/**
	 * Superclass for items that could be equipped by player (armor, weapon, talisman, piercing, ...).
	 * Subclasses should override "equip" and "unequip" methods. Optionally, they could override "equipEffect" and
	 * "unequipEffect" methods that perform additional effects on player. By default, they do nothing.
	 * Overridden "equip" and "unequip" should call "equipped" and "unequipped" if equipped/unequipped succesfully.
	 */
	public class Equipable extends Consumable
	{

		/**
		 * Called on attempt to equip item.
		 * @param output Print "equipping" scene to output
		 */
		override public function canUse(player:Player,output:Boolean):Boolean
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
			equipEffect(player,output);
		}

		protected final function unequipped(player:Player,output:Boolean):void
		{
			unequipEffect(player,output);
		}

		protected function equip(player:Player,returnOldItem:Boolean,output:Boolean):void
		{
			CoC_Settings.errorAMC("Equipable", "equip", id);
		}

		/**
		 * @param returnToInventory true if that item should be placed in player's inventory
		 * @param output true if the unequip function should print to the screen
		 */
		public function unequip(player:Player, returnToInventory:Boolean, output:Boolean = false):void
		{
			CoC_Settings.errorAMC("Equipable", "unequip", id);
		}

		/*override public function doEffect(player:Player,output:Boolean):void
		{
			if (game.debug && !(this is GooArmor)){
				if (output){
					clearOutput();
					outputText("You cannot equip anything in debug mode.  Please restart the game in normal mode to equip items.");
				}
				return;
			}
			equip(player,true,output);
		}*/

		public function Equipable(id:String, shortName:String = null, longName:String = null, value:Number = 0, description:String = null)
		{
			super(id, shortName, longName, value, description);
		}

		protected function unequipReturnItem(player:Player,output:Boolean):ItemType
		{
			return this;
		}
	}
}
