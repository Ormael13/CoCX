//Ingnam: The Prologue
package classes.Scenes.Places
{
import classes.*;
import classes.GlobalFlags.*;
import classes.Scenes.Places.Ingnam.*;
import classes.Scenes.SceneLib;
import classes.Scenes.Soulforce;

import coc.view.MainView;

public class Ingnam extends BaseContent
	{
		public var ingramTavern:IngramTavern = new IngramTavern();
		public var ingnamFarm:IngnamFarm = new IngnamFarm();
		public var thiefScene:ThiefScene = new ThiefScene();
		public var soulforce:Soulforce = new Soulforce();

		public function get inIngnam():Boolean { return flags[kFLAGS.IN_INGNAM]; }

		public function Ingnam()
		{
		}

		//Main Ingnam menu.
		public function menuIngnam():void {
			//Force autosave
			if (player.slotName != "VOID" && mainView.getButtonText(0) != "Game Over" && flags[kFLAGS.HARDCORE_MODE] > 0)
			{
				trace("Autosaving to slot: " + player.slotName);

			CoC.instance.saves.saveGameToSharedObject(player.slotName);
            }
			//Banished to Mareth.
			if (model.time.days >= 0 && flags[kFLAGS.INGNAM_PROLOGUE_COMPLETE] <= 0) {
				getBanishedToMareth();
				return;
			}
			clearOutput();
			if (timeQueued) {
				if (goNext(false)) {
					return;
				}
			}
			outputText(images.showImage("location-ingnam"));
			outputText("Ingnam is a rich and prosperous village despite its small size. There is already a well-established array of shops with a constant hum of tradesmen and merchants. The temple sits within view of the patrons sitting at tables at the tavern which serves as a hub for people near and far to drink and dance. On the road leading out of the plaza that sits before the temple is a trail that meanders its way to a large farm in the distance.");
			outputText("\n\nLooming ominously in the distance is a mountain known by the locals as Mount Ilgast. Surrounding Ingnam is a vast expanse of wilderness.");
			if (model.time.hours >= 21 || model.time.hours < 6) outputText("\n\nIt's dark outside. Stars dot the night sky and a moon casts the moonlight over the landscape, providing little light. Shops are closed at this time.");
			mainView.showMenuButton( MainView.MENU_NEW_MAIN );
			mainView.showMenuButton( MainView.MENU_DATA );
			mainView.showMenuButton( MainView.MENU_STATS );
			mainView.showMenuButton( MainView.MENU_PERKS );
			mainView.showMenuButton( MainView.MENU_APPEARANCE );
			showStats();
			mainView.setMenuButton( MainView.MENU_NEW_MAIN, "Main Menu", CoC.instance.mainMenu.mainMenu );
			mainView.newGameButton.toolTipText = "Return to main menu.";
			mainView.newGameButton.toolTipHeader = "Main Menu";
			if (camp.setLevelButton(true)) return;
			hideUpDown();
			menu();
			addButton(0, "Explore", exploreIngnam);
			addButton(1, "Shops", menuShops);
			addButton(2, "Temple", menuTemple);
			addButton(3, "Inn", ingramTavern.menuTavern);
			addButton(4, "Farm", ingnamFarm.menuFarm);
			if (flags[kFLAGS.INGNAM_PROLOGUE_COMPLETE] > 0) addButton(5, "Return2Camp", returnToMareth);
			if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] > 0 && inventory.showStash() && flags[kFLAGS.INGNAM_PROLOGUE_COMPLETE] <= 0) addButton(6, "Stash", inventory.stash);
			addButton(7, "Inventory", inventory.inventoryMenu);
			if (player.lust >= 30) {
				if (player.lust >= player.maxOverLust()) {
					outputText("\n\n<b>You are debilitatingly aroused, and can think of doing nothing other than masturbating.</b>");
					removeButton(0);
					removeButton(4);
				}
				SceneLib.masturbation.masturButton(8);
			}
			//Show wait/rest/sleep depending on conditions.
			addButton(9, "Wait", SceneLib.camp.doWait);
            if (player.fatigue > 40 || player.HP / player.maxHP() <= .9) addButton(9, "Rest", SceneLib.camp.rest);
            if (model.time.hours >= 21 || model.time.hours < 6) {
				removeButton(0);
				removeButton(1);
				removeButton(2);
				removeButton(4);
                addButton(9, "Sleep", SceneLib.camp.doSleep);
            }
			if (player.hasPerk(PerkLib.JobSoulCultivator)) addButton(10, "Soulforce", soulforce.accessSoulforceMenu).hint("Spend some time on the cultivation or spend some of the soulforce.");
		}

		//The end of prologue, starts the game.
		public function getBanishedToMareth():void {
			var hasWeapon:Boolean = false;
			clearOutput();
			hideMenus();
			outputText("Your time has come to meet up with the village elders. You know you are going to get sent to the demon realm and you're most likely not going to be able to return to Ingnam. You give your family and friends a long farewell.");
			flags[kFLAGS.IN_INGNAM] = 0;
			flags[kFLAGS.INGNAM_PROLOGUE_COMPLETE] = 1;
			doNext(CoC.instance.charCreation.arrival);
		}

		public function returnToMareth():void {
			clearOutput();
			outputText("You make your journey to Mount Ilgast, walk through the portal back to Mareth and return to your camp.");
			flags[kFLAGS.IN_INGNAM] = 0;
			doNext(camp.returnToCampUseOneHour);
		}

		public function returnToIngnam():void {
			clearOutput();
			outputText("You enter the portal and make your return to Ingnam, thanks to the debug powers.");
			flags[kFLAGS.IN_INGNAM] = 1;
			doNext(camp.returnToCampUseOneHour);
		}

		//Explore Ingnam
		public function exploreIngnam():void {
			hideMenus();
			clearOutput();
			if (rand(4) == 0) {
				outputText("You explore the village of Ingnam for a while but you don't find anything interesting.");
				advanceMinutes(15);
				doNext(camp.doCamp);
			}
			else thiefScene.encounterThief();
		}

		//Shopping time!
		public function menuShops():void {
			hideMenus();
			clearOutput();
			outputText("Which shop would you like to visit?");
			menu();
			addButton(0, "Blacksmith", shopBlacksmith);
			addButton(1, "Tailor", shopTailor);
			addButton(2, "Alchemist", shopAlchemist);
			addButton(3, "Trading Post", shopTradingPost);
			addButton(4, "Black Market", shopBlackMarket);
			addButton(14, "Back", menuIngnam);
		}

		public function shopBlacksmith():void {
			clearOutput();
			outputText("You enter the armor shop, noting the sign depicting armors. Some armor is proudly displayed on racks. You can hear the sound of hammering although it stops shortly after you enter. The local blacksmith, Ben, comes from the rear door, stepping up to the counter as he wipes the sweat from his brow, face red from the heat of his forge. \"<i>Welcome to my shop. Are you in need of protection? Or something sharp?</i>\"");
			if (flags[kFLAGS.INGNAM_WEAPONSMITH_TALKED] <= 0 && flags[kFLAGS.INGNAM_PROLOGUE_COMPLETE] <= 0) {
				outputText("\n\nBefore you can get a word in Ben lets out an exasperated sigh \"<i>Ah, just forget about…</i>\"");
				outputText("\n\nYou crook an eyebrow questioningly at the blacksmith. Ben then realizes his blunder.");
				outputText("\n\n\"<i>Ah, well it’s just… You’re the new Champion, right? None of the people I’ve seen who get sent to the portal brought a weapon and you would waste some gems. Still, if you want to train with weapons, you can go ahead and buy them. A little preparation never hurt anyone.</i>\" the blacksmith says.");
				flags[kFLAGS.INGNAM_WEAPONSMITH_TALKED] = 1;
			}
			outputText("\n\n<b><u>Blacksmith's pricings</u></b>");
			menu();
			if (player.hasPerk(PerkLib.HistoryFighter) || player.hasPerk(PerkLib.PastLifeFighter)) { //20% discount for History: Fighter
				addShopItem(weapons.DAGGER, 160, 1);
				addShopItem(weapons.PIPE, 120, 1);
				addShopItem(weapons.SPEAR, 480, 1);
				addShopItem(weapons.KATANA, 720, 1);
				addShopItem(weapons.MACE, 400, 1);
			}
			else {
				addShopItem(weapons.DAGGER, 200, 1);
				addShopItem(weapons.PIPE, 150, 1);
				addShopItem(weapons.SPEAR, 600, 1);
				addShopItem(weapons.KATANA, 900, 1);
				addShopItem(weapons.MACE, 500, 1);
			}
			if (player.hasPerk(PerkLib.HistorySmith) || player.hasPerk(PerkLib.PastLifeSmith)) { //20% discount for History: Smith perk
				addShopItem(armors.LEATHRA, 120, 2);
				addShopItem(armors.FULLCHN, 360, 2);
				addShopItem(armors.SCALEML, 800, 2);
			}
			else {
				addShopItem(armors.LEATHRA, 150, 2);
				addShopItem(armors.FULLCHN, 450, 2);
				addShopItem(armors.SCALEML, 1000, 2);
			}
			addShopItem(weapons.A_WAND, 225, 2);
			addButton(14, "Leave", menuShops);
		}

		public function shopTailor():void {
			clearOutput();
			outputText("You enter the tailor’s. The interior is laden with mannequins wearing half-finished works. Clothes are displayed on racks without obvious flaws. A fastidious, well-groomed young man with an immaculate blue three-piece suit topped with a measuring tape draping around his collar stands behind the counter and smiles at you with deference.");
			outputText("\n\n\"<i>Welcome to my shop. Do you need to get outfitted?</i>\" he says pulling keenly at the measuring tape draping his shoulders.");
			outputText("\n\n<b><u>Tailor shop pricings</u></b>");
			menu();
			addShopItem(armors.C_CLOTH, 15, 3);
			addShopItem(armors.ADVCLTH, 75, 3);
			addShopItem(armors.CLSSYCL, 60, 3);
			addShopItem(armors.TUBETOP, 40, 3);
			addShopItem(armors.OVERALL, 40, 3);
			addShopItem(armors.M_ROBES, 40, 3);
			addShopItem(armors.LTHRPNT, 30, 3);
			addShopItem(armors.RBBRCLT, 225, 3);
			addShopItem(armors.T_BSUIT, 75, 3);
			addButton(14, "Leave", menuShops);
		}

		public function shopAlchemist():void {
			clearOutput();
			if (flags[kFLAGS.INGNAM_ALCHEMIST_TALKED] <= 0) {
				outputText("As you approach the stone building, the overpowering smell of herbs and plants being brewed hits your nose. The crimson banner over the heavy wooden door indicates that this is where the potions are made. You enter what appears to be the place where the alchemist works on his famed remedies.");
				outputText("\n\nYou open the door and enter. Despite the establishment being dimly lit by candlelight, you can make out the vast multicolored rows of countless potions, elixirs and tonics. Fragrant drying herbs are hanging from the rafters and various strange-looking equipment is set up in a variety of locations in the store.");
				outputText("\n\nAn ancient-looking man in a much-singed pair of robes is working on something volatile in the corner until he hears your presence. He stops and shuffles up to the timber counter, drumming it under his stained fingers. \"<i>What can I do for you, young master?</i>\" he says from under his frayed hood.");
				flags[kFLAGS.INGNAM_ALCHEMIST_TALKED] = 1;
			}
			else {
				outputText("Once again, you return to the alchemist, letting the overpowering smell of herbs and plants being brewed hits your nose.");
				outputText("\n\nThe alchemist senses your presence as he steps up to the counter before speaking up, \"<i>How may I help you?</i>\"");
			}
			outputText("\n\n<b><u>Alchemy shop pricings</u></b>");
			menu();
			if (player.hasPerk(PerkLib.HistoryAlchemist) || player.hasPerk(PerkLib.PastLifeAlchemist)) { //20% discount for History: Alchemist perk
				addShopItem(consumables.REDUCTO, 80, 4);
				addShopItem(consumables.GROPLUS, 80, 4);
				addShopItem(consumables.L_DRAFT, 25, 4);
				addShopItem(consumables.LACTAID, 40, 4);
				addShopItem(consumables.HEALHERB, 12, 4);
				addShopItem(consumables.MOONGRASS, 12, 4);
			}
			else {
				addShopItem(consumables.REDUCTO, 100, 4);
				addShopItem(consumables.GROPLUS, 100, 4);
				addShopItem(consumables.L_DRAFT, 30, 4);
				addShopItem(consumables.LACTAID, 50, 4);
				addShopItem(consumables.HEALHERB, 15, 4);
				addShopItem(consumables.MOONGRASS, 15, 4);
			}
			addButton(14, "Leave", menuShops);
		}

		public function shopTradingPost():void {
			clearOutput();
			outputText("The trading post is one of the larger buildings in the village, with its porch covered in barrels filled with pickled goods, preserved delicacies and dried goods, from the humble local farm to exotic faraway lands. The interior is packed with crowded shelves that boast a variety of goods, all arranged neatly on shelves.");
			outputText("\n\nYou suspect you could buy or sell some imported goods here.");
			outputText("\n\n<b><u>Trading post pricings</u></b>");
			menu();
			addShopItem(consumables.MANUP_B, 12, 5);
			addShopItem(consumables.VITAL_T, 30, 5);
			addShopItem(consumables.AGILI_E, 12, 5);
			addShopItem(consumables.SMART_T, 30, 5);
			addShopItem(consumables.INCOINS, 30, 5);
			addShopItem(consumables.FISHFIL, 10, 5);
			addShopItem(consumables.H_PILL, 10, 5);
			addButton(10, "Sell", sellAtTradingPost);
			addButton(14, "Leave", menuShops);
		}
		private function sellAtTradingPost(page:int = 1):void {
			var slot:int;
			clearOutput();
			outputText("The trading post is one of the larger buildings in the village, with its porch covered in barrels filled with pickled goods, preserved delicacies and dried goods, from the humble local farm to exotic faraway lands. The interior is packed with crowded shelves that boast a variety of goods, all arranged neatly on shelves.");
			outputText("\n\nYou suspect you could buy or sell some imported goods here.\n\n");
			menu();
			var totalItems:int = 0;
			if (page == 1) {
				for (slot = 0; slot < 10; slot++) {
					if (player.itemSlots[slot].quantity > 0 && player.itemSlots[slot].itype.value >= 1) {
						outputText("\n" + int(player.itemSlots[slot].itype.value / 3) + " gems for " + player.itemSlots[slot].itype.longName + ".");
						addButton(slot, (player.itemSlots[slot].itype.shortName + " x" + player.itemSlots[slot].quantity), shopTradingPostSell, slot);
						totalItems += player.itemSlots[slot].quantity;
					}
				}
				if (inventory.getMaxSlots() > 10) addButton(13, "Next", sellAtTradingPost, page + 1);
			}
			if (page == 2) {
				for (slot = 10; slot < 20; slot++) {
					if (player.itemSlots[slot].quantity > 0 && player.itemSlots[slot].itype.value >= 1) {
						outputText("\n" + int(player.itemSlots[slot].itype.value / 3) + " gems for " + player.itemSlots[slot].itype.longName + ".");
						addButton(slot-10, (player.itemSlots[slot].itype.shortName + " x" + player.itemSlots[slot].quantity), shopTradingPostSell, slot);
						totalItems += player.itemSlots[slot].quantity;
					}
				}
				addButton(12, "Prev", sellAtTradingPost, page - 1);
				if (inventory.getMaxSlots() > 20) addButton(13, "Next", sellAtTradingPost, page + 1);
			}
			if (page == 3) {
				for (slot = 20; slot < 30; slot++) {
					if (player.itemSlots[slot].quantity > 0 && player.itemSlots[slot].itype.value >= 1) {
						outputText("\n" + int(player.itemSlots[slot].itype.value / 3) + " gems for " + player.itemSlots[slot].itype.longName + ".");
						addButton(slot-20, (player.itemSlots[slot].itype.shortName + " x" + player.itemSlots[slot].quantity), shopTradingPostSell, slot);
						totalItems += player.itemSlots[slot].quantity;
					}
				}
				addButton(12, "Prev", sellAtTradingPost, page - 1);
				if (inventory.getMaxSlots() > 30) addButton(13, "Next", sellAtTradingPost, page + 1);
			}
			if (page == 4) {
				for (slot = 30; slot < 40; slot++) {
					if (player.itemSlots[slot].quantity > 0 && player.itemSlots[slot].itype.value >= 1) {
						outputText("\n" + int(player.itemSlots[slot].itype.value / 3) + " gems for " + player.itemSlots[slot].itype.longName + ".");
						addButton(slot-30, (player.itemSlots[slot].itype.shortName + " x" + player.itemSlots[slot].quantity), shopTradingPostSell, slot);
						totalItems += player.itemSlots[slot].quantity;
					}
				}
				addButton(12, "Prev", sellAtTradingPost, page - 1);
				if (inventory.getMaxSlots() > 40) addButton(13, "Next", sellAtTradingPost, page + 1);
			}
			if (page == 5) {
				for (slot = 40; slot < 50; slot++) {
					if (player.itemSlots[slot].quantity > 0 && player.itemSlots[slot].itype.value >= 1) {
						outputText("\n" + int(player.itemSlots[slot].itype.value / 3) + " gems for " + player.itemSlots[slot].itype.longName + ".");
						addButton(slot-40, (player.itemSlots[slot].itype.shortName + " x" + player.itemSlots[slot].quantity), shopTradingPostSell, slot);
						totalItems += player.itemSlots[slot].quantity;
					}
				}
				addButton(12, "Prev", sellAtTradingPost, page - 1);
			}
			if (totalItems > 1) addButton(11, "Sell All", shopTradingPostSellAll);
			addButton(14, "Back", shopTradingPost);
		}
		private function shopTradingPostSell(slot:int):void {
			var itemValueOrgin:Number = player.itemSlots[slot].itype.value;
			var itemValue:int = int(player.itemSlots[slot].itype.value / 3);
			clearOutput();
			if (shiftKeyDown) {
				if (itemValue == 0)
					outputText("You hand over " + num2Text(player.itemSlots[slot].quantity) + " " +  player.itemSlots[slot].itype.shortName + " to trader.  He shrugs and says, \"<i>Well ok, it isn't worth anything, but I'll take it.</i>\"");
				else outputText("You hand over " + num2Text(player.itemSlots[slot].quantity) + " " +  player.itemSlots[slot].itype.shortName + " to trader.  He nervously pulls out " + num2Text(itemValue * player.itemSlots[slot].quantity)  + " gems and drops them into your waiting hand.");
				while (player.itemSlots[slot].quantity > 0){
					player.itemSlots[slot].removeOneItem();
					if (player.hasPerk(PerkLib.Greedy)) {
						itemValue *= 2;
						if (itemValue > itemValueOrgin) itemValue = itemValueOrgin;
					}
					player.gems += itemValue;
				}
			}
			else {
				if (player.hasPerk(PerkLib.Greedy)) itemValue *= 2;
				if (player.hasPerk(PerkLib.TravelingMerchantOutfit)) itemValue *= 2;
				if (itemValue > itemValueOrgin) itemValue = itemValueOrgin;
				if (itemValue == 0) outputText("You hand over " + player.itemSlots[slot].itype.longName + " to trader.  He shrugs and says, \"<i>Well ok, it isn't worth anything, but I'll take it.</i>\"");
				else outputText("You hand over " + player.itemSlots[slot].itype.longName + " to trader.  He nervously pulls out " + num2Text(itemValue) + " gems and drops them into your waiting hand.");
				player.itemSlots[slot].removeOneItem();
				if (itemValue != 0 && player.hasPerk(PerkLib.Greedy) || player.hasPerk(PerkLib.TravelingMerchantOutfit)) outputText("Thanks to a little magic and a lot of hard bargaining you managed to sell your item for more than normal.");
				player.gems += itemValue;
			}
			statScreenRefresh();
			doNext(sellAtTradingPost);
		}

		private function shopTradingPostSellAll():void {
			var itemValue:int = 0;
			clearOutput();
			for (var slot:int = 0; slot < 50; slot++) {
				if (player.itemSlots[slot].quantity > 0 && player.itemSlots[slot].itype.value >= 1) {
					itemValue += player.itemSlots[slot].quantity * int(player.itemSlots[slot].itype.value / 2);
					player.itemSlots[slot].quantity = 0;
				}
			}
			if (player.hasPerk(PerkLib.Greedy) || player.hasPerk(PerkLib.TravelingMerchantOutfit)) itemValue *= 2;
			outputText("You lay out all the items you're carrying on the counter in front of trader.  He examines them all and nods.  Nervously, he pulls out " + num2Text(itemValue) + " gems and drops them into your waiting hand.");
			if (player.hasPerk(PerkLib.Greedy) || player.hasPerk(PerkLib.TravelingMerchantOutfit)) outputText("Thanks to a little magic and a lot of hard bargaining you managed to sell your item for more than normal.");
			player.gems += itemValue;
			statScreenRefresh();
			doNext(sellAtTradingPost);
		}

		public function shopBlackMarket():void {
			clearOutput();
			if (flags[kFLAGS.INGNAM_BLACKMARKET_TALKED] <= 0) {
				outputText("You walk into an alley you swear you have never explored before. You stifle your fear as you walk into the dingy looking alley.");
				outputText("\n\nUnease creeps over you until you hear a raspy voice whisper from the darkness of the alley. You look around to see a hooded figure skulk from the shadows to approach you.");
				outputText("\n\n\"<i>Greetings. I know you. You’re going to be the new Champion, right?</i>\" The hooded figure croaks. His face is mostly concealed by the shade of his hood. Slightly unnerved by the prowling figure, you tell him that yes, you’re going to be the Champion of Ingnam.");
				outputText("\n\nHe pulls his hood down, quickly looking for the all-clear and rasps, \"<i>I’ve managed to sneak into the portal at the mountains. There is extraordinary stuff that can transform you! It takes me years of planning as the portal is only open for a short window of time before it closes for the rest of the year.</i>\"");
				outputText("\n\nWith a skin-crawling chuckle, he opens up his coat and shows you the array of goods and says, \"<i>I’ve managed to smuggle these in. They aren’t cheap but I guarantee you, they’re the real deal! See anything you like?</i>\"");
				flags[kFLAGS.INGNAM_BLACKMARKET_TALKED] = 1;
			}
			else {
				outputText("Once again, you walk into the alley where the shady dealer should be. He approaches you as if he knows you.");
				outputText("\n\n\"<i>Back, I see? See any deals you like?</i>\" The shady man asks.");
			}
			outputText("\n\n<b><u>Black market pricings</u></b>");
			menu();
			addShopItem(consumables.W_FRUIT, 75, 6);
			addShopItem(consumables.CANINEP, 75, 6);
			addShopItem(consumables.EQUINUM, 75, 6);
			addShopItem(consumables.INCUBID, 75, 6);
			addShopItem(consumables.SUCMILK, 75, 6);
			addShopItem(consumables.RINGFIG, 75, 6);
			addButton(14, "Leave", menuShops);
		}

		//Transaction for buying items.
		public function transactionItemConfirmation(item:ItemType, price:int, shop:int):void {
			clearOutput();
			outputText("\"<i>That will be " + num2Text(price) + " gems for " + item.longName + ".</i>\"");
			if (player.gems >= price) {
				outputText("\n\nDo you buy it?");
				menu();
				addButton(0, "Yes", transactionYes, item, price, shop);
				addButton(1, "No", transactionNo, shop);
			}
			else {
				outputText("\n\nYou count out your gems and realize it's beyond your price range.");
				menu();
				addButton(0, "Next", transactionNo, shop);
			}
		}
		public function transactionYes(item:ItemType, price:int, shop:int):void {
			//Determine shop
			var shopToGo:Function = null;
			if (shop == 1) shopToGo = shopBlacksmith;
			else if (shop == 2) shopToGo = shopBlacksmith;
			else if (shop == 3) shopToGo = shopTailor;
			else if (shop == 4) shopToGo = shopAlchemist;
			else if (shop == 5) shopToGo = shopTradingPost;
			else shopToGo = shopBlackMarket;
			//Process
			clearOutput();
			if (player.gems >= price) {
				outputText("You have purchased " + item.longName + " for " + price + " gems. ");
				player.gems -= price;
				menu();
				statScreenRefresh();
				inventory.takeItem(item, shopToGo);
			}
			else {
				outputText("You count out your gems and realize it's beyond your price range.");
				menu();
				addButton(0, "Next", transactionNo, shop);
			}
		}
		public function transactionNo(shop:int):void {
			if (shop == 1) shopBlacksmith();
			else if (shop == 2) shopBlacksmith();
			else if (shop == 3) shopTailor();
			else if (shop == 4) shopAlchemist();
			else if (shop == 5) shopTradingPost();
			else if (shop == 6) shopBlackMarket();
			else shopBlackMarket();
		}

		public function addShopItem(item:ItemType, price:int, shop:int):void {
			outputText("\n" + capitalizeFirstLetter(item.longName) + " - " + price + " gems");
			var button:int = 0;
			for (var i:int = 0; i < 14; i++) {
				if (buttonIsVisible(i)) button++;
			}
			addButton(button, item.shortName, transactionItemConfirmation, item, price, shop);
		}

		//Temple
		public function menuTemple():void {
			hideMenus();
			clearOutput();
			outputText(images.showImage("location-ingnam-temple"));
			outputText("The village’s temple appears humble looking from its stony exterior but the interior of the temple is truly a marvel to behold - intricately decorated wooden arches adorned with complex patterns of arcane runes of the Old World, walls adorned with majestic tapestries depicting the Gods and their most valiant of feats and, to the end of the temple stands an incredibly designed shrine to the All-Giving, the mother of all Gods.");
			outputText("\n\nIncense languorously wafts from the alcoves where offerings of fruit are left out for the Gods. Monks passively move amongst the parishioners, offering solace to those in need, food or drink to those who are weary, or in meditation.");
			outputText("\n\nThere are several soft mats on the floor to provide soft areas for people to pray on.");
			menu();
			addButton(0, "Meditate", SceneLib.masturbation.meditate);
			addButton(14, "Leave", menuIngnam);
		}

	}

}
