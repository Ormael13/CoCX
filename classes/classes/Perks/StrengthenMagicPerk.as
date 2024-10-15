/**
 * ...
 * @author Liadri
 */
package classes.Perks 
{
	import classes.PerkClass;
	import classes.PerkType;
	import classes.CoC;
	
	public class StrengthenMagicPerk extends PerkType
	{
		
		override public function desc(params:PerkClass = null):String
		{
			if (!player || !params) return _desc;
			return "(Rank: " + params.value1 + ") Consume the stored energy of souls to increase your intelligence, wisdom, and libido by " + params.value1 * 5 + "% permanently. This change persists through time.";
		}
		
		public function StrengthenMagicPerk()
		{
			super("Strengthen Magic", "Strengthen Magic", "", "Consume the stored energy of souls to increase your intelligence, wisdom, and libido by 5% permanently. This change persists through time.");
		}
		
		override public function keepOnAscension(respec:Boolean = false):Boolean
		{
			return true;
		}
	}
}
