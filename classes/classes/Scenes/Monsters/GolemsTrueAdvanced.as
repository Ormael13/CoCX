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
	
	public class GolemsTrueAdvanced extends AbstractGolem
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
			combatRoundOver();
		}
		
		public function overhandSmash():void {
			outputText("Raising their fists high overhead, the golems swiftly brings them down in a punishing strike!");
			
			var damage:Number = 100 + int(((str + weaponAttack) * 5) - rand(player.tou) - player.armorDef);
			if (damage <= 0 || rand(100) < 25 || player.getEvasionRoll()) outputText(" You're able to sidestep it just in time.");
			else
			{
				outputText(" The concussive strikes impacts you with a bonecrushing force. ");
				damage = player.takeDamage(damage, true);
			}
		}
		
		override protected function performCombatAction():void
		{
			if (this.HPRatio() < 0.6) {
				var choice2:Number = rand(5);
				if (choice2 < 3) eAttack();
				if (choice2 == 3) backhand();
				if (choice2 == 4) overhandSmash();
			}
			else if (this.HPRatio() < 0.8) {
				var choice1:Number = rand(4);
				if (choice1 < 3) eAttack();
				if (choice1 == 3) backhand();
			}
			else eAttack();
			combatRoundOver();
		}
		
		public function GolemsTrueAdvanced() 
		{
			super(true);
			this.a = "the ";
			this.short = "advanced true golems";
			this.imageName = "advanced true golems";
			this.long = "You're currently fighting advanced true golems. They're all around eight feet tall without any sexual characteristics, their stone body covered in cracks and using bare stone fists to smash enemies.";
			this.plural = true;
			initStrTouSpeInte(250, 200, 150, 10);
			initLibSensCor(10, 10, 50);
			this.tallness = 96;
			this.drop = new ChainedDrop()
					.add(useables.GOLCORE, 1);
			this.level = 51;
			this.bonusHP = 650;
			this.additionalXP = 650;
			this.weaponName = "stone fists";
			this.weaponVerb = "smash";
			this.weaponAttack = 70 + (15 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
			this.armorName = "stone";
			this.armorDef = 70 + (8 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
			this.createPerk(PerkLib.RefinedBodyI, 0, 0, 0, 0);
			this.createPerk(PerkLib.TankI, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyGroupType, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyConstructType, 0, 0, 0, 0);
			this.str += 100 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.tou += 80 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.spe += 60 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.inte += 4 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];			
			this.lib += 4 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.newgamebonusHP = 14880;
			checkMonster();
		}
		
	}

}