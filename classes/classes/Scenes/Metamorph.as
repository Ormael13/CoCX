/**
 * ...
 * @author Ormael
 */
package classes.Scenes {
	import classes.*;
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
	import classes.Items.MutationsHelper;

	import classes.GeneticMemories.*;

	import classes.internals.Utils;

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
				return;
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
			outputText("<font size=\"36\" face=\"Georgia\"><u>Soulforce Metamorph</u></font>\n");
			outputText("You calm your thoughts and take a moment to center yourself, recalling your past experiences. The transformations you have experienced so far have left their mark, not so easily forgotten even when undone and replaced innumerable times. When you focus, you can feel the threads in place, echoes of the many bodies you called your own, of limbs you once owned and skins you wore as comfortably as your current one.\n\nWith a little effort, you could imprint some of those recollections upon yourself. Powerful wings which carried you above the clouds, attentive ears which alerted you of danger; any such memories could return to you just as easily as they left, still rightfully yours.\n\nAs such, is there anything you would like to change about your current form?");
			outputText("\n\n<b>Race added to Metamorph:\n");
			outputText("Alicorn, Bat, Bee, Bicorn, Boar, Cat, Cave Wyrm, Cheshire Cat, Cow, Couatl, Cyclop, Demon, Devil, Displacer Beast, Dragon, Elf, Fox, Frost Wyrm, Gazer, Gorgon, Harpy, Hellcat, Hinezumi, Horse, Human, Kitsune, Lizard, Manticore, Mantis, Minotaur, Mouse, Naga, Nekomata, Nightmare, Oni, Orc, Orca, Phoenix, Pig, Raiju, Red Panda, Salamander, Shark, Sphinx, Spider (+Drider), Unicorn, Vampire, Winter Wolf</b>");
			outputText("\n\n<b>Bonus to Max Soulforce:</b> " + 50 * (1 + player.perkv1(PerkLib.Metamorph)));

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
				}
			];

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

		private function openPaginatedMenu (title: String, thisMenu: *, currentPage: int, memArray:Array): void {
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
				const partsInUse: Boolean = genMem.transformation().isPresent();
				const enoughSF: Boolean = player.soulforce >= genMem.cost;

				if (unlocked && !partsInUse && enoughSF) addButton(currentButton, buttonStr, doMetamorph, title, genMem).hint("Cost: " + genMem.cost + " SF" + (genMem.info ? "\n\n" + genMem.info : ""));
				else if (unlocked && partsInUse) addButtonDisabled(currentButton, buttonStr, "You already have this, the metamorphosis would have no effect!");
				else if (unlocked && !partsInUse && !enoughSF) addButtonDisabled(currentButton, buttonStr, "Cost: " + genMem.cost + " SF (You don't have enough Soulforce for this metamorphosis!)");
				else if (!unlocked) addButtonDisabled(currentButton, buttonStr, "You haven't unlocked this metamorphosis yet!" + (genMem.lockedInfo ? "\n\n" + genMem.lockedInfo : ""));
				currentButton++;
			}

			if (lastPage > 0) {
				if (currentPage > 0) addButton(12, "Prev Page", thisMenu, currentPage - 1);
				else addButtonDisabled (12, "Prev Page");
				if (currentPage < lastPage) addButton(13, "Next Page", thisMenu, currentPage + 1);
				else addButtonDisabled (13, "Next Page");
			}

			addButton(14, "Back", accessMetamorphMenu);
		}

		private function doMetamorph (title: String, genMem: *): void {
			clearOutput();
			outputText(title);
			genMem.transformation().applyEffect();
			player.soulforce -= genMem.cost;
			CoC.instance.mainViewManager.updateCharviewIfNeeded();
			doNext(accessMetamorphMenu);
		}

		private function openPaginatedSkinMenu (title: String, currentPage: int): void {
			menu();

			var memArray: Array = SkinMem.Memories;

			memArray = memArray.filter(function(element: *, index: int, array: Array): Boolean {
				if (element) {
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
			if (player.tallness >= 132) player.tallness = 132;
			doNext(accessPageEx1MetamorphMenu);
		}
		private function metamorphHeight2U():void {
			clearOutput();
			player.soulforce -= 700;
			outputText("\n\nWhoa wait did you just gain some height!? You indeed notice you've grown by two inches.");
			player.tallness += 2;
			if (player.tallness >= 132) player.tallness = 132;
			doNext(accessPageEx1MetamorphMenu);
		}
		private function metamorphHeight1D():void {
			clearOutput();
			player.soulforce -= 100;
			outputText("\n\nWhoa wait did you just lost some height!? You indeed notice you've shrunk by an inch.");
			player.tallness -= 1;
			if (player.tallness < 42) player.tallness = 42;
			doNext(accessPageEx1MetamorphMenu);
		}
		private function metamorphHeight2D():void {
			clearOutput();
			player.soulforce -= 300;
			outputText("\n\nWhoa wait did you just lost some height!? You indeed notice you've shrunk by two inches.");
			player.tallness -= 2;
			if (player.tallness < 42) player.tallness = 42;
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

		public static function permMetamorph (genMem: *): void {
			PermanentMemoryStorage[genMem.id] = true;
			player.ascensionPerkPoints -= genMem.permCost || 5;
		}
	}
}