package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.CoC;
import classes.CockTypesEnum;
import classes.GeneticMemories.RaceMem;
//import classes.IMutations.IMutationsLib;
//import classes.PerkLib;
import classes.Race;
import classes.VaginaClass;

public class ArigeanRace extends Race {
	public static const ArigeanSkinColors:/*String*/Array = ["albino"];
	public static const ArigeanHairColors:/*String*/Array = ["snowy white","white","silver"];
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
		
	public function ArigeanRace(id:int) {
		super("Arigean", id, []);//RaceBody);
		//disabled = true;
	}
	
	public override function setup():void {
		
		addScores()
				.earType(Ears.ELVEN, +1)
				.eyeType(Eyes.ARIGEAN, +1)
				//.eyeType(Eyes.ARIGEANPRINCESS, +2)
				.faceType(Face.ARIGEAN, +1)
				//.hairType(Hair.NORMAL, +1)
				.tongueType(Tongue.ARIGEAN, +1)
				.tailType(Tail.ARIGEAN_GREEN, +5)
				.armType(Arms.ARMORED_FOREARMS, +1)
				.legType(LowerBody.ARMORED_LEGS, +1)
				//.rearType(RearBody.ABYSSAL_SHARK_FIN, +2)
				//.skinBasePattern(Skin.PATTERN_BIOLUMINESCENCE, +1)
				.hairColor1(ANY(ArigeanHairColors), +1)
				.skinBaseType(Skin.PLAIN, +1)
				.plainSkinOfColor1(ANY(ArigeanSkinColors), +1)
				.cockOrVaginaOfType(CockTypesEnum.ARIGEAN, VaginaClass.ARIGEAN, +1)
				.customRequirement("",'60+ feminity',
						function (body:BodyData):Boolean {
							return body.player.femininity >= 60
						}, +1)
				.corruption(AT_LEAST(10), +1);
		
		//addMutation(IMutationsLib.SharkOlfactorySystemIM);
		
		buildTier(9, "half arigean")
				.buffs({
					"str.mult": +0.55,
					"tou.mult": +0.40,
					"spe.mult": +0.55,
					"int.mult": -0.05,
					"wis.mult": -0.10,
					"def": +1
				})
				.end();
		
		buildTier(16, "arigean")
                .requireTailType(Tail.ARIGEAN_GREEN)
				.buffs({
					"str.mult": +1.00,
					"tou.mult": +0.70,
					"spe.mult": +1.00,
					"int.mult": -0.10,
					"wis.mult": -0.20,
					"def": +3
				})
				.end();
		/*
		buildTier(18, "arigean elite")
				.requireTailType(Tail.ARIGEAN_RED)
				.buffs({
					"str.mult": +1.30,
					"tou.mult": +0.80,
					"spe.mult": +1.30,
					"int.mult": -0.30,
					"wis.mult": -0.40,
					"def": +4
				})
				.end();
		
		buildTier(20, "arigean countess")
				//.requirePerk(PerkLib.DantianPhylactery)
				.buffs({
					"str.mult": +1.00,
					"tou.mult": +0.70,
					"spe.mult": +1.00,
					"int.mult": -0.10,
					"wis.mult": -0.20,
					"def": +6
				})
				.end();*/
	}
}
}
