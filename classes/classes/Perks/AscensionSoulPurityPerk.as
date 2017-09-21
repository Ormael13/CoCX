/**
 * ...
 * @author Ormael
 */
package classes.Perks 
{
	import classes.PerkClass;
	import classes.PerkType;
	import classes.GlobalFlags.kGAMECLASS;
	
	public class AscensionSoulPurityPerk extends PerkType
	{
		
		override public function desc(params:PerkClass = null):String
		{
			return "(Rank: " + params.value1 + "/" + kGAMECLASS.charCreation.MAX_SOULPURITY_LEVEL + ") Increases maximum Soulforce by " + params.value1 * 50 + ".";
		}
		
		public function AscensionSoulPurityPerk() 
		{
			super("Ascension: Soul Purity", "Ascension: Soul Purity", "", "Increases maximum Soulforce by 50 per level.");
		}
		
		override public function keepOnAscension(respec:Boolean = false):Boolean 
		{
			return true;
		}
	}
}