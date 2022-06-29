package classes.Transformations {
import classes.BodyParts.*;
import classes.Cock;
import classes.CockTypesEnum;
import classes.GeneticMemories.*;
import classes.GlobalFlags.kFLAGS;
import classes.Items.MutationsHelper;
import classes.PerkLib;
import classes.Races.*;
import classes.Scenes.Metamorph;
import classes.StatusEffects;
import classes.Transformations.Transformations.AntennaeTransformations;
import classes.Transformations.Transformations.ArmsTransformations;
import classes.Transformations.Transformations.EarsTransformations;
import classes.Transformations.Transformations.EyesTransformations;
import classes.Transformations.Transformations.FaceTransformations;
import classes.Transformations.Transformations.GillsTransformations;
import classes.Transformations.Transformations.HairTransformations;
import classes.Transformations.Transformations.HornsTransformations;
import classes.Transformations.Transformations.LowerBodyTransformations;
import classes.Transformations.Transformations.RearBodyTransformations;
import classes.Transformations.Transformations.SkinTransformations;
import classes.Transformations.Transformations.TongueTransformations;
import classes.VaginaClass;
import classes.internals.Utils;
import classes.lists.BreastCup;

public class TransformationLib extends MutationsHelper {
public function TransformationLib() {}

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
	public const MutagenSpeSpider:PossibleEffect    = new MutagenEffect(
			"Mutagen Bonus SPE (spider)",
			"spe",
			1.5,
			"Your reflexes feel much faster. Experimentally, you make a grab at a fly on a nearby rock and quickly snatch it out of the air. A compulsion to stuff it in your mouth and eat it surfaces, but you resist the odd desire. Why would you ever want to do something like that?"
	);
	public const MutagenTouSpider:PossibleEffect    = new MutagenEffect(
			"Mutagen Bonus TOU (spider)",
			"tou",
			1,
			"Stretching languidly, you realize you're feeling a little tougher than before, almost as if you had a full-body shell of armor protecting your internal organs. How strange. You probe at yourself, and while your [skinfurscales] doesn't feel much different, the underlying flesh does seem tougher."
	);
	public const MutagenLibSpider:PossibleEffect    = new MutagenEffect(
			"Mutagen Bonus LIB (spider)",
			"lib",
			1,
			"You suddenly feel slightly needier, and your loins stir in quiet reminder that they could be seen to. The aftertaste hangs on your tongue and your teeth. You wish there had been more."
	);
	public const SensUpSpider:PossibleEffect        = new DynstatEffect(
			"Spider sens up",
			"sen",
			+1,
			"The hairs on your arms and legs stand up straight for a few moments, detecting the airflow around you. Touch appears to be more receptive from now on."
	);
	public const VenomRechargeSpider:PossibleEffect = new SimpleEffect(
				"Recharge spider venom",
				// apply
				function (doOutput:Boolean):void {
					var desc: String = "";

					desc += "The spinnerets on your abdomen twitch and drip a little webbing. The entirety of its heavy weight shifts slightly, and somehow you know you'll produce webs faster now.";

					if (doOutput) outputText(desc);
					player.tailRecharge += 5;
				},
				// is possible
				function ():Boolean {
				return player.tailType == Tail.SPIDER_ADBOMEN && player.tailRecharge < 25;
				}
	);

	public const VaginaTightenAndMutagenLib:PossibleEffect  = new SimpleEffect(
				"Tighten vagina + Mutagen Bonus LIB",
				// apply
				function (doOutput:Boolean):void {
				var desc: String = "";

				desc += "With a gasp, you feel your [vagina] tightening, making you leak sticky girl-juice. After a few seconds, it stops, and you rub on your [vagina] excitedly. You can't wait to try this out!";

				if (doOutput) outputText(desc);
				player.vaginas[0].vaginalLooseness--;
				dynStats("lus", 25);
				MutagenBonus("lib", 2);
				},
				// is possible
				function ():Boolean {
				return player.hasVagina() && player.looseness() > 1
				}
	);
	public const AssholeTightenAndMutagenLib:PossibleEffect = new SimpleEffect(
			"Tighten asshole + Mutagen Bonus LIB",
			// apply
			function (doOutput:Boolean):void {
				var desc: String = "";

				desc += "You let out a small cry as your [asshole] shrinks, becoming smaller and tighter. When it's done, you feel much hornier and eager to stretch it out again.";

				if (doOutput) outputText(desc);
				player.ass.analLooseness--;
				dynStats("lus", 25);
				MutagenBonus("lib", 2);
			},
			// is possible
			function ():Boolean {
				return player.ass.analLooseness > 1;
			}
	);
	public const CocksThickenAll:PossibleEffect             = new SimpleEffect(
			"Thicken all cocks",
			// apply
			function (doOutput:Boolean):void {
				var desc: String = "";
				var thickened:Boolean = false;
				for (var i:int = 0; i < player.cockTotal(); i++) {
					if (player.cocks[i].cockThickness * 5.5 < player.cocks[i].cockLength) {
						player.cocks[i].cockThickness += .1;
						thickened = true;
					}
				}
				if (thickened) {
					desc += "You can feel your [cocks] filling out in your [armor]. Pulling ";
					if (player.cockTotal() == 1) desc += "it";
					else desc += "them";
					desc += " out, you look closely. ";
					if (player.cockTotal() == 1) desc += "It's";
					else desc += "They're";
					desc += " definitely thicker.";
				}

				if (doOutput) outputText(desc);
			},
			// is possible
			function ():Boolean {
				return player.hasCock();
			}
	);

	public const MutagenSpdCat: PossibleEffect = new StatChangeEffect("Mutagen Spd Cat",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

      if (player.spe <= 30) {
          desc += "You feel... more balanced, sure of step. You're certain that you've become just a little bit faster.";
          MutagenBonus("spe", 2);
      } else if (player.spe <= 60) {
          desc += "You stumble as you shift position, surprised by how quickly you move. After a moment or two of disorientation, you adjust. You're certain that you can run faster now.";
          MutagenBonus("spe", 1);
      } else {
          desc += "You pause mid-step and crouch. Your leg muscles have cramped up like crazy. After a few moments, the pain passes and you feel like you could chase anything down.";
          MutagenBonus("spe", 0.5);
      }

	  	if (doOutput) outputText(desc);
	  }
	);

	public const MutagenStrCat: PossibleEffect = new StatChangeEffect("Mutagen Str Cat",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

      if (rand(2) == 0) desc += "Your muscles feel taut, like a coiled spring, and a bit more on edge.";
      else desc += "You arch your back as your muscles clench painfully. The cramp passes swiftly, leaving you feeling like you've gotten a bit stronger.";

			MutagenBonus("str", 1);
	  	if (doOutput) outputText(desc);
	  }
	);
	/*
*/
/*
*    ███████ ██   ██ ██ ███    ██
*    ██      ██  ██  ██ ████   ██
*    ███████ █████   ██ ██ ██  ██
*         ██ ██  ██  ██ ██  ██ ██
*    ███████ ██   ██ ██ ██   ████
*/

/*
  */
	public var skin: SkinTransformations = new SkinTransformations();
	public function SkinColor(colors: /*String*/ Array): Transformation { return skin.SkinColor(colors); }
	public const SkinPlain: Transformation = skin.SkinPlain;
  /**
  * @param options = {color/colors,color2/colors2,pattern,adj,desc}
  */
	public function SkinFur(coverage: int = Skin.COVERAGE_COMPLETE, options: * = null): Transformation 			{ return skin.SkinFur(coverage, options); }
	public function SkinFurGradual(coverage:int = Skin.COVERAGE_COMPLETE, options:* = null):Transformation 		{ return skin.SkinFurGradual(coverage, options); }
	public function SkinScales(coverage: int = Skin.COVERAGE_COMPLETE, options: * = null): Transformation 		{ return skin.SkinScales(coverage, options); }
	public function SkinDragonScales(coverage: int = Skin.COVERAGE_COMPLETE, options: * = null): Transformation { return skin.SkinDragonScales(coverage, options); }
	public function SkinChitin(coverage: int = Skin.COVERAGE_COMPLETE, options: * = null): Transformation 		{ return skin.SkinChitin(coverage, options); }
    public function SkinAquaScales(coverage: int = Skin.COVERAGE_HIGH, options: * = null): Transformation 		{ return skin.SkinAquaScales(coverage, options); }
	public function SkinGoo(coverage: int = Skin.COVERAGE_COMPLETE, type: int = 0, options: * = null): Transformation { return skin.SkinGoo(coverage, type, options); }
  /*
*/

/*
*    ███████ ██   ██ ██ ███    ██ 			███████   █████  ████████ ████████ ███████ ██████  ███    ██
*    ██      ██  ██  ██ ████   ██ 			██   ██  ██   ██    ██       ██    ██      ██   ██ ████   ██
*    ███████ █████   ██ ██ ██  ██ 			███████  ███████    ██       ██    █████   ██████  ██ ██  ██
*         ██ ██  ██  ██ ██  ██ ██ 			██		 ██   ██    ██       ██    ██      ██   ██ ██  ██ ██
*    ███████ ██   ██ ██ ██   ████ 			██		 ██   ██    ██       ██    ███████ ██   ██ ██   ████
*/

/*
  */
	public const SkinPatternNone: Transformation 				= skin.SkinPatternNone;
	public const SkinPatternOrc: Transformation 				= skin.SkinPatternOrc;
	public const SkinPatternRaiju: Transformation 				= skin.SkinPatternRaiju;
	public const SkinPatternOni: Transformation 				= skin.SkinPatternOni;
	public const SkinPatternKitsune: Transformation 			= skin.SkinPatternKitsune;
	public const SkinPatternVenomousMarkings: Transformation 	= skin.SkinPatternVenomousMarkings;
	public const SkinPatternWhiteBlackVeins: Transformation 	= skin.SkinPatternWhiteBlackVeins;
	public const SkinPatternOil: Transformation 				= skin.SkinPatternOil;
	public const SkinPatternScarWindswept: Transformation 		= skin.SkinPatternScarWindswept;
	public const SkinPatternUshiOniTattoo: Transformation 		= skin.SkinPatternUshiOniTattoo;
	public const SkinPatternBeeStripes:Transformation 			= skin.SkinPatternBeeStripes;
    public const SkinPatternTigerSharkStripes:Transformation 	= skin.SkinPatternTigerSharkStripes;
    public const SkinPatternOrca:Transformation 				= skin.SkinPatternOrca;
    public const SkinPatternSeaDragon:Transformation 			= skin.SkinPatternSeaDragon;
  /*
*/

/*
*    ██   ██  ██████  ██████  ███    ██ ███████
*    ██   ██ ██    ██ ██   ██ ████   ██ ██
*    ███████ ██    ██ ██████  ██ ██  ██ ███████
*    ██   ██ ██    ██ ██   ██ ██  ██ ██      ██
*    ██   ██  ██████  ██   ██ ██   ████ ███████
*/

/*
  */
	public var horns: HornsTransformations = new HornsTransformations();
	public const HornsNone: Transformation 					= horns.HornsNone;
	public const HornsBicorn: Transformation 				= horns.HornsBicorn;
	public const HornsUnicorn: Transformation 				= horns.HornsUnicorn;
	public const HornsOniDual: Transformation 				= horns.HornsOniDual;
	public const HornsOni: Transformation 					= horns.HornsOni;
	public const HornsGoat: Transformation 					= horns.HornsGoat;
	public const HornsGoatQuadruple: Transformation 		= horns.HornsGoatQuadruple;
	public const HornsDraconicQuadruple: Transformation 	= horns.HornsDraconicQuadruple;
	public const HornsDraconicDual: Transformation 			= horns.HornsDraconicDual;
	public const HornsCowMinotaur: Transformation 			= horns.HornsCowMinotaur;
	public const HornsDemonic: Transformation 				= horns.HornsDemonic;
	public const HornsAntlers: Transformation 				= horns.HornsAntlers;
	public const HornsAntlersWendigo: Transformation 		= horns.HornsAntlersWendigo;
	public const HornsGhostlyWisps: Transformation 			= horns.HornsGhostlyWisps;
	public const HornsOak: Transformation 					= horns.HornsOak;
	public const HornsOrchid: Transformation 				= horns.HornsOrchid;
	public const HornsKraken: Transformation 				= horns.HornsKraken;
	public const HornsSeadragon: Transformation 			= horns.HornsSeadragon;
	public const HornsFrostwyrm: Transformation 			= horns.HornsFrostwyrm;
	public const HornsJabberwocky: Transformation 			= horns.HornsJabberwocky;
	public const HornsUshiOni: Transformation 				= horns.HornsUshiOni;
  /*
*/

/*
*     █████  ███    ██ ████████ ███████ ███    ██ ███    ██  █████  ███████
*    ██   ██ ████   ██ 	  ██    ██      ████   ██ ████   ██ ██   ██ ██
*    ███████ ██ ██  ██    ██    █████   ██ ██  ██ ██ ██  ██ ███████ █████
*    ██   ██ ██  ██ ██    ██    ██      ██  ██ ██ ██  ██ ██ ██   ██ ██
*    ██   ██ ██   ████    ██    ███████ ██   ████ ██   ████ ██   ██ ███████
*/

/*
  */
	public var antennae: AntennaeTransformations = new AntennaeTransformations();
	public const AntennaeNone: Transformation 			= antennae.AntennaeNone;
	public const AntennaeMantis: Transformation 		= antennae.AntennaeMantis;
	public const AntennaeBee: Transformation 			= antennae.AntennaeBee;
	public const AntennaeCentipede: Transformation 		= antennae.AntennaeCentipede;
	public const AntennaeFireSnail: Transformation 		= antennae.AntennaeFireSnail;
	public const AntennaeSeaDragon: Transformation 		= antennae.AntennaeSeaDragon;
	public const AntennaeJabberwocky: Transformation 	= antennae.AntennaeJabberwocky;
	public const AntennaeAnt: Transformation 			= antennae.AntennaeAnt;
  /*
*/

/***
*    ██   ██  █████  ██████ ██████
*    ██   ██ ██   ██   ██   ██   ██
*    ███████ ███████   ██   ██████
*    ██   ██ ██   ██   ██   ██   ██
*    ██   ██ ██   ██ ██████ ██   ██
*/

/*
  */
	public var hair: HairTransformations = new HairTransformations();
	public const HairHuman: Transformation 		= hair.HairHuman;
	public const HairFeather: Transformation 	= hair.HairFeather;
	public const HairGorgon: Transformation 	= hair.HairGorgon;
	public const HairSilky: Transformation 		= hair.HairSilky;
	public const HairStorm: Transformation 		= hair.HairStorm;
	public const HairBurning: Transformation 	= hair.HairBurning;
	public const HairSnowy: Transformation 		= hair.HairSnowy;
	public const HairLeaf: Transformation 		= hair.HairLeaf;
	public const HairGrass: Transformation 		= hair.HairGrass;
	public const HairGoo: Transformation 		= hair.HairGoo;
	public const HairGhost: Transformation 		= hair.HairGhost;
	public const HairRatatoskr: Transformation 	= hair.HairRatatoskr;
	public const HairWindswept: Transformation 	= hair.HairWindswept;
	public const HairAnemone: Transformation 	= hair.HairAnemone;
	public const HairFluffy: Transformation 	= hair.HairFluffy;
	public const HairCrazy: Transformation 		= hair.HairCrazy;
	public const HairPrismatic: Transformation 	= hair.HairPrismatic;
	public const HairQuill: Transformation 		= hair.HairQuill;
	public const HairFairy: Transformation 		= hair.HairFairy;
	public const HairCow: Transformation 		= hair.HairCow;
	public function HairChangeColor(colors: /*String*/ Array): Transformation { return hair.HairChangeColor(colors); }
  /*
*/

/*
*    ███████  █████   ██████ ███████
*    ██      ██   ██ ██      ██
*    █████   ███████ ██      █████
*    ██      ██   ██ ██      ██
*    ██      ██   ██  ██████ ███████
*/

/*
  */
	public var face:FaceTransformations = new FaceTransformations();
	public const FaceHuman: Transformation 				= face.FaceHuman;
	public const FaceHorse: Transformation 				= face.FaceHorse;
	public const FaceDog: Transformation 				= face.FaceDog;
	public const FaceCowMinotaur: Transformation 		= face.FaceCowMinotaur;
	public const FaceSharkTeeth: Transformation 		= face.FaceSharkTeeth;
	public const FaceSnakeFangs: Transformation 		= face.FaceSnakeFangs;
	public const FaceCat: Transformation 				= face.FaceCat;
	public const FaceCatCanines: Transformation 		= face.FaceCatCanines;
	public const FaceLizard: Transformation 			= face.FaceLizard;
	public const FaceBunny: Transformation 				= face.FaceBunny;
	public const FaceKangaroo: Transformation 			= face.FaceKangaroo;
	public const FaceSpiderFangs: Transformation 		= face.FaceSpiderFangs;
	public const FaceFox: Transformation 				= face.FaceFox;
	public const FaceDragon: Transformation 			= face.FaceDragon;
	public const FaceDragonFangs: Transformation 		= face.FaceDragonFangs;
	public const FaceRaccoonMask: Transformation 		= face.FaceRaccoonMask;
	public const FaceRaccoon: Transformation 			= face.FaceRaccoon;
	public const FaceBuckteeth: Transformation 			= face.FaceBuckteeth;
	public const FaceMouse: Transformation 				= face.FaceMouse;
	public const FaceFerretMask: Transformation 		= face.FaceFerretMask;
	public const FaceFerret: Transformation 			= face.FaceFerret;
	public const FacePig: Transformation 				= face.FacePig;
	public const FaceBoar: Transformation 				= face.FaceBoar;
	public const FaceRhino: Transformation 				= face.FaceRhino;
	public const FaceEchidna: Transformation 			= face.FaceEchidna;
	public const FaceDeer: Transformation 				= face.FaceDeer;
	public const FaceWolf: Transformation 				= face.FaceWolf;
	public const FaceManticore: Transformation 			= face.FaceManticore;
	public const FaceSalamanderFangs: Transformation 	= face.FaceSalamanderFangs;
	public const FaceYetiFangs: Transformation 			= face.FaceYetiFangs;
	public const FaceOrca: Transformation 				= face.FaceOrca;
	public const FacePlantDragon: Transformation 		= face.FacePlantDragon;
	public const FaceDevilFangs: Transformation 		= face.FaceDevilFangs;
	public const FaceOniTeeth: Transformation 			= face.FaceOniTeeth;
	public const FaceWeasel: Transformation 			= face.FaceWeasel;
	public const FaceVampire: Transformation 			= face.FaceVampire;
	public const FaceBucktooth: Transformation 			= face.FaceBucktooth;
	public const FaceJabberwocky: Transformation 		= face.FaceJabberwocky;
	public const FaceRedPanda: Transformation 			= face.FacePanda;
	public const FaceCheshire: Transformation 			= face.FaceCheshire;
	public const FaceCheshireSmile: Transformation 		= face.FaceCheshireSmile;
	public const FaceAvian: Transformation 				= face.FaceAvian;
	public const FaceWolfFangs: Transformation 			= face.FaceWolfFangs;
	public const FaceOrcFangs: Transformation 			= face.FaceOrcFangs;
	public const FaceAnimalTeeth: Transformation 		= face.FaceAnimalTeeth;
	public const FaceBear: Transformation 				= face.FaceBear;
	public const FacePanda: Transformation 				= face.FacePanda;
	public const FaceFireSnail: Transformation 			= face.FaceFireSnail;
	public const FaceGhost: Transformation 				= face.FaceGhost;
	public const FaceJiangshi: Transformation 			= face.FaceJiangshi;
	public const FaceYukiOnna: Transformation 			= face.FaceYukiOnna;
	public const FaceKudere: Transformation 			= face.FaceKudere;
	public const FaceUshiOniOnna: Transformation 		= face.FaceUshiOniOnna;
	public const FaceFairy: Transformation 				= face.FaceFairy;
	public const FaceCrazy: Transformation 				= face.FaceCrazy;
	public const FaceSmug: Transformation 				= face.FaceSmug;
	public const FaceSquirrel: Transformation 			= face.FaceSquirrel;
	public const FaceElf: Transformation 				= face.FaceElf;
	public const FaceAnt: Transformation 				= face.FaceAnt;
  /*
*/

/*
*    ████████  ██████  ███    ██  ██████  ██    ██ ███████
*       ██    ██    ██ ████   ██ ██       ██    ██ ██
*       ██    ██    ██ ██ ██  ██ ██   ███ ██    ██ █████
*       ██    ██    ██ ██  ██ ██ ██    ██ ██    ██ ██
*       ██     ██████  ██   ████  ██████   ██████  ███████
*/

/*
  */
	public var tongue: TongueTransformations = new TongueTransformations();
	public const TongueHuman: Transformation 		= tongue.TongueHuman;
	public const TongueCat: Transformation 			= tongue.TongueCat;
	public const TongueElf: Transformation 			= tongue.TongueElf;
	public const TongueDraconic: Transformation 	= tongue.TongueDraconic;
	public const TongueSnake: Transformation 		= tongue.TongueSnake;
	public const TongueDemonic: Transformation 		= tongue.TongueDemonic;
	public const TongueRavenous: Transformation 	= tongue.TongueRavenous;
	public const TongueCaveWyrm: Transformation 	= tongue.TongueCaveWyrm;
	public const TongueGhost: Transformation 		= tongue.TongueGhost;
	public const TongueRatatoskr: Transformation 	= tongue.TongueRatatoskr;
	public const TongueMelkie: Transformation 		= tongue.TongueMelkie;
  /*
*/

/*
*    ███████  █████  ██████  ███████
*    ██      ██   ██ ██   ██ ██
*    █████   ███████ ██████  ███████
*    ██      ██   ██ ██   ██      ██
*    ███████ ██   ██ ██   ██ ███████
*/

/*
  */
	public var ears:EarsTransformations = new EarsTransformations();
	public const EarsHuman: Transformation 		= ears.EarsHuman;
	public const EarsLion: Transformation 		= ears.EarsLion;
	public const EarsDisplacer: Transformation 	= ears.EarsDisplacer;
	public const EarsCat: Transformation 		= ears.EarsCat;
	public const EarsRedPanda: Transformation 	= ears.EarsRedPanda;
	public const EarsHorse: Transformation 		= ears.EarsHorse;
	public const EarsPig: Transformation 		= ears.EarsPig;
	public const EarsVampire: Transformation 	= ears.EarsVampire;
	public const EarsBat: Transformation 		= ears.EarsBat;
	public const EarsWeasel: Transformation 	= ears.EarsWeasel;
	public const EarsOni: Transformation 		= ears.EarsOni;
	public const EarsElven: Transformation 		= ears.EarsElven;
	public const EarsGoat: Transformation 		= ears.EarsGoat;
	public const EarsCow: Transformation 		= ears.EarsCow;
	public const EarsDraconic: Transformation 	= ears.EarsDraconic;
	public const EarsSnake: Transformation 		= ears.EarsSnake;
	public const EarsOrca: Transformation 		= ears.EarsOrca;
	public const EarsOrca2: Transformation 		= ears.EarsOrca2;
	public const EarsLizard: Transformation 	= ears.EarsLizard;
	public const EarsInsect: Transformation 	= ears.EarsInsect;
	public const EarsFox: Transformation 		= ears.EarsFox;
	public const EarsElfin: Transformation 		= ears.EarsElfin;
	public const EarsWolf: Transformation 		= ears.EarsWolf;
	public const EarsDog: Transformation 		= ears.EarsDog;
	public const EarsGremlin: Transformation 	= ears.EarsGremlin;
	public const EarsShark: Transformation 		= ears.EarsShark;
	public const EarsCaveWyrm: Transformation 	= ears.EarsCaveWyrm;
	public const EarsBunny: Transformation 		= ears.EarsBunny;
	public const EarsAvian: Transformation 		= ears.EarsAvian;
	public const EarsGryphon: Transformation 	= ears.EarsGryphon;
	public const EarsKangaroo: Transformation 	= ears.EarsKangaroo;
	public const EarsRaiju: Transformation 		= ears.EarsRaiju;
	public const EarsSquirrel: Transformation 	= ears.EarsSquirrel;
	public const EarsRaccoon: Transformation 	= ears.EarsRaccoon;
	public const EarsMouse: Transformation 		= ears.EarsMouse;
	public const EarsFerret: Transformation 	= ears.EarsFerret;
	public const EarsYeti: Transformation 		= ears.EarsYeti;
	public const EarsBear: Transformation 		= ears.EarsBear;
	public const EarsPanda: Transformation 		= ears.EarsPanda;
	public const EarsMelkie: Transformation 	= ears.EarsMelkie;
	public const EarsDeer: Transformation 		= ears.EarsDeer;
  /*
*/

/*
*		███████ ██	  ██ ███████ ███████
*		██		 ██  ██	 ██		 ██
*		█████	   ██    ██████	 ███████
*		██		   ██	 ██		      ██
*		███████	   ██	 ███████ ███████
*/

/*
  */
	public var eyes:EyesTransformations = new EyesTransformations();
	public const EyesHuman: Transformation			= eyes.EyesHuman;
	public const EyesManticore: Transformation		= eyes.EyesManticore;
	public const EyesInfernal: Transformation		= eyes.EyesInfernal;
	public const EyesDisplacer: Transformation		= eyes.EyesDisplacer;
	public const EyesCat: Transformation			= eyes.EyesCat;
	public const EyesOrc: Transformation			= eyes.EyesOrc;
	public const EyesVampire: Transformation		= eyes.EyesVampire;
	public const EyesRaiju: Transformation			= eyes.EyesRaiju;
	public const EyesWeasel: Transformation			= eyes.EyesWeasel;
	public const EyesOni: Transformation			= eyes.EyesOni;
	public const EyesElf: Transformation			= eyes.EyesElf;
	public const EyesDevil: Transformation			= eyes.EyesDevil;
	public const EyesDraconic: Transformation		= eyes.EyesDraconic;
	public const EyesGorgon: Transformation			= eyes.EyesGorgon;
	public const EyesSnake: Transformation			= eyes.EyesSnake;
	public const EyesSnakeFiendish: Transformation	= eyes.EyesSnakeFiendish;
	public const EyesSpider: Transformation			= eyes.EyesSpider;
	public const EyesLizard: Transformation			= eyes.EyesLizard;
	public const EyesFox: Transformation			= eyes.EyesFox;
	public const EyesMonoeye: Transformation		= eyes.EyesMonoeye;
	public const EyesRatatoskr: Transformation		= eyes.EyesRatatoskr;
	public const EyesKraken: Transformation			= eyes.EyesKraken;
	public const EyesFireSnail: Transformation		= eyes.EyesFireSnail;
	public const EyesFenrir: Transformation			= eyes.EyesFenrir;
	public const EyesDead: Transformation			= eyes.EyesDead;
	public const EyesCaveWyrm: Transformation		= eyes.EyesCaveWyrm;
	public const EyesGryphon: Transformation		= eyes.EyesGryphon;
	public const EyesSandTrap: Transformation		= eyes.EyesSandTrap;
	public const EyesHinezumi: Transformation		= eyes.EyesHinezumi;
	public const EyesFrostwyrm: Transformation		= eyes.EyesFenrir;
	public const EyesGoat: Transformation			= eyes.EyesGoat;
	public const EyesBear: Transformation			= eyes.EyesBear;
	public const EyesCancer: Transformation			= eyes.EyesCancer;
	public const EyesCentipede: Transformation		= eyes.EyesCentipede;
	public const EyesGhost: Transformation			= eyes.EyesGhost;
	public const EyesFiendish: Transformation		= eyes.EyesFiendish;
// EYE COLORS

	public function EyesChangeColor(colors: /*String*/ Array): Transformation { return eyes.EyesChangeColor(colors);	}

	public const EyesOniColors: Transformation = eyes.EyesOniColors
	public const EyesPlantColors: Transformation = eyes.EyesPlantColors
	public const EyesGoblinColors: Transformation = eyes.EyesGoblinColors
	public const EyesRaijuColors: Transformation = eyes.EyesRaijuColors
	public const EyesKamaitachiColors: Transformation = eyes.EyesKamaitachiColors
	public const EyesRatatoskrColors: Transformation = eyes.EyesRatatoskrColors
	public const EyesRaccoonColors: Transformation = eyes.EyesRaccoonColors
	public const EyesKrakenColors: Transformation = eyes.EyesKrakenColors
	public const EyesSeadragonColors: Transformation = eyes.EyesSeadragonColors
	public const EyesFireSnailColors: Transformation = eyes.EyesFireSnailColors
	public const EyesSpiderAndMutagenInt: Transformation = eyes.EyesSpiderAndMutagenInt;
  /*
*/

/*
*		 █████	██████	███		 ███ ███████
*		██	 ██ ██	 ██ ████	████ ██
*		███████ ██████	██  ████  ██ ███████
*		██	 ██ ██	 ██ ██	 ██	  ██      ██
*		██	 ██ ██	 ██ ██		  ██ ███████
*/

/*
  */
	public var arms:ArmsTransformations = new ArmsTransformations();
	public const ArmsHuman: Transformation 			= arms.ArmsHuman;
	public const ArmsSphinx: Transformation 		= arms.ArmsSphinx;
	public const ArmsLion: Transformation 			= arms.ArmsLion;
	public const ArmsDisplacer: Transformation 		= arms.ArmsDisplacer;
	public const ArmsCat: Transformation 			= arms.ArmsCat;
	public const ArmsRedPanda: Transformation 		= arms.ArmsRedPanda;
	public const ArmsOrc: Transformation 			= arms.ArmsOrc;
	public const ArmsBoar: Transformation 			= arms.ArmsBoar;
	public const ArmsPig: Transformation 			= arms.ArmsPig;
	public const ArmsBatWing: Transformation 		= arms.ArmsBatWing;
	public const ArmsRaijuPaws: Transformation 		= arms.ArmsRaijuPaws;
	public const ArmsRaiju: Transformation 			= arms.ArmsRaiju;
	public const ArmsOni: Transformation 			= arms.ArmsOni;
	public const ArmsElf: Transformation 			= arms.ArmsElf;
	public const ArmsMantis: Transformation 		= arms.ArmsMantis;
	public const ArmsDevil: Transformation 			= arms.ArmsDevil;
	public const ArmsDraconic: Transformation 		= arms.ArmsDraconic;
	public const ArmsOrca: Transformation 			= arms.ArmsOrca;
	public const ArmsPhoenix: Transformation 		= arms.ArmsPhoenix;
	public const ArmsSalamander: Transformation 	= arms.ArmsSalamander;
	public const ArmsShark: Transformation 			= arms.ArmsShark;
	public const ArmsSpider: Transformation 		= arms.ArmsSpider;
	public const ArmsHarpy: Transformation 			= arms.ArmsHarpy;
	public const ArmsBee: Transformation 			= arms.ArmsBee;
	public const ArmsLizard: Transformation 		= arms.ArmsLizard;
	public const ArmsKitsune: Transformation 		= arms.ArmsKitsune;
	public const ArmsFox: Transformation 			= arms.ArmsFox;
	public const ArmsPlant: Transformation 			= arms.ArmsPlant;
	public const ArmsCentipede: Transformation 		= arms.ArmsCentipede;
	public const ArmsWendigo: Transformation 		= arms.ArmsWendigo;
	public const ArmsYukiOnna: Transformation 		= arms.ArmsYukiOnna;
	public const ArmsWolf: Transformation 			= arms.ArmsWolf;
	public const ArmsGoo: Transformation 			= arms.ArmsGoo;
	public const ArmsHydra: Transformation 			= arms.ArmsHydra;
	public const ArmsCaveWyrm: Transformation 		= arms.ArmsCaveWyrm;
	public const ArmsAvian: Transformation 			= arms.ArmsAvian;
	public const ArmsGryphon: Transformation 		= arms.ArmsGryphon;
	public const ArmsGhost: Transformation 			= arms.ArmsGhost;
	public const ArmsGazer: Transformation 			= arms.ArmsGazer;
	public const ArmsSquirrel: Transformation 		= arms.ArmsSquirrel;
	public const ArmsWeasel: Transformation 		= arms.ArmsWeasel;
	public const ArmsKamaitachi: Transformation 	= arms.ArmsKamaitachi;
	public const ArmsRaccoon: Transformation 		= arms.ArmsRaccoon;
	public const ArmsHinezumi: Transformation 		= arms.ArmsHinezumi;
	public const ArmsKraken: Transformation 		= arms.ArmsKraken;
	public const ArmsYeti: Transformation 			= arms.ArmsYeti;
	public const ArmsSeaDragon: Transformation 		= arms.ArmsSeaDragon;
	public const ArmsFrostwyrm: Transformation 		= arms.ArmsFrostwyrm;
	public const ArmsJabberwocky: Transformation 	= arms.ArmsJabberwocky;
	public const ArmsBear: Transformation 			= arms.ArmsBear;
	public const ArmsUshiOni: Transformation 		= arms.ArmsUshiOni;
	public const ArmsMelkie: Transformation 		= arms.ArmsMelkie;
	public const ArmsAtlach: Transformation 		= arms.ArmsAtlach;
	public const ArmsAnt: Transformation 			= arms.ArmsAnt;
  /*
*/

/*
*     ██████  ██ ██      ██      ███████
*    ██       ██ ██      ██      ██
*    ██   ███ ██ ██      ██      ███████
*    ██    ██ ██ ██      ██           ██
*     ██████  ██ ███████ ███████ ███████
*/

/*
  */
	public var gills:GillsTransformations = new GillsTransformations();
	public const GillsNone: Transformation 				= gills.GillsNone;
	public const GillsFish: Transformation 				= gills.GillsFish;
	public const GillsAnemone: Transformation 			= gills.GillsAnemone;
	public const GillsInTentacleLegs: Transformation 	= gills.GillsInTentacleLegs;
  /*
*/

/*
*    ██████  ███████  █████  ██████      ██████   ██████  ██████  ██    ██
*    ██   ██ ██      ██   ██ ██   ██     ██   ██ ██    ██ ██   ██  ██  ██
*    ██████  █████   ███████ ██████      ██████  ██    ██ ██   ██    ██
*    ██   ██ ██      ██   ██ ██   ██     ██   ██ ██    ██ ██   ██    ██
*    ██   ██ ███████ ██   ██ ██   ██     ██████   ██████  ██████     ██
*/

