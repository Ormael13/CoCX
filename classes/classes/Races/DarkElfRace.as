package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.GeneticMemories.RaceMem;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;
public class DarkElfRace extends Race {
	public static const DarkElfEyesColors:/*String*/Array = ["red", "lilac", "pink", "silver", "light blue"];
	public static const DarkElfHairColors:/*String*/Array = ["white", "golden blonde", "silver"];
	public static const DarkElfSkinColors:/*String*/Array = ["dark", "midnight blue", "black", "deep purple", "grey", "ebony"];
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
	
	public function DarkElfRace(id:int) {
		super("Dark Elf", id, RaceBody);
	}
	
	public override function setup():void {
		addScores()
				.earType(Ears.ELVEN, +1)
				.eyeType(Eyes.ELF, +1)
				.faceType(Face.ELF, +1)
				.tongueType(Tongue.ELF, +1)
				.armType(Arms.ELF, +1)
				.legType(LowerBody.ELF, +1)
				.hairType(Hair.SILKEN, +1)
				.hairColor1(ANY(DarkElfHairColors), +1, -1)
				.skinColor1(ANY(DarkElfSkinColors), +1, -1)
				.noWings(+1)
				.tone(AT_LEAST(60), +1)
				.thickness(AT_MOST(50), +1)
				.plainSkinOfAdj("flawless", +1)
				.hasPerk(PerkLib.FlawlessBody, +1)
				.hasPerk(PerkLib.ElvenSense, +1)
				.hasPerk(PerkLib.NaturalSpellcasting, +1)
				.customRequirement("","big cock",
						function (body:BodyData):Boolean {
							return body.hasCock && body.biggestCockSize > 12
						}, +1)
				.customRequirement("","vagina and small tits",
						function (body:BodyData):Boolean {
							return body.hasVagina && body.biggestTitSize < 3
						}, +1)
				.customRequirement("","not a wood elf",
						function (body:BodyData):Boolean {
							return !body.player.hasPerk(PerkLib.BlessingOfTheAncestorTree)
						}, 0, -1000)
				.hasPerk(PerkLib.GOBXChemical, -1000);
		
		addBloodline(PerkLib.ElfsDescendant, PerkLib.BloodlineElf);
		addMutation(IMutationsLib.ElvishPeripheralNervSysIM);
		
		buildTier(11, "dark elf")
                .namesTauric("dark elf", "dark elf-taur")
				.require("elf ears", function (body:BodyData):Boolean {
					return body.earType == Ears.ELVEN
				})
                .buffs({
                    "tou.mult": -0.10,
                    "spe.mult": +0.90,
                    "int.mult": +0.40,
                    "wis.mult": +0.90,
                    "maxmana_mult": +0.3,
                    "sens": +45
                })
                .end();
        buildTier(17, "dark high elf")
                .namesTauric("dark high elf", "dark high elf-taur")
				.requirePreviousTier()
                .buffs({
                    "tou.mult": -0.20,
                    "spe.mult": +1.70,
                    "int.mult": +1.00,
                    "wis.mult": +1.70,
                    "maxmana_mult": +0.6,
                    "sens": +90
                })
                .end();
	}
}
}
