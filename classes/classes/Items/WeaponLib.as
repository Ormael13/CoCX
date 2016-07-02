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
		public const B_SCARB:Weapon = new Weapon("B.ScarB", "B.ScarBlade", "broken scarred blade", "a broken scarred blade", "slash", 12, 1000, "This saber, made from lethicite-imbued metal, seems to no longer seek flesh; whatever demonic properties in this weapon is gone now but it's still an effective weapon.");
		public const BLUNDER:Weapon = new Weapon("Blunder", "Blunderbuss", "blunderbuss", "a blunderbuss", "shot", 16, 600, "This is a blunderbuss. It's effective at short range but poor at long range.", "Ranged");
		public const CLAYMOR:Weapon = new LargeClaymore();
		public const CROSSBW:Weapon = new Weapon("Crossbw","Crossbow","crossbow","a crossbow","shot",11,200,"This weapon fires bolts at your enemies.", "Ranged");
		public const DAGGER :Weapon = new Weapon("Dagger ","Dagger","dagger","a dagger","stab",4,40,"A small blade.  Preferred weapon for the rogues.");
		public const E_STAFF:EldritchStaff = new EldritchStaff();
		public const FLAIL  :Weapon = new Weapon("Flail  ","Flail","flail","a flail","smash",10,200,"This is a flail, a weapon consisting of a metal spiked ball attached to a stick by chain. Be careful with this as you might end up injuring yourself.");
		public const FLINTLK:Weapon = new Weapon("Flintlk","Flintlock","flintlock pistol","a flintlock pistol","shot",14,250,"A flintlock pistol. Pew pew pew. Can fire four times before a reload is required and Speed has a factor in damage.", "Ranged");
		public const URTAHLB:Weapon = new Weapon("UrtaHlb","UrtaHlb","halberd","a halberd","slash",11,10,"Urta's halberd. How did you manage to get this?","Large");
		public const H_GAUNT:Weapon = new Weapon("H.Gaunt", "H.Gaunt", "hooked gauntlets", "a set of hooked gauntlets", "clawing punch", 8, 300, "These metal gauntlets are covered in nasty looking hooks that are sure to tear at your foes flesh and cause them harm.");
		public const HNTCANE:HuntsmansCane = new HuntsmansCane();
		public const JRAPIER:JeweledRapier = new JeweledRapier();
		public const KATANA :Weapon = new Weapon("Katana ","Katana","katana","a katana","keen cut",10,500,"A curved bladed weapon that cuts through flesh with the greatest of ease.");
		public const KIHAAXE:Weapon = new Weapon("KihaAxe","Greataxe","fiery double-bladed axe","a fiery double-bladed axe","fiery cleave",20,1000,"This large, double-bladed axe matches Kiha's axe. It's constantly flaming.", "Large");
		public const L__AXE :Weapon = new Weapon("L. Axe ","L. Axe","large axe","an axe large enough for a minotaur","cleave",15,100,"This massive axe once belonged to a minotaur.  It'd be hard for anyone smaller than a giant to wield effectively.  The axe is double-bladed and deadly-looking.  Requires height of 6'6\" or 90 strength.","Large");
		public const L_DAGGR:Weapon = new Weapon("L.Daggr","L.Daggr","lust-enchanted dagger","an aphrodisiac-coated dagger","stab",3,150,"A dagger with a short blade in a wavy pattern.  Its edge seems to have been enchanted to always be covered in a light aphrodisiac to arouse anything cut with it.","Aphrodisiac Weapon");
		public const L_HAMMR:LargeHammer = new LargeHammer();
		public const L_STAFF:LethiciteStaff = new LethiciteStaff();
		public const L_WHIP :Weapon = new Weapon("L. Whip", "L. Whip", "flaming whip", "a flaming whip once belonged to Lethice", "whip-crack", 16, 2000, "This whip once belonged to Lethice who was defeated at your hands. It gives off flames when you crack this whip.");
		public const MACE   :Weapon = new Weapon("Mace   ","Mace","mace","a mace","smash",9,100,"This is a mace, designed to be able to crush against various defenses.");
		public const PIPE   :Weapon = new Weapon("Pipe   ","Pipe","pipe","a pipe","smash",5,25,"This is a simple rusted pipe of unknown origins.  It's hefty and could probably be used as an effective bludgeoning tool.");
		public const PTCHFRK:Weapon = new Weapon("PtchFrk","Pitchfork","pitchfork","a pitchfork","stab",10,200,"This is a pitchfork.  Intended for farm work but also useful as stabbing weapon.");
		public const RIDINGC:Weapon = new Weapon("RidingC","RidingC","riding crop","a riding crop","whip-crack",5,50,"This riding crop appears to be made of black leather, and could be quite a painful (or exciting) weapon.");
		public const RRAPIER:RaphaelsRapier = new RaphaelsRapier();
		public const S_BLADE:Spellblade = new Spellblade();
		public const S_GAUNT:Weapon = new Weapon("S.Gaunt","S.Gauntlet","spiked gauntlet","a spiked gauntlet","spiked punch",5,400,"This single metal gauntlet has the knuckles tipped with metal spikes.  Though it lacks the damaging potential of other weapons, the sheer pain of its wounds has a chance of stunning your opponent.");
		public const SCARBLD:Weapon = new ScarredBlade();
		public const SCIMITR:Weapon = new Weapon("Scimitr", "Scimitar", "scimitar", "a scimitar", "slash", 15, 500, "This curved sword is made for slashing.  No doubt it'll easily cut through flesh.");
		public const SPEAR  :Weapon = new Weapon("Spear  ","Spear","deadly spear","a deadly spear","piercing stab",8,450,"A staff with a sharp blade at the tip designed to pierce through the toughest armor.  This would ignore most armors.");
		public const SUCWHIP:Weapon = new Weapon("SucWhip","SucWhip","succubi whip","a succubi whip","sexy whipping",10,400,"This coiled length of midnight-black leather practically exudes lust.  Though it looks like it could do a lot of damage, the feel of that slick leather impacting flesh is sure to inspire lust.  However, it might slowly warp the mind of wielder.");
		public const W_STAFF:WizardsStaff = new WizardsStaff();
		public const WARHAMR:HugeWarhammer = new HugeWarhammer();
		public const WHIP   :Weapon = new Weapon("Whip   ","Whip","coiled whip","a coiled whip","whip-crack",5,500,"A coiled length of leather designed to lash your foes into submission.  There's a chance the bondage inclined might enjoy it!");

		/*
		private static function mk(id:String,shortName:String,name:String,longName:String,verb:String,attack:Number,value:Number,description:String,perk:String=""):Weapon {
			return new Weapon(id,shortName,name,longName,verb,attack,value,description,perk);
		}
		*/
		public function WeaponLib()
		{
		}
	}
}
