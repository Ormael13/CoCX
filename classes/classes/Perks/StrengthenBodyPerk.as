/**
 * ...
 * @author Liadri
 */
package classes.Perks 
{
	import classes.PerkClass;
	import classes.PerkType;
	import classes.CoC;
	
	public class StrengthenBodyPerk extends PerkType
	{
		
		override public function desc(params:PerkClass = null):String
		{
			if (!player || !params) return _desc;
			return "(Rank: " + params.value1 + ") Consume the stored energy of souls to increase your strength, toughness, and speed by " + params.value1 * 5 + "% permanently. This change persists through time.";
		}
		
		public function StrengthenBodyPerk()
		{
			super("Strengthen Body", "Strengthen Body", "", "Consume the stored energy of souls to increase your strength, toughness, and speed by 5% permanently. This change persists through time.");
		}
		
		override public function keepOnAscension(respec:Boolean = false):Boolean
		{
			return true;
		}
	}
}
