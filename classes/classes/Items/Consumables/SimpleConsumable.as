/**
 * Created by aimozg on 10.01.14.
 */
package classes.Items.Consumables
{
	import classes.Items.Consumable;
	import classes.Player;

	public class SimpleConsumable extends Consumable
	{
		private var effect:Function;


		override public function doEffect(player:Player,output:Boolean):void
		{
			effect(player);//TODO use output argument... which would require add checks for output to ALL mutations
		}

		/**
		 * @param effect Function(player:Player)
		 */
		public function SimpleConsumable(id:String,shortName:String,longName:String,effect:Function,value:Number=0,description:String=null)
		{
			super(id,shortName,longName,value,description);
			this.effect = effect;
		}
	}
}
