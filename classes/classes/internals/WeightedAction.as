package classes.internals 
{
	/**
	 * Class for performing weighted random actions (function/method calls) derived from WeightedDrop by aimozg
	 * @since May 7, 2017
	 * @author Stadler76
	 */
	public class WeightedAction
	{
		private var actions:Array = [];
		private var sum:Number = 0;

		public function WeightedAction(first:Function = null, firstWeight:Number = 0)
		{
			if (first != null) {
				actions.push([first,firstWeight]);
				sum += firstWeight;
			}
		}

		public function add(action:Function, weight:Number = 1):WeightedAction
		{
			actions.push([action, weight]);
			sum += weight;
			return this;
		}

		public function addMany(weight:Number, ..._actions):WeightedAction
		{
			for each (var action:Function in _actions) {
				actions.push([action, weight]);
				sum += weight;
			}
			return this;
		}

		public function exec():void
		{
			var random:Number = Math.random()*sum;
			var action:Function = null;
			var actions:Array = this.actions.slice();
			while (random > 0 && actions.length > 0) {
				var pair:Array = actions.shift();
				action = pair[0];
				random -= pair[1];
			}

			if (action != null)
				action();
		}

		public function clone():WeightedAction
		{
			var other:WeightedAction = new WeightedAction();
			other.actions = actions.slice();
			other.sum = sum;
			return other;
		}
	}
}
