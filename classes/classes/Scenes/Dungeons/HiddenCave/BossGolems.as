/**
 * ...
 * @author Ormael
 */
package classes.Scenes.Dungeons.HiddenCave 
{
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.Monsters.AbstractGargoyle;
import classes.Scenes.SceneLib;
import classes.Scenes.Places.HeXinDao;
import classes.internals.*;

public class BossGolems extends AbstractGargoyle
	{
		public var golems:HeXinDao = new HeXinDao();
		
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
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			if (player.hasStatusEffect(StatusEffects.SoulArenaGaunlet)) golems.gaunletchallange2postfight();
			else {
				outputText("Your last attack cause the golems to crumble to rubbles on the ground. It seems the way is clear, better not linguer in the same spot for to long there is no telling when another may cross your path.\n\n");
				flags[kFLAGS.HIDDEN_CAVE_BOSSES] = 2;
				cleanupAfterCombat();
			}
		}
		
		override public function won(hpVictory:Boolean,pcCameWorms:Boolean):void
		{
			SceneLib.dungeons.hiddencave.defeatedByBossGolems();
		}
		
		public function BossGolems() 
		{
			if (player.hasStatusEffect(StatusEffects.SoulArenaGaunlet)) {
				this.long = "You're currently fighting guardian quasi-gargoyles. They're all around six feet tall without any sexual characteristics, their stone body covered in cracks, with rudimental wins and fully formed mace or axe tails, using bare stone fists to smash you.";
				initStrTouSpeInte(60, 80, 60, 30);
				initWisLibSensCor(30, 10, 10, 50);
				this.level = 15;
				this.bonusHP = 200;
				this.weaponAttack = 24;
				this.armorDef = 24;
			}
			else {
				this.long = "You're currently fighting guardian quasi-gargoyles. They're all around six feet tall without any sexual characteristics, their stone body covered in cracks, with rudimental wins and fully formed mace or axe tails, using bare stone fists to smash intruders.";
				initStrTouSpeInte(30, 40, 30, 20);
				initWisLibSensCor(20, 10, 10, 50);
				this.level = 9;
				this.bonusHP = 100;
				this.weaponAttack = 16;
				this.armorDef = 16;
			}
			this.a = "the ";
			this.short = "guardian quasi-gargoyles";
			this.imageName = "guardian quasi-gargoyles";
			this.plural = true;
			this.lustVuln = 0;
			this.createBreastRow(0, 1);
			initGenderless();
			this.tallness = 72;
			this.drop = new ChainedDrop()
					.add(consumables.E3PEARL, 1);
			this.weaponName = "stone fists";
			this.weaponVerb = "smash";
			this.armorName = "slight cracked stone";
			this.createPerk(PerkLib.Resolute, 0, 0, 0, 0);
			this.createPerk(PerkLib.RefinedBodyI, 0, 0, 0, 0);
			this.createPerk(PerkLib.TankI, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyGroupType, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyConstructType, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyBossType, 0, 0, 0, 0);
			checkMonster();
		}
		
	}

}