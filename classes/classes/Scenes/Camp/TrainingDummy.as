/**
 * ...
 * @author Ormael
 */
package classes.Scenes.Camp 
{
	import classes.*;
	import classes.internals.*;
	import classes.GlobalFlags.kFLAGS;
	
	public class TrainingDummy extends Monster
	{
		
		public function TrainingDummy() 
		{
			if (flags[kFLAGS.CAMP_UPGRADES_SPARING_RING] == 4) {
				initStrTouSpeInte(10, 3500, 1000, 10);
				initWisLibSensCor(10, 500, 10, 50);
				this.bonusHP = 140000;
				this.bonusLust = 7000;
				this.armorDef = 7000;
				this.armorMDef = 7000;
				this.level = 60;
			}
			else if (flags[kFLAGS.CAMP_UPGRADES_SPARING_RING] == 3) {
				initStrTouSpeInte(10, 2000, 600, 10);
				initWisLibSensCor(10, 300, 10, 50);
				this.bonusHP = 80000;
				this.bonusLust = 4000;
				this.armorDef = 4000;
				this.armorMDef = 4000;
				this.level = 30;
			}
			else {
				initStrTouSpeInte(10, 500, 200, 10);
				initWisLibSensCor(10, 100, 10, 50);
				this.bonusHP = 20000;
				this.bonusLust = 1000;
				this.armorDef = 1000;
				this.armorMDef = 1000;
				this.level = 0;
			}
			this.a = "the ";
			this.short = "training dummy";
			this.imageName = "trainingdummy";
			this.long = "You're currently facing training dummy. Can't harm a fly (too much) but still can take a beating before it would fall apart....";
			this.plural = false;
			this.lustVuln = 0;
			this.tallness = 144;
			this.createBreastRow(0, 1);
			initGenderless();
			this.drop = NO_DROP;
			this.weaponName = "dummy stick";
			this.weaponVerb = "smash";
			this.weaponAttack = 1;
			this.armorName = "dummy stick";
			this.createPerk(PerkLib.TankI, 0, 0, 0, 0);
			this.createPerk(PerkLib.CheetahI, 0, 0, 0, 0);
			this.createPerk(PerkLib.NoExpGained, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyConstructType, 0, 0, 0, 0);
			this.createPerk(PerkLib.AlwaysSuccesfullRunaway, 0, 0, 0, 0);
			if (flags[kFLAGS.CAMP_UPGRADES_SPARING_RING] >= 3) {
				this.createPerk(PerkLib.EpicToughness, 0, 0, 0, 0);
				this.createPerk(PerkLib.EpicSpeed, 0, 0, 0, 0);
				this.createPerk(PerkLib.EpicLibido, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.CAMP_UPGRADES_SPARING_RING] >= 4) {
				this.createPerk(PerkLib.LegendaryToughness, 0, 0, 0, 0);
				this.createPerk(PerkLib.LegendarySpeed, 0, 0, 0, 0);
				this.createPerk(PerkLib.LegendaryLibido, 0, 0, 0, 0);
			}
			checkMonster();
		}
		
	}

}