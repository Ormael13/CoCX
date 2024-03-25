/**
 * Created by aimozg on 09.01.14.
 */
package classes.Items
{
import classes.Items.Dynamic.DynamicWeapon;
import classes.Items.Weapons.*;
import classes.PerkLib;
import classes.Races;

public final class WeaponLib extends ItemConstants
	{
		//1 atk for dual weapons = 80 lub 160 jeśli z dodatkowym perkiem lub 240 jeśli z dwoma dodatkowymi perkami
		//40 za 1 atk normalnie lub za wrath weapon lub 80 za 1 atk broni z perkiem/dod. efektem lub 120 za 1 atk broni z 2 perki/dod. efekty itd.
		//200 za 1 atk broni typu gaunlet (bo każda ma jakiś efekt lub perk dodany) lub 400 za 1 atk jeśli ma 2 efekty/perki lub 600 jak ma 3 itd.
		
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
				ASTERIUS,
				ELYSIUM
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
				ECLIPSE,
				HELLCAL
			];
		}
		
		public static const DEFAULT_VALUE:Number = 6;

		public static const FISTS:Fists = new Fists();
		
		// Template for new weapons
		
//		public const CONSTANTNAME:Weapon = new Weapon(
//				"id", "ButtonLabel","name","the long name", attack number, price number,
//				"Tooltip description",
//				WT_WEAPONTYPE, WSZ_WEAPONSSIZE, dual true/false) // dual is false by default
//				// optional: buffs
//				.withBuffs({
//					'statname': buff value number
//				})
//				// optional: perk on equip
//				.withPerk(PerkLib.Something)
//				// optional: item tags
//				.withTags(I_SOMETHING, W_SOMETHING)
//				// optional: item effect
//				.withEffect(IELib.Effect, power number)
//				// optional: item effect with extra values
//				.withEffect(IELib.Effect, power number, value1, value2, value3, value4) as Weapon;
//				// 'as Weapon' is needed after last ')' if any of '.withSomething' was used
		
		public const A_STAFF:Weapon = new Weapon(
				"A.Staff", "A. Staff", "amethyst staff", "an amethyst staff", "smack", 2, 240,
				"This staff is made of very old wood and seems to tingle to the touch.  The top has amethyst embedded in it, and the wood is worn smooth from lots of use.  It probably belonged to a wizard at some point and would aid magic use.",
				WT_STAFF, WSZ_LARGE)
				.withBuffs({'spellpower':+0.2}) as Weapon;
		public const ACLAYMO:Weapon = new Weapon(
				"AClaymo", "A.Claymore", "amethyst claymore", "an amethyst claymore", "cleaving sword-slash", 15, 1200,
				"This two-handed sword is made of obsidian and grotesquely decorated with amethysts and lead engravings. The magic within this murky blade will bleed unnatural darkness when charged with magic.",
				WT_SWORD, WSZ_LARGE)
				.withEffect(IELib.ScaleAttack_Str, 60) as Weapon;
		public const ADAGGER:Weapon = new Weapon(
				"ADagger","A.Dagger","amethyst dagger","an amethyst dagger","stab",3,240,
				"This dagger is made of obsidian and grotesquely decorated with amethysts and lead engravings. The magic within this murky blade will bleed unnatural darkness when charged with magic.",
				WT_DAGGER, WSZ_SMALL);
		public const AETHERD:Weapon = new AetherD();
		//Effect: Magic catalyst 180%, Count as a dual weapon this item also damage enemies mana on each successful swing. Also cause the burn status for 3 rounds.
		public const ATWINSCY:Weapon = new Weapon(
				"ATWINSCY","A.TwinScythe","twin scythe","Alvina's Twin Scythes","slash",20,12000,
				"Alvina’s beloved weapons. These pair of scythes were used to slay rival mages. The black flame which blaze along this cursed item’s blade burns the victim’s magic like fuel. Alvina rarely ever used this item to its full extent, only pulling it out as a trump card against her deadliest opponents when magic alone proved insufficient.",
				WT_SCYTHE,WSZ_LARGE,true)
				.withBuff('spellpower', +1.8)
				.withTags(W_WHIRLWIND,W_STAFFPART, W_FIRE_TYPE)
				.withEffect(IELib.Bleed,10)
				.withEffect(IELib.AttackBonus_Cor, 1/20) as Weapon;
		public const ANGSTD :Weapon = new Weapon(
				"AngstD","AngstDaggers","Angst Daggers","a set of Angst Daggers","stab",20,3200,
				"A pair of small blades filled with anger. To fully unleash potential of those deadly blades is required 300+ speed and 60+ strength.",
				WT_DAGGER, WSZ_SMALL, true)
				.withEffect(IELib.ScaleAttack_Spe, 300)
				.withEffect(IELib.ScaleAttack_Str, 60) as Weapon;
		public const ANGSTD1:Weapon = new Weapon(
				"AngstD1","AngstDagger","Angst Dagger","an Angst Dagger","stab",20,1600,
				"A small blade filled with anger. To fully unleash potential of this deadly blade is required 300+ speed and 60+ strength.",
				WT_DAGGER, WSZ_SMALL)
				.withEffect(IELib.ScaleAttack_Spe, 300)
				.withEffect(IELib.ScaleAttack_Str, 60) as Weapon;
		public const ARI_SPR:Weapon = new Weapon(
				"Ari_Spr", "ArigeanSpear", "Arigean Spear", "an Arigean Spear", "thrust", 13, 1040,
				"A black spear with white wrappings around the length of it, the metal shines a beautiful silver when even a small glimmer of light touches it. It supposedly becomes more dangerous the lower your mana is, and also should have no problem piercing armor.",
				WT_SPEAR, WSZ_MEDIUM)
				.withEffect(IELib.ArmorPenetration, 30) as Weapon;
		public const ARICLUB:Weapon = new Weapon(
				"AriClub", "ArigeanClub", "Arigean Club", "an Arigean Club", "smash", 11, 880,
				"A black club with white wrappings, the metal shines silver when even a small glimmer of light hits it. It should prove useful in keeping your foes at bay.",
				WT_MACE_HAMMER,WSZ_MEDIUM)
				.withEffect(IELib.AttackBonus_RaceTier, 4, Races.ARIGEAN) as Weapon;
		public const ARMAGED:Weapon = new ArmageddonBlade();
		public const ASCENSU:Weapon = new Weapon(
				"Ascensus", "Ascensus", "Ascensus", "Ascensus, Element of Ascension", "smack", 30, 4800,
				"This staff is made from sacred wood and holy bark. Vines and tentacles run along the staff, grown out of the wood itself. The top has an odd zigzag shape, with pulsing crystals adorning the recesses. This staff radiates power, neither pure nor corrupt. (-25% spell cost, x6.5 spellpower / healpower)",
				WT_STAFF, WSZ_LARGE)
				.withBuff('spellpower',+1.5) as Weapon;
		public const ASTERIUS:AsteriusRage = new AsteriusRage();
		public const AWL_   :Weapon = new Weapon(
				"Awl    ","Awl","awl","an awl","pierce",3,240,
				"A typical awl used to pierce magic hides when making magic armors or... to pierce organic object ;)",
				WT_EXOTIC, WSZ_SMALL)
				.withEffect(IELib.Bleed, 45) as Weapon;
		public const B_STAFF:Weapon = new BeautifulStaff();
		public const B_SWORD:Weapon = new Weapon(
				"B.Sword", "B.Sword", "beautiful sword", "a beautiful shining sword", "slash", 17, 560,
				"This beautiful sword shines brilliantly in the light, showing the flawless craftsmanship of its blade.  The pommel and guard are heavily decorated in gold and brass.  Some craftsman clearly poured his heart and soul into this blade.",
				WT_SWORD, WSZ_MEDIUM)
				.withEffect(IELib.Require_CorBelow, 33)
				.withEffect(IELib.AttackBonus_Cor, -1/3) as Weapon;
		public const B_WHIP :Weapon = new Weapon(
				"B.Whip", "B.Whip", "beautiful whip", "a beautiful shining whip", "whipping", 14, 400,
				"This beautiful whip shines brilliantly in the light, showing the flawless craftsmanship.  The handle and transition knot are heavily decorated in gold and brass.  Some craftsman clearly poured his heart and soul into this whip.",
				WT_WHIP, WSZ_MEDIUM)
				.withBuffs({'teasedmg': 35})
				.withTag(W_WHIPPING)
				.withEffect(IELib.Require_CorBelow, 33)
				.withEffect(IELib.AttackBonus_Cor, -1/3) as Weapon;
		public const B_FLYWHISK :Weapon = new BeautifulFlyWhisk();
		public const B_SCARB:Weapon = new Weapon(
				"B.ScarB", "B.ScarBlade", "broken scarred blade", "a broken scarred blade", "slash", 12, 480,
				"This saber, made from lethicite-imbued metal, seems to no longer seek flesh; whatever demonic properties in this weapon is gone now but it's still an effective weapon.",
				WT_SWORD, WSZ_MEDIUM);
		public const B_WIDOW:Weapon = new Weapon(
				"BWidow", "B. Widow", "black widow rapier", "a black widow rapier", "slash", 60, 9600,
				"A rapier that used to belong a deceitful noblewoman, made in a strange, purple metal. Its pommel design looks similar to that of a spiderweb, while the blade and hilt are decorated with amethysts and arachnid-looking engravings.",
				WT_DUELING, WSZ_MEDIUM)
				.withTags(I_LEGENDARY, W_RAPIER)
				.withEffect(IELib.ArmorPenetration, 100)
				.withEffect(IELib.AttackBonus_Fem, 1/10)
				.withEffect(IELib.AttackBonus_Cor, 1/10)
				.withEffect(IELib.ScaleAttack_Spe, 100) as Weapon;
		public const BCLAWS:BlizzardClaws = new BlizzardClaws();
		public const BFGAUNT:Weapon = new Weapon(
				"BFGaunt", "B.F.Gauntlets", "big fucking gauntlets", "a big fucking gauntlets", "smash", 0, 1600,
				"Big Fucking Gauntlets - the best solution for a tiny e-pen complex at this side of the Mareth!  This huge gauntlets signed by mysterious 'Vi' requires 150 strength to fully unleash it power.\nIncreases unarmed damage by 2x.\nIncreases stun chance by 40.",
				WT_GAUNTLET, WSZ_LARGE)
				.withEffect(IELib.Stun, 40)
				.withTags(W_LGWRATH) as Weapon;
		public const BFTHSWORD:Weapon = new Weapon("BFTHSword", "BFTHSword", "big fucking two-handed sword", "a big fucking two-handed sword", "slash", 100, 4000, "Big Fucking Two-Handed Sword - if the best solution for a tiny e-pen complex at this side of the Mareth not work take this one! This 2H 4 meters long sword requires 250 strength to fully unleash it power.", WT_SWORD, WSZ_MASSIVE)
				.withTag(W_LGWRATH)
				.withEffect(IELib.ScaleAttack_StrXL, 250) as Weapon;
		public const BFSWORD:Weapon = new Weapon("BFSword", "B.F.Sword", "big fucking sword", "a big fucking sword", "slash", 50, 2000, "Big Fucking Sword - the best solution for a tiny e-pen complex at this side of the Mareth!  This 2H 2,5 meters long sword requires 150 strength to fully unleash it power.", WT_SWORD, WSZ_LARGE)
				.withTag(W_LGWRATH)
				.withEffect(IELib.ScaleAttack_Str, 150) as Weapon;
		public const BFWHIP :Weapon = new Weapon("BFWhip", "B.F.Whip", "big fucking whip", "a big fucking whip", "whipping", 36, 1440, "Big Fucking Whip - the best solution for master tiny e-pen complex at this side of the Mareth!  This 2H 5 meters long whip requires 225 (strength+speed) to fully unleash it power.", WT_WHIP,WSZ_LARGE)
				.withBuffs({'teasedmg': 50})
				.withEffect(IELib.ScaleAttack_StrSpe, 225)
				.withTags(W_WHIPPING,W_LGWRATH) as Weapon;
		public const BLETTER:Weapon = new Weapon(
				"BLDLetter","Blood Letter","bloodletter katana","a bloodletter katana","slash",132,10560,
				"This dark blade is as beautiful as it is deadly, made in black metal and decorated with crimson ruby gemstones. Lending its power to a corrupt warrior, it will strike with an unholy force, albeit, draining some blood from its wielder on the process.", WT_DUELING, WSZ_LARGE)
				.withTags(I_LEGENDARY, W_CORRUPT_TYPE)
				.withEffect(IELib.AttackBonus_Cor, 3/5)
				.withEffect(IELib.ScaleAttack_Spe, 100) as Weapon;
		public const CATGLOV:Weapon = new Weapon(
				"CatGlove", "CatGlove", "black cat glove", "a pair of black cat gloves", "punch", 0, 480,
				"Not quite a weapon as much as they are black gloves with open fingers to let the tips out. These were made and custom enchanted for a cat girl adventurer. While worn by someone with cat pawed hands in feral stance, allow to perform two more claw attacks per turn. Feral Attack also counts as a light weapon for the purpose of sneak attacks.",
				WT_GAUNTLET, WSZ_SMALL);
		public const CHAOSEA:Weapon = new Weapon(
				"Chaosea", "Chaoseater", "Chaoseater", "a Chaoseater", "slash", 410, 65600,
				"It's incredibly large blade with jagged edges on both sides along with the skulls engraved within the middle of the blade. Requires 500 strength to fully unleash it power.",
				WT_SWORD, WSZ_MASSIVE)
				.withTags(W_MGWRATH, I_LEGENDARY, W_CORRUPT_TYPE)
				.withEffect(IELib.AttackBonus_Cor, 1/2)
				.withEffect(IELib.ScaleAttack_StrXL, 500) as Weapon;
		public const CLAWS  :Weapon = new Weapon(
				"Claws","Claws","gauntlet with claws","a gauntlet with claws","rend",0,100,
				"Those metal gauntlets have tips of the fingers shaped like sharp natural claws.  Though they lacks the damaging potential of other weapons, they have a chance to leave bleeding wounds.",
				WT_GAUNTLET, WSZ_SMALL)
				.withEffect(IELib.Bleed, 10) as Weapon;
		public const CLAYMOR:Weapon = new Weapon(
				"Claymor", "L.Claymore", "large claymore", "a large claymore", "cleaving sword-slash", 15, 600,
				"A massive sword that a very strong warrior might use.  Requires 40 strength to unleash full attack power.",
				WT_SWORD,WSZ_LARGE)
				.withEffect(IELib.ScaleAttack_Str, 60) as Weapon;
		//przerobić na high grade wrath weapon?
		public const CNTWHIP:Weapon = new Weapon(
				"CNTWhip", "CatONineTailWhip", "Bastet Whip", "a Bastet Whip", "whipping", 45, 1080,
				"A rope made from unknown magic beast fur that unravelled into three small ropes, each of which is unravelled again designed to whip and cut your foes into submission.",
				WT_WHIP, WSZ_LARGE)
				.withTag(W_WHIPPING)
				.withEffect(IELib.Bleed, 25)
				.withEffect(IELib.ScaleAttack_StrSpe, 225) as Weapon;
		public const C_BLADE:Weapon = new Weapon(
				"ChaosBlade", "Chaos Blade", "Chaos Blade", "a Chaos Blade", "slash", 135, 10800,
				"This dark blade is as beautiful as it is deadly, made in black metal and decorated with a single crimson ruby gemstones. Lending its power to a corrupt warrior, it will strike with an unholy force, albeit, draining some blood from its wielder on the process as this weapon is not meant to be wielded by mortals.",
				WT_DUELING, WSZ_MEDIUM)
				.withTags(W_HYBRID, I_LEGENDARY, W_CORRUPT_TYPE)
				.withEffect(IELib.AttackBonus_Cor, 3 / 5)
				.withEffect(IELib.ScaleAttack_Spe, 100) as Weapon;
		public const D_KAMA :Weapon = new Weapon(
				"D.Kama","D.Kama","dual kama","a dual kama","stab",4,640,
				"A pair of kama. Preferred weapon for the ninja fans.",
				WT_SCYTHE, WSZ_SMALL, true)
				.withEffect(IELib.Bleed, 10) as Weapon;
		public const DAGGER :DynamicWeapon = findCommonDynamicWeapon("dagger");
		public const DAGWHIP:Weapon = new Weapon(
				"DagWhip","DaggerWhip","dagger whip","a dagger whip","whip-like slash",5,200,
				"A small blade that is tied to the wrist by an 8 ft. cloth.  Could be used to attack few enemies at once.",
				WT_DAGGER, WSZ_SMALL)
				.withBuffs({'teasedmg': 30})
				.withTags(W_WHIPPING) as Weapon;
		public const DAISHO:Weapon = new Weapon(
				"Daisho ", "Daisho", "daisho", "a daisho", "keen cut", 15, 1360,
				"Set of katana & wakizashi that cuts through flesh with the greatest of ease.",
				WT_DUELING, WSZ_MEDIUM)
				.withTag(W_HYBRID)
				.withEffect(IELib.ArmorReduction, 10) as Weapon;
		public const DBFSWO :Weapon = new Weapon(
				"DBFSwo", "D.B.F.Sword", "dual big fucking swords", "a pair of big fucking swords", "slash", 50, 4000,
				"Big Fucking Swords - the best solution for a tiny e-pen complex at this side of the Mareth!  This pair of 2H 2,5 meters long swords requires 150 strength to fully unleash their power.",
				WT_SWORD,WSZ_LARGE,true)
				.withTags(W_LGWRATH)
				.withEffect(IELib.ScaleAttack_Str, 100) as Weapon;
		public const DBFTHSWO:Weapon = new Weapon(
				"DBFTHSwo", "DBFTHSword", "dual big fucking two-handed swords", "a pair of big fucking two-handed swords", "slash", 100, 8000,
				"Big Fucking Two-Handed Swords - if the best solution for a tiny e-pen complex at this side of the Mareth not work take this one! This pair of 2H 4 meters long swords requires 250 strength to fully unleash their power.",
				WT_SWORD, WSZ_MASSIVE, true)
				.withTags(W_LGWRATH)
				.withEffect(IELib.ScaleAttack_StrXL, 100) as Weapon;
		public const DBFWHIP:Weapon = new Weapon(
				"DBFWhip", "D.B.F.Whip", "dual big fucking whips", "a pair of big fucking whips", "whipping", 45, 2880,
				"Big Fucking Whips - the best solution for master tiny e-pen complex at this side of the Mareth!  This pair of 2H 5 meters long whips requires 225 (strength+speed) to fully unleash it power.", WT_WHIP, WSZ_LARGE, true)
				.withBuffs({'teasedmg': 50})
				.withEffect(IELib.ScaleAttack_StrSpe, 225)
				.withTags(W_WHIPPING) as Weapon;
		public const DBSWORD:Weapon = new Weapon(
				"DBSword", "DB.Sword", "dual beautiful swords", "a dual beautiful shining swords", "slash", 17, 1120,
				"Those beautiful swords shines brilliantly in the light, showing the flawless craftsmanship of their blades.  The pommel and guard are heavily decorated in gold and brass.  Some craftsman clearly poured his heart and soul into those blade.",
				WT_SWORD,WSZ_MEDIUM,true)
				.withEffect(IELib.Require_CorBelow, 33)
				.withEffect(IELib.AttackBonus_Cor, -1/3) as Weapon;
		public const DDAGGER:Weapon = new Weapon(
				"DDagger","D.Daggers","dual daggers","a dual daggers","stab",3,240,
				"A pair of small blades.  Preferred weapons for the rogues.",
				WT_DAGGER, WSZ_SMALL, true);
		public const DDAGWHIP:Weapon = new Weapon(
				"DDagWhip","DualDaggerWhip","dual dagger whip","a dual dagger whip","whip-like slash",5,400,
				"Two small blades that is tied to the wrist by an 8 ft. cloth each.  Could be used to attack few enemies at once.",
				WT_DAGGER, WSZ_SMALL, true)
				.withTags(W_WHIPPING) as Weapon;
		public const DEMSCYT:Weapon = new Weapon(
				"DemScyt","D.Scythe","demonic scythe","a demonic scythe","slash",20,4000,
				"A magic catalyst of unknown origin ornamented with a blade mounted on a skull. This magical scythe is both charged with powerful energy and extremely sharp. The letters A.S are engraved in the weapon.",
				WT_SCYTHE,WSZ_LARGE)
				.withBuff('spellpower', +1.0)
				.withTags(W_WHIRLWIND,W_STAFFPART)
				.withEffect(IELib.Bleed, 10)
				.withEffect(IELib.AttackBonus_Cor, 1/20) as Weapon;
		public const DEPRAVA:Weapon = new Weapon(
				"Depravatio", "Depravatio", "Depravatio", "Depravatio, Element of Corruption", "smack", 12, 1920,
				"This staff is made from sacred wood, infused with Marae’s bark. Tentacles run along the staff, and attempt to grope you when they think you’re not watching. The top has an odd zigzag shape, with clear crystals adorning the recesses. The staff seethes with corruption. (-15% spell cost, x2.5 black spellpower / he" +
				"alpower)", WT_STAFF, WSZ_LARGE)
				.withBuff('spellpower',0.6) as Weapon;
		public const DEXCALI:Weapon = new Weapon(
				"DExcalib", "DualExcalibur", "Dual Excalibur", "a Dual Excalibur", "slash", 40, 1600,
				"A legendary dual swords said to have been made by Marae for her champion. Those weapon radiates divine power, purifying its wielder and protecting them from impurity.",
				WT_SWORD, WSZ_MEDIUM, true)
				.withEffect(IELib.Require_CorBelow, 33)
				.withEffect(IELib.AttackBonus_Cor, -1/3)
				.withTag(I_LEGENDARY) as Weapon;
		public const DE_GAXE:Weapon = new Weapon(
				"D.GAXE", "Demon G.Axe", "demonic greataxe", "a demonic greataxe", "cleave", 80, 8000,
				"A greataxe made in black metal and imbued with unholy power. Its shaft is wrapped in bat wings made of darkened bronze. Its deadly blade seems to always aim for the enemy necks.",
				WT_AXE, WSZ_LARGE)
				.withTags(I_LEGENDARY, W_CORRUPT_TYPE)
				.withEffect(IELib.AttackBonus_Cor, 1/5)
				.withEffect(IELib.ScaleAttack_Str, 100) as Weapon;
		public const DKATANA:Weapon = new Weapon(
				"D.Katana","D.Katana","dual katana","a dual katana","keen cut",15,1360,
				"A pair of curved bladed weapons that cuts through flesh with the greatest of ease.",
				WT_DUELING, WSZ_LARGE, true)
				.withEffect(IELib.ArmorReduction, 10) as Weapon;
		public const DNODACHI:Weapon = new Weapon(
				"DNodachi","DualNodachi","dual nodachi","a dual nodachi","keen cut",65,5200,
				"Pair of curved over 3m long bladed weapons that cuts through flesh with the greatest of ease.",
				WT_DUELING, WSZ_MASSIVE, true)
				.withEffect(IELib.ScaleAttack_StrXL, 250) as Weapon;
		public const DORSOUL:Weapon = new Weapon(
				"DorSoul", "DorcSouls", "Dorc Souls", "a Dorc Souls", "slash", 160, 14400,
				"Said to have been the favored weapon of a mad god named Dorc these corrupted swords heals the wielder on swings.",
				WT_SWORD,WSZ_LARGE,true)
				.withTags(W_LGWRATH, I_LEGENDARY)
				.withEffect(IELib.ScaleAttack_Str, 250)
				.withEffect(IELib.AttackBonus_Cor, 1/5) as Weapon;
		public const DRAPIER:Weapon = new Weapon(
				"DRapier", "DRapier", "dragon rapier", "Dragon's Rapier", "slash", 18, 1440,
				"Ancient looking rapier forged in dragon fire. Tales saying that some of the dragon fire could still linger inside of it.  Still blade is piece of an extraordinatry quality and perfect for stabbing.",
				WT_DUELING, WSZ_MEDIUM)
				.withTags(W_RAPIER) as Weapon;
		public const DWARWA :Weapon = new Weapon(
				"DwarWA","DwarvenWaraxe","dwarven waraxe","a dwarven waraxe","cleave",53,2120,
				"A dwarven waraxe has a large, ornate head mounted to a thick handle, making it too large to use in one hand without special training.",
				WT_AXE, WSZ_LARGE)
				.withTags(W_LGWRATH)
				.withEffect(IELib.ScaleAttack_Str, 160) as Weapon;
		public const D_FLAIL:Weapon = new Weapon(
				"D.Flail", "D.Flail", "Demon flail", "a Demon flail", "smash", 20, 8000,
				"A leather-coated steel whip ending in a wide, heavy spiked ball of the same material. It reeks of corruption and its core seems to exude strong aphrodisiac that cover the blunt spikes of the ball, which look quite adapted to fit a whole range of orifices. Only the strongest warriors would be able to use such a large weapon, but it can deal tremendous damage as well as inspire lust.",
				WT_MACE_HAMMER, WSZ_LARGE)
				.withBuffs({'teasedmg': 35})
				.withTag(W_WHIRLWIND)
				.withEffect(IELib.Stun, 10)
				.withEffect(IELib.ScaleAttack_Str, 75)
				.withEffect(IELib.AttackBonus_Cor, 1/20) as Weapon;
		public const D_WHAM_:Weapon = new Weapon(
				"D.WHam", "D.WarHam", "dual huge warhammer", "a dual huge warhammer", "smash", 15, 2400,
				"A pair of huge war-hammers made almost entirely of steel that only the strongest warriors could use.  Getting hit with this might stun the victim.",
				WT_MACE_HAMMER, WSZ_LARGE, true)
				.withTags(W_WHIRLWIND)
				.withEffect(IELib.Stun, 10)
				.withEffect(IELib.ScaleAttack_Str, 80) as Weapon;
		public const D_LANCE:Weapon = new Weapon(
				"D.Lance", "D.Lance", "dual lance", "a dual lances", "piercing stab", 12, 960,
				"A pair of long wooden shafts with a pointed metal heads, used as a weapon by knights and cavalry soldiers in charging.  They would ignore most armors.  Req. 100+ speed to unleash full attack power.",
				WT_SPEAR, WSZ_MEDIUM, true)
				.withEffect(IELib.ArmorPenetration, 100)
				.withEffect(IELib.ScaleAttack_Spe, 100) as Weapon;
		public const DL_AXE_:Weapon = new Weapon(
				"D.L.Axe", "D.L.Axe", "dual large axes", "a pair of axes large enough for a minotaur", "cleaves", 18, 1440,
				"This pair of massive axes once belonged to a minotaur.  It'd be hard for anyone smaller than a giant to wield effectively.  Those axes are double-bladed and deadly-looking.  Requires height of 6'6\".",
				WT_AXE, WSZ_LARGE, true)
				.withEffect(IELib.ScaleAttack_Str, 120) as Weapon;
		public const DL_WHIP:Weapon = new Weapon(
				"DL.Whip","DL.Whip","twin flaming whips","a dual flaming whips once belonging to Lethice","whip-crack", 20, 3200,
				"Those whips once belonged to Lethice who was defeated at your hands. It gives off flames when you crack those whips.",
				WT_WHIP, WSZ_MEDIUM, true)
				.withBuffs({'teasedmg': 50})
				.withTags(W_WHIPPING) as Weapon;
		public const DOCDEST:Weapon = new Weapon(
				"DOCDest", "DOCDestroyer", "Defiled Oni Chieftain Destroyer", "a Defiled Oni Chieftain Destroyer", "smash", 160, 16800,
				"This unrealistically large two handed mace was clearly made for some legendary oni chieftain to wield. Even bigger than the standard oni tetsubo this thing could topple buildings. You likely will need some absurd strength just to lift it.",
				WT_MACE_HAMMER,WSZ_LARGE)
				.withTags(W_WHIRLWIND,W_LGWRATH,W_TETSUBO,I_LEGENDARY)
				.withEffect(IELib.Stun, 15)
				.withEffect(IELib.ScaleAttack_Str, 270)
				.withEffect(IELib.AttackBonus_Cor, 1/2) as Weapon;
		public const DSWORD_:Weapon = new Weapon(
				"DSwords", "DualSwords", "dual swords", "a pair of swords", "slashes", 10, 800,
				"A pair of swords made of the finest steel usefull for fight groups of enemies.",
				WT_SWORD, WSZ_MEDIUM, true);
		public const DSSPEAR:Weapon = new Weapon(
				"DSSpear", "Demon Sn Spear", "demon snake spear", "a demon snake spear", "piercing stab", 60, 4800,
				"A dark steel spear imbued with corruption. Along the handle is a snake-like decoration with ruby eyes, from the mouth of which the spear tip emerges. The spear head is poisoned with an unknown venom.",
				WT_SPEAR, WSZ_MEDIUM)
				.withTags(I_LEGENDARY, W_CORRUPT_TYPE)
				.withEffect(IELib.ArmorPenetration, 100)
				.withEffect(IELib.ScaleAttack_Str, 100)
				.withEffect(IELib.AttackBonus_Cor, 1/5) as Weapon;
		public const E_STAFF:Weapon = new Weapon(
				"E.Staff", "E.Staff", "eldritch staff", "an eldritch staff", "thwack", 10, 800,
				"This eldritch staff once belonged to the Harpy Queen, who was killed after her defeat at your hands.  It fairly sizzles with magical power.",
				WT_STAFF, WSZ_LARGE)
				.withBuff('spellpower', +0.6) as Weapon;
		public const EBNYBLD:Weapon = new Weapon(
				"EBNYBlade","Ebony Destroyer","ebony destroyer","an ebony destroyer","slash",160,7200,
				"This massive weapon, made of the darkest metal seems to seethe with unseen malice. Its desire to destroy and hurt the pure is so strong that it’s wielder must be wary, lest the blade take control of their body to fulfill its gruesome desires.",
				WT_SWORD, WSZ_LARGE)
				.withTags(I_LEGENDARY, W_CORRUPT_TYPE)
				.withEffect(IELib.AttackBonus_Cor, 1/5)
				.withEffect(IELib.ScaleAttack_Str, 250) as Weapon;
		public const ERIBBON:Weapon = new Weapon(
				"ERibbon", "ERibbon", "eldritch ribbon", "an eldritch ribbon", "whip-like slash", 5, 400,
				"A long ribbon made of fine silk that despite its seemingly fragile appearance can deal noticeable damage to several enemies at once.  It is inscribed with arcane runes, allowing it to facilitate spellcasting.",
				WT_RIBBON, WSZ_MEDIUM)
				.withBuff('spellpower', +0.4)
				.withTags(W_WHIPPING) as Weapon;
		public const EXCALIB:Weapon = new Weapon(
				"Excalib", "Excalibur", "Excalibur", "an Excalibur", "slash", 40, 800,
				"A legendary sword said to have been made by Marae for her champion. This weapon radiates divine power, purifying its wielder and protecting them from impurity.",
				WT_SWORD, WSZ_MEDIUM)
				.withTag(I_LEGENDARY)
				.withEffect(IELib.Require_CorBelow, 33)
				.withEffect(IELib.AttackBonus_Cor, -1/3) as Weapon;
		public const FLAIL  :Weapon = findCommonDynamicWeapon("flail");
		public const FLYINGC:Weapon = new Weapon(
				"FlyingC", "FlyingClaw", "Flying Claw", "a flying claw", "rend", 4, 640, "A metal claws that is tied to the wrist by an 8 ft. cloth.  Could be used to attack few enemies at once.", WT_EXOTIC, WSZ_SMALL)
				.withBuffs({
					'psoulskillpower': +0.2
				})
				.withEffect(IELib.Bleed, 10)
				.withTags(W_WHIPPING) as Weapon;
		public const FLYWHIS:Weapon = new Weapon(
				"FlyWhis", "FlyWhisk", "Fly-Whisk", "a Fly-Whisk", "slash", 0, 400,
				"This strange Daoist tool is a small wooden rod, with a prominently displayed ‘tail’ of plant fibers attached to the tip. Simply holding it seems to focus your concentration and empower your Soulforce!",
				WT_EXOTIC, WSZ_MEDIUM)
				.withBuffs({
					'psoulskillpower': +0.2,
					'msoulskillpower': +0.2
				}) as Weapon;
		public const FRTAXE :Weapon = new Weapon(
				"Fr.T.Axe","Fr.T.Axe", "Francisca throwing axe", "a Francisca throwing axe", "cleave", 25, 2000,
				"A foreign axe, made in polished steel and decorated with hunting reliefs in gold and silver. It’s unusually light for its size, so you may be able to manage it with a single hand. Some runes engraved on the handle assure that it will return to you once it has hit your opponent.",
				WT_AXE, WSZ_LARGE)
				.withTags(W_THROWN) as Weapon;
		public const CHAKRAM:Weapon = new Weapon(
				"chakram","chakram", "chakram", "a chakram", "slash", 12, 960,
				"The chakram is a simple, elegant, and highly portable thrown weapon. It is a flat, open-centered metal discus with a sharpened edge.",
				WT_EXOTIC, WSZ_MEDIUM)
				.withTags(W_THROWN) as Weapon;
		public const G_ROD  :Weapon = new Weapon(
				"G. Rod", "G. Rod", "Golemancer Rod", "a Golemancer Rod", "smack", 0, 100,
				"This metal rod seems to empower golems through energy influx.",
				WT_WAND, WSZ_MEDIUM);
		public const G_SHURI:Weapon = new Weapon(
				"G.Shuri","GiantShuriken","Giant Shuriken","a Giant Shuriken","slash",52,2080,
				"An inordinately large shuriken. Capable of being thrown by those strong enough to properly hold it.",
				WT_EXOTIC, WSZ_MASSIVE)
				.withTags(W_THROWN)
				.withEffect(IELib.ScaleAttack_StrXL, 250) as Weapon;
		public const GUANDAO:Weapon = new Weapon(
				"GuanDao", "GuanDao", "Guan Dao", "a Guan Dao", "slash", 75, 3000,
				"Made of a 7 foot long wooden pole, attached on top is an imposing sword blade measuring about 21 inches long, gleaming with a sharp light. You figure this weapon should be effective versus groups of foes.  Req. 300 strength to unleash full attack power.",
				WT_POLEARM,WSZ_MASSIVE)
				.withTag(W_WHIRLWIND)
				.withEffect(IELib.ArmorPenetration, 60)
				.withEffect(IELib.ScaleAttack_StrXL, 300) as Weapon;
		public const G_SPEAR:Weapon = new Weapon(
				"G.Spear", "G.Spear", "Guard's Spear", "a guard's spear", "thrust", 16,450,
				"A very sturdy and well-made spear\n",
				WT_SPEAR, WSZ_MEDIUM)
				.withEffect(IELib.ArmorPenetration, 45) as Weapon;
		public const H_GAUNT:Weapon = new Weapon(
				"H.Gaunt", "H.Gaunt", "hooked gauntlets", "a set of hooked gauntlets", "clawing punch", 0, 400,
				"These metal gauntlets are covered in nasty looking hooks that are sure to tear at your foes flesh and cause them harm.",
				WT_GAUNTLET, WSZ_MEDIUM)
				.withEffect(IELib.Bleed, 25) as Weapon;
		public const HALBERD:Weapon = new Weapon(
				"Halberd", "Halberd", "halberd", "a halberd", "slash", 30, 1200,
				"This imposing cross between a spear and an axe features a 5 foot solid steel pole with two crescent-shaped blades on each end of the pole, with a prominent spear tip.  The tool feels heavy enough to crush armor.  Req. 100 strength to unleash full attack power.",
				WT_POLEARM, WSZ_LARGE)
				.withTags(W_WHIRLWIND)
				.withEffect(IELib.ArmorPenetration, 40)
				.withEffect(IELib.ScaleAttack_Str, 100) as Weapon;
		public const HELRAIS:Weapon = new Weapon(
				"Helrais", "Hellraiser", "Hellraiser", "a Hellraiser", "slash", 80, 14400,
				"An infamous weapon not from this world. Rumors has it that fiends from the void forged it. Many unscruppulous spellcaster used this unholy weapon through the ages.",
				WT_SCYTHE, WSZ_LARGE)
				.withBuff('spellpower', +2)
				.withEffect(IELib.Bleed, 10)
				.withEffect(IELib.ScaleAttack_Str, 100)
				.withEffect(IELib.AttackBonus_Cor, 0.1)
				.withTags(W_STAFFPART, W_WHIRLWIND, I_LEGENDARY) as Weapon;
		public const HNTCANE:Weapon = new HuntsmansCane();
		public const HSWORDS:Weapon = new Weapon(
				"HSwords", "HookSwords", "hook swords", "a pair of hook swords", "slashes", 20, 1600,
				"Dual swords with wrist guards and an outwards-facing \"hook\" on the sword tip, useful for parrying and disarming opponents.",
				WT_SWORD, WSZ_MEDIUM, true)
				.withPerk(PerkLib.DexterousSwordsmanship) as Weapon;
		public const JRAPIER:Weapon = new Weapon(
				"JRapier", "JRapier", "jeweled rapier", "a jeweled rapier", "slash", 13, 1040,
				"This jeweled rapier is ancient but untarnished.  The hilt is wonderfully made, and fits your hand like a tailored glove.  The blade is shiny and perfectly designed for stabbing.",
				WT_DUELING, WSZ_MEDIUM)
				.withEffect(IELib.ArmorPenetration, 100)
				.withTags(W_RAPIER) as Weapon;
		public const JUDGE_S:Weapon = new Weapon(
				"Judge S", "JudgeStaff", "Judge staff", "a Judge staff", "smack", 10, 1600,
				"An ornamental staff favored by the desert anubi. A remnant of the god of death fate, these staves allowed their wielders to judge the weight of a soul or so legend says. Greatly empower soul skills but also improve spells.",
				WT_STAFF, WSZ_LARGE)
				.withBuffs({
					'spellpower': +0.2,
					'msoulskillpower': +0.8
				}) as Weapon;
		public const KAMA   :Weapon = new Weapon(
				"Kama","Kama", "kama", "a kama", "slash", 4,320,
				"The kama is a simple and elegant hand scythe weapon. Preferred weapon for the ninja fans.",
				WT_SCYTHE, WSZ_SMALL)
				.withEffect(IELib.Bleed, 10) as Weapon;
		public const KAMAWHIP:Weapon = new Weapon(
				"KamaWhip","KamaWhip","kama whip","a kama whip","whip-like slash",3,240,
				"A small kama-like weapon with two scythe blades that is tied to the wrist by an 8 ft. cloth.  Could be used to attack few enemies at once.",
				WT_SCYTHE, WSZ_SMALL)
				.withBuffs({'teasedmg': 30})
				.withTags(W_WHIPPING, W_THROWN) as Weapon;
		public const KARMTOU:Weapon = new Weapon(
				"KarmTou", "KarmicTouch", "karmic gloves", "a pair of karmic gloves", "punch", 0, 400,
				"A pair of gauntlets, ordinary at first glance save by its immaculate appearance in shining metal and snow-white cloth.Their touch brings waste into the wicked flesh, punishing them in the form of blows more painful then should be.",
				WT_GAUNTLET, WSZ_MEDIUM)
				.withBuffs({ 'psoulskillpower': +1.5 })
				.withTags(I_LEGENDARY, W_PURE_TYPE)
				.withEffect(IELib.Stun, 50) as Weapon;
		public const KATANA :Weapon = findCommonDynamicWeapon("katana");
		public const KIHAAXE:Weapon = new Weapon(
				"KihaAxe","Greataxe","fiery double-bladed axe","a fiery double-bladed axe","fiery cleave",22,880,
				"This large, double-bladed axe matches Kiha's axe. It's constantly flaming.",
				WT_AXE, WSZ_LARGE);
		public const L__AXE :Weapon = new Weapon(
				"L. Axe ","L. Axe","large axe","an axe large enough for a minotaur","cleave",18,720,
				"This massive axe once belonged to a minotaur.  It'd be hard for anyone smaller than a giant to wield effectively.  The axe is double-bladed and deadly-looking.",
				WT_AXE,WSZ_LARGE)
				.withEffect(IELib.ScaleAttack_Str, 60) as Weapon;
		public const L_CLAWS:Weapon = new Weapon(
				"L.Claws","LustyClaws","gauntlet with an aphrodisiac-coated claws","a gauntlet with an aphrodisiac-coated claws","rend",0,200,
				"Those metal gauntlets have tips of the fingers shaped like natural claws.  They seems to have been enchanted to always be covered in a light aphrodisiac to arouse anything cut with it.",
				WT_GAUNTLET, WSZ_MEDIUM)
				.withEffect(IELib.Bleed, 10) as Weapon;
		public const L_DAGGR:Weapon = new Weapon(
				"L.Daggr","L.Daggr","lust-enchanted dagger","an aphrodisiac-coated dagger","stab",3,240,
				"A dagger with a short blade in a wavy pattern.  Its edge seems to have been enchanted to always be covered in a light aphrodisiac to arouse anything cut with it.",
				WT_DAGGER, WSZ_SMALL);
		public const L_HAMMR:Weapon = new Weapon(
				"L.Hammr", "L.Hammr", "large hammer", "Marble's large hammer", "smash", 18, 720,
				"This two-handed warhammer looks pretty devastating.  You took it from Marble after she refused your advances.",
				WT_MACE_HAMMER, WSZ_LARGE)
				.withTags(W_WHIRLWIND)
				.withEffect(IELib.ScaleAttack_Str, 60) as Weapon;
		public const L_STAFF:Weapon = new Weapon(
				"L.Staff", "Lthc. Staff", "lethicite staff", "a lethicite staff", "smack", 14, 1337,
				"This staff is made of a dark material and seems to tingle to the touch.  The top consists of a glowing lethicite orb.  It once belonged to Lethice who was defeated in your hands.",
				WT_STAFF, WSZ_LARGE)
				.withBuff('spellpower', +0.8) as Weapon;
		public const L_WHIP :Weapon = new Weapon(
				"L. Whip","L. Whip","flaming whip","a flaming whip once belonged to Lethice","whip-crack", 20, 1600,
				"This whip once belonged to Lethice who was defeated at your hands. It gives off flames when you crack this whip.",
				WT_WHIP, WSZ_MEDIUM)
				.withBuffs({'teasedmg': 50})
				.withTags(W_WHIPPING) as Weapon;
		public const LANCE  :Weapon = new Weapon(
				"Lance", "Lance", "deadly lance", "a deadly lance", "piercing stab", 12, 480,
				"A long wooden shaft with a pointed metal head, used as a weapon by knights and cavalry soldiers in charging.  This would ignore most armors.  Req. 100+ speed to unleash full attack power.",
				WT_SPEAR, WSZ_MEDIUM)
				.withEffect(IELib.ArmorPenetration, 100)
				.withEffect(IELib.ScaleAttack_Spe, 100) as Weapon;
		public const LHSCYTH:Weapon = new Weapon("LifScyt", "L.Scythe", "lifehunt scythe", "a lifehunt scythe", "slash", 90, 14400,
				"This enchanted scythe is made of a white metal, and its surface is decorated with ruby gemstones and silver engravings depicting dragons. It seems to drink in the opponents blood use it to heal its user’s wounds.",
				WT_SCYTHE, WSZ_LARGE)
				.withBuff('spellpower', +1.0)
				.withTags(W_STAFFPART, W_WHIRLWIND, I_LEGENDARY)
				.withEffect(IELib.ScaleAttack_Str, 100)
				.withEffect(IELib.AttackBonus_Cor, -1/10) as Weapon;
		public const LRAPIER:Weapon = new Weapon(
				"LRapier", "LRapier", "lust rapier", "lust-coated rapier", "slash", 8, 640,
				"A rapier with edge that seems to have been enchanted to always be covered in a light aphrodisiac to arouse anything cut with it.",
				WT_DUELING, WSZ_MEDIUM)
				.withTags(W_RAPIER) as Weapon;
		public const MACE   :Weapon = findCommonDynamicWeapon("mace");
		public const MACGRSW:Weapon = new Weapon(
				"Macgrsw","Mach.greatsword","Machine Greatsword","a Machine Greatsword","slash",19,2720,
				"This greatsword is half invention and half weapon. Instead of a sharp straight blade, the weapon’s sides are a set of metal teeth that constantly move in order to properly saw through flesh and more solid matter, creating grievous wounds. Very good for cutting down trees too.",
				WT_EXOTIC, WSZ_LARGE)
				.withEffect(IELib.Bleed, 100) as Weapon;
		public const MASAMUN:Weapon = new Weapon(
				"masamune","Masamune","masamune katana","a masamune katana","slash",112,8960,
				"This blessed katana is made in shining steel and heavily decorated with silver and blue sapphires. When used by a pure-hearted knight, the divine will within guides each strike, making it much deadlier.",
				WT_DUELING, WSZ_LARGE)
				.withTags(I_LEGENDARY, W_PURE_TYPE)
				.withEffect(IELib.ScaleAttack_Spe, 100)
				.withEffect(IELib.AttackBonus_Cor, -2/5) as Weapon;
		public const MASTGLO:Weapon = new Weapon(
				"MastGlo", "MasterGloves", "Master Gloves", "a Master Gloves", "punch", 0, 400,
				"These gloves belonged to Chi Chi. They seem to naturally strengthen the soulforce techniques of the user.",
				WT_GAUNTLET, WSZ_MEDIUM)
				.withBuffs({
					'psoulskillpower': +0.4
				}) as Weapon;
		public const MCLAWS:Weapon = new Weapon(
				"MClaws", "MoonlightClaws", "moonlight claws", "a pair of moonlight claws", "clawing punch", 25, 4000,
				"This pair of claws is imbued with magic, which shall be unleashed as a wave of moonlight. The magic within this will grant greated boon when charged with magic.",
				WT_GAUNTLET, WSZ_MEDIUM)
				.withEffect(IELib.Bleed, 25)
				.withEffect(IELib.ScaleAttack_Str, 50) as Weapon;
		public const MGSWORD:Weapon = new Weapon(
				"MGsword", "MoonlightGreatsword", "moonlight greatsword", "a moonlight greatsword", "cleaving sword-slash", 25, 3000,
				"This two-handed sword is imbued with his magic, which shall be unleashed as a wave of moonlight. The magic within this will grant greated boon when charged with magic.",
				WT_SWORD, WSZ_LARGE)
				.withEffect(IELib.ScaleAttack_Str, 50) as Weapon;
		public const MOONLIT:Weapon = new Weapon(
				"Moonlit Snow","Moonlit Snow","Moonlit Snow","a Moonlit Snow","slash",115,9200,
				"This blessed katana is made in shining steel and heavily decorated with silver and blue sapphires. When used by a pure-hearted knight, the divine will within guides each strike, making it much deadlier.",
				WT_DUELING, WSZ_MEDIUM)
				.withTags(W_HYBRID, I_LEGENDARY, W_PURE_TYPE)
				.withEffect(IELib.AttackBonus_Cor, -2/5)
				.withEffect(IELib.ScaleAttack_Spe, 100) as Weapon;
		public const N_STAFF:Weapon = new NocturnusStaff();
		public const NRSABER:Weapon = new Weapon(
				"NRSaber","NineRingedSaber","Nine-ringed Saber","a nine-ringed saber","slash",14,1120,
				"This saber, with added nine rings is capable of delivering deep, jagged wounds.",
				WT_SWORD, WSZ_MEDIUM)
				.withEffect(IELib.Bleed, 10) as Weapon;
		public const NTWHIP :Weapon = new Weapon(
				"NTWhip ", "NineTailWhip", "nine tail whip", "a nine tail whip", "whipping", 18, 720,
				"A rope that unravelled into three small ropes, each of which is unravelled again designed to whip your foes into submission.",
				WT_WHIP, WSZ_LARGE)
				.withBuffs({'teasedmg': 40})
				.withTags(W_WHIPPING)
				.withEffect(IELib.ScaleAttack_StrSpe, 100) as Weapon;
		public const NODACHI:Weapon = new Weapon(
				"Nodachi","Nodachi","nodachi","a nodachi","keen cut",65,2600,
				"A curved over 3m long bladed weapon that cuts through flesh with the greatest of ease.",
				WT_DUELING, WSZ_MASSIVE)
				.withEffect(IELib.ScaleAttack_StrXL, 250) as Weapon;
		public const NORTHIP:Weapon = new Weapon("NorthIP","North.I.P.","Northerner ice picks", "a Northerner ice picks", "stabs", 5, 800, "These items are normally used by climbers to move across vertical icy surfaces. While these were not to be originally used as weapons this pair of pickaxes easily pierces through armors and hides.",
				WT_EXOTIC, WSZ_SMALL, true)
				.withEffect(IELib.ArmorPenetration, 100) as Weapon;
		public const NPHBLDE:Weapon = new Weapon(
				"NPHMBlade", "Nephilim Blade", "nephilim blade", "a nephilim blade", "slash", 180, 7200,
				"A long lost sword, made in a shining metal, that once belonged to the demigod Nephilim. This masterfully crafted blade seeks and destroys corruption wherever it might find it, and will periodically cleanse their user body and soul.",
				WT_SWORD, WSZ_LARGE)
				.withTags(I_LEGENDARY, W_LGWRATH, W_PURE_TYPE)
				.withEffect(IELib.AttackBonus_Cor, -1 / 5)
				.withEffect(IELib.ScaleAttack_Str, 250) as Weapon;
		public const OTETSU :Weapon = new Weapon("O.Tetsu", "OniTetsubo", "Oni Tetsubo", "an Oni Tetsubo", "smash", 45, 3600, "This unrealistically large two handed mace was clearly made for Oni warriors to wield. You likely will need some ridiculous strength just to lift it.", WT_MACE_HAMMER, WSZ_LARGE)
				.withTags(W_TETSUBO, W_WHIRLWIND, W_LGWRATH)
				.withEffect(IELib.Stun, 10)
				.withEffect(IELib.ScaleAttack_Str, 180) as Weapon;
		public const PHALLUS:Weapon = new ThePhalluspear();
		public const PHALUSS:Weapon = new ThePhalluspears();
		//public const RCHEEP:Weapon = new ReaperCheep(); TODO: finish!
		public const PIPE   :Weapon = new Weapon(
				"Pipe   ","Pipe","pipe","a pipe","smash",2,80,
				"This is a simple rusted pipe of unknown origins.  It's hefty and could probably be used as an effective bludgeoning tool.",
				WT_MACE_HAMMER, WSZ_MEDIUM);
		public const POCDEST:Weapon = new Weapon(
				"POCDest", "POCDestroyer", "Purified Oni Chieftain Destroyer", "a Purified Oni Chieftain Destroyer", "smash", 210, 16800,
				"This unrealistically large two handed mace was clearly made for some legendary oni chieftain to wield. Even bigger than the standard oni tetsubo this thing could topple buildings. You likely will need some absurd strength just to lift it.",
				WT_MACE_HAMMER, WSZ_LARGE)
				.withEffect(IELib.Stun, 15)
				.withEffect(IELib.AttackBonus_Cor, -1/2)
				.withEffect(IELib.ScaleAttack_Str, 270)
				.withTags(W_TETSUBO, W_WHIRLWIND, W_LGWRATH, ItemConstants.I_LEGENDARY) as Weapon;
		public const PRURUMI:Weapon = new Weapon(
				"PrUrumi ","Pr.Urumi","Prithviraj urumi","a Prithviraj urumi","slash",24,4800,
				"This urumi is a weapon made of four sharp blades of shining silver-blue steel put together so as to appear like a single blade when not in use. Its handle has a motif of elephants on lacquered ivory, decorated with blue sapphires.",
				WT_SWORD, WSZ_LARGE)
				.withEffect(IELib.ScaleAttack_Str, 24) as Weapon;
		public const PSWHIP :Weapon = new Weapon(
				"PSWhip","P.SucWhip","pair of succubi whips","a pair of succubi whips","sexy whipping",10,800,
				"This pair of coiled length of midnight-black leather practically exudes lust.  Though it looks like it could do a lot of damage, the feel of that slick leather impacting flesh is sure to inspire lust.  However, it might slowly warp the mind of wielder.",
				WT_WHIP, WSZ_MEDIUM, true)
				.withBuffs({'teasedmg': 90})
				.withTags(W_WHIPPING) as Weapon;
		public const PTCHFRK:Weapon = new Weapon(
				"PtchFrk","Pitchfork","pitchfork","a pitchfork","stab",10,400,
				"This is a pitchfork.  Intended for farm work but also useful as stabbing weapon.",
				WT_SPEAR, WSZ_MEDIUM);
		public const PWHIP  :Weapon = new Weapon(
				"P.Whip ", "P.Whip", "pair of coiled whips", "a pair of coiled whips", "whip-crack", 5, 400,
				"A pair of coiled length of leather designed to lash your foes into submission.  There's a chance the bondage inclined might enjoy it!",
				WT_WHIP, WSZ_MEDIUM, true)
				.withBuffs({'teasedmg': 30})
				.withTags(W_WHIPPING) as Weapon;
		public const PURITAS:Weapon = new Weapon(
				"Puritas", "Puritas", "Puritas", "Puritas, Element of Purity", "smack", 12, 1920,
				"This staff is made from sacred wood, infused with Marae’s bark. Vines run along the staff, grown out of the wood itself. The top has an odd zigzag shape, with clear crystals adorning the recesses. The staff glows with power, radiating purity. (-15% spell cost, x2.5 white spellpower / healpower)",
				WT_STAFF, WSZ_LARGE)
				.withBuff('spellpower', +0.6) as Weapon;
		public const Q_GUARD:Weapon = new Weapon(
				"Q.Guard", "Q. Guard", "queen's guard rapier", "a queen's guard rapier", "slash", 80, 9600,
				" An elegant rapier made in brass and gold, with the seal of Mareth’s former nobility. The ruby gemstones running among the blade and the intricate engravings in gold identify it as belonging to the old kingdom knighthoods orders.",
				WT_DUELING, WSZ_MEDIUM)
				.withTags(I_LEGENDARY, W_RAPIER)
				.withEffect(IELib.ArmorPenetration, 100)
				.withEffect(IELib.ScaleAttack_Spe, 100)
				.withEffect(IELib.AttackBonus_Cor, -1/10)
				.withEffect(IELib.AttackBonus_Fem, 1/10) as Weapon;
		public const R_STAFF:Weapon = new Weapon(
				"R.Staff", "R. Staff", "ruby staff", "a ruby staff", "smack", 2, 240,
				"This staff is made of very old wood and seems to tingle to the touch.  The top has ruby embedded in it, and the wood is worn smooth from lots of use.  It probably belonged to a wizard at some point and would aid magic use.",
				WT_STAFF, WSZ_LARGE)
				.withBuff('spellpower', +0.2) as Weapon;
		public const RCLAYMO:Weapon = new Weapon(
				"RClaymo", "R.Claymore", "ruby claymore", "a ruby claymore", "cleaving sword-slash", 15, 1200,
				"This two-handed sword is made of crimson metal and richly decorated with rubies and gold engravings. The magic within this crimson blade will flare up with magical flames when charged with magic.",
				WT_SWORD, WSZ_LARGE)
				.withEffect(IELib.ScaleAttack_Str, 40) as Weapon;
		public const RDAGGER:Weapon = new Weapon(
				"RDagger","R.Dagger","ruby dagger","a ruby dagger","stab",3,240,
				"This dagger is made of crimson metal and richly decorated with rubies and gold engravings. The magic within this crimson blade will flare up with magical flames when charged with magic.",
				WT_DAGGER, WSZ_SMALL);
		public const RIBBON :Weapon = new Weapon(
				"Ribbon ","Ribbon","long ribbon","a long ribbon","whip-like slash",5,200,
				"A long ribbon made of fine silk that despite it seemly fragile appearance can deal noticable damage to even few enemies at once.  Perfect example of weapon that is more dangerous than it looks.",
				WT_RIBBON, WSZ_MEDIUM)
				.withTags(W_WHIPPING) as Weapon;
		public const RIDINGC:Weapon = new Weapon(
				"RidingC","RidingC","riding crop","a riding crop","whip-crack",5,200,
				"This riding crop appears to be made of black leather, and could be quite a painful (or exciting) weapon.",
				WT_WHIP, WSZ_MEDIUM)
				.withBuffs({'teasedmg': 30}) as Weapon;
		public const RIPPER1:Weapon = new Weapon(
				"Ripper1","Ripper1.0","Ripper 1.0","a Ripper 1.0","slash",24,8260,
				"Similar to the machine Greatsword, this weapon is highly mechanical. Instead of a sharp straight blade, the weapon’s sides are a set of sharp metal teeth that constantly move in order to properly saw through flesh and more solid matter, creating grievous wounds. Very good for cutting down trees too.",
				WT_EXOTIC, WSZ_LARGE)
				.withEffect(IELib.Bleed, 100) as Weapon;
		public const RIPPER2:Weapon = new Weapon(
				"Ripper2","Ripper2.0","Ripper 2.0","a Ripper 2.0","slash",29,17360,
				"Similar to the machine Greatsword, this weapon is highly mechanical. Instead of a sharp straight blade, the weapon’s sides are a set of sharp metal teeth that constantly move in order to properly saw through flesh and more solid matter, creating grievous wounds. The blades movement is so fast it creates heat along the length and thanks to a small system set, the saw is constantly aflame. Aside of cutting fleshy things in half, it is very good for taking down trees.",
				WT_EXOTIC, WSZ_LARGE)
				.withEffect(IELib.Bleed, 100) as Weapon;
		public const RRAPIER:Weapon = new Weapon(
				"RRapier", "RRapier", "vulpine rapier", "Raphael's vulpine rapier", "slash", 8, 640,
				"He's bound it with his red sash around the length like a ribbon, as though he has now gifted it to you.  Perhaps it is his way of congratulating you.",
				WT_DUELING, WSZ_MEDIUM)
				.withTags(W_RAPIER) as Weapon;
		public const RULER:Weapon = new Weapon(
				"Ruler  ", "Ruler", "ruler", "a ruler", "smash", 16, 2560, "The flat, wide rod has a center ridge on one side, flat on the other. The handle consists of a thick tang with a heavy iron bolster on either side.",
				WT_MACE_HAMMER, WSZ_LARGE)
				.withBuffs({
					'psoulskillpower': +0.2
				})
				.withEffect(IELib.Stun, 10) as Weapon;
		public const SWORD :Weapon = findCommonDynamicWeapon("sword");
		public const S_BLADE:Weapon = new Weapon(
				"S.Blade", "S.Blade", "inscribed spellblade", "a spellblade", "slash", 8, 640,
				"Forged not by a swordsmith but a sorceress, this arcane-infused blade amplifies your magic. Unlike the wizard staves it is based on, this weapon also has a sharp edge, a technological innovation which has proven historically useful in battle.",
				WT_SWORD, WSZ_MEDIUM)
				.withBuff('spellpower', +0.5)
				.withTags(W_STAFFPART) as Weapon;
		public const S_GAUNT:Weapon = new Weapon(
				"S.Gaunt","S.Gauntlet","spiked gauntlet","a spiked gauntlet","spiked punch",0,200,
				"This single metal gauntlet has the knuckles tipped with metal spikes.  Though it lacks the damaging potential of other weapons, the sheer pain of its wounds has a chance of stunning your opponent.",
				WT_GAUNTLET, WSZ_MEDIUM)
				.withEffect(IELib.Stun, 10) as Weapon;
		public const S_RULER:Weapon = new Weapon(
				"S.Ruler", "S.Ruler", "Storm Ruler", "a Storm Ruler", "smash", 15, 4800,
				"A greatword with a broken blade, still possessing the residual power of lightning. Also known as the 'Giantslayer', for bringing giants to their knees. Deals increased damage to large enemies.",
				WT_MACE_HAMMER, WSZ_LARGE)
				.withBuffs({
					'psoulskillpower': +0.2
				})
				.withEffect(IELib.Stun, 10)
				.withTags(W_LIGHTNING_TYPE) as Weapon;
		public const S_STAFF:Weapon = new Weapon(
				"S.Staff", "S. Staff", "sapphire staff", "a sapphire staff", "smack", 2, 240,
				"This staff is made of very old wood and seems to tingle to the touch.  The top has sapphire embedded in it, and the wood is worn smooth from lots of use.  It probably belonged to a wizard at some point and would aid magic use.",
				WT_STAFF, WSZ_LARGE)
				.withBuff('spellpower', +0.2) as Weapon;
		public const SCARBLD:Weapon = new ScarredBlade();
		public const SCECOMM:Weapon = new Weapon(
				"SceComm", "SceptreOfCom", "Sceptre of Command", "a Sceptre of Command", "smack", 4, 600,
				"This enchanted scepter empowers the abilities and control of summoners over their minions.",
				WT_WAND, WSZ_MEDIUM);
		public const SCIMITR:Weapon = new Weapon(
				"Scimitr", "Scimitar", "scimitar", "a scimitar", "slash", 15, 600,
				"This curved sword is made for slashing.  No doubt it'll easily cut through flesh.",
				WT_DUELING, WSZ_MEDIUM);
		public const SCLAYMO:Weapon = new Weapon(
				"SClaymo", "S.Claymore", "sapphire claymore", "a sapphire claymore", "cleaving sword-slash", 15, 1200,
				"This two-handed sword is made of azure metal and richly decorated with sapphires and silver engravings. The magic within this azure blade will radiate magical frost when charged with magic.",
				WT_SWORD, WSZ_LARGE)
				.withEffect(IELib.ScaleAttack_Str, 40) as Weapon;
		public const SDAGGER:Weapon = new Weapon(
				"SDagger","S.Dagger","sapphire dagger","a sapphire dagger","stab",3,240,
				"This dagger is made of azure metal and richly decorated with sapphires and silver engravings. The magic within this azure blade will radiate magical frost when charged with magic.",
				WT_DAGGER, WSZ_SMALL);
		public const SESPEAR:Weapon = new Weapon("SeSpear", "Seraph Spear", "seraph spear", "a seraph spear", "piercing stab", 60, 4800,
				"A silvery spear imbued with holy power and decorated with blue sapphire gemstones. Engraved in the handle is an ancient runic spell made to ward evil. This blessed equipment seems to slowly heal its wielder’s wounds.",
				WT_SPEAR, WSZ_MEDIUM)
				.withTags(I_LEGENDARY, W_PURE_TYPE)
				.withEffect(IELib.ArmorPenetration, 100)
				.withEffect(IELib.ScaleAttack_Str, 100)
				.withEffect(IELib.AttackBonus_Cor, -1/10) as Weapon;
		public const SIM_SPR:Weapon = new Weapon(
				"Sim_Spr", "Sim.Spear", "simple spear", "a simple spear", "thrust", 10, 250,
				"A fairly crude-looking spear.",
				WT_SPEAR, WSZ_MEDIUM)
				.withEffect(IELib.ArmorPenetration, 30) as Weapon;
		public const SIM_STF:Weapon = new Weapon(
				"Sim_Stf", "Sim.Staff", "simple staff", "a simple staff", "smack", 11, 75,
				"A simple staff, faint pure energy emanates from it.\n",
				WT_STAFF, WSZ_LARGE)
				.withBuff('spellpower', +0.1) as Weapon;
		public const SKYPIER:Weapon = new Weapon(
				"Skypier", "Skypiercer", "Skypiercer", "a Skypiercer", "piercing stab", 55, 3840,
				"Tales has it that this spear tip is so sharp it is said it could pierce through the sky.  Req. 300+ speed and 100+ strength to unleash full attack power",
				WT_SPEAR, WSZ_LARGE)
				.withTags(W_LGWRATH)
				.withEffect(IELib.ArmorPenetration, 100)
				.withEffect(IELib.ScaleAttack_Str, 100)
				.withEffect(IELib.ScaleAttack_Spe, 300) as Weapon;
		public const SNAKESW:Weapon = new Weapon(
				"SnakeSw", "SnakeSword", "Snake Sword", "a Snake Sword", "whip-slash", 20, 800,
				"This unassuming double-edged sword is comprised of segmented pieces which, when swung, will lash out akin to a whip.",
				WT_SWORD, WSZ_MEDIUM)
				.withTags(W_WHIPPING) as Weapon;
		public const SDRILL :Weapon = new SoulDrill();
		public const SPEAR  :Weapon = new Weapon(
				"Spear", "Spear", "deadly spear", "a deadly spear", "piercing stab", 10, 400,
				"A staff with a sharp blade at the tip designed to pierce through the toughest armor.  This would ignore most armors.  Req. 75+ speed to unleash full attack power.",
				WT_SPEAR, WSZ_MEDIUM)
				.withEffect(IELib.ArmorPenetration, 100)
				.withEffect(IELib.ScaleAttack_Spe, 75) as Weapon;
		public const SUCWHIP:Weapon = new Weapon(
				"SucWhip","SucWhip","succubi whip","a succubi whip","sexy whipping",10,400,
				"This coiled length of midnight-black leather practically exudes lust.  Though it looks like it could do a lot of damage, the feel of that slick leather impacting flesh is sure to inspire lust.  However, it might slowly warp the mind of wielder.",
				WT_WHIP, WSZ_MEDIUM)
				.withBuffs({'teasedmg': 45})
				.withTags(W_WHIPPING) as Weapon;
		public const T_HEART:Weapon = new Weapon(
				"T.Heart", "T.Heart", "Trull Heart", "a Trull Heart", "slash", 180, 14400,
				"This pair of oversized swords is said to have once belonged to a legendary giant. The owner wounds seems to recover when those pure blades are used.", WT_SWORD, WSZ_LARGE, true)
				.withTags(W_LGWRATH, I_LEGENDARY)
				.withEffect(IELib.ScaleAttack_Str, 250)
				.withEffect(IELib.AttackBonus_Cor, -1/5) as Weapon;
		public const T_STAFF:Weapon = new Weapon(
				"T.Staff", "T. Staff", "topaz staff", "a topaz staff", "smack", 2, 240,
				"This staff is made of very old wood and seems to tingle to the touch.  The top has topaz embedded in it, and the wood is worn smooth from lots of use.  It probably belonged to a wizard at some point and would aid magic use.",
				WT_STAFF, WSZ_LARGE)
				.withBuff('spellpower', +0.2) as Weapon;
		public const TB_SCYT:Weapon = new Weapon(
				"TBScyt", "T.B.Scythe", "two bladed scythe", "a two bladed scythe", "slash", 30, 2400,
				"The Two Bladed Scythe resembles a scythe with a long thin blue grip, and two blades at the tip.",
				WT_SCYTHE, WSZ_LARGE)
				.withEffect(IELib.Bleed, 25)
				.withTags(W_WHIRLWIND) as Weapon;
		public const TCLAYMO:Weapon = new Weapon(
				"TClaymo", "T.Claymore", "topaz claymore", "a topaz claymore", "cleaving sword-slash", 15, 1200,
				"This two-handed sword is made of eversteel and richly decorated with yellow topazes and copper engravings. The magic within this shining blade will oversaturate the metal with electricity when charged with magic.",
				WT_SWORD, WSZ_LARGE)
				.withEffect(IELib.ScaleAttack_Str, 40) as Weapon;
		public const TDAGGER:Weapon = new Weapon(
				"TDagger","ThrowDagger","throwing dagger","a throwing dagger","stab",2,160,
				"A small blade that could be thrown. Preferred weapon for the rogues.",
				WT_DAGGER, WSZ_SMALL)
				.withTags(W_THROWN) as Weapon;
		public const TIDAR:Weapon = new Tidarion();
		public const TKNIVES:Weapon = new TaintlessKnives();
		public const TMACGRSW:Weapon = new Weapon(
				"TMacgrsw","T.Mach.greatsword","Twin Machine Greatswords","a Twin Machine Greatswords","slash",19,5440,
				"This twin greatswords are half invention and half weapon. Instead of a sharp straight blade, the weapon’s sides are a set of metal teeth that constantly move in order to properly saw through flesh and more solid matter, creating grievous wounds. Very good for cutting down trees too.",
				WT_EXOTIC, WSZ_LARGE, true)
				.withEffect(IELib.Bleed, 100) as Weapon;
		public const TODAGGER:Weapon = new Weapon(
				"ToDagger","T.Dagger","topaz dagger","a topaz dagger","stab",3,240,
				"This dagger is made of eversteel and richly decorated with yellow topazes and copper engravings. The magic within this shining blade will oversaturate the metal with electricity when charged with magic.",
				WT_DAGGER, WSZ_SMALL);
		public const TRASAXE:Weapon = new Weapon(
				"TraSAxe","Train.S.Axe", "training soul axe", "a training soul axe", "cleave", 1, 80,
				"This axe was specialy forged and enhanted to help novice soul cultivatiors to train their soulforce.  Still if situation calls for it it could be used as a normal weapon.",
				WT_AXE, WSZ_MEDIUM);
		public const TRIDAG :Weapon = new Weapon(
				"TriDag ","TriDagger","tri-dagger","a tri-dagger","stab",4,320,
				"A dagger whose blade is shaped like a perfect equilateral triangle.  It has chance to leave bleeding wounds.",
				WT_DAGGER, WSZ_SMALL)
				.withEffect(IELib.Bleed, 25) as Weapon;
		public const TRIDENT:Weapon = new Weapon(
				"Trident", "Trident", "deadly trident", "a deadly trident", "piercing stab", 12, 480,
				"A very ordinary trident. This weapon has a decent reach and can be used to impale foes. It is capable of piercing armor just as well as any other spear.  Req. 75+ speed to unleash full attack power.",
				WT_SPEAR, WSZ_LARGE)
				.withEffect(IELib.ScaleAttack_Spe, 100) as Weapon;
		public const TRIPPER1:Weapon = new Weapon(
				"TRipper1","T.Ripper1.0","Twin Ripper 1.0","a Twin Ripper 1.0","slash",24,16520,
				"Similar to the machine Greatsword, those weapons are highly mechanical. Instead of a sharp straight blade, the weapon’s sides are a set of sharp metal teeth that constantly move in order to properly saw through flesh and more solid matter, creating grievous wounds. Very good for cutting down trees too.",
				WT_EXOTIC, WSZ_LARGE, true)
				.withEffect(IELib.Bleed, 100) as Weapon;
		public const TRIPPER2:Weapon = new Weapon(
				"TRipper2","T.Ripper2.0","Twin Ripper 2.0","a Twin Ripper 2.0","slash",29,34720,
				"Similar to the machine Greatsword, those weapons are highly mechanical. Instead of a sharp straight blade, the weapon’s sides are a set of sharp metal teeth that constantly move in order to properly saw through flesh and more solid matter, creating grievous wounds. The blades movement is so fast it creates heat along the length and thanks to a small system set, the saws are constantly aflame. Aside of cutting fleshy things in half, it is very good for taking down trees.",
				WT_EXOTIC, WSZ_LARGE, true)
				.withEffect(IELib.Bleed, 100) as Weapon;
		public const TRSTSWO:Weapon = new Weapon(
				"TrStSwo","TruestrikeSword", "Truestrike sword", "a Truestrike sword", "slash", 5, 400,
				"Lia will write desc of it...soon.",
				WT_SWORD, WSZ_MEDIUM);
		public const TACLAYM:Weapon = new Weapon(
				"TAClaym", "T.A.Claymore", "twin amethyst claymores", "a twin amethyst claymores", "cleaving sword-slash", 15, 2400,
				"Those twin two-handed swords are made of obsidian and grotesquely decorated with amethysts and lead engravings. The magic within those murky blades will bleed unnatural darkness when charged with magic.",
				WT_SWORD, WSZ_LARGE, true)
				.withEffect(IELib.ScaleAttack_Str, 40) as Weapon;
		public const TRCLAYM:Weapon = new Weapon(
				"TRClaym", "T.R.Claymore", "twin ruby claymores", "a twin ruby claymores", "cleaving sword-slash", 15, 2400,
				"Those twin two-handed swords are made of crimson metal and richly decorated with rubies and gold engravings. The magic within those crimson blades will flare up with magical flames when charged with magic.",
				WT_SWORD, WSZ_LARGE, true)
				.withEffect(IELib.ScaleAttack_Str, 40) as Weapon;
		public const TSRULER:Weapon = new Weapon(
				"TSRuler", "T.S.Rulers", "Twin Storm Rulers", "a pair of Storm Rulers", "smash", 15, 9600,
				"A pair of greatwords with broken blades, still possessing the residual power of lightning. Also known as the 'Giantslayer', for bringing giants to their knees. Deals increased damage to large enemies.",
				WT_MACE_HAMMER, WSZ_LARGE, true)
				.withBuffs({'psoulskillpower': +0.4})
				.withEffect(IELib.Stun, 10)
				.withTags(W_LIGHTNING_TYPE) as Weapon;
		public const TSCLAYM:Weapon = new Weapon(
				"TSClaym", "T.S.Claymore", "twin sapphire claymores", "a twin sapphire claymores", "cleaving sword-slash", 15, 2400,
				"Those twin two-handed swords are made of azure metal and richly decorated with sapphires and silver engravings. The magic within those azure blades will radiate magical frost when charged with magic.",
				WT_SWORD, WSZ_LARGE, true)
				.withEffect(IELib.ScaleAttack_Str, 40) as Weapon;
		public const TTCLAYM:Weapon = new Weapon(
				"TTClaym", "T.T.Claymore", "twin topaz claymores", "a twin topaz claymores", "cleaving sword-slash", 15, 2400,
				"Those twin two-handed swords are made of eversteel and richly decorated with yellow topazes and copper engravings. The magic within those shining blades will oversaturate the metal with electricity when charged with magic.",
				WT_SWORD, WSZ_LARGE, true)
				.withEffect(IELib.ScaleAttack_Str, 40) as Weapon;
		public const U_STAFF:Weapon = new UnicornStaff();
		public const UDKDEST:Weapon = new Weapon(
				"UDKDest", "UDKDestroyer", "Undefeated King's Destroyer", "an Undefeated King's Destroyer", "smash", 75, 9000,
				"This unrealistically large two handed mace belonged in the past to the king, which claimed to be undefeated. To just lift it you will need some absurd strength and know special technique to wield such type of weapons.",
				WT_MACE_HAMMER, WSZ_MASSIVE)
				.withTags(W_WHIRLWIND, W_LGWRATH)
				.withEffect(IELib.Stun, 20)
				.withEffect(IELib.ScaleAttack_StrXL, 250) as Weapon;
		public const UGATANA:Weapon = findCommonDynamicWeapon("uchigatana");
		public const URTAHLB:Weapon = new Weapon("UrtaHlb","UrtaHlb","halberd","a halberd","slash",50,2000,"Urta's halberd. How did you manage to get this?",WT_POLEARM, WSZ_LARGE)
				.withTags(W_WHIRLWIND) as Weapon;
		public const VBLADE :Weapon = new Weapon(
				"V.Blade","V.Blade", "V.Blade", "a V.Blade", "slash", 28, 2240,
				"A peculiar sword. The letter V is engraved into the blade perhaps its former owner name.",
				WT_SWORD, WSZ_MEDIUM);
		public const VENCLAW:Weapon = new Weapon(
				"VenClaw","Venoclaw","Venoclaw","a Venoclaw","rend",0,400,
				"This set of catclaw gloves was tempered using Etna's own venom and reinforced using some of her tail bone spikes, a proof of her eternal love to you. Its also enchanted to reinforce natural attacks.",
				WT_GAUNTLET, WSZ_MEDIUM)
				.withEffect(IELib.Bleed, 10) as Weapon;
		public const W_STAFF:Weapon = new Weapon(
				"W.Staff", "W. Staff", "wizard's staff", "a wizard's staff", "smack", 3, 240,
				"This staff is made of very old wood and seems to tingle to the touch.  The top has an odd zig-zag shape to it, and the wood is worn smooth from lots of use.  It probably belonged to a wizard at some point and would aid magic use.",
				WT_STAFF, WSZ_LARGE)
				.withBuff('spellpower', +0.4) as Weapon;
		public const WARHAMR:Weapon = new Weapon(
				"Warhamr", "Warhammer", "huge warhammer", "a huge warhammer", "smash", 15, 1200,
				"A huge war-hammer made almost entirely of steel that only the strongest warriors could use.  Getting hit with this might stun the victim.",
				WT_MACE_HAMMER, WSZ_LARGE)
				.withTags(W_WHIRLWIND)
				.withEffect(IELib.Stun, 10)
				.withEffect(IELib.ScaleAttack_Str, 80) as Weapon;
		public const WHIP   :Weapon = new Weapon(
				"Whip   ", "Whip", "coiled whip", "a coiled whip", "whip-crack", 5, 200,
				"A coiled length of leather designed to lash your foes into submission.  There's a chance the bondage inclined might enjoy it!",
				WT_WHIP, WSZ_MEDIUM)
				.withBuffs({'teasedmg': 35})
				.withTags(W_WHIPPING) as Weapon;
		public const WG_GAXE:Weapon = new Weapon(
				"W.GAXE", "Winged G.Axe", "winged greataxe", "a winged greataxe", "cleave", 100, 8000,
				"A greataxe made in untarnished steel and imbued with holy power. Its shaft is wrapped in feathery wings made of brass and gold. This holy artifact was created to execute demonic fiends, always finding their weakest spot.",
				WT_AXE, WSZ_LARGE)
				.withTags(I_LEGENDARY, W_PURE_TYPE)
				.withEffect(IELib.ScaleAttack_Str, 100)
				.withEffect(IELib.AttackBonus_Cor, -1/20) as Weapon;
		public const WDBLADE:Weapon = new Weapon(
				"WDBlade", "WardensBlade", "Warden’s blade", "a Warden’s blade", "slash", 15, 1200,
				"Wrought from alchemy, not the forge, this sword is made from sacred wood and resonates with Yggdrasil’s song.",
				WT_SWORD, WSZ_MEDIUM)
				.withBuffs({
					'psoulskillpower': +0.4
				})
				.withPerk(PerkLib.BladeWarden) as Weapon;
		public const WDSTAFF:Weapon = new Weapon(
				"WDStaff", "WardensStaff", "Warden’s staff", "a Warden’s staff", "smack", 10, 1600,
				"This staff looks ordinary up until the crystal at its tip, which is attached by tendrils grown from the staff’s body. The sacred wood faintly seethes with arcane power, and the light within the crystal pulses to the tempo of Yggdrasil's song.",
				WT_STAFF, WSZ_LARGE)
				.withBuffs({
					'spellpower': +0.6,
					'msoulskillpower': +0.4
				})
				.withPerk(PerkLib.MageWarden) as Weapon;
		public const WGSWORD:Weapon = new Weapon(
				"WGSword", "WardenGSword", "Warden’s greatsword", "a Warden’s greatsword", "slash", 30, 2400, "Wrought from alchemy, not the forge, this sword is made from sacred wood and resonates with Yggdrasil’s song.",
				WT_SWORD, WSZ_LARGE)
				.withBuffs({
					'psoulskillpower': +0.4,
					'msoulskillpower': +0.4
				})
				.withPerk(PerkLib.StrifeWarden)
				.withEffect(IELib.ScaleAttack_Str, 100) as Weapon;
		public const YAMARG :Weapon = new Weapon(
				"YamaRG", "YamaRajaGrasp", "Yama-Raja gloves", "a pair of Yama-Raja gloves", "punch", 0, 1600, "These black gloves are made in black leather and an ebony alloy. Their corrupt touch seeks to destroy the pure and innocent. As such, it will seek the weak points of its victims when striking.", WT_GAUNTLET, WSZ_MEDIUM)
				.withBuffs({ 'psoulskillpower': +1.5 })
				.withTags(I_LEGENDARY, W_CORRUPT_TYPE) as Weapon;
		public const ZWNDER :Weapon = new Weapon(
				"Zwnder ","Zwnder","zweihander","a zweihander","slash",31,2480,
				"A zweihander is a longsword recognizable by its six foot monster of a blade and its wavy edges. The pommel and handle of this one are decorated with a fierce-looking wolf and made of silver with other lupine motifs as ornaments.",
				WT_SWORD, WSZ_LARGE)
				.withEffect(IELib.Stun, 30)
				.withEffect(IELib.ScaleAttack_Str, 105) as Weapon;
		//Spellcasting weapon
		public const S_SWORD:Weapon = new Weapon(
				"S.Sword", "S.Sword", "Sorcerer sword", "a sorcerer sword", "slash", 25, 2000, "This weapon was forged by elven wizards. It is both an excelent catalyst and a deadly blade.", WT_SWORD, WSZ_MEDIUM)
				.withBuff('spellpower', +0.40)
				.withTags(W_STAFFPART) as Weapon;
		public const A_WAND:Weapon = new Weapon(
				"A.Wand", "A.Wand", "Apprentice wand", "an apprentice wand", "smack", 1, 80, "A low quality wand. Light and cheap it is commonly used by young apprentices who have started learning magic. Seeing as beginners tend to cause their catalyst to explode this is the perfect weapon for them.", WT_WAND, WSZ_MEDIUM)
				.withBuff('spellpower', +0.30) as Weapon;
		public const O_WAND:Weapon = new Weapon(
				"O.Wand", "O.Wand", "Old wand", "an old wand", "smack", 1, 500, "An old wand. It seems to be broken or worn out, perhaps it can be repaired by a skilled wizard? It is not very useful in its current state but may be able to boost your spellpower if repaired.", WT_WAND, WSZ_MEDIUM)
				.withBuff('spellpower', +0.10) as Weapon;
		public const R_WAND:Weapon = new Weapon(
				"R.Wand", "R.Wand", "Repaired Old wand", "an old wand repaired by alvina", "smack", 1, 800, "An old wand that has been repaired for you by Alvina. It boosts your spellpower, though not as much as if it were made specifically for you.", WT_WAND, WSZ_MEDIUM)
				.withBuff('spellpower', +0.80) as Weapon;
		public const H_WAND:Weapon = new Weapon(
				"H.Wand", "H.Wand", "hellcat wand", "a hellcat wand", "smack", 1, 500, "A hellcat witch wand. Commonly used by hellcats to deliver their iconic fire magic.", WT_WAND, WSZ_MEDIUM)
				.withBuff('spellpower', +1) as Weapon;
		public const WDAGGER:Weapon = new Weapon(
				"WDagger","W.Dagger","witch dagger","a witch dagger","stab",3,500,"A dagger engraved with magical runes. While not the best catalyst around it is light, discreet and excelent for delivering spells.", WT_DAGGER, WSZ_SMALL)
				.withBuff('spellpower', +0.20)
				.withTags(W_STAFFPART) as Weapon;
		public const SFLUTTE:Weapon = new Weapon(
				"SFlute","S.Flute","Satyr Flute","a Satyr Flute","smack",1,160,"A musical instrument favored by satyr. This flute can draw beautiful desire inspiring notes and even magic in the hands of someone with an affinity for music.", WT_MACE_HAMMER, WSZ_SMALL)
				.withBuff('spellpower', +0.50)
				.withPerk(PerkLib.PerformancePower, 0.5, 0, 0, 0)
				.withTags(W_MUSICINSTR) as Weapon;
		public const PFLUTTE:Weapon = new Weapon(
				"PFlute","P.Flute","Pan Flute","a Pan Flute","smack",1,160,"A musical instrument favored by Pan the satyr lord who guards the edge labyrinth of the twilight grove. It was made out from the wood of a tentacle tree. Pan was considered a paragon amongst his people, his fabled music able to plunge his target into lewd waking dreams or horrifying nightmares.", WT_MACE_HAMMER, WSZ_SMALL)
				.withBuff('spellpower', +0.50)
				.withPerk(PerkLib.PerformancePower, 1, 0, 0, 0)
				.withTags(W_MUSICINSTR) as Weapon;
		public const HELLCAL:Weapon = new Weapon(
				"Hellcaller","Hellcaller","Hellcaller","a Hellcaller","smack",1,640,"Pan flute further infused with the power of corruption. Its depraved notes invite the listener to act of wanton debauchery or self destruction. This is an instrument of ruin not of creation.", WT_MACE_HAMMER, WSZ_SMALL)
				.withBuff('spellpower', +1.50)
				.withPerk(PerkLib.PerformancePower, 1.5, 0, 0, 0)
				.withTags(W_MUSICINSTR, I_LEGENDARY, W_CORRUPT_TYPE) as Weapon;
		public const ELYSIUM:Weapon = new Weapon(
				"Elysium","Elysium","Elysium","a Elysium","smack",1,640,"Pan flute purified and strengthened by holy magic. The allure of good and beauty of pure innocent love can be transmitted through its notes granting a glimpse of the designs of creation to its listeners.", WT_MACE_HAMMER, WSZ_SMALL)
				.withBuff('spellpower', +1.50)
				.withPerk(PerkLib.PerformancePower, 1.5, 0, 0, 0)
				.withTags(W_MUSICINSTR, I_LEGENDARY, W_PURE_TYPE) as Weapon;
		public const OCCULUS:Weapon = new Occulus();
		public const ECLIPSE:Weapon = new Eclipse();
		public const NEXUS:Weapon = new Nexus(); //We may need to add a special event or forge for this item
		public const NECROWA:Weapon = new NecroWand();
		
		//===================//
		// Single/Dual pairs //
		//===================//
		
		public const SingleDualPairList:/*Array*/Array = [
			[KAMA, D_KAMA],
			[DAGGER, DDAGGER],
			[ANGSTD1, ANGSTD],
			[DAGWHIP, DDAGWHIP],
			[BFSWORD, DBFSWO],
			[BFTHSWORD, DBFTHSWO],
			[BFWHIP, DBFWHIP],
			[NODACHI, DNODACHI],
			[WHIP, PWHIP],
			[WARHAMR, D_WHAM_],
			[SUCWHIP, PSWHIP],
			[KATANA, DKATANA],
			[L__AXE, DL_AXE_],
			[MACGRSW, TMACGRSW],
			[RIPPER1, TRIPPER1],
			[RIPPER2, TRIPPER2],
			[ACLAYMO, TACLAYM],
			[RCLAYMO, TRCLAYM],
			[SCLAYMO, TSCLAYM],
			[TCLAYMO, TTCLAYM],
			[S_RULER, TSRULER],
			[PHALLUS, PHALUSS],
			[L_WHIP, DL_WHIP],
			[B_SWORD, DBSWORD],
			[EXCALIB, DEXCALI]
		]
	}
}
