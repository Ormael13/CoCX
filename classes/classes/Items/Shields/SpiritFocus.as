package classes.Items.Shields
{
import classes.Items.Shield;

public class SpiritFocus extends Shield
	{
		
		public function SpiritFocus()
		{
			super("Spi Foc", "SpiritFocus", "spirit focus", "a spirit foci", 4, 800,
					"This small icon, tied with a silk ribbon and inscribed with eldritch runes, enhances a kitsune's power and magic. (+20% to Fox Fire dmg and lust dmg, +25% to magical soul skill power)",
					"Magic");
			withBuff('spellpower', +0.2);
		}
	}
}
