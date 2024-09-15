package classes.Scenes.Areas.Swamp
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.BodyParts.LowerBody;
import classes.BodyParts.Tail;
import classes.Scenes.SceneLib;
import classes.internals.*;

/**
	 * ...
	 * @author ...
	 */
	public class FemaleSpiderMorph extends AbstractSpiderMorph
	{


		override public function defeated(hpVictory:Boolean):void
		{
			SceneLib.swamp.femaleSpiderMorphScene.defeatASpiderBitch();
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if(pcCameWorms){
				outputText("\n\nThe spider flashes a predatory grin while she waits it out...");
				doNext(SceneLib.combat.endLustLoss);
			} else {
				SceneLib.swamp.femaleSpiderMorphScene.loseToFemaleSpiderMorph();
			}
		}

		public function FemaleSpiderMorph()
		{
			this.a = "the ";
			this.short = "female spider-morph";
			this.imageName = "femalespidermorph";
			this.long = "The female spider-morph is completely nude, save for her thigh-high stockings and forearm-length gloves, which upon closer inspection, appear to be actually be part of her body - her exoskeleton.  Her exposed skin is pale as the full moon, save for the dusky skin of her nipples and the black-skinned delta of her sex.  Her breasts and ass are both full and well-rounded, and just above her ass-cheeks there's a bulbous spider-abdomen.  The spider-girl is currently eyeing you with a strange expression and her fangs bared.";
			// this.plural = false;
			this.createVagina(false, VaginaClass.WETNESS_DROOLING, VaginaClass.LOOSENESS_LOOSE);
			this.createStatusEffect(StatusEffects.BonusVCapacity, 40, 0, 0, 0);
			createBreastRow(Appearance.breastCupInverse("E+"));
			this.ass.analLooseness = AssClass.LOOSENESS_VIRGIN;
			this.ass.analWetness = AssClass.WETNESS_DRY;
			this.createStatusEffect(StatusEffects.BonusACapacity,30,0,0,0);
			this.tallness = 7*12+6;
			this.hips.type = Hips.RATING_CURVY + 2;
			this.butt.type = Butt.RATING_LARGE + 1;
			this.lowerBody = LowerBody.CHITINOUS_SPIDER_LEGS;
			this.bodyColor = "dusky";
			this.hairColor = "red";
			this.hairLength = 13;
			initStrTouSpeInte(210, 180, 297, 297);
			initWisLibSensCor(297, 135, 105, -20);
			this.weaponName = "dagger";
			this.weaponVerb="stab";
			this.weaponAttack = 69;
			this.armorName = "exoskeleton";
			this.armorDef = 240;
			this.armorMDef = 22;
			this.armorPerk = "";
			this.armorValue = 50;
			this.bonusHP = 600;
			this.bonusLust = 275;
			this.lust = 20;
			this.lustVuln = .6;
			this.level = 35;
			this.gems = rand(15) + 15;
			this.drop = new WeightedDrop().add(consumables.S_GOSSR,5)
					.add(useables.T_SSILK,1)
					.add(null,4);
			this.tailType = Tail.SPIDER_ADBOMEN;
			checkMonster();
		}
		
	}

}
