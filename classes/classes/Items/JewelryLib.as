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
	 * 3: Critical
	 * 4: Regeneration
	 * 5: HP
	 * 6: Attack power
	 * 7: Spell power
	 * 8: Purity 
	 * 9: Corruption 
	 
	 */
	
	public final class JewelryLib
	{
		public static const MODIFIER_MINIMUM_LUST:int = 1;
		public static const MODIFIER_FERTILITY:int = 	2;
		public static const MODIFIER_CRITICAL:int = 	3;
		public static const MODIFIER_REGENERATION:int = 4;
		public static const MODIFIER_HP:int = 			5;
		public static const MODIFIER_ATTACK_POWER:int = 6;
		public static const MODIFIER_SPELL_POWER:int = 	7;
		public static const PURITY:int = 				8;
		public static const CORRUPTION:int = 			9;
		
		public static const DEFAULT_VALUE:Number = 6;
		
		public static const NOTHING:Nothing = new Nothing();
		
		//Tier 1 rings
		public const CRIMRN1:Jewelry = new Jewelry("CrimRng", "L Crim.Ring", "lesser crimstone ring", "an enchanted crimstone ring", MODIFIER_MINIMUM_LUST, 10, 1000, "This ring is topped with crimstone. It is said that this will help to keep your desires burning. ","Ring");
		public const FERTRN1:Jewelry = new Jewelry("FertRng", "L Fert.Ring", "lesser fertite ring", "an enchanted fertite ring", MODIFIER_FERTILITY, 20, 1000, "This ring is topped with fertite. It is said that this will make you more virile and fertile. ","Ring");
		public const ICE_RN1:Jewelry = new Jewelry("Ice_Rng", "L Icst.Ring", "lesser icestone ring", "an enchanted icestone ring", MODIFIER_MINIMUM_LUST, -10, 2000, "This ring is topped with icestone. It is said that this will counter ever-burning desires. ","Ring");
		public const CRITRN1:Jewelry = new Jewelry("CritRng", "L Crit Ring", "lesser ring of criticality", "an enchanted topaz ring of criticality", MODIFIER_CRITICAL, 3, 1500, "This ring is topped with topaz gemstone. It is said that this will help you to focus and exploit your opponent's weak spots, allowing you to score critical hits more often. ","Ring");
		public const REGNRN1:Jewelry = new Jewelry("RegnRng", "L Regn.Ring", "lesser ring of regeneration", "an enchanted amethyst ring of regeneration", MODIFIER_REGENERATION, 2, 2000, "This ring is topped with amethyst gemstone. It is said that this will hasten your recovery. ","Ring");
		public const LIFERN1:Jewelry = new Jewelry("LifeRng", "L Life Ring", "lesser ring of life", "an enchanted emerald ring of life force", MODIFIER_HP, 30, 1000, "This ring is topped with emerald gemstone. It is said that this will make you feel a bit healthier. ","Ring");
		public const MYSTRN1:Jewelry = new Jewelry("MystRng", "L Mystic Ring", "lesser ring of mysticality", "an enchanted sapphire ring of mysticality", MODIFIER_SPELL_POWER, 20, 1500, "This ring is topped with sapphire gemstone. It is said that this will make your spells more powerful. ","Ring");
		public const POWRRN1:Jewelry = new Jewelry("PowrRng", "L Power Ring", "lesser ring of power", "an enchanted ruby ring of power", MODIFIER_ATTACK_POWER, 6, 1500, "This ring is topped with ruby gemstone. It is said that this will make you feel a bit powerful. ","Ring");
		
		//Tier 2 rings
		public const CRIMRN2:Jewelry = new Jewelry("CrimRn2", "Crim.Ring", "crimstone ring", "an enchanted crimstone ring", MODIFIER_MINIMUM_LUST, 15, 2000, "This ring is topped with crimstone. It is said that this will help to keep your desires burning. ","Ring");
		public const FERTRN2:Jewelry = new Jewelry("FertRn2", "Fert.Ring", "fertite ring", "an enchanted fertite ring", MODIFIER_FERTILITY, 30, 2000, "This ring is topped with fertite. It is said that this will make you more virile and fertile. ","Ring");
		public const ICE_RN2:Jewelry = new Jewelry("Ice_Rn2", "Icst.Ring", "icestone ring", "an enchanted icestone ring", MODIFIER_MINIMUM_LUST, -15, 4000, "This ring is topped with icestone. It is said that this will counter ever-burning desires. ","Ring");
		public const CRITRN2:Jewelry = new Jewelry("CritRn2", "Crit Ring", "ring of criticality", "an enchanted topaz ring of criticality", MODIFIER_CRITICAL, 5, 3000, "This ring is topped with topaz gemstone. It is said that this will help you to focus and exploit your opponent's weak spots, allowing you to score critical hits more often. ","Ring");
		public const REGNRN2:Jewelry = new Jewelry("RegnRn2", "Regn.Ring", "ring of regeneration", "an enchanted amethyst ring of regeneration", MODIFIER_REGENERATION, 3, 4000, "This ring is topped with amethyst gemstone. It is said that this will hasten your recovery. ","Ring");
		public const LIFERN2:Jewelry = new Jewelry("LifeRn2", "Life Ring", "ring of life", "an enchanted emerald ring of life force", MODIFIER_HP, 45, 2000, "This ring is topped with emerald gemstone. It is said that this will make you feel a bit healthier. ","Ring");
		public const MYSTRN2:Jewelry = new Jewelry("MystRn2", "Mystic Ring", "ring of mysticality", "an enchanted sapphire ring of mysticality", MODIFIER_SPELL_POWER, 30, 3000, "This ring is topped with sapphire gemstone. It is said that this will make your spells more powerful. ","Ring");
		public const POWRRN2:Jewelry = new Jewelry("PowrRn2", "Power Ring", "ring of power", "an enchanted ruby ring of power", MODIFIER_ATTACK_POWER, 9, 3000, "This ring is topped with ruby gemstone. It is said that this will make you feel a bit powerful. ","Ring");

		//Tier 3 rings
		public const CRIMRN3:Jewelry = new Jewelry("CrimRn3", "G Crim.Ring", "greater crimstone ring", "an enchanted crimstone ring", MODIFIER_MINIMUM_LUST, 20, 4000, "This ring is topped with crimstone. It is said that this will help to keep your desires burning. ","Ring");
		public const FERTRN3:Jewelry = new Jewelry("FertRn3", "G Fert.Ring", "greater fertite ring", "an enchanted fertite ring", MODIFIER_FERTILITY, 40, 4000, "This ring is topped with fertite. It is said that this will make you more virile and fertile. ","Ring");
		public const ICE_RN3:Jewelry = new Jewelry("Ice_Rn3", "G Icst.Ring", "greater icestone ring", "an enchanted icestone ring", MODIFIER_MINIMUM_LUST, -20, 8000, "This ring is topped with icestone. It is said that this will counter ever-burning desires. ","Ring");
		public const CRITRN3:Jewelry = new Jewelry("CritRn3", "G Crit Ring", "greater ring of criticality", "an enchanted topaz ring of criticality", MODIFIER_CRITICAL, 7, 6000, "This ring is topped with topaz gemstone. It is said that this will help you to focus and exploit your opponent's weak spots, allowing you to score critical hits more often. ","Ring");
		public const REGNRN3:Jewelry = new Jewelry("RegnRn3", "G Regn.Ring", "greater ring of regeneration", "an enchanted amethyst ring of regeneration", MODIFIER_REGENERATION, 4, 8000, "This ring is topped with amethyst gemstone. It is said that this will hasten your recovery. ","Ring");
		public const LIFERN3:Jewelry = new Jewelry("LifeRn3", "G Life Ring", "greater ring of life", "an enchanted emerald ring of life force", MODIFIER_HP, 60, 4000, "This ring is topped with emerald gemstone. It is said that this will make you feel a bit healthier. ","Ring");
		public const MYSTRN3:Jewelry = new Jewelry("MystRn3", "G Mystic Ring", "greater ring of mysticality", "an enchanted sapphire ring of mysticality", MODIFIER_SPELL_POWER, 40, 6000, "This ring is topped with sapphire gemstone. It is said that this will make your spells more powerful. ","Ring");
		public const POWRRN3:Jewelry = new Jewelry("PowrRn3", "G Power Ring", "greater ring of power", "an enchanted ruby ring of power", MODIFIER_ATTACK_POWER, 12, 6000, "This ring is topped with ruby gemstone. It is said that this will make you feel a bit powerful. ","Ring");
		
		//Untiered/Special
		public const PURERNG:Jewelry = new Jewelry("PureRng", "Purity Ring", "lesser purity ring", "an enchanted diamond ring of purity", PURITY, 10, 3000, "This diamond-topped ring symbolizes chastity and purity. When worn, it reduces minimum libido and makes it harder for you to get turned on. ","Ring");
		public const LTHCRNG:Jewelry = new Jewelry("LthcRng", "Lethic.Ring", "lethicite ring", "a glowing lethicite ring", CORRUPTION, 0, 5000, "This ring appears to be made of platinum with some lethicite crystal. Very expensive as lethicite is rare. ","Ring");
		
		//Normal ring
		public const DIAMRNG:Jewelry = new Jewelry("DiamRng", "Diam Ring", "gold and diamond ring", "a shining gold and diamond ring", 0, 0, 1000, "This shining ring is made of gold and topped with diamond. Truly expensive. ","Ring");
		public const GOLDRNG:Jewelry = new Jewelry("GoldRng", "Gold Ring", "gold ring", "a shining gold ring", 0, 0, 400, "This shining ring is made of gold. ","Ring");
		public const PLATRNG:Jewelry = new Jewelry("PlatRng", "Plat Ring", "platinum ring", "a shining platinum ring", 0, 0, 1000, "This shining ring is made of platinum, one of the rare precious metals. It looks expensive! ","Ring");
		public const SILVRNG:Jewelry = new Jewelry("SilvRng", "Silver Ring", "silver ring", "a normal silver ring", 0, 0, 200, "This ring looks like it's made of silver. ","Ring");
		
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