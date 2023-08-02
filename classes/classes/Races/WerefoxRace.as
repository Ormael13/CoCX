package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.CoC;
import classes.GeneticMemories.RaceMem;
import classes.PerkLib;
import classes.Race;

public class WerefoxRace extends Race {
    public static const RaceBody:/*String*/Array = [
        /*Antenna*/		"Human",
        /*Arms*/		"Human",
        /*Balls*/		"Human",
        /*Breasts*/		"Human",
        /*Nips*/		"Human",
        /*Ears*/		"Human",
        /*Eyes*/		"Feral",
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
        /*Tail*/		"Fox",
        /*Tongue*/		"Human",
        /*Wings*/		"Human",
        /*Penis*/		"Human",
        /*Vagina*/		"Human",
        /*Perks*/		"Human"];

	public function WerefoxRace(id:int) {
		super("Werefox", id, []);//RaceBody);
	}
	
	public override function setup():void {
		
		addScores()
				//
				.eyeType(Eyes.FERAL, +1)
				.eyeType(NOT(Eyes.FOX), 0,-7)
				//.earType(Ears., +1)
				.armType(Arms.FOX, +1)
				.legType(LowerBody.FOX, +1)
				.hasPerk(PerkLib.Vulpesthropy, +1);
		
		buildTier(11, "werefox")
				.buffs({
					"str.mult": +0.30,
					"tou.mult": +0.35,
					"wis.mult": +1.00,
					"maxlust_mult": -0.15,
					"maxsf_mult": +1,
					"maxwrath_mult": +0.6,
					"maxmana_mult": -0.8
				})
				.end();
		/*
		buildTier(16, "tierName")
				.buffs({
					"str.mult": +0.40,
					"tou.mult": +0.60,
					"wis.mult": +1.40,
					"maxlust_mult": -0.3,
					"maxsf_mult": +1,
					"maxwrath_mult": +0.8,
					"maxmana_mult": -0.8
				})
				.end();
		 */
	}
}
}
