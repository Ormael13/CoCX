/**
 * ...
 * @author Ormael
 */
package classes.Scenes 
{
	import classes.*
	import classes.BaseContent;
	import classes.GlobalFlags.kGAMECLASS;
	
	use namespace kGAMECLASS;
	
	public class Metamorph extends BaseContent
	{
		
		public function Metamorph() 
		{
			
		}
	
public function accessMetamorphMenu():void {
	clearOutput();
	outputText("Using some of soulforce to re-gain any animal bodyparts that your body remember in it genetic memory.");
	outputText("<b>Race added to Metamorph: Bee, Demon, Fox, Harpy, Kitsune (up to 6th tail), Lizard</b>");
	menu();
	addButton(10, "Page 1", accessPage1MetamorphMenu);
	addButton(11, "Page 2", accessPage2MetamorphMenu);
//	addButton(12, "Page 3", accessPage3MetamorphMenu);
//	addButton(13, "Page 4", accessPage4MetamorphMenu);
	addButton(14, "Back", kGAMECLASS.soulforce.accessSoulforceMenu);
}

private function accessPage1MetamorphMenu():void {
	menu();
	addButton(0, "Skin", accessSkinMenu);
	addButton(1, "Hair", accessHairMenu);
	addButton(2, "Face(1)", accessPage1FaceMenu);
//	addButton(3, "Face(2)", accessPage2FaceMenu);
	addButton(4, "Tongue", accessTongueMenu);
	addButton(5, "Eyes", accessEyesMenu);
	addButton(6, "Ears(1)", accessPage1EarsMenu);
//	addButton(7, "Ears(2)", accessPage2EarsMenu);
	addButton(8, "Horns", accessHornsMenu);
	addButton(9, "Antennae", accessAntennaeMenu);
	addButton(10, "Gills", accessGillsMenu);
	addButton(11, "Arms", accessArmsMenu);
	addButton(12, "Tail(1)", accessPage1TailMenu);
	addButton(13, "Tail(2)", accessPage2TailMenu);
	addButton(14, "Back", accessMetamorphMenu);
}
private function accessSkinMenu():void {
	menu();
	if (player.hasStatusAffect(StatusAffects.UnlockedFur) && player.skinType != SKIN_TYPE_FUR && player.soulforce >= 100) addButton(0, "Fur", metamorphFur);
	else if (player.hasStatusAffect(StatusAffects.UnlockedFur) && player.skinType == SKIN_TYPE_FUR) addButtonDisabled(0, "Fur", "You already have fur.");
	else if (player.hasStatusAffect(StatusAffects.UnlockedFur) && player.skinType != SKIN_TYPE_FUR && player.soulforce < 100) addButtonDisabled(0, "Fur", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(0, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusAffect(StatusAffects.UnlockedScales) && player.skinType != SKIN_TYPE_SCALES && player.soulforce >= 100) addButton(1, "Scales", metamorphScales);
	else if (player.hasStatusAffect(StatusAffects.UnlockedScales) && player.skinType == SKIN_TYPE_SCALES) addButtonDisabled(1, "Scales", "You already have scales.");
	else if (player.hasStatusAffect(StatusAffects.UnlockedScales) && player.skinType != SKIN_TYPE_SCALES && player.soulforce < 100) addButtonDisabled(1, "Scales", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(1, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusAffect(StatusAffects.UnlockedChitin) && !player.hasCoatOfType(SKIN_COAT_CHITIN) && player.soulforce >= 100) addButton(3, "Chitin", metamorphChitin);
	else if (player.hasStatusAffect(StatusAffects.UnlockedChitin) && player.hasCoatOfType(SKIN_COAT_CHITIN)) addButtonDisabled(3, "Chitin", "You already have chitin.");
	else if (player.hasStatusAffect(StatusAffects.UnlockedChitin) && !player.hasCoatOfType(SKIN_COAT_CHITIN) && player.soulforce < 100) addButtonDisabled(3, "Chitin", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(3, "???", "You not yet unlocked this metamorphosis!");
	addButton(14, "Back", accessPage1MetamorphMenu);
}
private function accessHairMenu():void {
	menu();
	if (player.hasStatusAffect(StatusAffects.UnlockedHarpyHair) && player.hairType != 1 && player.soulforce >= 100) addButton(0, "Harpy", metamorphHarpyHair);
	else if (player.hasStatusAffect(StatusAffects.UnlockedHarpyHair) && player.hairType == 1) addButtonDisabled(0, "Harpy", "You already have harpy hair.");
	else if (player.hasStatusAffect(StatusAffects.UnlockedHarpyHair) && player.hairType != 1 && player.soulforce < 100) addButtonDisabled(0, "Harpy", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(0, "???", "You not yet unlocked this metamorphosis!");
	addButton(14, "Back", accessPage1MetamorphMenu);
}
private function accessPage1FaceMenu():void {
	menu();
	if (player.hasStatusAffect(StatusAffects.UnlockedSharkTeeth) && player.faceType != FACE_SHARK_TEETH && player.soulforce >= 100) addButton(3, "Shark", metamorphSharkTeeth);
	else if (player.hasStatusAffect(StatusAffects.UnlockedSharkTeeth) && player.faceType == FACE_SHARK_TEETH) addButtonDisabled(3, "Shark", "You already have shark teeth.");
	else if (player.hasStatusAffect(StatusAffects.UnlockedSharkTeeth) && player.faceType != FACE_SHARK_TEETH && player.soulforce < 100) addButtonDisabled(3, "Shark", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(3, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusAffect(StatusAffects.UnlockedLizardFace) && player.faceType != FACE_LIZARD && player.soulforce >= 100) addButton(7, "Lizard", metamorphLizardFace);
	else if (player.hasStatusAffect(StatusAffects.UnlockedLizardFace) && player.faceType == FACE_LIZARD) addButtonDisabled(7, "Lizard", "You already have lizard face.");
	else if (player.hasStatusAffect(StatusAffects.UnlockedLizardFace) && player.faceType != FACE_LIZARD && player.soulforce < 100) addButtonDisabled(7, "Lizard", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(7, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusAffect(StatusAffects.UnlockedSpiderFangs) && player.faceType != FACE_SPIDER_FANGS && player.soulforce >= 100) addButton(10, "Spider", metamorphSpiderFangs);
	else if (player.hasStatusAffect(StatusAffects.UnlockedSpiderFangs) && player.faceType == FACE_SPIDER_FANGS) addButtonDisabled(10, "Spider", "You already have spider fangs.");
	else if (player.hasStatusAffect(StatusAffects.UnlockedSpiderFangs) && player.faceType != FACE_SPIDER_FANGS && player.soulforce < 100) addButtonDisabled(10, "Spider", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(10, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusAffect(StatusAffects.UnlockedFoxFace) && player.faceType != FACE_FOX && player.soulforce >= 100) addButton(11, "Fox", metamorphFaceFox);
	else if (player.hasStatusAffect(StatusAffects.UnlockedFoxFace) && player.faceType == FACE_FOX) addButtonDisabled(11, "Fox", "You already have fox face.");
	else if (player.hasStatusAffect(StatusAffects.UnlockedFoxFace) && player.faceType != FACE_FOX && player.soulforce < 100) addButtonDisabled(11, "Fox", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(11, "???", "You not yet unlocked this metamorphosis!");
	addButton(14, "Back", accessPage1MetamorphMenu);
}
private function accessPage2FaceMenu():void {
	menu();
	addButton(14, "Back", accessPage1MetamorphMenu);
}
private function accessTongueMenu():void {
	menu();
	if (player.hasStatusAffect(StatusAffects.UnlockedDemonTonuge) && player.tongueType != TONUGE_DEMONIC && player.soulforce >= 100) addButton(1, "Demon", metamorphTonugeDemonic);
	else if (player.hasStatusAffect(StatusAffects.UnlockedDemonTonuge) && player.tongueType == TONUGE_DEMONIC) addButtonDisabled(1, "Demon", "You already have demon tonuge.");
	else if (player.hasStatusAffect(StatusAffects.UnlockedDemonTonuge) && player.tongueType != TONUGE_DEMONIC && player.soulforce < 100) addButtonDisabled(1, "Demon", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(1, "???", "You not yet unlocked this metamorphosis!");
	addButton(14, "Back", accessPage1MetamorphMenu);
}
private function accessEyesMenu():void {
	menu();
	if (player.hasStatusAffect(StatusAffects.UnlockedSpiderFourEyes) && player.eyeType != EYES_FOUR_SPIDER_EYES && player.soulforce >= 100) addButton(0, "Spider", metamorphSpiderFourEyes);
	else if (player.hasStatusAffect(StatusAffects.UnlockedSpiderFourEyes) && player.eyeType == EYES_FOUR_SPIDER_EYES) addButtonDisabled(0, "Spider", "You already have spider four eyes.");
	else if (player.hasStatusAffect(StatusAffects.UnlockedSpiderFourEyes) && player.eyeType != EYES_FOUR_SPIDER_EYES && player.soulforce < 100) addButtonDisabled(0, "Spider", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(0, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusAffect(StatusAffects.UnlockedFoxEyes) && player.eyeType != EYES_FOX && player.soulforce >= 100) addButton(6, "Fox", metamorphEyesFox);
	else if (player.hasStatusAffect(StatusAffects.UnlockedFoxEyes) && player.eyeType == EYES_FOX) addButtonDisabled(6, "Fox", "You already have fox eyes.");
	else if (player.hasStatusAffect(StatusAffects.UnlockedFoxEyes) && player.eyeType != EYES_FOX && player.soulforce < 100) addButtonDisabled(6, "Fox", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(6, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusAffect(StatusAffects.UnlockedLizardEyes) && player.eyeType != EYES_REPTILIAN && player.soulforce >= 100) addButton(7, "Lizard", metamorphLizardEyes);
	else if (player.hasStatusAffect(StatusAffects.UnlockedLizardEyes) && player.eyeType == EYES_REPTILIAN) addButtonDisabled(7, "Lizard", "You already have lizard eyes.");
	else if (player.hasStatusAffect(StatusAffects.UnlockedLizardEyes) && player.eyeType != EYES_REPTILIAN && player.soulforce < 100) addButtonDisabled(7, "Lizard", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(7, "???", "You not yet unlocked this metamorphosis!");
	addButton(14, "Back", accessPage1MetamorphMenu);
}
private function accessPage1EarsMenu():void {
	menu();
	if (player.hasStatusAffect(StatusAffects.UnlockedElfinEars) && player.earType != EARS_ELFIN && player.soulforce >= 100) addButton(3, "Elfin", metamorphElfinEars);
	else if (player.hasStatusAffect(StatusAffects.UnlockedElfinEars) && player.earType == EARS_ELFIN) addButtonDisabled(3, "Elfin", "You already have elfin ears.");
	else if (player.hasStatusAffect(StatusAffects.UnlockedElfinEars) && player.earType != EARS_ELFIN && player.soulforce < 100) addButtonDisabled(3, "Elfin", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(3, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusAffect(StatusAffects.UnlockedLizardEars) && player.earType != EARS_LIZARD && player.soulforce >= 100) addButton(5, "Lizard", metamorphLizardEars);
	else if (player.hasStatusAffect(StatusAffects.UnlockedLizardEars) && player.earType == EARS_LIZARD) addButtonDisabled(5, "Lizard", "You already have lizard ears.");
	else if (player.hasStatusAffect(StatusAffects.UnlockedLizardEars) && player.earType != EARS_LIZARD && player.soulforce < 100) addButtonDisabled(5, "Lizard", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(5, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusAffect(StatusAffects.UnlockedFoxEars) && player.earType != EARS_FOX && player.soulforce >= 100) addButton(8, "Fox", metamorphEarsFox);
	else if (player.hasStatusAffect(StatusAffects.UnlockedFoxEars) && player.earType == EARS_FOX) addButtonDisabled(8, "Fox", "You already have fox ears.");
	else if (player.hasStatusAffect(StatusAffects.UnlockedFoxEars) && player.earType != EARS_FOX && player.soulforce < 100) addButtonDisabled(8, "Fox", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(8, "???", "You not yet unlocked this metamorphosis!");
	addButton(14, "Back", accessPage1MetamorphMenu);
}
private function accessPage2EarsMenu():void {
	menu();
	addButton(14, "Back", accessPage1MetamorphMenu);
}
private function accessHornsMenu():void {
	menu();
	if (player.hasStatusAffect(StatusAffects.UnlockedDemonHorns) && player.hornType != HORNS_DEMON && player.soulforce >= 100) addButton(0, "Demon", metamorphHornsDemonic);
	else if (player.hasStatusAffect(StatusAffects.UnlockedDemonHorns) && player.hornType == HORNS_DEMON) addButtonDisabled(0, "Demon", "You already have demon horns.");
	else if (player.hasStatusAffect(StatusAffects.UnlockedDemonHorns) && player.hornType != HORNS_DEMON && player.soulforce < 100) addButtonDisabled(0, "Demon", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(0, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusAffect(StatusAffects.UnlockedDraconicX2) && player.hornType != HORNS_DRACONIC_X2 && player.soulforce >= 100) addButton(2, "DraconicX2", metamorphHornsDraconicX2);
	else if (player.hasStatusAffect(StatusAffects.UnlockedDraconicX2) && player.hornType == HORNS_DRACONIC_X2) addButtonDisabled(2, "DraconicX2", "You already have draconic horns.");
	else if (player.hasStatusAffect(StatusAffects.UnlockedDraconicX2) && player.hornType != HORNS_DRACONIC_X2 && player.soulforce < 100) addButtonDisabled(2, "DraconicX2", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(2, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusAffect(StatusAffects.UnlockedDraconicX4) && player.hornType == HORNS_DRACONIC_X2 && player.soulforce >= 200) addButton(3, "DraconicX4", metamorphHornsDraconicX4);
	else if (player.hasStatusAffect(StatusAffects.UnlockedDraconicX4) && player.hornType == HORNS_DRACONIC_X4_12_INCH_LONG) addButtonDisabled(3, "DraconicX4", "You already have two pairs of drconic horns.");
	else if (player.hasStatusAffect(StatusAffects.UnlockedDraconicX4) && player.hornType == HORNS_DRACONIC_X2 && player.soulforce < 200) addButtonDisabled(3, "DraconicX4", "You not have enough Soulforce for this metamorphosis.");
	else if (player.hasStatusAffect(StatusAffects.UnlockedDraconicX4) && player.hornType != HORNS_DRACONIC_X2) addButtonDisabled(3, "DraconicX4", "You not have proper type of horns for this metamorphosis.");
	else addButtonDisabled(3, "???", "You not yet unlocked this metamorphosis!");
	addButton(14, "Back", accessPage1MetamorphMenu);
}
private function accessAntennaeMenu():void {
	menu();
	if (player.hasStatusAffect(StatusAffects.UnlockedBeeAntennae) && player.antennae != ANTENNAE_BEE && player.soulforce >= 100) addButton(1, "Bee", metamorphBeeAntennae);
	else if (player.hasStatusAffect(StatusAffects.UnlockedBeeAntennae) && player.antennae == ANTENNAE_BEE) addButtonDisabled(1, "Bee", "You already have bee antennaes.");
	else if (player.hasStatusAffect(StatusAffects.UnlockedBeeAntennae) && player.antennae != ANTENNAE_BEE && player.soulforce < 100) addButtonDisabled(1, "Bee", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(1, "???", "You not yet unlocked this metamorphosis!");
	addButton(14, "Back", accessPage1MetamorphMenu);
}
private function accessGillsMenu():void {
	menu();
	if (player.hasStatusAffect(StatusAffects.UnlockedFishGills) && player.gillType != GILLS_FISH && player.soulforce >= 100) addButton(1, "Fish", metamorphFishGills);
	else if (player.hasStatusAffect(StatusAffects.UnlockedFishGills) && player.gillType == GILLS_FISH) addButtonDisabled(1, "Fish", "You already have fish gills.");
	else if (player.hasStatusAffect(StatusAffects.UnlockedFishGills) && player.gillType != GILLS_FISH && player.soulforce < 100) addButtonDisabled(1, "Fish", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(1, "???", "You not yet unlocked this metamorphosis!");
	addButton(14, "Back", accessPage1MetamorphMenu);
}
private function accessArmsMenu():void {
	menu();
	if (player.hasStatusAffect(StatusAffects.UnlockedHarpyArms) && player.armType != ARM_TYPE_HARPY && player.soulforce >= 100) addButton(0, "Harpy", metamorphHarpyArms);
	else if (player.hasStatusAffect(StatusAffects.UnlockedHarpyArms) && player.armType == ARM_TYPE_HARPY) addButtonDisabled(0, "Harpy", "You already have harpy arms.");
	else if (player.hasStatusAffect(StatusAffects.UnlockedHarpyArms) && player.armType != ARM_TYPE_HARPY && player.soulforce < 100) addButtonDisabled(0, "Harpy", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(0, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusAffect(StatusAffects.UnlockedSpiderArms) && player.armType != ARM_TYPE_SPIDER && player.soulforce >= 100) addButton(1, "Spider", metamorphSpiderArms);
	else if (player.hasStatusAffect(StatusAffects.UnlockedSpiderArms) && player.armType == ARM_TYPE_SPIDER) addButtonDisabled(1, "Spider", "You already have spider arms.");
	else if (player.hasStatusAffect(StatusAffects.UnlockedSpiderArms) && player.armType != ARM_TYPE_SPIDER && player.soulforce < 100) addButtonDisabled(1, "Spider", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(1, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusAffect(StatusAffects.UnlockedBeeArms) && player.armType != ARM_TYPE_BEE && player.soulforce >= 100) addButton(4, "Bee", metamorphBeeArms);
	else if (player.hasStatusAffect(StatusAffects.UnlockedBeeArms) && player.armType == ARM_TYPE_BEE) addButtonDisabled(4, "Bee", "You already have bee arms.");
	else if (player.hasStatusAffect(StatusAffects.UnlockedBeeArms) && player.armType != ARM_TYPE_BEE && player.soulforce < 100) addButtonDisabled(4, "Bee", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(4, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusAffect(StatusAffects.UnlockedSharkArms) && player.armType != ARM_TYPE_SHARK && player.soulforce >= 100) addButton(7, "Shark", metamorphSharkArms);
	else if (player.hasStatusAffect(StatusAffects.UnlockedSharkArms) && player.armType == ARM_TYPE_SHARK) addButtonDisabled(7, "Shark", "You already have shark arms.");
	else if (player.hasStatusAffect(StatusAffects.UnlockedSharkArms) && player.armType != ARM_TYPE_SHARK && player.soulforce < 100) addButtonDisabled(7, "Shark", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(7, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusAffect(StatusAffects.UnlockedFoxArms) && player.armType != ARM_TYPE_FOX && player.soulforce >= 100) addButton(11, "Fox", metamorphArmsFox);
	else if (player.hasStatusAffect(StatusAffects.UnlockedFoxArms) && player.armType == ARM_TYPE_FOX) addButtonDisabled(11, "Fox", "You already have fox arms.");
	else if (player.hasStatusAffect(StatusAffects.UnlockedFoxArms) && player.armType != ARM_TYPE_FOX && player.soulforce < 100) addButtonDisabled(11, "Fox", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(11, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusAffect(StatusAffects.UnlockedKitsuneArms) && player.armType != ARM_TYPE_FOX && player.soulforce >= 100) addButton(12, "Kitsune", metamorphKitsuneArms);
	else if (player.hasStatusAffect(StatusAffects.UnlockedKitsuneArms) && player.armType == ARM_TYPE_FOX) addButtonDisabled(12, "Kitsune", "You already have kitsune arms.");
	else if (player.hasStatusAffect(StatusAffects.UnlockedKitsuneArms) && player.armType != ARM_TYPE_FOX && player.soulforce < 100) addButtonDisabled(12, "Kitsune", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(12, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusAffect(StatusAffects.UnlockedLizardArms) && player.armType != ARM_TYPE_LIZARD && player.soulforce >= 100) addButton(13, "Lizard", metamorphLizardArms);
	else if (player.hasStatusAffect(StatusAffects.UnlockedLizardArms) && player.armType == ARM_TYPE_LIZARD) addButtonDisabled(13, "Lizard", "You already have lizard arms.");
	else if (player.hasStatusAffect(StatusAffects.UnlockedLizardArms) && player.armType != ARM_TYPE_LIZARD && player.soulforce < 100) addButtonDisabled(13, "Lizard", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(13, "???", "You not yet unlocked this metamorphosis!");
	addButton(14, "Back", accessPage1MetamorphMenu);
}
private function accessPage1TailMenu():void {
	menu();
	if (player.hasStatusAffect(StatusAffects.UnlockedDemonTail) && player.tailType != TAIL_TYPE_DEMONIC && player.soulforce >= 100) addButton(2, "Demon", metamorphTailDemonic);
	else if (player.hasStatusAffect(StatusAffects.UnlockedDemonTail) && player.tailType == TAIL_TYPE_DEMONIC) addButtonDisabled(2, "Demon", "You already have demon tail.");
	else if (player.hasStatusAffect(StatusAffects.UnlockedDemonTail) && player.tailType != TAIL_TYPE_DEMONIC && player.soulforce < 100) addButtonDisabled(2, "Demon", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(2, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusAffect(StatusAffects.UnlockedSpiderTail) && player.tailType != TAIL_TYPE_SPIDER_ADBOMEN && player.soulforce >= 100) addButton(4, "Spider", metamorphSpiderTail);
	else if (player.hasStatusAffect(StatusAffects.UnlockedSpiderTail) && player.tailType == TAIL_TYPE_SPIDER_ADBOMEN) addButtonDisabled(4, "Spider", "You already have spider abdomen.");
	else if (player.hasStatusAffect(StatusAffects.UnlockedSpiderTail) && player.tailType != TAIL_TYPE_SPIDER_ADBOMEN && player.soulforce < 100) addButtonDisabled(4, "Spider", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(4, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusAffect(StatusAffects.UnlockedBeeTail) && player.tailType != TAIL_TYPE_BEE_ABDOMEN && player.soulforce >= 100) addButton(5, "Bee", metamorphBeeTail);
	else if (player.hasStatusAffect(StatusAffects.UnlockedBeeTail) && player.tailType == TAIL_TYPE_BEE_ABDOMEN) addButtonDisabled(5, "Bee", "You already have bee tail.");
	else if (player.hasStatusAffect(StatusAffects.UnlockedBeeTail) && player.tailType != TAIL_TYPE_BEE_ABDOMEN && player.soulforce < 100) addButtonDisabled(5, "Bee", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(5, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusAffect(StatusAffects.UnlockedSharkTail) && player.tailType != TAIL_TYPE_SHARK && player.soulforce >= 100) addButton(6, "Shark", metamorphSharkTail);
	else if (player.hasStatusAffect(StatusAffects.UnlockedSharkTail) && player.tailType == TAIL_TYPE_SHARK) addButtonDisabled(6, "Shark", "You already have bee tail.");
	else if (player.hasStatusAffect(StatusAffects.UnlockedSharkTail) && player.tailType != TAIL_TYPE_SHARK && player.soulforce < 100) addButtonDisabled(6, "Shark", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(6, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusAffect(StatusAffects.UnlockedLizardTail) && player.tailType != TAIL_TYPE_LIZARD && player.soulforce >= 100) addButton(8, "Lizard", metamorphLizardTail);
	else if (player.hasStatusAffect(StatusAffects.UnlockedLizardTail) && player.tailType == TAIL_TYPE_LIZARD) addButtonDisabled(8, "Lizard", "You already have lizard tail.");
	else if (player.hasStatusAffect(StatusAffects.UnlockedLizardTail) && player.tailType != TAIL_TYPE_LIZARD && player.soulforce < 100) addButtonDisabled(8, "Lizard", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(8, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusAffect(StatusAffects.UnlockedHarpyTail) && player.tailType != TAIL_TYPE_HARPY && player.soulforce >= 100) addButton(10, "Harpy", metamorphHarpyTail);
	else if (player.hasStatusAffect(StatusAffects.UnlockedHarpyTail) && player.tailType == TAIL_TYPE_HARPY) addButtonDisabled(8, "Harpy", "You already have harpy tail.");
	else if (player.hasStatusAffect(StatusAffects.UnlockedHarpyTail) && player.tailType != TAIL_TYPE_HARPY && player.soulforce < 100) addButtonDisabled(8, "Harpy", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(10, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusAffect(StatusAffects.UnlockedFoxTail) && player.tailType != TAIL_TYPE_FOX && player.soulforce >= 100) addButton(13, "Fox", metamorphTailFox);
	else if (player.hasStatusAffect(StatusAffects.UnlockedFoxTail) && player.tailType == TAIL_TYPE_FOX && player.tailCount == 1) addButtonDisabled(13, "Fox", "You already have single fox tail.");
	else if (player.hasStatusAffect(StatusAffects.UnlockedFoxTail) && player.tailType != TAIL_TYPE_FOX && player.soulforce < 100) addButtonDisabled(13, "Fox", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(13, "???", "You not yet unlocked this metamorphosis!");
	addButton(14, "Back", accessPage1MetamorphMenu);
}
private function accessPage2TailMenu():void {
	menu();
	if (player.hasStatusAffect(StatusAffects.UnlockedFoxTail2nd) && player.tailType == TAIL_TYPE_FOX && player.tailCount == 1 && player.soulforce >= 200) addButton(0, "Fox 2nd", metamorphTailFox2nd);
	else if (player.hasStatusAffect(StatusAffects.UnlockedFoxTail2nd) && player.tailType == TAIL_TYPE_FOX && player.tailCount == 2) addButtonDisabled(0, "Fox 2nd", "You already have two fox tails.");
	else if (player.hasStatusAffect(StatusAffects.UnlockedFoxTail2nd) && player.tailType == TAIL_TYPE_FOX && player.tailCount == 1 && player.soulforce < 200) addButtonDisabled(0, "Fox 2nd", "You not have enough Soulforce for this metamorphosis.");
	else if (player.hasStatusAffect(StatusAffects.UnlockedFoxTail2nd) && player.tailType != TAIL_TYPE_FOX && player.tailCount != 1) addButtonDisabled(0, "Fox 2nd", "You not have proper type and amount of tails for this metamorphosis.");
	else addButtonDisabled(0, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusAffect(StatusAffects.UnlockedFoxTail3rd) && player.tailType == TAIL_TYPE_FOX && player.tailCount == 2 && player.soulforce >= 300) addButton(1, "Fox 3rd", metamorphTailFox2nd);
	else if (player.hasStatusAffect(StatusAffects.UnlockedFoxTail3rd) && player.tailType == TAIL_TYPE_FOX && player.tailCount == 3) addButtonDisabled(1, "Fox 3rd", "You already have three fox tails.");
	else if (player.hasStatusAffect(StatusAffects.UnlockedFoxTail3rd) && player.tailType == TAIL_TYPE_FOX && player.tailCount == 2 && player.soulforce < 300) addButtonDisabled(1, "Fox 3rd", "You not have enough Soulforce for this metamorphosis.");
	else if (player.hasStatusAffect(StatusAffects.UnlockedFoxTail3rd) && player.tailType != TAIL_TYPE_FOX && player.tailCount != 2) addButtonDisabled(1, "Fox 3rd", "You not have proper type and amount of tails for this metamorphosis.");
	else addButtonDisabled(1, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusAffect(StatusAffects.UnlockedFoxTail4th) && player.tailType == TAIL_TYPE_FOX && player.tailCount == 3 && player.soulforce >= 400) addButton(2, "Fox 4th", metamorphTailFox2nd);
	else if (player.hasStatusAffect(StatusAffects.UnlockedFoxTail4th) && player.tailType == TAIL_TYPE_FOX && player.tailCount == 4) addButtonDisabled(2, "Fox 4th", "You already have four fox tails.");
	else if (player.hasStatusAffect(StatusAffects.UnlockedFoxTail4th) && player.tailType == TAIL_TYPE_FOX && player.tailCount == 3 && player.soulforce < 400) addButtonDisabled(2, "Fox 4th", "You not have enough Soulforce for this metamorphosis.");
	else if (player.hasStatusAffect(StatusAffects.UnlockedFoxTail4th) && player.tailType != TAIL_TYPE_FOX && player.tailCount != 3) addButtonDisabled(2, "Fox 4th", "You not have proper type and amount of tails for this metamorphosis.");
	else addButtonDisabled(2, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusAffect(StatusAffects.UnlockedFoxTail5th) && player.tailType == TAIL_TYPE_FOX && player.tailCount == 4 && player.soulforce >= 500) addButton(3, "Fox 5th", metamorphTailFox2nd);
	else if (player.hasStatusAffect(StatusAffects.UnlockedFoxTail5th) && player.tailType == TAIL_TYPE_FOX && player.tailCount == 5) addButtonDisabled(3, "Fox 5th", "You already have five fox tails.");
	else if (player.hasStatusAffect(StatusAffects.UnlockedFoxTail5th) && player.tailType == TAIL_TYPE_FOX && player.tailCount == 4 && player.soulforce < 500) addButtonDisabled(3, "Fox 5th", "You not have enough Soulforce for this metamorphosis.");
	else if (player.hasStatusAffect(StatusAffects.UnlockedFoxTail5th) && player.tailType != TAIL_TYPE_FOX && player.tailCount != 4) addButtonDisabled(3, "Fox 5th", "You not have proper type and amount of tails for this metamorphosis.");
	else addButtonDisabled(3, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusAffect(StatusAffects.UnlockedFoxTail6th) && player.tailType == TAIL_TYPE_FOX && player.tailCount == 5 && player.soulforce >= 600) addButton(4, "Fox 6th", metamorphTailFox2nd);
	else if (player.hasStatusAffect(StatusAffects.UnlockedFoxTail6th) && player.tailType == TAIL_TYPE_FOX && player.tailCount == 6) addButtonDisabled(4, "Fox 6th", "You already have six fox tails.");
	else if (player.hasStatusAffect(StatusAffects.UnlockedFoxTail6th) && player.tailType == TAIL_TYPE_FOX && player.tailCount == 5 && player.soulforce < 600) addButtonDisabled(4, "Fox 6th", "You not have enough Soulforce for this metamorphosis.");
	else if (player.hasStatusAffect(StatusAffects.UnlockedFoxTail6th) && player.tailType != TAIL_TYPE_FOX && player.tailCount != 5) addButtonDisabled(4, "Fox 6th", "You not have proper type and amount of tails for this metamorphosis.");
	else addButtonDisabled(4, "???", "You not yet unlocked this metamorphosis!");
	addButton(14, "Back", accessPage1MetamorphMenu);
}

private function accessPage2MetamorphMenu():void {
	menu();
//	addButton(0, "Tail(3)", accessPage3TailMenu);
	addButton(1, "Wings(1)", accessPage1WingsMenu);
//	addButton(2, "Wings(2)", accessPage2WingsMenu);
	addButton(3, "Legs(1)", accessPage1LegsMenu);
	addButton(4, "Legs(2)", accessPage2LegsMenu);
//	addButton(5, "Legs(3)", accessPage3LegsMenu);
	addButton(6, "Rear B.", accessRearBodyMenu);
//	addButton(7, "Back", accessMetamorphMenu);
//	addButton(8, "Back", accessMetamorphMenu);
//	addButton(9, "Back", accessMetamorphMenu);
//	addButton(10, "Back", accessMetamorphMenu);
//	addButton(11, "Back", accessMetamorphMenu);
//	addButton(12, "Back", accessMetamorphMenu);
//	addButton(13, "Back", accessMetamorphMenu);
	addButton(14, "Back", accessMetamorphMenu);
}
private function accessPage3TailMenu():void {
	menu();
	addButton(14, "Back", accessPage2MetamorphMenu);
}
private function accessPage1WingsMenu():void {
	menu();
	if (player.hasStatusAffect(StatusAffects.UnlockedBeeWingsSmall) && player.wingType != WING_TYPE_BEE_LIKE_SMALL && player.soulforce >= 100) addButton(0, "Bee(S)", metamorphBeeWingsSmall);
	else if (player.hasStatusAffect(StatusAffects.UnlockedBeeWingsSmall) && player.wingType == WING_TYPE_BEE_LIKE_SMALL) addButtonDisabled(0, "Bee(S)", "You already have small bee wings.");
	else if (player.hasStatusAffect(StatusAffects.UnlockedBeeWingsSmall) && player.wingType != WING_TYPE_BEE_LIKE_SMALL && player.soulforce < 100) addButtonDisabled(0, "Bee(S)", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(0, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusAffect(StatusAffects.UnlockedBeeWingsLarge) && player.wingType == WING_TYPE_BEE_LIKE_SMALL && player.soulforce >= 200) addButton(1, "Bee(L)", metamorphBeeWingsLarge);
	else if (player.hasStatusAffect(StatusAffects.UnlockedBeeWingsLarge) && player.wingType == WING_TYPE_BEE_LIKE_LARGE) addButtonDisabled(1, "Bee(L)", "You already have large bee wings.");
	else if (player.hasStatusAffect(StatusAffects.UnlockedBeeWingsLarge) && player.wingType != WING_TYPE_BEE_LIKE_LARGE && player.soulforce < 200) addButtonDisabled(1, "Bee(L)", "You not have enough Soulforce for this metamorphosis.");
	else if (player.hasStatusAffect(StatusAffects.UnlockedBeeWingsLarge) && player.wingType != WING_TYPE_BEE_LIKE_SMALL) addButtonDisabled(1, "Bee(L)", "You not have proper type of wings for this metamorphosis.");
	else addButtonDisabled(1, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusAffect(StatusAffects.UnlockedDemonTinyBatWings) && player.wingType != WING_TYPE_BAT_LIKE_TINY && player.soulforce >= 100) addButton(4, "Demon(S)", metamorphWingsDemonicTiny);
	else if (player.hasStatusAffect(StatusAffects.UnlockedDemonTinyBatWings) && player.wingType == WING_TYPE_BAT_LIKE_TINY) addButtonDisabled(4, "Demon(S)", "You already have small bat wings.");
	else if (player.hasStatusAffect(StatusAffects.UnlockedDemonTinyBatWings) && player.wingType != WING_TYPE_BAT_LIKE_TINY && player.soulforce < 100) addButtonDisabled(4, "Demon(S)", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(4, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusAffect(StatusAffects.UnlockedDemonLargeBatWings) && player.wingType == WING_TYPE_BAT_LIKE_TINY && player.soulforce >= 200) addButton(5, "Demon(L)", metamorphWingsDemoncLarge);
	else if (player.hasStatusAffect(StatusAffects.UnlockedDemonLargeBatWings) && player.wingType == WING_TYPE_BAT_LIKE_LARGE) addButtonDisabled(5, "Demon(L)", "You already have large bat wings.");
	else if (player.hasStatusAffect(StatusAffects.UnlockedDemonLargeBatWings) && player.wingType != WING_TYPE_BAT_LIKE_LARGE && player.soulforce < 200) addButtonDisabled(5, "Demon(L)", "You not have enough Soulforce for this metamorphosis.");
	else if (player.hasStatusAffect(StatusAffects.UnlockedDemonLargeBatWings) && player.wingType != WING_TYPE_BAT_LIKE_TINY) addButtonDisabled(5, "Demon(L)", "You not have proper type of wings for this metamorphosis.");
	else addButtonDisabled(5, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusAffect(StatusAffects.UnlockedHarpyWings) && player.wingType != WING_TYPE_FEATHERED_LARGE && player.soulforce >= 100) addButton(6, "Harpy", metamorphHarpyWings);
	else if (player.hasStatusAffect(StatusAffects.UnlockedHarpyWings) && player.wingType == WING_TYPE_FEATHERED_LARGE) addButtonDisabled(6, "Harpy", "You already have harpy wings.");
	else if (player.hasStatusAffect(StatusAffects.UnlockedHarpyWings) && player.wingType != WING_TYPE_FEATHERED_LARGE && player.soulforce < 100) addButtonDisabled(6, "Harpy", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(6, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusAffect(StatusAffects.UnlockedDemonLargeBatWings2) && player.wingType == WING_TYPE_BAT_LIKE_LARGE && player.soulforce >= 300) addButton(10, "Demon(L2)", metamorphWingsDemonicLarge2);
	else if (player.hasStatusAffect(StatusAffects.UnlockedDemonLargeBatWings2) && player.wingType == WING_TYPE_BAT_LIKE_LARGE_2) addButtonDisabled(10, "Demon(L2)", "You already have two large pairs of bat wings.");
	else if (player.hasStatusAffect(StatusAffects.UnlockedDemonLargeBatWings2) && player.wingType != WING_TYPE_BAT_LIKE_LARGE_2 && player.soulforce < 300) addButtonDisabled(10, "Demon(L2)", "You not have enough Soulforce for this metamorphosis.");
	else if (player.hasStatusAffect(StatusAffects.UnlockedDemonLargeBatWings2) && player.wingType != WING_TYPE_BAT_LIKE_LARGE) addButtonDisabled(10, "Demon(L2)", "You not have proper type of wings for this metamorphosis.");
	else addButtonDisabled(10, "???", "You not yet unlocked this metamorphosis!");
	addButton(14, "Back", accessPage2MetamorphMenu);
}
private function accessPage2WingsMenu():void {
	menu();
	addButton(14, "Back", accessPage2MetamorphMenu);
}
private function accessPage1LegsMenu():void {
	menu();
	if (player.hasStatusAffect(StatusAffects.UnlockedDemonHighHeels) && player.lowerBody != LOWER_BODY_TYPE_DEMONIC_HIGH_HEELS && (player.gender == 2 || player.gender == 3) && player.soulforce >= 100) addButton(3, "Demon(F)", metamorphLegsDemonicHighHeels);
	else if (player.hasStatusAffect(StatusAffects.UnlockedDemonHighHeels) && player.lowerBody == LOWER_BODY_TYPE_DEMONIC_HIGH_HEELS && (player.gender == 2 || player.gender == 3)) addButtonDisabled(3, "Demon(F)", "You already have demon high heels lower body.");
	else if (player.hasStatusAffect(StatusAffects.UnlockedDemonHighHeels) && player.lowerBody != LOWER_BODY_TYPE_DEMONIC_HIGH_HEELS && (player.gender == 2 || player.gender == 3) && player.soulforce < 100) addButtonDisabled(3, "Demon(F)", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(3, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusAffect(StatusAffects.UnlockedDemonClawedLegs) && player.lowerBody != LOWER_BODY_TYPE_DEMONIC_CLAWS && player.gender != 2 && player.soulforce >= 100) addButton(4, "Demon(M)", metamorphLegsDemonicClaws);
	else if (player.hasStatusAffect(StatusAffects.UnlockedDemonClawedLegs) && player.lowerBody == LOWER_BODY_TYPE_DEMONIC_CLAWS && player.gender != 2) addButtonDisabled(4, "Demon(M)", "You already have demon clawed feet lower body.");
	else if (player.hasStatusAffect(StatusAffects.UnlockedDemonClawedLegs) && player.lowerBody != LOWER_BODY_TYPE_DEMONIC_CLAWS && player.gender != 2 && player.soulforce < 100) addButtonDisabled(4, "Demon(M)", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(4, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusAffect(StatusAffects.UnlockedBeeLegs) && player.lowerBody != LOWER_BODY_TYPE_BEE && player.soulforce >= 100) addButton(5, "Bee", metamorphBeeLegs);
	else if (player.hasStatusAffect(StatusAffects.UnlockedBeeLegs) && player.lowerBody == LOWER_BODY_TYPE_BEE) addButtonDisabled(5, "Bee", "You already have bee lower body.");
	else if (player.hasStatusAffect(StatusAffects.UnlockedBeeLegs) && player.lowerBody != LOWER_BODY_TYPE_BEE && player.soulforce < 100) addButtonDisabled(5, "Bee", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(5, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusAffect(StatusAffects.UnlockedLizardLegs) && player.lowerBody != LOWER_BODY_TYPE_LIZARD && player.soulforce >= 100) addButton(8, "Lizard", metamorphLizardLegs);
	else if (player.hasStatusAffect(StatusAffects.UnlockedLizardLegs) && player.lowerBody == LOWER_BODY_TYPE_LIZARD) addButtonDisabled(8, "Lizard", "You already have lizard lower body.");
	else if (player.hasStatusAffect(StatusAffects.UnlockedLizardLegs) && player.lowerBody != LOWER_BODY_TYPE_LIZARD && player.soulforce < 100) addButtonDisabled(8, "Lizard", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(8, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusAffect(StatusAffects.UnlockedHarpyLegs) && player.lowerBody != LOWER_BODY_TYPE_HARPY && player.soulforce >= 100) addButton(10, "Harpy", metamorphHarpyLegs);
	else if (player.hasStatusAffect(StatusAffects.UnlockedHarpyLegs) && player.lowerBody == LOWER_BODY_TYPE_HARPY) addButtonDisabled(10, "Harpy", "You already have harpy lower body.");
	else if (player.hasStatusAffect(StatusAffects.UnlockedHarpyLegs) && player.lowerBody != LOWER_BODY_TYPE_HARPY && player.soulforce < 100) addButtonDisabled(10, "Harpy", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(10, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusAffect(StatusAffects.UnlockedSpiderLegs) && player.lowerBody != LOWER_BODY_TYPE_CHITINOUS_SPIDER_LEGS && player.soulforce >= 100) addButton(13, "Spider", metamorphSpiderLegs);
	else if (player.hasStatusAffect(StatusAffects.UnlockedSpiderLegs) && player.lowerBody == LOWER_BODY_TYPE_CHITINOUS_SPIDER_LEGS) addButtonDisabled(13, "Spider", "You already have spider lower body.");
	else if (player.hasStatusAffect(StatusAffects.UnlockedSpiderLegs) && player.lowerBody != LOWER_BODY_TYPE_CHITINOUS_SPIDER_LEGS && player.soulforce < 100) addButtonDisabled(13, "Spider", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(13, "???", "You not yet unlocked this metamorphosis!");
	addButton(14, "Back", accessPage2MetamorphMenu);
}
private function accessPage2LegsMenu():void {
	menu();
	if (player.hasStatusAffect(StatusAffects.UnlockedDriderLegs) && player.lowerBody == LOWER_BODY_TYPE_CHITINOUS_SPIDER_LEGS && player.tailType == TAIL_TYPE_SPIDER_ADBOMEN && player.soulforce >= 300) addButton(0, "Drider", metamorphDriderLegs);
	else if (player.hasStatusAffect(StatusAffects.UnlockedDriderLegs) && player.lowerBody == LOWER_BODY_TYPE_DRIDER_LOWER_BODY) addButtonDisabled(0, "Drider", "You already have drider lower body.");
	else if (player.hasStatusAffect(StatusAffects.UnlockedDriderLegs) && player.lowerBody == LOWER_BODY_TYPE_CHITINOUS_SPIDER_LEGS && player.tailType == TAIL_TYPE_SPIDER_ADBOMEN && player.soulforce < 300) addButtonDisabled(0, "Drider", "You not have enough Soulforce for this metamorphosis.");
	else if (player.hasStatusAffect(StatusAffects.UnlockedDriderLegs) && player.lowerBody == LOWER_BODY_TYPE_CHITINOUS_SPIDER_LEGS && player.tailType != TAIL_TYPE_SPIDER_ADBOMEN) addButtonDisabled(0, "Drider", "You have proper type of legs but have wrong type of tail for this metamorphosis.");
	else if (player.hasStatusAffect(StatusAffects.UnlockedDriderLegs) && player.lowerBody != LOWER_BODY_TYPE_CHITINOUS_SPIDER_LEGS) addButtonDisabled(0, "Drider", "You not have proper type of legs and/or tail for this metamorphosis.");
	else addButtonDisabled(0, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusAffect(StatusAffects.UnlockedFoxLowerBody) && player.lowerBody != LOWER_BODY_TYPE_FOX && player.soulforce >= 100) addButton(1, "Fox", metamorphLowerBodyFox);
	else if (player.hasStatusAffect(StatusAffects.UnlockedFoxLowerBody) && player.lowerBody == LOWER_BODY_TYPE_FOX) addButtonDisabled(1, "Fox", "You already have fox lower body.");
	else if (player.hasStatusAffect(StatusAffects.UnlockedFoxLowerBody) && player.lowerBody != LOWER_BODY_TYPE_FOX && player.soulforce < 100) addButtonDisabled(1, "Fox", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(1, "???", "You not yet unlocked this metamorphosis!");
	if (player.hasStatusAffect(StatusAffects.UnlockedSharkLegs) && player.lowerBody != LOWER_BODY_TYPE_SHARK && player.soulforce >= 100) addButton(9, "Shark", metamorphSharkLegs);
	else if (player.hasStatusAffect(StatusAffects.UnlockedSharkLegs) && player.lowerBody == LOWER_BODY_TYPE_SHARK) addButtonDisabled(9, "Shark", "You already have shark lower body.");
	else if (player.hasStatusAffect(StatusAffects.UnlockedSharkLegs) && player.lowerBody != LOWER_BODY_TYPE_SHARK && player.soulforce < 100) addButtonDisabled(9, "Shark", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(9, "???", "You not yet unlocked this metamorphosis!");
	addButton(14, "Back", accessPage2MetamorphMenu);
}
private function accessPage3LegsMenu():void {
	menu();
	addButton(14, "Back", accessPage2MetamorphMenu);
}
private function accessRearBodyMenu():void {
	menu();
	if (player.hasStatusAffect(StatusAffects.UnlockedSharkFin) && player.rearBody != REAR_BODY_SHARK_FIN && player.soulforce >= 100) addButton(5, "Shark", metamorphSharkFin);
	else if (player.hasStatusAffect(StatusAffects.UnlockedSharkFin) && player.rearBody == REAR_BODY_SHARK_FIN) addButtonDisabled(5, "Shark", "You already have shark back fin.");
	else if (player.hasStatusAffect(StatusAffects.UnlockedSharkFin) && player.rearBody != REAR_BODY_SHARK_FIN && player.soulforce < 100) addButtonDisabled(5, "Shark", "You not have enough Soulforce for this metamorphosis.");
	else addButtonDisabled(5, "???", "You not yet unlocked this metamorphosis!");
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
private function accessHairMenu():void {
	menu();
	addButton(14, "Back", accessPage2MetamorphMenu);
}
private function accessHairMenu():void {
	menu();
	addButton(14, "Back", accessPage2MetamorphMenu);
}
private function accessHairMenu():void {
	menu();
	addButton(14, "Back", accessPage2MetamorphMenu);
}
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
private function metamorphFur():void {
	clearOutput();
	player.soulforce -= 100;
	
	doNext(accessMetamorphMenu);
}
private function metamorphFur():void {
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
private function metamorphSharkFin():void {
	clearOutput();
	player.soulforce -= 100;
	outputText("\n\n", false);
	outputText("You groan and slump down in pain, almost instantly regretting eating the tooth. You start sweating profusely and panting loudly, feeling the space between your shoulder blades shifting about. You hastily remove your " + player.armorName + " just in time before a strange fin-like structure bursts from in-between your shoulders. You examine it carefully and make a few modifications to your " + player.armorName + " to accommodate your new fin.", false);
	player.rearBody = REAR_BODY_SHARK_FIN;
	doNext(accessMetamorphMenu);
}
private function metamorphSharkArms():void {
	clearOutput();
	player.soulforce -= 100;
	outputText("\n\nYou watch, spellbound, while your arms gradually changing it entire outer structure into plain human-like form with exception places between your finger which starting show signs to growing webbing. Soon after you start sweating profusely and panting loudly, feeling the space near your elbows shifting about. You hastily remove your " + player.armorName + " just in time before a strange fin-like structure bursts from your forearms. You examine them carefully and make a few modifications to your " + player.armorName + " to accommodate your new fins. <b>You now have shark arms.</b>", false);
	player.armType = ARM_TYPE_SHARK;
	doNext(accessMetamorphMenu);
}
private function metamorphSharkLegs():void {
	clearOutput();
	player.soulforce -= 100;
	if (player.lowerBody != LOWER_BODY_TYPE_HUMAN) restoreHumanLegs();
	outputText("\n\nYou feel something change in your feets as webing form between your toes. Well this is sure to help you swim faster. <b>You now have webed feet!</b>", false);
	player.lowerBody = LOWER_BODY_TYPE_SHARK;
	doNext(accessMetamorphMenu);
}
private function metamorphSharkTail():void {
	clearOutput();
	player.soulforce -= 100;
	if (player.tailType == TAIL_TYPE_NONE) outputText("\n\nJets of pain shoot down your spine, causing you to gasp in surprise and fall to your hands and knees. Feeling a bulging at the end of your back, you lower your " + player.armorName + " down just in time for a fully formed shark tail to burst through. You swish it around a few times, surprised by how flexible it is. After some modifications to your clothing, you're ready to go with your brand new shark tail.", false);
	else outputText("\n\nJets of pain shoot down your spine into your tail.  You feel the tail bulging out until it explodes into a large and flexible shark-tail.  You swish it about experimentally, and find it quite easy to control.", false);
	player.tailType = TAIL_TYPE_SHARK;
	doNext(accessMetamorphMenu);
}
private function metamorphSharkTeeth():void {
	clearOutput();
	player.soulforce -= 100;
	outputText("\n\n", false);
	if (player.faceType > FACE_HUMAN && player.faceType != FACE_SHARK_TEETH) outputText("Your " + player.face() + " explodes with agony, reshaping into a more human-like visage.  ", false);
	outputText("You firmly grasp your mouth, an intense pain racking your oral cavity. Your gums shift around and the bones in your jaw reset. You blink a few times wondering what just happened. You move over to a puddle to catch sight of your reflection, and you are thoroughly surprised by what you see. A set of retractable shark fangs have grown in front of your normal teeth, and your face has elongated slightly to accommodate them!  They even scare you a little.\n(Gain: 'Bite' special attack)", false);
	player.faceType = FACE_SHARK_TEETH;
	doNext(accessMetamorphMenu);
}
private function metamorphDriderLegs():void {
	clearOutput();
	player.soulforce -= 300;
	outputText("\n\nJust like when your legs changed to those of a spider-morph, you find yourself suddenly paralyzed below the waist.  Your dark, reflective legs splay out and drop you flat on your back.   Before you can sit up, you feel tiny feelers of pain mixed with warmth and tingling running through them.  Terrified at the thought of all the horrible changes that could be wracking your body, you slowly sit up, expecting to find yourself turned into some incomprehensible monstrosity from the waist down.  As if to confirm your suspicions, the first thing you see is that your legs have transformed into eight long, spindly legs.  Instead of joining directly with your hips, they now connect with the spider-like body that has sprouted in place of where your legs would normally start.  Your abdomen has gotten even larger as well.  Once the strength returns to your new, eight-legged lower body, you struggle up onto your pointed 'feet', and wobble around, trying to get your balance.  As you experiment with your new form, you find you're even able to twist the spider half of your body down between your legs in an emulation of your old, bipedal stance.  That might prove useful should you ever want to engage in 'normal' sexual positions, particularly since your " + buttDescript() + " is still positioned just above the start of your arachnid half.  <b>You're now a drider.</b>", false);
	player.lowerBody = LOWER_BODY_TYPE_DRIDER_LOWER_BODY;
	player.legCount = 8;
	doNext(accessMetamorphMenu);
}
private function metamorphSpiderTail():void {
	clearOutput();
	player.soulforce -= 100;
	outputText("\n\n", false);
	if (player.tailType > TAIL_TYPE_NONE) outputText("Your tail shudders as heat races through it, twitching violently until it feels almost as if it's on fire.  You jump from the pain at your " + buttDescript() + " and grab at it with your hands.  It's huge... and you can feel it hardening under your touches, firming up until the whole tail has become rock-hard and spherical in shape.  The heat fades, leaving behind a gentle warmth, and you realize your tail has become a spider's abdomen!  With one experimental clench, you even discover that it can shoot webs from some of its spinnerets, both sticky and non-adhesive ones.  That may prove useful.  <b>You now have a spider's abdomen hanging from above your " + buttDescript() + "!</b>\n\n", false);
	else outputText("A burst of pain hits you just above your " + buttDescript() + ", coupled with a sensation of burning heat and pressure.  You can feel your " + player.skinFurScales() + " tearing as something forces its way out of your body.  Reaching back, you grab at it with your hands.  It's huge... and you can feel it hardening under your touches, firming up until the whole tail has become rock-hard and spherical in shape.  The heat fades, leaving behind a gentle warmth, and you realize your tail has become a spider's abdomen!  With one experimental clench, you even discover that it can shoot webs from some of its spinnerets, both sticky and non-adhesive ones.  That may prove useful.  <b>You now have a spider's abdomen hanging from above your " + buttDescript() + "!</b>", false);
	player.tailType = TAIL_TYPE_SPIDER_ADBOMEN;
	player.tailVenom = 5;
	player.tailRecharge = 5;
	doNext(accessMetamorphMenu);
}
private function metamorphSpiderLegs():void {
	clearOutput();
	player.soulforce -= 100;
	if (player.lowerBody != LOWER_BODY_TYPE_HUMAN) restoreHumanLegs();
	outputText("\n\nStarting at your " + player.feet() + ", a tingle runs up your " + player.legs() + ", not stopping until it reaches your thighs.  From the waist down, your strength completely deserts you, leaving you to fall hard on your " + buttDescript() + " in the dirt.  With nothing else to do, you look down, only to be mesmerized by the sight of black exoskeleton creeping up a perfectly human-looking calf.  It crests up your knee to envelop the joint in a many-faceted onyx coating.  Then, it resumes its slow upward crawl, not stopping until it has girded your thighs in glittery, midnight exoskeleton.  From a distance it would look almost like a black, thigh-high boot, but you know the truth.  <b>You now have human-like legs covered in a black, arachnid exoskeleton.</b>", false);
	player.lowerBody = LOWER_BODY_TYPE_CHITINOUS_SPIDER_LEGS;
	doNext(accessMetamorphMenu);
}
private function metamorphSpiderArms():void {
	clearOutput();
	player.soulforce -= 100;
	outputText("\n\n", false);
	if (player.armType == ARM_TYPE_HARPY || player.armType == ARM_TYPE_HUMAN) {
		if (player.armType == ARM_TYPE_HARPY) outputText("The feathers covering your arms fall away, leaving them to return to a far more human appearance.  ", false);
		outputText("You watch, spellbound, while your forearms gradually become shiny.  The entire outer structure of your arms tingles while it divides into segments, <b>turning the " + player.skinFurScales() + " into a shiny black carapace</b>.  You touch the onyx exoskeleton and discover to your delight that you can still feel through it as naturally as your own skin.", false);
	}
	else {
		if (player.armType == ARM_TYPE_BEE) outputText("The fizz covering your upper arms starting to fall down leaving only shiny black chitin clad arms.", false);
		if (player.armType == ARM_TYPE_SALAMANDER || player.armType == ARM_TYPE_LIZARD) outputText("The sclaes covering your upper arms starting to fall down leaving only shiny black chitin clad arms.", false);
		if (player.armType == ARM_TYPE_MANTIS) outputText("The long scythe extending from your wrist crumbling, while chitin covering your mantis arms slowly starting to change colors, <b>turning the " + player.skinFurScales() + " into a shiny black carapace</b>.", false);
	}
	player.armType = ARM_TYPE_SPIDER;
	doNext(accessMetamorphMenu);
}
private function metamorphSpiderFangs():void {
	clearOutput();
	player.soulforce -= 100;
	outputText("\n\nTension builds within your upper gum, just above your canines.  You open your mouth and prod at the affected area, pricking your finger on the sharpening tooth.  It slides down while you're touching it, lengthening into a needle-like fang.  You check the other side and confirm your suspicions.  <b>You now have a pair of pointy spider-fangs, complete with their own venom!</b>", false);
	player.faceType = FACE_SPIDER_FANGS;
	doNext(accessMetamorphMenu);
}
private function metamorphSpiderFourEyes():void {
	clearOutput();
	player.soulforce -= 100;
	outputText("\n\nYou suddenly get the strangest case of double vision.  Stumbling and blinking around, you clutch at your face, but you draw your hands back when you poke yourself in the eye.  Wait, those fingers were on your forehead!  You tentatively run your fingertips across your forehead, not quite believing what you felt.  <b>There's a pair of eyes on your forehead, positioned just above your normal ones!</b>  This will take some getting used to!", false);
	player.eyeType = EYES_FOUR_SPIDER_EYES;
	doNext(accessMetamorphMenu);
}
private function metamorphElfinEars():void {
	clearOutput();
	player.soulforce -= 100;
	outputText("\n\nYour ears twitch once, twice, before starting to shake and tremble madly.  They migrate back towards where your ears USED to be, so long ago, finally settling down before twisting and stretching, changing to become <b>new, pointed elfin ears.</b>", false);
	player.earType = EARS_ELFIN;
	doNext(accessMetamorphMenu);
}
private function metamorphHarpyWings():void {
	clearOutput();
	player.soulforce -= 100;
	if (player.wingType > WING_TYPE_NONE) outputText("\n\nSensation fades from your " + player.wingDesc + " wings slowly but surely, leaving them dried out husks that break off to fall on the ground. Your back closes up to conceal the loss, as smooth and unbroken as the day you entered the portal.", false);
	outputText("\n\nPain lances through your back, the muscles knotting oddly and pressing up to bulge your " + player.skinDesc + ". It hurts, oh gods does it hurt, but you can't get a good angle to feel at the source of your agony. A loud crack splits the air, and then your body is forcing a pair of narrow limbs through a gap in your " + player.armorName + ". Blood pumps through the new appendages, easing the pain as they fill out and grow. Tentatively, you find yourself flexing muscles you didn't know you had, and <b>you're able to curve the new growths far enough around to behold your brand new, " + player.hairColor + " wings.</b>", false);
	player.wingType = WING_TYPE_FEATHERED_LARGE;
	player.wingDesc = "large, feathered";
	doNext(accessMetamorphMenu);
}
private function metamorphHarpyHair():void {
	clearOutput();
	player.soulforce -= 100;
	outputText("\n\nA tingling starts in your scalp, getting worse and worse until you're itching like mad, the feathery strands of your hair tickling your fingertips while you scratch like a dog itching a flea. When you pull back your hand, you're treated to the sight of downy fluff trailing from your fingernails. A realization dawns on you - you have feathers for hair, just like a harpy!", false);
	player.hairType = 1;
	doNext(accessMetamorphMenu);
}
private function metamorphHarpyArms():void {
	clearOutput();
	player.soulforce -= 100;
	outputText("\n\nYou smile impishly as you lick the last bits of the nut from your teeth, but when you go to wipe your mouth, instead of the usual texture of your " + player.skinDesc + " on your lips, you feel feathers! You look on in horror while more of the avian plumage sprouts from your " + player.skinDesc + ", covering your forearms until <b>your arms look vaguely like wings</b>. Your hands remain unchanged thankfully. It'd be impossible to be a champion without hands! The feathery limbs might help you maneuver if you were to fly, but there's no way they'd support you alone.", false);
	player.armType = ARM_TYPE_HARPY;
	doNext(accessMetamorphMenu);
}
private function metamorphHarpyTail():void {
	clearOutput();
	player.soulforce -= 100;
	if (player.tailType > TAIL_TYPE_NONE) outputText("\n\nYour tail shortens, folding into the crack of your " + buttDescript() + " before it disappears. A moment later, a fan of feathers erupts in its place, fluffing up and down instinctively every time the breeze shifts. <b>You have a feathery harpy tail!</b>", false);
	else outputText("\n\nA tingling tickles the base of your spine, making you squirm in place. A moment later, it fades, but a fan of feathers erupts from your " + player.skinDesc + " in its place. The new tail fluffs up and down instinctively with every shift of the breeze. <b>You have a feathery harpy tail!</b>", false);
	player.tailType = TAIL_TYPE_HARPY;
	doNext(accessMetamorphMenu);
}
private function metamorphHarpyLegs():void {
	clearOutput();
	player.soulforce -= 100;
	if (!player.isGoo()) outputText("\n\nYour " + player.legs() + " creak ominously a split-second before they go weak and drop you on the ground. They go completely limp, twisting and reshaping before your eyes in ways that make you wince. Your lower body eventually stops, but the form it's settled on is quite thick in the thighs. Even your " + player.feet() + " have changed.  ", false);
	else outputText("\n\nYour gooey undercarriage loses some of its viscosity, dumping you into the puddle that was once your legs. As you watch, the fluid pulls together into a pair of distinctly leg-like shapes, solidifying into a distinctly un-gooey form. You've even regained a pair of feet!  ", false);
	outputText("While humanoid in shape, they have two large, taloned toes on the front and a single claw protruding from the heel. The entire ensemble is coated in " + player.hairColor + " feathers from ankle to hip, reminding you of the bird-women of the mountains. <b>You now have harpy legs!</b>", false);
	player.lowerBody = LOWER_BODY_TYPE_HARPY;
	player.legCount = 2;
	doNext(accessMetamorphMenu);
}
private function metamorphBeeWingsLarge():void {
	clearOutput();
	player.soulforce -= 200;
	outputText("\n\nYour wings tingle as they grow, filling out until they are large enough to lift you from the ground and allow you to fly!  <b>You now have large bee wings!</b>  You give a few experimental flaps and begin hovering in place, a giddy smile plastered on your face by the thrill of flight.");
	player.wingType = WING_TYPE_BEE_LIKE_LARGE;
	player.wingDesc = "large bee-like";
	doNext(accessMetamorphMenu);
}
private function metamorphBeeWingsSmall():void {
	clearOutput();
	player.soulforce -= 100;
	outputText("\n\nYou feel an itching between your shoulder-blades as something begins growing there.  You twist and contort yourself, trying to scratch and bring yourself relief, and failing miserably.  A sense of relief erupts from you as you feel something new grow out from your body.  You hastily remove the top portion of your " + player.armorName + " and marvel as a pair of small bee-like wings sprout from your back.  Tenderly flexing your new muscles, you find you can flap them quite fast.  Unfortunately you can't seem to flap your little wings fast enough to fly, but they would certainly slow a fall.  A few quick modifications to your " + player.armorName + " later and you are ready to continue your journey with <b>your new bee wings</b>.");
	player.wingType = WING_TYPE_BEE_LIKE_SMALL;
	player.wingDesc = "small bee-like";
	doNext(accessMetamorphMenu);
}
private function metamorphBeeTail():void {
	clearOutput();
	player.soulforce -= 100;
	if (player.tailType > TAIL_TYPE_NONE) outputText("\n\nPainful swelling just above your " + buttDescript() + " doubles you over, and you hear the sound of your tail dropping off onto the ground!  Before you can consider the implications, the pain gets worse, and you feel your backside bulge outward sickeningly, cracking and popping as a rounded bee-like abdomen grows in place of your old tail.  It grows large enough to be impossible to hide, and with a note of finality, your stinger slides free with an audible 'snick'.");
	else outputText("\n\nPainful swelling just above your " + buttDescript() + " doubles you over.  It gets worse and worse as the swollen lump begins to protrude from your backside, swelling and rounding with a series of pops until you have a bulbous abdomen hanging just above your butt.  The whole thing is covered in a hard chitinous material, and large enough to be impossible to hide.  You sigh as your stinger slides into place with a 'snick', finishing the transformation.  <b>You have a bee's abdomen.</b>");
	player.tailType = TAIL_TYPE_BEE_ABDOMEN;
	player.tailVenom = 10;
	player.tailRecharge = 2;
	doNext(accessMetamorphMenu);
}
private function metamorphBeeArms():void {
	clearOutput();
	player.soulforce -= 100;
	if (player.armType == ARM_TYPE_HARPY || player.armType == ARM_TYPE_HUMAN) {
		if (player.armType == ARM_TYPE_HARPY) outputText("The feathers covering your arms fall away, leaving them to return to a far more human appearance.  ");
		outputText("You watch, spellbound, while your forearms gradually become shiny.  The entire outer structure of your arms tingles while it divides into segments, <b>turning the " + player.skinFurScales() + " into a shiny black carapace</b>.  A moment later the pain fades and you are able to turn your gaze down to your beautiful new arms, covered in shining black chitin from the upper arm down, and downy yellow fuzz along your upper arm.");
	}
	else {
		if (player.armType == ARM_TYPE_SPIDER) outputText("On your upper arms slowly starting to grown yellow fuzz making them looks more like those of bee.");
		if (player.armType == ARM_TYPE_MANTIS) outputText("The long scythe extending from your wrist crumbling, while chitin covering your mantis arms slowly starting to change colors, <b>turning the " + player.skinFurScales() + " into a shiny black carapace</b>. Additionaly on your upper arms appear yellow fuzz.");
	}
	player.armType = ARM_TYPE_BEE;
	doNext(accessMetamorphMenu);
}
private function metamorphBeeLegs():void {
	clearOutput();
	player.soulforce -= 100;
	if (player.lowerBody != LOWER_BODY_TYPE_HUMAN) restoreHumanLegs();
	outputText("\n\nYour legs tremble with sudden unbearable pain, as if they're being ripped apart from the inside out and being stitched together again all at once.  You scream in agony as you hear bones snapping and cracking.  A moment later the pain fades and you are able to turn your gaze down to your beautiful new legs, covered in shining black chitin from the thigh down, and downy yellow fuzz along your upper thighs.");
	player.lowerBody = LOWER_BODY_TYPE_BEE;
	doNext(accessMetamorphMenu);
}
private function metamorphBeeAntennae():void {
	clearOutput();
	player.soulforce -= 100;
	if (player.antennae == ANTENNAE_MANTIS) outputText("\n\nYour head itches momentarily as your two long prehensile antennae changes slowly into floppy ones similar to those seen at bees.");
	else outputText("\n\nYour head itches momentarily as two floppy antennae sprout from your " + hairDescript() + ".");
	player.antennae = ANTENNAE_BEE;
	doNext(accessMetamorphMenu);
}
private function metamorphLizardFace():void {
	clearOutput();
	player.soulforce -= 100;
	outputText("\n\nTerrible agony wracks your " + player.face() + " as bones crack and shift.  Your jawbone rearranges while your cranium shortens.  The changes seem to last forever; once they've finished, no time seems to have passed.  Your fingers brush against your toothy snout as you get used to your new face.  It seems <b>you have a toothy, reptilian visage now.</b>", false);
	player.faceType = FACE_LIZARD;
	doNext(accessMetamorphMenu);
}
private function metamorphLizardEars():void {
	clearOutput();
	player.soulforce -= 100;
	outputText("\n\nTightness centers on your scalp, pulling your ears down from their normal, fleshy shape into small, scaley bumps with holes in their centers.  <b>You have reptilian ears!</b>", false);
	player.earType = EARS_LIZARD;
	doNext(accessMetamorphMenu);
}
private function metamorphLizardEyes():void {
	clearOutput();
	player.soulforce -= 100;
	if (player.eyeType != EYES_HUMAN) removeOddEyes();
	outputText("\n\nYou suddenly feel your vision shifting. It takes a moment for you to adapt to the weird sensory changes but once you recover you go to a puddle and notice your eyes now have a slitted pupil like that of a reptile taking on a yellow hue with a slit.  <b>You now have reptilian eyes!</b>");
	player.eyeType = EYES_REPTILIAN;
	doNext(accessMetamorphMenu);
}
private function metamorphLizardTail():void {
	clearOutput();
	player.soulforce -= 100;
	if (player.tailType == TAIL_TYPE_NONE) outputText("\n\nYou drop onto the ground as your spine twists and grows, forcing the flesh above your " + assDescript() + " to bulge out.  New bones form, one after another, building a tapered, prehensile tail onto the back of your body.  <b>You now have a reptilian tail!</b>", false);
	else outputText("\n\nYou drop to the ground as your tail twists and grows, changing its shape in order to gradually taper to a point.  It flicks back and forth, prehensile and totally under your control.  <b>You now have a reptilian tail.</b>", false);
	player.tailType = TAIL_TYPE_LIZARD;
	doNext(accessMetamorphMenu);
}
private function metamorphLizardArms():void {
	clearOutput();
	player.soulforce -= 100;
	outputText("\n\nYou scratch at your biceps absentmindedly, but no matter how much you scratch, it isn't getting rid of the itch.  After longer moment of ignoring it you finaly glancing down in irritation, only to discover that your arms former appearance changed into this of lizard one with leathery scales and short claws replacing your fingernails.  <b>You now have a lizard arms.</b>", false);
	player.armType = ARM_TYPE_LIZARD;
	doNext(accessMetamorphMenu);
}
private function metamorphLizardLegs():void {
	clearOutput();
	player.soulforce -= 100;
	if (player.lowerBody == LOWER_BODY_TYPE_HOOFED) outputText("\n\nYou scream in agony as you feel your hooves crack and break apart, beginning to rearrange.  Your legs change to a digitigrade shape while your feet grow claws and shift to have three toes on the front and a smaller toe on the heel.", false);
	else if (player.isTaur()) outputText("\n\nYour lower body is wracked by pain!  Once it passes, you discover that you're standing on digitigrade legs with lizard-like claws.", false);
	else if (player.lowerBody == LOWER_BODY_TYPE_HUMAN || player.lowerBody == LOWER_BODY_TYPE_DOG || player.lowerBody == LOWER_BODY_TYPE_DEMONIC_HIGH_HEELS || player.lowerBody == LOWER_BODY_TYPE_DEMONIC_CLAWS || player.lowerBody == LOWER_BODY_TYPE_PLANT_HIGH_HEELS || player.lowerBody == LOWER_BODY_TYPE_PLANT_ROOT_CLAWS || player.lowerBody == LOWER_BODY_TYPE_BEE || player.lowerBody == LOWER_BODY_TYPE_CAT || player.lowerBody == LOWER_BODY_TYPE_LIZARD) outputText("\n\nYou scream in agony as you feel the bones in your legs break and begin to rearrange. They change to a digitigrade shape while your feet grow claws and shift to have three toes on the front and a smaller toe on the heel.", false);
	else outputText("\n\nPain rips through your " + player.legs() + ", morphing and twisting them until the bones rearrange into a digitigrade configuration.  The strange legs have three-toed, clawed feet, complete with a small vestigial claw-toe on the back for added grip.", false);
	outputText("  <b>You have reptilian legs and claws!</b>", false);
	player.lowerBody = LOWER_BODY_TYPE_LIZARD;
	player.legCount = 2;
	doNext(accessMetamorphMenu);
}
private function metamorphHornsDraconicX4():void {
	clearOutput();
	player.soulforce -= 200;
	outputText("\n\nA second row of horns erupts under the first, and though they are narrower, they grow nearly as long as your first row before they stop.  A sense of finality settles over you.  <b>You have as many horns as a lizan can grow.</b>", false);
	player.horns = 12;
	player.hornType = HORNS_DRACONIC_X4_12_INCH_LONG;
	doNext(accessMetamorphMenu);
}
private function metamorphHornsDraconicX2():void {
	clearOutput();
	player.soulforce -= 100;
	outputText("\n\nYou feel your horns changing and warping, and reach back to touch them.  They have a slight curve and a gradual taper.  They must look something like the horns the dragons in your village's legends always had.", false);
	player.horns = 4;
	player.hornType = HORNS_DRACONIC_X2;
	doNext(accessMetamorphMenu);
}
private function metamorphWingsDemonicLarge2():void {
	clearOutput();
	player.soulforce -= 300;
	outputText("\n\nYour large demonic wings starts to tremble and then starts to split from the tip.  You stretch over your shoulder to stroke them as they divide, turning into two pairs of full-sized demon-wings.  <b>Your demonic wings have splited into two pairs!</b>", false);
	player.wingType = WING_TYPE_BAT_LIKE_LARGE_2;
	player.wingDesc = "two large pairs of bat-like";
	doNext(accessMetamorphMenu);
}
private function metamorphWingsDemoncLarge():void {
	clearOutput();
	player.soulforce -= 200;
	outputText("\n\nYour small demonic wings stretch and grow, tingling with the pleasure of being attached to such a tainted body.  You stretch over your shoulder to stroke them as they unfurl, turning into full-sized demon-wings.  <b>Your demonic wings have grown!</b>", false);
	player.wingType = WING_TYPE_BAT_LIKE_LARGE;
	player.wingDesc = "large, bat-like";
	doNext(accessMetamorphMenu);
}
private function metamorphWingsDemonicTiny():void {
	clearOutput();
	player.soulforce -= 100;
	if (player.wingType != WING_TYPE_NONE) removeOldWings();
	outputText("\n\nA knot of pain forms in your shoulders as they tense up.  With a surprising force, a pair of small demonic wings sprout from your back, ripping a pair of holes in the back of your " + player.armorName + ".  <b>You now have tiny demonic wings</b>.", false);
	player.wingType = WING_TYPE_BAT_LIKE_TINY;
	player.wingDesc = "tiny, bat-like";
	doNext(accessMetamorphMenu);
}
private function metamorphLegsDemonicClaws():void {
	clearOutput();
	player.soulforce -= 100;
	if (player.lowerBody != LOWER_BODY_TYPE_HUMAN) restoreHumanLegs();
	outputText("\n\n", false);
	outputText("Every muscle and sinew below your hip tingles and you begin to stagger. Seconds after you sit down, pain explodes in your " + player.feet() + ". Something hard breaks through your sole from the inside out as your toes splinter and curve cruelly. The pain slowly diminishes and your eyes look along a human leg that splinters at the foot into a claw with sharp black nails. When you relax, your feet grip the ground easily. <b>Your feet are now formed into demonic claws.</b>", false);
	player.lowerBody = LOWER_BODY_TYPE_DEMONIC_CLAWS;
	doNext(accessMetamorphMenu);
}
private function metamorphLegsDemonicHighHeels():void {
	clearOutput();
	player.soulforce -= 100;
	if (player.lowerBody != LOWER_BODY_TYPE_HUMAN) restoreHumanLegs();
	outputText("\n\n", false);
	outputText("Every muscle and sinew below your hip tingles and you begin to stagger. Seconds after you sit down, pain explodes in your " + player.feet() + ". Something hard breaks through your sole from the inside out. The pain slowly diminishes and your eyes look along a human leg to a thin and sharp horn protruding from the heel. When you relax, your feet are pointing down and their old posture is only possible with an enormous effort. <b>Your feet are now formed into demonic high-heels.</b> Tentatively you stand up and try to take a few steps. To your surprise you feel as if you were born with this and stride vigorously forward, hips swaying.", false);
	player.lowerBody = LOWER_BODY_TYPE_DEMONIC_HIGH_HEELS;
	doNext(accessMetamorphMenu);
}
private function metamorphTonugeDemonic():void {
	clearOutput();
	player.soulforce -= 100;
	outputText("\n\n", false);
	outputText("Your snake-like tongue tingles, thickening in your mouth until it feels more like your old human tongue, at least for the first few inches.  It bunches up inside you, and when you open up your mouth to release it, roughly two feet of tongue dangles out.  You find it easy to move and control, as natural as walking.  <b>You now have a long demon-tongue.</b>", false);
	player.tongueType = TONUGE_DEMONIC;
	doNext(accessMetamorphMenu);
}
private function metamorphHornsDemonic():void {
	clearOutput();
	player.soulforce -= 100;
	if (player.horns < 12 && (player.hornType == HORNS_NONE || player.hornType == HORNS_DEMON)) {
		outputText("\n\n", false);
		if (player.horns == 0) {
			outputText("A small pair of demon horns erupts from your forehead.  They actually look kind of cute.  <b>You have horns!</b>", false);
		}
		else outputText("Another pair of demon horns, larger than the last, forms behind the first row.", false);
		if (player.hornType == HORNS_NONE) player.hornType = HORNS_DEMON;
		player.horns++;
		player.horns++;
	}
	else if (player.hornType > HORNS_DEMON && player.hornType != HORNS_ORCHID) {
		outputText("\n\n", false);
		outputText("Your horns shift, shrinking into two small demonic-looking horns.", false);
		player.horns = 2;
		player.hornType = HORNS_DEMON;
	}
	doNext(accessMetamorphMenu);
}
private function metamorphTailDemonic():void {
	clearOutput();
	player.soulforce -= 100;
	if (player.tailType != TAIL_TYPE_NONE) {
		outputText("\n\n", false);
		if (player.tailType == TAIL_TYPE_SPIDER_ADBOMEN || player.tailType == TAIL_TYPE_BEE_ABDOMEN) outputText("You feel a tingling in your insectile abdomen as it stretches, narrowing, the exoskeleton flaking off as it transforms into a flexible demon-tail, complete with a round spaded tip.  ", false);
		else outputText("You feel a tingling in your tail.  You are amazed to discover it has shifted into a flexible demon-tail, complete with a round spaded tip.  ", false);
		outputText("<b>Your tail is now demonic in appearance.</b>", false);
	}
	else outputText("\n\nA pain builds in your backside... growing more and more pronounced.  The pressure suddenly disappears with a loud ripping and tearing noise.  <b>You realize you now have a demon tail</b>... complete with a cute little spade.", false);
	player.tailType = TAIL_TYPE_DEMONIC;
	doNext(accessMetamorphMenu);
}
private function metamorphKitsuneArms():void {
	clearOutput();
	player.soulforce -= 100;
	if (player.armType != ARM_TYPE_HUMAN) restoreHumanArms();
	outputText("\n\n Your finger tingle as your nails sharpen to point. You run them on a tree bark and they feel way harder than your old human nails. <b>You will be able to claw at your opponent with your sharp kitsune nails.</b>", false);
	player.armType = ARM_TYPE_KITSUNE;
	doNext(accessMetamorphMenu);
}
private function metamorphTailFox6th():void {
	clearOutput();
	player.soulforce -= 600;
	outputText("A tingling pressure builds on your backside, and your bushy tails begin to glow with an eerie, ghostly light.  With a crackle of electrical energy, one of your tails splits in two, giving you " + num2Text(player.tailCount + 1) + "!  <b>You now have a cluster of " + num2Text(player.tailCount + 1) + " fox-tails.</b>");
	player.tailCount++;
	doNext(accessMetamorphMenu);
}
private function metamorphTailFox5th():void {
	clearOutput();
	player.soulforce -= 500;
	outputText("A tingling pressure builds on your backside, and your bushy tails begin to glow with an eerie, ghostly light.  With a crackle of electrical energy, one of your tails splits in two, giving you " + num2Text(player.tailCount + 1) + "!  <b>You now have a cluster of " + num2Text(player.tailCount + 1) + " fox-tails.</b>");
	player.tailCount++;
	doNext(accessMetamorphMenu);
}
private function metamorphTailFox4th():void {
	clearOutput();
	player.soulforce -= 400;
	outputText("A tingling pressure builds on your backside, and your bushy tails begin to glow with an eerie, ghostly light.  With a crackle of electrical energy, one of your tails splits in two, giving you " + num2Text(player.tailCount + 1) + "!  <b>You now have a cluster of " + num2Text(player.tailCount + 1) + " fox-tails.</b>");
	player.tailCount++;
	doNext(accessMetamorphMenu);
}
private function metamorphTailFox3rd():void {
	clearOutput();
	player.soulforce -= 300;
	outputText("A tingling pressure builds on your backside, and your bushy tails begin to glow with an eerie, ghostly light.  With a crackle of electrical energy, one of your tails splits in two, giving you " + num2Text(player.tailCount + 1) + "!  <b>You now have a cluster of " + num2Text(player.tailCount + 1) + " fox-tails.</b>");
	player.tailCount++;
	doNext(accessMetamorphMenu);
}
private function metamorphTailFox2nd():void {
	clearOutput();
	player.soulforce -= 200;
	outputText("A tingling pressure builds on your backside, and your bushy tail begins to glow with an eerie, ghostly light.  With a crackle of electrical energy, your tail splits into two!  <b>You now have a pair of fox-tails.</b>");
	player.tailCount++;
	doNext(accessMetamorphMenu);
}
private function metamorphEyesFox():void {
	clearOutput();
	player.soulforce -= 100;
	outputText("You blink for an instant as the light and darkness seems to shift within your vision. You head to a pool to check it up and notice your pupils shifted to look more fox-like in a fashion similar to the kitsunes.  <b>You now have fox pupils.</b>");
	player.eyeType = EYES_FOX;
	doNext(accessMetamorphMenu);
}
private function metamorphFaceFox():void {
	clearOutput();
	player.soulforce -= 100;
	outputText("Your face pinches and you clap your hands to it.  Within seconds, your nose is poking through those hands, pushing them slightly to the side as new flesh and bone build and shift behind it, until it stops in a clearly defined, tapered, and familiar point you can see even without the aid of a mirror.  <b>Looks like you now have a fox's face.</b>");
	player.faceType = FACE_FOX;
	doNext(accessMetamorphMenu);
}
private function metamorphTailFox():void {
	clearOutput();
	player.soulforce -= 100;
	if (player.tailType == TAIL_TYPE_NONE) outputText("A pressure builds on your backside.  You feel under your [armor] and discover a strange nodule growing there that seems to be getting larger by the second.  With a sudden flourish of movement, it bursts out into a long and bushy tail that sways hypnotically, as if it had a mind of its own.  <b>You now have a fox's tail!</b>");
	else outputText("Pain lances through your lower back as your tail shifts violently.  With one final aberrant twitch, it fluffs out into a long, bushy fox tail that whips around in an almost hypnotic fashion.  <b>You now have a fox's tail!</b>");
	player.tailType = TAIL_TYPE_FOX;
	player.tailCount = 1;
	doNext(accessMetamorphMenu);
}
private function metamorphEarsFox():void {
	clearOutput();
	player.soulforce -= 100;
	if (player.earType == EARS_HUMAN || player.earType == EARS_ELFIN || player.earType == EARS_LIZARD) {
		outputText("The sides of your face painfully stretch as your ears elongate and begin to push past your hairline, toward the top of your head.  They elongate, becoming large vulpine triangles covered in bushy fur.  <b>You now have fox ears.</b>");
	}
	else {
		outputText("Your ears change, shifting from their current shape to become vulpine in nature.  <b>You now have fox ears.</b>");
	}
	player.earType = EARS_FOX;
	doNext(accessMetamorphMenu);
}
private function metamorphArmsFox():void {
	clearOutput();
	player.soulforce -= 100;
	if (player.armType != ARM_TYPE_HUMAN) restoreHumanArms();
	outputText("Your arms and hands start covering in fur at an alarming rate suddenly as you poke at your palms you jolt up as they become extremely sensitive turning into paw pads heck your nails transformed into wolf like claws so no wonder you felt it that much. <b>You now have pawed hands.</b>", false);
	player.armType = ARM_TYPE_FOX;
	doNext(accessMetamorphMenu);
}
private function metamorphLowerBodyFox():void {
	clearOutput();
	player.soulforce -= 100;
	if (player.isTaur()) outputText("You shiver as the strength drains from your back legs.  Shaken, you sit on your haunches, forelegs braced wide to stop you from tipping over;  their hooves scrape the dirt as your lower body shrinks, dragging them backward until you can feel the upper surfaces of your hindlegs with their undersides.  A wave of nausea and vertigo overtakes you, and you close your eyes to shut out the sensations.  When they reopen, what greets them are not four legs, but only two... and those roughly in the shape of your old hindleg, except for the furry toes where your hooves used to be.  <b>You now have fox legs!</b>");
	else if (player.isNaga()) outputText("Your scales split at the waistline and begin to peel, shedding like old snakeskin.  If that weren't curious enough, the flesh - not scales - underneath is pink and new, and the legs it covers crooked into the hocks and elongated feet of a field animal.  As the scaly coating falls and you step out of it, walking of necessity on your toes, a fine powder blows from the dry skin.  Within minutes, it crumbles completely and is taken by the ever-moving wind.  <b>Your legs are now those of a fox!</b>");
	else if (player.lowerBody == LOWER_BODY_TYPE_HOOFED || player.lowerBody == LOWER_BODY_TYPE_DOG || player.lowerBody == LOWER_BODY_TYPE_CAT || player.lowerBody == LOWER_BODY_TYPE_BUNNY || player.lowerBody == LOWER_BODY_TYPE_KANGAROO) {
		outputText("Your legs twitch and quiver, forcing you to your seat.  As you watch, the ends shape themselves into furry, padded toes.  <b>You now have fox feet!</b>  Rather cute ones, actually.");
	}
	else if (player.lowerBody == LOWER_BODY_TYPE_DRIDER_LOWER_BODY) outputText("Your legs buckle under you and you fall, smashing your abdomen on the ground.  Though your control deserts and you cannot see behind you, still you feel the disgusting sensation of chitin loosening and sloughing off your body, and the dry breeze on your exposed nerves.  Reflexively, your legs cling together to protect as much of their now-sensitive surface as possible.  When you try to part them, you find you cannot.  Several minutes pass uncomforably until you can again bend your legs, and when you do, you find that all the legs of a side bend together - <b>in the shape of a fox's leg!</b>");
	else if (player.isGoo()) outputText("It takes a while before you notice that your gooey mounds have something more defined in them.  As you crane your body and shift them around to look, you can just make out a semi-solid mass in the shape of a crooked, animalistic leg.  You don't think much of it until, a few minutes later, you step right out of your swishing gooey undercarriage and onto the new foot.  The goo covering it quickly dries up, as does the part you left behind, <b>revealing a pair of dog-like fox legs!</b>");
	else {
		outputText("Your hamstrings tense painfully and begin to pull, sending you onto your face.  As you writhe on the ground, you can feel your thighs shortening and your feet stretching");
		if (player.lowerBody == LOWER_BODY_TYPE_BEE) outputText(", while a hideous cracking fills the air");
		outputText(".  When the spasms subside and you can once again stand, <b>you find that your legs have been changed to those of a fox!</b>");
	}
	player.lowerBody = LOWER_BODY_TYPE_FOX;
	player.legCount = 2;
	doNext(accessMetamorphMenu);
}
private function metamorphFishGills():void {
	clearOutput();
	player.soulforce -= 100;
	if (player.gillType == GILLS_ANEMONE) {
		outputText("\n\nYou feel your gills tingle, a vague numbness registering across thier feathery exterior. You watch in awe as"
		           +" your gill's feathery folds dry out and fall off like crisp autumn leaves. The slits of your gills then"
		           +" rearrange themselves, becoming thinner and shorter, as they shift to the sides of your neck. They now close in"
		           +" a way that makes them almost invisible. As you run a finger over your neck you feel little more than several"
		           +" small raised lines where they meet your skin.");
	}
	else {
		outputText("\n\nYou feel a sudden tingle on your neck. You reach up to it to feel, whats the source of it. When you touch"
		           +" your neck, you feel that it begins to grow serveral narrow slits which slowly grow longer. After the changes"
		           +" have stopped you quickly head to a nearby puddle to take a closer look at your neck. You realize,"
		           +" that your neck has grown gills allowing you to breathe under water as if you were standing on land.");
	}
	outputText("\n\n<b>You now have fish like gills!</b>");
	player.gillType = GILLS_FISH;
	doNext(accessMetamorphMenu);
}
//all skin types TF effects goes here
/*private function metamorphTattoed():void {
	clearOutput();
	player.soulforce -= 100;
	
	doNext(accessMetamorphMenu);
}*/
private function metamorphChitin():void {
	clearOutput();
	player.soulforce -= 100;
	var chitinColor:String;
	if (rand(2) == 0) chitinColor = "pale white";
	else chitinColor = "green";
	if (player.hasCoat()) {
		outputText("\n\nA slowly-building itch spreads over your whole body, and as you idly scratch yourself, you find that your [skin coat] [skin coat.isare] falling to the ground, revealing flawless, " + chitinColor + " chitin underneath.", false);
	} else {
		outputText("\n\nA slowly-building itch spreads over your whole body, and as you idly scratch yourself, you find that your skin stating to harden turning slowly into chitin.", false);
	}
	outputText("  <b>You now have " + chitinColor + " chitin exoskeleton covering your body.</b>", false);
	player.skin.growCoat(SKIN_COAT_CHITIN,{adj:"",color:chitinColor});
	doNext(accessMetamorphMenu);
}
private function metamorphScales():void {
	clearOutput();
	player.soulforce -= 100;
	if (player.skinType == SKIN_TYPE_FUR) {
		if (rand(10) == 0) {
			if (rand(2) == 0) player.skinTone = "purple";
			else player.skinTone = "silver";
		}
		else {
			temp = rand(5);
			if (temp == 0) player.skinTone = "red";
			else if (temp == 1) player.skinTone = "green";
			else if (temp == 2) player.skinTone = "white";
			else if (temp == 3) player.skinTone = "blue";
			else player.skinTone = "black";
		}
		outputText("\n\nYou scratch yourself, and come away with a large clump of " + player.furColor + " fur.  Panicked, you look down and realize that your fur is falling out in huge clumps.  It itches like mad, and you scratch your body relentlessly, shedding the remaining fur with alarming speed.  Underneath the fur your skin feels incredibly smooth, and as more and more of the stuff comes off, you discover a seamless layer of " + player.skinTone + " scales covering most of your body.  The rest of the fur is easy to remove.  <b>You're now covered in scales from head to toe.</b>", false);
	}
	else {
		outputText("\n\nYou idly reach back to scratch yourself and nearly jump out of your " + player.armorName + " when you hit something hard.  A quick glance down reveals that scales are growing out of your " + player.skinTone + " skin with alarming speed.  As you watch, the surface of your skin is covered in smooth scales.  They interlink together so well that they may as well be seamless.  You peel back your " + player.armorName + " and the transformation has already finished on the rest of your body.  <b>You're covered from head to toe in shiny ", false);
		if (rand(10) == 0) {
			if (rand(2) == 0) player.skinTone = "purple";
			else player.skinTone = "silver";
		}
		else {
			temp = rand(5);
			if (temp == 0) player.skinTone = "red";
			else if (temp == 1) player.skinTone = "green";
			else if (temp == 2) player.skinTone = "white";
			else if (temp == 3) player.skinTone = "blue";
			else player.skinTone = "black";
		}
		outputText(player.skinTone + " scales.</b>", false);
	}
	player.skinType = SKIN_TYPE_SCALES;
	player.skinDesc = "scales";
	doNext(accessMetamorphMenu);
}
private function metamorphFur():void {
	clearOutput();
	player.soulforce -= 100;
	if (player.skinType == SKIN_TYPE_SCALES) outputText("Your skin shifts and every scale stands on end, sending you into a mild panic.  No matter how you tense, you can't seem to flatten them again.  The uncomfortable sensation continues for some minutes until, as one, every scale falls from your body and a fine coat of fur pushes out.  You briefly consider collecting them, but when you pick one up, it's already as dry and brittle as if it were hundreds of years old.  <b>Oh well; at least you won't need to sun yourself as much with your new fur.</b>");
	else outputText("Your skin itches all over, the sudden intensity and uniformity making you too paranoid to scratch.  As you hold still through an agony of tiny tingles and pinches, fine, luxuriant fur sprouts from every bare inch of your skin!  <b>You'll have to get used to being furry...</b>");
	player.skinType = SKIN_TYPE_FUR;
	player.skinAdj = "";
	player.skinDesc = "fur";
	doNext(accessMetamorphMenu);
}

private function removeOddEyes():void {
	if (player.eyeType == EYES_BLACK_EYES_SAND_TRAP) {
		outputText("\n\nYou feel a twinge in your eyes and you blink.  It feels like black cataracts have just fallen away from you, and you know without needing to see your reflection that your eyes have gone back to looking human.");
	}
	else {
		outputText("\n\nYou blink and stumble, a wave of vertigo threatening to pull your " + player.feet() + " from under you.  As you steady and open your eyes, you realize something seems different.  Your vision is changed somehow.", false);
		if (player.eyeType == EYES_FOUR_SPIDER_EYES) outputText("  Your multiple, arachnid eyes are gone!</b>", false);
		outputText("  <b>You have normal, humanoid eyes again.</b>", false);
	}
	player.eyeType = EYES_HUMAN;
}
private function removeOldWings():void {
	outputText("\n\nSensation fades from your " + player.wingDesc + " wings slowly but surely, leaving them dried out husks that break off to fall on the ground. Your back closes up to conceal the loss, as smooth and unbroken as the day you entered the portal.", false);
	player.wingType = WING_TYPE_NONE;
	player.wingDesc = "non-existant";
}
private function restoreHumanLegs():void {
	if (player.isTaur()) {
		outputText("\n\nYour quadrupedal hind-quarters seizes, overbalancing your surprised front-end and causing you to stagger and fall to your side.  Pain lances throughout, contorting your body into a tightly clenched ball of pain while tendons melt and bones break, melt, and regrow.  When it finally stops, <b>you look down to behold your new pair of human legs</b>!", false);
	}
	else {
		if (player.isGoo()) {
			outputText("\n\nYour lower body rushes inward, molding into two leg-like shapes that gradually stiffen up.  In moments they solidify into normal-looking legs, complete with regular, human feet.", false);
		}
		if (player.isNaga()) {
			outputText("\n\nYou collapse as your sinuous snake-tail tears in half, shifting into legs.  The pain is immense, particularly where your new feet are forming.", false);
		}
		if (player.isScylla()) {
			outputText("\n\nYou collapse as your tentacle legs starts to merge.  The pain is immense, particularly where your new feet are forming.", false);
		}
		//(Non-human -> Normal Human Legs)
		if (player.isBiped() && player.lowerBody != LOWER_BODY_TYPE_HUMAN) {
			outputText("\n\nYou collapse as your legs shift and twist.  By the time the pain subsides, you notice that you have normal legs and normal feet.", false);
		}
		outputText("  <b>You now have normal feet!</b>", false);
	}
	player.lowerBody = LOWER_BODY_TYPE_HUMAN;
	player.legCount = 2;
}
private function restoreHumanArms():void {
	outputText("You scratch at your biceps absentmindedly, but no matter how much you scratch, it isn't getting rid of the itch.  Glancing down in irritation, you discover that your ", false);
	if (player.armType == ARM_TYPE_HARPY || player.armType == ARM_TYPE_PHOENIX) {
		outputText("feathery arms are shedding their feathery coating.  The wing-like shape your arms once had is gone in a matter of moments, leaving " + player.skinDesc + " behind.", false);
	}
	if (player.armType == ARM_TYPE_SPIDER) {
		outputText("arms' chitinous covering is flaking away.  The glossy black coating is soon gone, leaving " + player.skinDesc + " behind.", false);
	}
	if (player.armType == ARM_TYPE_MANTIS) {
		outputText("arms' chitinous covering is flaking away and scythe shrinking until it vanish completly.  The glossy green coating is soon gone, leaving " + player.skinDesc + " behind.", false);
	}
	if (player.armType == ARM_TYPE_BEE) {
		outputText("arms' chitinous covering and fuzz is flaking away.  The glossy black and yellow coating is soon gone, leaving " + player.skinDesc + " behind.", false);
	}
	if (player.armType == ARM_TYPE_SALAMANDER || player.armType == ARM_TYPE_LIZARD) {
		outputText("arms' scales are flaking away.  The leathery ", false);
		if (player.armType == ARM_TYPE_SALAMANDER) outputText("red ", false);
		outputText("scales are soon gone, leaving " + player.skinDesc + " behind.", false);
	}
	if (player.armType == ARM_TYPE_PLANT) {
		outputText("arms' vines are withering.  Leaves also falling donw, leaving " + player.skinDesc + " behind.", false);
	}
	if (player.armType == ARM_TYPE_SHARK) {
		outputText("arms' fin suddenly fell down, leaving " + player.skinDesc + " behind.  Also webbing between your fingers slowly disappearing.", false);
	}
	if (player.armType == ARM_TYPE_WOLF || player.armType == ARM_TYPE_FOX) {
		outputText("arms' " + player.furColor + " fur is flaking away, leaving " + player.skinDesc + " behind.  Also the claws on your fingers reverts back into ordinary nails.", false);
	}
	if (player.armType == ARM_TYPE_KITSUNE) {
		outputText("arms' claws retracting back into ordinary nails. You hand looks human again.", false);
	}
	outputText("\n\n", false);
	player.armType = ARM_TYPE_HUMAN;
}
	}
}