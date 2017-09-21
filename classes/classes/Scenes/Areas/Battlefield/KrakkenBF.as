/**
 * ...
 * @author Ormael
 */
package classes.Scenes.Areas.Battlefield 
{
	import classes.*;
	import classes.internals.*;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.GlobalFlags.kFLAGS;
	
	public class KrakkenBF extends Monster
	{
		
		public function KrakkenBF() 
		{
			this.a = "";
			this.short = "Krakken";
			this.imageName = "krakken";
			this.long = "You are currently fighting 18 feet tall Krakken.";
			// this.plural = false;
			this.createVagina(false, VAGINA_WETNESS_DROOLING, VAGINA_LOOSENESS_GAPING);
			this.createStatusEffect(StatusEffects.BonusVCapacity, 200, 0, 0, 0);
			createBreastRow(Appearance.breastCupInverse("E"));
			this.ass.analLooseness = ANAL_LOOSENESS_VIRGIN;
			this.ass.analWetness = ANAL_WETNESS_NORMAL;
			this.tallness = 18*12;
			this.hipRating = HIP_RATING_AMPLE;
			this.buttRating = BUTT_RATING_NOTICEABLE;
			this.lowerBody = LOWER_BODY_TYPE_SCYLLA;
			this.skin.setBaseOnly({color:"slippery"});
			this.hairColor = "brown";
			this.hairLength = 5;
			initStrTouSpeInte(150, 100, 50, 100);
			initLibSensCor(50, 50, 50);
			this.weaponName = "tentacle";
			this.weaponVerb="slash";
			this.weaponAttack = 60 + (2 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
			this.armorName = "thick skin";
			this.armorDef = 30 + (2 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
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
			this.str += 10 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.tou += 12 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.spe += 6 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.inte += 7 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];			
			this.lib += 2 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.newgamebonusHP = 37;
			checkMonster();
		}
		
	}

}