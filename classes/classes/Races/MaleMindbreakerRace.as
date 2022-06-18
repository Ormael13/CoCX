package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.CockTypesEnum;
import classes.PerkLib;
import classes.Race;

import classes.internals.race.RaceUtils;

public class MaleMindbreakerRace extends Race{
	public static const MindbreakerEyeColors:/*String*/Array = ["yellow", "orange", "light green"];
	
	public function MaleMindbreakerRace(id:int) {
		super("Male Mind Breaker", id);
		chimeraTier = 0;
		grandChimeraTier = 0;
	}
	
	public override function setup():void {
		
		addScores()
				.faceType(Face.HUMAN, +1)
				.eyeType(Eyes.MINDBREAKERMALE, +1)
				.eyeColor(ANY(MindbreakerEyeColors), +1)
				.earType(Ears.HUMAN, +1)
				.noTail(+1)
				.rearType(RearBody.MINDBREAKER, +4)
				.armType(Arms.MINDBREAKER, +1)
				.legType(LowerBody.MINDBREAKERMALE,+1)
				.tongueType(Tongue.MINDBREAKERMALE, +1)
				.noWings(+3)
				.hasCockOfType(CockTypesEnum.MINDBREAKER, +1)
				.noVagina(0, -1000)
				.hairTypeAndColor(Hair.MINDBREAKERMALE, "purple", +1)
				.skinPlainOnly(0, -1)
				.skinColor("eldritch purple", +1)
				.skinBaseAdj("slippery", +1)
				.hasPerk(PerkLib.Insanity, +1)
				.givePerkV1(PerkLib.MindbreakerBrain1toX);
		
		buildTier(20,"mindbreaker")
				.buffs({
					"str.mult": +0.70,
					"spe.mult": -0.40,
					"tou.mult": +1.00,
					"int.mult": +4.50,
					"lib.mult": +4.00,
					"wis.mult": -0.30,
					"sens": +50
				})
				.end()
	}
}
}
