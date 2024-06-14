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

public class MothRace extends Race {
    public static const MothChitinColors:/*String*/Array = ["brown", "black","white"];
    public static const RaceBody:/*String*/Array = [
        /*Antenna*/		"Moth",
        /*Arms*/		"Moth",
        /*Balls*/		"Human",
        /*Breasts*/		"Normal",
        /*Nips*/		"Human",
        /*Ears*/		"Insect",
        /*Eyes*/		"Moth",
        /*Face*/		"Moth",
        /*Gills*/		"None",
        /*Hair*/		"Human",
        /*Horns*/		"Human",
        /*LowerBody*/	"Moth",
        /*RearBody*/	"Human",
        /*Skin*/		"Moth",
        /*Ovipositor*/	"Ant",
        /*Oviposition*/	"Human",
        /*GlowingAss*/	"Human",
        /*Tail*/		"Moth",
        /*Tongue*/		"Human",
        /*Wings*/		"Moth",
        /*Penis*/		"Insect",
        /*Vagina*/		"Vagina",
        /*Perks*/		"Human"];
    public function MothRace(id:int)  {
        super("Moth", id, []);
    }
    public override function setup():void {
        addScores()
                .faceType(Face.HUMAN, +1, -1)
                .antennaeType(Antennae.MOTH, +1)
                .earType(Ears.INSECT, +1, -1)
				.eyeType(Eyes.MOTH, +1)
                .armType(Arms.MOTH, +1)
                .legType(LowerBody.MOTH, +1)
				.tailType(Tail.MOTH_ABDOMEN, +1)
				.rearType(RearBody.MOTH_COLLAR, +1)
                .wingType(Wings.MOTH_SMALL, +1)
                .wingType(Wings.MOTH_LARGE, +2)
                .noHorns(+1)
                .skinCoatType(Skin.CHITIN, +1)
				.chitinColor1(ANY(MothChitinColors), +1)
                .hasCockOfType(CockTypesEnum.INSECT, +1);
                //.hasPerk(PerkLib.AntyDexterity, +1)
		
        addMutation(IMutationsLib.TrachealSystemIM);
		
		buildTier(10, "moth-morph")
				.buffs({
					"tou.mult": -0.30,
					"spe.mult": +1.50,
                    "wis.mult": +0.70,
					"lib.mult": +0.30,
					"sens": +70
				})
				.end();
    }
}
}
