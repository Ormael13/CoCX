package classes.Items.Armors 
{
	import classes.Items.Armor;
	import classes.Items.UndergarmentLib;
	import classes.Player;
	
	public class LethiciteArmor extends Armor
	{	
		public function LethiciteArmor() 
		{
			super("LthcArm","Lthc. Armor","lethicite armor","a suit of glowing purple lethicite armor",28,3000,"This is a suit of lethicite armor. It's all purple and it seems to glow. The pauldrons are spiky to give this armor an imposing appearance. It doesn't seem to cover your crotch and nipples though. It appears to be enchanted to never break and you highly doubt the demons might be able to eat it!");
		}
		
		override public function get def():Number { return 20 + int(game.player.cor / 10); }
		
		override public function useText():void
		{
			outputText("You " + game.player.clothedOrNaked("strip yourself naked before you ") + "proceed to put on the strange, purple crystalline armor. ");
			if (game.player.cor < 33) outputText("You hesitate at how the armor will expose your groin but you proceed to put it on anyway. ");
			if (game.player.cor >= 33 && getGame().player.cor < 66) outputText("You are not sure about the crotch-exposing armor. ");
			if (game.player.cor >= 66) outputText("You are eager to show off once you get yourself suited up. ");
			//Put on breastplate
			outputText("\n\nFirst, you clamber into the breastplate. It has imposing, spiked pauldrons to protect your shoulders. The breastplate shifts to accommodate your [chest] and when you look down, your [nipples] are exposed. ");
			if (game.player.biggestLactation() >= 4) outputText("A bit of milk gradually flows over your breastplate. "); 
			//Put on leggings
			if (game.player.isBiped()) {
				outputText("\n\nNext, you slip into the leggings. By the time you get the leggings fully adjusted, you realize that the intricately-designed opening gives access to your groin! ");
				if (game.player.hasCock() && game.player.lowerGarment == UndergarmentLib.NOTHING) outputText("Your " + game.player.multiCockDescriptLight() + " hang" + (game.player.cocks.length == 1 ? "s" : "") + " freely. ");
				if (game.player.cor < 33) { //Low corruption
					if (game.player.lowerGarment != UndergarmentLib.NOTHING) outputText("Good thing you have your " + game.player.lowerGarment + " on!");
					else outputText("You blush with embarrassment. ");
				}
				else if (game.player.cor >= 33 && game.player.cor < 66) { //Medium corruption
					if (game.player.lowerGarment != UndergarmentLib.NOTHING) outputText("You are unsure about whether you should keep your " + game.player.lowerGarment + " on or not.");
					else outputText("You are unsure how you feel about your crotch being exposed to the world.");
				}
				else if (game.player.cor >= 66) { //High corruption
					if (game.player.lowerGarment != UndergarmentLib.NOTHING) outputText("You ponder over taking off your undergarments.");
					else outputText("You delight in having your nether regions open to the world.");
				}
				outputText(" Then, you slip your feet into the 'boots'; they aren't even covering your feet. You presume they were originally designed for demons, considering how the demons either have high-heels or clawed feet.");
			}
			else {
				outputText("\n\nThe leggings are designed for someone with two legs so you leave them into your pack.");
			}
			//Finishing touches
			outputText("\n\nFinally, you put the bracers on to protect your arms. Your fingers are still exposed so you can still get a good grip.");
			outputText("\n\nYou are ready to set off on your adventures!\n\n");
		}
	}

}