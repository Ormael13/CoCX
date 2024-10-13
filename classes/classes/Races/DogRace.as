package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.CockTypesEnum;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;
public class DogRace extends Race {
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

    public function DogRace(id:int) {
		super("Dog", id, []);//RaceBody);
		chimeraTier = 0;
		grandChimeraTier = 0;
	}
	
	public override function setup():void {
		addScores()
				.faceType(Face.DOG, +1)
				.earType(Ears.DOG, +1)
				.tailType(Tail.DOG, +1)
				.legType(LowerBody.DOG, +1)
				.hasCockOfType(CockTypesEnum.DOG, +1)
				.breastRowCount(2, +1)
				.breastRowCount(3, +2)
				.skinCoatType(Skin.FUR, +1)
				.customRequirement("","not Cerberus",
						function (body:BodyData):Boolean {
							return !(CerberusRace.isCerberus(body));
						}, 0, -1000);
		
		addBloodline(PerkLib.CaninesDescendant, PerkLib.BloodlineCanine);
		
		buildTier(4, "dog-morph")
				.namesMaleFemaleMorphTaur("dog-boy", "dog-girl", "dog-morph", "dog-taur")
				.buffs({
					"str.mult": +0.15,
					"tou.mult": +0.15,
					"spe.mult": +0.35,
					"int.mult": -0.05
				})
				.end();
	}
}
}
