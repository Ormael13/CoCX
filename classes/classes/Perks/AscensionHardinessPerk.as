/**
 * ...
 * @author Ormael
 */
package classes.Perks 
{
	import classes.PerkClass;
	import classes.PerkType;
	import classes.CoC;
	
	public class AscensionHardinessPerk extends PerkType
	{
		
		override public function desc(params:PerkClass = null):String
		{
			return "(Rank: " + params.value1 + "/" + CoC.instance.charCreation.MAX_HARDINESS_LEVEL + ") Increases maximum HP by " + params.value1 * 400 + ".";
		}
		
		public function AscensionHardinessPerk() 
		{
			super("Ascension: Hardiness", "Ascension: Hardiness", "", "Increases maximum HP by 400 per level.");
		}
		
		override public function keepOnAscension(respec:Boolean = false):Boolean 
		{
			return true;
		}
	}

}