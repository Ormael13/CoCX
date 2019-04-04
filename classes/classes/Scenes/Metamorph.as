/**
 * ...
 * @author Ormael
 */
package classes.Scenes 
{
import classes.*;
import classes.BodyParts.Antennae;
import classes.BodyParts.Arms;
import classes.BodyParts.Ears;
import classes.BodyParts.Eyes;
import classes.BodyParts.Face;
import classes.BodyParts.Gills;
import classes.BodyParts.Hair;
import classes.BodyParts.Horns;
import classes.BodyParts.LowerBody;
import classes.BodyParts.RearBody;
import classes.BodyParts.Skin;
import classes.BodyParts.Tail;
import classes.BodyParts.Tongue;
import classes.BodyParts.Wings;
import classes.Items.MutationsHelper;

use namespace CoC;
	
	public class Metamorph extends BaseContent
	{
		
		public function Metamorph() 
		{
			
		}
	
public function accessMetamorphMenu():void {
	clearOutput();
	outputText("Using some of soulforce to re-gain any body parts that your body remembered in it genetic memory.\n");
	outputText("<i>Bonus to max soulforce: " + 50 * (1 + player.perkv1(PerkLib.Metamorph)) + "</i>\n\n");
	outputText("<b>Race added to Metamorph:\n");
	outputText("Alicorn, Bat, Bee, Bicorn, Boar, Cat, Cheshire Cat, Cow, Couatl, Demon, Devil, Displacer Beast, Dragon, Elf, Fox, Gorgon, Harpy, Hellcat, Horse, Human, Kitsune, Lizard, Manticore, Mantis, Minotaur, Naga, Nekomata, Nightmare, Oni, Orc, Orca, Phoenix, Pig, Raiju, Red Panda, Salamander, Shark, Sphinx, Spider (+Drider), Unicorn, Vampire</b>");
	menu();
	addButton(10, "Page 1", accessPage1MetamorphMenu).hint("Hair, Face, Tongue, Eyes, Ears, Horns");
	addButton(11, "Page 2", accessPage2MetamorphMenu).hint("Arms, Wings, Legs");
	addButton(12, "Page 3", accessPage3MetamorphMenu).hint("Skin, Skin Patterns/Tattoes, Rear Body, Antennae, Gills, Tail");
//	addButton(13, "Page 4", accessPage4MetamorphMenu);
	if (player.hasPerk(PerkLib.JobSoulCultivator)) addButton(14, "Back", SceneLib.soulforce.accessSoulforceMenu);
	else addButton(14, "Back", playerMenu);
}

private function accessPage1MetamorphMenu():void {
	menu();
	addButton(0, "Hair", accessHairMenu);
	addButton(1, "Face(1)", accessPage1FaceMenu);
	addButton(2, "Face(2)", accessPage2FaceMenu);
	addButton(3, "Face(3)", accessPage3FaceMenu);
	addButton(4, "Face(4)", accessPage4FaceMenu);
	addButton(5, "Tongue", accessTongueMenu);
	addButton(6, "Eyes(1)", accessPage1EyesMenu);
	addButton(7, "Eyes(2)", accessPage2EyesMenu);
	addButton(8, "Ears(1)", accessPage1EarsMenu);
	addButton(9, "Ears(2)", accessPage2EarsMenu);
	addButton(10, "Ears(3)", accessPage3EarsMenu);
	addButton(11, "Horns(1)", accessPage1HornsMenu);
	addButton(12, "Horns(2)", accessPage2HornsMenu);
	addButton(14, "Back", accessMetamorphMenu);
}
private function accessHairMenu():void {
	menu();
	if (player.hasStatusEffect(StatusEffects.UnlockedHumanHair) && player.hairType != Hair.NORMAL && player.soulforce >= 500) addButton(0, "Human", metamorphHumanHair);
	else if (player.hasStatusEffect(StatusEffects.UnlockedHumanHair) && player.hairType == Hair.NORMAL) addButtonDisabled(0, "Human", "You already have normal human hair.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedHumanHair) && player.hairType != Hair.NORMAL && player.soulforce < 500) addButtonDisabled(0, "Human", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(0, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedHarpyHair) && player.hairType != Hair.FEATHER && player.soulforce >= 100) addButton(1, "Harpy", metamorphHarpyHair);
	else if (player.hasStatusEffect(StatusEffects.UnlockedHarpyHair) && player.hairType == Hair.FEATHER) addButtonDisabled(1, "Harpy", "You already have harpy hair.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedHarpyHair) && player.hairType != Hair.FEATHER && player.soulforce < 100) addButtonDisabled(1, "Harpy", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(1, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedGorgonHair) && player.hairType != Hair.GORGON && player.soulforce >= 100) addButton(6, "Gorgon", metamorphGorgonHair);
	else if (player.hasStatusEffect(StatusEffects.UnlockedGorgonHair) && player.hairType == Hair.GORGON) addButtonDisabled(6, "Gorgon", "You already have snake hair.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedGorgonHair) && player.hairType != Hair.GORGON && player.soulforce < 100) addButtonDisabled(6, "Gorgon", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(6, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedElfHair) && player.hairType != Hair.SILKEN && player.soulforce >= 100) addButton(10, "Elf", metamorphElfHair);
	else if (player.hasStatusEffect(StatusEffects.UnlockedElfHair) && player.hairType == Hair.SILKEN) addButtonDisabled(10, "Elf", "You already have elf silken hair.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedElfHair) && player.hairType != Hair.SILKEN && player.soulforce < 100) addButtonDisabled(10, "Elf", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(10, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedRaijuHair) && player.hairType != Hair.STORM && player.soulforce >= 100) addButton(11, "Raiju", metamorphRaijuHair);
	else if (player.hasStatusEffect(StatusEffects.UnlockedRaijuHair) && player.hairType == Hair.STORM) addButtonDisabled(11, "Raiju", "You already have raiju stormy hair.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedRaijuHair) && player.hairType != Hair.STORM && player.soulforce < 100) addButtonDisabled(11, "Raiju", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(11, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedHellcatBurningHair) && player.hairType != Hair.BURNING && player.soulforce >= 100) addButton(12, "Hellcat", metamorphHellcatBurningHair);
	else if (player.hasStatusEffect(StatusEffects.UnlockedHellcatBurningHair) && player.hairType == Hair.BURNING) addButtonDisabled(12, "Hellcat", "You already have hellcat burning hair.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedHellcatBurningHair) && player.hairType != Hair.BURNING && player.soulforce < 100) addButtonDisabled(12, "Hellcat", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(12, "???", "You not yet unlocked this metamorphosis!");
	addButton(14, "Back", accessPage1MetamorphMenu);
}
private function accessPage1FaceMenu():void {
	menu();
	if (player.hasStatusEffect(StatusEffects.UnlockedHumanFace) && player.faceType != Face.HUMAN && player.soulforce >= 500) addButton(0, "Human", metamorphHumanFace);
	else if (player.hasStatusEffect(StatusEffects.UnlockedHumanFace) && player.faceType == Face.HUMAN) addButtonDisabled(0, "Human", "You already have human face.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedHumanFace) && player.faceType != Face.HUMAN && player.soulforce < 500) addButtonDisabled(0, "Human", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(0, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedHorseFace) && player.faceType != Face.HORSE && player.soulforce >= 500) addButton(1, "Horse", metamorphHorseFace);
	else if (player.hasStatusEffect(StatusEffects.UnlockedHorseFace) && player.faceType == Face.HORSE) addButtonDisabled(1, "Horse", "You already have horse face.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedHorseFace) && player.faceType != Face.HORSE && player.soulforce < 500) addButtonDisabled(1, "Horse", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(1, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedCowMinotaurFace) && player.faceType != Face.COW_MINOTAUR && player.soulforce >= 100) addButton(3, "Cow/Mino", metamorphCowMinotaurFace);
	else if (player.hasStatusEffect(StatusEffects.UnlockedCowMinotaurFace) && player.faceType == Face.COW_MINOTAUR) addButtonDisabled(3, "Cow/Mino", "You already have cow/minotaur face.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedCowMinotaurFace) && player.faceType != Face.COW_MINOTAUR && player.soulforce < 100) addButtonDisabled(3, "Cow/Mino", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(3, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedSharkTeeth) && player.faceType != Face.SHARK_TEETH && player.soulforce >= 100) addButton(4, "Shark", metamorphSharkTeeth);
	else if (player.hasStatusEffect(StatusEffects.UnlockedSharkTeeth) && player.faceType == Face.SHARK_TEETH) addButtonDisabled(4, "Shark", "You already have shark teeth.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedSharkTeeth) && player.faceType != Face.SHARK_TEETH && player.soulforce < 100) addButtonDisabled(4, "Shark", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(4, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedSnakeFangs) && player.faceType != Face.SNAKE_FANGS && player.soulforce >= 100) addButton(5, "Snake", metamorphSnakeFangs);
	else if (player.hasStatusEffect(StatusEffects.UnlockedSnakeFangs) && player.faceType == Face.SNAKE_FANGS) addButtonDisabled(5, "Snake", "You already have snake fangs.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedSnakeFangs) && player.faceType != Face.SNAKE_FANGS && player.soulforce < 100) addButtonDisabled(5, "Snake", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(5, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedCatFace) && player.faceType != Face.CAT && player.soulforce >= 100) addButton(6, "Cat", metamorphCatFace);
	else if (player.hasStatusEffect(StatusEffects.UnlockedCatFace) && player.faceType == Face.CAT) addButtonDisabled(6, "Cat", "You already have cat face.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedCatFace) && player.faceType != Face.CAT && player.soulforce < 100) addButtonDisabled(6, "Cat", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(6, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedLizardFace) && player.faceType != Face.LIZARD && player.soulforce >= 100) addButton(7, "Lizard", metamorphLizardFace);
	else if (player.hasStatusEffect(StatusEffects.UnlockedLizardFace) && player.faceType == Face.LIZARD) addButtonDisabled(7, "Lizard", "You already have lizard face.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedLizardFace) && player.faceType != Face.LIZARD && player.soulforce < 100) addButtonDisabled(7, "Lizard", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(7, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedSpiderFangs) && player.faceType != Face.SPIDER_FANGS && player.soulforce >= 100) addButton(10, "Spider", metamorphSpiderFangs);
	else if (player.hasStatusEffect(StatusEffects.UnlockedSpiderFangs) && player.faceType == Face.SPIDER_FANGS) addButtonDisabled(10, "Spider", "You already have spider fangs.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedSpiderFangs) && player.faceType != Face.SPIDER_FANGS && player.soulforce < 100) addButtonDisabled(10, "Spider", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(10, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedFoxFace) && player.faceType != Face.FOX && player.soulforce >= 100) addButton(11, "Fox", metamorphFaceFox);
	else if (player.hasStatusEffect(StatusEffects.UnlockedFoxFace) && player.faceType == Face.FOX) addButtonDisabled(11, "Fox", "You already have fox face.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedFoxFace) && player.faceType != Face.FOX && player.soulforce < 100) addButtonDisabled(11, "Fox", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(11, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedDraconicFace) && player.faceType != Face.DRAGON && player.soulforce >= 100) addButton(12, "Dragon", metamorphDragonFace);
	else if (player.hasStatusEffect(StatusEffects.UnlockedDraconicFace) && player.faceType == Face.DRAGON) addButtonDisabled(12, "Dragon", "You already have dragon face.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedDraconicFace) && player.faceType != Face.DRAGON && player.soulforce < 100) addButtonDisabled(12, "Dragon", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(12, "???", "You not yet unlocked this metamorphosis!");
	addButton(14, "Back", accessPage1MetamorphMenu);
}
private function accessPage2FaceMenu():void {
	menu();
	if (player.hasStatusEffect(StatusEffects.UnlockedPigFace) && player.faceType != Face.PIG && player.soulforce >= 100) addButton(5, "Pig", metamorphPigFace);
	else if (player.hasStatusEffect(StatusEffects.UnlockedPigFace) && player.faceType == Face.PIG) addButtonDisabled(5, "Pig", "You already have pig face.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedPigFace) && player.faceType != Face.PIG && player.soulforce < 100) addButtonDisabled(5, "Pig", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(5, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedBoarFace) && player.faceType != Face.BOAR && player.soulforce >= 100) addButton(6, "Boar", metamorphBoarFace);
	else if (player.hasStatusEffect(StatusEffects.UnlockedBoarFace) && player.faceType == Face.BOAR) addButtonDisabled(6, "Boar", "You already have boar face.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedBoarFace) && player.faceType != Face.BOAR && player.soulforce < 100) addButtonDisabled(6, "Boar", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(6, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedManticoreFace) && player.faceType != Face.MANTICORE && player.soulforce >= 100) addButton(11, "Manticore", metamorphManticoreFace);
	else if (player.hasStatusEffect(StatusEffects.UnlockedManticoreFace) && player.faceType == Face.MANTICORE) addButtonDisabled(11, "Manticore", "You already have manticore face.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedManticoreFace) && player.faceType != Face.MANTICORE && player.soulforce < 100) addButtonDisabled(11, "Manticore", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(11, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedSalamanderFace) && player.faceType != Face.SALAMANDER_FANGS && player.soulforce >= 100) addButton(12, "Salamander", metamorphSalamanderFace);
	else if (player.hasStatusEffect(StatusEffects.UnlockedSalamanderFace) && player.faceType == Face.SALAMANDER_FANGS) addButtonDisabled(12, "Salamander", "You already have salamander fangs.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedSalamanderFace) && player.faceType != Face.SALAMANDER_FANGS && player.soulforce < 100) addButtonDisabled(12, "Salamander", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(12, "???", "You not yet unlocked this metamorphosis!");
	addButton(14, "Back", accessPage1MetamorphMenu);
}
private function accessPage3FaceMenu():void {
	menu();
	if (player.hasStatusEffect(StatusEffects.UnlockedOrcaFace) && player.faceType != Face.ORCA && player.soulforce >= 100) addButton(0, "Orca", metamorphOrcaFace);
	else if (player.hasStatusEffect(StatusEffects.UnlockedOrcaFace) && player.faceType == Face.ORCA) addButtonDisabled(0, "Orca", "You already have orca face.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedOrcaFace) && player.faceType != Face.ORCA && player.soulforce < 100) addButtonDisabled(0, "Orca", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(0, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedDraconicFangs) && player.faceType != Face.DRAGON_FANGS && player.soulforce >= 100) addButton(2, "Dragon(F)", metamorphDragonFangs);
	else if (player.hasStatusEffect(StatusEffects.UnlockedDraconicFangs) && player.faceType == Face.DRAGON_FANGS) addButtonDisabled(2, "Dragon(F)", "You already have dragon fangs.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedDraconicFangs) && player.faceType != Face.DRAGON_FANGS && player.soulforce < 100) addButtonDisabled(2, "Dragon(F)", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(2, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedDevilFangs) && player.faceType != Face.DEVIL_FANGS && player.soulforce >= 100) addButton(3, "Devil", metamorphDevilFangs);
	else if (player.hasStatusEffect(StatusEffects.UnlockedDevilFangs) && player.faceType == Face.DEVIL_FANGS) addButtonDisabled(3, "Devil", "You already have devil fangs.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedDevilFangs) && player.faceType != Face.DEVIL_FANGS && player.soulforce < 100) addButtonDisabled(3, "Devil", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(3, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedOniFace) && player.faceType != Face.ONI_TEETH && player.soulforce >= 100) addButton(4, "Oni", metamorphOniFace);
	else if (player.hasStatusEffect(StatusEffects.UnlockedOniFace) && player.faceType == Face.ONI_TEETH) addButtonDisabled(4, "Oni", "You already have oni fangs.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedOniFace) && player.faceType != Face.ONI_TEETH && player.soulforce < 100) addButtonDisabled(4, "Oni", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(4, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedRaijuFace) && player.faceType != Face.RAIJU_FANGS && player.soulforce >= 100) addButton(5, "Raiju", metamorphRaijuFace);
	else if (player.hasStatusEffect(StatusEffects.UnlockedRaijuFace) && player.faceType == Face.RAIJU_FANGS) addButtonDisabled(5, "Raiju", "You already have raiju fangs.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedRaijuFace) && player.faceType != Face.RAIJU_FANGS && player.soulforce < 100) addButtonDisabled(5, "Raiju", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(5, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedVampireFace) && player.faceType != Face.VAMPIRE && player.soulforce >= 100) addButton(6, "Vampire", metamorphVampireFace);
	else if (player.hasStatusEffect(StatusEffects.UnlockedVampireFace) && player.faceType == Face.VAMPIRE) addButtonDisabled(6, "Vampire", "You already have vampire fangs.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedVampireFace) && player.faceType != Face.VAMPIRE && player.soulforce < 100) addButtonDisabled(6, "Vampire", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(6, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedRedPandaFace) && player.faceType != Face.RED_PANDA && player.soulforce >= 100) addButton(9, "Red Panda", metamorphRedPandaFace);
	else if (player.hasStatusEffect(StatusEffects.UnlockedRedPandaFace) && player.faceType == Face.RED_PANDA) addButtonDisabled(9, "Red Panda", "You already have red panda face.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedRedPandaFace) && player.faceType != Face.RED_PANDA && player.soulforce < 100) addButtonDisabled(9, "Red Panda", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(9, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedCatFangs) && player.faceType != Face.CAT_CANINES && player.soulforce >= 100) addButton(10, "CatCannines", metamorphCatFangs);
	else if (player.hasStatusEffect(StatusEffects.UnlockedCatFangs) && player.faceType == Face.CAT_CANINES) addButtonDisabled(10, "CatCannines", "You already have cat cannines.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedCatFangs) && player.faceType != Face.CAT_CANINES && player.soulforce < 100) addButtonDisabled(10, "CatCannines", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(10, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedCheshireFace) && player.faceType != Face.CHESHIRE && player.soulforce >= 200) addButton(11, "CheshCatFace", metamorphCheshireCatFace);
	else if (player.hasStatusEffect(StatusEffects.UnlockedCheshireFace) && player.faceType == Face.CHESHIRE) addButtonDisabled(11, "CheshCatFace", "You already have cheshire cat face.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedCheshireFace) && player.faceType != Face.CHESHIRE && player.soulforce < 100) addButtonDisabled(11, "CheshCatFace", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(11, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedCheshireSmile) && player.faceType != Face.CHESHIRE_SMILE && player.soulforce >= 200) addButton(12, "CheshireSmile", metamorphCheshireCatFangs);
	else if (player.hasStatusEffect(StatusEffects.UnlockedCheshireSmile) && player.faceType == Face.CHESHIRE_SMILE) addButtonDisabled(12, "CheshireSmile", "You already have cheshire cat smile.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedCheshireSmile) && player.faceType != Face.CHESHIRE_SMILE && player.soulforce < 100) addButtonDisabled(12, "CheshireSmile", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(12, "???", "You not yet unlocked this metamorphosis!");
	addButton(14, "Back", accessPage1MetamorphMenu);
}
private function accessPage4FaceMenu():void {
	menu();
	if (player.hasStatusEffect(StatusEffects.UnlockedOrcFangs) && player.faceType != Face.ORC_FANGS && player.soulforce >= 100) addButton(1, "Orc", metamorphOrcFangs);
	else if (player.hasStatusEffect(StatusEffects.UnlockedOrcFangs) && player.faceType == Face.ORC_FANGS) addButtonDisabled(1, "Orc", "You already have orc fangs.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedOrcFangs) && player.faceType != Face.ORC_FANGS && player.soulforce < 100) addButtonDisabled(1, "Orc", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(1, "???", "You not yet unlocked this metamorphosis!");
	addButton(14, "Back", accessPage1MetamorphMenu);
}
private function accessTongueMenu():void {
	menu();
	if (player.hasStatusEffect(StatusEffects.UnlockedHumanTongue) && player.tongue.type != Tongue.HUMAN && player.soulforce >= 500) addButton(0, "Human", metamorphHumanTongue);
	else if (player.hasStatusEffect(StatusEffects.UnlockedHumanTongue) && player.tongue.type == Tongue.HUMAN) addButtonDisabled(0, "Human", "You already have human tongue.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedHumanTongue) && player.tongue.type != Tongue.HUMAN && player.soulforce < 500) addButtonDisabled(0, "Human", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(0, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedSnakeTongue) && player.tongue.type != Tongue.SNAKE && player.soulforce >= 100) addButton(1, "Snake", metamorphSnakeTongue);
	else if (player.hasStatusEffect(StatusEffects.UnlockedSnakeTongue) && player.tongue.type == Tongue.SNAKE) addButtonDisabled(1, "Snake", "You already have snake tongue.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedSnakeTongue) && player.tongue.type != Tongue.SNAKE && player.soulforce < 100) addButtonDisabled(1, "Snake", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(1, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedDemonTonuge) && player.tongue.type != Tongue.DEMONIC && player.soulforce >= 100) addButton(2, "Demon", metamorphTonugeDemonic);
	else if (player.hasStatusEffect(StatusEffects.UnlockedDemonTonuge) && player.tongue.type == Tongue.DEMONIC) addButtonDisabled(2, "Demon", "You already have demon tongue.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedDemonTonuge) && player.tongue.type != Tongue.DEMONIC && player.soulforce < 100) addButtonDisabled(2, "Demon", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(2, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedDraconicTongue) && player.tongue.type != Tongue.DRACONIC && player.soulforce >= 100) addButton(3, "Dragon", metamorphDragonTonuge);
	else if (player.hasStatusEffect(StatusEffects.UnlockedDraconicTongue) && player.tongue.type == Tongue.DRACONIC) addButtonDisabled(3, "Dragon", "You already have dragon tongue.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedDraconicTongue) && player.tongue.type != Tongue.DRACONIC && player.soulforce < 100) addButtonDisabled(3, "Dragon", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(3, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedCatTongue) && player.tongue.type != Tongue.CAT && player.soulforce >= 100) addButton(5, "Cat", metamorphCatTongue);
	else if (player.hasStatusEffect(StatusEffects.UnlockedCatTongue) && player.tongue.type == Tongue.CAT) addButtonDisabled(5, "Cat", "You already have cat tongue.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedCatTongue) && player.tongue.type != Tongue.CAT && player.soulforce < 100) addButtonDisabled(5, "Cat", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(5, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedElfTongue) && player.tongue.type != Tongue.ELF && player.soulforce >= 100) addButton(6, "Elf", metamorphElfTongue);
	else if (player.hasStatusEffect(StatusEffects.UnlockedElfTongue) && player.tongue.type == Tongue.ELF) addButtonDisabled(6, "Elf", "You already have elf tongue.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedElfTongue) && player.tongue.type != Tongue.ELF && player.soulforce < 100) addButtonDisabled(6, "Elf", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(6, "???", "You not yet unlocked this metamorphosis!");
	addButton(14, "Back", accessPage1MetamorphMenu);
}
private function accessPage1EyesMenu():void {
	menu();
	if (player.hasStatusEffect(StatusEffects.UnlockedHumanEyes) && player.eyes.type != Eyes.HUMAN && player.soulforce >= 500) addButton(0, "Human", metamorphHumanEyes);
	else if (player.hasStatusEffect(StatusEffects.UnlockedHumanEyes) && player.eyes.type == Eyes.HUMAN) addButtonDisabled(0, "Human", "You already have human eyes.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedHumanEyes) && player.eyes.type != Eyes.HUMAN && player.soulforce < 500) addButtonDisabled(0, "Human", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(0, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedSpiderFourEyes) && player.eyes.type != Eyes.FOUR_SPIDER_EYES && player.soulforce >= 100) addButton(1, "Spider", metamorphSpiderFourEyes);
	else if (player.hasStatusEffect(StatusEffects.UnlockedSpiderFourEyes) && player.eyes.type == Eyes.FOUR_SPIDER_EYES) addButtonDisabled(1, "Spider", "You already have spider four eyes.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedSpiderFourEyes) && player.eyes.type != Eyes.FOUR_SPIDER_EYES && player.soulforce < 100) addButtonDisabled(1, "Spider", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(1, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedCatEyes) && player.eyes.type != Eyes.CAT_SLITS && player.soulforce >= 100) addButton(3, "Cat", metamorphCatEyes);
	else if (player.hasStatusEffect(StatusEffects.UnlockedCatEyes) && player.eyes.type == Eyes.CAT_SLITS) addButtonDisabled(3, "Cat", "You already have cat eyes.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedCatEyes) && player.eyes.type != Eyes.CAT_SLITS && player.soulforce < 100) addButtonDisabled(3, "Cat", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(3, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedGorgonEyes) && player.eyes.type != Eyes.GORGON && player.soulforce >= 100) addButton(4, "Gorgon", metamorphGorgonEyes);
	else if (player.hasStatusEffect(StatusEffects.UnlockedGorgonEyes) && player.eyes.type == Eyes.GORGON) addButtonDisabled(4, "Gorgon", "You already have gorgon eyes.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedGorgonEyes) && player.eyes.type != Eyes.GORGON && player.soulforce < 100) addButtonDisabled(4, "Gorgon", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(4, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedManticoreEyes) && player.eyes.type != Eyes.MANTICORE && player.soulforce >= 100) addButton(6, "Manticore", metamorphManticoreEyes);
	else if (player.hasStatusEffect(StatusEffects.UnlockedManticoreEyes) && player.eyes.type == Eyes.MANTICORE) addButtonDisabled(6, "Manticore", "You already have manticore eyes.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedManticoreEyes) && player.eyes.type != Eyes.MANTICORE && player.soulforce < 100) addButtonDisabled(6, "Manticore", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(6, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedFoxEyes) && player.eyes.type != Eyes.FOX && player.soulforce >= 100) addButton(7, "Fox", metamorphEyesFox);
	else if (player.hasStatusEffect(StatusEffects.UnlockedFoxEyes) && player.eyes.type == Eyes.FOX) addButtonDisabled(7, "Fox", "You already have fox eyes.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedFoxEyes) && player.eyes.type != Eyes.FOX && player.soulforce < 100) addButtonDisabled(7, "Fox", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(7, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedLizardEyes) && player.eyes.type != Eyes.REPTILIAN && player.soulforce >= 100) addButton(8, "Lizard", metamorphLizardEyes);
	else if (player.hasStatusEffect(StatusEffects.UnlockedLizardEyes) && player.eyes.type == Eyes.REPTILIAN) addButtonDisabled(8, "Lizard", "You already have lizard eyes.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedLizardEyes) && player.eyes.type != Eyes.REPTILIAN && player.soulforce < 100) addButtonDisabled(8, "Lizard", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(8, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedSnakeEyes) && player.eyes.type != Eyes.SNAKE && player.soulforce >= 100) addButton(9, "Snake", metamorphSnakeEyes);
	else if (player.hasStatusEffect(StatusEffects.UnlockedSnakeEyes) && player.eyes.type == Eyes.SNAKE) addButtonDisabled(9, "Snake", "You already have snake eyes.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedSnakeEyes) && player.eyes.type != Eyes.SNAKE && player.soulforce < 100) addButtonDisabled(9, "Snake", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(9, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedDraconicEyes) && player.eyes.type != Eyes.DRAGON && player.soulforce >= 100) addButton(10, "Dragon", metamorphDragonEyes);
	else if (player.hasStatusEffect(StatusEffects.UnlockedDraconicEyes) && player.eyes.type == Eyes.DRAGON) addButtonDisabled(10, "Dragon", "You already have dragon eyes.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedDraconicEyes) && player.eyes.type != Eyes.DRAGON && player.soulforce < 100) addButtonDisabled(10, "Dragon", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(10, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedDevilEyes) && player.eyes.type != Eyes.DEVIL && player.soulforce >= 100) addButton(11, "Devil", metamorphDevilEyes);
	else if (player.hasStatusEffect(StatusEffects.UnlockedDevilEyes) && player.eyes.type == Eyes.DEVIL) addButtonDisabled(11, "Devil", "You already have devil eyes.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedDevilEyes) && player.eyes.type != Eyes.DEVIL && player.soulforce < 100) addButtonDisabled(11, "Devil", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(11, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedOniEyes) && player.eyes.type != Eyes.ONI && player.soulforce >= 100) addButton(12, "Oni", metamorphOniEyes);
	else if (player.hasStatusEffect(StatusEffects.UnlockedOniEyes) && player.eyes.type == Eyes.ONI) addButtonDisabled(12, "Oni", "You already have oni eyes.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedOniEyes) && player.eyes.type != Eyes.ONI && player.soulforce < 100) addButtonDisabled(12, "Oni", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(12, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedElfEyes) && player.eyes.type != Eyes.ELF && player.soulforce >= 100) addButton(13, "Elf", metamorphElfEyes);
	else if (player.hasStatusEffect(StatusEffects.UnlockedElfEyes) && player.eyes.type == Eyes.ELF) addButtonDisabled(13, "Elf", "You already have elf eyes.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedElfEyes) && player.eyes.type != Eyes.ELF && player.soulforce < 100) addButtonDisabled(13, "Elf", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(13, "???", "You not yet unlocked this metamorphosis!");
	addButton(14, "Back", accessPage1MetamorphMenu);
}
private function accessPage2EyesMenu():void {
	menu();
	if (player.hasStatusEffect(StatusEffects.UnlockedRaijuEyes) && player.eyes.type != Eyes.RAIJU && player.soulforce >= 100) addButton(0, "Raiju", metamorphRaijuEyes);
	else if (player.hasStatusEffect(StatusEffects.UnlockedRaijuEyes) && player.eyes.type == Eyes.RAIJU) addButtonDisabled(0, "Raiju", "You already have raiju eyes.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedRaijuEyes) && player.eyes.type != Eyes.RAIJU && player.soulforce < 100) addButtonDisabled(0, "Raiju", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(0, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedVampireEyes) && player.eyes.type != Eyes.VAMPIRE && player.soulforce >= 100) addButton(1, "Vampire", metamorphVampireEyes);
	else if (player.hasStatusEffect(StatusEffects.UnlockedVampireEyes) && player.eyes.type == Eyes.VAMPIRE) addButtonDisabled(1, "Vampire", "You already have vampire eyes.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedVampireEyes) && player.eyes.type != Eyes.VAMPIRE && player.soulforce < 100) addButtonDisabled(1, "Vampire", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(1, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedHellcatInfernalEyes) && player.eyes.type != Eyes.INFERNAL && player.soulforce >= 100) addButton(5, "Hellcat", metamorphHellcatInfernalEyes);
	else if (player.hasStatusEffect(StatusEffects.UnlockedHellcatInfernalEyes) && player.eyes.type == Eyes.INFERNAL) addButtonDisabled(5, "Hellcat", "You already have hellcat infernal eyes.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedHellcatInfernalEyes) && player.eyes.type != Eyes.INFERNAL && player.soulforce < 100) addButtonDisabled(5, "Hellcat", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(5, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedOrcEyes) && player.eyes.type != Eyes.ORC && player.soulforce >= 100) addButton(6, "Orc", metamorphOrcEyes);
	else if (player.hasStatusEffect(StatusEffects.UnlockedOrcEyes) && player.eyes.type == Eyes.ORC) addButtonDisabled(6, "Orc", "You already have orc eyes.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedOrcEyes) && player.eyes.type != Eyes.ORC && player.soulforce < 100) addButtonDisabled(6, "Orc", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(6, "???", "You not yet unlocked this metamorphosis!");
	addButton(14, "Back", accessPage1MetamorphMenu);
}
private function accessPage1EarsMenu():void {
	menu();
	if (player.hasStatusEffect(StatusEffects.UnlockedHumanEars) && player.ears.type != Ears.HUMAN && player.soulforce >= 500) addButton(0, "Human", metamorphHumanEars);
	else if (player.hasStatusEffect(StatusEffects.UnlockedHumanEars) && player.ears.type == Ears.HUMAN) addButtonDisabled(0, "Human", "You already have human ears.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedHumanEars) && player.ears.type != Ears.HUMAN && player.soulforce < 500) addButtonDisabled(0, "Human", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(0, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedHorseEars) && player.ears.type != Ears.HUMAN && player.soulforce >= 500) addButton(1, "Horse", metamorphHorseEars);
	else if (player.hasStatusEffect(StatusEffects.UnlockedHorseEars) && player.ears.type == Ears.HUMAN) addButtonDisabled(1, "Horse", "You already have horse ears.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedHorseEars) && player.ears.type != Ears.HUMAN && player.soulforce < 500) addButtonDisabled(1, "Horse", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(1, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedCowEars) && player.ears.type != Ears.COW && player.soulforce >= 100) addButton(3, "Cow", metamorphCowEars);
	else if (player.hasStatusEffect(StatusEffects.UnlockedCowEars) && player.ears.type == Ears.COW) addButtonDisabled(3, "Cow", "You already have cow ears.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedCowEars) && player.ears.type != Ears.COW && player.soulforce < 100) addButtonDisabled(3, "Cow", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(3, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedElfinEars) && player.ears.type != Ears.ELFIN && player.soulforce >= 100) addButton(4, "Elfin", metamorphElfinEars);
	else if (player.hasStatusEffect(StatusEffects.UnlockedElfinEars) && player.ears.type == Ears.ELFIN) addButtonDisabled(4, "Elfin", "You already have elfin ears.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedElfinEars) && player.ears.type != Ears.ELFIN && player.soulforce < 100) addButtonDisabled(4, "Elfin", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(4, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedCatEars) && player.ears.type != Ears.CAT && player.soulforce >= 100) addButton(5, "Cat", metamorphCatEars);
	else if (player.hasStatusEffect(StatusEffects.UnlockedCatEars) && player.ears.type == Ears.CAT) addButtonDisabled(5, "Cat", "You already have cat ears.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedCatEars) && player.ears.type != Ears.CAT && player.soulforce < 100) addButtonDisabled(5, "Cat", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(5, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedLizardEars) && player.ears.type != Ears.LIZARD && player.soulforce >= 100) addButton(6, "Lizard", metamorphLizardEars);
	else if (player.hasStatusEffect(StatusEffects.UnlockedLizardEars) && player.ears.type == Ears.LIZARD) addButtonDisabled(6, "Lizard", "You already have lizard ears.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedLizardEars) && player.ears.type != Ears.LIZARD && player.soulforce < 100) addButtonDisabled(6, "Lizard", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(6, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedFoxEars) && player.ears.type != Ears.FOX && player.soulforce >= 100) addButton(9, "Fox", metamorphEarsFox);
	else if (player.hasStatusEffect(StatusEffects.UnlockedFoxEars) && player.ears.type == Ears.FOX) addButtonDisabled(9, "Fox", "You already have fox ears.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedFoxEars) && player.ears.type != Ears.FOX && player.soulforce < 100) addButtonDisabled(9, "Fox", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(9, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedDraconicEars) && player.ears.type != Ears.DRAGON && player.soulforce >= 100) addButton(10, "Dragon", metamorphDragonEars);
	else if (player.hasStatusEffect(StatusEffects.UnlockedDraconicEars) && player.ears.type == Ears.DRAGON) addButtonDisabled(10, "Dragon", "You already have dragon ears.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedDraconicEars) && player.ears.type != Ears.DRAGON && player.soulforce < 100) addButtonDisabled(10, "Dragon", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(10, "???", "You not yet unlocked this metamorphosis!");
	addButton(14, "Back", accessPage1MetamorphMenu);
}
private function accessPage2EarsMenu():void {
	menu();
	if (player.hasStatusEffect(StatusEffects.UnlockedPigEars) && player.ears.type != Ears.PIG && player.soulforce >= 100) addButton(0, "Pig", metamorphPigEars);
	else if (player.hasStatusEffect(StatusEffects.UnlockedPigEars) && player.ears.type == Ears.PIG) addButtonDisabled(0, "Pig", "You already have pig ears.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedPigEars) && player.ears.type != Ears.PIG && player.soulforce < 100) addButtonDisabled(0, "Pig", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(0, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedLionEars) && player.ears.type != Ears.LION && player.soulforce >= 100) addButton(5, "Lion", metamorphLionEars);
	else if (player.hasStatusEffect(StatusEffects.UnlockedLionEars) && player.ears.type == Ears.LION) addButtonDisabled(5, "Lion", "You already have lion ears.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedLionEars) && player.ears.type != Ears.LION && player.soulforce < 100) addButtonDisabled(5, "Lion", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(5, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedOrcaEars) && player.ears.type != Ears.ORCA && player.soulforce >= 100) addButton(7, "Orca", metamorphOrcaEars);
	else if (player.hasStatusEffect(StatusEffects.UnlockedOrcaEars) && player.ears.type == Ears.ORCA) addButtonDisabled(7, "Orca", "You already have orca ears.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedOrcaEars) && player.ears.type != Ears.ORCA && player.soulforce < 100) addButtonDisabled(7, "Orca", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(7, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedSnakeEars) && player.ears.type != Ears.SNAKE && player.soulforce >= 100) addButton(8, "Snake", metamorphSnakeEars);
	else if (player.hasStatusEffect(StatusEffects.UnlockedSnakeEars) && player.ears.type == Ears.SNAKE) addButtonDisabled(8, "Snake", "You already have snake ears.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedSnakeEars) && player.ears.type != Ears.SNAKE && player.soulforce < 100) addButtonDisabled(8, "Snake", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(8, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedGoatEars) && player.ears.type != Ears.GOAT && player.soulforce >= 100) addButton(9, "Goat", metamorphGoatEars);
	else if (player.hasStatusEffect(StatusEffects.UnlockedGoatEars) && player.ears.type == Ears.GOAT) addButtonDisabled(9, "Goat", "You already have goat ears.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedGoatEars) && player.ears.type != Ears.GOAT && player.soulforce < 100) addButtonDisabled(9, "Goat", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(9, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedOniEars) && player.ears.type != Ears.ONI && player.soulforce >= 100) addButton(10, "Oni", metamorphOniEars);
	else if (player.hasStatusEffect(StatusEffects.UnlockedOniEars) && player.ears.type == Ears.ONI) addButtonDisabled(10, "Oni", "You already have oni ears.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedOniEars) && player.ears.type != Ears.ONI && player.soulforce < 100) addButtonDisabled(10, "Oni", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(10, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedElfEars) && player.ears.type != Ears.ELVEN && player.soulforce >= 100) addButton(11, "Elf", metamorphElfEars);
	else if (player.hasStatusEffect(StatusEffects.UnlockedElfEars) && player.ears.type == Ears.ELVEN) addButtonDisabled(11, "Elf", "You already have elf ears.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedElfEars) && player.ears.type != Ears.ELVEN && player.soulforce < 100) addButtonDisabled(11, "Elf", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(11, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedRaijuEars) && player.ears.type != Ears.WEASEL && player.soulforce >= 100) addButton(12, "Raiju", metamorphRaijuEars);
	else if (player.hasStatusEffect(StatusEffects.UnlockedRaijuEars) && player.ears.type == Ears.WEASEL) addButtonDisabled(12, "Raiju", "You already have raiju ears.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedRaijuEars) && player.ears.type != Ears.WEASEL && player.soulforce < 100) addButtonDisabled(12, "Raiju", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(12, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedBatEars) && player.ears.type != Ears.BAT && player.soulforce >= 100) addButton(13, "Bat", metamorphBatEars);
	else if (player.hasStatusEffect(StatusEffects.UnlockedBatEars) && player.ears.type == Ears.BAT) addButtonDisabled(13, "Bat", "You already have bat ears.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedBatEars) && player.ears.type != Ears.BAT && player.soulforce < 100) addButtonDisabled(13, "Bat", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(13, "???", "You not yet unlocked this metamorphosis!");
	addButton(14, "Back", accessPage1MetamorphMenu);
}
private function accessPage3EarsMenu():void {
	menu();
	if (player.hasStatusEffect(StatusEffects.UnlockedVampireEars) && player.ears.type != Ears.VAMPIRE && player.soulforce >= 100) addButton(0, "Vampire", metamorphVampireEars);
	else if (player.hasStatusEffect(StatusEffects.UnlockedVampireEars) && player.ears.type == Ears.VAMPIRE) addButtonDisabled(0, "Vampire", "You already have vampire ears.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedVampireEars) && player.ears.type != Ears.VAMPIRE && player.soulforce < 100) addButtonDisabled(0, "Vampire", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(0, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedRedPandaEars) && player.ears.type != Ears.RED_PANDA && player.soulforce >= 100) addButton(1, "Red Panda", metamorphRedPandaEars);
	else if (player.hasStatusEffect(StatusEffects.UnlockedRedPandaEars) && player.ears.type == Ears.RED_PANDA) addButtonDisabled(1, "Red Panda", "You already have red panda ears.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedRedPandaEars) && player.ears.type != Ears.RED_PANDA && player.soulforce < 100) addButtonDisabled(1, "Red Panda", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(1, "???", "You not yet unlocked this metamorphosis!");
	addButton(14, "Back", accessPage1MetamorphMenu);
}
private function accessPage1HornsMenu():void {
	menu();
	if (player.hasStatusEffect(StatusEffects.UnlockedHumanNoHorns) && player.horns.type != Horns.NONE && player.soulforce >= 500) addButton(0, "Human", metamorphHumanNoHorns);
	else if (player.hasStatusEffect(StatusEffects.UnlockedHumanNoHorns) && player.horns.type == Horns.NONE) addButtonDisabled(0, "Human", "You already not have horns.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedHumanNoHorns) && player.horns.type != Horns.NONE && player.soulforce < 500) addButtonDisabled(0, "Human", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(0, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedDemonHorns) && player.horns.type != Horns.DEMON && player.soulforce >= 100) addButton(1, "Demon", metamorphHornsDemonic);
	else if (player.hasStatusEffect(StatusEffects.UnlockedDemonHorns) && player.horns.type == Horns.DEMON) addButtonDisabled(1, "Demon", "You already have demon horns.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedDemonHorns) && player.horns.type != Horns.DEMON && player.soulforce < 100) addButtonDisabled(1, "Demon", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(1, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedCowMinotaurHorns) && player.horns.type != Horns.COW_MINOTAUR && player.soulforce >= 100) addButton(2, "Cow/Mino", metamorphCowMinotaurHorns);
	else if (player.hasStatusEffect(StatusEffects.UnlockedCowMinotaurHorns) && player.horns.type == Horns.COW_MINOTAUR) addButtonDisabled(2, "Cow/Mino", "You already have cow/minotaur horns.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedCowMinotaurHorns) && player.horns.type != Horns.COW_MINOTAUR && player.soulforce < 100) addButtonDisabled(2, "Cow/Mino", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(2, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedDraconicX2) && player.horns.type != Horns.DRACONIC_X2 && player.soulforce >= 100) addButton(3, "DraconicX2", metamorphHornsDraconicX2);
	else if (player.hasStatusEffect(StatusEffects.UnlockedDraconicX2) && player.horns.type == Horns.DRACONIC_X2) addButtonDisabled(3, "DraconicX2", "You already have draconic horns.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedDraconicX2) && player.horns.type != Horns.DRACONIC_X2 && player.soulforce < 100) addButtonDisabled(3, "DraconicX2", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(3, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedDraconicX4) && player.horns.type == Horns.DRACONIC_X2 && player.soulforce >= 200) addButton(4, "DraconicX4", metamorphHornsDraconicX4);
	else if (player.hasStatusEffect(StatusEffects.UnlockedDraconicX4) && player.horns.type == Horns.DRACONIC_X4_12_INCH_LONG) addButtonDisabled(4, "DraconicX4", "You already have two pairs of drconic horns.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedDraconicX4) && player.horns.type == Horns.DRACONIC_X2 && player.soulforce < 200) addButtonDisabled(4, "DraconicX4", "You not have enough Soulforce for this metamorphosis.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedDraconicX4) && player.horns.type != Horns.DRACONIC_X2) addButtonDisabled(4, "DraconicX4", "You not have proper type of horns for this metamorphosis.");
	else addButtonDisabled(4, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedGoatHorns) && player.horns.type != Horns.GOAT && player.soulforce >= 100) addButton(6, "Goat", metamorphGoatHorns);
	else if (player.hasStatusEffect(StatusEffects.UnlockedGoatHorns) && player.horns.type == Horns.GOAT) addButtonDisabled(6, "Goat", "You already have goat horns.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedGoatHorns) && player.horns.type != Horns.GOAT && player.soulforce < 100) addButtonDisabled(6, "Goat", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(6, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedUnicornHorn) && player.horns.type != Horns.UNICORN && player.soulforce >= 100) addButton(7, "Unicorn", metamorphUnicornHorn);
	else if (player.hasStatusEffect(StatusEffects.UnlockedUnicornHorn) && player.horns.type == Horns.UNICORN) addButtonDisabled(7, "Unicorn", "You already have unicron horn.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedUnicornHorn) && player.horns.type != Horns.UNICORN && player.soulforce < 100) addButtonDisabled(7, "Unicorn", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(7, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedOniSingleHorn) && player.horns.type != Horns.ONI && player.soulforce >= 100) addButton(12, "Oni", metamorphOniSingleHorn);
	else if (player.hasStatusEffect(StatusEffects.UnlockedOniSingleHorn) && player.horns.type == Horns.ONI) addButtonDisabled(12, "Oni", "You already have oni horns.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedOniSingleHorn) && player.horns.type != Horns.ONI && player.soulforce < 100) addButtonDisabled(12, "Oni", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(12, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedOniTwinHorns) && player.horns.type != Horns.ONI_X2 && player.soulforce >= 100) addButton(13, "OniX2", metamorphOniDualHorns);
	else if (player.hasStatusEffect(StatusEffects.UnlockedOniTwinHorns) && player.horns.type == Horns.ONI_X2) addButtonDisabled(13, "OniX2", "You already have oni horns.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedOniTwinHorns) && player.horns.type != Horns.ONI_X2 && player.soulforce < 100) addButtonDisabled(13, "OniX2", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(13, "???", "You not yet unlocked this metamorphosis!");
	addButton(14, "Back", accessPage1MetamorphMenu);
}
private function accessPage2HornsMenu():void {
	menu();
	if (player.hasStatusEffect(StatusEffects.UnlockedBicornHorns) && player.horns.type != Horns.BICORN && player.soulforce >= 100) addButton(0, "Bicorn", metamorphBicornHorns);
	else if (player.hasStatusEffect(StatusEffects.UnlockedBicornHorns) && player.horns.type == Horns.BICORN) addButtonDisabled(0, "Bicorn", "You already have goat horns.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedBicornHorns) && player.horns.type != Horns.BICORN && player.soulforce < 100) addButtonDisabled(0, "Bicorn", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(0, "???", "You not yet unlocked this metamorphosis!");
	addButton(14, "Back", accessPage1MetamorphMenu);
}

private function accessPage2MetamorphMenu():void {
	menu();
	addButton(0, "Arms(1)", accessPage1ArmsMenu);
	addButton(1, "Arms(2)", accessPage2ArmsMenu);
	addButton(2, "Arms(3)", accessPage3ArmsMenu);
	addButton(3, "Wings(1)", accessPage1WingsMenu);
	addButton(4, "Wings(2)", accessPage2WingsMenu);
	addButton(5, "Wings(3)", accessPage3WingsMenu);
	addButton(6, "Legs(1)", accessPage1LegsMenu);//przenieść do page 3 a z page 3 przenieść tutaj rear body i gills??
	addButton(7, "Legs(2)", accessPage2LegsMenu);
	addButton(8, "Legs(3)", accessPage3LegsMenu);
	addButton(9, "Legs(4)", accessPage4LegsMenu);
	addButton(14, "Back", accessMetamorphMenu);
}
private function accessPage1ArmsMenu():void {
	menu();
	if (player.hasStatusEffect(StatusEffects.UnlockedHumanArms) && player.arms.type != Arms.HUMAN && player.soulforce >= 500) addButton(0, "Human", metamorphHumanArms);
	else if (player.hasStatusEffect(StatusEffects.UnlockedHumanArms) && player.arms.type == Arms.HUMAN) addButtonDisabled(0, "Human", "You already have human arms.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedHumanArms) && player.arms.type != Arms.HUMAN && player.soulforce < 500) addButtonDisabled(0, "Human", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(0, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedHarpyArms) && player.arms.type != Arms.HARPY && player.soulforce >= 100) addButton(1, "Harpy", metamorphHarpyArms);
	else if (player.hasStatusEffect(StatusEffects.UnlockedHarpyArms) && player.arms.type == Arms.HARPY) addButtonDisabled(1, "Harpy", "You already have harpy arms.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedHarpyArms) && player.arms.type != Arms.HARPY && player.soulforce < 100) addButtonDisabled(1, "Harpy", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(1, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedSpiderArms) && player.arms.type != Arms.SPIDER && player.soulforce >= 100) addButton(2, "Spider", metamorphSpiderArms);
	else if (player.hasStatusEffect(StatusEffects.UnlockedSpiderArms) && player.arms.type == Arms.SPIDER) addButtonDisabled(2, "Spider", "You already have spider arms.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedSpiderArms) && player.arms.type != Arms.SPIDER && player.soulforce < 100) addButtonDisabled(2, "Spider", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(2, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedMantisArms) && player.arms.type != Arms.MANTIS && player.soulforce >= 100) addButton(3, "Mantis", metamorphMantisArms);
	else if (player.hasStatusEffect(StatusEffects.UnlockedMantisArms) && player.arms.type == Arms.MANTIS) addButtonDisabled(3, "Mantis", "You already have mantis arms.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedMantisArms) && player.arms.type != Arms.MANTIS && player.soulforce < 100) addButtonDisabled(3, "Mantis", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(3, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedBeeArms) && player.arms.type != Arms.BEE && player.soulforce >= 100) addButton(4, "Bee", metamorphBeeArms);
	else if (player.hasStatusEffect(StatusEffects.UnlockedBeeArms) && player.arms.type == Arms.BEE) addButtonDisabled(4, "Bee", "You already have bee arms.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedBeeArms) && player.arms.type != Arms.BEE && player.soulforce < 100) addButtonDisabled(4, "Bee", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(4, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedSalamanderArms) && player.arms.type != Arms.SALAMANDER && player.soulforce >= 100) addButton(5, "Salamander", metamorphSalamanderArms);
	else if (player.hasStatusEffect(StatusEffects.UnlockedSalamanderArms) && player.arms.type == Arms.SALAMANDER) addButtonDisabled(5, "Salamander", "You already have salamander arms.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedSalamanderArms) && player.arms.type != Arms.SALAMANDER && player.soulforce < 100) addButtonDisabled(5, "Salamander", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(5, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedPhoenixArms) && player.arms.type != Arms.PHOENIX && player.soulforce >= 100) addButton(6, "Phoenix", metamorphPhoenixArms);
	else if (player.hasStatusEffect(StatusEffects.UnlockedPhoenixArms) && player.arms.type == Arms.PHOENIX) addButtonDisabled(6, "Phoenix", "You already have phoenix arms.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedPhoenixArms) && player.arms.type != Arms.PHOENIX && player.soulforce < 100) addButtonDisabled(6, "Phoenix", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(6, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedSharkArms) && player.arms.type != Arms.SHARK && player.soulforce >= 100) addButton(8, "Shark", metamorphSharkArms);
	else if (player.hasStatusEffect(StatusEffects.UnlockedSharkArms) && player.arms.type == Arms.SHARK) addButtonDisabled(8, "Shark", "You already have shark arms.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedSharkArms) && player.arms.type != Arms.SHARK && player.soulforce < 100) addButtonDisabled(8, "Shark", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(8, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedLionArms) && player.arms.type != Arms.LION && player.soulforce >= 100) addButton(11, "Lion", metamorphLionArms);
	else if (player.hasStatusEffect(StatusEffects.UnlockedLionArms) && player.arms.type == Arms.LION) addButtonDisabled(11, "Lion", "You already have lion arms.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedLionArms) && player.arms.type != Arms.LION && player.soulforce < 100) addButtonDisabled(11, "Lion", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(11, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedFoxArms) && player.arms.type != Arms.FOX && player.soulforce >= 100) addButton(12, "Fox", metamorphArmsFox);
	else if (player.hasStatusEffect(StatusEffects.UnlockedFoxArms) && player.arms.type == Arms.FOX) addButtonDisabled(12, "Fox", "You already have fox arms.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedFoxArms) && player.arms.type != Arms.FOX && player.soulforce < 100) addButtonDisabled(12, "Fox", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(12, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedKitsuneArms) && player.arms.type != Arms.KITSUNE && player.soulforce >= 100) addButton(13, "Kitsune", metamorphKitsuneArms);
	else if (player.hasStatusEffect(StatusEffects.UnlockedKitsuneArms) && player.arms.type == Arms.KITSUNE) addButtonDisabled(13, "Kitsune", "You already have kitsune arms.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedKitsuneArms) && player.arms.type != Arms.KITSUNE && player.soulforce < 100) addButtonDisabled(13, "Kitsune", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(13, "???", "You not yet unlocked this metamorphosis!");
	addButton(14, "Back", accessPage2MetamorphMenu);
}
private function accessPage2ArmsMenu():void {
	menu();
	if (player.hasStatusEffect(StatusEffects.UnlockedLizardArms) && player.arms.type != Arms.LIZARD && player.soulforce >= 100) addButton(0, "Lizard", metamorphLizardArms);
	else if (player.hasStatusEffect(StatusEffects.UnlockedLizardArms) && player.arms.type == Arms.LIZARD) addButtonDisabled(0, "Lizard", "You already have lizard arms.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedLizardArms) && player.arms.type != Arms.LIZARD && player.soulforce < 100) addButtonDisabled(0, "Lizard", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(0, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedDraconicArms) && player.arms.type != Arms.DRAGON && player.soulforce >= 100) addButton(1, "Dragon", metamorphDragonArms);
	else if (player.hasStatusEffect(StatusEffects.UnlockedDraconicArms) && player.arms.type == Arms.DRAGON) addButtonDisabled(1, "Dragon", "You already have dragon arms.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedDraconicArms) && player.arms.type != Arms.DRAGON && player.soulforce < 100) addButtonDisabled(1, "Dragon", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(1, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedOrcaArms) && player.arms.type != Arms.ORCA && player.soulforce >= 100) addButton(3, "Orca", metamorphOrcaArms);
	else if (player.hasStatusEffect(StatusEffects.UnlockedOrcaArms) && player.arms.type == Arms.ORCA) addButtonDisabled(3, "Orca", "You already have orca arms.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedOrcaArms) && player.arms.type != Arms.ORCA && player.soulforce < 100) addButtonDisabled(3, "Orca", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(3, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedDevilArms) && player.arms.type != Arms.DEVIL && player.soulforce >= 100) addButton(5, "Devil", metamorphDevilArms);
	else if (player.hasStatusEffect(StatusEffects.UnlockedDevilArms) && player.arms.type == Arms.DEVIL) addButtonDisabled(5, "Devil", "You already have devil arms.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedDevilArms) && player.arms.type != Arms.DEVIL && player.soulforce < 100) addButtonDisabled(5, "Devil", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(5, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedOniArms) && player.arms.type != Arms.ONI && player.soulforce >= 100) addButton(6, "Oni", metamorphOniArms);
	else if (player.hasStatusEffect(StatusEffects.UnlockedOniArms) && player.arms.type == Arms.ONI) addButtonDisabled(6, "Oni", "You already have oni arms.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedOniArms) && player.arms.type != Arms.ONI && player.soulforce < 100) addButtonDisabled(6, "Oni", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(6, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedElfArms) && player.arms.type != Arms.ELF && player.soulforce >= 100) addButton(7, "Elf", metamorphElfArms);
	else if (player.hasStatusEffect(StatusEffects.UnlockedElfArms) && player.arms.type == Arms.ELF) addButtonDisabled(7, "Elf", "You already have elf arms.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedElfArms) && player.arms.type != Arms.ELF && player.soulforce < 100) addButtonDisabled(7, "Elf", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(7, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedRaijuArms) && player.arms.type != Arms.RAIJU && player.soulforce >= 100) addButton(8, "Raiju", metamorphRaijuArms);
	else if (player.hasStatusEffect(StatusEffects.UnlockedRaijuArms) && player.arms.type == Arms.RAIJU) addButtonDisabled(8, "Raiju", "You already have raiju arms.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedRaijuArms) && player.arms.type != Arms.RAIJU && player.soulforce < 100) addButtonDisabled(8, "Raiju", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(8, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedRedPandaArms) && player.arms.type != Arms.RED_PANDA && player.soulforce >= 100) addButton(9, "Red Panda", metamorphRedPandaArms);
	else if (player.hasStatusEffect(StatusEffects.UnlockedRedPandaArms) && player.arms.type == Arms.RED_PANDA) addButtonDisabled(9, "Red Panda", "You already have red panda arms.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedRedPandaArms) && player.arms.type != Arms.RED_PANDA && player.soulforce < 100) addButtonDisabled(9, "Red Panda", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(9, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedCatArms) && player.arms.type != Arms.CAT && player.soulforce >= 100) addButton(11, "Cat", metamorphCatArms);
	else if (player.hasStatusEffect(StatusEffects.UnlockedCatArms) && player.arms.type == Arms.CAT) addButtonDisabled(11, "Cat", "You already have cat arms.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedCatArms) && player.arms.type != Arms.CAT && player.soulforce < 100) addButtonDisabled(11, "Cat", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(11, "???", "You not yet unlocked this metamorphosis!");
	addButton(14, "Back", accessPage2MetamorphMenu);
}
private function accessPage3ArmsMenu():void {
	menu();
	if (player.hasStatusEffect(StatusEffects.UnlockedSphinxArms) && player.arms.type != Arms.SPHINX && player.soulforce >= 100) addButton(0, "Sphinx", metamorphSphinxArms);
	else if (player.hasStatusEffect(StatusEffects.UnlockedSphinxArms) && player.arms.type == Arms.SPHINX) addButtonDisabled(0, "Sphinx", "You already have sphinx arms.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedSphinxArms) && player.arms.type != Arms.SPHINX && player.soulforce < 100) addButtonDisabled(0, "Sphinx", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(0, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedPigArms) && player.arms.type != Arms.PIG && player.soulforce >= 100) addButton(1, "Pig", metamorphPigArms);
	else if (player.hasStatusEffect(StatusEffects.UnlockedPigArms) && player.arms.type == Arms.PIG) addButtonDisabled(1, "Pig", "You already have pig arms.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedPigArms) && player.arms.type != Arms.PIG && player.soulforce < 100) addButtonDisabled(1, "Pig", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(1, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedBoarArms) && player.arms.type != Arms.BOAR && player.soulforce >= 100) addButton(2, "Boar", metamorphBoarArms);
	else if (player.hasStatusEffect(StatusEffects.UnlockedBoarArms) && player.arms.type == Arms.BOAR) addButtonDisabled(2, "Boar", "You already have boar arms.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedBoarArms) && player.arms.type != Arms.BOAR && player.soulforce < 100) addButtonDisabled(2, "Boar", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(2, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedOrcArms) && player.arms.type != Arms.ORC && player.soulforce >= 100) addButton(3, "Orc", metamorphOrcArms);
	else if (player.hasStatusEffect(StatusEffects.UnlockedOrcArms) && player.arms.type == Arms.ORC) addButtonDisabled(3, "Orc", "You already have orc arms.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedOrcArms) && player.arms.type != Arms.ORC && player.soulforce < 100) addButtonDisabled(3, "Orc", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(3, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedDisplacerArms) && player.arms.type != Arms.DISPLACER && player.soulforce >= 100) addButton(4, "Displacer", metamorphDisplacerArms);
	else if (player.hasStatusEffect(StatusEffects.UnlockedDisplacerArms) && player.arms.type == Arms.DISPLACER) addButtonDisabled(4, "Displacer", "You already have displacer beast arms.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedDisplacerArms) && player.arms.type != Arms.DISPLACER && player.soulforce < 100) addButtonDisabled(4, "Displacer", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(4, "???", "You not yet unlocked this metamorphosis!");
	addButton(14, "Back", accessPage2MetamorphMenu);
}
private function accessPage1WingsMenu():void {
	menu();
	if (player.hasStatusEffect(StatusEffects.UnlockedHumanNoWings) && player.wings.type != Wings.NONE && player.soulforce >= 500) addButton(0, "Human", metamorphHumanNoWings);
	else if (player.hasStatusEffect(StatusEffects.UnlockedHumanNoWings) && player.wings.type == Wings.NONE) addButtonDisabled(0, "Human", "You already have no wings.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedHumanNoWings) && player.wings.type != Wings.NONE && player.soulforce < 500) addButtonDisabled(0, "Human", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(0, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedBeeWingsSmall) && player.wings.type != Wings.BEE_LIKE_SMALL && player.soulforce >= 100) addButton(1, "Bee(S)", metamorphBeeWingsSmall);
	else if (player.hasStatusEffect(StatusEffects.UnlockedBeeWingsSmall) && player.wings.type == Wings.BEE_LIKE_SMALL) addButtonDisabled(1, "Bee(S)", "You already have small bee wings.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedBeeWingsSmall) && player.wings.type != Wings.BEE_LIKE_SMALL && player.soulforce < 100) addButtonDisabled(1, "Bee(S)", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(1, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedBeeWingsLarge) && player.wings.type == Wings.BEE_LIKE_SMALL && player.soulforce >= 200) addButton(2, "Bee(L)", metamorphBeeWingsLarge);
	else if (player.hasStatusEffect(StatusEffects.UnlockedBeeWingsLarge) && player.wings.type == Wings.BEE_LIKE_LARGE) addButtonDisabled(2, "Bee(L)", "You already have large bee wings.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedBeeWingsLarge) && player.wings.type != Wings.BEE_LIKE_LARGE && player.soulforce < 200) addButtonDisabled(2, "Bee(L)", "You not have enough Soulforce for this metamorphosis.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedBeeWingsLarge) && player.wings.type != Wings.BEE_LIKE_SMALL) addButtonDisabled(2, "Bee(L)", "You not have proper type of wings for this metamorphosis.");
	else addButtonDisabled(2, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedDemonTinyBatWings) && player.wings.type != Wings.BAT_LIKE_TINY && player.soulforce >= 100) addButton(6, "Demon(S)", metamorphWingsDemonicTiny);
	else if (player.hasStatusEffect(StatusEffects.UnlockedDemonTinyBatWings) && player.wings.type == Wings.BAT_LIKE_TINY) addButtonDisabled(6, "Demon(S)", "You already have small bat wings.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedDemonTinyBatWings) && player.wings.type != Wings.BAT_LIKE_TINY && player.soulforce < 100) addButtonDisabled(6, "Demon(S)", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(6, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedDemonLargeBatWings) && player.wings.type == Wings.BAT_LIKE_TINY && player.soulforce >= 200) addButton(7, "Demon(L)", metamorphWingsDemoncLarge);
	else if (player.hasStatusEffect(StatusEffects.UnlockedDemonLargeBatWings) && player.wings.type == Wings.BAT_LIKE_LARGE) addButtonDisabled(7, "Demon(L)", "You already have large bat wings.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedDemonLargeBatWings) && player.wings.type != Wings.BAT_LIKE_LARGE && player.soulforce < 200) addButtonDisabled(7, "Demon(L)", "You not have enough Soulforce for this metamorphosis.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedDemonLargeBatWings) && player.wings.type != Wings.BAT_LIKE_TINY) addButtonDisabled(7, "Demon(L)", "You not have proper type of wings for this metamorphosis.");
	else addButtonDisabled(7, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedHarpyWings) && player.wings.type != Wings.FEATHERED_LARGE && player.soulforce >= 100) addButton(8, "Harpy", metamorphHarpyWings);
	else if (player.hasStatusEffect(StatusEffects.UnlockedHarpyWings) && player.wings.type == Wings.FEATHERED_LARGE) addButtonDisabled(8, "Harpy", "You already have harpy wings.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedHarpyWings) && player.wings.type != Wings.FEATHERED_LARGE && player.soulforce < 100) addButtonDisabled(8, "Harpy", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(8, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedDraconicWingsSmall) && player.wings.type != Wings.DRACONIC_SMALL && player.soulforce >= 100) addButton(9, "Dragon(S)", metamorphDragonWingsSmall);
	else if (player.hasStatusEffect(StatusEffects.UnlockedDraconicWingsSmall) && player.wings.type == Wings.DRACONIC_SMALL) addButtonDisabled(9, "Dragon(S)", "You already have small dragon wings.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedDraconicWingsSmall) && player.wings.type != Wings.DRACONIC_SMALL && player.soulforce < 100) addButtonDisabled(9, "Dragon(S)", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(9, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedDraconicWingsLarge) && player.wings.type == Wings.DRACONIC_SMALL && player.soulforce >= 200) addButton(10, "Dragon(L)", metamorphDragonWingsLarge);
	else if (player.hasStatusEffect(StatusEffects.UnlockedDraconicWingsLarge) && player.wings.type == Wings.DRACONIC_LARGE) addButtonDisabled(10, "Dragon(L)", "You already have large dragon wings.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedDraconicWingsLarge) && player.wings.type != Wings.DRACONIC_LARGE && player.soulforce < 200) addButtonDisabled(10, "Dragon(L)", "You not have enough Soulforce for this metamorphosis.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedDraconicWingsLarge) && player.wings.type != Wings.DRACONIC_SMALL) addButtonDisabled(10, "Dragon(L)", "You not have proper type of wings for this metamorphosis.");
	else addButtonDisabled(10, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedDemonLargeBatWings2) && player.wings.type == Wings.BAT_LIKE_LARGE && player.soulforce >= 300) addButton(12, "Demon(L2)", metamorphWingsDemonicLarge2);
	else if (player.hasStatusEffect(StatusEffects.UnlockedDemonLargeBatWings2) && player.wings.type == Wings.BAT_LIKE_LARGE_2) addButtonDisabled(12, "Demon(L2)", "You already have two large pairs of bat wings.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedDemonLargeBatWings2) && player.wings.type != Wings.BAT_LIKE_LARGE_2 && player.soulforce < 300) addButtonDisabled(12, "Demon(L2)", "You not have enough Soulforce for this metamorphosis.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedDemonLargeBatWings2) && player.wings.type != Wings.BAT_LIKE_LARGE) addButtonDisabled(12, "Demon(L2)", "You not have proper type of wings for this metamorphosis.");
	else addButtonDisabled(12, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedDraconicWingsHuge) && player.wings.type == Wings.DRACONIC_LARGE && player.soulforce >= 300) addButton(13, "Dragon(H)", metamorphDragonWingsHuge);
	else if (player.hasStatusEffect(StatusEffects.UnlockedDraconicWingsHuge) && player.wings.type == Wings.DRACONIC_HUGE) addButtonDisabled(13, "Dragon(H)", "You already have huge dragon wings.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedDraconicWingsHuge) && player.wings.type != Wings.DRACONIC_HUGE && player.soulforce < 300) addButtonDisabled(13, "Dragon(H)", "You not have enough Soulforce for this metamorphosis.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedDraconicWingsHuge) && player.wings.type != Wings.DRACONIC_LARGE) addButtonDisabled(13, "Dragon(H)", "You not have proper type of wings for this metamorphosis.");
	else addButtonDisabled(13, "???", "You not yet unlocked this metamorphosis!");
	addButton(14, "Back", accessPage2MetamorphMenu);
}
private function accessPage2WingsMenu():void {
	menu();
	if (player.hasStatusEffect(StatusEffects.UnlockedPhoenixWings) && player.wings.type != Wings.FEATHERED_PHOENIX && player.soulforce >= 100) addButton(0, "Phoenix", metamorphPhoenixWings);
	else if (player.hasStatusEffect(StatusEffects.UnlockedPhoenixWings) && player.wings.type == Wings.FEATHERED_PHOENIX) addButtonDisabled(0, "Phoenix", "You already have phoenix wings.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedPhoenixWings) && player.wings.type != Wings.FEATHERED_PHOENIX && player.soulforce < 100) addButtonDisabled(0, "Phoenix", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(0, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedAlicornWings) && player.wings.type != Wings.FEATHERED_ALICORN && player.soulforce >= 200) addButton(1, "Alicorn", metamorphAlicornWings);
	else if (player.hasStatusEffect(StatusEffects.UnlockedAlicornWings) && player.wings.type == Wings.FEATHERED_ALICORN) addButtonDisabled(1, "Alicorn", "You already have alicorn wings.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedAlicornWings) && player.wings.type != Wings.FEATHERED_ALICORN && player.soulforce < 200) addButtonDisabled(1, "Alicorn", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(1, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedMantisWingsSmall) && player.wings.type != Wings.MANTIS_LIKE_SMALL && player.soulforce >= 100) addButton(2, "Mantis(S)", metamorphMantisWingsSmall);
	else if (player.hasStatusEffect(StatusEffects.UnlockedMantisWingsSmall) && player.wings.type == Wings.MANTIS_LIKE_SMALL) addButtonDisabled(2, "Mantis(S)", "You already have mantis small wings.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedMantisWingsSmall) && player.wings.type != Wings.MANTIS_LIKE_SMALL && player.soulforce < 100) addButtonDisabled(2, "Mantis(S)", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(2, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedMantisWingsLarge) && player.wings.type == Wings.MANTIS_LIKE_SMALL && player.soulforce >= 200) addButton(3, "Mantis(L)", metamorphMantisWingsLarge);
	else if (player.hasStatusEffect(StatusEffects.UnlockedMantisWingsLarge) && player.wings.type == Wings.MANTIS_LIKE_LARGE) addButtonDisabled(3, "Mantis(L)", "You already have large mantis wings.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedMantisWingsLarge) && player.wings.type != Wings.MANTIS_LIKE_LARGE && player.soulforce < 200) addButtonDisabled(3, "Mantis(L)", "You not have enough Soulforce for this metamorphosis.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedMantisWingsLarge) && player.wings.type != Wings.MANTIS_LIKE_SMALL) addButtonDisabled(3, "Mantis(L)", "You not have proper type of wings for this metamorphosis.");
	else addButtonDisabled(3, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedManticoreWingsSmall) && player.wings.type != Wings.MANTICORE_LIKE_SMALL && player.soulforce >= 100) addButton(7, "Manticore(S)", metamorphManticoreWingsSmall);
	else if (player.hasStatusEffect(StatusEffects.UnlockedManticoreWingsSmall) && player.wings.type == Wings.MANTICORE_LIKE_SMALL) addButtonDisabled(7, "Manticore(S)", "You already have manticore small wings.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedManticoreWingsSmall) && player.wings.type != Wings.MANTICORE_LIKE_SMALL && player.soulforce < 100) addButtonDisabled(7, "Manticore(S)", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(7, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedManticoreWingsLarge) && player.wings.type == Wings.MANTICORE_LIKE_SMALL && player.soulforce >= 200) addButton(8, "Manticore(L)", metamorphManticoreWingsLarge);
	else if (player.hasStatusEffect(StatusEffects.UnlockedManticoreWingsLarge) && player.wings.type == Wings.MANTICORE_LIKE_LARGE) addButtonDisabled(8, "Manticore(L)", "You already have large manticore wings.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedManticoreWingsLarge) && player.wings.type != Wings.MANTICORE_LIKE_LARGE && player.soulforce < 200) addButtonDisabled(8, "Manticore(L)", "You not have enough Soulforce for this metamorphosis.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedManticoreWingsLarge) && player.wings.type != Wings.MANTICORE_LIKE_SMALL) addButtonDisabled(8, "Manticore(L)", "You not have proper type of wings for this metamorphosis.");
	else addButtonDisabled(8, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedBatWings) && player.wings.type != Wings.BAT_ARM && player.soulforce >= 100) addButton(9, "Bat", metamorphBatWings);
	else if (player.hasStatusEffect(StatusEffects.UnlockedBatWings) && player.wings.type == Wings.BAT_ARM) addButtonDisabled(9, "Bat", "You already have bat wings.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedBatWings) && player.wings.type != Wings.BAT_ARM && player.soulforce < 100) addButtonDisabled(9, "Bat", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(9, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedVampireWings) && player.wings.type != Wings.VAMPIRE && player.soulforce >= 100) addButton(10, "Vampire", metamorphVampireWings);
	else if (player.hasStatusEffect(StatusEffects.UnlockedVampireWings) && player.wings.type == Wings.VAMPIRE) addButtonDisabled(10, "Vampire", "You already have vampire wings.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedVampireWings) && player.wings.type != Wings.VAMPIRE && player.soulforce < 100) addButtonDisabled(10, "Vampire", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(10, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedNightmareWings) && player.wings.type != Wings.NIGHTMARE && player.soulforce >= 200) addButton(13, "Nightmare", metamorphNightmareWings);
	else if (player.hasStatusEffect(StatusEffects.UnlockedNightmareWings) && player.wings.type == Wings.NIGHTMARE) addButtonDisabled(13, "Nightmare", "You already have nightmare wings.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedNightmareWings) && player.wings.type != Wings.NIGHTMARE && player.soulforce < 200) addButtonDisabled(13, "Nightmare", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(13, "???", "You not yet unlocked this metamorphosis!");
	addButton(14, "Back", accessPage2MetamorphMenu);
}
private function accessPage3WingsMenu():void {
	menu();
	if (player.hasStatusEffect(StatusEffects.UnlockedSphinxWings) && player.wings.type != Wings.FEATHERED_SPHINX && player.soulforce >= 100) addButton(0, "Sphinx", metamorphSphinxWings);
	else if (player.hasStatusEffect(StatusEffects.UnlockedSphinxWings) && player.wings.type == Wings.FEATHERED_SPHINX) addButtonDisabled(0, "Sphinx", "You already have sphinx wings.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedSphinxWings) && player.wings.type != Wings.FEATHERED_SPHINX && player.soulforce < 100) addButtonDisabled(0, "Sphinx", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(10, "???", "You not yet unlocked this metamorphosis!");
	addButton(14, "Back", accessPage2MetamorphMenu);
}
private function accessPage1LegsMenu():void {
	menu();
	if (player.hasStatusEffect(StatusEffects.UnlockedHumanLowerBody) && player.lowerBody != LowerBody.HUMAN && player.soulforce >= 500) addButton(0, "Human", metamorphHumanLegs);
	else if (player.hasStatusEffect(StatusEffects.UnlockedHumanLowerBody) && player.lowerBody == LowerBody.HUMAN) addButtonDisabled(0, "Human", "You already have human legs.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedHumanLowerBody) && player.lowerBody != LowerBody.HUMAN && player.soulforce < 500) addButtonDisabled(0, "Human", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(0, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedHoofedLegs) && player.lowerBody != LowerBody.HOOFED && player.soulforce >= 100) addButton(1, "Hoofed", metamorphHoofedLegs);
	else if (player.hasStatusEffect(StatusEffects.UnlockedHoofedLegs) && player.lowerBody == LowerBody.HOOFED) addButtonDisabled(1, "Hoofed", "You already have hoofed legs.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedHoofedLegs) && player.lowerBody != LowerBody.HOOFED && player.soulforce < 100) addButtonDisabled(1, "Hoofed", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(1, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedSnakeLowerBody) && player.lowerBody != LowerBody.NAGA && player.soulforce >= 100) addButton(3, "Snake", metamorphSnakeLowerBody);
	else if (player.hasStatusEffect(StatusEffects.UnlockedSnakeLowerBody) && player.lowerBody == LowerBody.NAGA) addButtonDisabled(3, "Snake", "You already have snake lower body.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedSnakeLowerBody) && player.lowerBody != LowerBody.NAGA && player.soulforce < 100) addButtonDisabled(3, "Snake", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(3, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedDemonHighHeels) && player.lowerBody != LowerBody.DEMONIC_HIGH_HEELS && (player.gender == 2 || player.gender == 3) && player.soulforce >= 100) addButton(4, "Demon(F)", metamorphLegsDemonicHighHeels);
	else if (player.hasStatusEffect(StatusEffects.UnlockedDemonHighHeels) && player.lowerBody == LowerBody.DEMONIC_HIGH_HEELS && (player.gender == 2 || player.gender == 3)) addButtonDisabled(4, "Demon(F)", "You already have demon high heels lower body.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedDemonHighHeels) && player.lowerBody != LowerBody.DEMONIC_HIGH_HEELS && (player.gender == 2 || player.gender == 3) && player.soulforce < 100) addButtonDisabled(4, "Demon(F)", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(4, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedDemonClawedLegs) && player.lowerBody != LowerBody.DEMONIC_CLAWS && player.gender != 2 && player.soulforce >= 100) addButton(5, "Demon(M)", metamorphLegsDemonicClaws);
	else if (player.hasStatusEffect(StatusEffects.UnlockedDemonClawedLegs) && player.lowerBody == LowerBody.DEMONIC_CLAWS && player.gender != 2) addButtonDisabled(5, "Demon(M)", "You already have demon clawed feet lower body.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedDemonClawedLegs) && player.lowerBody != LowerBody.DEMONIC_CLAWS && player.gender != 2 && player.soulforce < 100) addButtonDisabled(5, "Demon(M)", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(5, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedBeeLegs) && player.lowerBody != LowerBody.BEE && player.soulforce >= 100) addButton(6, "Bee", metamorphBeeLegs);
	else if (player.hasStatusEffect(StatusEffects.UnlockedBeeLegs) && player.lowerBody == LowerBody.BEE) addButtonDisabled(6, "Bee", "You already have bee lower body.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedBeeLegs) && player.lowerBody != LowerBody.BEE && player.soulforce < 100) addButtonDisabled(6, "Bee", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(6, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedCatLegs) && player.lowerBody != LowerBody.CAT && player.soulforce >= 100) addButton(8, "Cat", metamorphCatLegs);
	else if (player.hasStatusEffect(StatusEffects.UnlockedCatLegs) && player.lowerBody == LowerBody.CAT) addButtonDisabled(8, "Cat", "You already have cat lower body.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedCatLegs) && player.lowerBody != LowerBody.CAT && player.soulforce < 100) addButtonDisabled(8, "Cat", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(8, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedLizardLegs) && player.lowerBody != LowerBody.LIZARD && player.soulforce >= 100) addButton(9, "Lizard", metamorphLizardLegs);
	else if (player.hasStatusEffect(StatusEffects.UnlockedLizardLegs) && player.lowerBody == LowerBody.LIZARD) addButtonDisabled(9, "Lizard", "You already have lizard lower body.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedLizardLegs) && player.lowerBody != LowerBody.LIZARD && player.soulforce < 100) addButtonDisabled(9, "Lizard", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(9, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedHarpyLegs) && player.lowerBody != LowerBody.HARPY && player.soulforce >= 100) addButton(12, "Harpy", metamorphHarpyLegs);
	else if (player.hasStatusEffect(StatusEffects.UnlockedHarpyLegs) && player.lowerBody == LowerBody.HARPY) addButtonDisabled(12, "Harpy", "You already have harpy lower body.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedHarpyLegs) && player.lowerBody != LowerBody.HARPY && player.soulforce < 100) addButtonDisabled(12, "Harpy", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(12, "???", "You not yet unlocked this metamorphosis!");
	addButton(14, "Back", accessPage2MetamorphMenu);
}
private function accessPage2LegsMenu():void {
	menu();
	if (player.hasStatusEffect(StatusEffects.UnlockedSpiderLegs) && player.lowerBody != LowerBody.CHITINOUS_SPIDER_LEGS && player.soulforce >= 100) addButton(0, "Spider", metamorphSpiderLegs);
	else if (player.hasStatusEffect(StatusEffects.UnlockedSpiderLegs) && player.lowerBody == LowerBody.CHITINOUS_SPIDER_LEGS) addButtonDisabled(0, "Spider", "You already have spider lower body.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedSpiderLegs) && player.lowerBody != LowerBody.CHITINOUS_SPIDER_LEGS && player.soulforce < 100) addButtonDisabled(0, "Spider", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(0, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedDriderLegs) && player.lowerBody == LowerBody.CHITINOUS_SPIDER_LEGS && player.tailType == Tail.SPIDER_ADBOMEN && player.soulforce >= 300) addButton(1, "Drider", metamorphDriderLegs);
	else if (player.hasStatusEffect(StatusEffects.UnlockedDriderLegs) && player.lowerBody == LowerBody.DRIDER) addButtonDisabled(1, "Drider", "You already have drider lower body.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedDriderLegs) && player.lowerBody == LowerBody.CHITINOUS_SPIDER_LEGS && player.tailType == Tail.SPIDER_ADBOMEN && player.soulforce < 300) addButtonDisabled(1, "Drider", "You not have enough Soulforce for this metamorphosis.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedDriderLegs) && player.lowerBody == LowerBody.CHITINOUS_SPIDER_LEGS && player.tailType != Tail.SPIDER_ADBOMEN) addButtonDisabled(1, "Drider", "You have proper type of legs but have wrong type of tail for this metamorphosis.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedDriderLegs) && player.lowerBody != LowerBody.CHITINOUS_SPIDER_LEGS) addButtonDisabled(1, "Drider", "You not have proper type of legs and/or tail for this metamorphosis.");
	else addButtonDisabled(1, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedFoxLowerBody) && player.lowerBody != LowerBody.FOX && player.soulforce >= 100) addButton(2, "Fox", metamorphLowerBodyFox);
	else if (player.hasStatusEffect(StatusEffects.UnlockedFoxLowerBody) && player.lowerBody == LowerBody.FOX) addButtonDisabled(2, "Fox", "You already have fox lower body.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedFoxLowerBody) && player.lowerBody != LowerBody.FOX && player.soulforce < 100) addButtonDisabled(2, "Fox", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(2, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedDraconicLegs) && player.lowerBody != LowerBody.DRAGON && player.soulforce >= 100) addButton(3, "Dragon", metamorphDragonLegs);
	else if (player.hasStatusEffect(StatusEffects.UnlockedDraconicLegs) && player.lowerBody == LowerBody.DRAGON) addButtonDisabled(3, "Dragon", "You already have dragon lower body.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedDraconicLegs) && player.lowerBody != LowerBody.DRAGON && player.soulforce < 100) addButtonDisabled(3, "Dragon", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(3, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedClovenHoofedLegs) && player.lowerBody != LowerBody.CLOVEN_HOOFED && player.soulforce >= 100) addButton(6, "ClovenHoofed", metamorphClovenHoofedLegs);
	else if (player.hasStatusEffect(StatusEffects.UnlockedClovenHoofedLegs) && player.lowerBody == LowerBody.CLOVEN_HOOFED) addButtonDisabled(6, "ClovenHoofed", "You already have cloven hoofed legs.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedClovenHoofedLegs) && player.lowerBody != LowerBody.CLOVEN_HOOFED && player.soulforce < 100) addButtonDisabled(6, "ClovenHoofed", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(6, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedSalamanderLegs) && player.lowerBody != LowerBody.SALAMANDER && player.soulforce >= 100) addButton(9, "Salamander", metamorphSalamanderLegs);
	else if (player.hasStatusEffect(StatusEffects.UnlockedSalamanderLegs) && player.lowerBody == LowerBody.SALAMANDER) addButtonDisabled(9, "Salamander", "You already have salamander lower body.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedSalamanderLegs) && player.lowerBody != LowerBody.SALAMANDER && player.soulforce < 100) addButtonDisabled(9, "Salamander", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(9, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedMantisLegs) && player.lowerBody != LowerBody.MANTIS && player.soulforce >= 100) addButton(11, "Mantis", metamorphMantisLegs);
	else if (player.hasStatusEffect(StatusEffects.UnlockedMantisLegs) && player.lowerBody == LowerBody.MANTIS) addButtonDisabled(11, "Mantis", "You already have mantis lower body.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedMantisLegs) && player.lowerBody != LowerBody.MANTIS && player.soulforce < 100) addButtonDisabled(11, "Mantis", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(11, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedSharkLegs) && player.lowerBody != LowerBody.SHARK && player.soulforce >= 100) addButton(13, "Shark", metamorphSharkLegs);
	else if (player.hasStatusEffect(StatusEffects.UnlockedSharkLegs) && player.lowerBody == LowerBody.SHARK) addButtonDisabled(13, "Shark", "You already have shark lower body.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedSharkLegs) && player.lowerBody != LowerBody.SHARK && player.soulforce < 100) addButtonDisabled(13, "Shark", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(13, "???", "You not yet unlocked this metamorphosis!");
	addButton(14, "Back", accessPage2MetamorphMenu);
}
private function accessPage3LegsMenu():void {
	menu();
	if (player.hasStatusEffect(StatusEffects.UnlockedLionLegs) && player.lowerBody != LowerBody.LION && player.soulforce >= 100) addButton(5, "Lion", metamorphLionLegs);
	else if (player.hasStatusEffect(StatusEffects.UnlockedLionLegs) && player.lowerBody == LowerBody.LION) addButtonDisabled(5, "Lion", "You already have lion lower body.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedLionLegs) && player.lowerBody != LowerBody.LION && player.soulforce < 100) addButtonDisabled(5, "Lion", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(5, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedOrcaLegs) && player.lowerBody != LowerBody.ORCA && player.soulforce >= 100) addButton(7, "Orca", metamorphOrcaLegs);
	else if (player.hasStatusEffect(StatusEffects.UnlockedOrcaLegs) && player.lowerBody == LowerBody.ORCA) addButtonDisabled(7, "Orca", "You already have orca lower body.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedOrcaLegs) && player.lowerBody != LowerBody.ORCA && player.soulforce < 100) addButtonDisabled(7, "Orca", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(7, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedOniLegs) && player.lowerBody != LowerBody.ONI && player.soulforce >= 100) addButton(9, "Oni", metamorphOniLegs);
	else if (player.hasStatusEffect(StatusEffects.UnlockedOniLegs) && player.lowerBody == LowerBody.ONI) addButtonDisabled(9, "Oni", "You already have oni lower body.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedOniLegs) && player.lowerBody != LowerBody.ONI && player.soulforce < 100) addButtonDisabled(9, "Oni", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(9, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedElfLegs) && player.lowerBody != LowerBody.ELF && player.soulforce >= 100) addButton(10, "Elf", metamorphElfLegs);
	else if (player.hasStatusEffect(StatusEffects.UnlockedElfLegs) && player.lowerBody == LowerBody.ELF) addButtonDisabled(10, "Elf", "You already have elf lower body.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedElfLegs) && player.lowerBody != LowerBody.ELF && player.soulforce < 100) addButtonDisabled(10, "Elf", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(10, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedRaijuLegs) && player.lowerBody != LowerBody.RAIJU && player.soulforce >= 100) addButton(11, "Raiju", metamorphRaijuLegs);
	else if (player.hasStatusEffect(StatusEffects.UnlockedRaijuLegs) && player.lowerBody == LowerBody.RAIJU) addButtonDisabled(11, "Raiju", "You already have raiju lower body.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedRaijuLegs) && player.lowerBody != LowerBody.RAIJU && player.soulforce < 100) addButtonDisabled(11, "Raiju", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(11, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedRedPandaLegs) && player.lowerBody != LowerBody.RED_PANDA && player.soulforce >= 100) addButton(12, "Red Panda", metamorphRedPandaLegs);
	else if (player.hasStatusEffect(StatusEffects.UnlockedRedPandaLegs) && player.lowerBody == LowerBody.RED_PANDA) addButtonDisabled(12, "Red Panda", "You already have red panda lower body.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedRedPandaLegs) && player.lowerBody != LowerBody.RED_PANDA && player.soulforce < 100) addButtonDisabled(12, "Red Panda", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(12, "???", "You not yet unlocked this metamorphosis!");
	addButton(14, "Back", accessPage2MetamorphMenu);
}
private function accessPage4LegsMenu():void {
	menu();
	if (player.hasStatusEffect(StatusEffects.UnlockedOrcLegs) && player.lowerBody != LowerBody.ORC && player.soulforce >= 100) addButton(2, "Orc", metamorphOrcLegs);
	else if (player.hasStatusEffect(StatusEffects.UnlockedOrcLegs) && player.lowerBody == LowerBody.ORC) addButtonDisabled(2, "Orc", "You already have orc lower body.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedOrcLegs) && player.lowerBody != LowerBody.ORC && player.soulforce < 100) addButtonDisabled(2, "Orc", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(2, "???", "You not yet unlocked this metamorphosis!");
	addButton(14, "Back", accessPage2MetamorphMenu);
}/*
private function accessHairMenu():void {
	menu();
	addButton(14, "Back", accessPage2MetamorphMenu);
}
private function accessHairMenu():void {
	menu();
	addButton(14, "Back", accessPage2MetamorphMenu);
}
*/
private function accessPage3MetamorphMenu():void {
	menu();
	addButton(0, "Skin", accessSkinMenu);
	addButton(1, "SkinPat.", accessSkinPatternsMenu);
	addButton(2, "Rear B.", accessRearBodyMenu);
	addButton(3, "Antennae", accessAntennaeMenu);
	addButton(4, "Gills", accessGillsMenu);
	addButton(5, "Tail(1)", accessPage1TailMenu);
	addButton(6, "Tail(2)", accessPage2TailMenu);
	addButton(7, "Tail(3)", accessPage3TailMenu);
	addButton(8, "Tail(4)", accessPage4TailMenu);
	addButton(9, "Tail(5)", accessPage5TailMenu);
	/*addButton(10, "Back", accessMetamorphMenu);
	addButton(11, "Back", accessMetamorphMenu);
	addButton(12, "Back", accessMetamorphMenu);
	addButton(13, "Back", accessMetamorphMenu);*/
	addButton(14, "Back", accessMetamorphMenu);
}
private function accessSkinMenu():void {
	menu();
	if (player.hasStatusEffect(StatusEffects.UnlockedHumanSkin) && player.skinType != Skin.PLAIN && player.soulforce >= 500) addButton(0, "Human", metamorphHumanSkin);
	else if (player.hasStatusEffect(StatusEffects.UnlockedHumanSkin) && player.skinType == Skin.PLAIN) addButtonDisabled(0, "Human", "You already have plain human skin.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedHumanSkin) && player.skinType != Skin.PLAIN && player.soulforce < 500) addButtonDisabled(0, "Human", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(0, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedFur) && player.skinType != Skin.FUR && player.soulforce >= 100) addButton(1, "Fur", metamorphFur);
	else if (player.hasStatusEffect(StatusEffects.UnlockedFur) && player.skinType == Skin.FUR) addButtonDisabled(1, "Fur", "You already have fur.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedFur) && player.skinType != Skin.FUR && player.soulforce < 100) addButtonDisabled(1, "Fur", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(1, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedScales) && player.skinType != Skin.SCALES && player.soulforce >= 100) addButton(2, "Scales", metamorphScales);
	else if (player.hasStatusEffect(StatusEffects.UnlockedScales) && player.skinType == Skin.SCALES) addButtonDisabled(2, "Scales", "You already have scales.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedScales) && player.skinType != Skin.SCALES && player.soulforce < 100) addButtonDisabled(2, "Scales", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(2, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedChitin) && !player.hasCoatOfType(Skin.CHITIN) && player.soulforce >= 100) addButton(4, "Chitin", metamorphChitin);
	else if (player.hasStatusEffect(StatusEffects.UnlockedChitin) && player.hasCoatOfType(Skin.CHITIN)) addButtonDisabled(4, "Chitin", "You already have chitin.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedChitin) && !player.hasCoatOfType(Skin.CHITIN) && player.soulforce < 100) addButtonDisabled(4, "Chitin", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(4, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedDragonScales) && player.skinType != Skin.DRAGON_SCALES && player.soulforce >= 150) addButton(8, "D.Scales", metamorphDragonScales);
	else if (player.hasStatusEffect(StatusEffects.UnlockedDragonScales) && player.skinType == Skin.DRAGON_SCALES) addButtonDisabled(8, "D.Scales", "You already have dragon scales.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedDragonScales) && player.skinType != Skin.DRAGON_SCALES && player.soulforce < 150) addButtonDisabled(8, "D.Scales", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(8, "???", "You not yet unlocked this metamorphosis!");
	addButton(14, "Back", accessPage3MetamorphMenu);
}
private function accessSkinPatternsMenu():void {
	menu();
	if (player.hasStatusEffect(StatusEffects.UnlockedHumanNoSkinPattern) && player.skin.base.pattern != Skin.PATTERN_NONE && player.soulforce >= 500) addButton(0, "Human", metamorphHumanNoSkinPatterns);
	else if (player.hasStatusEffect(StatusEffects.UnlockedHumanNoSkinPattern) && player.skin.base.pattern == Skin.PATTERN_NONE) addButtonDisabled(0, "Human", "You already have no skin patterns.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedHumanNoSkinPattern) && player.skin.base.pattern != Skin.PATTERN_NONE && player.soulforce < 500) addButtonDisabled(0, "Human", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(0, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedTattoed) && player.skin.base.pattern != Skin.PATTERN_MAGICAL_TATTOO && player.soulforce >= 100) addButton(1, "Kitsune", metamorphKitsuneSkinPattern);
	else if (player.hasStatusEffect(StatusEffects.UnlockedTattoed) && player.skin.base.pattern == Skin.PATTERN_MAGICAL_TATTOO) addButtonDisabled(1, "Kitsune", "You already have kitsune skin patterns.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedTattoed) && player.skin.base.pattern != Skin.PATTERN_MAGICAL_TATTOO && player.soulforce < 100) addButtonDisabled(1, "Kitsune", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(1, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedBattleTattoed) && player.skin.base.pattern != Skin.PATTERN_BATTLE_TATTOO && player.soulforce >= 100) addButton(5, "Oni", metamorphOniSkinPattern);
	else if (player.hasStatusEffect(StatusEffects.UnlockedBattleTattoed) && player.skin.base.pattern == Skin.PATTERN_BATTLE_TATTOO) addButtonDisabled(5, "Oni", "You already have oni skin patterns.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedBattleTattoed) && player.skin.base.pattern != Skin.PATTERN_BATTLE_TATTOO && player.soulforce < 100) addButtonDisabled(5, "Oni", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(5, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedLightningTattoed) && player.skin.base.pattern != Skin.PATTERN_LIGHTNING_SHAPED_TATTOO && player.soulforce >= 100) addButton(7, "Raiju", metamorphRaijuSkinPattern);
	else if (player.hasStatusEffect(StatusEffects.UnlockedLightningTattoed) && player.skin.base.pattern == Skin.PATTERN_LIGHTNING_SHAPED_TATTOO) addButtonDisabled(7, "Raiju", "You already have raiju skin patterns.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedLightningTattoed) && player.skin.base.pattern != Skin.PATTERN_LIGHTNING_SHAPED_TATTOO && player.soulforce < 100) addButtonDisabled(7, "Raiju", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(7, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedScarTattoed) && player.skin.base.pattern != Skin.PATTERN_SCAR_SHAPED_TATTOO && player.soulforce >= 100) addButton(9, "Orc", metamorphOrcSkinPattern);
	else if (player.hasStatusEffect(StatusEffects.UnlockedScarTattoed) && player.skin.base.pattern == Skin.PATTERN_SCAR_SHAPED_TATTOO) addButtonDisabled(9, "Orc", "You already have orc skin patterns.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedScarTattoed) && player.skin.base.pattern != Skin.PATTERN_SCAR_SHAPED_TATTOO && player.soulforce < 100) addButtonDisabled(9, "Orc", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(9, "???", "You not yet unlocked this metamorphosis!");
	addButton(14, "Back", accessPage3MetamorphMenu);
}
private function accessRearBodyMenu():void {
	menu();
	if (player.hasStatusEffect(StatusEffects.UnlockedHumanNoRearBody) && player.rearBody.type != RearBody.NONE && player.soulforce >= 500) addButton(0, "Human", metamorphHumanNoRearBody);
	else if (player.hasStatusEffect(StatusEffects.UnlockedHumanNoRearBody) && player.rearBody.type == RearBody.NONE) addButtonDisabled(0, "Human", "You already have human rear body.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedHumanNoRearBody) && player.rearBody.type != RearBody.NONE && player.soulforce < 500) addButtonDisabled(0, "Human", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(0, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedLionMane) && player.rearBody.type != RearBody.LION_MANE && player.soulforce >= 100) addButton(4, "Lion", metamorphLionMane);
	else if (player.hasStatusEffect(StatusEffects.UnlockedLionMane) && player.rearBody.type == RearBody.LION_MANE) addButtonDisabled(4, "Lion", "You already have lion mane.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedLionMane) && player.rearBody.type != RearBody.LION_MANE && player.soulforce < 100) addButtonDisabled(4, "Lion", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(4, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedSharkFin) && player.rearBody.type != RearBody.SHARK_FIN && player.soulforce >= 100) addButton(6, "Shark", metamorphSharkFin);
	else if (player.hasStatusEffect(StatusEffects.UnlockedSharkFin) && player.rearBody.type == RearBody.SHARK_FIN) addButtonDisabled(6, "Shark", "You already have shark back fin.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedSharkFin) && player.rearBody.type != RearBody.SHARK_FIN && player.soulforce < 100) addButtonDisabled(6, "Shark", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(6, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedOrcaBlowhole) && player.rearBody.type != RearBody.ORCA_BLOWHOLE && player.soulforce >= 100) addButton(7, "Orca", metamorphOrcaBlowhole);
	else if (player.hasStatusEffect(StatusEffects.UnlockedOrcaBlowhole) && player.rearBody.type == RearBody.ORCA_BLOWHOLE) addButtonDisabled(7, "Orca", "You already have orca blowhole.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedOrcaBlowhole) && player.rearBody.type != RearBody.ORCA_BLOWHOLE && player.soulforce < 100) addButtonDisabled(7, "Shark", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(7, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedRaijuMane) && player.rearBody.type != RearBody.RAIJU_MANE && player.soulforce >= 100) addButton(8, "Raiju", metamorphRaijuMane);
	else if (player.hasStatusEffect(StatusEffects.UnlockedRaijuMane) && player.rearBody.type == RearBody.RAIJU_MANE) addButtonDisabled(8, "Raiju", "You already have raiju mane.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedRaijuMane) && player.rearBody.type != RearBody.RAIJU_MANE && player.soulforce < 100) addButtonDisabled(8, "Raiju", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(8, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedBatCollar) && player.rearBody.type != RearBody.BAT_COLLAR && player.soulforce >= 100) addButton(9, "Bat", metamorphBatCollar);
	else if (player.hasStatusEffect(StatusEffects.UnlockedBatCollar) && player.rearBody.type == RearBody.BAT_COLLAR) addButtonDisabled(9, "Bat", "You already have bat collar.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedBatCollar) && player.rearBody.type != RearBody.BAT_COLLAR && player.soulforce < 100) addButtonDisabled(9, "Bat", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(9, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedDisplacerBTentacles) && player.rearBody.type != RearBody.DISPLACER_TENTACLES && player.soulforce >= 100) addButton(11, "Displacer", metamorphDisplacerBackTentacles);
	else if (player.hasStatusEffect(StatusEffects.UnlockedDisplacerBTentacles) && player.rearBody.type == RearBody.DISPLACER_TENTACLES) addButtonDisabled(11, "Displacer", "You already have displacer beast back tentacles.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedDisplacerBTentacles) && player.rearBody.type != RearBody.DISPLACER_TENTACLES && player.soulforce < 100) addButtonDisabled(11, "Displacer", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(11, "???", "You not yet unlocked this metamorphosis!");
	addButton(14, "Back", accessPage3MetamorphMenu);
}
private function accessAntennaeMenu():void {
	menu();
	if (player.hasStatusEffect(StatusEffects.UnlockedMantisAntennae) && player.antennae.type != Antennae.NONE && player.soulforce >= 500) addButton(0, "Human", metamorphHumanNoAntennae);
	else if (player.hasStatusEffect(StatusEffects.UnlockedMantisAntennae) && player.antennae.type == Antennae.NONE) addButtonDisabled(0, "Human", "You already have no antennaes.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedMantisAntennae) && player.antennae.type != Antennae.NONE && player.soulforce < 500) addButtonDisabled(0, "Human", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(0, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedMantisAntennae) && player.antennae.type != Antennae.MANTIS && player.soulforce >= 100) addButton(1, "Mantis", metamorphMantisAntennae);
	else if (player.hasStatusEffect(StatusEffects.UnlockedMantisAntennae) && player.antennae.type == Antennae.MANTIS) addButtonDisabled(1, "Mantis", "You already have mantis antennaes.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedMantisAntennae) && player.antennae.type != Antennae.MANTIS && player.soulforce < 100) addButtonDisabled(1, "Mantis", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(1, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedBeeAntennae) && player.antennae.type != Antennae.BEE && player.soulforce >= 100) addButton(2, "Bee", metamorphBeeAntennae);
	else if (player.hasStatusEffect(StatusEffects.UnlockedBeeAntennae) && player.antennae.type == Antennae.BEE) addButtonDisabled(2, "Bee", "You already have bee antennaes.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedBeeAntennae) && player.antennae.type != Antennae.BEE && player.soulforce < 100) addButtonDisabled(2, "Bee", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(2, "???", "You not yet unlocked this metamorphosis!");
	addButton(14, "Back", accessPage3MetamorphMenu);
}
private function accessGillsMenu():void {
	menu();
	if (player.hasStatusEffect(StatusEffects.UnlockedFishGills) && player.gills.type != Gills.NONE && player.soulforce >= 500) addButton(0, "Human", metamorphHumanNoGills);
	else if (player.hasStatusEffect(StatusEffects.UnlockedFishGills) && player.gills.type == Gills.NONE) addButtonDisabled(0, "Human", "You already have no gills.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedFishGills) && player.gills.type != Gills.NONE && player.soulforce < 500) addButtonDisabled(0, "Human", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(0, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedFishGills) && player.gills.type != Gills.FISH && player.soulforce >= 100) addButton(2, "Fish", metamorphFishGills);
	else if (player.hasStatusEffect(StatusEffects.UnlockedFishGills) && player.gills.type == Gills.FISH) addButtonDisabled(2, "Fish", "You already have fish gills.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedFishGills) && player.gills.type != Gills.FISH && player.soulforce < 100) addButtonDisabled(2, "Fish", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(2, "???", "You not yet unlocked this metamorphosis!");
	addButton(14, "Back", accessPage3MetamorphMenu);
}
private function accessPage1TailMenu():void {
	menu();
	if (player.hasStatusEffect(StatusEffects.UnlockedHumanNoTail) && player.tailType != Tail.NONE && player.soulforce >= 500) addButton(0, "Human", metamorphHumanNoTail);
	else if (player.hasStatusEffect(StatusEffects.UnlockedHumanNoTail) && player.tailType == Tail.NONE) addButtonDisabled(0, "Human", "You already not have tail.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedHumanNoTail) && player.tailType != Tail.NONE && player.soulforce < 500) addButtonDisabled(0, "Human", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(0, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedHorseTail) && player.tailType != Tail.HORSE && player.soulforce >= 500) addButton(1, "Horse", metamorphHorseTail);
	else if (player.hasStatusEffect(StatusEffects.UnlockedHorseTail) && player.tailType == Tail.HORSE) addButtonDisabled(1, "Horse", "You already have horse tail.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedHorseTail) && player.tailType != Tail.HORSE && player.soulforce < 500) addButtonDisabled(1, "Horse", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(1, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedDemonTail) && player.tailType != Tail.DEMONIC && player.soulforce >= 100) addButton(3, "Demon", metamorphTailDemonic);
	else if (player.hasStatusEffect(StatusEffects.UnlockedDemonTail) && player.tailType == Tail.DEMONIC) addButtonDisabled(3, "Demon", "You already have demon tail.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedDemonTail) && player.tailType != Tail.DEMONIC && player.soulforce < 100) addButtonDisabled(3, "Demon", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(3, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedCowTail) && player.tailType != Tail.COW && player.soulforce >= 100) addButton(4, "Cow", metamorphCowTail);
	else if (player.hasStatusEffect(StatusEffects.UnlockedCowTail) && player.tailType == Tail.COW) addButtonDisabled(4, "Cow", "You already have cow tail.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedCowTail) && player.tailType != Tail.COW && player.soulforce < 100) addButtonDisabled(4, "Cow", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(4, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedSpiderTail) && player.tailType != Tail.SPIDER_ADBOMEN && player.soulforce >= 100) addButton(5, "Spider", metamorphSpiderTail);
	else if (player.hasStatusEffect(StatusEffects.UnlockedSpiderTail) && player.tailType == Tail.SPIDER_ADBOMEN) addButtonDisabled(5, "Spider", "You already have spider abdomen.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedSpiderTail) && player.tailType != Tail.SPIDER_ADBOMEN && player.soulforce < 100) addButtonDisabled(5, "Spider", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(5, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedBeeTail) && player.tailType != Tail.BEE_ABDOMEN && player.soulforce >= 100) addButton(6, "Bee", metamorphBeeTail);
	else if (player.hasStatusEffect(StatusEffects.UnlockedBeeTail) && player.tailType == Tail.BEE_ABDOMEN) addButtonDisabled(6, "Bee", "You already have bee tail.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedBeeTail) && player.tailType != Tail.BEE_ABDOMEN && player.soulforce < 100) addButtonDisabled(6, "Bee", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(6, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedSharkTail) && player.tailType != Tail.SHARK && player.soulforce >= 100) addButton(7, "Shark", metamorphSharkTail);
	else if (player.hasStatusEffect(StatusEffects.UnlockedSharkTail) && player.tailType == Tail.SHARK) addButtonDisabled(7, "Shark", "You already have shark tail.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedSharkTail) && player.tailType != Tail.SHARK && player.soulforce < 100) addButtonDisabled(7, "Shark", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(7, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedCatTail) && (player.tailType != Tail.CAT || (player.tailType == Tail.CAT && player.tailCount >= 2)) && player.soulforce >= 100) addButton(8, "Cat", metamorphCatTail);
	else if (player.hasStatusEffect(StatusEffects.UnlockedCatTail) && player.tailType == Tail.CAT && player.tailCount == 1) addButtonDisabled(8, "Cat", "You already have single cat tail.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedCatTail) && player.tailType != Tail.CAT && player.soulforce < 100) addButtonDisabled(8, "Cat", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(8, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedCatTail2nd) && player.tailType != Tail.CAT && player.tailCount < 2 && player.soulforce >= 400) addButton(9, "Nekomata", metamorphCat2ndTail);
	else if (player.hasStatusEffect(StatusEffects.UnlockedCatTail2nd) && player.tailType == Tail.CAT && player.tailCount >= 2) addButtonDisabled(9, "Nekomata", "You already have twin cat tail.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedCatTail2nd) && player.tailType != Tail.CAT && player.tailCount < 2 && player.soulforce < 400) addButtonDisabled(9, "Nekomata", "You not have enough Soulforce for this metamorphosis.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedCatTail2nd) && player.tailType != Tail.NEKOMATA_FORKED_1_3) addButtonDisabled(9, "Nekomata", "You not have proper type of tail for this metamorphosis.");
	else addButtonDisabled(2, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedLizardTail) && player.tailType != Tail.LIZARD && player.soulforce >= 100) addButton(10, "Lizard", metamorphLizardTail);
	else if (player.hasStatusEffect(StatusEffects.UnlockedLizardTail) && player.tailType == Tail.LIZARD) addButtonDisabled(10, "Lizard", "You already have lizard tail.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedLizardTail) && player.tailType != Tail.LIZARD && player.soulforce < 100) addButtonDisabled(10, "Lizard", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(10, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedHarpyTail) && player.tailType != Tail.HARPY && player.soulforce >= 100) addButton(12, "Harpy", metamorphHarpyTail);
	else if (player.hasStatusEffect(StatusEffects.UnlockedHarpyTail) && player.tailType == Tail.HARPY) addButtonDisabled(12, "Harpy", "You already have harpy tail.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedHarpyTail) && player.tailType != Tail.HARPY && player.soulforce < 100) addButtonDisabled(12, "Harpy", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(12, "???", "You not yet unlocked this metamorphosis!");
	addButton(14, "Back", accessPage3MetamorphMenu);
}
private function accessPage2TailMenu():void {
	menu();
	if (player.hasStatusEffect(StatusEffects.UnlockedFoxTail) && (player.tailType != Tail.FOX || (player.tailType == Tail.FOX && player.tailCount >= 2)) && player.soulforce >= 100) addButton(0, "Fox", metamorphTailFox);
	else if (player.hasStatusEffect(StatusEffects.UnlockedFoxTail) && player.tailType == Tail.FOX && player.tailCount == 1) addButtonDisabled(0, "Fox", "You already have single fox tail.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedFoxTail) && player.tailType != Tail.FOX && player.soulforce < 100) addButtonDisabled(0, "Fox", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(0, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedFoxTail2nd) && player.tailType == Tail.FOX && player.tailCount == 1 && player.soulforce >= 200) addButton(1, "Fox 2nd", metamorphTailFox2nd);
	else if (player.hasStatusEffect(StatusEffects.UnlockedFoxTail2nd) && player.tailType == Tail.FOX) {
		if (player.tailCount == 2) addButtonDisabled(1, "Fox 2nd", "You already have two fox tails.");
		else if (player.tailCount == 1 && player.soulforce < 200) addButtonDisabled(1, "Fox 2nd", "You not have enough Soulforce for this metamorphosis.");
		else addButtonDisabled(1, "Fox 2nd", "You need to have only one fox tail to use this metamophosis.");
	}
	else if (player.hasStatusEffect(StatusEffects.UnlockedFoxTail2nd) && player.tailType != Tail.FOX) {
		if (player.tailCount != 1) addButtonDisabled(1, "Fox 2nd", "You not have proper type of tails for this metamorphosis.");
		else addButtonDisabled(1, "Fox 2nd", "You not have proper type and amount of tails for this metamorphosis.");
	}
	else addButtonDisabled(1, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedFoxTail3rd) && player.tailType == Tail.FOX && player.tailCount == 2 && player.soulforce >= 300) addButton(2, "Fox 3rd", metamorphTailFox3rd);
	else if (player.hasStatusEffect(StatusEffects.UnlockedFoxTail3rd) && player.tailType == Tail.FOX) {
		if (player.tailCount == 3) addButtonDisabled(2, "Fox 3rd", "You already have three fox tails.");
		else if (player.tailCount == 2 && player.soulforce < 300) addButtonDisabled(2, "Fox 3rd", "You not have enough Soulforce for this metamorphosis.");
		else addButtonDisabled(2, "Fox 3rd", "You need to have two fox tails to use this metamophosis.");
	}
	else if (player.hasStatusEffect(StatusEffects.UnlockedFoxTail3rd) && player.tailType != Tail.FOX && player.tailCount != 2) addButtonDisabled(2, "Fox 3rd", "You not have proper type and amount of tails for this metamorphosis.");
	else addButtonDisabled(2, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedFoxTail4th) && player.tailType == Tail.FOX && player.tailCount == 3 && player.soulforce >= 400) addButton(3, "Fox 4th", metamorphTailFox4th);
	else if (player.hasStatusEffect(StatusEffects.UnlockedFoxTail4th) && player.tailType == Tail.FOX) {
		if (player.tailCount == 4) addButtonDisabled(3, "Fox 4th", "You already have four fox tails.");
		else if (player.tailCount == 3 && player.soulforce < 400) addButtonDisabled(3, "Fox 4th", "You not have enough Soulforce for this metamorphosis.");
		else addButtonDisabled(3, "Fox 4th", "You need to have three fox tails to use this metamophosis.");
	}
	else if (player.hasStatusEffect(StatusEffects.UnlockedFoxTail4th) && player.tailType != Tail.FOX && player.tailCount != 3) addButtonDisabled(3, "Fox 4th", "You not have proper type and amount of tails for this metamorphosis.");
	else addButtonDisabled(3, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedFoxTail5th) && player.tailType == Tail.FOX && player.tailCount == 4 && player.soulforce >= 500) addButton(4, "Fox 5th", metamorphTailFox5th);
	else if (player.hasStatusEffect(StatusEffects.UnlockedFoxTail5th) && player.tailType == Tail.FOX) {
		if (player.tailCount == 5) addButtonDisabled(4, "Fox 5th", "You already have five fox tails.");
		else if (player.tailCount == 4 && player.soulforce < 500) addButtonDisabled(4, "Fox 5th", "You not have enough Soulforce for this metamorphosis.");
		else addButtonDisabled(4, "Fox 5th", "You need to have four fox tails to use this metamophosis.");
	}
	else if (player.hasStatusEffect(StatusEffects.UnlockedFoxTail5th) && player.tailType != Tail.FOX && player.tailCount != 4) addButtonDisabled(4, "Fox 5th", "You not have proper type and amount of tails for this metamorphosis.");
	else addButtonDisabled(4, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedFoxTail6th) && player.tailType == Tail.FOX && player.tailCount == 5 && player.soulforce >= 600) addButton(5, "Fox 6th", metamorphTailFox6th);
	else if (player.hasStatusEffect(StatusEffects.UnlockedFoxTail6th) && player.tailType == Tail.FOX) {
		if (player.tailCount == 6) addButtonDisabled(5, "Fox 6th", "You already have six fox tails.");
		else if (player.tailCount == 5 && player.soulforce < 600) addButtonDisabled(5, "Fox 6th", "You not have enough Soulforce for this metamorphosis.");
		else addButtonDisabled(5, "Fox 6th", "You need to have five fox tails to use this metamophosis.");
	}
	else if (player.hasStatusEffect(StatusEffects.UnlockedFoxTail6th) && player.tailType != Tail.FOX && player.tailCount != 5) addButtonDisabled(5, "Fox 6th", "You not have proper type and amount of tails for this metamorphosis.");
	else addButtonDisabled(5, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedFoxTail7th) && player.tailType == Tail.FOX && player.tailCount == 6 && player.soulforce >= 700) addButton(6, "Fox 7th", metamorphTailFox7th);
	else if (player.hasStatusEffect(StatusEffects.UnlockedFoxTail7th) && player.tailType == Tail.FOX) {
		if (player.tailCount == 7) addButtonDisabled(6, "Fox 7th", "You already have seven fox tails.");
		else if (player.tailCount == 6 && player.soulforce < 700) addButtonDisabled(6, "Fox 7th", "You not have enough Soulforce for this metamorphosis.");
		else addButtonDisabled(6, "Fox 7th", "You need to have six fox tails to use this metamophosis.");
	}
	else if (player.hasStatusEffect(StatusEffects.UnlockedFoxTail7th) && player.tailType != Tail.FOX && player.tailCount != 6) addButtonDisabled(6, "Fox 7th", "You not have proper type and amount of tails for this metamorphosis.");
	else addButtonDisabled(6, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedFoxTail8th) && player.tailType == Tail.FOX && player.tailCount == 7 && player.soulforce >= 800) addButton(7, "Fox 8th", metamorphTailFox8th);
	else if (player.hasStatusEffect(StatusEffects.UnlockedFoxTail8th) && player.tailType == Tail.FOX) {
		if (player.tailCount == 8) addButtonDisabled(7, "Fox 8th", "You already have eight fox tails.");
		else if (player.tailCount == 7 && player.soulforce < 800) addButtonDisabled(7, "Fox 8th", "You not have enough Soulforce for this metamorphosis.");
		else addButtonDisabled(7, "Fox 8th", "You need to have seven fox tails to use this metamophosis.");
	}
	else if (player.hasStatusEffect(StatusEffects.UnlockedFoxTail8th) && player.tailType != Tail.FOX && player.tailCount != 7) addButtonDisabled(7, "Fox 8th", "You not have proper type and amount of tails for this metamorphosis.");
	else addButtonDisabled(7, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedFoxTail9th) && player.tailType == Tail.FOX && player.tailCount == 8 && player.soulforce >= 900) addButton(8, "Fox 9th", metamorphTailFox9th);
	else if (player.hasStatusEffect(StatusEffects.UnlockedFoxTail9th) && player.tailType == Tail.FOX) {
		if (player.tailCount == 9) addButtonDisabled(8, "Fox 9th", "You already have nine fox tails.");
		else if (player.tailCount == 8 && player.soulforce < 900) addButtonDisabled(8, "Fox 9th", "You not have enough Soulforce for this metamorphosis.");
		else addButtonDisabled(8, "Fox 9th", "You need to have eight fox tails to use this metamophosis.");
	}
	else if (player.hasStatusEffect(StatusEffects.UnlockedFoxTail9th) && player.tailType != Tail.FOX && player.tailCount != 8) addButtonDisabled(8, "Fox 9th", "You not have proper type and amount of tails for this metamorphosis.");
	else addButtonDisabled(8, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedDraconicTail) && player.tailType != Tail.DRACONIC && player.soulforce >= 100) addButton(9, "Dragon", metamorphDragonTail);
	else if (player.hasStatusEffect(StatusEffects.UnlockedDraconicTail) && player.tailType == Tail.DRACONIC) addButtonDisabled(9, "Dragon", "You already have dragon tail.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedDraconicTail) && player.tailType != Tail.DRACONIC && player.soulforce < 100) addButtonDisabled(9, "Dragon", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(9, "???", "You not yet unlocked this metamorphosis!");
	addButton(14, "Back", accessPage3MetamorphMenu);
}
private function accessPage3TailMenu():void {
	menu();
	if (player.hasStatusEffect(StatusEffects.UnlockedPigTail) && player.tailType != Tail.PIG && player.soulforce >= 100) addButton(0, "Pig", metamorphPigTail);
	else if (player.hasStatusEffect(StatusEffects.UnlockedPigTail) && player.tailType == Tail.PIG) addButtonDisabled(0, "Pig", "You already have pig tail.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedPigTail) && player.tailType != Tail.PIG && player.soulforce < 100) addButtonDisabled(0, "Pig", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(0, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedScorpionTail) && player.tailType != Tail.SCORPION && player.soulforce >= 100) addButton(1, "Scorpion", metamorphScorpionTail);
	else if (player.hasStatusEffect(StatusEffects.UnlockedScorpionTail) && player.tailType == Tail.SCORPION) addButtonDisabled(1, "Scorpion", "You already have scorpion tail.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedScorpionTail) && player.tailType != Tail.SCORPION && player.soulforce < 100) addButtonDisabled(1, "Scorpion", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(1, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedGoatTail) && player.tailType != Tail.GOAT && player.soulforce >= 100) addButton(2, "Goat", metamorphGoatTail);
	else if (player.hasStatusEffect(StatusEffects.UnlockedGoatTail) && player.tailType == Tail.GOAT) addButtonDisabled(2, "Goat", "You already have goat tail.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedGoatTail) && player.tailType != Tail.GOAT && player.soulforce < 100) addButtonDisabled(2, "Goat", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(2, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedSalamanderTail) && player.tailType != Tail.SALAMANDER && player.soulforce >= 100) addButton(6, "Salamander", metamorphSalamanderTail);
	else if (player.hasStatusEffect(StatusEffects.UnlockedSalamanderTail) && player.tailType == Tail.SALAMANDER) addButtonDisabled(6, "Salamander", "You already have salamander tail.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedSalamanderTail) && player.tailType != Tail.SALAMANDER && player.soulforce < 100) addButtonDisabled(6, "Salamander", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(6, "???", "You not yet unlocked this metamorphosis!");
	//7 to 13 -> kitshoo tails 1st to 7th
	addButton(14, "Back", accessPage3MetamorphMenu);
}
private function accessPage4TailMenu():void {
	menu();
	//0 and 1 -> kitshoo tails 8th & 9th
	if (player.hasStatusEffect(StatusEffects.UnlockedMantisTail) && player.tailType != Tail.MANTIS_ABDOMEN && player.soulforce >= 100) addButton(2, "Mantis", metamorphMantisTail);
	else if (player.hasStatusEffect(StatusEffects.UnlockedMantisTail) && player.tailType == Tail.MANTIS_ABDOMEN) addButtonDisabled(2, "Mantis", "You already have mantis abdomen.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedMantisTail) && player.tailType != Tail.MANTIS_ABDOMEN && player.soulforce < 100) addButtonDisabled(2, "Mantis", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(2, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedManticoreTail) && player.tailType == Tail.SCORPION) {
		if (player.tailType != Tail.MANTICORE_PUSSYTAIL && player.soulforce >= 200) {
			if (player.hasCock()) addButtonDisabled(3, "Manticore", "You can't use this metamorphosis as long you not get rid of your manhood.");
			else addButton(3, "Manticore", metamorphManticoreTail);
		}
		else if (player.tailType == Tail.MANTICORE_PUSSYTAIL) addButtonDisabled(3, "Manticore", "You already have manticore pussytail.");
		else if (player.tailType != Tail.MANTICORE_PUSSYTAIL && player.soulforce < 200) addButtonDisabled(3, "Manticore", "You not have enough Soulforce for this metamorphosis.");
	}
	else if (player.hasStatusEffect(StatusEffects.UnlockedManticoreTail) && player.tailType != Tail.SCORPION) addButtonDisabled(3, "Manticore", "You not have proper type of tail for this metamorphosis.");
	else addButtonDisabled(3, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedOrcaTail) && player.tailType != Tail.ORCA && player.soulforce >= 100) addButton(6, "Orca", metamorphOrcaTail);
	else if (player.hasStatusEffect(StatusEffects.UnlockedOrcaTail) && player.tailType == Tail.ORCA) addButtonDisabled(6, "Orca", "You already have orca tail.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedOrcaTail) && player.tailType != Tail.ORCA && player.soulforce < 100) addButtonDisabled(6, "Orca", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(6, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedRaijuTail) && player.tailType != Tail.RAIJU && player.soulforce >= 100) addButton(8, "Raiju", metamorphRaijuTail);
	else if (player.hasStatusEffect(StatusEffects.UnlockedRaijuTail) && player.tailType == Tail.RAIJU) addButtonDisabled(8, "Raiju", "You already have raiju tail.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedRaijuTail) && player.tailType != Tail.RAIJU && player.soulforce < 100) addButtonDisabled(8, "Raiju", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(8, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedRedPandaTail) && player.tailType != Tail.RED_PANDA && player.soulforce >= 100) addButton(9, "Red Panda", metamorphRedPandaTail);
	else if (player.hasStatusEffect(StatusEffects.UnlockedRedPandaTail) && player.tailType == Tail.RED_PANDA) addButtonDisabled(9, "Red Panda", "You already have red panda tail.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedRedPandaTail) && player.tailType != Tail.RED_PANDA && player.soulforce < 100) addButtonDisabled(9, "Red Panda", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(9, "???", "You not yet unlocked this metamorphosis!");
	addButton(14, "Back", accessPage3MetamorphMenu);
}
private function accessPage5TailMenu():void {
	menu();
	if (player.hasStatusEffect(StatusEffects.UnlockedHellcatBurningTail) && player.tailType != Tail.BURNING && player.soulforce >= 100) addButton(0, "Hellcat", metamorphHellcatBurningTail);
	else if (player.hasStatusEffect(StatusEffects.UnlockedHellcatBurningTail) && player.tailType == Tail.BURNING) addButtonDisabled(0, "Hellcat", "You already have hellcat burning tail.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedHellcatBurningTail) && player.tailType != Tail.BURNING && player.soulforce < 100) addButtonDisabled(0, "Hellcat", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(0, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedNekomataForkedTail1) && player.tailType != Tail.NEKOMATA_FORKED_1_3 && player.soulforce >= 200) addButton(1, "Forked 1/3", metamorphNekomataOneThirdForkedTail);
	else if (player.hasStatusEffect(StatusEffects.UnlockedNekomataForkedTail1) && player.tailType == Tail.NEKOMATA_FORKED_1_3) addButtonDisabled(1, "Forked 1/3", "You already have 1/3 forked cat tail.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedNekomataForkedTail1) && player.tailType != Tail.NEKOMATA_FORKED_1_3 && player.soulforce < 200) addButtonDisabled(1, "Forked 1/3", "You not have enough Soulforce for this metamorphosis.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedNekomataForkedTail1) && player.tailType != Tail.CAT && player.tailCount != 1) addButtonDisabled(2, "Forked 1/3", "You not have proper type of tail for this metamorphosis.");
	else addButtonDisabled(1, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusEffect(StatusEffects.UnlockedNekomataForkedTail2) && player.tailType != Tail.NEKOMATA_FORKED_2_3 && player.soulforce >= 300) addButton(2, "Forked 2/3", metamorphNekomataTwoThirdForkedTail);
	else if (player.hasStatusEffect(StatusEffects.UnlockedNekomataForkedTail2) && player.tailType == Tail.NEKOMATA_FORKED_2_3) addButtonDisabled(2, "Forked 2/3", "You already have 2/3 forked cat tail.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedNekomataForkedTail2) && player.tailType != Tail.NEKOMATA_FORKED_2_3 && player.soulforce < 300) addButtonDisabled(2, "Forked 2/3", "You not have enough Soulforce for this metamorphosis.");
	else if (player.hasStatusEffect(StatusEffects.UnlockedNekomataForkedTail2) && player.tailType != Tail.NEKOMATA_FORKED_1_3) addButtonDisabled(2, "Forked 2/3", "You not have proper type of tail for this metamorphosis.");
	else addButtonDisabled(2, "???", "You not yet unlocked this metamorphosis!");
	addButton(14, "Back", accessPage3MetamorphMenu);
}/*
private function accessHairMenu():void {
	menu();
	addButton(14, "Back", accessPage3MetamorphMenu);
}
private function accessHairMenu():void {
	menu();
	addButton(14, "Back", accessPage3MetamorphMenu);
}
*/
private function accessPage4MetamorphMenu():void {
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
}/*
private function accessHairMenu():void {
	menu();
	addButton(14, "Back", accessPage4MetamorphMenu);
}
private function accessHairMenu():void {
	menu();
	addButton(14, "Back", accessPage4MetamorphMenu);
}
*/
/*
private function metamorph1Fur():void {
	clearOutput();
	player.soulforce -= 100;
	
	
	doNext(accessMetamorphMenu);
}
private function metamorph1Fur():void {
	clearOutput();
	player.soulforce -= 100;
	
	
	doNext(accessMetamorphMenu);
}
private function metamorphGoo():void {
	clearOutput();
	player.soulforce -= 100;
	
	
	doNext(accessMetamorphMenu);
}
private function metamorphGoo():void {
	clearOutput();
	player.soulforce -= 100;
	
	
	doNext(accessMetamorphMenu);
}
private function metamorphGoo():void {
	clearOutput();
	player.soulforce -= 100;
	
	
	doNext(accessMetamorphMenu);
}
private function metamorphGoo():void {
	clearOutput();
	player.soulforce -= 100;
	
	
	doNext(accessMetamorphMenu);
}*/
private function metamorphSphinxArms():void {
	clearOutput();
	player.soulforce -= 100;
	outputText("\n\n");
	if (player.arms.type != Arms.HUMAN) outputText("You watch, spellbound, while your arms gradually changing it entire outer structure into plain human-like form. ");
	outputText("Your hands suddenly start to tingle as your arms grow a thin layer of -fur color- fur up to your shoulders. You watch, enthralled, as your nails fall off your fingers, feline claws taking their place on your five-fingered hands. That said, they don't look exactly like paws as your hands retain their dexterity and general appearance which is a perfect mix between human and leonine features. Thanks to their shape, your new bestial hands should not hinder your spellcasting abilities.. <b>Your arms are now covered in fur and end with clawed hands like those of a sphinx.</b>");
	player.arms.type = Arms.SPHINX;
	doNext(accessPage3ArmsMenu);
}
private function metamorphSphinxWings():void {
	clearOutput();
	player.soulforce -= 100;
	outputText("\n\n");
	if (player.wings.type != Wings.NONE) removeOldWings();
	outputText("Pain lances through your back, the muscles knotting oddly and pressing up to bulge your [skin.type]. It hurts, oh gods does it hurt, but you can't get a good angle to feel at the source of your agony. A loud crack splits the air, and then your body is forcing a pair of narrow limbs through a gap in your [armor]. Blood pumps through the new appendages, easing the pain as they fill out and grow. Tentatively, you find yourself flexing muscles you didn't know you had, and <b>you're able to curve the new growths far enough around to behold your brand new, [haircolor] wings.</b>");
	player.wings.type = Wings.FEATHERED_SPHINX;
	player.wings.desc = "large feathered";
	doNext(accessPage3WingsMenu);
}
private function metamorphManticoreEyes():void {
	clearOutput();
	player.soulforce -= 100;
	outputText("\n\nFor a moment your sight shifts as the ambient light suddenly turns extremely bright, almost blinding you. You walk around disoriented for a moment until the luminosity fades back to normal. You run to a puddle of water to check your reflection and quickly notice your pupils have become cat-like. While you do see way better in the dark, your now red iris are extremely intimidating and clearly don't belong on any normal feline. <b>You now have manticore eyes.</b>");
	player.eyes.type = Eyes.MANTICORE;
	player.eyes.colour = "red";
	doNext(accessPage1EyesMenu);
}
private function metamorphManticoreFace():void {
	clearOutput();
	player.soulforce -= 100;
	outputText("\n\nY");
	if (player.faceType != Face.HUMAN) outputText("our face suddenly mold back into it’s former human shape. However you feel your canines changing, elongating into sharp, dagger-like teeth capable of causing severe injuries. Y");
	outputText("ou feel your canines changing, elongating into sharp, dagger-like teeth capable of causing severe injuries. Funnily, your face remained relatively human even after the change. You feel the need to roar like a lion, to show the world how ferocious you look. <b>Your mouth is now filled with dagger-like canines.</b>");
	player.faceType = Face.MANTICORE;
	doNext(accessPage2FaceMenu);
}
private function metamorphManticoreWingsLarge():void {
	clearOutput();
	player.soulforce -= 200;
	outputText("\n\nYour feel your wings growing larger by the second. They keep growing until they reach three times their original size. The transformation finally stops as your wings reach a span of twice your arms length. These will be really useful should you want to fly around in search of a meal.  <b>You now have fully grown manticore wings.</b>");
	player.wings.type = Wings.MANTICORE_LIKE_LARGE;
	player.wings.desc = "large manticore-like";
	doNext(accessPage2WingsMenu);
}
private function metamorphManticoreWingsSmall():void {
	clearOutput();
	player.soulforce -= 100;
	outputText("\n\n");
	if (player.wings.type != Wings.NONE) removeOldWings();
	outputText("You scream something akin to a roar from the tremendous amount of pain you're suddenly experiencing as something starts to push out from your back. Your claws start digging large marks into the ground as the things stretch out and burst through your skin. Large bones covered in a thin, yet sturdy layer of skin, forming a pair of small bat-like wings slowly push out before finally staying in place. They are too small right now to allow you to take flight but they sure look good on you.  <b>You now have small manticore wings.</b>");
	player.wings.type = Wings.MANTICORE_LIKE_SMALL;
	player.wings.desc = "small manticore-like";
	doNext(accessPage2WingsMenu);
}
private function metamorphManticoreTail():void {
	clearOutput();
	player.soulforce -= 200;
	outputText("\n\nYour scorpion tail starts shifting as your stinger falls to the ground, leaving you with a wide hole at the tip of your tail. You have a feeling of emptiness in your tail, like if it was hollowed from the inside. The end of your tail where the stinger used to be suddenly explodes into a flower-like bulb of flesh. The petals open into what looks like the inside of a pussy, its folds moist and well lubricated. ");
	outputText("Right after the previous transformation’s finished, spikes starts to grow out of the bulbous tip giving your tail tip the appearance of a spiked bulb. Flinging your tail randomly to test your new appendage you shoot one of them straight into a nearby tree. You idly wonder what it will feels like to milk men with this.  <b>It seems you've grown the tail of a manticore.</b>");
	player.tailType = Tail.MANTICORE_PUSSYTAIL;
	doNext(accessPage4TailMenu);
}
private function metamorphScorpionTail():void {
	clearOutput();
	player.soulforce -= 100;
	if (player.tailType != Tail.NONE) outputText("\n\nPainful swelling just above your " + Appearance.buttDescription(player) + " doubles you over, and you hear the sound of your tail dropping off onto the ground!  Before you can consider the implications, the pain gets worse, and you feel your backside bulge outward sickeningly, cracking and popping as a segmented scorpion-like tail grows in place of your old one.  It grows large enough to be impossible to hide, and with a note of finality, your stinger slides free with an audible 'snick'.  <b>You have a scorpion tail.</b>");
	else outputText("\n\nPainful swelling just above your " + Appearance.buttDescription(player) + " doubles you over.  It gets worse and worse as the swollen lump begins to protrude from your backside, swelling and extending with a series of pops until you have a segmented tail hanging just above your butt.  The whole thing is covered in a hard chitinous material, and large enough to be impossible to hide.  You sigh as your stinger slides into place with a 'snick', finishing the transformation.  <b>You have a scorpion tail.</b>");
	player.tailType = Tail.SCORPION;
	player.tailCount = 1;
	player.tailVenom = 15;
	player.tailRecharge = 3;
	doNext(accessPage3TailMenu);
}
private function metamorphLionArms():void {
	clearOutput();
	player.soulforce -= 100;
	outputText("\n\n");
	if (player.arms.type != Arms.HUMAN) outputText("You watch, spellbound, while your arms gradually changing it entire outer structure into plain human-like form. ");
	outputText("Your hands suddenly start to hurt as your arms grows a thick coat of [skin coat.color] fur up to your shoulders where it turns [haircolor]. You watch enthralled as your nails fall off your fingers, feline claws taking their place on your now five-fingered paw-like hands. <b>You now have leonine paw hands.</b>");
	player.arms.type = Arms.LION;
	doNext(accessPage1ArmsMenu);
}
private function metamorphLionLegs():void {
	clearOutput();
	player.soulforce -= 100;
	outputText("\n\n");
	if (player.lowerBody != LowerBody.HUMAN) outputText("You watch, spellbound, while your legs gradually change its entire outer structure into a plain human-like form. ");
	outputText("Your legs suddenly shift painfully, forcing you down on all fours as the bone of your feet changes shape into something entirely different. You feel hairs growing at a rapid rate all over your legs. Something juts out of your toe as they clench into the ground. As you feel the pain recede you sit and take a look at your [feet]; or rather, your large leonine hind paws, now armed with sharp, retractable claws. <b>You now have leonine paws.</b>");
	player.lowerBody = LowerBody.LION;
	player.legCount = 2;
	doNext(accessPage3LegsMenu);
}
private function metamorphLionMane():void {
	clearOutput();
	player.soulforce -= 100;
	outputText("\n\nYou suddenly feel hair growing all around your neck at a crazy pace. It soon get so thick it almost looks as if you're wearing a [haircolor] fur collar. <b>You now have a full lion mane around your neck.</b>");
	player.rearBody.type = RearBody.LION_MANE;
	doNext(accessRearBodyMenu);
}
private function metamorphCat2ndTail():void {
	clearOutput();
	player.soulforce -= 400;
	outputText("\n\nA tingling pressure builds on your backside, and your soft, glossy, and partially forked tail begins to glow with an eerie, ghostly light.  With a crackle of electrical energy, your tail finishes splitting in two!  <b>You now have a pair of cat-tails.</b>");
	player.tailType = Tail.CAT;
	player.tailCount = 2;
	doNext(accessPage1TailMenu);
}
private function metamorphNekomataTwoThirdForkedTail():void {
	clearOutput();
	player.soulforce -= 300;
	outputText("\n\nA tingling pressure builds on your backside, and your soft, glossy, and partially forked tail begins to glow with an eerie, ghostly light.  With a crackle of electrical energy, it starts splitting into two, stopping as another third of its length becomes forked!  <b>You now have a cat tail that is forked at two thirds of its length.</b>");
	player.tailType = Tail.NEKOMATA_FORKED_2_3;
	doNext(accessPage5TailMenu);
}
private function metamorphNekomataOneThirdForkedTail():void {
	clearOutput();
	player.soulforce -= 200;
	outputText("\n\nA tingling pressure builds on your backside, and your soft, glossy tail begins to glow with an eerie, ghostly light.  With a crackle of electrical energy, it starts splitting into two, stopping once the split reaches a third of the way down the length!  <b>You now have a cat tail that is forked on the last third of its length.</b>");
	player.tailType = Tail.NEKOMATA_FORKED_1_3;
	doNext(accessPage5TailMenu);
}
private function metamorphHellcatBurningHair():void {
	clearOutput();
	player.soulforce -= 100;
	outputText("\n\nWarmth then rampage all around body altering your body. In a spectacular explosion your hair is set ablaze, the fire refusing to be put out until it literally replaces them. <b>You now have burning hair.</b>");
	player.hairType = Hair.BURNING;
	doNext(accessHairMenu);
}
private function metamorphHellcatInfernalEyes():void {
	clearOutput();
	player.soulforce -= 100;
	outputText("\n\nWarmth then rampage all around body altering your body. All of these pleasurable changes are driving you insane with pleasure to the point you would try to cry but just as soon as a tear pearls out of your eye it evaporates as two small flames leaks from their corners instead. <b>You now have infernal eyes.</b>");
	player.eyes.type = Eyes.INFERNAL;
	player.eyes.colour = "ember";
	doNext(accessPage2EyesMenu);
}
private function metamorphHellcatBurningTail():void {
	clearOutput();
	player.soulforce -= 100;
	outputText("\n\nWarmth then rampage all around body altering your body. It heads for your tail exploding there in a sheath of flame before spiraling toward your head. <b>You now have burning tail.</b>");
	player.tailType = Tail.BURNING;
	player.tailCount = 1;
	doNext(accessPage5TailMenu);
}
private function metamorphLionEars():void {
	clearOutput();
	player.soulforce -= 100;
	outputText("\n\nYour ears suddenly stretch painfully, making you scream in pain as they move toward the top of your head, growing rounder and bigger. Putting your hands to your ears you discover they are now covered with a fair amount of dark fur. <b>You now have lion ears.</b>");
	player.ears.type = Ears.LION;
	doNext(accessPage2EarsMenu);
}
private function metamorphDisplacerArms():void {
	clearOutput();
	player.soulforce -= 100;
	if (player.arms.type != Arms.HUMAN) restoreHumanArms();
	outputText("\n\nSomething weird is happening around the level of your ribcage. Painfully large bumps start expanding on the side of your body. You fall on all fours panting heavily from the pain as two new limbs surge under your arms. As you sit, trying to grab these new limbs to check them out, you grab your arms instead. No wait your arm grabbed your arm that grabs another arm?! As you examine yourself you discover a second set of limbs grew under your arms. <b>Guess if your mind actually managed to process the action correctly you could actually use four weapons at once, instead you move around on your three set of limbs not unlike a displacer beast.</b>");
	player.arms.type = Arms.DISPLACER;
	doNext(accessPage3ArmsMenu);
}
private function metamorphDisplacerBackTentacles():void {
	clearOutput();
	player.soulforce -= 100;
	outputText("\n\n");
	if (player.rearBody.type != RearBody.NONE) outputText("A wave of tightness spreads through your back, and it feels as if someone is stabbing a dagger in it.  After a moment the pain passes, though your back is back to what you looked like when you entered this realm! ");
	outputText("Two large fleshy lumps explode from your shoulders and you scream in pain. These fleshy appendages weave and move like whips in your back and only stop doing so when you finally manage to calm yourself. <b>As you look back to see what's going on, you notice you now have a pair of tentacles with thick, fleshy heads. You can feel the air brushing over the sensitive needles and suction cups that cover both of them, your new venom glistening on the tips.</b>");
	player.rearBody.type = RearBody.DISPLACER_TENTACLES;
	doNext(accessRearBodyMenu);
}
private function metamorphCheshireCatFangs():void {
	clearOutput();
	player.soulforce -= 200;
	var choice:int;
	outputText("\n\n");
	if (player.faceType != Face.HUMAN) outputText("Your face suddenly mold back into its former human shape. However you feel your canine changing elongating into sharp dagger-like teeth capable of causing severe injuries. ");
	outputText("You feel your canines changing, elongating into sharp dagger-like teeth capable of causing severe injuries. Funnily, your face remained relatively human even after the change. You purr at the change it gives you a cute look. <b>Your mouth is now filled with Cat-like canines.</b>");
	outputText("\n\nYou suddenly feel like smiling. Why actually look so serious? Everything is easier if you take it with a smile and a laughter. Perhaps it's just you taking on that mentality or it's that weird wonderfruit you took but now you feel you could smile forever showing that wide grin of yours. <b>You now have a cheshire smile.</b>");
	player.faceType = Face.CHESHIRE_SMILE;
	doNext(accessPage3FaceMenu);
}
private function metamorphCheshireCatFace():void {
	clearOutput();
	player.soulforce -= 200;
	var choice:int;
	choice = rand(3);
	if (choice == 0) outputText("\n\nYour face is wracked with pain. You throw back your head and scream in agony as you feel your cheekbones breaking and shifting, reforming into something... different. You find a puddle to view your reflection and discover <b>your face is now a cross between human and feline features.</b>");
	else if (choice == 1) outputText("\n\nMind-numbing pain courses through you as you feel your facial bones rearranging.  You clutch at your face in agony as your skin crawls and shifts, your visage reshaping to replace your facial characteristics with those of a feline. <b>You now have an anthropomorphic cat-face.</b>");
	else outputText("\n\nYour face is wracked with pain. You throw back your head and scream in agony as you feel your cheekbones breaking and shifting, reforming into something else. <b>Your facial features rearrange to take on many feline aspects.</b>");
	outputText("\n\nYou suddenly feel like smiling. Why actually look so serious? Everything is easier if you take it with a smile and a laughter. Perhaps it's just you taking on that mentality or it's that weird wonderfruit you took but now you feel you could smile forever showing that wide grin of yours. <b>You now have a cheshire smile.</b>");
	player.faceType = Face.CHESHIRE;
	doNext(accessPage3FaceMenu);
}
private function metamorphCatEyes():void {
	clearOutput();
	player.soulforce -= 100;
	outputText("\n\nYou blink and stumble, a wave of vertigo threatening to pull your [feet] from under you.  As you steady and open your eyes, you realize something seems different.  Your vision is changed somehow.  <b>Your eyes has turned into those of cat with vertical slit.</b>");
	player.eyes.type = Eyes.CAT_SLITS;
	doNext(accessPage1EyesMenu);
}
private function metamorphCatTongue():void {
	clearOutput();
	player.soulforce -= 100;
	outputText("\n\nYour tongue suddenly feel weird. You try to stick it out to see what’s going on and discover it changed to look similar to the tongue of a cat. At least you will be able to groom yourself properly with <b>your new cat tongue.</b>");
	player.tongue.type = Tongue.CAT;
	doNext(accessTongueMenu);
}
private function metamorphCatFangs():void {
	clearOutput();
	player.soulforce -= 100;
	var choice:int;
	outputText("\n\n");
	if (player.faceType != Face.HUMAN) outputText("Your face suddenly mold back into its former human shape. However you feel your canine changing elongating into sharp dagger-like teeth capable of causing severe injuries. ");
	outputText("You feel your canines changing, elongating into sharp dagger-like teeth capable of causing severe injuries. Funnily, your face remained relatively human even after the change. You purr at the change it gives you a cute look. <b>Your mouth is now filled with Cat-like canines.</b>");
	player.faceType = Face.CAT_CANINES;
	doNext(accessPage3FaceMenu);
}
private function metamorphCatFace():void {
	clearOutput();
	player.soulforce -= 100;
	var choice:int;
	choice = rand(3);
	if (choice == 0) outputText("\n\nYour face is wracked with pain. You throw back your head and scream in agony as you feel your cheekbones breaking and shifting, reforming into something... different. You find a puddle to view your reflection and discover <b>your face is now a cross between human and feline features.</b>");
	else if (choice == 1) outputText("\n\nMind-numbing pain courses through you as you feel your facial bones rearranging.  You clutch at your face in agony as your skin crawls and shifts, your visage reshaping to replace your facial characteristics with those of a feline. <b>You now have an anthropomorphic cat-face.</b>");
	else outputText("\n\nYour face is wracked with pain. You throw back your head and scream in agony as you feel your cheekbones breaking and shifting, reforming into something else. <b>Your facial features rearrange to take on many feline aspects.</b>");
	player.faceType = Face.CAT;
	doNext(accessPage1FaceMenu);
}
private function metamorphCatArms():void {
	clearOutput();
	player.soulforce -= 100;
	if (player.arms.type != Arms.HUMAN) restoreHumanArms();
	outputText("\n\nYour hands suddenly start to hurt as your arms grows a thick coat of [skin coat.color] fur up to your shoulders. You watch enthralled as your nails fall off your fingers, feline claws taking their place on your now five-fingered paw-like hands. <b>You now have cat paw hands.</b>");
	player.arms.type = Arms.CAT;
	doNext(accessPage2ArmsMenu);
}
private function metamorphCatLegs():void {
	clearOutput();
	player.soulforce -= 100;
	if (player.lowerBody == LowerBody.HOOFED) {
		outputText("\n\nYou feel your hooves suddenly splinter, growing into five unique digits. Their flesh softens as your hooves reshape into furred cat paws. <b>You now have cat paws.</b>");
		if (player.isTaur()) outputText("  You feel woozy and collapse on your side.  When you wake, you're no longer a centaur and your body has returned to a humanoid shape.");
	}
	else if (player.lowerBody == LowerBody.GOO) {
		outputText("\n\nYour lower body rushes inward, molding into two leg-like shapes that gradually stiffen up.  In moments they solidify into digitigrade legs, complete with soft, padded cat-paws.  <b>You now have cat-paws!</b>");
	}
	else outputText("\n\nYou scream in agony as you feel the bones in your [feet] break and begin to rearrange. When the pain fades, you feel surprisingly well-balanced. <b>You now have cat paws.</b>");
	player.lowerBody = LowerBody.CAT;
	player.legCount = 2;
	doNext(accessPage1LegsMenu);
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
	else outputText("\n\nYou pause and tilt your head... something feels different.  Ah, that's what it is; you turn around and look down at your tail as it starts to change shape, narrowing and sprouting glossy fur. <b>You now have a cat tail.</b>");
	player.tailType = Tail.CAT;
	player.tailCount = 1;
	doNext(accessPage1TailMenu);
}
private function metamorphCatEars():void {
	clearOutput();
	player.soulforce -= 100;
	if (player.ears.type == Ears.HUMAN) {
		if (rand(2) == 0) outputText("\n\nThe skin on the sides of your face stretches painfully as your ears migrate upwards, towards the top of your head. They shift and elongate a little, fur growing on them as they become feline in nature. <b>You now have cat ears.</b>");
		else outputText("\n\nYour ears begin to tingle. You reach up with one hand and gently rub them. They appear to be growing fur. Within a few moments, they've migrated up to the top of your head and increased in size. The tingling stops and you find yourself hearing noises in a whole new way. <b>You now have cat ears.</b>");
	}
	else {
		if (rand(2) == 0) outputText("\n\nYour ears change shape, morphing into pointed, feline ears!  They swivel about reflexively as you adjust to them.  <b>You now have cat ears.</b>");
		else outputText("\n\nYour ears tingle and begin to change shape. Within a few moments, they've become long and feline.  Thanks to the new fuzzy organs, you find yourself able to hear things that eluded your notice up until now. <b>You now have cat ears.</b>");
	}
	player.ears.type = Ears.CAT;
	doNext(accessPage1EarsMenu);
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
		outputText("Feeling an uncomfortable sensation on your butt, you stretch yourself, attributing it to having sat on a rough surface. A burning sensation runs through your body, similar to the one that you had after eating the root. When it migrates to your back, your attention goes to a mass of fluff that has erupted from your backside. Before you can check it properly, it seems to move on its own, following the heated sensation that now pulsates through your body, and when the heated pulses  seem to have stopped, it has become a long, fluffy tube");
		outputText("\n\nShortly after, the feel of that spicy root returns, but now the heat is felt only in your tail, which shakes wildly while it elongates and becomes more bushy. Soon it has become almost as long as you. A very thick mass of soft, fluffy furs covers it in a matter of seconds. It acquires a lovely ringed pattern of red-russet and copperish-orange.");
		outputText("\n\nWhen the effects finally subside, you decide to test the tail, making it coil around your body, realizing soon that you can control its movements with ease, and that its fur feels wonderful at the touch. Anyways, <b>you now have a long, bushy, red-panda tail!</b>");
	}
	else if (player.tailType == Tail.BEE_ABDOMEN || player.tailType == Tail.SPIDER_ADBOMEN || player.tailType == Tail.MANTIS_ABDOMEN) {
		outputText("Your insectile backside seems affected by the root properties, as your venom production suddenly stops. The flesh within the abdomen retracts into your backside, the chiting covering falling, leaving exposed a layer of soft, bare skin. When the abdomen disappears, your left with a comically sized butt, that soon reverts to its usual size.");
		outputText("\n\nThe root keeps doing its thing, as you feel an uncomfortable sensation on your butt. A burning sensation runs through your body, similar to the one that you had after eating the root. When it migrates to your back, your attention goes to a mass of fluff that has erupted from your backside. Before you can check it properly, it seems to move on its own, following the heated sensation that now pulsates through your body, and when the heated pulses  seem to have stopped, it has become a long, fluffy tube, quite different from your former abdomen.");
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
private function metamorphRedPandaLegs():void {
	clearOutput();
	player.soulforce -= 100;
	if (player.isTaur()) outputText("\n\nYou legs tremble, forcing you to lie on the ground, as they don't seems to answer you anymore. A burning sensation in them is the last thing you remember before briefly blacking out. When it subsides and you finally awaken, you look at them again, only to see that you’ve left with a single set of digitigrade legs, and a much more humanoid backside. Soon enough, the feeling returns to your reformed legs, only to come with an itching sensation. A thick black-brown coat of fur sprouts from them. It’s soft and fluffy to the touch. Cute pink paw pads complete the transformation. Seems like <b>you’ve gained a set of red-panda paws!</b>");
	if (player.isNaga()) outputText("\n\nA strange feeling in your tail makes you have to lay on the ground. Then, the feeling becomes stronger, as you feel an increasing pain in the middle of your coils. You gaze at them for a second, only to realize that they’re dividing! In a matter of seconds, they’ve reformed into a more traditional set of legs, with the peculiarity being that they’re fully digitigrade in shape. Soon, every scale on them falls off to leave soft [skin] behind. That doesn’t last long, because soon a thick coat of black-brown fur covers them. It feels soft and fluffy to the touch. Cute pink paw pads complete the transformation. Seems like <b>you’ve gained a set of red-panda paws!</b>");
	if (player.isGoo()) {
		outputText("\n\nThe blob that forms your lower body becomes suddenly rigid under the rhizome effects, forcing you to stay still until the transformation ends. Amazingly, what was once goo turns into flesh and skill in mere seconds, thus leaving you with a very human-like set of legs and feet.");
		outputText("\n\nIt doesn’t stop here as a feeling of unease forces you to sit on a nearby rock, as you feel something within your newly regained feet is changing. Numbness overcomes them, as muscles and bones change, softly shifting, melding and rearranging themselves. For a second you feel that they’re becoming goo again, but after a couple of minutes, they leave you with a set of digitigrade legs with pink pawpads, ending in short black claws and covered in a thick layer of black-brown fur. It feels quite soft and fluffy. <b>You’ve gained a set of red-panda paws!</b>");
	}
	else outputText("\n\nA feeling of unease forces your to sit on a nearby rock, as you feel something within your [feet] is changing. Numbness overcomes them, as muscles and bones change, softly shifting, melding and rearranging themselves. After a couple of minutes, they leave you with a set of digitigrade legs with pink pawpads, ending in short black claws and covered in a thick layer of black-brown fur. It feels quite soft and fluffy. <b>You’ve gained a set of red-panda paws!</b>");
	player.lowerBody = LowerBody.RED_PANDA;
	player.legCount = 2;
	doNext(accessPage3LegsMenu);
}
private function metamorphRedPandaArms():void {
	clearOutput();
	player.soulforce -= 100;
	outputText("\n\nWeakness overcomes your arms, and no matter what you do, you can’t muster the strength to raise or move them. Sighing you attribute this to the consumption of that strange root. Sitting on the ground, you wait for the limpness to end. As you do so, you realize that the bones at your hands are changing, as well as the muscles on your arms. They’re soon covered, from the shoulders to the tip of your digits, on a layer of soft, fluffy black-brown fur. Your hands gain pink, padded paws where your palms were once, and your nails become short claws, not sharp enough to tear flesh, but nimble enough to make climbing and exploring much easier. <b>Your arms have become like those of a red-panda!</b>");
	player.arms.type = Arms.RED_PANDA;
	doNext(accessPage2ArmsMenu);
}
private function metamorphRedPandaFace():void {
	clearOutput();
	player.soulforce -= 100;
	outputText("\n\nNumbness comes to your cheekbones and jaw, while the rest of your head is overwhelmed by a tingling sensation. Every muscle on your face tenses and shifts, while the bones and tissue rearrange, radically changing the shape of your head. You have troubles breathing as the changes reach your nose, but you manage to see as it changes into an animalistic muzzle. You jaw joins it and your teeth sharpen a little, not to the point of being true menacing, but gaining unequivocally the shape of those belonging on a little carnivore.");
	outputText("\n\nOnce you’re face and jaw has reshaped, fur covers the whole of your head. The soft sensation is quite pleasant. It has a russet-red coloration, that turns to white on your muzzle and cheeks. Small, rounded patches of white cover the area where your eyebrows were. <b>You now have a red-panda head!</b>");
	player.faceType = Face.RED_PANDA;
	doNext(accessPage3FaceMenu);
}
private function metamorphRedPandaEars():void {
	clearOutput();
	player.soulforce -= 100;
	outputText("\n\nA sudden dizziness seems to overcome your head. Your ears tingle, and you’re sure you can feel the flesh on them shifting, as you gradually have trouble hearing. A couple of minutes later the feeling stops. Curious of what has changed you go to check yourself on the stream, only to find that they’ve changed into cute, triangular ears, covered with white fur. <b>You’ve got red-panda ears!</b>");
	player.ears.type = Ears.RED_PANDA;
	doNext(accessPage3EarsMenu);
}
private function metamorphNightmareWings():void {
	clearOutput();
	player.soulforce -= 200;
	if (player.wings.type != Wings.NONE) removeOldWings();
	outputText("\n\nPain lances through your back, the muscles knotting oddly and pressing up to bulge your [skin.type]. It hurts, oh gods does it hurt, but you can't get a good angle to feel at the source of your agony. A loud crack splits the air, and then your body is forcing a pair of narrow limbs through a gap in your [armor]. Blood pumps through the new appendages, easing the pain as they fill out and grow. Tentatively, you find yourself flexing muscles you didn't know you had, and <b>you're able to curve the new growths far enough around to behold your brand new, white wings.</b>");
	player.wings.type = Wings.NIGHTMARE;
	player.wings.desc = "large black leathery";
	doNext(accessPage2WingsMenu);
}
private function metamorphBicornHorns():void {
	clearOutput();
	player.soulforce -= 100;
	if (player.horns.type == Horns.NONE) outputText("\n\nWith painful pressure, the skin on your forehead splits around two tiny nub-like horn, a little bit similar to that you would see on the cattle back in your homeland.");
	else outputText("\n\nYour horns vibrate and shift as if made of clay, reforming into horns with a bicorn-like shape.");
	player.horns.count = 2;
	player.horns.type = Horns.BICORN;
	doNext(accessPage2HornsMenu);
}
private function metamorphAlicornWings():void {
	clearOutput();
	player.soulforce -= 200;
	if (player.wings.type != Wings.NONE) removeOldWings();
	outputText("\n\nPain lances through your back, the muscles knotting oddly and pressing up to bulge your [skin.type]. It hurts, oh gods does it hurt, but you can't get a good angle to feel at the source of your agony. A loud crack splits the air, and then your body is forcing a pair of narrow limbs through a gap in your [armor]. Blood pumps through the new appendages, easing the pain as they fill out and grow. Tentatively, you find yourself flexing muscles you didn't know you had, and <b>you're able to curve the new growths far enough around to behold your brand new, white wings.</b>");
	player.wings.type = Wings.FEATHERED_ALICORN;
	player.wings.desc = "large white feathered";
	doNext(accessPage2WingsMenu);
}
private function metamorphUnicornHorn():void {
	clearOutput();
	player.soulforce -= 100;
	if (player.horns.type == Horns.NONE) outputText("\n\nWith painful pressure, the skin on your forehead splits around tiny nub-like horn, a little bit similar to that you would see on the cattle back in your homeland.");
	else outputText("\n\nYour horns vibrate and shift as if made of clay, reforming into horn with a unicorn-like shape.");
	player.horns.count = 2;
	player.horns.type = Horns.UNICORN;
	doNext(accessPage1HornsMenu);
}
private function metamorphHorseTail():void {
	clearOutput();
	player.soulforce -= 100;
	if (player.tailType == 0) outputText("\n\nThere is a sudden tickling on your ass, and you notice you have sprouted a long shiny horsetail of the same [haircolor] color as your hair.");
	if (player.tailType > Tail.HORSE && player.tailType <= Tail.COW) outputText("\n\nPain lances up your " + Appearance.assholeDescript(player) + " as your tail shifts and morphs disgustingly.  With one last wave of pain, it splits into hundreds of tiny filaments, transforming into a horsetail.");
	if ((player.tailType > Tail.COW && player.tailType < Tail.SHARK) || player.tailType == Tail.SCORPION || player.tailType == Tail.MANTIS_ABDOMEN) outputText("\n\nYour insect-like abdomen bunches up as it begins shrinking, exoskeleton flaking off like a snake sheds its skin.  It bunches up until it is as small as a tennis ball, then explodes outwards, growing into an animalistic tail shape.  Moments later, it explodes into filaments of pain, dividing into hundreds of strands and turning into a shiny horsetail.");
	if (player.tailType >= Tail.SHARK) outputText("\n\nPain lances up your " + player.assholeDescript() + " as your tail shifts and morphs disgustingly.  With one last wave of pain, it splits into hundreds of tiny filaments, transforming into a horsetail.");
	outputText("  <b>You now have a horse-tail.</b>");
	player.tailType = Tail.HORSE;
	doNext(accessPage1TailMenu);
}
private function metamorphHorseEars():void {
	clearOutput();
	player.soulforce -= 100;
	if (player.ears.type == Ears.HUMAN) outputText("\n\nYour ears tug painfully on your face as they begin shifting, moving upwards to the top of your head and transforming into a upright animalistic ears.  ");
	if (player.ears.type == Ears.DOG) outputText("\n\nYour ears change shape, morphing into from their doglike shape into equine-like ears!  ");
	else outputText("\n\nYour ears change shape, morphing into teardrop-shaped horse ears!  ");
	outputText("<b>You now have horse ears.</b>");
	player.ears.type = Ears.HORSE;
	doNext(accessPage1EarsMenu);
}
private function metamorphHorseFace():void {
	clearOutput();
	player.soulforce -= 100;
	if (player.faceType == Face.DOG) outputText("\n\nMind-numbing pain shatters through you as you feel your facial bones rearranging.  You clutch at your face in agony as your skin crawls and shifts, your visage reshaping to replace your dog-like characteristics with those of a horse.  <b>You now have a horse's face.</b>");
	else outputText("\n\nMind-numbing pain shatters through you as you feel your facial bones breaking and shifting.  You clutch at yourself in agony as you feel your skin crawl and elongate under your fingers.  Eventually the pain subsides, leaving you with a face that seamlessly blends human and equine features.  <b>You have a very equine-looking face.</b>");
	player.faceType = Face.HORSE;
	doNext(accessPage1FaceMenu);
}
private function metamorphOrcSkinPattern():void {
	clearOutput();
	player.soulforce -= 100;
	outputText("\n\nYou double over suddenly as a harsh, stabbing pain runs across your skin, tattoos in the shape of scars forming on various parts of your body. Considering how you look now, you might as well proudly display your <b>Orc scar tattooed skin.</b>");
	player.skin.base.pattern = Skin.PATTERN_SCAR_SHAPED_TATTOO;
	player.skin.base.adj = "scar shaped tattooed";
	doNext(accessSkinPatternsMenu);
}
private function metamorphOrcEyes():void {
	clearOutput();
	player.soulforce -= 100;
	if (player.eyes.type != Eyes.HUMAN) removeOddEyes();
	player.eyes.colour = "bloody red";
	outputText("\n\nYou blink and stumble, a wave of vertigo threatening to pull your [feet] from under you.  As you steady yourself and open your eyes, you realize something seems different, as if the nerves have been optimized.  Your vision has been changed somehow.  <b>Your eyes has turned into those of orc.</b>");
	player.eyes.type = Eyes.ORC;
	doNext(accessPage2EyesMenu);
}
private function metamorphOrcFangs():void {
	clearOutput();
	player.soulforce -= 100;
	outputText("\n\nY");
	if (player.faceType != Face.HUMAN) outputText("our face suddenly mold back into it’s former human shape. However y");
	outputText("ou feel your two lower canines grow bigger and slightly sharper, similar to those of a boar, or in your case, an orc. <b>You now have orc canines.</b>");
	player.faceType = Face.ORC_FANGS;
	doNext(accessPage4FaceMenu);
}
private function metamorphOrcArms():void {
	clearOutput();
	player.soulforce -= 100;
	if (player.arms.type != Arms.HUMAN) restoreHumanArms();
	outputText("\n\nThe skin on your arms feels as if they’re being cut open as a whole new set of intricate scar-like tattoos covers them. Furthermore your nails become increasingly pointed just like a set of claws and your arms in general grow a bit longer. Well, it seems you’re going to have some issues hiding your <b>scar tattooed arms and sharp nails.</b>");
	player.arms.type = Arms.ORC;
	doNext(accessPage3ArmsMenu);
}
private function metamorphOrcLegs():void {
	clearOutput();
	player.soulforce -= 100;
	if (player.lowerBody != LowerBody.HUMAN) restoreHumanLegs();
	outputText("\n\nYou have trouble standing up as multiple flashes of mild pain run across your legs as a whole set of intricate scar shaped tattoos covers them. Furthermore, your toenails become increasingly pointed, looking like a set of claws. Well, it seems you will have get used to your <b>scar tattooed legs and feet topped with pointed nails.</b>");
	player.lowerBody = LowerBody.ORC;
	player.legCount = 2;
	doNext(accessPage4LegsMenu);
}
private function metamorphHumanNoRearBody():void {
	clearOutput();
	player.soulforce -= 500;
	outputText("\n\nA wave of tightness spreads through your back, and it feels as if someone is stabbing a dagger in it.  After a moment the pain passes, though your back is back to what you looked like when you entered this realm!");
	player.rearBody.type = RearBody.NONE;
	doNext(accessRearBodyMenu);
}
private function metamorphHumanNoTail():void {
	clearOutput();
	player.soulforce -= 500;
	outputText("\n\nYou feel something shifting in your backside. Then something detaches from your backside and it falls onto the ground.  <b>You no longer have a tail!</b>");
	player.tailType = Tail.NONE;
	player.tailCount = 0;
	player.tailVenom = 0;
	player.tailRecharge = 5;
	doNext(accessPage1TailMenu);
}
private function metamorphHumanNoWings():void {
	clearOutput();
	player.soulforce -= 500;
	outputText("\n\nA wave of tightness spreads through your back, and it feels as if someone is stabbing a dagger into each of your shoulder-blades.  After a moment the pain passes, though your wings are gone!");
	player.wings.type = Wings.NONE;
	player.wings.desc = "non-existant";
	doNext(accessPage1WingsMenu);
}
private function metamorphHumanNoHorns():void {
	clearOutput();
	player.soulforce -= 500;
	if (player.horns.type == Horns.ORCHID) outputText("\n\nYour orchid flowers crumble, falling apart");
	else outputText("\n\nYour horns crumble, falling apart in large chunks");
	outputText(" until they flake away to nothing.");
	player.horns.count = 0;
	player.horns.type = Horns.NONE;
	doNext(accessPage1HornsMenu);
}
private function metamorphHumanNoAntennae():void {
	clearOutput();
	player.soulforce -= 500;
	outputText("\n\nThe muscles in your brow clench tightly, and you feel a tremendous pressure on your upper forehead.  When it passes, you touch yourself and discover your antennae.type have vanished!");
	player.antennae.type = Antennae.NONE;
	doNext(accessAntennaeMenu);
}
private function metamorphHumanHair():void {
	clearOutput();
	player.soulforce -= 500;
	if (player.hairType == Hair.FEATHER || player.hairType == Hair.QUILL) {
		var word1:String;
		if (player.hairType == Hair.FEATHER) word1 = "feather";
		else word1 = "quill";
		if (player.hairLength >= 6) outputText("\n\nA lock of your downy-soft " + word1 + "-hair droops over your eye.  Before you can blow the offending down away, you realize the " + word1 + " is collapsing in on itself.  It continues to curl inward until all that remains is a normal strand of hair.  <b>Your hair is no longer " + word1 + "-like!</b>");
		else outputText("\n\nYou run your fingers through your downy-soft " + word1 + "-hair while you await the effects of the item you just ingested.  While your hand is up there, it detects a change in the texture of your " + word1 + "s.  They're completely disappearing, merging down into strands of regular hair.  <b>Your hair is no longer " + word1 + "-like!</b>");
	}
	if (player.hairType == Hair.ANEMONE) outputText("\n\nYou feel something strange going in on your head. You reach your hands up to feel your tentacle-hair, only to find out that the tentacles have vanished and replaced with normal hair.  <b>Your hair is normal again!</b>");
	if (player.hairType == Hair.GOO) outputText("\n\nYour gooey hair begins to fall out in globs, eventually leaving you with a bald head.  Your head is not left bald for long, though.  Within moments, a full head of hair sprouts from the skin of your scalp.  <b>Your hair is normal again!</b>");
	if (player.hairType == Hair.GORGON) {
		player.hairLength = 1;
		outputText("\n\nAs you finish the root, the scaled critters on your head shake wildly in displeasure. Then, a sudden heat envelopes your scalp. The transformative effects of your spicy meal make themselves notorious, as the writhing mess of snakes start hissing uncontrollably. Many of them go rigid, any kind of life that they could had taken away by the root effects. Soon all the snakes that made your hair are limp and lifeless.");
		outputText("\n\nTheir dead bodies are separated from you head by a scorching sensation, and start falling to the ground, turning to dust in a matter of seconds. Examining your head on the stream, you realize that you have a normal, healthy scalp, though devoid of any kind of hair.");
		outputText("\n\nThe effects don’t end here, though as the familiar sensation of hair returns to your head a moment later. After looking yourself on the stream again, you confirm that <b>your once bald head now has normal, short [haircolor] hair</b>.");
	}
	if (player.hairType == Hair.GHOST) outputText("\n\nA sensation of weight assaults your scalp. You reach up and grab a handful of hair, confused. Your perplexion only heightens when you actually feel the follicles becoming heavier in your grasp.  Plucking a strand, you hold it up before you, surprised to see... it's no longer transparent!  You have normal hair!");
	if (player.hairType == Hair.LEAF) {
		if (player.hairLength >= 6) outputText("\n\nA lock of your leaf-hair droops over your eye.  Before you can blow the offending down away, you realize the leaf is changing until all that remains is a normal strand of hair.  <b>Your hair is no longer leaf-like!</b>");
		else outputText("\n\nYou run your fingers through your leaf-hair while you await the effects of the item you just ingested.  While your hand is up there, it detects a change in the texture of your leafs.  They're completely disappearing, merging down into strands of regular hair.  <b>Your hair is no longer leaf-like!</b>");
	}
	if (player.hairType == Hair.FLUFFY) outputText("\n\nYou feel something strange going in on your head. You reach your hands up to feel your fluffy hair, only to find out that they have vanished and replaced with normal hair.  <b>Your hair is normal again!</b>");
	if (player.hairType == Hair.GRASS) outputText("\n\nYou feel something strange going in on your head. You reach your hands up to feel your grass-hair, only to find out that the long, soft and leafy blades have vanished and replaced with normal hair.  <b>Your hair is normal again!</b>");
	if (player.hairType == Hair.SILKEN) outputText("\n\nYou feel something strange going in on your head. You reach your hands up to feel your silken-hair, only to find out that they have changed back to normal hair.  <b>Your hair is normal again!</b>");
	if (player.hairType == Hair.BURNING) outputText("\n\nYou're head begins to cool down until the flames entirely disapears leaving you with ordinary hairs.  <b>Your hair is normal again!</b>");
	player.hairType = Hair.NORMAL;
	doNext(accessHairMenu);
}
private function metamorphHumanNoGills():void {
	clearOutput();
	player.soulforce -= 500;
	if (player.gills.type == Gills.ANEMONE) outputText("\n\nYour chest itches, and as you reach up to scratch it, you realize your gills have withdrawn into your skin.");
	if (player.gills.type == Gills.FISH) outputText("\n\nYou feel your gills tighten, the slits seeming to close all at once. As you let out a choked gasp your gills shrink into nothingness, leaving only smooth skin behind. Seems you won't be able to stay in the water quite so long anymore.");
	outputText("  <b>You no longer have gills!</b>");
	player.gills.type = Gills.NONE;
	doNext(accessGillsMenu);
}
private function metamorphHumanEars():void {
	clearOutput();
	player.soulforce -= 500;
	outputText("\n\nOuch, your head aches! It feels like your ears are being yanked out of your head, and when you reach up to hold your aching noggin, you find they've vanished! Swooning and wobbling with little sense of balance, you nearly fall a half-dozen times before <b>a pair of normal, human ears sprout from the sides of your head.</b> You had almost forgotten what human ears felt like!");
	player.ears.type = Ears.HUMAN;
	doNext(accessPage1EarsMenu);
}
private function metamorphHumanEyes():void {
	clearOutput();
	player.soulforce -= 500;
	if (player.eyes.type == Eyes.BLACK_EYES_SAND_TRAP) {
		outputText("\n\nYou feel a twinge in your eyes and you blink.  It feels like black cataracts have just fallen away from you, and you know without needing to see your reflection that your eyes have gone back to looking human.");
	}
	else {
		outputText("\n\nYou blink and stumble, a wave of vertigo threatening to pull your [feet] from under you.  As you steady and open your eyes, you realize something seems different.  Your vision is changed somehow.");
		if (player.eyes.type == Eyes.FOUR_SPIDER_EYES) outputText("  Your multiple, arachnid eyes are gone!</b>");
		outputText("  <b>You have normal, humanoid eyes again.</b>");
	}
	player.eyes.type = Eyes.HUMAN;
	doNext(accessPage1EyesMenu);
}
private function metamorphHumanTongue():void {
	clearOutput();
	player.soulforce -= 500;
	outputText("\n\nYou feel something strange inside your face as your tongue shrinks and recedes until it feels smooth and rounded.  <b>You realize your tongue has changed back into human tongue!</b>");
	player.tongue.type = Tongue.HUMAN;
	doNext(accessTongueMenu);
}
private function metamorphHumanFace():void {
	clearOutput();
	player.soulforce -= 500;
	outputText("\n\nSudden agony sweeps over your [face], your visage turning hideous as bones twist and your jawline shifts. The pain slowly vanishes, leaving you weeping into your fingers. When you pull your hands away you realize you've been left with a completely normal, <b>human face</b>.");
	player.faceType = Face.HUMAN;
	doNext(accessPage1FaceMenu);
}
private function metamorphHumanArms():void {
	clearOutput();
	player.soulforce -= 500;
	restoreHumanArms();
	doNext(accessPage1ArmsMenu);
}
private function metamorphHumanNoSkinPatterns():void {
	clearOutput();
	player.soulforce -= 500;
	outputText("\n\nYour skin patterns itches incessantly, and as you scratch they shifts and changes, becoming less and less visible till they gone.  <b>Your skin is without any skin patterns!</b>");
	player.skin.base.pattern = Skin.PATTERN_NONE;
	player.skin.base.adj = "";
	doNext(accessSkinPatternsMenu);
}
private function metamorphHumanSkin():void {
	clearOutput();
	player.soulforce -= 500;
	switch (player.coatType()) {
		case Skin.FUR:
			outputText("\n\nYour fur itches incessantly, so you start scratching it.  It starts coming off in big clumps before the whole mess begins sloughing off your body.  In seconds, your skin is nude.  <b>You've lost your fur!</b>");
			break;
		case Skin.SCALES:
			outputText("\n\nYour scales itch incessantly, so you scratch at them.  They start falling off wholesale, leaving you standing in a pile of scales after only a few moments.  <b>You've lost your scales!</b>");
			break;
		case Skin.DRAGON_SCALES:
			outputText("\n\nYour dragon scales itch incessantly, so you scratch at them.  They start falling off wholesale, leaving you standing in a pile of scales after only a few moments.  <b>You've lost your dragon scales!</b>");
			break;
		default:
			outputText("\n\nYour [skin noadj] itches incessantly, and as you scratch it shifts and changes, becoming normal human-like skin.  <b>Your skin is once again normal!</b>");
	}
	player.skin.setBaseOnly({type: Skin.PLAIN, adj:""});
	doNext(accessSkinMenu);
}
private function metamorphHumanLegs():void {
	clearOutput();
	player.soulforce -= 500;
	restoreHumanLegs();
	doNext(accessPage1LegsMenu);
}
private function metamorphBoarArms():void {
	clearOutput();
	player.soulforce -= 100;
	if (player.arms.type != Arms.HUMAN) restoreHumanArms();
	outputText("\n\nYour arms and hands start covering in fur at an alarming rate suddenly as you poke at your palms you jolt up as they become extremely sensitive. Furthermore your nails become increasingly pointed turning black just like a set of claws. <b>You now have boar arms.</b>");
	player.arms.type = Arms.BOAR;
	doNext(accessPage3ArmsMenu);
}
private function metamorphBoarFace():void {
	clearOutput();
	player.soulforce -= 100;
	outputText("\n\nYou cry out in pain as the bones in your face begin to break and rearrange. You rub your face furiously in an attempt to ease the pain, but to no avail. Your bottom teeth ache as well. What’s happening to you? As the sensations pass, you examine your face in a nearby puddle. <b>You nearly gasp in shock at the sight of your new tusky boar face!</b>");
	player.faceType = Face.BOAR;
	doNext(accessPage2FaceMenu);
}
private function metamorphPigFace():void {
	clearOutput();
	player.soulforce -= 100;
	outputText("\n\nYou cry out in pain as the bones in your face begin to break and rearrange. You rub your face furiously in an attempt to ease the pain, but to no avail. As the sensations pass, you examine your face in a nearby puddle. <b>You nearly gasp in shock at the sight of your new pig face!</b>");
	player.faceType = Face.PIG;
	doNext(accessPage2FaceMenu);
}
private function metamorphPigArms():void {
	clearOutput();
	player.soulforce -= 100;
	if (player.arms.type != Arms.HUMAN) restoreHumanArms();
	outputText("\n\nYour finguers starts to feel like some bee stung them as they inflates to a more chubby size your nails tickening and darkening turning into clover-like claws. Aside of your now fat finguers and darker claws your arms remains about the same. <b>You now have pig arms.</b>");
	player.arms.type = Arms.PIG;
	doNext(accessPage3ArmsMenu);
}
private function metamorphPigTail():void {
	clearOutput();
	player.soulforce -= 100;
	if (player.tailType == Tail.NONE) outputText("\n\nYou feel a tug at the base of your spine as it lengthens ever so slightly. Looking over your shoulder, <b>you find that you have sprouted a small, curly pig tail.</b>");
	else outputText("\n\nYou feel a pinching sensation in your [tail] as it begins to warp in change. When the sensation dissipates, <b>you are left with a small, curly pig tail.</b>");
	player.tailType = Tail.PIG;
	doNext(accessPage3TailMenu);
}
private function metamorphPigEars():void {
	clearOutput();
	player.soulforce -= 100;
	outputText("\n\nYou feel a pressure on your ears as they begin to reshape. Once the changes finish, you flick them about experimentally, <b>and you’re left with pointed, floppy pig ears.</b>");
	player.ears.type = Ears.PIG;
	doNext(accessPage2EarsMenu);
}
private function metamorphVampireFace():void {
	clearOutput();
	player.soulforce -= 100;
	outputText("\n\nYou yelp as a throbbing pain takes root in the sides of your mouth. You feel your canines grow longer as your throat grow dryer. You could go for some wine right now, with a bloody steak to top it off… maybe just the steak.");
	outputText(" Or just the blood, really. You aren’t picky. Really, it’s up to you whether just rip off some poor sod’s throat and drink straight from the tap or drink blood from a wineglass, what with <b>your new vampire fangs!</b>");
	player.faceType = Face.VAMPIRE;
	doNext(accessPage3FaceMenu);
}
private function metamorphVampireEyes():void {
	clearOutput();
	player.soulforce -= 100;
	if (player.eyes.type != Eyes.HUMAN) removeOddEyes();
	outputText("\n\nYour eyes shift, causing sunlight to suddenly become annoyingly bright for you. It takes several minutes for your eyes to get used to it and, once they do, you still have to keep them half closed, so as to not be blinded by the sun’s glare.");
	outputText(" Upon looking at your reflection in the water, you discover your irises have taken on a blood-red shade. <b>You have Vampire Eyes.</b>");
	player.eyes.type = Eyes.VAMPIRE;
	doNext(accessPage2EyesMenu);
}
private function metamorphVampireWings():void {
	clearOutput();
	player.soulforce -= 100;
	if (player.wings.type == Wings.BAT_ARM) {
		outputText("\n\nYou cry out as your arms creak and twist, your bones breaking down and reforming in a frenzy. Your parchment-like skin begins to fall off in clumps, leaving the mess of malformed bones that are your arms right now naked for all to see. However, even as you watch, dark blood creeps over the bone, properly aligning them before healing them over, although not in their old form. Within seconds, the pain is gone, as your bones are remade into ones alike those you were born with, in structure if nothing else, the eldritch power of your blood finally ebbing away, but not before the last of it settles and turns into a brand new patch of skin. It's still sensitive, but you'll get used to it. ");
		outputText("You catch something moving on the edge of your peripheral vision, causing your hard-won instincts to kick in, muscle memory forcing you into a lunge away from whatever it was before you’re even fully aware of what’s happening. Instead of dodging with your usual grace, you stumble and roll, landing on your wings... Wait, <i>wings??</i> It seems that, while you were fascinated by your bloody shenanigans, you failed to notice that you were growing wings. Understandable, since your arms breaking themselves several times over tends to take priority over such things, attention-wise. You shakily stand up, your balance still thrown off by the new limb, inwardly grumbling at how long is it going to take you to get used to them. ");
		outputText("Distracted as you are, both from the ordeal and your inner grumbling, your first attempt at walking inevitably ends with an intimate reunion of your face and the ground. This time, you don’t bother to keep your cursing to the confines of your own mind. <b>You will now be able to enjoy nightly flights with your brand new vampire wings.</b>");
	}
	else {
		outputText("\n\nA terrible pain flares in the center of your back, a pain so intense that you black out briefly, coming back to your senses as you hit your head against the ground. You hear a horrifying ripping noise as your back stretches and tears to allow new bones to expand, black as tar and far lighter than most of the bones in your body. These new bones shift under your shoulder blade skin as you fall on all groaning in pain and clawing at the ground. In a flash of pain they violently break out of your skin sending blood everywhere as you make a chilling scream your wounds slowly closing on their own. Still panting from the pain, you take a look at your new appendage. It's a pair of large vampire wings of impressive size. ");
		outputText("Feeling chilly you fold them back on your body and you ought to admit they indeed look like a large cape. <b>You will be able to enjoy nightly flight using your brand new vampire wings.</b>");
	}
	player.wings.type = Wings.VAMPIRE;
	player.wings.desc = "large bat";
	doNext(accessPage2WingsMenu);
}
private function metamorphVampireEars():void {
	clearOutput();
	player.soulforce -= 100;
	outputText("\n\n");
	if (player.ears.type != Ears.HUMAN) outputText("Your ears revert back to their old human shape you had almost forgotten what humans ears felt like, before you can dwell on the implications of that, the changes continue. ");
	outputText("Your ears begin to prickle as they elongate to a point, being now reminiscent of those of elves, goblins, or in your case, vampires. Aside from looking cute, you find your new ears have drastically improved your hearing. <b>Sound has become an entirely new experience now that you have pointy vampire ears!</b>");
	player.ears.type = Ears.VAMPIRE;
	doNext(accessPage3EarsMenu);
}
private function metamorphBatCollar():void {
	clearOutput();
	player.soulforce -= 100;
	outputText("\n\nAn intense itching sets in around your neck. Bringing your hands to your neck to scratch it, you find sparse, downy fuzz. As you scratch away, it continues lengthening and growing in density until you have a collar of fur around your neck.");
	outputText(" Well, this isn’t so bad, the scarf-like look is certainly nice, at the very least. <b>Your neck now sports a collar of fur.</b>");
	player.hairType = RearBody.BAT_COLLAR;
	doNext(accessRearBodyMenu);
}
private function metamorphBatWings():void {
	clearOutput();
	player.soulforce -= 100;
	if (player.arms.type != Arms.HUMAN) restoreHumanArms();
	outputText("\n\nLarge bones surge out of your wrists and elbows. You can feel your bones shifting and grinding all over your body as your skeletal structure begins changing into one more fit for a flying creature, with light, hollow bones. You collapse to the ground as they begin shifting proportions becoming thinner and longer to maximize area while reducing their density. Leathery flesh begins to cover your new bony protrusions, spreading between each of them like creeping moss.");
	outputText(" Eventually, the skin stops growing and you admire your new arms. They are very obviously bat wings. You close them around your waist, like this they could easily be mistaken for a large cape when seen from afar. <b>You now have large bat wings.</b>");
	player.wings.type = Wings.BAT_ARM;
	player.wings.desc = "bat";
	doNext(accessPage2WingsMenu);
}
private function metamorphBatEars():void {
	clearOutput();
	player.soulforce -= 100;
	outputText("\n\nYour ears begin to prickle and burn as the skin tears and stretches, changing into wide, deep ears, perfect for catching any stray sound. Which becomes apparent when your hearing becomes far more clear than it has ever been. <b>Sound has become an entirely new experience now that you have bat ears!</b>");
	player.ears.type = Ears.BAT;
	doNext(accessPage2EarsMenu);
}
private function metamorphRaijuSkinPattern():void {
	clearOutput();
	player.soulforce -= 100;
	outputText("\n\nYou suddenly feel a rush of electricity on your skin as glowing tattoos in the shape of lightning bolts form in various place across your body. Well, how shocking. <b>Your skin is now inscribed with some lightning shaped tattoos.</b>");
	player.skin.base.pattern = Skin.PATTERN_LIGHTNING_SHAPED_TATTOO;
	player.skin.base.adj = "lightning shaped tattooed";
	doNext(accessSkinPatternsMenu);
}
private function metamorphRaijuHair():void {
	clearOutput();
	player.soulforce -= 100;
	outputText("\n\nThe ends of your hair seem to split before a quick jolt smacks you in the back of the head. Irritated and confused, you rub the back of your head only to get a small zap in return. You wander over to a puddle and make note of several glowing strands of hair shaped like the typical stylized lightning bolt. There's even a single strand that floats just off the side of your face!");
	player.hairType = Hair.STORM;
	doNext(accessHairMenu);
}
private function metamorphRaijuEyes():void {
	clearOutput();
	player.soulforce -= 100;
	if (player.eyes.type != Eyes.HUMAN) removeOddEyes();
	player.eyes.type = Eyes.RAIJU;
	if (rand(2) == 0) player.eyes.colour = "blue";
	else {
		if (rand(2) == 0) player.eyes.colour = "green";
		else player.eyes.colour = "teal";
	}
	outputText("\n\nBright lights flash into your vision as your eyes glow with electric light. Blinded, you rapidly shake your head around, trying to clear your vision. It takes a moment, but your vision eventually returns to normal. Curious, you go over to a nearby puddle and find <b>glowing [eyecolor] bestial slitted eyes staring back at you.</b>");
	doNext(accessPage2EyesMenu);
}
private function metamorphRaijuEars():void {
	clearOutput();
	player.soulforce -= 100;
	if (player.ears.type != Ears.HUMAN) restoreHumanEars();
	outputText("\n\nYour ears twitch as jolt of lightning flows through them, replacing all sound with crackling pops. You moan as the lightning arcs up to the top of your head before fanning out to the side. Hearing suddenly returns as you run your hands across your <b>new weasel ears!</b>");
	player.ears.type = Ears.WEASEL;
	doNext(accessPage2EarsMenu);
}
private function metamorphRaijuFace():void {
	clearOutput();
	player.soulforce -= 100;
	if (player.faceType != Face.HUMAN) outputText("our face suddenly mold back into it’s former human shape. However y");
	outputText("ou feel your two canines grow bigger and slightly sharper, not unlike those of a weasel or in your case a raiju. <b>You now have raiju canines.</b>");
	player.faceType = Face.RAIJU_FANGS;
	doNext(accessPage3FaceMenu);
}
private function metamorphRaijuMane():void {
	clearOutput();
	player.soulforce -= 100;
	outputText("\n\nThe base of your neck tingles with delight as little sparks travel across your skin. Strands of hair quickly grow in, giving you a [haircolor] collar of fur around your neck. Several strands of your new fur collar are quite dark, arcing around it like lightning.");
	player.rearBody.type = RearBody.RAIJU_MANE;
	doNext(accessRearBodyMenu);
}
private function metamorphRaijuTail():void {
	clearOutput();
	player.soulforce -= 100;
	if (player.tailType == Tail.NONE) outputText("\n\nYou yelp as a huge lightning bolt bursts out the area just above your ass. You watch in amazement as it twist and curls, slowly becoming thicker and thicker before it fizzles out, <b>leaving you with a silky Raiju tail!</b>");
	else outputText("\n\nYou nearly jump out of your skin as your tail burst into a huge lightning bolt. You watch as it curls and twist around before it fizzles out.  <b>You now have a silky Raiju tail!</b>");
	player.tailType = Tail.RAIJU;
	doNext(accessPage4TailMenu);
}
private function metamorphRaijuArms():void {
	clearOutput();
	player.soulforce -= 100;
	if (player.arms.type != Arms.HUMAN) restoreHumanArms();
	outputText("\n\nYour nails tingle as they elongate into white claws! They look quite dangerous, but you feel the strange need to use them to stimulate your ");
	if (player.gender == 1 || player.gender == 3) outputText("[cock]");
	if (player.gender == 3) outputText(" and ");
	if (player.gender > 1) outputText("[clit]");
	outputText(". ");
	if (player.cor >= 50) outputText("You give a lusty smile, thinking that it wouldn't be so bad...");
	else outputText("You scowl, shaking away the impure thoughts.");
	player.arms.type = Arms.RAIJU;
	doNext(accessPage2ArmsMenu);
}
private function metamorphRaijuLegs():void {
	clearOutput();
	player.soulforce -= 100;
	if (player.lowerBody != LowerBody.HUMAN) restoreHumanLegs();
	outputText("\n\nYou have trouble standing as multiple flashes of sensation run across your legs. Sitting down before you accidently hurt yourself, you watch with apprehension as your legs begin to shift, fluffy patches of fur traveling up your legs until they reach your knees. You yelp as the bones in your feet split and rearrange themselves into paws. Eventually, the sensation ebbs and you slowly get used to your <b>Raiju paws!</b>");
	player.lowerBody = LowerBody.RAIJU;
	player.legCount = 2;
	doNext(accessPage3LegsMenu);
}
private function metamorphOniSkinPattern():void {
	clearOutput();
	player.soulforce -= 100;
	outputText("\n\nAs you thought your skin couldn't handle more tattoo a few localised skin burns reveal a new set of drawing along your skin, some decorating your chest. Well you might as well proudly display your <b>Oni tattooed skin.</b>");
	player.skin.base.pattern = Skin.PATTERN_BATTLE_TATTOO;
	player.skin.base.adj = "battle tattooed";
	doNext(accessSkinPatternsMenu);
}
private function metamorphOniFace():void {
	clearOutput();
	player.soulforce -= 100;
	outputText("\n\nY");
	if (player.faceType != Face.HUMAN) outputText("our face suddenly mold back into it’s former human shape. However y");
	outputText("ou feel your canines changing, growing bigger and slightly sharper. Hey you could pretend to be some kind of demon with that kind of mouth. <b>You now have oni canines.</b>");
	player.faceType = Face.ONI_TEETH;
	doNext(accessPage3FaceMenu);
}
private function metamorphOniEars():void {
	clearOutput();
	player.soulforce -= 100;
	outputText("\n\nYour ears tingle slightly as their shape sharpen to a point not unlike those of some kind of demonic fiend. Still you know all too well those are <b>Oni ears.</b>");
	player.ears.type = Ears.ONI;
	doNext(accessPage2EarsMenu);
}
private function metamorphOniEyes():void {
	clearOutput();
	player.soulforce -= 100;
	player.eyes.type = Eyes.ONI;
	if (rand(2) == 0) player.eyes.colour = "red";
	else {
		if (rand(2) == 0) player.eyes.colour = "orange";
		else player.eyes.colour = "yellow";
	}
	outputText("\n\nYou feel something fundamental change in your sight when you go check yourself in a puddle you notice your iris now are <b>[eyecolor] just like that of an Oni with a slit at the center giving them a fiendish outlook.</b>");
	doNext(accessPage1EyesMenu);
}
private function metamorphOniDualHorns():void {
	clearOutput();
	player.soulforce -= 100;
	if (player.horns.type == Horns.NONE) outputText("You moan in pleasure as a pair of bony horns push forward out of your forehead,");
	else outputText("You begin to feel an odd itching sensation as you feel your horns repositioning,");
	outputText(" the things are actually surprisingly sensitive and you reach orgasm just from them reaching full size,");
	if (player.gender == 1 || player.gender == 3) outputText(" your [cock] splatering cum on the ground");
	if (player.gender == 3) outputText(" and");
	if (player.gender == 2 || player.gender == 3) outputText(" your pussy gushing with a copious amount of juice");
	outputText(". You would rather your opponent not know you have a G spot at the tip of your forehead and so you keep this information to yourself. <b>You now have a pair of horns just like an oni.</b>");
	player.horns.count = 1;
	player.horns.type = Horns.ONI_X2;
	doNext(accessPage1HornsMenu);
}
private function metamorphOniSingleHorn():void {
	clearOutput();
	player.soulforce -= 100;
	if (player.horns.type == Horns.NONE) outputText("You moan in pleasure as a single bony horns push forward out of your forehead,");
	else outputText("You begin to feel an odd itching sensation as you feel your horns repositioning and merging into one,");
	outputText(" the thing is actually surprisingly sensitive and you reach orgasm just from it reaching full size,");
	if (player.gender == 1 || player.gender == 3) outputText(" your [cock] splatering cum on the ground");
	if (player.gender == 3) outputText(" and");
	if (player.gender == 2 || player.gender == 3) outputText(" your pussy gushing with a copious amount of juice");
	outputText(". You would rather your opponent not know you have a G spot at the tip of your forehead and so you keep this information to yourself. <b>You now have a horns just like an oni.</b>");
	player.horns.count = 1;
	player.horns.type = Horns.ONI;
	doNext(accessPage1HornsMenu);
}
private function metamorphOniArms():void {
	clearOutput();
	player.soulforce -= 100;
	outputText("\n\n");
	if (player.arms.type != Arms.HUMAN) outputText("You watch, spellbound, while your arms gradually changing it entire outer structure into plain human-like form. ");
	outputText("The skin on your arms feels like it’s burning as a whole set of intricate warlike tattoos covers them. Furthermore your nails become increasingly pointed turning black just like a set of claws. Well it seems you will have issues hiding your <b>war tattooed arms with sharp nails.</b>");
	player.arms.type = Arms.ONI;
	doNext(accessPage2ArmsMenu);
}
private function metamorphOniLegs():void {
	clearOutput();
	player.soulforce -= 100;
	if (player.lowerBody != LowerBody.HUMAN) restoreHumanLegs();
	outputText("\n\nNot again! Now it's the skin on your legs that is burning as a whole set of intricate warlike tattoos covers them. Furthermore, your toenails become increasingly pointed turning black just like a set of claws. Well it seems you will have get used to your");
	outputText(" <b>war tattooed legs and feet topped with sharp nails.</b>");
	player.lowerBody = LowerBody.ONI;
	player.legCount = 2;
	doNext(accessPage3LegsMenu);
}
private function metamorphElfHair():void {
	clearOutput();
	player.soulforce -= 100;
	outputText("\n\nSomething changes in your scalp and you pass a hand through to know what is going on. To your surprise your hair texture turned silky, feeling as if you had been tending it for years, the touch is so agreeable you can’t help but idly stroke it with your hand. <b>Your hair has taken on an almost silk-like texture, just like that of an elf!</b>");
	player.hairType = Hair.SILKEN;
	doNext(accessHairMenu);
}
private function metamorphElfTongue():void {
	clearOutput();
	player.soulforce -= 100;
	if (player.tongue.type != Tongue.HUMAN) outputText("\n\nYou feel something strange inside your face as your tongue shrinks and recedes until it feels smooth and rounded.  <b>You realize your tongue has changed back into human tongue!</b>");
	outputText("\n\nYour throat starts to ache and your tongue tingles. You try to gasp for air, your eyes opening wide in surprise as the voice that exits your throat is entirely changed. Your words are notes, your sentence a melody. Your voice is like music to your ears and you realize it is because your body became closer to that of an elf, adapting even your tongue and voice.  <b>You now have the beautiful voice of the elves.</b>");
	player.tongue.type = Tongue.ELF;
	doNext(accessTongueMenu);
}
private function metamorphElfEyes():void {
	clearOutput();
	player.soulforce -= 100;
	if (player.eyes.type != Eyes.HUMAN) removeOddEyes();
	outputText("\n\nYou blink and stumble, a wave of vertigo threatening to pull your feet out from under you. As you steady yourself and open your eyes, you realize something seems different. Your vision is changed somehow. Your pupils draw in light and the color and shapes seems more defined even at great distance. Your new eyes granting you better vision. You go to a puddle to check what happened to them and notice <b>your new eyes are like those of an elf’s with a vertical slit that reflects lights.</b>");
	player.eyes.type = Eyes.ELF;
	doNext(accessPage1EyesMenu);
}
private function metamorphElfEars():void {
	clearOutput();
	player.soulforce -= 100;
	if (player.ears.type != Ears.HUMAN) restoreHumanEars();
	outputText("\n\nSounds become increasingly audible as a weird tingling runs through your scalp and your [hair] shifts slightly. You reach up to touch and bump <b>your new pointed elven ears.</b> The points are quite sensitive and you will have to get used to your new enhanced hearing ability.");
	player.ears.type = Ears.ELVEN;
	doNext(accessPage2EarsMenu);
}
private function metamorphElfArms():void {
	clearOutput();
	player.soulforce -= 100;
	if (player.arms.type != Arms.HUMAN) restoreHumanArms();
	outputText("\n\nSomething in your hands shift as they change taking on a more feminine fragile yet agile structure. You discover with surprise your dexterity has greatly increased allowing you to manipulate things in your delicate elven fingers with almost unreal precision. However your grip has become weaker as a result, weakening your ability to use raw force over finesse. <b>You now have delicate elven hands.</b>");
	player.arms.type = Arms.ELF;
	doNext(accessPage2ArmsMenu);
}
private function metamorphElfLegs():void {
	clearOutput();
	player.soulforce -= 100;
	if (player.lowerBody != LowerBody.HUMAN) restoreHumanLegs();
	outputText("\n\nSomething shifts in your legs as you feel almost supernatural agility imbue your steps granting a nymph like grace to your stride. Your feet are no longer rough but delicate and agile like those of an elf. <b>You now have agile elven feet.</b>");
	player.lowerBody = LowerBody.ELF;
	player.legCount = 2;
	doNext(accessPage3LegsMenu);
}
private function metamorphMantisWingsLarge():void {
	clearOutput();
	player.soulforce -= 200;
	outputText("\n\nYour wings tingle as they grow, filling out covering your back abdomen until they are large enough to lift you from the ground and allow you to fly!  You give a few experimental flaps and begin hovering in place, a giddy smile plastered on your face by the thrill of flight.  <b>You now have large Mantis wings!</b>");
	player.wings.type = Wings.MANTIS_LIKE_LARGE;
	player.wings.desc = "large mantis-like";
	doNext(accessPage2WingsMenu);
}
private function metamorphMantisWingsSmall():void {
	clearOutput();
	player.soulforce -= 100;
	if (player.wings.type != Wings.NONE) removeOldWings();
	outputText("\n\nYou feel an itching between your shoulder-blades as something begins growing there.  You twist and contort yourself, trying to scratch and bring yourself relief, and failing miserably.  A sense of relief erupts from you as you feel something new grow out from your body.");
	outputText("\nYou hastily remove the top portion of your [armor] and marvel as a pair of small Insectile wings sprout from your back.  Tenderly flexing your new muscles, you find you can flap them quite fast.  Unfortunately you can’t seem to flap your little wings fast enough to fly, but they would certainly slow a fall.  A few quick modifications to your [armor] later and you are ready to continue your journey with <b>your new mantis wings</b>.");
	player.wings.type = Wings.MANTIS_LIKE_SMALL;
	player.wings.desc = "small mantis-like";
	doNext(accessPage2WingsMenu);
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
private function metamorphMantisArms():void {
	clearOutput();
	player.soulforce -= 100;
	outputText("\n\nYou watch, spellbound, while your forearms gradually become shiny. The entire outer structure of your arms tingles while it divides into segments, turning the [skin.type] into a shiny green carapace.");
	outputText("\nA moment later the pain fades and you are able to turn your gaze down to your beautiful new arms, covered in shining green chitin from the upper arm down.");
	outputText("\nThe transformation end as down the lenght of your forearms you grow a pair of massive scythe like appendage just like a mantis.");
	outputText("\nYou nonchalantly run them across a young tree slicing the plant trunk in half. This might prove a deadly weapon if used as part of your unarmed strikes. <b>You now have mantis arms.</b>");
	player.arms.type = Arms.MANTIS;
	doNext(accessPage1ArmsMenu);
}
private function metamorphMantisLegs():void {
	clearOutput();
	player.soulforce -= 100;
	outputText("\n\nYour legs tremble with sudden unbearable pain, as if they’re being ripped apart from the inside out and being stitched together again all at once.");
	outputText("\nYou scream in agony as you hear bones snapping and cracking. A moment later the pain fades and you are able to turn your gaze down to your beautiful new legs, covered in shining green chitin from the thigh down. <b>You now have mantis feet.</b>");
	player.lowerBody = LowerBody.MANTIS;
	player.legCount = 2;
	doNext(accessPage2LegsMenu);
}
private function metamorphMantisAntennae():void {
	clearOutput();
	player.soulforce -= 100;
	if (player.antennae.type == Antennae.BEE) outputText("\n\nYour head itches momentarily as your two floppy antennae changes slowly into long prehensile ones similar to those seen at mantis.");
	else outputText("\n\nYour head itches momentarily as two long prehensile antennae sprout from your [hair].");
	player.antennae.type = Antennae.MANTIS;
	doNext(accessAntennaeMenu);
}
private function metamorphDevilEyes():void {
	clearOutput();
	player.soulforce -= 100;
	outputText("\n\nYour eyes feels like they are burning. You try to soothe them, but to no avail. You endure the agony for a few minutes before it finally fades. You look at yourself in the nearest reflective surface and notice your eyes have taken on a demonic appearance: the sclera is black and the pupils ember. Furthermore they seem to glow with a faint inner light. <b>You now have fiendish eyes!</b>");
	player.eyes.type = Eyes.DEVIL;
	player.eyes.colour = "ember";
	doNext(accessPage1EyesMenu);
}
private function metamorphDevilFangs():void {
	clearOutput();
	player.soulforce -= 100;
	outputText("\n\nYou feel your canines grow slightly longer to take on a sharp appearance like those of a beast. Perhaps not as long as you thought they would end up as but clearly they make your smile all the more fiendish. <b>You now have demonic fangs!</b>");
	player.faceType = Face.DEVIL_FANGS;
	doNext(accessPage3FaceMenu);
}
private function metamorphDevilArms():void {
	clearOutput();
	player.soulforce -= 100;
	outputText("\n\nYour hands shapeshift as they cover in fur and morph into the clawed hands of some unknown beast. They retain their dexterity despite their weird shape and paw pads. At least this won't hinder spellcasting. <b>You now have bestial clawed hands!</b>");
	player.arms.type = Arms.DEVIL;
	doNext(accessPage2ArmsMenu);
}
private function metamorphGoatEars():void {
	clearOutput();
	player.soulforce -= 100;
	outputText("\n\nYour ears elongate and flatten on your head. You flap them a little and discover they have turned into something similar to the ears of a goat. <b>You now have goat ears!</b>");
	player.ears.type = Ears.GOAT;
	doNext(accessPage2EarsMenu);
}
private function metamorphGoatHorns():void {
	clearOutput();
	player.soulforce -= 100;
	if (player.horns.type == Horns.NONE) outputText("You begin to feel a prickling sensation at the top of your head. Reaching up to inspect it, you find a pair of hard stubs. <b>You now have a pair of goat horns.</b>");
	else outputText("You begin to feel an odd itching sensation as you feel your horns repositioning. Once it's over, you reach up and find a pair of hard stubs. <b>You now have a pair of goat horns.</b>");
	player.horns.count = 1;
	player.horns.type = Horns.GOAT;
	doNext(accessPage1HornsMenu);
}
private function metamorphGoatTail():void {
	clearOutput();
	player.soulforce -= 100;
	outputText("You feel an odd itchy sensation just above your [ass]. Twisting around to inspect it you find a short stubby tail that wags when you're happy. <b>You now have a goat tail.</b>");
	player.tailType = Tail.GOAT;
	doNext(accessPage3TailMenu);
}
private function metamorphClovenHoofedLegs():void {
	clearOutput();
	player.soulforce -= 100;
	outputText("\n\nYou feel an odd sensation in your lower region. Your [feet] shift and you hear bones cracking as they reform. Fur grows on your legs and soon you're looking at a <b>new pair of goat legs</b>.");
	player.lowerBody = LowerBody.CLOVEN_HOOFED;
	player.legCount = 2;
	doNext(accessPage2LegsMenu);
}
private function metamorphCowMinotaurHorns():void {
	clearOutput();
	player.soulforce -= 100;
	if (player.horns.type == Horns.COW_MINOTAUR || player.horns.type == Horns.NONE) {
		if (player.horns.type == Horns.COW_MINOTAUR) {
			if (player.horns.count < 5) {
				outputText("\n\nYour small horns get a bit bigger, stopping as medium sized nubs.");
				player.horns.count += 1 + rand(2);
			}
		}
		if (player.horns.type == Horns.NONE || player.horns.count == 0) {
			outputText("\n\nWith painful pressure, the skin on your forehead splits around two tiny nub-like horns, similar to those you would see on the cattle back in your homeland.");
			player.horns.count = 1;
			player.horns.type = Horns.COW_MINOTAUR;
		}
		if (player.horns.type != Horns.NONE && player.horns.type != Horns.COW_MINOTAUR && player.horns.type != Horns.ORCHID && player.horns.count > 0) {
			outputText("\n\nYour horns twist, filling your skull with agonizing pain for a moment as they transform into cow-horns.");
			player.horns.type = Horns.COW_MINOTAUR;
		}
	}
	if ((player.horns.type == Horns.DEMON || player.horns.type > Horns.COW_MINOTAUR) && player.horns.type != Horns.ORCHID) {
		outputText("\n\nYour horns vibrate and shift as if made of clay, reforming into two small bovine nubs.");
		player.horns.count = 2;
		player.horns.type = Horns.COW_MINOTAUR;
	}
	doNext(accessPage1HornsMenu);
}
private function metamorphCowMinotaurFace():void {
	clearOutput();
	player.soulforce -= 100;
	outputText("\n\nYour visage twists painfully, warping and crackling as your bones are molded into a new shape.  Once it finishes, you reach up to touch it, and you discover that <b>your face is like that of a cow!</b>");
	player.faceType = Face.COW_MINOTAUR;
	doNext(accessPage1FaceMenu);
}
private function metamorphCowEars():void {
	clearOutput();
	player.soulforce -= 100;
	outputText("\n\nYou feel your ears tug on your scalp as they twist shape, becoming oblong and cow-like.  <b>You now have cow ears.</b>");
	player.ears.type = Ears.COW;
	doNext(accessPage1EarsMenu);
}
private function metamorphCowTail():void {
	clearOutput();
	player.soulforce -= 100;
	if (player.tailType == Tail.NONE) outputText("\n\nYou feel the flesh above your " + buttDescript() + " knotting and growing.  It twists and writhes around itself before flopping straight down, now shaped into a distinctly bovine form.  You have a <b>cow tail</b>.");
	else {
		if (player.tailType < Tail.SPIDER_ADBOMEN || player.tailType > Tail.BEE_ABDOMEN) {
			outputText("\n\nYour tail bunches uncomfortably, twisting and writhing around itself before flopping straight down, now shaped into a distinctly bovine form.  You have a <b>cow tail</b>.");
		}
		//insect
		if (player.tailType == Tail.SPIDER_ADBOMEN || player.tailType == Tail.BEE_ABDOMEN || player.tailType == Tail.SCORPION || player.tailType == Tail.MANTIS_ABDOMEN) {
			outputText("\n\nYour insect-like abdomen tingles pleasantly as it begins shrinking and softening, chitin morphing and reshaping until it looks exactly like a <b>cow tail</b>.");
		}
	}
	player.tailType = Tail.COW;
	doNext(accessPage1TailMenu);
}
private function metamorphHoofedLegs():void {
	clearOutput();
	player.soulforce -= 100;
	if (player.lowerBody == LowerBody.HUMAN) outputText("\n\nYou stagger as your feet change, curling up into painful angry lumps of flesh.  They get tighter and tighter, harder and harder, until at last they solidify into hooves!");
	if (player.lowerBody == LowerBody.DOG) outputText("\n\nYou stagger as your paws change, curling up into painful angry lumps of flesh.  They get tighter and tighter, harder and harder, until at last they solidify into hooves!");
	if (player.lowerBody == LowerBody.NAGA) outputText("\n\nYou collapse as your sinuous snake-tail tears in half, shifting into legs.  The pain is immense, particularly in your new feet as they curl inward and transform into hooves!");
	if (player.lowerBody > LowerBody.NAGA) outputText("\n\nYou stagger as your [feet] change, curling up into painful angry lumps of flesh.  They get tighter and tighter, harder and harder, until at last they solidify into hooves!");
	outputText("  A coat of beastial fur springs up below your waist, itching as it fills in.<b>  You now have hooves in place of your feet!</b>");
	player.lowerBody = LowerBody.HOOFED;
	player.legCount = 2;
	doNext(accessPage1LegsMenu);
}
private function metamorphDragonTail():void {
	clearOutput();
	player.soulforce -= 100;
	if (player.tailType == Tail.NONE) outputText("\n\nA sudden dull, throbbing pain in your " + buttDescript() + " forces your hands to it; you can feel an ominous lump over your tail bone, swelling bigger and bigger with every heartbeat.  All of a sudden, it seems to explode, jutting out and around until it hovers near your ankles, the skin under your flesh hard and scaly.  <b>You now have a dragon tail flicking at your back, flexible as a whip.</b>");
	else outputText("\n\nAn icy sensation fills your behind as your tail suddenly goes curiously numb.  Twisting your head around, you watch as it melts and transforms into a reptilian appendage, long and flexible, its tip adorned with wicked spikes.  <b>You now have a dragon tail.</b>");
	player.tailType = Tail.DRACONIC;
	doNext(accessPage2TailMenu);
}
private function metamorphDragonArms():void {
	clearOutput();
	player.soulforce -= 100;
	outputText("\n\nYou scratch at your biceps absentmindedly, but no matter how much you scratch, it isn't getting rid of the itch.  After longer moment of ignoring it you finaly glancing down in irritation, only to discover that your arms former appearance changed into this of dragon one with leathery scales and short claws replacing your fingernails.  <b>You now have a dragon arms.</b>");
	player.arms.type = Arms.DRAGON;
	doNext(accessPage2ArmsMenu);
}
private function metamorphDragonLegs():void {
	clearOutput();
	player.soulforce -= 100;
	if (player.lowerBody == LowerBody.DRIDER) outputText("\n\nA disquieting feeling ripples through your arachnid abdomen, and you find yourself losing control of your body from the waist down.  Your spidery legs flail madly as your abdomen visibly swells, chitin cracking ominously as the pressure builds up inside of you... and then explodes!  You wipe the gore from your face in disgust, wondering why you feel no pain.  Rolling over, you see that, caked with spider-slime, you now have a new pair of legs, human-like save for the scales and the bestial paws that serve as feet.  <b>You now have dragon feet.</b>");
	else if (player.isNaga()) outputText("\n\nYou fall on your face to the ground, hissing and screeching in pain - it feels like someone has grabbed the tip of your tail, pulled it viciously straight, and is now splitting it up the middle with a knife!  Paralyzed from the waist down, you claw desperately at the earth to try and alleviate the pain, and can only think to thank your lucky stars when it fades away.  Looking down where your tail was, though the scales remain, you realize you've become a biped again, your new feet sporting bestial claws on their toes.  <b>You now have dragon feet.</b>");
	else if (player.isGoo()) outputText("\n\nA strange tingling sensation fills you, and you watch as your gooey blob of a body begins to ripple and shudder; you try to make it stop, but you can't control it.  Before your eyes, it shapes itself into the appearance of legs, the colored slime growing denser and thicker, the surface membrane texturing itself to look like scales.  Before you've quite realized what's happened, the slime has set like water freezing, leaving you with humanoid legs once again, though tipped with claws and very reptilian in appearance.  <b>You now have dragon feet.</b>");
	else if (player.lowerBody == LowerBody.HOOFED) outputText("\n\nYou bellow in pain as your legs break and reform and your hooves seem to suddenly explode, the bones within twisting themselves into monstrous three-toed appendages, more like those of some terrible lizard-thing than anything else. <b>You now have dragon feet.</b>");
	else if (player.isTaur()) outputText("\n\nYou cry out as spasms of pain suddenly rip through your quadrupedal body, bringing you crashing onto the ground.  Words cannot define the agony as muscles and bones twist and shift and collapse violently.  When it's all over, you stagger upright, finding yourself standing on two legs again.  Though covered in scales and with the paws of some monster lizard instead of feet, they otherwise look like your old human legs.  <b>You now have dragon feet.</b>");
	else if (player.isScylla()) {
		outputText("\n\nSomething weird happens in your tentacles as your limbs coil into two pillars of flesh and fuse together, your ");
		if (player.gender == 1) outputText("[vagina]");
		if (player.gender == 3) outputText(" and ");
		if (player.cocks.length > 0) outputText("[cock]");
		outputText(" moving back up between your leg to where it used to be. Bones starts to form in your limb and, before you know it, you are staring at a pair of normal human legs. The changes does not end there however.  When the pain is over, you realize that you still stand atop human-looking legs, but your feet have become like those of some bipedal reptilian killer, with powerful claws meant for gripping the ground. <b>You now have dragon feet.</b>\n\n");
	}
	else if (player.isAlraune()) outputText("\n\nYour petals all withers and fall off as your pitch and flower turn to dust leaving you with normal human legs. The changes does not stop there however.  When the pain is over, you realize that you still stand atop human-looking legs, but your feet have become like those of some bipedal reptilian killer, with powerful claws meant for gripping the ground. <b>You now have dragon feet.</b>");
	else outputText("\n\nYou scream in agony as you feel the bones in your feet suddenly break and restructure themselves, toes fusing together, bone swelling out of the merged masses of flesh.  When the pain is over, you realize that you still stand atop human-looking legs, but your feet have become like those of some bipedal reptilian killer, with powerful claws meant for gripping the ground. <b>You now have dragon feet.</b>");
	player.lowerBody = LowerBody.DRAGON;
	player.legCount = 2;
	doNext(accessPage2LegsMenu);
}
private function metamorphDragonFangs():void {
	clearOutput();
	player.soulforce -= 100;
	outputText("\n\nSudden agony sweeps over your [face], your visage turning hideous as bones twist and your jawline shifts. The pain slowly vanishes, leaving you weeping into your fingers. When you pull your hands away you realize you've been left with a completely normal, human face. But then your tooth's suddenly hurt as they begin to change. Your canines getting sharper and more adapted to eating meat just like those of a dragon. <b>You now have dragon fangs.</b>");
	player.faceType = Face.DRAGON_FANGS;
	doNext(accessPage3FaceMenu);
}
private function metamorphDragonFace():void {
	clearOutput();
	player.soulforce -= 100;
	outputText("\n\nYou scream as your face is suddenly twisted; your facial bones begin rearranging themselves under your skin, restructuring into a long, narrow muzzle.  Spikes of agony rip through your jaws as your teeth are brutally forced from your gums, giving you new rows of fangs - long, narrow and sharp.  Your jawline begins to sprout strange growths; small spikes grow along the underside of your muzzle, giving you an increasingly inhuman visage.\n\nFinally, the pain dies down, and you look for a convenient puddle to examine your changed appearance.\n\nYour head has turned into a reptilian muzzle, with small barbs on the underside of the jaw.  <b>You now have a dragon's face.</b>");
	player.faceType = Face.DRAGON;
	doNext(accessPage1FaceMenu);
}
private function metamorphDragonTonuge():void {
	clearOutput();
	player.soulforce -= 100;
	outputText("\n\nYour tongue suddenly falls out of your mouth and begins undulating as it grows longer.  For a moment it swings wildly, completely out of control; but then settles down and you find you can control it at will, almost like a limb.  You're able to stretch it to nearly 4 feet and retract it back into your mouth to the point it looks like a normal human tongue.  <b>You now have a draconic tongue.</b>");
	player.tongue.type = Tongue.DRACONIC;
	doNext(accessTongueMenu);
}
private function metamorphDragonEyes():void {
	clearOutput();
	player.soulforce -= 100;
	outputText("\n\nYou suddenly feel your vision shifting. It takes a moment for you to adapt to the weird sensory changes but once you recover you go to a puddle and notice your eyes now have a slitted pupil like that of a dragon.  <b>You now have dragon eyes!</b>.");
	player.eyes.type = Eyes.DRAGON;
	doNext(accessPage1EyesMenu);
}
private function metamorphDragonWingsHuge():void {
	clearOutput();
	player.soulforce -= 300;
	outputText("\n\nA not-unpleasant tingling sensation again fills your wings, almost but not quite drowning out the odd, tickly feeling as they swell larger and stronger than before.  You spread them wide - they stretch now more than twice further than your arms do - and beat them experimentally, the powerful thrusts sending gusts of wind, and lifting you off your feet effortlesly.  <b>You now have fully-grown majestic dragon wings, capable of winging you through the air elegantly!</b>");
	player.wings.type = Wings.DRACONIC_HUGE;
	player.wings.desc = "large, majestic draconic";
	doNext(accessPage1WingsMenu);
}
private function metamorphDragonWingsLarge():void {
	clearOutput();
	player.soulforce -= 200;
	outputText("\n\nA not-unpleasant tingling sensation fills your wings, almost but not quite drowning out the odd, tickly feeling as they swell larger and stronger.  You spread them wide - they stretch further than your arms do - and beat them experimentally, the powerful thrusts sending gusts of wind, and almost lifting you off your feet.  <b>You now have fully-grown dragon wings, capable of winging you through the air elegantly!</b>");
	player.wings.type = Wings.DRACONIC_LARGE;
	player.wings.desc = "large, draconic";
	doNext(accessPage1WingsMenu);
}
private function metamorphDragonWingsSmall():void {
	clearOutput();
	player.soulforce -= 100;
	if (player.wings.type == Wings.NONE) outputText("\n\nYou double over as waves of pain suddenly fill your shoulderblades; your back feels like it's swelling, flesh and muscles ballooning.  A sudden sound of tearing brings with it relief and you straighten up.  Upon your back now sit small, leathery wings, not unlike a bat's. <b>You now have small dragon wings.  They're not big enough to fly with, but they look adorable.</b>");
	else outputText("\n\nA sensation of numbness suddenly fills your wings.  When it dies away, they feel... different.  Looking back, you realize that they have been replaced by new, small wings, ones that you can only describe as draconic.  <b>Your wings have changed into dragon wings.</b>");
	player.wings.type = Wings.DRACONIC_SMALL;
	player.wings.desc = "small, draconic";
	doNext(accessPage1WingsMenu);
}
private function metamorphDragonEars():void {
	clearOutput();
	player.soulforce -= 100;
	outputText("\n\nA prickling sensation suddenly fills your ears; unpleasant, but hardly painful.  It grows and grows until you can't stand it any more, and reach up to scratch at them.  To your surprise, you find them melting away like overheated candles.  You panic as they fade into nothingness, leaving you momentarily deaf and dazed, stumbling around in confusion.  Then, all of a sudden, hearing returns to you.  Gratefully investigating, you find you now have a pair of reptilian ear-holes, one on either side of your head.  A sudden pain strikes your temples, and you feel bony spikes bursting through the sides of your head, three on either side, which are quickly sheathed in folds of skin to resemble fins.  With a little patience, you begin to adjust these fins just like ears to aid your hearing.  <b>You now have dragon ears!</b>");
	player.ears.type = Ears.DRAGON;
	doNext(accessPage1EarsMenu);
}
private function metamorphGorgonEyes():void {
	clearOutput();
	player.soulforce -= 100;
	outputText("\n\nYou blink and stumble, a wave of vertigo threatening to pull your [feet] from under you.  As you steady and open your eyes, all seems to be fine until at least it seems so. But when moment later, when you casualy look at your hands pondering if there is any other effect the numbing sensation starts to spread starting from your hands fingers. Worried you focus your gaze at them to notice, that they typical texture becoming grey colored much similar to that of... stone? And slowy you realize the more you look at them, the faster change. Panicked for a moment you look away and then this numbing feeling starting to slowly receed. But looking back at them causing it to return. After moment, and closing eyelids, you conclude that your eyes must have gained an useful ability.  <b>Your eyes has turned into gorgon eyes.</b>");
	player.eyes.type = Eyes.GORGON;
	doNext(accessPage1EyesMenu);
}
private function metamorphGorgonHair():void {
	clearOutput();
	player.soulforce -= 100;
	if (player.hairLength == 0) outputText("\n\nAt first nothing happening. Then you start to feel tingling at your head scalp.  You run your fingers over head you feel small numbs fast growning up forming something akin to dull spikes.  After brief pause those nubs starts to slowly grown and covered gradualy with....sclaes?");
	else {
		outputText("\n\nYou run your fingers through your [hair] while you await the effects of the item you just ingested.  While your hand is up there, it detects a change in the texture of your hair.  They're completely changing becoming more thick and slowly covered with delicate....scales?");
		if (player.hairLength < 6) outputText("  Additionaly they seems to lenghten.");
	}
	outputText(" What even more worrisome seems at the ends of each strands form something that is similar to very small snake head.  Taking one of your hair 'strands' confirm your suspicions.  Your hair turned into bunch of tiny snakes similary to those possesed normaly by gorgons.  <b>Your hair turned into thin snakes replacing your current hair!</b>");
	if (player.hairLength < 6) player.hairLength = 6;
	player.hairType = Hair.GORGON;
	doNext(accessHairMenu);
}
private function metamorphSnakeEars():void {
	clearOutput();
	player.soulforce -= 100;
	outputText("\n\nA weird tingling runs through your scalp as your [hair] shifts slightly.  You reach up to touch and bump <b>your new pointed ears covered in small scales</b>.  You bet they look cute!");
	player.ears.type = Ears.SNAKE;
	doNext(accessPage2EarsMenu);
}
private function metamorphSnakeEyes():void {
	clearOutput();
	player.soulforce -= 100;
	outputText("\n\nYou suddenly feel your vision shifting. It takes a moment for you to adapt to the weird sensory changes but once you recover you go to a puddle and notice your eyes now have a slitted pupil like that of a snake.  <b>You now have snake eyes!</b>.");
	player.eyes.type = Eyes.SNAKE;
	doNext(accessPage1EyesMenu);
}
private function metamorphSnakeLowerBody():void {
	clearOutput();
	player.soulforce -= 100;
	if (player.lowerBody == LowerBody.SCYLLA) outputText("\n\nYou collapse as your tentacle legs starts to merge and the pain is immense.  Sometime later you feel the pain begin to ease and you lay on the ground, spent by the terrible experience. Once you feel you've recovered, you try to stand, but to your amazement you discover that you no longer have [legs]: the bottom half of your body is like that of a snake's.");
	else {
		outputText("\n\nYou find it increasingly harder to keep standing as your legs start feeling weak.  You swiftly collapse, unable to maintain your own weight.");
		outputText("\n\nTrying to get back up, you realize that the skin on the inner sides of your thighs is merging together like it was being sewn by an invisible needle.");
		outputText("  The process continues through the length of your [legs], eventually reaching your [feet].  Just when you think that the transformation is over, you find yourself pinned to the ground by an overwhelming sensation of pain. You hear the horrible sound of your bones snapping, fusing together and changing into something else while you contort in unthinkable agony.  Sometime later you feel the pain begin to ease and you lay on the ground, spent by the terrible experience. Once you feel you've recovered, you try to stand, but to your amazement you discover that you no longer have [legs]: the bottom half of your body is like that of a snake's.");
	}
	outputText("\n\nWondering what happened to your sex, you pass your hand down the front of your body until you find a large, horizontal slit around your pelvic area, which contains all of your sexual organs.");
	if (player.balls > 0 && player.ballSize > 10) outputText("  You're happy not to have to drag those testicles around with you anymore.");
	outputText("  But then, scales start to form on the surface of your skin, slowly becoming visible, recoloring all of your body from the waist down in a snake-like pattern. The feeling is... not that bad actually, kind of like callous, except on your whole lower body. The transformation complete, you get up, standing on your newly formed snake tail. You can't help feeling proud of this majestic new body of yours.");
	player.lowerBody = LowerBody.NAGA;
	player.legCount = 1;
	doNext(accessPage1LegsMenu);
}
private function metamorphSnakeFangs():void {
	clearOutput();
	player.soulforce -= 100;
	outputText("\n\nWithout warning, you feel your canine teeth jump almost an inch in size, clashing on your gums, cutting yourself quite badly. As you attempt to find a new way to close your mouth without dislocating your jaw, you notice that they are dripping with a bitter, khaki liquid.  Watch out, and <b>try not to bite your tongue with your poisonous fangs!</b>");
	if (player.faceType != Face.HUMAN && player.faceType != Face.SHARK_TEETH && player.faceType != Face.BUNNY && player.faceType != Face.SPIDER_FANGS) outputText("  As the change progresses, your [face] reshapes.  The sensation is far more pleasant than teeth cutting into gums, and as the tingling transformation completes, <b>you've gained with a normal-looking, human visage.</b>");
	player.faceType = Face.SNAKE_FANGS;
	doNext(accessPage1FaceMenu);
}
private function metamorphSnakeTongue():void {
	clearOutput();
	player.soulforce -= 100;
	if (player.tongue.type == Tongue.HUMAN) outputText("\n\nYour taste-buds start aching as they swell to an uncomfortably large size. Trying to understand what in the world could have provoked such a reaction, you bring your hands up to your mouth, your tongue feeling like it's trying to push its way past your lips. The soreness stops and you stick out your tongue to try and see what would have made it feel the way it did. As soon as you stick your tongue out you realize that it sticks out much further than it did before, and now appears to have split at the end, creating a forked tip. The scents in the air are much more noticeable to you with your snake-like tongue.");
	else outputText("\n\nYour inhuman tongue shortens, pulling tight in the very back of your throat.  After a moment the bunched-up tongue-flesh begins to flatten out, then extend forwards.  By the time the transformation has finished, your tongue has changed into a long, forked snake-tongue.");
	player.tongue.type = Tongue.SNAKE;
	doNext(accessTongueMenu);
}
private function metamorphOrcaBlowhole():void {
	clearOutput();
	player.soulforce -= 100;
	outputText("\n\n");
	if (player.rearBody.type > RearBody.NONE) outputText("Your wings fold into themselves, merging together with your back.  ");
	outputText("Pain rushes just behind your shoulder blades as a hole opens up, air rushing in. The hole is burning making you groan in pain as air flows in and out. Eventually you get accustomed to breathing from your back like whales do, but it sure was a weird experience.");
	if (silly()) outputText("  Well it doesn't matter because now you can break the world record of the longest breath holding by sitting on the ocean floor for more than 90 minutes.");
	player.rearBody.type = RearBody.ORCA_BLOWHOLE;
	doNext(accessRearBodyMenu);
}
private function metamorphOrcaFace():void {
	clearOutput();
	player.soulforce -= 100;
	outputText("\n\nYour nose starts to tingle, getting bigger and rounder as your facial features take on a bombed shape. Your nasal hole disappears entirely as you feel your mouth change, your dentition turning into pointed teeth fit for an orca. You go look at your reflection in the water to be sure, and discover your face is now similar in shape to that of a killer whale. Um… you could use a fish or two, you are getting pretty hungry. <b>Taking a bite out of fresh fish would be great with your new orca face.</b>");
	player.faceType = Face.ORCA;
	doNext(accessPage3FaceMenu);
}
private function metamorphOrcaEars():void {
	clearOutput();
	player.soulforce -= 100;
	outputText("\n\nYour ears suddenly begin to lengthen, growing bigger and bigger until their length reaches your shoulders. When you examine them you discover they have grown into a pair of large fins, easily twice as big as your head. <b>Orienting yourself underwater will be easy with your large orca fin ears.</b>");
	player.ears.type = Ears.ORCA;
	doNext(accessPage2EarsMenu);
}
private function metamorphOrcaTail():void {
	clearOutput();
	player.soulforce -= 100;
	outputText("\n\nA large bump starts to grow out of your " + assDescript() + ", making you groan as your spine lengthens for this whole new appendage to form. You finally grow a tail black as midnight with a white underside and a smaller fin closer to your body, likely for hydrodynamism sake. You swing your tail a few times, battering the ground with it and smile as you rush to the stream to take a dip. ");
	outputText("With the help of your mighty tail you easily reach such a high swim speed you even manage to jump several meters out of the water, laughing with delight at the trill of this aquatic experience. <b>You're going to have a lot of fun swimming with your new Orca tail.</b>");
	player.tailType = Tail.ORCA;
	doNext(accessPage4TailMenu);
}
private function metamorphOrcaArms():void {
	clearOutput();
	player.soulforce -= 100;
	outputText("\n\nYour fingers suddenly are forced together. When you stretch them back you discover they are now webbed, ready for swimming. You are still examining your hands when something not unlike a pair of fins grow out of your forearms. <b>You can only guess those Orca arms will help you to swim at high speeds!</b>");
	player.arms.type = Arms.ORCA;
	doNext(accessPage2ArmsMenu);
}
private function metamorphOrcaLegs():void {
	clearOutput();
	player.soulforce -= 100;
	if (player.lowerBody != LowerBody.HUMAN) restoreHumanLegs();
	outputText("\n\nYour toes suddenly are forced together. When you stretch them back you discover they are now webbed, ready for swimming. <b>You can only guess those Orca legs will help you to swim at great speed.</b>");
	player.lowerBody = LowerBody.ORCA;
	doNext(accessPage3LegsMenu);
}
private function metamorphPhoenixWings():void {
	clearOutput();
	player.soulforce -= 100;
	outputText("\n\nPain lances through your back, the muscles knotting oddly and pressing up to bulge your [skin.type]. It hurts, oh gods does it hurt, but you can't get a good angle to feel at the source of your agony. A loud crack splits the air, and then your body is forcing a pair of narrow limbs through a gap in your [armor]. Blood pumps through the new appendages, easing the pain as they fill out and grow. Tentatively, you find yourself flexing muscles you didn't know you had, and <b>you're able to curve the new growths far enough around to behold your brand new, crimson wings.</b>");
	player.wings.type = Wings.FEATHERED_PHOENIX;
	player.wings.desc = "large crimson feathered";
	doNext(accessPage2WingsMenu);
}
private function metamorphPhoenixArms():void {
	clearOutput();
	player.soulforce -= 100;
	outputText("\n\nA crimson colored avian plumage starts to sprouts from your [skin.type], covering your forearms until <b>your arms look vaguely like wings</b>. Your hands remain unchanged thankfully. It'd be impossible to be a champion without hands! The feathery limbs might help you maneuver if you were to fly, but there's no way they'd support you alone.");
	player.arms.type = Arms.PHOENIX;
	doNext(accessPage1ArmsMenu);
}
private function metamorphSalamanderFace():void {
	clearOutput();
	player.soulforce -= 100;
	outputText("\n\nYour tooth's suddenly hurt as you feel them changing. Your canines getting sharper and more adapted to eating meat.  <b>You now have fangs.</b>");
	player.faceType = Face.SALAMANDER_FANGS;
	doNext(accessPage2FaceMenu);
}
private function metamorphSalamanderArms():void {
	clearOutput();
	player.soulforce -= 100;
	outputText("\n\nYou scratch at your biceps absentmindedly, but no matter how much you scratch, it isn't getting rid of the itch.  After longer moment of ignoring it you finaly glancing down in irritation, only to discover that your arms former appearance changed into this of salamander one with leathery, red scales and short claws replacing your fingernails.  <b>You now have a salamander arms.</b>");
	player.arms.type = Arms.SALAMANDER;
	doNext(accessPage1ArmsMenu);
}
private function metamorphSalamanderLegs():void {
	clearOutput();
	player.soulforce -= 100;
	if (player.lowerBody == LowerBody.HOOFED) outputText("\n\nYou scream in agony as you feel your hooves crack and break apart, beginning to rearrange.  Your legs change to a digitigrade shape while your feet grow claws and shift to have three toes on the front and a smaller toe on the heel.");
	else if (player.isTaur()) outputText("\n\nYour lower body is wracked by pain!  Once it passes, you discover that you're standing on digitigrade legs with salamander-like claws.");
	else if (player.lowerBody == LowerBody.HUMAN || player.lowerBody == LowerBody.DOG || player.lowerBody == LowerBody.DEMONIC_HIGH_HEELS || player.lowerBody == LowerBody.DEMONIC_CLAWS || player.lowerBody == LowerBody.DEMONIC_CLAWS || player.lowerBody == LowerBody.PLANT_HIGH_HEELS || player.lowerBody == LowerBody.BEE || player.lowerBody == LowerBody.CAT || player.lowerBody == LowerBody.LIZARD) outputText("\n\nYou scream in agony as you feel the bones in your legs break and begin to rearrange. They change to a digitigrade shape while your feet grow claws and shift to have three toes on the front and a smaller toe on the heel.");
	else outputText("\n\nPain rips through your [legs], morphing and twisting them until the bones rearrange into a digitigrade configuration.  The strange legs have three-toed, clawed feet, complete with a small vestigial claw-toe on the back for added grip.");
	outputText("  <b>You have salamander legs and claws!</b>");
	player.lowerBody = LowerBody.SALAMANDER;
	player.legCount = 2;
	doNext(accessPage2LegsMenu);
}
private function metamorphSalamanderTail():void {
	clearOutput();
	player.soulforce -= 100;
	if (player.tailType == Tail.NONE) outputText("\n\nYou drop onto the ground as your spine twists and grows, forcing the flesh above your " + assDescript() + " to bulge out.  New bones form, one after another, building a tapered, prehensile tail onto the back of your body.  For a brief moment it tip ignite with a red-colored flame that with as little as your merely thought vanish moment later.  Still you somehow know you can set ablaze any part or whole your tail at any moment and even use it to burn enemies after lashing them with your tail.  <b>You now have a salamander tail!</b>");
	else outputText("\n\nYou drop to the ground as your tail twists and grows, changing its shape in order to gradually taper to a point.  It flicks back and forth, prehensile and totally under your control.  For a brief moment it tip ignite with a red-colored flame that with as little as your merely thought vanish moment later.  Still you somehow know you can set ablaze any part or whole your tail at any moment and even use it to burn enemies after lashing them with your tail.  <b>You now have a salamander tail.</b>");
	player.tailType = Tail.SALAMANDER;
	doNext(accessPage3TailMenu);
}
private function metamorphSharkFin():void {
	clearOutput();
	player.soulforce -= 100;
	outputText("\n\nYou groan and slump down in pain, almost instantly regretting eating the tooth. You start sweating profusely and panting loudly, feeling the space between your shoulder blades shifting about. You hastily remove your [armor] just in time before a strange fin-like structure bursts from in-between your shoulders. You examine it carefully and make a few modifications to your [armor] to accommodate your new fin.");
	player.rearBody.type = RearBody.SHARK_FIN;
	doNext(accessRearBodyMenu);
}
private function metamorphSharkArms():void {
	clearOutput();
	player.soulforce -= 100;
	outputText("\n\nYou watch, spellbound, while your arms gradually changing it entire outer structure into plain human-like form with exception places between your finger which starting show signs to growing webbing. Soon after you start sweating profusely and panting loudly, feeling the space near your elbows shifting about. You hastily remove your [armor] just in time before a strange fin-like structure bursts from your forearms. You examine them carefully and make a few modifications to your [armor] to accommodate your new fins. <b>You now have shark arms.</b>");
	player.arms.type = Arms.SHARK;
	doNext(accessPage1ArmsMenu);
}
private function metamorphSharkLegs():void {
	clearOutput();
	player.soulforce -= 100;
	if (player.lowerBody != LowerBody.HUMAN) restoreHumanLegs();
	outputText("\n\nYou feel something change in your feets as webing form between your toes. Well this is sure to help you swim faster. <b>You now have webed feet!</b>");
	player.lowerBody = LowerBody.SHARK;
	doNext(accessPage2LegsMenu);
}
private function metamorphSharkTail():void {
	clearOutput();
	player.soulforce -= 100;
	if (player.tailType == Tail.NONE) outputText("\n\nJets of pain shoot down your spine, causing you to gasp in surprise and fall to your hands and knees. Feeling a bulging at the end of your back, you lower your [armor] down just in time for a fully formed shark tail to burst through. You swish it around a few times, surprised by how flexible it is. After some modifications to your clothing, you're ready to go with your brand new shark tail.");
	else outputText("\n\nJets of pain shoot down your spine into your tail.  You feel the tail bulging out until it explodes into a large and flexible shark-tail.  You swish it about experimentally, and find it quite easy to control.");
	player.tailType = Tail.SHARK;
	doNext(accessPage1TailMenu);
}
private function metamorphSharkTeeth():void {
	clearOutput();
	player.soulforce -= 100;
	outputText("\n\n");
	if (player.faceType > Face.HUMAN && player.faceType != Face.SHARK_TEETH) outputText("Your [face] explodes with agony, reshaping into a more human-like visage.  ");
	outputText("You firmly grasp your mouth, an intense pain racking your oral cavity. Your gums shift around and the bones in your jaw reset. You blink a few times wondering what just happened. You move over to a puddle to catch sight of your reflection, and you are thoroughly surprised by what you see. A set of retractable shark fangs have grown in front of your normal teeth, and your face has elongated slightly to accommodate them!  They even scare you a little.\n(Gain: 'Bite' special attack)");
	player.faceType = Face.SHARK_TEETH;
	doNext(accessPage1FaceMenu);
}
private function metamorphDriderLegs():void {
	clearOutput();
	player.soulforce -= 300;
	outputText("\n\nJust like when your legs changed to those of a spider-morph, you find yourself suddenly paralyzed below the waist.  Your dark, reflective legs splay out and drop you flat on your back.   Before you can sit up, you feel tiny feelers of pain mixed with warmth and tingling running through them.  Terrified at the thought of all the horrible changes that could be wracking your body, you slowly sit up, expecting to find yourself turned into some incomprehensible monstrosity from the waist down.  As if to confirm your suspicions, the first thing you see is that your legs have transformed into eight long, spindly legs.  Instead of joining directly with your hips, they now connect with the spider-like body that has sprouted in place of where your legs would normally start.  Your abdomen has gotten even larger as well.  ");
	outputText("Once the strength returns to your new, eight-legged lower body, you struggle up onto your pointed 'feet', and wobble around, trying to get your balance.  As you experiment with your new form, you find you're even able to twist the spider half of your body down between your legs in an emulation of your old, bipedal stance.  That might prove useful should you ever want to engage in 'normal' sexual positions, particularly since your " + buttDescript() + " is still positioned just above the start of your arachnid half.  <b>You're now a drider.</b>");
	player.lowerBody = LowerBody.DRIDER;
	player.legCount = 8;
	doNext(accessPage2LegsMenu);
}
private function metamorphSpiderTail():void {
	clearOutput();
	player.soulforce -= 100;
	outputText("\n\n");
	if (player.tailType > Tail.NONE) outputText("Your tail shudders as heat races through it, twitching violently until it feels almost as if it's on fire.  You jump from the pain at your " + buttDescript() + " and grab at it with your hands.  It's huge... and you can feel it hardening under your touches, firming up until the whole tail has become rock-hard and spherical in shape.  The heat fades, leaving behind a gentle warmth, and you realize your tail has become a spider's abdomen!  With one experimental clench, you even discover that it can shoot webs from some of its spinnerets, both sticky and non-adhesive ones.  That may prove useful.  <b>You now have a spider's abdomen hanging from above your " + buttDescript() + "!</b>\n\n");
	else outputText("A burst of pain hits you just above your " + buttDescript() + ", coupled with a sensation of burning heat and pressure.  You can feel your " + player.skinFurScales() + " tearing as something forces its way out of your body.  Reaching back, you grab at it with your hands.  It's huge... and you can feel it hardening under your touches, firming up until the whole tail has become rock-hard and spherical in shape.  The heat fades, leaving behind a gentle warmth, and you realize your tail has become a spider's abdomen!  With one experimental clench, you even discover that it can shoot webs from some of its spinnerets, both sticky and non-adhesive ones.  That may prove useful.  <b>You now have a spider's abdomen hanging from above your " + buttDescript() + "!</b>");
	player.tailType = Tail.SPIDER_ADBOMEN;
	player.tailVenom = 5;
	player.tailRecharge = 5;
	doNext(accessPage1TailMenu);
}
private function metamorphSpiderLegs():void {
	clearOutput();
	player.soulforce -= 100;
	if (player.lowerBody != LowerBody.HUMAN) restoreHumanLegs();
	outputText("\n\nStarting at your [feet], a tingle runs up your [legs], not stopping until it reaches your thighs.  From the waist down, your strength completely deserts you, leaving you to fall hard on your " + buttDescript() + " in the dirt.  With nothing else to do, you look down, only to be mesmerized by the sight of black exoskeleton creeping up a perfectly human-looking calf.  It crests up your knee to envelop the joint in a many-faceted onyx coating.  Then, it resumes its slow upward crawl, not stopping until it has girded your thighs in glittery, midnight exoskeleton.  From a distance it would look almost like a black, thigh-high boot, but you know the truth.  <b>You now have human-like legs covered in a black, arachnid exoskeleton.</b>");
	player.lowerBody = LowerBody.CHITINOUS_SPIDER_LEGS;
	doNext(accessPage2LegsMenu);
}
private function metamorphSpiderArms():void {
	clearOutput();
	player.soulforce -= 100;
	outputText("\n\n");
	if (player.arms.type == Arms.HARPY || player.arms.type == Arms.HUMAN) {
		if (player.arms.type == Arms.HARPY) outputText("The feathers covering your arms fall away, leaving them to return to a far more human appearance.  ");
		outputText("You watch, spellbound, while your forearms gradually become shiny.  The entire outer structure of your arms tingles while it divides into segments, <b>turning the " + player.skinFurScales() + " into a shiny black carapace</b>.  You touch the onyx exoskeleton and discover to your delight that you can still feel through it as naturally as your own skin.");
	}
	else {
		if (player.arms.type == Arms.BEE) outputText("The fizz covering your upper arms starting to fall down leaving only shiny black chitin clad arms.");
		else if (player.arms.type == Arms.SALAMANDER || player.arms.type == Arms.LIZARD || player.arms.type == Arms.DRAGON) outputText("The sclaes covering your upper arms starting to fall down leaving only shiny black chitin clad arms.");
		else if (player.arms.type == Arms.MANTIS) outputText("The long scythe extending from your wrist crumbling, while chitin covering your mantis arms slowly starting to change colors, <b>turning the " + player.skinFurScales() + " into a shiny black carapace</b>.");
		else outputText("You watch, spellbound, while your forearms gradually become shiny.  The entire outer structure of your arms tingles while it divides into segments, <b>turning the " + player.skinFurScales() + " into a shiny black carapace</b>.  You touch the onyx exoskeleton and discover to your delight that you can still feel through it as naturally as your own skin.");
	}
	player.arms.type = Arms.SPIDER;
	doNext(accessPage1ArmsMenu);
}
private function metamorphSpiderFangs():void {
	clearOutput();
	player.soulforce -= 100;
	outputText("\n\nTension builds within your upper gum, just above your canines.  You open your mouth and prod at the affected area, pricking your finger on the sharpening tooth.  It slides down while you're touching it, lengthening into a needle-like fang.  You check the other side and confirm your suspicions.  <b>You now have a pair of pointy spider-fangs, complete with their own venom!</b>");
	player.faceType = Face.SPIDER_FANGS;
	doNext(accessPage1FaceMenu);
}
private function metamorphSpiderFourEyes():void {
	clearOutput();
	player.soulforce -= 100;
	outputText("\n\nYou suddenly get the strangest case of double vision.  Stumbling and blinking around, you clutch at your face, but you draw your hands back when you poke yourself in the eye.  Wait, those fingers were on your forehead!  You tentatively run your fingertips across your forehead, not quite believing what you felt.  <b>There's a pair of eyes on your forehead, positioned just above your normal ones!</b>  This will take some getting used to!");
	player.eyes.type = Eyes.FOUR_SPIDER_EYES;
	doNext(accessPage1EyesMenu);
}
private function metamorphElfinEars():void {
	clearOutput();
	player.soulforce -= 100;
	outputText("\n\nYour ears twitch once, twice, before starting to shake and tremble madly.  They migrate back towards where your ears USED to be, so long ago, finally settling down before twisting and stretching, changing to become <b>new, pointed elfin ears.</b>");
	player.ears.type = Ears.ELFIN;
	doNext(accessPage1EarsMenu);
}
private function metamorphHarpyWings():void {
	clearOutput();
	player.soulforce -= 100;
	if (player.wings.type > Wings.NONE) outputText("\n\nSensation fades from your " + player.wings.desc + " wings slowly but surely, leaving them dried out husks that break off to fall on the ground. Your back closes up to conceal the loss, as smooth and unbroken as the day you entered the portal.");
	outputText("\n\nPain lances through your back, the muscles knotting oddly and pressing up to bulge your [skin.type]. It hurts, oh gods does it hurt, but you can't get a good angle to feel at the source of your agony. A loud crack splits the air, and then your body is forcing a pair of narrow limbs through a gap in your [armor]. Blood pumps through the new appendages, easing the pain as they fill out and grow. Tentatively, you find yourself flexing muscles you didn't know you had, and <b>you're able to curve the new growths far enough around to behold your brand new, [haircolor] wings.</b>");
	player.wings.type = Wings.FEATHERED_LARGE;
	player.wings.desc = "large, feathered";
	doNext(accessPage1WingsMenu);
}
private function metamorphHarpyHair():void {
	clearOutput();
	player.soulforce -= 100;
	outputText("\n\nA tingling starts in your scalp, getting worse and worse until you're itching like mad, the feathery strands of your hair tickling your fingertips while you scratch like a dog itching a flea. When you pull back your hand, you're treated to the sight of downy fluff trailing from your fingernails. A realization dawns on you - you have feathers for hair, just like a harpy!");
	player.hairType = Hair.FEATHER;
	doNext(accessHairMenu);
}
private function metamorphHarpyArms():void {
	clearOutput();
	player.soulforce -= 100;
	outputText("\n\nAn avian plumage sprouts from your [skin.type], covering your forearms until <b>your arms look vaguely like wings</b>. Your hands remain unchanged thankfully. It'd be impossible to be a champion without hands! The feathery limbs might help you maneuver if you were to fly, but there's no way they'd support you alone.");
	player.arms.type = Arms.HARPY;
	doNext(accessPage1ArmsMenu);
}
private function metamorphHarpyTail():void {
	clearOutput();
	player.soulforce -= 100;
	if (player.tailType > Tail.NONE) outputText("\n\nYour tail shortens, folding into the crack of your " + buttDescript() + " before it disappears. A moment later, a fan of feathers erupts in its place, fluffing up and down instinctively every time the breeze shifts. <b>You have a feathery harpy tail!</b>");
	else outputText("\n\nA tingling tickles the base of your spine, making you squirm in place. A moment later, it fades, but a fan of feathers erupts from your [skin.type] in its place. The new tail fluffs up and down instinctively with every shift of the breeze. <b>You have a feathery harpy tail!</b>");
	player.tailType = Tail.HARPY;
	doNext(accessPage1TailMenu);
}
private function metamorphHarpyLegs():void {
	clearOutput();
	player.soulforce -= 100;
	if (!player.isGoo()) outputText("\n\nYour [legs] creak ominously a split-second before they go weak and drop you on the ground. They go completely limp, twisting and reshaping before your eyes in ways that make you wince. Your lower body eventually stops, but the form it's settled on is quite thick in the thighs. Even your [feet] have changed.  ");
	else outputText("\n\nYour gooey undercarriage loses some of its viscosity, dumping you into the puddle that was once your legs. As you watch, the fluid pulls together into a pair of distinctly leg-like shapes, solidifying into a distinctly un-gooey form. You've even regained a pair of feet!  ");
	outputText("While humanoid in shape, they have two large, taloned toes on the front and a single claw protruding from the heel. The entire ensemble is coated in [haircolor] feathers from ankle to hip, reminding you of the bird-women of the mountains. <b>You now have harpy legs!</b>");
	player.lowerBody = LowerBody.HARPY;
	player.legCount = 2;
	doNext(accessPage1LegsMenu);
}
private function metamorphBeeWingsLarge():void {
	clearOutput();
	player.soulforce -= 200;
	outputText("\n\nYour wings tingle as they grow, filling out until they are large enough to lift you from the ground and allow you to fly!  <b>You now have large bee wings!</b>  You give a few experimental flaps and begin hovering in place, a giddy smile plastered on your face by the thrill of flight.");
	player.wings.type = Wings.BEE_LIKE_LARGE;
	player.wings.desc = "large bee-like";
	doNext(accessPage1WingsMenu);
}
private function metamorphBeeWingsSmall():void {
	clearOutput();
	player.soulforce -= 100;
	outputText("\n\nYou feel an itching between your shoulder-blades as something begins growing there.  You twist and contort yourself, trying to scratch and bring yourself relief, and failing miserably.  A sense of relief erupts from you as you feel something new grow out from your body.  You hastily remove the top portion of your [armor] and marvel as a pair of small bee-like wings sprout from your back.  Tenderly flexing your new muscles, you find you can flap them quite fast.  Unfortunately you can't seem to flap your little wings fast enough to fly, but they would certainly slow a fall.  A few quick modifications to your [armor] later and you are ready to continue your journey with <b>your new bee wings</b>.");
	player.wings.type = Wings.BEE_LIKE_SMALL;
	player.wings.desc = "small bee-like";
	doNext(accessPage1WingsMenu);
}
private function metamorphBeeTail():void {
	clearOutput();
	player.soulforce -= 100;
	if (player.tailType > Tail.NONE) outputText("\n\nPainful swelling just above your " + buttDescript() + " doubles you over, and you hear the sound of your tail dropping off onto the ground!  Before you can consider the implications, the pain gets worse, and you feel your backside bulge outward sickeningly, cracking and popping as a rounded bee-like abdomen grows in place of your old tail.  It grows large enough to be impossible to hide, and with a note of finality, your stinger slides free with an audible 'snick'.");
	else outputText("\n\nPainful swelling just above your " + buttDescript() + " doubles you over.  It gets worse and worse as the swollen lump begins to protrude from your backside, swelling and rounding with a series of pops until you have a bulbous abdomen hanging just above your butt.  The whole thing is covered in a hard chitinous material, and large enough to be impossible to hide.  You sigh as your stinger slides into place with a 'snick', finishing the transformation.  <b>You have a bee's abdomen.</b>");
	player.tailType = Tail.BEE_ABDOMEN;
	player.tailVenom = 10;
	player.tailRecharge = 2;
	doNext(accessPage1TailMenu);
}
private function metamorphBeeArms():void {
	clearOutput();
	player.soulforce -= 100;
	outputText("\n\n");
	if (player.arms.type == Arms.SPIDER) outputText("On your upper arms slowly starting to grown yellow fuzz making them looks more like those of bee.");
	else if (player.arms.type == Arms.MANTIS) outputText("The long scythe extending from your wrist crumbling, while chitin covering your mantis arms slowly starting to change colors, <b>turning the " + player.skinFurScales() + " into a shiny black carapace</b>. Additionaly on your upper arms appear yellow fuzz.");
	else {
		if (player.arms.type == Arms.HARPY) outputText("The feathers covering your arms fall away, leaving them to return to a far more human appearance.  ");
		outputText("You watch, spellbound, while your forearms gradually become shiny.  The entire outer structure of your arms tingles while it divides into segments, <b>turning the " + player.skinFurScales() + " into a shiny black carapace</b>.  A moment later the pain fades and you are able to turn your gaze down to your beautiful new arms, covered in shining black chitin from the upper arm down, and downy yellow fuzz along your upper arm.");
	}
	player.arms.type = Arms.BEE;
	doNext(accessPage1ArmsMenu);
}
private function metamorphBeeLegs():void {
	clearOutput();
	player.soulforce -= 100;
	if (player.lowerBody != LowerBody.HUMAN) restoreHumanLegs();
	outputText("\n\nYour legs tremble with sudden unbearable pain, as if they're being ripped apart from the inside out and being stitched together again all at once.  You scream in agony as you hear bones snapping and cracking.  A moment later the pain fades and you are able to turn your gaze down to your beautiful new legs, covered in shining black chitin from the thigh down, and downy yellow fuzz along your upper thighs.");
	player.lowerBody = LowerBody.BEE;
	doNext(accessPage1LegsMenu);
}
private function metamorphBeeAntennae():void {
	clearOutput();
	player.soulforce -= 100;
	if (player.antennae.type == Antennae.MANTIS) outputText("\n\nYour head itches momentarily as your two long prehensile antennae changes slowly into floppy ones similar to those seen at bees.");
	else outputText("\n\nYour head itches momentarily as two floppy antennae sprout from your " + hairDescript() + ".");
	player.antennae.type = Antennae.BEE;
	doNext(accessAntennaeMenu);
}
private function metamorphLizardFace():void {
	clearOutput();
	player.soulforce -= 100;
	outputText("\n\nTerrible agony wracks your [face] as bones crack and shift.  Your jawbone rearranges while your cranium shortens.  The changes seem to last forever; once they've finished, no time seems to have passed.  Your fingers brush against your toothy snout as you get used to your new face.  It seems <b>you have a toothy, reptilian visage now.</b>");
	player.faceType = Face.LIZARD;
	doNext(accessPage1FaceMenu);
}
private function metamorphLizardEars():void {
	clearOutput();
	player.soulforce -= 100;
	outputText("\n\nTightness centers on your scalp, pulling your ears down from their normal, fleshy shape into small, scaley bumps with holes in their centers.  <b>You have reptilian ears!</b>");
	player.ears.type = Ears.LIZARD;
	doNext(accessPage1EarsMenu);
}
private function metamorphLizardEyes():void {
	clearOutput();
	player.soulforce -= 100;
	if (player.eyes.type != Eyes.HUMAN) removeOddEyes();
	player.eyes.colour = "yellow";
	outputText("\n\nYou suddenly feel your vision shifting. It takes a moment for you to adapt to the weird sensory changes but once you recover you go to a puddle and notice your eyes now have a slitted pupil like that of a reptile taking on a [eyecolor] hue with a slit.  <b>You now have reptilian eyes!</b>");
	player.eyes.type = Eyes.REPTILIAN;
	doNext(accessPage1EyesMenu);
}
private function metamorphLizardTail():void {
	clearOutput();
	player.soulforce -= 100;
	if (player.tailType == Tail.NONE) outputText("\n\nYou drop onto the ground as your spine twists and grows, forcing the flesh above your " + assDescript() + " to bulge out.  New bones form, one after another, building a tapered, prehensile tail onto the back of your body.  <b>You now have a reptilian tail!</b>");
	else outputText("\n\nYou drop to the ground as your tail twists and grows, changing its shape in order to gradually taper to a point.  It flicks back and forth, prehensile and totally under your control.  <b>You now have a reptilian tail.</b>");
	player.tailType = Tail.LIZARD;
	doNext(accessPage1TailMenu);
}
private function metamorphLizardArms():void {
	clearOutput();
	player.soulforce -= 100;
	outputText("\n\nYou scratch at your biceps absentmindedly, but no matter how much you scratch, it isn't getting rid of the itch.  After longer moment of ignoring it you finaly glancing down in irritation, only to discover that your arms former appearance changed into this of lizard one with leathery scales and short claws replacing your fingernails.  <b>You now have a lizard arms.</b>");
	player.arms.type = Arms.LIZARD;
	doNext(accessPage2ArmsMenu);
}
private function metamorphLizardLegs():void {
	clearOutput();
	player.soulforce -= 100;
	if (player.lowerBody == LowerBody.HOOFED) outputText("\n\nYou scream in agony as you feel your hooves crack and break apart, beginning to rearrange.  Your legs change to a digitigrade shape while your feet grow claws and shift to have three toes on the front and a smaller toe on the heel.");
	else if (player.isTaur()) outputText("\n\nYour lower body is wracked by pain!  Once it passes, you discover that you're standing on digitigrade legs with lizard-like claws.");
	else if (player.lowerBody == LowerBody.HUMAN || player.lowerBody == LowerBody.DOG || player.lowerBody == LowerBody.DEMONIC_HIGH_HEELS || player.lowerBody == LowerBody.DEMONIC_CLAWS || player.lowerBody == LowerBody.PLANT_HIGH_HEELS || player.lowerBody == LowerBody.PLANT_ROOT_CLAWS || player.lowerBody == LowerBody.BEE || player.lowerBody == LowerBody.CAT || player.lowerBody == LowerBody.LIZARD) outputText("\n\nYou scream in agony as you feel the bones in your legs break and begin to rearrange. They change to a digitigrade shape while your feet grow claws and shift to have three toes on the front and a smaller toe on the heel.");
	else outputText("\n\nPain rips through your [legs], morphing and twisting them until the bones rearrange into a digitigrade configuration.  The strange legs have three-toed, clawed feet, complete with a small vestigial claw-toe on the back for added grip.");
	outputText("  <b>You have reptilian legs and claws!</b>");
	player.lowerBody = LowerBody.LIZARD;
	player.legCount = 2;
	doNext(accessPage1LegsMenu);
}
private function metamorphHornsDraconicX4():void {
	clearOutput();
	player.soulforce -= 200;
	outputText("\n\nA second row of horns erupts under the first, and though they are narrower, they grow nearly as long as your first row before they stop.  A sense of finality settles over you.  <b>You have as many horns as a lizan can grow.</b>");
	player.horns.count = 12;
	player.horns.type = Horns.DRACONIC_X4_12_INCH_LONG;
	doNext(accessPage1HornsMenu);
}
private function metamorphHornsDraconicX2():void {
	clearOutput();
	player.soulforce -= 100;
	outputText("\n\nYou feel your horns changing and warping, and reach back to touch them.  They have a slight curve and a gradual taper.  They must look something like the horns the dragons in your village's legends always had.");
	player.horns.count = 4;
	player.horns.type = Horns.DRACONIC_X2;
	doNext(accessPage1HornsMenu);
}
private function metamorphWingsDemonicLarge2():void {
	clearOutput();
	player.soulforce -= 300;
	outputText("\n\nYour large demonic wings starts to tremble and then starts to split from the tip.  You stretch over your shoulder to stroke them as they divide, turning into two pairs of full-sized demon-wings.  <b>Your demonic wings have splited into two pairs!</b>");
	player.wings.type = Wings.BAT_LIKE_LARGE_2;
	player.wings.desc = "two large pairs of bat-like";
	doNext(accessPage1WingsMenu);
}
private function metamorphWingsDemoncLarge():void {
	clearOutput();
	player.soulforce -= 200;
	outputText("\n\nYour small demonic wings stretch and grow, tingling with the pleasure of being attached to such a tainted body.  You stretch over your shoulder to stroke them as they unfurl, turning into full-sized demon-wings.  <b>Your demonic wings have grown!</b>");
	player.wings.type = Wings.BAT_LIKE_LARGE;
	player.wings.desc = "large, bat-like";
	doNext(accessPage1WingsMenu);
}
private function metamorphWingsDemonicTiny():void {
	clearOutput();
	player.soulforce -= 100;
	if (player.wings.type != Wings.NONE) removeOldWings();
	outputText("\n\nA knot of pain forms in your shoulders as they tense up.  With a surprising force, a pair of small demonic wings sprout from your back, ripping a pair of holes in the back of your [armor].  <b>You now have tiny demonic wings</b>.");
	player.wings.type = Wings.BAT_LIKE_TINY;
	player.wings.desc = "tiny, bat-like";
	doNext(accessPage1WingsMenu);
}
private function metamorphLegsDemonicClaws():void {
	clearOutput();
	player.soulforce -= 100;
	if (player.lowerBody != LowerBody.HUMAN) restoreHumanLegs();
	outputText("\n\n");
	outputText("Every muscle and sinew below your hip tingles and you begin to stagger. Seconds after you sit down, pain explodes in your [feet]. Something hard breaks through your sole from the inside out as your toes splinter and curve cruelly. The pain slowly diminishes and your eyes look along a human leg that splinters at the foot into a claw with sharp black nails. When you relax, your feet grip the ground easily. <b>Your feet are now formed into demonic claws.</b>");
	player.lowerBody = LowerBody.DEMONIC_CLAWS;
	doNext(accessPage1LegsMenu);
}
private function metamorphLegsDemonicHighHeels():void {
	clearOutput();
	player.soulforce -= 100;
	if (player.lowerBody != LowerBody.HUMAN) restoreHumanLegs();
	outputText("\n\n");
	outputText("Every muscle and sinew below your hip tingles and you begin to stagger. Seconds after you sit down, pain explodes in your [feet]. Something hard breaks through your sole from the inside out. The pain slowly diminishes and your eyes look along a human leg to a thin and sharp horns protruding from the heel. When you relax, your feet are pointing down and their old posture is only possible with an enormous effort. <b>Your feet are now formed into demonic high-heels.</b> Tentatively you stand up and try to take a few steps. To your surprise you feel as if you were born with this and stride vigorously forward, hips swaying.");
	player.lowerBody = LowerBody.DEMONIC_HIGH_HEELS;
	doNext(accessPage1LegsMenu);
}
private function metamorphTonugeDemonic():void {
	clearOutput();
	player.soulforce -= 100;
	outputText("\n\n");
	outputText("Your snake-like tongue tingles, thickening in your mouth until it feels more like your old human tongue, at least for the first few inches.  It bunches up inside you, and when you open up your mouth to release it, roughly two feet of tongue dangles out.  You find it easy to move and control, as natural as walking.  <b>You now have a long demon-tongue.</b>");
	player.tongue.type = Tongue.DEMONIC;
	doNext(accessTongueMenu);
}
private function metamorphHornsDemonic():void {
	clearOutput();
	player.soulforce -= 100;
	if (player.horns.count < 12 && (player.horns.type == Horns.NONE || player.horns.type == Horns.DEMON)) {
		outputText("\n\n");
		if (player.horns.count == 0) {
			outputText("A small pair of demon horns erupts from your forehead.  They actually look kind of cute.  <b>You have horns!</b>");
		}
		else outputText("Another pair of demon horns, larger than the last, forms behind the first row.");
		if (player.horns.type == Horns.NONE) player.horns.type = Horns.DEMON;
		player.horns.count++;
		player.horns.count++;
	}
	else if (player.horns.type > Horns.DEMON && player.horns.type != Horns.ORCHID) {
		outputText("\n\n");
		outputText("Your horns shift, shrinking into two small demonic-looking horns.");
		player.horns.count = 2;
		player.horns.type = Horns.DEMON;
	}
	doNext(accessPage1HornsMenu);
}
private function metamorphTailDemonic():void {
	clearOutput();
	player.soulforce -= 100;
	if (player.tailType != Tail.NONE) {
		outputText("\n\n");
		if (player.tailType == Tail.SPIDER_ADBOMEN || player.tailType == Tail.BEE_ABDOMEN) outputText("You feel a tingling in your insectile abdomen as it stretches, narrowing, the exoskeleton flaking off as it transforms into a flexible demon-tail, complete with a round spaded tip.  ");
		else outputText("You feel a tingling in your tail.  You are amazed to discover it has shifted into a flexible demon-tail, complete with a round spaded tip.  ");
		outputText("<b>Your tail is now demonic in appearance.</b>");
	}
	else outputText("\n\nA pain builds in your backside... growing more and more pronounced.  The pressure suddenly disappears with a loud ripping and tearing noise.  <b>You realize you now have a demon tail</b>... complete with a cute little spade.");
	player.tailType = Tail.DEMONIC;
	doNext(accessPage1TailMenu);
}
private function metamorphKitsuneSkinPattern():void {
	clearOutput();
	player.soulforce -= 100;
	outputText("\n\nYou feel a crawling sensation on the surface of your skin, starting at the small of your back and spreading to your extremities, ultimately reaching your face.  You are caught by surprise when you are suddenly assaulted by a blinding flash issuing from areas of your skin, and when the spots finally clear from your vision, an assortment of glowing magical tattoos adorns your [skin].  The glow gradually fades, but the distinctive ");
	if (rand(2) == 0) outputText("angular");
	else outputText("curved");
	outputText(" markings remain, as if etched into your skin. <b>You now have Kitsune tattooed skin.</b>");
	player.skin.base.pattern = Skin.PATTERN_MAGICAL_TATTOO;
	player.skin.base.adj = "sexy tattooed";
	doNext(accessSkinPatternsMenu);
}
private function metamorphKitsuneArms():void {
	clearOutput();
	player.soulforce -= 100;
	if (player.arms.type != Arms.HUMAN) restoreHumanArms();
	outputText("\n\nYour finger tingle as your nails sharpen to point. You run them on a tree bark and they feel way harder than your old human nails. <b>You will be able to claw at your opponent with your sharp kitsune nails.</b>");
	player.arms.type = Arms.KITSUNE;
	doNext(accessPage1ArmsMenu);
}
private function metamorphTailFox9th():void {
	clearOutput();
	player.soulforce -= 900;
	outputText("A tingling pressure builds on your backside, and your bushy tails begin to glow with an eerie, ghostly light.  With a crackle of electrical energy, one of your tails splits in two, giving you " + num2Text(player.tailCount + 1) + "!  <b>You now have a cluster of " + num2Text(player.tailCount + 1) + " fox-tails.</b>");
	player.tailCount++;
	doNext(accessPage2TailMenu);
}
private function metamorphTailFox8th():void {
	clearOutput();
	player.soulforce -= 800;
	outputText("A tingling pressure builds on your backside, and your bushy tails begin to glow with an eerie, ghostly light.  With a crackle of electrical energy, one of your tails splits in two, giving you " + num2Text(player.tailCount + 1) + "!  <b>You now have a cluster of " + num2Text(player.tailCount + 1) + " fox-tails.</b>");
	player.tailCount++;
	doNext(accessPage2TailMenu);
}
private function metamorphTailFox7th():void {
	clearOutput();
	player.soulforce -= 700;
	outputText("A tingling pressure builds on your backside, and your bushy tails begin to glow with an eerie, ghostly light.  With a crackle of electrical energy, one of your tails splits in two, giving you " + num2Text(player.tailCount + 1) + "!  <b>You now have a cluster of " + num2Text(player.tailCount + 1) + " fox-tails.</b>");
	player.tailCount++;
	doNext(accessPage2TailMenu);
}
private function metamorphTailFox6th():void {
	clearOutput();
	player.soulforce -= 600;
	outputText("A tingling pressure builds on your backside, and your bushy tails begin to glow with an eerie, ghostly light.  With a crackle of electrical energy, one of your tails splits in two, giving you " + num2Text(player.tailCount + 1) + "!  <b>You now have a cluster of " + num2Text(player.tailCount + 1) + " fox-tails.</b>");
	player.tailCount++;
	doNext(accessPage2TailMenu);
}
private function metamorphTailFox5th():void {
	clearOutput();
	player.soulforce -= 500;
	outputText("A tingling pressure builds on your backside, and your bushy tails begin to glow with an eerie, ghostly light.  With a crackle of electrical energy, one of your tails splits in two, giving you " + num2Text(player.tailCount + 1) + "!  <b>You now have a cluster of " + num2Text(player.tailCount + 1) + " fox-tails.</b>");
	player.tailCount++;
	doNext(accessPage2TailMenu);
}
private function metamorphTailFox4th():void {
	clearOutput();
	player.soulforce -= 400;
	outputText("A tingling pressure builds on your backside, and your bushy tails begin to glow with an eerie, ghostly light.  With a crackle of electrical energy, one of your tails splits in two, giving you " + num2Text(player.tailCount + 1) + "!  <b>You now have a cluster of " + num2Text(player.tailCount + 1) + " fox-tails.</b>");
	player.tailCount++;
	doNext(accessPage2TailMenu);
}
private function metamorphTailFox3rd():void {
	clearOutput();
	player.soulforce -= 300;
	outputText("A tingling pressure builds on your backside, and your bushy tails begin to glow with an eerie, ghostly light.  With a crackle of electrical energy, one of your tails splits in two, giving you " + num2Text(player.tailCount + 1) + "!  <b>You now have a cluster of " + num2Text(player.tailCount + 1) + " fox-tails.</b>");
	player.tailCount++;
	doNext(accessPage2TailMenu);
}
private function metamorphTailFox2nd():void {
	clearOutput();
	player.soulforce -= 200;
	outputText("A tingling pressure builds on your backside, and your bushy tail begins to glow with an eerie, ghostly light.  With a crackle of electrical energy, your tail splits into two!  <b>You now have a pair of fox-tails.</b>");
	player.tailCount++;
	doNext(accessPage2TailMenu);
}
private function metamorphEyesFox():void {
	clearOutput();
	player.soulforce -= 100;
	outputText("You blink for an instant as the light and darkness seems to shift within your vision. You head to a pool to check it up and notice your pupils shifted to look more fox-like in a fashion similar to the kitsunes.  <b>You now have fox pupils.</b>");
	player.eyes.type = Eyes.FOX;
	doNext(accessPage1EyesMenu);
}
private function metamorphFaceFox():void {
	clearOutput();
	player.soulforce -= 100;
	outputText("Your face pinches and you clap your hands to it.  Within seconds, your nose is poking through those hands, pushing them slightly to the side as new flesh and bone build and shift behind it, until it stops in a clearly defined, tapered, and familiar point you can see even without the aid of a mirror.  <b>Looks like you now have a fox's face.</b>");
	player.faceType = Face.FOX;
	doNext(accessPage1FaceMenu);
}
private function metamorphTailFox():void {
	clearOutput();
	player.soulforce -= 100;
	if (player.tailType == Tail.NONE) outputText("A pressure builds on your backside.  You feel under your [armor] and discover a strange nodule growing there that seems to be getting larger by the second.  With a sudden flourish of movement, it bursts out into a long and bushy tail that sways hypnotically, as if it had a mind of its own.  <b>You now have a fox's tail!</b>");
	else outputText("Pain lances through your lower back as your tail shifts violently.  With one final aberrant twitch, it fluffs out into a long, bushy fox tail that whips around in an almost hypnotic fashion.  <b>You now have a fox's tail!</b>");
	player.tailType = Tail.FOX;
	player.tailCount = 1;
	doNext(accessPage2TailMenu);
}
private function metamorphEarsFox():void {
	clearOutput();
	player.soulforce -= 100;
	if (player.ears.type == Ears.HUMAN || player.ears.type == Ears.ELFIN || player.ears.type == Ears.LIZARD) {
		outputText("The sides of your face painfully stretch as your ears elongate and begin to push past your hairline, toward the top of your head.  They elongate, becoming large vulpine triangles covered in bushy fur.  <b>You now have fox ears.</b>");
	}
	else {
		outputText("Your ears change, shifting from their current shape to become vulpine in nature.  <b>You now have fox ears.</b>");
	}
	player.ears.type = Ears.FOX;
	doNext(accessPage1EarsMenu);
}
private function metamorphArmsFox():void {
	clearOutput();
	player.soulforce -= 100;
	if (player.arms.type != Arms.HUMAN) restoreHumanArms();
	outputText("Your arms and hands start covering in fur at an alarming rate suddenly as you poke at your palms you jolt up as they become extremely sensitive turning into paw pads heck your nails transformed into wolf like claws so no wonder you felt it that much. <b>You now have pawed hands.</b>");
	player.arms.type = Arms.FOX;
	doNext(accessPage1ArmsMenu);
}
private function metamorphLowerBodyFox():void {
	clearOutput();
	player.soulforce -= 100;
	if (player.isTaur()) outputText("You shiver as the strength drains from your back legs.  Shaken, you sit on your haunches, forelegs braced wide to stop you from tipping over;  their hooves scrape the dirt as your lower body shrinks, dragging them backward until you can feel the upper surfaces of your hindlegs with their undersides.  A wave of nausea and vertigo overtakes you, and you close your eyes to shut out the sensations.  When they reopen, what greets them are not four legs, but only two... and those roughly in the shape of your old hindleg, except for the furry toes where your hooves used to be.  <b>You now have fox legs!</b>");
	else if (player.isNaga()) outputText("Your scales split at the waistline and begin to peel, shedding like old snakeskin.  If that weren't curious enough, the flesh - not scales - underneath is pink and new, and the legs it covers crooked into the hocks and elongated feet of a field animal.  As the scaly coating falls and you step out of it, walking of necessity on your toes, a fine powder blows from the dry skin.  Within minutes, it crumbles completely and is taken by the ever-moving wind.  <b>Your legs are now those of a fox!</b>");
	else if (player.lowerBody == LowerBody.HOOFED || player.lowerBody == LowerBody.DOG || player.lowerBody == LowerBody.CAT || player.lowerBody == LowerBody.BUNNY || player.lowerBody == LowerBody.KANGAROO) {
		outputText("Your legs twitch and quiver, forcing you to your seat.  As you watch, the ends shape themselves into furry, padded toes.  <b>You now have fox feet!</b>  Rather cute ones, actually.");
	}
	else if (player.lowerBody == LowerBody.DRIDER) outputText("Your legs buckle under you and you fall, smashing your abdomen on the ground.  Though your control deserts and you cannot see behind you, still you feel the disgusting sensation of chitin loosening and sloughing off your body, and the dry breeze on your exposed nerves.  Reflexively, your legs cling together to protect as much of their now-sensitive surface as possible.  When you try to part them, you find you cannot.  Several minutes pass uncomforably until you can again bend your legs, and when you do, you find that all the legs of a side bend together - <b>in the shape of a fox's leg!</b>");
	else if (player.isGoo()) outputText("It takes a while before you notice that your gooey mounds have something more defined in them.  As you crane your body and shift them around to look, you can just make out a semi-solid mass in the shape of a crooked, animalistic leg.  You don't think much of it until, a few minutes later, you step right out of your swishing gooey undercarriage and onto the new foot.  The goo covering it quickly dries up, as does the part you left behind, <b>revealing a pair of dog-like fox legs!</b>");
	else {
		outputText("Your hamstrings tense painfully and begin to pull, sending you onto your face.  As you writhe on the ground, you can feel your thighs shortening and your feet stretching");
		if (player.lowerBody == LowerBody.BEE) outputText(", while a hideous cracking fills the air");
		outputText(".  When the spasms subside and you can once again stand, <b>you find that your legs have been changed to those of a fox!</b>");
	}
	player.lowerBody = LowerBody.FOX;
	player.legCount = 2;
	doNext(accessPage2LegsMenu);
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
	doNext(accessGillsMenu);
}
//all skin types TF effects goes here
/*private function metamorphTattoed():void {
	clearOutput();
	player.soulforce -= 100;
	
	doNext(accessMetamorphMenu);
}*/
private function metamorphDragonScales():void {
	clearOutput();
	player.soulforce -= 150;
	outputText("\n\nPrickling discomfort suddenly erupts all over your body, like every last inch of your skin has suddenly developed pins and needles.  You scratch yourself, hoping for relief; and when you look at your hands you notice small fragments of your " + player.skinFurScales() + " hanging from your fingers.  Nevertheless you continue to scratch yourself, and when you're finally done, you look yourself over. New shield-like scales have grown to replace your peeled off " + player.skinFurScales() + ". They are smooth and look nearly as tough as iron. ");
	var color:String;
	if (rand(10) == 0) {
		color = randomChoice("purple","silver");
	} else {
		color = randomChoice("red","green","white","blue","black");
	}
	outputText("<b>Your body is now fully covered in " + color + " shield-shaped dragon scales.</b>");
	player.skin.growCoat(Skin.DRAGON_SCALES,{color:color});
	doNext(accessSkinMenu);
}
private function metamorphChitin():void {
	clearOutput();
	player.soulforce -= 100;
	var chitinColor:String;
	if (rand(2) == 0) chitinColor = "pale white";
	else chitinColor = "green";
	if (player.hasCoat()) {
		outputText("\n\nA slowly-building itch spreads over your whole body, and as you idly scratch yourself, you find that your [skin coat] [skin coat.isare] falling to the ground, revealing flawless, " + chitinColor + " chitin underneath.");
	} else {
		outputText("\n\nA slowly-building itch spreads over your whole body, and as you idly scratch yourself, you find that your skin stating to harden turning slowly into chitin.");
	}
	outputText("  <b>You now have " + chitinColor + " chitin exoskeleton covering your body.</b>");
	player.skin.growCoat(Skin.CHITIN,{adj:"",color:chitinColor});
	doNext(accessSkinMenu);
}
private function metamorphScales():void {
	clearOutput();
	player.soulforce -= 100;
	if (player.skinType == Skin.FUR) {
		if (rand(10) == 0) {
			if (rand(2) == 0) player.coatColor = "purple";
			else player.coatColor = "silver";
		}
		else {
			switch (rand(5)) {
				case 0:
					player.coatColor = "red";
					break;
				case 1:
					player.coatColor = "green";
					break;
				case 2:
					player.coatColor = "white";
					break;
				case 3:
					player.coatColor = "blue";
					break;
				default:
					player.coatColor = "black";
					break;
			}
		}
		outputText("\n\nYou scratch yourself, and come away with a large clump of [skin coat.color] fur.  Panicked, you look down and realize that your fur is falling out in huge clumps.  It itches like mad, and you scratch your body relentlessly, shedding the remaining fur with alarming speed.  Underneath the fur your skin feels incredibly smooth, and as more and more of the stuff comes off, you discover a seamless layer of " + player.coatColor + " scales covering most of your body.  The rest of the fur is easy to remove.  <b>You're now covered in scales from head to toe.</b>");
	}
	else {
		outputText("\n\nYou idly reach back to scratch yourself and nearly jump out of your [armor] when you hit something hard.  A quick glance down reveals that scales are growing out of your " + player.skinTone + " skin with alarming speed.  As you watch, the surface of your skin is covered in smooth scales.  They interlink together so well that they may as well be seamless.  You peel back your [armor] and the transformation has already finished on the rest of your body.  ");
		if (rand(10) == 0) {
			if (rand(2) == 0) player.coatColor = "purple";
			else player.coatColor = "silver";
		}
		else {
			switch (rand(5)) {
				case 0:
					player.coatColor = "red";
					break;
				case 1:
					player.coatColor = "green";
					break;
				case 2:
					player.coatColor = "white";
					break;
				case 3:
					player.coatColor = "blue";
					break;
				default:
					player.coatColor = "black";
					break;
			}
		}
		outputText("<b>You're covered from head to toe in shiny " + player.coatColor + " scales.</b>");
	}
	player.skin.growCoat(Skin.SCALES,{color:player.coatColor});
	doNext(accessSkinMenu);
}
private function metamorphFur():void {
	clearOutput();
	player.soulforce -= 100;
	if (player.skinType == Skin.SCALES) outputText("Your skin shifts and every scale stands on end, sending you into a mild panic.  No matter how you tense, you can't seem to flatten them again.  The uncomfortable sensation continues for some minutes until, as one, every scale falls from your body and a fine coat of fur pushes out.  You briefly consider collecting them, but when you pick one up, it's already as dry and brittle as if it were hundreds of years old.  <b>Oh well; at least you won't need to sun yourself as much with your new fur.</b>");
	else outputText("Your skin itches all over, the sudden intensity and uniformity making you too paranoid to scratch.  As you hold still through an agony of tiny tingles and pinches, fine, luxuriant fur sprouts from every bare inch of your skin!  <b>You'll have to get used to being furry...</b>");
	player.skin.growFur();
	doNext(accessSkinMenu);
}

private function removeOddEyes():void {
	if (player.eyes.type == Eyes.BLACK_EYES_SAND_TRAP) {
		outputText("\n\nYou feel a twinge in your eyes and you blink.  It feels like black cataracts have just fallen away from you, and you know without needing to see your reflection that your eyes have gone back to looking human.");
	}
	else {
		outputText("\n\nYou blink and stumble, a wave of vertigo threatening to pull your [feet] from under you.  As you steady and open your eyes, you realize something seems different.  Your vision is changed somehow.");
		if (player.eyes.type == Eyes.FOUR_SPIDER_EYES) outputText("  Your multiple, arachnid eyes are gone!</b>");
		outputText("  <b>You have normal, humanoid eyes again.</b>");
	}
	player.eyes.type = Eyes.HUMAN;
}
private function removeOldWings():void {
	outputText("\n\nSensation fades from your " + player.wings.desc + " wings slowly but surely, leaving them dried out husks that break off to fall on the ground. Your back closes up to conceal the loss, as smooth and unbroken as the day you entered the portal.");
	player.wings.type = Wings.NONE;
	player.wings.desc = "non-existant";
}
private function restoreHumanEars():void {
	outputText("\n\nOuch, your head aches! It feels like your ears are being yanked out of your head, and when you reach up to hold your aching noggin, you find they've vanished! Swooning and wobbling with little sense of balance, you nearly fall a half-dozen times before <b>a pair of normal, human ears sprout from the sides of your head.</b> You had almost forgotten what human ears felt like!");
	player.ears.type = Ears.HUMAN;
}
private function restoreHumanLegs():void {
	if (player.isTaur()) {
		outputText("\n\nYour quadrupedal hind-quarters seizes, overbalancing your surprised front-end and causing you to stagger and fall to your side.  Pain lances throughout, contorting your body into a tightly clenched ball of pain while tendons melt and bones break, melt, and regrow.  When it finally stops, <b>you look down to behold your new pair of human legs</b>!");
	}
	else {
		if (player.isGoo()) {
			outputText("\n\nYour lower body rushes inward, molding into two leg-like shapes that gradually stiffen up.  In moments they solidify into normal-looking legs, complete with regular, human feet.");
		}
		if (player.isNaga()) {
			outputText("\n\nYou collapse as your sinuous snake-tail tears in half, shifting into legs.  The pain is immense, particularly where your new feet are forming.");
		}
		if (player.isScylla()) {
			outputText("\n\nYou collapse as your tentacle legs starts to merge.  The pain is immense, particularly where your new feet are forming.");
		}
		//(Non-human -> Normal Human Legs)
		if (player.isBiped() && player.lowerBody != LowerBody.HUMAN) {
			outputText("\n\nYou collapse as your legs shift and twist.  By the time the pain subsides, you notice that you have normal legs and normal feet.");
		}
		outputText("  <b>You now have normal feet!</b>");
	}
	player.lowerBody = LowerBody.HUMAN;
	player.legCount = 2;
}
private function restoreHumanArms():void {
	outputText("You scratch at your biceps absentmindedly, but no matter how much you scratch, it isn't getting rid of the itch.  Glancing down in irritation, you discover that your ");
	if (player.arms.type == Arms.HARPY || player.arms.type == Arms.PHOENIX || player.arms.type == Arms.AVIAN) {
		outputText("feathery arms are shedding their feathery coating.  The wing-like shape your arms once had is gone in a matter of moments, leaving [skin.type] behind.");
	}
	if (player.arms.type == Arms.SPIDER) {
		outputText("arms' chitinous covering is flaking away.  The glossy black coating is soon gone, leaving [skin.type] behind.");
	}
	if (player.arms.type == Arms.MANTIS) {
		outputText("arms' chitinous covering is flaking away and scythe shrinking until it vanish completly.  The glossy green coating is soon gone, leaving [skin.type] behind.");
	}
	if (player.arms.type == Arms.BEE) {
		outputText("arms' chitinous covering and fuzz is flaking away.  The glossy black and yellow coating is soon gone, leaving [skin.type] behind.");
	}
	if (player.arms.type == Arms.SALAMANDER || player.arms.type == Arms.LIZARD || player.arms.type == Arms.DRAGON) {
		outputText("arms' scales are flaking away.  The leathery ");
		if (player.arms.type == Arms.SALAMANDER) outputText("red ");
		outputText("scales are soon gone, leaving [skin.type] behind.");
	}
	if (player.arms.type == Arms.PLANT || player.arms.type == Arms.PLANT2) {
		outputText("arms' vines are withering.  Leaves also falling donw, leaving [skin.type] behind.");
	}
	if (player.arms.type == Arms.SHARK || player.arms.type == Arms.ORCA) {
		outputText("arms' fin suddenly fell down, leaving [skin.type] behind.  Also webbing between your fingers slowly disappearing.");
	}
	if (player.arms.type == Arms.WOLF || player.arms.type == Arms.FOX || player.arms.type == Arms.LION || player.arms.type == Arms.YETI || player.arms.type == Arms.DEVIL || player.arms.type == Arms.CAT || player.arms.type == Arms.BOAR || player.arms.type == Arms.DISPLACER) {
		outputText("arms' [skin coat.color] fur is flaking away, leaving [skin.type] behind.  Also the claws on your fingers reverts back into ordinary nails");
		if (player.arms.type == Arms.DISPLACER) outputText(" and both pairs fuse back into one");
		outputText(".");
	}
	if (player.arms.type == Arms.ELF || player.arms.type == Arms.KITSUNE || player.arms.type == Arms.ONI || player.arms.type == Arms.RAIJU || player.arms.type == Arms.PIG) {
		outputText("arms' claws retracting back into ordinary nails. You hand looks human again.");
	}
	outputText("\n\n");
	player.arms.type = Arms.HUMAN;
}
	}
}