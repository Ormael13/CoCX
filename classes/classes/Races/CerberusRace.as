package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.CockTypesEnum;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;

public class CerberusRace extends Race {
	public static const CerberusEyeColors:Array = ["red", "green"];
	public static const CerberusSkinColors:Array = ["dark"];
	public static const CerberusFurColors:Array = ["midnight black"];
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

    public function CerberusRace(id:int) {
		super("Cerberus", id, []);//RaceBody);
	}

	public override function setup():void {
		addScores()
				//.hairType(Hair.WILD, +1)
				.faceType(Face.CERBERUS, +1, -1000)
				.tongueType(Tongue.DOG, +1)
				.eyeType(Eyes.INFERNAL, +1)
				.eyeColor(ANY(CerberusEyeColors), +1)
				.earType(Ears.DOG, +1)
				.tailType(Tail.DOG, +1)
				.armType(Arms.HOUND, +1)
				.legType(LowerBody.DOG, +1)
				.rearType(RearBody.HELLHOUND_COLLAR, +1)
				.hasCockOfType(CockTypesEnum.DOG, +1)
				.customRequirement("","twin cocks",
						function (body:BodyData):Boolean {
							return body.hasCock && body.cockCount == 2
						}, +1, -10)
				.hasBalls(+1)
				.customRequirement("","quad balls",
						function (body:BodyData):Boolean {
							return body.hasBalls && body.ballCount == 4
						}, +1)
				.skinCoatType(Skin.FUR, +1)
				.furColor1(ANY(CerberusFurColors), +1)
				.hairColor1(ANY(CerberusFurColors), +1)
				.skinColor1("grayish-blue", +1)
				.noWings(+4)
				.height(AT_LEAST(11*12), +1)
				.tone(AT_LEAST(80), +1)
				.corruption(AT_LEAST(50), +1)
				.hasPerk(PerkLib.Hellfire, +1)
				.hasPerk(PerkLib.TransformationImmunity2, +3);

		addMutation(IMutationsLib.AlphaHowlIM);
		addMutation(IMutationsLib.HellhoundFireBallsIM);

		buildTier(24, "Cerberus")
				.namesMaleFemaleMorphTaur("Hellhound Cerberus", "Barghest Cerberus", "Cerberus", "Cerberus-taur")
				.buffs({
					"str.mult": +3.5,
					"spe.mult": +2.6,
					"tou.mult": +2.1,
					"lib.mult": +2.6
				})
				.requirePerk(PerkLib.TransformationImmunity2)
				.end();

		buildTier(27, "Greater Cerberus")
                .requirePreviousTier()
				.namesMaleFemale("Greater Hellhound Cerberus", "Greater Barghest Cerberus")
				.buffs({
					"str.mult": +4.1,
					"spe.mult": +2.9,
					"tou.mult": +2.25,
					"lib.mult": +2.9
				})
				.end();

		buildTier(30, "Cerberus Lord")
                .requirePreviousTier()
				.namesMaleFemale("Hellhound Cerberus Lord", "Barghest Cerberus Lord")
				.buffs({
					"str.mult": +4.7,
					"spe.mult": +3.2,
					"tou.mult": +2.4,
					"lib.mult": +3.2
				})
				.end();

		buildTier(33, "Alpha Cerberus")
                .requirePreviousTier()
				.namesMaleFemale("Alpha Hellhound Cerberus", "Alpha Barghest Cerberus")
				.buffs({
					"str.mult": +5.3,
					"spe.mult": +3.5,
					"tou.mult": +2.55,
					"lib.mult": +3.5
				})
				.end();
	}

	public static function isCerberus(body:BodyData):Boolean {
		return body.faceType == Face.CERBERUS;
	}
}
}
