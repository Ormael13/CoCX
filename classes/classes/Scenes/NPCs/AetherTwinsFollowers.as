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
		public static var AetherTwinsFoodMenuTin:Number;
		public static var AetherTwinsFoodMenuTinCap:Number;
		public static var AetherTwinsFoodMenuCopper:Number;
		public static var AetherTwinsFoodMenuCopperCap:Number;
		public static var AetherTwinsFoodMenuIron:Number;
		public static var AetherTwinsFoodMenuIronCap:Number;
		public static var AetherTwinsFoodMenuSilver:Number;
		public static var AetherTwinsFoodMenuSilverCap:Number;
		public static var AetherTwinsFoodMenuGold:Number;
		public static var AetherTwinsFoodMenuGoldCap:Number;
		public static var AetherTwinsFoodMenuWorldTreeBranch:Number;
		public static var AetherTwinsFoodMenuWorldTreeBranchCap:Number;
		public static var AetherTwinsFoodMenuDiamond:Number;
		public static var AetherTwinsFoodMenuDiamondCap:Number;
		public static var AetherTwinsFoodMenuAmethyst:Number;
		public static var AetherTwinsFoodMenuAmethystCap:Number;
		public static var AetherTwinsFoodMenuMoonstone:Number;
		public static var AetherTwinsFoodMenuMoonstoneCap:Number;
		public static var AetherTwinsFoodMenuSkymetal:Number;
		public static var AetherTwinsFoodMenuSkymetalCap:Number;
		public static var AetherTwinsFoodMenuAdamantine:Number;
		public static var AetherTwinsFoodMenuAdamantineCap:Number;
		public static var AetherTwinsFoodMenuOrichalcum:Number;
		public static var AetherTwinsFoodMenuOrichalcumCap:Number;
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
			AetherTwinsFoodMenuTin = 0;
			AetherTwinsFoodMenuTinCap = 0;
			AetherTwinsFoodMenuCopper = 0;
			AetherTwinsFoodMenuCopperCap = 0;
			AetherTwinsFoodMenuIron = 0;
			AetherTwinsFoodMenuIronCap = 0;
			AetherTwinsFoodMenuSilver = 0;
			AetherTwinsFoodMenuSilverCap = 0;
			AetherTwinsFoodMenuGold = 0;
			AetherTwinsFoodMenuGoldCap = 0;
			AetherTwinsFoodMenuWorldTreeBranch = 0;
			AetherTwinsFoodMenuWorldTreeBranchCap = 0;
			AetherTwinsFoodMenuDiamond = 0;
			AetherTwinsFoodMenuDiamondCap = 0;
			AetherTwinsFoodMenuAmethyst = 0;
			AetherTwinsFoodMenuAmethystCap = 0;
			AetherTwinsFoodMenuMoonstone = 0;
			AetherTwinsFoodMenuMoonstoneCap = 0;
			AetherTwinsFoodMenuSkymetal = 0;
			AetherTwinsFoodMenuSkymetalCap = 0;
			AetherTwinsFoodMenuAdamantine = 0;
			AetherTwinsFoodMenuAdamantineCap = 0;
			AetherTwinsFoodMenuOrichalcum = 0;
			AetherTwinsFoodMenuOrichalcumCap = 0;
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
				"AetherTwinsFoodMenuTin": AetherTwinsFoodMenuTin,
				"AetherTwinsFoodMenuTinCap": AetherTwinsFoodMenuTinCap,
				"AetherTwinsFoodMenuCopper": AetherTwinsFoodMenuCopper,
				"AetherTwinsFoodMenuCopperCap": AetherTwinsFoodMenuCopperCap,
				"AetherTwinsFoodMenuIron": AetherTwinsFoodMenuIron,
				"AetherTwinsFoodMenuIronCap": AetherTwinsFoodMenuIronCap,
				"AetherTwinsFoodMenuSilver": AetherTwinsFoodMenuSilver,
				"AetherTwinsFoodMenuSilverCap": AetherTwinsFoodMenuSilverCap,
				"AetherTwinsFoodMenuGold": AetherTwinsFoodMenuGold,
				"AetherTwinsFoodMenuGoldCap": AetherTwinsFoodMenuGoldCap,
				"AetherTwinsFoodMenuWorldTreeBranch": AetherTwinsFoodMenuWorldTreeBranch,
				"AetherTwinsFoodMenuWorldTreeBranchCap": AetherTwinsFoodMenuWorldTreeBranchCap,
				"AetherTwinsFoodMenuDiamond": AetherTwinsFoodMenuDiamond,
				"AetherTwinsFoodMenuDiamondCap": AetherTwinsFoodMenuDiamondCap,
				"AetherTwinsFoodMenuAmethyst": AetherTwinsFoodMenuAmethyst,
				"AetherTwinsFoodMenuAmethystCap": AetherTwinsFoodMenuAmethystCap,
				"AetherTwinsFoodMenuMoonstone": AetherTwinsFoodMenuMoonstone,
				"AetherTwinsFoodMenuMoonstoneCap": AetherTwinsFoodMenuMoonstoneCap,
				"AetherTwinsFoodMenuSkymetal": AetherTwinsFoodMenuSkymetal,
				"AetherTwinsFoodMenuSkymetalCap": AetherTwinsFoodMenuSkymetalCap,
				"AetherTwinsFoodMenuAdamantine": AetherTwinsFoodMenuAdamantine,
				"AetherTwinsFoodMenuAdamantineCap": AetherTwinsFoodMenuAdamantineCap,
				"AetherTwinsFoodMenuOrichalcum": AetherTwinsFoodMenuOrichalcum,
				"AetherTwinsFoodMenuOrichalcumCap": AetherTwinsFoodMenuOrichalcumCap,
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
				AetherTwinsFoodMenuTin = o["AetherTwinsFoodMenuTin"];
				AetherTwinsFoodMenuTinCap = o["AetherTwinsFoodMenuTinCap"];
				AetherTwinsFoodMenuCopper = o["AetherTwinsFoodMenuCopper"];
				AetherTwinsFoodMenuCopperCap = o["AetherTwinsFoodMenuCopperCap"];
				AetherTwinsFoodMenuIron = o["AetherTwinsFoodMenuIron"];
				AetherTwinsFoodMenuIronCap = o["AetherTwinsFoodMenuIronCap"];
				AetherTwinsFoodMenuSilver = o["AetherTwinsFoodMenuSilver"];
				AetherTwinsFoodMenuSilverCap = o["AetherTwinsFoodMenuSilverCap"];
				AetherTwinsFoodMenuGold = o["AetherTwinsFoodMenuGold"];
				AetherTwinsFoodMenuGoldCap = o["AetherTwinsFoodMenuGoldCap"];
				AetherTwinsFoodMenuWorldTreeBranch = o["AetherTwinsFoodMenuWorldTreeBranch"];
				AetherTwinsFoodMenuWorldTreeBranchCap = o["AetherTwinsFoodMenuWorldTreeBranchCap"];
				AetherTwinsFoodMenuDiamond = o["AetherTwinsFoodMenuDiamond"];
				AetherTwinsFoodMenuDiamondCap = o["AetherTwinsFoodMenuDiamondCap"];
				AetherTwinsFoodMenuAmethyst = o["AetherTwinsFoodMenuAmethyst"];
				AetherTwinsFoodMenuAmethystCap = o["AetherTwinsFoodMenuAmethystCap"];
				AetherTwinsFoodMenuMoonstone = o["AetherTwinsFoodMenuMoonstone"];
				AetherTwinsFoodMenuMoonstoneCap = o["AetherTwinsFoodMenuMoonstoneCap"];
				AetherTwinsFoodMenuSkymetal = o["AetherTwinsFoodMenuSkymetal"];
				AetherTwinsFoodMenuSkymetalCap = o["AetherTwinsFoodMenuSkymetalCap"];
				AetherTwinsFoodMenuAdamantine = o["AetherTwinsFoodMenuAdamantine"];
				AetherTwinsFoodMenuAdamantineCap = o["AetherTwinsFoodMenuAdamantineCap"];
				AetherTwinsFoodMenuOrichalcum = o["AetherTwinsFoodMenuOrichalcum"];
				AetherTwinsFoodMenuOrichalcumCap = o["AetherTwinsFoodMenuOrichalcumCap"];
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
	outputText("You walk over to the Aether Twins' resting place.  Seeing you approach, the sentient weapon"+(AetherTwinsCount > 1 ? "s turn the golem they":" turns the golem it")+" used as a temporal host in your direction.\n\n");
	outputText("\"<i>Hey there, [name]! Need anything while we're safe at camp?</i>\"\n\n");
	menu();
	//addButton(0, "Appearance", valeriaAppearance).hint("Examine Aether Twins appearance.");
	addButton(1, "Talk", aethertwinsFollowersTalk).hint("Discuss with the Aether Twins.");
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
	outputText("\"<i>So what do you wanna talk about?</i>\" The sentient weapon"+(AetherTwinsCount > 1 ? "s ask":"asks")+". \"<i>Or do you wanna go smash someone till they are reduced to a blood pulp?</i>\"\n\n");
	menu();
	addButton(0, "Them", aethertwinsFollowersTalkThem);
	if (AetherTwinsTalkMenu > 0) {
		addButton(1, "Evolutions", aethertwinsFollowersTalkEvolutions);
		addButton(2, "Past", aethertwinsFollowersTalkPast);
	}
	else {
		addButtonDisabled(1, "???", "Twins memories related to this topic are still sealed.");
		addButtonDisabled(2, "???", "Twins memories related to this topic are still sealed.");
	}
	addButton(14, "Back", aethertwinsFollowers);
}
public function aethertwinsFollowersTalkThem():void {
	clearOutput();
	outputText("\"<i>Oh, so you're interested in "+(AetherTwinsCount > 1 ? "us":"me")+"? "+(AetherTwinsCount > 1 ? "We're just":"I'm just an")+" ordinary sentient weapon"+(AetherTwinsCount > 1 ? "s":"")+" crafted by some gifted blacksmith. Maybe even a very 'gifted' blacksmith If you know what "+(AetherTwinsCount > 1 ? "we":"I")+" mean.</i>\"\n\n");
	outputText("No you not don't know or at least you react in a way they take it as you not knowing. With a light reminder to return to the subject "+(AetherTwinsCount > 1 ? "they":"she")+" continue"+(AetherTwinsCount > 1 ? "s":"")+".\n\n");
	outputText("\"<i>Maybe you think "+(AetherTwinsCount > 1 ? "we're":"i'm")+" weak but that's all relative. Just give "+(AetherTwinsCount > 1 ? "us":"me")+" some snacks and "+(AetherTwinsCount > 1 ? "we":"I")+"'ll get stronger in no time.</i>\"\n\n");
	outputText("Giving "+(AetherTwinsCount > 1 ? "them":"her")+" snacks? Like some food? Aren't "+(AetherTwinsCount > 1 ? "they":"she")+" a weapon? How would "+(AetherTwinsCount > 1 ? "they":"she")+" eat all that food?\n\n");
	outputText("\"<i>Hella no. "+(AetherTwinsCount > 1 ? "We are":"I am")+" not interested in food your kind eats. Bring "+(AetherTwinsCount > 1 ? "us":"me")+" all those tasty metals or equipment like gloves, claws and shields. That should be enough.</i>\"\n\n");
	outputText("That certainly would make thigns easier... or harder? As long "+(AetherTwinsCount > 1 ? "their":"her")+" 'appetite' isn't bottomless.\n\n");
	outputText("\"<i>So then ummm.. did you bring us some snacks?</i>\" "+(AetherTwinsCount > 1 ? "Their":"Her")+" voice sounds like "+(AetherTwinsCount > 1 ? "they are":"she is")+" expecting to get some 'food' now. You make an excuse like 'you need to go' and bring an end to the conversation.\n\n");
	if (!AetherTwinsFoodMenu && flags[kFLAGS.AETHER_DEXTER_TWIN_AT_CAMP] >= 1 && flags[kFLAGS.AETHER_SINISTER_TWIN_AT_CAMP] >= 1) {
		outputText("<b>Feed Option has been unlocked!!!</b>\n\n");
		AetherTwinsFoodMenu = true;
	}
	doNext(aethertwinsFollowersTalk);
	cheatTime(1/4);
}
public function aethertwinsFollowersTalkEvolutions():void {
	clearOutput();
	outputText("\"<i>That's what makes "+(AetherTwinsCount > 1 ? "us":"me")+" special, right? To keep devouring and evolving reaching our pinnacle.</i>\" Reaching your pinnacle? But why? \"<i>That's a silly question isn't it? Because...</i>\" "+(AetherTwinsCount > 1 ? "they":"she")+" fall silent for very long moment as if trying recall a reason. \"<i>... because it's the purpose of ");
	outputText((AetherTwinsCount > 1 ? "our":"my")+" existance.</i>\"\n\nJust like that? Merely existing to devour and evolve? Nothing more to "+(AetherTwinsCount > 1 ? "their":"her")+" evolutions than this?\n\n");
	outputText("\"<i>Haven't you also changed since coming to this realm? You also evolve in your own way, so why do you think "+(AetherTwinsCount > 1 ? "our":"my")+" evolutions have no purpose? Survival of the fittest, right?</i>\"\n\n");
	outputText("You fall silent thinking that over. Yes, you changed since comming here. Before you can continue conversation "+(AetherTwinsCount > 1 ? "they end":"she ends")+" it, \"<i>"+(AetherTwinsCount > 1 ? "We're":"I'm")+" bored, let's find someone to beat or something to eat. Come on... talking is so boring!!!</i>\"\n\n");
	doNext(aethertwinsFollowersTalk);
	cheatTime(1/4);
}
public function aethertwinsFollowersTalkPast():void {
	clearOutput();
	outputText("\"<i>Past?</i>\" "+(AetherTwinsCount > 1 ? "They focus":"She focuses")+" for a longer moment trying recall it. "+(AetherTwinsCount > 1 ? "They stay":"She stays")+" silent for very long moment before "+(AetherTwinsCount > 1 ? "They speak":"She speaks")+" again.\n\n\"<i>All "+(AetherTwinsCount > 1 ? "we":"I")+" could recall is awaking ");
	outputText("inside the dungeon next to the golem that "+(AetherTwinsCount > 1 ? "we":"I")+" bonded with and started controling like "+(AetherTwinsCount > 1 ? "our":"my")+" own bod"+(AetherTwinsCount > 1 ? "ies":"y")+". Anything before that time is still veiled like some sort of mist covering "+(AetherTwinsCount > 1 ? "our":"my")+" older memories.</i>\"\n\n");
	outputText("Well that wasn't much. You end the converstaion asuring "+(AetherTwinsCount > 1 ? "them":"her")+" that with more evolutions "+(AetherTwinsCount > 1 ? "they":"she")+" will recall more details about "+(AetherTwinsCount > 1 ? "their":"her")+" past.\n\n");
	doNext(aethertwinsFollowersTalk);
	cheatTime(1/4);
}
public function aethertwinsFollowersTalk2():void {
	clearOutput();
	outputText("\"<i></i>\"\n\n");
	outputText("\n\n");
	doNext(aethertwinsFollowersTalk);
	cheatTime(1/4);
}
public function aethertwinsFollowersTalk1():void {
	clearOutput();
	outputText("\"<i></i>\"\n\n");
	outputText("\n\n");
	doNext(aethertwinsFollowersTalk);
	cheatTime(1/4);
}

