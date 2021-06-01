/**
 * Coded by aimozg on 27.08.2017.
 */
package coc.view.charview {
import classes.BodyParts.Antennae;
import classes.BodyParts.Arms;
import classes.BodyParts.Beard;
import classes.BodyParts.Butt;
import classes.BodyParts.Claws;
import classes.BodyParts.Ears;
import classes.BodyParts.Eyes;
import classes.BodyParts.Face;
import classes.BodyParts.Gills;
import classes.BodyParts.Hair;
import classes.BodyParts.Hips;
import classes.BodyParts.Horns;
import classes.BodyParts.LowerBody;
import classes.BodyParts.Piercing;
import classes.BodyParts.RearBody;
import classes.BodyParts.Tail;
import classes.BodyParts.Tongue;
import classes.BodyParts.Wings;
import classes.CoC;
import classes.GlobalFlags.kFLAGS;
import classes.PerkLib;
import classes.Player;
import classes.StatusEffects;
import classes.CockTypesEnum;
import classes.VaginaClass;
import classes.lists.BreastCup;
import classes.lists.Gender;
import classes.BodyParts.Skin;

import coc.view.*;
import coc.xlogic.ExecContext;

	public class CharViewContext extends ExecContext {
		private var charview:CharView;

		public function CharViewContext(charview:CharView, character:*) {
			var player:Player = character as Player;
			var game:CoC = CoC.instance;
			super([
				{}, // local variables
				character,
				{
					CaveWyrmPussy: player.vaginaType() == VaginaClass.CAVE_WYRM,
					CaveWyrmNipples: player.hasStatusEffect(StatusEffects.GlowingNipples),
					CancerCrabStance: player.hasStatusEffect(StatusEffects.CancerCrabStance),
					SlimeCore: player.hasPerk(PerkLib.SlimeCore),
					DarkSlimeCore: player.hasPerk(PerkLib.DarkSlimeCore),
					showClothing: [Arms.GAZER, Arms.DISPLACER].indexOf(player.arms.type) == -1 && !player.isAlraune() && !player.isSitStancing(),
					showArmClothing: [Arms.GAZER, Arms.DISPLACER, Arms.GARGOYLE, Arms.GARGOYLE_2, Arms.YETI, Arms.HINEZUMI].indexOf(player.arms.type) == -1 && !player.hasStatusEffect(StatusEffects.CancerCrabStance) && !player.isStancing(),
					showLegClothing: [LowerBody.GAZER, LowerBody.YETI, LowerBody.HOOFED, LowerBody.CLOVEN_HOOFED, LowerBody.HARPY, LowerBody.BUNNY, LowerBody.GOO, LowerBody.NAGA, LowerBody.DRIDER, LowerBody.ATLACH_NACHA, LowerBody.HINEZUMI, LowerBody.MELKIE, LowerBody.CENTIPEDE, LowerBody.SCYLLA, LowerBody.KRAKEN, LowerBody.CANCER, LowerBody.GHOST_2].indexOf(player.lowerBody) == -1 && player.legCount == 2 && !player.isStancing(),
					PlayerHasViewableOutfit: player.isWearingArmor(),
					PlayerIsStancing: player.isStancing(),
					PlayerIsFeralStancing: player.isFeralStancing(),
					playerHasWeaponBannedArms: [Arms.GAZER, Arms.YETI, Arms.DISPLACER, Arms.GARGOYLE, Arms.FROSTWYRM, Arms.CANCER].indexOf(player.arms.type) == -1 && !player.isStancing(),
					playerHasWeaponWings: [Wings.VAMPIRE].indexOf(player.wings.type) == -1,
					playerHasLargeLowerBody: player.isTaur() || [LowerBody.DRIDER, LowerBody.ATLACH_NACHA, LowerBody.MELKIE, LowerBody.CENTIPEDE, LowerBody.SCYLLA, LowerBody.KRAKEN, LowerBody.CANCER].indexOf(player.lowerBody) != -1,
					playerHasWeirdLowerBody: player.isTaur() || [LowerBody.DRIDER, LowerBody.ATLACH_NACHA, LowerBody.HYDRA, LowerBody.NAGA, LowerBody.MELKIE, LowerBody.CENTIPEDE, LowerBody.SCYLLA, LowerBody.KRAKEN].indexOf(player.lowerBody) != -1,

					//Detect Weapon Skins
					PlayerHasAWeapon: player.isStaffTypeWeapon() || player.isSwordTypeWeapon() || player.isAxeTypeWeapon() || player.isMaceHammerTypeWeapon() || player.isSpearTypeWeapon() || player.isSpearTypeWeapon() || player.isDuelingTypeWeapon(),

					PlayerHasAStaff: player.isStaffTypeWeapon(),
					PlayerHasAStaffHoly:player.weapon == game.weapons.U_STAFF,
					PlayerHasAStaffUnholy:player.weapon == game.weapons.N_STAFF,

					PlayerHasASword: player.isSwordTypeWeapon(),
					PlayerHasASwordHoly:player.weapon == game.weapons.EXCALIB || game.weapons.NPHBLDE,
					PlayerHasASwordunholy:player.weapon == game.weapons.EBNYBLD,

					PlayerHasAnAxe: player.isAxeTypeWeapon(),
					PlayerHasAnAxeHoly:player.weapon == game.weapons.WG_GAXE,
					PlayerHasAnAxeUnholy:player.weapon == game.weapons.DE_GAXE,

					PlayerHasAHammer: player.isMaceHammerTypeWeapon() && !player.isTetsubo(),
					//PlayerHasAHammerHoly:player.weapon == game.weapons.POCDEST,
					//PlayerHasAHammerUnholy:player.weapon == game.weapons.DOCDEST,
					PlayerHasATetsu: player.weapon == game.weapons.OTETSU,
					PlayerHasATetsuHoly:player.weapon == game.weapons.POCDEST,
					PlayerHasATetsuUnholy:player.weapon == game.weapons.DOCDEST,

					PlayerHasASpear: player.isSpearTypeWeapon(),
					PlayerHasASpearHoly:player.weapon == game.weapons.SESPEAR,
					PlayerHasASpearUnholy:player.weapon == game.weapons.DSSPEAR,

					PlayerHasKatana: player.weapon == game.weapons.UGATANA  || player.weapon == game.weapons.NODACHI  || player.weapon == game.weapons.MOONLIT || player.weapon == game.weapons.C_BLADE || player.weapon == game.weapons.BLETTER  || player.weapon == game.weapons.KATANA || player.weapon == game.weapons.MASAMUN,
					PlayerHasKatanaHoly:player.weapon == game.weapons.MOONLIT || player.weapon == game.weapons.MASAMUN,
					PlayerHasKatanaUnholy:player.weapon == game.weapons.C_BLADE || player.weapon == game.weapons.BLETTER,

					PlayerHasRapier: player.weapon == game.weapons.B_WIDOW || player.weapon == game.weapons.DRAPIER || player.weapon == game.weapons.JRAPIER || player.weapon == game.weapons.Q_GUARD || player.weapon == game.weapons.RRAPIER || player.weapon == game.weapons.LRAPIER,
					PlayerHasRapierHoly:player.weapon == game.weapons.Q_GUARD,
					PlayerHasRapierUnholy:player.weapon == game.weapons.B_WIDOW,

					PlayerHasAShield: player.shieldName != "nothing" && player.shield != game.shields.SPI_FOC,
					PlayerDualWield: player.shieldName != "nothing" && player.shield != game.shields.SPI_FOC,
					PlayerHasSanctuary: player.shield == game.shields.SANCTYL || player.shield == game.shields.SANCTYN || player.shield == game.shields.SANCTYD,
					PlayerHasSanctuaryHoly:player.shield == game.shields.SANCTYL,
					PlayerHasSanctuaryUnholy:player.shield == game.shields.SANCTYD,

					PlayerHasABow: player.isBowTypeWeapon(),
					PlayerHasABowHoly:player.weaponRange == game.weaponsrange.ARTEMIS,
					PlayerHasABowUnholy:player.weaponRange == game.weaponsrange.WILDHUN,

					PlayerHasAThrownWeapon: player.isThrownTypeWeapon(),
					PlayerHasAJavelin: player.weaponRange == game.weaponsrange.TRJAVEL || player.weaponRange == game.weaponsrange.GTHRSPE || player.weaponRange == game.weaponsrange.KSLHARP || player.weaponRange == game.weaponsrange.LEVHARP,
					PlayerHasAJavelinHoly:player.weaponRange == game.weaponsrange.KSLHARP,
					PlayerHasAJavelinUnholy:player.weaponRange == game.weaponsrange.LEVHARP,
					PlayerHasAThrownAxe:player.weaponRange == game.weaponsrange.GTHRAXE,
					PlayerHasLactoBlaster:player.weaponRange == game.weaponsrange.LBLASTR,

					PlayerHasADualWeapon: player.isDualWield(),

					WeaponDisplay: game.flags[kFLAGS.WEAPON_DISPLAY_FLAG],
					FireBuff: player.hasStatusEffect(StatusEffects.FlameBlade),

					Antennae: Antennae,
					Arms: Arms,
					Beard: Beard,
					BreastCup: BreastCup,
					Butt: Butt,
					Claws: Claws,
					CockTypesEnum: CockTypesEnum,
					Ears: Ears,
					Eyes: Eyes,
					Face: Face,
					Gender: Gender,
					Gills: Gills,
					Hair: Hair,
					Hips: Hips,
					Horns: Horns,
					LowerBody: LowerBody,
					Neck: Neck,
					Pattern: Pattern,
					Piercing: Piercing,
					RearBody: RearBody,
					Skin: Skin,
					Tail: Tail,
					Tongue: Tongue,
					UnderBody: UnderBody,
					Wings: Wings,
					StatusEffects: StatusEffects,

					// Viewable Clothing lists
					armStanceNonBannedList: player.armor == game.armors.SCANSC || player.armor == game.armors.B_QIPAO || player.armor == game.armors.G_QIPAO || player.armor == game.armors.P_QIPAO || player.armor == game.armors.R_QIPAO || player.armor == game.armors.ERA || player.armor == game.armors.BERA,
					playerWearsAStanceBannedDress: player.armor == game.armors.BLIZZ_K || player.armor == game.armors.SPKIMO || player.armor == game.armors.WKIMONO || player.armor == game.armors.BKIMONO || player.armor == game.armors.RKIMONO || player.armor == game.armors.PKIMONO || player.armor == game.armors.BLKIMONO || player.armor == game.armors.KBDRESS || player.armor == game.armors.GTECHC_ || player.armor == game.armors.IBKIMO || player.armor == game.armors.TCKIMO || player.armor == game.armors.OEKIMO || player.armor == game.armors.OTKIMO,
					playerWearsAStanceBannedArmor: player.armor == game.armors.CTPALAD || player.armor == game.armors.EWPLTMA || player.armor == game.armors.FULLPLT || player.armor == game.armors.DBARMOR,

					ComfyCLothes: player.armor == game.armors.C_CLOTH,
					MageRobe: player.armor == game.armors.M_ROBES || player.armor == game.armors.I_ROBES || player.armor == game.armors.I_CORST || player.armor == game.armors.EWROBE_ || player.armor == game.armors.A_ROBE_,
					yukiDress: player.armor == game.armors.BLIZZ_K,
					sakuraPetalKimono: player.armor == game.armors.SPKIMO,
					OniLegendaryKimono: player.armor == game.armors.OEKIMO || player.armor == game.armors.OTKIMO,
					whiteKimono: player.armor == game.armors.WKIMONO,
					blueKimono: player.armor == game.armors.BKIMONO,
					redKimono: player.armor == game.armors.RKIMONO,
					purpleKimono: player.armor == game.armors.PKIMONO,
					blackKimono: player.armor == game.armors.BLKIMONO,
					legendKimono: player.armor == game.armors.IBKIMO || player.armor == game.armors.TCKIMO,
					blueQipao: player.armor == game.armors.B_QIPAO,
					greenQipao: player.armor == game.armors.G_QIPAO,
					purpleQipao: player.armor == game.armors.P_QIPAO,
					redQipao: player.armor == game.armors.R_QIPAO,
					centaurPaladinArmor: player.armor == game.armors.CTPALAD,
					centaurBlackGuardArmor: player.armor == game.armors.CTBGUAR,
					goblinTechnomancerClothe: player.armor == game.armors.GTECHC_,
					sexyAquamarineBikini: player.armor == game.armors.SAQBIKNI,
					sexyBlackBikini: player.armor == game.armors.SBABIKNI,
					sexyBlueBikini: player.armor == game.armors.SBUBIKNI,
					sexyGreenBikini: player.armor == game.armors.SGRBIKNI,
					sexyPinkBikini: player.armor == game.armors.SPIBIKNI,
					sexyRedBikini: player.armor == game.armors.SREBIKNI,
					sexyWhiteBikini: player.armor == game.armors.SWHBIKNI,
					sexyYellowBikini: player.armor == game.armors.SYEBIKNI,
					krakenBlackDress: player.armor == game.armors.KBDRESS,
					walpurgisIzaliaCloak: player.armor == game.armors.WALIC,
					scandalousSuccubusClothing: player.armor == game.armors.SCANSC,
					fairyQueenRegalia: player.armor == game.armors.FQR,
					berserkerArmor: player.armor == game.armors.BERA,
					vladimirRegalia: player.armor == game.armors.VLAR,
					travelingMerchantOutfit: player.armor == game.armors.TRMOUTF,
					chainMailBikini: player.armor == game.armors.CHBIKNI || player.armor == game.armors.LMARMOR,
					platemail: player.armor == game.armors.EWPLTMA || player.armor == game.armors.FULLPLT || player.armor == game.armors.DBARMOR,
					elfClothing: player.armor == game.armors.ERA,
					iceQueenGown: player.armor == game.armors.IQG,

					//viewable bra list
					goblinTechnomancerBra: player.upperGarment == game.undergarments.TECHBRA,
					dragonscaleBikiniBra: player.upperGarment == game.undergarments.DS_BRA,
					comfyBikiniBra: player.upperGarment == game.undergarments.C_BRA,

					//viewable panty list
					goblinTechnomancerPanty: player.lowerGarment == game.undergarments.T_PANTY,
					dragonscaleBikiniPanty: player.lowerGarment == game.undergarments.DSTHONG,
					comfyBikiniPanty: player.lowerGarment == game.undergarments.C_PANTY || player.lowerGarment == game.undergarments.C_LOIN,

					// Unique ring Accessories
					oniGourd: player.jewelry == game.jewelries.ONIGOURD || player.jewelry2 == game.jewelries.ONIGOURD || player.jewelry3 == game.jewelries.ONIGOURD || player.jewelry4 == game.jewelries.ONIGOURD,
					demonTailRing: player.jewelry == game.jewelries.DMTO || player.jewelry2 == game.jewelries.DMTO || player.jewelry3 == game.jewelries.DMTO || player.jewelry4 == game.jewelries.DMTO,

					// Viewable neck Accessory lists
					blueScarf: player.necklace == game.necklaces.BWSCARF,
					redScarf: player.necklace == game.necklaces.RWSCARF,
					greenScarf: player.necklace == game.necklaces.GWSCARF,
					purpleScarf: player.necklace == game.necklaces.PWSCARF,
					yellowScarf: player.necklace == game.necklaces.YWSCARF,

					// Viewable head Accessory lists
					foxHairpin: player.headJewelry == game.headjewelries.FOXHAIR,
					goldenNagaHairpin: player.headJewelry == game.headjewelries.GNHAIR,
					machinistGoggles: player.headJewelry == game.headjewelries.MACHGOG || player.headJewelry == game.headjewelries.SATGOG || player.headJewelry == game.headjewelries.SCANGOG,
					sphinxRegalia: player.headJewelry == game.headjewelries.SPHINXAS,
					skullOrnament: player.headJewelry == game.headjewelries.DMONSKUL,
					yukiHairpin: player.headJewelry == game.headjewelries.SNOWFH,

					// Viewable amulet Accessory lists
					GoldStatAmulet: player.necklace == game.necklaces.NECKINT || player.necklace == game.necklaces.NECKLIB || player.necklace == game.necklaces.NECKSEN ||
							player.necklace == game.necklaces.NECKSPE || player.necklace == game.necklaces.NECKSTR || player.necklace == game.necklaces.NECKTOU ||
							player.necklace == game.necklaces.NECKWIS || player.necklace == game.necklaces.FIRENEC || player.necklace == game.necklaces.ICENECK ||
							player.necklace == game.necklaces.LIGHNEC || player.necklace == game.necklaces.DARKNEC || player.necklace == game.necklaces.POISNEC ||
							player.necklace == game.necklaces.LUSTNEC
				}
			]);
			this.charview = charview;
		}

	}
}