/*
  */
	public var rearBody:RearBodyTransformations = new RearBodyTransformations();
	public const RearBodyNone: Transformation 				= rearBody.RearBodyNone;
	public const RearBodyLionMane: Transformation 			= rearBody.RearBodyLionMane;
	public const RearBodyDisplacerTentacles: Transformation = rearBody.RearBodyDisplacerTentacles;
	public const RearBodyBatCollar: Transformation 			= rearBody.RearBodyBatCollar;
	public const RearBodyRaijuMane: Transformation 			= rearBody.RearBodyRaijuMane;
	public const RearBodyOrcaBlowhole: Transformation 		= rearBody.RearBodyOrcaBlowhole;
	public const RearBodySharkFin: Transformation 			= rearBody.RearBodySharkFin;
	public const RearBodyMetamorphicGoo: Transformation 	= rearBody.RearBodyMetamorphicGoo;
	public const RearBodyGhostlyAura: Transformation 		= rearBody.RearBodyGhostlyAura;
	public const RearBodyTentacleEyestalks: Transformation 	= rearBody.RearBodyTentacleEyestalks;
	public const RearBodyKraken: Transformation 			= rearBody.RearBodyKraken;
	public const RearBodyYetiFur: Transformation 			= rearBody.RearBodyYetiFur;
	public const RearBodyGlacialAura: Transformation 		= rearBody.RearBodyGlacialAura;
	public const RearBodyFrostwyrm: Transformation 			= rearBody.RearBodyFrostwyrm;
	public const RearBodySnailShell: Transformation 		= rearBody.RearBodySnailShell;
	public const RearBodyCentipede: Transformation 			= rearBody.RearBodyCentipede;
	public const RearBodyFenrirIceSpikes: Transformation 	= rearBody.RearBodyFenrirIceSpikes;
	public const RearBodyFurCoat: Transformation 			= rearBody.RearBodyFurCoat;
	public const RearBodyAtlachNacha: Transformation 		= rearBody.RearBodyAtlachNacha;
	public const RearBodyCobraHood: Transformation 			= rearBody.RearBodyCobraHood;
  /*
*/

/*
*     ██       ██████  ██       ██ ███████ ██████      ██████   ██████  ██████  ██    ██
*     ██      ██    ██ ██       ██ ██      ██   ██     ██   ██ ██    ██ ██   ██  ██  ██
*     ██      ██    ██ ██  ███  ██ █████   ██████      ██████  ██    ██ ██   ██    ██
*     ██      ██    ██ ██ ██ ██ ██ ██      ██   ██     ██   ██ ██    ██ ██   ██    ██
*     ███████  ██████  ████   ████ ███████ ██   ██     ██████   ██████  ██████     ██
*/

/*
  */
	public var lowerBody:LowerBodyTransformations = new LowerBodyTransformations();
	public const LowerBodyBipedal: Transformation 			= lowerBody.LowerBodyBipedal;
	public function LowerBodyTaur(lowerBodyType: int = undefined): Transformation 		{ return lowerBody.LowerBodyTaur(lowerBodyType); }
	public const LowerBodyHuman: Transformation 			= lowerBody.LowerBodyHuman;
	public function LowerBodyHoofed(legCount: int = undefined): Transformation 			{ return lowerBody.LowerBodyHoofed(legCount); }
	public const LowerBodySnake: Transformation 			= lowerBody.LowerBodySnake;
	public const LowerBodyDemonHighHeels: Transformation 	= lowerBody.LowerBodyDemonHighHeels;
	public const LowerBodyDemonClawed: Transformation 		= lowerBody.LowerBodyDemonClawed;
	public const LowerBodyBee: Transformation 				= lowerBody.LowerBodyBee;
	public function LowerBodyCat(legCount: int = undefined): Transformation 			{ return lowerBody.LowerBodyCat(legCount); }
	public function LowerBodyLizard(legCount: int = undefined): Transformation 			{ return lowerBody.LowerBodyLizard(legCount); }
	public const LowerBodyHarpy: Transformation 			= lowerBody.LowerBodyHarpy;
	public const LowerBodySpider: Transformation 			= lowerBody.LowerBodySpider;
	public const LowerBodyDrider: Transformation 			= lowerBody.LowerBodyDrider;
	public function LowerBodyFox(legCount: int = undefined): Transformation 			{ return lowerBody.LowerBodyFox(legCount); }
	public function LowerBodyDraconic(legCount: int = undefined): Transformation 		{ return lowerBody.LowerBodyDraconic(legCount); }
	public function LowerBodyClovenHoofed(legCount: int = undefined): Transformation 	{ return lowerBody.LowerBodyClovenHoofed(legCount); }
	public function LowerBodySalamander(legCount: int = undefined): Transformation 		{ return lowerBody.LowerBodySalamander(legCount); }
	public function LowerBodyMantis(legCount: int = undefined): Transformation 			{ return lowerBody.LowerBodyMantis(legCount); }
	public function LowerBodyShark(legCount: int = undefined): Transformation 			{ return lowerBody.LowerBodyShark(legCount); }
	public function LowerBodyLion(legCount: int = undefined): Transformation 			{ return lowerBody.LowerBodyLion(legCount); }
	public function LowerBodyOrca(legCount: int = undefined): Transformation 			{ return lowerBody.LowerBodyOrca(legCount); }
	public const LowerBodyOni: Transformation 				= lowerBody.LowerBodyOni;
	public const LowerBodyElf: Transformation 				= lowerBody.LowerBodyElf;
	public function LowerBodyRaiju(legCount: int = undefined): Transformation 			{ return lowerBody.LowerBodyRaiju(legCount); }
	public const LowerBodyRedPanda: Transformation 			= lowerBody.LowerBodyRedPanda;
	public const LowerBodyOrc: Transformation 				= lowerBody.LowerBodyOrc;
	public function LowerBodyDog(legCount: int = undefined): Transformation 			{ return lowerBody.LowerBodyDog(legCount); }
	public function LowerBodyWolf(legCount: int = undefined): Transformation 			{ return lowerBody.LowerBodyWolf(legCount); }
	public const LowerBodyCentipede: Transformation 		= lowerBody.LowerBodyCentipede;
	public const LowerBodyWendigo: Transformation 			= lowerBody.LowerBodyWendigo;
	public const LowerBodyYukiOnna: Transformation 			= lowerBody.LowerBodyYukiOnna;
	public const LowerBodyPlantRootClaws: Transformation 	= lowerBody.LowerBodyPlantRootClaws;
	public const LowerBodyPlantHighHeels: Transformation 	= lowerBody.LowerBodyPlantHighHeels;
	public const LowerBodyPlantFlower: Transformation 		= lowerBody.LowerBodyPlantFlower;
	public const LowerBodyGoo: Transformation 				= lowerBody.LowerBodyGoo;
	public const LowerBodyFerret: Transformation 			= lowerBody.LowerBodyFerret;
	public const LowerBodyScylla: Transformation 			= lowerBody.LowerBodyScylla;
	public const LowerBodyKraken: Transformation 			= lowerBody.LowerBodyKraken;
	public const LowerBodyHydra: Transformation 			= lowerBody.LowerBodyHydra;
	public const LowerBodyAvian: Transformation 			= lowerBody.LowerBodyAvian;
	public const LowerBodyMelkie: Transformation 			= lowerBody.LowerBodyMelkie;
	public const LowerBodyUshiOni: Transformation 			= lowerBody.LowerBodyUshiOni;
	public const LowerBodyMouse: Transformation 			= lowerBody.LowerBodyMouse;
	public const LowerBodyHinezumi: Transformation 			= lowerBody.LowerBodyHinezumi;
	public const LowerBodyYeti: Transformation 				= lowerBody.LowerBodyYeti;
	public const LowerBodyGhost: Transformation 			= lowerBody.LowerBodyGhost;
	public const LowerBodyGhost2: Transformation 			= lowerBody.LowerBodyGhost2;
	public const LowerBodyGazer: Transformation 			= lowerBody.LowerBodyGazer;
	public const LowerBodyFireSnail: Transformation 		= lowerBody.LowerBodyFireSnail;
	public const LowerBodyFrostwyrm: Transformation 		= lowerBody.LowerBodyFrostwyrm;
	public const LowerBodyRaccoon: Transformation 			= lowerBody.LowerBodyRaccoon;
	public const LowerBodySquirrel: Transformation 			= lowerBody.LowerBodySquirrel;
	public const LowerBodyKangaroo: Transformation 			= lowerBody.LowerBodyKangaroo;
	public const LowerBodyCaveWyrm: Transformation 			= lowerBody.LowerBodyCaveWyrm;
	public function LowerBodyWeasel(legCount: int = undefined): Transformation 			{ return lowerBody.LowerBodyWeasel(legCount); }
	public function LowerBodyBear(legCount: int = undefined): Transformation 			{ return lowerBody.LowerBodyBear(legCount); }
	public function LowerBodySeaDragon(legCount: int = undefined): Transformation 		{ return lowerBody.LowerBodySeaDragon(legCount); }
	public function LowerBodyGryphon(legCount: int = undefined): Transformation 		{ return lowerBody.LowerBodyGryphon(legCount); }
	public const LowerBodyBunny: Transformation 			= lowerBody.LowerBodyBunny;
	public const LowerBodyJabberwocky: Transformation 		= lowerBody.LowerBodyJabberwocky;
	public const LowerBodyCrab: Transformation 				= lowerBody.LowerBodyCrab;
	public const LowerBodyCancer: Transformation 			= lowerBody.LowerBodyCancer;
	public const LowerBodyAtlach: Transformation 			= lowerBody.LowerBodyAtlach;
	public const LowerBodyAtlachNacha: Transformation 		= lowerBody.LowerBodyAtlachNacha;
	public const LowerBodyAnt: Transformation 				= lowerBody.LowerBodyAnt;
  /*
*/

/*
*    ████████  █████  ██ ██
*       ██    ██   ██ ██ ██
*       ██    ███████ ██ ██
*       ██    ██   ██ ██ ██
*       ██    ██   ██ ██ ███████
*/

