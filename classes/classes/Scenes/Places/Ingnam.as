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
			outputText("Ingnam is a rich and prosperous village for its small size.  There is already a good deal of shops.  Temple is established in a district located just across from the shops.  The tavern serves as the hub for people near and far to drink and dance.");
			outputText("\n\nIn the distance is a mountain known by the locals as Mount Ilgast.  Surrounding Ingnam is a vast expanse of wilderness.");
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
			addButton(0, "Explore", exploreIngnam);
			addButton(1, "Shops", menuShops);
			addButton(2, "Temple (NYI)", eventParser, 9999);
			addButton(3, "Tavern", menuTavern);
			addButton(4, "Farm", menuFarm);
			if (flags[kFLAGS.INGNAM_PROLOGUE_COMPLETE] > 0) addButton(6, "Return2Camp", getBanishedToMareth);
			addButton(7, "Inventory", eventParser, 1000);
			if (player.lust >= 30) {
				if (player.lust >= 100) {
					outputText("\n\n<b>You are debilitatingly aroused, and can think of doing nothing other than masturbating.</b>", false);
					removeButton(0);
					removeButton(4);
				}
				addButton(8, "Masturbate", eventParser, 10);
				if (((player.findPerk(PerkLib.HistoryReligious) >= 0 && player.cor <= 66) || (player.findPerk(PerkLib.Enlightened) >= 0 && player.cor < 10)) && !(player.findStatusAffect(StatusAffects.Exgartuan) >= 0 && player.statusAffectv2(StatusAffects.Exgartuan) == 0) || flags[kFLAGS.SFW_MODE] >= 1) addButton(8, "Meditate", eventParser, 10);
			}
			//Show wait/rest/sleep depending on conditions.
			addButton(9, "Wait", eventParser, 40);
			if (player.fatigue > 40 || player.HP / player.maxHP() <= .9) addButton(9, "Rest", eventParser, 11);
			if (model.time.hours >= 21 || model.time.hours < 6) addButton(9, "Sleep", eventParser, 41);
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
			clearOutput();
			outputText("Placeholder");
			doNext(13);
		}
		
		//Shopping time!
		public function menuShops():void {
			clearOutput();
			outputText("Which shop would you like to visit?");
			menu();
			addButton(0, "Weapon Shop", shopWeapon);
			addButton(1, "Armor Shop", shopArmor);
			addButton(2, "Tailor", shopTailor);
			addButton(3, "Alchemist", shopAlchemist);
			addButton(4, "Trading Post", shopTradingPost);
			addButton(5, "Black Market", shopBlackMarket);
			addButton(9, "Back", menuIngnam);
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
			outputText("\n40 gems - " + weapons.DAGGER.longName);
			outputText("\n50 gems - " + weapons.PIPE.longName);
			outputText("\n175 gems - " + weapons.SPEAR.longName);
			outputText("\n250 gems - " + weapons.KATANA.longName);
			menu();
			addButton(0, weapons.DAGGER.shortName, transactionItemConfirmation, weapons.DAGGER, 40, 1);
			addButton(1, weapons.PIPE.shortName, transactionItemConfirmation, weapons.PIPE, 50, 1);
			addButton(2, weapons.SPEAR.shortName, transactionItemConfirmation, weapons.SPEAR, 175, 1);
			addButton(3, weapons.KATANA.shortName, transactionItemConfirmation, weapons.KATANA, 250, 1);
			addButton(14, "Leave", menuShops);
		}
		
		public function shopArmor():void {
			clearOutput();
			outputText("You enter the armor shop, noting the sign depicting armors.  Few armors are proudly displayed on racks.  You can hear the sound of hammering although it stops shortly after you enter.  A male blacksmith comes from the rear door and steps up to the counter and says, \"<i>Welcome to the armor shop.  In a need of protection?</i>\"");
			outputText("\n\n<b><u>Armor shop pricings</u></b>");
			outputText("\n50 gems - " + armors.LEATHRA.longName);
			outputText("\n150 gems - " + armors.FULLCHN.longName);
			outputText("\n200 gems - " + armors.SCALEML.longName);
			menu();
			addButton(0, armors.LEATHRA.shortName, transactionItemConfirmation, armors.LEATHRA, 50, 2);
			addButton(1, armors.FULLCHN.shortName, transactionItemConfirmation, armors.FULLCHN, 150, 2);
			addButton(2, armors.SCALEML.shortName, transactionItemConfirmation, armors.SCALEML, 200, 2);
			addButton(14, "Leave", menuShops);
		}
		
		public function shopTailor():void {
			clearOutput();
			outputText("(Placeholder) This is the tailor.");
			outputText("\n\n<b><u>Tailor shop pricings</u></b>");
			outputText("\n10 gems - " + armors.C_CLOTH.longName);
			outputText("\n75 gems - " + armors.ADVCLTH.longName);
			outputText("\n40 gems - " + armors.TUBETOP.longName);
			outputText("\n30 gems - " + armors.OVERALL.longName);
			outputText("\n75 gems - " + armors.M_ROBES.longName);
			menu();
			addButton(0, armors.C_CLOTH.shortName, transactionItemConfirmation, armors.C_CLOTH, 10, 3);
			addButton(1, armors.ADVCLTH.shortName, transactionItemConfirmation, armors.ADVCLTH, 75, 3);
			addButton(2, armors.TUBETOP.shortName, transactionItemConfirmation, armors.TUBETOP, 40, 3);
			addButton(3, armors.OVERALL.shortName, transactionItemConfirmation, armors.OVERALL, 30, 3);
			addButton(4, armors.M_ROBES.shortName, transactionItemConfirmation, armors.M_ROBES, 75, 3);
			addButton(14, "Leave", menuShops);
		}
		
		public function shopAlchemist():void {
			clearOutput();
			outputText("(Placeholder) This is the alchemist.");
			outputText("\n\n<b><u>Alchemy shop pricings</u></b>");
			outputText("\n100 gems - " + consumables.REDUCTO.longName);
			outputText("\n100 gems - " + consumables.GROPLUS.longName);
			outputText("\n30 gems - " + consumables.L_DRAFT.longName);
			menu();
			addButton(0, consumables.REDUCTO.shortName, transactionItemConfirmation, consumables.REDUCTO, 100, 4);
			addButton(1, consumables.GROPLUS.shortName, transactionItemConfirmation, consumables.GROPLUS, 100, 4);
			addButton(2, consumables.L_DRAFT.shortName, transactionItemConfirmation, consumables.L_DRAFT, 30, 5);
			addButton(14, "Leave", menuShops);
		}
		
		public function shopTradingPost():void {
			clearOutput();
			outputText("(Placeholder) This is the trading post where you can buy goods.");
			outputText("\n15 gems - " + consumables.VITAL_T.longName);
			outputText("\n15 gems - " + consumables.SMART_T.longName);
			menu();
			addButton(0, consumables.VITAL_T.shortName, transactionItemConfirmation, consumables.VITAL_T, 15, 5);
			addButton(1, consumables.SMART_T.shortName, transactionItemConfirmation, consumables.SMART_T, 15, 5);
			addButton(14, "Leave", menuShops);
		}
		
		public function shopBlackMarket():void {
			clearOutput();
			outputText("(Placeholder) This is the black market where you can buy illegal items.");
			menu();
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
		
		//Tavern
		public function menuTavern():void {
			clearOutput();
			outputText("The tavern is a nice place to be in.  You see several people drinking and chatting about random topics.  The bartender stands behind the wooden counter, serving beverages and cleaning.");
			menu();
			addButton(0, "Order Drink", orderDrink, null, null, null, "Buy some refreshing beverages.");
			addButton(1, "Order Food (NYI)", eventParser, 9999, null, null, "Buy some food" + (flags[kFLAGS.HUNGER_ENABLED] > 0 ? " and curb that hunger of yours!": ".") + "");
			addButton(2, "Rumors (NYI)", eventParser, 9999, null, null, "Hear some rumors going on.");
			if (player.findPerk(PerkLib.HistoryWhore) >= 0) addButton(5, "Prostitute", eventParser, 9999, null, null, "Seek someone who's willing to have sex with you for profit.");
			addButton(14, "Leave", menuIngnam);
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
			addButton(9, "Back", menuTavern);
		}
		
		public function buyBeer():void {
			clearOutput();
			if (player.gems < 5) {
				outputText("You don't have enough gems for that.");
				doNext(orderDrink);
				return;
			}
			player.gems -= 5;
			outputText("\"<i>I'd like a glass of beer please,</i>\" you say.  You hand over the five gems to the bartender and he pours you a glass of beer.");
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
				//Get so drunk you end up peeing!
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
			outputText("\"<i>I'd like a glass of milk please,</i>\" you say.  You hand over the two gems to the bartender and he pours you a glass of milk.");
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
			outputText("\"<i>I'd like a glass of root beer please,</i>\" you say.  You hand over the three gems to the bartender and he pours you a glass of root beer.");
			outputText("\n\nYou drink the cup of root beer.  Refreshing!  ");
			fatigue(-15);
			HPChange(player.maxHP() / 4, false);
			player.refillHunger(10);
			cheatTime(1/12);
			doNext(menuTavern);
		}
		
		
		//Farm
		public function menuFarm():void {
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
				fatigue(30);
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
				fatigue(30);
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
				fatigue(15);
			}
			outputText("\n\nYou walk back to Ingnam.");
			player.gems += 5;
			statScreenRefresh();
			doNext(13);	
		}
	}

}