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
			if (flags[kFLAGS.JINX_LVL_UP] >= 0.4) {
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
			addButton(0, "MinoBomber", buyItemMinoBomber).hint("Both a sex toy and a weapon, the MinoBomber uses one rather unconventional ammunition: cum. Invented to take advantage of minotaur near endless supply of cum, this setup consists of a machine gun linked to a massive tank to be strapped on the users back and a harness with cockpump.");
			addButton(1, "Nail Gun", buyItemNailGun).hint("Usefull when you need to nail down crux of a problem.");
			addButton(2, "PileBunker", buyItemPileBunker).hint("When you need to jackhammer your point.");
			addButton(3, "Energy Core", buyItemEnergyCore).hint("A power source for devices.");
			addButton(4, "Golem Core", buyItemGolemCore).hint("Is this even functional golem core?");
			addButton(5, "MetalPiecesx1", buyItemMetalPlates, 1).hint("A metal pieces for something really cool. (x1)");
			addButton(6, "MetalPiecesx5", buyItemMetalPlates, 5).hint("A metal pieces for something really cool. (x5)");
			addButton(7, "MetalPiecesx10", buyItemMetalPlates, 10).hint("A metal pieces for something really cool. (x10)");
			addButton(8, "MetalPiecesx20", buyItemMetalPlates, 20).hint("A metal pieces for something really cool. (x20)");
			addButton(9, "MetalPiecesx50", buyItemMetalPlates, 50).hint("A metal pieces for something really cool. (x50)");
			if (flags[kFLAGS.JINX_LVL_UP] >= 0.8) addButton(10, "You", bazaarEncountersYouRepeat).hint("That a weird item to sell... but you all there behind [name] have very weird minds.");
			else addButton(10, "You", bazaarEncountersYou).hint("That a weird item to sell... but you all there behind [name] have very weird minds.");
			addButtonDisabled(11, "??? Core", "??? Core");
			addButton(14, "Back", SceneLib.bazaar.enterTheBazaarAndMenu);
		}
		
		private function buyItemMinoBomber():void {
			clearOutput();
			outputText("\"<i>That will be... perhaps... 250 spirit stones, yes definitely! It's how valuable they are. Show me da stones, baby!</i>\"\n\n");
			menu();
			if (flags[kFLAGS.SPIRIT_STONES] < 250) addButtonDisabled(1, "Buy", "You do not have enough spirit stones to buy this.");
			else addButton(1, "Buy", buyItemMinoBomberYes);
			addButton(3, "Don't Buy", bazaarEncounters);
		}
		private function buyItemMinoBomberYes():void {
			flags[kFLAGS.SPIRIT_STONES] -= 250;
			statScreenRefresh();
			outputText("She counts the stones carefully, putting them away before handing your purchase over.\n\n");
			outputText("\"<i>Always happy to do business! Anything else you want to buy, [name]?</i>\"\n\n");
			inventory.takeItem(weaponsrange.MBOMBER, bazaarEncounters);
		}
		private function buyItemNailGun():void {
			clearOutput();
			outputText("\"<i>That will be... perhaps... 150 spirit stones, yes definitely! It's how valuable they are. Show me da stones, baby!</i>\"\n\n");
			menu();
			if (flags[kFLAGS.SPIRIT_STONES] < 150) addButtonDisabled(1, "Buy", "You do not have enough spirit stones to buy this.");
			else addButton(1, "Buy", buyItemNailGunYes);
			addButton(3, "Don't Buy", bazaarEncounters);
		}
		private function buyItemNailGunYes():void {
			flags[kFLAGS.SPIRIT_STONES] -= 150;
			statScreenRefresh();
			outputText("She counts the stones carefully, putting them away before handing your purchase over.\n\n");
			outputText("\"<i>Always happy to do business! Anything else you want to buy, [name]?</i>\"\n\n");
			inventory.takeItem(weaponsrange.NAILGUN, bazaarEncounters);
		}
		private function buyItemPileBunker():void {
			clearOutput();
			outputText("\"<i>That will be... perhaps... 1,480 spirit stones, yes definitely! It's how valuable they are. Show me da stones, baby!</i>\"\n\n");
			menu();
			if (flags[kFLAGS.SPIRIT_STONES] < 1480) addButtonDisabled(1, "Buy", "You do not have enough spirit stones to buy this.");
			else addButton(1, "Buy", buyItemPileBunkerYes);
			addButton(3, "Don't Buy", bazaarEncounters);
		}
		private function buyItemPileBunkerYes():void {
			flags[kFLAGS.SPIRIT_STONES] -= 1480;
			statScreenRefresh();
			outputText("She counts the stones carefully, putting them away before handing your purchase over.\n\n");
			outputText("\"<i>Always happy to do business! Anything else you want to buy, [name]?</i>\"\n\n");
			inventory.takeItem(weapons.PILEBUN, bazaarEncounters);
		}
		private function buyItemUnknownCore():void {
			clearOutput();
			inventory.takeItem(useables.GOLCORE, bazaarEncounters);
		}
		private function buyItemEnergyCore():void {
			clearOutput();
			var cost:int = 520 / 4;
			outputText("\"<i>That will be... perhaps... " + cost + " spirit stones, yes definitely! It's how valuable they are. Show me da stones, baby!</i>\"\n\n");
			menu();
			if (flags[kFLAGS.SPIRIT_STONES] < cost) addButtonDisabled(1, "Buy", "You do not have enough spirit stones to buy this.");
			else if (CampStatsAndResources.EnergyCoreResc >= 200) addButtonDisabled(1, "Buy", "You can't store any more of this type of items.");
			else addButton(1, "Buy", curry(buyItemEnergyCoreYes, cost));
			addButton(3, "Don't Buy", bazaarEncounters);
		}
		private function buyItemEnergyCoreYes(cost:Number):void {
			flags[kFLAGS.SPIRIT_STONES] -= cost;
			statScreenRefresh();
			outputText("She counts the stones carefully, putting them away before handing your purchase over.\n\n");
			outputText("\"<i>Always happy to do business! Anything else you want to buy, [name]?</i>\"\n\n");
			CampStatsAndResources.EnergyCoreResc++;
			doNext(bazaarEncounters);
		}
		private function buyItemGolemCore():void {
			clearOutput();
			outputText("\"<i>That will be perhaps... actually, just a single spirit stone! Valued all for the price of just one stone! Show me dat stone, baby!</i>\"\n\n");
			menu();
			if (flags[kFLAGS.SPIRIT_STONES] < 1) addButtonDisabled(1, "Buy", "You do not have spirit stone to buy this.");
			else addButton(1, "Buy", buyItemGolemCoreYes);
			addButton(3, "Don't Buy", bazaarEncounters);
		}
		private function buyItemGolemCoreYes():void {
			flags[kFLAGS.SPIRIT_STONES] -= 1;
			statScreenRefresh();
			outputText("She puts the single stone away before handing your purchase over.\n\n");
			outputText("\"<i>Always happy to do business, anything else you want to buy [name]?</i>\"\n\n");
			inventory.takeItem(useables.GOLCORE, bazaarEncounters);
		}
		private function buyItemMetalPlates(amt:Number):void {
			clearOutput();
			var cost:int = (60 * amt) / 4;
			outputText("\"<i>That will be... perhaps... " + cost + " spirit stones, yes definitely! It's how valuable they are. Show me da stones, baby!</i>\"\n\n");
			menu();
			if (flags[kFLAGS.SPIRIT_STONES] < cost) addButtonDisabled(1, "Buy", "You do not have enough spirit stones to buy this.");
			else if (CampStatsAndResources.MetalPieces >= (201 - amt)) addButtonDisabled(1, "Buy", "You can't store any more of this type of items.");
			else addButton(1, "Buy", curry(buyItemMetalPlatesYes, cost, amt));
			addButton(3, "Don't Buy", bazaarEncounters);
		}
		private function buyItemMetalPlatesYes(cost:Number, amt:Number):void {
			flags[kFLAGS.SPIRIT_STONES] -= cost;
			statScreenRefresh();
			outputText("She counts the stones carefully, putting them away before handing your purchase over.\n\n");
			outputText("\"<i>Always happy to do business! Anything else you want to buy, [name]?</i>\"\n\n");
			CampStatsAndResources.MetalPieces += amt;
			doNext(bazaarEncounters);
		}
		
		public function bazaarEncountersYou():void {
			clearOutput();
			outputText("\"<i>You want.. me?</i>\" her eyes widen. \"<i>But I'm a living and sentient being. You can't just buy me..! I'm not that crazy... well… hmmm… probably…</i>\"\n\n");
			outputText("Wait, did she really think you were serious? Before you can explain, she perks up, \"<i>1,000 spirit stones.</i>\" You stare at her for a moment as she stands proud, seemingly satisfied with herself. \"<i>That should be enough.</i>\"\n\n");
			outputText("A thousand spirit stones? For buying her?\n\n");
			outputText("\"<i>No that fee is for me to move to... you got some place you live in, right?</i>\"\n\n");
			outputText("Your camp is what you have to offer, anyway.\n\n");
			outputText("\"<i>Yeah, move to your [camp]. It would be enough for now. And if I feel I no longer like your place, I would leave. Deal?</i>\"\n\n");
			outputText("You note that is quite a hefty sum of stones.\n\n");
			outputText("\"<i>Um,</i>\" she took a look back at the cart, then golem. \"<i>Ten spirit stones and free reign to do whatever I want in my corner. I still need to finish some projects and my current place is... too noisy with too curious neighbors.</i>\"\n\n");
			outputText("With such a price drop, you’re wondering if you should be concerned. Something feels... off here.\n\n");
			outputText("\"<i>Nope, nothing suspicious here. So decides the customer, if you accept my deal or return to browsing my wares here..</i>\"\n\n");
			flags[kFLAGS.JINX_LVL_UP] = 0.8;
			menu();
			addButton(1, "No", bazaarEncounters);
			addButtonDisabled(3, "Yes", "Inviting someone who would gladly blow up a warehouse to prove her usefulness seems like a horrendous idea... Right?");
		}
		public function bazaarEncountersYouRepeat():void {
			clearOutput();
			outputText("\"<i>No changes to my fee since the last time you asked. Ten spirit stones and a corner of space to myself. Do we have a deal or not?</i>\"\n\n");
			menu();
			addButton(1, "No", bazaarEncounters);
			addButtonDisabled(3, "Yes", "Inviting someone who would gladly blow up a warehouse to prove her usefulness seems like a horrendous idea... Right?");
		}
		public function bazaarEncountersYouYes():void {
			clearOutput();
			outputText("\"<i></i>\"\n\n");
			outputText("\"<i></i>\"\n\n");
			outputText("\"<i></i>\"\n\n");
			outputText("\"<i></i>\"\n\n");
			outputText("\"<i></i>\"\n\n");
			outputText("\"<i></i>\"\n\n");
			outputText("\"<i></i>\"\n\n");
		}
		
		public function campJinxMenuMain():void {
			clearOutput();
			outputText("Approaching the usual place where Minx resides, it would almost seem that there was some technological revolution happening here with all the sophisticated items put in seemingly specific ways… Or maybe they are all just thrown around randomly.\n\n");
			outputText("After a moment, from the midst of all the trinkets, emerges a blue haired goblin. \"<i>Ahh [name]. Be quick, I’ve got a lot of work to return to. So, what’s it gonna be?</i>\"\n\n");
			menu();
			addButton(0, "Shop", campJinxMenuMainShop);
			//x - Talk
			//x - fletcher table for guns
			addButton(14, "Back", camp.campFollowers);
		}
		
		public function campJinxMenuMainShop():void {
			clearOutput();
			menu();
			addButton(0, "MetalPiecesx1", buyItemMetalPlates, 1).hint("A metal pieces for something really cool. (x1)");
			addButton(1, "MetalPiecesx5", buyItemMetalPlates, 5).hint("A metal pieces for something really cool. (x5)");
			addButton(2, "MetalPiecesx10", buyItemMetalPlates, 10).hint("A metal pieces for something really cool. (x10)");
			addButton(3, "MetalPiecesx20", buyItemMetalPlates, 20).hint("A metal pieces for something really cool. (x20)");
			addButton(4, "MetalPiecesx50", buyItemMetalPlates, 50).hint("A metal pieces for something really cool. (x50)");
			addButton(5, "Golem Core", buyItemGolemCore).hint("Is this even functional golem core?");
			addButton(6, "Energy Core", buyItemEnergyCore).hint("A power source for devices.");
			addButtonDisabled(7, "MinoBomber", "MinoBomber");
			addButtonDisabled(10, "??? Core", "??? Core");
			addButton(14, "Back", campJinxMenuMain);
		}
		public function aaa8():void {
			clearOutput();
			outputText("\"<i></i>\"\n\n");
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
}//