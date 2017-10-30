/**
 * ...
 * @author Liadri
 */
package classes.Scenes.Areas.Beach 
{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
import classes.display.SpriteDb;

public class PinchousWaterwearAndTools extends BaseContent
	{
		public function PinchousWaterwearAndTools() 
		{
		}
		
		public function encounteringPinchouFirst():void {
			spriteSelect(SpriteDb.s_crabgirl);
			clearOutput();
			outputText("As you wander the beach you come upon a weird stall with clothes on it. As you touch the items ,out of curiosity, a small voice grabs your attention.\n\n");
			outputText("\"<i>Hey! No taking things from the shop without paying! Stealing is bad, " + player.mf("mister", "miss") + ".</i>\"\n\n");
			outputText("At first glance, it looks like a little girl half burrowed in the sand. You shrug and put back the item you were examining on the stall, then ask what are these.\n\n");
			outputText("\"<i>My name is Pinchou and this is my shop: ‘Pinchou’s waterwear and tools’.</i>\"\n\n");
			outputText("She doesn’t look very expressive, but her shopkeeper’s line is fine, albeit lacking in enthusiasm. Just as you're about to question her, she starts to lift out of the sand, making you quite glad that you didn’t steal from her! While her juvenile upper body looks like that of a kid, her lower one is that of a giant crab, with menacing pincers that could easily tear steel plated armor to shreds. She skitters behind her counter, easily as tall as you are, and with a bored look, she encourages you to browse through her merchandise.\n\n");
			outputText("\"<i>So...wanna buy anything? Browse to your heart's content, but if I find you stealing I'ma cut your hand.</i>\"\n\n");
			flags[kFLAGS.PINCHOU_SHOP] = 1;
			PinchousWaterwearAndToolsShopMenu();
		}
		public function encounteringPinchouRepeat():void {
			spriteSelect(SpriteDb.s_crabgirl);
			clearOutput();
			outputText("You spot the Cancer lazily sleeping at her stall. She wakes up just in time to give you her usual greeting, somewhat void of emotions as always.\n\n");
			outputText("\"<i>This is my shop: ‘Pinchou’s waterwear and tools’, my name is... oh it’s you again... well? Stop gawking, are you here to buy something or not?</i>\"\n\n");
			PinchousWaterwearAndToolsShopMenu();
		}
		
		public function PinchousWaterwearAndToolsShopMenu():void {
			menu();
			addButton(2, weapons.TRIDENT.shortName, weaponBuy, weapons.TRIDENT);
			addButton(14, "Leave", leavePinchousWaterwearAndToolsShop);
		}
		public function PinchousWaterwearAndToolsShopMenu2():void {
			clearOutput();
			outputText("\"<i>This is my shop: ‘Pinchou’s waterwear and tools’, my name is... oh it’s you again... Well sure go ahead and browse you know my inventory already.</i>\"\n\n");
			PinchousWaterwearAndToolsShopMenu();
		}
		private function weaponBuy(itype:ItemType):void {
			clearOutput();
			outputText("\"<i>That'll be " + itype.value + " gems.</i>\"");
			if(player.gems < itype.value) {
				outputText("\n\nYou count out your gems and realize it's beyond your price range.");
				doNext(PinchousWaterwearAndToolsShopMenu2);
				return;
			}
			else outputText("\n\nDo you buy it?\n\n");
			doYesNo(curry(debitWeapon,itype), PinchousWaterwearAndToolsShopMenu2);
		}
		private function debitWeapon(itype:ItemType):void {
			player.gems -= itype.value;
			statScreenRefresh();
			inventory.takeItem(itype, PinchousWaterwearAndToolsShopMenu2);
		}
		public function leavePinchousWaterwearAndToolsShop():void {
			clearOutput();
			outputText("You wave her goodbye and head back to camp.\n\n");
			doNext(camp.returnToCampUseOneHour);
		}
		
	}

}