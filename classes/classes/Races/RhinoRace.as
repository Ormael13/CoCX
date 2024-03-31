package classes.Races {
import classes.BodyParts.*;
import classes.CockTypesEnum;
import classes.Race;

public class RhinoRace extends Race {
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

	public function RhinoRace(id:int) {
		super("Rhino", id, []);//RaceBody);
		chimeraTier = 0;
		grandChimeraTier = 0;
		disabled = true;
	}
	
	public override function setup():void {
		
		addScores()
				.earType(Ears.RHINO, +1)
				.tailType(Tail.RHINO, +1)
				.faceType(Face.RHINO, +1)
				.hornType(Horns.RHINO, +1)
				.skinColor1("gray", +1)//thic skin perk also form numb rocks
				.hasCockOfType(CockTypesEnum.RHINO, +1);
		
		buildTier(4, "rhino")
				.namesMaleFemaleMorphTaur("rhino-man","rhino-girl","rhino-morph","rhino-morph")
				.buffs({
					"str.mult": +0.15,
					"tou.mult": +0.15,
					"spe.mult": -0.10,
					"int.mult": -0.10,
					"maxhp_base": +100
				})
				.end();
	}
}
}
