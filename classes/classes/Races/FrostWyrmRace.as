package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.CockTypesEnum;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;

public class FrostWyrmRace extends Race {
	public static const FrostWyrmHairColors:/*String*/Array = ["white", "snow white", "glacial white", "silver", "platinum silver"];
	public static const FrostWyrmScaleColos:/*String*/Array = ["bluish black", "dark gray", "black", "midnight black", "midnight"];
	
	public function FrostWyrmRace(id:int) {
		super("Frost Wyrm", id);
		chimeraTier = 0;
		grandChimeraTier = 0;
	}
	
	public override function setup():void {
		
		addScores()
				.earType(ANY(Ears.SNAKE,Ears.DRAGON), +1)
				.eyeType(Eyes.FROSTWYRM, +1)
				.faceType(Face.ANIMAL_TOOTHS, +1)
				.tongueType(Tongue.DRACONIC, +1)
				.armType(Arms.FROSTWYRM, +1, -1)
				.legType(LowerBody.FROSTWYRM, +3, -3)
				.rearType(RearBody.FROSTWYRM, +1)
				.skinCoatType(Skin.DRAGON_SCALES, +1)
				.hornType(Horns.FROSTWYRM, +2, -1);
		addScoresAfter(5)
				.noWings(+4)
				.hornType(NONE(Horns.DRACONIC_X4_12_INCH_LONG, Horns.DRACONIC_X2), 0, -2)
				.hairColor(ANY(FrostWyrmHairColors), +1)
				.skinCoatColor(ANY(FrostWyrmScaleColos), +1)
				.hasCockOfType(CockTypesEnum.DRAGON, +1)
				.customRequirement("","male with big cock or female with big tits",
						function (body:BodyData):Boolean {
							return body.hasCock && body.biggestCockSize > 6
									|| body.hasVagina && body.biggestTitSize >= 3
						}, +1)
				.hasPerk(PerkLib.DragonIceBreath, +1);
		addScoresAfter(10)
				.height(GREATER_THAN(120), +1);
		
		addBloodline(PerkLib.DragonsDescendant,PerkLib.BloodlineDragon);
		addMutation(IMutationsLib.DraconicBonesIM);
		addMutation(IMutationsLib.DraconicHeartIM);
		addMutation(IMutationsLib.DrakeLungsIM);
		
		buildTier(18, "frost wyrm")
				.buffs({
					"str.mult": +1.30,
					"tou.mult": +1.10,
					"spe.mult": +0.70,
					"int.mult": -0.90,
					"lib.mult": +0.50
				})
				.withExtraBonuses(
					"+1 Armor / Magic Resistance"
				)
				.end();
		
		buildTier(26, "greater frost wyrm")
				.buffs({
					"str.mult": +1.80,
					"tou.mult": +1.50,
					"spe.mult": +0.90,
					"int.mult": -1.00,
					"lib.mult": +0.70
				})
				.withExtraBonuses(
					"+4 Armor / Magic Resistance"
				)
				.end();
	}
}
}
