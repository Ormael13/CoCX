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
import classes.BodyParts.Skin;
import classes.BodyParts.Tail;
import classes.BodyParts.Tongue;
import classes.BodyParts.Wings;
import classes.CoC;
import classes.CockTypesEnum;
import classes.GlobalFlags.kFLAGS;
import classes.Items.Dynamic.DynamicArmor;
import classes.Items.Dynamic.DynamicWeapon;
import classes.Items.Dynamic.DynamicShield;
import classes.PerkLib;
import classes.Player;
import classes.StatusEffects;
import classes.VaginaClass;
import classes.lists.BreastCup;
import classes.lists.Gender;

import coc.view.*;
import coc.xlogic.ExecContext;

public class CharViewContext extends ExecContext {
		private var charview:CharView;

		public function CharViewContext(charview:CharView, character:*) {
			var player:Player = character as Player;
			var game:CoC = CoC.instance;
			var weaponSubtype:String = (player.weapon is DynamicWeapon) ? (player.weapon as DynamicWeapon).subtypeId : "";
			var armorSubtype:String = (player.armor is DynamicArmor) ? (player.armor as DynamicArmor).subtypeId : "";
			var shieldSubtype:String = (player.shield is DynamicShield) ? (player.shield as DynamicShield).subtypeId : "";

			function showLegClothing():Boolean {
				return !game.flags[kFLAGS.CHARVIEW_ARMOR_HIDDEN] && player.humanForm() || ([LowerBody.GAZER, LowerBody.YETI, LowerBody.KIRIN, LowerBody.HOOFED, LowerBody.CLOVEN_HOOFED, LowerBody.HARPY, LowerBody.JABBERWOCKY, LowerBody.BUNNY, LowerBody.GOO, LowerBody.NAGA, LowerBody.HYDRA, LowerBody.DRIDER, LowerBody.ATLACH_NACHA, LowerBody.HINEZUMI, LowerBody.MELKIE, LowerBody.CENTIPEDE, LowerBody.SCYLLA, LowerBody.KRAKEN, LowerBody.CANCER, LowerBody.GHOST_2, LowerBody.WERESHARK].indexOf(player.lowerBody) == -1 && player.legCount == 2 && !player.isStancing());
			}
			function showPanty():Boolean {
				return !game.flags[kFLAGS.CHARVIEW_ARMOR_HIDDEN] && player.humanForm() || ([LowerBody.GAZER, LowerBody.GOO, LowerBody.NAGA, LowerBody.HYDRA, LowerBody.DRIDER, LowerBody.ATLACH_NACHA, LowerBody.HINEZUMI, LowerBody.MELKIE, LowerBody.CENTIPEDE, LowerBody.SCYLLA, LowerBody.KRAKEN, LowerBody.CANCER, LowerBody.GHOST_2, LowerBody.WERESHARK].indexOf(player.lowerBody) == -1 && player.legCount == 2 && !player.isStancing());
			}

			super([
				{}, // local variables
				character,
				{
					IsEarthElemental: player.perkv1(PerkLib.ElementalBody) == 2,
					IsFireElemental: player.perkv1(PerkLib.ElementalBody) == 3,
					IsWaterElemental: player.perkv1(PerkLib.ElementalBody) == 4,
					IsWindElemental: player.perkv1(PerkLib.ElementalBody) == 1,
					CaveWyrmPussy: player.vaginaType() == VaginaClass.CAVE_WYRM || player.vaginaType() == VaginaClass.RAIJU,
					CaveWyrmNipples: player.hasStatusEffect(StatusEffects.GlowingNipples),
					MindBreakerPussy: player.vaginaType() == VaginaClass.MINDBREAKER,
					CancerCrabStance: player.hasStatusEffect(StatusEffects.CancerCrabStance),
					SlimeCore: player.hasPerk(PerkLib.SlimeCore),
					DarkSlimeCore: player.hasPerk(PerkLib.DarkSlimeCore),
					AzazelPhylactery: player.hasPerk(PerkLib.InnerPhylactery),
					showClothing: !game.flags[kFLAGS.CHARVIEW_ARMOR_HIDDEN] && player.humanForm() || ([Arms.GAZER, Arms.DISPLACER].indexOf(player.arms.type) == -1 && !player.isAlraune() && !player.isSitStancing() && !player.isGargoyleStancing()),
					showArmClothing: !game.flags[kFLAGS.CHARVIEW_ARMOR_HIDDEN] && player.humanForm() || ([Arms.GAZER, Arms.DISPLACER, Arms.GARGOYLE, Arms.GARGOYLE_2, Arms.YETI, Arms.HINEZUMI, Arms.FROSTWYRM, Arms.JABBERWOCKY].indexOf(player.arms.type) == -1 && !player.hasStatusEffect(StatusEffects.CancerCrabStance) && !player.isStancing()),
					showLegClothing: showLegClothing(),
					showPanty: showPanty(),
					PlayerHasViewableOutfit: !game.flags[kFLAGS.CHARVIEW_ARMOR_HIDDEN] && player.isWearingArmor(),
					PlayerHasBreastViewOutfit: !game.flags[kFLAGS.CHARVIEW_ARMOR_HIDDEN] && player.armor == game.armors.CGUNSLI || player.armor == game.armors.GTECHC_,
					PlayerHasABra: !game.flags[kFLAGS.CHARVIEW_ARMOR_HIDDEN] && player.isWearingBra(),
					PlayerIsStancing: player.isStancing(),
					PlayerIsFeralStancing: player.isFeralStancing(),
					PlayerIsSitStancing: player.isSitStancing(),
					PlayerIsInHumanForm: player.humanForm(),
					playerHasWeaponBannedArms: [Arms.GAZER, Arms.YETI, Arms.DISPLACER, Arms.FROSTWYRM, Arms.CANCER].indexOf(player.arms.type) == -1 && !player.isStancing(),
					playerHasWeaponWings: [Wings.VAMPIRE].indexOf(player.wings.type) == -1,
					playerHasLargeLowerBody: player.isTaur() || [LowerBody.DRIDER, LowerBody.ATLACH_NACHA, LowerBody.MELKIE, LowerBody.CENTIPEDE, LowerBody.SCYLLA, LowerBody.KRAKEN, LowerBody.CANCER, LowerBody.WERESHARK].indexOf(player.lowerBody) != -1,
					playerHasWeirdLowerBody: player.isTaur() || [LowerBody.DRIDER, LowerBody.ATLACH_NACHA, LowerBody.HYDRA, LowerBody.NAGA, LowerBody.MELKIE, LowerBody.CENTIPEDE, LowerBody.SCYLLA, LowerBody.KRAKEN, LowerBody.WERESHARK].indexOf(player.lowerBody) != -1,
					showDickDrippies: player.lust >= 0.8 * player.maxLust() && (player.lowerGarment.isNothing || !showPanty()) && (player.armor.isNothing || !showLegClothing()),

					//Detect Weapon Skins
					PlayerHasAWeapon: player.isDaggerTypeWeapon() || player.isWandTypeWeapon() || player.isStaffTypeWeapon() || player.isSwordTypeWeapon() || player.isAxeTypeWeapon() || player.isMaceHammerTypeWeapon() || player.isSpearTypeWeapon() || player.isDuelingTypeWeapon(),

					PlayerHasAStaff: player.isStaffTypeWeapon(),
					PlayerHasAStaffHoly: player.weapon == game.weapons.U_STAFF,
					PlayerHasAStaffUnholy: player.weapon == game.weapons.N_STAFF,

					PlayerHasAWand: player.isWandTypeWeapon(),
					PlayerHasAWandHoly: player.weapon == game.weapons.OCCULUS,
					PlayerHasAWandUnholy: player.weapon == game.weapons.ECLIPSE,

					PlayerHasAPanFlute: player.weapon == game.weapons.SFLUTTE || player.weapon == game.weapons.PFLUTTE || player.weapon == game.weapons.HELLCAL || player.weapon == game.weapons.ELYSIUM,

					PlayerHasASword: player.isSwordTypeWeapon() && player.weapon.isMedium(),
					PlayerHasASwordHoly: player.weapon == game.weapons.EXCALIB,
					PlayerHasASwordUnholy: player.weapon == game.weapons.SCARBLD,
					PlayerHasASwordMoonGS: player.weapon == game.weapons.MGSWORD,
					PlayerHasALargeSword: player.isSwordTypeWeapon() && player.weapon.isLarge(),
					PlayerHasALargeSwordHoly: player.weapon == game.weapons.NPHBLDE || player.weapon == game.weapons.T_HEART,
					PlayerHasALargeSwordUnholy: player.weapon == game.weapons.EBNYBLD || player.weapon == game.weapons.DORSOUL,
					PlayerHasAMassiveSword: player.isSwordTypeWeapon() && player.weapon.isMassive(),
					PlayerHasAMassiveSwordHoly: player.weapon == game.weapons.ARMAGED,
					PlayerHasAMassiveSwordUnholy: player.weapon == game.weapons.CHAOSEA,

					PlayerHasAnAxe: player.isAxeTypeWeapon(),
					PlayerHasAnAxeHoly:player.weapon == game.weapons.WG_GAXE,
					PlayerHasAnAxeUnholy:player.weapon == game.weapons.DE_GAXE || player.weapon == game.weapons.ASTERIUS,

					PlayerHasAHammer: player.isMaceHammerTypeWeapon() && !player.isTetsubo() && player.weapon != game.weapons.SFLUTTE && player.weapon != game.weapons.PFLUTTE && player.weapon != game.weapons.HELLCAL && player.weapon != game.weapons.ELYSIUM,
					//PlayerHasAHammerHoly:player.weapon == game.weapons.POCDEST,
					//PlayerHasAHammerUnholy:player.weapon == game.weapons.DOCDEST,
					PlayerHasATetsu: player.weapon == game.weapons.OTETSU || player.weapon == game.weapons.POCDEST || player.weapon == game.weapons.DOCDEST,
					PlayerHasATetsuHoly:player.weapon == game.weapons.POCDEST,
					PlayerHasATetsuUnholy:player.weapon == game.weapons.DOCDEST,

					PlayerHasASpear: player.isSpearTypeWeapon(), //until polearm have their own sprite they share sprite with spears
					PlayerHasASpearHoly:player.weapon == game.weapons.SESPEAR,
					PlayerHasASpearUnholy:player.weapon == game.weapons.DSSPEAR,
					PlayerHasASpearPhallus: player.weapon == game.weapons.PHALLUS || player.weapon == game.weapons.PHALUSS,

					PlayerHasKatana: weaponSubtype == "katana" || weaponSubtype == "uchigatana" || player.weapon == game.weapons.UGATANA || player.weapon == game.weapons.MOONLIT || player.weapon == game.weapons.C_BLADE || player.weapon == game.weapons.DKATANA,
					PlayerHasKatanaHoly:player.weapon == game.weapons.MOONLIT,
					PlayerHasKatanaUnholy:player.weapon == game.weapons.C_BLADE,

					PlayerHasNodachi: (weaponSubtype == "katana" && weaponSubtype != "uchigatana") || player.weapon == game.weapons.NODACHI  || player.weapon == game.weapons.DNODACHI || player.weapon == game.weapons.BLETTER  || player.weapon == game.weapons.KATANA || player.weapon == game.weapons.MASAMUN,
					PlayerHasNodachiHoly:player.weapon == game.weapons.MASAMUN,
					PlayerHasNodachiUnholy:player.weapon == game.weapons.BLETTER,

					PlayerHasDaisho: player.weapon == game.weapons.DAISHO,

					PlayerHasRapier: player.weapon == game.weapons.B_WIDOW || player.weapon == game.weapons.DRAPIER || player.weapon == game.weapons.JRAPIER || player.weapon == game.weapons.Q_GUARD || player.weapon == game.weapons.RRAPIER || player.weapon == game.weapons.LRAPIER,
					PlayerHasRapierHoly:player.weapon == game.weapons.Q_GUARD,
					PlayerHasRapierUnholy:player.weapon == game.weapons.B_WIDOW,

					PlayerHasDagger: player.isDaggerTypeWeapon() && player.weapon != game.weapons.AETHERD && player.shield != game.shields.AETHERS,
					//PlayerHasDaggerHoly:player.weapon == game.weapons.Q_GUARD,
					//PlayerHasDaggerUnholy:player.weapon == game.weapons.B_WIDOW,

					PlayerHasAScythe: player.isScytheTypeWeapon() || player.weapon == game.weapons.DEMSCYT || player.weapon == game.weapons.KAMA || player.weapon == game.weapons.KAMAWHIP || player.weapon == game.weapons.D_KAMA,
					PlayerHasAScytheHoly:player.weapon == game.weapons.LHSCYTH,
					PlayerHasAScytheUnholy: player.weapon == game.weapons.ATWINSCY || player.weapon == game.weapons.HELRAIS,

					PlayerHasADaggerTwin: player.hasAetherTwinsTierWeapon(),
					PlayerHasAShieldTwin: player.hasAetherTwinsTierLeftShield(),
					PlayerHasAnOffhandDaggerTwin: player.hasAetherTwinsTierLeftDagger(),

					PlayerHasAShield: player.shieldName != "nothing" && player.shield != game.shields.AETHERS && player.shield != game.shields.BATTNET && player.shield != game.shields.MABRACE && player.shield != game.shields.SPI_FOC && player.shield != game.shields.Y_U_PAN,
					PlayerDualWield: player.shieldName != "nothing" && player.shield != game.shields.AETHERS && player.shield != game.shields.BATTNET && player.shield != game.shields.MABRACE && player.shield != game.shields.SPI_FOC && player.shield != game.shields.Y_U_PAN,
					//PlayerHasAShieldHoly: player.shield == game.shields.SANCTYL,
					//PlayerHasAShieldUnholy: player.shield == game.shields.SANCTYD,
					PlayerHasAShieldSm: player.shield == game.shields.BUCKLER || player.shield == game.shields.TRASBUC || player.shield == game.shields.NECROSH,
					//PlayerHasAShieldSmHoly: player.shield == game.shields.SANCTYL,
					//PlayerHasAShieldSmUnholy: player.shield == game.shields.SANCTYD,
					PlayerHasAShieldLg: player.shield == game.shields.DRGNSHL || player.shield == game.shields.GREATSH || player.shield == game.shields.SANCTYN || player.shield == game.shields.SPIH_SH,
					PlayerHasAShieldLgHoly: player.shield == game.shields.SANCTYL,
					PlayerHasAShieldLgUnholy: player.shield == game.shields.SANCTYD,
					PlayerHasAShieldMs: player.shield == game.shields.SPIM_SH || player.shield == game.shields.TOWERSH,
					//PlayerHasAShieldMsHoly: player.shield == game.shields.SANCTYL,
					//PlayerHasAShieldMsUnholy: player.shield == game.shields.SANCTYD,

					PlayerhasACasterTome: shieldSubtype == "tome" || player.shield == game.shields.NEKONOM,

					PlayerHasABow: player.isBowTypeWeapon(),
					PlayerHasABowHoly:player.weaponRange == game.weaponsrange.ARTEMIS,
					PlayerHasABowUnholy:player.weaponRange == game.weaponsrange.WILDHUN,

					PlayerHasARangedBook:player.weaponRange == game.weaponsrange.E_TOME_ || player.weaponRange == game.weaponsrange.G_E_MAN || player.weaponRange == game.weaponsrange.G_E_MAN || player.weaponRange == game.weaponsrange.I_TOME_ || player.weaponRange == game.weaponsrange.SSKETCH,

					PlayerHasAThrownWeapon: player.isThrownTypeWeapon(),
					PlayerHasAJavelin: player.weaponRange == game.weaponsrange.O_JAVEL || player.weaponRange == game.weaponsrange.TRJAVEL || player.weaponRange == game.weaponsrange.GTHRSPE || player.weaponRange == game.weaponsrange.KSLHARP || player.weaponRange == game.weaponsrange.LEVHARP,
					PlayerHasAJavelinHoly:player.weaponRange == game.weaponsrange.KSLHARP,
					PlayerHasAJavelinUnholy:player.weaponRange == game.weaponsrange.LEVHARP,
					PlayerHasAThrownAxe:player.weaponRange == game.weaponsrange.GTHRAXE,
					PlayerHasLactoBlaster:player.weaponRange == game.weaponsrange.LBLASTR,

					PlayerHasADualWeapon: player.isDualWield(),
					PlayerHasADualMeleeWeapon: player.isDualWieldMelee(),
					PlayerHasADualRangedWeapon: player.isDualWieldRanged(),

					WeaponDisplay: game.flags[kFLAGS.WEAPON_DISPLAY_FLAG],
					BoobDisplay: game.flags[kFLAGS.BOOB_DISPLAY_FLAG],
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
					armStanceNonBannedList: player.armor == game.armors.SCANSC || player.armor == game.armors.ERA || player.armor == game.armors.FMDRESS || player.armor == game.armors.B_QIPAO || player.armor == game.armors.G_QIPAO || player.armor == game.armors.P_QIPAO || player.armor == game.armors.R_QIPAO || player.armor == game.armors.BERA,
					sleevelessList: player.armor == game.armors.B_QIPAO || player.armor == game.armors.G_QIPAO || player.armor == game.armors.P_QIPAO || player.armor == game.armors.R_QIPAO || player.armor == game.armors.BERA,
					playerWearsAStanceBannedDress: player.armor == game.armors.BLIZZ_K || player.armor == game.armors.SPKIMO || player.armor == game.armors.WKIMONO || player.armor == game.armors.BKIMONO || player.armor == game.armors.RKIMONO || player.armor == game.armors.PKIMONO || player.armor == game.armors.BLKIMONO || player.armor == game.armors.KBDRESS || player.armor == game.armors.GTECHC_ || player.armor == game.armors.IBKIMO || player.armor == game.armors.TCKIMO || player.armor == game.armors.OEKIMO || player.armor == game.armors.OTKIMO,
					playerWearsAStanceBannedArmor: armorSubtype == "fullplate" || player.armor == game.armors.CTPALAD || player.armor == game.armors.CTHPALA || player.armor == game.armors.EWPLTMA || player.armor == game.armors.FULLPLT || player.armor == game.armors.DBARMOR,

					ComfyCLothes: armorSubtype == "clothes" || player.armor == game.armors.C_CLOTH,
					deathPrinceOutfit: player.armor == game.armors.DEATHPO || player.armor == game.armors.DEATHPGA,
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
					centaurPaladinArmor: player.armor == game.armors.CTPALAD || player.armor == game.armors.CTHPALA,
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
					bestialBlademasterArmor: player.armor == game.armors.BESTBLA,
					vladimirRegalia: player.armor == game.armors.VLAR,
					elfVillagerDress: player.armor == game.armors.ELFDRES,
					travelingMerchantOutfit: player.armor == game.armors.TRMOUTF,
					chainMailBikini: player.armor == game.armors.CHBIKNI || player.armor == game.armors.LMARMOR,
					platemail: armorSubtype == "fullplate" || player.armor == game.armors.EWPLTMA || player.armor == game.armors.FULLPLT || player.armor == game.armors.DBARMOR,
					elfClothing: player.armor == game.armors.ERA,
					iceQueenGown: player.armor == game.armors.IQG,
					gooArmor: player.armor == game.armors.GOOARMR,
					franRegalia: player.armor == game.armors.FCLOAK,
					elfWizardDress: player.armor == game.armors.FMDRESS,
					CowGirlOutfit: player.armor == game.armors.CGUNSLI,
					greenAdventurerClothes: player.armor == game.armors.ADVCLTH,
					nurseClothing: player.armor == game.armors.NURSECL,
					SamuraiArmor: armorSubtype == "samurai" || player.armor == game.armors.SAMUARM,
					scalemail: armorSubtype == "scalemail" || player.armor == game.armors.SCALEML,
					chainMail: armorSubtype == "fullchain" || player.armor == game.armors.FULLCHN,

					//viewable bra list
					goblinTechnomancerBra: player.upperGarment == game.undergarments.TECHBRA,
					dragonscaleBikiniBra: player.upperGarment == game.undergarments.DS_BRA,
					comfyBikiniBra: player.upperGarment == game.undergarments.C_BRA,
					cowBra: player.upperGarment == game.undergarments.COW_BRA,
					blackCatBra: player.upperGarment == game.undergarments.BN_TOP,

					//viewable panty list
					goblinTechnomancerPanty: player.lowerGarment == game.undergarments.T_PANTY,
					dragonscaleBikiniPanty: player.lowerGarment == game.undergarments.DSTHONG,
					comfyBikiniPanty: player.lowerGarment == game.undergarments.C_PANTY,
					cowPanty: player.lowerGarment == game.undergarments.COW_PANTY,
					blackCatPanty: player.lowerGarment == game.undergarments.BN_SKIRT,
					brownLoincloth: player.lowerGarment == game.undergarments.C_LOIN || player.lowerGarment == game.undergarments.FURLOIN,
					whiteLoincloth: player.lowerGarment == game.undergarments.F_LOIN_ || player.lowerGarment == game.undergarments.SS_LOIN,

					// Unique misc Accessories
					oniGourd: player.countMiscJewelry(game.miscjewelries.ONI_GOURD) > 0,
					demonTailRing: player.countMiscJewelry(game.miscjewelries.DMAGETO) > 0,

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
					deathPrinceRegalia: player.headJewelry == game.headjewelries.DEATHPR,
					bestialBlademasterAccoutrements: player.headJewelry == game.headjewelries.BESTBLAA,
					skullOrnament: player.headJewelry == game.headjewelries.DMONSKUL,
					yukiHairpin: player.headJewelry == game.headjewelries.SNOWFH,
					cowGirlHat: player.headJewelry == game.headjewelries.COWHAT,
					kabutoMempo: player.headJewelry == game.headjewelries.KABUMEMP,

					// Viewable amulet Accessory lists
					GoldStatAmulet: player.necklace == game.necklaces.NECKINT || player.necklace == game.necklaces.NECKLIB || player.necklace == game.necklaces.NECKSEN ||
							player.necklace == game.necklaces.NECKSPE || player.necklace == game.necklaces.NECKSTR || player.necklace == game.necklaces.NECKTOU ||
							player.necklace == game.necklaces.NECKWIS || player.necklace == game.necklaces.FIRENEC || player.necklace == game.necklaces.ICENECK ||
							player.necklace == game.necklaces.LIGHNEC || player.necklace == game.necklaces.DARKNEC || player.necklace == game.necklaces.POISNEC ||
							player.necklace == game.necklaces.LUSTNEC,
					CowBellAmulet: player.necklace == game.necklaces.COWBELL || player.necklace == game.necklaces.CATBELL
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
	public static const SEA_DRAGON_UNDERBODY:int     = Skin.PATTERN_SEA_DRAGON_UNDERBODY;
	public static const BEE_STRIPES:int             = Skin.PATTERN_BEE_STRIPES;
	public static const TIGER_STRIPES:int           = Skin.PATTERN_TIGER_STRIPES;
	public static const BATTLE_TATTOO:int           = Skin.PATTERN_BATTLE_TATTOO;
	public static const PATTERN_GLYPH_TATTOO:int    = Skin.PATTERN_GLYPH_TATTOO;
	public static const SPOTTED:int                 = Skin.PATTERN_SPOTTED;
	public static const LIGHTNING_SHAPED_TATTOO:int = Skin.PATTERN_LIGHTNING_SHAPED_TATTOO;
	public static const RED_PANDA_UNDERBODY:int     = Skin.PATTERN_RED_PANDA_UNDERBODY;
	public static const SCAR_SHAPED_TATTOO:int      = Skin.PATTERN_SCAR_SHAPED_TATTOO;
	public static const WHITE_BLACK_VEINS:int       = Skin.PATTERN_WHITE_BLACK_VEINS;
}
class UnderBody {

}
