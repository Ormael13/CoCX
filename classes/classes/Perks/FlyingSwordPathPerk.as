/**
 * ...
 * @author Ormael
 */
package classes.Perks 
{
import classes.PerkClass;
import classes.PerkType;

	public class FlyingSwordPathPerk extends PerkType
	{
		
		override public function desc(params:PerkClass = null):String
		{
			if (!player || !params) return _desc;
			return "Allows you to control flying swords. By spending enough soulforce, you can even fly on them. (Rank: " + params.value1 + ")";
		}
		
		public function FlyingSwordPathPerk() 
		{
			super("Flying Sword Path", "Flying Sword Path",
					"Allows you to control flying swords. By spending enough soulforce, you can even fly on them.");
		}
		
	}

}
