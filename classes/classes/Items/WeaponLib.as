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
		//1 atk for dual weapons = 80 lub 160 jeśli z dodatkowym perkiem lub 240 jeśli z dwoma dodatkowymi perkami
		//40 za 1 atk normalnie lub za wrath weapon lub 80 za 1 atk broni z perkiem/dod. efektem lub 120 za 1 atk broni z 2 perki/dod. efekty itd.
		//200 za 1 atk broni typu gaunlet (bo każda ma jakiś efekt lub perk dodany) lub 400 za 1 atk jeśli ma 2 efekty/perki lub 600 jak ma 3 itd.
		//In order for weapons to be tracked for the type that it is (gauntlet, sword, hammer...), make sure the type parameter matches the element in the isXWeapon function.
		//Type is a comma-seperated string, and is the last parameter.
		public static const DEFAULT_VALUE:Number = 6;

		public static const FISTS:Fists = new Fists();

		public const A_STAFF:AmphystStaff = new AmphystStaff();
		public const ACLAYMO:AmphystClaymore = new AmphystClaymore();
		public const ADAGGER:Weapon = new Weapon("ADagger","A.Dagger","amethyst dagger","an amethyst dagger","stab",3,240,"This dagger is made of obsidian and grotesquely decorated with amethysts and lead engravings. The magic within this murky blade will bleed unnatural darkness when charged with magic.", "Small", "Dagger");
		public const AETHERD:AetherD = new AetherD();
		public const ANGSTD :AngstDaggers = new AngstDaggers();
		public const ARMAGED:ArmageddonBlade = new ArmageddonBlade();
		public const ASCENSU:Ascensus = new Ascensus();
		public const ASTERIUS:AsteriusRage = new AsteriusRage();
		public const AWL_   :Weapon = new Weapon("Awl    ","Awl","awl","an awl","pierce",3,240,"A typical awl used to pierce magic hides when making magic armors or... to pierce organic object ;)", "Small, Bleed45", "Exotic");
		public const NRSABER:Weapon = new Weapon("NRSaber","NineRingedSaber","Nine-ringed Saber","a nine-ringed saber","slash",14,1120,"This saber, with added nine rings is capable of delivering deep, jagged wounds.", "Bleed10", "Sword");
		public const B_STAFF:BeautifulStaff = new BeautifulStaff();
		public const B_SWORD:BeautifulSword = new BeautifulSword();
		public const B_SCARB:Weapon = new Weapon("B.ScarB", "B.ScarBlade", "broken scarred blade", "a broken scarred blade", "slash", 12, 480, "This saber, made from lethicite-imbued metal, seems to no longer seek flesh; whatever demonic properties in this weapon is gone now but it's still an effective weapon.", "", "Sword");
		public const B_WIDOW:BlackWidow = new BlackWidow();
		public const BFGAUNT:Weapon = new Weapon("BFGaunt", "B.F.Gauntlets", "big fucking gauntlets", "a big fucking gauntlets", "smash", 0, 1600, "Big Fucking Gauntlets - the best solution for a tiny e-pen complex at this side of the Mareth!  This huge gauntlets signed by mysterious 'Vi' requires 150 strength to fully unleash it power.\nIncreases unarmed damage by 4x.\nIncreases stun chance by 40.", "LGWrath, Stun40", "Gauntlet");
		public const BFTHSWORD:BFTHSword = new BFTHSword();
		public const BFSWORD:BFSword = new BFSword();
		public const BFWHIP :BFWhip = new BFWhip();
		public const BLETTER:BloodLetter = new BloodLetter();
		public const CHAOSEA:Chaoseater = new Chaoseater();
		public const CLAWS  :Weapon = new Weapon("Claws","Claws","gauntlet with claws","a gauntlet with claws","rend",0,100,"Those metal gauntlets have tips of the fingers shaped like sharp natural claws.  Though they lacks the damaging potential of other weapons, they have a chance to leave bleeding wounds.", "Bleed10", "Gauntlet");
		public const CLAYMOR:LargeClaymore = new LargeClaymore();
		public const CNTWHIP:CatONineTailWhip = new CatONineTailWhip();
		public const C_BLADE:ChaosBlade = new ChaosBlade();
		public const DAGGER :Weapon = new Weapon("Dagger ","Dagger","dagger","a dagger","stab",3,120,"A small blade.  Preferred weapon for the rogues.", "Small", "Dagger");
		public const DAGWHIP:Weapon = new Weapon("DagWhip","DaggerWhip","dagger whip","a dagger whip","whip-like slash",5,200,"A small blade that is tied to the wrist by an 8 ft. cloth.  Could be used to attack few enemies at once.", "Small, Whipping", "Dagger");
		public const DAISHO :Daisho = new Daisho();
		public const DBFSWO :DualBFSword = new DualBFSword();
		public const DBFWHIP:DualBFWhip = new DualBFWhip();
		public const DDAGGER:DualDaggers = new DualDaggers();
		public const DEMSCYT:DemonicScythe = new DemonicScythe();
		public const DEPRAVA:Depravatio = new Depravatio();
		public const DE_GAXE:DemonicGreataxe = new DemonicGreataxe();
		public const DKATANA:DualKatana = new DualKatana();
		public const DORSOUL:DorcSouls = new DorcSouls();
		public const DRAPIER:DragonsRapier = new DragonsRapier();
		public const DWARWA :DwarvenWaraxe = new DwarvenWaraxe();
		public const D_WHAM_:DualHugeWarhammer = new DualHugeWarhammer();
		public const D_LANCE:DualLance = new DualLance();
		public const DL_AXE_:DualLargeAxe = new DualLargeAxe();
		public const DOCDEST:DefiledOniChieftainDestroyer = new DefiledOniChieftainDestroyer();
		public const DSWORD_:DualSwords = new DualSwords();
		public const DSSPEAR:DemonSnakespear = new DemonSnakespear();
		public const E_STAFF:EldritchStaff = new EldritchStaff();
		public const EBNYBLD:EbonyDestroyer = new EbonyDestroyer();
		public const ERIBBON:EldritchRibbon = new EldritchRibbon();
		public const EXCALIB:Excalibur = new Excalibur();
		public const FLAIL  :Weapon = new Weapon("Flail  ","Flail","flail","a flail","smash",10,400,"This is a flail, a weapon consisting of a metal spiked ball attached to a stick by chain. Be careful with this as you might end up injuring yourself.", "Whipping","Mace/Hammer");
		public const FLYINGC:WeaponWithPerk = new WeaponWithPerk("FlyingC","FlyingClaw","Flying Claw","a flying claw","rend",4,640,"A metal claws that is tied to the wrist by an 8 ft. cloth.  Could be used to attack few enemies at once.", "Body Cultivator's Focus", PerkLib.BodyCultivatorsFocus, 0.2, 0, 0, 0, "Small, Whipping, Bleed10", "Exotic");
		public const FLYWHIS:FlyWhisk = new FlyWhisk();
		public const FRTAXE :Weapon = new Weapon("Fr.T.Axe","Fr.T.Axe", "Francisca throwing axe", "a Francisca throwing axe", "cleave", 25, 2000, "A foreign axe, made in polished steel and decorated with hunting reliefs in gold and silver. It’s unusually light for its size, so you may be able to manage it with a single hand. Some runes engraved on the handle assure that it will return to you once it has hit your opponent.", "Large", "Axe, Thrown");
		public const CHAKRAM:Weapon = new Weapon("chakram","chakram", "chakram", "a chakram", "slash", 12, 960, "The chakram is a simple, elegant, and highly portable thrown weapon. It is a flat, open-centered metal discus with a sharpened edge.", "", "Exotic, Thrown");
		public const G_ROD  :Weapon = new Weapon("G. Rod", "G. Rod", "Golemancer Rod", "a Golemancer Rod", "smack", 0, 100, "This metal rod seems to empower golems through energy influx.", "Wand");
		public const G_SHURI:GiantShuriken = new GiantShuriken();
		public const GUANDAO:GuanDao = new GuanDao();
		public const G_SPEAR:Weapon = new Weapon("G.Spear", "G.Spear", "Guard's Spear", "a guard's spear", "thrust", 16,450,"A very sturdy and well-made spear\n", "", "Spear")
		public const H_GAUNT:Weapon = new Weapon("H.Gaunt", "H.Gaunt", "hooked gauntlets", "a set of hooked gauntlets", "clawing punch", 0, 400, "These metal gauntlets are covered in nasty looking hooks that are sure to tear at your foes flesh and cause them harm.","Bleed25","Gauntlet");
		public const HALBERD:Halberd = new Halberd();
		public const HNTCANE:HuntsmansCane = new HuntsmansCane();
		public const HSWORDS:HookSwords = new HookSwords();
		public const JRAPIER:JeweledRapier = new JeweledRapier();
		public const KARMTOU:WeaponWithPerk = new WeaponWithPerk("KarmTou", "KarmicTouch", "karmic gloves", "a pair of karmic gloves", "punch", 0, 400, "A pair of gauntlets, ordinary at first glance save by its immaculate appearance in shining metal and snow-white cloth.Their touch brings waste into the wicked flesh, punishing them in the form of blows more painful then should be.", "Body Cultivator's Focus, Stun25", PerkLib.BodyCultivatorsFocus, 0.5, 0, 0, 0, "", "Gauntlet");
		public const KATANA :Weapon = new Weapon("Katana ","Katana","katana","a katana","keen cut",17,680,"A curved bladed weapon that cuts through flesh with the greatest of ease.", "Large", "Dueling");
		public const KIHAAXE:Weapon = new Weapon("KihaAxe","Greataxe","fiery double-bladed axe","a fiery double-bladed axe","fiery cleave",22,880,"This large, double-bladed axe matches Kiha's axe. It's constantly flaming.", "Large", "Axe");
		public const L__AXE :LargeAxe = new LargeAxe();
		public const L_CLAWS:Weapon = new Weapon("L.Claws","LustyClaws","gauntlet with an aphrodisiac-coated claws","a gauntlet with an aphrodisiac-coated claws","rend",0,200,"Those metal gauntlets have tips of the fingers shaped like natural claws.  They seems to have been enchanted to always be covered in a light aphrodisiac to arouse anything cut with it.", "Bleed10", "Gauntlet");
		public const L_DAGGR:Weapon = new Weapon("L.Daggr","L.Daggr","lust-enchanted dagger","an aphrodisiac-coated dagger","stab",3,240,"A dagger with a short blade in a wavy pattern.  Its edge seems to have been enchanted to always be covered in a light aphrodisiac to arouse anything cut with it.", "Small", "Dagger");
		public const L_HAMMR:LargeHammer = new LargeHammer();
		public const L_STAFF:LethiciteStaff = new LethiciteStaff();
		public const L_WHIP :LethiciteWhip = new LethiciteWhip();
		public const LANCE  :Lance = new Lance();
		public const LHSCYTH:LifehuntScythe = new LifehuntScythe();
		public const LRAPIER:LustRapier = new LustRapier();
		public const MACE   :Weapon = new Weapon("Mace   ", "Mace", "mace", "a mace", "smash", 9, 360, "This is a mace, designed to be able to crush various defenses.","", "Mace/Hammer");
		public const RULER  :WeaponWithPerk = new WeaponWithPerk("Ruler  ", "Ruler", "ruler", "a ruler", "smash", 16, 2560, "The flat, wide rod has a center ridge on one side, flat on the other. The handle consists of a thick tang with a heavy iron bolster on either side.", "Body Cultivator's Focus", PerkLib.BodyCultivatorsFocus, 0.2, 0, 0, 0, "Large, Stun10", "Mace/Hammer");
		public const S_RULER:WeaponWithPerk = new WeaponWithPerk("S.Ruler", "S.Ruler", "Storm Ruler", "a Storm Ruler", "smash", 15, 4800, "It's looking like a greatword with broken blade still possesing residual power of lightning. Also known as the Giantslayer for bringings giants to their knees.", "Body Cultivator's Focus", PerkLib.BodyCultivatorsFocus, 0.2, 0, 0, 0, "Large, Stun10", "Mace/Hammer");
		public const MACGRSW:Weapon = new Weapon("Macgrsw","Mach.greatsword","Machine Greatsword","a Machine Greatsword","slash",19,4415,"This greatsword is half invention and half weapon. Instead of a sharp straight blade, the weapon’s sides are a set of metal teeth that constantly move in order to properly saw through flesh and more solid matter, creating grievous wounds. Very good for cutting down trees too.", "Large, Bleed100");
		public const MASAMUN:Masamune = new Masamune();
		public const MASTGLO:WeaponWithPerk = new WeaponWithPerk("MastGlo", "MasterGloves", "Master Gloves", "a Master Gloves", "punch", 0, 400, "These gloves belonged to Chi Chi. They seem to naturally strengthen the soulforce techniques of the user.", "Body Cultivator's Focus", PerkLib.BodyCultivatorsFocus, 0.4, 0, 0, 0, "","Gauntlet");
		public const MGSWORD:MoonlightGreatsword = new MoonlightGreatsword();
		public const MOONLIT:MoonlitSnow = new MoonlitSnow();
		public const N_STAFF:NocturnusStaff = new NocturnusStaff();
		public const NTWHIP :NineTailWhip = new NineTailWhip();
		public const NODACHI:Nodachi = new Nodachi();
		public const NORTHIP:NorthernerIcePicks = new NorthernerIcePicks();
		public const NPHBLDE:NephilimBlade = new NephilimBlade();
		public const OTETSU :OniTetsubo = new OniTetsubo();
		public const PHALLUS:ThePhalluspear = new ThePhalluspear();
		public const PIPE   :Weapon = new Weapon("Pipe   ","Pipe","pipe","a pipe","smash",2,80,"This is a simple rusted pipe of unknown origins.  It's hefty and could probably be used as an effective bludgeoning tool.","", "Mace/Hammer");
		public const POCDEST:PurifiedOniChieftainDestroyer = new PurifiedOniChieftainDestroyer();
		public const PRURUMI:PrithvirajUrumi = new PrithvirajUrumi();
		public const PSWHIP :DualSuccubiWhip = new DualSuccubiWhip();
		public const PTCHFRK:Weapon = new Weapon("PtchFrk","Pitchfork","pitchfork","a pitchfork","stab",10,400,"This is a pitchfork.  Intended for farm work but also useful as stabbing weapon.", "", "Spear");
		public const PWHIP  :DualWhip = new DualWhip();
		public const PURITAS:Puritas = new Puritas();
		public const Q_GUARD:QueensGuard = new QueensGuard();
		public const R_STAFF:RubyStaff = new RubyStaff();
		public const RDAGGER:Weapon = new Weapon("RDagger","R.Dagger","ruby dagger","an ruby dagger","stab",3,240,"This dagger is made of crimson metal and richly decorated with rubies and gold engravings. The magic within this crimson blade will flare up with magical flames when charged with magic.", "Small", "Dagger");
		public const RIBBON :Weapon = new Weapon("Ribbon ","Ribbon","long ribbon","a long ribbon","whip-like slash",5,200,"A long ribbon made of fine silk that despite it seemly fragile appearance can deal noticable damage to even few enemies at once.  Perfect example of weapon that is more dangerous than it looks.", "Whipping", "Ribbon");
		public const RIDINGC:Weapon = new Weapon("RidingC","RidingC","riding crop","a riding crop","whip-crack",5,200,"This riding crop appears to be made of black leather, and could be quite a painful (or exciting) weapon.");
		public const RIPPER1:Weapon = new Weapon("Ripper1","Ripper1.0","Ripper 1.0","a Ripper 1.0","slash",24,14445,"Similar to the machine Greatsword, this weapon is highly mechanical. Instead of a sharp straight blade, the weapon’s sides are a set of sharp metal teeth that constantly move in order to properly saw through flesh and more solid matter, creating grievous wounds. Very good for cutting down trees too.", "Large, Bleed100");
		public const RIPPER2:Weapon = new Weapon("Ripper2","Ripper2.0","Ripper 2.0","a Ripper 2.0","slash",29,37520,"Similar to the machine Greatsword, this weapon is highly mechanical. Instead of a sharp straight blade, the weapon’s sides are a set of sharp metal teeth that constantly move in order to properly saw through flesh and more solid matter, creating grievous wounds. The blades movement is so fast it creates heat along the length and thanks to a small system set, the saw is constantly aflame. Aside of cutting fleshy things in half, it is very good for taking down trees.", "Large, Bleed100");
		public const RRAPIER:RaphaelsRapier = new RaphaelsRapier();
		public const RCLAYMO:RubyClaymore = new RubyClaymore();
		public const S_BLADE:Spellblade = new Spellblade();
		public const S_GAUNT:Weapon = new Weapon("S.Gaunt","S.Gauntlet","spiked gauntlet","a spiked gauntlet","spiked punch",0,200,"This single metal gauntlet has the knuckles tipped with metal spikes.  Though it lacks the damaging potential of other weapons, the sheer pain of its wounds has a chance of stunning your opponent.", "Stun10", "Gauntlet");
		public const S_STAFF:SapphireStaff = new SapphireStaff();
		public const SCARBLD:ScarredBlade = new ScarredBlade();
		public const SCECOMM:Weapon = new Weapon("SceComm", "SceptreOfCom", "Sceptre of Command", "a Sceptre of Command", "smack", 4, 600, "This enchanted scepter empowers the abilities and control of summoners over their minions.");
		public const SCIMITR:Weapon = new Weapon("Scimitr", "Scimitar", "scimitar", "a scimitar", "slash", 15, 600, "This curved sword is made for slashing.  No doubt it'll easily cut through flesh.", "", "Sword");
		public const SCLAYMO:SapphireClaymore = new SapphireClaymore();
		public const SDAGGER:Weapon = new Weapon("SDagger","S.Dagger","sapphire dagger","an sapphire dagger","stab",3,240,"This dagger is made of azure metal and richly decorated with sapphires and silver engravings. The magic within this azure blade will radiate magical frost when charged with magic.", "Small", "Dagger");
		public const SESPEAR:SeraphicSpear = new SeraphicSpear();
		public const SIM_SPR:Weapon = new Weapon("Sim_Spr", "Sim.Spear", "simple spear", "a simple spear", "thrust", 10, 250, "A fairly crude-looking spear", "","Spear")
		public const SIM_STF:Weapon = new WeaponWithPerk ("Sim_Stf", "Sim.Staff", "simple staff", "a simple staff", "smack", 11, 75, "A simple staff, faint pure energy emanates from it.\n", "",PerkLib.WizardsFocus, 0.1, 0, 0, 0, "", "Staff");
		public const SKYPIER:Skypiercer = new Skypiercer();
		public const SNAKESW:Weapon = new Weapon("SnakeSw", "SnakeSword", "Snake Sword", "a Snake Sword", "whip-slash", 20, 800, "This unassuming double-edged sword is comprised of segmented pieces which, when swung, will lash out akin to a whip.", "Whipping", "Sword");
		public const SDRILL :SoulDrill = new SoulDrill();
		public const SPEAR  :Spear = new Spear();
		public const SUCWHIP:SuccubiWhip = new SuccubiWhip();
		public const T_HEART:TrullHeart = new TrullHeart();
		public const T_STAFF:TopazStaff = new TopazStaff();
		public const TCLAYMO:TopazClaymore = new TopazClaymore();
		public const TODAGGER:Weapon = new Weapon("ToDagger","T.Dagger","topaz dagger","an topaz dagger","stab",3,240,"This dagger is made of eversteel and richly decorated with yellow topazes and copper engravings. The magic within this shining blade will oversaturate the metal with electricity when charged with magic.", "Small", "Dagger");
		public const TDAGGER:Weapon = new Weapon("TDagger","ThrowDagger","throwing dagger","a throwing dagger","stab",2,160,"A small blade that could be thrown.  Preferred weapon for the rogues.", "Small", "Dagger, Thrown");
		public const TRIDAG :Weapon = new Weapon("TriDag ","TriDagger","tri-dagger","a tri-dagger","stab",4,320,"A dagger whose blade is shaped like a perfect equilateral triangle.  It has chance to leave bleeding wounds.", "Small, Bleed25", "Dagger");
		public const TRASAXE:Weapon = new Weapon("TraSAxe","Train.S.Axe", "training soul axe", "a training soul axe", "cleave", 1, 80, "This axe was specialy forged and enhanted to help novice soul cultivatiors to train their soulforce.  Still if situation calls for it it could be used as a normal weapon.", "", "Axe");
		public const TRIDENT:Trident = new Trident();
		public const TRSTSWO:Weapon = new Weapon("TrStSwo","TruestrikeSword", "Truestrike sword", "a Truestrike sword", "slash", 5, 400, "Lia will write desc of it...soon.", "", "Sword");
		public const U_STAFF:UnicornStaff = new UnicornStaff();
		public const UDKDEST:UndefeatedKingDestroyer = new UndefeatedKingDestroyer();
		public const UGATANA:Weapon = new Weapon("Uchigatana ","Uchigatana","Uchigatana","a Uchigatana","keen cut",15,680,"A one handed curved bladed weapon that cuts through flesh with the greatest of ease. Can also be wielded with both hands.", "Hybrid", "Dueling");
		public const URTAHLB:Weapon = new Weapon("UrtaHlb","UrtaHlb","halberd","a halberd","slash",50,2000,"Urta's halberd. How did you manage to get this?","Large, Whirlwind", "Polearm");
		public const VBLADE :Weapon = new Weapon("V.Blade","V.Blade", "V.Blade", "a V.Blade", "slash", 28, 2240, "A peculiar sword. The letter V is engraved into the blade perhaps its former owner name.", "", "Sword");
		public const VENCLAW:Weapon = new Weapon("VenClaw","Venoclaw","Venoclaw","a Venoclaw","rend",0,400,"This set of catclaw gloves was tempered using Etna's own venom and reinforced using some of her tail bone spikes, a proof of her eternal love to you. Its also enchanted to reinforce natural attacks.", "Bleed10", "Gauntlet");
		public const W_STAFF:WizardsStaff = new WizardsStaff();
		public const WARHAMR:HugeWarhammer = new HugeWarhammer();
		public const WHIP   :Whip = new Whip();
		public const WG_GAXE:WingedGreataxe = new WingedGreataxe();
		public const WDBLADE:Wardensblade = new Wardensblade();
		public const WDSTAFF:Wardensstaff = new Wardensstaff();
		public const WGSWORD:Wardensgreatsword = new Wardensgreatsword();
		public const YAMARG :WeaponWithPerk = new WeaponWithPerk("YamaRG", "YamaRajaGrasp", "Yama-Raja gloves", "a pair of Yama-Raja gloves", "punch", 0, 400, "These black gloves are made in black leather and an ebony alloy. Their corrupt touch seeks to destroy the pure and innocent. As such, it will seek the weak points of its victims when striking.", "Body Cultivator's Focus", PerkLib.BodyCultivatorsFocus, 0.5, 0, 0, 0, "", "Gauntlet");
		public const ZWNDER :Zweihander = new Zweihander();


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