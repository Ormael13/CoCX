package classes.Items 
{
	/**
	 * ...
	 * @author Ormael
	 */
	import classes.Items.Necklaces.*;
	import classes.PerkLib;
	import classes.PerkType;
	
	public final class NecklaceLib 
	{
		public static const MODIFIER_SF:int = 				1;
		public static const MODIFIER_MP:int = 				2;
		public static const MODIFIER_HP:int = 				3;
		public static const MODIFIER_ATTACK_POWER:int = 	4;
		public static const MODIFIER_SPELL_POWER:int = 		5;
		public static const MODIFIER_R_ATTACK_POWER:int = 	6;
		//public static const :int = 				7;
		public static const MODIFIER_WR:int = 				8;
		public static const MODIFIER_FIRE_R:int = 			9;
		public static const MODIFIER_ICE_R:int = 			10;
		public static const MODIFIER_LIGH_R:int = 			11;
		public static const MODIFIER_DARK_R:int = 			12;
		public static const MODIFIER_POIS_R:int = 			13;
		public static const MODIFIER_MAGIC_R:int = 			14;
		public static const MODIFIER_LUST_R:int = 			15;
		public static const MODIFIER_PHYS_R:int = 			16;
		
		public static const DEFAULT_VALUE:Number = 6;
		
		public static const NOTHING:Nothing = new Nothing();
		
		public const BWSCARF:Necklace = new Necklace("BWScarf", "B. W. scarf", "Blue Winter scarf", "a Blue Winter scarf", 0, 0, 800, "This fancy winter scarf helps protect against cold temperatures and is magically enchanted to empower cold based abilities. \n\nType: Jewelry (Necklace) \nBase value: 800","Necklace");
		public const CSNECK :Necklace = new Necklace("CSNeck", "C.S.Necklace", "Crinos Shape necklace", "a Crinos Shape necklace", 0, 0, 4000, "Necklace made after long research into ferals to allow user using crinos shape transformation ability or boost it power is user already know this ability. It can also cause person wearing it feel getting angry much easier and faster. \n\nType: Jewelry (Necklace) \nBase value: 4,000","Necklace");
		public const GWSCARF:Necklace = new Necklace("GWScarf", "G. W. scarf", "Green Winter scarf", "a Green Winter scarf", 0, 0, 800, "This fancy winter scarf helps protect against cold temperatures and is magically enchanted to empower cold based abilities. \n\nType: Jewelry (Necklace) \nBase value: 800","Necklace");
		public const MCPNECK:Necklace = new Necklace("Mcpneck", "Mc & p neck", "Magic coral and pearl necklace", "a Magic coral and pearl necklace", 0, 0, 800, "This magic necklaces grants the gift of the sea to land dwellers, allowing them to breathe underwater. While near sources of water, children of the ocean recover from their wounds faster when wearing this good luck charm. \n\nType: Jewelry (Necklace) \nBase value: 800","Necklace");
		public const OBNECK :Necklace = new Necklace("OBNeck", "OniBeadNecklace", "Oni bead necklace", "an Oni bead necklace", 0, 0, 800, "Normally worn by monks, this necklace fills you with a sense of raw contained power. \n\nType: Jewelry (Necklace) \nBase value: 800","Necklace");
		public const PWSCARF:Necklace = new Necklace("PWScarf", "P. W. scarf", "Purple Winter scarf", "a Purple Winter scarf", 0, 0, 800, "This fancy winter scarf helps protect against cold temperatures and is magically enchanted to empower cold based abilities. \n\nType: Jewelry (Necklace) \nBase value: 800","Necklace");
		public const RWSCARF:Necklace = new Necklace("RWScarf", "R. W. scarf", "Red Winter scarf", "a Red Winter scarf", 0, 0, 800, "This fancy winter scarf helps protect against cold temperatures and is magically enchanted to empower cold based abilities. \n\nType: Jewelry (Necklace) \nBase value: 800","Necklace");
		public const SMNECK :Necklace = new Necklace("SMNeck", "SMNecklace", "soulmetal necklace", "a soulmetal necklace", MODIFIER_SF, 100, 500, "This simple necklace is made from low quality soulmetal. Despite it seemly simplicity it allow for slight compresion of it weaver soulforce allowing storing a little bit more of it. \n\nType: Jewelry (Necklace) \nBase value: 500 \nSpecial: Increases maximum Soulforce by 100.","Necklace");
		public const TSNECK :Necklace = new Necklace("TSNeck", "T.S.Necklace", "training soul necklace", "a training soul necklace", 0, 0, 300, "Necklace made from soulmetal to help train soulforce to the uttermost limit for novice soul cultivator. \n\nType: Jewelry (Necklace) \nBase value: 300","Necklace");
		public const YIYAAMU:Necklace = new Necklace("YiYaAmu", "YinYangAmulet", "Yin Yang Amulet", "an Yin Yang Amulet", 0, 0, 800, "An amulet of high sentimental value to Chi Chi. It seems to enhance Soulforce abilities. (+15% soulskills power) \n\nType: Jewelry (Necklace) \nBase value: 800","Necklace");
		public const YWSCARF:Necklace = new Necklace("YWScarf", "Y. W. scarf", "Yellow Winter scarf", "a Yellow Winter scarf", 0, 0, 800, "This fancy winter scarf helps protect against cold temperatures and is magically enchanted to empower cold based abilities. \n\nType: Jewelry (Necklace) \nBase value: 800","Necklace");
		public const FIRENEC:Necklace = new Necklace("FireNec", "Fire Neck", "necklace of fire protection", "an enchanted necklace of fire protection", MODIFIER_FIRE_R, 25, 4000, "This necklace is topped with ruby gemstones. It is said that this will make you protected from fire. \n\nType: Jewelry (Necklace) \nBase value: 4,000 \nSpecial: Increases fire resistance by 25%.","Necklace");
		public const ICENECK:Necklace = new Necklace("IceNeck", "Ice Neck", "necklace of ice protection", "an enchanted necklace of ice protection", MODIFIER_ICE_R, 25, 4000, "This necklace is topped with sapphire gemstones. It is said that this will make you protected from ice. \n\nType: Jewelry (Necklace) \nBase value: 4,000 \nSpecial: Increases ice resistance by 25%.","Necklace");
		public const LIGHNEC:Necklace = new Necklace("LighNec", "Ligh Neck", "necklace of lightning protection", "an enchanted necklace of lightning protection", MODIFIER_LIGH_R, 25, 4000, "This necklace is topped with lapis lazuli gemstones. It is said that this will make you protected from lightning. \n\nType: Jewelry (Necklace) \nBase value: 4,000 \nSpecial: Increases lightning resistance by 25%.","Necklace");
		public const DARKNEC:Necklace = new Necklace("DarkNec", "Dark Neck", "necklace of darkness protection", "an enchanted necklace of darkness protection", MODIFIER_DARK_R, 25, 4000, "This necklace is topped with onyx gemstones. It is said that this will make you protected from darkness. \n\nType: Jewelry (Necklace) \nBase value: 4,000 \nSpecial: Increases darkness resistance by 25%.","Necklace");
		public const POISNEC:Necklace = new Necklace("PoisNec", "Pois Neck", "necklace of poison protection", "an enchanted necklace of poison protection", MODIFIER_POIS_R, 25, 4000, "This necklace is topped with pearls. It is said that this will make you protected from poison. \n\nType: Jewelry (Necklace) \nBase value: 4,000 \nSpecial: Increases poison resistance by 25%.","Necklace");
		public const LUSTNEC:Necklace = new Necklace("LustNec", "Lust Neck", "necklace of lust protection", "an enchanted necklace of lust protection", MODIFIER_LUST_R, 25, 6000, "This necklace is topped with amethyst gemstones. It is said that this will make you protected from lust. \n\nType: Jewelry (Necklace) \nBase value: 6,000 \nSpecial: Increases lust resistance by 25%.","Necklace");
		public const MAGINEC:Necklace = new Necklace("MagiNec", "Magic Neck", "necklace of magical protection", "an enchanted necklace of magical protection", MODIFIER_MAGIC_R, 10, 8000, "This necklace is topped with pyrite gemstones. It is said that this will make you protected from magic. \n\nType: Jewelry (Necklace) \nBase value: 8,000 \nSpecial: Increases magic resistance by 10%.","Necklace");
		public const PHYSNEC:Necklace = new Necklace("PhysNec", "Phys Neck", "necklace of physical protection", "an enchanted necklace of physical protection", MODIFIER_PHYS_R, 15, 8000, "This necklace is topped with hematite gemstones. It is said that this will make you protected from physical harm. \n\nType: Jewelry (Necklace) \nBase value: 8,000 \nSpecial: Increases physical resistance by 15%.","Necklace");
		//armor, mag resis protection necklaces........
		public const NECKINT:NecklaceOfIntelligence = new NecklaceOfIntelligence();
		public const NECKLIB:NecklaceOfLibido = new NecklaceOfLibido();
		public const NECKSEN:NecklaceOfSensitivity = new NecklaceOfSensitivity();
		public const NECKSPE:NecklaceOfSpeed = new NecklaceOfSpeed();
		public const NECKSTR:NecklaceOfStrength = new NecklaceOfStrength();
		public const NECKTOU:NecklaceOfToughness = new NecklaceOfToughness();
		public const NECKWIS:NecklaceOfWisdom = new NecklaceOfWisdom();
		public const EZEKIELN:Necklace = new Necklace("EzekielN", "EzekielNecklace", "Ezekiel's Necklace", "an Ezekiel's Necklace", 0, 0, 500, "A necklace rumored to be blessed by the Ezekiel himself. Is that real one or just another fake necklace merchant sold you? \n\nType: Jewelry (Necklace) \nBase value: 500","Necklace");
		public const WRATHLE:Jewelry = new Jewelry("Wrathle", "Wrathless", "Wrathless", "a Wrathless", MODIFIER_SPELL_POWER, 10, 4500, "This necklace is topped with unknown type of gemstone. It is said that this will make your spells/m. specials free from wrath influence. \n\nType: Jewelry (Necklace) \nBase value: 4,000 \nSpecial: Increases spellpower by 10%.","Necklace");
		
		public function NecklaceLib() 
		{
		}
	}
}