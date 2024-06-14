package classes.Races {
import classes.BodyParts.*;
import classes.IMutations.IMutationsLib;
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
		super("Peafowl", id, []);//RaceBody);
		chimeraTier = 0;
		grandChimeraTier = 0;
	}
	
	public override function setup():void {
		
		addScores()
				.hairType(Hair.PEAFOWL, +1)
				.hairType(NOT(Hair.FEATHER), 0, -5)
				.faceType(Face.AVIAN, +1)
				.earType(Ears.AVIAN, +1)
				.eyeType(Eyes.GRYPHON, +1)
				.tailType(Tail.AVIAN, +1)//longer very colorful looking tail using feather color 1 & 2
				//.tailType(NOT(Tail.AVIAN), 0, -5)
				.armType(Arms.AVIAN, +1)
				.legType(LowerBody.AVIAN, +1)
				.wingType(Wings.FEATHERED_AVIAN, +2)//bit smaller wings but still capabgle of flight with more colorfull look - using feather color 1 & 2 probably
				//.tailType(NOT(Tail.FEATHERED_AVIAN), 0, -6)
				.skinCoatType(Skin.FEATHER, +1)
				.hasCockOfType(CockTypesEnum.AVIAN, +1);
		
		addMutation(IMutationsLib.HarpyHollowBonesIM);
		
		buildTier(9, "peafowl-morph")
				.buffs({
					"str.mult": -0.10,
					"spe.mult": +0.60,
					"wis.mult": +0.50,
					"lib.mult": +0.35
				})
				.end();
	}
}
}
