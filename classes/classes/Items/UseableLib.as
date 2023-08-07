/**
 * Created by aimozg on 10.01.14.
 */
package classes.Items
{
import classes.CoC;
import classes.Items.Alchemy.AlchemyLib;
import classes.Items.Alchemy.AlembicCatalyst;
import classes.Items.Other.DebugWand;
import classes.Items.Other.SimpleUseable;
import classes.Scenes.SceneLib;

use namespace CoC;

	public final class UseableLib extends ItemConstants
	{
		public function UseableLib() {}
		
		//MATERIALS
		public const AMETIST:SimpleUseable = new SimpleUseable("Amethyst", "Flawless Amethyst Necklace", "a Flawless Amethyst Necklace", 1000,
			"A Flawless Amethyst Necklace.",
			"You look over the flawless amethyst necklace. Likely worth a lot of gems.");
		public const DIAMOND:SimpleUseable = new SimpleUseable("Diamond", "Perfect Diamond", "a Perfect Diamond", 1000,
			"A Perfect Diamond.",
			"You look over the perfect diamond. Likely worth a lot of gems.");
		public const G_INGOT:SimpleUseable = new SimpleUseable("G.Ingot", "Gold ingot", "a Gold ingot", 800,
			"A Gold ingot.",//weight around 11-13 kg
			"You look over the Gold ingot. Likely usefull to making some accesories.");
		public const S_INGOT:SimpleUseable = new SimpleUseable("S.Ingot", "Silver ingot", "a Silver ingot", 200,
			"A Silver ingot.",//weight around 3-3,2 kg
			"You look over the Silver ingot. Likely usefull to making some accesories.");
		public const COP_ORE:SimpleUseable = new SimpleUseable("Cop.Ore", "Copper ore", "a Copper ore", 40,
			"A Copper ore.",
			"You look over the chunk of Copper ore. Likely usefull to making some equipment.");
		public const TIN_ORE:SimpleUseable = new SimpleUseable("Tin Ore", "Tin ore", "a Tin ore", 40,
			"A Tin ore.",
			"You look over the chunk of Tin ore. Likely usefull to making some equipment.");
		public const IRONORE:SimpleUseable = new SimpleUseable("Iron Ore", "Iron ore", "an Iron ore", 90,
			"An Iron ore.",
			"You look over the chunk of Iron ore. Likely usefull to making some equipment.");
		public const BRONZEB:SimpleUseable = new SimpleUseable("BronzeB", "Bronze bar", "a Bronze bar", 80,
			"A Bronze bar.",
			"You look over the Bronze bar. Likely usefull to making some equipment.");
		public const B_CHITN:SimpleUseable = new SimpleUseable("B.Chitn", "B.Chitn", "a large shard of chitinous plating", 100,
			"A perfect piece of black chitin from a bee-girl.  It still has some fuzz on it.",
			"You look over the scale carefully but cannot find a use for it.  Maybe someone else will know how to use it.");
		public const GREENGL:SimpleUseable = new SimpleUseable("GreenGl", "GreenGl", "a clump of green gel", 50,
			"This tough substance has no obvious use that you can discern.",
			"You examine the gel thoroughly, noting it is tough and resiliant, yet extremely pliable.  Somehow you know eating it would not be a good idea.");
		public const RED_GEL:SimpleUseable = new SimpleUseable("RedGel", "RedGel", "a clump of red gel", 100,
			"This malleable substance has no obvious use that you can discern.",
			"You examine the gel thoroughly, noting it is malleable, yet extremely reactive to soulforce.  Somehow you know eating it would not be a good idea.");
		public const T_SSILK:SimpleUseable = new SimpleUseable("T.SSilk", "T.SSilk", "a bundle of tough spider-silk", 200,
			"This bundle of fibrous silk is incredibly tough and strong, though somehow not sticky in the slightest.  You have no idea how to work these tough little strands into anything usable.  Perhaps one of this land's natives might have an idea?",
			"You look over the tough webbing, confusion evident in your expression.  There's really nothing practical you can do with these yourself.  It might be best to find someone more familiar with the odd materials in this land to see if they can make sense of it.");
		public const D_SCALE:SimpleUseable = new SimpleUseable("D.Scale", "Dragonscale", "a freshly-shed dragonscale", 500,
			"This sheet of dragon scale is incredibly strong and flexible.  No dragons were seriously harmed in the acquisition of this item.",
			"You look over the sheet of dragon scale. You've seen various legends about how the scales of a dragon can be worked into tough armor or used in alchemy.");
		public const EBONBLO:SimpleUseable = new SimpleUseable("Ebonblo", "Ebonbloom", "an ebonbloom", 600,
			"Grey metallic flowers such as these are known to bloom in the deepest caves that run below the mountains of Mareth. Prized by mountain dwellers, these blooms fetch a high price due to their rarity and alchemical value.",
			"You look over the grey metallic flowers such as these are known to bloom in the deepest caves that run below the mountains of Mareth. Prized by mountain dwellers, these blooms fetch a high price due to their rarity and alchemical value.");
		public const EBONING:SimpleUseable = new SimpleUseable("EbonIng", "Ebon Ingot", "an ebon ingot", 600,
			"An Ebon ingot.",
			"You look over the Ebon ingot. Likely usefull to making some weapons.");
		public const WT_BRAN:SimpleUseable = new SimpleUseable("WT.Bran", "W.T.Branch", "a World Tree Branch", 200,
			"A branch from World Tree.  It's infused with small amount of soulforce.",
			"You look over the branch of World Tree.  Maybe someone else will know how to use it.");
		public const TBAPLAT:SimpleUseable = new SimpleUseable("TBaPlat", "T.BarkPlates", "a Tentacled Bark Plates", 3000,
			"A Tentacled Bark Plates.",
			"You look over the Tentacled Bark Plates.  Tencales writhe and worm softly along the thick, sturdy plate.");
		public const DBAPLAT:SimpleUseable = new SimpleUseable("DBaPlat", "D.BarkPlates", "a Divine Bark Plates", 3000,
			"A Divine Bark Plates.",
			"You look over the Divine Bark Plates.  Tencales writhe and worm softly along the thick, sturdy plate.");
		public const GOLCORE:SimpleUseable = new SimpleUseable("GolCore", "GolemCore", "a golem core", 1,
			"An undamaged core taken from a defeated golem.",
			"You look at the undamaged golem core. A simple small crystal sphere, no larger than your fist glows gently. Any proper Golemancer knows the use of each core. For others, it's vendor fodder, preferably to a merchant that specifically seeks such items.");
		public const RPLASMA:SimpleUseable = new SimpleUseable("RPlasma", "Raiju Plasma", "a Raiju Plasma", 100,
			"A Raiju Plasma.",
			"You look over the Raiju Plasma.  Plasma generated by the orgasm of a raiju.");
		public const PCSHARD:SimpleUseable = new SimpleUseable("PCShard", "Purple Crystal Shard", "a Purple Crystal Shard", 1,
			"A Purple Crystal Shard.",
			"You look at the purple crystal shard. It occasionally glows gently in your hand, but you can't seem to find a use for the shard.");
		public const ELSHARD:SimpleUseable = new SimpleUseable("ELShard", "Elemental Shard", "an Elemental Shard", 1,
			"An Elemental Shard.",
			"You look at the elemental shard. It occasionally glows gently in your hand.  It may be usefull to rank up your summoned elementals.");
		public const LELSHARD:SimpleUseable = new SimpleUseable("LELShard", "Large Elemental Shard", "a Large Elemental Shard", 3,
			"A Large Elemental Shard.",
			"You look at the large elemental shard. It occasionally glows gently in your hand.  It may be usefull to rank up your summoned elementals.");
		public const ELCRYST:SimpleUseable = new SimpleUseable("ELCryst", "Elemental Crystal", "an Elemental Crystal", 10,
			"An Elemental Crystal.",
			"You look at the elemental crystal. It occasionally glows gently in your hand.  It precious material that may be usefull to make your summoned elementals stronger.");
		public const EL_CORE:SimpleUseable = new SimpleUseable("ELCore", "Elemental Core", "an Elemental Core", 20,
			"An Elemental Core.",
			"You look at the elemental core. It occasionally glows gently in your hand.  Rare treasure that have wide range of uses for elementalists.");
		public const E_ICHOR:SimpleUseable = new SimpleUseable("E.Ichor", "E-Ichor vial", "a vial of E-Ichor", 1,
			"A vial of E-Ichor.",
			"You look at the vial of substance called E-Ichor. It occasionally glows gently in your hand.  It may be useful for taking on mutations.");
		public const D_E_ICHOR:SimpleUseable = new SimpleUseable("D.E.Ichor", "D.E-Ichor vial", "a vial of diluted E-Ichor", 1,
			"A vial of diluted E-Ichor.",
			"You look at the vial of substance called E-Ichor. It occasionally glows gently in your hand.  It may be useful for crafting pills.");
		public const BTSOLUTION:SimpleUseable = new SimpleUseable("BTSolution", "Body Tempering Solution vial", "a vial of Body Tempering solution", 100,
			"An vial of Body Tempering solution.",
			"You look at the vial of substance called Body Tempering solution. It's only usefull for Body Cultivators and probably harmfull for anyone else.");
		public const SRESIDUE:SimpleUseable = new SimpleUseable("SoulResidue", "Soul Residue", "a Soul Residue", 1,
			"A Soul Residue.",
			"You look at the soul residue. It looks to be incredibly fine powder and may have some uses. If you find anyone that could work with this.");
		public const SKYMETA:SimpleUseable = new SimpleUseable("Skymetal", "Skymetal" , "a Skymetal", 900,
			"A Skymetal ore.",
			"You gaze at the skymetal ore. Likely usefull to making some weapons.");
		public const MOONSTO:SimpleUseable = new SimpleUseable("Moonsto", "Moonstone" , "a Moonstone", 900,
			"A Moonstone.",
			"You gaze at the Moonstone. Likely usefull to making some weapons.");
		public const UNICORNH:SimpleUseable = new SimpleUseable("UnicornH", "UnicornHair" , "an Unicorn Hair", 900,
			"An Unicorn Hair.",
			"You gaze at the Unicorn Hair. Likely usefull to making some weapons stronger.");
		public const AMEGEM:SimpleUseable = new SimpleUseable("Amet.Gem", "Amethyst Gem" , "an Amethyst Gem", 1200,
			"An Amethyst Gem.",
			"You gaze at the Amethyst Gem. It would make for great ornamentation, if one knew how to use it.");
		public const TPAZGEM:SimpleUseable = new SimpleUseable("TopzGem", "Topaz Gem", "a Topaz Gem", 1200,
			"A Topaz Gem.",
			"You gaze at the Topaz Gem. It would make for great ornamentation, if one knew how to use it.");
		public const RBYGEM:SimpleUseable = new SimpleUseable("RubyGem", "Ruby Gem", "a Ruby Gem", 1200,
			"A Ruby Gem.",
			"You gaze at the Ruby Gem. It would make for great ornamentation, if one knew how to use it.");
		public const EMDGEM:SimpleUseable = new SimpleUseable("Emd.Gem", "Emerald Gem", "an Emerald Gem", 1200,
			"An Emerald Gem.",
			"You gaze at the Emerald Gem. It would make for great ornamentation, if one knew how to use it.");
		public const SAPPGEM:SimpleUseable = new SimpleUseable("Sap.Gem", "Sapphire Gem", " a Sapphire Gem", 1200,
			"A Sapphire Gem.",
			"You gaze at the Sapphire Gem. It would make for great ornamentation, if one knew how to use it.");
		//MISCELLANEOUS
		public const CONDOM :SimpleUseable = new SimpleUseable("Condom ", "Condom", "a condom packet", 6,
			"This wrapper contains a single latex condom that can be worn over the penis. It's designed to prevent pregnancy... most of the time. Can be used in certain sex scenes.",
			"You look at the unopened condom packet.  If applicable, you can use the condom to prevent pregnancy. Most of the time, anyway.");
		public const DEMSKLL:SimpleUseable = new SimpleUseable("DemSkll", "DemonSkull", "a demon skull", 50,
			"A skull taken from a slain demon.",
			"You look at the demon skull.  A pair of horns protrude from the skull.  You admire the overall frame of the skull yet you find no obvious uses for it.");
		public const E_P_BOT:SimpleUseable = new SimpleUseable("E P Bot.", "empty pill bottle", "an empty pill bottle", 10,
			"An empty pill bottle used to keep various pills.",
			"You look at the empty pill bottle. It can help hold your sourforce pills more organized compared to keeping them loose.");
		public const ENECORE:SimpleUseable = new SimpleUseable("EneCore", "Energy Core", "an Energy Core", 1015,
			"A power source for devices.",
			"You look at Energy Core.  It's component used to make goblin tech.");
		public const FIMPSKL:SimpleUseable = new SimpleUseable("FImpSkl", "FImpSkul", "a feral imp skull", 25,
			"A skull taken from a slain feral imp.",
			"You look at the feral imp skull.  A pair of horns protrude from the deformed skull. You admire the overall frame of the skull yet you find no obvious uses for it.");
		public const GOBOEAR:SimpleUseable = new SimpleUseable("GoboEar", "GoblinEar", "a goblin ear", 25,
			"A goblin ear taken from a slain goblin.",
			"You look at the goblin ear.  You admire the overall curve of the ear yet you find no obvious uses for it.");
		public const GLDSTAT:SimpleUseable = new SimpleUseable("GldStat", "GldStat", "a golden statue", 2000,
			"An intricate golden idol of an androgynous humanoid figure with nine long tails.  It probably had some spiritual significance to its owner.",
			"", function():void {
					// SceneLib is not available during class initialization
					SceneLib.forest.kitsuneScene.kitsuneStatue();
				});
		public const IMPSKLL:SimpleUseable = new SimpleUseable("ImpSkll", "ImpSkull", "an imp skull", 25,
			"A skull taken from a slain imp.",
			"You look at the imp skull.  A pair of horns protrude from the skull. You admire the overall frame of the skull, yet you find no obvious uses for it.");
		public const MECHANI:SimpleUseable = new SimpleUseable("Mechani", "Mechanism", "a Mechanism", 1200,
			"A complex set of gears and gyros.",
			"You look at Mechanism.  It's component used to make goblin tech.");
		public const MINOHOR:SimpleUseable = new SimpleUseable("MinoHor", "MinoHorns", "a minotaur horns", 35,
			"A pair of horns from a minotaur.",
			"You look at the pair of minotaur horns.  You admire the overall frame of the horns yet you find no obvious uses for them.");
		public const SEVTENT:SimpleUseable = new SimpleUseable("SevTent", "SevTent", "a severed tentacle", 50,
			"A severed tentacle taken from a slain tentacle beast.",
			"You look at the severed tentacle skull.  It certainly looks a bit ...deformed, more than any other tentacle you seen so far.  Is it natural occuring or forced mutation?");
		public const SOULGEM:SimpleUseable = new SimpleUseable("SoulGem", "Soul Gem", "a Soul Gem", 2500,
			"A Soul Gem.",
			"You examine the purplish crystal. It must be soul gem. It's used to capture and hold souls.");
		public const STAFISH:SimpleUseable = new SimpleUseable("StaFish", "StackFish", "a stack of fishes", 60,
			"A stack of fresh fish. It’s smelly but it can be sold at the pawn shop for gems.",
			"You look at the stack of fresh fish.  There's too many to eat them all at once. You can sell them at the pawn shop for gems.");
		public const THHTONG:SimpleUseable = new SimpleUseable("THHTong", "TwoHellhoundTongues", "two hellhound tongues", 35,
			"Two tongues taken from a slain hellhound.",
			"You look at the two hellhound tongues.  They look disgusting but at least it proves you killed another of those wretched beasts.");
		public const TROLL_T:SimpleUseable = new SimpleUseable("Troll T", "Troll tusk", "a Troll tusk", 4000,
			"A Troll tusk.",
			"You inspect the tusk covered in a series of rings from the tip to the midsection. A trophy of your triumph.\n\nThere’s not much you can do but admire its glory, you grin in satisfaction knowing that cowards get what they deserve. It’ll likely be worth a hefty sum of gems to someone willing to buy it.");
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
		public const REAGENT:SimpleUseable = new SimpleUseable("Reagent", "Reagent", "a reagent vial", 12,
			"A vial of reagent.",
			"You look at the reagent vial.  It's used with dyes to dye scales, chitins and other similar types of natural armor covering your body.");
		public const S_SHARD:SimpleUseable = new SimpleUseable("S_SHARD", "S.Shard", "a tarnished shard of metal wich may have been part of a golden weapon", 200,
			"These appears to be the shards of a shattered weapon.",
			"These appears to be the shards of a shattered weapon though which one you do not know. You are no smith and thus have no idea how to reforge this item. From what Vala told you it might have been part of the scepter of the fairy queen. You recall that you will need 15 shards in total to start...");
		public const IARROWHEAD:SimpleUseable = new SimpleUseable("IArrowHead", "IArrowHeads", "an iron arrowheads", 1,
			"Hundred iron arrowheads.",
			"You look at a hundred iron arrowheads.  They could be used to craft special arrows.");
		public const MARROWHEAD:SimpleUseable = new SimpleUseable("MArrowHead", "MArrowHeads", "a moonstone arrowheads", 1,
			"Hundred moonstone arrowheads.",
			"You look at a hundred moonstone arrowheads.  They could be used to craft special arrows.");
		public const SARROWHEAD:SimpleUseable = new SimpleUseable("SArrowHead", "SArrowHeads", "a skymetal arrowheads", 1,
			"Hundred skymetal arrowheads.",
			"You look at a hundred skymetal arrowheads.  They could be used to craft special arrows.");
		public const EARROWHEAD:SimpleUseable = new SimpleUseable("EArrowHead", "EArrowHeads", "an ebonbloom arrowheads", 1,
			"Hundred ebonbloom arrowheads.",
			"You look at a hundred ebonbloom arrowheads.  They could be used to craft special arrows.");
		public const TEDDY:SimpleUseable = new SimpleUseable("TeddyBear", "TeddyBear", "a Teddy bear", 200,
				"An old Teddy bear with a small paper with the name Mister Paw tied to it.",
				"You look at an old Teddy bear and see there is a small paper with the name Mister Paw tied to it.");
		// Alchemical catalysts:
		// Substance/Essence/Residue/Pigment
		// Minor/Common/Major
		public const MIN_SUB_ACAT:AlembicCatalyst = new AlembicCatalyst("MIN_SUB_ACAT", AlchemyLib.RT_SUBSTANCE, 1);
		public const CMN_SUB_ACAT:AlembicCatalyst = new AlembicCatalyst("CMN_SUB_ACAT", AlchemyLib.RT_SUBSTANCE, 2);
		public const MAJ_SUB_ACAT:AlembicCatalyst = new AlembicCatalyst("MAJ_SUB_ACAT", AlchemyLib.RT_SUBSTANCE, 3);
		public const MIN_ESS_ACAT:AlembicCatalyst = new AlembicCatalyst("MIN_ESS_ACAT", AlchemyLib.RT_ESSENCE, 1);
		public const CMN_ESS_ACAT:AlembicCatalyst = new AlembicCatalyst("CMN_ESS_ACAT", AlchemyLib.RT_ESSENCE, 2);
		public const MAJ_ESS_ACAT:AlembicCatalyst = new AlembicCatalyst("MAJ_ESS_ACAT", AlchemyLib.RT_ESSENCE, 3);
		public const MIN_RES_ACAT:AlembicCatalyst = new AlembicCatalyst("MIN_RES_ACAT", AlchemyLib.RT_RESIDUE, 1);
		public const CMN_RES_ACAT:AlembicCatalyst = new AlembicCatalyst("CMN_RES_ACAT", AlchemyLib.RT_RESIDUE, 2);
		public const MAJ_RES_ACAT:AlembicCatalyst = new AlembicCatalyst("MAJ_RES_ACAT", AlchemyLib.RT_RESIDUE, 3);
		public const MIN_PIG_ACAT:AlembicCatalyst = new AlembicCatalyst("MIN_PIG_ACAT", AlchemyLib.RT_PIGMENT, 1);
		public const CMN_PIG_ACAT:AlembicCatalyst = new AlembicCatalyst("CMN_PIG_ACAT", AlchemyLib.RT_PIGMENT, 2);
		public const MAJ_PIG_ACAT:AlembicCatalyst = new AlembicCatalyst("MAJ_PIG_ACAT", AlchemyLib.RT_PIGMENT, 3);
		
		public const DYE_FOUNDATION:SimpleUseable = new SimpleUseable("DyeFoundation", "Dye Found", "a vial of dye foundation", 50,
				"Alchemical reagent to turn pigments into hair dyes.",
				"You inspect the transparent liquid in the vial.\n\n<i>(Use Crafting menu to create hair dyes from this item)</i>");
		public const OIL_FOUNDATION:SimpleUseable = new SimpleUseable("OilFoundation", "Oil Found", "a bottle of skin oil foundation", 100,
				"Alchemical reagent to turn pigments into skin oils.",
				"You inspect the transparent liquid in the ottle.\n\n<i>(Use Crafting menu to create skin oils from this item)</i>");
		public const DROP_FOUNDATION:SimpleUseable = new SimpleUseable("DropFoundation", "Drop Found", "a vial of eyedrop foundation", 150,
				"Alchemical reagent to turn pigments into iris-recoloring eyedrops.",
				"You inspect the transparent liquid in the vial.\n\n<i>(Use Crafting menu to create eyedrops from this item)</i>");
		
		public const List_AllCatalysts:/*ItemType*/Array = [
				MIN_SUB_ACAT,
				CMN_SUB_ACAT,
				MAJ_SUB_ACAT,
				MIN_ESS_ACAT,
				CMN_ESS_ACAT,
				MAJ_ESS_ACAT,
				MIN_RES_ACAT,
				CMN_RES_ACAT,
				MAJ_RES_ACAT,
				MIN_PIG_ACAT,
				CMN_PIG_ACAT,
				MAJ_PIG_ACAT
		];
		
		//CHEAT ITEM
		public const DBGWAND:DebugWand = new DebugWand();
	}
}
