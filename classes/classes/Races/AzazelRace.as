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
				.legType(LowerBody.HOOFED, +1)
				.tailType(ANY(Tail.GOAT, Tail.AZAZEL), +1)
				.wingType(ANY(Wings.PUREDEVILFEATHER), +4)
				.armType(Arms.DEVIL, +1)
				.hornType(ANY(Horns.GOAT, Horns.GOATQUAD), +1)
				.earType(Ears.GOAT, +1)
				.faceType(Face.INNOCENT, +1)
				.eyeType(ANY(Eyes.GOAT), +1)
				.customRequirement("","not Devil",
						function (body:BodyData):Boolean {
							return !(DevilRace.isDevilLike(body));
						}, 0, -1000);
		addScoresAfter(8)
				.eyeColor(ANY(AzazelEyeColors), +1)
				.height(LESS_THAN(48), +1)
				//.cockOrVaginaOfType(CockTypesEnum.HORSE, VaginaClass.DEMONIC, +1)
				.corruption(0, +3)
				.hasPerk(PerkLib.InnerPhylactery, +5);

		addMutation(IMutationsLib.DiamondHeartIM);
		
		buildTier(11, "azazelkin")
				.namesTauric("azazelkin", "azazelkin-taur")
				.buffs({
					"str.mult": +0.55,
					"spe.mult": -0.20,
					"int.mult": +0.80,
					"lib.mult": +0.65,
					"maxlust_base": +90,
					"sens": +15
				})
				.end();
		
		buildTier(16, "azazel")
				.namesTauric("azazel", "azazel-taur")
				.requirePerk(PerkLib.InnerPhylactery)
				.buffs({
					"str.mult": +0.75,
					"spe.mult": -0.25,
					"int.mult": +1.30,
					"lib.mult": +1.00,
					"maxlust_base": +170,
					"sens": +40
				})
				.end();
		
		buildTier(21, "true azazel")
				.namesTauric("true azazel", "true azazel-taur")
				.requirePreviousTier()
				.buffs({
					"str.mult": +0.95,
					"spe.mult": -0.30,
					"int.mult": +1.80,
					"lib.mult": +1.20,
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
