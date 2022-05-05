/**
 * ...
 * @author Liadri
 */
package classes.Perks 
{
	import classes.PerkClass;
	import classes.MutationsLib;
	import classes.PerkType;

	public class StarSphereMasteryPerk extends PerkType
	{
		
		override public function desc(params:PerkClass = null):String
		{
			var fr:Number = 1;
			var sr:String = "";
			var mr:String = "";
			if (player.hasPerk(MutationsLib.KitsuneThyroidGlandEvolved)) sr = ", " + (params.value1 * 4) + " soulforce";
			if (player.hasPerk(MutationsLib.KitsuneParathyroidGlandsEvolved)) mr = ", " + (params.value1 * 3) + " mana";
			return "Regenerate " + (params.value1 * fr) + " fatigue"+sr+mr+" every round. Increase Fox Fire damage by " + (params.value1 * 5) + "%. (Rank: " + params.value1 + ")";
		}
		
		public function StarSphereMasteryPerk() 
		{
			super("Star Sphere Mastery", "Star Sphere Mastery",
					"You have mastered your control over the flow of energy in your star sphere. You are now able to recover fatigue, soulforce and mana over time.");
		}
		
	}

}