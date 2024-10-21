/**
 * Created by aimozg on 27.01.14.
 */
package classes.Perks
{
import classes.PerkClass;
import classes.PerkType;
import classes.PerkLib;

public class AscensionTrancendentGenMemExX extends PerkType
{

    override public function desc(params:PerkClass = null):String {
        if (!player || !params) return _desc;
        var pVal:Number = player.perkv1(PerkLib.AscensionTrancendentalGeneticMemoryExStageX);
        return "Your body capacity to retain metamorphic adaptations increased by " + (pVal+1) + " times.";
    }

    override public function name(params:PerkClass=null):String {
        if (!player || !params) return _name;
        var sufval:String = player.perkv1(PerkLib.AscensionTrancendentalGeneticMemoryExStageX).toString();
        return "Ascension: Transcendental Genetic Memory (Ex) Rank " + sufval;
    }

    public function AscensionTrancendentGenMemExX() {
        super("Ascension: Transcendental Genetic Memory (Ex) Rank", "Ascension: Transcendental Genetic Memory (Ex) Rank",
                ".");
    }

    override public function keepOnAscension(respec:Boolean = false):Boolean {
        return true;
    }
}
}
