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
import classes.Scenes.NPCs.AmilyScene
import classes.Scenes.Camp.CampStatsAndResources
import classes.Scenes.Dungeons.DemonLab
import classes.internals.Utils;

import coc.view.MainView;
use namespace CoC;

public class RuinedTownRebuilt extends BaseContent implements SaveableState
{
	public static var RebuildState:int; //0 for uninitiated, 1 for Waiting, 2 for denied, 3 for started
	public static var ShouldraSeenTown:int; //0 for unseen, 1 for seen, but not introduced, 2 for introductions and excorcized, 3 for accepted Shouldra, 4 for Guardian Spirit Shouldra.
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
		ShouldraSeenTown = 0;
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
	prosperityvar = 0;
	if (MousetownPopulation > MouseTownPopCap) MousetownPopulation = MouseTownPopCap;
	prosperityvar = 1;
	if (JojoyLitters) prosperityvar += 3;
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
//--------------------Town Events--------------------

	public function MouseTownWeeklyUpdate():void {
		clearOutput();
		if (logbuilt) {
			WeeklyWoodGain = (prosperityvar/2);
		}

		if ((MousetownPopulation) == (MouseTownPopCap)) {
			outputText("As you wake up and head outside, getting ready for the day, you see one of your mouse-morph children standing awkwardly next to Amily. As you meet their gaze, they walk over, looking you in the eyes. \n\n");
			outputText("<i>\"Hey, "+ player.mf("father", "mother") +", I'm sorry to ask for your help again so soon, but the town's still growing, and we're going to need more houses soon. No pressure or anything, but we'd really appreciate your help.</i>\n\n");
		}
		if ((WeeklyGemTax) > 0) {
			outputText("He hands you a small sack, smiling. <i>\"We're grateful for all the help you've given us. We've been growing, so we decided to go around and collect some gems. Here's what we could spare this week.</i>\n\n");
			player.gems += WeeklyGemTax;
			outputText("You've Gained" +(WeeklyGemTax)+ "Gems!\n\n");
		}
		if ((WeeklyWoodGain) > 0) {
			outputText(" You watch as several more of your children carry pieces of well-cut lumber into your camp. With a grin, your mousey son sees where your gaze is. <i>\" Since you've been using your own resources to help build our hometown, it only seems right that we give back.</i>\" \n\n");
			flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] += WeeklyWoodGain;
			if (flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] > 1200 && flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] >= 3) flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] = 1200;
			else if (flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] > 400 && flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] < 3) flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] = 400;
			outputText("You've Gained" +(WeeklyWoodGain)+ "Wood!\n\n");
		}

		outputText(" With that said, he scampers off, heading back towards the village. \n\n");
		Intown = false;
		doNext(camp.returnToCamp);
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
	flags[kFLAGS.AMILY_FOLLOWER] = 0;
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
	public function EdrynBringsSupplies():void {
		clearOutput();
		outputText("The gate to your town is open, and a few carts have come through. Your mouse-children ooh and ahh at the carts, flanked by a scant dozen of Tel’adre’s guards, as they near the center of town. The guards are watching closely, but for the most part, the feeling in the village is one of excited contentment.  \n\n");
		outputText("<i>“We bought those the last time the runts went into Tel’adre”</i>, Amily explains, striding up behind you and leaning her head onto your shoulder. <i>“Took us a while to be able to get an armed escort.”</i>  \n\n");
		if (EdrynTownState == 0) {
			outputText("Edryn trots along behind the last wagon, and she gets a glimpse of you and Amily. “So, you two are the ones responsible for this town, huh?” She smiles slightly, her eyes taking in all the numbers, then back to you two, a knowing smile on her face. <i>“Nice.”</i>  \n\n");
			outputText("Amily blushes bright red at that. <i>“I-I mean, we didn’t, I mean, we did, just not-</i> \" Edryn and you both break out laughing at her embarrassment, and the Centauress pats Amily on the shoulder.  \n\n");
			outputText("<i>“Oh, don’t worry, pet. I got the memo from the wolf brothers. Increased fertility and growth rate from Gobbo drugs. Enough to repopulate an entire race.” She gives your kids an approving nod. “And did pretty good, from the looks of things”.</i> Your kids unload the wagons, and she turns around as the guards begin to file out of the town. \n\n");
			EdrynTownState = 1;
		}
		if ((flags[kFLAGS.EDRYN_NUMBER_OF_KIDS] > 0) && (EdrynTownState) < 2) {
			outputText("Edryn turns back suddenly. <i>“Hey [name], maybe we should bring the foal(s) out here sometime.”</i> Amily looks at you, confused, and Edryn shakes her head. <i>“Oh, you didn’t know, did you?”</i> She taps her back hoof against the ground. <i>“Suffice to say, your little ones have some half-siblings in Tel’adre”.</i> Edryn grins at Amily’s discomfort. <i>“Oh, don’t worry, pet. [name] and I are friends with benefits. I’m not gonna take ‘em from you”.</i> She looks at the village, a rather wistful look in her eyes. <i>“Would just be nice for the foals to meet their siblings, that’s all”.</i> \n\n");
			outputText("As Urta leaves, you look over nervously at Amily, who rolls her eyes at your expression. \"What, you think I'm going to flip out over this or something?\" Amily puts a hand on your shoulder, sighing slightly. \"[Name]...after all you've done for me, for our little ones, you think I'd be angry at that?\" \n\n");
			outputText("You answer an honest 'Yes', and Amily shakes her head. \"No, I've known you have other lovers. I live with you, remember?\" You nod, and she looks out at the town. \"I know, in my heart, that you have more than enough love to share. Knowing my kids have siblings they can meet? Well, it's odd, but not in a bad way.\" She smiles at you reassuringly. \"I think I have enough evidence to prove your love for me.\" \n\n");
			EdrynTownState = 2;
		}
		TelAdreSuppliesBought = false;
		cheatTime (1);
		doNext(enterVillage);
	}

	public function ScoutsVisitInit(): void {
		clearOutput();
		outputText(" \n\n");
		outputText("As you near your mouse village, you hear a growling, raspy voice unlike any among your children. Two wolfish men stand outside the town gates, with perplexed looks on their faces. Your children have them at bowpoint from on top of their walls. You blink as you recognize the emblem on their armour. These two wolves are from the Tel’adre guard! \n\n");
		outputText("“Look, we just want to make sure that there’s no demons around these parts.”  \n\n");
		outputText("“And how do we know you’re not demons yourselves?” A single guard replies, bow drawn taut. \n\n");
		outputText("At both sides’ mounting frustration, you step into view. The mice begin to make happy noises, but you give them a level stare. They keep their weapons out, but lower them.  \n\n");
		outputText("“Who are you?” One of the wolves ask.(If you did Raphael’s questline with them in it) “(he/she)’s the one we ran into chasing Raphael”. The other grunts.  \n\n");
		outputText("(Otherwise) “We’ve seen this one around Tel’adre”. (If Lover Urta is unlocked) “Urta’s mate.” You explain to the wolf brothers that these are your kids, and you won’t have anyone, demon or otherwise, harming them.  \n\n");
		outputText("“All of them are your kids?” They don’t seem to believe you, but as Amily walks out, she sees you talking to the wolf brothers. She wraps an arm around you.  \n\n");
		outputText("“Yes. These are our children.” The Wolf brothers blink rapidly, but as Amily explains how she did it, they nod.  \n\n");
		outputText("“A noble goal, bringing a race back to life in these times”. The taller one gives you a more respectful nod. “I’m Skoll, and this is my brother, Hati. We scout the areas deemed too dangerous for most town guardsmen”.  \n\n");
		outputText("“Could you let us in?” Hati asks. “Finding another town like this...especially one free of demonic taint? We just need some information for our report.” His tail is wagging, but his face remains serious. “And...It would be nice for the public to know we have allies out there. Even if they’re far away.”  \n\n");
		outputText("(Letting them in opens up potential interaction between Tel’adre and your mouse-town,. There could be some real benefits for your kids if you open up to the city of the sands).  \n\n");
		menu();
		addButton (1, "ComeIn", TelAdreOpen);
		addButton (2, "No", NoTelAdre);
	}

	public function NoTelAdre():void {
		clearOutput();
		outputText("You politely decline, stating that you don’t want to risk your kids by having them outside the walls if you can avoid it. The wolf-brothers nod respectfully, dashing away with a curt “We will inform the council.”  \n\n");
		outputText("Amily looks conflicted as they walk away. You get the feeling that she wants to have open communications with TelAdre.  \n\n");
		TelAdreScouts = 2;
		cheatTime (1/2);
		doNext(enterVillage);
	}

	public function TelAdreOpen():void {
		clearOutput();
		outputText("Any member of the Tel’adre guard should be trustworthy, besides, with so many of your kids, Amily and yourself around, they’d be stupid to pull anything right now. You give the order for the gates to be opened, and they are, only a few seconds later than usual.  \n\n");
		outputText("The wolf brothers listen to you intently as you describe the town, guiding them through the basic buildings and what you’re planning to make. A few of the mouse guard follow, but they seem much more relaxed with you around. As the tour ends, the wolves seem pleased, tails wagging and shoulders more relaxed. They exit the gates, nodding respectfully to you and Amily.  \n\n");
		outputText("“We’ll talk to the council”, Skoll says as you pass the ditch. “I’m sure they’d be happy to form an alliance.”  \n\n");
		outputText("“Don’t promise what we can’t deliver”, Hati chides, but he shrugs. “He’s probably right, but…”  \n\n");
		outputText("“In these times, we need all the help we can get.” Skoll says simply. “I assume either of you are fine to speak on this town’s behalf?”  \n\n");
		outputText("Amily nods, and the two wolf brothers wave back at the village and its guards. “Sorry for the misunderstanding.” With that, they run into the forest.  \n\n");
		TelAdreScouts = 1;
		cheatTime(1 / 2);
		doNext(enterVillage);
	}
		public function MiceBuiltHouse4U():void {
			clearOutput();
			outputText("At your arrival, a cry goes up from your mouselets standing guard. A veritable horde comes streaming out from the village as your mouse-children surround you. This seems a little different from the usual, their faces still happy, but as you open your mouth to ask them what’s going on, a rag is thrown to you.  \n\n");
			outputText("<i>“We have a surprise for you, "+ player.mf("father", "mother") +".</i>” A calm voice speaks up from within the mass. <i>“Just put on that blindfold, and we’ll bring you to it.</i>” You think for a moment, but with the expectant faces around you, there’s only one choice, really. You put the blindfold on gamely, tying it loosely around your head. As you do so, you feel a few hands reach behind, making sure the rag’s tied tight.  \n\n");
			outputText("<i>“No peeking!</i>” A giddy voice behind you whispers, and you can feel the mouse behind you gently push, guiding you into town. By the steps you’re taking, you can guess you’re somewhere near the middle of town. The guiding hands push you into another mouse, and you hear Amily’s voice beside you.  \n\n");
			outputText("<i>“Kids, I’m starting to lose my patience. What do you want to show me?</i>” Amily asks, wrapping her arms around you in what’s probably intended to be a stern attempt at a pin. <i>“Oh, it’s you [name]. Kids got you too, huh?</i>” You confirm that you just got here, and they seemed intent on showing you something.  \n\n");
			outputText("<i>“Awesome! Now face ‘em over here, guys!</i>” An enthusiastic voice rings out. <i>“And...Take them off now, mom and "+ player.mf("dad", "mother") +"!</i>” You remove the blindfold, and what you see makes you gasp. A tower made of wood and stone sits in the center of town. The facade is made from a few different types of stone, likely gathered from near the river, but the building goes up a good forty feet into the air. The first few floors are primarily made from stone, but the rest are made from oak from the edge of the forest.  \n\n");
			outputText("<i>“You made no few houses for us, "+ player.mf("father", "mother") +", so we decided you and mother needed one here.</i>” Amily gasps, looking at the tower in awe. <i>“You built us a tower?!</i>” She finally squeaks, but a few burlier mice chuckle, walking over to explain things.  \n\n");
			outputText("<i>“No, mom, "+ player.mf("father", "mother") +". The first two floors and the basement are yours. We were building this to be a fortification, but...We realised we could use the space.</i>” He points to a small hole near the left side. <i>“That’s a vent for a wood-burning stove we put in, and over there are the stairs so we can get guards to the top without disturbing you.</i>” He gives you a wide grin. <i>“I hope you enjoy it.</i>”  \n\n");
			outputText("You look at Amily, who’s still in awe at the towering structure your kids have built. You chuckle, offering Amily your hand. She takes it, and you guide her into the dwelling. There’s a small nook where you can take off your shoes, and a place to hang up a few sets of clothes or armour. Outside of that, and a room in the left-back corner, the whole first floor is wide open. There’s clearly marked places to set up a couch or bench, an iron stove, and places to store foodstuffs or dishes.  \n\n");
			outputText("Inside the back room is a small tub, barely big enough to fit you and Amily if you want to be very close. Amily looks at it, then at you, a sly little smile on her face as if she’s getting ideas \n\n");
			outputText("Along the right wall, a sturdy set of stairs leads up to the second floor. There are two main areas on this floor. One smaller area is clearly set up to be a nursery of sorts, with several cribs already built inside it. The second is a master bedroom. The bed is quite large, built like a massive basket into one corner. It takes up a good half of the room, however, and Amily squeals in delight, shoving you as hard as she can onto the bed. You could have easily dodged the blow, but you let her have her fun, sprawling on the bed as she leaps down beside you.  \n\n");
			outputText("<i>“The kids seem to think we’ll be giving them more siblings.</i>” Amily says. <i>“And...I wouldn’t be opposed to it.</i>” She cuddles close to you. <i>“Thank you [name].</i>” Her hug is like a fuzzy vice, and as she pulls a thick blanket over you both, you find yourself relaxing, just lying there, for the first time since entering Mareth. After a while you turn your head, to see Amily staring at you, a smile on her face.  \n\n");
			outputText("<i>“You’re cute when you’re so relaxed like that.</i>” Amily whispers. You give her a kiss on the mouth, gentle and sweet, before standing back up. Between the tour and the...nap? It’s taken you two hours. As you head back to camp, Amily joins you. Your children are evidently disappointed to see you go, but the ones on guard salute as you leave. \n\n");
			YourHouse = true;
			Intown = false;
			doNext(camp.returnToCampUseTwoHours);
		}
	//--------------Town Functions
	public function enterVillage():void {
		clearOutput();
		Intown = true;
		if ((TelAdreScouts) == 0) {
			doNext (ScoutsVisitInit);
		}
		if (TelAdreSuppliesBought) {
			doNext (EdrynBringsSupplies);
		}
		outputText("Since your children moved in, the old village has taken on new life. You decide to head over to where your mousey brood now live.\n\n");
		if (HouseNumber<11) {
			outputText("The small town is still mostly ruins, but the many mice bustling around makes the old ruins less sad. \n\n");
		}
		else if (HouseNumber<20) {
			outputText("A good number of houses have sprung up, each holding no small number of your mouse-kids. While the town ruins are far from gone, new life has clearly come to this place.\n\n");
		}
		else if (HouseNumber>19) {
			outputText("The town has entirely taken over the ruins. There are a few older buildings here and there, but even those seem to be in use. You're filled with pride, knowing you and Amily revived this once-barren place.\n\n");
		}
		if (YourHouse) {
			outputText("The tower-house your mouselets built for you stands in the middle of town, offering a solid vantage point for the town’s guards.  \n\n");
		}
		if (WellBuilt) {
			outputText("A solidly built well sits near the middle of town. It evidently sees a lot of traffic, judging by the line-up around it. \n\n");
		}
		if (ShopBuilt>0) {
			outputText(" "+ShopBuilt+" Shops line the main road of the town, with a loud mouse morph hawking their wares in each. \n\n");
		}
		if (SmithBuilt) {
			outputText("The loud ringing of iron fills the air, and two mouselets operate stalls nearby the smithery. They’re hawking their wares to anyone around to hear, weapons and armor made by your children. You wonder how their gear compares to that of Tel’adre. \n\n");
		}
		if (TrainingGroundsBuilt) {
			outputText("The sounds of combat rise up periodically from the west side of town. Your mouse children have started their own...guard? Army? You’re not sure which. There seem to be a number of mouselings drilling with simple spears. Some appear to have gotten pieces of gel armor, and others wear shields of simple wood on their left arms. \n\n");
			outputText("Still more have somehow obtained their own ranged weapons.")
		}
		if (TelAdreScouts == 2) {
			outputText("A single wolfman, out of place among the mice, sits on a makeshift chair outside the wall. He nods once at you, but makes no motion to leave his chair. Your kids on watch seem to be used to him, but they still watch him out of the corners of their eyes.  \n\n");
		}
		outputText("Your oldest mouse-children seem to be everywhere. Some stand guard, and as you walk by, a few break from their watch. Some are content to nod respectfully at you, while a few others seem to take more after their mother, bounding up to you and wrapping their arms around you. Shooing the more affectionate of your children away, you enter the village, a small smile on your face.  \n\n");

		if (player.hasStatusEffect(StatusEffects.PureCampJojo)) {
			outputText("on the outskirts of the training grounds, you see a familiar mousey monk leading a small group of your children in meditation.  \n\n");
		}
		/*if (JojoyLitters == true) {
			outputText("Amily’s brood appear to not be the only ones here, as"+if (player.hasStatusEffect(StatusEffects.PureCampJojo))+"Jojo" +if flags[kFLAGS.JOJO_BIMBO_STATE] = 3 +"Joy"  "can be seen sitting on a log,  with" +if player.hasStatusEffect((StatusEffects.PureCampJojo, 0, 0, 0, 0)+"his" +if (flags[kFLAGS.JOJO_BIMBO_STATE] = 3) +"her" "litters of mouselets in front of (him/her). (Jojo/Joy) appears to be teaching them the most basic of the forms from the Lotus Path. They’ve set up their own little cubbyholes inside the village. \n\n");
		}

		 */
		if (flags[kFLAGS.SHOULDRA_FOLLOWER_STATE] != 1 && ShouldraSeenTown == 0)
		{
			outputText ("A small shack sits on the outskirts of the village. Your mousey children avoid it for some reason. You strongly suspect that Shouldra is inside it.  ")
		}
		if (flags[kFLAGS.SHOULDRA_FOLLOWER_STATE] != 1 && ShouldraSeenTown == 1) {
			outputText ("Shouldra's shack sits on the outskirts of the village. Your mousey children play near it, but don't go inside. ")
		}
		if (flags[kFLAGS.SHOULDRA_FOLLOWER_STATE] != 1 && ShouldraSeenTown == 2) {
			outputText ("Shouldra's shack has been destroyed, and you feel a vague sense of malice coming from the ground on which it had stood. Incense burns around the site, as if to ward off evil. ")
		}
		if (flags[kFLAGS.SHOULDRA_FOLLOWER_STATE] != 1 && ShouldraSeenTown == 3) {
			outputText ("Shouldra's shack has been repaired, upgraded to a normal-looking house. As you watch, one of your mouse-children enters the home, and one of your sons leaves, cheeks flush and clothing tented. Clearly, Shouldra's getting some visitors regularly.")
		}
		if (flags[kFLAGS.SHOULDRA_FOLLOWER_STATE] != 1 && ShouldraSeenTown == 4) {
			var choice0:Number = rand(4);
			switch (choice0) {
				case 0:
					break;
				case 1:
					outputText ("Shouldra's house has floating torches outside it, and she's clearly had some fun decorating the place, shadow-puppets and cheesy fake spiderwebs hanging from lines outside. You notice some of your children inside, sitting around a small firepit in the middle of the house. Shouldra, from within the flames, makes shapes, clearly telling some sort of story. ")
					break;
				case 2:
					outputText ("Shouldra's house has floating torches outside it, and she's clearly had some fun decorating the place, shadow-puppets and cheesy fake spiderwebs hanging from lines outside. Her windows have been shut, and from inside, you can hear some telltale rhythmic thumps, and moans of pleasure. ")
					break;
				case 3:
					outputText ("Shouldra's house has floating torches outside it, and she's clearly had some fun decorating the place, shadow-puppets and cheesy fake spiderwebs hanging from lines outside. Shouldra herself lazes on a deck-chair, spectral eyes closed and a small smile on her face. Your spectral friend seems content with life...or at least, what passes for her life, now. ")
					break;
				default:
					outputText ("Shouldra's house has floating torches outside it, and she's clearly had some fun decorating the place, shadow-puppets and cheesy fake spiderwebs hanging from lines outside. You notice some of your children inside, sitting around a small firepit in the middle of the house. Shouldra, from within the flames, makes shapes, clearly telling some sort of story. ")
			}

		}
		if ((YourHouse = false) && (prosperityvar >= 10) && WellBuilt && TrainingGroundsBuilt) {
			doNext (MiceBuiltHouse4U);
		}
		menu();
		addButton (1, "Visit", MouseTownVisit);

		if (TrainingGroundsBuilt) {
			addButton (2, "Train", MouseTrainField);
		}
		if (ShopBuilt>0) {
			addButton (3, "Shop", MouseShopArea);
		}
		else if (ShopBuilt == 0) {
			addButtonDisabled (3, "N/A", "You must build a shop first.")
		}
		if (WellBuilt) {
			addButton (4, "Well", MouseWell);
		}
		else if (!WellBuilt) {
			addButtonDisabled (4, "N/A", "You must rebuild the well first.")
		}
		addButton (5, "Dinner", EveningMeal);

		addButton (6, "Build", MouseTownBuild);
		if (YourHouse) {
			addButton (7, "TowerHouse", YourAmilyHome)
		}
		else if (!YourHouse) {
			addButtonDisabled (4, "???", "The Town isn't prosperous enough for this, yet.")
		}
	}
	public function YourAmilyHome():void {
		outputText("NYI");
	}


	public function MouseWell():void {
		clearOutput();
		outputText("You throw the bucket back down into the well, and a few moments later, begin turning the wheel to bring it back up. Pure clean water is in the wooden bucket, and you drink a little, bottling most of it. The water here is pure, and drinking from the well clears your head a little.  \n\n");
		outputText(" \n\n");
		dynStats("lus", -25, "cor", -.5, "scale", false);
		player.refillHunger(15);
		if(player.cor > 50) dynStats("cor", -1);
		if(player.cor > 75) dynStats("cor", -1);
		advanceMinutes(15);
		inventory.takeItem(consumables.S_WATER, enterVillage);
	}

	public function MouseTownVisit():void {
		clearOutput();
		outputText("There are a few people in this town you\'ve helped to build. Who would you like to visit? \n\n");
		menu();
		addButton (1, "Amily", MouseTownAmily);
		if (player.hasStatusEffect(StatusEffects.PureCampJojo)) {
			addButton (2, "Jojo", MouseTownJojo);
		}
		else if (flags[kFLAGS.JOJO_BIMBO_STATE] == 3) {
			addButton (2, "Joy", MouseTownJoy);
		}
//if Chi Chi is there
//addButton (3, "Chi-Chi", MouseTownChiChi);
		if (TelAdreScouts == 2) {
			addButton (4, "Wolfman", AmbassadorGreet);
		}
		addButton (5, "Shouldra", ShouldraRebuilt);
	}

	public function MouseTownJojo():void {
		clearOutput();
		outputText("Not Yet written \n\n");
		doNext(enterVillage);
	}

	public function MouseTownJoy():void {
		clearOutput();
		outputText("Not, like, Yet written. Sorry Cuties~ \n\n");
		doNext(enterVillage);
	}

	public function MouseTownAmily():void {
		clearOutput();
		outputText("Amily sees you approach, and she bounces over. Opening your arms wide, you pick her up, spinning her around as she jumps into your arms. This gets a variety of coos, chuckles and other happy noises from your children. Some of the younger ones rush over, and before you or Amily realise it, you’re in the center of a massive group hug. The older ones take their time getting over, enjoying the sight of their parents getting swarmed, but eventually they break the hug up. Amily is slightly dishevelled, but has a grin from ear to ear as she looks you up and down.  \n\n");
		outputText("“Hey [name]”, she says quietly, blushing slightly, her arms still around you. Clearly she enjoyed that. \n\n");
		//if Amily is pregnant
		outputText("Amily guides one of your hands to her belly, giving you a happy bob as you rub her. “You know, I’m getting used to this.” She says teasingly.  \n\n");
		//if PC pregnant
		outputText("Amily puts a hand on your belly. “Oh, I’m so happy you came by. You look so...Cute right now.” She nuzzles your neck. \n\n");
		//if both preg
		outputText("Amily rubs her pregnant belly against yours, blushing slightly. “Well, aren’t we a fun pair?” She gropes your [ass], her tail wrapping around your thigh. “Well, our kiddos shouldn’t be short on hands, at least.” \n\n");
		outputText("“What brings you back to me?” \n\n");
		doNext(AmilyTownie);
	}
	public function AmilyTownie():void {
		outputText("Not, like, Yet written. Sorry Cuties~ \n\n");
		menu();
			addButton (1, "Back", enterVillage);

	}
	//---------SHOPS AND SERVICES-----------

	public function MouseShopArea():void {
		clearOutput();
		if (ShopBuilt >= 1) {
			outputText(" One of your mouselets sits behind a kiosk, the sign above it saying \"Heart and Soul Bakery\" in bright blue lettering. Around the stand, there\'s a wide variety of chairs and tables, and a few of your kids are sitting around, enjoying a meal.  \n\n");
		}
		if (ShopBuilt >= 2) {
			outputText("One of your mouselets, a beige-furred male with a wide-brimmed leather hat, has his feet up on a stand, labelled \"Exotic Materials\" \n\n");
		}
		if (ShopBuilt >= 3) {
			outputText("One of your mouselets, a female with wide yellow eyes and burly arms, rests her forearms on her stand. A sign with a stylized pickaxe hangs above it. \n\n");
		}
		if (ShopBuilt >= 4) {
			outputText("Several of your children sit in some chairs around a simple stand, ran by a single, lithe mouselet. He pours drinks, talking quickly and warmly. He sees you, giving you a roguish smile. \n\n");
		}
		if ((SmithBuilt = true) && (ShopBuilt >= 5)) {
			outputText("Outside the smithery is a single,  snow-white, mouse-girl sitting at a stand. Daggers and various small weapons sit on the stand, and she smiles brightly at anyone who approaches. \n\n");
			if (prosperityvar >= 14) {
				outputText("To the left of the stand is a weapon rack with a variety of spears on it. \n\n");
			}
			if (prosperityvar >= 18) {
				outputText("To the right of the stand, several axes and swords hang from a framed rack.  \n\n");
			}
			if (prosperityvar >= 20) {
				outputText(" \n\n");
			}
			if (prosperityvar >= 30 && ShouldraSeenTown == 4 && !ReapercheepBought) {
				outputText("The stand seems to be glowing, and the girl behind the stand grins wickedly. In front of the stand sits several rapiers. In the middle, nestled in black velvet, sits the source of the glow, an intricately engraved rapier. The blade ripples, folded metal reflecting its own light. The handguard is large, carved steel brushed with gold, and as you turn it over, you realise that its guard is shaped like Amily\'s head, with Sapphires for eyes. As you look at it, the girl nods solemnly. <i> \"That is my Daddy\'s finest work yet.</i> She\'s uncharacteristically somber. <i> \"ReaperCheep: Forged from starmetal, slathered in the sap of Marae, enchanted by our Guardian Spirit Shouldra, embued with SoulForce from the Race-Mother, Amily, and quenched in the donated blood of our people. This sword speaks to our will...And is only to be wielded by those who\'s blood pumps within our hearts. </i>\" She looks up at you, eyes shining. <i> \"It would be fitting, then, for you. </i> \n\n");
			}
		}
		if ((SmithBuilt = true) && (ShopBuilt >= 6)) {
			outputText("Outside the smithery is a single mouse-boy with coal-black fur. Steel glimmers in his eyes and on his stand, shields leaning against the wooden stand. \n\n");
			if 	(prosperityvar >= 14) {
				outputText("Hanging from racks are a variety of different pieces of armor, made from simple materials. \n\n");
			}
			if (prosperityvar >= 18) {
				outputText("Behind the stall are several rows of heavier armors, more intricately built than before. \n\n");
			}
			if (prosperityvar >= 20) {
				outputText("You notice several new-looking armors, made from fine steel. \n\n");
			}

			if (prosperityvar >=30) {
				outputText(" A single set of mail, thin yet strikingly strong-looking, hangs from the front of the stall. As you look, the silvery metal darkens, casting the stall around it in shadow for a single moment. The shoulders are inlaid with copper and gold, thin \'whiskers\' of metal poking out to the sides. <i>\"Ah, of course you\'d notice my mother\'s magnum opus.</i>\" The boy says proudly. <i>\"Lighter than a feather, yet stronger than plate. Each ring is a mixture of Starmetal and Silversteel, ground down with stones taken from the ancient wizard\'s tower then forged in Foxfire, tempered in paper-talisman-fuelled WhiteFire and quenched in Purity Philter, enchanted by our Guardian Spirit Shouldra, this is the Sentinel mail, ShǔRato. It\'s one of a kind armor, magically bound to our town and its people.\" \n\n");
			}
		}


		menu();
		if (ShopBuilt >= 1) {
			addButton (1, "Bakery", MouseTownBakery);
		}
		else if (ShopBuilt < 1) {
			addButtonDisabled (1, "???", "Haven\'t Built Enough Stores")
		}
		if (ShopBuilt >= 2) {
			addButton (1, " ", MouseTownRareGoods);
		}
		else if (ShopBuilt < 2) {
			addButtonDisabled (2, "???", "Haven\'t Built Enough Stores")
		}
		if (ShopBuilt >= 3) {
			addButton (1, "Gatherer", MouseTownMining);
		}
		else if (ShopBuilt < 3) {
			addButtonDisabled (3, "???", "Haven\'t Built Enough Stores")
		}
		if (ShopBuilt >= 4) {
			addButton (1, "Bar", MouseTownBar);
		}
		else if (ShopBuilt < 4) {
			addButtonDisabled (4, "???", "Haven\'t Built Enough Stores")
		}
		if ((SmithBuilt = true) && (ShopBuilt >= 5)) {
			addButton (5, "Weaponshop", MouseTownWeaponry);
		}
		else if (ShopBuilt < 5) {
			addButtonDisabled (5, "???", "Haven\'t Built Enough Stores")
		}
		else if (!SmithBuilt) {
			addButtonDisabled (5, "???", "This shop needs a Smithery")
		}
		if (SmithBuilt && (ShopBuilt >= 6)) {
			addButton (1, "Armor Shop", MouseTownArmor);
		}
		else if (ShopBuilt < 6) {
			addButtonDisabled (6, "???", "Haven\'t Built Enough Stores")
		}
	}

	public function MouseTownBakery():void {
		clearOutput();
		outputText("Nothing is here yet. Bug Snas about it \n\n");
		outputText(" \n\n");
		outputText(" \n\n");
		outputText(" \n\n");
		outputText(" \n\n");
		outputText(" \n\n");
		menu();
		addButton (1, "Back", enterVillage);
	}
	public function MouseTownBar():void {
		clearOutput();
		outputText("You stride up to the outdoor bar, and a single mouse-woman in a black dress greets you. “H-hey "+player.mf ("Dad", "Mom")+", welcome to the Sunlit Streaker.” She brings you over to a seat, and you look at the menu. For now, the menu is pretty barren, all it says is ALE in letters large enough to cover the menu. You look up, slightly annoyed, but also amused. \"Do you want a drink? We don't have different types of drink, for now. Just ale. 3 gems a pop.\n\n");
		menu();
		addButton (1, "Ale", MouseTownDrink);
		addButton (2, "Back", MouseShopArea);
	}

	public function MouseTownDrink():void {
		outputText("You nod, and your odd daughter skips off, coming back with a crude clay mug full of amber ale. Despite the town's recent revival, the ale is sweet, the work of a competent brewer. \n\n");
//Make the PC slightly Drunk
		doNext (enterVillage);
	}


	public function MouseTownRareGoods():void {
		clearOutput();
		if (SeenMatShop) {
			outputText("Rum-Runner smiles as you return. “Welcome back, "+player.mf ("Pa", "Ma")+". What's your pleasure today? Bee Chitin always sells, but perhaps something...rarer suits your taste? ” \n\n");
		}
		if (!SeenMatShop) {
		outputText("As you approach, the beige-furred mouselet takes his feet off the stand, giving you a doff of his hat. \n\n");
			outputText("“"+player.mf ("Pa", "Ma")+", what brings you to my stall?” He grins, only slightly sarcastically. “Name’s Rum-Runner, and welcome to Rum-Runner's Rarities. I sell…Shall we say, materials outside of the usual metal and stone. I go it...A little more primal. These things can be harder to get nowadays, but are findable with a little bit of legwork…and maybe a little bladework.” He puts a hand to the thin blade at his side. “Honestly, I’d expect a veteran adventurer like you to have little need of my services…but what would I know?” He takes his hat off, bowing theatrically \n\n");
		SeenMatShop = true;
		}
		outputText("“What can I do ya for?” \n\n");
		menu();
		addButton (1, "GrnGel", BuyGel);
		addButton (2, "Chitin", BuyChitin);
		if (prosperityvar > 10) {
			addButton (3, "Silk", BuySilk);
		}
		if (prosperityvar > 16) {
			addButton (4, "Ebonbloom", BuyEbonbloom);
		}
		if (prosperityvar > 30)  { //Add the qualifier, must complete the demon lab dungeon.
			addButton (5, "D.Scale", BuyDragonscale);
		}
		if (prosperityvar > 20) {
			addButton (6, "ImpSkull", BuyImpSkull);
		}
		if (prosperityvar > 30) {
			addButton (7, "D.Skull", BuyDemonSkull);
		}
		addButton (8, "Back", MouseShopArea);
	}

	public function BuyGel():void {
		clearOutput();
		if(player.gems < 50) {
			outputText("You don't have enough gems.");
			menu();
			addButton(0,"Next", MouseTownRareGoods);
			return;
		}
		outputText("Your roguish son grins. <i>\"These are popular with the town guard. Comfortable, but protective. Hope ya get some good use out of it.</i>\" He hands you the gel. <i>\"Anything else?</i> \n\n");
		player.gems -= 50;
		statScreenRefresh();
		inventory.takeItem(useables.GREENGL, MouseTownRareGoods);
	}

	public function BuyDemonSkull():void {
		menu();
		addButton(0,"Next", MouseTownRareGoods);
	}

	public function BuyImpSkull():void {
		menu();
		addButton(0,"Next", MouseTownRareGoods);
	}

	public function BuyChitin():void {
		clearOutput();
		if(player.gems < 100) {
			outputText("You don't have enough gems.");
			menu();
			addButton(0,"Next", MouseTownRareGoods);
			return;
		}
		outputText("Your son doffs his hat. <i>\" These ones aren't the hardest to get, but them bee folk need some...Buttering up to part with larger chunks voluntarily. Needless to say, I enjoy getting my hands on these.</i>\" He hands you a decent-sized chunk of bee chitin. <i>\"Anything else?</i>\n\n");
		player.gems -= 100;
		statScreenRefresh();
		inventory.takeItem(useables.B_CHITN, curry(MouseTownRareGoods));
	}
	public function BuySilk():void {
		clearOutput();
		if(player.gems < 200) {
			outputText("You don't have enough gems.");
			menu();
			addButton(0,"Next", MouseTownRareGoods);
			return;
		}
		outputText("RumRunner sighs. <i>\"Restocking these...It's hit and miss. Some o' them Spider-folk aint so bad, once you get to know em...But it's always a risk, if ya run into them Driders.</i>\" He hands you a spool of tough silk. <i>\"Anything else?</i> >n\n");
		player.gems -= 200;
		statScreenRefresh();
		inventory.takeItem(useables.T_SSILK, curry(MouseTownRareGoods));
	}

	public function BuyDragonscale():void {
		clearOutput();
		if(player.gems < 300) {
			outputText("You don't have enough gems.");
			menu();
			addButton(0,"Next", MouseTownRareGoods);
			return;
		}
		outputText("Your son gives you a smile. <i>\"Oh, I can't take complete credit for these ones.</i>\" He leans back. <i>\" Went into Tel'Adre with the runts, and found out some Dragon-folk had taken up residence there. Got to talkin' with some of em, and they mentioned that you'd freed 'em from the demons.</i>\" He gives you a conspiratorial grin. <i>\"I may have let it slip that you're my"+player.mf ("Pa", "Ma")+", and bam, that opened em up like nothing else.\"</i>\" He gives you a curt nod. \"<i>So anyways, apparently those scales of theirs are not only extremely hard, but also fall off pretty regularly. So they've taken to sellin' 'em. They'd normally sell for a bit more, but I got a pretty big discount, considering what you did for 'em. Give that old scales my regards, would ya?\"</i>  \n\n");
		player.gems -= 300;
		statScreenRefresh();
		inventory.takeItem(useables.D_SCALE, curry(MouseTownRareGoods));
	}
	public function BuyEbonbloom():void {
		clearOutput();
		if(player.gems < 500) {
			outputText("You don't have enough gems.");
			menu();
			addButton(0,"Next", MouseTownRareGoods);
			return;
		}
		outputText("Rum-Runner winces as you look at the Ebonblooms. <i>\"Those are without a doubt one of the most annoying plants I've encountered. Worth a pretty gem, but those caves are crawling with all kinds of nasty buggers, most of em best avoided.\"\n\n");
		player.gems -= 500;
		statScreenRefresh();
		inventory.takeItem(useables.EBONBLO, curry(MouseTownRareGoods));
	}

	public function MouseTownMining():void {
		clearOutput();
		outputText("You walk up to the third stall, and the burly mouse-woman blinks, looking up at you with genuine surprise. She covers it quickly, sitting up in her seat.  \n\n");
		outputText("<i>“[Name]”.</i> She says roughly. <i>“Welcome to the Quarry Corps. Pay us gems, protect our workers, and we’ll scour the area for resources, and bring em back for ya.”</i> She points at a sign beside her. \n\n");

		outputText("Forest Runs are 100 gems\n\n");
		if (prosperityvar > 8) {
			outputText("Desert Runs are 200 gems\n\n");
		}
		if (prosperityvar > 14) {
			outputText("Quarry Runs are 300 gems\n\n");
		}
		if (prosperityvar > 20) {
			outputText("Battlefield Runs are 400 gems\n\n");
		}
		outputText("Do you want to lead an expedition today?\n\n");

		menu();
		addButton (1, "Forest", DoWoodRun);
		if (prosperityvar > 8) {
			addButton (2, "Desert", DoNailsRun);
		}
		if (prosperityvar > 14) {
			addButton (3, "Quarry", DoStoneRun);
		}
		if (prosperityvar > 20) {
			addButton (4, "Junkyard", DoScrapRun);
		}
		addButton (5, "Back", MouseShopArea);
	}

	public function DoWoodRun():void {
		clearOutput();
		outputText("The burly mouse-woman nods, calling to the building behind her. Quickly, several wagons are brought out, and a variety of mice begin to follow you. You lead them out past the gates, out into Mareth. You head out towards the forest, constantly looking out for demons. \n\n");
		player.gems -= 100;
		var wood:Number = 0;
		var choice0:Number = rand(4);
		switch (choice0) {
			case 0:
				outputText("While in the forest, you run into several tentacle beasts. You spend a few hours keeping your mouselets together, trying to prevent anyone from getting attacked. You don't lose anyone, but your kids have a hard time focusing on wood gathering.  \n\n");
				wood = 10 * prosperityvar;
				flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] += wood;
				if (flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] > 1200 && flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] >= 3) flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] = 1200;
				else if (flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] > 400 && flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] < 3) flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] = 400;

				outputText("You and your kids bring "+ wood +"Wood back from your expedition. \n\n");
				break;
			case 1:
				outputText("Your mouselets run afoul of a group of imps, forcing you to come to their defense. However, the imps flee quickly, and after the initial skirmesh, you and the kids can harvest in peace. However, as several imps escaped, you fill the wagons halfway and leave.\n\n");
				wood = 15 * prosperityvar;
				flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] += wood;
				if (flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] > 1200 && flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] >= 3) flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] = 1200;
				else if (flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] > 400 && flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] < 3) flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] = 400;
				outputText("You and your kids bring "+ wood +"Wood back from your expedition. \n\n");
				break;
			case 2:
				outputText("Scouting ahead, you manage to avoid a demon scouting party. You and your kids keep to a lighter area of the woods. While an imp sees you and your kids, you manage to bring it down before it can alert the rest of the demon patrol. You fill the wagons three-quarters of the way, but a squad of demons begin closing in on your kids, and you decide to avoid the risk. You cover your children as they flee, and the demons decide not to pursue. \n\n");
				wood = 20 * prosperityvar;
				flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] += wood;
				if (flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] > 1200 && flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] >= 3) flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] = 1200;
				else if (flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] > 400 && flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] < 3) flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] = 400;
				outputText("You and your kids bring "+ wood +"Wood back from your expedition. \n\n");
				break;
			case 3:
				outputText("To your surprise, you don't encounter any demons or beasts. You and your mouselets fill your wagons several times over.  \n\n");
				wood = 25 * prosperityvar;
				flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] += wood;
				if (flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] > 1200 && flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] >= 3) flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] = 1200;
				else if (flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] > 400 && flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] < 3) flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] = 400;
				outputText("You and your kids bring "+ wood +"Wood back from your expedition. \n\n");
				break;
			default:
		}
		Intown = false;
		doNext (camp.returnToCampUseFourHours)
	}
	public function DoNailsRun():void {
		clearOutput();
		outputText("The burly mouse-woman nods, calling to the building behind her. Quickly, several wagons are brought out, and a variety of mice begin to follow you. You lead them out past the gates, out into Mareth. You head out towards the desert, looking for old buildings and ruins. \n\n");
		player.gems -= 200;
		var nails:Number = 0;
		var choice0:Number = rand(4);
		switch (choice0) {
			case 0:
				outputText("You catch sight of a large set of buildings, but on your way there, several of your children vanish into the sands, shifting sands pulling them in towards androgynous people in the middle. You and your kin leap into action, leaping into the sandtrap's funnels en masse, forcing the egg-laying rapists to flee. Once you get everyone back up, your children are shaken, tired by the struggle. \n\n");
				outputText("Your children, despite their fatigue, pull together and get to work. You pull nails from the buildings, until a small group of demons appear. You haven't gotten much, but the Quarry corps aren't fighters. You decide to get out of the desert before more demons show up. \n\n");
				nails = 5 * prosperityvar;
				flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] += nails;
				if (flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] > 750 && flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] >= 2) flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] = 750;
				else if (flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] > 250 && flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] < 2) flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] = 250;
				outputText("You found "+ nails +"usable nails in the old wood")
				break;
			case 1:
				outputText("You come upon an old wooden structure, half-buried in the desert. You notice the telltale signs of the desert traps, and your children are easily able to avoid them. You begin to extract the nails from the structure, but are called away to deal with a few sand witches, who are eyeing your group. The women don't approach, but begin to giggle, making out with each other in full display. Several of your mice stop working altogether, and as several more sand witches appear, walking towards your group, you bring everyone in, heading back to town before the conniving cow-bitches can become even more of an annoyance. \n\n");
				nails = 10 * prosperityvar;
				flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] += nails;
				if (flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] > 750 && flags[kFLAGS.	MATERIALS_STORAGE_UPGRADES] >= 2) flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] = 750;
				else if (flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] > 250 && flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] < 2) flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] = 250;
				outputText("You found "+ nails +"usable nails in the old wood")
				break;
			case 2:
				outputText("You run into a group of sand witches unleashing their magics on a group of demons. You take advantage of the chaos, heading past with your mouselets. Both groups are still fighting several hours later, when you finish. You and yours pack up and leave, the two groups still fighting.  \n\n");
				nails = 15 * prosperityvar;
				flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] += nails;
				if (flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] > 750 && flags[kFLAGS.	MATERIALS_STORAGE_UPGRADES] >= 2) flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] = 750;
				else if (flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] > 250 && flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] < 2) flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] = 250;
				outputText("You found "+ nails +"usable nails in the old wood")
				break;
			case 3:
				outputText("While heading to some ruins, you run into some of Tel'Adre's outriders. They nod respectfully, and take a rest beside your mouse children as you work. You think you see a sand witch or two, but between Tel'Adre's guards and your own, they think better of it. \n\n");
				nails = 20 * prosperityvar;
				flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] += nails;
				if (flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] > 750 && flags[kFLAGS.	MATERIALS_STORAGE_UPGRADES] >= 2) flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] = 750;
				else if (flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] > 250 && flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] < 2) flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] = 250;
				outputText("You found "+ nails +"usable nails in the old wood")
				break;
			default:

		}
		Intown = false;
		doNext(camp.returnToCampUseFourHours);
	}

	public function DoStoneRun():void {
		clearOutput();
		player.gems -= 300;
		var stone:Number = 0;
		var choice0:Number = rand(4);
		switch (choice0) {
			case 0:
				stone = 5 * prosperityvar;
				flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] += stone;
				if (flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] > 1200 && flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] >= 3) flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] = 1200;
				else if (flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] > 400 && flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] < 3) flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] = 400;
				outputText("You run into a minotaur, fucking a Bovine. Some of your mouselets seem to enjoy what they see, but as you hurry them along, another minotaur, watching the show, sees your mouselets, running towards them. You intercept, slaying the beast, but the encounter rattles your kids. You get to the quarry, but some amorous harpies catch sight of you and your kids. They attack, forcing several of your mouselets to stop and defend themselves. Your trip is far less productive than it could have been. \n\n");
				outputText("You and your kids bring "+ stone +"Stone back from your expedition. \n\n");
				break;
			case 1:
				stone = 10 * prosperityvar;
				flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] += stone;
				if (flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] > 1200 && flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] >= 3) flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] = 1200;
				else if (flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] > 400 && flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] < 3) flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] = 400;
				outputText("On your way up the mountain, you run into a minotaur. As the beast snorts, pawing the ground, a massive Oni woman grabs it from behind, taking it by the horns and laughing as she forces it forward, leaping down a thirty-foot drop and splattering the unfortunate minotaur against the stone. She looks up, giving you a crazed grin and a thumbs-up, before rushing off. You get to the quarry, and last a good few hours before a small group of harpies land nearby. Not liking the looks in their eyes, you decide to get your kids out of there, calling an end to the gathering trip. \n\n");
				outputText("You and your kids bring "+ stone +"Stone back from your expedition. \n\n");
				break;
			case 2:
				stone = 15 * prosperityvar;
				flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] += stone;
				if (flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] > 1200 && flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] >= 3) flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] = 1200;
				else if (flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] > 400 && flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] < 3) flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] = 400;
				outputText("Your trip up the mountain is surprisingly clear. You hear a minotaur once or twice, but they never get close to your kids. A few mouselets stagger, nearly falling off the path, but it's nothing you can't handle. At the quarry, you run into a few basilisks, who paralyze a few of your kids before you chase them off. Nobody's hurt, but you have to put them in the cart. The rest of your mouselets work hard, and you manage to get a few solid hours of quarrying in before a group of imps catch sight of you. You take most of them down, but a few mouselets are injured in the process. The remaining imps fly off, presumably to bring reinforcements. You decide to gather your kids and get out before the demons come. \n\n");
				outputText("You and your kids bring "+ stone +"Stone back from your expedition. \n\n");
				break;
			case 3:
				stone = 20 * prosperityvar;
				flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] += stone;
				if (flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] > 1200 && flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] >= 3) flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] = 1200;
				else if (flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] > 400 && flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] < 3) flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] = 400;
				outputText("Your trip up is completely uneventful, not even a Minotaur is seen. The Quarry is similarly empty, and you manage to fill your carts entirely with stone. \n\n");
				outputText("You and your kids bring "+ stone +"Stone back from your expedition. \n\n");
				break;
			default:

		}
		Intown = false;
		doNext(camp.returnToCampUseFourHours);
	}

	public function DoScrapRun():void {
		clearOutput();
		player.gems -= 400;
		var metal:Number = 0;
		var choice0:Number = rand(3);
		switch (choice0) {
			case 0:
				metal = 5 * prosperityvar;
				flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] += metal;
				if (flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] > 1200 && flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] >= 3) flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] = 1200;
				else if (flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] > 400 && flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] < 3) flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] = 400;
				outputText("You and your kids bring "+ metal +"Metal back from your expedition. \n\n");
				break;
			case 1:
				metal = 7 * prosperityvar;
				flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] += metal;
				if (flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] > 1200 && flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] >= 3) flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] = 1200;
				else if (flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] > 400 && flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] < 3) flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] = 400;
				outputText("You and your kids bring "+ metal +"Metal back from your expedition. \n\n");
				break;
			case 2:
				metal = 10 * prosperityvar;
				flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] += metal;
				if (flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] > 1200 && flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] >= 3) flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] = 1200;
				else if (flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] > 400 && flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] < 3) flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] = 400;
				outputText("You and your kids bring "+ metal +"Metal back from your expedition. \n\n");
				break;
			default:

		}
		Intown = false;
		doNext(camp.returnToCampUseFourHours);
	}
	public function MouseTownWeaponry():void {
		clearOutput();
		outputText("As you approach, the cute little mouselet behind the wooden stall stands, her tail whipping around. Her eyes light up when she sees you, and she hops up and down on her little stool. \n\n");
		if (!SeenMMelee) {
			outputText("“Are you…[Name]?” You answer that yes, you’re [name], champion of Ignam. Her eyes widen, and she squeals in delight. “You’re Papa’s "+player.mf ("Papa", "Mama")+"!” She sits back down, little tush wiggling in delight. “So…I’m running the weapons store!” She looks at you, whispering conspiratorially. “Can I sell you a stabber?”  \n\n");
			SeenMMelee = true;
		}
		if (SeenMMelee) {
			outputText("As you approach, the cute little mouselet behind the wooden stall stands, her tail whipping around. Her eyes light up when she sees you, and she hops up and down on her little stool. “Hi again! Do you need a stabber?” She seems far too excited for her job. \n\n");
		}
		if (prosperityvar >= 30 && ShouldraSeenTown == 4 && !ReapercheepBought) {
			outputText("The stand seems to be glowing, and the girl behind the stand grins wickedly. In front of the stand sits several rapiers. In the middle, nestled in black velvet, sits the source of the glow, an intricately engraved rapier. The blade ripples, folded metal reflecting its own light. The handguard is large, carved steel brushed with gold, and as you turn it over, you realise that its guard is shaped like Amily's head, with Sapphires for eyes. As you look at it, the girl nods solemnly. <i> \"That's my Daddy's finest work yet.</i> She\'s uncharacteristically somber. <i> \"ReaperCheep: Forged from starmetal, slathered in the sap of Marae, enchanted by our Guardian Spirit Shouldra, embued with SoulForce from the Race-Mother, Amily, and quenched in the donated blood of our people. This sword speaks to our will...And is only to be wielded by those who\'s blood pumps within our hearts. </i>\" She looks up at you, eyes shining. <i> \"It would be fitting, then, for you. </i> \n\n");
		}

		menu();
		addButton(0, weapons.CLAYMOR.shortName, MouseBuyWeapon, weapons.CLAYMOR);
		addButton(1, weapons.WARHAMR.shortName, MouseBuyWeapon, weapons.WARHAMR);
		addButton(2, weapons.BFSWORD.shortName, MouseBuyWeapon, weapons.BFSWORD);
		addButton(3, weapons.SPEAR.shortName, MouseBuyWeapon, weapons.SPEAR);
		addButton(4, weapons.LANCE.shortName, MouseBuyWeapon, weapons.LANCE);
		addButton(5, weapons.SCIMITR.shortName, MouseBuyWeapon, weapons.SCIMITR);
		addButton(6, weapons.MACE.shortName, MouseBuyWeapon, weapons.MACE);
		addButton(7, weapons.FLAIL.shortName, MouseBuyWeapon, weapons.FLAIL);
		addButton(8, weapons.HALBERD.shortName, MouseBuyWeapon, weapons.HALBERD);
		addButton(9, weapons.G_SHURI.shortName, MouseBuyWeapon, weapons.G_SHURI);
		addButton(10, weapons.DSWORD_.shortName, MouseBuyWeapon, weapons.DSWORD_);
		addButton(11, weapons.DAGGER.shortName, MouseBuyWeapon, weapons.DAGGER);
		addButton (11, "Back", MouseShopArea);
	}

	public function MouseBuyWeapon(itype:ItemType, cost:Number):void {
		clearOutput();
		outputText("You gesture at " + itype.longName + ".\n\n");
		outputText("The tiny mouselet gives you a smile that would be terrifying on anyone...but her tiny size almost makes it more intimidating. \"<i>Greeeeaaat choice. You could kill a TON of demons with that!\"</i> She giggles a little, before taking the weapon, cradling it in her arms before putting it on the counter for you. \"<i>For this little piggy, it's gonna drop you\"</i>" + cost + " gems.</i>\"");
		if (player.gems < cost) {
			outputText("\n<b>You don't have enough gems...</b>");
			doNext(MouseTownWeaponry);
			return;
		}
		doYesNo(Utils.curry(MouseBuyWeapon,itype,cost), MouseTownWeaponry);
	}

	public function MouseTownArmor():void {
		clearOutput();
		outputText("As you near the stall, a serious-looking mouse child looks up at you. He nods once, saying a single word. “[Name]?” You nod, and he points at the stall’s sign. “Okay, "+player.mf ("Grandfather", "Grandmother")+". Welcome to Aegis Armors. What can I get for you?”  \n\n");
		menu();
		addButton(0,    armors.CHBIKNI.shortName,   MouseBuyArmor, armors.CHBIKNI);
		addButton(1,    armors.FULLCHN.shortName,   MouseBuyArmor, armors.FULLCHN);
		addButton(2,    armors.FULLPLT.shortName,   MouseBuyArmor, armors.FULLPLT);
		addButton(3,    armors.INDECST.shortName,   MouseBuyArmor, armors.INDECST);
		addButton(4,    armors.SCALEML.shortName,   MouseBuyArmor, armors.SCALEML);
		addButton(5,    shields.BUCKLER.shortName,  MouseBuyArmor, shields.BUCKLER);
		addButton(6,    shields.KITE_SH.shortName,  MouseBuyArmor, shields.KITE_SH);
		addButton(7,   	shields.SPIL_SH.shortName,  MouseBuyArmor, shields.SPIL_SH);
		addButton(8,    shields.GREATSH.shortName,  MouseBuyArmor, shields.GREATSH);
		addButton(9,    shields.TOWERSH.shortName,  MouseBuyArmor, shields.TOWERSH);
		addButton(10,   armors.SAMUARM.shortName,   MouseBuyArmor, armors.SAMUARM);
		//addButton(11, )
		addButton (12, "Back", MouseShopArea);
	}

	public function MouseBuyArmor(itype:ItemType, cost:Number):void {
		clearOutput();
		outputText("You gesture at " + itype.longName + ".\n\n");
		outputText("\"<i>A wise decision\"</i> The mouselet says, a serious expression on his face. \"<i>Every purchase comes with free fitting, to ensure that the product actually protects as it should.\"</i> He motions to the house behind the stall, where you can see an adult mouse-morph sitting at a leatherworker's table. He looks up at you, nodding, before returning to his work. <i> \"This product will cost you" + cost + " gems.</i>\"");
		if (player.gems < cost) {
			outputText("\n<b>You don't have enough gems...</b>");
			doNext(MouseTownArmor);
			return;
		}
		doYesNo(Utils.curry(MouseBuyArmor,itype,cost), MouseTownArmor);
	}

	public function MouseTrainField():void {
		clearOutput();
		outputText("You decide to head down to the training grounds, where a large number of your mouse-kids are training with various weapons. They seem to run the gamut of combat styles, ranged, melee, even a few magic users. Where do you feel like going now?  \n\n");

		menu();
		addButton (1, "Ranged", TrainFieldRanged);
		addButton (2, "Melee", TrainFieldMelee);
		//addButton (3, "Magic", TrainFieldMagic);
//If you have Jojoy (NYW)
//addButton (4, "Monk", TrainFieldMonk);
	}

	public function TrainFieldRanged():void {
		clearOutput();
		outputText("A few mouselets stand on the edge of the training grounds. A few have proper bows, but most use slingshots. They stand with varying degrees of confidence, and pelt the wooden targets with their weapon of choice. A slender, almost elegant white mouse goes from person to person, correcting a stance, adjusting a bow, or offering words of encouragement. She notices you, and her eyes light up. <i>“Hold your fire!</i>” She yells, pointing towards you. <i>“Take a few moments, everyone.</i>” She looks remarkably like Amily, down to her gait. <i>“Our "+ player.mf("father", "mother") +" is here!</i>” Most of the mouselets disperse, grabbing water or a snack, but she looks at you expectantly. <i>“Well, what’re you here for, "+ player.mf("dad", "mom") +"?</i>”  \n\n");

		menu();
		addButton (1, "Training", MiceTrainRanged);
		addButton (2, "SpendTime", MaybeNot);
		addButton (3, "Her", Ameliar);
	}

	public function MiceTrainRanged():void {
		clearOutput();
		outputText("She calls her younger siblings back after a few minutes, and you take a stance near the end of the line. You spend an hour putting arrows, sling bullets, knives and even a bolt or two into the targets. Your children pass their weapons around, sharing, and you join in. At the end of the session, your weapon is returned, and the kids around you are happy to spend time with you. \n\n");
		//gain archery Dao EXP
		outputText("As you leave, your would-be ranger kids group around you. Some look like they want you to stay, but you apologise, ruffling a few heads and offering words of encouragement as you leave.  \n\n");
		outputText(" \n\n");
		//add in perks later
		Intown = false;
		doNext(camp.returnToCampUseOneHour);

	}
	public function MaybeNot():void {
		clearOutput();
		outputText("<i>“Well, most of us are kinda busy keeping the village running</i>”. She laughs awkwardly. <i>“So...Dinner’s your best bet for that, unless you wanna join us in target practice\". \n\n");
		doNext (enterVillage);
	}

	public function Ameliar():void {
		clearOutput();
		outputText("<i>“Oh, me?</i>” She blushes slightly, just like her mom. <i>“I’m Ameliar. I was in mom’s second litter.</i>” She shrugs. <i>“I wanted to take up a more safe option to defend our village,and so...I got this bow.</i>” You raise your eyebrows, and she puts a hand on your shoulder. <i>“No, not from that Centaur on the farm, don’t worry, (mom/dad). We know better than to go near that tainted beast.</i>”  \n\n");
		outputText("<i>“Anyways, we need to get back to training. Please feel free to join us, but if you’re not, we need to focus.</i>” You excuse yourself, and walk back to the centre of town.  \n\n");
		doNext(enterVillage);
	}

	public function TrainFieldMelee():void {
		clearOutput();
		outputText("You decide to train with your children’s warriors. They perk up on seeing you, but the largest, a darker furred mouse with a few scars on his fur and a missing whisker, eyes you with a warrior’s gaze.  \n\n");
		outputText("<i>“Good news, rats!</i>” He bellows. <i>“Our old "+ player.mf("man", "woman") +"has chosen to join our training for now!</i>” He glares at a few fidgety ones, clearly new to this. <i>“And you lot will not embarrass our village, or so help me I will have you running laps for the next day straight!</i>” he takes his spear, joining the middle of the mouseling formation. <i>“Come on, "+ player.mf("mom", "dad") +"! Show us what we inherited from you!</i>” He raises his voice. <i>“Shieldwall, March!</i>” \n\n");
		outputText("You are now fighting your children's Shieldwall! \n\n");
		outputText("Or...You would be, if they were coded in. For now, just enjoy the village \n\n");
		doNext(enterVillage);
//Fight The Rats!
	}
	public function EveningMeal():void {
		clearOutput();
		outputText("You decide to stay for the evening meal. While it’s simple fare, berries, nuts and root vegetables, mostly, with a little bit of fish on the side, it’s surprisingly filling (+50% satiety). You and Amily sit closest to the campfire, your children sitting you together on purpose, and you find yourself smiling as your children take turns talking about their day. A brawnier mouse with singed fur on his cheeks asks how you’ve enjoyed the meal. Amily smiles at the boy, her mouth full. He looks to you. \n\n");
		menu();
		addButton (1, "Good", MealGood);
		addButton (2, "Bleh", MealBleh);
	}

	public function MealGood():void {
		clearOutput();
		outputText("At your compliment, his face brightens up considerably, and he scampers off into the campgrounds excitedly. Amily chuckles, taking your arm, and you watch as your massive mouseling family begins to wind down for the evening.  \n\n");
		outputText("As the sun begins to lower, Amily takes your arm. <i>“We should leave, [name], if we want to get back to the camp before dark.</i>”  \n\n");
		menu();
		addButton (1, "Leave", EatandRun);
		addButton (2, "SleepHere", StayTheNight);
	}

	public function MealBleh():void {
		clearOutput();
		outputText("At the look on your face, he looks down, crestfallen. Before you can say anything else, he turns about and leaves, his shoulders slumped. Amily slaps your shoulder, but says nothing else. The mood is a little more subdued in the town.  \n\n");
		outputText("As the sun begins to lower, Amily takes your arm. <i>“We should leave, [name], if we want to get back to the camp before dark.</i>”  \n\n");
		menu();
		addButton (1, "Leave", EatandRun);
		addButton (2, "SleepHere", StayTheNight);
	}

	public function EatandRun():void {
		clearOutput();
		outputText("You nod, and the two of you walk arm in arm back to your camp. You notice a few of your children following. Upon closer inspection, you recognize them as the three combat trainers from the training area, but as you turn around to face them, the three scamper off, back towards the village.  \n\n");
		outputText("<i>“aww...They were worried about us.</i>” Amily seems to like this, leaning into you a bit more. She kisses you on the cheek, then goes to her spot in camp. \n\n");
		Intown = false;
		doNext(camp.returnToCampUseOneHour);
	}

	//----------------------MouseTown Building Functions-------------------

	public function MouseTownBuild():void {
		clearOutput();
		outputText("You can build some buildings to improve the town. Houses, defenses...what will you make? \n\n");
		menu();
		addButton (1, "House", BuildHouse);
		addButton (2, "Wall", BuildWall);
		if (ShopBuilt < 4){
			addButton (3, "Shop", BuildShop);
		}
		if (!TrainingGroundsBuilt) {
			addButton (4, "TrainGrounds", BuildTrainGrounds);
		}
		if (!SmithBuilt) {
			addButton (5, "Smith", BuildSmith);
		}
		if (!logbuilt) {
			addButton (6, "Logging", BuildLogging);
		}
		if (!WellBuilt) {
			addButton (7, "Well", BuildWell);
		}
		addButton (8, "back", enterVillage);
	}
	public function BuildWell():void {
		clearOutput();
		if (flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] >= 20 && flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] >= 50 && flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] >= 200) {
			flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] -= 20;
			flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] -= 50;
			flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] -= 200;
			outputText("You ask your kids if the old town’s well is still functional. Amily gives you a pained look, and she shakes her head. <i>“The old well partly collapsed, but the hole’s still there.”</i> She blinks. <i>“It shouldn’t take too much to fix, considering how many of us there are.”</i>  \n\n");
			outputText("You nod, and Amily leads you to the old well, and you clear the rubble from around the old structure. Upon inspection, there are a few places where the well’s stones have come loose lower down, and two of your children dive down to patch them up. Meanwhile, you start laying the groundwork for rebuilding the aboveground portion of the well, including a rope-pull and wooden cover for the well.  \n\n");
			outputText("The construction takes a mere hour, and when it’s finished, Amily pulls the first bucket of water up from the well. She gives it a serious look, and your children look on, the mood darkening. “[Name], come here.” You stride towards your lover, worried…Amily swings the bucket, sending the entire bucket of water into your face. Now dripping wet, you splutter as Amily howls with laughter, letting the bucket fall back down into the well. Some of your children giggle at the sight, and as Amily straightens back up, she wipes a tear out of her eyes.  \n\n");
			outputText("“I’m sorry, [Name], I couldn’t resist.” She doesn’t look that sorry, but you know the best way to get her back. You open your [arms], telling Amily that it’s quite alright. She realises, too late, what you’re up to as you wrap her in a bear hug. You rub your soaking wet front into her, and Amily gives you a giggle, pushing you off. Now both soaking wet, your kids laugh at their parents.  \n\n");
			outputText("You leave, heading back to the portal. While water from the well still clings to your [clothing], you don’t mind too much. A small price to pay for a job…well done.  \n\n");
			Intown = false;
			doNext (camp.returnToCampUseOneHour);
		}
		else if (flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] <= 20 && flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] <= 50 && flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] <= 200)
		{
			outputText("You don't have enough resources to build this project \n\n");
		}
	}


	public function BuildHouse():void {
		clearOutput();
		if (flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] >=100 && flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES]>=200 && flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] >= 100) {
			outputText("You call out, and Amily echoes you, calling your children to gather round. As a dozen or so join you, you explain to them the job at hand.  \n\n");

			outputText("You point at a patch of land, telling your kids that you’re using it for housing, and your kids nod. You help them till the ground, cut notches into the wood, and raise the central pillar. As you work, nearly a dozen are already working on the walls, pounding stakes into the ground to act as grounding points for the house and cutting lumber into precise pieces for the walls. \n\n");
			outputText("To your surprise, more of your kids come in, toting buckets of water and clay. Between each piece of lumber, they slather the top with the clay, sealing the holes between the wood. \n\n");
			outputText("The roof comes next, and a half-dozen mice clamber onto the supporting beams while another climbs up the central pillar with a saw. You help your kids feed pieces of wood to lay across, making support beams for the roof. They fill in the roof with shocking speed, and within an hour, the structure of the house is done. The floor inside is still dirt, but your children show no signs of stopping. She waves you off.  \n\n");
			outputText("<i>“We’ll handle the rest of this”,</i> she says cheerfully, handing you a glass of water. You down it, and Amily gives you a hug. “For real, the heavy lifting is done. Thank you.” You give her back the glass, excusing yourself. You relax for a moment, before getting to your feet. \n\n");
			flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] -= 100;
			flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] -= 200;
			flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] -= 100;
			HouseNumber += 1;
			MouseTownPopCap += 15;
			Intown = false;
			cheatTime(1);
			doNext(enterVillage);
		}
		if ((flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] <= 100) || (flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] <= 200) || (flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] <= 100))
		{
			outputText("This house will take more resources to build than you currently have. ");
			doNext(enterVillage);
		}
	}

	public function BuildWall():void {
		clearOutput();
		if (flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES]>= 50 && flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] >= 100)
		{
			flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] -= 50;
			flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] -= 100;
			outputText("You call out, and Amily echoes you, calling your children to gather round. As a dozen or so join you, you explain to them the job at hand.  \n\n");
			outputText("Your children nod, and start hauling lumber over towards the boundaries of town. You mark off the wall’s location, and your children get to work, pounding logs into the ground every four feet or so, laying a strong foundation.  \n\n");
			outputText("In between the logs, you and your kids run planks, nailing them into each side of the log. As you and several mouselets work on that, more of your children grab shovels, working together to carve out a small trench in front of the wooden frame. They shovel the dirt inside, and one of your kids watches, carving a piece of wood to fit into the frame. After a few feet of dirt are put into the frame, they put the piece of wood overtop, then pile onto it, jumping in unison.  \n\n");
			outputText("<i>“Rammed Earth Walls”,</i> Amily explains. <i>“A lot easier than carting stone for miles, stronger than a purely wooden wall, and lets us make a trench at the same time.” </i> \n\n");
			outputText("The process repeats, and within a few hours, a segment of wall has been put in place. It’ll need time to dry, but you know that once it does, this part of the wall will be extremely hard to damage. You're sweating hard, the sun beating down on your [skin]. Amily approaches, patting you on the back. \n\n");
			outputText("<i>“We’ll handle the rest of this”,</i> she says cheerfully, handing you a glass of water. You down it, and Amily gives you a hug. <i>“For real, the heavy lifting is done. Thank you.”</i> You give her back the glass, excusing yourself. You head back to camp, slightly winded from your work.  \n\n");
			WallNumber +=1;
			Intown = false;
			doNext(camp.returnToCampUseOneHour);
		}
		else if (flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] < 50 && flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] < 100)
		{
			outputText ("You don't have enough resources to build the wall. Gather some more and come back later.");
			doNext(enterVillage);
		}
	}

	public function BuildShop():void {
		clearOutput();
		if (flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] >= 70 && flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] >= 150) {
			flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] -= 70;
			flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] -= 150;
			outputText("You call out, and Amily echoes you, calling your children to gather round. As a dozen or so join you, you explain to them the job at hand.  \n\n");
			ShopBuilt += 1;
			Intown = false;
			doNext(camp.returnToCampUseTwoHours);
		}
		else if (flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] >= 70 && flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] >= 150) {
			outputText("You don't have enough resources to make a new shop. Try again later. \n\n");
			doNext(enterVillage);
		}
	}

	public function BuildTrainGrounds():void {
		clearOutput();
		if (flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] >= 50 && flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] >= 150 && flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] >= 10) {
			flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] -= 50;
			flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] -= 150;
			flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] -= 10;
			outputText("You call out, and Amily echoes you, calling your children to gather round. As a dozen or so join you, you explain to them the job at hand.  \n\n");
			outputText("Your children get to work, pulling weeds, grass and rocks alike from the ground you’ve marked out. You begin working on a few simple wooden frames to hold targets, and within an hour, you’ve constructed some simple target frames, and built up some wooden barricades to block stray shots. You look up from your work to see that stakes have been pounded every few meters, and the area’s being flattened out.  \n\n");
			outputText("Three of your children in particular, a stocky, black-furred male, a slender, elegant woman with white fur, and an adrogynous seeming mouselet with beige fur, seem to be throwing their all into the training grounds, taking clear leadership over certain parts of the new facility. \n\n");
			outputText("You note that construction is pretty much done, and you see some of your children constructing a few straw dummies. One even appears to be whittling some crude demonic horns. You excuse yourself, heading back to camp.  \n\n");
			Intown = false;
			doNext(camp.returnToCampUseOneHour);
		} else if (flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] < 50 && flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] < 150 && flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] < 10) {
			outputText("You don't have enough resources to make the training grounds. Gather more to build them. \n\n");
			doNext(enterVillage);
		}
	}

		public function BuildSmith():void {
			clearOutput();
			if ((flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] >= 400) && (flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] >= 450) && (flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] >= 300)) {
				flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] -= 400;
				flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] -= 450;
				flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] -= 300;
				outputText("You call out, and Amily echoes you, calling your children to gather round. As a dozen or so join you, you explain to them the job at hand.  \n\n");
				outputText("You point at a patch of land, telling your kids that you’re using it for a new store, and your kids nod. You help them till the ground, cut notches into the wood, and raise the central pillar. As you work, nearly a dozen are already working on the walls, pounding stakes into the ground to act as grounding points for the house and cutting lumber into precise pieces for the walls.  \n\n");
				outputText("To your surprise, more of your kids come in, toting buckets of water and clay. Between each piece of lumber, they slather the top with the clay, sealing the holes between the wood. \n\n");
				outputText("The roof comes next, and a half-dozen mice clamber onto the supporting beams while another climbs up the central pillar with a saw. You help your kids feed pieces of wood to lay across, making support beams for the roof. They fill in the roof with shocking speed, and within an hour, the structure of the house is done. The floor inside is still dirt, but your children show no signs of stopping.\n\n");
				outputText("You rest for a moment, as Amily brings you and some of your kids water. You get back into the build, laying stones for a smeltery, at the instruction of one of your oldest mice-children. An old, beaten iron anvil is brought in, and vents cut into the building.  \n\n");
				outputText(" \n\n");
				outputText(" \n\n");
				SmithBuilt = true;
				Intown = false;
				doNext(camp.returnToCampUseOneHour);
			}
			else if ((flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] < 400) && (flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] < 450) && (flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] < 300)) {
				outputText("The smithery will require more resources than you have to build. \n\n");
				doNext(enterVillage);
			}
		}

		public function BuildLogging():void {
			clearOutput();
			outputText("You tell your kids that you feel the time has come to build a more effective way of cutting timber. A mill that would allow your kids to cut larger pieces of wood, quicker. You get some nods of approval, and with that, you begin marking off an area of land, just inside the boundaries of the town. You decide to make it near one of the town entrances, for easy access.  \n\n");
			outputText("First comes the foundation: You and your mouselets till the earth, readying it for the wooden stakes you intend to drive into it. Next, you bring in timber, and your mouselets begin to raise the timbers, framing a windmill, not unlike the ones you saw in Ignam. They quickly begin to climb the frames once they’re stable, laying down ladders and securing the beams. \n\n");
			outputText("As you finish tilling the adjacent area, Your children are already working on the saw, and as you sit down, you can see them laying beams to drive into the ground, framing a lumber mill. After a few minutes, you get back up, helping your kids bring over the stones, laying a stable floor for the sawmill. \n\n");
			outputText("A few hours pass, and when you’re done, the windmill spins steadily in the breeze. While your mouselets grin, loading the first log into the new lumber mill, you’re heading back to camp.  \n\n");
			logbuilt = true;
			Intown = false;
			doNext (camp.returnToCampUseFourHours);
		}


	//------------Town Side Character Functions (Shouldra, Jojo/Joy, ChiChi etc)----------------------
	public function AmbassadorGreet():void {
		clearOutput();
		outputText("The wolfman sits up as you approach. <i>“Hey, [name]. You speak for the people here, yeah?</i>” you nod and say that you do. At that, he grins. <i>“Well, I’m an ambassador from Tel’adre. Basically, we want to trade freely, send patrols out here occasionally and not risk getting shot, y’know, pretty basic stuff. We’re prepared to offer entry to yours, so long as they’re not corrupt, goods and services, paid for, obviously, and asylum for your kids should the worst happen. You’ve got a decent setup here, but you’re big enough for the demons to take notice.</i>” He winces. <i>“And we all know what can happen when you get their attention</i>”. He leans back in his chair. <i>“It’s a win/win, if you ask me.</i>”\n\n");
		menu();
		addButton (1, "Accept", WolfmanAccept);
		addButton (2, "Nope", WolfmanDeny);
	}
	public function WolfmanAccept():void {
		clearOutput();
		outputText("He sits up. <i>“Well, shit. I guess my vacation’s over.</i>” He gives you a sarcastic grin. <i>“Look, I’m glad to have been here. Your little town here...Well, if it can survive, who knows? Maybe the demons aren’t as unbeatable as we thought.</i>” He gives you a mock salute. <i>“You and yours are always welcome in Tel’adre, friend. Stay safe out here.</i>” \n\n");
		(TelAdreScouts = 1);
		doNext(enterVillage);
	}

	public function WolfmanDeny():void {
		clearOutput();
		outputText("He folds his arms behind his back, his visible paunch sloshing. <i>“Hey, no worries, mate. I’m perfectly happy sitting here until I kick the bucket. Just wake me up if the demons come, alright?</i>”  \n\n");
		doNext(enterVillage);
	}
	//Shouldra recruiting/leaving there.
	public function ShouldraRebuilt():void {
		clearOutput();
		if ((ShouldraSeenTown == 0) && kFLAGS.SHOULDRA_FOLLOWER_STATE != 1) {

			outputText("<i>“Who dares disturb the rest of the scary ghoOOoost- oh wait, it’s you.</i>” Shouldra looks mildly annoyed, but seems to appreciate the company. <i>“Not gonna lie, Champ, I kinda liked it better when the village was quiet... some of your mouselets seem kinda fun to mess with though.</i>” She perks up a bit. <i>“Well, at least none of them are too zealous. So, wanna go on an adventure, champ?</i>”  \n\n");
			ShouldraSeenTown = 1;
			menu();
			addButton(1, "ComeWithMe", GhostFollowerGet);
			addButton(2, "NoThx", enterVillage);
			//addButton (3, "Talk", ShouldraTalk);
		}
		if ((ShouldraSeenTown == 1) && kFLAGS.SHOULDRA_FOLLOWER_STATE != 1) {
			outputText("You walk up to Shouldra’s house, and enter. Your children watch, whispering as the door shuts behind you.  \n\n");
			outputText("“Oh, hey champ. How’s it going?” Shouldra asks, floating in front of you. “Not gonna lie, I’ve been getting pretty bored. Being the 'spooky ghost' is getting old. Wanna do something?” \n\n");
			menu();
			addButton(1, "ComeWithMe", GhostFollowerGet);
			addButton(2, "NoThx", enterVillage);
			//addButton (3, "Talk", ShouldraTalk);
			addButton(4, "Introduce", ShouldraDragOut);
		}
		if ((ShouldraSeenTown == 3) && kFLAGS.SHOULDRA_FOLLOWER_STATE != 1) {
			outputText("Shouldra sees you coming towards her house, and stops toying with one of your children, phasing through the door and greeting you on her front porch. “Champ, I gotta say, while these little ones aren’t as good as you, they’re damn fine replacements.” She seems pleased to see you, however. “But…As cool as these little guys and gals are, I prefer the original.” \n\n");
			menu();
			addButton(1, "ComeWithMe", GhostFollowerGet);
			addButton(2, "NoThx", enterVillage);
			//addButton (3, "Talk", ShouldraTalk);
		}
		if ((ShouldraSeenTown == 4) && (kFLAGS.SHOULDRA_FOLLOWER_STATE != 1))
		{
			outputText("As you near Shouldra’s home, you notice her ‘sitting’ on her porch, looking down at a few mouselets in white robes. She’s smiling, and she continues speaking to them. “Good work today, little ones.” Shouldra sounds…proud…? “I knew you’d have the talent. You are [Name]’s kids, after all. But the hard work you’ve put into mastering magic cannot be denied.” She points to the village. “Go back to your homes and rest. I will pick up our lesson later on.”  \n\n");
			outputText("She turns to you, and your mouselets bow respectfully, first to Shouldra, then to you. They walk off, and you notice that one of them has muscular arms, far larger than the others. You ask Shouldra about it, and she grins.  \n\n");
			outputText("“Oh, I’ve been teaching them magic. Everything I know, really.” She chuckles, shrugging as she approaches. “They’ve been great students so far.” She folds her arms across her chest. “So, am I gonna need to take a sabbatical, champ? As great as these guys are, there’s a wide world of debauchery out there.” \n\n");
			menu();
			addButton(1, "ComeWithMe", GhostFollowerGet);
			addButton(2, "NoThx", enterVillage);
			//addButton (3, "Talk", ShouldraTalk);
		}
		if (flags[kFLAGS.SHOULDRA_FOLLOWER_STATE] == 1) {
			outputText("Inside your body, you can feel your spectral tagalong squirm a little. “Hey, boss? Why are we back here? I know you like this town ya got here, but there's so much more to see.”  \n\n");
			outputText("You tell Shouldra that you want her to leave your body for a bit. She protests, letting several moans out and tweaking your groin, but she reluctantly agrees to leave your body, going back to her home.  \n\n");
			outputText("“Hey, this isn’t goodbye forever, right champ?” Shouldra says. “I’ll be here, but you’re too much fun to let go!” That being said, she phases through her door. You leave the spectre to her own devices, heading back to your town. \n\n");
			flags[kFLAGS.SHOULDRA_FOLLOWER_STATE] = 0;
			doNext(enterVillage)
		}
	}

		public function ShouldraDragOut():void {
			clearOutput();
			outputText("You shake your head at Shouldra, deciding that enough is enough. You tell the ghost-girl that she’s been skulking around the town for long enough. As Shouldra begins to glow, ready for combat, you motion for her to calm down, that you’re not picking a fight.  \n\n");
			outputText("You tell Shouldra that she shouldn’t have to hide to remain here. Whatever history Amily has with her, you’re sure this can be resolved. Shouldra seems shocked, but you stand, taking Shouldra’s hand and pulling her out of the building. For whatever reason, the ghost-girl doesn’t resist as you bring her to the middle of the village, where Amily’s currently resting. As you draw near, Shouldra’s spectral form dangling behind you, your mousey lover sees you, smiling…The moment she sees your ghostly companion, however, her smile freezes.  \n\n");
			outputText("“YOU!” Amily stands, a scowl on her face. “What are you doing with [name]?” \n\n");
			outputText("“Less than you, clearly.” Shouldra fires back, easily freeing herself from your grasp. “I mean, look at this place.” \n\n");
			outputText("Amily seethes, whistling. A few dozen of your kids come running, and seeing the fight brewing, you raise your voice, stopping everyone in their tracks. Telling everyone to calm down, you stand between Amily and Shouldra, staring your mousey lover down. You ask her what problems she has with Shouldra.  \n\n");
			outputText("“...Are you kidding me? This…Dead woman was a menace!” Amily launches into a tirade, starting with an incident involving Shouldra possessing a minotaur, bringing it to the town, and chasing her, the minotaur’s cock enlarged to grotesque proportions.  \n\n");
			outputText("“I wasn’t gonna let it fuck you”, Shouldra fires back. “Besides, it was too big to fit inside you anyways.”  \n\n");
			outputText("“Then there was that time you possessed my tits while I was asleep!” \n\n");
			outputText("“Pfft…What tits?” Shouldra snarks, then seems to realise what she just did. Amily snarls, pulling a paper charm from within her rags.  \n\n");
			outputText("“Recognize this?” Amily growls, and as Shouldra turns, she sees dozens of similar charms, drawn from pockets, robes…Nearly every mouselet has one. Shouldra’s eyes widen, and for the first time, you can see fear in her eyes.  \n\n");
			menu();
			addButton (1, "Intervene", ShouldraSave );
			addButton (2, "StepBack", ShouldraKill);
		}

		public function ShouldraSave():void {
			clearOutput();
			outputText("You step in, between Shouldra and Amily, and raise a hand, pointing at Amily accusingly. You remind Amily that not everyone sexual is corrupt, and that Shouldra may be mischevious, but not malicious. She opens her mouth to protest, but you speak over her, saying that if Shouldra had really wanted to hurt Amily, she could have easily done so years ago. Amily reels back as if struck, and while Shouldra gloats, you turn, pointing at her as well. You berate your ectoplasmic companion for making fun of Amily, considering what she means to you. You tell her that they came to make things right, not tear open old wounds.  \n\n");
			outputText("Your kids freeze, unwilling to go against you but not ready to let Shouldra off the hook, either. Amily sighs, closing her eyes. “What do you want, Shouldra?” She scratches her snout, clearly angered.  \n\n");
			outputText("“I just want to live here.” Shouldra says, annoyed. “I would’ve been able to do it in peace, if not for this idiot over here.” She points at you, scowling. “Look, I won’t do anything to you if you don’t want it, just put those fucking charms away.”  \n\n");
			outputText("“And what about my kids? You gonna leave them alone too?” Amily says accusingly. “I know damn well you’ve been messing with them!”  \n\n");
			outputText("“It was consensual, damn you!” Shouldra wails, looking at one of your kids in particular.  \n\n");
			outputText("“It’s true.” He speaks up, getting looks of shock from Amily and a few of his siblings. He steps into the circle, throwing his blessed tag away. “I’ve been seeing Shouldra for some time now. Don’t hurt her, mom. Please.” As Amily begins to yell, he yells back. “I’m fully grown, mother. I can make my own choices.”  \n\n");
			outputText("Amily looks from you, to her kid, then to Shouldra. “...Fine.” She sits down, glaring daggers. “But if you’re living in our village, you’re going to help, just like everyone else.” Shouldra and Amily begin to barter back and forth, discussing hours worked, compensation, and other details. You slowly back away, running back to camp as soon as you’re out of the village.  \n\n");
			ShouldraSeenTown = 3;
			Intown = false;
			doNext(camp.returnToCampUseOneHour);
		}

		public function GhostFollowerGet():void {

		}

		public function ShouldraKill():void {
			clearOutput();
			outputText("At Amily’s rage, you look from her to Shouldra. Making your choice, you take a step back from the troublesome ghost, grabbing a spare paper charm from one of your children. Trapped in a holy circle, Shouldra wails in pain as the charms begin to glow.  \n\n");
			outputText("“No. No! Please, stop! I just…Wanted to live!” Tears stream down Shouldra’s face, but your kids are relentless, closing the circle. A swirl of energy envelops Shouldra, pulling her incorporeal form down, down into the earth. With a last wail and a ghostly middle finger to you, Shouldra vanishes into the ground beneath her house. Your children work fast, dousing the former dwelling in flammable liquids before setting the entire thing on fire, throwing their holy charms into the blaze. A disembodied wail fills the air, echoing through the town before gradually subsiding. “It’s Done.” Amily declares. “Good work, everyone.” \n\n");
			ShouldraSeenTown = 2;
			outputText(" \n\n");
			Intown = false;
			doNext(camp.returnToCampUseOneHour);
		}



		//----------------------Amily Scenes in Town------------------

