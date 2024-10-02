package classes.Races {
import classes.BodyParts.*;
import classes.IMutations.IMutationsLib;
import classes.CockTypesEnum;
import classes.PerkLib;
import classes.Race;

public class AvianRace extends Race{
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


	public function AvianRace(id:int) {
		super("Avian", id, []);//RaceBody);
        //tfRace = RaceMem.appendEnumVal("Apophis", CoC.instance.transformations.FullApophis);
	}
	
	public override function setup():void {
		
		addScores()
				.hairType(Hair.FEATHER, +1)
				.faceType(Face.AVIAN, +1)
				.earType(Ears.AVIAN, +1)
				.eyeType(Eyes.GRYPHON, +1)
				.tailType(Tail.AVIAN, +1)
				.armType(Arms.AVIAN, +1)
				.legType(LowerBody.AVIAN, +1)
				.wingType(Wings.FEATHERED_AVIAN, +2)
				.skinCoatType(Skin.FEATHER, +1)
				.hasCockOfType(CockTypesEnum.AVIAN, +1);
		
		addBloodline(PerkLib.AviansDescendant, PerkLib.BloodlineAvian);
		addMutation(IMutationsLib.HarpyHollowBonesIM);
		
		buildTier(9, "avian-morph")
				.buffs({
					"str.mult": +0.30,
					"spe.mult": +0.75,
					"int.mult": +0.30
				})
				.end()
	}
}
}
