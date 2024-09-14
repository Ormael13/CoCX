package classes.Scenes.Areas.Swamp
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.BodyParts.Tail;
import classes.Scenes.SceneLib;

public class SpiderMorphMob extends Monster
	{
		//==============================
		// SPOIDAH HORDE COMBAT SHIZZLE HERE!
		//==============================
		private function spiderStandardAttack():void {
			//SPIDER HORDE ATTACK - Miss (guaranteed if turns 1-3 and PC lost to Kiha)
			if(hasStatusEffect(StatusEffects.MissFirstRound) || player.getEvasionRoll()) {
				removeStatusEffect(StatusEffects.MissFirstRound);
				outputText("A number of spiders rush at you, trying to claw and bite you.  You manage to beat them all back, though, with some literal covering fire from Kiha.");
			}
			//SPIDER HORDE ATTACK - Hit
			else {
				outputText("A number of spiders rush at you, trying to claw and bite you.  You manage to knock most of them away, but a few nasty hits manage to punch through your [armorName].  ");
				//Determine damage - str modified by enemy toughness!
				var damage:int = int((str + weaponAttack) - rand(player.tou) - player.armorDef) + 20;
				if(damage > 0) damage = player.takePhysDamage(damage);
				if(damage <= 0) {
					damage = 0;
					if(rand(player.armorDef + player.tou) < player.armorDef) outputText("You absorb and deflect every " + weaponVerb + " with your [armor].");
					else outputText("You deflect and block every " + weaponVerb + " " + a + short + " throws at you.");
				}
				else if(damage < 6) outputText("You are struck a glancing blow by " + a + short + "! ");
				else if(damage < 11) outputText(capitalA + short + " wounds you! ");
				else if(damage < 21) outputText(capitalA + short + " staggers you with the force of " + pronoun3 + " " + weaponVerb + "! ");
				else if(damage > 20) {
					outputText(capitalA + short + " <b>mutilate");
					outputText("</b> you with " + pronoun3 + " powerful " + weaponVerb + "! ");
				}
				if (damage > 0) outputText("<b>([font-damage]" + damage + "[/font])</b>");
				else outputText("<b>([font-miss]" + damage + "[/font])</b>");
				if(damage > 0) {
					if(lustVuln > 0 && player.armorName == "barely-decent bondage straps") {
						if(!plural) outputText("\n" + capitalA + short + " brushes against your exposed skin and jerks back in surprise, coloring slightly from seeing so much of you revealed.");
						else outputText("\n" + capitalA + short + " brush against your exposed skin and jerk back in surprise, coloring slightly from seeing so much of you revealed.");
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
			if(hasStatusEffect(StatusEffects.MissFirstRound) || player.getEvasionRoll()) {
				outputText("One of the driders launches a huge glob of webbing right at you!  Luckily, Kiha manages to burn it out of the air with a well-timed gout of flame!");
			}
			else {
				outputText("Some of the spiders and driders launch huge globs of wet webbing right at you, hitting you in the torso!  You try to wiggle out, but it's no use; you're stuck like this for now.  Though comfortingly, the driders' open stance and self-satisfaction allow Kiha to blast them in the side with a huge conflagration!");
				//(PC cannot attack or use spells for one turn; can use Magical Special and Possess)
				player.createStatusEffect(StatusEffects.UBERWEB,0,0,0,0);
				HP -= 250;
			}
		}

		private function kihaSPOIDAHAI():void {
			outputText("[pg]");
			outputText("While they're tangled up with you, however, Kiha takes the opportunity to get in a few shallow swings with her axe, to the accompaniment of crunching chitin.");
			//horde loses HP
			HP -= 50;
		}

		override protected function performCombatAction():void
		{
			if(rand(2) == 0 || player.hasStatusEffect(StatusEffects.UBERWEB)) spiderStandardAttack();
			else spoidahHordeWebLaunchahs();
		}


		override public function defeated(hpVictory:Boolean):void
		{
			SceneLib.kihaFollower.beatSpiderMob();
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if (pcCameWorms){
				outputText("\n\nThe spiders smile to one at another as they watch your display, then close in...");
				doNext(SceneLib.combat.endLustLoss);
			} else {
				SceneLib.kihaFollower.loseToSpiderMob();
			}
		}

		public function SpiderMorphMob()
		{
			this.a = "the ";
			this.short = "mob of spiders-morphs";
			this.imageName = "spidermorphmob";
			this.long = "You are fighting a horde of spider-morphs!  A group of some two-dozen spiders and driders approaches you, all baring their teeth.  A pair of large, powerful driders lead the group, their corrupt, lusty stares sending shivers up your spine.  While "+(player.level <= 18?"you'd never face such a large horde on your own":"you could probably handle them alone")+", you have a powerful ally in this fight - the dragoness Kiha!";
			this.plural = true;
			this.pronoun1 = "they";
			this.pronoun2 = "them";
			this.pronoun3 = "their";
			this.createCock(9,2,CockTypesEnum.HUMAN);
			this.balls = 2;
			this.ballSize = 1;
			this.cumMultiplier = 3;
			// this.hoursSinceCum = 0;
			this.createVagina(false, VaginaClass.WETNESS_SLICK, VaginaClass.LOOSENESS_LOOSE);
			createBreastRow(0);
			this.ass.analLooseness = AssClass.LOOSENESS_STRETCHED;
			this.ass.analWetness = AssClass.WETNESS_SLIME_DROOLING;
			this.tallness = rand(8) + 70;
			this.hips.type = Hips.RATING_AMPLE + 2;
			this.butt.type = Butt.RATING_LARGE;
			this.bodyColor = "red";
			this.hairColor = "black";
			this.hairLength = 15;
			initStrTouSpeInte(100, 80, 99, 99);
			initWisLibSensCor(99, 35, 35, -60);
			this.weaponName = "claws";
			this.weaponVerb="claws";
			this.weaponAttack = 34;
			this.armorName = "chitin";
			this.armorDef = 30;
			this.armorMDef = 3;
			this.bonusHP = 1200;
			this.bonusLust = 93;
			this.lustVuln = .2;
			this.level = 23;
			this.gems = rand(50)+100;
			this.special1 = SceneLib.combat.packAttack;
			this.special2 = SceneLib.combat.lustAttack;
			this.tailType = Tail.SPIDER_ADBOMEN;
			this.drop = NO_DROP;
			this.createPerk(PerkLib.EnemyLargeGroupType, 0, 0, 0, 0);
			checkMonster();
		}
		
	}

}
