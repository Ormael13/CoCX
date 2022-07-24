package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;

public class YgddrasilRace extends Race {
	
	public function YgddrasilRace(id:int) {
		super("Yggdrassil", id);
	}
	
	public override function setup():void {
		
		addScores()
				.faceType(Face.PLANT_DRAGON, +2)
				.hairType(ANY(Hair.ANEMONE,Hair.LEAF,Hair.GRASS), +1)
				.hairColor1("green", +1)
				.earType(Ears.LIZARD, +1)
				.earType(NOT(Ears.ELFIN), 0, -2)
				.armType(ANY(Arms.PLANT,Arms.PLANT2), +2) //++ - untill claws tf added arms tf will count for both arms and claws tf
				//claws?
				.wingType(Wings.YGGDRASIL_LARGE, +2)
				.wingType(Wings.YGGDRASIL_HUGE, +4)
				.wingType(Wings.YGGDRASIL_HUGE_2, +6)
				.skinCoatType(Skin.BARK, +1)
				.customRequirement("cock","tentacle or stamen cock",
						function (body:BodyData):Boolean {
							return body.player.tentacleCocks() > 0 || body.player.stamenCocks() > 0;
						}, +1)
				.legType(LowerBody.YGG_ROOT_CLAWS, +1)
				.tailType(Tail.YGGDRASIL, +1)
				.hasPerk(PerkLib.DragonPoisonBreath, +1);
		
		addMutation(IMutationsLib.DraconicBonesIM);
		addMutation(IMutationsLib.DraconicHeartIM);
		addMutation(IMutationsLib.DrakeLungsIM);
		
		buildTier(12, "ygddrasil")
				.buffs({
					"maxhp_mult": +0.10,
					"str.mult": +0.30,
					"tou.mult": +1.30,
					"spe.mult": -0.50,
					"int.mult": +0.10,
					"wis.mult": +1.30,
					"lib.mult": -0.50,
					"sens": +20,
					"def": +7,
					"mdef": +7
				})
				.end();
		
		buildTier(20, "elder ygddrasil")
				.buffs({
					"maxhp_mult": +0.20,
					"str.mult": +0.40,
					"tou.mult": +2.00,
					"spe.mult": -0.60,
					"int.mult": +0.20,
					"wis.mult": +2.00,
					"lib.mult": -0.60,
					"sens": +40,
					"def": +14,
					"mdef": +14
				})
				.end();
	}
}
}
