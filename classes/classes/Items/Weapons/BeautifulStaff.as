/**
 * Created by ormael on 19.05.19.
 */
package classes.Items.Weapons 
{
	import classes.CoC_Settings;
	import classes.Creature;
	import classes.CoC;
	import classes.Items.Weapon;
	import classes.PerkLib;
	import classes.Player;

	public class BeautifulStaff extends WeaponWithPerk {
		
		public function BeautifulStaff() 
		{
			super("B.Staff", "B.Staff", "beautiful staff", "a beautiful shining staff", "smack", 2, 160, "This beautiful staff shines brilliantly in the light, showing the flawless craftsmanship.  The pommel and guard are heavily decorated in gold and brass.  Some craftsman clearly poured his heart and soul into this staff.", "Staff" + descExtra, PerkLib.WizardsFocus, 0, 0, 0, 0, "", "Staff");
		}
		
		public function descExtra():String {
			var desc:String = "";
			var temp:int = 40 - game.player.cor;
			if (temp < 10) temp = 10;
			desc += ", Wizard's Focus (+" + temp + "% Spellpower)";
			return desc;
		}
		
		override public function get verb():String { 
			return game.player.hasPerk(PerkLib.StaffChanneling) ? "shot" : "smack";
		}
		
		override public function canUse():Boolean {
			if (game.player.cor < (33 + game.player.corruptionTolerance())) return super.canUse();
			outputText("You grab hold of the handle of the staff only to have it grow burning hot.  You're forced to let it go lest you burn yourself.  Something within the staff must be displeased.  ");
			return false;
		}
	}
}