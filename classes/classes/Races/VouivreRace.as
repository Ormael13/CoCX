package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.CockTypesEnum;
import classes.GeneticMemories.RaceMem;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;
import classes.Races;
import classes.VaginaClass;

public class VouivreRace extends Race {
    public static const RaceBody:/*String*/Array = [
        /*Antenna*/		"Human",
        /*Arms*/		"Draconic",
        /*Balls*/		"Human",
        /*Breasts*/		"Human",
        /*Nips*/		"Human",
        /*Ears*/		"Draconic",
        /*Eyes*/		"Snake",
        /*Face*/		"Snake",
        /*Gills*/		"None",
        /*Hair*/		"Human",
        /*Horns*/		"QuadDraco",
        /*LowerBody*/	"Snake",
        /*RearBody*/	"Human",
        /*Skin*/		"Vouivre",
        /*Ovipositor*/	"Human",
        /*Oviposition*/	"Human",
        /*GlowingAss*/	"Human",
        /*Tail*/		"Human",
        /*Tongue*/		"Snake",
        /*Wings*/		"DraconicL",
        /*Penis*/		"Lizard",
        /*Vagina*/		"Lizard",
        /*Perks*/		"Human"];

	public function VouivreRace(id:int) {
		super("Vouivre", id, RaceBody);
	}
	
	public override function setup():void {
		addScores()
				.isNaga(+3, -1000)
				.tongueType(ANY(Tongue.SNAKE, Tongue.DRACONIC), +1)
				.faceType(Face.SNAKE_FANGS, +1)
				.armType(Arms.DRACONIC, +1)
				.armType(NONE(Arms.FEY_DRACONIC, Arms.LION), 0, -10)
				.skinCoatType(Skin.DRAGON_SCALES, +1)
				.earType(Ears.DRAGON, +1)
				.earType(NOT(Ears.CAT), 0, -10)
				.eyeType(Eyes.SNAKE, +1)
				.eyeType(NOT(Eyes.CAT), 0, -10)
				.hornType(Horns.DRACONIC_X4_12_INCH_LONG, +2)
				.hornType(Horns.DRACONIC_X2, +1)
				.wingType(Wings.DRACONIC_SMALL, +2)
				.wingType(Wings.DRACONIC_LARGE, +4)
				.wingType(Wings.DRACONIC_HUGE, +6)
				.cockOrVaginaOfType(CockTypesEnum.LIZARD, VaginaClass.NAGA, +1)
				.customRequirement("","Must have dragon wings",
						hasDragonWing,0,-1000
				)
				.customRequirement("","not another snake-like race",
						function (body:BodyData):Boolean {
							return !(body.player.racialScore(Races.NAGA) > 10
									|| GorgonRace.isGorgonLike(body)
									|| CouatlRace.isCouatlLike(body)
									|| HydraRace.isHydraLike(body)
									|| ApophisRace.isApophisLike(body));
						}, 0, -1000);
		addScoresAfter(11)
				.hasPerk(PerkLib.DragonFireBreath,+1);
		
		addMutation(IMutationsLib.VenomGlandsIM);
		addMutation(IMutationsLib.DrakeLungsIM);
		addMutation(IMutationsLib.MightyLowerHalfIM);
		
		buildTier(11, "lesser vouivre")
				.buffs({
					"str.mult": +0.70,
					"tou.mult": +0.45,
					"spe.mult": +0.45,
					"int.mult": +0.10,
					"wis.mult": -0.10
				})
				.end();
		
		buildTier(16, "vouivre")
				.buffs({
					"str.mult": +1.00,
					"tou.mult": +0.65,
					"spe.mult": +0.70,
					"int.mult": +0.15,
					"wis.mult": -0.15
				})
				.end();
		
		buildTier(21, "greater vouivre")
				.buffs({
					"str.mult": +1.30,
					"tou.mult": +0.80,
					"spe.mult": +1.00,
					"int.mult": +0.20,
					"wis.mult": -0.20
				})
				.end();
	}
	
	public static function isVouivreLike(body:BodyData):Boolean {
		return (body.hornType == Horns.DRACONIC_X4_12_INCH_LONG
					|| body.hornType == Horns.DRACONIC_X2)
				&& body.tongueType == Tongue.DRACONIC
				&& (body.wingType == Wings.DRACONIC_SMALL
					|| body.wingType == Wings.DRACONIC_LARGE
					|| body.wingType == Wings.DRACONIC_HUGE)
	}

	public static function hasDragonWing(body:BodyData):Boolean {
		return (body.wingType == Wings.DRACONIC_SMALL
						|| body.wingType == Wings.DRACONIC_LARGE || body.wingType == Wings.DRACONIC_HUGE)
	}
}
}
