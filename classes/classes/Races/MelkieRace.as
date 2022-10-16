package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;
public class MelkieRace extends Race {
	public static const MelkieSkinColors:/*String*/Array = ["light", "fair", "pale"];
	public static const MelkieFurColors:/*String*/Array = ["grey", "silver", "white", "glacial white", "light gray"];
	public static const MelkieHairColors:/*String*/Array = ["blonde", "platinum blonde"];
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
	
	public function MelkieRace(id:int) {
		super("Melkie", id, []);//RaceBody);
	}
	
	public override function setup():void {
		
		addScores()
				.skinColor1(ANY(MelkieSkinColors), +1)
				.skinCoatType(Skin.FUR, +1)
				.furColor1(ANY(MelkieFurColors), +1)
				.hairType(Hair.NORMAL, +1)
				.hairColor1(ANY(MelkieHairColors), +1)
				.eyeType(Eyes.HUMAN, +1)
				.eyeColor("blue", +1)
				.faceType(Face.ANIMAL_TOOTHS, +1)
				.earType(Ears.MELKIE, +1)
				.tongueType(Tongue.MELKIE, +1)
				.legType(LowerBody.MELKIE, +3, -1000)
				.armType(Arms.MELKIE, +1)
				.femininity(GREATER_THAN(80), +1)
				.hasVagina(+1)
				.biggestTitSize(GREATER_THAN(3), +1)
				.height(AT_LEAST(73), +1);
		
		addMutation(IMutationsLib.MelkieLungIM);
		addBloodline(PerkLib.MelkiesDescendant, PerkLib.BloodlineMelkie);
		
		buildTier(18, "melkie")
				.buffs({
					"spe.mult": +1.20,
					"int.mult": +1.20,
					"lib.mult": +0.80,
					"sens": +50
				})
				.end();
		
		buildTier(21, "elder melkie")
				.buffs({
					"spe.mult": +1.40,
					"int.mult": +1.40,
					"lib.mult": +1.00,
					"sens": +65
				})
				.end();
	}
}
}
