package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;
public class MantisRace extends Race {
	public static const MantisChitinColors:/*String*/Array = ["green", "emerald", "turquoise"];
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
	
	public function MantisRace(id:int) {
		super("Mantis", id, []);//RaceBody);
	}
	
	public override function setup():void {
		addScores()
				.skinCoatType(Skin.CHITIN, +3)
				.chitinColor1(ANY(MantisChitinColors), +1)
				.antennaeType(Antennae.MANTIS, +1)
				.faceType(Face.HUMAN, +1)
				.earType(Ears.INSECT, +1)
				.armType(Arms.MANTIS, +1)
				.legType(LowerBody.MANTIS, +1)
				.tailType(Tail.MANTIS_ABDOMEN, +1)
				.wingType(Wings.MANTIS_SMALL, +1)
				.wingType(Wings.MANTIS_LARGE, +2)
				.wingType(Wings.MANTIS_LARGE_2, +4)
				.hasPerk(PerkLib.MantisOvipositor, +1);
		
		//Thunder Mantis score
		//4 eyes - adj spider 4 eyes desc
		//var. of arms, legs, wings, tail, ears
		
		addBloodline(PerkLib.MantisesDescendant, PerkLib.BloodlineMantis);
		addMutation(IMutationsLib.MantislikeAgilityIM);
		addMutation(IMutationsLib.TrachealSystemIM);
		
		buildTier(12, "mantis-morph")
				.namesTauric("mantis-morph","mantis-taur")
				.buffs({
					"str.mult": -0.40,
					"tou.mult": +0.60,
					"spe.mult": +1.40,
					"int.mult": +0.20
				})
				.end();
	}
}
}
