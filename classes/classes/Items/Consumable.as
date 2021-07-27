/**
 * Created by aimozg on 09.01.14.
 */
package classes.Items
{
import classes.CoC;
import classes.DefaultDict;
import classes.EngineCore;
import classes.GlobalFlags.*;
import classes.Player;
import classes.Scenes.Camp;
import classes.Scenes.Places.Prison;
import classes.Scenes.SceneLib;
import classes.internals.Utils;

/**
	 * An item, that is consumed by player, and disappears after use. Direct subclasses should override "doEffect" method
	 * and NOT "useItem" method.
	 */
	public class Consumable extends Useable
	{

    protected function get mutations():Mutations { return CoC.instance.mutations; }
		protected function get changes():int { return mutations.changes; }
		protected function set changes(val:int):void { mutations.changes = val; }
		protected function get changeLimit():int { return mutations.changeLimit; }
		protected function set changeLimit(val:int):void { mutations.changeLimit = val; }

		protected function get player():Player { return CoC.instance.player; }
		protected function get prison():Prison { return SceneLib.prison; }
		protected function get flags():DefaultDict { return CoC.instance.flags; }
		protected function get camp():Camp { return SceneLib.camp; }
		protected function doNext(eventNo:Function):void { EngineCore.doNext(eventNo); }
		protected function rand(n:Number):int { return Utils.rand(n); }

		public function Consumable(id:String, shortName:String = null, longName:String = null, value:Number = 0, description:String = null) {
			super(id, shortName, longName, value, description);
		}

		override public function get description():String {
			var desc:String = _description;
			//Type
			desc += "\n\nType: Consumable ";
			if (shortName == "Wingstick" || shortName == "MiniBangB") desc += "(Thrown)";
			if (shortName == "S.Hummus") desc += "(Cheat Item)";
			if (shortName == "BroBrew" || shortName == "BimboLq" || shortName == "P.Pearl") desc += "(Rare Item)";
			if (longName.indexOf("dye") >= 0) desc += "(Dye)";
			if (longName.indexOf("egg") >= 0) desc += "(Egg)";
			if (longName.indexOf("book") >= 0) desc += "(Magic Book)";
			//Value
			desc += "\nBase value: " + String(value);
			return desc;
		}

		/**
		 * Delegate function for legacy 'Mutations.as' code.
		 * @param	... args stat change parameters
		 */
		protected function dynStats(... args):void {
			game.player.dynStats.apply(game.player, args);
		}

/*
		public function canUse(player:Player,output:Boolean):Boolean
		{
			return true;
		}
*/

		/**
		 * Perform effect on player WITHOUT requiring item being in player's inventory and removing it
		 */
/*
		public function doEffect(player:Player,output:Boolean):void
		{
			CoC_Settings.errorAMC("Consumable","doEffect",id);
		}
*/

		/**
		 * Removes item from player and does effect
		 */
/*
		override public function useItem(player:Player, output:Boolean, external:Boolean):void
		{
			if (canUse(player,output)){
				if (!external && !game.debug) player.consumeItem(this,1);
				doEffect(player,output);
			}
		}
*/
	}
}
