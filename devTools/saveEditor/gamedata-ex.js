// See js/gamedata.d.ts for Gamedata structure

// noinspection JSValidateTypes
/**
 * @type {IExtendedGamedata}
 */
let Gamedata = ExportedGamedata;

/**
 * Flag descriptions
 */
Gamedata.flags[1].desc = "Marble Pregnancy Incubation";

Object.assign(Gamedata.perks["Accuracy-"],{
	tags: ["item"],
	hasv1: true,
	v1desc: "penalty in 0.5%"
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
	"Stone Building Guide": { name: "Stone Building Guide" },
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

/**
 * Editable values
 */
Gamedata.setup = {
	values: {
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
				type: "tierSlider",
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
				type: "tierSlider",
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
		]
	}
}
