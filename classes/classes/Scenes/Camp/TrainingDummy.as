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
				initStrTouSpeInte(10, 300, 300, 10);
				initWisLibSensCor(10, 10, 10, 50);
				this.level = 60;
			}
			else if (flags[kFLAGS.CAMP_UPGRADES_SPARING_RING] == 3) {
				initStrTouSpeInte(10, 200, 200, 10);
				initWisLibSensCor(10, 10, 10, 50);
				this.level = 30;
			}
			else {
				initStrTouSpeInte(10, 100, 100, 10);
				initWisLibSensCor(10, 10, 10, 50);
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
			this.bonusLust = 20;
			this.weaponName = "dummy stick";
			this.weaponVerb = "smash";
			this.weaponAttack = 1;
			this.armorName = "dummy stick";
			this.armorDef = 1000;
			this.armorMDef = 1000;
			this.createPerk(PerkLib.TankI, 0, 0, 0, 0);
			this.createPerk(PerkLib.CheetahI, 0, 0, 0, 0);
			this.createPerk(PerkLib.NoExpGained, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyConstructType, 0, 0, 0, 0);
			this.createPerk(PerkLib.AlwaysSuccesfullRunaway, 0, 0, 0, 0);
			checkMonster();
		}
		
	}

}