package classes.Scenes.Dungeons.DemonLab {
/**
 * ...
 * @author ...
 */

import classes.*;
import classes.Scenes.SceneLib;

public class ProjectNightwalker extends Monster {
    override public function defeated(hpVictory:Boolean):void {
        SceneLib.dungeons.demonLab.afterNightwalkerFight();
    }

    override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void {
        SceneLib.dungeons.demonLab.BadEndExperiment();
    }
}

}