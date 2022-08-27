package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.PerkLib;
import classes.Race;

public class DragonneRace extends Race{
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

    public function DragonneRace(id:int) {
		super("Dragonne", id, []);//RaceBody);
		chimeraTier = 0;
		grandChimeraTier = 0;
	}
	
	public override function setup():void {
		
		addScores()
				.faceType(Face.CAT, +1)
				.earType(Ears.CAT, +1)
				.tailType(Tail.CAT, +1)
				.tongueType(Tongue.DRACONIC, +1)
				.wingType(Wings.DRACONIC_LARGE, +2)
				.wingType(Wings.DRACONIC_SMALL, +1)
				.legType(LowerBody.CAT, +1);
		addScoresAfter(1)
				.skinCoatType(Skin.SCALES, +1);
		
		buildTier(6, "dragonne")
				.namesMaleFemaleMorphTaur(
						"dragonne-man",
						"dragonne-girl",
						"dragonne",
						"dragonne-taur")
				.end();
	}
}
}
