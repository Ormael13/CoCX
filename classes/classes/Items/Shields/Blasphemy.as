/**
 * ...
 * @author Zavos
 */
package classes.Items.Shields 
{
	import classes.Items.Shield;
	import classes.PerkLib;
	import classes.Player;

	public class Blasphemy extends ShieldWithPerk
	{
		
		public function Blasphemy() 
		{
			super("Blasphe", "Blasphemy", "Blasphemy", "a Blasphemy", 1, 200, "Metal prayer beads, engraved with holy symbols of dead gods.", "Obsession", PerkLib.Obsession, 0.2, 0.15, 0, 0);
		}
		
	}

}