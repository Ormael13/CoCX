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
				// loading from old save
				resetState();
			}

				// resetState();

				// GeneticMemoryStorage["Human Hair"] = true;
				// GeneticMemoryStorage["Storm Hair"] = true;
				// GeneticMemoryStorage["Human Face"] = true;
				// GeneticMemoryStorage["Human Tongue"] = true;
				// GeneticMemoryStorage["Vampire Face"] = true;
				// GeneticMemoryStorage["Vampire Eyes"] = true;
				// GeneticMemoryStorage["Fox Eyes"] = true;
				// GeneticMemoryStorage["Elf Tongue"] = true;

				// TODO: Move migration inside else after finished
				// migration

				GeneticMemoryStorage["Human Hair"] = true;
				GeneticMemoryStorage["Human Face"] = true;
				GeneticMemoryStorage["Human Eyes"] = true;
				GeneticMemoryStorage["Human Tongue"] = true;
				GeneticMemoryStorage["Human Ears"] = true;
				GeneticMemoryStorage["Human Arms"] = true;
				GeneticMemoryStorage["No Horns"] = true;
				GeneticMemoryStorage["No Wings"] = true;
				GeneticMemoryStorage["Plain Skin"] = true;

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
		}

		public function Metamorph() {
			Saves.registerSaveableState(this);
		}

		public function accessMetamorphMenu(currentPage: int = 0):void {
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
				},
				{
					name: "Page 3",
					func: accessPage3MetamorphMenu,
					hint: "Skin Patterns/Tattoos, Rear Body, Antennae, Gills, Tail"
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

			openPaginatedMenuOld(title, accessRearBodyMenu, currentPage, RearBody.Types, RearBody.Types[player.rearBody.type], RearBody.getTFDescription);
		}

		private function accessAntennaeMenu(currentPage: int = 0): void {
			const title: String = "<font size=\"36\" face=\"Georgia\"><u>Soulforce Metamorph - Antennae</u></font>\n";

			clearOutput();
			outputText(title);
			outputText("What kind of antennae do you want?");

			openPaginatedMenuOld(title, accessAntennaeMenu, currentPage, Antennae.Types, Antennae.Types[player.antennae.type], Antennae.getTFDescription);
		}

		private function accessSkinPatternsMenu(currentPage: int = 0): void {
			const title: String = "<font size=\"36\" face=\"Georgia\"><u>Soulforce Metamorph - Skin Patterns</u></font>\n";

			clearOutput();
			outputText(title);
			outputText("What kind of skin patterns do you want?");

			openPaginatedMenuOld(title, accessSkinPatternsMenu, currentPage, Skin.PatternTypes, Skin.PatternTypes[player.skin.base.pattern], Skin.getTFDescription);
		}

		private function accessGillsMenu(currentPage: int = 0): void {
			const title: String = "<font size=\"36\" face=\"Georgia\"><u>Soulforce Metamorph - Gills</u></font>\n";

			clearOutput();
			outputText(title);
			outputText("What kind of gills do you want?");

			openPaginatedMenuOld(title, accessGillsMenu, currentPage, Gills.Types, Gills.Types[player.gills.type], Gills.getTFDescription);
		}

		private function accessTailMenu(currentPage: int = 0): void {
			const title: String = "<font size=\"36\" face=\"Georgia\"><u>Soulforce Metamorph - Tail</u></font>\n";

			clearOutput();
			outputText(title);
			outputText("What kind of tail do you want?");

			openPaginatedMenuOld(title, accessTailMenu, currentPage, Tail.Types, Tail.Types[player.tailType], Tail.getTFDescription);
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

			const memsPerPage: int = memArray.length > 14 ? 12 : 14;

			const lastPage: int = Math.ceil(memArray.length/memsPerPage) - 1;

			const pageMems: Array = memArray.slice(currentPage * memsPerPage, (currentPage * memsPerPage) + memsPerPage);

			var currentButton: int = 0;

			for each (var genMem: * in pageMems) {
				const buttonStr: String = genMem.metamorphTitle || "";
				const unlocked: Boolean = GeneticMemoryStorage[genMem.name];
				const partsInUse: Boolean = genMem.transformation().isPresent();
				const enoughSF: Boolean = player.soulforce >= genMem.metamorphCost;

				if (unlocked && !partsInUse && enoughSF) addButton(currentButton, buttonStr, doMetamorph, title, genMem).hint("Cost: " + genMem.metamorphCost + " SF");
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

		private function accessPage3MetamorphMenu():void {
			menu();
			addButton(1, "SkinPat.", accessSkinPatternsMenuOld);
			addButton(2, "Rear B.", accessRearBodyMenuOld);
			addButton(3, "Antennae", accessAntennaeMenuOld);
			addButton(4, "Gills", accessGillsMenuOld);
			addButton(5, "Tail(1)", accessPage1TailMenu);
			addButton(6, "Tail(2)", accessPage2TailMenu);
			addButton(7, "Tail(3)", accessPage3TailMenu);
			addButton(8, "Tail(4)", accessPage4TailMenu);
			addButton(9, "Tail(5)", accessPage5TailMenu);
			addButton(14, "Back", accessMetamorphMenu);
		}
		private function accessSkinPatternsMenuOld():void {
			menu();
			if (player.hasStatusEffect(StatusEffects.UnlockedHumanNoSkinPattern) && player.skin.base.pattern != Skin.PATTERN_NONE && player.soulforce >= 500) addButton(0, "Human", metamorphHumanNoSkinPatterns);
			else if (player.hasStatusEffect(StatusEffects.UnlockedHumanNoSkinPattern) && player.skin.base.pattern == Skin.PATTERN_NONE) addButtonDisabled(0, "Human", "You already have no skin patterns.");
			else if (player.hasStatusEffect(StatusEffects.UnlockedHumanNoSkinPattern) && player.skin.base.pattern != Skin.PATTERN_NONE && player.soulforce < 500) addButtonDisabled(0, "Human", "You do not have enough Soulforce for this metamorphosis.");
			else addButtonDisabled(0, "???", "You have not yet unlocked this metamorphosis!");

			if (player.hasStatusEffect(StatusEffects.UnlockedTattoed) && player.skin.base.pattern != Skin.PATTERN_MAGICAL_TATTOO && player.soulforce >= 100) addButton(1, "Kitsune", metamorphKitsuneSkinPattern);
			else if (player.hasStatusEffect(StatusEffects.UnlockedTattoed) && player.skin.base.pattern == Skin.PATTERN_MAGICAL_TATTOO) addButtonDisabled(1, "Kitsune", "You already have kitsune skin patterns.");
			else if (player.hasStatusEffect(StatusEffects.UnlockedTattoed) && player.skin.base.pattern != Skin.PATTERN_MAGICAL_TATTOO && player.soulforce < 100) addButtonDisabled(1, "Kitsune", "You do not have enough Soulforce for this metamorphosis.");
			else addButtonDisabled(1, "???", "You have not yet unlocked this metamorphosis!");

			if (player.hasStatusEffect(StatusEffects.UnlockedBattleTattoed) && player.skin.base.pattern != Skin.PATTERN_BATTLE_TATTOO && player.soulforce >= 100) addButton(5, "Oni", metamorphOniSkinPattern);
			else if (player.hasStatusEffect(StatusEffects.UnlockedBattleTattoed) && player.skin.base.pattern == Skin.PATTERN_BATTLE_TATTOO) addButtonDisabled(5, "Oni", "You already have oni skin patterns.");
			else if (player.hasStatusEffect(StatusEffects.UnlockedBattleTattoed) && player.skin.base.pattern != Skin.PATTERN_BATTLE_TATTOO && player.soulforce < 100) addButtonDisabled(5, "Oni", "You do not have enough Soulforce for this metamorphosis.");
			else addButtonDisabled(5, "???", "You have not yet unlocked this metamorphosis!");

			if (player.hasStatusEffect(StatusEffects.UnlockedLightningTattoed) && player.skin.base.pattern != Skin.PATTERN_LIGHTNING_SHAPED_TATTOO && player.soulforce >= 100) addButton(7, "Raiju", metamorphRaijuSkinPattern);
			else if (player.hasStatusEffect(StatusEffects.UnlockedLightningTattoed) && player.skin.base.pattern == Skin.PATTERN_LIGHTNING_SHAPED_TATTOO) addButtonDisabled(7, "Raiju", "You already have raiju skin patterns.");
			else if (player.hasStatusEffect(StatusEffects.UnlockedLightningTattoed) && player.skin.base.pattern != Skin.PATTERN_LIGHTNING_SHAPED_TATTOO && player.soulforce < 100) addButtonDisabled(7, "Raiju", "You do not have enough Soulforce for this metamorphosis.");
			else addButtonDisabled(7, "???", "You have not yet unlocked this metamorphosis!");

			if (player.hasStatusEffect(StatusEffects.UnlockedScarTattoed) && player.skin.base.pattern != Skin.PATTERN_SCAR_SHAPED_TATTOO && player.soulforce >= 100) addButton(9, "Orc", metamorphOrcSkinPattern);
			else if (player.hasStatusEffect(StatusEffects.UnlockedScarTattoed) && player.skin.base.pattern == Skin.PATTERN_SCAR_SHAPED_TATTOO) addButtonDisabled(9, "Orc", "You already have orc skin patterns.");
			else if (player.hasStatusEffect(StatusEffects.UnlockedScarTattoed) && player.skin.base.pattern != Skin.PATTERN_SCAR_SHAPED_TATTOO && player.soulforce < 100) addButtonDisabled(9, "Orc", "You do not have enough Soulforce for this metamorphosis.");
			else addButtonDisabled(9, "???", "You have not yet unlocked this metamorphosis!");
			addButton(14, "Back", accessPage3MetamorphMenu);
		}
		private function accessRearBodyMenuOld():void {
			menu();
			if (player.hasStatusEffect(StatusEffects.UnlockedHumanNoRearBody) && player.rearBody.type != RearBody.NONE && player.soulforce >= 500) addButton(0, "Human", metamorphHumanNoRearBody);
			else if (player.hasStatusEffect(StatusEffects.UnlockedHumanNoRearBody) && player.rearBody.type == RearBody.NONE) addButtonDisabled(0, "Human", "You already have human rear body.");
			else if (player.hasStatusEffect(StatusEffects.UnlockedHumanNoRearBody) && player.rearBody.type != RearBody.NONE && player.soulforce < 500) addButtonDisabled(0, "Human", "You do not have enough Soulforce for this metamorphosis.");
			else addButtonDisabled(0, "???", "You have not yet unlocked this metamorphosis!");

			if (player.hasStatusEffect(StatusEffects.UnlockedLionMane) && player.rearBody.type != RearBody.LION_MANE && player.soulforce >= 100) addButton(4, "Lion", metamorphLionMane);
			else if (player.hasStatusEffect(StatusEffects.UnlockedLionMane) && player.rearBody.type == RearBody.LION_MANE) addButtonDisabled(4, "Lion", "You already have lion mane.");
			else if (player.hasStatusEffect(StatusEffects.UnlockedLionMane) && player.rearBody.type != RearBody.LION_MANE && player.soulforce < 100) addButtonDisabled(4, "Lion", "You do not have enough Soulforce for this metamorphosis.");
			else addButtonDisabled(4, "???", "You have not yet unlocked this metamorphosis!");

			if (player.hasStatusEffect(StatusEffects.UnlockedSharkFin) && player.rearBody.type != RearBody.SHARK_FIN && player.soulforce >= 100) addButton(6, "Shark", metamorphSharkFin);
			else if (player.hasStatusEffect(StatusEffects.UnlockedSharkFin) && player.rearBody.type == RearBody.SHARK_FIN) addButtonDisabled(6, "Shark", "You already have shark back fin.");
			else if (player.hasStatusEffect(StatusEffects.UnlockedSharkFin) && player.rearBody.type != RearBody.SHARK_FIN && player.soulforce < 100) addButtonDisabled(6, "Shark", "You do not have enough Soulforce for this metamorphosis.");
			else addButtonDisabled(6, "???", "You have not yet unlocked this metamorphosis!");

			if (player.hasStatusEffect(StatusEffects.UnlockedOrcaBlowhole) && player.rearBody.type != RearBody.ORCA_BLOWHOLE && player.soulforce >= 100) addButton(7, "Orca", metamorphOrcaBlowhole);
			else if (player.hasStatusEffect(StatusEffects.UnlockedOrcaBlowhole) && player.rearBody.type == RearBody.ORCA_BLOWHOLE) addButtonDisabled(7, "Orca", "You already have orca blowhole.");
			else if (player.hasStatusEffect(StatusEffects.UnlockedOrcaBlowhole) && player.rearBody.type != RearBody.ORCA_BLOWHOLE && player.soulforce < 100) addButtonDisabled(7, "Shark", "You do not have enough Soulforce for this metamorphosis.");
			else addButtonDisabled(7, "???", "You have not yet unlocked this metamorphosis!");

			if (player.hasStatusEffect(StatusEffects.UnlockedRaijuMane) && player.rearBody.type != RearBody.RAIJU_MANE && player.soulforce >= 100) addButton(8, "Raiju", metamorphRaijuMane);
			else if (player.hasStatusEffect(StatusEffects.UnlockedRaijuMane) && player.rearBody.type == RearBody.RAIJU_MANE) addButtonDisabled(8, "Raiju", "You already have raiju mane.");
			else if (player.hasStatusEffect(StatusEffects.UnlockedRaijuMane) && player.rearBody.type != RearBody.RAIJU_MANE && player.soulforce < 100) addButtonDisabled(8, "Raiju", "You do not have enough Soulforce for this metamorphosis.");
			else addButtonDisabled(8, "???", "You have not yet unlocked this metamorphosis!");

			if (player.hasStatusEffect(StatusEffects.UnlockedBatCollar) && player.rearBody.type != RearBody.BAT_COLLAR && player.soulforce >= 100) addButton(9, "Bat", metamorphBatCollar);
			else if (player.hasStatusEffect(StatusEffects.UnlockedBatCollar) && player.rearBody.type == RearBody.BAT_COLLAR) addButtonDisabled(9, "Bat", "You already have bat collar.");
			else if (player.hasStatusEffect(StatusEffects.UnlockedBatCollar) && player.rearBody.type != RearBody.BAT_COLLAR && player.soulforce < 100) addButtonDisabled(9, "Bat", "You do not have enough Soulforce for this metamorphosis.");
			else addButtonDisabled(9, "???", "You have not yet unlocked this metamorphosis!");

			if (player.hasStatusEffect(StatusEffects.UnlockedDisplacerBTentacles) && player.rearBody.type != RearBody.DISPLACER_TENTACLES && player.soulforce >= 100) addButton(11, "Displacer", metamorphDisplacerBackTentacles);
			else if (player.hasStatusEffect(StatusEffects.UnlockedDisplacerBTentacles) && player.rearBody.type == RearBody.DISPLACER_TENTACLES) addButtonDisabled(11, "Displacer", "You already have displacer beast back tentacles.");
			else if (player.hasStatusEffect(StatusEffects.UnlockedDisplacerBTentacles) && player.rearBody.type != RearBody.DISPLACER_TENTACLES && player.soulforce < 100) addButtonDisabled(11, "Displacer", "You do not have enough Soulforce for this metamorphosis.");
			else addButtonDisabled(11, "???", "You have not yet unlocked this metamorphosis!");
			addButton(14, "Back", accessPage3MetamorphMenu);
		}
		private function accessAntennaeMenuOld():void {
			menu();
			if (player.hasStatusEffect(StatusEffects.UnlockedMantisAntennae) && player.antennae.type != Antennae.NONE && player.soulforce >= 500) addButton(0, "Human", metamorphHumanNoAntennae);
			else if (player.hasStatusEffect(StatusEffects.UnlockedMantisAntennae) && player.antennae.type == Antennae.NONE) addButtonDisabled(0, "Human", "You already have no antennaes.");
			else if (player.hasStatusEffect(StatusEffects.UnlockedMantisAntennae) && player.antennae.type != Antennae.NONE && player.soulforce < 500) addButtonDisabled(0, "Human", "You do not have enough Soulforce for this metamorphosis.");
			else addButtonDisabled(0, "???", "You have not yet unlocked this metamorphosis!");

			if (player.hasStatusEffect(StatusEffects.UnlockedMantisAntennae) && player.antennae.type != Antennae.MANTIS && player.soulforce >= 100) addButton(1, "Mantis", metamorphMantisAntennae);
			else if (player.hasStatusEffect(StatusEffects.UnlockedMantisAntennae) && player.antennae.type == Antennae.MANTIS) addButtonDisabled(1, "Mantis", "You already have mantis antennaes.");
			else if (player.hasStatusEffect(StatusEffects.UnlockedMantisAntennae) && player.antennae.type != Antennae.MANTIS && player.soulforce < 100) addButtonDisabled(1, "Mantis", "You do not have enough Soulforce for this metamorphosis.");
			else addButtonDisabled(1, "???", "You have not yet unlocked this metamorphosis!");

			if (player.hasStatusEffect(StatusEffects.UnlockedBeeAntennae) && player.antennae.type != Antennae.BEE && player.soulforce >= 100) addButton(2, "Bee", metamorphBeeAntennae);
			else if (player.hasStatusEffect(StatusEffects.UnlockedBeeAntennae) && player.antennae.type == Antennae.BEE) addButtonDisabled(2, "Bee", "You already have bee antennaes.");
			else if (player.hasStatusEffect(StatusEffects.UnlockedBeeAntennae) && player.antennae.type != Antennae.BEE && player.soulforce < 100) addButtonDisabled(2, "Bee", "You do not have enough Soulforce for this metamorphosis.");
			else addButtonDisabled(2, "???", "You have not yet unlocked this metamorphosis!");
			addButton(14, "Back", accessPage3MetamorphMenu);
		}
		private function accessGillsMenuOld():void {
			menu();
			if (player.hasStatusEffect(StatusEffects.UnlockedFishGills) && player.gills.type != Gills.NONE && player.soulforce >= 500) addButton(0, "Human", metamorphHumanNoGills);
			else if (player.hasStatusEffect(StatusEffects.UnlockedFishGills) && player.gills.type == Gills.NONE) addButtonDisabled(0, "Human", "You already have no gills.");
			else if (player.hasStatusEffect(StatusEffects.UnlockedFishGills) && player.gills.type != Gills.NONE && player.soulforce < 500) addButtonDisabled(0, "Human", "You do not have enough Soulforce for this metamorphosis.");
			else addButtonDisabled(0, "???", "You have not yet unlocked this metamorphosis!");

			if (player.hasStatusEffect(StatusEffects.UnlockedFishGills) && player.gills.type != Gills.FISH && player.soulforce >= 100) addButton(2, "Fish", metamorphFishGills);
			else if (player.hasStatusEffect(StatusEffects.UnlockedFishGills) && player.gills.type == Gills.FISH) addButtonDisabled(2, "Fish", "You already have fish gills.");
			else if (player.hasStatusEffect(StatusEffects.UnlockedFishGills) && player.gills.type != Gills.FISH && player.soulforce < 100) addButtonDisabled(2, "Fish", "You do not have enough Soulforce for this metamorphosis.");
			else addButtonDisabled(2, "???", "You have not yet unlocked this metamorphosis!");
			addButton(14, "Back", accessPage3MetamorphMenu);
		}
		private function accessPage1TailMenu():void {
			menu();
			if (player.hasStatusEffect(StatusEffects.UnlockedHumanNoTail) && player.tailType != Tail.NONE && player.soulforce >= 500) addButton(0, "Human", metamorphHumanNoTail);
			else if (player.hasStatusEffect(StatusEffects.UnlockedHumanNoTail) && player.tailType == Tail.NONE) addButtonDisabled(0, "Human", "You already not have tail.");
			else if (player.hasStatusEffect(StatusEffects.UnlockedHumanNoTail) && player.tailType != Tail.NONE && player.soulforce < 500) addButtonDisabled(0, "Human", "You do not have enough Soulforce for this metamorphosis.");
			else addButtonDisabled(0, "???", "You have not yet unlocked this metamorphosis!");

			if (player.hasStatusEffect(StatusEffects.UnlockedHorseTail) && player.tailType != Tail.HORSE && player.soulforce >= 100) addButton(1, "Horse", metamorphHorseTail);
			else if (player.hasStatusEffect(StatusEffects.UnlockedHorseTail) && player.tailType == Tail.HORSE) addButtonDisabled(1, "Horse", "You already have horse tail.");
			else if (player.hasStatusEffect(StatusEffects.UnlockedHorseTail) && player.tailType != Tail.HORSE && player.soulforce < 100) addButtonDisabled(1, "Horse", "You do not have enough Soulforce for this metamorphosis.");
			else addButtonDisabled(1, "???", "You have not yet unlocked this metamorphosis!");

			if (player.hasStatusEffect(StatusEffects.UnlockedDemonTail) && player.tailType != Tail.DEMONIC && player.soulforce >= 100) addButton(3, "Demon", metamorphTailDemonic);
			else if (player.hasStatusEffect(StatusEffects.UnlockedDemonTail) && player.tailType == Tail.DEMONIC) addButtonDisabled(3, "Demon", "You already have demon tail.");
			else if (player.hasStatusEffect(StatusEffects.UnlockedDemonTail) && player.tailType != Tail.DEMONIC && player.soulforce < 100) addButtonDisabled(3, "Demon", "You do not have enough Soulforce for this metamorphosis.");
			else addButtonDisabled(3, "???", "You have not yet unlocked this metamorphosis!");

			if (player.hasStatusEffect(StatusEffects.UnlockedCowTail) && player.tailType != Tail.COW && player.soulforce >= 100) addButton(4, "Cow", metamorphCowTail);
			else if (player.hasStatusEffect(StatusEffects.UnlockedCowTail) && player.tailType == Tail.COW) addButtonDisabled(4, "Cow", "You already have cow tail.");
			else if (player.hasStatusEffect(StatusEffects.UnlockedCowTail) && player.tailType != Tail.COW && player.soulforce < 100) addButtonDisabled(4, "Cow", "You do not have enough Soulforce for this metamorphosis.");
			else addButtonDisabled(4, "???", "You have not yet unlocked this metamorphosis!");

			if (player.hasStatusEffect(StatusEffects.UnlockedSpiderTail) && player.tailType != Tail.SPIDER_ADBOMEN && player.soulforce >= 100) addButton(5, "Spider", metamorphSpiderTail);
			else if (player.hasStatusEffect(StatusEffects.UnlockedSpiderTail) && player.tailType == Tail.SPIDER_ADBOMEN) addButtonDisabled(5, "Spider", "You already have spider abdomen.");
			else if (player.hasStatusEffect(StatusEffects.UnlockedSpiderTail) && player.tailType != Tail.SPIDER_ADBOMEN && player.soulforce < 100) addButtonDisabled(5, "Spider", "You do not have enough Soulforce for this metamorphosis.");
			else addButtonDisabled(5, "???", "You have not yet unlocked this metamorphosis!");

			if (player.hasStatusEffect(StatusEffects.UnlockedBeeTail) && player.tailType != Tail.BEE_ABDOMEN && player.soulforce >= 100) addButton(6, "Bee", metamorphBeeTail);
			else if (player.hasStatusEffect(StatusEffects.UnlockedBeeTail) && player.tailType == Tail.BEE_ABDOMEN) addButtonDisabled(6, "Bee", "You already have bee tail.");
			else if (player.hasStatusEffect(StatusEffects.UnlockedBeeTail) && player.tailType != Tail.BEE_ABDOMEN && player.soulforce < 100) addButtonDisabled(6, "Bee", "You do not have enough Soulforce for this metamorphosis.");
			else addButtonDisabled(6, "???", "You have not yet unlocked this metamorphosis!");

			if (player.hasStatusEffect(StatusEffects.UnlockedSharkTail) && player.tailType != Tail.SHARK && player.soulforce >= 100) addButton(7, "Shark", metamorphSharkTail);
			else if (player.hasStatusEffect(StatusEffects.UnlockedSharkTail) && player.tailType == Tail.SHARK) addButtonDisabled(7, "Shark", "You already have shark tail.");
			else if (player.hasStatusEffect(StatusEffects.UnlockedSharkTail) && player.tailType != Tail.SHARK && player.soulforce < 100) addButtonDisabled(7, "Shark", "You do not have enough Soulforce for this metamorphosis.");
			else addButtonDisabled(7, "???", "You have not yet unlocked this metamorphosis!");

			if (player.hasStatusEffect(StatusEffects.UnlockedCatTail) && (player.tailType != Tail.CAT || (player.tailType == Tail.CAT && player.tailCount >= 2)) && player.soulforce >= 100) addButton(8, "Cat", metamorphCatTail);
			else if (player.hasStatusEffect(StatusEffects.UnlockedCatTail) && player.tailType == Tail.CAT && player.tailCount == 1) addButtonDisabled(8, "Cat", "You already have single cat tail.");
			else if (player.hasStatusEffect(StatusEffects.UnlockedCatTail) && player.tailType != Tail.CAT && player.soulforce < 100) addButtonDisabled(8, "Cat", "You do not have enough Soulforce for this metamorphosis.");
			else addButtonDisabled(8, "???", "You have not yet unlocked this metamorphosis!");

			if (player.hasStatusEffect(StatusEffects.UnlockedCatTail2nd) && player.tailType == Tail.NEKOMATA_FORKED_2_3 && player.soulforce >= 400) addButton(9, "Nekomata", metamorphCat2ndTail);
			else if (player.hasStatusEffect(StatusEffects.UnlockedCatTail2nd) && player.tailType == Tail.CAT && player.tailCount >= 2) addButtonDisabled(9, "Nekomata", "You already have twin cat tail.");
			else if (player.hasStatusEffect(StatusEffects.UnlockedCatTail2nd) && player.tailType != Tail.CAT && player.tailCount < 2 && player.soulforce < 400) addButtonDisabled(9, "Nekomata", "You do not have enough Soulforce for this metamorphosis.");
			else if (player.hasStatusEffect(StatusEffects.UnlockedCatTail2nd) && player.tailType != Tail.NEKOMATA_FORKED_2_3) addButtonDisabled(9, "Nekomata", "You do not have proper type of tail for this metamorphosis.");
			else addButtonDisabled(2, "???", "You have not yet unlocked this metamorphosis!");

			if (player.hasStatusEffect(StatusEffects.UnlockedLizardTail) && player.tailType != Tail.LIZARD && player.soulforce >= 100) addButton(10, "Lizard", metamorphLizardTail);
			else if (player.hasStatusEffect(StatusEffects.UnlockedLizardTail) && player.tailType == Tail.LIZARD) addButtonDisabled(10, "Lizard", "You already have lizard tail.");
			else if (player.hasStatusEffect(StatusEffects.UnlockedLizardTail) && player.tailType != Tail.LIZARD && player.soulforce < 100) addButtonDisabled(10, "Lizard", "You do not have enough Soulforce for this metamorphosis.");
			else addButtonDisabled(10, "???", "You have not yet unlocked this metamorphosis!");

			if (player.hasStatusEffect(StatusEffects.UnlockedHarpyTail) && player.tailType != Tail.HARPY && player.soulforce >= 100) addButton(12, "Harpy", metamorphHarpyTail);
			else if (player.hasStatusEffect(StatusEffects.UnlockedHarpyTail) && player.tailType == Tail.HARPY) addButtonDisabled(12, "Harpy", "You already have harpy tail.");
			else if (player.hasStatusEffect(StatusEffects.UnlockedHarpyTail) && player.tailType != Tail.HARPY && player.soulforce < 100) addButtonDisabled(12, "Harpy", "You do not have enough Soulforce for this metamorphosis.");
			else addButtonDisabled(12, "???", "You have not yet unlocked this metamorphosis!");
			addButton(14, "Back", accessPage3MetamorphMenu);
		}
		private function accessPage2TailMenu():void {
			menu();
			if (player.hasStatusEffect(StatusEffects.UnlockedFoxTail) && (player.tailType != Tail.FOX || (player.tailType == Tail.FOX && player.tailCount >= 2)) && player.soulforce >= 100) addButton(0, "Fox", metamorphTailFox);
			else if (player.hasStatusEffect(StatusEffects.UnlockedFoxTail) && player.tailType == Tail.FOX && player.tailCount == 1) addButtonDisabled(0, "Fox", "You already have single fox tail.");
			else if (player.hasStatusEffect(StatusEffects.UnlockedFoxTail) && player.tailType != Tail.FOX && player.soulforce < 100) addButtonDisabled(0, "Fox", "You do not have enough Soulforce for this metamorphosis.");
			else addButtonDisabled(0, "???", "You have not yet unlocked this metamorphosis!");

			if (player.hasStatusEffect(StatusEffects.UnlockedFoxTail2nd) && player.tailType == Tail.FOX && player.tailCount == 1 && player.soulforce >= 200) addButton(1, "Fox 2nd", metamorphTailFox2nd);
			else if (player.hasStatusEffect(StatusEffects.UnlockedFoxTail2nd) && player.tailType == Tail.FOX) {
				if (player.tailCount == 2) addButtonDisabled(1, "Fox 2nd", "You already have two fox tails.");
				else if (player.tailCount == 1 && player.soulforce < 200) addButtonDisabled(1, "Fox 2nd", "You do not have enough Soulforce for this metamorphosis.");
				else addButtonDisabled(1, "Fox 2nd", "You need to have only one fox tail to use this metamophosis.");
			}
			else if (player.hasStatusEffect(StatusEffects.UnlockedFoxTail2nd) && player.tailType != Tail.FOX) {
				if (player.tailCount != 1) addButtonDisabled(1, "Fox 2nd", "You do not have proper type of tails for this metamorphosis.");
				else addButtonDisabled(1, "Fox 2nd", "You do not have proper type and amount of tails for this metamorphosis.");
			}
			else addButtonDisabled(1, "???", "You have not yet unlocked this metamorphosis!");

			if (player.hasStatusEffect(StatusEffects.UnlockedFoxTail3rd) && player.tailType == Tail.FOX && player.tailCount == 2 && player.soulforce >= 300) addButton(2, "Fox 3rd", metamorphTailFox3rd);
			else if (player.hasStatusEffect(StatusEffects.UnlockedFoxTail3rd) && player.tailType == Tail.FOX) {
				if (player.tailCount == 3) addButtonDisabled(2, "Fox 3rd", "You already have three fox tails.");
				else if (player.tailCount == 2 && player.soulforce < 300) addButtonDisabled(2, "Fox 3rd", "You do not have enough Soulforce for this metamorphosis.");
				else addButtonDisabled(2, "Fox 3rd", "You need to have two fox tails to use this metamophosis.");
			}
			else if (player.hasStatusEffect(StatusEffects.UnlockedFoxTail3rd) && player.tailType != Tail.FOX && player.tailCount != 2) addButtonDisabled(2, "Fox 3rd", "You do not have proper type and amount of tails for this metamorphosis.");
			else addButtonDisabled(2, "???", "You have not yet unlocked this metamorphosis!");

			if (player.hasStatusEffect(StatusEffects.UnlockedFoxTail4th) && player.tailType == Tail.FOX && player.tailCount == 3 && player.soulforce >= 400) addButton(3, "Fox 4th", metamorphTailFox4th);
			else if (player.hasStatusEffect(StatusEffects.UnlockedFoxTail4th) && player.tailType == Tail.FOX) {
				if (player.tailCount == 4) addButtonDisabled(3, "Fox 4th", "You already have four fox tails.");
				else if (player.tailCount == 3 && player.soulforce < 400) addButtonDisabled(3, "Fox 4th", "You do not have enough Soulforce for this metamorphosis.");
				else addButtonDisabled(3, "Fox 4th", "You need to have three fox tails to use this metamophosis.");
			}
			else if (player.hasStatusEffect(StatusEffects.UnlockedFoxTail4th) && player.tailType != Tail.FOX && player.tailCount != 3) addButtonDisabled(3, "Fox 4th", "You do not have proper type and amount of tails for this metamorphosis.");
			else addButtonDisabled(3, "???", "You have not yet unlocked this metamorphosis!");

			if (player.hasStatusEffect(StatusEffects.UnlockedFoxTail5th) && player.tailType == Tail.FOX && player.tailCount == 4 && player.soulforce >= 500) addButton(4, "Fox 5th", metamorphTailFox5th);
			else if (player.hasStatusEffect(StatusEffects.UnlockedFoxTail5th) && player.tailType == Tail.FOX) {
				if (player.tailCount == 5) addButtonDisabled(4, "Fox 5th", "You already have five fox tails.");
				else if (player.tailCount == 4 && player.soulforce < 500) addButtonDisabled(4, "Fox 5th", "You do not have enough Soulforce for this metamorphosis.");
				else addButtonDisabled(4, "Fox 5th", "You need to have four fox tails to use this metamophosis.");
			}
			else if (player.hasStatusEffect(StatusEffects.UnlockedFoxTail5th) && player.tailType != Tail.FOX && player.tailCount != 4) addButtonDisabled(4, "Fox 5th", "You do not have proper type and amount of tails for this metamorphosis.");
			else addButtonDisabled(4, "???", "You have not yet unlocked this metamorphosis!");

			if (player.hasStatusEffect(StatusEffects.UnlockedFoxTail6th) && player.tailType == Tail.FOX && player.tailCount == 5 && player.soulforce >= 600) addButton(5, "Fox 6th", metamorphTailFox6th);
			else if (player.hasStatusEffect(StatusEffects.UnlockedFoxTail6th) && player.tailType == Tail.FOX) {
				if (player.tailCount == 6) addButtonDisabled(5, "Fox 6th", "You already have six fox tails.");
				else if (player.tailCount == 5 && player.soulforce < 600) addButtonDisabled(5, "Fox 6th", "You do not have enough Soulforce for this metamorphosis.");
				else addButtonDisabled(5, "Fox 6th", "You need to have five fox tails to use this metamophosis.");
			}
			else if (player.hasStatusEffect(StatusEffects.UnlockedFoxTail6th) && player.tailType != Tail.FOX && player.tailCount != 5) addButtonDisabled(5, "Fox 6th", "You do not have proper type and amount of tails for this metamorphosis.");
			else addButtonDisabled(5, "???", "You have not yet unlocked this metamorphosis!");

			if (player.hasStatusEffect(StatusEffects.UnlockedFoxTail7th) && player.tailType == Tail.FOX && player.tailCount == 6 && player.soulforce >= 700) addButton(6, "Fox 7th", metamorphTailFox7th);
			else if (player.hasStatusEffect(StatusEffects.UnlockedFoxTail7th) && player.tailType == Tail.FOX) {
				if (player.tailCount == 7) addButtonDisabled(6, "Fox 7th", "You already have seven fox tails.");
				else if (player.tailCount == 6 && player.soulforce < 700) addButtonDisabled(6, "Fox 7th", "You do not have enough Soulforce for this metamorphosis.");
				else addButtonDisabled(6, "Fox 7th", "You need to have six fox tails to use this metamophosis.");
			}
			else if (player.hasStatusEffect(StatusEffects.UnlockedFoxTail7th) && player.tailType != Tail.FOX && player.tailCount != 6) addButtonDisabled(6, "Fox 7th", "You do not have proper type and amount of tails for this metamorphosis.");
			else addButtonDisabled(6, "???", "You have not yet unlocked this metamorphosis!");

			if (player.hasStatusEffect(StatusEffects.UnlockedFoxTail8th) && player.tailType == Tail.FOX && player.tailCount == 7 && player.soulforce >= 800) addButton(7, "Fox 8th", metamorphTailFox8th);
			else if (player.hasStatusEffect(StatusEffects.UnlockedFoxTail8th) && player.tailType == Tail.FOX) {
				if (player.tailCount == 8) addButtonDisabled(7, "Fox 8th", "You already have eight fox tails.");
				else if (player.tailCount == 7 && player.soulforce < 800) addButtonDisabled(7, "Fox 8th", "You do not have enough Soulforce for this metamorphosis.");
				else addButtonDisabled(7, "Fox 8th", "You need to have seven fox tails to use this metamophosis.");
			}
			else if (player.hasStatusEffect(StatusEffects.UnlockedFoxTail8th) && player.tailType != Tail.FOX && player.tailCount != 7) addButtonDisabled(7, "Fox 8th", "You do not have proper type and amount of tails for this metamorphosis.");
			else addButtonDisabled(7, "???", "You have not yet unlocked this metamorphosis!");

			if (player.hasStatusEffect(StatusEffects.UnlockedFoxTail9th) && player.tailType == Tail.FOX && player.tailCount == 8 && player.soulforce >= 900) addButton(8, "Fox 9th", metamorphTailFox9th);
			else if (player.hasStatusEffect(StatusEffects.UnlockedFoxTail9th) && player.tailType == Tail.FOX) {
				if (player.tailCount == 9) addButtonDisabled(8, "Fox 9th", "You already have nine fox tails.");
				else if (player.tailCount == 8 && player.soulforce < 900) addButtonDisabled(8, "Fox 9th", "You do not have enough Soulforce for this metamorphosis.");
				else addButtonDisabled(8, "Fox 9th", "You need to have eight fox tails to use this metamophosis.");
			}
			else if (player.hasStatusEffect(StatusEffects.UnlockedFoxTail9th) && player.tailType != Tail.FOX && player.tailCount != 8) addButtonDisabled(8, "Fox 9th", "You do not have proper type and amount of tails for this metamorphosis.");
			else addButtonDisabled(8, "???", "You have not yet unlocked this metamorphosis!");

			if (player.hasStatusEffect(StatusEffects.UnlockedDraconicTail) && player.tailType != Tail.DRACONIC && player.soulforce >= 100) addButton(9, "Dragon", metamorphDragonTail);
			else if (player.hasStatusEffect(StatusEffects.UnlockedDraconicTail) && player.tailType == Tail.DRACONIC) addButtonDisabled(9, "Dragon", "You already have dragon tail.");
			else if (player.hasStatusEffect(StatusEffects.UnlockedDraconicTail) && player.tailType != Tail.DRACONIC && player.soulforce < 100) addButtonDisabled(9, "Dragon", "You do not have enough Soulforce for this metamorphosis.");
			else addButtonDisabled(9, "???", "You have not yet unlocked this metamorphosis!");
			addButton(14, "Back", accessPage3MetamorphMenu);
		}
		private function accessPage3TailMenu():void {
			menu();
			if (player.hasStatusEffect(StatusEffects.UnlockedPigTail) && player.tailType != Tail.PIG && player.soulforce >= 100) addButton(0, "Pig", metamorphPigTail);
			else if (player.hasStatusEffect(StatusEffects.UnlockedPigTail) && player.tailType == Tail.PIG) addButtonDisabled(0, "Pig", "You already have pig tail.");
			else if (player.hasStatusEffect(StatusEffects.UnlockedPigTail) && player.tailType != Tail.PIG && player.soulforce < 100) addButtonDisabled(0, "Pig", "You do not have enough Soulforce for this metamorphosis.");
			else addButtonDisabled(0, "???", "You have not yet unlocked this metamorphosis!");

			if (player.hasStatusEffect(StatusEffects.UnlockedScorpionTail) && player.tailType != Tail.SCORPION && player.soulforce >= 100) addButton(1, "Scorpion", metamorphScorpionTail);
			else if (player.hasStatusEffect(StatusEffects.UnlockedScorpionTail) && player.tailType == Tail.SCORPION) addButtonDisabled(1, "Scorpion", "You already have scorpion tail.");
			else if (player.hasStatusEffect(StatusEffects.UnlockedScorpionTail) && player.tailType != Tail.SCORPION && player.soulforce < 100) addButtonDisabled(1, "Scorpion", "You do not have enough Soulforce for this metamorphosis.");
			else addButtonDisabled(1, "???", "You have not yet unlocked this metamorphosis!");

			if (player.hasStatusEffect(StatusEffects.UnlockedGoatTail) && player.tailType != Tail.GOAT && player.soulforce >= 100) addButton(2, "Goat", metamorphGoatTail);
			else if (player.hasStatusEffect(StatusEffects.UnlockedGoatTail) && player.tailType == Tail.GOAT) addButtonDisabled(2, "Goat", "You already have goat tail.");
			else if (player.hasStatusEffect(StatusEffects.UnlockedGoatTail) && player.tailType != Tail.GOAT && player.soulforce < 100) addButtonDisabled(2, "Goat", "You do not have enough Soulforce for this metamorphosis.");
			else addButtonDisabled(2, "???", "You have not yet unlocked this metamorphosis!");

			if (player.hasStatusEffect(StatusEffects.UnlockedSalamanderTail) && player.tailType != Tail.SALAMANDER && player.soulforce >= 100) addButton(6, "Salamander", metamorphSalamanderTail);
			else if (player.hasStatusEffect(StatusEffects.UnlockedSalamanderTail) && player.tailType == Tail.SALAMANDER) addButtonDisabled(6, "Salamander", "You already have salamander tail.");
			else if (player.hasStatusEffect(StatusEffects.UnlockedSalamanderTail) && player.tailType != Tail.SALAMANDER && player.soulforce < 100) addButtonDisabled(6, "Salamander", "You do not have enough Soulforce for this metamorphosis.");
			else addButtonDisabled(6, "???", "You have not yet unlocked this metamorphosis!");
			//7 to 13 -> kitshoo tails 1st to 7th
			addButton(14, "Back", accessPage3MetamorphMenu);
		}
		private function accessPage4TailMenu():void {
			menu();
			//0 and 1 -> kitshoo tails 8th & 9th
			if (player.hasStatusEffect(StatusEffects.UnlockedMantisTail) && player.tailType != Tail.MANTIS_ABDOMEN && player.soulforce >= 100) addButton(2, "Mantis", metamorphMantisTail);
			else if (player.hasStatusEffect(StatusEffects.UnlockedMantisTail) && player.tailType == Tail.MANTIS_ABDOMEN) addButtonDisabled(2, "Mantis", "You already have mantis abdomen.");
			else if (player.hasStatusEffect(StatusEffects.UnlockedMantisTail) && player.tailType != Tail.MANTIS_ABDOMEN && player.soulforce < 100) addButtonDisabled(2, "Mantis", "You do not have enough Soulforce for this metamorphosis.");
			else addButtonDisabled(2, "???", "You have not yet unlocked this metamorphosis!");
			if (player.hasStatusEffect(StatusEffects.UnlockedManticoreTail) && player.tailType == Tail.SCORPION) {
				if (player.tailType != Tail.MANTICORE_PUSSYTAIL && player.soulforce >= 200) {
					if (player.hasCock()) addButtonDisabled(3, "Manticore", "You can't use this metamorphosis as long you not get rid of your manhood.");
					else addButton(3, "Manticore", metamorphManticoreTail);
				}
				else if (player.tailType == Tail.MANTICORE_PUSSYTAIL) addButtonDisabled(3, "Manticore", "You already have manticore pussytail.");
				else if (player.tailType != Tail.MANTICORE_PUSSYTAIL && player.soulforce < 200) addButtonDisabled(3, "Manticore", "You do not have enough Soulforce for this metamorphosis.");
			}
			else if (player.hasStatusEffect(StatusEffects.UnlockedManticoreTail) && player.tailType != Tail.SCORPION) addButtonDisabled(3, "Manticore", "You do not have proper type of tail for this metamorphosis.");
			else addButtonDisabled(3, "???", "You have not yet unlocked this metamorphosis!");

			if (player.hasStatusEffect(StatusEffects.UnlockedOrcaTail) && player.tailType != Tail.ORCA && player.soulforce >= 100) addButton(6, "Orca", metamorphOrcaTail);
			else if (player.hasStatusEffect(StatusEffects.UnlockedOrcaTail) && player.tailType == Tail.ORCA) addButtonDisabled(6, "Orca", "You already have orca tail.");
			else if (player.hasStatusEffect(StatusEffects.UnlockedOrcaTail) && player.tailType != Tail.ORCA && player.soulforce < 100) addButtonDisabled(6, "Orca", "You do not have enough Soulforce for this metamorphosis.");
			else addButtonDisabled(6, "???", "You have not yet unlocked this metamorphosis!");

			if (player.hasStatusEffect(StatusEffects.UnlockedRaijuTail) && player.tailType != Tail.RAIJU && player.soulforce >= 100) addButton(8, "Raiju", metamorphRaijuTail);
			else if (player.hasStatusEffect(StatusEffects.UnlockedRaijuTail) && player.tailType == Tail.RAIJU) addButtonDisabled(8, "Raiju", "You already have raiju tail.");
			else if (player.hasStatusEffect(StatusEffects.UnlockedRaijuTail) && player.tailType != Tail.RAIJU && player.soulforce < 100) addButtonDisabled(8, "Raiju", "You do not have enough Soulforce for this metamorphosis.");
			else addButtonDisabled(8, "???", "You have not yet unlocked this metamorphosis!");

			if (player.hasStatusEffect(StatusEffects.UnlockedRedPandaTail) && player.tailType != Tail.RED_PANDA && player.soulforce >= 100) addButton(9, "Red Panda", metamorphRedPandaTail);
			else if (player.hasStatusEffect(StatusEffects.UnlockedRedPandaTail) && player.tailType == Tail.RED_PANDA) addButtonDisabled(9, "Red Panda", "You already have red panda tail.");
			else if (player.hasStatusEffect(StatusEffects.UnlockedRedPandaTail) && player.tailType != Tail.RED_PANDA && player.soulforce < 100) addButtonDisabled(9, "Red Panda", "You do not have enough Soulforce for this metamorphosis.");
			else addButtonDisabled(9, "???", "You have not yet unlocked this metamorphosis!");
			addButton(14, "Back", accessPage3MetamorphMenu);
		}
		private function accessPage5TailMenu():void {
			menu();
			if (player.hasStatusEffect(StatusEffects.UnlockedHellcatBurningTail) && player.tailType != Tail.BURNING && player.soulforce >= 100) addButton(0, "Hellcat", metamorphHellcatBurningTail);
			else if (player.hasStatusEffect(StatusEffects.UnlockedHellcatBurningTail) && player.tailType == Tail.BURNING) addButtonDisabled(0, "Hellcat", "You already have hellcat burning tail.");
			else if (player.hasStatusEffect(StatusEffects.UnlockedHellcatBurningTail) && player.tailType != Tail.BURNING && player.soulforce < 100) addButtonDisabled(0, "Hellcat", "You do not have enough Soulforce for this metamorphosis.");
			else addButtonDisabled(0, "???", "You have not yet unlocked this metamorphosis!");

			if (player.hasStatusEffect(StatusEffects.UnlockedNekomataForkedTail1) && player.tailType != Tail.NEKOMATA_FORKED_1_3 && player.soulforce >= 200) addButton(1, "Forked 1/3", metamorphNekomataOneThirdForkedTail);
			else if (player.hasStatusEffect(StatusEffects.UnlockedNekomataForkedTail1) && player.tailType == Tail.NEKOMATA_FORKED_1_3) addButtonDisabled(1, "Forked 1/3", "You already have 1/3 forked cat tail.");
			else if (player.hasStatusEffect(StatusEffects.UnlockedNekomataForkedTail1) && player.tailType != Tail.NEKOMATA_FORKED_1_3 && player.soulforce < 200) addButtonDisabled(1, "Forked 1/3", "You do not have enough Soulforce for this metamorphosis.");
			else if (player.hasStatusEffect(StatusEffects.UnlockedNekomataForkedTail1) && player.tailType != Tail.CAT && player.tailCount != 1) addButtonDisabled(2, "Forked 1/3", "You do not have proper type of tail for this metamorphosis.");
			else addButtonDisabled(1, "???", "You have not yet unlocked this metamorphosis!");

			if (player.hasStatusEffect(StatusEffects.UnlockedNekomataForkedTail2) && player.tailType != Tail.NEKOMATA_FORKED_2_3 && player.soulforce >= 300) addButton(2, "Forked 2/3", metamorphNekomataTwoThirdForkedTail);
			else if (player.hasStatusEffect(StatusEffects.UnlockedNekomataForkedTail2) && player.tailType == Tail.NEKOMATA_FORKED_2_3) addButtonDisabled(2, "Forked 2/3", "You already have 2/3 forked cat tail.");
			else if (player.hasStatusEffect(StatusEffects.UnlockedNekomataForkedTail2) && player.tailType != Tail.NEKOMATA_FORKED_2_3 && player.soulforce < 300) addButtonDisabled(2, "Forked 2/3", "You do not have enough Soulforce for this metamorphosis.");
			else if (player.hasStatusEffect(StatusEffects.UnlockedNekomataForkedTail2) && player.tailType != Tail.NEKOMATA_FORKED_1_3) addButtonDisabled(2, "Forked 2/3", "You do not have proper type of tail for this metamorphosis.");
			else addButtonDisabled(2, "???", "You have not yet unlocked this metamorphosis!");
			addButton(14, "Back", accessPage3MetamorphMenu);
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
			//addButton(5, "Back", accessMetamorphMenu);
			//addButton(6, "Back", accessMetamorphMenu);
			//addButton(7, "Back", accessMetamorphMenu);
			//addButton(8, "Back", accessMetamorphMenu);
			if (player.soulforce >= 100) addButton(9, "Hair -1", metamorphHair1D);
			else addButtonDisabled(9, "Hair -1", "You do not have enough Soulforce for this metamorphosis.");
			//addButton(10, "Back", accessMetamorphMenu);
			//addButton(11, "Back", accessMetamorphMenu);
			//addButton(12, "Back", accessMetamorphMenu);
			//addButton(13, "Back", accessMetamorphMenu);
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
			addButton(2, "Fur", accessMetamorphMenu);/*
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
			addButton(13, "Back", accessMetamorphMenu);*/
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
			outputText("\n\nWhoa wait did your hair just lenghten!? You indeed notice they're longer by an inch.");
			player.hairLength += 1;
			doNext(accessPageEx1MetamorphMenu);
		}
		private function metamorphHair1D():void {
			clearOutput();
			player.soulforce -= 100;
			outputText("\n\nWhoa wait did your hair just lost some lenght!? You indeed notice they shortened by an inch.");
			player.hairLength -= 1;
			if (player.hairLength < 0) player.hairLength = 0;
			doNext(accessPageEx1MetamorphMenu);
		}


		private function metamorph000Fur():void {
			clearOutput();
			player.soulforce -= 100;


			doNext(accessMetamorphMenu);
		}
		private function metamorph001Fur():void {
			clearOutput();
			player.soulforce -= 100;


			doNext(accessMetamorphMenu);
		}
		private function metamorph002Fur():void {
			clearOutput();
			player.soulforce -= 100;


			doNext(accessMetamorphMenu);
		}





		private function metamorphManticoreTail():void {
			clearOutput();
			player.soulforce -= 200;
			outputText("\n\nYour scorpion tail starts shifting as your stinger falls to the ground, leaving you with a wide hole at the tip of your tail. You have a feeling of emptiness in your tail, like if it was hollowed from the inside. The end of your tail where the stinger used to be suddenly explodes into a flower-like bulb of flesh. The petals open into what looks like the inside of a pussy, its folds moist and well lubricated. ");
			outputText("Right after the previous transformation’s finished, spikes starts to grow out of the bulbous tip giving your tail tip the appearance of a spiked bulb. Flinging your tail randomly to test your new appendage you shoot one of them straight into a nearby tree. You idly wonder what it will feels like to milk men with this. <b>It seems you've grown the tail of a manticore.</b>");
			player.tailType = Tail.MANTICORE_PUSSYTAIL;
			doNext(accessPage4TailMenu);
		}
		private function metamorphScorpionTail():void {
			clearOutput();
			player.soulforce -= 100;
			if (player.tailType != Tail.NONE) outputText("\n\nPainful swelling just above your " + Appearance.buttDescription(player) + " doubles you over, and you hear the sound of your tail dropping off onto the ground! Before you can consider the implications, the pain gets worse, and you feel your backside bulge outward sickeningly, cracking and popping as a segmented scorpion-like tail grows in place of your old one. It grows large enough to be impossible to hide, and with a note of finality, your stinger slides free with an audible 'snick'. <b>You have a scorpion tail.</b>");
			else outputText("\n\nPainful swelling just above your " + Appearance.buttDescription(player) + " doubles you over. It gets worse and worse as the swollen lump begins to protrude from your backside, swelling and extending with a series of pops until you have a segmented tail hanging just above your butt. The whole thing is covered in a hard chitinous material, and large enough to be impossible to hide. You sigh as your stinger slides into place with a 'snick', finishing the transformation. <b>You have a scorpion tail.</b>");
			player.tailType = Tail.SCORPION;
			player.tailCount = 1;
			player.tailVenom = 15;
			player.tailRecharge = 5;
			doNext(accessPage3TailMenu);
		}

		private function metamorphLionMane():void {
			clearOutput();
			player.soulforce -= 100;
			outputText("\n\nYou suddenly feel hair growing all around your neck at a crazy pace. It soon get so thick it almost looks as if you're wearing a [haircolor] fur collar. <b>You now have a full lion mane around your neck.</b>");
			player.rearBody.type = RearBody.LION_MANE;
			doNext(accessRearBodyMenuOld);
		}
		private function metamorphCat2ndTail():void {
			clearOutput();
			player.soulforce -= 400;
			outputText("\n\nA tingling pressure builds on your backside, and your soft, glossy, and partially forked tail begins to glow with an eerie, ghostly light. With a crackle of electrical energy, your tail finishes splitting in two! <b>You now have a pair of cat-tails.</b>");
			player.tailType = Tail.CAT;
			player.tailCount = 2;
			doNext(accessPage1TailMenu);
		}
		private function metamorphNekomataTwoThirdForkedTail():void {
			clearOutput();
			player.soulforce -= 300;
			outputText("\n\nA tingling pressure builds on your backside, and your soft, glossy, and partially forked tail begins to glow with an eerie, ghostly light. With a crackle of electrical energy, it starts splitting into two, stopping as another third of its length becomes forked! <b>You now have a cat tail that is forked at two thirds of its length.</b>");
			player.tailType = Tail.NEKOMATA_FORKED_2_3;
			doNext(accessPage5TailMenu);
		}
		private function metamorphNekomataOneThirdForkedTail():void {
			clearOutput();
			player.soulforce -= 200;
			outputText("\n\nA tingling pressure builds on your backside, and your soft, glossy tail begins to glow with an eerie, ghostly light. With a crackle of electrical energy, it starts splitting into two, stopping once the split reaches a third of the way down the length! <b>You now have a cat tail that is forked on the last third of its length.</b>");
			player.tailType = Tail.NEKOMATA_FORKED_1_3;
			doNext(accessPage5TailMenu);
		}
		private function metamorphHellcatBurningTail():void {
			clearOutput();
			player.soulforce -= 100;
			outputText("\n\nWarmth then rampage all around body altering your body. It heads for your tail exploding there in a sheath of flame before spiraling toward your head. <b>You now have burning tail.</b>");
			player.tailType = Tail.BURNING;
			player.tailCount = 1;
			doNext(accessPage5TailMenu);
		}

		private function metamorphDisplacerBackTentacles():void {
			clearOutput();
			player.soulforce -= 100;
			outputText("\n\n");
			if (player.rearBody.type != RearBody.NONE) outputText("A wave of tightness spreads through your back, and it feels as if someone is stabbing a dagger in it. After a moment the pain passes, though your back is back to what you looked like when you entered this realm! ");
			outputText("Two large fleshy lumps explode from your shoulders and you scream in pain. These fleshy appendages weave and move like whips in your back and only stop doing so when you finally manage to calm yourself. <b>As you look back to see what's going on, you notice you now have a pair of tentacles with thick, fleshy heads. You can feel the air brushing over the sensitive needles and suction cups that cover both of them, your new venom glistening on the tips.</b>");
			player.rearBody.type = RearBody.DISPLACER_TENTACLES;
			doNext(accessRearBodyMenuOld);
		}


		private function metamorphCatTail():void {
			clearOutput();
			var choice:int;
			player.soulforce -= 100;
			if (player.tailType == Tail.NONE) {
				choice = rand(3);
				if (choice == 0) outputText("\n\nA pressure builds in your backside. You feel under your [armor] and discover an odd bump that seems to be growing larger by the moment. In seconds it passes between your fingers, bursts out the back of your clothes and grows most of the way to the ground. A thick coat of fur springs up to cover your new tail. You instinctively keep adjusting it to improve your balance. <b>You now have a cat-tail.</b>");
				if (choice == 1) outputText("\n\nYou feel your backside shift and change, flesh molding and displacing into a long, flexible tail! <b>You now have a cat tail.</b>");
				if (choice == 2) outputText("\n\nYou feel an odd tingling in your spine and your tail bone starts to throb and then swell. Within a few moments it begins to grow, adding new bones to your spine. Before you know it, you have a tail. Just before you think it's over, the tail begins to sprout soft, glossy [skin coat.color] fur. <b>You now have a cat tail.</b>");
			}
			else outputText("\n\nYou pause and tilt your head... something feels different. Ah, that's what it is; you turn around and look down at your tail as it starts to change shape, narrowing and sprouting glossy fur. <b>You now have a cat tail.</b>");
			player.tailType = Tail.CAT;
			player.tailCount = 1;
			doNext(accessPage1TailMenu);
		}
		private function metamorphRedPandaTail():void {
			clearOutput();
			player.soulforce -= 100;
			outputText("\n\n");
			if (player.tailCount > 1) {
				outputText("Your tails seem to move on their own, tangling together in a single mass. Before you can ever feel it happening, you realize that they’re merging! An increased sensation of heat, not unlike the flavor of the roots, rushes through your body, and once that it fades, you realize that you now have a single tail.");
				outputText("\n\nThe process doesn’t stop here though, as the feel of that spicy root returns, but now the heat is felt only in your tail, as it shakes wildly while it elongates and becomes more bushy. Soon it has become almost as long as you. A very thick mass of soft, fluffy furs covers it in a matter of seconds. It acquires a lovely ringed pattern of red-russet and copperish-orange.");
				outputText("\n\nWhen the effects finally subside, you decide to test the tail, making it coil around your body, realizing soon that you can control its movements with ease, and that its fur feels wonderful to the touch. Anyways, <b>you now have a long, bushy, red-panda tail!</b>");
			}
			else if (player.tailType == Tail.NONE) {
				outputText("Feeling an uncomfortable sensation on your butt, you stretch yourself, attributing it to having sat on a rough surface. A burning sensation runs through your body, similar to the one that you had after eating the root. When it migrates to your back, your attention goes to a mass of fluff that has erupted from your backside. Before you can check it properly, it seems to move on its own, following the heated sensation that now pulsates through your body, and when the heated pulses seem to have stopped, it has become a long, fluffy tube");
				outputText("\n\nShortly after, the feel of that spicy root returns, but now the heat is felt only in your tail, which shakes wildly while it elongates and becomes more bushy. Soon it has become almost as long as you. A very thick mass of soft, fluffy furs covers it in a matter of seconds. It acquires a lovely ringed pattern of red-russet and copperish-orange.");
				outputText("\n\nWhen the effects finally subside, you decide to test the tail, making it coil around your body, realizing soon that you can control its movements with ease, and that its fur feels wonderful at the touch. Anyways, <b>you now have a long, bushy, red-panda tail!</b>");
			}
			else if (player.tailType == Tail.BEE_ABDOMEN || player.tailType == Tail.SPIDER_ADBOMEN || player.tailType == Tail.MANTIS_ABDOMEN) {
				outputText("Your insectile backside seems affected by the root properties, as your venom production suddenly stops. The flesh within the abdomen retracts into your backside, the chiting covering falling, leaving exposed a layer of soft, bare skin. When the abdomen disappears, your left with a comically sized butt, that soon reverts to its usual size.");
				outputText("\n\nThe root keeps doing its thing, as you feel an uncomfortable sensation on your butt. A burning sensation runs through your body, similar to the one that you had after eating the root. When it migrates to your back, your attention goes to a mass of fluff that has erupted from your backside. Before you can check it properly, it seems to move on its own, following the heated sensation that now pulsates through your body, and when the heated pulses seem to have stopped, it has become a long, fluffy tube, quite different from your former abdomen.");
				outputText("\n\nShortly after, the feel of that spicy root returns, but now the heat is felt only in your tail, which shakes wildly while it elongates and becomes more bushy. Soon it has become almost as long as you. A very thick mass of soft, fluffy furs covers it in a matter of seconds. It acquires a lovely ringed pattern of red-russet and copperish-orange.");
				outputText("\n\nWhen the effects finally subside, you decide to test the tail, making it coil around your body, realizing soon that you can control its movements with ease, and that its fur feels wonderful at the touch. Anyways, <b>you now have a long, bushy, red-panda tail!</b>");
			}
			else {
				outputText("The feel of that spicy root returns, but now the heat is felt on your tail, that shakes wildly while it elongates and becomes more bushy. Soon it has become almost as long as you. A very thick mass of soft, fluffy furs covers it in a matter of seconds. It acquires a lovely ringed pattern of red-russet and copperish-orange.");
				outputText("\n\nWhen the effects finally subside, you decide to test the tail, making it coil around your body, realizing soon that you can control their moves with easy, and that its fur feels wonderful at the touch. Anyways, <b>you now have a long, bushy, red-panda tail!</b>");
			}
			player.tailType = Tail.RED_PANDA;
			doNext(accessPage4TailMenu);
		}





		private function metamorphHorseTail():void {
			clearOutput();
			player.soulforce -= 100;
			if (player.tailType == 0) outputText("\n\nThere is a sudden tickling on your ass, and you notice you have sprouted a long shiny horsetail of the same [haircolor] color as your hair.");
			if (player.tailType > Tail.HORSE && player.tailType <= Tail.COW) outputText("\n\nPain lances up your " + Appearance.assholeDescript(player) + " as your tail shifts and morphs disgustingly. With one last wave of pain, it splits into hundreds of tiny filaments, transforming into a horsetail.");
			if ((player.tailType > Tail.COW && player.tailType < Tail.SHARK) || player.tailType == Tail.SCORPION || player.tailType == Tail.MANTIS_ABDOMEN) outputText("\n\nYour insect-like abdomen bunches up as it begins shrinking, exoskeleton flaking off like a snake sheds its skin. It bunches up until it is as small as a tennis ball, then explodes outwards, growing into an animalistic tail shape. Moments later, it explodes into filaments of pain, dividing into hundreds of strands and turning into a shiny horsetail.");
			if (player.tailType >= Tail.SHARK) outputText("\n\nPain lances up your " + player.assholeDescript() + " as your tail shifts and morphs disgustingly. With one last wave of pain, it splits into hundreds of tiny filaments, transforming into a horsetail.");
			outputText(" <b>You now have a horse-tail.</b>");
			player.tailType = Tail.HORSE;
			doNext(accessPage1TailMenu);
		}
		private function metamorphOrcSkinPattern():void {
			clearOutput();
			player.soulforce -= 100;
			outputText("\n\nYou double over suddenly as a harsh, stabbing pain runs across your skin, tattoos in the shape of scars forming on various parts of your body. Considering how you look now, you might as well proudly display your <b>Orc scar tattooed skin.</b>");
			player.skin.base.pattern = Skin.PATTERN_SCAR_SHAPED_TATTOO;
			player.skin.base.adj = "scar shaped tattooed";
			doNext(accessSkinPatternsMenuOld);
		}

		private function metamorphHumanNoRearBody():void {
			clearOutput();
			player.soulforce -= 500;
			outputText("\n\nA wave of tightness spreads through your back, and it feels as if someone is stabbing a dagger in it. After a moment the pain passes, though your back is back to what you looked like when you entered this realm!");
			player.rearBody.type = RearBody.NONE;
			doNext(accessRearBodyMenuOld);
		}
		private function metamorphHumanNoTail():void {
			clearOutput();
			player.soulforce -= 500;
			outputText("\n\nYou feel something shifting in your backside. Then something detaches from your backside and it falls onto the ground. <b>You no longer have a tail!</b>");
			player.tailType = Tail.NONE;
			player.tailCount = 0;
			player.tailVenom = 0;
			player.tailRecharge = 5;
			doNext(accessPage1TailMenu);
		}


		private function metamorphHumanNoAntennae():void {
			clearOutput();
			player.soulforce -= 500;
			outputText("\n\nThe muscles in your brow clench tightly, and you feel a tremendous pressure on your upper forehead. When it passes, you touch yourself and discover your antennae.type have vanished!");
			player.antennae.type = Antennae.NONE;
			doNext(accessAntennaeMenuOld);
		}
		private function metamorphHumanNoGills():void {
			clearOutput();
			player.soulforce -= 500;
			if (player.gills.type == Gills.ANEMONE) outputText("\n\nYour chest itches, and as you reach up to scratch it, you realize your gills have withdrawn into your skin.");
			if (player.gills.type == Gills.FISH) outputText("\n\nYou feel your gills tighten, the slits seeming to close all at once. As you let out a choked gasp your gills shrink into nothingness, leaving only smooth skin behind. Seems you won't be able to stay in the water quite so long anymore.");
			outputText(" <b>You no longer have gills!</b>");
			player.gills.type = Gills.NONE;
			doNext(accessGillsMenuOld);
		}


		private function metamorphHumanNoSkinPatterns():void {
			clearOutput();
			player.soulforce -= 500;
			outputText("\n\nYour skin patterns itches incessantly, and as you scratch they shifts and changes, becoming less and less visible till they gone. <b>Your skin is without any skin patterns!</b>");
			player.skin.base.pattern = Skin.PATTERN_NONE;
			player.skin.base.adj = "";
			doNext(accessSkinPatternsMenuOld);
		}

		private function metamorphPigTail():void {
			clearOutput();
			player.soulforce -= 100;
			if (player.tailType == Tail.NONE) outputText("\n\nYou feel a tug at the base of your spine as it lengthens ever so slightly. Looking over your shoulder, <b>you find that you have sprouted a small, curly pig tail.</b>");
			else outputText("\n\nYou feel a pinching sensation in your [tail] as it begins to warp in change. When the sensation dissipates, <b>you are left with a small, curly pig tail.</b>");
			player.tailType = Tail.PIG;
			doNext(accessPage3TailMenu);
		}
		private function metamorphBatCollar():void {
			clearOutput();
			player.soulforce -= 100;
			outputText("\n\nAn intense itching sets in around your neck. Bringing your hands to your neck to scratch it, you find sparse, downy fuzz. As you scratch away, it continues lengthening and growing in density until you have a collar of fur around your neck.");
			outputText(" Well, this isn’t so bad, the scarf-like look is certainly nice, at the very least. <b>Your neck now sports a collar of fur.</b>");
			player.rearBody.type = RearBody.BAT_COLLAR;
			doNext(accessRearBodyMenuOld);
		}

		private function metamorphRaijuSkinPattern():void {
			clearOutput();
			player.soulforce -= 100;
			outputText("\n\nYou suddenly feel a rush of electricity on your skin as glowing tattoos in the shape of lightning bolts form in various place across your body. Well, how shocking. <b>Your skin is now inscribed with some lightning shaped tattoos.</b>");
			player.skin.base.pattern = Skin.PATTERN_LIGHTNING_SHAPED_TATTOO;
			player.skin.base.adj = "lightning shaped tattooed";
			doNext(accessSkinPatternsMenuOld);
		}
		private function metamorphRaijuMane():void {
			clearOutput();
			player.soulforce -= 100;
			outputText("\n\nThe base of your neck tingles with delight as little sparks travel across your skin. Strands of hair quickly grow in, giving you a [haircolor] collar of fur around your neck. Several strands of your new fur collar are quite dark, arcing around it like lightning.");
			player.rearBody.type = RearBody.RAIJU_MANE;
			doNext(accessRearBodyMenuOld);
		}
		private function metamorphRaijuTail():void {
			clearOutput();
			player.soulforce -= 100;
			if (player.tailType == Tail.NONE) outputText("\n\nYou yelp as a huge lightning bolt bursts out the area just above your ass. You watch in amazement as it twist and curls, slowly becoming thicker and thicker before it fizzles out, <b>leaving you with a silky Raiju tail!</b>");
			else outputText("\n\nYou nearly jump out of your skin as your tail burst into a huge lightning bolt. You watch as it curls and twist around before it fizzles out. <b>You now have a silky Raiju tail!</b>");
			player.tailType = Tail.RAIJU;
			doNext(accessPage4TailMenu);
		}

		private function metamorphOniSkinPattern():void {
			clearOutput();
			player.soulforce -= 100;
			outputText("\n\nAs you thought your skin couldn't handle more tattoo a few localised skin burns reveal a new set of drawing along your skin, some decorating your chest. Well you might as well proudly display your <b>Oni tattooed skin.</b>");
			player.skin.base.pattern = Skin.PATTERN_BATTLE_TATTOO;
			player.skin.base.adj = "battle tattooed";
			doNext(accessSkinPatternsMenuOld);
		}







		private function metamorphMantisTail():void {
			clearOutput();
			player.soulforce -= 100;
			outputText("\n\nPainful swelling just above your firm backside doubles you over.");
			outputText("\nIt gets worse and worse as the swollen lump begins to protrude from your backside, swelling and elongating with a series of pops until you have a bulbous abdomen hanging just above your butt.");
			outputText("\nThe whole thing is covered in a hard greenish chitinous material, and large enough to be impossible to hide. <b>You have a Mantis abdomen.</b>");
			player.tailType = Tail.MANTIS_ABDOMEN;
			doNext(accessPage4TailMenu);
		}

		private function metamorphMantisAntennae():void {
			clearOutput();
			player.soulforce -= 100;
			if (player.antennae.type == Antennae.BEE) outputText("\n\nYour head itches momentarily as your two floppy antennae changes slowly into long prehensile ones similar to those seen at mantis.");
			else outputText("\n\nYour head itches momentarily as two long prehensile antennae sprout from your [hair].");
			player.antennae.type = Antennae.MANTIS;
			doNext(accessAntennaeMenuOld);
		}


		private function metamorphGoatTail():void {
			clearOutput();
			player.soulforce -= 100;
			outputText("You feel an odd itchy sensation just above your [ass]. Twisting around to inspect it you find a short stubby tail that wags when you're happy. <b>You now have a goat tail.</b>");
			player.tailType = Tail.GOAT;
			doNext(accessPage3TailMenu);
		}

		private function metamorphCowTail():void {
			clearOutput();
			player.soulforce -= 100;
			if (player.tailType == Tail.NONE) outputText("\n\nYou feel the flesh above your [butt] knotting and growing. It twists and writhes around itself before flopping straight down, now shaped into a distinctly bovine form. You have a <b>cow tail</b>.");
			else {
				if (player.tailType < Tail.SPIDER_ADBOMEN || player.tailType > Tail.BEE_ABDOMEN) {
					outputText("\n\nYour tail bunches uncomfortably, twisting and writhing around itself before flopping straight down, now shaped into a distinctly bovine form. You have a <b>cow tail</b>.");
				}
				//insect
				if (player.tailType == Tail.SPIDER_ADBOMEN || player.tailType == Tail.BEE_ABDOMEN || player.tailType == Tail.SCORPION || player.tailType == Tail.MANTIS_ABDOMEN) {
					outputText("\n\nYour insect-like abdomen tingles pleasantly as it begins shrinking and softening, chitin morphing and reshaping until it looks exactly like a <b>cow tail</b>.");
				}
			}
			player.tailType = Tail.COW;
			doNext(accessPage1TailMenu);
		}
		private function metamorphDragonTail():void {
			clearOutput();
			player.soulforce -= 100;
			if (player.tailType == Tail.NONE) outputText("\n\nA sudden dull, throbbing pain in your [butt] forces your hands to it; you can feel an ominous lump over your tail bone, swelling bigger and bigger with every heartbeat. All of a sudden, it seems to explode, jutting out and around until it hovers near your ankles, the skin under your flesh hard and scaly. <b>You now have a dragon tail flicking at your back, flexible as a whip.</b>");
			else outputText("\n\nAn icy sensation fills your behind as your tail suddenly goes curiously numb. Twisting your head around, you watch as it melts and transforms into a reptilian appendage, long and flexible, its tip adorned with wicked spikes. <b>You now have a dragon tail.</b>");
			player.tailType = Tail.DRACONIC;
			doNext(accessPage2TailMenu);
		}






		private function metamorphOrcaBlowhole():void {
			clearOutput();
			player.soulforce -= 100;
			outputText("\n\n");
			if (player.rearBody.type > RearBody.NONE) outputText("Your wings fold into themselves, merging together with your back. ");
			outputText("Pain rushes just behind your shoulder blades as a hole opens up, air rushing in. The hole is burning making you groan in pain as air flows in and out. Eventually you get accustomed to breathing from your back like whales do, but it sure was a weird experience.");
			if (silly()) outputText(" Well it doesn't matter because now you can break the world record of the longest breath holding by sitting on the ocean floor for more than 90 minutes.");
			player.rearBody.type = RearBody.ORCA_BLOWHOLE;
			doNext(accessRearBodyMenuOld);
		}
		private function metamorphOrcaTail():void {
			clearOutput();
			player.soulforce -= 100;
			outputText("\n\nA large bump starts to grow out of your " + assDescript() + ", making you groan as your spine lengthens for this whole new appendage to form. You finally grow a tail black as midnight with a white underside and a smaller fin closer to your body, likely for hydrodynamism sake. You swing your tail a few times, battering the ground with it and smile as you rush to the stream to take a dip. ");
			outputText("With the help of your mighty tail you easily reach such a high swim speed you even manage to jump several meters out of the water, laughing with delight at the trill of this aquatic experience. <b>You're going to have a lot of fun swimming with your new Orca tail.</b>");
			player.tailType = Tail.ORCA;
			doNext(accessPage4TailMenu);
		}




		private function metamorphSalamanderTail():void {
			clearOutput();
			player.soulforce -= 100;
			if (player.tailType == Tail.NONE) outputText("\n\nYou drop onto the ground as your spine twists and grows, forcing the flesh above your " + assDescript() + " to bulge out. New bones form, one after another, building a tapered, prehensile tail onto the back of your body. For a brief moment it tip ignite with a red-colored flame that with as little as your merely thought vanish moment later. Still you somehow know you can set ablaze any part or whole your tail at any moment and even use it to burn enemies after lashing them with your tail. <b>You now have a salamander tail!</b>");
			else outputText("\n\nYou drop to the ground as your tail twists and grows, changing its shape in order to gradually taper to a point. It flicks back and forth, prehensile and totally under your control. For a brief moment it tip ignite with a red-colored flame that with as little as your merely thought vanish moment later. Still you somehow know you can set ablaze any part or whole your tail at any moment and even use it to burn enemies after lashing them with your tail. <b>You now have a salamander tail.</b>");
			player.tailType = Tail.SALAMANDER;
			doNext(accessPage3TailMenu);
		}
		private function metamorphSharkFin():void {
			clearOutput();
			player.soulforce -= 100;
			outputText("\n\nYou groan and slump down in pain, almost instantly regretting eating the tooth. You start sweating profusely and panting loudly, feeling the space between your shoulder blades shifting about. You hastily remove your [armor] just in time before a strange fin-like structure bursts from in-between your shoulders. You examine it carefully and make a few modifications to your [armor] to accommodate your new fin.");
			player.rearBody.type = RearBody.SHARK_FIN;
			doNext(accessRearBodyMenuOld);
		}

		private function metamorphSharkTail():void {
			clearOutput();
			player.soulforce -= 100;
			if (player.tailType == Tail.NONE) outputText("\n\nJets of pain shoot down your spine, causing you to gasp in surprise and fall to your hands and knees. Feeling a bulging at the end of your back, you lower your [armor] down just in time for a fully formed shark tail to burst through. You swish it around a few times, surprised by how flexible it is. After some modifications to your clothing, you're ready to go with your brand new shark tail.");
			else outputText("\n\nJets of pain shoot down your spine into your tail. You feel the tail bulging out until it explodes into a large and flexible shark-tail. You swish it about experimentally, and find it quite easy to control.");
			player.tailType = Tail.SHARK;
			doNext(accessPage1TailMenu);
		}
		private function metamorphSpiderTail():void {
			clearOutput();
			player.soulforce -= 100;
			outputText("\n\n");
			if (player.tailType > Tail.NONE) outputText("Your tail shudders as heat races through it, twitching violently until it feels almost as if it's on fire. You jump from the pain at your [butt] and grab at it with your hands. It's huge... and you can feel it hardening under your touches, firming up until the whole tail has become rock-hard and spherical in shape. The heat fades, leaving behind a gentle warmth, and you realize your tail has become a spider's abdomen! With one experimental clench, you even discover that it can shoot webs from some of its spinnerets, both sticky and non-adhesive ones. That may prove useful. <b>You now have a spider's abdomen hanging from above your [butt]!</b>\n\n");
			else outputText("A burst of pain hits you just above your [butt], coupled with a sensation of burning heat and pressure. You can feel your " + player.skinFurScales() + " tearing as something forces its way out of your body. Reaching back, you grab at it with your hands. It's huge... and you can feel it hardening under your touches, firming up until the whole tail has become rock-hard and spherical in shape. The heat fades, leaving behind a gentle warmth, and you realize your tail has become a spider's abdomen! With one experimental clench, you even discover that it can shoot webs from some of its spinnerets, both sticky and non-adhesive ones. That may prove useful. <b>You now have a spider's abdomen hanging from above your [butt]!</b>");
			player.tailType = Tail.SPIDER_ADBOMEN;
			player.tailVenom = 5;
			player.tailRecharge = 5;
			doNext(accessPage1TailMenu);
		}



		private function metamorphHarpyTail():void {
			clearOutput();
			player.soulforce -= 100;
			if (player.tailType > Tail.NONE) outputText("\n\nYour tail shortens, folding into the crack of your [butt] before it disappears. A moment later, a fan of feathers erupts in its place, fluffing up and down instinctively every time the breeze shifts. <b>You have a feathery harpy tail!</b>");
			else outputText("\n\nA tingling tickles the base of your spine, making you squirm in place. A moment later, it fades, but a fan of feathers erupts from your [skin.type] in its place. The new tail fluffs up and down instinctively with every shift of the breeze. <b>You have a feathery harpy tail!</b>");
			player.tailType = Tail.HARPY;
			doNext(accessPage1TailMenu);
		}


		private function metamorphBeeTail():void {
			clearOutput();
			player.soulforce -= 100;
			if (player.tailType > Tail.NONE) outputText("\n\nPainful swelling just above your [butt] doubles you over, and you hear the sound of your tail dropping off onto the ground! Before you can consider the implications, the pain gets worse, and you feel your backside bulge outward sickeningly, cracking and popping as a rounded bee-like abdomen grows in place of your old tail. It grows large enough to be impossible to hide, and with a note of finality, your stinger slides free with an audible 'snick'.");
			else outputText("\n\nPainful swelling just above your [butt] doubles you over. It gets worse and worse as the swollen lump begins to protrude from your backside, swelling and rounding with a series of pops until you have a bulbous abdomen hanging just above your butt. The whole thing is covered in a hard chitinous material, and large enough to be impossible to hide. You sigh as your stinger slides into place with a 'snick', finishing the transformation. <b>You have a bee's abdomen.</b>");
			player.tailType = Tail.BEE_ABDOMEN;
			player.tailVenom = 10;
			player.tailRecharge = 5;
			doNext(accessPage1TailMenu);
		}

		private function metamorphBeeAntennae():void {
			clearOutput();
			player.soulforce -= 100;
			if (player.antennae.type == Antennae.MANTIS) outputText("\n\nYour head itches momentarily as your two long prehensile antennae changes slowly into floppy ones similar to those seen at bees.");
			else outputText("\n\nYour head itches momentarily as two floppy antennae sprout from your " + hairDescript() + ".");
			player.antennae.type = Antennae.BEE;
			doNext(accessAntennaeMenuOld);
		}
		private function metamorphLizardTail():void {
			clearOutput();
			player.soulforce -= 100;
			if (player.tailType == Tail.NONE) outputText("\n\nYou drop onto the ground as your spine twists and grows, forcing the flesh above your " + assDescript() + " to bulge out. New bones form, one after another, building a tapered, prehensile tail onto the back of your body. <b>You now have a reptilian tail!</b>");
			else outputText("\n\nYou drop to the ground as your tail twists and grows, changing its shape in order to gradually taper to a point. It flicks back and forth, prehensile and totally under your control. <b>You now have a reptilian tail.</b>");
			player.tailType = Tail.LIZARD;
			doNext(accessPage1TailMenu);
		}








		private function metamorphTailDemonic():void {
			clearOutput();
			player.soulforce -= 100;
			if (player.tailType != Tail.NONE) {
				outputText("\n\n");
				if (player.tailType == Tail.SPIDER_ADBOMEN || player.tailType == Tail.BEE_ABDOMEN) outputText("You feel a tingling in your insectile abdomen as it stretches, narrowing, the exoskeleton flaking off as it transforms into a flexible demon-tail, complete with a round spaded tip. ");
				else outputText("You feel a tingling in your tail. You are amazed to discover it has shifted into a flexible demon-tail, complete with a round spaded tip. ");
				outputText("<b>Your tail is now demonic in appearance.</b>");
			}
			else outputText("\n\nA pain builds in your backside... growing more and more pronounced. The pressure suddenly disappears with a loud ripping and tearing noise. <b>You realize you now have a demon tail</b>... complete with a cute little spade.");
			player.tailType = Tail.DEMONIC;
			doNext(accessPage1TailMenu);
		}
		private function metamorphKitsuneSkinPattern():void {
			clearOutput();
			player.soulforce -= 100;
			outputText("\n\nYou feel a crawling sensation on the surface of your skin, starting at the small of your back and spreading to your extremities, ultimately reaching your face. You are caught by surprise when you are suddenly assaulted by a blinding flash issuing from areas of your skin, and when the spots finally clear from your vision, an assortment of glowing magical tattoos adorns your [skin]. The glow gradually fades, but the distinctive ");
			if (rand(2) == 0) outputText("angular");
			else outputText("curved");
			outputText(" markings remain, as if etched into your skin. <b>You now have Kitsune tattooed skin.</b>");
			player.skin.base.pattern = Skin.PATTERN_MAGICAL_TATTOO;
			player.skin.base.adj = "sexy tattooed";
			doNext(accessSkinPatternsMenuOld);
		}

		private function metamorphTailFox9th():void {
			clearOutput();
			player.soulforce -= 900;
			outputText("A tingling pressure builds on your backside, and your bushy tails begin to glow with an eerie, ghostly light. With a crackle of electrical energy, one of your tails splits in two, giving you " + num2Text(player.tailCount + 1) + "! <b>You now have a cluster of " + num2Text(player.tailCount + 1) + " fox-tails.</b>");
			player.tailCount++;
			doNext(accessPage2TailMenu);
		}
		private function metamorphTailFox8th():void {
			clearOutput();
			player.soulforce -= 800;
			outputText("A tingling pressure builds on your backside, and your bushy tails begin to glow with an eerie, ghostly light. With a crackle of electrical energy, one of your tails splits in two, giving you " + num2Text(player.tailCount + 1) + "! <b>You now have a cluster of " + num2Text(player.tailCount + 1) + " fox-tails.</b>");
			player.tailCount++;
			doNext(accessPage2TailMenu);
		}
		private function metamorphTailFox7th():void {
			clearOutput();
			player.soulforce -= 700;
			outputText("A tingling pressure builds on your backside, and your bushy tails begin to glow with an eerie, ghostly light. With a crackle of electrical energy, one of your tails splits in two, giving you " + num2Text(player.tailCount + 1) + "! <b>You now have a cluster of " + num2Text(player.tailCount + 1) + " fox-tails.</b>");
			player.tailCount++;
			doNext(accessPage2TailMenu);
		}
		private function metamorphTailFox6th():void {
			clearOutput();
			player.soulforce -= 600;
			outputText("A tingling pressure builds on your backside, and your bushy tails begin to glow with an eerie, ghostly light. With a crackle of electrical energy, one of your tails splits in two, giving you " + num2Text(player.tailCount + 1) + "! <b>You now have a cluster of " + num2Text(player.tailCount + 1) + " fox-tails.</b>");
			player.tailCount++;
			doNext(accessPage2TailMenu);
		}
		private function metamorphTailFox5th():void {
			clearOutput();
			player.soulforce -= 500;
			outputText("A tingling pressure builds on your backside, and your bushy tails begin to glow with an eerie, ghostly light. With a crackle of electrical energy, one of your tails splits in two, giving you " + num2Text(player.tailCount + 1) + "! <b>You now have a cluster of " + num2Text(player.tailCount + 1) + " fox-tails.</b>");
			player.tailCount++;
			doNext(accessPage2TailMenu);
		}
		private function metamorphTailFox4th():void {
			clearOutput();
			player.soulforce -= 400;
			outputText("A tingling pressure builds on your backside, and your bushy tails begin to glow with an eerie, ghostly light. With a crackle of electrical energy, one of your tails splits in two, giving you " + num2Text(player.tailCount + 1) + "! <b>You now have a cluster of " + num2Text(player.tailCount + 1) + " fox-tails.</b>");
			player.tailCount++;
			doNext(accessPage2TailMenu);
		}
		private function metamorphTailFox3rd():void {
			clearOutput();
			player.soulforce -= 300;
			outputText("A tingling pressure builds on your backside, and your bushy tails begin to glow with an eerie, ghostly light. With a crackle of electrical energy, one of your tails splits in two, giving you " + num2Text(player.tailCount + 1) + "! <b>You now have a cluster of " + num2Text(player.tailCount + 1) + " fox-tails.</b>");
			player.tailCount++;
			doNext(accessPage2TailMenu);
		}
		private function metamorphTailFox2nd():void {
			clearOutput();
			player.soulforce -= 200;
			outputText("A tingling pressure builds on your backside, and your bushy tail begins to glow with an eerie, ghostly light. With a crackle of electrical energy, your tail splits into two! <b>You now have a pair of fox-tails.</b>");
			player.tailCount++;
			doNext(accessPage2TailMenu);
		}
		private function metamorphTailFox():void {
			clearOutput();
			player.soulforce -= 100;
			if (player.tailType == Tail.NONE) outputText("A pressure builds on your backside. You feel under your [armor] and discover a strange nodule growing there that seems to be getting larger by the second. With a sudden flourish of movement, it bursts out into a long and bushy tail that sways hypnotically, as if it had a mind of its own. <b>You now have a fox's tail!</b>");
			else outputText("Pain lances through your lower back as your tail shifts violently. With one final aberrant twitch, it fluffs out into a long, bushy fox tail that whips around in an almost hypnotic fashion. <b>You now have a fox's tail!</b>");
			player.tailType = Tail.FOX;
			player.tailCount = 1;
			doNext(accessPage2TailMenu);
		}

		private function metamorphFishGills():void {
			clearOutput();
			player.soulforce -= 100;
			if (player.gills.type == Gills.ANEMONE) {
				outputText("\n\nYou feel your gills tingle, a vague numbness registering across thier feathery exterior. You watch in awe as your gill's feathery folds dry out and fall off like crisp autumn leaves. The slits of your gills then"
				 +" rearrange themselves, becoming thinner and shorter, as they shift to the sides of your neck. They now close in a way that makes them almost invisible. As you run a finger over your neck you feel little more than several"
				 +" small raised lines where they meet your skin.");
			}
			else {
				outputText("\n\nYou feel a sudden tingle on your neck. You reach up to it to feel, whats the source of it. When you touch your neck, you feel that it begins to grow serveral narrow slits which slowly grow longer. After the changes"
				 +" have stopped you quickly head to a nearby puddle to take a closer look at your neck. You realize, that your neck has grown gills allowing you to breathe under water as if you were standing on land.");
			}
			outputText("\n\n<b>You now have fish like gills!</b>");
			player.gills.type = Gills.FISH;
			doNext(accessGillsMenuOld);
		}

		private function removeOldWings():void {
			outputText("\n\nSensation fades from your  [wings] slowly but surely, leaving them dried out husks that break off to fall on the ground. Your back closes up to conceal the loss, as smooth and unbroken as the day you entered the portal.");
			player.wings.desc = "non-existant";
			player.wings.type = Wings.NONE;
		}
		private function restoreHumanLegs():void {
			if (player.isTaur()) {
				outputText("\n\nYour quadrupedal hind-quarters seizes, overbalancing your surprised front-end and causing you to stagger and fall to your side. Pain lances throughout, contorting your body into a tightly clenched ball of pain while tendons melt and bones break, melt, and regrow. When it finally stops, <b>you look down to behold your new pair of human legs</b>!");
			}
			else {
				if (player.isGoo()) {
					outputText("\n\nYour lower body rushes inward, molding into two leg-like shapes that gradually stiffen up. In moments they solidify into normal-looking legs, complete with regular, human feet.");
				}
				if (player.isNaga()) {
					outputText("\n\nYou collapse as your sinuous snake-tail tears in half, shifting into legs. The pain is immense, particularly where your new feet are forming.");
				}
				if (player.isScylla()) {
					outputText("\n\nYou collapse as your tentacle legs starts to merge. The pain is immense, particularly where your new feet are forming.");
				}
				//(Non-human -> Normal Human Legs)
				if (player.isBiped() && player.lowerBody != LowerBody.HUMAN) {
					outputText("\n\nYou collapse as your legs shift and twist. By the time the pain subsides, you notice that you have normal legs and normal feet.");
				}
				outputText(" <b>You now have normal feet!</b>");
			}
			player.lowerBody = LowerBody.HUMAN;
			player.legCount = 2;
		}
		private function restoreHumanArms():void {
			outputText("You scratch at your biceps absentmindedly, but no matter how much you scratch, it isn't getting rid of the itch. Glancing down in irritation, you discover that your ");
			if (player.arms.type == Arms.HARPY || player.arms.type == Arms.PHOENIX || player.arms.type == Arms.AVIAN) {
				outputText("feathery arms are shedding their feathery coating. The wing-like shape your arms once had is gone in a matter of moments, leaving [skin.type] behind.");
			}
			if (player.arms.type == Arms.SPIDER) {
				outputText("arms' chitinous covering is flaking away. The glossy black coating is soon gone, leaving [skin.type] behind.");
			}
			if (player.arms.type == Arms.MANTIS) {
				outputText("arms' chitinous covering is flaking away and scythe shrinking until it vanish completly. The glossy green coating is soon gone, leaving [skin.type] behind.");
			}
			if (player.arms.type == Arms.BEE) {
				outputText("arms' chitinous covering and fuzz is flaking away. The glossy black and yellow coating is soon gone, leaving [skin.type] behind.");
			}
			if (player.arms.type == Arms.SALAMANDER || player.arms.type == Arms.LIZARD || player.arms.type == Arms.DRACONIC) {
				outputText("arms' scales are flaking away. The leathery ");
				if (player.arms.type == Arms.SALAMANDER) outputText("red ");
				outputText("scales are soon gone, leaving [skin.type] behind.");
			}
			if (player.arms.type == Arms.PLANT || player.arms.type == Arms.PLANT2) {
				outputText("arms' vines are withering. Leaves also falling donw, leaving [skin.type] behind.");
			}
			if (player.arms.type == Arms.SHARK || player.arms.type == Arms.ORCA) {
				outputText("arms' fin suddenly fell down, leaving [skin.type] behind. Also webbing between your fingers slowly disappearing.");
			}
			if (player.arms.type == Arms.WOLF || player.arms.type == Arms.FOX || player.arms.type == Arms.LION || player.arms.type == Arms.YETI || player.arms.type == Arms.DEVIL || player.arms.type == Arms.CAT || player.arms.type == Arms.BOAR || player.arms.type == Arms.DISPLACER) {
				outputText("arms' [skin coat.color] fur is flaking away, leaving [skin.type] behind. Also the claws on your fingers reverts back into ordinary nails");
				if (player.arms.type == Arms.DISPLACER) outputText(" and both pairs fuse back into one");
				outputText(".");
			}
			if (player.arms.type == Arms.ELF || player.arms.type == Arms.KITSUNE || player.arms.type == Arms.ONI || player.arms.type == Arms.RAIJU || player.arms.type == Arms.PIG) {
				outputText("arms' claws retracting back into ordinary nails. You hand looks human again.");
			}
			if (player.arms.type == Arms.BAT) {
				outputText("bones are breaking down and reforming in a frenzy. Your parchment-like skin begins to fall off in clumps, leaving the mess of malformed bones that are your arms right now naked for all to see. However, even as you watch, dark blood creeps over the bone, properly aligning them before healing them over, although not in their old form. Within seconds, your bones are remade into ones alike those you were born with, in structure if nothing else, the eldritch power of your blood finally ebbing away, but not before the last of it settles and turns into a brand new patch of skin.");
			}
			outputText("\n\n");
			player.arms.type = Arms.HUMAN;
		}
	}
}
