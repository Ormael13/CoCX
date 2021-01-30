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
		public static var AetherTwinsTalkMenu:Number;
		public static var AetherTwinsFoodMenuSilver:Number;
		public static var AetherTwinsFoodMenuSilverCap:Number;
		public static var AetherTwinsFoodMenu:Boolean;
		public static var AetherTwinsFoodMenuBuckler:Boolean;
		public static var AetherTwinsFoodMenuSpikeLShield:Boolean;
		public static var AetherTwinsFoodMenuSGauntlet:Boolean;
		public static var AetherTwinsFoodMenuClaws:Boolean;
		public static var AetherTwinsFoodMenuHGaunt:Boolean;
		public static var AetherTwinsFoodMenuBFGauntlets:Boolean;
		public static var AetherTwinsFoodMenuLustyClaws:Boolean;
		public static var AetherTwinsFoodMenu2:Boolean;
		public static var AetherTwinsFoodMenu1:Boolean;
		
		public function stateObjectName():String {
			return "AetherTwinsScenes";
		}
		
		public function resetState():void {
			AetherTwinsShape = "";
			AetherTwinsCount = 0;
			AetherTwinsTalkMenu = 0;
			AetherTwinsFoodMenuSilver = 0;
			AetherTwinsFoodMenuSilverCap = 0;
			AetherTwinsFoodMenu = false;
			AetherTwinsFoodMenuBuckler = false;
			AetherTwinsFoodMenuSpikeLShield = false;
			AetherTwinsFoodMenuSGauntlet = false;
			AetherTwinsFoodMenuClaws = false;
			AetherTwinsFoodMenuHGaunt = false;
			AetherTwinsFoodMenuBFGauntlets = false;
			AetherTwinsFoodMenuLustyClaws = false;
			AetherTwinsFoodMenu2 = false;
			AetherTwinsFoodMenu1 = false;
		}
		
		public function saveToObject():Object {
			return {
				"AetherTwinsShape": AetherTwinsShape,
				"AetherTwinsCount": AetherTwinsCount,
				"AetherTwinsTalkMenu": AetherTwinsTalkMenu,
				"AetherTwinsFoodMenuSilver": AetherTwinsFoodMenuSilver,
				"AetherTwinsFoodMenuSilverCap": AetherTwinsFoodMenuSilverCap,
				"AetherTwinsFoodMenu": AetherTwinsFoodMenu,
				"AetherTwinsFoodMenuBuckler": AetherTwinsFoodMenuBuckler,
				"AetherTwinsFoodMenuSpikeLShield": AetherTwinsFoodMenuSpikeLShield,
				"AetherTwinsFoodMenuSGauntlet": AetherTwinsFoodMenuSGauntlet,
				"AetherTwinsFoodMenuClaws": AetherTwinsFoodMenuClaws,
				"AetherTwinsFoodMenuHGaunt": AetherTwinsFoodMenuHGaunt,
				"AetherTwinsFoodMenuBFGauntlets": AetherTwinsFoodMenuBFGauntlets,
				"AetherTwinsFoodMenuLustyClaws": AetherTwinsFoodMenuLustyClaws,
				"AetherTwinsFoodMenu2": AetherTwinsFoodMenu2,
				"AetherTwinsFoodMenu1": AetherTwinsFoodMenu1
			};
		}
		
		public function loadFromObject(o:Object, ignoreErrors:Boolean):void {
			if (o) {
				AetherTwinsShape = o["AetherTwinsShape"];
				AetherTwinsCount = o["AetherTwinsCount"];
				AetherTwinsTalkMenu = o["AetherTwinsTalkMenu"];
				AetherTwinsFoodMenuSilver = o["AetherTwinsFoodMenuSilver"];
				AetherTwinsFoodMenuSilverCap = o["AetherTwinsFoodMenuSilverCap"];
				AetherTwinsFoodMenu = o["AetherTwinsFoodMenu"];
				AetherTwinsFoodMenuBuckler = o["AetherTwinsFoodMenuBuckler"];
				AetherTwinsFoodMenuSpikeLShield = o["AetherTwinsFoodMenuSpikeLShield"];
				AetherTwinsFoodMenuSGauntlet = o["AetherTwinsFoodMenuSGauntlet"];
				AetherTwinsFoodMenuClaws = o["AetherTwinsFoodMenuClaws"];
				AetherTwinsFoodMenuHGaunt = o["AetherTwinsFoodMenuHGaunt"];
				AetherTwinsFoodMenuBFGauntlets = o["AetherTwinsFoodMenuBFGauntlets"];
				AetherTwinsFoodMenuLustyClaws = o["AetherTwinsFoodMenuLustyClaws"];
				AetherTwinsFoodMenu2 = o["AetherTwinsFoodMenu2"];
				AetherTwinsFoodMenu1 = o["AetherTwinsFoodMenu1"];
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
	if (AetherTwinsTalkMenu > 0) {
		addButtonDisabled(1, "Evolutions", "Still unwritten talk subject.");//addButton(1, "Evolutions", aethertwinsFollowersTalkEvolutions);
		addButtonDisabled(2, "Past", "Still unwritten talk subject.");//addButton(1, "Past", aethertwinsFollowersTalkPast);
	}
	else {
		addButtonDisabled(1, "???", "Twins memories related to this topic are still sealed.");
		addButtonDisabled(2, "???", "Twins memories related to this topic are still sealed.");
	}
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
	if (!AetherTwinsFoodMenu && flags[kFLAGS.AETHER_DEXTER_TWIN_AT_CAMP] >= 1 && flags[kFLAGS.AETHER_SINISTER_TWIN_AT_CAMP] >= 1) {
		outputText("<b>Feed Option has been unlocked!!!</b>\n\n");
		AetherTwinsFoodMenu = true;
	}
	doNext(aethertwinsFollowersTalk);
	cheatTime(1/4);
}
public function aethertwinsFollowersTalkEvolutions():void {
	clearOutput();
	outputText("\n\n");
	doNext(aethertwinsFollowersTalk);
	cheatTime(1/4);
}
public function aethertwinsFollowersTalkPast():void {
	clearOutput();
	outputText("\n\n");
	doNext(aethertwinsFollowersTalk);
	cheatTime(1/4);
}
public function aethertwinsFollowersTalk2():void {
	clearOutput();
	outputText("\n\n");
	doNext(aethertwinsFollowersTalk);
	cheatTime(1/4);
}
public function aethertwinsFollowersTalk1():void {
	clearOutput();
	outputText("\n\n");
	doNext(aethertwinsFollowersTalk);
	cheatTime(1/4);
}

public function aethertwinsFollowersFeed():void {
	clearOutput();
	outputText("\"<i>You brought somethng tasty for "+(AetherTwinsCount > 1 ? "us":"me")+" to eat?</i>\" "+(AetherTwinsCount > 1 ? "They":"She")+" ask"+(AetherTwinsCount > 1 ? "s":"")+".\n\n");
	outputText("\n\nEaten materials:");
	outputText("\n-Silver ingot ("+AetherTwinsFoodMenuSilver+"/"+AetherTwinsFoodMenuSilverCap+")");
	outputText("\n\nEaten equipment:");
	if (AetherTwinsFoodMenuBuckler) outputText("\n-Buckler");
	if (AetherTwinsFoodMenuSpikeLShield) outputText("\n-Spiked Light Shield");
	if (AetherTwinsFoodMenuSGauntlet) outputText("\n-Spiked Gauntlet");
	if (AetherTwinsFoodMenuClaws) outputText("\n-Claws");
	if (AetherTwinsFoodMenuHGaunt) outputText("\n-Hooked Gauntlets");
	if (AetherTwinsFoodMenuBFGauntlets) outputText("\n-Big Fucking Gauntlets");
	if (AetherTwinsFoodMenuLustyClaws) outputText("\n-Lusty Claws");
	menu();
	var btn:int = 0;
	if (player.hasItem(useables.S_INGOT, 1)) {
		if (AetherTwinsTalkMenu > 0) {
			if (AetherTwinsFoodMenuSilver < AetherTwinsFoodMenuSilverCap) addButton(btn, useables.S_INGOT.shortName, aethertwinsFollowersFeedMaterial, useables.S_INGOT);
			else addButtonDisabled(btn, useables.S_INGOT.shortName, "They can't eat more of this type of metal without undergoing evolution.");
		}
		else addButtonDisabled(btn, useables.S_INGOT.shortName, "They can't eat this type of metal before first evolution.");
	}
	btn++;
	if (player.hasItem(shields.BUCKLER, 1) && !AetherTwinsFoodMenuBuckler) addButton(btn, shields.BUCKLER.shortName, aethertwinsFollowersFeedEquipment, shields.BUCKLER);
	btn++;
	if (player.hasItem(weapons.S_GAUNT, 1) && !AetherTwinsFoodMenuSGauntlet) addButton(btn, weapons.S_GAUNT.shortName, aethertwinsFollowersFeedEquipment, weapons.S_GAUNT);
	btn++;
	if (player.hasItem(weapons.CLAWS, 1) && !AetherTwinsFoodMenuClaws) addButton(btn, weapons.CLAWS.shortName, aethertwinsFollowersFeedEquipment, weapons.CLAWS);
	btn++;
	//if (AetherTwinsTalkMenu > 0) {
		//if (player.hasItem(shields.SPIL_SH, 1) && !AetherTwinsFoodMenuSpikeLShield) addButton(btn, shields.SPIL_SH.shortName, aethertwinsFollowersFeedEquipment, shields.SPIL_SH);
		//btn++;
		//if (player.hasItem(weapons.H_GAUNT, 1) && !AetherTwinsFoodMenuHGaunt) addButton(btn, weapons.H_GAUNT.shortName, aethertwinsFollowersFeedEquipment, weapons.H_GAUNT);
		//btn++;
		//if (player.hasItem(weapons.BFGAUNT, 1) && !AetherTwinsFoodMenuBFGauntlets) addButton(btn, weapons.BFGAUNT.shortName, aethertwinsFollowersFeedEquipment, weapons.BFGAUNT);
		//btn++;
		//if (player.hasItem(weapons.L_CLAWS, 1) && !AetherTwinsFoodMenuLustyClaws) addButton(btn, weapons.L_CLAWS.shortName, aethertwinsFollowersFeedEquipment, weapons.L_CLAWS);
		//btn++;
	//}
	addButton(14, "Back", aethertwinsFollowers);
}
public function aethertwinsFollowersFeedMaterial(itype:ItemType):void {
	clearOutput();
	outputText("You decide it's time to upgrade the twins with some new material. You grab the "+itype.shortName+" out of your bag and slowly let the twin eat it, the material turning liquid as you squeeze it between gauntlets. ");
	outputText("Before long the now fluid "+itype.shortName+" is coating them entirely. A few seconds later you are done and the "+itype.shortName+" is fully absorbed into the twins.\n\n");
	outputText("\"<i>Thank you for the meal.</i>\" they grins.\n\n");
	if (player.hasItem(useables.S_INGOT, 1)) AetherTwinsFoodMenuSilver += 1;
	player.destroyItems(itype, 1);
	doNext(aethertwinsFollowersFeed);
	cheatTime(1/4);
}
public function aethertwinsFollowersFeedEquipment(itype:ItemType):void {
	clearOutput();
	outputText("You deposit the item on the ground and approach the aether twins from it. Not to your surprise the item begins to melt as if turning to sludge as the twins zap them with some unknown magic the twins growing something not unlike magical teeth with which it begins munching at this new material. Before long the item is fully assimilated into the twins which acquires some of its powers.\n\n");
	outputText("\"<i>Thank you for the meal.</i>\" they grins.\n\n");
	switch (itype) {
		case shields.BUCKLER:	AetherTwinsFoodMenuBuckler = true;		break;
		case shields.SPIL_SH:	AetherTwinsFoodMenuSpikeLShield = true;	break;
		case weapons.S_GAUNT:	AetherTwinsFoodMenuSGauntlet = true;	break;
		case weapons.CLAWS:		AetherTwinsFoodMenuClaws = true;		break;
		case weapons.H_GAUNT:	AetherTwinsFoodMenuHGaunt = true;		break;
		case weapons.BFGAUNT:	AetherTwinsFoodMenuBFGauntlets = true;	break;
		case weapons.L_CLAWS:	AetherTwinsFoodMenuLustyClaws = true;	break;
	}
	player.destroyItems(itype, 1);
	if (AetherTwinsFoodMenuBuckler && AetherTwinsFoodMenuSGauntlet && AetherTwinsFoodMenuSGauntlet) {
		outputText("\"<i>Woohoo we're evolving.</i>\" they exclaims. \"<i>We going Faster Harder Better Stronger Curvier!!!</i>\"\n\n");
		outputText("<b>Aether Twins base form evolved unlocking some of their sealed memories.</b>\n\n");
		player.addStatusValue(StatusEffects.AetherTwins1, 2, 5);
		AetherTwinsShape = "Human-tier Gaunlets";
		AetherTwinsFoodMenuSilverCap = 4;
		AetherTwinsTalkMenu = 1;
	}
	doNext(aethertwinsFollowersFeed);
	cheatTime(1/4);
}
	}
}//do 549 linii na razie dodawać ^^