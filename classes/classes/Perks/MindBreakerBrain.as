/**
 * Created by aimozg on 27.01.14.
 */
package classes.Perks
{
	import classes.PerkClass;
	import classes.PerkType;
	import classes.PerkLib;

	public class MindBreakerBrain extends PerkType
	{

		override public function desc(params:PerkClass = null):String {
			if (!player || !params) return _desc;
			return "Repeated mental exercise as well as the increasing size of the mindbreaker collective psionic network has allowed your brain to grow beyond its normal size. Empowers all of your mindbreaker abilities by " + params.value1 * 50 + "% and allows you to store more stolen knowledge with Brain Melt. Your current tier is "+params.value1+"";
		}

		override public function name(params:PerkClass=null):String {
			if (!player || !params) return _name;
			var suffix:Array = ["", "Gamma", "Beta", "Alpha", "Omega", "Prime"];
			var sufval:int = player ? player.perkv1(PerkLib.MindbreakerBrain1toX) : 0;
			if (sufval > 5) sufval = 5;
			return "Mindbreaker Brain " + suffix[sufval] + "";
		}

		public function MindBreakerBrain() {
			super("Mindbreaker Brain", "Mindbreaker Brain",
					"NOT RELEVANT TEXT");
		}

		override public function keepOnAscension(respec:Boolean = false):Boolean {
			return true;
		}
	}
}
