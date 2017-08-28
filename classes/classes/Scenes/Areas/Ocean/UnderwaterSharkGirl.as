/**
 * ...
 * @author Liadri
 */
package classes.Scenes.Areas.Ocean 
{
	import classes.*;
	import classes.internals.*;
	import classes.GlobalFlags.kFLAGS;

	public class UnderwaterSharkGirl extends Monster
	{
		private function sharkTease():void {
			game.spriteSelect(70);
			if(rand(2) == 0) {
				outputText("You charge at the shark girl, prepared to strike again, but stop dead in your tracks when she turns around and wiggles her toned ass towards you. It distracts you long enough for her tail to swing out and smack you. She coos, \"<i>Aw... You really do like me!</i>\" ");
				//(Small health damage, medium lust build).
				player.takeDamage(10+rand(10), true);
				game.dynStats("lus", (10+(player.lib/10)));
			}
			else {
				outputText("You pull your [weapon] back, getting a swimming start to land another attack. The Shark girl smirks and pulls up her bikini top, shaking her perky breasts in your direction. You stop abruptly, aroused by the sight just long enough for the shark girl to kick you across the face and knock you away.  She teases, \"<i>Aw, don't worry baby, you're gonna get the full package in a moment!</i>\" ");
				//(Small health damage, medium lust build)
				player.takeDamage(10+rand(10), true);
				game.dynStats("lus", (5+(player.lib/5)));
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
			else player.createStatusEffect(StatusEffects.Hemorrhage,3,0.05,0,0);
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
		public function UnderwaterSharkGirl() 
		{
			this.a = "the ";
			this.short = "shark-girl";
			this.imageName = "sharkgirl";
			this.long = "The shark girl is menacingly circling you off waiting for the opportunity to strike. These creatures clearly look way more deadly in the water then out of it!";
			// this.plural = false;
			this.createVagina(false, VAGINA_WETNESS_DROOLING, VAGINA_LOOSENESS_NORMAL);
			this.createStatusEffect(StatusEffects.BonusVCapacity, 15, 0, 0, 0);
			createBreastRow(Appearance.breastCupInverse("D"));
			this.ass.analLooseness = ANAL_LOOSENESS_TIGHT;
			this.ass.analWetness = ANAL_WETNESS_DRY;
			this.createStatusEffect(StatusEffects.BonusACapacity,40,0,0,0);
			this.tallness = 5*12+5;
			this.hipRating = HIP_RATING_AMPLE+2;
			this.buttRating = BUTT_RATING_LARGE;
			this.skinTone = "gray";
			this.hairColor = "silver";
			this.hairLength = 16;
			initStrTouSpeInte(200, 140, 160, 90);
			initLibSensCor(100, 35, 40);
			this.weaponName = "shark teeth";
			this.weaponVerb="bite";
			this.weaponAttack = 30 + (7 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
			this.armorName = "tough skin";
			this.armorDef = 20 + (3 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
			this.bonusHP = 100;
			this.bonusLust = 20;
			this.lust = 40;
			this.lustVuln = .9;
			this.temperment = TEMPERMENT_RANDOM_GRAPPLES;
			this.level = 54;
			this.gems = rand(30) + 25;
			this.drop = new WeightedDrop().
					add(consumables.L_DRAFT,3).
					add(armors.S_SWMWR,1).
					add(consumables.SHARK_T,5).
					add(null,1);
			this.special1 = sharkTease;
			this.special2 = sharkBiteAttack;
			this.createPerk(PerkLib.EnemyBeastOrAnimalMorphType, 0, 0, 0, 0);
			this.str += 80 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.tou += 56 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.spe += 64 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.inte += 36 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];			
			this.lib += 40 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.newgamebonusHP = 16560;
			checkMonster();
		}
		
	}

}