public function aethertwinsFollowersFeed():void {
	clearOutput();
	outputText("\"<i>You brought somethng tasty for "+(AetherTwinsCount > 1 ? "us":"me")+" to eat?</i>\" "+(AetherTwinsCount > 1 ? "They":"She")+" ask"+(AetherTwinsCount > 1 ? "s":"")+".");
	outputText("\n\n-------");
	if (AetherTwinsTalkMenu > 0) {
		outputText("\n\nEaten materials:");
		outputText("\n-Silver ingot ("+AetherTwinsFoodMenuSilver+"/"+AetherTwinsFoodMenuSilverCap+")");
		outputText("\n-Gold ingot ("+AetherTwinsFoodMenuGold+"/"+AetherTwinsFoodMenuGoldCap+")");
		outputText("\n-Tin ore ("+AetherTwinsFoodMenuTin+"/"+AetherTwinsFoodMenuTinCap+")");
		outputText("\n-Copper ore ("+AetherTwinsFoodMenuCopper+"/"+AetherTwinsFoodMenuCopperCap+")");
	}
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
		btn++;
	}
	if (player.hasItem(useables.G_INGOT, 1)) {
		if (AetherTwinsTalkMenu > 0) {
			if (AetherTwinsFoodMenuGold < AetherTwinsFoodMenuGoldCap) addButton(btn, useables.G_INGOT.shortName, aethertwinsFollowersFeedMaterial, useables.G_INGOT);
			else addButtonDisabled(btn, useables.G_INGOT.shortName, "They can't eat more of this type of metal without undergoing evolution.");
		}
		else addButtonDisabled(btn, useables.G_INGOT.shortName, "They can't eat this type of metal before first evolution.");
		btn++;
	}
	if (player.hasItem(useables.TIN_ORE, 1)) {
		if (AetherTwinsTalkMenu > 0) {
			if (AetherTwinsFoodMenuTin < AetherTwinsFoodMenuTinCap) addButton(btn, useables.TIN_ORE.shortName, aethertwinsFollowersFeedMaterial, useables.TIN_ORE);
			else addButtonDisabled(btn, useables.TIN_ORE.shortName, "They can't eat more of this type of metal without undergoing evolution.");
		}
		else addButtonDisabled(btn, useables.TIN_ORE.shortName, "They can't eat this type of metal before first evolution.");
		btn++;
	}
	if (player.hasItem(useables.COP_ORE, 1)) {
		if (AetherTwinsTalkMenu > 0) {
			if (AetherTwinsFoodMenuCopper < AetherTwinsFoodMenuCopperCap) addButton(btn, useables.COP_ORE.shortName, aethertwinsFollowersFeedMaterial, useables.COP_ORE);
			else addButtonDisabled(btn, useables.COP_ORE.shortName, "They can't eat more of this type of metal without undergoing evolution.");
		}
		else addButtonDisabled(btn, useables.COP_ORE.shortName, "They can't eat this type of metal before first evolution.");
		btn++;
	}
	if (player.hasItem(shields.BUCKLER, 1) && !AetherTwinsFoodMenuBuckler) {
		addButton(btn, shields.BUCKLER.shortName, aethertwinsFollowersFeedEquipment, shields.BUCKLER);
		btn++;
	}
	if (player.hasItem(weapons.S_GAUNT, 1) && !AetherTwinsFoodMenuSGauntlet) {
		addButton(btn, weapons.S_GAUNT.shortName, aethertwinsFollowersFeedEquipment, weapons.S_GAUNT);
		btn++;
	}
	if (player.hasItem(weapons.CLAWS, 1) && !AetherTwinsFoodMenuClaws) {
		addButton(btn, weapons.CLAWS.shortName, aethertwinsFollowersFeedEquipment, weapons.CLAWS);
		btn++;
	}
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
	switch (itype) {
		case useables.TIN_ORE: AetherTwinsFoodMenuTin += 1;		break;
		case useables.COP_ORE: AetherTwinsFoodMenuCopper += 1;	break;
		//case useables.: AetherTwinsFoodMenuIron += 1;	break;
		case useables.S_INGOT: AetherTwinsFoodMenuSilver += 1;	break;
		case useables.G_INGOT: AetherTwinsFoodMenuGold += 1;	break;
	}
	player.destroyItems(itype, 1);
	doNext(aethertwinsFollowersFeed);
	cheatTime(1/4);
}
public function aethertwinsFollowersFeedEquipment(itype:ItemType):void {
	clearOutput();
	outputText("You deposit the item on the ground and approach the aether twins from it. Not to your surprise the item begins to melt as if turning to sludge as the twins zap them with some unknown magic the twins growing something not unlike magical teeth with which they begin munching on this new material. Before long the item is fully assimilated into the twins which acquire some of its powers.\n\n");
	outputText("\"<i>Thank you for the meal.</i>\" they grin.\n\n");
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
	if (AetherTwinsFoodMenuBuckler && AetherTwinsFoodMenuSGauntlet && AetherTwinsFoodMenuClaws) {
		outputText("\"<i>Woohoo we're evolving.</i>\" they exclaim. \"<i>We're going Faster Harder Better Stronger Curvier!!!</i>\"\n\n");
		outputText("<b>The Aether Twins base form evolved unlocking some of their sealed memories.</b>\n\n");
		player.createStatusEffect(StatusEffects.AetherTwins1, 0, 5, 0, 0);
		//player.addStatusValue(StatusEffects.AetherTwins1, 2, 5);
		AetherTwinsShape = "Human-tier Gaunlets";
		AetherTwinsFoodMenuTin = 0;
		AetherTwinsFoodMenuTinCap = 2;
		AetherTwinsFoodMenuCopper = 0;
		AetherTwinsFoodMenuCopperCap = 2;
		AetherTwinsFoodMenuIron = 0;
		AetherTwinsFoodMenuIronCap = 2;
		AetherTwinsFoodMenuSilver = 0;
		AetherTwinsFoodMenuSilverCap = 2;
		AetherTwinsFoodMenuGold = 0;
		AetherTwinsFoodMenuGoldCap = 2;
		AetherTwinsTalkMenu = 1;
	}
	doNext(aethertwinsFollowersFeed);
	cheatTime(1/4);
}
	}
}//do 781 linii na razie dodawać ^^
