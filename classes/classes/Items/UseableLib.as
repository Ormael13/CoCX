/**
 * Created by aimozg on 10.01.14.
 */
package classes.Items
{
	import classes.BaseContent;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.Items.Other.DebugWand;
	import classes.Items.Other.SimpleUseable;
	import classes.Player;
	import classes.internals.Utils;

	use namespace kGAMECLASS;

	public final class UseableLib extends BaseContent
	{
		public function UseableLib() {}
		
		//MATERIALS
		public const B_CHITN:SimpleUseable = new SimpleUseable("B.Chitn", "B.Chitn", "a large shard of chitinous plating", 6,
			"A perfect piece of black chitin from a bee-girl.  It still has some fuzz on it.",
			"You look over the scale carefully but cannot find a use for it.  Maybe someone else will know how to use it.");
		public const GREENGL:SimpleUseable = new SimpleUseable("GreenGl", "GreenGl", "a clump of green gel", 6,
			"This tough substance has no obvious use that you can discern.",
			"You examine the gel thoroughly, noting it is tough and resiliant, yet extremely pliable.  Somehow you know eating it would not be a good idea.");
		public const T_SSILK:SimpleUseable = new SimpleUseable("T.SSilk", "T.SSilk", "a bundle of tough spider-silk", 6,
			"This bundle of fibrous silk is incredibly tough and strong, though somehow not sticky in the slightest.  You have no idea how to work these tough little strands into anything usable.  Perhaps one of this land's natives might have an idea?",
			"You look over the tough webbing, confusion evident in your expression.  There's really nothing practical you can do with these yourself.  It might be best to find someone more familiar with the odd materials in this land to see if they can make sense of it.");
		public const D_SCALE:SimpleUseable = new SimpleUseable("D.Scale", "Dragonscale", "a freshly-shed dragonscale", 6, 
			"This sheet of dragon scale is incredibly strong and flexible.  No dragons were seriously harmed in the acquisition of this item.", 
			"You look over the sheet of dragon scale. You've seen various legends about how the scales of a dragon can be worked into tough armor or used in alchemy.");
		public const LETHITE:SimpleUseable = new SimpleUseable("Lethite", "Lethicite", "a chunk of lethicite", 1000, 
			"A chunk of lethicite. It's rare as lethicite is only produced when a mortal becomes a demon and cums their souls out. A demon's favourite treat.",
			"You examine the pinkish-purple crystal. It must be lethicite. You know that the demons like to consume them but you're sure there might be a use for it.");
		public const IMPSKLL:SimpleUseable = new SimpleUseable("ImpSkll", "ImpSkull", "an imp skull", 25, 
			"A skull taken from a slain imp.",
			"You look at the imp skull.  A pair of horns protrude from the skull.  You admire the overall frame of the skull yet you find no obvious uses for it.");
		//MISCELLANEOUS
		public const CONDOM :SimpleUseable = new SimpleUseable("Condom ", "Condom", "a packet of condom", 6,
			"This wrapper contains a latex condom that can be worn over penis. It's designed to prevent pregnancy most of the time. Can be used in certain sex scenes.",
			"You look at the unopened packet of condom.  If applicable, you can use the condom to prevent pregnancy most of the time.");
		public const GLDSTAT:SimpleUseable = new SimpleUseable("GldStat", "GldStat", "a golden statue", 600,
			"An intricate golden idol of an androgynous humanoid figure with nine long tails.  It probably had some spiritual significance to its owner.",
			"", kGAMECLASS.forest.kitsuneScene.kitsuneStatue);
		//CHEAT ITEM
		public const DBGWAND:DebugWand = new DebugWand();
	}
}
