package classes.Items 
{
	/**
	 * ...
	 * @author Kitteh6660
	 */
	import classes.Items.Jewelries.*;
	import classes.PerkLib;
	import classes.PerkType;

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
	
	public final class JewelryLib
	{
		public static const MODIFIER_MINIMUM_LUST:int = 	1;
		public static const MODIFIER_FERTILITY:int = 		2;
		public static const MODIFIER_SF:int = 				3;
		public static const MODIFIER_MP:int = 				4;
		public static const MODIFIER_HP:int = 				5;
		public static const MODIFIER_ATTACK_POWER:int = 	6;
		public static const MODIFIER_SPELL_POWER:int = 		7;
		public static const PURITY:int = 					8;
		public static const CORRUPTION:int = 				9;
		public static const MODIFIER_WR:int = 				10;
		public static const MODIFIER_R_ATTACK_POWER:int =	11;
		public static const MODIFIER_FIRE_R:int = 			12;
		public static const MODIFIER_ICE_R:int = 			13;
		public static const MODIFIER_LIGH_R:int = 			14;
		public static const MODIFIER_DARK_R:int = 			15;
		public static const MODIFIER_POIS_R:int = 			16;
		public static const MODIFIER_MAGIC_R:int = 			17;
		public static const MODIFIER_LUST_R:int = 			18;
		
		public static const DEFAULT_VALUE:Number = 6;
		
		public static const NOTHING:Nothing = new Nothing();
		
		//Pre-Enchanted rings
		public const CRIMRNG:Jewelry = new Jewelry("CrimRng", "Crimst.Ring", "crimstone ring", "an enchanted crimstone ring", MODIFIER_MINIMUM_LUST, 10, 1000, "This ring is topped with crimstone. It is said that this will help to keep your desires burning. \n\nType: Jewelry (Ring) \nBase value: 1,000 \nSpecial: Increases minimum lust by 10.","Ring");
		public const FERTRNG:Jewelry = new Jewelry("FertRng", "FertiteRing", "fertite ring", "an enchanted fertite ring", MODIFIER_FERTILITY, 20, 1000, "This ring is topped with fertite. It is said that this will make you more virile and fertile. \n\nType: Jewelry (Ring) \nBase value: 1,000 \nSpecial: Increases cum production by 20 percent and ferility by 20.","Ring");
		public const ICE_RNG:Jewelry = new Jewelry("Ice_Rng", "Icestn.Ring", "icestone ring", "an enchanted icestone ring", MODIFIER_MINIMUM_LUST, -10, 2000, "This ring is topped with icestone. It is said that this will counter ever-burning desires. \n\nType: Jewelry (Ring) \nBase value: 2,000 \nSpecial: Reduces minimum lust by 10.","Ring");
		public const SOULRNG:Jewelry = new Jewelry("SoulRng", "Soul Ring", "soulmetal ring", "a soulmetal ring", MODIFIER_SF, 100, 1250, "This simple ring is made from low quality soulmetal. Despite it seemly simplicity it allow for slight compresion of it weaver soulforce allowing storing a little bit more of it. \n\nType: Jewelry (Ring) \nBase value: 1250 \nSpecial: Increases maximum Soulforce by 100.","Ring");
		public const MANARNG:Jewelry = new Jewelry("ManaRng", "Mana Ring", "ring of mana", "an enchanted alexandrite ring of mana", MODIFIER_MP, 200, 1250, "This ring is topped with alexandrite gemstone. It is said that this will make you feel having more mana. \n\nType: Jewelry (Ring) \nBase value: 1,250 \nSpecial: Increases maximum Mana by 200.","Ring");
		public const LIFERNG:Jewelry = new Jewelry("LifeRng", "Life Ring", "ring of life", "an enchanted emerald ring of life force", MODIFIER_HP, 350, 1000, "This ring is topped with emerald gemstone. It is said that this will make you feel healthier. \n\nType: Jewelry (Ring) \nBase value: 1,000 \nSpecial: Increases maximum HP by 350.","Ring");
		public const WRATRNG:Jewelry = new Jewelry("WratRng", "Wrath Ring", "ring of wrath", "an enchanted peridot ring of wrath", MODIFIER_WR, 175, 1000, "This ring is topped with peridot gemstone. It is said that this will make you feel angrier. \n\nType: Jewelry (Ring) \nBase value: 1,000 \nSpecial: Increases maximum Wrath by 175.","Ring");
		public const MYSTRNG:Jewelry = new Jewelry("MystRng", "Mystic Ring", "ring of mysticality", "an enchanted sapphire ring of mysticality", MODIFIER_SPELL_POWER, 25, 1500, "This ring is topped with sapphire gemstone. It is said that this will make your spells more powerful. \n\nType: Jewelry (Ring) \nBase value: 1,500 \nSpecial: Increases spellpower by 25 percent.","Ring");
		public const POWRRNG:Jewelry = new Jewelry("PowrRng", "Power Ring", "ring of power (M)", "an enchanted ruby ring of power (M)", MODIFIER_ATTACK_POWER, 10, 1500, "This ring is topped with ruby gemstone. It is said that this will make your melee attacks feel a bit more powerful. \n\nType: Jewelry (Ring) \nBase value: 1,500 \nSpecial: Increases melee damage by 10 percent.","Ring");
		public const RPOWRNG:Jewelry = new Jewelry("RPowRng", "R. Power Ring", "ring of power (R)", "an enchanted ruby ring of power (R)", MODIFIER_R_ATTACK_POWER, 10, 1500, "This ring is topped with ruby gemstone. It is said that this will make your range attacks feel a bit more powerful. \n\nType: Jewelry (Ring) \nBase value: 1,500 \nSpecial: Increases range damage by 10 percent.","Ring");
		public const PURERNG:Jewelry = new Jewelry("PureRng", "Purity Ring", "purity ring", "an enchanted purity ring", PURITY, 10, 3000, "This ring symbolizes chastity and purity. When worn, it reduces minimum libido and makes it harder for you to get turned on. \n\nType: Jewelry (Ring) \nBase value: 3,000 \nSpecial: Slowly decreases the corruption of the wearer over time. Reduces minimum libido by 10.","Ring");
		public const TSRNG  :Jewelry = new Jewelry("TSRng  ", "T.S.Ring", "training soul ring", "a training soul ring", 0, 0, 100, "This simple ring is made from special forged soulmetal. It help train soulforce to the uttermost limit for novice soul cultivator. \n\nType: Jewelry (Ring) \nBase value: 100.","Ring");
		public const RINGDEA:Jewelry = new Jewelry("RingDeA", "RingDeadeyeAim", "Ring of deadeye aim", "a Ring of deadeye aim", 0, 0, 800, "This unique ring helps to remove range accuracy penalty due to flying and increase by 20% range accuracy. \n\nType: Jewelry (Ring) \nBase value: 800.","Ring");
		public const RNGAMBI:Jewelry = new Jewelry("RngAmbi", "RingOfAmbidexty", "Ring of Ambidexty", "a Ring of Ambidexty", 0, 0, 800, "This unique ring helps to remove melee accuracy penalty due to flying and increase by 15% melee accuracy. \n\nType: Jewelry (Ring) \nBase value: 800.","Ring");
		public const FIRERNG:Jewelry = new Jewelry("FireRng", "Fire Ring", "ring of fire protection", "an enchanted ruby ring of fire protection", MODIFIER_FIRE_R, 5, 800, "This ring is topped with ruby gemstone. It is said that this will make you protected from fire. \n\nType: Jewelry (Ring) \nBase value: 800 \nSpecial: Increases fire resistance by 5%.","Ring");
		public const ICERNG :Jewelry = new Jewelry("IceRng ", "Ice Ring", "ring of ice protection", "an enchanted sapphire ring of ice protection", MODIFIER_ICE_R, 5, 800, "This ring is topped with sapphire gemstone. It is said that this will make you protected from ice. \n\nType: Jewelry (Ring) \nBase value: 800 \nSpecial: Increases ice resistance by 5%.","Ring");
		public const LIGHRNG:Jewelry = new Jewelry("LighRng", "Ligh Ring", "ring of lightning protection", "an enchanted lapis lazuli ring of lightning protection", MODIFIER_LIGH_R, 5, 800, "This ring is topped with lapis lazuli gemstone. It is said that this will make you protected from lightning. \n\nType: Jewelry (Ring) \nBase value: 800 \nSpecial: Increases lightning resistance by 5%.","Ring");
		public const DARKRNG:Jewelry = new Jewelry("DarkRng", "Dark Ring", "ring of darkness protection", "an enchanted onyx ring of darkness protection", MODIFIER_DARK_R, 5, 800, "This ring is topped with onyx gemstone. It is said that this will make you protected from darkness. \n\nType: Jewelry (Ring) \nBase value: 800 \nSpecial: Increases darkness resistance by 5%.","Ring");
		public const POISRNG:Jewelry = new Jewelry("PoisRng", "Pois Ring", "ring of poison protection", "an enchanted pearl ring of poison protection", MODIFIER_POIS_R, 5, 800, "This ring is topped with pearl. It is said that this will make you protected from poison. \n\nType: Jewelry (Ring) \nBase value: 800 \nSpecial: Increases poison resistance by 5%.","Ring");
		public const LUSTRNG:Jewelry = new Jewelry("LustRng", "Lust Ring", "ring of lust protection", "an enchanted amethyst ring of lust protection", MODIFIER_LUST_R, 5, 1200, "This ring is topped with amethyst gemstone. It is said that this will make you protected from lust. \n\nType: Jewelry (Ring) \nBase value: 1,200 \nSpecial: Increases lust resistance by 5%.","Ring");
		//armor, mag resis protection rings
		public const UNDKINS:Jewelry = new Jewelry("UndKinS", "UndefKingSignet", "Undefeated King's Signet", "an Undefeated King's Signet", MODIFIER_WR, 100, 2000, "A signet that belonged in the past to the king, which claimed to be undefeated. But then how it get into your hands?","Ring");
		public const FLLIRNG:Jewelry = new Jewelry("FlLiRng", "FlameLizardRing", "Flame Lizard ring", "an Flame Lizard ring", MODIFIER_WR, 75, 3200, "Ring is encrusted with a few small emerald, peridot and carnelian gemstones. Usefull to use Lustzerker or boost it. \n\nType: Jewelry (Ring) \nBase value: 1,000 \nSpecial: Increases maximum Wrath by 75. Generate 2/1 wrath per turn/hour. Allow to use Lustzerker.","Ring");
		//public const FLLIRNG:FlameLizardRing = new FlameLizardRing();
		public const INMORNG:Jewelry = new Jewelry("InMoRng", "InfernalMouseRing", "Infernal Mouse ring", "an Infernal Mouse ring", MODIFIER_WR, 75, 3200, "Ring is encrusted with a few small emerald, peridot and sunstone gemstones. Usefull to use Blazing battle spirit or boost it. \n\nType: Jewelry (Ring) \nBase value: 1,000 \nSpecial: Increases maximum Wrath by 75. Generate 2/1 wrath per turn/hour. Allow to use Blazing battle spirit.","Ring");
		//public const INMORNG:InfernalMouseRing = new InfernalMouseRing();
		public const MSIGNIT:MediusSignet = new MediusSignet();
		public const RINGINT:RingOfIntelligence = new RingOfIntelligence();
		public const RINGLIB:RingOfLibido = new RingOfLibido();
		public const RINGSEN:RingOfSensitivity = new RingOfSensitivity();
		public const RINGSPE:RingOfSpeed = new RingOfSpeed();
		public const RINGSTR:RingOfStrength = new RingOfStrength();
		public const RINGTOU:RingOfToughness = new RingOfToughness();
		public const RINGWIS:RingOfWisdom = new RingOfWisdom();
		//public const RINGWIS:Bullseye = new RingWisdom();
			
		//Normal ring
		public const DIAMRNG:Jewelry = new Jewelry("DiamRng", "Diam Ring", "gold and diamond ring", "a shining gold and diamond ring", 0, 0, 1000, "This shining ring is made of gold and topped with diamond. Truly expensive. \n\nType: Jewelry (Ring) \nBase value: 1,000","Ring");
		public const GOLDRNG:Jewelry = new Jewelry("GoldRng", "Gold Ring", "gold ring", "a shining gold ring", 0, 0, 400, "This shining ring is made of gold. \n\nType: Jewelry (Ring) \nBase value: 400","Ring");
		public const LTHCRNG:Jewelry = new Jewelry("LthcRng", "Lethic.Ring", "lethicite ring", "a glowing lethicite ring", 1, 0, 5000, "This ring appears to be made of platinum with some lethicite crystal. Very expensive as lethicite is rare. \n\nType: Jewelry (Ring) \nBase value: 5,000","Ring");
		public const PLATRNG:Jewelry = new Jewelry("PlatRng", "Plat Ring", "platinum ring", "a shining platinum ring", 0, 0, 1000, "This shining ring is made of platinum, one of the rare precious metals. It looks expensive! \n\nType: Jewelry (Ring) \nBase value: 1,000","Ring");
		public const SILVRNG:Jewelry = new Jewelry("SilvRng", "Silver Ring", "silver ring", "a normal silver ring", 0, 0, 200, "This ring looks like it's made of silver. \n\nType: Jewelry (Ring) \nBase value: 200","Ring");
		
		/*private static function mk(id:String,shortName:String,name:String,longName:String,effectId:Number,effectMagnitude:Number,value:Number,description:String,type:String,perk:String=""):Jewelry {
			return new Jewelry(id,shortName,name,longName,effectId,effectMagnitude,value,description,type,perk);
		}*/
		/*private static function mk2(id:String,shortName:String,name:String,longName:String,def:Number,value:Number,description:String,perk:String,
				playerPerk:PerkType,playerPerkV1:Number,playerPerkV2:Number,playerPerkV3:Number,playerPerkV4:Number,playerPerkDesc:String=null):ArmorWithPerk{
			return new ArmorWithPerk(id,shortName,name,longName,def,value,description,perk,
					playerPerk,playerPerkV1,playerPerkV2,playerPerkV3,playerPerkV4);
		}*/
		public function JewelryLib()
		{
		}
	}

}