package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.PerkLib;
import classes.Race;
import classes.StatusEffects;
import classes.internals.race.RaceUtils;

public class CyclopRace extends Race {
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

    public function CyclopRace(id:int) {
		super("Cyclop", id, []);//RaceBody);
	}
	
	public override function setup():void {
		
		addScores()
				.skinPlainOnly(+1)
				.eyeType(Eyes.MONOEYE, +3)
				.faceType(Face.ANIMAL_TOOTHS, +1)
				.noWings(+1)
				.noTail(+1)
				.tone(AT_LEAST(90), +1)
				.customRequirement("","not a gazer",
						function(body:BodyData):Boolean {
							return !(body.rearType == RearBody.TENTACLE_EYESTALKS && body.player.statusEffectv1(StatusEffects.GazerEyeStalksPlayer) >= 2);
						}, 0, -10);
		addConditionedScores(
				RaceUtils.checkSlotFn(BodyData.SLOT_EYE_TYPE, Eyes.MONOEYE),
				"monoeye;")
				.armType(Arms.HUMAN, +1)
				.legType(LowerBody.HUMAN, +1);
		addScoresAfter(4)
				.tone(AT_LEAST(120), +1)
				.height(GREATER_THAN(72), +1);
		addScoresAfter(6)
				.height(GREATER_THAN(96), +1);
		addScoresAfter(8)
				.height(GREATER_THAN(120), +1);
		
		addBloodline(PerkLib.CyclopsDescendant, PerkLib.BloodlineCyclop);
		
		buildTier(12, "cyclop")
				.buffs({
					"str.mult": +0.90,
					"tou.mult": +0.90
				})
				.end()
	}
}
}
