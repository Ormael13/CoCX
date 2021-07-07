/**
 * Created by aimozg on 27.01.14.
 */
package classes.Perks
{
	import classes.PerkClass;
	import classes.PerkType;

	public class ELFElvenSpearDancingFlurry extends PerkType
	{

		override public function desc(params:PerkClass = null):String
		{
			return "As an elf add " + params.value1 + " extra attacks when full attacking using a one handed or two handed spear with no shield equipped. and increase spear damage by " + params.value1 * 20 + "% when full attacking.";
		}

		override public function name(params:PerkClass=null):String {
			if (params) {
				return "Elven Spear Dancing Flurry " + params.value1 + "";
			} else {
				return "Elven Spear Dancing Furry";
			}
		}

		public function ELFElvenSpearDancingFlurry()
		{
			super("Elven Spear Dancing Flurry", "Elven Spear Dancing Flurry",
					"NOT RELEVANT TEXT");
		}

		override public function keepOnAscension(respec:Boolean = false):Boolean
		{
			return true;
		}
	}
}
