/**
 * Created by aimozg on 10.01.14.
 */
package classes.Items.Weapons
{
	import classes.Items.Weapon;
	import classes.Player;

	public class WizardsStaff extends Weapon
	{
		override public function equipEffect(player:Player, output:Boolean):void
		{
			player.createPerk("Wizard's Focus",.4,0,0,0,"Your "+longName+" grants you additional focus, reducing the use of fatigue for spells.");
		}

		override public function unequipEffect(player:Player, output:Boolean):void
		{
			player.removePerk("Wizard's Focus");
		}
		public function WizardsStaff()
		{
			super("W.Staff","W.Staff","wizard's staff","a wizard's staff","smack",3,350,"This staff is made of very old wood and seems to tingle to the touch.  The top has an odd zig-zag shape to it, and the wood is worn smooth from lots of use.  It probably belonged to a wizard at some point and would aid magic use. (ATK: 3)","Wizard's Focus");
		}
	}
}
