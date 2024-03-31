/*
 * Typings file to help with IDE suggestions
 *
 * "exported" - data exported from game
 * "gamedata-ex" - data cnfigured in gamedata-ex.js
 */

declare var Gamedata:IExtendedGamedata;

declare interface IExportedGamedata {
	version: string;
	versionNumber: number;
	/** index: flag_number */
	flags: Record<number, IGDFlag>;
	/** index: perk_id */
	perks: Record<string, IGDPerk>;
	/** index: perk_id */
	mutations: Record<string, IGDMutation>;
	/** index: slot_id */
	mutation_slots: Record<string, IGDMutationSlot>;
	/**
	 * index1: item_category
	 * index2: item_id
	 */
	items: Record<
			Exclude<IGDItemCategory, keyof IGDSpecialItemTypes>,
			Record<string, IGDItem>> & IGDSpecialItemTypes;
	itemTemplates: Record<string, IGDItemTemplate>;
	statuses: Record<string, IGDStatusEffect>;
	bptypes: Record<
			Exclude<IGDBodySlot, keyof IGDSpecialBodyParts>,
			Record<string, IGDBodyPart>> & IGDSpecialBodyParts;
	colors: IGDColor[];
	stats: IGDStat[];
	maxBreastCup: number;
	breastCups: string[];
	itemSlotCount: number;
}
declare type IGDSpecialItemTypes = {
	weapon: Record<string,IGDItemWeapon>;
	undergarment: Record<string,IGDItemUndergarment>;
}

/**
 * Extra data added in gamedata-ex.js
 */
declare interface IExtendedGamedata extends IExportedGamedata {
	minVersion: number;
	maxVersion: number;

	keyitems: Record<string, IGDKeyItem>;

	maxCoreStatValue: number;

	skin_coverage: {value:number,text:string}[];
	skinAdjs: string[];
	skinDescs: string[];
	maxBreastRows: number;
	analWetness: [number, string][];
	analLooseness: [number, string][];
	defaultVagina: object;
	maxVaginas: number;
	vaginalWetness: [number, string][];
	vaginalLooseness: [number, string][];

	maxPregnanyIncubation: number;
	pregnancyType: VSelectItem<number>[];

	equipmentSlots: IGDEquipmentSlot[];
	itemCategoryNames: Record<IGDItemCategory, string>;
	anyItemSelector: VSelectItem<string>[];
	maxItemsInSlot: number;
	gearStorages: IGDGearStorage[];

	/**
	 * Array of ["key in Gamedata.values", "displayed name"]
	 */
	storyGroups: [string,string][],
	values: {
		stats_main: IGDCustomValue[];
		stats_resources: IGDCustomValue[];
		stats_skills: IGDCustomValue[];
		body_stats: IGDCustomValue[];
		[index:string]: IGDCustomValue[];
	},
}

declare type VSelectItem<T> = {
	value: T;
	text: string;
	disabled?: boolean;
} | { divider: true } | { header: string } | T;

declare interface IGDEquipmentSlot {
	/** Reference in the save data */
	ref: string;
	/** Item category to use */
	category: IGDItemCategory;
	/** Displayed name */
	label: string;
}

/** Flag metadata */
declare interface IGDFlag {
	/**
	 * Flag number
	 */
	id: number;
	/**
	 * Variable name from kFLAGS (exported)
	 */
	name: string;
	/**
	 * Description (custom)
	 */
	desc?: string;
}

/**
 * "monster" (exported) - monster perk, not intended for player
 * "levelup" (exported) - ordinary can be obtained at level-up
 * "unobtainable" (exported) - player perk that has no reqs (racial/quest/...)
 * "item" (gamedata.js) - perk given by equipping an item
 * "other" (gamedata.js) - other kind of special perk
 */
declare type IGDPerkTag =
	"monster"|"levelup"|"unobtainable"|"item"|"special";

/** Non-mutation perk metadata */
declare interface IGDPerk {
	/** (exported) Perk id */
	id: string;
	/** (exported) In-game name */
	name: string;
	/** (exported) In-game description */
	desc: string;
	/** (exported but customizable) */
	tags: IGDPerkTag[];
	/** (exported but customizable) */
	requirements: IGDPerkRequirement[];
	/** (exported) Unlocked perk ids */
	unlocks: string[];
	/** (exported) default value1-4 */
	defaultValues: [number, number, number, number];
	/** (gamedata.js) Perk has meaningful value1 */
	hasv1?:boolean;
	/** (gamedata.js) Perk has meaningful value2 */
	hasv2?:boolean;
	/** (gamedata.js) Perk has meaningful value3 */
	hasv3?:boolean;
	/** (gamedata.js) Perk has meaningful value4 */
	hasv4?:boolean;
	/** (gamedata.js) value1 description */
	v1desc?:string;
	/** (gamedata.js) value2 description */
	v2desc?:string;
	/** (gamedata.js) value3 description */
	v3desc?:string;
	/** (gamedata.js) value4 description */
	v4desc?:string;
}

