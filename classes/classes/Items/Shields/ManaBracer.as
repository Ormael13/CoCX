package classes.Items.Shields 
{
	import classes.Items.Shield;
	import classes.PerkLib;
	import classes.Player;

	public class ManaBracer extends ShieldWithPerk
	{
		
		public function ManaBracer() 
		{
			super("MaBrace", "ManaBracer", "mana bracer", "a mana bracer", 2, 200,
					"Runed bracers such as this are popular amongst mages that can afford them. This silver bracer augments a mage’s spell power while leaving the hand open to make gestures used in spellcasting.",
					"Magic", PerkLib.WizardsFocus, 0.5, 0, 0, 0);
		}
	}
}