package classes.Scenes.Areas.Swamp
{
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.SceneLib;
import classes.internals.*;

public class MaleSpiderMorph extends AbstractSpiderMorph
	{


		override public function defeated(hpVictory:Boolean):void
		{
			SceneLib.swamp.maleSpiderMorphScene.defeatSpiderBoy();
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if(pcCameWorms){
				outputText("\n\nThe spider flashes a predatory grin while she waits it out...");
				doNext(game.endLustLoss);
			} else {
				SceneLib.swamp.maleSpiderMorphScene.loseToMaleSpiderMorph();
			}
		}

		public function MaleSpiderMorph()
		{
			this.a = "the ";
			this.short = "male spider-morph";
			this.imageName = "malespidermorph";
			this.long = "The male spider-morph is completely nude, save for his thigh-high stockings and forearm-length gloves, which upon closer inspection, appear to be actually be part of his body - his exoskeleton.  His exposed skin is pale as the full moon, save for the dusk of his nipples and a patch of jet-black that spreads out over his groin, glossing the male's foreskinned cock and dangling sack in glistening ebon.  His ass is small but well-rounded, with a weighty spider-abdomen hanging from just above.  The spider-man is currently eyeing you with a strange expression and his fangs bared.";
			// this.plural = false;
			this.createCock(6,2);
			this.balls = 2;
			this.ballSize = 2;
			createBreastRow(0);
			this.ass.analLooseness = AppearanceDefs.ANAL_LOOSENESS_TIGHT;
			this.ass.analWetness = AppearanceDefs.ANAL_WETNESS_DRY;
			this.createStatusEffect(StatusEffects.BonusACapacity,40,0,0,0);
			this.tallness = 7*12+6;
			this.hipRating = AppearanceDefs.HIP_RATING_CURVY+2;
			this.buttRating = AppearanceDefs.BUTT_RATING_LARGE+1;
			this.lowerBody = AppearanceDefs.LOWER_BODY_TYPE_CHITINOUS_SPIDER_LEGS;
			this.skinTone = "dusky";
			this.hairColor = "red";
			this.hairLength = 13;
			initStrTouSpeInte(70, 60, 99, 99);
			initLibSensCor(45, 35, 20);
			this.weaponName = "dagger";
			this.weaponVerb="stab";
			this.weaponAttack = 24 + (5 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
			this.armorName = "exoskeleton";
			this.armorDef = 23 + (3 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
			this.armorPerk = "";
			this.armorValue = 70;
			this.bonusHP = 200;
			this.bonusLust = 10;
			this.lust = 20;
			this.lustVuln = .6;
			this.temperment = TEMPERMENT_RANDOM_GRAPPLES;
			this.level = 18;
			this.gems = rand(15) + 15;
			this.drop = new WeightedDrop().add(consumables.S_GOSSR,5)
					.add(useables.T_SSILK,1)
					.add(null,4);
			this.tailType = AppearanceDefs.TAIL_TYPE_SPIDER_ADBOMEN;
			this.tailRecharge = 0;
			this.str += 14 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.tou += 12 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.spe += 19 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.inte += 19 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];			
			this.lib += 9 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.newgamebonusHP = 1460;
			checkMonster();
		}
		
	}

}
