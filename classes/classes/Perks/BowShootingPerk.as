/**
 * Created by Ormael on 18.01.16.
 */
package classes.Perks
{
	import classes.PerkClass;
	import classes.PerkType;

	public class BowShootingPerk extends PerkType
	{

		override public function desc(params:PerkClass = null):String
		{
			if (!player || !params) return _desc;
			return "Reduces arrow shooting costs by " + params.value1 + "%.";
		}

		public function BowShootingPerk()
		{
			super("Bow Shooting","Bow Shooting", "Reduces cost of shooting arrows.");
		}
	}
}
