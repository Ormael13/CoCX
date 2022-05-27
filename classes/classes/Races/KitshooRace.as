package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;
public class KitshooRace extends Race {
	public function KitshooRace(id:int) {
		super("Kitshoo", id);
		disabled = true;
	}
	
	public override function setup():void {
		addScores()
				.earType(Ears.FOX, +1)
				.faceType(ANY(Face.HUMAN, Face.FOX), +1)
				.skinCoatTypeAndColor(Skin.FUR, ANY(KitsuneRace.KitsuneHairColors), +1)
				.skinCoatType(NOT(Skin.CHITIN), 0, -2)
				.skinBaseType(NOT(Skin.GOO), 0, -3)
		
		buildTier(6, "kitshoo")
				.namesTauric("kitshoo", "kitshoo-taur")
				.buffs({
					"str.mult": +0.00,
					"tou.mult": +0.00,
					"spe.mult": +0.00,
					"int.mult": +0.00,
					"wis.mult": +0.00,
					"lib.mult": +0.00,
					"sens": +0
				})
				.end();
	}
}
}
