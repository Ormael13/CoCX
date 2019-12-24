/**
 * Created by aimozg on 10.01.14.
 */
package classes.Items
{
import classes.BaseContent;
import classes.CoC;
import classes.Items.Other.DebugWand;
import classes.Items.Other.SimpleUseable;
import classes.Scenes.SceneLib;

use namespace CoC;

	public final class UseableLib extends BaseContent
	{
		public function UseableLib() {}
		
		//MATERIALS
		public const AMETIST:SimpleUseable = new SimpleUseable("Amethyst", "Flawless Amethyst Necklace", "a Flawless Amethyst Necklace", 1000, 
			"A Flawless Amethyst Necklace.",
			"You look over the flawless amethyst necklace. Likely worth a lot of gems.");
		public const DIAMOND:SimpleUseable = new SimpleUseable("Diamond", "Perfect Diamond", "a Perfect Diamond", 1000, 
			"A Perfect Diamond.",
			"You look over the perfect diamond. Likely worth a lot of gems.");
		public const S_INGOT:SimpleUseable = new SimpleUseable("S.Ingot", "Silver ingot", "a Silver ingot", 500, 
			"A Silver ingot.",
			"You look over the Silver ingot. Likely usefull to making some accesories.");
		public const B_CHITN:SimpleUseable = new SimpleUseable("B.Chitn", "B.Chitn", "a large shard of chitinous plating", 100,
			"A perfect piece of black chitin from a bee-girl.  It still has some fuzz on it.",
			"You look over the scale carefully but cannot find a use for it.  Maybe someone else will know how to use it.");
		public const GREENGL:SimpleUseable = new SimpleUseable("GreenGl", "GreenGl", "a clump of green gel", 50,
			"This tough substance has no obvious use that you can discern.",
			"You examine the gel thoroughly, noting it is tough and resiliant, yet extremely pliable.  Somehow you know eating it would not be a good idea.");
		public const T_SSILK:SimpleUseable = new SimpleUseable("T.SSilk", "T.SSilk", "a bundle of tough spider-silk", 200,
			"This bundle of fibrous silk is incredibly tough and strong, though somehow not sticky in the slightest.  You have no idea how to work these tough little strands into anything usable.  Perhaps one of this land's natives might have an idea?",
			"You look over the tough webbing, confusion evident in your expression.  There's really nothing practical you can do with these yourself.  It might be best to find someone more familiar with the odd materials in this land to see if they can make sense of it.");
		public const D_SCALE:SimpleUseable = new SimpleUseable("D.Scale", "Dragonscale", "a freshly-shed dragonscale", 500, 
			"This sheet of dragon scale is incredibly strong and flexible.  No dragons were seriously harmed in the acquisition of this item.", 
			"You look over the sheet of dragon scale. You've seen various legends about how the scales of a dragon can be worked into tough armor or used in alchemy.");
		public const EBONBLO:SimpleUseable = new SimpleUseable("Ebonblo", "Ebonbloom", "an ebonbloom", 600, 
			"Grey metallic flowers such as these are known to bloom in the deepest caves that run below the mountains of Mareth. Prized by mountain dwellers, these blooms fetch a high price due to their rarity and alchemical value.", 
			"You look over the grey metallic flowers such as these are known to bloom in the deepest caves that run below the mountains of Mareth. Prized by mountain dwellers, these blooms fetch a high price due to their rarity and alchemical value.");
		public const WT_BRAN:SimpleUseable = new SimpleUseable("WT.Bran", "W.T.Branch", "a World Tree Branch", 100,
			"A branch from World Tree.  It's infused with small amount of soulforce.",
			"You look over the branch of World Tree.  Maybe someone else will know how to use it.");
		public const TBAPLAT:SimpleUseable = new SimpleUseable("TBaPlat", "T.BarkPlates", "a Tentacled Bark Plates", 1000, 
			"A Tentacled Bark Plates.",
			"You look over the Tentacled Bark Plates.  Need some better desc I suppose.");
		public const DBAPLAT:SimpleUseable = new SimpleUseable("DBaPlat", "D.BarkPlates", "a Divine Bark Plates", 1000, 
			"A Divine Bark Plates.",
			"You look over the Divine Bark Plates.  Need some better desc I suppose.");
		public const LETHITE:SimpleUseable = new SimpleUseable("Lethite", "Lethicite", "a chunk of lethicite", 1000, 
			"A chunk of lethicite. It's rare as lethicite is only produced when a mortal becomes a demon and cums their souls out. A demon's favourite treat.",
			"You examine the pinkish-purple crystal. It must be lethicite. You know that the demons like to consume them but you're sure there might be a use for it.");
		public const GOLCORE:SimpleUseable = new SimpleUseable("GolCore", "GolemCore", "a golem core", 1, 
			"An undamaged core taken from a defeated golem.",
			"You look at the undamaged golem core.  A simple small crystal sphere no larger than your fist that glows gently.  For those that know art of golem making it will be great use and for others it's uselss and better to sell it, preferably to merchant that specificaly buying such items.");
		public const RPLASMA:SimpleUseable = new SimpleUseable("RPlasma", "Raiju Plasma", "a Raiju Plasma", 100, 
			"A Raiju Plasma.",
			"You look over the Raiju Plasma.  Plasma generated by the orgasm of a raiju.");
		public const PCSHARD:SimpleUseable = new SimpleUseable("PCShard", "Purple Crystal Shard", "a Purple Crystal Shard", 1, 
			"A Purple Crystal Shard.",
			"You look at the purple crystal shard. It occasionally glows gently in your hand, but you can't seem to find a use for the shard.");
		//MISCELLANEOUS
		public const CONDOM :SimpleUseable = new SimpleUseable("Condom ", "Condom", "a packet of condom", 6,
			"This wrapper contains a latex condom that can be worn over penis. It's designed to prevent pregnancy most of the time. Can be used in certain sex scenes.",
			"You look at the unopened packet of condom.  If applicable, you can use the condom to prevent pregnancy most of the time.");
		public const DEMSKLL:SimpleUseable = new SimpleUseable("DemSkll", "DemonSkull", "a demon skull", 50, 
			"A skull taken from a slain demon.",
			"You look at the demon skull.  A pair of horns protrude from the skull.  You admire the overall frame of the skull yet you find no obvious uses for it.");
		public const E_P_BOT:SimpleUseable = new SimpleUseable("E P Bot.", "empty pills bottle", "an empty pills bottle", 10, 
			"An empty pills bottle used to keep various pills.",
			"You look at empty pills bottle.  It would help hold your sourforce pills more organized than keep all loose.");
		public const ENECORE:SimpleUseable = new SimpleUseable("EneCore", "Energy Core", "an Energy Core", 1015, 
			"A power source for devices.",
			"You look at Energy Core.  It's component used to make goblin tech.");
		public const FIMPSKL:SimpleUseable = new SimpleUseable("FImpSkl", "FImpSkul", "a feral imp skull", 25, 
			"A skull taken from a slain feral imp.",
			"You look at the feral imp skull.  A two pairs of horns protrude from the deformed skull.  You admire the overall frame of the skull yet you find no obvious uses for it.");
		public const GOBOEAR:SimpleUseable = new SimpleUseable("GoboEar", "GoblinEar", "a goblin ear", 25, 
			"A goblin ear taken from a slain goblin.",
			"You look at the goblin ear.  You admire the overall curve of the ear yet you find no obvious uses for it.");
		public const GLDSTAT:SimpleUseable = new SimpleUseable("GldStat", "GldStat", "a golden statue", 2000,
			"An intricate golden idol of an androgynous humanoid figure with nine long tails.  It probably had some spiritual significance to its owner.",
			"", SceneLib.forest.kitsuneScene.kitsuneStatue);
		public const IMPSKLL:SimpleUseable = new SimpleUseable("ImpSkll", "ImpSkull", "an imp skull", 25, 
			"A skull taken from a slain imp.",
			"You look at the imp skull.  A pair of horns protrude from the skull.  You admire the overall frame of the skull yet you find no obvious uses for it.");
		public const MECHANI:SimpleUseable = new SimpleUseable("Mechani", "Mechanism", "a Mechanism", 1200, 
			"A complex set of gears and gyros.",
			"You look at Mechanism.  It's component used to make goblin tech.");
		public const MINOHOR:SimpleUseable = new SimpleUseable("MinoHor", "MinoHorns", "a minotaur horns", 35, 
			"A horns taken from a slain minotaur.",
			"You look at the pair of minotaur horns.  You admire the overall frame of the horns yet you find no obvious uses for them.");
		public const SEVTENT:SimpleUseable = new SimpleUseable("SevTent", "SevTent", "a severed tentacle", 50, 
			"A severed tentacle taken from a slain tentacle beast.",
			"You look at the severed tentacle skull.  It certain look a bit of...deformed more than any other tentacle you seen so far.  Is it natural occuring or forced mutation?");
		public const SOULGEM:SimpleUseable = new SimpleUseable("SoulGem", "Soul Gem", "a Soul Gem", 2500, 
			"A Soul Gem.",
			"You examine the purplish crystal. It must be soul gem. It's used to capture and hold souls.");
		public const STAFISH:SimpleUseable = new SimpleUseable("StaFish", "StackFish", "a stack of fishes", 60, 
			"A stack of fresh fish. It’s smelly but it can be sold at the pawn shop for gems.",
			"You look at stack of fresh fish.  Too many to eat them all at once you can sold them at the pawn shop for gems.");
		public const VIALCLE:SimpleUseable = new SimpleUseable("VialCle", "V.Clear", "a clear vial", 1, 
			"A clear vial used to dye scales.",
			"You look at clear vial.  It would help Arian change scales color.");
		public const VIALTUR:SimpleUseable = new SimpleUseable("VialTur", "V.Turquoise", "a turquoise vial", 1, 
			"A turquoise vial used to dye scales.",
			"You look at turquoise vial.  It would help Arian change scales color.");
		public const VIALPIN:SimpleUseable = new SimpleUseable("VialPin", "V.Pink", "a pink vial", 1, 
			"A pink vial used to dye scales.",
			"You look at pink vial.  It would help Arian change scales color.");
		public const VIALRAI:SimpleUseable = new SimpleUseable("VialRai", "V.Rainbow", "a rainbow vial", 1, 
			"A rainbow vial used to dye scales.",
			"You look at rainbow vial.  It would help Arian change scales color.");
		//CHEAT ITEM
		public const DBGWAND:DebugWand = new DebugWand();
	}
}
