/**
 * ...
 * @author Ormael
 */
package classes.Items.WeaponsRange 
{
	import classes.Items.IELib;
	import classes.Items.WeaponRange;
	import classes.PerkLib;
	import classes.Player;
	
	public class TwinNailGun extends WeaponRange
	{
		
		public function TwinNailGun() 
		{
			super("NailGun2", "TwinNailGun", "Twin Nail Gun", "a Twin Nail Gun", "shot", 15, 1200, "With a white base and grey trims, those twin guns fires nails. Simple as that!", "Dual Firearms");
			withEffect(IELib.Bleed, 25);
		}
		
		override public function canEquip(doOutput:Boolean, slot:int):Boolean {
			if (game.player.hasPerk(PerkLib.DualWield) || game.player.hasPerk(PerkLib.AntyDexterity)) return super.canEquip(doOutput, slot);
			if (doOutput) outputText("You aren't skilled enough to handle this pair of firearms! (req. Dual Wield/Anty-Dexternity)  ");
			return false;
		}
	}
}
