package classes.Scenes 
{
	import classes.*;
	import classes.Items.*
	import classes.GlobalFlags.kFLAGS;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.MainViewManager;
	import flash.utils.describeType;
	import flash.utils.*
	
	public class DebugMenu extends BaseContent
	{
		public var flagNames:XML = describeType(kFLAGS);
		private var lastMenu:Function = null;
		
		public var setArrays:Boolean = false;

		//Set up equipment arrays
		public var weaponArray:Array = [];
		public var shieldArray:Array = [];
		public var armourArray:Array = [];
		public var undergarmentArray:Array = [];
		public var accessoryArray:Array = [];
		
		//Set up item arrays
		public var transformativeArray:Array = [];
		public var consumableArray:Array = [];
		public var dyeArray:Array = [];
		public var materialArray:Array = [];
		public var rareArray:Array = [];
		
		
		public function DebugMenu() 
		{	
		}
		
		public function accessDebugMenu():void {
			//buildArray();
			if (!getGame().inCombat) {
				hideMenus();
				mainView.nameBox.visible = false;
				mainView.nameBox.text = "";
				mainView.nameBox.maxChars = 16;
				mainView.nameBox.restrict = null;
				mainView.nameBox.width = 140;
				outputText("Welcome to the super secret debug menu!", true);
				menu();
				addButton(0, "Spawn Items", itemSpawnMenu, null, null, null, "Spawn any items of your choice, including items usually not obtainable through gameplay.");
				addButton(1, "Change Stats", statChangeMenu, null, null, null, "Change your core stats.");
				addButton(2, "Flag Editor", flagEditor, null, null, null, "Edit any flag. \n\nCaution: This might screw up your save!");
				addButton(3, "Reset NPC", resetNPCMenu, null, null, null, "Choose a NPC to reset.");
				if (player.isPregnant()) addButton(4, "Abort Preg", abortPregnancy);
				addButton(5, "DumpEffects", dumpEffectsMenu, null, null, null, "Display your status effects");
				addButton(7, "HACK STUFFZ", styleHackMenu, null, null, null, "H4X0RZ");
				addButton(14, "Exit", playerMenu);
			}
			if (getGame().inCombat) {
				clearOutput();
				outputText("You raise the wand and give it a twirl but nothing happens. Seems like it only works when you're not in the middle of a battle.");
				doNext(playerMenu);
			}
		}
		private function  dumpEffectsMenu():void {
			clearOutput();
			for each (var effect:StatusEffectClass in player.statusEffects) {
				outputText("'"+effect.stype.id+"': "+effect.value1+" "+effect.value2+" "+effect.value3+" "+effect.value4+"\n");
			}
			doNext(playerMenu);
		}

		//Spawn items menu
		private function itemSpawnMenu():void {
			setItemArrays();
			clearOutput();
			outputText("Select a category.");
			menu();
			addButton(0, "Transformatives", displayItemPage, transformativeArray, 1);
			addButton(1, "Consumables", displayItemPage, consumableArray, 1);
			addButton(2, "Dyes", displayItemPage, dyeArray, 1);
			addButton(3, "Materials", displayItemPage, materialArray, 1);
			addButton(4, "Rare Items", displayItemPage, rareArray, 1);
			addButton(5, "Weapons", displayItemPage, weaponArray, 1);
			addButton(6, "Shields", displayItemPage, shieldArray, 1);
			addButton(7, "Armours", displayItemPage, armourArray, 1);
			addButton(8, "Undergarments", displayItemPage, undergarmentArray, 1);
			addButton(9, "Accessories", displayItemPage, accessoryArray, 1);
			addButton(14, "Back", accessDebugMenu);
		}
		
		private function displayItemPage(array:Array, page:int):void {
			clearOutput();
			outputText("What item would you like to spawn? ");
			menu();
			var buttonPos:int = 0; //Button positions 4 and 9 are reserved for next and previous.
			for (var i:int = 0; i < 12; i++) {
				if (array[((page-1) * 12) + i] != undefined) {
					if (array[((page-1) * 12) + i] != null) addButton(buttonPos, array[((page-1) * 12) + i].shortName, inventory.takeItem, array[((page-1) * 12) + i], curry(displayItemPage, array, page));
				}
				buttonPos++;
				if (buttonPos == 4 || buttonPos == 9) buttonPos++;
			}
			if (!isNextPageEmpty(array, page)) addButton(4, "Next", displayItemPage, array, page+1);
			if (!isPreviousPageEmpty(array, page)) addButton(9, "Previous", displayItemPage, array, page-1);
			addButton(14, "Back", itemSpawnMenu);
		}
		
		private function isPreviousPageEmpty(array:Array, page:int):Boolean {
			var isEmpty:Boolean = true;
			for (var i:int = 0; i < 12; i++) {
				if (array[((page-2) * 12) + i] != undefined) {
					isEmpty = false;
				}
			}
			return isEmpty;
		}
		
		private function isNextPageEmpty(array:Array, page:int):Boolean {
			var isEmpty:Boolean = true;
			for (var i:int = 0; i < 12; i++) {
				if (array[((page) * 12) + i] != undefined) {
					isEmpty = false;
				}
			}
			return isEmpty;
		}
		
		private function setItemArrays():void {
			if (setArrays) return; //Already set, cancel.
			//Build arrays here
			//------------
			// Transformatives
			//------------
			//Page 1
			transformativeArray.push(consumables.B_GOSSR);
			transformativeArray.push(consumables.BEEHONY);
			transformativeArray.push(consumables.BLACKPP);
			transformativeArray.push(consumables.BOARTRU);
			transformativeArray.push(consumables.BULBYPP);
			transformativeArray.push(consumables.CANINEP);
			transformativeArray.push(consumables.DBLPEPP);
			transformativeArray.push(consumables.DRAKHRT);
			transformativeArray.push(consumables.DRYTENT);
			transformativeArray.push(consumables.ECTOPLS);
			transformativeArray.push(consumables.EQUINUM);
			transformativeArray.push(consumables.FOXBERY);
			//Page 2
			transformativeArray.push(consumables.FOXJEWL);
			transformativeArray.push(consumables.FRRTFRT);
			transformativeArray.push(consumables.GLDRIND);
			transformativeArray.push(consumables.GLDSEED);
			transformativeArray.push(consumables.GOB_ALE);
			transformativeArray.push(consumables.HUMMUS_);
			transformativeArray.push(consumables.IMPFOOD);
			transformativeArray.push(consumables.INCUBID);
			transformativeArray.push(consumables.KANGAFT);
			transformativeArray.push(consumables.KNOTTYP);
			transformativeArray.push(consumables.LABOVA_);
			transformativeArray.push(consumables.LARGEPP);
			//Page 3
			transformativeArray.push(consumables.MAGSEED);
			transformativeArray.push(consumables.MGHTYVG);
			transformativeArray.push(consumables.MOUSECO);
			transformativeArray.push(consumables.MINOBLO);
			transformativeArray.push(consumables.MYSTJWL);
			transformativeArray.push(consumables.P_LBOVA);
			transformativeArray.push(consumables.PIGTRUF);
			transformativeArray.push(consumables.PRFRUIT);
			transformativeArray.push(consumables.PROBOVA);
			transformativeArray.push(consumables.P_DRAFT);
			transformativeArray.push(consumables.P_S_MLK);
			transformativeArray.push(consumables.PSDELIT);
			//Page 4
			transformativeArray.push(consumables.PURHONY);
			transformativeArray.push(consumables.SATYR_W);
			transformativeArray.push(consumables.SDELITE);
			transformativeArray.push(consumables.S_DREAM);
			transformativeArray.push(consumables.SUCMILK);
			transformativeArray.push(consumables.REPTLUM);
			transformativeArray.push(consumables.RINGFIG);
			transformativeArray.push(consumables.RIZZART);
			transformativeArray.push(consumables.S_GOSSR);
			transformativeArray.push(consumables.SALAMFW);
			transformativeArray.push(consumables.SHARK_T);
			transformativeArray.push(consumables.SNAKOIL);
			//Page 5
			transformativeArray.push(consumables.SPHONEY);
			transformativeArray.push(consumables.TAURICO);
			transformativeArray.push(consumables.TRAPOIL);
			transformativeArray.push(consumables.TSCROLL);
			transformativeArray.push(consumables.TSTOOTH);
			transformativeArray.push(consumables.VIXVIGR);
			transformativeArray.push(consumables.W_FRUIT);
			transformativeArray.push(consumables.WETCLTH);
			
			//------------
			// Consumables
			//------------
			//Page 1
			consumableArray.push(consumables.AKBALSL);
			consumableArray.push(consumables.C__MINT);
			consumableArray.push(consumables.CERUL_P);
			consumableArray.push(consumables.COAL___);
			consumableArray.push(consumables.DEBIMBO);
			consumableArray.push(consumables.EXTSERM);
			consumableArray.push(consumables.F_DRAFT);
			consumableArray.push(consumables.GROPLUS);
			consumableArray.push(consumables.H_PILL);
			consumableArray.push(consumables.HRBCNT);
			consumableArray.push(consumables.ICICLE_);
			consumableArray.push(consumables.KITGIFT);
			//Page 2
			consumableArray.push(consumables.L_DRAFT);
			consumableArray.push(consumables.LACTAID);
			consumableArray.push(consumables.LUSTSTK);
			consumableArray.push(consumables.MILKPTN);
			consumableArray.push(consumables.NUMBOIL);
			consumableArray.push(consumables.NUMBROX);
			consumableArray.push(consumables.OVIELIX);
			consumableArray.push(consumables.OVI_MAX);
			consumableArray.push(consumables.PEPPWHT);
			consumableArray.push(consumables.PPHILTR);
			consumableArray.push(consumables.PRNPKR);
			consumableArray.push(consumables.PROMEAD);
			//Page 3
			consumableArray.push(consumables.REDUCTO);
			consumableArray.push(consumables.SENSDRF);
			consumableArray.push(consumables.SMART_T);
			consumableArray.push(consumables.VITAL_T);
			consumableArray.push(consumables.B__BOOK);
			consumableArray.push(consumables.W__BOOK);
			consumableArray.push(consumables.BC_BEER);
			consumableArray.push(consumables.BHMTCUM);
			consumableArray.push(consumables.BIMBOCH);
			consumableArray.push(consumables.C_BREAD);
			consumableArray.push(consumables.CCUPCAK);
			consumableArray.push(consumables.FISHFIL);
			//Page 4
			consumableArray.push(consumables.FR_BEER);
			consumableArray.push(consumables.GODMEAD);
			consumableArray.push(consumables.H_BISCU);
			consumableArray.push(consumables.IZYMILK);
			consumableArray.push(consumables.M__MILK);
			consumableArray.push(consumables.MINOCUM);
			consumableArray.push(consumables.P_BREAD);
			consumableArray.push(consumables.P_WHSKY);
			consumableArray.push(consumables.PURPEAC);
			consumableArray.push(consumables.SHEEPMK);
			consumableArray.push(consumables.S_WATER);
			consumableArray.push(consumables.NPNKEGG);
			//Page 5
			consumableArray.push(consumables.DRGNEGG);
			consumableArray.push(consumables.W_PDDNG);
			consumableArray.push(consumables.TRAILMX);
			consumableArray.push(consumables.URTACUM);
			consumableArray.push(null);
			consumableArray.push(null);
			consumableArray.push(null);
			consumableArray.push(null);
			consumableArray.push(null);
			consumableArray.push(null);
			consumableArray.push(null);
			consumableArray.push(null);
			consumableArray.push(null);
			//Page 6
			consumableArray.push(consumables.BLACKEG);
			consumableArray.push(consumables.L_BLKEG);
			consumableArray.push(consumables.BLUEEGG);
			consumableArray.push(consumables.L_BLUEG);
			consumableArray.push(consumables.BROWNEG);
			consumableArray.push(consumables.L_BRNEG);
			consumableArray.push(consumables.PINKEGG);
			consumableArray.push(consumables.L_PNKEG);
			consumableArray.push(consumables.PURPLEG);
			consumableArray.push(consumables.L_PRPEG);
			consumableArray.push(consumables.WHITEEG);
			consumableArray.push(consumables.L_WHTEG);
			
			//------------
			// Dyes
			//------------
			//Page 1
			dyeArray.push(consumables.AUBURND);
			dyeArray.push(consumables.BLACK_D);
			dyeArray.push(consumables.BLOND_D);
			dyeArray.push(consumables.BLUEDYE);
			dyeArray.push(consumables.BROWN_D);
			dyeArray.push(consumables.GRAYDYE);
			dyeArray.push(consumables.GREEN_D);
			dyeArray.push(consumables.ORANGDY);
			dyeArray.push(consumables.PINKDYE);
			dyeArray.push(consumables.PURPDYE);
			dyeArray.push(consumables.RAINDYE);
			dyeArray.push(consumables.RED_DYE);
			//Page 2
			dyeArray.push(consumables.WHITEDY);
			
			//------------
			// Materials
			//------------
			//Page 1, which is the only page for material so far. :(
			materialArray.push(useables.GREENGL);
			materialArray.push(useables.B_CHITN);
			materialArray.push(useables.T_SSILK);
			materialArray.push(useables.D_SCALE);
			materialArray.push(useables.IMPSKLL);
			materialArray.push(useables.LETHITE);
			materialArray.push(null);
			materialArray.push(null);
			materialArray.push(null);
			materialArray.push(null);
			materialArray.push(null);
			materialArray.push(useables.CONDOM);
			//------------
			// Rare Items
			//------------
			//Page 1, again the only page available.
			rareArray.push(consumables.BIMBOLQ);
			rareArray.push(consumables.BROBREW);
			rareArray.push(consumables.HUMMUS2);
			rareArray.push(consumables.P_PEARL);
			
			rareArray.push(useables.DBGWAND);
			rareArray.push(useables.GLDSTAT);
			
			//------------
			// Weapons
			//------------
			//Page 1
			weaponArray.push(weapons.B_SCARB);
			weaponArray.push(weapons.B_SWORD);
			weaponArray.push(weapons.BLUNDER);
			weaponArray.push(weapons.CLAYMOR);
			weaponArray.push(weapons.CROSSBW);
			weaponArray.push(weapons.E_STAFF);
			weaponArray.push(weapons.FLAIL);
			weaponArray.push(weapons.FLINTLK);
			weaponArray.push(weapons.URTAHLB);
			weaponArray.push(weapons.H_GAUNT);
			weaponArray.push(weapons.JRAPIER);
			weaponArray.push(weapons.KATANA);
			//Page 2
			weaponArray.push(weapons.L__AXE);
			weaponArray.push(weapons.L_DAGGR);
			weaponArray.push(weapons.L_HAMMR);
			weaponArray.push(weapons.L_STAFF);
			weaponArray.push(weapons.L_WHIP);
			weaponArray.push(weapons.MACE);
			weaponArray.push(weapons.PIPE);
			weaponArray.push(weapons.PTCHFRK);			
			weaponArray.push(weapons.RIDINGC);
			weaponArray.push(weapons.RRAPIER);
			weaponArray.push(weapons.S_BLADE);
			weaponArray.push(weapons.S_GAUNT);
			//Page 3
			weaponArray.push(weapons.SCARBLD);
			weaponArray.push(weapons.SCIMITR);
			weaponArray.push(weapons.SPEAR);
			weaponArray.push(weapons.SUCWHIP);
			weaponArray.push(weapons.W_STAFF);
			weaponArray.push(weapons.WARHAMR);
			weaponArray.push(weapons.WHIP);
			
			//------------
			// Shields
			//------------
			//Page 1, poor shield category is so lonely. :(
			shieldArray.push(shields.BUCKLER);
			shieldArray.push(shields.DRGNSHL);
			shieldArray.push(shields.GREATSH);
			shieldArray.push(shields.KITE_SH);
			shieldArray.push(shields.TOWERSH);
			
			//------------
			// Armours
			//------------
			//Page 1
			armourArray.push(armors.ADVCLTH);
			armourArray.push(armors.B_DRESS);
			armourArray.push(armors.BEEARMR);
			armourArray.push(armors.BIMBOSK);
			armourArray.push(armors.BONSTRP);
			armourArray.push(armors.C_CLOTH);
			armourArray.push(armors.CHBIKNI);
			armourArray.push(armors.CLSSYCL);
			armourArray.push(armors.DBARMOR);
			armourArray.push(armors.FULLCHN);
			armourArray.push(armors.FULLPLT);
			armourArray.push(armors.GELARMR);
			//Page 2
			armourArray.push(armors.GOOARMR);
			armourArray.push(armors.I_CORST);
			armourArray.push(armors.I_ROBES);
			armourArray.push(armors.INDECST);
			armourArray.push(armors.KIMONO);
			armourArray.push(armors.LEATHRA);
			armourArray.push(armors.URTALTA);
			armourArray.push(armors.LMARMOR);
			armourArray.push(armors.LTHCARM);
			armourArray.push(armors.LTHRPNT);
			armourArray.push(armors.LTHRROB);
			armourArray.push(armors.M_ROBES);
			//Page 3
			armourArray.push(armors.TBARMOR);
			armourArray.push(armors.NURSECL);
			armourArray.push(armors.OVERALL);
			armourArray.push(armors.R_BDYST);
			armourArray.push(armors.RBBRCLT);
			armourArray.push(armors.S_SWMWR);
			armourArray.push(armors.SAMUARM);
			armourArray.push(armors.SCALEML);
			armourArray.push(armors.SEDUCTA);
			armourArray.push(armors.SEDUCTU);
			armourArray.push(armors.SS_ROBE);
			armourArray.push(armors.SSARMOR);
			//Page 4
			armourArray.push(armors.T_BSUIT);
			armourArray.push(armors.TUBETOP);
			armourArray.push(armors.W_ROBES);
			
			//------------
			// Undergarments
			//------------
			//Page 1
			undergarmentArray.push(undergarments.C_BRA);
			undergarmentArray.push(undergarments.C_LOIN);
			undergarmentArray.push(undergarments.C_PANTY);
			undergarmentArray.push(undergarments.DS_BRA);
			undergarmentArray.push(undergarments.DS_LOIN);
			undergarmentArray.push(undergarments.DSTHONG);
			undergarmentArray.push(undergarments.FUNDOSH);
			undergarmentArray.push(undergarments.FURLOIN);
			undergarmentArray.push(undergarments.GARTERS);
			undergarmentArray.push(undergarments.LTX_BRA);
			undergarmentArray.push(undergarments.LTXSHRT);
			undergarmentArray.push(undergarments.LTXTHNG);
			undergarmentArray.push(undergarments.SS_BRA);
			//Page 2
			undergarmentArray.push(undergarments.SS_LOIN);
			undergarmentArray.push(undergarments.SSPANTY);
			
			//------------
			// Accessories
			//------------
			//Page 1
			accessoryArray.push(jewelries.SILVRNG);
			accessoryArray.push(jewelries.GOLDRNG);
			accessoryArray.push(jewelries.PLATRNG);
			accessoryArray.push(jewelries.DIAMRNG);
			accessoryArray.push(jewelries.LTHCRNG);
			accessoryArray.push(jewelries.PURERNG);
			accessoryArray.push(null);
			accessoryArray.push(null);
			accessoryArray.push(null);
			accessoryArray.push(null);
			accessoryArray.push(null);
			accessoryArray.push(null);
			//Page 2
			accessoryArray.push(jewelries.CRIMRN1);
			accessoryArray.push(jewelries.FERTRN1);
			accessoryArray.push(jewelries.ICE_RN1);
			accessoryArray.push(jewelries.CRITRN1);
			accessoryArray.push(jewelries.REGNRN1);
			accessoryArray.push(jewelries.LIFERN1);
			accessoryArray.push(jewelries.MYSTRN1);
			accessoryArray.push(jewelries.POWRRN1);
			accessoryArray.push(null);
			accessoryArray.push(null);
			accessoryArray.push(null);
			accessoryArray.push(null);
			//Page 3
			accessoryArray.push(jewelries.CRIMRN2);
			accessoryArray.push(jewelries.FERTRN2);
			accessoryArray.push(jewelries.ICE_RN2);
			accessoryArray.push(jewelries.CRITRN2);
			accessoryArray.push(jewelries.REGNRN2);
			accessoryArray.push(jewelries.LIFERN2);
			accessoryArray.push(jewelries.MYSTRN2);
			accessoryArray.push(jewelries.POWRRN2);
			accessoryArray.push(null);
			accessoryArray.push(null);
			accessoryArray.push(null);
			accessoryArray.push(null);
			//Page 4
			accessoryArray.push(jewelries.CRIMRN3);
			accessoryArray.push(jewelries.FERTRN3);
			accessoryArray.push(jewelries.ICE_RN3);
			accessoryArray.push(jewelries.CRITRN3);
			accessoryArray.push(jewelries.REGNRN3);
			accessoryArray.push(jewelries.LIFERN3);
			accessoryArray.push(jewelries.MYSTRN3);
			accessoryArray.push(jewelries.POWRRN3);
			accessoryArray.push(null);
			accessoryArray.push(null);
			accessoryArray.push(null);
			accessoryArray.push(null);
			setArrays = true;
		}
		

		
		private function statChangeMenu():void {
			outputText("Which attribute would you like to alter?", true);
			menu();
			addButton(0, "Strength", statChangeAttributeMenu, "str");
			addButton(1, "Toughness", statChangeAttributeMenu, "tou");
			addButton(2, "Speed", statChangeAttributeMenu, "spe");
			addButton(3, "Intelligence", statChangeAttributeMenu, "int");
			addButton(5, "Libido", statChangeAttributeMenu, "lib");
			addButton(6, "Sensitivity", statChangeAttributeMenu, "sen");
			addButton(7, "Corruption", statChangeAttributeMenu, "cor");
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
			addButton(1, "Scorpion Tail", changeScorpionTail);
			addButton(2, "Be Manticore", getManticoreKit, null, null, null, "Gain everything needed to become a Manticore-morph.");
			addButton(3, "Be Dragonne", getDragonneKit, null, null, null, "Gain everything needed to become a Dragonne-morph.");
			addButton(4, "Debug Prison", debugPrison);
			addButton(5, "Tooltips Ahoy", kGAMECLASS.doNothing, null, null, null, "Ahoy! I'm a tooltip! I will show up a lot in future updates!", "Tooltip 2.0");
			addButton(14, "Back", accessDebugMenu);
		}
		
		private function changeScorpionTail():void {
			clearOutput();
			outputText("<b>Your tail is now that of a scorpion's. Currently, scorpion tail has no use but it will eventually be useful for stinging.</b>");
			player.tailType = TAIL_TYPE_SCORPION;
			player.tailVenom = 100;
			player.tailRecharge = 5;
			doNext(styleHackMenu);
		}
		
		private function getManticoreKit():void {
			clearOutput();
			outputText("<b>You are now a Manticore!</b>");
			//Cat TF
			player.faceType = FACE_CAT;
			player.earType = EARS_CAT;
			player.lowerBody = LOWER_BODY_TYPE_CAT;
			player.legCount = 2;
			player.skinType = SKIN_TYPE_FUR;
			player.skinDesc = "fur";
			player.underBody.restore(); // Restore the underbody for now
			//Draconic TF
			player.hornType = HORNS_DRACONIC_X2;
			player.horns = 4;
			player.wingType = WING_TYPE_BAT_LIKE_LARGE;
			//Scorpion TF
			player.tailType = TAIL_TYPE_SCORPION;
			player.tailVenom = 100;
			player.tailRecharge = 5;
			doNext(styleHackMenu);
		}
		
		private function getDragonneKit():void {
			clearOutput();
			outputText("<b>You are now a Dragonne!</b>");
			//Cat TF
			player.faceType = FACE_CAT;
			player.earType = EARS_CAT;
			player.tailType = TAIL_TYPE_CAT;
			player.lowerBody = LOWER_BODY_TYPE_CAT;
			player.legCount = 2;
			//Draconic TF
			player.skinType = SKIN_TYPE_DRAGON_SCALES;
			player.skinAdj = "tough";
			player.skinDesc = "shield-shaped dragon scales";
			player.furColor = player.hairColor;
			player.underBody.type = UNDER_BODY_TYPE_DRAGON;
			player.underBody.copySkin({        // copy the main skin props to the underBody skin ...
				desc: "ventral dragon scales"  // ... and only override the desc
			});
			player.tongueType = TONGUE_DRACONIC;
			player.hornType = HORNS_DRACONIC_X2;
			player.horns = 4;
			player.wingType = WING_TYPE_DRACONIC_LARGE;
			doNext(styleHackMenu);
		}
		
		private function debugPrison():void {
			clearOutput();
			doNext(styleHackMenu);
			//Stored equipment
			outputText("<b><u>Stored equipment:</u></b>");
			outputText("\n<b>Stored armour:</b> ");
			if (flags[kFLAGS.PRISON_STORAGE_ARMOR] != 0) {
				outputText("" + ItemType.lookupItem(flags[kFLAGS.PRISON_STORAGE_ARMOR]));
			}
			else outputText("None");
			outputText("\n<b>Stored weapon:</b> ");
			if (flags[kFLAGS.PRISON_STORAGE_WEAPON] != 0) {
				outputText("" + ItemType.lookupItem(flags[kFLAGS.PRISON_STORAGE_WEAPON]));
			}
			else outputText("None");
			outputText("\n<b>Stored shield:</b> ");
			if (flags[kFLAGS.PRISON_STORAGE_SHIELD] != 0) {
				outputText("" + ItemType.lookupItem(flags[kFLAGS.PRISON_STORAGE_SHIELD]));
			}
			else outputText("None");
			//Stored items
			outputText("\n\n<b><u>Stored items:</u></b>");
			for (var i:int = 0; i < 10; i++) {
				if (player.prisonItemSlots[i*2] != null && player.prisonItemSlots[i*2] != undefined) {
					outputText("\n" + player.prisonItemSlots[i*2]);
					outputText(" x" + player.prisonItemSlots[(i*2) +1]);
				}
			}
			output.flush();
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
			if (flags[kFLAGS.JOJO_STATUS] >= 5 || flags[kFLAGS.JOJO_DEAD_OR_GONE] > 0) addButton(1, "Jojo", resetJojo);
			if (flags[kFLAGS.EGG_BROKEN] > 0) addButton(2, "Ember", resetEmber);
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
		
		private function resetJojo():void {
			clearOutput();
			outputText("Did you do something wrong with Jojo? Corrupted him? Accidentally removed him from the game? No problem!");
			doYesNo(reallyResetJojo, resetNPCMenu);
		}
		private function reallyResetJojo():void {
			clearOutput();
			if (flags[kFLAGS.JOJO_STATUS] > 1) {
				outputText("Jojo is no longer corrupted!  ");
				flags[kFLAGS.JOJO_STATUS] = 0;
			}
			if (flags[kFLAGS.JOJO_DEAD_OR_GONE] > 0) {
				outputText("Jojo has respawned.  ");
				flags[kFLAGS.JOJO_DEAD_OR_GONE] = 0;
			}
			doNext(resetNPCMenu);
		}
		
		private function resetEmber():void {
			clearOutput();
			outputText("Did you destroy the egg containing Ember? Want to restore the egg so you can take it?");
			doYesNo(reallyResetEmber, resetNPCMenu);
		}
		private function reallyResetEmber():void {
			clearOutput();
			if (flags[kFLAGS.EGG_BROKEN] > 0) {
				outputText("Egg is now restored. Go find it in swamp! And try not to destroy it next time.  ");
				flags[kFLAGS.EGG_BROKEN] = 0;
			}
			doNext(resetNPCMenu);
		}
		
		private function abortPregnancy():void {
			clearOutput();
			outputText("You feel as if something's dissolving inside your womb. Liquid flows out of your [vagina] and your womb feels empty now. <b>You are no longer pregnant!</b>");
			player.knockUpForce();
			doNext(accessDebugMenu);
		}
		
		//[Flag Editor]
		private function flagEditor():void {
			clearOutput();
			menu();
			outputText("This is the Flag Editor.  You can edit flags from here.  For flags reference, look at kFLAGS.as class file.  Please input any number from 0 to 2999.");
			outputText("\n\n<b>WARNING: This might screw up your save file so backup your saves before using this!</b>");
			mainView.nameBox.visible = true;
			mainView.nameBox.width = 165;
			mainView.nameBox.text = "";
			mainView.nameBox.maxChars = 4;
			mainView.nameBox.restrict = "0-9";
			addButton(0, "OK", editFlag);
			addButton(4, "Done", accessDebugMenu);
			mainView.nameBox.x = mainView.mainText.x + 5;
			mainView.nameBox.y = mainView.mainText.y + 3 + mainView.mainText.textHeight;
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
