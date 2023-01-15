/**
 * ...
 * @author Ormael
 */
package classes.Scenes.Explore 
{
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.Monsters.AbstractGargoyle;
import classes.Scenes.SceneLib;
import classes.internals.*;

public class ElementalGolems extends AbstractGargoyle
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
					GargoyleTailSlamAttack();
				}
			}
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			SceneLib.exploration.elementalGolemBeaten1();
		}
		
		public function ElementalGolems() 
		{
			this.a = "the ";
			this.short = "guardian quasi-gargoyle";
			this.imageName = "guardian quasi-gargoyle";
			this.long = "You're currently fighting guardian quasi-gargoyle. It's six feet tall without any sexual characteristics, it stone body covered in cracks, with rudimental wings and fully formed mace tail, using bare stone fists to smash you. In cracks at it shoulders there are large elemental shards.";
			this.plural = true;
			this.createBreastRow(0, 1);
			initGenderless();
			initStrTouSpeInte(30, 40, 30, 20);
			initWisLibSensCor(20, 10, 10, 50);
			this.tallness = 72;
			this.weaponName = "stone fists";
			this.weaponVerb = "smash";
			this.weaponAttack = 16;
			this.armorName = "slight cracked stone";
			this.armorDef = 16;
			this.armorMDef = 16;
			this.bonusHP = 100;
			this.lustVuln = 0;
			this.level = 9;
			this.drop = new ChainedDrop()
					.add(consumables.E3PEARL, 1);
			this.createPerk(PerkLib.RefinedBodyI, 0, 0, 0, 0);
			this.createPerk(PerkLib.TankI, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyBossType, 0, 0, 0, 0);
			checkMonster();
		}
	}
}