package classes {
import classes.BodyParts.*;
import classes.GlobalFlags.*;
import classes.Items.*;
import classes.Scenes.Places.Mindbreaker;
import classes.Stats.BuffableStat;
import classes.Stats.IStat;
import classes.Stats.PrimaryStat;
import classes.Stats.RawStat;
import classes.Stats.StatUtils;
import classes.StatusEffects.CombatStatusEffect;

import coc.view.ButtonDataList;
import coc.view.CoCLoader;
import coc.view.MainView;

import flash.net.FileReference;
import flash.text.TextFormat;
import flash.utils.ByteArray;

/**
 * ...
 * @author ...
 */
public class GameSettings extends BaseContent {

    public var sceneHunter_inst:SceneHunter = new SceneHunter();
	
	public static function get buttonIconsEnabled():Boolean {
		return flags && !flags[kFLAGS.BUTTON_ICONS_DISABLED];
	}

	public function get charviewEnabled():Boolean {
		return flags[kFLAGS.CHARVIEWER_ENABLED];
	}

	private var daysPerYear_temp:int; //used for storing the flag value without exiting the menu (to avoid issues while cycling through 'real' date.

	public function settingsScreenMain(justOpened:Boolean = false):void {
		CoC.instance.saves.savePermObject(false);
		if (justOpened) daysPerYear_temp = flags[kFLAGS.DAYS_PER_YEAR];
		else model.time.changeDPY(daysPerYear_temp);
        mainView.showMenuButton(MainView.MENU_NEW_MAIN);
		mainView.showMenuButton(MainView.MENU_DATA);
		clearOutput();
		displayHeader("Settings");
		outputText("Here, you can adjust the gameplay and interface settings. Setting flags are saved in a special file so you don't have to re-adjust it each time you load a save file.");
		menu();
		addButton(0, "Gameplay(1)", settingsScreenGameSettings).hint("Mainly setting that need to have loaded save.");
		addButton(1, "Interface", settingsScreenInterfaceSettings);
		addButton(2, "QoL", settingsScreenQoLSettings).hint("Quality of Life Settings.");
		addButton(3, "Font Size", fontSettingsMenu);
		addButton(4, "Controls", displayControls);
		addButton(5, "Gameplay(2)", settingsScreenGameSettings2);
		addButton(6, "SceneHunter", sceneHunter_inst.settingsPage);
		if (debug) addButton(12, "gamedata.js", exportGameDataJs).hint("Export gamedata.js file for (new) save editor");
		addButton(14, "Back", CoC.instance.mainMenu.mainMenu);
	}

	//------------
	// GAMEPLAY
	//------------
	public function settingsScreenGameSettings():void {

		clearOutput();
		displayHeader("Gameplay Settings");
		if (flags[kFLAGS.AUTO_LEVEL] >= 1) {
			outputText("Automatic Leveling: [font-green]<b>ON</b>[/font]\n Leveling up is done automatically once you accumulate enough experience.");
		}
		else
			outputText("Automatic Leveling: [font-dred]<b>OFF</b>[/font]\n Leveling up is done manually.");
		outputText("\n\n");
		outputText("<b><u>SAVE-RELATED FLAGS</u></b>\n");
		outputText("The following flags are applied to the save - you <b>must</b> be <i>in a game session</i> (e.g. load your save, hit \"Main Menu\", change them. If you load a save, they will be set to the saved values.");
		outputText("\n\n");
		if (player) {
			if (daysPerYear_temp == 0) {
				outputText("Timescale: [font-green]<b>REAL</b>[/font]\n In-game date (used for holiday events) uses real date from your computer.");
				if (flags[kFLAGS.DAYS_PER_YEAR] > 0) outputText("\n[font-dred]<b>WARNING: your current in-game date will be erased after you exit this menu.</b>[/font]");
			} else {
				outputText("Timescale: [font-blue]<b>DAYS ("+daysPerYear_temp+" in-game days per year)</b>[/font]\n In-game date is calculated from the days spent in Mareth.");
			}
			outputText("\nDay of the month event requirements (e.g. exact days of Easter/Thanksgiving) <b>" + (daysPerYear_temp == 0 || daysPerYear_temp == 365 ? "ARE" : "are NOT") + "</b> taken into account with the selected option.");
			outputText("\n\n");
			player.displayFinalGameDifficulty();
			outputText("\n\n");
			if (flags[kFLAGS.PRIMARY_DIFFICULTY] <= 0) {
				outputText("Primary Difficulty: [font-olive]<b>Easy</b>[/font]\n No opponent(s) stats modifiers. You can resume from bad-ends with penalties. No penatlies for too high wrath. Internal mutation negative effects will be triggered after accumulating 11 points in internal mutation score.");
			}
			else if (flags[kFLAGS.PRIMARY_DIFFICULTY] == 1) {
				outputText("Primary Difficulty: <b>[font-dred]Normal[/font]</b>\n Opponent(s) take 2x less HP/Lust dmg, deal 20% more damage and gives ~20% more EXP. No penatlies for too high wrath. Bad-ends can ruin your game. Internal mutation negative effects will be triggered after accumulating 6 points in internal mutation score.");
			}
			else if (flags[kFLAGS.PRIMARY_DIFFICULTY] == 2) {
				outputText("Primary Difficulty: <b>[font-red]Hard[/font]</b>\n Opponent(s) take 5x less HP/Lust dmg, deal 50% more damage and gives ~50% more EXP." +
						" If you want to spellcast or use magic specials, you have to pay attention to your accumulated wrath. Additionally, the negative effects of internal mutations begin immediately.");
			}
			else if (flags[kFLAGS.PRIMARY_DIFFICULTY] == 3) {
				outputText("Primary Difficulty: <b>[font-red]Nightmare[/font]</b>\n Opponent(s) take 10x less HP/Lust dmg, deal more 100% damage and gives ~100% more EXP." +
						" If you want to spellcast or use magic specials, you have to pay attention to your accumulated wrath. Additionally, the negative effects of internal mutations begin immediately.");
			}
			else if (flags[kFLAGS.PRIMARY_DIFFICULTY] == 4) {
				outputText("Primary Difficulty: <b>[font-lred]Extreme[/font]</b>\n Opponent(s) take 25x less HP/Lust dmg, deal more 250% damage and gives ~150% more EXP." +
						" If you want to spellcast or use magic specials, you have to pay attention to your accumulated wrath. Additionally, the negative effects of internal mutations begin immediately.");
			}
			else if (flags[kFLAGS.PRIMARY_DIFFICULTY] == 5) {
				outputText("Primary Difficulty: <b>[font-lred]Inferno[/font]</b>\n Opponent(s) take 25x less HP/Lust dmg, deal more 250% damage and gives ~150% more EXP." +
						" If you want to spellcast or use magic specials, you have to pay attention to your accumulated wrath. Additionally, the negative effects of internal mutations begin immediately.");
			}
			else if (flags[kFLAGS.PRIMARY_DIFFICULTY] == 6) {
				outputText("Primary Difficulty: <b>[font-pink]Metroid Dread[/font]</b>\n Opponent(s) take 25x less HP/Lust dmg, deal more 250% damage and gives ~150% more EXP." +
						" If you want to spellcast or use magic specials, you have to pay attention to your accumulated wrath. Additionally, the negative effects of internal mutations begin immediately.");
			}
			else if (flags[kFLAGS.PRIMARY_DIFFICULTY] >= 7) {
				outputText("Primary Difficulty: <b>[font-pink]Xianxia MC[/font]</b>\n Opponent(s) take 25x less HP/Lust dmg, deal more 250% damage and gives ~150% more EXP." +
						" If you want to spellcast or use magic specials, you have to pay attention to your accumulated wrath. Additionally, the negative effects of internal mutations begin immediately.");
			}
			outputText("\n\n");
			if (flags[kFLAGS.HUNGER_ENABLED] < 0.5) {
				outputText("Hunger/Realistic Mode Modifier: <b>[font-olive]Disabled[/font]</b>");
			}
			else if (flags[kFLAGS.HUNGER_ENABLED] == 0.5) {
				outputText("Hunger Modifier: <b>[font-red]Enabled[/font]</b> (PC must manage his own hunger lest you want see his death from starvation)");
			}
			else if (flags[kFLAGS.HUNGER_ENABLED] == 1) {
				outputText("Realistic Mode Modifier: <b>[font-red]Enabled[/font]</b> (PC must manage his own hunger lest you want see his death from starvation + your cum production is capped and having oversized parts will weigh you down)");
			}
			outputText("\n\n");
			if (flags[kFLAGS.HARDCORE_MODE] == 0) {
				outputText("Hardcore Modifier: <b>[font-olive]Disabled[/font]</b>");
			}
			else if (flags[kFLAGS.HARDCORE_MODE] == 1) {
				outputText("Hardcore Modifier: <b>[font-red]Enabled[/font]</b> (No level limits for unlocking new areas)");
			}
			outputText("\n\n");
			if (flags[kFLAGS.SECONDARY_STATS_SCALING] == 0) {
				outputText("Secondary Stats Modifier: No opponent secondary stats modifiers.");
			}
			else if (flags[kFLAGS.SECONDARY_STATS_SCALING] == 1) {
				outputText("Secondary Stats Modifier: Opponent has 10x (bosses) and 5x (rest) more HP/Lust/Wrath/Fatigue/Mana/Soulforce.");
			}
			else if (flags[kFLAGS.SECONDARY_STATS_SCALING] == 2) {
				outputText("Secondary Stats Modifier: Opponent has 30x (bosses) and 10x (rest) more HP/Lust/Wrath/Fatigue/Mana/Soulforce.");
			}
			else if (flags[kFLAGS.SECONDARY_STATS_SCALING] == 3) {
				outputText("Secondary Stats Modifier: Opponent has 100x (bosses) and 25x (rest) more HP/Lust/Wrath/Fatigue/Mana/Soulforce.");
			}
			else if (flags[kFLAGS.SECONDARY_STATS_SCALING] == 4) {
				outputText("Secondary Stats Modifier: Opponent has 500x (bosses) and 100x (rest) more HP/Lust/Wrath/Fatigue/Mana/Soulforce.");
			}
			else if (flags[kFLAGS.SECONDARY_STATS_SCALING] == 5) {
				outputText("Secondary Stats Modifier: Opponent has 1500x (bosses) and 500x (rest) more HP/Lust/Wrath/Fatigue/Mana/Soulforce.");
			}
			else if (flags[kFLAGS.SECONDARY_STATS_SCALING] >= 6) {
				outputText("Secondary Stats Modifier: Opponent has 21000x (bosses) and 3000x (rest) more HP/Lust/Wrath/Fatigue/Mana/Soulforce.");
			}
			outputText("\n\n");
			if (flags[kFLAGS.BOSS_CHAMPION_ELITE_SCALING] == 0) {
				outputText("Elite/Champion/Boss Modifier: [font-olive]<b>Normal</b>[/font]\n No HP modifiers");
			}
			else if (flags[kFLAGS.BOSS_CHAMPION_ELITE_SCALING] == 1) {
				outputText("Elite/Champion/Boss Modifier: <b>[font-dred]Fantasy[/font]</b>\n 1.25x / 2.5x / 5x HP modifiers");
			}
			else if (flags[kFLAGS.BOSS_CHAMPION_ELITE_SCALING] == 2) {
				outputText("Elite/Champion/Boss Modifier: <b>[font-red]Torment[/font]</b>\n 2.5x / 5x / 10x HP modifier");
			}
			else if (flags[kFLAGS.BOSS_CHAMPION_ELITE_SCALING] == 3) {
				outputText("Elite/Champion/Boss Modifier: <b>[font-lred]Infernium[/font]</b>\n 3.75x / 7.5x / 15x HP modifier");
			}
			else if (flags[kFLAGS.BOSS_CHAMPION_ELITE_SCALING] >= 4) {
				outputText("Elite/Champion/Boss Modifier: <b>[font-pink]HELL[/font]</b>\n 5x / 10x / 20x HP modifier");
			}
			outputText("\n\n");
			if (flags[kFLAGS.EASY_MODE_ENABLE_FLAG] == 1) {
				outputText("Easier Mode: [font-green]<b>ON</b>[/font]\n Bad-ends can be ignored and combat is so super easy that even CoC Vanilla and CoC2 devs can breeze it with one hand ^^ (dmg monsters deal is 10x lower, no scaling of some of their combat stats and no penalty for level difference)");
			}
			else {
				outputText("Easier Mode: [font-dred]<b>OFF</b>[/font]\n Bad-ends can ruin your game and combat is back to what it should be.");
			}
			outputText("\n\n");
			if (flags[kFLAGS.WATERSPORTS_ENABLED] >= 1) {
				outputText("Watersports: [font-green]<b>Enabled</b>[/font]\n Watersports scenes are enabled. (You kinky person)");
			}
			else
				outputText("Watersports: [font-dred]<b>Disabled</b>[/font]\n Watersports scenes are disabled.");
			outputText("\n\n");
		}
		menu();
		if (player) {
			addButton(0, "Prime Difficulty", difficultySelectionMenu1).hint("Adjust primary difficulty to make game easier or harder.");
			addButton(1, "Sec.Mon.Stat", difficultySelectionMenu2).hint("Adjusts monsters secondary stats multiplier to make game easier or harder.");
			addButton(2, "E/Ch/B.Mon.Stat", difficultySelectionMenu3).hint("Adjusts elite/champion/boss monsters HP multiplier to make game easier or harder.");
			if (flags[kFLAGS.HARDCORE_MODE] != 1) addButton(5, "Hardcore+", enableHardcoreModifierForReal);
			else addButton(5, "Hardcore-", disableHardcoreModifierForReal);
			if (flags[kFLAGS.HUNGER_ENABLED] != 0) addButton(6, "Hunger (Off)", disableHungerModifierForReal);
			if (flags[kFLAGS.HUNGER_ENABLED] != 0.5) addButton(7, "Hunger (On)", enableHungerModifierForReal);
			if (flags[kFLAGS.HUNGER_ENABLED] != 1) addButton(8, "Realistic (On)", enableRealisticModifierForReal);
			if (flags[kFLAGS.GAME_DIFFICULTY] <= 0) addButton(10, "Easier Mode", toggleFlag, kFLAGS.EASY_MODE_ENABLE_FLAG, settingsScreenGameSettings).hint("Toggles easier than easy mode. Enemy damage is 10% of normal and bad-ends can be ignored.");
			else addButtonDisabled(10, "Easier Mode", "Diffulty setting is too high to allow toggle easy mode.");
			addButton(11, "Fetishes", fetishSubMenu).hint("Toggle some of the weird fetishes such as watersports and worms.");
			addButton(12, "Timescale", timescaleCycle).hint("Change the way how time and date work in the game.");
		}
		else {
			addButtonDisabled(0, "Prime Difficulty", "Requires a loaded save.");
			addButtonDisabled(1, "Sec.Mon.Stat", "Requires a loaded save.");
			addButtonDisabled(2, "E/Ch/B.Mon.Stat", "Requires a loaded save.");
			//addButtonDisabled(3, "", "Requires a loaded save.");
			//addButtonDisabled(4, "", "Requires a loaded save.");
			addButtonDisabled(5, "Hardcore", "Requires a loaded save.");
			addButtonDisabled(6, "Hunger (Off)", "Requires a loaded save.");
			addButtonDisabled(7, "Hunger (On)", "Requires a loaded save.");
			addButtonDisabled(8, "Realistic (On)", "Requires a loaded save.");
			//addButtonDisabled(9, "", "Requires a loaded save.");
			addButtonDisabled(10, "Easier Mode", "Requires a loaded save.");
			addButtonDisabled(11, "Fetishes", "Requires a loaded save.");
			addButtonDisabled(12, "Timescale", "Requires a loaded save.");
		}
		addButton(13, "Auto level", toggleFlag, kFLAGS.AUTO_LEVEL, settingsScreenGameSettings).hint("Toggles automatic leveling when you accumulate sufficient experience.");
		addButton(14, "Back", settingsScreenMain);

		//===========================
		function timescaleCycle():void {
			var cycle:Array = [0, 60, 120, 180, 240, 365];
			daysPerYear_temp = cycle[(cycle.indexOf(daysPerYear_temp) + 1) % cycle.length];
			settingsScreenGameSettings();
		}
	}
	private function exportGameDataJs():void {
		var p:Player           = new Player();
		var k:String;
		var entry:Object;
		var subentry:Object;
		var file:FileReference = new FileReference();
		var bytes:ByteArray    = new ByteArray();
		// see devTools/saveEditor/js/gamedata.d.ts
		var gamedata:Object    = {
			version: CoC.instance.ver,
			versionNumber: CoC.instance.modSaveVersion,
			/** key: flag_id, value: IGDFlag */
			flags: {},
			/** key: perk_id, value: IGDPerk */
			perks: {},
			/** key: perk_id, value: IGDMutation */
			mutations: {},
			/** key: slot_id, value: IGDMutationSlot */
			mutation_slots: {
				"": {name: "Other"}
			},
			/** key: item_category, subkey: item_id, value: IGDItem */
			items: {
				armor: {},
				consumable: {},
				flyingsword: {},
				headjewelry: {},
				jewelry: {},
				miscjewelry: {},
				necklace: {},
				shield: {},
				/** value: IGDItemUndergarment */
				undergarment: {},
				useable: {},
				vehicle: {},
				weapon: {},
				weaponrange: {},
				
				other: {}
			},
			itemTemplates: {},
			// key: status_id
			statuses: {},
			// key: keyitem_id
			keyitems: {},
			// key: part
			// subkey: type_id
			bptypes: {
				antennae: {},
				arms: {},
				beard: {},
				claws: {},
				ears: {},
				eyes: {},
				face: {},
				gills: {},
				hair: {},
				hairstyle: {},
				horns: {},
				// extra properties: legCount, taur, noTail, tail
				legs: {},
				materials: {},
				rear: {},
				// extra properties: base, coat
				skin: {},
				// extra properties: base, coat
				pattern: {},
				tail: {},
				tongue: {},
				vagina: {},
				wings: {}
			},
			// value: { name:string, rgb:string }
			colors: [],
			// value: { id, name, type="primary"|"buffable"|"raw", isPercentage }
			stats: [],
			maxBreastCup: Appearance.BREAST_CUP_NAMES.length - 1,
			breastCups: Appearance.BREAST_CUP_NAMES,
			itemSlotCount: p.itemSlots.length
		};
		// flags
		for each(k in keys(kFLAGS, true)) {
			if (kFLAGS[k] is Number) {
				gamedata.flags[kFLAGS[k]] = {id: kFLAGS[k], name: k, desc: ""};
			}
		}
		// perks & mutations
		var monsterPerks:Array = PerkLib.enemyPerkList();
		var levelupPerks:Array = PerkTree.obtainablePerks();
		// perk requirement type -> list of extra properties
		const perkRequirementMappings:Object = {
			"custom":[],
			"level": ["value"],
			"attr": ["attr", "value"],
			"attr-lt": ["attr", "value"],
			"ng+": ["value"],
			"minlust": ["value"],
			"minsensitivity": ["value"],
			"soulforce": ["value"], // max soulforce
			"mana": ["value"], // max mana
			"venom_web": ["value"], // max venom/web
			"advanced": [], // free advanced job slot
			"prestige": [], // free prestige job slot
			"mutationslot": ["slot"],
			"dragonmutation": [], // free dragon mutation slot
			"kitsunemutation": [], // free kitsune mutation slot
			"hungerflag": [], // hunger enabled
			"effect": ["effect"],
			"race": ["race", "tier"],
			"anyrace": ["races"],
			"perk": ["perk"],
			"anyperk": ["perks"],
			"allperks": ["allperks"],
			"mutation": ["perk"]
		};
		function exportValue(v:*):* {
			if (v is StatusEffectType) {
				return (v as StatusEffectType).id;
			} else if (v is PerkType) {
				return (v as PerkType).id;
			} else if (v is Race) {
				return (v as Race).id;
			} else if (v is Array) {
				return v.map(varargify(exportValue));
			} else {
				return v;
			}
		}
		for (k in PerkType.getPerkLibrary()) {
			var pt:PerkType          = PerkType.lookupPerk(k);
			var mt:IMutationPerkType = pt as IMutationPerkType;
			var tags:Array           = [];
			if (mt) {
				gamedata.mutations[k] = {
					id: k,
					name: mt.name(null),
					desc: mt.desc(null),
					maxLevel: mt.maxLvl,
					tags: tags,
					slot: mt.slot
				}
			} else {
				if (monsterPerks.indexOf(pt) >= 0) tags.push('monster');
				else if (levelupPerks.indexOf(pt) >= 0) tags.push('levelup');
				else tags.push('unobtainable');
				entry = {
					id: k,
					name: pt.name(null),
					desc: pt.desc(null),
					tags: tags,
					defaultValues: [pt.defaultValue1, pt.defaultValue2, pt.defaultValue3, pt.defaultValue4],
					requirements: [],
					unlocks: []
				};
				for each (var pt2:PerkType in CoC.instance.perkTree.listUnlocks(pt)) {
					entry.unlocks.push(pt2.id);
				}
				for each (var r:Object in pt.requirements) {
					subentry = {
						text: r.text is String ? r.text : r.statictext,
						type: r.type
					};
					if (r.type in perkRequirementMappings) {
						for each (var k2:String in perkRequirementMappings[r.type]) {
							subentry[k2] = exportValue(r[k2]);
						}
					}
					entry.requirements.push(subentry);
				}
				gamedata.perks[k] = entry;
			}
		}
		// mutation slots
		for (k in IMutationPerkType.Slots) {
			gamedata.mutation_slots[k] = {id:k, name:IMutationPerkType.Slots[k].name};
		}
		// items
		for (k in ItemType.getItemLibrary()) {
			var it:ItemType = ItemType.lookupItem(k);
			var itemEffects:Array = [];
			for each (var ie:ItemEffect in it.itemEffects) {
				var jie:Object = {name:ie.type.name, power:ie.power};
				function sanitizeIEValue(value:*):* {
					if (value is Race) return "Race["+(value as Race).name+"]"
					return value;
				}
				if (ie.value1 !== undefined) jie.value1 = sanitizeIEValue(ie.value1);
				if (ie.value2 !== undefined) jie.value2 = sanitizeIEValue(ie.value2);
				if (ie.value3 !== undefined) jie.value3 = sanitizeIEValue(ie.value3);
				if (ie.value4 !== undefined) jie.value4 = sanitizeIEValue(ie.value4);
				itemEffects.push(jie);
			}
			entry = {name: it.longName, id: k, tags:keys(it.tags), effects:itemEffects};
			try {
				entry.desc = it.description;
			} catch (e:*) {
				entry.desc = '';
			}
			if (it is Armor) {
				entry.category = "armor";
				gamedata.items.armor[k] = entry;
			} else if (it is Consumable) {
				entry.category = "consumable";
				gamedata.items.consumable[k] = entry;
			} else if (it is FlyingSwords) {
				entry.category = "flyingsword";
				gamedata.items.flyingsword[k] = entry;
			} else if (it is HeadJewelry) {
				entry.category = "headjewelry";
				gamedata.items.headjewelry[k] = entry;
			} else if (it is Jewelry) {
				entry.category = "jewelry";
				gamedata.items.jewelry[k] = entry;
			} else if (it is MiscJewelry) {
				entry.category = "miscjewelry";
				gamedata.items.miscjewelry[k] = entry;
			} else if (it is Necklace) {
				entry.category = "necklace";
				gamedata.items.necklace[k] = entry;
			} else if (it is Shield) {
				entry.category = "shield";
				gamedata.items.shield[k] = entry;
			} else if (it is Undergarment) {
				entry.category = "undergarment";
				entry.type = (it as Undergarment).type;
				gamedata.items.undergarment[k] = entry;
			} else if (it is Vehicles) {
				entry.category = "vehicle";
				gamedata.items.vehicle[k] = entry;
			} else if (it is Weapon) {
				entry.category = "weapon";
				entry.type = (it as Weapon).type;
				entry.size = (it as Weapon).size;
				entry.dual = (it as Weapon).isDual();
				gamedata.items.weapon[k] = entry;
			} else if (it is WeaponRange) {
				entry.category = "weaponrange";
				gamedata.items.weaponrange[k] = entry;
			} else if (it is Useable) {
				entry.category = "useable";
				gamedata.items.useable[k] = entry;
			} else {
				entry.category = "other";
				gamedata.items.other[k] = entry;
			}
		}
		// item templates
		for (k in ItemTemplate.getLibrary()) {
			var tem:ItemTemplate = ItemTemplate.lookupTemplate(k);
			gamedata.itemTemplates[tem.templateId] = {
				id: tem.templateId,
				name: tem.name,
				metadata: deepCopy(tem.metadata)
			}
		}
		// statuses
		for (k in StatusEffectType.getStatusEffectLibrary()) {
			var st:StatusEffectType = StatusEffectType.lookupStatusEffect(k);
			gamedata.statuses[k] = {
				id: k,
				combat: st.create(0,0,0,0) is CombatStatusEffect
			}
		}
		// body part types
		// [target, enumValues, extraProperties]
		// extra props - array of propname or [nameInSource, nameInTarget]
		var bprec:Array = [
			[gamedata.bptypes.antennae, Antennae.Types],
			[gamedata.bptypes.arms, Arms.Types],
			[gamedata.bptypes.beard, Beard.Types],
			[gamedata.bptypes.claws, Claws.Types],
			[gamedata.bptypes.ears, Ears.Types],
			[gamedata.bptypes.eyes, Eyes.Types],
			[gamedata.bptypes.face, Face.Types],
			[gamedata.bptypes.gills, Gills.Types],
			[gamedata.bptypes.hair, Hair.Types],
			[gamedata.bptypes.hairstyle, Hair.Styles],
			[gamedata.bptypes.horns, Horns.Types],
			[gamedata.bptypes.legs, LowerBody.Types, ["legCount","canTaur","noTail","tail"]],
			[gamedata.bptypes.materials, BodyMaterial.Types],
			[gamedata.bptypes.rear, RearBody.Types],
			[gamedata.bptypes.skin, Skin.SkinTypes, ["base","coat",["name","desc"],"adj"]],
			[gamedata.bptypes.pattern, Skin.PatternTypes, ["base","coat"]],
			[gamedata.bptypes.tail, Tail.Types],
			[gamedata.bptypes.tongue, Tongue.Types],
			[gamedata.bptypes.vagina, VaginaClass.Types],
			[gamedata.bptypes.wings, Wings.Types, ["desc"]]
		];
		for each (var a:Array in bprec) {
			// a = [ target, EnumValue[], extra_props ]
			for each (var ev:Object in a[1]) {
				if (!ev) continue;
				entry = {
					value: ev.value,
					name: ev.name,
					id: ev.id
				};
				if (a[2]) {
					for each (var o:* in a[2]) {
						if (o is Array) {
							// [exported_name, enumvalue_name]
							entry[o[1]] = ev[o[0]]
						} else {
							entry[o] = ev[o];
						}
					}
				}
				a[0][ev.value] = entry;
			}
		}
		// colors
		var model:XML = XML(CoCLoader.getEmbedText("res/model.xml"));
		var map:Object = {}
		for each(var prop:XML in model.palette.property) {
			for each (var color:XML in prop.color) {
				k = color.@name.toString();
				map[k] = {
					name: k,
					rgb: color.text().toString()
				};
			}
		}
		for each(color in model.palette.common.color) {
			k = color.@name.toString();
			map[k] = {
				name: k,
				rgb: color.text().toString()
			};
		}
		gamedata.colors = values(map).sort();
		// stats
		for each (var stat:IStat in p.statStore.allStats()) {
			entry = {
				id: stat.statName,
				name: StatUtils.nameOfStat(stat.statName),
				isPercentage: StatUtils.isPercentageStat(stat.statName)
			};
			if (stat is BuffableStat) {
				entry.type = "buffable";
				entry.base = (stat as BuffableStat).base;
				entry.aggregate = (stat as BuffableStat).aggregate;
			} else if (stat is RawStat) {
				entry.type = "raw";
			} else if (stat is PrimaryStat) {
				entry.type = "primary";
			} else {
				entry.type = "unknown"
			}
			gamedata.stats.push(entry);
		}
		
		bytes.writeUTFBytes(
				"// GENERATED FOR " + CoC.instance.version + "\n" +
				"/** @type {IExportedGameData} */\n" +
				"let ExportedGamedata=");
		bytes.writeUTFBytes(JSON.stringify(gamedata));
		file.save(bytes, "gamedata.js");
	}
	public function settingsScreenGameSettings2():void {
		clearOutput();
		displayHeader("Gameplay Settings");
		if (debug) outputText("Debug Mode: [font-green]<b>ON</b>[/font]\n Items will not be consumed by use, fleeing always succeeds, and bad-ends can be ignored.");
		else outputText("Debug Mode: [font-dred]<b>OFF</b>[/font]\n Items consumption will occur as normal.");
		outputText("\n\n");
		if (flags[kFLAGS.SILLY_MODE_ENABLE_FLAG])
			outputText("Silly Mode: [font-green]<b>ON</b>[/font]\n Crazy, nonsensical, and possibly hilarious things may occur.");
		else
			outputText("Silly Mode: [font-dred]<b>OFF</b>[/font]\n You're an incorrigable stick-in-the-mud with no sense of humor.");
		outputText("\n\n");
		if (flags[kFLAGS.LOW_STANDARDS_FOR_ALL]) {
			outputText("Low standards Mode: [font-green]<b>ON</b>[/font]\n NPCs ignore body type preferences.");
			outputText("\n (Not gender preferences though. You still need the right hole.)");
		}
		else
			outputText("Low standards Mode: [font-dred]<b>OFF</b>[/font]\n NPCs have body-type preferences.");
		outputText("\n\n");
		if (flags[kFLAGS.HYPER_HAPPY]) {
			outputText("Hyper Happy Mode: [font-green]<b>ON</b>[/font]\n Only reducto and humus shrink endowments.");
			outputText("\n Incubus draft doesn't affect breasts, and succubi milk doesn't affect cocks.")
		}
		else
			outputText("Hyper Happy Mode: [font-dred]<b>OFF</b>[/font]\n Male enhancement potions shrink female endowments, and vice versa.");
		outputText("\n\n");
		if (flags[kFLAGS.ITS_EVERY_DAY]) {
			outputText("Eternal Holiday Mode: [font-green]<b>ON</b>[/font]\n All holiday events like Eastern/X-mas and etc. can happen at any day of the year.");
		}
		else
			outputText("Eternal Holiday Mode: [font-dred]<b>OFF</b>[/font]\n All holiday events happen only during their respective holiday times.");
		outputText("\n\n");
		if (flags[kFLAGS.STRENGTH_SCALING] >= 1) {
			outputText("Strength Scaling: [font-green]<b>New</b>[/font]\n Values are less random and a bit higher on average than in old scaling.");
		}
		else
			outputText("Strength Scaling: [font-dred]<b>Old</b>[/font]\n Values are more random and a bit lower on average than in new scaling.");
		outputText("\n\n");
		if (flags[kFLAGS.SPEED_SCALING] >= 1) {
			outputText("Speed Scaling: [font-green]<b>New</b>[/font]\n Values are less random and a bit higher on average than in old scaling.");
		}
		else
			outputText("Speed Scaling: [font-dred]<b>Old</b>[/font]\n Values are more random and a bit lower on average than in new scaling.");
		outputText("\n\n");
		if (flags[kFLAGS.WISDOM_SCALING] >= 1) {
			outputText("Wisdom Scaling: [font-green]<b>New</b>[/font]\n Values are less random and a bit higher on average than in old scaling.");
		}
		else
			outputText("Wisdom Scaling: [font-dred]<b>Old</b>[/font]\n Values are more random and a bit lower on average than in new scaling.");
		outputText("\n\n");
		if (flags[kFLAGS.INTELLIGENCE_SCALING] >= 1) {
			outputText("Intelligence Scaling: [font-green]<b>New</b>[/font]\n Values are less random and a bit higher on average than in old scaling.");
		}
		else
			outputText("Intelligence Scaling: [font-dred]<b>Old</b>[/font]\n Values are more random and a bit lower on average than in new scaling.");
		outputText("\n\n");
		menu();
		addButton(0, "Toggle Debug", toggleDebug).hint("Turn on debug mode. Debug mode is intended for testing purposes but can be thought of as a cheat mode.  Items are infinite and combat is easy to escape from.  Weirdness and bugs are to be expected.");
		addButton(1, "Silly Toggle", toggleFlag, kFLAGS.SILLY_MODE_ENABLE_FLAG, settingsScreenGameSettings2).hint("Toggles silly mode. Funny, crazy and nonsensical scenes may occur if enabled.");
		addButton(2, "Low Standards", toggleFlag, kFLAGS.LOW_STANDARDS_FOR_ALL, settingsScreenGameSettings2);
		addButton(3, "Hyper Happy", toggleFlag, kFLAGS.HYPER_HAPPY, settingsScreenGameSettings2);
		addButton(4, "Eternal Holiday", toggleFlag, kFLAGS.ITS_EVERY_DAY, settingsScreenGameSettings2).hint("Toggles eternal holiday mode. All holiday events like Eastern/X-mas and etc. can happen at any day of the year.");
		addButton(5, "Wis scaling", toggleFlag, kFLAGS.WISDOM_SCALING, settingsScreenGameSettings2).hint("Toggles Wisdom scaling for all attacks using it. If enabled, wisdom scaling would be less random with big generally a bit higher values on average.");
		addButton(6, "Int scaling", toggleFlag, kFLAGS.INTELLIGENCE_SCALING, settingsScreenGameSettings2).hint("Toggles Intelligance scaling for all attacks using it. If enabled, intelligence scaling would be less random with values being a bit higher on average.");
		addButton(7, "Str scaling", toggleFlag, kFLAGS.STRENGTH_SCALING, settingsScreenGameSettings2).hint("Toggles Strength scaling for all attacks using it. If enabled, strength scaling would be less random with values being a bit higher on average.");
		addButton(8, "Spe scaling", toggleFlag, kFLAGS.SPEED_SCALING, settingsScreenGameSettings2).hint("Toggles Speed scaling for all attacks using it. If enabled, speed scaling would be less random with values being a bit higher on average.");
		if (CoC_Settings.debugBuild) {
			outputText("ILLY Protocol: "+(player.hasStatusEffect(StatusEffects.ILLYProtocol)?"Active (No Cheats menu for you)":"Not active (Cheat menu is all yours)")+"");
			outputText("\n\n");
			if (player) {
				if (player.hasStatusEffect(StatusEffects.ILLYProtocol)) addButton(13, "ILLY Protocol Off", ILLYProtocolOff).hint("Show Cheats in test builds.");
				else addButton(13, "ILLY Protocol On", ILLYProtocolOn).hint("Hide Cheats in test builds.");
			}
			else addButtonDisabled(13, "ILLY Protocol", "Requires a loaded save.");
		}
		addButton(14, "Back", settingsScreenMain);
	}

	public function toggleFlag(flagID:int, menuFun:Function):void {
		flags[flagID] = !flags[flagID];
		menuFun();
	}
	private function ILLYProtocolOn():void {
		player.createStatusEffect(StatusEffects.ILLYProtocol, 0, 0, 0, 0);
		settingsScreenGameSettings2();
	}
	private function ILLYProtocolOff():void {
		player.removeStatusEffect(StatusEffects.ILLYProtocol);
		settingsScreenGameSettings2();
	}

	public function settingsScreenQoLSettings():void{
		clearOutput();
		displayHeader("Quality of Life Settings");
		outputText("This page contains settings that can affect the game's performance, appearance, and other tedious tasks.\n\n");
		fastLvlSettings();
		mutationsSpoilersSetting();
		simpPerkSetting();
		invMgmtSetting();
		USSdisplayOpt();
		IMDBdisplayStyle();
		outputText("\n\n");
		menu();
		addButton(0, "Fast Lvl", flagUpdate, kFLAGS.LVL_UP_FAST, 2).hint("Immediately level to the highest possible from XP instead of spamming next.");
		addButton(1, "Mutation Assist", flagUpdate, kFLAGS.MUTATIONS_SPOILERS, 1).hint("Mutation Tracker Spoiler Mode. For when you want to discover mutations by yourself, or with some help.");
		addButton(2, "PerkView Simplfied", flagUpdate, kFLAGS.NEWPERKSDISPLAY, 1).hint("Simplified Perk Viewing. So duplicate entries/tiers don't show up.");
		addButton(3, "Inventory Mgmt", flagUpdate, kFLAGS.INVT_MGMT_TYPE, 1).hint("Toggle between existing SHIFT to remove items vs an extra menu. Recommended to enable for Mobile users.");
		addButton(4,"USS Display Opt.", flagUpdate, kFLAGS.USSDISPLAY_STYLE,1).hint("Switches between USS Display options.");
		addButton(5,"IMDB Details", flagUpdate, kFLAGS.IMDB_DETAILS,1).hint("Switches between Internal Mutation DB display styles.");
		addButton(14, "Back", settingsScreenMain);
		function fastLvlSettings():void{
			if (flags[kFLAGS.LVL_UP_FAST] == 2) {
				outputText("Instant Leveling: [font-green]<b>ON, Direct Jump</b>[/font]\nInstantly levels you up to the highest possible given your xp.");
			}
			else if (flags[kFLAGS.LVL_UP_FAST] == 1){
				outputText("Instant Leveling: [font-blue]<b>ON, Manual Increase</b>[/font]\nIncrease XP by specific amounts.");
			}
			else {
				outputText("Instant Leveling: [font-dred]<b>OFF</b>[/font]\nIndividual leveling up, i.e. One level click at a time.");
			}
			outputText("\nThis setting has three modes: Default(Levelling up one at a time), Direct(Auto-calculates your highest and sets accordingly), and Manual(You are given the option to increase levels in increments.)");
			outputText("Works in conjunction with Auto-Leveling.");
			outputText("\n\n");
		}

		function mutationsSpoilersSetting():void {
			if (flags[kFLAGS.MUTATIONS_SPOILERS] >= 1){
				outputText("Mutation Assist: [font-green]<b>ON</b>[/font]\nAll mutations are known, and hints to acquire them are provided.");
			}
			else {
				outputText("Mutation Assist: [font-dred]<b>OFF</b>[/font]\nFor players that want to discover the mutations by themselves.");
			}
			outputText("\n\n");
		}

		function simpPerkSetting():void{
			if (flags[kFLAGS.NEWPERKSDISPLAY] >= 1){
				outputText("Perks Display: [font-green]<b>Enabled</b>[/font]\nPerks are collapsed to their highest tier. Use this for faster perks menu loading, and less clutter.");
			}
			else {
				outputText("Perks Display: [font-dred]<b>Disabled</b>[/font]\nPerks display uses old method of displaying all perks. Use this for getting all perk information, but higher loading lag and a whole menu of perks.");
			}
			outputText("\n\n");
		}

		function invMgmtSetting():void{
			if (flags[kFLAGS.INVT_MGMT_TYPE] > 0){
				outputText("Inventory Mgmt: <b>New</b>\n A prompt will appear asking you what you want to do with the item.");
			}
			else{
				outputText("Inventory Mgmt: <b>Old</b>\n Shift key is required for removing items.");
			}
			outputText("This toggle is most useful for mobile players where the shift key is not available, but is functional for desktop use too.");
			outputText("\n\n");
		}

		function USSdisplayOpt():void{
			if (flags[kFLAGS.USSDISPLAY_STYLE] > 0){
				outputText("USS Display: <b>Old</b>\n All options will be shown.");
			}
			else{
				outputText("USS Display: <b>Shuffled</b>\n Options that can be used will show up first.");
			}
			outputText("This toggle is used to hide extra scenes.");
			outputText("\n\n");
		}

		function IMDBdisplayStyle():void{
			if (flags[kFLAGS.IMDB_DETAILS] > 0){
				outputText("IMDB style: <b>Detailed</b>\n All mutation tiers will be displayed.");
			}
			else{
				outputText("IMDB style: <b>Short</b>\n Only the next tier will be displayed for each mutation.");
			}
			outputText("This toggle is used to show more info in Internal Mutation Database.");
			outputText("\n\n");
		}

		function flagUpdate(flag:*, max:int = 1):void{
			flags[flag]++;
			if (flags[flag] > max) flags[flag] = 0;
			settingsScreenQoLSettings();
		}
	}

	public function toggleDebug():void {
		//toggle debug
		debug = !debug;
		mainView.showMenuButton(MainView.MENU_DATA);
		settingsScreenGameSettings2();
	}

	public function fetishSubMenu():void {
		menu();
		addButton(0, "Watersports", toggleFlag, kFLAGS.WATERSPORTS_ENABLED, fetishSubMenu).hint("Toggles watersports scenes. (Scenes related to urine fetish)","Watersports "+(flags[kFLAGS.WATERSPORTS_ENABLED] < 1? "OFF" : "ON")); //Enables watersports.
		if (player.hasStatusEffect(StatusEffects.WormsOn) || player.hasStatusEffect(StatusEffects.WormsOff)) addButton(1, "Worms", toggleWormsMenu).hint("Enable or disable worms. This will NOT cure infestation, if you have any.");
		else addButtonDisabled(1, "Worms", "Find the sign depicting the worms in the mountains to unlock this.");
		addButtonIfTrue(2, "Mindbreaker", toggleMindbreaker, "You are too late, you cannot turn back now!", Mindbreaker.MindBreakerQuest < Mindbreaker.QUEST_STAGE_ISMB,"Toggles Mindbreaker scenes.", "Mindbreaker "+(Mindbreaker.MindBreakerQuest == Mindbreaker.QUEST_STAGE_MBOFF? "OFF":"ON"));
		addButton(4, "Back", settingsScreenGameSettings);
	}

	private function toggleWormsMenu():void {
		clearOutput();
		if (player.hasStatusEffect(StatusEffects.WormsOn)) {
			outputText("You have chosen to encounter worms as you find the mountains");
			if (player.hasStatusEffect(StatusEffects.WormsHalf)) outputText(" albeit at reduced encounter rate");
			outputText(". You can get infested.");
		}
		if (player.hasStatusEffect(StatusEffects.WormsOff)) {
			outputText("You have chosen to avoid worms. You won't be able to get infested.");
		}
		menu();
		addButton(0, "Enable", setWorms, true, false);
		addButton(1, "Enable (Half)", setWorms, true, true);
		addButton(2, "Disable", setWorms, false, false);
		addButton(4, "Back", fetishSubMenu);
	}

	private function setWorms(enabled:Boolean, half:Boolean):void {
		//Clear status effects
		if (player.hasStatusEffect(StatusEffects.WormsOn)) player.removeStatusEffect(StatusEffects.WormsOn);
		if (player.hasStatusEffect(StatusEffects.WormsHalf)) player.removeStatusEffect(StatusEffects.WormsHalf);
		if (player.hasStatusEffect(StatusEffects.WormsOff)) player.removeStatusEffect(StatusEffects.WormsOff);
		//Set status effects
		if (enabled) {
			player.createStatusEffect(StatusEffects.WormsOn, 0, 0, 0, 0);
			if (half) player.createStatusEffect(StatusEffects.WormsHalf, 0, 0, 0, 0);
		}
		else {
			player.createStatusEffect(StatusEffects.WormsOff, 0, 0, 0, 0);
		}
		toggleWormsMenu();
	}

	public function toggleMindbreaker():void {
		if (Mindbreaker.MindBreakerQuest == Mindbreaker.QUEST_STAGE_MBOFF)
			Mindbreaker.MindBreakerQuest = Mindbreaker.QUEST_STAGE_NOT_STARTED;
		else if (Mindbreaker.MindBreakerQuest < Mindbreaker.QUEST_STAGE_ISMB)
				Mindbreaker.MindBreakerQuest = Mindbreaker.QUEST_STAGE_MBOFF
		fetishSubMenu();
	}

	public function enableHardcoreModifierForReal():void {
		clearOutput();
		outputText("Hardcore modifier is now enabled.");
		flags[kFLAGS.HARDCORE_MODE] = 1;
		setTheFuckingDifficultyForFuckingGood();
		doNext(settingsScreenGameSettings);
	}
	public function disableHardcoreModifierForReal():void {
		clearOutput();
		outputText("Hardcore modifier is now disabled.");
		flags[kFLAGS.HARDCORE_MODE] = 0;
		setTheFuckingDifficultyForFuckingGood();
		doNext(settingsScreenGameSettings);
	}
	public function disableHungerModifierForReal():void {
		clearOutput();
		outputText("Hunger & Realistic modifier is now disabled.");
		flags[kFLAGS.HUNGER_ENABLED] = 0;
		setTheFuckingDifficultyForFuckingGood();
		doNext(settingsScreenGameSettings);
	}
	public function enableHungerModifierForReal():void {
		clearOutput();
		outputText("Hunger modifier is now enabled.");
		flags[kFLAGS.HUNGER_ENABLED] = 0.5;
		setTheFuckingDifficultyForFuckingGood();
		doNext(settingsScreenGameSettings);
	}
	public function enableRealisticModifierForReal():void {
		clearOutput();
		outputText("Realistic Mode modifier is now enabled.");
		flags[kFLAGS.HUNGER_ENABLED] = 1;
		setTheFuckingDifficultyForFuckingGood();
		doNext(settingsScreenGameSettings);
	}
	public function difficultySelectionMenu1():void {
		clearOutput();
		outputText("You can choose a prime difficulty to set how hard battles will be.\n");
		if (flags[kFLAGS.PRIMARY_DIFFICULTY] <= 0) outputText("\n No opponent(s) stats modifiers. You can resume from bad-ends with penalties. No penatlies for too high wrath. Internal mutation negative effects will be triggered after accumulating 11 points in internal mutation score.");
		else if (flags[kFLAGS.PRIMARY_DIFFICULTY] == 1) outputText("\n Opponent(s) take 2x less HP/Lust dmg, deal 20% more damage and gives ~20% more EXP. No penatlies for too high wrath. Bad-ends can ruin your game. Internal mutation negative effects will be triggered after accumulating 6 points in internal mutation score. (+1 diff modifier)");
		else if (flags[kFLAGS.PRIMARY_DIFFICULTY] == 2) outputText("\n Opponent(s) take 5x less HP/Lust dmg, deal 50% more damage and gives ~50% more EXP. If you want to spellcast or use magic specials, you have to pay attention to your accumulated wrath. Additionally, the negative effects of internal mutations begin immediately. (+1 diff modifier)");
		else if (flags[kFLAGS.PRIMARY_DIFFICULTY] == 3) outputText("\n Opponent(s) take 10x less HP/Lust dmg, deal more 100% damage and gives ~100% more EXP. If you want to spellcast or use magic specials, you have to pay attention to your accumulated wrath. Additionally, the negative effects of internal mutations begin immediately. (+1 diff modifier)");
		else if (flags[kFLAGS.PRIMARY_DIFFICULTY] == 4) outputText("\n Opponent(s) take 25x less HP/Lust dmg, deal more 250% damage and gives ~150% more EXP. If you want to spellcast or use magic specials, you have to pay attention to your accumulated wrath. Additionally, the negative effects of internal mutations begin immediately. (+1 diff modifier)");
		menu();
		if (flags[kFLAGS.PRIMARY_DIFFICULTY] != 0) addButton(0, "-0-", chooseDifficulty1, 0);
		if (flags[kFLAGS.PRIMARY_DIFFICULTY] != 1) addButton(1, "-1-", chooseDifficulty1, 1);
		if (flags[kFLAGS.PRIMARY_DIFFICULTY] != 2) addButton(2, "-2-", chooseDifficulty1, 2);
		if (flags[kFLAGS.PRIMARY_DIFFICULTY] != 3) addButton(3, "-3-", chooseDifficulty1, 3);
		if (flags[kFLAGS.PRIMARY_DIFFICULTY] != 4) addButton(4, "-4-", chooseDifficulty1, 4);
		addButton(14, "Back", settingsScreenGameSettings);
	}
	public function chooseDifficulty1(difficulty:int = 0):void {
		flags[kFLAGS.PRIMARY_DIFFICULTY] = difficulty;
		setTheFuckingDifficultyForFuckingGood();
		settingsScreenGameSettings();
	}
	public function difficultySelectionMenu2():void {
		clearOutput();
		outputText("You can choose a difficulty to set how hard battles will be.\n");
		if (flags[kFLAGS.SECONDARY_STATS_SCALING] == 0) outputText("\n No stats changes.");
		if (flags[kFLAGS.SECONDARY_STATS_SCALING] == 1) outputText("\n 10x (bosses) and 5x (rest) multi for secondary stats for monsters. (+1 diff modifier)");
		if (flags[kFLAGS.SECONDARY_STATS_SCALING] == 2) outputText("\n 30x (bosses) and 10x (rest) multi for secondary stats for monsters. (+1 diff modifier)");
		if (flags[kFLAGS.SECONDARY_STATS_SCALING] == 3) outputText("\n 100x (bosses) and 25x (rest) multi for secondary stats for monsters. (+1 diff modifier)");
		if (flags[kFLAGS.SECONDARY_STATS_SCALING] == 4) outputText("\n 500x (bosses) and 100x (rest) multi for secondary stats for monsters. (+1 diff modifier)");
		if (flags[kFLAGS.SECONDARY_STATS_SCALING] == 5) outputText("\n 1500x (bosses) and 500x (rest) multi for secondary stats for monsters. (+1 diff modifier)");
		if (flags[kFLAGS.SECONDARY_STATS_SCALING] >= 6) outputText("\n 21000x (bosses) and 3000x (rest) multi for secondary stats for monsters. (+1 diff modifier)");
		menu();
		if (flags[kFLAGS.SECONDARY_STATS_SCALING] != 0) addButton(0, "1x", chooseDifficulty2, 0);
		if (flags[kFLAGS.SECONDARY_STATS_SCALING] != 1) addButton(1, "5x", chooseDifficulty2, 1);
		if (flags[kFLAGS.SECONDARY_STATS_SCALING] != 2) addButton(2, "10x", chooseDifficulty2, 2);
		if (flags[kFLAGS.SECONDARY_STATS_SCALING] != 3) addButton(3, "25x", chooseDifficulty2, 3);
		if (flags[kFLAGS.SECONDARY_STATS_SCALING] != 4) addButton(4, "100x", chooseDifficulty2, 4);
		if (flags[kFLAGS.SECONDARY_STATS_SCALING] != 5) addButton(5, "500x", chooseDifficulty2, 5);
		if (flags[kFLAGS.SECONDARY_STATS_SCALING] != 6) addButton(5, "3000x", chooseDifficulty2, 6);
		addButton(14, "Back", settingsScreenGameSettings);
	}
	public function chooseDifficulty2(difficulty:int = 0):void {
		flags[kFLAGS.SECONDARY_STATS_SCALING] = difficulty;
		setTheFuckingDifficultyForFuckingGood();
		settingsScreenGameSettings();
	}
	public function difficultySelectionMenu3():void {
		clearOutput();
		outputText("You can choose how hard elite/champion/boss battles will be.\n");
		outputText("\n<b>Normal:</b> No stats changes.");
		outputText("\n<b>Fantasy:</b> 1.25x/2.5x/5x HP for elite/champion/boss monsters. (+1 diff modifier)");
		outputText("\n<b>Torment:</b> 2.5x/5x/10x HP for elite/champion/boss monsters. (+1 diff modifier)");
		outputText("\n<b>Infernium:</b> 3.75x/7.5x/15x HP for elite/champion/boss monsters. (+1 diff modifier)");
		outputText("\n<b>Hell:</b> 5x/10x/20x HP for elite/champion/boss monsters. (+1 diff modifier)");
		menu();
		if (flags[kFLAGS.BOSS_CHAMPION_ELITE_SCALING] != 0) addButton(0, "Normal", chooseDifficulty3, 0);
		if (flags[kFLAGS.BOSS_CHAMPION_ELITE_SCALING] != 1) addButton(1, "Fantasy", chooseDifficulty3, 1);
		if (flags[kFLAGS.BOSS_CHAMPION_ELITE_SCALING] != 2) addButton(2, "Torment", chooseDifficulty3, 2);
		if (flags[kFLAGS.BOSS_CHAMPION_ELITE_SCALING] != 3) addButton(3, "Infernium", chooseDifficulty3, 3);
		if (flags[kFLAGS.BOSS_CHAMPION_ELITE_SCALING] != 4) addButton(4, "Hell", chooseDifficulty3, 4);
		addButton(14, "Back", settingsScreenGameSettings);
	}
	public function chooseDifficulty3(difficulty:int = 0):void {
		flags[kFLAGS.BOSS_CHAMPION_ELITE_SCALING] = difficulty;
		setTheFuckingDifficultyForFuckingGood();
		settingsScreenGameSettings();
	}
	private function setTheFuckingDifficultyForFuckingGood():void {
		var sTFDFFG:Number = 0;
		if (flags[kFLAGS.PRIMARY_DIFFICULTY] > 0) sTFDFFG += 1;
		if (flags[kFLAGS.SECONDARY_STATS_SCALING] > 0) sTFDFFG += 1;
		if (flags[kFLAGS.BOSS_CHAMPION_ELITE_SCALING] > 0) sTFDFFG += 1;
		if (flags[kFLAGS.HUNGER_ENABLED] > 0) sTFDFFG += 1;
		if (flags[kFLAGS.HARDCORE_MODE] > 0) sTFDFFG += 1;
		flags[kFLAGS.GAME_DIFFICULTY] = sTFDFFG;
	}

	//------------
	// INTERFACE
	//------------
	public function settingsScreenInterfaceSettings():void {
		clearOutput();
		displayHeader("Interface Settings");

		if (flags[kFLAGS.USE_OLD_FONT] >= 1) {
			outputText("Font: <b>Lucida Sans Typewriter</b>\n");
		}
		else
			outputText("Font: <b>Georgia</b>\n");

		outputText("\n\n");

		outputText("Char Viewer: ");
		if (flags[kFLAGS.CHARVIEWER_ENABLED] == 1) outputText("[font-green]<b>ON</b>[/font]\n Player visualiser is available under \\[Appearance\\].");
		else outputText("[font-dred]<b>OFF</b>[/font]\n Player visualiser is disabled.");
		outputText("\nChar View Style: ");
		switch (flags[kFLAGS.CHARVIEW_STYLE]) {
			case 0:
				outputText("[font-blue]<b>ALWAYS</b>[/font]\n Viewer is shown on the left, always visible");
				break;
			case 1:
				outputText("[font-dred]<b>OLD</b>[/font]\n Viewer is shown on the left");
				break;
			case 2:
				outputText("[font-green]<b>NEW</b>[/font]\n Viewer is inline with text");
				break;
		}
		outputText("\nChar View Armor: ");
		if (flags[kFLAGS.CHARVIEW_ARMOR_HIDDEN])
            outputText("[font-dred]<b>OFF</b>[/font]\n Armor is hidden - enjoy your naked look!");
		else
            outputText("[font-green]<b>ON</b>[/font]\n Armor is shown (some body parts may be hidden or displayed wrongly)");
		
        outputText("\n\n");
		if (flags[kFLAGS.IMAGEPACK_OFF] == 0) {
			outputText("Image Pack: [font-green]<b>ON</b>[/font]\n Image pack is enabled.");
		}
		else
			outputText("Image Pack: [font-dred]<b>OFF</b>[/font]\n Image pack is disabled.");

		outputText("\n\n");

		if (flags[kFLAGS.SHOW_SPRITES_FLAG] == 0) {
			outputText("Sprites: [font-green]<b>ON</b>[/font]\n You like to look at pretty pictures.");
			outputText("\n\n");
			if (flags[kFLAGS.SPRITE_STYLE] == 0)
				outputText("Sprite Type: <b>New</b>\n 16-bit sprites will be used.");
			else
				outputText("Sprite Type: <b>Old</b>\n 8-bit sprites will be used.");
		}
		else {
			outputText("Sprites: [font-dred]<b>OFF</b>[/font]\n There are only words. Nothing else.");
			outputText("\n\n\n");
		}

		outputText("\n\n");

		if (flags[kFLAGS.USE_12_HOURS] > 0)
			outputText("Time Format: <b>12 hours</b>\n Time will display in 12 hours format (AM/PM)");
		else
			outputText("Time Format: <b>24 hours</b>\n Time will display in 24 hours format.");

		outputText("\n\n");

		if (flags[kFLAGS.USE_METRICS] == 1)
			outputText("Measurement: <b>Metric</b>\n Height and cock size will be measured in metres and centimetres.");
		else if (flags[kFLAGS.USE_METRICS] == 0)
			outputText("Measurement: <b>Imperial</b>\n Height and cock size will be measured in feet and inches. (Worded)");
		else	//Yes, this is 2. Yes, this was added as an afterthought.
			outputText("Measurement: <b>Imperial</b>\n Height and cock size will be measured in feet and inches. (Symbols)");
		outputText("\n\n");
		
		if (buttonIconsEnabled)
			outputText("Button icons: <b>ON</b>");
		else
			outputText("Button icons: <b>OFF</b>");
		outputText("\n\n");
		
		if (flags[kFLAGS.STATBAR_ANIMATIONS] == 1)
			outputText("Stat bar animations: <b>OFF</b>");
		else
			outputText("Stat bar animations: <b>ON</b>");
		outputText("\n\n");

		if (flags[kFLAGS.HP_STATBAR_PERCENTAGE] == 0)
			outputText("HP bars show percentages: <b>OFF</b>");
		else
			outputText("HP bars show percentages: <b>ON</b>");
		outputText("\n\n");

		if (flags[kFLAGS.LUST_STATBAR_PERCENTAGE] == 0)
			outputText("Lust bars show percentages: <b>OFF</b>");
		else
			outputText("Lust bars show percentages: <b>ON</b>");
		outputText("\n\n");

		if (flags[kFLAGS.WRATH_STATBAR_PERCENTAGE] == 0)
			outputText("Wrath bars show percentages: <b>OFF</b>");
		else
			outputText("Wrath bars show percentages: <b>ON</b>");
		outputText("\n\n");
		
		if (flags[kFLAGS.ANGELIC_FRACTION_TOGGLE] == 0)
			outputText("Angelic Faction: <b>FULL PRESENCE</b>");
		else
			outputText("Angelic Faction: <b>ABSENT</b>");
		outputText("\n\n");

		var buttons:ButtonDataList = new ButtonDataList();
		menu();
		buttons.add("Side Bar Font", curry(toggleFlag, kFLAGS.USE_OLD_FONT, settingsScreenInterfaceSettings), "Toggle between old and new font for side bar.");
		buttons.add("Main BG", menuMainBackground, "Choose a background for main game interface.");
		buttons.add("Text BG", menuTextBackground, "Choose a background for text.");
		buttons.add("Sprites", menuSpriteSelect, "Turn sprites on/off and change sprite style preference.");
		buttons.add("Charview Style",toggleCharViewerStyle, "Change between in text and sidebar display");
		buttons.add("Toggle Images", toggleImages, "Enable or disable image pack.");
		buttons.add("Time Format", toggleTimeFormat, "Toggles between 12-hour and 24-hour format.");
		buttons.add("Measurements", toggleMeasurements, "Switch between imperial and metric measurements.  \n\nNOTE: Only applies to your appearance screen.");
		buttons.add("Toggle CharView", toggleCharViewer, "Turn PC visualizer on/off.");
		buttons.add("Charview Armor", curry(toggleFlag, kFLAGS.CHARVIEW_ARMOR_HIDDEN, settingsScreenInterfaceSettings), "Turn PC armor and underwear display on/off");
		buttons.add("Button Icons", curry(toggleFlag, kFLAGS.BUTTON_ICONS_DISABLED, settingsScreenInterfaceSettings));
		buttons.add("Statbar Anim.", curry(toggleFlag, kFLAGS.STATBAR_ANIMATIONS, settingsScreenInterfaceSettings), "Toggle stat bar animations when value changes");
		buttons.add("HP Percent", curry(toggleFlag, kFLAGS.HP_STATBAR_PERCENTAGE, settingsScreenInterfaceSettings), "Toggle between showing the HP stat as a percentage");
		buttons.add("Lust Percent", curry(toggleFlag, kFLAGS.LUST_STATBAR_PERCENTAGE, settingsScreenInterfaceSettings), "Toggle between showing the Lust stat as a percentage");
		buttons.add("Wrath Percent", curry(toggleFlag, kFLAGS.WRATH_STATBAR_PERCENTAGE, settingsScreenInterfaceSettings), "Toggle between showing the Wrath stat as a percentage");
		buttons.add("Angelic Fract", curry(toggleFlag, kFLAGS.ANGELIC_FRACTION_TOGGLE, settingsScreenInterfaceSettings), "Toggle between full and no presence of angelic fraction ingame");
		submenu(buttons, settingsScreenMain, 0, false);
	}
	public function menuMainBackground():void {
		menu();
		addButton(0, "Map (Default)", setMainBackground, 0);
		addButton(1, "Parchment", setMainBackground, 1);
		addButton(2, "Marble", setMainBackground, 2);
		addButton(3, "Obsidian", setMainBackground, 3);
		addButton(4, "Black", setMainBackground, 4);

		addButton(14, "Back", settingsScreenInterfaceSettings);
	}

	public function menuTextBackground():void {
		menu();
		addButton(0, "Normal", setTextBackground, 0);
		addButton(1, "White", setTextBackground, 1);
		addButton(2, "Tan", setTextBackground, 2);

		addButton(14, "Back", settingsScreenInterfaceSettings);
	}

	public function menuSpriteSelect():void {
		menu();
		addButton(0, "Off", toggleSpritesFlag, true, 0, null, "Turn off the sprites completely");
		addButton(1, "Old", toggleSpritesFlag, false, 1, null, "Use the 8-bit sprites from older versions of CoC.");
		addButton(2, "New", toggleSpritesFlag, false, 0, null, "Use the 16-bit sprites in current versions of CoC.");

		addButton(14, "Back", settingsScreenInterfaceSettings);
	}

	public function toggleCharViewer(flag:int = kFLAGS.CHARVIEWER_ENABLED):void {
		if (flags[flag] < 1) {
			flags[flag] = 1;
			mainView.charView.reload();
		} else {
			flags[flag] = 0;
		}
		settingsScreenInterfaceSettings();
	}
	public function toggleCharViewerStyle():void {
		flags[kFLAGS.CHARVIEW_STYLE] = (flags[kFLAGS.CHARVIEW_STYLE]+1)%3;
		settingsScreenInterfaceSettings();
	}

	public function setMainBackground(type:int):void {
			flags[kFLAGS.BACKGROUND_STYLE]     = type;
			mainViewManager.setTheme();
			settingsScreenInterfaceSettings();
		}

	public function setTextBackground(type:int):void {
		mainView.textBGWhite.visible = false;
		mainView.textBGTan.visible   = false;
		if (type == 1) mainView.textBGWhite.visible = true;
		if (type == 2) mainView.textBGTan.visible = true;
		settingsScreenInterfaceSettings();
	}

	public function toggleSpritesFlag(enabled:Boolean, style:int):void {
		flags[kFLAGS.SHOW_SPRITES_FLAG] = enabled;
		flags[kFLAGS.SPRITE_STYLE]      = style;
		settingsScreenInterfaceSettings();

	}

	public function toggleImages():void {
		if (flags[kFLAGS.IMAGEPACK_OFF] < 1) flags[kFLAGS.IMAGEPACK_OFF] = 1;
		else flags[kFLAGS.IMAGEPACK_OFF] = 0;
		settingsScreenInterfaceSettings();
	}

	public function toggleTimeFormat():void {
		if (flags[kFLAGS.USE_12_HOURS] < 1) flags[kFLAGS.USE_12_HOURS] = 1;
		else flags[kFLAGS.USE_12_HOURS] = 0;
		settingsScreenInterfaceSettings();
	}

	public function toggleMeasurements():void {
		if (flags[kFLAGS.USE_METRICS] < 2) flags[kFLAGS.USE_METRICS] += 1;
		else flags[kFLAGS.USE_METRICS] = 0;
		settingsScreenInterfaceSettings();
	}

	//------------
	// FONT SETTINGS
	//------------
	public function fontSettingsMenu():void {
		menu();
		simpleChoices("Smaller Font", decFontSize,
				"Larger Font", incFontSize,
				"Reset Size", resetFontSize,
				"", null,
				"Back", settingsScreenMain);
	}

	public function incFontSize():void {
		var fmt:TextFormat = mainView.mainText.getTextFormat();

		if (fmt.size == null) fmt.size = 20;

		fmt.size = (fmt.size as Number) + 1;

		if ((fmt.size as Number) > 32) fmt.size = 32;

		trace("Font size set to: " + (fmt.size as Number));
		mainView.mainText.setTextFormat(fmt);
		flags[kFLAGS.CUSTOM_FONT_SIZE] = fmt.size;
	}

	public function decFontSize():void {
		var fmt:TextFormat = mainView.mainText.getTextFormat();

		if (fmt.size == null) fmt.size = 20;

		fmt.size = (fmt.size as Number) - 1;

		if ((fmt.size as Number) < 14) fmt.size = 14;

		trace("Font size set to: " + (fmt.size as Number));
		mainView.mainText.setTextFormat(fmt);
		flags[kFLAGS.CUSTOM_FONT_SIZE] = fmt.size;
	}

	public function resetFontSize():void {
		var fmt:TextFormat = mainView.mainText.getTextFormat();
		if (fmt.size == null) fmt.size = 20;
		fmt.size = 20;
		mainView.mainText.setTextFormat(fmt);
		flags[kFLAGS.CUSTOM_FONT_SIZE] = 0;
	}

    private function displayControls():void
    {
        mainView.hideAllMenuButtons();
        CoC.instance.inputManager.DisplayBindingPane();
        EngineCore.menu();
        EngineCore.addButton(0, "Reset Ctrls", resetControls);
        EngineCore.addButton(1, "Clear Ctrls", clearControls);
        EngineCore.addButton(4, "Back", hideControls);
    }

    private function hideControls():void
    {
        CoC.instance.inputManager.HideBindingPane();
        settingsScreenMain();
    }

    private function resetControls():void
    {
        CoC.instance.inputManager.HideBindingPane();
        EngineCore.clearOutput();
        EngineCore.outputText("Are you sure you want to reset all of the currently bound controls to their defaults?");

        EngineCore.doYesNo(resetControlsYes, displayControls);
    }

    private function resetControlsYes():void
    {
        CoC.instance.inputManager.ResetToDefaults();
        EngineCore.clearOutput();
        EngineCore.outputText("Controls have been reset to defaults!\n\n");

        EngineCore.doNext(displayControls);
    }

    private function clearControls():void
    {
        CoC.instance.inputManager.HideBindingPane();
        EngineCore.clearOutput();
        EngineCore.outputText("Are you sure you want to clear all of the currently bound controls?");

        EngineCore.doYesNo(clearControlsYes, displayControls);
    }

    private function clearControlsYes():void
    {
        CoC.instance.inputManager.ClearAllBinds();
        EngineCore.clearOutput();
        EngineCore.outputText("Controls have been cleared!");

        EngineCore.doNext(displayControls);
    }
}

}
