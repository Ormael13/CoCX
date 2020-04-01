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
	import classes.Scenes.Dungeons.RiverDungeon;
	import classes.Scenes.SceneLib;
	import classes.Scenes.Camp.CampMakeWinions;
	
	public class GolemDummyImproved extends AbstractGolem
	{
		public var floor1:RiverDungeon = new RiverDungeon();
		public var campMake:CampMakeWinions = new CampMakeWinions();
		
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
		
		override public function defeated(hpVictory:Boolean):void
		{
			if (player.hasStatusEffect(StatusEffects.RiverDungeonA)) {
				if (flags[kFLAGS.RIVER_DUNGEON_FLOORS_PROGRESS] == 1) flags[kFLAGS.RIVER_DUNGEON_FLOORS_PROGRESS] = 2;
				else flags[kFLAGS.RIVER_DUNGEON_FLOORS_PROGRESS] = 1;
				if (flags[kFLAGS.AETHER_SINISTER_EVO] == 0.5) SceneLib.dungeons.riverdungeon.takeAetherSister2();
				else SceneLib.dungeons.riverdungeon.takeAetherSister1();
			}
			else {
				if (player.hasStatusEffect(StatusEffects.SoulArena)) SceneLib.combat.finishCombat();
				else campMake.postFightGolemOptions1();
			}
		}
		
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if (player.hasStatusEffect(StatusEffects.RiverDungeonA)) floor1.defeatedByAetherGolem();
			else SceneLib.combat.cleanupAfterCombatImpl();
		}
		
		public function GolemDummyImproved() 
		{
			super(false);
			if (player.hasStatusEffect(StatusEffects.RiverDungeonA)) {
				this.a = "";
				this.short = "Aether Golem";
				if (flags[kFLAGS.AETHER_SINISTER_EVO] == 0.5) this.long = "You're currently fighting guardian of the first floor - Aether Golem. It's around six feet tall without any sexual characteristics, it stone body covered in cracks, some of them are filled with goo-like substance and wearing gaunlet on it left arm that it use to smash enemies.";
				else this.long = "You're currently fighting guardian of the first floor - Aether Golem. It's around six feet tall without any sexual characteristics, it stone body covered in cracks, some of them are filled with goo-like substance and wearing gaunlet on it right arm that it use to smash enemies.";
				initStrTouSpeInte(50, 50, 50, 20);
				initWisLibSensCor(20, 10, 10, 50);
				this.level = 11;
				this.bonusHP = 300;
				this.additionalXP = 300;
				this.weaponName = "stone fists";
				this.weaponAttack = 20;
				this.armorDef = 30;
				this.armorMDef = 9;
				this.createPerk(PerkLib.EnemyBossType, 0, 0, 0, 0);
			}
			else {
				this.a = "the ";
				this.short = "improved dummy golem";
				this.long = "You're currently fighting improved dummy golem. It's six and half feet tall without any sexual characteristics, it stone body covered in cracks and using it bare stone fists to smash enemies.";
				initStrTouSpeInte(40, 40, 20, 10);
				initWisLibSensCor(10, 10, 10, 50);
				this.level = 12;
				this.bonusHP = 100;
				this.additionalXP = 100;
				this.weaponName = "stone fists";
				this.weaponAttack = 15;
				this.armorDef = 15;
				this.armorMDef = 3;
			}
			this.imageName = "dummy golem";
			this.tallness = 78;
			this.weaponVerb = "smash";
			this.armorName = "cracked stone";
			this.drop = NO_DROP;
			this.createPerk(PerkLib.RefinedBodyI, 0, 0, 0, 0);
			this.createPerk(PerkLib.TankI, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyConstructType, 0, 0, 0, 0);
			checkMonster();
		}
		
	}

}