package classes.Scenes 
{
	import classes.*;
	import classes.BaseContent;
	import classes.GlobalFlags.*;
	import classes.Items.*;

	public class Crafting extends BaseContent
	{
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
		
		public function Crafting() {}
		
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
			addButton(14, "Back", playerMenu);
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
		}
	}

}