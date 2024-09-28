package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.CockTypesEnum;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;
import classes.VaginaClass;

public class DemonRace extends Race {
	public static const DemonSkinColors:/*String*/Array = ["olive", "tan", "fair", "shiny black", "sky blue", "indigo", "ghostly white", "leaf green", "light green", "light purple", "purple", "red", "grey", "blue", "snow white", "midnight black", "pink"];
    public static const DemonSkin2Colors:/*String*/Array = ["light pink", "purple", "turquoise", "light green", "snow white"];
	public static const DemonEyeColors:/*String*/Array = ["fiendish pink", "pink", "red", "yellow", "blue", "turquoise", "light green"];
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
		super("Demon", id, []);//RaceBody);
		mutationThreshold = 6;
	}
	
	public override function setup():void {
		addScores()
				.hornType(Horns.DEMON, +1)
				.hornType(NOT(Horns.GOAT), 0, -10)
				.faceType(Face.DEMON, +1)
				.faceType(NOT(Face.VAMPIRE), 0, -10)
				.tongueType(Tongue.DEMONIC, +1)
				.earType(ANY(Ears.ELFIN, Ears.ELVEN), +1)
				.eyeType(ANY(Eyes.DEMON, Eyes.DEVIL), +1)
				.eyeColor(ANY(DemonEyeColors), +1)
				.armType(Arms.DEMON, +1)
				.legType(ANY(LowerBody.DEMONIC_HIGH_HEELS, LowerBody.DEMONIC_GRACEFUL_FEET, LowerBody.DEMONIC_CLAWS), +1)
				.tailType(Tail.DEMONIC, +1)
				.wingType(Wings.BAT_LIKE_TINY, +2)
				.wingType(Wings.BAT_LIKE_LARGE, +4)
				.wingType(NOT(Wings.VAMPIRE), 0, -10)
				.plainSkinOfAdj(NOT("slippery"), +1)
				.skinColor1(ANY(DemonSkinColors), +1)
				.skinColor2(ANY(DemonSkin2Colors), +1)
				.skinBasePattern(Skin.PATTERN_DEMONIC_PLEASURE_RUNE, +1)
				.cockOrVaginaOfType(CockTypesEnum.DEMON, VaginaClass.DEMONIC, +1)
				.customRequirement("",'vagina and D+ tits or 12\"+ long cock',
						function (body:BodyData):Boolean {
							return body.hasVagina && body.biggestTitSize >= 4 || body.biggestCockSize > 12
						}, +1)
				.hornTypeAndCount(Horns.DEMON, GREATER_THAN(4), +4)
				.corruption(AT_LEAST(50), +1)
				.corruption(AT_LEAST(75), +1)
				.corruption(AT_LEAST(100), +1)
				.hasPerk(PerkLib.DemonicLethicite, +1)
				.hasPerk(PerkLib.Soulless, +4);
		
		addBloodline(PerkLib.DemonsDescendant, PerkLib.BloodlineDemon);
		addMutation(IMutationsLib.BlackHeartIM);
		addMutation(IMutationsLib.FiendishMetabolismIM);
		addMutation(IMutationsLib.FiendishBallsIM);
		addMutation(IMutationsLib.FiendishOvariesIM);
		
		buildTier(15, "succubi-kin/incubi-kin")
				.namesMaleFemaleTaur("incubi-kin", "succubi-kin", "incubi-kintaur", "succubi-kintaur")
				.buffs({
					"spe.mult": +0.25,
					"int.mult": +0.50,
					"lib.mult": +1.50,
					"maxmana_mult": +0.8,
					"maxwrath_mult": -0.3,
					"maxsf_mult": -0.8,
					"maxlust_mult": +0.6
				})
				.end();
		
		buildTier(21, "succubus/incubus")
				.namesMaleFemaleTaur("incubus","succubus","incubi-taur","succubi-taur")
				.requirePerk(PerkLib.Soulless)
				.buffs({
					"spe.mult": +0.65,
					"int.mult": +0.70,
					"lib.mult": +2.00,
					"sens": +20,
					"maxmana_mult": +1.2,
					"maxwrath_mult": -0.45,
					"maxlust_mult": +1.2
				})
				.end();
		
		buildTier(29, "elder succubus/incubus")
				.namesMaleFemaleTaur("elder incubus","elder succubus","elder incubi-taur","elder succubi-taur")
				.requirePerk(PerkLib.Soulless)
				.buffs({
					"spe.mult": +1.00,
					"int.mult": +1.10,
					"lib.mult": +2.75,
					"sens": +50,
					"maxmana_mult": +1.5,
					"maxwrath_mult": -0.5,
					"maxlust_mult": +1.5
				})
				.end();
		
		buildTier(38, "arch succubus/incubus")
				.namesMaleFemaleTaur("arch incubus","arch succubus","arch incubi-taur","arch succubi-taur")
				.requirePerk(PerkLib.Soulless)
				.buffs({
					"spe.mult": +2.00,
					"int.mult": +2.50,
					"lib.mult": +3.20,
					"sens": +200,
					"maxmana_mult": +1.8,
					"maxwrath_mult": -0.55,
					"maxlust_mult": +1.8
				})
				.end();
	}
}
}
