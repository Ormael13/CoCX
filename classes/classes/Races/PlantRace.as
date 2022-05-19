package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.CockTypesEnum;
import classes.Race;
import classes.Races;

public class PlantRace extends Race {
	
	public function PlantRace(id:int) {
		super("Plant", id);
	}
	
	public override function setup():void {
		
		addScores()
				.faceType(Face.HUMAN, +1)
				.faceType(NOT(Face.PLANT_DRAGON), 0, -1)
				.hornType(ANY(Horns.OAK, Horns.ORCHID), +1)
				.earType(Ears.ELFIN, +1)
				.earType(NOT(Ears.LIZARD), 0, -1)
				.hairTypeAndColor(ANY(Hair.LEAF, Hair.GRASS), "green", +1)
				.plainSkinOfColor(ANY("leaf green", "lime green", "turquoise", "light green"), +1)
				//	if (skinType == 6)/zielona skóra +1, bark skin +2
				//		plantCounter += 2;
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
		
		buildTier(4, "plant-morph")
				.buffs({
					"tou.mult": +0.30,
					"spe.mult": -0.10
				})
				.withExtraBonuses("+2 Armor")
				.end();
		
		buildTier(5, "plant-morph")
				.buffs({
					"str.mult": +0.10,
					"tou.mult": +0.50,
					"spe.mult": -0.20
				})
				.withExtraBonuses("+4 Armor")
				.end();
		
		buildTier(6, "treant")
				.namesMaleFemaleTaur("treant", "dryad", "treant-taur", "dryad-taur")
				.buffs({
					"str.mult": +0.20,
					"tou.mult": +0.80,
					"spe.mult": -0.40
				})
				.withExtraBonuses("+8 Armor")
				.end();
		
		buildTier(7, "treant")
				.namesMaleFemaleTaur("treant", "dryad", "treant-taur", "dryad-taur")
				.buffs({
					"str.mult": +0.25,
					"tou.mult": +1.00,
					"spe.mult": -0.50
				})
				.withExtraBonuses("+10 Armor")
				.end();
	}
}
}
