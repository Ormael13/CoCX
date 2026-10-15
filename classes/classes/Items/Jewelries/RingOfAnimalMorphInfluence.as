package classes.Items.Jewelries 
{
	import classes.Items.Jewelry;
	import classes.Scenes.SceneLib;
	import classes.StatusEffects;
	
	public class RingOfAnimalMorphInfluence extends Jewelry
	{
		
		public function RingOfAnimalMorphInfluence() 
		{
			super("RingOAMI", "RingOfAnimalMorphInfluence", "Ring of Animal-Morph Influence", "Ring of Animal-Morph Influence", 0, 0, 200, "This ring is made of serpentine. . \nSpecial: .");
		}

		override public function afterEquip(doOutput:Boolean, slot:int):void {
			if (!game.isLoadingSave) SceneLib.campMakeWinions.equipRingOfTaming();
			SceneLib.setItemsChecks.equippedTamerSetItems();
			super.afterEquip(doOutput, slot);
		}

		override public function afterUnequip(doOutput:Boolean, slot:int):void {
			while (game.player.hasStatusEffect(StatusEffects.RingOfTamingCount)) SceneLib.campMakeWinions.unequipRingOfTaming();
			SceneLib.setItemsChecks.unequipTamerItemsSet();
			super.afterUnequip(doOutput, slot);
		}
	}
}
