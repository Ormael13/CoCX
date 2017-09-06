/**
 * ...
 * @author Ormael
 */
package classes.Scenes.NPCs 
{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.internals.*;
	
	public class Jinx extends Monster
	{
		
		public function Jinx() 
		{
			this.a = "the ";
			this.short = "ayotech maniac";
			this.imageName = "ayotech maniac";
			this.long = "You're currently fighting an ayotech maniac.";
			this.plural = false;
			createBreastRow(Appearance.breastCupInverse("A"));
			this.createVagina(false, VAGINA_WETNESS_DRY, VAGINA_LOOSENESS_TIGHT);
			this.createStatusEffect(StatusEffects.BonusVCapacity,10,0,0,0);
			this.ass.analLooseness = ANAL_LOOSENESS_VIRGIN;
			this.ass.analWetness = ANAL_WETNESS_DRY;
			this.createStatusEffect(StatusEffects.BonusACapacity,10,0,0,0);
			this.tallness = 120;
			this.hipRating = HIP_RATING_BOYISH;
			this.buttRating = BUTT_RATING_BUTTLESS;
			this.skin.setBaseOnly({color:"olive"});//zmienić?
			this.hairColor = "blue";
			this.hairLength = 20;
			initStrTouSpeInte(50, 50, 40, 40);
			initLibSensCor(20, 10, 50);
			this.lustVuln = 0.85;
			this.drop = NO_DROP;
			//this.drop = new ChainedDrop()
			//		.add(useables.GOLCORE, 1/4);
			this.level = 15;
			//this.bonusHP = 200;
			this.weaponName = "spiked fists";//zdecydowanie zmienić na coś innego
			this.weaponVerb = "smash";
			this.weaponAttack = 16 + (4 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
			this.armorName = "light ayo armor";//zamienić na coś innego?
			this.armorDef = 30 + (4 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
			//this.createPerk(PerkLib.JobGuardian, 0, 0, 0, 0);
			this.str += 10 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.tou += 10 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.spe += 8 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.inte += 8 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];			
			this.lib += 4 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.newgamebonusHP = 800;//*20
			checkMonster();
		}
		
	}

}