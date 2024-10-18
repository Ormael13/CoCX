/**
 * ...
 * @author Ormael
 */
package classes.Items.HeadJewelries 
{
	import classes.GlobalFlags.kFLAGS;
	import classes.Items.HeadJewelry;
	import classes.Scenes.SceneLib;
	
	public class TreeOfLifeCrown extends HeadJewelry
	{
		
		public function TreeOfLifeCrown() 
		{
			super("TreeLCr", "TreeLifeCrown", "Tree of Life Crown", "a Tree of Life Crown", 0, 0, 8000, "A crown made of branches that the symbolize tree of life, with a strong aura of life surrounding it. Rumored to be blessed by the god of life, it has an amazing effect on any living being who wears it. \nBase value: 8,000 \nSpecial: +2%(+4%)/-2%(-4%) HP regeneration (below 0 HP)(others / undead), +5% diehard for living beings", HJT_CROWN);
		}
		
		override public function afterEquip(doOutput:Boolean, slot:int):void {
			SceneLib.setItemsChecks.equipTreeOfLifeItemsSet();
			super.afterEquip(doOutput, slot);
		}
		
		override public function afterUnequip(doOutput:Boolean, slot:int):void {
			SceneLib.setItemsChecks.unequipTreeOfLifeItemsSet();
			super.afterUnequip(doOutput, slot);
		}
	}
}
