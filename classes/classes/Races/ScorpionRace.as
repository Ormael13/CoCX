package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;
public class ScorpionRace extends Race {
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
	
	public function ScorpionRace(id:int) {
		super("Scorpion", id, []);//RaceBody);
		chimeraTier = 0;
		grandChimeraTier = 0;
		disabled = true;
	}
	
	public override function setup():void {
		addScores()
				.earType(Ears.INSECT, +1)
				.tailType(Tail.SCORPION, +1)
				.skinCoatType(Skin.CHITIN, +1);
		
		addMutation(IMutationsLib.TrachealSystemIM);
		
		buildTier(4, "scorpion")
				.namesTauric("scorpion-morph","scorpion-taur")
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
