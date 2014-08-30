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
	 * 1: Increased minimum lust
	 * 2: Decreased minimum lust
	 * 3: Increased fertility
	 * 4: Decreased fertility
	 * 5: Increased HP
	 * 6: Increased power
	 * 7: Purity 
	 * 8: Corruption 
	 */
	
	//Some rings are dummied out because it doesn't work properly. Surely it could be equipped but it has no effects.
	public final class JewelryLib
	{
		public static const DEFAULT_VALUE:Number = 6;
		
		public static const NOTHING:Nothing = new Nothing();
		
		//Pre-Enchanted rings
		public const CRIMRNG:Jewelry = mk("CrimRng", "Crimst.Ring", "crimstone ring", "an enchanted crimstone ring", 1, 10, 1000, "This ring is topped with crimstone. It is said that this will help to keep your desires burning. \n\nType: Jewelry (Ring) \nBase value: 1,000 \nSpecial: Increases minimum lust by 10.","Ring");
		public const ICE_RNG:Jewelry = mk("Ice_Rng", "Icestn.Ring", "icestone ring", "an enchanted icestone ring", 2, 10, 2000, "This ring is topped with icestone. It is said that this will counter ever-burning desires. \n\nType: Jewelry (Ring) \nBase value: 2,000 \nSpecial: Reduces minimum lust by 10.","Ring");
		public const FERTRNG:Jewelry = mk("FertRng", "FertiteRing", "fertite ring", "an enchanted fertite ring", 3, 20, 1000, "This ring is topped with fertite. It is said that this will make you more virile and fertile. \n\nType: Jewelry (Ring) \nBase value: 1,000 \nSpecial: Increases cum production and fertility by 20 percent.","Ring");
		public const LIFERNG:Jewelry = mk("LifeRng", "Life Ring", "ring of life", "an enchanted ruby ring of life force", 5, 25, 1000, "This ring is topped with emerald gemstome. It is said that this will make you feel a bit healthier. \n\nType: Jewelry (Ring) \nBase value: 1,000 \nSpecial: Increases maximum HP by 25.","Ring");
		public const POWRRNG:Jewelry = mk("PowrRng", "Power Ring", "ring of power", "an enchanted emerald ring of power", 6, 10, 1500, "This ring is topped with ruby gemstome. It is said that this will make you feel a bit powerful. \n\nType: Jewelry (Ring) \nBase value: 1,500 \nIncreases damage by 10 percent.","Ring");
		public const PURERNG:Jewelry = mk("PureRng", "Purity Ring", "purity ring", "an enchanted purity ring", 7, 5, 3000, "This ring symbolizes chastity and purity. When worn, it reduces minimum libido and makes it harder for you to get turned on. \n\nType: Jewelry (Ring) \nBase value: 3,000 \nSpecial: Slowly purifies the wearer over time. Reduces minimum libido by 5.","Ring");
			
		//Normal ring
		public const SILVRNG:Jewelry = mk("SilvRng", "Silver Ring", "silver ring", "a normal silver ring", 0, 0, 200, "This ring looks like it's made of silver. \n\nType: Jewelry (Ring) \nBase value: 200","Ring");
		public const GOLDRNG:Jewelry = mk("GoldRng", "Gold Ring", "gold ring", "a shining gold ring", 0, 0, 400, "This shining ring is made of gold. \n\nType: Jewelry (Ring) \nBase value: 400","Ring");
		public const PLATRNG:Jewelry = mk("PlatRng", "Plat Ring", "platinum ring", "a shining platinum ring", 0, 0, 1000, "This shining ring is made of platinum, one of the rare precious metals. It looks expensive! \n\nType: Jewelry (Ring) \nBase value: 1,000","Ring");
		public const LTHCRNG:Jewelry = mk("LthcRng", "Lethic.Ring", "lethicite ring", "a glowing lethicite ring", 8, 1, 5000, "This ring appears to be made of platinum with some lethicite crystal. Very expensive as lethicite is rare. \n\nType: Jewelry (Ring) \nBase value: 5,000 \nSpecial: Slowly corrupts the wearer over time.","Ring");
		
		private static function mk(id:String,shortName:String,name:String,longName:String,effectId:Number,effectMagnitude:Number,value:Number,description:String,type:String,perk:String=""):Jewelry {
			return new Jewelry(id,shortName,name,longName,effectId,effectMagnitude,value,description,type,perk);
		}
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