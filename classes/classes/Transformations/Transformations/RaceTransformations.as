package classes.Transformations.Transformations {
import classes.Race;
import classes.Transformations.*;
import classes.Items.MutationsHelper;
import classes.Scenes.Metamorph;

/**
 * Base class for transformation events.
 */
public class RaceTransformations extends MutationsHelper {

    public static function raceTransform(name:String, raceArr:/*String*/Array, raceID:Race):Transformation {
        var desc:String = "[pg]<b>You are now a" + name + "</b>\n";

        const newTF:Transformation = new SimpleTransformation(name + " Full Transform",
            function(doOutput:Boolean):void{
                if(doOutput) outputText(desc);
                Metamorph.runMetamorph(raceArr);
            },
            function():Boolean{
                return player.isRace(raceID);
            },
            function():Boolean{
                return true;
            }
        );

        return newTF;
    }
}

}
