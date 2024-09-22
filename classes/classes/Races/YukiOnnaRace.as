package classes.Races {
import classes.BodyParts.*;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;

public class YukiOnnaRace extends Race {
	public static const YukiOnnaSkinColors:/*String*/Array = ["snow white", "light blue", "glacial white"];
	public static const YukiOnnaHairColors:/*String*/Array = ["snow white", "silver white", "platinum blonde", "quartz white"];
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
	
	public function YukiOnnaRace(id: int) {
		super("Yuki Onna", id, []);//RaceBody);
	}
	
	public override function setup():void {
		
		addScores()
				.skinColor1(ANY(YukiOnnaSkinColors), +1)
				.skinBaseAdj("cold", +1)
				.eyeColor("light purple", +1)
				.hairColor1(ANY(YukiOnnaHairColors), +1)
				.hairType(Hair.SNOWY, +1)
				.legType(LowerBody.YUKI_ONNA, +1)
				.armType(Arms.YUKI_ONNA, +1)
				.faceType(Face.YUKI_ONNA, +1)
				.rearType(RearBody.GLACIAL_AURA, +1)
				.wingType(Wings.LEVITATION, +3)
				.femininity(100, +1)
				.noCock(+1)
				.hasVagina(+1);
		
		addBloodline(PerkLib.YukiOnnasDescendant, PerkLib.BloodlineYukiOnna);
		addMutation(IMutationsLib.FrozenHeartIM);
		
		buildTier(14,"Yuki Onna")
				.buffs({
					"spe.mult": +0.70,
					"int.mult": +1.40,
					"wis.mult": +0.70,
					"lib.mult": +0.50
				})
				.end()
	}
}
}
