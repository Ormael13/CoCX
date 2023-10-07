package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.CockTypesEnum;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;
import classes.VaginaClass;

public class AzazelRace extends Race {
	public static const AzazelEyeColors:/*String*/Array = ["gold","pure blue"];
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

    public function AzazelRace(id:int) {
		super("Azazel", id, []);//RaceBody);
		mutationThreshold = 6;
	}
	
	public override function setup():void {
		addScores()
				.hornType(ANY(Horns.GOAT, Horns.GOATQUAD), +1)
				.earType(Ears.GOAT, +1)
				.faceType(Face.INNOCENT, +1)
				.tongueType(Tongue.HUMAN, +1)
				.eyeType(ANY(Eyes.GOAT), +1)
				.tailType(ANY(Tail.GOAT, Tail.AZAZEL), +1)
				.armType(Arms.DEVIL, +1)
				.legType(LowerBody.HOOFED, +1)
				.wingType(ANY(Wings.PUREDEVILFEATHER), +4)
				.customRequirement("","not Devil",
						function (body:BodyData):Boolean {
							return !(DevilRace.isDevilLike(body));
						}, 0, -1000)
				.eyeColor(ANY(AzazelEyeColors), +1)
				.hairTypeAndColor1(ANY(Hair.NORMAL),ANY("immaculate white"), +2)
				.customRequirement("","immaculate white colored feather",
						function (body:BodyData):Boolean {
							return body.player.featherColor == "immaculate white";
						}, +1)
				.customRequirement("","immaculate white colored fur",
						function (body:BodyData):Boolean {
							return body.player.furColor == "immaculate white";
						}, +1)
				.height(LESS_THAN(48), +1)
				.corruption(0, +3)
				.hasPerk(PerkLib.InnerPhylactery, +5)
				.hasPerk(PerkLib.TransformationImmunity2, +3);

		addMutation(IMutationsLib.DiamondHeartIM);
		
		buildTier(11, "azazelkin")
				.requireWingType(Wings.PUREDEVILFEATHER)
				.requireFaceType(Face.INNOCENT)
				.namesTauric("azazelkin", "azazelkin-taur")
				.buffs({
					"str.mult": +0.55,
					"spe.mult": -0.20,
					"int.mult": +0.80,
					"wis.mult": +0.65,
					"maxlust_base": +90,
					"sens": +15
				})
				.end();
		
		buildTier(16, "azazel")
				.namesTauric("azazel", "azazel-taur")
				.requirePreviousTier()
				.requirePerk(PerkLib.InnerPhylactery)
				.buffs({
					"str.mult": +0.75,
					"spe.mult": -0.25,
					"int.mult": +1.30,
					"wis.mult": +1.00,
					"maxlust_base": +170,
					"sens": +40
				})
				.end();

		buildTier(29, "true azazel")
				.namesTauric("true azazel", "true azazel-taur")
				.requirePreviousTier()
				.buffs({
					"str.mult": +1.00,
					"spe.mult": -0.30,
					"int.mult": +2.50,
					"wis.mult": +1.50,
					"maxlust_base": +220,
					"sens": +50
				})
				.end();

	}

	public static function isAzazelLike(body:BodyData):Boolean {
		return body.faceType == Face.INNOCENT
				|| body.wingType == Wings.PUREDEVILFEATHER;
	}
}
}
