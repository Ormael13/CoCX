/**
 * ...
 * @author Ormael
 */
package classes.Scenes.Areas.Forest 
{
import classes.*;
import classes.GlobalFlags.*;
import classes.internals.ChainedDrop;
import classes.Scenes.Areas.Forest.HornetGirl;

	public class HornetAssassin extends HornetGirl {
		
		override protected function performCombatAction():void
		{
			var choice:Number = rand(5);
			if (choice == 0) hornetStingAttack();
			if (choice == 1) hornetSpearAttack();
			if (choice == 2) eAttack();//special dla niej tylko
			if (choice >= 3) eAttack();
		}
		
		public function HornetAssassin() 
		{
			super();
			this.a = "a ";
			this.short = "hornet assassin";
			this.long = "A hornet assassin buzzes around you, filling the air with intoxicatingly sweet scents and a buzz that gets inside your head.  She has a humanoid face with small antennae, black chitin on her quad arms and legs that looks like shiny gloves and boots, sizable breasts, and a swollen abdomen tipped with a gleaming stinger.";
			createBreastRow(Appearance.breastCupInverse("FF"));
			initStrTouSpeInte(50, 100, 50, 35);
			initWisLibSensCor(35, 90, 75, 0);
			this.weaponAttack = 10;
			this.armorDef = 25;
			this.armorMDef = 10;
			this.bonusHP = 100;
			this.level = 16;
			this.gems = rand(30) + 12;
			this.drop = new ChainedDrop().add(consumables.OVIELIX, 1 / 4)
					.add(consumables.W__BOOK, 1 / 3)
					.add(consumables.BEEHONY, 1 / 2)
					.elseDrop(useables.B_CHITN);
			checkMonster();
		}
		
	}

}