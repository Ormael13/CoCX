package classes.Items.Jewelries
{
	import classes.Items.Jewelry;
	import classes.Scenes.NPCs.KihaFollower;
	import classes.StatusEffects;
	
	public class StarfireBand extends Jewelry
	{
		public function StarfireBand()
		{
			super("StarfireBand", "Starfire Band", "Starfire Band", "Starfire Band", 0, 0, 1200, "The engagement ring given to you by Kiha");
			withBuffs({'res_fire':40,'res_physical':10,'res_magic':10}, true);
		}

		override public function afterEquip(doOutput:Boolean, slot:int):void {
			if (!game.isLoadingSave) {
				outputText("This Ring is clearly the work of a master jeweller and enchanter. Just wearing this band fills your body with comfortable warmth. ");
				if (KihaFollower.ProposalStatus == 3) {
					outputText("When you focus on the ring, you can feel a vague tinge of curiosity...and a surge of affection, with a little exasperation in there. Kiha notices you thinking of her, and you pull back from the ring, mentally. The connection fades, but you can still feel the barest hint of a mental pull, homing back towards your fiery wife. \n");
				} else {
					outputText("The ring fills you with a very faint feeling of loneliness. You feel like…You’ve left something behind…or someone. \n");
				}
				while (game.player.hasStatusEffect(StatusEffects.FieryBand)) game.player.removeStatusEffect(StatusEffects.FieryBand);
				game.player.createStatusEffect(StatusEffects.FieryBand, 0, 0, 0, 0);
			}
			super.afterEquip(doOutput, slot);
		}

		override public function afterUnequip(doOutput:Boolean, slot:int):void {
			while (game.player.hasStatusEffect(StatusEffects.FieryBand)) game.player.removeStatusEffect(StatusEffects.FieryBand);
			super.afterUnequip(doOutput, slot);
		}
	}
}
