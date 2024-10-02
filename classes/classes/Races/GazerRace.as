package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;
import classes.StatusEffects;

public class GazerRace extends Race {
	public static const GazerHairColors:/*String*/Array = ["black", "midnight", "midnight black"];
	public static const GazerSkinColors:/*String*/Array = ["snow white", "red", "pale white"];
    public static const RaceBody:/*String*/Array = [
        /*Antenna*/		"Human",
        /*Arms*/		"Elf",
        /*Balls*/		"Human",
        /*Breasts*/		"Human",
        /*Nips*/		"Human",
        /*Ears*/		"Elven",
        /*Eyes*/		"Elf",
        /*Face*/		"Elf",
        /*Gills*/		"None",
        /*Hair*/		"Elf",
        /*Horns*/		"Human",
        /*LowerBody*/	"Elf",
        /*RearBody*/	"Human",
        /*Skin*/		"Elf",
        /*Ovipositor*/	"Human",
        /*Oviposition*/	"Human",
        /*GlowingAss*/	"Human",
        /*Tail*/		"Human",
        /*Tongue*/		"Elf",
        /*Wings*/		"Human",
        /*Penis*/		"Human",
        /*Vagina*/		"Human",
        /*Perks*/		"Elf"];
	
	public function GazerRace(id:int) {
		super("Gazer", id, []);//RaceBody);
	}
	
	public override function setup():void {
		
		addScores()
				.hairColor1(ANY(GazerHairColors), +1)
				.skinPlainOnly(+1)
				.skinColor1(ANY(GazerSkinColors), +1)
				.skinBasePattern(Skin.PATTERN_OIL, +1)
				.eyeType(Eyes.MONOEYE, +1)
				.eyeColor("red", +1)
				.faceType(Face.ANIMAL_TOOTHS, +1)
				.armType(Arms.GAZER, +1)
				.legType(LowerBody.GAZER, +1)
				.noTail(+1)
				.wingType(Wings.LEVITATION, +1)
				.customScoreRequirement("rear",
						"tentacle eyestalks",
						function(body:BodyData):Boolean {
							return body.rearType == RearBody.TENTACLE_EYESTALKS && body.player.statusEffectv1(StatusEffects.GazerEyeStalksPlayer) >= 2
						},
						function (body:BodyData):int {
							var x:Number = body.player.statusEffectv1(StatusEffects.GazerEyeStalksPlayer);
							if (x >= 10) return 10;
							if (x >= 8) return 8;
							if (x >= 6) return 6;
							if (x >= 4) return 4;
							if (x >= 2) return 2;
							return 0;
						}
				);
		
		addBloodline(PerkLib.GazersDescendant, PerkLib.BloodlineGazer);
		addMutation(IMutationsLib.GazerEyesIM);
		
		buildTier(14, "gazer")
				.require("6+ eye stalks",
						function (body:BodyData):Boolean {
							return body.player.statusEffectv1(StatusEffects.GazerEyeStalksPlayer) >= 6;
						})
				.buffs({
					"tou.mult": +0.80,
					"spe.mult": -0.65,
					"int.mult": +1.30,
					"lib.mult": +0.90
				})
				.end();
		
		buildTier(21, "Eye Tyrant")
				.require("10+ eye stalks",
						function (body:BodyData):Boolean {
							return body.player.statusEffectv1(StatusEffects.GazerEyeStalksPlayer) >= 10;
						})
				.buffs({
					"tou.mult": +0.55,
					"spe.mult": -0.65,
					"int.mult": +1.80,
					"lib.mult": +1.30
				})
				.end();
	}
}
}
