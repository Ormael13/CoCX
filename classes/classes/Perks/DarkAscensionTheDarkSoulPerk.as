/**
 * ...
 * @author Liadri
 */
package classes.Perks
{
	import classes.PerkClass;
	import classes.PerkType;
	import classes.CoC;
	
	public class DarkAscensionTheDarkSoulPerk extends PerkType
	{
		
		override public function desc(params:PerkClass = null):String
		{
			if (!player || !params) return _desc;
			return "(Rank: " + params.value1 + "/" + CoC.instance.charCreation.MAX_THE_DARK_SOUL + ") You have acquired permanent power from the many souls you consumed in your previous timelines. Raise core stats cap by " + params.value1 + "0.";
		}
		
		public function DarkAscensionTheDarkSoulPerk() 
		{
			super("Dark Ascension: The Dark Soul", "Dark Ascension: The Dark Soul", "", "You have acquired permanent power from the many souls you consumed in your previous timelines. Raise core stats cap by 10.");
		}
		
		override public function keepOnAscension(respec:Boolean = false):Boolean
		{
			return true;
		}
	}

}
