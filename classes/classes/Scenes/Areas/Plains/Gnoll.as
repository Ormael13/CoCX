package classes.Scenes.Areas.Plains
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.Scenes.SceneLib;
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
			doNext(EventParser.playerMenu);
				//Determine damage - str modified by enemy toughness!
				damage = int((str + weaponAttack) - Math.random()*(player.tou) - player.armorDef);
				if(damage <= 0) {
					//hapies have their own shit
					if(short == "harpy") outputText("The harpy dives at you with her foot-talons, but you deflect the attack, grasp onto her leg, and swing her through the air, tossing her away from you before she has a chance to right herself.");
					//Due to toughness or amor...
					else if(rand(player.armorDef + player.tou) < player.armorDef) outputText("Your [armor] absorb and deflect every " + weaponVerb + " from " + a + short + ".");
					else outputText("You deflect and block every " + weaponVerb + " " + a + short + " throws at you.");
				}
				//everyone else
				else {
					//Gnoll Attack #1
					if(attack == 0) {
						outputText("The gnoll leaps forward, her jaws slamming shut across your upper arm.  She twists away before you can touch her, laughing the entire time.");
						damage += 10;
					}
					//Gnoll Attack #2
					else if(attack == 1) {
						outputText("With a shudder and lurch, the gnoll barrels forward into your gut, the claws of her free hand raking across your belly.");
						damage += 3;
					}
					//Gnoll Attack #3
					else if(attack == 2) {
						outputText("The gnoll tumbles to the ground, then comes up with a handful of sand.  The sand goes in your face; the club goes into your cheek.  Ow.");
						damage += 13;
					}
					//Gnoll Attack #4
					else if(attack == 3) {
						outputText("The hyena girl giggles and darts forward, teeth snapping.  Spittle flies everywhere, and the snapping teeth find purchase, drawing red lines across your body.");
						damage += 8;
					}
					//Gnoll Attack #5
					else if(attack == 4) {
						outputText("With a mocking laugh, the gnoll brings her club high and then down in a savage strike that catches you across the temple.");
						damage += 25;
					}
					//Gnoll Attack #6
					else {
						outputText("The gnoll waves her club threateningly, but it's her foot that snaps up from the dusty plain to connect with your gut.");
					}
					outputText(" ");
					player.takePhysDamage(damage, true);
				}
				EngineCore.statScreenRefresh();
		}
		
		private function gnollTease():void {
			var tease:Number = rand(6);
			var bonus:Number = 0;
			//Gnoll Tease #1
			if(tease == 0) {
				outputText("The gnoll takes a moment to stretch her sleek, athletic body.  Her free hand runs up her side and she leers knowingly at you.");
				bonus += 5;
			}
			//Gnoll Tease #2
			else if(tease == 1) {
				outputText("With one hand, the hyena girl grasps her eight-inch clitoris and strokes it.  \"<i>I know you're curious!</i>\" she laughs.  \"<i>You want to try this.</i>\"");
				bonus += 5;
			}
			//Gnoll Tease #3
			else if(tease == 2) {
				outputText("The gnoll bounds forward, but instead of clobbering you she slides her lithe body against yours.  \"<i>We don't have to fight,</i>\" she titters.  \"<i>It's lots easier if I just fuck you.</i>\"");
				bonus += 10;
			}
			//Gnoll Tease #4
		 	else if(tease == 3) {
				outputText("The gnoll slides her fingers down the length of her pseudo-penis and collects the cream that drips from its end.  With two steps, she's inside your guard, but all she does is wave her hand in front of your nose.  The reek of sex nearly bowls you over.");
				bonus += 12;
			}
			//Gnoll Tease #5
			else if(tease == 4) outputText("\"<i>I love outlanders,</i>\" the gnoll confides in you as she circles.  \"<i>You have such interesting cries when you get fucked in a new way.</i>\"  She laughs, and the sound is far louder than it has any right to be.\n\n");
			//Gnoll Tease #6
			else {
				outputText("The gnoll dances forward, then back, her whole body alive with sensual movement.  She catches the way you watch her and smirks, throwing in a hip-shake just for you.");
				bonus += 6;
			}
			player.takeLustDamage((bonus + 10 + player.lib/10 + rand(player.cor/10)), true);
			outputText("\n");
		}

		override public function eAttack():void
		{
			gnollAttackText();
		}

		override protected function performCombatAction():void
		{
			if (hasStatusEffect(StatusEffects.Stunned)) {
				if (plural) outputText("Your foes are too dazed from your last hit to strike back!");
				else outputText("Your foe is too dazed from your last hit to strike back!");
				removeStatusEffect(StatusEffects.Stunned);
			}
			if (hasStatusEffect(StatusEffects.Fear)) {
				if (statusEffectv1(StatusEffects.Fear) == 0) {
					if (plural) {
						this.speStat.core.value += statusEffectv2(StatusEffects.Fear);
						removeStatusEffect(StatusEffects.Fear);
						outputText("Your foes shake free of their fear and ready themselves for battle.");
					}
					else {
						this.speStat.core.value += statusEffectv2(StatusEffects.Fear);
						removeStatusEffect(StatusEffects.Fear);
						outputText("Your foe shakes free of its fear and readies itself for battle.");
					}
				}
				else {
					addStatusValue(StatusEffects.Fear, 1, -1);
					if (plural) outputText(capitalA + short + " are too busy shivering with fear to fight.");
					else outputText(capitalA + short + " is too busy shivering with fear to fight.");
				}
			}
			if (hasStatusEffect(StatusEffects.Constricted)) {
				//Enemy struggles -
				outputText("Your prey pushes at your tail, twisting and writhing in an effort to escape from your tail's tight bonds.");
				if (statusEffectv1(StatusEffects.Constricted) <= 0) {
					outputText("  " + capitalA + short + " proves to be too much for your tail to handle, breaking free of your tightly bound coils.");
					removeStatusEffect(StatusEffects.Constricted);
				}
				addStatusValue(StatusEffects.Constricted, 1, -1);
			}

			if (rand(2) == 0) gnollTease();
			else gnollAttackText();
		}


		override public function defeated(hpVictory:Boolean):void
		{
			if(hasStatusEffect(StatusEffects.PhyllaFight)) {
				removeStatusEffect(StatusEffects.PhyllaFight);
				SceneLib.desert.antsScene.phyllaPCBeatsGnoll();
				return;
			}
			SceneLib.plains.gnollScene.defeatHyena();
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if(hasStatusEffect(StatusEffects.PhyllaFight)) {
				removeStatusEffect(StatusEffects.PhyllaFight);
				SceneLib.desert.antsScene.phyllaGnollBeatsPC();
			} else if(pcCameWorms) {
				outputText("\n\nYour foe doesn't seem put off enough to leave...");
				doNext(SceneLib.combat.endLustLoss);
			} else {
				SceneLib.plains.gnollScene.getRapedByGnoll();
			}
		}

		public function Gnoll()
		{
			this.a = "the ";
			this.short = "gnoll";
			this.imageName = "gnoll";
			this.long = "This lanky figure is dappled with black spots across rough, tawny fur. Wiry muscle ripples along long legs and arms, all of it seeming in perpetual frenetic motion: every moment half flinching and half lunging.  The head bears a dark muzzle curled in a perpetual leer and bright orange eyes watching with a savage animal cunning.  Between the legs hang what appears at first to be a long, thin dong; however, on closer inspection it is a fused tube of skin composed of elongated pussy lips and clitoris.  The hyena girl is sporting a pseudo-penis, and judging by the way it bobs higher as she jinks back and forth, she's happy to see you!\n\nShe wears torn rags scavenged from some other, somewhat smaller, creature, and in one hand clutches a twisted club.";
			// this.plural = false;
			this.createVagina(false, VaginaClass.WETNESS_DROOLING, VaginaClass.LOOSENESS_LOOSE);
			createBreastRow(Appearance.breastCupInverse("C"));
			this.ass.analLooseness = AssClass.LOOSENESS_STRETCHED;
			this.ass.analWetness = AssClass.WETNESS_DRY;
			this.createStatusEffect(StatusEffects.BonusACapacity,25,0,0,0);
			this.tallness = 6*12;
			this.hips.type = Hips.RATING_AMPLE;
			this.butt.type = Butt.RATING_TIGHT;
			this.skin.growFur({color:"tawny"});
			this.hairColor = "black";
			this.hairLength = 22;
			initStrTouSpeInte(180, 150, 150, 120);
			initWisLibSensCor(120, 128, 59, 20);
			this.weaponName = "twisted club";
			this.weaponVerb="smash";
			this.weaponAttack = 55;
			this.weaponValue = 25;
			this.armorName = "skin";
			this.armorDef = 70;
			this.armorMDef = 10;
			this.bonusHP = 1200;
			this.bonusLust = 218;
			this.lust = 30;
			this.lustVuln = .35;
			this.level = 31;
			this.gems = 15 + rand(10);
			this.drop = new ChainedDrop().
					add(consumables.REDUCTO,1/5).
					add(consumables.SUCMILK,1/2).
					elseDrop(consumables.BLACK_D);
			checkMonster();
		}
		
	}

}
