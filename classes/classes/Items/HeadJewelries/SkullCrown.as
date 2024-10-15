/**
 * ...
 * @author Ormael
 */
package classes.Items.HeadJewelries 
{
	import classes.GlobalFlags.kFLAGS;
	import classes.Items.HeadJewelry;
	import classes.Scenes.SceneLib;
	
	public class SkullCrown extends HeadJewelry
	{
		
		public function SkullCrown() 
		{
			super("SkullsCr", "SkullsCrown", "Skulls Crown", "a Skull Crown", 0, 0, 8000, "A crown made of skulls with strong aura of death surrounding it. Rumored to be blessed by the god of death, it has amazing effect for any undead being that wears it. \nBase value: 8,000 \nSpecial: +2%(+4%)/-2%(-4%) HP regeneration (below 0 HP)(undead / others), +5% diehard for undead", HJT_CROWN);
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
