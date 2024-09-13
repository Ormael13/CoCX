/**
 * ...
 * @author Ormael
 */
package classes.Scenes.Dungeons.HiddenCave 
{
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.SceneLib;
import classes.internals.*;

public class GuardianGolems extends Monster
	{
		public function backhand():void {
			outputText("The golems visage twists into a grimace of irritation, and few of them swings their hands at you in a vicious backhand.");
			var damage:Number = int (((str + weaponAttack) * 5) - rand(player.tou) - player.armorDef);
			//Dodge
			if (damage <= 0 || (player.getEvasionRoll())) outputText(" You slide underneath the surprise swings!");
			else
			{
				if (hasStatusEffect(StatusEffects.Provoke)) damage = Math.round(damage * statusEffectv2(StatusEffects.Provoke));
				outputText(" They hits you square in the chest from a few different angles. ");
				damage = player.takePhysDamage(damage, true);
			}
		}
		
		override protected function performCombatAction():void
		{
			if ((this.lust100 >= 85 && rand(2) == 0) || this.lust100 < 85) {
				var choice:Number = rand(3);
				if (choice < 2) eAttack();
				if (choice == 2) backhand();
			}
		}
		
	//	override public function defeated(hpVictory:Boolean):void
	//	{
	//		game.dungeons.hiddencave.cumWitchDefeated();
	//	}
		
		override public function won(hpVictory:Boolean,pcCameWorms:Boolean):void
		{
			SceneLib.dungeons.hiddencave.defeatedByGuardianGolems();
		}
		
		public function GuardianGolems() 
		{
			this.a = "the ";
			this.short = "guardian golems";
			this.imageName = "guardian golems";
			this.long = "You're currently fighting guardian golems. They're all around six feet tall without any sexual characteristics, their stone body covered in cracks and using bare stone fists to smash enemies.";
			this.plural = true;
			this.lustVuln = 0.01;
			this.createBreastRow(0, 1);
			initGenderless();
			initStrTouSpeInte(20, 25, 20, 10);
			initWisLibSensCor(10, 10, 10, 0);
			this.tallness = 72;
			this.drop = new ChainedDrop()
					.add(useables.GOLCORE, 1);
			this.level = 7;
			this.bonusHP = 75;
			this.weaponName = "stone fists";
			this.weaponVerb = "smash";
			this.weaponAttack = 12;
			this.armorName = "cracked stone";
			this.armorDef = 12;
			this.armorMDef = 12;
			this.createPerk(PerkLib.Resolute, 0, 0, 0, 0);
			this.createPerk(PerkLib.RefinedBodyI, 0, 0, 0, 0);
			this.createPerk(PerkLib.TankI, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyGroupType, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyConstructType, 0, 0, 0, 0);
			checkMonster();
		}
		
	}

}