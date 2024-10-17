/**
 * ...
 * @author Liadri
 */
package classes.Scenes.Areas.Ashlands
{
import classes.*;
import classes.GlobalFlags.*;
import classes.Scenes.Areas.Forest.Alraune;
import classes.Scenes.Holidays;
import classes.Scenes.SceneLib;
import classes.internals.ChainedDrop;
import classes.display.SpriteDb;

public class Cinderbloom extends Alraune
	{
		override public function defeated(hpVictory:Boolean):void
		{
			if (player.hasStatusEffect(StatusEffects.RiverDungeonA)) cleanupAfterCombat();
			else SceneLib.forest.alrauneScene.alrauneDeepwoodsWon();
		}

		override public function won(hpVictory:Boolean,pcCameWorms:Boolean):void
		{
			if (player.hasStatusEffect(StatusEffects.RiverDungeonA)) SceneLib.dungeons.riverdungeon.defeatedByPlantWomen();
			else SceneLib.forest.alrauneScene.alrauneDeepwoodsLost();
		}
		
		public function Cinderbloom()
		{
			super();
			if (player.hasStatusEffect(StatusEffects.RiverDungeonA)) {
				this.a = "a ";
				this.short = "mist cinderbloom alraune";
				this.long = "You are fighting against a Mist Cinderbloom, an intelligent plant with the torso of a woman and the lower body of a giant flower. Her whole body is covered in faint vein-like lines. She seems really keen on raping you.";
				this.bodyColor = "chocolate";
				this.hairColor = "blonde";
			}
			else if (Holidays.isHalloween()) {
				this.short = "Jack-O-Raune";
				this.long = "You are fighting against a Jack-O-Raune, an intelligent plant with the torso of a woman and the lower body of a giant pumpkin with snaking tentacle vines. She seems really keen on raping you.";
				this.bodyColor = "pale orange";
				this.hairColor = "dark green";
			}
			else {
				this.short = "cinderbloom alraune";
				this.long = "You are fighting against a Cinderbloom, an intelligent plant with the torso of a woman and the lower body of a giant flower. She seems really keen on raping you.";
				this.bodyColor = "chocolate";
				this.hairColor = "blonde";
			}
			if (player.hasStatusEffect(StatusEffects.RiverDungeonA)) {
				initStrTouSpeInte(36, 720, 36, 280);
				initWisLibSensCor(280, 480, 200, 10);
				this.armorDef = 600;
				this.armorMDef = 125;
				this.bonusHP = 1600;
				this.bonusLust = 748;
				this.level = 68;
				this.createPerk(PerkLib.EnemyEliteType, 0, 0, 0, 0);
				this.drop = new ChainedDrop().add(consumables.EMBER_F, 1 / 6)
						.add(consumables.MARAFRU, 1 / 4)
						.add(useables.PCSHARD, 1 / 2);
					//	.elseDrop(useables.B_CHITN);
			}
			else {
				initStrTouSpeInte(10, 250, 10, 100);
				initWisLibSensCor(100, 200, 50, 10);
				this.armorDef = 90;
				this.armorMDef = 9;
				this.bonusHP = 200;
				this.bonusLust = 290;
				this.level = 40;
				this.drop = new ChainedDrop().add(consumables.EMBER_F, 1 / 6)
						.add(consumables.MARAFRU, 1 / 4);
					//	.add(consumables.BEEHONY, 1 / 2)
					//	.elseDrop(useables.B_CHITN);
			}
			this.imageName = "cinderbloom alraune";
			this.gems = rand(25) + 15;
			this.removePerk(PerkLib.FireVulnerability);
			this.createPerk(PerkLib.IceVulnerability, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyPlantType, 0, 0, 0, 0);
			checkMonster();
		}
		
	}

}
