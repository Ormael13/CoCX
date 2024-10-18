/**
 * Created by aimozg on 27.01.14.
 */
package classes.Perks
{
	import classes.PerkClass;
	import classes.PerkType;
	import classes.PerkLib;

	public class ELFElvenSpearDancingFlurry extends PerkType
	{

		override public function desc(params:PerkClass = null):String {
			if (!player || !params) return _desc;
			return "As an elf, you gain " + params.value1 + " extra attacks when making a full attack with a one-handed or two-handed spear, without a shield equipped. It also increases spear damage by " + params.value1 * 20 + "% when full attacking.";
		}

		override public function name(params:PerkClass = null):String {
			if (!player || !params) return _name;
			var pPerkCompare:int = player.perkv1(PerkLib.ELFElvenSpearDancingFlurry1to4);
			if (pPerkCompare >= 0) {
				return "Elven Spear Dancing Flurry " + pPerkCompare + "";
			} else {
				return "Elven Spear Dancing Flurry";
			}
		}

		public function ELFElvenSpearDancingFlurry() {
			super("Elven Spear Dancing Flurry", "Elven Spear Dancing Flurry",
					"NOT RELEVANT TEXT");
		}

		override public function keepOnAscension(respec:Boolean = false):Boolean {
			return true;
		}
	}
}
