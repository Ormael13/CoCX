package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.CockTypesEnum;
import classes.Race;
import classes.Races;

public class PlantRace extends Race {
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
	
	public function PlantRace(id:int) {
		super("Plant", id, []);//RaceBody);
		chimeraTier = 0;
		grandChimeraTier = 0;
	}
	
	public override function setup():void {
		
		addScores()
				.faceType(Face.HUMAN, +1)
				.faceType(NOT(Face.PLANT_DRAGON), 0, -1)
				.hornType(ANY(Horns.OAK, Horns.ORCHID), +1)
				.earType(Ears.ELFIN, +1)
				.earType(NOT(Ears.LIZARD), 0, -1)
				.hairTypeAndColor1(ANY(Hair.LEAF, Hair.GRASS), "green", +1)
				.plainSkinOfColor1(ANY("leaf green", "lime green", "turquoise", "light green"), +1)
				//	if (skinType == 6)/zielona skóra +1, bark skin +2
				.customRequirement("skin", "bark skin", function (body:BodyData):Boolean {
					return body.player.isBarkSkin()
				}, +2)
				.armType(Arms.PLANT, +1)
				.legType(ANY(LowerBody.PLANT_HIGH_HEELS,LowerBody.PLANT_ROOT_CLAWS), +1)
				.hasCockOfType(CockTypesEnum.TENTACLE, +1)
				.wingType(Wings.PLANT, +1)
				.customRequirement("","not alraune",
						function (body:BodyData):Boolean {
							return !body.player.isRace(Races.ALRAUNE);
						}, 0, -7)
				.customRequirement("","not yggdrasil",
						function (body:BodyData):Boolean {
							return !body.player.isRace(Races.YGGDRASIL);
						}, 0, -4);
		
		buildTier(7, "plant-morph")
				.buffs({
					"str.mult": +0.25,
					"tou.mult": +0.75,
					"spe.mult": -0.25,
					"def": +5
				})
				.end();
		
		buildTier(10, "treant")
				.namesMaleFemaleTaur("treant", "dryad", "treant-taur", "dryad-taur")
				.buffs({
					"str.mult": +0.40,
					"tou.mult": +1.30,
					"spe.mult": -0.50,
					"def": +10,
					"mdef": +2
				})
				.end();
	}
}
}