/*
  */
	public const TailNone: Transformation = new SimpleTransformation("No Tail",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "You feel something shifting in your backside. Then something detaches from your backside and it falls onto the ground. <b>You no longer have a tail!</b>";
	    player.tailCount = 0;
	    player.tailVenom = 0;
	    player.tailRecharge = 5;
	    player.tailType = Tail.NONE;

	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.tailType === Tail.NONE;
	  }
	);

	public const TailScorpion: Transformation = new SimpleTransformation("Scorpion Tail",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.removeLowerBodyIfIncompatible(player, doOutput);

	    if (player.tailType != Tail.NONE) desc += "Painful swelling just above your [ass] doubles you over, and you hear the sound of your tail dropping off onto the ground! Before you can consider the implications, the pain gets worse, and you feel your backside bulge outward sickeningly, cracking and popping as a segmented scorpion-like tail grows in place of your old one. It grows large enough to be impossible to hide, and with a note of finality, your stinger slides free with an audible 'snick'. <b>You have a scorpion tail.</b>";
	    else desc += "Painful swelling just above your [ass] doubles you over. It gets worse and worse as the swollen lump begins to protrude from your backside, swelling and extending with a series of pops until you have a segmented tail hanging just above your butt. The whole thing is covered in a hard chitinous material, and large enough to be impossible to hide. You sigh as your stinger slides into place with a 'snick', finishing the transformation. <b>You have a scorpion tail.</b>";
	    player.tailVenom = 15;
	    player.tailRecharge = 5;
	    player.tailType = Tail.SCORPION;
	    player.tailCount = 1;

	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(TailMem.getMemory(TailMem.SCORPION));
	  },
	  // is present
	  function (): Boolean {
	    return player.tailType === Tail.SCORPION;
	  }
	);

	public const TailManticore: Transformation = new SimpleTransformation("Manticore Tail",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.applyTFIfNotPresent(transformations.TailScorpion, doOutput);

	    desc += "Your scorpion tail starts shifting as your stinger falls to the ground, leaving you with a wide hole at the tip of your tail. You have a feeling of emptiness in your tail, like if it was hollowed from the inside. The end of your tail where the stinger used to be suddenly explodes into a flower-like bulb of flesh. The petals open into what looks like the inside of a pussy, its folds moist and well lubricated. ";
	    desc += "\n\nRight after the previous transformation’s finished, spikes starts to grow out of the bulbous tip giving your tail tip the appearance of a spiked bulb. Flinging your tail randomly to test your new appendage you shoot one of them straight into a nearby tree. You idly wonder what it will feels like to milk men with this. <b>It seems you've grown the tail of a manticore.</b>";
	    player.tailType = Tail.MANTICORE_PUSSYTAIL;

	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(TailMem.getMemory(TailMem.MANTICORE));
	  },
	  // is present
	  function (): Boolean {
	    return player.tailType === Tail.MANTICORE_PUSSYTAIL;
	  }
	);

	public const TailBurning: Transformation = new SimpleTransformation("Burning Tail",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.removeLowerBodyIfIncompatible(player, doOutput);

	    TransformationUtils.applyTFIfNotPresent(transformations.TailNone, doOutput);

	    desc += "Warmth rampages all over your body before concentrating right above your [ass]. Right on cue, a blade of fire bursts from that spot, spiraling upwards. Strangely, despite the tail being obviously made of flames, it doesn't even feel hot unless you will it to. <b>You now have burning tail.</b>";
	    player.tailVenom = 0;
	    player.tailRecharge = 0;
	    player.tailType = Tail.BURNING;
	    player.tailCount = 1;

	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(TailMem.getMemory(TailMem.BURNING));
	  },
	  // is present
	  function (): Boolean {
	    return player.tailType === Tail.BURNING;
	  }
	);

	public const TailTwinkasha: Transformation = new SimpleTransformation("Twinkasha Tail",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.applyTFIfNotPresent(transformations.TailBurning);

	    desc += "Something weird is happening to your tail as the fire suddenly begins to flare to twice its volume. You screech, hiss and yowl in pain like a cat as it suddenly cracks and splits into <b>two fiery cat tails.</b> Feeling horny you proceed to stretch and lick your vagina to damp out your growing heat but it swiftly becomes obvious you will not be able to get rid of that scorching heat without a victim.";

	    player.tailType = Tail.TWINKASHA;
	    player.tailCount = 2;

	    if (doOutput) outputText(desc);
		  Metamorph.unlockMetamorph(TailMem.getMemory(TailMem.TWINKASKA));
	  },
	  // is present
	  function (): Boolean {
	    return player.tailType === Tail.TWINKASHA;
	  }
	);

	public const TailCat: Transformation = new SimpleTransformation("Cat Tail",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.removeLowerBodyIfIncompatible(player, doOutput);

	    var choice: int;
	    if (player.tailType == Tail.NONE) {
	      choice = rand(3);
	      if (choice == 0) desc += "A pressure builds in your backside. You feel under your [armor] and discover an odd bump that seems to be growing larger by the moment. In seconds it passes between your fingers, bursts out the back of your clothes and grows most of the way to the ground. A thick coat of fur springs up to cover your new tail. You instinctively keep adjusting it to improve your balance. <b>You now have a cat-tail.</b>";
	      if (choice == 1) desc += "You feel your backside shift and change, flesh molding and displacing into a long, flexible tail! <b>You now have a cat tail.</b>";
	      if (choice == 2) desc += "You feel an odd tingling in your spine and your tail bone starts to throb and then swell. Within a few moments it begins to grow, adding new bones to your spine. Before you know it, you have a tail. Just before you think it's over, the tail begins to sprout soft, glossy [fur color] fur. <b>You now have a cat tail.</b>";
	    } else desc += "You pause and tilt your head... something feels different. Ah, that's what it is; you turn around and look down at your tail as it starts to change shape, narrowing and sprouting glossy fur. <b>You now have a cat tail.</b>";
	    player.tailVenom = 0;
	    player.tailRecharge = 0;
	    player.tailType = Tail.CAT;
	    player.tailCount = 1;

	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(TailMem.getMemory(TailMem.CAT));
	  },
	  // is present
	  function (): Boolean {
	    return player.tailType === Tail.CAT && player.tailCount === 1;
	  }
	);

	public const TailNekomataOneThirdForked: Transformation = new SimpleTransformation("Forked 1/3 Tail",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.applyTFIfNotPresent(transformations.TailCat, doOutput);

	    desc += "A tingling pressure builds on your backside, and your soft, glossy tail begins to glow with an eerie, ghostly light. With a crackle of electrical energy, it starts splitting into two, stopping once the split reaches a third of the way down the length! <b>You now have a cat tail that is forked on the last third of its length.</b>";

	    player.tailType = Tail.NEKOMATA_FORKED_1_3;

	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(TailMem.getMemory(TailMem.NEKOMATA_FORKED_1_3));
	  },
	  // is present
	  function (): Boolean {
	    return player.tailType === Tail.NEKOMATA_FORKED_1_3;
	  }
	);

	public const TailNekomataTwoThirdsForked: Transformation = new SimpleTransformation("Forked 2/3 Tail",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.applyTFIfNotPresent(transformations.TailCat, doOutput);
	    TransformationUtils.applyTFIfNotPresent(transformations.TailNekomataOneThirdForked, doOutput);

	    desc += "A tingling pressure builds on your backside, and your soft, glossy, and partially forked tail begins to glow with an eerie, ghostly light. With a crackle of electrical energy, it starts splitting into two, stopping as another third of its length becomes forked! <b>You now have a cat tail that is forked at two thirds of its length.</b>";

	    player.tailType = Tail.NEKOMATA_FORKED_2_3;

	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(TailMem.getMemory(TailMem.NEKOMATA_FORKED_2_3));
	  },
	  // is present
	  function (): Boolean {
	    return player.tailType === Tail.NEKOMATA_FORKED_2_3;
	  }
	);

	public const TailCat2nd: Transformation = new SimpleTransformation("Cat2nd Tail",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.applyTFIfNotPresent(transformations.TailCat, doOutput);
	    TransformationUtils.applyTFIfNotPresent(transformations.TailNekomataOneThirdForked, doOutput);
	    TransformationUtils.applyTFIfNotPresent(transformations.TailNekomataTwoThirdsForked, doOutput);

	    desc += "A tingling pressure builds on your backside, and your soft, glossy, and partially forked tail begins to glow with an eerie, ghostly light. With a crackle of electrical energy, your tail finishes splitting in two! <b>You now have a pair of cat tails.</b>";

	    player.tailType = Tail.CAT;
	    player.tailCount = 2;

	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(TailMem.getMemory(TailMem.CAT_2));
	  },
	  // is present
	  function (): Boolean {
	    return player.tailType === Tail.CAT && player.tailCount == 2;
	  }
	);

	public const TailRedPanda: Transformation = new SimpleTransformation("RedPanda Tail",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.removeLowerBodyIfIncompatible(player, doOutput);

	    if (player.tailCount > 1) {
	      desc += "Your tails seem to move on their own, tangling together in a single mass. Before you can ever feel it happening, you realize that they’re merging! An increased sensation of heat, not unlike the flavor of the roots, rushes through your body, and once that it fades, you realize that you now have a single tail.";
	      desc += "The process doesn’t stop here though, as the feel of that spicy root returns, but now the heat is felt only in your tail, as it shakes wildly while it elongates and becomes more bushy. Soon it has become almost as long as you. A very thick mass of soft, fluffy furs covers it in a matter of seconds. It acquires a lovely ringed pattern of red-russet and copperish-orange.";
	      desc += "When the effects finally subside, you decide to test the tail, making it coil around your body, realizing soon that you can control its movements with ease, and that its fur feels wonderful to the touch. Anyways, <b>you now have a long, bushy, red-panda tail!</b>";
	    } else if (player.tailType == Tail.NONE) {
	      desc += "Feeling an uncomfortable sensation on your butt, you stretch yourself, attributing it to having sat on a rough surface. A burning sensation runs through your body, similar to the one that you had after eating the root. When it migrates to your back, your attention goes to a mass of fluff that has erupted from your backside. Before you can check it properly, it seems to move on its own, following the heated sensation that now pulsates through your body, and when the heated pulses seem to have stopped, it has become a long, fluffy tube";
	      desc += "Shortly after, the feel of that spicy root returns, but now the heat is felt only in your tail, which shakes wildly while it elongates and becomes more bushy. Soon it has become almost as long as you. A very thick mass of soft, fluffy furs covers it in a matter of seconds. It acquires a lovely ringed pattern of red-russet and copperish-orange.";
	      desc += "When the effects finally subside, you decide to test the tail, making it coil around your body, realizing soon that you can control its movements with ease, and that its fur feels wonderful at the touch. Anyways, <b>you now have a long, bushy, red-panda tail!</b>";
	    } else if (player.tailType == Tail.BEE_ABDOMEN || player.tailType == Tail.SPIDER_ADBOMEN || player.tailType == Tail.MANTIS_ABDOMEN || player.tailType == Tail.ANT_ABDOMEN) {
	      desc += "Your insectile backside seems affected by the root properties, as your venom production suddenly stops. The flesh within the abdomen retracts into your backside, the chiting covering falling, leaving exposed a layer of soft, bare skin. When the abdomen disappears, your left with a comically sized butt, that soon reverts to its usual size.";
	      desc += "The root keeps doing its thing, as you feel an uncomfortable sensation on your butt. A burning sensation runs through your body, similar to the one that you had after eating the root. When it migrates to your back, your attention goes to a mass of fluff that has erupted from your backside. Before you can check it properly, it seems to move on its own, following the heated sensation that now pulsates through your body, and when the heated pulses seem to have stopped, it has become a long, fluffy tube, quite different from your former abdomen.";
	      desc += "Shortly after, the feel of that spicy root returns, but now the heat is felt only in your tail, which shakes wildly while it elongates and becomes more bushy. Soon it has become almost as long as you. A very thick mass of soft, fluffy furs covers it in a matter of seconds. It acquires a lovely ringed pattern of red-russet and copperish-orange.";
	      desc += "When the effects finally subside, you decide to test the tail, making it coil around your body, realizing soon that you can control its movements with ease, and that its fur feels wonderful at the touch. Anyways, <b>you now have a long, bushy, red-panda tail!</b>";
	    } else {
	      desc += "The feel of that spicy root returns, but now the heat is felt on your tail, that shakes wildly while it elongates and becomes more bushy. Soon it has become almost as long as you. A very thick mass of soft, fluffy furs covers it in a matter of seconds. It acquires a lovely ringed pattern of red-russet and copperish-orange.";
	      desc += "When the effects finally subside, you decide to test the tail, making it coil around your body, realizing soon that you can control their moves with easy, and that its fur feels wonderful at the touch. Anyways, <b>you now have a long, bushy, red-panda tail!</b>";
	    }
	    player.tailVenom = 0;
	    player.tailRecharge = 0;
	    player.tailType = Tail.RED_PANDA;
	    player.tailCount = 1;

	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(TailMem.getMemory(TailMem.RED_PANDA));
	  },
	  // is present
	  function (): Boolean {
	    return player.tailType === Tail.RED_PANDA;
	  }
	);

	public const TailHorse: Transformation = new SimpleTransformation("Horse Tail",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.removeLowerBodyIfIncompatible(player, doOutput);

	    if (player.tailType == Tail.SPIDER_ADBOMEN || player.tailType == Tail.BEE_ABDOMEN || player.tailType == Tail.SCORPION || player.tailType == Tail.MANTIS_ABDOMEN) {
	      desc += "Your insect-like abdomen bunches up as it begins shrinking, exoskeleton flaking off like a snake sheds its skin. It bunches up until it is as small as a tennis ball, then explodes outwards, growing into an animalistic tail shape. Moments later, it explodes into filaments of pain, dividing into hundreds of strands and turning into a shiny horsetail.";
	    } else {
	      TransformationUtils.applyTFIfNotPresent(transformations.TailNone, doOutput);

	      desc += "There is a sudden tickling on your ass, and you notice you have sprouted a long shiny horsetail of the same [haircolor] color as your hair.";
	    }

	    desc += " <b>You now have a horse-tail.</b>";
	    player.tailVenom = 0;
	    player.tailRecharge = 0;
	    player.tailType = Tail.HORSE;
	    player.tailCount = 1;

	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(TailMem.getMemory(TailMem.HORSE));
	  },
	  // is present
	  function (): Boolean {
	    return player.tailType === Tail.HORSE;
	  }
	);

	public const TailPig: Transformation = new SimpleTransformation("Pig Tail",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.removeLowerBodyIfIncompatible(player, doOutput);

	    if (player.tailType == Tail.NONE) desc += "You feel a tug at the base of your spine as it lengthens ever so slightly. Looking over your shoulder, <b>you find that you have sprouted a small, curly pig tail.</b>";
	    else desc += "You feel a pinching sensation in your [tail] as it begins to warp in change. When the sensation dissipates, <b>you are left with a small, curly pig tail.</b>";
	    player.tailVenom = 0;
	    player.tailRecharge = 0;
	    player.tailType = Tail.PIG;
	    player.tailCount = 1;

	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(TailMem.getMemory(TailMem.PIG));
	  },
	  // is present
	  function (): Boolean {
	    return player.tailType === Tail.PIG;
	  }
	);

	public const TailRaiju: Transformation = new SimpleTransformation("Raiju Tail",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.removeLowerBodyIfIncompatible(player, doOutput);

	    if (player.tailType == Tail.NONE) desc += "You yelp as a huge lightning bolt bursts out the area just above your ass. You watch in amazement as it twist and curls, slowly becoming thicker and thicker before it fizzles out, <b>leaving you with a silky Raiju tail!</b>";
	    else desc += "You nearly jump out of your skin as your tail burst into a huge lightning bolt. You watch as it curls and twist around before it fizzles out. <b>You now have a silky Raiju tail!</b>";
	    player.tailVenom = 0;
	    player.tailRecharge = 0;
	    player.tailType = Tail.RAIJU;
	    player.tailCount = 1;

	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(TailMem.getMemory(TailMem.RAIJU));
	  },
	  // is present
	  function (): Boolean {
	    return player.tailType === Tail.RAIJU;
	  }
	);

	public const TailMantis: Transformation = new SimpleTransformation("Mantis Tail",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.removeLowerBodyIfIncompatible(player, doOutput);

	    TransformationUtils.applyTFIfNotPresent(transformations.TailNone, doOutput);

	    desc += "Painful swelling just above your firm backside doubles you over. It gets worse and worse as the swollen lump begins to protrude from your backside, swelling and elongating with a series of pops until you have a bulbous abdomen hanging just above your butt. The whole thing is covered in a hard greenish chitinous material, and large enough to be impossible to hide. <b>You have a Mantis abdomen.</b>";
	    player.tailVenom = 0;
	    player.tailRecharge = 0;
	    player.tailType = Tail.MANTIS_ABDOMEN;
	    player.tailCount = 1;

	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(TailMem.getMemory(TailMem.MANTIS_ABDOMEN));
	  },
	  // is present
	  function (): Boolean {
	    return player.tailType === Tail.MANTIS_ABDOMEN;
	  }
	);

	public const TailGoat: Transformation = new SimpleTransformation("Goat Tail",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.removeLowerBodyIfIncompatible(player, doOutput);

	    TransformationUtils.applyTFIfNotPresent(transformations.TailNone, doOutput);

	    desc += "You feel an odd itchy sensation just above your [ass]. Twisting around to inspect it you find a short stubby tail that wags when you're happy. <b>You now have a goat tail.</b>";
	    player.tailVenom = 0;
	    player.tailRecharge = 0;
	    player.tailType = Tail.GOAT;
	    player.tailCount = 1;

	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(TailMem.getMemory(TailMem.GOAT));
	  },
	  // is present
	  function (): Boolean {
	    return player.tailType === Tail.GOAT;
	  }
	);

	public const TailCow: Transformation = new SimpleTransformation("Cow Tail",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.removeLowerBodyIfIncompatible(player, doOutput);

	    if (player.tailType == Tail.NONE) desc += "You feel the flesh above your [butt] knotting and growing. It twists and writhes around itself before flopping straight down, now shaped into a distinctly bovine form. You have a <b>cow tail</b>.";
	    else {
	      if (!InCollection(player.tailType, Tail.SPIDER_ADBOMEN, Tail.BEE_ABDOMEN, Tail.SCORPION, Tail.MANTIS_ABDOMEN, Tail.ANT_ABDOMEN)) {
	        desc += "Your tail bunches uncomfortably, twisting and writhing around itself before flopping straight down, now shaped into a distinctly bovine form. You have a <b>cow tail</b>.";
	      } else {
	        desc += "Your insect-like abdomen tingles pleasantly as it begins shrinking and softening, chitin morphing and reshaping until it looks exactly like a <b>cow tail</b>.";
	      }
	    }
	    player.tailVenom = 0;
	    player.tailRecharge = 0;
	    player.tailType = Tail.COW;
	    player.tailCount = 1;

	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(TailMem.getMemory(TailMem.COW));
	  },
	  // is present
	  function (): Boolean {
	    return player.tailType === Tail.COW;
	  }
	);

	public const TailDraconic: Transformation = new SimpleTransformation("Draconic Tail",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.removeLowerBodyIfIncompatible(player, doOutput);

	    if (player.tailType == Tail.NONE) desc += "A sudden dull, throbbing pain in your [butt] forces your hands to it; you can feel an ominous lump over your tail bone, swelling bigger and bigger with every heartbeat. All of a sudden, it seems to explode, jutting out and around until it hovers near your ankles, the skin under your flesh hard and scaly. <b>You now have a dragon tail flicking at your back, flexible as a whip.</b>";
	    else desc += "An icy sensation fills your behind as your tail suddenly goes curiously numb. Twisting your head around, you watch as it melts and transforms into a reptilian appendage, long and flexible, its tip adorned with wicked spikes. <b>You now have a dragon tail.</b>";
	    player.tailVenom = 0;
	    player.tailRecharge = 0;
	    player.tailType = Tail.DRACONIC;
	    player.tailCount = 1;

	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(TailMem.getMemory(TailMem.DRACONIC));
	  },
	  // is present
	  function (): Boolean {
	    return player.tailType === Tail.DRACONIC;
	  }
	);

	public const TailOrca: Transformation = new SimpleTransformation("Orca Tail",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.removeLowerBodyIfIncompatible(player, doOutput);

	    TransformationUtils.applyTFIfNotPresent(transformations.TailNone, doOutput);

	    desc += "A large bump starts to grow out of your [ass], making you groan as your spine lengthens for this whole new appendage to form. You finally grow a tail black as midnight with a white underside and a smaller fin closer to your body, likely for hydrodynamism sake. You swing your tail a few times, battering the ground, and realize that you should now be able to easily reach very high speeds on water. <b>You're going to have a lot of fun swimming with your new Orca tail.</b>";
	    player.tailVenom = 0;
	    player.tailRecharge = 0;
	    player.tailType = Tail.ORCA;
	    player.tailCount = 1;

	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(TailMem.getMemory(TailMem.ORCA));
	  },
	  // is present
	  function (): Boolean {
	    return player.tailType === Tail.ORCA;
	  }
	);

	public const TailSalamander: Transformation = new SimpleTransformation("Salamander Tail",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.removeLowerBodyIfIncompatible(player, doOutput);

	    TransformationUtils.applyTFIfNotPresent(transformations.TailNone, doOutput);

	    desc += "You drop onto the ground as your spine twists and grows, forcing the flesh above your [ass] to bulge out. New bones form, one after another, building a tapered, prehensile tail onto the back of your body. For a brief moment it tip ignite with a red-colored flame that with as little as your merely thought vanish moment later. Still you somehow know you can set ablaze any part or whole your tail at any moment and even use it to burn enemies after lashing them with your tail. <b>You now have a salamander tail!</b>";

	    player.tailVenom = 0;
	    player.tailRecharge = 0;
	    player.tailType = Tail.SALAMANDER;
	    player.tailCount = 1;

	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(TailMem.getMemory(TailMem.SALAMANDER));
	  },
	  // is present
	  function (): Boolean {
	    return player.tailType === Tail.SALAMANDER;
	  }
	);

	public const TailHydra: Transformation = new SimpleTransformation("Hydra Tails",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";
		TransformationUtils.applyTFIfNotPresent(transformations.LowerBodyHydra, doOutput);

		player.addStatusValue(StatusEffects.HydraTailsPlayer, 1, 1);
		desc +="[pg]You groan in discomfort as your tail splits again, a new snake head growing from the bloodied flesh lump to join the others. <b>You now have " + player.statusEffectv1(StatusEffects.HydraTailsPlayer) + " hydra heads below your waist.</b>";

		if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.statusEffectv1(StatusEffects.HydraTailsPlayer) >= 12;
	  },
	  // is possible
	  function (): Boolean {
	    return player.lowerBody == LowerBody.HYDRA && player.statusEffectv1(StatusEffects.HydraTailsPlayer) < 12;
	  }
	);

	public const TailShark: Transformation = new SimpleTransformation("Shark Tail",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.removeLowerBodyIfIncompatible(player, doOutput);

	    TransformationUtils.applyTFIfNotPresent(transformations.TailNone, doOutput);

	    desc += "Jets of pain shoot down your spine, causing you to gasp in surprise and fall to your hands and knees. Feeling a bulging at the end of your back, you lower your [armor] down just in time for a fully formed shark tail to burst through. You swish it around a few times, surprised by how flexible it is. After some modifications to your clothing, you're ready to go with your brand new shark tail.";
	    player.tailVenom = 0;
	    player.tailRecharge = 0;
	    player.tailType = Tail.SHARK;
	    player.tailCount = 1;

	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(TailMem.getMemory(TailMem.SHARK));
	  },
	  // is present
	  function (): Boolean {
	    return player.tailType === Tail.SHARK;
	  }
	);

	public const TailSpider: Transformation = new SimpleTransformation("Spider Tail",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.removeLowerBodyIfIncompatible(player, doOutput);

	    TransformationUtils.applyTFIfNotPresent(transformations.TailNone, doOutput);

	    desc += "A burst of pain hits you just above your [butt], coupled with a sensation of burning heat and pressure. You can feel your " + player.skinFurScales() + " tearing as something forces its way out of your body. Reaching back, you grab at it with your hands. It's huge... and you can feel it hardening under your touches, firming up until the whole tail has become rock-hard and spherical in shape. The heat fades, leaving behind a gentle warmth, and you realize your tail has become a spider's abdomen! With one experimental clench, you even discover that it can shoot webs from some of its spinnerets, both sticky and non-adhesive ones. That may prove useful. <b>You now have a spider's abdomen hanging from above your [butt]!</b>";

	    player.chitinColor2 = "black";
	    player.tailVenom = 5;
	    player.tailRecharge = 5;
	    player.tailType = Tail.SPIDER_ADBOMEN;
	    player.tailCount = 1;

	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(TailMem.getMemory(TailMem.SPIDER_ADBOMEN));
	  },
	  // is present
	  function (): Boolean {
	    return player.tailType === Tail.SPIDER_ADBOMEN;
	  }
	);

	public const TailHarpy: Transformation = new SimpleTransformation("Harpy Tail",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.removeLowerBodyIfIncompatible(player, doOutput);

	    if (player.tailType !== Tail.NONE) desc += "Your tail shortens, folding into the crack of your [butt] before it disappears. A moment later, a fan of feathers erupts in its place, fluffing up and down instinctively every time the breeze shifts. <b>You have a feathery harpy tail!</b>";
	    else desc += "A tingling tickles the base of your spine, making you squirm in place. A moment later, it fades, but a fan of feathers erupts from your [skin.type] in its place. The new tail fluffs up and down instinctively with every shift of the breeze. <b>You have a feathery harpy tail!</b>";
	    player.tailVenom = 0;
	    player.tailRecharge = 0;
	    player.tailType = Tail.HARPY;
	    player.tailCount = 1;

	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(TailMem.getMemory(TailMem.HARPY));
	  },
	  // is present
	  function (): Boolean {
	    return player.tailType === Tail.HARPY;
	  }
	);

	public const TailBee: Transformation = new SimpleTransformation("Bee Tail",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.removeLowerBodyIfIncompatible(player, doOutput);

	    if (player.tailType !== Tail.NONE) desc += "Painful swelling just above your [butt] doubles you over, and you hear the sound of your tail dropping off onto the ground! Before you can consider the implications, the pain gets worse, and you feel your backside bulge outward sickeningly, cracking and popping as a rounded bee-like abdomen grows in place of your old tail. It grows large enough to be impossible to hide, and with a note of finality, your stinger slides free with an audible 'snick'.";
	    else desc += "Painful swelling just above your [butt] doubles you over. It gets worse and worse as the swollen lump begins to protrude from your backside, swelling and rounding with a series of pops until you have a bulbous abdomen hanging just above your butt. The whole thing is covered in a hard chitinous material, and large enough to be impossible to hide. You sigh as your stinger slides into place with a 'snick', finishing the transformation. <b>You have a bee's abdomen.</b>";
	    player.tailVenom = 10;
	    player.tailRecharge = 5;
	    player.tailType = Tail.BEE_ABDOMEN;
		if (!InCollection(player.chitinColor2, "black","ebony")){
			player.chitinColor2 = randomChoice("black","ebony");
		}
		if (player.chitinColor1 != "yellow"){
			player.chitinColor1 = "yellow";
		}
	    player.tailCount = 1;

	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(TailMem.getMemory(TailMem.BEE_ABDOMEN));
	  },
	  // is present
	  function (): Boolean {
	    return player.tailType === Tail.BEE_ABDOMEN;
	  }
	);

	public const TailLizard: Transformation = new SimpleTransformation("Lizard Tail",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.removeLowerBodyIfIncompatible(player, doOutput);

	    if (player.tailType == Tail.NONE) desc += "You drop onto the ground as your spine twists and grows, forcing the flesh above your [ass] to bulge out. New bones form, one after another, building a tapered, prehensile tail onto the back of your body. <b>You now have a reptilian tail!</b>";
	    else desc += "You drop to the ground as your tail twists and grows, changing its shape in order to gradually taper to a point. It flicks back and forth, prehensile and totally under your control. <b>You now have a reptilian tail.</b>";
	    player.tailVenom = 0;
	    player.tailRecharge = 0;
	    player.tailType = Tail.LIZARD;
	    player.tailCount = 1;

	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(TailMem.getMemory(TailMem.LIZARD));
	  },
	  // is present
	  function (): Boolean {
	    return player.tailType === Tail.LIZARD;
	  }
	);

	public const TailDemonic: Transformation = new SimpleTransformation("Demonic Tail",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.removeLowerBodyIfIncompatible(player, doOutput);

	    if (player.tailType != Tail.NONE) {
	      desc += "";
	      if (player.tailType == Tail.SPIDER_ADBOMEN || player.tailType == Tail.BEE_ABDOMEN) desc += "You feel a tingling in your insectile abdomen as it stretches, narrowing, the exoskeleton flaking off as it transforms into a flexible demon-tail, complete with a round spaded tip. ";
	      else desc += "You feel a tingling in your tail. You are amazed to discover it has shifted into a flexible demon-tail, complete with a round spaded tip. ";
	      desc += "<b>Your tail is now demonic in appearance.</b>";
	    } else desc += "A pain builds in your backside... growing more and more pronounced. The pressure suddenly disappears with a loud ripping and tearing noise. <b>You realize you now have a demon tail</b>... complete with a cute little spade.";
	    player.tailVenom = 0;
	    player.tailRecharge = 0;
	    player.tailType = Tail.DEMONIC;
	    player.tailCount = 1;

	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(TailMem.getMemory(TailMem.DEMONIC));
	  },
	  // is present
	  function (): Boolean {
	    return player.tailType === Tail.DEMONIC;
	  }
	);

	public const TailWolf: Transformation = new SimpleTransformation("Wolf Tail",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.removeLowerBodyIfIncompatible(player, doOutput);

	    if (player.tailType == Tail.NONE) {
	      desc += "A pressure builds in your backside. You feel under your clothes and discover an odd bump that seems to be growing larger by the moment. In seconds it passes between your fingers, bursts out the back of your clothes, and grow most of the way to the ground. A thick coat of fur cold to the touch yet warm on your tail skin cover it entirely from the base to the tip. ";
	    }
	    if (player.tailType == Tail.HORSE) desc += "You feel a tightness in your rump, matched by the tightness with which the strands of your tail clump together.  In seconds they fuse into a single tail, rapidly sprouting thick fur. ";
	    else if (player.tailType == Tail.DEMONIC) desc += "The tip of your tail feels strange.  As you pull it around to check on it, the spaded tip disappears, quickly replaced by a thick coat of fur over the entire surface of your tail. ";
	    else desc += "You feel your backside shift and change, flesh molding and displacing into a long puffy tail! ";

	    desc += "<b>You now have a wolf tail!</b>";

	    player.tailVenom = 0;
	    player.tailRecharge = 0;
	    player.tailType = Tail.WOLF;
	    player.tailCount = 1;

	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(TailMem.getMemory(TailMem.WOLF));
	  },
	  // is present
	  function (): Boolean {
	    return player.tailType === Tail.WOLF;
	  }
	);

	public const TailDog: Transformation = new SimpleTransformation("Dog Tail",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.removeLowerBodyIfIncompatible(player, doOutput);

	    if (player.tailType == Tail.NONE) {
	      desc += "A pressure builds in your backside. You feel under your clothes and discover an odd bump that seems to be growing larger by the moment. In seconds it passes between your fingers, bursts out the back of your clothes, and grow most of the way to the ground. A thick coat of fur springs up to cover your new tail. ";
	    }
	    if (player.tailType == Tail.HORSE) desc += "You feel a tightness in your rump, matched by the tightness with which the strands of your tail clump together.  In seconds they fuse into a single tail, rapidly sprouting thick fur. ";
	    else if (player.tailType == Tail.DEMONIC) desc += "The tip of your tail feels strange.  As you pull it around to check on it, the spaded tip disappears, quickly replaced by a thick coat of fur over the entire surface of your tail. ";
	    else desc += "You feel your backside shift and change, flesh molding and displacing into a long puffy tail! ";

	    desc += "<b>You now have a dog tail!</b>";

	    player.tailVenom = 0;
	    player.tailRecharge = 0;
	    player.tailType = Tail.DOG;
	    player.tailCount = 1;

	    if (doOutput) outputText(desc);
		  Metamorph.unlockMetamorph(TailMem.getMemory(TailMem.DOG));
	  },
	  // is present
	  function (): Boolean {
	    return player.tailType === Tail.DOG;
	  }
	);

	public const TailCaveWyrm: Transformation = new SimpleTransformation("Cave Wyrm Tail",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.removeLowerBodyIfIncompatible(player, doOutput);

	    TransformationUtils.applyTFIfNotPresent(transformations.TailNone, doOutput);

	    desc += "A large bump starts to grow out of your [ass], making you groan as your spine lengthens for this whole new appendage to form. You finally grow a tail with patches of black scales which taper on the ground. Its fat and chubby like that of a newt and its heavy weight helps you keep your balance not to mention that people will just want to outright hug it.  <b>You have grown a large earth wyrm tail.</b>";

	    player.tailVenom = 0;
	    player.tailRecharge = 0;
	    player.tailType = Tail.CAVE_WYRM;
	    player.tailCount = 1;

	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(TailMem.getMemory(TailMem.CAVE_WYRM));
	  },
	  // is present
	  function (): Boolean {
	    return player.tailType === Tail.CAVE_WYRM;
	  }
	);

	public const TailRabbit: Transformation = new SimpleTransformation("Rabbit Tail",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.removeLowerBodyIfIncompatible(player, doOutput);

	    TransformationUtils.applyTFIfNotPresent(transformations.TailNone, doOutput);

	    desc += "A burning pressure builds at your spine before dissipating in a rush of relief. You reach back and discover a small, fleshy tail that's rapidly growing long, poofy fur. <b>You've got a white bunny-tail! It even twitches when you aren't thinking about it.</b>";

	    player.tailVenom = 0;
	    player.tailRecharge = 0;
	    player.tailType = Tail.RABBIT;
	    player.tailCount = 1;

	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.tailType === Tail.RABBIT;
	  }
	);

	public const TailAvian: Transformation = new SimpleTransformation("Avian Tail",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.removeLowerBodyIfIncompatible(player, doOutput);

	    if (player.tailType !== Tail.NONE) {
	      if (player.tailCount > 1) {
	        desc += "You feel an odd itch down your tail. It’s kind of a familiar feeling, as when you work a muscle to strengthen it. As you’re musing on what could be the cause, something changes on your tails, as they tense and twitch, so you look back to examine what’s happening to them.\n\nWhen you lay your eyes on them, the first thing that you notice if that is they’re entwining in a mess of curls and knots, the flesh on them merging until you have a single one. Then, the lone tail left starts shortening quickly. Soon, it has reduced into a short, fleshy bump of a tail. It doesn’t keep that way long, as it lengthens and wides a little, and start sprouting large, [feather color] colored feathers, shaped as wide fan. Some of then are very long, while others, near you [ass], are soft and downy.";
	      } else {
	        desc += "You feel an odd itch down your tail. It’s kind of a familiar feeling, as when you work a muscle to strengthen it. As you’re musing on what could be the cause, something changes on your tail, as it tenses and twitches, so you look back to examine what’s happening.\n\nWhen you lay your eyes on it, the first thing that you notice if that is shortening quickly. Soon, it has reduced into a short, fleshy bump of a tail. It doesn’t keep that way long, as it lengthens and wides a little, and start sprouting large, [feather color] colored feathers, shaped as wide fan. Some of then are very long, while others, near you butt, are soft and downy.";
	      }
	    } else {
	      desc += "You feel an odd itch down your spine. It’s kind of a familiar feeling, as when you work a muscle to strengthen it. As you’re musing on what could be the cause, something sprouts just above your butt and you take of your lower clothing so you can examine it.\n\nWhen you lay your eyes on it, you notice a short, fleshy bump of a tail. It doesn’t keep that way long, as it lengthens and wides a little, and start sprouting large, [feather color] colored feathers, shaped as wide fan. Some of then are very long, while others, near you butt, are soft and downy.";
	    }
	    desc += " <b>In any case, you have now a full, fan-shaped avian tail above your [butt]!</b>";

	    player.tailVenom = 0;
	    player.tailRecharge = 0;
	    player.tailType = Tail.AVIAN;
	    player.tailCount = 1;

	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.tailType === Tail.AVIAN;
	  }
	);

	public const TailGriffin: Transformation = new SimpleTransformation("Griffin Tail",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.removeLowerBodyIfIncompatible(player, doOutput);

	    desc += "The fan of feathers at your backside reacts under the statue magic effects. An otherworldly magic envelopes it, making the feathers twist and converge in an odd fashion, at the same time that the small bump of your tail elongates until becoming long enough to reach far past your knee.\n\nBefore you notice it, the long feathers have merged into a tuft of [fur color] at the end of your now long tail, while the short, downy ones now cover every inch of bare skin that the elongated appendage now have. <b>Well, seems like you gained a griffin-like tail!</b> It’s quite leonine in shape, but its appearance remains a bit avian.";

	    player.tailVenom = 0;
	    player.tailRecharge = 0;
	    player.tailType = Tail.GRIFFIN;
	    player.tailCount = 1;

	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.tailType === Tail.GRIFFIN;
	  }
	);

	public const TailKangaroo: Transformation = new SimpleTransformation("Kangaroo Tail",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.removeLowerBodyIfIncompatible(player, doOutput);

	    if (player.tailType == Tail.NONE) desc += "A painful pressure in your lower body causes you to stand straight and lock up. At first you think it might be gas. No... something is growing at the end of your tailbone. As you hold stock still so as not to exacerbate the pain, something thick pushes out from the rear of your garments. The pain subsides and you crane your neck around to look; a long, tapered tail is now attached to your butt and a thin coat of fur is already growing in! <b>You now have a kangaroo tail!</b>";
	    else if (player.tailType == Tail.SPIDER_ADBOMEN || player.tailType == Tail.BEE_ABDOMEN || player.tailType == Tail.SCORPION || player.tailType == Tail.MANTIS_ABDOMEN) {
	      desc += "Your chitinous backside shakes and cracks.  Peering at it as best you can, it appears as though the fuzz is falling out in clumps and the chitin is flaking off.  As convulsions begin to wrack your body and force you to collapse, the ";
	      if (player.tailType == Tail.BEE_ABDOMEN) desc += "hollow stinger drops out of the end, taking the venom organ with it.";
	      else desc += "spinnerets drop out of the end, taking the last of your webbing with it. By the time you're back to yourself, the insectile carapace has fallen off completely, leaving you with a long, thick, fleshy tail in place of your proud, insectile abdomen.  <b>You now have a kangaroo tail!</b>";
	    } else {
	      desc += "Your tail twitches as you eat.  It begins to feel fat and swollen, and you try to look at your own butt as best you can.  What you see matches what you feel as your tail thickens and stretches out into a long cone shape. <b>You now have a kangaroo tail!</b>";
	    }

	    player.tailVenom = 0;
	    player.tailRecharge = 0;
	    player.tailType = Tail.KANGAROO;
	    player.tailCount = 1;

	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.tailType === Tail.KANGAROO;
	  }
	);

	public const TailThunderbird: Transformation = new SimpleTransformation("Thunderbird Tail",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.removeLowerBodyIfIncompatible(player, doOutput);

	    if (player.tailType == Tail.NONE) desc += "You yelp as a huge lightning bolt bursts out the area just above your ass. You watch in amazement as it twist and curls, slowly becoming still before it fully fizzles out, <b>leaving you with a long sinuous bolt shaped thunderbird tail!</b>";
	    else desc += "You nearly jump out of your skin as your tail burst into a huge lightning bolt. You watch as it curls and twist around before it fizzles out. <b>You now have a long sinuous bolt shaped thunderbird tail!</b>";

	    player.tailVenom = 0;
	    player.tailRecharge = 0;
	    player.tailType = Tail.THUNDERBIRD;
	    player.tailCount = 1;

	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.tailType === Tail.THUNDERBIRD;
	  }
	);

	public const TailSquirrel: Transformation = new SimpleTransformation("Squirrel Tail",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.removeLowerBodyIfIncompatible(player, doOutput);

	    if (player.tailType == Tail.NONE) desc += "A pressure builds in your backside. You feel under your clothes and discover an odd bump that seems to be growing larger by the moment. In seconds it passes between your fingers and bursts out the back of your clothes, it grows most of the way to the ground before suddenly curving back up, turning easily twice as big as you are. A thick coat of light and [fur color] striped fur covers it entirely from the base to the tip. Well it's going to be hard to hide this huge thing, especially since it curls and puffs up just <b>like a squirrel tail.</b>";
	    else desc += "Something weird happens with your tail as it begins to change into something else. Within seconds the shape and coverage becomes closer to what you would expect of a squirrel tail. <b>You now have a squirrel tail!</b>";

	    player.tailVenom = 0;
	    player.tailRecharge = 0;
	    player.tailType = Tail.SQUIRREL;
	    player.tailCount = 1;

	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.tailType === Tail.SQUIRREL;
	  }
	);

	public const TailWeasel: Transformation = new SimpleTransformation("Weasel Tail",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.removeLowerBodyIfIncompatible(player, doOutput);

	    if (player.tailType == Tail.NONE) desc += "A pressure builds in your backside. You feel under your waist and discover an odd bump that seems to be growing larger by the moment. In seconds it passes between your fingers and bursts out the back of your ass into a tail which gets covered with a thick coat of fur entirely from the base to the tip. <b>You now have a weasel tail.</b>";
	    else desc += "Something weird happens with your tail as it begins to change into something else. Within seconds the shape and coverage becomes closer to what you would expect of a weasel tail. <b>You now have a silky weasel tail!</b>";

	    player.tailVenom = 0;
	    player.tailRecharge = 0;
	    player.tailType = Tail.WEASEL;
	    player.tailCount = 1;

	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.tailType === Tail.WEASEL;
	  }
	);

	public const TailRaccoon: Transformation = new SimpleTransformation("Raccoon Tail",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.removeLowerBodyIfIncompatible(player, doOutput);

	    if (player.tailType == Tail.NONE) {
	      desc += "Pain shivers through your spine and forces you onto the ground; your body locks up despite your attempt to rise again.  You can feel a tug on your spine from your backside, as if someone is trying to pull it out!  Several nodules form along your back, growing into new vertebrae and pushing the old ones downward and into your [armor].  An uncomfortable pressure grows there, as whatever development is taking place fights to free itself from the constriction.  Finally the shifting stops, and you're able to move again; the first thing you do is loosen your bottoms, allowing a matted tail to slide out.  <b>It twitches involuntarily, fluffing out into a ringed raccoon tail!</b>";
	    } else {
	      desc += "Your tail goes rigid with pain, and soon your body follows.  It feels as though your spine is trying to push the growth off of your body... barely, you manage to turn your head to see almost exactly that!  A new ringed, fluffy tail is growing in behind its predecessor, dark bands after light.  Soon it reaches full length and a tear comes to your eye as your old tail parts from its end and drops to the ground like overripe fruit, dissolving.  <b>You now have a raccoon tail!</b>";
	    }

	    player.tailVenom = 0;
	    player.tailRecharge = 0;
	    player.tailType = Tail.RACCOON;
	    player.tailCount = 1;

	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.tailType === Tail.RACCOON;
	  }
	);

	public const TailMouse: Transformation = new SimpleTransformation("Mouse Tail",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.removeLowerBodyIfIncompatible(player, doOutput);

	    if (player.tailType !== Tail.NONE) {
	      desc += "Your tail clenches and itches simultaneously, leaving you wondering whether to cry out or try to scratch it. The question is soon answered as the pain takes the forefront; looking backward is a horrible strain, but when you manage it, you can see your old appendage morphing into a long, thin line. With a shudder, it begins to shed until it's completely, starkly nude. <b>Your new mouse tail looks a bit peaked.</b>";
	    } else desc += "A small nub pokes from your backside, and you turn to look at it.  When you do, your neck aches as if whiplashed, and you groan as your spine shifts smoothly downward like a rope being pulled, growing new vertebra behind it and expanding the nub into a naked, thin, tapered shape.  <b>Rubbing at your sore neck, you stare at your new mouse tail.</b>";

	    player.tailVenom = 0;
	    player.tailRecharge = 0;
	    player.tailType = Tail.MOUSE;
	    player.tailCount = 1;

	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(TailMem.getMemory(TailMem.MOUSE));
	  },
	  // is present
	  function (): Boolean {
	    return player.tailType === Tail.MOUSE;
	  }
	);

	public const TailHinezumi: Transformation = new SimpleTransformation("Hinezumi Tail",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.applyTFIfNotPresent(transformations.TailMouse, doOutput);

	    desc += "You jump in surprise as your tail suddenly sparks and lights ablaze. Oddly, it doesn’t hurt. Your tail doesn’t seem to burn your own skin but whatever it touches is set aflame. Pondering how difficult it will be to move around without torching everything, your tail’s fire suddenly dies down. Seems you can light it up or extinguish it at will. <b>You now have a fiery mouse tail!</b>";

	    player.tailVenom = 0;
	    player.tailRecharge = 0;
	    player.tailType = Tail.HINEZUMI;
	    player.tailCount = 1;

	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(TailMem.getMemory(TailMem.HINEZUMI));
	  },
	  // is present
	  function (): Boolean {
	    return player.tailType === Tail.HINEZUMI;
	  }
	);

	public const TailFerret: Transformation = new SimpleTransformation("Ferret Tail",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.removeLowerBodyIfIncompatible(player, doOutput);

	    if (player.tailType == 0) {
	      desc += "You slump to the ground as you feel your spine lengthening and twisting, sprouting fur as it finishes growing.  Luckily the new growth does not seem to have ruined your [armor].  <b>You now have a ferret tail!</b>";
	    } else if (player.tailType == Tail.HORSE && player.isTaur()) desc += "You shiver as the wind gets to your tail, all of its shiny bristles having fallen out.  Your tail then begins to lengthen, warming back up as it sprouts a new, shaggier coat of fur.  This new, mismatched tail looks a bit odd on your horse lower body.  <b>You now have a ferret tail!</b>";
	    else if (player.tailType == Tail.HARPY) desc += "You feel a soft tingle as your tail feathers fall out one by one.  The little stump that once held the feathers down begins to twist and lengthen before sprouting soft, fluffy fur.  <b>You now have a ferret tail!</b>";
	    else if (player.tailType == Tail.RABBIT) desc += "You feel a pressure at the base of your tiny, poofy bunny tail as it begins to lengthen, gaining at least another foot in length.  <b>You now have a ferret tail!</b>";
	    else if (player.tailType == Tail.DRACONIC || player.tailType == Tail.LIZARD) desc += "You reach a hand behind yourself to rub at your backside as your tail begins to twist and warp, becoming much thinner than before.  It then sprouts a thick coat of fur.  <b>You now have a ferret tail!</b>";
	    else if (player.tailType == Tail.COW) desc += "Your tail begins to itch slightly as the poof at the end of your tail begins to spread across its entire surface, making all of its fur much more dense than it was before. It also loses a tiny bit of its former length. <b>You now have a ferret tail!</b>";
	    else if (player.tailType == Tail.CAT) desc += "Your tail begins to itch as its fur becomes much denser than it was before.  It also loses a tiny bit of its former length.  <b>You now have a ferret tail!</b>";
	    else if (player.tailType == Tail.DOG) desc += "Something about your tail feels... different.  You reach behind yourself, feeling it.  It feels a bit floppier than it was before, and the fur seems to have become a little more dense.  <b>You now have a ferret tail!</b>";
	    else if (player.tailType == Tail.KANGAROO) desc += "Your tail becomes uncomfortably tight as the entirety of its length begins to lose a lot of its former thickness.  The general shape remains tapered, but its fur has become much more dense and shaggy.  <b>You now have a ferret tail!</b>";
	    else if (player.tailType == Tail.FOX) desc += "Your tail begins to itch as its fur loses a lot of its former density.  It also appears to have lost a bit of length.  <b>You now have a ferret tail!</b>";
	    else if (player.tailType == Tail.RACCOON) desc += "Your tail begins to itch as its fur loses a lot of its former density, losing its trademark ring pattern as well.  It also appears to have lost a bit of length.  <b>You now have a ferret tail!</b>";
	    else if (player.tailType == Tail.HORSE) desc += "You shiver as the wind gets to your tail, all of its shiny bristles having fallen out.  Your tail then begins to lengthen, warming back up as it sprouts a new, shaggier coat of fur.  <b>You now have a ferret tail!</b>";
	    else if (player.tailType == Tail.MOUSE) desc += "Your tail begins to itch as its bald surface begins to sprout a thick layer of fur.  It also appears to have lost a bit of its former length.  <b>You now have a ferret tail!</b>";
	    else desc += "Your tail begins to itch a moment before it starts writhing, your back muscles spasming as it changes shape. Before you know it, <b>your tail has reformed into a narrow, ferret's tail.</b>";

	    player.tailVenom = 0;
	    player.tailRecharge = 0;
	    player.tailType = Tail.FERRET;
	    player.tailCount = 1;

	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.tailType === Tail.FERRET;
	  }
	);

	public const TailBear: Transformation = new SimpleTransformation("Bear Tail",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.removeLowerBodyIfIncompatible(player, doOutput);

	    if (player.tailType != Tail.NONE) desc += "You feel something shifting in your backside. Then something detaches from your backside and it falls onto the ground. ";
	    desc += "You groan in surprise as you feel your spine lengthening and twisting, sprouting fur as it finishes growing. ";
	    if (!player.isNaked()) desc += "Luckily the new growth does not seem to have ruined your [armor]. ";
	    desc += "Curious, you examine the new appendage, wagging it and smiling as you see your cute, <b>brand new bear-like tail!</b>";

	    player.tailVenom = 0;
	    player.tailRecharge = 0;
	    player.tailType = Tail.BEAR;
	    player.tailCount = 1;

	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.tailType === Tail.BEAR;
	  }
	);

	public const TailUshiOni: Transformation = new SimpleTransformation("Ushi-Oni Tail",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.removeLowerBodyIfIncompatible(player, doOutput);

	    if (player.tailType > Tail.NONE) desc += "You feel something shifting in your backside. Then something detaches from your backside and it falls onto the ground. ";
	    desc += "You feel a little pressure in your rear as you look back you see something emerging from it, a long, dexterous tail appear from it, It looks something along 25 inches witha little orifice in the tip, where the spinneret is located, <b>you now have an Ushi-Oni tail.</b>";

	    player.tailVenom = 5;
	    player.tailRecharge = 5;
	    player.tailType = Tail.USHI_ONI;
	    player.tailCount = 1;

	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.tailType === Tail.USHI_ONI;
	  }
	);

	public const TailWendigo: Transformation = new SimpleTransformation("Wendigo Tail",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.removeLowerBodyIfIncompatible(player, doOutput);

	    desc += "";

	    player.tailVenom = 0;
	    player.tailRecharge = 0;
	    player.tailType = Tail.WENDIGO;
	    player.tailCount = 1;

	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.tailType === Tail.WENDIGO;
	  }
	);
	
	/**
	 * @param tailCount target tail count
	 * @param magnitude max. number of added/removed tails
	 * @param canRemove can remove tails (if false, this is "at least [tailCount] fox tails" TF)
	 */
	public function TailFox(tailCount:int = 1, magnitude:int = 9, canRemove:Boolean = true):Transformation {
		return new SimpleTransformation("Fox Tail",
				// apply effect
				function (doOutput:Boolean):void {
					var desc:String = "";
					
					TransformationUtils.removeLowerBodyIfIncompatible(player, doOutput);
					
					if (player.tailType !== Tail.FOX) {
						transformations.TailNone.applyEffect();
						
						desc += "You feel a strange sensation on your backside. When you touch the area, you discover a strange nodule growing there that seems to be getting larger by the second. With a sudden flourish of movement, it bursts out into a long and bushy tail that sways hypnotically, as if it had a mind of its own. <b>You now have a fox's tail!</b>";
						
						player.tailVenom    = 0;
						player.tailRecharge = 0;
						player.tailType     = Tail.FOX;
						player.tailCount    = 1;
						
						if (tailCount > 1) {
							desc += "\n\n";
						}
					}

					if (player.tailCount < tailCount) {
						const newTails:int = Math.min(tailCount - player.tailCount, magnitude);
						tailCount          = player.tailCount + newTails;
						
						desc += "A tingling pressure builds on your backside, and your bushy tail" + ((player.tailCount > 1) ? "s begin" : " begins") + " to glow with an eerie, ghostly light. With a crackle of electrical energy, ";
						
						if (player.tailCount == 1) {
							desc += "your tail splits itself in " + Utils.num2Text(tailCount) + "!"
						} else {
							if (newTails == 1) {
								desc += "one of your tails splits in two!"
							} else {
								desc += "your tails multiply, creating " + Utils.num2Text(newTails) + " more besides the " + Utils.num2Text(player.tailCount) + " you already had!"
							}
						}
					} else if (player.tailCount > tailCount && canRemove) {
						const removedTails:int = Math.min(player.tailCount - tailCount, magnitude);
						tailCount              = player.tailCount - removedTails;
						
						desc += "A tingling pressure builds on your backside, and your bushy tail" + ((player.tailCount > 1) ? "s begin" : " begins") + " to glow with an eerie, ghostly light. With a crackle of electrical energy, ";
						
						if (tailCount == 1) {
							desc += (player.tailCount == 2 ? "both" : "all") + " your tails"
						} else if (removedTails == 1) {
							desc += "two of your tails"
						} else {
							desc += "some of your tails"
						}
						
						desc += " magically fuse, leaving you with "
						
						if (tailCount == 1) {
							desc += "only a single remaining fox tail!"
						} else {
							desc += Utils.num2Text(tailCount) + " remaining fox tails!"
						}
					}
					
					desc += " <b>You now have " + Utils.num2Text(tailCount) + " fox tail" + ((tailCount > 1) ? "s" : "") + "!</b>"
					
					if (tailCount == 2) (desc += "<b>\nYour next tail will be available at level 6, provided you have 30 Intelligence and 30 Wisdom.</b>")
					else if (tailCount == 3) (desc += "<b>\nYour next tail will be available at level 12, provided you have 45 Intelligence and 45 Wisdom.</b>")
					else if (tailCount == 4) (desc += "<b>\nYour next tail will be available at level 18, provided you have 60 Intelligence and 60 Wisdom.</b>")
					else if (tailCount == 5) (desc += "<b>\nYour next tail will be available at level 24, provided you have 75 Intelligence and 75 Wisdom.</b>")
					else if (tailCount == 6) (desc += "<b>\nYour next tail will be available at level 30, provided you have 90 Intelligence and 90 Wisdom.\nOnly the truly corrupted would continue gaining tails by directly using the jewels. Pure kitsune should offer up the jewels to Taoth.</b>")
					else if (tailCount == 7) (desc += "<b>\nYour next tail will be available at level 36, provided you have 105 Intelligence and 105 Wisdom.</b>")
					else if (tailCount == 8) (desc += "<b>\nYour final tail will be available at level 42, provided you have 120 Intelligence and 120 Wisdom.</b>")
					
					player.tailCount = tailCount;
					if (doOutput) outputText(desc);
					
					//noinspection FallThroughInSwitchStatementJS			// Fallthrough is intended for retroactively unlocking in Metamorph after getting GeneticMemory
					switch (tailCount) {
						case 9:
							if (player.hasPerk(PerkLib.NinetailsKitsuneOfBalance))
								Metamorph.unlockMetamorph(TailMem.getMemory(TailMem.FOX_9));
						case 8:
							if (player.hasPerk(PerkLib.NinetailsKitsuneOfBalance))
								Metamorph.unlockMetamorph(TailMem.getMemory(TailMem.FOX_8));
						case 7:
							if (player.hasPerk(PerkLib.NinetailsKitsuneOfBalance))
								Metamorph.unlockMetamorph(TailMem.getMemory(TailMem.FOX_7));
						case 6:
							Metamorph.unlockMetamorph(TailMem.getMemory(TailMem.FOX_6));
						case 5:
							Metamorph.unlockMetamorph(TailMem.getMemory(TailMem.FOX_5));
						case 4:
							Metamorph.unlockMetamorph(TailMem.getMemory(TailMem.FOX_4));
						case 3:
							Metamorph.unlockMetamorph(TailMem.getMemory(TailMem.FOX_3));
						case 2:
							Metamorph.unlockMetamorph(TailMem.getMemory(TailMem.FOX_2));
						case 1:
							Metamorph.unlockMetamorph(TailMem.getMemory(TailMem.FOX));
							break;
					}
				},
				// is present
				function ():Boolean {
					return player.tailType == Tail.FOX && (player.tailCount == tailCount || !canRemove && player.tailCount >= tailCount);
				}
		)
	}

	public function TailKitshoo(tailCount: int = 1): Transformation {
	  return new SimpleTransformation("Cinder Fox Tail",
	    // apply effect
	    function (doOutput: Boolean): void {
	      var desc: String = "";

	      TransformationUtils.removeLowerBodyIfIncompatible(player, doOutput);

	      if (player.tailType !== Tail.KITSHOO) {
	        transformations.TailNone.applyEffect();

	        desc += "You feel a strange sensation on your backside. When you touch the area, you discover a strange nodule growing there that seems to be getting larger by the second. With a sudden flourish of movement, it bursts out into a long and bushy tail that sways hypnotically, sending hot embers around. <b>You now have a cinder fox's tail!</b>";

	        player.tailVenom = 0;
	        player.tailRecharge = 0;
	        player.tailType = Tail.KITSHOO;
	        player.tailCount = 1;

	        if (tailCount > 1) {
	          desc += "\n\n";
	        }
	      }

	      if (player.tailCount < tailCount) {
	        const newTails: int = tailCount - player.tailCount;

	        desc += "A tingling pressure builds on your backside, and your bushy flame tail" + ((player.tailCount > 1) ? "s begin" : " begins") + " to glow with an eerie, crimson light. With a few stray embers, ";

	        if (player.tailCount == 1) {
	          desc += "your tail splits itself in " + Utils.num2Text(tailCount) + "!"
	        } else {
	          if (newTails == 1) {
	            desc += "one of your tails splits in two!"
	          } else {
	            desc += "your tails multiply, creating " + Utils.num2Text(newTails) + " more besides the " + Utils.num2Text(player.tailCount) + " you already had!"
	          }
	        }
	      } else if (player.tailCount > tailCount) {
	        const removedTails: int = tailCount - player.tailCount;

	        desc += "A tingling pressure builds on your backside, and your bushy flame tail" + ((player.tailCount > 1) ? "s begin" : " begins") + " to glow with an eerie, crimson light. With a few stray embers, ";

	        if (tailCount == 1) {
	          desc += (player.tailCount == 2 ? "both" : "all") + " your tails"
	        } else if (removedTails == 1) {
	          desc += "two of your tails"
	        } else {
	          desc += "some of your tails"
	        }

	        desc += " magically fuse, leaving you with "

	        if (tailCount == 1) {
	          desc += "only a single remaining cinder fox tail!"
	        } else {
	          desc += Utils.num2Text(tailCount) + " remaining cinder fox tails!"
	        }
	      }

	      desc += " <b>You now have " + Utils.num2Text(tailCount) + " cinder fox tail" + ((tailCount > 1) ? "s" : "") + "!</b>"

		  if (tailCount == 2) ( desc += "<b>\nYour next tail will be available at level 6, provided you have 30 Intelligence and 30 Wisdom.</b>" )
		  else if (tailCount == 3) ( desc += "<b>\nYour next tail will be available at level 12, provided you have 45 Intelligence and 45 Wisdom.</b>" )
		  else if (tailCount == 4) ( desc += "<b>\nYour next tail will be available at level 18, provided you have 60 Intelligence and 60 Wisdom.</b>" )
		  else if (tailCount == 5) ( desc += "<b>\nYour next tail will be available at level 24, provided you have 75 Intelligence and 75 Wisdom.</b>" )
		  else if (tailCount == 6) ( desc += "<b>\nYour next tail will be available at level 30, provided you have 90 Intelligence and 90 Wisdom.</b>" )
		  else if (tailCount == 7) ( desc += "<b>\nYour next tail will be available at level 36, provided you have 105 Intelligence and 105 Wisdom.</b>" )
		  else if (tailCount == 8) ( desc += "<b>\nYour final tail will be available at level 42, provided you have 120 Intelligence and 120 Wisdom.</b>" )

	      player.tailCount = tailCount;
	      if (doOutput) outputText(desc);

	      //noinspection FallThroughInSwitchStatementJS			// Fallthrough is intended for retroactively unlocking in Metamorph after getting GeneticMemory
	      switch (tailCount) {
	      case 9:
	        	Metamorph.unlockMetamorph(TailMem.getMemory(TailMem.KITSHOO_9));
	      case 8:
	        	Metamorph.unlockMetamorph(TailMem.getMemory(TailMem.KITSHOO_8));
	      case 7:
	        	Metamorph.unlockMetamorph(TailMem.getMemory(TailMem.KITSHOO_7));
	      case 6:
	    		Metamorph.unlockMetamorph(TailMem.getMemory(TailMem.KITSHOO_6));
	      case 5:
	    		Metamorph.unlockMetamorph(TailMem.getMemory(TailMem.KITSHOO_5));
	      case 4:
	    		Metamorph.unlockMetamorph(TailMem.getMemory(TailMem.KITSHOO_4));
	      case 3:
	    		Metamorph.unlockMetamorph(TailMem.getMemory(TailMem.KITSHOO_3));
	      case 2:
	    		Metamorph.unlockMetamorph(TailMem.getMemory(TailMem.KITSHOO_2));
	      case 1:
	    		Metamorph.unlockMetamorph(TailMem.getMemory(TailMem.KITSHOO));
				  break;
	      }
	    },
	    // is present
	    function (): Boolean {
	      return player.tailType == Tail.FOX && player.tailCount == tailCount;
	    }
	  )
	}

	public const TailSpinneretAtlach: Transformation = new SimpleTransformation("Spinneret Atlach Tail",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.removeLowerBodyIfIncompatible(player, doOutput);

	    if (player.tailType !== Tail.NONE) desc += "Your tail shudders as heat races through it, twitching violently until it feels almost as if it's on fire. You jump from the pain at your [butt] and grab at it with your hands. It's huge... and you can feel it hardening under your touches, firming up until the whole tail has become rock-hard and spherical in shape. The heat fades, leaving behind a gentle warmth, and you realize your tail has become a spider's abdomen!  With one experimental clench, you even discover that it can shoot webs from some of its spinnerets, both sticky and non-adhesive ones. That may prove useful. <b>You now have a spider's abdomen hanging from above your [butt]!</b>\n\n";
	    //(No tail)
	    else desc += "A burst of pain hits you just above your [butt], coupled with a sensation of burning heat and pressure. You can feel your " + player.skinFurScales() + " tearing as something forces its way out of your body. Reaching back, you grab at it with your hands. It's huge... and you can feel it hardening under your touches, firming up until the whole tail has become rock-hard and spherical in shape. The heat fades, leaving behind a gentle warmth, and you realize your tail has become a spider's abdomen!  With one experimental clench, you even discover that it can shoot webs from some of its spinnerets, both sticky and non-adhesive ones. That may prove useful. <b>You now have a spider's abdomen hanging from above your [butt]!</b>";

	    if (doOutput) outputText(desc);
	    TransformationUtils.applyTFIfNotPresent(transformations.TailSpider, false);
	    player.tailVenom = 5;
	    player.tailRecharge = 5;
	    player.chitinColor = "midnight purple";
	  },
	  // is present
	  function (): Boolean {
	    return player.tailType === Tail.SPIDER_ADBOMEN;
	  }
	);

	public const TailAnt: Transformation = new SimpleTransformation("Ant Tail",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.removeLowerBodyIfIncompatible(player, doOutput);

	    TransformationUtils.applyTFIfNotPresent(transformations.TailNone, doOutput);

	    desc += "A burst of pain hits you just above your [butt], coupled with a sensation of burning heat and pressure. You can feel your " + player.skinFurScales() + " tearing as something forces its way out of your body. Reaching back, you grab at it with your hands. It's huge... and you can feel it toughening under your touches, firming up until the whole tail has become quite hard and elliptical in shape. The heat fades, leaving behind a gentle warmth, and you realize your tail has become an ant's abdomen! As you start to shift your seat, however, you feel a sudden tug, and feel like something was just spat out--you must have a small stinger back there as well. <b>You now have an ant's abdomen.</b>";
		player.tailVenom = 10;
	    player.tailRecharge = 5;
	    player.tailType = Tail.ANT_ABDOMEN;
	    player.tailCount = 1;

	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(TailMem.getMemory(TailMem.ANT_ABDOMEN));
	  },
	  // is present
	  function (): Boolean {
	    return player.tailType === Tail.ANT_ABDOMEN;
	  }
	);
  /*
*/

