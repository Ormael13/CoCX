/**
 * ...
 * @author Zevos
 */
package classes.Items.Weapons 
{
	import classes.Items.Weapon;
	import classes.PerkLib;
	import classes.Player;

	public class EldritchRibbon extends WeaponWithPerk {
		
		public function EldritchRibbon() 
		{
			super("ERibbon", "ERibbon", "eldritch ribbon", "an eldritch ribbon", "whip-like slash", 5, 400, "A long ribbon made of fine silk that despite its seemingly fragile appearance can deal noticeable damage to several enemies at once.  It is inscribed with arcane runes, allowing it to facilitate spellcasting.", "Wizard's Focus, Whipping", PerkLib.WizardsFocus, 0.4, 0, 0, 0, "", "Ribbon");
		}
	}
}