declare type IGDPerkRequirement = IGDPerkRequirementNoArgs | IGDPerkRequirementOneValue | IGDPerkRequirementAttr |
	IGDPerkRequirementMutationSlot | IGDPerkRequirementEffect | IGDPerkRequirementRace | IGDPerkRequirementAnyRace |
	IGDPerkRequirementPerk | IGDPerkRequirementPerks;
declare interface IPerkRequirement {
	type: string;
	text: string;
}
declare interface IGDPerkRequirementNoArgs extends IPerkRequirement {
	type: "custom"|"advanced"|"prestige"|"dragonmutation"|"kitsunemutation"|"hungerflag";
}
declare interface IGDPerkRequirementOneValue extends IPerkRequirement {
	type: "level"|"ng+"|"minlust"|"minsensitivity"|"soulforce"|"mana"|"venom_web";
	value: number;
}
declare interface IGDPerkRequirementAttr extends IPerkRequirement {
	type: "attr"|"attr-lt";
	attr: string;
	value: number;
}
declare interface IGDPerkRequirementMutationSlot extends IPerkRequirement {
	type: "mutationslot";
	slot: string;
}
declare interface IGDPerkRequirementEffect extends IPerkRequirement {
	type: "effect";
	effect: string;
}
declare interface IGDPerkRequirementRace extends IPerkRequirement {
	type: "race";
	race: number;
	tier: number;
}
declare interface IGDPerkRequirementAnyRace extends IPerkRequirement {
	type: "anyrace";
	races: number[];
}
declare interface IGDPerkRequirementPerk extends IPerkRequirement {
	type: "perk";
	perk: string;
}
declare interface IGDPerkRequirementPerks extends IPerkRequirement {
	type: "anyperk"|"allperks";
	perks: string[];
}

/** Mutation metadata */
declare interface IGDMutation {
	/** (exported) perk id */
	id:string;
	/** (exported) in-game name */
	name: string;
	/** (exported) in-game description (often blank or same as name) */
	desc: string;
	/** (exported) */
	maxLevel: number;
	/** (exported) */
	tags: [];
	/** (exported) Mutation slot name */
	slot: string;
}

/** Mutation slot metadata */
declare interface IGDMutationSlot {
	/** (exported) */
	id:string;
	/** (exported) */
	name:string;
}

declare type IGDItemCategory = "armor"|"consumable"|"flyingsword"|"headjewelry"|"jewelry"|"miscjewelry"|"necklace"|"shield"|"undergarment"|"vehicle"|"weapon"|"weaponrange"|"useable"|"other";
/** Item metadata */
declare interface IGDItem {
	/** (exported) item id */
	id: string;
	/** (exported) in-game long name */
	name: string;
	/** (exported) */
	category: IGDItemCategory;
	/** (exported) */
	desc: string;
	/** (exported) */
	tags: string[];
	/** (exported) */
	effects: IGDItemEffect[];
}
declare interface IGDItemEffect {
	name: string;
	power: number;
	value1?: any;
	value2?: any;
	value3?: any;
	value4?: any;
}
declare interface IGDItemUndergarment extends IGDItem {
	/**
	 * (exported) 0: upper, 1: lower, 2: full
	 */
	type: 0|1|2;
}
declare interface IGDItemWeapon extends IGDItem {
	/** (exported) */
	type: string;
	/** (exported) */
	size: number;
	/** (exported) */
	dual: boolean;
}
declare interface IGDItemTemplate {
	id: string;
	name: string;
	metadata: {
		category: IGDItemCategory;
		params: IGDItemTemplateParam[];
	}
}
declare interface IGDItemTemplateParam {
	name: string;
	label?: string;
	type: "text"|"number";
	value: any;
	min?: number;
	max?: number;
}
declare interface IGDGearStorage {
	/** start index (inclusive) in gearStorage array */
	start:number;
	/** end index (exclusive) in gearStorage array */
	end:number;
	/** displayed name */
	name:string;
	/** valid item categories, or undefined if any item */
	categories?: IGDItemCategory[];
}

