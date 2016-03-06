package classes.Scenes.Areas.Swamp
{
	import classes.*;
	import classes.internals.*;

	public class MaleSpiderMorph extends AbstractSpiderMorph
	{


		override public function defeated(hpVictory:Boolean):void
		{
			game.swamp.maleSpiderMorphScene.defeatSpiderBoy();
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if (pcCameWorms){
				outputText("\n\nThe spider flashes a predatory grin while she waits it out...");
				doNext(game.combat.endLustLoss);
			} else {
				game.swamp.maleSpiderMorphScene.loseToMaleSpiderMorph();
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
			this.ass.analLooseness = ANAL_LOOSENESS_TIGHT;
			this.ass.analWetness = ANAL_WETNESS_DRY;
			this.createStatusEffect(StatusEffects.BonusACapacity,40,0,0,0);
			this.tallness = 7*12+6;
			this.hipRating = HIP_RATING_CURVY+2;
			this.buttRating = BUTT_RATING_LARGE+1;
			this.lowerBody = LOWER_BODY_TYPE_CHITINOUS_SPIDER_LEGS;
			this.skinTone = "dusky";
			this.hairColor = "red";
			this.hairLength = 13;
			initStrTouSpeInte(60, 50, 99, 99);
			initLibSensCor(35, 35, 20);
			this.weaponName = "dagger";
			this.weaponVerb="stab";
			this.weaponAttack = 15;
			this.armorName = "exoskeleton";
			this.armorDef = 14;
			this.armorPerk = "";
			this.armorValue = 70;
			this.bonusHP = 200;
			this.lust = 20;
			this.lustVuln = .6;
			this.temperment = TEMPERMENT_RANDOM_GRAPPLES;
			this.level = 13;
			this.gems = rand(10) + 10;
			this.drop = new WeightedDrop().add(consumables.S_GOSSR,5)
					.add(useables.T_SSILK,1)
					.add(null,4);
			this.tailType = TAIL_TYPE_SPIDER_ADBOMEN;
			this.tailRecharge = 0;
			checkMonster();
		}
		
	}

}