/*
*    ██       ██ ██ ███    ██  ██████  ███████
*    ██       ██ ██ ████   ██ ██       ██
*    ██  ███  ██ ██ ██ ██  ██ ██   ███ ███████
*    ██ ██ ██ ██ ██ ██  ██ ██ ██    ██      ██
*    ████   ████ ██ ██   ████  ██████  ███████
*/

/*
  */
	public const WingsNone: Transformation = new SimpleTransformation("No Wings",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    if (player.wings.type == Wings.BEE_SMALL || player.wings.type == Wings.BEE_LARGE) {
	      desc += "Your wings twitch and flap involuntarily. You crane your neck to look at them as best you are able; from what you can see, they seem to be shriveling and curling up. They're starting to look a lot like they did when they first popped out, wet and new. <b>As you watch, they shrivel all the way, then recede back into your body.</b>";
	    } else {
	      switch (rand(2)) {
	      case 0:
	        desc += "Sensation fades from your [wings] slowly but surely, leaving them dried out husks that break off to fall on the ground. Your back closes up to conceal the loss, as smooth and unbroken as the day you entered the portal.";
	        break;
	      case 1:
	        desc += "A wave of tightness spreads through your back, and it feels as if someone is stabbing a dagger into each of your shoulder-blades. After a moment the pain passes, though your wings are gone!";
	        break;
	      }
	    }

	    player.wings.type = Wings.NONE;

	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.wings.type === Wings.NONE;
	  }
	);

	public const WingsFeatheredSphinx: Transformation = new SimpleTransformation("Feathered Sphinx Wings",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.applyTFIfNotPresent(transformations.WingsNone, doOutput);

	    desc += "Pain lances through your back, the muscles knotting oddly and pressing up to bulge your [skin.type]. It hurts, oh gods does it hurt, but you can't get a good angle to feel at the source of your agony. A loud crack splits the air, and then your body is forcing a pair of narrow limbs through a gap in your [armor]. Blood pumps through the new appendages, easing the pain as they fill out and grow. "+
				"Tentatively, you find yourself flexing muscles you didn't know you had, and <b>you're able to curve the new growths far enough around to behold your brand new, [haircolor] wings.</b>";
	    player.wings.type = Wings.FEATHERED_SPHINX;

	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(WingsMem.getMemory(WingsMem.FEATHERED_SPHINX));
	  },
	  // is present
	  function (): Boolean {
	    return player.wings.type === Wings.FEATHERED_SPHINX;
	  }
	);

	public const WingsManticoreLarge: Transformation = new SimpleTransformation("Manticore Large Wings",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.applyTFIfNotPresent(transformations.WingsManticoreSmall, doOutput);

	    desc += "Your feel your wings growing larger by the second. They keep growing until they reach three times their original size. The transformation finally stops as your wings reach a span of twice your arms length. These will be really useful should you want to fly around in search of a meal. <b>You now have fully grown manticore wings.</b>";
	    player.wings.type = Wings.MANTICORE_LARGE;

	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(WingsMem.getMemory(WingsMem.MANTICORE_LARGE));
	  },
	  // is present
	  function (): Boolean {
	    return player.wings.type === Wings.MANTICORE_LARGE;
	  }
	);

	public const WingsManticoreSmall: Transformation = new SimpleTransformation("Manticore Small Wings",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "";
	    TransformationUtils.applyTFIfNotPresent(transformations.WingsNone, doOutput);

	    desc += "You scream something akin to a roar from the tremendous amount of pain you're suddenly experiencing as something starts to push out from your back. Your claws start digging large marks into the ground as the things stretch out and burst through your skin. "+
				"Large bones covered in a thin, yet sturdy layer of skin, forming a pair of small bat-like wings slowly push out before finally staying in place. They are too small right now to allow you to take flight but they sure look good on you. <b>You now have small manticore wings.</b>";
	    player.wings.type = Wings.MANTICORE_SMALL;

	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(WingsMem.getMemory(WingsMem.MANTICORE_SMALL));
	  },
	  // is present
	  function (): Boolean {
	    return player.wings.type === Wings.MANTICORE_SMALL;
	  }
	);

	public const WingsNightmare: Transformation = new SimpleTransformation("Nightmare Wings",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.applyTFIfNotPresent(transformations.WingsNone, doOutput);

	    desc += "Pain lances through your back, the muscles knotting oddly and pressing up to bulge your [skin.type]. It hurts, oh gods does it hurt, but you can't get a good angle to feel at the source of your agony. A loud crack splits the air, and then your body is forcing a pair of narrow limbs through a gap in your [armor]. "+
				"Blood pumps through the new appendages, easing the pain as they fill out and grow. Tentatively, you find yourself flexing muscles you didn't know you had, and <b>you're able to curve the new growths far enough around to behold your brand new, white wings.</b>";
	    player.wings.type = Wings.NIGHTMARE;

	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(WingsMem.getMemory(WingsMem.NIGHTMARE));
	  },
	  // is present
	  function (): Boolean {
	    return player.wings.type === Wings.NIGHTMARE;
	  }
	);

	public const WingsFeatheredAlicorn: Transformation = new SimpleTransformation("Feathered Alicorn Wings",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.applyTFIfNotPresent(transformations.WingsNone, doOutput);

	    desc += "Pain lances through your back, the muscles knotting oddly and pressing up to bulge your [skin.type]. It hurts, oh gods does it hurt, but you can't get a good angle to feel at the source of your agony. A loud crack splits the air, and then your body is forcing a pair of narrow limbs through a gap in your [armor]. "+
				"Blood pumps through the new appendages, easing the pain as they fill out and grow. Tentatively, you find yourself flexing muscles you didn't know you had, and <b>you're able to curve the new growths far enough around to behold your brand new, white wings.</b>";
	    player.wings.type = Wings.FEATHERED_ALICORN;

	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(WingsMem.getMemory(WingsMem.FEATHERED_ALICORN));
	  },
	  // is present
	  function (): Boolean {
	    return player.wings.type === Wings.FEATHERED_ALICORN;
	  }
	);

	public const WingsThunderousAura: Transformation = new SimpleTransformation("Thunderous Aura (Wings)",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "You've become so charged in electricity that your movements are sometimes accompanied by the sound of static. <b>It's going to be difficult to hide your presence with that thunderous aura of yours.</b>";
	    player.wings.type = Wings.THUNDEROUS_AURA;

	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(WingsMem.getMemory(WingsMem.THUNDEROUS_AURA));
	  },
	  // is present
	  function (): Boolean {
	    return player.wings.type === Wings.THUNDEROUS_AURA;
	  }
	);

	public const WingsMantisLarge: Transformation = new SimpleTransformation("Mantis Large Wings",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.applyTFIfNotPresent(transformations.WingsMantisSmall, doOutput);

	    desc += "Your wings tingle as they grow, filling out covering your back abdomen until they are large enough to lift you from the ground and allow you to fly! You give a few experimental flaps and begin hovering in place, a giddy smile plastered on your face by the thrill of flight. <b>You now have large Mantis wings!</b>";
	    player.wings.type = Wings.MANTIS_LARGE;

	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(WingsMem.getMemory(WingsMem.MANTIS_LARGE));
	  },
	  // is present
	  function (): Boolean {
	    return player.wings.type === Wings.MANTIS_LARGE;
	  }
	);

	public const WingsMantisSmall: Transformation = new SimpleTransformation("Mantis Small Wings",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.applyTFIfNotPresent(transformations.WingsNone, doOutput);

	    desc += "You feel an itching between your shoulder-blades as something begins growing there. You twist and contort yourself, trying to scratch and bring yourself relief, and failing miserably. A sense of relief erupts from you as you feel something new grow out from your body.";
	    desc += "\nYou hastily remove the top portion of your [armor] and marvel as a pair of small Insectile wings sprout from your back. Tenderly flexing your new muscles, you find you can flap them quite fast. Unfortunately you can’t seem to flap your little wings fast enough to fly, but they would certainly slow a fall. "+
				"A few quick modifications to your [armor] later and you are ready to continue your journey with <b>your new mantis wings</b>.";
	    player.wings.type = Wings.MANTIS_SMALL;

	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(WingsMem.getMemory(WingsMem.MANTIS_SMALL));
	  },
	  // is present
	  function (): Boolean {
	    return player.wings.type === Wings.MANTIS_SMALL;
	  }
	);

	public const WingsDraconicHuge: Transformation = new SimpleTransformation("Draconic Huge Wings",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.applyTFIfNotPresent(transformations.WingsDraconicLarge, doOutput);

	    desc += "A not-unpleasant tingling sensation again fills your wings, almost but not quite drowning out the odd, tickly feeling as they swell larger and stronger than before. You spread them wide - they stretch now more than twice further than your arms do - and beat them experimentally, the powerful thrusts sending gusts of wind, and lifting you off your feet effortlesly. "+
				"<b>You now have fully-grown majestic dragon wings, capable of winging you through the air elegantly!</b>";
	    player.wings.type = Wings.DRACONIC_HUGE;

	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(WingsMem.getMemory(WingsMem.DRACONIC_HUGE));
	  },
	  // is present
	  function (): Boolean {
	    return player.wings.type === Wings.DRACONIC_HUGE;
	  }
	);

	public const WingsDraconicLarge: Transformation = new SimpleTransformation("Draconic Large Wings",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.applyTFIfNotPresent(transformations.WingsDraconicSmall, doOutput);

	    desc += "A not-unpleasant tingling sensation fills your wings, almost but not quite drowning out the odd, tickly feeling as they swell larger and stronger. You spread them wide - they stretch further than your arms do - and beat them experimentally, the powerful thrusts sending gusts of wind, and almost lifting you off your feet. "+
				"<b>You now have fully-grown dragon wings, capable of winging you through the air elegantly!</b>";
	    player.wings.type = Wings.DRACONIC_LARGE;

	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(WingsMem.getMemory(WingsMem.DRACONIC_LARGE));
	  },
	  // is present
	  function (): Boolean {
	    return player.wings.type === Wings.DRACONIC_LARGE;
	  }
	);

	public const WingsDraconicSmall: Transformation = new SimpleTransformation("Draconic Small Wings",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    if (player.wings.type == Wings.NONE) desc += "You double over as waves of pain suddenly fill your shoulderblades; your back feels like it's swelling, flesh and muscles ballooning. A sudden sound of tearing brings with it relief and you straighten up. Upon your back now sit small, leathery wings, not unlike a bat's. "+
				"<b>You now have small dragon wings. They're not big enough to fly with, but they look adorable.</b>";
	    else desc += "A sensation of numbness suddenly fills your wings. When it dies away, they feel... different. Looking back, you realize that they have been replaced by new, small wings, ones that you can only describe as draconic. <b>Your wings have changed into dragon wings.</b>";
	    player.wings.type = Wings.DRACONIC_SMALL;

	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(WingsMem.getMemory(WingsMem.DRACONIC_SMALL));
	  },
	  // is present
	  function (): Boolean {
	    return player.wings.type === Wings.DRACONIC_SMALL;
	  }
	);

	public const WingsFeatheredPhoenix: Transformation = new SimpleTransformation("Feathered Phoenix Wings",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "Pain lances through your back, the muscles knotting oddly and pressing up to bulge your [skin.type]. It hurts, oh gods does it hurt, but you can't get a good angle to feel at the source of your agony. A loud crack splits the air, and then your body is forcing a pair of narrow limbs through a gap in your [armor]. Blood pumps through the new appendages, easing the pain as they fill out and grow. "+
				"Tentatively, you find yourself flexing muscles you didn't know you had, and <b>you're able to curve the new growths far enough around to behold your brand new, crimson wings.</b>";

	    player.wings.type = Wings.FEATHERED_PHOENIX;
	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(WingsMem.getMemory(WingsMem.FEATHERED_PHOENIX));
	  },
	  // is present
	  function (): Boolean {
	    return player.wings.type === Wings.FEATHERED_PHOENIX;
	  }
	);

	public const WingsFeatheredLarge: Transformation = new SimpleTransformation("Feathered Large Wings",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    if (player.wings.type > Wings.NONE) desc += "Sensation fades from your " + player.wings.desc + " wings slowly but surely, leaving them dried out husks that break off to fall on the ground. Your back closes up to conceal the loss, as smooth and unbroken as the day you entered the portal.";
	    desc += "Pain lances through your back, the muscles knotting oddly and pressing up to bulge your [skin.type]. It hurts, oh gods does it hurt, but you can't get a good angle to feel at the source of your agony. A loud crack splits the air, and then your body is forcing a pair of narrow limbs through a gap in your [armor]. Blood pumps through the new appendages, easing the pain as they fill out and grow. "+
				"Tentatively, you find yourself flexing muscles you didn't know you had, and <b>you're able to curve the new growths far enough around to behold your brand new, [haircolor] wings.</b>";
	    player.wings.type = Wings.FEATHERED_LARGE;

	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(WingsMem.getMemory(WingsMem.FEATHERED_LARGE));
	  },
	  // is present
	  function (): Boolean {
	    return player.wings.type === Wings.FEATHERED_LARGE;
	  }
	);

	public const WingsBeeLarge: Transformation = new SimpleTransformation("Bee Large Wings",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.applyTFIfNotPresent(transformations.WingsBeeSmall, doOutput);

	    desc += "Your wings tingle as they grow, filling out until they are large enough to lift you from the ground and allow you to fly! <b>You now have large bee wings!</b> You give a few experimental flaps and begin hovering in place, a giddy smile plastered on your face by the thrill of flight.";
	    player.wings.type = Wings.BEE_LARGE;

	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(WingsMem.getMemory(WingsMem.BEE_LARGE));
	  },
	  // is present
	  function (): Boolean {
	    return player.wings.type === Wings.BEE_LARGE;
	  }
	);

	public const WingsBeeSmall: Transformation = new SimpleTransformation("Bee Small Wings",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "You feel an itching between your shoulder-blades as something begins growing there. You twist and contort yourself, trying to scratch and bring yourself relief, and failing miserably. A sense of relief erupts from you as you feel something new grow out from your body. You hastily remove the top portion of your [armor] and marvel as a pair of small bee-like wings sprout from your back. "+
				"Tenderly flexing your new muscles, you find you can flap them quite fast. Unfortunately you can't seem to flap your little wings fast enough to fly, but they would certainly slow a fall. A few quick modifications to your [armor] later and you are ready to continue your journey with <b>your new bee wings</b>.";
	    player.wings.type = Wings.BEE_SMALL;

	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(WingsMem.getMemory(WingsMem.BEE_SMALL));
	  },
	  // is present
	  function (): Boolean {
	    return player.wings.type === Wings.BEE_SMALL;
	  }
	);

	// UNUSED
	// public const WingsDemonicQuadrupleLarge: Transformation = new SimpleTransformation("Demonic Large Quadruple Wings",
	//   // apply effect
	//   function (doOutput: Boolean): void {
	//     var desc: String = "";

	//     TransformationUtils.applyTFIfNotPresent(transformations.WingsDemonicLarge, doOutput);

	//     desc += "Your large demonic wings starts to tremble and then starts to split from the tip. You stretch over your shoulder to stroke them as they divide, turning into two pairs of full-sized demon-wings. <b>Your demonic wings have splited into two pairs!</b>";
	//     player.wings.desc = "two large pairs of bat-like";
	//     player.wings.type = Wings.BAT_LIKE_LARGE_2;

	//     if (doOutput) outputText(desc);
	//     Metamorph.unlockMetamorph(WingsMem.getMemory(WingsMem.DEMONIC_LARGE_X4));
	//   },
	//   // is present
	//   function (): Boolean {
	//     return player.wings.type === Wings.BAT_LIKE_LARGE_2;
	//   }
	// );

	public const WingsDemonicLarge: Transformation = new SimpleTransformation("Demonic Large Wings",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.applyTFIfNotPresent(transformations.WingsDemonicTiny, doOutput);

	    if (player.wings.type == Wings.DRACONIC_LARGE || player.wings.type == Wings.BEE_LARGE || player.wings.type == Wings.MANTIS_LARGE || player.wings.type == Wings.MANTICORE_LARGE) {
	      desc += "The muscles around your shoulders bunch up uncomfortably, changing to support your wings as you feel their weight increasing. You twist your head as far as you can for a look and realize they've changed into large <b>bat-like demon-wings!</b>";
	    } else {
	      desc += "Your small demonic wings stretch and grow, tingling with the pleasure of being attached to such a tainted body. You stretch over your shoulder to stroke them as they unfurl, turning into full-sized demon-wings. <b>Your demonic wings have grown!</b>";
	    }

	    player.wings.type = Wings.BAT_LIKE_LARGE;

	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(WingsMem.getMemory(WingsMem.DEMONIC_LARGE));
	  },
	  // is present
	  function (): Boolean {
	    return player.wings.type === Wings.BAT_LIKE_LARGE;
	  }
	);

	public const WingsDemonicTiny: Transformation = new SimpleTransformation("Demonic Tiny Wings",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.applyTFIfNotPresent(transformations.WingsNone, doOutput);

	    desc += "A knot of pain forms in your shoulders as they tense up. With a surprising force, a pair of small demonic wings sprout from your back, ripping a pair of holes in the back of your [armor]. <b>You now have tiny demonic wings</b>.";
	    player.wings.type = Wings.BAT_LIKE_TINY;

	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(WingsMem.getMemory(WingsMem.DEMONIC_TINY));
	  },
	  // is present
	  function (): Boolean {
	    return player.wings.type === Wings.BAT_LIKE_TINY;
	  }
	);

	public const WingsVampire: Transformation = new SimpleTransformation("Vampire Wings",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "A terrible pain flares in the center of your back, a pain so intense that you black out briefly, coming back to your senses as you hit your head against the ground. You hear a horrifying ripping noise as your back stretches and tears to allow new bones to expand, black as tar and far lighter than most of the bones in your body. "+
				"These new bones shift under your shoulder blade skin as you fall on all groaning in pain and clawing at the ground. In a flash of pain they violently break out of your skin sending blood everywhere as you make a chilling scream your wounds slowly closing on their own. Still panting from the pain, you take a look at your new appendage. "+
				"It's a pair of large vampire wings of impressive size. Feeling chilly you fold them back on your body and you ought to admit they indeed look like a large cape. <b>You will be able to enjoy nightly flight using your brand new vampire wings.</b>";
	    player.wings.type = Wings.VAMPIRE;

	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(WingsMem.getMemory(WingsMem.VAMPIRE));
	  },
	  // is present
	  function (): Boolean {
	    return player.wings.type === Wings.VAMPIRE;
	  }
	);

	public const WingsFeatheredAvian: Transformation = new SimpleTransformation("Feathered Avian Wings",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    if (player.wings.type == Wings.DRACONIC_SMALL || player.wings.type == Wings.DRACONIC_LARGE || player.wings.type == Wings.DRACONIC_HUGE || player.wings.type == Wings.BAT_LIKE_TINY || player.wings.type == Wings.BAT_LIKE_LARGE || player.wings.type == Wings.BAT_LIKE_LARGE_2 || Arms.canFly(player.arms.type) || player.wings.type == Wings.VAMPIRE) {
	      desc += "Your wings feel suddenly heavier, and you’re forced to sit down to keep balance. Putting attention to the things happening at your back, you realize that the scales covering them are falling!";
	      desc += "A bit alarmed, you’re surprised when, not much later, feathers started sprouting everywhere on them. t all the same, as long ones grow at the base, while shorter ones appear on the upper part of them and near your shoulders. When all the growth is finished, your wings are left with a much more bird-like appearance.";
	      desc += "<b>In the end, your pair of now avian wings will carry you to skies with ease.</b>";
	    } else if (player.wings.type > Wings.NONE) {
	      desc += "Your wings feel suddenly heavier, and you’re forced to sit down to keep balance. Putting attention to the things happening at your back, you realize that the delicate tissue of them is becoming skin and flesh, with bones sprouting inside and placing themselves to support the added weight.";
	      desc += "Once the muscles and bones are correctly formed, feathers start sprouting everywhere on them. Not all the same, as long ones grow at the base, while shorter ones appear on the upper part of them and near your shoulders. When all the growth is finished, your wings are left with a much more bird-like appearance.";
	      desc += "<b>In the end, your pair of now avian wings will carry you to skies with ease.</b>";
	    } else {
	      desc += "A sudden ache overcomes your back, when you’re at the middle of your daily routine. Knowing from before how hazardous is the food found on the wilds of Mareth, you curse the strange seed that you’ve just eat for this painful state.";
	      desc += "Before you can find something to soothe the pain, a piercing sensation of something tearing its way of of your flesh and skin makes you lose the balance and fall. Instinctively, you take off the upper part of your [armor] so anything that it’s growing from back there makes they way out without any trouble.";
	      desc += "When everything finishes, you take a look at your backside, noticing two shapes sprouting from your upper back. They grow and grow, and when you recognize them as wings, they’ve already grown to carry with your body ease through the skies. Once the growth stops, you extend them and flex your newly gained bones and muscles. <b>Seems like you’ve gained a pair of avian wings!</b>";
	    }

	    player.wings.type = Wings.FEATHERED_AVIAN;

	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.wings.type === Wings.FEATHERED_AVIAN;
	  }
	);

	public const WingsEthereal: Transformation = new SimpleTransformation("Ethereal Wings Wings",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "Your body feels lighter than usual, almost as if you’re floating on air. Unintentionally you lean forward, finding yourself floating a few feet off the ground. Confused as to what is happening, you try to move, floating a few paces in the direction you want to go. That’s when you notice three pairs of wispy otherworldly tendrils growing out of your back. "+
				"They glow faintly and almost appear as though they’re moving with the wind. They don’t even hold any weight. <b>You can get used to floating like this with your ethereal wings.</b>";

	    player.wings.type = Wings.ETHEREAL;
	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.wings.type === Wings.ETHEREAL;
	  }
	);

	public const WingsLevitation: Transformation = new SimpleTransformation("Levitation Wings",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "You feel so tired you could fall on your knees but to your surprise you don't. Instead of actually hitting the ground you simply float in the air. <b>You are now naturally levitating.</b>";

	    player.wings.type = Wings.LEVITATION;
	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(WingsMem.getMemory(WingsMem.LEVITATION));
	  },
	  // is present
	  function (): Boolean {
	    return player.wings.type === Wings.LEVITATION;
	  }
	);

	public const WingsWindyAura: Transformation = new SimpleTransformation("Windy Aura Wings",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "Winds begin to amass around you as if the prelude to a gathering storm. At first you think you are about to be attacked before you realise it’s all your doing. Merely by thinking about it the wind suddenly blows into a raging tornado carrying you up before you seize control and give it just enough strength to uplift you into its currents. "+
				"It would seem you have gained the infamous wind control power of the kamaitachi achieving mastery over it. Well this is going to be fun to play with. <b>You now have the ability to control winds as the Kamaitachi do using your windy aura!</b>";

	    player.wings.type = Wings.WINDY_AURA;
	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.wings.type === Wings.WINDY_AURA;
	  }
	);

	public const WingsGiantDragonfly: Transformation = new SimpleTransformation("Giant Dragonfly Wings",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "You scream and fall to your knees as incredible pain snags at your shoulders, as if needle like hooks were being sunk into your flesh just below your shoulder blades. After about five seconds of white hot, keening agony it is with almost sexual relief that something splits out of your upper back. You clench the dirt as you slide what feel like giant leaves of paper into the open air. "+
				"Eventually the sensation passes and you groggily get to your feet. You can barely believe what you can see by craning your neck behind you - <b>you've grown a set of four giant dragonfly wings</b>, thinner, longer and more pointed than the ones you've seen upon the forest bee girls, but no less diaphanous and beautiful. "+
				"You cautiously flex the new muscle groups in your shoulder blades and gasp as your new wings whirr and lift you several inches off the ground. What fun this is going to be!";

	    player.wings.type = Wings.GIANT_DRAGONFLY;
	    if (doOutput) outputText(desc);
		  Metamorph.unlockMetamorph(WingsMem.getMemory(WingsMem.GIANT_DRAGONFLY));
	  },
	  // is present
	  function (): Boolean {
	    return player.wings.type === Wings.GIANT_DRAGONFLY;
	  }
	);

	public const WingsSeaDragon: Transformation = new SimpleTransformation("Sea Dragon Wings",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    desc += "You keel in pain as you feel something penetrating your back. No, nothing is stabbing your back. More so, something is about to burst from within you. The trauma subsides as large bones emerge. A thin yet sturdy layer of skin covers your wings are covered as they fall into place behind you.\n\nAs you examine the fleshy appendage, you realize it's webbed. "+
				"It seems to resemble more of a giant aquatic flipper than wings. The insides are not only colorful but also display several minute light specks. Not unlike those of a deep-sea beast. <b>You can now fly and swim at great speed with your brand new sea dragon wings!</b>";

	    player.wings.type = Wings.SEA_DRAGON;
	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.wings.type === Wings.SEA_DRAGON;
	  }
	);

	public const WingsDevilfeather: Transformation = new SimpleTransformation("Devilfeather Wings",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    if ((player.wings.type == Wings.BAT_LIKE_LARGE) && player.cor >= 75) {
	      desc += "Your wing shrivels before suddenly changing and covering themselves with black feathers. They still look demonic in a sense, albeit they are feathered now. <b>You now have black, feathered wings!</b>";
	    } else if (player.wings.type == Wings.BEE_SMALL || player.wings.type == Wings.BEE_LARGE) {
	      desc += "The muscles around your shoulders bunch up uncomfortably, changing to support your wings as you feel their weight increasing. You twist your head as far as you can for a look and realize they've changed into <b>black, feathered wings!</b>";
	    } else if (player.wings.type != Wings.NONE) {
	      desc += "A sensation of numbness suddenly fills your wings. When it dies away, they feel... different. Looking back, you realize that they have been replaced by <b>black, feathered wings!</b>";
	    } else {
	      desc += "A knot of pain forms in your shoulders as they tense up. With a surprising force, a pair of black feathered wings sprout from your back, ripping a pair of holes in the back of your [armor]. <b>You now have black, feathered wings!</b>";
	    }

	    player.wings.type = Wings.DEVILFEATHER;
	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.wings.type === Wings.DEVILFEATHER;
	  }
	);

	public const WingsFeyDragon: Transformation = new SimpleTransformation("Fey Dragon Wings",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";
		if ((player.wings.type == Wings.NONE)) {
			desc += "You keel in pain as you feel something penetrating your back. No, nothing is stabbing your back. More so, something is about to burst from within you. The trauma subsides as large bones emerge. A thin yet sturdy layer of skin covers your wings are covered as they fall into place behind you.\n\nAs you examine the fleshy appendage, you realize it's webbed. "+
					"It seems to resemble more of a giant aquatic flipper than wings. The insides are not only colorful but also display several minute light specks. Not unlike those of a deep-sea beast. <b>You can now fly and swim at great speed with your brand new sea dragon wings!</b>";
		}
		if ((player.wings.type != Wings.NONE)) {
			desc += "You ain't even noticing as something messed up happen in your wings. They shrivel and change taking on a delicate almost fairy like appearance and you flap them in awe as they not only feel strong but also agile. You now have a set of <b>fey dragon wings.</b>";
		}
	    player.wings.type = Wings.FEY_DRAGON;
	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.wings.type === Wings.FEY_DRAGON;
	  }
	);

	public const WingsPlant: Transformation = new SimpleTransformation("Plant Wings",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.applyTFIfNotPresent(transformations.WingsNone, doOutput);

	    desc += "Pressure is building in multiple spots on your upper back. It feels more like several over-eager erections trapped in incredibly tight undies. You can’t help but groan with relief when finally the pressure peaks and many thick protrusions burst impatiently out of your [skin.type]. "+
				"The hot, thick, vine-like growths thrust their way into being, feet of oily green tentacles, alarmingly energetic and prehensile, thrashing around your [hips]. After a moment of concentration you cause one of these growths to rear around into your hand to take a closer look at it. "+
				"It feels unmistakably dick-like - bulging, tender flesh under the fibrous skin, with quite a bit of flexible, able to bend all along its length and dart its wet, distended head in any direction you wish. <b>You now have cockvine wings.</b>";

	    player.wings.type = Wings.PLANT;
	    if (doOutput) outputText(desc);
	  },
	  // is present
	  function (): Boolean {
	    return player.wings.type === Wings.PLANT;
	  }
	);

	public const WingsAntLarge: Transformation = new SimpleTransformation("Ant Large Wings",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    TransformationUtils.applyTFIfNotPresent(transformations.WingsAntSmall, doOutput);

		if (player.wings.type == Wings.BEE_LARGE) desc += "You wince as you feel your wings tearing in half, but after a short moment, they start to tingle and grow longer. <b>You now have four large ant wings</b>.";
	    else desc += "Your wings tingle as they grow, filling out until they are large enough to lift you from the ground and allow you to fly! <b>You now have large ant wings!</b> You give a few experimental flaps and begin hovering in place, a giddy smile plastered on your face by the thrill of flight.";
	    player.wings.desc = "large ant-like";
	    player.wings.type = Wings.ANT_LARGE;

	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(WingsMem.getMemory(WingsMem.ANT_LARGE));
	  },
	  // is present
	  function (): Boolean {
	    return player.wings.type === Wings.ANT_LARGE;
	  }
	);

	public const WingsAntSmall: Transformation = new SimpleTransformation("Ant Small Wings",
	  // apply effect
	  function (doOutput: Boolean): void {
	    var desc: String = "";

	    if (player.wings.type == Wings.BEE_SMALL) desc += "You wince as you feel your wings tearing in half, but after a short moment, they start to tingle as they grow into four small ant wings. You still can't fly with them, but <b>you now have small ant wings</b>."
		else desc += "You feel an itching between your shoulder-blades as something begins growing there. You twist and contort yourself, trying to scratch and bring yourself relief, and failing miserably. A sense of relief erupts from you as you feel something new grow out from your body. You hastily remove the top portion of your [armor] and marvel as four small ant-like wings sprout from your back. "+
				"Tenderly flexing your new muscles, you find you can flap them quite fast. Unfortunately you can't seem to flap your little wings fast enough to fly, but they would certainly slow a fall. A few quick modifications to your [armor] later and you are ready to continue your journey with <b>your new ant wings</b>.";
	    player.wings.desc = "small ant-like";
	    player.wings.type = Wings.ANT_SMALL;

	    if (doOutput) outputText(desc);
	    Metamorph.unlockMetamorph(WingsMem.getMemory(WingsMem.ANT_SMALL));
	  },
	  // is present
	  function (): Boolean {
	    return player.wings.type === Wings.ANT_SMALL;
	  }
	);
  /*
*/

