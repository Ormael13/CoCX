package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.CockTypesEnum;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;
import classes.VaginaClass;

public class DraculaRace extends Race {
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
		
		public function DraculaRace(id:int) {
			super("Dracula", id, []);//RaceBody);
		}
	
	public override function setup():void {
		
		addScores()
                .earType(Ears.VAMPIRE, +1, -1000)
				.wingType(Wings.VAMPIRE, +4)
				.faceType(Face.VAMPIRE, +1)
				.eyeType(Eyes.VAMPIRE, +1)
				.eyeColor("blood-red", +1)
				.skinColor1("pale", +1)
				.skinBasePattern(Skin.PATTERN_BLOOD_MAGIC_TATTOO, +1)
				.rearType(RearBody.THIRSTY_NECK, +1)
				.tongueType(Tongue.DEMONIC, +1)
				.hornType(Horns.DEMON, +1)
				.hornType(NOT(Horns.GOAT), 0, -10)
				.hairType(Hair.SILKEN, +1)
				.tailType(Tail.DEMONIC, +1)
				.armType(Arms.DEMON, +1)
				.legType(ANY(LowerBody.DEMONIC_HIGH_HEELS, LowerBody.DEMONIC_GRACEFUL_FEET, LowerBody.DEMONIC_CLAWS), +1)
				.cockOrVaginaOfType(CockTypesEnum.DEMON, VaginaClass.DEMONIC, +1)
				.corruption(AT_LEAST(50), +1)
				.corruption(AT_LEAST(75), +1)
				.corruption(AT_LEAST(100), +1)
				.hasPerk(PerkLib.Undeath, +1)
				.hasPerk(PerkLib.Soulless, +2);
		
		addBloodline(PerkLib.VampiresDescendant,PerkLib.BloodlineVampire);
		addMutation(IMutationsLib.BlackHeartIM);
		addMutation(IMutationsLib.VampiricBloodstreamIM);
		addMutation(IMutationsLib.HollowFangsIM);
		
		buildTier(22, "fiendish vampire")
                .requirePerk(PerkLib.Soulless)
				.requirePerk(PerkLib.TransformationImmunity2)
				.buffs({
					"str.mult": +2.40,
					"spe.mult": +2.40,
					"int.mult": +2.40,
					"lib.mult": +2.70
				})
				.end();
		
		buildTier(34, "dracula")
                .requirePreviousTier()
				.namesMaleFemale("dracula", "draculina")
				.buffs({
					"str.mult": +3.60,
					"spe.mult": +3.60,
					"int.mult": +3.60,
					"lib.mult": +4.50
				})
				.end();
	}
}
}
