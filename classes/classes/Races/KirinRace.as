package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.CockTypesEnum;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;
import classes.StatusEffects;
import classes.VaginaClass;

public class KirinRace extends Race {
	public static const KirinEyeColors:/*String*/Array = ["red","light blue","turquoise"];
	public static const KirinHairColors:/*String*/Array = ["silver", "silver-white", "white", "snow white", "golden blonde"];
	public static const KirinScaleColors:/*String*/Array = ["light blue", "silver", "silver-white", "metallic golden"];
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

	public function KirinRace(id:int) {
		super("Kirin", id, []);//RaceBody);
	}
	
	public override function setup():void {
		addScores()
				.tongueType(Tongue.DRACONIC, +1)
				.hairType(Hair.STORM, +1)
				.hairColor1(ANY(KirinHairColors), +1)
				.rearType(RearBody.RAIJU_MANE, +1)
				.tailType(Tail.KIRIN, +1)
				.tailType(NOT(Tail.THUNDERBIRD), 0, -1000)
				.tailType(NOT(Tail.RAIJU), 0, -1000)
				.legType(LowerBody.KIRIN, +2)
				.eyeColor(ANY(KirinEyeColors), +1)
				.skinBasePattern(Skin.PATTERN_LIGHTNING_SHAPED_TATTOO,+1)
				.skinCoatTypeAndColor1(Skin.DRAGON_SCALES, ANY(KirinScaleColors), +1)
				.wingType(Wings.THUNDEROUS_AURA, +4)
				.cockOrVaginaOfType(CockTypesEnum.KIRIN, VaginaClass.KIRIN, +1)
				.customRequirement("","glowing nipples and asshole",
						function (body:BodyData):Boolean {
							return body.player.hasStatusEffect(StatusEffects.GlowingNipples) && body.player.hasStatusEffect(StatusEffects.GlowingAsshole);
						}, +2)
				.hornTypeAndCount(Horns.KIRIN, LESS_THAN(6), +1, 0, "size 1-5 kirin horn")
				.hornTypeAndCount(Horns.KIRIN, AT_LEAST(6), +2, 0, "size 6+ kirin horn")
				.armType(Arms.LIZARD,+1)
				.earType(Ears.KIRIN,+1)
				.eyeType(Eyes.DRACONIC,+1)
				.faceType(ANY(Face.HUMAN, Face.HORSE), +1);

		addMutation(IMutationsLib.HeartOfTheStormIM);
		addMutation(IMutationsLib.RaijuCathodeIM);
		addMutation(IMutationsLib.DrakeBonesIM);
		
		buildTier(23, "Kirin")
				.requireLegType(LowerBody.KIRIN)
				.requireHornType(Horns.KIRIN)
				.buffs({
					"tou.mult": +0.45,
					"spe.mult": +1.50,
					"lib.mult": +1.50,
					"maxhp_base": +100
				})
				.end();
		
		buildTier(32, "elder Kirin")
				.requirePreviousTier()
				.buffs({
					"tou.mult": +0.80,
					"spe.mult": +2.00,
					"lib.mult": +2.00,
					"maxhp_base": +250
				})
				.end();
	}
}
}
