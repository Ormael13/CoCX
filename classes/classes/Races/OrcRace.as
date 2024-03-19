package classes.Races {
import classes.BodyParts.*;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;

public class OrcRace extends Race {
	public static const OrcSkinColors:/*String*/Array = ["green", "gray", "brown", "red", "sandy tan"];
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
	
	public function OrcRace(id:int) {
		super("Orc", id, []);//RaceBody);
	}
	
	public override function setup():void {
		addScores()
				.earType(Ears.ELFIN, +1)
				.eyeType(Eyes.ORC, +1)
				.faceType(Face.ORC_FANGS, +1)
				.armType(Arms.ORC, +1)
				.legType(LowerBody.ORC, +1)
				.skinBasePattern(Skin.PATTERN_SCAR_SHAPED_TATTOO, +1)
				.skinColor1(ANY(OrcSkinColors), +1)
				.skinPlainOnly(+1)
				.noTail(+1)
				.height(AT_LEAST(48), 0, -1000)
				.tone(AT_LEAST(80), +1)
				.tone(AT_LEAST(100), +1)
				.tone(AT_LEAST(120), +1)
				.thickness(AT_MOST(60), +1)
				.thickness(AT_MOST(20), +1)
				.hasPerk(PerkLib.Ferocity, +1);
		
		addBloodline(PerkLib.OrcsDescendant, PerkLib.BloodlineOrc);
		addMutation(IMutationsLib.OrcAdrenalGlandsIM);
		
		buildTier(11, "orc")
				.namesTauric("orc", "orc-taur")
				.buffs({
					"str.mult": +1.30,
					"tou.mult": +0.30,
					"spe.mult": +0.10,
					"int.mult": +0.10,
					"lib.mult": +0.25,
					"maxwrath_mult": +0.2
				})
				.end();
	}
}
}
