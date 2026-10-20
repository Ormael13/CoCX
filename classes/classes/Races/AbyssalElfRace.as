package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;

public class AbyssalElfRace extends Race {
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
        
    public function AbyssalElfRace(id:int) {
        super("Abyssal Elf", id, []);//RaceBody);
		disabled = true;
    }
    
    public override function setup():void {
        addScores()
                .gillType(Gills.FISH, +1)
				.skinBasePattern(Skin.PATTERN_BIOLUMINESCENCE, +1)
				.hasPerk(PerkLib.FlawlessBody, +1)
				.hasPerk(PerkLib.ElvenSense, +1)
				.hasPerk(PerkLib.NaturalSpellcasting, +1)
				.hasPerk(PerkLib.DantianPhylactery, +1, -10)
				.hasPerk(PerkLib.GOBXChemical, -1000);//5+1

        addBloodline(PerkLib.ElfsDescendant, PerkLib.BloodlineElf);
		addMutation(IMutationsLib.ElvishPeripheralNervSysIM);
		addMutation(IMutationsLib.ElvenSharpEyesIM);
		
		buildTier(11, "abyssal elf")
                .requirePerk(PerkLib.DantianPhylactery)
                .buffs({
                        "str.mult": +0.00,
                        "tou.mult": +0.00,
                        "spe.mult": +0.00,
                        "int.mult": +0.00,
                        "wis.mult": +0.00,
                        "lib.mult": +0.00,
                        "sens": +0
                    })
                .end();
    }
}
}