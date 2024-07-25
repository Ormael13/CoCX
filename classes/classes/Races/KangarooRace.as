package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.CockTypesEnum;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;
public class KangarooRace extends Race {
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
	
	public function KangarooRace(id:int) {
		super("Kangaroo", id, []);//RaceBody);
		chimeraTier = 0;
		grandChimeraTier = 0;
	}
	
	public override function setup():void {
		addScores()
				.earType(Ears.KANGAROO, +1)
				.tailType(Tail.KANGAROO, +1)
				.legType(LowerBody.KANGAROO, +1)
				.faceType(Face.KANGAROO,1)
				.skinCoatType(Skin.FUR, +1)
				.hasCockOfType(CockTypesEnum.KANGAROO, +1);
		
		addMutation(IMutationsLib.MightyLegsIM);
		
		buildTier(4, "kangaroo-morph")
				.buffs({
					"tou.mult": +0.05,
					"spe.mult": +0.15
				})
				.end();
	}
}
}
