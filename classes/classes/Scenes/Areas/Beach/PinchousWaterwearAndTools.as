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
			outputText("As you wander the beach, you come across a strange stall displaying clothes. Out of curiosity, you reach out to touch one of the items when a small voice grabs your attention.\n\n");
			outputText("\"<i>Hey! No touching without paying! Stealing is bad, " + player.mf("mister", "miss") + ".</i>\"\n\n");
			outputText("At first glance, it looks like a little girl half-buried in the sand. You quickly put the item back on the stall and ask what these are.\n\n");
			outputText("\"<i>My name is Pinchou, and this is my shop: ‘Pinchou’s Waterwear and Tools’.</i>\"\n\n");
			outputText("Though she lacks enthusiasm, her shopkeeper's line is delivered without any mistakes. As you're about to ask her something, she lifts out of the sand, and you’re glad you didn’t steal from her! While her upper body looks like that of a child, her lower body is that of a giant crab, complete with menacing pincers capable of tearing through steel-plated armor. She skitters behind her counter, now as tall as you, and with a bored look, she encourages you to browse through her wares.\n\n");
			outputText("\"<i>So, wanna buy anything? Feel free to browse, but if I catch you stealing, I’ll cut off your hand.</i>\"\n\n");
			flags[kFLAGS.PINCHOU_SHOP] = 1;
			PinchousWaterwearAndToolsShopMenu();
		}
		public function encounteringPinchouRepeat():void {
			spriteSelect(SpriteDb.s_crabgirlShop);
			clearOutput();
			outputText("You spot Pinchou lazily resting at her stall. She wakes up just in time to greet you with her usual lack of enthusiasm.\n\n");
			outputText("\"<i>This is my shop: ‘Pinchou’s Waterwear and Tools’, my name is... oh it’s you again... well? Stop gawking, are you here to buy something or not?</i>\"\n\n");
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
			outputText("\"<i>This is my shop: ‘Pinchou’s Waterwear and Tools’, my name is... oh, it’s you again... Well, feel free to browse. You already know my inventory.</i>\"\n\n");
			PinchousWaterwearAndToolsShopMenu();
		}
		private function confirmBuy(itype:ItemType):void {
			var descString:String = "";

			switch (itype) {
				case consumables.ORCASUN:		descString = "\"<i>A bottle of sunscreen lotion to protect against those annoying sunburns. It's made for orca morphs who favor sunbathing. You might want to take precautions.</i>\""; break;
				case consumables.BUBBLEG:		descString = "\"<i>Just a very ordinary candy. I eat these all the time, but I’ve never seen an outsider take them. You might want to take precautions.</i>\""; break;
				case weapons.TRIDENT:			descString = "\"<i>That’s a trident... useful for catching fish or fighting underwater.</i>\""; break;
				case consumables.BLACKIN:		descString = "\"<i>This is standard calligraphy equipment, you know, to write stuff. However, I've heard that if consumed, weird things may happen. You might want to take precautions.</i>\""; break;
				case consumables.AIRWEED:		descString = "\"<i>Don’t like the breather, huh? Well, these Airweeds will allow you to breath underwater for a time.</i>\""; break;
				case necklaces.MCPNECK:			descString = "\"<i>You want to go underwater or improve your ability to swim? Then this necklace can help you do it. However, it doesn't come cheap.</i>\""; break;
				case shields.BATTNET:			descString = "\"<i>This net can be used for fishing or entangling foes.</i>\""; break;
				case headjewelries.AQBREATH:	descString = "\"<i>Don’t like the breather? Well, you'll have to deal with it because it's the cheapest diving item I have, aside from the Airweeds.</i>\""; break;
				case armors.SAQBIKNI:
				case armors.SBABIKNI:
				case armors.SBUBIKNI:
				case armors.SGRBIKNI:
				case armors.SPIBIKNI:
				case armors.SREBIKNI:
				case armors.SWHBIKNI:
				case armors.SYEBIKNI:			descString = "\"<i>What now? This is just a bikini… you know... for swimming. It’ll make any groundwalker a better swimmer, that’s for sure.</i>\""; break;
				case armors.KBDRESS:			descString = "\"<i>That’s for people with tentacle legs… I don't get that fashion style really, but apparently, it improves their abilities.</i>\""; break;
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