declare interface IGDKeyItem {
	/** (gamedata.js) key item name - same as id */
	name:string;
	/** (gamedata.js) editor description */
	desc?:string;
	/** (gamedata.js) Key item has meaningful value1 */
	hasv1?:boolean;
	/** (gamedata.js) Key item has meaningful value2 */
	hasv2?:boolean;
	/** (gamedata.js) Key item has meaningful value3 */
	hasv3?:boolean;
	/** (gamedata.js) Key item has meaningful value4 */
	hasv4?:boolean;
	/** (gamedata.js) value1 description */
	v1desc?:string;
	/** (gamedata.js) value2 description */
	v2desc?:string;
	/** (gamedata.js) value3 description */
	v3desc?:string;
	/** (gamedata.js) value4 description */
	v4desc?:string;
}

declare type IGDBodySlot = "antennase"|"arms"|"beard"|"claws"|"ears"|"eyes"|"face"|"gills"|"hair"|"hairstyle"|"horns"|"legs"|"material"|"rear"|"skin"|"skin_base"|"skin_coat"|"pattern"|"pattern_base"|"pattern_coat"|"tail"|"tongue"|"vagina"|"wings";
declare interface IGDSpecialBodyParts {
	legs: IGDBodyLegType;
	skin: IGDBodySkinType;
	pattern: IGDBodyPatternType;
	wings: IGDBodyWingType;
}
declare interface IGDBodyPart {
	/** (exported) enum name ("HUMAN", "FOX") */
	id:number;
	/** (exported) enum number (0, 1) */
	value:number;
	/** (exported) displayed name */
	name:number;
}
declare interface IGDBodyLegType extends IGDBodyPart {
	/** (exported) default leg count (2 if not specified)*/
	legCount?:number;
	/** (exported) this lower body can be tauric (valid leg counts: 2, 4) */
	canTaur?:boolean;
	/** (exported) this lower body blocks tail */
	noTail?:boolean;
	/** (exported) this lower body has own tail */
	tail?:boolean;
}
declare interface IGDBodySkinType extends IGDBodyPart {
	/** (exported) this is a base layer type */
	base:boolean;
	/** (exported) this is a coat layer type */
	coat:boolean;
	/** (exported) default desc */
	desc?:string;
	/** (exported) default adj */
	adj?:string;
}
declare interface IGDBodyPatternType extends IGDBodyPart {
	/** (exported) this pattern can be applied to base layer */
	base:boolean;
	/** (exported) this pattern can be applied to coat layer */
	coat:boolean;
}
declare interface IGDBodyWingType extends IGDBodyPart {
	/** (exported) default wing description */
	desc?:string;
}

declare interface IGDStatusEffect {
	/** (exported) status effect id */
	id: string;
	/** (gamedata.js) editor name */
	name?: string;
	/** (gamedata.js) editor description */
	desc?: string;
	/** (exported) */
	combat: boolean;
}

declare interface IGDColor {
	/** (exported) */
	name: string;
	/** (exported) */
	rgb: string;
}

declare type IGDStatType = "raw"|"primary"|"buffable";
declare interface IGDStat {
	/** (exported) stat id ('str') */
	id: string;
	/** (exported) stat display name ('Strength') */
	name: string;
	/** (exported) is a multiplier, display as % */
	isPercentage: boolean;
	/** (exported) */
	type: IGDStatType;
}

//////////////////////////////////
// Custom values
/////////////////////////////////

declare type ICustomValueType = "text"|"slider"|"tierslider"|"number"|"bignumber"|"enum"|"checkbox";
declare interface ICustomValue {
	type: ICustomValueType;
	/**
	 * Unique id. A r/w property named "cv_"+id is created in the app
	 */
	id: string;
	/**
	 * Name of the variable in the save data (can be nested), or getter&setter
	 */
	ref: string | {
		get(): any;
		set(value: any): void;
	};
	/**
	 * Text label
	 */
	label: string;
	/**
	 * Width in columns on grid of 12, default 12 (full row)
	 */
	cols?: number;
}

/**
 * Creates a text input
 */
declare interface CVText extends ICustomValue {
	type: "text";
}
declare interface CVSlider extends ICustomValue {
	type: "slider";
	min: number;
	max: number;
	step?: number;
	color?: string;
}
declare interface CVTierSlider extends ICustomValue {
	type: "tierslider";
	min: number;
	max: number;
	step?: number;
	color?: string;
	tiers: [number, string][];
}
declare interface CVNumber extends ICustomValue {
	type: "number"|"bignumber";
	min?: number;
	max?: number;
	step?: number;
	color?: string;
}
declare interface CVEnum<T> extends ICustomValue {
	type: "enum";
	items: VSelectItem<T>[];
}
declare interface CVCheckbox extends ICustomValue {
	type: "checkbox"
}

declare type IGDCustomValue = CVDelimiter | CVText | CVSlider | CVTierSlider | CVNumber | CVEnum<string> | CVEnum<number> | CVCheckbox;
declare type CVDelimiter = string;

declare type IGDSSDef = string | [string,string] | [string,Partial<IGDCustomValue>];
