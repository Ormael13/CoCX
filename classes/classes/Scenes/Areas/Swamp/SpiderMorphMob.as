package classes.Scenes.Areas.Swamp
{
	import classes.*;

	public class SpiderMorphMob extends Monster
	{
		//==============================
		// SPOIDAH HORDE COMBAT SHIZZLE HERE!
		//==============================
		private function spiderStandardAttack():void {
			//SPIDER HORDE ATTACK - Miss (guaranteed if turns 1-3 and PC lost to Kiha)
			if (findStatusEffect(StatusEffects.MissFirstRound) >= 0 || player.getEvasionRoll()) {
				removeStatusEffect(StatusEffects.MissFirstRound);
				outputText("A number of spiders rush at you, trying to claw and bite you.  You manage to beat them all back, though, with some literal covering fire from Kiha.", false);
			}
			//SPIDER HORDE ATTACK - Hit
			else {
				outputText("A number of spiders rush at you, trying to claw and bite you.  You manage to knock most of them away, but a few nasty hits manage to punch through your [armorName].  ", false);
				//Determine damage - str modified by enemy toughness!
				var damage:int = int((str + weaponAttack) - rand(player.tou) - player.armorDef) + 20;
				if (damage > 0) damage = player.takeDamage(damage);
				if (damage <= 0) {
					damage = 0;
					if (rand(player.armorDef + player.tou) < player.armorDef) outputText("You absorb and deflect every " + weaponVerb + " with your " + player.armorName + ".", false);
					else outputText("You deflect and block every " + weaponVerb + " " + a + short + " throws at you.", false);
				}
				else if (damage < 6) outputText("You are struck a glancing blow by " + a + short + "! ", false);
				else if (damage < 11) outputText(capitalA + short + " wounds you! ", false);
				else if (damage < 21) outputText(capitalA + short + " staggers you with the force of " + pronoun3 + " " + weaponVerb + "! ", false);
				else if (damage > 20) {
					outputText(capitalA + short + " <b>mutilate", false);
					outputText("</b> you with " + pronoun3 + " powerful " + weaponVerb + "! ", false);
				}
				if (damage > 0) outputText("<b>(<font color=\"#800000\">" + damage + "</font>)</b>", false)
				else outputText("<b>(<font color=\"#000080\">" + damage + "</font>)</b>", false)
				if (damage > 0) {
					if (lustVuln > 0 && player.armorName == "barely-decent bondage straps") {
						if (!plural) outputText("\n" + capitalA + short + " brushes against your exposed skin and jerks back in surprise, coloring slightly from seeing so much of you revealed.", false);
						else outputText("\n" + capitalA + short + " brush against your exposed skin and jerk back in surprise, coloring slightly from seeing so much of you revealed.", false);
						lust += 10 * lustVuln;
					}
				}
				statScreenRefresh();
			}
			kihaSPOIDAHAI();
		}

		//SPIDER HORDE WEB - Hit
		private function spoidahHordeWebLaunchahs():void {
			//SPIDER HORDE WEB - Miss (guaranteed if turns 1-3 and PC lost to Kiha)
			if (findStatusEffect(StatusEffects.MissFirstRound) >= 0 || player.getEvasionRoll()) {
				outputText("One of the driders launches a huge glob of webbing right at you!  Luckily, Kiha manages to burn it out of the air with a well-timed gout of flame!", false);
				combatRoundOver();
			}
			else {
				outputText("Some of the spiders and driders launch huge globs of wet webbing right at you, hitting you in the torso!  You try to wiggle out, but it's no use; you're stuck like this for now.  Though comfortingly, the driders' open stance and self-satisfaction allow Kiha to blast them in the side with a huge conflagration!", false);
				//(PC cannot attack or use spells for one turn; can use Magical Special and Possess)
				player.createStatusEffect(StatusEffects.UBERWEB,0,0,0,0);
				HP -= 250;
				combatRoundOver();
			}
		}

		private function kihaSPOIDAHAI():void {
			outputText("[pg]", false);
			game.spriteSelect(72);
			outputText("While they're tangled up with you, however, Kiha takes the opportunity to get in a few shallow swings with her axe, to the accompaniment of crunching chitin.", false);
			//horde loses HP
			HP -= 50;
			combatRoundOver();
		}

		override protected function performCombatAction():void
		{
			game.spriteSelect(72);
			if (rand(2) == 0 || player.findStatusEffect(StatusEffects.UBERWEB) >= 0) spiderStandardAttack();
			else spoidahHordeWebLaunchahs();
		}


		override public function defeated(hpVictory:Boolean):void
		{
			game.kihaFollower.beatSpiderMob();
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if (pcCameWorms){
				outputText("\n\nThe spiders smile to one at another as they watch your display, then close in...");
				doNext(game.combat.endLustLoss);
			} else {
				game.kihaFollower.loseToSpiderMob();
			}
		}

		public function SpiderMorphMob()
		{
			this.a = "the ";
			this.short = "mob of spiders-morphs";
			this.imageName = "spidermorphmob";
			this.long = "You are fighting a horde of spider-morphs!  A group of some two-dozen spiders and driders approaches you, all baring their teeth.  A pair of large, powerful driders lead the group, their corrupt, lusty stares sending shivers up your spine.  While "+(player.level <= 13?"you'd never face such a large horde on your own":"you could probably handle them alone") +", you have a powerful ally in this fight - the dragoness Kiha!";
			this.plural = true;
			this.pronoun1 = "they";
			this.pronoun2 = "them";
			this.pronoun3 = "their";
			this.createCock(9,2,CockTypesEnum.HUMAN);
			this.balls = 2;
			this.ballSize = 1;
			this.cumMultiplier = 3;
			// this.hoursSinceCum = 0;
			this.createVagina(false, VAGINA_WETNESS_SLICK, VAGINA_LOOSENESS_LOOSE);
			createBreastRow(0);
			this.ass.analLooseness = ANAL_LOOSENESS_STRETCHED;
			this.ass.analWetness = ANAL_WETNESS_SLIME_DROOLING;
			this.tallness = rand(8) + 70;
			this.hipRating = HIP_RATING_AMPLE+2;
			this.buttRating = BUTT_RATING_LARGE;
			this.skinTone = "red";
			this.hairColor = "black";
			this.hairLength = 15;
			initStrTouSpeInte(60, 50, 99, 99);
			initLibSensCor(35, 35, 20);
			this.weaponName = "claws";
			this.weaponVerb="claws";
			this.armorName = "chitin";
			this.bonusHP = 1200;
			this.lustVuln = .2;
			this.temperment = TEMPERMENT_LOVE_GRAPPLES;
			this.level = 18;
			this.gems = rand(25) +40;
			this.special1 = game.combat.packAttack;
			this.special2 = game.combat.lustAttack;
			this.tailType = TAIL_TYPE_SPIDER_ADBOMEN;
			this.drop = NO_DROP;
			checkMonster();
		}
		
	}

}