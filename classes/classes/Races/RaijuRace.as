package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.CockTypesEnum;
import classes.GeneticMemories.RaceMem;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;
import classes.StatusEffects;
import classes.VaginaClass;

public class RaijuRace extends Race {
	public static const RaijuEyeColors:/*String*/Array = ["blue","green", "turquoise","light green"];
	public static const RaijuHairColors:/*String*/Array = ["purple", "light blue", "yellow", "white", "lilac", "green", "stormy blue"];
    public static const RaceBody:/*String*/Array = [
        /*Antenna*/		"Human",
        /*Arms*/		"Raiju",
        /*Balls*/		"Human",
        /*Breasts*/		"Human",
        /*Nips*/		"Glow",
        /*Ears*/		"Raiju",
        /*Eyes*/		"Raiju",
        /*Face*/		"Weasel",
        /*Gills*/		"None",
        /*Hair*/		"Raiju",
        /*Horns*/		"Human",
        /*LowerBody*/	"Raiju",
        /*RearBody*/	"Raiju",
        /*Skin*/		"Raiju",
        /*Ovipositor*/	"Human",
        /*Oviposition*/	"Human",
        /*GlowingAss*/	"Glow",
        /*Tail*/		"Raiju",
        /*Tongue*/		"Human",
        /*Wings*/		"Thunder",
        /*Penis*/		"Raiju",
        /*Vagina*/		"Raiju",
        /*Perks*/		"Human"];
	
	public function RaijuRace(id:int) {
		super("Raiju", id, RaceBody);
	}
	
	public override function setup():void {
		addScores()
				.earType(ANY(Ears.RAIJU,Ears.WEASEL), +1)
				.eyeType(Eyes.RAIJU, +1)
				.eyeColor(ANY(RaijuEyeColors), +1)
				.faceType(Face.WEASEL, +1)
				.hornType(NOT(Horns.KIRIN), 0, -1000)
				.armType(ANY(Arms.RAIJU,Arms.RAIJU_PAWS), +1)
				.legType(LowerBody.RAIJU, +1)
				.tailType(Tail.RAIJU, +1)
				.tailType(NOT(Tail.THUNDERBIRD), 0, -1000)
				.wingType(Wings.THUNDEROUS_AURA, +4)
				.rearType(RearBody.RAIJU_MANE, +1)
				.skinBasePattern(Skin.PATTERN_LIGHTNING_SHAPED_TATTOO,+1)
				.hairType(Hair.STORM, +1)
				.hairColor1(ANY(RaijuHairColors), +1)
				.customRequirement("","glowing nipples or asshole",
						function (body:BodyData):Boolean {
							return body.player.hasStatusEffect(StatusEffects.GlowingNipples) || body.player.hasStatusEffect(StatusEffects.GlowingAsshole);
						}, +1)
				.cockOrVaginaOfType(CockTypesEnum.RAIJU, VaginaClass.RAIJU, +1);
				
		addBloodline(PerkLib.RaijusDescendant, PerkLib.BloodlineRaiju);
		addMutation(IMutationsLib.HeartOfTheStormIM);
		addMutation(IMutationsLib.RaijuCathodeIM);
		
		buildTier(10, "raiju")
				.requireWingType(Wings.THUNDEROUS_AURA)
				.namesTauric("raiju", "raiju-taur")
				.buffs({
					"spe.mult": +0.70,
					"int.mult": +0.50,
					"lib.mult": +0.80,
					"sens": +50
				})
				.end();
		
		buildTier(20, "greater raiju")
				.namesTauric("greater raiju", "greater raiju-taur")
				.requirePreviousTier()
				.buffs({
					"spe.mult": +1.50,
					"int.mult": +0.50,
					"lib.mult": +1.60,
					"sens": +60
				})
				.end();
	}
}
}
