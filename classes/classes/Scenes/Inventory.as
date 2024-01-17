/**
 * Created by aimozg on 12.01.14.
 */
package classes.Scenes
{
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.Items.Armor;
import classes.Items.Consumable;
import classes.Items.Equipable;
import classes.Items.FlyingSwordsLib;
import classes.Items.ItemConstants;
import classes.Items.Jewelry;
import classes.Items.Shield;
import classes.Items.Undergarment;
import classes.Items.Useable;
import classes.Items.VehiclesLib;
import classes.Items.Weapon;
import classes.Items.WeaponRange;
import classes.Scenes.Camp.Garden;
import classes.Scenes.Camp.UniqueCampScenes;
import classes.Scenes.NPCs.HolliPureScene;
import classes.Scenes.NPCs.MagnoliaFollower;
import classes.Scenes.Places.HeXinDao.AdventurerGuild;

import coc.view.ButtonDataList;
import coc.view.charview.DragButton;

use namespace CoC;

	public class Inventory extends BaseContent {
		private static const inventorySlotName:Array = ["first", "second", "third", "fourth", "fifth", "sixth", "seventh", "eighth", "ninth", "tenth", "eleventh", "twelfth", "thirteenth", "fourteenth", "fifteenth", "sixteenth", "seventeenth", "eighteenth", "nineteenth", "twentieth",
		"21th", "22th", "23th", "24th", "25th", "26th", "27th", "28th", "29th", "30th", "31th", "32th", "33th", "34th", "35th", "36th", "37th", "38th", "39th", "40th", "41th", "42th", "43th", "44th", "45th", "46th", "47th", "48th", "49th", "50th"];

		private var itemStorage:/*ItemSlotClass*/Array;
		private var pearlStorage:/*ItemSlotClass*/Array;
		private var gearStorage:/*ItemSlotClass*/Array;
		private static const GEAR_WEAPON_FROM:int = 0;
		private static const GEAR_WEAPON_TO:int = 9;
		private static const GEAR_ARMOR_FROM:int = 9;
		private static const GEAR_ARMOR_TO:int = 18;
		private static const GEAR_JEWELRY_FROM:int = 18;
		private static const GEAR_JEWELRY_TO:int = 27;
		private static const GEAR_DRESSER_FROM:int = 27;
		private static const GEAR_DRESSER_TO:int = 36;
		private static const GEAR_SHIELD_FROM:int = 36;
		private static const GEAR_SHIELD_TO:int = 45;
		private static const GEAR_BOC_FROM:int = 45;
		private static const GEAR_BOC_TO:int = 57;
		private static const GEAR_WAREHOUSE1_FROM:int = 57;
		private static const GEAR_WAREHOUSE1_TO:int = 69;
		private static const GEAR_GRANARY_FROM:int = 69;
		private static const GEAR_GRANARY_TO:int = 78;
		private static const GEAR_WAREHOUSE2_FROM:int = 78;
		private static const GEAR_WAREHOUSE2_TO:int = 90;
		private var callNext:Function;		//These are used so that we know what has to happen once the player finishes with an item
		private var callOnAbandon:Function;	//They simplify dealing with items that have a sub menu. Set in inventoryMenu and in takeItem
		private var currentItemSlot:ItemSlotClass;	//The slot previously occupied by the current item - only needed for stashes and items with a sub menu.
		private var maxSFCapacity:Number = 0;
		public var HolliPure:HolliPureScene = new HolliPureScene();
		public var Gardening:UniqueCampScenes = new UniqueCampScenes();
		public var Magnolia:MagnoliaFollower = new MagnoliaFollower();

		public function Inventory(saveSystem:Saves) {
			itemStorage = [];
			pearlStorage = [];
			gearStorage = [];
			saveSystem.linkToInventory(itemStorageDirectGet, pearlStorageDirectGet, gearStorageDirectGet);
		}
		
		public function pearlStorageSize():int {
			if (player.hasKeyItem("Sky Poison Pearl") < 0) return 0;
			var x:int = 14;
			var y:Number = 0;
			if (player.hasPerk(PerkLib.AscensionSkyPoisonPearlMasteryStageX)) y += (6 * player.perkv1(PerkLib.AscensionSkyPoisonPearlMasteryStageX));
			if (player.level >= (6 - y)) x += 14;
			if (player.level >= (12 - y)) x += 14;
			if (player.level >= (18 - y)) x += 14;
			if (player.level >= (24 - y)) x += 14;//129
			if (player.level >= (30 - y)) x += 14;//78 + 87 (165)
			if (player.level >= (36 - y)) x += 14;//96 + 105 (201)
			return Math.min(98, x);
		}

		public function showStash():Boolean {
			return player.hasKeyItem("Equipment Rack - Weapons") >= 0 || player.hasKeyItem("Equipment Rack - Armor") >= 0 || player.hasKeyItem("Equipment Rack - Shields") >= 0 || itemStorage.length > 0 || player.hasKeyItem("Equipment Storage - Jewelry Box") >= 0 || flags[kFLAGS.CAMP_CABIN_FURNITURE_DRESSER] > 0;
		}

		public function itemStorageDirectGet():Array { return itemStorage; }

		public function pearlStorageDirectGet():Array { return pearlStorage; }

		public function pearlStorageSlice():/*ItemSlotClass*/Array {
			return pearlStorage.slice(0, pearlStorageSize());
		}
		
		public function gearStorageDirectGet():Array { return gearStorage; }

//		public function currentCallNext():Function { return callNext; }

		public function itemGoNext():void { if (callNext != null) doNext(callNext); }

		public var returnFn:Function = null;
		public function showInventoryMenu(returnFn:Function = null):void {
			this.returnFn = returnFn;
			inventoryMenu();
		}
		public function inventoryMenu(page:int = 1):void {
			DragButton.setup(mainView, mainView.toolTipView);
			var x:int;
			//var foundItem:Boolean = false;
            if (CoC.instance.inCombat) {
				//Player will return to combat after item use
				callNext = function():void {
					returnFn = null;
					inventoryCombatHandler();
				}
			}
			else {
				spriteSelect(null);
				callNext = inventoryMenu; //In camp or in a dungeon player will return to inventory menu after item use
			}
			hideMenus();
			hideUpDown();
			clearOutput();
			mainView.linkHandler = showItemTooltipLinkHandler;
			EngineCore.displayHeader("Inventory");
			outputText("<b><u>Equipment:</u></b>\n");
			outputText("<b>Weapon (Melee):</b> "+mkLink(player.weapon.name, player.weapon.id)+" (Attack: " + player.weaponAttack + ")");
			if (player.isGauntletWeapon()) outputText(" (Gauntlet-type weapon)");
			if (player.isSwordTypeWeapon()) outputText(" (Sword-type weapon)");
			if (player.isAxeTypeWeapon()) outputText(" (Axe-type weapon)");
			if (player.isMaceHammerTypeWeapon()) outputText(" (Mace/Hammer-type weapon)");
			if (player.isDuelingTypeWeapon()) outputText(" (Dueling Sword-type weapon)");
			if (player.isSpearTypeWeapon()) outputText(" (Spear-type weapon)");
			if (player.isDaggerTypeWeapon()) outputText(" (Dagger-type weapon)");
			if (player.isWhipTypeWeapon()) outputText(" (Whip-type weapon)");
			if (player.isRibbonTypeWeapon()) outputText(" (Ribbon-type weapon)");
			if (player.isExoticTypeWeapon()) outputText(" (Exotic-type weapon)");
			outputText("\n");
			outputText("<b>Weapon (Range):</b> " + mkLink(player.weaponRange.name, player.weaponRange.id) + " (Attack: " + player.weaponRangeAttack + ")");
			if (player.weaponRangePerk == "Bow" || player.weaponRangePerk == "Crossbow") outputText(" (Bow/Crosbow-type weapon)");
			if (player.weaponRangePerk == "Throwing") outputText(" (Throwing weapon-type weapon)");
			if (player.isFirearmTypeWeapon()) outputText(" (Firearms-type weapon)");
			outputText("\n");
			outputText("<b>Shield:</b> " + mkLink(player.shield.name, player.shield.id) + " (Block Rating: " + player.shieldBlock + ")");
			if (player.shieldPerk == "Large") outputText(" (Large)");
			if (player.shieldPerk == "Massive") outputText(" (Massive)");
			outputText("\n");
			outputText("<b>Armour:</b> " + mkLink(player.armor.name, player.armor.id) + " (Physical / Magical Defense: " + player.armorDef + " / " + player.armorMDef + ")\n");
			outputText("<b>Upper underwear:</b> " + mkLink(player.upperGarment.name, player.upperGarment.id) + "\n");
			outputText("<b>Lower underwear:</b> " + mkLink(player.lowerGarment.name, player.lowerGarment.id) + "\n");
			outputText("<b>Head Accessory/Helm:</b> " + mkLink(player.headJewelry.name, player.headJewelry.id) + "\n");
			outputText("<b>Necklace:</b> " + mkLink(player.necklace.name, player.necklace.id) + "\n");
			outputText("<b>Ring (1st):</b> " + mkLink(player.jewelry1.name, player.jewelry1.id) + "\n");
			if (player.hasPerk(PerkLib.SecondRing)) outputText("<b>Ring (2nd):</b> " + mkLink(player.jewelry2.name, player.jewelry2.id) + "\n");
			else outputText("<b>Ring (2nd):</b> <i>LOCKED</i> (req. Second Ring perk)\n");
			if (player.hasPerk(PerkLib.ThirdRing)) outputText("<b>Ring (3rd):</b> " + mkLink(player.jewelry3.name, player.jewelry3.id) + "\n");
			else outputText("<b>Ring (3rd):</b> <i>LOCKED</i> (req. Third Ring perk)\n");
			if (player.hasPerk(PerkLib.FourthRing)) outputText("<b>Ring (4th):</b> " + mkLink(player.jewelry4.name, player.jewelry4.id) + "\n");
			else outputText("<b>Ring (4th):</b> <i>LOCKED</i> (req. Fourth Ring perk)\n");
			outputText("<b>Accessory (1st):</b> " + mkLink(player.miscJewelry1.name, player.miscJewelry1.id) + "\n");
			outputText("<b>Accessory (2nd):</b> " + mkLink(player.miscJewelry2.name, player.miscJewelry2.id) + "\n");
			if (player.hasPerk(PerkLib.FlyingSwordPath)) outputText("<b>Flying Sword:</b> " + mkLink(player.weaponFlyingSwords.name, player.weaponFlyingSwords.id) + "\n");
			else outputText("<b>Flying Sword:</b> <i>LOCKED</i> (req. Flying Swords Control perk)\n");
			outputText("<b>Vehicle:</b> " + mkLink(player.vehicles.name, player.vehicles.id) + "\n");
			if (player.hasKeyItem("Bag of Cosmos") >= 0 || player.hasKeyItem("Sky Poison Pearl") >= 0) {
				outputText("\n");
				if (player.hasKeyItem("Bag of Cosmos") >= 0) outputText("<i>At your belt hangs bag of cosmos.</i>\n");
				if (player.hasKeyItem("Sky Poison Pearl") >= 0) outputText("<i>There is a circular green imprint at the palm of your left hand.</i>\n");
			}
			outputText("\nWhich item will you use? (To discard unwanted items, hold Shift then click the item.)");
			outputText("\n<b>Capacity:</b> " + getOccupiedSlots() + " / " + getMaxSlots() + "\n");
			if (player.keyItems.length > 0) outputText("\n<b><u>Key Items:</u></b>\n");
			for (x = 0; x < player.keyItems.length; x++) outputText(player.keyItems[x].keyName + "\n");
			menu();
			if (page == 1) {
				for (x = 0; x < 10; x++) {
					if (player.itemSlots[x].unlocked && player.itemSlots[x].quantity > 0) {
						button(x).showForItemSlot(player.itemSlots[x], curry(doWhatWithItem, x));
						//foundItem = true;
					}
				}
				if (getMaxSlots() > 10) addButton(13, "Next", inventoryMenu, page + 1);
			}
			if (page == 2) {
				for (x = 10; x < 20; x++) {
					if (player.itemSlots[x].unlocked && player.itemSlots[x].quantity > 0) {
						button(x-10).showForItemSlot(player.itemSlots[x], curry(doWhatWithItem, x));
						//foundItem = true;
					}
				}
				//addButton(12, "Prev", inventoryMenu, page - 1);
				if (getMaxSlots() > 20) addButton(13, "Next", inventoryMenu, page + 1);
				else addButton(13, "Next", inventoryMenu, page - 1);
			}
			if (page == 3) {
				for (x = 20; x < 30; x++) {
					if (player.itemSlots[x].unlocked && player.itemSlots[x].quantity > 0) {
						button(x-20).showForItemSlot(player.itemSlots[x], curry(doWhatWithItem, x));
						//foundItem = true;
					}
				}
				//addButton(12, "Prev", inventoryMenu, page - 1);
				if (getMaxSlots() > 30) addButton(13, "Next", inventoryMenu, page + 1);
				else addButton(13, "Next", inventoryMenu, page - 2);
			}
			if (page == 4) {
				for (x = 30; x < 40; x++) {
					if (player.itemSlots[x].unlocked && player.itemSlots[x].quantity > 0) {
						button(x-30).showForItemSlot(player.itemSlots[x], curry(doWhatWithItem, x));
						//foundItem = true;
					}
				}
				//addButton(12, "Prev", inventoryMenu, page - 1);
				if (getMaxSlots() > 40) addButton(13, "Next", inventoryMenu, page + 1);
				else addButton(13, "Next", inventoryMenu, page - 3);
			}
			if (page == 5) {
				for (x = 40; x < 50; x++) {
					if (player.itemSlots[x].unlocked && player.itemSlots[x].quantity > 0) {
						button(x-40).showForItemSlot(player.itemSlots[x], curry(doWhatWithItem, x));
						//foundItem = true;
					}
				}
				//addButton(12, "Prev", inventoryMenu, page - 1);
				addButton(13, "Next", inventoryMenu, page - 4);
			}
            if (!CoC.instance.inCombat) {
                addButton(10, "Unequip/Misc", manageEquipmentmiscitemsMenu);
				if (player.hasKeyItem("Bag of Cosmos") >= 0) {
					if (player.hasPerk(PerkLib.Soulless)) addButtonDisabled(11, "Bag of Cosmos", "Without soul nor SF you can'y open Bag of Cosmos.");
					else addButton(11, "Bag of Cosmos", BagOfCosmosMenuv2);
				}
				if (player.hasKeyItem("Sky Poison Pearl") >= 0) {
					if (player.hasPerk(PerkLib.Soulless)) addButtonDisabled(12, "Sky P. Pearl", "Without soul nor SF you can't open Sky Poison Pearl.");
					else addButton(12, "Sky P. Pearl", SkyPoisonPearlMenuv2);
				}
			}
			//Button for alchemical items during combat
			if (CoC.instance.inCombat) {
				addButton(11, "Potions", SceneLib.garden.PotionMenu).disableIf(Garden.PotionsBagSlot01Cap == 0, "You not have any potions bag.");
			}
            if (CoC.instance.inCombat && player.hasStatusEffect(StatusEffects.Sealed) && player.statusEffectv1(StatusEffects.Sealed) == 3) {
				outputText("\nYou reach for your items, but you just can't get your pouches open.  <b>Your ability to use items was sealed, and now you've wasted a chance to attack!</b>\n\n");
				SceneLib.combat.enemyAIImpl();
				return;
			}
			addButton(14, "Back", returnFromInventory);
		}
		private function returnFromInventory():void {
			var returnFn:Function = this.returnFn;
			if (returnFn != null) {
				this.returnFn = null;
				returnFn();
				return;
			}
			if (CoC.instance.inCombat) SceneLib.combat.combatMenu(false);
			else playerMenu();
		}
		
		public function showItemTooltipLinkHandler(itemid:String):void {
			var item:ItemType = ItemType.lookupItem(itemid);
			if (item) {
				mainView.toolTipView.header = item.longName;
				mainView.toolTipView.text   = item.description;
				mainView.toolTipView.show(mainView.mouseX, mainView.mouseY, 0, 0);
			}
		}

		public function manageEquipmentmiscitemsMenu():void {
			menu();
			if (!inDungeon && !inRoomedDungeon && !flags[kFLAGS.IN_INGNAM]) {
				var miscNieve:Boolean = Holidays.nieveHoliday() && flags[kFLAGS.NIEVE_STAGE] > 0 && flags[kFLAGS.NIEVE_STAGE] < 5;
                var miscHolli:Boolean = flags[kFLAGS.FUCK_FLOWER_KILLED] == 0 && (flags[kFLAGS.FUCK_FLOWER_LEVEL] >= 1 && flags[kFLAGS.FUCK_FLOWER_LEVEL] < 4 || flags[kFLAGS.FLOWER_LEVEL] >= 1 && flags[kFLAGS.FLOWER_LEVEL] < 4);
				if (miscNieve || miscHolli || player.hasKeyItem("Dragon Egg") >= 0 || (player.hasKeyItem("Rathazul's Purity Elixir") >= 0 && player.perkv1(PerkLib.PurityElixir) < 5)
					|| flags[kFLAGS.ANEMONE_KID] > 0 || flags[kFLAGS.ALRAUNE_SEEDS] > 0 || (flags[kFLAGS.CHRISTMAS_TREE_LEVEL] > 0 && flags[kFLAGS.CHRISTMAS_TREE_LEVEL] < 8)) {
					if (miscNieve) {
						if (flags[kFLAGS.NIEVE_STAGE] == 1)
							outputText("\nThere's some odd snow here that you could do something with...\n");
                        else outputText("\nYou have a snow" + Holidays.nieveMF("man", "woman") + " here that seems like it could use a little something...\n");
                    }
					if (player.hasKeyItem("Dragon Egg") >= 0) {
                        SceneLib.emberScene.emberCampDesc();
						addButton(3, "Egg", SceneLib.emberScene.emberEggInteraction);
					}
					if (flags[kFLAGS.ANEMONE_KID] > 0) {
						SceneLib.kidAScene.anemoneBarrelDescription();
						if (model.time.hours >= 6) addButton(4, "Anemone", SceneLib.kidAScene.approachAnemoneBarrel);
					}
					if (flags[kFLAGS.ALRAUNE_SEEDS] > 0) {
						outputText("\nYou have " + flags[kFLAGS.ALRAUNE_SEEDS] + " alraune seeds planted in your garden.");
						if (flags[kFLAGS.ALRAUNE_GROWING] > 14) outputText(" Some have already grown to adulthood.");
						outputText("\n");
					}
					if (Holidays.nieveHoliday()) {
						if (flags[kFLAGS.NIEVE_STAGE] > 0 && flags[kFLAGS.NIEVE_STAGE] < 5) addButton(1, "Snow", SceneLib.holidays.nieveBuilding);
						if (flags[kFLAGS.CHRISTMAS_TREE_LEVEL] == 1 && player.hasKeyItem("Mysterious Seed") >= 0) addButton(7, "Mysterious Seed", Magnolia.treeMenu);
						if (flags[kFLAGS.CHRISTMAS_TREE_LEVEL] > 2 && flags[kFLAGS.CHRISTMAS_TREE_LEVEL] < 9) {
							if (flags[kFLAGS.CHRISTMAS_TREE_LEVEL] == 7 && player.hasKeyItem("Decorations") >= 0) addButton(7, "Decorate Tree", Magnolia.treeMenu);
							else addButton(7, (flags[kFLAGS.CHRISTMAS_TREE_LEVEL] >= 8 ? "Ch. Tree" : "Green Tree"), Magnolia.treeMenu);
						}
					}
					if (flags[kFLAGS.FUCK_FLOWER_KILLED] == 0 && flags[kFLAGS.FUCK_FLOWER_LEVEL] >= 1 && flags[kFLAGS.FUCK_FLOWER_LEVEL] < 4) addButton(2, (flags[kFLAGS.FUCK_FLOWER_LEVEL] >= 3 ? "Tree" : "Plant"), SceneLib.holliScene.treeMenu);
					if (flags[kFLAGS.FUCK_FLOWER_KILLED] == 0 && flags[kFLAGS.FLOWER_LEVEL] >= 1 && flags[kFLAGS.FLOWER_LEVEL] < 4) addButton(2, (flags[kFLAGS.FLOWER_LEVEL] >= 3 ? "Tree" : "Plant"), HolliPure.treeMenu);
					if (flags[kFLAGS.ALRAUNE_SEEDS] > 0 && model.time.hours >= 6) addButton(0, "Garden", Gardening.manageyourgarden).hint("Visit your plant offspring");
					if (player.hasKeyItem("Rathazul's Purity Elixir") >= 0 && player.perkv1(PerkLib.PurityElixir) < 5) addButton(9, "PurityElixir", PurityElixir);
				}
			}
			addButton(10, "Unequip", manageEquipment);
			if (player.isInAyoArmor()) addButton(11, "Ayo Armors", AyoArmorsMaintance);
			else addButtonDisabled(11, "Ayo Armors", "You need to wear any type of Ayo Armor to use this option.");
			addButton(14, "Back", inventoryMenu);
		}

		private function PurityElixir():void {
            clearOutput();
            if (player.getAllMinStats().cor == 0) {
                outputText("You take out the elixir, but reconsider. ");
                if (player.cor > 0) outputText("All of your corruption can be removed using simpler methods.");
                else outputText("You're completely pure!");
                outputText("\n\nYou decide to leave the elixir for worse times.");
            }
            else {
                outputText("You feel something unlock within you as you drink the elixir, some of the veil of corruption being washed out of you as the liquid undo and counteract some of the vile demonic changes your body was afflicted with.");
                outputText("\n\n<b>Minimum corruption lowered!</b>");
                if (player.keyItemvX("Rathazul's Purity Elixir", 1) > 1) player.addKeyValue("Rathazul's Purity Elixir", 1, -1);
                else player.removeKeyItem("Rathazul's Purity Elixir");
                if (player.hasPerk(PerkLib.PurityElixir)) player.addPerkValue(PerkLib.PurityElixir, 1, 1);
                else player.createPerk(PerkLib.PurityElixir, 1, 0, 0, 0);
            }
			doNext(inventoryMenu);
		}
		
		public function AyoArmorsMaintance():void {
			clearOutput();
			var currentArmorSFDrainrate:Number = 0;
			if (player.armor == armors.LAYOARM) currentArmorSFDrainrate += 60;
			if (player.armor == armors.HAYOARM) currentArmorSFDrainrate += 120;
			if (player.armor == armors.UHAYOARM) currentArmorSFDrainrate += 240;
			if (player.armor == armors.HBARMOR) currentArmorSFDrainrate += 180;
			if (player.vehicles == vehicles.HB_MECH) {
				if (player.hasKeyItem("HB Internal Systems") >= 0) {
					if (player.keyItemvX("HB Internal Systems", 1) == 2) currentArmorSFDrainrate += 40;
					else currentArmorSFDrainrate += 50;
				}
				else currentArmorSFDrainrate += 60;
			}
			maxSFCapacity = 0;
			if (player.armor == armors.LAYOARM) maxSFCapacity += 1500;
			if (player.armor == armors.HAYOARM) maxSFCapacity += 3000;
			if (player.armor == armors.UHAYOARM) maxSFCapacity += 6000;
			if (player.armor == armors.HBARMOR) {
				maxSFCapacity += 4500;
				if (player.headJewelry == headjewelries.HBHELM) maxSFCapacity += 900;
			}
			if (player.upperGarment == undergarments.HBSHIRT) maxSFCapacity += 350;
			if (player.lowerGarment == undergarments.HBSHORT) maxSFCapacity += 350;
			if (player.vehicles == vehicles.HB_MECH) {
				maxSFCapacity += 1000;
				if (player.hasKeyItem("HB Internal Systems") >= 0) {
					if (player.keyItemvX("HB Internal Systems", 1) == 2) maxSFCapacity += 5000;
					else maxSFCapacity += 2000;
				}
			}
			//if (player.vehicles == vehicles.HB_MECH) maxSFCapacity += 1000;
			outputText("Currently used Ayo Armor name: "+player.armorName+"\n\n");
			outputText("Currently used Ayo Armor soulforce drain rate (per hour): "+currentArmorSFDrainrate+"\n\n");
			outputText("Soulforce reserves in armor: "+flags[kFLAGS.SOULFORCE_STORED_IN_AYO_ARMOR]+" / "+maxSFCapacity+"\n\n");
			menu();
			var btn:int = 0;
			for each (var amnt:int in [50, 100, 200, 500])
				addButton(btn++, "Charge " + amnt, AyoArmorRecharge, amnt)
					.disableIf(player.soulforce < amnt, "Your current soulforce is too low.");
			addButton(btn++, "Full Charge", AyoArmorRecharge, -1)
				.disableIf(player.soulforce <= 0, "You don't have any soulforce at all!");
			addButton(10, "Power UP", AyoArmorPowerUP).hint("Activate Ayo Armor (increases strength and speed)")
				.disableIf(flags[kFLAGS.SOULFORCE_STORED_IN_AYO_ARMOR] == 0,
					"You need to charge your Ayo Armor with Soulforce before using Power UP function.");
			addButton(14, "Back", inventoryMenu);
		}

		public function AyoArmorRecharge(amnt:int):void {
			clearOutput();
			if (amnt < 0) amnt = player.soulforce;
			amnt = Math.min(amnt, maxSFCapacity - flags[kFLAGS.SOULFORCE_STORED_IN_AYO_ARMOR]);
			outputText("You focus on your spiritual power and guide it to armor energy storages recharging it for "+amnt+" soulforce.");
			flags[kFLAGS.SOULFORCE_STORED_IN_AYO_ARMOR] += amnt;
			EngineCore.SoulforceChange(-amnt);
			doNext(AyoArmorsMaintance);
		}

		public function AyoArmorPowerUP():void {
			clearOutput();
			var oldHPratio:Number = player.hp100/100;
			player.buff("Ayo Armor").remove();
			outputText("You pressing button placed on side of chest part of armor, activating it. With a silent hiss armor activate making you feel faster and stronger."+(silly()?" You have come here to chew bubblegum and kick ass...and you're all out of bubblegum.":"")+"");
			if (player.armor == armors.LAYOARM) player.buff("Ayo Armor").addStats( {"str.mult":0.10, "spe.mult":0.10} );
			if (player.armor == armors.HAYOARM) player.buff("Ayo Armor").addStats( {"str.mult":0.20, "spe.mult":0.20} );
			if (player.armor == armors.UHAYOARM) player.buff("Ayo Armor").addStats( {"str.mult":0.40, "spe.mult":0.30, "tou.mult":0.10} );
			if (player.armor == armors.HBARMOR) player.buff("Ayo Armor").addStats( {"str.mult":0.18, "spe.mult":0.60} );
			player.HP = oldHPratio*player.maxHP();
			statScreenRefresh();
			doNext(AyoArmorsMaintance);
		}

		public function BagOfCosmosMenuv2():void{
			transferMenu(gearStorage, GEAR_BOC_FROM, GEAR_BOC_TO, inventoryMenu, "BagofCosmos");
		}

		public function SkyPoisonPearlMenuv2():void{
			transferMenu(pearlStorage, 0, pearlStorageSize(), inventoryMenu, "S. P. Pearl");
		}

		public function transferMenu(
				storage:/*ItemSlotClass*/Array,
				startInclusive:int,
				endExclusive:int,
				backFn:Function,
				storageName:String = "Storage",
				itemTypeFilter:Function = null,
				canTake:Boolean = true,
				canStore:Boolean = true
		):void {
			DragButton.setup(mainView, mainView.toolTipView);
			function fromStorage(i:int):void {
				var storageSlot:ItemSlotClass = storage[i];
				if (storageSlot.isEmpty()) return;
				if (transferOneItemToPlayer(storageSlot)) {
					if (shiftKeyDown && storageSlot.quantity > 0) {
						fromStorage(i);
					} else {
						show();
					}
				}
			}
			function toStorage(i:int):void {
				var playerSlot:ItemSlotClass = player.itemSlots[i];
				if (playerSlot.isEmpty() || itemTypeFilter != null && !itemTypeFilter(playerSlot.itype)) return;
				if (transferOneItemToStorage(playerSlot, storage, startInclusive, endExclusive, storageName)) {
					if (shiftKeyDown && playerSlot.quantity > 0) {
						toStorage(i);
					} else {
						show();
					}
				}
			}
			function storeAll():void {
				for each (var playerSlot:ItemSlotClass in player.itemSlots) {
					if (itemTypeFilter != null && !itemTypeFilter(playerSlot.itype)) return;
					while (playerSlot.quantity > 0) {
						if (!transferOneItemToStorage(playerSlot, storage, startInclusive, endExclusive, storageName)) break;
					}
				}
				show();
			}
			function takeAll():void {
				for (var i:int = startInclusive; i < endExclusive; i++) {
					var storageSlot:ItemSlotClass = storage[i];
					while (storageSlot.quantity > 0) {
						if (!transferOneItemToPlayer(storageSlot)) break;
					}
				}
				show();
			}
			function findSameInStorage(playerSlot:ItemSlotClass):ItemSlotClass {
				for (var i:int = startInclusive; i < endExclusive; i++) {
					var storageSlot:ItemSlotClass = storage[i];
					if (storageSlot.quantity > 0 && storageSlot.itype == playerSlot.itype) return storageSlot;
				}
				return null;
			}
			function restock():void {
				for each (var playerSlot:ItemSlotClass in player.itemSlots) {
					if (!playerSlot.unlocked || playerSlot.quantity == 0) continue;
					while (playerSlot.quantity < playerSlot.itype.stackSize) {
						var storageSlot:ItemSlotClass = findSameInStorage(playerSlot);
						if (!storageSlot) break;
						storageSlot.removeOneItem();
						playerSlot.quantity++;
					}
				}
				show();
			}
			function drop():void {
				for each (var playerSlot:ItemSlotClass in player.itemSlots) {
					if (!playerSlot.unlocked || playerSlot.quantity == 0) continue;
					if (!findSameInStorage(playerSlot)) continue;
					while (playerSlot.quantity > 0) {
						if (!transferOneItemToStorage(playerSlot, storage, startInclusive, endExclusive, storageName)) break;
					}
				}
				show();
			}
			function sortStorage():void {
				// Sort
				var temp:/*ItemSlotClass*/Array = sortedBy(storage.slice(startInclusive, endExclusive),
						function(e:ItemSlotClass):String {
							return e.quantity > 0 ? e.itype.shortName : "\uffff"
						}).map(varargify(function(e:ItemSlotClass):ItemSlotClass {
							return e.clone();
						}));
				var i:int;
				for (i = 0; i<temp.length; i++) {
					storage[startInclusive+i].setItemAndQty(temp[i].itype, temp[i].quantity);
				}
				
				// Compact neighbouring cells, moving everything to the left
				var ref:int=startInclusive;
				for (i = startInclusive+1; i < endExclusive; i++) {
					var slot:ItemSlotClass = storage[i];
					var refslot:ItemSlotClass = storage[ref];
					var itype:ItemType = slot.itype;
					var room:int = itype.stackSize - refslot.quantity;
					if (refslot.isEmpty() || itype != refslot.itype) {
						ref = i;
						continue;
					}
					// refslot and slot contain same item, and refslot has free space
					var n:int = Math.min(room, slot.quantity);
					if (n > 0) {
						refslot.quantity += n;
						slot.quantity -= n;
					}
					if (!refslot.hasRoom() && slot.quantity > 0) {
						// refslot is full but there's more items in slot
						// ex. ref=[4] [1] slot=[3] -> ref=[5] [1] slot=[2]
						// try move refslot to next
						if (ref + 1 < i) {
							ref++;
							i--; // to repeat the iteration
						}
					}
				}
				
				// Fill empty cells
				var d:int = 0; // number of empty cells, move all non-empty <d> cells to the left
				for (i = startInclusive+1; i < endExclusive; i++) {
					slot = storage[i];
					if (slot.isEmpty()) {
						d++;
					} else if (d>0) {
						storage[i-d].setItemAndQty(slot.itype, slot.quantity);
						slot.emptySlot();
					}
				}
				
				show();
			}
			
			// 5 rows: player inventory
			// 1 row : player inventory pages
			// 1 row : spacer
			// 5 rows: storage
			// 1 row : storage pages
			var playerItemCount:int = player.itemSlotCount();
			var storageItemCount:int = endExclusive - startInclusive;
			var N:int           = 25;
			var playerPage:int  = 0;
			var storagePage:int = 0;
			var freeRows:int;
			if (storageItemCount < N && playerItemCount > N) {
				// add more rows for player using storage rows
				freeRows = 6 - (storageItemCount + 4) / 5;
				N += freeRows*5;
			}
			if (playerItemCount < N && storageItemCount > N) {
				// add more rows for storage using player rows
				freeRows = 6 - (playerItemCount + 4) / 5;
				N += freeRows*5;
			}
			var playerPageMax:int = Math.max(0, Math.ceil(playerItemCount / N));
			var storagePageMax:int = Math.max(0, Math.ceil(storageItemCount / N));
			
			function show():void {
				var i:int;
				var n:int;
				hideMenus();
				clearOutput();
				outputText("<i>(Shift+click to transfer full stack)</i>\n");
				outputText("Inventory: ");
				menu();
				var bd:ButtonDataList = new ButtonDataList();
				
				// Player inventory
				n = Math.min((playerPage+1)*N, playerItemCount);
				for (i = playerPage*N; i < n; i++) {
					var playerSlot:ItemSlotClass = player.itemSlots[i];
					bd.add("Put", curry(toStorage, i))
							.forItemSlot(playerSlot)
							.drag(playerSlot, itemTypeFilter)
							.disableIf(itemTypeFilter != null && !itemTypeFilter(playerSlot.itype))
							.disableIf(playerSlot.isEmpty())
							.disableIf(!canStore);
				}
				while (bd.length%5 > 0) bd.add(""); // Padding
				if (playerPageMax > 0) {
					bd.add("Prev", function ():void {
						playerPage--;
						show();
					}).hint("Prev inventory page").disableIf(playerPage == 0).icon("Left")
					bd.add("");
					bd.add("");
					bd.add("");
					bd.add("Next", function ():void {
						playerPage++;
						show();
					}).hint("Next inventory page").disableIf(playerPage == playerPageMax-1).icon("Right")
				}
				
				// Spacer
				bd.add(storageName+":").extra("text");
				for (i=1; i<5; i++) bd.add("");
				
				// Storage
				n = Math.min(startInclusive+(storagePage+1)*N, endExclusive);
				for (i = startInclusive+storagePage*N; i < n; i++) {
					var storageSlot:ItemSlotClass = storage[i];
					bd.add("Take", curry(fromStorage, i))
							.forItemSlot(storageSlot).drag(storageSlot, itemTypeFilter)
							.disableIf(storageSlot.isEmpty())
							.disableIf(!canTake);
				}
				while (bd.length%5 > 0) bd.add(""); // Padding
				if (storagePageMax > 0) {
					bd.add("Prev", function ():void {
						storagePage--;
						show();
					}).hint("Prev storage page").disableIf(storagePage == 0).icon("Left")
					bd.add("");
					bd.add("");
					bd.add("");
					bd.add("Next", function ():void {
						storagePage++;
						show();
					}).hint("Next storage page").disableIf(storagePage == storagePageMax-1).icon("Right")
				}
				
				bigButtonGrid(bd);
				if (canStore) addButton(0, "Store All", storeAll).hint("Move all items from your inventory to the storage");
				if (canTake) addButton(1, "Take All", takeAll).hint("Take all items from the storage to your inventory");
				if (canStore) addButton(4, "Sort storage", sortStorage).hint("Sort and compact the storage");
				if (canStore) addButton(5, "Drop", drop).hint("Move from your inventory items of types that are already in storage");
				if (canTake) addButton(6, "Restock", restock).hint("Refill items in your inventory from the storage to max. stack size");
				
				addButton(14, "Back", backFn).icon("Back");
			}
			
			show();
		}
		
		public function stash():void {
			hideMenus();
			clearOutput();
			spriteSelect(null);
			menu();

			if (player.hasKeyItem("Camp - Chest") >= 0 || player.hasKeyItem("Camp - Murky Chest") >= 0 || player.hasKeyItem("Camp - Ornate Chest") >= 0) {
				var chestArray:Array = [];
				if (player.hasKeyItem("Camp - Chest") >= 0) chestArray.push("a large wood and iron chest");
				if (player.hasKeyItem("Camp - Murky Chest") >= 0) chestArray.push("a medium damp chest");
				if (player.hasKeyItem("Camp - Ornate Chest") >= 0) chestArray.push("a medium gilded chest");
				outputText("You have " + formatStringArray(chestArray) + " to help store excess items located ");
				if (camp.homeDesc() == "cabin") outputText("inside your cabin");
				else outputText("near the portal entrance");
				outputText(".\n\n");
				addButton(0, "Chest", curry(transferMenu, itemStorage, 0, itemStorage.length, stash, "Chest"));
			}
			//Jewelry box
			if(player.hasKeyItem("Equipment Storage - Jewelry Box") >= 0) {
				outputText("Your jewelry box is located ");
				if (flags[kFLAGS.CAMP_BUILT_CABIN] > 0 && flags[kFLAGS.CAMP_CABIN_FURNITURE_BED])
				{
					if (flags[kFLAGS.CAMP_CABIN_FURNITURE_DRESSER]) outputText("on your dresser inside your cabin.");
					else
					{
						if (flags[kFLAGS.CAMP_CABIN_FURNITURE_NIGHTSTAND]) outputText("on your nightstand inside your cabin.");
						else  outputText("under your bed inside your cabin.");
					}
				}
				else outputText("next to your bedroll.");
				addButton(1, "J.Box", curry(transferMenu, gearStorage, GEAR_JEWELRY_FROM, GEAR_JEWELRY_TO, stash, "Jewelry box", jewelryAcceptable));
				outputText("\n\n");
			}
			//Dresser
			if (flags[kFLAGS.CAMP_CABIN_FURNITURE_DRESSER] > 0) {
				outputText("You have a dresser inside your cabin to store nine different types of undergarments.\n\n");
				addButton(2, "Dresser", curry(transferMenu, gearStorage, GEAR_DRESSER_FROM, GEAR_DRESSER_TO, stash, "Dresser", undergarmentAcceptable));
			}
			if (flags[kFLAGS.CAMP_UPGRADES_WAREHOUSE_GRANARY] < 2) {
			//Weapon Rack
			if (player.hasKeyItem("Equipment Rack - Weapons") >= 0) {
				outputText("There's a weapon rack set up here, able to hold up to nine various weapons.\n\n");
				addButton(3, "W.Rack", curry(transferMenu, gearStorage, GEAR_WEAPON_FROM, GEAR_WEAPON_TO, stash, "Weapon rack", weaponAcceptable));
			}
			//Armor Rack
			if(player.hasKeyItem("Equipment Rack - Armor") >= 0) {
				outputText("Your camp has an armor rack set up to hold your various sets of gear.  It appears to be able to hold nine different types of armor.\n\n");
				addButton(4, "A.Rack", curry(transferMenu, gearStorage, GEAR_ARMOR_FROM, GEAR_ARMOR_TO, stash, "Armor rack", armorAcceptable));
			}
			//Shield Rack
			if(player.hasKeyItem("Equipment Rack - Shields") >= 0) {
				outputText("There's a shield rack set up here, set up to hold up to nine various shields.\n\n");
				addButton(5, "S.Rack", curry(transferMenu, gearStorage, GEAR_SHIELD_FROM, GEAR_SHIELD_TO, stash, "Shield rack", shieldAcceptable));
			}
			}
			addButton(14, "Back", playerMenu);
		}

		public function warehouse():void {
			hideMenus();
			clearOutput();
			spriteSelect(null);
			menu();
			outputText("You walk inside your warehouse");
			if (flags[kFLAGS.CAMP_UPGRADES_WAREHOUSE_GRANARY] >= 2 && flags[kFLAGS.CAMP_UPGRADES_WAREHOUSE_GRANARY] < 4) outputText(", looking at the goods stored inside.");
			else if (flags[kFLAGS.CAMP_UPGRADES_WAREHOUSE_GRANARY] >= 4 && flags[kFLAGS.CAMP_UPGRADES_WAREHOUSE_GRANARY] < 6) outputText(" and connected to it medium-sized granary looking at the goods and food stored inside.");
			else if (flags[kFLAGS.CAMP_UPGRADES_WAREHOUSE_GRANARY] == 6) outputText("s and connecting them medium-sized granary looking at the goods and food stored inside.");
			outputText("\n\n");
			//Warehouse part 1 and 2
			if (flags[kFLAGS.CAMP_UPGRADES_WAREHOUSE_GRANARY] >= 2)
				addButton(0, "Warehouse 1", curry(transferMenu, gearStorage, GEAR_WAREHOUSE1_FROM, GEAR_WAREHOUSE1_TO, warehouse, "Warehouse 1"));
			if (flags[kFLAGS.CAMP_UPGRADES_WAREHOUSE_GRANARY] >= 6)
				addButton(1, "Warehouse 2", curry(transferMenu, gearStorage, GEAR_WAREHOUSE2_FROM, GEAR_WAREHOUSE2_TO, warehouse, "Warehouse 2"));
			//Granary
			if (flags[kFLAGS.CAMP_UPGRADES_WAREHOUSE_GRANARY] >= 4)
				addButton(2, "Granary", curry(transferMenu, gearStorage, GEAR_GRANARY_FROM, GEAR_GRANARY_TO, warehouse, "Granary", consumableAcceptable));
			//Weapon Rack
			if (player.hasKeyItem("Equipment Rack - Weapons") >= 0) {
				outputText("There's a weapon rack set up here, able to hold up to nine various weapons.\n\n");
				addButton(3, "W.Rack", curry(transferMenu, gearStorage, GEAR_WEAPON_FROM, GEAR_WEAPON_TO, warehouse, "Weapon rack", weaponAcceptable));
			}
			//Armor Rack
			if(player.hasKeyItem("Equipment Rack - Armor") >= 0) {
				outputText("Your camp has an armor rack set up to hold your various sets of gear.  It appears to be able to hold nine different types of armor.\n\n");
				addButton(4, "A.Rack", curry(transferMenu, gearStorage, GEAR_ARMOR_FROM, GEAR_ARMOR_TO, warehouse, "Armor rack", armorAcceptable));
			}
			//Shield Rack
			if(player.hasKeyItem("Equipment Rack - Shields") >= 0) {
				outputText("There's a shield rack set up here, set up to hold up to nine various shields.\n\n");
				addButton(5, "S.Rack", curry(transferMenu, gearStorage, GEAR_SHIELD_FROM, GEAR_SHIELD_TO, warehouse, "Shield rack", shieldAcceptable));
			}
			addButton(14, "Back", playerMenu);
		}
		/**
		 * Tries to add 1 item to player. Does not produce any output.
		 * @param itype
		 * @return 0: not transfered, 1: added to existing stack, 2: added to empty stack
		 */
		public function tryAddItemToPlayer(itype:ItemType):int {
			var i:int = player.roomInExistingStack(itype);
			if (i >= 0) {
				player.itemSlots[i].quantity++;
				return 1;
			}
			i = player.emptySlot();
			if (i >= 0) {
				player.itemSlots[i].setItemAndQty(itype, 1);
				return 2;
			}
			return 0;
		}
		/**
		 * Tries to add `qty` items to player. Does not produce any output. Halts when out of inventory space
		 * @return Number of items added
		 */
		public function tryAddMultipleItemsToPlayer(itype:ItemType, qty:int):int {
			var n:int = 0;
			while (qty-->0) {
				if (tryAddItemToPlayer(itype) == 0) break;
				n++;
			}
			return n
		}
		/**
		 * Tries to transfer 1 item from [source], reducing its quantity, to player.
		 * Does not produce any output.
		 * @param source
		 * @return 0: not transfered, 1: added to existing stack, 2: added to empty stack
		 */
		public function transferOneItemToPlayer(source:ItemSlotClass):int {
			var i:int = tryAddItemToPlayer(source.itype);
			if (i > 0) {
				source.removeOneItem()
			}
			return i;
		}
		public function tryAddOneItemToPearl(itype:ItemType):int {
			return tryAddOneItemToStorage(itype, pearlStorage, 0, pearlStorageSize(), "S.P.Pearl");
		}
		/**
		 * Tries to add 1 item to storage.
		 * Does not produce any output.
		 * @param source
		 * @return 0: not transfered, 1: added to existing stack, 2: added to empty stack
		 */
		public function tryAddOneItemToStorage(itype:ItemType, storage:/*ItemSlotClass*/Array, startInclusive:int, endExclusive:int, storageName:String):int {
			var empty:int = -1;
			var existing:int = -1;
			for (var i:int = startInclusive; i < endExclusive; i++) {
				var slot:ItemSlotClass = storage[i];
				//if (!slot.unlocked) continue;
				if (empty < 0 && slot.quantity == 0) empty = i;
				if (existing < 0 && slot.itype == itype && slot.hasRoom()) {
					existing = i;
					break;
				}
			}
			if (existing >= 0) {
				storage[existing].quantity++;
				return 1;
			}
			if (empty >= 0) {
				storage[empty].setItemAndQty(itype, 1);
				return 2;
			}
			return 0;
		}
		/**
		 * Tries to transfer 1 item from [source], reducing its quantity, to storage.
		 * Does not produce any output.
		 * @param source
		 * @return 0: not transfered, 1: added to existing stack, 2: added to empty stack
		 */
		public function transferOneItemToStorage(source:ItemSlotClass, storage:/*ItemSlotClass*/Array, startInclusive:int, endExclusive:int, storageName:String):int {
			var i:int = tryAddOneItemToStorage(source.itype, storage, startInclusive, endExclusive, storageName);
			if (i > 0) {
				source.removeOneItem();
			}
			return i;
		}
		
		public function takeItem(itype:ItemType,
								 nextAction:Function,
								 overrideAbandon:Function = null,
								 source:ItemSlotClass = null):void {
			if (itype == null) {
				CoC_Settings.error("takeItem(null)");
				return;
			}
			if (nextAction != null) {
				if (nextAction != callNext) callNext = nextAction;
			} else {
				callNext = playerMenu;
			}
			if (itype.isNothing) {
				itemGoNext();
				return;
			}
			//Check for an existing stack with room in the inventory and return the value for it.
			var temp:int = player.roomInExistingStack(itype);
			if (temp >= 0) { //First slot go!
				player.itemSlots[temp].quantity++;
				outputText("You place " + itype.longName + " in your " + inventorySlotName[temp] + " pouch, giving you " + player.itemSlots[temp].quantity + " of them.");
				itemGoNext();
				return;
			}
			//Check for room in Ore bag and return the itemcount for it.
			if (InCollection(itype, useables.COP_ORE, useables.TIN_ORE, useables.BRONZEB, useables.IRONORE, useables.EBONING, useables.MOONSTO) && nextAction != SceneLib.crafting.accessCraftingMaterialsBag) {
				temp = SceneLib.crafting.roomForMaterial(itype);
				if (temp >= 0) {
					SceneLib.crafting.placeMaterialInBag(itype);
					outputText("You place " + itype.longName + " in your Ore bag, giving you "+ (temp+1) +" of them.");
					itemGoNext();
					return;
				}
			}
			//Check for room in Guild quest bag and return the itemcount for it.
			if (nextAction != SceneLib.adventureGuild.questItemsBag) {
				if (AdventurerGuild.lootBag.addItem(itype, 1) == 1) {
					outputText("You place " + itype.longName + " in your quest materials pouch, giving you " + AdventurerGuild.lootBag.itemCount(itype) + " of them.");
					itemGoNext();
					return;
				}
			}
			//Check for room in Guild quest bag and return the itemcount for it.
			if (InCollection(itype, useables.GOLCORE) && nextAction != SceneLib.camp.campMake.accessMakeWinionsMainMenu) {
				temp = (flags[kFLAGS.REUSABLE_GOLEM_CORES_BAG] < SceneLib.camp.campMake.maxReusableGolemCoresBagSize() ? flags[kFLAGS.REUSABLE_GOLEM_CORES_BAG]:-1);
				if (temp >= 0) {
					flags[kFLAGS.REUSABLE_GOLEM_CORES_BAG]++;
					outputText("You place " + itype.longName + " in your Golem Core bag, giving you "+ (temp+1) +" of them.");
					itemGoNext();
					return;
				}
			}
			//If not done, then put it in an empty spot!
			//Throw in slot 1 if there is room
			temp = player.emptySlot();
			if (temp >= 0) {
				player.itemSlots[temp].setItemAndQty(itype, 1);
				outputText("You place " + itype.longName + " in your " + inventorySlotName[temp] + " pouch.");
				itemGoNext();
				return;
			}
			if (overrideAbandon != null) //callOnAbandon only becomes important if the inventory is full
				callOnAbandon = overrideAbandon;
			else callOnAbandon = callNext;
			//OH NOES! No room! Call replacer functions!
			takeItemFull(itype, true, source);
		}

		public function returnItemToInventory(item:Useable, showNext:Boolean = true):void { //Used only by items that have a sub menu if the player cancels
			if (!debug) {
				if (currentItemSlot == null) {
					takeItem(item, callNext, callNext, null); //Give player another chance to put item in inventory
				}
				else if (currentItemSlot.quantity > 0) { //Add it back to the existing stack
					currentItemSlot.quantity++;
				}
				else { //Put it back in the slot it came from
					currentItemSlot.setItemAndQty(item, 1);
				}
			}
            if (CoC.instance.inCombat) {
                enemyAI();
				return;
			}
			if (showNext)
				doNext(callNext); //Items with sub menus should return to the inventory screen if the player decides not to use them
			else callNext(); //When putting items back in your stash we should skip to the take from stash menu
		}

		//Check to see if anything is stored
		public function hasItemsInStorage():Boolean { return itemAnyInStorage(itemStorage, 0, itemStorage.length); }

		public function hasItemInStorage(itype:ItemType):Boolean { return itemTypeInStorage(itemStorage, 0, itemStorage.length, itype); }

		public function consumeItemInStorage(itype:ItemType):Boolean {
			var index:int = itemStorage.length;
			while(index > 0) {
				index--;
				if(itemStorage[index].itype == itype && itemStorage[index].quantity > 0) {
					itemStorage[index].quantity--;
					return true;
				}
			}
			return false;
		}

		public function hasItemsInBagStorage():Boolean { return itemAnyInStorage(gearStorage, 45, 57); }

		public function hasItemInBagStorage(itype:ItemType):Boolean { return itemTypeInStorage(gearStorage, 45, 57, itype); }

		public function hasItemsInPearlStorage():Boolean { return itemAnyInStorage(pearlStorage, 0, 98); }

		public function hasItemInPearlStorage(itype:ItemType):Boolean { return itemTypeInStorage(pearlStorage, 0, 98, itype); }

		public function giveHumanizer():void {
			clearOutput();
			if(flags[kFLAGS.TIMES_CHEATED_COUNTER] > 0) {
				outputText("<b>I was a cheater until I took an arrow to the knee...</b>");
				EventParser.gameOver();
				return;
			}
			outputText("I AM NOT A CROOK.  BUT YOU ARE!  <b>CHEATER</b>!\n\n");
			inventory.takeItem(consumables.HUMMUS_, playerMenu);
			flags[kFLAGS.TIMES_CHEATED_COUNTER]++;
		}

		public function getMaxSlots():int {
			var slots:int = 6;
			if (player.hasKeyItem("Backpack") >= 0) slots += player.keyItemvX("Backpack", 1);
			if (player.hasPerk(PerkLib.StrongBack)) {
				var bonus:Number = slots * 0.5;
				slots += bonus;
				if (player.hasPerk(PerkLib.StrongBack2)) slots += bonus;
				if (player.hasPerk(PerkLib.StrongBack3)) slots += bonus;
			}
			//Constrain slots to between 6 and 50.
			if (slots < 6) slots = 6;
			if (slots > 50) slots = 50;
			return slots;
		}
		public function getOccupiedSlots():int {
			var occupiedSlots:int = 0;
		    for (var i:int = 0; i < player.itemSlots.length; i++) {
				if (!player.itemSlot(i).isEmpty() && player.itemSlot(i).unlocked) occupiedSlots++;
			}
			return occupiedSlots;
		}

		//Create a storage slot
		public function createStorage():Boolean {
			if (itemStorage.length >= 16) return false;
			var newSlot:ItemSlotClass = new ItemSlotClass();
			itemStorage.push(newSlot);
			return true;
		}

		//Clear storage slots
		public function clearStorage():void {
			//Various Errors preventing action
			if (itemStorage == null) CoC_Settings.error("Cannot clear storage because storage does not exist.");
			else {
				trace("Attempted to remove " + itemStorage.length + " storage slots.");
				itemStorage.splice(0, itemStorage.length);
			}
		}

		public function clearGearStorage():void {
			//Various Errors preventing action
			if (gearStorage == null) CoC_Settings.error("Cannot clear storage because storage does not exist.");
			else {
				trace("Attempted to remove " + gearStorage.length + " storage slots.");
				gearStorage.splice(0, gearStorage.length);
			}
		}

		public function clearPearlStorage():void {
			//Various Errors preventing action
			if (pearlStorage == null) CoC_Settings.error("Cannot clear storage because storage does not exist.");
			else {
				trace("Attempted to remove " + pearlStorage.length + " storage slots.");
				pearlStorage.splice(0, pearlStorage.length);
			}
		}

		public function initializeGearStorage():void {
			//Completely empty storage array
			if (gearStorage == null) CoC_Settings.error("Cannot clear gearStorage because storage does not exist.");
			else {
				trace("Attempted to remove " + gearStorage.length + " gearStorage slots.");
				gearStorage.splice(0, gearStorage.length);
			}
			//Rebuild a new one!
			var newSlot:ItemSlotClass;
			while (gearStorage.length < 90) {
				newSlot = new ItemSlotClass();
				gearStorage.push(newSlot);
			}
		}

		public function initializePearlStorage():void {
			//Completely empty storage array
			if (pearlStorage == null) CoC_Settings.error("Cannot clear pearlStorage because storage does not exist.");
			else {
				trace("Attempted to remove " + pearlStorage.length + " pearlStorage slots.");
				pearlStorage.splice(0, pearlStorage.length);
			}
			//Rebuild a new one!
			var newSlot:ItemSlotClass;
			while (pearlStorage.length < 98) {
				newSlot = new ItemSlotClass();
				pearlStorage.push(newSlot);
			}
		}
		private function doWhatWithItem(slotNum:int):void {
			clearOutput();
			if (player.itemSlots[slotNum].itype is Useable) {
				var item:Useable = player.itemSlots[slotNum].itype as Useable;
			if (flags[kFLAGS.INVT_MGMT_TYPE] == 0){
				if (shiftKeyDown) {
					deleteItemPrompt(item, slotNum);
				return;
				}
				if (item.canUse()) { //If an item cannot be used then canUse should provide a description of why the item cannot be used
					if (!debug) player.itemSlots[slotNum].removeOneItem();
					useItem(item, player.itemSlots[slotNum]);
					return;
				}
				itemGoNext(); //Normally returns to the inventory menu. In combat it goes to the inventoryCombatHandler function
			}	else {
				if (item.canUse()) {
					outputText("You grab " + player.itemSlots[slotNum].itype.longName + " and consider what you will do with it.\n\n"
							+ "Do you use it, or destroy it?\n\n");
					menu();	//Can't get the menu to pop up...
					addButton(0, "Use it", handleItemInInventory, 0, item, slotNum);
					addButton(1, "Discard it", deleteItemPrompt,  item, slotNum);
				} else {
					menu();
					addButton(0, "Next", itemGoNext);
					//addButton(1, "Discard it", deleteItemPrompt, item, slotNum);
					//itemGoNext();
				}
				}
			}else {
				outputText("You cannot use " + player.itemSlots[slotNum].itype.longName + "!\n\n");
				itemGoNext(); //Normally returns to the inventory menu. In combat it goes to the inventoryCombatHandler function
			}
			}


		private function handleItemInInventory(x:int, item:Useable, slotNum:int):void{
			if (!debug) player.itemSlots[slotNum].removeOneItem();
			useItem(item, player.itemSlots[slotNum]);
		}


		private function inventoryCombatHandler():void {
			//Check if the battle is over. If not then go to the enemy's action.
			if (combat.combatIsOver()) return;
			outputText("\n\n");
			enemyAI();
		}
		private function deleteItemPrompt(item:Useable, slotNum:int):void {
			clearOutput();
			outputText("Are you sure you want to destroy " + player.itemSlots[slotNum].quantity + "x " + item.shortName + "?  You won't be able to retrieve " + (player.itemSlots[slotNum].quantity == 1 ? "it": "them") + "!");
			menu();
			addButton(0, "Yes", deleteItem, item, slotNum);
			addButton(1, "No", inventoryMenu);
			//doYesNo(deleteItem, inventoryMenu);
		}

		private function deleteItem(item:Useable, slotNum:int):void {
			clearOutput();
			outputText(player.itemSlots[slotNum].quantity + "x " + item.shortName + " " + (player.itemSlots[slotNum].quantity == 1 ? "has": "have") + " been destroyed.");
			player.destroyItems(item, player.itemSlots[slotNum].quantity);
			doNext(inventoryMenu);
		}

		private function useItem(item:Useable, fromSlot:ItemSlotClass):void {
			var originalItem:Useable = item;
			item.useText();
			if (item is Equipable) {
				var e:Equipable = item as Equipable;
				var slot:int = player.slotForItem(e);
				if (slot < 0) slot = e.slots()[0]; // not found suitable slot, try to fit into first - will fail but display a message why
				var returnItem:ItemType = player.internalEquipItem(slot, e);
				if (returnItem == null) takeItem(originalItem, callNext); // failed to equip, return original item
				else if (returnItem.isNothing) itemGoNext();
				else takeItem(returnItem, callNext);
			} else {
				currentItemSlot = fromSlot;
				if (!item.useItem()) itemGoNext(); //Items should return true if they have provided some form of sub-menu.
					//This is used for Reducto and GroPlus (which always present the player with a sub-menu)
					//and for the Kitsune Gift (which may show a sub-menu if the player has a full inventory)
//				if (!item.hasSubMenu()) itemGoNext(); //Don't call itemGoNext if there's a sub menu, otherwise it would never be displayed
			}
			CoC.instance.mainViewManager.updateCharviewIfNeeded();
			statScreenRefresh();
		}

		private function takeItemFull(itype:ItemType, showUseNow:Boolean, source:ItemSlotClass, page:int = 1):void {
			var x:int;
			mainView.linkHandler = showItemTooltipLinkHandler;
			outputText("There is no room for " + mkLink(itype.longName, itype.id) + " in your inventory.  You may replace the contents of a pouch with " + itype.longName + " or abandon it.");
			menu();
			if (showUseNow && itype is Useable) addButton(11, "Use Now", createCallBackFunction2(useItemNow, itype as Useable, source));/*
			for (var x:int = 0; x < 10; x++) {
				if (player.itemSlots[x].unlocked)
					addButton(x, (player.itemSlots[x].itype.shortName + " x" + player.itemSlots[x].quantity), createCallBackFunction2(replaceItem, itype, x));
			}*/
			if (source != null) {
				currentItemSlot = source;
				addButton(11, "Put Back", createCallBackFunction2(returnItemToInventory, itype, false));
			}
			if (page == 1) {
				for (x = 0; x < 10; x++) {
					if (player.itemSlots[x].unlocked)
							button(x).showForItemSlot(player.itemSlots[x], curry(replaceItem, itype, x));
				}
				if (getMaxSlots() > 10) addButton(13, "Next", curry(takeItemFull, itype, showUseNow, source, page + 1));
			}
			if (page == 2) {
				for (x = 10; x < 20; x++) {
					if (player.itemSlots[x].unlocked)
						button(x-10).showForItemSlot(player.itemSlots[x], curry(replaceItem, itype, x));
				}
				addButton(12, "Prev", curry(takeItemFull, itype, showUseNow, source, page - 1));
				if (getMaxSlots() > 20) addButton(13, "Next", curry(takeItemFull, itype, showUseNow, source, page + 1));
			}
			if (page == 3) {
				for (x = 20; x < 30; x++) {
					if (player.itemSlots[x].unlocked)
						button(x-20).showForItemSlot(player.itemSlots[x], curry(replaceItem, itype, x));
				}
				addButton(12, "Prev", curry(takeItemFull, itype, showUseNow, source, page - 1));
				if (getMaxSlots() > 30) addButton(13, "Next", curry(takeItemFull, itype, showUseNow, source, page + 1));
			}
			if (page == 4) {
				for (x = 30; x < 40; x++) {
					if (player.itemSlots[x].unlocked)
						button(x-30).showForItemSlot(player.itemSlots[x], curry(replaceItem, itype, x));
				}
				addButton(12, "Prev", curry(takeItemFull, itype, showUseNow, source, page - 1));
				if (getMaxSlots() > 40) addButton(13, "Next", curry(takeItemFull, itype, showUseNow, source, page + 1));
			}
			if (page == 5) {
				for (x = 40; x < 50; x++) {
					if (player.itemSlots[x].unlocked)
						button(x-40).showForItemSlot(player.itemSlots[x], curry(replaceItem, itype, x));
				}
				addButton(12, "Prev", curry(takeItemFull, itype, showUseNow, source, page - 1));
			}
			addButton(14, "Abandon", callOnAbandon); //Does not doNext - immediately executes the callOnAbandon function
		}

		public function UseItemNow(item:Useable, nextAction:Function, source:ItemSlotClass = null):void {
			clearOutput();

			if (nextAction != null) {
				if (nextAction != callNext) callNext = nextAction;
			} else {
				callNext = playerMenu;
			}
			if (item.canUse()) { //If an item cannot be used then canUse should provide a description of why the item cannot be used
				useItem(item, source);
			}
			else {
				takeItemFull(item, false, source); //Give the player another chance to take this item
			}
		}

		private function useItemNow(item:Useable, source:ItemSlotClass):void {
			clearOutput();
			if (item.canUse()) { //If an item cannot be used then canUse should provide a description of why the item cannot be used
				useItem(item, source);
			}
			else {
				takeItemFull(item, false, source); //Give the player another chance to take this item
			}
		}

		private function replaceItem(itype:ItemType, slotNum:int):void {
			clearOutput();
			if (player.itemSlots[slotNum].itype == itype) //If it is the same as what's in the slot...just throw away the new item
				outputText("You discard " + itype.longName + " from the stack to make room for the new one.");
			else { //If they are different...
				if (player.itemSlots[slotNum].quantity == 1) outputText("You throw away " + player.itemSlots[slotNum].itype.longName + " and replace it with " + itype.longName + ".");
				else outputText("You throw away " + player.itemSlots[slotNum].itype.longName + "(x" + player.itemSlots[slotNum].quantity + ") and replace it with " + itype.longName + ".");
				player.itemSlots[slotNum].setItemAndQty(itype, 1);
			}
			itemGoNext();
		}

		private function itemAnyInStorage(storage:Array, startSlot:int, endSlot:int):Boolean {
			for (var x:int = startSlot; x < endSlot; x++) {
				if (storage[x] != undefined) if (storage[x].quantity > 0) return true;
			}
			return false;
		}

		private function itemTypeInStorage(storage:Array, startSlot:int, endSlot:int, itype:ItemType):Boolean {
			for (var x:int = startSlot; x < endSlot; x++) {
				if (storage[x] != undefined) if (storage[x].quantity > 0 && storage[x].itype == itype) return true;
			}
			return false;
		}

		public function removeItemFromStorage(storage:Array, itype:ItemType):void {
			for (var x:int = 0; x < storage.length; x++) {
				if (storage[x] != undefined) {
					if (storage[x].quantity > 0 && storage[x].itype == itype) {
						storage[x].quantity--;
						return;
					}
				}
			}
		}

		public function manageEquipment(page:int = 1):void {
			clearOutput();
			outputText("Which would you like to unequip?\n\n");
			menu();
			if (page == 1) {
				addButton(0, "Weapon (M)", unequipWeapon)
						.itemHints(player.weapon)
						.disableIf(!player.weapon.canUnequip(false))
						.disableIf(player.weapon.isNothing || player.hasPerk(PerkLib.Rigidity), "You don't have melee weapon equipped.");
				addButton(1, "Weapon (R)", unequipWeaponRange)
						.itemHints(player.weaponRange)
						.disableIf(!player.weaponRange.canUnequip(false))
						.disableIf(player.weaponRange.isNothing || player.hasPerk(PerkLib.Rigidity), "You don't have range weapon equipped.");
				addButton(2, "Shield", unequipShield)
						.itemHints(player.shield)
						.disableIf(!player.shield.canUnequip(false))
						.disableIf(player.shield.isNothing || player.hasPerk(PerkLib.Rigidity), "You don't have shield equipped.");
				addButton(3, "Flying Sword", unequipFlyingSwords)
						.itemHints(player.weaponFlyingSwords)
						.disableIf(!player.weaponFlyingSwords.canUnequip(false))
						.disableIf(player.weaponFlyingSwords == FlyingSwordsLib.NOTHING, "You don't have shield equipped.")
						.disableIf(!player.hasPerk(PerkLib.FlyingSwordPath), "You don't have flying sword equipped. (Req. perk: Flying Swords Control)");
				addButton(5, "Armour", unequipArmor)
						.itemHints(player.armor)
						.disableIf(!player.armor.canUnequip(false))
						.disableIf(player.hasPerk(PerkLib.Rigidity), "Your body stiffness prevents you from unequipping this armor.")
						.disableIf(player.armor.isNothing, "You don't have armor equipped.");
				addButton(6, "Upperwear", unequipUpperwear)
						.itemHints(player.upperGarment)
						.disableIf(!player.upperGarment.canUnequip(false))
						.disableIf(player.upperGarment.isNothing || player.hasPerk(PerkLib.Rigidity), "You don't have upperwear equipped.");
				addButton(7, "Lowerwear", unequipLowerwear)
						.itemHints(player.lowerGarment)
						.disableIf(!player.lowerGarment.canUnequip(false))
						.disableIf(player.lowerGarment.isNothing || player.hasPerk(PerkLib.Rigidity), "You don't have lowerwear equipped.");
				addButton(8, "Vehicle", unequipVehicle)
						.itemHints(player.vehicles)
						.disableIf(!player.vehicles.canUnequip(false))
						.disableIf(player.vehicles == VehiclesLib.NOTHING || player.hasPerk(PerkLib.Rigidity), "You not using currently any vehicle.");
				//10 - lower body armor slot
				addButton(13, "-2-", manageEquipment, page + 1);
			}
			if (page == 2) {
				addButton(0, "Head Acc", unequipHeadJewel)
						.itemHints(player.headJewelry)
						.disableIf(!player.headJewelry.canUnequip(false))
						.disableIf(player.hasPerk(PerkLib.Rigidity), "Your body stiffness prevents you from unequipping this head accessory.")
						.disableIf(player.headJewelry.isNothing, "You don't have equipped any head accessory.");
				addButton(1, "Necklace", unequipNecklace)
						.itemHints(player.necklace)
						.disableIf(!player.necklace.canUnequip(false))
						.disableIf(player.necklace.isNothing, "You don't have equipped any necklace.");
				addButton(2, "Acc 1", unequipMiscJewel1)
						.itemHints(player.miscJewelry1)
						.disableIf(!player.miscJewelry1.canUnequip(false))
						.disableIf(player.miscJewelry1.isNothing, "You don't have equipped any accessory.");
				addButton(3, "Acc 2", unequipMiscJewel2)
						.itemHints(player.miscJewelry2)
						.disableIf(!player.miscJewelry2.canUnequip(false))
						.disableIf(player.miscJewelry2.isNothing, "You don't have equipped any accessory.");
				addButton(5, "Ring 1", unequipJewel1)
						.itemHints(player.jewelry1)
						.disableIf(!player.jewelry1.canUnequip(false))
						.disableIf(player.jewelry1.isNothing, "You don't have equipped any ring.");
				addButton(6, "Ring 3", unequipJewel3)
						.itemHints(player.jewelry3)
						.disableIf(!player.jewelry3.canUnequip(false))
						.disableIf(player.jewelry3.isNothing, "You don't have equipped any ring.")
						.disableIf(!player.hasPerk(PerkLib.ThirdRing), "You don't have equipped any ring. (Req. lvl 60+ perk: Third Ring)");
				addButton(10, "Ring 2", unequipJewel2)
						.itemHints(player.jewelry2)
						.disableIf(!player.jewelry2.canUnequip(false))
						.disableIf(player.jewelry2.isNothing, "You don't have equipped any ring.")
						.disableIf(!player.hasPerk(PerkLib.SecondRing), "You don't have equipped any ring. (Req. lvl 30+ perk: Second Ring)");
				addButton(11, "Ring 4", unequipJewel4)
						.itemHints(player.jewelry4)
						.disableIf(!player.jewelry4.canUnequip(false))
						.disableIf(player.jewelry4.isNothing, "You don't have equipped any ring.")
						.disableIf(!player.hasPerk(PerkLib.FourthRing), "You don't have equipped any ring. (Req. lvl 90+ perk: Fourth Ring)");
				addButton(13, "-1-", manageEquipment, page - 1);
			}
			/*if (player.jewelry != JewelryLib.NOTHING) {
				addButton(3, "Accessory", unequipJewel).hint(player.jewelry.description, capitalizeFirstLetter(player.jewelry.name));
			}
			zrobić sloty:
			na pas/belt?
			2 bransolety/bracelets(on arm wrists)?
			przy dodawaniu tych slotow popatrzec czy ktorys nie bedzie musial uzywac tego fragmentu kodu:
			else if (item is Shield) {
				player.shield.removeText();
				item = player.setShield(item as Shield); //Item is now the player's old shield
			*/
			addButton(14, "Back", inventoryMenu);

		}
		//Unequip!
		/**
		 * Unequip item from slot, placing it into inventory.
		 * @param nextFn Next scene
		 * @param slot
		 * @param doOutput Print 'you unequip' text
		 * @param force Ignore canUnequip check
		 */
		public function unequipSlotToInventory(nextFn:Function, slot:int, doOutput:Boolean = true, force:Boolean = false):void {
			var oldItem:ItemType = player.internalUnequipItem(slot, doOutput, force);
			if (oldItem && !oldItem.isNothing) {
				takeItem(oldItem, nextFn);
			} else if (oldItem == null) {
				// failed to unequip, text was displayed, add [Next] before proceeding
				doNext(nextFn);
			} else {
				nextFn();
			}
			CoC.instance.mainViewManager.updateCharviewIfNeeded();
			statScreenRefresh();
		}
		public function unequipWeapon():void {
			unequipSlotToInventory(manageEquipment, ItemConstants.SLOT_WEAPON_MELEE);
		}
		public function unequipWeaponRange():void {
			unequipSlotToInventory(manageEquipment, ItemConstants.SLOT_WEAPON_RANGED);
		}
		private function unequipFlyingSwords():void {
			unequipSlotToInventory(manageEquipment, ItemConstants.SLOT_FLYING_SWORD);
		}
		public function unequipShield():void {
			unequipSlotToInventory(manageEquipment, ItemConstants.SLOT_SHIELD);
		}
		public function unequipArmor():void {
			unequipSlotToInventory(manageEquipment, ItemConstants.SLOT_ARMOR);
		}
		public function unequipUpperwear():void {
			unequipSlotToInventory(manageEquipment, ItemConstants.SLOT_UNDER_TOP);
		}
		public function unequipLowerwear():void {
			unequipSlotToInventory(manageEquipment, ItemConstants.SLOT_UNDER_BOTTOM);
		}
		public function unequipHeadJewel():void {
			unequipSlotToInventory(manageEquipment, ItemConstants.SLOT_HEAD);
		}
		public function unequipNecklace():void {
			unequipSlotToInventory(manageEquipment, ItemConstants.SLOT_NECK);
		}
		public function unequipMiscJewel1():void {
			unequipSlotToInventory(manageEquipment, ItemConstants.SLOT_JEWELRY_MISC_1);
		}
		public function unequipMiscJewel2():void {
			unequipSlotToInventory(manageEquipment, ItemConstants.SLOT_JEWELRY_MISC_2);
		}
		public function unequipJewel1():void {
			unequipSlotToInventory(manageEquipment, ItemConstants.SLOT_RING_1);
		}
		public function unequipJewel2():void {
			unequipSlotToInventory(manageEquipment, ItemConstants.SLOT_RING_2);
		}
		public function unequipJewel3():void {
			unequipSlotToInventory(manageEquipment, ItemConstants.SLOT_RING_3);
		}
		public function unequipJewel4():void {
			unequipSlotToInventory(manageEquipment, ItemConstants.SLOT_RING_4);
		}
		public function unequipVehicle():void {
			unequipSlotToInventory(manageEquipment, ItemConstants.SLOT_VEHICLE);
		}

		//Acceptable types of items
		public function allAcceptable(itype:ItemType):Boolean { return true; }
		public function consumableAcceptable(itype:ItemType):Boolean { return itype is Consumable; }
		public function armorAcceptable(itype:ItemType):Boolean { return itype is Armor; }
		public function weaponAcceptable(itype:ItemType):Boolean { return (itype is Weapon) || (itype is WeaponRange); }
		public function shieldAcceptable(itype:ItemType):Boolean { return itype is Shield; }
		public function jewelryAcceptable(itype:ItemType):Boolean { return itype is Jewelry; }
		public function undergarmentAcceptable(itype:ItemType):Boolean { return itype is Undergarment; }
	}
}
