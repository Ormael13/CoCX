package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.Race;

public class YgddrasilRace extends Race {
	
	public function YgddrasilRace(id:int) {
		super("Yggdrassil", id);
	}
	
	public override function setup():void {
		
		addScores()
				.faceType(Face.PLANT_DRAGON, +2)
				.hairTypeAndColor(ANY(Hair.ANEMONE,Hair.LEAF,Hair.GRASS), "green", +1)
				.earType(Ears.LIZARD, +1)
				.earType(NOT(Ears.ELFIN), 0, -2)
				.armType(ANY(Arms.PLANT,Arms.PLANT2), +2) //++ - untill claws tf added arms tf will count for both arms and claws tf
		//claws?
				.wingType(Wings.PLANT, +1)
				.skinCoatType(Skin.SCALES, +1)
				.customRequirement("cock","tentacle or stamen cock",
						function (body:BodyData):Boolean {
							return body.player.tentacleCocks() > 0 || body.player.stamenCocks() > 0;
						}, +1)
				.legType(LowerBody.YGG_ROOT_CLAWS, +1)
				.tailType(Tail.YGGDRASIL, +1);
		
		buildTier(10, "ygddrasil")
				.buffs({
					"str.mult": +0.50,
					"tou.mult": +0.70,
					"spe.mult": -0.50,
					"int.mult": +0.50,
					"wis.mult": +0.80,
					"lib.mult": -0.50
				})
				.withExtraBonuses("+10 Armor / Magical Resistance")
				.end();
	}
}
}
