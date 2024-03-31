package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.PerkLib;
import classes.Race;
public class TrollRace extends Race {
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
		
		buildTier(10, "troll")
				.buffs({
					"str.mult": +0.30,
					"spe.mult": +0.40,
					"int.mult": +0.30,
					"wis.mult": +0.50
				})
				.end();
	}
}
}
