package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.CockTypesEnum;
import classes.GeneticMemories.RaceMem;
import classes.IMutations.IMutationsLib;
import classes.Race;
import classes.VaginaClass;

public class AlrauneRace extends Race {
	public static const AlrauneEyeColor:/*String*/Array = ["light purple", "green", "light green"];
	public static const AlrauneHairColor:/*String*/Array = ["green", "light purple"];
	public static const AlrauneSkinColor:/*String*/Array = ["leaf green", "lime green", "turquoise", "light green"];
	
	public function AlrauneRace(id:int) {
		super("Alraune", id);
        tfRace = RaceMem.ALRAUNE;
	}

	public override function setup():void {

		addScores()
				.faceType(Face.HUMAN, +1)
				.eyeType(Eyes.HUMAN, +1)
				.eyeColor(ANY(AlrauneEyeColor), +1)
				.earType(Ears.ELFIN, +1)
				.hairTypeAndColor1(ANY(Hair.LEAF,Hair.GRASS),ANY(AlrauneHairColor), +1)
				.plainSkinOfColor1(ANY(AlrauneSkinColor), +1)
				.armType(Arms.PLANT, +1)
				.noWings(+1)
				.customRequirement("legs","alraune-like lower body",
						function (body:BodyData): Boolean {
							return body.player.isAlraune();
						}, +5)
				.hasCockOfType(CockTypesEnum.STAMEN, +1)
				.vaginaType(VaginaClass.ALRAUNE,1);

		addMutation(IMutationsLib.FloralOvariesIM);

		buildTier(13, "alraune")
				.customNamingFunction(function (body:BodyData):String {
					return body.legType == LowerBody.FLOWER_LILIRAUNE ? "liliraune" : "alraune";
				})
				.buffs({
					"tou.mult": +1.00,
					"spe.mult": -0.50,
					"lib.mult": +1.45,
					"def": +10
				})
				.end();

		buildTier(17, "greater alraune")
				.customNamingFunction(function (body:BodyData):String {
					return body.legType == LowerBody.FLOWER_LILIRAUNE ? "greater liliraune" : "greater alraune";
				})
				.buffs({
					"tou.mult": +1.15,
					"spe.mult": -0.60,
					"lib.mult": +2.00,
					"def": +10
				})
				.end();
	}
}
}
