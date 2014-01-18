/**
 * Created by aimozg on 18.01.14.
 */
package classes.Items.Armors
{
	import classes.Items.Armor;
	import classes.Items.ArmorLib;
	import classes.Player;

	public class SluttySwimwear extends ArmorWithPerk
	{

		override public function equipEffect(player:Player, output:Boolean):void
		{
			if(output) game.dynStats("lus", 5);
			if(output) {
				//[flat-chested]
				if(player.biggestTitSize() < 1) outputText("You feel rather stupid putting the top part on like this, but you're willing to bear with it. It could certainly be good for distracting.  ");
				//[breasts]
				else {
					outputText("The bikini top clings tightly to your bustline, sending a shiver of pleasure through your body. It serves to turn you on quite nicely.  ");
					game.dynStats("lus", 5);
				}
				//[no dick]
				if(player.totalCocks() == 0) {
					outputText("The thong moves over your smooth groin, clinging onto your buttocks nicely.  ");
					if(player.balls > 0) {
						if(player.ballSize > 5) outputText("You do your best to put the thong on, and while the material is very stretchy, it simply can't even begin to cover everything, and your " + player.ballsDescriptLight() + " hang on the sides, exposed.  Maybe if you shrunk your male parts down a little...");
						else outputText("However, your testicles do serve as an area of discomfort, stretching the material and bulging out the sides slightly.  ");
					}
				}
				//[dick]
				else {
					if(player.totalCocks() == 1) {
						outputText("You grunt in discomfort, your " + player.cockDescript(0) + " flopping free from the thong's confines. The tight material rubbing against your dick does manage to turn you on slightly.  ");
					}
					else {
						outputText("You grunt in discomfort, your " + player.multiCockDescriptLight() + " flopping free from the thong's confines. The tight material rubbing against your dicks does manage to turn you on slightly.  ");
					}
					game.dynStats("lus", 5);
					if(player.biggestCockArea() >= 20) outputText("You do your best to put the thong on, and while the material is very stretchy, it simply can't even begin to cover everything, and your " + player.cockDescript(0) + " has popped out of the top, completely exposed.  Maybe if you shrunk your male parts down a little...");
					//[If dick is 7+ inches OR balls are apple-sized]
					else if(player.ballSize > 5) outputText("You do your best to put the thong on, and while the material is very stretchy, it simply can't even begin to cover everything, and your " + player.ballsDescriptLight() + " hang on the sides, exposed.  Maybe if you shrunk your male parts down a little...");
				}
				outputText("\n\n");
			}
		}

		public function SluttySwimwear()
		{
			super("S.Swmwr","S.Swmwr","slutty swimwear","a skimpy black bikini",0,ArmorLib.DEFAULT_VALUE,"An impossibly skimpy black bikini. You feel dirty just looking at it… and a little aroused, actually.","Light",
					"Slutty Seduction",6,0,0,0,"Your revealing swimwear allows you access to 'Seduce', an improved form of 'Tease'."
			);
		}
	}
}
