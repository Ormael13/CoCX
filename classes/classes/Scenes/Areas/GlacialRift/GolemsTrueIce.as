/**
 * ...
 * @author Ormael
 */
package classes.Scenes.Areas.GlacialRift 
{
	import classes.*;
	import classes.internals.*;
	import classes.CoC;
	import classes.GlobalFlags.kFLAGS;
	import classes.Scenes.Camp.CampMakeWinions;
	
	public class GolemsTrueIce extends Monster
	{
		public var campMake:CampMakeWinions = new CampMakeWinions();
		
		public function backhand():void {
			outputText("The golems visage twists into a grimace of irritation, and few of them swings their hands at you in a vicious backhand.");
			var damage:Number = int (((str + weaponAttack) * 5) - rand(player.tou) - player.armorDef);
			if (player.findPerk(PerkLib.FromTheFrozenWaste) >= 0 || player.findPerk(PerkLib.ColdAffinity) >= 0) damage *= 0.1;
			if (player.findPerk(PerkLib.FireAffinity) >= 0) damage *= 3;
			damage = Math.round(damage);
			//Dodge
			if (damage <= 0 || (player.getEvasionRoll())) outputText(" You slide underneath the surprise swings!");
			else
			{
				outputText(" They hits you square in the chest from a few different angles. ");
				damage = player.takePhysDamage(damage, true);
			}
		}
		
		public function overhandSmash():void {
			outputText("Raising their fists high overhead, the golems swiftly brings them down in a punishing strike!");
			
			var damage:Number = 100 + int(((str + weaponAttack) * 5) - rand(player.tou) - player.armorDef);
			if (player.findPerk(PerkLib.FromTheFrozenWaste) >= 0 || player.findPerk(PerkLib.ColdAffinity) >= 0) damage *= 0.1;
			if (player.findPerk(PerkLib.FireAffinity) >= 0) damage *= 3;
			damage = Math.round(damage);
			if (damage <= 0 || rand(100) < 25 || player.getEvasionRoll()) outputText(" You're able to sidestep it just in time.");
			else
			{
				outputText(" The concussive strikes impacts you with a bonecrushing force. ");
				damage = player.takePhysDamage(damage, true);
			}
		}
		
		override protected function performCombatAction():void
		{
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
		
		override public function defeated(hpVictory:Boolean):void
		{
			campMake.postFightGolemOptions4();
		}
		
		public function GolemsTrueIce() 
		{
			this.a = "the ";
			this.short = "true ice golems";
			this.imageName = "true ice golems";
			this.long = "You're currently fighting true ice golems. They're all around seven feet tall without any sexual characteristics, their body covered in ice and using bare fists to smash enemies.";
			this.plural = true;
			initStrTouSpeInte(175, 135, 90, 10);
			initWisLibSensCor(10, 10, 10, 50);
			this.lustVuln = 0;
			this.tallness = 84;
			this.drop = NO_DROP;
			this.createBreastRow(0, 1);
			initGenderless();
			this.level = 43;
			this.bonusHP = 400;
			this.additionalXP = 400;
			this.weaponName = "fists";
			this.weaponVerb = "smash";
			this.weaponAttack = 45;
			this.armorName = "ice armor";
			this.armorDef = 45;
			this.armorMDef = 45;
			this.createPerk(PerkLib.RefinedBodyI, 0, 0, 0, 0);
			this.createPerk(PerkLib.TankI, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyGroupType, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyConstructType, 0, 0, 0, 0);
			this.createPerk(PerkLib.FireVulnerability, 0, 0, 0, 0);
			checkMonster();
		}
		
	}

}