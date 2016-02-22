/**
 * Created by aimozg on 27.01.14.
 */
package classes.Perks
{
	import classes.PerkClass;
	import classes.PerkType;

	public class ElvenBountyPerk extends PerkType
	{

		override public function desc(params:PerkClass = null):String
		{
			return "Increases fertility by " + params.value2 + "% and cum production by " + params.value1 + "mLs.";
		}

		public function ElvenBountyPerk()
		{
			super("Elven Bounty", "Elven Bounty", "After your encounter with an elf, her magic has left you with increased fertility and virility.", null, true);
		}
	}
}
