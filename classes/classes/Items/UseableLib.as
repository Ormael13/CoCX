/**
 * Created by aimozg on 10.01.14.
 */
package classes.Items
{
	import classes.BaseContent;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.Items.Other.SimpleUseable;
	import classes.Player;
	import classes.internals.Utils;

	use namespace kGAMECLASS;

	public final class UseableLib extends BaseContent
	{
		public static const DEFAULT_VALUE:Number = 6;

		public const GREENGL:SimpleUseable = mk("GreenGl","GreenGl","a clump of green gel", m.greenGel,"This tough substance has no obvious use that you can discern.");
		public const B_CHITN:SimpleUseable = mk("B.Chitn","B.Chitn","a large shard of chitinous plating", m.chitinUseless,"A perfect piece of black chitin from a bee-girl.  It still has some fuzz on it.");
		public const T_SSILK:SimpleUseable = mk("T.SSilk","T.SSilk","a bundle of tough spider-silk", m.toughSpiderSilk,"This bundle of fibrous silk is incredibly tough and strong, though somehow not sticky in the slightest.  You have no idea how to work these tough little strands into anything usable.  Perhaps one of this land's natives might have an idea?");
		public const GLDSTAT:SimpleUseable = mk("GldStat","GldStat","a golden statue",function(player:Player):void{getGame().forest.kitsuneScene.kitsuneStatue(player)},"An intricate golden idol of an androgynous humanoid figure with nine long tails.  It probably had some spiritual significance to its owner.",600);
		private var mutations:Mutations;

		private static function mk(id:String, shortName:String,longName:String, effect:Function, description:String, value:Number = DEFAULT_VALUE):SimpleUseable{
			return new SimpleUseable(id,shortName,longName,effect,value,description);
		}
		private function get m():Mutations{
			if (mutations == null) mutations = new Mutations();
			return mutations;
		}
		public function UseableLib()
		{
		}
	}
}
