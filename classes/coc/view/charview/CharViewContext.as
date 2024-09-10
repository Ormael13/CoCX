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
import classes.Items.ItemConstants;
import classes.PerkLib;
import classes.Player;
import classes.StatusEffects;
import classes.VaginaClass;
import classes.lists.BreastCup;
import classes.lists.Gender;

import coc.view.*;
import coc.xlogic.ExecContext;

public class CharViewContext extends ExecContext {
		public var charview:CharView;

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
			function meleeWeaponSprite():String {
				// Variants
				if (player.weapon == game.weapons.U_STAFF) return 'staff_holy';
				if (player.weapon == game.weapons.N_STAFF) return 'staff_unholy';
				if (player.weapon == game.weapons.OCCULUS) return 'wand_holy';
				if (player.weapon == game.weapons.ECLIPSE) return 'wand_unholy';
				if (player.weapon == game.weapons.SFLUTTE || player.weapon == game.weapons.PFLUTTE || player.weapon == game.weapons.HELLCAL || player.weapon == game.weapons.ELYSIUM) return 'pan_flute';
				if (player.weapon == game.weapons.EXCALIB) return 'sword_holy';
				if (player.weapon == game.weapons.SCARBLD) return 'sword_unholy';
				if (player.weapon == game.weapons.MGSWORD) return 'sword_moongs';
				if (player.weapon == game.weapons.NPHBLDE || player.weapon == game.weapons.T_HEART) return 'large_sword_holy';
				if (player.weapon == game.weapons.EBNYBLD || player.weapon == game.weapons.DORSOUL) return 'large_sword_unholy';
				if (player.weapon == game.weapons.ARMAGED) return 'massive_sword_holy';
				if (player.weapon == game.weapons.CHAOSEA) return 'massive_sword_unholy';
				if (player.weapon == game.weapons.WG_GAXE || player.weapon == game.weapons.GGRAVEA) return 'axe_holy';
				if (player.weapon == game.weapons.DE_GAXE || player.weapon == game.weapons.ASTERIUS) return 'axe_unholy';
				// if (player.weapon == ???) return 'hammer_holy';
				if (player.weapon == game.weapons.VGRAVEH) return 'hammer_unholy';
				if (player.weapon == game.weapons.POCDEST) return 'tetsu_holy';
				if (player.weapon == game.weapons.DOCDEST) return 'tetsu_unholy';
				if (player.weapon == game.weapons.SESPEAR) return 'spear_holy';
				if (player.weapon == game.weapons.DSSPEAR) return 'spear_unholy';
				if (player.weapon == game.weapons.PHALLUS || player.weapon == game.weapons.PHALUSS) return 'spear_phallus';
				if (player.weapon == game.weapons.MOONLIT) return 'katana_holy';
				if (player.weapon == game.weapons.C_BLADE) return 'katana_unholy';
				if (player.weapon == game.weapons.MASAMUN) return 'nodachi_holy';
				if (player.weapon == game.weapons.BLETTER) return 'nodachi_unholy';
				if (player.weapon == game.weapons.DAISHO) return 'daisho';
				if (player.weapon == game.weapons.Q_GUARD) return 'rapier_holy';
				if (player.weapon == game.weapons.B_WIDOW) return 'rapier_unholy';
				if (player.weapon == game.weapons.LHSCYTH) return 'scythe_holy';
				if (player.weapon == game.weapons.ATWINSCY || player.weaponOff == game.weapons.ATWINSCY || player.weapon == game.weapons.HATWINSCY || player.weaponOff == game.weapons.HATWINSCY || player.weapon == game.weapons.HELRAIS || player.weaponOff == game.weapons.HELRAIS) return 'scythe_unholy';
				if (player.hasAetherTwinsTierWeapon()) return 'dagger_aether';
				// if (???) return 'dagger_holy';
				// if (???) return 'dagger_unholy';
				
				// Generics
				if (weaponSubtype == 'katana' || weaponSubtype == 'uchigatana' || player.weapon == game.weapons.UGATANA || player.weapon == game.weapons.MOONLIT || player.weapon == game.weapons.C_BLADE || player.weapon == game.weapons.DKATANA) return 'katana';
				if ((weaponSubtype == 'katana' && weaponSubtype != 'uchigatana') || player.weapon == game.weapons.NODACHI  || player.weapon == game.weapons.DNODACHI || player.weapon == game.weapons.BLETTER  || player.weapon == game.weapons.KATANA || player.weapon == game.weapons.MASAMUN) return 'nodachi';
				if (player.weapon.hasTag(ItemConstants.W_RAPIER)) return 'rapier';
				if (player.weapon.hasTag(ItemConstants.W_TETSUBO)) return 'tetsubo';
				
				// Weapon type-based
				if (player.weapon.isStaffType()) return 'staff';
				if (player.weapon.isWandType()) return 'wand';
				if (player.weapon.isSwordType()) {
					if (player.weapon.isLarge()) return 'large_sword';
					if (player.weapon.isMassive()) return 'massive_sword';
					return 'sword';
				}
				if (player.weapon.isAxeType()) return 'axe';
				if (player.weapon.isMaceHammerType()) return 'hammer';
				if (player.isSpearTypeWeapon()) return 'spear'
				if (player.weapon.isDaggerType() && player.weapon != game.weapons.AETHERD && player.shield != game.shields.AETHERS) return 'dagger';
				if (player.weapon.isScytheType() || player.weapon == game.weapons.DEMSCYT || player.weapon == game.weapons.KAMA || player.weapon == game.weapons.KAMAWHIP || player.weapon == game.weapons.D_KAMA) return 'scythe';
				
				// default - no sprite
				return '';
			}
			function shieldSprite():String {
				if (player.shield.isNothing) return '';
				if (player.shield == game.shields.AETHERS || player.shield == game.shields.BATTNET || player.shield == game.shields.MABRACE || player.shield == game.shields.SPI_FOC || player.shield == game.shields.Y_U_PAN) return '';
				
				// if (???) return 'medium_holy'
				// if (???) return 'medium_unholy'
				// if (???) return 'small_holy'
				// if (???) return 'small_unholy'
				if (player.shield == game.shields.BUCKLER || player.shield == game.shields.TRASBUC || player.shield == game.shields.NECROSH) return 'small';
				
				if (player.shield == game.shields.SANCTYL) return 'large_holy';
				if (player.shield == game.shields.SANCTYD) return 'large_unholy';
				if (player.shield == game.shields.DRGNSHL || player.shield == game.shields.GREATSH || player.shield == game.shields.SANCTYN || player.shield == game.shields.SPIH_SH) return 'large';
				
				// if (???) return 'massive_holy'
				// if (???) return 'massive_unholy'
				if (player.shield == game.shields.SPIM_SH || player.shield == game.shields.TOWERSH) return 'massive';
				
				if (shieldSubtype == 'tome' || player.shield == game.shields.NEKONOM) return 'tome';
				
				// default - no sprite
				return '';
			}
			function rangedWeaponSprite():String {
				if (player.weaponRange == game.weaponsrange.ARTEMIS) return 'bow_holy';
				if (player.weaponRange == game.weaponsrange.WILDHUN) return 'bow_unholy';
				if (player.isBowTypeWeapon()) return 'bow';
				
				if (player.weaponRange == game.weaponsrange.E_TOME_ || player.weaponRange == game.weaponsrange.G_E_MAN || player.weaponRange == game.weaponsrange.G_E_MAN || player.weaponRange == game.weaponsrange.I_TOME_ || player.weaponRange == game.weaponsrange.SSKETCH) return 'tome';
				
				if (player.weaponRange == game.weaponsrange.KSLHARP) return 'javelin_holy';
				if (player.weaponRange == game.weaponsrange.LEVHARP) return 'javelin_unholy';
				if (player.weaponRange == game.weaponsrange.O_JAVEL || player.weaponRange == game.weaponsrange.TRJAVEL || player.weaponRange == game.weaponsrange.GTHRSPE) return 'javelin';
				
				if (player.weaponRange == game.weaponsrange.GTHRAXE) return 'axe';
				
				if (player.weaponRange == game.weaponsrange.LBLASTR) return 'lactoblaster';
				
				// default - no sprite
				return '';
			}
			function armorSprite():String {
				if (armorSubtype == 'clothes' || player.armor == game.armors.C_CLOTH) return 'ComfyCLothes';
				if (player.armor == game.armors.DEATHPO || player.armor == game.armors.DEATHPGA) return 'deathPrinceOutfit';
				if (player.armor == game.armors.M_ROBES || player.armor == game.armors.I_ROBES || player.armor == game.armors.I_CORST || player.armor == game.armors.EWROBE_ || player.armor == game.armors.A_ROBE_) return 'MageRobe';
				if (player.armor == game.armors.BLIZZ_K) return 'yukiDress';
				if (player.armor == game.armors.SPKIMO) return 'sakuraPetalKimono';
				if (player.armor == game.armors.OEKIMO || player.armor == game.armors.OTKIMO) return 'OniLegendaryKimono';
				if (player.armor == game.armors.WKIMONO) return 'whiteKimono';
				if (player.armor == game.armors.BKIMONO) return 'blueKimono';
				if (player.armor == game.armors.RKIMONO) return 'redKimono';
				if (player.armor == game.armors.PKIMONO) return 'purpleKimono';
				if (player.armor == game.armors.BLKIMONO) return 'blackKimono';
				if (player.armor == game.armors.IBKIMO || player.armor == game.armors.TCKIMO) return 'legendKimono';
				if (player.armor == game.armors.B_QIPAO) return 'blueQipao';
				if (player.armor == game.armors.G_QIPAO) return 'greenQipao';
				if (player.armor == game.armors.P_QIPAO) return 'purpleQipao';
				if (player.armor == game.armors.R_QIPAO) return 'redQipao';
				if (player.armor == game.armors.CTPALAD || player.armor == game.armors.CTHPALA) return 'centaurPaladinArmor';
				if (player.armor == game.armors.CTBGUAR) return 'centaurBlackGuardArmor';
				if (player.armor == game.armors.GTECHC_) return 'goblinTechnomancerClothe';
				if (player.armor == game.armors.SAQBIKNI) return 'sexyAquamarineBikini';
				if (player.armor == game.armors.SBABIKNI) return 'sexyBlackBikini';
				if (player.armor == game.armors.SBUBIKNI) return 'sexyBlueBikini';
				if (player.armor == game.armors.SGRBIKNI) return 'sexyGreenBikini';
				if (player.armor == game.armors.SPIBIKNI) return 'sexyPinkBikini';
				if (player.armor == game.armors.SREBIKNI) return 'sexyRedBikini';
				if (player.armor == game.armors.SWHBIKNI) return 'sexyWhiteBikini';
				if (player.armor == game.armors.SYEBIKNI) return 'sexyYellowBikini';
				if (player.armor == game.armors.KBDRESS) return 'krakenBlackDress';
				if (player.armor == game.armors.WALIC) return 'walpurgisIzaliaCloak';
				if (player.armor == game.armors.SCANSC) return 'scandalousSuccubusClothing';
				if (player.armor == game.armors.FQR) return 'fairyQueenRegalia';
				if (player.armor == game.armors.BERA) return 'berserkerArmor';
				if (player.armor == game.armors.BESTBLA) return 'bestialBlademasterArmor';
				if (player.armor == game.armors.VLAR) return 'vladimirRegalia';
				if (player.armor == game.armors.ELFDRES) return 'elfVillagerDress';
				if (player.armor == game.armors.TRMOUTF) return 'travelingMerchantOutfit';
				if (player.armor == game.armors.CHBIKNI || player.armor == game.armors.LMARMOR) return 'chainMailBikini';
				if (armorSubtype == "fullplate" || player.armor == game.armors.EWPLTMA || player.armor == game.armors.FULLPLT || player.armor == game.armors.DBARMOR) return 'platemail';
				if (player.armor == game.armors.ERA) return 'elfClothing';
				if (player.armor == game.armors.IQG) return 'iceQueenGown';
				if (player.armor == game.armors.GOOARMR) return 'gooArmor';
				if (player.armor == game.armors.FCLOAK) return 'franRegalia';
				if (player.armor == game.armors.FMDRESS) return 'elfWizardDress';
				if (player.armor == game.armors.CGUNSLI) return 'CowGirlOutfit';
				if (player.armor == game.armors.ADVCLTH) return 'greenAdventurerClothes';
				if (player.armor == game.armors.NURSECL) return 'nurseClothing';
				if (armorSubtype == "samurai" || player.armor == game.armors.SAMUARM) return 'SamuraiArmor';
				if (armorSubtype == "scalemail" || player.armor == game.armors.SCALEML) return 'scalemail';
				if (armorSubtype == "fullchain" || player.armor == game.armors.FULLCHN) return 'chainMail';
				
				return '';
			}
			function braSprite():String {
				if (player.upperGarment == game.undergarments.TECHBRA) return 'goblinTechnomancerBra';
				if (player.upperGarment == game.undergarments.DS_BRA) return 'dragonscaleBikiniBra';
				if (player.upperGarment == game.undergarments.C_BRA) return 'comfyBikiniBra';
				if (player.upperGarment == game.undergarments.COW_BRA) return 'cowBra';
				if (player.upperGarment == game.undergarments.BN_TOP) return 'blackCatBra';
				return '';
			}
			function pantySprite():String {
				if (player.lowerGarment == game.undergarments.T_PANTY) return 'goblinTechnomancerPanty';
				if (player.lowerGarment == game.undergarments.DSTHONG) return 'dragonscaleBikiniPanty';
				if (player.lowerGarment == game.undergarments.C_PANTY) return 'comfyBikiniPanty';
				if (player.lowerGarment == game.undergarments.COW_PANTY) return 'cowPanty';
				if (player.lowerGarment == game.undergarments.BN_SKIRT) return 'blackCatPanty';
				if (player.lowerGarment == game.undergarments.C_LOIN || player.lowerGarment == game.undergarments.FURLOIN) return 'brownLoincloth';
				if (player.lowerGarment == game.undergarments.F_LOIN_ || player.lowerGarment == game.undergarments.SS_LOIN) return 'whiteLoincloth';
				return '';
			}
			function miscAccSprites():Object {
				var mas:Object = {};
				mas['oniGourd'] = player.countMiscJewelry(game.miscjewelries.ONI_GOURD);
				mas['demonTailRing'] = player.countMiscJewelry(game.miscjewelries.DMAGETO);
				return mas;
			}
			function neckAccSprite():String {
				if (player.necklace == game.necklaces.BWSCARF) return 'blueScarf';
				if (player.necklace == game.necklaces.RWSCARF) return 'redScarf';
				if (player.necklace == game.necklaces.GWSCARF) return 'greenScarf';
				if (player.necklace == game.necklaces.PWSCARF) return 'purpleScarf';
				if (player.necklace == game.necklaces.YWSCARF) return 'yellowScarf';
				if (player.necklace == game.necklaces.NECKINT || player.necklace == game.necklaces.NECKLIB || player.necklace == game.necklaces.NECKSEN ||
						player.necklace == game.necklaces.NECKSPE || player.necklace == game.necklaces.NECKSTR || player.necklace == game.necklaces.NECKTOU ||
						player.necklace == game.necklaces.NECKWIS || player.necklace == game.necklaces.FIRENEC || player.necklace == game.necklaces.ICENECK ||
						player.necklace == game.necklaces.LIGHNEC || player.necklace == game.necklaces.DARKNEC || player.necklace == game.necklaces.POISNEC ||
						player.necklace == game.necklaces.LUSTNEC) return 'GoldStatAmulet';
				if (player.necklace == game.necklaces.COWBELL || player.necklace == game.necklaces.CATBELL) return 'CowBellAmulet';
				return '';
			}
			function headAccSprite():String {
				if (player.headJewelry == game.headjewelries.FOXHAIR) return 'foxHairpin';
				if (player.headJewelry == game.headjewelries.GNHAIR) return 'goldenNagaHairpin';
				if (player.headJewelry == game.headjewelries.MACHGOG || player.headJewelry == game.headjewelries.SATGOG || player.headJewelry == game.headjewelries.SCANGOG) return 'machinistGoggles';
				if (player.headJewelry == game.headjewelries.SPHINXAS) return 'sphinxRegalia';
				if (player.headJewelry == game.headjewelries.DEATHPR) return 'deathPrinceRegalia';
				if (player.headJewelry == game.headjewelries.BESTBLAA) return 'bestialBlademasterAccoutrements';
				if (player.headJewelry == game.headjewelries.DMONSKUL) return 'skullOrnament';
				if (player.headJewelry == game.headjewelries.SNOWFH) return 'yukiHairpin';
				if (player.headJewelry == game.headjewelries.COWHAT) return 'cowGirlHat';
				if (player.headJewelry == game.headjewelries.KABUMEMP) return 'kabutoMempo';
				return '';
			}

