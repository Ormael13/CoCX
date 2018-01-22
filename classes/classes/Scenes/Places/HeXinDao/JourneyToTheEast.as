/**
 * ...
 * @author Ormael and others
 */
package classes.Scenes.Places.HeXinDao 
{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.Scenes.SceneLib;
	
	public class JourneyToTheEast extends HeXinDaoAbstractContent
	{
		public function JourneyToTheEast() 
		{}
		
		public function enteringInn():void {
			clearOutput();
			outputText("You enter the town local Inn ‘Journey to the East’ and look around. ");
			reenteringInn2();
		}
		public function reenteringInn():void {
			clearOutput();
			reenteringInn2();
		}
		public function reenteringInn2():void {
			outputText("You can see many people enjoying a meal or drink in the dining hall, a barman standing by ready to serve drinks.");
			menu();
			addButton(0, "Drink", drinkAlcohol);
			//addButton(4, "", );mission giving npc
			//addButtonDisabled(12, "???", "You see some suspicious looking squirrel in one of inn corners. (Liadri + Star should bring this npc to more completness)");
			addButton(14, "Leave", heXinDao.riverislandVillageStuff);
		}
		
		public function drinkAlcohol():void {
			clearOutput();
			outputText("You go sit at the counter and the barman comes over to take your order.\n\n");
			outputText("\"<i>Good ");
			if (model.time.hours >= 16) outputText("afternoon ");
			else outputText("morning");
			outputText("" + player.mf("mister", "miss") + ", what can I get you?</i>\"\n\n");
			menu();
			addButton(0, "ManUp B", buyManupbeer);
			addButton(1, "Gob.Ale", buyGobale);
			addButton(2, "NoceLiq", buyNoceliq);
			addButton(3, "OniSake", buyOnisake);
			addButton(4, "SalamFW", buySalafw);
			addButton(14, "Back", notThirsty);
		}
		public function notThirsty():void {
			clearOutput();
			outputText("In the end you realise you are not thirsty after all and wave a goodbye before leaving.\n\n");
			doNext(reenteringInn);
		}
		public function buyManupbeer():void {
			if (player.gems < 18) {
				outputText("\n\nBarman shakes his head, indicating you need " + String(18 - player.gems) + " more gems to purchase this drink.");
				doNext(drinkAlcohol);
			}
			else {
				player.gems -= 18;
				statScreenRefresh();
				outputText("\n\nThe barman hands over the drink you ordered.");
				inventory.takeItem(consumables.MANUP_B, drinkAlcohol);
			}
		}
		public function buyGobale():void {
			if (player.gems < 18) {
				outputText("\n\nBarman shakes his head, indicating you need " + String(18 - player.gems) + " more gems to purchase this drink.");
				doNext(drinkAlcohol);
			}
			else {
				player.gems -= 18;
				statScreenRefresh();
				outputText("\n\nThe barman hands over the drink you ordered.");
				inventory.takeItem(consumables.GOB_ALE, drinkAlcohol);
			}
		}
		public function buyNoceliq():void {
			if (player.gems < 60) {
				outputText("\n\nBarman shakes his head, indicating you need " + String(60 - player.gems) + " more gems to purchase this drink.");
				doNext(drinkAlcohol);
			}
			else {
				player.gems -= 60;
				statScreenRefresh();
				outputText("\n\nThe barman hands over the drink you ordered.");
				inventory.takeItem(consumables.NOCELIQ, drinkAlcohol);
			}
		}
		public function buyOnisake():void {
			if (player.gems < 18) {
				outputText("\n\nBarman shakes his head, indicating you need " + String(18 - player.gems) + " more gems to purchase this drink.");
				doNext(drinkAlcohol);
			}
			else {
				player.gems -= 18;
				statScreenRefresh();
				outputText("\n\nThe barman hands over the drink you ordered.");
				inventory.takeItem(consumables.ONISAKE, drinkAlcohol);
			}
		}
		public function buySalafw():void {
			if (player.gems < 18) {
				outputText("\n\nBarman shakes his head, indicating you need " + String(18 - player.gems) + " more gems to purchase this drink.");
				doNext(drinkAlcohol);
			}
			else {
				player.gems -= 18;
				statScreenRefresh();
				outputText("\n\nThe barman hands over the drink you ordered.");
				inventory.takeItem(consumables.SALAMFW, drinkAlcohol);
			}
		}
		//drink list (to be expanded)
		//MANUP_B, GOB_ALE, NOCELIQ, ONISAKE, SALAMFW, fire mouse TF, some generic nonTF beers
	}
}