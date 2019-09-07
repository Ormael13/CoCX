/**
 * ...
 * @author Ormael
 */
package classes.Scenes.Monsters 
{
	import classes.*;
	import classes.internals.*;
	import classes.CoC;
	import classes.GlobalFlags.kFLAGS;
	
	public class GolemsDummyAdvanced extends AbstractGolem
	{
		public function backhand():void {
			outputText("The golems visage twists into a grimace of irritation, and few of them swings their hands at you in a vicious backhand.");
			var damage:Number = int (((str + weaponAttack) * 5) - rand(player.tou) - player.armorDef);
			//Dodge
			if (damage <= 0 || (player.getEvasionRoll())) outputText(" You slide underneath the surprise swings!");
			else
			{
				outputText(" They hits you square in the chest from a few different angles. ");
				damage = player.takePhysDamage(damage, true);
			}
		}
		
		override protected function performCombatAction():void
		{
			if (this.HPRatio() < 0.75) {
				var choice:Number = rand(4);
				if (choice < 3) eAttack();
				if (choice == 3) backhand();
			}
			else eAttack();
		}
		
		public function GolemsDummyAdvanced() 
		{
			super(true);
			this.a = "the ";
			this.short = "advanced dummy golems";
			this.imageName = "advanced dummy golems";
			this.long = "You're currently fighting advanced dummy golems. They're all around seven feet tall without any sexual characteristics, their stone body covered in cracks and using bare stone fists to smash enemies.";
			initStrTouSpeInte(60, 60, 30, 10);
			initWisLibSensCor(10, 10, 10, 50);
			this.tallness = 84;
			this.drop = new ChainedDrop()
					.add(useables.GOLCORE, 1);
			this.level = 18;
			this.bonusHP = 150;
			this.additionalXP = 150;
			this.weaponName = "stone fists";
			this.weaponVerb = "smash";
			this.weaponAttack = 20;
			this.armorName = "cracked stone";
			this.armorDef = 20;
			this.armorMDef = 4;
			this.createPerk(PerkLib.RefinedBodyI, 0, 0, 0, 0);
			this.createPerk(PerkLib.TankI, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyGroupType, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyConstructType, 0, 0, 0, 0);
			checkMonster();
		}
		
	}

}