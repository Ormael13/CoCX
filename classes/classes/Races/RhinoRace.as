package classes.Races {
import classes.BodyParts.*;
import classes.CockTypesEnum;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;

public class RhinoRace extends Race {
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

	public function RhinoRace(id:int) {
		super("Rhino", id, []);//RaceBody);
		mutationThreshold = 4;
	}
	
	public override function setup():void {
		
		addScores()
				.earType(Ears.RHINO, +1)
				.faceType(Face.RHINO, +1)
				.hornTypeAndCount(Horns.RHINO, AT_LEAST(1), +1)
				.hornTypeAndCount(Horns.STONE_RHINO, AT_LEAST(1), +2)
				.hornTypeAndCount(Horns.RHINO, AT_LEAST(2), +1)
				.hornTypeAndCount(Horns.STONE_RHINO, AT_LEAST(2), +2)
				.hornTypeAndCount(Horns.RHINO, AT_LEAST(3), +1)
				.hornTypeAndCount(Horns.STONE_RHINO, AT_LEAST(3), +2)
				.tailType(Tail.RHINO, +1)
				.tailType(Tail.STONE_RHINO, +2)
				.armType(Arms.RHINO, +1)
				.armType(Arms.STONE_RHINO, +2)
				.legType(LowerBody.HOOFED_NO_FUR, +1)
				.legType(LowerBody.STONE_HOOFED_NO_FUR, +2)
				.skinColor1("gray", +1)
				.skinBaseType(Skin.STONE, +1)
				.hasCockOfType(CockTypesEnum.RHINO, +1)
				.hasPerk(PerkLib.ThickSkin, +1)
				.hasPerk(PerkLib.GOBXChemical, -1000);
		
		addBloodline(PerkLib.RhinosDescendant, PerkLib.BloodlineRhino);
		addMutation(IMutationsLib.EquineMuscleIM);
		
		buildTier(8, "rhino")
				.namesMaleFemaleMorphTaur("rhino-man","rhino-girl","rhino-morph","rhino-morph")
				.buffs({
					"maxhp_mult": +0.01,
					"str.mult": +0.90,
					"tou.mult": +0.90,
					"int.mult": -0.20,
					"sens": -40,
					"maxhp_base": +100,
					"def": +5,
					"mdef": +2
				})
				.end();
		
		buildTier(14, "stone rhino")
				.namesMaleFemaleMorphTaur("stone rhino-man","stone rhino-girl","stone rhino-morph","stone rhino-morph")
				.requireArmType(Arms.STONE_RHINO)
				.requireLegType(LowerBody.STONE_HOOFED_NO_FUR)
				.buffs({
					"maxhp_mult": +0.04,
					"str.mult": +1.35,
					"tou.mult": +1.35,
					"int.mult": -0.30,
					"sens": -50,
					"maxhp_base": +400,
					"def": +20,
					"mdef": +8
				})
				.end();
		
		buildTier(20, "petrokheros")
				.requirePreviousTier()
				.buffs({
					"maxhp_mult": +0.06,
					"str.mult": +1.80,
					"tou.mult": +1.80,
					"int.mult": -0.40,
					"sens": -60,
					"maxhp_base": +600,
					"def": +30,
					"mdef": +12
				})
				.end();
	}
}
}
