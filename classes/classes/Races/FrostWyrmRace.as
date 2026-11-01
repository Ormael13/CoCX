package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.CockTypesEnum;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;
import classes.VaginaClass;

public class FrostWyrmRace extends Race {
	public static const FrostWyrmHairColors:/*String*/Array = ["white", "snow white", "glacial white", "silver", "platinum silver"];
	public static const FrostWyrmScaleColos:/*String*/Array = ["bluish black", "dark gray", "black", "midnight black", "midnight"];
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
	
	public function FrostWyrmRace(id:int) {
		super("Frost Wyrm", id, []);//RaceBody);
		chimeraTier = 0;
		grandChimeraTier = 0;
		mutationThreshold = 6;
	}
	
	public override function setup():void {
		
		addScores()
				.earType(ANY(Ears.SNAKE,Ears.DRAGON), +1)
				.eyeType(Eyes.FROSTWYRM, +1)
				.faceType(Face.ANIMAL_TOOTHS, +1)
				.tongueType(Tongue.DRACONIC, +1)
				.armType(Arms.FROSTWYRM, +1, -1)
				.legType(LowerBody.FROSTWYRM, +3, -3)
				.rearType(RearBody.FROSTWYRM, +1)
				.skinCoatType(Skin.DRAGON_SCALES, +1)
				.hornType(Horns.FROSTWYRM, +2, -1)
				.hasPerk(PerkLib.GOBXChemical, -1000);
		addScoresAfter(5)
				.noWings(+4)
				.hornType(NONE(Horns.DRACONIC_X4_12_INCH_LONG, Horns.DRACONIC_X2), 0, -2)
				.hairColor1(ANY(FrostWyrmHairColors), +1)
				.scaleColor1(ANY(FrostWyrmScaleColos), +1)
				.cockOrVaginaOfType(CockTypesEnum.DRAGON, VaginaClass.DRAGON, +2)
				.customRequirement("","male with big cock or female with big tits",
						function (body:BodyData):Boolean {
							return body.hasCock && body.biggestCockSize > 6
									|| body.hasVagina && body.biggestTitSize >= 3
						}, +1)
				.hasPerk(PerkLib.DragonIceBreath, +1);
		addScoresAfter(10)
				.height(GREATER_THAN(120), +1)
				.hasPerk(PerkLib.Dracoforce, +1);
		
		addBloodline(PerkLib.DragonsDescendant,PerkLib.BloodlineDragon);
		addMutation(IMutationsLib.DrakeBonesIM);
		addMutation(IMutationsLib.DrakeHeartIM);
		addMutation(IMutationsLib.DrakeLungsIM);
		addMutation(IMutationsLib.MightyLowerHalfIM);
		addMutation(IMutationsLib.WyrmMusculatureIM);
		addMutation(IMutationsLib.WyrmCursedBloodIM);
		
		buildTier(18, "frost wyrm")
				.buffs({
					"str.mult": +1.30,
					"tou.mult": +1.10,
					"spe.mult": +0.70,
					"int.mult": -0.90,
					"lib.mult": +0.50,
					"maxhp_mult": +0.10,
					"maxhp_base": +1000,
					"def": +1,
					"mdef": +1
				})
				.end();
		
		buildTier(26, "elder frost wyrm")
				.buffs({
					"str.mult": +1.80,
					"tou.mult": +1.50,
					"spe.mult": +0.90,
					"int.mult": -1.00,
					"lib.mult": +0.70,
					"maxhp_mult": +0.20,
					"maxhp_base": +2000,
					"def": +2,
					"mdef": +2
				})
				.end();
		
		buildTier(32, "jormungandr")
				.buffs({
					"str.mult": +2.30,
					"tou.mult": +1.80,
					"spe.mult": +0.90,
					"int.mult": -1.10,
					"lib.mult": +0.90,
					"maxhp_mult": +0.30,
					"maxhp_base": +3000,
					"def": +4,
					"mdef": +4
				})
				.end();
	}
}
}
