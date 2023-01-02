// See js/gamedata.d.ts for Gamedata structure

// noinspection JSValidateTypes
/**
 * @type {IExtendedGamedata}
 */
let Gamedata = ExportedGamedata;

Gamedata.minVersion = 36.007;
Gamedata.maxVersion = 36.099;

/**
 * Flag descriptions
 */
Gamedata.flags[1].desc = "Marble Pregnancy Incubation";

// Mark certain perks w/o requirements as obtainable
for (let perkId of [
	"History: Alchemist",
	"History: Cultivator",
	"History: Fighter",
	"History: Fortune",
	"History: Healer",
	"History: Religious",
	"History: Scholar",
	"History: Scout",
	"History: Slacker",
	"History: Slut",
	"History: Smith",
	"History: Tactician",
	"History: Whore",
	"Past Life: Alchemist",
	"Past Life: Cultivator",
	"Past Life: Fighter",
	"Past Life: Fortune",
	"Past Life: Healer",
	"Past Life: Religious",
	"Past Life: Scholar",
	"Past Life: Scout",
	"Past Life: Slacker",
	"Past Life: Slut",
	"Past Life: Smith",
	"Past Life: Tactician",
	"Past Life: Whore",
	"Fast",
	"Lusty",
	"Pervert",
	"Sensitive",
	"Wise",
	"Smart",
	"Strong",
	"Tough",
	"Big Clit",
	"Big Tits",
	"Fertile",
	"Wet Pussy",
	"Big Cock",
	"Messy Orgasms",
])
	if (perkId in Gamedata.perks)
		Object.assign(Gamedata.perks[perkId], {
			tags: ["levelup"]
		});

Gamedata.stats.sortBy("name");
// Mover core stats to the start
Gamedata.stats.unshift(
	...["str","tou","int","wis","lib","sens"].map(v=>
		Gamedata.stats.splice(
			Gamedata.stats.findIndex(stat=>stat.id===v),1
		)[0]
	)
);

Gamedata.maxCoreStatValue = 1000;

/**
 * Source: all across the codebase
 */
