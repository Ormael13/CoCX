/**
 * Created by aimozg on 18.01.14.
 */
package classes.Scenes.Monsters
{
	import classes.*;
	import classes.Items.*
	
	public class AbstractSuccubus extends Monster
	{
		protected function whipAttack():void
		{
			if (hasStatusEffect(StatusEffects.WhipReady)) {
				//Blind dodge change
				if (hasStatusEffect(StatusEffects.Blind)) {
					outputText(capitalA + short + " swings her " + weaponName + " at you wildly, totally missing due to her blindness!!");
					return;
				}
				outputText("Grinning deviously, the ");
				if (this.short == "omnibus") outputText("omnibus");
				else if (this.short == "cow succubus") outputText("cow succubus");
				else outputText("succubus");
				outputText(" cracks her " + weaponName + " with expert skill, landing a painful blow on your ");
				var temp:int = rand(6);
				var damage:int;
				//Whip yo ass!
				if (temp == 0) {
					outputText("ass");
					damage = 4;
					player.takeLustDamage(6 + int(player.effectiveSensitivity() / 20), true);
				}
				//Whip yo tits!
				if (temp == 1) {
					if (player.breastRows.length > 0 && player.biggestTitSize() > 0) outputText(player.allBreastsDescript() + "");
					else outputText("chest");
					damage = 9 - player.armor.def;
					if (damage <= 0) {
						outputText(" but you feel no pain thanks to your protection");
						damage = 0;
					}
					player.takeLustDamage(4 + int(player.effectiveSensitivity() / 15), true);
				}
				//Whip yo groin
				if (temp == 2) {
					var groinProtection:int = 0;
					//Take armor in account.
					if (!player.armor.isNothing) {
						if (player.armor.perk == "Light") groinProtection = 1;
						else if (player.armor.perk == "Medium") groinProtection = 2;
						else groinProtection = 3;
						//Certain armor affects protection.
						if (player.armor == armors.BEEARMR || player.armor == armors.SSARMOR || player.armor == armors.DBARMOR || player.armor == armors.TBARMOR) groinProtection = 2; //The only thing protecting your groin is a loincloth.
						if (player.armor == armors.GOOARMR) groinProtection = 2; //Goo armor is soft and gooey so not complete protection.
						if (player.armor == armors.LTHCARM) groinProtection = 0; //Lethicite armor exposes your groin.
					}
					//Wearing armored undergarments? BONUS POINTS!
					if (!player.lowerGarment.isNothing) {
						if (player.lowerGarment == undergarments.SS_LOIN || player.lowerGarment == undergarments.SSPANTY) groinProtection += 1;
						else if (player.lowerGarment == undergarments.DS_LOIN || player.lowerGarment == undergarments.DSTHONG) groinProtection += 2;
					}
					//Apply damage
					if (groinProtection >= 3) {
						outputText("groin but luckily you're wearing groin protection");
						damage = 0;
					}
					else {
						if (player.gender == 0) {
							outputText("groin");
							damage = 5;
							damage = int(damage / (groinProtection + 1));
						}
						if (player.gender == 1) {
							outputText("groin, dealing painful damage to your [cocks], doubling you over in agony");
							damage = int((player.maxHP()) / 4);
							if (groinProtection > 0) {
								outputText("! Of course, it would have been worse if you didn't wear groin protection");
								damage = int(damage / (groinProtection + 1));
							}
							if (damage < 20) damage = 10;
							player.takeLustDamage(-15, true);
						}
						if (player.gender == 2) {
							outputText("groin, making your " + vaginaDescript(0) + " sting with pain");
							damage = 10;
							player.takeLustDamage(-8, true);
						}
						if (player.gender == 3) {
							outputText("groin, dealing painful damage to your [cocks] and " + player.vaginaDescript(0) + ", doubling you over in agony");
							damage = int((player.maxHP()) / 3);
							if (groinProtection > 0) {
								outputText("! Of course, it would have been worse if you didn't wear groin protection");
								damage = int(damage / (groinProtection + 1));
							}
							if (damage < 30) damage = 30;
							player.takeLustDamage(-20, true);
						}
					}
				}
				//Whip yo legs
				if (temp == 3) {
					outputText("legs");
					damage = 7;
				}
				//Whip yo arms
				if (temp == 4) {
					outputText("arms");
					damage = 8;
				}
				//Whip yo neck
				if (temp == 5) {
					outputText("neck");
					damage = 24;
				}
				outputText("! ");
				damage *= 0.1;
				var damage2:Number = damage * this.weaponAttack;
				player.takePhysDamage(damage2, true);
			}
			else {
				outputText("The ");
				if (this.short == "omnibus") outputText("omnibus");
				else if (this.short == "cow succubus") outputText("cow succubus");
				else outputText("succubus");
				outputText(" flicks her wrist, allowing a whip-like cord to slither out from the palm of her clawed hand.  She cracks the " + weaponName + " experimentally, cackling with glee.");
				createStatusEffect(StatusEffects.WhipReady, 0, 0, 0, 0);
				this.strStat.core.value += 20;
			}
		}

		public function AbstractSuccubus()
		{
		}

		protected function kissAttack():void
		{
			//[Kiss of Death Text]
			outputText("The ");
			if (this.short == "omnibus") outputText("omnibus");
			else outputText("succubus");
			outputText(" dances forwards, cocking her elbow back for a vicious strike.");
			//avoid!
			if (player.getEvasionRoll()) {
				outputText("  You start to sidestep and realize it's a feint.   Ducking low, you slide under her real attack... a kiss?!  ");
				if (player.lust >= maxLust() * 0.7) outputText("  Maybe you shouldn't have bothered to move, it might have been fun.");
			}
			//get hit
			else {
				outputText("  You start to dodge to the side, but she shifts direction expertly and plants a wet kiss on your lips.  She spins and dodges away with a ballet dancer's grace, leaving you to wonder what just happened.  ");
				if (!player.hasStatusEffect(StatusEffects.KissOfDeath)) player.createStatusEffect(StatusEffects.KissOfDeath, 0, 0, 0, 0);
			}
		}

		protected function seduceAttack():void
		{
			var temp:int;
			//determine which method of teasing you use
			temp = rand(3);
			//Butt slap!
			if (temp == 0) {
				outputText(capitalA + short + " slaps her " + Appearance.buttDescriptionShort(this));
				if (butt.type >= 10) {
					outputText(", making it jiggle delightfully.");
					//85% success rate for the jiggly girls
					if (rand(100) <= 95) {
						player.takeLustDamage(rand(butt.type) + 10, true);
						outputText("\nThe display is quite arousing.");
					}
					else outputText("\nYou're unimpressed.\n\n");
				}
				else {
					outputText(".");
					//50%ish chance of success for the tight butted.
					if (rand(100) <= (70 + butt.type * 2)) {
						player.takeLustDamage(rand(butt.type) + 9, true);
						outputText("\nThe display is quite arousing.");
					}
					else outputText("\nYou're unimpressed.\n\n");
				}
			}
			//Jiggly-tits
			if (temp == 1 && breastRows[0].breastRating >= 2) {
				//rand(breastRating) + breastRows*BreastperRow
				//Single breast row
				if (breastRows.length == 1) {
					//50+ breastsize% success rate
					outputText(capitalA + short + " caresses some of her ample chest-flesh before shaking it from side to side enticingly.");
					if (lust >= maxLust() * 0.5) outputText("  " + pronoun2 + " hard nipples seem to demand your attention.");
					if (rand(100) <= (65 + biggestTitSize())) {
						player.takeLustDamage(rand(breastRows[0].breastRating) + breastRows.length + 10, true);
						outputText("\nThe display is quite arousing.");
					}
					else outputText("\nYou're unimpressed.\n\n");
				}
				if (breastRows.length > 1) {
					//50 + 10% per breastRow + breastSize%
					outputText(capitalA + short + " caresses " + pronoun2 + " some of her rows of ample chest-flesh before shaking it all from side to side enticingly.");
					if (lust >= maxLust() * 0.5) outputText(", your " + nippleDescript(0) + "s painfully visible.");
					else outputText(".");
					if (rand(100) <= (54 + (breastRows.length - 1) * 15 + breastRows[0].breastRating)) {
						player.takeLustDamage(rand(breastRows[0].breastRating) + breastRows.length * breastRows[0].breasts + 5, true);
						outputText("\nThe display is quite arousing.");
					}
					else outputText("\nYou're unimpressed.\n\n");
				}
			}
			//Genetals flash!
			if (temp == 2) {
				if (this.short == "omnibus") outputText(capitalA + short + " spreads her legs and buries three fingers in her sopping twat, her thumb vigorously rubbing against the base of her bumpy prick.  Her other hand wraps around the meaty pole and begins jerking it rapidly.  In one practiced movement she stops jerking long enough to wrap the whip around her nodule-studded demon-cock, using it like a cockring.  The organ swells thanks to the forced blood-flow, and after a few more seconds of intense masturbation, the demoness cums hard.  Her cunny squirts all over her hand, dripping clear feminine drool down her thighs.  The omnibus' masculine endowment pulses and twitches, blasting out two big squirts of jizm before it slows to a trickle.");
				else outputText(capitalA + short + " reaches down and strokes her moist lips.  She sighs and licks her fingers clean, giving you a smoldering gaze.");
				//Success = 50% + 10% times each cock/vagina
				//rand(vaginas*2 + cocks*2) + wetness and/or length/6
				if (rand(101) <= (65 + vaginas.length * 10 + cocks.length * 10)) {
					player.takeLustDamage(rand(vaginas.length * 2 + cocks.length * 2) + 13, true);
					outputText("\nThe display is quite arousing.");
				}
				else outputText("\nYou're unimpressed.\n\n");
			}
		}
	}
}
