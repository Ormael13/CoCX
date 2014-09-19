/**
 * Created by aimozg on 09.01.14.
 */
package classes.Items
{
	import classes.Items.Weapons.*;

	public final class WeaponLib
	{
		public static const DEFAULT_VALUE:Number = 6;

		public static const FISTS:Fists = new Fists();

		public const B_SWORD:Weapon = new BeautifulSword();
		public const CLAYMOR:Weapon = new LargeClaymore();
		public const DRGNSHL:DragonShellShield = new DragonShellShield();
		public const E_STAFF:EldritchStaff = new EldritchStaff();
		public const URTAHLB:Weapon = mk("UrtaHlb","UrtaHlb","halberd","a halberd","slash",11,10,null,"Large");
		public const H_GAUNT:Weapon = mk("H.Gaunt","H.Gaunt","hooked gauntlets","a set of hooked gauntlets","clawing punch",8,300,"These metal gauntlets are covered in nasty looking hooks that are sure to tear at your foes flesh and cause them harm. \n\nType: Weapon (Gauntlet) \nAttack: 8 \nBase value: 300 \nChance to inflict bleeding status on strike.");
		public const JRAPIER:JeweledRapier = new JeweledRapier();
		public const KATANA :Weapon = mk("Katana ","Katana","katana","a katana","keen cut",10,500,"A curved bladed weapon that cuts through flesh with the greatest of ease. \n\nType: Weapon (Sword) \nAttack: 10 \nBase value: 500");
		public const L__AXE :Weapon = mk("L. Axe ","L. Axe","large axe","an axe large enough for a minotaur","cleave",15,100,"This massive axe once belonged to a minotaur.  It'd be hard for anyone smaller than a giant to wield effectively.  The axe is double-bladed and deadly-looking.  \n\nType: Weapon (Heavy) \nAttack: 15 \nBase value: 100 \nRequires height of 6'6\" or 90 strength.","Large");
		public const L_DAGGR:Weapon = mk("L.Daggr","L.Daggr","lust-enchanted dagger","an aphrodisiac-coated dagger","stab",3,150,"A dagger with a short blade in a wavy pattern.  Its edge seems to have been enchanted to always be covered in a light aphrodisiac to arouse anything cut with it. \n\nType: Weapon (Dagger) \nAttack: 3 \nBase value: 150 \nInflicts lust damage on strike.","Aphrodisiac Weapon");
		public const L_HAMMR:LargeHammer = new LargeHammer();
		public const PIPE   :Weapon = mk("Pipe   ","Pipe","pipe","a pipe","smash",5,25,"This is a simple rusted pipe of unknown origins.  It's hefty and could probably be used as an effective bludgeoning tool. \n\nType: Weapon \nAttack: 5 \nBase value: 25");
		public const PTCHFRK:Weapon = mk("PtchFrk","Pitckfork","pitchfork","a pitchfork","stab",10,200,"This is a pitchfork.  Intended for farm work but also useful as stabbing weapon. \n\nType: Weapon \nAttack: 10 \nBase value: 200");
		public const RIDINGC:Weapon = mk("RidingC","RidingC","riding crop","a riding crop","whip-crack",5,50,"This riding crop appears to be made of black leather, and could be quite a painful (or exciting) weapon.  \n\nType: Weapon (Whip) \nAttack: 5 \nBase value: 50");
		public const RRAPIER:RaphaelsRapier = new RaphaelsRapier();
		public const S_BLADE:Spellblade = new Spellblade();
		public const S_GAUNT:Weapon = mk("S.Gaunt","S.Gauntlet","spiked gauntlet","a spiked gauntlet","spiked punch",5,400,"This single metal gauntlet has the knuckles tipped with metal spikes.  Though it lacks the damaging potential of other weapons, the sheer pain of its wounds has a chance of stunning your opponent. \n\nType: Weapon (Gauntlet) \nAttack: 5 \nBase value: 400 \nChance to stun your opponent.");
		public const SPEAR  :Weapon = mk("Spear  ","Spear","deadly spear","a deadly spear","piercing stab",8,450,"A staff with a sharp blade at the tip designed to pierce through the toughest armor.  This would ignore most armors.  \n\nType: Weapon (Spear) \nAttack: 8 \nBase value: 450 \nIgnores most armors.");
		public const SUCWHIP:Weapon = mk("SucWhip","SucWhip","succubi whip","a succubi whip","sexy whipping",10,400,"This coiled length of midnight-black leather practically exudes lust.  Though it looks like it could do a lot of damage, the feel of that slick leather impacting flesh is sure to inspire lust. \n\nType: Weapon \nAttack: 10 \nBase value: 400 \nInflicts lust damage on strike but slowly corrupts the wielder.");
		public const W_STAFF:WizardsStaff = new WizardsStaff();
		public const WARHAMR:HugeWarhammer = new HugeWarhammer();
		public const WHIP   :Weapon = mk("Whip   ","Whip","coiled whip","a coiled whip","whip-crack",5,500,"A coiled length of leather designed to lash your foes into submission.  There's a chance the bondage inclined might enjoy it! \n\nType: Weapon (Whip) \nAttack: 5 \nBase value: 500");

		private static function mk(id:String,shortName:String,name:String,longName:String,verb:String,attack:Number,value:Number,description:String,perk:String=""):Weapon {
			return new Weapon(id,shortName,name,longName,verb,attack,value,description,perk);
		}
		public function WeaponLib()
		{
		}
	}
}