Gamedata.keyitems = {
	"Adventurer Guild: Bronze plate": { name: "Adventurer Guild: Bronze plate" },
	"Adventurer Guild: Copper plate": { name: "Adventurer Guild: Copper plate" },
	"Adventurer Guild: Iron plate": { name: "Adventurer Guild: Iron plate" },
	"Air Sylph Core": { name: "Air Sylph Core" },
	"All-Natural Onahole": { name: "All-Natural Onahole" },
	"All-Natural Self-Stimulation Belt": { name: "All-Natural Self-Stimulation Belt" },
	"Alvina's Shattered Phylactery": { name: "Alvina's Shattered Phylactery" },
	"Aphrodigas Gun": { name: "Aphrodigas Gun" },
	"Arian's Charged Talisman": { name: "Arian's Charged Talisman" },
	"Arian's Talisman": { name: "Arian's Talisman" },
	"Ascension": { name: "Ascension" },
	"Ayane Star Sphere": { name: "Ayane Star Sphere" },
	"Backpack": { name: "Backpack" },
	"Bag of Cosmos": { name: "Bag of Cosmos" },
	"Black Soul Gem": { name: "Black Soul Gem" },
	"Blueprint - Aphrodigas Gun": { name: "Blueprint - Aphrodigas Gun" },
	"Blueprint - Cum Reservoir": { name: "Blueprint - Cum Reservoir" },
	"Blueprint - Drug injectors": { name: "Blueprint - Drug injectors" },
	"Blueprint - Dynapunch Glove": { name: "Blueprint - Dynapunch Glove" },
	"Blueprint - Energy Core": { name: "Blueprint - Energy Core" },
	"Blueprint - Gravity shots": { name: "Blueprint - Gravity shots" },
	"Blueprint - Gun Scope with Aim tech": { name: "Blueprint - Gun Scope with Aim tech" },
	"Blueprint - Gun Scope with Aimbot": { name: "Blueprint - Gun Scope with Aimbot" },
	"Blueprint - Gun Scope": { name: "Blueprint - Gun Scope" },
	"Blueprint - Impregnator 1.0": { name: "Blueprint - Impregnator 1.0" },
	"Blueprint - Improved Drug injectors": { name: "Blueprint - Improved Drug injectors" },
	"Blueprint - Jetpack": { name: "Blueprint - Jetpack" },
	"Blueprint - Lustnade Launcher": { name: "Blueprint - Lustnade Launcher" },
	"Blueprint - M.G.S. bracer": { name: "Blueprint - M.G.S. bracer" },
	"Blueprint - MK2 Jetpack": { name: "Blueprint - MK2 Jetpack" },
	"Blueprint - Machine Gun MK1": { name: "Blueprint - Machine Gun MK1" },
	"Blueprint - Machine Gun MK2": { name: "Blueprint - Machine Gun MK2" },
	"Blueprint - Machine Gun MK3": { name: "Blueprint - Machine Gun MK3" },
	"Blueprint - Machined greatsword": { name: "Blueprint - Machined greatsword" },
	"Blueprint - Machinist Goggles": { name: "Blueprint - Machinist Goggles" },
	"Blueprint - Mechanism": { name: "Blueprint - Mechanism" },
	"Blueprint - Medical Dispenser 2.0": { name: "Blueprint - Medical Dispenser 2.0" },
	"Blueprint - Missile launcher": { name: "Blueprint - Missile launcher" },
	"Blueprint - Nitro Boots": { name: "Blueprint - Nitro Boots" },
	"Blueprint - Omni Missile": { name: "Blueprint - Omni Missile" },
	"Blueprint - Potent Drug injectors": { name: "Blueprint - Potent Drug injectors" },
	"Blueprint - Powboy": { name: "Blueprint - Powboy" },
	"Blueprint - Power bracer": { name: "Blueprint - Power bracer" },
	"Blueprint - Raijin blaster": { name: "Blueprint - Raijin blaster" },
	"Blueprint - Repeater Gun": { name: "Blueprint - Repeater Gun" },
	"Blueprint - Ripper 1.0": { name: "Blueprint - Ripper 1.0" },
	"Blueprint - Ripper 2.0": { name: "Blueprint - Ripper 2.0" },
	"Blueprint - Rocket Boots": { name: "Blueprint - Rocket Boots" },
	"Blueprint - S.A Tech Goggle": { name: "Blueprint - S.A Tech Goggle" },
	"Blueprint - SPMK1": { name: "Blueprint - SPMK1" },
	"Blueprint - Safety bubble": { name: "Blueprint - Safety bubble" },
	"Blueprint - Scanner goggle": { name: "Blueprint - Scanner goggle" },
	"Blueprint - Snowball Generator": { name: "Blueprint - Snowball Generator" },
	"Blueprint - Spring Boots": { name: "Blueprint - Spring Boots" },
	"Blueprint - Stimpack Dispenser 1.0": { name: "Blueprint - Stimpack Dispenser 1.0" },
	"Blueprint - Taser with an overcharged battery": { name: "Blueprint - Taser with an overcharged battery" },
	"Blueprint - Taser": { name: "Blueprint - Taser" },
	"Blueprint - Toolbelt": { name: "Blueprint - Toolbelt" },
	"Blueprint - Upgraded Armor plating 1.0": { name: "Blueprint - Upgraded Armor plating 1.0" },
	"Blueprint - Upgraded Armor plating 2.0": { name: "Blueprint - Upgraded Armor plating 2.0" },
	"Blueprint - Upgraded Armor plating 3.0": { name: "Blueprint - Upgraded Armor plating 3.0" },
	"Blueprint - Whitefire Beam Cannon": { name: "Blueprint - Whitefire Beam Cannon" },
	"Breast Milker - Installed At Whitney's Farm": { name: "Breast Milker - Installed At Whitney's Farm" },
	"Breast Milker": { name: "Breast Milker" },
	"Camp - Chest": { name: "Camp - Chest" },
	"Camp - Murky Chest": { name: "Camp - Murky Chest" },
	"Camp - Ornate Chest": { name: "Camp - Ornate Chest" },
	"Carpenter's Toolbox": { name: "Carpenter's Toolbox" },
	"Carrot": { name: "Carrot" },
	"Centaur Pole": { name: "Centaur Pole" },
	"Cock Milker - Installed At Whitney's Farm": { name: "Cock Milker - Installed At Whitney's Farm" },
	"Cock Milker": { name: "Cock Milker" },
	"Cultivation Manual: Duality": { name: "Cultivation Manual: Duality" },
	"Cum Reservoir": { name: "Cum Reservoir" },
	"Dangerous Plants": { name: "Dangerous Plants" },
	"Dark Mage’s Grimoire": { name: "Dark Mage’s Grimoire" },
	"Dart pistol": { name: "Dart pistol" },
	"Decorations": { name: "Decorations" },
	"Deluxe Dildo": { name: "Deluxe Dildo" },
	"Deluxe Onahole": { name: "Deluxe Onahole" },
	"Demon Hunter Amulet": { name: "Demon Hunter Amulet" },
	"Demonic Strap-On": { name: "Demonic Strap-On" },
	"Derpnade Launcher": { name: "Derpnade Launcher" },
	"Desert Eagle": { name: "Desert Eagle" },
	"Dildo": { name: "Dildo" },
	"Double barreled dragon gun": { name: "Double barreled dragon gun" },
	"Dragon Egg": { name: "Dragon Egg" },
	"Dragon Eggshell": { name: "Dragon Eggshell" },
	"Drug injectors": { name: "Drug injectors" },
	"Dual Belt": { name: "Dual Belt" },
	"Dynapunch Glove": { name: "Dynapunch Glove" },
	"Earth Golem Core": { name: "Earth Golem Core" },
	"Engineer's Toolbox": { name: "Engineer's Toolbox" },
	"Equipment Rack - Armor": { name: "Equipment Rack - Armor" },
	"Equipment Rack - Shields": { name: "Equipment Rack - Shields" },
	"Equipment Rack - Weapons": { name: "Equipment Rack - Weapons" },
	"Equipment Storage - Jewelry Box": { name: "Equipment Storage - Jewelry Box" },
	"Fake Mare": { name: "Fake Mare" },
	"Fire Ifrit Core": { name: "Fire Ifrit Core" },
	"Fishing Pole": { name: "Fishing Pole" },
	"Flame Heart": { name: "Flame Heart" },
	"Frost Heart": { name: "Frost Heart" },
	"Gargoyle demonic researches": { name: "Gargoyle demonic researches" },
	"Gleipnir Collar": { name: "Gleipnir Collar" },
	"Golden Antlers": { name: "Golden Antlers" },
	"Golems, Animations and You": { name: "Golems, Animations and You" },
	"Gravity shots": { name: "Gravity shots" },
	"Gryphon Statuette": { name: "Gryphon Statuette" },
	"Gun Scope with Aim tech": { name: "Gun Scope with Aim tech" },
	"Gun Scope with Aimbot": { name: "Gun Scope with Aimbot" },
	"Gun Scope": { name: "Gun Scope" },
	"HB Agility": { name: "HB Agility" },
	"HB Armor Plating": { name: "HB Armor Plating" },
	"HB Dragon's Breath Flamer": { name: "HB Dragon's Breath Flamer" },
	"HB Internal Systems": { name: "HB Internal Systems" },
	"HB Leather Insulation": { name: "HB Leather Insulation" },
	"HB Rapid Reload": { name: "HB Rapid Reload" },
	"HB Scatter Laser": { name: "HB Scatter Laser" },
	"HB Stealth System": { name: "HB Stealth System" },
	"Harpoon gun": { name: "Harpoon gun" },
	"Harpy Key A": { name: "Harpy Key A" },
	"Harpy Key B": { name: "Harpy Key B" },
	"Hentai Comic": { name: "Hentai Comic" },
	"Holli's Ashes": { name: "Holli's Ashes" },
	"Holy Symbol": { name: "Holy Symbol" },
	"Impregnator 1.0": { name: "Impregnator 1.0" },
	"Improved Drug injectors": { name: "Improved Drug injectors" },
	"Iron Key": { name: "Iron Key" },
	"Izma's Book - Combat Manual": { name: "Izma's Book - Combat Manual" },
	"Izma's Book - Etiquette Guide": { name: "Izma's Book - Etiquette Guide" },
	"Izma's Book - Porn": { name: "Izma's Book - Porn" },
	"Jabala's Charm": { name: "Jabala's Charm" },
	"Jade Talisman": { name: "Jade Talisman" },
	"Jetpack": { name: "Jetpack" },
	"Jojo's Talisman": { name: "Jojo's Talisman" },
	"Key Of Darkness (1/3)": { name: "Key Of Darkness (1/3)" },
	"Key Of Darkness (2/3)": { name: "Key Of Darkness (2/3)" },
	"Key Of Darkness": { name: "Key Of Darkness" },
	"Kitsune Star Sphere": { name: "Kitsune Star Sphere" },
	"Lactoblasters": { name: "Lactoblasters" },
	"Laybans": { name: "Laybans" },
	"Lustnade Launcher": { name: "Lustnade Launcher" },
	"M.G.S. bracer": { name: "M.G.S. bracer" },
	"M1 Cerberus": { name: "M1 Cerberus" },
	"MK2 Jetpack": { name: "MK2 Jetpack" },
	"Machine Gun MK1": { name: "Machine Gun MK1" },
	"Machine Gun MK2": { name: "Machine Gun MK2" },
	"Machine Gun MK3": { name: "Machine Gun MK3" },
	"Marae's Lethicite": { name: "Marae's Lethicite" },
	"Marae's Seed": { name: "Marae's Seed" },
	"Mechanic's Wrench": { name: "Mechanic's Wrench" },
	"Medical Dispenser 2.0": { name: "Medical Dispenser 2.0" },
	"Missile launcher": { name: "Missile launcher" },
	"Mistress Elly's Slave Collar": { name: "Mistress Elly's Slave Collar" },
	"Mysterious Seed": { name: "Mysterious Seed" },
	"Nail's Box": { name: "Nail's Box" },
	"Nieve's Tear": { name: "Nieve's Tear" },
	"Nightmare Horns": { name: "Nightmare Horns" },
	"Nitro Boots": { name: "Nitro Boots" },
	"North Star Key": { name: "North Star Key" },
	"Old Pickaxe": { name: "Old Pickaxe" },
	"Omni Missile": { name: "Omni Missile" },
	"Onyx Token - Ceraph's": { name: "Onyx Token - Ceraph's" },
	"Opal Ring": { name: "Opal Ring" },
	"Ore Bag (Lowest grade)": { name: "Ore Bag (Lowest grade)" },
	"Peacock Statuette": { name: "Peacock Statuette" },
	"PerksOverJobs": { name: "PerksOverJobs" },
	"Plain Onahole": { name: "Plain Onahole" },
	"Potent Drug injectors": { name: "Potent Drug injectors" },
	"Potent Mixture": { name: "Potent Mixture" },
	"Powboy": { name: "Powboy" },
	"Power bracer": { name: "Power bracer" },
	"Radiant shard": { name: "Radiant shard" },
	"Raijin blaster": { name: "Raijin blaster" },
	"Rathazul's Purity Elixir": { name: "Rathazul's Purity Elixir" },
	"Rathazul's Purity Potion": { name: "Rathazul's Purity Potion" },
	"Repeater Gun": { name: "Repeater Gun" },
	"Rocket Boots": { name: "Rocket Boots" },
	"Ruby Heart": { name: "Ruby Heart" },
	"Ruby Orb": { name: "Ruby Orb" },
	"SPMK1": { name: "SPMK1" },
	"Safety bubble": { name: "Safety bubble" },
	"Self-Stimulation Belt": { name: "Self-Stimulation Belt" },
	"Sheila's Lethicite": { name: "Sheila's Lethicite" },
	"Siegweird's holy symbol": { name: "Siegweird's holy symbol" },
	"Silver Kitty-Bell": { name: "Silver Kitty-Bell" },
	"Sky Poison Pearl": { name: "Sky Poison Pearl" },
	"Snippler": { name: "Snippler" },
	"Snowball Generator": { name: "Snowball Generator" },
	"Soul Gem Research": { name: "Soul Gem Research" },
	"Spare Key to Urta's House": { name: "Spare Key to Urta's House" },
	"Spring Boots": { name: "Spring Boots" },
	"Stimpack Dispenser 1.0": { name: "Stimpack Dispenser 1.0" },
	"Stone Statue Lethicite": { name: "Stone Statue Lethicite" },
	"Super Reducto": { name: "Super Reducto" },
	"Supervisor's Key": { name: "Supervisor's Key" },
	"Tarnished Ore Bag (Lowest grade)": { name: "Tarnished Ore Bag (Lowest grade)" },
	"Taser with an overcharged battery": { name: "Taser with an overcharged battery" },
	"Taser": { name: "Taser" },
	"Tel'Adre Magazine Issue 5": { name: "Tel'Adre Magazine Issue 5" },
	"Tel'Adre Magazine Issue 10": { name: "Tel'Adre Magazine Issue 10" },
	"Toolbelt": { name: "Toolbelt" },
	"Torch": { name: "Torch" },
	"Touhouna M3": { name: "Touhouna M3" },
	"Training Crate - Installed In Prison Cell": { name: "Training Crate - Installed In Prison Cell" },
	"Traveler's Guide": { name: "Traveler's Guide" },
	"Tripxi Fatbilly": { name: "Tripxi Fatbilly" },
	"Twin Dart pistol": { name: "Twin Dart pistol" },
	"Twin Grakaturd": { name: "Twin Grakaturd" },
	"Upgraded Armor plating 1.0": { name: "Upgraded Armor plating 1.0" },
	"Upgraded Armor plating 2.0": { name: "Upgraded Armor plating 2.0" },
	"Upgraded Armor plating 3.0": { name: "Upgraded Armor plating 3.0" },
	"Warding Tome": { name: "Warding Tome" },
	"Water Undine Core": { name: "Water Undine Core" },
	"Whitefire Beam Cannon": { name: "Whitefire Beam Cannon" },
	"Yoga Guide": { name: "Yoga Guide" },
	"Zetaz's Map": { name: "Zetaz's Map" },
};

