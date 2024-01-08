package classes.Perks 
{
import classes.PerkClass;
import classes.PerkType;
import classes.PerkLib;

public class AscensionSkyPoisonPearlMasteryX extends PerkType
{

    override public function desc(params:PerkClass = null):String {
        if (!player || !params) return _desc;
        var pVal:Number = (player.perkv1(PerkLib.AscensionSkyPoisonPearlMasteryStageX) * 4);
        return "Your gain " + pVal.toString() + " more stat points at each level up.";
    }

    override public function name(params:PerkClass=null):String {
        if (!player || !params) return _name;
        var sufval:String = player.perkv1(PerkLib.AscensionSkyPoisonPearlMasteryStageX).toString();
        return "Ascension: Sky Poison Pearl Mastery " + sufval;
    }

    public function AscensionSkyPoisonPearlMasteryX() 
	{
		super("Ascension Sky Poison Pearl Mastery", "Ascension: Sky Poison Pearl Mastery",
               ".");
	}

    override public function keepOnAscension(respec:Boolean = false):Boolean {
        return true;
    }
}
}
