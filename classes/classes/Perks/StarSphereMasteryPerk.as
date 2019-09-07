/**
 * ...
 * @author Liadri
 */
package classes.Perks 
{
	import classes.PerkClass;
	import classes.PerkLib;
	import classes.PerkType;

	public class StarSphereMasteryPerk extends PerkType
	{
		
		override public function desc(params:PerkClass = null):String
		{
			if (player.hasPerk(PerkLib.KitsuneThyroidGlandFinalForm)) return "Regenerate " + params.value1 + " fatigue, " + (params.value1 * 2) + " soulforce and " + (params.value1 * 2) + " mana every round. Increase Fox Fire damage by " + (params.value1 * 5) + "%. (Rank: " + params.value1 + ")";
			else return "Regenerate " + params.value1 + " fatigue every round and increase Fox Fire damage by " + (params.value1 * 5) + "%. (Rank: " + params.value1 + ")";
		}
		
		public function StarSphereMasteryPerk() 
		{
			super("Star Sphere Mastery", "Star Sphere Mastery",
					"You have mastered your control over the flow of energy in your star sphere. You are now able to recover fatigue, soulforce and mana over time.");
		}
		
	}

}