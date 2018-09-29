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
		public static const DEFAULT_VALUE:Number = 6;
		
		public static const NOTHING:Nothing = new Nothing();
		
		public const OBNECK :Necklace = new Necklace("OBNeck", "OniBeadNecklace", "Oni bead necklace", "an Oni bead necklace", 0, 0, 800, "Normally worn by monks, this necklace fills you with a sense of raw contained power. \n\nType: Jewelry (Necklace) \nBase value: 800","Necklace");
		public const SMNECK :Necklace = new Necklace("SMNeck", "SMNecklace", "soulmetal necklace", "a soulmetal necklace", 0, 100, 500, "This simple necklace is made from low quality soulmetal. Despite it seemly simplicity it allow for slight compresion of it weaver soulforce allowing storing a little bit more of it. \n\nType: Jewelry (Necklace) \nBase value: 500 \nSpecial: Increases maximum Soulforce by 100.","Necklace");
		public const TSNECK :Necklace = new Necklace("TSNeck", "T.S.Necklace", "training soul necklace", "a training soul necklace", 0, 0, 300, "Necklace made from soulmetal to help train soulforce to the uttermost limit for novice soul cultivator. \n\nType: Jewelry (Necklace) \nBase value: 300","Necklace");
		
		public function NecklaceLib() 
		{
		}
	}

}