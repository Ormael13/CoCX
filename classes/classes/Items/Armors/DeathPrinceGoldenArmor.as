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
			super("DeathPGA","DeathPrinceGoldenArmor","Death Prince Golden Armor","a Death Prince Golden Armor",20,40,19200,"A set of golden armor worn by Anubi lords, both a symbol of status and power. These armors are generally granted to an anubis who has acquired a sizable amount of slaves.","Medium")
		}
		
		override public function afterEquip(doOutput:Boolean):void {
			if (!game.isLoadingSave) {
				while (game.player.hasStatusEffect(StatusEffects.DeathPrinceGA)) game.player.removeStatusEffect(StatusEffects.DeathPrinceGA);
				game.player.createStatusEffect(StatusEffects.DeathPrinceGA, 0, 0, 0, 0);
			}
			super.afterEquip(doOutput);
		}
		
		override public function afterUnequip(doOutput:Boolean):void {
			while (game.player.hasStatusEffect(StatusEffects.DeathPrinceGA)) game.player.removeStatusEffect(StatusEffects.DeathPrinceGA);
			super.afterUnequip(doOutput);
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
		
		override public function canEquip(doOutput:Boolean):Boolean {
			if (game.player.level >= 54) return super.canEquip(doOutput);
			if (doOutput) outputText("You try and wear the legendary armor but to your disapointment the item simply refuse to stay on your body. It would seem you yet lack the power and right to wield this item.");
			return false;
		}
		
	}

}
