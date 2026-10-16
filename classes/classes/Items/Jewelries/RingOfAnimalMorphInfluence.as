package classes.Items.Jewelries 
{
	import classes.Items.Jewelry;
	import classes.Scenes.SceneLib;
	
	public class RingOfAnimalMorphInfluence extends Jewelry
	{
		
		public function RingOfAnimalMorphInfluence() 
		{
			super("RingOAMI", "RingOfAnimalMorphInfluence", "Ring of Animal-Morph Influence", "Ring of Animal-Morph Influence", 0, 0, 1600, "This ring is made of serpentine. Good for taming low intelligence beasts or to intimidate them. \nSpecial: +100% wis in taming checks vs animal-morph/beasts and once per fight use of Fear against them.");
		}

		override public function afterEquip(doOutput:Boolean, slot:int):void {
			SceneLib.setItemsChecks.equippedTamerSetItems();
			super.afterEquip(doOutput, slot);
		}

		override public function afterUnequip(doOutput:Boolean, slot:int):void {
			SceneLib.setItemsChecks.unequipTamerItemsSet();
			super.afterUnequip(doOutput, slot);
		}
	}
}
