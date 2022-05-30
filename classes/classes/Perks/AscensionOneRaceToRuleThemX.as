/**
 * Created by aimozg on 27.01.14.
 */
package classes.Perks
{
import classes.PerkClass;
import classes.PerkType;
import classes.PerkLib;

public class AscensionOneRaceToRuleThemX extends PerkType
{

    override public function desc(params:PerkClass = null):String {
        var pVal:Number = player.perkv1(PerkLib.AscensionOneRaceToRuleThemAllX);
        return "Your racial paragon boost is increased. +" + (2*pVal).toString() + " to each stat per level and increase racial skill power by " + (25*pVal).toString() + "%.";
    }

    override public function name(params:PerkClass=null):String {
        var sufval:String = player.perkv1(PerkLib.AscensionOneRaceToRuleThemAllX).toString();
        return "Ascension: One Race To Rule Them All " + sufval;
    }

    public function AscensionOneRaceToRuleThemX() {
        super("Ascension One Race To Rule Them All", "Ascension One Race To Rule Them All",
                ".");
    }

    override public function keepOnAscension(respec:Boolean = false):Boolean {
        return true;
    }
}
}