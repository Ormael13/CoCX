package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;
import classes.VaginaClass;

public class YgddrasilRace extends Race {
	public static const YgddrasilSkinColors:/*String*/Array = ["mahogany", "brown", "black"];
    public static const YgddrasilEyeColor:/*String*/Array = ["green"];
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
				.eyeType(Eyes.YGGDRASIL, +1)
				.eyeColor("green", +1)
				.eyeType(NOT(Eyes.CAT), 0, -10)
				.earType(Ears.LIZARD, +1)
				.earType(NOT(Ears.ELFIN), 0, -2)
				.hornType(Horns.OAK, +1)
				.armType(Arms.YGGDRASIL, +2)
				.armType(NONE(Arms.DRACONIC, Arms.FEY_DRACONIC, Arms.LION), 0, -10)
				.wingType(Wings.YGGDRASIL_LARGE, +4)
				.wingType(Wings.YGGDRASIL_HUGE, +6)
				.wingType(Wings.YGGDRASIL_HUGE_2, +8)
				.wingType(Wings.YGGDRASIL_HUGE_3, +10)
				.wingType(Wings.YGGDRASIL_HUGE_4, +12)
				.customRequirement("skin", "bark skin", function (body:BodyData):Boolean {
					return body.player.isBarkSkin()
				}, +2)
				.customRequirement("cock","tentacle or stamen cock",
						function (body:BodyData):Boolean {
							return body.player.tentacleCocks() > 0 || body.player.stamenCocks() > 0;
						}, +1)
				.vaginaType(VaginaClass.DRAGON, +1)
				.legType(LowerBody.YGG_ROOT_CLAWS, +1)
				.legType(NONE(LowerBody.FROSTWYRM, LowerBody.FEY_DRAGON, LowerBody.LION), 0, -10)
				.customScoreRequirement("tail", "multiple yggdrasil tails, +1 per tail",
						function (body:BodyData):Boolean {
							return body.tailType == Tail.YGGDRASIL && body.tailCount >= 1;
						},
						function (body:BodyData):int {
							return body.tailCount;
						},
						-7
				)
				.hasPerk(PerkLib.DragonPoisonousSapBreath, +1)
				.hasPerk(PerkLib.GOBXChemical, -1000);
		
		addMutation(IMutationsLib.DrakeBonesIM);
		addMutation(IMutationsLib.DrakeHeartIM);
		addMutation(IMutationsLib.DrakeLungsIM);
		addMutation(IMutationsLib.PlantChlorophyllIM);
		
		buildTier(16, "ygddrasil")
				.buffs({
					"str.mult": +0.30,
					"tou.mult": +1.70,
					"spe.mult": -0.60,
					"int.mult": +0.30,
					"wis.mult": +1.70,
					"lib.mult": -0.60,
					"sens": +40,
					"maxhp_mult": +0.15,
					"maxhp_base": +1500,
					"def": +10,
					"mdef": +10
				})
				.end();
		
		buildTier(24, "elder ygddrasil")
				.buffs({
					"str.mult": +0.50,
					"tou.mult": +2.80,
					"spe.mult": -1.00,
					"int.mult": +0.50,
					"wis.mult": +2.80,
					"lib.mult": -1.00,
					"sens": +100,
					"maxhp_mult": +0.30,
					"maxhp_base": +3000,
					"def": +20,
					"mdef": +20
				})
				.end();
		
		buildTier(32, "ancient ygddrasil")
				.buffs({
					"str.mult": +0.70,
					"tou.mult": +3.90,
					"spe.mult": -1.40,
					"int.mult": +0.70,
					"wis.mult": +3.90,
					"lib.mult": -1.40,
					"sens": +160,
					"maxhp_mult": +0.45,
					"maxhp_base": +4500,
					"def": +30,
					"mdef": +30
				})
				.end();
	}
}
}