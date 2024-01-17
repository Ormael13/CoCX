/**
 * Created by aimozg on 09.01.14.
 */
package classes.Items
{
import classes.Items.Dynamic.DynamicWeapon;
import classes.Items.Weapons.*;
import classes.PerkLib;

public final class WeaponLib extends ItemConstants
	{
		//1 atk for dual weapons = 80 lub 160 jeśli z dodatkowym perkiem lub 240 jeśli z dwoma dodatkowymi perkami
		//40 za 1 atk normalnie lub za wrath weapon lub 80 za 1 atk broni z perkiem/dod. efektem lub 120 za 1 atk broni z 2 perki/dod. efekty itd.
		//200 za 1 atk broni typu gaunlet (bo każda ma jakiś efekt lub perk dodany) lub 400 za 1 atk jeśli ma 2 efekty/perki lub 600 jak ma 3 itd.
		//In order for weapons to be tracked for the type that it is (gauntlet, sword, hammer...), make sure the type parameter matches the element in the isXWeapon function.
		//Type is a comma-seperated string, and is the last parameter.
		
		/** @paam subtypeId key in DynamicWeapon.Subtypes */
		private static function findCommonDynamicWeapon(subtypeId:String):DynamicWeapon {
			return ItemTemplateLib.instance.createWeapon(subtypeId, RARITY_COMMON, 0, CS_KNOWN_UNCURSED, []);
		}

		public function Legendary():Array {
			return legendaryPure().concat(LegendaryCorrupt()).concat(NEXUS);
		}
		public function legendaryPure():Array {
			return [
				NPHBLDE,
				T_HEART,
				KARMTOU,
				MASAMUN,
				U_STAFF,
				LHSCYTH,
				MOONLIT,
				WG_GAXE,
				SESPEAR,
				Q_GUARD,
				POCDEST,
				ARMAGED,
				OCCULUS,
				EXCALIB,
				DEXCALI,
				ASTERIUS
			];
		}
		public function LegendaryCorrupt():Array {
			return [
				EBNYBLD,
				DORSOUL,
				YAMARG,
				BLETTER,
				N_STAFF,
				HELRAIS,
				C_BLADE,
				DE_GAXE,
				DSSPEAR,
				B_WIDOW,
				DOCDEST,
				CHAOSEA,
				ECLIPSE
			];
		}
		
		public static const DEFAULT_VALUE:Number = 6;

		public static const FISTS:Fists = new Fists();

		public const A_STAFF:Weapon = new Weapon("A.Staff", "A. Staff", "amethyst staff", "an amethyst staff", "smack", 2, 240, "This staff is made of very old wood and seems to tingle to the touch.  The top has amethyst embedded in it, and the wood is worn smooth from lots of use.  It probably belonged to a wizard at some point and would aid magic use.", "Large, Staff", WT_STAFF).withBuffs({'spellpower':+0.2}) as Weapon;
		public const ACLAYMO:AmethystClaymore = new AmethystClaymore();
		public const ADAGGER:Weapon = new Weapon("ADagger","A.Dagger","amethyst dagger","an amethyst dagger","stab",3,240,"This dagger is made of obsidian and grotesquely decorated with amethysts and lead engravings. The magic within this murky blade will bleed unnatural darkness when charged with magic.", "Small", "Dagger");
		public const AETHERD:AetherD = new AetherD();
		public const ATWINSCY:AlvinaTwinScythe = new AlvinaTwinScythe();
		public const ANGSTD :AngstDaggers = new AngstDaggers();
		public const ANGSTD1:AngstDagger = new AngstDagger();
		public const ARI_SPR:Weapon = new Weapon("Ari_Spr", "ArigeanSpear", "Arigean Spear", "an Arigean Spear", "thrust", 13, 1040, "A black spear with white wrappings around the length of it, the metal shines a beautiful silver when even a small glimmer of light touches it. It supposedly becomes more dangerous the lower your mana is, and also should have no problem piercing armor.", WP_AP30,"Spear");
		public const ARICLUB:ArigeanClub = new ArigeanClub();
		public const ARMAGED:ArmageddonBlade = new ArmageddonBlade();
		public const ASCENSU:Weapon = new Weapon("Ascensus", "Ascensus", "Ascensus", "Ascensus, Element of Ascension", "smack", 30, 4800, "This staff is made from sacred wood and holy bark. Vines and tentacles run along the staff, grown out of the wood itself. The top has an odd zigzag shape, with pulsing crystals adorning the recesses. This staff radiates power, neither pure nor corrupt. (-25% spell cost, x6.5 spellpower / healpower)", "Large, Staff", WT_STAFF).withBuff('spellpower',+1.5) as Weapon;
		public const ASTERIUS:AsteriusRage = new AsteriusRage();
		public const AWL_   :Weapon = new Weapon("Awl    ","Awl","awl","an awl","pierce",3,240,"A typical awl used to pierce magic hides when making magic armors or... to pierce organic object ;)", "Small, Bleed45", "Exotic");
		public const B_STAFF:BeautifulStaff = new BeautifulStaff();
		public const B_SWORD:BeautifulSword = new BeautifulSword();
		public const B_WHIP :BeautifulWhip = new BeautifulWhip();
		public const B_FLYWHISK :BeautifulFlyWhisk = new BeautifulFlyWhisk();
		public const B_SCARB:Weapon = new Weapon("B.ScarB", "B.ScarBlade", "broken scarred blade", "a broken scarred blade", "slash", 12, 480, "This saber, made from lethicite-imbued metal, seems to no longer seek flesh; whatever demonic properties in this weapon is gone now but it's still an effective weapon.", "", WT_SWORD);
		public const B_WIDOW:BlackWidow = new BlackWidow();
		public const BCLAWS:BlizzardClaws = new BlizzardClaws();
		public const BFGAUNT:Weapon = new Weapon("BFGaunt", "B.F.Gauntlets", "big fucking gauntlets", "a big fucking gauntlets", "smash", 0, 1600, "Big Fucking Gauntlets - the best solution for a tiny e-pen complex at this side of the Mareth!  This huge gauntlets signed by mysterious 'Vi' requires 150 strength to fully unleash it power.\nIncreases unarmed damage by 2x.\nIncreases stun chance by 40.", "Large, LGWrath, Stun40", WT_GAUNTLET);
		public const BFTHSWORD:BFTHSword = new BFTHSword();
		public const BFSWORD:BFSword = new BFSword();
		public const BFWHIP :BFWhip = new BFWhip();
		public const BLETTER:BloodLetter = new BloodLetter();
		public const CATGLOV:Weapon = new Weapon("CatGlove", "CatGlove", "black cat glove", "a pair of black cat gloves", "punch", 0, 480, "Not quite a weapon as much as they are black gloves with open fingers to let the tips out. These were made and custom enchanted for a cat girl adventurer. While worn by someone with cat pawed hands in feral stance, allow to perform two more claw attacks per turn. Feral Attack also counts as a light weapon for the purpose of sneak attacks.", "Small", WT_GAUNTLET);
		public const CHAOSEA:Chaoseater = new Chaoseater();
		public const CLAWS  :Weapon = new Weapon("Claws","Claws","gauntlet with claws","a gauntlet with claws","rend",0,100,"Those metal gauntlets have tips of the fingers shaped like sharp natural claws.  Though they lacks the damaging potential of other weapons, they have a chance to leave bleeding wounds.", "Bleed10", WT_GAUNTLET);
		public const CLAYMOR:LargeClaymore = new LargeClaymore();
		public const CNTWHIP:CatONineTailWhip = new CatONineTailWhip();
		public const C_BLADE:ChaosBlade = new ChaosBlade();
		public const D_KAMA :DualKama = new DualKama();
		public const DAGGER :DynamicWeapon = findCommonDynamicWeapon("dagger");
		public const DAGWHIP:Weapon = new Weapon("DagWhip","DaggerWhip","dagger whip","a dagger whip","whip-like slash",5,200,"A small blade that is tied to the wrist by an 8 ft. cloth.  Could be used to attack few enemies at once.", "Small, Whipping", WT_DAGGER).withBuffs({'teasedmg': 30}) as Weapon;
		public const DAISHO :Daisho = new Daisho();
		public const DBFSWO :DualBFSword = new DualBFSword();
		public const DBFTHSWO:DualBFTHSword = new DualBFTHSword();
		public const DBFWHIP:DualBFWhip = new DualBFWhip();
		public const DBSWORD:DualBeautifulSword = new DualBeautifulSword();
		public const DDAGGER:DualDaggers = new DualDaggers();
		public const DDAGWHIP:DualDaggerWhips = new DualDaggerWhips();
		public const DEMSCYT:DemonicScythe = new DemonicScythe();
		public const DEPRAVA:Weapon = new Weapon("Depravatio", "Depravatio", "Depravatio", "Depravatio, Element of Corruption", "smack", 12, 1920, "This staff is made from sacred wood, infused with Marae’s bark. Tentacles run along the staff, and attempt to grope you when they think you’re not watching. The top has an odd zigzag shape, with clear crystals adorning the recesses. The staff seethes with corruption. (-15% spell cost, x2.5 black spellpower / healpower)", "Large, Staff", WT_STAFF).withBuff('spellpower',0.6) as Weapon;
		public const DEXCALI:DualExcalibur = new DualExcalibur();
		public const DE_GAXE:DemonicGreataxe = new DemonicGreataxe();
		public const DKATANA:DualKatana = new DualKatana();
		public const DNODACHI:DualNodachi = new DualNodachi();
		public const DORSOUL:DorcSouls = new DorcSouls();
		public const DRAPIER:DragonsRapier = new DragonsRapier();
		public const DWARWA :DwarvenWaraxe = new DwarvenWaraxe();
		public const D_FLAIL:DemonFlail = new DemonFlail();
		public const D_WHAM_:DualHugeWarhammer = new DualHugeWarhammer();
		public const D_LANCE:DualLance = new DualLance();
		public const DL_AXE_:DualLargeAxe = new DualLargeAxe();
		public const DL_WHIP:DualLethiciteWhip = new DualLethiciteWhip();
		public const DOCDEST:DefiledOniChieftainDestroyer = new DefiledOniChieftainDestroyer();
		public const DSWORD_:DualSwords = new DualSwords();
		public const DSSPEAR:DemonSnakespear = new DemonSnakespear();
		public const E_STAFF:Weapon = new Weapon("E.Staff", "E.Staff", "eldritch staff", "an eldritch staff", "thwack", 10, 800, "This eldritch staff once belonged to the Harpy Queen, who was killed after her defeat at your hands.  It fairly sizzles with magical power.", "Large, Staff", WT_STAFF).withBuff('spellpower', +0.6) as Weapon;
		public const EBNYBLD:EbonyDestroyer = new EbonyDestroyer();
		public const ERIBBON:Weapon = new Weapon("ERibbon", "ERibbon", "eldritch ribbon", "an eldritch ribbon", "whip-like slash", 5, 400, "A long ribbon made of fine silk that despite its seemingly fragile appearance can deal noticeable damage to several enemies at once.  It is inscribed with arcane runes, allowing it to facilitate spellcasting.", "Whipping",  WT_RIBBON).withBuff('spellpower', +0.4) as Weapon;
		public const EXCALIB:Excalibur = new Excalibur();
		public const FLAIL  :Weapon = findCommonDynamicWeapon("flail");
		public const FLYINGC:Weapon = new Weapon("FlyingC","FlyingClaw","Flying Claw","a flying claw","rend",4,640,"A metal claws that is tied to the wrist by an 8 ft. cloth.  Could be used to attack few enemies at once.", "Small, Whipping, Bleed10", WT_EXOTIC).withBuffs({
			'psoulskillpower': +0.2
		}) as Weapon;
		public const FLYWHIS:Weapon = new Weapon("FlyWhis", "FlyWhisk", "Fly-Whisk", "a Fly-Whisk", "slash", 0, 400, "This strange Daoist tool is a small wooden rod, with a prominently displayed ‘tail’ of plant fibers attached to the tip. Simply holding it seems to focus your concentration and empower your Soulforce!", "", WT_EXOTIC).withBuffs({
			'psoulskillpower':+0.2,
			'msoulskillpower':+0.2
		}) as Weapon;
		public const FRTAXE :Weapon = new Weapon("Fr.T.Axe","Fr.T.Axe", "Francisca throwing axe", "a Francisca throwing axe", "cleave", 25, 2000, "A foreign axe, made in polished steel and decorated with hunting reliefs in gold and silver. It’s unusually light for its size, so you may be able to manage it with a single hand. Some runes engraved on the handle assure that it will return to you once it has hit your opponent.", "Large", "Axe, Thrown");
		public const CHAKRAM:Weapon = new Weapon("chakram","chakram", "chakram", "a chakram", "slash", 12, 960, "The chakram is a simple, elegant, and highly portable thrown weapon. It is a flat, open-centered metal discus with a sharpened edge.", "", "Exotic, Thrown");
		public const G_ROD  :Weapon = new Weapon("G. Rod", "G. Rod", "Golemancer Rod", "a Golemancer Rod", "smack", 0, 100, "This metal rod seems to empower golems through energy influx.", "Wand");
		public const G_SHURI:GiantShuriken = new GiantShuriken();
		public const GUANDAO:GuanDao = new GuanDao();
		public const G_SPEAR:Weapon = new Weapon("G.Spear", "G.Spear", "Guard's Spear", "a guard's spear", "thrust", 16,450,"A very sturdy and well-made spear\n", WP_AP45, WT_SPEAR);
		public const H_GAUNT:Weapon = new Weapon("H.Gaunt", "H.Gaunt", "hooked gauntlets", "a set of hooked gauntlets", "clawing punch", 0, 400, "These metal gauntlets are covered in nasty looking hooks that are sure to tear at your foes flesh and cause them harm.","Bleed25","Gauntlet");
		public const HALBERD:Halberd = new Halberd();
		public const HELRAIS:Hellraiser = new Hellraiser();
		public const HNTCANE:HuntsmansCane = new HuntsmansCane();
		public const HSWORDS:HookSwords = new HookSwords();
		public const JRAPIER:JeweledRapier = new JeweledRapier();
		public const JUDGE_S:Weapon = new Weapon("Judge S", "JudgeStaff", "Judge staff", "a Judge staff", "smack", 10, 1600, "An ornamental staff favored by the desert anubi. A remnant of the god of death fate, these staves allowed their wielders to judge the weight of a soul or so legend says. Greatly empower soul skills but also improve spells.", "Large, Staff", WT_STAFF).withBuffs({
			'spellpower': +0.2,
			'msoulskillpower': +0.8
		}) as Weapon;
		public const KAMA   :Weapon = new Weapon("Kama","Kama", "kama", "a kama", "slash", 4,320, "The kama is a simple and elegant hand scythe weapon. Preferred weapon for the ninja fans.", "Small, Bleed10", "Scythe");
		public const KAMAWHIP:Weapon = new Weapon("KamaWhip","KamaWhip","kama whip","a kama whip","whip-like slash",3,240,"A small kama-like weapon with two scythe blades that is tied to the wrist by an 8 ft. cloth.  Could be used to attack few enemies at once.", "Small, Whipping, Bleed10", "Scythe, Thrown").withBuffs({'teasedmg': 30}) as Weapon;
		public const KARMTOU:KarmicTouch = new KarmicTouch();
		public const KATANA :DynamicWeapon = findCommonDynamicWeapon("katana");
		public const KIHAAXE:Weapon = new Weapon("KihaAxe","Greataxe","fiery double-bladed axe","a fiery double-bladed axe","fiery cleave",22,880,"This large, double-bladed axe matches Kiha's axe. It's constantly flaming.", "Large", "Axe");
		public const L__AXE :LargeAxe = new LargeAxe();
		public const L_CLAWS:Weapon = new Weapon("L.Claws","LustyClaws","gauntlet with an aphrodisiac-coated claws","a gauntlet with an aphrodisiac-coated claws","rend",0,200,"Those metal gauntlets have tips of the fingers shaped like natural claws.  They seems to have been enchanted to always be covered in a light aphrodisiac to arouse anything cut with it.", "Bleed10", "Gauntlet");
		public const L_DAGGR:Weapon = new Weapon("L.Daggr","L.Daggr","lust-enchanted dagger","an aphrodisiac-coated dagger","stab",3,240,"A dagger with a short blade in a wavy pattern.  Its edge seems to have been enchanted to always be covered in a light aphrodisiac to arouse anything cut with it.", "Small", "Dagger");
		public const L_HAMMR:LargeHammer = new LargeHammer();
		public const L_STAFF:Weapon = new Weapon("L.Staff", "Lthc. Staff", "lethicite staff", "a lethicite staff", "smack", 14, 1337, "This staff is made of a dark material and seems to tingle to the touch.  The top consists of a glowing lethicite orb.  It once belonged to Lethice who was defeated in your hands.", "Large, Staff", WT_STAFF).withBuff('spellpower', +0.8) as Weapon;
		public const L_WHIP :LethiciteWhip = new LethiciteWhip();
		public const LANCE  :Lance = new Lance();
		public const LHSCYTH:LifehuntScythe = new LifehuntScythe();
		public const LRAPIER:LustRapier = new LustRapier();
		public const MACE   :DynamicWeapon = findCommonDynamicWeapon("mace");
		public const MACGRSW:Weapon = new Weapon("Macgrsw","Mach.greatsword","Machine Greatsword","a Machine Greatsword","slash",19,2720,"This greatsword is half invention and half weapon. Instead of a sharp straight blade, the weapon’s sides are a set of metal teeth that constantly move in order to properly saw through flesh and more solid matter, creating grievous wounds. Very good for cutting down trees too.", "Large, Bleed100", "Exotic");
		public const MASAMUN:Masamune = new Masamune();
		public const MASTGLO:Weapon = new Weapon("MastGlo", "MasterGloves", "Master Gloves", "a Master Gloves", "punch", 0, 400, "These gloves belonged to Chi Chi. They seem to naturally strengthen the soulforce techniques of the user.", "",WT_GAUNTLET).withBuffs({
			'psoulskillpower': +0.4
		}) as Weapon;
		public const MCLAWS:MoonlightClaws = new MoonlightClaws();
		public const MGSWORD:MoonlightGreatsword = new MoonlightGreatsword();
		public const MOONLIT:MoonlitSnow = new MoonlitSnow();
		public const N_STAFF:NocturnusStaff = new NocturnusStaff();
		public const NRSABER:Weapon = new Weapon("NRSaber","NineRingedSaber","Nine-ringed Saber","a nine-ringed saber","slash",14,1120,"This saber, with added nine rings is capable of delivering deep, jagged wounds.", "Bleed10", "Sword");
		public const NTWHIP :NineTailWhip = new NineTailWhip();
		public const NODACHI:Nodachi = new Nodachi();
		public const NORTHIP:NorthernerIcePicks = new NorthernerIcePicks();
		public const NPHBLDE:NephilimBlade = new NephilimBlade();
		public const OTETSU :OniTetsubo = new OniTetsubo();
		public const PHALLUS:ThePhalluspear = new ThePhalluspear();
		public const PHALUSS:ThePhalluspears = new ThePhalluspears();
		//public const RCHEEP:Weapon = new ReaperCheep(); TODO: finish!
		public const PIPE   :Weapon = new Weapon("Pipe   ","Pipe","pipe","a pipe","smash",2,80,"This is a simple rusted pipe of unknown origins.  It's hefty and could probably be used as an effective bludgeoning tool.","", "Mace/Hammer");
		public const POCDEST:PurifiedOniChieftainDestroyer = new PurifiedOniChieftainDestroyer();
		public const PRURUMI:PrithvirajUrumi = new PrithvirajUrumi();
		public const PSWHIP :DualSuccubiWhip = new DualSuccubiWhip();
		public const PTCHFRK:Weapon = new Weapon("PtchFrk","Pitchfork","pitchfork","a pitchfork","stab",10,400,"This is a pitchfork.  Intended for farm work but also useful as stabbing weapon.", "", "Spear");
		public const PWHIP  :DualWhip = new DualWhip();
		public const PURITAS:Weapon = new Weapon("Puritas", "Puritas", "Puritas", "Puritas, Element of Purity", "smack", 12, 1920, "This staff is made from sacred wood, infused with Marae’s bark. Vines run along the staff, grown out of the wood itself. The top has an odd zigzag shape, with clear crystals adorning the recesses. The staff glows with power, radiating purity. (-15% spell cost, x2.5 white spellpower / healpower)", "Large, Staff", WT_STAFF).withBuff('spellpower', +0.6) as Weapon;
		public const Q_GUARD:QueensGuard = new QueensGuard();
		public const R_STAFF:Weapon = new Weapon("R.Staff", "R. Staff", "ruby staff", "a ruby staff", "smack", 2, 240, "This staff is made of very old wood and seems to tingle to the touch.  The top has ruby embedded in it, and the wood is worn smooth from lots of use.  It probably belonged to a wizard at some point and would aid magic use.", "Large, Staff", WT_STAFF).withBuff('spellpower', +0.2) as Weapon;
		public const RCLAYMO:RubyClaymore = new RubyClaymore();
		public const RDAGGER:Weapon = new Weapon("RDagger","R.Dagger","ruby dagger","a ruby dagger","stab",3,240,"This dagger is made of crimson metal and richly decorated with rubies and gold engravings. The magic within this crimson blade will flare up with magical flames when charged with magic.", "Small", "Dagger");
		public const RIBBON :Weapon = new Weapon("Ribbon ","Ribbon","long ribbon","a long ribbon","whip-like slash",5,200,"A long ribbon made of fine silk that despite it seemly fragile appearance can deal noticable damage to even few enemies at once.  Perfect example of weapon that is more dangerous than it looks.", "Whipping", "Ribbon");
		public const RIDINGC:Weapon = new Weapon("RidingC","RidingC","riding crop","a riding crop","whip-crack",5,200,"This riding crop appears to be made of black leather, and could be quite a painful (or exciting) weapon.").withBuffs({'teasedmg': 30}) as Weapon;
		public const RIPPER1:Weapon = new Weapon("Ripper1","Ripper1.0","Ripper 1.0","a Ripper 1.0","slash",24,8260,"Similar to the machine Greatsword, this weapon is highly mechanical. Instead of a sharp straight blade, the weapon’s sides are a set of sharp metal teeth that constantly move in order to properly saw through flesh and more solid matter, creating grievous wounds. Very good for cutting down trees too.", "Large, Bleed100", "Exotic");
		public const RIPPER2:Weapon = new Weapon("Ripper2","Ripper2.0","Ripper 2.0","a Ripper 2.0","slash",29,17360,"Similar to the machine Greatsword, this weapon is highly mechanical. Instead of a sharp straight blade, the weapon’s sides are a set of sharp metal teeth that constantly move in order to properly saw through flesh and more solid matter, creating grievous wounds. The blades movement is so fast it creates heat along the length and thanks to a small system set, the saw is constantly aflame. Aside of cutting fleshy things in half, it is very good for taking down trees.", "Large, Bleed100", "Exotic");
		public const RRAPIER:RaphaelsRapier = new RaphaelsRapier();
		public const RULER  :Weapon = new Weapon("Ruler  ", "Ruler", "ruler", "a ruler", "smash", 16, 2560, "The flat, wide rod has a center ridge on one side, flat on the other. The handle consists of a thick tang with a heavy iron bolster on either side.", "Large, Stun10", WT_MACE_HAMMER).withBuffs({
			'psoulskillpower': +0.2
		}) as Weapon;
		public const S_BLADE:Weapon = new Weapon("S.Blade", "S.Blade", "inscribed spellblade", "a spellblade", "slash", 8, 640, "Forged not by a swordsmith but a sorceress, this arcane-infused blade amplifies your magic. Unlike the wizard staves it is based on, this weapon also has a sharp edge, a technological innovation which has proven historically useful in battle.", "", "Sword, StaffPart").withBuff('spellpower', +0.5) as Weapon;
		public const S_GAUNT:Weapon = new Weapon("S.Gaunt","S.Gauntlet","spiked gauntlet","a spiked gauntlet","spiked punch",0,200,"This single metal gauntlet has the knuckles tipped with metal spikes.  Though it lacks the damaging potential of other weapons, the sheer pain of its wounds has a chance of stunning your opponent.", "Stun10", "Gauntlet");
		public const S_RULER:Weapon = new Weapon("S.Ruler", "S.Ruler", "Storm Ruler", "a Storm Ruler", "smash", 15, 4800, "It's looking like a greatword with broken blade still possesing residual power of lightning. Also known as the Giantslayer for bringings giants to their knees.", "Large, Stun10", WT_MACE_HAMMER).withBuffs({
			'psoulskillpower': +0.2
		}) as Weapon;
		public const S_STAFF:Weapon = new Weapon("S.Staff", "S. Staff", "sapphire staff", "a sapphire staff", "smack", 2, 240, "This staff is made of very old wood and seems to tingle to the touch.  The top has sapphire embedded in it, and the wood is worn smooth from lots of use.  It probably belonged to a wizard at some point and would aid magic use.", "Large, Staff", WT_STAFF).withBuff('spellpower', +0.2) as Weapon;
		public const SCARBLD:ScarredBlade = new ScarredBlade();
		public const SCECOMM:Weapon = new Weapon("SceComm", "SceptreOfCom", "Sceptre of Command", "a Sceptre of Command", "smack", 4, 600, "This enchanted scepter empowers the abilities and control of summoners over their minions.");
		public const SCIMITR:Weapon = new Weapon("Scimitr", "Scimitar", "scimitar", "a scimitar", "slash", 15, 600, "This curved sword is made for slashing.  No doubt it'll easily cut through flesh.", "", "Dueling");
		public const SCLAYMO:SapphireClaymore = new SapphireClaymore();
		public const SDAGGER:Weapon = new Weapon("SDagger","S.Dagger","sapphire dagger","a sapphire dagger","stab",3,240,"This dagger is made of azure metal and richly decorated with sapphires and silver engravings. The magic within this azure blade will radiate magical frost when charged with magic.", "Small", "Dagger");
		public const SESPEAR:SeraphicSpear = new SeraphicSpear();
		public const SIM_SPR:Weapon = new Weapon("Sim_Spr", "Sim.Spear", "simple spear", "a simple spear", "thrust", 10, 250, "A fairly crude-looking spear.", WP_AP30,"Spear");
		public const SIM_STF:Weapon = new Weapon ("Sim_Stf", "Sim.Staff", "simple staff", "a simple staff", "smack", 11, 75, "A simple staff, faint pure energy emanates from it.\n", "Large, Staff",WT_STAFF).withBuff('spellpower', +0.1) as Weapon;
		public const SKYPIER:Skypiercer = new Skypiercer();
		public const SNAKESW:Weapon = new Weapon("SnakeSw", "SnakeSword", "Snake Sword", "a Snake Sword", "whip-slash", 20, 800, "This unassuming double-edged sword is comprised of segmented pieces which, when swung, will lash out akin to a whip.", "Whipping", "Sword");
		public const SDRILL :SoulDrill = new SoulDrill();
		public const SPEAR  :Spear = new Spear();
		public const SUCWHIP:SuccubiWhip = new SuccubiWhip();
		public const T_HEART:TrullHeart = new TrullHeart();
		public const T_STAFF:Weapon = new Weapon("T.Staff", "T. Staff", "topaz staff", "a topaz staff", "smack", 2, 240, "This staff is made of very old wood and seems to tingle to the touch.  The top has topaz embedded in it, and the wood is worn smooth from lots of use.  It probably belonged to a wizard at some point and would aid magic use.", "Large, Staff", WT_STAFF).withBuff('spellpower', +0.2) as Weapon;
		public const TB_SCYT:Weapon = new Weapon("TBScyt", "T.B.Scythe", "two bladed scythe", "a two bladed scythe", "slash", 30, 2400, "The Two Bladed Scythe resembles a scythe with a long thin blue grip, and two blades at the tip.", "Large, Whirlwind, Bleed25", "Scythe");
		public const TCLAYMO:TopazClaymore = new TopazClaymore();
		public const TDAGGER:Weapon = new Weapon("TDagger","ThrowDagger","throwing dagger","a throwing dagger","stab",2,160,"A small blade that could be thrown. Preferred weapon for the rogues.", "Small", "Dagger, Thrown");
		public const TIDAR:Tidarion = new Tidarion();
		public const TKNIVES:TaintlessKnives = new TaintlessKnives();
		public const TMACGRSW:TwinMachineGreatsword = new TwinMachineGreatsword();
		public const TODAGGER:Weapon = new Weapon("ToDagger","T.Dagger","topaz dagger","a topaz dagger","stab",3,240,"This dagger is made of eversteel and richly decorated with yellow topazes and copper engravings. The magic within this shining blade will oversaturate the metal with electricity when charged with magic.", "Small", "Dagger");
		public const TRASAXE:Weapon = new Weapon("TraSAxe","Train.S.Axe", "training soul axe", "a training soul axe", "cleave", 1, 80, "This axe was specialy forged and enhanted to help novice soul cultivatiors to train their soulforce.  Still if situation calls for it it could be used as a normal weapon.", "", "Axe");
		public const TRIDAG :Weapon = new Weapon("TriDag ","TriDagger","tri-dagger","a tri-dagger","stab",4,320,"A dagger whose blade is shaped like a perfect equilateral triangle.  It has chance to leave bleeding wounds.", "Small, Bleed25", "Dagger");
		public const TRIDENT:Trident = new Trident();
		public const TRIPPER1:TwinRipper1 = new TwinRipper1();
		public const TRIPPER2:TwinRipper2 = new TwinRipper2();
		public const TRSTSWO:Weapon = new Weapon("TrStSwo","TruestrikeSword", "Truestrike sword", "a Truestrike sword", "slash", 5, 400, "Lia will write desc of it...soon.", "", "Sword");
		public const TACLAYM:TwinAmethystClaymores = new TwinAmethystClaymores();
		public const TRCLAYM:TwinRubyClaymores = new TwinRubyClaymores();
		public const TSRULER:TwinStormRulers = new TwinStormRulers();
		public const TSCLAYM:TwinSapphireClaymores = new TwinSapphireClaymores();
		public const TTCLAYM:TwinTopazClaymores = new TwinTopazClaymores();
		public const U_STAFF:UnicornStaff = new UnicornStaff();
		public const UDKDEST:UndefeatedKingDestroyer = new UndefeatedKingDestroyer();
		public const UGATANA:DynamicWeapon = findCommonDynamicWeapon("uchigatana");
		public const URTAHLB:Weapon = new Weapon("UrtaHlb","UrtaHlb","halberd","a halberd","slash",50,2000,"Urta's halberd. How did you manage to get this?","Large, Whirlwind", "Polearm");
		public const VBLADE :Weapon = new Weapon("V.Blade","V.Blade", "V.Blade", "a V.Blade", "slash", 28, 2240, "A peculiar sword. The letter V is engraved into the blade perhaps its former owner name.", "", "Sword");
		public const VENCLAW:Weapon = new Weapon("VenClaw","Venoclaw","Venoclaw","a Venoclaw","rend",0,400,"This set of catclaw gloves was tempered using Etna's own venom and reinforced using some of her tail bone spikes, a proof of her eternal love to you. Its also enchanted to reinforce natural attacks.", "Bleed10", "Gauntlet");
		public const W_STAFF:Weapon = new Weapon("W.Staff", "W. Staff", "wizard's staff", "a wizard's staff", "smack", 3, 240, "This staff is made of very old wood and seems to tingle to the touch.  The top has an odd zig-zag shape to it, and the wood is worn smooth from lots of use.  It probably belonged to a wizard at some point and would aid magic use.", "Large, Staff", WT_STAFF).withBuff('spellpower', +0.4) as Weapon;
		public const WARHAMR:HugeWarhammer = new HugeWarhammer();
		public const WHIP   :Whip = new Whip();
		public const WG_GAXE:WingedGreataxe = new WingedGreataxe();
		public const WDBLADE:Weapon = new Weapon("WDBlade", "WardensBlade", "Warden’s blade", "a Warden’s blade", "slash", 15, 1200, "Wrought from alchemy, not the forge, this sword is made from sacred wood and resonates with Yggdrasil’s song.", "", WT_SWORD).withBuffs({
			'psoulskillpower': +0.4
		}).withPerk(PerkLib.BladeWarden) as Weapon;
		public const WDSTAFF:Weapon = new Weapon("WDStaff", "WardensStaff", "Warden’s staff", "a Warden’s staff", "smack", 10, 1600, "This staff looks ordinary up until the crystal at its tip, which is attached by tendrils grown from the staff’s body. The sacred wood faintly seethes with arcane power, and the light within the crystal pulses to the tempo of Yggdrasil's song.", "Large, Staff", WT_STAFF)
				.withBuffs({
					'spellpower': +0.6,
					'msoulskillpower': +0.4
				})
				.withPerk(PerkLib.MageWarden) as Weapon;
		public const WGSWORD:Wardensgreatsword = new Wardensgreatsword();
		public const YAMARG :YamaRajaGrasp = new YamaRajaGrasp();
		public const ZWNDER :Zweihander = new Zweihander();
		//Spellcasting weapon
		public const S_SWORD:Weapon = new Weapon("S.Sword", "S.Sword", "Sorcerer sword", "a sorcerer sword", "slash", 25, 2000, "This weapon was forged by elven wizards. It is both an excelent catalyst and a deadly blade.", "", "Sword, StaffPart").withBuff('spellpower', +0.40) as Weapon;
		public const A_WAND:Weapon = new Weapon("A.Wand", "A.Wand", "Apprentice wand", "an apprentice wand", "smack", 1, 80, "A low quality wand. Light and cheap it is commonly used by young apprentices who have started learning magic. Seeing as beginners tend to cause their catalyst to explode this is the perfect weapon for them.", "Wand", WT_WAND).withBuff('spellpower', +0.30) as Weapon;
		public const O_WAND:Weapon = new Weapon("O.Wand", "O.Wand", "Old wand", "an old wand", "smack", 1, 500, "An old wand. It seems to be broken or worn out, perhaps it can be repaired by a skilled wizard? It is not very useful in its current state but may be able to boost your spellpower if repaired.", "Wand", WT_WAND).withBuff('spellpower', +0.10) as Weapon;
		public const R_WAND:Weapon = new Weapon("R.Wand", "R.Wand", "Repaired Old wand", "an old wand repaired by alvina", "smack", 1, 800, "An old wand that has been repaired for you by Alvina. It boosts your spellpower, though not as much as if it were made specifically for you.", "Wand", WT_WAND).withBuff('spellpower', +0.80) as Weapon;
		public const H_WAND:Weapon = new Weapon("H.Wand", "H.Wand", "hellcat wand", "a hellcat wand", "smack", 1, 500, "A hellcat witch wand. Commonly used by hellcats to deliver their iconic fire magic.", "Wand", WT_WAND).withBuff('spellpower', +1) as Weapon;
		public const WDAGGER:Weapon = new Weapon("WDagger","W.Dagger","witch dagger","a witch dagger","stab",3,500,"A dagger engraved with magical runes. While not the best catalyst around it is light, discreet and excelent for delivering spells.", "Small" , "Dagger, StaffPart").withBuff('spellpower', +0.20) as Weapon;
		public const OCCULUS:Occulus = new Occulus();
		public const ECLIPSE:Eclipse = new Eclipse();
		public const NEXUS:Nexus = new Nexus(); //We may need to add a special event or forge for this item
		public const NECROWA:NecroWand = new NecroWand();
	}
}