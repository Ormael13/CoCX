package classes.Scenes 
{
	import classes.*;
import classes.BodyParts.Skin;
import classes.BodyParts.SkinLayer;
	import classes.GlobalFlags.kFLAGS;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.MainViewManager;

import coc.view.Color;

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
			LogProfilingReport();
			//buildArray();
			if (!getGame().inCombat) {
				hideMenus();
				mainView.nameBox.visible = false;
				mainView.nameBox.text = "";
				mainView.nameBox.maxChars = 16;
				mainView.nameBox.restrict = null;
				mainView.nameBox.width = 140;
				clearOutput();
				outputText("Welcome to the super secret debug menu!");
				menu();
				addButton(0, "Spawn Items", itemSpawnMenu).hint("Spawn any items of your choice, including items usually not obtainable through gameplay.");
				addButton(1, "Change Stats", statChangeMenu).hint("Change your core stats.");
				addButton(2, "Flag Editor", flagEditor).hint("Edit any flag. \n\nCaution: This might screw up your save!");
				addButton(3, "Reset NPC", resetNPCMenu).hint("Choose a NPC to reset.");
				//addButton(5, "Event Trigger", eventTriggerMenu);
				//addButton(6, "MeaninglessCorr", toggleMeaninglessCorruption).hint("Toggles the Meaningless Corruption flag. If enabled, all corruption requirements are disabled for scenes.");
				if (player.isPregnant()) addButton(4, "Abort Preg", abortPregnancy);
				addButton(5, "DumpEffects", dumpEffectsMenu).hint("Display your status effects");
				addButton(7, "HACK STUFFZ", styleHackMenu).hint("H4X0RZ");
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
			transformativeArray.push(consumables.CENTARI);
			transformativeArray.push(consumables.DBLPEPP);
			transformativeArray.push(consumables.DRAKHRT);
			transformativeArray.push(consumables.DRYTENT);
			transformativeArray.push(consumables.ECTOPLS);
			transformativeArray.push(consumables.EQUINUM);
			//Page 2
			transformativeArray.push(consumables.FOXBERY);
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
			//Page 3
			transformativeArray.push(consumables.LARGEPP);
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
			//Page 4
			transformativeArray.push(consumables.PSDELIT);
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
			//Page 5
			transformativeArray.push(consumables.SNAKOIL);
			transformativeArray.push(consumables.SPHONEY);
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
			consumableArray.push(consumables.PEPPWHT);
			consumableArray.push(consumables.PPHILTR);
			consumableArray.push(consumables.PRNPKR);
			consumableArray.push(consumables.REDUCTO);
			consumableArray.push(consumables.SENSDRF);
			//Page 3
			consumableArray.push(consumables.SMART_T);
			consumableArray.push(consumables.VITAL_T);
			consumableArray.push(consumables.B__BOOK);
			consumableArray.push(consumables.W__BOOK);
			consumableArray.push(consumables.G__BOOK);
			consumableArray.push(consumables.BC_BEER);
			consumableArray.push(consumables.BHMTCUM);
			consumableArray.push(consumables.BIMBOCH);
			consumableArray.push(consumables.C_BREAD);
			consumableArray.push(consumables.CCUPCAK);
			consumableArray.push(consumables.FISHFIL);
			consumableArray.push(consumables.FR_BEER);
			//Page 4
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
			consumableArray.push(consumables.DRGNEGG);
			//Page 5
			consumableArray.push(consumables.W_PDDNG);
			consumableArray.push(consumables.TRAILMX);
			consumableArray.push(consumables.URTACUM);
			consumableArray.push(consumables.BLACKEG);
			consumableArray.push(consumables.L_BLKEG);
			consumableArray.push(consumables.BLUEEGG);
			consumableArray.push(consumables.L_BLUEG);
			consumableArray.push(consumables.BROWNEG);
			consumableArray.push(consumables.L_BRNEG);
			consumableArray.push(consumables.PINKEGG);
			consumableArray.push(consumables.L_PNKEG);
			consumableArray.push(consumables.PURPLEG);
			//Page 6
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
			weaponArray.push(weapons.BFSWORD);
			weaponArray.push(weapons.CLAYMOR);
			weaponArray.push(weapons.E_STAFF);
			weaponArray.push(weapons.FLAIL);
			weaponArray.push(weapons.URTAHLB);
			weaponArray.push(weapons.H_GAUNT);
			weaponArray.push(weapons.JRAPIER);
			weaponArray.push(weapons.KATANA);
			weaponArray.push(weapons.L__AXE);
			weaponArray.push(weapons.L_DAGGR);
			//Page 2
			weaponArray.push(weapons.L_HAMMR);
			weaponArray.push(weapons.L_STAFF);
			weaponArray.push(weapons.MACE);
			weaponArray.push(weapons.PIPE);
			weaponArray.push(weapons.PTCHFRK);			
			weaponArray.push(weapons.RIDINGC);
			weaponArray.push(weapons.RRAPIER);
			weaponArray.push(weapons.S_BLADE);
			weaponArray.push(weapons.S_GAUNT);			
			weaponArray.push(weapons.SCARBLD);
			weaponArray.push(weapons.SCIMITR);
			weaponArray.push(weapons.SPEAR);
			//Page 3
			weaponArray.push(weapons.SUCWHIP);
			weaponArray.push(weapons.W_STAFF);
			weaponArray.push(weapons.WARHAMR);
			weaponArray.push(weapons.WHIP);
			weaponArray.push(weaponsrange.BLUNDER);
			weaponArray.push(weaponsrange.BOWKELT);
			weaponArray.push(weaponsrange.BOWOLD_);
			weaponArray.push(weaponsrange.LCROSBW);
			weaponArray.push(weaponsrange.FLINTLK);
			
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
			armourArray.push(armors.LEATHRA);
			armourArray.push(armors.URTALTA);
			armourArray.push(armors.LMARMOR);
			armourArray.push(armors.LTHCARM);
			armourArray.push(armors.LTHRPNT);
			armourArray.push(armors.LTHRROB);
			armourArray.push(armors.M_ROBES);
			armourArray.push(armors.TBARMOR);
			//Page 3
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
			armourArray.push(armors.T_BSUIT);
			armourArray.push(armors.TUBETOP);
			//Page 4
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
			accessoryArray.push(jewelries.CRIMRNG);
			accessoryArray.push(jewelries.FERTRNG);
			accessoryArray.push(jewelries.ICE_RNG);
			accessoryArray.push(jewelries.LIFERNG);
			accessoryArray.push(jewelries.MYSTRNG);
			accessoryArray.push(jewelries.POWRRNG);
			accessoryArray.push(jewelries.PURERNG);
			accessoryArray.push(jewelries.DIAMRNG);
			accessoryArray.push(jewelries.GOLDRNG);
			accessoryArray.push(jewelries.LTHCRNG);
			accessoryArray.push(jewelries.PLATRNG);
			accessoryArray.push(jewelries.SILVRNG);
			setArrays = true;
		}
		

		
		private function statChangeMenu():void {
			clearOutput();
			outputText("Which attribute would you like to alter?");
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
			clearOutput();
			outputText("Increment or decrement by how much?");
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
			menu();
			clearOutput();
			outputText("TEST STUFFZ");
			addButton(0, "ASPLODE", styleHackMenu);
			addButton(1, "Scorpion Tail", changeScorpionTail);
			addButton(2, "Be Manticore", getManticoreKit).hint("Gain everything needed to become a Manticore-morph.");
			addButton(3, "Be Dragonne", getDragonneKit).hint("Gain everything needed to become a Dragonne-morph.");
			addButton(4, "Debug Prison", debugPrison);
			addButton(5, "Tooltips Ahoy", kGAMECLASS.doNothing).hint("Ahoy! I'm a tooltip! I will show up a lot in future updates!", "Tooltip 2.0");
			addButton(6, "Lights Out", startLightsOut, testVictoryFunc, testFailureFunc, null, "Test the lights out puzzle, fresh off TiTS!");
			addButton(7, "Isabella Birth", kGAMECLASS.isabellaFollowerScene.isabellaGivesBirth).hint("Test Isabella giving birth for debugging purposes.", "Trigger Isabella Giving Birth");
			addButton(8, "BodyPartEditor", bodyPartEditorRoot).hint("Inspect and fine-tune the player body parts");
			addButton(9, "Color Picker", colorPickerRoot).hint("HSL picker for skin/hair color");
			addButton(14, "Back", accessDebugMenu);
		}
		private function generateTagDemos(...tags:Array):String {
			return tags.map(function(tag:String,index:int,array:Array):String {
				return "\\["+tag+"\\] = " +
					   getGame().parser.recursiveParser("["+tag+"]").replace(' ','\xA0')
			}).join(",\t");
		}
		private function showChangeOptions(backFn:Function, page:int, constants:Array, functionPageIndex:Function):void {
			var N:int = 12;
			for (var i:int = N * page; i < constants.length && i < (page + 1) * N; i++) {
				var e:* = constants[i];
				if (!(e is Array)) e = [i,e];
				addButton(i % N, e[1], curry(functionPageIndex, page, e[0]));
			}
			if (page > 0) addButton(12, "PrevPage", curry(functionPageIndex, page - 1));
			if ((page +1)*N < constants.length) addButton(13, "NextPage", curry(functionPageIndex, page + 1));
			addButton(14, "Back", backFn);
		}
		private var oldColor:String = "";
		private var pickerMode:String = "skin";
		private function colorPickerRoot():void {
			clearOutput();
			mainViewManager.showPlayerDoll(false);
			var c:String = pickerMode=='skin'?player.skin.base.color:player.hairColor;
			var hsl:Object;
			var h:int,s:int,l:int;
			if (c.charAt(0) != '$') {
				oldColor = c;
				hsl = Color.toHsl(mainView.charView.lookupColorValue(pickerMode, c));
				c        = '$hsl('+int(hsl.h)+','+int(hsl.s)+','+int(hsl.l)+')';
				if (pickerMode == 'skin') player.skin.base.color = c;
				else if (pickerMode == 'hair') player.hairColor = c;
				h = hsl.h;
				s = hsl.s;
				l = hsl.l;
			} else {
				var m:/*String*/Array = c.match(/^\$hsl\((\d+),(\d+),(\d+)\)$/);
				if (!m) styleHackMenu();
				h=int(m[1]);
				s=int(m[2]);
				l=int(m[3]);
			}
			displayHeader("Color picker");
			outputText('\nCurrent color:');
			outputText("\n<b>H</b>ue:\t\t\t"+h+' / 360\t<i>(0: red, 120: green, 240: blue)');
			outputText("\n<b>S</b>aturation:\t\t"+s+' / 100\t(0: greyscale, 100: bright color)');
			outputText("\n<b>L</b>uminosity:\t"+l+' / 100\t(0: black, 50: bright color, 100: white)');
			outputText('\n\nCurrent mode: <b>'+pickerMode+' color</b>.');
			var palette:/*String*/Array = [];
			var maps:Object = mainView.charView.palette.lookupObjects;
			for (var mapname:String in maps) {
				var map:Object = maps[mapname];
				var suffix:String = mapname == 'common' ? '' : (' ('+mapname+')');
				for (var colorname:String in map) {
					hsl = Color.toHsl(Color.convertColor(map[colorname]));
					palette.push({
						label:colorname+suffix+' ('+int(hsl.h)+', '+int(hsl.s)+', '+int(hsl.l)+')',
						data:{name:colorname,h:hsl.h,s:hsl.s,l:hsl.l}});
				}
			}
			palette.sortOn('label');

			kGAMECLASS.showComboBox(palette,"Known colors",function(item:Object):void {
				oldColor = item.data.name;
				colorPickerSet(item.data.h,item.data.s,item.data.l);
			});
			outputText('<b>Missing colors:</b>');
			outputText('\n<i>' +
					   [
						   'ashen', 'caramel', 'cerulean', 'chocolate', 'crimson', 'crystal', 'dusky',
						   'emerald', 'golden', 'indigo', 'metallic', 'midnight', 'peach', 'sable',
						   'sanguine', 'silky', 'silver', 'tan', 'tawny', 'turquoise', 'aphotic blue-black',
						   'ashen grayish-blue', 'creamy-white', 'crimson platinum', 'dark blue',
						   'dark gray', 'dark green', 'deep blue', 'deep red', 'ghostly pale',
						   'glacial white', 'golden blonde', 'grayish-blue', 'light blonde', 'light blue',
						   'light gray', 'light green', 'light grey', 'light purple', 'lime green',
						   'mediterranean-toned', 'metallic golden', 'metallic silver', 'midnight black',
						   'pale white', 'pale yellow', 'platinum blonde', 'platinum crimson',
						   'purplish-black', 'quartz white', 'reddish-orange', 'rough gray', 'sandy brown',
						   'shiny black', 'silver blonde', 'silver-white', 'snow white', 'yellowish-green'
					   ].join('</i>, <i>') + '</i>.');
			outputText('\n\n<b>Not verified:</b>');
			outputText('\n<i>' +
					   [
						   'albino', 'aqua', 'auburn', 'black', 'blonde', 'blue', 'bronzed', 'brown',
						   'dark', 'ebony', 'fair', 'gray', 'green', 'light', 'mahogany', 'olive',
						   'orange', 'pink', 'purple', 'red', 'russet', 'white', 'yellow',
						   'iridescent gray', 'leaf green', 'milky white', 'sandy blonde', 'red(hair)',
						   'flaxen(hair)', 'brown(hair)', 'black(hair)', 'gray(hair)', 'white(hair)',
						   'raven(hair)', 'snowy(hair)', 'pale(skin)'
					   ].join('</i>, <i>') + '</i>.');
			menu();
			addButton(0,"Back",colorPickerExit);
			addButton(5,"Skin",colorPickerSetMode,'skin');
			button(5).enabled = pickerMode != 'skin';
			addButton(10,"Hair",colorPickerSetMode,'hair');
			button(10).enabled = pickerMode != 'hair';

			addButton(1,"Sub 20 Hue",colorPickerSet,(h+360-20)%360,s,l);
			addButton(2,"Sub 1 Hue",colorPickerSet,(h+360-1)%360,s,l);
			addButton(3,"Add 1 Hue",colorPickerSet,(h+1)%360,s,l);
			addButton(4,"Add 20 Hue",colorPickerSet,(h+20)%360,s,l);
			addButton(6,"Sub 10 Sat",colorPickerSet,h,boundInt(0,s-10,100),l);
			addButton(7,"Sub 1 Sat",colorPickerSet,h,boundInt(0,s-1,100),l);
			addButton(8,"Add 1 Sat",colorPickerSet,h,boundInt(0,s+1,100),l);
			addButton(9,"Add 10 Sat",colorPickerSet,h,boundInt(0,s+10,100),l);
			addButton(11,"Sub 10 Lum ",colorPickerSet,h,s,boundInt(0,l-10,100));
			addButton(12,"Sub 1 Lum ",colorPickerSet,h,s,boundInt(0,l-1,100));
			addButton(13,"Add 1 Lum",colorPickerSet,h,s,boundInt(0,l+1,100));
			addButton(14,"Add 10 Lum",colorPickerSet,h,s,boundInt(0,l+10,100));
		}
		private function colorPickerSetMode(mode:String):void {
			if (pickerMode == 'skin') player.skin.base.color = oldColor;
			else if (pickerMode == 'hair') player.hairColor = oldColor;
			pickerMode = mode;
			colorPickerRoot();
		}
		private function colorPickerSet(h:int,s:int,l:int):void {
			var color:String = '$hsl(' + (h + 360) % 360 + ',' + s + ',' + l + ')';
			if (pickerMode == 'skin') player.skin.base.color = color;
			else if (pickerMode == 'hair') player.hairColor = color;
			colorPickerRoot();
		}
		private function colorPickerExit():void {
			if (pickerMode == 'skin') player.skin.base.color = oldColor;
			else if (pickerMode == 'hair') player.hairColor = oldColor;
			styleHackMenu();
		}
		private function dumpPlayerData():void {
			clearOutput();
			mainViewManager.showPlayerDoll(true);
			var pa:PlayerAppearance = getGame().playerAppearance;
			pa.describeRace();
			pa.describeFaceShape();
			outputText("  It has " + player.faceDesc() + "."); //M/F stuff!
			pa.describeEyes();
			pa.describeHairAndEars();
			pa.describeBeard();
			pa.describeTongue();
			pa.describeHorns();
			outputText("[pg]");
			pa.describeBodyShape();
			pa.describeWings();
			pa.describeRearBody();
			pa.describeArms();
			pa.describeLowerBody();
			outputText("[pg]");
	/*		outputText("player.skin = " + JSON.stringify(player.skin.saveToObject())
											  .replace(/":"/g,'":&nbsp; "')
											  .replace(/,"/g, ', "') + "\n");
			outputText("player.facePart = " + JSON.stringify(player.facePart.saveToObject()).replace(/,/g, ", ") + "\n");
	*/	}
		private function bodyPartEditorRoot():void {
			menu();
			dumpPlayerData();
			addButton(0,"Head",bodyPartEditorHead);
			addButton(1,"Skin & Hair",bodyPartEditorSkin);
			addButton(2,"Torso & Limbs",bodyPartEditorTorso);
//			addButton(3,"",bodyPartEditorValues);
//			addButton(4,"",bodyPartEditorCocks);
//			addButton(5,"",bodyPartEditorVaginas);
//			addButton(6,"",bodyPartEditorBreasts);
//			addButton(7,"",bodyPartEditorPiercings);
//			addButton(,"",change);
//			addButton(13, "Page2", bodyPartEditor2);
			addButton(14, "Back", accessDebugMenu);
		}
		private var bpeSkinLayer:String = "Base";
		private function bodyPartEditorSkin():void {
			var editBase:Boolean = bpeSkinLayer == "Base";
			menu();
			dumpPlayerData();
			tagDemosSkin();
			addButton(0,"Skin Coverage",changeSkinCoverage);
			addButton(1,bpeSkinLayer+ " Type",curry(changeLayerType,editBase));
			addButton(2,bpeSkinLayer+ " Color",curry(changeLayerColor,editBase));
			addButton(3,bpeSkinLayer+ " Adj",curry(changeLayerAdj,editBase));
			addButton(4,bpeSkinLayer+ " Desc",curry(changeLayerDesc,editBase));
			if (editBase) {
				addButton(5, "Select Coat",changeCurrentLayer).disableIf(player.skin.coverage == Skin.COVERAGE_NONE);
			} else {
				addButton(5, "Select Base",changeCurrentLayer);
			}
			addButton(6,bpeSkinLayer+" Color2",curry(changeLayerColor2,editBase));
			addButton(7,bpeSkinLayer+" Pattern",curry(changeLayerPattern,editBase));
			addButton(10,"HairType",changeHairType);
			addButton(11,"HairColor",changeHairColor);
			addButton(12,"HairLength",changeHairLength);
//			addButton(12,"HairStyle",);
			addButton(14, "Back", bodyPartEditorRoot);
		}
		private static const SKIN_BASE_TYPES:Array = [
			[SKIN_BASE_PLAIN,"(0) PLAIN"],
			[SKIN_BASE_GOO,"(3) GOO"],
			[SKIN_BASE_STONE,"(7) STONE"]
		];
		private static const SKIN_COAT_TYPES:Array = [
			[SKIN_COAT_FUR,"(1) FUR"],
			[SKIN_COAT_SCALES,"(2) SCALES"],
			[SKIN_COAT_CHITIN,"(5) CHITIN"],
			[SKIN_COAT_BARK,"(6) BARK"],
			[SKIN_COAT_STONE,"(7) STONE"],
			[SKIN_COAT_AQUA_SCALES,"(9) AQUA_SCALES"],
			[SKIN_COAT_DRAGON_SCALES,"(10) DRAGON_SCALES"],
			[SKIN_COAT_MOSS,"(11) MOSS"]
		];
		private static const PATTERN_BASE_TYPES:Array = [
			[PATTERN_NONE,"(0) NONE"],
			[PATTERN_MAGICAL_TATTOO,"(1) MAGICAL_TATTOO"],
			[PATTERN_ORCA_UNDERBODY,"(2) ORCA_UNDERBODY"],
			[PATTERN_BATTLE_TATTOO,"(5) BATTLE_TATTOO"],
		];
		private static const PATTERN_COAT_TYPES:Array = [
			[PATTERN_NONE,"(0) NONE"],
			[PATTERN_BEE_STRIPES,"(3) BEE_STRIPES"],
			[PATTERN_TIGER_STRIPES,"(4) TIGER_STRIPES"],
		];
		private static const SKIN_TONE_CONSTANTS:Array = [
			"pale", "light", "dark", "green", "gray",
			"blue", "black", "white", "red", "yellow",
			"dark blue", "pink",
		];
		private static const SKIN_ADJ_CONSTANTS:Array = [
			"(none)", "tough", "smooth", "rough", "sexy",
			"freckled", "glistering", "shiny", "slimy","goopey",
			"latex", "rubber"
		];
		private static const SKIN_DESC_CONSTANTS:Array = [
			"(default)", "covering", "feathers", "hide",
			"shell", "plastic", "skin", "fur",
			"scales", "bark", "stone", "chitin"
		];
		private static const SKIN_COVERAGE_CONSTANTS:Array = [
				[Skin.COVERAGE_NONE, "NONE (0)"],
				[Skin.COVERAGE_LOW, "LOW (1, partial)"],
				[Skin.COVERAGE_MEDIUM, "MEDIUM (2, mixed)"],
				[Skin.COVERAGE_HIGH, "HIGH (3, full)"],
				[Skin.COVERAGE_COMPLETE, "COMPLETE (4, full+face)"]
		];
		private static const HAIR_TYPE_CONSTANTS:Array = [
			[HAIR_NORMAL,"(0) NORMAL"],
			[HAIR_FEATHER,"(1) FEATHER"],
			[HAIR_GHOST,"(2) GHOST"],
			[HAIR_GOO,"(3) GOO"],
			[HAIR_ANEMONE,"(4) ANEMONE"],
			[HAIR_QUILL,"(5) QUILL"],
			[HAIR_GORGON,"(6) GORGON"],
			[HAIR_LEAF,"(7) LEAF"],
			[HAIR_FLUFFY,"(8) FLUFFY"],
			[HAIR_GRASS,"(9) GRASS"],
		];
		private static const HAIR_COLOR_CONSTANTS:Array = [
			"blond", "brown", "black", "red", "white",
			"silver blonde","sandy-blonde", "platinum blonde", "midnight black", "golden blonde",
			"rainbow", "seven-colored",
		];
		private static const HAIR_LENGTH_CONSTANTS:Array = [
			0,0.5,1,2,4,
			8,12,24,32,40,
			64,72
		];
		private function tagDemosSkin():void {
			outputText("[pg]");
			outputText(generateTagDemos(
							"skin", "skin base", "skin coat", "skin full",
							"skin noadj", "skin base.noadj", "skin coat.noadj", "skin full.noadj",
							"skin notone", "skin base.notone", "skin coat.notone", "skin full.notone",
							"skin type", "skin base.type", "skin coat.type", "skin full.type",
							"skin color", "skin base.color", "skin coat.color",
							"skin isare", "skin base.isare", "skin coat.isare",
							"skin vs","skin base.vs", "skin coat.vs",
							"skinfurscales", "skintone") + ".\n");
		}
		private function changeCurrentLayer():void {
			bpeSkinLayer = bpeSkinLayer == "Base" ? "Coat" : "Base";
			bodyPartEditorSkin();
		}
		private function changeLayerType(page:int=0,setIdx:int=-1):void {
			var editBase:Boolean = bpeSkinLayer == "Base";
			if (setIdx>=0) (editBase?player.skin.base:player.skin.coat).type = setIdx;
			menu();
			dumpPlayerData();
			tagDemosSkin();
			showChangeOptions(bodyPartEditorSkin, page, editBase?SKIN_BASE_TYPES:SKIN_COAT_TYPES, changeLayerType);
		}
		private function changeLayerPattern(page:int=0,setIdx:int=-1):void {
			var editBase:Boolean = bpeSkinLayer == "Base";
			if (setIdx>=0) (editBase?player.skin.base:player.skin.coat).pattern = setIdx;
			menu();
			dumpPlayerData();
			tagDemosSkin();
			showChangeOptions(bodyPartEditorSkin, page, editBase?PATTERN_BASE_TYPES:PATTERN_COAT_TYPES, changeLayerPattern);
		}
		private function changeLayerColor(editBase:Boolean,page:int=0,setIdx:int=-1):void {
			if (setIdx>=0) (editBase?player.skin.base:player.skin.coat).color = SKIN_TONE_CONSTANTS[setIdx];
			menu();
			dumpPlayerData();
			tagDemosSkin();
			showChangeOptions(bodyPartEditorSkin, page, SKIN_TONE_CONSTANTS, curry(changeLayerColor,editBase));
		}
		private function changeLayerColor2(editBase:Boolean,page:int=0,setIdx:int=-1):void {
			if (setIdx>=0) (editBase?player.skin.base:player.skin.coat).color2 = SKIN_TONE_CONSTANTS[setIdx];
			menu();
			dumpPlayerData();
			tagDemosSkin();
			showChangeOptions(bodyPartEditorSkin, page, SKIN_TONE_CONSTANTS, curry(changeLayerColor2,editBase));
		}
		private function changeLayerAdj(editBase:Boolean,page:int=0,setIdx:int=-1):void {
			var tgt:SkinLayer = (editBase?player.skin.base:player.skin.coat);
			if (setIdx==0) tgt.adj = "";
			if (setIdx>0) tgt.adj = SKIN_ADJ_CONSTANTS[setIdx];
			menu();
			dumpPlayerData();
			tagDemosSkin();
			showChangeOptions(bodyPartEditorSkin, page, SKIN_ADJ_CONSTANTS, curry(changeLayerAdj,editBase));
		}
		private function changeLayerDesc(editBase:Boolean,page:int=0,setIdx:int=-1):void {
			var tgt:SkinLayer = (editBase?player.skin.base:player.skin.coat);
			if (setIdx==0) tgt.desc = "";
			if (setIdx>0) tgt.desc = SKIN_DESC_CONSTANTS[setIdx];
			menu();
			dumpPlayerData();
			tagDemosSkin();
			showChangeOptions(bodyPartEditorSkin, page, SKIN_DESC_CONSTANTS, curry(changeLayerDesc,editBase));
		}
		private function changeSkinCoverage(page:int=0,setIdx:int=-1):void {
			if (setIdx>=0) player.skin.coverage = setIdx;
			menu();
			dumpPlayerData();
			tagDemosSkin();
			showChangeOptions(bodyPartEditorSkin, page, SKIN_COVERAGE_CONSTANTS, changeSkinCoverage);
		}
		private function changeHairType(page:int=0,setIdx:int=-1):void {
			if (setIdx>=0) player.hairType = setIdx;
			menu();
			dumpPlayerData();
			showChangeOptions(bodyPartEditorSkin, page, HAIR_TYPE_CONSTANTS, changeHairType);
		}
		private function changeHairColor(page:int=0,setIdx:int=-1):void {
			if (setIdx>=0) player.hairColor = HAIR_COLOR_CONSTANTS[setIdx];
			menu();
			dumpPlayerData();
			showChangeOptions(bodyPartEditorSkin, page, HAIR_COLOR_CONSTANTS, changeHairColor);
		}
		private function changeHairLength(page:int=0,setIdx:int=-1):void {
			if (setIdx>=0) player.hairLength = HAIR_LENGTH_CONSTANTS[setIdx];
			menu();
			dumpPlayerData();
			showChangeOptions(bodyPartEditorSkin, page, HAIR_LENGTH_CONSTANTS, changeHairLength);
		}
		private function bodyPartEditorHead():void {
			menu();
			dumpPlayerData();
			addButton(0,"FaceType",changeFaceType);
			addButton(1,"TongueType",changeTongueType);
			addButton(2,"EyeType",changeEyeType);
			addButton(3,"EarType",changeEarType);
			addButton(4,"AntennaeType",changeAntennaeType);
			addButton(5,"HornType",changeHornType);
			addButton(6,"HornCount",changeHornCount);
			addButton(7,"GillType",changeGillType);
			addButton(8,"BeardStyle",changeBeardStyle);
			addButton(9,"BeardLength",changeBeardLength);
			/*addButton(,"FaceDecoType",changeFaceDecoType);
			addButton(,"FaceDecoAdj",changeFaceDecoAdj);*/
			addButton(14, "Back", bodyPartEditorRoot);
		}
		private static const FACE_TYPE_CONSTANTS:Array = [
			[FACE_HUMAN,"(0) HUMAN"],
			[FACE_HORSE,"(1) HORSE"],
			[FACE_DOG,"(2) DOG"],
			[FACE_COW_MINOTAUR,"(3) COW_MINOTAUR"],
			[FACE_SHARK_TEETH,"(4) SHARK_TEETH"],
			[FACE_SNAKE_FANGS,"(5) SNAKE_FANGS"],
			[FACE_CAT,"(6) CAT"],
			[FACE_LIZARD,"(7) LIZARD"],
			[FACE_BUNNY,"(8) BUNNY"],
			[FACE_KANGAROO,"(9) KANGAROO"],
			[FACE_SPIDER_FANGS,"(10) SPIDER_FANGS"],
			[FACE_FOX,"(11) FOX"],
			[FACE_DRAGON,"(12) DRAGON"],
			[FACE_RACCOON_MASK,"(13) RACCOON_MASK"],
			[FACE_RACCOON,"(14) RACCOON"],
			[FACE_BUCKTEETH,"(15) BUCKTEETH"],
			[FACE_MOUSE,"(16) MOUSE"],
			[FACE_FERRET_MASK,"(17) FERRET_MASK"],
			[FACE_FERRET,"(18) FERRET"],
			[FACE_PIG,"(19) PIG"],
			[FACE_BOAR,"(20) BOAR"],
			[FACE_RHINO,"(21) RHINO"],
			[FACE_ECHIDNA,"(22) ECHIDNA"],
			[FACE_DEER,"(23) DEER"],
			[FACE_WOLF,"(24) WOLF"],
			[FACE_MANTICORE,"(25) MANTICORE"],
			[FACE_SALAMANDER_FANGS,"(26) SALAMANDER_FANGS"],
			[FACE_YETI_FANGS,"(27) YETI_FANGS"],
			[FACE_ORCA,"(28) ORCA"],
			[FACE_PLANT_DRAGON,"(29) PLANT_DRAGON"],
			[FACE_DRAGON_FANGS,"(30) DRAGON_FANGS"],
			[FACE_DEVIL_FANGS,"(31) DEVIL_FANGS"],
		];
		private static const TONGUE_TYPE_CONSTANTS:Array = [
			[TONGUE_HUMAN, "(0) HUMAN"],
			[TONGUE_SNAKE, "(1) SNAKE"],
			[TONGUE_DEMONIC, "(2) DEMONIC"],
			[TONGUE_DRACONIC, "(3) DRACONIC"],
			[TONGUE_ECHIDNA, "(4) ECHIDNA"],
			[TONGUE_CAT, "(5) CAT"],
		];
		private static const EYE_TYPE_CONSTANTS:Array = [
			[EYES_HUMAN, "(0) HUMAN"],
			[EYES_FOUR_SPIDER_EYES, "(1) FOUR_SPIDER_EYES"],
			[EYES_BLACK_EYES_SAND_TRAP, "(2) BLACK_EYES_SAND_TRAP"],
			[EYES_CAT_SLITS, "(3) CAT_SLITS"],
			[EYES_GORGON, "(4) GORGON"],
			[EYES_FENRIR, "(5) FENRIR"],
			[EYES_MANTICORE, "(6) MANTICORE"],
			[EYES_FOX, "(7) FOX"],
			[EYES_REPTILIAN, "(8) REPTILIAN"],
			[EYES_SNAKE, "(9) SNAKE"],
			[EYES_DRAGON, "(10) DRAGON"],
			[EYES_DEVIL, "(11) DEVIL"],
		];
		private static const EAR_TYPE_CONSTANTS:Array    = [
			[EARS_HUMAN, "(0) HUMAN"],
			[EARS_HORSE, "(1) HORSE"],
			[EARS_DOG, "(2) DOG"],
			[EARS_COW, "(3) COW"],
			[EARS_ELFIN, "(4) ELFIN"],
			[EARS_CAT, "(5) CAT"],
			[EARS_LIZARD, "(6) LIZARD"],
			[EARS_BUNNY, "(7) BUNNY"],
			[EARS_KANGAROO, "(8) KANGAROO"],
			[EARS_FOX, "(9) FOX"],
			[EARS_DRAGON, "(10) DRAGON"],
			[EARS_RACCOON, "(11) RACCOON"],
			[EARS_MOUSE, "(12) MOUSE"],
			[EARS_FERRET, "(13) FERRET"],
			[EARS_PIG, "(14) PIG"],
			[EARS_RHINO, "(15) RHINO"],
			[EARS_ECHIDNA, "(16) ECHIDNA"],
			[EARS_DEER, "(17) DEER"],
			[EARS_WOLF, "(18) WOLF"],
			[EARS_LION, "(19) LION"],
			[EARS_YETI, "(20) YETI"],
			[EARS_ORCA, "(21) ORCA"],
			[EARS_SNAKE, "(22) SNAKE"],
			[EARS_GOAT, "(23) GOAT"],
		];
		private static const HORN_TYPE_CONSTANTS:Array    = [
			[HORNS_NONE, "(0) NONE"],
			[HORNS_DEMON, "(1) DEMON"],
			[HORNS_COW_MINOTAUR, "(2) COW_MINOTAUR"],
			[HORNS_DRACONIC_X2, "(3) DRACONIC_X2"],
			[HORNS_DRACONIC_X4_12_INCH_LONG, "(4) DRACONIC_X4_12_INCH_LONG"],
			[HORNS_ANTLERS, "(5) ANTLERS"],
			[HORNS_GOAT, "(6) GOAT"],
			[HORNS_UNICORN, "(7) UNICORN"],
			[HORNS_RHINO, "(8) RHINO"],
			[HORNS_OAK, "(9) OAK"],
			[HORNS_GARGOYLE, "(10) GARGOYLE"],
			[HORNS_ORCHID, "(11) ORCHID"],
		];
		private static const HORN_COUNT_CONSTANTS:Array = [
				0,1,2,3,4,
				5,6,8,10,12,
				16,20
		];
		private static const ANTENNA_TYPE_CONSTANTS:Array = [
			[ANTENNAE_NONE, "(0) NONE"],
			[ANTENNAE_MANTIS, "(1) MANTIS"],
			[ANTENNAE_BEE, "(2) BEE"],
		];
		private static const GILLS_TYPE_CONSTANTS:Array   = [
			[GILLS_NONE, "(0) NONE"],
			[GILLS_ANEMONE, "(1) ANEMONE"],
			[GILLS_FISH, "(2) FISH"],
			[GILLS_IN_TENTACLE_LEGS, "(3) IN_TENTACLE_LEGS"],
		];
		private static const BEARD_STYLE_CONSTANTS:Array = [
			[BEARD_NORMAL,"(0) NORMAL"],
			[BEARD_GOATEE,"(1) GOATEE"],
			[BEARD_CLEANCUT,"(2) CLEANCUT"],
			[BEARD_MOUNTAINMAN,"(3) MOUNTAINMAN"],
		];
		private static const BEARD_LENGTH_CONSTANTS:Array = [
			0,0.1,0.3,2,4,
			8,12,16,32,64,
		];
		private function changeFaceType(page:int=0,setIdx:int=-1):void {
			if (setIdx>=0) player.facePart.type = setIdx;
			menu();
			dumpPlayerData();
			showChangeOptions(bodyPartEditorHead, page, FACE_TYPE_CONSTANTS, changeFaceType);
		}
		private function changeTongueType(page:int=0,setIdx:int=-1):void {
			if (setIdx>=0) player.tongueType = setIdx;
			menu();
			dumpPlayerData();
			showChangeOptions(bodyPartEditorHead, page, TONGUE_TYPE_CONSTANTS, changeTongueType);
		}
		private function changeEyeType(page:int=0,setIdx:int=-1):void {
			if (setIdx>=0) player.eyeType = setIdx;
			menu();
			dumpPlayerData();
			showChangeOptions(bodyPartEditorHead, page, EYE_TYPE_CONSTANTS, changeEyeType);
		}
		private function changeEarType(page:int=0,setIdx:int=-1):void {
			if (setIdx>=0) player.earType = setIdx;
			menu();
			dumpPlayerData();
			showChangeOptions(bodyPartEditorHead, page, EAR_TYPE_CONSTANTS, changeEarType);
		}
		private function changeHornType(page:int=0,setIdx:int=-1):void {
			if (setIdx>=0) player.hornType = setIdx;
			menu();
			dumpPlayerData();
			showChangeOptions(bodyPartEditorHead, page, HORN_TYPE_CONSTANTS, changeHornType);
		}
		private function changeHornCount(page:int=0,setIdx:int=-1):void {
			if (setIdx>=0) player.horns = HORN_COUNT_CONSTANTS[setIdx];
			menu();
			dumpPlayerData();
			tagDemosSkin();
			showChangeOptions(bodyPartEditorHead, page, HORN_COUNT_CONSTANTS, changeHornCount);
		}
		private function changeAntennaeType(page:int=0,setIdx:int=-1):void {
			if (setIdx>=0) player.antennae = setIdx;
			menu();
			dumpPlayerData();
			showChangeOptions(bodyPartEditorHead, page, ANTENNA_TYPE_CONSTANTS, changeAntennaeType);
		}
		private function changeGillType(page:int=0,setIdx:int=-1):void {
			if (setIdx>=0) player.gillType = setIdx;
			menu();
			dumpPlayerData();
			showChangeOptions(bodyPartEditorHead, page, GILLS_TYPE_CONSTANTS, changeGillType);
		}
		private function changeBeardStyle(page:int=0,setIdx:int=-1):void {
			if (setIdx>=0) player.beardStyle = setIdx;
			menu();
			dumpPlayerData();
			showChangeOptions(bodyPartEditorHead, page, BEARD_STYLE_CONSTANTS, changeBeardStyle);
		}
		private function changeBeardLength(page:int=0,setIdx:int=-1):void {
			if (setIdx>=0) player.beardLength = BEARD_LENGTH_CONSTANTS[setIdx];
			menu();
			dumpPlayerData();
			tagDemosSkin();
			showChangeOptions(bodyPartEditorHead, page, BEARD_LENGTH_CONSTANTS, changeBeardLength);
		}
		private function bodyPartEditorTorso():void {
			menu();
			dumpPlayerData();
			addButton(0,"ArmType",changeArmType);
			addButton(1,"ClawType",changeClawType);
			addButton(2,"ClawTone",changeClawTone);
			addButton(3,"TailType",changeTailType);
			addButton(4,"TailCount",changeTailCount);
			addButton(5,"WingType",changeWingType);
			addButton(6,"WingDesc",changeWingDesc);
			addButton(7,"LowerBodyType",changeLowerBodyType);
			addButton(8,"LegCount",changeLegCount);
			addButton(9,"ReadBodyType",changeRearBodyType);
			addButton(14, "Back", bodyPartEditorRoot);
		}
		private static const ARM_TYPE_CONSTANTS:Array   = [
			[ARM_TYPE_HUMAN, "(0) HUMAN"],
			[ARM_TYPE_HARPY, "(1) HARPY"],
			[ARM_TYPE_SPIDER, "(2) SPIDER"],
			[ARM_TYPE_MANTIS, "(3) MANTIS"],
			[ARM_TYPE_BEE, "(4) BEE"],
			[ARM_TYPE_SALAMANDER, "(5) SALAMANDER"],
			[ARM_TYPE_PHOENIX, "(6) PHOENIX"],
			[ARM_TYPE_PLANT, "(7) PLANT"],
			[ARM_TYPE_SHARK, "(8) SHARK"],
			[ARM_TYPE_GARGOYLE, "(9) GARGOYLE"],
			[ARM_TYPE_WOLF, "(10) WOLF"],
			[ARM_TYPE_LION, "(11) LION"],
			[ARM_TYPE_KITSUNE, "(12) KITSUNE"],
			[ARM_TYPE_FOX, "(13) FOX"],
			[ARM_TYPE_LIZARD, "(14) LIZARD"],
			[ARM_TYPE_DRAGON, "(15) DRAGON"],
			[ARM_TYPE_YETI, "(16) YETI"],
			[ARM_TYPE_ORCA, "(17) ORCA"],
			[ARM_TYPE_PLANT2, "(18) PLANT2"],
			[ARM_TYPE_DEVIL, "(19) DEVIL"],
		];
		private static const CLAW_TYPE_CONSTANTS:Array = [
			[CLAW_TYPE_NORMAL,"(0) NORMAL"],
			[CLAW_TYPE_LIZARD,"(1) LIZARD"],
			[CLAW_TYPE_DRAGON,"(2) DRAGON"],
			[CLAW_TYPE_SALAMANDER,"(3) SALAMANDER"],
			[CLAW_TYPE_CAT,"(4) CAT"],
			[CLAW_TYPE_DOG,"(5) DOG"],
			[CLAW_TYPE_RAPTOR,"(6) RAPTOR"],
			[CLAW_TYPE_MANTIS,"(7) MANTIS"],
		];
		private static const TAIL_TYPE_CONSTANTS:Array  = [
			[TAIL_TYPE_NONE, "(0) NONE"],
			[TAIL_TYPE_HORSE, "(1) HORSE"],
			[TAIL_TYPE_DOG, "(2) DOG"],
			[TAIL_TYPE_DEMONIC, "(3) DEMONIC"],
			[TAIL_TYPE_COW, "(4) COW"],
			[TAIL_TYPE_SPIDER_ADBOMEN, "(5) SPIDER_ADBOMEN"],
			[TAIL_TYPE_BEE_ABDOMEN, "(6) BEE_ABDOMEN"],
			[TAIL_TYPE_SHARK, "(7) SHARK"],
			[TAIL_TYPE_CAT, "(8) CAT"],
			[TAIL_TYPE_LIZARD, "(9) LIZARD"],
			[TAIL_TYPE_RABBIT, "(10) RABBIT"],
			[TAIL_TYPE_HARPY, "(11) HARPY"],
			[TAIL_TYPE_KANGAROO, "(12) KANGAROO"],
			[TAIL_TYPE_FOX, "(13) FOX"],
			[TAIL_TYPE_DRACONIC, "(14) DRACONIC"],
			[TAIL_TYPE_RACCOON, "(15) RACCOON"],
			[TAIL_TYPE_MOUSE, "(16) MOUSE"],
			[TAIL_TYPE_FERRET, "(17) FERRET"],
			[TAIL_TYPE_BEHEMOTH, "(18) BEHEMOTH"],
			[TAIL_TYPE_PIG, "(19) PIG"],
			[TAIL_TYPE_SCORPION, "(20) SCORPION"],
			[TAIL_TYPE_GOAT, "(21) GOAT"],
			[TAIL_TYPE_RHINO, "(22) RHINO"],
			[TAIL_TYPE_ECHIDNA, "(23) ECHIDNA"],
			[TAIL_TYPE_DEER, "(24) DEER"],
			[TAIL_TYPE_SALAMANDER, "(25) SALAMANDER"],
			[TAIL_TYPE_KITSHOO, "(26) KITSHOO"],
			[TAIL_TYPE_MANTIS_ABDOMEN, "(27) MANTIS_ABDOMEN"],
			[TAIL_TYPE_MANTICORE_PUSSYTAIL, "(28) MANTICORE_PUSSYTAIL"],
			[TAIL_TYPE_WOLF, "(29) WOLF"],
			[TAIL_TYPE_GARGOYLE, "(30) GARGOYLE"],
			[TAIL_TYPE_ORCA, "(31) ORCA"],
			[TAIL_TYPE_YGGDRASIL, "(32) YGGDRASIL"],
		];
		private static const TAIL_COUNT_CONSTANTS:Array = [
			[0,"0"],1,2,3,4,
			5,6,7,8,9,
			10,16
		];
		private static const WING_TYPE_CONSTANTS:Array  = [
			[WING_TYPE_NONE, "(0) NONE"],
			[WING_TYPE_BEE_LIKE_SMALL, "(1) BEE_LIKE_SMALL"],
			[WING_TYPE_BEE_LIKE_LARGE, "(2) BEE_LIKE_LARGE"],
			[WING_TYPE_HARPY, "(4) HARPY"],
			[WING_TYPE_IMP, "(5) IMP"],
			[WING_TYPE_BAT_LIKE_TINY, "(6) BAT_LIKE_TINY"],
			[WING_TYPE_BAT_LIKE_LARGE, "(7) BAT_LIKE_LARGE"],
			[WING_TYPE_SHARK_FIN, "(8) SHARK_FIN"],
			[WING_TYPE_FEATHERED_LARGE, "(9) FEATHERED_LARGE"],
			[WING_TYPE_DRACONIC_SMALL, "(10) DRACONIC_SMALL"],
			[WING_TYPE_DRACONIC_LARGE, "(11) DRACONIC_LARGE"],
			[WING_TYPE_GIANT_DRAGONFLY, "(12) GIANT_DRAGONFLY"],
			[WING_TYPE_BAT_LIKE_LARGE_2, "(13) BAT_LIKE_LARGE_2"],
			[WING_TYPE_DRACONIC_HUGE, "(14) DRACONIC_HUGE"],
			[WING_TYPE_FEATHERED_PHOENIX, "(15) FEATHERED_PHOENIX"],
			[WING_TYPE_FEATHERED_ALICORN, "(16) FEATHERED_ALICORN"],
			[WING_TYPE_MANTIS_LIKE_SMALL, "(17) MANTIS_LIKE_SMALL"],
			[WING_TYPE_MANTIS_LIKE_LARGE, "(18) MANTIS_LIKE_LARGE"],
			[WING_TYPE_MANTIS_LIKE_LARGE_2, "(19) MANTIS_LIKE_LARGE_2"],
			[WING_TYPE_GARGOYLE_LIKE_LARGE, "(20) GARGOYLE_LIKE_LARGE"],
			[WING_TYPE_PLANT, "(21) PLANT"],
			[WING_TYPE_MANTICORE_LIKE_SMALL, "(22) MANTICORE_LIKE_SMALL"],
			[WING_TYPE_MANTICORE_LIKE_LARGE, "(23) MANTICORE_LIKE_LARGE"],
		];
		private static const WING_DESC_CONSTANTS:Array = [
			"(none)","non-existant","tiny hidden","huge","small",
			"giant gragonfly","large bee-like","small bee-like",
			"large, feathered","fluffy featherly","large white feathered","large crimson feathered",
			"large, bat-like","two large pairs of bat-like",
			"imp","small black faerie wings",
			"large, draconic","large, majestic draconic","small, draconic",
			"large manticore-like","small manticore-like",
			"large mantis-like","small mantis-like",
		];
		private static const LOWER_TYPE_CONSTANTS:Array = [
			[LOWER_BODY_TYPE_HUMAN, "(0) HUMAN"],
			[LOWER_BODY_TYPE_HOOFED, "(1) HOOFED"],
			[LOWER_BODY_TYPE_DOG, "(2) DOG"],
			[LOWER_BODY_TYPE_NAGA, "(3) NAGA"],
			[LOWER_BODY_TYPE_DEMONIC_HIGH_HEELS, "(5) DEMONIC_HIGH_HEELS"],
			[LOWER_BODY_TYPE_DEMONIC_CLAWS, "(6) DEMONIC_CLAWS"],
			[LOWER_BODY_TYPE_BEE, "(7) BEE"],
			[LOWER_BODY_TYPE_GOO, "(8) GOO"],
			[LOWER_BODY_TYPE_CAT, "(9) CAT"],
			[LOWER_BODY_TYPE_LIZARD, "(10) LIZARD"],
			[LOWER_BODY_TYPE_PONY, "(11) PONY"],
			[LOWER_BODY_TYPE_BUNNY, "(12) BUNNY"],
			[LOWER_BODY_TYPE_HARPY, "(13) HARPY"],
			[LOWER_BODY_TYPE_KANGAROO, "(14) KANGAROO"],
			[LOWER_BODY_TYPE_CHITINOUS_SPIDER_LEGS, "(15) CHITINOUS_SPIDER_LEGS"],
			[LOWER_BODY_TYPE_DRIDER_LOWER_BODY, "(16) DRIDER_LOWER_BODY"],
			[LOWER_BODY_TYPE_FOX, "(17) FOX"],
			[LOWER_BODY_TYPE_DRAGON, "(18) DRAGON"],
			[LOWER_BODY_TYPE_RACCOON, "(19) RACCOON"],
			[LOWER_BODY_TYPE_FERRET, "(20) FERRET"],
			[LOWER_BODY_TYPE_CLOVEN_HOOFED, "(21) CLOVEN_HOOFED"],
			[LOWER_BODY_TYPE_ECHIDNA, "(23) ECHIDNA"],
			[LOWER_BODY_TYPE_SALAMANDER, "(25) SALAMANDER"],
			[LOWER_BODY_TYPE_SCYLLA, "(26) SCYLLA"],
			[LOWER_BODY_TYPE_MANTIS, "(27) MANTIS"],
			[LOWER_BODY_TYPE_SHARK, "(29) SHARK"],
			[LOWER_BODY_TYPE_GARGOYLE, "(30) GARGOYLE"],
			[LOWER_BODY_TYPE_PLANT_HIGH_HEELS, "(31) PLANT_HIGH_HEELS"],
			[LOWER_BODY_TYPE_PLANT_ROOT_CLAWS, "(32) PLANT_ROOT_CLAWS"],
			[LOWER_BODY_TYPE_WOLF, "(33) WOLF"],
			[LOWER_BODY_TYPE_PLANT_FLOWER, "(34) PLANT_FLOWER"],
			[LOWER_BODY_TYPE_LION, "(35) LION"],
			[LOWER_BODY_TYPE_YETI, "(36) YETI"],
			[LOWER_BODY_TYPE_ORCA, "(37) ORCA"],
			[LOWER_BODY_TYPE_YGG_ROOT_CLAWS, "(38) YGG_ROOT_CLAWS"],
		];
		private static const LEG_COUNT_CONSTANTS:Array = [
			1,2,4,6,8,
			10,12,16
		];
		private static const REAR_TYPE_CONSTANTS:Array  = [
			[REAR_BODY_NONE, "(0) NONE"],
			[REAR_BODY_DRACONIC_MANE, "(1) DRACONIC_MANE"],
			[REAR_BODY_DRACONIC_SPIKES, "(2) DRACONIC_SPIKES"],
			[REAR_BODY_FENRIR_ICE_SPIKES, "(3) FENRIR_ICE_SPIKES"],
			[REAR_BODY_LION_MANE, "(4) LION_MANE"],
			[REAR_BODY_BEHEMOTH, "(5) BEHEMOTH"],
			[REAR_BODY_SHARK_FIN, "(6) SHARK_FIN"],
			[REAR_BODY_ORCA_BLOWHOLE, "(7) ORCA_BLOWHOLE"],
		];
		private function changeArmType(page:int=0,setIdx:int=-1):void {
			if (setIdx>=0) player.armType = setIdx;
			menu();
			dumpPlayerData();
			showChangeOptions(bodyPartEditorTorso, page, ARM_TYPE_CONSTANTS, changeArmType);
		}
		private function changeClawType(page:int=0,setIdx:int=-1):void {
			if (setIdx>=0) player.clawType = setIdx;
			menu();
			dumpPlayerData();
			showChangeOptions(bodyPartEditorTorso, page, CLAW_TYPE_CONSTANTS, changeClawType);
		}
		private function changeClawTone(page:int=0,setIdx:int=-1):void {
			if (setIdx>=0) player.clawTone = SKIN_TONE_CONSTANTS[setIdx];
			menu();
			dumpPlayerData();
			showChangeOptions(bodyPartEditorTorso, page, SKIN_TONE_CONSTANTS, changeClawTone);
		}
		private function changeTailType(page:int=0,setIdx:int=-1):void {
			if (setIdx>=0) player.tailType = setIdx;
			menu();
			dumpPlayerData();
			showChangeOptions(bodyPartEditorTorso, page, TAIL_TYPE_CONSTANTS, changeTailType);
		}
		private function changeTailCount(page:int=0,setIdx:int=-1):void {
			if (setIdx>=0) player.tailCount = TAIL_COUNT_CONSTANTS[setIdx];
			menu();
			dumpPlayerData();
			showChangeOptions(bodyPartEditorTorso, page, TAIL_COUNT_CONSTANTS, changeTailCount);
		}
		private function changeWingType(page:int=0,setIdx:int=-1):void {
			if (setIdx>=0) player.wingType = setIdx;
			menu();
			dumpPlayerData();
			showChangeOptions(bodyPartEditorTorso, page, WING_TYPE_CONSTANTS, changeWingType);
		}
		private function changeWingDesc(page:int=0,setIdx:int=-1):void {
			if (setIdx==0) player.wingDesc = "";
			if (setIdx>=0) player.wingDesc = WING_DESC_CONSTANTS[setIdx];
			menu();
			dumpPlayerData();
			showChangeOptions(bodyPartEditorTorso, page, WING_DESC_CONSTANTS, changeWingDesc);
		}
		private function changeLowerBodyType(page:int=0,setIdx:int=-1):void {
			if (setIdx>=0) player.lowerBodyPart.type = setIdx;
			menu();
			dumpPlayerData();
			showChangeOptions(bodyPartEditorTorso, page, LOWER_TYPE_CONSTANTS, changeLowerBodyType);
		}
		private function changeLegCount(page:int=0,setIdx:int=-1):void {
			if (setIdx>=0) player.legCount = LEG_COUNT_CONSTANTS[setIdx];
			menu();
			dumpPlayerData();
			showChangeOptions(bodyPartEditorTorso, page, LEG_COUNT_CONSTANTS, changeLegCount);
		}
		private function changeRearBodyType(page:int=0,setIdx:int=-1):void {
			if (setIdx>=0) player.rearBody = setIdx;
			menu();
			dumpPlayerData();
			showChangeOptions(bodyPartEditorTorso, page, REAR_TYPE_CONSTANTS, changeRearBodyType);
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
			player.skin.restore();
			player.skin.growFur();
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
			player.skin.restore();
			player.skin.growCoat(SKIN_COAT_SCALES);
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
					outputText(" x" + player.prisonItemSlots[(i*2)+1]);
				}
			}
			flushOutputTextToGUI();
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
			if (kGAMECLASS.monk >= 5 || flags[kFLAGS.JOJO_DEAD_OR_GONE] > 0) addButton(1, "Jojo", resetJojo);
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
			doYesNo(reallyResetSheila, resetNPCMenu);
		}
		private function reallyResetJojo():void {
			clearOutput();
			if (kGAMECLASS.monk > 1) {
				outputText("Jojo is no longer corrupted!  ");
				kGAMECLASS.monk = 0;
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
		
		//------------
		// LIGHTS OUT
		//------------
		public var lightsOutVictoryFunction:Function;
		public var lightsOutFailureFunction:Function;

		public var lightsArray:Array;

		public function startLightsOut(victoryFunction:Function = null, failureFunction:Function = null):void
		{
			clearOutput();
			outputText("Test puzzle!");
			outputText("\n\nThis is the same type used in Stellar Tether bomb puzzle in TiTS.");
			
			if (victoryFunction == null) victoryFunction = accessDebugMenu;
			lightsOutVictoryFunction = victoryFunction;
			if (failureFunction == null) failureFunction = accessDebugMenu;
			lightsOutFailureFunction = failureFunction;
			
			menu();
			lightsArray = new Array();
			
			for (var i:int = 0; i < 15; i++)
			{
				lightsArray[i] = false;
				
				addButton(i, " ", toggleLight, i);
			}
			
			var onBts:Array = [1, 5, 6, 9, 10, 11, 12, 13];
			
			for (i = 0; i < onBts.length; i++)
			{
				lightsArray[onBts[i]] = true;
				
				addButton(onBts[i], "XXXXXXXX", toggleLight, onBts[i]);
			}
		}

		public function testVictoryFunc():void
		{
			clearOutput();
			outputText("A winner is you! A horsecock for your butt as tribute!");
			menu();
			addButton(0, "Next", accessDebugMenu);
		}

		public function testFailureFunc():void
		{
			clearOutput();
			outputText("You failed. Try again?");
			menu();
			addButton(0, "Yes", startLightsOut, testVictoryFunc, testFailureFunc);
			addButton(1, "No", accessDebugMenu);
		}
		
		public function toggleSlot(slot:int):void
		{
			lightsArray[slot] = !lightsArray[slot]
			
			if (lightsArray[slot]) 
			{
				//userInterface.setButtonPurple(slot);
				mainView.setButtonText(slot, "XXXXXXXX");
			}
			else
			{
				//userInterface.setButtonBlue(slot);
				mainView.setButtonText(slot, "");
			}
		}

		public function toggleLight(slot:int):void
		{
			toggleSlot(slot);
			toggleNearby(slot);
			
			var allOff:Boolean = true;
			var allOn:Boolean = true;
			
			for (var i:int = 0; i < 15; i++)
			{
				if (lightsArray[i] == 1) allOff = false;
				if (lightsArray[i] == 0) allOn = false;

			}
			if (allOn)
			{
				lightsOutFailureFunction();
			}
			if (allOff)
			{
				lightsOutVictoryFunction();
			}
		}

		public function toggleNearby(slot:int):void
		{
			var pX:int = slot % 5;
			var pY:int = slot / 5;
			
			if (pX > 0) toggleSlot(slot - 1);
			if (pX < 4) toggleSlot(slot + 1);
			if (pY > 0) toggleSlot(slot - 5);
			if (pY < 2) toggleSlot(slot + 5);
		}
	}

}