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

		public function stateObjectName():String {
			return "GeneticMemoryStorage";
		}

		public function resetState():void {
			GeneticMemoryStorage = {};

			// Basic human parts, unlocked from the start
			/*
				*/
				GeneticMemoryStorage["Human Hair"] = true;
				GeneticMemoryStorage["Human Face"] = true;
				GeneticMemoryStorage["Human Eyes"] = true;
				GeneticMemoryStorage["Human Tongue"] = true;
				GeneticMemoryStorage["Human Ears"] = true;
				GeneticMemoryStorage["Human Arms"] = true;
				GeneticMemoryStorage["Human Lower Body"] = true;
				GeneticMemoryStorage["No Horns"] = true;
				GeneticMemoryStorage["No Wings"] = true;
				GeneticMemoryStorage["Plain Skin"] = true;
				GeneticMemoryStorage["No Skin Pattern"] = true;
				GeneticMemoryStorage["No Antennae"] = true;
				GeneticMemoryStorage["No Gills"] = true;
				GeneticMemoryStorage["No Rear Body"] = true;
				GeneticMemoryStorage["No Tail"] = true;
				/*
			*/
		}

		public function saveToObject():Object {
			return {
				"storage": GeneticMemoryStorage
			};
		}

		public function loadFromObject(o:Object, ignoreErrors:Boolean):void {
			if (o) {
				GeneticMemoryStorage = Utils.copyObject({}, o["storage"]);

				GeneticMemoryStorage = {};
				var storage:* = o["storage"];
				for (var k:String in storage) {
    			if (storage.hasOwnProperty(k)) GeneticMemoryStorage[k] = !!storage[k];
				}
			} else {
				// Migration from old save

				resetState();
			}

				// TODO: Move migration inside else after finished
				// migration

				// Basic human parts, unlocked from the start
				GeneticMemoryStorage["Human Hair"] = true;
				GeneticMemoryStorage["Human Face"] = true;
				GeneticMemoryStorage["Human Eyes"] = true;
				GeneticMemoryStorage["Human Tongue"] = true;
				GeneticMemoryStorage["Human Ears"] = true;
				GeneticMemoryStorage["Human Arms"] = true;
				GeneticMemoryStorage["Human Lower Body"] = true;
				GeneticMemoryStorage["No Horns"] = true;
				GeneticMemoryStorage["No Wings"] = true;
				GeneticMemoryStorage["Plain Skin"] = true;
				GeneticMemoryStorage["No Skin Pattern"] = true;
				GeneticMemoryStorage["No Antennae"] = true;
				GeneticMemoryStorage["No Gills"] = true;
				GeneticMemoryStorage["No Rear Body"] = true;
				GeneticMemoryStorage["No Tail"] = true;

				// Converting Unlocked flags into Genetic Memory Storage
				/*
					*/
					if (player.hasStatusEffect(StatusEffects.UnlockedHumanHair)) GeneticMemoryStorage["Human Hair"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedHarpyHair)) GeneticMemoryStorage["Feather Hair"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedGorgonHair)) GeneticMemoryStorage["Gorgon Hair"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedElfHair)) GeneticMemoryStorage["Silky Hair"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedRaijuHair)) GeneticMemoryStorage["Storm Hair"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedHellcatBurningHair)) GeneticMemoryStorage["Burning Hair"] = true;

					if (player.hasStatusEffect(StatusEffects.UnlockedHumanFace)) GeneticMemoryStorage["Human Face"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedHorseFace)) GeneticMemoryStorage["Horse Face"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedCowMinotaurFace)) GeneticMemoryStorage["Cow Minotaur Face"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedSharkTeeth)) GeneticMemoryStorage["Shark Teeth Face"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedSnakeFangs)) GeneticMemoryStorage["Snake Fangs Face"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedCatFace)) GeneticMemoryStorage["Cat Face"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedCatFangs)) GeneticMemoryStorage["Cat Canines Face"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedLizardFace)) GeneticMemoryStorage["Lizard Face"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedSpiderFangs)) GeneticMemoryStorage["Spider Fangs Face"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedFoxFace)) GeneticMemoryStorage["Fox Face"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedPigFace)) GeneticMemoryStorage["Pig Face"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedBoarFace)) GeneticMemoryStorage["Boar Face"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedManticoreFace)) GeneticMemoryStorage["Manticore Face"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedSalamanderFace)) GeneticMemoryStorage["Salamander Fangs Face"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedOrcaFace)) GeneticMemoryStorage["Orca Face"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedDraconicFace)) GeneticMemoryStorage["Draconic Face"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedDraconicFangs)) GeneticMemoryStorage["Draconic Fangs Face"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedDevilFangs)) GeneticMemoryStorage["Devil Fangs Face"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedOniFace)) GeneticMemoryStorage["Oni Teeth Face"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedRaijuFace)) GeneticMemoryStorage["Weasel Face"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedVampireFace)) GeneticMemoryStorage["Vampire Face"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedRedPandaFace)) GeneticMemoryStorage["Red Panda Face"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedCheshireFace)) GeneticMemoryStorage["Cheshire Face"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedCheshireSmile)) GeneticMemoryStorage["Cheshire Smile Face"] = true;

					if (player.hasStatusEffect(StatusEffects.UnlockedHumanEyes)) GeneticMemoryStorage["Human Eyes"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedSpiderFourEyes)) GeneticMemoryStorage["Spider Eyes"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedCatEyes)) GeneticMemoryStorage["Cat Eyes"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedGorgonEyes)) GeneticMemoryStorage["Gorgon Eyes"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedManticoreEyes)) GeneticMemoryStorage["Manticore Eyes"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedFoxEyes)) GeneticMemoryStorage["Fox Eyes"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedLizardEyes)) GeneticMemoryStorage["Lizard Eyes"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedSnakeEyes)) GeneticMemoryStorage["Snake Eyes"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedDraconicEyes)) GeneticMemoryStorage["Draconic Eyes"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedDevilEyes)) GeneticMemoryStorage["Devil Eyes"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedOniEyes)) GeneticMemoryStorage["Oni Eyes"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedElfEyes)) GeneticMemoryStorage["Elf Eyes"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedRaijuEyes)) GeneticMemoryStorage["Raiju Eyes"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedVampireEyes)) GeneticMemoryStorage["Vampire Eyes"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedHellcatInfernalEyes)) GeneticMemoryStorage["Infernal Eyes"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedOrcEyes)) GeneticMemoryStorage["Orc Eyes"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedDisplacerEyes)) GeneticMemoryStorage["Displacer Eyes"] = true;

					if (player.hasStatusEffect(StatusEffects.UnlockedHumanTongue)) GeneticMemoryStorage["Human Tongue"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedSnakeTongue)) GeneticMemoryStorage["Snake Tongue"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedDemonTonuge)) GeneticMemoryStorage["Demonic Tongue"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedDraconicTongue)) GeneticMemoryStorage["Draconic Tongue"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedCatTongue)) GeneticMemoryStorage["Cat Tongue"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedElfTongue)) GeneticMemoryStorage["Elf Tongue"] = true;

					if (player.hasStatusEffect(StatusEffects.UnlockedHumanEars)) GeneticMemoryStorage["Human Ears"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedHorseEars)) GeneticMemoryStorage["Horse Ears"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedCowEars)) GeneticMemoryStorage["Cow Ears"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedElfinEars)) GeneticMemoryStorage["Elfin Ears"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedCatEars)) GeneticMemoryStorage["Cat Ears"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedLizardEars)) GeneticMemoryStorage["Lizard Ears"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedFoxEars)) GeneticMemoryStorage["Fox Ears"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedDraconicEars)) GeneticMemoryStorage["Draconic Ears"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedPigEars)) GeneticMemoryStorage["Pig Ears"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedLionEars)) GeneticMemoryStorage["Lion Ears"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedOrcaEars)) GeneticMemoryStorage["Orca Ears"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedSnakeEars)) GeneticMemoryStorage["Snake Ears"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedGoatEars)) GeneticMemoryStorage["Goat Ears"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedOniEars)) GeneticMemoryStorage["Oni Ears"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedElfEars)) GeneticMemoryStorage["Elven Ears"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedRaijuEars)) GeneticMemoryStorage["Weasel Ears"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedBatEars)) GeneticMemoryStorage["Bat Ears"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedVampireEars)) GeneticMemoryStorage["Vampire Ears"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedRedPandaEars)) GeneticMemoryStorage["Red Panda Ears"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedDisplacerEars)) GeneticMemoryStorage["Displacer Ears"] = true;

					if (player.hasStatusEffect(StatusEffects.UnlockedHumanNoHorns)) GeneticMemoryStorage["No Horns"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedDemonHorns)) GeneticMemoryStorage["Demon Horns"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedCowMinotaurHorns)) GeneticMemoryStorage["Cow Minotaur Horns"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedDraconicX2)) GeneticMemoryStorage["Draconic Dual Horns"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedDraconicX4)) GeneticMemoryStorage["Draconic Quadruple Horns"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedGoatHorns)) GeneticMemoryStorage["Goat Horns"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedUnicornHorn)) GeneticMemoryStorage["Unicorn Horn"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedOniSingleHorn)) GeneticMemoryStorage["Oni Horn"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedOniTwinHorns)) GeneticMemoryStorage["Oni Dual Horns"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedBicornHorns)) GeneticMemoryStorage["Bicorn Horns"] = true;

					if (player.hasStatusEffect(StatusEffects.UnlockedHumanArms)) GeneticMemoryStorage["Human Arms"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedHarpyArms)) GeneticMemoryStorage["Harpy Arms"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedSpiderArms)) GeneticMemoryStorage["Spider Arms"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedMantisArms)) GeneticMemoryStorage["Mantis Arms"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedBeeArms)) GeneticMemoryStorage["Bee Arms"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedSalamanderArms)) GeneticMemoryStorage["Salamander Arms"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedPhoenixArms)) GeneticMemoryStorage["Phoenix Arms"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedSharkArms)) GeneticMemoryStorage["Shark Arms"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedLionArms)) GeneticMemoryStorage["Lion Arms"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedFoxArms)) GeneticMemoryStorage["Fox Arms"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedKitsuneArms)) GeneticMemoryStorage["Kitsune Arms"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedLizardArms)) GeneticMemoryStorage["Lizard Arms"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedDraconicArms)) GeneticMemoryStorage["Draconic Arms"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedOrcaArms)) GeneticMemoryStorage["Orca Arms"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedDevilArms)) GeneticMemoryStorage["Devil Arms"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedOniArms)) GeneticMemoryStorage["Oni Arms"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedElfArms)) GeneticMemoryStorage["Elf Arms"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedRaijuArms)) GeneticMemoryStorage["Raiju Arms"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedRedPandaArms)) GeneticMemoryStorage["Red Panda Arms"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedCatArms)) GeneticMemoryStorage["Cat Arms"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedSphinxArms)) GeneticMemoryStorage["Sphinx Arms"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedPigArms)) GeneticMemoryStorage["Pig Arms"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedBoarArms)) GeneticMemoryStorage["Boar Arms"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedOrcArms)) GeneticMemoryStorage["Orc Arms"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedDisplacerArms)) GeneticMemoryStorage["Displacer Arms"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedRaijuArms2)) GeneticMemoryStorage["Raiju Paws Arms"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedBatWings)) GeneticMemoryStorage["Bat Wing Arms"] = true;

					if (player.hasStatusEffect(StatusEffects.UnlockedHumanNoWings)) GeneticMemoryStorage["No Wings"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedBeeWingsSmall)) GeneticMemoryStorage["Bee Small Wings"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedBeeWingsLarge)) GeneticMemoryStorage["Bee Large Wings"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedDemonTinyBatWings)) GeneticMemoryStorage["Demonic Tiny Wings"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedDemonLargeBatWings)) GeneticMemoryStorage["Demonic Large Wings"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedDemonLargeBatWings2)) GeneticMemoryStorage["Demonic Large Quadruple Wings"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedHarpyWings)) GeneticMemoryStorage["Feathered Large Wings"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedDraconicWingsSmall)) GeneticMemoryStorage["Draconic Small Wings"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedDraconicWingsLarge)) GeneticMemoryStorage["Draconic Large Wings"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedDraconicWingsHuge)) GeneticMemoryStorage["Draconic Huge Wings"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedPhoenixWings)) GeneticMemoryStorage["Feathered Phoenix Wings"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedAlicornWings)) GeneticMemoryStorage["Feathered Alicorn Wings"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedMantisWingsSmall)) GeneticMemoryStorage["Mantis Small Wings"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedMantisWingsLarge)) GeneticMemoryStorage["Mantis Large Wings"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedManticoreWingsSmall)) GeneticMemoryStorage["Manticore Small Wings"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedManticoreWingsLarge)) GeneticMemoryStorage["Manticore Large Wings"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedVampireWings)) GeneticMemoryStorage["Vampire Wings"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedNightmareWings)) GeneticMemoryStorage["Nightmare Wings"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedSphinxWings)) GeneticMemoryStorage["Feathered Sphinx Wings"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedRaijuThunderousAura)) GeneticMemoryStorage["Thunderous Aura (Wings)"] = true;

					if (player.hasStatusEffect(StatusEffects.UnlockedHumanSkin)) GeneticMemoryStorage["Plain Skin"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedFur)) GeneticMemoryStorage["Fur Skin"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedScales)) GeneticMemoryStorage["Scales Skin"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedChitin)) GeneticMemoryStorage["Chitin Skin"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedDragonScales)) GeneticMemoryStorage["Dragon Scales Skin"] = true;

					if (player.hasStatusEffect(StatusEffects.UnlockedHumanNoSkinPattern)) GeneticMemoryStorage["No Skin Pattern"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedTattoed)) GeneticMemoryStorage["Kitsune Skin Pattern"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedBattleTattoed)) GeneticMemoryStorage["Oni Skin Pattern"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedLightningTattoed)) GeneticMemoryStorage["Raiju Skin Pattern"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedScarTattoed)) GeneticMemoryStorage["Orc Skin Pattern"] = true;

					if (player.hasStatusEffect(StatusEffects.UnlockedHumanNoAntennae)) GeneticMemoryStorage["No Antennae"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedMantisAntennae)) GeneticMemoryStorage["Mantis Antennae"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedBeeAntennae)) GeneticMemoryStorage["Bee Antennae"] = true;

					if (player.hasStatusEffect(StatusEffects.UnlockedHumanNoGills)) GeneticMemoryStorage["No Gills"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedFishGills)) GeneticMemoryStorage["Fish Gills"] = true;

					if (player.hasStatusEffect(StatusEffects.UnlockedHumanNoRearBody)) GeneticMemoryStorage["No Rear Body"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedLionMane)) GeneticMemoryStorage["Lion Mane Rear Body"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedSharkFin)) GeneticMemoryStorage["Shark Fin Rear Body"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedOrcaBlowhole)) GeneticMemoryStorage["Orca Blowhole Rear Body"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedRaijuMane)) GeneticMemoryStorage["Raiju Mane Rear Body"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedBatCollar)) GeneticMemoryStorage["Bat Collar Rear Body"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedDisplacerBTentacles)) GeneticMemoryStorage["Displacer Tentacles Rear Body"] = true;

					if (player.hasStatusEffect(StatusEffects.UnlockedHumanNoTail)) GeneticMemoryStorage["No Tail"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedHorseTail)) GeneticMemoryStorage["Horse Tail"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedDemonTail)) GeneticMemoryStorage["Demonic Tail"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedCowTail)) GeneticMemoryStorage["Cow Tail"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedSpiderTail)) GeneticMemoryStorage["Spider Tail"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedBeeTail)) GeneticMemoryStorage["Bee Tail"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedSharkTail)) GeneticMemoryStorage["Shark Tail"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedLizardTail)) GeneticMemoryStorage["Lizard Tail"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedHarpyTail)) GeneticMemoryStorage["Harpy Tail"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedDraconicTail)) GeneticMemoryStorage["Draconic Tail"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedPigTail)) GeneticMemoryStorage["Pig Tail"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedScorpionTail)) GeneticMemoryStorage["Scorpion Tail"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedManticoreTail)) GeneticMemoryStorage["Manticore Tail"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedGoatTail)) GeneticMemoryStorage["Goat Tail"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedSalamanderTail)) GeneticMemoryStorage["Salamander Tail"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedMantisTail)) GeneticMemoryStorage["Mantis Tail"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedOrcaTail)) GeneticMemoryStorage["Orca Tail"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedRaijuTail)) GeneticMemoryStorage["Raiju Tail"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedRedPandaTail)) GeneticMemoryStorage["Red Panda Tail"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedHellcatBurningTail)) GeneticMemoryStorage["Burning Tail"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedCatTail)) GeneticMemoryStorage["Cat Tail"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedNekomataForkedTail1)) GeneticMemoryStorage["Forked 1/3 Tail"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedNekomataForkedTail2)) GeneticMemoryStorage["Forked 2/3 Tail"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedCatTail2nd)) GeneticMemoryStorage["Cat 2nd Tail"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedFoxTail)) GeneticMemoryStorage["Fox Tail"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedFoxTail2nd)) GeneticMemoryStorage["Fox 2nd Tail"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedFoxTail3rd)) GeneticMemoryStorage["Fox 3rd Tail"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedFoxTail4th)) GeneticMemoryStorage["Fox 4th Tail"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedFoxTail5th)) GeneticMemoryStorage["Fox 5th Tail"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedFoxTail6th)) GeneticMemoryStorage["Fox 6th Tail"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedFoxTail7th)) GeneticMemoryStorage["Fox 7th Tail"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedFoxTail8th)) GeneticMemoryStorage["Fox 8th Tail"] = true;
					if (player.hasStatusEffect(StatusEffects.UnlockedFoxTail9th)) GeneticMemoryStorage["Fox 9th Tail"] = true;
					/*
				*/

				// Previous code didn't unlock more than 2 tails forEnlightened Kitsunes, migration fix
				/*
					*/
					if (player.hasPerk(PerkLib.EnlightenedKitsune) || player.hasPerk(PerkLib.CorruptedKitsune)) {
						GeneticMemoryStorage["Fox Tail"] = true;
						GeneticMemoryStorage["Fox 2nd Tail"] = true;
						GeneticMemoryStorage["Fox 3rd Tail"] = true;
						GeneticMemoryStorage["Fox 4th Tail"] = true;
						GeneticMemoryStorage["Fox 5th Tail"] = true;
						GeneticMemoryStorage["Fox 6th Tail"] = true;
						GeneticMemoryStorage["Fox 7th Tail"] = true;
					}

					if (player.hasPerk(PerkLib.EnlightenedNinetails) || player.hasPerk(PerkLib.CorruptedNinetails)) {
						GeneticMemoryStorage["Fox 8th Tail"] = true;
						GeneticMemoryStorage["Fox 9th Tail"] = true;
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

		public function Metamorph() {
			Saves.registerSaveableState(this);
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
			outputText("What kind of horns do you want?");

			openPaginatedMenu(title, accessHornsMenu, currentPage, HornsMem.Memories);
		}

		private function accessHairMenu(currentPage: int = 0): void {
			const title: String = "<font size=\"36\" face=\"Georgia\"><u>Soulforce Metamorph - Hair</u></font>\n";

			clearOutput();
			outputText(title);
			// TODO: Add to all appearances are refactored
			// outputText(Hair.getAppearanceDescription(player));
			// outputText("\n\nYou wonder about changing it. In that case, what kind of hair would you like instead?");
			outputText("What kind of hair do you want?");

			openPaginatedMenu(title, accessLowerBodyMenu, currentPage, HairMem.Memories);
		}

		private function accessFaceMenu(currentPage: int = 0): void {
			const title: String = "<font size=\"36\" face=\"Georgia\"><u>Soulforce Metamorph - Face</u></font>\n";

			clearOutput();
			outputText(title);
			outputText("What kind of face do you want?");

			openPaginatedMenu(title, accessFaceMenu, currentPage, FaceMem.Memories);
		}

		private function accessEyesMenu(currentPage: int = 0): void {
			const title: String = "<font size=\"36\" face=\"Georgia\"><u>Soulforce Metamorph - Eyes</u></font>\n";

			clearOutput();
			outputText(title);
			outputText("What kind of eyes do you want?");

			openPaginatedMenu(title, accessEyesMenu, currentPage, EyesMem.Memories);
		}

		private function accessTongueMenu(currentPage: int = 0): void {
			const title: String = "<font size=\"36\" face=\"Georgia\"><u>Soulforce Metamorph - Tongue</u></font>\n";

			clearOutput();
			outputText(title);
			outputText("What kind of tongue do you want?");

			openPaginatedMenu(title, accessTongueMenu, currentPage, TongueMem.Memories);
		}

		private function accessEarsMenu(currentPage: int = 0): void {
			const title: String = "<font size=\"36\" face=\"Georgia\"><u>Soulforce Metamorph - Ears</u></font>\n";

			clearOutput();
			outputText(title);
			outputText("What kind of ears do you want?");

			openPaginatedMenu(title, accessEarsMenu, currentPage, EarsMem.Memories);
		}

		private function accessArmsMenu(currentPage: int = 0): void {
			const title: String = "<font size=\"36\" face=\"Georgia\"><u>Soulforce Metamorph - Arms</u></font>\n";

			clearOutput();
			outputText(title);
			outputText("What kind of arms do you want?");

			openPaginatedMenu(title, accessArmsMenu, currentPage, ArmsMem.Memories);
		}

		private function accessWingsMenu(currentPage: int = 0): void {
			const title: String = "<font size=\"36\" face=\"Georgia\"><u>Soulforce Metamorph - Wings</u></font>\n";

			clearOutput();
			outputText(title);
			outputText("What kind of wings do you want?");

			openPaginatedMenu(title, accessWingsMenu, currentPage, WingsMem.Memories);
		}

		private function accessLowerBodyMenu(currentPage: int = 0): void {
			const title: String = "<font size=\"36\" face=\"Georgia\"><u>Soulforce Metamorph - Lower Body</u></font>\n";

			clearOutput();
			outputText(title);
			outputText("What kind of lower body do you want?");

			openPaginatedMenuOld(title, accessLowerBodyMenu, currentPage, LowerBody.Types, LowerBody.Types[player.lowerBody], LowerBody.getTFDescription);
		}

		private function accessSkinMenu(currentPage: int = 0): void {
			const title: String = "<font size=\"36\" face=\"Georgia\"><u>Soulforce Metamorph - Skin</u></font>\n";

			clearOutput();
			outputText(title);
			outputText("How do you want to change your skin?");

			openPaginatedSkinMenu(title, currentPage);
		}

		private function accessRearBodyMenu(currentPage: int = 0): void {
			const title: String = "<font size=\"36\" face=\"Georgia\"><u>Soulforce Metamorph - Rear Body</u></font>\n";

			clearOutput();
			outputText(title);
			outputText("What kind of rear body do you want?");

			openPaginatedMenu(title, accessRearBodyMenu, currentPage, RearBodyMem.Memories);
		}

		private function accessAntennaeMenu(currentPage: int = 0): void {
			const title: String = "<font size=\"36\" face=\"Georgia\"><u>Soulforce Metamorph - Antennae</u></font>\n";

			clearOutput();
			outputText(title);
			outputText("What kind of antennae do you want?");

			openPaginatedMenu(title, accessAntennaeMenu, currentPage, AntennaeMem.Memories);
		}

		private function accessSkinPatternsMenu(currentPage: int = 0): void {
			const title: String = "<font size=\"36\" face=\"Georgia\"><u>Soulforce Metamorph - Skin Patterns</u></font>\n";

			clearOutput();
			outputText(title);
			outputText("What kind of skin patterns do you want?");

			openPaginatedMenu(title, accessSkinPatternsMenu, currentPage, SkinPatternMem.Memories);
		}

		private function accessGillsMenu(currentPage: int = 0): void {
			const title: String = "<font size=\"36\" face=\"Georgia\"><u>Soulforce Metamorph - Gills</u></font>\n";

			clearOutput();
			outputText(title);
			outputText("What kind of gills do you want?");

			openPaginatedMenu(title, accessGillsMenu, currentPage, GillsMem.Memories);
		}

		private function accessTailMenu(currentPage: int = 0): void {
			const title: String = "<font size=\"36\" face=\"Georgia\"><u>Soulforce Metamorph - Tail</u></font>\n";

			clearOutput();
			outputText(title);
			outputText("What kind of tail do you want?");

			openPaginatedMenu(title, accessTailMenu, currentPage, TailMem.Memories);
		}

		private function openPaginatedMenuOld (title: String, thisMenu: *, currentPage: int, partsArray:Array, currentPart: *, getTFDescription: *): void {
			menu();

			var partsList: Array = [];

			// Removing empty slots
			for each (var part: * in partsArray) {
				if (part && part.metamorphFlag) {
					partsList.push(part);
				}
			}

			const partsPerPage: int = partsList.length > 14 ? 12 : 14;

			const lastPage: int = Math.ceil(partsList.length/partsPerPage) - 1;

			const pageParts: Array = partsList.slice(currentPage * partsPerPage, (currentPage * partsPerPage) + partsPerPage);

			var currentButton: int = 0;

			for each (var bodyPart: * in pageParts) {
				if (bodyPart.metamorphFlag) {
					const buttonStr: String = bodyPart.metamorphTitle || "";

					const unlocked: Boolean = player.hasStatusEffect(bodyPart.metamorphFlag);
					const isPossible: Boolean = currentPart === bodyPart;
					const enoughSF: Boolean = player.soulforce >= bodyPart.metamorphCost;

					if (unlocked && !isPossible && enoughSF) addButton(currentButton, buttonStr, doMetamorph, title, bodyPart, getTFDescription);
					else if (unlocked && isPossible) addButtonDisabled(currentButton, buttonStr, "You already have this body part.");
					else if (unlocked && !isPossible && enoughSF) addButtonDisabled(currentButton, buttonStr, "You don't have enough Soulforce for this metamorphosis!");
					else if (!unlocked) addButtonDisabled(currentButton, "???", "You haven't unlocked this metamorphosis yet!");
					currentButton++;
				}
			}

			if (lastPage > 0) {
				if (currentPage > 0) addButton(12, "Prev Page", thisMenu, currentPage - 1);
				else addButtonDisabled (12, "Prev Page");
				if (currentPage < lastPage) addButton(13, "Next Page", thisMenu, currentPage + 1);
				else addButtonDisabled (13, "Next Page");
			}

			addButton(14, "Back", accessMetamorphMenu);
		}

		private function openPaginatedMenu (title: String, thisMenu: *, currentPage: int, memArray:Array): void {
			menu();

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
				const buttonStr: String = genMem.metamorphTitle || "";
				const unlocked: Boolean = GeneticMemoryStorage[genMem.name];
				const partsInUse: Boolean = genMem.transformation().isPresent();
				const enoughSF: Boolean = player.soulforce >= genMem.metamorphCost;

				if (unlocked && !partsInUse && enoughSF) addButton(currentButton, buttonStr, doMetamorph, title, genMem).hint("Cost: " + genMem.metamorphCost + " SF" + (genMem.info ? "\n\n" + genMem.info : ""));
				else if (unlocked && partsInUse) addButtonDisabled(currentButton, buttonStr, "You already have this, the metamorphosis would have no effect!");
				else if (unlocked && !partsInUse && !enoughSF) addButtonDisabled(currentButton, buttonStr, "Cost: " + genMem.metamorphCost + " SF (You don't have enough Soulforce for this metamorphosis!)");
				else if (!unlocked) addButtonDisabled(currentButton, "???", "You haven't unlocked this metamorphosis yet!");
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
			player.soulforce -= genMem.metamorphCost;
			CoC.instance.mainViewManager.updateCharviewIfNeeded();
			doNext(accessMetamorphMenu);
		}

		private function openPaginatedSkinMenu (title: String, currentPage: int): void {
			menu();

			const memArray: Array = SkinMem.Memories;

			const memsPerPage: int = memArray.length > 14 ? 12 : 14;

			const lastPage: int = Math.ceil(memArray.length/memsPerPage) - 1;

			const pageMems: Array = memArray.slice(currentPage * memsPerPage, (currentPage * memsPerPage) + memsPerPage);

			var currentButton: int = 0;

			for each (var genMem: * in pageMems) {
				const buttonStr: String = genMem.metamorphTitle || "";
				const unlocked: Boolean = GeneticMemoryStorage[genMem.name];
				const enoughSF: Boolean = player.soulforce >= genMem.metamorphCost;

				if (!genMem.transformationFunc) {
					const partsInUse: Boolean = genMem.transformation().isPresent();
					if (unlocked && !partsInUse && enoughSF) addButton(currentButton, buttonStr, doMetamorph, title, genMem).hint("Cost: " + genMem.metamorphCost + " SF");
					else if (unlocked && partsInUse) addButtonDisabled(currentButton, buttonStr, "You already have this, the metamorphosis would have no effect!");
					else if (unlocked && !partsInUse && !enoughSF) addButtonDisabled(currentButton, buttonStr, "Cost: " + genMem.metamorphCost + " SF (You don't have enough Soulforce for this metamorphosis!)");
					else if (!unlocked) addButtonDisabled(currentButton, "???", "You haven't unlocked this metamorphosis yet!");
					currentButton++;
				} else {
					if (unlocked) addButton(currentButton, buttonStr, openCoverageMenu, genMem);
					else if (!unlocked) addButtonDisabled(currentButton, "???", "You haven't unlocked this metamorphosis yet!");
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
			outputText("<font size=\"36\" face=\"Georgia\"><u>Soulforce Metamorph - " + genMem.name.split(" Skin")[0] + " Coverage</u></font>\n");
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
					const cost: int = genMem.metamorphCost * (coverages.indexOf(coverage) + 1);
					const enoughSF: Boolean = player.soulforce >= cost;
					const inEffect: Boolean = genMem.transformationFunc(coverage.value).isPresent();

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
			outputText("<font size=\"36\" face=\"Georgia\"><u>Soulforce Metamorph - " + genMem.name.split(" Skin")[0] + "</u></font>\n");

			genMem.transformationFunc(coverage).applyEffect();
			player.soulforce -= cost;
			CoC.instance.mainViewManager.updateCharviewIfNeeded();
			doNext(accessMetamorphMenu);
		}

		public static function unlockMetamorph (genMemName: String): void {
			if (!GeneticMemoryStorage[genMemName] && player.hasPerk(PerkLib.GeneticMemory)) {
				GeneticMemoryStorage[genMemName] = true;
				if (player.hasPerk(PerkLib.Metamorph)) outputText("\n\n<b>Genetic Memory Obtained: " + genMemName + "</b>");
			}
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
	}
}
