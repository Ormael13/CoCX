package classes.Transformations {
import classes.BodyParts.*;
import classes.CockTypesEnum;
import classes.Items.MutationsHelper;
import classes.Transformations.Transformations.*;
import classes.internals.EnumValue;

public class TransformationLib extends MutationsHelper {
public function TransformationLib() {
//	printAlchemyTable();
}

// VARIABLE NAMING: <body part> + <what to do> + <flavour>
// e.g. "grow 9th fox tail" -> TailFox9
// Complex TF should have prefix "Complex" or "Tiered" and can have any naming

// Template - copy and fill
// "is possible" function is optional default is "possible if not present"
/*
public const NAME:Transformation = new SimpleTransformation("Tf Name",
			// apply effect
			function (doOutput:Boolean):void {
				if (doOutput) {
					outputText("TF Effect")
				}
				apply_TF
			},
			// is present
			function():Boolean {
				return true_if_TF_already_present_on_player
			},
			// is possible
			function():Boolean {
				return true_if_TF_can_be_applied_to_player
			}
);
*/


/***
*    ███████ ███████ ███████ ███████  ██████ ████████ ███████
*    ██      ██      ██      ██      ██         ██    ██
*    █████   █████   █████   █████   ██         ██    ███████
*    ██      ██      ██      ██      ██         ██         ██
*    ███████ ██      ██      ███████  ██████    ██    ███████
*
*
*/
// Template for non-tf effects and tf effects that cannot be "present" (ex. enlarge cock)
// "is possible" function is optional, default always possible
/*
public const NAME:PossibleEffect = new SimpleEffect("Effect name",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "";

				if (doOutput) outputText(desc);
				apply_effect
			},
			// is possible?
			function ():Boolean {
				return true_if_effect_can_be_applied_to_player
			}
);
*/

/*
	*/
	public var mutagenEffect: MutagenEffectTransformations = new MutagenEffectTransformations();
	public const MutagenSpeSpider:PossibleEffect    		= mutagenEffect.MutagenSpeSpider;
	public const MutagenCurseSpeSpider:PossibleEffect    	= mutagenEffect.MutagenCurseSpeSpider;
	public const MutagenTouSpider:PossibleEffect    		= mutagenEffect.MutagenTouSpider;
	public const MutagenCurseStrSpider:PossibleEffect    	= mutagenEffect.MutagenCurseStrSpider;
	public const MutagenLibSpider:PossibleEffect    		= mutagenEffect.MutagenLibSpider;
	public const MutagenSpdCat: PossibleEffect 				= mutagenEffect.MutagenSpdCat;
	public const MutagenStrCat: PossibleEffect 				= mutagenEffect.MutagenStrCat;
	public const MutagenIntCat: PossibleEffect 				= mutagenEffect.MutagenIntCat;
	public const MutagenCurseTouCat: PossibleEffect 		= mutagenEffect.MutagenCurseTouCat;
	public const MutagenLibSensCat: PossibleEffect 		    = mutagenEffect.MutagenLibSensCat;
	public const MutagenSpeKanga: PossibleEffect 			= mutagenEffect.MutagenSpeKanga;
    public const MutagenCurseIntKanga:PossibleEffect        = mutagenEffect.MutagenCurseIntKanga;

    public const SensUpSpider:PossibleEffect        		= mutagenEffect.SensUpSpider;
    public const VenomRechargeSpider:PossibleEffect 		= mutagenEffect.VenomRechargeSpider;
    public const VaginaTightenAndMutagenLib:PossibleEffect  = mutagenEffect.VaginaTightenAndMutagenLib;
    public const AssholeTightenAndMutagenLib:PossibleEffect = mutagenEffect.AssholeTightenAndMutagenLib;
    public const CocksThickenAll:PossibleEffect             = mutagenEffect.CocksThickenAll;
    public const ShrinkClit:PossibleEffect                  = mutagenEffect.ShrinkClit.registerEffect(AS_CLIT,AE_SHRINK);
    public const ShrinkBalls:Transformation                 = mutagenEffect.ShrinkBalls.registerTf(AS_BALLS,AE_SHRINK);

//ANTENNAE
//======================================================================================================================
//                                                                                                                    ==
//    █████  ███    ██ ████████ ███████ ███    ██ ███    ██  █████  ███████                                           ==
//   ██   ██ ████   ██    ██    ██      ████   ██ ████   ██ ██   ██ ██                                                ==
//   ███████ ██ ██  ██    ██    █████   ██ ██  ██ ██ ██  ██ ███████ █████                                             ==
//   ██   ██ ██  ██ ██    ██    ██      ██  ██ ██ ██  ██ ██ ██   ██ ██                                                ==
//   ██   ██ ██   ████    ██    ███████ ██   ████ ██   ████ ██   ██ ███████                                           ==
//                                                                                                                    ==
//======================================================================================================================
	public var antennae: AntennaeTransformations = new AntennaeTransformations();
	public const AntennaeNone: Transformation 			= antennae.AntennaeNone.registerTf(AS_ANTENNAE, AE_REMOVE);
	public const AntennaeAnt: Transformation 			= antennae.AntennaeAnt.registerTf(AS_ANTENNAE, AE_ANT);
	public const AntennaeBee: Transformation 			= antennae.AntennaeBee.registerTf(AS_ANTENNAE, AE_BEE);
	public const AntennaeCentipede: Transformation 		= antennae.AntennaeCentipede.registerTf(AS_ANTENNAE, AE_CENTIPEDE);
	public const AntennaeFireSnail: Transformation 		= antennae.AntennaeFireSnail.registerTf(AS_ANTENNAE, AE_FIRE_SNAIL);
	public const AntennaeJabberwocky: Transformation 	= antennae.AntennaeJabberwocky.registerTf(AS_ANTENNAE, AE_JABBERWOCKY);
	public const AntennaeMantis: Transformation 		= antennae.AntennaeMantis.registerTf(AS_ANTENNAE, AE_MANTIS);
	public const AntennaeSeaDragon: Transformation 		= antennae.AntennaeSeaDragon.registerTf(AS_ANTENNAE, AE_SEA_DRAGON);
    public const AntennaeMoth: Transformation           = antennae.AntennaeMoth.registerTf(AS_ANTENNAE, AE_MOTH);

//ARMS
//======================================================================================================================
//  .                                                                                                                 ==
//    █████  ██████  ███      ███ ███████                                                                             ==
//   ██   ██ ██   ██ ████    ████ ██                                                                                  ==
//   ███████ ██████  ██  ████  ██ ███████                                                                             ==
//   ██   ██ ██   ██ ██   ██   ██      ██                                                                             ==
//   ██   ██ ██   ██ ██        ██ ███████                                                                             ==
//                                                                                                                    ==
//======================================================================================================================
	public var arms:ArmsTransformations = new ArmsTransformations();
	public const ArmsHuman: Transformation 				= arms.ArmsHuman.registerTf(AS_ARMS, AE_HUMAN);
	public const ArmsAnt: Transformation 				= arms.ArmsAnt.registerTf(AS_ARMS, AE_ANT);
	public const ArmsAtlach: Transformation 			= arms.ArmsAtlach.registerTf(AS_ARMS, AE_ATLACH_NACHA);
	public const ArmsAvian: Transformation 				= arms.ArmsAvian.registerTf(AS_ARMS, AE_AVIAN);
	public const ArmsBatWing: Transformation 			= arms.ArmsBatWing.registerTf(AS_ARMS, AE_BAT);
	public const ArmsBear: Transformation 				= arms.ArmsBear.registerTf(AS_ARMS, AE_BEAR);
	public const ArmsBee: Transformation 				= arms.ArmsBee.registerTf(AS_ARMS, AE_BEE);
	public const ArmsBoar: Transformation 				= arms.ArmsBoar.registerTf(AS_ARMS, AE_BOAR);
	public const ArmsCat: Transformation 				= arms.ArmsCat.registerTfMultiple(AS_ARMS, AE_CAT, AE_DRAGONNE);
	public const ArmsCaveWyrm: Transformation 			= arms.ArmsCaveWyrm.registerTf(AS_ARMS, AE_CAVE_WYRM);
	public const ArmsCentipede: Transformation 			= arms.ArmsCentipede.registerTf(AS_ARMS, AE_CENTIPEDE);
	public const ArmsDevil: Transformation 				= arms.ArmsDevil.registerTf(AS_ARMS, AE_DEVIL);
	public const ArmsDisplacer: Transformation 			= arms.ArmsDisplacer.registerTf(AS_ARMS, AE_DISPLACER_BEAST);
	public const ArmsDraconic: Transformation 			= arms.ArmsDraconic.registerTf(AS_ARMS, AE_DRAGON);
	public const ArmsFeyDraconic: Transformation 		= arms.ArmsFeyDraconic.registerTf(AS_ARMS, AE_FAERIE_DRAGON);
	public const ArmsElf: Transformation 				= arms.ArmsElf.registerTf(AS_ARMS, AE_ELF);
	public const ArmsFox: Transformation 				= arms.ArmsFox.registerTf(AS_ARMS, AE_FOX);
	public const ArmsFrostwyrm: Transformation 			= arms.ArmsFrostwyrm.registerTf(AS_ARMS, AE_FROST_WYRM);
	public const ArmsGazer: Transformation 				= arms.ArmsGazer.registerTf(AS_ARMS, AE_GAZER);
	public const ArmsGhost: Transformation 				= arms.ArmsGhost.registerTf(AS_ARMS, AE_GHOST);
	public const ArmsGoo: Transformation 				= arms.ArmsGoo.registerTf(AS_ARMS, AE_GOO);
	public const ArmsGryphon: Transformation 			= arms.ArmsGryphon.registerTf(AS_ARMS, AE_GRYPHON);
	public const ArmsHarpy: Transformation 				= arms.ArmsHarpy.registerTf(AS_ARMS, AE_HARPY);
	public const ArmsHinezumi: Transformation 			= arms.ArmsHinezumi.registerTf(AS_ARMS, AE_HINEZUMI);
	public const ArmsHydra: Transformation 				= arms.ArmsHydra.registerTf(AS_ARMS, AE_HYDRA);
	public const ArmsJabberwocky: Transformation 		= arms.ArmsJabberwocky.registerTf(AS_ARMS, AE_JABBERWOCKY);
	public const ArmsJiangshi: Transformation 			= arms.ArmsJiangshi.registerTf(AS_ARMS, AE_JIANGSHI);
	public const ArmsKamaitachi: Transformation 		= arms.ArmsKamaitachi.registerTf(AS_ARMS, AE_KAMAITACHI);
	public const ArmsKitsune: Transformation 			= arms.ArmsKitsune.registerTf(AS_ARMS, AE_KITSUNE);
	public const ArmsKraken: Transformation 			= arms.ArmsKraken.registerTf(AS_ARMS, AE_KRAKEN);
	public const ArmsLion: Transformation 				= arms.ArmsLion.registerTfMultiple(AS_ARMS, AE_LION, AE_DRAGONNE);
	public const ArmsLizard: Transformation 			= arms.ArmsLizard.registerTf(AS_ARMS, AE_LIZARD);
	public const ArmsMantis: Transformation 			= arms.ArmsMantis.registerTf(AS_ARMS, AE_MANTIS);
	public const ArmsMelkie: Transformation 			= arms.ArmsMelkie.registerTf(AS_ARMS, AE_MELKIE);
	public const ArmsOni: Transformation 				= arms.ArmsOni.registerTf(AS_ARMS, AE_ONI);
	public const ArmsOrc: Transformation 				= arms.ArmsOrc.registerTf(AS_ARMS, AE_ORC);
	public const ArmsOrca: Transformation 				= arms.ArmsOrca.registerTf(AS_ARMS, AE_ORCA);
	public const ArmsPhoenix: Transformation 			= arms.ArmsPhoenix.registerTf(AS_ARMS, AE_PHOENIX);
	public const ArmsPig: Transformation 				= arms.ArmsPig.registerTf(AS_ARMS, AE_PIG);
	public const ArmsPlant: Transformation 				= arms.ArmsPlant.registerTf(AS_ARMS, AE_PLANT);
	public const ArmsPlant2: Transformation 			= arms.ArmsPlant2.registerTf(AS_ARMS, AE_YGGDRASIL);
	public const ArmsRaccoon: Transformation 			= arms.ArmsRaccoon.registerTf(AS_ARMS, AE_RACCOON);
	public const ArmsRaiju: Transformation 				= arms.ArmsRaiju.registerTf(AS_ARMS, AE_RAIJU);
	public const ArmsRaijuPaws: Transformation 			= arms.ArmsRaijuPaws.registerTf(AS_ARMS, AE_RAIJU);
	public const ArmsRedPanda: Transformation 			= arms.ArmsRedPanda.registerTf(AS_ARMS, AE_RED_PANDA);
	public const ArmsSalamander: Transformation 		= arms.ArmsSalamander.registerTf(AS_ARMS, AE_SALAMANDER);
	public const ArmsSeaDragon: Transformation 			= arms.ArmsSeaDragon.registerTf(AS_ARMS, AE_SEA_DRAGON);
	public const ArmsShark: Transformation 				= arms.ArmsShark.registerTfMultiple(AS_ARMS, AE_SHARK, AE_WERESHARK);
	public const ArmsSphinx: Transformation 			= arms.ArmsSphinx.registerTf(AS_ARMS, AE_SPHINX);
	public const ArmsSpider: Transformation 			= arms.ArmsSpider.registerTf(AS_ARMS, AE_SPIDER);
	public const ArmsSquirrel: Transformation 			= arms.ArmsSquirrel.registerTf(AS_ARMS, AE_SQUIRREL);
	public const ArmsUshiOni: Transformation 			= arms.ArmsUshiOni.registerTf(AS_ARMS, AE_USHI_ONI);
	public const ArmsWeasel: Transformation 			= arms.ArmsWeasel.registerTf(AS_ARMS, AE_WEASEL);
	public const ArmsWendigo: Transformation 			= arms.ArmsWendigo.registerTf(AS_ARMS, AE_WENDIGO);
	public const ArmsWolf: Transformation 				= arms.ArmsWolf.registerTf(AS_ARMS, AE_WOLF);
	public const ArmsHound: Transformation 				= arms.ArmsHound.registerTf(AS_ARMS, AE_CERBERUS);
	public const ArmsYeti: Transformation 				= arms.ArmsYeti.registerTf(AS_ARMS, AE_YETI);
	public const ArmsYukiOnna: Transformation 			= arms.ArmsYukiOnna.registerTf(AS_ARMS, AE_YUKI_ONNA);
	public const ArmsTiny: Transformation 			    = arms.ArmsTiny.registerTf(AS_ARMS, AE_IMP);
	public const ArmsCanine: Transformation 			= arms.ArmsCanine.registerTf(AS_ARMS, AE_ANUBIS);
	public const ArmsAbyssalShark: Transformation 		= arms.ArmsAbyssalShark.registerTf(AS_ARMS, AE_ABYSSAL_SHARK);
	public const ArmsArigean: Transformation 			= arms.ArmsArigean.registerTf(AS_ARMS, AE_ARIGEAN);
	public const ArmsDemon: Transformation 				= arms.ArmsDemon.registerTf(AS_ARMS, AE_DEMON);
	public const ArmsDeer: Transformation 				= arms.ArmsDeer.registerTf(AS_ARMS, AE_DEER);
	public const ArmsReindeer: Transformation 			= arms.ArmsReindeer.registerTf(AS_ARMS, AE_REINDEER);
    public const ArmsMoth: Transformation               = arms.ArmsMoth.registerTf(AS_ARMS, AE_MOTH);
    public const ArmsSatyr: Transformation              = arms.ArmsSatyr.registerTf(AS_ARMS, AE_SATYR);
    public const ArmsTroll: Transformation              = arms.ArmsTroll.registerTf(AS_ARMS, AE_TROLL);
    public const ArmsGlacialTroll: Transformation       = arms.ArmsGlacialTroll.registerTf(AS_ARMS, AE_GLACIAL_TROLL);


//ASS
//======================================================================================================================
//                                                                                                                    ==
//     █████  ███████ ███████                                                                                         ==
//    ██   ██ ██      ██                                                                                              ==
//    ███████ ███████ ███████                                                                                         ==
//    ██   ██      ██      ██                                                                                         ==
//    ██   ██ ███████ ███████                                                                                         ==
//                                                                                                                    ==
//======================================================================================================================
    public const AssGrowUpTo11:Transformation = new SimpleTransformation("Grow ass up to 11",
            // apply
            function (doOutput:Boolean):void {
                var desc: String = "";

                desc += "You look over your shoulder at your [ass] only to see it expand just slightly. You gape in confusion before looking back at the remaining silk in your hands. You finish it anyway. Dammit!";

                if (doOutput) outputText(desc);
                player.butt.type++;
            },
            // is present
            function ():Boolean {
                return player.butt.type < 11;
            }
    ).registerTf(AS_ASS, AE_GROW);


//BALLS
//======================================================================================================================
//                                                                                                                    ==
//   ██████   █████  ██     ██     ███████                                                                            ==
//   ██   ██ ██   ██ ██     ██     ████                                                                               ==
//   ██████  ███████ ██     ██     ███████                                                                            ==
//   ██   ██ ██   ██ ██     ██          ██                                                                            ==
//   ██████  ██   ██ ██████ ██████ ███████                                                                            ==
//                                                                                                                    ==
//======================================================================================================================
	public var balls:BallsTransformations = new BallsTransformations();
	public const BallsNone:Transformation = balls.BallsNone.registerTf(AS_BALLS, AE_REMOVE);
	public const BallsDuo:Transformation = balls.BallsDuo;
	public function BallsQuad(size: int = 1, forceQuad: Boolean = false):Transformation { return balls.BallsQuad(size, forceQuad); }
	public const BallsTrap:Transformation = balls.BallsTrap.registerTf(AS_BALLS, AE_SAND_TRAP);


//BREASTS
//======================================================================================================================
//                                                                                                                    ==
//   ██████  ██████  ███████  █████  ███████ ████████ ███████                                                         ==
//   ██   ██ ██   ██ ██      ██   ██ ██         ██    ██                                                              ==
//   ██████  ██████  █████   ███████ ███████    ██    ███████                                                         ==
//   ██   ██ ██   ██ ██      ██   ██      ██    ██         ██                                                         ==
//   ██████  ██   ██ ███████ ██   ██ ███████    ██    ███████                                                         ==
//                                                                                                                    ==
//======================================================================================================================
    public var breasts:BreastsTransformations = new BreastsTransformations();
    public function UnlockBreasts(): void {	return breasts.UnlockBreasts(); }
    public const BreastsGrowUpToDD:Transformation 		= breasts.BreastsGrowUpToDD.registerTf(AS_BREASTS, AE_GROW);
    public const BreastsShrinkToNothing:Transformation 	= breasts.BreastsShrinkToNothing.registerTf(AS_BREASTS, AE_SHRINK);
    public const BreastRowsRemoveToOne:Transformation 	= breasts.BreastRowsRemoveToOne.registerTf(AS_BREASTS, AE_REMOVE);
    public const BreastRowsOne:Transformation 			= breasts.BreastRowsOne;
    public const BreastRowsTwo:Transformation 			= breasts.BreastRowsTwo;
    public const BreastRowsThree:Transformation 		= breasts.BreastRowsThree;
    public const BreastRowsFour:Transformation 			= breasts.BreastRowsFour;
    public function CreateBreastRow(size:int = 2):Transformation { return breasts.CreateBreastRow(size); }
    public function CopyBreastRow(keepSize:Boolean = false):Transformation { return breasts.CopyBreastRow(keepSize); }
    public const NipplesPerBreastOne:Transformation 	= breasts.NipplesPerBreastOne.registerTf(AS_BREASTS, AE_HUMAN);
    public const NipplesPerBreastFour:Transformation 	= breasts.NipplesPerBreastFour.registerTf(AS_BREASTS, AE_COW);
    public const NipplesFuckableForce:Transformation 	= breasts.NipplesFuckableForce;
    public const NipplesFuckable:Transformation 		= breasts.NipplesFuckable.registerTf(AS_NIPPLES, AE_DEMON);
    public const NipplesUnfuck:Transformation 			= breasts.NipplesUnfuck;
    public const StartLactation:Transformation 			= breasts.StartLactation;
    public const RemoveLactation:Transformation 		= breasts.RemoveLactation;
    public const NipplesNoColor:Transformation 			= breasts.NipplesNoColor;
    public const NipplesBlack:Transformation 			= breasts.NipplesBlack.registerTfMultiple(AS_NIPPLES, AE_SPIDER, AE_SAND_TRAP);
    public const NipplesGlowing:Transformation 			= breasts.NipplesGlowing.registerTf(AS_NIPPLES, AE_CAVE_WYRM);
	public const NipplessHumanize:Transformation        = new TransformationGroupAll("Humanize nipples",[NipplesUnfuck, NipplesNoColor]).registerTf(AS_NIPPLES, AE_HUMAN);


//COCK
//======================================================================================================================
//                                                                                                                    ==
//	  ██████  ██████   ██████ ██    ██                                                                                ==
//   ██      ██    ██ ██      ██  ██                                                                                  ==
//	 ██      ██    ██ ██      ████                                                                                    ==
//	 ██      ██    ██ ██      ██  ██                                                                                  ==
//	  ██████  ██████   ██████ ██    ██                                                                                ==
//                                                                                                                    ==
//======================================================================================================================
    public var cocks:CockTransformations = new CockTransformations();
    public function UnlockCocks():void { return cocks.UnlockCocks(); }
    public function CockNone(cock:int = 0): Transformation { return cocks.CockNone(cock); }
	public const CockRemoveRandom:Transformation = CockNone(-1).registerTf(AS_COCK, AE_REMOVE);
    public function CockHuman(cock:int = 0, length:Number = 5.5, thickness:Number = 1): Transformation 			{ return cocks.CockHuman(cock, length, thickness); }
	public const CockAnyHuman:Transformation = CockHuman(-1).registerTf(AS_COCK, AE_HUMAN);
    public function CockHorse(cock:int = 0, length:Number = 5.5, thickness:Number = 1): Transformation 			{ return cocks.CockHorse(cock, length, thickness); }
	public const CockAnyHorse:Transformation = CockHorse(-1).registerTfMultiple(AS_COCK, AE_HORSE, AE_ALICORN, AE_UNICORN);
    public function CockKirin(cock:int = 0, length:Number = 5.5, thickness:Number = 1): Transformation 			{ return cocks.CockKirin(cock, length, thickness); }
	public const CockAnyKirin:Transformation = CockKirin(-1).registerTf(AS_COCK, AE_KIRIN);
    public function CockDog(cock:int = 0, length:Number = 5.5, thickness:Number = 1, knot:Number = 1.4): Transformation { return cocks.CockDog(cock, length, thickness, knot); }
	public const CockAnyDog:Transformation = CockDog(-1).registerTf(AS_COCK, AE_DOG);
    public function CockDemon(cock:int = 0, length:Number = 5.5, thickness:Number = 1): Transformation 			{ return cocks.CockDemon(cock, length, thickness); }
	public const CockAnyDemon:Transformation = CockDemon(-1).registerTf(AS_COCK, AE_DEMON);
    public function CockTentacle(cock:int = 0, length:Number = 5.5, thickness:Number = 1): Transformation 		{ return cocks.CockTentacle(cock, length, thickness); }
	public const CockAnyTentacle:Transformation = CockTentacle(-1).registerTf(AS_COCK, AE_PLANT);
    public function CockScylla(cock:int = 0, length:Number = 5.5, thickness:Number = 1): Transformation 		{ return cocks.CockScylla(cock, length, thickness); }
	public const CockAnyScylla:Transformation = CockScylla(-1).registerTf(AS_COCK, AE_SCYLLA);
    public function CockCat(cock:int = 0, length:Number = 5.5, thickness:Number = 1): Transformation 			{ return cocks.CockCat(cock, length, thickness); }
	public const CockAnyCat:Transformation = CockCat(-1).registerTf(AS_COCK, AE_CAT);
    public function CockCancer(cock:int = 0, length:Number = 5.5, thickness:Number = 1): Transformation 		{ return cocks.CockCancer(cock, length, thickness); }
	public const CockAnyCancer:Transformation = CockCancer(-1).registerTf(AS_COCK, AE_CANCER);
    public function CockLizard(cock:int = 0, length:Number = 5.5, thickness:Number = 1): Transformation 		{ return cocks.CockLizard(cock, length, thickness); }
	public const CockAnyLizard:Transformation = CockLizard(-1).registerTf(AS_COCK, AE_LIZARD);
    public function CockCaveWyrm(cock:int = 0, length:Number = 5.5, thickness:Number = 1): Transformation 		{ return cocks.CockCaveWyrm(cock, length, thickness); }
	public const CockAnyCaveWyrm:Transformation = CockCaveWyrm(-1).registerTf(AS_COCK, AE_CAVE_WYRM);
    public function CockAnemone(cock:int = 0, length:Number = 5.5, thickness:Number = 1): Transformation 		{ return cocks.CockAnemone(cock, length, thickness); }
	public const CockAnyAnemone:Transformation = CockAnemone(-1).registerTf(AS_COCK, AE_ANEMONE);
    public function CockKangaroo(cock:int = 0, length:Number = 5.5, thickness:Number = 1): Transformation 		{ return cocks.CockKangaroo(cock, length, thickness); }
	public const CockAnyKangaroo:Transformation = CockKangaroo(-1).registerTf(AS_COCK, AE_KANGAROO);
    public function CockDragon(cock:int = 0, length:Number = 5.5, thickness:Number = 1): Transformation 		{ return cocks.CockDragon(cock, length, thickness); }
	public const CockAnyDragon:Transformation = CockDragon(-1).registerTf(AS_COCK, AE_DRAGON);
    public function CockDisplacer(cock:int = 0, length:Number = 5.5, thickness:Number = 1, knot:Number = 1.5): Transformation { return cocks.CockDisplacer(cock, length, thickness, knot); }
	public const CockAnyDisplacer:Transformation = CockDisplacer(-1).registerTf(AS_COCK, AE_DISPLACER_BEAST);
    public function CockFox(cock:int = 0, length:Number = 5.5, thickness:Number = 1, knot:Number = 1.25): Transformation { return cocks.CockFox(cock, length, thickness, knot); }
	public const CockAnyFox:Transformation = CockFox(-1).registerTf(AS_COCK, AE_FOX);
    public function CockBee(cock:int = 0, length:Number = 5.5, thickness:Number = 1): Transformation 			{ return cocks.CockBee(cock, length, thickness); }
	public const CockAnyBee:Transformation = CockBee(-1).registerTf(AS_COCK, AE_BEE);
    public function CockPig(cock:int = 0, length:Number = 5.5, thickness:Number = 1): Transformation 			{ return cocks.CockPig(cock, length, thickness); }
	public const CockAnyPig:Transformation = CockPig(-1).registerTf(AS_COCK, AE_PIG);
    public function CockAvian(cock:int = 0, length:Number = 5.5, thickness:Number = 1): Transformation 			{ return cocks.CockAvian(cock, length, thickness); }
	public const CockAnyAvian:Transformation = CockAvian(-1).registerTf(AS_COCK, AE_AVIAN);
    public function CockRhino(cock:int = 0, length:Number = 5.5, thickness:Number = 1, inBlackCock:Boolean = false): Transformation { return cocks.CockRhino(cock, length, thickness, inBlackCock); }
	public const CockAnyRhino:Transformation = CockRhino(-1).registerTf(AS_COCK, AE_RHINO);
    public function CockEchidna(cock:int = 0, length:Number = 5.5, thickness:Number = 1, inBlackCock:Boolean = false): Transformation { return cocks.CockEchidna(cock, length, thickness, inBlackCock); }
	public const CockAnyEchidna:Transformation = CockEchidna(-1).registerTf(AS_COCK, AE_ECHIDNA);
    public function CockWolf(cock:int = 0, length:Number = 5.5, thickness:Number = 1, knot:Number = 1.1): Transformation { return cocks.CockWolf(cock, length, thickness, knot); }
	public const CockAnyWolf:Transformation = CockWolf(-1).registerTf(AS_COCK, AE_WOLF);
    public function CockStamen(cock:int = 0, length:Number = 5.5, thickness:Number = 1): Transformation 		{ return cocks.CockStamen(cock, length, thickness); }
	public const CockAnyStamen:Transformation = CockStamen(-1).registerTf(AS_COCK, AE_ALRAUNE);
    public function CockRedPanda(cock:int = 0, length:Number = 5.5, thickness:Number = 1): Transformation 		{ return cocks.CockRedPanda(cock, length, thickness); }
	public const CockAnyRedPanda:Transformation = CockRedPanda(-1).registerTf(AS_COCK, AE_RED_PANDA);
    public function CockGryphon(cock:int = 0, length:Number = 5.5, thickness:Number = 1): Transformation 		{ return cocks.CockGryphon(cock, length, thickness); }
	public const CockAnyGryphon:Transformation = CockGryphon(-1).registerTf(AS_COCK, AE_GRYPHON);
    public function CockCentipede(cock:int = 0, length:Number = 5.5, thickness:Number = 1): Transformation 		{ return cocks.CockCentipede(cock, length, thickness); }
	public const CockAnyCentipede:Transformation = CockCentipede(-1).registerTf(AS_COCK, AE_CENTIPEDE);
    public function CockRaiju(cock:int = 0, length:Number = 5.5, thickness:Number = 1): Transformation 			{ return cocks.CockRaiju(cock, length, thickness); }
	public const CockAnyRaiju:Transformation = CockRaiju(-1).registerTf(AS_COCK, AE_RAIJU);
    public function CockUshiOni(cock:int = 0, length:Number = 5.5, thickness:Number = 1): Transformation 		{ return cocks.CockUshiOni(cock, length, thickness); }
	public const CockAnyUshiOni:Transformation = CockUshiOni(-1).registerTf(AS_COCK, AE_USHI_ONI);
    public function CockInsect(cock:int = 0, length:Number = 5.5, thickness:Number = 1): Transformation 		{ return cocks.CockInsect(cock, length, thickness); }
	public const CockAnyInsect:Transformation = CockInsect(-1).registerTfMultiple(AS_COCK, AE_BEE, AE_ANT, AE_MANTIS);
    public function CockArigean(cock:int = 0, length:Number = 5.5, thickness:Number = 1): Transformation 		{ return cocks.CockArigean(cock, length, thickness); }
	public const CockAnyArigean:Transformation = CockArigean(-1).registerTf(AS_COCK, AE_ARIGEAN);
    public function GrowKnot(cock:int = 0, crit:Number = 1, mod:Number = 1, div:Number = 20): Transformation 	{ return cocks.GrowKnot(cock, crit, mod, div); }
    public function CockChangeType(type:CockTypesEnum, grow:Boolean, oneByOne:Boolean=false):Transformation 	{ return cocks.CockChangeType(type, grow, oneByOne); }


//EARS
//======================================================================================================================
//  .                                                                                                                 ==
//   ███████  █████  ██████  ███████                                                                                  ==
//   ██      ██   ██ ██   ██ ██                                                                                       ==
//   █████   ███████ ██████  ███████                                                                                  ==
//   ██      ██   ██ ██   ██      ██                                                                                  ==
//   ███████ ██   ██ ██   ██ ███████                                                                                  ==
//                                                                                                                    ==
//======================================================================================================================
	public var ears:EarsTransformations = new EarsTransformations();
	public const EarsHuman: Transformation 			= ears.EarsHuman.registerTf(AS_EARS, AE_HUMAN);
	public const EarsLion: Transformation 			= ears.EarsLion.registerTf(AS_EARS, AE_LION);
	public const EarsDisplacer: Transformation 		= ears.EarsDisplacer.registerTf(AS_EARS, AE_DISPLACER_BEAST);
	public const EarsCat: Transformation 			= ears.EarsCat.registerTfMultiple(AS_EARS, AE_CAT, AE_DRAGONNE);
	public const EarsRedPanda: Transformation 		= ears.EarsRedPanda.registerTf(AS_EARS, AE_RED_PANDA);
	public const EarsHorse: Transformation 			= ears.EarsHorse.registerTf(AS_EARS, AE_HORSE);
	public const EarsKirin: Transformation 			= ears.EarsKirin.registerTf(AS_EARS, AE_KIRIN);
	public const EarsPig: Transformation 			= ears.EarsPig.registerTf(AS_EARS, AE_PIG);
	public const EarsVampire: Transformation 		= ears.EarsVampire.registerTf(AS_EARS, AE_VAMPIRE);
	public const EarsBat: Transformation 			= ears.EarsBat.registerTf(AS_EARS, AE_BAT);
	public const EarsWeasel: Transformation 		= ears.EarsWeasel.registerTf(AS_EARS, AE_WEASEL);
	public const EarsOni: Transformation 			= ears.EarsOni.registerTf(AS_EARS, AE_ONI);
	public const EarsElven: Transformation 			= ears.EarsElven.registerTf(AS_EARS, AE_ELF);
	public const EarsGoat: Transformation 			= ears.EarsGoat.registerTf(AS_EARS, AE_GOAT);
	public const EarsCow: Transformation 			= ears.EarsCow.registerTf(AS_EARS, AE_COW);
	public const EarsDraconic: Transformation 		= ears.EarsDraconic.registerTf(AS_EARS, AE_DRAGON);
	public const EarsSnake: Transformation 			= ears.EarsSnake.registerTf(AS_EARS, AE_SNAKE);
	public const EarsOrca: Transformation 			= ears.EarsOrca.registerTf(AS_EARS, AE_ORCA);
	public const EarsOrca2: Transformation 			= ears.EarsOrca2.registerTf(AS_EARS, AE_ORCA);
	public const EarsLizard: Transformation 		= ears.EarsLizard.registerTf(AS_EARS, AE_LIZARD);
	public const EarsInsect: Transformation 		= ears.EarsInsect.registerTf(AS_EARS, AE_BEE);
	public const EarsFox: Transformation 			= ears.EarsFox.registerTf(AS_EARS, AE_FOX);
	public const EarsElfin: Transformation 			= ears.EarsElfin.registerTfMultiple(AS_EARS, AE_IMP, AE_GOBLIN);
	public const EarsWolf: Transformation 			= ears.EarsWolf.registerTf(AS_EARS, AE_WOLF);
	public const EarsDog: Transformation 			= ears.EarsDog.registerTf(AS_EARS, AE_DOG);
	public const EarsGremlin: Transformation 		= ears.EarsGremlin.registerTf(AS_EARS, AE_GREMLIN);
	public const EarsShark: Transformation 			= ears.EarsShark.registerTfMultiple(AS_EARS, AE_SHARK, AE_WERESHARK);
	public const EarsCaveWyrm: Transformation 		= ears.EarsCaveWyrm.registerTf(AS_EARS, AE_CAVE_WYRM);
	public const EarsBunny: Transformation 			= ears.EarsBunny.registerTf(AS_EARS, AE_BUNNY);
	public const EarsAvian: Transformation 			= ears.EarsAvian.registerTf(AS_EARS, AE_AVIAN);
	public const EarsGryphon: Transformation 		= ears.EarsGryphon.registerTf(AS_EARS, AE_GRYPHON);
	public const EarsKangaroo: Transformation 		= ears.EarsKangaroo.registerTf(AS_EARS, AE_KANGAROO);
	public const EarsRaiju: Transformation 			= ears.EarsRaiju.registerTf(AS_EARS, AE_RAIJU);
	public const EarsSquirrel: Transformation 		= ears.EarsSquirrel.registerTf(AS_EARS, AE_SQUIRREL);
	public const EarsRaccoon: Transformation 		= ears.EarsRaccoon.registerTf(AS_EARS, AE_RACCOON);
	public const EarsMouse: Transformation 			= ears.EarsMouse.registerTf(AS_EARS, AE_MOUSE);
	public const EarsFerret: Transformation 		= ears.EarsFerret.registerTf(AS_EARS, AE_FERRET);
	public const EarsYeti: Transformation 			= ears.EarsYeti.registerTf(AS_EARS, AE_YETI);
	public const EarsBear: Transformation 			= ears.EarsBear.registerTf(AS_EARS, AE_BEAR);
	public const EarsPanda: Transformation 			= ears.EarsPanda.registerTf(AS_EARS, AE_PANDA);
	public const EarsMelkie: Transformation 		= ears.EarsMelkie.registerTf(AS_EARS, AE_MELKIE);
	public const EarsDeer: Transformation 			= ears.EarsDeer.registerTfMultiple(AS_EARS, AE_DEER, AE_REINDEER);
	public const EarsBig: Transformation        	= ears.EarsBig.registerTfMultiple(AS_EARS, AE_GOBLIN, AE_IMP);
	public const EarsFennecFox: Transformation 		= ears.EarsFennecFox.registerTf(AS_EARS, AE_WEREFOX);
	public const EarsJackal: Transformation 		= ears.EarsJackal.registerTf(AS_EARS, AE_ANUBIS);
	public const EarsTroll: Transformation 			= ears.EarsTroll.registerTf(AS_EARS, AE_TROLL);
	public const EarsGlacialTroll: Transformation 	= ears.EarsGlacialTroll.registerTf(AS_EARS, AE_GLACIAL_TROLL);


//EYES
//======================================================================================================================
//  .                                                                                                                 ==
//   ███████ ██   ██ ███████ ███████                                                                                  ==
//   ██	      ██ ██	 ██		 ██                                                                                       ==
//   █████	   ██    ██████	 ███████                                                                                  ==
//   ██		   ██	 ██		      ██                                                                                  ==
//   ███████   ██	 ███████ ███████                                                                                  ==
//                                                                                                                    ==
//======================================================================================================================
	public var eyes:EyesTransformations = new EyesTransformations();
    public const EyesCat: Transformation			= eyes.EyesCat.registerTfMultiple(AS_EYES, AE_CAT, AE_DRAGONNE);
	public const EyesDevil: Transformation			= eyes.EyesDevil.registerTf(AS_EYES, AE_DEVIL);
    public const EyesDisplacer: Transformation		= eyes.EyesDisplacer.registerTf(AS_EYES, AE_DISPLACER_BEAST);
	public const EyesDraconic: Transformation		= eyes.EyesDraconic.registerTf(AS_EYES, AE_DRAGON);
	public const EyesElf: Transformation			= eyes.EyesElf.registerTf(AS_EYES, AE_ELF);
	public const EyesFairy: Transformation			= eyes.EyesFairy.registerTf(AS_EYES, AE_FAIRY);
	public const EyesGorgon: Transformation			= eyes.EyesGorgon.registerTf(AS_EYES, AE_GORGON);
	public const EyesOni: Transformation			= eyes.EyesOni.registerTf(AS_EYES, AE_ONI);
	public const EyesBear: Transformation			= eyes.EyesBear.registerTf(AS_EYES, AE_BEAR);
	public const EyesCancer: Transformation			= eyes.EyesCancer.registerTf(AS_EYES, AE_CANCER);
	public const EyesCaveWyrm: Transformation		= eyes.EyesCaveWyrm.registerTf(AS_EYES, AE_CAVE_WYRM);
	public const EyesCentipede: Transformation		= eyes.EyesCentipede.registerTf(AS_EYES, AE_CENTIPEDE);
	public const EyesDead: Transformation			= eyes.EyesDead.registerTf(AS_EYES, AE_WENDIGO);
	public const EyesFenrir: Transformation			= eyes.EyesFenrir.registerTf(AS_EYES, AE_FENRIR);
	public const EyesFiendish: Transformation		= eyes.EyesFiendish.registerTf(AS_EYES, AE_DARK_SLIME);
	public const EyesFireSnail: Transformation		= eyes.EyesFireSnail.registerTf(AS_EYES, AE_FIRE_SNAIL);
	public const EyesFeral: Transformation		    = eyes.EyesFeral.registerTfMultiple(AS_EYES, AE_WEREWOLF, AE_WEREFOX, AE_WERESHARK);
	public const EyesFox: Transformation			= eyes.EyesFox.registerTf(AS_EYES, AE_FOX);
	public const EyesFrostwyrm: Transformation		= eyes.EyesFrostwyrm.registerTf(AS_EYES, AE_FROST_WYRM);
	public const EyesGoat: Transformation			= eyes.EyesGoat.registerTf(AS_EYES, AE_GOAT);
	public const EyesGhost: Transformation			= eyes.EyesGhost.registerTf(AS_EYES, AE_GHOST);
	public const EyesGryphon: Transformation		= eyes.EyesGryphon.registerTfMultiple(AS_EYES, AE_GRYPHON, AE_PEAFOWL, AE_AVIAN);
	public const EyesHinezumi: Transformation		= eyes.EyesHinezumi.registerTf(AS_EYES, AE_HINEZUMI);
	public const EyesHuman: Transformation			= eyes.EyesHuman.registerTf(AS_EYES, AE_HUMAN);
    public const EyesInfernal: Transformation		= eyes.EyesInfernal.registerTf(AS_EYES, AE_HELLCAT);
    public const EyesJiangshi: Transformation		= eyes.EyesJiangshi.registerTf(AS_EYES, AE_JIANGSHI);
	public const EyesKraken: Transformation			= eyes.EyesKraken.registerTf(AS_EYES, AE_KRAKEN);
	public const EyesLizard: Transformation			= eyes.EyesLizard.registerTf(AS_EYES, AE_LIZARD);
	public const EyesManticore: Transformation		= eyes.EyesManticore.registerTf(AS_EYES, AE_MANTICORE);
	public const EyesMonoeye: Transformation		= eyes.EyesMonoeye.registerTf(AS_EYES, AE_GAZER);
    public const EyesOrc: Transformation			= eyes.EyesOrc.registerTf(AS_EYES, AE_ORC);
	public const EyesRaiju: Transformation			= eyes.EyesRaiju.registerTf(AS_EYES, AE_RAIJU);
	public const EyesRatatoskr: Transformation		= eyes.EyesRatatoskr.registerTf(AS_EYES, AE_SQUIRREL);
	public const EyesSandTrap: Transformation		= eyes.EyesSandTrap.registerTf(AS_EYES, AE_SAND_TRAP);
	public const EyesSnake: Transformation			= eyes.EyesSnake.registerTf(AS_EYES, AE_SNAKE);
	public const EyesSnakeFiendish: Transformation	= eyes.EyesSnakeFiendish.registerTf(AS_EYES, AE_APOPHIS);
	public const EyesSpider: Transformation			= eyes.EyesSpider.registerTf(AS_EYES, AE_SPIDER);
	public const EyesWeasel: Transformation			= eyes.EyesWeasel.registerTf(AS_EYES, AE_WEASEL);
    public const EyesVampire: Transformation		= eyes.EyesVampire.registerTf(AS_EYES, AE_VAMPIRE);
    public const EyesArigean: Transformation		= eyes.EyesArigean.registerTf(AS_EYES, AE_ARIGEAN);
    public const EyesDemon: Transformation			= eyes.EyesDemon.registerTf(AS_EYES, AE_DEMON);
    public const EyesMoth: Transformation           = eyes.EyesMoth.registerTf(AS_EYES, AE_MOTH);
    public const EyesGremlin: Transformation        = eyes.EyesGremlin.registerTf(AS_EYES, AE_GREMLIN);
//=================================
//                                =
//   EYE COLORS                   =
//                                =
//=================================
	public function EyesChangeColor(colors: /*String*/ Array): Transformation { return eyes.EyesChangeColor(colors);	}

	public const EyesAlrauneColors: Transformation 			= eyes.EyesAlrauneColors;
	public const EyesAlicornColors: Transformation 			= eyes.EyesAlicornColors;
	public const EyesAtlachColors: Transformation 			= eyes.EyesAtlachColors;
	public const EyesOniColors: Transformation	 			= eyes.EyesOniColors;
	public const EyesPlantColors: Transformation 			= eyes.EyesPlantColors;
	public const EyesGoblinColors: Transformation 			= eyes.EyesGoblinColors;
	public const EyesGremlinColors: Transformation 			= eyes.EyesGremlinColors;
	public const EyesRaijuColors: Transformation 			= eyes.EyesRaijuColors;
	public const EyesKirinColors: Transformation 			= eyes.EyesKirinColors;
	public const EyesKamaitachiColors: Transformation 		= eyes.EyesKamaitachiColors;
	public const EyesRatatoskrColors: Transformation 		= eyes.EyesRatatoskrColors;
	public const EyesRaccoonColors: Transformation 			= eyes.EyesRaccoonColors;
	public const EyesKrakenColors: Transformation 			= eyes.EyesKrakenColors;
	public const EyesSeadragonColors: Transformation 		= eyes.EyesSeadragonColors;
	public const EyesFireSnailColors: Transformation 		= eyes.EyesFireSnailColors;
	public const EyesFenrirColor: Transformation 			= eyes.EyesFenrirColor;
	public const EyesDemonColors: Transformation 			= eyes.EyesDemonColors;
	public const EyesSpiderAndMutagenInt: Transformation 	= eyes.EyesSpiderAndMutagenInt;


//FACE
//======================================================================================================================
//                                                                                                                    ==
//   ███████  █████   ██████ ███████                                                                                  ==
//   ██      ██   ██ ██      ██                                                                                       ==
//   █████   ███████ ██      █████                                                                                    ==
//   ██      ██   ██ ██      ██                                                                                       ==
//   ██      ██   ██  ██████ ███████                                                                                  ==
//                                                                                                                    ==
//======================================================================================================================
    public var face:FaceTransformations = new FaceTransformations();
    public const FaceHuman: Transformation 				= face.FaceHuman.registerTf(AS_FACE, AE_HUMAN);
    public const FaceHorse: Transformation 				= face.FaceHorse.registerTf(AS_FACE, AE_HORSE);
    public const FaceCerberus: Transformation 			= face.FaceCerberus.registerTf(AS_FACE, AE_CERBERUS);
    public const FaceDog: Transformation 				= face.FaceDog.registerTf(AS_FACE, AE_DOG);
    public const FaceCowMinotaur: Transformation 		= face.FaceCowMinotaur.registerTf(AS_FACE, AE_COW);
    public const FaceSharkTeeth: Transformation 		= face.FaceSharkTeeth.registerTfMultiple(AS_FACE, AE_SHARK< AE_WERESHARK);
    public const FaceSnakeFangs: Transformation 		= face.FaceSnakeFangs.registerTf(AS_FACE, AE_SNAKE);
    public const FaceCat: Transformation 				= face.FaceCat.registerTfMultiple(AS_FACE, AE_CAT, AE_DRAGONNE);
    public const FaceCatCanines: Transformation 		= face.FaceCatCanines.registerTfMultiple(AS_FACE, AE_CAT, AE_DRAGONNE);
    public const FaceLizard: Transformation 			= face.FaceLizard.registerTf(AS_FACE, AE_LIZARD);
    public const FaceBunny: Transformation 				= face.FaceBunny.registerTf(AS_FACE, AE_BUNNY);
    public const FaceKangaroo: Transformation 			= face.FaceKangaroo.registerTf(AS_FACE, AE_KANGAROO);
    public const FaceSpiderFangs: Transformation 		= face.FaceSpiderFangs.registerTf(AS_FACE, AE_SPIDER);
    public const FaceFox: Transformation 				= face.FaceFox.registerTf(AS_FACE, AE_FOX);
    public const FaceDragon: Transformation 			= face.FaceDragon.registerTf(AS_FACE, AE_DRAGON);
    public const FaceDragonFangs: Transformation 		= face.FaceDragonFangs.registerTf(AS_FACE, AE_DRAGON);
    public const FaceRaccoonMask: Transformation 		= face.FaceRaccoonMask.registerTf(AS_FACE, AE_RACCOON);
    public const FaceRaccoon: Transformation 			= face.FaceRaccoon.registerTf(AS_FACE, AE_RACCOON);
    public const FaceBuckteeth: Transformation 			= face.FaceBuckteeth.registerTf(AS_FACE, AE_MOUSE);
    public const FaceMouse: Transformation 				= face.FaceMouse.registerTf(AS_FACE, AE_MOUSE);
    public const FaceFerretMask: Transformation 		= face.FaceFerretMask.registerTf(AS_FACE, AE_FERRET);
    public const FaceFerret: Transformation 			= face.FaceFerret.registerTf(AS_FACE, AE_FERRET);
    public const FacePig: Transformation 				= face.FacePig.registerTf(AS_FACE, AE_PIG);
    public const FaceBoar: Transformation 				= face.FaceBoar.registerTf(AS_FACE, AE_BOAR);
    public const FaceRhino: Transformation 				= face.FaceRhino.registerTf(AS_FACE, AE_RHINO);
    public const FaceEchidna: Transformation 			= face.FaceEchidna.registerTf(AS_FACE, AE_ECHIDNA);
    public const FaceDeer: Transformation 				= face.FaceDeer.registerTfMultiple(AS_FACE, AE_DEER, AE_REINDEER);
    public const FaceWolf: Transformation 				= face.FaceWolf.registerTf(AS_FACE, AE_WOLF);
    public const FaceManticore: Transformation 			= face.FaceManticore.registerTf(AS_FACE, AE_MANTICORE);
    public const FaceSalamanderFangs: Transformation 	= face.FaceSalamanderFangs.registerTf(AS_FACE, AE_SALAMANDER);
    public const FaceYetiFangs: Transformation 			= face.FaceYetiFangs.registerTf(AS_FACE, AE_YETI);
    public const FaceOrca: Transformation 				= face.FaceOrca.registerTf(AS_FACE, AE_ORCA);
    public const FacePlantDragon: Transformation 		= face.FacePlantDragon.registerTf(AS_FACE, AE_YGGDRASIL);
    public const FaceDevilFangs: Transformation 		= face.FaceDevilFangs.registerTf(AS_FACE, AE_DEVIL);
    public const FaceInnocent: Transformation 			= face.FaceInnocent.registerTf(AS_FACE, AE_AZAZEL);
    public const FaceOniTeeth: Transformation 			= face.FaceOniTeeth.registerTf(AS_FACE, AE_ONI);
    public const FaceWeasel: Transformation 			= face.FaceWeasel.registerTf(AS_FACE, AE_WEASEL);
    public const FaceVampire: Transformation 			= face.FaceVampire.registerTf(AS_FACE, AE_VAMPIRE);
    public const FaceBucktooth: Transformation 			= face.FaceBucktooth.registerTf(AS_FACE, AE_JABBERWOCKY);
    public const FaceJabberwocky: Transformation 		= face.FaceJabberwocky.registerTf(AS_FACE, AE_JABBERWOCKY);
    public const FaceRedPanda: Transformation 			= face.FaceRedPanda.registerTf(AS_FACE, AE_RED_PANDA);
    public const FaceCheshire: Transformation 			= face.FaceCheshire.registerTf(AS_FACE, AE_CHESHIRE);
    public const FaceCheshireSmile: Transformation 		= face.FaceCheshireSmile.registerTf(AS_FACE, AE_CHESHIRE);
    public const FaceAvian: Transformation 				= face.FaceAvian.registerTf(AS_FACE, AE_AVIAN);
    public const FaceWolfFangs: Transformation 			= face.FaceWolfFangs.registerTf(AS_FACE, AE_WOLF);
    public const FaceOrcFangs: Transformation 			= face.FaceOrcFangs.registerTf(AS_FACE, AE_ORC);
    public const FaceAnimalTeeth: Transformation 		= face.FaceAnimalTeeth.registerTfMultiple(AS_FACE, AE_CENTIPEDE, AE_CYCLOP, AE_DEMON, AE_GAZER, AE_FROST_WYRM, AE_GOBLIN, AE_HARPY, AE_IMP, AE_KITSUNE, AE_MELKIE, AE_OOMUKADE, AE_WENDIGO, AE_WOLF).withAlchemyNames("Canines","Sharp canines");
    public const FaceBear: Transformation 				= face.FaceBear.registerTf(AS_FACE, AE_BEAR);
    public const FacePanda: Transformation 				= face.FacePanda.registerTf(AS_FACE, AE_PANDA);
    public const FaceFireSnail: Transformation 			= face.FaceFireSnail.registerTf(AS_FACE, AE_FIRE_SNAIL);
    public const FaceGhost: Transformation 				= face.FaceGhost.registerTf(AS_FACE, AE_GHOST);
    public const FaceJiangshi: Transformation 			= face.FaceJiangshi.registerTf(AS_FACE, AE_JIANGSHI);
    public const FaceYukiOnna: Transformation 			= face.FaceYukiOnna.registerTf(AS_FACE, AE_YUKI_ONNA);
    public const FaceKudere: Transformation 			= face.FaceKudere.registerTf(AS_FACE, AE_CANCER);
    public const FaceUshiOniOnna: Transformation 		= face.FaceUshiOniOnna.registerTf(AS_FACE, AE_USHI_ONI);
    public const FaceFairy: Transformation 				= face.FaceFairy.registerTf(AS_FACE, AE_FAIRY);
    public const FaceCrazy: Transformation 				= face.FaceCrazy.registerTf(AS_FACE, AE_GREMLIN);
    public const FaceSmug: Transformation 				= face.FaceSmug.registerTf(AS_FACE, AE_SQUIRREL);
    public const FaceSquirrel: Transformation 			= face.FaceSquirrel.registerTf(AS_FACE, AE_SQUIRREL);
    public const FaceElf: Transformation 				= face.FaceElf.registerTf(AS_FACE, AE_ELF);
    public const FaceAnt: Transformation 				= face.FaceAnt.registerTf(AS_FACE, AE_ANT);
    public const FaceFoxFangs: Transformation 			= face.FaceFoxFangs.registerTf(AS_FACE, AE_WEREFOX);
    public const FaceAbyssalShark: Transformation 		= face.FaceAbyssalShark.registerTf(AS_FACE, AE_ABYSSAL_SHARK);
    public const FaceArigean: Transformation 			= face.FaceArigean.registerTf(AS_FACE, AE_ARIGEAN);
    public const FaceDemon: Transformation 				= face.FaceDemon.registerTf(AS_FACE, AE_DEMON);
    public const FaceTroll: Transformation 				= face.FaceTroll.registerTf(AS_FACE, AE_TROLL);
    public const FaceGlacialTroll: Transformation 		= face.FaceGlacialTroll.registerTf(AS_FACE, AE_GLACIAL_TROLL);


//GILLS
//======================================================================================================================
//                                                                                                                    ==
//      ██████  ██ ██      ██      ███████                                                                            ==
//     ██       ██ ██      ██      ██                                                                                 ==
//     ██   ███ ██ ██      ██      ███████                                                                            ==
//     ██    ██ ██ ██      ██           ██                                                                            ==
//      ██████  ██ ███████ ███████ ███████                                                                            ==
//                                                                                                                    ==
//======================================================================================================================
    public var gills:GillsTransformations = new GillsTransformations();
    public const GillsNone: Transformation 				= gills.GillsNone.registerTf(AS_GILLS, AE_REMOVE);
    public const GillsFish: Transformation 				= gills.GillsFish.registerTfMultiple(AS_GILLS, AE_SHARK, AE_SIREN, AE_ABYSSAL_SHARK, AE_WERESHARK);
    public const GillsAnemone: Transformation 			= gills.GillsAnemone.registerTf(AS_GILLS, AE_ANEMONE);
    public const GillsInTentacleLegs: Transformation 	= gills.GillsInTentacleLegs.registerTf(AS_GILLS, AE_SCYLLA);


//HAIR
//======================================================================================================================
//                                                                                                                    ==
//    ██   ██  █████  ██████ ██████                                                                                   ==
//    ██   ██ ██   ██   ██   ██   ██                                                                                  ==
//    ███████ ███████   ██   ██████                                                                                   ==
//    ██   ██ ██   ██   ██   ██   ██                                                                                  ==
//    ██   ██ ██   ██ ██████ ██   ██                                                                                  ==
//                                                                                                                    ==
//======================================================================================================================
    public var hair: HairTransformations = new HairTransformations();
    public const HairHuman: Transformation 		= hair.HairHuman.registerTf(AS_HAIR, AE_HUMAN);
    public const HairFeather: Transformation 	= hair.HairFeather.registerTfMultiple(AS_HAIR, AE_AVIAN, AE_GRYPHON);
    public const HairGorgon: Transformation 	= hair.HairGorgon.registerTf(AS_HAIR, AE_GORGON);
    public const HairSilky: Transformation 		= hair.HairSilky.registerTf(AS_HAIR, AE_ELF);
    public const HairStorm: Transformation 		= hair.HairStorm.registerTfMultiple(AS_HAIR, AE_RAIJU, AE_KIRIN, AE_THUNDERBIRD).withAlchemyNames("StormHair","Storm hair");
    public const HairBurning: Transformation 	= hair.HairBurning.registerTfMultiple(AS_HAIR, AE_FIRE_SNAIL, AE_HELLCAT, AE_HINEZUMI).withAlchemyNames("BurningHair", "Burning hair");
    public const HairSnowy: Transformation 		= hair.HairSnowy.registerTf(AS_HAIR, AE_YUKI_ONNA);
    public const HairLeaf: Transformation 		= hair.HairLeaf.registerTfMultiple(AS_HAIR, AE_PLANT, AE_ALRAUNE, AE_YGGDRASIL);
    public const HairGrass: Transformation 		= hair.HairGrass.registerTfMultiple(AS_HAIR, AE_PLANT, AE_ALRAUNE, AE_YGGDRASIL);
    public const HairGoo: Transformation 		= hair.HairGoo.registerTf(AS_HAIR, AE_GOO);
    public const HairGhost: Transformation 		= hair.HairGhost.registerTf(AS_HAIR, AE_GHOST);
    public const HairRatatoskr: Transformation 	= hair.HairRatatoskr.registerTf(AS_HAIR, AE_SQUIRREL);
    public const HairWindswept: Transformation 	= hair.HairWindswept.registerTf(AS_HAIR, AE_KAMAITACHI);
    public const HairWild: Transformation 		= hair.HairWild;
    public const HairAnemone: Transformation 	= hair.HairAnemone.registerTf(AS_HAIR, AE_ANEMONE);
    public const HairFluffy: Transformation 	= hair.HairFluffy.registerTf(AS_HAIR, AE_YETI);
    public const HairCrazy: Transformation 		= hair.HairCrazy.registerTf(AS_HAIR, AE_GREMLIN);
    public const HairPrismatic: Transformation 	= hair.HairPrismatic.registerTf(AS_HAIR, AE_SEA_DRAGON);
    public const HairQuill: Transformation 		= hair.HairQuill.registerTf(AS_HAIR, AE_ECHIDNA);
    public const HairFairy: Transformation 		= hair.HairFairy.registerTf(AS_HAIR, AE_FAIRY);
    public const HairCow: Transformation 		= hair.HairCow.registerTf(AS_HAIR, AE_COW);
    public const HairDripping: Transformation 	= hair.HairDripping.registerTf(AS_HAIR, AE_SAND_WORM);
    public const HairPeafowlFeather: Transformation = hair.HairPeafowlFeather.registerTf(AS_HAIR, AE_PEAFOWL);
    public function HairChangeColor(colors: /*String*/ Array): Transformation { return hair.HairChangeColor(colors); }


//HORNS
//======================================================================================================================
//                                                                                                                    ==
//    ██    ██  ██████  ██████  ███    ██ ███████                                                                     ==
//    ██    ██ ██    ██ ██   ██ ████   ██ ██                                                                          ==
//    ████████ ██    ██ ██████  ██ ██  ██ ███████                                                                     ==
//    ██    ██ ██    ██ ██   ██ ██  ██ ██      ██                                                                     ==
//    ██    ██  ██████  ██   ██ ██   ████ ███████                                                                     ==
//                                                                                                                    ==
//======================================================================================================================
    public var horns: HornsTransformations = new HornsTransformations();
    public const HornsNone: Transformation 					= horns.HornsNone.registerTfMultiple(AS_HORNS, AE_REMOVE, AE_KITSUNE);
    public const HornsBicorn: Transformation 				= horns.HornsBicorn.registerTf(AS_HORNS, AE_BICORN);
    public const HornsUnicorn: Transformation 				= horns.HornsUnicorn.registerTf(AS_HORNS, AE_UNICORN);
    public const HornsKirin: Transformation 				= horns.HornsKirin.registerTf(AS_HORNS, AE_KIRIN);
    public const HornsOniDual: Transformation 				= horns.HornsOniDual.registerTf(AS_HORNS, AE_ONI);
    public const HornsOni: Transformation 					= horns.HornsOni.registerTf(AS_HORNS, AE_ONI);
    public const HornsGoat: Transformation 					= horns.HornsGoat.registerTf(AS_HORNS, AE_GOAT);
    public const HornsGoatQuadruple: Transformation 		= horns.HornsGoatQuadruple.registerTf(AS_HORNS, AE_GOAT);
    public const HornsDraconicQuadruple: Transformation 	= horns.HornsDraconicQuadruple.registerTf(AS_HORNS, AE_DRAGON);
    public const HornsDraconicDual: Transformation 			= horns.HornsDraconicDual.registerTf(AS_HORNS, AE_DRAGON);
    public const HornsCowMinotaur: Transformation 			= horns.HornsCowMinotaur.registerTf(AS_HORNS, AE_COW);
    public const HornsDemonic: Transformation 				= horns.HornsDemonic.registerTf(AS_HORNS, AE_DEMON);
    public const HornsAntlers: Transformation 				= horns.HornsAntlers.registerTfMultiple(AS_HORNS, AE_DEER, AE_REINDEER, AE_WENDIGO);
    public const HornsAntlersWendigo: Transformation 		= horns.HornsAntlersWendigo.registerTf(AS_HORNS, AE_WENDIGO);
    public const HornsGhostlyWisps: Transformation 			= horns.HornsGhostlyWisps.registerTf(AS_HORNS, AE_GHOST);
    public const HornsOak: Transformation 					= horns.HornsOak.registerTfMultiple(AS_HORNS, AE_PLANT, AE_YGGDRASIL);
    public const HornsOrchid: Transformation 				= horns.HornsOrchid.registerTf(AS_HORNS, AE_PLANT);
    public const HornsKraken: Transformation 				= horns.HornsKraken.registerTf(AS_HORNS, AE_KRAKEN);
    public const HornsSeadragon: Transformation 			= horns.HornsSeadragon.registerTf(AS_HORNS, AE_SEA_DRAGON);
    public const HornsFrostwyrm: Transformation 			= horns.HornsFrostwyrm.registerTf(AS_HORNS, AE_FROST_WYRM);
    public const HornsJabberwocky: Transformation 			= horns.HornsJabberwocky.registerTf(AS_HORNS, AE_JABBERWOCKY);
    public const HornsUshiOni: Transformation 				= horns.HornsUshiOni.registerTf(AS_HORNS, AE_USHI_ONI);
    public const HornsJiangshi: Transformation 				= horns.HornsJiangshi.registerTf(AS_HORNS, AE_JIANGSHI);
    public const HornsArchImp: Transformation 				= horns.HornsArchImp.registerTf(AS_HORNS, AE_IMP);


//LOWER BODY ( LEGS )
//======================================================================================================================
//                                                                                                                    ==
//  ██       ██████  ██       ██ ███████ ██████      ██████   ██████  ██████  ██    ██                                ==
//  ██      ██    ██ ██       ██ ██      ██   ██     ██   ██ ██    ██ ██   ██  ██  ██                                 ==
//  ██      ██    ██ ██  ███  ██ █████   ██████      ██████  ██    ██ ██   ██    ██                                   ==
//  ██      ██    ██ ██ ██ ██ ██ ██      ██   ██     ██   ██ ██    ██ ██   ██    ██                                   ==
//  ███████  ██████  ████   ████ ███████ ██   ██     ██████   ██████  ██████     ██                                   ==
//                                                                                                                    ==
//======================================================================================================================

    public var lowerBody:LowerBodyTransformations = new LowerBodyTransformations();
    public function LowerBodyTaur(lowerBodyType: int = undefined): Transformation 				{ return lowerBody.LowerBodyTaur(lowerBodyType); }
    public function LowerBodyWolf(legCount: int = undefined): Transformation 					{ return lowerBody.LowerBodyWolf(legCount); }
	public const LowerBodyWolfBipedal:Transformation = LowerBodyWolf(2).registerTf(AS_LEGS, AE_WOLF);
    public function LowerBodyWolfToggle(toggleTaur:Boolean = false): Transformation 			{ return lowerBody.LowerBodyWolf(player.legCount, toggleTaur); }
    public function LowerBodyHoofed(legCount: int = undefined): Transformation 					{ return lowerBody.LowerBodyHoofed(legCount); }
	public const LowerBodyHoofedBipedal:Transformation = LowerBodyHoofed(2).registerTf(AS_LEGS, AE_HORSE);
    public function LowerBodyHoofedToggle(toggleTaur:Boolean = false): Transformation 			{ return lowerBody.LowerBodyHoofed(player.legCount, toggleTaur); }
    public function LowerBodyKirin(legCount: int = undefined): Transformation 					{ return lowerBody.LowerBodyKirin(legCount); }
	public const LowerBodyKirinBipedal:Transformation = LowerBodyKirin(2).registerTf(AS_LEGS, AE_KIRIN);
    public function LowerBodyKirinToggle(toggleTaur:Boolean = false): Transformation 			{ return lowerBody.LowerBodyKirin(player.legCount, toggleTaur); }
    public function LowerBodyCat(legCount: int = undefined): Transformation 					{ return lowerBody.LowerBodyCat(legCount); }
	public const LowerBodyCatBipedal:Transformation = LowerBodyCat(2).registerTfMultiple(AS_LEGS, AE_CAT, AE_DRAGONNE);
    public function LowerBodyCatToggle(toggleTaur:Boolean = false): Transformation 				{ return lowerBody.LowerBodyCat(player.legCount, toggleTaur); }
    public function LowerBodyLizard(legCount: int = undefined): Transformation 					{ return lowerBody.LowerBodyLizard(legCount); }
	public const LowerBodyLizardBipedal:Transformation = LowerBodyLizard(2).registerTf(AS_LEGS, AE_LIZARD);
    public function LowerBodyLizardToggle(toggleTaur:Boolean = false): Transformation 			{ return lowerBody.LowerBodyLizard(player.legCount, toggleTaur); }
    public function LowerBodyFox(legCount: int = undefined): Transformation 					{ return lowerBody.LowerBodyFox(legCount); }
	public const LowerBodyFoxBipedal:Transformation = LowerBodyFox(2).registerTf(AS_LEGS, AE_FOX);
    public function LowerBodyFoxToggle(toggleTaur:Boolean = false): Transformation 				{ return lowerBody.LowerBodyFox(player.legCount, toggleTaur); }
    public function LowerBodyDraconic(legCount: int = undefined): Transformation 				{ return lowerBody.LowerBodyDraconic(legCount); }
	public const LowerBodyDraconicBipedal:Transformation = LowerBodyDraconic(2).registerTf(AS_LEGS, AE_DRAGON);
    public function LowerBodyDraconicToggle(toggleTaur:Boolean = false): Transformation 		{ return lowerBody.LowerBodyDraconic(player.legCount, toggleTaur); }
    public function LowerBodyFeyDraconic(legCount: int = undefined): Transformation 			{ return lowerBody.LowerBodyFeyDraconic(legCount); }
	public const LowerBodyFeyDraconicBipedal:Transformation = LowerBodyFeyDraconic(2).registerTf(AS_LEGS, AE_FAERIE_DRAGON);
    public function LowerBodyFeyDraconicToggle(toggleTaur:Boolean = false): Transformation 		{ return lowerBody.LowerBodyFeyDraconic(player.legCount, toggleTaur); }
    public function LowerBodyClovenHoofed(legCount: int = undefined): Transformation 			{ return lowerBody.LowerBodyClovenHoofed(legCount); }
    public const LowerBodyClovenHoofedBipedal:Transformation = LowerBodyClovenHoofed(2).registerTf(AS_LEGS, AE_DEER);
    public function LowerBodyClovenHoofedToggle(toggleTaur:Boolean = false): Transformation 	{ return lowerBody.LowerBodyClovenHoofed(player.legCount, toggleTaur); }
    public function LowerBodyReindeer(legCount: int = undefined): Transformation 			{ return lowerBody.LowerBodyReindeer(legCount); }
    public const LowerBodyReindeerBipedal:Transformation = LowerBodyReindeer(2).registerTf(AS_LEGS, AE_REINDEER);
    public function LowerBodyReindeerToggle(toggleTaur:Boolean = false): Transformation 	{ return lowerBody.LowerBodyReindeer(player.legCount, toggleTaur); }
    public function LowerBodySalamander(legCount: int = undefined): Transformation 				{ return lowerBody.LowerBodySalamander(legCount); }
	public const LowerBodySalamanderBipedal:Transformation = LowerBodySalamander(2).registerTf(AS_LEGS, AE_SALAMANDER);
    public function LowerBodySalamanderToggle(toggleTaur:Boolean = false): Transformation 		{ return lowerBody.LowerBodySalamander(player.legCount, toggleTaur); }
    public function LowerBodyMantis(legCount: int = undefined): Transformation 					{ return lowerBody.LowerBodyMantis(legCount); }
	public const LowerBodyMantisBipedal:Transformation = LowerBodyMantis(2).registerTf(AS_LEGS, AE_MANTIS);
    public function LowerBodyMantisToggle(toggleTaur:Boolean = false): Transformation 			{ return lowerBody.LowerBodyMantis(player.legCount, toggleTaur); }
    public function LowerBodyShark(legCount: int = undefined): Transformation 					{ return lowerBody.LowerBodyShark(legCount); }
	public const LowerBodySharkBipedal:Transformation = LowerBodyShark(2).registerTf(AS_LEGS, AE_SHARK);
    public function LowerBodySharkToggle(toggleTaur:Boolean = false): Transformation 			{ return lowerBody.LowerBodyShark(player.legCount, toggleTaur); }
    public function LowerBodyLion(legCount: int = undefined): Transformation 					{ return lowerBody.LowerBodyLion(legCount); }
	public const LowerBodyLionBipedal:Transformation = LowerBodyLion(2).registerTf(AS_LEGS, AE_LION);
    public function LowerBodyLionToggle(toggleTaur:Boolean = false): Transformation 			{ return lowerBody.LowerBodyLion(player.legCount, toggleTaur); }
    public function LowerBodyOrca(legCount: int = undefined): Transformation 					{ return lowerBody.LowerBodyOrca(legCount); }
	public const LowerBodyOrcaBipedal:Transformation = LowerBodyOrca(2).registerTf(AS_LEGS, AE_ORCA);
    public function LowerBodyOrcaToggle(toggleTaur:Boolean = false): Transformation 			{ return lowerBody.LowerBodyOrca(player.legCount, toggleTaur); }
    public function LowerBodyRaiju(legCount: int = undefined): Transformation 					{ return lowerBody.LowerBodyRaiju(legCount); }
	public const LowerBodyRaijuBipedal:Transformation = LowerBodyRaiju(2).registerTf(AS_LEGS, AE_RAIJU);
    public function LowerBodyRaijuToggle(toggleTaur:Boolean = false): Transformation 			{ return lowerBody.LowerBodyRaiju(player.legCount, toggleTaur); }
    public function LowerBodyDog(legCount: int = undefined): Transformation 					{ return lowerBody.LowerBodyDog(legCount); }
	public const LowerBodyDogBipedal:Transformation = LowerBodyDog(2).registerTf(AS_LEGS, AE_DOG);
    public function LowerBodyDogToggle(toggleTaur:Boolean = false): Transformation 				{ return lowerBody.LowerBodyDog(player.legCount, toggleTaur); }
    public function LowerBodyWeasel(legCount: int = undefined): Transformation 					{ return lowerBody.LowerBodyWeasel(legCount); }
	public const LowerBodyWeaselBipedal:Transformation = LowerBodyWeasel(2).registerTf(AS_LEGS, AE_WEASEL);
    public function LowerBodyWeaselToggle(toggleTaur:Boolean = false): Transformation 			{ return lowerBody.LowerBodyWeasel(player.legCount, toggleTaur); }
    public function LowerBodyBear(legCount: int = undefined): Transformation 					{ return lowerBody.LowerBodyBear(legCount); }
	public const LowerBodyBearBipedal:Transformation = LowerBodyBear(2).registerTf(AS_LEGS, AE_BEAR);
    public function LowerBodyBearToggle(toggleTaur:Boolean = false): Transformation 			{ return lowerBody.LowerBodyBear(player.legCount, toggleTaur); }
    public function LowerBodySeaDragon(legCount: int = undefined): Transformation 				{ return lowerBody.LowerBodySeaDragon(legCount); }
	public const LowerBodySeaDragonBipedal:Transformation = LowerBodySeaDragon(2).registerTf(AS_LEGS, AE_SEA_DRAGON);
    public function LowerBodySeaDragonToggle(toggleTaur:Boolean = false): Transformation 		{ return lowerBody.LowerBodySeaDragon(player.legCount, toggleTaur); }
    public function LowerBodyGryphon(legCount: int = undefined): Transformation 				{ return lowerBody.LowerBodyGryphon(legCount); }
	public const LowerBodyGryphonBipedal:Transformation = LowerBodyGryphon(2).registerTf(AS_LEGS, AE_GRYPHON);
    public function LowerBodyGryphonToggle(toggleTaur:Boolean = false): Transformation 			{ return lowerBody.LowerBodyGryphon(player.legCount, toggleTaur); }
    public const LowerBodyAnt: Transformation 					= lowerBody.LowerBodyAnt.registerTf(AS_LEGS, AE_ANT);
    public const LowerBodyAtlach: Transformation 				= lowerBody.LowerBodyAtlach.registerTf(AS_LEGS, AE_ATLACH_NACHA);
    public const LowerBodyAtlachNacha: Transformation 			= lowerBody.LowerBodyAtlachNacha.registerTf(AS_LEGS, AE_ATLACH_NACHA);
    public const LowerBodyBee: Transformation 					= lowerBody.LowerBodyBee.registerTf(AS_LEGS, AE_BEE);
    public const LowerBodyBipedal: Transformation 				= lowerBody.LowerBodyBipedal;
    public const LowerBodyCentipede: Transformation 			= lowerBody.LowerBodyCentipede.registerTf(AS_LEGS, AE_CENTIPEDE);
    public const LowerBodyDemonClawed: Transformation 			= lowerBody.LowerBodyDemonClawed.registerTf(AS_LEGS, AE_DEMON);
    public const LowerBodyDemonHighHeels: Transformation 		= lowerBody.LowerBodyDemonHighHeels.registerTf(AS_LEGS, AE_DEMON);
    public const LowerBodyDrider: Transformation 				= lowerBody.LowerBodyDrider.registerTf(AS_LEGS, AE_DRIDER);
    public const LowerBodyElf: Transformation 					= lowerBody.LowerBodyElf.registerTf(AS_LEGS, AE_ELF);
    public const LowerBodyFerret: Transformation 				= lowerBody.LowerBodyFerret.registerTf(AS_LEGS, AE_FERRET);
    public const LowerBodyGoo: Transformation 					= lowerBody.LowerBodyGoo.registerTf(AS_LEGS, AE_GOO);
    public const LowerBodyHarpy: Transformation 				= lowerBody.LowerBodyHarpy.registerTf(AS_LEGS, AE_HARPY);
    public const LowerBodyHuman: Transformation 				= lowerBody.LowerBodyHuman.registerTf(AS_LEGS, AE_HUMAN);
    public const LowerBodyJiangshi: Transformation 				= lowerBody.LowerBodyJiangshi.registerTf(AS_LEGS, AE_JIANGSHI);
    public const LowerBodyOni: Transformation 					= lowerBody.LowerBodyOni.registerTf(AS_LEGS, AE_ONI);
    public const LowerBodyOrc: Transformation 					= lowerBody.LowerBodyOrc.registerTf(AS_LEGS, AE_ORC);
    public const LowerBodyPlantFlower: Transformation 			= lowerBody.LowerBodyPlantFlower.registerTf(AS_LEGS, AE_PLANT);
    public const LowerBodyPlantHighHeels: Transformation 		= lowerBody.LowerBodyPlantHighHeels.registerTf(AS_LEGS, AE_PLANT);
    public const LowerBodyPlantRootClaws: Transformation 		= lowerBody.LowerBodyPlantRootClaws.registerTf(AS_LEGS, AE_PLANT);
    public const LowerBodyRedPanda: Transformation 				= lowerBody.LowerBodyRedPanda.registerTf(AS_LEGS, AE_RED_PANDA);
    public const LowerBodySpider: Transformation 				= lowerBody.LowerBodySpider.registerTf(AS_LEGS, AE_SPIDER);
    public const LowerBodyWendigo: Transformation 				= lowerBody.LowerBodyWendigo.registerTf(AS_LEGS, AE_WENDIGO);
    public const LowerBodyYukiOnna: Transformation 				= lowerBody.LowerBodyYukiOnna.registerTf(AS_LEGS, AE_YUKI_ONNA);
    public const LowerBodyScylla: Transformation 				= lowerBody.LowerBodyScylla.registerTf(AS_LEGS, AE_SCYLLA);
    public const LowerBodyKraken: Transformation 				= lowerBody.LowerBodyKraken.registerTf(AS_LEGS, AE_KRAKEN);
    public const LowerBodyHydra: Transformation 				= lowerBody.LowerBodyHydra.registerTf(AS_LEGS, AE_HYDRA);
    public const LowerBodyAvian: Transformation 				= lowerBody.LowerBodyAvian.registerTf(AS_LEGS, AE_AVIAN);
    public const LowerBodyMelkie: Transformation 				= lowerBody.LowerBodyMelkie.registerTf(AS_LEGS, AE_MELKIE);
    public const LowerBodyUshiOni: Transformation 				= lowerBody.LowerBodyUshiOni.registerTf(AS_LEGS, AE_USHI_ONI);
    public const LowerBodyMouse: Transformation 				= lowerBody.LowerBodyMouse.registerTf(AS_LEGS, AE_MOUSE);
    public const LowerBodyHinezumi: Transformation 				= lowerBody.LowerBodyHinezumi.registerTf(AS_LEGS, AE_HINEZUMI);
    public const LowerBodyYeti: Transformation 					= lowerBody.LowerBodyYeti.registerTf(AS_LEGS, AE_YETI);
    public const LowerBodyGhost: Transformation 				= lowerBody.LowerBodyGhost.registerTf(AS_LEGS, AE_GHOST);
    public const LowerBodyGhost2: Transformation 				= lowerBody.LowerBodyGhost2.registerTf(AS_LEGS, AE_GHOST);
    public const LowerBodyGazer: Transformation 				= lowerBody.LowerBodyGazer.registerTf(AS_LEGS, AE_GAZER);
    public const LowerBodyFireSnail: Transformation 			= lowerBody.LowerBodyFireSnail.registerTf(AS_LEGS, AE_FIRE_SNAIL);
    public const LowerBodyFrostwyrm: Transformation 			= lowerBody.LowerBodyFrostwyrm.registerTf(AS_LEGS, AE_FROST_WYRM);
    public const LowerBodyRaccoon: Transformation 				= lowerBody.LowerBodyRaccoon.registerTf(AS_LEGS, AE_RACCOON);
    public const LowerBodySquirrel: Transformation 				= lowerBody.LowerBodySquirrel.registerTf(AS_LEGS, AE_SQUIRREL);
    public const LowerBodyKangaroo: Transformation 				= lowerBody.LowerBodyKangaroo.registerTf(AS_LEGS, AE_KANGAROO);
    public const LowerBodyCaveWyrm: Transformation 				= lowerBody.LowerBodyCaveWyrm.registerTf(AS_LEGS, AE_CAVE_WYRM);
    public const LowerBodyBunny: Transformation 				= lowerBody.LowerBodyBunny.registerTf(AS_LEGS, AE_BUNNY);
    public const LowerBodyJabberwocky: Transformation 			= lowerBody.LowerBodyJabberwocky.registerTf(AS_LEGS, AE_JABBERWOCKY);
    public const LowerBodyCrab: Transformation 					= lowerBody.LowerBodyCrab.registerTf(AS_LEGS, AE_CANCER);
    public const LowerBodyCancer: Transformation 				= lowerBody.LowerBodyCancer.registerTf(AS_LEGS, AE_CANCER);
    public const LowerBodySnake: Transformation 				= lowerBody.LowerBodySnake.registerTf(AS_LEGS, AE_SNAKE);
    public const LowerBodyTiny: Transformation 			    	= lowerBody.LowerBodyTiny.registerTf(AS_LEGS, AE_IMP);
    public const LowerBodyWorm: Transformation 			    	= lowerBody.LowerBodyWorm.registerTf(AS_LEGS, AE_SAND_WORM);
    public const LowerBodyAbyssalShark: Transformation 			= lowerBody.LowerBodyAbyssalShark.registerTf(AS_LEGS, AE_ABYSSAL_SHARK);
    public const LowerBodyWereshark: Transformation 			= lowerBody.LowerBodyWereshark.registerTf(AS_LEGS, AE_WERESHARK);
    public const LowerBodyYgddrasilRootClaws: Transformation	= lowerBody.LowerBodyYgddrasilRootClaws.registerTf(AS_LEGS, AE_YGGDRASIL);
    public const LowerBodyArigean: Transformation 				= lowerBody.LowerBodyArigean.registerTf(AS_LEGS, AE_ARIGEAN);
    public const LowerBodyDemonGracefulFeet: Transformation 	= lowerBody.LowerBodyDemonGracefulFeet.registerTf(AS_LEGS, AE_DEMON);
    public const LowerBodyMoth:Transformation                   = lowerBody.LowerBodyMoth.registerTf(AS_LEGS, AE_MOTH);
    public const LowerBodyTroll:Transformation                  = lowerBody.LowerBodyTroll.registerTf(AS_LEGS, AE_TROLL);
    public const LowerBodyGlacialTroll:Transformation           = lowerBody.LowerBodyGlacialTroll.registerTf(AS_LEGS, AE_GLACIAL_TROLL);


//OTHER ( SPECIAL )
//======================================================================================================================
//                                                                                                                    ==
// 	   █████  ████████ ██    ██ ██████ ██████                                                                         ==
// 	 ██    ██    ██    ██    ██ ██     ██   ██                                                                        ==
// 	 ██    ██    ██    ████████ █████  ██████                                                                         ==
// 	 ██    ██    ██    ██    ██ ██     ██   ██                                                                        ==
// 	  ██████     ██    ██    ██ ██████ ██   ██                                                                        ==
//                                                                                                                    ==
//======================================================================================================================
        public var special:SpecialTransformations = new SpecialTransformations();
        public const RemoveOvipositor:Transformation 		= special.RemoveOvipositor;
        public const GainOvipositor:Transformation 			= special.GainOvipositor;
        public const OvipositorBee:Transformation 			= special.OvipositorBee;
        public const OvipositorSpider:Transformation 		= special.OvipositorSpider;
        public const OvipositorMantis:Transformation 		= special.OvipositorMantis;
        public const OvipositorAnt:Transformation 			= special.OvipositorAnt;
        public const RemoveOviposition:Transformation 		= special.RemoveOviposition;
        public const GainOviposition:Transformation 		= special.GainOviposition;
        public const AssholeGlowing:Transformation 			= special.AssholeGlowing;
        public const AssholeNormal:Transformation 			= special.AssholeNormal;


//REAR BODY
//======================================================================================================================
//                                                                                                                    ==
//   ██████  ███████  █████  ██████      ██████   ██████  ██████  ██    ██                                            ==
//   ██   ██ ██      ██   ██ ██   ██     ██   ██ ██    ██ ██   ██  ██  ██                                             ==
//   ██████  █████   ███████ ██████      ██████  ██    ██ ██   ██    ██                                               ==
//   ██   ██ ██      ██   ██ ██   ██     ██   ██ ██    ██ ██   ██    ██                                               ==
//   ██   ██ ███████ ██   ██ ██   ██     ██████   ██████  ██████     ██                                               ==
//                                                                                                                    ==
//======================================================================================================================
	public var rearBody:RearBodyTransformations = new RearBodyTransformations();
	public const RearBodyNone: Transformation 				= rearBody.RearBodyNone.registerTf(AS_REAR, AE_NONE);
	public const RearBodyLionMane: Transformation 			= rearBody.RearBodyLionMane.registerTfMultiple(AS_REAR, AE_LION, AE_DRAGONNE);
	public const RearBodyDisplacerTentacles: Transformation = rearBody.RearBodyDisplacerTentacles.registerTf(AS_REAR, AE_DISPLACER_BEAST);
	public const RearBodyBatCollar: Transformation 			= rearBody.RearBodyBatCollar.registerTf(AS_REAR, AE_BAT);
	public const RearBodyRaijuMane: Transformation 			= rearBody.RearBodyRaijuMane.registerTf(AS_REAR, AE_RAIJU);
	public const RearBodyOrcaBlowhole: Transformation 		= rearBody.RearBodyOrcaBlowhole.registerTf(AS_REAR, AE_ORCA);
	public const RearBodySharkFin: Transformation 			= rearBody.RearBodySharkFin.registerTfMultiple(AS_REAR, AE_SHARK, AE_WERESHARK);
	public const RearBodyMetamorphicGoo: Transformation 	= rearBody.RearBodyMetamorphicGoo.registerTf(AS_REAR, AE_GOO);
	public const RearBodyGhostlyAura: Transformation 		= rearBody.RearBodyGhostlyAura.registerTf(AS_REAR, AE_GHOST);
	public const RearBodyTentacleEyestalks: Transformation 	= rearBody.RearBodyTentacleEyestalks.registerTf(AS_REAR, AE_GAZER);
	public const RearBodyKraken: Transformation 			= rearBody.RearBodyKraken.registerTf(AS_REAR, AE_KRAKEN);
	public const RearBodyYetiFur: Transformation 			= rearBody.RearBodyYetiFur.registerTf(AS_REAR, AE_YETI);
	public const RearBodyGlacialAura: Transformation 		= rearBody.RearBodyGlacialAura.registerTf(AS_REAR, AE_YUKI_ONNA);
	public const RearBodyFrostwyrm: Transformation 			= rearBody.RearBodyFrostwyrm.registerTf(AS_REAR, AE_FROST_WYRM);
	public const RearBodySnailShell: Transformation 		= rearBody.RearBodySnailShell.registerTf(AS_REAR, AE_FIRE_SNAIL);
	public const RearBodyCentipede: Transformation 			= rearBody.RearBodyCentipede.registerTf(AS_REAR, AE_CENTIPEDE);
	public const RearBodyFenrirIceSpikes: Transformation 	= rearBody.RearBodyFenrirIceSpikes.registerTf(AS_REAR, AE_FENRIR);
	public const RearBodyFurCoat: Transformation 			= rearBody.RearBodyFurCoat.registerTf(AS_REAR, AE_WENDIGO);
	public const RearBodyAtlachNacha: Transformation 		= rearBody.RearBodyAtlachNacha.registerTf(AS_REAR, AE_ATLACH_NACHA);
	public const RearBodyCobraHood: Transformation 			= rearBody.RearBodyCobraHood.registerTf(AS_REAR, AE_APOPHIS);
	public const RearBodyWolfCollar: Transformation 		= rearBody.RearBodyWolfCollar.registerTfMultiple(AS_REAR, AE_WOLF, AE_WEREWOLF, AE_WEREFOX);
	public const RearBodyHellhoundCollar: Transformation 	= rearBody.RearBodyHellhoundCollar.registerTf(AS_REAR, AE_CERBERUS);
	public const RearBodyAbyssalSharkFin: Transformation 	= rearBody.RearBodyAbyssalSharkFin.registerTf(AS_REAR, AE_ABYSSAL_SHARK);
	public const RearBodyArigeanAuraRed: Transformation 	= rearBody.RearBodyArigeanAuraRed.registerTf(AS_REAR, AE_ARIGEAN);
	public const RearBodyArigeanAuraYellow: Transformation 	= rearBody.RearBodyArigeanAuraYellow.registerTf(AS_REAR, AE_ARIGEAN);
    public const RearBodyMoth: Transformation               = rearBody.RearBodyMoth.registerTf(AS_REAR, AE_MOTH);


//SKIN
//======================================================================================================================
//                                                                                                                    ==
//   ███████ ██   ██ ██ ███    ██                                                                                     ==
//   ██      ██  ██  ██ ████   ██                                                                                     ==
//   ███████ █████   ██ ██ ██  ██                                                                                     ==
//        ██ ██  ██  ██ ██  ██ ██                                                                                     ==
//   ███████ ██   ██ ██ ██   ████                                                                                     ==
//                                                                                                                    ==
//======================================================================================================================
    public var skin: SkinTransformations = new SkinTransformations();
    public function SkinColor(colors: /*String*/ Array): Transformation { return skin.SkinColor(colors); }
	public const SkinPlain:Transformation = skin.SkinPlain.registerTfMultiple(AS_SKIN,
			AE_HUMAN, AE_ELF, AE_FAIRY, AE_GAZER, AE_GOBLIN, AE_GREMLIN, AE_IMP, AE_KITSUNE, AE_OOMUKADE, AE_ORC, AE_ORCA)
												.withAlchemyNames("PlainSkin", "Plain skin");
    public const SkinSlippery: Transformation = skin.SkinSlippery;
    public const SkinTransparent: Transformation = skin.SkinTransparent.registerTfMultiple(AS_SKIN,
			AE_POLTERGEIST)
													   .withAlchemyNames("Transp.Skin", "Transparent skin");
    /**
     * @param options = {color/colors,color2/colors2,pattern,adj,desc}
     */
    public function SkinFur(coverage: int = Skin.COVERAGE_COMPLETE, options: * = null): Transformation 					{ return skin.SkinFur(coverage, options); }
    public function SkinFurGradual(coverage:int = Skin.COVERAGE_COMPLETE, options:* = null):Transformation 				{ return skin.SkinFurGradual(coverage, options); }
	public const SkinFurGradualToFull:Transformation = SkinFurGradual().registerTfMultiple(AS_SKIN,
			AE_AZAZEL, AE_BEAR, AE_BUNNY, AE_CAT, AE_CERBERUS, AE_COW, AE_DEER, AE_REINDEER, AE_DISPLACER_BEAST, AE_ECHIDNA, AE_FERRET, AE_FOX, AE_HELLCAT, AE_HORSE, AE_KAMAITACHI, AE_KANGAROO, AE_MELKIE, AE_MOUSE, AE_NEKOMATA, AE_PIG, AE_RACCOON, AE_SQUIRREL, AE_RED_PANDA, AE_SPHINX, AE_WENDIGO, AE_WEREWOLF, AE_WOLF, AE_YETI)
																	   .withAlchemyNames("Fur", "Fur");
    public function SkinScales(coverage: int = Skin.COVERAGE_COMPLETE, options: * = null): Transformation 				{ return skin.SkinScales(coverage, options); }
    public function SkinScalesGradual(coverage: int = Skin.COVERAGE_COMPLETE, options: * = null): Transformation 				{ return skin.SkinScalesGradual(coverage, options); }
	public const SkinScalesGradualToFull:Transformation = SkinScalesGradual().registerTfMultiple(AS_SKIN,
			AE_APOPHIS, AE_COUATL, AE_CAVE_WYRM, AE_GORGON, AE_HYDRA, AE_LIZARD, AE_SNAKE, AE_PHOENIX, AE_SALAMANDER)
															   .withAlchemyNames("Scale", "Scales");
    public function SkinDragonScales(coverage: int = Skin.COVERAGE_COMPLETE, options: * = null): Transformation 		{ return skin.SkinDragonScales(coverage, options); }
	public const SkinDragonScalesToFull:Transformation = SkinDragonScales().registerTfMultiple(AS_SKIN,
			AE_DRAGON, AE_FAERIE_DRAGON, AE_FROST_WYRM, AE_JABBERWOCKY, AE_KIRIN)
																		   .withAlchemyNames("DragonScales", "Dragon scales");
    public function SkinChitin(coverage: int = Skin.COVERAGE_COMPLETE, options: * = null): Transformation 				{ return skin.SkinChitin(coverage, options); }
	public const SkinChitinToFull:Transformation = SkinChitin().registerTfMultiple(AS_SKIN,
			AE_ANT, AE_BEE, AE_MANTIS, AE_SPIDER, AE_SCORPION, AE_ATLACH_NACHA)
															   .withAlchemyNames("Chitin", "chitin");
    public function SkinAquaScales(coverage: int = Skin.COVERAGE_HIGH, options: * = null): Transformation 				{ return skin.SkinAquaScales(coverage, options); }
	public const SkinAquaScalesToFull:Transformation = SkinAquaScales().registerTfMultiple(AS_SKIN, AE_SHARK, AE_SIREN, AE_WERESHARK)
																	   .withAlchemyNames("AquaScales", "Aqua scales");
	public function SkinBark(coverage: int = Skin.COVERAGE_COMPLETE, options: * = null): Transformation					{ return skin.SkinBark(coverage, options); }
	public const SkinBarkToFull:Transformation = SkinBark().registerTf(AS_SKIN, AE_YGGDRASIL)
														   .withAlchemyNames("Bark", "Bark");
    public function SkinGoo(coverage: int = Skin.COVERAGE_COMPLETE, type: int = 0, options: * = null): Transformation 	{ return skin.SkinGoo(coverage, type, options); }
	public const SkinGooToFull:Transformation = SkinGoo().registerTfMultiple(AS_SKIN, AE_GOO, AE_DARK_SLIME)
														 .withAlchemyNames("Goo", "Goo");


//SKIN PATTERN
//======================================================================================================================
//                                                                                                                    ==
//   ███████ ██   ██ ██ ███    ██ 		███████   █████  ████████ ████████ ███████ ██████  ███    ██                  ==
//   ██      ██  ██  ██ ████   ██ 		██   ██  ██   ██    ██       ██    ██      ██   ██ ████   ██                  ==
//   ███████ █████   ██ ██ ██  ██ 		███████  ███████    ██       ██    █████   ██████  ██ ██  ██                  ==
//        ██ ██  ██  ██ ██  ██ ██ 		██		 ██   ██    ██       ██    ██      ██   ██ ██  ██ ██                  ==
//   ███████ ██   ██ ██ ██   ████ 		██		 ██   ██    ██       ██    ███████ ██   ██ ██   ████                  ==
//                                                                                                                    ==
//======================================================================================================================
    public const SkinPatternNone: Transformation 				= skin.SkinPatternNone.registerTfMultiple(AS_SKIN_PATTERN, AE_REMOVE, AE_HUMAN);
    public const SkinPatternOrc: Transformation 				= skin.SkinPatternOrc.registerTf(AS_SKIN_PATTERN, AE_ORC);
    public const SkinPatternRaiju: Transformation 				= skin.SkinPatternRaiju.registerTf(AS_SKIN_PATTERN, AE_RAIJU);
    public const SkinPatternOni: Transformation 				= skin.SkinPatternOni.registerTf(AS_SKIN_PATTERN, AE_ONI);
    public const SkinPatternKitsune: Transformation 			= skin.SkinPatternKitsune.registerTf(AS_SKIN_PATTERN, AE_KITSUNE);
    public const SkinPatternVenomousMarkings: Transformation 	= skin.SkinPatternVenomousMarkings.registerTf(AS_SKIN_PATTERN, AE_OOMUKADE);
    public const SkinPatternWhiteBlackVeins: Transformation 	= skin.SkinPatternWhiteBlackVeins.registerTf(AS_SKIN_PATTERN, AE_GHOST);
    public const SkinPatternOil: Transformation 				= skin.SkinPatternOil.registerTf(AS_SKIN_PATTERN, AE_GAZER);
    public const SkinPatternScarWindswept: Transformation 		= skin.SkinPatternScarWindswept.registerTf(AS_SKIN_PATTERN, AE_KAMAITACHI);
    public const SkinPatternUshiOniTattoo: Transformation 		= skin.SkinPatternUshiOniTattoo.registerTf(AS_SKIN_PATTERN, AE_USHI_ONI);
    public const SkinPatternBeeStripes:Transformation 			= skin.SkinPatternBeeStripes.registerTf(AS_SKIN_PATTERN, AE_BEE);
    public const SkinPatternTigerSharkStripes:Transformation 	= skin.SkinPatternTigerSharkStripes.registerTf(AS_SKIN_PATTERN, AE_SHARK);
    public const SkinPatternOrca:Transformation 				= skin.SkinPatternOrca.registerTf(AS_SKIN_PATTERN, AE_ORCA);
    public const SkinPatternSeaDragon:Transformation 			= skin.SkinPatternSeaDragon.registerTf(AS_SKIN_PATTERN, AE_SEA_DRAGON);
    public const SkinPatternArchImp:Transformation 			    = skin.SkinPatternArchImp.registerTf(AS_SKIN_PATTERN, AE_IMP);
    public const SkinPatternAnubis:Transformation 			    = skin.SkinPatternAnubis.registerTf(AS_SKIN_PATTERN, AE_ANUBIS);
    public const SkinPatternBioluminescence:Transformation 		= skin.SkinPatternBioluminescence.registerTf(AS_SKIN_PATTERN, AE_ABYSSAL_SHARK);//TfMultiple(AS_


//TAIL
//======================================================================================================================
//                                                                                                                    ==
//    ████████  █████  ██ ██                                                                                          ==
//       ██    ██   ██ ██ ██                                                                                          ==
//       ██    ███████ ██ ██                                                                                          ==
//       ██    ██   ██ ██ ██                                                                                          ==
//       ██    ██   ██ ██ ███████                                                                                     ==
//                                                                                                                    ==
//======================================================================================================================
	public var tail:TailTransformations = new TailTransformations();
	public const TailNone: Transformation 						= tail.TailNone.registerTf(AS_TAIL, AE_REMOVE);
	public const TailScorpion: Transformation 					= tail.TailScorpion.registerTf(AS_TAIL, AE_SCORPION);
	public const TailManticore: Transformation 					= tail.TailManticore.registerTf(AS_TAIL, AE_MANTICORE);
	public const TailBurning: Transformation 					= tail.TailBurning.registerTf(AS_TAIL, AE_HINEZUMI);
	public const TailTwinkasha: Transformation 					= tail.TailTwinkasha.registerTf(AS_TAIL, AE_HELLCAT);
	public const TailCat: Transformation 						= tail.TailCat.registerTfMultiple(AS_TAIL, AE_CAT< AE_DRAGONNE);
	public const TailNekomataOneThirdForked: Transformation 	= tail.TailNekomataOneThirdForked.registerTf(AS_TAIL, AE_NEKOMATA);
	public const TailNekomataTwoThirdsForked: Transformation 	= tail.TailNekomataTwoThirdsForked.registerTf(AS_TAIL, AE_NEKOMATA);
	public const TailCat2nd: Transformation 					= tail.TailCat2nd.registerTf(AS_TAIL, AE_NEKOMATA);
	public const TailRedPanda: Transformation 					= tail.TailRedPanda.registerTf(AS_TAIL, AE_RED_PANDA);
	public const TailHorse: Transformation 						= tail.TailHorse.registerTf(AS_TAIL, AE_HORSE);
	public const TailKirin: Transformation 						= tail.TailKirin.registerTf(AS_TAIL, AE_KIRIN);
	public const TailPig: Transformation 						= tail.TailPig.registerTf(AS_TAIL, AE_PIG);
	public const TailRaiju: Transformation 						= tail.TailRaiju.registerTf(AS_TAIL, AE_RAIJU);
	public const TailMantis: Transformation 					= tail.TailMantis.registerTf(AS_TAIL, AE_MANTIS);
	public const TailGoat: Transformation 						= tail.TailGoat.registerTf(AS_TAIL, AE_GOAT);
	public const TailCow: Transformation 						= tail.TailCow.registerTf(AS_TAIL, AE_COW);
	public const TailDraconic: Transformation 					= tail.TailDraconic.registerTf(AS_TAIL, AE_DRAGON);
	public const TailFeyDraconic: Transformation 				= tail.TailFeyDraconic.registerTf(AS_TAIL, AE_FAERIE_DRAGON);
	public const TailOrca: Transformation 						= tail.TailOrca.registerTf(AS_TAIL, AE_ORCA);
	public const TailSalamander: Transformation 				= tail.TailSalamander.registerTf(AS_TAIL, AE_SALAMANDER);
	public const TailShark: Transformation 						= tail.TailShark.registerTf(AS_TAIL, AE_SHARK);
	public const TailSpider: Transformation 					= tail.TailSpider.registerTf(AS_TAIL, AE_SPIDER);
	public const TailHarpy: Transformation 						= tail.TailHarpy.registerTf(AS_TAIL, AE_HARPY);
	public const TailBee: Transformation 						= tail.TailBee.registerTf(AS_TAIL, AE_BEE);
	public const TailLizard: Transformation 					= tail.TailLizard.registerTf(AS_TAIL, AE_LIZARD);
	public const TailDemonic: Transformation 					= tail.TailDemonic.registerTf(AS_TAIL, AE_DEMON);
	public const TailAzazel: Transformation 					= tail.TailAzazel.registerTf(AS_TAIL, AE_AZAZEL);
	public const TailWolf: Transformation 						= tail.TailWolf.registerTf(AS_TAIL, AE_WOLF);
	public const TailDog: Transformation 						= tail.TailDog.registerTf(AS_TAIL, AE_DOG);
	public const TailCaveWyrm: Transformation 					= tail.TailCaveWyrm.registerTf(AS_TAIL, AE_CAVE_WYRM);
	public const TailRabbit: Transformation 					= tail.TailRabbit.registerTf(AS_TAIL, AE_BUNNY);
	public const TailAvian: Transformation 						= tail.TailAvian.registerTf(AS_TAIL, AE_AVIAN);
	public const TailGriffin: Transformation 					= tail.TailGriffin.registerTf(AS_TAIL, AE_GRYPHON);
	public const TailKangaroo: Transformation 					= tail.TailKangaroo.registerTf(AS_TAIL, AE_KANGAROO);
	public const TailThunderbird: Transformation 				= tail.TailThunderbird.registerTf(AS_TAIL, AE_THUNDERBIRD);
	public const TailSquirrel: Transformation 					= tail.TailSquirrel.registerTf(AS_TAIL, AE_SQUIRREL);
	public const TailWeasel: Transformation 					= tail.TailWeasel.registerTf(AS_TAIL, AE_WEASEL);
	public const TailRaccoon: Transformation 					= tail.TailRaccoon.registerTf(AS_TAIL, AE_RACCOON);
	public const TailMouse: Transformation 						= tail.TailMouse.registerTf(AS_TAIL, AE_MOUSE);
	public const TailHinezumi: Transformation 					= tail.TailHinezumi.registerTf(AS_TAIL, AE_HINEZUMI);
	public const TailFerret: Transformation 					= tail.TailFerret.registerTf(AS_TAIL, AE_FERRET);
	public const TailBear: Transformation 						= tail.TailBear.registerTf(AS_TAIL, AE_BEAR);
	public const TailUshiOni: Transformation 					= tail.TailUshiOni.registerTf(AS_TAIL, AE_USHI_ONI);
	public const TailWendigo: Transformation 					= tail.TailWendigo.registerTf(AS_TAIL, AE_WENDIGO);
	public const TailHydra: Transformation 						= tail.TailHydra.registerTf(AS_TAIL, AE_HYDRA);
	public const TailSpinneretAtlach: Transformation 			= tail.TailSpinneretAtlach.registerTf(AS_TAIL, AE_ATLACH_NACHA);
	public const TailDeer: Transformation 						= tail.TailDeer.registerTf(AS_TAIL, AE_DEER);
	public const TailYgddrasil: Transformation 					= tail.TailYgddrasil.registerTf(AS_TAIL, AE_YGGDRASIL);
	public const TailAbyssalShark: Transformation 				= tail.TailAbyssalShark.registerTf(AS_TAIL, AE_ABYSSAL_SHARK);
	public const TailArigeanGreen: Transformation 				= tail.TailArigeanGreen.registerTf(AS_TAIL, AE_ARIGEAN);
	public const TailArigeanRed: Transformation 				= tail.TailArigeanRed.registerTf(AS_TAIL, AE_ARIGEAN);
	public const TailArigeanYellow: Transformation 				= tail.TailArigeanYellow.registerTf(AS_TAIL, AE_ARIGEAN);
    public const TailMoth: Transformation                       = tail.TailMoth.registerTf(AS_TAIL, AE_MOTH);
    public const TailTroll: Transformation                      = tail.TailTroll.registerTf(AS_TAIL, AE_TROLL);
    public const TailGlacialTroll: Transformation               = tail.TailGlacialTroll.registerTf(AS_TAIL, AE_GLACIAL_TROLL);

	/**
	 * @param tailCount target tail count
	 * @param magnitude max. number of added/removed tails
	 * @param canRemove can remove tails (if false, this is "at least [tailCount] fox tails" TF)
	 */
	public function TailFox(tailCount:int = 1, magnitude:int = 9, canRemove:Boolean = true):Transformation { return tail.TailFox(tailCount, magnitude, canRemove); }
	public function TailKitshoo(tailCount: int = 1): Transformation { return tail.TailKitshoo(tailCount); }
	public const TailAnt: Transformation 						= tail.TailAnt;


//TONGUE
//======================================================================================================================
//                                                                                                                    ==
//    ████████  ██████  ███    ██  ██████  ██    ██ ███████                                                           ==
//       ██    ██    ██ ████   ██ ██       ██    ██ ██                                                                ==
//       ██    ██    ██ ██ ██  ██ ██   ███ ██    ██ █████                                                             ==
//       ██    ██    ██ ██  ██ ██ ██    ██ ██    ██ ██                                                                ==
//       ██     ██████  ██   ████  ██████   ██████  ███████                                                           ==
//                                                                                                                    ==
//======================================================================================================================
	public var tongue: TongueTransformations = new TongueTransformations();
	public const TongueHuman: Transformation 		= tongue.TongueHuman.registerTf(AS_TONGUE, AE_HUMAN);
	public const TongueCat: Transformation 			= tongue.TongueCat.registerTfMultiple(AS_TONGUE, AE_CAT, AE_DRAGONNE);
	public const TongueDog: Transformation 			= tongue.TongueDog.registerTf(AS_TONGUE, AE_DOG);
	public const TongueElf: Transformation 			= tongue.TongueElf.registerTf(AS_TONGUE, AE_ELF);
	public const TongueDraconic: Transformation 	= tongue.TongueDraconic.registerTf(AS_TONGUE, AE_DRAGON);
	public const TongueSnake: Transformation 		= tongue.TongueSnake.registerTf(AS_TONGUE, AE_SNAKE);
	public const TongueDemonic: Transformation 		= tongue.TongueDemonic.registerTf(AS_TONGUE, AE_DEMON);
	public const TongueRavenous: Transformation 	= tongue.TongueRavenous.registerTf(AS_TONGUE, AE_WENDIGO);
	public const TongueCaveWyrm: Transformation 	= tongue.TongueCaveWyrm.registerTf(AS_TONGUE, AE_CAVE_WYRM);
	public const TongueGhost: Transformation 		= tongue.TongueGhost.registerTf(AS_TONGUE, AE_GHOST);
	public const TongueRatatoskr: Transformation 	= tongue.TongueRatatoskr.registerTf(AS_TONGUE, AE_SQUIRREL);
	public const TongueMelkie: Transformation 		= tongue.TongueMelkie.registerTf(AS_TONGUE, AE_MELKIE);
	public const TongueImp: Transformation 			= tongue.TongueImp.registerTf(AS_TONGUE, AE_IMP);
	public const TongueArigean: Transformation 		= tongue.TongueArigean.registerTf(AS_TONGUE, AE_ARIGEAN);


//VAGINA
//======================================================================================================================
//                                                                                                                    ==
//   ██       ██  █████   ██████  ██ ███   ██  █████                                                                  ==
// 	  ██     ██  ██   ██ ██       ██ ████  ██ ██   ██                                                                 ==
// 	   ██   ██   ███████ ██   ███ ██ ██ ██ ██ ███████                                                                 ==
// 	    ██ ██    ██   ██ ██    ██ ██ ██  ████ ██   ██                                                                 ==
//	     ███     ██   ██  ██████  ██ ██   ███ ██   ██                                                                 ==
//                                                                                                                    ==
//======================================================================================================================
    public var vaginas:VaginaTransformations = new VaginaTransformations();
    public function UnlockVagina(): void { return vaginas.UnlockVagina(); }
    public function VaginaNone(vagina:int = 0): Transformation { return vaginas.VaginaNone(vagina); }
	public const VaginaRemoveFirst:Transformation = VaginaNone(0).registerTf(AS_VAGINA, AE_REMOVE);
    public function CockToVagina(vagina:int = 0): Transformation { return vaginas.CockToVagina(vagina); }
    public const SecondVagina: Transformation = vaginas.SecondVagina();
    public function VaginaHuman(vagina:int = 0): Transformation { return vaginas.VaginaHuman(vagina); }
	public const VaginaAnyHuman:Transformation = VaginaHuman(-1).registerTf(AS_VAGINA, AE_HUMAN);
    public function VaginaHorse(vagina:int = 0): Transformation { return vaginas.VaginaHorse(vagina); }
	public const VaginaAnyHorse:Transformation = VaginaHorse(-1).registerTf(AS_VAGINA, AE_HORSE);
    public function VaginaKirin(vagina:int = 0): Transformation { return vaginas.VaginaKirin(vagina); }
	public const VaginaAnyKirin:Transformation = VaginaKirin(-1).registerTf(AS_VAGINA, AE_KIRIN);
    public function VaginaSandTrap(vagina:int = 0): Transformation { return vaginas.VaginaSandTrap(vagina); }
	public const VaginaAnySandTrap:Transformation = VaginaSandTrap(-1).registerTf(AS_VAGINA, AE_SAND_TRAP);
    public function VaginaCaveWyrm(vagina:int = 0): Transformation { return vaginas.VaginaCaveWyrm(vagina); }
	public const VaginaAnyCaveWyrm:Transformation = VaginaCaveWyrm(-1).registerTf(AS_VAGINA, AE_CAVE_WYRM);
    public function VaginaCentipede(vagina:int = 0): Transformation { return vaginas.VaginaCentipede(vagina); }
	public const VaginaAnyCentipede:Transformation = VaginaCentipede(-1).registerTf(AS_VAGINA, AE_CENTIPEDE);
    public function VaginaManticore(vagina:int = 0): Transformation { return vaginas.VaginaManticore(vagina); }
	public const VaginaAnyManticore:Transformation = VaginaManticore(-1).registerTf(AS_VAGINA, AE_MANTICORE);
    public function VaginaCancer(vagina:int = 0): Transformation { return vaginas.VaginaCancer(vagina); }
	public const VaginaAnyCancer:Transformation = VaginaCancer(-1).registerTf(AS_VAGINA, AE_CANCER);
    public function VaginaDemonic(vagina:int = 0): Transformation { return vaginas.VaginaDemonic(vagina); }
	public const VaginaAnyDemonic:Transformation = VaginaDemonic(-1).registerTf(AS_VAGINA, AE_DEMON);
    public function VaginaScylla(vagina:int = 0): Transformation { return vaginas.VaginaScylla(vagina); }
	public const VaginaAnyScylla:Transformation = VaginaScylla(-1).registerTf(AS_VAGINA, AE_SCYLLA);
    public function VaginaNaga(vagina:int = 0): Transformation { return vaginas.VaginaNaga(vagina); }
	public const VaginaAnyNaga:Transformation = VaginaNaga(-1).registerTf(AS_VAGINA, AE_SNAKE);
    public function VaginaShark(vagina:int = 0): Transformation { return vaginas.VaginaShark(vagina); }
	public const VaginaAnyShark:Transformation = VaginaShark(-1).registerTfMultiple(AS_VAGINA, AE_SHARK, AE_WERESHARK);
    public function VaginaRaiju(vagina:int = 0): Transformation { return vaginas.VaginaRaiju(vagina); }
	public const VaginaAnyRaiju:Transformation = VaginaRaiju(-1).registerTf(AS_VAGINA, AE_RAIJU);
    public function VaginaAlraune(vagina:int = 0): Transformation { return vaginas.VaginaAlraune(vagina); }
	public const VaginaAnyAlraune:Transformation = VaginaAlraune(-1).registerTf(AS_VAGINA, AE_ALRAUNE);
    public function VaginaArigean(vagina:int = 0): Transformation { return vaginas.VaginaArigean(vagina); }
	public const VaginaAnyArigean:Transformation = VaginaArigean(-1).registerTf(AS_VAGINA, AE_ARIGEAN);


//WINGS
//======================================================================================================================
//                                                                                                                    ==
//   ██       ██ ██ ███    ██  ██████  ███████                                                                        ==
//   ██       ██ ██ ████   ██ ██       ██                                                                             ==
//   ██  ███  ██ ██ ██ ██  ██ ██   ███ ███████                                                                        ==
//   ██ ██ ██ ██ ██ ██  ██ ██ ██    ██      ██                                                                        ==
//   ████   ████ ██ ██   ████  ██████  ███████                                                                        ==
//                                                                                                                    ==
//======================================================================================================================
	public var wings:WingsTransformations = new WingsTransformations();
	public const WingsNone: Transformation 						= wings.WingsNone.registerTf(AS_WINGS, AE_REMOVE);
	public const WingsBeeLarge: Transformation 					= wings.WingsBeeLarge.registerTf(AS_WINGS, AE_BEE);
	public const WingsBeeSmall: Transformation 					= wings.WingsBeeSmall.registerTf(AS_WINGS, AE_BEE);
	public const WingsCouatl: Transformation 					= wings.WingsCouatl.registerTf(AS_WINGS, AE_COUATL);
	public const WingsDraconicHuge: Transformation 				= wings.WingsDraconicHuge.registerTf(AS_WINGS, AE_DRAGON);
	public const WingsDraconicLarge: Transformation 			= wings.WingsDraconicLarge.registerTf(AS_WINGS, AE_DRAGON);
	public const WingsDraconicSmall: Transformation 			= wings.WingsDraconicSmall.registerTf(AS_WINGS, AE_DRAGON);
	public const WingsFairy: Transformation 					= wings.WingsFairy.registerTf(AS_WINGS, AE_FAIRY);
	public const WingsFeatheredAlicorn: Transformation 			= wings.WingsFeatheredAlicorn.registerTf(AS_WINGS, AE_ALICORN);
	public const WingsFeatheredLarge: Transformation 			= wings.WingsFeatheredLarge.registerTfMultiple(AS_WINGS, AE_HARPY, AE_SIREN, AE_THUNDERBIRD);
	public const WingsFeatheredPhoenix: Transformation 			= wings.WingsFeatheredPhoenix.registerTf(AS_WINGS, AE_PHOENIX);
	public const WingsFeatheredSphinx: Transformation 			= wings.WingsFeatheredSphinx.registerTf(AS_WINGS, AE_SPHINX);
	public const WingsManticoreLarge: Transformation 			= wings.WingsManticoreLarge.registerTf(AS_WINGS, AE_MANTICORE);
	public const WingsManticoreSmall: Transformation 			= wings.WingsManticoreSmall.registerTf(AS_WINGS, AE_MANTICORE);
	public const WingsMantisLarge: Transformation 				= wings.WingsMantisLarge.registerTf(AS_WINGS, AE_MANTIS);
	public const WingsMantisSmall: Transformation 				= wings.WingsMantisSmall.registerTf(AS_WINGS, AE_MANTIS);
	public const WingsNightmare: Transformation 				= wings.WingsNightmare.registerTf(AS_WINGS, AE_NIGHTMARE);
	public const WingsThunderousAura: Transformation 			= wings.WingsThunderousAura.registerTfMultiple(AS_WINGS, AE_KIRIN,AE_RAIJU).withAlchemyNames("Thund.Aura","Thunderous aura");
	public const WingsDemonicLarge: Transformation 				= wings.WingsDemonicLarge.registerTf(AS_WINGS, AE_DEMON);
	public const WingsDemonicTiny: Transformation 				= wings.WingsDemonicTiny.registerTf(AS_WINGS, AE_DEMON);
	public const WingsVampire: Transformation 					= wings.WingsVampire.registerTf(AS_WINGS, AE_VAMPIRE);
	public const WingsFeatheredAvian: Transformation 			= wings.WingsFeatheredAvian.registerTf(AS_WINGS, AE_AVIAN);
	public const WingsEthereal: Transformation 					= wings.WingsEthereal.registerTf(AS_WINGS, AE_POLTERGEIST);
	public const WingsLevitation: Transformation 				= wings.WingsLevitation.registerTfMultiple(AS_WINGS, AE_GAZER,AE_WENDIGO, AE_YUKI_ONNA).withAlchemyNames("Levitation","Levitation");
	public const WingsWindyAura: Transformation 				= wings.WingsWindyAura.registerTf(AS_WINGS, AE_KAMAITACHI);
	public const WingsGiantDragonfly: Transformation 			= wings.WingsGiantDragonfly.registerTf(AS_WINGS, AE_SAND_TRAP);
	public const WingsSeaDragon: Transformation 				= wings.WingsSeaDragon.registerTf(AS_WINGS, AE_SEA_DRAGON);
	public const WingsAntLarge: Transformation 					= wings.WingsAntLarge.registerTf(AS_WINGS, AE_ANT);
	public const WingsAntSmall: Transformation 					= wings.WingsAntSmall.registerTf(AS_WINGS, AE_ANT);
	public const WingsDevilfeather: Transformation 				= wings.WingsDevilfeather.registerTf(AS_WINGS, AE_DEVIL);
	public const WingsPureDevilfeather: Transformation 			= wings.WingsPureDevilfeather.registerTf(AS_WINGS, AE_DEVIL);
	public const WingsFeyDragon: Transformation 				= wings.WingsFeyDragon.registerTf(AS_WINGS, AE_FAERIE_DRAGON);
	public const WingsJabberwocky: Transformation 				= wings.WingsJabberwocky.registerTf(AS_WINGS, AE_JABBERWOCKY);
	public const WingsPlant: Transformation 					= wings.WingsPlant.registerTf(AS_WINGS, AE_PLANT);
	public const WingsYggdrasilLarge: Transformation 			= wings.WingsYggdrasilLarge.registerTf(AS_WINGS, AE_YGGDRASIL);
	public const WingsYggdrasilHuge: Transformation 			= wings.WingsYggdrasilHuge.registerTf(AS_WINGS, AE_YGGDRASIL);
	public const WingsYggdrasilQuadrupleHuge: Transformation 	= wings.WingsYggdrasilQuadrupleHuge.registerTf(AS_WINGS, AE_YGGDRASIL);
    public const WingsMothSmall: Transformation                 = wings.WingsMothSmall.registerTf(AS_WINGS, AE_MOTH);
    public const WingsMothLarge: Transformation                 = wings.WingsMothLarge.registerTf(AS_WINGS, AE_MOTH);



//Warnings
//======================================================================================================================
//                                                                                                                    ==
//   ██       ██  █████  ██████  ███    ██ ██ ███    ██  ██████  ███████                                              ==
//   ██       ██ ██   ██ ██   ██ ████   ██ ██ ████   ██ ██       ██                                                   ==
//   ██  ███  ██ ███████ ██████  ██ ██  ██ ██ ██ ██  ██ ██   ███ ███████                                              ==
//   ██ ██ ██ ██ ██   ██ ██   ██ ██  ██ ██ ██ ██  ██ ██ ██    ██      ██                                              ==
//   ████   ████ ██   ██ ██   ██ ██   ████ ██ ██   ████  ██████  ███████                                              ==
//                                                                                                                    ==
//======================================================================================================================

/*
    */
    public var warnings:WarningTransformations = new WarningTransformations();
    //warnings dont work as yet, calling function needs to return if bad end triggered!
    public const CaninePepperWarning: PossibleEffect = warnings.CaninePepperWarning;
    public const KangaFruitWarning: PossibleEffect = warnings.KangaFruitWarning;
    /*
*/

/*
*    ███████ ██████  ███████  ██████ ██  █████  ██          ████████ ███████ ███████
*    ██      ██   ██ ██      ██      ██ ██   ██ ██             ██    ██      ██
*    ███████ ██████  █████   ██      ██ ███████ ██             ██    █████   ███████
*         ██ ██      ██      ██      ██ ██   ██ ██             ██    ██           ██
*    ███████ ██      ███████  ██████ ██ ██   ██ ███████        ██    ██      ███████
*/


/*
*    ████████ ██ ███████ ██████  ███████ ██████      ████████ ███████ ███████
*       ██    ██ ██      ██   ██ ██      ██   ██     	██    ██      ██
*       ██    ██ █████   ██████  █████   ██   ██        ██    █████   ███████
*       ██    ██ ██      ██   ██ ██      ██   ██        ██    ██           ██
*       ██    ██ ███████ ██   ██ ███████ ██████         ██    ██      ███████
*/

/*
		*/
		public const TieredSpiderFace:GradualTransformation = new GradualTransformation("Spider face (gradual)", [
			FaceHuman,
			FaceSpiderFangs
		]);
		/*
*/

/*
*    ██      ██ ███████ ████████ ███████
*    ██      ██ ██         ██    ██
*    ██      ██ ███████    ██    ███████
*    ██      ██      ██    ██         ██
*    ███████ ██ ███████    ██    ███████
*/

/*
		*/
		public const List_AtlachNacha: /*Transformation*/ Array = [
			MutagenLibSpider,
			MutagenTouSpider,
			MutagenSpeSpider,
			SensUpSpider,

			VenomRechargeSpider,
			VaginaTightenAndMutagenLib,
			AssholeTightenAndMutagenLib,
			CocksThickenAll,
			BreastsGrowUpToDD,
			AssGrowUpTo11,

			EarsElfin,
			SkinChitin(Skin.COVERAGE_LOW, {color: "midnight purple"}),
			TieredSpiderFace,
			HairChangeColor(["midnight purple"]),
			new OrderedTransformation("EyesRedThenSpider", [
			EyesChangeColor(["red"]),
			EyesSpiderAndMutagenInt
			]),
			BreastRowsRemoveToOne,
			NipplesPerBreastOne,
			NipplesBlack,
			ArmsAtlach,
			LowerBodyAtlach,
			TailSpinneretAtlach,
			GillsNone,
			RearBodyAtlachNacha
		];
		/*
*/
	
	private function printAlchemyTable():void {
		var dump:/*String*/Array = [];
		var eid:int, sid:int;
		for (eid = 0; eid < Essences.length; eid++) {
			var ess:EnumValue = Essences[eid];
			if (eid == 0) {
				var row:/*String*/Array = ["Essences"];
			} else {
				if (!ess) continue;
				row = [ess.name];
			}
			for (sid = 1; sid < Substances.length; sid++) {
				var sub:EnumValue = Substances[sid];
				if (!sub) continue;
				if (eid == 0) {
					row.push(sub.short);
				} else {
					var tf:PossibleEffect = Transformation.findSETf(sid, eid);
					if (!tf) row.push("-");
					else row.push(tf.alchemyShortName);
				}
			}
			dump.push(row.join("\t"));
		}
		trace("\n"+dump.join("\n"));
	}
}
}
