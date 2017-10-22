/**
 * ...
 * @author Ormael
 */
package classes.Scenes.NPCs 
{
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.internals.ChainedDrop;

public class RyuBiHuman extends Monster
	{
		
		public function RyuBiHuman() 
		{
			this.a = " ";
			this.short = "RyuBi";
			this.imageName = "ryubihuman";
			this.long = "You are currently 'battling' RyuBi in human form, in a playfight.  At least, that was the intention.  The way she lashes her tail along the ground, with claws spread and teeth bared ferociously, makes you wonder.";
			createVagina(true,AppearanceDefs.VAGINA_WETNESS_NORMAL,AppearanceDefs.VAGINA_LOOSENESS_NORMAL);
			createStatusEffect(StatusEffects.BonusVCapacity,10,0,0,0);
			createBreastRow(Appearance.breastCupInverse("F"));
			this.ass.analLooseness = AppearanceDefs.ANAL_LOOSENESS_TIGHT;
			this.ass.analWetness = AppearanceDefs.ANAL_WETNESS_DRY;
			this.createStatusEffect(StatusEffects.BonusACapacity,10,0,0,0);
			this.tallness = rand(8) + 70;
			this.hipRating = AppearanceDefs.HIP_RATING_AMPLE+2;
			this.buttRating = AppearanceDefs.BUTT_RATING_LARGE;
			this.skinTone = "red";
			this.hairColor = "black";
			this.hairLength = 15;
			initStrTouSpeInte(100, 90, 80, 90);
			initLibSensCor(50, 35, 50);
			this.weaponName = "claws";
			this.weaponVerb="claw";
			this.weaponAttack = 36 + (8 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
			this.armorName = "scales";
			this.armorDef = 54 + (6 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
			this.bonusHP = 600;
			this.bonusLust = 10;
			this.lust = 20;
			this.lustVuln = .25;
			this.temperment = TEMPERMENT_LOVE_GRAPPLES;
			this.level = 21;
			this.gems = 15 + rand(8);
			this.drop = new ChainedDrop().add(useables.D_SCALE, 0.2);//zamienić na worek of spirit stones ^^
			this.hornType = AppearanceDefs.HORNS_DRACONIC_X4_12_INCH_LONG;
			this.horns = 4;
			this.tailType = AppearanceDefs.TAIL_TYPE_DRACONIC;
			this.createPerk(PerkLib.EnemyBossType, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyGigantType, 0, 0, 0, 0);
			this.str += 24 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.tou += 18 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.spe += 20 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.inte += 18 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];			
			this.lib += 10 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.newgamebonusHP = 2700;
			checkMonster();
		}
		
	}

}