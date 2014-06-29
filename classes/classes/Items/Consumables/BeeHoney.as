/**
 * Created by K.Quesom 11.06.14
 */
package classes.Items.Consumables
{
    import classes.Player;

    public class BeeHoney extends SimpleConsumable
    {
        private const PURE_HONEY_VALUE:int = 40;

        private function beeHoneyEffect(player:Player):void
        {
			game.mutations.pureHoney(_value == PURE_HONEY_VALUE, player);
        }

        public function BeeHoney(pure:Boolean)
        {
			var honeyName:String = (pure ? "PurHony" : "BeeHony");
			var honeyLong:String = (pure ? "a crystal vial filled with glittering honey" : "a small vial filled with giant-bee honey");
			var honeyDesc:String = "This fine crystal vial is filled with a thick amber liquid that glitters" + (pure ? " " : " dully ") + "in the light.  You can smell a sweet scent, even though it is tightly corked.";
			super(honeyName, honeyName, honeyLong, beeHoneyEffect, (pure ? PURE_HONEY_VALUE : 3), honeyDesc);
        }
    }
}