//This function needs some serious function calling help, specifically gender, clothing etc.
		public function StayTheNight():void {
			clearOutput();
			outputText("You shake your head, smiling at your mousey lady. At the questioning look she gives you, you wave your hand at the village around you. You ask Amily if she really wants to go back to the camp tonight. Amily thinks about it for a moment, but shakes her head, leaning into you. The sun falls lower in the sky, and you lean in, kissing your mousey lover on the lips. Amily returns the kiss with ardour, a bit more experienced than when you first met, but still cute.  \n\n");
			outputText("You pick your lover up in your arms, carrying her to the tower. Amily giggles girlishly, her curly tail wrapping around your arms as you carry her in. As you enter your home, she gives you a warm, loving look, her eyes sparkling. Her tail seems to have a mind of its own, but right now, as she reaches up, brushing your cheek with one hand, it wraps around your waist, quivering with excitement.  \n\n");
			outputText("You don’t disrobe here, in the hallway, no. You decide to have some more fun, taking the stairs at a run. Amily gasps, holding onto you for dear life, but you roar playfully as you push the door to your shared bedroom open with your shoulder, leaping into your nest like bed, still holding Amily. You bounce off the springy mattress, still holding her, and she begins laughing hysterically, playfully slapping at you with both hands.  \n\n");
			outputText("<i>“What was that?</i>” She asks, still laughing. You grin, telling her that you wanted to get here as quickly as possible. And if you got to hold her the whole way, well, you aren’t complaining there, either. The look she gives you could wake a dead man, and her tail brushes your inner thigh.  \n\n");
			outputText("<i>“Oh, is that so?</i>” She asks, hands idly playing with your (Armor/clothing). <i>“And why were you in such a rush to get to bed, exactly?</i>” Her tail slides inside the leg of your (clothing/armour) and she watches the look on your face, her smile growing. <i>“Well?</i>”  Her small breasts are pressing against you.\n\n");
			if (player.hasCock()) {
				outputText("You harden, your [cock] tenting your [armor]. \n\n");
			}
			if (player.hasVagina()) {
				outputText(" Your lower lips begin to drool, and she smiles a little more, her tail taking the moisture and tickling your twat with it.  \n\n");
			}
			outputText("Amily’s rags moisten, betraying her own lust, not that you needed that to tell. You notice, your own lustful smile growing, and you kiss Amily full on the mouth, hands flying to her rags. Amily lets out a little squeal, her own hands flying to your [armor]. It takes a bit longer for her to undress you, but before long, you’re staring at her, her A-cup breasts rubbing against your [breasts]. Your mouse-girl’s clearly raring to go, and as she finishes, she pulls her lips back. <i>“We’re staying the night,</i>” she declares, licking her lips. <i>“And I’m gonna enjoy every second.</i>”  \n\n");
			if (player.hasCock()) {
				outputText("Amily’s eyes drop to your erection. She playfully shoves your shoulder, putting you on your back. Curious as to what she’ll do, you let her have her fun. Amily pumps your [cock] a few times, slathering your pre all over your shaft, before pressing her engorged lips against your tip. She slowly slides it in, moaning slightly as you get about halfway in.  \n\n");
				outputText("Straddling you, Amily lies down on top of you, kissing your shoulder, neck and lips as she moves her whole body up and down yours. Not only can you feel her tight, slick pussy, but the warm scraping of her fur up and down your stomach and chest. You bring your [arms] up, running your hands up and down your furry lover’s sides, which only serves to intensify her. Amily’s rock-hard nipples bounce off your chest and abs as she runs them up and down you. \n\n");
				outputText("After a few minutes of this, she slows down, resting her weight on top of you and moving her hips. Her tail wraps around your hand, guiding it to her full ass. You knead her assflesh, and you’re rewarded with a groan. Amily brings her face back to yours, eyes smouldering. <i>“Hmm...This was nice, but I think you’re being a bit lazy here</i>”, she teases. \n\n");
				outputText("Lazy? You’ll show her! Your hands move quickly, and you firmly grab Amily’s wrists, rolling so that you’re on top. You whisper into her ear that if she wanted a champion’s all, she’d better be sure she can handle it. You bury yourself to the hilt into her tight chasm, and although she squirms under you, her voice is honest.  \n\n");
				outputText("<i>“Yes. yes. Yes.</i>” That’s all you needed to hear! You begin pounding her in earnest, silencing her screams with your mouth. She moans and pants into your lips, paw-hands wrapped around your shoulders as you slide in and out of her channel. Amily squeals in delight, tongue lolling out, but as she arches her back, her vagina squeezing your member, you realise you aren’t done.  \n\n");
				outputText("You take her shoulders, one in each hand, and pull your lover to the side of the bed.. You spread her legs wide, and Amily blushes, almost embarrassed by this position. You don’t give her time to react, yanking her legs up and lining her vagina back up with your member. Amily’s eyes widen, and your mouse-girl grips the bed instinctively as you plunge back into her warm passage.  \n\n");
				outputText("<i>“Ooh! Oh! Oh!</i>” Amily’s still bright red, but her tail is lashed around your leg, and her vaginal walls are clamping tighter and tighter around you. You pick up the pace, ravaging your lover’s cunt, and before long, she lets out a final, extremely high-pitched wail before your mouse lover squirts, legs in the air, flailing. Her juices hit you in the chest and face, and the smell fills your nostrils. You cum hard, [legs] buckling as you pump your lover full of your juices. You remain on your feet for over a minute as your orgasm racks you. Eventually, you can’t take it anymore. You collapse on the bed beside Amily, Your [cock] still plugging her cunt. Her belly is noticeably larger, and despite your dick in the way, a steady stream of your cum trickles from her hole.  \n\n");
			}
			//if you or Amily are herm
			if (player.gender >= 3) {
				outputText("Your own vagina drips a steady stream of lubricant, staining the bed with your juices. <i>“Alright, [name]. You made me feel...hmm...really good. Now it’s my turn to play</i>”. You’re barely able to sit up, after your orgasm, but you do so, Amily diddling your twat.\n\n");
				outputText(" \n\n");
			}
			if ((flags[kFLAGS.AMILY_WANG_LENGTH] > 0) && (player.gender >= 2)){
				outputText("Amily opens one eye, looking at your moist cunt. She sits up, tweaking your button.  \n\n");
				outputText("Amily’s erection looks really good right now, and your needy cunt hasn’t been seen to. Your mouse-lover chuckles, wrapping her tail around your waist and pulling you towards her \n\n")
				if (player.gender >= 3) { outputText("<i>“Don’t worry, [name]. I’ll give you some time to recover before the main event.</i>”  \n\n");
				}
				outputText("Amily runs a paw-hand along your cheek, down past your [breasts] and along your stomach, light as a feather. It tickles, and she notices, tickling your stomach before suddenly dropping a hand to your [vagina]. She sticks one finger in, slowly wriggling it around in you, then two, then three, slowly building the intensity as you breathe heavily under her ministrations. She leans you up against the side of the bed, sitting you up, and you spread your legs for your mousey herm, giving her a lusty grin. As you present yourself, she blushes, smiling at you.  \n\n");
				outputText("Amily leans in, bringing herself to both your mouths at the same time. Your lips meet, tongues wrapping around each other as she presses at your entrance. Amily slides in without issue, and your moan hits the back of her throat. She pulls her head back, sliding deeper into you, and she almost purrs. <i>“Marae, I love you</i>”, she whispers, ramming herself home. You gasp as she slips under you, pulling you onto her lap. Your own weight drives her home, and you clench around her, arching your back against the sudden pleasure. <i>“That’s it, that’s it</i>”. Amily soothes, making little thrusts, pushing you up only to let gravity slide you right back down.  \n\n");
				if (flags[kFLAGS.PC_TIMES_BIRTHED_AMILYKIDS] > 0) {
					outputText("<i>“[name], my lover, mother to our kids.</i>” \n\n");
				}
				if (flags[kFLAGS.AMILY_BIRTH_TOTAL] > 0) {
					outputText("<i>“[name], my lover, father to our children.</i>” \n\n");
					outputText("You tighten even further around her, and she chuckles. <i>“Oh, you liked that?</i>” She whispers, a soft, light voice in your ear. <i>“You want more?</i>” She accompanies this with a thrust, bigger than the others. <i>“More little ones?</i>”\n\n");
					if (player.gender >= 3) {
						outputText("<i>“Two little litters, at the same time?</i>” <i>“Cause I do.</i>”\n\n");
					}
					outputText("She keeps thrusting, her member trembling inside you. Your muscles clench as you try to hold back your orgasm. <i>“Come for me, [name]?</i>” \n\n");
					outputText("At her increased pace and gentle requests, you can’t hold back anymore. With a cry that would wake up half the camp had you been back home, you cum on your mouse-herm’s cock, your walls milking her for all you’re worth. You arch your back, toes curling, as she follows right after, filling your womb with her warm seed. Her tail, around your thigh, curls tight as she clings to you, filling your belly. After a good thirty seconds, the flow of cum stops, and you begin to feel lightheaded. You fall back onto the bed, Amily still clinging to you, and you both lie there, breathing heavily.  \n\n");
				}
			}
		//Significant Chance for Amily and/or the PC to get pregnant.
		menu();
		addButton (1, "Next", AmilyAfterSex);
	}

	public function AmilyAfterSex():void {
		clearOutput();
		outputText("<i>“Marae above, that was…</i>” Amily can’t even finish the sentence. <i>“I love you.</i>” You return her affection, moving over to a dry(er) section of the bed before completely collapsing, pulling a sheet over you both and cuddling together in the afterglow.  \n\n");
		outputText("You wake up, and Amily’s there beside you, head under one arm. Her fur’s still damp from the night before, but you don’t really care. She feels you move, opening one eye. <i>“[name],</i>” she whispers, resting her head on your shoulder. Obviously she’s still half-asleep. You hold her close, rubbing her ears. About an hour later she opens her eyes, smiling at the look on your face.  \n\n");
		outputText("<i>“Been awake long?</i>” You assure her that you weren’t, and she yawns, stretching her arms. <i>“Well...You probably need to go now, don’t you, my champion?</i>” You nod, giving your mouse lover one last hug before getting out of bed.  \n\n");
		outputText("<i>“Well, I’ll just…</i>” Amily yawns. <i>“Give me a little bit of time, okay?</i>” She flops back down onto the bed, recoiling as she hits a particularly damp spot. <i>“Never mind, I’m awake.</i>” She stands up, wiping her arm on your chest. You laugh, pulling her into your embrace. Her fur is soft and warm, and she sighs. <i>“Just stay safe out there.</i>” Amily nags, looking into your eyes. <i>“And make sure to stay...You.</i>” She lets go, and sees you to the door. Several of your children follow you to the gate, waving you off as you return to camp. The sun’s barely up, and you roll your shoulders, ready for another day.\n\n");
		Intown = false;
		doNext (camp.returnToCampUseFourHours);
	}


}
}