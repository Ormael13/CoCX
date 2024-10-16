package classes.Items.Armors
{
	import classes.GlobalFlags.kFLAGS;
import classes.CoC;
import classes.ItemType;
	import classes.Items.Armor;
	import classes.Player;
	
	/**
	 * ...
	 * @author Kitteh6660
	 */
	public class PureMaraeArmor extends Armor
	{
		public function PureMaraeArmor()
		{
			super("DB.Armr","D.B.Armor","divine bark armor","a suit of divine bark armor",120,120,28800,"This suit of armor is finely made from the white bark you've received from Marae as a reward.","Heavy");
		}
		//każde 1 armor point kosztuje 120
		override public function get supportsBulge():Boolean { return true; }
		
		override public function get def():Number { return 20 + (100 - game.player.cor); }
		override public function get mdef():Number { return 20 + (100 - game.player.cor); }
		
		override public function equipText():void
		{
			outputText("You strip yourself naked before you proceed to put on the armor. ");
			
			outputText("\n\nFirst, you clamber into the breastplate. ");
            if (CoC.instance.player.isBiped()) //Some variants.
            {
                if (CoC.instance.player.lowerBody == 0) outputText("Then you put your feet into your boots. With the boots fully equipped, you move on to the next piece. ");
                else outputText("Then you attempt to put your feet into your boots. You realize that the boots are designed for someone with normal feet. You have to modify the boots to fit and when you do put on your boots, your feet are exposed. ");
			}
			outputText("Next, you put on your reinforced bark bracers to protect your arms.\n\n");
            if (!CoC.instance.player.isTaur()) {
                outputText("Last but not least, you put your silken loincloth on to cover your groin. You thank Konstantin for that, and you know that you easily have access to your ");
                if (CoC.instance.player.hasCock()) outputText(CoC.instance.player.multiCockDescriptLight());
                if (CoC.instance.player.hasCock() && CoC.instance.player.hasVagina()) outputText(" and ");
                if (CoC.instance.player.hasVagina()) outputText("[vagina]");
                //Genderless
                if (!CoC.instance.player.hasCock() && !CoC.instance.player.hasVagina()) outputText("groin");
                outputText(" should you need to. ");
                if (CoC.instance.player.hasCock()) {
                    if (CoC.instance.player.biggestCockArea() >= 40 && CoC.instance.player.biggestCockArea() < 100) {
                        outputText("A large bulge forms against your silken loincloth. ");
					}
                    if (CoC.instance.player.biggestCockArea() >= 100) {
                        outputText("Your manhood is too big to be concealed by your silken loincloth. Part of your " + CoC.instance.player.cockDescriptShort(CoC.instance.player.biggestCockIndex()) + " is visible. ");
                        if (CoC.instance.player.cor < 33) outputText("You let out a sigh. ");
                        else if (CoC.instance.player.cor >= 33 && CoC.instance.player.cor < 66) outputText("You blush a bit, not sure how you feel. ");
                        else if (CoC.instance.player.cor >= 66 || game.flags[kFLAGS.PC_FETISH] > 0) outputText("You admire how your manhood is visible. ");
                    }
				}
                if (CoC.instance.player.cor >= 66 || game.flags[kFLAGS.PC_FETISH] > 0) {
					outputText("You'd love to lift your loincloth and show off whenever you want to. ");
				}
			}
			else {
				outputText("Last but not least, you take a silken loincloth in your hand but stop short as you examine your tauric body. There is no way you could properly conceal your genitals! ");
                if (CoC.instance.player.cor < 33) outputText("You let out a sigh. Being a centaur surely is inconvenient! ");
                else if (CoC.instance.player.cor >= 33 && CoC.instance.player.cor < 66) outputText("You blush a bit, not sure how you feel. ");
                else if (CoC.instance.player.cor >= 66 || game.flags[kFLAGS.PC_FETISH] > 0) outputText("Regardless, you are happy with what you are right now. ");
                outputText("You leave the silken loincloth in your possessions for the time being.");
			}
			outputText("You are suited up and all good to go. ");
		}
	}
}
