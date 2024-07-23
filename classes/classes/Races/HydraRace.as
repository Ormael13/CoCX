package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.CockTypesEnum;
import classes.GeneticMemories.RaceMem;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;
import classes.Races;
import classes.StatusEffects;
import classes.VaginaClass;

public class HydraRace extends Race {
    public static const RaceBody:/*String*/Array = [
        /*Antenna*/		"Human",
        /*Arms*/		"Hydra",
        /*Balls*/		"Human",
        /*Breasts*/		"Human",
        /*Nips*/		"Human",
        /*Ears*/		"Snake",
        /*Eyes*/		"Snake",
        /*Face*/		"Snake",
        /*Gills*/		"None",
        /*Hair*/		"Human",
        /*Horns*/		"Human",
        /*LowerBody*/	"Hydra",
        /*RearBody*/	"Human",
        /*Skin*/		"Snake",
        /*Ovipositor*/	"Human",
        /*Oviposition*/	"Human",
        /*GlowingAss*/	"Human",
        /*Tail*/		"Human",
        /*Tongue*/		"Snake",
        /*Wings*/		"Human",
        /*Penis*/		"Lizard",
        /*Vagina*/		"Lizard",
        /*Perks*/		"Human"];

	public function HydraRace(id:int) {
		super("Hydra", id, RaceBody);
	}
	
	public override function setup():void {
		addScores()
				.customScoreRequirement("legs", "hydra lower body, +1 per tail after 2",
						function (body:BodyData):Boolean {
							return body.legType == LowerBody.HYDRA && body.player.statusEffectv1(StatusEffects.HydraTailsPlayer) >= 1;
						},
						function (body:BodyData):int {
							return Math.min(11, body.player.statusEffectv1(StatusEffects.HydraTailsPlayer)-1);
						},
						-1000
				)
				.armType(Arms.HYDRA, +2)
				.tongueType(Tongue.SNAKE, +1)
				.faceType(Face.SNAKE_FANGS, +1)
				.skinCoatType(Skin.SCALES, +1)
				.eyeType(Eyes.SNAKE, +1)
				.earType(Ears.SNAKE, +1)
				.noWings(+2)
				.height(AT_LEAST(120), +1)
				.cockOrVaginaOfType(CockTypesEnum.LIZARD, VaginaClass.NAGA, +1)
				.hasPerk(PerkLib.LizanRegeneration, +1)
				.hasPerk(PerkLib.HydraRegeneration, +1)
				.hasPerk(PerkLib.HydraAcidBreath, +1)
				.customRequirement("","not another snake-like race",
						function (body:BodyData):Boolean {
							return !(body.player.racialScore(Races.NAGA) > 10
									|| GorgonRace.isGorgonLike(body)
									|| VouivreRace.isVouivreLike(body)
									|| CouatlRace.isCouatlLike(body)
									|| ApophisRace.isApophisLike(body));
						}, 0, -1000);
		
		addBloodline(PerkLib.HydrasDescendant, PerkLib.BloodlineHydra);
		addMutation(IMutationsLib.VenomGlandsIM);
		addMutation(IMutationsLib.HydraBloodIM);
		
		buildTier(14, "hydra")
				.buffs({
					"str.mult": +1.00,
					"tou.mult": +0.50,
					"spe.mult": +0.60
				})
				.end();
		
		buildTier(19, "greater hydra")
				.buffs({
					"str.mult": +1.20,
					"tou.mult": +1.05,
					"spe.mult": +0.60
				})
				.end();
		
		buildTier(24, "ancient hydra")
				.buffs({
					"str.mult": +1.30,
					"tou.mult": +1.25,
					"spe.mult": +1.05
				})
				.end();
		
		buildTier(29, "legendary hydra")
				.buffs({
					"str.mult": +1.60,
					"tou.mult": +1.45,
					"spe.mult": +1.30
				})
				.end();
	}
	
	public static function isHydraLike(body:BodyData):Boolean {
		return body.legType == LowerBody.HYDRA
				|| body.armType == Arms.HYDRA;
	}
}
}
