/**
 * Created by aimozg on 18.01.14.
 */
package classes.Items.Armors
{
	import classes.Items.Armor;
	import classes.Items.ArmorLib;
	import classes.PerkLib;
	import classes.Player;
	import classes.Items.UndergarmentLib;

	public class BimboSkirt extends ArmorWithPerk {
		
		public function BimboSkirt() {
			super("BimboSk","BimboSk","bimbo skirt","a skirt that looks like it belongs on a bimbo",1,50,"A tight, cleavage-inducing halter top and an extremely short miniskirt.  The sexual allure of this item is undoubtable.","Light", PerkLib.SluttySeduction,10,0,0,0,"Your delightfully slutty yet upbeat garb helps you seduce your foes!", false, false);
		}
		
		override public function useText():void { //Produces any text seen when equipping the armor normally
			
			var wornUpper:Boolean = (game.player.upperGarment != UndergarmentLib.NOTHING);
			var wornLower:Boolean = (game.player.lowerGarment != UndergarmentLib.NOTHING);
			
			if (wornLower && wornLower) {
				outputText("You look very awkward wearing " + game.player.lowerGarment.longName + " and putting your skirt on.");
				outputText(" You realize that you probably won't be able to seduce much of your foes in this ludicrous outfit. For a moment you consider putting your " + game.player.lowerGarment.longName + " off, but then decide against it.");
				return;
			}
		
			game.dynStats("lus", 5);
			
			if (!wornUpper) {
				if 		(game.player.biggestTitSize() >= 8) {
					outputText("The halter top clings tightly to your bustline, sending a shiver of pleasure through your body. You feel how your erect [nipples] protrude from the soft fabric of you beautiful dress, and sensation make you feel slightly dizzy. ");
					if (game.player.isLactating()) {
						outputText("You feel how the top your dress become wet, as droplets of milk sip from your [nipples]. ");
					}
				}
				else if (game.player.biggestTitSize() >= 5) {
					outputText("The halter top clings to your bustline, sending a shiver of pleasure through your body. ");
					if (game.player.isLactating()) {
						outputText("You feel how the top your dress becomes wet, as droplets of milk sip from your [nipples]. ");
					}
					game.dynStats("lus", 2);
				}
				else if (game.player.biggestTitSize() >= 2) {
					outputText("The halter top of your sluttish outfit snugly embraces your " + game.player.breastDescript(0) + ". Sensation of a soft fabric on your bare [nipples] makes you feel warm and sexy. ");
					if (game.player.isLactating()) {
						outputText("You feel how the top your dress become wet, as droplets of milk sip from your [nipples]. ");
					}
					game.dynStats("lus", 5);
				}
				else if (game.player.biggestTitSize() >= 1) {
					outputText("You feel how soft fabric of your dress caresses your " + game.player.breastDescript(0) + ". Sensation is very erotic and you touch your sensitive [nipples], feeling the spread of arousal. You idly notice that halter top of your whorish dress is somewhat loose, and it would feel much better if only your breasts would be bigger and suppler. ");
					if (game.player.isLactating()) {
						outputText("You feel how the top your dress become wet, as droplets of milk sip from your [nipples]. ");
					}
					game.dynStats("lus", 10);
				}
				else {
					outputText("You feel rather stupid putting the top part on like this, but you're willing to bear with it. As you put it on, you feel how soft fabric of your dress touches your [nipples], making them erect.");
					game.dynStats("lus", 15);
				}
				outputText("\n\n");
				game.player.orgasm('Tits',false); 
			}
			
			if (!wornLower) {
				if (game.player.buttRating < 8) {
					outputText("Sensation of tender fabric clinging to your [butt] arouses you immensely, as you smooth your skirt. ");
				}
				else {
					outputText("You feel how fine fabric of your sluttish skirt don't quite cover your [ass]");
					if (game.player.hipRating > 8) {
						outputText(", and smooth skirt is stretched by your [hips]. ");
					}
					else outputText(". ");
				}
				if (game.player.hasCock()) {
					outputText("Your [cock] becomes erect under your obscene skirt, bulging unnaturally. ");
				}
				else {
					switch (game.player.vaginas[0].vaginalWetness) {
						
						case 5:
							outputText("Your juice constantly escapes your [pussy] and spoils your sexy skirt. ");
							game.dynStats("lus", 5);
							break;
						case 4:
							outputText("Thin stream of your girl-cum escapes your [pussy] and spoils your skirt. ");
							game.dynStats("lus", 5);
							break;
						case 3:
							outputText("Your [pussy] becomes all tingly and wet under your slutty skirt. ");
							game.dynStats("lus", 5);
							break;
					}
					
				}
				outputText("\n\n");
				game.player.orgasm('Anal', false);
				game.player.orgasm('Vaginal', false);
			}
			
			game.player.orgasm('Lips',false);
		}
	
		override public function get supportsUndergarment():Boolean {
			if (game.player.cor >= 10) return false;
			return true; 
		}
		
		override public function canUse():Boolean {
			
			var wornUpper:Boolean = game.player.upperGarment != UndergarmentLib.NOTHING;
			var wornLower:Boolean = game.player.lowerGarment != UndergarmentLib.NOTHING;
			
			if (game.player.cor >= 10) {
				
				if (wornUpper || wornLower) {
					var output:String = "";
					

					output += "It would be awkward to put on " + longName + " when you're currently wearing ";
					if (wornUpper) {
						output += game.player.upperGarment.longName;
						wornUpper = true;
					}
					if (wornLower) {
						if (wornUpper) {
							output += " and ";
						}
						output += game.player.lowerGarment.longName;
					}
					output += ". You should consider removing them. You put it back into your inventory.";
					outputText(output);
					return false;
				}
				else 
					return true;
			}
			return true;

		}
	}
	
	
}
