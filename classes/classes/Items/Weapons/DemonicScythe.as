/**
 * ...
 * @author ...
 */
package classes.Items.Weapons 
{
	import classes.Items.Weapon;
	import classes.PerkLib;
	import classes.Player;

	public class DemonicScythe extends WeaponWithPerk
	{
		
		public function DemonicScythe() 
		{
			super("DemScyt","D.Scythe","demonic scythe","a demonic scythe","slash",25,2000,"A magic catalyst of unknown origin ornamented with a blade mounted on a skull. This magical scythe is both charged with powerful energy and extremely sharp. The letters A.S are engraved in the weapon.", "Large, Whirlwind", PerkLib.WizardsFocus, 1, 0, 0, 0,"", "Scythe, StaffPart");
		}
		
		override public function get verb():String { 
			return game.player.hasPerk(PerkLib.StaffChanneling) ? "shoot magic bolt" : "slash";
		}
		
		override public function get attack():Number{
			return 20 + (game.player.cor / 20);
		}
		
	}

}