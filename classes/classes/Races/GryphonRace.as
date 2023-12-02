package classes.Races {

import classes.BodyParts.*;
import classes.IMutations.IMutationsLib;
import classes.CockTypesEnum;
import classes.PerkLib;
import classes.Race;

public class GryphonRace extends Race{
    public static const RaceBody:/*String*/Array = [
        /*Antenna*/		"Human",
        /*Arms*/		"Human",
        /*Balls*/		"Human",
        /*Breasts*/		"Human",
        /*Nips*/		"Human",
        /*Ears*/		"Snake",
        /*Eyes*/		"Gorgon",
        /*Face*/		"Snake",
        /*Gills*/		"None",
        /*Hair*/		"Gorgon",
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

	public function GryphonRace(id:int) {
		super("Gryphon", id, []);//RaceBody);
		chimeraTier = 0;
		grandChimeraTier = 0;
	}
	
	public override function setup():void {
		
		addScores()
				.hairType(Hair.FEATHER, +1)
				.faceType(Face.AVIAN, +1)
				.earType(Ears.GRYPHON, +1)
				.eyeType(Eyes.GRYPHON, +1)
				.rearType(RearBody.LION_MANE, +1)
				.tailType(Tail.GRIFFIN, +1)
				.tailType(NOT(Tail.AVIAN), 0, -5)
				.armType(Arms.GRYPHON, +1)
				.armType(NOT(Arms.AVIAN), 0, -5)
				.legType(LowerBody.GRYPHON, +1)
				.legType(NOT(LowerBody.AVIAN), 0, -5)
				.wingType(Wings.FEATHERED_AVIAN, +2)
				.skinCoatType(Skin.FEATHER, +1)
				.hasCockOfType(CockTypesEnum.GRYPHON, +1);
		
		addMutation(IMutationsLib.HarpyHollowBonesIM);
		
		buildTier(9,"gryphon")
				.buffs({
					"str.mult": +0.40,
					"tou.mult": +0.30,
					"spe.mult": +0.50,
					"int.mult": +0.15
				})
				.end();
	}
}
}
