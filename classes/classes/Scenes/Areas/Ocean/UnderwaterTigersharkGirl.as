/**
 * ...
 * @author Liadri
 */
package classes.Scenes.Areas.Ocean 
{
	import classes.*;
	import classes.internals.*;
	import classes.GlobalFlags.kFLAGS;

	public class UnderwaterTigersharkGirl extends Monster
	{
		private function sharkTease():void {
			game.spriteSelect(70);
			if(rand(2) == 0) {
				outputText("You charge at the shark girl, prepared to strike again, but stop dead in your tracks when she turns around and wiggles her toned ass towards you. It distracts you long enough for her tail to swing out and smack you. She coos, \"<i>Aw... You really do like me!</i>\" ");
				//(Small health damage, medium lust build).
				player.takeDamage(12+rand(12), true);
				game.dynStats("lus", (12+(player.lib/10)));
			}
			else {
				outputText("You pull your [weapon] back, getting a swimming start to land another attack. The Shark girl smirks and pulls up her bikini top, shaking her perky breasts in your direction. You stop abruptly, aroused by the sight just long enough for the shark girl to kick you across the face and knock you away.  She teases, \"<i>Aw, don't worry baby, you're gonna get the full package in a moment!</i>\" ");
				//(Small health damage, medium lust build)
				player.takeDamage(12+rand(12), true);
				game.dynStats("lus", (6+(player.lib/5)));
			}
			combatRoundOver();
		}
		private function sharkBiteAttack():void {
			game.spriteSelect(70);
			outputText("Your opponent take a turn and charge at you at high speed jaw open as she go in for the kill viciously biting you. You start to bleed in abundance the water around you turning red. ");
			var damage:Number = 0;
			damage += eBaseDamage();
			player.takeDamage(damage, true);
			if (player.hasStatusEffect(StatusEffects.Hemorrhage)) player.addStatusValue(StatusEffects.Hemorrhage, 1, 1);
			else player.createStatusEffect(StatusEffects.Hemorrhage,3,0.1,0,0);
			combatRoundOver();
		}
		/*
		override public function defeated(hpVictory:Boolean):void
		{
			game.boat.sharkGirlScene.sharkWinChoices();
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if (pcCameWorms){
				outputText("\n\nYour foe doesn't seem disgusted enough to leave...");
				doNext(game.endLustLoss);
			} else {
				game.boat.sharkGirlScene.sharkLossRape();
			}
		}
		*/
		public function UnderwaterTigersharkGirl() 
		{
			this.a = "the ";
			this.short = "shark-girl";
			this.imageName = "izma";
			this.long = "The tiger shark girl is menacingly circling you off waiting for the opportunity to strike. These creatures clearly look way more deadly in the water then out of it!";
			// this.plural = false;
			this.createCock(15,2.2);
			this.balls = 4;
			this.ballSize = 3;
			this.createVagina(false, VAGINA_WETNESS_SLICK, VAGINA_LOOSENESS_LOOSE);
			this.createStatusEffect(StatusEffects.BonusVCapacity, 45, 0, 0, 0);
			createBreastRow(Appearance.breastCupInverse("DD"));
			this.ass.analLooseness = ANAL_LOOSENESS_NORMAL;
			this.ass.analWetness = ANAL_WETNESS_DRY;
			this.createStatusEffect(StatusEffects.BonusACapacity,30,0,0,0);
			this.tallness = 5*12+5;
			this.hipRating = HIP_RATING_CURVY;
			this.buttRating = BUTT_RATING_NOTICEABLE;
			this.skinTone = "striped orange";
			this.hairColor = "silver";
			this.hairLength = 20;
			initStrTouSpeInte(250, 170, 205, 110);
			initLibSensCor(120, 25, 40);
			this.weaponName = "shark teeth";
			this.weaponVerb="bite";
			this.weaponAttack = 66 + (14 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
			this.armorName = "tough skin";
			this.armorDef = 20 + (3 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
			this.bonusHP = 500;
			this.bonusLust = 20;
			this.lust = 20;
			this.lustVuln = .20;
			this.temperment = TEMPERMENT_RANDOM_GRAPPLES;
			this.level = 58;
			this.gems = rand(15) + 10;
			this.drop = new WeightedDrop().
					add(consumables.L_DRAFT,3).
					add(armors.S_SWMWR,1).
					add(consumables.TSTOOTH,5).
					add(null,1);
			this.special1 = sharkTease;
			this.special2 = sharkBiteAttack;
			this.createPerk(PerkLib.EnemyBeastOrAnimalMorphType, 0, 0, 0, 0);
			this.str += 100 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.tou += 68 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.spe += 82 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.inte += 44 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];			
			this.lib += 48 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.newgamebonusHP = 20520;
			checkMonster();
		}
		
	}

}