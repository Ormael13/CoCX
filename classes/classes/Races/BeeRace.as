package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;
public class BeeRace extends Race {
	public static const BeeHairColors:/*String*/Array = ["shiny black", "brown", "yellow"];
	
	public function BeeRace(id:int) {
		super("Bee", id);
	}
	
	public override function setup():void {
		addScores()
				.chitinColor(ANY("yellow and black","yellow and ebony"), +1)
				.eyeType(Eyes.BLACK_EYES_SAND_TRAP, +2) //po dodaniu bee tongue wróci do +1
				.antennaeType(Antennae.BEE, +1)
				.faceType(Face.HUMAN, +1) //ptem zamienić na specificzną dla pszczół wariant twarzy
				.noHorns(+1)
				.armType(Arms.BEE, +1)
				.legType(LowerBody.BEE, +1)
				.tailType(Tail.BEE_ABDOMEN, +1)
				.wingType(Wings.BEE_SMALL, +1)
				.wingType(Wings.BEE_LARGE, +4)
				.noRearBody(+1)
				.skinCoatPattern(Skin.PATTERN_BEE_STRIPES, +1)
				.hasPerk(PerkLib.BeeOvipositor, +1)
				.customRequirement("","vagina or bee cock",
						function (body:BodyData):Boolean {
							return body.hasVagina || body.player.beeCocks() > 0
						}, +1);
		
		addMutation(IMutationsLib.TrachealSystemIM);
		
		buildTier(17, "bee-morph")
				.buffs({
					"tou.mult": +0.80,
					"spe.mult": +0.80,
					"int.mult": +0.50,
					"lib.mult": +0.65
				})
				.withExtraBonuses("Min Lib +10")
				.end();
	}
}
}
