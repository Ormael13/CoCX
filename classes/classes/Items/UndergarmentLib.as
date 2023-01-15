package classes.Items
{
	/**
	 * ...
	 * @author Kitteh6660
	 */

import classes.Items.Undergarments.*;
import classes.PerkLib;

public final class UndergarmentLib extends ItemConstants
	{
		public static const DEFAULT_VALUE:Number = 6;
		
		public static const NOTHING:Undergarment = new Nothing();
		
		//Upper
		public const BN_TOP:Undergarment = new Undergarment("BN. Top", "Neko Top", "black Neko leather top", "a black neko leather top", UT_TOP, 500, 0, 0, 2, "A bra made of leather black as night. Makes one slimmer than it appears, increasing evasion. Stronger at night. \n\nType: Undergarment (Upper)")
				.withBuffs({'evade': +2}) as Undergarment;
		public const C_BRA  :Undergarment = new Undergarment("C. Bra ", "C. Bra", "comfortable bra", "a pair of comfortable bra", UT_TOP, DEFAULT_VALUE, 0, 0, 0, "A generic pair of bra. \n\nType: Undergarment (Upper)");
		public const C_SHIRT:Undergarment = new Undergarment("C.Shirt", "C. Shirt", "comfortable shirt", "a comfortable shirt", UT_TOP, DEFAULT_VALUE, 0, 0, 0, "A generic shirt. \n\nType: Undergarment (Upper)");
		public const COW_BRA:Undergarment = new Undergarment("Cow Bra", "Cow Bra", "cow girl bra", "a cow girl bra", UT_TOP, 1000, 1, 1, 3, "This bra look like ordinary panty at a first glance save for the cow fur like motif. They increase lacta bovina lactation rate as well as the efficiency of Milk blast. Comes with the bonus of accomodating just any breast size and letting milk flow through! \n\nType: Undergarment (Upper)");
		public const DRI_BRA:DriderBra = new DriderBra();
		public const DS_BRA :Undergarment = new Undergarment("DS. Bra", "D.Scale Bra", "dragonscale bra", "a pair of dragonscale bra", UT_TOP, 600, 2, 2, 1, "This bra appears to be made of dragon scale. It's held together with leather straps for flexibility. Great for those on the primal side! \n\nType: Undergarment (Upper)");
		public const DS_VEST:Undergarment = new Undergarment("DS.Vest", "D.Scale Vest", "dragonscale vest", "a dragonscale vest", UT_TOP, 600, 2, 2, 1, "This sleeveless vest is made of dragonscale, treated until it is as light and comfortable as cloth.  However, these treatments have reduced the defensive properties of the dragonscale. \n\nType: Undergarment (Upper)");
		public const EW_CORS:Undergarment = new Undergarment("EW.Cors", "E.W. Corset", "ebonweave corset", "an ebonweave corset", UT_TOP, 900, 3, 1, 2, "This corset is ebonweave, created using refined ebonbloom petals. The ebonweave is elastic, making the corset surprisingly comfortable to wear, while displaying your bust down to the most subtle curves. \n\nType: Undergarment (Upper)");
		public const EW_LBRA:Undergarment = new Undergarment("EW.LBra", "E.W. Laced Bra", "ebonweave laced bra", "an ebonweave laced bra", UT_TOP, 900, 3, 1, 2, ". \n\nType: Undergarment (Upper)");
		public const EW_VEST:Undergarment = new Undergarment("EW.Vest", "E.W. Vest", "ebonweave vest", "an ebonweave vest", UT_TOP, 900, 3, 1, 2, "This vest is ebonweave, created using refined ebonbloom petals. Elastic, form-fitting and somewhat transparent, this comfortable vest will display your curves, masculine or feminine. \n\nType: Undergarment (Upper)");
		public const F_B_TOP:Undergarment = new Undergarment("F.B.Top", "F.Bikini Top", "Fur bikini top", "a pair of Fur bikini top", UT_TOP, 600, 0, 0, 1, "This white fur bikini made from a material similar to yeti fur helps reduce the effect of cold environments. (+10% ice resistance) \n\nType: Undergarment (Upper)");
		public const HBSHIRT:Undergarment = new Undergarment("HBShirt", "HBShirt", "HB shirt", "a HB shirt", UT_TOP, 1500, 3, 3, 0, "A white shirt made from fabric capable to conduct soulforce. \n\nType: Undergarment (Upper)");
		public const LTX_BRA:Undergarment = new Undergarment("Ltx.Bra", "Latex Bra", "latex bra", "a pair of latex bra", UT_TOP, 250, 0, 0, 2, "This bra is black and shiny, obviously made of latex. It's designed to fit snugly against your breasts. \n\nType: Undergarment (Upper)");
		public const SS_BRA :Undergarment = new Undergarment("SS. Bra", "S.Silk Bra", "spider-silk bra", "a pair of spider-silk bra", UT_TOP, 1000, 1, 0, 1, "This bra looks incredibly comfortable. It's as white as snow and finely woven with hundreds of strands of spider silk. \n\nType: Undergarment (Upper)");
		public const SSSHIRT:Undergarment = new Undergarment("SSShirt", "S.Silk Shirt", "spider-silk shirt", "a spider-silk shirt", UT_TOP, 1000, 1, 0, 1, "A comfortable undershirt.  It's as white as snow and woven with hundreds of strands of fine spider silk. \n\nType: Undergarment (Upper)");
		public const STSHIRT:Undergarment = new Undergarment("STShirt", "S.T.Shirt", "soul training shirt", "a soul training shirt", UT_TOP, 200, 0, 0, 0, "A shirt made from fabric capable to help train soulforce. \n\nType: Undergarment (Upper)");
		public const TECHBRA:TechnomancerBra = new TechnomancerBra();
		//Lower
		public const BN_SKIRT:Undergarment = new Undergarment("BN. SKIRT", "Neko Bottom", "black Neko bottom", "a black Neko leather panty", UT_BOTTOM, 500, 0, 0, 2, "A panty made of leather black as night. Makes one slimmer than it appears, increasing evasion. Stronger at night. \n\nType: Undergarment (Lower)")
				.withBuffs({'evade': +2}) as Undergarment;
		public const C_LOIN :Undergarment = new Undergarment("C. Loin", "C. Loin", "comfortable loincloth", "a pair of comfortable loincloth", UT_BOTTOM, DEFAULT_VALUE, 0, 0, 0, "A generic pair of loincloth. \n\nType: Undergarment (Lower)", "NagaWearable");
		public const C_PANTY:Undergarment = new Undergarment("C.Panty", "C. Panties", "comfortable panties", "a pair of comfortable panties", UT_BOTTOM, DEFAULT_VALUE, 0, 0, 0, "A generic pair of panties. \n\nType: Undergarment (Lower)");
		public const COW_PANTY:Undergarment = new Undergarment("Cow Panty", "Cow Panty", "cow girl panties", "a pair of Cow girl panties", UT_BOTTOM, 1000, 1, 1, 3, "These panties look like ordinary panty at a first glance save for the cow fur like motif. They increase lacta bovina lactation rate. \n\nType: Undergarment (Lower)");
		public const DRI_PANTY:DriderPanties = new DriderPanties();
		public const DS_LOIN:Undergarment = new Undergarment("DS.Loin", "D.Scale Loin", "dragonscale loincloth", "a pair of dragonscale loincloth", UT_BOTTOM, 600, 2, 2, 1, "This loincloth appears to be made of dragonscale and held together with a leather strap that goes around your waist. Great for those on the wild side! \n\nType: Undergarment (Lower)", "NagaWearable");
		public const DSTHONG:Undergarment = new Undergarment("DSPanty", "D.Scale Thong", "dragonscale thong", "a pair of dragonscale thong", UT_BOTTOM, 600, 2, 2, 1, "This thong appears to be made of dragonscale and held together with a leather strap that goes around your waist. Great for those on the wild side! \n\nType: Undergarment (Lower)");
		public const EW_JOCK:Undergarment = new Undergarment("EW.Jock", "E.W. Jock", "ebonweave jockstrap", "an ebonweave jockstrap", UT_BOTTOM, 900, 3, 1, 2, "This jock is ebonweave, made from refined ebonbloom petals. This jock is comfortable and elastic, providing support while comfortably containing assets of any size. \n\nType: Undergarment (Lower)");
		public const EWTHONG:Undergarment = new Undergarment("EWPanty", "E.W. Thong", "ebonweave thong", "a pair of ebonweave thong", UT_BOTTOM, 900, 3, 1, 2, "This thong is ebonweave, designed to fit snugly around your form. Thanks to the alchemical treatments, this thong is elastic enough to comfortably hold assets of any size. \n\nType: Undergarment (Lower)");
		public const FURLOIN:Undergarment = new Undergarment("FurLoin", "FurLoin", "fur loincloth", "a front and back set of loincloths", UT_BOTTOM, DEFAULT_VALUE, 0, 0, 1,  "A pair of loincloths to cover your crotch and butt.  Typically worn by people named 'Conan'. \n\nType: Undergarment (Lower)", "NagaWearable");
		public const F_LOIN_:Undergarment = new Undergarment("F. Loin", "Fur Loin", "Fur loincloth", "a Fur loincloth", UT_BOTTOM, 600, 0, 0, 1, "This white fur loincloth made from a material similar to yeti furs help reduce the effect of cold environments. (+10% ice resistance) \n\nType: Undergarment (Lower)", "NagaWearable");
		public const F_PANTY:Undergarment = new Undergarment("F.Panty", "Fur Panty", "Fur panty", "a pair of Fur panty", UT_BOTTOM, 600, 0, 0, 1, "This white fur panty made from a material similar to yeti fur helps reduce the effect of cold environments. (+10% ice resistance) \n\nType: Undergarment (Lower)");
		public const GARTERS:Undergarment = new Undergarment("Garters", "Garters", "stockings and garters", "a pair of stockings and garters", UT_BOTTOM, DEFAULT_VALUE, 0, 0, 2, "These pairs of stockings, garters and lingerie are perfect for seducing your partner! \n\nType: Undergarment (Lower)");
		public const HBSHORT:Undergarment = new Undergarment("HBPanty", "HBShorts", "HB shorts", "a pair of HB shorts", UT_BOTTOM, 1500, 3, 3, 0, "Those white long shorts are made from fabric capable to conduct soulforce. \n\nType: Undergarment (Lower)");
		public const LTXSHRT:Undergarment = new Undergarment("LtxShrt", "LatexShorts", "latex shorts", "a pair of latex shorts", UT_BOTTOM, 300, 0, 0, 2, "These shorts are black and shiny, obviously made of latex. It's designed to fit snugly against your form. \n\nType: Undergarment (Lower)");
		public const LTXTHNG:Undergarment = new Undergarment("LtxThng", "LatexThong", "latex thong", "a pair of latex thong", UT_BOTTOM, 300, 0, 0, 2, "This thong is black and shiny, obviously made of latex. It's designed to fit snugly against your form. \n\nType: Undergarment (Lower)");
		public const R_JOCK :Undergarment = new Undergarment("R. Jock", "Rune Jock", "rune jock", "runed ebonweave jock", UT_BOTTOM, 1200, 3, 1, 3, "This jock is ebonweave, made from refined ebonbloom petals. This jock is comfortable and elastic, providing support while comfortably containing assets of any size. Adorning the front is a rune of lust, glowing with dark magic. \n\nType: Undergarment (Lower)")
				.withPerk(PerkLib.WellspringOfLust, 0, 0, 0, 0) as Undergarment;
		public const R_THONG:Undergarment = new Undergarment("R.Thong", "RuneThong", "rune thong", "runed ebonweave thong", UT_BOTTOM, 1200, 3, 1, 3, "This thong is ebonweave, designed to fit snugly around your form. Thanks to the alchemical treatments, this thong is elastic enough to comfortably hold assets of any size. Adorning the front is a rune of lust, glowing with dark magic. \n\nType: Undergarments (Lower)")
				.withPerk(PerkLib.WellspringOfLust, 0, 0, 0, 0) as Undergarment;
		public const SS_LOIN:Undergarment = new Undergarment("SS.Loin", "S.Silk Loin", "spider-silk loincloth", "a spider-silk loincloth", UT_BOTTOM, 1000, 1, 0, 1, "This loincloth looks incredibly comfortable. It's as white as snow and finely woven with hundreds of strands of spider silk.  \n\nType: Undergarment (Lower)", "NagaWearable");
		public const SSPANTY:Undergarment = new Undergarment("SSPanty", "S.Silk Panty", "spider-silk panties", "a pair of spider-silk panties", UT_BOTTOM, 1000, 1, 0, 1, "These panties look incredibly comfortable. It's as white as snow and finely woven with hundreds of strands of spider silk. \n\nType: Undergarment (Lower)");
		public const STPANTY:Undergarment = new Undergarment("STPanty", "S.T.Panties", "soul training panties", "a pair of soul training panties", UT_BOTTOM, 200, 0, 0, 0, "A pair of panties made from fabric capable to help train soulforce. \n\nType: Undergarment (Lower)");
		public const T_PANTY:TechnomancerPanties = new TechnomancerPanties();
		public function UndergarmentLib()
		{
		}
	}
}