/*
*    ███████ ███████ ██   ██ ██    ██  █████  ██
*    ██      ██       ██ ██  ██    ██ ██   ██ ██
*    ███████ █████     ███   ██    ██ ███████ ██
*         ██ ██       ██ ██  ██    ██ ██   ██ ██
*    ███████ ███████ ██   ██  ██████  ██   ██ ███████
*/

/*
*    ██████  ██████  ███████  █████  ███████ ████████ ███████
*    ██   ██ ██   ██ ██      ██   ██ ██         ██    ██
*    ██████  ██████  █████   ███████ ███████    ██    ███████
*    ██   ██ ██   ██ ██      ██   ██      ██    ██         ██
*    ██████  ██   ██ ███████ ██   ██ ███████    ██    ███████
*/

/*
	*/
	public function UnlockBreasts(): void {
		//noinspection FallThroughInSwitchStatementJS	// Fallthrough is intended for retroactively unlocking in Metamorph after getting GeneticMemory
		switch (player.bRows()) {
			case 4: Metamorph.unlockMetamorphEx(BreastMem.getMemory(BreastMem.BREAST4));
			case 3: Metamorph.unlockMetamorphEx(BreastMem.getMemory(BreastMem.BREAST3));
			case 2: Metamorph.unlockMetamorphEx(BreastMem.getMemory(BreastMem.BREAST2));
			case 1: Metamorph.unlockMetamorphEx(BreastMem.getMemory(BreastMem.BREAST1));
				break;
			default: break;
		}
	}

	public const BreastsGrowUpToDD:Transformation = new SimpleTransformation("Grow breasts up to DD",
		// apply effect
		function (doOutput:Boolean):void {
			var row:int = player.smallestTitRow();
			var desc: String = "";

			desc += "Your chest aches and tingles, and your hands reach up to scratch at it unthinkingly. Just as you start to scratch at your " + breastDescript(row) + ", your chest pushes out in slight but sudden growth.";

			if (doOutput) outputText(desc);
			player.breastRows[row].breastRating++;
		},
		// is present
		function ():Boolean {
			return player.smallestTitSize() >= 6;
		}
	);

	public const BreastsShrinkToNothing:Transformation = new SimpleTransformation("Shrink breasts to nothing",
		// apply effect
		function (doOutput:Boolean):void {
			var desc: String = "";

			desc += "A tingle starts in your [nipples] before the tight buds grow warm, hot even.  ";
			if (player.biggestLactation() >= 1) desc += "Somehow, you know that the milk you had been producing is gone, reabsorbed by your body.  ";
			desc += "They pinch in towards your core, shrinking along with your flattening [allbreasts].  You shudder and flex in response.  Your chest isn't just shrinking, it's reforming, sculping itself into a massive pair of chiseled pecs.  ";
			if (player.breastRows.length > 1) {
				desc += "The breasts below vanish entirely.  ";
				while (player.breastRows.length > 1) {
					player.removeBreastRow(player.breastRows.length - 1, 1);
				}
			}
			player.breastRows[0].breastRating = 0;
			player.breastRows[0].nipplesPerBreast = 1;
			player.breastRows[0].fuckable = false;
			if (player.nippleLength > .5) player.nippleLength = .25;
			player.breastRows[0].lactationMultiplier = 0;
			player.removeStatusEffect(StatusEffects.Feeder);
			if (player.hasPerk(PerkLib.Feeder)) {
				outputText("<b>(Perk Lost - Feeder!)</b>\n");
				player.removePerk(PerkLib.Feeder);
			}
			desc += "All too soon, your boobs are gone.  Whoa![pg]";

			if (doOutput) outputText(desc);
		},
		// is present
		function ():Boolean {
			return !player.hasBreasts();
		}
	);

	public const BreastRowsRemoveToOne:Transformation = new SimpleTransformation("One pair of breasts",
		// apply effect
		function (doOutput:Boolean):void {
			var desc: String = "";

			desc += "You stumble back when your center of balance shifts, and though you adjust before you can fall over, you're left to watch in awe as your bottom-most " + breastDescript(player.breastRows.length - 1) + " shrink down, disappearing completely into your ";
			if (player.bRows() >= 3) desc += "abdomen";
			else desc += "chest";
				desc += ". The " + nippleDescript(player.breastRows.length - 1) + "s even fade until nothing but ";
			//if (player.isFurCovered()) outputText(player.hairColor + " " + player.skinDesc);
			//else outputText(player.bodyColor + " " + player.skinDesc);
			desc += "[skin full] remains. <b>You've lost a row of breasts!</b>";

			if (doOutput) outputText(desc);
			dynStats("sen", -5);
			player.removeBreastRow(player.breastRows.length - 1, 1);
			transformations.UnlockBreasts();
		},
		// is present
		function ():Boolean {
			return player.breastRows.length <= 1;
		}
	);

	public const BreastRowsOne:Transformation = new SimpleTransformation("One pair of breasts ONLY",
		// apply effect
		function (doOutput:Boolean):void {
			var desc: String = "";

			while (player.bRows() > 1)
				transformations.BreastRowsRemoveToOne.applyEffect(doOutput);

			if (player.bRows() == 0 || player.breastRows[0].breastRating < 3) {
				transformations.CreateBreastRow(3).applyEffect(doOutput);
			}

			if (doOutput) outputText(desc);
		},
		// is present
		function ():Boolean {
			return player.breastRows.length == 1 && (player.breastRows[0].breastRating > BreastCup.FLAT);
		}
	);

	public const BreastRowsTwo:Transformation = new SimpleTransformation("Two pairs of breasts ONLY",
		// apply effect
		function (doOutput:Boolean):void {
			var desc: String = "";

			while (player.bRows() > 2)
				transformations.BreastRowsRemoveToOne.applyEffect(doOutput);

			if (player.bRows() == 0 || player.breastRows[0].breastRating < 3) {
				transformations.CreateBreastRow(3).applyEffect(doOutput);
				desc += "[pg]"
			}
			if (player.bRows() < 2)
				transformations.CopyBreastRow().applyEffect();

			if (doOutput) outputText(desc);
		},
		// is present
		function ():Boolean {
			return player.breastRows.length == 2;
		}
	);

	public const BreastRowsThree:Transformation = new SimpleTransformation("Three pairs of breasts ONLY",
		// apply effect
		function (doOutput:Boolean):void {
			var desc: String = "";

			while (player.bRows() > 3)
				transformations.BreastRowsRemoveToOne.applyEffect(doOutput);

			if (player.bRows() == 0 || player.breastRows[0].breastRating < 3) {
				transformations.CreateBreastRow(3).applyEffect(doOutput);
				desc += "[pg]"
			}
			var first:Boolean = true;
			while (player.bRows() < 3) {
				transformations.CopyBreastRow().applyEffect(first);
				if (!first)
					desc += "[pg]Another row of breasts grow in at " + player.breastCup(player.bRows()-1) + ", looking just like the row above";
				first = false;
			}

			if (doOutput) outputText(desc);
		},
		// is present
		function ():Boolean {
			return player.breastRows.length == 3;
		}
	);

	public const BreastRowsFour:Transformation = new SimpleTransformation("Four pairs of breasts ONLY",
		// apply effect
		function (doOutput:Boolean):void {
			var desc: String = "";

			while (player.bRows() > 4)
				transformations.BreastRowsRemoveToOne.applyEffect(doOutput);

			if (player.bRows() == 0 || player.breastRows[0].breastRating < 3) {
				transformations.CreateBreastRow(3).applyEffect(doOutput);
				desc += "[pg]"
			}
			var first:Boolean = true;
			while (player.bRows() < 4) {
				transformations.CopyBreastRow().applyEffect(first);
				if (!first)
					desc += "[pg]Another row of breasts grow in at " + player.breastCup(player.bRows()-1) + ", looking just like the row above";
				first = false;
			}

			if (doOutput) outputText(desc);
		},
		// is present
		function ():Boolean {
			return player.breastRows.length == 4;
		}
	);

	public function CreateBreastRow(size:int = 2):Transformation { return new SimpleTransformation("Create a breast row",
		// apply effect
		function (doOutput:Boolean):void {
			var desc:String = "[pg]";

			if (size < 0) size = 0;
			if (player.bRows() < 3 || player.breastRows[0].breastRating < size)
				desc += "Your chest tingles uncomfortably as your center of balance shifts.  <b>You now have a pair of " +breastSize(size)+ " breasts.</b>";
			else {
				if (size == 0) desc += "Your abdomen tingles and twitches as a new row of breasts sprouts below the others.";
				else desc +="Your abdomen tingles and twitches as a new row of " + breastSize(size) + " " + breastDescript(player.bRows()-1) + " sprouts below your others.";

			}
			if (player.bRows() == 0) {
				desc += "  A sensitive nub grows on the summit of each tit, becoming a new nipple.";
				player.createBreastRow(size);
				if (player.nippleLength < .25) player.nippleLength = .25;
			} else if (player.breastRows[0].breastRating == BreastCup.FLAT) {
				player.breastRows[0].breastRating = size;
			} else {
				player.createBreastRow(size, player.breastRows[player.bRows() - 1].nipplesPerBreast);
				if (player.breastRows[player.bRows() - 1].nipplesPerBreast == 1)
					desc += "  A sensitive nub grows on the summit of each tit, becoming a new nipple.";
				else
					desc += "  A set of sensitive nubs grow on the summit of each tit, becoming new nipples.";
				if (player.hasFuckableNipples()) {
					player.breastRows[player.bRows() - 1].fuckable = true;
					desc += "  Your new nipples are leaking and you can even press your finger inside, they are fuckable!"
				}
				player.breastRows[player.bRows() - 1].lactationMultiplier = player.breastRows[player.bRows() - 2].lactationMultiplier;
				dynStats("lus", 30);
				player.addCurse("sen", 2, 1);
			}
			if (doOutput) outputText(desc);
			transformations.UnlockBreasts();
		},
		// is present
		function ():Boolean {
			return player.bRows() >= 4;
		}
	); }

	public function CopyBreastRow(keepSize:Boolean = false):Transformation { return new SimpleTransformation("Copy last breast row but shrink 1 size",
		// apply effect
		function (doOutput:Boolean):void {
			var desc:String = "[pg]";

			if (player.breastRows[player.bRows() - 1].breastRating > BreastCup.FLAT) {
				var size:Number = player.breastRows[player.bRows() - 1].breastRating;
				if (!keepSize) size--;
				if (size < 0) size = 0;
				desc += "There's an itching below your [allbreasts].  You idly scratch at it, but gods be damned, it hurts!  You peel off part of your [armor] to inspect the unwholesome itch, ";
				if (player.biggestTitSize() >= 8) desc += "it's difficult to see past the wall of tits obscuring your view.";
				else desc += "it's hard to get a good look at.";
				desc += "  A few gentle prods draw a pleasant gasp from your lips, and you realize that you didn't have an itch - you were growing new nipples!";
				desc += "[pg]A closer examination reveals your new nipples to be just like the ones above in size and shape";
				if (player.breastRows[player.bRows() - 1].nipplesPerBreast > 1) desc += ", not to mention number";
				else if (player.hasFuckableNipples()) desc += ", not to mention penetrability";
				if (size > 0) {
					desc += ".  While you continue to explore your body's newest addition, a strange heat builds behind the new nubs. Soft, jiggly breastflesh begins to fill your cupped hands.  Radiant warmth spreads through you, eliciting a moan of pleasure from your lips as your new breasts ";
					if (keepSize) desc += "catch up to the pair above.";
					else desc += "stop just short of the ones above.";
					desc += "  They stop at " + breastSize(size) + "s.";
				} else desc += "  Your new breasts stay flat and masculine, not growing any larger.";
				desc += "  <b>You have " + num2Text(player.bRows() + 1) + " rows of breasts!</b>";
				if (doOutput) outputText(desc);

				player.createBreastRow(size, player.breastRows[player.bRows() - 1].nipplesPerBreast);
				if (player.hasFuckableNipples()) player.breastRows[player.bRows() - 1].fuckable = true;
				player.breastRows[player.bRows() - 1].lactationMultiplier = player.breastRows[player.bRows() - 2].lactationMultiplier;
				dynStats("lus", 30);
				player.addCurse("sen", 2, 1);
			}
			else transformations.CreateBreastRow(2).applyEffect(doOutput);
			transformations.UnlockBreasts();
		},
		// is present
		function ():Boolean {
			return player.bRows() >= 4;
		}
	); }

	public const NipplesPerBreastOne:Transformation = new SimpleTransformation("One nipple per breast",
		// apply effect
		function (doOutput:Boolean):void {
			var desc: String = "";

			desc += "A chill runs over your [allbreasts] and vanishes. You stick a hand under your [armor] and discover that your extra nipples are missing!  You're down to just one per ";
			if (player.biggestTitSize() < 1) desc += "'breast'.";
			else desc += "breast.";


			if (doOutput) outputText(desc);
			for (var i:int = 0; i < player.breastRows.length; i++)
				player.breastRows[i].nipplesPerBreast = 1;
		},
		// is present
		function ():Boolean {
			return player.averageNipplesPerBreast() == 1;
		}
	);

	public const NipplesPerBreastFour:Transformation = new SimpleTransformation("Four nipples per breast",
		// apply effect
		function (doOutput:Boolean):void {
			var desc: String = "";
			TransformationUtils.applyTFIfNotPresent(transformations.NipplesUnfuck, doOutput);

			desc += "[pg]Your " + nippleDescript(0) + "s tingle and itch.  You pull back your [armor] and watch in shock as they split into four distinct nipples!  <b>You now have four nipples on each side of your chest!</b>";
			if (player.breastRows.length >= 2 && player.breastRows[1].nipplesPerBreast == 1)
				desc += "A moment later your second row of " + breastDescript(1) + " does the same.";
			if (player.breastRows.length >= 3 && player.breastRows[2].nipplesPerBreast == 1) {
				desc += "Finally, your ";
				if (player.bRows() == 3) desc +="third row of " + breastDescript(2) + " mutates along with its sisters, sprouting into a wonderland of nipples.";
				else desc +="everything from the third row down mutates, sprouting into a wonderland of nipples.";
			}
			if (doOutput) outputText(desc);
			for (var i:int = 0; i < player.breastRows.length; i++)
				player.breastRows[i].nipplesPerBreast = 4;
			if (player.bRows() > 1)
				outputText("  <b>You have a total of " + num2Text(player.totalNipples()) + " nipples.</b>");
			Metamorph.unlockMetamorph(BreastMem.getMemory(BreastMem.QUADNIPPLE));
		},
		// is present
		function ():Boolean {
			return player.averageNipplesPerBreast() == 4;
		}
	);

	public const NipplesFuckableForce:Transformation = new SimpleTransformation("Increase Nipple size >= 2",
		// apply effect
		function (doOutput:Boolean):void {
			var desc: String = "";
			if (player.nippleLength < 2) {
				desc += "[pg]Your nipples engorge, prodding hard against the inside of your [armor].  Abruptly you realize they've grown rapidly to 2 inches."
				player.nippleLength = 2;
			}
			if (doOutput) outputText(desc);

			TransformationUtils.applyTFIfNotPresent(transformations.NipplesFuckable, doOutput);
		},
		// is present
		function ():Boolean {
			return player.hasFuckableNipples();
		}
	);

	public const NipplesFuckable:Transformation = new SimpleTransformation("Fuckable nipples",
		// apply effect
		function (doOutput:Boolean):void {
			var desc: String = "";
			TransformationUtils.applyTFIfNotPresent(transformations.NipplesPerBreastOne, doOutput);

			var nowFuckable:Boolean;
			//Set nipplecunts on every row.
			for (var i:int = 0; i < player.breastRows.length; i++)
				if (!player.breastRows[i].fuckable && player.nippleLength >= 2) {
					player.breastRows[i].fuckable = true;
					nowFuckable = true;
				}
			desc += "[pg]Your [allbreasts] tingle with warmth that slowly migrates to your nipples, filling them with warmth.  You pant and moan, rubbing them with your fingers.  A trickle of wetness suddenly coats your finger as it slips inside the nipple.  Shocked, you pull the finger free.  <b>You now have fuckable nipples!</b>";
			//Talk about if anything was changed.
			if (doOutput && nowFuckable) outputText(desc);
			if (nowFuckable) Metamorph.unlockMetamorph(BreastMem.getMemory(BreastMem.FUCKNIPPLE));
		},
		// is present
		function ():Boolean {
			return player.hasFuckableNipples() || player.biggestTitSize() == 0;
		},
		// is possible
		function ():Boolean {
			return !player.hasFuckableNipples() && player.bRows() > 0 && player.averageNipplesPerBreast() == 1 && player.nippleLength >= 2
		}
	);

	public const NipplesUnfuck:Transformation = new SimpleTransformation("Unfuck nipples",
		// apply effect
		function (doOutput:Boolean): void {
			var desc: String = "";
			var unfucked:Boolean;
			for (var i:int = 0; i < player.breastRows.length; i++)
				if (player.breastRows[i].fuckable) {
					player.breastRows[i].fuckable = false;
					unfucked = true;
				}
			desc += "[pg]Your [allbreasts] tingle with a chill that slowly migrates to your nipples.  You pant and moan, rubbing them with your fingers.  You notice that you can no longer penetrate your nipples like before.  ";
			//Talk about if anything was changed.
			if (doOutput && unfucked) outputText(desc);
		},
		// is present
		function (): Boolean {
			return !player.hasFuckableNipples();
		}
	);

	public const StartLactation:Transformation = new SimpleTransformation("Start lactating",
			// apply effect
			function (doOutput:Boolean):void {
				var desc: String = "[pg]";

				desc += "You feel your [nipple]s become tight and engorged.  A single droplet of milk escapes each, rolling down the curves of your breasts.  <b>You are now lactating!</b>";
				for (var i:int = 0; i < player.breastRows.length; i++) {
					player.breastRows[i].lactationMultiplier += 2;
				}

				if (doOutput) outputText(desc);
			},
			// is present
			function ():Boolean {
				return player.isLactating();
			}
	);

	public const RemoveLactation:Transformation = new SimpleTransformation("Stop lactating",
		// apply effect
		function (doOutput:Boolean):void {
			var desc: String = "";

			if (player.totalNipples() == 2) desc += "[pg]Both of your";
			else desc += "[pg]All of your many";
			desc += " nipples relax.  It's a strange feeling, and you pull back your top to touch one.  It feels fine, though there doesn't seem to be any milk leaking out.  You give it a squeeze and marvel when nothing ";
			if (player.hasFuckableNipples()) desc += "but sexual fluid ";
			desc += "escapes it.  <b>You are no longer lactating.</b>  That makes sense, only mammals lactate!  Smiling, you muse at how much time this will save you when cleaning your gear.";
			if (player.hasPerk(PerkLib.Feeder) || player.hasStatusEffect(StatusEffects.Feeder)) {
				desc += "[pg](<b>Feeder perk lost!</b>)";
				player.removePerk(PerkLib.Feeder);
				player.removeStatusEffect(StatusEffects.Feeder);
			}
			//Loop through and reset lactation
			for (var i:int = 0; i < player.breastRows.length; i++) {
				player.breastRows[i].lactationMultiplier = 0;
			}
			if (doOutput) outputText(desc);
		},
		// is present
		function ():Boolean {
			return !player.isLactating();
		}
	);

	public const NipplesNoColor:Transformation = new SimpleTransformation("Black nipples",
		// apply effect
		function (doOutput:Boolean):void {
			var desc: String = "";

			//Cant have multicoloured nips...
			if (player.hasStatusEffect(StatusEffects.GlowingNipples) || player.hasStatusEffect(StatusEffects.BlackNipples))
				desc +="[pg]Something invisible brushes against your [nipples], making you twitch.  Undoing your clothes, you take a look at your chest and find that your nipples have turned back to their natural flesh colour.";
			if (player.hasStatusEffect(StatusEffects.GlowingNipples))
				player.removeStatusEffect(StatusEffects.GlowingNipples);
			if (player.hasStatusEffect(StatusEffects.BlackNipples))
				player.removeStatusEffect(StatusEffects.BlackNipples);

			if (doOutput) outputText(desc);
		},
		// is present
		function ():Boolean {
			return !player.hasStatusEffect(StatusEffects.BlackNipples) && !player.hasStatusEffect(StatusEffects.GlowingNipples);
		}
	);

	public const NipplesBlack:Transformation = new SimpleTransformation("Black nipples",
		// apply effect
		function (doOutput:Boolean):void {
			var desc: String = "";

			//Cant have multicoloured nips...
			TransformationUtils.applyTFIfNotPresent(transformations.NipplesNoColor, doOutput);

			desc += "A tickling sensation plucks at your nipples and you cringe, trying not to giggle. Looking down you are in time to see the last spot of flesh tone disappear from your [nipples]. They have turned an onyx black!";

			if (doOutput) outputText(desc);
			player.createStatusEffect(StatusEffects.BlackNipples, 0, 0, 0, 0);
			Metamorph.unlockMetamorph(BreastMem.getMemory(BreastMem.BLACKNIPPLE));
		},
		// is present
		function ():Boolean {
			return player.hasStatusEffect(StatusEffects.BlackNipples);
		}
	);

	public const NipplesGlowing:Transformation = new SimpleTransformation("Glowing nipples",
		// apply effect
		function (doOutput:Boolean):void {
			var desc: String = "";

			//Cant have multicoloured nips...
			TransformationUtils.applyTFIfNotPresent(transformations.NipplesNoColor, doOutput);

			desc += "[pg]You suddenly feel an itch in your nipples and undress to check up on them. To your surprise they begin to glow with a fluorescent blue light as latent electricity build up within them. Well, this will be interesting.  <b>You now have neon blue nipples that glow in the dark.</b>";

			if (doOutput) outputText(desc);
			player.createStatusEffect(StatusEffects.GlowingNipples, 0, 0, 0, 0);
			Metamorph.unlockMetamorph(BreastMem.getMemory(BreastMem.GLOWINGNIPPLE));
		},
		// is present
		function ():Boolean {
			return player.hasStatusEffect(StatusEffects.GlowingNipples);
		}
	);
	/*
*/

/*
*     █████  ███████ ███████
*    ██   ██ ██      ██
*    ███████ ███████ ███████
*    ██   ██      ██      ██
*    ██   ██ ███████ ███████
*/

/*
	*/
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
	);
	/*
*/

/*
*	 ██       ██  █████   ██████  ██ ███   ██  █████
* 	  ██     ██  ██   ██ ██       ██ ████  ██ ██   ██
* 	   ██   ██   ███████ ██   ███ ██ ██ ██ ██ ███████
* 	    ██ ██    ██   ██ ██    ██ ██ ██  ████ ██   ██
*	     ███     ██   ██  ██████  ██ ██   ███ ██   ██
*/

