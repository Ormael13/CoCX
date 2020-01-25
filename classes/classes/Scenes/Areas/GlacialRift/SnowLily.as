/**
 * ...
 * @author Liadri
 */
package classes.Scenes.Areas.GlacialRift 
{
import classes.*;
import classes.GlobalFlags.*;
import classes.Scenes.Areas.Forest.Alraune;
import classes.Scenes.Holidays;
import classes.Scenes.SceneLib;
import classes.internals.ChainedDrop;
import classes.display.SpriteDb;

public class SnowLily extends Alraune
	{
		override public function defeated(hpVictory:Boolean):void
		{
			SceneLib.forest.alrauneScene.alrauneDeepwoodsWon();
		}

		override public function won(hpVictory:Boolean,pcCameWorms:Boolean):void
		{
			SceneLib.forest.alrauneScene.alrauneDeepwoodsLost();
		}
		
		public function SnowLily() 
		{
			super();
			if (Holidays.isHalloween()) {
				this.short = "Jack-O-Raune";
				this.long = "You are fighting against a Jack-O-Raune, an intelligent plant with the torso of a woman and the lower body of a giant pumpkin with snaking tentacle vines. She seems really keen on raping you.";
				this.skinTone = "pale orange";
				this.hairColor = "dark green";
			}
			else {
				this.short = "snow lily alraune";
				this.long = "You are fighting against an Snow Lily, an intelligent plant with the torso of a woman and the lower body of a giant flower. She seems really keen on raping you.";
				this.skinTone = "light blue";
				this.hairColor = "white";
			}
			this.imageName = "snow lily alraune";
			initStrTouSpeInte(10, 250, 10, 100);
			initWisLibSensCor(100, 200, 50, 0);
			this.armorDef = 90;
			this.armorMDef = 9;
			this.bonusHP = 200;
			this.level = 40;
			this.gems = rand(25) + 15;
			this.drop = new ChainedDrop().add(consumables.MARAFRU, 1 / 6);
				//	.add(consumables.W__BOOK, 1 / 4)
				//	.add(consumables.BEEHONY, 1 / 2)
				//	.elseDrop(useables.B_CHITN);
			this.removePerk(PerkLib.FireVulnerability);
			this.createPerk(PerkLib.IceNature, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyPlantType, 0, 0, 0, 0);
			checkMonster();
		}
		
	}

}