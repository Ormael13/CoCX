/**
 * Created by aimozg on 10.01.14.
 */
package classes.Items.Weapons
{
	import classes.Items.Weapon;
	import classes.Items.WeaponLib;
	import classes.Player;

	public class EldritchStaff extends Weapon
	{

		override public function equipEffect(player:Player, output:Boolean):void
		{
			player.createPerk("Wizard's Focus",.6,0,0,0,"Your "+longName+" grants you additional focus, reducing the use of fatigue for spells.");
		}

		override public function unequipEffect(player:Player, output:Boolean):void
		{
			player.removePerk("Wizard's Focus");
		}

		public function EldritchStaff()
		{
			super("E.Staff","E.Staff","eldritch staff","an eldritch staff","thwack",10,WeaponLib.DEFAULT_VALUE,"This eldritch staff once belonged to the Harpy Queen, who was killed after her defeat at your hands.  It fairly sizzles with magical power.","Wizard's Focus");
		}
	}
}
