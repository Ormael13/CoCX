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
		//CRAFTING MATERIALS
		public const GREENGL:SimpleUseable = mk("GreenGl","GreenGl","a clump of green gel", m.greenGel,"This tough substance has no obvious use that you can discern. \n\nType: Material");
		public const B_CHITN:SimpleUseable = mk("B.Chitn","B.Chitn","a large shard of chitinous plating", m.chitinUseless,"A perfect piece of black chitin from a bee-girl.  It still has some fuzz on it. \n\nType: Material");
		public const T_SSILK:SimpleUseable = mk("T.SSilk", "T.SSilk", "a bundle of tough spider-silk", m.toughSpiderSilk, "This bundle of fibrous silk is incredibly tough and strong, though somehow not sticky in the slightest.  You have no idea how to work these tough little strands into anything usable.  Perhaps one of this land's natives might have an idea? \n\nType: Material");

		public const D_SCALE:SimpleUseable = mk("D.Scale", "Dragonscale", "a freshly-shed dragonscale", m.toughDragonScale, "This sheet of dragon scale is incredibly strong and flexible.  No dragons were harmed in the acquisition of this item. \n\nType: Material");
		public const IMPSKLL:SimpleUseable = mk("ImpSkll", "ImpSkull", "an imp skull", m.examineImpSkull, "A skull taken from a slain imp. \n\nType: Material", 100);
		public const LETHITE:SimpleUseable = mk("Lethite", "Lethicite", "a chunk of lethicite", m.examineImpSkull, "A chunk of lethicite.  It's very rare as lethicite is only produced when a mortal becomes a demon and cums their souls out.  \n\nType: Material", 1000);
		//Ores
		//public const COPPORE:SimpleUseable = mk("CoppOre", "Copper Ore", "a cluster of copper ore", m.examineCopperOre, "A raw metal ore that's ready to be processed into ingots. \n\nType: Material", 10);
		//public const IRONORE:SimpleUseable = mk("IronOre", "Iron Ore", "a cluster of iron ore", m.examineIronOre, "A raw metal ore that's ready to be processed into ingots. \n\nType: Material", 20);
		//public const TIN_ORE:SimpleUseable = mk("Tin Ore", "Tin Ore", "a cluster of tin ore", m.examineTinOre, "A raw metal ore that's ready to be processed into ingots. \n\nType: Material", 10);
		//Ingots
		//public const BRONBAR:SimpleUseable = mk("BronBar", "Bronze Bar", "a bronze ingot", m.examineBronzeBar, "A refined bronze ingot ready to be used for crafting. \n\nType: Material", 30);
		//public const IRONBAR:SimpleUseable = mk("IronBar", "Iron Bar", "an iron ingot", m.examineIronBar, "A refined iron ingot ready to be used for crafting. \n\nType: Material", 40);
		//public const STL_BAR:SimpleUseable = mk("Stl.Bar", "Steel Bar", "a steel ingot", m.examineSteelBar, "A refined steel ingot ready to be used for crafting. \n\nType: Material", 50);
		//Miscellaneous
		public const GLDSTAT:SimpleUseable = mk("GldStat","GldStat","a golden statue",function(player:Player):void{getGame().forest.kitsuneScene.kitsuneStatue(player)},"An intricate golden idol of an androgynous humanoid figure with nine long tails.  It probably had some spiritual significance to its owner. \n\nType: Rare item \nBase value: 600",600);
		public const CONDOM :SimpleUseable = mk("Condom ","Condom","a packet of condom",m.examineCondom,"This wrapper contains a latex condom that can be worn over penis. It's designed to prevent pregnancy most of the time. Can be used in certain sex scenes. \n\nType: Consumable",DEFAULT_VALUE);
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
