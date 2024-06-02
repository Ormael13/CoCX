package classes.Items.Consumables
{
import classes.Items.Alchemy.AlchemyLib;
import classes.Items.Consumable;
import classes.StatusEffects;

/**
	 * Increases sensitivity.
	 */
	public class SensitivityDraft extends Consumable
	{
		private static const ITEM_VALUE:int = 15;
		
		public function SensitivityDraft()
		{
			super("SensDrf","SensDraft", "a bottle of sensitivity draft", ITEM_VALUE, "This carefully labelled potion is a 'Sensitivity Draft', and if the diagrams are any indication, it will make your body more sensitive.");
			refineableInto([], [], [[1, AlchemyLib.AR_SENS_DEC]]);
		}
		
		override public function useItem():Boolean
		{
			player.slimeFeed();
			clearOutput();
			outputText("You pop the cork on this small vial and drink down the clear liquid.  It makes your lips and tongue tingle strangely, letting you feel each globule of spit in your mouth and each breath of air as it slides past your lips.");

			if (player.hasStatusEffect(StatusEffects.Dysfunction)) {
				outputText("\n\nThankfully, the draft invigorates your groin, replacing the numbness with waves of raw sensation.  It seems your crotch is back to normal and <b>you can masturbate again!</b>");
				player.removeStatusEffect(StatusEffects.Dysfunction);
			}
			if (rand(4) == 0 && !player.hasStatusEffect(StatusEffects.LustyTongue)) {
				outputText("The constant tingling in your mouth grows and grows, particularly around your lips, until they feel as sensitive as ");
				if (player.hasVagina()) outputText("your");
				else outputText("a woman's");
				outputText(" lower lips.  You'll have to be careful not to lick them!");
				//(Lustytongue status)
				player.createStatusEffect(StatusEffects.LustyTongue, 25, 0, 0, 0);
			}
			outputText("\n\nAfter the wave of sensation passes, your [skin.type] feels a little more receptive to touch.  ");
			if (player.lust > 70 || player.lib > 70) {
				outputText("You shiver and think of how much better it'll make sex and masturbation.");
			}
			else outputText("You worry it'll make it harder to resist the attentions of a demon.");
			player.addCurse("sens", 10,2);
			dynStats("lus", Math.round(5*player.postConsumptionMlt()), "scale", false);
			player.refillHunger(5);
			
			return false;
		}
	}

}
