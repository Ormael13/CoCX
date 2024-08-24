/**
 * ...
 * @author Ormael
 */
package classes.Scenes.Areas.Forest 
{
import classes.*;
import classes.GlobalFlags.*;
import classes.internals.ChainedDrop;
import classes.Scenes.SceneLib;
import classes.Scenes.Areas.Forest.BeeGirl;

	public class BeeGirlHuntress extends BeeGirl {
		
		override public function won(hpVictory:Boolean,pcCameWorms:Boolean):void
		{
			SceneLib.dungeons.riverdungeon.defeatedByStingerWomen();
		}
		
		public function BeeGirlHuntress() 
		{
			super();
			if (player.hasStatusEffect(StatusEffects.RiverDungeonA)) {
				this.short = "mist bee-girl huntress";
				this.long = "A mist bee-girl huntress buzzes around you, filling the air with intoxicatingly sweet scents and a buzz that gets inside your head.  She has a humanoid face with small antennae, black chitin on her arms and legs that looks like shiny gloves and boots, sizable breasts, and a swollen abdomen tipped with a gleaming stinger.  Her body covers nearly not visible network of faint purple vein-like lines.";
				initStrTouSpeInte(280, 480, 420, 260);
				initWisLibSensCor(260, 420, 300, 0);
				this.weaponAttack = 40;
				this.armorDef = 375;
				this.armorMDef = 150;
				this.bonusHP = 1000;
				this.bonusLust = 780;
				this.level = 60;
				this.gems = rand(25) + 20;
				this.createPerk(PerkLib.EnemyEliteType, 0, 0, 0, 0);
				this.drop = new ChainedDrop().add(consumables.W__BOOK, 1 / 6)
						.add(consumables.BEEHONY, 1 / 4)
						.add(useables.PCSHARD, 1 / 2)
						.elseDrop(useables.B_CHITN);
			}
			else {
				this.short = "bee-girl huntress";
				this.long = "A bee-girl huntress buzzes around you, filling the air with intoxicatingly sweet scents and a buzz that gets inside your head.  She has a humanoid face with small antennae, black chitin on her arms and legs that looks like shiny gloves and boots, sizable breasts, and a swollen abdomen tipped with a gleaming stinger.";
				initStrTouSpeInte(90, 170, 90, 50);
				initWisLibSensCor(50, 140, 115, 0);
				this.weaponAttack = 20;
				this.armorDef = 50;
				this.armorMDef = 20;
				this.bonusHP = 200;
				this.bonusLust = 274;//lib+sens+lvl
				this.level = 19;
				this.gems = rand(30) + 12;
				this.drop = new ChainedDrop().add(consumables.OVIELIX, 1 / 4)
						.add(consumables.W__BOOK, 1 / 3)
						.add(consumables.BEEHONY, 1 / 2)
						.elseDrop(useables.B_CHITN);
			}
			this.a = "a ";
			createBreastRow(Appearance.breastCupInverse("E"));
			checkMonster();
		}
		
	}

}