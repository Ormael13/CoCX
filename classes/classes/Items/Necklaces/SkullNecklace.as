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
			super("SkullNe", "SkullNecklace", "Skull Necklace", "a Skull Necklace", 0, 0, 8000, "A necklace made of skulls with strong aura of death surrounding it. Rumored to be blessed by the god of death have amazing effect for any undead being that would wear it. \n\nType: Jewelry (Necklace) \nBase value: 8,000 \nSpecial: +5%(+10%)/-5%(-10%) HP regeneration (below 0 HP)(undead / others), +5% diehard/overmax HP for undead","Necklace");
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