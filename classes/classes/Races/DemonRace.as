package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.CockTypesEnum;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;
import classes.VaginaClass;

public class DemonRace extends Race {
	public static const DemonSkinColors:/*String*/Array = ["shiny black", "sky blue", "indigo", "ghostly white", "light purple", "purple", "red", "grey", "blue"];
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


    public function DemonRace(id:int) {
		super("Demon", id);
		mutationThreshold = 6;
	}
	
	public override function setup():void {
		addScores()
				.hornType(Horns.DEMON, +1)
				.hornType(NOT(Horns.GOAT), 0, -10)
				.tailType(Tail.DEMONIC, +1)
				.wingType(Wings.BAT_LIKE_TINY, +2)
				.wingType(Wings.BAT_LIKE_LARGE, +4)
				.tongueType(Tongue.DEMONIC, +1)
				.earType(ANY(Ears.ELFIN, Ears.ELVEN, Ears.HUMAN), +1)
				.legType(ANY(LowerBody.DEMONIC_HIGH_HEELS, LowerBody.DEMONIC_CLAWS), +1)
				.cockOrVaginaOfType(CockTypesEnum.DEMON, VaginaClass.DEMONIC, +1);
		addScoresAfter(5)
				.hasPerk(PerkLib.DemonicLethicite, +1)
				.hasPerk(PerkLib.Phylactery, +5);
		addConditionedScores(function (body:BodyData):Boolean {
			return body.player.cor >= 50;
		}, "cor 50+;", 5)
				.hornTypeAndCount(Horns.DEMON, GREATER_THAN(4), +4)
				.plainSkinOfAdj(NOT("slippery"), +1)
				.skinColor1(ANY(DemonSkinColors), +1)
				.faceType(ANY(Face.HUMAN, Face.ANIMAL_TOOTHS, Face.DEVIL_FANGS), +1)
				.armType(Arms.HUMAN, +1);
		
		addMutation(IMutationsLib.BlackHeartIM);
		
		buildTier(11, "succubi-kin/incubi-kin")
				.namesMaleFemaleTaur("incubi-kin", "succubi-kin", "incubi-kintaur", "succubi-kintaur")
				.buffs({
					"spe.mult": +0.30,
					"int.mult": +0.35,
					"lib.mult": +1.00,
					"maxmana_mult": +0.8,
					"maxwrath_mult": -0.3,
					"maxsf_mult": -0.8,
					"maxlust_mult": +0.6
				})
				.end();
		
		buildTier(16, "succubus/incubus")
				.namesMaleFemaleTaur("incubus","succubus","incubi-taur","succubi-taur")
				.requirePerk(PerkLib.Phylactery)
				.buffs({
					"spe.mult": +0.40,
					"int.mult": +0.60,
					"lib.mult": +1.40,
					"maxmana_mult": +1.2,
					"maxwrath_mult": -0.45,
					"maxsf_mult": -0.8,
					"maxlust_mult": +1.2
				})
				.end();
	}
}
}
