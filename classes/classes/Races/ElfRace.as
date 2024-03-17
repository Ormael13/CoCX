package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.GeneticMemories.RaceMem;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;
public class ElfRace extends Race {
	public static const ElfHairColors:/*String*/Array = ["black", "leaf green", "golden blonde", "silver"];
	public static const ElfSkinColors:/*String*/Array = ["dark", "light","tan","olive"];
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
	
	public function ElfRace(id:int) {
		super("Elf", id, RaceBody);
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
				.hairColor1(ANY(ElfHairColors), +1)
				.skinColor1(ANY(ElfSkinColors), +1)
				.noWings(+1)
				.tone(AT_MOST(60), +1)
				.thickness(AT_MOST(50), +1)
				.plainSkinOfAdj("flawless", +1)
				.hasPerk(PerkLib.FlawlessBody, +1)
				.hasPerk(PerkLib.ElvenSense, +1)
				.hasPerk(PerkLib.NaturalSpellcasting, +1)
				.customRequirement("","small cock",
						function (body:BodyData):Boolean {
							return body.hasCock && body.biggestCockSize < 6
						}, +1)
				.customRequirement("","vagina and big tits",
						function (body:BodyData):Boolean {
							return body.hasVagina && body.biggestTitSize >= 3
						}, +1)
				.customRequirement("","not a wood elf",
						function (body:BodyData):Boolean {
							return !body.player.hasPerk(PerkLib.BlessingOfTheAncestorTree)
						}, 0, -1000);
		
		addBloodline(PerkLib.ElfsDescendant, PerkLib.BloodlineElf);
		addMutation(IMutationsLib.ElvishPeripheralNervSysIM);
		
		buildTier(11, "elf")
                .namesTauric("elf", "elf-taur")
				.require("elf ears", function (body:BodyData):Boolean {
					return body.earType == Ears.ELVEN
				})
                .buffs({
                    "str.mult": -0.10,
                    "tou.mult": -0.15,
                    "spe.mult": +0.80,
                    "int.mult": +0.80,
                    "wis.mult": +0.60,
                    "maxmana_mult": +0.2,
                    "sens": +30
                })
                .end();
        buildTier(17, "high elf")
                .namesTauric("high elf", "high elf-taur")
				.requirePreviousTier()
                .buffs({
                    "str.mult": -0.20,
                    "tou.mult": -0.30,
                    "spe.mult": +1.60,
                    "int.mult": +1.60,
                    "wis.mult": +1.20,
                    "maxmana_mult": +0.4,
                    "sens": +60
                })
                .end();
	}
}
}
