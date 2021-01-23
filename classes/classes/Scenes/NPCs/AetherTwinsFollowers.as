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
import classes.internals.SaveableState;

	public class AetherTwinsFollowers extends NPCAwareContent implements SaveableState
	{
		public static var AetherTwinsShape:String;
		public static var AetherTwinsCount:Number;
		public static var AetherTwinsFoodMenu:Boolean;
		
		public function stateObjectName():String {
			return "AetherTwinsScenes";
		}
		
		public function resetState():void {
			AetherTwinsShape = "";
			AetherTwinsCount = 0;
			AetherTwinsFoodMenu = false;
		}
		
		public function saveToObject():Object {
			return {
				"AetherTwinsShape": AetherTwinsShape,
				"AetherTwinsCount": AetherTwinsCount,
				"AetherTwinsFoodMenu": AetherTwinsFoodMenu
			};
		}
		
		public function loadFromObject(o:Object, ignoreErrors:Boolean):void {
			if (o) {
				AetherTwinsShape = o["AetherTwinsShape"];
				AetherTwinsCount = o["AetherTwinsCount"];
				AetherTwinsFoodMenu = o["AetherTwinsFoodMenu"];
			} else {
				// loading from old save
				resetState();
			}
		}
		
		public function AetherTwinsFollowers() 
		{
			Saves.registerSaveableState(this);
		}

public function aethertwinsFollowers():void {
	clearOutput();
	if (flags[kFLAGS.AETHER_DEXTER_TWIN_AT_CAMP] >= 1 || flags[kFLAGS.AETHER_SINISTER_TWIN_AT_CAMP] >= 1) AetherTwinsCount = 1;
	if (flags[kFLAGS.AETHER_DEXTER_TWIN_AT_CAMP] >= 1 && flags[kFLAGS.AETHER_SINISTER_TWIN_AT_CAMP] >= 1) AetherTwinsCount = 2;
	outputText("You walk over to Aether Twins resting place.  Seeing you approach, the sentient weapon"+(AetherTwinsCount > 1 ? "s":"")+" turns the golem "+(AetherTwinsCount > 1 ? "they":"it")+" used as temporal host in your direction.\n\n");
	outputText("\"<i>Hey there, [name]! Need anything while we're safe at camp?</i>\"\n\n");
	menu();
	//addButton(0, "Appearance", valeriaAppearance).hint("Examine Aether Twins appearance.");
	addButton(1, "Talk", aethertwinsFollowersTalk).hint("Discuss with Aether Twins.");
	if (AetherTwinsFoodMenu) addButton(2, "Feed", aethertwinsFollowersFeed).hint("Give Aether Twins some equipment or materials to eat.");
	else addButtonDisabled(2, "???", "Maybe you should talk with them to unlock this option?");
	//if (flags[kFLAGS.CAMP_UPGRADES_SPARING_RING] >= 2) addButton(3, "Spar", valeriaSpar).hint("Do a quick battle with Valeria!");
	//if (player.lust >= 33) addButton(4, "Sex", followersValeriaSex).hint("Initiate sexy time with the armor-goo.");
	if (flags[kFLAGS.AETHER_DEXTER_TWIN_AT_CAMP] == 1) addButton(10, "Take A.D.", takeAetherD).hint(weapons.AETHERD.description);
	if (flags[kFLAGS.AETHER_SINISTER_TWIN_AT_CAMP] == 1) addButton(11, "Take A.S.", takeAetherS).hint(shields.AETHERS.description);
	addButton(14, "Back", camp.campFollowers);
}

private function takeAetherD():void {
	clearOutput();
	weapons.AETHERD.useText();
	player.weapon.removeText();
	var item:Weapon = player.setWeapon(weapons.AETHERD); //Item is now the player's old weapon
	if (item == null) doNext(aethertwinsFollowers);
	else inventory.takeItem(item, aethertwinsFollowers);
}
private function takeAetherS():void {
	clearOutput();
	shields.AETHERS.useText();
	player.shield.removeText();
	var item:Shield = player.setShield(shields.AETHERS); //Item is now the player's old shield
	if (item == null) doNext(aethertwinsFollowers);
	else inventory.takeItem(item, aethertwinsFollowers);
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
	outputText("\"<i>So what you wanna talk about?</i>\" Sentient weapon"+(AetherTwinsCount > 1 ? "s":"")+" ask"+(AetherTwinsCount > 1 ? "s":"")+". \"<i>Or you wanna go smash someone till they are reduced to blood pulp?</i>\"\n\n");
	menu();
	addButton(0, "Them", aethertwinsFollowersTalkThem);
	addButton(14, "Back", aethertwinsFollowers);
}
public function aethertwinsFollowersTalkThem():void {
	clearOutput();
	outputText("\"<i>Oh, so you're interested in "+(AetherTwinsCount > 1 ? "us":"me")+"? "+(AetherTwinsCount > 1 ? "We're":"I'm")+" just a ordinary sentient weapon"+(AetherTwinsCount > 1 ? "s":"")+" crafted by some vip blacksmith. Maybe even VERY VIP one blacksmith. If you know what "+(AetherTwinsCount > 1 ? "we":"i")+" mean.</i>\"\n\n");
	outputText("No you not don't know or at least you react in a way they take it as not knowing. With light reminder to return to subject "+(AetherTwinsCount > 1 ? "they":"she")+" continue"+(AetherTwinsCount > 1 ? "s":"")+".\n\n");
	outputText("\"<i>Maybe you think "+(AetherTwinsCount > 1 ? "we're":"i'm")+" weak but that all relative. Just givine "+(AetherTwinsCount > 1 ? "us":"me")+" some snacks and "+(AetherTwinsCount > 1 ? "we":"i")+"'ll get stronger in no time.</i>\"\n\n");
	outputText("Giving them snacks? Like some food? Aren't "+(AetherTwinsCount > 1 ? "they":"she")+" a weapon. How would "+(AetherTwinsCount > 1 ? "they":"she")+" eat all that food?\n\n");
	outputText("\"<i>Hella no. "+(AetherTwinsCount > 1 ? "We":"I")+" not interested in food you eating. Bring "+(AetherTwinsCount > 1 ? "us":"me")+" all those tasty metals or equipment like swords or shields. That should be enough</i>\"\n\n");
	outputText("That certainly would make thigns easier... or harder? As long "+(AetherTwinsCount > 1 ? "their":"her")+" 'appetite' won't be bottomless.\n\n");
	outputText("\"<i>So then ummm.. did you brought some snacks?</i>\" "+(AetherTwinsCount > 1 ? "Their":"Her")+" voice sounds like "+(AetherTwinsCount > 1 ? "they":"she")+" expecting to get some 'food' now. Making excuse of need to go bring it you ends this conversation.\n\n");
	if (!AetherTwinsFoodMenu) {
		outputText("<b>Feed Option has been unlocked!!!</b>\n\n");
		AetherTwinsFoodMenu = true;
	}
	doNext(aethertwinsFollowersTalk);
	cheatTime(1/4);
}
public function aethertwinsFollowersTalk2():void {
	clearOutput();
	outputText("\n\n");
	doNext(aethertwinsFollowersTalk);
	cheatTime(1/4);
}
public function aethertwinsFollowersTalk3():void {
	clearOutput();
	outputText("\n\n");
	doNext(aethertwinsFollowersTalk);
	cheatTime(1/4);
}

public function aethertwinsFollowersFeed():void {
	clearOutput();
	outputText("\"<i>You brought somethng tasty for "+(AetherTwinsCount > 1 ? "us":"me")+" to eat?</i>\" "+(AetherTwinsCount > 1 ? "They":"She")+" ask"+(AetherTwinsCount > 1 ? "s":"")+".\n\n");
	menu();
	addButton(14, "Back", aethertwinsFollowers);
}
public function aethertwinsFollowersFeedEquipment():void {
	clearOutput();
	outputText("Placeholder text.\n\n");
	outputText("\"<i>Contracted writer not wrote text yet.</i>\" "+(AetherTwinsCount > 1 ? "one of the":"both")+" twins shrugs.\n\n");
	doNext(aethertwinsFollowersFeed);
	cheatTime(1/4);
}
public function aethertwinsFollowersFeedMaterial():void {
	clearOutput();
	outputText("\n\n");
	outputText("\n\n");
	outputText("\"<i></i>\"\n\n");
	doNext(camp.returnToCampUseOneHour);
}
	}
}//do 165 linii na razie dodawać ^^