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
				.tailType(NONE(Tail.CHAMELEON), 0, -10)
				.tailType(Tail.LIZARD, +2)
				.armType(Arms.LIZARD, +2)
				.legType(LowerBody.LIZARD, +2)
				.hornType(ANY(Horns.DRACONIC_X2,Horns.DRACONIC_X4_12_INCH_LONG), +1)
				.skinCoatType(Skin.SCALES, +2)
				.hasCockOfType(CockTypesEnum.LIZARD, +1)
				.noWings(+1)
				.hasPerk(PerkLib.LizanRegeneration, +1)
				.hasPerk(PerkLib.GOBXChemical, -1000);
		
		addBloodline(PerkLib.LizardsDescendant, PerkLib.BloodlineLizard);
		addMutation(IMutationsLib.LizanMarrowIM);
		
		buildTier(10, "lizan")
				.namesTauric("lizan", "lizan-taur")
				.buffs({
					"tou.mult": +1.00,
					"int.mult": +0.50,
					"maxhp_mult": +0.05,
					"maxhp_base": +500,
					"maxfatigue_base": +100
				})
				.end();
		
		buildTier(18, "elder lizan")
				.namesTauric("elder lizan", "elder lizan-taur")
				.buffs({
					"tou.mult": +2.00,
					"int.mult": +0.70,
					"maxhp_mult": +0.10,
					"maxhp_base": +1000,
					"maxfatigue_base": +200
				})
				.end();
		
		buildTier(26, "ancient lizan")
				.namesTauric("ancient lizan", "ancient lizan-taur")
				.buffs({
					"tou.mult": +3.10,
					"int.mult": +0.80,
					"maxhp_mult": +0.20,
					"maxhp_base": +2000,
					"maxfatigue_base": +400
				})
				.end();
	}
}
}
