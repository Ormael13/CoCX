package classes.Transformations.Transformations {
import classes.Race;
import classes.Races;
import classes.Transformations.*;
import classes.BodyParts.*;
import classes.GeneticMemories.RaceMem;
import classes.Items.MutationsHelper;
import classes.Races.*;
import classes.Scenes.Metamorph;
import classes.StatusEffects;

/**
 * Base class for transformation events.
 */
public class RaceTransformations extends MutationsHelper {
	/*
    *	 RACE
    */
	//															["Antenna",	"Arms",		"Balls",	"Breasts",	"Nips",		"Ears",		"Eyes",			"Face",			"Gills",	"Hair",			"Horns",		"LowerBody",	"RearBody",		"Skin",			"Ovipositor",	"Oviposition",	"GlowingAss",	"Tail",		"Tongue",	"Wings",	"Penis",	"Vagina",	"Perks Required"];
	//public static const Creature:/*String*/Array = 			["Human",	"Human",	"Human",	"Human",	"Human",	"Human",	"Human",		"Human",		"None",		"Human",		"Human",   		"Human",		"Human",    	"Raiju",		"Human",		"Human",		"Human",		"Human",	"Human",	"Human",	"Human",	"Human"];
	public static const HumanRaceBody:/*String*/Array = 		["Human",	"Human",	"Human",	"Human",	"Human",	"Human",	"Human",		"Human",		"None",		"Human",		"Human",		"Human",		"Human",    	"Human",		"Human",		"Human",		"Human",		"Human",	"Human",	"Human",	"Human",	"Human"];
	public static const AlicornRaceBody:/*String*/Array = 		["Human",	"Human",	"Human",	"Normal",	"Human",	"Horse",	"Alicorn",	"Human",		"None",		"Alicorn",	"Unicorn",		"Horse",	"Human",    "Alicorn",	"Human",		"Human",		"Human",		"Horse",	"Human",	"Alicorn",	"Horse",	"Horse"];
	public static const AlrauneRaceBody:/*String*/Array = 		["Human",	"Plant",	"Human",	"Normal",	"Human",	"Elfin",	"Alraune",		"Human",		"None",		"Plant",		"Human",		"Alraune",		"Human",    	"Alraune",		"Human",		"Human",		"Human",		"Human",	"Human",	"Human",	"Alraune",	"Alraune"];
	public static const AntRaceBody:/*String*/Array = 			["Ant",		"Ant",		"Human",	"Normal",	"Human",	"Insect",	"Human",		"Ant",			"None",		"Human",		"Human",		"Ant",			"Human",    	"Ant",			"Ant",			"Human",		"Human",		"Ant",		"Human",	"Ant",		"Insect",	"Vagina"];
	public static const AtlahNachaRaceBody:/*String*/Array =	["Human",	"Spider",	"Human",	"Human",	"Human",	"Elfin",	"AtlachNacha",	"Spider",		"None",		"AtlachNacha",	"Human",		"AtlachNacha",	"AtlachNacha",	"AtlachNacha",	"Spider",		"Human",		"Human",		"Spider",	"Human",	"Human",	"Human",	"Human", 	"AtlachNacha"];
	public static const CouatlRaceBody:/*String*/Array =		["Human",	"Harpy",	"Human",	"Human",	"Human",	"Snake",	"Snake",		"Snake",		"None",		"Feather",		"Human",		"Snake",		"Human",    	"Snake",		"Human",		"Human",		"Human",		"Human",	"Snake",	"Feathered","Lizard",	"Lizard"];
	public static const ElfRaceBody:/*String*/Array =			["Human",	"Elf",		"Human",	"Human",	"Human",	"Elven",	"Elf",			"Elf",			"None",		"Elf",			"Human",		"Elf",			"Human",    	"Elf",			"Human",		"Human",		"Human",		"Human",	"Elf",		"Human",	"Human",	"Human", 	"Elf"];
	public static const GorgonRaceBody:/*String*/Array =		["Human",	"Human",	"Human",	"Human",	"Human",	"Snake",	"Gorgon",		"Snake",		"None",		"Gorgon",		"Human",		"Snake",		"Human",    	"Snake",		"Human",		"Human",		"Human",		"Human",	"Snake",	"Human",	"Lizard",	"Lizard"];
	public static const HydraRaceBody:/*String*/Array =			["Human",	"Hydra",	"Human",	"Human",	"Human",	"Snake",	"Snake",		"Snake",		"None",		"Human",		"Human",		"Hydra",		"Human",    	"Snake",		"Human",		"Human",		"Human",		"Human",	"Snake",	"Human",	"Lizard",	"Lizard"];
	public static const JiangshiRaceBody:/*String*/Array =		["Human",	"Jiangshi",	"Human",	"Human",	"Human",	"Human",	"Jiangshi",		"Jiangshi",		"None",		"Human",		"Jiangshi",		"Jiangshi",		"Human",    	"Jiangshi",		"Human",		"Human",		"Human",		"Human",	"Human",	"Human",	"Human",	"Human", 	"Jiangshi"];
    public static const KitsuneRaceBody:/*String*/Array = 		["Human",	"Kitsune",	"Human",	"Human",	"Human",	"Fox",		"Fox",			"Fox",			"None",		"Kitsune",		"Human",   		"Fox",			"Human",    	"Kitsune",		"Human",		"Human",		"Human",		"Kitsune",	"Human",	"Human",	"Human",	"Human", "Kitsune"];
	public static const NagaRaceBody:/*String*/Array = 			["Human",	"Human",	"Human",	"Human",	"Human",	"Snake",	"Snake",		"Snake",		"None",		"Human",		"Human",		"Snake",		"Human",    	"Snake",		"Human",		"Human",		"Human",		"Human",	"Snake",	"Human",	"Lizard",	"Lizard"];
    public static const RaccoonRaceBody:/*String*/Array = 		["Human",	"Raccoon",	"Raccoon",	"Normal",	"Human",	"Raccoon",	"Raccoon",		"RaccoonMask",	"None",		"Raccoon",		"Human",		"Raccoon",		"Human",    	"Raccoon",		"Human",		"Human",		"Human",		"Raccoon",	"Human",	"Human",	"Raccoon",	"Human"];
	public static const RaijuRaceBody:/*String*/Array = 		["Human",	"Raiju",	"Human",	"Human",	"Glow",		"Raiju",	"Raiju",		"Weasel",		"None",		"Raiju",		"Human",		"Raiju",		"Raiju",    	"Raiju",		"Human",		"Human",		"Glow",			"Raiju",	"Human",	"Thunder",	"Raiju",	"Raiju"];
	public static const VouivreRaceBody:/*String*/Array =		["Human",	"Draconic",	"Human",	"Human",	"Human",	"Draconic",	"Snake",		"Snake",		"None",		"Human",		"QuadDraco",	"Snake",		"Human",    	"Vouivre",		"Human",		"Human",		"Human",		"Human",	"Snake",	"DraconicL","Lizard",	"Lizard"];
/**


																																																			   																																										 flawless plain skin (+1)
*/


	public const FullAlicorn: Transformation = new SimpleTransformation("Alicorn Full Transform",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "[pg]";
				desc += "<b>You are now an Alicorn </b>";
				if (doOutput) outputText(desc);
				Metamorph.runMetamorph(AlicornRaceBody);
			},
			// is present
			function (): Boolean {
				return player.isRace(Races.ALICORN);

			}
	);

	public const FullAlraune: Transformation = new SimpleTransformation("Alraune Full Transform",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "[pg]";
				desc += "<b>You are now an Alraune </b>";
				if (doOutput) outputText(desc);
				Metamorph.runMetamorph(AlrauneRaceBody);
			},
			// is present
			function (): Boolean {
				return player.isRace(Races.ALRAUNE);
			}
	);

	public const FullAtlahNacha: Transformation = new SimpleTransformation("Alraune Full Transform",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "[pg]";
				desc += "<b>You are now an Alraune </b>";
				if (doOutput) outputText(desc);
				Metamorph.runMetamorph(AtlahNachaRaceBody);
			},
			// is present
			function (): Boolean {
				return player.isRace(Races.ATLACH_NACHA);
			}
	);

	public const FullAnt: Transformation = new SimpleTransformation("Ant Full Transform",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "[pg]";
				desc += "<b>You are now an Ant </b>";
				if (doOutput) outputText(desc);
				Metamorph.runMetamorph(AntRaceBody);// AntRace.AntRaceBody);
			},
			// is present
			function (): Boolean {
				return player.isRace(Races.ANT);
			}
	);

	public const FullCouatl: Transformation = new SimpleTransformation("Couatl Full Transform",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "[pg]";
				desc += "<b>You are now a Couatl </b>";
				if (doOutput) outputText(desc);
				Metamorph.runMetamorph(CouatlRaceBody);
			},
			// is present
			function (): Boolean {
				return player.isRace(Races.COUATL);
			}
	);

	public const FullElf: Transformation = new SimpleTransformation("Elf Full Transform",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "[pg]";
				desc += "<b>You are now a Elf </b>";
				if (doOutput) outputText(desc);
				Metamorph.runMetamorph(ElfRaceBody);
			},
			// is present
			function (): Boolean {
				return player.isRace(Races.ELF);
			}
	);

	public const FullGorgon: Transformation = new SimpleTransformation("Gorgon Full Transform",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "[pg]";
				desc += "<b>You are now a Gorgon </b>";
				if (doOutput) outputText(desc);
				Metamorph.runMetamorph(GorgonRaceBody);
			},
			// is present
			function (): Boolean {
				return player.isRace(Races.GORGON);
			}
	);

	public const FullHuman: Transformation = new SimpleTransformation("Human Full Transform",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "[pg]";
				desc += "<b>You are now Human </b>";
				if (doOutput) outputText(desc);
				Metamorph.runMetamorph(HumanRaceBody);// HumanRace.HumanRaceBody);
			},
			// is present
			function (): Boolean {
				return false;
			}
	);


	public const FullHydra: Transformation = new SimpleTransformation("Hydra Full Transform",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "[pg]";
				desc += "<b>You are now Hydra </b>";
				if (doOutput) outputText(desc);

				Metamorph.runMetamorph(HydraRaceBody);// HumanRace.HumanRaceBody);
			},
			// is present
			function (): Boolean {
				return player.isRace(Races.HYDRA);
			}
	);

    public const FullJiangshi: Transformation = new SimpleTransformation("Jiangshi Full Transform",
		// apply effect
		function (doOutput: Boolean): void {
			var desc: String = "[pg]";
			desc += "<b>You are now Jiangshi </b>";
			if (doOutput) outputText(desc);
			Metamorph.runMetamorph(JiangshiRaceBody);
		},
		// is present
		function (): Boolean {
			return player.isRace(Races.JIANGSHI);
		}
    );

    public const FullKitsune: Transformation = new SimpleTransformation("Jiangshi Full Transform",
		// apply effect
		function (doOutput: Boolean): void {
			var desc: String = "[pg]";
			desc += "<b>You are now a 9 Tailed Kitsune </b>";
			if (doOutput) outputText(desc);
			Metamorph.runMetamorph(KitsuneRaceBody);
		},
		// is present
		function (): Boolean {
			return player.isRace(Races.KITSUNE);
		}
    );

	public const FullNaga: Transformation = new SimpleTransformation("Naga Full Transform",
			// apply effect
			function (doOutput: Boolean): void {
				var desc: String = "[pg]";
				desc += "<b>You are now a Naga </b>";
				if (doOutput) outputText(desc);
				Metamorph.runMetamorph(NagaRaceBody);
			},
			// is present
			function (): Boolean {
				return player.isRace(Races.NAGA);
			}
	);

	public const FullRaccoon:Transformation = new SimpleTransformation("Raccoon Full Transform",
			// apply
			function (doOutput:Boolean):void {
				var desc: String = "[pg]";
				desc += "<b>You are now Raccoon </b>";

				if (doOutput) outputText(desc);
				Metamorph.runMetamorph(RaccoonRaceBody);// RaccoonRace.RaccoonRaceBody);
				
				// TODO: Check Qualifications
				//
			},
			// is present
			function ():Boolean { 
				return player.isRace(Races.RACCOON);
			}
	);

	public const FullRaiju:Transformation = new SimpleTransformation("Raiju Full Transform",
			// apply
			function (doOutput:Boolean):void {
				var desc: String = "[pg]";
				desc += "<b>You are now a Raiju </b>";

				if (doOutput) outputText(desc);
				Metamorph.runMetamorph(RaijuRaceBody);
				
				// TODO: Check Qualifications
				//
			},
			// is present
			function ():Boolean { 
				return player.isRace(Races.RAIJU);
			}
	);

	public const FullVouivre:Transformation = new SimpleTransformation("Vouivre Full Transform",
			// apply
			function (doOutput:Boolean):void {
				var desc: String = "[pg]";
				desc += "<b>You are now a Vouivre </b>";

				if (doOutput) outputText(desc);
				Metamorph.runMetamorph(VouivreRaceBody);
				
				// TODO: Check Qualifications
				//
			},
			// is present
			function ():Boolean { 
				return player.isRace(Races.VOUIVRE);
			}
	);

	
}

}
