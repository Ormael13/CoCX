/**
 * ...
 * @author Ormael
 */
package classes.Scenes.Monsters 
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.BodyParts.Tail;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.SceneLib;
import classes.internals.*;

	public class Oozaru extends Monster
	{
		
		public function Oozaru() 
		{
			if (flags[kFLAGS.SAIYAN_ENEMY_NUMBER_COUNTER] == 1) {//female
				this.long = "";
				createVagina(true,VaginaClass.WETNESS_NORMAL,VaginaClass.LOOSENESS_TIGHT);
				this.createStatusEffect(StatusEffects.BonusVCapacity,75,0,0,0);
				createBreastRow(Appearance.breastCupInverse("F"));
				this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
				this.ass.analWetness = AssClass.WETNESS_DRY;
				this.createStatusEffect(StatusEffects.BonusACapacity,25,0,0,0);
				this.tallness = 30*12;
				this.hips.type = Hips.RATING_CURVY + 3;
				this.butt.type = Butt.RATING_LARGE + 2;
				this.skinTone = "platinum brown";
				this.hairColor = "platinum green";
				this.hairLength = 5;
				this.weaponName = "fist";
				this.weaponVerb="punch";
				this.armorName = "fur";
				this.lust = 30;
				this.lustVuln = .8;
				//if (statusEffectv2(StatusEffects.SaiyanNumber1a) == 1) {
					initStrTouSpeInte(100, 100, 100, 25);
					initWisLibSensCor(25, 200, 100, 50);
					this.weaponAttack = 50;
					this.armorDef = 50;
					this.armorMDef = 50;
					this.bonusHP = 100;
					this.bonusWrath = 25;
					this.bonusLust = 318;
					this.level = 18;
				//}
			}
			this.a = "the ";
			this.short = "oozaru";
			this.temperment = TEMPERMENT_RANDOM_GRAPPLES;
			this.gems = 45 + rand(40);
			this.drop = NO_DROP;
			this.tailType = Tail.MONKEY;
			this.tailRecharge = 0;
			this.createPerk(PerkLib.EnemyGigantType, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyGodType, 0, 0, 0, 0);
			checkMonster();
		}
		
	}

}