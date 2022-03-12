/**
 * ...
 * @author Ormael
 */
package classes.Scenes.Explore 
{
import classes.*;
import classes.GlobalFlags.*;
import classes.Appearance;
import classes.BodyParts.*;
import classes.BreastRowClass;
import classes.Cock;
import classes.Monster;
import classes.PerkLib;
import classes.Scenes.SceneLib;
import classes.VaginaClass;

	public class TheDummy extends Monster
	{
		
		public function TheDummy() 
		{
			this.a = "the ";
			this.short = "Dummy";
			this.long = "You’re facing The Dummy. Can't harm a fly (too much) but still can take a beating or teasing very well...";
			this.plural = false;
			this.createCock(30,4,CockTypesEnum.FOX);
			this.balls = 2;
			this.ballSize = 6;
			this.cumMultiplier = 6;
			this.hoursSinceCum = 400;
			createBreastRow(0);
			this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
			this.ass.analWetness = AssClass.WETNESS_NORMAL;
			this.createStatusEffect(StatusEffects.BonusACapacity,20,0,0,0);
			this.tallness = rand(14) + 70;
			this.hips.type = Hips.RATING_SLENDER;
			this.butt.type = Butt.RATING_TIGHT;
			this.skinTone = "grey";
			this.hairColor = "grey";
			this.hairLength = 31 + rand(10);
			initStrTouSpeInte(15, 10000, 15, 15);
			initWisLibSensCor(15, 10000, 15, 50);
			this.weaponName = "worn down staff";
			this.weaponVerb="smack";
			this.weaponAttack = 8;
			this.armorName = "red kimono";
			this.armorDef = 20;
			this.armorMDef = 50;
			this.bonusHP = 15276591;
			this.bonusLust = 162595;
			this.bonusWrath = 3000;
			this.bonusMana = 3000;
			this.bonusSoulforce = 3000;
			this.lust = 20;
			this.lustVuln = 0.5;
			this.temperment = TEMPERMENT_LUSTY_GRAPPLES;
			this.level = player.level;
			this.gems = 1;
			this.drop = NO_DROP;
			this.createPerk(PerkLib.EnemyGodType, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyBossType, 0, 0, 0, 0);
			this.createPerk(PerkLib.DemonicDesireI, 0, 0, 0, 0);
			this.createPerk(PerkLib.CheetahI, 0, 0, 0, 0);
			this.createPerk(PerkLib.GoliathI, 0, 0, 0, 0);
			this.createPerk(PerkLib.TankI, 0, 0, 0, 0);
			checkMonster();
		}
	}
}