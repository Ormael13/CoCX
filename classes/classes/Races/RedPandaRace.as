package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.PerkLib;
import classes.Race;

public class RedPandaRace extends Race{
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

	public function RedPandaRace(id:int) {
		super("Red Panda", id, []);//RaceBody);
	}
	
	public override function setup():void {
		
		addScores()
				.faceType(Face.RED_PANDA, +2)
				.earType(Ears.RED_PANDA, +1)
				.tailType(Tail.RED_PANDA, +1)
				.armType(Arms.RED_PANDA, +1)
				.legType(LowerBody.RED_PANDA, +1)
				.skinCoatPattern(Skin.PATTERN_RED_PANDA_UNDERBODY, +1)
				.skinCoatType(Skin.FUR, +1);
		
		buildTier(8, "red panda")
				.namesMaleFemaleMorphTaur("red-panda-boy","red-panda-girl",
						"red-panda-morph","red-panda-taur")
				.buffs({
					"str.mult": +0.15,
					"spe.mult": +0.75,
					"int.mult": +0.30
				})
				.end()
	}
}
}
