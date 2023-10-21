/**
 * ...
 * @author Liadri
 */
package classes.Items.Weapons 
{
	import classes.Items.Weapon;
	import classes.Player;

	public class YamaRajaGrasp extends Weapon
	{
		
		public function YamaRajaGrasp() 
		{
			super("YamaRG", "YamaRajaGrasp", "Yama-Raja gloves", "a pair of Yama-Raja gloves", "punch", 0, 1600, "These black gloves are made in black leather and an ebony alloy. Their corrupt touch seeks to destroy the pure and innocent. As such, it will seek the weak points of its victims when striking.", "", WT_GAUNTLET);
			withBuffs({ 'psoulskillpower': +1.5 });
		}
		
		override public function canEquip(doOutput:Boolean):Boolean {
			if (game.player.level >= 54) return super.canEquip(doOutput);
			if (doOutput) outputText("You try and wield the legendary weapon but to your disapointment the item simply refuse to stay in your hands. It would seem you yet lack the power and right to wield this item.");
			return false;
		}
		
	}

}