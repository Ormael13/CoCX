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

/*
        public var wizardsMult = 0;
		//Implementation of TimeAwareInterface
        //Recalculate Wizard's multiplier every hour
		public function timeChange():Boolean
		{
			calcWizardsMult();
			return false;
		}
	
		public function timeChangeLarge():Boolean {
            calcWizardsMult();
			return false;
		}
		*/
		public function BeautifulStaff() 
		{
			super("B.Staff", "B.Staff", "beautiful staff", "a beautiful shining staff", "smack", 2, 160, "[0% is a visual-only issue] This beautiful staff shines brilliantly in the light, showing the flawless craftsmanship.  The pommel and guard are heavily decorated in gold and brass.  Some craftsman clearly poured his heart and soul into this staff.", "Staff, increases Spellpower depending on purity", PerkLib.WizardsFocus, 0, 0, 0, 0, "", "Staff");
            //EventParser.timeAwareClassAdd(this);
		}
		
		public function descExtra():String {
			var desc:String = "";
			desc += ", Wizard's Focus (+" + Math.floor(calcWizardsMult() * 100) + "% Spellpower)";
			return desc;
		}
		
		public function calcWizardsMult():Number {
			var desc:String = "";
			var multadd:Number = 0.4;
            if (game && game.player)
                multadd = (40 - game.player.cor) / 100;
			if (multadd < 0.1) multadd = 0.1;
			return multadd;
		}
		
		override public function get perk():String { 
            return "Staff" + descExtra();
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