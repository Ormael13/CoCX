package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.CockTypesEnum;
import classes.GeneticMemories.RaceMem;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;
import classes.StatusEffects;
import classes.VaginaClass;

public class NagaRace extends Race {
	public static const SnakeScaleColors:/*String*/Array = ["black", "midnight", "midnight black"];
    public static const RaceBody:/*String*/Array = [
        /*Antenna*/		"Human",
        /*Arms*/		"Human",
        /*Balls*/		"Human",
        /*Breasts*/		"Human",
        /*Nips*/		"Human",
        /*Ears*/		"Snake",
        /*Eyes*/		"Snake",
        /*Face*/		"Snake",
        /*Gills*/		"None",
        /*Hair*/		"Human",
        /*Horns*/		"Human",
        /*LowerBody*/	"Snake",
        /*RearBody*/	"Human",
        /*Skin*/		"Snake",
        /*Ovipositor*/	"Human",
        /*Oviposition*/	"Human",
        /*GlowingAss*/	"Human",
        /*Tail*/		"Human",
        /*Tongue*/		"Snake",
        /*Wings*/		"Human",
        /*Penis*/		"Lizard",
        /*Vagina*/		"Lizard",
        /*Perks*/		"Human"];

	public function NagaRace(id:int) {
		super("Naga", id, RaceBody);
	}
	
	public override function setup():void {
		addScores()
				.isNaga(+3, -1000)
				.tongueType(Tongue.SNAKE, +1)
				.faceType(Face.SNAKE_FANGS, +1)
				.armType(Arms.HUMAN, +1)
				.skinCoatType(Skin.SCALES, +1)
				.earType(Ears.SNAKE, +1)
				.eyeType(Eyes.SNAKE, +1)
				.cockOrVaginaOfType(CockTypesEnum.LIZARD, VaginaClass.NAGA, +1)
				.customRequirement("","not another snake-like race",
						function (body:BodyData):Boolean {
							return !(GorgonRace.isGorgonLike(body)
									|| CouatlRace.isCouatlLike(body)
									|| VouivreRace.isVouivreLike(body)
									|| HydraRace.isHydraLike(body));
						}, 0, -1000);
		
		addMutation(IMutationsLib.VenomGlandsIM);
		addMutation(IMutationsLib.MightyLowerHalfIM);
		
		buildTier(8, "naga")
				.buffs({
					"str.mult": +0.40,
					"tou.mult": +0.20,
					"spe.mult": +0.60
				})
				.end();
	}
}
}
