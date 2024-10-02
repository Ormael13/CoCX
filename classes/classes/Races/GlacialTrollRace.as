package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.PerkLib;
import classes.Race;
import classes.VaginaClass;
public class GlacialTrollRace extends Race {
    public static const GlacialTrollFurColors:/*String*/Array = ["blue", "white"];
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

	public function GlacialTrollRace(id:int) {
		super("Glacial Troll", id, []);//RaceBody);
	}
	
	public override function setup():void {
		addScores()
				.faceType(Face.GLACIAL_TROLL, +1)
				.earType(Ears.GLACIAL_TROLL, +1)
				.eyeTypeAndColor(Eyes.HUMAN, "blue", +2)
				.armType(Arms.GLACIAL_TROLL, +2)
				.legType(LowerBody.GLACIAL_TROLL, +2)
				.skinCoatTypeAndColor1(Skin.FUR, ANY(GlacialTrollFurColors), +2)
				.biggestTitSize(AT_MOST(2), +1)
				.height(AT_LEAST(84), +1)
				.customRequirement("",'Troll Tail and having cock OR having human vagina',
						function (body:BodyData):Boolean {
							return (body.tailType == Tail.TROLL && body.player.hasCock()) || (body.player.hasVagina() && body.player.vaginaType() == VaginaClass.HUMAN)
						}, +1)
				.customRequirement("",'Feminity less than 56',
						function (body:BodyData):Boolean {
							return body.player.femininity <= 55
						}, +1);
		
		addBloodline(PerkLib.TrollsDescendant, PerkLib.BloodlineTroll);
		
		buildTier(10, "glacial troll")
				.buffs({
					"str.mult": +0.30,
					"tou.mult": +0.40,
					"spe.mult": +0.10,
					"int.mult": +0.20,
					"wis.mult": +0.50
				})
				.end();
	}
}
}
