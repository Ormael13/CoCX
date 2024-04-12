/**
 * ...
 * @author Ormael
 */
package classes.Scenes.Areas.Forest 
{
import classes.*;
import classes.GlobalFlags.*;
import classes.internals.ChainedDrop;
import classes.Scenes.Areas.Forest.BeeGirl;

	public class BeeGirlHuntress extends BeeGirl {
		
		public function BeeGirlHuntress() 
		{
			super();
			if (player.hasStatusEffect(StatusEffects.RiverDungeonA)) {
				this.short = "mist bee-girl huntress";
				this.long = "A mist bee-girl huntress buzzes around you, filling the air with intoxicatingly sweet scents and a buzz that gets inside your head.  She has a humanoid face with small antennae, black chitin on her arms and legs that looks like shiny gloves and boots, sizable breasts, and a swollen abdomen tipped with a gleaming stinger.  Her body covers nearly not visible network of faint purple vein-like lines.";
				initStrTouSpeInte(140, 240, 210, 130);
				initWisLibSensCor(130, 210, 150, 0);
				this.weaponAttack = 20;
				this.armorDef = 75;
				this.armorMDef = 30;
				this.bonusHP = 500;
				this.bonusLust = 420;//lib+sens+lvl
				this.level = 60;
				this.gems = rand(30) + 12;
				this.drop = new ChainedDrop().add(consumables.W__BOOK, 1 / 6)
						.add(consumables.BEEHONY, 1 / 4)
						.add(useables.PCSHARD, 1 / 2)
						.elseDrop(useables.B_CHITN);
			}
			else {
				this.short = "bee-girl huntress";
				this.long = "A bee-girl huntress buzzes around you, filling the air with intoxicatingly sweet scents and a buzz that gets inside your head.  She has a humanoid face with small antennae, black chitin on her arms and legs that looks like shiny gloves and boots, sizable breasts, and a swollen abdomen tipped with a gleaming stinger.";
				initStrTouSpeInte(50, 100, 50, 35);
				initWisLibSensCor(35, 90, 75, 0);
				this.weaponAttack = 10;
				this.armorDef = 25;
				this.armorMDef = 10;
				this.bonusHP = 100;
				this.bonusLust = 181;//lib+sens+lvl
				this.level = 16;
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