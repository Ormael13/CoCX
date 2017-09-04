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
	
	public class GolemDummy extends AbstractGolem
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
			if (this.HPRatio() < 0.75) {
				var choice:Number = rand(4);
				if (choice < 3) eAttack();
				if (choice == 3) backhand();
			}
			else eAttack();
			combatRoundOver();
		}
		
		public function GolemDummy() 
		{
			super(false);
			this.a = "the ";
			this.short = "dummy golem";
			this.imageName = "dummy golem";
			this.long = "You're currently fighting dummy golem. It's six feet tall without any sexual characteristics, it stone body covered in cracks and using it bare stone fists to smash enemies.";
			initStrTouSpeInte(20, 20, 10, 10);
			initLibSensCor(10, 10, 50);
			this.tallness = 72;
			this.drop = new ChainedDrop()
					.add(useables.GOLCORE, 1/4);
			this.level = 6;
			this.bonusHP = 50;
			this.additionalXP = 50;
			this.weaponName = "stone fists";
			this.weaponVerb = "smash";
			this.weaponAttack = 10 + (3 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
			this.armorName = "cracked stone";
			this.armorDef = 10 + (2 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
			this.createPerk(PerkLib.RefinedBodyI, 0, 0, 0, 0);
			this.createPerk(PerkLib.TankI, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyConstructType, 0, 0, 0, 0);
			this.str += 4 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.tou += 4 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.spe += 2 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.inte += 2 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];			
			this.lib += 2 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.newgamebonusHP = 140;
			checkMonster();
		}
		
	}

}