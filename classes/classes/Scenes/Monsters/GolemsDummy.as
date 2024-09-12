/**
 * ...
 * @author Ormael
 */
package classes.Scenes.Monsters 
{
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.SceneLib;

public class GolemsDummy extends AbstractGolem
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
				if (hasStatusEffect(StatusEffects.Provoke)) {
					var choiceP:Number = rand(4);
					if (choiceP < 2) eAttack();
					if (choiceP > 1) backhand();
				}
				else {
					if (this.HPRatio() < 0.75) {
						var choice:Number = rand(4);
						if (choice < 3) eAttack();
						if (choice == 3) backhand();
					}
					else eAttack();
				}
			}
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			if (flags[kFLAGS.GOLEM_ENEMY_TYPE] == 1) {
				if (player.hasStatusEffect(StatusEffects.SoulArenaGaunlet)) SceneLib.hexindao.gaunletchallange1fight2();
				else {
					if (player.hasStatusEffect(StatusEffects.SoulArena)) SceneLib.combat.finishCombat();
					else SceneLib.campMakeWinions.postFightGolemOptions2();
				}
			}
			else {
				if (player.hasStatusEffect(StatusEffects.SoulArena)) SceneLib.combat.finishCombat();
				else SceneLib.campMakeWinions.postFightGolemOptions2();
			}
		}
		
		public function GolemsDummy() 
		{
			super(true);
			if (flags[kFLAGS.GOLEM_ENEMY_TYPE] == 1) {
				this.short = "dummy golems";
				this.imageName = "dummy golems";
				this.long = "You're currently fighting dummy golems. They're all around six feet tall without any sexual characteristics, their stone body covered in cracks and using bare stone fists to smash enemies.";
				initStrTouSpeInte(100, 100, 50, 10);
				initWisLibSensCor(10, 10, 10, 0);
				this.tallness = 72;
				this.level = 15;
				this.bonusHP = 50;
				this.bonusLust = 35;
				this.additionalXP = 150;
				this.weaponAttack = 20;
				this.armorDef = 50;
				this.armorMDef = 20;
			}
			if (flags[kFLAGS.GOLEM_ENEMY_TYPE] == 3) {
				this.short = "improved dummy golems";
				this.imageName = "improved dummy golems";
				this.long = "You're currently fighting improved dummy golems. They're all around six and half feet tall without any sexual characteristics, their stone body covered in cracks and using bare stone fists to smash enemies.";
				initStrTouSpeInte(180, 180, 90, 10);
				initWisLibSensCor(10, 10, 10, 0);
				this.tallness = 78;
				this.level = 24;
				this.bonusHP = 100;
				this.bonusLust = 44;
				this.additionalXP = 240;
				this.weaponAttack = 30;
				this.armorDef = 75;
				this.armorMDef = 30;
			}
			if (flags[kFLAGS.GOLEM_ENEMY_TYPE] == 5) {
				this.short = "advanced dummy golems";
				this.imageName = "advanced dummy golems";
				this.long = "You're currently fighting advanced dummy golems. They're all around seven feet tall without any sexual characteristics, their stone body covered in cracks and using bare stone fists to smash enemies.";
				initStrTouSpeInte(260, 260, 130, 10);
				initWisLibSensCor(10, 10, 10, 0);
				this.tallness = 84;
				this.level = 33;
				this.bonusHP = 150;
				this.bonusLust = 53;
				this.additionalXP = 330;
				this.weaponAttack = 40;
				this.armorDef = 100;
				this.armorMDef = 40;
			}
			if (flags[kFLAGS.GOLEM_ENEMY_TYPE] == 7) {
				this.short = "superior dummy golems";
				this.imageName = "superior dummy golems";
				this.long = "You're currently fighting superior dummy golems. They're all around seven feet tall without any sexual characteristics, their stone body covered in cracks and using bare stone fists to smash enemies.";
				initStrTouSpeInte(340, 340, 170, 10);
				initWisLibSensCor(10, 10, 10, 0);
				this.tallness = 84;
				this.level = 42;
				this.bonusHP = 200;
				this.bonusLust = 62;
				this.additionalXP = 420;
				this.weaponAttack = 50;
				this.armorDef = 125;
				this.armorMDef = 50;
			}
			this.a = "the ";
			this.drop = NO_DROP;
			this.weaponName = "stone fists";
			this.weaponVerb = "smash";
			this.armorName = "cracked stone";
			this.createPerk(PerkLib.RefinedBodyI, 0, 0, 0, 0);
			this.createPerk(PerkLib.TankI, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyGroupType, 0, 0, 0, 0);
			checkMonster();
		}
		
	}

}