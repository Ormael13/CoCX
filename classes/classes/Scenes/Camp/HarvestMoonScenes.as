package classes.Scenes.Camp {
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.CoC;
import classes.Scenes.NPCs.*;
import classes.Scenes.SceneLib;
import classes.internals.SaveableState;

use namespace CoC;

public class HarvestMoonScenes extends BaseContent implements SaveableState {

    //This should be managed like a quest checking weekly for crops
    public static var harvestmoonstageHH:int;
    public static const HARVESTMOONNOTSTARTEDHH:int = 0;
    public static const HARVESTMOONPENDINGHH:int = 1;
    public static const HARVESTMOONPENDINGHH2:int = 2;
    public static const HARVESTMOONPENDINGHH3:int = 3;
    public static const HARVESTMOONPENDINGHH4:int = 4;
    public static const HARVESTMOONPENDINGHH5:int = 5;
    public static const HARVESTMOONPENDINGHH6:int = 6;
    public static const HARVESTMOONREADYHH:int = 7;

    public static var harvestmoonstageMG:int;
    public static const HARVESTMOONNOTSTARTEDMG:int = 0;
    public static const HARVESTMOONPENDINGMG:int = 1;
    public static const HARVESTMOONPENDINGMG2:int = 2;
    public static const HARVESTMOONPENDINGMG3:int = 3;
    public static const HARVESTMOONPENDINGMG4:int = 4;
    public static const HARVESTMOONPENDINGMG5:int = 5;
    public static const HARVESTMOONPENDINGMG6:int = 6;
    public static const HARVESTMOONREADYMG:int = 7;

    public static var harvestmoonstageSB:int;
    public static const HARVESTMOONNOTSTARTEDSB:int = 0;
    public static const HARVESTMOONPENDINGSB:int = 1;
    public static const HARVESTMOONPENDINGSB2:int = 2;
    public static const HARVESTMOONPENDINGSB3:int = 3;
    public static const HARVESTMOONPENDINGSB4:int = 4;
    public static const HARVESTMOONPENDINGSB5:int = 5;
    public static const HARVESTMOONPENDINGSB6:int = 6;
    public static const HARVESTMOONREADYSB:int = 7;

    public static var harvestmoonstageIW:int;
    public static const HARVESTMOONNOTSTARTEDIW:int = 0;
    public static const HARVESTMOONPENDINGIW:int = 1;
    public static const HARVESTMOONPENDINGIW2:int = 2;
    public static const HARVESTMOONPENDINGIW3:int = 3;
    public static const HARVESTMOONPENDINGIW4:int = 4;
    public static const HARVESTMOONPENDINGIW5:int = 5;
    public static const HARVESTMOONPENDINGIW6:int = 6;
    public static const HARVESTMOONREADYIW:int = 7;

    public static var harvestmoonstageBF:int;
    public static const HARVESTMOONNOTSTARTEDBF:int = 0;
    public static const HARVESTMOONPENDINGBF:int = 1;
    public static const HARVESTMOONPENDINGBF2:int = 2;
    public static const HARVESTMOONPENDINGBF3:int = 3;
    public static const HARVESTMOONPENDINGBF4:int = 4;
    public static const HARVESTMOONPENDINGBF5:int = 5;
    public static const HARVESTMOONPENDINGBF6:int = 6;
    public static const HARVESTMOONREADYBF:int = 7;

    public function stateObjectName():String {
        return "CampScenes";
    }

    public function resetState():void {
        harvestmoonstageHH = HARVESTMOONNOTSTARTEDHH;
        harvestmoonstageMG = HARVESTMOONNOTSTARTEDMG;
        harvestmoonstageSB = HARVESTMOONNOTSTARTEDSB;
        harvestmoonstageIW = HARVESTMOONNOTSTARTEDIW;
        harvestmoonstageBF = HARVESTMOONNOTSTARTEDBF;
    }

    public function saveToObject():Object {
        return {
            "stageHH": harvestmoonstageHH,
            "stageMG": harvestmoonstageMG,
            "stageSB": harvestmoonstageSB,
            "stageIW": harvestmoonstageIW,
            "stageBF": harvestmoonstageBF
        };
    }

    public function loadFromObject(o:Object, ignoreErrors:Boolean):void {
        if (o) {
            harvestmoonstageHH = o["stageHH"];
            harvestmoonstageMG = o["stageMG"];
            harvestmoonstageSB = o["stageSB"];
            harvestmoonstageIW = o["stageIW"];
            harvestmoonstageBF = o["stageBF"];
        } else {
            // loading from old save
            resetState();
        }
    }

    public function HarvestMoonScenes() {
        Saves.registerSaveableState(this);
    }
}
}
