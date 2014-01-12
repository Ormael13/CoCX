/**
 * Created by aimozg on 10.01.14.
 */
package classes.Items.Other
{
	import classes.Character;
	import classes.Items.Useable;
	import classes.Player;

	public class SimpleUseable extends Useable
	{
		private var effect:Function;

		override public function useItem(user:Player):void
		{
			effect(user);
		}

		public function SimpleUseable(id:String, shortName:String, longName:String, effect:Function,value:Number = 0, description:String = null)
		{
			super(id, shortName, longName, value, description);
			this.effect = effect;
		}
	}
}
