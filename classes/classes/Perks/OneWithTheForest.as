/**
 * Created by aimozg on 27.01.14.
 */
package classes.Perks
{
	import classes.PerkClass;
	import classes.PerkType;
	import classes.PerkLib;

	public class OneWithTheForest extends PerkType
	{

		override public function desc(params:PerkClass = null):String {
			if (!player || !params) return _desc;
			return "With each new soul added to the collective that bolsters the trees of the sacred forest, you become stronger both physically and spiritually. Gain +1% to all stats for each new wood elf created. "+(params.value1 >= 10?"Increases green spell power by "+Math.round((params.value1-5)*0.5)+"%. ":"")+"Your current tier is "+params.value1+"";
		}

		public function OneWithTheForest() {
			super("One with the forest", "One with the forest",
					"NOT RELEVANT TEXT");
		}
	}
}
