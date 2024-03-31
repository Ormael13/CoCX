/**
 * ...
 * @author Ormael
 */
package classes.Items
{
import classes.Items.FlyingSwords.*;
import classes.Scenes.Combat.CombatAbility;

public final class FlyingSwordsLib extends ItemConstants
	{
		public static const DEFAULT_VALUE:Number = 6;	//cena bazowa dla latających mieczy to 50 gems a nie 40 gems
		public static const NOTHING:Nothing = new Nothing();
		
		public const ASAUCHI:FlyingSwords = new FlyingSwords("Asauchi","Asauchi","Asauchi","Asauchi","slash",32,1600,"Sword that was forged from soulmetal. It may not be as deadly as others but due to material it lessen consumption of soul energies.", "Massive");
		public const A_HALFM:FlyingSwords = new FlyingSwords("A.HalfM","Aquamarine Half-Moon","Aquamarine Half-Moon","Aquamarine Half-Moon","slash",15,1500,"Sword that was forged from metal repeadly bathed in water from oceanic trench.", "Large", 1, CombatAbility.TAG_WATER);
		public const A_HALFM2:FlyingSwords = new FlyingSwords("A.HalfM2","Aquamarine Half-Moon Duo","Aquamarine Half-Moon Duo","Aquamarine Half-Moon Duo","slash",15,3000,"Pair of swords that were forged from metal repeadly bathed in water from oceanic trench.", "Large", 2, CombatAbility.TAG_WATER);
		public const B_HALFM:FlyingSwords = new FlyingSwords("B.HalfM","Black Half-Moon","Black Half-Moon","Black Half-Moon","slash",6,600,"Sword that was forged from metal repeadly bathed in liquid ice.", "Small", 1, CombatAbility.TAG_ICE);
		public const B_HALFM2:FlyingSwords = new FlyingSwords("B.HalfM2","Black Half-Moon Duo","Black Half-Moon Duo","Black Half-Moon Duo","slash",6,1200,"Pair of swords that were forged from metal repeadly bathed in liquid ice.", "Small", 2, CombatAbility.TAG_ICE);
		public const B_HALFM3:FlyingSwords = new FlyingSwords("B.HalfM3","Black Half-Moon Quartet","Black Half-Moon Quartet","Black Half-Moon Quartet","slash",6,2400,"Set of four swords that were forged from metal repeadly bathed in liquid ice.", "Small", 4, CombatAbility.TAG_ICE);
		public const C_NEW_M:FlyingSwords = new FlyingSwords("C.New.M","Chrysolite New Moon","Chrysolite New Moon","Chrysolite New Moon","slash",40,3750,"Magnificent sword that was forged from metal repeadly tempered by the golden crow flames.", "Massive", 1, CombatAbility.TAG_PLASMA);
		public const E_HALFM:FlyingSwords = new FlyingSwords("E.HalfM","Ebon Half-Moon","Ebon Half-Moon","Ebon Half-Moon","slash",6,600,"Sword that was forged from metal repeadly infused with the darkness.", "Small", 1, CombatAbility.TAG_DARKNESS);
		public const E_HALFM2:FlyingSwords = new FlyingSwords("E.HalfM2","Ebon Half-Moon Duo","Ebon Half-Moon Duo","Ebon Half-Moon Duo","slash",6,1200,"Pair of swords that were forged from metal repeadly infused with the darkness.", "Small", 2, CombatAbility.TAG_DARKNESS);
		public const E_HALFM3:FlyingSwords = new FlyingSwords("E.HalfM3","Ebon Half-Moon Quartet","Ebon Half-Moon Quartet","Ebon Half-Moon Quartet","slash",6,2400,"Set of four swords that were forged from metal repeadly infused with the darkness.", "Small", 4, CombatAbility.TAG_DARKNESS);
		public const MOONLGT:FlyingSwords = new FlyingSwords("Moonlgt","Moonlight","Moonlight","Moonlight","slash",8,800,"This flying sword was specialy forged and enchanted to help with sneak attacks and posses increased chance to leave bleeding wounds.", "Small");
		public const O_HALFM:FlyingSwords = new FlyingSwords("O.HalfM","Obsidian Half-Moon","Obsidian Half-Moon","Obsidian Half-Moon","slash",15,1500,"Sword that was forged from metal repeadly tempered deep in planet crust.", "Large", 1, CombatAbility.TAG_EARTH);
		public const O_HALFM2:FlyingSwords = new FlyingSwords("O.HalfM2","Obsidian Half-Moon Duo","Obsidian Half-Moon Duo","Obsidian Half-Moon Duo","slash",15,3000,"Pair of swords that were forged from metal repeadly tempered deep in planet crust.", "Large", 2, CombatAbility.TAG_EARTH);
		public const S_HALFM:FlyingSwords = new FlyingSwords("S.HalfM","Scarlet Half-Moon", "Scarlet Half-Moon", "Scarlet Half-Moon", "slash",6,600, "Sword that was forged from metal repeadly tempered by the lightning.", "Small", 1, CombatAbility.TAG_LIGHTNING);
		public const S_HALFM2:FlyingSwords = new FlyingSwords("S.Half2M","Scarlet Half-Moon Duo", "Scarlet Half-Moon Duo", "Scarlet Half-Moon Duo", "slash",6,1200, "Pair of swords that were forged from metal repeadly tempered by the lightning.", "Small", 2, CombatAbility.TAG_LIGHTNING);
		public const S_HALFM3:FlyingSwords = new FlyingSwords("S.Half3M","Scarlet Half-Moon Quartet", "Scarlet Half-Moon Quartet", "Scarlet Half-Moon Quartet", "slash",6,2400, "Set of four swords that were forged from metal repeadly tempered by the lightning.", "Small", 4, CombatAbility.TAG_LIGHTNING);
		public const S_TWINS:FlyingSwords = new FlyingSwords("S.Twins", "Sky Twins", "Sky Twins", "Sky Twins", "slash", 12, 1200, "Pair of solid swords that could be used to fly or to tear enemies apart.", "Large", 2);
		public const TRASFLS:FlyingSwords = new FlyingSwords("TraSFlS","Tra.S.Fl.Sword","training soul flying sword","a training flying sword","slash",1,100,"This large flying sword was specialy forged and enhanted to help novice soul cultivatiors to train their soulforce.  Still if situation calls for it it could be used as a normal weapon or to fly on it.", "Large");
		public const W_HALFM:FlyingSwords = new FlyingSwords("W.HalfM","White Half-Moon","White Half-Moon","White Half-Moon","slash",6,600,"Sword that was forged from metal repeadly bathed in lava.", "Small", 1, CombatAbility.TAG_FIRE);
		public const W_HALFM2:FlyingSwords = new FlyingSwords("W.HalfM2","White Half-Moon Duo","White Half-Moon Duo","White Half-Moon Duo","slash",6,1200,"Pair of swords that were forged from metal repeadly bathed in lava.", "Small", 2, CombatAbility.TAG_FIRE);
		public const W_HALFM3:FlyingSwords = new FlyingSwords("W.HalfM3","White Half-Moon Quartet","White Half-Moon Quartet","White Half-Moon Quartet","slash",6,2400,"Set of four swords that were forged from metal repeadly bathed in lava.", "Small", 4, CombatAbility.TAG_FIRE);
		
		public function FlyingSwordsLib()
		{
		}
	}
}
