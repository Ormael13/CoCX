/**
 * Created by aimozg on 27.01.14.
 */
package classes.Perks
{
	import classes.PerkClass;
	import classes.PerkType;

	public class MindBreakerBrain extends PerkType
	{

		override public function desc(params:PerkClass = null):String
		{
			return "Repeated mental exercise as well as the increasing size of the mindbreaker collective mental psychic allowed your brain to increase beyond normal size. Empowers all of mindbreaker your abilities by " + params.value1 * 50 + "% and allow you to store more stolen knowledge with Brain Melt.";
		}

		override public function name(params:PerkClass=null):String {
			if (params.value1 == 3) {
				return "Mindbreaker Brain Prime";
			}
			if (params.value1 == 2) {
				return "Mindbreaker Brain Alpha";
			}
			if (params.value1 == 1) {
				return "Mindbreaker Brain";
			}
		}

		public function MindBreakerBrain()
		{
			super("Mindbreaker Brain", "Mindbreaker Brain",
					"NOT RELEVANT TEXT");
		}

		override public function keepOnAscension(respec:Boolean = false):Boolean
		{
			return true;
		}
	}
}
