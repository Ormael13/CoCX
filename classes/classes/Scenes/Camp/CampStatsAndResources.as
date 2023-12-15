package classes.Scenes.Camp {
import classes.BaseContent;
import classes.Saves;
import classes.internals.SaveableState;

public class CampStatsAndResources extends BaseContent implements SaveableState {
    //cabin stored resources
    public static var MetalPieces:Number;
    public static var MechanismResc:Number;
    public static var EnergyCoreResc:Number;
    public static var StonesResc:Number;
    public static var WoodResc:Number;
    public static var NailsResc:Number;

    public function CampStatsAndResources() {
        Saves.registerSaveableState(this);
    }

    public function stateObjectName():String {
        return "CampStatsAndResources";
    }

    public function resetState():void {
        MetalPieces = 0;
        MechanismResc = 0;
        EnergyCoreResc = 0;
        StonesResc = 0;
        WoodResc = 0;
        NailsResc = 0;
    }

    public function saveToObject():Object {
        return {
            "MetalPieces":MetalPieces,
            "MechanismResc":MechanismResc,
            "EnergyCoreResc":EnergyCoreResc,
            "StonesResc": StonesResc,
            "WoodResc":WoodResc,
            "NailsResc":NailsResc
        }
    }

    public function loadFromObject(o:Object, ignoreErrors:Boolean):void {
        if(o) {
            MetalPieces = o.MetalPieces;
            MechanismResc = o.MechanismResc;
            EnergyCoreResc = o.EnergyCoreResc;
            StonesResc = o.StonesResc;
            WoodResc = o.WoodResc;
            NailsResc = o.NailsResc;
        } else  {
            resetState();
        }
    }
}
}
