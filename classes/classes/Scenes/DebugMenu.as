package classes.Scenes 
{
	import classes.*;
	import classes.Items.*
	import classes.GlobalFlags.kFLAGS;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.MainViewHack;
	import flash.utils.describeType;
	import flash.utils.*
	
	public class DebugMenu extends BaseContent
	{
		public var flagNames:XML = describeType(kFLAGS);
		public var mainHack:MainViewHack = new MainViewHack();
		private var lastMenu:Function = null;
		
		public var setArrays:Boolean = false;
		//public var consumableXML:XMLList = describeType(classes.Items.ConsumableLib).descendants("constant");
		
		public function DebugMenu() 
		{	
		}
		
		/*public function buildArray():void {
			if (setArrays) return;
			trace("Setting arrays");
			for each(var obj:Object in consumableXML) {
				trace(getQualifiedClassName(consumables[obj.@name]));
				if (!(getQualifiedClassName(obj) is Number || getQualifiedClassName(obj) is int || getQualifiedClassName(obj) is Array)) {
					trace("Added " + obj.@name + "!");
					kGAMECLASS.consumables.consumableItems.push(consumables[obj.@name]);
				}
			}
			setArrays = true;
		}*/
		
		public function accessDebugMenu():void {
			//buildArray();
			kGAMECLASS.tooltipLoc = "";
			if ((debug && flags[kFLAGS.HARDCORE_MODE] <= 0 || CoC_Settings.debugBuild) && !getGame().inCombat) {
				hideMenus();
				mainView.nameBox.visible = false;
				mainView.nameBox.text = "";
				mainView.nameBox.maxChars = 16;
				mainView.nameBox.restrict = null;
				outputText("Welcome to the super secret debug menu!", true);
				menu();
				addButton(0, "Spawn Items", itemSpawnMenu, null, null, null, "Spawn any items of your choice, including items usually not obtainable through gameplay.");
				addButton(1, "Change Stats", statChangeMenu, null, null, null, "Change your core stats.");
				//addButton(2, "HACK STUFFZ", styleHackMenu, null, null, null, "H4X0RZ");
				addButton(2, "Flag Editor", flagEditor);
				addButton(3, "Event Trigger", eventTriggerMenu);
				addButton(4, "MeaninglessCorr", toggleMeaninglessCorruption, null, null, null, "Toggles the Meaningless Corruption flag. If enabled, all corruption requirements are disabled for scenes.");
				addButton(14, "Exit", eventParser, 1);
			}
		}
		
		//Spawn items menu
		private function itemSpawnMenu():void {
			kGAMECLASS.tooltipLoc = "ItemDebug"
			outputText("What item would you like to spawn?", true);
			menu();
			addButton(0, "Transformatives", itemSpawnTransformativesMenuI)
			//addButton(0, "Transformatives", itemSpawnConsumableMenu)
			addButton(1, "Consumables", itemSpawnConsumablesMenuI)
			addButton(2, "Dyes", itemSpawnDyesMenuI)
			addButton(3, "Materials", itemSpawnMaterialsMenu)
			addButton(4, "Rare Items", itemSpawnRaresMenu)
			addButton(5, "Weapons", itemSpawnWeaponsMenuI)
			addButton(6, "Armours", itemSpawnArmoursMenuI)
			addButton(7, "Accessories", itemSpawnAccessoriesMenuI)
			addButton(14, "Back", accessDebugMenu);
		}
		
		/*private function itemSpawnConsumableMenu(page:int = 0):void {
			var temp:int = 0;
			var btnTemp:int = 0;
			var goal:int = 12;
			var offset:int = 12;
			menu();
			while (temp < goal) {
				if (kGAMECLASS.consumables.consumableItems[temp + (page * offset)] != undefined) {
					addButton(btnTemp, kGAMECLASS.consumables.consumableItems[temp + (page * offset)].shortName, giveItem, kGAMECLASS.consumables.consumableItems[temp + (page * offset)])
				}
				if (kGAMECLASS.consumables.consumableItems[(page * offset) + 12] != undefined) {
					addButton(4, "Next", itemSpawnConsumableMenu, page+1)
				}
				if (kGAMECLASS.consumables.consumableItems[(page * offset) - 1] != undefined) {
					addButton(9, "Previous", itemSpawnConsumableMenu, page-1)
				}
				temp++;
				btnTemp++;
				if (btnTemp == 4 || btnTemp == 9) btnTemp++;
			}
			addButton(14, "Back", itemSpawnMenu);
		}*/
		
		private function itemSpawnTransformativesMenuI():void {
			lastMenu = itemSpawnTransformativesMenuI;
			menu();
			addButton(0, "B.Gossr", giveItem, consumables.B_GOSSR);
			addButton(1, "BeeHony", giveItem, consumables.BEEHONY);
			addButton(2, "BlackPp", giveItem, consumables.BLACKPP);
			addButton(3, "BulbyPp", giveItem, consumables.BULBYPP);
			
			addButton(5, "CanineP", giveItem, consumables.CANINEP);
			addButton(6, "DblPepp", giveItem, consumables.DBLPEPP);
			addButton(7, "DryTent", giveItem, consumables.DRYTENT);
			addButton(8, "EctoPls", giveItem, consumables.ECTOPLS);
			
			addButton(10, "Equinum", giveItem, consumables.EQUINUM);
			addButton(11, "Fox Berry", giveItem, consumables.FOXBERY);
			addButton(12, "FerretFrt", giveItem, consumables.FRRTFRT);
			addButton(13, "Fox Jewel", giveItem, consumables.FOXJEWL);
			
			addButton(4, "Next", itemSpawnTransformativesMenuII);
			//addButton(9, "Previous", itemSpawnTransformativesMenuI);
			addButton(14, "Back", itemSpawnMenu);			
		}
		private function itemSpawnTransformativesMenuII():void {
			lastMenu = itemSpawnTransformativesMenuII;
			menu();
			addButton(0, "GoldenSeed", giveItem, consumables.GLDSEED);
			addButton(1, "Gob.Ale", giveItem, consumables.GOB_ALE);
			addButton(2, "Hummus", giveItem, consumables.HUMMUS_);
			addButton(3, "ImpFood", giveItem, consumables.IMPFOOD);
			
			addButton(5, "IncubiD", giveItem, consumables.INCUBID);
			addButton(6, "KangaFruit", giveItem, consumables.KANGAFT);
			addButton(7, "KnottyP", giveItem, consumables.KNOTTYP);
			addButton(8, "La Bova", giveItem, consumables.LABOVA_);
			
			addButton(10, "LargePp", giveItem, consumables.LARGEPP);
			addButton(11, "MagSeed", giveItem, consumables.MAGSEED);
			addButton(12, "MghtyVg", giveItem, consumables.MGHTYVG);
			addButton(13, "MouseCo", giveItem, consumables.MOUSECO);
			
			addButton(4, "Next", itemSpawnTransformativesMenuIII);
			addButton(9, "Previous", itemSpawnTransformativesMenuI);		
			addButton(14, "Back", itemSpawnMenu);			
		}
		private function itemSpawnTransformativesMenuIII():void {
			lastMenu = itemSpawnTransformativesMenuIII;
			menu();
			addButton(0, "MinoBlo", giveItem, consumables.MINOBLO);
			addButton(1, "MystJwl", giveItem, consumables.MYSTJWL);
			addButton(2, "P.LBova", giveItem, consumables.P_LBOVA);
			addButton(3, "PrFruit", giveItem, consumables.PRFRUIT);
			
			addButton(5, "ProBova", giveItem, consumables.PROBOVA);
			addButton(6, "P.Draft", giveItem, consumables.P_DRAFT);
			addButton(7, "P.S.Mlk", giveItem, consumables.P_S_MLK);
			addButton(8, "PSDelit", giveItem, consumables.PSDELIT);
			
			addButton(10, "PurHony", giveItem, consumables.PURHONY);
			addButton(11, "S.Delite", giveItem, consumables.SDELITE);
			addButton(12, "S.Dream", giveItem, consumables.S_DREAM);
			addButton(13, "SucMilk", giveItem, consumables.SUCMILK);
			
			addButton(4, "Next", itemSpawnTransformativesMenuIV);
			addButton(9, "Previous", itemSpawnTransformativesMenuII);
			addButton(14, "Back", itemSpawnMenu);			
		}
		private function itemSpawnTransformativesMenuIV():void {
			lastMenu = itemSpawnTransformativesMenuIV;
			menu();
			addButton(0, "Reptilum", giveItem, consumables.REPTLUM);
			addButton(1, "RingFig", giveItem, consumables.RINGFIG);
			addButton(2, "Rizza Root", giveItem, consumables.RIZZART);
			addButton(3, "S.Gossr", giveItem, consumables.S_GOSSR);
			
			addButton(5, "Shark.T", giveItem, consumables.SHARK_T);
			addButton(6, "SnakOil", giveItem, consumables.SNAKOIL);
			addButton(7, "TrapOil", giveItem, consumables.TRAPOIL);
			addButton(8, "TScroll", giveItem, consumables.TSCROLL);
			
			addButton(10, "TSTooth", giveItem, consumables.TSTOOTH);
			addButton(11, "VixVigr", giveItem, consumables.VIXVIGR);
			addButton(12, "W.Fruit", giveItem, consumables.W_FRUIT);
			addButton(13, "WetClth", giveItem, consumables.WETCLTH);
			
			//addButton(4, "Next", itemSpawnTransformativesMenuV);
			addButton(9, "Previous", itemSpawnTransformativesMenuIII);
			addButton(14, "Back", itemSpawnMenu);
		}

		private function itemSpawnConsumablesMenuI():void {
			lastMenu = itemSpawnConsumablesMenuI;
			menu();
			addButton(0, "AkbalSlv", giveItem, consumables.AKBALSL);
			addButton(1, "C. Mint", giveItem, consumables.C__MINT);
			addButton(2, "Cerulean P.", giveItem, consumables.CERUL_P);
			addButton(3, "Coal", giveItem, consumables.COAL___);
			
			addButton(5, "Debimbo", giveItem, consumables.DEBIMBO);
			addButton(6, "ExtSerm", giveItem, consumables.EXTSERM);
			addButton(7, "F.Draft", giveItem, consumables.F_DRAFT);
			addButton(8, "GroPlus", giveItem, consumables.GROPLUS);
			
			addButton(10, "HrblCnt", giveItem, consumables.HRBCNT);
			addButton(11, "Icicle", giveItem, consumables.ICICLE_);
			addButton(12, "KitGift", giveItem, consumables.KITGIFT);
			addButton(13, "LustDraft", giveItem, consumables.L_DRAFT);
			
			addButton(4, "Next", itemSpawnConsumablesMenuII);
			//addButton(9, "Previous", itemSpawnConsumablesMenuI);
			addButton(14, "Back", itemSpawnMenu);
		}
		private function itemSpawnConsumablesMenuII():void {
			lastMenu = itemSpawnConsumablesMenuII;
			menu();
			addButton(0, "Lactaid", giveItem, consumables.LACTAID);
			addButton(1, "LustStk", giveItem, consumables.LUSTSTK);
			addButton(2, "Numb Rox", giveItem, consumables.NUMBROX);
			addButton(3, "Ovi Elixir", giveItem, consumables.OVIELIX);
			
			addButton(5, "PeppWht", giveItem, consumables.PEPPWHT);
			addButton(6, "P.Pucker", giveItem, consumables.PRNPKR);
			addButton(7, "Reducto", giveItem, consumables.REDUCTO);
			addButton(8, "SensDraft", giveItem, consumables.SENSDRF);
			
			addButton(10, "Scholars T.", giveItem, consumables.SMART_T);
			addButton(11, "Vitality T.", giveItem, consumables.VITAL_T);
			addButton(12, "B. Book", giveItem, consumables.B__BOOK);
			addButton(13, "W. Book", giveItem, consumables.W__BOOK);	
			
			addButton(4, "Next", itemSpawnConsumablesMenuIII);
			addButton(9, "Previous", itemSpawnConsumablesMenuI);
			addButton(14, "Back", itemSpawnMenu);
		}
		private function itemSpawnConsumablesMenuIII():void {
			lastMenu = itemSpawnConsumablesMenuIII;
			menu();
			addButton(0, "BC Beer", giveItem, consumables.BC_BEER);
			addButton(1, "BimboCh", giveItem, consumables.BIMBOCH);
			addButton(2, "CCupcak", giveItem, consumables.CCUPCAK);
			addButton(3, "FishFil", giveItem, consumables.FISHFIL);
			
			addButton(5, "GodMead", giveItem, consumables.GODMEAD);
			addButton(6, "IzyMilk", giveItem, consumables.IZYMILK);
			addButton(7, "M. Milk", giveItem, consumables.M__MILK);
			addButton(8, "MinoCum", giveItem, consumables.MINOCUM);
			
			addButton(10, "Ph. Whiskey", giveItem, consumables.P_WHSKY);
			addButton(11, "PurPeac", giveItem, consumables.PURPEAC);
			addButton(12, "SheepMk", giveItem, consumables.SHEEPMK);
			addButton(13, "SpringWtr", giveItem, consumables.S_WATER);
			
			addButton(4, "Next", itemSpawnConsumablesMenuIV);
			addButton(9, "Previous", itemSpawnConsumablesMenuII);
			addButton(14, "Back", itemSpawnMenu);
		}
		private function itemSpawnConsumablesMenuIV():void {
			lastMenu = itemSpawnConsumablesMenuIV;
			menu();
			addButton(0, "NPnkEgg", giveItem, consumables.NPNKEGG);
			addButton(1, "DrgnEgg", giveItem, consumables.DRGNEGG);
			addButton(2, "Condom", giveItem, useables.CONDOM);
			addButton(3, "MilkPtn", giveItem, consumables.MILKPTN);
			
			addButton(5, "W.Pudding", giveItem, consumables.W_PDDNG);
			
			addButton(4, "Next", itemSpawnConsumablesMenuV);
			addButton(9, "Previous", itemSpawnConsumablesMenuIII);
			addButton(14, "Back", itemSpawnMenu);
		}
		private function itemSpawnConsumablesMenuV():void {
			lastMenu = itemSpawnConsumablesMenuV;
			menu();
			addButton(0, "BlackEg", giveItem, consumables.BLACKEG);
			addButton(1, "L.BlkEg", giveItem, consumables.L_BLKEG);
			addButton(2, "BlueEgg", giveItem, consumables.BLUEEGG);
			addButton(3, "L.BluEg", giveItem, consumables.L_BLUEG);
			
			addButton(5, "BrownEg", giveItem, consumables.BROWNEG);
			addButton(6, "L.BrnEg", giveItem, consumables.L_BRNEG);
			addButton(7, "PinkEgg", giveItem, consumables.PINKEGG);
			addButton(8, "L.PnkEg", giveItem, consumables.L_PNKEG);
			
			addButton(10, "PurplEg", giveItem, consumables.PURPLEG);
			addButton(11, "L.PrpEg", giveItem, consumables.L_PRPEG);
			addButton(12, "WhiteEg", giveItem, consumables.WHITEEG);
			addButton(13, "L.WhtEg", giveItem, consumables.L_WHTEG);
			
			//addButton(4, "Next", itemSpawnConsumablesMenuVI);
			addButton(9, "Previous", itemSpawnConsumablesMenuIV);
			addButton(14, "Back", itemSpawnMenu);
		}
		
		private function itemSpawnDyesMenuI():void {
			lastMenu = itemSpawnDyesMenuI;
			menu();
			addButton(0, "AuburnD", giveItem, consumables.AUBURND);
			addButton(1, "Black D", giveItem, consumables.BLACK_D);
			addButton(2, "Blond D", giveItem, consumables.BLOND_D);
			addButton(3, "BlueDye", giveItem, consumables.BLUEDYE);
			
			addButton(5, "Brown D", giveItem, consumables.BROWN_D);
			addButton(6, "GrayDye", giveItem, consumables.GRAYDYE);
			addButton(7, "Green D", giveItem, consumables.GREEN_D);
			addButton(8, "OrangDy", giveItem, consumables.ORANGDY);
			
			addButton(10, "PinkDye", giveItem, consumables.PINKDYE);
			addButton(11, "PurpDye", giveItem, consumables.PURPDYE);
			addButton(12, "Red Dye", giveItem, consumables.RED_DYE);
			addButton(13, "WhiteDy", giveItem, consumables.WHITEDY);
			
			addButton(14, "Back", itemSpawnMenu);
		}
		
		private function itemSpawnMaterialsMenu():void {
			lastMenu = itemSpawnMaterialsMenu;
			menu();
			addButton(0, "GreenGl", giveItem, useables.GREENGL);
			addButton(1, "B.Chitn", giveItem, useables.B_CHITN);
			addButton(2, "T.SSilk", giveItem, useables.T_SSILK);
			
			addButton(14, "Back", itemSpawnMenu);
		}
		
		private function itemSpawnRaresMenu():void {
			lastMenu = itemSpawnRaresMenu;
			menu();
			addButton(0, "BimboLq", giveItem, consumables.BIMBOLQ);
			addButton(1, "BroBrew", giveItem, consumables.BROBREW);
			addButton(2, "GldStat", giveItem, useables.GLDSTAT);
			addButton(3, "S.Hummus", giveItem, consumables.HUMMUS2);
			
			addButton(5, "P.Pearl", giveItem, consumables.P_PEARL);
			
			addButton(14, "Back", itemSpawnMenu);
		}
		
		private function itemSpawnWeaponsMenuI():void {
			lastMenu = itemSpawnWeaponsMenuI;
			menu();
			addButton(0, "B.Sword", giveItem, weapons.B_SWORD);
			addButton(1, "L.Claymore", giveItem, weapons.CLAYMOR);
			addButton(2, "DrgnShl", giveItem, weapons.DRGNSHL);
			addButton(3, "E.Staff", giveItem, weapons.E_STAFF);
			
			addButton(5, "Flintlock", giveItem, weapons.FLINTLK);
			addButton(6, "UrtaHlb", giveItem, weapons.URTAHLB);
			addButton(7, "H.Gaunt", giveItem, weapons.H_GAUNT);
			addButton(8, "JRapier", giveItem, weapons.JRAPIER);
			
			addButton(10, "Katana", giveItem, weapons.KATANA);
			addButton(11, "L. Axe", giveItem, weapons.L__AXE);
			addButton(12, "L.Daggr", giveItem, weapons.L_DAGGR);
			addButton(13, "L.Hammr", giveItem, weapons.L_HAMMR);
			
			addButton(4, "Next", itemSpawnWeaponsMenuII);
			//addButton(9, "Previous", itemSpawnWeaponsMenuI);
			addButton(14, "Back", itemSpawnMenu);
		}
		private function itemSpawnWeaponsMenuII():void {
			lastMenu = itemSpawnWeaponsMenuII;
			menu();
			addButton(0, "Pipe", giveItem, weapons.PIPE);
			addButton(1, "Pitchfork", giveItem, weapons.PTCHFRK);
			addButton(2, "RidingC", giveItem, weapons.RIDINGC);
			addButton(3, "RRapier", giveItem, weapons.RRAPIER);
			
			addButton(5, "S.Blade", giveItem, weapons.S_BLADE);
			addButton(6, "S.Gauntlet", giveItem, weapons.S_GAUNT);
			addButton(7, "ScarBlade", giveItem, weapons.SCARBLD);
			addButton(8, "Scimitar", giveItem, weapons.SCIMITR);
			
			addButton(10, "Spear", giveItem, weapons.SPEAR);
			addButton(11, "SucWhip", giveItem, weapons.SUCWHIP);
			addButton(12, "W.Staff", giveItem, weapons.W_STAFF);
			addButton(13, "Warhammer", giveItem, weapons.WARHAMR);

			addButton(4, "Next", itemSpawnWeaponsMenuIII);
			addButton(9, "Previous", itemSpawnWeaponsMenuI);
			addButton(14, "Back", itemSpawnMenu);
		}
		private function itemSpawnWeaponsMenuIII():void {
			lastMenu = itemSpawnWeaponsMenuIII;
			menu();
			addButton(0, "Whip", giveItem, weapons.WHIP);			

			//addButton(4, "Next", itemSpawnWeaponsMenuIV);
			addButton(9, "Previous", itemSpawnWeaponsMenuII);
			addButton(14, "Back", itemSpawnMenu);
		}

		
		private function itemSpawnArmoursMenuI():void {
			lastMenu = itemSpawnArmoursMenuI;
			menu();
			addButton(0, "G. Clothes", giveItem, armors.ADVCLTH);
			addButton(1, "Long Dress", giveItem, armors.B_DRESS);
			addButton(2, "Bee Armor", giveItem, armors.BEEARMR);
			addButton(3, "BimboSk", giveItem, armors.BIMBOSK);
			
			addButton(5, "BonStrp", giveItem, armors.BONSTRP);
			addButton(6, "C.Cloth", giveItem, armors.C_CLOTH);
			addButton(7, "Chn Bikini", giveItem, armors.CHBIKNI);
			addButton(8, "Suitclothes", giveItem, armors.CLSSYCL);
			
			addButton(10, "Full Chain", giveItem, armors.FULLCHN);
			addButton(11, "Full Plate", giveItem, armors.FULLPLT);
			addButton(12, "GelArmr", giveItem, armors.GELARMR);
			addButton(13, "GooArmr", giveItem, armors.GOOARMR);
			
			addButton(4, "Next", itemSpawnArmoursMenuII);
			//addButton(9, "Previous", itemSpawnArmoursMenuI);
			addButton(14, "Back", itemSpawnMenu);
		}
		private function itemSpawnArmoursMenuII():void {
			lastMenu = itemSpawnArmoursMenuII;
			menu();
			addButton(0, "I.Corst", giveItem, armors.I_CORST);
			addButton(1, "I.Robes", giveItem, armors.I_ROBES);
			addButton(2, "Indec StAr", giveItem, armors.INDECST);
			addButton(3, "LeathrA", giveItem, armors.LEATHRA);
			
			addButton(5, "UrtaLta", giveItem, armors.URTALTA);
			addButton(6, "LMArmor", giveItem, armors.LMARMOR);
			addButton(7, "T.Lthr Pants", giveItem, armors.LTHRPNT);
			addButton(8, "Lthr Robes", giveItem, armors.LTHRROB);
			
			addButton(10, "Robes", giveItem, armors.M_ROBES);
			addButton(11, "T.B.Armor", giveItem, armors.TBARMOR);
			addButton(12, "NurseCl", giveItem, armors.NURSECL);
			addButton(13, "Overalls", giveItem, armors.OVERALL);
			
			addButton(4, "Next", itemSpawnArmoursMenuIII);
			addButton(9, "Previous", itemSpawnArmoursMenuI);
			addButton(14, "Back", itemSpawnMenu);
		}
		private function itemSpawnArmoursMenuIII():void {
			lastMenu = itemSpawnArmoursMenuIII;
			menu();
			addButton(0, "R.BdySt", giveItem, armors.R_BDYST);
			addButton(1, "Rbbr Fetish", giveItem, armors.RBBRCLT);
			addButton(2, "S.Swmwr", giveItem, armors.S_SWMWR);
			addButton(3, "Scale Mail", giveItem, armors.SCALEML);
			
			addButton(5, "SeductA", giveItem, armors.SEDUCTA);
			addButton(6, "U.SeductA", giveItem, armors.SEDUCTU);
			addButton(7, "SS.Robes", giveItem, armors.SS_ROBE);
			addButton(8, "SS.Armor", giveItem, armors.SSARMOR);
			
			addButton(10, "Bodysuit", giveItem, armors.T_BSUIT);
			addButton(11, "Tube Top", giveItem, armors.TUBETOP);
			addButton(12, "W.Robes", giveItem, armors.W_ROBES);
			
			//addButton(4, "Next", itemSpawnArmoursMenuIV);
			addButton(9, "Previous", itemSpawnArmoursMenuII);
			addButton(14, "Back", itemSpawnMenu);
		}
		
		private function itemSpawnAccessoriesMenuI():void {
			lastMenu = itemSpawnAccessoriesMenuI;
			menu();
			addButton(0, "Crimst.Ring", giveItem, jewelries.CRIMRNG);
			addButton(1, "FertiteRing", giveItem, jewelries.FERTRNG);
			addButton(2, "Icestn.Ring", giveItem, jewelries.ICE_RNG);
			addButton(3, "Life Ring", giveItem, jewelries.LIFERNG);
			
			addButton(5, "Mystic Ring", giveItem, jewelries.MYSTRNG);
			addButton(6, "Power Ring", giveItem, jewelries.POWRRNG);
			addButton(7, "Purity Ring", giveItem, jewelries.PURERNG);
			addButton(8, "Diam Ring", giveItem, jewelries.DIAMRNG);
			
			addButton(10, "Gold Ring", giveItem, jewelries.GOLDRNG);
			addButton(11, "Lethic.Ring", giveItem, jewelries.LTHCRNG);
			addButton(12, "Plat Ring", giveItem, jewelries.PLATRNG);
			addButton(13, "Silver Ring", giveItem, jewelries.SILVRNG);
			
			//addButton(4, "Next", itemSpawnAccessoriesMenuII);
			//addButton(9, "Previous", itemSpawnAccessoriesMenuI);
			addButton(14, "Back", itemSpawnMenu);
		}

		private function giveItem(item:*):void {
			clearOutput();
			inventory.takeItem(item, lastMenu);
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
			addButton(14, "Back", accessDebugMenu);
		}
		
		private function statChangeAttributeMenu(stats:String = ""):void {
			var attribute:* = stats;
			outputText("Increment or decrement by how much?", true);
			addButton(0, "Add 1", statChangeApply, stats, 1);
			addButton(1, "Add 5", statChangeApply, stats, 5);
			addButton(2, "Add 10", statChangeApply, stats, 10);
			addButton(3, "Add 25", statChangeApply, stats, 25);
			addButton(4, "Add 50", statChangeApply, stats, 50);
			addButton(5, "Subtract 1", statChangeApply, stats, -1);
			addButton(6, "Subtract 5", statChangeApply, stats, -5);
			addButton(7, "Subtract 10", statChangeApply, stats, -10);
			addButton(8, "Subtract 25", statChangeApply, stats, -25);
			addButton(9, "Subtract 50", statChangeApply, stats, -50);
			addButton(14, "Back", statChangeMenu);
		}
		
		private function statChangeApply(stats:String = "", increment:Number = 0):void {
			dynStats(stats, increment);
			statScreenRefresh();
			statChangeAttributeMenu(stats);
		}
		
		private function styleHackMenu():void {
			menu()
			outputText("TEST STUFFZ", true);
			addButton(0, "HackSideBar", mainHack.refreshStats);
			addButton(1, "ASPLODE", styleHackMenu);
			addButton(2, "Advance Minute", cheatTime, 0.25);
			addButton(14, "Back", accessDebugMenu);
		}
		
		private function eventTriggerMenu():void {
			menu();
			addButton(0, "Anemone", kGAMECLASS.anemoneScene.anemoneKidBirthPtII);
			//addButton(0, "Marae Purify", kGAMECLASS.highMountains.minervaScene.minervaPurification.purificationByMarae);
			//addButton(1, "Jojo Purify", kGAMECLASS.highMountains.minervaScene.minervaPurification.purificationByJojoPart1);
			//addButton(2, "Rathazul Purify", kGAMECLASS.highMountains.minervaScene.minervaPurification.purificationByRathazul);
			
			addButton(14, "Back", accessDebugMenu);
		}
		
		private function toggleMeaninglessCorruption():void {
			clearOutput();
			if (flags[kFLAGS.MEANINGLESS_CORRUPTION] == 0) {
				flags[kFLAGS.MEANINGLESS_CORRUPTION] = 1;
				outputText("<b>Set MEANINGLESS_CORRUPTION flag to 1.</b>");
			}
			else {
				flags[kFLAGS.MEANINGLESS_CORRUPTION] = 0;
				outputText("<b>Set MEANINGLESS_CORRUPTION flag to 0.</b>");
			}
		}
		
		private function flagEditor():void {
			clearOutput();
			menu();
			outputText("This is the Flag Editor.  You can edit flags from here.  For flags reference, look at kFLAGS.as class file.  Please input any number from 0 to 2999.");
			outputText("\n\n<b>WARNING: This might screw up your save file so backup your saves before using this!</b>");
			mainView.nameBox.visible = true;
			mainView.nameBox.x = mainView.mainText.x + 5;
			mainView.nameBox.y = mainView.mainText.y + 3 + mainView.mainText.textHeight;
			mainView.nameBox.text = "";
			mainView.nameBox.maxChars = 4;
			mainView.nameBox.restrict = "0-9";
			addButton(0, "OK", editFlag);
			addButton(4, "Done", accessDebugMenu);
		}
		
		private function editFlag():void {
			var flagId:int = int(mainView.nameBox.text);
			clearOutput();
			menu();
			if (flagId < 0 || flagId >= 3000) {
				mainView.nameBox.visible = false;
				outputText("That flag does not exist!");
				doNext(flagEditor);
				return;
			}
			mainView.nameBox.visible = true;
			mainView.nameBox.x = mainView.mainText.x + 5;
			mainView.nameBox.y = mainView.mainText.y + 3 + mainView.mainText.textHeight;
			mainView.nameBox.maxChars = 127;
			mainView.nameBox.restrict = null;
			mainView.nameBox.text = flags[flagId];
			addButton(0, "Save", saveFlag, flagId);
			addButton(1, "Discard", flagEditor);
		}
		
		private function saveFlag(flagId:int = 0):void {
			flags[flagId] = mainView.nameBox.text;
			flagEditor();
		}
	}

}