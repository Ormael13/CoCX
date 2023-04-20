/**
 * ...
 * @author ...
 */
package classes.Items.Weapons
{
	import classes.Items.Weapon;

	public class DemonicScythe extends Weapon
	{
		
		public function DemonicScythe()
		{
			super("DemScyt","D.Scythe","demonic scythe","a demonic scythe","slash",25,4000,"A magic catalyst of unknown origin ornamented with a blade mounted on a skull. This magical scythe is both charged with powerful energy and extremely sharp. The letters A.S are engraved in the weapon.", "Large, Whirlwind, Bleed10", "Scythe, StaffPart");
			withBuff('spellpower', +1.0);
		}
		
		override public function get attack():Number{
			return 20 + (game.player.cor / 20);
		}
		
	}

}
