package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.CockTypesEnum;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;
import classes.Transformations.TransformationGroupAny;
import classes.VaginaClass;
import classes.internals.Utils;

/**
 * Tier 1: imp
 */
public class ImpRace extends Race {
	public static const ImpSkinColors:/*String*/Array = ["red", "orange","pale purple", "royal purple", "light purple"];
	public static const ImpSkinColorsMale:/*String*/Array = ["red","orange"];
	public static const ImpSkinColorsFemale:/*String*/Array = ["pale purple", "royal purple", "light purple"];
	public static const ImpRareSkinColors:/*String*/Array = ["pale yellow", "grayish-blue", "green", "dark green", "emerald"];
	public static const ImpEyeColors:/*String*/Array = ["red", "green", "purple", "yellow"];
	public static const ImpHairColors:/*String*/Array = ["red", "purple", "dark purple"];
    public static const RaceBody:/*String*/Array = [
        /*Antenna*/		"Human",
        /*Arms*/		"Human",
        /*Balls*/		"Human",
        /*Breasts*/		"Human",
        /*Nips*/		"Human",
        /*Ears*/		"Elfin",
        /*Eyes*/		"Goblin",
        /*Face*/		"Human",
        /*Gills*/		"None",
        /*Hair*/		"Goblin",
        /*Horns*/		"Human",
        /*LowerBody*/	"Human",
        /*RearBody*/	"Human",
        /*Skin*/		"Goblin",
        /*Ovipositor*/	"Human",
        /*Oviposition*/	"Human",
        /*GlowingAss*/	"Human",
        /*Tail*/		"Human",
        /*Tongue*/		"Human",
        /*Wings*/		"Human",
        /*Penis*/		"Human",
        /*Vagina*/		"Human",
        /*Perks*/		"Goblin"];
	
	public function get TfList():/*Transformation*/Array {
		return [
			new TransformationGroupAny("FaceHumanOrAnimal", [
				game.transformations.FaceHuman,
				game.transformations.FaceAnimalTeeth
			]),
			new TransformationGroupAny("EarsElfinOrBig", [
				game.transformations.EarsElfin,
				game.transformations.EarsBig
			]),
			game.transformations.SkinPlain,
			game.transformations.SkinColor(ImpSkinColors),
			game.transformations.EyesHuman,
			game.transformations.EyesChangeColor(ImpEyeColors),
			game.transformations.HairChangeColor(ImpHairColors),
			game.transformations.ArmsHuman,
			game.transformations.LowerBodyHuman,
			game.transformations.WingsDemonicTiny,
			game.transformations.HornsDemonic,
			game.transformations.AntennaeNone
		];
	}

	public function ImpRace(id:int) {
		super("Imp", id, RaceBody);
	}
	
	public override function setup():void {
		addScores()
				.faceType(ANY(Face.HUMAN, Face.ANIMAL_TOOTHS), +1)
				.hornTypeAndCount(Horns.DEMON, AT_MOST(2), +1)
				.hornType(NOT(Horns.GOAT), 0, -10)
				.wingType(Wings.BAT_LIKE_TINY, +4)
				.tailType(Tail.DEMONIC, +1)
				.earType(ANY(Ears.ELFIN, Ears.BIG), +1)
				.tongueType(Tongue.IMPISH, +1)
				.armType(Arms.TINY, +1)
				.armType(NOT(Arms.HUMAN), 0, -10)
				.legType(LowerBody.TINY, +1)
				.legType(NOT(LowerBody.HUMAN), 0, -10)
				.height(AT_MOST(42), +1)
				.skinPlainOnly(+1)
				.customRequirement("", "Male red or Female purple skin",
						function (body:BodyData):Boolean {
							return (body.hasCock && body.hasVagina ? Utils.InCollection(body.skinColor1, ImpSkinColors, ImpRareSkinColors):
									body.hasVagina ? Utils.InCollection(body.skinColor1, ImpSkinColorsFemale, ImpRareSkinColors):
											Utils.InCollection(body.skinColor1, ImpSkinColorsMale, ImpRareSkinColors))
						}, +1, -1000)
				.plainSkinOfAdj(NOT("slippery"), +1)
				.eyeTypeAndColor(Eyes.HUMAN, ANY(ImpEyeColors), +1)
				.hairColor1(ANY(ImpHairColors), +1)
				.cockOrVaginaOfType(CockTypesEnum.DEMON, VaginaClass.DEMONIC, +1)
				.noAntennae(+1)
				.noRearBody(+1);
		addConditionedScores(function (body:BodyData):Boolean {
					return body.player.cor >= 50;
				}, "cor 50+;", 5);
		addScoresAfter(18)
				.hornType(Horns.ARCH_IMP, +2)
				.skinBasePattern(Skin.PATTERN_ARCH_IMP_RUNIC_TATTOO, +1)
				.hasPerk(PerkLib.Soulless, +4);

		addMutation(IMutationsLib.BlackHeartIM);
		addMutation(IMutationsLib.FiendishMetabolismIM);
		addMutation(IMutationsLib.FiendishBallsIM);

		buildTier(9, "imp")
				.buffs({
					"str.mult": -0.30,
					"spe.mult": +0.25,
					"int.mult": +0.60,
					"lib.mult": +0.55
				})
				.end();

		buildTier(18, "imp lord")
				.buffs({
					"str.mult": -0.50,
					"spe.mult": +0.45,
					"int.mult": +1.15,
					"lib.mult": +1.10
				})
				.end();

		buildTier(25, "lesser arch imp")
				.requirePerk(PerkLib.ImpNobility)
				.buffs({
					"str.mult": -0.80,
					"spe.mult": +2.00,
					"int.mult": +5.00,
					"lib.mult": +4.80
				})
				.end();

		buildTier(28, "arch imp")
				.requirePerk(PerkLib.ImpNobility)
				.buffs({
					"str.mult": -0.80,
					"spe.mult": +2.25,
					"int.mult": +5.50,
					"lib.mult": +5.40
				})
				.end();
	}
}
}
