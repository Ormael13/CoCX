package classes.Items.Consumables 
{
import classes.CoC;
import classes.Items.*;
import classes.Scenes.SceneLib;
import classes.StatusEffects;

/**
	 * Satyr Wine, part of the Black Cock by Foxxling
	 * @author Kitteh6660
	 */
	public class SatyrWine extends Consumable
	{
		
		public function SatyrWine() 
		{
			super("SatyrWn", "SatyrWine", "a bottle of satyr wine", 20, "A dark bottle with a brilliant red liquid sloshing around inside. On the label there is a picture of a satyr playing pipes.");
		}
		
		override public function useItem():Boolean {
			outputText("Feeling parched you tug the cork from a bottle of wine. As you put the bottle to your lips and drink the rich, invigorating liquid you soon find yourself with an empty bottle and a smile. ");
			if (!player.hasStatusEffect(StatusEffects.DrunkenPower) && CoC.instance.inCombat && player.oniScore() >= CoC.instance.mutations.DrunkenPowerEmpowerOni()) CoC.instance.mutations.DrunkenPowerEmpower();
            player.refillHunger(10);
			SceneLib.bazaar.blackCock.satyrTFs();
            return false;
		}
		
	}

}