			super([
				{}, // local variables
				{
					hydraTails: player.statusEffectv1(StatusEffects.HydraTailsPlayer),
					cockSize: player.cocks.length > 0 ? player.cocks[0].cockLength : 0,
					cockType: player.cocks.length > 0 ? player.cocks[0].cockType : 0,
					breastRating: player.breastRows[0].breastRating,
					
					ElementalBodyType: player.perkv1(PerkLib.ElementalBody),
					CaveWyrmPussy: player.vaginaType() == VaginaClass.CAVE_WYRM || player.vaginaType() == VaginaClass.RAIJU,
					CaveWyrmNipples: player.hasStatusEffect(StatusEffects.GlowingNipples),
					MindBreakerPussy: player.vaginaType() == VaginaClass.MINDBREAKER,
					CancerCrabStance: player.hasStatusEffect(StatusEffects.CancerCrabStance),
					SlimeCore: player.hasPerk(PerkLib.SlimeCore),
					DarkSlimeCore: player.hasPerk(PerkLib.DarkSlimeCore),
					AzazelPhylactery: player.hasPerk(PerkLib.InnerPhylactery),
					AkbalFire: player.hasPerk(PerkLib.FireLord),
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
					MeleeWeaponSprite: meleeWeaponSprite(),
					PlayerHasADaggerTwin: player.hasAetherTwinsTierWeapon(),
					PlayerHasAShieldTwin: player.hasAetherTwinsTierLeftShield(),
					PlayerHasAnOffhandDaggerTwin: player.hasAetherTwinsTierLeftDagger(),

					ShieldSprite: shieldSprite(), // incl. tome

					RangedWeaponSprite: rangedWeaponSprite(),

					PlayerHasADualWeapon: player.isDualWield(),
					PlayerHasADualMeleeWeapon: player.weapon.isDualWielded(),
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
					Piercing: Piercing,
					RearBody: RearBody,
					Skin: Skin,
					Tail: Tail,
					Tongue: Tongue,
					VaginaClass: VaginaClass,
					Wings: Wings,
//					StatusEffects: StatusEffects,

					// Viewable Clothing lists
					armStanceNonBannedList: player.armor == game.armors.SCANSC || player.armor == game.armors.ERA || player.armor == game.armors.FMDRESS || player.armor == game.armors.B_QIPAO || player.armor == game.armors.G_QIPAO || player.armor == game.armors.P_QIPAO || player.armor == game.armors.R_QIPAO || player.armor == game.armors.BERA,
					sleevelessList: player.armor == game.armors.B_QIPAO || player.armor == game.armors.G_QIPAO || player.armor == game.armors.P_QIPAO || player.armor == game.armors.R_QIPAO || player.armor == game.armors.BERA,
					playerWearsAStanceBannedDress: player.armor == game.armors.BLIZZ_K || player.armor == game.armors.SPKIMO || player.armor == game.armors.WKIMONO || player.armor == game.armors.BKIMONO || player.armor == game.armors.RKIMONO || player.armor == game.armors.PKIMONO || player.armor == game.armors.BLKIMONO || player.armor == game.armors.KBDRESS || player.armor == game.armors.GTECHC_ || player.armor == game.armors.IBKIMO || player.armor == game.armors.TCKIMO || player.armor == game.armors.OEKIMO || player.armor == game.armors.OTKIMO,
					playerWearsAStanceBannedArmor: armorSubtype == "fullplate" || player.armor == game.armors.CTPALAD || player.armor == game.armors.CTHPALA || player.armor == game.armors.EWPLTMA || player.armor == game.armors.FULLPLT || player.armor == game.armors.DBARMOR,

					ArmorSprite: armorSprite(),
					BraSprite: braSprite(),
					PantySprite: pantySprite(),
					MiscAccSprites: miscAccSprites(),
					NeckAccSprite: neckAccSprite(),
					HeadAccSprite: headAccSprite()
				}, {
					// utilities
					isLayerVisible: charview.composite.isVisible
				},
				character
			]);
			this.charview = charview;
		}
	}
}
