/**
 * ...
 * @author Shadeogorath the Zerkaholic
 */
package classes.Items.Armors
{
import classes.Items.Armor;
import classes.Scenes.SceneLib;
import classes.PerkLib;

	public class BestialBlademasterArmor extends Armor
	{
		
		public function BestialBlademasterArmor() 
		{
			super("BestBlA", "BestBlA", "Bestial Blademaster armor", "a Bestial Blademaster armor", 15, 10, 8000, "An armor that was once worn by a lizan swordswoman with an odd affinity for fire. Designed to cover and sturdily protect the parts of her body her tough scales did not, whilst allowing her to maintain her mobility.", "Medium");
				withBuffs({'teasedmg':8});
				withPerk(PerkLib.InfernalRage, 0, 0, 0, 0);
				withTag(A_AGILE);
				withTag(A_REVEALING);
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
