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
	
	public class GargoyleBasic extends AbstractGargoyle
	{
		override protected function performCombatAction():void
		{
			if (this.HPRatio() < 0.9) {
				var choice:Number = rand(6);
				if (choice < 3) eAttack();
				if (choice == 3) GargoyleStoneClawAttack();
				if (choice == 4) {
					if (hasStatusEffect(StatusEffects.AbilityCooldown1)) GargoyleStoneClawAttack();
					else GargoyleTailSlamAttack();
				}
				if (choice == 5) {
					if (hasStatusEffect(StatusEffects.AbilityCooldown2)) GargoyleStoneClawAttack();
					else GargoyleWingBuffetAttack();
				}
			}
			else eAttack();
			combatRoundOver();
		}
		
		public function GargoyleBasic() 
		{
			this.a = "the ";
			this.short = "basic gargoyle";
			this.imageName = "basic gargoyle";
			this.long = "You're currently fighting basic gargoyle. It's ten feet tall with masculine frame with bat wings and mace-like tail, but without any sexual characteristics. It stone body is without any cracks and he's using stone claws to slash enemies.";
			initStrTouSpeInte(150, 120, 90, 10);
			initLibSensCor(10, 10, 50);
			this.tallness = 120;
			this.drop = new ChainedDrop()
					.add(useables.GOLCORE, 1/4);
			this.level = 24;
			this.bonusHP = 500;
			this.additionalXP = 500;
			this.weaponName = "stone claws";
			this.weaponVerb = "claw-slash";
			this.weaponAttack = 75 + (16 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
			this.armorName = "stone";
			this.armorDef = 75 + (8 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
			this.createPerk(PerkLib.RefinedBodyI, 0, 0, 0, 0);
			this.createPerk(PerkLib.TankI, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyConstructType, 0, 0, 0, 0);
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