Gamedata.colors.push({name:"",rgb:"none"});

/**
 * Source: classes/BodyParts/Skin.as
 */
Gamedata.skin_coverage = [
	{ value: 0, text:"no coat"},
	{ value: 1, text:"partially covered"},
	{ value: 2, text:"mixed"},
	{ value: 3, text:"mostly covered"},
	{ value: 4, text:"fully covered"},
];

/**
 * Source: various transformations
 */
Gamedata.skinAdjs = [
	"",
	// skin lotions
	"tough", "smooth", "rough", "sexy",
	// pattern-related
	"tattooed", "battle tattooed", "scar shaped tattooed", "venomous markings-covered",
	"veined", "oily skin", "windswept scars", "black spider glyph-tattooed",
	// type-related
	"flawless", "slippery rubber-like",
	// mutations
	"latex", "rubber", "cold", "sticky glistering",
	// other
	"freckled", "glistering", "shiny", "slimy", "goopey",
];

Gamedata.skinDescs = [
	"", "covering", "feathers", "hide",
	"shell", "plastic", "skin", "fur",
	"scales", "bark", "stone", "chitin"
];

Gamedata.maxBreastRows = 5;

/**
 * Source: classes/AssClass.as
 */
Gamedata.analLooseness = [
	[0, "VIRGIN"],
	[1, "TIGHT"],
	[2, "NORMAL"],
	[3, "LOOSE"],
	[4, "STRETCHED"],
	[5, "GAPING"],
];

