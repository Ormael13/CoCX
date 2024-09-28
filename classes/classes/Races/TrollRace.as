package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.PerkLib;
import classes.Race;
import classes.VaginaClass;
public class TrollRace extends Race {
    public static const TrollEyeColors:/*String*/Array = ["green", "grey"];
	public static const TrollFurColors:/*String*/Array = ["green", "grey"];
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

	public function TrollRace(id:int) {
		super("Troll", id, []);//RaceBody);
	}
	
	public override function setup():void {
		addScores()
				.faceType(Face.TROLL, +1)
				.earType(Ears.TROLL, +1)
				.eyeTypeAndColor(Eyes.HUMAN, ANY(TrollEyeColors), +2)
				.armType(Arms.TROLL, +2)
				.legType(LowerBody.TROLL, +2)
				.skinCoatTypeAndColor1(Skin.FUR, ANY(TrollFurColors), +2)
				.biggestTitSize(AT_MOST(2), +1)
				.height(AT_LEAST(84), +1)
				.customRequirement("",'Glacial Troll Tail and having cock OR having human vagina',
						function (body:BodyData):Boolean {
							return (body.tailType == Tail.TROLL && body.player.hasCock()) || (body.player.hasVagina() && body.player.vaginaType() == VaginaClass.HUMAN)
						}, +1)
				.customRequirement("",'Feminity less than 71',
						function (body:BodyData):Boolean {
							return body.player.femininity <= 70
						}, +1);
		
		addBloodline(PerkLib.TrollsDescendant, PerkLib.BloodlineTroll);
		
		buildTier(10, "troll")
				.buffs({
					"str.mult": +0.30,
					"tou.mult": +0.30,
					"spe.mult": +0.20,
					"int.mult": +0.20,
					"wis.mult": +0.60
				})
				.end();
	}
}
}
