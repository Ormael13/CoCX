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
                .faceType(ANY(Face.HUMAN, Face.ANT), +1, -1)
                .hornType(Horns.NONE, +1)
                .antennaeType(Antennae.MOTH, +1)
                .earType(Ears.INSECT, +1, -1)
                .skinCoatType(Skin.CHITIN, +1)
                .armType(Arms.MOTH, +1)
                .legType(LowerBody.MOTH, +1)
                .hasCockOfType(CockTypesEnum.INSECT, +1)
                .wingType(ANY(Wings.MOTH_SMALL,Wings.MOTH_LARGE), +1)
                .wingType(Wings.MOTH_LARGE, +2)
                .hasPerk(PerkLib.AntyDexterity, +1)
                .hasPerk(PerkLib.AntOvipositor, +1);
        addMutation(IMutationsLib.TrachealSystemIM);
    }
}
}
