package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.CockTypesEnum;
import classes.GeneticMemories.RaceMem;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;
import classes.VaginaClass;

public class ScyllaRace extends Race {
	public static const ScyllaEyeColors:/*String*/Array = ["bright pink", "light purple", "purple"];
	public static const ScyllaSkinColors:/*String*/Array = ["ghostly pale"];
    public static const RaceBody:/*String*/Array = [
        /*Antenna*/		"Human",
        /*Arms*/		"Kraken",
        /*Balls*/		"Human",
        /*Breasts*/		"Human",
        /*Nips*/		"Human",
        /*Ears*/		"Elfin",
        /*Eyes*/		"Kraken",
        /*Face*/		"Human",
        /*Gills*/		"Human",
        /*Hair*/		"Human",
        /*Horns*/		"Kraken",
        /*LowerBody*/	"Scylla",
        /*RearBody*/	"Kraken",
        /*Skin*/		"Kraken",
        /*Ovipositor*/	"Human",
        /*Oviposition*/	"Human",
        /*GlowingAss*/	"Human",
        /*Tail*/		"Human",
        /*Tongue*/		"Human",
        /*Wings*/		"Human",
        /*Penis*/		"Human",
        /*Vagina*/		"Scylla",
        /*Perks*/		"Human"];
	
	public function ScyllaRace(id:int) {
		super("Scylla", id, RaceBody);
	}
	
	public override function setup():void {
		
		addScores()
				.faceType(Face.HUMAN, 0, -1)
				.eyeType(ANY(Eyes.KRAKEN, Eyes.HUMAN), +1)
				.eyeColor(ANY(ScyllaEyeColors), +1)
				.earType(Ears.ELFIN, +1)
				.hornType(Horns.KRAKEN, +2)
				.armType(Arms.KRAKEN, +1)
				.customRequirement("skin","slippery skin",
						function (body:BodyData): Boolean {
							return body.player.hasPlainSkinOnly() && body.skinBaseAdj == "slippery"
						}, +1)
				.skinColor1("ghostly pale", +1)
				.rearType(RearBody.KRAKEN, +1)
				.height(GREATER_THAN(96), +1)
				.height(GREATER_THAN(120), +1)
				.vaginaType(VaginaClass.SCYLLA, +1)
				.customRequirement("legs","scylla or kraken lower body",
						function (body:BodyData): Boolean {
							return body.player.isScylla() || body.player.isKraken();
						}, +0, -1000)
				.customRequirement("legs","scylla lower body",
						function (body:BodyData): Boolean {
							return body.player.isScylla();
						}, +2)
				.customRequirement("legs","kraken lower body",
						function (body:BodyData): Boolean {
							return body.player.isKraken();
						}, +4)
				.skinBasePattern(Skin.PATTERN_BIOLUMINESCENCE, +1)
				.hasPerk(PerkLib.InkSpray, +1);
		addConditionedScores(function (body:BodyData):Boolean {
			return body.player.isScylla() || body.player.isKraken();
		}, "scylla or kraken lower body;")
				.faceType(Face.HUMAN, +1)
				.hairType(Hair.NORMAL, +1)
				.cockOrVaginaOfType(CockTypesEnum.SCYLLATENTACLE, VaginaClass.SCYLLA, +1)
				.noWings(+2);
		
		addBloodline(PerkLib.KrakensDescendant, PerkLib.BloodlineKraken);
		addMutation(IMutationsLib.ScyllaInkGlandsIM);
		addMutation(IMutationsLib.MightyLowerHalfIM);
		
		buildTier(7, "scylla")
				.buffs({
					"str.mult": +0.65,
					"tou.mult": +0.20,
					"int.mult": +0.20,
					"maxhp_base": +50
				})
				.end();
		
		buildTier(12, "kraken")
				.buffs({
					"str.mult": +1.20,
					"tou.mult": +0.30,
					"int.mult": +0.30,
					"maxhp_base": +150
				})
				.end();
		
		buildTier(18, "elder kraken")
				.buffs({
					"str.mult": +1.70,
					"tou.mult": +0.50,
					"int.mult": +0.50,
					"maxhp_base": +300
				})
				.end();
		
		buildTier(24, "ancient kraken")
				.buffs({
					"str.mult": +2.20,
					"tou.mult": +0.70,
					"int.mult": +0.70,
					"maxhp_base": +600
				})
				.end();
	}
}
}
