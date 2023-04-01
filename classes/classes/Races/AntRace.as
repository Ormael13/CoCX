package classes.Races {
import classes.BodyParts.*;
import classes.CockTypesEnum;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;

public class AntRace extends Race {
    public static const AntChitinColors:/*String*/Array = ["brown", "black"];
    public static const RaceBody:/*String*/Array = [
        /*Antenna*/		"Ant",
        /*Arms*/		"Ant",
        /*Balls*/		"Human",
        /*Breasts*/		"Normal",
        /*Nips*/		"Human",
        /*Ears*/		"Insect",
        /*Eyes*/		"Human",
        /*Face*/		"Ant",
        /*Gills*/		"None",
        /*Hair*/		"Human",
        /*Horns*/		"Human",
        /*LowerBody*/	"Ant",
        /*RearBody*/	"Human",
        /*Skin*/		"Ant",
        /*Ovipositor*/	"Ant",
        /*Oviposition*/	"Human",
        /*GlowingAss*/	"Human",
        /*Tail*/		"Ant",
        /*Tongue*/		"Human",
        /*Wings*/		"Ant",
        /*Penis*/		"Insect",
        /*Vagina*/		"Vagina",
        /*Perks*/		"Human"];

	public function AntRace(id:int) {
		super("Ant", id, RaceBody);
		chimeraTier = 0;
		grandChimeraTier = 0;
	}
	
	public override function setup():void {
		
		addScores()
				.faceType(ANY(Face.HUMAN, Face.ANT), +1, -1)
                .hornType(Horns.NONE, +1)
				.antennaeType(Antennae.ANT, +1)
                .earType(Ears.INSECT, +1, -1)
				.skinCoatType(Skin.CHITIN, +1)
				.armType(Arms.ANT, +1)
				.legType(ANY(LowerBody.CHITINOUS_SPIDER_LEGS, LowerBody.MANTIS), +1)
                .legType(LowerBody.ANT, +2)
				.hasCockOfType(CockTypesEnum.INSECT, +1)
				.wingType(ANY(Wings.ANT_SMALL, Wings.BEE_SMALL, Wings.BEE_LARGE), +1)
				.wingType(Wings.ANT_LARGE, +2)
                .hasPerk(PerkLib.AntyDexterity, +1)
				.hasPerk(PerkLib.AntOvipositor, +1);

        addMutation(IMutationsLib.TrachealSystemIM);
				
		
		buildTier(10, "ant-morph")
				.buffs({
					"str.mult": +1.40,
                    "tou.mult": +0.70,
					"int.mult": -0.30,
                    "wis.mult": -0.30
				})
				.end();
		
		buildTier(14, "formicidian")
				.buffs({
					"str.mult": +2.00,
					"tou.mult": +0.90,
					"int.mult": -0.40,
                    "wis.mult": -0.40
				})
				.end();
	}
}
}
