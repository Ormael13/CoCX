package classes.Items.Jewelries 
{
	import classes.Items.Jewelry;
	import classes.Scenes.SceneLib;
	import classes.StatusEffects;
	
	public class RingOfTaming extends Jewelry
	{
		
		public function RingOfTaming() 
		{
			super("RingOTam", "RingOfTaming", "Ring of Taming", "Ring of Taming", 0, 0, 1600, "This ring is made of serpentine. It helps tame monster and or boost them. \nSpecial: +1 taming slot for non-Tamers/+100% base dmg of tamed monsters for Tamers.");
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
