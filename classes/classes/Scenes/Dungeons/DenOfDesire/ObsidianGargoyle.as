/**
 * ...
 * @author Liadri
 */
package classes.Scenes.Dungeons.DenOfDesire 
{
	import classes.*;
	import classes.internals.*;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.GlobalFlags.kFLAGS;
	import classes.Scenes.Monsters.AbstractGargoyle;
	
	public class ObsidianGargoyle extends AbstractGargoyle
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
		/*
		override public function defeated(hpVictory:Boolean):void
		{
			game.dungeons.deepcave.impGangVICTORY();
		}
		
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			game.dungeons.deepcave.loseToImpMob();
		}
		*/
		public function ObsidianGargoyle() 
		{
			this.a = "the ";
			this.short = "Obsidian gargoyle";
			this.imageName = "obsidian gargoyle";
			this.long = "This gargoyle looks like a vile and corrupted version of the other gargoyle you met. Clearly created using a modified ritual, the face of the guardian is half lost in an expression of constant mind breaking pleasure, its eyes only focusing long enough on you that you can figure just what obscene things it plans to do with your body. Down between its legs, a nightmarish 18 inch rock hard cock throbs constantly and the slit right under it drips constantly, oozing jet black corrupted fluids.";
			this.createCock(18,3,CockTypesEnum.UNDEFINED);
			this.balls = 2;
			this.ballSize = 1;
			createBreastRow(0);
			this.tallness = 120;
			initStrTouSpeInte(150, 120, 90, 10);
			initLibSensCor(10, 10, 50);
			this.tallness = 120;
			this.drop = new ChainedDrop()
					.add(useables.GOLCORE, 1/4);
			this.level = 24;
			this.bonusHP = 500;
			this.additionalXP = 500;
			this.lustVuln = 0;
			this.weaponName = "stone claws";
			this.weaponVerb = "claw-slash";
			this.weaponAttack = 75 + (16 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
			this.armorName = "stone";
			this.armorDef = 75 + (8 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
			this.createPerk(PerkLib.Resolute, 0, 0, 0, 0);
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