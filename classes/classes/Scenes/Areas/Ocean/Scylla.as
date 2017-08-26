/**
 * ...
 * @author Liadri
 */
package classes.Scenes.Areas.Ocean 
{
	import classes.*;
	import classes.internals.*;
	import classes.GlobalFlags.kFLAGS;

	public class Scylla extends Monster
	{
		
		public function Scylla() 
		{
			this.a = "";
			this.short = "Scylla";
			this.imageName = "scylla";
			this.long = "You are currently fighting 10 feet tall scylla.";
			// this.plural = false;
			this.createVagina(false, VAGINA_WETNESS_DROOLING, VAGINA_LOOSENESS_GAPING);
			this.createStatusEffect(StatusEffects.BonusVCapacity, 200, 0, 0, 0);
			createBreastRow(Appearance.breastCupInverse("E"));
			this.ass.analLooseness = ANAL_LOOSENESS_VIRGIN;
			this.ass.analWetness = ANAL_WETNESS_NORMAL;
			this.tallness = 10*12;
			this.hipRating = HIP_RATING_AMPLE;
			this.buttRating = BUTT_RATING_NOTICEABLE;
			this.lowerBody = LOWER_BODY_TYPE_SCYLLA;
			this.skin.setBaseOnly({color:"slippery"});
			this.hairColor = "brown";
			this.hairLength = 5;
			initStrTouSpeInte(350, 100, 100, 150);
			initLibSensCor(100, 50, 50);
			this.weaponName = "tentacle";
			this.weaponVerb="slash";
			this.weaponAttack = 86 + (18 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
			this.armorName = "thick skin";
			this.armorDef = 52 + (6 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
			this.bonusHP = 3000;
			this.bonusLust = 20;
			this.lust = 20;
			this.lustVuln = .2;
			this.level = 70;
			this.gems = 0;
			this.drop = new WeightedDrop(consumables.BLACKIN, 1);
			this.createPerk(PerkLib.RefinedBodyI, 0, 0, 0, 0);
			this.createPerk(PerkLib.TankI, 0, 0, 0, 0);
			this.createPerk(PerkLib.Regeneration, 0, 0, 0, 0);
			this.str += 140 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.tou += 40 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.spe += 40 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.inte += 60 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];			
			this.lib += 40 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.newgamebonusHP = 26400;
			checkMonster();
		}
		
	}

}