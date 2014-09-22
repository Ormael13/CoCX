package classes.Items.Armors 
{
	import classes.GlobalFlags.kFLAGS;
	import classes.ItemType;
	import classes.Items.Armor;
	import classes.Player;

	/**
	 * ...
	 * @author Kitteh6660
	 */
	public class BeeArmor extends Armor
	{
		override public function equipEffect(player:Player, output:Boolean):void
		{
			if(output) {
				outputText("\n\nYou first strip yourself naked. You start to equip your armor, one piece at a time. \n\nFirst, you clamber into the breastplate. ");
				if (player.isBiped()) //Some variants.
				{
					if (player.lowerBody == 0) outputText("Then you put your feet into your boots. With the boots fully equipped, you move on to the next piece. ");
					else outputText("Then you attempt to put your feet into your boots. You realize that the boots are designed for someone with normal feet. You have to modify the boots to fit and when you do put on your boots, your feet are exposed. ");
				}
				outputText("Next, you put on your chitinous bracers to protect your arms.\n\n")
				if (!player.isTaur() && !player.isDrider()) outputText("Last but not least, you put your silken loincloth on to cover your groin. You thank Rathazul for that and you know that you easily have access to your ");
				if (player.hasCock()) outputText(player.multiCockDescriptLight());
				if (player.hasCock() && player.hasVagina()) outputText(" and ");
				if (player.hasVagina()) outputText(player.vaginaDescript());
				//Genderless
				if (!player.hasCock() && !player.hasVagina()) outputText("groin");
				outputText(" should you need to. ");
				if (player.hasCock())
				{
					if (player.biggestCockArea() >= 40 && player.biggestCockArea() < 100)
					{
						outputText("Large bulge forms against your silken loincloth. ");
					}
					if (player.biggestCockArea() >= 100)
					{
						outputText("Your manhood is too big to be concealed by your silken loincloth. Part of your " + player.biggestCockIndex() + " is visible. ");
						if (player.cor < 33) outputText("You let out a sigh. ")
						if (player.cor >= 33 && player.cor < 66) outputText("You blush a bit, not sure how you feel. ")
						if (player.cor >= 66 || game.flags[kFLAGS.PC_FETISH] > 0) outputText("You admire how your manhood is visible. ")
					}
				}
				if (player.cor >= 66 || game.flags[kFLAGS.PC_FETISH] > 0)
				{
					outputText("You'd love to lift your loincloth and show off whenever you want to. ");
				}
				outputText("\n\nYou admire the design of your armor. No wonder it looks so sexy!")
			}
		}
		
		public function BeeArmor() 
		{
			super("BeeArmr","Bee Armor","sexy black chitin armor-plating","a set of chitinous armor",18,200,"A suit of armor cleverly fashioned from giant bee chitin. It comes with a silken loincloth to protect your modesty. \n\nType: Heavy armor \nDefense: 18 \nBase value: 200");
		}
		
	}

}