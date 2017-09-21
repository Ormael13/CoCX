/**
 * ...
 * @author Ormael
 */
package classes.Scenes.Dungeons.HiddenCave 
{
	import classes.*;
	import classes.internals.*;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.GlobalFlags.kFLAGS;
	
	public class GuardianGolems extends Monster
	{
		public function backhand():void {
			outputText("The golems visage twists into a grimace of irritation, and few of them swings their hands at you in a vicious backhand.");
			var damage:Number = int (((str + weaponAttack) * 5) - rand(player.tou) - player.armorDef);
			//Dodge
			if (damage <= 0 || (player.getEvasionRoll())) outputText(" You slide underneath the surprise swings!");
			else
			{
				outputText(" They chits you square in the chest from a few different angles. ");
				damage = player.takeDamage(damage, true);
			}
		}
		
		override protected function performCombatAction():void
		{
			var choice:Number = rand(3);
			if (choice < 2) eAttack();
			if (choice == 2) backhand();
			combatRoundOver();
		}
		
	//	override public function defeated(hpVictory:Boolean):void
	//	{
	//		game.dungeons.hiddencave.cumWitchDefeated();
	//	}
		
		override public function won(hpVictory:Boolean,pcCameWorms:Boolean):void
		{
			game.dungeons.hiddencave.defeatedByGuardianGolems();
		}
		
		public function GuardianGolems() 
		{
			this.a = "the ";
			this.short = "guardian golems";
			this.imageName = "guardian golems";
			this.long = "You're currently fighting guardian golems. They're all around six feet tall without any sexual characteristics, their stone body covered in cracks and using bare stone fists to smash enemies.";
			this.plural = true;
			this.lustVuln = 0;
			this.createBreastRow(0, 1);
			initGenderless();
			initStrTouSpeInte(20, 25, 20, 10);
			initLibSensCor(10, 10, 50);
			this.tallness = 72;
			this.drop = new ChainedDrop()
					.add(useables.GOLCORE, 1);
			this.level = 7;
			this.bonusHP = 75;
			this.weaponName = "stone fists";
			this.weaponVerb = "smash";
			this.weaponAttack = 12 + (3 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
			this.armorName = "cracked stone";
			this.armorDef = 12 + (2 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
			this.createPerk(PerkLib.Resolute, 0, 0, 0, 0);
			this.createPerk(PerkLib.RefinedBodyI, 0, 0, 0, 0);
			this.createPerk(PerkLib.TankI, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyGroupType, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyConstructType, 0, 0, 0, 0);
			this.str += 4 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.tou += 5 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.spe += 4 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.inte += 2 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];			
			this.lib += 2 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.newgamebonusHP = 170;
			checkMonster();
		}
		
	}

}