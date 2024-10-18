/**
 * ...
 * @author Ormael
 */
package classes.Items.Necklaces 
{
	import classes.GlobalFlags.kFLAGS;
	import classes.Items.Necklace;
	import classes.Scenes.SceneLib;
	
	public class TreeOfLifeNecklace extends Necklace
	{
		
		public function TreeOfLifeNecklace() 
		{
			super("TreeLNe", "TreeLifeNecklace", "Tree of Life Necklace", "a Tree of Life Necklace", 0, 0, 4000, "A necklace made of branches that symbolize the tree of life, surrounded by a strong aura of vitality. Rumored to be blessed by the god of life, it has an amazing effect on any living being that wears it. \n\nType: Jewelry (Necklace) \nBase value: 4,000 \nSpecial: +2%(+4%)/-2%(-4%) HP regeneration (below 0 HP) (living beings/undead), +5% diehard for living beings","Necklace");
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
