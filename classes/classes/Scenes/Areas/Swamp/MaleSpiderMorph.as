package classes.Scenes.Areas.Swamp
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.BodyParts.LowerBody;
import classes.BodyParts.Tail;
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
				outputText("\n\nThe spider flashes a predatory grin while he waits it out...");
				doNext(SceneLib.combat.endLustLoss);
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
			this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
			this.ass.analWetness = AssClass.WETNESS_DRY;
			this.createStatusEffect(StatusEffects.BonusACapacity,40,0,0,0);
			this.tallness = 7*12+6;
			this.hips.type = Hips.RATING_CURVY + 2;
			this.butt.type = Butt.RATING_LARGE + 1;
			this.lowerBody = LowerBody.CHITINOUS_SPIDER_LEGS;
			this.bodyColor = "dusky";
			this.hairColor = "red";
			this.hairLength = 13;
			initStrTouSpeInte(200, 170, 289, 289);
			initWisLibSensCor(289, 130, 100, -24);
			this.weaponName = "dagger";
			this.weaponVerb="stab";
			this.weaponAttack = 67;
			this.armorName = "exoskeleton";
			this.armorDef = 230;
			this.armorMDef = 20;
			this.armorPerk = "";
			this.armorValue = 70;
			this.bonusHP = 500;
			this.bonusLust = 263;
			this.lust = 20;
			this.lustVuln = .6;
			this.level = 33;
			this.gems = rand(15) + 15;
			this.drop = new WeightedDrop().add(consumables.S_GOSSR,5)
					.add(useables.T_SSILK,1)
					.add(null,4);
			this.tailType = Tail.SPIDER_ADBOMEN;
			this.tailRecharge = 0;
			checkMonster();
		}
		
	}

}
