package classes.Races {
import classes.BodyParts.*;
import classes.CockTypesEnum;
import classes.Race;

public class PeacockRace extends Race{
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

	public function PeacockRace(id:int) {
		super("Peacock", id, []);//RaceBody);
		chimeraTier = 0;
		grandChimeraTier = 0;
	}
	
	public override function setup():void {
		
		addScores()
				.hairType(Hair.FEATHER, +1)
				.faceType(Face.AVIAN, +1)
				.earType(Ears.AVIAN, +1)
				.tailType(Tail.AVIAN, +1)
				.armType(Arms.AVIAN, +1)
				.legType(LowerBody.AVIAN, +1)
				.wingType(Wings.FEATHERED_AVIAN, +2)
				.skinCoatType(Skin.FEATHER, +1)
				.hasCockOfType(CockTypesEnum.AVIAN, +1)
		
		buildTier(9, "peacock")
				.end();
	}
}
}
