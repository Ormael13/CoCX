/**
 * @author Liadri
 */
package classes.Items.Armors 
{
	import classes.Items.Armor;
	import classes.StatusEffects;
	
	public class DeathPrinceOutfit extends Armor
	{
		
		public function DeathPrinceOutfit() 
		{
			super("DeathPO","DeathPrinceOutfit","Death Prince Outfit","a Death Prince Outfit",0,5,500,"The formal outfit worn by Anubi slavers from the inner desert region. (+50% Magic Soulskill power, grants 2% regeneration when soulforce is above half)","Light")
		}
		
		override public function afterEquip(doOutput:Boolean, slot:int):void {
			if (!game.isLoadingSave) {
				while (game.player.hasStatusEffect(StatusEffects.DeathPrinceO)) game.player.removeStatusEffect(StatusEffects.DeathPrinceO);
				game.player.createStatusEffect(StatusEffects.DeathPrinceO, 0, 0, 0, 0);
			}
			super.afterEquip(doOutput, slot);
		}
		
		override public function afterUnequip(doOutput:Boolean, slot:int):void {
			while (game.player.hasStatusEffect(StatusEffects.DeathPrinceO)) game.player.removeStatusEffect(StatusEffects.DeathPrinceO);
			super.afterUnequip(doOutput, slot);
		}
		
	}

}
