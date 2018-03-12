/**
 * Created by aimozg on 12.01.14.
 */
package classes.Scenes
{
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.CoC;
import classes.Items.Armor;
import classes.Items.ArmorLib;
import classes.Items.Consumable;
import classes.Items.Jewelry;
import classes.Items.JewelryLib;
import classes.Items.Shield;
import classes.Items.ShieldLib;
import classes.Items.Undergarment;
import classes.Items.UndergarmentLib;
import classes.Items.Useable;
import classes.Items.Weapon;
import classes.Items.WeaponLib;
import classes.Items.WeaponRange;
import classes.Items.WeaponRangeLib;
import classes.Scenes.Camp.UniqueCampScenes;
import classes.Scenes.NPCs.HolliPureScene;

use namespace CoC;

	public class Inventory extends BaseContent {
		private static const inventorySlotName:Array = ["first", "second", "third", "fourth", "fifth", "sixth", "seventh", "eighth", "ninth", "tenth"];
		
		private var itemStorage:Array;
		private var pearlStorage:Array;
		private var gearStorage:Array;
		private var prisonStorage:Array;
		private var callNext:Function;		//These are used so that we know what has to happen once the player finishes with an item
		private var callOnAbandon:Function;	//They simplify dealing with items that have a sub menu. Set in inventoryMenu and in takeItem
		private var currentItemSlot:ItemSlotClass;	//The slot previously occupied by the current item - only needed for stashes and items with a sub menu.
		public var HolliPure:HolliPureScene = new HolliPureScene();
		public var Gardening:UniqueCampScenes = new UniqueCampScenes();
		
		public function Inventory(saveSystem:Saves) {
			itemStorage = [];
			pearlStorage = [];
			gearStorage = [];
			prisonStorage = [];
			saveSystem.linkToInventory(itemStorageDirectGet, pearlStorageDirectGet, gearStorageDirectGet);
		}
		
		public function showStash():Boolean {
			return player.hasKeyItem("Equipment Rack - Weapons") >= 0 || player.hasKeyItem("Equipment Rack - Armor") >= 0 || player.hasKeyItem("Equipment Rack - Shields") >= 0 || itemStorage.length > 0 || player.hasKeyItem("Equipment Storage - Jewelry Box") >= 0 || flags[kFLAGS.CAMP_CABIN_FURNITURE_DRESSER] > 0;
		}
		
		public function itemStorageDirectGet():Array { return itemStorage; }
		
		public function pearlStorageDirectGet():Array { return pearlStorage; }
		
		public function gearStorageDirectGet():Array { return gearStorage; }
		
		public function prisonStorageDirectGet():Array { return prisonStorage; }
		
//		public function currentCallNext():Function { return callNext; }
		
		public function itemGoNext():void { if (callNext != null) doNext(callNext); }
		
		public function inventoryMenu():void {
			var x:int;
			var foundItem:Boolean = false;
            if (CoC.instance.inCombat) {
                callNext = inventoryCombatHandler; //Player will return to combat after item use
			}
			else {
				spriteSelect(-1);
				callNext = inventoryMenu; //In camp or in a dungeon player will return to inventory menu after item use
			}
			hideMenus();
			hideUpDown();
			clearOutput();
			EngineCore.displayHeader("Inventory");
			outputText("<b><u>Equipment:</u></b>\n");
			outputText("<b>Weapon (Melee):</b> " + player.weapon.name + " (Attack: " + player.weaponAttack + ")\n");
			outputText("<b>Weapon (Range):</b> " + player.weaponRange.name + " (Attack: " + player.weaponRangeAttack + ")\n");
			outputText("<b>Shield:</b> " + player.shield.name + " (Block Rating: " + player.shieldBlock + ")\n");
			outputText("<b>Armour:</b> " + player.armor.name + " (Defense: " + player.armorDef + ")\n");
			outputText("<b>Upper underwear:</b> " + player.upperGarment.name + "\n");
			outputText("<b>Lower underwear:</b> " + player.lowerGarment.name + "\n");
			outputText("<b>Accessory:</b> " + player.jewelryName + "\n");
			if (player.hasKeyItem("Bag of Cosmos") >= 0) outputText("\nAt your belt hangs bag of cosmos.\n");
			if (player.hasKeyItem("Sky Poison Pearl") >= 0) outputText("\nThere is a circular green imprint at the palm of your left hand.\n");
			if (player.keyItems.length > 0) outputText("<b><u>\nKey Items:</u></b>\n");
			for (x = 0; x < player.keyItems.length; x++) outputText(player.keyItems[x].keyName + "\n");
			menu();
			for (x = 0; x < 10; x++) {
				if (player.itemSlots[x].unlocked && player.itemSlots[x].quantity > 0) {
					addButton(x, (player.itemSlots[x].itype.shortName + " x" + player.itemSlots[x].quantity), useItemInInventory, x);
					foundItem = true;
				}
			}

if (!CoC.instance.inCombat && inDungeon == false && inRoomedDungeon == false && flags[kFLAGS.IN_PRISON] == 0 && flags[kFLAGS.IN_INGNAM] == 0) {
                var miscNieve:Boolean = Holidays.nieveHoliday() && flags[kFLAGS.NIEVE_STAGE] > 0 && flags[kFLAGS.NIEVE_STAGE] < 5;
                var miscHolli:Boolean         = flags[kFLAGS.FUCK_FLOWER_KILLED] == 0 && (flags[kFLAGS.FUCK_FLOWER_LEVEL] >= 1 && flags[kFLAGS.FUCK_FLOWER_LEVEL] < 4 || flags[kFLAGS.FLOWER_LEVEL] >= 1 && flags[kFLAGS.FLOWER_LEVEL] < 4);
				if (miscNieve
					|| miscHolli
					|| player.hasKeyItem("Dragon Egg") >= 0
					|| player.hasKeyItem("Gryphon Statuette") >= 0
					|| player.hasKeyItem("Peacock Statuette") >= 0
					|| flags[kFLAGS.ANEMONE_KID] > 0
					|| flags[kFLAGS.ALRAUNE_SEEDS] > 0) {
					if (miscNieve) {
						if (flags[kFLAGS.NIEVE_STAGE] == 1)
							outputText("\nThere's some odd snow here that you could do something with...\n");
                        else outputText("\nYou have a snow" + Holidays.nieveMF("man", "woman") + " here that seems like it could use a little something...\n");
                    }
					if (player.hasKeyItem("Dragon Egg") >= 0) {
                        SceneLib.emberScene.emberCampDesc();
					}
					if (flags[kFLAGS.ANEMONE_KID] > 0) {
						SceneLib.anemoneScene.anemoneBarrelDescription();
					}
					if (flags[kFLAGS.ALRAUNE_SEEDS] > 0) {
						outputText("\nYou have " + flags[kFLAGS.ALRAUNE_SEEDS] + " alraune seeds planted in your garden.");
						if (flags[kFLAGS.ALRAUNE_GROWING] > 14) outputText(" Some have already grown to adulthood.");
						outputText("\n");
					}
					addButton(13, "Misc.", miscitemsMenu);
				}
			}
            if (!CoC.instance.inCombat) {
                addButton(10, "Unequip", manageEquipment);
				if (player.hasKeyItem("Bag of Cosmos") >= 0) {
					addButton(11, "Bag of Cosmos", BagOfCosmosMenu);
				}
				if (player.hasKeyItem("Sky Poison Pearl") >= 0) {
					addButton(12, "Sky P. Pearl", SkyPoisonPearlMenu);
				}
			}
			if (foundItem) {
                if (CoC.instance.inCombat && player.hasStatusEffect(StatusEffects.Sealed) && player.statusEffectv1(StatusEffects.Sealed) == 3) {
                    outputText("\nYou reach for your items, but you just can't get your pouches open.  <b>Your ability to use items was sealed, and now you've wasted a chance to attack!</b>\n\n");
                    SceneLib.combat.enemyAIImpl();
                    return;
				}
				outputText("\nWhich item will you use? (To discard unwanted items, hold Shift then click the item.)");
			}
			outputText("\n<b>Capacity:</b> " + getOccupiedSlots() + " / " + getMaxSlots());
            if (CoC.instance.inCombat)
                addButton(14, "Back", SceneLib.combat.combatMenu, false); //Player returns to the combat menu on cancel
			else addButton(14, "Back", playerMenu);
//Gone			menuLoc = 1;
		}
		
		public function miscitemsMenu():void {
			var foundItem:Boolean = false;
			menu();
            if (Holidays.nieveHoliday() && flags[kFLAGS.NIEVE_STAGE] > 0 && flags[kFLAGS.NIEVE_STAGE] < 5) {
                addButton(0, "Snow", Holidays.nieveBuilding);
                foundItem = true;
				}
				if (flags[kFLAGS.FUCK_FLOWER_KILLED] == 0 && flags[kFLAGS.FUCK_FLOWER_LEVEL] >= 1 && flags[kFLAGS.FUCK_FLOWER_LEVEL] < 4) {
					addButton(2, (flags[kFLAGS.FUCK_FLOWER_LEVEL] >= 3 ? "Tree" : "Plant"), SceneLib.holliScene.treeMenu);
					foundItem = true;
				}
				if (flags[kFLAGS.FUCK_FLOWER_KILLED] == 0 && flags[kFLAGS.FLOWER_LEVEL] >= 1 && flags[kFLAGS.FLOWER_LEVEL] < 4) {
					addButton(2, (flags[kFLAGS.FLOWER_LEVEL] >= 3 ? "Tree" : "Plant"), HolliPure.treeMenu);
					foundItem = true;
				}
				if (player.hasKeyItem("Dragon Egg") >= 0) {
					addButton(3, "Egg", SceneLib.emberScene.emberEggInteraction);
					foundItem = true;
				}
				if (flags[kFLAGS.ANEMONE_KID] > 0) {
					//CoC.instance.anemoneScene.anemoneBarrelDescription();
					if (model.time.hours >= 6) addButton(4, "Anemone", SceneLib.anemoneScene.approachAnemoneBarrel);
				}
				if (flags[kFLAGS.ALRAUNE_SEEDS] > 0) {
					if (model.time.hours >= 6) addButton(5, "Garden", Gardening.manageuyourgarden).hint("Visit your plant offspring");
				}
			/*	if (player.hasKeyItem("Gryphon Statuette") >= 0) {
					addButton(6, "Gryphon", SceneLib.mutationsTable.skybornSeed(1));
					foundItem = true;
				}
				if (player.hasKeyItem("Peacock Statuette") >= 0) {
					addButton(6, "Peacock", SceneLib.mutationsTable.skybornSeed(2));
					foundItem = true;
				}
			*/	addButton(14, "Back", inventoryMenu);
		}
		
		public function BagOfCosmosMenu():void {
			hideMenus();
			spriteSelect(-1);
			menu();
			addButton(0, "Bag Store", pickItemToPlaceInBagOfCosmos);
			addButton(1, "Bag Take", pickItemToTakeFromBagOfCosmos);
			addButton(14, "Back", inventoryMenu);
		}
		
		public function SkyPoisonPearlMenu():void {
			hideMenus();
			spriteSelect(-1);
			menu();
			addButton(0, "Pearl Store 1", pickItemToPlaceInSkyPoisonPearl5).hint("Store item in Sky Poison Pearl (central section).");
			addButton(5, "Pearl Take 1", pickItemToTakeFromSkyPoisonPearl5).hint("Take item from Sky Poison Pearl (central section).");
			if (player.level >= 6) addButton(6, "Pearl Take 2", pickItemToTakeFromSkyPoisonPearl1).hint("Take item from Sky Poison Pearl (east section).");
			if (player.level >= 12) addButton(7, "Pearl Take 3", pickItemToTakeFromSkyPoisonPearl2).hint("Take item from Sky Poison Pearl (south section).");
			if (player.level >= 18) addButton(8, "Pearl Take 4", pickItemToTakeFromSkyPoisonPearl3).hint("Take item from Sky Poison Pearl (west section).");
			if (player.level >= 24) addButton(9, "Pearl Take 5", pickItemToTakeFromSkyPoisonPearl4).hint("Take item from Sky Poison Pearl (north section).");
			if (player.level >= 30) addButton(11, "Pearl Take 6", pickItemToTakeFromSkyPoisonPearl6).hint("Take item from Sky Poison Pearl (above section).");
			if (player.level >= 36) addButton(13, "Pearl Take 7", pickItemToTakeFromSkyPoisonPearl7).hint("Take item from Sky Poison Pearl (below section).");
			if (player.level >= 6) addButton(1, "Pearl Store 2", pickItemToPlaceInSkyPoisonPearl1).hint("Store item in Sky Poison Pearl (east section).");
			else addButtonDisabled(1, "Pearl Store 2", "Req. LvL 6+ to unlock this.");
			if (player.level >= 12) addButton(2, "Pearl Store 3", pickItemToPlaceInSkyPoisonPearl2).hint("Store item in Sky Poison Pearl (south section).");
			else addButtonDisabled(2, "Pearl Store 3", "Req. LvL 12+ to unlock this.");
			if (player.level >= 18) addButton(3, "Pearl Store 4", pickItemToPlaceInSkyPoisonPearl3).hint("Store item in Sky Poison Pearl (west section).");
			else addButtonDisabled(3, "Pearl Store 4", "Req. LvL 18+ to unlock this.");
			if (player.level >= 24) addButton(4, "Pearl Store 5", pickItemToPlaceInSkyPoisonPearl4).hint("Store item in Sky Poison Pearl (north section).");
			else addButtonDisabled(4, "Pearl Store 5", "Req. LvL 24+ to unlock this.");
			if (player.level >= 30) addButton(10, "Pearl Store 6", pickItemToPlaceInSkyPoisonPearl6).hint("Store item in Sky Poison Pearl (above section).");
			else addButtonDisabled(10, "Pearl Store 6", "Req. LvL 30+ to unlock this.");
			if (player.level >= 36) addButton(12, "Pearl Store 7", pickItemToPlaceInSkyPoisonPearl7).hint("Store item in Sky Poison Pearl (below section).");
			else addButtonDisabled(12, "Pearl Store 7", "Req. LvL 36+ to unlock this.");
			addButton(14, "Back", inventoryMenu);
		}
		
		public function stash():void {
			/*Hacked in cheat to enable shit
			flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00254] = 1;
			flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00255] = 1;*/
			//REMOVE THE ABOVE BEFORE RELASE ()
			hideMenus();
			clearOutput();
			spriteSelect(-1);
			menu();
			
			if (player.hasKeyItem("Camp - Chest") >= 0 || player.hasKeyItem("Camp - Murky Chest") >= 0 || player.hasKeyItem("Camp - Ornate Chest") >= 0) {
				var chestArray:Array = [];
				if (player.hasKeyItem("Camp - Chest") >= 0) chestArray.push("a large wood and iron chest");
				if (player.hasKeyItem("Camp - Murky Chest") >= 0) chestArray.push("a medium damp chest");
				if (player.hasKeyItem("Camp - Ornate Chest") >= 0) chestArray.push("a medium gilded chest");
				outputText("You have " + formatStringArray(chestArray) + " to help store excess items located ");
				if (camp.homeDesc() == "cabin") outputText("inside your cabin");
				else outputText("near the portal entrance");
				outputText(".\n\n");
				addButton(0, "Chest Store", pickItemToPlaceInCampStorage);
				if (hasItemsInStorage()) addButton(1, "Chest Take", pickItemToTakeFromCampStorage);
			}
			//Jewelry box
			if(player.hasKeyItem("Equipment Storage - Jewelry Box") >= 0) {
				outputText("Your jewelry box is located ");
				if (flags[kFLAGS.CAMP_BUILT_CABIN] > 0 && flags[kFLAGS.CAMP_CABIN_FURNITURE_BED])
				{
					if (flags[kFLAGS.CAMP_CABIN_FURNITURE_DRESSER]) outputText("on your dresser inside your cabin.");
					else
					{
						if (flags[kFLAGS.CAMP_CABIN_FURNITURE_NIGHTSTAND]) outputText("on your nightstand inside your cabin.");
						else  outputText("under your bed inside your cabin.");
					}
				}
				else outputText("next to your bedroll.");	
				addButton(2, "J.Box Put", inventory.pickItemToPlaceInJewelryBox);
				if (inventory.jewelryBoxDescription()) addButton(3, "J.Box Take", inventory.pickItemToTakeFromJewelryBox);
				outputText("\n\n");
			}
			//Dresser
			if (flags[kFLAGS.CAMP_CABIN_FURNITURE_DRESSER] > 0) {
				outputText("You have a dresser inside your cabin to store nine different types of undergarments.");
				addButton(5, "Dresser Put", inventory.pickItemToPlaceInDresser);
				if (inventory.dresserDescription()) addButton(6, "Dresser Take", inventory.pickItemToTakeFromDresser);
				outputText("\n\n");
			}
			if (flags[kFLAGS.CAMP_UPGRADES_WAREHOUSE_GRANARY] < 2) {
			//Weapon Rack
			if (player.hasKeyItem("Equipment Rack - Weapons") >= 0) {
				outputText("There's a weapon rack set up here, set up to hold up to nine various weapons.");
				addButton(7, "W.Rack Put", pickItemToPlaceInWeaponRack);
				if (weaponRackDescription()) addButton(8, "W.Rack Take", pickItemToTakeFromWeaponRack);
				outputText("\n\n");
			}
			//Armor Rack
			if(player.hasKeyItem("Equipment Rack - Armor") >= 0) {
				outputText("Your camp has an armor rack set up to hold your various sets of gear.  It appears to be able to hold nine different types of armor.");
				addButton(10, "A.Rack Put", pickItemToPlaceInArmorRack);
				if (armorRackDescription()) addButton(11, "A.Rack Take", pickItemToTakeFromArmorRack);
				outputText("\n\n");
			}
			//Shield Rack
			if(player.hasKeyItem("Equipment Rack - Shields") >= 0) {
				outputText("There's a shield rack set up here, set up to hold up to nine various shields.");
				addButton(12, "S.Rack Put", pickItemToPlaceInShieldRack);
				if (shieldRackDescription()) addButton(13, "S.Rack Take", pickItemToTakeFromShieldRack);
				outputText("\n\n");
			}
			}
			addButton(14, "Back", playerMenu);
		}
		
		public function warehouse():void {
			hideMenus();
			clearOutput();
			spriteSelect(-1);
			menu();
			if (flags[kFLAGS.CAMP_UPGRADES_WAREHOUSE_GRANARY] == 2) {
				outputText("You stand inside your warehouse looking at the goods stored inside.");
				outputText("\n\n");
			}
			if (flags[kFLAGS.CAMP_UPGRADES_WAREHOUSE_GRANARY] == 4) {
				outputText("You stand inside your warehouse and connected to it medium-sized granary looking at the goods and food stored inside.");
				outputText("\n\n");
			}
			if (flags[kFLAGS.CAMP_UPGRADES_WAREHOUSE_GRANARY] == 6) {
				outputText("You stand inside your warehouses and connecting them medium-sized granary looking at the goods and food stored inside.");
				outputText("\n\n");
			}
			//Warehouse part 1 and 2
			if (flags[kFLAGS.CAMP_UPGRADES_WAREHOUSE_GRANARY] >= 2) {
				addButton(0, "Warehouse P1", pickItemToPlaceInWarehouse1).hint("Put item in 1st Warehouse.");
				if (warehouse1Description()) addButton(1, "Warehouse T1", pickItemToTakeFromWarehouse1).hint("Take item from 1st Warehouse.");
			}
			if (flags[kFLAGS.CAMP_UPGRADES_WAREHOUSE_GRANARY] >= 6) {
				addButton(2, "Warehouse P2", pickItemToPlaceInWarehouse2).hint("Put item in 2nd Warehouse.");
				if (warehouse2Description()) addButton(3, "Warehouse T2", pickItemToTakeFromWarehouse2).hint("Take item from 2nd Warehouse.");
			}
			//Granary
			if (flags[kFLAGS.CAMP_UPGRADES_WAREHOUSE_GRANARY] >= 4) {
				addButton(5, "Granary Put", pickItemToPlaceInGranary).hint("Put food in Granary.");
				if (granaryDescription()) addButton(6, "Granary Take", pickItemToTakeFromGranary).hint("Take food from Granary.");
			}
			//Weapon Rack
			if (player.hasKeyItem("Equipment Rack - Weapons") >= 0) {
				outputText("There's a weapon rack set up here, set up to hold up to nine various weapons.");
				addButton(7, "W.Rack Put", pickItemToPlaceInWeaponRack2).hint("Put weapon on the rack.");
				if (weaponRackDescription()) addButton(8, "W.Rack Take", pickItemToTakeFromWeaponRack2).hint("Take weapon from the rack.");
				outputText("\n\n");
			}
			//Armor Rack
			if(player.hasKeyItem("Equipment Rack - Armor") >= 0) {
				outputText("Your camp has an armor rack set up to hold your various sets of gear.  It appears to be able to hold nine different types of armor.");
				addButton(10, "A.Rack Put", pickItemToPlaceInArmorRack2).hint("Put armor on the rack.");
				if (armorRackDescription()) addButton(11, "A.Rack Take", pickItemToTakeFromArmorRack2).hint("Take armor from the rack.");
				outputText("\n\n");
			}
			//Shield Rack
			if(player.hasKeyItem("Equipment Rack - Shields") >= 0) {
				outputText("There's a shield rack set up here, set up to hold up to nine various shields.");
				addButton(12, "S.Rack Put", pickItemToPlaceInShieldRack2).hint("Put shield on the rack.");
				if (shieldRackDescription()) addButton(13, "S.Rack Take", pickItemToTakeFromShieldRack2).hint("Take shield from the rack.");
				outputText("\n\n");
			}
			addButton(14, "Back", playerMenu);
		}
		
		public function takeItem(itype:ItemType, nextAction:Function, overrideAbandon:Function = null, source:ItemSlotClass = null):void {
			if (itype == null) {
				CoC_Settings.error("takeItem(null)");
				return;
			}
			if (itype == ItemType.NOTHING) return;
			if (nextAction != null)
				callNext = nextAction;
			else callNext = playerMenu;
			//Check for an existing stack with room in the inventory and return the value for it.
			var temp:int = player.roomInExistingStack(itype);
			if (temp >= 0) { //First slot go!
				player.itemSlots[temp].quantity++;
				outputText("You place " + itype.longName + " in your " + inventorySlotName[temp] + " pouch, giving you " + player.itemSlots[temp].quantity + " of them.");
				itemGoNext();
				return;
			}
			//If not done, then put it in an empty spot!
			//Throw in slot 1 if there is room
			temp = player.emptySlot();
			if (temp >= 0) {
				player.itemSlots[temp].setItemAndQty(itype, 1);
				outputText("You place " + itype.longName + " in your " + inventorySlotName[temp] + " pouch.");
				itemGoNext();
				return;
			}
			if (overrideAbandon != null) //callOnAbandon only becomes important if the inventory is full
				callOnAbandon = overrideAbandon;
			else callOnAbandon = callNext;
			//OH NOES! No room! Call replacer functions!
			takeItemFull(itype, true, source);
		}
		
		public function returnItemToInventory(item:Useable, showNext:Boolean = true):void { //Used only by items that have a sub menu if the player cancels
			if (!debug) {
				if (currentItemSlot == null) {
					takeItem(item, callNext, callNext, null); //Give player another chance to put item in inventory
				}
				else if (currentItemSlot.quantity > 0) { //Add it back to the existing stack
					currentItemSlot.quantity++;
				}
				else { //Put it back in the slot it came from
					currentItemSlot.setItemAndQty(item, 1);
				}
			}
            if (CoC.instance.inCombat) {
                enemyAI();
				return;
			}
			if (showNext)
				doNext(callNext); //Items with sub menus should return to the inventory screen if the player decides not to use them
			else callNext(); //When putting items back in your stash we should skip to the take from stash menu
		}
		
		//Check to see if anything is stored
		public function hasItemsInStorage():Boolean { return itemAnyInStorage(itemStorage, 0, itemStorage.length); }
		
		public function hasItemInStorage(itype:ItemType):Boolean { return itemTypeInStorage(itemStorage, 0, itemStorage.length, itype); }
		
		public function consumeItemInStorage(itype:ItemType):Boolean {
			var index:int = itemStorage.length;
			while(index > 0) {
				index--;
				if(itemStorage[index].itype == itype && itemStorage[index].quantity > 0) {
					itemStorage[index].quantity--;
					return true;
				}
			}
			return false;
		}
		
		public function hasItemsInBagStorage():Boolean { return itemAnyInStorage(gearStorage, 45, 57); }
		
		public function hasItemInBagStorage(itype:ItemType):Boolean { return itemTypeInStorage(gearStorage, 45, 57, itype); }
		
		public function hasItemsInPearlStorage():Boolean { return itemAnyInStorage(pearlStorage, 0, 98); }
		
		public function hasItemInPearlStorage(itype:ItemType):Boolean { return itemTypeInStorage(pearlStorage, 0, 98, itype); }
		
		public function giveHumanizer():void {
			clearOutput();
			if(flags[kFLAGS.TIMES_CHEATED_COUNTER] > 0) {
				outputText("<b>I was a cheater until I took an arrow to the knee...</b>");
				EventParser.gameOver();
				return;
			}
			outputText("I AM NOT A CROOK.  BUT YOU ARE!  <b>CHEATER</b>!\n\n");
			inventory.takeItem(consumables.HUMMUS_, playerMenu);
			flags[kFLAGS.TIMES_CHEATED_COUNTER]++;
		}
		
		public function getMaxSlots():int {
			var slots:int = 3;
			if (player.findPerk(PerkLib.StrongBack) >= 0) slots++;
			if (player.findPerk(PerkLib.StrongBack2) >= 0) slots++;
			slots += player.keyItemv1("Backpack");
			//Constrain slots to between 3 and 10.
			if (slots < 3) slots = 3;
			if (slots > 10) slots = 10;
			return slots;
		}
		public function getOccupiedSlots():int {
			var occupiedSlots:int = 0;
		    for (var i:int = 0; i < player.itemSlots.length; i++) {
				if (!player.itemSlot(i).isEmpty() && player.itemSlot(i).unlocked) occupiedSlots++;
			}
			return occupiedSlots;
		}
		
		//Create a storage slot
		public function createStorage():Boolean {
			if (itemStorage.length >= 16) return false;
			var newSlot:ItemSlotClass = new ItemSlotClass();
			itemStorage.push(newSlot);
			return true;
		}
		
		//Clear storage slots
		public function clearStorage():void {
			//Various Errors preventing action
			if (itemStorage == null) trace("ERROR: Cannot clear storage because storage does not exist.");
			else {
				trace("Attempted to remove " + itemStorage.length + " storage slots.");
				itemStorage.splice(0, itemStorage.length);
			}
		}
		
		public function clearGearStorage():void {
			//Various Errors preventing action
			if (gearStorage == null) trace("ERROR: Cannot clear storage because storage does not exist.");
			else {
				trace("Attempted to remove " + gearStorage.length + " storage slots.");
				gearStorage.splice(0, gearStorage.length);
			}
		}
		
		public function clearPearlStorage():void {
			//Various Errors preventing action
			if (pearlStorage == null) trace("ERROR: Cannot clear storage because storage does not exist.");
			else {
				trace("Attempted to remove " + pearlStorage.length + " storage slots.");
				pearlStorage.splice(0, pearlStorage.length);
			}
		}
		
		public function initializeGearStorage():void {
			//Completely empty storage array
			if (gearStorage == null) trace("ERROR: Cannot clear gearStorage because storage does not exist.");
			else {
				trace("Attempted to remove " + gearStorage.length + " gearStorage slots.");
				gearStorage.splice(0, gearStorage.length);
			}
			//Rebuild a new one!
			var newSlot:ItemSlotClass;
			while (gearStorage.length < 90) {
				newSlot = new ItemSlotClass();
				gearStorage.push(newSlot);
			}
		}
		
		public function initializePearlStorage():void {
			//Completely empty storage array
			if (pearlStorage == null) trace("ERROR: Cannot clear pearlStorage because storage does not exist.");
			else {
				trace("Attempted to remove " + pearlStorage.length + " pearlStorage slots.");
				pearlStorage.splice(0, pearlStorage.length);
			}
			//Rebuild a new one!
			var newSlot:ItemSlotClass;
			while (pearlStorage.length < 98) {
				newSlot = new ItemSlotClass();
				pearlStorage.push(newSlot);
			}
		}
		
		private function useItemInInventory(slotNum:int):void {
			clearOutput();
			if (player.itemSlots[slotNum].itype is Useable) {
				var item:Useable = player.itemSlots[slotNum].itype as Useable;
				if (flags[kFLAGS.SHIFT_KEY_DOWN] == 1) {
					deleteItemPrompt(item, slotNum);
					return;
				}
				if (item.canUse()) { //If an item cannot be used then canUse should provide a description of why the item cannot be used
					if (!debug) player.itemSlots[slotNum].removeOneItem();
					useItem(item, player.itemSlots[slotNum]);
					return;
				}
			}
			else {
				outputText("You cannot use " + player.itemSlots[slotNum].itype.longName + "!\n\n");
			}
			itemGoNext(); //Normally returns to the inventory menu. In combat it goes to the inventoryCombatHandler function
		}
		
		private function inventoryCombatHandler():void {
			//Check if the battle is over. If not then go to the enemy's action.
			if (combat.combatIsOver()) return;
			outputText("\n\n");
			enemyAI();
		}
		private function deleteItemPrompt(item:Useable, slotNum:int):void {
			clearOutput();
			outputText("Are you sure you want to destroy " + player.itemSlots[slotNum].quantity + "x " + item.shortName + "?  You won't be able to retrieve " + (player.itemSlots[slotNum].quantity == 1 ? "it": "them") + "!");
			menu();
			addButton(0, "Yes", deleteItem, item, slotNum);
			addButton(1, "No", inventoryMenu);
			//doYesNo(deleteItem, inventoryMenu);
		}
		
		private function deleteItem(item:Useable, slotNum:int):void {
			clearOutput();
			outputText(player.itemSlots[slotNum].quantity + "x " + item.shortName + " " + (player.itemSlots[slotNum].quantity == 1 ? "has": "have") + " been destroyed.");
			player.destroyItems(item, player.itemSlots[slotNum].quantity);
			doNext(inventoryMenu);
		}
		
		private function useItem(item:Useable, fromSlot:ItemSlotClass):void {
			item.useText();
			if (item is Armor) {
				player.armor.removeText();
				item = player.setArmor(item as Armor); //Item is now the player's old armor
				if (item == null)
					itemGoNext();
				else takeItem(item, callNext);
			}
			else if (item is Weapon) {
				player.weapon.removeText();
				item = player.setWeapon(item as Weapon); //Item is now the player's old weapon
				if (item == null)
					itemGoNext();
				else takeItem(item, callNext);
			}
			else if (item is WeaponRange) {
				player.weaponRange.removeText();
				item = player.setWeaponRange(item as WeaponRange); //Item is now the player's old weapon range
				if (item == null)
					itemGoNext();
				else takeItem(item, callNext);
			}
			else if (item is Jewelry) {
				player.jewelry.removeText();
				item = player.setJewelry(item as Jewelry); //Item is now the player's old jewelry
				if (item == null)
					itemGoNext();
				else takeItem(item, callNext);
			}
			else if (item is Shield) {
				player.shield.removeText();
				item = player.setShield(item as Shield); //Item is now the player's old shield
				if (item == null)
					itemGoNext();
				else takeItem(item, callNext);
			}
			else if (item is Undergarment) {
				if (item["type"] == 0) player.upperGarment.removeText();
				else player.lowerGarment.removeText();
				item = player.setUndergarment(item as Undergarment, item["type"]); //Item is now the player's old shield
				if (item == null)
					itemGoNext();
				else takeItem(item, callNext);
			}
			else {
				currentItemSlot = fromSlot;
				if (!item.useItem()) itemGoNext(); //Items should return true if they have provided some form of sub-menu.
					//This is used for Reducto and GroPlus (which always present the player with a sub-menu)
					//and for the Kitsune Gift (which may show a sub-menu if the player has a full inventory)
//				if (!item.hasSubMenu()) itemGoNext(); //Don't call itemGoNext if there's a sub menu, otherwise it would never be displayed
			}
		}
		
		private function takeItemFull(itype:ItemType, showUseNow:Boolean, source:ItemSlotClass):void {
			outputText("There is no room for " + itype.longName + " in your inventory.  You may replace the contents of a pouch with " + itype.longName + " or abandon it.");
			menu();
			for (var x:int = 0; x < 10; x++) {
				if (player.itemSlots[x].unlocked)
					addButton(x, (player.itemSlots[x].itype.shortName + " x" + player.itemSlots[x].quantity), createCallBackFunction2(replaceItem, itype, x));
			}
			if (source != null) {
				currentItemSlot = source;
				addButton(12, "Put Back", createCallBackFunction2(returnItemToInventory, itype, false));
			}
			if (showUseNow && itype is Useable) addButton(13, "Use Now", createCallBackFunction2(useItemNow, itype as Useable, source));
			addButton(14, "Abandon", callOnAbandon); //Does not doNext - immediately executes the callOnAbandon function
		}
		
		private function useItemNow(item:Useable, source:ItemSlotClass):void {
			clearOutput();
			if (item.canUse()) { //If an item cannot be used then canUse should provide a description of why the item cannot be used
				useItem(item, source);
			}
			else {
				takeItemFull(item, false, source); //Give the player another chance to take this item
			}
		}
		
		private function replaceItem(itype:ItemType, slotNum:int):void {
			clearOutput();
			if (player.itemSlots[slotNum].itype == itype) //If it is the same as what's in the slot...just throw away the new item
				outputText("You discard " + itype.longName + " from the stack to make room for the new one.");
			else { //If they are different...
				if (player.itemSlots[slotNum].quantity == 1) outputText("You throw away " + player.itemSlots[slotNum].itype.longName + " and replace it with " + itype.longName + ".");
				else outputText("You throw away " + player.itemSlots[slotNum].itype.longName + "(x" + player.itemSlots[slotNum].quantity + ") and replace it with " + itype.longName + ".");
				player.itemSlots[slotNum].setItemAndQty(itype, 1);
			}
			itemGoNext();
		}
		
		//My unequip function is still superior, albeit rewritten.
		//private function unequipWeapon():void {
		//	clearOutput();
		//	takeItem(player.setWeapon(WeaponLib.FISTS), inventoryMenu);
		//}
		
/* Never called
		public function hasItemsInRacks(itype:ItemType, armor:Boolean):Boolean {
			if (armor) return itemTypeInStorage(gearStorage, 9, 18, itype);
			return itemTypeInStorage(gearStorage, 0, 9, itype);
		}
*/
		
		public function armorRackDescription():Boolean {
			if (itemAnyInStorage(gearStorage, 9, 18)) {
				var itemList:Array = [];
				for (var x:int = 9; x < 18; x++)
					if (gearStorage[x].quantity > 0) itemList[itemList.length] = gearStorage[x].itype.longName;
				outputText("  It currently holds " + formatStringArray(itemList) + ".");
				return true;
			}
			return false;
		}
		
		public function weaponRackDescription():Boolean {
			if (itemAnyInStorage(gearStorage, 0, 9)) {
				var itemList:Array = [];
				for (var x:int = 0; x < 9; x++)
					if (gearStorage[x].quantity > 0) itemList[itemList.length] = gearStorage[x].itype.longName;
				outputText("  It currently holds " + formatStringArray(itemList) + ".");
				return true;
			}
			return false;
		}
		
		public function shieldRackDescription():Boolean {
			if (itemAnyInStorage(gearStorage, 36, 45)) {
				var itemList:Array = [];
				for (var x:int = 36; x < 45; x++)
					if (gearStorage[x].quantity > 0) itemList[itemList.length] = gearStorage[x].itype.longName;
				outputText("  It currently holds " + formatStringArray(itemList) + ".");
				return true;
			}
			return false;
		}
		
		public function jewelryBoxDescription():Boolean {
			if (itemAnyInStorage(gearStorage, 18, 27)) {
				var itemList:Array = [];
				for (var x:int = 18; x < 27; x++)
					if (gearStorage[x].quantity > 0) itemList[itemList.length] = gearStorage[x].itype.longName;
				outputText("  It currently holds " + formatStringArray(itemList) + ".");
				return true;
			}
			return false;
		}
		
		public function dresserDescription():Boolean {
			if (itemAnyInStorage(gearStorage, 27, 36)) {
				var itemList:Array = [];
				for (var x:int = 27; x < 36; x++)
					if (gearStorage[x].quantity > 0) itemList[itemList.length] = gearStorage[x].itype.longName;
				outputText("  It currently holds " + formatStringArray(itemList) + ".");
				return true;
			}
			return false;
		}
		
		public function warehouse1Description():Boolean {
			if (itemAnyInStorage(gearStorage, 57, 69)) {
				var itemList:Array = [];
				for (var x:int = 57; x < 69; x++)
					if (gearStorage[x].quantity > 0) itemList[itemList.length] = gearStorage[x].itype.longName;
				outputText("  It currently holds " + formatStringArray(itemList) + ".");
				return true;
			}
			return false;
		}
		
		public function warehouse2Description():Boolean {
			if (itemAnyInStorage(gearStorage, 78, 90)) {
				var itemList:Array = [];
				for (var x:int = 78; x < 90; x++)
					if (gearStorage[x].quantity > 0) itemList[itemList.length] = gearStorage[x].itype.longName;
				outputText("  It currently holds " + formatStringArray(itemList) + ".");
				return true;
			}
			return false;
		}
		
		public function granaryDescription():Boolean {
			if (itemAnyInStorage(gearStorage, 69, 78)) {
				var itemList:Array = [];
				for (var x:int = 69; x < 78; x++)
					if (gearStorage[x].quantity > 0) itemList[itemList.length] = gearStorage[x].itype.longName;
				outputText("  It currently holds " + formatStringArray(itemList) + ".");
				return true;
			}
			return false;
		}
		
		private function itemAnyInStorage(storage:Array, startSlot:int, endSlot:int):Boolean {
			for (var x:int = startSlot; x < endSlot; x++) {
				if (storage[x] != undefined) if (storage[x].quantity > 0) return true;
			}
			return false;
		}
		
		private function itemTypeInStorage(storage:Array, startSlot:int, endSlot:int, itype:ItemType):Boolean {
			for (var x:int = startSlot; x < endSlot; x++) {
				if (storage[x] != undefined) if (storage[x].quantity > 0 && storage[x].itype == itype) return true;
			}
			return false;
		}
		
		public function removeItemFromStorage(storage:Array, itype:ItemType):void {
			for (var x:int = 0; x < storage.length; x++) {
				if (storage[x] != undefined) {
					if (storage[x].quantity > 0 && storage[x].itype == itype) {
						storage[x].quantity--;
						return;
					}
				}
			}
		}
		
		public function manageEquipment():void {
			clearOutput();
			outputText("Which would you like to unequip?\n\n");
			menu();
			if (player.weapon != WeaponLib.FISTS)
			{
				addButton(0, "Weapon (M)", unequipWeapon).hint(player.weapon.description, capitalizeFirstLetter(player.weapon.name));
			}
			if (player.weaponRange != WeaponRangeLib.NOTHING)
			{
				addButton(1, "Weapon (R)", unequipWeaponRange).hint(player.weaponRange.description, capitalizeFirstLetter(player.weaponRange.name));
			}
			if (player.shield != ShieldLib.NOTHING)
			{
				addButton(2, "Shield", unequipShield).hint(player.shield.description, capitalizeFirstLetter(player.shield.name));
			}
			if (player.jewelry != JewelryLib.NOTHING)
			{
				addButton(3, "Accessory", unequipJewel).hint(player.jewelry.description, capitalizeFirstLetter(player.jewelry.name));
			}
			if (player.armor != ArmorLib.NOTHING)
			{
				addButton(5, "Armour", unequipArmor).hint(player.armor.description, capitalizeFirstLetter(player.armor.name));
			}
			if (player.upperGarment != UndergarmentLib.NOTHING)
			{
				addButton(6, "Upperwear", unequipUpperwear).hint(player.upperGarment.description, capitalizeFirstLetter(player.upperGarment.name));
			}
			if (player.lowerGarment != UndergarmentLib.NOTHING)
			{
				addButton(7, "Lowerwear", unequipLowerwear).hint(player.lowerGarment.description, capitalizeFirstLetter(player.lowerGarment.name));
			}/*			
			if (player.jewelry != JewelryLib.NOTHING)
			{
				addButton(10, "Necklace", unequipJewel).hint(player.jewelry.description, capitalizeFirstLetter(player.jewelry.name));
			}
			if (player.jewelry != JewelryLib.NOTHING)
			{
				addButton(11, "Ring 1", unequipJewel).hint(player.jewelry.description, capitalizeFirstLetter(player.jewelry.name));
			}
			if (player.jewelry != JewelryLib.NOTHING)
			{
				addButton(12, "Ring 2", unequipJewel).hint(player.jewelry.description, capitalizeFirstLetter(player.jewelry.name));
			}
			if (player.jewelry != JewelryLib.NOTHING)
			{
				addButton(2, "Accessory", unequipJewel).hint(player.jewelry.description, capitalizeFirstLetter(player.jewelry.name));
			}
			zrobić sloty:
			na broń dystansową
			może jeszcze 1-3 kolejne ringi (poza pierwszym orginalnym slotem)
			na naszyjnik
			coś w stylu slotu na prawdziwe akcesoria
			może coś na item związany z soulforce - ala latający miecz lub takie tam itemy ^^
			przy dodawaniu tych slotow popatrzec czy ktorys nie bedzie musial uzywac tego fragmentu kodu:
			else if (item is Shield) {
				player.shield.removeText();
				item = player.setShield(item as Shield); //Item is now the player's old shield
			*/
			addButton(14, "Back", inventoryMenu);
			
		}
		//Unequip!
		private function unequipWeapon():void {
			takeItem(player.setWeapon(WeaponLib.FISTS), inventoryMenu);
		}
		private function unequipWeaponRange():void {
			takeItem(player.setWeaponRange(WeaponRangeLib.NOTHING), inventoryMenu);
		}
		public function unequipArmor():void {
			if (player.armorName != "goo armor") takeItem(player.setArmor(ArmorLib.NOTHING), inventoryMenu); 
			else { //Valeria belongs in the camp, not in your inventory!
				player.armor.removeText();
				player.setArmor(ArmorLib.NOTHING);
				doNext(manageEquipment);
			}
		}
		public function unequipUpperwear():void {
			takeItem(player.setUndergarment(UndergarmentLib.NOTHING, UndergarmentLib.TYPE_UPPERWEAR), inventoryMenu);
		}
		public function unequipLowerwear():void {
			takeItem(player.setUndergarment(UndergarmentLib.NOTHING, UndergarmentLib.TYPE_LOWERWEAR), inventoryMenu);
		}
		public function unequipJewel():void {
			takeItem(player.setJewelry(JewelryLib.NOTHING), inventoryMenu);
		}
		public function unequipShield():void {
			takeItem(player.setShield(ShieldLib.NOTHING), inventoryMenu);
		}

		//Pick item to take from storage
		private function pickItemToTakeFromCampStorage():void {
			callNext = pickItemToTakeFromCampStorage;
			pickItemToTakeFromStorage(itemStorage, 0, itemStorage.length, "storage");
		}
		
		private function pickItemToTakeFromBagOfCosmos():void {
			callNext = pickItemToTakeFromBagOfCosmos;
			pickItemToTakeFromStorage2(gearStorage, 45, 57, "bag");
		}
		
		private function pickItemToTakeFromSkyPoisonPearl1():void {
			callNext = pickItemToTakeFromSkyPoisonPearl1;
			pickItemToTakeFromStorage2(pearlStorage, 0, 14, "sky poison pearl (east section)");
		}
		
		private function pickItemToTakeFromSkyPoisonPearl2():void {
			callNext = pickItemToTakeFromSkyPoisonPearl2;
			pickItemToTakeFromStorage2(pearlStorage, 14, 28, "sky poison pearl (south section)");
		}
		
		private function pickItemToTakeFromSkyPoisonPearl3():void {
			callNext = pickItemToTakeFromSkyPoisonPearl3;
			pickItemToTakeFromStorage2(pearlStorage, 28, 42, "sky poison pearl (west section)");
		}
		
		private function pickItemToTakeFromSkyPoisonPearl4():void {
			callNext = pickItemToTakeFromSkyPoisonPearl4;
			pickItemToTakeFromStorage2(pearlStorage, 42, 56, "sky poison pearl (north section)");
		}
		
		private function pickItemToTakeFromSkyPoisonPearl5():void {
			callNext = pickItemToTakeFromSkyPoisonPearl5;
			pickItemToTakeFromStorage2(pearlStorage, 56, 70, "sky poison pearl (central section)");
		}
		
		private function pickItemToTakeFromSkyPoisonPearl6():void {
			callNext = pickItemToTakeFromSkyPoisonPearl6;
			pickItemToTakeFromStorage2(pearlStorage, 70, 84, "sky poison pearl (above section)");
		}
		
		private function pickItemToTakeFromSkyPoisonPearl7():void {
			callNext = pickItemToTakeFromSkyPoisonPearl7;
			pickItemToTakeFromStorage2(pearlStorage, 84, 98, "sky poison pearl (below section)");
		}
		
		private function pickItemToTakeFromWarehouse1():void {
			callNext = pickItemToTakeFromWarehouse1;
			pickItemToTakeFromStorage3(gearStorage, 57, 69, "1st warehouse");
		}
		
		private function pickItemToTakeFromWarehouse2():void {
			callNext = pickItemToTakeFromWarehouse2;
			pickItemToTakeFromStorage3(gearStorage, 78, 90, "2nd warehouse");
		}
		
		private function pickItemToTakeFromGranary():void {
			callNext = pickItemToTakeFromGranary;
			pickItemToTakeFromStorage3(gearStorage, 69, 78, "granary");
		}
		
		private function pickItemToTakeFromShieldRack():void {
			callNext = pickItemToTakeFromShieldRack;
			pickItemToTakeFromStorage(gearStorage, 36, 45, "rack");
		}
		
		private function pickItemToTakeFromShieldRack2():void {
			callNext = pickItemToTakeFromShieldRack2;
			pickItemToTakeFromStorage3(gearStorage, 36, 45, "rack");
		}
		
		private function pickItemToTakeFromArmorRack():void {
			callNext = pickItemToTakeFromArmorRack;
			pickItemToTakeFromStorage(gearStorage, 9, 18, "rack");
		}
		
		private function pickItemToTakeFromArmorRack2():void {
			callNext = pickItemToTakeFromArmorRack2;
			pickItemToTakeFromStorage3(gearStorage, 9, 18, "rack");
		}
		
		private function pickItemToTakeFromWeaponRack():void {
			callNext = pickItemToTakeFromWeaponRack;
			pickItemToTakeFromStorage(gearStorage, 0, 9, "rack");
		}
		
		private function pickItemToTakeFromWeaponRack2():void {
			callNext = pickItemToTakeFromWeaponRack2;
			pickItemToTakeFromStorage3(gearStorage, 0, 9, "rack");
		}
		
		public function pickItemToTakeFromJewelryBox():void {
			callNext = pickItemToTakeFromJewelryBox;
			pickItemToTakeFromStorage(gearStorage, 18, 27, "box");
		}
		
		public function pickItemToTakeFromDresser():void {
			callNext = pickItemToTakeFromDresser;
			pickItemToTakeFromStorage(gearStorage, 27, 36, "dresser");
		}
		
		private function pickItemToTakeFromStorage(storage:Array, startSlot:int, endSlot:int, text:String):void {
			clearOutput(); //Selects an item from a gear slot. Rewritten so that it no longer needs to use numbered events
			hideUpDown();
			if (!itemAnyInStorage(storage, startSlot, endSlot)) { //If no items are left then return to the camp menu. Can only happen if the player removes the last item.
				playerMenu();
				return;
			}
			outputText("What " + text + " slot do you wish to take an item from?");
			var button:int = 0;
			menu();
			for (var x:int = startSlot; x < endSlot; x++, button++) {
				if (storage[x].quantity > 0) addButton(button, (storage[x].itype.shortName + " x" + storage[x].quantity), createCallBackFunction2(pickFrom, storage, x));
			}
			addButton(14, "Back", stash);
		}
		
		private function pickItemToTakeFromStorage2(storage:Array, startSlot:int, endSlot:int, text:String):void {
			clearOutput(); //Selects an item from a gear slot. Rewritten so that it no longer needs to use numbered events
			hideUpDown();
			if (!itemAnyInStorage(storage, startSlot, endSlot)) { //If no items are left then return to the camp menu. Can only happen if the player removes the last item.
				playerMenu();
				return;
			}
			outputText("What " + text + " slot do you wish to take an item from?");
			var button:int = 0;
			menu();
			for (var x:int = startSlot; x < endSlot; x++, button++) {
				if (storage[x].quantity > 0) addButton(button, (storage[x].itype.shortName + " x" + storage[x].quantity), createCallBackFunction2(pickFrom, storage, x));
			}
			addButton(14, "Back", inventoryMenu);
		}
		
		private function pickItemToTakeFromStorage3(storage:Array, startSlot:int, endSlot:int, text:String):void {
			clearOutput(); //Selects an item from a gear slot. Rewritten so that it no longer needs to use numbered events
			hideUpDown();
			if (!itemAnyInStorage(storage, startSlot, endSlot)) { //If no items are left then return to the camp menu. Can only happen if the player removes the last item.
				playerMenu();
				return;
			}
			outputText("What " + text + " slot do you wish to take an item from?");
			var button:int = 0;
			menu();
			for (var x:int = startSlot; x < endSlot; x++, button++) {
				if (storage[x].quantity > 0) addButton(button, (storage[x].itype.shortName + " x" + storage[x].quantity), createCallBackFunction2(pickFrom, storage, x));
			}
			addButton(14, "Back", warehouse);
		}
		
		private function pickFrom(storage:Array, slotNum:int):void {
			clearOutput();
			var itype:ItemType = storage[slotNum].itype;
			storage[slotNum].quantity--;
			inventory.takeItem(itype, callNext, callNext, storage[slotNum]);
		}
		
		//Pick items to place in storage
		private function pickItemToPlaceInCampStorage():void { pickItemToPlaceInStorage(placeInCampStorage, allAcceptable, "storage containers", false); }
		
		private function pickItemToPlaceInBagOfCosmos():void { pickItemToPlaceInStorage2(placeInBagOfCosmos, allAcceptable, "bag of cosmos", false); }
		
		private function pickItemToPlaceInSkyPoisonPearl1():void { pickItemToPlaceInStorage2(placeInSkyPoisonPearl1, allAcceptable, "sky poison pearl (east section)", false); }
		
		private function pickItemToPlaceInSkyPoisonPearl2():void { pickItemToPlaceInStorage2(placeInSkyPoisonPearl2, allAcceptable, "sky poison pearl (south section)", false); }
		
		private function pickItemToPlaceInSkyPoisonPearl3():void { pickItemToPlaceInStorage2(placeInSkyPoisonPearl3, allAcceptable, "sky poison pearl (west section)", false); }
		
		private function pickItemToPlaceInSkyPoisonPearl4():void { pickItemToPlaceInStorage2(placeInSkyPoisonPearl4, allAcceptable, "sky poison pearl (north section)", false); }
		
		private function pickItemToPlaceInSkyPoisonPearl5():void { pickItemToPlaceInStorage2(placeInSkyPoisonPearl5, allAcceptable, "sky poison pearl (central section)", false); }
		
		private function pickItemToPlaceInSkyPoisonPearl6():void { pickItemToPlaceInStorage2(placeInSkyPoisonPearl6, allAcceptable, "sky poison pearl (above section)", false); }
		
		private function pickItemToPlaceInSkyPoisonPearl7():void { pickItemToPlaceInStorage2(placeInSkyPoisonPearl7, allAcceptable, "sky poison pearl (below section)", false); }
		
		private function pickItemToPlaceInWarehouse1():void { pickItemToPlaceInStorage3(placeInWarehouse1, allAcceptable, "1st warehouse", false); }
		
		private function pickItemToPlaceInWarehouse2():void { pickItemToPlaceInStorage3(placeInWarehouse2, allAcceptable, "2nd warehouse", false); }
		
		private function pickItemToPlaceInGranary():void { pickItemToPlaceInStorage3(placeInGranary, consumableAcceptable, "granary", true); }
		
		private function pickItemToPlaceInArmorRack():void { pickItemToPlaceInStorage(placeInArmorRack, armorAcceptable, "armor rack", true); }
		
		private function pickItemToPlaceInArmorRack2():void { pickItemToPlaceInStorage3(placeInArmorRack2, armorAcceptable, "armor rack", true); }
		
		private function pickItemToPlaceInWeaponRack():void { pickItemToPlaceInStorage(placeInWeaponRack, weaponAcceptable, "weapon rack", true); }
		
		private function pickItemToPlaceInWeaponRack2():void { pickItemToPlaceInStorage3(placeInWeaponRack2, weaponAcceptable, "weapon rack", true); }
		
		private function pickItemToPlaceInShieldRack():void { pickItemToPlaceInStorage(placeInShieldRack, shieldAcceptable, "shield rack", true); }
		
		private function pickItemToPlaceInShieldRack2():void { pickItemToPlaceInStorage3(placeInShieldRack2, shieldAcceptable, "shield rack", true); }
		
		public function pickItemToPlaceInJewelryBox():void { pickItemToPlaceInStorage(placeInJewelryBox, jewelryAcceptable, "jewelry box", true); }
		
		public function pickItemToPlaceInDresser():void { pickItemToPlaceInStorage(placeInDresser, undergarmentAcceptable, "dresser", true); }
		
		//Acceptable type of items
		private function allAcceptable(itype:ItemType):Boolean { return true; }
		
		private function consumableAcceptable(itype:ItemType):Boolean { return itype is Consumable; }
		
		private function armorAcceptable(itype:ItemType):Boolean { return itype is Armor; }
		
		private function weaponAcceptable(itype:ItemType):Boolean { return itype is (Weapon || WeaponRange); }

		private function shieldAcceptable(itype:ItemType):Boolean { return itype is Shield; }
		
		private function jewelryAcceptable(itype:ItemType):Boolean { return itype is Jewelry; }
		
		private function undergarmentAcceptable(itype:ItemType):Boolean { return itype is Undergarment; }
		
		//Place in storage functions
		private function pickItemToPlaceInStorage(placeInStorageFunction:Function, typeAcceptableFunction:Function, text:String, showEmptyWarning:Boolean):void {
			clearOutput(); //Selects an item to place in a gear slot. Rewritten so that it no longer needs to use numbered events
			hideUpDown();
			outputText("What item slot do you wish to empty into your " + text + "?");
			menu();
			var foundItem:Boolean = false;
			for (var x:int = 0; x < 10; x++) {
				if (player.itemSlots[x].unlocked && player.itemSlots[x].quantity > 0 && typeAcceptableFunction(player.itemSlots[x].itype)) {
					addButton(x, (player.itemSlots[x].itype.shortName + " x" + player.itemSlots[x].quantity), placeInStorageFunction, x);
					foundItem = true;
				}
			}
			if (showEmptyWarning && !foundItem) outputText("\n<b>You have no appropriate items to put in this " + text + ".</b>");
			addButton(14, "Back", stash);
		}
		
		private function pickItemToPlaceInStorage2(placeInStorageFunction:Function, typeAcceptableFunction:Function, text:String, showEmptyWarning:Boolean):void {
			clearOutput(); //Selects an item to place in a gear slot. Rewritten so that it no longer needs to use numbered events
			hideUpDown();
			outputText("What item slot do you wish to empty into your " + text + "?");
			menu();
			var foundItem:Boolean = false;
			for (var x:int = 0; x < 10; x++) {
				if (player.itemSlots[x].unlocked && player.itemSlots[x].quantity > 0 && typeAcceptableFunction(player.itemSlots[x].itype)) {
					addButton(x, (player.itemSlots[x].itype.shortName + " x" + player.itemSlots[x].quantity), placeInStorageFunction, x);
					foundItem = true;
				}
			}
			if (showEmptyWarning && !foundItem) outputText("\n<b>You have no appropriate items to put in this " + text + ".</b>");
			addButton(14, "Back", inventoryMenu);
		}
		
		private function pickItemToPlaceInStorage3(placeInStorageFunction:Function, typeAcceptableFunction:Function, text:String, showEmptyWarning:Boolean):void {
			clearOutput(); //Selects an item to place in a gear slot. Rewritten so that it no longer needs to use numbered events
			hideUpDown();
			outputText("What item slot do you wish to empty into your " + text + "?");
			menu();
			var foundItem:Boolean = false;
			for (var x:int = 0; x < 10; x++) {
				if (player.itemSlots[x].unlocked && player.itemSlots[x].quantity > 0 && typeAcceptableFunction(player.itemSlots[x].itype)) {
					addButton(x, (player.itemSlots[x].itype.shortName + " x" + player.itemSlots[x].quantity), placeInStorageFunction, x);
					foundItem = true;
				}
			}
			if (showEmptyWarning && !foundItem) outputText("\n<b>You have no appropriate items to put in this " + text + ".</b>");
			addButton(14, "Back", warehouse);
		}
		
		private function placeInCampStorage(slotNum:int):void {
			placeIn(itemStorage, 0, itemStorage.length, slotNum);
			doNext(pickItemToPlaceInCampStorage);
		}
		
		private function placeInBagOfCosmos(slotNum:int):void {
			placeIn(gearStorage, 45, 57, slotNum);
			doNext(pickItemToPlaceInBagOfCosmos);
		}
		
		private function placeInSkyPoisonPearl1(slotNum:int):void {
			placeIn(pearlStorage, 0, 14, slotNum);
			doNext(pickItemToPlaceInSkyPoisonPearl1);
		}
		
		private function placeInSkyPoisonPearl2(slotNum:int):void {
			placeIn(pearlStorage, 14, 28, slotNum);
			doNext(pickItemToPlaceInSkyPoisonPearl2);
		}
		
		private function placeInSkyPoisonPearl3(slotNum:int):void {
			placeIn(pearlStorage, 28, 42, slotNum);
			doNext(pickItemToPlaceInSkyPoisonPearl3);
		}
		
		private function placeInSkyPoisonPearl4(slotNum:int):void {
			placeIn(pearlStorage, 42, 56, slotNum);
			doNext(pickItemToPlaceInSkyPoisonPearl4);
		}
		
		private function placeInSkyPoisonPearl5(slotNum:int):void {
			placeIn(pearlStorage, 56, 70, slotNum);
			doNext(pickItemToPlaceInSkyPoisonPearl5);
		}
		
		private function placeInSkyPoisonPearl6(slotNum:int):void {
			placeIn(pearlStorage, 70, 84, slotNum);
			doNext(pickItemToPlaceInSkyPoisonPearl6);
		}
		
		private function placeInSkyPoisonPearl7(slotNum:int):void {
			placeIn(pearlStorage, 84, 98, slotNum);
			doNext(pickItemToPlaceInSkyPoisonPearl7);
		}
		
		private function placeInWarehouse1(slotNum:int):void {
			placeIn(gearStorage, 57, 69, slotNum);
			doNext(pickItemToPlaceInWarehouse1);
		}
		
		private function placeInWarehouse2(slotNum:int):void {
			placeIn(gearStorage, 78, 90, slotNum);
			doNext(pickItemToPlaceInWarehouse2);
		}
		
		private function placeInGranary(slotNum:int):void {
			placeIn(gearStorage, 69, 78, slotNum);
			doNext(pickItemToPlaceInGranary);
		}
		
		private function placeInArmorRack2(slotNum:int):void {
			placeIn(gearStorage, 9, 18, slotNum);
			doNext(pickItemToPlaceInArmorRack2);
		}
		
		private function placeInArmorRack(slotNum:int):void {
			placeIn(gearStorage, 9, 18, slotNum);
			doNext(pickItemToPlaceInArmorRack);
		}
		
		private function placeInWeaponRack2(slotNum:int):void {
			placeIn(gearStorage, 0, 9, slotNum);
			doNext(pickItemToPlaceInWeaponRack2);
		}
		
		private function placeInWeaponRack(slotNum:int):void {
			placeIn(gearStorage, 0, 9, slotNum);
			doNext(pickItemToPlaceInWeaponRack);
		}
		
		private function placeInShieldRack2(slotNum:int):void {
			placeIn(gearStorage, 36, 45, slotNum);
			doNext(pickItemToPlaceInShieldRack2);
		}
		
		private function placeInShieldRack(slotNum:int):void {
			placeIn(gearStorage, 36, 45, slotNum);
			doNext(pickItemToPlaceInShieldRack);
		}
		
		private function placeInJewelryBox(slotNum:int):void {
			placeIn(gearStorage, 18, 27, slotNum);
			doNext(pickItemToPlaceInJewelryBox);
		}
		
		private function placeInDresser(slotNum:int):void {
			placeIn(gearStorage, 27, 36, slotNum);
			doNext(pickItemToPlaceInDresser);
		}
		
		private function placeIn(storage:Array, startSlot:int, endSlot:int, slotNum:int):void {
			clearOutput();
			var x:int;
			var temp:int;
			var itype:ItemType = player.itemSlots[slotNum].itype;
			var qty:int = player.itemSlots[slotNum].quantity;
			var orig:int = qty;
			player.itemSlots[slotNum].emptySlot();
			for (x = startSlot; x < endSlot && qty > 0; x++) { //Find any slots which already hold the item that is being stored
				if (storage[x].itype == itype && storage[x].quantity < 5) {
					temp = 5 - storage[x].quantity;
					if (qty < temp) temp = qty;
					outputText("You add " + temp + "x " + itype.shortName + " into storage slot " + num2Text(x + 1 - startSlot) + ".\n");
					storage[x].quantity += temp;
					qty -= temp;
					if (qty == 0) return;
				}
			}
			for (x = startSlot; x < endSlot && qty > 0; x++) { //Find any empty slots and put the item(s) there
				if (storage[x].quantity == 0) {
					storage[x].setItemAndQty(itype, qty);
					outputText("You place " + qty + "x " + itype.shortName + " into storage slot " + num2Text(x + 1 - startSlot) + ".\n");
					qty = 0;
					return;
				}
			}
			outputText("There is no room for " + (orig == qty ? "" : "the remaining ") + qty + "x " + itype.shortName + ".  You leave " + (qty > 1 ? "them" : "it") + " in your inventory.\n");
			player.itemSlots[slotNum].setItemAndQty(itype, qty);
		}
	}
}