package classes.Items
{
	/**
	 * ...
	 * @author Ormael
	 */

import classes.Items.HeadJewelries.*;

public final class HeadJewelryLib extends ItemConstants
	{
		public static const MODIFIER_SF:int = 				HEADEFF_SF;
		public static const MODIFIER_MP:int = 				HEADEFF_MP;
		public static const MODIFIER_HP:int = 				HEADEFF_HP;
		public static const MODIFIER_ATTACK_POWER:int = 	HEADEFF_ATTACK_POWER;
		public static const MODIFIER_SPELL_POWER:int = 		HEADEFF_SPELL_POWER;
		public static const MODIFIER_R_ATTACK_POWER:int = 	HEADEFF_R_ATTACK_POWER;
		//public static const :int = 				7;
		public static const MODIFIER_WR:int = 				HEADEFF_WR;
		public static const MODIFIER_FIRE_R:int = 			HEADEFF_FIRE_R;
		public static const MODIFIER_ICE_R:int = 			HEADEFF_ICE_R;
		public static const MODIFIER_LIGH_R:int = 			HEADEFF_LIGH_R;
		public static const MODIFIER_DARK_R:int = 			HEADEFF_DARK_R;
		public static const MODIFIER_POIS_R:int = 			HEADEFF_POIS_R;
		public static const MODIFIER_MAGIC_R:int = 			HEADEFF_MAGIC_R;
		public static const MODIFIER_LUST_R:int = 			HEADEFF_LUST_R;
		public static const MODIFIER_PHYS_R:int = 			HEADEFF_PHYS_R;
		
		public static const DEFAULT_VALUE:Number = 6;//base cost 200 gems, each effect increase up to 2x cost
		
		public static const NOTHING:Nothing = new Nothing();
		
		public const AQBREATH:HeadJewelry = new HeadJewelry("AqBreath", "Aqua breather", "Aqua breather", "an Aqua breather", 0, 0, 200, "This unfashionable, yet very practical, goblin device allows to breathe underwater. A must have for any underwater expedition.",HJT_HELMET);
		public const COWHAT :HeadJewelry = new HeadJewelry("CGHAT", "C.G.Hat", "cow girl hat", "cow girl hat", 0, 0, 200, "This hat was retrieved from an offworld gunslinger who became a cow. As such aside from its powerful enchantment that increase firearms potency it also raise milk production.",HJT_HELMET);
		public const DEATHPR:DeathPrinceRegalia = new DeathPrinceRegalia();
		public const DMONSKUL:SkullOrnament = new SkullOrnament();
		public const FOXHAIR:HeadJewelry = new HeadJewelry("FoxHair", "Fox Hairpin", "fox hairpin", "a fox hairpin", 0, 0, 800, "This hairpin, adorned with the design of a fox and blessed by Taoth, grants a kitsune increased magical power. (-20% spell and soulskills costs, +20% mag/lust dmg to fox fire specials)",HJT_HAIRPIN);
		public const GNHAIR:HeadJewelry = new HeadJewelry("GNHair", "Golden Naga Hairpins", "pair of Golden Naga Hairpins", "a pair of Golden Naga Hairpins", 0, 0, 400, "This pair of lovely half moon-shaped golden hairpins are commonly used by the nagas to enhance their bodily charms. (+10% lust dmg from naga specials and +1 duration of Hypnosis)",HJT_HAIRPIN);
		public const HBHELM :HBHelmet = new HBHelmet();
		public const KABUMEMP:HeadJewelry = new HeadJewelry("KabuMemp", "KabutoMempo", "Kabuto & Mempo", "a Kabuto & Mempo", 0, 0, 100, "This fashionable and practical set of Kabuto (helmet) and Mempo (face mask) allow to protect whole head. Usualy worn alongside Samurai armor.",HJT_HELMET);
		public const MACHGOG:MachinistGoggles = new MachinistGoggles();
		public const SATGOG :SATechGoggle = new SATechGoggle();
		public const SCANGOG:ScannerGoggle = new ScannerGoggle();
		public const SEERPIN:SeersHairpin = new SeersHairpin();
		public const SKIGOGG:HeadJewelry = new HeadJewelry("SkiGogg", "Ski goggles", "Ski goggles", "a Ski goggles", 0, 0, 400, "These goggles help shield your eyes against the snowstorms of the glacial rift, allowing you to see correctly in a blizzard like the denizens of the rift.",HJT_HELMET);
		public const SNOWFH:SnowflakeHairpin = new SnowflakeHairpin();
		public const SPHINXAS:SphinxAccessorySet = new SphinxAccessorySet();
		public const TSHAIR :HeadJewelry = new HeadJewelry("TSHair", "T.S.Hairpin", "training soul hairpin", "training soul hairpin", 0, 0, 200, "This hairpin, made from soulmetal helps to train soulforce to the uttermost limit for novice soul cultivator. ",HJT_HAIRPIN);
		public const FIRECRO:HeadJewelry = new HeadJewelry("FireCro", "Fire Crown", "crown of fire protection", "an enchanted crown of fire protection", MODIFIER_FIRE_R, 20, 3200, "This crown is topped with ruby gemstones. It is said that this will make you protected from fire.",HJT_CROWN);
		public const ICECROW:HeadJewelry = new HeadJewelry("IceCrow", "Ice Crown", "crown of ice protection", "an enchanted crown of ice protection", MODIFIER_ICE_R, 20, 3200, "This crown is topped with sapphire gemstones. It is said that this will make you protected from ice.",HJT_CROWN);
		public const LIGHCRO:HeadJewelry = new HeadJewelry("LighCro", "Ligh Crown", "crown of lightning protection", "an enchanted crown of lightning protection", MODIFIER_LIGH_R, 20, 3200, "This crown is topped with lapis lazuli gemstones. It is said that this will make you protected from lightning.",HJT_CROWN);
		public const DARKCRO:HeadJewelry = new HeadJewelry("DarkCro", "Dark Crown", "crown of darkness protection", "an enchanted crown of darkness protection", MODIFIER_DARK_R, 20, 3200, "This crown is topped with onyx gemstones. It is said that this will make you protected from darkness.",HJT_CROWN);
		public const POISCRO:HeadJewelry = new HeadJewelry("PoisCro", "Pois Crown", "crown of poison protection", "an enchanted crown of poison protection", MODIFIER_POIS_R, 20, 3200, "This crown is topped with pearls. It is said that this will make you protected from poison.",HJT_CROWN);
		public const LUSTCRO:HeadJewelry = new HeadJewelry("LustCro", "Lust Crown", "crown of lust protection", "an enchanted crown of lust protection", MODIFIER_LUST_R, 20, 4800, "This crown is topped with amethyst gemstones. It is said that this will make you protected from lust.",HJT_CROWN);
		public const MAGICRO:HeadJewelry = new HeadJewelry("MagiCro", "Magic Crown", "crown of magic protection", "an enchanted crown of magical protection", MODIFIER_MAGIC_R, 8, 6400, "This crown is topped with pyrite gemstones. It is said that this will make you protected from magic.",HJT_CROWN);
		public const PHYSCRO:HeadJewelry = new HeadJewelry("PhysCro", "Phys Crown", "crown of physical protection", "an enchanted crown of physical protection", MODIFIER_PHYS_R, 12, 6400, "This crown is topped with hematite gemstones. It is said that this will make you protected from physical harm.",HJT_CROWN);
		public const CUNDKIN:HeadJewelry = new HeadJewelry("CUndKing", "CroUndefKing", "Crown of the Undefeated King", "a Crown of the Undefeated King", 0, 0, 6000, "This splendid crown topped with many kinds of gems belonged in the past to the king, which claimed to be undefeated. But then how it get into your hands?",HJT_CROWN);
		//helmet(s) that giving armor and/or mres
		public const CROWINT:HeadJewelry = new HeadJewelry("CrowInt", "CrownOfIntelligence", "Crown of Intelligence", "a Crown of Intelligence", 0, 0, 3200, "A simple crown to boost intelligence.",HJT_CROWN).withBuffs({"int.mult":+0.20}) as HeadJewelry;
		public const CROWLIB:HeadJewelry = new HeadJewelry("CrowLib", "CrownOfLibido", "Crown of Libido", "a Crown of Libido", 0, 0, 3200, "A simple crown to boost libido.",HJT_CROWN).withBuffs({"lib.mult":+0.20}) as HeadJewelry;
		public const CROWSEN:HeadJewelry = new HeadJewelry("CrowSen", "CrownOfSensitivity", "Crown of Sensitivity", "a Crown of Sensitivity", 0, 0, 3200, "A simple crown to boost sensitivity.",HJT_CROWN).withBuffs({"sens":+20}) as HeadJewelry;
		public const CROWSPE:HeadJewelry = new HeadJewelry("CrowSpe", "CrownOfSpeed", "Crown of Speed", "a Crown of Speed", 0, 0, 3200, "A simple crown to boost speed.",HJT_CROWN).withBuffs({"spe.mult":+0.20}) as HeadJewelry;
		public const CROWSTR:HeadJewelry = new HeadJewelry("CrowStr", "CrownOfStrength", "Crown of Strength", "a Crown of Strength", 0, 0, 3200, "A simple crown to boost strength.",HJT_CROWN).withBuffs({"str.mult":+0.20}) as HeadJewelry;
		public const CROWTOU:HeadJewelry = new HeadJewelry("CrowTou", "CrownOfToughness", "Crown of Toughness", "a Crown of Toughness", 0, 0, 3200, "A simple crown to boost toughness.",HJT_CROWN).withBuffs({"tou.mult":+0.20}) as HeadJewelry;
		public const CROWWIS:HeadJewelry = new HeadJewelry("CrowWis", "CrownOfWisdom", "Crown of Wisdom", "a Crown of Wisdom", 0, 0, 3200, "A simple crown to boost Wisdom.",HJT_CROWN).withBuffs({"wis.mult":+0.20}) as HeadJewelry;
		public const EZEKIELC:HeadJewelry = new HeadJewelry("EzekielC", "EzekielCrown", "Ezekiel's Crown", "an Ezekiel's Crown", 0, 0, 400, "A crown rumored to be blessed by the Ezekiel himself. Is that real one or just another fake crown merchant sold you?",HJT_CROWN);
		public const JIANGCT:HeadJewelry = new HeadJewelry("JiangCT", "JiangshiCurseTag", "Jiangshi Curse Tag", "a Jiangshi Curse Tag", 0, 0, 400, "This item controls and alter your bodily function.",HJT_HELMET);
		
		public function HeadJewelryLib()
		{
		}
	}
}
