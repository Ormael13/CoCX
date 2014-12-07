//Ingnam: The Prologue
package classes.Scenes.Places 
{
	import classes.*;
	import classes.GlobalFlags.*;
	import classes.Items.*;
	
	import coc.view.MainView;
	
	public class Ingnam extends BaseContent
	{
		
		public function Ingnam() 
		{	
		}
		
		//Main Ingnam menu.
		public function menuIngnam():void {
			kGAMECLASS.tooltipLoc = "Ingnam";
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
			outputText("Ingnam is a rich and prosperous village for its small size.  There is already a good deal of shops.  Temple is established in a district located just across from the shops.  The tavern serves as the hub for people near and far to drink and dance.  One of the paths leads to the large farm.");
			outputText("\n\nIn the distance is a mountain known by the locals as Mount Ilgast.  Surrounding Ingnam is a vast expanse of wilderness.  ");
			if (model.time.hours >= 21 || model.time.hours < 6) outputText("\n\nIt's dark outside.  Stars dot the night sky and a moon casts the moonlight, providing little light.  Shops are closed at this time.");
			mainView.showMenuButton( MainView.MENU_NEW_MAIN );
			mainView.showMenuButton( MainView.MENU_DATA );
			mainView.showMenuButton( MainView.MENU_STATS );
			mainView.showMenuButton( MainView.MENU_PERKS );
			mainView.showMenuButton( MainView.MENU_APPEARANCE );
			showStats();
			mainView.setMenuButton( MainView.MENU_NEW_MAIN, "Main Menu", kGAMECLASS.mainMenu );
			if(player.XP >= (player.level) * 100 || player.perkPoints > 0 || player.statPoints > 0) {
				if (player.XP < player.level * 100)
				{
					if (player.statPoints > 0) mainView.setMenuButton( MainView.MENU_LEVEL, "Stat Up" );
					else mainView.setMenuButton( MainView.MENU_LEVEL, "Perk Up" );
				}
				else
					mainView.setMenuButton( MainView.MENU_LEVEL, "Level Up" );
				mainView.showMenuButton( MainView.MENU_LEVEL );
				mainView.statsView.showLevelUp();
			}
			else {
				mainView.hideMenuButton( MainView.MENU_LEVEL );
				mainView.statsView.hideLevelUp();
			}
			hideUpDown();
			menu();
			//addButton(0, "Explore", exploreIngnam);
			addButton(1, "Shops", menuShops);
			addButton(2, "Temple", menuTemple);
			addButton(3, "Inn", menuTavern);
			addButton(4, "Farm", menuFarm);
			if (flags[kFLAGS.INGNAM_PROLOGUE_COMPLETE] > 0) addButton(6, "Return2Camp", getBanishedToMareth);
			addButton(7, "Inventory", inventory.inventoryMenu);
			if (player.lust >= 30) {
				if (player.lust >= 100) {
					outputText("\n\n<b>You are debilitatingly aroused, and can think of doing nothing other than masturbating.</b>", false);
					removeButton(0);
					removeButton(4);
				}
				addButton(8, "Masturbate", eventParser, 42);
				if (((player.findPerk(PerkLib.HistoryReligious) >= 0 && player.cor <= 66) || (player.findPerk(PerkLib.Enlightened) >= 0 && player.cor < 10)) && !(player.findStatusAffect(StatusAffects.Exgartuan) >= 0 && player.statusAffectv2(StatusAffects.Exgartuan) == 0) || flags[kFLAGS.SFW_MODE] >= 1) addButton(8, "Meditate", eventParser, 42);
			}
			//Show wait/rest/sleep depending on conditions.
			addButton(9, "Wait", eventParser, 40);
			if (player.fatigue > 40 || player.HP / player.maxHP() <= .9) addButton(9, "Rest", eventParser, 11);
			if (model.time.hours >= 21 || model.time.hours < 6) {
				removeButton(0);
				removeButton(1);
				removeButton(2);
				removeButton(4);
				addButton(9, "Sleep", eventParser, 41);
			}
		}
		
		//The end of epilogue, starts the game.
		public function getBanishedToMareth():void {
			var hasWeapon:Boolean = false;
			clearOutput();
			outputText("Your time has come.  It's time for you to meet up with the village elders.  You know you are going to get sent to the demon realm and you're most likely not going to return to Ingnam.  You give your family and friends a long farewell.");
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
			flags[kFLAGS.IN_INGNAM] = 0;
			flags[kFLAGS.INGNAM_PROLOGUE_COMPLETE] = 1;
			doNext(kGAMECLASS.charCreation.getBanishedToMarethForReal);
		}
		
		//Explore Ingnam
		public function exploreIngnam():void {
			hideMenus();
			clearOutput();
			outputText("Placeholder");
			doNext(camp.returnToCampUseOneHour);
		}
		
		//Shopping time!
		public function menuShops():void {
			hideMenus();
			clearOutput();
			outputText("Which shop would you like to visit?");
			menu();
			addButton(0, "Weapon Shop", shopWeapon);
			addButton(1, "Armor Shop", shopArmor);
			addButton(2, "Tailor", shopTailor);
			addButton(3, "Alchemist", shopAlchemist);
			addButton(4, "Trading Post", shopTradingPost);
			addButton(5, "Black Market", shopBlackMarket);
			addButton(14, "Back", menuIngnam);
		}
		
		public function shopWeapon():void {
			clearOutput();
			outputText("You enter the weapon shop, easily indicated by the sign depicting a sword.  A weaponsmith stands at the counter.  You approach him and he says, \"<i>Hi there.</i>\"");
			if (flags[kFLAGS.INGNAM_WEAPONSMITH_TALKED] <= 0 && flags[kFLAGS.INGNAM_PROLOGUE_COMPLETE] <= 0) {
				outputText("\n\n\"<i>I do sell weapons but I suggest you don't buy weapons. None of the people I've seen who get sent to the portal brought a weapon and you would waste some gems.  Still, if you want to train with weapons, you can go ahead and buy them,</i>\" the blacksmith says.");
				flags[kFLAGS.INGNAM_WEAPONSMITH_TALKED] = 1;
			}
			outputText("\n\n\"<i>So, do you want to buy anything?</i>\"");
			outputText("\n\n<b><u>Weapon shop pricings</u></b>");
			menu();
			if (player.findPerk(PerkLib.HistoryFighter) >= 0) { //20% discount for History: Fighter
				addShopItem(weapons.DAGGER, 32, 1);
				addShopItem(weapons.PIPE, 40, 1);
				addShopItem(weapons.SPEAR, 140, 1);
				addShopItem(weapons.KATANA, 200, 1);
			}
			else {
				addShopItem(weapons.DAGGER, 40, 1);
				addShopItem(weapons.PIPE, 50, 1);
				addShopItem(weapons.SPEAR, 175, 1);
				addShopItem(weapons.KATANA, 250, 1);
			}
			addButton(14, "Leave", menuShops);
		}
		
		public function shopArmor():void {
			clearOutput();
			outputText("You enter the armor shop, noting the sign depicting armors.  Few armors are proudly displayed on racks.  You can hear the sound of hammering although it stops shortly after you enter.  A male blacksmith comes from the rear door and steps up to the counter and says, \"<i>Welcome to the armor shop.  In a need of protection?</i>\"");
			outputText("\n\n<b><u>Armor shop pricings</u></b>");
			menu();
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
			outputText("You enter the tailor shop.  The interior is well-maintained and decorated.  Clothes are displayed on racks without obvious flaws.  A woman behind the counter smiles at you with greet.  ");
			outputText("\n\nShe says, \"<i>Welcome to my shop.  Need to get outfitted?</i>\"");
			outputText("\n\n<b><u>Tailor shop pricings</u></b>");
			menu();
			addShopItem(armors.C_CLOTH, 10, 3);
			addShopItem(armors.ADVCLTH, 75, 3);
			addShopItem(armors.TUBETOP, 40, 3);
			addShopItem(armors.OVERALL, 30, 3);
			addShopItem(armors.M_ROBES, 75, 3);
			addShopItem(armors.RBBRCLT, 500, 3);
			addButton(14, "Leave", menuShops);
		}
		
		public function shopAlchemist():void {
			clearOutput();
			if (flags[kFLAGS.INGNAM_ALCHEMIST_TALKED] <= 0) {
				outputText("The smell of potions being brewed hits your nose as you approach the door.  The sign indicates that this is where the potions are made.  You enter what appears to be the place where the alchemist works on potions.");
				outputText("\n\nYou open the door and enter.  Various alchemy equipment are set up in various locations.");
				outputText("\n\nA male alchemist is working on something until he hears your presence.  He stops and walks up to the counter.  \"<i>Welcome to my shop,</i>\" he says.");
				flags[kFLAGS.INGNAM_ALCHEMIST_TALKED] = 1;
			}
			else {
				outputText("Once again, you return to the alchemist.");
				outputText("\n\nThe alchemist senses your presences and he steps up to the counter and says, \"<i>How may I help you?</i>\"");
			}
			outputText("\n\n<b><u>Alchemy shop pricings</u></b>");
			menu();
			if (player.findPerk(PerkLib.HistoryAlchemist) >= 0) { //20% discount for History: Alchemist perk
				addShopItem(consumables.REDUCTO, 80, 4);
				addShopItem(consumables.GROPLUS, 80, 4);
				addShopItem(consumables.L_DRAFT, 25, 4);
			}
			else {
				addShopItem(consumables.REDUCTO, 100, 4);
				addShopItem(consumables.GROPLUS, 100, 4);
				addShopItem(consumables.L_DRAFT, 30, 4);
			}
			addButton(14, "Leave", menuShops);
		}
		
		public function shopTradingPost():void {
			clearOutput();
			outputText("The trading post contains a variety of goods, all arranged neatly on shelves.  You suspect you could buy some imported goods here.");
			outputText("\n\n<b><u>Trading post pricings</u></b>");
			menu();
			addShopItem(consumables.VITAL_T, 30, 5);
			addShopItem(consumables.SMART_T, 30, 5);
			addButton(14, "Leave", menuShops);
		}
		
		public function shopBlackMarket():void {
			clearOutput();
			if (flags[kFLAGS.INGNAM_BLACKMARKET_TALKED] <= 0) {
				outputText("You walk into an alley you swear you have never explored before.  You swallow your pride as you walk into the alley.");
				outputText("\n\nYou have an uneasy feeling until you hear a voice.  You look around to see that a hooded figure walks from the shadows to approach you.");
				outputText("\n\n\"<i>Greetings.  I know you.  You're going to be the Champion, right?</i>\" The hooded figure says.  His face is concealed by the shade of his hood.  You tell him that yes, you're going to be the Champion of Ingnam.");
				outputText("\n\nHe pulls his hood down and says, \"<i>I've managed to sneak into the portal at the mountains.  There are extraordinary stuff that can transform you.  I've managed to smuggle these goods.  It takes me years of plannings as the portal is only open for a period of time before it closes for the rest of the year.</i>\"  He opens up his coat and shows you the array of goods and says, \"<i>They aren't cheap but I can guarantee, they are the real stuff!  See anything you would like?</i>\"");
				flags[kFLAGS.INGNAM_BLACKMARKET_TALKED] = 1;
			}
			else {
				outputText("Once again, you walk into the alley where the shady dealer should be.  He approaches you as if he knows you.");
				outputText("\n\n\"<i>Back, I see?  See any deals you like?</i>\" The shady man asks.");
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
			if (shop == 1) shopToGo = shopWeapon;
			else if (shop == 2) shopToGo = shopArmor;
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
			if (shop == 1) shopWeapon();
			else if (shop == 2) shopArmor();
			else if (shop == 3) shopTailor();
			else if (shop == 4) shopAlchemist();
			else if (shop == 5) shopTradingPost();
			else shopBlackMarket();
		}
		
		public function addShopItem(item:ItemType, price:int, shop:int):void {
			outputText("\n" + price + " gems - " + item.longName + "");
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
			outputText("The interior of temple is intricately decorated.  There are several mats on the floor to provide soft areas for people to pray on.");
			menu();
			addButton(0, "Meditate", startMeditate);
			addButton(14, "Leave", menuIngnam);
		}
		
		public function startMeditate():void {
			if (player.findPerk(PerkLib.HistoryReligious) >= 0) dynStats("lib", -0.5, "cor", -0.5); //Bonus points for religious perks.
			flags[kFLAGS.FORCE_MEDITATE] = 1; //Sets flag to 1 to force meditate. The flag itself is set to 0 after meditate is done.
			eventParser(42); //Fires the event.
		}
		
		//Tavern
		public function menuTavern():void {
			hideMenus();
			clearOutput();
			outputText("The inn is a nice place to be in.  You see several people drinking and chatting about random topics.  The innkeeper stands behind the wooden counter, serving beverages and cleaning.");
			if ((player.earType > 0 && player.earType != flags[kFLAGS.INGNAM_EARS_LAST_TYPE] && flags[kFLAGS.INGNAM_EARS_FREAKOUT] <= 0) || (player.tailType > 0 && player.tailType != flags[kFLAGS.INGNAM_TAIL_LAST_TYPE] && flags[kFLAGS.INGNAM_TAIL_FREAKOUT] <= 0)) {
				appearanceFreakout();
				return;
			}
			menu();
			addButton(0, "Order Drink", orderDrink, null, null, null, "Buy some refreshing beverages.");
			addButton(1, "Order Food", orderFood, null, null, null, "Buy some food" + (flags[kFLAGS.HUNGER_ENABLED] > 0 && player.hunger < 50 ? " and curb that hunger of yours!": ".") + "");
			if (flags[kFLAGS.INGNAM_RUMORS] < 3) addButton(2, "Stories", hearRumors, null, null, null, "Hear the story the innkeeper has to offer.");
			//if (player.findPerk(PerkLib.HistoryWhore) >= 0) addButton(5, "Prostitute", eventParser, 9999, null, null, "Seek someone who's willing to have sex with you for profit.");
			addButton(14, "Leave", menuIngnam);
		}
		
		public function appearanceFreakout():void {
			clearOutput();
			outputText("The innkeeper stands up to see that there's something unusual with your appearance.");
			if (player.earType > 0) {
				if (player.earType == EARS_HORSE) {
					outputText("\n\nHe says, \"<i>Your ears... They look different!  They look like horse's!  I have no idea how your ears changed.</i>\"");
				}
				if (player.earType == EARS_DOG) {
					outputText("\n\nHe says, \"<i>Your ears... They look like dog's!  I have no idea how your ears changed.</i>\"");
				}
				if (player.earType == EARS_CAT) {
					outputText("\n\nHe says, \"<i>Your ears... They look like cat's!  I have no idea how your ears changed but other than that, you look much cuter with cat ears!</i>\"  He walks over to you and scratch your cat-ears.  \"<i>They look and feel so real,</i>\" he says.");
				}
				flags[kFLAGS.INGNAM_EARS_LAST_TYPE] = player.earType;
				flags[kFLAGS.INGNAM_EARS_FREAKOUT] = 1;
			}
			if (player.earType > 0 && player.tailType > 0 && player.hasLongTail()) outputText("Next, he walks behind you, taking a glance at your tail.");
			if (player.tailType > 0) {
				if (player.hasLongTail()) {
					outputText("\n\nHe says with a surprised look, \"<i>You have a tail now?  Are you sure this is fake?</i>\"  You tell him that your tail is not fake; it's real.  \"<i>Prove it,</i>\" he says as he tugs your tail.  Ouch! That hurts!  \"<i>Sorry about that,</i>\" he says, \"<i>but that tail definitely looks and feels real!  I think your tail do looks nice.</i>\"");
					outputText("\n\nYou thank him for the compliment and he goes back to behind the counter.");
				}
				flags[kFLAGS.INGNAM_TAIL_LAST_TYPE] = player.earType;
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
			outputText("\"<i>I'd like a glass of beer please,</i>\" you say.  You hand over the five gems to the innkeeper and he pours you a glass of beer.");
			outputText("\n\nYou kick back and drink the beer slowly.  ");
			player.refillHunger(10);
			if (player.findStatusAffect(StatusAffects.Drunk) < 0) {
				player.createStatusAffect(StatusAffects.Drunk, 2, 1, 1, 0);
				dynStats("str", 0.1);
				dynStats("inte", -0.5);
				dynStats("lib", 0.25);
			}
			else {
				player.addStatusValue(StatusAffects.Drunk, 2, 1);
				if (player.statusAffectv1(StatusAffects.Drunk) < 2) player.addStatusValue(StatusAffects.Drunk, 1, 1);
				if (player.statusAffectv2(StatusAffects.Drunk) == 2) {
					outputText("\n\n<b>You feel a bit drunk. Maybe you should cut back on the beers.</b>");
				}
				//Get so drunk you end up peeing! Genderless can still urinate.
				if (player.statusAffectv2(StatusAffects.Drunk) >= 3) {
					outputText("\n\nYou feel so drunk.  Your vision is blurry and you realize something's not feeling right.  Gasp! You have to piss like a racehorse!  You stumble toward the back door and go outside.  ")
					if (player.hasVagina() && !player.hasCock()) outputText("You open up your [armor] and squat down while you release your pressure onto the ground.  ");
					else outputText("You open up your [armor] and lean against the wall using one of your arms for support while you release your pressure onto the wall.  ");
					outputText("It's like as if the floodgate has opened!  ");
					awardAchievement("Urine Trouble", kACHIEVEMENTS.GENERAL_URINE_TROUBLE, true, true);
					awardAchievement("Smashed", kACHIEVEMENTS.GENERAL_SMASHED, true, true);
					outputText("\n\nIt seems to take forever but it eventually stops.  You look down to see that your urine has been absorbed into the ground.  You close up your [armor] and head back inside.");
					player.removeStatusAffect(StatusAffects.Drunk);
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
			outputText("\"<i>I'd like a glass of milk please,</i>\" you say.  You hand over the two gems to the innkeeper and he pours you a glass of milk.");
			outputText("\n\nYou drink the cup of milk.  You feel calm and refreshed.  ");
			fatigue(-15);
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
			player.gems -= 2;
			outputText("\"<i>I'd like a glass of root beer please,</i>\" you say.  You hand over the three gems to the innkeeper and he pours you a glass of root beer.");
			outputText("\n\nYou drink the cup of root beer.  Refreshing!  ");
			fatigue(-15);
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

			menu();
			addButton(0, "Sandwich", buySandwich);
			addButton(1, "Soup", buySoup);
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
			outputText("\"You tell the innkeeper that you would like a sandwich and toss five gems at him.  \"<i>Certainly, " + player.mf("sir", "madam") + ",</i>\" he says as he quickly grabs a plate and assembles a sandwich.  Hey, it's your favorite type!");
			outputText("\n\nYou eat the sandwich.  Delicious!");
			HPChange(player.maxHP() / 3, false);
			player.refillHunger(25);
			cheatTime(1/12);
			doNext(menuTavern);
		}
		
		public function buySoup():void { //Eat soup. Again, it's vague to let you imagine what soup you're eating.
			clearOutput();
			if (player.gems < 5) {
				outputText("You don't have enough gems for that.");
				doNext(orderDrink);
				return;
			}
			player.gems -= 5;
			outputText("\"You tell the innkeeper that you would like a bowl of soup and toss three gems at him.  \"<i>Certainly, " + player.mf("sir", "madam") + ",</i>\" he says as he grabs a bowl and fills it with steaming soup.  Hey, it's your favorite type!");
			outputText("\n\nYou take one spoonful at a time, blowing to make sure the soup isn't too hot.  You eventually finish the soup.  Delicious!");
			HPChange(player.maxHP() / 3, false);
			player.refillHunger(20);
			cheatTime(1/12);
			doNext(menuTavern);
		}
		
		public function hearRumors():void { //Hear rumors. Will be altered after defeating Lethice so he will say "Welcome back".
			clearOutput();
			var rumor:int = rand(4);
			outputText("You ask the innkeeper if he has anything special to tell you.");
			if (flags[kFLAGS.INGNAM_RUMORS] == 0) {
				outputText("\n\nHe nods and says, \"<i>Let me tell you.  You know what happens to the so-called 'champions'?</i>\"  ");
				outputText("\n\nYou nod in response and he continues, \"<i>Well... Nobody ever came.  I've seen twenty people departing over the course of my career.  Twenty years.  None of them ever returned.  Who knows what happened to them?  Some say they're abducted by an evil presence as soon as they set foot into the portal.</i>\"");
				outputText("\n\nHe looks at you and sniffles.  \"<i>Truth be told, you're going to be the Champion of Ingnam.  You will be sent to the so-called 'portal' that is supposedly located in Mount Ilgast.  I will miss your patronage at the inn.  You're still welcome anytime.</i>\"");
				flags[kFLAGS.INGNAM_RUMORS] = 1;
			}
			else if (flags[kFLAGS.INGNAM_RUMORS] == 1) {
				outputText("\n\nHe nods and says, \"<i>You know Mount Ilgast?</i>\"  ");
				outputText("\n\nYou nod in response and he continues, \"<i>Before I began my work as an innkeeper, I was an adventurer.  I've explored Mount Ilgast once.  There was something glowing.  It's a portal but it's no ordinary portal.  Even strange was that there was something stirring in my groin.  Honestly, I swear I never felt that sensation before.  I winded up masturbating at the cave entrance just because of that warmth.  As soon as I go near the portal, the warm sensation came back again.  It's just strange, really strange.  So I've hurried back to Ingnam and never visited the mountain again.</i>\"");
				outputText("\n\nYou thank him for telling you.");
				flags[kFLAGS.INGNAM_RUMORS] = 2;
			}
			else if (flags[kFLAGS.INGNAM_RUMORS] == 2) {
				outputText("\n\nHe nods and says, \"<i>Would you really like to know something special?</i>\"  You nod in response and he continues, \"<i>One time I've seen a man with cat ears and a tail.  I thought they were just accessories but he insisted it was real.  So I tugged on his ears and it was... real.  I thought he used a lot of glue but he insisted that it's real.  His ears do feel real.  His tail even swished from side to side like it's an actual cat tail.  He told me about something called 'Whisker Fruit' or something.  So my guess is that the food in the so-called 'demon realm' can change you.</i>\"");
				outputText("\n\nYou tell him if he has some tips for you.  He says, \"<i>Yes.  If I were you, I would eat them only as last resort.  Even a food that could transform you can make the difference betweeen life and death.</i>\"  You thank him for the advice.");
				outputText("\n\n\"<i>You're welcome.  I have nothing left to tell you but you're always welcome,</i>\" he says.");
				flags[kFLAGS.INGNAM_RUMORS] = 3; //Finished
			}
			doNext(camp.returnToCampUseOneHour);
		}
		
		//Farm
		public function menuFarm():void {
			hideMenus();
			clearOutput();
			outputText("The size of the farm is quite the contrast to Ingnam.  Dairy cows are penned up near the barn.  Acres of crops grow on the field for the purpose of being harvested for food.");
			if (flags[kFLAGS.INGNAM_FARMER_MET] <= 0) {
				outputText("\n\nThe farmer walks up to greet you.  She is a female human with blonde hair. She is modestly garbed in overalls and you're unsure about her breast size but you'd guess they are at C-cups. She says, \"<i>I heard about the rumors that you're going to be the Champion of Ingnam.</i>\" Tears leak from her eyes. \"<i>I'm going to feel sad.  I won't be seeing you again.  But... you can still work here to get some gems.  I'll pay you five gems for each hour you work.  This should help you.</i>\"");
				flags[kFLAGS.INGNAM_FARMER_MET] = 1;
			}
			outputText("\n\nYou could help out the farmer with some work for gems.");
			menu();
			addButton(0, "Work", workAtFarm, null, null, null, "Work at the farm for gems.");
			addButton(14, "Leave", menuIngnam);
		}
		
		public function workAtFarm():void { //Job at the farm.
			clearOutput();
			if (player.fatigue > 70) {
				outputText("You are too exhausted to work at the farm!");
				doNext(menuFarm);
				return;
			}
			var chooser:int = rand(3);
			outputText("You let the farmer know that you're here to work for the farm.");
			if (chooser == 0) {
				outputText("\n\n\"<i>Great!  The stable needs cleaning.  I understand it's not for the faint of the heart but I promise you'll be rewarded,</i>\" the farmer says.  She guides you to the stables and hands you the shovel for cleaning" + (silly() ? " and a clothespin to clamp your nose shut": "") + ".");
				outputText("\n\nYou spend half an hour cleaning the muck out of the stable.  When you're finished cleaning the muck, the farmer comes back at you and instructs you to change the straw pile.  You do as she instructs, sweeping all the old straw piles into one large pile.  Finally, you spend the rest of the hour laying a new layer of straw for the horses to lay on.");
				outputText("\n\n\"<i>I'll take care of these from there.  Thank you for helping me.  You've taken some of the load off my burden.  Here's your payment,</i>\" she says.  She hands you five gems.");
				if (player.str < 25 && rand(2) == 0) {
					outputText("\n\nYou feel a bit stronger from all the hard work you've done.");
					dynStats("str", 1);
				}
				if (player.tou < 25 && rand(2) == 0) {
					outputText("\n\nYour efforts have helped to improve your stamina.");
					dynStats("tou", 1);
				}
				fatigue(20);
			}
			else if (chooser == 1) {
				outputText("\n\n\"<i>Great!  I could use a hand harvesting crops,</i>\" she says, \"<i>We need five full baskets of crops.</i>\"");
				outputText("\n\nShe escorts you to the field where the crops grow.  She hands you the basket so you can collect the crops.  \"<i>We'll harvest the crops.  You only need to fill three, I'll take care of the rest,</i>\" she says.");
				outputText("\n\nYou pick the corns from the plant one by one and put them into basket.  This continues until the basket gets full after which you switch to another empty basket.  You get back to harvesting and repeat until all the baskets are full.  The farmer comes to see that you've filled all the baskets.  \"<i>Good work!  I'll take care of things from there.  Here's your payment,</i>\" she says.  She hands you the five gems.");
				if (player.str < 25 && rand(2) == 0) {
					outputText("\n\nYou feel a bit stronger from all the hard work you've done.");
					dynStats("str", 1);
				}
				if (player.tou < 25 && rand(2) == 0) {
					outputText("\n\nYour efforts have helped to improve your stamina.");
					dynStats("tou", 1);
				}
				fatigue(20);
			}
			else {
				outputText("\n\n\"<i>Great!  The cows need to be milked.  It should be a simple task,</i>\" she says.  She escorts you to the cow pen and says, \"<i>Fill as much buckets as you can but make sure all the cows are milked.  When you're done, we'll haul the buckets.  I have things to attend.  Good luck!</i>\"");
				outputText("\n\nYou place the bucket under one of the cows' udders.  You gently squeeze the udders.  Milk squirts from its udders and into the bucket.  When the milk flow stops, you move on to the next cow.  You repeat the process, cow after cow.");
				outputText("\n\nBy the time you've finished milking all the cows, you are left with ten full buckets of milk.  The farmer comes back and says, \"<i>Did you milk all these cows?</i>\" You give her a nod and show her the full buckets of milk. \"<i>Thank you. You know what?  You've deserved some free milk!  Now would be a good time for some break,</i>\" She says happily.  She fills a cup with milk and gives it to you.  You promptly drink the milk.  Wow, this stuff is delicious when it's freshly milked!  After a good drink, you strike up some conversation with her.");
				player.refillHunger(20);
				player.HP += 50;
				fatigue(-10);
				outputText("\n\nAfter a few minutes of chatting, the break is over and you help her with hauling the buckets to her farmhouse, four at a time.  After three trips, she gives you a final task of filling the milk bottles.  You carefully pour the milk through a funnel into the bottle and when you manage to fill it, you move on to the next bottle.  You repeat the process until the buckets are empty.  \"<i>Good work!  You have finished your work!  Here's your payment,</i>\" she says as she hands you the five gems you deserve.");
				if (player.str < 25 && rand(2) == 0) {
					outputText("\n\nYou feel a bit stronger from all the hard work you've done.");
					dynStats("str", 1);
				}
				if (player.tou < 25 && rand(2) == 0) {
					outputText("\n\nYour efforts have helped to improve your stamina.");
					dynStats("tou", 1);
				}
				fatigue(10);
			}
			if (player.findPerk(PerkLib.HistorySlacker) >= 0) fatigue(-5);
			outputText("\n\nYou walk back to Ingnam.");
			player.gems += 5;
			statScreenRefresh();
			doNext(camp.returnToCampUseOneHour);	
		}
	}

}