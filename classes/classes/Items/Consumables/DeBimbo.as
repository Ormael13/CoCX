/**
 * Created by aimozg on 10.01.14.
 */
package classes.Items.Consumables
{
	import classes.GlobalFlags.kGAMECLASS;
	import classes.Items.Consumable;
	import classes.Player;

	public final class DeBimbo extends Consumable
	{

		override public function get description():String
		{
			if (game.player.hasPerk("Bimbo Brains") >= 0 || game.player.hasPerk("Futa Faculties") >= 0)
				return "This should totally like, fix your brain and stuff.  You don't really think anything is wrong with your head - it feels all pink and giggly all the time.";
			else
				return "This draft is concocted from five scholar's teas and who knows what else.  Supposedly it will correct the stupifying effects of Bimbo Liqueur.";
		}


		override public function doEffect(player:Player,output:Boolean):void
		{
			kGAMECLASS.mutations.deBimbo(player);// TODO use output argument in mutations.deBimbo
		}

		public function DeBimbo()
		{
			super("Debimbo", "Debimbo", "a bottle marked as 'Debimbo'",250);
		}
	}
}
