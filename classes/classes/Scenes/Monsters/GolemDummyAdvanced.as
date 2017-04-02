/**
 * ...
 * @author Ormael
 */
package classes.Scenes.Monsters 
{

	import classes.*;
	import classes.internals.*;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.GlobalFlags.kFLAGS;
	
	public class GolemDummyAdvanced extends Monster
	{
		public function backhand():void {
			outputText("The golem's visage twists into a grimace of irritation, and it swings its hand at you in a vicious backhand.");
			var damage:Number = int ((str + weaponAttack) - rand(player.tou) - player.armorDef);
			//Dodge
			if (damage <= 0 || (player.getEvasionRoll())) outputText(" You slide underneath the surprise swing!");
			else
			{
				outputText(" It chits you square in the chest. ");
				damage = player.takeDamage(damage, true);
			}
		}
		
		override protected function performCombatAction():void
		{
			var choice:Number = rand(4);
			if (choice < 3) eAttack();
			if (choice == 3) backhand();
			combatRoundOver();
		}
		
		public function GolemDummyAdvanced() 
		{
			this.a = "the ";
			this.short = "advanced dummy golem";
			this.imageName = "advanced dummy golem";
			this.long = "You're currently fighting advanced dummy golem. It's seven feet tall without any sexual characteristics, it stone body covered in cracks and using it bare stone fists to smash enemies.";
			this.plural = false;
			initStrTouSpeInte(60, 60, 30, 10);
			initLibSensCor(10, 10, 50);
			this.lustVuln = 0;
			this.tallness = 84;
			this.createBreastRow(0, 1);
			initGenderless();
			this.drop = new ChainedDrop()
					.add(useables.GOLCORE, 1/4);
			this.level = 18;
			this.bonusHP = 150;
			this.additionalXP = 150;
			this.weaponName = "stone fists";
			this.weaponVerb = "smash";
			this.weaponAttack = 20 + (5 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
			this.armorName = "cracked stone";
			this.armorDef = 20 + (3 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
			this.createPerk(PerkLib.RefinedBodyI, 0, 0, 0, 0);
			this.createPerk(PerkLib.TankI, 0, 0, 0, 0);
			this.str += 12 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.tou += 12 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.spe += 6 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.inte += 2 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];			
			this.lib += 2 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.newgamebonusHP = 680;
			checkMonster();
		}
		
	}

}