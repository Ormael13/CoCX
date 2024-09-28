package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.CockTypesEnum;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;
import classes.Transformations.TransformationLib;

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

	public function get TfList():/*PossibleEffect*/Array {
		var t:TransformationLib = game.transformations;
		return [
				// Lizardize
				t.FaceLizard,
				t.EarsLizard,
				t.EyesLizard,
				t.TailLizard,
				t.ArmsLizard,
				t.LowerBodyLizard(),
				t.SkinScalesGradualToFull,
				t.CockChangeType(CockTypesEnum.LIZARD,false),
				// Humanize
				t.AntennaeNone,
				t.SkinPatternNone,
				t.BreastRowsRemoveToOne,
				t.NipplesPerBreastOne,
				t.GillsNone,
				t.RearBodyNone
		]
	}
	
	public function LizardRace(id:int) {
		super("Lizard", id, []);//RaceBody);
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
		
		addBloodline(PerkLib.LizardsDescendant, PerkLib.BloodlineLizard);
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
