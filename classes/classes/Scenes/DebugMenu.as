package classes.Scenes
{
import classes.*;
import classes.BodyParts.Antennae;
import classes.BodyParts.Arms;
import classes.BodyParts.Beard;
import classes.BodyParts.BodyMaterial;
import classes.BodyParts.Claws;
import classes.BodyParts.Ears;
import classes.BodyParts.Eyes;
import classes.BodyParts.Face;
import classes.BodyParts.Gills;
import classes.BodyParts.Hair;
import classes.BodyParts.Horns;
import classes.BodyParts.LowerBody;
import classes.BodyParts.RearBody;
import classes.BodyParts.Skin;
import classes.BodyParts.Tail;
import classes.BodyParts.Tongue;
import classes.BodyParts.Wings;
import classes.GlobalFlags.kFLAGS;
import classes.Items.Armor;
import classes.Items.Consumable;
import classes.Items.Consumables.HairDye;
import classes.Items.Dynamic.DynamicArmor;
import classes.Items.Dynamic.DynamicWeapon;
import classes.Items.DynamicItems;
import classes.Items.EnchantmentType;
import classes.Items.FlyingSwords;
import classes.Items.HeadJewelry;
import classes.Items.ItemConstants;
import classes.Items.Jewelry;
import classes.Items.MiscJewelry;
import classes.Items.Shield;
import classes.Items.Undergarment;
import classes.Items.Weapon;
import classes.Items.WeaponRange;
import classes.Parser.Parser;
import classes.Scenes.NPCs.JojoScene;
import classes.Transformations.PossibleEffect;
import classes.Transformations.Transformation;
import classes.internals.EnumValue;

import coc.view.Block;
import coc.view.ButtonDataList;
import coc.view.Color;
import coc.view.MainView;
import com.bit101.components.ComboBox;
import com.bit101.components.InputText;
//import fl.controls.ComboBox;
//import fl.controls.TextInput;
//import fl.data.DataProvider;

import flash.display.DisplayObject;
import flash.events.Event;
import flash.events.TextEvent;
import flash.utils.describeType;

public class DebugMenu extends BaseContent
	{
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
		public var testArray:Array = [];


		public function DebugMenu()
		{
		}

		public function accessDebugMenu():void {
			LogProfilingReport();
			//buildArray();
            if (!CoC.instance.inCombat) {
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
				addButton(6, "MeaninglessCorr", toggleMeaninglessCorruption).hint("Toggles the Meaningless Corruption flag. If enabled, most corruption requirements are disabled for scenes.");
				if (player.isPregnant()) addButton(4, "Abort Preg", abortPregnancy);
				addButton(5, "DumpEffects", dumpEffectsMenu).hint("Display your status effects");
				addButton(7, "HACK STUFFZ", styleHackMenu).hint("H4X0RZ");
	            addButton(8, "Test Scene", testScene);
	            addButton(9, "Test Tf", testTfMenu);
	            addButton(10, "Debug set var", debugSetVarMenu);
				addButton(14, "Exit", playerMenu);
			}
            if (CoC.instance.inCombat) {
                clearOutput();
				outputText("You raise the wand and give it a twirl but nothing happens. Seems like it only works when you're not in the middle of a battle.");
				doNext(playerMenu);
			}
		}
		
		/**
		 * Sets an inputted variable to specified value
		 * all parameters are strings
		 * @param	objName name of desired object (player)
		 * @param	varName name of desired variable (XP)
		 * @param	varVal value to set
		 * @return true if obj.var exists, otherwise false
		 */public function debugVarSet(objName:String, varName:String, varVal:String):Boolean {
			if (!BaseContent[objName].hasOwnProperty(varName)) {
				outputText("Invalid " + objName + "or" + varName);
				return false;
			} else {
				BaseContent[objName][varName] = varVal;
				return true;
			}
		}
		/**
		 * Accepts a simple assignment string like player.XP=10
		 * can also read text box in debug menu
		 * @param	input String to parse, no fancy interpreting
		 * @return true unless textbox empty, otherwise false
		 */public function debugVarParse(input:String = null):Boolean {
			if (input == null) input = mainView.nameBox.text;
			if (input == "") return false;
			mainView.nameBox.visible = false;
			mainView.nameBox.text = "";
			var regex:RegExp = /[.=]/;
			var inputa:Array = input.split(regex);
			outputText("\n\n"+input+" became "+inputa[0]+", "+inputa[1]+", "+inputa[2]+".");
			return debugVarSet(inputa[0], inputa[1], inputa[2]);
		}
		
		private function debugSetVarMenu():void {
			clearOutput();
			mainView.nameBox.visible = true;
			mainView.nameBox.width = 165;
			mainView.nameBox.x = mainView.mainText.x + 5;
			mainView.nameBox.y = mainView.mainText.y + 3 + mainView.mainText.textHeight;
			mainView.nameBox.text = "";
			mainView.nameBox.maxChars = 999;
			mainView.nameBox.restrict = null;
			outputText("\n\n\n\n\nThis is not intelligent, please use the format: obj.var=val\n"
				+"For example, player.XP=10\nValues are <b>case-sensitive</b> and basically only strings or numbers.\n"
				+"Note that values may not visibly update until a refresh is called in some way.\n");
			menu();
			addButton(0, "Enter", debugVarParse);
			addButton(1, "Cancel", accessDebugMenu);
			addButton(2, "Refresh", debugSetVarMenu);
		}
		
		private function dumpEffectsMenu():void {
			clearOutput();
			for each (var effect:StatusEffectClass in player.statusEffects) {
				outputText("'"+effect.stype.id+"': "+effect.value1+" "+effect.value2+" "+effect.value3+" "+effect.value4+"\n");
			}
			doNext(playerMenu);
		}

		private var selectedScene:*;
		private function testScene(selected:*=null):void{
			clearOutput();
			if(!selected){selected = SceneLib;}
			selectedScene = selected;
			mainView.mainText.addEventListener(TextEvent.LINK, linkhandler);
			getFun("variable",selected);
			getFun("method",selected);
			menu();
			addButton(0,"Back",linkhandler,new TextEvent(TextEvent.LINK,false,false,"-1"));

			function getFun(type:String, scene:*):void{
				var funsxml:XML = describeType(scene);
				var funs:Array = [];
				for each(var item:XML in funsxml[type]){
					funs.push(item);
				}
				funs.sortOn("@name");
				if(funs.length > 0){outputText("<b><u>"+type.toUpperCase()+"</u></b>\n");}
				for each (var fun:* in funs){
					outputText("<u><a href=\"event:"+fun.@name+"\">"+fun.@name+"</a></u>\n")
				}
			}
			function linkhandler(e:TextEvent):void{
				mainView.mainText.removeEventListener(TextEvent.LINK, linkhandler);
				if(e.text == "-1"){
					mainView.mainText.removeEventListener(TextEvent.LINK, linkhandler);
					if(selectedScene != SceneLib){testScene();}
					else{accessDebugMenu();}
					return;
				}
				if(selectedScene[e.text] is Function){
					clearOutput();
					doNext(accessDebugMenu);
					var selected:Function = selectedScene[e.text];
					selectedScene = null;
					selected();
				}
				else{
					selectedScene = selectedScene[e.text];
					testScene(selectedScene);
				}

			}
		}

		private function testTfMenu():void {
			clearOutput();
			mainView.mainText.addEventListener(TextEvent.LINK, linkhandler);
			outputText("<b>Test transformations:</b>\n");

			var list:/*String*/Array = keys(transformations, true).sort();
			for each (var key:String in list) {
				var tf:PossibleEffect = transformations[key] as PossibleEffect;
				if (!tf) continue;
				outputText("\n");
				if (tf.isPossible()) outputText("<u>");
				outputText('<a href="event:'+key+'">'+key+"</a>");
				if (tf.isPossible()) outputText("</u>");
				outputText(" / "+tf.name);
				if (tf is Transformation && (tf as Transformation).isPresent()) {
					outputText(" [font-green]present[/font]");
				} else if (!tf.isPossible()) {
					outputText(" [font-red]impossible[/font]");
				}
			}
			outputText("\n\n");
			menu();
			addButton(0,"Back",linkhandler,new TextEvent(TextEvent.LINK,false,false,"-1"));

			function linkhandler(e:TextEvent):void {
				mainView.mainText.removeEventListener(TextEvent.LINK, linkhandler);
				var tf:PossibleEffect = (e.text in transformations) ? transformations[e.text] as PossibleEffect : null;
				if (e.text == "-1" || !tf) {
					accessDebugMenu();
				} else {
					CoC.instance.currentText = "";
					tf.applyEffect();
					var text:String = CoC.instance.currentText;
					mainViewManager.updateCharviewIfNeeded();
					testTfMenu();
					rawOutputText(text);
					flushOutputTextToGUI();
				}
			}
		}

		//Spawn items menu
		private function itemSpawnMenu():void {
			setItemArrays();
			clearOutput();
			outputText("Select a category.");
			menu();
			addButton(0, "Transformatives", displayItemList, transformativeArray);
			addButton(1, "Consumables", displayItemList, consumableArray);
			addButton(2, "Dyes", displayItemList, dyeArray);
			addButton(3, "Materials", displayItemList, materialArray);
			addButton(4, "Rare Items", displayItemList, rareArray);
			addButton(5, "Weapons", displayItemList, weaponArray);
			addButton(6, "Shields", displayItemList, shieldArray);
			addButton(7, "Armours", displayItemList, armourArray);
			addButton(8, "Undergarments", displayItemList, undergarmentArray);
			addButton(9, "Accessories", displayItemList, accessoryArray);
			addButton(10,"ConsumableLib",displayItemList,testArray);
			addButton(12, "Dynamic", dynamicItemMenu);
			addButton(13, "Enchanted", enchantedItemMenu);
			addButton(14, "Back", accessDebugMenu);
		}
		
		private function dynamicItemMenu():void {
			hideItemParams();
			clearOutput();
			menu();
			var buttons:ButtonDataList = new ButtonDataList();
			buttons.add("HairDye", curry(configureTemplate, itemTemplates.THairDye));
			submenu(buttons, itemSpawnMenu);
		}
		private var itemParamsBlock:Block;
		private function hideItemParams():void {
			if (itemParamsBlock) {
				mainView.removeElement(itemParamsBlock);
				itemParamsBlock = null;
			}
		}
		private function configureTemplate(template:ItemTemplate, paramsDef:Array=null):void {
			paramsDef ||= template.metadata.params;
			clearOutput();
			outputText(template.name + " parameters:\n");
			flushOutputTextToGUI();
			
			var parameters:Object = {};
			
			itemParamsBlock = new Block({
				layoutConfig: {
					type: "flow",
					direction: "column",
					gap: 2
				},
				x: mainView.mainText.x,
				y: mainView.mainText.y + 24,
				width: mainView.mainText.width,
				height: mainView.mainText.height - 24
			});
			mainView.hotkeysDisabled = true;
			mainView.addElement(itemParamsBlock);
			for each (var def:Object in paramsDef) {
				parameters[def.name] = def.value;
				var row:Block = new Block({height: 24});
				row.addTextField({text: def.label || def.name});
				var element:DisplayObject;
				switch (def.type) {
					case "text":
						element = (function(def:Object):DisplayObject{
							return row.addTextInput({
								bindText: [parameters, def.name]
							})
						})(def);
						break;
					case "number":
						element = (function(def:Object):DisplayObject{
							return row.addTextInput({
								bindNumber: [parameters, def.name]
							})
						})(def);
						break;
					default:
						element = row.addTextField({text:"Bad type "+def.type});
				}
				if (element) {
					element.x       = itemParamsBlock.width * 1 / 5;
					element.width   = itemParamsBlock.width * 4 / 5;
					element.visible = true;
					row.addElement(element);
					itemParamsBlock.addElement(row);
				}
			}
			
			menu();
			addButton(0, "Create", createDynamicItem, template, parameters);
			addButton(14, "Back", dynamicItemMenu);
		}
		private function createDynamicItem(template:ItemTemplate, parameters:Object):void {
			clearOutput();
			hideItemParams();
			inventory.takeItem(template.createItem(parameters), dynamicItemMenu);
		}

		private function enchantedItemMenu():void {
			clearOutput();
			outputText("Create an enchanted item");
			flushOutputTextToGUI();
			
			var params:Object = {
				typeSubtype: "weapon/sword",
				rarity: ItemConstants.RARITY_COMMON,
				curse: ItemConstants.CS_HIDDEN_UNCURSED,
				quality: +0,
				effects: [
					{identified: true, type: 0, params: "0"},
					{identified: true, type: 0, params: "0"},
					{identified: true, type: 0, params: "0"},
					{identified: true, type: 0, params: "0"}
				]
			};
			
			hideItemParams();
			itemParamsBlock = new Block({
				layoutConfig: {
					type: "flow",
					direction: "column",
					gap: 2,
					stretch: true
				},
				x: mainView.mainText.x,
				y: mainView.mainText.y + 24,
				width: mainView.mainText.width,
				height: mainView.mainText.height - 24
			});
			
			var paramGrid:Block = new Block({
				layoutConfig: {
					type: "grid",
					columns: [1/3, 2/3],
					gap: 2,
					setWidth: true
				}
			});
			
			var typesAndSubtypes:Array = [];
			for each (var k:String in values(DynamicWeapon.Subtypes).sort()) typesAndSubtypes.push("weapon/"+k);
			for each (k in values(DynamicArmor.Subtypes).sort()) typesAndSubtypes.push("armor/"+k);
			paramGrid.addTextField("Type/Subtype");
			paramGrid.addComboBox({
				bindValue: [params, "typeSubtype"],
				items: typesAndSubtypes
			});
			paramGrid.addTextField("Rarity");
			paramGrid.addComboBox({
				bindValue: [params, "rarity"],
				items: ItemConstants.Rarities,
				labelKey: "name",
				valueKey: "value"
			});
			paramGrid.addTextField("Curse status");
			paramGrid.addComboBox({
				bindValue: [params, "curse"],
				items: [
					{label:"Unknown uncursed", data:ItemConstants.CS_HIDDEN_UNCURSED},
					{label:"Known uncursed", data:ItemConstants.CS_KNOWN_UNCURSED},
					{label:"Unknown cursed", data:ItemConstants.CS_HIDDEN_CURSED},
					{label:"Known cursed", data:ItemConstants.CS_KNOWN_CURSED}
				]
			});
			paramGrid.addTextField("Quality");
			paramGrid.addTextInput({
				bindNumber: [params, "quality"]
			});
			itemParamsBlock.addElement(paramGrid);
			
			var effectGrid:Block = new Block({
				layoutConfig: {
					type: "grid",
					columns: [1/3, 1/3, 1/3],
					gap: 2,
					setWidth: true
				}
			});
			effectGrid.addTextField("Identified");
			effectGrid.addTextField("Enchantment type");
			effectGrid.addTextField("Enchantment power/params");
			for (var i:int = 0; i < params.effects.length; i++) {
				effectGrid.addComboBox({
					bindValue: [params.effects[i], "identified"],
					items:[
						{label:"identified", data:true},
						{label:"unidentified", data:false}
					]
				}, {setWidth:false});
				effectGrid.addComboBox({
					items: [{name:"(none)", id:0}].concat(values(EnchantmentType.ENCHANTMENT_TYPES)),
					labelKey: "name",
					valueKey: "id",
					bindValue: [params.effects[i], "type"]
				});
				effectGrid.addTextInput({
					bindText: [params.effects[i], "params"]
				});
			}
			itemParamsBlock.addElement(effectGrid);
			
			mainView.hotkeysDisabled = true;
			mainView.addElement(itemParamsBlock);
			
			menu();
			addButton(0, "Spawn", function():void {
				hideItemParams();
				clearOutput();
				rawOutputText(JSON.stringify(params));
				outputText("\n\n");
				var effs:Array = [];
				for each (var e:Object in params.effects) {
					if (e.type) {
						effs.push(
								[
									e.identified ? 1 : 0,
									e.type
								].concat(JSON.parse("[" + e.params + "]"))
						);
					}
				}
				var p:Object = {
					t: params.typeSubtype.split("/")[1],
					r: params.rarity,
					q: params.quality,
					c: params.curse,
					e: effs
				}
				rawOutputText(JSON.stringify(p));
				outputText("\n\n");
				var item:ItemType;
				switch (params.typeSubtype.split("/")[0]) {
					case "weapon":
						item = itemTemplates.TDynamicWeapon.createItem(p);
						break;
					case "armor":
						item = itemTemplates.TDynamicArmor.createItem(p);
						break;
					default:
						throw new Error(params.typeSubtype);
				}
				
				outputText(item.shortName+"\n"+item.longName+"\n"+item.description);
				
				doNext(inventory.takeItem, item, itemSpawnMenu);
			});
			addButton(5, "Random", function():void {
				hideItemParams();
				clearOutput();
				var item:ItemType = DynamicItems.randomItem({identified:true});
				inventory.takeItem(item, enchantedItemMenu);
			});
			addButton(6, "Random x20", generate20RandomItems);
			addButton(14, "Back", function():void {
				hideItemParams();
				itemSpawnMenu();
			})
		}
		
		private function generate20RandomItems():void {
			hideItemParams();
			clearOutput();
			mainView.linkHandler = function(event:String):void {
				inventory.takeItem(ItemType.lookupItem(event), enchantedItemMenu);
			}
			outputText("Click to take:");
			for (var i:int = 0; i<20; i++) {
				var item:ItemType = DynamicItems.randomItem({identified:true});
				outputText("\n"+mkLink(item.longName, item.id));
			}
			menu();
			addButton(0, "Again", generate20RandomItems);
			addButton(14, "Back", itemSpawnMenu);
		}
		
		private function displayItemList(array:/*ItemType*/Array):void {
			// displayItemPage(array, 1);
			var storage:/*ItemSlotClass*/Array = [];
			for (var i:int = 0; i < array.length; i++) {
				var isc:ItemSlotClass = new ItemSlotClass();
				var itype:ItemType = array[i];
				if (itype) {
					isc.setItemAndQty(itype, itype.stackSize);
				}
				storage.push(isc);
			}
			inventory.transferMenu(
					storage,
					0,
					storage.length,
					itemSpawnMenu,
					"Spawn Item",
					null,
					true,
					false
			);
		}
		private function displayItemPage(array:Array, page:int):void {
			clearOutput();
			outputText("What item would you like to spawn? ");
			menu();
			var buttonPos:int = 0; //Button positions 4 and 9 are reserved for next and previous.
			for (var i:int = 0; i < 12; i++) {
				var itemType:ItemType = array[((page-1) * 12) + i];
				if (itemType) {
					addButton(buttonPos, itemType.shortName, inventory.takeItem, itemType, curry(displayItemPage, array, page)).itemIcon(itemType);
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
			function addItemsFromLib(array:/*ItemType*/Array, lib:Object, itemClass:Class):void {
				for each (var item:* in values(lib, true)) {
					if (item is ItemType && !(item as ItemType).isNothing && item is itemClass) {
						array.push(item);
						// trace(String(item.name));
					} else {
						trace("Not Added: " + String(item));
					}
				}
				array.sortOn("shortName");
			}
			addItemsFromLib(testArray, consumables, Consumable);
			//Build arrays here
			//------------
			// Materials
			//------------
			//Page 1, which is the only page for material so far. :(
			materialArray.push(useables.GREENGL);
			materialArray.push(useables.B_CHITN);
			materialArray.push(useables.T_SSILK);
			materialArray.push(useables.D_SCALE);
			materialArray.push(useables.IMPSKLL);
			materialArray.push(useables.E_ICHOR);
			materialArray.push(useables.D_E_ICHOR);
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
			// Transformatives & Consumables
			//------------
			for each (var item:ItemType in testArray) {
				if (item is HairDye) {
					dyeArray.push(item);
				} else if (materialArray.indexOf(item) == -1 && rareArray.indexOf(item) == -1) {
					if (item.hasTag(ItemConstants.U_TF)) {
						transformativeArray.push(item);
					} else
						consumableArray.push(item);
				}
			}

			//------------
			// Weapons
			//------------
			addItemsFromLib(weaponArray, weapons, Weapon);
			addItemsFromLib(weaponArray, weaponsrange, WeaponRange);
			addItemsFromLib(weaponArray, weaponsflyingswords, FlyingSwords);

			//------------
			// Shields
			//------------
			addItemsFromLib(shieldArray, shields, Shield);

			//------------
			// Armours
			//------------
			addItemsFromLib(armourArray, armors, Armor);

			//------------
			// Undergarments
			//------------
			addItemsFromLib(undergarmentArray, undergarments, Undergarment);

			//------------
			// Accessories
			//------------
			addItemsFromLib(accessoryArray, jewelries, Jewelry);
			addItemsFromLib(accessoryArray, headjewelries, HeadJewelry);
			addItemsFromLib(accessoryArray, miscjewelries, MiscJewelry);
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
			addButton(5, "Tooltips Ahoy", EngineCore.doNothing).hint("Ahoy! I'm a tooltip! I will show up a lot in future updates!", "Tooltip 2.0");
			addButton(6, "Lights Out", startLightsOut, testVictoryFunc, testFailureFunc, null, "Test the lights out puzzle, fresh off TiTS!");
			addButton(7, "Isabella Birth", SceneLib.isabellaFollowerScene.isabellaGivesBirth).hint("Test Isabella giving birth for debugging purposes.", "Trigger Isabella Giving Birth");
			addButton(8, "BodyPartEditor", bodyPartEditorRoot, styleHackMenu).hint("Inspect and fine-tune the player body parts");
			addButton(9, "Color Picker", colorPickerRoot).hint("HSL picker for skin/hair color");
			addButton(14, "Back", accessDebugMenu);
		}
		private function generateTagDemos(...tags:Array):String {
			return tags.map(function(tag:String,index:int,array:Array):String {
				return "\\["+tag+"\\] = " +
                        Parser.recursiveParser("[" + tag + "]").replace(' ', '\xA0')
            }).join(",\t");
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
			outputText("\n<b>H</b>ue:\t\t\t"+h+' / 360\t(0: red, 120: green, 240: blue)');
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

			CoC.instance.showComboBox(palette,"Known colors",function(item:Object):void {
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
			CoC.instance.playerAppearance.appearance(true);
			outputText("[pg]");
			var body:BodyData = player.bodyData();
			for each (var race:Race in Races.AllRacesByName) {
				var score:int = race.totalScore(body);
				if (score == 0) continue;
				outputText("<b>"+race.name+" score: "+score+"</b>\n");
				//outputText(race.printDetails(body));
			}
			flushOutputTextToGUI();
		}
		private var bodyEditorControls:Block;

		private var bodyPartEditorBack:Function = null;
		public function bodyPartEditorRoot(back:Function = null):void {
			if (back != null) bodyPartEditorBack = back;
			if (bodyPartEditorBack == null) bodyPartEditorBack = accessDebugMenu;
			clearOutput();
			menu();
			if (bodyEditorControls) {
				mainView.removeElement(bodyEditorControls);
			}
			bodyEditorControls = new Block({
				layoutConfig: {
					type: "flow",
					direction: "column",
					gap: 1
				},
				x: MainView.SPRITE_X,
				y: MainView.SPRITE_Y,
				width: MainView.SPRITE_MAX_W
			});
			mainView.addElement(bodyEditorControls);
			dumpPlayerData();
			addButton(0,"Head",bodyPartEditorHead);
			addButton(1,"Skin & Hair",bodyPartEditorSkin);
			addButton(2,"Torso & Limbs",bodyPartEditorTorso);
			addButton(3,"AlrauneDebug",AlrauneDebug);
//			addButton(3,"",bodyPartEditorValues);
//			addButton(4,"",bodyPartEditorCocks);
//			addButton(5,"",bodyPartEditorVaginas);
//			addButton(6,"",bodyPartEditorBreasts);
//			addButton(7,"",bodyPartEditorPiercings);
//			addButton(,"",change);
//			addButton(13, "Page2", bodyPartEditor2);
			addButton(14, "Back", function():void {
				if (bodyEditorControls) {
					mainView.removeElement(bodyEditorControls);
					bodyEditorControls = null;
				}
				bodyPartEditorBack();
			});
		}
		private function clearBeElements():void {
			var i:int = bodyEditorControls.numElements;
			while (i-->0) {
				bodyEditorControls.removeElement(bodyEditorControls.getElementAt(i));
			}
		}
		private function addBeControl(label:String, element:DisplayObject):void {
			var row:Block = new Block({
				height: 24
			});
			var style:* = MainView.Themes[flags[kFLAGS.BACKGROUND_STYLE]];
			row.addTextField({
				text: label,
				defaultTextFormat:{color:style.statTextColor}
			});
			element.x = bodyEditorControls.width*2/5;
			element.width = bodyEditorControls.width*3/5;
			element.visible = true;
			row.addElement(element);
			bodyEditorControls.addElement(row);
		}
		private function addBeComboBox(label:String, items:Array, selectedItem:*, callback:Function):void {
			var cb:ComboBox = new ComboBox();
			cb.items = items;
			for (var i:int = 0; i < items.length; i++) {
				if (selectedItem == items[i] || 'data' in items[i] && items[i].data == selectedItem) {
					cb.selectedIndex = i;
					break;
				}
			}
			cb.addEventListener(Event.SELECT, function(event:Event):void {
				event.preventDefault();
				callback(cb.selectedItem);
			});
			addBeControl(label, cb);
		}
		private function addBeTextInput(label:String, value:String, callback:Function):void {
			var ti:InputText = new InputText();
			ti.text = value;
			ti.addEventListener(Event.CHANGE, function (event:Event):void {
				event.preventDefault();
				callback(ti.text);
			});
			addBeControl(label, ti);
		}

		private function bodyPartEditorSkin():void {
			clearBeElements();
			addBeComboBox("Hair type",
                    mapForComboBox(Hair.Types, "id"),
                    Hair.Types[player.hairType],
					function (item:*):void {
						player.hairType = item.data.value;
						dumpPlayerData();
						tagDemosSkin();
					}
			);
			addBeTextInput("Hair length",
					""+player.hairLength,
					function (item:String):void {
						if (!isNaN(parseFloat(item))) {
							player.hairLength = parseInt(item);
							dumpPlayerData();
							tagDemosSkin();
						}
					}
			);
			addBeComboBox("Skin coverage", SKIN_COVERAGE_CONSTANTS, player.skin.coverage,
					function (item:*):void {
						player.skin.coverage = item.data;
						dumpPlayerData();
						tagDemosSkin();
					}
			);
			addBeComboBox("Base type",
					mapForComboBox(
							filterByProp(Skin.SkinTypes,"base",true),
							"id"
					),
					Skin.SkinTypes[player.skin.base.type],
					function (item:*):void {
						player.skin.base.type = item.data.value;
						dumpPlayerData();
						tagDemosSkin();
					}
			);
			addBeComboBox("Base pattern",
					mapForComboBox(
							filterByProp(Skin.PatternTypes,"base",true),
							"id"
					),
					Skin.PatternTypes[player.skin.base.pattern],
					function (item:*):void {
						player.skin.base.pattern = item.data.value;
						dumpPlayerData();
						tagDemosSkin();
					}
			);
			addBeComboBox("Base adj", SKIN_ADJ_CONSTANTS, player.skin.base.adj,
					function (item:*):void {
						player.skin.base.adj = item == "(none)" ? "" : item;
						dumpPlayerData();
						tagDemosSkin();
					}
			);
			/*addBeComboBox("Base desc", SKIN_DESC_CONSTANTS, player.skin.base.descRaw,
					function (item:*):void {
						player.skin.base.descRaw = item.data === "(default)" ? "" : item.data;
						dumpPlayerData();
						tagDemosSkin();
					}
			);*/
			addBeComboBox("Coat type",
					mapForComboBox(
							filterByProp(Skin.SkinTypes,"coat",true),
							"id"
					),
					Skin.SkinTypes[player.skin.coat.type],
					function (item:*):void {
						player.skin.coat.type = item.data.value;
						dumpPlayerData();
						tagDemosSkin();
					}
			);
			addBeComboBox("Coat pattern",
					mapForComboBox(
							filterByProp(Skin.PatternTypes,"coat",true),
							"id"
					),
					Skin.PatternTypes[player.skin.coat.pattern],
					function (item:*):void {
						player.skin.coat.pattern = item.data.value;
						dumpPlayerData();
						tagDemosSkin();
					}
			);
			addBeComboBox("Coat adj", SKIN_ADJ_CONSTANTS, player.skin.coat.adj,
					function (item:*):void {
						player.skin.coat.adj = item == "(none)" ? "" : item;
						dumpPlayerData();
						tagDemosSkin();
					}
			);
			/*addBeComboBox("Coat desc", SKIN_DESC_CONSTANTS, player.skin.coat.descRaw,
					function (item:*):void {
						player.skin.coat.descRaw = item.data === "(default)" ? "" : item.data;
						dumpPlayerData();
						tagDemosSkin();
					}
			);*/
			for each (var type:EnumValue in BodyMaterial.Types) {
				addBeComboBox(capitalizeFirstLetter(type.name)+" color1",
						COLOR_CONSTANTS,
						player.bodyMaterialColor1(type.value),
						curry(function (id:int,item:*):void {
							player.setBodyMaterialColor1(id, item);
							dumpPlayerData();
							tagDemosSkin();
						}, type.value)
				);
				addBeComboBox(capitalizeFirstLetter(type.name)+" color2",
						COLOR_CONSTANTS,
						player.bodyMaterialColor2(type.value),
						curry(function (id:int,item:*):void {
							player.setBodyMaterialColor2(id, item);
							dumpPlayerData();
							tagDemosSkin();
						}, type.value)
				);
			}
			menu();
			dumpPlayerData();
			tagDemosSkin();
			addButton(14, "Back", bodyPartEditorRoot);
		}
		private static const COLOR_CONSTANTS:Array = [
			"albino", "aqua", "ashen", "auburn", "black", "blond", "blonde", "blood-red", "blue", "bronzed", "brown", "caramel",
			"cerulean", "chocolate", "crimson", "crystal", "dark", "dusky", "ebony", "emerald", "fair",
			"golden", "gray", "green", "indigo", "light", "light pink", "mahogany", "metallic", "midnight", "olive", "orange",
			"peach", "pink", "purple", "red", "russet", "sable", "sanguine", "silky", "silver",
			"tan", "tawny", "turquoise", "white", "yellow",
			"aphotic blue-black", "ashen grayish-blue", "creamy-white", "crimson platinum",
			"dark blue", "dark gray", "dark green", "deep blue", "deep red",
			"ghostly pale", "glacial white", "golden blonde", "grayish-blue", "iridescent gray",
			"leaf green", "light blonde", "light blue", "light gray", "light green", "light grey", "light purple", "lime green",
			"mediterranean-toned", "metallic golden", "metallic silver", "midnight black", "milky white",
			"pale white", "pale yellow", "pinkish purple", "platinum blonde", "platinum crimson", "platinum-blonde", "purplish-black",
			"quartz white", "reddish-orange", "rough gray", "immaculate white", "royal purple", "dark purple",
			"sandy blonde", "sandy brown", "sandy-blonde", "shiny black", "silver blonde", "silver-white", "snow white", "blazing red",
			"yellowish-green", "black and yellow", "white and black", "pure blue", "neon blue", "pale purple", "eldritch green"
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
			{data: Skin.COVERAGE_NONE, label: "NONE (0)"},
			{data: Skin.COVERAGE_LOW, label: "LOW (1, partial)"},
			{data: Skin.COVERAGE_MEDIUM, label: "MEDIUM (2, mixed)"},
			{data: Skin.COVERAGE_HIGH, label: "HIGH (3, full)"},
			{data: Skin.COVERAGE_COMPLETE, label: "COMPLETE (4, full+face)"}
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
							"skinfurscales", "color") + ".\n");
		}
		private function bodyPartEditorHead():void {
			clearBeElements();
			// Convert from EnumValue[] to { label: EnumValue.id, data: EnumValue }[]
			// to generate proper combo box items.
			var faceTypes:Array = mapForComboBox(Face.Types, "id");
			addBeComboBox("Face type", faceTypes,
					Face.Types[player.facePart.type],
					function (item:*):void {
						player.facePart.type = item.data.value;
						dumpPlayerData();
					}
			);
			var tongueTypes:Array = mapForComboBox(Tongue.Types, "id");
			addBeComboBox("Tongue type", tongueTypes,
					Tongue.Types[player.tongue.type],
					function (item:*):void {
						player.tongue.type = item.data.value;
						dumpPlayerData();
					}
			);
			var eyeTypes:Array = mapForComboBox(Eyes.Types, "id");
			addBeComboBox("Eye type", eyeTypes,
					Eyes.Types[player.eyes.type],
					function (item:*):void {
						player.eyes.type = item.data.value;
						dumpPlayerData();
					}
			);
			addBeComboBox("Eye color", COLOR_CONSTANTS, player.eyes.colour,
					function (item:*):void {
						player.eyes.colour = item;
						dumpPlayerData();
					}
			);
			var earTypes:Array = mapForComboBox(Ears.Types, "id");
			addBeComboBox("Ear type", earTypes,
					Ears.Types[player.ears.type],
					function (item:*):void {
						player.ears.type = item.data.value;
						dumpPlayerData();
					}
			);
			var antennaeTypes:Array = mapForComboBox(Antennae.Types, "id");
			addBeComboBox("Antennae type", antennaeTypes,
					Antennae.Types[player.antennae.type],
					function (item:*):void {
						player.antennae.type = item.data.value;
						dumpPlayerData();
					}
			);
			var hornTypes:Array = mapForComboBox(Horns.Types, "id");
			addBeComboBox("Horns type", hornTypes,
					Horns.Types[player.horns.type],
					function (item:*):void {
						player.horns.type = item.data.value;
						dumpPlayerData();
					}
			);
			addBeComboBox("Horn count", HORN_COUNT_CONSTANTS,
					player.horns.count,
					function (item:*):void {
						player.horns.count = item;
						dumpPlayerData();
					}
			);
			var gillTypes:Array = mapForComboBox(Gills.Types, "id");
			addBeComboBox("Gills type", gillTypes,
					Gills.Types[player.gills.type],
					function (item:*):void {
						player.gills.type = item.data.value;
						dumpPlayerData();
					}
			);
			var beardStyles:Array = mapForComboBox(Beard.Types, "id");
			addBeComboBox("Beard style", beardStyles,
					Beard.Types[player.beardStyle],
					function (item:*):void {
						player.beardStyle = item.data.value;
						dumpPlayerData();
					}
			);
			addBeComboBox("Beard length", BEARD_LENGTH_CONSTANTS,
					player.beardLength,
					function (item:*):void {
						player.beardLength = item;
						dumpPlayerData();
					}
			);
			menu();
			dumpPlayerData();
			addButton(14, "Back", bodyPartEditorRoot);
		}
		private static const HORN_COUNT_CONSTANTS:Array = [
				0,1,2,3,4,
				5,6,8,10,12,
				16,20
		];
		private static const BEARD_LENGTH_CONSTANTS:Array = [
			0,0.1,0.3,2,4,
			8,12,16,32,64,
		];
		private function AlrauneDebug():void {
			outputText("\n\nSet all cocks to tentacle and lower body to alraune!");
			if (player.cocks.length > 0)
				player.killCocks(-1);
			if (player.cocks.length == 0) {
				if (player.hasBalls()) player.balls = 0;
				for (var i:int = 0; i<10; i++)
					transformations.CockStamen(i, 7 + rand(7), 1.5 + rand(10) / 10).applyEffect(false);
			}
			if (!player.hasStatusEffect(StatusEffects.AlrauneFlower)) player.createStatusEffect(StatusEffects.AlrauneFlower,0,0,0,0);
			if (player.wings.type == Wings.PLANT) player.wings.type = Wings.NONE;
			player.lowerBody = LowerBody.PLANT_FLOWER;
			player.legCount = 12;

		}
		private function bodyPartEditorTorso():void {
			clearBeElements();
			var armTypes:Array = mapForComboBox(Arms.Types, "id");
			addBeComboBox("Arm type", armTypes,
					Arms.Types[player.arms.type],
					function (item:*):void {
						player.arms.type = item.data.value;
						dumpPlayerData();
					}
			);
			var clawTypes:Array = mapForComboBox(Claws.Types, "id");
			addBeComboBox("Claw type", clawTypes,
					Claws.Types[player.clawsPart.type],
					function (item:*):void {
						player.clawsPart.type = item.data.value;
						dumpPlayerData();
					}
			);
			addBeComboBox("Claw color", COLOR_CONSTANTS,
					player.clawsPart.tone,
					function (item:*):void {
						player.clawsPart.tone = item;
						dumpPlayerData();
					}
			);
			var tailTypes:Array = mapForComboBox(Tail.Types, "id");
			addBeComboBox("Tail type", tailTypes,
					Tail.Types[player.tail.type],
					function (item:*):void {
						player.tail.type = item.data.value;
						dumpPlayerData();
					}
			);
			addBeComboBox("Tail count", TAIL_COUNT_CONSTANTS,
					player.tail.count,
					function (item:*):void {
						player.tail.count = item;
						dumpPlayerData();
					}
			);
			var wingTypes:Array = mapForComboBox(Wings.Types, "id");
			addBeComboBox("Wing type", wingTypes,
					Wings.Types[player.wings.type],
					function (item:*):void {
						player.wings.type = item.data.value;
						dumpPlayerData();
					}
			);
			addBeComboBox("Wing desc", WING_DESC_CONSTANTS,
					player.wings.desc,
					function (item:*):void {
						player.wings.desc = item;
						dumpPlayerData();
					}
			);
			var legTypes:Array = mapForComboBox(LowerBody.Types, "id");
			addBeComboBox("Lower body type", legTypes,
					LowerBody.Types[player.lowerBodyPart.type],
					function (item:*):void {
						player.lowerBodyPart.type = item.data.value;
						bodyPartEditorTorso();
					}
			);
			addBeComboBox("Leg count", LEG_COUNT_CONSTANTS,
					player.lowerBodyPart.legCount,
					function (item:*):void {
						player.lowerBodyPart.legCount = item;
						dumpPlayerData();
					}
			);
			var rearTypes:Array = mapForComboBox(RearBody.Types, "id");
			addBeComboBox("Rear body type", rearTypes,
					RearBody.Types[player.rearBody.type],
					function (item:*):void {
						player.rearBody.type = item.data.value;
						dumpPlayerData();
					}
			);
			menu();
			dumpPlayerData();
			addButton(14, "Back", bodyPartEditorRoot);
		}
		private static const TAIL_COUNT_CONSTANTS:Array = [
			0,1,2,3,4,
			5,6,7,8,9,
			10,16
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
		private static const LEG_COUNT_CONSTANTS:Array = [
			1,2,4,6,8,
			10,12,16
		];
		private function changeScorpionTail():void {
			clearOutput();
			outputText("<b>Your tail is now that of a scorpion's. Currently, scorpion tail has no use but it will eventually be useful for stinging.</b>");
			player.tailType = Tail.SCORPION;
			player.tailVenom = 100;
			player.tailRecharge = 5;
			doNext(styleHackMenu);
		}

		private function getManticoreKit():void {
			clearOutput();
			outputText("<b>You are now a Manticore!</b>");
			//Cat TF
			CoC.instance.transformations.FaceCat.applyEffect(false);
			player.ears.type = Ears.CAT;
			player.lowerBody = LowerBody.CAT;
			player.legCount = 2;
			player.skin.restore();
			CoC.instance.transformations.SkinFur().applyEffect(false);
			//Draconic TF
			player.horns.type = Horns.DRACONIC_X2;
			player.horns.count = 4;
			player.wings.type = Wings.BAT_LIKE_LARGE;
			//Scorpion TF
			player.tailType = Tail.MANTICORE_PUSSYTAIL;
			player.tailVenom = 100;
			player.tailRecharge = 5;
			doNext(styleHackMenu);
		}

		private function getDragonneKit():void {
			clearOutput();
			outputText("<b>You are now a Dragonne!</b>");
			//Cat TF
			CoC.instance.transformations.FaceCat.applyEffect(false);
			player.ears.type = Ears.CAT;
			player.tailType = Tail.CAT;
			player.lowerBody = LowerBody.CAT;
			player.legCount = 2;
			//Draconic TF
			player.skin.restore();
			CoC.instance.transformations.SkinScales().applyEffect(false);
			player.tongue.type = Tongue.DRACONIC;
			player.horns.type = Horns.DRACONIC_X2;
			player.horns.count = 4;
			player.wings.type = Wings.DRACONIC_LARGE;
			doNext(styleHackMenu);
		}

		private function toggleMeaninglessCorruption():void {
			clearOutput();
			if (flags[kFLAGS.CORRUPTION_TOLERANCE_MODE] == 0) {
				flags[kFLAGS.CORRUPTION_TOLERANCE_MODE] = 2;
				outputText("<b>Set CORRUPTION_TOLERANCE_MODE flag to 2.</b>");
			}
			else {
				flags[kFLAGS.CORRUPTION_TOLERANCE_MODE] = 0;
				outputText("<b>Set CORRUPTION_TOLERANCE_MODE flag to 0.</b>");
			}
		}

		private function resetNPCMenu():void {
			clearOutput();
			outputText("Which NPC would you like to reset?");
			menu();
			if (flags[kFLAGS.URTA_COMFORTABLE_WITH_OWN_BODY] < 0 || flags[kFLAGS.URTA_QUEST_STATUS] == -1) addButton(0, "Urta", resetUrta);
			if (JojoScene.monk >= 5 || flags[kFLAGS.JOJO_DEAD_OR_GONE] > 0) addButton(1, "Jojo", resetJojo);
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
			if (JojoScene.monk > 1) {
				outputText("Jojo is no longer corrupted!  ");
				JojoScene.monk = JojoScene.JOJO_NOT_MET;
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
			player.knockUpForce(0, 0, 1);
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
			lightsArray = [];

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
			lightsArray[slot] = !lightsArray[slot];

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
