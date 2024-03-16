/**
 * Created by aimozg on 27.01.14.
 */
package classes.Perks
{
import classes.PerkClass;
import classes.PerkType;
import classes.PerkLib;

public class AscensionBuildPrestigeX extends PerkType
{

    override public function desc(params:PerkClass = null):String {
        if (!player || !params) return _desc;
        var pVal:Number = player.perkv1(PerkLib.AscensionBuildingPrestigeX) + 1;
        return "Your understanding of prestige jobs from your previous life allows you to pick another " + pVal.toString() + " job" + (pVal > 1 ? "s":"") +" at lvl 54+.";
    }

    override public function name(params:PerkClass=null):String {
        if (!player || !params) return _name;
        var sufval:String = player.perkv1(PerkLib.AscensionBuildingPrestigeX).toString();
        return "Ascension: Building Prestige Stage " + sufval;
    }

    public function AscensionBuildPrestigeX() {
        super("Ascension Building Prestige Stage", "Ascension: Building Prestige Stage",
                ".");
    }

    override public function keepOnAscension(respec:Boolean = false):Boolean {
        return true;
    }
}
}
