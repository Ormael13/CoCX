package classes.Items 
{
	/**
	 * ...
	 * @author Kitteh6660
	 */
	import classes.Items.Shields.*;
	import classes.PerkLib;
	import classes.PerkType;
	
	public final class ShieldLib 
	{
		public static const DEFAULT_VALUE:Number = 6;
		
		public static const NOTHING:Nothing = new Nothing();
		
		public const BUCKLER:Shield = new Shield("Buckler", "Buckler", "buckler", "a buckler", 5, 50, "A simple wooden rounded shield.  \n\nType: Shield \nBlock rating: 5 \nValue: 50");
		public const GREATSH:Shield = new Shield("GreatSh", "GreatShld", "greatshield", "a greatshield", 12, 300, "A large metal shield.  \n\nType: Shield \nBlock rating: 12 \nValue: 300");
		public const KITE_SH:Shield = new Shield("Kite Sh", "KiteShield", "kite shield", "a kite shield", 8, 150, "An average-sized kite shield.  \n\nType: Shield \nBlock rating: 8 \nValue: 150");
		public const MABRACE:Shield = new Shield("MaBrace", "ManaBracer", "mana bracer", "a mana bracer", 2, 400, "Runed bracers such as this are popular amongst mages that can afford them. This silver bracer augments a mage’s spell power while leaving the hand open to make gestures used in spellcasting.  \n\nType: Shield \nBlock rating: 2 \nValue: 400");
		public const SPI_FOC:Shield = new Shield("Spi Foc", "SpiritFocus", "spirit focus", "a spirit focus", 4, 800, "This small icon with a silk ribbon is inscribed with eldritch runes and reinforces a kitsune's power and magic.  \n\nType: Shield \nBlock rating: 4 \nValue: 800");
		public const TRASBUC:Shield = new Shield("TraSBuc", "TrainSBuckler", "training soul buckler", "a training soul buckler", 3, 60, "A simple rounded shield made of soulmetal used to train soulforce by soul cultivator novices.  \n\nType: Shield \nBlock rating: 3 \nValue: 60");
		public const TOWERSH:Shield = new TowerShield();
		public const DRGNSHL:DragonShellShield = new DragonShellShield();
		
		/*private static function mk(id:String,shortName:String,name:String,longName:String,effectId:Number,effectMagnitude:Number,value:Number,description:String,type:String,perk:String=""):Jewelry {
			return new Shield(id,shortName,name,longName,effectId,effectMagnitude,value,description,type,perk);
		}*/
		
		public function ShieldLib() 
		{
		}
	}

}