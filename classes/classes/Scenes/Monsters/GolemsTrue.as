/**
 * ...
 * @author Ormael
 */
package classes.Scenes.Monsters 
{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.Scenes.SceneLib;
	
	public class GolemsTrue extends AbstractGolem
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
		
		public function overhandSmash():void {
			outputText("Raising their fists high overhead, the golems swiftly brings them down in a punishing strike!");
			
			var damage:Number = 100 + int(((str + weaponAttack) * 5) - rand(player.tou) - player.armorDef);
			if (damage <= 0 || rand(100) < 25 || player.getEvasionRoll()) outputText(" You're able to sidestep it just in time.");
			else
			{
				if (hasStatusEffect(StatusEffects.Provoke)) damage = Math.round(damage * statusEffectv2(StatusEffects.Provoke));
				outputText(" The concussive strikes impacts you with a bonecrushing force. ");
				damage = player.takePhysDamage(damage, true);
			}
		}
		
		override protected function performCombatAction():void
		{
			if ((this.lust100 >= 85 && rand(2) == 0) || this.lust100 < 85) {
				if (hasStatusEffect(StatusEffects.Provoke)) {
					var choiceP:Number = rand(3);
					if (choiceP == 0) eAttack();
					if (choiceP == 1) backhand();
					if (choiceP == 2) overhandSmash();
				}
				else {
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
				}
			}
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			if (player.hasStatusEffect(StatusEffects.SoulArena)) SceneLib.combat.finishCombat();
			else SceneLib.campMakeWinions.postFightGolemOptions4();
		}
		
		public function GolemsTrue() 
		{
			super(true);
			if (flags[kFLAGS.GOLEM_ENEMY_TYPE] == 9) {
				this.short = "basic true golems";
				this.imageName = "basic true golems";
				this.long = "You're currently fighting basic true golems. They're all around seven feet tall without any sexual characteristics, their stone body covered in cracks and using bare stone fists to smash enemies.";
				initStrTouSpeInte(410, 400, 220, 10);
				initWisLibSensCor(10, 10, 10, 0);
				this.tallness = 84;
				this.level = 51;
				this.bonusHP = 400;
				this.bonusLust = 71;
				this.additionalXP = 510;
				this.weaponAttack = 70;
				this.armorDef = 175;
				this.armorMDef = 70;
			}
			if (flags[kFLAGS.GOLEM_ENEMY_TYPE] == 11) {
				this.short = "improved true golems";
				this.imageName = "improved true golems";
				this.long = "You're currently fighting improved true golems. They're all around seven and half feet tall without any sexual characteristics, their stone body covered in cracks and using bare stone fists to smash enemies.";
				initStrTouSpeInte(490, 480, 260, 10);
				initWisLibSensCor(10, 10, 10, 0);
				this.tallness = 90;
				this.level = 60;
				this.bonusHP = 600;
				this.bonusLust = 80;
				this.additionalXP = 600;
				this.weaponAttack = 90;
				this.armorDef = 225;
				this.armorMDef = 90;
			}
			if (flags[kFLAGS.GOLEM_ENEMY_TYPE] == 13) {
				this.short = "advanced true golems";
				this.imageName = "advanced true golems";
				this.long = "You're currently fighting advanced true golems. They're all around eight feet tall without any sexual characteristics, their stone body covered in cracks and using bare stone fists to smash enemies.";
				this.plural = true;
				initStrTouSpeInte(570, 560, 300, 10);
				initWisLibSensCor(10, 10, 10, 0);
				this.tallness = 96;
				this.level = 69;
				this.bonusHP = 800;
				this.bonusLust = 89;
				this.additionalXP = 690;
				this.weaponAttack = 110;
				this.armorDef = 275;
				this.armorMDef = 110;
			}
			this.a = "the ";
			this.drop = NO_DROP;
			this.weaponName = "stone fists";
			this.weaponVerb = "smash";
			this.armorName = "stone";
			this.createPerk(PerkLib.RefinedBodyI, 0, 0, 0, 0);
			this.createPerk(PerkLib.TankI, 0, 0, 0, 0);
			this.createPerk(PerkLib.CheetahI, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyGroupType, 0, 0, 0, 0);
			checkMonster();
		}
		
	}

}