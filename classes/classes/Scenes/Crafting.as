package classes.Scenes
{
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.Items.Alchemy.AlchemyLib;
import classes.Items.Alchemy.AlchemyReagent;
import classes.Items.Alchemy.AlembicCatalyst;
import classes.Items.Consumable;
import classes.Scenes.Crafting.AlchemyExtraction;
import classes.Scenes.Crafting.MutagenPillCrafting;
import classes.Scenes.Crafting.StatPillCrafting;
import classes.Transformations.PossibleEffect;
import classes.internals.EnumValue;
import classes.internals.SaveableState;

public class Crafting extends BaseContent implements SaveableState
	{
		public static const ALEMBIC_LEVELS:/*EnumValue*/Array = [];
		public static const ALEMBIC_LEVEL_NONE:int            = EnumValue.add(ALEMBIC_LEVELS, 0, "NONE", {
			name         : "no alembic",
			successChance: 0,
			value        : 0
		});
		public static const ALEMBIC_LEVEL_SIMPLE:int          = EnumValue.add(ALEMBIC_LEVELS, 1, "SIMPLE", {
			name         : "simple alembic",
			successChance: 25,
			value        : 250
		});
		public static const ALEMBIC_LEVEL_GOOD:int            = EnumValue.add(ALEMBIC_LEVELS, 2, "GOOD", {
			name         : "good alembic",
			successChance: 50,
			value        : 2500
		});
		public static const ALEMBIC_LEVEL_ANCIENT:int         = EnumValue.add(ALEMBIC_LEVELS, 3, "ANCIENT", {
			name         : "ancient alembic",
			successChance: 75,
			value        : 25000
		});

		public static const FURNACE_LEVELS:/*EnumValue*/Array = [];
		public static const FURNACE_LEVEL_NONE:int            = EnumValue.add(FURNACE_LEVELS, 0, "NONE", {
			name         : "no pill furnace",
			refineChances: [100, 0, 0, 0, 0, 0], // see AlchemyLib.PP_xxx constants
			stoneLimit   : 0,
			value        : 0
		});
		public static const FURNACE_LEVEL_SIMPLE:int          = EnumValue.add(FURNACE_LEVELS, 1, "SIMPLE", {
			name         : "simple pill furnace",
			refineChances: [0, 40, 30, 20, 10, 0],// see AlchemyLib.PP_xxx constants
			stoneLimit   : 2,
			value        : 250
		});
		public static const FURNACE_LEVEL_GOOD:int            = EnumValue.add(FURNACE_LEVELS, 2, "GOOD", {
			name         : "good pill furnace",
			refineChances: [0, 20, 30, 30, 20, 0],
			stoneLimit   : 4,
			value        : 2500
		});
		public static const FURNACE_LEVEL_ANCIENT:int         = EnumValue.add(FURNACE_LEVELS, 3, "ANCIENT", {
			name         : "ancient pill furnace",
			refineChances: [0, 10, 20, 30, 40, 0],
			stoneLimit   : 8,
			value        : 25000
		});

		// State

		public static var BagSlot01:Number;
		public static var BagSlot01Cap:Number;//Copper Ore
		public static var BagSlot02:Number;
		public static var BagSlot02Cap:Number;//Tin Ore
		public static var BagSlot03:Number;
		public static var BagSlot03Cap:Number;//Bronze Bar
		public static var BagSlot04:Number;
		public static var BagSlot04Cap:Number;//Iron Ore
		public static var BagSlot05:Number;
		public static var BagSlot05Cap:Number;//Ebonbloom - not yet storable with current best bag
		public static var BagSlot06:Number;
		public static var BagSlot06Cap:Number;//Ebon Ingot
		public static var BagSlot07:Number;
		public static var BagSlot07Cap:Number;//Moonstone
		public static var BagSlot08:Number;
		public static var BagSlot08Cap:Number;//Skymetal - not yet storable with current best bag
		public static var BagSlot09:Number;
		public static var BagSlot09Cap:Number;//Divine Ice - not yet storable with current best bag
		public static var BagSlot10:Number;
		public static var BagSlot10Cap:Number;//Orichalcum - not yet storable with current best bag
		public static var BagSlot11:Number;
		public static var BagSlot11Cap:Number;
		public static var BagSlot12:Number;
		public static var BagSlot12Cap:Number;
		public static var BagSlot13:Number;
		public static var BagSlot13Cap:Number;
		public static var BagSlot14:Number;
		public static var BagSlot14Cap:Number;
		public static var BagSlot15:Number;
		public static var BagSlot15Cap:Number;
		public static var BagSlot16:Number;
		public static var BagSlot16Cap:Number;
		public static var BagSlot17:Number;
		public static var BagSlot17Cap:Number;
		public static var BagSlot18:Number;
		public static var BagSlot18Cap:Number;
		public static var BagSlot19:Number;
		public static var BagSlot19Cap:Number;
		public static var BagSlot20:Number;
		public static var BagSlot20Cap:Number;
		public static var BagSlot21:Number;
		public static var BagSlot21Cap:Number;
		public static var BagSlot22:Number;
		public static var BagSlot22Cap:Number;
		public static var BagSlot23:Number;
		public static var BagSlot23Cap:Number;
		public static var BagSlot24:Number;
		public static var BagSlot24Cap:Number;
		public static var BagSlot25:Number;
		public static var BagSlot25Cap:Number;
		public static var BagSlot26:Number;
		public static var BagSlot26Cap:Number;
		public static var BagSlot27:Number;
		public static var BagSlot27Cap:Number;
		public static var BagSlot28:Number;
		public static var BagSlot28Cap:Number;
		public static var BagSlot29:Number;
		public static var BagSlot29Cap:Number;
		public static var BagSlot30:Number;
		public static var BagSlot30Cap:Number;
		public static var BagSlot31:Number;
		public static var BagSlot31Cap:Number;
		public static var BagSlot32:Number;
		public static var BagSlot32Cap:Number;
		public static var BagSlot33:Number;
		public static var BagSlot33Cap:Number;
		public static var BagSlot34:Number;
		public static var BagSlot34Cap:Number;
		public static var BagSlot35:Number;
		public static var BagSlot35Cap:Number;
		public static var BagSlot36:Number;
		public static var BagSlot36Cap:Number;
		public static var BagSlot37:Number;
		public static var BagSlot37Cap:Number;
		public static var BagSlot38:Number;
		public static var BagSlot38Cap:Number;
		public static var BagSlot39:Number;
		public static var BagSlot39Cap:Number;
		public static var BagSlot40:Number;
		public static var BagSlot40Cap:Number;

		public static var alembicLevel:int = 0;
		// Catalyst currently in the alembic, or null
		public static var alembicCatalyst:AlembicCatalyst = null;
		public static var furnaceLevel:int                = 0;
		// Times used Xianxia MC powers
		public static var xmcLuck:int = 0;
		// Amount of 'stinky goo' produced when refining ingredients
		public static var gooProduced:int = 0;

		// Map of substanceId -> count
		public static var substanceStock:Object = {};
		// Map of essenceId -> count
		public static var essenceStock:Object = {};
		// Map of essenceId -> count
		public static var residueStock:Object = {};
		// Map of pigment color -> count
		public static var pigmentStock:Object = {};

		// Map of itemId -> reagentType -> set of reagent id
		// ex. { FoxJewl: { RT_ESSENCE: { AE_FOX: true } } }
		// It is saved in a compressed form
		public static var ingredientKnowledge:Object = {};
		// Set of tfId
		// ex. { TF_2_3: true }
		// It is saved in a compressed form (array of strings)
		public static var tfPillKnowledge:Object = {}

		public function stateObjectName():String {
			return "Crafting";
		}

		public function resetState():void {
			BagSlot01 = 0;
			BagSlot01Cap = 0;
			BagSlot02 = 0;
			BagSlot02Cap = 0;
			BagSlot03 = 0;
			BagSlot03Cap = 0;
			BagSlot04 = 0;
			BagSlot04Cap = 0;
			BagSlot05 = 0;
			BagSlot05Cap = 0;
			BagSlot06 = 0;
			BagSlot06Cap = 0;
			BagSlot07 = 0;
			BagSlot07Cap = 0;
			BagSlot08 = 0;
			BagSlot08Cap = 0;
			BagSlot09 = 0;
			BagSlot09Cap = 0;
			BagSlot10 = 0;
			BagSlot10Cap = 0;
			BagSlot11 = 0;
			BagSlot11Cap = 0;
			BagSlot12 = 0;
			BagSlot12Cap = 0;
			BagSlot13 = 0;
			BagSlot13Cap = 0;
			BagSlot14 = 0;
			BagSlot14Cap = 0;
			BagSlot15 = 0;
			BagSlot15Cap = 0;
			BagSlot16 = 0;
			BagSlot16Cap = 0;
			BagSlot17 = 0;
			BagSlot17Cap = 0;
			BagSlot18 = 0;
			BagSlot18Cap = 0;
			BagSlot19 = 0;
			BagSlot19Cap = 0;
			BagSlot20 = 0;
			BagSlot20Cap = 0;
			BagSlot21 = 0;
			BagSlot21Cap = 0;
			BagSlot22 = 0;
			BagSlot22Cap = 0;
			BagSlot23 = 0;
			BagSlot23Cap = 0;
			BagSlot24 = 0;
			BagSlot24Cap = 0;
			BagSlot25 = 0;
			BagSlot25Cap = 0;
			BagSlot26 = 0;
			BagSlot26Cap = 0;
			BagSlot27 = 0;
			BagSlot27Cap = 0;
			BagSlot28 = 0;
			BagSlot28Cap = 0;
			BagSlot29 = 0;
			BagSlot29Cap = 0;
			BagSlot30 = 0;
			BagSlot30Cap = 0;
			BagSlot31 = 0;
			BagSlot31Cap = 0;
			BagSlot32 = 0;
			BagSlot32Cap = 0;
			BagSlot33 = 0;
			BagSlot33Cap = 0;
			BagSlot34 = 0;
			BagSlot34Cap = 0;
			BagSlot35 = 0;
			BagSlot35Cap = 0;
			BagSlot36 = 0;
			BagSlot36Cap = 0;
			BagSlot37 = 0;
			BagSlot37Cap = 0;
			BagSlot38 = 0;
			BagSlot38Cap = 0;
			BagSlot39 = 0;
			BagSlot39Cap = 0;
			BagSlot40 = 0;
			BagSlot40Cap = 0;

			alembicLevel = 0;
			alembicCatalyst = null;
			furnaceLevel = 0;
			xmcLuck = 0;
			gooProduced = 0;
			substanceStock = {};
			essenceStock = {};
			residueStock = {};
			pigmentStock = {};
			// do not reset knowledge on ascension
			if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] == 0) {
				ingredientKnowledge = {};
				tfPillKnowledge = {};
			}
		}

		public function saveToObject():Object {
			return {
				"BagSlot01": BagSlot01,
				"BagSlot01Cap": BagSlot01Cap,
				"BagSlot02": BagSlot02,
				"BagSlot02Cap": BagSlot02Cap,
				"BagSlot03": BagSlot03,
				"BagSlot03Cap": BagSlot03Cap,
				"BagSlot04": BagSlot04,
				"BagSlot04Cap": BagSlot04Cap,
				"BagSlot05": BagSlot05,
				"BagSlot05Cap": BagSlot05Cap,
				"BagSlot06": BagSlot06,
				"BagSlot06Cap": BagSlot06Cap,
				"BagSlot07": BagSlot07,
				"BagSlot07Cap": BagSlot07Cap,
				"BagSlot08": BagSlot08,
				"BagSlot08Cap": BagSlot08Cap,
				"BagSlot09": BagSlot09,
				"BagSlot09Cap": BagSlot09Cap,
				"BagSlot10": BagSlot10,
				"BagSlot10Cap": BagSlot10Cap,
				"BagSlot11": BagSlot11,
				"BagSlot11Cap": BagSlot11Cap,
				"BagSlot12": BagSlot12,
				"BagSlot12Cap": BagSlot12Cap,
				"BagSlot13": BagSlot13,
				"BagSlot13Cap": BagSlot13Cap,
				"BagSlot14": BagSlot14,
				"BagSlot14Cap": BagSlot14Cap,
				"BagSlot15": BagSlot15,
				"BagSlot15Cap": BagSlot15Cap,
				"BagSlot16": BagSlot16,
				"BagSlot16Cap": BagSlot16Cap,
				"BagSlot17": BagSlot17,
				"BagSlot17Cap": BagSlot17Cap,
				"BagSlot18": BagSlot18,
				"BagSlot18Cap": BagSlot18Cap,
				"BagSlot19": BagSlot19,
				"BagSlot19Cap": BagSlot19Cap,
				"BagSlot20": BagSlot20,
				"BagSlot20Cap": BagSlot20Cap,
				"BagSlot21": BagSlot21,
				"BagSlot21Cap": BagSlot21Cap,
				"BagSlot22": BagSlot22,
				"BagSlot22Cap": BagSlot22Cap,
				"BagSlot23": BagSlot23,
				"BagSlot23Cap": BagSlot23Cap,
				"BagSlot24": BagSlot24,
				"BagSlot24Cap": BagSlot24Cap,
				"BagSlot25": BagSlot25,
				"BagSlot25Cap": BagSlot25Cap,
				"BagSlot26": BagSlot26,
				"BagSlot26Cap": BagSlot26Cap,
				"BagSlot27": BagSlot27,
				"BagSlot27Cap": BagSlot27Cap,
				"BagSlot28": BagSlot28,
				"BagSlot28Cap": BagSlot28Cap,
				"BagSlot29": BagSlot29,
				"BagSlot29Cap": BagSlot29Cap,
				"BagSlot30": BagSlot30,
				"BagSlot30Cap": BagSlot30Cap,
				"BagSlot31": BagSlot31,
				"BagSlot31Cap": BagSlot31Cap,
				"BagSlot32": BagSlot32,
				"BagSlot32Cap": BagSlot32Cap,
				"BagSlot33": BagSlot33,
				"BagSlot33Cap": BagSlot33Cap,
				"BagSlot34": BagSlot34,
				"BagSlot34Cap": BagSlot34Cap,
				"BagSlot35": BagSlot35,
				"BagSlot35Cap": BagSlot35Cap,
				"BagSlot36": BagSlot36,
				"BagSlot36Cap": BagSlot36Cap,
				"BagSlot37": BagSlot37,
				"BagSlot37Cap": BagSlot37Cap,
				"BagSlot38": BagSlot38,
				"BagSlot38Cap": BagSlot38Cap,
				"BagSlot39": BagSlot39,
				"BagSlot39Cap": BagSlot39Cap,
				"BagSlot40": BagSlot40,
				"BagSlot40Cap": BagSlot40Cap,

				"xmcLuck": xmcLuck,
				"gooProduced": gooProduced,
				"alembicLevel": alembicLevel,
				"alembicCatalyst": alembicCatalyst?alembicCatalyst.id:null,
				"furnaceLevel": furnaceLevel,
				"substanceStock": substanceStock,
				"essenceStock": essenceStock,
				"residueStock": residueStock,
				"pigmentStock": pigmentStock,
				"tfPillKnowledge": compressTfPillKnowledge(),
				"ingredientKnowledge": compressIngredientKnowledge()
			};
		}

		public function loadFromObject(o:Object, ignoreErrors:Boolean):void {
			if (o) {
				BagSlot01 = o["BagSlot01"];
				BagSlot01Cap = o["BagSlot01Cap"];
				BagSlot02 = o["BagSlot02"];
				BagSlot02Cap = o["BagSlot02Cap"];
				BagSlot03 = o["BagSlot03"];
				BagSlot03Cap = o["BagSlot03Cap"];
				BagSlot04 = o["BagSlot04"];
				BagSlot04Cap = o["BagSlot04Cap"];
				BagSlot05 = o["BagSlot05"];
				BagSlot05Cap = o["BagSlot05Cap"];
				BagSlot06 = o["BagSlot06"];
				BagSlot06Cap = o["BagSlot06Cap"];
				BagSlot07 = o["BagSlot07"];
				BagSlot07Cap = o["BagSlot07Cap"];
				BagSlot08 = o["BagSlot08"];
				BagSlot08Cap = o["BagSlot08Cap"];
				BagSlot09 = o["BagSlot09"];
				BagSlot09Cap = o["BagSlot09Cap"];
				BagSlot10 = o["BagSlot10"];
				BagSlot10Cap = o["BagSlot10Cap"];
				BagSlot11 = o["BagSlot11"];
				BagSlot11Cap = o["BagSlot11Cap"];
				BagSlot12 = o["BagSlot12"];
				BagSlot12Cap = o["BagSlot12Cap"];
				BagSlot13 = o["BagSlot13"];
				BagSlot13Cap = o["BagSlot13Cap"];
				BagSlot14 = o["BagSlot14"];
				BagSlot14Cap = o["BagSlot14Cap"];
				BagSlot15 = o["BagSlot15"];
				BagSlot15Cap = o["BagSlot15Cap"];
				BagSlot16 = o["BagSlot16"];
				BagSlot16Cap = o["BagSlot16Cap"];
				BagSlot17 = o["BagSlot17"];
				BagSlot17Cap = o["BagSlot17Cap"];
				BagSlot18 = o["BagSlot18"];
				BagSlot18Cap = o["BagSlot18Cap"];
				BagSlot19 = o["BagSlot19"];
				BagSlot19Cap = o["BagSlot19Cap"];
				BagSlot20 = o["BagSlot20"];
				BagSlot20Cap = o["BagSlot20Cap"];
				BagSlot21 = o["BagSlot21"];
				BagSlot21Cap = o["BagSlot21Cap"];
				BagSlot22 = o["BagSlot22"];
				BagSlot22Cap = o["BagSlot22Cap"];
				BagSlot23 = o["BagSlot23"];
				BagSlot23Cap = o["BagSlot23Cap"];
				BagSlot24 = o["BagSlot24"];
				BagSlot24Cap = o["BagSlot24Cap"];
				BagSlot25 = o["BagSlot25"];
				BagSlot25Cap = o["BagSlot25Cap"];
				BagSlot26 = o["BagSlot26"];
				BagSlot26Cap = o["BagSlot26Cap"];
				BagSlot27 = o["BagSlot27"];
				BagSlot27Cap = o["BagSlot27Cap"];
				BagSlot28 = o["BagSlot28"];
				BagSlot28Cap = o["BagSlot28Cap"];
				BagSlot29 = o["BagSlot29"];
				BagSlot29Cap = o["BagSlot29Cap"];
				BagSlot30 = o["BagSlot30"];
				BagSlot30Cap = o["BagSlot30Cap"];
				BagSlot31 = o["BagSlot31"];
				BagSlot31Cap = o["BagSlot31Cap"];
				BagSlot32 = o["BagSlot32"];
				BagSlot32Cap = o["BagSlot32Cap"];
				BagSlot33 = o["BagSlot33"];
				BagSlot33Cap = o["BagSlot33Cap"];
				BagSlot34 = o["BagSlot34"];
				BagSlot34Cap = o["BagSlot34Cap"];
				BagSlot35 = o["BagSlot35"];
				BagSlot35Cap = o["BagSlot35Cap"];
				BagSlot36 = o["BagSlot36"];
				BagSlot36Cap = o["BagSlot36Cap"];
				BagSlot37 = o["BagSlot37"];
				BagSlot37Cap = o["BagSlot37Cap"];
				BagSlot38 = o["BagSlot38"];
				BagSlot38Cap = o["BagSlot38Cap"];
				BagSlot39 = o["BagSlot39"];
				BagSlot39Cap = o["BagSlot39Cap"];
				BagSlot40 = o["BagSlot40"];
				BagSlot40Cap = o["BagSlot40Cap"];

				xmcLuck = intOr(o["xmcLuck"], 0);
				gooProduced = intOr(o["gooProduced"], 0);
				alembicLevel = intOr(o["alembicLevel"], 0);
				alembicCatalyst = ItemType.lookupItem(stringOr(o["alembicCatalyst"], "")) as AlembicCatalyst;
				furnaceLevel = intOr(o["furnaceLevel"], 0);
				substanceStock = objectOr(o["substanceStock"], {});
				essenceStock = objectOr(o["essenceStock"], {});
				residueStock = objectOr(o["residueStock"], {});
				pigmentStock = objectOr(o["pigmentStock"], {});
				// Delete invalid elements
				for each (var k:String in keys(substanceStock)) {
					if (!AlchemyLib.Substances[k]) delete substanceStock[k];
				}
				for each (k in keys(essenceStock)) {
					if (!AlchemyLib.Essences[k]) delete essenceStock[k];
				}
				for each (k in keys(residueStock)) {
					if (!AlchemyLib.Residues[k]) delete residueStock[k];
				}
				uncompressTfPillKnowledge(o["tfPillKnowledge"]);
				uncompressIngredientKnowledge(o["ingredientKnowledge"]);
			} else {
				// loading from old save
				resetState();
			}
		}

		public function isLuckyXianxiaMC():Boolean {
			return xmcLuck < 10 && flags[kFLAGS.GAME_DIFFICULTY] == 4;
		}
		public function useXianxiaMCLuck():void {
			xmcLuck++;
		}

		/*
		public static const TYPE_ALCHEMY:int = 0;
		public static const TYPE_COOKING:int = 1;
		public static const TYPE_SMITHING:int = 2;
		public static const TYPE_TAILORING:int = 3;

		private var item1:ItemType = null;
		private var item1Quantity:int = 0;
		private var item2:ItemType = null;
		private var item2Quantity:int = 0;
		private var item3:ItemType = null;
		private var item3Quantity:int = 0;
		private var item4:ItemType = null;
		private var item4Quantity:int = 0;
		private var itemResult:ItemType = null;
		*/

		public const alchemyExtraction:AlchemyExtraction = new AlchemyExtraction();
		public const mutagenPillCrafting:MutagenPillCrafting = new MutagenPillCrafting();
		public const statPillCrafting:StatPillCrafting = new StatPillCrafting();

		public function Crafting() {
			Saves.registerSaveableState(this);
		}

