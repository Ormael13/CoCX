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
	import classes.Scenes.Camp.CampMakeWinions;
	import classes.Scenes.SceneLib;
	
	public class GolemsDummySuperior extends AbstractGolem
	{
		public var campMake:CampMakeWinions = new CampMakeWinions();
		
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
		
		override public function defeated(hpVictory:Boolean):void
		{
			if (player.hasStatusEffect(StatusEffects.SoulArena)) SceneLib.combat.finishCombat();
			else campMake.postFightGolemOptions2();
		}
		
		public function GolemsDummySuperior() 
		{
			super(true);
			this.a = "the ";
			this.short = "superior dummy golems";
			this.imageName = "superior dummy golems";
			this.long = "You're currently fighting superior dummy golems. They're all around seven feet tall without any sexual characteristics, their stone body covered in cracks and using bare stone fists to smash enemies.";
			initStrTouSpeInte(80, 80, 40, 10);
			initWisLibSensCor(10, 10, 10, 50);
			this.tallness = 84;
			this.drop = NO_DROP;
			this.level = 24;
			this.bonusHP = 200;
			this.additionalXP = 200;
			this.weaponName = "stone fists";
			this.weaponVerb = "smash";
			this.weaponAttack = 25;
			this.armorName = "cracked stone";
			this.armorDef = 25;
			this.armorMDef = 5;
			this.createPerk(PerkLib.RefinedBodyI, 0, 0, 0, 0);
			this.createPerk(PerkLib.TankI, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyGroupType, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyConstructType, 0, 0, 0, 0);
			checkMonster();
		}
		
	}

}