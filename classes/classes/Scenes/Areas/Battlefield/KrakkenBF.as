/**
 * ...
 * @author Ormael
 */
package classes.Scenes.Areas.Battlefield 
{
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.internals.*;

public class KrakkenBF extends Monster
	{
		
		public function KrakkenBF() 
		{
			this.a = "";
			this.short = "Krakken";
			this.imageName = "krakken";
			this.long = "You are currently fighting 18 feet tall Krakken.";
			// this.plural = false;
			this.createVagina(false, AppearanceDefs.VAGINA_WETNESS_DROOLING, AppearanceDefs.VAGINA_LOOSENESS_GAPING);
			this.createStatusEffect(StatusEffects.BonusVCapacity, 200, 0, 0, 0);
			createBreastRow(Appearance.breastCupInverse("E"));
			this.ass.analLooseness = AppearanceDefs.ANAL_LOOSENESS_VIRGIN;
			this.ass.analWetness = AppearanceDefs.ANAL_WETNESS_NORMAL;
			this.tallness = 18*12;
			this.hipRating = AppearanceDefs.HIP_RATING_AMPLE;
			this.buttRating = AppearanceDefs.BUTT_RATING_NOTICEABLE;
			this.lowerBody = AppearanceDefs.LOWER_BODY_TYPE_SCYLLA;
			this.skin.setBaseOnly({color:"slippery"});
			this.hairColor = "brown";
			this.hairLength = 5;
			initStrTouSpeInte(150, 100, 50, 100);
			initWisLibSensCor(50, 50, 50, 50);
			this.weaponName = "tentacle";
			this.weaponVerb="slash";
			this.weaponAttack = 60;
			this.armorName = "thick skin";
			this.armorDef = 30;
			this.bonusHP = 150;
			this.bonusLust = 20;
			this.lust = 20;
			this.lustVuln = .2;
			this.level = 60;
			this.gems = 0;
			this.drop = new WeightedDrop(consumables.SPPEARL, 1);
			this.createPerk(PerkLib.EnemyBossType, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyGigantType, 0, 0, 0, 0);
			this.createPerk(PerkLib.RefinedBodyI, 0, 0, 0, 0);
			this.createPerk(PerkLib.TankI, 0, 0, 0, 0);
			this.createPerk(PerkLib.Regeneration, 0, 0, 0, 0);
			//this.createPerk(PerkLib., 0, 0, 0, 0);
			//this.createPerk(PerkLib., 0, 0, 0, 0);
			//this.createPerk(PerkLib., 0, 0, 0, 0);
			//this.createPerk(PerkLib., 0, 0, 0, 0);
			checkMonster();
		}
		
	}

}