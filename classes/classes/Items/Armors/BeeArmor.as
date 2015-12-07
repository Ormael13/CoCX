package classes.Items.Armors 
{
	import classes.GlobalFlags.kFLAGS;
	import classes.ItemType;
	import classes.Items.Armor;
	import classes.Player;

	public class BeeArmor extends Armor
	{
		public function BeeArmor() 
		{
			super("BeeArmr","Bee Armor","sexy black chitin armor-plating","a set of chitinous armor",18,200,"A suit of armor cleverly fashioned from giant bee chitin. It comes with a silken loincloth to protect your modesty.");
		}
		
		override public function useText():void
		{
			outputText("\n\nYou" + game.player.clothedOrNaked(" first strip yourself naked and ") + " equip your armor, one piece at a time. \n\nFirst, you clamber into the breastplate. ");
			if (getGame().player.isBiped()) //Some variants.
			{
				if (getGame().player.lowerBody == 0) outputText("Then you put your feet into your boots. With the boots fully equipped, you move on to the next piece. ");
				else outputText("Then you attempt to put your feet into your boots. You realize that the boots are designed for someone with normal feet. You have to modify the boots to fit and when you do put on your boots, your feet are exposed. ");
			}
			outputText("Next, you put on your chitinous bracers to protect your arms.\n\n")
			if (!getGame().player.isTaur()) {
				outputText("Last but not least, you put your silken loincloth on to cover your groin. You thank Rathazul for that and you know that you easily have access to your ");
				if (getGame().player.hasCock()) outputText(getGame().player.multiCockDescriptLight());
				if (getGame().player.hasCock() && getGame().player.hasVagina()) outputText(" and ");
				if (getGame().player.hasVagina()) outputText(getGame().player.vaginaDescript());
				//Genderless
				if (!getGame().player.hasCock() && !getGame().player.hasVagina()) outputText("groin");
				outputText(" should you need to. ");
				if (getGame().player.hasCock())
				{
					if (getGame().player.biggestCockArea() >= 40 && getGame().player.biggestCockArea() < 100)
					{
						outputText("Large bulge forms against your silken loincloth. ");
					}
					if (getGame().player.biggestCockArea() >= 100)
					{
						outputText("Your manhood is too big to be concealed by your silken loincloth. Part of your " + getGame().player.cockDescriptShort(getGame().player.biggestCockIndex()) + " is visible. ");
						if (getGame().player.cor < 33) outputText("You let out a sigh. ");
						else if (getGame().player.cor >= 33 && getGame().player.cor < 66) outputText("You blush a bit, not sure how you feel. ");
						else if (getGame().player.cor >= 66 || game.flags[kFLAGS.PC_FETISH] > 0) outputText("You admire how your manhood is visible. ");
					}
				}
				if (getGame().player.cor >= 66 || game.flags[kFLAGS.PC_FETISH] > 0)
				{
					outputText("You'd love to lift your loincloth and show off whenever you want to. ");
				}
			}
			else {
				outputText("Last but not least, you take a silken loincloth in your hand but stop short as you examine your tauric body. There is no way you could properly conceal your genitals! ");
				if (getGame().player.cor < 33) outputText("You let out a sigh. Being a centaur surely is inconvenient! ");
				else if (getGame().player.cor >= 33 && getGame().player.cor < 66) outputText("You blush a bit, not sure how you feel. ");
				else if (getGame().player.cor >= 66 || game.flags[kFLAGS.PC_FETISH] > 0) outputText("Regardless, you are happy with what you are right now. ");
				outputText("You leave the silken loincloth in your possessions for the time being.");
			}
			outputText("\n\nYou admire the design of your armor. No wonder it looks so sexy!")
		}
	}
}