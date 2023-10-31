/**
 * ...
 * @author Liadri
 */
package classes.Items.Weapons 
{
	import classes.Items.Weapon;
	import classes.Player;

	public class KarmicTouch extends Weapon
	{
		
		public function KarmicTouch() 
		{
			super("KarmTou", "KarmicTouch", "karmic gloves", "a pair of karmic gloves", "punch", 0, 400, "A pair of gauntlets, ordinary at first glance save by its immaculate appearance in shining metal and snow-white cloth.Their touch brings waste into the wicked flesh, punishing them in the form of blows more painful then should be.", "Stun50", WT_GAUNTLET);
			withBuffs({ 'psoulskillpower': +1.5 });
		}
		
		override public function canEquip(doOutput:Boolean):Boolean {
			if (game.player.level >= 54) return super.canEquip(doOutput);
			if (doOutput) outputText("You try and wield the legendary weapon but to your disapointment the item simply refuse to stay in your hands. It would seem you yet lack the power and right to wield this item.");
			return false;
		}
		
	}

}