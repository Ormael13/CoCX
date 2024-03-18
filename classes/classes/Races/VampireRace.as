package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;

/**
 * Tier 1: vampire
 * Tier 2: pureblood vampire
 */
public class VampireRace extends Race {
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

	public function VampireRace(id:int) {
		super("Vampire", id, []);//RaceBody);
	}
	
	public override function setup():void {
		
		addScores()
                .earType(Ears.VAMPIRE, +1, -1000)
				.wingType(Wings.VAMPIRE, +4)
				.faceType(Face.VAMPIRE, +2)
				.eyeType(Eyes.VAMPIRE, +1)
				.armType(Arms.HUMAN, +1)
				.legType(LowerBody.HUMAN, +1)
				.eyeColor("blood-red", +1)
				.skinColor1("pale", +1)
				.noTail(+1)
				.noHorns(+1)
				.noAntennae(+1);
		
		addBloodline(PerkLib.VampiresDescendant,PerkLib.BloodlineVampire);
		addMutation(IMutationsLib.VampiricBloodstreamIM);
		addMutation(IMutationsLib.HollowFangsIM);
		
		buildTier(10, "vampire")
				.buffs({
					"str.mult": +0.35,
					"spe.mult": +0.35,
					"int.mult": +0.35,
					"lib.mult": +0.45
				})
				.end();
		
		buildTier(20, "pureblood vampire")
				.buffs({
					"str.mult": +0.70,
					"spe.mult": +0.70,
					"int.mult": +0.70,
					"lib.mult": +0.90
				})
				.end();
	}
}
}
