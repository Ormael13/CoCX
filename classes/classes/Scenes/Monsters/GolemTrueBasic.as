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
	
	public class GolemTrueBasic extends Monster
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
		
		public function overhandSmash():void {
			outputText("Raising its fist high overhead, the golem swiftly brings it down in a punishing strike!");
			
			var damage:Number = 100 + int((str + weaponAttack) - rand(player.tou) - player.armorDef);
			if (damage <= 0 || rand(100) < 25 || player.getEvasionRoll()) outputText(" You're able to sidestep it just in time.");
			else
			{
				outputText(" The concussive strike impacts you with bonecrushing force. ");
				damage = player.takeDamage(damage, true);
			}
		}
		
		override protected function performCombatAction():void
		{
			var choice:Number = rand(6);
			if (choice < 3) eAttack();
			if (choice == 3 || choice == 4) backhand();
			if (choice == 5) overhandSmash();
			combatRoundOver();
		}
		
		public function GolemTrueBasic() 
		{
			this.a = "the ";
			this.short = "basic true golem";
			this.imageName = "basic true golem";
			this.long = "You're currently fighting basic true golem. It's seven feet tall without any sexual characteristics, it stone body lacking any cracks dummy ones possesed and using it bare stone fists to smash enemies.";
			this.plural = false;
			initStrTouSpeInte(150, 120, 90, 10);
			initLibSensCor(10, 10, 50);
			this.lustVuln = 0;
			this.tallness = 84;
			this.createBreastRow(0, 1);
			initGenderless();
			this.drop = new ChainedDrop()
					.add(useables.GOLCORE, 1/4);
			this.level = 33;
			this.bonusHP = 350;
			this.additionalXP = 350;
			this.weaponName = "stone fists";
			this.weaponVerb = "smash";
			this.weaponAttack = 40 + (9 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
			this.armorName = "stone";
			this.armorDef = 40 + (5 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
			this.createPerk(PerkLib.RefinedBodyI, 0, 0, 0, 0);
			this.createPerk(PerkLib.TankI, 0, 0, 0, 0);
			this.str += 45 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.tou += 36 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.spe += 27 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.inte += 3 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];			
			this.lib += 3 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.newgamebonusHP = 4560;
			checkMonster();
		}
		
	}

}