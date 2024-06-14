/**
 * ...
 * @author Liadri
 */
package classes.Scenes.Areas.Beach
{
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.display.SpriteDb;
import classes.Scenes.API.MultiBuy;

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
			addButton(1, consumables.ORCASUN.shortName, confirmBuy, consumables.ORCASUN);
			addButton(2, consumables.BUBBLEG.shortName, confirmBuy, consumables.BUBBLEG);
			addButton(3, consumables.BLACKIN.shortName, confirmBuy, consumables.BLACKIN);
			addButton(4, weapons.TRIDENT.shortName, confirmBuy, weapons.TRIDENT);
			addButton(5, consumables.AIRWEED.shortName, confirmBuy, consumables.AIRWEED);
			addButton(6, necklaces.MCPNECK.shortName, confirmBuy, necklaces.MCPNECK);
			addButton(7, shields.BATTNET.shortName, confirmBuy, shields.BATTNET);
			addButton(8, headjewelries.AQBREATH.shortName, confirmBuy, headjewelries.AQBREATH);
			addButton(9, armors.KBDRESS.shortName, confirmBuy, armors.KBDRESS);
			addButton(10, "Bikini", PinchousWaterwearAndToolsShopBikiniMenu);
			addButton(11, armors.G_DIVES.shortName, confirmBuy, armors.G_DIVES);
			addButton(14, "Leave", leavePinchousWaterwearAndToolsShop);
		}
		public function PinchousWaterwearAndToolsShopBikiniMenu():void {
			menu();
			addButton(0, armors.SAQBIKNI.shortName, confirmBuy, armors.SAQBIKNI);
			addButton(1, armors.SBABIKNI.shortName, confirmBuy, armors.SBABIKNI);
			addButton(2, armors.SBUBIKNI.shortName, confirmBuy, armors.SBUBIKNI);
			addButton(3, armors.SGRBIKNI.shortName, confirmBuy, armors.SGRBIKNI);
			addButton(5, armors.SPIBIKNI.shortName, confirmBuy, armors.SPIBIKNI);
			addButton(6, armors.SREBIKNI.shortName, confirmBuy, armors.SREBIKNI);
			addButton(7, armors.SWHBIKNI.shortName, confirmBuy, armors.SWHBIKNI);
			addButton(8, armors.SYEBIKNI.shortName, confirmBuy, armors.SYEBIKNI);
			addButton(14, "Leave", PinchousWaterwearAndToolsShopMenu);
		}
		public function PinchousWaterwearAndToolsShopMenu2():void {
			clearOutput();
			outputText("\"<i>This is my shop: ‘Pinchou’s waterwear and tools’, my name is... oh it’s you again... Well sure go ahead and browse you know my inventory already.</i>\"\n\n");
			PinchousWaterwearAndToolsShopMenu();
		}
		private function confirmBuy(itype:ItemType):void {
			var descString:String = "";

			switch (itype) {
				case consumables.ORCASUN:		descString = "\"<i>A bottle of sunscreen lotion to protect against those annoying sunburns. That said its an item made for orca morphs who favor sunbathing. You might want to take precautions.</i>\""; break;
				case consumables.BUBBLEG:		descString = "\"<i>Just a very ordinary candy, I eat these all the time but I’ve never seen an outsider take these. You might want to take precautions.</i>\""; break;
				case weapons.TRIDENT:			descString = "\"<i>That is a trident… useful for catching fish or fighting underwater.</i>\""; break;
				case consumables.BLACKIN:		descString = "\"<i>This is standard calligraphy equipment, you know to write stuff. However I heard that if consumed weird things can happens. You might want to take precautions.</i>\""; break;
				case consumables.AIRWEED:		descString = "\"<i>Don’t like the breather, huh? Well these Airweeds will allow you to breath underwater for a time.</i>\""; break;
				case necklaces.MCPNECK:			descString = "\"<i>You want to go underwater or improve your ability to swim? This necklace can allow you to do it. However it does not come cheap.</i>\""; break;
				case shields.BATTNET:			descString = "\"<i>This net can be used for fishing or entangling foes.</i>\""; break;
				case headjewelries.AQBREATH:	descString = "\"<i>Don’t like the breather? Well you will have to deal with it because it's still the cheapest diving item I got aside the Airweeds.</i>\""; break;
				case armors.SAQBIKNI:
				case armors.SBABIKNI:
				case armors.SBUBIKNI:
				case armors.SGRBIKNI:
				case armors.SPIBIKNI:
				case armors.SREBIKNI:
				case armors.SWHBIKNI:
				case armors.SYEBIKNI:			descString = "\"<i>What now? This is just a bikini… you know... for swimming. It’ll make any groundwalker less of a bad swimmer anyway that’s for sure.</i>\""; break;
				case armors.KBDRESS:			descString = "\"<i>That’s for people with tentacle legs… I can’t understand that fashion style really, but apparently it would improve those tentacle people’s abilities.</i>\""; break;
			}
			
			MultiBuy.confirmBuyMulti(PinchousWaterwearAndToolsShopMenu2, "Pinchou", 1, itype, descString, "\n", false);
		}
		
		public function leavePinchousWaterwearAndToolsShop():void {
			clearOutput();
			outputText("You wave her goodbye and head back to camp.\n\n");
			endEncounter();
		}
		
	}

}
