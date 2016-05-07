package classes.Items.Consumables 
{
	import classes.Items.*;
	/**
	 * Satyr Wine, part of the Black Cock by Foxxling
	 * @author Kitteh6660
	 */
	public class SatyrWine extends Consumable
	{
		
		public function SatyrWine() 
		{
			super("SatyrWn", "SatyrWine", "a bottle of satyr wine", 30, "A dark bottle with a brilliant red liquid sloshing around inside. On the label there is a picture of a satyr playing pipes.");
		}
		
		override public function useItem():Boolean {
			outputText("Feeling parched you tug the cork from a bottle of wine. As you put the bottle to your lips and drink the rich, invigorating liquid you soon find yourself with an empty bottle and a smile. ");
			getGame().player.refillHunger(10);
			getGame().bazaar.blackCock.satyrTFs();
			return false;
		}
		
	}

}