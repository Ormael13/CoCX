package classes.Races {
import classes.BodyParts.*;
import classes.IMutations.IMutationsLib;
import classes.Race;

public class KamaitachiRace extends Race {
	public static const KamaitachiHairColors:/*String*/Array = ["blonde", "yellow", "caramel", "brown", "emerald"];
	public static const KamaitachiFurColors:/*String*/Array = KamaitachiHairColors;
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
	
	public function KamaitachiRace(id:int) {
		super("Kamaitachi", id, []);//RaceBody);
	}
	
	public override function setup():void {
		
		addScores()
				.earType(Ears.WEASEL, +1)
				.eyeType(Eyes.WEASEL, +1)
				.eyeColor("golden", +1)
				.faceType(Face.WEASEL, +1)
				.armType(Arms.KAMAITACHI, +1)
				.skinCoatType(Skin.FUR, +1)
				.wingType(Wings.WINDY_AURA, +3)
				.legType(LowerBody.WEASEL,1)
				.tailType(Tail.WEASEL, +1)
				.skinBasePattern(Skin.PATTERN_SCAR_WINDSWEPT, +1)
				.hairType(Hair.WINDSWEPT, +1)
				.hairColor1(ANY(KamaitachiHairColors), +1)
				.furColor1(ANY(KamaitachiHairColors), +1);
		
		addMutation(IMutationsLib.HeartOfTheStormIM);
		
		buildTier(14, "kamaitachi")
				.namesTauric("kamaitachi", "kamaitachi-taur")
				.buffs({
					"str.mult": -0.20,
					"spe.mult": +1.40,
					"int.mult": +0.45,
					"wis.mult": +0.70,
					"sens": +25
				})
				.end();
		
		buildTier(18, "greater kamaitachi")
				.namesTauric("greater kamaitachi", "greater kamaitachi-taur")
				.buffs({
					"str.mult": -0.35,
					"spe.mult": +2.00,
					"int.mult": +0.55,
					"wis.mult": +1.00,
					"sens": +50
				})
				.end();
	}
}
}
