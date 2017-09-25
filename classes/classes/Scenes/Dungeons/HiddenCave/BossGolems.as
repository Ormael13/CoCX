/**
 * ...
 * @author Ormael
 */
package classes.Scenes.Dungeons.HiddenCave 
{
	import classes.*;
	import classes.internals.*;
	import classes.Scenes.Monsters.AbstractGargoyle;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.GlobalFlags.kFLAGS;
	
	public class BossGolems extends AbstractGargoyle
	{
		override protected function performCombatAction():void
		{
			var choice:Number = rand(4);
			if (choice == 0) {
				eAttack();
				eAttack();
				eAttack();
			}
			if (choice == 1) {
				eAttack();
				eAttack();
				eAttack();
				eAttack();
			}
			if (choice == 2) {
				if (player.hasStatusEffect(StatusEffects.Stunned)) {
					eAttack();
					eAttack();
					eAttack();
					eAttack();
					eAttack();
				}
				else {
					eAttack();
					eAttack();
					GargoyleTailSlamAttack();
				}
			}
			if (choice == 3) {
				if (player.hasStatusEffect(StatusEffects.IzmaBleed)) {
					eAttack();
					eAttack();
					eAttack();
					eAttack();
					eAttack();
					eAttack();
				}
				else {
					eAttack();
					GargoyleTailCleaveAttack();
				}
			}
			combatRoundOver();
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			//game.dungeons.hiddencave.cumWitchDefeated();
			flags[kFLAGS.HIDDEN_CAVE_BOSSES] = 2;
			cleanupAfterCombat();
		}
		
		override public function won(hpVictory:Boolean,pcCameWorms:Boolean):void
		{
			game.dungeons.hiddencave.defeatedByBossGolems();
		}
		
		public function BossGolems() 
		{
			this.a = "the ";
			this.short = "guardian quasi-gargoyles";
			this.imageName = "guardian quasi-gargoyles";
			this.long = "You're currently fighting guardian quasi-gargoyles. They're all around six feet tall without any sexual characteristics, their stone body covered in cracks, with rudimental wins and fully formed mace or axe tails, using bare stone fists to smash intruders.";
			this.plural = true;
			this.lustVuln = 0;
			this.createBreastRow(0, 1);
			initGenderless();
			initStrTouSpeInte(30, 40, 30, 20);
			initLibSensCor(10, 10, 50);
			this.tallness = 72;
			this.drop = new ChainedDrop()
					.add(consumables.E_PEARL, 1);
			this.level = 9;
			this.bonusHP = 100;
			this.weaponName = "stone fists";
			this.weaponVerb = "smash";
			this.weaponAttack = 16 + (4 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
			this.armorName = "slight cracked stone";
			this.armorDef = 16 + (2 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
			this.createPerk(PerkLib.Resolute, 0, 0, 0, 0);
			this.createPerk(PerkLib.RefinedBodyI, 0, 0, 0, 0);
			this.createPerk(PerkLib.TankI, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyGroupType, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyConstructType, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyBossType, 0, 0, 0, 0);
			this.str += 6 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.tou += 8 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.spe += 6 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.inte += 4 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];			
			this.lib += 2 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.newgamebonusHP = 260;
			checkMonster();
		}
		
	}

}