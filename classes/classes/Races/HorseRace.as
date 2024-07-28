package classes.Races {
import classes.BodyParts.*;
import classes.CockTypesEnum;
import classes.IMutations.IMutationsLib;
import classes.Race;
import classes.VaginaClass;

public class HorseRace extends Race {
	public static const FurColors:/*String*/Array = ["brown", "chocolate", "auburn", "sandy brown", "caramel", "peach", "black", "midnight black", "dark gray", "gray", "light gray", "silver", "white", "brown and white", "black and white"];
    public static const RaceBody:/*String*/Array = [
        /*Antenna*/		"Human",
        /*Arms*/		"Human",
        /*Balls*/		"Human",
        /*Breasts*/		"Human",
        /*Nips*/		"Human",
        /*Ears*/		"Snake",
        /*Eyes*/		"Gorgon",
        /*Face*/		"Snake",
        /*Gills*/		"None",
        /*Hair*/		"Gorgon",
        /*Horns*/		"Human",
        /*LowerBody*/	"Snake",
        /*RearBody*/	"Human",
        /*Skin*/		"Snake",
        /*Ovipositor*/	"Human",
        /*Oviposition*/	"Human",
        /*GlowingAss*/	"Human",
        /*Tail*/		"Human",
        /*Tongue*/		"Snake",
        /*Wings*/		"Human",
        /*Penis*/		"Lizard",
        /*Vagina*/		"Lizard",
        /*Perks*/		"Human"];

	public function HorseRace(id:int) {
		super("Horse", id, []);//RaceBody);
	}
	
	public override function setup():void {
		addScores()
				.faceType(Face.HORSE, +1)
				.earType(Ears.HORSE, +1)
				.hornType(NONE(Horns.UNICORN,Horns.BICORN), 0, -1000)
				.tailType(Tail.HORSE, +1)
				.legType(LowerBody.HOOFED, +1)
				.hasCockOfType(CockTypesEnum.HORSE, +1)
				.vaginaType(VaginaClass.EQUINE, +1)
				.skinCoatType(Skin.FUR, +1)
				.armType(Arms.HUMAN, +1)
				.isNotTaur(0, -7);
		
		addMutation(IMutationsLib.EquineMuscleIM);
		addMutation(IMutationsLib.MightyLegsIM);
		
		buildTier(7, "equine-morph")
				.buffs({
					"spe.mult": +0.70,
					"tou.mult": +0.35,
					"maxhp_base": +70
				})
				.end();
	}
}
}
