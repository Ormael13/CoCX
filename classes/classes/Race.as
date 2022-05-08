package classes {
import classes.BodyParts.*;
import classes.Scenes.Areas.Forest.KitsuneScene;
import classes.internals.Utils;
import classes.internals.race.RaceBuilder;
import classes.internals.race.RacialRequirement;
import classes.lists.Gender;

public class Race {
    public static const ALL_RACES:/*Race*/Array = [];
    
    // Race builder helper functions. Can be used as a substitute for type
	// Ex. faceType( ANY(Face.HUMAN, Face.TROLL), +1)
	// instead of faceType(Face.HUMAN, +1).faceType(Face.TROLL, +1)
	
    private static function ANY(...options:Array):* {
        return {operator:"any",options:Utils.flatten(options)};
    }
	private static function NONE(...options:Array):* {
        return {operator:"none",options:Utils.flatten(options)};
    }
	private static function LESS_THAN(value:Number):* {
        return {operator:"lt",value:value};
    }
	private static function GREATER_THAN(value:Number):* {
        return {operator:"gt",value:value};
    }
	private static function AT_MOST(value:Number):* {
        return {operator:"lte",value:value};
    }
	private static function AT_LEAST(value:Number):* {
        return {operator:"gte",value:value};
    }
	private static function NOT(value:Number):* {
        return {operator:"ne",value:value};
    }
	
	private static const raceClass:Class = Race;
    private static function buildRace(id:int, name:String): RaceBuilder {
        return new RaceBuilder(raceClass, id, name);
    }

    public static const HUMAN:Race = new Race("Human",1, "humanScore", 1);
    public static const CAT:Race = new Race("Cat",2,"catScore", 8);
    public static const NEKOMATA:Race = new Race("Nekomata",3,"nekomataScore", 10);
    public static const CHESHIRE:Race = new Race("Cheshire",4, "cheshireScore", 11);
    public static const HELLCAT:Race = new Race("Hellcat",5, "hellcatScore", 10);
    public static const DISPLACERBEAST:Race = new Race("Displacer beast",6, "displacerbeastScore", 14);
    public static const SPHINX:Race = new Race("Sphinx",7, "sphinxScore", 14);
    public static const LIZARD:Race = new Race("Lizard",8, "lizardScore", 8);
    public static const DRAGON:Race =
		buildRace(9, "dragon")
				.withScores()
					.faceType(ANY(Face.DRAGON,Face.DRAGON_FANGS), +1)
					.faceType(ANY(Face.JABBERWOCKY,Face.BUCKTOOTH), -10)
					.eyeType(Eyes.DRACONIC,+1)
					.earType(Ears.DRAGON,+1)
					.tailType(Tail.DRACONIC, +1)
					.tongueType(Tongue.DRACONIC,+1)
					.wingType(Wings.DRACONIC_SMALL,+1)
					.wingType(Wings.DRACONIC_LARGE,+2)
					.wingType(Wings.DRACONIC_HUGE,+4)
					.wingType(Wings.FEY_DRAGON,-10)
					.legType(LowerBody.DRAGON,+1)
					.legType(LowerBody.FROSTWYRM,-10)
					.armType(Arms.DRACONIC,+1)
					.skinCoatType(Skin.DRAGON_SCALES, +1)
					.hornType(Horns.DRACONIC_X2, +1)
					.hornType(Horns.DRACONIC_X4_12_INCH_LONG, +2)
					.hornType(Horns.FROSTWYRM, -3)
					.hasCockOfType(CockTypesEnum.DRAGON,+1)
					.gender(Gender.GENDER_FEMALE, +1)
				.end()
				.withScoresAfter(5)
					.perk(MutationsLib.DraconicBones, +1)
					.perk(MutationsLib.DraconicBonesPrimitive, +1)
					.perk(MutationsLib.DraconicBonesEvolved, +1)
					.perk(MutationsLib.DraconicHeart, +1)
					.perk(MutationsLib.DraconicHeartPrimitive, +1)
					.perk(MutationsLib.DraconicHeartEvolved, +1)
					.perk(MutationsLib.DraconicLungs, +1)
					.perk(MutationsLib.DraconicLungsPrimitive, +1)
					.perk(MutationsLib.DraconicLungsEvolved, +1)
				.end()
				.withScoresAfter(8)
					.height(GREATER_THAN(120),+1)
					.anyPerk([PerkLib.DragonFireBreath,PerkLib.DragonIceBreath,PerkLib.DragonLightningBreath,PerkLib.DragonDarknessBreath],+1)
					.allPerks([PerkLib.DragonFireBreath,PerkLib.DragonIceBreath,PerkLib.DragonLightningBreath,PerkLib.DragonDarknessBreath],+1)
				.end()
				.withBloodline([PerkLib.DragonsDescendant,PerkLib.BloodlineDragon])
				.withTier(16, "dragon")
					.customNamingFunction(function(body:BodyData):String {
						if (body.isTaur) return "dragon-taur";
						if (body.faceType == Face.HUMAN) return "dragon-"+body.mf("man","girl");
						return "dragon";
					})
					.buffs({
						"maxhp_mult": +0.10,
						"str.mult": +0.50,
						"tou.mult": +0.50,
						"spe.mult": +0.50,
						"int.mult": +0.40,
						"wis.mult": +0.40,
						"lib.mult": +0.30,
						"sens": +20
					})
					.withExtraBonuses("+1 Armor / Magic Resistance")
				.end()
				.withTier(24,"elder dragon")
					.customNamingFunction(function(body:BodyData):String {
						if (body.isTaur) return "elder dragon-taur";
						if (body.faceType == Face.HUMAN) return "elder dragon-"+body.mf("man","girl");
						return "elder dragon";
					})
					.buffs({
						"maxfatigue_base": +100,
						"maxlust_base": +25,
						"maxhp_mult": +0.20,
						"str.mult": +0.80,
						"tou.mult": +0.80,
						"spe.mult": +0.80,
						"int.mult": +0.70,
						"wis.mult": +0.70,
						"lib.mult": +0.40,
						"sens": +30
					})
					.withExtraBonuses("+4 Armor / Magic Resistance")
				.end()
				.withTier(32,"ancient dragon")
					.customNamingFunction(function(body:BodyData):String {
						if (body.isTaur) return "ancient dragon-taur";
						if (body.faceType == Face.HUMAN) return "ancient dragon-"+body.mf("man","girl");
						return "ancient dragon";
					})
					.buffs({
						"maxfatigue_base": +200,
						"maxlust_base": +50,
						"maxhp_mult": +0.30,
						"str.mult": +1.00,
						"tou.mult": +1.00,
						"spe.mult": +1.00,
						"int.mult": +0.80,
						"wis.mult": +0.80,
						"lib.mult": +0.60,
						"sens": +40
					})
					.withExtraBonuses("+10 Armor / Magic Resistance")
				.end()
				.build()
    public static const DRAGONNE:Race = new Race("Dragonne",10, "dragonneScore", 6);
    public static const RACCOON:Race = new Race("Raccoon",11,"raccoonScore", 8);
    public static const DOG:Race = new Race("Dog",12,"dogScore", 4);
	public static const WOLF: Race =
			buildRace(13, "wolf")
					.withScores()
						.faceType(ANY(Face.WOLF, Face.ANIMAL_TOOTHS), +1)
						.eyeType(Eyes.FENRIR, +3)
						.eyeType(Eyes.FERAL, -11)
						.eyeColor("glacial blue", +2)
						.earType(Ears.WOLF, +1)
						.armType(Arms.WOLF, +1)
						.legType(LowerBody.WOLF, +1)
						.tailType(Tail.WOLF, +1)
						.skinCoatType(Skin.FUR, +2)
						.skinCoatColor("glacial white", +1)
						.hairColor("glacial white", +1)
						.wingType(Wings.NONE, +1)
						.rearType(RearBody.FENRIR_ICE_SPIKES, +6)
						.perk(PerkLib.FreezingBreath, +3)
						.hasCockOfType(CockTypesEnum.WOLF, +1)
					.end()
					.withTier(8, "wolf-boy", "wolf-girl")
						.tauricName("wolf-taur")
						.buffs({
							"str.mult": +0.50,
							"tou.mult": +0.30,
							"spe.mult": +0.50,
							"int.mult": -0.10
						})
					.end()
					.withTier(10, "winter wolf")
						.tauricName("winter wolf-taur")
						.requireSkinCoatType(Skin.FUR)
						.requireSkinCoatColor("glacial white")
						.buffs({
							"str.mult": +0.65,
							"tou.mult": +0.40,
							"spe.mult": +0.55,
							"int.mult": -0.10
						})
					.end()
						.withTier(21, "Fenrir")
						.tauricName("winter wolf-taur")
						.buffs({
							"str.mult": +1.45,
							"tou.mult": +0.70,
							"spe.mult": +1.00,
							"int.mult": -0.10
						})
					.end()
					.build();
    public static const WEREWOLF:Race = new Race("Werewolf",14, "werewolfScore", 12);
    public static const FOX:Race = new Race("Fox",15,"foxScore", 7);
    public static const FERRET:Race = new Race("Ferret",16,"ferretScore", 4);
    public static const KITSUNE:Race = buildRace(17, "kitsune")
			.withScores()
				.eyeType(Eyes.FOX, +1)
				.earType(Ears.FOX, +1)
				.earType(NOT(Ears.FOX), -1)
				.tailTypeAndCount(Tail.FOX, 1, -7)
				.tailType(NOT(Tail.FOX), -7)
				.customScoreRequirement("tail", "2+ fox tails",
						function (body:BodyData):Boolean {
							return body.tailType == Tail.FOX && body.tailCount >= 2;
						},
						function (body:BodyData):int {
							return body.tailCount;
						}
				)
				.customRequirement("skin","fur or magical tatoo",
						function(body:BodyData):Boolean {
							return body.skinCoatType == Skin.FUR
									|| body.skinBasePattern == Skin.PATTERN_MAGICAL_TATTOO
						}, +1)
				.armType(ANY(Arms.HUMAN,Arms.KITSUNE,Arms.FOX), +1)
				.legType(ANY(LowerBody.FOX,LowerBody.HUMAN), +1)
				.legType(NONE(LowerBody.FOX,LowerBody.HUMAN), -1)
				.faceType(ANY(Face.ANIMAL_TOOTHS,Face.HUMAN,Face.FOX), +1)
				.faceType(NONE(Face.ANIMAL_TOOTHS,Face.HUMAN,Face.FOX), -1)
			.end()
			.withScoresAfter(5)
				.customRequirement("skin coat", "skin coat other than fur",
						function (body:BodyData):Boolean {
							return body.hasCoat && body.skinCoatType != Skin.FUR;
						}, -2
				)
				.skinBaseType(Skin.PLAIN, +1)
				.skinBaseType(NOT(Skin.PLAIN), -3)
				.hairColor(ANY(KitsuneScene.basicKitsuneHair,KitsuneScene.elderKitsuneColors), +1)
				.customRequirement("vagina","Vag of Holding",
						function(body:BodyData):Boolean {
							return body.player.vaginalCapacity() >= 8000;
						},
						+1)
				.perk(PerkLib.StarSphereMastery, +1)
				.anyPerk([PerkLib.EnlightenedKitsune,PerkLib.CorruptedKitsune],+1)
				.perk(PerkLib.NinetailsKitsuneOfBalance, +1)
				.perk(MutationsLib.KitsuneThyroidGland, +1)
				.perk(MutationsLib.KitsuneThyroidGlandPrimitive, +1)
				.perk(MutationsLib.KitsuneThyroidGlandEvolved, +1)
				.perk(MutationsLib.KitsuneParathyroidGlands, +1)
				.perk(MutationsLib.KitsuneParathyroidGlandsEvolved, +1)
				.perk(MutationsLib.KitsuneParathyroidGlandsFinalForm, +1)
				.customRequirement("", "Chimerical Body Semi-Improved Stage + Kitsune Mutation I",
						function (body:BodyData):Boolean {
							return (body.player.hasPerk(MutationsLib.KitsuneThyroidGland)
									|| body.player.hasPerk(MutationsLib.KitsuneParathyroidGlands)
									) && body.player.hasPerk(PerkLib.ChimericalBodySemiImprovedStage)
						},
						+1
				)
				.customRequirement("", "Chimerical Body Semi-Superior Stage + Kitsune Mutation II",
						function (body:BodyData):Boolean {
							return (body.player.hasPerk(MutationsLib.KitsuneThyroidGlandPrimitive)
									|| body.player.hasPerk(MutationsLib.KitsuneParathyroidGlandsEvolved)
									) && body.player.hasPerk(PerkLib.ChimericalBodySemiSuperiorStage)
						},
						+1
				)
				.customRequirement("", "Chimerical Body Semi-Epic Stage + Kitsune Mutation III",
						function (body:BodyData):Boolean {
							return (body.player.hasPerk(MutationsLib.KitsuneThyroidGlandEvolved)
									|| body.player.hasPerk(MutationsLib.KitsuneParathyroidGlandsFinalForm)
									) && body.player.hasPerk(PerkLib.ChimericalBodySemiEpicStage)
						},
						+1
				)
			.end()
			.withTier(9, "kitsune")
				.tauricName("kitsune-taur")
				.require("2+ fox tails", function(body:BodyData):Boolean {
					return body.tailType == Tail.FOX && body.tailCount >= 2
				})
				.buffs({
					"str.mult": -0.35,
					"spe.mult": +0.25,
					"int.mult": +0.60,
					"wis.mult": +0.75,
					"lib.mult": +0.30,
					"sens": +20,
					"maxsf_mult": +0.20,
					"maxfatigue_base": +100
				})
			.end()
			.withTier(16, "nine tailed kitsune")
				.tauricName("nine tailed kitsune-taur")
				.requirePreviousTier()
				.requireTailCount(9)
				.buffs({
					"str.mult": -0.40,
					"spe.mult": +0.30,
					"int.mult": +1.10,
					"wis.mult": +1.25,
					"lib.mult": +0.45,
					"sens": +30,
					"maxsf_mult": +0.40,
					"maxfatigue_base": +300
				})
			.end()
			.withTier(21, "nine tailed kitsune of balance")
				.tauricName("nine tailed kitsune-taur of balance")
				.requirePreviousTier()
				.requirePerk(PerkLib.NinetailsKitsuneOfBalance)
				.buffs({
					"str.mult": -0.45,
					"spe.mult": +0.40,
					"int.mult": +1.25,
					"wis.mult": +1.60,
					"lib.mult": +0.80,
					"sens": +45,
					"maxsf_mult": +0.65,
					"maxfatigue_base": +500
				})
			.end()
			.withTier(26, "Inari")
				.tauricName("Inari-taur")
				.requirePreviousTier()
				.buffs({
					"str.mult": -0.50,
					"spe.mult": +0.50,
					"int.mult": +1.40,
					"wis.mult": +2.00,
					"lib.mult": +0.60,
					"sens": +60,
					"maxsf_mult": +1.00,
					"maxfatigue_base": +1000
				})
			.end()
			.withBloodline([PerkLib.KitsunesDescendant,PerkLib.BloodlineKitsune])
			.build()
    public static const HORSE:Race = new Race("Horse",18, "horseScore", 7);
    public static const UNICORN:Race = new Race("Unicorn",19,"unicornScore", 8);
    public static const CENTAUR:Race = new Race("Centaur",20, "centaurScore", 8);
    public static const MINOTAUR:Race = new Race("Minotaur",21,"minotaurScore", 10);
    public static const COW:Race = new Race("Cow",22,"cowScore", 10);
    public static const SANDTRAP:Race = new Race("SANDTRAP",23,"sandTrapScore", 5);
    public static const BEE:Race = new Race("Bee",24,"beeScore", 17);
    public static const GOBLIN: Race =
			buildRace(25, "goblin")
					.withScores()
						.faceType(ANY(Face.HUMAN,Face.ANIMAL_TOOTHS), +1)
						.earType(Ears.ELFIN, +1)
						.earType(NOT(Ears.ELFIN), -100)
						.height(LESS_THAN(48), +1)
						.perk(PerkLib.GoblinoidBlood, +1)
						.perk(PerkLib.BouncyBody, +1)
						.perk(MutationsLib.NaturalPunchingBag, +1)
						.perk(MutationsLib.NaturalPunchingBagPrimitive, +1)
						.perk(MutationsLib.NaturalPunchingBagEvolved, +1)
						.skinPlainOnly(+1)
						.skinBaseColor(NONE("pale yellow", "grayish-blue", "green", "dark green", "emerald"), -100)
						.allPerks([MutationsLib.NaturalPunchingBag, PerkLib.ChimericalBodySemiImprovedStage], +1)
						.allPerks([MutationsLib.NaturalPunchingBagPrimitive, PerkLib.ChimericalBodySemiSuperiorStage], +1)
						.allPerks([MutationsLib.NaturalPunchingBagEvolved, PerkLib.ChimericalBodySemiEpicStage], +1)
						.hasVagina(+1)
					.end()
					.withConditionedScores(
							function(body:BodyData):Boolean {
								return body.player.hasPlainSkinOnly();
							},
							"plain skin; "
					)
						.skinBaseColor(ANY("pale yellow", "grayish-blue", "green", "dark green", "emerald"), +1)
						.eyeTypeOfColor(Eyes.HUMAN, ANY("red", "yellow", "purple"), +1)
						.hairColor(ANY("red", "purple", "green", "blue", "pink", "orange"), +1)
						.armType(Arms.HUMAN, +1)
						.legType(LowerBody.HUMAN, +1)
						.noAntennae(+1)
					.end()
					.withTier(10, "goblin")
						.buffs({
							"str.mult": -0.50,
							"spe.mult": +0.75,
							"int.mult": +1.00,
							"lib.mult": +0.25
						})
					.end()
					.withBloodline([PerkLib.GoblinsDescendant, PerkLib.BloodlineGoblin])
					.build();
    public static const DEMON:Race = new Race("Demon",26,"demonScore", 11);
    public static const DEVIL:Race = new Race("Devil",27,"devilkinScore", 11);
    public static const SHARK:Race = new Race("Shark",28, "sharkScore", 10);
    public static const ORCA:Race = new Race("Orca",29, "orcaScore", 14);
    public static const OOMUKADE:Race = new Race("Oomukade",30, "oomukadeScore", 15);
    public static const ONI:Race = new Race("Oni",31, "oniScore", 12);
    public static const ELF:Race = new Race("Elf",32, "elfScore", 11);
    public static const ORC:Race = new Race("Orc",33, "orcScore", 11);
    public static const RAIJU:Race = new Race("Raiju",34, "raijuScore", 10);
    public static const THUNDERBIRD:Race = new Race("Thunderbird",35, "thunderbirdScore", 16);
    public static const BUNNY:Race = new Race("Bunny",36, "bunnyScore", 10);
    public static const HARPY:Race = new Race("Harpy",37, "harpyScore", 8);
    public static const SPIDER:Race = new Race("Spider",38, "spiderScore", 7);
    public static const KANGAROO:Race = new Race("Kangaroo",39, "kangaScore", 4);
    public static const MOUSE:Race = new Race("Mouse and hinezumi",40,"mouseScore", 8);
    public static const SCORPION:Race = new Race("Scorpion",41, "scorpionScore", 4);
    public static const MANTIS:Race = new Race("Mantis",42, "mantisScore", 12);
    public static const SALAMANDER:Race = new Race("Salamander",43, "salamanderScore", 7);
    public static const CAVEWYRM:Race = new Race("Cave wyrm",44, "cavewyrmScore", 10);
    public static const NAGA:Race = new Race("Naga",45, "nagaScore", 8);
    public static const GORGON:Race = new Race("Gorgon",46, "gorgonScore", 11);
    public static const VOUIVRE:Race = new Race("Vouivre",47, "vouivreScore", 11);
    public static const COUATL:Race = new Race("Couatl",48, "couatlScore", 11);
    public static const HYDRA:Race = new Race("Hydra",49, "hydraScore", 14);
    public static const FIRESNAILS:Race = new Race("Fire snails",50, "firesnailScore", 15);
    public static const PHOENIX:Race = new Race("Phoenix",51, "phoenixScore", 10);
    public static const SCYLLA:Race = new Race("Scylla",52, "scyllaScore", 7);
    public static const PLANT:Race = new Race("Plant",53, "plantScore", 4);
    public static const ALRAUNE:Race = new Race("Alraune",54, "alrauneScore", 13);
    public static const YGGDRASIL:Race = new Race("Yggdrassil",55, "yggdrasilScore", 10);
    public static const PIG:Race = new Race("Pig",56, "pigScore", 10);
    public static const SATYR:Race = new Race("Satyr",57, "satyrScore", 4);
    public static const RHINO:Race = new Race("Rhino",58, "rhinoScore", 4);
    public static const ECHIDNA:Race = new Race("Echnida",59, "echidnaScore", 4);
    public static const DEER:Race = new Race("Deer",60, "deerScore", 4);
    public static const MANTICORE:Race = new Race("Manticore",61, "manticoreScore", 15);
    public static const REDPANDA:Race = new Race("Red panda",62, "redpandaScore", 8);
    public static const BEARANDPANDA:Race = new Race("Bear and Panda",63,"bearpandaScore", 10);
    public static const SIREN:Race = new Race("Siren",64, "sirenScore", 10);
    public static const YETI:Race = new Race("Yeti",65, "yetiScore", 14);
    public static const YUKIONNA:Race = new Race("Yuki Onna",66, "yukiOnnaScore", 14);
    public static const BAT:Race = new Race("Bat",67, "batScore", 10);
    public static const VAMPIRE:Race = new Race("Vampire",68, "vampireScore", 10);
    public static const JABBERWOCKY:Race = new Race("Jabberwocky",69, "jabberwockyScore", 10);
    public static const AVIAN:Race = new Race("Avian",70, "avianScore", 9);
    public static const GARGOYLE:Race = new Race("Gargoyle",71, "gargoyleScore", 22);
    public static const SLIME:Race = new Race("Slime",72, "gooScore", 11);
    public static const MAGMASLIME:Race = new Race("Magma slime",73, "magmagooScore", 13);
    public static const DARKSLIME:Race = new Race("Dark slime",74, "darkgooScore", 13);
    public static const JIANGSHI:Race = new Race("Jiangshi",75,"jiangshiScore", 20);
    public static const POLTERGEIST:Race = new Race("Poltergeist",76, "poltergeistScore", 6);
    public static const BANSHEE:Race = new Race("Banshee",77, "bansheeScore", 4);
    public static const MELKIE:Race = new Race("Melkie",78, "melkieScore", 18);
    public static const EASTERBUNNY:Race = new Race("Easter Bunny",79, "easterbunnyScore", 12);
    public static const CENTIPEDE:Race = new Race("Centipede",80, "centipedeScore", 8);
    public static const FROSTWYRM:Race = new Race("Frost Wyrm",81, "frostWyrmScore", 18);
    public static const CANCER:Race = new Race("Cancer",82, "cancerScore", 13);
    public static const USHIONNA:Race = new Race("Ushi-Onna",83, "ushionnaScore", 11);
    public static const FAIRY:Race = new Race("Fairy",84,"fairyScore", 23);
    public static const GREMLIN:Race = new Race("Gremlin",85,"gremlinScore", 15);
    public static const KAMAITACHI:Race = new Race("Kamaitachi",86, "kamaitachiScore", 14);
    public static const GAZER:Race = new Race("Gazer",87, "gazerScore", 14);
    public static const RATATOSKR:Race = new Race("Ratatoskr",88, "ratatoskrScore", 12);
    public static const WENDIGO:Race = new Race("Wendigo",89, "wendigoScore", 10);
    public static const TROLL:Race        = new Race("Troll",90, "trollScore", 10);
    public static const ATLACH_NACHA:Race = new Race("Atlach Nacha", 91, "atlachNachaScore", 10);
    public static const WOODELF:Race      = new Race("Wood Elf",92, "woodElfScore", 22);
    public static const SEA_DRAGON:Race = new Race("Sea Dragon",93, "leviathanScore", 20);
    public static const FMINDBREAKER:Race = new Race("Female Mind Breaker",94, "femaleMindbreakerScore", 20);
    public static const MMINDBREAKER:Race = new Race("Male Mind Breaker",95, "maleMindbreakerScore", 20);
    public static const ELEMENTALFUSION:Race = new Race("Elemental Fusion",96, "fusedElementalScore", 5);
    public static const GRYPHON:Race = new Race("Gryphon",97, "gryphonScore", 4);
    public static const PEACOCK:Race = new Race("Peacock",98, "peacockScore", 4);
    public static const ANGEL:Race = new Race("Angel",99, "angelScore", 11);
    public static const APOPHIS:Race = new Race("Apophis",100, "apophisScore", 23);
    public static const CYCLOP:Race = new Race("Cyclop",101, "cyclopScore", 12);
    public static const ALICORN:Race = new Race("Alicorn",102, "alicornScore", 8);

	public static const AllRacesByName:/*Race*/Array =
								ALL_RACES.slice()
										.filter(function(e:Race,...rest:Array):Boolean {
											return !!e
										})
										.sortOn("name");
	
    public var name:String;
    public var id:int;
    private var playerFunctionName:String;
	public var requirements:/*RacialRequirement*/Array = [];
	public var tiers:/*RaceTier*/Array = [];
	private var _minScore:int;

    /**
     * @param _name Display name of the race
     * @param _id Unique number id
     * @param _playerFunctionName (old system) Function in Player class that returns score for this race
	 * @param _minScore (old system) Min score for player to be qualified as this race
     */
    function Race(_name:String, _id:int, _playerFunctionName: String, _minScore:int) {
        this.name = _name;
        this.id = _id;
        this.playerFunctionName = _playerFunctionName;
        ALL_RACES[_id] = this;
		this._minScore = _minScore;
    }
	
	public function basicScore(body:BodyData):int {
		if (playerFunctionName) {
			return body.player[playerFunctionName]();
		} else {
			var score:int = 0;
			try {
				Utils.Begin("Race", "basicScore", name);
				for each(var req:RacialRequirement in requirements) {
					score += req.getScore(body, score);
				}
				if (score < 0) score = 0;
			} finally {
				Utils.End("Race", "basicScore");
			}
			return score;
		}
	}
	
	public function totalScore(body:BodyData):int {
		return finalizeScore(body, basicScore(body));
	}
	
	public function finalizeScore(body:BodyData, score:int):int {
		var player:Player = body.player;
		if (player.hasPerk(PerkLib.RacialParagon) && this != player.racialParagonSelectedRace()) {
			return 0;
		}
		if (player.isGargoyle() && this != Race.GARGOYLE) {
			return 0;
		}
		if (player.hasPerk(PerkLib.ElementalBody) && this != Race.ELEMENTALFUSION) {
			return 0;
		}
		if (this != Race.HUMAN && this != Race.ELEMENTALFUSION && this != Race.GARGOYLE) {
			if (player.hasPerk(PerkLib.AscensionCruelChimerasThesis) && score >= minScore-2)
				score += 1;
			if (player.hasPerk(PerkLib.AscensionHybridTheory) && score >= minScore-1)
				score += 1;
			if (player.hasPerk(PerkLib.ChimericalBodyUltimateStage))
				score += 50;
		}
		return score;
	}
	
	public function getTier(body:BodyData, score:int=-1):RaceTier {
		if (score < 0) score = this.totalScore(body);
		var tier:RaceTier = null;
		for each(var i:RaceTier in tiers) {
			if (i.check(body, score)) tier = i;
		}
		return tier;
	}
	public function getTierNumber(body:BodyData, score:int=-1):int {
		var tier:RaceTier = getTier(body,score);
		if (!tier) return 0;
		return tier.tierNumber;
	}
	
	public function nameFor(body:BodyData, score:int=-1):String {
		if (score < 0) score = this.totalScore(body);
		var tier:RaceTier = getTier(body, score);
		if (tier) return tier.nameFor(body);
		if (tiers.length > 0) return tiers[0].nameFor(body);
		return name;
	}
	
	public function get minScore():int {
		if (this.tiers.length == 0) return _minScore;
		return this.tiers[0].minScore;
	}

    }
}
