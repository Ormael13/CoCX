/**
 * ...
 * @author Ormael
 */
package classes.Scenes.NPCs 
{
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.Camp.CampStatsAndResources;
import classes.Scenes.SceneLib;
	
	public class JinxFollower extends NPCAwareContent
	{
		
		public function JinxFollower() 
		{}
		
		public function bazaarEncounters():void {
			clearOutput();
			if (flags[kFLAGS.JINX_LVL_UP] == 0.4) {
				outputText("When you walk into the bazaar alley, a blue-haired goblin followed by a large golem-like figure pushing a cart approaches you again.\n\n");
				outputText("\"<i>Hey there! You're back. Need something?</i>\"\n\n");
			}
			else {
				outputText("When you walk into the bazaar alley, a blue-haired goblin followed by large golem-like figure pushing a cart approaches you.\n\n");
				outputText("\"<i>Hello there. Are you in need of gun? Or maybe ammo to it? Or... belts?!</i>\" She uncovers the top of the cart, showing you her wares. You notice a strange contraption that appears to be a cockpump attached to something resembling a canon.\n\n");
				outputText("She follows your gaze to the item, \"<i>Oh this is the MinoBomber! Original project of greatest inventor, Minx!</i>\"\n\n");
				outputText("Noticing your confusion, she folds her arms, \"<i>You have not heard about her?</i>\" Her ears droop, briefly crestfallen, before she straightens her back with a grin, starting to laugh maniacally. \"<i>Not to worry, for I am she!</i>\" She starts to talk seemingly to herself, as if remembering something from the past.\n\n");
				outputText("\"<i>They said. 'Minx you can't do it. You not ready. Who would want this.'</i>\" She beams brighter as she puffs out her chest, \"<i>But I did it, I showed all those cunts it was possible! So, do you want it or maybe... some other stuff?</i>\"\n\n");
				flags[kFLAGS.JINX_LVL_UP] = 0.4;
			}
			menu();
			addButton(3, "Energy Core", buyItemEnergyCore).hint("A power source for devices.");
			addButton(5, "MetalPiecesx1", buyItemMetalPlates, 1).hint("A metal pieces for something really cool. (x1)");
			addButton(6, "MetalPiecesx5", buyItemMetalPlates, 5).hint("A metal pieces for something really cool. (x5)");
			addButton(7, "MetalPiecesx10", buyItemMetalPlates, 10).hint("A metal pieces for something really cool. (x10)");
			addButton(8, "MetalPiecesx20", buyItemMetalPlates, 20).hint("A metal pieces for something really cool. (x20)");
			addButton(9, "MetalPiecesx50", buyItemMetalPlates, 50).hint("A metal pieces for something really cool. (x50)");
			addButton(14, "Back", SceneLib.bazaar.enterTheBazaarAndMenu);
		}
		
		private function buyItemEnergyCore():void {
			clearOutput();
			var cost:int = 520 / 5;
			outputText("\"<i>That will be perhaps... " + cost + " spirit stones, yes definetly it's how value they are. Show me da stones baby.</i>\"\n\n");
			menu();
			if (flags[kFLAGS.SPIRIT_STONES] < cost) addButtonDisabled(1, "Buy", "You do not have enough spirit stones to buy this.");
			else if (CampStatsAndResources.EnergyCoreResc >= 200) addButtonDisabled(1, "Buy", "You can't store any more of this type of items.");
			else addButton(1, "Buy", curry(buyItemEnergyCoreYes, cost));
			addButton(3, "Don't Buy", bazaarEncounters);
		}
		private function buyItemEnergyCoreYes(cost:Number):void {
			flags[kFLAGS.SPIRIT_STONES] -= cost;
			statScreenRefresh();
			outputText("She counts the stones and putting htem away before handing your purchase over.\n\n");
			outputText("\"<i>Always happy to do business, anything else you want to buy [name]?</i>\"\n\n");
			CampStatsAndResources.EnergyCoreResc++;
			doNext(bazaarEncounters);
		}
		private function buyItemMetalPlates(amt:Number):void {
			clearOutput();
			var cost:int = (60 * amt) / 4;
			outputText("\"<i>That will be perhaps... " + cost + " spirit stones, yes definetly it's how value they are. Show me da stones baby.</i>\"\n\n");
			menu();
			if (flags[kFLAGS.SPIRIT_STONES] < cost) addButtonDisabled(1, "Buy", "You do not have enough spirit stones to buy this.");
			else if (CampStatsAndResources.MetalPieces >= (201 - amt)) addButtonDisabled(1, "Buy", "You can't store any more of this type of items.");
			else addButton(1, "Buy", curry(buyItemMetalPlatesYes, cost, amt));
			addButton(3, "Don't Buy", bazaarEncounters);
		}
		private function buyItemMetalPlatesYes(cost:Number, amt:Number):void {
			flags[kFLAGS.SPIRIT_STONES] -= cost;
			statScreenRefresh();
			outputText("She counts the stones and putting htem away before handing your purchase over.\n\n");
			outputText("\"<i>Always happy to do business, anything else you want to buy [name]?</i>\"\n\n");
			CampStatsAndResources.MetalPieces += amt;
			doNext(bazaarEncounters);
		}
		
		public function campJinxMenuMain():void {
			clearOutput();
			outputText("Approaching the usual place where Minx resides, it would almost seem that there was some technological revolution happening here with all the sophisticated items put in seemingly specific ways… Or maybe they are all just thrown around randomly.\n\n");
			outputText("After a moment, from the midst of all the trinkets, emerges a blue haired goblin. \"<i>Ahh [name]. Be quick, I’ve got a lot of work to return to. So, what’s it gonna be?</i>\"\n\n");
			menu();
			addButton(14, "Back", camp.campFollowers);
		}
		
		public function aaa12():void {
			clearOutput();
			outputText("\"<i></i>\"\n\n");
			outputText("\"<i></i>\"\n\n");
		}
		public function aaa11():void {
			clearOutput();
			outputText("\"<i></i>\"\n\n");
		}
		public function aaa10():void {
			clearOutput();
			outputText("\"<i></i>\"\n\n");
		}
		public function aaa9():void {
			clearOutput();
			outputText("\"<i></i>\"\n\n");
		}
		public function aaa8():void {
			clearOutput();
			outputText("\"<i></i>\"\n\n");
		}
		public function aaa7():void {
			clearOutput();
			outputText("\"<i></i>\"\n\n");
		}
		public function aaa6():void {
			clearOutput();
			outputText("\"<i></i>\"\n\n");
		}
		public function aaa5():void {
			clearOutput();
			outputText("\"<i></i>\"\n\n");
		}
		public function aaa4():void {
			clearOutput();
			outputText("\"<i></i>\"\n\n");
		}
		public function aaa3():void {
			clearOutput();
			outputText("\"<i></i>\"\n\n");
		}
		public function aaa2():void {
			clearOutput();
			outputText("\"<i></i>\"\n\n");
		}
		public function aaa1():void {
			clearOutput();
			outputText("\"<i></i>\"\n\n");
		}
	}
}