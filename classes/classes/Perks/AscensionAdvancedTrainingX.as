/**
 * Created by aimozg on 27.01.14.
 */
package classes.Perks
{
import classes.PerkClass;
import classes.PerkType;
import classes.PerkLib;

public class AscensionAdvancedTrainingX extends PerkType
{

    override public function desc(params:PerkClass = null):String {
        if (!player || !params) return _desc;
        var pVal:Number = (player.perkv1(PerkLib.AscensionAdvTrainingX) * 4);
        return "Your gain " + pVal.toString() + " more stat points at each level up.";
    }

    override public function name(params:PerkClass=null):String {
        if (!player || !params) return _name;
        var sufval:String = player.perkv1(PerkLib.AscensionAdvTrainingX).toString();
        return "Ascension: Advanced Training " + sufval;
    }

    public function AscensionAdvancedTrainingX() {
		super("Ascension Advanced Training", "Ascension: Advanced Training",
                ".");
	}

    override public function keepOnAscension(respec:Boolean = false):Boolean {
        return true;
    }
}
}