/*
    */
	public function UnlockVagina(): void {
		//noinspection FallThroughInSwitchStatementJS	// Fallthrough is intended for retroactively unlocking in Metamorph after getting GeneticMemory
		switch (player.vaginas.length) {
			case 2: Metamorph.unlockMetamorphEx(VaginaCountMem.getMemory(VaginaCountMem.VAGINA2));
			case 1: Metamorph.unlockMetamorphEx(VaginaCountMem.getMemory(VaginaCountMem.VAGINA1));
				break;
			default: break;
		}
	}

	public function VaginaNone(vagina:int = 0): Transformation {
		return new SimpleTransformation("Remove Vagina",
			// apply effect
			function (doOutput:Boolean):void {
				var desc:String = "[pg]";

				if (player.hasVagina()) {
					desc += "A tightness in your groin is the only warning you get before your <b>[vagina "+(vagina+1)+"] disappears completely</b>!";
					if (doOutput) outputText(desc);

					player.removeVagina(vagina, 1);
				}
			},
			// is present
			function ():Boolean {
				return !player.hasVagina();
			}
		);
	}

	public function CockToVagina(vagina:int = 0): Transformation {
		return new SimpleTransformation("Remove Vagina",
			// apply effect
			function (doOutput:Boolean):void {
				var desc:String = "[pg]";

				if (player.cockTotal() == 1 && !player.hasVagina()) {
					desc += "Your [cock] suddenly starts tingling.  It's a familiar feeling, similar to an orgasm.  However, this one seems to start from the top down, instead of gushing up from your loins.  You spend a few seconds frozen to the odd sensation, when it suddenly feels as though your own body starts sucking on the base of your shaft.  Almost instantly, your cock sinks into your crotch with a wet slurp.  The tip gets stuck on the front of your body on the way down, but your glans soon loses all volume to turn into a shiny new clit.";
					if (!flags[kFLAGS.HYPER_HAPPY]) {
						if (player.balls > 0) desc += "  At the same time, your [balls] fall victim to the same sensation; eagerly swallowed whole by your crotch.";
						desc += "  Curious, you touch around down there, to find you don't have any exterior organs left.  All of it got swallowed into the gash you now have running between two fleshy folds, like sensitive lips.  It suddenly occurs to you; <b>you now have a vagina!</b>";
						player.balls = 0;
						player.ballSize = 1;
						transformations.VaginaHuman().applyEffect(false);
						player.removeCock(0, 1);
					}
				} else if (!flags[kFLAGS.HYPER_HAPPY]) {
					player.killCocks(1);
				}
				if (doOutput) outputText(desc);
			},
			// is present
			function ():Boolean {
				return player.hasVagina();
			},
			// is possible
			function ():Boolean {
				return !player.hasVagina() && player.hasCock();
			}
		);
	}

	public function GrowVaginaGenericText(): String {
		var desc:String = "";
		if (player.balls > 0) desc += "An itch starts behind your [balls], but before you can reach under to scratch it, the discomfort fades. A moment later a warm, wet feeling brushes your [sack], and curious about the sensation, you lift up your balls to reveal your new vagina. ";
		else if (player.hasCock()) desc += "An itch starts on your groin, just below your [cocks]. You pull the manhood aside to give you a better view, and you're able to watch as your skin splits to give you a new vagina, complete with a tiny clit. ";
		else desc += "An itch starts on your groin and fades before you can take action. Curious about the intermittent sensation, you peek under your [armor] to discover your brand new vagina, complete with pussy lips and a tiny clit. " ;
		player.createVagina();
		player.clitLength = .25;
		return desc;
	}

	public function VaginaHuman(vagina:int = 0): Transformation {
		return new SimpleTransformation("Human Vagina",
			// apply effect
			function (doOutput:Boolean):void {
				var desc:String = "";

				if (player.hasVagina()){
					desc += "Something invisible brushes against your sex, making you twinge.  Undoing your clothes, you take a look at your [vagina "+(vagina+1)+"] and see it changing back to its ";
					if (player.vaginaType() == 5 || player.vaginaType() == 6)
						desc +="natural flesh colour.";
					else
						desc +="old human qualities.";
				}
				else {
					desc += GrowVaginaGenericText();
				}
				if (doOutput) outputText(desc);

				player.vaginaType(VaginaClass.HUMAN, vagina);

				transformations.UnlockVagina();
			},
			// is present
			function ():Boolean {
				return player.hasVagina() && player.vaginaType(-1, vagina) == VaginaClass.HUMAN;
			}
		);
	}

	public function VaginaHorse(vagina:int = 0): Transformation {
		return new SimpleTransformation("Equine Vagina",
				// apply effect
				function (doOutput:Boolean):void {
					var desc:String = "[pg]";

					if (player.hasVagina()){
						desc += "You grip your gut in pain as you feel your organs shift slightly.  When the pressure passes, you realize your [vagina "+(vagina+1)+"] has grown larger, in depth AND size. To your absolute surprise, it suddenly resume deepening inside your body. " +
								"When you finally take a look you discover your vagina is now not unlike that of a horse, capable of taking the largest cock with ease." +
								"<b>  You now have an equine vagina!</b>";
					}
					else {
						desc += GrowVaginaGenericText();
						desc += "To your absolute surprise it suddenly resume deepening inside your body. " +
								"When you finally take a look you discover your vagina is now not unlike that of a horse, capable of taking the largest cock with ease." +
								"<b>  You now have a equine vagina!</b>";
					}
					if (doOutput) outputText(desc);
					player.vaginaType(VaginaClass.EQUINE, vagina);
					player.vaginas[vagina].vaginalLooseness = VaginaClass.LOOSENESS_GAPING;

					transformations.UnlockVagina();
					Metamorph.unlockMetamorphEx(VaginaMem.getMemory(VaginaMem.EQUINE));
				},
				// is present
				function ():Boolean {
					return player.hasVagina() && player.vaginaType(-1, vagina) == VaginaClass.EQUINE;
				}
		);
	}

	public function VaginaSandTrap(vagina:int = 0): Transformation {
		return new SimpleTransformation("Sand Trap Vagina",
				// apply effect
				function (doOutput:Boolean):void {
					var desc:String = "[pg]";

					if (player.hasVagina()){
						desc += "Your [vagina] feels... odd.  You undo your clothes and gingerly inspect your nether regions.  The tender pink color of your sex has disappeared, replaced with smooth, marble blackness starting at your lips and working inwards.";
						//(Wet:
						if (player.wetness() >= 3) desc += "  Your natural lubrication makes it gleam invitingly.";
						//(Corruption <50:
						if (player.cor < 50) desc +="  After a few cautious touches you decide it doesn't feel any different- it does certainly look odd, though.";
						else desc +="  After a few cautious touches you decide it doesn't feel any different - the sheer bizarreness of it is a big turn on though, and you feel it beginning to shine with anticipation at the thought of using it.";
						desc +="  <b>Your vagina is now ebony in color.</b>";
					}
					else {
						desc += GrowVaginaGenericText();
						desc += "The tender pink color of your sex slowly disappears, replaced with smooth, marble blackness starting at your lips and working inwards. " +
								"When you finally take a look you discover your vagina is now not unlike that of a horse, capable of taking the largest cock with ease." +
								"<b>  You now have an ebony coloured vagina!</b>";
					}
					if (doOutput) outputText(desc);
					player.vaginaType(VaginaClass.BLACK_SAND_TRAP);

					transformations.UnlockVagina();
					Metamorph.unlockMetamorphEx(VaginaMem.getMemory(VaginaMem.BLACK_SAND_TRAP));
				},
				// is present
				function ():Boolean {
					return player.hasVagina() && player.vaginaType(-1, vagina) == VaginaClass.BLACK_SAND_TRAP;
				}
		);
	}

	public function VaginaCaveWyrm(vagina:int = 0): Transformation {
		return new SimpleTransformation("Cave Wyrm Vagina",
				// apply effect
				function (doOutput:Boolean):void {
					var desc:String = "[pg]";

					if (player.hasVagina()){
						desc += "You feel a sudden jolt in your pussy and undress as an irrepressible desire to masturbate takes hold of you. You keep fingering your itchy pussy moaning as you cum neon blue fluids. Wait, what? When you inspect your [vagina] you discover it too has changed color to neon blue. Furthermore it seems to naturally glow in the dark like the fluids it now squirt.  <b>You now have a neon blue pussy that glow in the dark.</b>";
					}
					else {
						desc += GrowVaginaGenericText();
						desc += "  You feel a sudden jolt in your new pussy as an irrepressible desire to masturbate takes hold of you. You keep fingering your itchy pussy moaning as you cum neon blue fluids. Wait, what? When you inspect your [vagina] you discover it too has changed color to neon blue. Furthermore it seems to naturally glow in the dark like the fluids it now squirts." +
								"  <b>You now have a neon blue pussy that glow in the dark.</b>";
					}
					if (doOutput) outputText(desc);
					player.vaginaType(VaginaClass.CAVE_WYRM);

					transformations.UnlockVagina();
					Metamorph.unlockMetamorphEx(VaginaMem.getMemory(VaginaMem.CAVE_WYRM));
				},
				// is present
				function ():Boolean {
					return player.hasVagina() && player.vaginaType(-1, vagina) == VaginaClass.CAVE_WYRM;
				}
		);
	}

	public function VaginaCentipede(vagina:int = 0): Transformation {
		return new SimpleTransformation("Centipede Vagina",
				// apply effect
				function (doOutput:Boolean):void {
					var desc:String = "[pg]";

					if (player.hasVagina()){
						desc += "You double over as an overwhelming heat pools in your groin ";
						if (player.vaginaType() != VaginaClass.VENOM_DRIPPING && player.vaginaType() != VaginaClass.HUMAN)
							desc +="as your vagina returns back to a human one, at least in appearance."+
								"  You moan out as your pussy tingles and clenches, drooling a strange dark purple liquid. ";
						if (player.skin.hasVenomousMarking())
							desc += "  It would seem your venomous markings altered something fundamental about your pussy, stimulating it into producing venom."
						else desc += "  It would seem your vagina has been stimulated to produce venom."
								desc += "<b>  You now have a Centipede vagina!</b>";
					}
					else {
						desc += GrowVaginaGenericText();
						desc += "You moan out as your pussy tingles and clenches, drooling a strange dark purple liquid. ";
						if (player.skin.hasVenomousMarking())
							desc += "  It would seem your venomous markings altered something fundamental about your pussy, stimulating it into producing venom."
						else desc += "  It would seem your vagina has been stimulated to produce venom."
						desc += "<b>  You now have a Centipede vagina!</b>";
					}
					if (doOutput) outputText(desc);
					player.vaginaType(VaginaClass.VENOM_DRIPPING, vagina);

					transformations.UnlockVagina();
					Metamorph.unlockMetamorphEx(VaginaMem.getMemory(VaginaMem.VENOM_DRIPPING));
				},
				// is present
				function ():Boolean {
					return player.hasVagina() && player.vaginaType(-1, vagina) == VaginaClass.VENOM_DRIPPING;
				}
		);
	}

	public function VaginaManticore(vagina:int = 0): Transformation {
		return new SimpleTransformation("Manticore Vagina",
				// apply effect
				function (doOutput:Boolean):void {
					var desc:String = "[pg]";

					if (player.hasVagina()){
						desc +="You suddenly became exceedingly aware of your surroundings, feeling the caress of the wind on your skin and especially its passage next to your [pussy]. " +
								"Out of curiosity you slide a single digit inside your pussy to test your new sensitivity and yelp a sound not unlike singing. " +
								"Your pussy has reached the sensitiveness of a manticore and the mere act of touching it will now cause you to moan an entire partition! " +
								"<b>Your ultrasensitive pussy is now exactly like that of a manticore!</b>";
					}
					else {
						desc += GrowVaginaGenericText();
						desc += "Out of curiosity you slide a single digit inside your new pussy to test your sensitivity and yelp a sound not unlike singing. " +
								"Your pussy is as sensitive as that of a manticore and the merely touching it will now cause you to moan an entire partition! " +
								"<b>Your ultrasensitive pussy is now exactly like that of a manticore!</b>";
					}
					if (doOutput) outputText(desc);
					player.vaginaType(VaginaClass.MANTICORE, vagina);

					transformations.UnlockVagina();
					Metamorph.unlockMetamorphEx(VaginaMem.getMemory(VaginaMem.MANTICORE));
				},
				// is present
				function ():Boolean {
					return player.hasVagina() && player.vaginaType(-1, vagina) == VaginaClass.MANTICORE;
				}
		);
	}

	public function VaginaCancer(vagina:int = 0): Transformation {
		return new SimpleTransformation("Cancer Vagina",
				// apply effect
				function (doOutput:Boolean):void {
					var desc:String = "[pg]";

					if (player.hasVagina()){
						desc += "Your pussy starts foaming bubbles for a few seconds, juice slowly flowing out. You cannot resist as your hands dive into your [vagina]. Your pussy gushes, foaming more and more bubbles until you suddenly shoot a powerful bubble jet. You make a dopey smile at the many uses of this you can already think of. <b>You now have an cancer vagina</b>.";
					}
					else {
						desc += GrowVaginaGenericText();
						desc += "To your absolute surprise it suddenly resume deepening inside your body. " +
								"When you finally take a look you discover your vagina is now not unlike that of a horse, capable of taking the largest cock with ease." +
								"<b>  You now have an cancer vagina!</b>";
					}
					if (player.vaginas[vagina].vaginalWetness < VaginaClass.WETNESS_DROOLING) {
						player.vaginas[vagina].vaginalWetness = VaginaClass.WETNESS_DROOLING;
						desc += " <b>You are now a squirter!</b>";
					}
					if (doOutput) outputText(desc);

					player.vaginaType(VaginaClass.CANCER, vagina);

					transformations.UnlockVagina();
					Metamorph.unlockMetamorphEx(VaginaMem.getMemory(VaginaMem.CANCER));
				},
				// is present
				function ():Boolean {
					return player.hasVagina() && player.vaginaType(-1, vagina) == VaginaClass.CANCER;
				}
		);
	}

	public function VaginaDemonic(vagina:int = 0): Transformation {
		return new SimpleTransformation("Demonic Vagina",
				// apply effect
				function (doOutput:Boolean):void {
					var desc:String = "[pg]";

					if (player.hasVagina()) {
					}
					else {
						desc += GrowVaginaGenericText();
					}
					desc += "  Pressure begins building within your loins and your first instinct is to start fiercely fingering yourself in an effort to improve the pleasure, and to your surprise, your vaginal lips seem to reflexively clench around your fingers to kiss you. Wait, no, they're LITERALLY kissing your fingers. Where the hell did your cunt acquire such dexterity? "+
							"Just as you ponder this question, hunger seizes you over as the taste of sweat rushes to your mouth. Not your upper mouth, but the one between your legs has managed to taste the faint salty sweat coating your fingers! You can now taste and milk cum like never before using your "+
							"<b>brand new succubus cunt!</b>";
					if (doOutput) outputText(desc);
					player.vaginaType(VaginaClass.DEMONIC, vagina);

					transformations.UnlockVagina();
					Metamorph.unlockMetamorphEx(VaginaMem.getMemory(VaginaMem.DEMONIC));
				},
				// is present
				function ():Boolean {
					return player.hasVagina() && player.vaginaType(-1, vagina) == VaginaClass.DEMONIC;
				}
		);
	}

	public function VaginaScylla(vagina:int = 0): Transformation {
		return new SimpleTransformation("Scylla Vagina",
				// apply effect
				function (doOutput:Boolean):void {
					var desc:String = "[pg]";

					if (player.hasVagina()){
						desc += "Something fundamental changes in your [vagina " +(vagina+1)+ "] as the insides begins to heat up. Out of curiosity you take a peek and are amazed that the interior of the gaping maw that is your cunt has changed in form and texture. For one you no longer have a clitoris, Instead, several concentric rings of small ultrasensitive nubs line up the walls of your cunt. "+
								"Intrigued you shove your entire hand inside and gasp as your snatch instantly grips it and reflectively tries to pull it deeper in. It takes all of your willpower not to fist yourself to orgasm. "+
								"<b>Your vagina is now like that of a naga and can take in lenghtier insertions.</b>";
					}
					else {
						desc += GrowVaginaGenericText();
						desc += "The insides of your vagina begins to heat up. Out of curiosity you take a peek and are amazed that the interior of the gaping maw that is your cunt has changed in form and texture. For one you no longer have a clitoris, Instead, several concentric rings of small ultrasensitive nubs line up the walls of your cunt. " +
								"Intrigued you shove your entire hand inside and gasp as your snatch instantly grips it and reflectively tries to pull it deeper in. It takes all of your willpower not to fist yourself to orgasm. " +
								"<b>Your vagina is now like that of a naga and can take in lenghtier insertions.</b>";
					}
					if (doOutput) outputText(desc);
					player.vaginaType(VaginaClass.SCYLLA, vagina);
					player.vaginas[vagina].vaginalLooseness = VaginaClass.LOOSENESS_GAPING_WIDE;

					transformations.UnlockVagina();
					Metamorph.unlockMetamorphEx(VaginaMem.getMemory(VaginaMem.SCYLLA));
				},
				// is present
				function ():Boolean {
					return player.hasVagina() && player.vaginaType(-1, vagina) == VaginaClass.SCYLLA;
				},
				function ():Boolean {
					return player.lowerBody == LowerBody.SCYLLA;
				}
		);
	}

	public function VaginaNaga(vagina:int = 0): Transformation {
		return new SimpleTransformation("Naga Vagina",
				// apply effect
				function (doOutput:Boolean):void {
					var desc:String = "[pg]";

					if (player.hasVagina()) {
						desc += "Something fundamental changes in your [vagina " +(vagina+1)+ "] as the insides begins to heat up. Out of curiosity you take a peek and are amazed that the interior of your cunt has deepened to ridiculus extent running all the way farther into your tail.  "+
								"Intrigued you literally shove your entire hand inside and gasp as your snatch instantly grips it and reflectively tries to pull it deeper in heck you could easily insert a good part of your own tail inside and still find space. It takes all of your willpower not to fist yourself to orgasm. "+
								"<b>Your vagina is now like that of a naga and can take in lenghtier insertions.</b>";
					}
					else {
						desc += GrowVaginaGenericText();
						desc += "The insides begins to heat up. Out of curiosity you take a peek and are amazed that the interior of your cunt has deepened to ridiculus extent running all the way farther into your tail. " +
								"Intrigued you literally shove your entire hand inside and gasp as your snatch instantly grips it and reflectively tries to pull it deeper in heck you could easily insert a good part of your own tail inside and still find space. It takes all of your willpower not to fist yourself to orgasm. " +
								"<b>Your vagina is now like that of a naga and can take in lenghtier insertions.</b>";
					}
					if (doOutput) outputText(desc);
					player.vaginas[vagina].vaginalLooseness = VaginaClass.LOOSENESS_GAPING_WIDE;
					player.vaginaType(VaginaClass.NAGA, vagina);

					transformations.UnlockVagina();
					Metamorph.unlockMetamorphEx(VaginaMem.getMemory(VaginaMem.NAGA));
				},
				// is present
				function ():Boolean {
					return player.hasVagina() && player.vaginaType(-1, vagina) == VaginaClass.NAGA;
				},
				// is possible
				function ():Boolean {
					return (player.lowerBody == LowerBody.NAGA || player.lowerBody == LowerBody.HYDRA) && player.vaginaType(-1, vagina) != VaginaClass.NAGA;
				}
		);
	}

	public function VaginaShark(vagina:int = 0): Transformation {
		return new SimpleTransformation("Shark Vagina",
				// apply effect
				function (doOutput:Boolean):void {
					var desc:String = "[pg]";

					if (player.hasVagina()){
						desc += "Something invisible brushes against your sex, making you twinge. Undoing your clothes, you take a look at your vagina. It looks normal at a first glance despite the odd sensation but inserting your fingers inside reveals that your walls are now covered with small sensitive tendril-like feelers. " +
								"You blush as they instinctively drive your digits further in, attempting to milk them like they would a penis. " +
								"<b>It looks like your vagina has turned into that of a shark girl.</b>";
						player.vaginaType(15);
					}
					else {
						desc += GrowVaginaGenericText();
						desc += "It looks normal at a first glance despite the odd sensation but inserting your fingers inside reveals that your walls are now covered with small sensitive tendril-like feelers. " +
								"You blush as they instinctively drive your digits further in, attempting to milk them like they would a penis. " +
								"<b>It looks like your vagina has turned into that of a shark girl.</b>";
					}
					if (doOutput) outputText(desc);
					player.vaginaType(VaginaClass.SHARK, vagina);

					transformations.UnlockVagina();
					Metamorph.unlockMetamorphEx(VaginaMem.getMemory(VaginaMem.SHARK));
				},
				// is present
				function ():Boolean {
					return player.hasVagina() && player.vaginaType(-1, vagina) == VaginaClass.SHARK;
				}
		);
	}

	public function VaginaRaiju(vagina:int = 0): Transformation {
		return new SimpleTransformation("Raiju Vagina",
				// apply effect
				function (doOutput:Boolean):void {
					var desc:String = "[pg]";

					if (player.hasVagina()){
						desc += "You feel a sudden jolt in your pussy and undress as an irrepressible desire to masturbate takes hold of you. You keep fingering your itchy pussy moaning as you cum neon blue plasma. Wait, what? When you inspect your [vagina] you discover it has changed color to neon blue. Furthermore it seems to naturally glow in the dark like the fluids it now squirt.  "+
								"<b>You now have a neon blue raiju pussy that glow in the dark.</b>";
					}
					else {
						desc += GrowVaginaGenericText();
						desc += "An irrepressible desire to masturbate takes hold of you. You keep fingering your itchy pussy moaning as you cum neon blue plasma. Wait, what? When you inspect your [vagina] you discover it has changed color to neon blue. Furthermore it seems to naturally glow in the dark like the fluids it now squirt.  " +
								"<b>You now have a neon blue raiju pussy that glow in the dark.</b>";
					}
					if (doOutput) outputText(desc);
					player.vaginaType(VaginaClass.RAIJU, vagina);

					transformations.UnlockVagina();
					Metamorph.unlockMetamorphEx(VaginaMem.getMemory(VaginaMem.RAIJU));
				},
				// is present
				function ():Boolean {
					return player.hasVagina() && player.vaginaType(-1, vagina) == VaginaClass.RAIJU;
				}
		);
	}
    /*
*/

/*
*	  ██████  ██████   ██████ ██    ██
*	 ██      ██    ██ ██      ██  ██
*	 ██      ██    ██ ██      ████
*	 ██      ██    ██ ██      ██  ██
*	  ██████  ██████   ██████ ██    ██
*/

