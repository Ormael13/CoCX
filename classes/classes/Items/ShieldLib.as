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
		
		public const AETHERS:AetherS = new AetherS();
		public const BATTNET:Shield = new Shield("BattNet", "BattleNet", "Battle Net", "a Battle Net", 0, 500, "A battle net used in the off hand to impair the opponent's movement. Also very good for fishing.");
		public const BSHIELD:BeautifulShield = new BeautifulShield();
		public const BLASPHE:Blasphemy = new Blasphemy();
		public const BUCKLER:Shield = new Shield("Buckler", "Buckler", "buckler", "a buckler", 5, 50, "A simple wooden rounded shield.");
		public const GREATSH:Shield = new Shield("GreatSh", "GreatShld", "greatshield", "a greatshield", 12, 300, "A large metal shield.");
		public const KITE_SH:Shield = new Shield("Kite Sh", "KiteShield", "kite shield", "a kite shield", 8, 150, "An average-sized kite shield.");
		public const MABRACE:Shield = new Shield("MaBrace", "ManaBracer", "mana bracer", "a mana bracer", 2, 400, "Runed bracers such as this are popular amongst mages that can afford them. This silver bracer augments a mage’s spell power while leaving the hand open to make gestures used in spellcasting.");
		public const SPI_FOC:Shield = new Shield("Spi Foc", "SpiritFocus", "spirit focus", "a spirit focus", 4, 800, "This small icon with a silk ribbon is inscribed with eldritch runes and reinforces a kitsune's power and magic. (+20% to Fox Fire dmg and lust dmg, +20% to soulskills power)");
		public const TRASBUC:Shield = new Shield("TraSBuc", "TrainSBuckler", "training soul buckler", "a training soul buckler", 3, 60, "A simple rounded shield made of soulmetal used to train soulforce by soul cultivator novices.");
		public const TOWERSH:Shield = new TowerShield();
		public const DRGNSHL:DragonShellShield = new DragonShellShield();
		public const SANCTYN:Shield = new Shield ("SanctN", "Sanctuary", "Sanctuary", "a Sanctuary", 20, 1500, "The legendary shield");
		public const SANCTYL:Sanctuary = new Sanctuary();
		public const SANCTYD:DarkAegis = new DarkAegis();
		
		/*private static function mk(id:String,shortName:String,name:String,longName:String,effectId:Number,effectMagnitude:Number,value:Number,description:String,type:String,perk:String=""):Jewelry {
			return new Shield(id,shortName,name,longName,effectId,effectMagnitude,value,description,type,perk);
		}*/
		
		public function ShieldLib() 
		{
		}
	}

}