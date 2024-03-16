/**
 * ...
 * @author Ormael
 */
package classes.Items
{
import classes.Items.WeaponsRange.*;
import classes.PerkLib;

public final class WeaponRangeLib extends ItemConstants
	{
		public function Legendary():Array {
			return legendaryPure().concat(LegendaryCorrupt());
		}
		public function legendaryPure():Array {
			return [
				ARTEMIS,
				KSLHARP,
				GOODSAM
			]
		}
		public function LegendaryCorrupt():Array {
			return [
				WILDHUN,
				LEVHARP,
				BADOMEN
			];
		}


		public static const DEFAULT_VALUE:Number = 6;	//cena bazowa dla broni dyst to 50 gems a nie 40 gems
		public static const NOTHING:WeaponRange = new Nothing();	//cena broni palnych to: (wart atk * 20) + (ilość naboi w magazynku * 30)
		//public const TRFATBI:WeaponRange = new WeaponRange("TrFatbi", "TripxiFatbilly", "Tripxi Fatbilly", "a Tripxi Fatbilly", "shot", 260, 5230, "", WT_2H_FIREARM);
		//public const TRFATBI:WeaponRange = new WeaponRange("TrFatbi", "TripxiFatbilly", "Tripxi Fatbilly", "a Tripxi Fatbilly", "shot", 260, 5230, "", WT_2H_FIREARM);
		//pump action shotgun, Lawgiver (wzorowany na broni z Judge Dreed xD), x
		public const ADBSCAT:WeaponRange = new WeaponRange("DBScatt", "A.D.B.Scattergun", "antique double barrel scattergun", "an antique double barrel scattergun", "shot", 28, 920, "This is a double barrel scattergun. It's effective at short range but poor at long range. When fighting multiple enemies it bullet splitting after leaving muzzle cause to deal a bit more damage to enemies.\n\nGoblin Mech Compatibile", WT_RIFLE).withBuffs({'rangedaccuracy':-60}) as WeaponRange;
		public const ADBSHOT:WeaponRange = new WeaponRange("DBShot", "A.D.B.Shotgun", "antique double barrel shotgun", "an antique double barrel shotgun", "shot", 26, 880, "This is a double barrel shotgun. It slug not fracture on many fragmetns after leaving muzzle but it's still not the most accurate weapon. Which it make up by high damage of each slug.\n\nGoblin Mech Compatibile", WT_RIFLE).withBuffs({'rangedaccuracy':-20}) as WeaponRange;
		public const ALAKABL:WeaponRange = new WeaponRange("Alakabl", "Alakablam", "Alakablam", "an Alakablam", "shot", 20, 760, "This is a double barrel shotgun. Not the most accurate weapon but each slug deal magical damege.", WT_RIFLE).withBuffs({'rangedaccuracy':-20}) as WeaponRange;
		public const ARTEMIS:Artemis = new Artemis();
		public const ATKNIFE:WeaponRange = new WeaponRange("ATKnife", "A.ThrowingKnife", "amethyst throwing knife", "an amethyst throwing knife", "shot", 3, 300, "A small knife made of obsidian and grotesquely decorated with amethysts and lead engravings that could be thrown. The magic within this murky blade will bleed unnatural darkness when charged with magic. You can carry up to 15 on you and need to retrieve them after battles.", "Throwing");
		public const AVELYNN:WeaponRange = new WeaponRange("Avelynn", "Avelynn", "Avelynn", "Avelynn", "shot", 40, 6000, "A marvel of goblin prehistory before the time the first firearms were created, Avelynn prototype 3.0 is designed with several chained mechanism in order to allow firing up to 3 bolts all at the same time. Despite being primitive by modern goblin design this exquisite tool of death does its job well.", WT_CROSSBOW).withBuffs({'rangedaccuracy':+60}) as WeaponRange;
		public const BADOMEN:BadOmen = new BadOmen();
		public const BEA_BOW:BeautifulBow = new BeautifulBow();
		public const B_F_BOW:BFBow = new BFBow();
		public const BFXBOW_:WeaponRange = new WeaponRange("BFXBow", "BFXBow", "big fucking crossbow", "a big fucking crossbow", "shot", 60, 3000, "Big Fucking Crossbow - the best solution for a tiny e-pen complex at this side of the Mareth!", WT_CROSSBOW).withBuffs({'rangedaccuracy':+60}) as WeaponRange;
		public const BLUNDER:WeaponRange = new WeaponRange("Blunder", "Blunderbuss", "blunderbuss rifle", "a blunderbuss rifle", "shot", 16, 590, "This is a blunderbuss rifle. It's effective at short range but poor at long range.\n\nGoblin Mech Compatibile", WT_RIFLE);
		public const BOWGUID:WeaponRange = new WeaponRange("BowGuid", "BowGuided", "Guided bow", "a Guided bow", "shot", 6, 2400, "A bow ornemented with a small carving representing a target. It seems to never miss no mather how poorly you aim.", WT_BOW);
		public const BOWHODR:WeaponRange = new WeaponRange("BowHodr", "BowHodr", "Hodr's bow", "a Hodr's bow", "shot", 25, 3000, "Once was a frost giant wielding this bow and boasting to be the best hunter. To punish him Fera cursed him and his weapon rendering him permanently blind. Regardless, arrows drawn by this bow seems to seek out the eyes of its target.", WT_BOW).withBuffs({'rangedaccuracy':-10}) as WeaponRange;
		public const BOWHUNT:WeaponRange = new WeaponRange("BowHunt", "BowHunt", "hunter bow", "a hunter bow", "shot", 10, 500, "This is a hunter bow. It has better accuracy than long bow at the cost of slight lower damage.", WT_BOW);
		public const BOWKELT:WeaponRange = new WeaponRange("BowTain", "BowTain", "tainted bow", "a tainted bow", "shot", 30, 1500, "This bow is tainted by corruption in the past. It's quite effective at both short and long range. It balance helps uset to increase shooting accuracy quite a bit compared to other bows.", WT_BOW).withBuffs({'rangedaccuracy':+10}) as WeaponRange;
		public const BOWLIGH:WeaponRange = new WeaponRange("BowLigh", "BowLigh", "light bow", "a light bow", "shot", 5, 250, "This is a light bow. It's average in every way.", WT_BOW).withBuffs({'rangedaccuracy':-40}) as WeaponRange;
		public const BOWLONG:WeaponRange = new WeaponRange("BowLong", "BowLong", "longbow", "a longbow", "shot", 20, 1000, "This is a longbow. It allows to shoot arrows with greater speed dealing more damage at cost of slight lowered accuracy compared to hunter's bow.", WT_BOW).withBuffs({'rangedaccuracy':-30}) as WeaponRange;
		public const BOWOLD_:WeaponRange = new WeaponRange("BowOld ", "BowOld ", "old bow", "an old bow", "shot", 1, 50, "This is an old bow. It's barely effective even at short range not to meantion it poor accuracy.", WT_BOW).withBuffs({'rangedaccuracy':-50}) as WeaponRange;
		public const DALAKABL:DuAlakablam = new DuAlakablam();
		public const DBDRAGG:WeaponRange = new WeaponRange("DBDragG", "DoubleBarreledDragonGun", "Double barreled dragon gun", "a Double barreled dragon gun", "shot", 50, 1060, "Also called shotguns the dragon gun can hit multiple targets in a spray shot.", WT_2H_FIREARM);
		public const DERPLAU:WeaponRange = new WeaponRange("DerpLau", "DerpnadeLauncher", "Derpnade Launcher", "a Derpnade Launcher", "shot", 100, 2030, "A firearm as deadly to others as it is to the user. Launches bouncing explosives which deals aoe damage but can also bounce back if not careful!", WT_2H_FIREARM);
		public const DESEAGL:WeaponRange = new WeaponRange("DesEagl", "DesertEagle", "Desert Eagle", "a Desert Eagle", "shot", 25, 620, "A single hand firearm, the desert eagle has the largest bullets out of the pistol family. Its shots are deadly and precises through the gun has one hell of a recoil.\n\nGoblin Mech Compatibile", "Pistol");
		public const DPISTOL:WeaponRange = new WeaponRange("DPistol", "DartPistol", "Dart pistol", "a Dart pistol", "shot", 1, 120, "This weapon is not designed to wound but to deliver loads of chemical into the victim bloodstream.\n\nGoblin Mech Compatibile", "Pistol");
		public const DUEL_P_:WeaponRange = new WeaponRange("DuelP", "DuelingP", "dueling pistol", "a dueling pistol", "shot", 20, 430, "A pistol for duels between gentelmen. Or just for shooting. Can shoot only once before it need reload.\n\nGoblin Mech Compatibile", "Pistol").withBuffs({'rangedaccuracy':-10}) as WeaponRange;
		public const EVELYN_:WeaponRange = new WeaponRange("Evelyn", "Evelyn", "Evelyn", "Evelyn", "shot", 40, 6000, "A marvel of goblin prehistory before the time the first firearms were created, Avelynn prototype 3.0 is designed with several chained mechanism in order to allow firing up to 3 bolts all at the same time. Despite being primitive by modern goblin design this exquisite tool of death does its job well.", WT_CROSSBOW).withBuffs({'rangedaccuracy':+60}) as WeaponRange;
		public const FLINTLK:WeaponRange = new WeaponRange("Flintlk", "Flintlock", "flintlock pistol", "a flintlock pistol", "shot", 14, 310, "A flintlock pistol. Pew pew pew. Can fire once before a reload is required.\n\nGoblin Mech Compatibile", "Pistol");
		public const GOODSAM:GoodSamaritan = new GoodSamaritan();
		public const GTHRAXE:WeaponRange = new WeaponRange("GThrAxe", "GThrowAxes", "gnoll throwing axes", "a gnoll throwing axes", "shot", 25, 1250, "A set of throwing axes made and used by the gnoll barbarian, they are actually heavier than standard throwing weapon but all the more effective. You can carry up to 10 on you and need to retrieve them after battles.", "Throwing");
		public const GTHRSPE:WeaponRange = new WeaponRange("GThrSpe", "GThrowSpear", "gnoll throwing spear", "a gnoll throwing spear", "shot", 18, 900, "A standard javelin for ranged combat made by the gnolls. You can carry up to 20 on you and need to retrieve them after battles.", "Throwing");
		public const HARKON1:WeaponRange = new WeaponRange("Harkon1", "Harkonnen", "Harkonnen", "a Harkonnen", "shot", 160, 3230, "This 30 mm, single-shot breech loader cannon use 'true damage' shells.", WT_2H_FIREARM).withBuffs({'rangedaccuracy':-20}) as WeaponRange;
		public const HARKON2:HarkonnenII = new HarkonnenII();
		public const HARPGUN:WeaponRange = new WeaponRange("HarpGun", "HarpoonGun", "Harpoon gun", "a Harpoon gun", "shot", 50, 1030, "Standard issue goblin weaponry for underwater combat.\n\nGoblin Mech Compatibile", WT_RIFLE);
		public const HEXBOW_:WeaponRange = new WeaponRange("HeXbow", "HeavyXbow", "heavy crossbow", "a heavy crossbow", "shot", 25, 1250, "This is a heavy crossbow. High penetrative power and good accuracy.", WT_CROSSBOW).withBuffs({'rangedaccuracy':+40}) as WeaponRange;
		public const HUXBOW_:WeaponRange = new WeaponRange("HuXbow", "HuntXbow", "hunter crossbow", "a hunter crossbow", "shot", 15, 750, "This is a hunter crossbow. Slight better one with better accuracy and bolts penetrative power than light crossbow.", WT_CROSSBOW).withBuffs({'rangedaccuracy':+20}) as WeaponRange;
		public const IVIARG_:WeaponRange = new WeaponRange("IvIArq", "Iv.I.Arq", "ivory inlaid arquebus", "an ivory inlaid arquebus", "shot", 24, 840, "Gifted with a superb range and accuracy, this arquebus is truly a piece of art. Its stock has a gold trim and is inlaid with ivory in a pattern of wreath leaves. A layer of gold and ivory also runs through the barrel, giving the rifle a majestic look without compromising its functionality.\n\nGoblin Mech Compatibile", WT_RIFLE).withBuffs({'rangedaccuracy':+40}) as WeaponRange;
		public const KSLHARP:KrakenSlayerHarpoons = new KrakenSlayerHarpoons();
		public const LBLASTR:LactoBlasters = new LactoBlasters();
		public const LCROSBW:WeaponRange = new WeaponRange("LCrosbw", "LCrossbow", "light crossbow", "a light crossbow", "shot", 5, 250, "This is a light crossbow. A most basic one that fires bolts at your enemies.", WT_CROSSBOW).withBuffs({'rangedaccuracy':+10}) as WeaponRange;
		public const LEVHARP:LeviathanHarpoons = new LeviathanHarpoons();
		public const M1CERBE:WeaponRange = new WeaponRange("M1Cerbe", "M1Cerberus", "M1 Cerberus", "a M1 Cerberus", "shot", 45, 930, "A rifle prized for its precision and versatility, the Cerberus shoots multiple bullet in salvo ensuring that if one shot land all the others do with minimal recoil.\n\nGoblin Mech Compatibile", WT_2H_FIREARM);
		public const O_JAVEL:WeaponRange = new WeaponRange("O.Javel", "OldJavelins", "old javelins", "an old javelins", "shot", 1, 50, "An old training javelin for ranged combat. You can carry up to 10 on you and need to retrieve them after battles.", "Throwing");
		public const RTKNIFE:WeaponRange = new WeaponRange("RTKnife", "R.ThrowingKnife", "ruby throwing knife", "a ruby throwing knife", "shot", 3, 300, "A small knife made of crimson metal and richly decorated with rubies and gold engravings that could be thrown. The magic within this crimson blade will flare up with magical flames when charged with magic. You can carry up to 15 on you and need to retrieve them after battles.", "Throwing");
		public const SNIPPLE:WeaponRange = new WeaponRange("Snipple", "Snippler", "Snippler", "a Snippler", "shot", 50, 1030, "Thus named for its ability to hit the center of a nipple with perfect accuracy several hundred yards away, the Snippler perform best in situation were its extreme precision are assets such as from stealth.", WT_2H_FIREARM);
		public const SHUNHAR:SeaHuntressHarpoons = new SeaHuntressHarpoons();
		public const SHURIKE:WeaponRange = new WeaponRange("Shurike", "Shuriken", "shuriken", "a shuriken", "shot", 2, 100, "A throwing knife commonly used by ninja. You can carry up to 10 on you and need to retrieve them after battles.", "Throwing");
		public const SIXSHOT:WeaponRange = new WeaponRange("SixShot", "SixShooter", "Six shooter", "a Six shooter", "shot", 20, 580, "A revolver with six chambers. Its shots are deadly and precise.", "Pistol");
		public const STKNIFE:WeaponRange = new WeaponRange("STKnife", "S.ThrowingKnife", "sapphire throwing knife", "a sapphire throwing knife", "shot", 3, 300, "A small knife made of azure metal and richly decorated with sapphires and silver engravings that could be thrown. The magic within this azure blade will radiate magical frost when charged with magic. You can carry up to 15 on you and need to retrieve them after battles.", "Throwing");
		public const T_KNIFE:WeaponRange = new WeaponRange("T.Knife", "ThrowingKnife", "throwing knife", "a throwing knife", "shot", 2, 100, "A small knife that could be thrown.  Preferred weapon for the rogues. You can carry up to 10 on you and need to retrieve them after battles.", "Throwing");
		public const TDEEAGL:TwinDesertEagles = new TwinDesertEagles();
		public const TDPISTO:TwinDartPistol = new TwinDartPistol();
		public const TM1CERB:TwinM1Cerberuses = new TwinM1Cerberuses();
		public const TOUHOM3:WeaponRange = new WeaponRange("TouhoM3", "TouhounaM3", "Touhouna M3", "a Touhouna M3", "shot", 20, 430, "Pinnacle of goblin engineering, the Touhouna is what goblins call a mechagun. Never needing to be reloaded it shoots bullets in very fast succession achieving with sheer shot number what way more unwieldy or hazardous gun do.\n\nGoblin Mech Compatibile", WT_2H_FIREARM);
		public const TRFATBI:WeaponRange = new WeaponRange("TrFatbi", "TripxiFatbilly", "Tripxi Fatbilly", "a Tripxi Fatbilly", "shot", 260, 5230, "Tripxi has one moto… if you can't aim right, deliver an artillery shot so wide it hit everything in the next 200 yard reliably.", WT_2H_FIREARM);
		public const TRJAVEL:WeaponRange = new WeaponRange("TrJavel", "Tra.Javelins", "training javelins", "a training javelins", "shot", 5, 250, "A standard training javelin for ranged combat. You can carry up to 10 on you and need to retrieve them after battles.", "Throwing");
		public const TRSXBOW:WeaponRange = new WeaponRange("TrSXBow", "Tra.S.Xbow", "training soul crossbow", "a training soul crossbow", "shot", 1, 50, "This crossbow was specialy forged and enhanted to help novice soul cultivatiors to train their soulforce.  Still if situation calls for it it could be used as a normal range weapon.", WT_CROSSBOW).withBuffs({'rangedaccuracy':+5}) as WeaponRange;
		public const TTKNIFE:WeaponRange = new WeaponRange("TTKnife", "T.ThrowingKnife", "topaz throwing knife", "a topaz throwing knife", "shot", 3, 300, "A small knife made of eversteel and richly decorated with yellow topazes and copper engravings that could be thrown. The magic within this shining blade will oversaturate the metal with electricity when charged with magic. You can carry up to 15 on you and need to retrieve them after battles.", "Throwing");
		public const TWINGRA:TwinGrakaturd = new TwinGrakaturd();
		public const TWINSIXS:TwinSixShooter = new TwinSixShooter();
		public const WARDBOW:WeaponRange = new WeaponRange("WardBow", "WardensBow", "Warden’s bow", "a Warden’s bow", "shot", 20, 2000, "Recurve bows like this serve as a compromise for a shortbow’s accuracy and ease of use, with a longbow’s devastating stopping power.  The sacred wood quietly hums Yggdrasil's song, unheard by all but it’s wielder.", WT_BOW).withBuffs({
			'rangedaccuracy':+10,
			'psoulskillpower':+0.4,
			'msoulskillpower':+0.4
		}).withPerk(PerkLib.WildWarden) as WeaponRange;
		public const WILDHUN:WildHunt = new WildHunt();
		
		//Tomes
		public const E_TOME_:WeaponRange = new WeaponRange("E. Tome", "E. Tome", "Elementalist’s Tome", "an Elementalist's Tome", "nothing", 0, 500, "This ornate navy blue book is inscribed filled with magical glyphs and complicated diagrams, concealed within a detailed treatise on the nature of the world. The magic within this tome allows you to strengthen your connection with summoned elementals. (+50% to elementals damage)", "Tome");
		public const G_E_MAN:WeaponRange = new WeaponRange("G.E.Book", "G.E.Book", "Golemancy Evocation Manuscript", "A bundle of pages haphazardly bound together within a worn-out leather book.", "nothing", 0, 200, "This black tome is filled with golemancy knowledge. The magic within this tome allows you to control your manufactured golems with greater control and precision. (+50% to golems damage)", "Tome");
		public const I_TOME_:InquisitorsTome = new InquisitorsTome();
		public const RB_TOME:WeaponRange = new WeaponRange("R.B.Tome", "R.B.Tome", "Restrained Black Tome", "a Restrained Black Tome", "nothing", 0, 100, "This solid black tome is totally unmarked, saved for a blood red thin chain that is wrapped around it.  The pages are edged with gold, like some of the fancy books in the monastary back home. (Increase spellpower and reduce cooldown for tier 1 black spells at levels below 18)", "Tome");
		public const RG_TOME:WeaponRange = new WeaponRange("R.G.Tome", "R.G.Tome", "Restrained Grey Tome", "a Restrained Grey Tome", "nothing", 0, 200, "This grey tome is totally unmarked, and on the cover is wrote few words that seems have no meaning or maybe you just aren't able to decipher them yet. A plain green thin chains is wrapped around it. (Increase spellpower and reduce cooldown for tier 1 grey spells at levels below 18)", "Tome");
		public const RW_TOME:WeaponRange = new WeaponRange("R.W.Tome", "R.W.Tome", "Restrained White Tome", "a Restrained White Tome", "nothing", 0, 100, "This white tome is totally unmarked, and the cover is devoid of any lettering or title.  A shiny brass thin chain is wrapped around it. (Increase spellpower and reduce cooldown for tier 1 white spells at levels below 18)", "Tome");
		public const SSKETCH:WeaponRange = new WeaponRange("SSketch", "S.Sketchbook", "Sage’s Sketchbook", "a Sage’s Sketchbook", "nothing", 0, 500, "Strangely, this ornate blue book is completely blank.  Yet, as you flip through it, you occasionally see magical glyphs and complicated diagrams out of the corner of your eye, only to disappear as you focus.  Still, the arcane energies within the book could augment your spellcraft.", "Tome").withBuffs({'spellpower': + 0.6}) as WeaponRange;

		public const NEKONOM:WeaponRange = new WeaponRange("MissingNo", "MissingNo", "MissingNo", "MissingNo", "nothing", 0, 500, "This is a deprecated weapon no longer in use it will be removed from the game in a few version. Please remove it from your character and delete it for safety", "Tome");
		
		//===================//
		// Single/Dual pairs //
		//===================//
		
		public const SingleDualPairList:/*Array*/Array = [
			[SIXSHOT, TWINSIXS],
			[M1CERBE, TM1CERB],
			[ALAKABL, DALAKABL],
			[DESEAGL, TDEEAGL]
			//[HARKON1, HARKON2],
		];
		
		/*
		private static function mk(id:String,shortName:String,name:String,longName:String,verb:String,attack:Number,value:Number,description:String,perk:String=""):Weapon {
			return new Weapon(id,shortName,name,longName,verb,attack,value,description,perk);
		}
		*/
		public function WeaponRangeLib()
		{
		}
	}
}
