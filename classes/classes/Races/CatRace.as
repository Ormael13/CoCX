package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.CockTypesEnum;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;
import classes.Transformations.TransformationGroupAny;

public class CatRace extends Race {
	public static const catFurColors:/*String*/Array = ["brown", "chocolate", "auburn", "caramel", "orange", "sandy brown", "golden", "black", "midnight black", "dark gray", "gray", "light gray", "silver", "white", "orange and white", "brown and white", "black and white", "gray and white"];
    public static const RaceBody:/*String*/Array = [
        /*Antenna*/		"Human",
        /*Arms*/		"Human",
        /*Balls*/		"Human",
        /*Breasts*/		"Human",
        /*Nips*/		"Human",
        /*Ears*/		"Human",
        /*Eyes*/		"Human",
        /*Face*/		"Human",
        /*Gills*/		"Human",
        /*Hair*/		"Human",
        /*Horns*/		"Human",
        /*LowerBody*/	"Human",
        /*RearBody*/	"Human",
        /*Skin*/		"Human",
        /*Ovipositor*/	"Human",
        /*Oviposition*/	"Human",
        /*GlowingAss*/	"Human",
        /*Tail*/		"Human",
        /*Tongue*/		"Human",
        /*Wings*/		"Human",
        /*Penis*/		"Human",
        /*Vagina*/		"Human",
        /*Perks*/		"Human"];


    public function CatRace(id:int) {
		super("Cat", id, []);
	}
	
	public const TfList:/*PossibleEffect*/Array = [
		new TransformationGroupAny("FaceHumanOrCat", [
			game.transformations.FaceCat,
			game.transformations.FaceCatCanines
		]),
		game.transformations.EyesCat,
		game.transformations.EarsCat,
		game.transformations.TongueCat,
		game.transformations.TailCat,
		game.transformations.ArmsCat,
		game.transformations.LowerBodyCat(),
		game.transformations.SkinFurGradual(Skin.COVERAGE_HIGH, {colors: catFurColors}),
		game.transformations.HornsNone,
		game.transformations.WingsNone,
		game.transformations.CockChangeType(CockTypesEnum.CAT, false)
	];
	
	public override function setup():void {
		
		addScores()
				.faceType(ANY(Face.CAT,Face.CAT_CANINES), +1)
				.faceType(NONE(Face.CHESHIRE,Face.CHESHIRE_SMILE), 0, -7)
				.eyeType(Eyes.CAT,+1)
				.eyeType(Eyes.FERAL, -11)
				.earType(Ears.CAT,+1)
				.tongueType(Tongue.CAT, +1)
				.tailType(Tail.CAT, +1)
				.armType(Arms.CAT, +1)
				.legType(LowerBody.CAT, +1)
				.skinCoatType(Skin.FUR, +1)
				.hornType(NONE(Horns.DEMON,Horns.DRACONIC_X2,Horns.DRACONIC_X4_12_INCH_LONG), 0, -2)
				.wingType(NONE(Wings.BAT_LIKE_TINY,Wings.DRACONIC_SMALL,Wings.BAT_LIKE_LARGE,Wings.DRACONIC_LARGE,Wings.BAT_LIKE_LARGE_2,Wings.DRACONIC_HUGE),0,-2)
				.hasCockOfType(CockTypesEnum.CAT, +1)
				.breastRowCount(2, +1)
				.breastRowCount(3, +2)
				.breastRowCount(LESS_THAN(4), 0, -1)
				.customRequirement("","not magical feline race",
						function (body:BodyData):Boolean {
							return !(isSphinxLike(body)
									|| body.tailType == Tail.MANTICORE_PUSSYTAIL
									|| isNekomataLike(body)
									|| body.rearType == RearBody.LION_MANE
									|| isCheshireLike(body)
									|| isHellcatLike(body)
									|| isDisplacerLike(body));
						},0,-1000
						)
				.hasPerk(PerkLib.Flexibility, +1);
		
		addMutation(IMutationsLib.CatLikeNimblenessIM);
		
		buildTier(8, "cat")
				.customNamingFunction(function(body:BodyData):String {
					if (body.isTaur && body.legType == LowerBody.CAT) return "cat-taur";
					if (body.faceType == Face.HUMAN) return "cat-morph";
					return "cat-"+body.mf("boy","girl")
				})
				.buffs({
					"spe.mult": +0.60,
					"lib.mult": +0.60
				})
				.end();
	}
	
	public static function isNekomataLike(body:BodyData):Boolean {
		return body.tailType == Tail.NEKOMATA_FORKED_1_3
				|| body.tailType == Tail.NEKOMATA_FORKED_2_3
				|| (body.tailType == Tail.CAT && body.tailCount > 1);
	}
	public static function isHellcatLike(body:BodyData):Boolean {
		return body.eyeType == Eyes.INFERNAL
				|| body.hairType == Hair.BURNING
				|| body.tailType == Tail.BURNING
				|| body.tailType == Tail.TWINKASHA;
	}
	public static function isCheshireLike(body:BodyData):Boolean {
		return (body.hairColors == "lilac and white" && body.furColors == "lilac and white");
	}
	public static function isSphinxLike(body:BodyData):Boolean {
		return body.armType == Arms.SPHINX
				|| body.wingType == Wings.FEATHERED_SPHINX;
	}
	public static function isDisplacerLike(body:BodyData):Boolean {
		return body.eyeType == Eyes.DISPLACER
				|| body.earType == Ears.DISPLACER
				|| body.armType == Arms.DISPLACER
				|| body.rearType == RearBody.DISPLACER_TENTACLES;
	}
}
}
