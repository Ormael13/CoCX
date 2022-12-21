package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;
public class BansheeRace extends Race {
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

	public function BansheeRace(id:int) {
		super("Banshee", id, []);//RaceBody);
		disabled = true;
		chimeraTier = 0;
		grandChimeraTier = 0;
        //tfRace = RaceMem.appendEnumVal("Banshee", CoC.instance.transformations.FullBanshee);
	}
	
	public override function setup():void {
		addScores()
				.hairType(Hair.GHOST, +1)
		
		buildTier(1000, "tierName")
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
