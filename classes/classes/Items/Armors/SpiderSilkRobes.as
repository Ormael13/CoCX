/**
 * Created by aimozg on 16.01.14.
 */
package classes.Items.Armors
{
	import classes.Items.Armor;
	import classes.Player;

	public final class SpiderSilkRobes extends Armor
	{

		override public function equipEffect(player:Player, output:Boolean):void
		{
			if(player.hasPerk("Wizard's Endurance") < 0) player.createPerk("Wizard's Endurance",30,0,0,0,"Your spellcasting equipment makes it harder for spell-casting to fatigue you!");
		}

		override public function unequipEffect(player:Player, output:Boolean):void
		{
			while(player.hasPerk("Wizard's Endurance") >= 0) player.removePerk("Wizard's Endurance");
		}

		public function SpiderSilkRobes()
		{
			super("SS.Robe","SS.Robe","a spider-silk robes",6,950,"This robe looks incredibly comfortable.  It's made from alchemically enhanced spider-silk, and embroidered with what looks like magical glyphs around the sleeves and hood.","Light");
		}
	}
}
