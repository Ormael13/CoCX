package classes.Scenes.Areas.Swamp
{
	import classes.CoC;
	import classes.Cock;
	import classes.Monster;
	import classes.CockTypesEnum;
	
	/**
	 * ...
	 * @author aimozg
	 */
	public class SpiderMorphMob extends Monster 
	{
		//==============================
		// SPOIDAH HORDE COMBAT SHIZZLE HERE!
		//==============================
		private function spiderStandardAttack():void {
			//SPIDER HORDE ATTACK - Miss (guaranteed if turns 1-3 and PC lost to Kiha)
			if(findStatusAffect(StatusAffects.miss_first_round) >= 0 || combatMiss() || combatEvade() || combatFlexibility() || combatMisdirect()) {
				removeStatusAffect(StatusAffects.miss_first_round);
				outputText("A number of spiders rush at you, trying to claw and bite you.  You manage to beat them all back, though, with some literal covering fire from Kiha.", false);
			}
			//SPIDER HORDE ATTACK - Hit
			else {
				outputText("A number of spiders rush at you, trying to claw and bite you.  You manage to knock most of them away, but a few nasty hits manage to punch through your [armorName].  ", false);
				//Determine damage - str modified by enemy toughness!
				var damage:int = int((str + weaponAttack) - rand(player.tou) - player.armorDef) + 20;
				if(damage > 0) damage = player.takeDamage(damage);
				if(damage <= 0) {
					damage = 0;
					if(rand(player.armorDef + player.tou) < player.armorDef) outputText("You absorb and deflect every " + weaponVerb + " with your " + player.armorName + ".", false);
					else outputText("You deflect and block every " + weaponVerb + " " + a + short + " throws at you.", false);
				}
				else if(damage < 6) outputText("You are struck a glancing blow by " + a + short + "! (" + damage + ")", false);
				else if(damage < 11) outputText(capitalA + short + " wounds you! (" + damage + ")", false);
				else if(damage < 21) outputText(capitalA + short + " staggers you with the force of " + pronoun3 + " " + weaponVerb + "! (" + damage + ")", false);
				else if(damage > 20) {
					outputText(capitalA + short + " <b>mutilate", false);
					outputText("</b> you with " + pronoun3 + " powerful " + weaponVerb + "! (" + damage + ")", false);
				}
				if(damage > 0) {
					if(lustVuln > 0 && player.armorName == "barely-decent bondage straps") {
						if(!plural) outputText("\n" + capitalA + short + " brushes against your exposed skin and jerks back in surprise, coloring slightly from seeing so much of you revealed.", false);
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
			if(findStatusAffect(StatusAffects.miss_first_round) >= 0 || combatMiss() || combatEvade() || combatFlexibility() || combatMisdirect()) {
				outputText("One of the driders launches a huge glob of webbing right at you!  Luckily, Kiha manages to burn it out of the air with a well-timed gout of flame!", false);
				combatRoundOver();
			}
			else {
				outputText("Some of the spiders and driders launch huge globs of wet webbing right at you, hitting you in the torso!  You try to wiggle out, but it's no use; you're stuck like this for now.  Though comfortingly, the driders' open stance and self-satisfaction allow Kiha to blast them in the side with a huge conflagration!", false);
				//(PC cannot attack or use spells for one turn; can use Magical Special and Possess)
				player.createStatusAffect(StatusAffects.UBERWEB,0,0,0,0);
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
			if(rand(2) == 0 || player.findStatusAffect(StatusAffects.UBERWEB) >= 0) spiderStandardAttack();
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
				doNext(game.endLustLoss);
			} else {
				game.kihaFollower.loseToSpiderMob();
			}
		}

		public function SpiderMorphMob()
		{
			init01Names("the ","mob of spiders-morphs","spidermorphmob","You are fighting a horde of spider-morphs!  A group of some two-dozen spiders and driders approaches you, all baring their teeth.  A pair of large, powerful driders lead the group, their corrupt, lusty stares sending shivers up your spine.  While "+(player.level <= 13?"you'd never face such a large horde on your own":"you could probably handle them alone")+", you have a powerful ally in this fight - the dragoness Kiha!",true);
			init02Male(new Cock(9,2,CockTypesEnum.HUMAN),2,1,3);
			init02Female(VAGINA_WETNESS_SLICK,VAGINA_LOOSENESS_LOOSE);
			init03BreastRows(0);
			init04Ass(ANAL_LOOSENESS_STRETCHED,ANAL_WETNESS_SLIME_DROOLING);
			init05Body(rand(8) + 70,HIP_RATING_AMPLE+2,BUTT_RATING_LARGE);
			init06Skin("red");
			init07Hair("black",15);
			init08Face();
			init09PrimaryStats(60,50,99,99,35,35,20);
			init10Weapon("claws","claws");
			init11Armor("chitin");
			init12Combat(1200,0,.2,Monster.TEMPERMENT_LOVE_GRAPPLES);
			init13Level(18,rand(25)+40);
			initX_Specials(5043,5044);
			initX_Tail(TAIL_TYPE_SPIDER_ADBOMEN);
		}
		
	}

}