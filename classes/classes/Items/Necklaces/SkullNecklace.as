/**
 * ...
 * @author Ormael
 */
package classes.Items.Necklaces 
{
	import classes.GlobalFlags.kFLAGS;
	import classes.Items.Necklace;
	import classes.Scenes.SceneLib;
	
	public class SkullNecklace extends Necklace
	{
		
		public function SkullNecklace() 
		{
			super("SkullNe", "SkullNecklace", "Skull Necklace", "a Skull Necklace", 0, 0, 4000, "A necklace made of skulls with strong aura of death surrounding it. Rumored to be blessed by the god of death have amazing effect for any undead being that would wear it. \n\nType: Jewelry (Necklace) \nBase value: 4,000 \nSpecial: +2%(+4%)/-2%(-4%) HP regeneration (below 0 HP)(undead / others), +5% diehard for undead","Necklace");
		}
		
		override public function afterEquip(doOutput:Boolean, slot:int):void {
			SceneLib.setItemsChecks.equippedSkullSetItems();
			super.afterEquip(doOutput, slot);
		}
		
		override public function afterUnequip(doOutput:Boolean, slot:int):void {
			SceneLib.setItemsChecks.unequipSkullItemsSet();
			super.afterUnequip(doOutput, slot);
		}
	}
}
