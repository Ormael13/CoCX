package classes.Races {
import classes.BodyParts.*;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;

public class NekomataRace extends Race{
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

	public function NekomataRace(id:int) {
		super("Nekomata", id, []);//RaceBody);
	}
	
	public override function setup():void {
		
		addScores()
				.faceType(Face.CAT_CANINES, +1)
				.eyeType(Eyes.CAT, +1)
				.earType(Ears.CAT, +1)
				.tongueType(Tongue.CAT, +1)
				.tailType(Tail.CAT, +1)
				.rearType(RearBody.LION_MANE, +1)
				.tailType(Tail.NEKOMATA_FORKED_1_3, +2)
				.tailType(Tail.NEKOMATA_FORKED_2_3, +3)
				.tailTypeAndCount(Tail.CAT, 2, +4)
				.armType(Arms.CAT, +1)
				.legType(LowerBody.CAT, +1)
				.skinCoatType(Skin.FUR, +1)
				.hasPerk(PerkLib.Flexibility, +1)
				.hasPerk(PerkLib.Necromancy, +1)
				.customRequirement("","more nekomata features than other magical feline",
						CatRace.isNekomataSubrace,0,-1000
				);
		
		addBloodline(PerkLib.FelinesDescendant, PerkLib.BloodlineFeline);
		addMutation(IMutationsLib.CatLikeNimblenessIM);
		addMutation(IMutationsLib.EyeOfTheTigerIM);
		
		buildTier(10, "nekomata")
				.buffs({
					"spe.mult": +0.40,
					"int.mult": +0.30,
					"wis.mult": +0.80,
					"maxsf_mult": +0.1
				})
				.withExtraBonuses(
					"+20% SF Regeneration"
				)
				.end();
		
		buildTier(14, "elder nekomata")
				.requireTailType(Tail.CAT)
				.requireTailCount(AT_LEAST(2))
				.buffs({
					"spe.mult": +0.50,
					"int.mult": +0.40,
					"wis.mult": +1.20,
					"maxsf_mult": +0.3
				})
				.withExtraBonuses(
					"+40% SF Regeneration"
				)
				.end();
	}
}
}
