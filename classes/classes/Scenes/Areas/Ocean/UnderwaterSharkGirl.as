/**
 * ...
 * @author Liadri
 */
package classes.Scenes.Areas.Ocean 
{
	import classes.*;
	import classes.internals.*;
	import classes.GlobalFlags.kFLAGS;

	public class UnderwaterSharkGirl extends Monster
	{
		
		public function UnderwaterSharkGirl() 
		{
			this.a = "the ";
			this.short = "shark-girl";
			this.imageName = "sharkgirl";
			this.long = "The shark/tiger shark girl is menacingly circling you off waiting for the opportunity to viciously strike. These creatures clearly look way more deadly in the water then out of it!";
			// this.plural = false;
			this.createVagina(false, VAGINA_WETNESS_DROOLING, VAGINA_LOOSENESS_NORMAL);
			this.createStatusEffect(StatusEffects.BonusVCapacity, 15, 0, 0, 0);
			createBreastRow(Appearance.breastCupInverse("D"));
			this.ass.analLooseness = ANAL_LOOSENESS_TIGHT;
			this.ass.analWetness = ANAL_WETNESS_DRY;
			this.createStatusEffect(StatusEffects.BonusACapacity,40,0,0,0);
			this.tallness = 5*12+5;
			this.hipRating = HIP_RATING_AMPLE+2;
			this.buttRating = BUTT_RATING_LARGE;
			this.skinTone = "gray";
			this.hairColor = "silver";
			this.hairLength = 16;
			initStrTouSpeInte(200, 140, 160, 90);
			initLibSensCor(100, 35, 40);
			this.weaponName = "shark teeth";
			this.weaponVerb="bite";
			this.weaponAttack = 30 + (7 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
			this.armorName = "tough skin";
			this.armorDef = 20 + (3 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
			this.bonusHP = 100;
			this.bonusLust = 20;
			this.lust = 40;
			this.lustVuln = .9;
			this.temperment = TEMPERMENT_RANDOM_GRAPPLES;
			this.level = 56;
			this.gems = rand(30) + 25;
			this.drop = new WeightedDrop().
					add(consumables.L_DRAFT,3).
					add(armors.S_SWMWR,1).
					add(consumables.SHARK_T,5).
					add(null,1);
			//this.special1 = sharkTease;
			//this.special2 = sharkTease;
			this.createPerk(PerkLib.EnemyBeastOrAnimalMorphType, 0, 0, 0, 0);
			this.str += 80 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.tou += 56 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.spe += 64 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.inte += 36 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];			
			this.lib += 40 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.newgamebonusHP = 16560;
			checkMonster();
		}
		
	}

}