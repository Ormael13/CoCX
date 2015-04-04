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
				addButton(2, "Flag Editor", flagEditor);
				//addButton(5, "Event Trigger", eventTriggerMenu);
				addButton(6, "MeaninglessCorr", toggleMeaninglessCorruption, null, null, null, "Toggles the Meaningless Corruption flag. If enabled, all corruption requirements are disabled for scenes.");
				addButton(5, "Reset NPC", resetNPCMenu, null, null, null, "Choose a NPC to reset.");
				addButton(7, "HACK STUFFZ", styleHackMenu, null, null, null, "H4X0RZ");
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
			addButton(8, "Shields", itemSpawnShieldsMenu);
			addButton(9, "Undergarments", itemSpawnUndergarmentsMenu);
			addButton(14, "Back", accessDebugMenu);
		}
		
		private function addItemButton(item:*):void {
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
			addButton(button, item.shortName, giveItem, item);
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
			addItemButton(consumables.B_GOSSR);
			addItemButton(consumables.BEEHONY);
			addItemButton(consumables.BLACKPP);
			addItemButton(consumables.BULBYPP);

			addItemButton(consumables.CANINEP);
			addItemButton(consumables.DBLPEPP);
			addItemButton(consumables.DRYTENT);
			addItemButton(consumables.ECTOPLS);

			addItemButton(consumables.EQUINUM);
			addItemButton(consumables.FOXBERY);
			addItemButton(consumables.FRRTFRT);
			addItemButton(consumables.FOXJEWL);
			
			addButton(4, "Next", itemSpawnTransformativesMenuII);
			//addButton(9, "Previous", itemSpawnTransformativesMenuI);
			addButton(14, "Back", itemSpawnMenu);			
		}
		private function itemSpawnTransformativesMenuII():void {
			lastMenu = itemSpawnTransformativesMenuII;
			menu();
			addItemButton(consumables.GLDSEED);
			addItemButton(consumables.GOB_ALE);
			addItemButton(consumables.HUMMUS_);
			addItemButton(consumables.IMPFOOD);
			
			addItemButton(consumables.INCUBID);
			addItemButton(consumables.KANGAFT);
			addItemButton(consumables.KNOTTYP);
			addItemButton(consumables.LABOVA_);
			
			addItemButton(consumables.LARGEPP);
			addItemButton(consumables.MAGSEED);
			addItemButton(consumables.MGHTYVG);
			addItemButton(consumables.MOUSECO);
			
			addButton(4, "Next", itemSpawnTransformativesMenuIII);
			addButton(9, "Previous", itemSpawnTransformativesMenuI);		
			addButton(14, "Back", itemSpawnMenu);			
		}
		private function itemSpawnTransformativesMenuIII():void {
			lastMenu = itemSpawnTransformativesMenuIII;
			menu();
			addItemButton(consumables.MINOBLO);
			addItemButton(consumables.MYSTJWL);
			addItemButton(consumables.P_LBOVA);
			addItemButton(consumables.PIGTRUF);
			
			addItemButton(consumables.PRFRUIT);
			addItemButton(consumables.PROBOVA);
			addItemButton(consumables.P_DRAFT);
			addItemButton(consumables.P_S_MLK);
			
			addItemButton(consumables.PSDELIT);
			addItemButton(consumables.PURHONY);
			addItemButton(consumables.SDELITE);
			addItemButton(consumables.S_DREAM);
			
			addButton(4, "Next", itemSpawnTransformativesMenuIV);
			addButton(9, "Previous", itemSpawnTransformativesMenuII);
			addButton(14, "Back", itemSpawnMenu);			
		}
		private function itemSpawnTransformativesMenuIV():void {
			lastMenu = itemSpawnTransformativesMenuIV;
			menu();
			addItemButton(consumables.SUCMILK);
			addItemButton(consumables.REPTLUM);
			addItemButton(consumables.RINGFIG);
			addItemButton(consumables.RIZZART);
			
			addItemButton(consumables.S_GOSSR);
			addItemButton(consumables.SHARK_T);
			addItemButton(consumables.SNAKOIL);
			addItemButton(consumables.SPHONEY);
			
			addItemButton(consumables.TAURICO);
			addItemButton(consumables.TRAPOIL);
			addItemButton(consumables.TSCROLL);
			addItemButton(consumables.TSTOOTH);
			
			addButton(4, "Next", itemSpawnTransformativesMenuV);
			addButton(9, "Previous", itemSpawnTransformativesMenuIII);
			addButton(14, "Back", itemSpawnMenu);
		}
		private function itemSpawnTransformativesMenuV():void {
			lastMenu = itemSpawnTransformativesMenuV;
			menu();
			addItemButton(consumables.VIXVIGR);
			addItemButton(consumables.W_FRUIT);
			addItemButton(consumables.WETCLTH);
			
			addButton(9, "Previous", itemSpawnTransformativesMenuIV);
			addButton(14, "Back", itemSpawnMenu);
		}

		private function itemSpawnConsumablesMenuI():void {
			lastMenu = itemSpawnConsumablesMenuI;
			menu();
			addItemButton(consumables.AKBALSL);
			addItemButton(consumables.C__MINT);
			addItemButton(consumables.CERUL_P);
			addItemButton(consumables.COAL___);
			
			addItemButton(consumables.DEBIMBO);
			addItemButton(consumables.EXTSERM);
			addItemButton(consumables.F_DRAFT);
			addItemButton(consumables.GROPLUS);
			
			addItemButton(consumables.HRBCNT);
			addItemButton(consumables.ICICLE_);
			addItemButton(consumables.KITGIFT);
			addItemButton(consumables.L_DRAFT);
			
			addButton(4, "Next", itemSpawnConsumablesMenuII);
			//addButton(9, "Previous", itemSpawnConsumablesMenuI);
			addButton(14, "Back", itemSpawnMenu);
		}
		private function itemSpawnConsumablesMenuII():void {
			lastMenu = itemSpawnConsumablesMenuII;
			menu();
			addItemButton(consumables.LACTAID);
			addItemButton(consumables.LUSTSTK);
			addItemButton(consumables.NUMBROX);
			addItemButton(consumables.OVIELIX);
			
			addItemButton(consumables.PEPPWHT);
			addItemButton(consumables.PRNPKR);
			addItemButton(consumables.REDUCTO);
			addItemButton(consumables.SENSDRF);
			
			addItemButton(consumables.SMART_T);
			addItemButton(consumables.VITAL_T);
			addItemButton(consumables.B__BOOK);
			addItemButton(consumables.W__BOOK);	
			
			addButton(4, "Next", itemSpawnConsumablesMenuIII);
			addButton(9, "Previous", itemSpawnConsumablesMenuI);
			addButton(14, "Back", itemSpawnMenu);
		}
		private function itemSpawnConsumablesMenuIII():void {
			lastMenu = itemSpawnConsumablesMenuIII;
			menu();
			addItemButton(consumables.BC_BEER);
			addItemButton(consumables.BIMBOCH);
			addItemButton(consumables.CCUPCAK);
			addItemButton(consumables.FISHFIL);
			
			addItemButton(consumables.GODMEAD);
			addItemButton(consumables.IZYMILK);
			addItemButton(consumables.M__MILK);
			addItemButton(consumables.MINOCUM);
			
			addItemButton(consumables.P_WHSKY);
			addItemButton(consumables.PURPEAC);
			addItemButton(consumables.SHEEPMK);
			addItemButton(consumables.S_WATER);
			
			addButton(4, "Next", itemSpawnConsumablesMenuIV);
			addButton(9, "Previous", itemSpawnConsumablesMenuII);
			addButton(14, "Back", itemSpawnMenu);
		}
		private function itemSpawnConsumablesMenuIV():void {
			lastMenu = itemSpawnConsumablesMenuIV;
			menu();
			addItemButton(consumables.NPNKEGG);
			addItemButton(consumables.DRGNEGG);
			addItemButton(useables.CONDOM);
			addItemButton(consumables.MILKPTN);
			
			addItemButton(consumables.W_PDDNG);
			
			addButton(4, "Next", itemSpawnConsumablesMenuV);
			addButton(9, "Previous", itemSpawnConsumablesMenuIII);
			addButton(14, "Back", itemSpawnMenu);
		}
		private function itemSpawnConsumablesMenuV():void {
			lastMenu = itemSpawnConsumablesMenuV;
			menu();
			addItemButton(consumables.BLACKEG);
			addItemButton(consumables.L_BLKEG);
			addItemButton(consumables.BLUEEGG);
			addItemButton(consumables.L_BLUEG);
			
			addItemButton(consumables.BROWNEG);
			addItemButton(consumables.L_BRNEG);
			addItemButton(consumables.PINKEGG);
			addItemButton(consumables.L_PNKEG);
			
			addItemButton(consumables.PURPLEG);
			addItemButton(consumables.L_PRPEG);
			addItemButton(consumables.WHITEEG);
			addItemButton(consumables.L_WHTEG);
			
			//addButton(4, "Next", itemSpawnConsumablesMenuVI);
			addButton(9, "Previous", itemSpawnConsumablesMenuIV);
			addButton(14, "Back", itemSpawnMenu);
		}
		
		private function itemSpawnDyesMenuI():void {
			lastMenu = itemSpawnDyesMenuI;
			menu();
			addItemButton(consumables.AUBURND);
			addItemButton(consumables.BLACK_D);
			addItemButton(consumables.BLOND_D);
			addItemButton(consumables.BLUEDYE);
			
			addItemButton(consumables.BROWN_D);
			addItemButton(consumables.GRAYDYE);
			addItemButton(consumables.GREEN_D);
			addItemButton(consumables.ORANGDY);
			
			addItemButton(consumables.PINKDYE);
			addItemButton(consumables.PURPDYE);
			addItemButton(consumables.RAINDYE);
			addItemButton(consumables.RED_DYE);
			
			addButton(4, "Next", itemSpawnDyesMenuII);
			addButton(14, "Back", itemSpawnMenu);
		}
		
		private function itemSpawnDyesMenuII():void {
			lastMenu = itemSpawnDyesMenuII;
			menu();
			addItemButton(consumables.WHITEDY);
			
			addButton(9, "Previous", itemSpawnDyesMenuI);
			addButton(14, "Back", itemSpawnMenu);
		}
		
		private function itemSpawnMaterialsMenu():void {
			lastMenu = itemSpawnMaterialsMenu;
			menu();
			addItemButton(useables.GREENGL);
			addItemButton(useables.B_CHITN);
			addItemButton(useables.T_SSILK);
			addItemButton(useables.D_SCALE);
			
			addItemButton(useables.IMPSKLL);
			
			addButton(14, "Back", itemSpawnMenu);
		}
		
		private function itemSpawnRaresMenu():void {
			lastMenu = itemSpawnRaresMenu;
			menu();
			addItemButton(consumables.BIMBOLQ);
			addItemButton(consumables.BROBREW);
			addItemButton(useables.GLDSTAT);
			addItemButton(consumables.HUMMUS2);
			
			addItemButton(consumables.P_PEARL);
			
			addButton(14, "Back", itemSpawnMenu);
		}
		
		private function itemSpawnWeaponsMenuI():void {
			lastMenu = itemSpawnWeaponsMenuI;
			menu();
			addItemButton(weapons.B_SCARB);
			addItemButton(weapons.B_SWORD);
			addItemButton(weapons.BLUNDER);
			addItemButton(weapons.CLAYMOR);
			
			addItemButton(weapons.CROSSBW);
			addItemButton(weapons.E_STAFF);
			addItemButton(weapons.FLAIL);
			addItemButton(weapons.FLINTLK);
			
			addItemButton(weapons.URTAHLB);
			addItemButton(weapons.H_GAUNT);
			addItemButton(weapons.JRAPIER);
			addItemButton(weapons.KATANA);
			
			addButton(4, "Next", itemSpawnWeaponsMenuII);
			//addButton(9, "Previous", itemSpawnWeaponsMenuI);
			addButton(14, "Back", itemSpawnMenu);
		}
		private function itemSpawnWeaponsMenuII():void {
			lastMenu = itemSpawnWeaponsMenuII;
			menu();
			addItemButton(weapons.L__AXE);
			addItemButton(weapons.L_DAGGR);
			addItemButton(weapons.L_HAMMR);
			addItemButton(weapons.L_STAFF);
			
			addItemButton(weapons.MACE);
			addItemButton(weapons.PIPE);
			addItemButton(weapons.PTCHFRK);			
			addItemButton(weapons.RIDINGC);
			
			addItemButton(weapons.RRAPIER);
			addItemButton(weapons.S_BLADE);
			addItemButton(weapons.S_GAUNT);			
			addItemButton(weapons.SCARBLD);
			
			
			addButton(4, "Next", itemSpawnWeaponsMenuIII);
			addButton(9, "Previous", itemSpawnWeaponsMenuI);
			addButton(14, "Back", itemSpawnMenu);
		}
		private function itemSpawnWeaponsMenuIII():void {
			lastMenu = itemSpawnWeaponsMenuIII;
			menu();
			addItemButton(weapons.SCIMITR);
			addItemButton(weapons.SPEAR);
			addItemButton(weapons.SUCWHIP);
			addItemButton(weapons.W_STAFF);
			
			addItemButton(weapons.WARHAMR);
			addItemButton(weapons.WHIP);			

			//addButton(4, "Next", itemSpawnWeaponsMenuIV);
			addButton(9, "Previous", itemSpawnWeaponsMenuII);
			addButton(14, "Back", itemSpawnMenu);
		}

		
		private function itemSpawnArmoursMenuI():void {
			lastMenu = itemSpawnArmoursMenuI;
			menu();
			addItemButton(armors.ADVCLTH);
			addItemButton(armors.B_DRESS);
			addItemButton(armors.BEEARMR);
			addItemButton(armors.BIMBOSK);
			
			addItemButton(armors.BONSTRP);
			addItemButton(armors.C_CLOTH);
			addItemButton(armors.CHBIKNI);
			addItemButton(armors.CLSSYCL);
			
			addItemButton(armors.DBARMOR);
			addItemButton(armors.FULLCHN);
			addItemButton(armors.FULLPLT);
			addItemButton(armors.GELARMR);
			
			addButton(4, "Next", itemSpawnArmoursMenuII);
			//addButton(9, "Previous", itemSpawnArmoursMenuI);
			addButton(14, "Back", itemSpawnMenu);
		}
		private function itemSpawnArmoursMenuII():void {
			lastMenu = itemSpawnArmoursMenuII;
			menu();
			addItemButton(armors.GOOARMR);
			addItemButton(armors.I_CORST);
			addItemButton(armors.I_ROBES);
			addItemButton(armors.INDECST);
			
			addItemButton(armors.LEATHRA);
			addItemButton(armors.URTALTA);
			addItemButton(armors.LMARMOR);
			addItemButton(armors.LTHCARM);
			
			addItemButton(armors.LTHRPNT);
			addItemButton(armors.LTHRROB);
			addItemButton(armors.M_ROBES);
			addItemButton(armors.TBARMOR);
			
			addButton(4, "Next", itemSpawnArmoursMenuIII);
			addButton(9, "Previous", itemSpawnArmoursMenuI);
			addButton(14, "Back", itemSpawnMenu);
		}
		private function itemSpawnArmoursMenuIII():void {
			lastMenu = itemSpawnArmoursMenuIII;
			menu();
			addItemButton(armors.NURSECL);
			addItemButton(armors.OVERALL);
			addItemButton(armors.R_BDYST);
			addItemButton(armors.RBBRCLT);
			
			addItemButton(armors.S_SWMWR);
			addItemButton(armors.SCALEML);
			addItemButton(armors.SEDUCTA);
			addItemButton(armors.SEDUCTU);
			
			addItemButton(armors.SS_ROBE);
			addItemButton(armors.SSARMOR);
			addItemButton(armors.T_BSUIT);
			addItemButton(armors.TUBETOP);
			
			
			addButton(4, "Next", itemSpawnArmoursMenuIV);
			addButton(9, "Previous", itemSpawnArmoursMenuII);
			addButton(14, "Back", itemSpawnMenu);
		}
		private function itemSpawnArmoursMenuIV():void {
			lastMenu = itemSpawnArmoursMenuIV;
			menu();
			addItemButton(armors.W_ROBES);
			
			//addButton(4, "Next", itemSpawnArmoursMenuIV);
			addButton(9, "Previous", itemSpawnArmoursMenuIII);
			addButton(14, "Back", itemSpawnMenu);
		}
		
		private function itemSpawnAccessoriesMenuI():void {
			lastMenu = itemSpawnAccessoriesMenuI;
			menu();
			addItemButton(jewelries.CRIMRNG);
			addItemButton(jewelries.FERTRNG);
			addItemButton(jewelries.ICE_RNG);
			addItemButton(jewelries.LIFERNG);
			
			addItemButton(jewelries.MYSTRNG);
			addItemButton(jewelries.POWRRNG);
			addItemButton(jewelries.PURERNG);
			addItemButton(jewelries.DIAMRNG);
			
			addItemButton(jewelries.GOLDRNG);
			addItemButton(jewelries.LTHCRNG);
			addItemButton(jewelries.PLATRNG);
			addItemButton(jewelries.SILVRNG);
			
			//addButton(4, "Next", itemSpawnAccessoriesMenuII);
			//addButton(9, "Previous", itemSpawnAccessoriesMenuI);
			addButton(14, "Back", itemSpawnMenu);
		}
		
		private function itemSpawnShieldsMenu():void {
			lastMenu = itemSpawnShieldsMenu;
			menu();
			addItemButton(shields.BUCKLER);
			addItemButton(shields.DRGNSHL);
			addItemButton(shields.GREATSH);
			addItemButton(shields.KITE_SH);
			addItemButton(shields.TOWERSH);
			
			//addButton(4, "Next", itemSpawnAccessoriesMenuII);
			//addButton(9, "Previous", itemSpawnAccessoriesMenuI);
			addButton(14, "Back", itemSpawnMenu);
		}

		private function itemSpawnUndergarmentsMenu():void {
			lastMenu = itemSpawnUndergarmentsMenu;
			menu();
			addItemButton(undergarments.C_BRA);
			addItemButton(undergarments.C_LOIN);
			addItemButton(undergarments.C_PANTY);
			addItemButton(undergarments.DS_BRA);
			
			addItemButton(undergarments.DS_LOIN);
			addItemButton(undergarments.DSTHONG);
			addItemButton(undergarments.FURLOIN);
			addItemButton(undergarments.GARTERS);
			
			addItemButton(undergarments.LTX_BRA);
			addItemButton(undergarments.LTXSHRT);
			addItemButton(undergarments.LTXTHNG);
			addItemButton(undergarments.SS_BRA);
			
			addButton(4, "Next", itemSpawnUndergarmentsMenuII);
			//addButton(9, "Previous", itemSpawnUndergarmentsMenu);
			addButton(14, "Back", itemSpawnMenu);
		}
		private function itemSpawnUndergarmentsMenuII():void {
			lastMenu = itemSpawnUndergarmentsMenuII;
			menu();
			addItemButton(undergarments.SS_LOIN);
			addItemButton(undergarments.SSPANTY);
			
			//addButton(4, "Next", itemSpawnUndergarmentsMenuII);
			addButton(9, "Previous", itemSpawnUndergarmentsMenu);
			addButton(14, "Back", itemSpawnMenu);
		}
		
		private function giveItem(item:*):void {
			clearOutput();
			inventory.takeItem(item, lastMenu);
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
			addButton(0, "ASPLODE", styleHackMenu);
			if (player.hasKeyItem("Backpack") < 0) addButton(1, "Unlock slots", gimmeALLTheSlotz, null, null, null, "Unlocks inventory slots 6 through 10 for testing purposes.")
			addButton(14, "Back", accessDebugMenu);
		}
		
		private function gimmeALLTheSlotz():void {
			clearOutput();
			outputText("Here you go. <b>Backpack GET!</b>");
			player.createKeyItem("Backpack", 5, 0, 0, 0);
			doNext(styleHackMenu);
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
		
		private function resetNPCMenu():void {
			clearOutput();
			outputText("Which NPC would you like to reset?");
			menu();
			if (flags[kFLAGS.URTA_COMFORTABLE_WITH_OWN_BODY] < 0 || flags[kFLAGS.URTA_QUEST_STATUS] == -1) addButton(0, "Urta", resetUrta);
			if (flags[kFLAGS.SHEILA_DISABLED] > 0 || flags[kFLAGS.SHEILA_DEMON] > 0 || flags[kFLAGS.SHEILA_CITE] < 0 || flags[kFLAGS.SHEILA_CITE] >= 6) addButton(6, "Sheila", resetSheila);
			addButton(14, "Back", accessDebugMenu);
		}
		
		private function resetUrta():void {
			clearOutput();
			outputText("Did you do something wrong and get Urta heartbroken or did you fail Urta's quest? You can reset if you want to.");
			doYesNo(reallyResetUrta, resetNPCMenu);
		}
		private function reallyResetUrta():void {
			clearOutput();
			if (flags[kFLAGS.URTA_QUEST_STATUS] == -1) {
				outputText("Somehow, you have a feeling that Urta somehow went back to Tel'Adre.  ");
				flags[kFLAGS.URTA_QUEST_STATUS] = 0;
			}
			if (flags[kFLAGS.URTA_COMFORTABLE_WITH_OWN_BODY] < 0) {
				outputText("You have a feeling that Urta finally got over with her depression and went back to normal.  ");
				flags[kFLAGS.URTA_COMFORTABLE_WITH_OWN_BODY] = 0;
			}
			doNext(resetNPCMenu);
		}
		
		private function resetSheila():void {
			clearOutput();
			outputText("Did you do something wrong with Sheila? Turned her into demon? Lost the opportunity to get her lethicite? No problem, you can just reset her!");
			doYesNo(reallyResetSheila, resetNPCMenu);
		}
		private function reallyResetSheila():void {
			clearOutput();
			if (flags[kFLAGS.SHEILA_DISABLED] > 0) {
				outputText("You can finally encounter Sheila again!  ");
				flags[kFLAGS.SHEILA_DISABLED] = 0;
			}
			if (flags[kFLAGS.SHEILA_DEMON] > 0) {
				outputText("Sheila is no longer a demon; she is now back to normal.  ");
				flags[kFLAGS.SHEILA_DEMON] = 0;
				flags[kFLAGS.SHEILA_CORRUPTION] = 30;
			}
			if (flags[kFLAGS.SHEILA_CITE] < 0) {
				outputText("Any lost Lethicite opportunity is now regained.  ");
				flags[kFLAGS.SHEILA_CITE] = 0;
			}
			doNext(resetNPCMenu);
		}
		
		//[Flag Editor]
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
			var temp:* = Number(mainView.nameBox.text);
			if (temp is Number || temp is int) flags[flagId] = temp;
			else flags[flagId] = mainView.nameBox.text;
			flagEditor();
		}
	}

}