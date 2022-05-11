package classes.Scenes 
{
	import classes.*;
	import classes.BaseContent;
	import classes.GlobalFlags.*;
	import classes.Items.*;
	import classes.internals.SaveableState;

	public class Crafting extends BaseContent implements SaveableState
	{
		public static var BagSlot01:Number;
		public static var BagSlot01Cap:Number;//Cooper Ore
		public static var BagSlot02:Number;
		public static var BagSlot02Cap:Number;//Tin Ore
		public static var BagSlot03:Number;
		public static var BagSlot03Cap:Number;//Bronze Bar
		public static var BagSlot04:Number;
		public static var BagSlot04Cap:Number;//Iron Ore
		public static var BagSlot05:Number;
		public static var BagSlot05Cap:Number;//Ebonbloom
		public static var BagSlot06:Number;
		public static var BagSlot06Cap:Number;//Ebon Ingot
		public static var BagSlot07:Number;
		public static var BagSlot07Cap:Number;//Moonstone
		public static var BagSlot08:Number;
		public static var BagSlot08Cap:Number;//Skymetal
		public static var BagSlot09:Number;
		public static var BagSlot09Cap:Number;
		public static var BagSlot10:Number;
		public static var BagSlot10Cap:Number;
		public static var BagSlot11:Number;
		public static var BagSlot11Cap:Number;
		public static var BagSlot12:Number;
		public static var BagSlot12Cap:Number;
		public static var BagSlot13:Number;
		public static var BagSlot13Cap:Number;
		public static var BagSlot14:Number;
		public static var BagSlot14Cap:Number;
		public static var BagSlot15:Number;
		public static var BagSlot15Cap:Number;
		public static var BagSlot16:Number;
		public static var BagSlot16Cap:Number;
		public static var BagSlot17:Number;
		public static var BagSlot17Cap:Number;
		public static var BagSlot18:Number;
		public static var BagSlot18Cap:Number;
		public static var BagSlot19:Number;
		public static var BagSlot19Cap:Number;
		public static var BagSlot20:Number;
		public static var BagSlot20Cap:Number;
		public static var BagSlot21:Number;
		public static var BagSlot21Cap:Number;
		public static var BagSlot22:Number;
		public static var BagSlot22Cap:Number;
		public static var BagSlot23:Number;
		public static var BagSlot23Cap:Number;
		public static var BagSlot24:Number;
		public static var BagSlot24Cap:Number;
		public static var BagSlot25:Number;
		public static var BagSlot25Cap:Number;
		public static var BagSlot26:Number;
		public static var BagSlot26Cap:Number;
		public static var BagSlot27:Number;
		public static var BagSlot27Cap:Number;
		public static var BagSlot28:Number;
		public static var BagSlot28Cap:Number;
		public static var BagSlot29:Number;
		public static var BagSlot29Cap:Number;
		public static var BagSlot30:Number;
		public static var BagSlot30Cap:Number;
		public static var BagSlot31:Number;
		public static var BagSlot31Cap:Number;
		public static var BagSlot32:Number;
		public static var BagSlot32Cap:Number;
		public static var BagSlot33:Number;
		public static var BagSlot33Cap:Number;
		public static var BagSlot34:Number;
		public static var BagSlot34Cap:Number;
		public static var BagSlot35:Number;
		public static var BagSlot35Cap:Number;
		public static var BagSlot36:Number;
		public static var BagSlot36Cap:Number;
		public static var BagSlot37:Number;
		public static var BagSlot37Cap:Number;
		public static var BagSlot38:Number;
		public static var BagSlot38Cap:Number;
		public static var BagSlot39:Number;
		public static var BagSlot39Cap:Number;
		public static var BagSlot40:Number;
		public static var BagSlot40Cap:Number;

		public function stateObjectName():String {
			return "Crafting";
		}

		public function resetState():void {
			BagSlot01 = 0;
			BagSlot01Cap = 0;
			BagSlot02 = 0;
			BagSlot02Cap = 0;
			BagSlot03 = 0;
			BagSlot03Cap = 0;
			BagSlot04 = 0;
			BagSlot04Cap = 0;
			BagSlot05 = 0;
			BagSlot05Cap = 0;
			BagSlot06 = 0;
			BagSlot06Cap = 0;
			BagSlot07 = 0;
			BagSlot07Cap = 0;
			BagSlot08 = 0;
			BagSlot08Cap = 0;
			BagSlot09 = 0;
			BagSlot09Cap = 0;
			BagSlot10 = 0;
			BagSlot10Cap = 0;
			BagSlot11 = 0;
			BagSlot11Cap = 0;
			BagSlot12 = 0;
			BagSlot12Cap = 0;
			BagSlot13 = 0;
			BagSlot13Cap = 0;
			BagSlot14 = 0;
			BagSlot14Cap = 0;
			BagSlot15 = 0;
			BagSlot15Cap = 0;
			BagSlot16 = 0;
			BagSlot16Cap = 0;
			BagSlot17 = 0;
			BagSlot17Cap = 0;
			BagSlot18 = 0;
			BagSlot18Cap = 0;
			BagSlot19 = 0;
			BagSlot19Cap = 0;
			BagSlot20 = 0;
			BagSlot20Cap = 0;
			BagSlot21 = 0;
			BagSlot21Cap = 0;
			BagSlot22 = 0;
			BagSlot22Cap = 0;
			BagSlot23 = 0;
			BagSlot23Cap = 0;
			BagSlot24 = 0;
			BagSlot24Cap = 0;
			BagSlot25 = 0;
			BagSlot25Cap = 0;
			BagSlot26 = 0;
			BagSlot26Cap = 0;
			BagSlot27 = 0;
			BagSlot27Cap = 0;
			BagSlot28 = 0;
			BagSlot28Cap = 0;
			BagSlot29 = 0;
			BagSlot29Cap = 0;
			BagSlot30 = 0;
			BagSlot30Cap = 0;
			BagSlot31 = 0;
			BagSlot31Cap = 0;
			BagSlot32 = 0;
			BagSlot32Cap = 0;
			BagSlot33 = 0;
			BagSlot33Cap = 0;
			BagSlot34 = 0;
			BagSlot34Cap = 0;
			BagSlot35 = 0;
			BagSlot35Cap = 0;
			BagSlot36 = 0;
			BagSlot36Cap = 0;
			BagSlot37 = 0;
			BagSlot37Cap = 0;
			BagSlot38 = 0;
			BagSlot38Cap = 0;
			BagSlot39 = 0;
			BagSlot39Cap = 0;
			BagSlot40 = 0;
			BagSlot40Cap = 0;
		}

		public function saveToObject():Object {
			return {
				"BagSlot01": BagSlot01,
				"BagSlot01Cap": BagSlot01Cap,
				"BagSlot02": BagSlot02,
				"BagSlot02Cap": BagSlot02Cap,
				"BagSlot03": BagSlot03,
				"BagSlot03Cap": BagSlot03Cap,
				"BagSlot04": BagSlot04,
				"BagSlot04Cap": BagSlot04Cap,
				"BagSlot05": BagSlot05,
				"BagSlot05Cap": BagSlot05Cap,
				"BagSlot06": BagSlot06,
				"BagSlot06Cap": BagSlot06Cap,
				"BagSlot07": BagSlot07,
				"BagSlot07Cap": BagSlot07Cap,
				"BagSlot08": BagSlot08,
				"BagSlot08Cap": BagSlot08Cap,
				"BagSlot09": BagSlot09,
				"BagSlot09Cap": BagSlot09Cap,
				"BagSlot10": BagSlot10,
				"BagSlot10Cap": BagSlot10Cap,
				"BagSlot11": BagSlot11,
				"BagSlot11Cap": BagSlot11Cap,
				"BagSlot12": BagSlot12,
				"BagSlot12Cap": BagSlot12Cap,
				"BagSlot13": BagSlot13,
				"BagSlot13Cap": BagSlot13Cap,
				"BagSlot14": BagSlot14,
				"BagSlot14Cap": BagSlot14Cap,
				"BagSlot15": BagSlot15,
				"BagSlot15Cap": BagSlot15Cap,
				"BagSlot16": BagSlot16,
				"BagSlot16Cap": BagSlot16Cap,
				"BagSlot17": BagSlot17,
				"BagSlot17Cap": BagSlot17Cap,
				"BagSlot18": BagSlot18,
				"BagSlot18Cap": BagSlot18Cap,
				"BagSlot19": BagSlot19,
				"BagSlot19Cap": BagSlot19Cap,
				"BagSlot20": BagSlot20,
				"BagSlot20Cap": BagSlot20Cap,
				"BagSlot21": BagSlot21,
				"BagSlot21Cap": BagSlot21Cap,
				"BagSlot22": BagSlot22,
				"BagSlot22Cap": BagSlot22Cap,
				"BagSlot23": BagSlot23,
				"BagSlot23Cap": BagSlot23Cap,
				"BagSlot24": BagSlot24,
				"BagSlot24Cap": BagSlot24Cap,
				"BagSlot25": BagSlot25,
				"BagSlot25Cap": BagSlot25Cap,
				"BagSlot26": BagSlot26,
				"BagSlot26Cap": BagSlot26Cap,
				"BagSlot27": BagSlot27,
				"BagSlot27Cap": BagSlot27Cap,
				"BagSlot28": BagSlot28,
				"BagSlot28Cap": BagSlot28Cap,
				"BagSlot29": BagSlot29,
				"BagSlot29Cap": BagSlot29Cap,
				"BagSlot30": BagSlot30,
				"BagSlot30Cap": BagSlot30Cap,
				"BagSlot21": BagSlot31,
				"BagSlot21Cap": BagSlot31Cap,
				"BagSlot22": BagSlot32,
				"BagSlot22Cap": BagSlot32Cap,
				"BagSlot23": BagSlot33,
				"BagSlot23Cap": BagSlot33Cap,
				"BagSlot24": BagSlot34,
				"BagSlot24Cap": BagSlot34Cap,
				"BagSlot25": BagSlot35,
				"BagSlot25Cap": BagSlot35Cap,
				"BagSlot26": BagSlot36,
				"BagSlot26Cap": BagSlot36Cap,
				"BagSlot27": BagSlot37,
				"BagSlot27Cap": BagSlot37Cap,
				"BagSlot28": BagSlot38,
				"BagSlot28Cap": BagSlot38Cap,
				"BagSlot29": BagSlot39,
				"BagSlot29Cap": BagSlot39Cap,
				"BagSlot30": BagSlot40,
				"BagSlot30Cap": BagSlot40Cap
			};
		}

		public function loadFromObject(o:Object, ignoreErrors:Boolean):void {
			if (o) {
				BagSlot01 = o["BagSlot01"];
				BagSlot01Cap = o["BagSlot01Cap"];
				BagSlot02 = o["BagSlot02"];
				BagSlot02Cap = o["BagSlot02Cap"];
				BagSlot03 = o["BagSlot03"];
				BagSlot03Cap = o["BagSlot03Cap"];
				BagSlot04 = o["BagSlot04"];
				BagSlot04Cap = o["BagSlot04Cap"];
				BagSlot05 = o["BagSlot05"];
				BagSlot05Cap = o["BagSlot05Cap"];
				BagSlot06 = o["BagSlot06"];
				BagSlot06Cap = o["BagSlot06Cap"];
				BagSlot07 = o["BagSlot07"];
				BagSlot07Cap = o["BagSlot07Cap"];
				BagSlot08 = o["BagSlot08"];
				BagSlot08Cap = o["BagSlot08Cap"];
				BagSlot09 = o["BagSlot09"];
				BagSlot09Cap = o["BagSlot09Cap"];
				BagSlot10 = o["BagSlot10"];
				BagSlot10Cap = o["BagSlot10Cap"];
				BagSlot11 = o["BagSlot11"];
				BagSlot11Cap = o["BagSlot11Cap"];
				BagSlot12 = o["BagSlot12"];
				BagSlot12Cap = o["BagSlot12Cap"];
				BagSlot13 = o["BagSlot13"];
				BagSlot13Cap = o["BagSlot13Cap"];
				BagSlot14 = o["BagSlot14"];
				BagSlot14Cap = o["BagSlot14Cap"];
				BagSlot15 = o["BagSlot15"];
				BagSlot15Cap = o["BagSlot15Cap"];
				BagSlot16 = o["BagSlot16"];
				BagSlot16Cap = o["BagSlot16Cap"];
				BagSlot17 = o["BagSlot17"];
				BagSlot17Cap = o["BagSlot17Cap"];
				BagSlot18 = o["BagSlot18"];
				BagSlot18Cap = o["BagSlot18Cap"];
				BagSlot19 = o["BagSlot19"];
				BagSlot19Cap = o["BagSlot19Cap"];
				BagSlot20 = o["BagSlot20"];
				BagSlot20Cap = o["BagSlot20Cap"];
				BagSlot21 = o["BagSlot21"];
				BagSlot21Cap = o["BagSlot21Cap"];
				BagSlot22 = o["BagSlot22"];
				BagSlot22Cap = o["BagSlot22Cap"];
				BagSlot23 = o["BagSlot23"];
				BagSlot23Cap = o["BagSlot23Cap"];
				BagSlot24 = o["BagSlot24"];
				BagSlot24Cap = o["BagSlot24Cap"];
				BagSlot25 = o["BagSlot25"];
				BagSlot25Cap = o["BagSlot25Cap"];
				BagSlot26 = o["BagSlot26"];
				BagSlot26Cap = o["BagSlot26Cap"];
				BagSlot27 = o["BagSlot27"];
				BagSlot27Cap = o["BagSlot27Cap"];
				BagSlot28 = o["BagSlot28"];
				BagSlot28Cap = o["BagSlot28Cap"];
				BagSlot29 = o["BagSlot29"];
				BagSlot29Cap = o["BagSlot29Cap"];
				BagSlot30 = o["BagSlot30"];
				BagSlot30Cap = o["BagSlot30Cap"];
				BagSlot21 = o["BagSlot31"];
				BagSlot21Cap = o["BagSlot31Cap"];
				BagSlot22 = o["BagSlot32"];
				BagSlot22Cap = o["BagSlot32Cap"];
				BagSlot23 = o["BagSlot33"];
				BagSlot23Cap = o["BagSlot33Cap"];
				BagSlot24 = o["BagSlot34"];
				BagSlot24Cap = o["BagSlot34Cap"];
				BagSlot25 = o["BagSlot35"];
				BagSlot25Cap = o["BagSlot35Cap"];
				BagSlot26 = o["BagSlot36"];
				BagSlot26Cap = o["BagSlot36Cap"];
				BagSlot27 = o["BagSlot37"];
				BagSlot27Cap = o["BagSlot37Cap"];
				BagSlot28 = o["BagSlot38"];
				BagSlot28Cap = o["BagSlot38Cap"];
				BagSlot29 = o["BagSlot39"];
				BagSlot29Cap = o["BagSlot39Cap"];
				BagSlot30 = o["BagSlot40"];
				BagSlot30Cap = o["BagSlot40Cap"];
			} else {
				// loading from old save
				resetState();
			}
		}
		/*
		public static const TYPE_ALCHEMY:int = 0;
		public static const TYPE_COOKING:int = 1;
		public static const TYPE_SMITHING:int = 2;
		public static const TYPE_TAILORING:int = 3;
		
		private var item1:ItemType = null;
		private var item1Quantity:int = 0;
		private var item2:ItemType = null;
		private var item2Quantity:int = 0;
		private var item3:ItemType = null;
		private var item3Quantity:int = 0;
		private var item4:ItemType = null;
		private var item4Quantity:int = 0;
		private var itemResult:ItemType = null;
		*/
		public function Crafting() {
			Saves.registerSaveableState(this);
		}
		
public function accessCraftingMaterialsBag():void {
	clearOutput();
	outputText("Would you like to put some crafting materials into the bag, and if so, with ones?\n\n");
	if (BagSlot01Cap > 0) outputText("<b>Cooper Ore:</b> "+BagSlot01+" / "+BagSlot01Cap+"\n");
	if (BagSlot02Cap > 0) outputText("<b>Tin Ore:</b> "+BagSlot02+" / "+BagSlot02Cap+"\n");
	if (BagSlot03Cap > 0) outputText("<b>Bronze Bar:</b> "+BagSlot03+" / "+BagSlot03Cap+"\n");
	if (BagSlot04Cap > 0) outputText("<b>Iron Ore:</b> "+BagSlot04+" / "+BagSlot04Cap+"\n");
	if (BagSlot05Cap > 0) outputText("<b>Ebonbloom:</b> "+BagSlot05+" / "+BagSlot05Cap+"\n");
	if (BagSlot06Cap > 0) outputText("<b>Ebon Ingot:</b> "+BagSlot06+" / "+BagSlot06Cap+"\n");
	//if (BagSlot07Cap > 0) outputText("<b>Moonstone:</b> "+BagSlot07+" / "+BagSlot07Cap+"\n");
	//if (BagSlot08Cap > 0) outputText("<b>Skymetal:</b> "+BagSlot08+" / "+BagSlot08Cap+"\n");
	menu();
	if (BagSlot01 < BagSlot01Cap) {
		if (player.hasItem(useables.COP_ORE, 1)) addButton(0, "CopperOre", craftingMaterialsCopperOre1UP);
		else addButtonDisabled(0, "CopperOre", "You not have any copper ore to store.");
	}
	else addButtonDisabled(0, "CopperOre", "You can't store more copper ore in your bag.");
	if (BagSlot01 > 0) addButton(1, "CopperOre", craftingMaterialsCopperOre1Down);
	else addButtonDisabled(1, "CopperOre", "You not have any copper ore in your bag.");
	if (BagSlot02 < BagSlot02Cap) {
		if (player.hasItem(useables.TIN_ORE, 1)) addButton(2, "TinOre", craftingMaterialsTinOre1UP);
		else addButtonDisabled(2, "TinOre", "You not have any tin ore to store.");
	}
	else addButtonDisabled(2, "TinOre", "You can't store more tin ore in your bag.");
	if (BagSlot02 > 0) addButton(3, "TinOre", craftingMaterialsTinOre1Down);
	else addButtonDisabled(3, "TinOre", "You not have any tin ore in your bag.");
	if (BagSlot03 < BagSlot03Cap) {
		if (player.hasItem(useables.BRONZEB, 1)) addButton(5, "BronzeBar", craftingMaterialsBronzeBar1UP);
		else addButtonDisabled(5, "BronzeBar", "You not have any bronze bar to store.");
	}
	else addButtonDisabled(5, "BronzeBar", "You can't store more copper ore in your bag.");
	if (BagSlot03 > 0) addButton(6, "BronzeBar", craftingMaterialsBronzeBar1Down);
	else addButtonDisabled(6, "BronzeBar", "You not have any bronze bar in your bag.");
	if (BagSlot04 < BagSlot04Cap) {
		if (player.hasItem(useables.IRONORE, 1)) addButton(7, "IronOre", craftingMaterialsIronOre1UP);
		else addButtonDisabled(7, "IronOre", "You not have any iron ore to store.");
	}
	else addButtonDisabled(7, "IronOre", "You can't store more iron ore in your bag.");
	if (BagSlot04 > 0) addButton(8, "IronOre", craftingMaterialsIronOre1Down);
	else addButtonDisabled(8, "IronOre", "You not have any iron ore in your bag.");
	addButton(14, "Back", camp.campActions);
}
private function craftingMaterialsCopperOre1UP():void {
	player.destroyItems(useables.COP_ORE, 1);
	BagSlot01 += 1;
	doNext(accessCraftingMaterialsBag);
}
private function craftingMaterialsCopperOre1Down():void {
	outputText("\n");
	BagSlot01 -= 1;
	inventory.takeItem(useables.COP_ORE, accessCraftingMaterialsBag);
}
private function craftingMaterialsTinOre1UP():void {
	player.destroyItems(useables.COP_ORE, 1);
	BagSlot02 += 1;
	doNext(accessCraftingMaterialsBag);
}
private function craftingMaterialsTinOre1Down():void {
	outputText("\n");
	BagSlot02 -= 1;
	inventory.takeItem(useables.COP_ORE, accessCraftingMaterialsBag);
}
private function craftingMaterialsBronzeBar1UP():void {
	player.destroyItems(useables.BRONZEB, 1);
	BagSlot03 += 1;
	doNext(accessCraftingMaterialsBag);
}
private function craftingMaterialsBronzeBar1Down():void {
	outputText("\n");
	BagSlot03 -= 1;
	inventory.takeItem(useables.BRONZEB, accessCraftingMaterialsBag);
}
private function craftingMaterialsIronOre1UP():void {
	player.destroyItems(useables.IRONORE, 1);
	BagSlot04 += 1;
	doNext(accessCraftingMaterialsBag);
}
private function craftingMaterialsIronOre1Down():void {
	outputText("\n");
	BagSlot04 -= 1;
	inventory.takeItem(useables.IRONORE, accessCraftingMaterialsBag);
}
		/*
		public function accessCraftingMenu(type:int, page:int = 1):void {
			clearOutput();
			outputText("What would you like to craft?");
			menu();
			if (type == TYPE_ALCHEMY) {
				
			}
			else if (type == TYPE_COOKING) {
				
			}
			else if (type == TYPE_SMITHING) {
				
			}
			else if (type == TYPE_TAILORING) {
				
			}
			addButton(14, "Back", campActions);
		}
		
		private function createCraftingRecipe(item:*, recipe:Array):void {
			var button:int = 0;
			var temp:int = 0;
			var goal:int = 14;
			while (temp < goal)
			{
				if (buttonIsVisible(temp)) {
					button++;
				}
				if (button == 4 || button == 9) button++;
				temp++;
			}
			addButton(button, item.shortName, displayCraftingRequirement, item, recipe);
		}
		
		private function meetsItemRequirement(id:int):Boolean {
			if (id == 1) {
				if (item1 == null) return true;
				if (player.hasItem(item1, item1Quantity)) return true;
			}
			else if (id == 2) {
				if (item2 == null) return true;
				if (player.hasItem(item2, item2Quantity)) return true;
			}
			else if (id == 3) {
				if (item3 == null) return true;
				if (player.hasItem(item3, item3Quantity)) return true;
			}
			else if (id == 4) {
				if (item4 == null) return true;
				if (player.hasItem(item4, item4Quantity)) return true;
			}
			return false;
		}
		
		private function displayCraftingRequirement(item:ItemType, recipe:Array):void {
			//Item #1
			if (recipe[0] != undefined) item1 = recipe[0];
			else item1 = null;
			if (recipe[1] != undefined) item1Quantity = recipe[1];
			//Item #2
			if (recipe[2] != undefined) item2 = recipe[2];
			else item2 = null;
			if (recipe[3] != undefined) item2Quantity = recipe[3];
			//Item #3
			if (recipe[4] != undefined) item3 = recipe[4];
			else item3 = null;
			if (recipe[5] != undefined) item3Quantity = recipe[5];
			//Item #4
			if (recipe[6] != undefined) item4 = recipe[6];
			else item4 = null;
			if (recipe[7] != undefined) item4Quantity = recipe[7];
			//Set result item
			itemResult = item;
			clearOutput();
			outputText("<b>Item:</b> " + item.longName + "\n\n");
			outputText("<b><u>Items Needed:</u></b>\n");
			if (item1 != null) {
				if (player.hasItem(item1, item1Quantity)) outputText("<font color=\"#008000\">" + player.itemCount(item1) + " / " + item1Quantity + " " + item1.longName + "</font>");
				else outputText("<font color=\"#800000\">" + player.itemCount(item1) + " / " + item1Quantity + " " + item1.longName + "</font>");
				outputText("\n");
			}
			if (item2 != null) {
				if (player.hasItem(item2, item2Quantity)) outputText("<font color=\"#008000\">" + player.itemCount(item2) + " / " + item2Quantity + " " + item2.longName + "</font>");
				else outputText("<font color=\"#800000\">" + player.itemCount(item2) + " / " + item2Quantity + " " + item2.longName + "</font>");
				outputText("\n");
			}
			if (item3 != null) {
				if (player.hasItem(item3, item3Quantity)) outputText("<font color=\"#008000\">" + player.itemCount(item3) + " / " + item3Quantity + " " + item3.longName + "</font>");
				else outputText("<font color=\"#800000\">" + player.itemCount(item3) + " / " + item3Quantity + " " + item3.longName + "</font>");
				outputText("\n");
			}
			if (item4 != null) {
				if (player.hasItem(item4, item4Quantity)) outputText("<font color=\"#008000\">" + player.itemCount(item4) + " / " + item4Quantity + " " + item4.longName + "</font>");
				else outputText("<font color=\"#800000\">" + player.itemCount(item4) + " / " + item4Quantity + " " + item4.longName + "</font>");
				outputText("\n");
			}
			outputText("\n");
			//Is it okay to craft this shit?
			if (meetsItemRequirement(1) && meetsItemRequirement(2) && meetsItemRequirement(3) && meetsItemRequirement(4)) {
				outputText("Would you like to craft this item?");
				doYesNo(craftItem, accessCraftingMenu);
			}
			else {
				outputText("You do not have the required ingredients to craft this item.");
				doNext(accessCraftingMenu);
			}
		}
		
		private function craftItem():void {
			clearOutput();
			if (item1 != null) player.destroyItems(item1, item1Quantity);
			if (item2 != null) player.destroyItems(item2, item2Quantity);
			if (item3 != null) player.destroyItems(item3, item3Quantity);
			if (item4 != null) player.destroyItems(item4, item4Quantity);
			inventory.takeItem(itemResult, accessCraftingMenu);
		}*/
	}
}