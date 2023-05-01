/**
 * ...
 * @author Lady Aeducan
 */
package classes.Items.WeaponsRange 
{
	import classes.Items.WeaponRange;
	import classes.GlobalFlags.kFLAGS;
	
	public class BadOmen extends WeaponRange {
		
		public function BadOmen() 
		{
			super("BadOmen", "BadOmen", "Bad Omen", "a Bad Omen", "shot", 150, 7500, "A single 22mm, four-round revolver, the Bad Omen has even largest bullets than desert eagle. Its shots are deadly and precise through the gun has one hell of a recoil. Requires 200 strength to fully unleash it power.", "Pistol")
		}
		
		override public function get attack():Number{
			var boost:int = 0;
			var scal:Number = 10;
			if (game.player.str >= 200) {
				boost += 40;
				scal -= 3;
			}
			if (game.player.str >= 100) {
				boost += 40;
				scal -= 3;
			}
			if (game.player.str >= 50) {
				boost += 10;
				scal -= 2;
			}
			boost += Math.round(game.player.cor / scal);
			return (10 + boost);
		}
		
		override public function canEquip(doOutput:Boolean):Boolean {
			if (game.player.level >= 54) return super.canEquip(doOutput);
			if(doOutput) outputText("You try and wield the legendary firearm but to your disapointment the item simply refuse to stay in your hands. It would seem you yet lack the power and right to wield this item.");
			return false;
		}
		
	}

}