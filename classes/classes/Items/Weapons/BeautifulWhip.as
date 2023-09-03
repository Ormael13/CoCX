package classes.Items.Weapons 
{
	import classes.CoC_Settings;
	import classes.Creature;
	import classes.CoC;
	import classes.Items.Weapon;
	import classes.PerkLib;
	import classes.Player;

	public class BeautifulWhip extends Weapon {
		
		public function BeautifulWhip() 
		{
			super("B.Whip", "B.Whip", "beautiful whip", "a beautiful shining whip", "whipping", 5, 400, "This beautiful whip shines brilliantly in the light, showing the flawless craftsmanship.  The handle and transition knot are heavily decorated in gold and brass.  Some craftsman clearly poured his heart and soul into this whip.", "Whipping", "Whip");
			withBuffs({'teasedmg': 35});
		}
		
		override public function get attack():Number {
			var temp:int = 5 + (7 - game.player.cor / 4);
			if (temp < 3) temp = 3;
			if (game.player.hasPerk(PerkLib.ArcaneLash)) temp += 2;
			return temp;
		}
		
		override public function canEquip(doOutput:Boolean):Boolean {
			if (game.player.cor < (33 + game.player.corruptionTolerance)) return super.canEquip(doOutput);
			if (doOutput) outputText("You grab hold of the handle of the whip only to have it grow burning hot.  You're forced to let it go lest you burn yourself.  Something within the whip must be displeased.  ");
			return false;
		}
	}
}