/*
    */
    public function UnlockCocks():void {
		//noinspection FallThroughInSwitchStatementJS	// Fallthrough is intended for retroactively unlocking in Metamorph after getting GeneticMemory
        switch (player.cockTotal()) {
            case 10: Metamorph.unlockMetamorphEx(CockCountMem.getMemory(CockCountMem.COCK10));
            case 9: Metamorph.unlockMetamorphEx(CockCountMem.getMemory(CockCountMem.COCK9));
            case 8: Metamorph.unlockMetamorphEx(CockCountMem.getMemory(CockCountMem.COCK8));
            case 7: Metamorph.unlockMetamorphEx(CockCountMem.getMemory(CockCountMem.COCK7));
            case 6: Metamorph.unlockMetamorphEx(CockCountMem.getMemory(CockCountMem.COCK6));
            case 5: Metamorph.unlockMetamorphEx(CockCountMem.getMemory(CockCountMem.COCK5));
            case 4: Metamorph.unlockMetamorphEx(CockCountMem.getMemory(CockCountMem.COCK4));
            case 3: Metamorph.unlockMetamorphEx(CockCountMem.getMemory(CockCountMem.COCK3));
            case 2: Metamorph.unlockMetamorphEx(CockCountMem.getMemory(CockCountMem.COCK2));
            case 1: Metamorph.unlockMetamorphEx(CockCountMem.getMemory(CockCountMem.COCK1));
                break;
        }
    }

	public function CockNone(cock:int = 0): Transformation {
		return new SimpleTransformation("Remove Cock",
			// apply effect
			function (doOutput:Boolean):void {
				var desc:String = "[pg]";

				desc += "You have a strange feeling as your crotch tingles.  Opening your [armor], <b>you realize that one of your cocks have vanished completely!</b>";
				if (doOutput) outputText(desc);

				player.removeCock(cock, 1);
			},
			// is present
			function ():Boolean {
				return cock >= player.cockTotal();
			}
		);
	}

	public function GrowCockGenericText(): String {
		var desc:String = "";
		if (player.isTaur()) desc += "You feel a sudden stabbing pain between your back legs" +(player.hasVagina()?" just below your [vagina]":"")+" and bend over, moaning in agony. falling on your back so you can get a stare at your hindquarters you are presented with the shocking site of once-smooth flesh swelling and flowing like self-animate clay, resculpting itself into the form of male genitalia! When the pain dies down, ";
		else if (!player.hasVagina() && !player.hasCock()) desc +="You feel a sudden stabbing pain in your groin and bend over, moaning in agony. Your hands clasp protectively over the surface - which is swelling in an alarming fashion under your fingers! Stripping off your clothes, you are presented with the shocking site of once-smooth flesh swelling and flowing like self-animate clay, resculpting itself into the form of male genitalia! When the pain dies down, ";
		else if (player.hasCock()) desc += "You feel a sudden stabbing pain above your [cocks] and bend over, moaning in agony. Your hands clasp protectively over the surface - which is swelling in an alarming fashion under your fingers! Stripping off your clothes, you are presented with the shocking site of once-smooth flesh swelling and flowing like self-animate clay, resculpting itself into the form of male genitalia! When the pain dies down, ";
		else desc +="You feel a sudden stabbing pain just above your [vagina] and bend over, moaning in agony. Your hands clasp protectively over the surface - which is swelling in an alarming fashion under your fingers! Stripping off your clothes, you are presented with the shocking site of once-smooth flesh swelling and flowing like self-animate clay, resculpting itself into the form of male genitalia! When the pain dies down, ";
		return desc;
	}

	public function CockHuman(cock:int = 0, length:Number = 5.5, thickness:Number = 1): Transformation {
		return new SimpleTransformation("Human Cock",
				// apply effect
				function (doOutput:Boolean):void {
					var desc:String = "[pg]";

					if (player.cocks.length > cock){
						desc += "A strange tingling begins behind your [cock], slowly crawling up across its entire length.  While neither particularly arousing nor uncomfortable, you do shift nervously as the feeling intensifies.  You resist the urge to undo your [armor] to check, but by the feel of it, your penis is shifting form.  Eventually the transformative sensation fades, "+
								"<b>leaving you with a completely human penis.</b>";
					}
					else {
						desc += GrowCockGenericText();
						desc += ", you are the proud owner of "+(player.hasVagina()?" not only a [vagina], but":"")+"<b> You now have a human cock!</b>";
						player.createCock();
					}
					if (doOutput) outputText(desc);
					if (length != 5.5)
						player.cocks[cock].cockLength = length;
					if (thickness != 1)
						player.cocks[cock].cockThickness = thickness;
					player.cocks[cock].cockType = CockTypesEnum.HUMAN;

					transformations.UnlockCocks();
				},
				// is present
				function ():Boolean {
					return cock < player.cocks.length && player.cocks[cock].cockType == CockTypesEnum.HUMAN;
				}
		);
	}

	public function CockHorse(cock:int = 0, length:Number = 5.5, thickness:Number = 1): Transformation {
		return new SimpleTransformation("Horse Cock",
				// apply effect
				function (doOutput:Boolean):void {
					var desc:String = "[pg]";

					if (player.cockTotal() > cock){
						desc += "Your [cock "+(cock+1)+"] begins to feel strange.  You pull down your clothes to take a look and see it darkening";

						desc += player.hasSheath()? "." : " as you feel a tightness near the base where your skin seems to be bunching up.  A sheath begins forming around your cock's base, tightening and pulling your cock inside its depths.";
						desc += "  The shaft suddenly explodes with movement, growing longer and developing a thick flared head, leaking a steady stream of animal-cum.  Your cock pushes out of your sheath, inch after inch of animal-flesh growing beyond its previous size and takes on a more leathery texture.";

						//Text for dogdicks
						if (player.hasKnot(cock)) desc += "  You notice your knot vanishing, the extra flesh pushing more fresh horsecock out from your sheath.";
						else desc += "  The skin is mottled brown and black and feels more sensitive than normal.";

					}
					else {
						desc += GrowCockGenericText();
						desc += "your cock begins to feel strange... you see it darkening as you feel a tightness near the base where your skin seems to be bunching up.  A sheath begins forming around your cock's base, tightening and pulling your cock inside its depths.  A hot feeling envelops your member as it suddenly grows into a horse penis, dwarfing its old size.  The skin is mottled brown and black and feels more sensitive than normal.  Your hands are irresistibly drawn to it, and you jerk yourself off, splattering cum with intense force.";
						player.createCock();
					}
					if (doOutput) outputText(desc);
					if (length != 5.5)
						player.cocks[cock].cockLength = length;
					if (thickness != 1)
						player.cocks[cock].cockThickness = thickness;
					player.cocks[cock].cockType = CockTypesEnum.HORSE;
					player.cocks[cock].knotMultiplier = 1;
					if (doOutput) outputText("<b>  Your hands are drawn to the strange new [cock "+(cock+1)+"]</b>, and you jerk yourself off, splattering thick ropes of cum with intense force.");

					transformations.UnlockCocks();
					Metamorph.unlockMetamorphEx(CockMem.getMemory(CockMem.HORSE));
				},
				// is present
				function ():Boolean {
					return cock < player.cocks.length && player.cocks[cock].cockType == CockTypesEnum.HORSE;
				}
		);
	}

	public function CockDog(cock:int = 0, length:Number = 5.5, thickness:Number = 1, knot:Number = 1.4): Transformation {
		return new SimpleTransformation("Dog Cock",
				// apply effect
				function (doOutput:Boolean):void {
					var desc:String = "[pg]";

					if (player.cocks.length > cock){
						if (player.cocks[cock].cockType == CockTypesEnum.HORSE) {
							desc += "Your [cock "+(cock+1)+"] shrinks, the extra equine length seeming to shift into girth.  The flared tip vanishes and you";
							//Tweak length/thickness.
							if (player.cocks[cock].cockLength > 6) player.cocks[cock].cockLength -= 2;
							else player.cocks[cock].cockLength -= .5;
							player.cocks[cock].cockThickness += .5;
						}
						else if (["tentacle","plant"].indexOf(CockTypesEnum.ParseConstant(player.cocks[cock].cockType)) >= 0)
							desc += "Your [cock "+(cock+1)+"] coils in on itself, reshaping and losing its coloration, becoming a shiny red. You";
						else desc += "Your [cock "+(cock+1)+"] clenches painfully, becoming achingly, throbbingly erect and turning a shiny red. You"
						desc += " shudder as the crown of your [cock "+(cock+1)+"] reshapes into a point, the sensations nearly too much for you. "
						if (!player.hasSheath()) desc += "A tightness seems to squeeze around the base, and you wince as you see your skin and flesh shifting forwards into a canine-looking sheath. ";
						if (player.cocks[cock].knotMultiplier <= 1) desc += "You cry out as you feel a swelling at the base of your cock and your new canine knot slowly slips out of your sheath. "
						else if (player.cocks[cock].knotMultiplier < knot) desc += "The knot on your new red pecker grows extremely sensitive as it grows thicker than before. ";
						desc += "You throw back your head as the transformation completes, your cock much thicker than before.  <b>You now have a dog-cock.</b>";

					}
					else {
						desc += GrowCockGenericText();
						desc += "Your cock clenches painfully, becoming achingly, throbbingly erect and turning a shiny red. ";
						if (!player.hasSheath()) desc += "A tightness seems to squeeze around the base, and you wince as you see your skin and flesh shifting forwards into a canine-looking sheath. ";
						desc += "You cry out as you feel a swelling at the base of your cock and your new canine knot slowly slips out of your sheath. ";
						desc += "You throw back your head as the transformation completes, that was intense!  <b>You now have a dog-cock.</b>"
						player.createCock();
					}
					if (doOutput) outputText(desc);
					if (length != 5.5)
						player.cocks[cock].cockLength = length;
					if (thickness != 1)
						player.cocks[cock].cockThickness = thickness;
					if (player.cocks[cock].knotMultiplier < knot) player.cocks[cock].knotMultiplier = knot;
					player.cocks[cock].cockType = CockTypesEnum.DOG;

					transformations.UnlockCocks();
					Metamorph.unlockMetamorphEx(CockMem.getMemory(CockMem.DOG));
				},
				// is present
				function ():Boolean {
					return cock < player.cocks.length && player.cocks[cock].cockType == CockTypesEnum.DOG;
				}
		);
	}

	public function CockDemon(cock:int = 0, length:Number = 5.5, thickness:Number = 1): Transformation {
		return new SimpleTransformation("Demon Cock",
				// apply effect
				function (doOutput:Boolean):void {
					var desc:String = "[pg]";

					if (player.cocks.length > cock){

						desc += "You smile, watching your [cock] grow longer.  Inches of newfound dick-flesh erupt from your crotch in response to omnibus' dark magics.  Before you can play with your transformed tool, a wave of burning desire passes through you.  ";
						if(player.cor < 80) desc += "You watch in horror as the skin of your [cock] turns shiny and purplish-black.  ";
						else desc += "Curious, you watch the skin of your [cock] turn a shiny-dark purple.  ";

						if(player.cor < 50) desc += "Corrupt nodules begin to spring up over its entire length.  <b>Your penis is transforming into a demon cock!</b>  The new nubs wriggle about as they sprout over every inch of surface, save for the head.  Unable to do anything but groan with forced pleasure and horror, you can only watch.  One last batch of nodules forms in a ring around the crown of your [cock], seemingly completing its transformation, until you notice, almost throwing up, that your testicles are also getting covered in black veins under your powerless eyes!  ";
						else desc += "As you watch expectantly, tiny wriggling nodules begin to erupt from the purplish skin, like those magnificent cocks you saw on demons!  <b>Your penis is transforming into a demon cock!</b>  You pant and moan in happiness as it lengthens one last time.  As you stroke all of its amazing length with both hands, the excitement of possessing such a beautiful pleasure tool makes you cum.  As one last ring of nodules forms around the edge of your [cock]'s crown, you notice that the squirts getting out of your cock-slit are not completely white and gradually become darker, the last drops being pitch-black! Your new [cock] pulsates darkly with each beat of your heart, but the thick, throbbing veins that are finishing to cover your testicles do not contain blood, but a black liquid, which apparently has perverted them. You ponder what its purpose might be, but then you decide, as you stroke the huge, dark, bumpy shaft, that if this feels as good as this looks, it doesn't really matter.  ";
					}
					else {
						if (!player.hasVagina() && !player.hasCock()) desc +="A sudden pressure builds in your groin ";
						else if (player.hasCock()) desc += "A sudden pressure builds above your [cocks] ";
						else desc +="A sudden pressure builds just above your [vagina] ";
						desc += "and you bend over, stripping off your clothes.You look down in wonder, more than a little turned on by the prospect of growing your own penis.  Your skin ripples and bulges outwards, the sensation turning from pressure to feelings of intense warmth.  The bump distends, turning purple near the tip as it reaches three inches in size.  You touch it and cry out with pleasure, watching it leap forwards another inch in response.  Your tiny dick's crown becomes more and more defined as it grows larger, until you have what looks like a normal six inch dick.  You sigh with happiness and desire at your new addition.  Before you can enjoy it, another wave of heat washes through you, making your new addition respond.  It grows painfully hard as it crests eight inches in length.  ";
						if(player.cor < 80) desc += "In horror you watch the skin turn a shiny-dark purple.  Tiny wriggling nodules begin to erupt from the purplish skin, making your cock look more like a crazed sex-toy than a proper penis.  You pant and nearly cum as it lengthens one last time, peaking at ten inches long.  One last ring of nodules forms around the edge of your demon-dick's crown, pulsating darkly with each beat of your horrified heart.";
						else desc +="Curious, you watch the skin turn a shiny-dark purple.  Tiny wriggling nodules begin to erupt from the purplish skin, making your penis look more like those amazing cocks you saw on demons!  You pant and moan in happiness as it lengthens one last time, peaking at ten inches long.  The excitement of possessing such a magnificent pleasure tool makes you cum.  As one last ring of nodules forms around the edge of your new demon-dick's crown, you notice to your surprise that the liquid you ejaculated is pitch black!  But as your new cock pulsates darkly with each beat of your heart, the only thing you have on your mind is to try it out as soon as possible...";
						desc += "<b> You now have a demon dick!</b>";
						player.createCock();
					}
					if (doOutput) outputText(desc);
					if (length != 5.5)
						player.cocks[cock].cockLength = length;
					if (thickness != 1)
						player.cocks[cock].cockThickness = thickness;
					if (player.cocks[cock].cockThickness < 2)
						player.cocks[0].cockThickness = 2;
					player.cocks[cock].cockType = CockTypesEnum.DEMON;

					transformations.UnlockCocks();
					Metamorph.unlockMetamorphEx(CockMem.getMemory(CockMem.DEMON));
				},
				// is present
				function ():Boolean {
					return cock < player.cocks.length && player.cocks[cock].cockType == CockTypesEnum.DEMON;
				}
		);
	}

	public function CockTentacle(cock:int = 0, length:Number = 5.5, thickness:Number = 1): Transformation {
		return new SimpleTransformation("Tentacle Cock",
				// apply effect
				function (doOutput:Boolean):void {
					var desc:String = "[pg]";

					if (player.cocks.length > cock){
						desc += "Your " + num2Text2(cock+1) + " penis itches, and you idly scratch at it.  As you do, it begins to grow longer and longer, all the way to the ground before you realize something is wrong.  You pull open your [armor] and look down, discovering your [cock "+(cock+1)+"] has become a tentacle!  As you watch, it shortens back up; it's colored green except for a purplish head, and evidence seems to suggest you can make it stretch out at will.  <b>You now have a";

						if(player.tentacleCocks() > 0) desc +="nother";
						desc +=" tentacle-cock!</b>";
					}
					else {
						desc += GrowCockGenericText();
						desc += "Your feel it bending and flexing of its own volition... looking down, you see it morph into a green vine-like shape.  <b>You now have a tentacle cock!</b>";
						player.createCock();
					}
					if (doOutput) outputText(desc);
					if (length != 5.5)
						player.cocks[cock].cockLength = length;
					if (thickness != 1)
						player.cocks[cock].cockThickness = thickness;
					if (player.cocks[cock].knotMultiplier < 1.3) player.cocks[cock].knotMultiplier = 1.3;
					player.cocks[cock].cockType = CockTypesEnum.TENTACLE;

					transformations.UnlockCocks();
					Metamorph.unlockMetamorphEx(CockMem.getMemory(CockMem.TENTACLE));
				},
				// is present
				function ():Boolean {
					return cock < player.cocks.length && player.cocks[cock].cockType == CockTypesEnum.TENTACLE;
				}
		);
	}

	public function CockScylla(cock:int = 0, length:Number = 5.5, thickness:Number = 1): Transformation {
		return new SimpleTransformation("Scylla Cock",
				// apply effect
				function (doOutput:Boolean):void {
					var desc:String = "[pg]";

					if (player.cocks.length > cock){
						desc += "Your feel your [cock "+(cock+1)+"] bending and flexing of its own volition... looking down, you see it morph into a tentacle-like shape.  <b>You now have a tentacle cock!</b>  ";
					}
					else {
						desc += GrowCockGenericText();
						desc += "Your feel your cock bending and flexing of its own volition... looking down, you see it morph into a tentacle-like shape.  <b>You now have a tentacle cock!</b>  ";
						player.createCock();
					}
					if (doOutput) outputText(desc);
					if (length != 5.5)
						player.cocks[cock].cockLength = length;
					if (thickness != 1)
						player.cocks[cock].cockThickness = thickness;
					player.cocks[cock].cockType = CockTypesEnum.SCYLLATENTACLE;

					transformations.UnlockCocks();
					Metamorph.unlockMetamorphEx(CockMem.getMemory(CockMem.SCYLLATENTACLE));
				},
				// is present
				function ():Boolean {
					return cock < player.cocks.length && player.cocks[cock].cockType == CockTypesEnum.SCYLLATENTACLE;
				}
		);
	}

	public function CockCat(cock:int = 0, length:Number = 5.5, thickness:Number = 1): Transformation {
		return new SimpleTransformation("Cat Cock",
				// apply effect
				function (doOutput:Boolean):void {
					var desc:String = "[pg]";

					if (player.cocks.length > cock){
						desc += "One of your penises begins to feel strange.  You pull down your clothes to take a look and see your [cock "+(cock+1)+"] swells up with near-painful arousal and begin to transform.  It turns pink and begins to narrow until the tip is barely wide enough to accommodate your urethra.  Barbs begin to sprout from its flesh, if you can call the small, fleshy nubs barbs. They start out thick around the base of your [cock "+(cock+1)+"] and shrink towards the tip. The smallest are barely visible. <b>Your new feline dong throbs powerfully</b> and spurts a few droplets of cum.";
						if (player.hasSheath()) desc += "  Your sheath tingles and begins growing larger as the cock's base shifts to lie inside it.";
						else {
							desc +="  You feel a tightness near the base where your skin seems to be bunching up.  A sheath begins forming around your [cock "+(cock+1)+"]'s root, tightening and pulling it inside its depths.";
							if (player.balls > 0) outputText("  Thankfully, your balls appear untouched.");
						}
					}
					else {
						desc += GrowCockGenericText();
						desc += "You see your cock swells up with near-painful arousal and begin to transform.  It turns pink and begins to narrow until the tip is barely wide enough to accommodate your urethra.  Barbs begin to sprout from its flesh, if you can call the small, fleshy nubs barbs. They start out thick around the base of your cock and shrink towards the tip. The smallest are barely visible. <b>Your new feline dong throbs powerfully</b> and spurts a few droplets of cum.";
						if (player.hasSheath()) desc += "  Your sheath tingles and begins growing larger as the cock's base shifts to lie inside it.";
						else {
							desc +="  You feel a tightness near the base where your skin seems to be bunching up.  A sheath begins forming around your cock's root, tightening and pulling it inside its depths.";
							if (player.balls > 0) outputText("  Thankfully, your balls appear untouched.");
						}
						player.createCock();
					}
					if (doOutput) outputText(desc);
					if (length != 5.5)
						player.cocks[cock].cockLength = length;
					if (thickness != 1)
						player.cocks[cock].cockThickness = thickness;
					player.cocks[cock].knotMultiplier = 1;
					player.cocks[cock].cockType = CockTypesEnum.CAT;

					transformations.UnlockCocks();
					Metamorph.unlockMetamorphEx(CockMem.getMemory(CockMem.CAT));
				},
				// is present
				function ():Boolean {
					return cock < player.cocks.length && player.cocks[cock].cockType == CockTypesEnum.CAT;
				}
		);
	}

	public function CockCancer(cock:int = 0, length:Number = 5.5, thickness:Number = 1): Transformation {
		return new SimpleTransformation("Cancer Cock",
				// apply effect
				function (doOutput:Boolean):void {
					var desc:String = "[pg]";

					if (player.cocks.length > cock) {
						desc += "Your [cock] begins foaming bubbles... well guess thats going to take some time to get used to? <b>Your penis is now foaming bubbles like that of a Cancer!</b>";
						//(REMOVE SHEATH IF NECESSARY)
						if (player.hasSheath())
							desc +="[pg]Your sheath tightens and starts to smooth out, revealing ever greater amounts of your [cock "+(cock+1)+"]'s lower portions.  After a few moments <b>your groin is no longer so animalistic – the sheath is gone.</b>";
					}
					else {
						desc += GrowCockGenericText();
						desc += "your cock begins foaming bubbles... well guess thats going to take some time to get used to? <b>Your penis is now foaming bubbles like that of a Cancer!</b>";
						player.createCock();
					}
					if (doOutput) outputText(desc);
					if (length != 5.5)
						player.cocks[cock].cockLength = length;
					if (thickness != 1)
						player.cocks[cock].cockThickness = thickness;
					player.cocks[cock].cockType = CockTypesEnum.CANCER;

					transformations.UnlockCocks();
					Metamorph.unlockMetamorphEx(CockMem.getMemory(CockMem.CANCER));
				},
				// is present
				function ():Boolean {
					return cock < player.cocks.length && player.cocks[cock].cockType == CockTypesEnum.CANCER;
				}
		);
	}

	public function CockLizard(cock:int = 0, length:Number = 5.5, thickness:Number = 1): Transformation {
		return new SimpleTransformation("Lizard Cock",
				// apply effect
				function (doOutput:Boolean):void {
					var desc:String = "[pg]";

					if (player.cocks.length > cock){
						if (player.lizardCocks() > 0) {
							desc += "A familiar tingle starts in your crotch, and before you can miss the show, you pull open your [armor].  As if operating on a cue, "+
									((player.cockTotal() == 2)? desc += "your other dick" : "another one of your dicks")+
									" starts to change into the strange reptilian shape you've grown familiar with.  It warps visibly, trembling and radiating pleasurable feelings back to you as the transformation progresses.  "+
									"Pre-cum oozes from the tip"+
									" from the pleasure of the change.  In moments <b>you have a bulbous, lizard-like cock.</b>";
							//(REMOVE SHEATH IF NECESSARY)
							if (player.hasSheath()) {
								player.cocks[cock].cockType = CockTypesEnum.LIZARD;
								if (!player.hasSheath()) desc += ("[pg]Your sheath tightens and starts to smooth out, revealing ever greater amounts of your " + cockDescript(cock) + "'s lower portions.  After a few moments <b>your groin is no longer so animalistic – the sheath is gone.</b>");
							}
						}
						else {
							desc += "A slow tingle warms your groin.  Before it can progress any further, you yank back your [armor] to investigate.  Your [cock "+(cock+1)+"] is changing!  It ripples loosely from "+
									(player.hasSheath() ? "sheath " : "base ") + "to tip, undulating and convulsing as its color lightens, darkens, and finally settles on a purplish hue.  Your [cock "+(cock+1)+"] resolves itself into a bulbous form, with a slightly pointed tip.  The 'bulbs' throughout its shape look like they would provide an interesting ride for your sexual partners, but the perverse, alien pecker "+
									(player.cor < 33 ? "horrifies you." : (player.cor < 66 ?"is a little strange for your tastes." :"looks like it might be more fun to receive than use on others."));
							if (player.hasVagina()) desc+= "Maybe you could find someone else with one to ride?"
							else desc+= "Maybe you should test it out on someone and ask them exactly how it feels?";
							desc+="  <b>You now have a bulbous, reptile-like cock.</b>";
							if (player.hasSheath()) {
								player.cocks[cock].cockType = CockTypesEnum.LIZARD;
								if (!player.hasSheath()) desc += ("[pg]Your sheath tightens and starts to smooth out, revealing ever greater amounts of your " + cockDescript(cock) + "'s lower portions.  After a few moments <b>your groin is no longer so animalistic – the sheath is gone.</b>");
							}
						}
					}
					else {
						if (player.lizardCocks() > 0) {
							outputText("[pg]A knot of pressure forms in your groin, forcing you off your [feet] as you try to endure it.  You examine the affected area and see a lump starting to bulge under your [skin.type], adjacent to your [cock].  The flesh darkens, turning purple");
							if (player.hasCoat())
								outputText(" and shedding " + player.coatColor);
							outputText(" as the bulge lengthens, pushing out from your body.  Too surprised to react, you can only pant in pain and watch as the fleshy lump starts to take on a penis-like appearance.  <b>You're growing a second lizard-cock!</b>  It doesn't stop growing until it's just as long as its brother and the same shade of shiny purple.  A dribble of cum oozes from its tip, and you feel relief at last.");
						} else {
							desc += GrowCockGenericText();
							desc += "it ripples loosely from "+
									(player.hasSheath() ? "sheath " : "base ") + "to tip, undulating and convulsing as its color lightens, darkens, and finally settles on a purplish hue.  Your cock resolves itself into a bulbous form, with a slightly pointed tip.  The 'bulbs' throughout its shape look like they would provide an interesting ride for your sexual partners, but the perverse, alien pecker "+
									(player.cor < 33 ? "horrifies you." : (player.cor < 66 ?"is a little strange for your tastes." :"looks like it might be more fun to receive than use on others."));
							if (player.hasVagina()) desc+= "Maybe you could find someone else with one to ride?"
							else desc+= "Maybe you should test it out on someone and ask them exactly how it feels?";
							desc+="  <b>You now have a bulbous, reptile-like cock.</b>";
						}
						player.createCock();
					}
					if (doOutput) outputText(desc);
					if (length != 5.5)
						player.cocks[cock].cockLength = length;
					if (thickness != 1)
						player.cocks[cock].cockThickness = thickness;
					player.cocks[cock].cockType = CockTypesEnum.LIZARD;

					transformations.UnlockCocks();
					Metamorph.unlockMetamorphEx(CockMem.getMemory(CockMem.LIZARD));
				},
				// is present
				function ():Boolean {
					return cock < player.cocks.length && player.cocks[cock].cockType == CockTypesEnum.LIZARD;
				}
		);
	}

	public function CockCaveWyrm(cock:int = 0, length:Number = 5.5, thickness:Number = 1): Transformation {
		return new SimpleTransformation("Cave Wyrm Cock",
				// apply effect
				function (doOutput:Boolean):void {
					var desc:String = "[pg]";

					if (player.cocks.length > cock){
						desc += "You feel a sudden itch in your cock and undress as an irrepressible desire to masturbate takes hold of you. You keep stroking your twitching cock, moaning as you cum neon blue fluids. Wait, what? When you inspect your [cock "+(cock+1)+"] you discover it has not only changed color to neon blue but reshaped into a lizard cock. Furthermore it seems to naturally glow in the dark like the fluids that comes out of it. <b>You now have a neon blue lizard cock that glow in the dark.</b>";
						//(REMOVE SHEATH IF NECESSARY)
						if (player.hasSheath()) {
							player.cocks[cock].cockType = CockTypesEnum.CAVE_WYRM;
							if (!player.hasSheath()) desc += "[pg]Your sheath tightens and starts to smooth out, revealing ever greater amounts of your " + cockDescript(cock) + "'s lower portions.  After a few moments <b>your groin is no longer so animalistic – the sheath is gone.</b>";
						}
					}
					else {
						desc += GrowCockGenericText();
						desc += "an irrepressible desire to masturbate takes hold of you. You keep stroking your twitching cock, moaning as you cum neon blue fluids. Wait, what? When you inspect your new cock you discover it has not only changed color to neon blue but reshaped into a lizard cock. Furthermore it seems to naturally glow in the dark like the fluids that comes out of it. <b>You now have a neon blue lizard cock that glow in the dark.</b>";
						player.createCock();
					}
					if (doOutput) outputText(desc);
					if (length != 5.5)
						player.cocks[cock].cockLength = length;
					if (thickness != 1)
						player.cocks[cock].cockThickness = thickness;
					player.cocks[cock].cockType = CockTypesEnum.CAVE_WYRM;

					transformations.UnlockCocks();
					Metamorph.unlockMetamorphEx(CockMem.getMemory(CockMem.CAVE_WYRM));
				},
				// is present
				function ():Boolean {
					return cock < player.cocks.length && player.cocks[cock].cockType == CockTypesEnum.CAVE_WYRM;
				}
		);
	}

	public function CockAnemone(cock:int = 0, length:Number = 5.5, thickness:Number = 1): Transformation {
		return new SimpleTransformation("Anemone Cock",
				// apply effect
				function (doOutput:Boolean):void {
					var desc:String = "[pg]";

					if (player.cocks.length > cock) {
						desc += "A strange tingling begins at the base of your [cock], slowly crawling up across its entire length.  You shift nervously as the feeling intensifies.  You undo your [armor] to check, and see  small blue-green tendrils emerging all around the base of your cock and  as it too shifts colour. The tentacles wave about"+
								"<b>You have a new anemone-penis!</b>";
						desc += "  The tentacles writhe around, rubbing against your [cocks] and the head of your new blue pecker";
						player.cocks[cock].cockType = CockTypesEnum.ANEMONE;
						desc += " and you quickly become fully erect from the aphrodisiac they inject.  Over and over the tentacles caress [eachcock] sensually, leaving behind a tingling trail of vibrant pleasure";
						//[(if no dick1 and no balls)
						if(player.cockTotal() == 1 && player.balls == 0) desc += "; you feel a pressure build below the shaft, near your asshole";
						desc += ".  As the venom and the rubbing work you to the edge of climax, your muscles clench and a ";
						if(player.cumQ() < 100) desc += "glob";
						else if(player.cumQ() < 500) desc += "squirt";
						else desc += "spray";
						desc += " of semen shoots from your new penis and lands on your ";
						//[(if boobs)
						if(player.biggestTitSize() >= 1) desc += allBreastsDescript() + " and ";
						desc += "stomach";
						//[(dick1 exists)
						if(player.cockTotal() > 1) desc += ", followed in short order by white squirts from [eachcock] remaining";
						if(player.hasVagina()) {
							desc += ".  Your [vag] quivers and pulses as well, adding ";
							if(player.wetness() < VaginaClass.WETNESS_SLICK) desc += "a trickle";
							else if(player.wetness() < VaginaClass.WETNESS_SLAVERING) desc += "a squirt";
							else desc += "nearly a cupful of fluid";
							desc += " from your female orgasm to the puddle on the ground below your ass.";
						}
					}
					else {
						desc += "You lay down and place a fresh anemone tentacle in the ground before you. "
						desc += "As you take in the sight, small nodules around the tip begin to form and lengthen, until the little anemone is capped by a mop of wriggling blue-green tentacles.  The small anemone and you both lay there.  You watch it flexing its body, wedging the head under itself, and elevating the base.";
						desc += "You watch as the strange thing sets butt-end down on your pubic mound and adheres";
						//[(if cocks)
						if(player.cockTotal() > 0) desc += " below your " + player.multiCockDescriptLight();
						desc +=". A sharp pinch lances through the nerves in your groin and sends your hands to it reflexively.  You shift your grip and pull at it a few times, but the thing doesn't budge.  The handling of it only serves to make the stalk thicken and become stiff; gradually you notice that you're feeling the sensation of your own pulling not from the skin at the point of attachment but from the stalk itself, and this realization is accompanied by the ring of tentacles opening and pulling back to reveal the crown of a penis!  <b>You have a new anemone-penis!</b>";
						//[(dick slot 1 exists)
						if(player.cockTotal() > 0) desc += "  The tentacles writhe around, rubbing against your " + player.multiCockDescriptLight();
						//(doesn't exist)
						else desc += "  The tentacles curl inwards, rubbing on the head of your new blue pecker";
						player.createCock((4+rand(3)),1.2, CockTypesEnum.ANEMONE);
						desc += " and you quickly become fully erect from the aphrodisiac they inject.  Over and over the tentacles caress [eachcock] sensually, leaving behind a tingling trail of vibrant pleasure";
						//[(if no dick1 and no balls)
						if(player.cockTotal() == 1 && player.balls == 0) desc += "; you feel a pressure build below the shaft, near your asshole";
						desc += ".  As the venom and the rubbing work you to the edge of climax, your muscles clench and a ";
						if(player.cumQ() < 100) desc += "glob";
						else if(player.cumQ() < 500) desc += "squirt";
						else desc += "spray";
						desc += " of semen shoots from your new penis and lands on your ";
						//[(if boobs)
						if(player.biggestTitSize() >= 1) desc += allBreastsDescript() + " and ";
						desc += "stomach";
						//[(dick1 exists)
						if(player.cockTotal() > 1) desc += ", followed in short order by white squirts from [eachcock] remaining";
						if(player.hasVagina()) {
							desc += ".  Your [vag] quivers and pulses as well, adding ";
							if(player.wetness() < VaginaClass.WETNESS_SLICK) desc += "a trickle";
							else if(player.wetness() < VaginaClass.WETNESS_SLAVERING) desc += "a squirt";
							else desc += "nearly a cupful of fluid";
							desc += " from your female orgasm to the puddle on the ground below your ass.";
						}
					}
					if (doOutput) outputText(desc);
					if (length != 5.5)
						player.cocks[cock].cockLength = length;
					if (thickness != 1)
						player.cocks[cock].cockThickness = thickness;

					transformations.UnlockCocks();
					Metamorph.unlockMetamorphEx(CockMem.getMemory(CockMem.ANEMONE));
				},
				// is present
				function ():Boolean {
					return cock < player.cocks.length && player.cocks[cock].cockType == CockTypesEnum.ANEMONE;
				}
		);
	}

	public function CockKangaroo(cock:int = 0, length:Number = 5.5, thickness:Number = 1): Transformation {
		return new SimpleTransformation("Kangaroo Cock",
				// apply effect
				function (doOutput:Boolean):void {
					var desc:String = "[pg]";

					if (player.cocks.length > cock){
						desc += "You feel a sharp pinch at the end of your penis and whip down your clothes to check.  Before your eyes, the tip of it collapses into a narrow point and the shaft begins to tighten behind it, assuming a conical shape before it retracts into ";
						if (player.hasSheath()) desc += "your sheath";
						else desc += "a sheath that forms at the base of it";
						desc += ".  <b>You now have a kangaroo-penis!</b>";
					}
					else {
						desc += GrowCockGenericText();
						desc += "the tip of it collapses into a narrow point and the shaft begins to tighten behind it, assuming a conical shape before it retracts into";
						if (player.hasSheath()) desc += "your sheath";
						else desc += "a sheath that forms at the base of it";
						desc += ".  <b>You now have a kangaroo-penis!</b>";
						player.createCock();
					}
					if (doOutput) outputText(desc);
					if (length != 5.5)
						player.cocks[cock].cockLength = length;
					if (thickness != 1)
						player.cocks[cock].cockThickness = thickness;
					player.cocks[cock].cockType = CockTypesEnum.KANGAROO;

					transformations.UnlockCocks();
					Metamorph.unlockMetamorphEx(CockMem.getMemory(CockMem.KANGAROO));
				},
				// is present
				function ():Boolean {
					return cock < player.cocks.length && player.cocks[cock].cockType == CockTypesEnum.KANGAROO;
				}
		);
	}

	public function CockDragon(cock:int = 0, length:Number = 5.5, thickness:Number = 1): Transformation {
		return new SimpleTransformation("Dragon Cock",
				// apply effect
				function (doOutput:Boolean):void {
					var desc:String = "[pg]";

					if (player.cocks.length > cock){
						desc += "Your " + player.cockDescript(cock) + " tingles as pins and needles sweep across it.  You pull open your [armor] to watch as it changes; the tip elongates and tapers, like a spear; a series of ridges form along the shaft, giving it an almost segmented look, and a prominent knot swells at its base.  You can't resist stroking it, until it begins dripping pre; ";
						if (player.sens >= 50) desc += "however, it's not until you press on your"+(player.cocks[cock].hasKnot()?"":" new,")+" sensitive knot that you manage to blow your load and enjoy the last few spasms of pleasure as it finally finishes changing.";
						else desc += "but you sternly rein in your hands and tuck them into your armpits as the arousing changes run their course.";
						if (player.cocks[cock].knotMultiplier < 1.3 && player.cocks[cock].knotMultiplier > 1) desc += "The knot on your cock grows extremely sensitive as it grows thicker than before. ";
						desc += "The knot on your cock grows extremely sensitive as it grows thicker than before. ";
						desc += "  <b>You now have a dragon penis.</b>";
					}
					else {
						desc += GrowCockGenericText();
						desc += "it changes; the tip elongates and tapers, like a spear; a series of ridges form along the shaft, giving it an almost segmented look, and a prominent knot swells at its base.  You can't resist stroking it, until it begins dripping pre; ";
						if (player.sens >= 50) desc += "however, it's not until you press on your new, sensitive knot that you manage to blow your load and enjoy the last few spasms of pleasure as it finally finishes changing.";
						else desc += "but you sternly rein in your hands and tuck them into your armpits as the arousing changes run their course.";
						desc += "  <b>You now have a dragon penis.</b>";
						player.createCock();
					}
					if (doOutput) outputText(desc);
					if (length != 5.5)
						player.cocks[cock].cockLength = length;
					if (thickness != 1)
						player.cocks[cock].cockThickness = thickness;
					if (player.cocks[cock].knotMultiplier < 1.3) player.cocks[cock].knotMultiplier = 1.3;
					player.cocks[cock].cockType = CockTypesEnum.DRAGON;

					transformations.UnlockCocks();
					Metamorph.unlockMetamorphEx(CockMem.getMemory(CockMem.DRAGON));
				},
				// is present
				function ():Boolean {
					return cock < player.cocks.length && player.cocks[cock].cockType == CockTypesEnum.DRAGON;
				}
		);
	}

	public function CockDisplacer(cock:int = 0, length:Number = 5.5, thickness:Number = 1, knot:Number = 1.5): Transformation {
		return new SimpleTransformation("Displacer Cock",
				// apply effect
				function (doOutput:Boolean):void {
					var desc:String = "[pg]";

					if (player.cocks.length > cock){
						desc += "You feel an incessant hardness beneath you and realize your cock is dangling out of its sheath.";
						if (!player.hasSheath()) desc += "  Wait... did you have a sheath before? Well you do now.";
						if (player.cocks[cock].knotMultiplier < knot && player.cocks[cock].knotMultiplier > 1) desc += "The knot on your cock grows extremely sensitive as it grows thicker than before. ";
						desc += "  You blink your eyes again... is something wrong with your dick?  At first glance, it appears to be a normal canine dick complete with a knot... but the tip seems to have five grooves along the sides.  When you think about it, you find the tip opening up, splaying out into something resembling a five-armed starfish, with the tips ending in wiggling tendrils, the inner-flesh covered in bumpy nodules that stiffen in the cool air.  With another thought, the cock returns to its normal, almost-canine like appearance, though it's definitely thicker around the tip than an actual canine dick.";
						desc += "You give your <b>new coeurl cock</b> a few tentative strokes";
					}
					else {
						desc += GrowCockGenericText();
						desc += "it shifts again. At first glance, it appears to be a normal canine dick complete with a knot... but the tip seems to have five grooves along the sides.  When you think about it, you find the tip opening up, splaying out into something resembling a five-armed starfish, with the tips ending in wiggling tendrils, the inner-flesh covered in bumpy nodules that stiffen in the cool air.  With another thought, the cock returns to its normal, almost-canine like appearance, though it's definitely thicker around the tip than an actual canine dick.";
						desc += "You give your <b>new coeurl cock</b> a few tentative strokes";
						player.createCock();
					}
					if (doOutput) outputText(desc);
					if (length != 5.5)
						player.cocks[cock].cockLength = length;
					if (thickness != 1)
						player.cocks[cock].cockThickness = thickness;
					if(player.cocks[cock].knotMultiplier < knot) player.cocks[cock].knotMultiplier = knot;
					player.cocks[cock].cockType = CockTypesEnum.DISPLACER;

					transformations.UnlockCocks();
					Metamorph.unlockMetamorphEx(CockMem.getMemory(CockMem.DISPLACER));
				},
				// is present
				function ():Boolean {
					return cock < player.cocks.length && player.cocks[cock].cockType == CockTypesEnum.DISPLACER;
				}
		);
	}

	public function CockFox(cock:int = 0, length:Number = 5.5, thickness:Number = 1, knot:Number = 1.25): Transformation {
		return new SimpleTransformation("Fox Cock",
				// apply effect
				function (doOutput:Boolean):void {
					var desc:String = "[pg]";

					if (player.cocks.length > cock){
						if (player.cocks[cock].cockType == CockTypesEnum.HORSE) {
							desc += "Your [cock "+(cock+1)+"] shrinks, the extra equine length seeming to shift into girth.  The flared tip vanishes and you";
							//Tweak length/thickness.
							if (player.cocks[cock].cockLength > 6) player.cocks[cock].cockLength -= 2;
							else player.cocks[cock].cockLength -= .5;
							player.cocks[cock].cockThickness += .5;
						}
						else if (["tentacle","plant"].indexOf(CockTypesEnum.ParseConstant(player.cocks[cock].cockType)) >= 0)
							desc += "Your [cock "+(cock+1)+"] coils in on itself, reshaping and losing its coloration, becoming a shiny red. You";
						else desc += "Your [cock "+(cock+1)+"] clenches painfully, becoming achingly, throbbingly erect and turning a shiny red. You"
						desc += " shudder as the crown of your [cock "+(cock+1)+"] reshapes into a point, the sensations nearly too much for you. "
						if (!player.hasSheath()) desc += "A tightness seems to squeeze around the base, and you wince as you see your skin and flesh shifting forwards into a canine-looking sheath. ";
						if (player.cocks[cock].knotMultiplier <= 1) desc += "You cry out as you feel a swelling at the base of your cock and your new canine knot slowly slips out of your sheath. "
						else if (player.cocks[cock].knotMultiplier < knot) desc += "The knot on your new red pecker grows extremely sensitive as it grows thicker than before. ";
						desc += "You throw back your head as the transformation completes, your cock much thicker than before.  <b>You now have a fox-cock.</b>";

					}
					else {
						desc += GrowCockGenericText();
						desc += "Your cock clenches painfully, becoming achingly, throbbingly erect and turning a shiny red. ";
						if (!player.hasSheath()) desc += "A tightness seems to squeeze around the base, and you wince as you see your skin and flesh shifting forwards into a canine-looking sheath. ";
						desc += "You cry out as you feel a swelling at the base of your cock and your new canine knot slowly slips out of your sheath. ";
						desc += "You throw back your head as the transformation completes, that was intense!  <b>You now have a fox-cock.</b>";
						player.createCock();
					}
					if (doOutput) outputText(desc);
					if (length != 5.5)
						player.cocks[cock].cockLength = length;
					if (thickness != 1)
						player.cocks[cock].cockThickness = thickness;
					if (player.cocks[cock].knotMultiplier < knot) player.cocks[cock].knotMultiplier = knot;
					player.cocks[cock].cockType = CockTypesEnum.FOX;

					transformations.UnlockCocks();
					Metamorph.unlockMetamorphEx(CockMem.getMemory(CockMem.FOX));
				},
				// is present
				function ():Boolean {
					return cock < player.cocks.length && player.cocks[cock].cockType == CockTypesEnum.FOX;
				}
		);
	}

	public function CockBee(cock:int = 0, length:Number = 5.5, thickness:Number = 1): Transformation {
		return new SimpleTransformation("Bee Cock",
				// apply effect
				function (doOutput:Boolean):void {
					var desc:String = "[pg]";

					if (player.cocks.length > cock){
						desc += "Your huge [cock "+(cock+1)+"] suddenly starts to hurt, especially the tip of the thing.  At the same time, you feel your length start to get incredibly sensitive and the base of your shaft starts to itch.  You tear off your [armor] and watch in fascination as your [cock] starts to change.  The shaft turns black, while becoming hard and smooth to the touch, while the base develops a mane of four inch long yellow bee hair.  As the transformation continues, your member grows even larger than before.  However, it is the tip that keeps your attention the most, as a much finer layer of short yellow hairs grow around it.  Its appearance isn’t the thing that you care about right now, it is the pain that is filling it.  ";
						outputText("It is entirely different from the usual feeling you get when you’re cock grows larger from imbibing transformative substances.  When the changes stop, the tip is shaped like a typical human mushroom cap covered in fine bee hair, but it feels nothing like what you’d expect a human dick to feel like.  Your whole length is incredibly sensitive, and touching it gives you incredible stimulation, but you’re sure that no matter how much you rub it, you aren’t going to cum by yourself.  You want cool honey covering it, you want tight walls surrounding it, you want to fertilize hundreds of eggs with it.  These desires are almost overwhelming.  ");
						outputText("<b>You now have a bee cock!</b>");
					}
					else {
						desc += GrowCockGenericText();
						desc += "the shaft turns black, while becoming hard and smooth to the touch, while the base develops a mane of four inch long yellow bee hair.  As the transformation continues, your member grows even larger than before.  However, it is the tip that keeps your attention the most, as a much finer layer of short yellow hairs grow around it.  Its appearance isn’t the thing that you care about right now, it is the pain that is filling it.  ";
						desc += "It is entirely different from the usual feeling you get when you’re cock grows larger from imbibing transformative substances.  When the changes stop, the tip is shaped like a typical human mushroom cap covered in fine bee hair, but it feels nothing like what you’d expect a human dick to feel like.  Your whole length is incredibly sensitive, and touching it gives you incredible stimulation, but you’re sure that no matter how much you rub it, you aren’t going to cum by yourself.  You want cool honey covering it, you want tight walls surrounding it, you want to fertilize hundreds of eggs with it.  These desires are almost overwhelming.  ";
						desc += "<b>You now have a bee cock!</b>";
						player.createCock();
					}
					if (doOutput) outputText(desc);
					if (length != 5.5)
						player.cocks[cock].cockLength = length;
					if (thickness != 1)
						player.cocks[cock].cockThickness = thickness;
					player.cocks[cock].cockType = CockTypesEnum.BEE;

					transformations.UnlockCocks();
					Metamorph.unlockMetamorphEx(CockMem.getMemory(CockMem.BEE));
				},
				// is present
				function ():Boolean {
					return cock < player.cocks.length && player.cocks[cock].cockType == CockTypesEnum.BEE;
				}
		);
	}

	public function CockPig(cock:int = 0, length:Number = 5.5, thickness:Number = 1): Transformation {
		return new SimpleTransformation("Pig Cock",
				// apply effect
				function (doOutput:Boolean):void {
					var desc:String = "[pg]";

					if (player.cocks.length > cock){
						desc += "You feel an uncomfortable pinching sensation in your [cock "+(cock+1)+"]. " + player.clothedOrNakedLower("You pull open your [armor]", "You look down at your exposed groin") + ", watching as it warps and changes. As the transformation completes, you’re left with a shiny, pinkish red pecker ending in a prominent corkscrew at the tip. <b>You now have a pig penis!</b>";
					}
					else {
						desc += GrowCockGenericText();
						desc += "and as the transformation completes, you’re left with a shiny, pinkish red pecker ending in a prominent corkscrew at the tip. <b>You now have a pig penis!</b>";
						player.createCock();
					}
					if (doOutput) outputText(desc);
					if (length != 5.5)
						player.cocks[cock].cockLength = length;
					if (thickness != 1)
						player.cocks[cock].cockThickness = thickness;
					player.cocks[cock].cockType = CockTypesEnum.PIG;

					transformations.UnlockCocks();
					Metamorph.unlockMetamorphEx(CockMem.getMemory(CockMem.PIG));
				},
				// is present
				function ():Boolean {
					return cock < player.cocks.length && player.cocks[cock].cockType == CockTypesEnum.PIG;
				}
		);
	}

	public function CockAvian(cock:int = 0, length:Number = 5.5, thickness:Number = 1): Transformation {
		return new SimpleTransformation("Avian Cock",
				// apply effect
				function (doOutput:Boolean):void {
					var desc:String = "[pg]";

					if (player.cocks.length > cock){
						desc += "A warm tingling on your nethers makes you check down if the transformative had an effect on your genitals. Giving them a thorough check, you notice that, effectively, your " + cockDescript(cock) + " has changed.  ";
						desc += "It has acquired a reddish-pink coloration, with a smooth texture. The most notorious thing is its tapered, albeit slightly wavy shape, as well as its pointy head. All in all it has a very bird-like appearance.  <b>Seems like you’ve got an avian penis!</b>";
					}
					else {
						desc += GrowCockGenericText();
						desc += "you see it has acquired a reddish-pink coloration, with a smooth texture. The most notorious thing is its tapered, albeit slightly wavy shape, as well as its pointy head. All in all it has a very bird-like appearance.  <b>Seems like you’ve got an avian penis!</b>";
						player.createCock();
					}
					if (doOutput) outputText(desc);
					if (length != 5.5)
						player.cocks[cock].cockLength = length;
					if (thickness != 1)
						player.cocks[cock].cockThickness = thickness;
					player.cocks[cock].cockType = CockTypesEnum.AVIAN;

					transformations.UnlockCocks();
					Metamorph.unlockMetamorphEx(CockMem.getMemory(CockMem.AVIAN));
				},
				// is present
				function ():Boolean {
					return cock < player.cocks.length && player.cocks[cock].cockType == CockTypesEnum.AVIAN;
				}
		);
	}

	public function CockRhino(cock:int = 0, length:Number = 5.5, thickness:Number = 1, inBlackCock:Boolean = false): Transformation {
		return new SimpleTransformation("Rhino Cock",
				// apply effect
				function (doOutput:Boolean):void {
					var desc:String = "[pg]";

					if (player.cocks.length > cock){
						desc += "You feel a stirring in your loins as your [cock "+(cock+1)+"] grows rock hard. ";
						desc += "You " + player.clothedOrNakedLower("pull it out from your [armor]", "lean over");
						desc += (inBlackCock? ", right there in the center of The Black Cock":"") +", to take a look. You watch as the skin of your cock becomes a smooth, tough pink colored phallus. It takes on a long and narrow shape with an oval shaped bulge along the center. You feel a tightness near the base where your skin seems to be bunching up. A sheath begins forming around your flared rhino cock’s root, tightening as your stiff rhino dick elongates and settles, the thick flared head, leaking a steady stream of funky animal-cum. <b>You now have a rhino-dick.</b>";

					}
					else {
						desc += GrowCockGenericText();
						desc += "the skin of your cock becomes a smooth, tough pink colored phallus. It takes on a long and narrow shape with an oval shaped bulge along the center. You feel a tightness near the base where your skin seems to be bunching up. A sheath begins forming around your flared rhino cock’s root, tightening as your stiff rhino dick elongates and settles, the thick flared head, leaking a steady stream of funky animal-cum. <b>You now have a rhino-dick.</b>";
						player.createCock();
					}
					if (doOutput) outputText(desc);
					if (length != 5.5)
						player.cocks[cock].cockLength = length;
					if (thickness != 1)
						player.cocks[cock].cockThickness = thickness;
					player.cocks[cock].cockType = CockTypesEnum.RHINO;

					transformations.UnlockCocks();
					Metamorph.unlockMetamorphEx(CockMem.getMemory(CockMem.RHINO));
				},
				// is present
				function ():Boolean {
					return cock < player.cocks.length && player.cocks[cock].cockType == CockTypesEnum.RHINO;
				}
		);
	}

	public function CockEchidna(cock:int = 0, length:Number = 5.5, thickness:Number = 1, inBlackCock:Boolean = false): Transformation {
		return new SimpleTransformation("Echidna Cock",
				// apply effect
				function (doOutput:Boolean):void {
					var desc:String = "[pg]";

					if (player.cocks.length > cock){
						desc += "Your [cock "+(cock+1)+"] suddenly becomes rock hard out of nowhere. You " + player.clothedOrNakedLower("pull it out from your [armor]"+(inBlackCock?", right in the middle of the food tent":"")+", watching", "watch") + " as it begins to shift and change. It becomes pink in color, and you feel a pinch at the head as it splits to become four heads. " + (player.hasSheath() ? "" : "The transformation finishes off with a fleshy sheath forming at the base.") + " It ejaculates before going limp, retreating into your sheath.";
						desc += " <b>You now have an echidna penis!</b>";
					}
					else {
						desc += GrowCockGenericText();
						desc += "it becomes pink in color, and you feel a pinch at the head as it splits to become four heads. " + (player.hasSheath() ? "" : "The transformation finishes off with a fleshy sheath forming at the base.") + " It ejaculates before going limp, retreating into your sheath."+
							" <b>You now have an echidna penis!</b>";
						player.createCock();
					}
					if (doOutput) outputText(desc);
					if (length != 5.5)
						player.cocks[cock].cockLength = length;
					if (thickness != 1)
						player.cocks[cock].cockThickness = thickness;
					player.cocks[cock].cockType = CockTypesEnum.ECHIDNA;

					transformations.UnlockCocks();
					Metamorph.unlockMetamorphEx(CockMem.getMemory(CockMem.ECHIDNA));
				},
				// is present
				function ():Boolean {
					return cock < player.cocks.length && player.cocks[cock].cockType == CockTypesEnum.ECHIDNA;
				}
		);
	}

	public function CockWolf(cock:int = 0, length:Number = 5.5, thickness:Number = 1, knot:Number = 1.1): Transformation {
		return new SimpleTransformation("Wolf Cock",
				// apply effect
				function (doOutput:Boolean):void {
					var desc:String = "[pg]";

					if (player.cocks.length > cock){
						desc += "Your " + cockDescript(cock) + " clenches painfully, becoming achingly, throbbingly erect. ";
						if (!player.hasSheath()) desc +="A tightness seems to squeeze around the base, and you wince as you see your skin and flesh shifting forwards into a canine-looking sheath. ";
						desc += "You shudder as the crown of your prick reshapes into a point, the sensations nearly too much for you. You throw back your head as the transformation completes, your knotted wolf-cock much thicker than before.";
						if (player.cocks[cock].knotMultiplier < knot) desc += "The knot on your new red pecker grows extremely sensitive as it grows thicker than before. ";
						desc += "  <b>You now have a wolf-cock.</b>";
					}
					else {
						desc += GrowCockGenericText();
						desc += "A tightness seems to squeeze around the base, and you wince as you see your skin and flesh shifting forwards into a canine-looking sheath. ";
						desc += "You shudder as the crown of your prick reshapes into a point, the sensations nearly too much for you. You throw back your head as the transformation completes, your knotted wolf-cock much thicker than before.";
						desc += "  <b>You now have a wolf-cock.</b>";
						player.createCock();
					}
					if (doOutput) outputText(desc);
					if (length != 5.5)
						player.cocks[cock].cockLength = length;
					if (thickness != 1)
						player.cocks[cock].cockThickness = thickness;
					if (player.cocks[cock].cockThickness < 1.5)
						player.cocks[cock].thickenCock(2);
					if (player.cocks[cock].knotMultiplier < knot) player.cocks[cock].knotMultiplier = knot;
					player.cocks[cock].cockType = CockTypesEnum.WOLF;

					transformations.UnlockCocks();
					Metamorph.unlockMetamorphEx(CockMem.getMemory(CockMem.WOLF));
				},
				// is present
				function ():Boolean {
					return cock < player.cocks.length && player.cocks[cock].cockType == CockTypesEnum.WOLF;
				}
		);
	}

	public function CockStamen(cock:int = 0, length:Number = 5.5, thickness:Number = 1): Transformation {
		return new SimpleTransformation("Stamen Cock",
				// apply effect
				function (doOutput:Boolean):void {
					var desc:String = "[pg]";

					if (player.cocks.length > cock){
						desc += "You feel a strange tingling in your " + num2Text2(cock+1) + " cock. You remove your [armor] and look down and witness your cock shifting into a peculiar form. Its tapered, [color] and crowned by several colorful balls that look sort of like knots. Its covered in sweet smelling dust...  you're secreting pollen!  <b>You now have a";
						if(player.tentacleCocks() > 0) desc += "nother";
						desc +=" plantlike stamen cock!</b>";
					}
					else {
						desc += GrowCockGenericText();
						desc += "You feel a strange tingling in your " + num2Text2(cock+1) + " cock and look down to witness your cock shifting into a peculiar form. Its tapered, [color] and crowned by several colorful balls that look sort of like knots. Its covered in sweet smelling dust...  you're secreting pollen!  <b>You now have a plantlike stamen cock!</b>";
						player.createCock();
					}
					if (doOutput) outputText(desc);
					if (length != 5.5)
						player.cocks[cock].cockLength = length;
					if (thickness != 1)
						player.cocks[cock].cockThickness = thickness;
					if (player.cocks[cock].knotMultiplier < 1.3) player.cocks[cock].knotMultiplier = 1.3;
					player.cocks[cock].cockType = CockTypesEnum.STAMEN;

					transformations.UnlockCocks();
					Metamorph.unlockMetamorphEx(CockMem.getMemory(CockMem.STAMEN));
				},
				// is present
				function ():Boolean {
					return cock < player.cocks.length && player.cocks[cock].cockType == CockTypesEnum.STAMEN;
				}
		);
	}

	public function CockRedPanda(cock:int = 0, length:Number = 5.5, thickness:Number = 1): Transformation {
		return new SimpleTransformation("Red Panda Cock",
				// apply effect
				function (doOutput:Boolean):void {
					var desc:String = "[pg]";

					if (player.cocks.length > cock){
						desc += "The skin surrounding your penis folds, encapsulating it and turning itself into a protective sheath.  ";
						desc += "<b>You now have a red-panda cock!</b>";
					}
					else {
						if (!player.hasVagina() && !player.hasCock()) desc +="You feel a sudden stabbing pain in your groin and bend over, moaning in agony. Your hands clasp protectively over the surface - which is swelling in an alarming fashion under your fingers! Stripping off your clothes, you are presented with the shocking site of once-smooth flesh swelling and flowing like self-animate clay, resculpting itself into the form of male genitalia! ";
						else if (player.hasCock()) desc += "You feel a sudden stabbing pain above your [cocks] and bend over, moaning in agony. Your hands clasp protectively over the surface - which is swelling in an alarming fashion under your fingers! Stripping off your clothes, you are presented with the shocking site of once-smooth flesh swelling and flowing like self-animate clay, resculpting itself into the form of male genitalia! ";
						else desc +="You feel a sudden stabbing pain just above your [vagina] and bend over, moaning in agony. Your hands clasp protectively over the surface - which is swelling in an alarming fashion under your fingers! Stripping off your clothes, you are presented with the shocking site of once-smooth flesh swelling and flowing like self-animate clay, resculpting itself into the form of male genitalia! ";
						desc += "The skin surrounding your penis folds, encapsulating it and turning itself into a protective sheath.  ";
						desc += "<b>You now have a red-panda cock!</b>";
						player.createCock();
					}
					if (doOutput) outputText(desc);
					if (length != 5.5)
						player.cocks[cock].cockLength = length;
					if (thickness != 1)
						player.cocks[cock].cockThickness = thickness;
					player.cocks[cock].cockType = CockTypesEnum.RED_PANDA;

					transformations.UnlockCocks();
					Metamorph.unlockMetamorphEx(CockMem.getMemory(CockMem.RED_PANDA));
				},
				// is present
				function ():Boolean {
					return cock < player.cocks.length && player.cocks[cock].cockType == CockTypesEnum.RED_PANDA;
				}
		);
	}

	public function CockGryphon(cock:int = 0, length:Number = 5.5, thickness:Number = 1): Transformation {
		return new SimpleTransformation("Gryphon Cock",
				// apply effect
				function (doOutput:Boolean):void {
					var desc:String = "[pg]";

					if (player.cocks.length > cock){
						desc += "Your nethers tingle under its effect.[pg]Giving them a glimpse, the first thing that becomes obvious if that your " + cockDescript(cock) + " becames a bit ticker, but albeit it retained it’s avian, tapered shape, it’s slightly wavy form became more straight. ";
						desc += "It’s reddish-pink color became pink and it’s tip became more conical. Nevertheless, the main chance manifested across its length, where small, soft barbs grew, giving your member an the appearance of an avian-feline hybrid one.  <b>You'll have to try around your new gryphon cock to know how’ they’ll feel to use,</b> but you’re sure that it’ll be pleasant both for you and your partners.";
					}
					else {
						desc += GrowCockGenericText();
						desc += "your cock becames a bit ticker, but albeit it retained it’s avian, tapered shape, it’s slightly wavy form became more straight. " +
								"It’s reddish-pink color became pink and it’s tip became more conical. Nevertheless, the main chance manifested across its length, where small, soft barbs grew, giving your member an the appearance of an avian-feline hybrid one.  <b>You'll have to try around your new gryphon cock to know how they’ll feel to use,</b> but you’re sure that it’ll be pleasant both for you and your partners.";
						player.createCock();
					}
					if (doOutput) outputText(desc);
					if (length != 5.5)
						player.cocks[cock].cockLength = length;
					if (thickness != 1)
						player.cocks[cock].cockThickness = thickness;
					player.cocks[cock].cockType = CockTypesEnum.GRYPHON;

					transformations.UnlockCocks();
					Metamorph.unlockMetamorphEx(CockMem.getMemory(CockMem.GRYPHON));
				},
				// is present
				function ():Boolean {
					return cock < player.cocks.length && player.cocks[cock].cockType == CockTypesEnum.GRYPHON;
				}
		);
	}

	public function CockCentipede(cock:int = 0, length:Number = 5.5, thickness:Number = 1): Transformation {
		return new SimpleTransformation("Centipede Cock",
				// apply effect
				function (doOutput:Boolean):void {
					var desc:String = "[pg]";

					if (player.cocks.length > cock){
						if (player.hasSheath()) {
							player.cocks[cock].cockType = CockTypesEnum.OOMUKADE;
							if (!player.hasSheath())
								desc += "Your sheath tightens and starts to smooth out, revealing ever greater amounts of your " + player.cockDescript(cock) + "'s lower portions.  After a few moments <b>your groin is no longer so animalistic – the sheath is gone.</b> " +
										"This said the changes are only starting as you moan out feeling your cock harden and tingle as it dribbles venoms.";
						}
						desc += "You moan out, feeling your cock harden and tingle as it dribbles a strange dark purple liquid. <b>You now have a venom dripping, centipede cock.</b>";
					}
					else {
						if (!player.hasVagina() && !player.hasCock()) desc +="You feel a sudden stabbing pain in your groin and bend over, moaning in agony. Your hands clasp protectively over the surface - which is swelling in an alarming fashion under your fingers! Stripping off your clothes, you are presented with the shocking site of once-smooth flesh swelling and flowing like self-animate clay, resculpting itself into the form of male genitalia! ";
						else if (player.hasCock()) desc += "You feel a sudden stabbing pain above your [cocks] and bend over, moaning in agony. Your hands clasp protectively over the surface - which is swelling in an alarming fashion under your fingers! Stripping off your clothes, you are presented with the shocking site of once-smooth flesh swelling and flowing like self-animate clay, resculpting itself into the form of male genitalia! ";
						else desc +="You feel a sudden stabbing pain just above your [vagina] and bend over, moaning in agony. Your hands clasp protectively over the surface - which is swelling in an alarming fashion under your fingers! Stripping off your clothes, you are presented with the shocking site of once-smooth flesh swelling and flowing like self-animate clay, resculpting itself into the form of male genitalia! ";
						desc += "You moan out, feeling your cock harden and tingle as it dribbles a strange dark purple liquid. <b>You now have a venom dripping, centipede cock.</b>";
						player.createCock();
					}
					if (doOutput) outputText(desc);
					if (length != 5.5)
						player.cocks[cock].cockLength = length;
					if (thickness != 1)
						player.cocks[cock].cockThickness = thickness;
					player.cocks[cock].cockType = CockTypesEnum.OOMUKADE;

					transformations.UnlockCocks();
					Metamorph.unlockMetamorphEx(CockMem.getMemory(CockMem.OOMUKADE));
				},
				// is present
				function ():Boolean {
					return cock < player.cocks.length && player.cocks[cock].cockType == CockTypesEnum.OOMUKADE;
				}
		);
	}

	public function CockRaiju(cock:int = 0, length:Number = 5.5, thickness:Number = 1): Transformation {
		return new SimpleTransformation("Raiju Cock",
				// apply effect
				function (doOutput:Boolean):void {
					var desc:String = "[pg]";

					if (player.cocks.length > cock){
						desc += "You feel a sudden itch in your cock and undress as an irrepressible desire to masturbate takes hold of you. You keep stroking your twitching cock, moaning as you cum neon blue fluids. Wait, what? When you inspect your [cock] you discover its tip not only has changed color to neon blue but is now tappered with a sheath like that of a raiju. Furthermore it seems to naturally glow in the dark like the plasma that naturaly drips out of it. <b>You now have a neon blue raiju cock that glow in the dark.</b>";
					}
					else {
						desc += GrowCockGenericText();
						desc += "an irrepressible desire to masturbate takes hold of you. You keep stroking your twitching cock, moaning as you cum neon blue fluids. Wait, what? When you inspect your cock you discover its tip not only has changed color to neon blue but is now tappered with a sheath like that of a raiju. Furthermore it seems to naturally glow in the dark like the plasma that naturaly drips out of it. <b>You now have a neon blue raiju cock that glow in the dark.</b>";
						player.createCock();
					}
					if (doOutput) outputText(desc);
					if (length != 5.5)
						player.cocks[cock].cockLength = length;
					if (thickness != 1)
						player.cocks[cock].cockThickness = thickness;
					if (player.cocks[cock].knotMultiplier < 1.25) player.cocks[cock].knotMultiplier = 1.25;
					player.cocks[cock].cockType = CockTypesEnum.RAIJU;

					transformations.UnlockCocks();
					Metamorph.unlockMetamorphEx(CockMem.getMemory(CockMem.RAIJU));
				},
				// is present
				function ():Boolean {
					return cock < player.cocks.length && player.cocks[cock].cockType == CockTypesEnum.RAIJU;
				}
		);
	}

	public function CockUshiOni(cock:int = 0, length:Number = 5.5, thickness:Number = 1): Transformation {
		return new SimpleTransformation("Ushi Oni Cock",
				// apply effect
				function (doOutput:Boolean):void {
					var desc:String = "[pg]";

					if (player.cocks.length > cock){
						desc += "[pg]<b>HOW THE HELL, IT DOES NOT EXIST YET</b>[pg]" +
								"<b> You now have a Ushi Oni cock!</b>";
					}
					else {
						desc += GrowCockGenericText();
						desc += "[pg]<b>HOW THE HELL, IT DOES NOT EXIST YET</b>[pg]" +
								"<b> You now have a Ushi Oni cock!</b>";
						player.createCock();
					}
					if (doOutput) outputText(desc);
					if (length != 5.5)
						player.cocks[cock].cockLength = length;
					if (thickness != 1)
						player.cocks[cock].cockThickness = thickness;
					player.cocks[cock].cockType = CockTypesEnum.USHI_ONI;

					transformations.UnlockCocks();
					Metamorph.unlockMetamorphEx(CockMem.getMemory(CockMem.USHI_ONI));
				},
				// is present
				function ():Boolean {
					return cock < player.cocks.length && player.cocks[cock].cockType == CockTypesEnum.USHI_ONI;
				}
		);
	}

	public function GrowKnot(cock:int = 0, crit:Number = 1, mod:Number = 1, div:Number = 20): Transformation { return new SimpleTransformation( "Grow knot of cock",
			// apply effect
			function (doOutput:Boolean): void {
				var desc:String = "[pg]";

				if (cock == -1) { //choose smallest dog knot if not specified
					var choice:int = 0;
					//set temp2 to first wolfdick for initialization
					while (choice < player.cocks.length) {
						if (player.isDogCock(choice)) {
							cock = choice;
							break;
						} else choice++;
					}
					//Reset choice for nex tcheck
					choice = player.cocks.length;
					//Find smallest knot
					while (choice > 0) {
						choice--;
						if (player.isDogCock(choice) && player.cocks[choice].knotMultiplier < player.cocks[cock].knotMultiplier) cock = choice;
					}
					//Have smallest knotted cock selected.
				}

				var knot:Number = (rand(2) + mod) / div * crit;
				if (player.cocks[cock].knotMultiplier >= 1.5) knot /= 2;
				if (player.cocks[cock].knotMultiplier >= 1.75) knot /= 2;
				if (player.cocks[cock].knotMultiplier >= 2) knot /= 5;
				player.cocks[cock].knotMultiplier += (knot);
				if (knot < .06) desc +="Your " + cockDescript(cock) + " feels unusually tight in your sheath as your knot grows.";
				else if (knot <= .12) desc += "Your " + cockDescript(cock) + " pops free of your sheath, thickening nicely into a bigger knot.";
				else  desc +="Your " + cockDescript(cock) + " surges free of your sheath, swelling thicker with each passing second.  Your knot bulges out at the base, growing far beyond normal.";
				dynStats("lus", 5 * crit);
				player.addCurse("sen", 1, 1);

				if (doOutput) outputText(desc);
			},
			// is present
			function (): Boolean {
				return !player.isDogCock(cock);
			}
	 );}

	public function CockInsect(cock:int = 0, length:Number = 5.5, thickness:Number = 1): Transformation {
		return new SimpleTransformation("Insect Cock",
				// apply effect
				function (doOutput:Boolean):void {
					var desc:String = "[pg]";

					if (player.cocks.length > cock){
						desc += "Your " + num2Text2(cock+1) + " penis itches, and you idly scratch at it.  As you do, it begins to grow longer and longer";
						desc += player.hasSheath()? "" : " out of its new sheath";
						desc += ", all the way to the ground before you realize something is wrong.  You pull open your [armor] and look down, discovering your [cock "+(cock+1)+"] has become a tentacle!  As you watch, it withdraws back into its sheath; it's colored a dull white, and evidence seems to suggest you can make it extend out at will.  <b>You now have a";
						if(player.tentacleCocks() > 0) desc += "nother";
						desc += " tentacle-cock!</b>";
					}
					else {
						desc += GrowCockGenericText();
						desc += "Your feel it bending and flexing of its own volition... looking down, you see it morph into a white vine-like shape.  <b>You now have an insect cock!</b>";
						player.createCock();
					}
					if (doOutput) outputText(desc);
					if (length != 5.5)
						player.cocks[cock].cockLength = length;
					if (thickness != 1)
						player.cocks[cock].cockThickness = thickness;
					player.cocks[cock].knotMultiplier = 1;
					player.cocks[cock].cockType = CockTypesEnum.INSECT;

					UnlockCocks();
					Metamorph.unlockMetamorphEx(CockMem.getMemory(CockMem.INSECT));
				},
				// is present
				function ():Boolean {
					return cock < player.cocks.length && player.cocks[cock].cockType == CockTypesEnum.INSECT;
				}
		);
	}
	
	public function CockChangeType(type:CockTypesEnum, grow:Boolean, oneByOne:Boolean=false):Transformation {
		return new SimpleTransformation("CockChangeType("+type.DisplayName+","+grow+","+oneByOne+")",
				// apply effect
				function (doOutput:Boolean):void {
					var n:int = player.cocks.length;
					if (grow && n == 0) n = 1;
					for (var i:int = 0; i < n; i++) {
						var cock:Cock = player.cocks[i];
						if (!cock || cock.cockType != type) {
							switch (type) {
								case CockTypesEnum.HUMAN:
									CockHuman(i, cock.cockLength, cock.cockThickness).applyEffect(doOutput);
									break;
								case CockTypesEnum.DOG:
									CockDog(i, cock.cockLength, cock.cockThickness).applyEffect(doOutput);
									break;
								case CockTypesEnum.DEMON:
									CockDemon(i, cock.cockLength, cock.cockThickness).applyEffect(doOutput);
									break;
								case CockTypesEnum.TENTACLE:
									CockTentacle(i, cock.cockLength, cock.cockThickness).applyEffect(doOutput);
									break;
								case CockTypesEnum.SCYLLATENTACLE:
									CockScylla(i, cock.cockLength, cock.cockThickness).applyEffect(doOutput);
									break;
								case CockTypesEnum.CAT:
									CockCat(i, cock.cockLength, cock.cockThickness).applyEffect(doOutput);
									break;
								case CockTypesEnum.CANCER:
									CockCancer(i, cock.cockLength, cock.cockThickness).applyEffect(doOutput);
									break;
								case CockTypesEnum.LIZARD:
									CockLizard(i, cock.cockLength, cock.cockThickness).applyEffect(doOutput);
									break;
								case CockTypesEnum.CAVE_WYRM:
									CockCaveWyrm(i, cock.cockLength, cock.cockThickness).applyEffect(doOutput);
									break;
								case CockTypesEnum.ANEMONE:
									CockAnemone(i, cock.cockLength, cock.cockThickness).applyEffect(doOutput);
									break;
								case CockTypesEnum.KANGAROO:
									CockKangaroo(i, cock.cockLength, cock.cockThickness).applyEffect(doOutput);
									break;
								case CockTypesEnum.DRAGON:
									CockDragon(i, cock.cockLength, cock.cockThickness).applyEffect(doOutput);
									break;
								case CockTypesEnum.DISPLACER:
									CockDisplacer(i, cock.cockLength, cock.cockThickness).applyEffect(doOutput);
									break;
								case CockTypesEnum.FOX:
									CockFox(i, cock.cockLength, cock.cockThickness).applyEffect(doOutput);
									break;
								case CockTypesEnum.BEE:
									CockBee(i, cock.cockLength, cock.cockThickness).applyEffect(doOutput);
									break;
								case CockTypesEnum.PIG:
									CockPig(i, cock.cockLength, cock.cockThickness).applyEffect(doOutput);
									break;
								case CockTypesEnum.AVIAN:
									CockAvian(i, cock.cockLength, cock.cockThickness).applyEffect(doOutput);
									break;
								case CockTypesEnum.RHINO:
									CockRhino(i, cock.cockLength, cock.cockThickness).applyEffect(doOutput);
									break;
								case CockTypesEnum.ECHIDNA:
									CockEchidna(i, cock.cockLength, cock.cockThickness).applyEffect(doOutput);
									break;
								case CockTypesEnum.WOLF:
									CockWolf(i, cock.cockLength, cock.cockThickness).applyEffect(doOutput);
									break;
								case CockTypesEnum.STAMEN:
									CockStamen(i, cock.cockLength, cock.cockThickness).applyEffect(doOutput);
									break;
								case CockTypesEnum.RED_PANDA:
									CockRedPanda(i, cock.cockLength, cock.cockThickness).applyEffect(doOutput);
									break;
								case CockTypesEnum.GRYPHON:
									CockGryphon(i, cock.cockLength, cock.cockThickness).applyEffect(doOutput);
									break;
								case CockTypesEnum.OOMUKADE:
									CockCentipede(i, cock.cockLength, cock.cockThickness).applyEffect(doOutput);
									break;
//								case CockTypesEnum.MINDBREAKER:
									// CockMindbreaker(i, cock.cockLength, cock.cockThickness).applyEffect(doOutput);
//									break;
								case CockTypesEnum.RAIJU:
									CockRaiju(i, cock.cockLength, cock.cockThickness).applyEffect(doOutput);
									break;
								case CockTypesEnum.USHI_ONI:
									CockUshiOni(i, cock.cockLength, cock.cockThickness).applyEffect(doOutput);
									break;
								case CockTypesEnum.INSECT:
									CockInsect(i, cock.cockLength, cock.cockThickness).applyEffect(doOutput);
									break;
								default:
									if (cock) {
										cock.cockType = type;
									} else {
										player.createCock(5.5, 1, type);
									}
							}
							if (oneByOne) break;
						}
					}
				},
				// is present
				function():Boolean {
					return player.countCocksOfType(type) == player.cocks.length;
				});
	}
    /*
*/

