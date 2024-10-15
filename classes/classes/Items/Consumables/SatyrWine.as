package classes.Items.Consumables
{
import classes.Items.*;
import classes.Items.Alchemy.AlchemyLib;
import classes.Scenes.SceneLib;

/**
	 * Satyr Wine, part of the Black Cock by Foxxling
	 * @author Kitteh6660
	 */
	public class SatyrWine extends Consumable
	{
		
		public function SatyrWine()
		{
			super("SatyrWn", "SatyrWine", "a bottle of satyr wine", 20, "A dark bottle with a brilliant red liquid sloshing around inside. The label features a picture of a satyr playing pipes..");
			withTag(U_TF);
			refineableInto(
					AlchemyLib.DEFAULT_SUBSTANCES_DROP_TABLE,
					AlchemyLib.MULTIRACE_ESSENCE_DROP_TABLE(AlchemyLib.AE_SATYR, AlchemyLib.AE_GOAT)
			)
		}
		
		override public function useItem():Boolean {
			outputText("Feeling parched, you tug the cork from a bottle of wine. As you put the bottle to your lips and drink the rich, invigorating liquid, you soon find yourself with an empty bottle and a smile. ");
			mutations.DrunkenPowerEmpowerIfPossible();
			mutations.AelfwineEmpowerIfPossible();
            player.refillHunger(10);
			SceneLib.bazaar.blackCock.satyrTFs();
            return false;
		}
		
	}

}
