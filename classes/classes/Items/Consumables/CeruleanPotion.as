package classes.Items.Consumables
{
	import classes.GlobalFlags.kFLAGS;
	import classes.Items.Consumable;
	import classes.StatusEffects;

	/**
	 * Item that triggers succubus events.
	 */
	public class CeruleanPotion extends Consumable
	{
		private static const ITEM_VALUE:int = 75;
		
		public function CeruleanPotion()
		{
			super("Cerul P", "Cerulean P.", "a cerulean-tinted potion", ITEM_VALUE, "This is a mysterious bottle filled with a sky-blue liquid that sloshes gently inside.  Supposedly, it will make you irresistible, though to who or what is unkown.");
		}
		
		override public function useItem():Boolean
		{
			clearOutput();
			player.slimeFeed();
			//Repeat genderless encounters
			if (player.gender == 0 && flags[kFLAGS.CERULEAN_POTION_NEUTER_ATTEMPTED] > 0) {
				outputText("You take another sip of the Cerulean Potion.  You find it soothing and become very excited about the possibility of another visit from the succubus.");
			}
			else if (player.gender == 3 && flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00111] > 0) {
				outputText("With anticipation, you chug down another bottle of the Cerulean Potion. A warm sensation radiates out from your stomach as you feel the potion course through your body.");
			}
			//All else
			else {
				outputText("The liquid tastes rather bland and goes down easily. ");
				//Special repeat texts
				if (player.hasStatusEffect(StatusEffects.RepeatSuccubi)) outputText("You look forwards to tonight's encounter.");
				//First timer huh?
				else outputText("You do not notice any real effects.  Did the merchant con you?");
			}
			if (player.hasStatusEffect(StatusEffects.SuccubiNight)) {
				if (player.statusEffectv1(StatusEffects.SuccubiNight) < 3) player.addStatusValue(StatusEffects.SuccubiNight,1,1);
			}
			else player.createStatusEffect(StatusEffects.SuccubiNight, 1, 0, 0, 0);
			player.refillHunger(20);
			
			return false;
		}
	}
}