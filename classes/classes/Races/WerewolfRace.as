package classes.Races {
import classes.BodyParts.*;
import classes.CockTypesEnum;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;
import classes.VaginaClass;
import classes.internals.race.RaceUtils;

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
				.cockOrVaginaOfType(CockTypesEnum.WOLF, VaginaClass.HUMAN, +1)
				.noWings(+4)
				.corruption(AT_LEAST(20), +1)
				.corruption(AT_LEAST(50), +1)
				.corruption(AT_LEAST(80), +1)
				.hasPerk(PerkLib.LycanthropyDormant, +1)
				.hasPerk(PerkLib.Lycanthropy, +2, -11);
		
		addBloodline(PerkLib.WerewolfsDescendant,PerkLib.BloodlineWerewolf);
		addMutation(IMutationsLib.FerasBirthrightIM);
		addMutation(IMutationsLib.AlphaHowlIM);
		
		buildTier(12, "werewolf")
				.require("Lycanthropy or Dormant Lycanthropy perk", 
					RaceUtils.hasAnyPerkFn([PerkLib.Lycanthropy, PerkLib.LycanthropyDormant]))
				.buffs({
					"str.mult": +1.00,
					"tou.mult": +0.60,
					"spe.mult": +0.40,
					"int.mult": -0.20
				})
				.end();
		buildTier(18, "elder werewolf")
				.requirePreviousTier()
				.buffs({
					"str.mult": +1.45,
					"tou.mult": +0.90,
					"spe.mult": +0.55,
					"int.mult": -0.20
				})
				.end();
		buildTier(24, "ancient werewolf")
				.requirePreviousTier()
				.buffs({
					"str.mult": +1.90,
					"tou.mult": +1.20,
					"spe.mult": +0.70,
					"int.mult": -0.20
				})
				.end();
	}
}
}
