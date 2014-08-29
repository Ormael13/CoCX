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
	 * 3: Increased fertility.
	 * 4: Decreased fertility.
	 * 5: Increased HP.
	 * 6: Increased power (not implemented yet)
	 * 7: Purity (not implemented yet)
	 * 8: Corruption (not implemented yet)
	 */
	
	//Some rings are dummied out because it doesn't work properly. Surely it could be equipped but it has no effects.
	public final class JewelryLib
	{
		public static const DEFAULT_VALUE:Number = 6;
		
		public static const NOTHING:Nothing = new Nothing();
		
		//Pre-Enchanted rings
		public const CRIMRNG:Jewelry = mk("CrimRng", "Crimst.Ring", "crimstone ring", "an enchanted crimstone ring", 1, 10, 1000, "This ring is topped with crimstone. It is said that this will help to keep your desires burning. \n\nType: Jewelry (Ring) \nBase value: 1,000 \nIncreases minimum lust by 10.","Ring");
		public const ICE_RNG:Jewelry = mk("Ice_Rng", "Icestn.Ring", "icestone ring", "an enchanted icestone ring", 2, 10, 2000, "This ring is topped with icestone. It is said that this will counter ever-burning desires. \n\nType: Jewelry (Ring) \nBase value: 2,000 \nReduces minimum lust by 10.","Ring");
		public const FERTRNG:Jewelry = mk("FertRng", "FertiteRing", "fertite ring", "an enchanted fertite ring", 3, 10, 1000, "This ring is topped with fertite. It is said that this will make you more virile and fertile. \n\nType: Jewelry (Ring) \nBase value: 1,000 \nIncreases cum production and fertility.","Ring");
		public const LIFERNG:Jewelry = mk("LifeRng", "Life Ring", "ring of life", "an enchanted ruby ring of life force", 5, 25, 1000, "This ring is topped with emerald gemstome. It is said that this will make you feel a bit healthier. \n\nType: Jewelry (Ring) \nBase value: 1,000 \nIncreases maximum HP by 25.","Ring");
		//public const POWRRNG:Jewelry = mk("PowrRng", "Life Ring", "ring of power", "an enchanted emerald ring of power", 6, 10, 1500, "This ring is topped with ruby gemstome. It is said that this will make you feel a bit powerful. \n\nType: Jewelry (Ring) \nBase value: 1,500 \nIncreases damage by 10 percent.","Ring");
		//public const PURERNG:Jewelry = mk("PureRng", "Purity Ring", "purity ring", "an enchanted purity ring", 10, 5, 1000, "This ring symbolizes chastity. When worn, it reduces minimum libido and prevents sex. \n\nType: Jewelry (Ring) \nBase value: 1,000 \nReduces minimum libido by 5. Slows corruption gain.","Ring");
			
		//Normal ring
		public const SILVRNG:Jewelry = mk("SilvRng", "Silver Ring", "silver ring", "a normal silver ring", 0, 0, 200, "This ring looks like it's made of silver. It seems to do nothing when worn. It might fetch a bit of fortune. \n\nType: Jewelry (Ring) \nBase value: 200","Ring");
		public const GOLDRNG:Jewelry = mk("GoldRng", "Gold Ring", "gold ring", "a shining gold ring", 0, 0, 400, "This shining ring is made of gold. It might fetch a nice value. \n\nType: Jewelry (Ring) \nBase value: 400","Ring");
		public const PLATRNG:Jewelry = mk("PlatRng", "Plat Ring", "platinum ring", "a shining platinum ring", 0, 0, 1000, "This shining ring is made of platinum, one of the rare precious metals. It might fetch an incredible price. \n\nType: Jewelry (Ring) \nBase value: 1,000","Ring");
		public const LTHCRNG:Jewelry = mk("LthcRng", "Lethic.Ring", "lethicite ring", "a glowing lethicite ring", 7, 1, 5000, "This ring appears to be made of platinum with some lethicite crystal. \n\nType: Jewelry (Ring) \nBase value: 5,000","Ring");
		
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