package classes.Perks 
{
import classes.PerkClass;
import classes.PerkType;
import classes.PerkLib;

public class SurvivalTrainingXPerk extends PerkType
{
	
	override public function desc(params:PerkClass = null):String
	{
		if (!player || !params) return _desc;
		return "You have trained to better survive this realm's hostile environment. (+1% to MaxOver HP, MaxOver Lust and Diehard every 3 levels up to +" + params.value1 * 10 + "%)";
	}

	override public function name(params:PerkClass=null):String {
        if (!player || !params) return _name;
        var sufval:String = player.perkv1(PerkLib.SPSurvivalTrainingX).toString();
        return "Survival Training (Rank: " + sufval + ")";
    }

    public function SurvivalTrainingXPerk() 
	{
		super("Survival Training","Survival Training", ".");
	}
}
}
