/**
 * Created by Ormael
 */
package classes.Perks
{
	import classes.PerkClass;
	import classes.PerkType;

	public class MetamorphExPerk extends PerkType
	{
		
		override public function desc(params:PerkClass = null):String
		{
			if (!player || !params) return _desc;
			return "Mold your own body even further than before using genetic memory and soulforce: cock types, ball count, pussy types, and breast row count. (+" + params.value1 * 100 + " soulforce)";
		}
		
		public function MetamorphExPerk()
		{
			super("Metamorph (Ex)", "Metamorph (Ex)",
				"Mold your own body even further than before using genetic memory and soulforce. (cock types, ball count, pussy types, breast rows count)",
				"You've chosen the 'Metamorph (Ex)' perk, giving you more options to mold your own body. (cock types, ball count, pussy types, breast row count)");
		}
	}
}
