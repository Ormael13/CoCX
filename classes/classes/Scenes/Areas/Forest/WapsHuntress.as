/**
 * ...
 * @author Ormael
 */
package classes.Scenes.Areas.Forest 
{
import classes.*;
import classes.GlobalFlags.*;
import classes.internals.ChainedDrop;
import classes.Scenes.Areas.Forest.WaspGirl;

	public class WapsHuntress extends WaspGirl {
		
		override protected function performCombatAction():void
		{
			var choice:Number = rand(5);
			if (choice == 0) waspStingAttack();
			if (choice == 1) waspSpearAttack();
			if (choice == 2) eAttack();//special dla niej tylko
			if (choice >= 3) eAttack();
		}
		
		public function WapsHuntress() 
		{
			super();
			this.a = "an ";
			this.short = "wasp huntress";
			this.long = "An wasp huntress buzzes around you, filling the air with intoxicatingly sweet scents and a buzz that gets inside your head.  She has a humanoid face with small antennae, black chitin on her arms and legs that looks like shiny gloves and boots, sizable breasts, and a swollen abdomen tipped with a gleaming stinger.";
			createBreastRow(Appearance.breastCupInverse("DD_BIG"));
			initStrTouSpeInte(88, 137, 88, 63);
			initWisLibSensCor(63, 119, 97, 0);
			this.weaponAttack = 31;
			this.armorDef = 42;
			this.armorMDef = 21;
			this.bonusHP = 300;
			this.level = 48;
			this.gems = rand(38) + 24;
			this.drop = new ChainedDrop().add(consumables.OVIELIX, 1 / 4)
					.add(consumables.W__BOOK, 1 / 3)
					.add(consumables.BEEHONY, 1 / 2)
					.elseDrop(useables.B_CHITN);
			checkMonster();
		}
		
	}

}