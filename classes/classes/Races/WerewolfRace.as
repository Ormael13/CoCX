package classes.Races {
import classes.BodyParts.*;
import classes.CockTypesEnum;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;

public class WerewolfRace extends Race {
    public static const RaceBody:/*String*/Array = [
        /*Antenna*/		"Human",
        /*Arms*/		"Wolf",
        /*Balls*/		"Human",
        /*Breasts*/		"Human",
        /*Nips*/		"Human",
        /*Ears*/		"Wolf",
        /*Eyes*/		"Feral",
        /*Face*/		"WolfFangs",
        /*Gills*/		"Human",
        /*Hair*/		"Wolf",
        /*Horns*/		"Human",
        /*LowerBody*/	"Wolf",
        /*RearBody*/	"Wolf",
        /*Skin*/		"Wolf",
        /*Ovipositor*/	"Human",
        /*Oviposition*/	"Human",
        /*GlowingAss*/	"Human",
        /*Tail*/		"Wolf",
        /*Tongue*/		"Dog",
        /*Wings*/		"Human",
        /*Penis*/		"Wolf",
        /*Vagina*/		"Human",
        /*Perks*/		"Human"];
	
	public function WerewolfRace(id:int) {
		super("Werewolf", id, RaceBody);
	}
	
	public override function setup():void {
		
		addScores()
				.faceType(Face.WOLF_FANGS, +2)
				.eyeType(Eyes.FERAL, +2)
				.eyeType(NOT(Eyes.FENRIR), 0,-7)
				.earType(Ears.WOLF, +1)
				.tongueType(Tongue.DOG, +1)
				.armType(Arms.WOLF, +1)
				.legType(LowerBody.WOLF, +1)
				.tailType(Tail.WOLF, +1)
				.skinCoatType(Skin.FUR, +1)
				.rearType(RearBody.WOLF_COLLAR, +1)
				.rearType(NOT(RearBody.FENRIR_ICE_SPIKES), 0, -7)
				.corruption(AT_LEAST(20), +1)
				.hasPerk(PerkLib.Lycanthropy, +2, -11);
		addScoresAfter(1)
				.hasCockOfType(CockTypesEnum.WOLF, +1);
		
		addMutation(IMutationsLib.FerasBirthrightIM);
		addMutation(IMutationsLib.AlphaHowlIM);
		
		buildTier(12, "werewolf")
                .requirePerk(PerkLib.Lycanthropy)
				.buffs({
					"str.mult": +1.00,
					"tou.mult": +0.60,
					"spe.mult": +0.40,
					"int.mult": -0.20
				})
				.end();
		buildTier(16, "elder werewolf")
				.requirePreviousTier()
				.buffs({
					"str.mult": +1.30,
					"tou.mult": +0.80,
					"spe.mult": +0.50,
					"int.mult": -0.20
				})
				.end();
		buildTier(20, "ancient werewolf")
				.requirePreviousTier()
				.buffs({
					"str.mult": +1.60,
					"tou.mult": +1.00,
					"spe.mult": +0.60,
					"int.mult": -0.20
				})
				.end();
	}
}
}
