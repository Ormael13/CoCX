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
			if (flags[kFLAGS.CAMP_UPGRADES_SPARING_RING] == 5) {
				initStrTouSpeInte(8, 200, 14, 10);
				initWisLibSensCor(10, 14, 5, 50);
				this.bonusHP = 200000;
				this.bonusLust = 109;
				this.armorDef = 10000;
				this.armorMDef = 10000;
				this.level = 90;
			}
			else if (flags[kFLAGS.CAMP_UPGRADES_SPARING_RING] == 4) {
				initStrTouSpeInte(7, 150, 10, 10);
				initWisLibSensCor(10, 10, 5, 50);
				this.bonusHP = 140000;
				this.bonusLust = 75;
				this.armorDef = 7000;
				this.armorMDef = 7000;
				this.level = 60;
			}
			else if (flags[kFLAGS.CAMP_UPGRADES_SPARING_RING] == 3) {
				initStrTouSpeInte(6, 100, 6, 10);
				initWisLibSensCor(10, 6, 5, 50);
				this.bonusHP = 80000;
				this.bonusLust = 41;
				this.armorDef = 4000;
				this.armorMDef = 4000;
				this.level = 30;
			}
			else {
				initStrTouSpeInte(5, 50, 2, 10);
				initWisLibSensCor(10, 2, 5, 50);
				this.bonusHP = 20000;
				this.bonusLust = 7;
				this.armorDef = 1000;
				this.armorMDef = 1000;
				this.level = 0;
			}
			if (flags[kFLAGS.CAMP_UPGRADES_SPARING_RING] >= 5) {
				this.short = "training dummies";
				this.long = "You're currently facing training dummies. Maybe they can't harm a fly (too much) but still could take a beating before they would fall apart....";
			}
			else {
				this.short = "training dummy";
				this.long = "You're currently facing training dummy. Can't harm a fly (too much) but still can take a beating before it would fall apart....";
			}
			this.a = "the ";
			this.imageName = "trainingdummy";
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
			this.createPerk(PerkLib.NoDodges, 0, 0, 0, 0);
			this.createPerk(PerkLib.DieHardHP, 50, 0, 0, 0);
			this.createPerk(PerkLib.OverMaxHP, 50, 0, 0, 0);
			this.createPerk(PerkLib.NoExpGained, 0, 0, 0, 0);
			this.createPerk(PerkLib.OverMaxLust, 50, 0, 0, 0);
			this.createPerk(PerkLib.NoItemsGained, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyEliteType, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyConstructType, 0, 0, 0, 0);
			this.createPerk(PerkLib.AlwaysSuccesfullRunaway, 0, 0, 0, 0);
			if (flags[kFLAGS.CAMP_UPGRADES_SPARING_RING] >= 3) {
				this.createPerk(PerkLib.EpicToughness, 0, 0, 0, 0);
				this.createPerk(PerkLib.EpicSpeed, 0, 0, 0, 0);
				this.createPerk(PerkLib.EpicLibido, 0, 0, 0, 0);
				this.createPerk(PerkLib.EnemyChampionType, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.CAMP_UPGRADES_SPARING_RING] >= 4) {
				this.createPerk(PerkLib.LegendaryToughness, 0, 0, 0, 0);
				this.createPerk(PerkLib.LegendarySpeed, 0, 0, 0, 0);
				this.createPerk(PerkLib.LegendaryLibido, 0, 0, 0, 0);
				this.createPerk(PerkLib.EnemyBossType, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.CAMP_UPGRADES_SPARING_RING] >= 5) {
				this.createPerk(PerkLib.EnemyGroupType, 0, 0, 0, 0);
				this.createPerk(PerkLib.GoliathI, 0, 0, 0, 0);
				this.createPerk(PerkLib.EpicStrength, 0, 0, 0, 0);
			}
			checkMonster();
		}
		
	}

}