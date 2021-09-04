/**
 * ...
 * @author Liadri
 */
package classes.Scenes.Dungeons.BeeHive 
{
import classes.*;
import classes.BodyParts.Horns;
import classes.GlobalFlags.*;
import classes.Scenes.SceneLib;
import classes.internals.ChainedDrop;
import classes.Scenes.Dungeons.BeeHive;
import classes.Scenes.Dungeons.BeeHive.BeeGuards;

	public class CorruptBeeQueen extends BeeGuards {
		
		
		
		override public function defeated(hpVictory:Boolean):void
		{
			cleanupAfterCombat();
		}
		
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			beehive.defeatedByCorruptBeeQueen();
		}
		
		public function CorruptBeeQueen() 
		{
			super();
			this.a = "";
			this.short = "Corrupt bee queen";
			this.long = "The bee queen, now corrupted. She looks at you with depraved eyes, likely planning a very unsavory fate for you. She sports four horns and a massive 50-inch penis between her legs, constantly dripping precum.";
			createBreastRow(Appearance.breastCupInverse("G"));
			this.createCock(50,6,CockTypesEnum.DEMON);
			this.tallness = rand(14) + 108;
			initStrTouSpeInte(70, 220, 110, 75);
			initWisLibSensCor(75, 195, 155, 0);
			this.weaponAttack = 15;
			this.armorDef = 50;
			this.armorMDef = 20;
			this.bonusHP = 1500;
			this.bonusLust = 390;
			this.lustVuln = .4;
			this.level = 40;
			this.gems = rand(45) + 40;
			this.drop = new ChainedDrop().add(consumables.OVIELIX, 1 / 4)
					.add(consumables.W__BOOK, 1 / 3)
					.add(consumables.BEEHONY, 1 / 2)
					.elseDrop(useables.B_CHITN);
			this.createPerk(PerkLib.EnemyHugeType, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyTrueDemon, 0, 0, 0, 0);
			checkMonster();
		}
		
	}

}