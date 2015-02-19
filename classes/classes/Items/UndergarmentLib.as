package classes.Items 
{
	/**
	 * ...
	 * @author Kitteh6660
	 */
	import classes.Items.Undergarments.*;
	import classes.PerkLib;
	import classes.PerkType;
	
	public final class UndergarmentLib 
	{
		public static const DEFAULT_VALUE:Number = 6;
		
		public static const TYPE_UPPERWEAR:int = 0;
		public static const TYPE_LOWERWEAR:int = 1;
		public static const TYPE_FULLWEAR:int  = 2;
		
		//public static const COMFORTABLE_UNDERCLOTHES:Undergarment = new ComfortableUnderclothes();
		public static const NOTHING:Undergarment = new Nothing();
		
		//Upper
		public const C_BRA:Undergarment = new Undergarment("C. Bra ", "C. Bra", "comfortable bra", "a pair of comfortable bra", TYPE_UPPERWEAR, DEFAULT_VALUE, "A generic pair of bra. \n\nType: Undergarment (Upper)");
		public const LTX_BRA:Undergarment = new Undergarment("Ltx.Bra", "Latex Bra", "latex bra", "a pair of latex bra", TYPE_UPPERWEAR, 250, "This bra is black and shiny, obviously made of latex. It's designed to fit snugly against your breasts. \n\nType: Undergarment (Upper) \nBase value: 250 \nSpecial: Increases tease effectiveness by 1.");
		public const SS_BRA:Undergarment = new Undergarment("SS. Bra", "S.Silk Bra", "spider-silk bra", "a pair of spider-silk bra", TYPE_UPPERWEAR, 1000, "This bra looks incredibly comfortable. It's as white as snow and finely woven with hundreds of strands of spider silk. \nBase value: 1,000 \nType: Undergarment (Upper) \n\nDefense: 1");
		
		//Lower
		public const C_LOIN:Undergarment = new Undergarment("C. Loin", "C. Loin", "comfortable loincloth", "a pair of comfortable loincloth", TYPE_LOWERWEAR, DEFAULT_VALUE, "A generic pair of loincloth. \n\nType: Undergarment (Lower)");
		public const C_PANTY:Undergarment = new Undergarment("C.Panty", "C.Panties", "comfortable panties", "a pair of comfortable panties", TYPE_LOWERWEAR, DEFAULT_VALUE, "A generic pair of panties. \n\nType: Undergarment (Lower)");
		public const FURLOIN:Undergarment = new Undergarment("FurLoin", "FurLoin", "fur loincloth", "a front and back set of loincloths", TYPE_LOWERWEAR, DEFAULT_VALUE, "A pair of loincloths to cover your crotch and butt.  Typically worn by people named 'Conan'. \n\nType: Undergarment (Lower) \nDefense: 0 \nBase value: 100 \n\nType: Undergarment (Lower)");
		public const GARTERS:Undergarment = new Undergarment("Garters", "Garters", "stockings and garters", "a pair of stockings and garters", TYPE_LOWERWEAR, DEFAULT_VALUE, "These pairs of stockings, garters and lingerie are perfect for seducing your partner! \n\nType: Undergarment (Lower) \nBase value: 100 \nSpecial: Increases tease effectiveness by 1.");
		public const LTXTHNG:Undergarment = new Undergarment("LtxThng", "Latex Thong", "latex thong", "a pair of latex thong", TYPE_LOWERWEAR, 300, "This thong is black and shiny, obviously made of latex. It's designed to fit snugly against your form. \n\nType: Undergarment (Lower) \nBase value: 300 \nSpecial: Increases tease effectiveness by 1.");
		public const LTXSHRT:Undergarment = new Undergarment("LtxShrt", "Latex Shorts", "latex shorts", "a pair of latex shorts", TYPE_LOWERWEAR, 300, "These shorts are black and shiny, obviously made of latex. It's designed to fit snugly against your form. \n\nType: Undergarment (Lower) \nBase value: 300 \nSpecial: Increases tease effectiveness by 1.");
		public const SS_LOIN:Undergarment = new Undergarment("SS.Loin", "S.Silk Loin", "spider-silk loincloth", "a spider-silk loincloth", TYPE_LOWERWEAR, 1000, "This loincloth looks incredibly comfortable. It's as white as snow and finely woven with hundreds of strands of spider silk.  \n\nType: Undergarment (Lower) \nBase value: 1,000 \nDefense: 1");
		public const SSPANTY:Undergarment = new Undergarment("SS.Panty", "S.Silk Panties", "spider-silk panties", "a pair of spider-silk panties", TYPE_LOWERWEAR, 1000, "These panties look incredibly comfortable. It's as white as snow and finely woven with hundreds of strands of spider silk. \n\nType: Undergarment (Lower) \nBase value: 1,000 \nDefense: 1");
		
		public function UndergarmentLib() 
		{
		}
		
	}

}