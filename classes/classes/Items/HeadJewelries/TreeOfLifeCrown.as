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
			super("TreeLCr", "TreeLifeCrown", "Tree of Life Crown", "a Tree of Life Crown", 0, 0, 6400, "A crown made of branches that symbolize tree of life with strong aura of life surrounding it. Rumored to be blessed by the god of life have amazing effect for any living being that would wear it. \nBase value: 6,400 \nSpecial: +2%(+4%)/-2%(-4%) HP regeneration (below 0 HP)(others / undead), +4% diehard/overmax HP for living beings", HJT_CROWN);
		}
		
		override public function afterEquip(doOutput:Boolean):void {
			SceneLib.setItemsChecks.equipTreeOfLifeItemsSet();
			super.afterEquip(doOutput);
		}
		
		override public function afterUnequip(doOutput:Boolean):void {
			SceneLib.setItemsChecks.unequipTreeOfLifeItemsSet();
			super.afterUnequip(doOutput);
		}
	}
}