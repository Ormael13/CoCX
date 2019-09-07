/**
 * ...
 * @author Ormael
 */
package classes.Perks 
{
	import classes.PerkClass;
	import classes.PerkType;
	import classes.CoC;
	
	public class AscensionSpiritualEnlightenmentPerk extends PerkType
	{
		
		override public function desc(params:PerkClass = null):String
		{
			return "(Rank: " + params.value1 + "/" + CoC.instance.charCreation.MAX_SPIRITUALENLIGHTENMENT_LEVEL + ") Increases soulskill effect multiplier by " + params.value1 * 10 + "% multiplicatively.";
		}

		public function AscensionSpiritualEnlightenmentPerk() 
		{
			super("Ascension: Spiritual Enlightenment", "Ascension: Spiritual Enlightenment", "", "Increases soulskill effect multiplier by 10% per level, multiplicatively.");
		}
		
		override public function keepOnAscension(respec:Boolean = false):Boolean 
		{
			return true;
		}		
	}

}