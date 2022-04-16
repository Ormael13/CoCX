package classes.Items.Consumables 
{
import classes.EngineCore;
import classes.Items.Consumable;
import classes.Items.ConsumableLib;
import classes.PerkLib;
import classes.MutationsLib;

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
			
			if (player.HP < player.maxOverHP()) {
				if (player.hasPerk(PerkLib.GoblinoidBlood) && player.hasPerk(MutationsLib.NaturalPunchingBagEvolved)) EngineCore.HPChange(Math.round((50 + player.tou) * 2), true);
				else if ((player.hasPerk(PerkLib.GoblinoidBlood) && player.hasPerk(MutationsLib.NaturalPunchingBagPrimitive)) || player.hasPerk(MutationsLib.NaturalPunchingBagEvolved)) EngineCore.HPChange(Math.round((50 + player.tou) * 1.5), true);
				else EngineCore.HPChange(50 + player.tou, true);
				outputText("Some of your wounds are healed. ");
			}
			else
			{
				outputText("You feel an odd sensation. ");
			}
			
			if (rand < 70 && player.lib < 40 && player.MutagenBonus("lib", 1)) {
				outputText("You feel a sense of warmth spread through your erogenous areas.");
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