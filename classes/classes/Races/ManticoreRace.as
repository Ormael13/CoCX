package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.IMutations.IMutationsLib;
import classes.Race;
import classes.VaginaClass;

/**
 * Tier 1: manticore
 * Tier 2: true manticore
 */
public class ManticoreRace extends Race {
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

	public function ManticoreRace(id:int) {
		super("Manticore", id, []);//RaceBody);
	}
	
	public override function setup():void {
		
		addScores()
				.faceType(Face.MANTICORE, +1)
				.eyeType(Eyes.MANTICORE, +1)
				.earType(Ears.LION, +1)
				.tailType(Tail.MANTICORE_PUSSYTAIL, +2, -1000)
				.rearType(RearBody.LION_MANE, +1)
				.armType(Arms.LION, +1)
				.legType(LowerBody.LION, +1)
				.tongueType(Tongue.CAT, +1)
				.wingType(Wings.MANTICORE_SMALL, +1)
				.wingType(Wings.MANTICORE_LARGE, +4)
				.noCock(+1, -3)
				.vaginaType(VaginaClass.MANTICORE, +1)
				.corruption(AT_LEAST(20), +1)
				.customRequirement("","more manticore features than other magical feline",
						CatRace.isManticoreSubrace,0,-1000
				);
		
		addMutation(IMutationsLib.CatLikeNimblenessIM);
		addMutation(IMutationsLib.ManticoreMetabolismIM);
		addMutation(IMutationsLib.PoisonGlandIM);
		
		buildTier(15, "manticore")
				.customNamingFunction(function(body:BodyData):String {
					if (body.isTaur && body.legType == LowerBody.LION) return "manticore-taur";
					return "manticore"
				})
				.buffs({
					"spe.mult": +1.10,
					"int.mult": +0.70,
					"lib.mult": +0.90,
					"sens": +45,
					"maxhp_base": +75
				})
				.end()
		
		buildTier(22, "true manticore")
				.customNamingFunction(function(body:BodyData):String {
					if (body.isTaur && body.legType == LowerBody.LION) return "true manticore-taur";
					return "true manticore"
				})
				.buffs({
					"spe.mult": +1.60,
					"int.mult": +0.90,
					"lib.mult": +1.40,
					"sens": +60,
					"maxhp_base": +150
				})
				.end()
	}
}
}
