package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.CoC;
import classes.GeneticMemories.RaceMem;
import classes.PerkLib;
import classes.Race;

public class AngelRace extends Race {
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

	public function AngelRace(id:int) {
		super("Angel", id, []);//RaceBody);
		chimeraTier = 0;
		grandChimeraTier = 0;
		disabled = true;
	}
	
	public override function setup():void {
		
		addScores()
				//start ctrl-spacing here
		;
		
		buildTier(15, "angel-kin")
				.buffs({
					"str.mult": +0.25,
					"tou.mult": +0.50,
					"wis.mult": +1.50,
					"maxlust_mult": -0.15,
					"maxsf_mult": +1,
					"maxwrath_mult": +0.6,
					"maxmana_mult": -0.8
				})
				.end();
		
		buildTier(21, "angel")
				//requirePerk(PerkLib.)-perk causing no mana for them like soulless make no sf for demons
				.buffs({
					"str.mult": +0.65,
					"tou.mult": +0.70,
					"wis.mult": +2.00,
					"sens": +20,
					"maxlust_mult": -0.3,
					"maxsf_mult": +1.5,
					"maxwrath_mult": +0.8
				})
				.end();
	}
}
}
