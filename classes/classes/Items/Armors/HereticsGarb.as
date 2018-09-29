/**
 * ...
 * @author Zavos
 */
package classes.Items.Armors 
{
	import classes.Items.Armor;
	import classes.Items.ArmorLib;
	import classes.PerkLib;
	
	public class HereticsGarb extends ArmorWithPerk
	{
		
		public function HereticsGarb() 
		{
			super("H. Garb","Heretic‘s Garb","Heretic‘s Garb","an Heretic‘s Garb",0,6,480,"Weathered traveling clothes, covered by a duster.  Wards and arcane glyphs inscribed in the duster facilitates magic while providing significant defense.  A feather tipped trilby completes the look.","Light", PerkLib.WizardsAndDaoistsEndurance, 10, 10, 0, 0, "", true, true);
		}
		
	}

}