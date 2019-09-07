/**
 * Created by aimozg on 27.01.14.
 */
package classes.Perks
{
	import classes.PerkClass;
	import classes.PerkType;

	public class SpellcastingAffinityPerk extends PerkType
	{

		override public function desc(params:PerkClass = null):String
		{
			return "Reduces spell costs by " + params.value1 + "%.";
		}

		public function SpellcastingAffinityPerk()
		{
			super("Spellcasting Affinity","Spellcasting Affinity", "Reduces spell costs.");
		}
	}
}
