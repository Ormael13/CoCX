package classes.Items.Consumables 
{
	import classes.Items.*;
	/**
	 * Golden Rind/Deer TF, part of the Wild Hunt by Frogapus
	 * @author Kitteh6660
	 */
	public class GoldenRind extends Consumable
	{
		
		public function GoldenRind() 
		{
			super("GldRind", "GoldenRind", "a golden rind", ConsumableLib.DEFAULT_VALUE, "This shimmering, citrus peel is shaped like a corkscrew and smells sweet and sour at the same time.");
		}
		
		override public function useItem():Boolean {
			outputText("You pop the sliver of fruit in your mouth, delighting in the sweetness and tanginess as you chew it.  A burst of lime-like tartness slaps your senses, and you feel an answering tingle further down in your body.");
			getGame().player.refillHunger(10);
			getGame().forest.erlkingScene.deerTFs();
			return false;
		}
	}

}