package classes.Transformations {
import classes.BodyParts.*;
import classes.CockTypesEnum;
import classes.Items.MutationsHelper;
import classes.Transformations.Transformations.*;

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
	public const AntennaeNone: Transformation 			= antennae.AntennaeNone;
	public const AntennaeAnt: Transformation 			= antennae.AntennaeAnt;
	public const AntennaeBee: Transformation 			= antennae.AntennaeBee;
	public const AntennaeCentipede: Transformation 		= antennae.AntennaeCentipede;
	public const AntennaeFireSnail: Transformation 		= antennae.AntennaeFireSnail;
	public const AntennaeJabberwocky: Transformation 	= antennae.AntennaeJabberwocky;
	public const AntennaeMantis: Transformation 		= antennae.AntennaeMantis;
	public const AntennaeSeaDragon: Transformation 		= antennae.AntennaeSeaDragon;


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
	public const ArmsHuman: Transformation 				= arms.ArmsHuman;
	public const ArmsAnt: Transformation 				= arms.ArmsAnt;
	public const ArmsAtlach: Transformation 			= arms.ArmsAtlach;
	public const ArmsAvian: Transformation 				= arms.ArmsAvian;
	public const ArmsBatWing: Transformation 			= arms.ArmsBatWing;
	public const ArmsBear: Transformation 				= arms.ArmsBear;
	public const ArmsBee: Transformation 				= arms.ArmsBee;
	public const ArmsBoar: Transformation 				= arms.ArmsBoar;
	public const ArmsCat: Transformation 				= arms.ArmsCat;
	public const ArmsCaveWyrm: Transformation 			= arms.ArmsCaveWyrm;
	public const ArmsCentipede: Transformation 			= arms.ArmsCentipede;
	public const ArmsDevil: Transformation 				= arms.ArmsDevil;
	public const ArmsDisplacer: Transformation 			= arms.ArmsDisplacer;
	public const ArmsDraconic: Transformation 			= arms.ArmsDraconic;
	public const ArmsElf: Transformation 				= arms.ArmsElf;
	public const ArmsFox: Transformation 				= arms.ArmsFox;
	public const ArmsFrostwyrm: Transformation 			= arms.ArmsFrostwyrm;
	public const ArmsGazer: Transformation 				= arms.ArmsGazer;
	public const ArmsGhost: Transformation 				= arms.ArmsGhost;
	public const ArmsGoo: Transformation 				= arms.ArmsGoo;
	public const ArmsGryphon: Transformation 			= arms.ArmsGryphon;
	public const ArmsHarpy: Transformation 				= arms.ArmsHarpy;
	public const ArmsHinezumi: Transformation 			= arms.ArmsHinezumi;
	public const ArmsHydra: Transformation 				= arms.ArmsHydra;
	public const ArmsJabberwocky: Transformation 		= arms.ArmsJabberwocky;
	public const ArmsJiangshi: Transformation 			= arms.ArmsJiangshi;
	public const ArmsKamaitachi: Transformation 		= arms.ArmsKamaitachi;
	public const ArmsKitsune: Transformation 			= arms.ArmsKitsune;
	public const ArmsKraken: Transformation 			= arms.ArmsKraken;
	public const ArmsLion: Transformation 				= arms.ArmsLion;
	public const ArmsLizard: Transformation 			= arms.ArmsLizard;
	public const ArmsMantis: Transformation 			= arms.ArmsMantis;
	public const ArmsMelkie: Transformation 			= arms.ArmsMelkie;
	public const ArmsOni: Transformation 				= arms.ArmsOni;
	public const ArmsOrc: Transformation 				= arms.ArmsOrc;
	public const ArmsOrca: Transformation 				= arms.ArmsOrca;
	public const ArmsPhoenix: Transformation 			= arms.ArmsPhoenix;
	public const ArmsPig: Transformation 				= arms.ArmsPig;
	public const ArmsPlant: Transformation 				= arms.ArmsPlant;
	public const ArmsRaccoon: Transformation 			= arms.ArmsRaccoon;
	public const ArmsRaiju: Transformation 				= arms.ArmsRaiju;
	public const ArmsRaijuPaws: Transformation 			= arms.ArmsRaijuPaws;
	public const ArmsRedPanda: Transformation 			= arms.ArmsRedPanda;
	public const ArmsSalamander: Transformation 		= arms.ArmsSalamander;
	public const ArmsSeaDragon: Transformation 			= arms.ArmsSeaDragon;
	public const ArmsShark: Transformation 				= arms.ArmsShark;
	public const ArmsSphinx: Transformation 			= arms.ArmsSphinx;
	public const ArmsSpider: Transformation 			= arms.ArmsSpider;
	public const ArmsSquirrel: Transformation 			= arms.ArmsSquirrel;
	public const ArmsUshiOni: Transformation 			= arms.ArmsUshiOni;
	public const ArmsWeasel: Transformation 			= arms.ArmsWeasel;
	public const ArmsWendigo: Transformation 			= arms.ArmsWendigo;
	public const ArmsWolf: Transformation 				= arms.ArmsWolf;
	public const ArmsYeti: Transformation 				= arms.ArmsYeti;
	public const ArmsYukiOnna: Transformation 			= arms.ArmsYukiOnna;


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
    );


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
	public const BallsNone:Transformation = balls.BallsNone;
	public const BallsDuo:Transformation = balls.BallsDuo;
	public function BallsQuad(size: int = 1, forceQuad: Boolean = false):Transformation { return balls.BallsQuad(size, forceQuad); }
	public const BallsTrap:Transformation = balls.BallsTrap;


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
    public const BreastsGrowUpToDD:Transformation 		= breasts.BreastsGrowUpToDD;
    public const BreastsShrinkToNothing:Transformation 	= breasts.BreastsShrinkToNothing;
    public const BreastRowsRemoveToOne:Transformation 	= breasts.BreastRowsRemoveToOne;
    public const BreastRowsOne:Transformation 			= breasts.BreastRowsOne;
    public const BreastRowsTwo:Transformation 			= breasts.BreastRowsTwo;
    public const BreastRowsThree:Transformation 		= breasts.BreastRowsThree;
    public const BreastRowsFour:Transformation 			= breasts.BreastRowsFour;
    public function CreateBreastRow(size:int = 2):Transformation { return breasts.CreateBreastRow(size); }
    public function CopyBreastRow(keepSize:Boolean = false):Transformation { return breasts.CopyBreastRow(keepSize); }
    public const NipplesPerBreastOne:Transformation 	= breasts.NipplesPerBreastOne;
    public const NipplesPerBreastFour:Transformation 	= breasts.NipplesPerBreastFour;
    public const NipplesFuckableForce:Transformation 	= breasts.NipplesFuckableForce;
    public const NipplesFuckable:Transformation 		= breasts.NipplesFuckable;
    public const NipplesUnfuck:Transformation 			= breasts.NipplesUnfuck;
    public const StartLactation:Transformation 			= breasts.StartLactation;
    public const RemoveLactation:Transformation 		= breasts.RemoveLactation;
    public const NipplesNoColor:Transformation 			= breasts.NipplesNoColor;
    public const NipplesBlack:Transformation 			= breasts.NipplesBlack;
    public const NipplesGlowing:Transformation 			= breasts.NipplesGlowing;


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
    public function CockHuman(cock:int = 0, length:Number = 5.5, thickness:Number = 1): Transformation 			{ return cocks.CockHuman(cock, length, thickness); }
    public function CockHorse(cock:int = 0, length:Number = 5.5, thickness:Number = 1): Transformation 			{ return cocks.CockHorse(cock, length, thickness); }
    public function CockKirin(cock:int = 0, length:Number = 5.5, thickness:Number = 1): Transformation 			{ return cocks.CockKirin(cock, length, thickness); }
    public function CockDog(cock:int = 0, length:Number = 5.5, thickness:Number = 1, knot:Number = 1.4): Transformation { return cocks.CockDog(cock, length, thickness, knot); }
    public function CockDemon(cock:int = 0, length:Number = 5.5, thickness:Number = 1): Transformation 			{ return cocks.CockDemon(cock, length, thickness); }
    public function CockTentacle(cock:int = 0, length:Number = 5.5, thickness:Number = 1): Transformation 		{ return cocks.CockTentacle(cock, length, thickness); }
    public function CockScylla(cock:int = 0, length:Number = 5.5, thickness:Number = 1): Transformation 		{ return cocks.CockScylla(cock, length, thickness); }
    public function CockCat(cock:int = 0, length:Number = 5.5, thickness:Number = 1): Transformation 			{ return cocks.CockCat(cock, length, thickness); }
    public function CockCancer(cock:int = 0, length:Number = 5.5, thickness:Number = 1): Transformation 		{ return cocks.CockCancer(cock, length, thickness); }
    public function CockLizard(cock:int = 0, length:Number = 5.5, thickness:Number = 1): Transformation 		{ return cocks.CockLizard(cock, length, thickness); }
    public function CockCaveWyrm(cock:int = 0, length:Number = 5.5, thickness:Number = 1): Transformation 		{ return cocks.CockCaveWyrm(cock, length, thickness); }
    public function CockAnemone(cock:int = 0, length:Number = 5.5, thickness:Number = 1): Transformation 		{ return cocks.CockAnemone(cock, length, thickness); }
    public function CockKangaroo(cock:int = 0, length:Number = 5.5, thickness:Number = 1): Transformation 		{ return cocks.CockKangaroo(cock, length, thickness); }
    public function CockDragon(cock:int = 0, length:Number = 5.5, thickness:Number = 1): Transformation 		{ return cocks.CockDragon(cock, length, thickness); }
    public function CockDisplacer(cock:int = 0, length:Number = 5.5, thickness:Number = 1, knot:Number = 1.5): Transformation { return cocks.CockDisplacer(cock, length, thickness, knot); }
    public function CockFox(cock:int = 0, length:Number = 5.5, thickness:Number = 1, knot:Number = 1.25): Transformation { return cocks.CockFox(cock, length, thickness, knot); }
    public function CockBee(cock:int = 0, length:Number = 5.5, thickness:Number = 1): Transformation 			{ return cocks.CockBee(cock, length, thickness); }
    public function CockPig(cock:int = 0, length:Number = 5.5, thickness:Number = 1): Transformation 			{ return cocks.CockPig(cock, length, thickness); }
    public function CockAvian(cock:int = 0, length:Number = 5.5, thickness:Number = 1): Transformation 			{ return cocks.CockAvian(cock, length, thickness); }
    public function CockRhino(cock:int = 0, length:Number = 5.5, thickness:Number = 1, inBlackCock:Boolean = false): Transformation { return cocks.CockRhino(cock, length, thickness, inBlackCock); }
    public function CockEchidna(cock:int = 0, length:Number = 5.5, thickness:Number = 1, inBlackCock:Boolean = false): Transformation { return cocks.CockEchidna(cock, length, thickness, inBlackCock); }
    public function CockWolf(cock:int = 0, length:Number = 5.5, thickness:Number = 1, knot:Number = 1.1): Transformation { return cocks.CockWolf(cock, length, thickness, knot); }
    public function CockStamen(cock:int = 0, length:Number = 5.5, thickness:Number = 1): Transformation 		{ return cocks.CockStamen(cock, length, thickness); }
    public function CockRedPanda(cock:int = 0, length:Number = 5.5, thickness:Number = 1): Transformation 		{ return cocks.CockRedPanda(cock, length, thickness); }
    public function CockGryphon(cock:int = 0, length:Number = 5.5, thickness:Number = 1): Transformation 		{ return cocks.CockGryphon(cock, length, thickness); }
    public function CockCentipede(cock:int = 0, length:Number = 5.5, thickness:Number = 1): Transformation 		{ return cocks.CockCentipede(cock, length, thickness); }
    public function CockRaiju(cock:int = 0, length:Number = 5.5, thickness:Number = 1): Transformation 			{ return cocks.CockRaiju(cock, length, thickness); }
    public function CockUshiOni(cock:int = 0, length:Number = 5.5, thickness:Number = 1): Transformation 		{ return cocks.CockUshiOni(cock, length, thickness); }
    public function CockInsect(cock:int = 0, length:Number = 5.5, thickness:Number = 1): Transformation 		{ return cocks.CockInsect(cock, length, thickness); }
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
	public const EarsHuman: Transformation 		= ears.EarsHuman;
	public const EarsLion: Transformation 		= ears.EarsLion;
	public const EarsDisplacer: Transformation 	= ears.EarsDisplacer;
	public const EarsCat: Transformation 		= ears.EarsCat;
	public const EarsRedPanda: Transformation 	= ears.EarsRedPanda;
	public const EarsHorse: Transformation 		= ears.EarsHorse;
	public const EarsKirin: Transformation 		= ears.EarsKirin;
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
    public const EyesCat: Transformation			= eyes.EyesCat;
	public const EyesDevil: Transformation			= eyes.EyesDevil;
    public const EyesDisplacer: Transformation		= eyes.EyesDisplacer;
	public const EyesDraconic: Transformation		= eyes.EyesDraconic;
	public const EyesElf: Transformation			= eyes.EyesElf;
	public const EyesFairy: Transformation			= eyes.EyesFairy;
	public const EyesGorgon: Transformation			= eyes.EyesGorgon;
	public const EyesOni: Transformation			= eyes.EyesOni;
	public const EyesBear: Transformation			= eyes.EyesBear;
	public const EyesCancer: Transformation			= eyes.EyesCancer;
	public const EyesCaveWyrm: Transformation		= eyes.EyesCaveWyrm;
	public const EyesCentipede: Transformation		= eyes.EyesCentipede;
	public const EyesDead: Transformation			= eyes.EyesDead;
	public const EyesFenrir: Transformation			= eyes.EyesFenrir;
	public const EyesFiendish: Transformation		= eyes.EyesFiendish;
	public const EyesFireSnail: Transformation		= eyes.EyesFireSnail;
	public const EyesFeral: Transformation		    = eyes.EyesFeral;
	public const EyesFox: Transformation			= eyes.EyesFox;
	public const EyesFrostwyrm: Transformation		= eyes.EyesFrostwyrm;
	public const EyesGoat: Transformation			= eyes.EyesGoat;
	public const EyesGhost: Transformation			= eyes.EyesGhost;
	public const EyesGryphon: Transformation		= eyes.EyesGryphon;
	public const EyesHinezumi: Transformation		= eyes.EyesHinezumi;
	public const EyesHuman: Transformation			= eyes.EyesHuman;
    public const EyesInfernal: Transformation		= eyes.EyesInfernal;
    public const EyesJiangshi: Transformation		= eyes.EyesJiangshi;
	public const EyesKraken: Transformation			= eyes.EyesKraken;
	public const EyesLizard: Transformation			= eyes.EyesLizard;
	public const EyesManticore: Transformation		= eyes.EyesManticore;
	public const EyesMonoeye: Transformation		= eyes.EyesMonoeye;
    public const EyesOrc: Transformation			= eyes.EyesOrc;
	public const EyesRaiju: Transformation			= eyes.EyesRaiju;
	public const EyesRatatoskr: Transformation		= eyes.EyesRatatoskr;
	public const EyesSandTrap: Transformation		= eyes.EyesSandTrap;
	public const EyesSnake: Transformation			= eyes.EyesSnake;
	public const EyesSnakeFiendish: Transformation	= eyes.EyesSnakeFiendish;
	public const EyesSpider: Transformation			= eyes.EyesSpider;
	public const EyesWeasel: Transformation			= eyes.EyesWeasel;
    public const EyesVampire: Transformation		= eyes.EyesVampire;
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
	public const EyesRaijuColors: Transformation 			= eyes.EyesRaijuColors;
	public const EyesKirinColors: Transformation 			= eyes.EyesKirinColors;
	public const EyesKamaitachiColors: Transformation 		= eyes.EyesKamaitachiColors;
	public const EyesRatatoskrColors: Transformation 		= eyes.EyesRatatoskrColors;
	public const EyesRaccoonColors: Transformation 			= eyes.EyesRaccoonColors;
	public const EyesKrakenColors: Transformation 			= eyes.EyesKrakenColors;
	public const EyesSeadragonColors: Transformation 		= eyes.EyesSeadragonColors;
	public const EyesFireSnailColors: Transformation 		= eyes.EyesFireSnailColors;
	public const EyesFenrirColor: Transformation 			= eyes.EyesFenrirColor;
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
    public const FaceRedPanda: Transformation 			= face.FaceRedPanda;
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
    public const GillsNone: Transformation 				= gills.GillsNone;
    public const GillsFish: Transformation 				= gills.GillsFish;
    public const GillsAnemone: Transformation 			= gills.GillsAnemone;
    public const GillsInTentacleLegs: Transformation 	= gills.GillsInTentacleLegs;


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
    public const HornsNone: Transformation 					= horns.HornsNone;
    public const HornsBicorn: Transformation 				= horns.HornsBicorn;
    public const HornsUnicorn: Transformation 				= horns.HornsUnicorn;
    public const HornsKirin: Transformation 				= horns.HornsKirin;
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
    public const HornsJiangshi: Transformation 				= horns.HornsJiangshi;


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
    public function LowerBodyWolfToggle(toggleTaur:Boolean = false): Transformation 			{ return lowerBody.LowerBodyWolf(player.legCount, toggleTaur); }
    public function LowerBodyHoofed(legCount: int = undefined): Transformation 					{ return lowerBody.LowerBodyHoofed(legCount); }
    public function LowerBodyHoofedToggle(toggleTaur:Boolean = false): Transformation 			{ return lowerBody.LowerBodyHoofed(player.legCount, toggleTaur); }
    public function LowerBodyKirin(legCount: int = undefined): Transformation 					{ return lowerBody.LowerBodyKirin(legCount); }
    public function LowerBodyKirinToggle(toggleTaur:Boolean = false): Transformation 			{ return lowerBody.LowerBodyKirin(player.legCount, toggleTaur); }
    public function LowerBodyCat(legCount: int = undefined): Transformation 					{ return lowerBody.LowerBodyCat(legCount); }
    public function LowerBodyCatToggle(toggleTaur:Boolean = false): Transformation 				{ return lowerBody.LowerBodyCat(player.legCount, toggleTaur); }
    public function LowerBodyLizard(legCount: int = undefined): Transformation 					{ return lowerBody.LowerBodyLizard(legCount); }
    public function LowerBodyLizardToggle(toggleTaur:Boolean = false): Transformation 			{ return lowerBody.LowerBodyLizard(player.legCount, toggleTaur); }
    public function LowerBodyFox(legCount: int = undefined): Transformation 					{ return lowerBody.LowerBodyFox(legCount); }
    public function LowerBodyFoxToggle(toggleTaur:Boolean = false): Transformation 				{ return lowerBody.LowerBodyFox(player.legCount, toggleTaur); }
    public function LowerBodyDraconic(legCount: int = undefined): Transformation 				{ return lowerBody.LowerBodyDraconic(legCount); }
    public function LowerBodyDraconicToggle(toggleTaur:Boolean = false): Transformation 		{ return lowerBody.LowerBodyDraconic(player.legCount, toggleTaur); }
    public function LowerBodyClovenHoofed(legCount: int = undefined): Transformation 			{ return lowerBody.LowerBodyClovenHoofed(legCount); }
    public function LowerBodyClovenHoofedToggle(toggleTaur:Boolean = false): Transformation 	{ return lowerBody.LowerBodyClovenHoofed(player.legCount, toggleTaur); }
    public function LowerBodySalamander(legCount: int = undefined): Transformation 				{ return lowerBody.LowerBodySalamander(legCount); }
    public function LowerBodySalamanderToggle(toggleTaur:Boolean = false): Transformation 		{ return lowerBody.LowerBodySalamander(player.legCount, toggleTaur); }
    public function LowerBodyMantis(legCount: int = undefined): Transformation 					{ return lowerBody.LowerBodyMantis(legCount); }
    public function LowerBodyMantisToggle(toggleTaur:Boolean = false): Transformation 			{ return lowerBody.LowerBodyMantis(player.legCount, toggleTaur); }
    public function LowerBodyShark(legCount: int = undefined): Transformation 					{ return lowerBody.LowerBodyShark(legCount); }
    public function LowerBodySharkToggle(toggleTaur:Boolean = false): Transformation 			{ return lowerBody.LowerBodyShark(player.legCount, toggleTaur); }
    public function LowerBodyLion(legCount: int = undefined): Transformation 					{ return lowerBody.LowerBodyLion(legCount); }
    public function LowerBodyLionToggle(toggleTaur:Boolean = false): Transformation 			{ return lowerBody.LowerBodyLion(player.legCount, toggleTaur); }
    public function LowerBodyOrca(legCount: int = undefined): Transformation 					{ return lowerBody.LowerBodyOrca(legCount); }
    public function LowerBodyOrcaToggle(toggleTaur:Boolean = false): Transformation 			{ return lowerBody.LowerBodyOrca(player.legCount, toggleTaur); }
    public function LowerBodyRaiju(legCount: int = undefined): Transformation 					{ return lowerBody.LowerBodyRaiju(legCount); }
    public function LowerBodyRaijuToggle(toggleTaur:Boolean = false): Transformation 			{ return lowerBody.LowerBodyRaiju(player.legCount, toggleTaur); }
    public function LowerBodyDog(legCount: int = undefined): Transformation 					{ return lowerBody.LowerBodyDog(legCount); }
    public function LowerBodyDogToggle(toggleTaur:Boolean = false): Transformation 				{ return lowerBody.LowerBodyDog(player.legCount, toggleTaur); }
    public function LowerBodyWeasel(legCount: int = undefined): Transformation 					{ return lowerBody.LowerBodyWeasel(legCount); }
    public function LowerBodyWeaselToggle(toggleTaur:Boolean = false): Transformation 			{ return lowerBody.LowerBodyWeasel(player.legCount, toggleTaur); }
    public function LowerBodyBear(legCount: int = undefined): Transformation 					{ return lowerBody.LowerBodyBear(legCount); }
    public function LowerBodyBearToggle(toggleTaur:Boolean = false): Transformation 			{ return lowerBody.LowerBodyBear(player.legCount, toggleTaur); }
    public function LowerBodySeaDragon(legCount: int = undefined): Transformation 				{ return lowerBody.LowerBodySeaDragon(legCount); }
    public function LowerBodySeaDragonToggle(toggleTaur:Boolean = false): Transformation 		{ return lowerBody.LowerBodySeaDragon(player.legCount, toggleTaur); }
    public function LowerBodyGryphon(legCount: int = undefined): Transformation 				{ return lowerBody.LowerBodyGryphon(legCount); }
    public function LowerBodyGryphonToggle(toggleTaur:Boolean = false): Transformation 			{ return lowerBody.LowerBodyGryphon(player.legCount, toggleTaur); }
    public const LowerBodyAnt: Transformation 				= lowerBody.LowerBodyAnt;
    public const LowerBodyAtlach: Transformation 			= lowerBody.LowerBodyAtlach;
    public const LowerBodyAtlachNacha: Transformation 		= lowerBody.LowerBodyAtlachNacha;
    public const LowerBodyBee: Transformation 				= lowerBody.LowerBodyBee;
    public const LowerBodyBipedal: Transformation 			= lowerBody.LowerBodyBipedal;
    public const LowerBodyCentipede: Transformation 		= lowerBody.LowerBodyCentipede;
    public const LowerBodyDemonClawed: Transformation 		= lowerBody.LowerBodyDemonClawed;
    public const LowerBodyDemonHighHeels: Transformation 	= lowerBody.LowerBodyDemonHighHeels;
    public const LowerBodyDrider: Transformation 			= lowerBody.LowerBodyDrider;
    public const LowerBodyElf: Transformation 				= lowerBody.LowerBodyElf;
    public const LowerBodyFerret: Transformation 			= lowerBody.LowerBodyFerret;
    public const LowerBodyGoo: Transformation 				= lowerBody.LowerBodyGoo;
    public const LowerBodyHarpy: Transformation 			= lowerBody.LowerBodyHarpy;
    public const LowerBodyHuman: Transformation 			= lowerBody.LowerBodyHuman;
    public const LowerBodyJiangshi: Transformation 			= lowerBody.LowerBodyJiangshi;
    public const LowerBodyOni: Transformation 				= lowerBody.LowerBodyOni;
    public const LowerBodyOrc: Transformation 				= lowerBody.LowerBodyOrc;
    public const LowerBodyPlantFlower: Transformation 		= lowerBody.LowerBodyPlantFlower;
    public const LowerBodyPlantHighHeels: Transformation 	= lowerBody.LowerBodyPlantHighHeels;
    public const LowerBodyPlantRootClaws: Transformation 	= lowerBody.LowerBodyPlantRootClaws;
    public const LowerBodyRedPanda: Transformation 			= lowerBody.LowerBodyRedPanda;
    public const LowerBodySpider: Transformation 			= lowerBody.LowerBodySpider;
    public const LowerBodyWendigo: Transformation 			= lowerBody.LowerBodyWendigo;
    public const LowerBodyYukiOnna: Transformation 			= lowerBody.LowerBodyYukiOnna;
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
    public const LowerBodyBunny: Transformation 			= lowerBody.LowerBodyBunny;
    public const LowerBodyJabberwocky: Transformation 		= lowerBody.LowerBodyJabberwocky;
    public const LowerBodyCrab: Transformation 				= lowerBody.LowerBodyCrab;
    public const LowerBodyCancer: Transformation 			= lowerBody.LowerBodyCancer;
    public const LowerBodySnake: Transformation 			= lowerBody.LowerBodySnake;



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
	public const RearBodyWolfCollar: Transformation 		= rearBody.RearBodyWolfCollar;


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
    public const SkinPlain: Transformation = skin.SkinPlain;
    public const SkinSlippery: Transformation = skin.SkinSlippery;
    public const SkinTransparent: Transformation = skin.SkinTransparent;
    /**
     * @param options = {color/colors,color2/colors2,pattern,adj,desc}
     */
    public function SkinFur(coverage: int = Skin.COVERAGE_COMPLETE, options: * = null): Transformation 					{ return skin.SkinFur(coverage, options); }
    public function SkinFurGradual(coverage:int = Skin.COVERAGE_COMPLETE, options:* = null):Transformation 				{ return skin.SkinFurGradual(coverage, options); }
    public function SkinScales(coverage: int = Skin.COVERAGE_COMPLETE, options: * = null): Transformation 				{ return skin.SkinScales(coverage, options); }
    public function SkinDragonScales(coverage: int = Skin.COVERAGE_COMPLETE, options: * = null): Transformation 		{ return skin.SkinDragonScales(coverage, options); }
    public function SkinChitin(coverage: int = Skin.COVERAGE_COMPLETE, options: * = null): Transformation 				{ return skin.SkinChitin(coverage, options); }
    public function SkinAquaScales(coverage: int = Skin.COVERAGE_HIGH, options: * = null): Transformation 				{ return skin.SkinAquaScales(coverage, options); }
	public function SkinBark(coverage: int = Skin.COVERAGE_COMPLETE, options: * = null): Transformation					{ return skin.SkinBark(coverage, options); }
    public function SkinGoo(coverage: int = Skin.COVERAGE_COMPLETE, type: int = 0, options: * = null): Transformation 	{ return skin.SkinGoo(coverage, type, options); }


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
	public const TailNone: Transformation 						= tail.TailNone;
	public const TailScorpion: Transformation 					= tail.TailScorpion;
	public const TailManticore: Transformation 					= tail.TailManticore;
	public const TailBurning: Transformation 					= tail.TailBurning;
	public const TailTwinkasha: Transformation 					= tail.TailTwinkasha;
	public const TailCat: Transformation 						= tail.TailCat;
	public const TailNekomataOneThirdForked: Transformation 	= tail.TailNekomataOneThirdForked;
	public const TailNekomataTwoThirdsForked: Transformation 	= tail.TailNekomataTwoThirdsForked;
	public const TailCat2nd: Transformation 					= tail.TailCat2nd;
	public const TailRedPanda: Transformation 					= tail.TailRedPanda;
	public const TailHorse: Transformation 						= tail.TailHorse;
	public const TailKirin: Transformation 						= tail.TailKirin;
	public const TailPig: Transformation 						= tail.TailPig;
	public const TailRaiju: Transformation 						= tail.TailRaiju;
	public const TailMantis: Transformation 					= tail.TailMantis;
	public const TailGoat: Transformation 						= tail.TailGoat;
	public const TailCow: Transformation 						= tail.TailCow;
	public const TailDraconic: Transformation 					= tail.TailDraconic;
	public const TailOrca: Transformation 						= tail.TailOrca;
	public const TailSalamander: Transformation 				= tail.TailSalamander;
	public const TailShark: Transformation 						= tail.TailShark;
	public const TailSpider: Transformation 					= tail.TailSpider;
	public const TailHarpy: Transformation 						= tail.TailHarpy;
	public const TailBee: Transformation 						= tail.TailBee;
	public const TailLizard: Transformation 					= tail.TailLizard;
	public const TailDemonic: Transformation 					= tail.TailDemonic;
	public const TailWolf: Transformation 						= tail.TailWolf;
	public const TailDog: Transformation 						= tail.TailDog;
	public const TailCaveWyrm: Transformation 					= tail.TailCaveWyrm;
	public const TailRabbit: Transformation 					= tail.TailRabbit;
	public const TailAvian: Transformation 						= tail.TailAvian;
	public const TailGriffin: Transformation 					= tail.TailGriffin;
	public const TailKangaroo: Transformation 					= tail.TailKangaroo;
	public const TailThunderbird: Transformation 				= tail.TailThunderbird;
	public const TailSquirrel: Transformation 					= tail.TailSquirrel;
	public const TailWeasel: Transformation 					= tail.TailWeasel;
	public const TailRaccoon: Transformation 					= tail.TailRaccoon;
	public const TailMouse: Transformation 						= tail.TailMouse;
	public const TailHinezumi: Transformation 					= tail.TailHinezumi;
	public const TailFerret: Transformation 					= tail.TailFerret;
	public const TailBear: Transformation 						= tail.TailBear;
	public const TailUshiOni: Transformation 					= tail.TailUshiOni;
	public const TailWendigo: Transformation 					= tail.TailWendigo;
	public const TailHydra: Transformation 						= tail.TailHydra;
	public const TailSpinneretAtlach: Transformation 			= tail.TailSpinneretAtlach;
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
	public const TongueHuman: Transformation 		= tongue.TongueHuman;
	public const TongueCat: Transformation 			= tongue.TongueCat;
	public const TongueDog: Transformation 			= tongue.TongueDog;
	public const TongueElf: Transformation 			= tongue.TongueElf;
	public const TongueDraconic: Transformation 	= tongue.TongueDraconic;
	public const TongueSnake: Transformation 		= tongue.TongueSnake;
	public const TongueDemonic: Transformation 		= tongue.TongueDemonic;
	public const TongueRavenous: Transformation 	= tongue.TongueRavenous;
	public const TongueCaveWyrm: Transformation 	= tongue.TongueCaveWyrm;
	public const TongueGhost: Transformation 		= tongue.TongueGhost;
	public const TongueRatatoskr: Transformation 	= tongue.TongueRatatoskr;
	public const TongueMelkie: Transformation 		= tongue.TongueMelkie;


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
    public function CockToVagina(vagina:int = 0): Transformation { return vaginas.CockToVagina(vagina); }
    public function VaginaHuman(vagina:int = 0): Transformation { return vaginas.VaginaHuman(vagina); }
    public function VaginaHorse(vagina:int = 0): Transformation { return vaginas.VaginaHorse(vagina); }
    public function VaginaKirin(vagina:int = 0): Transformation { return vaginas.VaginaKirin(vagina); }
    public function VaginaSandTrap(vagina:int = 0): Transformation { return vaginas.VaginaSandTrap(vagina); }
    public function VaginaCaveWyrm(vagina:int = 0): Transformation { return vaginas.VaginaCaveWyrm(vagina); }
    public function VaginaCentipede(vagina:int = 0): Transformation { return vaginas.VaginaCentipede(vagina); }
    public function VaginaManticore(vagina:int = 0): Transformation { return vaginas.VaginaManticore(vagina); }
    public function VaginaCancer(vagina:int = 0): Transformation { return vaginas.VaginaCancer(vagina); }
    public function VaginaDemonic(vagina:int = 0): Transformation { return vaginas.VaginaDemonic(vagina); }
    public function VaginaScylla(vagina:int = 0): Transformation { return vaginas.VaginaScylla(vagina); }
    public function VaginaNaga(vagina:int = 0): Transformation { return vaginas.VaginaNaga(vagina); }
    public function VaginaShark(vagina:int = 0): Transformation { return vaginas.VaginaShark(vagina); }
    public function VaginaRaiju(vagina:int = 0): Transformation { return vaginas.VaginaRaiju(vagina); }
    public function VaginaAlraune(vagina:int = 0): Transformation { return vaginas.VaginaAlraune(vagina); }


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
	public const WingsNone: Transformation 						= wings.WingsNone;
	public const WingsBeeLarge: Transformation 					= wings.WingsBeeLarge;
	public const WingsBeeSmall: Transformation 					= wings.WingsBeeSmall;
	public const WingsCouatl: Transformation 					= wings.WingsCouatl;
	public const WingsDraconicHuge: Transformation 				= wings.WingsDraconicHuge;
	public const WingsDraconicLarge: Transformation 			= wings.WingsDraconicLarge;
	public const WingsDraconicSmall: Transformation 			= wings.WingsDraconicSmall;
	public const WingsFairy: Transformation 					= wings.WingsFairy;
	public const WingsFeatheredAlicorn: Transformation 			= wings.WingsFeatheredAlicorn;
	public const WingsFeatheredLarge: Transformation 			= wings.WingsFeatheredLarge;
	public const WingsFeatheredPhoenix: Transformation 			= wings.WingsFeatheredPhoenix;
	public const WingsFeatheredSphinx: Transformation 			= wings.WingsFeatheredSphinx;
	public const WingsManticoreLarge: Transformation 			= wings.WingsManticoreLarge;
	public const WingsManticoreSmall: Transformation 			= wings.WingsManticoreSmall;
	public const WingsMantisLarge: Transformation 				= wings.WingsMantisLarge;
	public const WingsMantisSmall: Transformation 				= wings.WingsMantisSmall;
	public const WingsNightmare: Transformation 				= wings.WingsNightmare;
	public const WingsThunderousAura: Transformation 			= wings.WingsThunderousAura;
	public const WingsDemonicLarge: Transformation 				= wings.WingsDemonicLarge;
	public const WingsDemonicTiny: Transformation 				= wings.WingsDemonicTiny;
	public const WingsVampire: Transformation 					= wings.WingsVampire;
	public const WingsFeatheredAvian: Transformation 			= wings.WingsFeatheredAvian;
	public const WingsEthereal: Transformation 					= wings.WingsEthereal;
	public const WingsLevitation: Transformation 				= wings.WingsLevitation;
	public const WingsWindyAura: Transformation 				= wings.WingsWindyAura;
	public const WingsGiantDragonfly: Transformation 			= wings.WingsGiantDragonfly;
	public const WingsSeaDragon: Transformation 				= wings.WingsSeaDragon;
	public const WingsAntLarge: Transformation 					= wings.WingsAntLarge;
	public const WingsAntSmall: Transformation 					= wings.WingsAntSmall;
	public const WingsDevilfeather: Transformation 				= wings.WingsDevilfeather;
	public const WingsFeyDragon: Transformation 				= wings.WingsFeyDragon;
	public const WingsJabberwocky: Transformation 				= wings.WingsJabberwocky;
	public const WingsPlant: Transformation 					= wings.WingsPlant;
	public const WingsYggdrasilLarge: Transformation 			= wings.WingsYggdrasilLarge;
	public const WingsYggdrasilHuge: Transformation 			= wings.WingsYggdrasilHuge;
	public const WingsYggdrasilQuadrupleHuge: Transformation 	= wings.WingsYggdrasilQuadrupleHuge;



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
