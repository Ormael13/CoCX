/**
 * Created by Ormael on 25.07.18.
 */
package classes.Perks
{
	import classes.PerkClass;
	import classes.PerkType;

	public class DemonSlayerPerk extends PerkType
	{

		override public function desc(params:PerkClass = null):String
		{
			if (!player || !params) return _desc;
			return "Deal " + params.value1 * 100 + "% more physical melee damage to True Demons type enemies. (Rank: " + params.value1 * 10 + ")";
		}

		public function DemonSlayerPerk()
		{
			super("Demon Slayer","Demon Slayer", "Deal more physical melee damage to True Demons type enemies.");
		}
	}
}
