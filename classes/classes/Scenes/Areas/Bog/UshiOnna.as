package classes.Scenes.Areas.Bog 
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.BodyParts.LowerBody;
import classes.BodyParts.Tail;
import classes.Scenes.Monsters.AbstractBullSpider;
import classes.Scenes.SceneLib;
import classes.internals.*;

/**
	 * ...
	 * @author ...
	 */
	public class UshiOnna extends AbstractBullSpider 
	{
		override public function defeated(hpVictory:Boolean):void
		{
			SceneLib.bullSpidersScene.defeatBullSpider();
		}
		
		override protected function performCombatAction():void
		{
			if(player.spe >= 2 && rand(2) == 0) {
				spiderMorphWebAttack();
			}
			else if(!player.hasStatusEffect(StatusEffects.WebSilence) && rand(3) == 0) {
				spiderSilence();
			}
			else if(!player.hasStatusEffect(StatusEffects.Disarmed) && !player.isFistOrFistWeapon() && rand(3) == 0) {
				spiderDisarm();
			}
			else if(rand(2) == 0 || player.spe < 2) getBitten();
			else {
				if (rand(2) == 0) toxicBreathBullSpider();
				else eAttack();
			}
		}

		public function UshiOnna() 
		{
			this.a = "the ";
			this.short = "ushi onna";
			this.imageName = "ushi onna";
			this.long = "The ushi onna is completely nude, save for her thigh-high stockings and forearm-length gloves, which upon closer inspection, appear to be actually be part of her body - her exoskeleton.  Her exposed skin is pale as the full moon, save for the dusky skin of her nipples and the black-skinned delta of her sex.  Her breasts and ass are both full and well-rounded, and just above her ass-cheeks there's a bulbous spider-abdomen.  The ushi onna is currently eyeing you with a strange expression and her fangs bared.";
			// this.plural = false;
			this.magicuser = true;
			this.createVagina(false, VaginaClass.WETNESS_DROOLING, VaginaClass.LOOSENESS_LOOSE);
			this.createStatusEffect(StatusEffects.BonusVCapacity, 40, 0, 0, 0);
			createBreastRow(Appearance.breastCupInverse("E+"));
			this.ass.analLooseness = AssClass.LOOSENESS_VIRGIN;
			this.ass.analWetness = AssClass.WETNESS_DRY;
			this.createStatusEffect(StatusEffects.BonusACapacity,30,0,0,0);
			this.tallness = 7*12+6;
			this.hips.type = Hips.RATING_CURVY + 2;
			this.butt.type = Butt.RATING_LARGE + 1;
			this.lowerBody = LowerBody.USHI_ONI;
			this.bodyColor = "dusky";
			this.hairColor = "red";
			this.hairLength = 13;
			initStrTouSpeInte(410, 380, 307, 197);
			initWisLibSensCor(227, 485, 135, -20);
			this.weaponName = "dagger";
			this.weaponVerb="stab";
			this.weaponAttack = 99;
			this.armorName = "exoskeleton";
			this.armorDef = 350;
			this.armorMDef = 44;
			this.armorPerk = "";
			this.armorValue = 50;
			this.bonusHP = 600;
			this.bonusLust = 675;
			this.lust = 20;
			this.lustVuln = .6;
			this.level = 55;
			this.gems = rand(15) + 20;
			this.drop = new WeightedDrop().add(consumables.TGOGODD,5)
					.add(useables.T_SSILK,1)
					.add(null,4);
			this.tailType = Tail.USHI_ONI;
			this.createPerk(PerkLib.MonsterRegeneration, 2, 0, 0, 0);
			checkMonster();
		}
		
	}

}
