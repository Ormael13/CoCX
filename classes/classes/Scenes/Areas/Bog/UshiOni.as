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
	public class UshiOni extends AbstractBullSpider
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
		
		public function UshiOni() 
		{
			this.a = "the ";
			this.short = "ushi oni";
			this.imageName = "ushi oni";
			this.long = "The ushi oni is completely nude, save for his thigh-high stockings and forearm-length gloves, which upon closer inspection, appear to be actually be part of his body - his exoskeleton.  His exposed skin is pale as the full moon, save for the dusk of his nipples and a patch of jet-black that spreads out over his groin, glossing the male's foreskinned cock and dangling sack in glistening ebon.  His ass is small but well-rounded, with a weighty spider-abdomen hanging from just above.  The ushi oni is currently eyeing you with a strange expression and his fangs bared.";
			// this.plural = false;
			this.magicuser = true;
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
			this.lowerBody = LowerBody.USHI_ONI;
			this.bodyColor = "dusky";
			this.hairColor = "red";
			this.hairLength = 13;
			initStrTouSpeInte(400, 370, 299, 189);
			initWisLibSensCor(219, 460, 130, -24);
			this.weaponName = "dagger";
			this.weaponVerb="stab";
			this.weaponAttack = 97;
			this.armorName = "exoskeleton";
			this.armorDef = 340;
			this.armorMDef = 40;
			this.armorPerk = "";
			this.armorValue = 70;
			this.bonusHP = 500;
			this.bonusLust = 644;
			this.lust = 20;
			this.lustVuln = .6;
			this.level = 54;
			this.gems = rand(15) + 20;
			this.drop = new WeightedDrop().add(consumables.TGOGODD,5)
					.add(useables.T_SSILK,1)
					.add(null,4);
			this.tailType = Tail.USHI_ONI;
			this.tailRecharge = 0;
			this.createPerk(PerkLib.MonsterRegeneration, 2, 0, 0, 0);
			checkMonster();
		}
		
	}

}
