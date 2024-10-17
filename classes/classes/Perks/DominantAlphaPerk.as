/**
 * Created by Ormael on 25.07.18.
 */
package classes.Perks
{
	import classes.PerkClass;
	import classes.PerkType;

	public class DominantAlphaPerk extends PerkType
	{

		override public function desc(params:PerkClass = null):String
		{
			if (!player || !params) return _desc;
			return "Increases your might by "+params.value1*2+"% based on the number of slaves and submissive followers and lovers you lord upon. " +
					"Raping opponents gives you a temporary surge of strength ("+params.value2+")lasting ("+params.value3+") hours.";
		}

		public function DominantAlphaPerk()
		{
			super("Dominant Alpha", "Dominant Alpha", "Increase your might based on the number of slaves and submissive followers and lovers you lord upon. Raping opponents gives you a temporary surge of strength that lasts a few hours.");
		}
	}
}
