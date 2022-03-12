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
				initStrTouSpeInte(10, 1500, 600, 10);
				initWisLibSensCor(10, 300, 10, 50);
				this.bonusHP = 50000;
				this.bonusLust = 500;
				this.armorDef = 5000;
				this.armorMDef = 5000;
				this.level = 60;
			}
			else if (flags[kFLAGS.CAMP_UPGRADES_SPARING_RING] == 3) {
				initStrTouSpeInte(10, 1000, 400, 10);
				initWisLibSensCor(10, 200, 10, 50);
				this.bonusHP = 30000;
				this.bonusLust = 250;
				this.armorDef = 3000;
				this.armorMDef = 3000;
				this.level = 30;
			}
			else {
				initStrTouSpeInte(10, 500, 200, 10);
				initWisLibSensCor(10, 100, 10, 50);
				this.bonusHP = 10000;
				this.bonusLust = 100;
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
				
			}
			if (flags[kFLAGS.CAMP_UPGRADES_SPARING_RING] >= 4) {
				
			}
			checkMonster();
		}
		
	}

}