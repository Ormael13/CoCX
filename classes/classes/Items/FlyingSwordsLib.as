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
		public static const DEFAULT_VALUE:Number = 6;	//cena bazowa dla latających mieczy to 50 gems a nie 40 gems
		public static const NOTHING:Nothing = new Nothing();
		
		public const B_HALFM:FlyingSwords = new FlyingSwords("B.HalfM","Black Half-Moon","Black Half-Moon","Black Half-Moon","slash",6,600,"Sword that was forged from metal repeadly bathed in the liquid ice.", "Small");
		public const MOONLGT:FlyingSwords = new FlyingSwords("Moonlgt","Moonlight","Moonlight","Moonlight","slash",8,800,"This flying sword was specialy forged and enhanted to help with sneak attacks and posses increased chance to leave bleeding wounds.", "Small");
		public const TRASFLS:FlyingSwords = new FlyingSwords("TraSFlS","Tra.S.Fl.Sword","training soul flying sword","a training flying sword","slash",1,100,"This large flying sword was specialy forged and enhanted to help novice soul cultivatiors to train their soulforce.  Still if situation calls for it it could be used as a normal weapon or to fly on it.", "Large");
		public const W_HALFM:FlyingSwords = new FlyingSwords("W.HalfM","White Half-Moon","White Half-Moon","White Half-Moon","slash",6,600,"Sword that was forged from metal repeadly bathed in the lava.", "Small");
		//public const TRASFLS:FlyingSwords = new FlyingSwords("TraSFlS","Tra.S.Fl.Sword","training soul flying sword","a training flying sword","slash",1,50,"This small flying sword was specialy forged and enhanted to help novice soul cultivatiors to train their soulforce.", "Small");
		
		public function FlyingSwordsLib() 
		{
		}
	}
}