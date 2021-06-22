/**
 * ...
 * @author Ormael
 */
package classes.Items 
{
	import classes.Items.FlyingSwords.*;
	import classes.PerkLib;
	import classes.PerkType;
	
	public final class FlyingSwordsLib 
	{
		public static const DEFAULT_VALUE:Number = 6;
		
		public static const NOTHING:Nothing = new Nothing();
		
		public const TRASFLS:FlyingSwords = new FlyingSwords("TraSFlS","Tra.S.Fl.Sword","training soul flying sword","a training flying sword","slash",1,100,"This small flying sword was specialy forged and enhanted to help novice soul cultivatiors to train their soulforce.  Still if situation calls for it it could be used as a normal weapon or if user is not too heavy fly on it.", "Small");
		
		public function FlyingSwordsLib() 
		{
		}
	}
}