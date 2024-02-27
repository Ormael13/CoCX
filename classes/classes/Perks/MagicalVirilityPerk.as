/**
 * Created by Ormael on 18.01.16.
 */
package classes.Perks
{
	import classes.PerkClass;
	import classes.PerkType;

	public class MagicalVirilityPerk extends PerkType
	{

		override public function desc(params:PerkClass = null):String
		{
			if (!player || !params) return _desc;
			return "" + (200 + (params.value1 * 100)) + " mLs more cum per orgasm and enhanced virility.";
		}

		public function MagicalVirilityPerk()
		{
			super("Magical Virility","Magical Virility", "200 mLs more cum per orgasm and enhanced virility.");
		}
	}
}
