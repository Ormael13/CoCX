package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.CoC;
import classes.CockTypesEnum;
import classes.GeneticMemories.RaceMem;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;
import classes.VaginaClass;

public class AbyssalSharkRace extends Race {
	public static const AbyssalSharkScaleColors:/*String*/Array = ["rough gray","dark gray","iridescent gray","ashen","gray","black"];
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

	public function AbyssalSharkRace(id:int) {
		super("Abbysal Shark", id, []);//RaceBody);
		//disabled = true;
	}
	
	public override function setup():void {
		
		addScores()
				.gillType(Gills.FISH, +1)
				.earType(Ears.SHARK, +1)
				.eyeType(Eyes.DEVIL, +1)
				//.faceType(Face.ABYSSAL_SHARK, +2)
				.hairType(Hair.NORMAL, +1)
				.tongueType(Tongue.HUMAN, +1)
				//.skinBasePattern(Skin.PATTERN_, +1) - bioluminescent
				.skinCoatType(ANY(Skin.SCALES, Skin.AQUA_SCALES, Skin.DRAGON_SCALES), +1)
				.cockOrVaginaOfType(CockTypesEnum.HUMAN, VaginaClass.SHARK, +1)
				.height(AT_LEAST(84), +1)
				.customRequirement("",'H-cup tits (or bigger) or 18"+ long cock',
						function (body:BodyData):Boolean {
							return body.biggestTitSize > 18 || body.biggestCockSize > 17
						}, +1)
//9
				.rearType(RearBody.SHARK_FIN, +1)
				//.rearType(RearBody.ABYSSAL_SHARK_FIN, +2)
				.armType(Arms.SHARK, +1)
				//.armType(Arms.SEA_DRAGON, +2)
				.legType(LowerBody.SHARK, +1)
				//.legType(LowerBody.ABYSSAL_SHARK, +2)
				.tailType(Tail.SHARK, +1)
				//.tailType(Tail.SHARK, +1)
				.hasPerk(PerkLib.Phylactery, +1, -10);//4+1
		
		buildTier(10, "abyssal shark-morph")
                .requirePerk(PerkLib.Phylactery)
				.buffs({
					"str.mult": +0.90,
					"spe.mult": +0.90,
					"wis.mult": +0.40,
					"lib.mult": -0.20,
					"sens": +50
				})
				.withExtraBonuses("+150 Max Hunger")
				.end();
				
		buildTier(18, "elder abyssal shark-morph")
				.requirePreviousTier()
				.buffs({
					"str.mult": +1.90,
					"spe.mult": +1.20,
					"wis.mult": +0.80,
					"lib.mult": -0.20,
					"sens": +100
				})
				.withExtraBonuses("+300 Max Hunger")
				.end();
	}
}
}
