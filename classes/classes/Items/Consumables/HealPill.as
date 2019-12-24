package classes.Items.Consumables 
{
import classes.EngineCore;
import classes.Items.Consumable;
import classes.Items.ConsumableLib;
import classes.PerkLib;

/**
	 * Moderate boost to HP.
	 * 
	 * Retro UTG stuff!
	 */
	public class HealPill extends Consumable 
	{
		public function HealPill() 
		{
			super("H. Pill", "Heal Pill", "a small healing pill", ConsumableLib.DEFAULT_VALUE, "A small healing pill that's guaranteed to heal you by a bit.");
		}
		
		override public function useItem():Boolean
		{
			var rand:int = Math.random() * 100;
			outputText("You pop the small pill into your mouth and swallow. ");
			
			if (player.HP < player.maxHP()) {
				if (player.hasPerk(PerkLib.GoblinoidBlood) && player.hasPerk(PerkLib.NaturalPunchingBagFinalForm)) EngineCore.HPChange(Math.round((50 + player.tou) * 2), true);
				else if ((player.hasPerk(PerkLib.GoblinoidBlood) && player.hasPerk(PerkLib.NaturalPunchingBagEvolved)) || player.hasPerk(PerkLib.NaturalPunchingBagFinalForm)) EngineCore.HPChange(Math.round((50 + player.tou) * 1.5), true);
				else EngineCore.HPChange(50 + player.tou, true);
				outputText("Some of your wounds are healed. ");
			}
			else
			{
				outputText("You feel an odd sensation. ");
			}
			
			if (rand < 70 && player.lib < 40) {
				outputText("You feel a sense of warmth spread through your erogenous areas.");
				dynStats("lib", 1);
			}
			
			if (rand >= 70 && rand <= 90) {
				outputText("Your body tingles and feels more sensitive.");
				dynStats("sens", 1);
			}
			
			if (rand > 90) {
				outputText("You shudder as a small orgasm passes through you. When you recover you actually feel more aroused.");
				dynStats("lus", 5);
			}
			
			return false;
		}
	}
}
