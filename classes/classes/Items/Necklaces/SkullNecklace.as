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
			super("SkullNe", "SkullNecklace", "Skull Necklace", "a Skull Necklace", 0, 0, 500, "A necklace made of skulls with strong aura of death surrounding it. Rumored to be blessed by the god of death have amazing effect for any undead being that would wear it. \n\nType: Jewelry (Necklace) \nBase value: 500 \nSpecial: +5%/-5% HP regeneration (undead / others)","Necklace");
		}
		
		override public function afterEquip(doOutput:Boolean):void {
			SceneLib.setItemsChecks.equippedSkullSetItems();
			super.afterEquip(doOutput);
		}
		
		override public function afterUnequip(doOutput:Boolean):void {
			SceneLib.setItemsChecks.unequipSkullItemsSet();
			super.afterUnequip(doOutput);
		}
	}
}