package classes.Items.Jewelries 
{
	import classes.Items.Jewelry;
	import classes.Scenes.SceneLib;
	import classes.StatusEffects;
	
	public class RingOfTaming extends Jewelry
	{
		
		public function RingOfTaming() 
		{
			super("RingOTam", "RingOfTaming", "Ring of Taming", "Ring of Taming", 0, 0, 1600, "This ring is made of serpentine. It helps tame monster and for Tamers it would boost all tamed monsters.");
		}

		override public function afterEquip(doOutput:Boolean, slot:int):void {
			if (!game.isLoadingSave) SceneLib.campMakeWinions.equipRingOfTaming();
			super.afterEquip(doOutput, slot);
		}

		override public function afterUnequip(doOutput:Boolean, slot:int):void {
			while (game.player.hasStatusEffect(StatusEffects.FieryBand)) SceneLib.campMakeWinions.unequipRingOfTaming();
			super.afterUnequip(doOutput, slot);
		}
	}
}
