/**
 * @author Liadri
 */
package classes.Items.Armors 
{
	import classes.Items.Armor;
	import classes.StatusEffects;
		
	public class DeathPrinceGoldenArmor extends Armor
	{
		
		public function DeathPrinceGoldenArmor() 
		{
			super("DeathPGA","DeathPrinceGoldenArmor","Death Prince Golden Armor","a Death Prince Golden Armor",20,40,19200,"A set of golden armor worn by Anubi lords, both a symbol of status and power. These armors are generally granted to an Anubis who has acquired a sizable amount of slaves. (empowers Anubi ability by 50%, +200% Magic Soulskill power, grants 5% regeneration when soulforce is above half)","Medium")
			withTag(I_LEGENDARY);
		}
		
		override public function afterEquip(doOutput:Boolean, slot:int):void {
			if (!game.isLoadingSave) {
				while (game.player.hasStatusEffect(StatusEffects.DeathPrinceGA)) game.player.removeStatusEffect(StatusEffects.DeathPrinceGA);
				game.player.createStatusEffect(StatusEffects.DeathPrinceGA, 0, 0, 0, 0);
			}
			super.afterEquip(doOutput, slot);
		}
		
		override public function afterUnequip(doOutput:Boolean, slot:int):void {
			while (game.player.hasStatusEffect(StatusEffects.DeathPrinceGA)) game.player.removeStatusEffect(StatusEffects.DeathPrinceGA);
			super.afterUnequip(doOutput, slot);
		}
		
		override public function get def():Number{
			var mod:int = 0;
			mod += game.player.cor/10;
			return 10 + mod;
		}
		override public function get mdef():Number{
			var mod:int = 0;
			mod += game.player.cor/5;
			return 20 + mod;
		}
	}

}
