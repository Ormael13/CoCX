package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.CockTypesEnum;
import classes.GeneticMemories.RaceMem;
import classes.IMutations.IMutationsLib;
import classes.Race;
import classes.Races;
import classes.VaginaClass;

public class CouatlRace extends Race {
    public static const RaceBody:/*String*/Array = [
        /*Antenna*/		"Human",
        /*Arms*/		"Harpy",
        /*Balls*/		"Human",
        /*Breasts*/		"Human",
        /*Nips*/		"Human",
        /*Ears*/		"Snake",
        /*Eyes*/		"Snake",
        /*Face*/		"Snake",
        /*Gills*/		"None",
        /*Hair*/		"Feather",
        /*Horns*/		"Human",
        /*LowerBody*/	"Snake",
        /*RearBody*/	"Human",
        /*Skin*/		"Snake",
        /*Ovipositor*/	"Human",
        /*Oviposition*/	"Human",
        /*GlowingAss*/	"Human",
        /*Tail*/		"Human",
        /*Tongue*/		"Snake",
        /*Wings*/		"Couatl",
        /*Penis*/		"Lizard",
        /*Vagina*/		"Lizard",
        /*Perks*/		"Human"];

    public function CouatlRace(id:int) {
		super("Couatl", id, []);//RaceBody);
	}
	
	public override function setup():void {
		addScores()
				.isNaga(+3, -1000)
				.tongueType(Tongue.SNAKE, +1)
				.faceType(Face.SNAKE_FANGS, +1)
				.armType(Arms.HARPY, +1)
				.skinCoatType(Skin.SCALES, +1)
				.earType(Ears.SNAKE, +1)
				.eyeType(Eyes.SNAKE, +1)
				.hairType(Hair.FEATHER, +1)
				.hairColor1("crimson", +1)
				.scaleColor1("green", +1)
				.scaleColor2("yellow", +1)
				.featherColor1("blue", +1)
				.wingType(Wings.COUATL, +4, -1000)
				.cockOrVaginaOfType(CockTypesEnum.LIZARD, VaginaClass.NAGA, +1)
				.customRequirement("","not another snake-like race",
						function (body:BodyData):Boolean {
							return !(body.player.racialScore(Races.NAGA) > 10
									|| GorgonRace.isGorgonLike(body)
									|| VouivreRace.isVouivreLike(body)
									|| HydraRace.isHydraLike(body)
									|| ApophisRace.isApophisLike(body));
						}, 0, -1000);
		
		addMutation(IMutationsLib.VenomGlandsIM);
		addMutation(IMutationsLib.HeartOfTheStormIM);
		addMutation(IMutationsLib.MightyLowerHalfIM);
		
		buildTier(11, "couatl")
				.buffs({
					"str.mult": +0.30,
					"tou.mult": +0.25,
					"spe.mult": +0.80,
					"int.mult": +0.30
				})
				.end();
		
		buildTier(25, "greater couatl")
				.buffs({
					"str.mult": +0.50,
					"tou.mult": +0.45,
					"spe.mult": +1.50,
					"int.mult": +1.30
				})
				.end();
	}
	
	public static function isCouatlLike(body:BodyData):Boolean {
		return (body.hairType == Hair.FEATHER
				&& body.armType == Arms.HARPY)
				|| body.wingType == Wings.COUATL;
	}
}
}
