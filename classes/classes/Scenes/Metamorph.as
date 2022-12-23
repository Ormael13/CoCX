/**
 * ...
 * @author Ormael
 */
package classes.Scenes {
	import classes.*;
	import classes.GeneticMemories.VaginaCountMem;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.Areas.Ocean.Scylla;
import classes.internals.SaveableState;
	import classes.BodyParts.Hair;
	import classes.BodyParts.Antennae;
	import classes.BodyParts.Arms;
	import classes.BodyParts.Ears;
	import classes.BodyParts.Eyes;
	import classes.BodyParts.Face;
	import classes.BodyParts.Gills;
	import classes.BodyParts.Horns;
	import classes.BodyParts.LowerBody;
	import classes.BodyParts.RearBody;
	import classes.BodyParts.Skin;
	import classes.BodyParts.Tail;
	import classes.BodyParts.Tongue;
	import classes.BodyParts.Wings;
	import classes.Races.*;

	import classes.GeneticMemories.*;


	use namespace CoC;

	public class Metamorph extends BaseContent implements SaveableState {

		public static var GeneticMemoryStorage: Object;
		public static var PermanentMemoryStorage: Object;
		public static var TriggerUpdate: Boolean;

		public function stateObjectName():String {
			return "GeneticMemoryStorage";
		}

		public function resetState():void {
			GeneticMemoryStorage = {};
			if (!PermanentMemoryStorage) PermanentMemoryStorage = {};

			// Generic value for TFs unlocked from the beginning
			GeneticMemoryStorage["Unlocked Metamorph"] = true;
		}

		public function saveToObject():Object {
			return {
				"genetic memory storage": GeneticMemoryStorage,
				"permanent memory storage": PermanentMemoryStorage
			};
		}

		public function loadFromObject(o:Object, ignoreErrors:Boolean):void {
			if (o) {
				GeneticMemoryStorage = {};
				var storage:* = o["genetic memory storage"];
				for (var k:String in storage) {
    			if (storage.hasOwnProperty(k)) GeneticMemoryStorage[k] = !!storage[k];
				}

				if (!o["permanent memory storage"]) {
					TriggerUpdate = true;
				}

				PermanentMemoryStorage = {};
				var storage2:* = o["permanent memory storage"];
				for (var k2:String in storage2) {
    			if (storage2.hasOwnProperty(k2)) PermanentMemoryStorage[k2] = !!storage2[k2];
				}
				var permedMetamorphCount:int = Metamorph.PermanentMemoryStorage.length;
				player.removeStatusEffect(StatusEffects.TranscendentalGeneticMemory);
				player.createStatusEffect(StatusEffects.TranscendentalGeneticMemory, 15 * player.perkv1(PerkLib.AscensionTrancendentalGeneticMemoryStageX), permedMetamorphCount, 0, 0);
			} else {
				// Migration from old save
				resetState();
				TriggerUpdate = true;
			}
		}

		private static function refundAscMetamorph(): Boolean {
			const refunded: Boolean = player.hasStatusEffect(StatusEffects.TranscendentalGeneticMemory);

			// Refunding Ascension Perk Points for each permanent Metamorph, including costlier human parts, and enable opening Ascension menu
			/*
				*/
				// Non-human permanent Metamorphs cost 5 points each
				player.ascensionPerkPoints += player.statusEffectv2(StatusEffects.TranscendentalGeneticMemory) * 5;
				player.removeStatusEffect(StatusEffects.TranscendentalGeneticMemory);

				// Upgrade prices
				if (player.hasPerk(PerkLib.AscensionTranscendentalGeneticMemoryStage1)) {
					player.removePerk(PerkLib.AscensionTranscendentalGeneticMemoryStage1);
					player.ascensionPerkPoints += 15;
				}
				if (player.hasPerk(PerkLib.AscensionTranscendentalGeneticMemoryStage2)) {
					player.removePerk(PerkLib.AscensionTranscendentalGeneticMemoryStage2);
					player.ascensionPerkPoints += 30;
				}
				if (player.hasPerk(PerkLib.AscensionTranscendentalGeneticMemoryStage3)) {
					player.removePerk(PerkLib.AscensionTranscendentalGeneticMemoryStage3);
					player.ascensionPerkPoints += 45;
				}
				if (player.hasPerk(PerkLib.AscensionTranscendentalGeneticMemoryStage4)) {
					player.removePerk(PerkLib.AscensionTranscendentalGeneticMemoryStage4);
					player.ascensionPerkPoints += 60;
				}
				if (player.hasPerk(PerkLib.AscensionTranscendentalGeneticMemoryStage5)) {
					player.removePerk(PerkLib.AscensionTranscendentalGeneticMemoryStage5);
					player.ascensionPerkPoints += 75;
				}
				if (player.hasPerk(PerkLib.AscensionTranscendentalGeneticMemoryStage6)) {
					player.removePerk(PerkLib.AscensionTranscendentalGeneticMemoryStage6);
					player.ascensionPerkPoints += 90;
				}

				// Human permanent Metamorphs cost 25 each, but 5 was already refunded, leaving 20
				if (player.statusEffectv4(StatusEffects.UnlockedHumanHair) == 9000) player.ascensionPerkPoints += 20;
				player.removeStatusEffect(StatusEffects.UnlockedHumanHair);
				if (player.statusEffectv4(StatusEffects.UnlockedHumanFace) == 9000) player.ascensionPerkPoints += 20;
				player.removeStatusEffect(StatusEffects.UnlockedHumanFace);
				if (player.statusEffectv4(StatusEffects.UnlockedHumanEyes) == 9000) player.ascensionPerkPoints += 20;
				player.removeStatusEffect(StatusEffects.UnlockedHumanEyes);
				if (player.statusEffectv4(StatusEffects.UnlockedHumanTongue) == 9000) player.ascensionPerkPoints += 20;
				player.removeStatusEffect(StatusEffects.UnlockedHumanTongue);
				if (player.statusEffectv4(StatusEffects.UnlockedHumanEars) == 9000) player.ascensionPerkPoints += 20;
				player.removeStatusEffect(StatusEffects.UnlockedHumanEars);
				if (player.statusEffectv4(StatusEffects.UnlockedHumanArms) == 9000) player.ascensionPerkPoints += 20;
				player.removeStatusEffect(StatusEffects.UnlockedHumanArms);
				if (player.statusEffectv4(StatusEffects.UnlockedHumanLowerBody) == 9000) player.ascensionPerkPoints += 20;
				player.removeStatusEffect(StatusEffects.UnlockedHumanLowerBody);
				if (player.statusEffectv4(StatusEffects.UnlockedHumanNoHorns) == 9000) player.ascensionPerkPoints += 20;
				player.removeStatusEffect(StatusEffects.UnlockedHumanNoHorns);
				if (player.statusEffectv4(StatusEffects.UnlockedHumanNoWings) == 9000) player.ascensionPerkPoints += 20;
				player.removeStatusEffect(StatusEffects.UnlockedHumanNoWings);
				if (player.statusEffectv4(StatusEffects.UnlockedHumanSkin) == 9000) player.ascensionPerkPoints += 20;
				player.removeStatusEffect(StatusEffects.UnlockedHumanSkin);
				if (player.statusEffectv4(StatusEffects.UnlockedHumanNoSkinPattern) == 9000) player.ascensionPerkPoints += 20;
				player.removeStatusEffect(StatusEffects.UnlockedHumanNoSkinPattern);
				if (player.statusEffectv4(StatusEffects.UnlockedHumanNoAntennae) == 9000) player.ascensionPerkPoints += 20;
				player.removeStatusEffect(StatusEffects.UnlockedHumanNoAntennae);
				if (player.statusEffectv4(StatusEffects.UnlockedHumanNoGills) == 9000) player.ascensionPerkPoints += 20;
				player.removeStatusEffect(StatusEffects.UnlockedHumanNoGills);
				if (player.statusEffectv4(StatusEffects.UnlockedHumanNoRearBody) == 9000) player.ascensionPerkPoints += 20;
				player.removeStatusEffect(StatusEffects.UnlockedHumanNoRearBody);
				if (player.statusEffectv4(StatusEffects.UnlockedHumanNoTail) == 9000) player.ascensionPerkPoints += 20;
				player.removeStatusEffect(StatusEffects.UnlockedHumanNoTail);
				/*
			*/

			return refunded;
		}

		private static function convertUnlockMetamorphFlags(): void {
			// Converting Unlocked flags into Genetic Memory Storage (Human flags are dealt with separately)
			/*
				*/
				if (player.hasStatusEffect(StatusEffects.UnlockedHarpyHair)) GeneticMemoryStorage["Feather Hair"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedHarpyHair);
				if (player.hasStatusEffect(StatusEffects.UnlockedGorgonHair)) GeneticMemoryStorage["Gorgon Hair"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedGorgonHair);
				if (player.hasStatusEffect(StatusEffects.UnlockedElfHair)) GeneticMemoryStorage["Silky Hair"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedElfHair);
				trace("LOADED");
				trace(player.hasStatusEffect(StatusEffects.UnlockedRaijuHair));
				if (player.hasStatusEffect(StatusEffects.UnlockedRaijuHair)) GeneticMemoryStorage["Storm Hair"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedRaijuHair);
				if (player.hasStatusEffect(StatusEffects.UnlockedHellcatBurningHair)) GeneticMemoryStorage["Burning Hair"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedHellcatBurningHair);
				if (player.hasStatusEffect(StatusEffects.UnlockedHorseFace)) GeneticMemoryStorage["Horse Face"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedHorseFace);
				if (player.hasStatusEffect(StatusEffects.UnlockedCowMinotaurFace)) GeneticMemoryStorage["Cow Minotaur Face"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedCowMinotaurFace);
				if (player.hasStatusEffect(StatusEffects.UnlockedSharkTeeth)) GeneticMemoryStorage["Shark Teeth Face"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedSharkTeeth);
				if (player.hasStatusEffect(StatusEffects.UnlockedSnakeFangs)) GeneticMemoryStorage["Snake Fangs Face"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedSnakeFangs);
				if (player.hasStatusEffect(StatusEffects.UnlockedCatFace)) GeneticMemoryStorage["Cat Face"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedCatFace);
				if (player.hasStatusEffect(StatusEffects.UnlockedCatFangs)) GeneticMemoryStorage["Cat Canines Face"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedCatFangs);
				if (player.hasStatusEffect(StatusEffects.UnlockedLizardFace)) GeneticMemoryStorage["Lizard Face"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedLizardFace);
				if (player.hasStatusEffect(StatusEffects.UnlockedSpiderFangs)) GeneticMemoryStorage["Spider Fangs Face"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedSpiderFangs);
				if (player.hasStatusEffect(StatusEffects.UnlockedFoxFace)) GeneticMemoryStorage["Fox Face"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedFoxFace);
				if (player.hasStatusEffect(StatusEffects.UnlockedPigFace)) GeneticMemoryStorage["Pig Face"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedPigFace);
				if (player.hasStatusEffect(StatusEffects.UnlockedBoarFace)) GeneticMemoryStorage["Boar Face"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedBoarFace);
				if (player.hasStatusEffect(StatusEffects.UnlockedManticoreFace)) GeneticMemoryStorage["Manticore Face"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedManticoreFace);
				if (player.hasStatusEffect(StatusEffects.UnlockedSalamanderFace)) GeneticMemoryStorage["Salamander Fangs Face"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedSalamanderFace);
				if (player.hasStatusEffect(StatusEffects.UnlockedOrcaFace)) GeneticMemoryStorage["Orca Face"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedOrcaFace);
				if (player.hasStatusEffect(StatusEffects.UnlockedDraconicFace)) GeneticMemoryStorage["Draconic Face"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedDraconicFace);
				if (player.hasStatusEffect(StatusEffects.UnlockedDraconicFangs)) GeneticMemoryStorage["Draconic Fangs Face"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedDraconicFangs);
				if (player.hasStatusEffect(StatusEffects.UnlockedDevilFangs)) GeneticMemoryStorage["Devil Fangs Face"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedDevilFangs);
				if (player.hasStatusEffect(StatusEffects.UnlockedOniFace)) GeneticMemoryStorage["Oni Teeth Face"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedOniFace);
				if (player.hasStatusEffect(StatusEffects.UnlockedRaijuFace)) GeneticMemoryStorage["Weasel Face"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedRaijuFace);
				if (player.hasStatusEffect(StatusEffects.UnlockedVampireFace)) GeneticMemoryStorage["Vampire Face"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedVampireFace);
				if (player.hasStatusEffect(StatusEffects.UnlockedRedPandaFace)) GeneticMemoryStorage["Red Panda Face"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedRedPandaFace);
				if (player.hasStatusEffect(StatusEffects.UnlockedCheshireFace)) GeneticMemoryStorage["Cheshire Face"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedCheshireFace);
				if (player.hasStatusEffect(StatusEffects.UnlockedCheshireSmile)) GeneticMemoryStorage["Cheshire Smile Face"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedCheshireSmile);
				if (player.hasStatusEffect(StatusEffects.UnlockedOrcFangs)) GeneticMemoryStorage["Orc Fangs Face"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedOrcFangs);
				if (player.hasStatusEffect(StatusEffects.UnlockedSpiderFourEyes)) GeneticMemoryStorage["Spider Eyes"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedSpiderFourEyes);
				if (player.hasStatusEffect(StatusEffects.UnlockedCatEyes)) GeneticMemoryStorage["Cat Eyes"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedCatEyes);
				if (player.hasStatusEffect(StatusEffects.UnlockedGorgonEyes)) GeneticMemoryStorage["Gorgon Eyes"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedGorgonEyes);
				if (player.hasStatusEffect(StatusEffects.UnlockedManticoreEyes)) GeneticMemoryStorage["Manticore Eyes"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedManticoreEyes);
				if (player.hasStatusEffect(StatusEffects.UnlockedFoxEyes)) GeneticMemoryStorage["Fox Eyes"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedFoxEyes);
				if (player.hasStatusEffect(StatusEffects.UnlockedLizardEyes)) GeneticMemoryStorage["Lizard Eyes"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedLizardEyes);
				if (player.hasStatusEffect(StatusEffects.UnlockedSnakeEyes)) GeneticMemoryStorage["Snake Eyes"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedSnakeEyes);
				if (player.hasStatusEffect(StatusEffects.UnlockedDraconicEyes)) GeneticMemoryStorage["Draconic Eyes"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedDraconicEyes);
				if (player.hasStatusEffect(StatusEffects.UnlockedDevilEyes)) GeneticMemoryStorage["Devil Eyes"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedDevilEyes);
				if (player.hasStatusEffect(StatusEffects.UnlockedOniEyes)) GeneticMemoryStorage["Oni Eyes"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedOniEyes);
				if (player.hasStatusEffect(StatusEffects.UnlockedElfEyes)) GeneticMemoryStorage["Elf Eyes"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedElfEyes);
				if (player.hasStatusEffect(StatusEffects.UnlockedRaijuEyes)) GeneticMemoryStorage["Raiju Eyes"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedRaijuEyes);
				if (player.hasStatusEffect(StatusEffects.UnlockedVampireEyes)) GeneticMemoryStorage["Vampire Eyes"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedVampireEyes);
				if (player.hasStatusEffect(StatusEffects.UnlockedHellcatInfernalEyes)) GeneticMemoryStorage["Infernal Eyes"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedHellcatInfernalEyes);
				if (player.hasStatusEffect(StatusEffects.UnlockedOrcEyes)) GeneticMemoryStorage["Orc Eyes"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedOrcEyes);
				if (player.hasStatusEffect(StatusEffects.UnlockedDisplacerEyes)) GeneticMemoryStorage["Displacer Eyes"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedDisplacerEyes);
				if (player.hasStatusEffect(StatusEffects.UnlockedSnakeTongue)) GeneticMemoryStorage["Snake Tongue"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedSnakeTongue);
				if (player.hasStatusEffect(StatusEffects.UnlockedDemonTonuge)) GeneticMemoryStorage["Demonic Tongue"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedDemonTonuge);
				if (player.hasStatusEffect(StatusEffects.UnlockedDraconicTongue)) GeneticMemoryStorage["Draconic Tongue"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedDraconicTongue);
				if (player.hasStatusEffect(StatusEffects.UnlockedCatTongue)) GeneticMemoryStorage["Cat Tongue"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedCatTongue);
				if (player.hasStatusEffect(StatusEffects.UnlockedElfTongue)) GeneticMemoryStorage["Elf Tongue"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedElfTongue);
				if (player.hasStatusEffect(StatusEffects.UnlockedHorseEars)) GeneticMemoryStorage["Horse Ears"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedHorseEars);
				if (player.hasStatusEffect(StatusEffects.UnlockedCowEars)) GeneticMemoryStorage["Cow Ears"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedCowEars);
				if (player.hasStatusEffect(StatusEffects.UnlockedElfinEars)) GeneticMemoryStorage["Elfin Ears"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedElfinEars);
				if (player.hasStatusEffect(StatusEffects.UnlockedCatEars)) GeneticMemoryStorage["Cat Ears"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedCatEars);
				if (player.hasStatusEffect(StatusEffects.UnlockedLizardEars)) GeneticMemoryStorage["Lizard Ears"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedLizardEars);
				if (player.hasStatusEffect(StatusEffects.UnlockedFoxEars)) GeneticMemoryStorage["Fox Ears"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedFoxEars);
				if (player.hasStatusEffect(StatusEffects.UnlockedDraconicEars)) GeneticMemoryStorage["Draconic Ears"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedDraconicEars);
				if (player.hasStatusEffect(StatusEffects.UnlockedPigEars)) GeneticMemoryStorage["Pig Ears"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedPigEars);
				if (player.hasStatusEffect(StatusEffects.UnlockedLionEars)) GeneticMemoryStorage["Lion Ears"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedLionEars);
				if (player.hasStatusEffect(StatusEffects.UnlockedOrcaEars)) GeneticMemoryStorage["Orca Ears"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedOrcaEars);
				if (player.hasStatusEffect(StatusEffects.UnlockedSnakeEars)) GeneticMemoryStorage["Snake Ears"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedSnakeEars);
				if (player.hasStatusEffect(StatusEffects.UnlockedGoatEars)) GeneticMemoryStorage["Goat Ears"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedGoatEars);
				if (player.hasStatusEffect(StatusEffects.UnlockedOniEars)) GeneticMemoryStorage["Oni Ears"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedOniEars);
				if (player.hasStatusEffect(StatusEffects.UnlockedElfEars)) GeneticMemoryStorage["Elven Ears"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedElfEars);
				if (player.hasStatusEffect(StatusEffects.UnlockedRaijuEars)) GeneticMemoryStorage["Weasel Ears"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedRaijuEars);
				if (player.hasStatusEffect(StatusEffects.UnlockedBatEars)) GeneticMemoryStorage["Bat Ears"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedBatEars);
				if (player.hasStatusEffect(StatusEffects.UnlockedVampireEars)) GeneticMemoryStorage["Vampire Ears"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedVampireEars);
				if (player.hasStatusEffect(StatusEffects.UnlockedRedPandaEars)) GeneticMemoryStorage["Red Panda Ears"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedRedPandaEars);
				if (player.hasStatusEffect(StatusEffects.UnlockedDisplacerEars)) GeneticMemoryStorage["Displacer Ears"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedDisplacerEars);
				if (player.hasStatusEffect(StatusEffects.UnlockedDemonHorns)) GeneticMemoryStorage["Demon Horns"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedDemonHorns);
				if (player.hasStatusEffect(StatusEffects.UnlockedCowMinotaurHorns)) GeneticMemoryStorage["Cow Minotaur Horns"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedCowMinotaurHorns);
				if (player.hasStatusEffect(StatusEffects.UnlockedDraconicX2)) GeneticMemoryStorage["Draconic Dual Horns"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedDraconicX2);
				if (player.hasStatusEffect(StatusEffects.UnlockedDraconicX4)) GeneticMemoryStorage["Draconic Quadruple Horns"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedDraconicX4);
				if (player.hasStatusEffect(StatusEffects.UnlockedGoatHorns)) GeneticMemoryStorage["Goat Horns"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedGoatHorns);
				if (player.hasStatusEffect(StatusEffects.UnlockedUnicornHorn)) GeneticMemoryStorage["Unicorn Horn"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedUnicornHorn);
				if (player.hasStatusEffect(StatusEffects.UnlockedOniSingleHorn)) GeneticMemoryStorage["Oni Horn"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedOniSingleHorn);
				if (player.hasStatusEffect(StatusEffects.UnlockedOniTwinHorns)) GeneticMemoryStorage["Oni Dual Horns"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedOniTwinHorns);
				if (player.hasStatusEffect(StatusEffects.UnlockedBicornHorns)) GeneticMemoryStorage["Bicorn Horns"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedBicornHorns);
				if (player.hasStatusEffect(StatusEffects.UnlockedHarpyArms)) GeneticMemoryStorage["Harpy Arms"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedHarpyArms);
				if (player.hasStatusEffect(StatusEffects.UnlockedSpiderArms)) GeneticMemoryStorage["Spider Arms"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedSpiderArms);
				if (player.hasStatusEffect(StatusEffects.UnlockedMantisArms)) GeneticMemoryStorage["Mantis Arms"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedMantisArms);
				if (player.hasStatusEffect(StatusEffects.UnlockedBeeArms)) GeneticMemoryStorage["Bee Arms"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedBeeArms);
				if (player.hasStatusEffect(StatusEffects.UnlockedSalamanderArms)) GeneticMemoryStorage["Salamander Arms"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedSalamanderArms);
				if (player.hasStatusEffect(StatusEffects.UnlockedPhoenixArms)) GeneticMemoryStorage["Phoenix Arms"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedPhoenixArms);
				if (player.hasStatusEffect(StatusEffects.UnlockedSharkArms)) GeneticMemoryStorage["Shark Arms"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedSharkArms);
				if (player.hasStatusEffect(StatusEffects.UnlockedLionArms)) GeneticMemoryStorage["Lion Arms"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedLionArms);
				if (player.hasStatusEffect(StatusEffects.UnlockedFoxArms)) GeneticMemoryStorage["Fox Arms"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedFoxArms);
				if (player.hasStatusEffect(StatusEffects.UnlockedKitsuneArms)) GeneticMemoryStorage["Kitsune Arms"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedKitsuneArms);
				if (player.hasStatusEffect(StatusEffects.UnlockedLizardArms)) GeneticMemoryStorage["Lizard Arms"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedLizardArms);
				if (player.hasStatusEffect(StatusEffects.UnlockedDraconicArms)) GeneticMemoryStorage["Draconic Arms"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedDraconicArms);
				if (player.hasStatusEffect(StatusEffects.UnlockedOrcaArms)) GeneticMemoryStorage["Orca Arms"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedOrcaArms);
				if (player.hasStatusEffect(StatusEffects.UnlockedDevilArms)) GeneticMemoryStorage["Devil Arms"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedDevilArms);
				if (player.hasStatusEffect(StatusEffects.UnlockedOniArms)) GeneticMemoryStorage["Oni Arms"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedOniArms);
				if (player.hasStatusEffect(StatusEffects.UnlockedElfArms)) GeneticMemoryStorage["Elf Arms"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedElfArms);
				if (player.hasStatusEffect(StatusEffects.UnlockedRaijuArms)) GeneticMemoryStorage["Raiju Arms"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedRaijuArms);
				if (player.hasStatusEffect(StatusEffects.UnlockedRedPandaArms)) GeneticMemoryStorage["Red Panda Arms"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedRedPandaArms);
				if (player.hasStatusEffect(StatusEffects.UnlockedCatArms)) GeneticMemoryStorage["Cat Arms"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedCatArms);
				if (player.hasStatusEffect(StatusEffects.UnlockedSphinxArms)) GeneticMemoryStorage["Sphinx Arms"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedSphinxArms);
				if (player.hasStatusEffect(StatusEffects.UnlockedPigArms)) GeneticMemoryStorage["Pig Arms"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedPigArms);
				if (player.hasStatusEffect(StatusEffects.UnlockedBoarArms)) GeneticMemoryStorage["Boar Arms"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedBoarArms);
				if (player.hasStatusEffect(StatusEffects.UnlockedOrcArms)) GeneticMemoryStorage["Orc Arms"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedOrcArms);
				if (player.hasStatusEffect(StatusEffects.UnlockedDisplacerArms)) GeneticMemoryStorage["Displacer Arms"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedDisplacerArms);
				if (player.hasStatusEffect(StatusEffects.UnlockedRaijuArms2)) GeneticMemoryStorage["Raiju Paws Arms"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedRaijuArms2);
				if (player.hasStatusEffect(StatusEffects.UnlockedBatWings)) GeneticMemoryStorage["Bat Wing Arms"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedBatWings);
				if (player.hasStatusEffect(StatusEffects.UnlockedBeeWingsSmall)) GeneticMemoryStorage["Bee Small Wings"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedBeeWingsSmall);
				if (player.hasStatusEffect(StatusEffects.UnlockedBeeWingsLarge)) GeneticMemoryStorage["Bee Large Wings"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedBeeWingsLarge);
				if (player.hasStatusEffect(StatusEffects.UnlockedDemonTinyBatWings)) GeneticMemoryStorage["Demonic Tiny Wings"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedDemonTinyBatWings);
				if (player.hasStatusEffect(StatusEffects.UnlockedDemonLargeBatWings)) GeneticMemoryStorage["Demonic Large Wings"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedDemonLargeBatWings);
				if (player.hasStatusEffect(StatusEffects.UnlockedDemonLargeBatWings2)) GeneticMemoryStorage["Demonic Large Quadruple Wings"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedDemonLargeBatWings2);
				if (player.hasStatusEffect(StatusEffects.UnlockedHarpyWings)) GeneticMemoryStorage["Feathered Large Wings"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedHarpyWings);
				if (player.hasStatusEffect(StatusEffects.UnlockedDraconicWingsSmall)) GeneticMemoryStorage["Draconic Small Wings"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedDraconicWingsSmall);
				if (player.hasStatusEffect(StatusEffects.UnlockedDraconicWingsLarge)) GeneticMemoryStorage["Draconic Large Wings"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedDraconicWingsLarge);
				if (player.hasStatusEffect(StatusEffects.UnlockedDraconicWingsHuge)) GeneticMemoryStorage["Draconic Huge Wings"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedDraconicWingsHuge);
				if (player.hasStatusEffect(StatusEffects.UnlockedPhoenixWings)) GeneticMemoryStorage["Feathered Phoenix Wings"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedPhoenixWings);
				if (player.hasStatusEffect(StatusEffects.UnlockedAlicornWings)) GeneticMemoryStorage["Feathered Alicorn Wings"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedAlicornWings);
				if (player.hasStatusEffect(StatusEffects.UnlockedMantisWingsSmall)) GeneticMemoryStorage["Mantis Small Wings"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedMantisWingsSmall);
				if (player.hasStatusEffect(StatusEffects.UnlockedMantisWingsLarge)) GeneticMemoryStorage["Mantis Large Wings"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedMantisWingsLarge);
				if (player.hasStatusEffect(StatusEffects.UnlockedManticoreWingsSmall)) GeneticMemoryStorage["Manticore Small Wings"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedManticoreWingsSmall);
				if (player.hasStatusEffect(StatusEffects.UnlockedManticoreWingsLarge)) GeneticMemoryStorage["Manticore Large Wings"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedManticoreWingsLarge);
				if (player.hasStatusEffect(StatusEffects.UnlockedVampireWings)) GeneticMemoryStorage["Vampire Wings"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedVampireWings);
				if (player.hasStatusEffect(StatusEffects.UnlockedNightmareWings)) GeneticMemoryStorage["Nightmare Wings"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedNightmareWings);
				if (player.hasStatusEffect(StatusEffects.UnlockedSphinxWings)) GeneticMemoryStorage["Feathered Sphinx Wings"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedSphinxWings);
				if (player.hasStatusEffect(StatusEffects.UnlockedRaijuThunderousAura)) GeneticMemoryStorage["Thunderous Aura (Wings)"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedRaijuThunderousAura);
				if (player.hasStatusEffect(StatusEffects.UnlockedFur)) GeneticMemoryStorage["Fur Skin"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedFur);
				if (player.hasStatusEffect(StatusEffects.UnlockedScales)) GeneticMemoryStorage["Scales Skin"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedScales);
				if (player.hasStatusEffect(StatusEffects.UnlockedChitin)) GeneticMemoryStorage["Chitin Skin"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedChitin);
				if (player.hasStatusEffect(StatusEffects.UnlockedDragonScales)) GeneticMemoryStorage["Dragon Scales Skin"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedDragonScales);
				if (player.hasStatusEffect(StatusEffects.UnlockedTattoed)) GeneticMemoryStorage["Kitsune Skin Pattern"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedTattoed);
				if (player.hasStatusEffect(StatusEffects.UnlockedBattleTattoed)) GeneticMemoryStorage["Oni Skin Pattern"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedBattleTattoed);
				if (player.hasStatusEffect(StatusEffects.UnlockedLightningTattoed)) GeneticMemoryStorage["Raiju Skin Pattern"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedLightningTattoed);
				if (player.hasStatusEffect(StatusEffects.UnlockedScarTattoed)) GeneticMemoryStorage["Orc Skin Pattern"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedScarTattoed);
				if (player.hasStatusEffect(StatusEffects.UnlockedMantisAntennae)) GeneticMemoryStorage["Mantis Antennae"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedMantisAntennae);
				if (player.hasStatusEffect(StatusEffects.UnlockedBeeAntennae)) GeneticMemoryStorage["Bee Antennae"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedBeeAntennae);
				if (player.hasStatusEffect(StatusEffects.UnlockedFishGills)) GeneticMemoryStorage["Fish Gills"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedFishGills);
				if (player.hasStatusEffect(StatusEffects.UnlockedLionMane)) GeneticMemoryStorage["Lion Mane Rear Body"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedLionMane);
				if (player.hasStatusEffect(StatusEffects.UnlockedSharkFin)) GeneticMemoryStorage["Shark Fin Rear Body"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedSharkFin);
				if (player.hasStatusEffect(StatusEffects.UnlockedOrcaBlowhole)) GeneticMemoryStorage["Orca Blowhole Rear Body"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedOrcaBlowhole);
				if (player.hasStatusEffect(StatusEffects.UnlockedRaijuMane)) GeneticMemoryStorage["Raiju Mane Rear Body"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedRaijuMane);
				if (player.hasStatusEffect(StatusEffects.UnlockedBatCollar)) GeneticMemoryStorage["Bat Collar Rear Body"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedBatCollar);
				if (player.hasStatusEffect(StatusEffects.UnlockedDisplacerBTentacles)) GeneticMemoryStorage["Displacer Tentacles Rear Body"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedDisplacerBTentacles);
				if (player.hasStatusEffect(StatusEffects.UnlockedHorseTail)) GeneticMemoryStorage["Horse Tail"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedHorseTail);
				if (player.hasStatusEffect(StatusEffects.UnlockedDemonTail)) GeneticMemoryStorage["Demonic Tail"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedDemonTail);
				if (player.hasStatusEffect(StatusEffects.UnlockedCowTail)) GeneticMemoryStorage["Cow Tail"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedCowTail);
				if (player.hasStatusEffect(StatusEffects.UnlockedSpiderTail)) GeneticMemoryStorage["Spider Tail"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedSpiderTail);
				if (player.hasStatusEffect(StatusEffects.UnlockedBeeTail)) GeneticMemoryStorage["Bee Tail"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedBeeTail);
				if (player.hasStatusEffect(StatusEffects.UnlockedSharkTail)) GeneticMemoryStorage["Shark Tail"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedSharkTail);
				if (player.hasStatusEffect(StatusEffects.UnlockedLizardTail)) GeneticMemoryStorage["Lizard Tail"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedLizardTail);
				if (player.hasStatusEffect(StatusEffects.UnlockedHarpyTail)) GeneticMemoryStorage["Harpy Tail"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedHarpyTail);
				if (player.hasStatusEffect(StatusEffects.UnlockedDraconicTail)) GeneticMemoryStorage["Draconic Tail"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedDraconicTail);
				if (player.hasStatusEffect(StatusEffects.UnlockedPigTail)) GeneticMemoryStorage["Pig Tail"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedPigTail);
				if (player.hasStatusEffect(StatusEffects.UnlockedScorpionTail)) GeneticMemoryStorage["Scorpion Tail"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedScorpionTail);
				if (player.hasStatusEffect(StatusEffects.UnlockedManticoreTail)) GeneticMemoryStorage["Manticore Tail"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedManticoreTail);
				if (player.hasStatusEffect(StatusEffects.UnlockedGoatTail)) GeneticMemoryStorage["Goat Tail"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedGoatTail);
				if (player.hasStatusEffect(StatusEffects.UnlockedSalamanderTail)) GeneticMemoryStorage["Salamander Tail"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedSalamanderTail);
				if (player.hasStatusEffect(StatusEffects.UnlockedMantisTail)) GeneticMemoryStorage["Mantis Tail"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedMantisTail);
				if (player.hasStatusEffect(StatusEffects.UnlockedOrcaTail)) GeneticMemoryStorage["Orca Tail"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedOrcaTail);
				if (player.hasStatusEffect(StatusEffects.UnlockedRaijuTail)) GeneticMemoryStorage["Raiju Tail"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedRaijuTail);
				if (player.hasStatusEffect(StatusEffects.UnlockedRedPandaTail)) GeneticMemoryStorage["Red Panda Tail"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedRedPandaTail);
				if (player.hasStatusEffect(StatusEffects.UnlockedHellcatBurningTail)) GeneticMemoryStorage["Burning Tail"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedHellcatBurningTail);
				if (player.hasStatusEffect(StatusEffects.UnlockedCatTail)) GeneticMemoryStorage["Cat Tail"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedCatTail);
				if (player.hasStatusEffect(StatusEffects.UnlockedNekomataForkedTail1)) GeneticMemoryStorage["Forked 1/3 Tail"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedNekomataForkedTail1);
				if (player.hasStatusEffect(StatusEffects.UnlockedNekomataForkedTail2)) GeneticMemoryStorage["Forked 2/3 Tail"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedNekomataForkedTail2);
				if (player.hasStatusEffect(StatusEffects.UnlockedCatTail2nd)) GeneticMemoryStorage["Cat 2nd Tail"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedCatTail2nd);
				if (player.hasStatusEffect(StatusEffects.UnlockedFoxTail)) GeneticMemoryStorage["Fox Tail"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedFoxTail);
				if (player.hasStatusEffect(StatusEffects.UnlockedFoxTail2nd)) GeneticMemoryStorage["Fox 2nd Tail"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedFoxTail2nd);
				if (player.hasStatusEffect(StatusEffects.UnlockedFoxTail3rd)) GeneticMemoryStorage["Fox 3rd Tail"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedFoxTail3rd);
				if (player.hasStatusEffect(StatusEffects.UnlockedFoxTail4th)) GeneticMemoryStorage["Fox 4th Tail"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedFoxTail4th);
				if (player.hasStatusEffect(StatusEffects.UnlockedFoxTail5th)) GeneticMemoryStorage["Fox 5th Tail"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedFoxTail5th);
				if (player.hasStatusEffect(StatusEffects.UnlockedFoxTail6th)) GeneticMemoryStorage["Fox 6th Tail"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedFoxTail6th);
				if (player.hasStatusEffect(StatusEffects.UnlockedFoxTail7th)) GeneticMemoryStorage["Fox 7th Tail"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedFoxTail7th);
				if (player.hasStatusEffect(StatusEffects.UnlockedFoxTail8th)) GeneticMemoryStorage["Fox 8th Tail"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedFoxTail8th);
				if (player.hasStatusEffect(StatusEffects.UnlockedFoxTail9th)) GeneticMemoryStorage["Fox 9th Tail"] = true;
				player.removeStatusEffect(StatusEffects.UnlockedFoxTail9th);
        if (player.hasStatusEffect(StatusEffects.UnlockedHoofedLegs)) GeneticMemoryStorage["Hoofed Lower Body"] = true;
        player.removeStatusEffect(StatusEffects.UnlockedHoofedLegs);
        if (player.hasStatusEffect(StatusEffects.UnlockedSnakeLowerBody)) GeneticMemoryStorage["Snake Lower Body"] = true;
        player.removeStatusEffect(StatusEffects.UnlockedSnakeLowerBody);
        if (player.hasStatusEffect(StatusEffects.UnlockedDemonHighHeels)) GeneticMemoryStorage["Demon High Heels Lower Body"] = true;
        player.removeStatusEffect(StatusEffects.UnlockedDemonHighHeels);
        if (player.hasStatusEffect(StatusEffects.UnlockedDemonClawedLegs)) GeneticMemoryStorage["Demon Clawed Lower Body"] = true;
        player.removeStatusEffect(StatusEffects.UnlockedDemonClawedLegs);
        if (player.hasStatusEffect(StatusEffects.UnlockedBeeLegs)) GeneticMemoryStorage["Bee Lower Body"] = true;
        player.removeStatusEffect(StatusEffects.UnlockedBeeLegs);
        if (player.hasStatusEffect(StatusEffects.UnlockedCatLegs)) GeneticMemoryStorage["Cat Lower Body"] = true;
        player.removeStatusEffect(StatusEffects.UnlockedCatLegs);
        if (player.hasStatusEffect(StatusEffects.UnlockedLizardLegs)) GeneticMemoryStorage["Lizard Lower Body"] = true;
        player.removeStatusEffect(StatusEffects.UnlockedLizardLegs);
        if (player.hasStatusEffect(StatusEffects.UnlockedHarpyLegs)) GeneticMemoryStorage["Harpy Lower Body"] = true;
        player.removeStatusEffect(StatusEffects.UnlockedHarpyLegs);
        if (player.hasStatusEffect(StatusEffects.UnlockedSpiderLegs)) GeneticMemoryStorage["Spider Lower Body"] = true;
        player.removeStatusEffect(StatusEffects.UnlockedSpiderLegs);
        if (player.hasStatusEffect(StatusEffects.UnlockedDriderLegs)) GeneticMemoryStorage["Drider Lower Body"] = true;
        player.removeStatusEffect(StatusEffects.UnlockedDriderLegs);
        if (player.hasStatusEffect(StatusEffects.UnlockedFoxLowerBody)) GeneticMemoryStorage["Fox Lower Body"] = true;
        player.removeStatusEffect(StatusEffects.UnlockedFoxLowerBody);
        if (player.hasStatusEffect(StatusEffects.UnlockedDraconicLegs)) GeneticMemoryStorage["Draconic Lower Body"] = true;
        player.removeStatusEffect(StatusEffects.UnlockedDraconicLegs);
        if (player.hasStatusEffect(StatusEffects.UnlockedClovenHoofedLegs)) GeneticMemoryStorage["Cloven Hoofed Lower Body"] = true;
        player.removeStatusEffect(StatusEffects.UnlockedClovenHoofedLegs);
        if (player.hasStatusEffect(StatusEffects.UnlockedSalamanderLegs)) GeneticMemoryStorage["Salamander Lower Body"] = true;
        player.removeStatusEffect(StatusEffects.UnlockedSalamanderLegs);
        if (player.hasStatusEffect(StatusEffects.UnlockedMantisLegs)) GeneticMemoryStorage["Mantis Lower Body"] = true;
        player.removeStatusEffect(StatusEffects.UnlockedMantisLegs);
        if (player.hasStatusEffect(StatusEffects.UnlockedSharkLegs)) GeneticMemoryStorage["Shark Lower Body"] = true;
        player.removeStatusEffect(StatusEffects.UnlockedSharkLegs);
        if (player.hasStatusEffect(StatusEffects.UnlockedLionLegs)) GeneticMemoryStorage["Lion Lower Body"] = true;
        player.removeStatusEffect(StatusEffects.UnlockedLionLegs);
        if (player.hasStatusEffect(StatusEffects.UnlockedOrcaLegs)) GeneticMemoryStorage["Orca Lower Body"] = true;
        player.removeStatusEffect(StatusEffects.UnlockedOrcaLegs);
        if (player.hasStatusEffect(StatusEffects.UnlockedOniLegs)) GeneticMemoryStorage["Oni Lower Body"] = true;
        player.removeStatusEffect(StatusEffects.UnlockedOniLegs);
        if (player.hasStatusEffect(StatusEffects.UnlockedElfLegs)) GeneticMemoryStorage["Elf Lower Body"] = true;
        player.removeStatusEffect(StatusEffects.UnlockedElfLegs);
        if (player.hasStatusEffect(StatusEffects.UnlockedRaijuLegs)) GeneticMemoryStorage["Raiju Lower Body"] = true;
        player.removeStatusEffect(StatusEffects.UnlockedRaijuLegs);
        if (player.hasStatusEffect(StatusEffects.UnlockedRedPandaLegs)) GeneticMemoryStorage["Red Panda Lower Body"] = true;
        player.removeStatusEffect(StatusEffects.UnlockedRedPandaLegs);
        if (player.hasStatusEffect(StatusEffects.UnlockedOrcLegs)) GeneticMemoryStorage["Orc Lower Body"] = true;
        player.removeStatusEffect(StatusEffects.UnlockedOrcLegs);
				/*
			*/

			// Previous code didn't unlock more than 2 tails for Enlightened Kitsunes, migration fix
			/*
				*/
				if (player.hasPerk(PerkLib.NinetailsKitsuneOfBalance)) {
					GeneticMemoryStorage["Fox 7th Tail"] = true;
					GeneticMemoryStorage["Fox 8th Tail"] = true;
					GeneticMemoryStorage["Fox 9th Tail"] = true;
				}
				if (player.hasPerk(PerkLib.EnlightenedKitsune) || player.hasPerk(PerkLib.CorruptedKitsune)) {
					GeneticMemoryStorage["Fox Tail"] = true;
					GeneticMemoryStorage["Fox 2nd Tail"] = true;
					GeneticMemoryStorage["Fox 3rd Tail"] = true;
					GeneticMemoryStorage["Fox 4th Tail"] = true;
					GeneticMemoryStorage["Fox 5th Tail"] = true;
					GeneticMemoryStorage["Fox 6th Tail"] = true;
				}
				//noinspection FallThroughInSwitchStatementJS
				if (player.tailType == Tail.FOX && player.tailCount < 7) {
					switch (player.tailCount) {
						case 6:
							GeneticMemoryStorage["Fox 6th Tail"] = true;
						case 5:
							GeneticMemoryStorage["Fox 5th Tail"] = true;
						case 4:
							GeneticMemoryStorage["Fox 4th Tail"] = true;
						case 3:
							GeneticMemoryStorage["Fox 3rd Tail"] = true;
						case 2:
							GeneticMemoryStorage["Fox 2nd Tail"] = true;
						case 1:
							GeneticMemoryStorage["Fox Tail"] = true;
					}
				}
				/*
			*/
		}

		public static function update(): void {
			TriggerUpdate = false;
			convertUnlockMetamorphFlags();
			if (refundAscMetamorph()) {
				CoC.instance.charCreation.updateAscension("<b>The way Metamorph saves TFs has been completely changed, and so all Perks related to it, with the exception of Natural Metamorph, have been taken away from the player and refunded to ensure a safer transition. Feel free to spend your points to reobtain them, and perhaps buy something else as well, before returning to your game.</b>\n\n");
			}
		}

		public function Metamorph() {
			Saves.registerSaveableState(this);
		}

		public static function resetMetamorph(): void {
			GeneticMemoryStorage = {};
			// Generic value for TFs unlocked from the beginning
			GeneticMemoryStorage["Unlocked Metamorph"] = true;
			for (var id:String in PermanentMemoryStorage) {
				GeneticMemoryStorage[id] = true;
			}
		}

		public static function registerPermanentMetamorphs(): void {
			for (var id:String in PermanentMemoryStorage) {
				if (!GeneticMemoryStorage[id]) GeneticMemoryStorage[id] = true;
			}
		}

		// Controls the main Metamorph menu's page without having to carry the value through functions
		public var mainMetamorphMenuPage: int = 0;

		// Resets the main Metamorph menu's page when accessing Metamorph
		public function openMetamorph(): void {
			mainMetamorphMenuPage = 0;
			accessMetamorphMenu();
		}

		public function accessMetamorphMenu(currentPage: int = -1):void {
			if (currentPage < 0) {
				currentPage = mainMetamorphMenuPage;
			}	else {
				mainMetamorphMenuPage = currentPage;
			}

			clearOutput();
			statScreenRefresh();
			var BtMS:Number = (50 * (1 + player.perkv1(PerkLib.Metamorph)));
			if (player.hasPerk(PerkLib.MetamorphEx)) BtMS += (100 * player.perkv1(PerkLib.MetamorphEx));
			//if (player.hasPerk(PerkLib.MetamorphMastery)) BtMS += (100 * player.perkv1(PerkLib.MetamorphMastery));
			outputText("<font size=\"36\" face=\"Georgia\"><u>Soulforce Metamorph</u></font>\n");
			outputText("You calm your thoughts and take a moment to center yourself, recalling your past experiences. The transformations you have experienced so far have left their mark, not so easily forgotten even when undone and replaced innumerable times. When you focus, you can feel the threads in place, echoes of the many bodies you called your own, of limbs you once owned and skins you wore as comfortably as your current one.\n\nWith a little effort, you could imprint some of those recollections upon yourself. Powerful wings which carried you above the clouds, attentive ears which alerted you of danger; any such memories could return to you just as easily as they left, still rightfully yours.\n\nAs such, is there anything you would like to change about your current form?");
			outputText("\n\n<b>Race added to Metamorph:\n");
			outputText("Alicorn, Alruane, Bat, Bee, Bicorn, Boar, Cat, Cave Wyrm, Cheshire Cat, Cow, Couatl, Cyclop, Demon, Devil, Displacer Beast, Dragon, Elf, Fox, Frost Wyrm, Gazer, Gorgon, Harpy, Hellcat, Hinezumi, Horse, Human, Kitsune, Lizard, Manticore, Mantis, Minotaur, Mouse, Naga, Nekomata, Nightmare, Oni, Orc, Orca, Phoenix, Pig, Raccoon, Raiju, Red Panda, Salamander, Shark, Sphinx, Spider (+Drider), Unicorn, Vampire, Winter Wolf</b>");
			outputText("\n\n<b>Bonus to Max Soulforce:</b> " + BtMS);

			menu();

			const menusList: Array = [
				{
					name: "Hair",
					func: accessHairMenu
				},
				{
					name: "Face",
					func: accessFaceMenu
				},
				{
					name: "Eyes",
					func: accessEyesMenu
				},
				{
					name: "Tongue",
					func: accessTongueMenu
				},
				{
					name: "Ears",
					func: accessEarsMenu
				},
				{
					name: "Arms",
					func: accessArmsMenu
				},
				{
					name: "Lower Body",
					func: accessLowerBodyMenu
				},
				{
					name: "Rear Body",
					func: accessRearBodyMenu
				},
				{
					name: "Skin",
					func: accessSkinMenu
				},
				{
					name: "Patterns",
					func: accessSkinPatternsMenu
				},
				{
					name: "Antennae",
					func: accessAntennaeMenu
				},
				{
					name: "Horns",
					func: accessHornsMenu
				},
				{
					name: "Gills",
					func: accessGillsMenu
				},
				{
					name: "Wings",
					func: accessWingsMenu
				},
				{
					name: "Tail",
					func: accessTailMenu
				},
			];

			if (player.hasPerk(PerkLib.MetamorphEx)) {
				menusList.push({
						name: "Breasts",
						func: accessBreastsMenu
					});
				menusList.push({
						name: "Vagina",
						func: accessVaginasMenu
					});
				menusList.push({
						name: "Penis",
						func: accessCocksMenu
					});
				menusList.push({
						name: "Balls",
						func: accessBallsMenu
					});
				menusList.push({
							name: "Special",
							func: accessSexSpecialMenu
					});
			}
			

//			if (player.hasPerk(PerkLib.MetamorphMastery)) {
//				menusList.push({
//					name: "Complete",
//					func: accessCompleteMenu
//				});
//			}

			const menusPerPage: int = menusList.length > 14 ? 12 : 14;

			const lastPage: int = Math.ceil(menusList.length/menusPerPage) - 1;

			const pageMenus: Array = menusList.slice(currentPage * menusPerPage, (currentPage * menusPerPage) + menusPerPage);

			var currentButton: int = 0;

			for each (var menuObj: * in pageMenus) {
				if (menuObj.hint) {
					addButton(currentButton, menuObj.name, menuObj.func).hint(menuObj.hint);
				} else {
					addButton(currentButton, menuObj.name, menuObj.func);
				}
				currentButton++;
			}

			if (lastPage > 0) {
				if (currentPage > 0) addButton(12, "Prev Page", accessMetamorphMenu, currentPage - 1);
				else addButtonDisabled (12, "Prev Page");
				if (currentPage < lastPage) addButton(13, "Next Page", accessMetamorphMenu, currentPage + 1);
				else addButtonDisabled (13, "Next Page");
			}

			if (player.hasPerk(PerkLib.JobSoulCultivator)) addButton(14, "Back", SceneLib.soulforce.accessSoulforceMenu);
			else addButton(14, "Back", playerMenu);
		}

		private function accessCompleteMenu(currentPage: int = 0): void {
			const title: String = "<font size=\"36\" face=\"Georgia\"><u>Soulforce Metamorph - Full Body</u></font>\n";

			clearOutput();
			outputText(title);

			outputText("[pg]Don't feel like yourself? Perhaps you'd like to revert to a single race?");

			openPaginatedMenu(title, accessCompleteMenu, currentPage, RaceMem.Memories.sortOn("id"));
		}


		private function accessHornsMenu(currentPage: int = 0): void {
			const title: String = "<font size=\"36\" face=\"Georgia\"><u>Soulforce Metamorph - Horns</u></font>\n";

			clearOutput();
			outputText(title);

			const hornsDesc: String = Horns.getAppearanceDescription(player);
			outputText(hornsDesc ?  hornsDesc : "You have no horns.");
			outputText("[pg]Perhaps you'd like to change this?");

			openPaginatedMenu(title, accessHornsMenu, currentPage, HornsMem.Memories);
		}

		private function accessHairMenu(currentPage: int = 0): void {
			const title: String = "<font size=\"36\" face=\"Georgia\"><u>Soulforce Metamorph - Hair</u></font>\n";

			clearOutput();
			outputText(title);

			outputText(Hair.getAppearanceDescription(player) + "[pg]Perhaps you'd like to change this?");

			openPaginatedMenu(title, accessLowerBodyMenu, currentPage, HairMem.Memories);
		}

		private function accessFaceMenu(currentPage: int = 0): void {
			const title: String = "<font size=\"36\" face=\"Georgia\"><u>Soulforce Metamorph - Face</u></font>\n";

			clearOutput();
			outputText(title);

			outputText(Face.getAppearanceDescription(player) + "[pg]Perhaps you'd like to change this?");

			openPaginatedMenu(title, accessFaceMenu, currentPage, FaceMem.Memories);
		}

		private function accessEyesMenu(currentPage: int = 0): void {
			const title: String = "<font size=\"36\" face=\"Georgia\"><u>Soulforce Metamorph - Eyes</u></font>\n";

			clearOutput();
			outputText(title);

			outputText(Eyes.getAppearanceDescription(player) + "[pg]Perhaps you'd like to change this?");

			openPaginatedMenu(title, accessEyesMenu, currentPage, EyesMem.Memories);
		}

		private function accessTongueMenu(currentPage: int = 0): void {
			const title: String = "<font size=\"36\" face=\"Georgia\"><u>Soulforce Metamorph - Tongue</u></font>\n";

			clearOutput();
			outputText(title);

			outputText(Tongue.getAppearanceDescription(player) + "[pg]Perhaps you'd like to change this?");

			openPaginatedMenu(title, accessTongueMenu, currentPage, TongueMem.Memories);
		}

		private function accessEarsMenu(currentPage: int = 0): void {
			const title: String = "<font size=\"36\" face=\"Georgia\"><u>Soulforce Metamorph - Ears</u></font>\n";

			clearOutput();
			outputText(title);

			outputText(Ears.getAppearanceDescription(player) + "[pg]Perhaps you'd like to change this?");

			openPaginatedMenu(title, accessEarsMenu, currentPage, EarsMem.Memories);
		}

		private function accessArmsMenu(currentPage: int = 0): void {
			const title: String = "<font size=\"36\" face=\"Georgia\"><u>Soulforce Metamorph - Arms</u></font>\n";

			clearOutput();
			outputText(title);

			outputText(Arms.getAppearanceDescription(player) + "[pg]Perhaps you'd like to change this?");

			openPaginatedMenu(title, accessArmsMenu, currentPage, ArmsMem.Memories);
		}

		private function accessWingsMenu(currentPage: int = 0): void {
			const title: String = "<font size=\"36\" face=\"Georgia\"><u>Soulforce Metamorph - Wings</u></font>\n";

			clearOutput();
			outputText(title);

			const wingsDesc: String = Wings.getAppearanceDescription(player);
			outputText(wingsDesc ?  wingsDesc : "You have no wings.");
			outputText("[pg]Perhaps you'd like to change this?");

			openPaginatedMenu(title, accessWingsMenu, currentPage, WingsMem.Memories);
		}

		private function accessLowerBodyMenu(currentPage: int = 0): void {
			const title: String = "<font size=\"36\" face=\"Georgia\"><u>Soulforce Metamorph - Lower Body</u></font>\n";

			clearOutput();
			outputText(title);

			outputText(LowerBody.getAppearanceDescription(player) + "[pg]Perhaps you'd like to change this?");

			openPaginatedMenu(title, accessLowerBodyMenu, currentPage, LowerBodyMem.Memories);
		}

		private function accessSkinMenu(currentPage: int = 0): void {
			const title: String = "<font size=\"36\" face=\"Georgia\"><u>Soulforce Metamorph - Skin</u></font>\n";

			clearOutput();
			outputText(title);

			outputText(Skin.getSkinAppearanceDescription(player) + "[pg]Perhaps you'd like to change this?");

			openPaginatedSkinMenu(title, currentPage);
		}

		private function accessRearBodyMenu(currentPage: int = 0): void {
			const title: String = "<font size=\"36\" face=\"Georgia\"><u>Soulforce Metamorph - Rear Body</u></font>\n";

			clearOutput();
			outputText(title);

			const rearBodyDesc: String = RearBody.getAppearanceDescription(player);
			outputText(rearBodyDesc ?  rearBodyDesc : "You have no rear body.");
			outputText("[pg]Perhaps you'd like to change this?");

			openPaginatedMenu(title, accessRearBodyMenu, currentPage, RearBodyMem.Memories);
		}

		private function accessAntennaeMenu(currentPage: int = 0): void {
			const title: String = "<font size=\"36\" face=\"Georgia\"><u>Soulforce Metamorph - Antennae</u></font>\n";

			clearOutput();
			outputText(title);

			const antennaeDesc: String = Antennae.getAppearanceDescription(player);
			outputText(antennaeDesc ?  antennaeDesc : "You have no antennae.");
			outputText("[pg]Perhaps you'd like to change this?");

			openPaginatedMenu(title, accessAntennaeMenu, currentPage, AntennaeMem.Memories);
		}

		private function accessSkinPatternsMenu(currentPage: int = 0): void {
			const title: String = "<font size=\"36\" face=\"Georgia\"><u>Soulforce Metamorph - Skin Patterns</u></font>\n";

			clearOutput();
			outputText(title);

			const skinPatternDesc: String = Skin.getSkinPatternAppearanceDescription(player);
			outputText(skinPatternDesc ?  skinPatternDesc : "You have no skin pattern.");
			outputText("[pg]Perhaps you'd like to change this?");

			openPaginatedMenu(title, accessSkinPatternsMenu, currentPage, SkinPatternMem.Memories);
		}

		private function accessGillsMenu(currentPage: int = 0): void {
			const title: String = "<font size=\"36\" face=\"Georgia\"><u>Soulforce Metamorph - Gills</u></font>\n";

			clearOutput();
			outputText(title);

			const gillsDesc: String = Gills.getAppearanceDescription(player);
			outputText(gillsDesc ?  gillsDesc + "[pg]Perhaps you'd like to change this?" : "You have no gills. Perhaps you'd like to grow some?");

			openPaginatedMenu(title, accessGillsMenu, currentPage, GillsMem.Memories);
		}

		private function accessTailMenu(currentPage: int = 0): void {
			const title: String = "<font size=\"36\" face=\"Georgia\"><u>Soulforce Metamorph - Tail</u></font>\n";

			clearOutput();
			outputText(title);

			const tailDesc: String = Tail.getAppearanceDescription(player);
			outputText(tailDesc ?  tailDesc : "You have no tail.");
			outputText("[pg]Perhaps you'd like to change this?");

			openPaginatedMenu(title, accessTailMenu, currentPage, TailMem.Memories);
		}

		private function accessBreastsMenu(currentPage: int = 0): void {
			const title: String = "<font size=\"36\" face=\"Georgia\"><u>Soulforce Metamorph - Breasts</u></font>\n";

			clearOutput();
			outputText(title);

			const breastsDesc: String = CoC.instance.playerAppearance.describeBreasts();
			outputText(player.hasBreasts() ?  breastsDesc : "You have no Breasts.");
			outputText("[pg]Perhaps you'd like to change this?");

			addButton(14, "Back", accessMetamorphMenu);
			openPaginatedMenu(title, accessBreastsMenu, currentPage, BreastMem.Memories);
		}

		private function accessCocksMenu(currentPage: int = 0): void {
			const title: String = "<font size=\"36\" face=\"Georgia\"><u>Soulforce Metamorph - Cocks</u></font>\n";

			clearOutput();
			outputText(title);

			const cocksDesc: String = CoC.instance.playerAppearance.describeCocks();
			outputText(player.hasCock() ?  cocksDesc : "You have no cock.");
			outputText("[pg]Perhaps you'd like to change this?");

			var totCock: int = player.cockTotal();
			if (totCock == 0 && GeneticMemoryStorage[CockCountMem.Memories[0].id]) {
				openPaginatedMenu(title, accessCockMenu, currentPage, CockMem.Memories, 0);
			} else {
				menu();

				for (var i: int = 0; i  < totCock; i++) {
					addButton(i, "Cock "+(i+1), accessCockMenu, 0, i).hint( player.cockDescript(i));
				}
				if (totCock < 10) {
					const cockUnlocked:Boolean = GeneticMemoryStorage[CockCountMem.Memories[totCock].id] && true;
					addButtonIfTrue(totCock, "New Cock", curry(accessCockMenu, 0, totCock), "You need to get a cock first", cockUnlocked, "Add a cock");
				}

				addButton(14, "Back", accessMetamorphMenu);
			}
		}

		private function accessCockMenu(currentPage: int = 0, cock: int = 0): void {
			const title: String = "<font size=\"36\" face=\"Georgia\"><u>Soulforce Metamorph - Cock</u></font>\n";
			clearOutput();
			outputText(title);

			const cockDesc: String = (cock == player.cockTotal()? "Add a new cock":CoC.instance.playerAppearance.describeCock(cock));
			outputText(cockDesc);
			outputText("[pg]Perhaps you'd like to change this?");

			openPaginatedMenu(title, accessCockMenu, currentPage, CockMem.Memories, cock);
		}

		private function accessBallsMenu(currentPage: int = 0): void {
			const title: String = "<font size=\"36\" face=\"Georgia\"><u>Soulforce Metamorph - Balls</u></font>\n";

			clearOutput();
			outputText(title);

			const ballsDesc: String = CoC.instance.playerAppearance.describeBalls();
			outputText(player.hasBalls() ?  ballsDesc : "You have no balls.");
			outputText("[pg]Perhaps you'd like to change this?");

			openPaginatedMenu(title, accessBallsMenu, currentPage, BallsMem.Memories);
		}

		private function accessSexSpecialMenu(currentPage: int = 0): void {
			const title: String = "<font size=\"36\" face=\"Georgia\"><u>Soulforce Metamorph - Genitals Special</u></font>\n";

			clearOutput();
			outputText(title);

			const desc: String = "Ovipositors and other stuff";
			outputText(desc ?  desc : "You have no specials.");

			openPaginatedMenu(title, accessSexSpecialMenu, currentPage, SpecialsMem.Memories);
		}

		private function accessVaginasMenu(currentPage: int = 0): void {
			const title: String = "<font size=\"36\" face=\"Georgia\"><u>Soulforce Metamorph - Vagina</u></font>\n";

			clearOutput();
			outputText(title);
			outputText(player.hasVagina() ?  CoC.instance.playerAppearance.describePussies() : "You have no vagina.");
			outputText("[pg]Perhaps you'd like to change this?");

			var totVag:int = player.vaginas.length;
			if ((totVag == 0 && GeneticMemoryStorage[VaginaCountMem.Memories[0].id]) ||
				(totVag == 1 && !GeneticMemoryStorage[VaginaCountMem.Memories[1].id])) {
				openPaginatedMenu(title, accessVaginaMenu, currentPage, VaginaMem.Memories, 0);
			} else if (totVag > 1 || GeneticMemoryStorage[VaginaCountMem.Memories[1].id]) {
				menu();

				for (var i: int = 0; i  < totVag; i++) {
					addButton(i, "Vagina "+(i+1), accessVaginaMenu, 0, i).hint( player.vaginaDescript(i));
				}
				const vaginaUnlocked:Boolean = GeneticMemoryStorage[VaginaCountMem.Memories[totVag].id] && true;
				addButtonIfTrue(totVag, "New Vagina", curry(accessVaginaMenu, 0, totVag), "You need to get a vagina first", vaginaUnlocked, "Add a vagina");

				addButton(14, "Back", accessMetamorphMenu);
			}
			else {
				clearOutput();
				outputText(title);
				outputText("You need to unlock a vagina first!");
				addButton(14, "Back", accessMetamorphMenu);
			}
		}

		private function accessVaginaMenu(currentPage: int = 0, vagina: int = 0): void {
			const title: String = "<font size=\"36\" face=\"Georgia\"><u>Soulforce Metamorph - Vagina</u></font>\n";

			clearOutput();
			outputText(title);

			const vaginaDesc: String = CoC.instance.playerAppearance.describePussy(0);
			outputText(player.hasVagina() ?  vaginaDesc : "You have no vagina.");
			outputText("[pg]Perhaps you'd like to change this?");

			openPaginatedMenu(title, accessVaginaMenu, currentPage, VaginaMem.Memories, 0);
		}

		private function openPaginatedMenu (title: String, thisMenu: *, currentPage: int, memArray:Array, index:int = -9000): void {
			menu();


			memArray = memArray.filter(function(element: *, index: int, array: Array): Boolean {
				if (element && element.id !== "Taur Lower Body") {
					return true;
				}
				return false;
			});

			const memsPerPage: int = memArray.length > 14 ? 12 : 14;

			const lastPage: int = Math.ceil(memArray.length/memsPerPage) - 1;

			const pageMems: Array = memArray.slice(currentPage * memsPerPage, (currentPage * memsPerPage) + memsPerPage);

			var currentButton: int = 0;

			for each (var genMem: * in pageMems) {
				const buttonStr: String = genMem.title || "";
				const unlocked: Boolean = GeneticMemoryStorage[genMem.id] && (genMem.taurVariant ? GeneticMemoryStorage["Taur Lower Body"] : true);
				const partsInUse: Boolean = (index==-1? genMem.transformation().isPresent() : genMem.transformation(index).isPresent());
				const cost:Number=(genMem.cost is Function? genMem.cost() : genMem.cost);
				const enoughSF: Boolean = player.soulforce >= cost;

				if (unlocked && !partsInUse && enoughSF) addButton(currentButton++, buttonStr, doMetamorph, title, genMem, index).hint("Cost: " + cost + " SF" + (genMem.info ? "\n\n" + genMem.info : ""));
				else if (unlocked && partsInUse) addButtonDisabled(currentButton++, buttonStr, (!genMem.hint? "You already have this, the metamorphosis would have no effect!":genMem.hint));
				else if (unlocked && !partsInUse && !enoughSF) addButtonDisabled(currentButton++, buttonStr, "Cost: " + cost + " SF (You don't have enough Soulforce for this metamorphosis!)");
				else if (!unlocked)	addButtonDisabled(currentButton++, buttonStr, "You haven't unlocked this metamorphosis yet!" + (genMem.lockedInfo ? "\n\n" + genMem.lockedInfo : ""));
			}

			if (lastPage > 0) {
				if (currentPage > 0) addButton(12, "Prev Page", thisMenu, currentPage - 1, index);
				else addButtonDisabled (12, "Prev Page");
				if (currentPage < lastPage) addButton(13, "Next Page", thisMenu, currentPage + 1, index);
				else addButtonDisabled (13, "Next Page");
			}

			addButton(14, "Back", accessMetamorphMenu);
		}

		public static function checkTaurUnlock():Boolean{
			return GeneticMemoryStorage["Taur Lower Body"] ? true : false;
		}
		
		private function doMetamorph (title: String, genMem: *, index:int = -1): void {
			clearOutput();
			outputText(title);
			if (index != -1)
				genMem.transformation(index).applyEffect();
			else
				genMem.transformation().applyEffect();
			player.soulforce -= (genMem.cost is Function? genMem.cost() : genMem.cost);
			CoC.instance.mainViewManager.updateCharviewIfNeeded();
			doNext(accessMetamorphMenu);
		}

		private function openPaginatedSkinMenu (title: String, currentPage: int): void {
			menu();

			var memArray: Array = SkinMem.Memories;

			memArray = memArray.filter(function(element: *, index: int, array: Array): Boolean {
				return !!element;
			});

			const memsPerPage: int = memArray.length > 14 ? 12 : 14;

			const lastPage: int = Math.ceil(memArray.length/memsPerPage) - 1;

			const pageMems: Array = memArray.slice(currentPage * memsPerPage, (currentPage * memsPerPage) + memsPerPage);

			var currentButton: int = 0;

			for each (var genMem: * in pageMems) {
				const buttonStr: String = genMem.title || "";
				const unlocked: Boolean = GeneticMemoryStorage[genMem.id];
				const enoughSF: Boolean = player.soulforce >= genMem.cost;

				if (!genMem.transformationCoverage) {
					const partsInUse: Boolean = genMem.transformation().isPresent();
					if (unlocked && !partsInUse && enoughSF) addButton(currentButton, buttonStr, doMetamorph, title, genMem).hint("Cost: " + genMem.cost + " SF" + (genMem.info ? "\n\n" + genMem.info : ""));
					else if (unlocked && partsInUse) addButtonDisabled(currentButton, buttonStr, "You already have this, the metamorphosis would have no effect!");
					else if (unlocked && !partsInUse && !enoughSF) addButtonDisabled(currentButton, buttonStr, "Cost: " + genMem.cost + " SF (You don't have enough Soulforce for this metamorphosis!)");
					else if (!unlocked) addButtonDisabled(currentButton, buttonStr, "You haven't unlocked this metamorphosis yet!" + (genMem.lockedInfo ? "\n\n" + genMem.lockedInfo : ""));
					currentButton++;
				} else {
					if (unlocked) addButton(currentButton, buttonStr, openCoverageMenu, genMem);
					else if (!unlocked) addButtonDisabled(currentButton, buttonStr, "You haven't unlocked this metamorphosis yet!" + (genMem.lockedInfo ? "\n\n" + genMem.lockedInfo : ""));
					currentButton++;
				}
			}

			if (lastPage > 0) {
				if (currentPage > 0) addButton(12, "Prev Page", accessSkinMenu, currentPage - 1);
				else addButtonDisabled (12, "Prev Page");
				if (currentPage < lastPage) addButton(13, "Next Page", accessSkinMenu, currentPage + 1);
				else addButtonDisabled (13, "Next Page");
			}

			addButton(14, "Back", accessMetamorphMenu);
		}

		private function openCoverageMenu(genMem: *): void {
			clearOutput();
			menu();
			outputText("<font size=\"36\" face=\"Georgia\"><u>Soulforce Metamorph - " + genMem.id.split(" Skin")[0] + " Coverage</u></font>\n");
			outputText("How much do you want your skin to be covered?");

			const coverages: Array = [
				{
					name: "Low",
					value: Skin.COVERAGE_LOW
				},
				{
					name: "Medium",
					value: Skin.COVERAGE_MEDIUM
				},
				{
					name: "High",
					value: Skin.COVERAGE_HIGH
				},
				{
					name: "Complete",
					value: Skin.COVERAGE_COMPLETE
				}
			];

			var currentButton: int = 0;

			for each (var coverage: Object in coverages) {
				if (InCollection(coverage.value, genMem.availableCoverages)) {
					const cost: int = genMem.cost * (coverages.indexOf(coverage) + 1);
					const enoughSF: Boolean = player.soulforce >= cost;
					const inEffect: Boolean = genMem.transformationCoverage(coverage.value).isPresent();

					if (enoughSF && !inEffect) addButton(currentButton, coverage.name, doMetamorphSkin, genMem, coverage.value, cost).hint("Cost: " + cost + " SF");
					else if (inEffect) addButtonDisabled(currentButton, coverage.name, "You already have this much coverage, the metamorphosis would have no effect!");
					else addButtonDisabled(currentButton, coverage.name, "Cost: " + cost + " SF (You don't have enough Soulforce for this coverage!)");
					currentButton++;
				}
			}

			addButton(14, "Back", accessSkinMenu);
		}

		private function doMetamorphSkin (genMem: *, coverage: int, cost: int): void {
			clearOutput();
			outputText("<font size=\"36\" face=\"Georgia\"><u>Soulforce Metamorph - " + genMem.id.split(" Skin")[0] + "</u></font>\n");

			genMem.transformationCoverage(coverage).applyEffect();
			player.soulforce -= cost;
			CoC.instance.mainViewManager.updateCharviewIfNeeded();
			doNext(accessMetamorphMenu);
		}

		private function accessPageEx1MetamorphMenu():void {
			menu();
			if (player.soulforce >= 300) addButton(0, "Height +1", metamorphHeight1U);
			else addButtonDisabled(0, "Height +1", "You do not have enough Soulforce for this metamorphosis.");
			if (player.soulforce >= 700) addButton(1, "Height +2", metamorphHeight2U);
			else addButtonDisabled(1, "Height +2", "You do not have enough Soulforce for this metamorphosis.");
			if (player.soulforce >= 100) addButton(2, "Height -1", metamorphHeight1D);
			else addButtonDisabled(2, "Height -1", "You do not have enough Soulforce for this metamorphosis.");
			if (player.soulforce >= 300) addButton(3, "Height -2", metamorphHeight2D);
			else addButtonDisabled(3, "Height -2", "You do not have enough Soulforce for this metamorphosis.");
			if (player.soulforce >= 300) addButton(4, "Hair +1", metamorphHair1U);
			else addButtonDisabled(4, "Hair +1", "You do not have enough Soulforce for this metamorphosis.");
			if (player.soulforce >= 100) addButton(9, "Hair -1", metamorphHair1D);
			else addButtonDisabled(9, "Hair -1", "You do not have enough Soulforce for this metamorphosis.");
			addButton(14, "Back", accessMetamorphMenu);
		}
		private function accessPageEx2MetamorphMenu():void {
			menu();
			addButton(0, "Back", accessMetamorphMenu);
			addButton(1, "Back", accessMetamorphMenu);
			addButton(2, "Back", accessMetamorphMenu);
			addButton(3, "Back", accessMetamorphMenu);
			addButton(4, "Back", accessMetamorphMenu);
			addButton(5, "Back", accessMetamorphMenu);
			addButton(6, "Back", accessMetamorphMenu);
			addButton(7, "Back", accessMetamorphMenu);
			addButton(8, "Back", accessMetamorphMenu);
			addButton(9, "Back", accessMetamorphMenu);
			addButton(10, "Back", accessMetamorphMenu);
			addButton(11, "Back", accessMetamorphMenu);
			addButton(12, "Back", accessMetamorphMenu);
			addButton(13, "Back", accessMetamorphMenu);
			addButton(14, "Back", accessMetamorphMenu);
		}
		private function accessPageEx3MetamorphMenu():void {
			menu();
			addButton(0, "Skin", accessMetamorphMenu);
			addButton(1, "Hair", accessMetamorphMenu);
			addButton(2, "Fur", accessMetamorphMenu);
			addButton(14, "Back", accessMetamorphMenu);
		}
		private function metamorphHeight1U():void {
			clearOutput();
			player.soulforce -= 300;
			outputText("\n\nWhoa wait did you just gain some height!? You indeed notice you've grown by an inch.");
			player.tallness += 1;
			if (player.basetallness >= 132) player.tallness = 132;
			doNext(accessPageEx1MetamorphMenu);
		}
		private function metamorphHeight2U():void {
			clearOutput();
			player.soulforce -= 700;
			outputText("\n\nWhoa wait did you just gain some height!? You indeed notice you've grown by two inches.");
			player.tallness += 2;
			if (player.basetallness >= 132) player.tallness = 132;
			doNext(accessPageEx1MetamorphMenu);
		}
		private function metamorphHeight1D():void {
			clearOutput();
			player.soulforce -= 100;
			outputText("\n\nWhoa wait did you just lost some height!? You indeed notice you've shrunk by an inch.");
			player.tallness -= 1;
			if (player.basetallness < 42) player.tallness = 42;
			doNext(accessPageEx1MetamorphMenu);
		}
		private function metamorphHeight2D():void {
			clearOutput();
			player.soulforce -= 300;
			outputText("\n\nWhoa wait did you just lost some height!? You indeed notice you've shrunk by two inches.");
			player.tallness -= 2;
			if (player.basetallness < 42) player.tallness = 42;
			doNext(accessPageEx1MetamorphMenu);
		}
		private function metamorphHair1U():void {
			clearOutput();
			player.soulforce -= 300;
			outputText("\n\nAs you focus, you feel more hair sprouting from your scalp. <b>Your hair is now about an inch longer.</b>");
			player.hairLength += 1;
			doNext(accessPageEx1MetamorphMenu);
		}
		private function metamorphHair2U():void {
			clearOutput();
			player.soulforce -= 300;
			outputText("\n\nAs you focus, you feel more hair sprouting from your scalp. <b>Your hair is now about two inches longer.</b>");
			player.hairLength += 2;
			doNext(accessPageEx1MetamorphMenu);
		}
		private function metamorphHair1D():void {
			clearOutput();
			player.soulforce -= 100;
			outputText("\n\nAs you focus, you feel it as your strands of hair are suddenly cut short at a specific length. <b>Your hair is now about one inch shorter.</b>");
			player.hairLength -= 1;
			if (player.hairLength < 0) player.hairLength = 0;
			doNext(accessPageEx1MetamorphMenu);
		}
		private function metamorphHair2D():void {
			clearOutput();
			player.soulforce -= 100;
			outputText("\n\nAs you focus, you feel it as your strands of hair are suddenly cut short at a specific length. <b>Your hair is now about two inches shorter.</b>");
			player.hairLength -= 2;
			if (player.hairLength < 0) player.hairLength = 0;
			doNext(accessPageEx1MetamorphMenu);
		}

		public static function unlockMetamorph (genMem: *): void {
			if (!GeneticMemoryStorage[genMem.id] && player.hasPerk(PerkLib.GeneticMemory)) {
				GeneticMemoryStorage[genMem.id] = true;
				if (player.hasPerk(PerkLib.Metamorph)) outputText("\n\n<b>Genetic Memory Obtained: " + (genMem.name || genMem.id) + "!</b>");
				if (genMem.unlockText) outputText("\n<b>" + genMem.unlockText +"</b>");
			}
		}

		public static function unlockMetamorphEx (genMem: *): void {
			if (!GeneticMemoryStorage[genMem.id] && player.hasPerk(PerkLib.GeneticMemory)) {
				GeneticMemoryStorage[genMem.id] = true;
				if (player.hasPerk(PerkLib.MetamorphEx)) outputText("\n\n<b>Genetic Memory Obtained: " + (genMem.name || genMem.id) + "!</b>");
				if (genMem.unlockText) outputText("\n<b>" + genMem.unlockText +"</b>");
			}
		}

//		public static function unlockMetamorphMastery (genMem: *): void {
//			if (!GeneticMemoryStorage[genMem.id] && player.hasPerk(PerkLib.GeneticMemory)) {
//				GeneticMemoryStorage[genMem.id] = true;
//				if (player.hasPerk(PerkLib.MetamorphMastery)) outputText("\n\n<b>Genetic Memory Obtained: " + (genMem.name || genMem.id) + "!</b>");
//				if (genMem.unlockText) outputText("\n<b>" + genMem.unlockText +"</b>");
//			}
//		}

		public static function permMetamorph (genMem: *): void {
			PermanentMemoryStorage[genMem.id] = true;
			player.ascensionPerkPoints -= genMem.permCost || 5;
		}
		
		public static function runMetamorph(arr:Array):void{	//TODO: Khovel - All the Functionality to do the TFs here
			switch(arr[0]) {// Antennae
				case "Ant": 		CoC.instance.transformations.AntennaeAnt.applyEffect(); 		break;
				case "Bee": 		CoC.instance.transformations.AntennaeBee.applyEffect(); 		break;
				case "Centipede": 	CoC.instance.transformations.AntennaeCentipede.applyEffect(); 	break;
				case "FireSnail": 	CoC.instance.transformations.AntennaeFireSnail.applyEffect(); 	break;
				case "Human": 		CoC.instance.transformations.AntennaeNone.applyEffect(); 		break;
				case "Jabberwocky": CoC.instance.transformations.AntennaeJabberwocky.applyEffect();	break;
				case "Mantis": 		CoC.instance.transformations.AntennaeMantis.applyEffect(); 		break;
				case "SeaDragon": 	CoC.instance.transformations.AntennaeFireSnail.applyEffect(); 	break;
				default: 			CoC.instance.transformations.AntennaeNone.applyEffect(); 		break;
			}
			switch(arr[1]) {// Arms					
				case "Ant": 		CoC.instance.transformations.ArmsAnt.applyEffect();			break;
				case "Atlach": 		CoC.instance.transformations.ArmsAtlach.applyEffect();		break;	
				case "Avian": 		CoC.instance.transformations.ArmsAvian.applyEffect();		break;	
				case "BatWing": 	CoC.instance.transformations.ArmsBatWing.applyEffect(); 	break;			
				case "Bear": 		CoC.instance.transformations.ArmsBear.applyEffect();		break;	
				case "Bee": 		CoC.instance.transformations.ArmsBee.applyEffect();			break;
				case "Boar": 		CoC.instance.transformations.ArmsBoar.applyEffect(); 		break;	
				case "Cat": 		CoC.instance.transformations.ArmsCat.applyEffect(); 		break;	
				case "CaveWyrm": 	CoC.instance.transformations.ArmsCaveWyrm.applyEffect();	break;			
				case "Centipede": 	CoC.instance.transformations.ArmsCentipede.applyEffect();	break;			
				case "Devil": 		CoC.instance.transformations.ArmsDevil.applyEffect();		break;	
				case "Displacer": 	CoC.instance.transformations.ArmsDisplacer.applyEffect(); 	break;			
				case "Dragon":      CoC.instance.transformations.ArmsDraconic.applyEffect();	break;
				case "Elf": 		CoC.instance.transformations.ArmsElf.applyEffect(); 		break;	
				case "Fox": 		CoC.instance.transformations.ArmsFox.applyEffect();			break;
				case "Frostwyrm": 	CoC.instance.transformations.ArmsFrostwyrm.applyEffect();	break;			
				case "Gazer": 		CoC.instance.transformations.ArmsGazer.applyEffect();		break;	
				case "Ghost": 		CoC.instance.transformations.ArmsGhost.applyEffect();		break;	
				case "Goo": 		CoC.instance.transformations.ArmsGoo.applyEffect();			break;
				case "Gryphon": 	CoC.instance.transformations.ArmsGryphon.applyEffect();		break;		
				case "Harpy": 		CoC.instance.transformations.ArmsHarpy.applyEffect();		break;	
				case "Hinezumi": 	CoC.instance.transformations.ArmsHinezumi.applyEffect();	break;			
				case "Human": 		CoC.instance.transformations.ArmsHuman.applyEffect(); 		break;	
				case "Hydra": 		CoC.instance.transformations.ArmsHydra.applyEffect();		break;	
				case "Jabberwocky": CoC.instance.transformations.ArmsJabberwocky.applyEffect();	break;				
				case "Jiangshi":    CoC.instance.transformations.ArmsJiangshi.applyEffect();	break;
				case "Kamaitachi": 	CoC.instance.transformations.ArmsKamaitachi.applyEffect();	break;
				case "Kitsune": 	CoC.instance.transformations.ArmsKitsune.applyEffect();		break;		
				case "Kraken": 		CoC.instance.transformations.ArmsKraken.applyEffect();		break;	
				case "Lion": 		CoC.instance.transformations.ArmsLion.applyEffect(); 		break;	
				case "Lizard": 		CoC.instance.transformations.ArmsLizard.applyEffect();		break;	
				case "Mantis": 		CoC.instance.transformations.ArmsMantis.applyEffect(); 		break;	
				case "Melkie": 		CoC.instance.transformations.ArmsMelkie.applyEffect();		break;	
				case "Oni": 		CoC.instance.transformations.ArmsOni.applyEffect(); 		break;	
				case "Orc": 		CoC.instance.transformations.ArmsOrc.applyEffect(); 		break;	
				case "Orca": 		CoC.instance.transformations.ArmsOrca.applyEffect();		break;	
				case "Phoenix": 	CoC.instance.transformations.ArmsPhoenix.applyEffect();		break;		
				case "Pig": 		CoC.instance.transformations.ArmsPig.applyEffect(); 		break;	
				case "Plant":		CoC.instance.transformations.ArmsPlant.applyEffect();		break;	
				case "Raccoon": 	CoC.instance.transformations.ArmsRaccoon.applyEffect();		break;		
				case "Raiju": 		CoC.instance.transformations.ArmsRaiju.applyEffect(); 		break;		
				case "RedPanda": 	CoC.instance.transformations.ArmsRedPanda.applyEffect(); 	break;			
				case "Salamander": 	CoC.instance.transformations.ArmsSalamander.applyEffect();	break;			
				case "SeaDragon": 	CoC.instance.transformations.ArmsSeaDragon.applyEffect();	break;			
				case "Shark": 		CoC.instance.transformations.ArmsShark.applyEffect();		break;	
				case "Sphinx": 		CoC.instance.transformations.ArmsSphinx.applyEffect(); 		break;	
				case "Spider": 		CoC.instance.transformations.ArmsSpider.applyEffect();		break;	
				case "Squirrel": 	CoC.instance.transformations.ArmsSquirrel.applyEffect();	break;			
				case "UshiOni": 	CoC.instance.transformations.ArmsUshiOni.applyEffect();		break;		
				case "Weasel": 		CoC.instance.transformations.ArmsWeasel.applyEffect();		break;	
				case "Wendigo": 	CoC.instance.transformations.ArmsWendigo.applyEffect();		break;		
				case "Wolf": 		CoC.instance.transformations.ArmsWolf.applyEffect();		break;	
				case "Yeti": 		CoC.instance.transformations.ArmsYeti.applyEffect();		break;	
				case "YukiOnna": 	CoC.instance.transformations.ArmsYukiOnna.applyEffect();	break;	
				default: 			CoC.instance.transformations.ArmsHuman.applyEffect();		break;
			}
			switch(arr[2]) {// Balls
				case "Human": 	if (player.hasBalls() && player.balls != 2) CoC.instance.transformations.BallsDuo.applyEffect();			break;
				case "Bunny":	// Shares similar requirement to Raccoon
				case "Raccoon": if (!player.hasBalls()) CoC.instance.transformations.BallsDuo.applyEffect();
								player.ballSize = 6;  																break;
				case "Trap":	if (!player.hasStatusEffect(StatusEffects.Uniball)) CoC.instance.transformations.BallsTrap.applyEffect(); 	break;
				case "Duo":		if (player.balls != 2) CoC.instance.transformations.BallsDuo.applyEffect();			break;
				case "None":	if (player.hasBalls()) CoC.instance.transformations.BallsNone.applyEffect();		break;
				default: 		if (player.hasBalls()) CoC.instance.transformations.BallsDuo.applyEffect();			break;
			}
			switch(arr[3]) {// Breasts
				case "Normal": 	if (player.hasBreasts() && player.bRows() > 1) CoC.instance.transformations.BreastRowsRemoveToOne.applyEffect();
								if (player.breastRows.length > 1) CoC.instance.transformations.BreastRowsRemoveToOne.applyEffect(); break;
				case "Bimbo": 	if (player.smallestTitSize() < 6) CoC.instance.transformations.BreastsGrowUpToDD.applyEffect(); break;
				case "Flat": 	if (player.hasBreasts()) CoC.instance.transformations.BreastsShrinkToNothing.applyEffect(); break;
				case "Row2":	if (player.bRows() != 2) CoC.instance.transformations.BreastRowsTwo.applyEffect(); break;
				case "Row3":	if (player.bRows() != 3) CoC.instance.transformations.BreastRowsThree.applyEffect(); break;
				case "Row4":	if (player.bRows() != 4) CoC.instance.transformations.BreastRowsFour.applyEffect(); break;
				default: 		if (player.hasBreasts() && player.bRows() > 1) CoC.instance.transformations.BreastRowsRemoveToOne.applyEffect();
								if (player.breastRows.length > 1) CoC.instance.transformations.BreastRowsRemoveToOne.applyEffect(); break;
				 //if(player.hasBreasts()) CoC.instance.transformations.BreastsShrinkToNothing.applyEffect(); 
			}
			switch(arr[4]) {// Nipples
				case "Human": 	CoC.instance.transformations.NipplesPerBreastOne.applyEffect(); 
								CoC.instance.transformations.NipplesUnfuck.applyEffect(); 
								CoC.instance.transformations.NipplesNoColor.applyEffect();	break;
				case "Cow": 	CoC.instance.transformations.NipplesPerBreastFour.applyEffect(); 
								CoC.instance.transformations.StartLactation.applyEffect();
								CoC.instance.transformations.NipplesNoColor.applyEffect();	break;
				case "Fuckable":CoC.instance.transformations.NipplesFuckableForce.applyEffect(); break;
				case "Black":   CoC.instance.transformations.NipplesBlack.applyEffect(); break;
				case "Glow":	CoC.instance.transformations.NipplesGlowing.applyEffect(); break;
				default: 		CoC.instance.transformations.NipplesPerBreastOne.applyEffect();
								CoC.instance.transformations.NipplesNoColor.applyEffect();
								CoC.instance.transformations.NipplesUnfuck.applyEffect();
								CoC.instance.transformations.RemoveLactation.applyEffect(); 	break;
			}
			switch(arr[5]) {// Ears
				case "Avian": 		CoC.instance.transformations.EarsAvian.applyEffect();		break;
				case "Bat": 		CoC.instance.transformations.EarsBat.applyEffect();			break;
				case "Bear": 		CoC.instance.transformations.EarsBear.applyEffect();		break;
				case "Bunny": 		CoC.instance.transformations.EarsBunny.applyEffect();		break;
				case "Cat": 		CoC.instance.transformations.EarsCat.applyEffect();			break;
				case "CaveWyrm": 	CoC.instance.transformations.EarsCaveWyrm.applyEffect();	break;
				case "Cow": 		CoC.instance.transformations.EarsCow.applyEffect();			break;
				case "Deer": 		CoC.instance.transformations.EarsDeer.applyEffect();		break;
				case "Displacer": 	CoC.instance.transformations.EarsDisplacer.applyEffect();	break;
				case "Dog": 		CoC.instance.transformations.EarsDog.applyEffect();			break;
				case "Dragon":  	CoC.instance.transformations.EarsDraconic.applyEffect();	break;
				case "Elfin": 		CoC.instance.transformations.EarsElfin.applyEffect();		break;
				case "Elven": 		CoC.instance.transformations.EarsElven.applyEffect();		break;
				case "Ferret":		CoC.instance.transformations.EarsFerret.applyEffect();		break;
				case "Fox": 		CoC.instance.transformations.EarsFox.applyEffect();			break;
				case "Goat": 		CoC.instance.transformations.EarsGoat.applyEffect();		break;
				case "Gremlin": 	CoC.instance.transformations.EarsGremlin.applyEffect();		break;
				case "Gryphon": 	CoC.instance.transformations.EarsGryphon.applyEffect();		break;
				case "Horse": 		CoC.instance.transformations.EarsHorse.applyEffect();		break;
				case "Human": 		CoC.instance.transformations.EarsHuman.applyEffect();		break;
				case "Insect": 		CoC.instance.transformations.EarsInsect.applyEffect();		break;
				case "Kangaroo": 	CoC.instance.transformations.EarsKangaroo.applyEffect();	break;
				case "Kirin": 		CoC.instance.transformations.EarsKirin.applyEffect();		break;
				case "Lion": 		CoC.instance.transformations.EarsLion.applyEffect();		break;
				case "Lizard": 		CoC.instance.transformations.EarsLizard.applyEffect();		break;
				case "Melkie": 		CoC.instance.transformations.EarsMelkie.applyEffect();		break;
				case "Mouse": 		CoC.instance.transformations.EarsMouse.applyEffect();		break;
				case "Oni": 		CoC.instance.transformations.EarsOni.applyEffect();			break;
				case "Orca": 		CoC.instance.transformations.EarsOrca.applyEffect();		break;
				case "Orca2": 		CoC.instance.transformations.EarsOrca2.applyEffect();		break;
				case "Panda": 		CoC.instance.transformations.EarsPanda.applyEffect();		break;
				case "Pig": 		CoC.instance.transformations.EarsPig.applyEffect();			break;
				case "Raccoon": 	CoC.instance.transformations.EarsRaccoon.applyEffect();		break;
				case "Raiju": 		CoC.instance.transformations.EarsRaiju.applyEffect();		break;
				case "RedPanda": 	CoC.instance.transformations.EarsRedPanda.applyEffect();	break;
				case "Shark": 		CoC.instance.transformations.EarsShark.applyEffect();		break;
				case "Snake": 		CoC.instance.transformations.EarsSnake.applyEffect();		break;
				case "Squirrel": 	CoC.instance.transformations.EarsSquirrel.applyEffect();	break;
				case "Vampire": 	CoC.instance.transformations.EarsVampire.applyEffect();		break;
				case "Weasel": 		CoC.instance.transformations.EarsWeasel.applyEffect();		break;
				case "Wolf": 		CoC.instance.transformations.EarsWolf.applyEffect();		break;
				case "Yeti": 		CoC.instance.transformations.EarsYeti.applyEffect();		break;

				default: CoC.instance.transformations.EarsHuman.applyEffect();					break;
			}
			switch(arr[6]) {// Eyes & Color
				case "Alicorn": 		CoC.instance.transformations.EyesHuman.applyEffect();
                                        CoC.instance.transformations.EyesAlicornColors.applyEffect();	break;
				case "Alraune":			CoC.instance.transformations.EyesAlrauneColors.applyEffect();	break;
				case "AtlachNacha":		CoC.instance.transformations.EyesSpider.applyEffect();
					 					CoC.instance.transformations.EyesAtlachColors.applyEffect(); break;
				case "Bear": 			CoC.instance.transformations.EyesBear.applyEffect();			break;
				case "Cancer": 			CoC.instance.transformations.EyesCancer.applyEffect();			break;
				case "Cat": 			CoC.instance.transformations.EyesCat.applyEffect();				break;
				case "CaveWyrm": 		CoC.instance.transformations.EyesCaveWyrm.applyEffect();		break;
				case "Centipede":		CoC.instance.transformations.EyesCentipede.applyEffect();		break;
				case "Dead": 			CoC.instance.transformations.EyesDead.applyEffect();			break;
				case "Devil": 			CoC.instance.transformations.EyesDevil.applyEffect();			break;
				case "Displacer": 		CoC.instance.transformations.EyesDisplacer.applyEffect();		break;
				case "Dragon": 		    CoC.instance.transformations.EyesDraconic.applyEffect();		break;
				case "Elf": 			CoC.instance.transformations.EyesElf.applyEffect();				break;
				case "Fairy": 			CoC.instance.transformations.EyesFairy.applyEffect();			break;
				case "Fenrir": 			CoC.instance.transformations.EyesFenrir.applyEffect();
										CoC.instance.transformations.EyesFenrirColor.applyEffect();		break;
				case "Feral": 			CoC.instance.transformations.EyesFeral.applyEffect();			break;
				case "Fiendish": 		CoC.instance.transformations.EyesFiendish.applyEffect();		break;
				case "FireSnail": 		CoC.instance.transformations.EyesFireSnail.applyEffect();		break;
				case "Fox": 			CoC.instance.transformations.EyesFox.applyEffect();				break;
				case "Frostwyrm": 		CoC.instance.transformations.EyesFrostwyrm.applyEffect();		break;
				case "Ghost": 			CoC.instance.transformations.EyesGhost.applyEffect();			break;
				case "Goat": 			CoC.instance.transformations.EyesGoat.applyEffect();			break;
				case "Goblin":			CoC.instance.transformations.EyesGoblinColors.applyEffect();	break;
				case "Gorgon": 			CoC.instance.transformations.EyesGorgon.applyEffect();			break;
				case "Gryphon": 		CoC.instance.transformations.EyesGryphon.applyEffect();			break;
				case "Hinezumi": 		CoC.instance.transformations.EyesHinezumi.applyEffect();		break;
				case "Human": 			CoC.instance.transformations.EyesHuman.applyEffect();			break;
				case "Infernal": 		CoC.instance.transformations.EyesInfernal.applyEffect();		break;
				case "Jiangshi": 		CoC.instance.transformations.EyesJiangshi.applyEffect();		break;
				case "Kamaitachi": 		CoC.instance.transformations.EyesKamaitachiColors.applyEffect();break;
				case "Kirin": 			CoC.instance.transformations.EyesKirinColors.applyEffect();		break;
				case "Kraken": 			CoC.instance.transformations.EyesKraken.applyEffect();
                                        CoC.instance.transformations.EyesKrakenColors.applyEffect();	break;
				case "Lizard": 			CoC.instance.transformations.EyesLizard.applyEffect();			break;
				case "Manticore": 		CoC.instance.transformations.EyesManticore.applyEffect();		break;
				case "Monoeye": 		CoC.instance.transformations.EyesMonoeye.applyEffect();			break;
				case "Oni": 			CoC.instance.transformations.EyesOni.applyEffect();				break;
				case "OniColors": 		CoC.instance.transformations.EyesOniColors.applyEffect();		break;
				case "Orc": 			CoC.instance.transformations.EyesOrc.applyEffect();				break;
				case "Plant": 			CoC.instance.transformations.EyesPlantColors.applyEffect();		break;
				case "Raccoon": 		CoC.instance.transformations.EyesRaccoonColors.applyEffect();	break;
				case "Raiju": 			CoC.instance.transformations.EyesRaiju.applyEffect();			break;
				case "Ratatoskr": 		CoC.instance.transformations.EyesRatatoskr.applyEffect();		break;
				case "SandTrap": 		CoC.instance.transformations.EyesSandTrap.applyEffect();		break;
				case "Seadragon": 		CoC.instance.transformations.EyesSeadragonColors.applyEffect();	break;
				case "Snake": 			CoC.instance.transformations.EyesSnake.applyEffect();			break;
				case "SnakeFiendish": 	CoC.instance.transformations.EyesSnakeFiendish.applyEffect();	break;
				case "Spider": 			CoC.instance.transformations.EyesSpider.applyEffect();			break;
				case "Vampire": 		CoC.instance.transformations.EyesVampire.applyEffect();			break;
				case "Weasel": 			CoC.instance.transformations.EyesWeasel.applyEffect();			break;
				default: 				CoC.instance.transformations.EyesHuman.applyEffect();			break;
			}
			switch(arr[7]) {// Face
				case "AnimalTeeth": 	CoC.instance.transformations.FaceAnimalTeeth.applyEffect();	break;
				case "Ant": 			CoC.instance.transformations.FaceAnt.applyEffect();				break;		
				case "Avian": 			CoC.instance.transformations.FaceAvian.applyEffect();			break;
				case "Bear": 			CoC.instance.transformations.FaceBear.applyEffect();			break;
				case "Boar": 			CoC.instance.transformations.FaceBoar.applyEffect();			break;
				case "Buckteeth": 		CoC.instance.transformations.FaceBuckteeth.applyEffect();		break;
				case "Bucktooth": 		CoC.instance.transformations.FaceBucktooth.applyEffect();		break;
				case "Bunny": 			CoC.instance.transformations.FaceBunny.applyEffect();			break;
				case "Cat": 			CoC.instance.transformations.FaceCat.applyEffect();				break;
				case "CatCanines": 		CoC.instance.transformations.FaceCatCanines.applyEffect();		break;
				case "Cheshire": 		CoC.instance.transformations.FaceCheshire.applyEffect();		break;
				case "CheshireSmile": 	CoC.instance.transformations.FaceCheshireSmile.applyEffect();	break;
				case "CowMinotaur": 	CoC.instance.transformations.FaceCowMinotaur.applyEffect();		break;
				case "Crazy": 			CoC.instance.transformations.FaceCrazy.applyEffect();			break;
				case "Deer": 			CoC.instance.transformations.FaceDeer.applyEffect();			break;
				case "Dog": 			CoC.instance.transformations.FaceDog.applyEffect();				break;
				case "DevilFangs": 		CoC.instance.transformations.FaceDevilFangs.applyEffect();		break;
				case "Dragon": 			CoC.instance.transformations.FaceDragon.applyEffect();			break;
				case "DragonFangs": 	CoC.instance.transformations.FaceDragonFangs.applyEffect();		break;
				case "Echidna": 		CoC.instance.transformations.FaceEchidna.applyEffect();			break;
				case "Elf": 			CoC.instance.transformations.FaceElf.applyEffect();				break;
				case "Fairy": 			CoC.instance.transformations.FaceFairy.applyEffect();			break;
				case "Ferret": 			CoC.instance.transformations.FaceFerret.applyEffect();			break;
				case "FerretMask": 		CoC.instance.transformations.FaceFerretMask.applyEffect();		break;
				case "FireSnail": 		CoC.instance.transformations.FaceFireSnail.applyEffect();		break;
				case "Fox": 			CoC.instance.transformations.FaceFox.applyEffect();				break;
				case "Ghost": 			CoC.instance.transformations.FaceGhost.applyEffect();			break;
				case "Horse": 			CoC.instance.transformations.FaceHorse.applyEffect();			break;		
				case "Human": 			CoC.instance.transformations.FaceHuman.applyEffect();			break;		
				case "Jabberwocky": 	CoC.instance.transformations.FaceJabberwocky.applyEffect();		break;
				case "Jiangshi": 		CoC.instance.transformations.FaceJiangshi.applyEffect();		break;
				case "Kangaroo": 		CoC.instance.transformations.FaceKangaroo.applyEffect();		break;
				case "Kudere": 			CoC.instance.transformations.FaceKudere.applyEffect();			break;
				case "Lizard": 			CoC.instance.transformations.FaceLizard.applyEffect();			break;
				case "Manticore": 		CoC.instance.transformations.FaceManticore.applyEffect();		break;
				case "Mouse": 			CoC.instance.transformations.FaceMouse.applyEffect();			break;
				case "OniTeeth": 		CoC.instance.transformations.FaceOniTeeth.applyEffect();		break;
				case "Orca": 			CoC.instance.transformations.FaceOrca.applyEffect();			break;
				case "OrcFangs": 		CoC.instance.transformations.FaceOrcFangs.applyEffect();		break;
				case "Panda": 			CoC.instance.transformations.FacePanda.applyEffect();			break;
				case "Pig": 			CoC.instance.transformations.FacePig.applyEffect();				break;
				case "PlantDragon": 	CoC.instance.transformations.FacePlantDragon.applyEffect();		break;
				case "Raccoon": 		CoC.instance.transformations.FaceRaccoon.applyEffect();			break;		
				case "RaccoonMask": 	CoC.instance.transformations.FaceRaccoonMask.applyEffect();		break;		
				case "RedPanda": 		CoC.instance.transformations.FaceRedPanda.applyEffect();		break;
				case "Rhino": 			CoC.instance.transformations.FaceRhino.applyEffect();			break;
				case "Salamander": 		CoC.instance.transformations.FaceSalamanderFangs.applyEffect();	break;
				case "Shark":   		CoC.instance.transformations.FaceSharkTeeth.applyEffect();		break;
				case "Smug": 			CoC.instance.transformations.FaceSmug.applyEffect();			break;
				case "Snake": 			CoC.instance.transformations.FaceSnakeFangs.applyEffect();		break;
				case "Spider": 	        CoC.instance.transformations.FaceSpiderFangs.applyEffect();		break;
				case "Squirrel": 		CoC.instance.transformations.FaceSquirrel.applyEffect();		break;
				case "UshiOniOnna": 	CoC.instance.transformations.FaceUshiOniOnna.applyEffect();		break;
				case "Vampire": 		CoC.instance.transformations.FaceVampire.applyEffect();			break;
				case "Weasel": 			CoC.instance.transformations.FaceWeasel.applyEffect();			break;
				case "Wolf": 			CoC.instance.transformations.FaceWolf.applyEffect();			break;
				case "WolfFangs": 		CoC.instance.transformations.FaceWolfFangs.applyEffect();		break;
				case "YetiFangs": 		CoC.instance.transformations.FaceYetiFangs.applyEffect();		break;
				case "YukiOnna": 		CoC.instance.transformations.FaceYukiOnna.applyEffect();		break;
				default: 				CoC.instance.transformations.FaceHuman.applyEffect();			break;
			}
            switch(arr[8]) {// Gills
				case "None": 		CoC.instance.transformations.GillsNone.applyEffect();			break;
				case "Human": 		CoC.instance.transformations.GillsNone.applyEffect();			break;
				case "Fish": 		CoC.instance.transformations.GillsFish.applyEffect();			break;
				case "Anemone": 	CoC.instance.transformations.GillsAnemone.applyEffect();		break;
				case "Tentacle":	CoC.instance.transformations.GillsInTentacleLegs.applyEffect();	break;
				default: 			CoC.instance.transformations.GillsNone.applyEffect();			break;
			}
            switch(arr[9]) {//Hair
			/*	CoC.instance.transformations.HairFeather.applyEffect();
				CoC.instance.transformations.HairBurning.applyEffect();
				CoC.instance.transformations.HairSnowy.applyEffect();
				CoC.instance.transformations.HairGrass.applyEffect();
				CoC.instance.transformations.HairGoo.applyEffect();
				CoC.instance.transformations.HairGhost.applyEffect();
				CoC.instance.transformations.HairRatatoskr.applyEffect();
				CoC.instance.transformations.HairWindswept.applyEffect();
				CoC.instance.transformations.HairAnemone.applyEffect();
				CoC.instance.transformations.HairFluffy.applyEffect();
				CoC.instance.transformations.HairCrazy.applyEffect();
				CoC.instance.transformations.HairPrismatic.applyEffect();
				CoC.instance.transformations.HairQuill.applyEffect();
				CoC.instance.transformations.HairFairy.applyEffect();
				CoC.instance.transformations.HairCow.applyEffect();
			*/
                case "Alicorn":		CoC.instance.transformations.HairHuman.applyEffect();
                    CoC.instance.transformations.HairChangeColor(["white"]).applyEffect();	break;
                case "AtlachNacha":	CoC.instance.transformations.HairHuman.applyEffect();
                    CoC.instance.transformations.HairChangeColor(AtlachNachaRace.AtlachNachaHairColors).applyEffect();	break;
                case "Elf":			CoC.instance.transformations.HairSilky.applyEffect();
                    CoC.instance.transformations.HairChangeColor(ElfRace.ElfHairColors).applyEffect(); break;
                case "Fairy":		CoC.instance.transformations.HairFairy.applyEffect(); break;
                case "Goblin":		CoC.instance.transformations.HairHuman.applyEffect();
                    CoC.instance.transformations.HairChangeColor(GoblinRace.GoblinHairColors).applyEffect(); break;
                case "Human": 		CoC.instance.transformations.HairHuman.applyEffect();	    break;
                case "Feather": 	CoC.instance.transformations.HairFeather.applyEffect();	    break;
                case "Ghost": 		CoC.instance.transformations.HairGhost.applyEffect();	    break;
                case "Gorgon": 		CoC.instance.transformations.HairGorgon.applyEffect();	    break;
                case "Kitsune": 	CoC.instance.transformations.HairHuman.applyEffect();
                    CoC.instance.transformations.HairChangeColor(KitsuneRace.BasicKitsuneHairColors).applyEffect();	break;
                case "Kitshoo": 	CoC.instance.transformations.HairHuman.applyEffect();
                    CoC.instance.transformations.HairChangeColor(KitshooRace.KitshooHairColors).applyEffect();	break;
                case "Plant": 		CoC.instance.transformations.HairLeaf.applyEffect();
                    CoC.instance.transformations.HairChangeColor(AlrauneRace.AlrauneHairColor).applyEffect();	break;
                case "Raccoon": 	CoC.instance.transformations.HairHuman.applyEffect();
                    CoC.instance.transformations.HairChangeColor(RaccoonRace.RaccoonHairColors).applyEffect();	break;
                case "Raiju": 		CoC.instance.transformations.HairStorm.applyEffect();
                    CoC.instance.transformations.HairChangeColor(RaijuRace.RaijuHairColors).applyEffect();	break;
                case "Shark": 		CoC.instance.transformations.HairHuman.applyEffect();
                    CoC.instance.transformations.HairChangeColor(SharkRace.SharkHairColors).applyEffect();	break;
                case "Wolf":	 	CoC.instance.transformations.HairHuman.applyEffect();
                    CoC.instance.transformations.HairChangeColor(WolfRace.BasicWolfHairColors).applyEffect();	break;
                default:			CoC.instance.transformations.HairHuman.applyEffect();	break;
            }
            switch(arr[10]) {// Horns
                case "Bicorn":		CoC.instance.transformations.HornsBicorn.applyEffect(); break;
                case "Cow":			CoC.instance.transformations.HornsCowMinotaur.applyEffect(); break;
                case "Deer":		CoC.instance.transformations.HornsAntlers.applyEffect(); break;
                case "Demon":		CoC.instance.transformations.HornsDemonic.applyEffect(); break;
                case "DragonDual":	CoC.instance.transformations.HornsDraconicDual.applyEffect();	break;
                case "DragonQuad":	CoC.instance.transformations.HornsDraconicQuadruple.applyEffect();	break;
                case "Frostwyrm":	CoC.instance.transformations.HornsFrostwyrm.applyEffect(); break;
                case "Ghost": 		CoC.instance.transformations.HornsGhostlyWisps.applyEffect(); break;
                case "GoatDual":	CoC.instance.transformations.HornsGoat.applyEffect(); break;
                case "GoatQuad":	CoC.instance.transformations.HornsGoatQuadruple.applyEffect(); break;
				case "Human":		CoC.instance.transformations.HornsNone.applyEffect();	break;
                case "Jabberwocky":	CoC.instance.transformations.HornsJabberwocky.applyEffect(); break;
				case "Jiangshi":	CoC.instance.transformations.HornsJiangshi.applyEffect();	break;
                case "Kirin":		CoC.instance.transformations.HornsKirin.applyEffect(); break;
                case "Kraken":		CoC.instance.transformations.HornsKraken.applyEffect(); break;
                case "Oak":			CoC.instance.transformations.HornsOak.applyEffect(); break;
                case "Oni":			CoC.instance.transformations.HornsOni.applyEffect(); break;
                case "OniDual":		CoC.instance.transformations.HornsOniDual.applyEffect(); break;
                case "Orchid":		CoC.instance.transformations.HornsOrchid.applyEffect(); break;
                case "Seadragon":	CoC.instance.transformations.HornsSeadragon.applyEffect(); break;
                case "Unicorn":		CoC.instance.transformations.HornsUnicorn.applyEffect();	break;
                case "UshiOni":		CoC.instance.transformations.HornsUshiOni.applyEffect(); break;
                case "Wendigo": 	CoC.instance.transformations.HornsAntlersWendigo.applyEffect(); break;
				default:			CoC.instance.transformations.HornsNone.applyEffect();	break;
			}
			switch(arr[11]) {// Lower Body ( Legs )
				case "DemonHighHeels": 	CoC.instance.transformations.LowerBodyDemonHighHeels.applyEffect();	break;
				case "DemonClawed": 	CoC.instance.transformations.LowerBodyDemonClawed.applyEffect();	break;
				case "Bee": 			CoC.instance.transformations.LowerBodyBee.applyEffect();	break;
				case "Spider":          CoC.instance.transformations.LowerBodySpider.applyEffect();	break;
				case "Drider": CoC.instance.transformations.LowerBodyDrider.applyEffect();	break;
				case "Oni": CoC.instance.transformations.LowerBodyOni.applyEffect();	break;
				case "RedPanda": CoC.instance.transformations.LowerBodyRedPanda.applyEffect();	break;
				case "Orc": CoC.instance.transformations.LowerBodyOrc.applyEffect();	break;
				case "Centipede": CoC.instance.transformations.LowerBodyCentipede.applyEffect();	break;
				case "Wendigo": CoC.instance.transformations.LowerBodyWendigo.applyEffect();	break;
				case "YukiOnna": CoC.instance.transformations.LowerBodyYukiOnna.applyEffect();	break;
				case "PlantRootClaws": CoC.instance.transformations.LowerBodyPlantRootClaws.applyEffect();	break;
				case "PlantHighHeels": CoC.instance.transformations.LowerBodyPlantHighHeels.applyEffect();	break;
				case "Goo": CoC.instance.transformations.LowerBodyGoo.applyEffect();	break;
				case "Ferret": CoC.instance.transformations.LowerBodyFerret.applyEffect();	break;
				case "Avian": CoC.instance.transformations.LowerBodyAvian.applyEffect();	break;
				case "Melkie": CoC.instance.transformations.LowerBodyMelkie.applyEffect();	break;
				case "UshiOni": CoC.instance.transformations.LowerBodyUshiOni.applyEffect();	break;
				case "Mouse": CoC.instance.transformations.LowerBodyMouse.applyEffect();	break;
				case "Hinezumi": CoC.instance.transformations.LowerBodyHinezumi.applyEffect();	break;
				case "Yeti": CoC.instance.transformations.LowerBodyYeti.applyEffect();	break;
				case "Gazer": CoC.instance.transformations.LowerBodyGazer.applyEffect();	break;
				case "FireSnail": CoC.instance.transformations.LowerBodyFireSnail.applyEffect();	break;
				case "Frostwyrm": CoC.instance.transformations.LowerBodyFrostwyrm.applyEffect();	break;
				case "Raccoon": CoC.instance.transformations.LowerBodyRaccoon.applyEffect();	break;
				case "Squirrel": CoC.instance.transformations.LowerBodySquirrel.applyEffect();	break;
				case "Kangaroo": CoC.instance.transformations.LowerBodyKangaroo.applyEffect();	break;
				case "CaveWyrm": CoC.instance.transformations.LowerBodyCaveWyrm.applyEffect();	break;
				case "Bunny": CoC.instance.transformations.LowerBodyBunny.applyEffect();	break;
				case "Jabberwocky": CoC.instance.transformations.LowerBodyJabberwocky.applyEffect();	break;
				case "Crab": CoC.instance.transformations.LowerBodyCrab.applyEffect();	break;
				case "Cancer": CoC.instance.transformations.LowerBodyCancer.applyEffect();	break;



				case "Alraune":     CoC.instance.transformations.LowerBodyPlantFlower.applyEffect();	break;
				case "Ant":         CoC.instance.transformations.LowerBodyAnt.applyEffect();			break;
				case "Atlach":      CoC.instance.transformations.LowerBodyAtlach.applyEffect();			break;
				case "AtlachNacha": CoC.instance.transformations.LowerBodyAtlachNacha.applyEffect();	break;
                case "Bipedal": 	CoC.instance.transformations.LowerBodyBipedal.applyEffect();		break;
                case "Dragon": 		CoC.instance.transformations.LowerBodyDraconic().applyEffect();		break;
                case "Elf": 		CoC.instance.transformations.LowerBodyElf.applyEffect();			break;
				case "Ghost": 		CoC.instance.transformations.LowerBodyGhost.applyEffect();	break;
				case "Ghost2": 		CoC.instance.transformations.LowerBodyGhost2.applyEffect();	break;
                case "Harpy":       CoC.instance.transformations.LowerBodyHarpy.applyEffect();	        break;
				case "Human": 		CoC.instance.transformations.LowerBodyBipedal.applyEffect();
									CoC.instance.transformations.LowerBodyHuman.applyEffect();			break;
				case "Horse": 		CoC.instance.transformations.LowerBodyBipedal.applyEffect();
									CoC.instance.transformations.LowerBodyHoofed().applyEffect();		break;
				case "Hydra": 		CoC.instance.transformations.LowerBodyHydra.applyEffect();			break;
				case "Jiangshi":	CoC.instance.transformations.LowerBodyJiangshi.applyEffect();		break;
				case "Kraken": 		CoC.instance.transformations.LowerBodyKraken.applyEffect();	break;
				case "Raiju": 		CoC.instance.transformations.LowerBodyRaiju().applyEffect();		break;
				case "Salamander":	CoC.instance.transformations.LowerBodySalamander().applyEffect();	break;
				case "Scylla": 		CoC.instance.transformations.LowerBodyScylla.applyEffect();	break;
				case "Shark": 		CoC.instance.transformations.LowerBodyShark().applyEffect();	break;
				case "Snake":		CoC.instance.transformations.LowerBodySnake.applyEffect();			break;
				case "Wolf":		CoC.instance.transformations.LowerBodyWolf().applyEffect();			break;
				default: 	  		CoC.instance.transformations.LowerBodyBipedal.applyEffect();
									CoC.instance.transformations.LowerBodyHuman.applyEffect(); 			break;
			}
			switch(arr[12]) {// Rear Body ( Back/Neck ) 
				case "AtlachNacha": CoC.instance.transformations.RearBodyAtlachNacha.applyEffect();			break;
				case "Bat": 		CoC.instance.transformations.RearBodyBatCollar.applyEffect();			break;
				case "Centipede": 	CoC.instance.transformations.RearBodyCentipede.applyEffect();			break;
				case "Cobra":		CoC.instance.transformations.RearBodyCobraHood.applyEffect();			break;
				case "Displacer": 	CoC.instance.transformations.RearBodyDisplacerTentacles.applyEffect();	break;
				case "Eyestalk": 	CoC.instance.transformations.RearBodyTentacleEyestalks.applyEffect();	break;
				case "Fenrir":		CoC.instance.transformations.RearBodyFenrirIceSpikes.applyEffect();		break;
				case "FrostWyrm": 	CoC.instance.transformations.RearBodyFrostwyrm.applyEffect();			break;
				case "FurCoat": 	CoC.instance.transformations.RearBodyFurCoat.applyEffect();				break;
				case "Ghost": 		CoC.instance.transformations.RearBodyGhostlyAura.applyEffect();			break;
				case "Glacial": 	CoC.instance.transformations.RearBodyGlacialAura.applyEffect();			break;
				case "Goo": 		CoC.instance.transformations.RearBodyMetamorphicGoo.applyEffect();		break;
				case "Human": 		CoC.instance.transformations.RearBodyNone.applyEffect();				break;
				case "Kraken": 		CoC.instance.transformations.RearBodyKraken.applyEffect();				break;
				case "Lion": 		CoC.instance.transformations.RearBodyLionMane.applyEffect();			break;
				case "Orca": 		CoC.instance.transformations.RearBodyOrcaBlowhole.applyEffect();		break;
				case "Raiju": 		CoC.instance.transformations.RearBodyRaijuMane.applyEffect();			break;
				case "Shark": 		CoC.instance.transformations.RearBodySharkFin.applyEffect();			break;
				case "Snail": 		CoC.instance.transformations.RearBodySnailShell.applyEffect();			break;
				case "Yeti": 		CoC.instance.transformations.RearBodyYetiFur.applyEffect();				break;
				case "Wolf": 		CoC.instance.transformations.RearBodyWolfCollar.applyEffect();				break;
				default: 			CoC.instance.transformations.RearBodyNone.applyEffect();				break;
			}
			switch(arr[13]) {//Skin
			/*ransformations.SkinPatternNone.applyEffect();
				CoC.instance.transformations.SkinPatternOrc.applyEffect();
				CoC.instance.transformations.SkinPatternOni.applyEffect();
				CoC.instance.transformations.SkinPatternKitsune.applyEffect();
				CoC.instance.transformations.SkinPatternVenomousMarkings.applyEffect();
				CoC.instance.transformations.SkinPatternOil.applyEffect();
				CoC.instance.transformations.SkinPatternScarWindswept.applyEffect();
				CoC.instance.transformations.SkinPatternUshiOniTattoo.applyEffect();
				CoC.instance.transformations.SkinPatternBeeStripes.applyEffect();
				CoC.instance.transformations.SkinPatternTigerSharkStripes.applyEffect();
				CoC.instance.transformations.SkinPatternOrca.applyEffect();
				CoC.instance.transformations.SkinPatternSeaDragon.applyEffect();
			*/
				case "Alraune":
					CoC.instance.transformations.SkinColor(AlrauneRace.AlrauneSkinColor).applyEffect();
					CoC.instance.transformations.SkinPlain.applyEffect();
					break;
				case "Alicorn":
					CoC.instance.transformations.SkinPlain.applyEffect();
					CoC.instance.transformations.SkinFur(Skin.COVERAGE_COMPLETE, {colors: AlicornRace.AlicornFurColors}).applyEffect();
					break;
                case "Ant":
					CoC.instance.transformations.SkinPlain.applyEffect();
					CoC.instance.transformations.SkinChitin(Skin.COVERAGE_COMPLETE, {colors: AntRace.AntChitinColors}).applyEffect();
					break;
                case "AtlachNacha":
					CoC.instance.transformations.SkinPlain.applyEffect();
					CoC.instance.transformations.SkinChitin(Skin.COVERAGE_COMPLETE, {colors: AtlachNachaRace.AtlachNachaChitinColors}).applyEffect();
					break;
                case "Dragon":
					CoC.instance.transformations.SkinPlain.applyEffect();
					CoC.instance.transformations.SkinDragonScales(Skin.COVERAGE_COMPLETE, {colors: DragonRace.DragonScaleColors}).applyEffect();
					break;
                case "Elf":
					CoC.instance.transformations.SkinPatternNone.applyEffect();
					CoC.instance.transformations.SkinColor(ElfRace.ElfSkinColors).applyEffect();
					CoC.instance.transformations.SkinPlain.applyEffect();
					player.skinAdj = "flawless";
					break;
                case "Fenrir":
                    CoC.instance.transformations.SkinPlain.applyEffect();
                    CoC.instance.transformations.SkinFur(Skin.COVERAGE_COMPLETE, {colors: WolfRace.BasicWolfFurColors}).applyEffect();
                    break;
				case "Goblin":
					CoC.instance.transformations.SkinPlain.applyEffect();
					CoC.instance.transformations.SkinColor(GoblinRace.GoblinSkinColors).applyEffect();
					break;
				case "Ghost":
                    CoC.instance.transformations.SkinTransparent.applyEffect();
                    CoC.instance.transformations.SkinPatternWhiteBlackVeins.applyEffect();
					CoC.instance.transformations.SkinColor(PoltergeistRace.PoltergeistSkinColors).applyEffect();

					break;
                case "Human":
					CoC.instance.transformations.SkinPatternNone.applyEffect();
					CoC.instance.transformations.SkinColor(HumanRace.HumanSkinColors).applyEffect();
					CoC.instance.transformations.SkinPlain.applyEffect();
					break;
				case "Jiangshi":
					CoC.instance.transformations.SkinColor(JiangshiRace.JiangshiSkinColors).applyEffect();
					CoC.instance.transformations.SkinPlain.applyEffect();
					break;
                case "Kitsune":
                    CoC.instance.transformations.SkinPlain.applyEffect();
                    CoC.instance.transformations.SkinFur(Skin.COVERAGE_COMPLETE, {colors: KitsuneRace.BasicKitsuneFurColors}).applyEffect();
                    CoC.instance.transformations.SkinPatternKitsune.applyEffect();
                    break;
                case "Kitshoo":
                    CoC.instance.transformations.SkinPlain.applyEffect();
                    CoC.instance.transformations.SkinFur(Skin.COVERAGE_COMPLETE, {colors: KitshooRace.KitshooFurColors}).applyEffect();
                    CoC.instance.transformations.SkinPatternKitsune.applyEffect();
                    break;
                case "Kraken":
                    CoC.instance.transformations.SkinSlippery.applyEffect();
                    CoC.instance.transformations.SkinColor(ScyllaRace.ScyllaSkinColors).applyEffect();
                    break;
				case "Raccoon":
					CoC.instance.transformations.SkinFur(Skin.COVERAGE_COMPLETE, {colors: RaccoonRace.RaccoonFurColors}).applyEffect();
					break;
				case "Wolf":
					CoC.instance.transformations.SkinFur(Skin.COVERAGE_COMPLETE, {colors: WolfRace.BasicWolfHairColors}).applyEffect();
					break;
				case "Raiju":
					CoC.instance.transformations.SkinPatternRaiju.applyEffect();
					break;
                case "Salamander":
                    CoC.instance.transformations.SkinScales(Skin.COVERAGE_LOW, {colors: SalamanderRace.SalamanderScaleColors}).applyEffect();
                    break;
				case "Shark":
                    CoC.instance.transformations.SkinAquaScales(Skin.COVERAGE_HIGH, {color: "orange", color2: "black", pattern: Skin.PATTERN_TIGER_STRIPES}).applyEffect();
                    //CoC.instance.transformations.SkinPatternTigerSharkStripes.applyEffect();
                    break;
                case "Snake":
                    CoC.instance.transformations.SkinScales(Skin.COVERAGE_LOW, {colors: NagaRace.SnakeScaleColors}).applyEffect();
                    break;
				case "Vouivre":
					CoC.instance.transformations.SkinDragonScales(Skin.COVERAGE_COMPLETE, {colors: NagaRace.SnakeScaleColors}).applyEffect();
					break;

				case "Fur":	// Default Fur - For races with no color requirements
                    CoC.instance.transformations.SkinFur(Skin.COVERAGE_COMPLETE).applyEffect();
					break;
                default:
					CoC.instance.transformations.SkinPatternNone.applyEffect();
					CoC.instance.transformations.SkinPlain.applyEffect();
					break;
			}
			switch(arr[14]) {// Ovipositor ( Bee/Spider egg laying )
				case "Ant": 	if(!player.canOvipositAnt()) CoC.instance.transformations.OvipositorAnt.applyEffect();		break;
				case "Human": 	if(!player.canOviposit()) CoC.instance.transformations.RemoveOvipositor.applyEffect();		break;
				case "Mantis": 	if(!player.canOvipositMantis()) CoC.instance.transformations.OvipositorMantis.applyEffect();break;
				case "Spider": 	if(!player.canOvipositSpider()) CoC.instance.transformations.OvipositorSpider.applyEffect();break;
				default:		if(player.canOviposit()) CoC.instance.transformations.RemoveOvipositor.applyEffect();		break;
			}
			switch(arr[15]) {// Oviposition ( Harpy / Reptile egg laying )
				case "Human": 	CoC.instance.transformations.RemoveOviposition.applyEffect();	break;
				default: 		CoC.instance.transformations.RemoveOviposition.applyEffect();	break;
			}
			switch(arr[16]) {// Glowing Asshole
				case "Human": 	CoC.instance.transformations.AssholeNormal.applyEffect();	break;
				case "Glow": 	CoC.instance.transformations.AssholeGlowing.applyEffect();	break;
				default: 		CoC.instance.transformations.AssholeNormal.applyEffect();	break;
			}
			switch(arr[17]) {//Tail
			/*	CoC.instance.transformations.TailScorpion.applyEffect();
				CoC.instance.transformations.TailManticore.applyEffect();
				CoC.instance.transformations.TailBurning.applyEffect();
				CoC.instance.transformations.TailTwinkasha.applyEffect();
				CoC.instance.transformations.TailCat.applyEffect();
				CoC.instance.transformations.TailNekomataOneThirdForked.applyEffect();
				CoC.instance.transformations.TailNekomataTwoThirdsForked.applyEffect();
				CoC.instance.transformations.TailCat2nd.applyEffect();
				CoC.instance.transformations.TailRedPanda.applyEffect(); 
				CoC.instance.transformations.TailKirin.applyEffect();
				CoC.instance.transformations.TailPig.applyEffect();
				CoC.instance.transformations.TailMantis.applyEffect();
				CoC.instance.transformations.TailGoat.applyEffect();
				CoC.instance.transformations.TailCow.applyEffect();
				CoC.instance.transformations.TailDraconic.applyEffect();
				CoC.instance.transformations.TailOrca.applyEffect();
				CoC.instance.transformations.TailHarpy.applyEffect();
				CoC.instance.transformations.TailBee.applyEffect();
				CoC.instance.transformations.TailLizard.applyEffect();
				CoC.instance.transformations.TailDemonic.applyEffect();
				CoC.instance.transformations.TailDog.applyEffect();
				CoC.instance.transformations.TailCaveWyrm.applyEffect();
				CoC.instance.transformations.TailAvian.applyEffect();
				CoC.instance.transformations.TailGriffin.applyEffect();
				CoC.instance.transformations.TailKangaroo.applyEffect();
				CoC.instance.transformations.TailThunderbird.applyEffect();
				CoC.instance.transformations.TailSquirrel.applyEffect();
				CoC.instance.transformations.TailWeasel.applyEffect();
				CoC.instance.transformations.TailMouse.applyEffect();
				CoC.instance.transformations.TailHinezumi.applyEffect();
				CoC.instance.transformations.TailFerret.applyEffect();
				CoC.instance.transformations.TailBear.applyEffect();
				CoC.instance.transformations.TailUshiOni.applyEffect();
				CoC.instance.transformations.TailWendigo.applyEffect();
			*/
				case "Ant":		    CoC.instance.transformations.TailAnt.applyEffect();		        break;
				case "Atlach":	    CoC.instance.transformations.TailSpinneretAtlach.applyEffect(); break;
				case "Bunny":	    CoC.instance.transformations.TailRabbit.applyEffect();       	break;
				case "Dragon":	    CoC.instance.transformations.TailDraconic.applyEffect();        break;
				case "Horse":	    CoC.instance.transformations.TailHorse.applyEffect();	        break;
				case "Human":	    CoC.instance.transformations.TailNone.applyEffect();	        break;
                case "Hydra":	    CoC.instance.transformations.TailHydra.applyEffect();			break;
				case "Kitsune":	    CoC.instance.transformations.TailFox(9).applyEffect();	        break;
				case "Kitshoo":	    CoC.instance.transformations.TailKitshoo(9).applyEffect();		break;
				case "Raccoon":	    CoC.instance.transformations.TailRaccoon.applyEffect();	        break;
				case "Raiju": 	    CoC.instance.transformations.TailRaiju.applyEffect();	        break;
				case "Salamander": 	CoC.instance.transformations.TailSalamander.applyEffect();	    break;
				case "Shark": 		CoC.instance.transformations.TailShark.applyEffect();			break;
                case "Spider": 	    CoC.instance.transformations.TailSpider.applyEffect();	        break;
                case "Wolf": 	    CoC.instance.transformations.TailWolf.applyEffect();	        break;
				default:		    CoC.instance.transformations.TailNone.applyEffect();	        break;
			}
			switch(arr[18]) {// Tongue
				case "Cat":			CoC.instance.transformations.TongueCat.applyEffect();		break;
				case "CaveWyrm":	CoC.instance.transformations.TongueCaveWyrm.applyEffect();	break;
				case "Demon":		CoC.instance.transformations.TongueDemonic.applyEffect();	break;
				case "Dog":			CoC.instance.transformations.TongueDog.applyEffect();		break;
				case "Dragon":		CoC.instance.transformations.TongueDraconic.applyEffect();	break;
                case "Elf": 		CoC.instance.transformations.TongueElf.applyEffect();		break;
				case "Ghost":		CoC.instance.transformations.TongueGhost.applyEffect();		break;
				case "Human": 		CoC.instance.transformations.TongueHuman.applyEffect();		break;
				case "Melkie":		CoC.instance.transformations.TongueMelkie.applyEffect();	break;
				case "Ratatoskr":	CoC.instance.transformations.TongueRatatoskr.applyEffect();	break;
				case "Ravenous":	CoC.instance.transformations.TongueRavenous.applyEffect();	break;
				case "Snake": 		CoC.instance.transformations.TongueSnake.applyEffect();		break;
				default: 			CoC.instance.transformations.TongueHuman.applyEffect();		break;
			}
			switch(arr[19]) {//Wings
			/*	CoC.instance.transformations.WingsFeatheredSphinx.applyEffect();
				CoC.instance.transformations.WingsManticoreLarge.applyEffect();
				CoC.instance.transformations.WingsManticoreSmall.applyEffect();
				CoC.instance.transformations.WingsNightmare.applyEffect(); 
				CoC.instance.transformations.WingsThunderousAura.applyEffect();
				CoC.instance.transformations.WingsMantisLarge.applyEffect();
				CoC.instance.transformations.WingsMantisSmall.applyEffect();
				CoC.instance.transformations.WingsDraconicHuge.applyEffect();
				CoC.instance.transformations.WingsDraconicLarge.applyEffect();
				CoC.instance.transformations.WingsDraconicSmall.applyEffect();
				CoC.instance.transformations.WingsFeatheredPhoenix.applyEffect();
				CoC.instance.transformations.WingsBeeLarge.applyEffect();
				CoC.instance.transformations.WingsBeeSmall.applyEffect();
				CoC.instance.transformations.WingsDemonicQuadrupleLarge.applyEffect();
				CoC.instance.transformations.WingsDemonicLarge.applyEffect();
				CoC.instance.transformations.WingsDemonicTiny.applyEffect();
				CoC.instance.transformations.WingsVampire.applyEffect();
				CoC.instance.transformations.WingsFeatheredAvian.applyEffect();
				CoC.instance.transformations.WingsLevitation.applyEffect();
				CoC.instance.transformations.WingsWindyAura.applyEffect();
				CoC.instance.transformations.WingsGiantDragonfly.applyEffect();
				CoC.instance.transformations.WingsSeaDragon.applyEffect();
				CoC.instance.transformations.WingsDevilfeather.applyEffect();
				CoC.instance.transformations.WingsFeyDragon.applyEffect();
				CoC.instance.transformations.WingsJabberwocky.applyEffect();
				CoC.instance.transformations.WingsPlant.applyEffect();
				 
			 */
				case "Ant": 			CoC.instance.transformations.WingsAntLarge.applyEffect();			break;
				case "Alicorn": 		CoC.instance.transformations.WingsFeatheredAlicorn.applyEffect();	break;
				case "Couatl":	 		CoC.instance.transformations.WingsCouatl.applyEffect();				break;
				case "DraconicL": 		CoC.instance.transformations.WingsDraconicLarge.applyEffect();		break;
				case "Fairy": 		    CoC.instance.transformations.WingsFairy.applyEffect();		        break;
				case "Feathered": 		CoC.instance.transformations.WingsFeatheredLarge.applyEffect();		break;
				case "Ghost": 		    CoC.instance.transformations.WingsEthereal.applyEffect();		    break;
				case "Phoenix": 		CoC.instance.transformations.WingsFeatheredPhoenix.applyEffect();	break;
				case "Human": 			CoC.instance.transformations.WingsNone.applyEffect();				break;
				case "Thunder": 		CoC.instance.transformations.WingsThunderousAura.applyEffect();		break;
				default: 				CoC.instance.transformations.WingsNone.applyEffect();				break;
			}
			switch(arr[20]) {//Cocks
			/*	public var cocks:CockCoC.instance.transformations = new CockCoC.instance.transformations();
				public function UnlockCocks():void { return cocks.UnlockCocks(); }
				public function CockNone(cock:int = 0): Transformation { return cocks.CockNone(); }
				public function CockHuman(cock:int = 0, length:Number = 5.5, thickness:Number = 1): Transformation 			{ return cocks.CockHuman(cock, length, thickness); }
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
				public function CockUshiOni(cock:int = 0, length:Number = 5.5, thickness:Number = 1): Transformation 		{ return cocks.CockUshiOni(cock, length, thickness); }
				public function CockInsect(cock:int = 0, length:Number = 5.5, thickness:Number = 1): Transformation 		{ return cocks.CockInsect(cock, length, thickness); }
				public function GrowKnot(cock:int = 0, crit:Number = 1, mod:Number = 1, div:Number = 20): Transformation 	{ return cocks.GrowKnot(cock, crit, mod, div); }
				public function CockChangeType(type:CockTypesEnum, grow:Boolean, oneByOne:Boolean=false):Transformation 	{ return cocks.CockChangeType(type, grow, oneByOne); }
				*/
				case "Alraune": if (player.cocks.length >= 1) CoC.instance.transformations.CockStamen(0, rand(3) + 4).applyEffect(false);	break;
				case "Horse": 	if (player.cocks.length >= 1) CoC.instance.transformations.CockHorse(0, rand(3) + 4).applyEffect(false);	break;
				case "Human": 	if (player.cocks.length >= 1) CoC.instance.transformations.CockHuman(0, rand(3) + 4).applyEffect(false);	break;
				case "Insect": 	if (player.cocks.length >= 1) CoC.instance.transformations.CockInsect(0, rand(3) + 4).applyEffect(false);	break;
				case "Lizard": 	if (player.cocks.length >= 1) CoC.instance.transformations.CockLizard(0, rand(3) + 4).applyEffect(false);	break;
				case "Raiju": 	if (player.cocks.length >= 1) CoC.instance.transformations.CockRaiju(0, rand(3) + 4).applyEffect(false);	break;
				case "Wolf": 	if (player.cocks.length >= 1) CoC.instance.transformations.CockWolf(0, rand(3) + 4).applyEffect(false);	break;

				// Requires Penis towards Score
                case "EasterBunny":
				case "Raccoon": CoC.instance.transformations.CockHuman(0, rand(3) + 4).applyEffect(false);	break;

				default: 		if(player.cocks.length >= 1) CoC.instance.transformations.CockHuman(0, rand(3) + 4).applyEffect(false);	break;
			}
			switch(arr[21]) {// Vaginas
			/*	public var vaginas:VaginaCoC.instance.transformations = new VaginaCoC.instance.transformations();
				public function UnlockVagina(): void { return vaginas.UnlockVagina(); }
				public function VaginaNone(vagina:int = 0): Transformation { return vaginas.VaginaNone(vagina); }
				public function CockToVagina(vagina:int = 0): Transformation { return vaginas.CockToVagina(vagina); }
				public function VaginaHuman(vagina:int = 0): Transformation { return vaginas.VaginaHuman(vagina); }
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
			*/
				case "Alraune":	if(player.hasVagina()) CoC.instance.transformations.VaginaAlraune().applyEffect();	break;
				case "Human": 	if(player.hasVagina()) CoC.instance.transformations.VaginaHuman().applyEffect();	break;
				case "Horse": 	if(player.hasVagina()) CoC.instance.transformations.VaginaHorse().applyEffect();	break;
				case "Lizard":	if(player.hasVagina()) CoC.instance.transformations.VaginaNaga().applyEffect();		break;
				case "Raiju": 	if(player.hasVagina()) CoC.instance.transformations.VaginaRaiju().applyEffect();	break;
				case "Scylla": 	if(player.hasVagina()) CoC.instance.transformations.VaginaScylla().applyEffect();	break;
				case "Shark": 	if(player.hasVagina()) CoC.instance.transformations.VaginaShark().applyEffect();	break;



				case "Goblin": 	if(!player.hasVagina()) CoC.instance.transformations.VaginaHuman().applyEffect();	break;
				default: 		if(player.hasVagina()) CoC.instance.transformations.VaginaHuman().applyEffect();	break;
			}
            switch(arr[22]){ // Race Specific Perks
                case "AtlachNacha":
                    player.createPerk(PerkLib.Venomancy,0,0,0,0);
                    player.createPerk(PerkLib.Insanity,0,0,0,0);
                    break;
                case "EasterBunny":
                    player.createPerk(PerkLib.EasterBunnyBalls, 0, 0, 0, 0);
					break;
                case "Elf":
                    player.createPerk(PerkLib.FlawlessBody, 0, 0, 0, 0);
                    player.createPerk(PerkLib.ElvenSense, 0, 0, 0, 0);
                    break;
                case "Fairy":
                    player.createPerk(PerkLib.FlawlessBody, 0, 0, 0, 0);
                    break;
                case "Ghost":
                    player.createPerk(PerkLib.Ghostslinger, 0, 0, 0, 0);
                    player.createPerk(PerkLib.Telekinesis, 0, 0, 0, 0);
                    player.createPerk(PerkLib.PhantomShooting, 0, 0, 0, 0);
                    break;
                case "Goblin":
                    player.createPerk(PerkLib.GoblinoidBlood, 0, 0, 0, 0);
                    player.createPerk(PerkLib.BouncyBody, 0, 0, 0, 0);
                    break;
                case "Jiangshi":
                    player.createPerk(PerkLib.HaltedVitals, 0, 0, 0, 0);
                    player.createPerk(PerkLib.SuperStrength, 0, 0, 0, 0);
                    player.createPerk(PerkLib.PoisonNails, 0, 0, 0, 0);
                    player.createPerk(PerkLib.Rigidity, 0, 0, 0, 0);
                    player.createPerk(PerkLib.LifeLeech, 0, 0, 0, 0);
                    player.createPerk(PerkLib.Undeath, 0, 0, 0, 0);
                    player.createPerk(PerkLib.EnergyDependent, 0, 0, 0, 0);
                    flags[kFLAGS.CURSE_OF_THE_JIANGSHI] = 2;
                    break;
                case "Phoenix":
                    player.createPerk(PerkLib.HarpyWomb, 10, 0, 0, 0);
                    break;
                default: break;
            }

			//CoC.instance.transformations.SkinColor(GoblinRace.GoblinSkinColors).applyEffect();
			//player.killCocks(player.cocks.length - 1) - remove all but 1
			//player.killCocks(-1) - remove all	
		}
	}
}