//Ingnam: The Prologue
package classes.Scenes.Places 
{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.GlobalFlags.kGAMECLASS;
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
			clearOutput();
			if (model.time.days == 0 && flags[kFLAGS.INGNAM_PROLOGUE_COMPLETE] <= 0) {
				getBanishedToMareth();
				return;
			}
			outputText("Ingnam is a rich and prosperous village for its small size.  There is already a good deal of shops.  Temple is established in a district located just across from the shops.  The tavern serves as the hub for people near and far to drink and dance.");
			outputText("\n\nIn the distance is a mountain known by the locals as Mount Ilgast.  Surrounding Ingnam is a vast expanse of wilderness.");
			mainView.showMenuButton( MainView.MENU_NEW_MAIN );
			mainView.showMenuButton( MainView.MENU_DATA );
			mainView.showMenuButton( MainView.MENU_STATS );
			mainView.showMenuButton( MainView.MENU_PERKS );
			mainView.showMenuButton( MainView.MENU_APPEARANCE );
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
			addButton(2, "Temple", eventParser, 9999);
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
				player.weapon.unequip(player, false, false);
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
			addButton(5, "Shady Dealer", shopBlackMarket);
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
			outputText("\n\n40 gems - " + weapons.DAGGER.longName);
			outputText("\n\n50 gems - " + weapons.PIPE.longName);
			outputText("\n\n175 gems - " + weapons.SPEAR.longName);
			outputText("\n\n250 gems - " + weapons.KATANA.longName);
			menu();
			addButton(0, weapons.DAGGER.shortName, transactionItemConfirmation, weapons.DAGGER, 40, 1);
			addButton(1, weapons.PIPE.shortName, transactionItemConfirmation, weapons.PIPE, 50, 1);
			addButton(2, weapons.SPEAR.shortName, transactionItemConfirmation, weapons.SPEAR, 175, 1);
			addButton(3, weapons.KATANA.shortName, transactionItemConfirmation, weapons.KATANA, 250, 1);
			addButton(9, "Leave", menuShops);
		}
		
		public function shopArmor():void {
			clearOutput();
			outputText("You enter the armor shop, noting the sign depicting armors.  Few armors are proudly displayed on racks.  You can hear the sound of hammering although it stops shortly after you enter.  A male blacksmith comes from the rear door and steps up to the counter and says, \"<i>Welcome to the armor shop.  In a need of protection?</i>\"");
			outputText("\n\n<b><u>Armor shop pricings</u></b>");
			outputText("\n\n50 gems - " + armors.LEATHRA.longName);
			outputText("\n\n150 gems - " + armors.FULLCHN.longName);
			outputText("\n\n200 gems - " + armors.SCALEML.longName);
			menu();
			addButton(0, armors.LEATHRA.shortName, transactionItemConfirmation, armors.LEATHRA, 50, 2);
			addButton(1, armors.FULLCHN.shortName, transactionItemConfirmation, armors.FULLCHN, 150, 2);
			addButton(2, armors.SCALEML.shortName, transactionItemConfirmation, armors.SCALEML, 200, 2);
			addButton(9, "Leave", menuShops);
		}
		
		public function shopTailor():void {
			clearOutput();
			outputText("(Placeholder) This is the tailor.");
			outputText("\n\n<b><u>Tailor shop pricings</u></b>");
			outputText("\n\n10 gems - " + armors.C_CLOTH.longName);
			outputText("\n\n75 gems - " + armors.ADVCLTH.longName);
			outputText("\n\n40 gems - " + armors.TUBETOP.longName);
			outputText("\n\n30 gems - " + armors.OVERALL.longName);
			outputText("\n\n75 gems - " + armors.M_ROBES.longName);
			menu();
			addButton(0, armors.C_CLOTH.shortName, transactionItemConfirmation, armors.C_CLOTH, 10, 3);
			addButton(1, armors.ADVCLTH.shortName, transactionItemConfirmation, armors.ADVCLTH, 75, 3);
			addButton(2, armors.TUBETOP.shortName, transactionItemConfirmation, armors.TUBETOP, 40, 3);
			addButton(3, armors.OVERALL.shortName, transactionItemConfirmation, armors.OVERALL, 30, 3);
			addButton(4, armors.M_ROBES.shortName, transactionItemConfirmation, armors.M_ROBES, 75, 3);
			addButton(9, "Leave", menuShops);
		}
		
		public function shopAlchemist():void {
			clearOutput();
			outputText("(Placeholder) This is the alchemist.");
			outputText("\n\n<b><u>Alchemy shop pricings</u></b>");
			outputText("\n\n100 gems - " + consumables.REDUCTO.longName);
			outputText("\n\n100 gems - " + consumables.GROPLUS.longName);
			menu();
			addButton(0, "Reducto", transactionItemConfirmation, consumables.REDUCTO, 100, 4);
			addButton(1, "GroPlus", transactionItemConfirmation, consumables.GROPLUS, 100, 4);
			addButton(9, "Leave", menuShops);
		}
		
		public function shopTradingPost():void {
			clearOutput();
			outputText("(Placeholder) This is the trading post where you can buy goods.");
			outputText("\n\n15 gems - " + consumables.VITAL_T.longName);
			outputText("\n\n15 gems - " + consumables.SMART_T.longName);
			menu();
			addButton(0, "Reducto", transactionItemConfirmation, consumables.VITAL_T, 15, 5);
			addButton(1, "GroPlus", transactionItemConfirmation, consumables.SMART_T, 15, 5);
			addButton(9, "Leave", menuShops);
		}
		
		public function shopBlackMarket():void {
			clearOutput();
			outputText("(Placeholder) This is the black market where you can buy illegal items.");
			menu();
			addButton(9, "Leave", menuShops);
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
			clearOutput();
			if (player.gems >= price) {
				outputText("You have purchased " + item.longName + " for " + price + " gems. ");
				player.gems -= price;
				menu();
				statScreenRefresh();
				inventory.takeItem(item);
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
			outputText("(Placeholder) You are in the tavern.");
			menu();
			addButton(0, "Order Drink", eventParser, 9999);
			addButton(1, "Order Food", eventParser, 9999);
			addButton(2, "Rumors", eventParser, 9999);
			if (player.findPerk(PerkLib.HistoryWhore) >= 0) addButton(5, "Prostitute", eventParser, 9999);
			addButton(9, "Leave", menuIngnam);
		}
		
		//Farm
		public function menuFarm():void {
			clearOutput();
			outputText("The size of the farm is quite the contrast to Ingnam.  Dairy cows are penned up near the barn.  Acres of crops grow on the field for the purpose of being harvested for food.");
			if (flags[kFLAGS.INGNAM_FARMER_MET] <= 0) {
				outputText("\n\nThe farmer walks up to greet you.  She is a female human with blonde hair. She is modestly garbed in overalls and you're unsure about her chest size. She says, \"<i>I heard about the rumors that you're going to be the Champion of Ingnam.</i>\" Tears leak from her eyes. \"<i>I'm going to feel sad.  I won't be seeing you again.  But... you can still work here to get some gems.  I'll pay you five gems for each hour you work.  This should help you.</i>\"");
				flags[kFLAGS.INGNAM_FARMER_MET] = 1;
			}
			outputText("\n\nYou could help out the farmer with some work for gems.");
			menu();
			addButton(0, "Work", workAtFarm);
			addButton(4, "Leave", menuIngnam);
		}
		
		public function workAtFarm():void { //Job at the farm.
			clearOutput();
			var chooser:int = rand(3);
			outputText("You let the farmer know that you're here to work for the farm.");
			if (chooser == 0) {
				outputText("\n\n\"<i>Great!  The stable needs cleaning.  I understand it's not for the faint of the heart but I promise you'll be rewarded,</i>\" the farmer says.  She guides you to the stables and hands you the shovel for cleaning" + (silly() ? " and a clothespin to clamp your nose shut": "") + ".");
				outputText("\n\nYou spend half an hour cleaning the muck out of the stable.  When you're finished cleaning the muck, the farmer comes back at you and instructs you to change the straw pile.  You do as she instructs, sweeping all the old straw piles into one large pile.  Finally, you spend the rest of the hour laying a new layer of straw for the horses to lay on.");
				outputText("\n\n\"<i>Thank you for helping me.  You've taken some of the load off my burden.  Here's your payment,</i>\" she says.  She hands you five gems.");
				if (player.str < 25 && rand(2) == 0) {
					outputText("\n\nYou feel a bit stronger from all the hard work you've done.");
					dynStats("str", 1);
				}
				fatigue(30);
			}
			else if (chooser == 1) {
				outputText("\n\n\"<i>Great!  I could use a hand harvesting crops,</i>\" she says.");
				outputText("\n\n(PLACEHOLDER)");
				if (player.str < 25 && rand(2) == 0) {
					outputText("\n\nYou feel a bit stronger from all the hard work you've done.");
					dynStats("str", 1);
				}
				fatigue(30);
			}
			
			player.gems += 5;
			statScreenRefresh();
			doNext(13);			
		}
	}

}