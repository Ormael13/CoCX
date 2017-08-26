/**
 * ...
 * @author Liadri
 */
package classes.Scenes.Monsters 
{
	import classes.*;
	import classes.internals.*;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.GlobalFlags.kFLAGS;
	import classes.Scenes.Monsters.DarkElfScene;
	
	public class DarkElfRanger extends DarkElfScout
	{
		override public function DarkElfBowShooting():void
		{
			var Acc:Number = 0;
			Acc += (this.spe - player.spe);
			if (Acc < 0) Acc = 0;
			outputText("The black skinned elf aims her bow at you, drawing several arrows and starts shooting.\n\n");
			PoisonedBowShoot();
			if (rand(100) < (90 + Acc)) PoisonedBowShoot();
			else outputText("An arrow missed you.\n\n");
			if (rand(100) < (80 + Acc)) PoisonedBowShoot();
			else outputText("An arrow missed you.\n\n");
			if (rand(100) < (70 + Acc)) PoisonedBowShoot();
			else outputText("An arrow missed you.\n\n");
			if (rand(100) < (60 + Acc)) PoisonedBowShoot();
			else outputText("An arrow missed you.\n\n");
		}
		
		public function DarkElfRanger() 
		{
			this.a = "the ";
			this.short = "dark elf ranger";
			this.imageName = "dark elf";
			this.long = "This woman with dark skin has long pointed ears. You suspect her to be a dark elf, though why she’s here on the surface, you have no idea. Regardless, she’s dangerous and seems well equipped for kidnapping.";
			this.createVagina(false, VAGINA_WETNESS_SLAVERING, VAGINA_LOOSENESS_NORMAL);
			this.createStatusEffect(StatusEffects.BonusVCapacity, 30, 0, 0, 0);
			createBreastRow(Appearance.breastCupInverse("DD"));
			this.ass.analLooseness = ANAL_LOOSENESS_STRETCHED;
			this.ass.analWetness = ANAL_WETNESS_SLIME_DROOLING;
			this.tallness = 72;
			this.hipRating = HIP_RATING_CURVY;
			this.buttRating = BUTT_RATING_LARGE+1;
			this.lowerBody = LOWER_BODY_TYPE_ELF;
			this.skinTone = "dark";
			this.hairColor = "silver";
			this.hairLength = 13;
			initStrTouSpeInte(90, 130, 190, 100);
			initLibSensCor(70, 80, 90);
			this.weaponName = "dagger";
			this.weaponVerb= "stab";
			this.weaponAttack = 5 + (1 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
			this.weaponRangeName = "elven bow";
			this.weaponRangeVerb= "shoot";
			this.weaponRangeAttack = 30 + (7 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
			this.armorName = "elven armor";
			this.armorDef = 12 + (2 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
			this.bonusLust = 20;
			this.lustVuln = .7;
			this.lust = 50;
			this.temperment = TEMPERMENT_RANDOM_GRAPPLES;
			this.level = 39;
			this.gems = rand(10) + 20;
			this.drop = new WeightedDrop().
					add(weaponsrange.BOWLIGH,1).
					add(consumables.ELFEARS,4);
			this.str += 27 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.tou += 39 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.spe += 57 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.inte += 30 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];			
			this.lib += 21 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.newgamebonusHP = 6960;
			checkMonster();
		}
		
	}

}