import classes.BodyParts.Skin;

// Revamp compatibility layer
class Neck {

}
class Pattern {
	public static const NONE:int                    = Skin.PATTERN_NONE;
	public static const MAGICAL_TATTOO:int          = Skin.PATTERN_MAGICAL_TATTOO;
	public static const ORCA_UNDERBODY:int          = Skin.PATTERN_ORCA_UNDERBODY;
	public static const SEADRAGON_UNDERBODY:int     = Skin.PATTERN_SEADRAGON_UNDERBODY;
	public static const BEE_STRIPES:int             = Skin.PATTERN_BEE_STRIPES;
	public static const TIGER_STRIPES:int           = Skin.PATTERN_TIGER_STRIPES;
	public static const BATTLE_TATTOO:int           = Skin.PATTERN_BATTLE_TATTOO;
	public static const SPOTTED:int                 = Skin.PATTERN_SPOTTED;
	public static const LIGHTNING_SHAPED_TATTOO:int = Skin.PATTERN_LIGHTNING_SHAPED_TATTOO;
	public static const RED_PANDA_UNDERBODY:int     = Skin.PATTERN_RED_PANDA_UNDERBODY;
	public static const SCAR_SHAPED_TATTOO:int      = Skin.PATTERN_SCAR_SHAPED_TATTOO;
	public static const WHITE_BLACK_VEINS:int       = Skin.PATTERN_WHITE_BLACK_VEINS;
}
class UnderBody {

}
