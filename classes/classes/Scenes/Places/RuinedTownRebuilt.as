/**
 * Ruined Town Rebuilding with Amily and her Mouse-Morphs 
 * @author Candian Snas
 */
package classes.Scenes.Places 
{
import classes.*;
import classes.GlobalFlags.*;
import classes.Items.*;
import classes.Scenes.SceneLib;
import classes.internals.SaveableState;

import coc.view.MainView;
use namespace CoC;

public class RuinedTownRebuilt extends BaseContent implements SaveableState//, NPCAwareContent, TimeAwareInterface
{
	public static var RebuildState: int; //0 for uninitiated, 1 for Waiting, 2 for denied, 3 for started
	public static var ShouldraSeenTown:Boolean; //0 for unseen, 1 for seen, but not introduced, 2 for introductions and excorcized, 3 for accepted Shouldra, 4 for Guardian Spirit Shouldra.
	public static var HouseNumber:int; //The more houses, the more the town can grow
	public static var Housecap:int; //How many houses the town can safely have. Equal to Wallnumber*2, not including the first 20 houses.
	public static var YourHouse:Boolean; //whether or not the mouselets have built you a house
	public static var WellBuilt:Boolean;
	public static var ShopBuilt:int;
	public static var SmithBuilt:Boolean;
	public static var TrainingGroundsBuilt:Boolean;
	public static var MousetownPopulation:int; //Grows weekly, depending on how many mouselets you have, and the state of the town.
	public static var TelAdreScouts:int; //0 for unseen, 1 for seen and accepted, 2 for seen and unaccepted
	public static var InvasionCounter:int; //how many times the mouse-town's been invaded. 
	public static var JojoyLitters:Boolean; //whether or not Jojo/Joy has children living in the town. Affects Growth rate.
	public static var ChiChiSeenHere:Boolean;
	public static var ChiChiLitters:Boolean; //same as above, but Chi Chi. 
	public static var GrowthRate:int; //how many new mouselets will be born in town each week. 
	public static var MouseTownPopCap:int; //Each house adds 15
	public static var WallNumber:int; //Determines HouseCap
	public static var MiceArcherySessions:int;
	public static var logbuilt:Boolean;
	public static var AmilyAtWetBitch:Boolean;
	public static var AmilyAngerCooldown:int;
	public static var WeeklyGemTax:int;
	public static var WeeklyWoodGain:int;
	public static var prosperityvar:int;
	public static var OwcaSeen:Boolean;
	public static var FarmSeen:Boolean;
	public static var EdrynTownState:int; //0 for unseen, 1 for been, 2 if you've talked about bringing the foals, 3 if you've brought them. 
	public static var TelAdreSuppliesBought:Boolean;
	public static var ReapercheepBought:Boolean;
	public static var SeenBakery:Boolean;
	public static var SeenMatShop:Boolean;
	public static var SeenQuarryCorps:Boolean;
	public static var SeenStreaker:Boolean;
	public static var SeenMMelee:Boolean;
	public static var SeenAArmors:Boolean;
	public static var Intown:Boolean;

	public function stateObjectName():String {
		return "RuinedTownRebuilt";
	}
	
	public function resetState():void {
		RebuildState = 0;
		ShouldraSeenTown = false;
		HouseNumber = 0;
		Housecap = 20;
		YourHouse = false;
		WellBuilt = false;
		ShopBuilt = 0;
		SmithBuilt = false;
		TrainingGroundsBuilt = false;
		MousetownPopulation = 50;
		TelAdreScouts = 0;
		InvasionCounter = 0;
		JojoyLitters = false;
		ChiChiSeenHere = false;
		ChiChiLitters = false;
		GrowthRate = 1;
		MouseTownPopCap = 70;
		WallNumber = 0;
		MiceArcherySessions = 0;
		logbuilt = false;
		AmilyAtWetBitch = false;
		AmilyAngerCooldown = 0;
		WeeklyGemTax = 0;
		WeeklyWoodGain = 0;
		prosperityvar = 1;
		OwcaSeen = false;
		FarmSeen = false;
		EdrynTownState = 0;
		TelAdreSuppliesBought = false;
		ReapercheepBought = false;
		SeenBakery = false;
		SeenMatShop = false;
		SeenQuarryCorps = false;
		SeenStreaker = false;
		SeenMMelee = false;
		SeenAArmors = false;
		Intown = false;
	}
		
	public function saveToObject():Object {
		return {
			"RebuildState":RebuildState,
			"ShouldraSeenTown":ShouldraSeenTown,
			"HouseNumber":HouseNumber,
			"Housecap":Housecap,
			"YourHouse":YourHouse,
			"WellBuilt":WellBuilt,
			"ShopBuilt":ShopBuilt,
			"SmithBuilt":SmithBuilt,
			"TrainingGroundsBuilt":TrainingGroundsBuilt,
			"MousetownPopulation":MousetownPopulation,
			"TelAdreScouts":TelAdreScouts,
			"InvasionCounter":InvasionCounter,
			"JojoyLitters":JojoyLitters,
			"ChiChiSeenHere": ChiChiSeenHere,
			"ChiChiLitters":ChiChiLitters,
			"GrowthRate":GrowthRate,
			"MouseTownPopCap":MouseTownPopCap,
			"WallNumber":WallNumber,
			"MiceArcherySessions":MiceArcherySessions,
			"logbuilt":logbuilt,
			"AmilyAtWetBitch":AmilyAtWetBitch,
			"AmilyAngerCooldown":AmilyAngerCooldown,
			"WeeklyGemTax":WeeklyGemTax,
			"WeeklyWoodGain":WeeklyWoodGain,
			"prosperityvar":prosperityvar,
			"OwcaSeen":OwcaSeen,
			"FarmSeen":FarmSeen,
			"EdrynTownState":EdrynTownState,
			"TelAdreSuppliesBought":TelAdreSuppliesBought,
			"ReapercheepBought":ReapercheepBought,
			"SeenBakery":SeenBakery,
			"SeenMatShop":SeenMatShop,
			"SeenQuarryCorps":SeenQuarryCorps,
			"SeenStreaker":SeenStreaker,
			"SeenMMelee":SeenMMelee,
			"SeenAArmors":SeenAArmors,
			"Intown":Intown
		};
	}
	
	public function loadFromObject(o:Object, ignoreErrors:Boolean):void {
		if (o) {
			RebuildState = o["RebuildState"];
			ShouldraSeenTown = o["ShouldraSeenTown"];
			HouseNumber = o["HouseNumber"];
			Housecap = o["Housecap"];
			YourHouse = o["YourHouse"];
			WellBuilt = o["WellBuilt"];
			ShopBuilt = o["ShopBuilt"];
			SmithBuilt = o["SmithBuilt"];
			TrainingGroundsBuilt = o["TrainingGroundsBuilt"];
			MousetownPopulation = o["MousetownPopulation"];
			TelAdreScouts = o["TelAdreScouts"];
			InvasionCounter = o["InvasionCounter"];
			JojoyLitters = o["JojoyLitters"];
			ChiChiSeenHere = o[" ChiChiSeenHere"];
			ChiChiLitters = o["ChiChiLitters"];
			GrowthRate = o["GrowthRate"];
			MouseTownPopCap = o["MouseTownPopCap"];
			WallNumber = o["WallNumber"];
			MiceArcherySessions = o["MiceArcherySessions"];
			logbuilt = o["logbuilt"];
			AmilyAtWetBitch = o["AmilyAtWetBitch"];
			AmilyAngerCooldown = o["AmilyAngerCooldown"];
			WeeklyGemTax = valueOr(o["WeeklyGemTax"], 0);
			WeeklyWoodGain = valueOr(o["WeeklyWoodGain"], 0);
			prosperityvar = valueOr(o["prosperityvar"], 1);
			OwcaSeen = valueOr(o["OwcaSeen"], false);
			FarmSeen = valueOr(o["FarmSeen"], false);
			EdrynTownState = valueOr(o["EdrynTownState"], 0);
			TelAdreSuppliesBought = valueOr(o["TelAdreSuppliesBought"], false);
			ReapercheepBought = valueOr(o["ReapercheepBought"], false);
			SeenBakery = valueOr(o["SeenBakery"], false);
			SeenMatShop = valueOr(o["SeenMatShop"], false);
			SeenQuarryCorps = valueOr(o["SeenQuarryCorps"], false);
			SeenStreaker = valueOr(o["SeenStreaker"], false);
			SeenMMelee = valueOr(o["SeenMMelee"], false);
			SeenAArmors = valueOr(o["SeenAArmors"], false);
			Intown = valueOr(o["Intown"], false);
		} else {
			// loading from old save
			resetState();
		}
	}
	
	public function RuinedTownRebuilt() 
	{
		Saves.registerSaveableState(this);
	}

public function weeklyPopAdjustment():void {
	var divide:Number = 10;
	if (JojoyLitters > 0) divide -= 2;
	GrowthRate = MousetownPopulation / divide;
	MousetownPopulation = (MousetownPopulation + GrowthRate);
	if (MousetownPopulation > MouseTownPopCap) MousetownPopulation = MouseTownPopCap;
	prosperityvar = 1;
	if (JojoyLitters) prosperityvar += 1;
	prosperityvar += (MousetownPopulation / 10);
	if (WellBuilt) prosperityvar += 1;
	if (logbuilt) prosperityvar += 1;
	if (HouseNumber < ((WallNumber * 2) + 5)) prosperityvar += 3;
	if (ShopBuilt) prosperityvar += 1;
	if (TelAdreScouts == 1) prosperityvar += 1;
	if (FarmSeen) prosperityvar += 1;
	if (OwcaSeen) prosperityvar += 1;
	if (TrainingGroundsBuilt) prosperityvar += 2;
	prosperityvar = Math.round(prosperityvar);
	WeeklyGemTax = ((MousetownPopulation * prosperityvar ) / 2);
	WeeklyGemTax = Math.round(WeeklyGemTax);
	WeeklyWoodGain = 0;
	if (logbuilt) WeeklyWoodGain += 5;
	WeeklyWoodGain *= ((MousetownPopulation / 50) * (prosperityvar / 2));
	WeeklyWoodGain = Math.round(WeeklyWoodGain);
	//DoNext: (MouseTownWeeklyUpdate);
}


//After Pure Amily is a camp follower, and her kids have moved out, she approaches you. 
public function amilyRebuild():void {
	clearOutput();
	outputText("As you approach Amily, you can tell that the mouse-girl has something eating at her. <i>“Hey [name], I have...a request for you.</i>” The mouse girl fidgets nervously, then seems to put steel in her spine, squaring up. <i>“Our kids...Well, they need a big place to live, bigger than they could find. They need flattened land, and the best place they could find was...Well...The old village.</i>” Amily looks at you, trying to keep calm, but she’s obviously nervous. <i>“They’re grown, but they’re going to need help setting up. Will you come with me, just for a little while, and help them rebuild?</i>”\n\n");
	menu();
	addButton(1, "Help", amilyRebuildInit);
	addButton(2, "Delay", amilyRebuildNotNow);
	addButton(3, "No", amilyGoAway);
}

public function amilyRebuildInit():void {
	clearOutput();
	outputText("You tell Amily that you’ll be there for your kids. Her face brightens, her whiskers twitching happily and she all but tackles you in a warm, fuzzy hug. <i>“Well, no time like the present, right?</i>” She gently pulls you away from the camp, and you find yourself gently amused as she leads you back to the Old Town Ruins. As you near it, she wipes tears from her eyes. You stop, asking her if she’s alright, and she nods.\n\n");
	outputText("<i>“Just some mixed feelings, you know? It’s...hard to be back here again, but...We’re rebuilding. It’s everything I've thought about...For years.</i>” She wipes her tears on your shoulder, and as you get closer to the ruins, you notice your kids already hard at work. Amily picks herself up, and the two of you walk over. Your older kids nod respectfully, and make a spot for you as they divvy up tasks. You throw your back into it, gathering stones for a fireplace, setting up tents and carting water alongside your kids.\n\n"); 
	outputText("Soon enough, most of the day has passed, but every kid has a tent or A-frame to share. It’s not much, but it’s a start. Amily joins you and you head back to camp together, exhausted, but the tired joy on her face makes it worthwhile. The poor woman’s nearly dead on her feet and by the time you get back to camp. She dives into her bedroll, falling asleep almost instantly.\n\n"); 
	RebuildState = 3;
	doNext(camp.returnToCampUseFourHours);
}

public function amilyRebuildNotNow():void {
	clearOutput();
	outputText("You tell Amily that you will help, but you need time since you’re pretty busy right now. She nods, giving you a hug, but the look on her face is pure disappointment. She walks away, to her usual spot at camp.\n\n"); 
	RebuildState = 1;//Make a button in Amily talk to start the thing
	doNext(camp.returnToCamp);
}

public function amilyGoAway():void {
	clearOutput();
	outputText("You flatly deny her request, saying that as the champion, your first priority is the portal and that nothing is more important than that. This seems to anger Amily, and she begins berating you furiously. You turn your back and begin to leave the camp. Amily seems to deflate as you walk away, and you hear the sound of the mouse-girl crying behind you. Do you keep walking, or do you turn around and try to salvage the situation?\n\n"); 
	menu();
	addButton(1, "Turn Around", amilyReassure);
	addButton(2, "Walk Away", amilyWalkAway);
}

public function amilyReassure():void {
	clearOutput();
	outputText("You turn back around, kneeling down beside the crying woman. She raises her head and you wrap your arms around her. As she cries into your shoulder, you explain that you really do care about the family you started together, but that your entire village back home is depending on you as well. She seems to understand, but when you pull back, she seems despondent. As you back away, she looks up at you. <i>“I’m sorry</i>”, she says simply. You apologise too, but she shakes her head. <i>“I’m heading to Tel’adre for a while. Don’t come looking for me, please</i>”.\n\n"); 
	AmilyAtWetBitch = true;
	AmilyAngerCooldown = 168;
	doNext(camp.returnToCampUseOneHour);
	//(Amily will be in the Wet Bitch and will talk to you again after a week ingame. You have the option to salvage your relationship with her, or lose her forever if you refuse to help a second time).
}

public function amilyWalkAway():void {
	clearOutput();
	outputText("Amily’s been too needy lately. You need some space. When you get back to your camp, her bedroll is gone. You have the feeling that she left to be with your kids, but you don’t really know.\n\n"); 
	flags[kFLAGS.AMILY_FOLLOWER] == 0;
	RebuildState = 2;
	doNext(camp.returnToCampUseOneHour);
}

public function amilyMadBar():void {
	clearOutput();
	outputText("You notice Amily sitting down in front of the bar, nursing a drink. You sit down wordlessly beside her, but as Amily looks over at you, her eyes burn, red from crying. She doesn’t say anything, but she clenches her fists, clearly still mad at you. You decide to leave your angry mouse-morph alone, especially since some of the bar’s patrons are giving you the stink-eye. You leave the bar and head back to camp.\n\n"); 
	doNext(camp.returnToCampUseOneHour);
}

public function amilyBarTalk():void {
	clearOutput();
	outputText("You notice Amily at the bar, nursing some kind of fruit juice. She seems much calmer, and as you sit down, she sighs heavily. For a few seconds, neither of you speak, the silence building between you.\n\n"); 
	outputText("“...Hey.” She breaks the ice, voice low, but not angry. “...Are you doing alright?” Taken aback by her question, you fumble your answer, eventually telling Amily that yes, you’re alright, but you’re more worried about her.\n\n");
	outputText("“I suppose that’s fair.” Amily says. “...I’m not going to lie, [name], the first few days were hell. You…You’ve been good to me, and…I guess I just, kind of expected you to keep helping.” You open your mouth to speak, and Amily puts a finger over your mouth. “...Shh…Let me get through this, okay?” You nod, and she continues, leaning over the counter. “...But I’ve had a lot of time to think, and…I realised that I’ve…been putting a lot of pressure on you. You came here with your own quest, your own goals, and…I guess I needed you to refuse me, before it really sunk in.” Amily puts a hand on your shoulder. “I’m sorry. For demanding so much, and then…blowing up on you when you refused.” She hangs her head. “I love you…So much, and I…almost blew it.” Amily looks into your eyes, giving you a hopeful look. “I was able to find a place for now, near the farm. Demons don’t go there, and our kids can get work from Whitney, in exchange for shelter. It’s not a good long-term solution, but…Until we can start construction on the ruins, it’ll do.” She gives you a pleading look, eyes damp.\n\n");
	outputText("“We can wait for now, until you’ve got the time…But please, our kids need a proper home…and I don’t think we can do it without you.”\n\n");
	outputText("You wrap your arms around Amily, letting the mouse-morph bury her head into your chest. Soothingly, you tell Amily that you missed her. That you just need some time, but once you’re ready, you’ll be there to ensure that your offspring have a safe town to call home.\n\n"); 
	outputText("Shaking, Amily sobs into you, tension bleeding from her muscles. “I love you.”\n\n");
	outputText("Together, you and Amily stand, leaving Tel’Adre and heading back to camp.\n\n");
	flags[kFLAGS.AMILY_FOLLOWER] = 1;
	AmilyAtWetBitch = false;
	//add the button in Amily's talk menu to start the town building init
	doNext(camp.returnToCampUseOneHour);
}
	
}
}