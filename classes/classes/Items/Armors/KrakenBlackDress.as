package classes.Items.Armors 
{
	import classes.Items.Armor;
	import classes.Scenes.NPCs.CelessScene;
	import classes.Player;
	import classes.PerkLib;
	import classes.Player;
	import classes.StatusEffects;
	/**
	 * ...
	 * @author 
	 */
	public class KrakenBlackDress extends ArmorWithPerk
	{
		
		public function KrakenBlackDress()
		{
			super("K.B.Dress","K.B.Dress","Kraken Black Dress","a Kraken black dress",5,5,1000,
			"Due to its black rubber like texture and triangular patterns that reveal skin every now and then, it's difficult to determine whether this item is a dress or a very slutty swimwear." +
					" Instead of the standard skirt or bikini panty the bottom is shaped in a sun like pattern made to cover each of a kraken tentacle joint properly up to tight level. " +
					"Sadly, due to the dress shape itself and the way it only seems to adhere to a scylla-kin skin, it is obvious a normal human would be unable to use it.","Light",
					PerkLib.KrakenBlackDress, 0,0,0,0, "Increase the duration of ink spray stun and blind by 1 round and empower all grappling moves.",false,false);
		}
		override public function canUse():Boolean{
			if (game.player.isKraken() || game.player.isScylla()){return true}
			outputText("You try to figure out how to wear this thing but your current body shape does not allow it. You put it back in your backpack for now.");
			return false;
		}
		
		override public function useText():void{
			outputText("You put the dress on and marvel as it adheres to your skin like a rubber glove. " +
					"The dress fits your body so well you have trouble figuring whether you are touching your own skin or the black rubber of the outfit.\n");
		}
	}

}