package classes.Items.Shields 
{
	import classes.Items.Shield;
	import classes.PerkLib;
	import classes.Player;

	public class SpiritFocus extends ShieldWithPerk
	{
		
		public function SpiritFocus() 
		{
			super("Spi Foc", "SpiritFocus", "spirit focus", "a spirit foci", 4, 800,
					"This small icon with a silk ribbon is inscribed with eldritch runes and reinforces a kitsune's power and magic. (+20% to Fox Fire dmg and lust dmg, +25% to magical soulskills power)",
					"Magic", PerkLib.WizardsFocus, 0.2, 0, 0, 0);
		}
	}
}