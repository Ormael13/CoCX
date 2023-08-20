package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.CoC;
import classes.GeneticMemories.RaceMem;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;

public class WeresharkRace extends Race {
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

	public function WeresharkRace(id:int) {
		super("Wereshark", id, []);//RaceBody);
		//disabled = true;
	}
	
	public override function setup():void {
		
		addScores()
				.eyeType(Eyes.FERAL, +1);
		
		addMutation(IMutationsLib.HengeyokaiBirthrightIM);
		addMutation(IMutationsLib.SharkOlfactorySystemIM);
		
		buildTier(12, "wereshark")
				.buffs({
					"str.mult": +0.90,
					"tou.mult": +0.50,
					"spe.mult": +0.50,
					"int.mult": -0.10
				})
				.end();
		/*
		buildTier(16, "tierName")
				.buffs({
					"str.mult": +0.40,
					"tou.mult": +0.60,
					"wis.mult": +1.40,
					"maxlust_mult": -0.3,
					"maxsf_mult": +1.0,
					"maxwrath_mult": +0.8,
					"maxmana_mult": -0.8
				})
				.end();
		 */
	}
}
}
