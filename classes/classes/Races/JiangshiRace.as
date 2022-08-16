package classes.Races {
import classes.BodyParts.*;
import classes.GeneticMemories.RaceMem;
import classes.PerkLib;
import classes.Race;

/**
 * Tier 1: jiangshi
 */
public class JiangshiRace extends Race {
	
	public static const JiangshiSkinColors:/*String*/Array = ["ghostly pale", "light blue", "snow white"];
	
	public function JiangshiRace(id:int) {
		super("Jiangshi", id);
		chimeraTier = 0;
		grandChimeraTier = 0;
        pinacleTierScore = 20;
        tfRace = RaceMem.JIANGSHI;
	}
	
	public override function setup():void {
		
		addScores()
				.skinPlainOnly(+1)
				.skinBaseAdj(NOT("slippery"), 0, -1)
				.skinColor1(ANY(JiangshiSkinColors), +1)
				.hairType(Hair.NORMAL, +1)
				.faceType(Face.JIANGSHI, +1)
				.eyeType(Eyes.JIANGSHI, +2)
				.earType(Ears.HUMAN, +1)
				.tongueType(Tongue.HUMAN, +1)
				.noGills(+1)
				.noAntennae(+1)
				.hornType(Horns.SPELL_TAG, +1)
				.noWings(+2)
				.noTail(+1)
				.armType(Arms.JIANGSHI, +1)
				.legType(LowerBody.JIANGSHI, +1)
				.noRearBody(+1)
				.skinBasePattern(Skin.PATTERN_NONE, +1)
				.hasPerk(PerkLib.Undeath, +2);
		
		buildTier(20, "jiangshi")
				.buffs({
					"str.mult": +1.50,
					"spe.mult": -0.90,
					"int.mult": -0.90,
					"wis.mult": +1.30,
					"lib.mult": +2.00
				})
				.end();
	}
}
}
