package classes.Items
{
	/**
	 * ...
	 * @author Kitteh6660
	 */

import classes.Items.Jewelries.*;
import classes.PerkLib;

//Enchantment IDs
	/*
	 * 0: Nothing
	 * 1: Minimum lust
	 * 2: Fertility
	 * 3: Soulforce
	 * 4: Fatigue
	 * 5: HP
	 * 6: Attack power
	 * 7: Spell power
	 * 8: Purity
	 * 9: Corruption
	 
	 */
	
	public final class JewelryLib extends ItemConstants
	{
		public static const MODIFIER_MINIMUM_LUST:int = 	RINGEFF_MINLUST;
		public static const MODIFIER_FERTILITY:int = 		RINGEFF_FERTILITY;
		public static const MODIFIER_SF:int = 				RINGEFF_SF;
		public static const MODIFIER_MP:int = 				RINGEFF_MP;
		public static const MODIFIER_HP:int = 				RINGEFF_HP;
		public static const MODIFIER_ATTACK_POWER:int = 	RINGEFF_ATTACK_POWER;
		public static const MODIFIER_SPELL_POWER:int = 		RINGEFF_SPELL_POWER;
		public static const PURITY:int = 					RINGEFF_PURITY;
		public static const CORRUPTION:int = 				RINGEFF_CORRUPTION;
		public static const MODIFIER_WR:int = 				RINGEFF_WR;
		public static const MODIFIER_R_ATTACK_POWER:int =	RINGEFF_R_ATTACK_POWER;
		public static const MODIFIER_SOUL_POWER:int = 		RINGEFF_SOUL_POWER;
//		public static const MODIFIER_FIRE_R:int = 			;// add 'res_fire' buff
//		public static const MODIFIER_ICE_R:int = 			;// add 'res_ice' buff
//		public static const MODIFIER_LIGH_R:int = 			;// add 'res_lightning' buff
//		public static const MODIFIER_DARK_R:int = 			;// add 'res_darkness' buff
//		public static const MODIFIER_POIS_R:int = 			;// add 'res_poison' buff
//		public static const MODIFIER_MAGIC_R:int = 			;// add 'res_magic' buff
//		public static const MODIFIER_LUST_R:int = 			;// add 'res_lust' buff
//		public static const MODIFIER_PHYS_R:int = 			;// add 'res_physical' buff
		
		public static const DEFAULT_VALUE:Number = 6;//base cost 200 gems, each effect increase up to 2x cost
		
		public static const NOTHING:Nothing = new Nothing();
		
		//Pre-Enchanted rings
		public const CRIMRNG:Jewelry = new Jewelry("CrimRng", "Crimst.Ring", "crimstone ring", "an enchanted crimstone ring", RINGEFF_MINLUST, 10, 1000, "This ring is topped with crimstone. It is said that this will help to keep your desires burning.").withBuffs({'minlust':10}) as Jewelry;
		public const FERTRNG:Jewelry = new Jewelry("FertRng", "FertiteRing", "fertite ring", "an enchanted fertite ring", MODIFIER_FERTILITY, 20, 1000, "This ring is topped with fertite. It is said that this will make you more virile and fertile.");
		public const ICE_RNG:Jewelry = new Jewelry("Ice_Rng", "Icestn.Ring", "icestone ring", "an enchanted icestone ring", RINGEFF_MINLUST, -10, 2000, "This ring is topped with icestone. It is said that this will counter ever-burning desires.").withBuffs({'minlust':-10}) as Jewelry;
		public const SOULRNG:Jewelry = new Jewelry("SoulRng", "Soul Ring", "soulmetal ring", "a soulmetal ring", MODIFIER_SF, 100, 1250, "This simple ring is made from low quality soulmetal. Despite it seemly simplicity it allow for slight compresion of it weaver soulforce allowing storing a little bit more of it.");
		public const MANARNG:Jewelry = new Jewelry("ManaRng", "Mana Ring", "ring of mana", "an enchanted alexandrite ring of mana", MODIFIER_MP, 200, 1250, "This ring is topped with alexandrite gemstone. It is said that this will make you feel having more mana.");
		public const LIFERNG:Jewelry = new Jewelry("LifeRng", "Life Ring", "ring of life", "an enchanted emerald ring of life force", MODIFIER_HP, 350, 1000, "This ring is topped with emerald gemstone. It is said that this will make you feel healthier.");
		public const WRATRNG:Jewelry = new Jewelry("WratRng", "Wrath Ring", "ring of wrath", "an enchanted peridot ring of wrath", MODIFIER_WR, 175, 1000, "This ring is topped with peridot gemstone. It is said that this will make you feel angrier.");
		public const MYSTRNG:Jewelry = new Jewelry("MystRng", "Mystic Ring", "ring of mysticality", "an enchanted sapphire ring of mysticality", MODIFIER_SPELL_POWER, 25, 1500, "This ring is topped with sapphire gemstone. It is said that this will make your spells more powerful.");
        public const SPIRRNG:Jewelry = new Jewelry("SpirRng", "Spiritual Ring", "ring of spiritual enlightenment", "an enchanted realgar ring of spiritual enlightenment", MODIFIER_SOUL_POWER, 25, 1500, "This ring is topped with realgar crystal. It is said that this will make your soulskills more powerful.");
        public const POWRRNG:Jewelry = new Jewelry("PowrRng", "Power Ring", "ring of power (M)", "an enchanted ruby ring of power (M)", MODIFIER_ATTACK_POWER, 10, 1500, "This ring is topped with ruby gemstone. It is said that this will make your melee attacks feel a bit more powerful.");
		public const RPOWRNG:Jewelry = new Jewelry("RPowRng", "R. Power Ring", "ring of power (R)", "an enchanted ruby ring of power (R)", MODIFIER_R_ATTACK_POWER, 10, 1500, "This ring is topped with ruby gemstone. It is said that this will make your range attacks feel a bit more powerful.");
		public const PURERNG:Jewelry = new Jewelry("PureRng", "Purity Ring", "purity ring", "an enchanted purity ring", PURITY, 10, 3000, "This ring symbolizes chastity and purity. When worn, it reduces minimum libido and makes it harder for you to get turned on.");
		public const TSRNG  :Jewelry = new Jewelry("TSRng  ", "T.S.Ring", "training soul ring", "a training soul ring", 0, 0, 100, "This simple ring is made from special forged soulmetal. It help train soulforce to the uttermost limit for novice soul cultivator.");
		public const RINGDEA:Jewelry = new Jewelry("RingDeA", "RingDeadeyeAim", "Ring of Deadeye Aim", "a Ring of Deadeye Aim", 0, 0, 600, "This unique ring helps to remove the ranged accuracy penalty due to flying, and increases ranged accuracy by 20%.");
		public const RNGAMBI:Jewelry = new Jewelry("RngAmbi", "RingOfAmbidexty", "Ring of Ambidexterity", "a Ring of Ambidexterity", 0, 0, 600, "This unique ring helps to remove the melee accuracy penalty due to flying, and increases melee accuracy by 15%.");
		public const FIRERNG:Jewelry = new Jewelry("FireRng", "Fire Ring", "ring of fire protection", "an enchanted ruby ring of fire protection", 0, 0, 800, "This ring is topped with ruby gemstone. It is said that this will make you protected from fire.").withBuffs({'res_fire':5}) as Jewelry;
		public const ICERNG :Jewelry = new Jewelry("IceRng ", "Ice Ring", "ring of ice protection", "an enchanted sapphire ring of ice protection", 0, 0, 800, "This ring is topped with sapphire gemstone. It is said that this will make you protected from ice.").withBuffs({'res_ice':5}) as Jewelry;
		public const LIGHRNG:Jewelry = new Jewelry("LighRng", "Ligh Ring", "ring of lightning protection", "an enchanted lapis lazuli ring of lightning protection", 0, 0, 800, "This ring is topped with lapis lazuli gemstone. It is said that this will make you protected from lightning.").withBuffs({'res_lightning':5}) as Jewelry;
		public const DARKRNG:Jewelry = new Jewelry("DarkRng", "Dark Ring", "ring of darkness protection", "an enchanted onyx ring of darkness protection", 0, 0, 800, "This ring is topped with onyx gemstone. It is said that this will make you protected from darkness.").withBuffs({'res_darkness':5}) as Jewelry;
		public const POISRNG:Jewelry = new Jewelry("PoisRng", "Pois Ring", "ring of poison protection", "an enchanted pearl ring of poison protection", 0, 0, 800, "This ring is topped with pearl. It is said that this will make you protected from poison.").withBuffs({'res_poison':5}) as Jewelry;
		public const LUSTRNG:Jewelry = new Jewelry("LustRng", "Lust Ring", "ring of lust protection", "an enchanted amethyst ring of lust protection", 0, 0, 1200, "This ring is topped with amethyst gemstone. It is said that this will make you protected from lust.").withBuffs({'res_lust':5}) as Jewelry;
		public const MAGIRNG:Jewelry = new Jewelry("MagiRng", "Magic Ring", "ring of magical protection", "an enchanted pyrite ring of magical protection", 0, 0, 1600, "This ring is topped with pyrite gemstone. It is said that this will make you protected from magic.").withBuffs({'res_magic':2}) as Jewelry;
		public const PHYSRNG:Jewelry = new Jewelry("PhysRng", "Phys Ring", "ring of physical protection", "an enchanted hematite ring of physical protection", 0, 0, 1600, "This ring is topped with hematite gemstone. It is said that this will make you protected from physical harm.").withBuffs({'res_physical':3}) as Jewelry;
		//armor, mag resis protection rings
		public const UNDKINS:Jewelry = new Jewelry("UndKinS", "UndefKingSignet", "Undefeated King's Signet", "an Undefeated King's Signet", MODIFIER_WR, 100, 2000, "A signet that belonged in the past to the king, which claimed to be undefeated. But then how it get into your hands?");
		public const FLLIRNG:Jewelry = new Jewelry("FlLiRng", "FlameLizardRing", "Flame Lizard ring", "an Flame Lizard ring", MODIFIER_WR, 75, 3200, "Ring is encrusted with a few small emerald, peridot and carnelian gemstones. Usefull to use Lustzerker or boost it.", "Special: Generate 2/1 wrath per turn/hour. Allow to use Lustzerker.");
		public const INMORNG:Jewelry = new Jewelry("InMoRng", "InfernalMouseRing", "Infernal Mouse ring", "an Infernal Mouse ring", MODIFIER_WR, 75, 3200, "Ring is encrusted with a few small emerald, peridot and sunstone gemstones. Usefull to use Blazing battle spirit or boost it.", "Special: Generate 2/1 wrath per turn/hour. Allow to use Blazing battle spirit.");
		public const MSIGNIT:Jewelry = new Jewelry("MSignit", "Medius Signet", "Medius Signet", "a Medius Signet", 0, 0, 800, "A gift from your mentor, this ring bears the seal of an extinct clan of magi.", "Special: Ambition (+20% spell effect multiplier, 15% power boost/cost reduction for white magic)")
				.withPerk(PerkLib.Ambition,0.2,0.15,0,0) as Jewelry;
		public const RINGINT:Jewelry = new Jewelry("RingInt", "RingOfIntelligence", "Ring of Intelligence", "a Ring of Intelligence", 0, 0, 800, "A simple ring to boost intelligence.").withBuffs({'int.mult':0.05}) as Jewelry;
		public const RINGLIB:Jewelry = new Jewelry("RingLib", "RingOfLibido", "Ring of Libido", "a Ring of Libido", 0, 0, 800, "A simple ring to boost libido.").withBuffs({'lib.mult':0.05}) as Jewelry;
		public const RINGSEN:Jewelry = new Jewelry("RingSen", "RingOfSensitivity", "Ring of Sensitivity", "a Ring of Sensitivity", 0, 0, 800, "A simple ring to boost sensitivity.").withBuffs({'sens':5}) as Jewelry;
		public const RINGSPE:Jewelry = new Jewelry("RingSpe", "RingOfSpeed", "Ring of Speed", "a Ring of Speed", 0, 0, 800, "A simple ring to boost speed.").withBuffs({'spe.mult':0.05}) as Jewelry;
		public const RINGSTR:Jewelry = new Jewelry("RingStr", "RingOfStrength", "Ring of Strength", "a Ring of Strength", 0, 0, 800, "A simple ring to boost strength.").withBuffs({'str.mult':0.05}) as Jewelry;
		public const RINGTOU:Jewelry = new Jewelry("RingTou", "RingOfToughness", "Ring of Toughness", "a Ring of Toughness", 0, 0, 800, "A simple ring to boost toughness.").withBuffs({'tou.mult':0.05}) as Jewelry;
		public const RINGWIS:Jewelry = new Jewelry("RingWis", "RingOfWisdom", "Ring of Wisdom", "a Ring of Wisdom", 0, 0, 800, "A simple ring to boost wisdom.").withBuffs({'wis.mult':0.05}) as Jewelry;
		public const EZEKIELS:Jewelry = new Jewelry("EzekielS", "EzekielSignet", "Ezekiel's Signet", "an Ezekiel's Signet", 0, 0, 100, "A signet rumored to be blessed by the Ezekiel himself. Is that real one or just another fake signet merchant sold you?", "Special: -1 to internal chimerical disposition");
		public const CHIMEMBR:Jewelry = new Jewelry("ChimEmbr", "ChimericEmbrace", "Chimeric Embrace", "a Chimeric Embrace", 0, 0, 400, "This shining ring is made of gold.");
		//public const RINGWIS:Bullseye = new RingWisdom();

		public const STARBAND:Jewelry = new StarfireBand();
		//Normal ring
		public const DIAMRNG:Jewelry = new Jewelry("DiamRng", "Diam Ring", "gold and diamond ring", "a shining gold and diamond ring", 0, 0, 1000, "This shining ring is made of gold and topped with diamond. Truly expensive.");
		public const GOLDRNG:Jewelry = new Jewelry("GoldRng", "Gold Ring", "gold ring", "a shining gold ring", 0, 0, 400, "This shining ring is made of gold.");
		public const LTHCRNG:Jewelry = new Jewelry("LthcRng", "Lethic.Ring", "lethicite ring", "a glowing lethicite ring", 1, 0, 5000, "This ring appears to be made of platinum with some lethicite crystal. Very expensive as lethicite is rare.");
		public const PLATRNG:Jewelry = new Jewelry("PlatRng", "Plat Ring", "platinum ring", "a shining platinum ring", 0, 0, 1000, "This shining ring is made of platinum, one of the rare precious metals. It looks expensive!");
		public const SILVRNG:Jewelry = new Jewelry("SilvRng", "Silver Ring", "silver ring", "a normal silver ring", 0, 0, 200, "This ring looks like it's made of silver.");
		public const ENDGRNG:Jewelry = new Jewelry("EndgRng", "Engagement Ring", "engagement ring", "an engagement ring", 0, 0, 200, "A symbol of eternal love to gift to someone else. Indispensable to any wedding.");
		
		public function JewelryLib()
		{
		}
	}
}
