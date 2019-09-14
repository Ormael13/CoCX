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
	outputText("You walk over to Aether Twins resting place.  Seeing you approach, the sentient weapons turns the golem they used as temporal host in your direction.\n\n");
	outputText("\"<i>Hey there, [name]! Need anything while we're safe at camp?</i>\"\n\n");
	//(Display Options: [Appearance] [Spar] [Sex] [Talk])
	menu();
	//addButton(0, "Appearance", valeriaAppearance).hint("Examine Valeria's appearance.");
	//if (flags[kFLAGS.CAMP_UPGRADES_SPARING_RING] >= 2) addButton(1, "Spar", valeriaSpar).hint("Do a quick battle with Valeria!");
	//if (player.lust >= 33) addButton(2, "Sex", followersValeriaSex).hint("Initiate sexy time with the armor-goo.");
	//addButton(3, "Talk", talkWithValeria).hint("Discuss with Valeria.");
	if (flags[kFLAGS.AETHER_DEXTER_TWIN_AT_CAMP] == 1) addButton(8, "Take", takeAetherD).hint(weapons.AETHERD.description);
	if (flags[kFLAGS.AETHER_SINISTER_TWIN_AT_CAMP] == 1) addButton(9, "Take", takeAetherS).hint(shields.AETHERS.description);
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

	}
}