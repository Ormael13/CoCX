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

	public class WaspAssassin extends WaspGirl {
		
		override protected function performCombatAction():void
		{
			var choice:Number = rand(5);
			if (choice == 0) waspStingAttack();
			if (choice == 1) waspSpearAttack();
			if (choice == 2) eAttack();//special dla niej tylko
			if (choice >= 3) eAttack();
		}
		
		public function WaspAssassin() 
		{
			super();
			this.a = "an ";
			this.short = "wasp assassin";
			this.long = "An wasp assassin buzzes around you, filling the air with intoxicatingly sweet scents and a buzz that gets inside your head.  She has a humanoid face with small antennae, black chitin on her arms and legs that looks like shiny gloves and boots, sizable breasts, and a swollen abdomen tipped with a gleaming stinger.";
			createBreastRow(Appearance.breastCupInverse("E_BIG"));
			initStrTouSpeInte(110, 188, 200, 100);
			initWisLibSensCor(100, 129, 105, 0);
			this.weaponAttack = 53;
			this.armorDef = 49;
			this.armorMDef = 26;
			this.bonusHP = 400;
			this.level = 63;
			this.gems = rand(42) + 28;
			this.drop = new ChainedDrop().add(consumables.OVIELIX, 1 / 4)
					.add(consumables.W__BOOK, 1 / 3)
					.add(consumables.BEEHONY, 1 / 2)
					.elseDrop(useables.B_CHITN);
			checkMonster();
		}
		
	}

}