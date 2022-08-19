package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.CockTypesEnum;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;
public class LizardRace extends Race {
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

	public function LizardRace(id:int) {
		super("Lizard", id);
	}
	
	public override function setup():void {
		addScores()
				.faceType(Face.LIZARD, +1)
				.earType(Ears.LIZARD, +1)
				.eyeType(Eyes.LIZARD, +1)
				.tailType(Tail.LIZARD, +1)
				.armType(Arms.LIZARD, +1)
				.legType(LowerBody.LIZARD, +1)
				.hornType(ANY(Horns.DRACONIC_X2,Horns.DRACONIC_X4_12_INCH_LONG), +1)
				.skinCoatType(ANY(Skin.SCALES, Skin.AQUA_SCALES, Skin.DRAGON_SCALES), +1)
				.hasCockOfType(CockTypesEnum.LIZARD, +1)
				.hasPerk(PerkLib.LizanRegeneration, +1);
		
		addMutation(IMutationsLib.LizanMarrowIM);
		
		
		buildTier(8, "lizan")
				.namesTauric("lizan", "lizan-taur")
				.buffs({
					"tou.mult": +0.70,
					"int.mult": +0.50,
					"maxfatigue_base": +100
				})
				.end();
	}
}
}
