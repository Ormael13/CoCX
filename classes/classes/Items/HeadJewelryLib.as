package classes.Items 
{
	/**
	 * ...
	 * @author Ormael
	 */
	import classes.Items.HeadJewelries.*;
	import classes.PerkLib;
	import classes.PerkType;
	
	public final class HeadJewelryLib 
	{
		public static const DEFAULT_VALUE:Number = 6;
		
		public static const NOTHING:Nothing = new Nothing();
		
		public const FOXHAIR:HeadJewelry = new HeadJewelry("FoxHair", "Fox Hairpin", "fox hairpin", "a fox hairpin", 0, 0, 800, "This hairpin, adorned with the design of a fox and blessed by Taoth, grants a kitsune increased magical power. \n\nType: Jewelry (Hairpin) \nBase value: 800","Hairpin");
		public const GNHAIR:HeadJewelry = new HeadJewelry("GNHair", "Golden Naga Hairpins", "pair of Golden Naga Hairpins", "a pair of Golden Naga Hairpins", 0, 0, 400, "This pair of lovely half moon-shaped golden hairpins are commonly used by the nagas to enhance their bodily charms. \n\nType: Jewelry (Hairpin) \nBase value: 400","Hairpin");
		public const SEERPIN:SeersHairpin = new SeersHairpin();
		public const TSHAIR :HeadJewelry = new HeadJewelry("TSHair", "T.S.Hairpin", "training soul hairpin", "training soul hairpin", 0, 0, 200, "This hairpin, made from soulmetal helps to train soulforce to the uttermost limit for novice soul cultivator. \n\nType: Jewelry (Hairpin) \nBase value: 200","Hairpin");
		
		public function HeadJewelryLib() 
		{
		}
	}

}