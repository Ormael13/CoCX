package classes.Races {
import classes.BodyParts.*;
import classes.IMutations.IMutationsLib;
import classes.Race;
import classes.VaginaClass;

public class SirenRace extends Race {
	public static const SirenScaleColors:/*String*/Array = ["rough gray", "orange", "dark gray", "grayish-blue", "iridescent gray", "ashen grayish-blue", "gray"];
	
	public function SirenRace(id: int) {
		super("Siren", id);
		
		addScores()
				.faceType(Face.SHARK_TEETH, +1)
				.hairType(Hair.FEATHER, +1)
				.hairColor("silver", +1)
				.earType(ANY(Ears.SHARK, Ears.HUMAN, Ears.ELFIN), +1)
				.tailType(Tail.SHARK, +1)
				.wingType(Wings.FEATHERED_LARGE, +4, -100)
				.armType(ANY(Arms.HARPY, Arms.SHARK), +1)
				.legType(ANY(LowerBody.SHARK, LowerBody.HARPY), +1)
				.skinCoatTypeAndColor(Skin.AQUA_SCALES, ANY(SirenScaleColors), +2)
				.gillType(Gills.FISH, +1)
				.eyeType(Eyes.HUMAN, +1)
				.vaginaType(VaginaClass.SHARK, +1);
		
		addMutation(IMutationsLib.HarpyHollowBonesIM);
		addMutation(IMutationsLib.SharkOlfactorySystemIM);
		
		buildTier(10,"siren")
				.namesTauric("siren", "siren-taur")
				.buffs({
					"str.mult": +0.80,
					"spe.mult": +1.20,
					"lib.mult": +1.00
				})
				.end();
		
		buildTier(20,"Greater siren")
				.namesTauric("Greater siren", "Greater siren-taur")
				.buffs({
					"str.mult": +0.50,
					"spe.mult": +0.70,
					"lib.mult": +0.30
				})
				.end();
	}
}
}
