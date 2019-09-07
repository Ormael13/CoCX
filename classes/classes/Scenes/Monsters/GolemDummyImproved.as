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
	
	public class GolemDummyImproved extends AbstractGolem
	{
		public function backhand():void {
			outputText("The golem's visage twists into a grimace of irritation, and it swings its hand at you in a vicious backhand.");
			var damage:Number = int ((str + weaponAttack) - rand(player.tou) - player.armorDef);
			//Dodge
			if (damage <= 0 || (player.getEvasionRoll())) outputText(" You slide underneath the surprise swing!");
			else
			{
				outputText(" It hits you square in the chest. ");
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
		
		public function GolemDummyImproved() 
		{
			super(false);
			this.a = "the ";
			this.short = "improved dummy golem";
			this.imageName = "dummy golem";
			this.long = "You're currently fighting improved dummy golem. It's six and half feet tall without any sexual characteristics, it stone body covered in cracks and using it bare stone fists to smash enemies.";
			initStrTouSpeInte(40, 40, 20, 10);
			initWisLibSensCor(10, 10, 10, 50);
			this.tallness = 78;
			this.drop = new ChainedDrop()
					.add(useables.GOLCORE, 1/4);
			this.level = 12;
			this.bonusHP = 100;
			this.additionalXP = 100;
			this.weaponName = "stone fists";
			this.weaponVerb = "smash";
			this.weaponAttack = 15;
			this.armorName = "cracked stone";
			this.armorDef = 15;
			this.armorMDef = 3;
			this.createPerk(PerkLib.RefinedBodyI, 0, 0, 0, 0);
			this.createPerk(PerkLib.TankI, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyConstructType, 0, 0, 0, 0);
			checkMonster();
		}
		
	}

}