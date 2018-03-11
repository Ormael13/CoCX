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
		
		public function enteringInn(first:Boolean = true):void {
			clearOutput();
			if(first){
				outputText("You enter the town local Inn ‘Journey to the East’ and look around. ");
			}
			outputText("You can see many people enjoying a meal or drink in the dining hall, a barman standing by ready to serve drinks.");
			menu();
			addButton(0, "Drink", drinkAlcohol);
			//addButton(4, "", );mission giving npc
			//addButtonDisabled(12, "???", "You see some suspicious looking squirrel in one of inn corners. (Liadri + Star should bring this npc to more completness)");
			addButton(14, "Leave", heXinDao.riverislandVillageStuff);
		}
		
		private function drinkAlcohol():void {
			clearOutput();
			outputText("You go sit at the counter and the barman comes over to take your order.\n\n");
			outputText("\"<i>Good ");
			if (model.time.hours >= 16) outputText("afternoon ");
			else outputText("morning");
			outputText("" + player.mf("mister", "miss") + ", what can I get you?</i>\"\n\n");
			menu();
			addButton(0, "ManUp B", buyDrink, consumables.MANUP_B);
			addButton(1, "Gob.Ale", buyDrink, consumables.GOB_ALE);
			addButton(2, "NoceLiq", buyDrink, consumables.NOCELIQ);
			addButton(3, "OniSake", buyDrink, consumables.ONISAKE);
			addButton(4, "SalamFW", buyDrink, consumables.SALAMFW);
			addButton(14, "Back", notThirsty);
		}

		private function notThirsty():void {
			clearOutput();
			outputText("In the end you realise you are not thirsty after all and wave a goodbye before leaving.\n\n");
			doNext(curry(enteringInn,false));
		}

		private function buyDrink(drink:ItemType):void{
			var cost:int = drink.value * 3;
			if(player.gems < cost){
				outputText("\n\nBarman shakes his head, indicating you need " + String(cost - player.gems) + " more gems to purchase this drink.");
				doNext(drinkAlcohol);
				return;
			}
			player.gems -= cost;
			statScreenRefresh();
			outputText("\n\nThe barman hands over the drink you ordered.");
			inventory.takeItem(drink, drinkAlcohol);
		}
		//drink list (to be expanded)
		//MANUP_B, GOB_ALE, NOCELIQ, ONISAKE, SALAMFW, fire mouse TF, some generic nonTF beers
	}
}