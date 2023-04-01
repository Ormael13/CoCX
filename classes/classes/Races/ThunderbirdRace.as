package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;
public class ThunderbirdRace extends Race {
	public static const ThunderbirdHairColors:/*String*/Array = ["purple", "light blue", "yellow", "white", "emerald", "turquoise"];
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
	
	public function ThunderbirdRace(id:int) {
		super("Thunderbird", id, []);//RaceBody);
	}
	
	public override function setup():void {
		addScores()
				.earType(Ears.ELFIN, +1)
				.eyeType(Eyes.RAIJU, +1)
				.faceType(ANY(Face.HUMAN, Face.WEASEL), +1)
				.armType(Arms.HARPY, +1)
				.wingType(Wings.FEATHERED_LARGE, +4)
				.legType(LowerBody.HARPY, +1)
				.tailType(Tail.THUNDERBIRD, +1, -1000)
				.tailType(NOT(Tail.KIRIN), 0, -1000)
				.tailType(NOT(Tail.RAIJU), 0, -1000)
				.rearType(RearBody.RAIJU_MANE, +1)
				.skinBasePattern(Skin.PATTERN_LIGHTNING_SHAPED_TATTOO, +1)
				.hairType(Hair.STORM, +1, -1000)
				.hairColor1(ANY(ThunderbirdHairColors), +1)
				.hasPerk(PerkLib.HarpyWomb, +2);
		
		addMutation(IMutationsLib.HeartOfTheStormIM);
		addMutation(IMutationsLib.HarpyHollowBonesIM);
		
		buildTier(16, "thunderbird")
				.requireWingType(Wings.FEATHERED_LARGE)
				.buffs({
					"tou.mult": -0.20,
					"spe.mult": +1.20,
					"lib.mult": +1.40
				})
				.end();
		
		buildTier(21, "greater thunderbird")
				.requirePreviousTier()
				.buffs({
					"tou.mult": -0.25,
					"spe.mult": +1.55,
					"lib.mult": +1.85
				})
				.end();
	}
}
}
