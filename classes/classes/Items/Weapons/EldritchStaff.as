/**
 * Created by aimozg on 10.01.14.
 */
package classes.Items.Weapons
{
	import classes.Items.Weapon;
	import classes.Items.WeaponLib;
	import classes.PerkLib;
	import classes.Player;

	public class EldritchStaff extends Weapon {
		
		public function EldritchStaff() {
			super("E.Staff", "E.Staff", "eldritch staff", "an eldritch staff", "thwack", 10, WeaponLib.DEFAULT_VALUE, "This eldritch staff once belonged to the Harpy Queen, who was killed after her defeat at your hands.  It fairly sizzles with magical power.", "Wizard's Focus");
		}
		
		override public function playerEquip():Weapon {
			while (game.player.findPerk(PerkLib.WizardsFocus) >= 0) game.player.removePerk(PerkLib.WizardsFocus);
			game.player.createPerk(PerkLib.WizardsFocus, 0.6, 0, 0, 0);
			return super.playerEquip();
		}
		
		override public function playerRemove():Weapon {
			while (game.player.findPerk(PerkLib.WizardsFocus) >= 0) game.player.removePerk(PerkLib.WizardsFocus);
			return super.playerRemove();
		}
		
/*
		override public function equipEffect(player:Player, output:Boolean):void
		{
			player.createPerk(PerkLib.WizardsFocus,.6,0,0,0);
		}
		
		override public function unequipEffect(player:Player, output:Boolean):void
		{
			player.removePerk(PerkLib.WizardsFocus);
		}
*/
	}
}
