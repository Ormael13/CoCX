package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.GeneticMemories.RaceMem;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;
import classes.Transformations.GradualTransformation;
import classes.Transformations.TransformationGroupAny;

/**
 * Tier 1: kitsune
 * Tier 2: nine-tailed kitsune
 * Tier 3: nine-tailed kitsune of balance
 * Tier 4: Inari
 */
public class KitsuneRace extends Race {
	
	// weighted with white being rare
	public static const BasicKitsuneHairColors:/*String*/Array = ["white", "black", "black", "black", "red", "red", "red"];
	public static const BasicKitsuneHairColorSet:/*String*/Array = ["white", "black", "red"];
	public static const BasicKitsuneFurColors:/*String*/Array = ["orange and white", "black", "black and white", "red", "red and white", "white"];
	public static const ElderKitsuneColors:/*String*/Array = ["metallic golden", "golden blonde", "metallic silver", "silver blonde", "snow white", "iridescent gray"];
	public static const BasicKitsuneSkinColors:/*String*/Array = ["tan", "olive", "light"];
	public static const ElderKitsuneSkinColors:/*String*/Array = ["dark", "ebony", "ashen", "sable", "milky white"];

	public static const KitsuneHairColors:/*String*/Array = BasicKitsuneHairColorSet.concat(ElderKitsuneColors);
	public static const KitsuneFurColors:/*String*/Array = BasicKitsuneFurColors.concat(ElderKitsuneColors);
    public static const RaceBody:/*String*/Array = [
        /*Antenna*/		"Human",
        /*Arms*/		"Kitsune",
        /*Balls*/		"Human",
        /*Breasts*/		"Human",
        /*Nips*/		"Human",
        /*Ears*/		"Fox",
        /*Eyes*/		"Fox",
        /*Face*/		"Fox",
        /*Gills*/		"None",
        /*Hair*/		"Kitsune",
        /*Horns*/		"Human",
        /*LowerBody*/	"Fox",
        /*RearBody*/	"Human",
        /*Skin*/		"Kitsune",
        /*Ovipositor*/	"Human",
        /*Oviposition*/	"Human",
        /*GlowingAss*/	"Human",
        /*Tail*/		"Kitsune",
        /*Tongue*/		"Human",
        /*Wings*/		"Human",
        /*Penis*/		"Human",
        /*Vagina*/		"Human",
        /*Perks*/		"Kitsune"];
	
	public function get TfList():/*Transformation*/Array {
		return [
			game.transformations.EyesFox,
			game.transformations.EarsFox,
			game.transformations.TailFox(2, 1, false),
			new TransformationGroupAny("SkinOrKitsuneTattoo", [
						new GradualTransformation("SkinPlainKitsuneTattoed", [
							game.transformations.SkinPlain,
							game.transformations.SkinPatternKitsune
						]),
						game.transformations.SkinFur(Skin.COVERAGE_LOW, {colors: KitsuneFurColors})
					]
			),
			game.transformations.ArmsHuman,
			game.transformations.LowerBodyHuman,
			new TransformationGroupAny("FaceHumanFoxOrAnimal", [
				game.transformations.FaceHuman,
				game.transformations.FaceFox,
				game.transformations.FaceAnimalTeeth
			]),
			game.transformations.HairChangeColor(KitsuneHairColors),
		];
	}

	public function KitsuneRace(id:int) {
		super("Kitsune", id, RaceBody);
		mutationThreshold = 6;
    }
	
