package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.CockTypesEnum;
import classes.IMutations.IMutationsLib;
import classes.Race;
import classes.VaginaClass;

public class ApophisRace extends Race {
	public static const ApophisScaleColors:/*String*/Array = ["black", "midnight", "midnight black"];
	public static const ApophisHairColors:/*String*/Array = ["black", "midnight", "midnight black"];
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

	public function ApophisRace(id:int) {
		super("Apophis", id, []);
		disabled = true;
		chimeraTier = 0;
		grandChimeraTier = 0;
        //tfRace = RaceMem.appendEnumVal("Apophis", CoC.instance.transformations.FullApophis);
	}
	
	public override function setup():void {
		
		addScores()
				.isNaga(+3, -1000)
				.armType(Arms.HUMAN, +1)
				.hairColor1(ANY(ApophisHairColors), +1)
				.skinColor1("light purple", +1)
				.skinCoatType(Skin.SCALES, +1)
				.scaleColor1(ANY(ApophisScaleColors), +1)
				.tongueType(Tongue.SNAKE, +1)
				.faceType(Face.SNAKE_FANGS, +1)
				.eyeTypeAndColor(Eyes.SNAKEFIENDISH, "yellow", +2)
				.earType(Ears.SNAKE, +1)
				.rearType(RearBody.COBRA_HOOD, +1)
				.noWings(+4)
				.cockOrVaginaOfType(CockTypesEnum.LIZARD, VaginaClass.NAGA, +1)
				.corruption(AT_LEAST(20), +1)
				.corruption(AT_LEAST(50), +1)
				.corruption(AT_LEAST(100), +2)
				.customRequirement("","not another snake-like race",
						function (body:BodyData):Boolean {
							return !(GorgonRace.isGorgonLike(body)
									|| CouatlRace.isCouatlLike(body)
									|| HydraRace.isHydraLike(body)
									|| VouivreRace.isVouivreLike(body));
						}, 0, -1000);
		
		addMutation(IMutationsLib.VenomGlandsIM);
		
		buildTier(23, "apophis")
				.buffs({
					"str.mult": +0.70,
					"tou.mult": +0.70,
					"spe.mult": +1.00,
					"lib.mult": +1.05
				})
				.end();
		
		buildTier(26, "unhallowed apophis")
				.buffs({
					"str.mult": +0.80,
					"tou.mult": +0.80,
					"spe.mult": +1.00,
					"lib.mult": +1.30
				})
				.end();
	}
}
}
