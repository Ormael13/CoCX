package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.GeneticMemories.RaceMem;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;
public class KitshooRace extends Race {
	public static const KitshooHairColors:/*String*/Array = ["white", "black", "red", "orange"];
	public static const KitshooScaleColors:/*String*/Array = ["red", "blazing red", "orange", "reddish-orange"];
	public static const KitshooFurColors:/*String*/Array = ["red", "blazing red", "orange", "reddish-orange"];
	public static const KitshooSkinColors:/*String*/Array = ["tan", "olive", "light", "dark", "ebony", "ashen", "sable", "milky white"];
    public static const RaceBody:/*String*/Array = [
        /*Antenna*/		"Human",
        /*Arms*/		"Salamander",
        /*Balls*/		"Human",
        /*Breasts*/		"Human",
        /*Nips*/		"Human",
        /*Ears*/		"Fox",
        /*Eyes*/		"Fox",
        /*Face*/		"Salamander",
        /*Gills*/		"Human",
        /*Hair*/		"Kitsumori",
        /*Horns*/		"Human",
        /*LowerBody*/	"Salamander",
        /*RearBody*/	"Human",
        /*Skin*/		"Kitsune",
        /*Ovipositor*/	"Human",
        /*Oviposition*/	"Human",
        /*GlowingAss*/	"Human",
        /*Tail*/		"Kitsumori",
        /*Tongue*/		"Human",
        /*Wings*/		"Human",
        /*Penis*/		"Human",
        /*Vagina*/		"Human",
        /*Perks*/		"Kitsune"];
	
	public function KitshooRace(id:int) {
		super("Kitsumori", id, RaceBody);
		mutationThreshold = 6;
	}
	
	public override function setup():void {
		addScores()
				.eyeType(Eyes.FOX, +1)
				.earType(Ears.FOX, +1)
				.customScoreRequirement("tail", "multiple cinder fox tails, +1 per tail",
						function (body:BodyData):Boolean {
							return body.tailType == Tail.KITSHOO && body.tailCount >= 2;
						},
						function (body:BodyData):int {
							return body.tailCount;
						},
						-7
				)
				.faceType(Face.SALAMANDER_FANGS, +1)
				.armType(Arms.SALAMANDER, +1)
				.legType(LowerBody.SALAMANDER, +1)
				.skinCoatType(NOT(Skin.CHITIN), 0, -2)
				.skinBaseType(NOT(Skin.GOO), 0, -3)
				.hasPerk(PerkLib.Lustzerker, +1);
		addScoresAfter(5)
				.skinBaseType(Skin.PLAIN, +1, -1)
				.skinBasePattern(Skin.PATTERN_MAGICAL_TATTOO, +1, -1)
				.hairColor1(ANY(KitshooHairColors), +1)
				.hasPerk(PerkLib.StarSphereMastery, +1);
		
		addBloodline(PerkLib.SalamandersDescendant, PerkLib.BloodlineSalamander);
		addMutation(IMutationsLib.KitsuneParathyroidGlandsIM);
		addMutation(IMutationsLib.SalamanderAdrenalGlandsIM);
		
		buildTier(8, "kitsumori")
				.namesTauric("kitsumori", "kitsumori-taur")
				.buffs({
					"tou.mult": +0.15,
					"spe.mult": +0.15,
					"int.mult": +0.40,
					"wis.mult": +0.50,
					"lib.mult": +0.50,
					"sens": +50,
					"maxlust_base": +20,
					"maxsf_mult": +0.15
				})
				.withExtraBonuses(
						"+30% SF Regeneration"
				)
				.end();
		buildTier(16, "elder kitsumori")
				.namesTauric("elder kitsumori", "elder kitsumori-taur")
				.requirePreviousTier()
				.requireTailType(Tail.KITSHOO)
				.requireTailCount(AT_LEAST(6))
				.buffs({
					"str.mult": +0.10,
					"tou.mult": +0.50,
					"spe.mult": +0.40,
					"int.mult": +0.70,
					"wis.mult": +0.80,
					"lib.mult": +0.90,
					"sens": +100,
					"maxlust_base": +40,
					"maxsf_mult": +0.25
				})
				.withExtraBonuses(
						"+40% SF Regeneration"
				)
				.end();
		buildTier(24, "nine-tailed elder kitsumori")
				.namesTauric("nine-tailed elder kitsumori", "nine-tailed elder kitsumori-taur")
				.requirePreviousTier()
				.requireTailCount(9)
				.buffs({
					"str.mult": +0.20,
					"tou.mult": +0.80,
					"spe.mult": +0.70,
					"int.mult": +1.00,
					"wis.mult": +1.10,
					"lib.mult": +1.30,
					"sens": +150,
					"maxlust_base": +60,
					"maxsf_mult": +0.35
				})
				.withExtraBonuses(
						"+50% SF Regeneration"
				)
				.end();
	}
}
}
