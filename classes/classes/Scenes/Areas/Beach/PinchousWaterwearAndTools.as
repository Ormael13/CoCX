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
			spriteSelect(SpriteDb.s_crabgirlShop);
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
			spriteSelect(SpriteDb.s_crabgirlShop);
			clearOutput();
			outputText("You spot the Cancer lazily sleeping at her stall. She wakes up just in time to give you her usual greeting, somewhat void of emotions as always.\n\n");
			outputText("\"<i>This is my shop: ‘Pinchou’s waterwear and tools’, my name is... oh it’s you again... well? Stop gawking, are you here to buy something or not?</i>\"\n\n");
			PinchousWaterwearAndToolsShopMenu();
		}
		
		public function PinchousWaterwearAndToolsShopMenu():void {
			menu();
			//crab tf - 0
			addButton(1, consumables.ORCASUN.shortName, itemBuy, consumables.ORCASUN);
			addButton(2, consumables.BUBBLEG.shortName, itemBuy, consumables.BUBBLEG);
			addButton(3, consumables.BLACKIN.shortName, itemBuy, consumables.BLACKIN);
			addButton(4, weapons.TRIDENT.shortName, itemBuy, weapons.TRIDENT);
			addButton(5, consumables.AIRWEED.shortName, itemBuy, consumables.AIRWEED);
			addButton(6, necklaces.MCPNECK.shortName, itemBuy, necklaces.MCPNECK);
			addButton(7, shields.BATTNET.shortName, itemBuy, shields.BATTNET);
			addButton(8, headjewelries.AQBREATH.shortName, itemBuy, headjewelries.AQBREATH);
			addButton(9, armors.KBDRESS.shortName, itemBuy, armors.KBDRESS);
			addButton(10, "Bikini", PinchousWaterwearAndToolsShopBikiniMenu);
			addButton(11, armors.G_DIVES.shortName, itemBuy, armors.G_DIVES);
			addButton(14, "Leave", leavePinchousWaterwearAndToolsShop);
		}
		public function PinchousWaterwearAndToolsShopBikiniMenu():void {
			menu();
			addButton(0, armors.SAQBIKNI.shortName, itemBuy, armors.SAQBIKNI);
			addButton(1, armors.SBABIKNI.shortName, itemBuy, armors.SBABIKNI);
			addButton(2, armors.SBUBIKNI.shortName, itemBuy, armors.SBUBIKNI);
			addButton(3, armors.SGRBIKNI.shortName, itemBuy, armors.SGRBIKNI);
			addButton(5, armors.SPIBIKNI.shortName, itemBuy, armors.SPIBIKNI);
			addButton(6, armors.SREBIKNI.shortName, itemBuy, armors.SREBIKNI);
			addButton(7, armors.SWHBIKNI.shortName, itemBuy, armors.SWHBIKNI);
			addButton(8, armors.SYEBIKNI.shortName, itemBuy, armors.SYEBIKNI);
			addButton(14, "Leave", PinchousWaterwearAndToolsShopMenu);
		}
		public function PinchousWaterwearAndToolsShopMenu2():void {
			clearOutput();
			outputText("\"<i>This is my shop: ‘Pinchou’s waterwear and tools’, my name is... oh it’s you again... Well sure go ahead and browse you know my inventory already.</i>\"\n\n");
			PinchousWaterwearAndToolsShopMenu();
		}
		private function itemBuy(itype:ItemType):void {
			clearOutput();
			switch (itype) {
				case consumables.ORCASUN:		outputText("\"<i>A bottle of sunscreen lotion to protect against those annoying sunburns. That said its an item made for orca morphs who favor sunbathing. You might want to take precautions. Anyway it’s " + itype.value + " gems each.</i>\""); break;
				case consumables.BUBBLEG:		outputText("\"<i>Just a very ordinary candy, I eat these all the time but I’ve never seen an outsider take these. You might want to take precautions. Anyway it’s " + itype.value + " gems each.</i>\""); break;
				case weapons.TRIDENT:			outputText("\"<i>That is a trident… useful for catching fish or fighting underwater. I can part with it for " + itype.value + " gems.</i>\""); break;
				case consumables.BLACKIN:		outputText("\"<i>This is standard calligraphy equipment, you know to write stuff. However I heard that if consumed weird things can happens. You might want to take precautions. Anyway it’s " + itype.value + " gems each.</i>\""); break;
				case consumables.AIRWEED:		outputText("\"<i>Don’t like the breather, huh? Well these Airweeds will allow you to breath underwater for a time for only " + itype.value + " gem each.</i>\""); break;
				case necklaces.MCPNECK:			outputText("\"<i>You want to go underwater or improve your ability to swim? This necklace can allow you to do it. However it does not come cheap. " + itype.value + " gems and it is yours.</i>\""); break;
				case shields.BATTNET:			outputText("\"<i>This net can be used for fishing or entangling foes. " + itype.value + " gems and it's yours.</i>\""); break;
				case headjewelries.AQBREATH:	outputText("\"<i>Don’t like the breather? Well you will have to deal with it because it's still the cheapest diving item I got aside the Airweeds.</i>\""); break;
				case armors.SAQBIKNI:
				case armors.SBABIKNI:
				case armors.SBUBIKNI:
				case armors.SGRBIKNI:
				case armors.SPIBIKNI:
				case armors.SREBIKNI:
				case armors.SWHBIKNI:
				case armors.SYEBIKNI:			outputText("\"<i>What now? This is just a bikini… you know... for swimming. It’ll make any groundwalker less of a bad swimmer anyway that’s for sure. It’s yours for only " + itype.value + " gems.</i>\""); break;
				case armors.KBDRESS:			outputText("\"<i>That’s for people with tentacle legs… I can’t understand that fashion style really, but apparently it would improve those tentacle people’s abilities. " + itype.value + " gems and it’s yours.</i>\""); break;
			}
			//outputText("\"<i>That is a trident… useful for catching fish or fighting underwater. I can part with it for " + itype.value + " gems.</i>\"");
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