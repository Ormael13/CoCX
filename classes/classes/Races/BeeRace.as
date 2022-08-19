package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.CockTypesEnum;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;
import classes.StatusEffects;
import classes.Transformations.GradualTransformation;

public class BeeRace extends Race {
	public static const BeeHairColors:/*String*/Array = ["shiny black", "brown", "yellow"];
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


    public const TfList:/*PossibleEffect*/Array = [
		game.transformations.HairChangeColor(BeeHairColors),
		game.transformations.BreastRowsRemoveToOne,
		game.transformations.AntennaeBee,
		game.transformations.EyesSandTrap,
		game.transformations.HornsNone,
		game.transformations.SkinPatternBeeStripes,
		game.transformations.LowerBodyBee,
		game.transformations.ArmsBee,
		game.transformations.NipplesPerBreastOne,
		game.transformations.OvipositorBee,
		game.transformations.TailBee,
		new GradualTransformation("BeeWings", [
				game.transformations.WingsNone,
				game.transformations.WingsBeeSmall,
				game.transformations.WingsBeeLarge
		]),
		game.transformations.GillsNone,
		game.transformations.CockChangeType(CockTypesEnum.BEE, false),
		game.transformations.RearBodyNone
	];
	
	public function BeeRace(id:int) {
		super("Bee", id, []);
	}
	
	override public function finalizeScore(body:BodyData, score:int, checkRP:Boolean = true, outputText:Function = null):int {
        if (body.player.hasPerk(PerkLib.TransformationImmunityBeeHandmaiden)) {
            mutations[0][1] = +3;
        } else {
            mutations[0][1] = +1;
        }
        return super.finalizeScore(body, score, checkRP, outputText);
    }
	
	public override function setup():void {
		addScores()
				.chitinColors(ANY("yellow and black","yellow and ebony"), +1)
				.eyeType(Eyes.BLACK_EYES_SAND_TRAP, +1)
				.antennaeType(Antennae.BEE, +1)
				.faceType(Face.HUMAN, +1) //potem zamienić na specificzny dla pszczół wariant twarzy
				.noHorns(+1)
				.armType(Arms.BEE, +1)
				.legType(LowerBody.BEE, +1)
				.tailType(Tail.BEE_ABDOMEN, +1)
				.wingType(Wings.BEE_SMALL, +1)
				.wingType(Wings.BEE_LARGE, +4)
				.noRearBody(+1)
				.skinCoatPattern(Skin.PATTERN_BEE_STRIPES, +1)
				.hasPerk(PerkLib.BeeOvipositor, +1)
				.customRequirement("","vagina or bee cock",
						function (body:BodyData):Boolean {
							return body.hasVagina || body.player.beeCocks() > 0
						}, +1)
				.hasPerk(PerkLib.TransformationImmunityBeeHandmaiden, +2);
		addConditionedScores(
				function(body:BodyData):Boolean {
					return body.player.hasPerk(PerkLib.TransformationImmunityBeeHandmaiden);
				}, "Bee tf immunity;")
				.rearType(RearBody.BEE_HANDMAIDEN, +1)
				.customRequirement("","black nipples",
						function (body:BodyData):Boolean {
							return body.player.hasStatusEffect(StatusEffects.BlackNipples)
						}, +1);
		
		addMutation(IMutationsLib.TrachealSystemIM);
		
		buildTier(8, "bee-morph")
				.buffs({
					"tou.mult": +0.40,
					"spe.mult": +0.40,
					"int.mult": +0.20,
					"lib.mult": +0.20
				})
				.withExtraBonuses("Min Lib +5")
				.end();
		
		buildTier(16, "elder bee-morph")
				.buffs({
					"tou.mult": +0.70,
					"spe.mult": +0.70,
					"int.mult": +0.50,
					"lib.mult": +0.50
				})
				.withExtraBonuses("Min Lib +10")
				.end();
		
		buildTier(20, "bee handmaiden")
				.requirePerk(PerkLib.TransformationImmunityBeeHandmaiden)
				.buffs({
					"tou.mult": +2.70,
					"spe.mult": +2.70,
					"int.mult": +1.80,
					"lib.mult": +1.80
				})
				.withExtraBonuses("Min Lib +30")
				.end();/*
		
		buildTier(24, "bee handmaiden")
				.requirePerk(PerkLib.TransformationImmunityBeeHandmaiden)
				.buffs({
					"tou.mult": +3.30,
					"spe.mult": +3.30,
					"int.mult": +2.10,
					"lib.mult": +2.10
				})
				.withExtraBonuses("Min Lib +45")
				.end();*/
	}
}
}