/**
 * Created by Demojay on 24.12.23.
 */
package classes.Perks
{
import classes.PerkClass;
import classes.PerkType;
import classes.PerkLib;

public class AscensionHerosBirthrightX extends PerkType
{

    override public function desc(params:PerkClass = null):String {
        if (!player) return _desc;
        var pVal:Number = player.perkv1(PerkLib.AscensionHerosBirthrightRankX);
        if (pVal < 6)
            return "The level needed to use legendary items has been reduced by " + (9 * pVal).toString() + ", making the minimum level " + (54 - (9 * pVal)).toString() + ".";
        else   
            return "There is no longer a minimum level needed to use legendary items.";
    }
    
    override public function name(params:PerkClass=null):String {
        if (!player) return _name;
        var sufval:String = player.perkv1(PerkLib.AscensionHerosBirthrightRankX).toString();
        return "Ascension: Hero's Birthright " + sufval;
    }

    public function AscensionHerosBirthrightX() {
        super("Ascension Hero's Birthright", "Ascension: Hero's Birthright",
                ".");
    }

    override public function keepOnAscension(respec:Boolean = false):Boolean {
        return true;
    }
}
}
