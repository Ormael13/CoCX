package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.CoC;
import classes.CockTypesEnum;
import classes.GeneticMemories.RaceMem;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;
import classes.VaginaClass;

public class AbyssalSharkRace extends Race {
	
	public function AbyssalSharkRace(id:int) {
		super("Abbysal Shark", id, []);//RaceBody);
		//disabled = true;
	}
	
	public override function setup():void {
		
		addScores()
				.gillType(Gills.FISH, +1)
				.earType(Ears.SHARK, +1)
				.hairType(Hair.NORMAL, +1)
				.tongueType(Tongue.HUMAN, +1)
				.skinCoatType(ANY(Skin.SCALES, Skin.AQUA_SCALES, Skin.DRAGON_SCALES), +1)
				.cockOrVaginaOfType(CockTypesEnum.HUMAN, VaginaClass.SHARK, +1)
				.faceType(Face.SHARK_TEETH, +1)
				//.faceType(Face.SHARK_TEETH, +1)
				.rearType(RearBody.SHARK_FIN, +1)
				//.rearType(RearBody.SHARK_FIN, +1)
				.armType(Arms.SHARK, +1)
				//.armType(Arms.SHARK, +1)
				.legType(LowerBody.SHARK, +1)
				//.legType(LowerBody.SHARK, +1)
				.tailType(Tail.SHARK, +1)
				//.tailType(Tail.SHARK, +1)
				.hasPerk(PerkLib.Phylactery, +1, -5);
		
		buildTier(10, "shark-morph")
				.buffs({
					"str.mult": +0.50,
					"spe.mult": +0.90,
					"lib.mult": +0.10
				})
				.end();
				
		buildTier(12, "abyssal shark-morph")
				.end();
	}
}
}