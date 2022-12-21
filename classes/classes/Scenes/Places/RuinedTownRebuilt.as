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
	public static var ShouldraSeenTown:Boolean;
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
			"AmilyAngerCooldown":AmilyAngerCooldown
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
			AmilyAngerCooldown = o["AmilyAngerCooldown"]
		} else {
			// loading from old save
			resetState();
		}
	}
	
	public function RuinedTownRebuilt() 
	{
		Saves.registerSaveableState(this);
	}

	public function AmilyMadBar():void {
		clearOutput();
		outputText("You notice Amily sitting down in front of the bar, nursing a drink. You sit down wordlessly beside her, but as Amily looks over at you, her eyes burn, red from crying. She doesn’t say anything, but she clenches her fists, clearly still mad at you. You decide to leave your angry mouse-morph alone, especially since some of the bar’s patrons are giving you the stink-eye. You leave the bar and head back to camp.\n\n"); 
		doNext(camp.returnToCampUseOneHour);
	}

	public function AmilyBarTalk():void {
		clearOutput();
		outputText("You notice Amily at the bar, nursing some kind of fruit juice. She seems much calmer, and as you sit down, she sighs heavily. For a few seconds, neither of you speak, the silence building between you.\n\n"); 
		outputText("“...Hey.” She breaks the ice, voice low, but not angry. “...Are you doing alright?” Taken aback by her question, you fumble your answer, eventually telling Amily that yes, you’re alright, but you’re more worried about her.\n\n");
		outputText("“I suppose that’s fair.” Amily says. “...I’m not going to lie, [name], the first few days were hell. You…You’ve been good to me, and…I guess I just, kind of expected you to keep helping.” You open your mouth to speak, and Amily puts a finger over your mouth. “...Shh…Let me get through this, okay?” You nod, and she continues, leaning over the counter. “...But I’ve had a lot of time to think, and…I realised that I’ve…been putting a lot of pressure on you. You came here with your own quest, your own goals, and…I guess I needed you to refuse me, before it really sunk in.” Amily puts a hand on your shoulder. “I’m sorry. For demanding so much, and then…blowing up on you when you refused.” She hangs her head. “I love you…So much, and I…almost blew it.” Amily looks into your eyes, giving you a hopeful look. “I was able to find a place for now, near the farm. Demons don’t go there, and our kids can get work from Whitney, in exchange for shelter. It’s not a good long-term solution, but…Until we can start construction on the ruins, it’ll do.” She gives you a pleading look, eyes damp.\n\n");
		outputText("“We can wait for now, until you’ve got the time…But please, our kids need a proper home…and I don’t think we can do it without you.”   \n\n");
		outputText("You wrap your arms around Amily, letting the mouse-morph bury her head into your chest. Soothingly, you tell Amily that you missed her. That you just need some time, but once you’re ready, you’ll be there to ensure that your offspring have a safe town to call home.\n\n"); 
		outputText("Shaking, Amily sobs into you, tension bleeding from her muscles. “I love you.”  \n\n");
		outputText("Together, you and Amily stand, leaving Tel’Adre and heading back to camp.\n\n");
		flags[kFLAGS.AMILY_FOLLOWER] = 1;
		AmilyAtWetBitch = false;
		doNext(camp.returnToCampUseOneHour);
	}
	
}
}