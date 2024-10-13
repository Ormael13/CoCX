package classes.Races {
import classes.BodyParts.*;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;

public class DisplacerBeastRace extends Race {
	public static const DisplacerFurColors:/*String*/Array = ["black", "midnight black", "midnight"];
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


    public function DisplacerBeastRace(id:int) {
		super("Displacer beast", id, []);//RaceBody);
	}
	
	public override function setup():void {
		
		addScores()
				.faceType(ANY(Face.CAT,Face.CAT_CANINES), +1)
				.eyeTypeAndColor(Eyes.DISPLACER, "yellow", +1)
				.tongueType(Tongue.CAT, +1)
				.earType(Ears.DISPLACER, +1)
				.tailType(Tail.CAT, +1)
				.legType(LowerBody.LION, +1)
				.armType(Arms.DISPLACER, +3, -1000)
				.rearType(RearBody.DISPLACER_TENTACLES, +2, -1000)
				.skinCoatType(Skin.FUR, +1)
				.furColor1(ANY(DisplacerFurColors), +1)
				.skinColor1("dark gray", +1)
				.hasPerk(PerkLib.Flexibility, +1)
				.customRequirement("","more displacer features than other magical feline",
						CatRace.isDisplacerSubrace,0,-1000
				);
		
		addBloodline(PerkLib.FelinesDescendant, PerkLib.BloodlineFeline);
		addMutation(IMutationsLib.CatLikeNimblenessIM);
		addMutation(IMutationsLib.DisplacerMetabolismIM);
		
		buildTier(14, "displacer beast")
				.buffs({
					"str.mult": +0.95,
					"spe.mult": +1.00,
					"int.mult": -0.25,
					"wis.mult": -0.20,
					"lib.mult": +0.80
				})
				.end()
		
		buildTier(20, "elder displacer beast")
				.buffs({
					"str.mult": +1.40,
					"spe.mult": +1.40,
					"int.mult": -0.30,
					"wis.mult": -0.30,
					"lib.mult": +0.80
				})
				.end()
	}
}
}
