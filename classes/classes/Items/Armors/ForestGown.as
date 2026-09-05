/**
 * forest gown that has a slow progression to a dryad
 * @author imported from Revamp/UEE
 */
package classes.Items.Armors
{
	import classes.Items.Armor;
	import classes.CoC;

	public class ForestGown extends Armor
	{
		public function ForestGown():void
		{
			super("FrsGown","FrsGown","forest gown","a forest gown",1,1,25,"This the very earthy gown commonly worn by dryads. It is made from a mixture of plants. The predominate fabric looks like a weave of fresh grass. It is decorated by simple flowers that are attached to it. Strangely, everything seems alive like it was still planted. There must be some peculiar magic at work here.","Light");
		}

		override public function equipText():void
		{
			if (CoC.instance.player.gender == 2) outputText("You comfortably slide into the forest gown. You spin around several times and giggle happily. Where did that come from?\n\n");
			if (CoC.instance.player.gender == 1) outputText("You slide forest gown over your head and down to your toes. It obviously would fit someone more female. You feel sad and wish you had the svelte body that would look amazing in this gown. Wait, did you always think that way?\n\n");
			if (CoC.instance.player.gender != 1 && CoC.instance.player.gender != 2) outputText("You slide the gown over your head and slip it into place.\n\n");
			if (CoC.instance.player.hasCock()) outputText("You notice the bulge from [cock] in the folds of the dress and wish it wasn't there.\n\n");
		}
	}
}