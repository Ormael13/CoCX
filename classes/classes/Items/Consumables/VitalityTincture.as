package classes.Items.Consumables
{
import classes.EngineCore;
import classes.Items.Consumable;

/**
	 * Item that increases VIT
	 */
	public class VitalityTincture extends Consumable
	{
		private static const ITEM_VALUE:int = 15;
		
		public function VitalityTincture()
		{
			super("Vital T", "Vitality T.", "a vitality tincture", ITEM_VALUE, "This potent tea is supposedly good for the strengthening the body.");
		}
		
		override public function useItem():Boolean
		{
			player.slimeFeed();
			clearOutput();
			player.slimeFeed();
			outputText("You down the contents of the bottle. The liquid is thick and tastes remarkably like cherries. Within moments, you feel much more healthy.");
			player.AlchemyBonus("tou", 1 + rand(2));
			if (EngineCore.HPChange(50, false)) outputText("  Any aches, pains and bruises you have suffered no longer hurt and you feel much better.");
			player.refillHunger(10);
			
			return false;
		}
	}
}