package classes.Scenes.Dungeons {
import classes.EventParser;
import classes.GlobalFlags.kFLAGS;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Races;
import classes.Saves;
import classes.Scenes.NPCs.DivaScene;
import classes.Scenes.NPCs.TyrantiaFollower;
import classes.Scenes.SceneLib;
import classes.StatusEffects;
import classes.internals.SaveableState;

public class DemonLab extends DungeonAbstractContent implements SaveableState {
    public static var PharaohState:int; //0 for unseen, 1 for friendly, 2 for destroyed, 3 if you've been given the puzzle
    public static var MagicTalkedState:int; //0 for not talked, 1 for 

    public function resetState():void {
        
    }

    public function stateObjectName():String {
        return "AncientPyramid";
    }

    public function saveToObject():Object {
        return {
            
        }
    }

    public function loadFromObject(o:Object, ignoreErrors:Boolean):void {
        if (o) {
            variable = o ["variable"];
            
        } else {
            // loading from old save
            resetState();
        }
    }
}
}