/**
 * ...
 * @author Liadri
 */
package classes.Scenes.Areas.Ocean 
{
	import classes.*;
	import classes.internals.*;
	import classes.GlobalFlags.kFLAGS;

	public class UnderwaterTigersharkGirl extends Monster
	{
		
		public function UnderwaterTigersharkGirl() 
		{
			this.a = "the ";
			this.short = "shark-girl";
			this.imageName = "izma";
			this.long = "The tiger shark girl is menacingly circling you off waiting for the opportunity to viciously strike. These creatures clearly look way more deadly in the water then out of it!";
			// this.plural = false;
			this.createCock(15,2.2);
			this.balls = 4;
			this.ballSize = 3;
			this.createVagina(false, VAGINA_WETNESS_SLICK, VAGINA_LOOSENESS_LOOSE);
			this.createStatusEffect(StatusEffects.BonusVCapacity, 45, 0, 0, 0);
			createBreastRow(Appearance.breastCupInverse("DD"));
			this.ass.analLooseness = ANAL_LOOSENESS_NORMAL;
			this.ass.analWetness = ANAL_WETNESS_DRY;
			this.createStatusEffect(StatusEffects.BonusACapacity,30,0,0,0);
			this.tallness = 5*12+5;
			this.hipRating = HIP_RATING_CURVY;
			this.buttRating = BUTT_RATING_NOTICEABLE;
			this.skinTone = "striped orange";
			this.hairColor = "silver";
			this.hairLength = 20;
			initStrTouSpeInte(250, 170, 205, 110);
			initLibSensCor(120, 25, 40);
			this.weaponName = "shark teeth";
			this.weaponVerb="bite";
			this.weaponAttack = 66 + (14 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
			this.armorName = "tough skin";
			this.armorDef = 20 + (3 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
			this.bonusHP = 500;
			this.bonusLust = 20;
			this.lust = 20;
			this.lustVuln = .20;
			this.temperment = TEMPERMENT_RANDOM_GRAPPLES;
			this.level = 62;
			this.gems = rand(15) + 10;
			this.drop = new WeightedDrop().
					add(consumables.L_DRAFT,3).
					add(armors.S_SWMWR,1).
					add(consumables.TSTOOTH,5).
					add(null,1);
			//this.special1 = sharkTease;
			//this.special2 = sharkTease;
			this.createPerk(PerkLib.EnemyBeastOrAnimalMorphType, 0, 0, 0, 0);
			this.str += 100 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.tou += 68 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.spe += 82 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.inte += 44 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];			
			this.lib += 48 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.newgamebonusHP = 23940;
			checkMonster();
		}
		
	}

}