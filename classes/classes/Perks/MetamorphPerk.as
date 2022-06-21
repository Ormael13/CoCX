/**
 * Created by Ormael
 */
package classes.Perks
{
	import classes.PerkClass;
	import classes.PerkType;

	public class MetamorphPerk extends PerkType
	{
		
		override public function desc(params:PerkClass = null):String
		{
			if (!player || !params) return _desc;
			return "Mold your own body using genetic memory and soulforce. (+" + (1 + params.value1) * 50 + " soulforce)";
		}
		
		public function MetamorphPerk()
		{
			super("Metamorph", "Metamorph",
				"Mold your own body using genetic memory and soulforce.",
				"You choose the 'Metamorph' perk, giving you a chance to mold your own body.");
		}
	}
}
