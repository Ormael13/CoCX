/**
 * Created by aimozg on 09.01.14.
 */
package classes.Items
{
	import classes.Items.Weapons.*;
	import classes.PerkLib;
	import classes.PerkType;

	public final class WeaponLib
	{
		public static const DEFAULT_VALUE:Number = 6;
//1 atk for dual weapons = 80 lub 160 jeśli z dodatkowym perkiem
		public static const FISTS:Fists = new Fists();//40 za 1 atk normalnie lub za wrath weapon i 80 za 1 atk broni z perkiem/dod. efektem

		public const ASCENSU:Ascensus = new Ascensus();
		public const B_SWORD:Weapon = new BeautifulSword();
		public const BFSWORD:Weapon = new BFSword();
		public const B_SCARB:Weapon = new Weapon("B.ScarB", "B.ScarBlade", "broken scarred blade", "a broken scarred blade", "slash", 12, 480, "This saber, made from lethicite-imbued metal, seems to no longer seek flesh; whatever demonic properties in this weapon is gone now but it's still an effective weapon.");
		public const BLETTER:BloodLetter = new BloodLetter();
		public const B_WIDOW:BlackWidow = new BlackWidow();
		public const CLAYMOR:Weapon = new LargeClaymore();
		public const CNTWHIP:CatONineTailWhip = new CatONineTailWhip();
		public const DAGGER :Weapon = new Weapon("Dagger ","Dagger","dagger","a dagger","stab",3,120,"A small blade.  Preferred weapon for the rogues.");
		public const DBFSWO :DualBFSword = new DualBFSword();
		public const DEMSCYT:WeaponWithPerk = new WeaponWithPerk("DemScyt","D.Scythe","demonic scythe","a demonic scythe","slash",25,2000,"A mage catalyst of unknown origin ornamented with a blade mounted on a skull. This magical scythe is both charged with powerful energy and extremely sharp. The letters A.S are engraved in the weapon.", "Large", PerkLib.WizardsFocus, 1, 0, 0, 0);
		public const DEPRAVA:Depravatio = new Depravatio();
		public const DE_GAXE:DemonicGreataxe = new DemonicGreataxe();
		public const DRAPIER:DragonsRapier = new DragonsRapier();
		public const D_WHAM_:DualHugeWarhammer = new DualHugeWarhammer();
		public const DL_AXE_:DualLargeAxe = new DualLargeAxe();
		public const DSWORD_:DualSwords = new DualSwords();
		public const DSSPEAR:DemonSnakespear = new DemonSnakespear();
		public const E_STAFF:EldritchStaff = new EldritchStaff();
		public const EBNYBLD:EbonyDestroyer = new EbonyDestroyer();
		public const ERIBBON:EldritchRibbon = new EldritchRibbon();
		public const FLAIL  :Weapon = new Weapon("Flail  ","Flail","flail","a flail","smash",10,400,"This is a flail, a weapon consisting of a metal spiked ball attached to a stick by chain. Be careful with this as you might end up injuring yourself.");
		public const URTAHLB:Weapon = new Weapon("UrtaHlb","UrtaHlb","halberd","a halberd","slash",30,1200,"Urta's halberd. How did you manage to get this?","Large");
		public const H_GAUNT:Weapon = new Weapon("H.Gaunt", "H.Gaunt", "hooked gauntlets", "a set of hooked gauntlets", "clawing punch", 21, 1680, "These metal gauntlets are covered in nasty looking hooks that are sure to tear at your foes flesh and cause them harm.");
		public const HNTCANE:HuntsmansCane = new HuntsmansCane();
		public const JRAPIER:JeweledRapier = new JeweledRapier();
		public const KATANA :Weapon = new Weapon("Katana ","Katana","katana","a katana","keen cut",10,400,"A curved bladed weapon that cuts through flesh with the greatest of ease.");
		public const KIHAAXE:Weapon = new Weapon("KihaAxe","Greataxe","fiery double-bladed axe","a fiery double-bladed axe","fiery cleave",22,880,"This large, double-bladed axe matches Kiha's axe. It's constantly flaming.", "Large");
		public const L__AXE :LargeAxe = new LargeAxe();
		public const L_DAGGR:Weapon = new Weapon("L.Daggr","L.Daggr","lust-enchanted dagger","an aphrodisiac-coated dagger","stab",3,240,"A dagger with a short blade in a wavy pattern.  Its edge seems to have been enchanted to always be covered in a light aphrodisiac to arouse anything cut with it.","Aphrodisiac Weapon");
		public const L_HAMMR:LargeHammer = new LargeHammer();
		public const LHSCYTH:LifehuntScythe = new LifehuntScythe();
		public const L_STAFF:LethiciteStaff = new LethiciteStaff();
		public const L_WHIP :LethiciteWhip = new LethiciteWhip();
		public const LANCE  :Lance = new Lance();
		public const MACE   :Weapon = new Weapon("Mace   ", "Mace", "mace", "a mace", "smash", 9, 360, "This is a mace, designed to be able to crush against various defenses.");
		public const MASAMUN:Masamune = new Masamune();
		public const N_STAFF:NocturnusStaff = new NocturnusStaff();
		public const NTWHIP :NineTailWhip = new NineTailWhip();
		public const NODACHI:Weapon = new Weapon("Nodachi","Nodachi","nodachi","a nodachi","keen cut",17,680,"A curved over 1,7 m long bladed weapon that cuts through flesh with the greatest of ease.", "Large");
		public const NPHBLDE:NephilimBlade = new NephilimBlade();
		public const OTETSU :OniTetsubo = new OniTetsubo();
		public const PIPE   :Weapon = new Weapon("Pipe   ","Pipe","pipe","a pipe","smash",2,80,"This is a simple rusted pipe of unknown origins.  It's hefty and could probably be used as an effective bludgeoning tool.");
		public const PTCHFRK:Weapon = new Weapon("PtchFrk","Pitchfork","pitchfork","a pitchfork","stab",10,400,"This is a pitchfork.  Intended for farm work but also useful as stabbing weapon.");
		public const PSWHIP :DualSuccubiWhip = new DualSuccubiWhip();
		public const PWHIP  :DualWhip = new DualWhip();
		public const PURITAS:Puritas = new Puritas();
		public const Q_GUARD:QueensGuard = new QueensGuard();
		public const RIBBON :Weapon = new Weapon("Ribbon ","Ribbon","long ribbon","a long ribbon","whip-like slash",5,200,"A long ribbon made of fine silk that despite it seemly fragile appearance can deal noticable damage to even few enemies at once.  Perfect example of weapon that is more dangerous than it looks.");
		public const RIDINGC:Weapon = new Weapon("RidingC","RidingC","riding crop","a riding crop","whip-crack",5,200,"This riding crop appears to be made of black leather, and could be quite a painful (or exciting) weapon.");
		public const RRAPIER:RaphaelsRapier = new RaphaelsRapier();
		public const RCLAYMO:RubyClaymore = new RubyClaymore();
		public const S_BLADE:Spellblade = new Spellblade();
		public const S_GAUNT:Weapon = new Weapon("S.Gaunt","S.Gauntlet","spiked gauntlet","a spiked gauntlet","spiked punch",5,200,"This single metal gauntlet has the knuckles tipped with metal spikes.  Though it lacks the damaging potential of other weapons, the sheer pain of its wounds has a chance of stunning your opponent.");
		public const SCARBLD:Weapon = new ScarredBlade();
		public const SCLAYMO:SapphireClaymore = new SapphireClaymore();
		public const SCIMITR:Weapon = new Weapon("Scimitr", "Scimitar", "scimitar", "a scimitar", "slash", 15, 600, "This curved sword is made for slashing.  No doubt it'll easily cut through flesh.");
		public const SESPEAR:SeraphicSpear = new SeraphicSpear();
		public const SPEAR  :Spear = new Spear();
		public const SUCWHIP:SuccubiWhip = new SuccubiWhip();
		public const TRASAXE:Weapon = new Weapon("TraSAxe","Train.S.Axe", "training soul axe", "a training soul axe", "cleave", 1, 80, "This axe was specialy forged and enhanted to help novice soul cultivatiors to train their soulforce.  Still if situation calls for it it could be used as a normal weapon.");
		public const TRIDENT:Trident = new Trident();
		public const U_STAFF:UnicornStaff = new UnicornStaff();
		public const W_STAFF:WizardsStaff = new WizardsStaff();
		public const WARHAMR:HugeWarhammer = new HugeWarhammer();
		public const WHIP   :Whip = new Whip();
		public const WG_GAXE:WingedGreataxe = new WingedGreataxe();
		public const WDBLADE:Wardensblade = new Wardensblade();
		public const WDSTAFF:Wardensstaff = new Wardensstaff();
		public const WGSWORD:Wardensgreatsword = new Wardensgreatsword();
		
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
