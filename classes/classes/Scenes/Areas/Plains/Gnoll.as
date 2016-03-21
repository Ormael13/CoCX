package classes.Scenes.Areas.Plains
{
	import classes.*;
	import classes.internals.*;

	/**
	 * ...
	 * @author ...
	 */
	public class Gnoll extends Monster 
	{

		//Gnoll Description
		private function gnollAttackText():void {
			var damage:Number = 0;
			var attack:Number = rand(6);
			//return to combat menu when finished
			doNext(game.playerMenu);
			//Blind dodge change
			if (findStatusEffect(StatusEffects.Blind) >= 0 && rand(3) < 2) {
				outputText(capitalA + short + " completely misses you with a blind attack!\n", false);
			}
			//Determine if dodged!
			else if (player.spe - spe > 0 && int(Math.random()*(((player.spe-spe)/4) +80)) > 80) {
				if (player.spe - spe < 8) outputText("You narrowly avoid " + a + short + "'s " + weaponVerb + "!\n", false);
				else if (player.spe - spe >= 8 && player.spe-spe < 20) outputText("You dodge " + a + short + "'s " + weaponVerb + " with superior quickness!\n", false);
				else if (player.spe - spe >= 20) outputText("You deftly avoid " + a + short + "'s slow " + weaponVerb + ".\n", false);
			}
			//Determine if evaded
			else if (player.findPerk(PerkLib.Evade) >= 0 && rand(100) < 10) {
				outputText("Using your skills at evading attacks, you anticipate and sidestep " + a + short + "'s attack.\n", false);
			}
			//("Misdirection"
			else if (player.findPerk(PerkLib.Misdirection) >= 0 && rand(100) < 10 && player.armorName == "red, high-society bodysuit") {
				outputText("Using Raphael's teachings, you anticipate and sidestep " + a + short + "' attacks.\n", false);
			}
			//Determine if cat'ed
			else if (player.findPerk(PerkLib.Flexibility) >= 0 && rand(100) < 6) {
				outputText("With your incredible flexibility, you squeeze out of the way of " + a + short + "", false);
				if (plural) outputText("' attacks.\n", false);
				else outputText("'s attack.\n", false);
			}
			else {
				//Determine damage - str modified by enemy toughness!
				damage = int((str + weaponAttack) - Math.random()*(player.tou) - player.armorDef);
				if (damage <= 0) {
					damage = 0;
					//hapies have their own shit
					if (short == "harpy") outputText("The harpy dives at you with her foot-talons, but you deflect the attack, grasp onto her leg, and swing her through the air, tossing her away from you before she has a chance to right herself.", false);
					//Due to toughness or amor...
					else if (rand(player.armorDef + player.tou) < player.armorDef) outputText("Your " + player.armorName + " absorb and deflect every " + weaponVerb + " from " + a + short + ".", false);
					else outputText("You deflect and block every " + weaponVerb + " " + a + short + " throws at you.", false);
				}
				//everyone else
				else {
					//Gnoll Attack #1
					if (attack == 0) {
						outputText("The gnoll leaps forward, her jaws slamming shut across your upper arm.  She twists away before you can touch her, laughing the entire time.", false);
						damage += 10;
					}
					//Gnoll Attack #2
					else if (attack == 1) {
						outputText("With a shudder and lurch, the gnoll barrels forward into your gut, the claws of her free hand raking across your belly.", false);
						damage += 3;
					}
					//Gnoll Attack #3
					else if (attack == 2) {
						outputText("The gnoll tumbles to the ground, then comes up with a handful of sand.  The sand goes in your face; the club goes into your cheek.  Ow.", false);
						damage += 13;
					}
					//Gnoll Attack #4
					else if (attack == 3) {
						outputText("The hyena girl giggles and darts forward, teeth snapping.  Spittle flies everywhere, and the snapping teeth find purchase, drawing red lines across your body.", false);
						damage += 8;
					}
					//Gnoll Attack #5
					else if (attack == 4) {
						outputText("With a mocking laugh, the gnoll brings her club high and then down in a savage strike that catches you across the temple.", false);
						damage += 25;
					}
					//Gnoll Attack #6
					else {
						outputText("The gnoll waves her club threateningly, but it's her foot that snaps up from the dusty plain to connect with your gut.", false);
					}
					outputText(" ");
					player.takeDamage(damage, true);
				}
				game.statScreenRefresh();
			}
		}
		
		private function gnollTease():void {
			var tease:Number = rand(6);
			var bonus:Number = 0;
			//Gnoll Tease #1
			if (tease == 0) {
				outputText("The gnoll takes a moment to stretch her sleek, athletic body.  Her free hand runs up her side and she leers knowingly at you.", false);
				bonus += 5;
			}
			//Gnoll Tease #2
			else if (tease == 1) {
				outputText("With one hand, the hyena girl grasps her eight-inch clitoris and strokes it.  \"<i>I know you're curious!</i>\" she laughs.  \"<i>You want to try this.</i>\"", false);
				bonus += 5;
			}
			//Gnoll Tease #3
			else if (tease == 2) {
				outputText("The gnoll bounds forward, but instead of clobbering you she slides her lithe body against yours.  \"<i>We don't have to fight,</i>\" she titters.  \"<i>It's lots easier if I just fuck you.</i>\"", false);
				bonus += 10;
			}
			//Gnoll Tease #4
		 	else if (tease == 3) {
				outputText("The gnoll slides her fingers down the length of her pseudo-penis and collects the cream that drips from its end.  With two steps, she's inside your guard, but all she does is wave her hand in front of your nose.  The reek of sex nearly bowls you over.", false);
				bonus += 12;
			}
			//Gnoll Tease #5
			else if (tease == 4) outputText("\"<i>I love outlanders,</i>\" the gnoll confides in you as she circles.  \"<i>You have such interesting cries when you get fucked in a new way.</i>\"  She laughs, and the sound is far louder than it has any right to be.\n\n", false);
			//Gnoll Tease #6
			else {
				outputText("The gnoll dances forward, then back, her whole body alive with sensual movement.  She catches the way you watch her and smirks, throwing in a hip-shake just for you.", false);
				bonus += 6;
			}
			game.dynStats("lus", (bonus + 10 + player.lib/20 + rand(player.cor/20)));
			outputText("\n", false);
		}

		override public function eAttack():void
		{
			var damage:Number = 0;
			var attack:Number = rand(6);
//return to combat menu when finished
			doNext(game.playerMenu);
//Blind dodge change
			if (findStatusEffect(StatusEffects.Blind) >= 0 && rand(3) < 2) {
				outputText(capitalA + short + " completely misses you with a blind attack!\n", false);
			}
			//Determine if dodged!
			else if (player.spe - spe > 0 && int(Math.random() * (((player.spe - spe) / 4) + 80)) > 80) {
				if (player.spe - spe < 8) outputText("You narrowly avoid " + a + short + "'s " + weaponVerb + "!\n", false);
				else if (player.spe - spe >= 8 && player.spe - spe < 20) outputText("You dodge " + a + short + "'s " + weaponVerb + " with superior quickness!\n", false);
				else if (player.spe - spe >= 20) outputText("You deftly avoid " + a + short + "'s slow " + weaponVerb + ".\n", false);
			}
			//Determine if evaded
			else if (player.findPerk(PerkLib.Evade) >= 0 && rand(100) < 10) {
				outputText("Using your skills at evading attacks, you anticipate and sidestep " + a + short + "'s attack.\n", false);
			}
			//("Misdirection"
			else if (player.findPerk(PerkLib.Misdirection) >= 0 && rand(100) < 10 && player.armorName == "red, high-society bodysuit") {
				outputText("Using Raphael's teachings, you anticipate and sidestep " + a + short + "' attacks.\n", false);
			}
			//Determine if cat'ed
			else if (player.findPerk(PerkLib.Flexibility) >= 0 && rand(100) < 6) {
				outputText("With your incredible flexibility, you squeeze out of the way of " + a + short + "", false);
				if (plural) outputText("' attacks.\n", false);
				else outputText("'s attack.\n", false);
			}
			else {
				//Determine damage - str modified by enemy toughness!
				damage = int((str + weaponAttack) - Math.random() * (player.tou) - player.armorDef);
				if (damage <= 0) {
					damage = 0;
					//hapies have their own shit
					if (short == "harpy") outputText("The harpy dives at you with her foot-talons, but you deflect the attack, grasp onto her leg, and swing her through the air, tossing her away from you before she has a chance to right herself.", false);
					//Due to toughness or amor...
					else if (rand(player.armorDef + player.tou) < player.armorDef) outputText("Your " + player.armorName + " absorb and deflect every " + weaponVerb + " from " + a + short + ".", false);
					else outputText("You deflect and block every " + weaponVerb + " " + a + short + " throws at you.", false);
				}
				//everyone else
				else {
					//Gnoll Attack #1
					if (attack == 0) {
						outputText("The gnoll leaps forward, her jaws slamming shut across your upper arm.  She twists away before you can touch her, laughing the entire time.", false);
						damage += 10;
					}
					//Gnoll Attack #2
					else if (attack == 1) {
						outputText("With a shudder and lurch, the gnoll barrels forward into your gut, the claws of her free hand raking across your belly.", false);
						damage += 3;
					}
					//Gnoll Attack #3
					else if (attack == 2) {
						outputText("The gnoll tumbles to the ground, then comes up with a handful of sand.  The sand goes in your face; the club goes into your cheek.  Ow.", false);
						damage += 13;
					}
					//Gnoll Attack #4
					else if (attack == 3) {
						outputText("The hyena girl giggles and darts forward, teeth snapping.  Spittle flies everywhere, and the snapping teeth find purchase, drawing red lines across your body.", false);
						damage += 8;
					}
					//Gnoll Attack #5
					else if (attack == 4) {
						outputText("With a mocking laugh, the gnoll brings her club high and then down in a savage strike that catches you across the temple.", false);
						damage += 25;
					}
					//Gnoll Attack #6
					else {
						outputText("The gnoll waves her club threateningly, but it's her foot that snaps up from the dusty plain to connect with your gut.", false);
					}
					outputText(" ");
					player.takeDamage(damage, true);
				}
				game.statScreenRefresh();
			}
		}

		override protected function performCombatAction():void
		{
			if (findStatusEffect(StatusEffects.Stunned) >= 0) {
				if (plural) outputText("Your foes are too dazed from your last hit to strike back!", false);
				else outputText("Your foe is too dazed from your last hit to strike back!", false);
				removeStatusEffect(StatusEffects.Stunned);
				combatRoundOver();
			}
			if (findStatusEffect(StatusEffects.Fear) >= 0) {
				if (statusEffectv1(StatusEffects.Fear) == 0) {
					if (plural) {
						removeStatusEffect(StatusEffects.Fear);
						outputText("Your foes shake free of their fear and ready themselves for battle.", false);
					}
					else {
						removeStatusEffect(StatusEffects.Fear);
						outputText("Your foe shakes free of its fear and readies itself for battle.", false);
					}
				}
				else {
					addStatusValue(StatusEffects.Fear, 1, -1);
					if (plural) outputText(capitalA + short + " are too busy shivering with fear to fight.", false);
					else outputText(capitalA + short + " is too busy shivering with fear to fight.", false);
				}
				combatRoundOver();
			}
			var select:Number = 1;
			var rando:Number = 1;
//Exgartuan gets to do stuff!
			if (player.findStatusEffect(StatusEffects.Exgartuan) >= 0 && player.statusEffectv2(StatusEffects.Exgartuan) == 0 && rand(3) == 0) {
				game.exgartuan.exgartuanCombatUpdate();
				outputText("\n\n", false);
			}
			if (findStatusEffect(StatusEffects.Constricted) >= 0) {
				//Enemy struggles -
				outputText("Your prey pushes at your tail, twisting and writhing in an effort to escape from your tail's tight bonds.", false);
				if (statusEffectv1(StatusEffects.Constricted) <= 0) {
					outputText("  " + capitalA + short + " proves to be too much for your tail to handle, breaking free of your tightly bound coils.", false);
					removeStatusEffect(StatusEffects.Constricted);
				}
				addStatusValue(StatusEffects.Constricted, 1, -1);
				combatRoundOver();
			}
//If grappling...
/* Grappling was never included
			if (game.gameState == 2) {
				//temperment - used for determining grapple behaviors
				//0 - avoid grapples/break grapple
				//1 - lust determines > 50 grapple
				//2 - random
				//3 - love grapples
				//		if (temperment == 0) eGrappleRetreat();
				if (temperment == 1) {
					//			if (lust < 50) eGrappleRetreat();
					doNext(3);
				}
				outputText("Lust Placeholder!!", false);
				doNext(3);
			}
*/
			if (rand(2) == 0) gnollTease();
			else {
				var damage:Number = 0;
				var attack:Number = rand(6);
//return to combat menu when finished
				doNext(game.playerMenu);
//Blind dodge change
				if (findStatusEffect(StatusEffects.Blind) >= 0 && rand(3) < 2) {
					outputText(capitalA + short + " completely misses you with a blind attack!\n", false);
				}
				//Determine if dodged!
				else if (player.spe - spe > 0 && int(Math.random() * (((player.spe - spe) / 4) + 80)) > 80) {
					if (player.spe - spe < 8) outputText("You narrowly avoid " + a + short + "'s " + weaponVerb + "!\n", false);
					else if (player.spe - spe >= 8 && player.spe - spe < 20) outputText("You dodge " + a + short + "'s " + weaponVerb + " with superior quickness!\n", false);
					else if (player.spe - spe >= 20) outputText("You deftly avoid " + a + short + "'s slow " + weaponVerb + ".\n", false);
				}
				//Determine if evaded
				else if (player.findPerk(PerkLib.Evade) >= 0 && rand(100) < 10) {
					outputText("Using your skills at evading attacks, you anticipate and sidestep " + a + short + "'s attack.\n", false);
				}
				//("Misdirection"
				else if (player.findPerk(PerkLib.Misdirection) >= 0 && rand(100) < 10 && player.armorName == "red, high-society bodysuit") {
					outputText("Using Raphael's teachings, you anticipate and sidestep " + a + short + "' attacks.\n", false);
				}
				//Determine if cat'ed
				else if (player.findPerk(PerkLib.Flexibility) >= 0 && rand(100) < 6) {
					outputText("With your incredible flexibility, you squeeze out of the way of " + a + short + "", false);
					if (plural) outputText("' attacks.\n", false);
					else outputText("'s attack.\n", false);
				}
				else {
					//Determine damage - str modified by enemy toughness!
					damage = int((str + weaponAttack) - Math.random() * (player.tou) - player.armorDef);
					if (damage <= 0) {
						damage = 0;
						//hapies have their own shit
						if (short == "harpy") outputText("The harpy dives at you with her foot-talons, but you deflect the attack, grasp onto her leg, and swing her through the air, tossing her away from you before she has a chance to right herself.", false);
						//Due to toughness or amor...
						else if (rand(player.armorDef + player.tou) < player.armorDef) outputText("Your " + player.armorName + " absorb and deflect every " + weaponVerb + " from " + a + short + ".", false);
						else outputText("You deflect and block every " + weaponVerb + " " + a + short + " throws at you.", false);
					}
					//everyone else
					else {
						//Gnoll Attack #1
						if (attack == 0) {
							outputText("The gnoll leaps forward, her jaws slamming shut across your upper arm.  She twists away before you can touch her, laughing the entire time.", false);
							damage += 10;
						}
						//Gnoll Attack #2
						else if (attack == 1) {
							outputText("With a shudder and lurch, the gnoll barrels forward into your gut, the claws of her free hand raking across your belly.", false);
							damage += 3;
						}
						//Gnoll Attack #3
						else if (attack == 2) {
							outputText("The gnoll tumbles to the ground, then comes up with a handful of sand.  The sand goes in your face; the club goes into your cheek.  Ow.", false);
							damage += 13;
						}
						//Gnoll Attack #4
						else if (attack == 3) {
							outputText("The hyena girl giggles and darts forward, teeth snapping.  Spittle flies everywhere, and the snapping teeth find purchase, drawing red lines across your body.", false);
							damage += 8;
						}
						//Gnoll Attack #5
						else if (attack == 4) {
							outputText("With a mocking laugh, the gnoll brings her club high and then down in a savage strike that catches you across the temple.", false);
							damage += 25;
						}
						//Gnoll Attack #6
						else {
							outputText("The gnoll waves her club threateningly, but it's her foot that snaps up from the dusty plain to connect with your gut.", false);
						}
						outputText(" ");
						player.takeDamage(damage);
					}
					game.statScreenRefresh();
				}
				gnollAttackText();
			}
			combatRoundOver();
		}


		override public function defeated(hpVictory:Boolean):void
		{
			if (findStatusEffect(StatusEffects.PhyllaFight) >= 0) {
				removeStatusEffect(StatusEffects.PhyllaFight);
				game.desert.antsScene.phyllaPCBeatsGnoll();
				return;
			}
			game.plains.gnollScene.defeatHyena();
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if (findStatusEffect(StatusEffects.PhyllaFight) >= 0) {
				removeStatusEffect(StatusEffects.PhyllaFight);
				game.desert.antsScene.phyllaGnollBeatsPC();
			} else if (pcCameWorms) {
				outputText("\n\nYour foe doesn't seem put off enough to leave...");
				doNext(game.combat.endLustLoss);
			} else {
				game.plains.gnollScene.getRapedByGnoll();
			}
		}

		public function Gnoll()
		{
			this.a = "the ";
			this.short = "gnoll";
			this.imageName = "gnoll";
			this.long = "This lanky figure is dappled with black spots across rough, tawny fur. Wiry muscle ripples along long legs and arms, all of it seeming in perpetual frenetic motion: every moment half flinching and half lunging.  The head bears a dark muzzle curled in a perpetual leer and bright orange eyes watching with a savage animal cunning.  Between the legs hang what appears at first to be a long, thin dong; however, on closer inspection it is a fused tube of skin composed of elongated pussy lips and clitoris.  The hyena girl is sporting a pseudo-penis, and judging by the way it bobs higher as she jinks back and forth, she's happy to see you!\n\nShe wears torn rags scavenged from some other, somewhat smaller, creature, and in one hand clutches a twisted club.";
			// this.plural = false;
			this.createVagina(false, VAGINA_WETNESS_DROOLING, VAGINA_LOOSENESS_LOOSE);
			createBreastRow(Appearance.breastCupInverse("C"));
			this.ass.analLooseness = ANAL_LOOSENESS_STRETCHED;
			this.ass.analWetness = ANAL_WETNESS_DRY;
			this.createStatusEffect(StatusEffects.BonusACapacity,25,0,0,0);
			this.tallness = 6*12;
			this.hipRating = HIP_RATING_AMPLE;
			this.buttRating = BUTT_RATING_TIGHT;
			this.skinTone = "tawny";
			this.skinType = SKIN_TYPE_FUR;
			//this.skinDesc = Appearance.Appearance.DEFAULT_SKIN_DESCS[SKIN_TYPE_FUR];
			this.hairColor = "black";
			this.hairLength = 22;
			initStrTouSpeInte(80, 70, 75, 60);
			initLibSensCor(65, 25, 60);
			this.weaponName = "twisted club";
			this.weaponVerb="smash";
			this.weaponAttack = 0;
			this.weaponPerk = "";
			this.weaponValue = 25;
			this.armorName = "skin";
			this.armorDef = 2;
			this.bonusHP = 250;
			this.lust = 30;
			this.lustVuln = .35;
			this.temperment = TEMPERMENT_RANDOM_GRAPPLES;
			this.level = 14;
			this.gems = 10 + rand(5);
			this.drop = new ChainedDrop().
					add(consumables.REDUCTO,1/5).
					add(consumables.SUCMILK,1/2).
					elseDrop(consumables.BLACK_D);
			checkMonster();
		}
		
	}

}