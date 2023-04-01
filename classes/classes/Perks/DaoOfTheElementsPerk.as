/**
 * ...
 * @author Ormael
 */
package classes.Perks
{
	import classes.PerkClass;
	import classes.PerkType;
	import classes.CoC;
	
	public class DaoOfTheElementsPerk extends PerkType
	{
		override public function desc(params:PerkClass = null):String
		{
			if (!player || !params) return _desc;
			var descS:String = "Number and maximum rank of elementals you can command increases by " + params.value2 + ". Allows you to rank-up summoned elementals to rank " + params.value1 * 4 + ". You can now summon and command ether, wood, metal";
			if (params.value1 > 1) descS += ", ice, lightning, darkness";
			if (params.value1 > 2) descS += ", poison, purity, corruption";
			descS += " elementals. (Layer: " + params.value1 + ")";
            return descS;
		}
		
		public function DaoOfTheElementsPerk() 
		{
			super("Dao of the Elements", "Dao of the Elements",
					"Dao of the Elements is endless.");
		}
	}
}
