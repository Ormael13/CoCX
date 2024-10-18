/**
 * Created by aimozg on 27.01.14.
 */
package classes.Perks
{
import classes.PerkClass;
import classes.PerkType;
import classes.PerkLib;

public class AscensionTrancendentGenMemX extends PerkType
{

    override public function desc(params:PerkClass = null):String {
        if (!player || !params) return _desc;
        var pVal:Number = player.perkv1(PerkLib.AscensionTrancendentalGeneticMemoryStageX);
        return "Your body has learned to retain up to " + (15*pVal).toString() + " metamorphic adaptations.";
    }

    override public function name(params:PerkClass=null):String {
        if (!player || !params) return _name;
        var sufval:String = player.perkv1(PerkLib.AscensionTrancendentalGeneticMemoryStageX).toString();
        return "Ascension: Transcendental Genetic Memory Rank " + sufval;
    }

    public function AscensionTrancendentGenMemX() {
        super("Ascension: Transcendental Genetic Memory Rank", "Ascension: Transcendental Genetic Memory Rank",
                ".");
    }

    override public function keepOnAscension(respec:Boolean = false):Boolean {
        return true;
    }
}
}
