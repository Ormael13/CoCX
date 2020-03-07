/**
 * ...
 * @author Ormael
 */
package classes.Scenes.NPCs 
{
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.Items.Shield;
import classes.Items.Weapon;

	public class AetherTwinsFollowers extends NPCAwareContent
	{
		
		public function AetherTwinsFollowers() 
		{}

public function aethertwinsFollowers():void {
	clearOutput();
	outputText("You walk over to Aether Twins resting place.  Seeing you approach, the sentient weapon"+(flags[kFLAGS.AETHER_DEXTER_TWIN_AT_CAMP] == 2 || flags[kFLAGS.AETHER_SINISTER_TWIN_AT_CAMP] == 2 ? "":"s")+" turns the golem "+(flags[kFLAGS.AETHER_DEXTER_TWIN_AT_CAMP] == 2 || flags[kFLAGS.AETHER_SINISTER_TWIN_AT_CAMP] == 2 ? "it":"they")+" used as temporal host in your direction.\n\n");
	outputText("\"<i>Hey there, [name]! Need anything while we're safe at camp?</i>\"\n\n");
	menu();
	//if (flags[kFLAGS.CAMP_UPGRADES_SPARING_RING] >= 2) addButton(1, "Spar", valeriaSpar).hint("Do a quick battle with Valeria!");
	//if (player.lust >= 33) addButton(2, "Sex", followersValeriaSex).hint("Initiate sexy time with the armor-goo.");
	if (flags[kFLAGS.AETHER_DEXTER_TWIN_AT_CAMP] == 1) addButton(10, "Take", takeAetherD).hint(weapons.AETHERD.description);
	if (flags[kFLAGS.AETHER_SINISTER_TWIN_AT_CAMP] == 1) addButton(11, "Take", takeAetherS).hint(shields.AETHERS.description);
	//addButton(12, "Appearance", valeriaAppearance).hint("Examine Aether Twins appearance.");
	//addButton(13, "Talk", talkWithValeria).hint("Discuss with Aether Twins.");
	addButton(14, "Back", camp.campFollowers);
}

private function takeAetherD():void {
	clearOutput();
	weapons.AETHERD.useText();
	player.weapon.removeText();
	var item:Weapon = player.setWeapon(weapons.AETHERD); //Item is now the player's old weapon
	if (item == null)
		doNext(playerMenu);
	else inventory.takeItem(item, playerMenu);
}
private function takeAetherS():void {
	clearOutput();
	shields.AETHERS.useText();
	player.shield.removeText();
	var item:Shield = player.setShield(shields.AETHERS); //Item is now the player's old shield
	if (item == null)
		doNext(playerMenu);
	else inventory.takeItem(item, playerMenu);
}

public function aethertwinsFollowersAppearance():void {
	clearOutput();
	outputText("\n\n");
	outputText("\n\n");
	menu();
	addButton(14, "Back", aethertwinsFollowers);
}

public function aethertwinsFollowersTalk():void {
	clearOutput();
	outputText("\n\n");
	outputText("\"<i></i>\"\n\n");
	menu();
	addButton(14, "Back", aethertwinsFollowers);
}
public function aethertwinsFollowersTalkThem():void {
	clearOutput();
	outputText("\n\n");
	outputText("\"<i></i>\"\n\n");
	doNext(camp.returnToCampUseOneHour);
}
public function aethertwinsFollowersTalk2():void {
	clearOutput();
	outputText("\n\n");
	doNext(camp.returnToCampUseOneHour);
}
public function aethertwinsFollowersTalk3():void {
	clearOutput();
	outputText("\n\n");
	doNext(camp.returnToCampUseOneHour);
}
	}
}