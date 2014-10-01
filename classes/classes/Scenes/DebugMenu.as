package classes.Scenes 
{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.GlobalFlags.kGAMECLASS;
	
	public class DebugMenu extends BaseContent
	{
		/*
			addButton(0, "Item1", giveItem, consumables.ITEM);
			addButton(1, "Item2", giveItem, consumables.ITEM);
			addButton(2, "Item3", giveItem, consumables.ITEM);
			addButton(3, "Item4", giveItem, consumables.ITEM);
			
			addButton(5, "Item5", giveItem, consumables.ITEM);
			addButton(6, "Item6", giveItem, consumables.ITEM);
			addButton(7, "Item7", giveItem, consumables.ITEM);
			addButton(8, "Item8", giveItem, consumables.ITEM);
		 */
		public function DebugMenu() 
		{	
		}
		
		public function accessDebugMenu():void {
			kGAMECLASS.tooltipLoc = ""
			if (debug && flags[kFLAGS.HARDCORE_MODE] <= 0 && !inCombat()) {
				outputText("Welcome to the super secret debug menu!", true);
				menu();
				addButton(0, "Spawn Items", itemSpawnMenu);
				addButton(1, "Change Stats", statChangeMenu);
				addButton(9, "Exit", eventParser, 1);
			}
		}
		
		//Spawn items menu
		private function itemSpawnMenu():void {
			kGAMECLASS.tooltipLoc = "ItemDebug"
			outputText("What item would you like to spawn?", true);
			menu();
			addButton(0, "Transformatives", itemSpawnTransformativesMenuI)
			addButton(1, "Consumables", itemSpawnConsumablesMenuI)
			addButton(2, "Dyes", itemSpawnDyesMenuI)
			addButton(3, "Materials", itemSpawnMaterialsMenu)
			addButton(4, "Rare Items", itemSpawnRaresMenu)
			addButton(5, "Weapons", itemSpawnWeaponsMenuI)
			addButton(6, "Armours", itemSpawnArmoursMenuI)
			addButton(7, "Accessories", itemSpawnAccessoriesMenuI)
			addButton(9, "Back", accessDebugMenu);
		}
		
		private function itemSpawnTransformativesMenuI():void {
			menu();
			addButton(0, "B.Gossr", giveItem, consumables.B_GOSSR);
			addButton(1, "BeeHony", giveItem, consumables.BEEHONY);
			addButton(2, "BlackPp", giveItem, consumables.BLACKPP);
			addButton(3, "BulbyPp", giveItem, consumables.BULBYPP);
			
			addButton(5, "CanineP", giveItem, consumables.CANINEP);
			addButton(6, "DblPepp", giveItem, consumables.DBLPEPP);
			addButton(7, "DryTent", giveItem, consumables.DRYTENT);
			addButton(8, "EctoPls", giveItem, consumables.ECTOPLS);
			
			addButton(4, "Page 1/6", itemSpawnTransformativesMenuII);
			addButton(9, "Back", itemSpawnMenu);			
		}
		private function itemSpawnTransformativesMenuII():void {
			menu();
			addButton(0, "Equinum", giveItem, consumables.EQUINUM);
			addButton(1, "Fox Berry", giveItem, consumables.FOXBERY);
			addButton(2, "FerretFrt", giveItem, consumables.FRRTFRT);
			addButton(3, "Fox Jewel", giveItem, consumables.FOXJEWL);
			
			addButton(5, "GoldenSeed", giveItem, consumables.GLDSEED);
			addButton(6, "Gob.Ale", giveItem, consumables.GOB_ALE);
			addButton(7, "ImpFood", giveItem, consumables.IMPFOOD);
			addButton(8, "IncubiD", giveItem, consumables.INCUBID);
			
			addButton(4, "Page 2/6", itemSpawnTransformativesMenuIII);
			addButton(9, "Back", itemSpawnMenu);			
		}
		private function itemSpawnTransformativesMenuIII():void {
			menu();
			addButton(0, "KangaFruit", giveItem, consumables.KANGAFT);
			addButton(1, "KnottyP", giveItem, consumables.KNOTTYP);
			addButton(2, "La Bova", giveItem, consumables.LABOVA_);
			addButton(3, "LargePp", giveItem, consumables.LARGEPP);
			
			addButton(5, "MagSeed", giveItem, consumables.MAGSEED);
			addButton(6, "MghtyVg", giveItem, consumables.MGHTYVG);
			addButton(7, "MouseCo", giveItem, consumables.MOUSECO);
			addButton(8, "MinoBlo", giveItem, consumables.MINOBLO);
			
			addButton(4, "Page 3/6", itemSpawnTransformativesMenuIV);
			addButton(9, "Back", itemSpawnMenu);			
		}
		private function itemSpawnTransformativesMenuIV():void {
			menu();
			addButton(0, "MystJwl", giveItem, consumables.MYSTJWL);
			addButton(1, "P.LBova", giveItem, consumables.P_LBOVA);
			addButton(2, "PrFruit", giveItem, consumables.PRFRUIT);
			addButton(3, "ProBova", giveItem, consumables.PROBOVA);
			
			addButton(5, "P.Draft", giveItem, consumables.P_DRAFT);
			addButton(6, "P.S.Mlk", giveItem, consumables.P_S_MLK);
			addButton(7, "PSDelit", giveItem, consumables.PSDELIT);
			addButton(8, "PurHony", giveItem, consumables.PURHONY);
			
			addButton(4, "Page 4/6", itemSpawnTransformativesMenuV);
			addButton(9, "Back", itemSpawnMenu);			
		}
		private function itemSpawnTransformativesMenuV():void {
			menu();
			addButton(0, "S.Delite", giveItem, consumables.SDELITE);
			addButton(1, "S.Dream", giveItem, consumables.S_DREAM);
			addButton(2, "SucMilk", giveItem, consumables.SUCMILK);
			addButton(3, "Reptilum", giveItem, consumables.REPTLUM);
			
			addButton(5, "RingFig", giveItem, consumables.RINGFIG);
			addButton(6, "Rizza Root", giveItem, consumables.RIZZART);
			addButton(7, "S.Gossr", giveItem, consumables.S_GOSSR);
			addButton(8, "Shark.T", giveItem, consumables.SHARK_T);
			
			addButton(4, "Page 5/6", itemSpawnTransformativesMenuVI);
			addButton(9, "Back", itemSpawnMenu);			
		}
		private function itemSpawnTransformativesMenuVI():void {
			menu();
			addButton(0, "SnakOil", giveItem, consumables.SNAKOIL);
			addButton(1, "TrapOil", giveItem, consumables.TRAPOIL);
			addButton(2, "TScroll", giveItem, consumables.TSCROLL);
			addButton(3, "TSTooth", giveItem, consumables.TSTOOTH);
			
			addButton(5, "VixVigr", giveItem, consumables.VIXVIGR);
			addButton(6, "W.Fruit", giveItem, consumables.W_FRUIT);
			addButton(7, "WetClth", giveItem, consumables.WETCLTH);
			
			addButton(4, "Page 6/6", itemSpawnTransformativesMenuI);
			addButton(9, "Back", itemSpawnMenu);			
		}
		
		private function itemSpawnConsumablesMenuI():void {
			menu();
			addButton(0, "AkbalSlv", giveItem, consumables.AKBALSL);
			addButton(1, "C. Mint", giveItem, consumables.C__MINT);
			addButton(2, "Cerulean P.", giveItem, consumables.CERUL_P);
			addButton(3, "Coal", giveItem, consumables.COAL___);
			
			addButton(5, "Debimbo", giveItem, consumables.DEBIMBO);
			addButton(6, "ExtSerm", giveItem, consumables.EXTSERM);
			addButton(7, "F.Draft", giveItem, consumables.F_DRAFT);
			addButton(8, "GroPlus", giveItem, consumables.GROPLUS);
			
			addButton(4, "Page 1/7", itemSpawnConsumablesMenuII);
			addButton(9, "Back", itemSpawnMenu);
		}
		private function itemSpawnConsumablesMenuII():void {
			menu();
			addButton(0, "HrblCnt", giveItem, consumables.HRBCNT);
			addButton(1, "Icicle", giveItem, consumables.ICICLE_);
			addButton(2, "KitGift", giveItem, consumables.KITGIFT);
			addButton(3, "LustDraft", giveItem, consumables.L_DRAFT);
			
			addButton(5, "Lactaid", giveItem, consumables.LACTAID);
			addButton(6, "LustStk", giveItem, consumables.LUSTSTK);
			addButton(7, "Numb Rox", giveItem, consumables.NUMBROX);
			addButton(8, "Ovi Elixir", giveItem, consumables.OVIELIX);
			
			addButton(4, "Page 2/7", itemSpawnConsumablesMenuIII);
			addButton(9, "Back", itemSpawnMenu);
		}
		private function itemSpawnConsumablesMenuIII():void {
			menu();
			addButton(0, "PeppWht", giveItem, consumables.PEPPWHT);
			addButton(1, "P.Pucker", giveItem, consumables.PRNPKR);
			addButton(2, "Reducto", giveItem, consumables.REDUCTO);
			addButton(3, "SensDraft", giveItem, consumables.SENSDRF);
			
			addButton(5, "Scholars T.", giveItem, consumables.SMART_T);
			addButton(6, "Vitality T.", giveItem, consumables.VITAL_T);
			addButton(7, "B. Book", giveItem, consumables.B__BOOK);
			addButton(8, "W. Book", giveItem, consumables.W__BOOK);
			
			addButton(4, "Page 3/7", itemSpawnConsumablesMenuIV);
			addButton(9, "Back", itemSpawnMenu);
		}
		private function itemSpawnConsumablesMenuIV():void {
			menu();
			addButton(0, "BC Beer", giveItem, consumables.BC_BEER);
			addButton(1, "BimboCh", giveItem, consumables.BIMBOCH);
			addButton(2, "CCupcak", giveItem, consumables.CCUPCAK);
			addButton(3, "FishFil", giveItem, consumables.FISHFIL);
			
			addButton(5, "GodMead", giveItem, consumables.GODMEAD);
			addButton(6, "IzyMilk", giveItem, consumables.IZYMILK);
			addButton(7, "M. Milk", giveItem, consumables.M__MILK);
			addButton(8, "MinoCum", giveItem, consumables.MINOCUM);
			
			addButton(4, "Page 4/7", itemSpawnConsumablesMenuV);
			addButton(9, "Back", itemSpawnMenu);
		}
		private function itemSpawnConsumablesMenuV():void {
			menu();
			addButton(0, "Ph. Whiskey", giveItem, consumables.P_WHSKY);
			addButton(1, "PurPeac", giveItem, consumables.PURPEAC);
			addButton(2, "SheepMk", giveItem, consumables.SHEEPMK);
			addButton(3, "SpringWtr", giveItem, consumables.S_WATER);
			
			addButton(5, "NPnkEgg", giveItem, consumables.NPNKEGG);
			addButton(6, "DrgnEgg", giveItem, consumables.DRGNEGG);
			
			addButton(4, "Page 5/7", itemSpawnConsumablesMenuVI);
			addButton(9, "Back", itemSpawnMenu);
		}
		private function itemSpawnConsumablesMenuVI():void {
			menu();
			addButton(0, "BlackEg", giveItem, consumables.BLACKEG);
			addButton(1, "BlueEgg", giveItem, consumables.BLUEEGG);
			addButton(2, "BrownEg", giveItem, consumables.BROWNEG);
			addButton(3, "PinkEgg", giveItem, consumables.PINKEGG);
			
			addButton(5, "L.BlkEg", giveItem, consumables.L_BLKEG);
			addButton(6, "L.BluEg", giveItem, consumables.L_BLUEG);
			addButton(7, "L.BrnEg", giveItem, consumables.L_BRNEG);
			addButton(8, "L.PnkEg", giveItem, consumables.L_PNKEG);
			
			addButton(4, "Page 6/7", itemSpawnConsumablesMenuVII);
			addButton(9, "Back", itemSpawnMenu);
		}
		private function itemSpawnConsumablesMenuVII():void {
			menu();
			addButton(0, "PurplEg", giveItem, consumables.PURPLEG);
			addButton(1, "WhiteEg", giveItem, consumables.WHITEEG);
			
			addButton(5, "L.PrpEg", giveItem, consumables.L_PRPEG);
			addButton(6, "L.WhtEg", giveItem, consumables.L_WHTEG);
			
			addButton(4, "Page 7/7", itemSpawnConsumablesMenuI);
			addButton(9, "Back", itemSpawnMenu);
		}
		
		private function itemSpawnDyesMenuI():void {
			menu();
			addButton(0, "AuburnD", giveItem, consumables.AUBURND);
			addButton(1, "Black D", giveItem, consumables.BLACK_D);
			addButton(2, "Blond D", giveItem, consumables.BLOND_D);
			addButton(3, "BlueDye", giveItem, consumables.BLUEDYE);
			
			addButton(5, "Brown D", giveItem, consumables.BROWN_D);
			addButton(6, "GrayDye", giveItem, consumables.GRAYDYE);
			addButton(7, "Green D", giveItem, consumables.GREEN_D);
			addButton(8, "OrangDy", giveItem, consumables.ORANGDY);
			
			addButton(4, "Page 1/2", itemSpawnDyesMenuII);
			addButton(9, "Back", itemSpawnMenu);
		}
		private function itemSpawnDyesMenuII():void {
			menu();
			addButton(0, "PinkDye", giveItem, consumables.PINKDYE);
			addButton(1, "PurpDye", giveItem, consumables.PURPDYE);
			addButton(2, "Red Dye", giveItem, consumables.RED_DYE);
			addButton(3, "WhiteDy", giveItem, consumables.WHITEDY);
			
			addButton(4, "Page 2/2", itemSpawnDyesMenuI);
			addButton(9, "Back", itemSpawnMenu);
		}		
		
		private function itemSpawnMaterialsMenu():void {
			menu();
			addButton(0, "GreenGl", giveItem, useables.GREENGL);
			addButton(1, "B.Chitn", giveItem, useables.B_CHITN);
			addButton(2, "T.SSilk", giveItem, useables.T_SSILK);
			
			addButton(4, "Page 1/1", itemSpawnMaterialsMenu);
			addButton(9, "Back", itemSpawnMenu);
		}
		
		private function itemSpawnRaresMenu():void {
			menu();
			addButton(0, "BimboLq", giveItem, consumables.BIMBOLQ);
			addButton(1, "BroBrew", giveItem, consumables.BROBREW);
			addButton(2, "GldStat", giveItem, useables.GLDSTAT);
			addButton(3, "Hummus", giveItem, consumables.HUMMUS_);
			
			addButton(5, "P.Pearl", giveItem, consumables.P_PEARL);
			
			addButton(4, "Page 1/1", itemSpawnRaresMenu);
			addButton(9, "Back", itemSpawnMenu);
		}
		
		private function itemSpawnWeaponsMenuI():void {
			menu();
			addButton(0, "B.Sword", giveItem, weapons.B_SWORD);
			addButton(1, "L.Claymore", giveItem, weapons.CLAYMOR);
			addButton(2, "DrgnShl", giveItem, weapons.DRGNSHL);
			addButton(3, "E.Staff", giveItem, weapons.E_STAFF);
			
			addButton(5, "UrtaHlb", giveItem, weapons.URTAHLB);
			addButton(6, "H.Gaunt", giveItem, weapons.H_GAUNT);
			addButton(7, "JRapier", giveItem, weapons.JRAPIER);
			addButton(8, "Katana", giveItem, weapons.KATANA);
			
			addButton(4, "Page 1/3", itemSpawnWeaponsMenuII);
			addButton(9, "Back", itemSpawnMenu);
		}
		private function itemSpawnWeaponsMenuII():void {
			menu();
			addButton(0, "L. Axe", giveItem, weapons.L__AXE);
			addButton(1, "L.Daggr", giveItem, weapons.L_DAGGR);
			addButton(2, "L.Hammr", giveItem, weapons.L_HAMMR);
			addButton(3, "Pipe", giveItem, weapons.PIPE);
			
			addButton(5, "Pitchfork", giveItem, weapons.PTCHFRK);
			addButton(6, "RidingC", giveItem, weapons.RIDINGC);
			addButton(7, "RRapier", giveItem, weapons.RRAPIER);
			addButton(8, "S.Blade", giveItem, weapons.S_BLADE);
			
			addButton(4, "Page 2/3", itemSpawnWeaponsMenuIII);
			addButton(9, "Back", itemSpawnMenu);
		}
		private function itemSpawnWeaponsMenuIII():void {
			menu();
			addButton(0, "S.Gauntlet", giveItem, weapons.S_GAUNT);
			addButton(1, "ScarBlade", giveItem, weapons.SCARBLD);
			addButton(2, "Spear", giveItem, weapons.SPEAR);
			addButton(3, "SucWhip", giveItem, weapons.SUCWHIP);
			
			addButton(5, "W.Staff", giveItem, weapons.W_STAFF);
			addButton(6, "Warhammer", giveItem, weapons.WARHAMR);
			addButton(7, "Whip", giveItem, weapons.WHIP);
			
			
			addButton(4, "Page 3/3", itemSpawnWeaponsMenuI);
			addButton(9, "Back", itemSpawnMenu);
		}
		
		private function itemSpawnArmoursMenuI():void {
			menu();
			addButton(0, "G. Clothes", giveItem, armors.ADVCLTH);
			addButton(1, "Long Dress", giveItem, armors.B_DRESS);
			addButton(2, "Bee Armor", giveItem, armors.BEEARMR);
			addButton(3, "BimboSk", giveItem, armors.BIMBOSK);
			
			addButton(5, "BonStrp", giveItem, armors.BONSTRP);
			addButton(6, "C.Cloth", giveItem, armors.C_CLOTH);
			addButton(7, "Chn Bikini", giveItem, armors.CHBIKNI);
			addButton(8, "Suitclothes", giveItem, armors.CLSSYCL);
			
			addButton(4, "Page 1/5", itemSpawnArmoursMenuII);
			addButton(9, "Back", itemSpawnMenu);
		}
		private function itemSpawnArmoursMenuII():void {
			menu();
			addButton(0, "Full Chain", giveItem, armors.FULLCHN);
			addButton(1, "Full Plate", giveItem, armors.FULLPLT);
			addButton(2, "GelArmr", giveItem, armors.GELARMR);
			addButton(3, "GooArmr", giveItem, armors.GOOARMR);
			
			addButton(5, "I.Corst", giveItem, armors.I_CORST);
			addButton(6, "I.Robes", giveItem, armors.I_ROBES);
			addButton(7, "Indec StAr", giveItem, armors.INDECST);
			addButton(8, "LeathrA", giveItem, armors.LEATHRA);
			
			addButton(4, "Page 2/5", itemSpawnArmoursMenuIII);
			addButton(9, "Back", itemSpawnMenu);
		}
		private function itemSpawnArmoursMenuIII():void {
			menu();
			addButton(0, "UrtaLta", giveItem, armors.URTALTA);
			addButton(1, "LMArmor", giveItem, armors.LMARMOR);
			addButton(2, "T.Lthr Pants", giveItem, armors.LTHRPNT);
			addButton(3, "Lthr Robes", giveItem, armors.LTHRROB);
			
			addButton(5, "Robes", giveItem, armors.M_ROBES);
			addButton(6, "T.B.Armor", giveItem, armors.TBARMOR);
			addButton(7, "NurseCl", giveItem, armors.NURSECL);
			addButton(8, "Overalls", giveItem, armors.OVERALL);
			
			addButton(4, "Page 3/5", itemSpawnArmoursMenuIV);
			addButton(9, "Back", itemSpawnMenu);
		}
		private function itemSpawnArmoursMenuIV():void {
			menu();
			addButton(0, "R.BdySt", giveItem, armors.R_BDYST);
			addButton(1, "Rbbr Fetish", giveItem, armors.RBBRCLT);
			addButton(2, "S.Swmwr", giveItem, armors.S_SWMWR);
			addButton(3, "Scale Mail", giveItem, armors.SCALEML);
			
			addButton(5, "SeductA", giveItem, armors.SEDUCTA);
			addButton(6, "U.SeductA", giveItem, armors.SEDUCTU);
			addButton(7, "SS.Robes", giveItem, armors.SS_ROBE);
			addButton(8, "SS.Armor", giveItem, armors.SSARMOR);
			
			addButton(4, "Page 4/5", itemSpawnArmoursMenuV);
			addButton(9, "Back", itemSpawnMenu);
		}
		private function itemSpawnArmoursMenuV():void {
			menu();
			addButton(0, "Bodysuit", giveItem, armors.T_BSUIT);
			addButton(1, "Tube Top", giveItem, armors.TUBETOP);
			addButton(2, "W.Robes", giveItem, armors.W_ROBES);
			
			addButton(4, "Page 5/5", itemSpawnArmoursMenuI);
			addButton(9, "Back", itemSpawnMenu);
		}
		
		private function itemSpawnAccessoriesMenuI():void {
			menu();
			addButton(0, "Crimst.Ring", giveItem, jewelries.CRIMRNG);
			addButton(1, "FertiteRing", giveItem, jewelries.FERTRNG);
			addButton(2, "Icestn.Ring", giveItem, jewelries.ICE_RNG);
			addButton(3, "Life Ring", giveItem, jewelries.LIFERNG);
			
			addButton(5, "Mystic Ring", giveItem, jewelries.MYSTRNG);
			addButton(6, "Power Ring", giveItem, jewelries.POWRRNG);
			addButton(7, "Purity Ring", giveItem, jewelries.PURERNG);

			addButton(4, "Page 1/2", itemSpawnAccessoriesMenuII);
			addButton(9, "Back", itemSpawnMenu);
		}
		private function itemSpawnAccessoriesMenuII():void {
			menu();
			addButton(0, "Diam Ring", giveItem, jewelries.DIAMRNG);
			addButton(1, "Gold Ring", giveItem, jewelries.GOLDRNG);
			addButton(2, "Lethic.Ring", giveItem, jewelries.LTHCRNG);
			addButton(3, "Plat Ring", giveItem, jewelries.PLATRNG);
			
			addButton(5, "Silver Ring", giveItem, jewelries.SILVRNG);
			
			addButton(4, "Page 2/2", itemSpawnAccessoriesMenuI);
			addButton(9, "Back", itemSpawnMenu);	
		}
		//Spawn items functions
		private function giveItem(item:*):void {
			clearOutput();
			inventory.takeItem(item);
			doNext(itemSpawnMenu);
		}
		
		private function statChangeMenu():void {
			outputText("Which attribute would you like to alter?", true);
			menu();
			addButton(0, "Strength", statChangeAttributeMenu, "str")
			addButton(1, "Toughness", statChangeAttributeMenu, "tou")
			addButton(2, "Speed", statChangeAttributeMenu, "spe")
			addButton(3, "Intelligence", statChangeAttributeMenu, "int")
			addButton(5, "Libido", statChangeAttributeMenu, "lib")
			addButton(6, "Sensitivity", statChangeAttributeMenu, "sen")
			addButton(7, "Corruption", statChangeAttributeMenu, "cor")
			addButton(9, "Back", accessDebugMenu);
		}
		
		private function statChangeAttributeMenu(stats:String = ""):void {
			var attribute:* = stats;
			outputText("Increment or decrement by how much?", true);
			addButton(0, "Add 1", statChangeApply, stats, 1);
			addButton(1, "Add 5", statChangeApply, stats, 5);
			addButton(2, "Add 10", statChangeApply, stats, 10);
			addButton(3, "Add 25", statChangeApply, stats, 25);
			
			addButton(5, "Subtract 1", statChangeApply, stats, -1);
			addButton(6, "Subtract 5", statChangeApply, stats, -5);
			addButton(7, "Subtract 10", statChangeApply, stats, -10);
			addButton(8, "Subtract 25", statChangeApply, stats, -25);
			addButton(9, "Back", statChangeMenu);
			
		}
		
		private function statChangeApply(stats:String = "", increment:Number = 0):void {
			dynStats(stats, increment);
			statScreenRefresh();
			statChangeAttributeMenu(stats);
		}		
	}

}