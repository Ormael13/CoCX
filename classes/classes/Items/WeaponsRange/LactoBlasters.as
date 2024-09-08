/**
 * ...
 * @author Liadri
 */
package classes.Items.WeaponsRange
{
	import classes.Items.WeaponRange;
	import classes.PerkLib;
	import classes.Player;
	import classes.Scenes.API.FnHelpers;
	
	public class LactoBlasters extends WeaponRange {
		
		public function LactoBlasters()
		{
			super("LactoBlaster", "LactoBlaster", "Lactoblaster", "a LactoBlaster", "shot", 1, 1000, "Both a sex toy and a weapon the Lactoblaster uses one most unconventionnal ammunition, breast milks. Invented to take advantage of lacta bovine near endless supply of milk, this setup consists of two machine guns linked to a massive tank to be strapped on the users back and a harness with two milkers. The gun is only as strong as the user's milk production and since the weapon seldom constantly milk the lacta bovine it will never need to satisfy its milking needs. As expected this setup is quite heavy and only a very strong individual or a lacta bovine could use it.", "Dual Firearms");
		}
		
		override public function canEquip(doOutput:Boolean, slot:int):Boolean {
			if (game.player.hasPerk(PerkLib.DualWield) && game.player.str >= 100 && game.player.biggestTitSize() > 4) return super.canEquip(doOutput, slot);
			if (doOutput) {
				if (!game.player.hasPerk(PerkLib.DualWield)) outputText("You have yet to master the art of dual wielding! ");
				if (game.player.str < 100) outputText("This setup is to heavy for you to wield! ");
				if (game.player.biggestTitSize() < 4) outputText("You lack the 'assets' to use this weapon. ");
			}
			return false;
		}
		
		override public function get attack():Number {
			var lactoatk:Number = (1 + (game.player.lactationQ() / 100));
			lactoatk = FnHelpers.FN.logScale(lactoatk,LactoblastersABC,10);
			return lactoatk;
		}
		
		private static const LactoblastersABC:Object = FnHelpers.FN.buildLogScaleABC(10,100,1000,10,100);
	}
}