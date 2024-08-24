/**
 * ...
 * @author Liadri
 */
package classes.Items.HeadJewelries 
{
	import classes.Items.HeadJewelry;
	import classes.StatusEffects;

	public class DeathPrinceRegalia extends HeadJewelry
	{
		
		public function DeathPrinceRegalia() 
		{
			super("DeathPR", "Death Prince Regalia", "Death Prince Regalia", "a Death Prince Regalia", 0, 0, 800, "A typical hair ornament worn by the anubi slavers from the inner desert region. Increases Soul Skill damage and grants SF regeneration when SF is above half.",HJT_HAIRPIN,"","\nSpecial: Increases Soul Skill damage by 20%. Grants 1% regeneration when SF is above half.");
		}
		
		override public function afterEquip(doOutput:Boolean, slot:int):void {
			if (!game.isLoadingSave) {
				while (game.player.hasStatusEffect(StatusEffects.DeathPrinceR)) game.player.removeStatusEffect(StatusEffects.DeathPrinceR);
				game.player.createStatusEffect(StatusEffects.DeathPrinceR, 0, 0, 0, 0);
			}
			super.afterEquip(doOutput, slot);
		}
		
		override public function afterUnequip(doOutput:Boolean, slot:int):void {
			while (game.player.hasStatusEffect(StatusEffects.DeathPrinceR)) game.player.removeStatusEffect(StatusEffects.DeathPrinceR);
			super.afterUnequip(doOutput, slot);
		}
		
	}

}
