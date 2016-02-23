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
		
		public const BUCKLER:Shield = new Shield("Buckler", "Buckler", "buckler", "a buckler", 5, 50, "A simple wooden rounded shield.");
		public const GREATSH:Shield = new Shield("GreatSh", "GreatShld", "greatshield", "a greatshield", 12, 300, "A large metal shield. It's a bit heavy.");
		public const KITE_SH:Shield = new Shield("Kite Sh", "KiteShield", "kite shield", "a kite shield", 8, 150, "An average-sized kite shield.");
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