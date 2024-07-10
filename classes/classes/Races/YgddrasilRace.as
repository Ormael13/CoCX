package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;

public class YgddrasilRace extends Race {
	public static const YgddrasilSkinColors:/*String*/Array = ["mahogany", "brown", "black"];
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
	
	public function YgddrasilRace(id:int) {
		super("Yggdrasil", id, []);//RaceBody);
		mutationThreshold = 6;
	}
	
	public override function setup():void {
		
		addScores()
				.faceType(Face.PLANT_DRAGON, +2)
				.faceType(NONE(Face.DRAGON, Face.DRAGON_FANGS, Face.CAT, Face.CAT_CANINES), 0, -10)
				.hairType(ANY(Hair.ANEMONE,Hair.LEAF,Hair.GRASS), +1)
				.hairColor1("green", +1)
				.earType(Ears.LIZARD, +1)
				.earType(NOT(Ears.ELFIN), 0, -2)
				.hornType(Horns.OAK, +1)
				.armType(ANY(Arms.PLANT,Arms.PLANT2), +2)
				.armType(NONE(Arms.DRACONIC, Arms.FEY_DRACONIC, Arms.LION), 0, -10)
				.wingType(Wings.YGGDRASIL_LARGE, +4)
				.wingType(Wings.YGGDRASIL_HUGE, +6)
				.wingType(Wings.YGGDRASIL_HUGE_2, +8)
				.customRequirement("skin", "bark skin", function (body:BodyData):Boolean {
					return body.player.isBarkSkin()
				}, +2)
				.customRequirement("cock","tentacle or stamen cock",
						function (body:BodyData):Boolean {
							return body.player.tentacleCocks() > 0 || body.player.stamenCocks() > 0;
						}, +1)
				.legType(LowerBody.YGG_ROOT_CLAWS, +1)
				.legType(NONE(LowerBody.FROSTWYRM, LowerBody.FEY_DRAGON, LowerBody.LION), 0, -10)
				.tailType(Tail.YGGDRASIL, +1)
				.hasPerk(PerkLib.DragonPoisonousSapBreath, +1);
		
		addMutation(IMutationsLib.DrakeBonesIM);
		addMutation(IMutationsLib.DrakeHeartIM);
		addMutation(IMutationsLib.DrakeLungsIM);
		
		buildTier(12, "ygddrasil")
				.buffs({
					"maxhp_mult": +0.12,
					"str.mult": +0.30,
					"tou.mult": +1.30,
					"spe.mult": -0.50,
					"int.mult": +0.10,
					"wis.mult": +1.30,
					"lib.mult": -0.50,
					"sens": +20,
					"def": +7,
					"mdef": +7
				})
				.end();
		
		buildTier(20, "elder ygddrasil")
				.buffs({
					"maxhp_mult": +0.24,
					"str.mult": +0.40,
					"tou.mult": +2.00,
					"spe.mult": -0.60,
					"int.mult": +0.20,
					"wis.mult": +2.00,
					"lib.mult": -0.60,
					"sens": +40,
					"def": +14,
					"mdef": +14
				})
				.end();
		
		buildTier(28, "ancient ygddrasil")
				.buffs({
					"maxhp_mult": +0.36,
					"str.mult": +0.50,
					"tou.mult": +2.70,
					"spe.mult": -0.70,
					"int.mult": +0.30,
					"wis.mult": +2.70,
					"lib.mult": -0.70,
					"sens": +60,
					"def": +21,
					"mdef": +21
				})
				.end();
	}
}
}