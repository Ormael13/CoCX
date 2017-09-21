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
	import classes.Scenes.Places.HeXinDao;
	
	public class DarkElfScout extends Monster
	{
		public var darkelf:DarkElfScene = new DarkElfScene();
		public var golems:HeXinDao = new HeXinDao();
		
		override public function defeated(hpVictory:Boolean):void
		{
			if (player.hasStatusEffect(StatusEffects.SoulArena)) {
				golems.gaunletchallange1postfight();
			}
			else darkelf.wonWithDarkElf();
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			darkelf.lostToDarkElf();
		}
		
		public function DarkElfBowShooting():void
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
		}
		
		public function PoisonedBowShoot():void
		{
			if (player.hasStatusEffect(StatusEffects.WindWall)) {
				outputText("An arrow hits wind wall dealing no damage to you.\n\n");
				player.addStatusValue(StatusEffects.WindWall,2,-1);
			}
			else {
				var damage:Number = 0;
				damage += eBaseSpeedDamage() * 0.2;
				damage = player.reduceDamage(damage);
				if (damage < 10) damage = 10;
				if (this.weaponRangeAttack < 51) damage *= (1 + (this.weaponRangeAttack * 0.03));
				else if (this.weaponRangeAttack >= 51 && this.weaponRangeAttack < 101) damage *= (2.5 + ((this.weaponRangeAttack - 50) * 0.025));
				else if (this.weaponRangeAttack >= 101 && this.weaponRangeAttack < 151) damage *= (3.75 + ((this.weaponRangeAttack - 100) * 0.02));
				else if (this.weaponRangeAttack >= 151 && this.weaponRangeAttack < 201) damage *= (4.75 + ((this.weaponRangeAttack - 150) * 0.015));
				else damage *= (5.5 + ((this.weaponRangeAttack - 200) * 0.01));
				damage = Math.round(damage);
				outputText("An arrow hit you for ");
				player.takeDamage(damage, true);
				outputText(" damage. It was poisoned you feel your strength failing you!\n\n");
				if (player.hasStatusEffect(StatusEffects.BasiliskSlow)) {
					player.addStatusValue(StatusEffects.BasiliskSlow, 1, 2);
					player.spe -= 2;
				}
				else {
					player.createStatusEffect(StatusEffects.BasiliskSlow, 3, 0, 0, 0);
					player.spe -= 3;
				}
				showStatDown( 'spe' );
			}
		}
		
		public function AnkleShot():void
		{
			outputText("The dark skinned elf shot you through the ankle and gains some distance. Crippled like you are, it will be annoying to catch her, if not impossible. Better use ranged attack until you recover mobility.");
			player.createStatusEffect(StatusEffects.Sealed2, 4, 0, 0, 0);
		}
		
		public function WingClip():void
		{
			if (player.hasStatusEffect(StatusEffects.WindWall)) {
				outputText("An arrow hits wind wall dealing no damage to you.\n\n");
				player.addStatusValue(StatusEffects.WindWall,2,-1);
			}
			else {
				outputText("The dark elf makes a wicked smirk before letting out an arrow straight into your wing. You fall down, unable to fly and crashing to the ground. ");
				player.removeStatusEffect(StatusEffects.Flying);
				var damage:Number = 0;
				damage += this.str * 1.5;
				damage += eBaseSpeedDamage() * 1.5;
				if (damage < 10) damage = 10;
				if (this.weaponRangeAttack < 51) damage *= (1 + (this.weaponRangeAttack * 0.03));
				else if (this.weaponRangeAttack >= 51 && this.weaponRangeAttack < 101) damage *= (2.5 + ((this.weaponRangeAttack - 50) * 0.025));
				else if (this.weaponRangeAttack >= 101 && this.weaponRangeAttack < 151) damage *= (3.75 + ((this.weaponRangeAttack - 100) * 0.02));
				else if (this.weaponRangeAttack >= 151 && this.weaponRangeAttack < 201) damage *= (4.75 + ((this.weaponRangeAttack - 150) * 0.015));
				else damage *= (5.5 + ((this.weaponRangeAttack - 200) * 0.01));
				damage = Math.round(damage);
				player.takeDamage(damage, true);
				outputText("\n\n");
			}
		}
		
		override protected function performCombatAction():void
		{
			var choice:Number = rand(3);
			if (choice == 0) DarkElfBowShooting();
			if (choice == 1) {
				if (!player.hasStatusEffect(StatusEffects.Sealed2)) AnkleShot();
				else DarkElfBowShooting();
			}
			if (choice == 2) {
				if (player.hasStatusEffect(StatusEffects.Flying) && rand(4) == 0) WingClip();
				else DarkElfBowShooting();
			}
			combatRoundOver();
		}
		
		public function DarkElfScout() 
		{
			this.a = "the ";
			this.short = "dark elf scout";
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
			initStrTouSpeInte(30, 30, 90, 40);
			initLibSensCor(50, 60, 80);
			this.weaponName = "dagger";
			this.weaponVerb= "stab";
			this.weaponAttack = 5 + (1 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
			this.weaponRangeName = "elven bow";
			this.weaponRangeVerb= "shoot";
			this.weaponRangeAttack = 18 + (4 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
			this.armorName = "elven armor";
			this.armorDef = 4 + (1 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
			this.bonusLust = 20;
			this.lustVuln = .7;
			this.lust = 50;
			this.temperment = TEMPERMENT_RANDOM_GRAPPLES;
			this.level = 15;
			this.gems = rand(10) + 10;
			this.drop = new WeightedDrop().
					add(weaponsrange.BOWLIGH,1).
					add(consumables.ELFEARS,4);
			this.str += 6 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.tou += 6 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.spe += 18 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.inte += 8 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];			
			this.lib += 10 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.newgamebonusHP = 960;
			checkMonster();
		}
	}
}