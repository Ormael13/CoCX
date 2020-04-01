/**
 * ...
 * @author Ormael
 */
package classes.Scenes.Monsters 
{
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.Places.HeXinDao;
import classes.CoC;
import classes.internals.*;
import classes.Scenes.Camp.CampMakeWinions;
import classes.Scenes.SceneLib;

public class GolemsDummy extends AbstractGolem
	{
		public var golems:HeXinDao = new HeXinDao();
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
			if (player.hasStatusEffect(StatusEffects.SoulArenaGaunlet)) golems.gaunletchallange1fight2();
			else {
				if (player.hasStatusEffect(StatusEffects.SoulArena)) SceneLib.combat.finishCombat();
				else campMake.postFightGolemOptions2();
			}
		}
		
		public function GolemsDummy() 
		{
			super(true);
			this.a = "the ";
			this.short = "dummy golems";
			this.imageName = "dummy golems";
			this.long = "You're currently fighting dummy golems. They're all around six feet tall without any sexual characteristics, their stone body covered in cracks and using bare stone fists to smash enemies.";
			initStrTouSpeInte(20, 20, 10, 10);
			initWisLibSensCor(10, 10, 10, 50);
			this.tallness = 72;
			this.drop = NO_DROP;
			this.level = 6;
			this.bonusHP = 50;
			this.additionalXP = 50;
			this.weaponName = "stone fists";
			this.weaponVerb = "smash";
			this.weaponAttack = 10;
			this.armorName = "cracked stone";
			this.armorDef = 10;
			this.armorMDef = 2;
			this.createPerk(PerkLib.RefinedBodyI, 0, 0, 0, 0);
			this.createPerk(PerkLib.TankI, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyGroupType, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyConstructType, 0, 0, 0, 0);
			checkMonster();
		}
		
	}

}