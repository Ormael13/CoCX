/**
 * @author Liadri
 */
package classes.Perks 
{
	import classes.PerkClass;
	import classes.PerkType;

	public class PurityElixirPerk extends PerkType
	{
		
		override public function desc(params:PerkClass = null):String
		{
			return "Minimum corruption reduced by " + params.value1 * 20 + " to a minimum of 0.";
		}
		
		public function PurityElixirPerk() 
		{
			super("Purity Elixir", "Purity Elixir",
					"Minimum corruption reduced by 20 to a minimum of 0.");
		}
	}
}