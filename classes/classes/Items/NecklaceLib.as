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
		
		public const BWSCARF:Necklace = new Necklace("BWScarf", "B. W. scarf", "Blue Winter scarf", "a Blue Winter scarf", 0, 0, 800, "This fancy winter scarf helps protect against cold temperatures and is magically enchanted to empower cold based abilities. \n\nType: Jewelry (Necklace) \nBase value: 800","Necklace");
		public const CSNECK :Necklace = new Necklace("CSNeck", "C.S.Necklace", "Crinos Shape necklace", "a Crinos Shape necklace", 0, 0, 400, "Necklace made after long research into ferals to allow user using crinos shape transformation ability or boost it power is user already know this ability. \n\nType: Jewelry (Necklace) \nBase value: 400","Necklace");
		public const GWSCARF:Necklace = new Necklace("GWScarf", "G. W. scarf", "Green Winter scarf", "a Green Winter scarf", 0, 0, 800, "This fancy winter scarf helps protect against cold temperatures and is magically enchanted to empower cold based abilities. \n\nType: Jewelry (Necklace) \nBase value: 800","Necklace");
		public const OBNECK :Necklace = new Necklace("OBNeck", "OniBeadNecklace", "Oni bead necklace", "an Oni bead necklace", 0, 0, 800, "Normally worn by monks, this necklace fills you with a sense of raw contained power. \n\nType: Jewelry (Necklace) \nBase value: 800","Necklace");
		public const PWSCARF:Necklace = new Necklace("PWScarf", "P. W. scarf", "Purple Winter scarf", "a Purple Winter scarf", 0, 0, 800, "This fancy winter scarf helps protect against cold temperatures and is magically enchanted to empower cold based abilities. \n\nType: Jewelry (Necklace) \nBase value: 800","Necklace");
		public const RWSCARF:Necklace = new Necklace("RWScarf", "R. W. scarf", "Red Winter scarf", "a Red Winter scarf", 0, 0, 800, "This fancy winter scarf helps protect against cold temperatures and is magically enchanted to empower cold based abilities. \n\nType: Jewelry (Necklace) \nBase value: 800","Necklace");
		public const SMNECK :Necklace = new Necklace("SMNeck", "SMNecklace", "soulmetal necklace", "a soulmetal necklace", 0, 100, 500, "This simple necklace is made from low quality soulmetal. Despite it seemly simplicity it allow for slight compresion of it weaver soulforce allowing storing a little bit more of it. \n\nType: Jewelry (Necklace) \nBase value: 500 \nSpecial: Increases maximum Soulforce by 100.","Necklace");
		public const TSNECK :Necklace = new Necklace("TSNeck", "T.S.Necklace", "training soul necklace", "a training soul necklace", 0, 0, 300, "Necklace made from soulmetal to help train soulforce to the uttermost limit for novice soul cultivator. \n\nType: Jewelry (Necklace) \nBase value: 300","Necklace");
		public const YWSCARF:Necklace = new Necklace("YWScarf", "Y. W. scarf", "Yellow Winter scarf", "a Yellow Winter scarf", 0, 0, 800, "This fancy winter scarf helps protect against cold temperatures and is magically enchanted to empower cold based abilities. \n\nType: Jewelry (Necklace) \nBase value: 800","Necklace");
		
		public function NecklaceLib() 
		{
		}
	}

}