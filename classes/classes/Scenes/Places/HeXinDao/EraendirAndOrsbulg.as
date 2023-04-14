/**
 * ...
 * @author Liadri
 */
package classes.Scenes.Places.HeXinDao 
{
import classes.*;

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
			outputText("The elf gives you a wide display of his many knife and swords. Small blades indeed but sharp and light, ideal to deliver many cuts in the time it normaly takes to deliver 1 strike.");
			menu();
			addButton(0, weapons.DAGGER.shortName, itemBuy1, weapons.DAGGER);
			addButton(1, weapons.DDAGGER.shortName, itemBuy1, weapons.DDAGGER);
			addButton(2, weapons.TRIDAG.shortName, itemBuy1, weapons.TRIDAG);
			addButton(3, weapons.TDAGGER.shortName, itemBuy1, weapons.TDAGGER);
			addButton(4, weapons.DAGWHIP.shortName, itemBuy1, weapons.DAGWHIP);
			addButton(5, weapons.ADAGGER.shortName, itemBuy1, weapons.ADAGGER);
			addButton(6, weapons.RDAGGER.shortName, itemBuy1, weapons.RDAGGER);
			addButton(7, weapons.SDAGGER.shortName, itemBuy1, weapons.SDAGGER);
			addButton(8, weapons.TODAGGER.shortName, itemBuy1, weapons.TODAGGER);
			addButton(9, weapons.ANGSTD.shortName, itemBuy1, weapons.ANGSTD);
			addButton(10, weapons.FLYINGC.shortName, itemBuy1, weapons.FLYINGC);
			addButton(11, weapons.KAMAWHIP.shortName, itemBuy1, weapons.KAMAWHIP);
			//12
			addButton(13, weapons.S_SWORD.shortName, itemBuy1, weapons.S_SWORD);
			addButton(14, "Back", EraendirMainMenu);
		}
		private function itemBuy1(itype:ItemType):void {
			clearOutput();
			outputText("\"<i>Interested? It’s yours for only " + itype.value + " gems.</i>\"");
			if(player.gems < itype.value) {
				outputText("\n\nYou count out your gems and realize it's beyond your price range.");
				doNext(EraendirBuyMenu);
				return;
			}
			else outputText("\n\nDo you buy it?\n\n");
			doYesNo(curry(debitWeapon1,itype), EraendirBuyMenu);
		}
		private function debitWeapon1(itype:ItemType):void {
			player.gems -= itype.value;
			statScreenRefresh();
			inventory.takeItem(itype, EraendirBuyMenu);
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
			addButton(0, weapons.BFSWORD.shortName, itemBuy2, weapons.BFSWORD);
			addButton(1, weapons.BFTHSWORD.shortName, itemBuy2, weapons.BFTHSWORD);
			addButton(2, weapons.BFWHIP.shortName, itemBuy2, weapons.BFWHIP);
			addButton(3, weapons.OTETSU.shortName, itemBuy2, weapons.OTETSU);
			addButton(4, weapons.DWARWA.shortName, itemBuy2, weapons.DWARWA);
			addButton(5, weapons.DBFSWO.shortName, itemBuy2, weapons.DBFSWO);
			addButton(6, weapons.DBFTHSWO.shortName, itemBuy2, weapons.DBFTHSWO);
			addButton(7, weapons.DBFWHIP.shortName, itemBuy2, weapons.DBFWHIP);
			addButton(8, weapons.SKYPIER.shortName, itemBuy2, weapons.SKYPIER);
			//9
			addButton(10, weapons.BFGAUNT.shortName, itemBuy2, weapons.BFGAUNT);
			addButton(11, weaponsrange.B_F_BOW.shortName, itemBuy2, weaponsrange.B_F_BOW);
			addButton(12, weaponsrange.BFXBOW_.shortName, itemBuy2, weaponsrange.BFXBOW_);
			//13
			addButton(14, "Back", OrsbulgMainMenu);
		}
		private function itemBuy2(itype:ItemType):void {
			clearOutput();
			outputText("\"<i>Interested? It’s yours for only " + itype.value + " gems.</i>\"");
			if(player.gems < itype.value) {
				outputText("\n\nYou count out your gems and realize it's beyond your price range.");
				doNext(OrsbulgBuyMenu);
				return;
			}
			else outputText("\n\nDo you buy it?\n\n");
			doYesNo(curry(debitWeapon2,itype), OrsbulgBuyMenu);
		}
		private function debitWeapon2(itype:ItemType):void {
			player.gems -= itype.value;
			statScreenRefresh();
			inventory.takeItem(itype, OrsbulgBuyMenu);
		}
	}
}