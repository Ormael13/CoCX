package classes.Scenes.Camp {
import classes.BaseContent;
import classes.Saves;
import classes.internals.SaveableState;

public class CampStatsAndResources extends BaseContent implements SaveableState {
    public static var MetalPieces:Number;
    public static var StonesResc:Number;
    public static var WoodResc:Number;
    public static var NailsResc:Number;
    public static var CabinProgress:Number;
    public static var CabinBuilt:Boolean;
    public static var MaterialsStorageUpgradeStat:Number;

    public function CampStatsAndResources() {
        Saves.registerSaveableState(this);
    }

    public function stateObjectName():String {
        return "CampStatsAndResources";
    }

    public function resetState():void {
        MetalPieces = 0;
        StonesResc = 0;
        WoodResc = 0;
        NailsResc = 0;
        CabinProgress = 0;
        CabinBuilt = false;
        MaterialsStorageUpgradeStat = 0;
    }

    public function saveToObject():Object {
        return {
            "MetalPieces":MetalPieces,
            "StonesResc": StonesResc,
            "WoodResc":WoodResc,
            "NailsResc":NailsResc,
            "CabinProgress":CabinProgress,
            "CabinBuilt":CabinBuilt,
            "MaterialsStorageUpgradeStat":MaterialsStorageUpgradeStat,
        }
    }

    public function loadFromObject(o:Object, ignoreErrors:Boolean):void {
        if(o) {
            MetalPieces = o.MetalPieces;
            StonesResc = o.StonesResc;
            WoodResc = o.WoodResc;
            NailsResc = o.NailsResc;
            CabinProgress = o.CabinProgress;
            CabinBuilt = o.CabinBuilt;
            MaterialsStorageUpgradeStat = o.MaterialsStorageUpgradeStat;
        } else  {
            resetState();
        }
    }
}
}