	public override function setup():void {
		addScores()
				.eyeType(Eyes.FOX, +1)
				.eyeType(NOT(Eyes.FERAL), 0, -11)
				.earType(Ears.FOX, +1, -1)
				.customScoreRequirement("tail", "multiple fox tails, +1 per tail",
						function (body:BodyData):Boolean {
							return body.tailType == Tail.FOX && body.tailCount >= 2;
						},
						function (body:BodyData):int {
							return body.tailCount;
						},
						-7
				)
				.customRequirement("skin", "fur or magical tattoo",
						function (body:BodyData):Boolean {
							return body.skinCoatType == Skin.FUR
									|| body.skinBasePattern == Skin.PATTERN_MAGICAL_TATTOO
						}, +1)
				.armType(ANY(Arms.HUMAN, Arms.KITSUNE, Arms.FOX), +1)
				.legType(ANY(LowerBody.FOX, LowerBody.HUMAN), +1, -1)
				.faceType(ANY(Face.ANIMAL_TOOTHS, Face.HUMAN, Face.FOX), +1, -1)
				.rearType(NOT(RearBody.WOLF_COLLAR), 0, -7);
		addScoresAfter(5)
				.customRequirement("skin coat", "fur or no coat",
						function (body:BodyData):Boolean {
							return !body.hasCoat || body.skinCoatType == Skin.FUR;
						}, 0, -2
				)
				.skinBaseType(Skin.PLAIN, +1, -3)
				.hairColor1(ANY(KitsuneHairColors), +1)
				.hasPerk(PerkLib.StarSphereMastery, +1)
				.hasAnyPerk([PerkLib.EnlightenedKitsune, PerkLib.CorruptedKitsune], +1)
				.hasPerk(PerkLib.NinetailsKitsuneOfBalance, +1);
		
		addBloodline(PerkLib.KitsunesDescendant, PerkLib.BloodlineKitsune);
		addMutation(IMutationsLib.KitsuneThyroidGlandIM);
		addMutation(IMutationsLib.KitsuneParathyroidGlandsIM);
		
		buildTier(8, "kitsune")
				.namesTauric("kitsune", "kitsune-taur")
				.require("2+ fox tails", function (body:BodyData):Boolean {
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
				.withExtraBonuses(
						"+40% SF Regeneration"
				)
				.end();
		buildTier(15, "nine-tailed kitsune")
				.namesTauric("nine-tailed kitsune", "nine-tailed kitsune-taur")
				.requirePreviousTier()
				.requirePerk(PerkLib.StarSphereMastery)
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
				.withExtraBonuses(
					"+80% SF Regeneration"
				)
				.end();
		buildTier(20, "nine-tailed kitsune of balance")
				.namesTauric("nine-tailed kitsune of balance", "nine-tailed kitsune-taur of balance")
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
				.withExtraBonuses(
					"+130% SF Regeneration"
				)
				.end();
		buildTier(25, "Inari")
				.namesTauric("Inari", "Inari-taur")
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
				.withExtraBonuses(
					"+200% SF Regeneration"
				)
				.end();
		
		debugForms = {
			"kitsune": [
				game.transformations.EyesFox,
				game.transformations.EarsFox,
				game.transformations.TailFox(2),
				game.transformations.SkinFur(Skin.COVERAGE_LOW, {colors:KitsuneFurColors}),
				game.transformations.ArmsHuman,
				game.transformations.LowerBodyHuman,
				game.transformations.FaceHuman,
				game.transformations.HairChangeColor(KitsuneHairColors),
			],
			"ninetails": [
				game.transformations.EyesFox,
				game.transformations.EarsFox,
				game.transformations.TailFox(9),
				game.transformations.SkinFur(Skin.COVERAGE_LOW, {colors:KitsuneFurColors}),
				game.transformations.ArmsHuman,
				game.transformations.LowerBodyHuman,
				game.transformations.FaceHuman,
				game.transformations.HairChangeColor(KitsuneHairColors)
			],
			"9TKoB": [
				game.transformations.EyesFox,
				game.transformations.EarsFox,
				game.transformations.TailFox(9),
				game.transformations.SkinFur(Skin.COVERAGE_LOW, {color:KitsuneFurColors}),
				game.transformations.ArmsHuman,
				game.transformations.LowerBodyHuman,
				game.transformations.FaceHuman,
				game.transformations.HairChangeColor(KitsuneHairColors),
				PerkLib.StarSphereMastery,
				PerkLib.EnlightenedKitsune,
				PerkLib.CorruptedKitsune,
				PerkLib.NinetailsKitsuneOfBalance
			]
		};
	}
}
}
