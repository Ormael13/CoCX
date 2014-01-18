/**
 * Created by aimozg on 10.01.14.
 */
package classes.Items.Weapons
{
	import classes.GlobalFlags.kFLAGS;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.Items.Weapon;
	import classes.Player;

	public class DragonShellShield extends Weapon
	{

		override public function equipEffect(player:Player, output:Boolean):void
		{
			if(kGAMECLASS.flags[kFLAGS.TIMES_EQUIPPED_EMBER_SHIELD] == 0) {
				if (output){
					clearOutput();
					outputText("Turning the sturdy shield over in inspection, you satisfy yourself as to its craftsmanship and adjust the straps to fit your arm snugly.  You try a few practice swings, but find yourself overbalancing at each one due to the deceptive lightness of the material.  Eventually, though, you pick up the knack of putting enough weight behind it to speed it through the air while thrusting a leg forward to stabilize yourself, and try bashing a nearby rock with it.  You smile with glee as ");
					if(player.str < 80) outputText("bits and pieces from the surface of the");
					else outputText("huge shards of the shattered");
					outputText(" rock are sent flying in all directions.");
					outputText("\n\nAfter a few more practice bashes and shifts to acquaint yourself with its weight, you think you're ready to try facing an enemy with your new protection.  One last thing... taking off the shield and turning it straps-down, you spit onto the surface.  Satisfyingly, the liquid disappears into the shell as soon as it touches.");
				}
			}
			kGAMECLASS.flags[kFLAGS.TIMES_EQUIPPED_EMBER_SHIELD]++;
		}

		public function DragonShellShield()
		{
			super("DrgnShl","DrgnShl","dragon-shell shield","a dragon-shell shield","smack",0,1500,"A durable shield that has been forged from the remains of the dragon egg you found in the swamp. Absorbs any fluid attacks you can catch, rendering them useless.","Large");
		}
	}
}
