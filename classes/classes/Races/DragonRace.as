package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.CockTypesEnum;
import classes.GeneticMemories.RaceMem;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;
import classes.lists.Gender;
import classes.VaginaClass;

/**
 * Tier 1: dragon
 * Tier 2: elder dragon
 * Tier 3: ancient dragon
 */
public class DragonRace extends Race {
	public static const DragonScaleColors:Array = ["red", "golden", "metallic golden", "metallic silver", "silver", "snow white", "green", "blue", "bronzed", "black", "midnight"];
    public static const RaceBody:/*String*/Array = [
        /*Antenna*/		"Human",
        /*Arms*/		"Dragon",
        /*Balls*/		"Human",
        /*Breasts*/		"Human",
        /*Nips*/		"Human",
        /*Ears*/		"Dragon",
        /*Eyes*/		"Dragon",
        /*Face*/		"Dragon",
        /*Gills*/		"None",
        /*Hair*/		"Human",
        /*Horns*/		"DragonQuad",
        /*LowerBody*/	"Dragon",
        /*RearBody*/	"Human",
        /*Skin*/		"Dragon",
        /*Ovipositor*/	"Human",
        /*Oviposition*/	"Human",
        /*GlowingAss*/	"Human",
        /*Tail*/		"Dragon",
        /*Tongue*/		"Dragon",
        /*Wings*/		"DraconicL",
        /*Penis*/		"Dragon",
        /*Vagina*/		"Human",
		/*Perks*/		"Dragon"];

    public function DragonRace(id:int) {
		super("Dragon", id, RaceBody);
		mutationThreshold = 6;
	}
	
	public override function setup():void {
		addScores()
				.faceType(ANY(Face.DRAGON, Face.DRAGON_FANGS), +1)
				.faceType(NONE(Face.JABBERWOCKY, Face.BUCKTOOTH, Face.CAT, Face.CAT_CANINES), 0, -10)
				.scaleColors(NOT("pinkish purple"), 0, -10)
				.hairColor1(NOT("pink"), 0, -10)
				.eyeType(Eyes.DRACONIC, +1)
				.eyeType(NONE(Eyes.CAT, Eyes.FERAL), 0, -10)
				.earType(Ears.DRAGON, +1)
				.earType(NOT(Ears.CAT), 0, -10)
				.tailType(Tail.DRACONIC, +1)
				.tailType(NONE(Tail.FEY_DRACONIC, Tail.CAT), 0, -10)
				.tongueType(Tongue.DRACONIC, +1)
				.tongueType(NOT(Tongue.CAT), 0, -1000)
				.wingType(Wings.DRACONIC_SMALL, +2)
				.wingType(Wings.DRACONIC_LARGE, +4)
				.wingType(Wings.DRACONIC_HUGE, +6)
				.wingType(NOT(Wings.FEY_DRAGON), 0, -10)
				.legType(LowerBody.DRAGON, +1)
				.legType(NONE(LowerBody.FROSTWYRM, LowerBody.FEY_DRAGON, LowerBody.LION), 0, -10)
				.armType(Arms.DRACONIC, +1)
				.armType(NONE(Arms.FEY_DRACONIC, Arms.LION, Arms.YGGDRASIL), 0, -10)
				.skinCoatType(Skin.DRAGON_SCALES, +1)
				.hornType(Horns.DRACONIC_X2, +1)
				.hornType(Horns.DRACONIC_X4_12_INCH_LONG, +2)
				.hornType(NONE(Horns.FROSTWYRM, Horns.GOAT, Horns.GOATQUAD), 0, -3)
				.cockOrVaginaOfType(CockTypesEnum.DRAGON, VaginaClass.DRAGON, +2)
				.hasPerk(PerkLib.GOBXChemical, -1000);
		addScoresAfter(8)
				.height(GREATER_THAN(120), +1)
				.hasAnyPerk([
					PerkLib.DragonFireBreath,
					PerkLib.DragonIceBreath,
					PerkLib.DragonLightningBreath,
					PerkLib.DragonDarknessBreath
				], +1)
				.hasAllPerks([
					PerkLib.DragonFireBreath,
					PerkLib.DragonIceBreath,
					PerkLib.DragonLightningBreath,
					PerkLib.DragonDarknessBreath
				], +1)
				.hasPerk(PerkLib.Dracoforce, +1);
		
		addBloodline(PerkLib.DragonsDescendant, PerkLib.BloodlineDragon);
		addMutation(IMutationsLib.DrakeBloodIM);
		addMutation(IMutationsLib.DrakeBonesIM);
		addMutation(IMutationsLib.DrakeHeartIM);
		addMutation(IMutationsLib.DrakeLungsIM);
		
		buildTier(16, "dragon")
				.namesMaleFemaleMorphTaur("dragon-man","dragon-girl",
						"dragon","dragon-taur")
				.buffs({
					"str.mult": +0.50,
					"tou.mult": +0.50,
					"spe.mult": +0.50,
					"int.mult": +0.40,
					"wis.mult": +0.40,
					"lib.mult": +0.30,
					"sens": +20,
					"maxhp_mult": +0.10,
					"maxhp_base": +1000,
					"def": +1,
					"mdef": +1
				})
				.withExtraBonuses("+50 Max Hunger")
				.end();
		buildTier(24, "elder dragon")
				.namesMaleFemaleMorphTaur("elder dragon-man","elder dragon-girl",
						"elder dragon","elder dragon-taur")
				.buffs({
					"str.mult": +0.80,
					"tou.mult": +0.80,
					"spe.mult": +0.80,
					"int.mult": +0.70,
					"wis.mult": +0.70,
					"lib.mult": +0.40,
					"sens": +30,
					"maxfatigue_base": +100,
					"maxlust_base": +25,
					"maxhp_mult": +0.20,
					"maxhp_base": +2000,
					"def": +4,
					"mdef": +4
				})
				.withExtraBonuses("+100 Max Hunger")
				.end();
		buildTier(32, "ancient dragon")
				.namesMaleFemaleMorphTaur("ancient dragon-man","ancient dragon-girl",
						"ancient dragon","ancient dragon-taur")
				.buffs({
					"str.mult": +1.00,
					"tou.mult": +1.00,
					"spe.mult": +1.00,
					"int.mult": +0.80,
					"wis.mult": +0.80,
					"lib.mult": +0.60,
					"sens": +40,
					"maxfatigue_base": +200,
					"maxlust_base": +50,
					"maxhp_mult": +0.30,
					"maxhp_base": +3000,
					"def": +10,
					"mdef": +10
				})
				.withExtraBonuses("+150 Max Hunger")
				.end();
	}
}
}