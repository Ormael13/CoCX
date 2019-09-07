/**
 * Created by aimozg on 11.01.14.
 */
package classes.internals
{
	public class WeightedDrop implements RandomDrop
	{
		private var items:Array = [];
		private var sum:Number = 0;
		public function WeightedDrop(first:*=null,firstWeight:Number=0)
		{
			if (first != null){
				items.push([first,firstWeight]);
				sum += firstWeight;
			}
		}
		public function add(item:*,weight:Number=1):WeightedDrop
		{
			items.push([item,weight]);
			sum += weight;
			return this;
		}
		public function addMany(weight:Number,..._items):WeightedDrop
		{
			for each (var item:* in _items){
				items.push([item,weight]);
				sum += weight;
			}
			return this;
		}
		// you can pass your own random value from 0 to 1 (so you can use your own RNG)
		public function roll():*
		{
			var random:Number = Math.random()*sum;
			var item:* = null;
			while (random > 0 && items.length > 0) {
				var pair:Array = items.shift();
				item = pair[0];
				random -= pair[1];
			}
			return item;
		}

		public function clone():WeightedDrop
		{
			var other:WeightedDrop = new WeightedDrop();
			other.items = items.slice();
			other.sum = sum;
			return other;
		}
	}
}