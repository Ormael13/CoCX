/**
 * ...
 * @author Liadri
 */
package classes.Scenes.Areas.GlacialRift 
{
	import classes.*;
	import classes.GlobalFlags.*;
	import classes.Scenes.Areas.Forest.Alraune;
	import classes.internals.ChainedDrop;
	
	public class SnowLily extends Alraune
	{
		
		public function SnowLily() 
		{
			super();
			this.short = "snow lily alraune";
			this.imageName = "snow lily alraune";
			this.skinTone = "light blue";
			this.hairColor = "white";
			initStrTouSpeInte(10, 250, 10, 100);
			initLibSensCor(200, 50, 0);
			this.armorDef = 90 + (10 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
			this.bonusHP = 200;
			this.level = 40;
			this.gems = rand(25) + 15;
			this.drop = new ChainedDrop().add(consumables.MARAFRU, 1 / 6)
				//	.add(consumables.W__BOOK, 1 / 4)
				//	.add(consumables.BEEHONY, 1 / 2)
				//	.elseDrop(useables.B_CHITN);
			this.removePerk(PerkLib.FireVulnerability);
			this.createPerk(PerkLib.IceNature, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyPlantType, 0, 0, 0, 0);
			this.str += 3 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.tou += 75 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.spe += 3 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.inte += 30 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];			
			this.lib += 60 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.newgamebonusHP = 4050;//x50
			checkMonster();
		}
		
	}

}