/**
 * Source: classes/AssClass.as
 */
Gamedata.analWetness = [
	[0, "DRY"],
	[1, "NORMAL"],
	[2, "MOIST"],
	[3, "SLIMY"],
	[4, "DROOLING"],
	[5, "SLIME_DROOLING"],
];

/**
 * Source: VaginaClass.as
 */
Gamedata.defaultVagina = {
	type: 0,
	vaginalWetness: 0,
	vaginalLooseness: 0,
	fullness: 0,
	virgin: true,
	labiaPierced: 0,
	labiaPShort: "",
	labiaPLong: "",
	clitPierced: 0,
	clitPShort: "",
	clitPLong: "",
	clitLength: 0.5,
	recoveryProgress: 0,
};

Gamedata.maxVaginas = 2;

/**
 * Source: VaginaClass.as
 */
Gamedata.vaginalWetness = [
	[0, "DRY"],
	[1, "NORMAL"],
	[2, "WET"],
	[3, "SLICK"],
	[4, "DROOLING"],
	[5, "SLAVERING"],
]

/**
 * Source: VaginaClass.as
 */
Gamedata.vaginalLooseness = [
	[0, "TIGHT"],
	[1, "NORMAL"],
	[2, "LOOSE"],
	[3, "GAPING"],
	[4, "GAPING_WIDE"],
	[5, "LEVEL_CLOWN_CAR"],
]

/**
 * Source: classes/PregnancyStore.as
 */
Gamedata.maxPregnanyIncubation = 2160;

/**
 * Source: classes/PregnancyStore.as
 */
Gamedata.pregnancyType = [
	{value:0, text:"(none)"},
	{value:1, text:"IMP"},
	{value:2, text:"MINOTAUR"},
	{value:3, text:"COCKATRICE"},
	{value:4, text:"MOUSE"},
	{value:5, text:"OVIELIXIR_EGGS"},
	{value:6, text:"HELL_HOUND"},
	{value:7, text:"CENTAUR"},
	{value:8, text:"MARBLE"},
	{value:9, text:"BUNNY"},
	{value:10, text:"ANEMONE"},
	{value:11, text:"AMILY"},
	{value:12, text:"IZMA"},
	{value:13, text:"SPIDER"},
	{value:14, text:"BASILISK"},
	{value:15, text:"DRIDER_EGGS"},
	{value:16, text:"GOO_GIRL"},
	{value:17, text:"EMBER"},
	{value:18, text:"BENOIT"},
	{value:19, text:"SATYR"},
	{value:20, text:"COTTON"},
	{value:21, text:"URTA"},
	{value:22, text:"SAND_WITCH"},
	{value:23, text:"FROG_GIRL"},
	{value:24, text:"FAERIE"},
	{value:25, text:"PLAYER"},
	{value:26, text:"BEE_EGGS"},
	{value:27, text:"SANDTRAP_FERTILE"},
	{value:28, text:"SANDTRAP"},
	{value:29, text:"JOJO"},
	{value:30, text:"KELT"},
	{value:31, text:"TAOTH"},
	{value:32, text:"GOO_STUFFED"},
	{value:33, text:"WORM_STUFFED"},
	{value:34, text:"MINERVA"},
	{value:35, text:"BEHEMOTH"},
	{value:36, text:"PHOENIX"},
	{value:37, text:"ANDY"},
	{value:38, text:"ALRAUNE"},
	{value:39, text:"CELESS"},
	{value:40, text:"GOBLIN"},
	{value:41, text:"ZENJI"},
	{value:42, text:"AYANE"},
]

/**
 * Source: Creature.as/Player.as
 */
Gamedata.equipmentSlots = [{
	label: "Armor",
	ref: "armorId",
	category: "armor"
}, {
	label: "Weapon",
	ref: "weaponId",
	category: "weapon"
}, {
	label: "Ranged Weapon",
	ref: "weaponRangeId",
	category: "weaponrange"
}, {
	label: "Shield",
	ref: "shieldId",
	category: "shield"
}, {
	label: "Undergarment (Upper)",
	ref: "upperGarmentId",
	category: "undergarment"
}, {
	label: "Undergarment (Lower)",
	ref: "lowerGarmentId",
	category: "undergarment"
}, {
	label: "Jewelry (head)",
	ref: "headJewelryId",
	category: "headjewelry"
}, {
	label: "Necklace",
	ref: "necklaceId",
	category: "necklace"
}, {
	label: "Jewelry (1)",
	ref: "jewelryId",
	category: "jewelry"
}, {
	label: "Jewelry (2)",
	ref: "jewelryId2",
	category: "jewelry"
}, {
	label: "Jewelry (3)",
	ref: "jewelryId3",
	category: "jewelry"
}, {
	label: "Jewelry (4)",
	ref: "jewelryId4",
	category: "jewelry"
}, {
	label: "Jewelry (Misc 1)",
	ref: "miscJewelryId",
	category: "miscjewelry"
}, {
	label: "Jewelry (Misc 2)",
	ref: "miscJewelryId2",
	category: "miscjewelry"
}, {
	label: "Flying Sword",
	ref: "weaponFlyingSwordsId",
	category: "flyingsword"
}, {
	label: "Vehicle",
	ref: "vehiclesId",
	category: "vehicle"
}];

