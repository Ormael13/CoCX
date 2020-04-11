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
import classes.Items.ArmorLib;
import classes.Player;
import classes.StatusEffects;
import classes.CockTypesEnum;
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
		super([
			{}, // local variables
			character,
			{

				CaveWyrmPussy: player.vaginaType() == VaginaClass.CAVE_WYRM,
				CaveWyrmNipples: player.hasStatusEffect(StatusEffects.GlowingNipples),
				showClothing: [LowerBody.LION,LowerBody.GARGOYLE,LowerBody.GARGOYLE_2].indexOf(player.lowerBody) <= 0,
				showArmClothing: [Arms.LION,Arms.DISPLACER,Arms.GARGOYLE,Arms.GARGOYLE_2,Arms.YETI,Arms.HINEZUMI].indexOf(player.arms.type) <= 0,
				showLegClothing: [LowerBody.YETI,LowerBody.HOOFED,LowerBody.HARPY,LowerBody.GOO,LowerBody.NAGA,LowerBody.DRIDER,LowerBody.HINEZUMI,LowerBody.MELKIE,LowerBody.CENTIPEDE,LowerBody.SCYLLA,LowerBody.KRAKEN].indexOf(player.lowerBody) <= 0,
				PlayerHasViewableOutfit: player.isWearingArmor(),

				Antennae     : Antennae,
				Arms         : Arms,
				Beard        : Beard,
				BreastCup    : BreastCup,
				Butt         : Butt,
				Claws        : Claws,
				CockTypesEnum: CockTypesEnum,
				Ears         : Ears,
				Eyes         : Eyes,
				Face         : Face,
				Gender       : Gender,
				Gills        : Gills,
				Hair         : Hair,
				Hips         : Hips,
				Horns        : Horns,
				LowerBody    : LowerBody,
				Neck         : Neck,
				Pattern      : Pattern,
				Piercing     : Piercing,
				RearBody     : RearBody,
				Skin         : Skin,
				Tail         : Tail,
				Tongue       : Tongue,
				UnderBody    : UnderBody,
				Wings        : Wings,
				StatusEffects: StatusEffects,

				// Viewable Clothing lists
				armStanceNonBannedList: player.armor == game.armors.B_QIPAO || player.armor == game.armors.G_QIPAO || player.armor == game.armors.P_QIPAO || player.armor == game.armors.R_QIPAO,
				yukiDress: player.armor == game.armors.BLIZZ_K,
				sakuraPetalKimono: player.armor == game.armors.SPKIMO,
				whiteKimono: player.armor == game.armors.WKIMONO,
				blueKimono: player.armor == game.armors.BKIMONO,
				redKimono: player.armor == game.armors.RKIMONO,
				purpleKimono: player.armor == game.armors.PKIMONO,
				blackKimono: player.armor == game.armors.BLKIMONO,
				blueQipao: player.armor == game.armors.B_QIPAO,
				greenQipao: player.armor == game.armors.G_QIPAO,
				purpleQipao: player.armor == game.armors.P_QIPAO,
				redQipao: player.armor == game.armors.R_QIPAO,
				centaurBlackguardArmor: player.armor == game.armors.CTPALAD,
				centaurPaladinArmor: player.armor == game.armors.CTPALAD,
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
				walpurgisIzaliaRobe: player.armor == game.armors.WIR,
				platemail: player.armor == game.armors.EWPLTMA || player.armor == game.armors.FULLPLT || player.armor == game.armors.DBARMOR,

				//viewable bra list
				goblinTechnomancerBra: player.upperGarment == game.undergarments.TECHBRA,

				//viewable panty list
				goblinTechnomancerPanty: player.lowerGarment == game.undergarments.T_PANTY,

				// Viewable neck Accessory lists
				blueScarf: player.necklace == game.necklaces.BWSCARF,
				greenScarf: player.necklace == game.necklaces.GWSCARF,
				purpleScarf: player.necklace == game.necklaces.PWSCARF,
				yellowScarf: player.necklace == game.necklaces.YWSCARF,

				// Viewable head Accessory lists
				foxHairpin: player.headJewelry == game.headjewelries.FOXHAIR,
				goldenNagaHairpin: player.headJewelry == game.headjewelries.GNHAIR,
				machinistGoggles: player.headJewelry == game.headjewelries.MACHGOG || player.headJewelry == game.headjewelries.SATGOG || player.headJewelry == game.headjewelries.SCANGOG,
				//sphinxRegalia: player.headJewelry == game.headjewelries.SphinxAS
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
	public static const NONE:int                    = classes.BodyParts.Skin.PATTERN_NONE;
	public static const MAGICAL_TATTOO:int          = classes.BodyParts.Skin.PATTERN_MAGICAL_TATTOO;
	public static const ORCA_UNDERBODY:int          = classes.BodyParts.Skin.PATTERN_ORCA_UNDERBODY;
	public static const BEE_STRIPES:int             = classes.BodyParts.Skin.PATTERN_BEE_STRIPES;
	public static const TIGER_STRIPES:int           = classes.BodyParts.Skin.PATTERN_TIGER_STRIPES;
	public static const BATTLE_TATTOO:int           = classes.BodyParts.Skin.PATTERN_BATTLE_TATTOO;
	public static const SPOTTED:int                 = classes.BodyParts.Skin.PATTERN_SPOTTED;
	public static const LIGHTNING_SHAPED_TATTOO:int = classes.BodyParts.Skin.PATTERN_LIGHTNING_SHAPED_TATTOO;
	public static const RED_PANDA_UNDERBODY:int     = classes.BodyParts.Skin.PATTERN_RED_PANDA_UNDERBODY;
	public static const SCAR_SHAPED_TATTOO:int      = classes.BodyParts.Skin.PATTERN_SCAR_SHAPED_TATTOO;
	public static const WHITE_BLACK_VEINS:int       = classes.BodyParts.Skin.PATTERN_WHITE_BLACK_VEINS;
}
class UnderBody {

}
