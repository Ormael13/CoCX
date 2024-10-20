/**
 * ...
 * @author Liadri
 */
package classes.Scenes.Places.HeXinDao 
{
import classes.*;
import classes.Scenes.API.MultiBuy;

public class EraendirAndOrsbulg extends HeXinDaoAbstractContent
	{
		
		public function EraendirAndOrsbulg() 
		{}
		
		public function EraendirMainMenu():void {
			clearOutput();
			outputText("A sleek graceful elven man stare at you from the shop counter.\n\n");
			outputText("\"<i>Welcome to Eraendir and Orsbulg. I’m Eraendir and I sell the finest most elegant weapons in the realm. If you can appreciate the refinement of a light steel edge sharpened to perfection or the elegance and finesse of a well balanced elven dagger this shop is for you.</i>\"");
			menu();
			addButton(0, "Buy", EraendirBuyMenu);
			addButton(14, "Leave", heXinDao.riverislandVillageStuff);
		}
		public function EraendirBuyMenu():void {
			clearOutput();
			outputText("The elf gives you a wide display of his many knife and swords. Small blades indeed but sharp and light, ideal to deliver many cuts in the time it normally takes to deliver 1 strike.");
			menu();
			addButton(0, weapons.DAGGER.shortName, itemBuy, weapons.DAGGER, EraendirMainMenu, "Eraendir");
			addButton(1, weapons.TRIDAG.shortName, itemBuy, weapons.TRIDAG, EraendirMainMenu, "Eraendir");
			addButton(2, weapons.TDAGGER.shortName, itemBuy, weapons.TDAGGER, EraendirMainMenu, "Eraendir");
			addButton(3, weapons.DAGWHIP.shortName, itemBuy, weapons.DAGWHIP, EraendirMainMenu, "Eraendir");
			addButton(4, weapons.ANGSTD1.shortName, itemBuy, weapons.ANGSTD1, EraendirMainMenu, "Eraendir");
			addButton(5, weapons.ADAGGER.shortName, itemBuy, weapons.ADAGGER, EraendirMainMenu, "Eraendir");
			addButton(6, weapons.RDAGGER.shortName, itemBuy, weapons.RDAGGER, EraendirMainMenu, "Eraendir");
			addButton(7, weapons.SDAGGER.shortName, itemBuy, weapons.SDAGGER, EraendirMainMenu, "Eraendir");
			addButton(8, weapons.TODAGGER.shortName, itemBuy, weapons.TODAGGER, EraendirMainMenu, "Eraendir");
			addButton(9, weapons.FLYINGC.shortName, itemBuy, weapons.FLYINGC, EraendirMainMenu, "Eraendir");
			addButton(10, weapons.KAMA.shortName, itemBuy, weapons.KAMA, EraendirMainMenu, "Eraendir");
			addButton(11, weapons.KAMAWHIP.shortName, itemBuy, weapons.KAMAWHIP, EraendirMainMenu, "Eraendir");
			//12
			addButton(13, weapons.S_SWORD.shortName, itemBuy, weapons.S_SWORD, EraendirMainMenu, "Eraendir");
			addButton(14, "Back", EraendirMainMenu);
		}
		
		public function OrsbulgMainMenu():void {
			clearOutput();
			outputText("A tall muscular orc woman stare at you from the shop \"<i>Welcome to Eraendir and Orsbulg. I’m Orsbulg and I sell THE weapons. BIG weapons for REAL heroes. So what will it be " + player.mf("boy", "lass") + "?</i>\"");
			menu();
			addButton(0, "Buy", OrsbulgBuyMenu);
			addButton(14, "Leave", heXinDao.riverislandVillageStuff);
		}
		public function OrsbulgBuyMenu():void {
			clearOutput();
			menu();
			outputText("\"<i>Only the biggest deadliest weapon right here!</i>\"");
			addButton(0, weapons.BFSWORD.shortName, itemBuy, weapons.BFSWORD, OrsbulgMainMenu, "Orsbulg");
			addButton(1, weapons.BFTHSWORD.shortName, itemBuy, weapons.BFTHSWORD, OrsbulgMainMenu, "Orsbulg");
			addButton(2, weapons.BFWHIP.shortName, itemBuy, weapons.BFWHIP, OrsbulgMainMenu, "Orsbulg");
			addButton(3, weapons.OTETSU.shortName, itemBuy, weapons.OTETSU, OrsbulgMainMenu, "Orsbulg");
			addButton(4, weapons.DWARWA.shortName, itemBuy, weapons.DWARWA, OrsbulgMainMenu, "Orsbulg");
			addButton(5, weapons.SKYPIER.shortName, itemBuy, weapons.SKYPIER, OrsbulgMainMenu, "Orsbulg");
			addButton(6, weapons.GUANDAO.shortName, itemBuy, weapons.GUANDAO, OrsbulgMainMenu, "Orsbulg");
			addButton(7, weapons.TB_SCYT.shortName, itemBuy, weapons.TB_SCYT, OrsbulgMainMenu, "Orsbulg");
			addButton(8, weapons.BFGAUNT.shortName, itemBuy, weapons.BFGAUNT, OrsbulgMainMenu, "Orsbulg");
			//9
			addButton(10, weaponsrange.B_F_BOW.shortName, itemBuy, weaponsrange.B_F_BOW, OrsbulgMainMenu, "Orsbulg");
			addButton(11, weaponsrange.BFXBOW_.shortName, itemBuy, weaponsrange.BFXBOW_, OrsbulgMainMenu, "Orsbulg");
			//12
			//13
			addButton(14, "Back", OrsbulgMainMenu);
		}

		private function itemBuy(itype:ItemType, returnFunc:Function, merchant:String):void {
			var descString:String = "\"<i>Interested?</i>\"";
			
			MultiBuy.confirmBuyMulti(returnFunc, merchant, 1, itype, descString, "\n");
		}
	}
}