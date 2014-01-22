/**
 * Created by aimozg on 18.01.14.
 */
package classes.Scenes.Monsters
{
	import classes.Monster;

	public class AbstractSuccubus extends Monster
	{
		protected function whipAttack():void
		{
			if (hasStatusAffect("Whip Ready") >= 0) {
				//Blind dodge change
				if (hasStatusAffect("Blind") >= 0) {
					outputText(capitalA + short + " swings her whip at you wildly, totally missing due to her blindness!!", false);
					combatRoundOver();
					return;
				}
				outputText("Grinning deviously, the succubi cracks her whip with expert skill, landing a painful blow on your ", false);
				var temp:int = rand(6);
				//Whip yo ass!
				if (temp == 0) {
					outputText("ass (4)", false);
					player.takeDamage(4);
					game.dynStats("lus", 6 + int(player.sens / 20));
				}
				//Whip yo tits!
				if (temp == 1) {
					if (player.breastRows.length > 0 && player.biggestTitSize() > 0) outputText(player.allBreastsDescript() + " (9)", false);
					else outputText("chest (9)", false);
					player.takeDamage(9);
					game.dynStats("lus", 4 + int(player.sens / 15));
				}
				//Whip yo groin
				if (temp == 2) {
					if (player.gender == 0) {
						outputText("groin (5)", false);
						player.takeDamage(5);
					}
					if (player.gender == 1) {
						outputText("groin, dealing painful damage to your " + player.multiCockDescriptLight() + ", doubling you over in agony (" + int((player.tou * 2 + 50) / 4) + ")", false);
						game.dynStats("lus", -15);
						player.takeDamage(int((player.maxHP()) / 4));
					}
					if (player.gender == 2) {
						outputText("groin, making your " + vaginaDescript(0) + " sting with pain (-10)", false);
						player.takeDamage(10);
						game.dynStats("lus", -8);
					}
					if (player.gender == 3) {
						outputText("groin, dealing painful damage to your " + player.multiCockDescriptLight() + " and " + player.vaginaDescript(0) + ", doubling you over in agony (" + int((player.tou * 2 + 50) / 3) + ")", false);
						game.dynStats("lus", -20);
						player.takeDamage(int((player.maxHP()) / 3));
					}
				}
				//Whip yo legs
				if (temp == 3) {
					outputText("legs (7)", false);
					player.takeDamage(7);
				}
				//Whip yo arms
				if (temp == 4) {
					outputText("arms (8)", false);
					player.takeDamage(8);
				}
				//Whip yo neck
				if (temp == 5) {
					outputText("neck (24)", false);
					player.takeDamage(24);
				}
				outputText("!", false);
			}
			else {
				outputText("The succubus flicks her wrist, allowing a whip-like cord to slither out from the palm of her clawed hand.  She cracks the whip experimentally, cackling with glee.", false);
				createStatusAffect("Whip Ready", 0, 0, 0, 0);
				str += 20;
				setWeaponName("whip");
				setWeaponVerb("brutal whip-crack");
			}
			combatRoundOver();
		}

		public function AbstractSuccubus()
		{
		}

		protected function kissAttack():void
		{
			//[Kiss of Death Text]
			outputText("The succubus dances forwards, cocking her elbow back for a vicious strike.", false);
			//avoid!
			if (player.spe > spe && rand(4) == 0 || (player.hasPerk("Evade") >= 0 && rand(4) == 0) || (player.hasPerk("Misdirection") >= 0 && rand(4) == 0 && player.armorName == "red, high-society bodysuit")) {
				outputText("  You start to sidestep and realize it's a feint.   Ducking low, you slide under her real attack...a kiss?!  ", false);
				if (player.lust >= 70) outputText("  Maybe you shouldn't have bothered to move, it might have been fun.", false);
			}
			//get hit
			else {
				outputText("  You start to dodge to the side, but she shifts direction expertly and plants a wet kiss on your lips.  She spins and dodges away with a ballet dancer's grace, leaving you to wonder what just happened.  ", false);
				if (player.hasStatusAffect("Kiss of Death") < 0) player.createStatusAffect("Kiss of Death", 0, 0, 0, 0);
			}
			combatRoundOver();
		}

		protected function seduceAttack():void
		{
			var temp:int;
			//determine which method of teasing you use
			temp = rand(3);
			//Butt slap!
			if (temp == 0) {
				outputText(capitalA + short + " slaps her " + game.eButtDescript(), false);
				if (buttRating >= 10) {
					outputText(", making it jiggle delightfully.", false);
					//85% success rate for the jiggly girls
					if (rand(100) <= 95) {
						game.dynStats("lus", rand(buttRating) + 10);
						outputText("\nThe display is quite arousing.", false);
					}
					else outputText("\nYou're unimpressed.\n\n", false);
				}
				else {
					outputText(".", false);
					//50%ish chance of success for the tight butted.
					if (rand(100) <= (70 + buttRating * 2)) {
						game.dynStats("lus", rand(buttRating) + 9);
						outputText("\nThe display is quite arousing.", false);
					}
					else outputText("\nYou're unimpressed.\n\n", false);
				}
			}
			//Jiggly-tits
			if (temp == 1 && breastRows[0].breastRating >= 2) {
				//rand(breastRating) + breastRows*BreastperRow
				//Single breast row
				if (breastRows.length == 1) {
					//50+ breastsize% success rate
					outputText(capitalA + short + " caresses some of her ample chest-flesh before shaking it from side to side enticingly.", false);
					if (lust >= 50) outputText("  " + pronoun2 + " hard nipples seem to demand your attention.", false);
					if (rand(100) <= (65 + biggestTitSize())) {
						game.dynStats("lus", rand(breastRows[0].breastRating) + breastRows.length + 10);
						outputText("\nThe display is quite arousing.", false);
					}
					else outputText("\nYou're unimpressed.\n\n", false);
				}
				if (breastRows.length > 1) {
					//50 + 10% per breastRow + breastSize%
					outputText(capitalA + short + " caresses " + pronoun2 + " some of her rows of ample chest-flesh before shaking it all from side to side enticingly.", false);
					if (lust >= 50) outputText(", your " + nippleDescript(0) + "s painfully visible.", false);
					else outputText(".", false);
					if (rand(100) <= (54 + (breastRows.length - 1) * 15 + breastRows[0].breastRating)) {
						game.dynStats("lus", rand(breastRows[0].breastRating) + breastRows.length * breastRows[0].breasts + 5);
						outputText("\nThe display is quite arousing.", false);
					}
					else outputText("\nYou're unimpressed.\n\n", false);
				}
			}
			//Genetals flash!
			if (temp == 2) {
				outputText(capitalA + short + " reaches down and strokes her moist lips.  She sighs and licks her fingers clean, giving you a smouldering gaze.", false);
				//Success = 50% + 10% times each cock/vagina
				//rand(vaginas*2 + cocks*2) + wetness and/or length/6
				if (rand(101) <= (65 + vaginas.length * 10 + cocks.length * 10)) {
					game.dynStats("lus", rand(vaginas.length * 2 + cocks.length * 2) + 13);
					outputText("\nThe display is quite arousing.", false);
				}
				else outputText("\nYou're unimpressed.\n\n", false);
			}
			combatRoundOver();
		}
	}
}