public function accessCraftingMaterialsBag():void {
	clearOutput();
	outputText("Would you like to put some crafting materials into the bag, and if so, with ones?\n\n");
	if (BagSlot01Cap > 0) outputText("<b>Copper Ore:</b> "+BagSlot01+" / "+BagSlot01Cap+"\n");
	if (BagSlot02Cap > 0) outputText("<b>Tin Ore:</b> "+BagSlot02+" / "+BagSlot02Cap+"\n");
	if (BagSlot03Cap > 0) outputText("<b>Bronze Bar:</b> "+BagSlot03+" / "+BagSlot03Cap+"\n");
	if (BagSlot04Cap > 0) outputText("<b>Iron Ore:</b> "+BagSlot04+" / "+BagSlot04Cap+"\n");
	//if (BagSlot05Cap > 0) outputText("<b>Ebonbloom:</b> "+BagSlot05+" / "+BagSlot05Cap+"\n");
	if (BagSlot06Cap > 0) outputText("<b>Ebon Ingot:</b> "+BagSlot06+" / "+BagSlot06Cap+"\n");
	if (BagSlot07Cap > 0) outputText("<b>Moonstone:</b> "+BagSlot07+" / "+BagSlot07Cap+"\n");
	//if (BagSlot08Cap > 0) outputText("<b>Skymetal:</b> "+BagSlot08+" / "+BagSlot08Cap+"\n");
	menu();
	//Copper Ore
	if (BagSlot01 < BagSlot01Cap) {
		if (player.hasItem(useables.COP_ORE, 1)) addButton(0, "CopperOre", craftingMaterialsCopperOre1UP);
		else addButtonDisabled(0, "CopperOre", "You don't have any copper ore to store.");
	}
	else addButtonDisabled(0, "CopperOre", "You can't store more copper ore in your bag.");
	if (BagSlot01 > 0) addButton(1, "CopperOre", craftingMaterialsCopperOre1Down);
	else addButtonDisabled(1, "CopperOre", "You don't have any copper ore in your bag.");
	//Tin Ore
	if (BagSlot02 < BagSlot02Cap) {
		if (player.hasItem(useables.TIN_ORE, 1)) addButton(2, "TinOre", craftingMaterialsTinOre1UP);
		else addButtonDisabled(2, "TinOre", "You don't have any tin ore to store.");
	}
	else addButtonDisabled(2, "TinOre", "You can't store more tin ore in your bag.");
	if (BagSlot02 > 0) addButton(3, "TinOre", craftingMaterialsTinOre1Down);
	else addButtonDisabled(3, "TinOre", "You don't have any tin ore in your bag.");
	//Bronze Bar
	if (BagSlot03 < BagSlot03Cap) {
		if (player.hasItem(useables.BRONZEB, 1)) addButton(5, "BronzeBar", craftingMaterialsBronzeBar1UP);
		else addButtonDisabled(5, "BronzeBar", "You don't have any bronze bar to store.");
	}
	else addButtonDisabled(5, "BronzeBar", "You can't store more copper ore in your bag.");
	if (BagSlot03 > 0) addButton(6, "BronzeBar", craftingMaterialsBronzeBar1Down);
	else addButtonDisabled(6, "BronzeBar", "You don't have any bronze bar in your bag.");
	//Iron Ore
	if (BagSlot04 < BagSlot04Cap) {
		if (player.hasItem(useables.IRONORE, 1)) addButton(7, "IronOre", craftingMaterialsIronOre1UP);
		else addButtonDisabled(7, "IronOre", "You don't have any iron ore to store.");
	}
	else addButtonDisabled(7, "IronOre", "You can't store more iron ore in your bag.");

	if (BagSlot04 > 0) addButton(8, "IronOre", craftingMaterialsIronOre1Down);
	else addButtonDisabled(8, "IronOre", "You don't have any iron ore in your bag.");
	//Ebon Ingot
	if (BagSlot06 < BagSlot06Cap) {
		if (player.hasItem(useables.EBONING, 1)) addButton(10, "EbonIngot", craftingMaterialsEbonIngot1UP);
		else addButtonDisabled(10, "EbonIngot", "You don't have any ebon ingot to store.");
	}
	else addButtonDisabled(10, "EbonIngot", "You can't store more ebon ingots in your bag.");

	if (BagSlot06 > 0) addButton(11, "EbonIngot", craftingMaterialsEbonIngot1Down);
	else addButtonDisabled(11, "EbonIngot", "You don't have any ebon ingot in your bag.");
	//Moonstone
	if (BagSlot07 < BagSlot07Cap) {
		if (player.hasItem(useables.MOONSTO, 1)) addButton(12, "Moonstone", craftingMaterialsMoonstone1UP);
		else addButtonDisabled(12, "Moonstone", "You don't have any moonstone to store.");
	}
	else addButtonDisabled(12, "Moonstone", "You can't store more moonstones in your bag.");

	if (BagSlot07 > 0) addButton(13, "Moonstone", craftingMaterialsMoonstone1Down);
	else addButtonDisabled(13, "Moonstone", "You don't have any moonstone in your bag.");
	addButton(14, "Back", craftingMain);
}
private function craftingMaterialsCopperOre1UP():void {
	player.destroyItems(useables.COP_ORE, 1);
	BagSlot01 += 1;
	doNext(accessCraftingMaterialsBag);
}
private function craftingMaterialsCopperOre1Down():void {
	outputText("\n");
	BagSlot01 -= 1;
	inventory.takeItem(useables.COP_ORE, accessCraftingMaterialsBag);
}
private function craftingMaterialsTinOre1UP():void {
	player.destroyItems(useables.TIN_ORE, 1);
	BagSlot02 += 1;
	doNext(accessCraftingMaterialsBag);
}
private function craftingMaterialsTinOre1Down():void {
	outputText("\n");
	BagSlot02 -= 1;
	inventory.takeItem(useables.TIN_ORE, accessCraftingMaterialsBag);
}
private function craftingMaterialsBronzeBar1UP():void {
	player.destroyItems(useables.BRONZEB, 1);
	BagSlot03 += 1;
	doNext(accessCraftingMaterialsBag);
}
private function craftingMaterialsBronzeBar1Down():void {
	outputText("\n");
	BagSlot03 -= 1;
	inventory.takeItem(useables.BRONZEB, accessCraftingMaterialsBag);
}
private function craftingMaterialsIronOre1UP():void {
	player.destroyItems(useables.IRONORE, 1);
	BagSlot04 += 1;
	doNext(accessCraftingMaterialsBag);
}
private function craftingMaterialsIronOre1Down():void {
	outputText("\n");
	BagSlot04 -= 1;
	inventory.takeItem(useables.IRONORE, accessCraftingMaterialsBag);
}
private function craftingMaterialsEbonIngot1UP():void {
	player.destroyItems(useables.EBONING, 1);
	BagSlot06 += 1;
	doNext(accessCraftingMaterialsBag);
}
private function craftingMaterialsEbonIngot1Down():void {
	outputText("\n");
	BagSlot06 -= 1;
	inventory.takeItem(useables.EBONING, accessCraftingMaterialsBag);
}
private function craftingMaterialsMoonstone1UP():void {
	player.destroyItems(useables.MOONSTO, 1);
	BagSlot07 += 1;
	doNext(accessCraftingMaterialsBag);
}
private function craftingMaterialsMoonstone1Down():void {
	outputText("\n");
	BagSlot07 -= 1;
	inventory.takeItem(useables.MOONSTO, accessCraftingMaterialsBag);
}
		/*
		public function accessCraftingMenu(type:int, page:int = 1):void {
			clearOutput();
			outputText("What would you like to craft?");
			menu();
			if (type == TYPE_ALCHEMY) {

			}
			else if (type == TYPE_COOKING) {

			}
			else if (type == TYPE_SMITHING) {

			}
			else if (type == TYPE_TAILORING) {

			}
			addButton(14, "Back", campActions);
		}

		private function createCraftingRecipe(item:*, recipe:Array):void {
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
			addButton(button, item.shortName, displayCraftingRequirement, item, recipe);
		}

		private function meetsItemRequirement(id:int):Boolean {
			if (id == 1) {
				if (item1 == null) return true;
				if (player.hasItem(item1, item1Quantity)) return true;
			}
			else if (id == 2) {
				if (item2 == null) return true;
				if (player.hasItem(item2, item2Quantity)) return true;
			}
			else if (id == 3) {
				if (item3 == null) return true;
				if (player.hasItem(item3, item3Quantity)) return true;
			}
			else if (id == 4) {
				if (item4 == null) return true;
				if (player.hasItem(item4, item4Quantity)) return true;
			}
			return false;
		}

		private function displayCraftingRequirement(item:ItemType, recipe:Array):void {
			//Item #1
			if (recipe[0] != undefined) item1 = recipe[0];
			else item1 = null;
			if (recipe[1] != undefined) item1Quantity = recipe[1];
			//Item #2
			if (recipe[2] != undefined) item2 = recipe[2];
			else item2 = null;
			if (recipe[3] != undefined) item2Quantity = recipe[3];
			//Item #3
			if (recipe[4] != undefined) item3 = recipe[4];
			else item3 = null;
			if (recipe[5] != undefined) item3Quantity = recipe[5];
			//Item #4
			if (recipe[6] != undefined) item4 = recipe[6];
			else item4 = null;
			if (recipe[7] != undefined) item4Quantity = recipe[7];
			//Set result item
			itemResult = item;
			clearOutput();
			outputText("<b>Item:</b> " + item.longName + "\n\n");
			outputText("<b><u>Items Needed:</u></b>\n");
			if (item1 != null) {
				if (player.hasItem(item1, item1Quantity)) outputText("<font color=\"#008000\">" + player.itemCount(item1) + " / " + item1Quantity + " " + item1.longName + "</font>");
				else outputText("<font color=\"#800000\">" + player.itemCount(item1) + " / " + item1Quantity + " " + item1.longName + "</font>");
				outputText("\n");
			}
			if (item2 != null) {
				if (player.hasItem(item2, item2Quantity)) outputText("<font color=\"#008000\">" + player.itemCount(item2) + " / " + item2Quantity + " " + item2.longName + "</font>");
				else outputText("<font color=\"#800000\">" + player.itemCount(item2) + " / " + item2Quantity + " " + item2.longName + "</font>");
				outputText("\n");
			}
			if (item3 != null) {
				if (player.hasItem(item3, item3Quantity)) outputText("<font color=\"#008000\">" + player.itemCount(item3) + " / " + item3Quantity + " " + item3.longName + "</font>");
				else outputText("<font color=\"#800000\">" + player.itemCount(item3) + " / " + item3Quantity + " " + item3.longName + "</font>");
				outputText("\n");
			}
			if (item4 != null) {
				if (player.hasItem(item4, item4Quantity)) outputText("<font color=\"#008000\">" + player.itemCount(item4) + " / " + item4Quantity + " " + item4.longName + "</font>");
				else outputText("<font color=\"#800000\">" + player.itemCount(item4) + " / " + item4Quantity + " " + item4.longName + "</font>");
				outputText("\n");
			}
			outputText("\n");
			//Is it okay to craft this shit?
			if (meetsItemRequirement(1) && meetsItemRequirement(2) && meetsItemRequirement(3) && meetsItemRequirement(4)) {
				outputText("Would you like to craft this item?");
				doYesNo(craftItem, accessCraftingMenu);
			}
			else {
				outputText("You do not have the required ingredients to craft this item.");
				doNext(accessCraftingMenu);
			}
		}

		private function craftItem():void {
			clearOutput();
			if (item1 != null) player.destroyItems(item1, item1Quantity);
			if (item2 != null) player.destroyItems(item2, item2Quantity);
			if (item3 != null) player.destroyItems(item3, item3Quantity);
			if (item4 != null) player.destroyItems(item4, item4Quantity);
			inventory.takeItem(itemResult, accessCraftingMenu);
		}*/


		public function feedAetherTwinsMaterialFromOreBag(itype:ItemType):void {
			switch (itype) {
				case useables.COP_ORE: BagSlot01 -= 1;
					break;
				case useables.TIN_ORE: BagSlot02 -= 1;
					break;
				case useables.BRONZEB: BagSlot03 -= 1;
					break;
				case useables.IRONORE: BagSlot04 -= 1;
					break;
				case useables.EBONING: BagSlot06 -= 1;
					break;
				case useables.MOONSTO: BagSlot07 -= 1;
					break;
			}
			return;
		}
		public function roomForMaterial(itype:ItemType):Number {
			switch (itype) {
				case useables.COP_ORE: if (BagSlot01 < BagSlot01Cap) return BagSlot01;
					break;
				case useables.TIN_ORE: if (BagSlot02 < BagSlot02Cap) return BagSlot02;
					break;
				case useables.BRONZEB: if (BagSlot03 < BagSlot03Cap) return BagSlot03;
					break;
				case useables.IRONORE: if (BagSlot04 < BagSlot04Cap) return BagSlot04;
					break;
				case useables.EBONING: if (BagSlot06 < BagSlot06Cap) return BagSlot06;
					break;
				case useables.MOONSTO: if (BagSlot07 < BagSlot07Cap) return BagSlot07;
					break;
			}
			return -1;
		}
		public function placeMaterialInBag(itype:ItemType):Number {
			switch (itype) {
				case useables.COP_ORE: craftingMaterialsCopperOre1UP();
					break;
				case useables.TIN_ORE: craftingMaterialsTinOre1UP();
					break;
				case useables.BRONZEB: craftingMaterialsBronzeBar1UP();
					break;
				case useables.IRONORE: craftingMaterialsIronOre1UP();
					break;
				case useables.EBONING: craftingMaterialsEbonIngot1UP();
					break;
				case useables.MOONSTO: craftingMaterialsMoonstone1UP();
					break;
			}
			return -1;
		}
		public function hasMaterial(itype:ItemType):Number {
			switch (itype) {
				case useables.COP_ORE: return BagSlot01;
				case useables.TIN_ORE: return BagSlot02;
				case useables.BRONZEB: return BagSlot03;
				case useables.IRONORE: return BagSlot04;
				case useables.EBONING: return BagSlot06;
				case useables.MOONSTO: return BagSlot07;
			}
			return -1;
		}
		public function useMaterial(itype:ItemType, amount:Number = 1):Boolean {
			switch (itype) {
				case useables.COP_ORE: if (BagSlot01 >= amount) {
					BagSlot01 -= amount;
					return true;
				} else return false;
				case useables.TIN_ORE: if (BagSlot02 >= amount) {
					BagSlot02 -= amount;
					return true;
				} else return false;
				case useables.BRONZEB: if (BagSlot03 >= amount) {
					BagSlot03 -= amount;
					return true;
				} else return false;
				case useables.IRONORE: if (BagSlot04 >= amount) {
					BagSlot04 -= amount;
					return true;
				} else return false;
				case useables.EBONING: if (BagSlot06 >= amount) {
					BagSlot06 -= amount;
					return true;
				} else return false;
				case useables.MOONSTO: if (BagSlot07 >= amount) {
					BagSlot07 -= amount;
					return true;
				} else return false;
			}
			return false;
		}

		public function craftingMain():void {
			clearOutput();

			if (alembicLevel > 0) {
				outputText("You can use your "+alchemyExtraction.alembicName()+" to extract alchemical reagents from consumable items.\n");
			}
			if (furnaceLevel > 0) {
				outputText("With "+mutagenPillCrafting.furnaceName()+" you can refine alchemical reagents into pills.\n");
			}
			outputText("If you have pigments and foundations, you can mix them into hair dyes and eye drops.\n")

			outputText("\nWhat will you do?");

			menu();
			// [Extract ] [Mut.Pill] [StatPill] [Dyes    ] [Stock   ]
			// [        ] [        ] [        ] [        ] [        ]
			// [        ] [        ] [Bag     ] [Cheat   ] [Back    ]
			button(0).show("Extract", alchemyExtraction.extractionMenu)
					 .hint("Refined mutagens into alchemical reagents using your alembic.")
					 .icon("I_Potion_Empty")
					 .disableIf(alembicLevel == 0, "You don't have an alembic!");
			button(1).show("Mutagen Pills", mutagenPillCrafting.craftingMenu)
					 .hint("Craft mutagen pills in your alchemical furnace.")
					 .icon("I_MutagenPill_5")
					 .disableIf(furnaceLevel == 0, "You don't have an alchemical furnace!");
			button(2).show("Stat Pills", statPillCrafting.craftingMenu)
					 .hint("Craft enhancing pills in your alchemical furnace.")
					 .icon("I_StatBonusPill_5")
					 .disableIf(furnaceLevel == 0, "You don't have an alchemical furnace!");
			button(3).show("Dyes", dyeCraftingMenu)
					 .hint("Mix dyes using pigments.")
					 .icon("I_HairDye");
			button(4).show("Stock", checkStock)
					 .hint("Check your stock of crafting materials.");
			button(12).show("Bag", accessCraftingMaterialsBag).hint("Manage your bag with crafting materials.").disableIf(BagSlot01Cap <= 0, "You'll need a bag to do that.");
			if(debug) {
				button(13).show("Cheat", craftingCheats);
			}
			button(14).show("Back", camp.campActions).icon("Back");
		}

		public function checkStock(withMenu:Boolean=false):void {
			clearOutput();

			function printAlchemyReagentStock(type:int):void {
				var a:Array;
				// Array of [AlchemyReagent, quantity:int, name:String]
				var list:Array;
				list = listAlchemyReagents(type).sortOn("2");
				if(list.length == 0) {
					outputText(" none\n")
				} else {
					outputText("<ul>");
					for each (a in list) {
						outputText("<li>"+a[1]+" x "+a[2]+"</li>");
					}
					outputText("</ul>");
				}
			}
			outputText("<b>Reagent storage capacity: </b>"+maxReagentCount()+" each.");
			outputText("\n");
			outputText("\n<b><u>Alchemical substances</u></b>:");
			printAlchemyReagentStock(AlchemyLib.RT_SUBSTANCE);
			outputText("\n<b><u>Alchemical essences</u></b>:");
			printAlchemyReagentStock(AlchemyLib.RT_ESSENCE);
			outputText("\n<b><u>Alchemical residues</u></b>:");
			printAlchemyReagentStock(AlchemyLib.RT_RESIDUE);
			outputText("\n<b><u>Alchemical pigments</u></b>:");
			printAlchemyReagentStock(AlchemyLib.RT_PIGMENT);
			flushOutputTextToGUI();
			if (withMenu) {
				menu();
				button(14).show("Back",craftingMain).icon("Back");
			}
		}

		private function craftingCheats():void {
			clearOutput();
			outputText("You have:");
			outputText("<ul>");
			outputText("<li>"+alchemyExtraction.alembicName()+"</li>");
			outputText("<li>"+mutagenPillCrafting.furnaceName()+"</li>");
			outputText("</ul>");
			function setAlembic(level:int):void {
				alembicLevel = level;
				craftingCheats();
			}
			function setFurnace(level:int):void {
				furnaceLevel = level;
				craftingCheats();
			}
			function cheatReagents():void {
				var i:int;
				for (i = 1; i < AlchemyLib.Substances.length; i++) {
					if (AlchemyLib.Substances[i]) addSubstance(i, 10);
				}
				for (i = 1; i < AlchemyLib.Essences.length; i++) {
					if (AlchemyLib.Essences[i]) addEssence(i, 10);
				}
				for (i = 1; i < AlchemyLib.Residues.length; i++) {
					if (AlchemyLib.Residues[i]) addResidue(i, 10);
				}

				craftingMain();
				checkStock();
			}
			function cheatSpawnItems():void {
				var storage:/*ItemSlotClass*/Array = [];
				for each (var type:ItemType in useables.List_AllCatalysts) {
					var slot:ItemSlotClass = new ItemSlotClass();
					slot.unlocked = true;
					slot.setItemAndQty(type, 1);
					storage.push(slot);
				}
				for (var id:String in statPillCrafting.ValidIngredients) {
					slot = new ItemSlotClass();
					slot.unlocked = true;
					slot.setItemAndQty(ItemType.lookupItem(id), 10);
					storage.push(slot);
				}
				inventory.transferMenu(storage,0,storage.length,craftingMain, "Cheat dimension",null,true,false);
			}
			function cheatKnowledge():void {
				for (var s:int = 1; s < AlchemyLib.Substances.length; s++) {
					if (!AlchemyLib.Substances[s]) continue;
					for (var e:int = 1; e < AlchemyLib.Essences.length; e++) {
						if (!AlchemyLib.Essences[e]) continue;
						setTfPillKnown(s,e);
					}
				}
				for each (var o:* in values(consumables)) {
					var item:Consumable = o as Consumable;
					if (!item) continue;
					for each (var ar:AlchemyReagent in item.getAllRefineReagents()) {
						setReagentKnown(item.id, ar.type, ar.key())
					}
				}
				craftingCheats();
			}
			menu();
			// [Alembic1] [Furnace1] [        ] [        ] [Knowledg]
			// [Alembic2] [Furnace2] [        ] [        ] [Alc.Reag]
			// [Alembic3] [Furnace3] [        ] [ Items  ] [ Back   ]
			button(0).show("Alembic1", curry(setAlembic, 1));
			button(1).show("Furnace1", curry(setFurnace, 1));
			button(4).show("Knowledge", cheatKnowledge);
			button(5).show("Alembic2", curry(setAlembic, 2));
			button(6).show("Furnace2", curry(setFurnace, 2));
			button(9).show("Alc.Reags", cheatReagents)
					 .hint("Get 10 of every alchemical reagent (except pigments)");
			button(10).show("Alembic3", curry(setAlembic, 3));
			button(11).show("Furnace3", curry(setFurnace, 3));
			button(13).show("Items", cheatSpawnItems)
					  .hint("Spawn items like alembic catalysts.");
			button(14).show("Back", craftingMain);
		}

		//=========//
		// ALCHEMY //
		//=========//


		public function maxReagentCount():int {
			return 100
		}
		public function addSubstance(id:int, change:int =+1):int {
			if (!AlchemyLib.Substances[id]) throw new Error("Invalid alchemical substance "+id);
			var count:int = substanceStock[id];
			count = boundInt(0, count + change, maxReagentCount());
			if (count > 0) substanceStock[id] = count;
			else delete substanceStock[id];
			return count;
		}
		public function addEssence(id:int, change:int=+1):int {
			if (!AlchemyLib.Essences[id]) throw new Error("Invalid alchemical essence "+id);
			var count:int = essenceStock[id];
			count = boundInt(0, count + change, maxReagentCount());
			if (count > 0) essenceStock[id] = count;
			else delete essenceStock[id];
			return count;
		}
		public function addResidue(id:int, change:int=+1):int {
			if (!AlchemyLib.Residues[id]) throw new Error("Invalid alchemical residue "+id);
			var count:int = residueStock[id];
			count = boundInt(0, count + change, maxReagentCount());
			if (count > 0) residueStock[id] = count;
			else delete residueStock[id];
			return count;
		}
		public function addPigment(id:String, change:int=+1):int {
			var count:int = pigmentStock[id];
			count = boundInt(0, count + change, maxReagentCount());
			if (count > 0) pigmentStock[id] = count;
			else delete pigmentStock[id];
			return count;
		}
		public function addAlchemyReagent(ac:AlchemyReagent, change:int =+1):int {
			switch (ac.type) {
				case AlchemyLib.RT_SUBSTANCE:
					return addSubstance(ac.intValue, change);
				case AlchemyLib.RT_ESSENCE:
					return addEssence(ac.intValue, change);
				case AlchemyLib.RT_RESIDUE:
					return addResidue(ac.intValue, change);
				case AlchemyLib.RT_PIGMENT:
					return addPigment(ac.stringValue, change);
			}
			return 0;
		}
		// Array of [AlchemyReagent, quantity:int, name:String, value:int|String]
		public function listAlchemyReagents(type:int):/*Array*/Array {
			var result:Array = [];
			var key:String;
			var ac:AlchemyReagent;
			switch (type) {
				case AlchemyLib.RT_SUBSTANCE:
					for (key in substanceStock) if (substanceStock[key] > 0) {
						ac = AlchemyReagent.substance(int(key));
						result.push([ac, substanceStock[key], ac.name(), int(key)])
					}
					break;
				case AlchemyLib.RT_ESSENCE:
					for (key in essenceStock) if (essenceStock[key] > 0) {
						ac = AlchemyReagent.essence(int(key));
						result.push([ac, essenceStock[key], ac.name(), int(key)])
					}
					break;
				case AlchemyLib.RT_RESIDUE:
					for (key in residueStock) if (residueStock[key] > 0) {
						ac = AlchemyReagent.residue(int(key));
						result.push([ac, residueStock[key], ac.name(), int(key)])
					}
					break;
				case AlchemyLib.RT_PIGMENT:
					for (key in pigmentStock) if (pigmentStock[key] > 0) {
						ac = AlchemyReagent.pigment(key);
						result.push([ac, pigmentStock[key], ac.name(), key])
					}
					break;
			}
			return result;
		}

		//================================//
		// ALCHEMY - KNOWLEDGE MANAGEMENT //
		//================================//
		// { itemId: { reagentType: { reagentId: true } } }
		// compressed into
		// { itemId: [ compressedRT1, compressedRT2, compressedRT3, compressedRT4 ]
		// where compressedRTX is knowledge of reagent type X in form:
		// "*" - all known, "0" - all unknown
		// else array of values
		// e.g.
		// { FoxJewl: {
		//              RT_SUBSTANCE: { 2 :true, 19:true, /* some unknown */ }
		//              RT_ESSENCE: { all: true },
		//              RT_RESIDUE: { 5: true, /* some unknown */ },
		//              RT_PIGMENT: {}
		// }          }
		// =>
		// { FoxJewl: [ [2,19], "*", [5], "0" ] }
		private function compressIngredientKnowledge():Object {
			function compressOneEntry(source:Object, itype:Consumable, rtype:int):* {
				if (!source) return "0";
				var reagents:/*AlchemyReagent*/Array = itype.getRefineReagents(rtype);
				var hasUnknown:Boolean = false, hasKnown:Boolean = false;
				for each (var ar:AlchemyReagent in reagents) {
					if (source[ar.key()]) {
						hasKnown = true;
					} else {
						hasUnknown = true;
					}
					if (hasKnown && hasUnknown) break;
				}
				if (hasKnown && !hasUnknown) return "*";
				if (!hasKnown && hasUnknown) return "0";
				var result:Array = [];
				for each(ar in reagents) {
					if (source[ar.key()]) result.push(ar.key());
				}
				return result;
			}
			var result:Object = {};
			for (var itemId:String in ingredientKnowledge) {
				var source:Object = ingredientKnowledge[itemId];
				if (!source) continue;
				var itype:Consumable = ItemType.lookupItem(itemId) as Consumable;
				if (!itype) continue;
				var data:Array = [];
				for (var rt:int = 1 /* SUBSTANCE */; rt <= 4 /* PIGMENT */; rt++) {
					data.push(compressOneEntry(source[rt], itype, rt));
				}
				result[itemId] = data;
			}
			return result;
		}
		private function uncompressIngredientKnowledge(compressed:Object):void {
			function uncompressOneEntry(source:*, itype:Consumable, rtype:int):Object {
				if (!source || source == "0") return {};
				var result:Object = {};
				if (source == "*") {
					for each (var ar:AlchemyReagent in itype.getRefineReagents(rtype)) {
						result[ar.key()] = true;
					}
				}
				for each (var key:* in (source as Array)) {
					result[key] = true;
				}
				return result;
			}
			ingredientKnowledge = {};
			for (var itemId:String in compressed) {
				var itemType:Consumable = ItemType.lookupItem(itemId) as Consumable;
				if (!itemType) continue;
				var sourceData:Array = compressed[itemId] as Array;
				var itemEntry:Object = {};
				for (var rt:int = 1 /* SUBSTANCE */; rt <= 4 /* PIGMENT */; rt++) {
					itemEntry[rt] = uncompressOneEntry(sourceData[rt-1], itemType, rt);
				}
				ingredientKnowledge[itemId] = itemEntry;
			}
		}
		// { TF_1_2:true, TF_4_5:true } -> ["TF_1_2", "TF_4_5"]
		private function compressTfPillKnowledge():Array {
			return keys(tfPillKnowledge);
		}
		private function uncompressTfPillKnowledge(compressed:Array):void {
			tfPillKnowledge = {};
			for each (var tf:String in compressed) {
				tfPillKnowledge[tf] = true;
			}
		}

		public function isTfPillKnown(substance:int, essence:int):Boolean {
			return !!tfPillKnowledge["TF_"+substance+"_"+essence];
		}
		public function setTfPillKnown(substance:int, essence:int):void {
			tfPillKnowledge["TF_"+substance+"_"+essence] = true;
		}
		public function isReagentKnown(itemId:String, reagentType:int, reagentKey:*):Boolean {
			var o:Object = ingredientKnowledge[itemId];
			if (!o) return false;
			o = o[reagentType];
			if (!o) return false;
			return !!o[reagentKey];
		}
		public function setReagentKnown(itemId:String, reagentType:int, reagentKey:*):void {
			var ik:Object = ingredientKnowledge[itemId];
			if (!ik) ik = (ingredientKnowledge[itemId] = {});
			var rk:Object = ik[reagentType];
			if (!rk) rk = (ik[reagentType] = {});
			rk[reagentKey] = true;
		}
		public function alchemyFurnaceObject():EnumValue {
			return Crafting.FURNACE_LEVELS[furnaceLevel];
		}
		public function alchemyFurnaceStoneSafeLimit():int {
			return alchemyFurnaceObject().stoneLimit
		}
		/**
		 * List reagents of type. On click, **take one from storage** and call `callback(value)`
		 * @param type AlchemyLib.RT_XXXX
		 * @param callback function(value:int|String):void
		 * @param backFn function():void
		 * @param current int|String, selected reagent.
		 */
		public function selectReagent(type:int, callback:Function, backFn:Function, current:*):void {
			clearOutput();
			mainView.linkHandler = function (event:String):void {
				if (type == AlchemyLib.RT_PIGMENT) {
					addPigment(event, -1);
					callback(event);
				} else {
					addAlchemyReagent(AlchemyReagent.getReagent(type, int(event)), -1);
					callback(int(event));
				}
			}
			outputText("<b>Alchemical " + AlchemyLib.ReagentTypes[type].name  + "s</b>:");
			var list:Array = SceneLib.crafting.listAlchemyReagents(type).sortOn("2");
			if (list.length == 0) {
				outputText("\nYou don't have any! Refine ingredients in the alembic.");
			} else {
				outputText("<ul>");
				for each (var element:Array in list) {
					outputText("<li>");
					outputText(mkLink(element[2] + " (" + element[1] + ")", String(element[3])));
					if (element[3] == current) outputText(" - selected");
					outputText("</li>")
				}
				outputText("</ul>");
			}

			menu();
			button(14).show("Back", backFn).icon("Back");
		}
		//======================//
		// ALCHEMY - DYE MIXING //
		//======================//

		private var selectedPigment:String = "";
		private function selectPigment(pigment:String):void {
			if (selectedPigment) {
				// Give back old pigment
				addPigment(selectedPigment);
			}
			selectedPigment = pigment;
			dyeCraftingMenu();
		}
		public function dyeCraftingMenu():void {
			clearOutput();

			// if we're returning from crafting and used last pigment
			var dyeFnd:int = player.itemCount(useables.DYE_FOUNDATION);
			var oilFnd:int = player.itemCount(useables.OIL_FOUNDATION);
			var dropFnd:int = player.itemCount(useables.DROP_FOUNDATION);
			outputText("You prepare the glassware to mix some dyes. ");
			outputText("\n");
			outputText("\n<b>Selected pigment</b>: "+(selectedPigment?selectedPigment:"<i>none</i>"));
			outputText("\n<b>Dye foundations</b>: "+dyeFnd);
			outputText("\n<b>Skin oil foundations</b>: "+oilFnd);
			outputText("\n<b>Eyedrop foundations</b>: "+dropFnd);

			if (keys(pigmentStock).length == 0) {
				outputText("\n\n<b>You don't have any pigments. Pigments can be extracted from consumables.</b> ");
			}
			if (dyeFnd == 0 && oilFnd == 0 && dropFnd == 0) {
				outputText("\n\n<b>You have no foundations. Buy some from hair dye vendor.</b>")
			}

			menu();
			button(0).show("Pigment", curry(selectReagent, AlchemyLib.RT_PIGMENT, selectPigment, dyeCraftingMenu, selectedPigment))
					 .hint("Select a pigment to use")
					 .disableIf(keys(pigmentStock).length == 0);
			button(1).show("Craft Dye", craftHairDye)
					 .hint("Craft "+selectedPigment+" hair dye.\n\nIt can be applied to fur, scales, and chiting with the use of additional reagents.")
					 .icon("I_HairDye")
					 .disableIf(dyeFnd == 0, "++\n<b>You need a dye foundation!</b>")
					 .disableIf(!selectedPigment, "Select a pigment");
			button(2).show("Craft Oil", craftSkinDye)
					 .hint("Craft "+selectedPigment+" skin oil.")
					 .icon("I_SkinOil")
					 .disableIf(oilFnd == 0, "++\n<b>You need an oil foundation!</b>")
					 .disableIf(!selectedPigment, "Select a pigment");
			button(3).show("Craft Eyedrops", craftEyeDye)
					 .hint("Craft "+selectedPigment+" eye drops.")
					 .icon("I_EyeDye")
					 .disableIf(dropFnd == 0, "++\n<b>You need an eyedrop foundation!</b>")
					 .disableIf(!selectedPigment, "Select a pigment");

			button(14).show("Back",function():void {
				if (selectedPigment) {
					addPigment(selectedPigment);
				}
				selectedPigment = "";
				craftingMain();
			}).icon("Back");
		}
		private function craftHairDye():void {
			clearOutput();
			player.giveAlchemyXP(1);
			outputText("You pour the pigment into foundation and stir it with a spoon. The viscous mixture quickly turns "+selectedPigment+". You stir it for one more minute to get a uniform coloring, and then cork the vial.\n");
			player.destroyItems(useables.DYE_FOUNDATION, 1, true);
			inventory.takeItem(itemTemplates.createHairDye(selectedPigment, 1), dyeCraftingMenu);
			selectedPigment = "";
		}
		private function craftSkinDye():void {
			clearOutput();
			player.giveAlchemyXP(1);
			outputText("You pour the pigment into foundation and stir it with a spoon. The viscous mixture quickly turns "+selectedPigment+". You stir it for one more minute to get a uniform coloring, and then cork the bottle.\n");
			player.destroyItems(useables.OIL_FOUNDATION, 1, true);
			inventory.takeItem(itemTemplates.createSkinOil(selectedPigment), dyeCraftingMenu);
			selectedPigment = "";
		}
		private function craftEyeDye():void {
			clearOutput();
			player.giveAlchemyXP(1);
			outputText("You pour the pigment into foundation and stir it with a spoon. The mixture quickly turns "+selectedPigment+". You stir it for one more minute to get a uniform coloring, and then cork the vial.\n");
			player.destroyItems(useables.DROP_FOUNDATION, 1, true);
			inventory.takeItem(itemTemplates.createEyeDye(selectedPigment), dyeCraftingMenu);
			selectedPigment = "";
		}
	}
}
