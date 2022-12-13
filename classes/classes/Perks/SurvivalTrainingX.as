package classes.Perks 
{
import classes.PerkClass;
import classes.PerkType;
import classes.PerkLib;

public class SurvivalTrainingX extends PerkType
{
	
	override public function desc(params:PerkClass = null):String
	{
		if (!player || !params) return _desc;
		return "You have trained to better survive this realm hostile environment. (+1% to MaxOver HP, MaxOver Lust and Diehard each 3 lvl's up to +" + params.value1 * 10 + "%)";
	}

	override public function name(params:PerkClass=null):String {
        if (!player || !params) return _name;
        var sufval:String = player.perkv1(PerkLib.AscensionBuildingPrestigeX).toString();
        return "Survival Training (Rank: " + sufval + ")";
    }

    public function SurvivalTrainingX() 
	{
		super("Survival Training","Survival Training", ".");
	}
}
}
