/**
 * Created by aimozg on 11.01.14.
 */
package classes.internals
{
	import classes.CoC_Settings;

	public class ChainedDrop implements RandomDrop
	{
		private var items:Array = [];
		private var probs:Array = [];
		private var defaultItem:*;
		public function ChainedDrop(defaultItem:* = null)
		{
			this.defaultItem = defaultItem;
		}
		public function add(item:*,prob:Number):ChainedDrop{
			if (prob<0 || prob>1){
				CoC_Settings.error("Invalid probability value "+prob);
			}
			items.push(item);
			probs.push(prob);
			return this;
		}
		public function elseDrop(item:*):ChainedDrop{
			this.defaultItem = item;
			return this;
		}

		public function roll():*
		{
			for (var i:int = 0; i<items.length; i++){
				if (Math.random()<probs[i]) return items[i];
			}
			return defaultItem;
		}
	}
}