Gamedata.itemCategoryNames = {
	armor: "Armor",
	consumable: "Consumable",
	flyingsword: "Flying Sword",
	jewelry: "Jewelry",
	headjewelry: "Jewelry (Head)",
	miscjewelry: "Jewelry (Misc)",
	necklace: "Necklace",
	other: "Other",
	shield: "Shield",
	undergarment: "Undergarment",
	useable: "Useable",
	vehicle: "Vehicle",
	weapon: "Weapon",
	weaponrange: "Weapon (Ranged)",
};

Gamedata.maxItemsInSlot = 5;

/**
 * Source: Inventory.as
 */
Gamedata.gearStorages = [{
	name: "Weapon Rack",
	start: 0,
	end: 9,
	categories: ["weapon", "weaponrange"]
}, {
	name: "Armor Rack",
	start: 9,
	end: 18,
	categories: ["armor"]
}, {
	name: "Jewelry Box",
	start: 18,
	end: 27,
	categories: ["jewelry"]
}, {
	name: "Dresser",
	start: 27,
	end: 36,
	categories: ["undergarment"]
}, {
	name: "Shield Rack",
	start: 36,
	end: 45,
	categories: ["shield"]
}, {
	name: "Warehouse 1",
	start: 57,
	end: 69
}, {
	name: "Granary",
	start: 69,
	end: 78,
	categories: ["consumable"]
}, {
	name: "Warehouse 2",
	start: 78,
	end: 90
}];

/**
 * Editable values
 */

/**
 * Array of pairs [key in Gamedata.values, displayed tab name]
 */
Gamedata.storyGroups = [
	["story_misc", "Misc"],
	["ss_adventurer_guild", "Adventurer Guild"],
	["ss_aether_twins", "Aether Twins"],
	["ss_belisa", "Belisa"],
	["x_celess", "Celess"],
	["ss_crafting", "Crafting"],
	["x_diva", "Diva"],
	["ss_drider_town", "Drider Town"],
	["ss_evangeline", "Evangeline"],
	["ss_forgefather", "Forgefather"],
	["ss_harvestmoon", "Harvest"],
	["ss_jtte", "Journey To The East"],
	["ss_lily", "Lily"],
	["ss_luna", "Luna"],
	["ss_mindbreaker", "Mindbreaker"],
	["ss_trollvillage", "Troll Village"],
	["ss_tyrantia", "Tyrantia"],
	["ss_vala", "Vala"],
	["ss_waizabi", "WaizAbiFollower"],
	["ss_woodelves", "Wood Elves"],
	["ss_zenji", "Zenji"],
];

