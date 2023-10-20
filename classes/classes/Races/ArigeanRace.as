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
				//.gillType(Gills.FISH, +1)
				.earType(Ears.ELVEN, +1)
				//.eyeType(Eyes.DEVIL, +2)
				.faceType(Face.ARIGEAN, +1)
				/*.hairType(Hair.NORMAL, +1)
				.tongueType(Tongue.HUMAN, +1)
				.tailType(Tail.ABYSSAL_SHARK, +2)*/
				.armType(Arms.ARMORED_FOREARMS, +1)
				.legType(LowerBody.ARMORED_LEGS, +1)
				//.rearType(RearBody.ABYSSAL_SHARK_FIN, +2)
				//.skinBasePattern(Skin.PATTERN_BIOLUMINESCENCE, +1)
				.hairColor1(ANY(ArigeanHairColors), +1)
				//.skinCoatType(ANY(Skin.SCALES, Skin.AQUA_SCALES, Skin.DRAGON_SCALES), +1)
				.plainSkinOfColor1(ANY(ArigeanSkinColors), +1);
				/*.cockOrVaginaOfType(CockTypesEnum.HUMAN, VaginaClass.SHARK, +1)
				.customRequirement("",'60+ feminity',
						function (body:BodyData):Boolean {
							return body.player.femininity >= 60
						}, +1)
				.corruption(AT_LEAST(10), +1)*/
		
		//addMutation(IMutationsLib.SharkOlfactorySystemIM);
		/*
		buildTier(9, "half arigean")
				.end();
		*/
		buildTier(16, "arigean")
                //.requirePerk(PerkLib.DantianPhylactery)
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
				//.requirePerk(PerkLib.DantianPhylactery)
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
