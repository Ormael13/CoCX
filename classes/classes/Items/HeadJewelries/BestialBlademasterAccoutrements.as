/**
 * ...
 * @author Shadeogorath the Zerkaholic
 */
package classes.Items.HeadJewelries 
{
import classes.Items.HeadJewelry;
import classes.Scenes.SceneLib;
import classes.PerkLib;

	public class BestialBlademasterAccoutrements extends HeadJewelry
	{
		
		public function BestialBlademasterAccoutrements() 
		{
			super("BestBlaA", "BestBlaA", "Bestial Blademaster accoutrements", "Bestial Blademaster accoutrements", 0, 0, 1600, "Armored circlet and cape of a lizan swordswoman who was said to have mastered maintaining a serene state of mind in even the most heated of battles.", HJT_HELMET);
			withPerk(PerkLib.SereneMind, 0, 0, 0, 0);
		}
		
		override public function afterEquip(doOutput:Boolean, slot:int):void {
			SceneLib.setItemsChecks.equipBestialBlademasterItemsSet();
			super.afterEquip(doOutput, slot);
		}
		
		override public function afterUnequip(doOutput:Boolean, slot:int):void {
			SceneLib.setItemsChecks.unequipBestialBlademasterItemsSet();
			super.afterUnequip(doOutput, slot);
		}
	}
}
