/**
 * ...
 * @author Liadri
 */
package classes.Perks
{
import classes.IMutations.IMutationsLib;
import classes.PerkClass;
import classes.PerkType;

	public class StarSphereMasteryPerk extends PerkType
	{
		
		override public function desc(params:PerkClass = null):String
		{
			if (!player || !params) return _desc;
			var fr:Number = 1;
			var sr:String = "";
			var mr:String = "";
			if (player.perkv1(IMutationsLib.KitsuneParathyroidGlandsIM) >= 3) mr = ", " + (params.value1 * 4) + " soulforce, " + (params.value1 * 3) + " mana";
			return "Regenerate " + (params.value1 * fr) + " fatigue"+sr+mr+" every round. Increase Fox Fire damage by " + (params.value1 * 5) + "%. (Rank: " + params.value1 + ")";
		}
		
		public function StarSphereMasteryPerk()
		{
			super("Star Sphere Mastery", "Star Sphere Mastery",
					"You have mastered control over the flow of energy in your star sphere. Allowing you to recover fatigue, soulforce, and mana over time.");
		}
		
	}

}
