/**
 * Created by aimozg on 10.01.14.
 */
package classes.Scenes
{
	import classes.BaseContent;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.ItemType;

	public class InventoryScene extends BaseContent
	{
		public function InventoryScene()
		{
		}
		
		public function takeItem(itype:ItemType):void{
			var done:Boolean = false;
			//Check for an existing stack with room in the inventory and return the value for it.
			var temp:int = player.roomInExistingStack(itype);
			if(temp >= 0) {
				//First slot go!
				player.itemSlot(temp).quantity++;
				outputText("You place " + itype.longName + " in your "+
						["first","second","third","fourth","fifth"][temp]+
						" pouch, giving you " + player.itemSlot(temp).quantity + " of them.", false);
				done = true;
			}
			//If not done, then put it in an empty spot!
			//Throw in slot 1 if there is room
			if(!done) {
				temp = player.emptySlot();
				if (temp >= 0){
					player.itemSlot(temp).setItemAndQty(itype, 1);
					outputText("You place " + itype.longName + " in your "+
							["first","second","third","fourth","fifth"][temp]+
							" pouch.", false);
				}
				done = true;
			}
			if(done) {
				itemGoNext();
				return;
			}
			var slot4:Number = 0;
			var slot5:Number = 0;
			if(player.itemSlot4.unlocked) slot4 = 1005;
			if(player.itemSlot5.unlocked) slot5 = 1006;
			//OH NOES! No room! Call replacer functions!
			outputText("There is no room for " + itype.longName + " in your inventory.  You may replace the contents of a pouch with " + itype.longName + " or abandon it.", false);
			var abandon:* = 13;
			//If at giacomo abandon goes differently...
			if (gameState == 4)
			{
				abandon = 2015;
			}
			else if (gameState == 6) 
			{
				abandon = 2070;
			}
			else if (menuLoc == 7)
			{
				abandon = 1029;
			}
			//Tailor
			else if (menuLoc == 10)
			{
				abandon = 1072;
			}
			//Armor
			else if (menuLoc == 9)
			{
				abandon =  kGAMECLASS.telAdre.armorShop;
			}
			else if (menuLoc == 11)
			{
				abandon = 41;
			}
			else if (menuLoc == 12 || menuLoc == 13)
			{
				abandon = kGAMECLASS.lumi.lumiLabChoices;
			}
			else if (menuLoc == 14)
			{
				abandon =  1;
			}
			else if (menuLoc == 15)
			{
				abandon = kGAMECLASS.telAdre.weaponShop;
			}
			else if (menuLoc == 16)
			{
				abandon =  2642;
			}
			else if (menuLoc == 17)
			{
				abandon = 15;
			}
			else if (menuLoc == 18)
			{
				abandon = 16;
			}
			else if (menuLoc == 19)
			{
				abandon =  kGAMECLASS.telAdre.bakeryScene.bakeryuuuuuu;
			}
			else if (menuLoc == 20)
			{
				abandon = 1090;
			}
			else if (menuLoc == 21)
			{
				abandon = 1091;
			}
			else if (menuLoc == 22)
			{
				abandon = 1106;
			}
			else if (menuLoc == 23)
			{
				abandon = 1107;
			}
			else if (menuLoc == 24)
			{
				abandon = kGAMECLASS.telAdre.barTelAdre;
			}
			else if (menuLoc == 25)
			{
				abandon = kGAMECLASS.owca.owcaTavern;
			}
			else if (menuLoc == 26)
			{
				abandon = kGAMECLASS.bazaar.benoit.benoitsBuyMenu;
			}
			else if (menuLoc == 27)
			{
				abandon = 3968;
			}
			else if (menuLoc == 28)
			{
				abandon = 1000;
			}
			else if (menuLoc == 29)
			{
				abandon = kGAMECLASS.telAdre.bakeryScene.ingredientsMenu;
			}
			choices((player.itemSlot1.shortName + " x" + player.itemSlot1.quantity), 1002,
					(player.itemSlot2.shortName + " x" + player.itemSlot2.quantity), 1003,
					(player.itemSlot3.shortName + " x" + player.itemSlot3.quantity), 1004,
					(player.itemSlot4.shortName + " x" + player.itemSlot4.quantity), slot4,
					(player.itemSlot5.shortName + " x" + player.itemSlot5.quantity), slot5,
					"", 0,
					"", 0,
					"", 0,
					"Use Now", 1016,
					"Abandon", abandon);
			trace("TakeItem Menuloc: " + menuLoc);
		}
	}
}
