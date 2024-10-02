package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.CockTypesEnum;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;
import classes.VaginaClass;
import classes.internals.Utils;

public class DevilRace extends Race {
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

    public function DevilRace(id:int) {
		super("Devil", id, []);//RaceBody);
		mutationThreshold = 6;
	}
	
	public override function setup():void {
		addScores()
				.legType(LowerBody.CLOVEN_HOOFED, +1)
				.tailType(ANY(Tail.GOAT, Tail.DEMONIC), +1)
				.wingType(ANY(Wings.BAT_LIKE_TINY, Wings.BAT_LIKE_LARGE, Wings.DEVILFEATHER), +4)
				.armType(Arms.DEVIL, +1)
				.hornType(ANY(Horns.GOAT, Horns.GOATQUAD), +1)
				.earType(Ears.GOAT, +1)
				.faceType(Face.DEVIL_FANGS, +1);
		addScoresAfter(5)
				.eyeType(ANY(Eyes.DEVIL, Eyes.GOAT), +1)
				.height(LESS_THAN(48), +1)
				.cockOrVaginaOfType(CockTypesEnum.HORSE, VaginaClass.DEMONIC, +1)
				.corruption(AT_LEAST(60), +1)
				.hasPerk(PerkLib.Phylactery, +5)
				.customRequirement("","not Azazel",
						function (body:BodyData):Boolean {
							return !(AzazelRace.isAzazelLike(body));
						}, 0, -1000);
		
		addBloodline(PerkLib.DevilsDescendant, PerkLib.BloodlineDevil);
		addMutation(IMutationsLib.ObsidianHeartIM);
		
		buildTier(11, "devilkin")
				.namesTauric("devilkin", "devilkin-taur")
				.buffs({
					"str.mult": +0.55,
					"spe.mult": -0.20,
					"int.mult": +0.80,
					"lib.mult": +0.65,
					"maxlust_base": +90,
					"sens": +15
				})
				.end();
		
		buildTier(16, "devil")
				.namesTauric("devil", "devil-taur")
				.requirePerk(PerkLib.Phylactery)
				.buffs({
					"str.mult": +0.75,
					"spe.mult": -0.25,
					"int.mult": +1.30,
					"lib.mult": +1.00,
					"maxlust_base": +170,
					"sens": +40
				})
				.end();
		
		buildTier(21, "archdevil")
				.namesTauric("archdevilkin", "archdevilkin-taur")
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

	public static function isDevilLike(body:BodyData):Boolean {
		return body.faceType == Face.DEVIL_FANGS
				|| Utils.InCollection(body.wingType, Wings.BAT_LIKE_TINY, Wings.BAT_LIKE_LARGE, Wings.DEVILFEATHER);
	}
}
}