Gamedata.values = {
	stats_main: [
		{
			id: 'name',
			ref: 'short',
			type: 'text',
			label: 'Name',
			cols: 6
		}, {
			id: 'startingRace',
			ref: 'startingRace',
			type: 'text',
			label: 'Starting race',
			cols: 6
		}, {
			id: 'cor',
			ref: 'cor',
			type: 'slider',
			min: 0,
			max: 100,
			color: 'purple',
			label: 'Corruption'
		}, {
			id: 'gems',
			ref: 'gems',
			type: 'number',
			min: 0,
			max: 1_000_000_000,
			label: "Gems"
		},
		"Progression",
		{
			id: 'level',
			ref: 'level',
			type: 'number',
			min: 0,
			max: 185,
			label: 'Level',
			cols: 6
		}, {
			id: 'xp',
			ref: 'XP',
			type: 'number',
			min: 0,
			label: 'XP',
			cols: 6
		}, {
			id: 'perkPoints',
			ref: 'perkPoints',
			type: 'number',
			min: 0,
			label: 'Perk points',
			cols: 6
		}, {
			id: 'statPoints',
			ref: 'statPoints',
			type: 'number',
			min: 0,
			label: 'Stat points',
			cols: 6
		}, {
			id: 'superPerkPoints',
			ref: 'superPerkPoints',
			type: 'number',
			min: 0,
			label: 'Super perk points',
			cols: 6
		}, {
			id: 'ascensionPerkPoints',
			ref: 'ascensionPerkPoints',
			type: 'number',
			min: 0,
			label: 'Ascension perk points',
			cols: 6
		}
	],
	stats_resources: [
		{
			id: 'hp',
			ref: 'HP',
			type: 'bignumber',
			label: 'HP'
		}, {
			id: 'lust',
			ref: 'lust',
			type: 'bignumber',
			label: 'Lust',
			min: 0
		}, {
			id: 'fatigue',
			ref: 'fatigue',
			type: 'bignumber',
			label: 'Fatigue',
			min: 0
		}, {
			id: 'mana',
			ref: 'mana',
			type: 'bignumber',
			label: 'Mana',
			min: 0
		}, {
			id: 'soulforce',
			ref: 'soulforce',
			type: 'bignumber',
			label: 'Soulforce',
			min: 0
		}, {
			id: 'wrath',
			ref: 'wrath',
			type: 'bignumber',
			label: 'Wrath',
			min: 0
		}
	],
	stats_skills: [
		{
			prefix: "tease",
			max: 70,
			label: "Tease"
		}, {
			prefix: "mining",
			max: 20,
			label: "Mining"
		}, {
			prefix: "herbalism",
			max: 20,
			label: "Herbalism"
		},
		{prefix: 'masteryArchery', label: "Archery mastery"},
		{prefix: 'masteryAxe', label: "Axe mastery"},
		{prefix: 'masteryDagger', label: "Dagger mastery"},
		{prefix: 'dualWS', label: "Dual Wielding (Small) mastery"},
		{prefix: 'dualWN', label: "Dual Wielding (Normal) mastery"},
		{prefix: 'dualWL', label: "Dual Wielding (Large) mastery"},
		{prefix: 'dualWF', label: "Dual Wielding (Firearms) mastery"},
		{prefix: 'masteryDuelingSword', label: "Dueling Sword mastery"},
		{prefix: 'masteryExotic', label: "Exotic mastery"},
		{prefix: 'masteryFeralCombat', label: "Feral combat mastery"},
		{prefix: 'masteryFirearms', label: "Firearms mastery"},
		{prefix: 'masteryGauntlet', label: "Gauntlet mastery"},
		{prefix: 'masteryMaceHammer', label: "Mace&Hammer mastery"},
		{prefix: 'masteryPolearm', label: "Polearm mastery"},
		{prefix: 'masterySpear', label: "Spear mastery"},
		{prefix: 'masterySword', label: "Sword mastery"},
		{prefix: 'masteryThrowing', label: "Throwing mastery"},
		{prefix: 'masteryWhip', label: "Whip mastery"},
	].flatMap(x=>[{
		id: x.prefix+"Level",
		ref: x.levelRef ?? x.prefix+"Level",
		min: 0,
		max: x.max ?? 150,
		type: "number",
		label: x.label+" level",
		cols: 6
	}, {
		id: x.prefix+"XP",
		ref: x.xpRef ?? x.prefix+"XP",
		min: 0,
		type: "number",
		label: x.label+" XP",
		cols: 6
	}]),
	body_stats: [
		{
			id: 'femininity',
			ref: "femininity",
			type: "slider",
			min: 0,
			max: 100,
			label: "Femininity"
		}, {
			id: 'thickness',
			ref: "thickness",
			type: "slider",
			min: 0,
			max: 170,
			label: "Thickness"
		}, {
			id: 'tone',
			ref: "tone",
			type: "slider",
			min: 0,
			max: 170,
			label: "Muscle tone"
		}, {
			id: 'height',
			ref: "tallness",
			type: "slider",
			min: 42,
			max: 144,
			label: "Height",
			hint: "inches"
		}, {
			id: "hipRating",
			ref: 'hipRating',
			type: "tierslider",
			min: 0,
			max: 20,
			label: "Hip width",
			tiers: [
				[0, "boyish"],
				[2, "slender"],
				[4, "average"],
				[6, "ample"],
				[10, "curvy"],
				[15, "fertile"],
				[20, "inhumanly wide"],
			]
		}, {
			id: "buttRating",
			ref: 'buttRating',
			type: "tierslider",
			min: 0,
			max: 20,
			label: "Butt size",
			tiers: [
				[0, "buttless"],
				[2, "tight"],
				[4, "average"],
				[6, "noticeable"],
				[8, "large"],
				[10, "jiggly"],
				[13, "expansive"],
				[15, "huge"],
				[20, "inconceivably big"],
			]
		}
	],
	story_misc: [{
		id: "story_misc_jojo",
		ref: "monk",
		label: "Jojo corruption status",
		type: "enum",
		items: [
			{value:0, text:"(0) Not met"},
			{value:1, text:"(1) Met"},
			{value:2, text:"(2) Corrupt x1"},
			{value:3, text:"(3) Corrupt x2"},
			{value:4, text:"(4) Corrupt x3"},
			{value:5, text:"(5) Corrupt fully"},
			{value:-1, text:"(-1) Denied sex first time"},
			{value:-2, text:"(-2) Denied sex at high affection"},
			{value:-3, text:"(-3) Had sex"},
		]
	}, {
		id: "story_misc_sand",
		ref: "sand",
		label: "Was raped by Sand Witch",
		type: "checkbox"
	}, {
		id: "story_misc_explored",
		ref: "explored",
		label: "Times explored",
		type: "number"
	}, {
		id: "story_misc_exploredLake",
		ref: "exploredLake",
		label: "Times explored Lake",
		type: "number"
	}, {
		id: "story_misc_exploredMountain",
		ref: "exploredMountain",
		label: "Times explored Mountain",
		type: "number"
	}, {
		id: "story_misc_exploredDesert",
		ref: "exploredDesert",
		label: "Times explored Desert",
		type: "number"
	}, {
		id: "story_misc_exploredForest",
		ref: "exploredForest",
		label: "Times explored Forest",
		type: "number"
	}],
	ss_adventurer_guild: [
		...Array.from(Array(30).keys()).map(i=>(i+1)).map(i=>i<10?"0"+i:""+i).flatMap(i=>[
			cvOfSs("AdventurerGuild", "Slot"+i, "number"),
			cvOfSs("AdventurerGuild", "Slot"+i+"Cap", "number")
		])
	],
	ss_aether_twins: customValuesOfSaveableState("AetherTwinsScenes",{
		"AetherTwinsShape": "text",
		"AetherTwinsCount": "number",
		"AetherTwinsTalkMenu": "number",
		"AetherTwinsFoodMenuTin": "number",
		"AetherTwinsFoodMenuTinCap": "number",
		"AetherTwinsFoodMenuCopper": "number",
		"AetherTwinsFoodMenuCopperCap": "number",
		"AetherTwinsFoodMenuIron": "number",
		"AetherTwinsFoodMenuIronCap": "number",
		"AetherTwinsFoodMenuSilver": "number",
		"AetherTwinsFoodMenuSilverCap": "number",
		"AetherTwinsFoodMenuGold": "number",
		"AetherTwinsFoodMenuGoldCap": "number",
		"AetherTwinsFoodMenuWorldTreeBranch": "number",
		"AetherTwinsFoodMenuWorldTreeBranchCap": "number",
		"AetherTwinsFoodMenuDiamond": "number",
		"AetherTwinsFoodMenuDiamondCap": "number",
		"AetherTwinsFoodMenuAmethyst": "number",
		"AetherTwinsFoodMenuAmethystCap": "number",
		"AetherTwinsFoodMenuMoonstone": "number",
		"AetherTwinsFoodMenuMoonstoneCap": "number",
		"AetherTwinsFoodMenuSkymetal": "number",
		"AetherTwinsFoodMenuSkymetalCap": "number",
		"AetherTwinsFoodMenuAdamantine": "number",
		"AetherTwinsFoodMenuAdamantineCap": "number",
		"AetherTwinsFoodMenuOrichalcum": "number",
		"AetherTwinsFoodMenuOrichalcumCap": "number",
		"AetherTwinsFoodMenu": "checkbox",
		"AetherTwinsFoodMenuBuckler": "checkbox",
		"AetherTwinsFoodMenuSpikeLShield": "checkbox",
		"AetherTwinsFoodMenuSGauntlet": "checkbox",
		"AetherTwinsFoodMenuClaws": "checkbox",
		"AetherTwinsFoodMenuHGaunt": "checkbox",
		"AetherTwinsFoodMenuBFGauntlets": "checkbox",
		"AetherTwinsFoodMenuLustyClaws": "checkbox",
		"AetherTwinsFoodMenu2": "checkbox",
		"AetherTwinsFoodMenu1": "checkbox"
	}),
	ss_belisa: customValuesOfSaveableState("BelisaFollower", {
		"BelisaEncounternum": "number",
		"BelisaAffectionMeter": "number",
		"BelisaInGame": "checkbox",
		"BelisaFollowerStage": "number",
		"BelisaVirgin": "checkbox",
		"BelisaShopOpen": "checkbox",
		"BelisaQuestOn": "checkbox",
		"BelisaRalthTalked":"checkbox",
		"BelisaQuestComp": "checkbox",
		"BelisaConfessed": "checkbox",
		"BelisaToldTyrantia": "checkbox",
		"BelisaInCamp": "checkbox",
		"HolyBand1": "number",
		"HolyBand1Cap": "number",
		"HolyBand2": "number",
		"HolyBand2Cap": "number",
		"HolyBand3": "number",
		"HolyBand3Cap": "number",
		"HolyBand4": "number",
		"HolyBand4Cap": "number",
		"HolyBand5": "number",
		"HolyBand5Cap": "number",
		"HolyBand6": "number",
		"HolyBand6Cap": "number",
		"HolyBand7": "number",
		"HolyBand7Cap": "number"
	}),
	ss_crafting: [
		...Array.from(Array(40).keys()).map(i=>(i+1)).map(i=>i<10?"0"+i:""+i).flatMap(i=>[
			cvOfSs("Crafting","BagSlot"+i,"number"),
			cvOfSs("Crafting","BagSlot"+i+"Cap","number"),
		])
	],
	ss_drider_town: customValuesOfSaveableState("DriderTown", {
		"DriderTownComplete": "checkbox",
		"SisterBangEnabled": "checkbox",
		"BelisaKids": "number",
		"BelisaPregnancy": "number",
		"BelisaKidsEggs": "number",
		"BelisaKidsEggs1": "number",
		"BelisaKidsEggs2": "number",
		"BelisaKidsEggsHatching": "number",
		"BelisaKidsEggsHatching1": "number",
		"BelisaKidsEggsHatching2": "number",
		"LilyKidsPC": "number",
		"LilyKidsPCPregnancy": "number",
		"LilyKidsPCEggs": "number",
		"LilyKidsPCEggs1": "number",
		"LilyKidsPCEggs2": "number",
		"LilyKidsPCEggsHatching": "number",
		"LilyKidsPCEggsHatching1": "number",
		"LilyKidsPCEggsHatching2": "number",
		"LilyKidsIzma": "number",
		"LilyKidsIzmaPregnancy": "number",
		"LilyKidsSidone": "number",
		"LilyKidsSidonePregnancy": "number",
		"TyrantiaMaleKids": "number",
		"TyrantiaFemaleKids": "number",
		"TyrantiaPregnancy": "number",
		"TyrantiaKidsEggs": "number",
		"TyrantiaKidsEggs1": "number",
		"TyrantiaKidsEggs2": "number",
		"TyrantiaKidsEggsHatching": "number",
		"TyrantiaKidsEggsHatching1": "number",
		"TyrantiaKidsEggsHatching2": "number"
	}),
	ss_evangeline: customValuesOfSaveableState("EvangelineFollower", {
		"EvangelinePeepTalkOnInternalMutations": "number",
		"EvangelineGemsPurse": "number",
		"EvangelineTalks": "number",
		"EvangelineAffectionMeter": "number",
		"EvangelineFollowerStage": "number"
	}),
	ss_forgefather: customValuesOfSaveableState("ForgeFatherScenes", {
		"hairLength": "number",
		"gender": "number",
		"wings": "number",
		"arms": "number",
		"tail": "number",
		"lowerBody": "number",
		"chest": "number",
		"vagina": "number",
		"cock": "number",
		"balls": "number",
		"granite": "number",
		"ebony": "number",
		"marble": "number",
		"sandstone": "number",
		"alabaster": "number",
		"material": ["enum", {
			items: [
				"",
				"granite",
				"ebony",
				"alabaster",
				"marble",
				"sandstone"
			]
		}],
		"refinement": "number",
		"channelInlay": ["enum", {
			items: [
				"",
				"amethyst",
				"emerald",
				"ruby",
				"sapphire",
				"topaz"
			]
		}],
		"gem": ["enum", {
			items: [
				"",
				"amethyst",
				"emerald",
				"ruby",
				"sapphire",
				"topaz"
			]
		}],
		"rarityAbsorbed": "text",
		"purePearlEaten": "checkbox",
		"lethiciteEaten": "checkbox",
		"materialsExplained": "checkbox",
		"refinementExplained": "checkbox",
		"inlaysExplained": "checkbox",
		"gemstonesExplained": "checkbox"
	}),
	ss_harvestmoon: customValuesOfSaveableState("CampScenes", {
		"stageHH": "number",
		"stageMG": "number",
		"stageSB": "number",
		"stageIW": "number",
		"stageBF": "number"
	}),
	ss_jtte: customValuesOfSaveableState("JourneyToTheEast", {
		"AhriStatsToPerksConvertCounter": "number",
		"AhriTavernTalks": "checkbox",
		"EvelynnPerksToStatsConvertCounter": "number",
		"EvelynnTavernTalks": "checkbox"
	}),
	ss_lily: customValuesOfSaveableState("LilyFollower", {
		"LilyHairColor": "text",
		"LilySkinTone": "text",
		"LilyAffectionMeter": "number",
		"LilySubmissivenessMeter": "number",
		"LilyTalked": "number",
		"LilyFollowerState": "checkbox",
		"LilyExhibitionAble": "checkbox",
		"Lily3SomeSidonie": "checkbox",
		"Lily3SomeIzma": "checkbox",
	}),
	ss_luna: customValuesOfSaveableState("LunaFollower", {
		"LunaNursed": "checkbox",
		"LunaNursedCooldown": "number",
		"LunaSated": "checkbox",
		"LunaSatedCooldown": "number",
	}),
	ss_mindbreaker: customValuesOfSaveableState("Mindbreaker", {
		"stage": "number",
		"numberOfConvert": "number",
		"numberOfConvertGoal": "number",
		"numberOfGoblinConvert": "number",
		"numberOfFetishFemaleConvert": "number",
		"numberOfFetishMaleConvert": "number",

		"numberOfFullConvert": "number",
		"numberOfFullFemaleConvert": "number",
		"numberOfMaleFullConvert": "number",
		"numberOfMiniFullConvert": "number",

		"playerEggIsFertile": "checkbox",
		"mindbreakerPrisoner": "checkbox",
		"mindbreakerPrisonerCooldown": "number",
	}),
	ss_trollvillage: customValuesOfSaveableState("TrollVillage", {
		"ZenjiVillageStage": "number",
		"JabalaUnlocked": "checkbox",
		"YenzaUnlocked": "checkbox",
		"KaljiUnlocked": "number",
		"ZenjiFollowing": "checkbox",
		"KuruUnlocked": "checkbox",
		"HalkanoUnlocked": "checkbox",
		"ZenjiBerated": "checkbox",
		"YenzaLockdown": "number",
		"ZenjiTrollVillageTimeChk": "number",
		"YubiUnlocked": "checkbox",
		"KaljiMBJDeny": "number",
		"ZenjiMoneyHelp": "number",
		"JabalaLoveChat": "checkbox",
		"ZenjiSleep": "checkbox",
		"ZenjiMarriageDress": "number",
	}),
	ss_tyrantia: customValuesOfSaveableState("TyrantiaFollower", {
		"TyraniaIsRemovedFromThewGame": "checkbox",
		"TyraniaPostFinalKissScene": "checkbox",
		"TyraniaSeenFlitzy": "checkbox",
		"TyraniaAndIzumi": "checkbox",
		"TyrantiaAffectionMeter": "number",
		"TyrantiaFollowerStage": "number",
		"TyrantiaTrainingSessions": "number",
		"TyraniaThePhalluspear": "checkbox",
		"TyraniaDriderJuggernautPlate": "checkbox",
		"TyraniaCorrupteedLegendaries": "number",
	}),
	ss_vala: customValuesOfSaveableState("ValaScene", {
		"stage": "number",
	}),
	ss_waizabi: customValuesOfSaveableState("WaizAbiFollower", {
		"WaizAbiState": "number",
		"WaizAbiAffection": "number",
		"WaizAbiWrathMulti": "number",
		"WaizAbiHPMulti": "number",
		"WaizAbiSoulforceMulti": "number",
		"WaizAbiLustMulti": "number",
		"WaizAbiOtherSecondaryBarsMulti": "number",
		"WaizAbiStrMulti": "number",
		"WaizAbiSpeMulti": "number",
		"WaizAbiTouMulti": "number",
		"WaizAbiWisMulti": "number",
		"WaizAbiIntMulti": "number",
		"WaizAbiLibMulti": "number",
		"WaizAbiSensMulti": "number",
	}),
	ss_woodelves: customValuesOfSaveableState("WoodElves", {
		"stage": "number",
		"stageBow": "number",
		"stageSpear": "number",
		"elfHasTrainedToday": "checkbox",
	}),
	ss_zenji: customValuesOfSaveableState("ZenjiScenes", {
		"Z1stKid": "text",
		"Z2ndKid": "text",
		"ZenjiNightWatch": "number",
		"ZenjiFood": "checkbox",
		"ZenjiMarae": "checkbox",
		"ZenjiHolli": "checkbox",
		"ZenjiMarried": "checkbox",
		"ZenjiFigMulti": "number",
		"ZenjiSleepCount": "number",
		"ZenjiLoverDays": "number",
		"ZenjiLoverDaysTracker" : "number",
		"ZenjiTalkCount": "number",
	}),
	x_celess: [{
		id: "celess_age",
		ref: "world.x.celess.age",
		label: "Age",
		type: "number"
	}, {
		id: "celess_corruption",
		ref: "world.x.celess.corruption",
		label: "Corruption",
		type: "number"
	}, {
		id: "celess_name",
		ref: "world.x.celess.name",
		label: "Name",
		type: "text"
	}, {
		id: "celess_armorFound",
		ref: "world.x.celess.armorFound",
		label: "Armor Found",
		type: "checkbox"
	}, {
		id: "celess_questFinished",
		ref: "world.x.celess.questFinished",
		label: "Quest Finished",
		type: "enum",
		items: [
			{value:0, text:"Not finished"},
			{value:1, text:"Finished (Unicorn)"},
			{value:-1, text:"Finished (Nightmare)"},
		]
	}],
	x_diva: [{
		id: "diva_status",
		ref: "world.x.diva.status",
		label: "Status",
		type: "number"
	}, {
		id: "diva_firstLoss",
		ref: "world.x.diva.firstLoss",
		label: "First Loss",
		type: "checkbox"
	}, {
		id: "diva_tookVialToday",
		ref: "world.x.diva.tookVialToday",
		label: "Took Vial Today",
		type: "checkbox"
	}, {
		id: "diva_timesReduced",
		ref: "world.x.diva.timesReduced",
		label: "Times Reduced",
		type: "number"
	}, {
		id: "diva_bloodUsed",
		ref: "world.x.diva.bloodUsed",
		label: "Blood Used",
		type: "checkbox"
	}],
};
/*
TODO
isabellaOffspringData
 */

/////////////////////////////
// Utilities
/////////////////////////////

/**
 * Create a IGDCustomValue for saveable state
 * @param ssName Name of SaveableState object
 * @param varName SaveableState saved variable
 * @param varType IGDCustomValue type
 * @param extraProps Extra IGDCustomValue props
 * @return {IGDCustomValue}
 */
function cvOfSs(ssName,varName,varType,extraProps={}) {
	return {
		id: "ss_"+ssName+"_"+varName,
		ref: "ss."+ssName+"."+varName,
		label: varName,
		type: varType,
		...extraProps
	}
}

/**
 * Create a multiple IGDCustomValue from
 * @param ssName
 * @param {Record<string,IGDSSDef>} items
 */
function customValuesOfSaveableState(ssName,items) {
	return Object.entries(items).map(([id,def])=>{
		// id: "type"
		if (typeof def === "string") return cvOfSs(ssName,id,def);
		// id: ["type", "label"]
		if (typeof def[1] === "string") return cvOfSs(ssName,id,def[0],{label:def[1]});
		// id: ["type", props]
		return cvOfSs(ssName,id,def[0],def[1]);
	})
}