/*
*	 ██████   █████  ██     ██     ███████
* 	 ██   ██ ██   ██ ██     ██     ██
* 	 ██████  ███████ ██     ██     ███████
* 	 ██   ██ ██   ██ ██     ██          ██
* 	 ██████  ██   ██ ██████ ██████ ███████
*/

/*
    */
	public const BallsNone:Transformation = new SimpleTransformation("Remove Bals",
			// apply
			function (doOutput:Boolean):void {
				var desc: String = "";

				desc += "[pg]Your scrotum slowly shrinks, eventually disappearing entirely!  <b>You've lost your balls!</b>";

				if (doOutput) outputText(desc);
				player.balls = 0;
				player.ballSize = 1;
			},
			// is present
			function ():Boolean {
				return player.balls == 0;
			}
	);

	public const BallsDuo:Transformation = new SimpleTransformation("Two balls only",
			// apply
			function (doOutput:Boolean):void {
				var desc: String = "[pg]";

				if (player.balls < 2) {
					player.ballSize = 1;
					if (rand(2) == 0) desc += "A nauseating pressure forms just under the base of your maleness.  With agonizing pain the flesh bulges and distends, pushing out a rounded lump of flesh that you recognize as a testicle!  A moment later relief overwhelms you as the second drops into your newly formed sack.";
					else desc += "You gasp in shock as a sudden pain racks your crotch. Within seconds, two balls drop down into a new sack, your skin stretching out to accommodate them. Once the pain clears, you examine <b>your new pair of testes.</b>[pg]";
				}
				else
					desc += "Your scrotum slowly shrinks until they seem to have reached a normal size. <b>It feels as if your extra balls have fused together, leaving you with a pair of balls.</b>[pg]";

				if (doOutput) outputText(desc);
				player.balls = 2;
				Metamorph.unlockMetamorphEx(BallsMem.getMemory(BallsMem.DUO));
			},
			// is present
			function ():Boolean {
				return player.balls == 2;
			}
	);

	public function BallsQuad(size: int = 1, forceQuad: Boolean = false):Transformation {

		return new SimpleTransformation("Four balls",
				// apply
				function (doOutput:Boolean):void {
					var desc:String = "[pg]";

					if (player.balls == 0) {
						player.balls = 2;
						player.ballSize = size;
						desc += "You gasp in shock as a sudden pain racks your abdomen. Within seconds, two balls drop down into a new sack, your skin stretching out to accommodate them. Once the pain clears, you examine <b>your new set of testes.</b>";
						if (forceQuad) {
							desc += "After a minute, two more testes drop down into your [sack], your skin stretching even more to accommodate them. Once the pain clears, you examine <b>your new quartet of testes.</b>"
							player.balls = 4;
						}
					}
					else {
						desc += "You gasp in shock as a sudden pain racks your abdomen. Within seconds, two more testes drop down into your [sack], your skin stretching out to accommodate them. Once the pain clears, you examine <b>your new quartet of testes.</b>";
						player.balls = 4;
					}

					if (doOutput) outputText(desc);

					if (player.balls == 2)
						Metamorph.unlockMetamorphEx(BallsMem.getMemory(BallsMem.DUO));
					else
						Metamorph.unlockMetamorphEx(BallsMem.getMemory(BallsMem.QUAD));
				},
				// is present
				function ():Boolean {
					return player.balls == 4;
				}
		);
	}

	public const BallsTrap:Transformation = new SimpleTransformation("Trap pouch",
			// apply
			function (doOutput:Boolean):void {
				var desc: String = "[pg]";

				if (player.balls < 2) {
					player.balls = 2;
					desc += "You gasp in shock as a sudden pain racks your abdomen. Within seconds, two balls drop down into a new sack, your skin stretching out to accommodate them. Once the pain clears, you examine <b>your new pair of testes.</b>[pg]";
				}
				else
					if (player.ballSize > 1) desc += "You feel a delicate tightening sensation around your [balls].  The sensation upon this most sensitive part of your anatomy isn't painful, but the feeling of your balls getting smaller is intense enough that you stifle anything more than a sharp intake of breath only with difficulty.[pg]";
				player.ballSize = 1;
				if (!player.hasStatusEffect(StatusEffects.Uniball))
					desc += "You whimper as once again, your balls tighten and shrink.  Your eyes widen when you feel the gentle weight of your testicles pushing against your crotch, and a few hesitant swings of your [butt] confirm what you can feel - you've tightened your balls up so much they no longer hang beneath your [cocks], but press perkily upwards.  Heat ringing your ears, you explore your new sack with a careful hand.  "+
							"You are deeply grateful you apparently haven't reversed puberty, but you discover that though you still have " + num2Text(player.balls) + ", your balls now look and feel like one: one cute, tight little sissy parcel, its warm, insistent pressure upwards upon the joining of your thighs a never-ending reminder of it.[pg]"

				if (doOutput) outputText(desc);
				if (!player.hasStatusEffect(StatusEffects.Uniball))
					player.createStatusEffect(StatusEffects.Uniball, 0, 0, 0, 0);

				Metamorph.unlockMetamorphEx(BallsMem.getMemory(BallsMem.TRAP));
			},
			// is present
			function ():Boolean {
				return player.hasStatusEffect(StatusEffects.Uniball);
			}
	);
    /*
*/

/*
* 	   █████  ████████ ██    ██ ██████ ██████
*  	 ██    ██    ██    ██    ██ ██     ██   ██
*  	 ██    ██    ██    ████████ █████  ██████
*  	 ██    ██    ██    ██    ██ ██     ██   ██
*  	  ██████     ██    ██    ██ ██████ ██   ██
*/

/*
	*/
	public const RemoveOvipositor:Transformation = new SimpleTransformation("Remove Oviposition",
			// apply
			function (doOutput:Boolean):void {
				var desc: String = "[pg]";

				if (player.hasPerk(PerkLib.SpiderOvipositor)) { //Remove dat shit!
					desc += "<b>Your ovipositor (and eggs) vanish since your body has become less spider-like.</b>";
					player.removePerk(PerkLib.SpiderOvipositor);
				}
				else if (player.hasPerk(PerkLib.BeeOvipositor)) { //Remove dat shit!
					desc += "<b>Your ovipositor (and eggs) vanish since your body has become less bee-like.</b>";
					player.removePerk(PerkLib.BeeOvipositor);
				}
				else if (player.hasPerk(PerkLib.MantisOvipositor)) { //Remove dat shit!
					desc += "<b>Your ovipositor (and eggs) vanish since your body has become less mantis-like.</b>";
					player.removePerk(PerkLib.MantisOvipositor);
				}
				else if (player.hasPerk(PerkLib.AntOvipositor)) { //Remove dat shit!
					desc += "<b>Your ovipositor (and eggs) vanish since your body has become less ant-like.</b>";
					player.removePerk(PerkLib.AntOvipositor);
				}

				if (doOutput) outputText(desc);
			},
			// is present
			function ():Boolean {
				return !player.hasPerk(PerkLib.BeeOvipositor) && !player.hasPerk(PerkLib.SpiderOvipositor) && !player.hasPerk(PerkLib.MantisOvipositor) && !player.hasPerk(PerkLib.AntOvipositor);
			},
			// is possible
			function ():Boolean {
				return ((player.hasPerk(PerkLib.SpiderOvipositor) && (!player.isDrider() || player.tailType != Tail.SPIDER_ADBOMEN)) ||
						(player.hasPerk(PerkLib.BeeOvipositor) && player.tailType != Tail.BEE_ABDOMEN) ||
						(player.hasPerk(PerkLib.MantisOvipositor) && player.tailType != Tail.MANTIS_ABDOMEN) ||
						(player.hasPerk(PerkLib.AntOvipositor) && player.tailType != Tail.ANT_ABDOMEN));
			}
	);

	public const GainOvipositor:Transformation = new SimpleTransformation("Remove Oviposition",
			// apply
			function (doOutput:Boolean):void {
				if (player.tailType === Tail.BEE_ABDOMEN)
						TransformationUtils.applyTFIfNotPresent(transformations.OvipositionBee, doOutput);
				if (player.tailType === Tail.SPIDER_ADBOMEN)
						TransformationUtils.applyTFIfNotPresent(transformations.OvipositionSpider, doOutput);
				if (player.tailType === Tail.MANTIS_ABDOMEN)
						TransformationUtils.applyTFIfNotPresent(transformations.OvipositionMantis, doOutput);
				if (player.tailType === Tail.ANT_ABDOMEN)
					TransformationUtils.applyTFIfNotPresent(transformations.OvipositionAnt, doOutput);
			},
			// is present
			function ():Boolean {
				return !InCollection(player.tailType, Tail.BEE_ABDOMEN, Tail.SPIDER_ADBOMEN, Tail.MANTIS_ABDOMEN) ||
							player.hasPerk(PerkLib.SpiderOvipositor) || player.hasPerk(PerkLib.BeeOvipositor) || player.hasPerk(PerkLib.MantisOvipositor);
			}
	);

	public const OvipositionBee:Transformation = new SimpleTransformation("Bee Oviposition",
			// apply
			function (doOutput:Boolean):void {
				var desc: String = "";

				TransformationUtils.applyTFIfNotPresent(transformations.RemoveOvipositor, doOutput);
				TransformationUtils.applyTFIfNotPresent(transformations.TailBee, doOutput);

				outputText("\n\nAn odd swelling starts in your insectile abdomen, somewhere along the underside.  Curling around, you reach back to your extended, bulbous bee part and run your fingers along the underside.  You gasp when you feel a tender, yielding slit near the stinger.  As you probe this new orifice, a shock of pleasure runs through you, and a tubular, black, semi-hard appendage drops out, pulsating as heavily as any sexual organ.  <b>The new organ is clearly an ovipositor!</b>  A few gentle prods confirm that it's just as sensitive; you can already feel your internals changing, adjusting to begin the production of unfertilized eggs.  You idly wonder what laying them with your new bee ovipositor will feel like...");
				outputText("\n\n(<b>Perk Gained:  Bee Ovipositor - Allows you to lay eggs in your foes!</b>)");
				player.createPerk(PerkLib.BeeOvipositor, 0, 0, 0, 0);

				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(SpecialsMem.getMemory(SpecialsMem.OVIPOSITOR));
			},
			// is present
			function ():Boolean {
				return player.hasPerk(PerkLib.BeeOvipositor);
			},
			// is possible
			function ():Boolean {
				return !player.hasPerk(PerkLib.BeeOvipositor) && player.tailType == Tail.BEE_ABDOMEN;
			}
	);

	public const OvipositionSpider:Transformation = new SimpleTransformation("Spider Oviposition",
			// apply
			function (doOutput:Boolean):void {
				var desc: String = "";

				TransformationUtils.applyTFIfNotPresent(transformations.RemoveOvipositor, doOutput);
				TransformationUtils.applyTFIfNotPresent(transformations.TailSpider, doOutput);
				TransformationUtils.applyTFIfNotPresent(transformations.LowerBodyDrider, doOutput);

				desc += "[pg]An odd swelling sensation floods your spider half.  Curling your abdomen underneath you for a better look, you gasp in recognition at your new 'equipment'!  Your semi-violent run-ins with the swamp's population have left you <i>intimately</i> familiar with the new appendage.  <b>It's a drider ovipositor!</b>  A few light prods confirm that it's just as sensitive as any of your other sexual organs.  You idly wonder what laying eggs with this thing will feel like..."+
						"[pg](<b>Perk Gained:  Spider Ovipositor - Allows you to lay eggs in your foes!</b>)";
				//V1 - Egg Count
				//V2 - Fertilized Count
				player.createPerk(PerkLib.SpiderOvipositor, 0, 0, 0, 0);

				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(SpecialsMem.getMemory(SpecialsMem.OVIPOSITOR));
			},
			// is present
			function ():Boolean {
				return player.hasPerk(PerkLib.SpiderOvipositor);
			},
			// is possible
			function ():Boolean {
				return !player.hasPerk(PerkLib.SpiderOvipositor) && player.isDrider() && player.tailType == Tail.SPIDER_ADBOMEN;
			}
	);

	public const OvipositionMantis:Transformation = new SimpleTransformation("Mantis Oviposition",
			// apply
			function (doOutput:Boolean):void {
				var desc: String = "";

				TransformationUtils.applyTFIfNotPresent(transformations.RemoveOvipositor, doOutput);
				TransformationUtils.applyTFIfNotPresent(transformations.SkinChitin(Skin.COVERAGE_LOW, {colors: MantisRace.MantisChitinColors}), doOutput);
				TransformationUtils.applyTFIfNotPresent(transformations.TailMantis, doOutput);

				desc +="[pg]An odd swelling starts in your insectile abdomen, somewhere along the underside.  Curling around, you reach back to your extended, bulbous mantis part and run your fingers along the underside.  You gasp when you feel a tender, yielding slit near the end.  As you probe this new orifice, a shock of pleasure runs through you, and a tubular, green, semi-hard appendage drops out, pulsating as heavily as any sexual organ.  <b>The new organ is clearly an ovipositor!</b>  A few gentle prods confirm that it's just as sensitive; you can already feel your internals changing, adjusting to begin the production of unfertilized eggs.  You idly wonder what laying them with your new mantis ovipositor will feel like..."+
						"[pg](<b>Perk Gained:  Mantis Ovipositor - Allows you to lay eggs in your foes!</b>)";
				player.createPerk(PerkLib.MantisOvipositor, 0, 0, 0, 0);

				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(SpecialsMem.getMemory(SpecialsMem.OVIPOSITOR));
			},
			// is present
			function ():Boolean {
				return player.hasPerk(PerkLib.MantisOvipositor);
			},
			// is possible
			function ():Boolean {
				return player.hasCoatOfType(Skin.CHITIN) && !player.hasPerk(PerkLib.MantisOvipositor) && player.tailType == Tail.MANTIS_ABDOMEN;
			}
	);

	public const OvipositionAnt:Transformation = new SimpleTransformation("Mantis Oviposition",
			// apply
			function (doOutput:Boolean):void {
				var desc: String = "";

				TransformationUtils.applyTFIfNotPresent(transformations.RemoveOvipositor, doOutput);
				TransformationUtils.applyTFIfNotPresent(transformations.TailAnt, doOutput);

				outputText("[pg]An odd swelling starts in your insectile abdomen, somewhere along the underside.  Curling around, you reach back to your extended, bulbous ant part and run your fingers along the underside.  You gasp when you feel a tender, yielding slit near the end.  As you probe this new orifice, a shock of pleasure runs through you, and a tubular, tan, semi-hard appendage drops out, pulsating as heavily as any sexual organ.  <b>The new organ is clearly an ovipositor!</b>  A few gentle prods confirm that it's just as sensitive; you can already feel your internals changing, adjusting to begin the production of unfertilized eggs.  You idly wonder what laying them with your new ant ovipositor will feel like...");
				outputText("\n\n(<b>Perk Gained:  Ant Ovipositor - Allows you to lay eggs in your foes!</b>)");
				player.createPerk(PerkLib.AntOvipositor, 0, 0, 0, 0);

				if (doOutput) outputText(desc);
				Metamorph.unlockMetamorph(SpecialsMem.getMemory(SpecialsMem.OVIPOSITOR));
			},
			// is present
			function ():Boolean {
				return player.hasPerk(PerkLib.AntOvipositor);
			},
			// is possible
			function ():Boolean {
				return !player.hasPerk(PerkLib.AntOvipositor) && player.tailType == Tail.ANT_ABDOMEN;
			}
	);


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
}
}
