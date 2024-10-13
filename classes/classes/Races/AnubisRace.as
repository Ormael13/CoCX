package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.CockTypesEnum;
import classes.IMutations.IMutationsLib;
import classes.CoC;
import classes.GeneticMemories.RaceMem;
import classes.PerkLib;
import classes.Race;
import classes.VaginaClass;

//import classes.VaginaClass;

public class AnubisRace extends Race {
	public static const AnubisEyeColors:Array = ["red", "green"];
	public static const AnubisHairColors:Array = ["brown", "black", "bluish black"];
	public static const AnubisFurColors:Array = ["brown", "black", "bluish black"];
	public static const AnubisSkinColors:Array = ["dark", "tan", "olive"];
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

	public function AnubisRace(id:int) {
		super("Anubis", id, []);//RaceBody);
	}
	
	public override function setup():void {
		
		addScores()
				.earType(Ears.JACKAL, +1)
				.skinPlainOnly(+1)
				.eyeType(Eyes.HUMAN, +1)
				.eyeColor(ANY(AnubisEyeColors), +1)
				.faceType(ANY(Face.DOG,Face.ANIMAL_TOOTHS), +1)
				.tongueType(Tongue.DOG, +1)
				.armType(Arms.CANINE, +1)
				.legType(LowerBody.DOG, +1)
				.tailType(Tail.DOG, +1)
				.wingType(Wings.NONE, +4)
				.skinBasePattern(Skin.PATTERN_GLYPH_TATTOO, +1)
				.furColor01(ANY(AnubisFurColors), +1)
				.hairColor1(ANY(AnubisHairColors), +1)
				.cockOrVaginaOfType(CockTypesEnum.DOG,VaginaClass.HUMAN, +1)
				.skinColor1(ANY(AnubisSkinColors), +1)
				.corruption(AT_LEAST(50), +1)
				.hasPerk(PerkLib.MummyLord, +1);
		
		addBloodline(PerkLib.CaninesDescendant, PerkLib.BloodlineCanine);
		addMutation(IMutationsLib.AnubiHeartIM);
		addMutation(IMutationsLib.AlphaHowlIM);
		
		buildTier(20, "anubi")
				.buffs({
					"tou.mult": +1.00,
					"wis.mult": +1.50,
					"lib.mult": +0.50
				})
				.end();
		buildTier(28, "anubi high priest/ess")
				.namesMaleFemale("anubi high priest", "anubi high priestess")
				.buffs({
					"tou.mult": +1.00,
					"wis.mult": +2.00,
					"lib.mult": +1.20
				})
				.end();
	}
}
}
