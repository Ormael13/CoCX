//Ingnam: The Prologue
package classes.Scenes.Places 
{
	import classes.*;
	import classes.GlobalFlags.*;
	import classes.Items.*;
	import classes.Scenes.Places.Ingnam.*;
	
	import coc.view.MainView;
	
	public class Ingnam extends BaseContent
	{
		public var ingnamFarm:IngnamFarm = new IngnamFarm();
		public var thiefScene:ThiefScene = new ThiefScene();
		
		public function get inIngnam():Boolean { return flags[kFLAGS.IN_INGNAM] > 0; }
		
		public function Ingnam() 
		{	
		}
		
		//Main Ingnam menu.
		public function menuIngnam():void {
			//Force autosave
			if (player.slotName != "VOID" && mainView.getButtonText(0) != "Game Over" && flags[kFLAGS.HARDCORE_MODE] > 0) 
			{
				trace("Autosaving to slot: " + player.slotName);
				
				getGame().saves.saveGame(player.slotName);
			}
			//Banished to Mareth.
			if (model.time.days >= 0 && flags[kFLAGS.INGNAM_PROLOGUE_COMPLETE] <= 0) {
				getBanishedToMareth();
				return;
			}
			clearOutput();
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
			mainView.setMenuButton( MainView.MENU_NEW_MAIN, "Main Menu", kGAMECLASS.mainMenu );
			mainView.newGameButton.toolTipText = "Return to main menu.";
			mainView.newGameButton.toolTipHeader = "Main Menu";
			if (camp.setLevelButton()) return;
			hideUpDown();
			menu();
			addButton(0, "Explore", exploreIngnam);
			addButton(1, "Shops", menuShops);
			addButton(2, "Temple", menuTemple);
			addButton(3, "Inn", menuTavern);
			addButton(4, "Farm", ingnamFarm.menuFarm);
			if (flags[kFLAGS.INGNAM_PROLOGUE_COMPLETE] > 0) addButton(5, "Return2Camp", returnToMareth);
			if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] > 0 && inventory.showStash() && flags[kFLAGS.INGNAM_PROLOGUE_COMPLETE] <= 0) addButton(6, "Stash", inventory.stash);
			addButton(7, "Inventory", inventory.inventoryMenu);
			if (player.lust >= 30) {
				if (player.lust >= player.maxLust()) {
					outputText("\n\n<b>You are debilitatingly aroused, and can think of doing nothing other than masturbating.</b>", false);
					removeButton(0);
					removeButton(4);
				}
				addButton(8, "Masturbate", kGAMECLASS.masturbation.masturbateMenu);
				if (((player.findPerk(PerkLib.HistoryReligious) >= 0 && player.cor <= 66) || (player.findPerk(PerkLib.Enlightened) >= 0 && player.cor < 10)) && !(player.findStatusEffect(StatusEffects.Exgartuan) >= 0 && player.statusEffectv2(StatusEffects.Exgartuan) == 0) || flags[kFLAGS.SFW_MODE] >= 1) addButton(8, "Meditate", kGAMECLASS.masturbation.masturbateMenu);
			}
			//Show wait/rest/sleep depending on conditions.
			addButton(9, "Wait", kGAMECLASS.camp.doWait);
			if (player.fatigue > 40 || player.HP / player.maxHP() <= .9) addButton(9, "Rest", getGame().camp.rest);
			if (model.time.hours >= 21 || model.time.hours < 6) {
				removeButton(0);
				removeButton(1);
				removeButton(2);
				removeButton(4);
				addButton(9, "Sleep", getGame().camp.doSleep);
			}
		}
		
		//The end of prologue, starts the game.
		public function getBanishedToMareth():void {
			var hasWeapon:Boolean = false;
			clearOutput();
			hideMenus();
			outputText("Your time has come to meet up with the village elders. You know you are going to get sent to the demon realm and you're most likely not going to be able to return to Ingnam. You give your family and friends a long farewell.");
			if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] == 0) { //Doesn't happen in New Game+.
				if (player.weaponName != "fists") {
					hasWeapon = true;
					player.setWeapon(WeaponLib.FISTS);
				}
				while (player.hasItem(weapons.DAGGER, 1)) {
					hasWeapon = true;
					player.destroyItems(weapons.DAGGER, 1);
				}
				while (player.hasItem(weapons.PIPE, 1)) {
					hasWeapon = true;
					player.destroyItems(weapons.PIPE, 1);
				}
				while (player.hasItem(weapons.SPEAR, 1)) {
					hasWeapon = true;
					player.destroyItems(weapons.SPEAR, 1);
				}
				while (player.hasItem(weapons.KATANA, 1)) {
					hasWeapon = true;
					player.destroyItems(weapons.KATANA, 1);
				}
				if (hasWeapon) outputText("\n\n<b>Unfortunately, you were instructed to leave your weapon behind.</b>");
			}
			flags[kFLAGS.IN_INGNAM] = 0;
			flags[kFLAGS.INGNAM_PROLOGUE_COMPLETE] = 1;
			doNext(kGAMECLASS.charCreation.arrival);
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
			var chooser:int = rand(4);
			if (chooser == 0) {
				thiefScene.encounterThief();
				return;
			}
			else {
				outputText("You explore the village of Ingnam for a while but you don't find anything intersting.");
			}
			doNext(camp.returnToCampUseOneHour);
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
			outputText("You enter the armor shop, noting the sign depicting armors. Some armor is proudly displayed on racks. You can hear the sound of hammering although it stops shortly after you enter. The local blacksmith, Ben, comes from the rear door and steps up to the counter and wipes away sweat from his face flushed red by the forge, \"<i>Welcome to my shop. In a need of protection? Or something sharp?</i>\"");
			if (flags[kFLAGS.INGNAM_WEAPONSMITH_TALKED] <= 0 && flags[kFLAGS.INGNAM_PROLOGUE_COMPLETE] <= 0) {
				outputText("\n\n\Before you can get a word in Ben lets out an exasperated sigh \"<i>Ah, just forget about…</i>\"");
				outputText("\n\nYou crook an eyebrow questioningly at the blacksmith. Ben then realizes his blunder.");
				outputText("\n\n\"<i>Ah, well it’s just… You’re the new Champion, right? None of the people I’ve seen who get sent to the portal brought a weapon and you would waste some gems. Still, if you want to train with weapons, you can go ahead and buy them. A little preparation never hurt anyone.</i>\" the blacksmith says.");
				flags[kFLAGS.INGNAM_WEAPONSMITH_TALKED] = 1;
			}
			outputText("\n\n<b><u>Blacksmith's pricings</u></b>");
			menu();
			if (player.findPerk(PerkLib.HistoryFighter) >= 0) { //20% discount for History: Fighter
				addShopItem(weapons.DAGGER, 32, 1);
				addShopItem(weapons.PIPE, 40, 1);
				addShopItem(weapons.SPEAR, 140, 1);
				addShopItem(weapons.KATANA, 200, 1);
				addShopItem(weapons.MACE, 80, 1);
			}
			else {
				addShopItem(weapons.DAGGER, 40, 1);
				addShopItem(weapons.PIPE, 50, 1);
				addShopItem(weapons.SPEAR, 175, 1);
				addShopItem(weapons.KATANA, 250, 1);
				addShopItem(weapons.MACE, 100, 1);
			}
			if (player.findPerk(PerkLib.HistorySmith) >= 0) { //20% discount for History: Smith perk
				addShopItem(armors.LEATHRA, 40, 2);
				addShopItem(armors.FULLCHN, 120, 2);
				addShopItem(armors.SCALEML, 160, 2);
			}
			else {
				addShopItem(armors.LEATHRA, 50, 2);
				addShopItem(armors.FULLCHN, 150, 2);
				addShopItem(armors.SCALEML, 200, 2);
			}
			addButton(14, "Leave", menuShops);
		}
		
		public function shopTailor():void {
			clearOutput();
			outputText("You enter the tailor’s. The interior is laden with mannequins wearing half-finished works. Clothes are displayed on racks without obvious flaws. A fastidious, well-groomed young man with an immaculate blue three-piece suit topped with a measuring tape draping around his collar stands behind the counter and smiles at you with deference.");
			outputText("\n\n\"<i>Welcome to my shop. Do you need to get outfitted?</i>\" he says pulling keenly at the measuring tape draping his shoulders.");
			outputText("\n\n<b><u>Tailor shop pricings</u></b>");
			menu();
			addShopItem(armors.C_CLOTH, 10, 3);
			addShopItem(armors.ADVCLTH, 75, 3);
			addShopItem(armors.CLSSYCL, 100, 3);
			addShopItem(armors.TUBETOP, 40, 3);
			addShopItem(armors.OVERALL, 30, 3);
			addShopItem(armors.M_ROBES, 75, 3);
			addShopItem(armors.LTHRPNT, 200, 3);
			addShopItem(armors.RBBRCLT, 500, 3);
			addShopItem(armors.T_BSUIT, 650, 3);
			addButton(14, "Leave", menuShops);
		}
		
		public function shopAlchemist():void {
			clearOutput();
			if (flags[kFLAGS.INGNAM_ALCHEMIST_TALKED] <= 0) {
				outputText("As you approach the stone building the overpowering smell of herbs and plants being brewed hits your nose. The crimson banner over the heavy wooden door indicates that this is where the potions are made. You enter what appears to be the place where the alchemist works on his famed remedies.");
				outputText("\n\nYou open the door and enter. Despite the establishment being dimly lit by candlelight you can make out the vast multicolored rows of countless potions, elixirs and tonics. Fragrant drying herbs are hanging from the rafters and various strange-looking equipment is set up in a variety of locations in the store.");
				outputText("\n\nAn ancient-looking man in a much-singed pair of robes is working on something volatile in the corner until he hears your presence. He stops and shuffles up to the timber counter, drumming it under his stained fingers. \"<i>What can I do for you, young master?</i>\" he says from under his frayed hood.");
				flags[kFLAGS.INGNAM_ALCHEMIST_TALKED] = 1;
			}
			else {
				outputText("Once again, you return to the alchemist, letting the overpowering smell of herbs and plants being brewed hits your nose.");
				outputText("\n\nThe alchemist senses your presences and he steps up to the counter and says, \"<i>How may I help you?</i>\"");
			}
			outputText("\n\n<b><u>Alchemy shop pricings</u></b>");
			menu();
			if (player.findPerk(PerkLib.HistoryAlchemist) >= 0) { //20% discount for History: Alchemist perk
				addShopItem(consumables.REDUCTO, 80, 4);
				addShopItem(consumables.GROPLUS, 80, 4);
				addShopItem(consumables.L_DRAFT, 25, 4);
				addShopItem(consumables.LACTAID, 40, 4);
			}
			else {
				addShopItem(consumables.REDUCTO, 100, 4);
				addShopItem(consumables.GROPLUS, 100, 4);
				addShopItem(consumables.L_DRAFT, 30, 4);
				addShopItem(consumables.LACTAID, 50, 4);
			}
			addButton(14, "Leave", menuShops);
		}
		
		public function shopTradingPost():void {
			clearOutput();
			outputText("The trading post is one of the larger buildings in the village with its porch covered in barrels filled with pickled goods, preserved delicacies and dried goods from the humble local farm to exotic faraway lands. The interior is packed with crowded shelves that boast a variety of goods, all arranged neatly on shelves.");
			outputText("\n\nYou suspect you could buy some imported goods here.");
			outputText("\n\n<b><u>Trading post pricings</u></b>");
			menu();
			addShopItem(consumables.VITAL_T, 30, 5);
			addShopItem(consumables.SMART_T, 30, 5);
			addShopItem(consumables.FISHFIL, 5, 5);
			addButton(14, "Leave", menuShops);
		}
		
		public function shopBlackMarket():void {
			clearOutput();
			if (flags[kFLAGS.INGNAM_BLACKMARKET_TALKED] <= 0) {
				outputText("You walk into an alley you swear you have never explored before. You stifle your fear as you walk into the dingy looking alley.");
				outputText("\n\nUnease creeps over you until you hear a raspy voice whisper from the darkness of the alley. You look around to see a hooded figure skulk from the shadows to approach you.");
				outputText("\n\n\"<i>Greetings. I know you. You’re going to be the new Champion, right?</i>\" The hooded figure croaks. His face is mostly concealed by the shade of his hood. Slightly unnerved by the prowling figure you tell him that yes, you’re going to be the Champion of Ingnam.");
				outputText("\n\nHe pulls his hood down, quickly looking for the all-clear and rasps, \"<i>I’ve managed to sneak into the portal at the mountains. There is extraordinary stuff that can transform you! It takes me years of planning as the portal is only open for a short window of time before it closes for the rest of the year.</i>\"");
				outputText("\n\nWith a skin-crawling chuckle he opens up his coat and shows you the array of goods and says, \"<i>I’ve managed to smuggle these in. They aren’t cheap but I guarantee you, they’re the real deal! See anything you like?</i>\"");
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
				menu()
				addButton(0, "Next", transactionNo, shop);
			}
		}
		public function transactionYes(item:ItemType, price:int, shop:int):void {
			//Determine shop
			var shopToGo:Function = null
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
			outputText("The village’s temple appears humble looking from its stony exterior but the interior of temple is truly a marvel to behold - intricately decorated wooden arches adorned with complex patterns of arcane runes of the Old World, walls adorned with majestic tapestries depicting the Gods and their most valiant of feats and, to the end of the temple stands an incredibly designed shrine to the All-Giving, the mother of all Gods.");
			outputText("\n\nIncense languorously wafts from the alcoves where offerings of fruit are left out for the Gods. Monks passively move amongst the parishioners, offering solace to those in need, food or drink to those who are weary, or in meditation.");
			outputText("\n\nThere are several soft mats on the floor to provide soft areas for people to pray on.");
			menu();
			addButton(0, "Meditate", kGAMECLASS.masturbation.meditate);
			addButton(14, "Leave", menuIngnam);
		}
		
		//Tavern
		public function menuTavern():void {
			hideMenus();
			clearOutput();
			outputText(images.showImage("location-ingnam-inn"));
			outputText("The inn is a cozy little nook that exudes a warm and welcoming air. You see several guardsmen roaring with laughter over a few steins and a hand of cards, and some townsfolk chatting about random topics. The innkeeper stands behind the polished wooden counter, serving beverages to his patrons and cleaning up spilled drinks.");
			if (flags[kFLAGS.INGNAM_PROLOGUE_COMPLETE] > 0 && flags[kFLAGS.INGNAM_GREETED_AFTER_LONGTIME] <= 0) {
				welcomeBack();
			}
			if ((player.earType > 0 && player.earType != flags[kFLAGS.INGNAM_EARS_LAST_TYPE] && flags[kFLAGS.INGNAM_EARS_FREAKOUT] <= 0) || (player.tailType > 0 && player.tailType != flags[kFLAGS.INGNAM_TAIL_LAST_TYPE] && flags[kFLAGS.INGNAM_TAIL_FREAKOUT] <= 0) && flags[kFLAGS.INGNAM_PROLOGUE_COMPLETE] <= 0) {
				appearanceFreakout();
				return;
			}
			menu();
			addButton(0, "Order Drink", orderDrink, null, null, null, "Buy some refreshing beverages.");
			addButton(1, "Order Food", orderFood, null, null, null, "Buy some food" + (flags[kFLAGS.HUNGER_ENABLED] > 0 && player.hunger < 50 ? " and curb that hunger of yours!": ".") + "");
			if (flags[kFLAGS.INGNAM_RUMORS] < 3) addButton(2, "Stories", hearRumors, null, null, null, "Hear the story the innkeeper has to offer.");
			//if (player.findPerk(PerkLib.HistoryWhore) >= 0) addButton(5, "Prostitute", whoreForGems, null, null, null, "Seek someone who's willing to have sex with you for profit.");
			addButton(14, "Leave", menuIngnam);
		}
		
		public function welcomeBack():void {
			clearOutput();
			outputText("The innkeeper looks at you and says, \"<i>Welcome back! I've missed you! How did your adventures go?</i>\"");
			outputText("\n\nYou tell the innkeeper about your adventures and how you've met various denizens in Mareth.\n\n");
			if (flags[kFLAGS.TIMES_TRANSFORMED] <= 0) outputText("The innkeeper looks at you in awe and says, \"<i>Wow, you haven't changed at all! How did you manage to stay in that strange realm for years and still be normal?</i>\""); 
			else if (player.race() == "human") {
				outputText("The innkeeper looks at you and says, \"<i>I can see that you have changed a bit.</i>\" ");
			}
			else {
				outputText("The innkeeper looks at you and says, \"<i>I can see that you have changed quite a lot! Back then, before you left, you were a human. Now look at yourself!</i>\"");
			}
			if (player.horns > 0 && player.hornType > 0) {
				outputText("\n\n\"<i>Are these " + (player.hornType == HORNS_ANTLERS ? "antlers" : "horns") + "? I can imagine they must be real,</i>\" The innkeeper says before touching your [horns]. You can already feel his fingers rubbing against your [horns]. \"<i>Yes, they're real and I think you look better,</i>\" he says. You thank him for complimenting on your horns.");
			}
			if (player.wingType > 0 && player.wingType != WING_TYPE_SHARK_FIN) {
				outputText("\n\nNext, he looks at your wings that sprout from your back and says, \"<i>Wings? I've never seen a person with wings before!</i>\" ");
				if (player.canFly()) outputText("You tell him that you can fly. To demonstrate, you guide the innkeeper outside and you grit your teeth with effort as you flap your wings and you finally launch off from the ground and fly around the town! The people of Ingnam, including your family and friends, look at you in shock and some even say, \"<i>" + player.mf("He", "She") + " can fly!</i>\"");
			}
			outputText("\n\nPLACEHOLDER.");
			flags[kFLAGS.INGNAM_GREETED_AFTER_LONGTIME] = 1;
			doNext(menuTavern);
		}
		
		public function appearanceFreakout():void {
			clearOutput();
			outputText("The innkeeper stands up to see that there's something unusual with your appearance.");
			if (player.earType > 0) {
				if (player.earType == EARS_HORSE) {
					outputText("\n\nHe says, \"<i>Your ears... They look different! They look like horse's! I have no idea how your ears changed.</i>\"");
				}
				if (player.earType == EARS_DOG) {
					outputText("\n\nHe says, \"<i>Your ears... They look like dog's! I have no idea how your ears changed.</i>\"");
				}
				if (player.earType == EARS_CAT) {
					outputText("\n\nHe says, \"<i>Your ears... They look like cat's! I have no idea how your ears changed but other than that, you look much cuter with cat ears!</i>\" He walks over to you and scratch your cat-ears. \"<i>They look and feel so real,</i>\" he says.");
				}
				flags[kFLAGS.INGNAM_EARS_LAST_TYPE] = player.earType;
				flags[kFLAGS.INGNAM_EARS_FREAKOUT] = 1;
			}
			if (player.earType > 0 && player.tailType > 0 && player.hasLongTail()) outputText("Next, he walks behind you, taking a glance at your tail.");
			if (player.tailType > 0) {
				if (player.hasLongTail()) {
					outputText("\n\nHe says with a surprised look, \"<i>You have a tail now? Are you sure this is fake?</i>\" You tell him that your tail is not fake; it's real. \"<i>Prove it,</i>\" he says as he tugs your tail. Ouch! That hurts! \"<i>Sorry about that,</i>\" he says, \"<i>but that tail definitely looks and feels real! I think your tail does look nice.</i>\"");
					outputText("\n\nYou wag your tail and thank him for the compliment and he walks behind the counter.");
				}
				flags[kFLAGS.INGNAM_TAIL_LAST_TYPE] = player.tailType;
				flags[kFLAGS.INGNAM_TAIL_FREAKOUT] = 1;
			}
			doNext(menuTavern);
		}

		
		public function orderDrink():void {
			clearOutput();
			outputText("What kind of drink would you like?");
			outputText("\n\n<b><u>Pricings</u></b>");
			outputText("\n5 gems - Beer");
			outputText("\n2 gems - Milk");
			outputText("\n3 gems - Root Beer");

			menu();
			addButton(0, "Beer", buyBeer);
			addButton(1, "Milk", buyMilk);
			addButton(2, "Root Beer", buyRootBeer);
			addButton(14, "Back", menuTavern);
		}
		
		public function buyBeer():void {
			clearOutput();
			if (player.gems < 5) {
				outputText("You don't have enough gems for that.");
				doNext(orderDrink);
				return;
			}
			player.gems -= 5;
			outputText("\"<i>I'd like a glass of beer please,</i>\" you say. You hand over the five gems to the innkeeper and he pours you a glass of beer.");
			outputText("\n\nYou kick back and drink the beer slowly. ");
			dynStats("lus", 20);
			player.refillHunger(10);
			if (player.findStatusEffect(StatusEffects.Drunk) < 0) {
				player.createStatusEffect(StatusEffects.Drunk, 2, 1, 1, 0);
				dynStats("str", 0.1);
				dynStats("inte", -0.5);
				dynStats("lib", 0.25);
			}
			else {
				player.addStatusValue(StatusEffects.Drunk, 2, 1);
				if (player.statusEffectv1(StatusEffects.Drunk) < 2) player.addStatusValue(StatusEffects.Drunk, 1, 1);
				if (player.statusEffectv2(StatusEffects.Drunk) == 2) {
					outputText("\n\n<b>You feel a bit drunk. Maybe you should cut back on the beers?</b>");
				}
				//Get so drunk you end up peeing! Genderless can still urinate.
				if (player.statusEffectv2(StatusEffects.Drunk) >= 3) {
					outputText("\n\nYou feel so drunk. Your vision is blurry and you realize something's not feeling right. Gasp! You have to piss like a racehorse! You stumble toward the back door and go outside. ")
					if (player.hasVagina() && !player.hasCock()) outputText("You open up your [armor] and squat down while you release your pressure onto the ground. ");
					else outputText("You open up your [armor] and lean against the wall using one of your arms for support while you release your pressure onto the wall. ");
					outputText("It's like as if the floodgate has opened! ");
					awardAchievement("Urine Trouble", kACHIEVEMENTS.GENERAL_URINE_TROUBLE, true, true, false);
					awardAchievement("Smashed", kACHIEVEMENTS.GENERAL_SMASHED, true, true, false);
					outputText("\n\nIt seems to take forever but it eventually stops. You look down to see that your urine has been absorbed into the ground. You close up your [armor] and head back inside.");
					player.removeStatusEffect(StatusEffects.Drunk);
					cheatTime(1/12);
				}
			}
			cheatTime(1/12);
			doNext(menuTavern);
		}
		public function buyMilk():void {
			clearOutput();
			if (player.gems < 2) {
				outputText("You don't have enough gems for that.");
				doNext(orderDrink);
				return;
			}
			player.gems -= 2;
			outputText("\"<i>I'd like a glass of milk please,</i>\" you say. You hand over the two gems to the innkeeper and he pours you a glass of milk.");
			outputText("\n\nYou drink the cup of milk. You feel calm and refreshed. ");
			player.changeFatigue(-15);
			HPChange(player.maxHP() / 4, false);
			player.refillHunger(10);
			cheatTime(1/12);
			doNext(menuTavern);
		}
		public function buyRootBeer():void {
			clearOutput();
			if (player.gems < 3) {
				outputText("You don't have enough gems for that.");
				doNext(orderDrink);
				return;
			}
			player.gems -= 3;
			outputText("\"<i>I'd like a glass of root beer please,</i>\" you say. You hand over the three gems to the innkeeper and he pours you a glass of root beer.");
			outputText("\n\nYou drink the cup of root beer. Refreshing! ");
			player.changeFatigue(-15);
			HPChange(player.maxHP() / 4, false);
			player.refillHunger(10);
			cheatTime(1/12);
			doNext(menuTavern);
		}
		
		public function orderFood():void { //Order food, because you need to be able to fill hunger.
			clearOutput();
			outputText("You take a seat and look at the menu. What would you like?");
			outputText("\n\n<b><u>Pricings</u></b>");
			outputText("\n5 gems - Sandwich");
			outputText("\n3 gems - Soup");
			outputText("\n5 gems - Hard biscuits (Packed)");
			outputText("\n10 gems - Trail mix (Packed)");
			menu();
			addButton(0, "Sandwich", buySandwich);
			addButton(1, "Soup", buySoup);
			addButton(2, "Biscuits", buyHardBiscuits);
			addButton(3, "Trail Mix", buyTrailMix);
			addButton(14, "Back", menuTavern);
		}
		
		public function buySandwich():void { //Eat sandwich, refill hunger. The reason it's ambiguous is to let you imagine what sandwich you're eating.
			clearOutput();
			if (player.gems < 5) {
				outputText("You don't have enough gems for that.");
				doNext(orderDrink);
				return;
			}
			player.gems -= 5;
			outputText("You tell the innkeeper that you would like a sandwich and toss five gems at him. \"<i>Certainly, " + player.mf("sir", "madam") + ",</i>\" he says as he quickly grabs a plate and assembles a sandwich. Hey, it's your favorite type!");
			outputText("\n\nYou eat the sandwich. Delicious!");
			HPChange(player.maxHP() / 3, false);
			player.refillHunger(25);
			cheatTime(1/12);
			doNext(menuTavern);
		}
		
		public function buySoup():void { //Eat soup. Again, it's vague to let you imagine what soup you're eating.
			clearOutput();
			if (player.gems < 3) {
				outputText("You don't have enough gems for that.");
				doNext(orderDrink);
				return;
			}
			player.gems -= 3;
			outputText("You tell the innkeeper that you would like a bowl of soup and toss three gems at him. \"<i>Certainly, " + player.mf("sir", "madam") + ",</i>\" he says as he grabs a bowl and fills it with steaming soup. Hey, it's your favorite type!");
			outputText("\n\nYou take one spoonful at a time, blowing to make sure the soup isn't too hot. You eventually finish the soup. Delicious!");
			HPChange(player.maxHP() / 3, false);
			player.refillHunger(20);
			cheatTime(1/12);
			doNext(menuTavern);
		}
		
		private function buyHardBiscuits():void {
			clearOutput();
			if (player.gems < 5) {
				outputText("You can't afford one of those!");
				doNext(orderFood);
				return;
			}
			outputText("You pay five gems for a pack of hard biscuits.  ");
			player.gems -= 5;
			statScreenRefresh();
			inventory.takeItem(consumables.H_BISCU, orderFood);
		}

		private function buyTrailMix():void {
			clearOutput();
			if (player.gems < 10) {
				outputText("You can't afford one of those!");
				doNext(orderFood);
				return;
			}
			outputText("You pay twenty gems for a pack of trail mix.  ");
			player.gems -= 10;
			statScreenRefresh();
			inventory.takeItem(consumables.TRAILMX, orderFood);
		}
		
		public function hearRumors():void { //Hear rumors. Will be altered after defeating Lethice so he will say "Welcome back".
			clearOutput();
			var rumor:int = rand(4);
			outputText("You ask the innkeeper if he has anything special to tell you.");
			if (flags[kFLAGS.INGNAM_RUMORS] == 0) {
				outputText("\n\nHe nods and says, \"<i>Let me tell you. You know what happens to the so-called 'champions'?</i>\" ");
				outputText("\n\nYou nod in response and he continues, \"<i>Well... Nobody ever came. I've seen twenty people departing over the course of my career. Twenty years. None of them ever returned. Who knows what happened to them? Some say they're abducted by an evil presence as soon as they set foot into the portal.</i>\"");
				outputText("\n\nHe looks at you and sniffles. \"<i>Truth be told, you're going to be the Champion of Ingnam. You will be sent to the so-called 'portal' that is supposedly located in Mount Ilgast. I will miss your patronage at the inn. You're still welcome anytime.</i>\"");
				flags[kFLAGS.INGNAM_RUMORS] = 1;
			}
			else if (flags[kFLAGS.INGNAM_RUMORS] == 1) {
				outputText("\n\nHe nods and says, \"<i>You know Mount Ilgast?</i>\" ");
				outputText("\n\nYou nod in response and he continues, \"<i>Before I began my work as an innkeeper, I was an adventurer. I've explored Mount Ilgast once. There was something glowing. It's a portal but it's no ordinary portal. Even strange was that there was something stirring in my groin. Honestly, I swear I never felt that sensation before. I winded up masturbating at the cave entrance just because of that warmth. As soon as I go near the portal, the warm sensation came back again. It's just strange, really strange. So I've hurried back to Ingnam and never visited the mountain again.</i>\"");
				outputText("\n\nYou thank him for telling you.");
				flags[kFLAGS.INGNAM_RUMORS] = 2;
			}
			else if (flags[kFLAGS.INGNAM_RUMORS] == 2) {
				outputText("\n\nHe nods and says, \"<i>Would you really like to know something special?</i>\" You nod in response and he continues, \"<i>One time I've seen a man with cat ears and a tail. I thought they were just accessories but he insisted it was real. So I tugged on his ears and it was... real. I thought he used a lot of glue but he insisted that it's real. His ears do feel real. His tail even swished from side to side like it's an actual cat tail. He told me about something called 'Whisker Fruit' or something. So my guess is that the food in the so-called 'demon realm' can change you.</i>\"");
				outputText("\n\nYou tell him if he has some tips for you. He says, \"<i>Yes. If I were you, I would eat them only as last resort. Even a food that could transform you can make the difference between life and death.</i>\" You thank him for the advice.");
				outputText("\n\n\"<i>You're welcome. I have nothing left to tell you but you're always welcome,</i>\" he says.");
				flags[kFLAGS.INGNAM_RUMORS] = 3; //Finished
			}
			doNext(camp.returnToCampUseOneHour);
		}
		
	}

}