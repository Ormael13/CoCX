﻿package classes
{
import classes.BodyParts.Antennae;
import classes.BodyParts.Arms;
import classes.BodyParts.Ears;
import classes.BodyParts.Eyes;
import classes.BodyParts.Gills;
import classes.BodyParts.Hair;
import classes.BodyParts.Horns;
import classes.BodyParts.RearBody;
import classes.BodyParts.Tail;
import classes.BodyParts.Tongue;
import classes.GlobalFlags.kACHIEVEMENTS;
import classes.GlobalFlags.kFLAGS;
import classes.IMutations.IMutationsLib;
import classes.Items.*;
import classes.Scenes.Areas.Desert.SandWitchScene;
import classes.Scenes.NPCs.JojoScene;
import classes.Scenes.NPCs.XXCNPC;
import classes.Scenes.SceneLib;
import classes.Stats.BuffableStat;
import classes.Stats.IStat;
import classes.internals.Jsonable;
import classes.internals.SaveableState;
import classes.lists.BreastCup;

import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.events.MouseEvent;
import flash.net.FileReference;
import flash.net.SharedObject;
import flash.net.URLLoader;
import flash.net.URLLoaderDataFormat;
import flash.net.URLRequest;
import flash.utils.ByteArray;
import flash.utils.getDefinitionByName;

CONFIG::AIR
{
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
}

public class Saves extends BaseContent {

	private static const SAVE_FILE_CURRENT_INTEGER_FORMAT_VERSION:int		= 816;
		//Didn't want to include something like this, but an integer is safer than depending on the text version number from the CoC class.
		//Also, this way the save file version doesn't need updating unless an important structural change happens in the save file.

	private var gameStateGet:Function;
	private var gameStateSet:Function;
	private var itemStorageGet:Function;
	private var pearlStorageGet:Function;
	private var gearStorageGet:Function;


    //Any classes that need to be made aware when the game is saved or loaded can add themselves to this array using saveAwareAdd.
    //	Once in the array they will be notified by Saves.as whenever the game needs them to write or read their data to the flags array.
	private static var _saveAwareClassList:Vector.<SaveAwareInterface> = new Vector.<SaveAwareInterface>();
	private static var _saveableStates:Object = {};

    public function Saves(gameStateDirectGet:Function, gameStateDirectSet:Function) {
		gameStateGet = gameStateDirectGet; //This is so that the save game functions (and nothing else) get direct access to the gameState variable
		gameStateSet = gameStateDirectSet;
	}

	public function linkToInventory(itemStorageDirectGet:Function, pearlStorageDirectGet:Function, gearStorageDirectGet:Function):void {
		itemStorageGet = itemStorageDirectGet;
		pearlStorageGet = pearlStorageDirectGet;
		gearStorageGet = gearStorageDirectGet;
	}

CONFIG::AIR {
public var airFile:File;
}
public var file:FileReference;
public var loader:URLLoader;

public var saveFileNames:Array = ["CoC_1", "CoC_2", "CoC_3", "CoC_4", "CoC_5", "CoC_6", "CoC_7", "CoC_8", "CoC_9", "CoC_10", "CoC_11", "CoC_12", "CoC_13", "CoC_14"];
public var versionProperties:Object = { "legacy" : 100, "0.8.3f7" : 124, "0.8.3f8" : 125, "0.8.4.3":119, "latest" : 119 };
public var savedGameDir:String = "data/com.fenoxo.coc";

public var notes:String = "";

public function loadSaveDisplay(saveFile:Object, slotName:String):String
{
	var holding:String = "";
	if (saveFile.data.exists/* && saveFile.data.flags[2066] == undefined*/)
	{
		if (saveFile.data.notes == undefined)
		{
			saveFile.data.notes = "No notes available.";
		}
		holding = slotName;
		holding += ":  <b>";
		holding += saveFile.data.short;
		holding += "</b> - <i>" + saveFile.data.notes + "</i>\r";
		holding += "Days - " + saveFile.data.days + " | Gender - ";
		if (saveFile.data.gender == 0)
			holding += "U";
		if (saveFile.data.gender == 1)
			holding += "M";
		if (saveFile.data.gender == 2)
			holding += "F";
		if (saveFile.data.gender == 3)
			holding += "H";
		if (saveFile.data.flags != undefined) {
			holding += " | Difficulty - ";
			if (saveFile.data.flags[kFLAGS.GAME_DIFFICULTY] != undefined) { //Handles undefined
				if (saveFile.data.flags[kFLAGS.GAME_DIFFICULTY] == 0 || saveFile.data.flags[kFLAGS.GAME_DIFFICULTY] == null) {
					if (saveFile.data.flags[kFLAGS.EASY_MODE_ENABLE_FLAG] == 1) holding += "<font color=\"#008000\">Easy</font>";
					else holding += "<font color=\"#808000\">Normal</font>";
				}
				if (saveFile.data.flags[kFLAGS.GAME_DIFFICULTY] == 1)
					holding += "<font color=\"#800000\">Hard</font>";
				if (saveFile.data.flags[kFLAGS.GAME_DIFFICULTY] == 2)
					holding += "<font color=\"#C00000\">Nightmare</font>";
				if (saveFile.data.flags[kFLAGS.GAME_DIFFICULTY] == 3)
					holding += "<font color=\"#FF0000\">EXTREME</font>";
				if (saveFile.data.flags[kFLAGS.GAME_DIFFICULTY] >= 4)
					holding += "<font color=\"#FF0000\">XIANXIA</font>";
			}
			else {
				if (saveFile.data.flags[kFLAGS.EASY_MODE_ENABLE_FLAG] != undefined) { //Workaround to display Easy if difficulty is set to easy.
					if (saveFile.data.flags[kFLAGS.EASY_MODE_ENABLE_FLAG] == 1) holding += "<font color=\"#008000\">Easy</font>";
					else holding += "<font color=\"#808000\">Normal</font>";
				}
				else holding += "<font color=\"#808000\">Normal</font>";
			}
		}
		else {
			holding += " | <b>REQUIRES UPGRADE</b>";
		}
		holding += "\r";
		return holding;
	}
	/*else if (saveFile.data.exists && saveFile.data.flags[2066] != undefined) //This check is disabled in CoC Revamp Mod. Otherwise, we would be unable to load mod save files!
	{
		return slotName + ":  <b>UNSUPPORTED</b>\rThis is a save file that has been created in a modified version of CoC.\r";
	}*/
	else
	{
		return slotName + ":  <b>EMPTY</b>\r     \r";
	}
}

CONFIG::AIR
{

	private function selectLoadButton(gameObject:Object, slot:String):void {
		//trace("Loading save with name ", fileList[fileCount].url, " at index ", i);
		clearOutput();
		loadGameObject(gameObject, slot);
		outputText("Slot " + slot + " Loaded!");
		statScreenRefresh();
		doNext(playerMenu);
	}

public function loadScreenAIR():void
{
	var airSaveDir:File = File.documentsDirectory.resolvePath(savedGameDir);
	var fileList:Array = new Array();
	var maxSlots:int = saveFileNames.length;
	var slots:Array = new Array(maxSlots);
	var gameObjects:Array = new Array(maxSlots);

	try
	{
		airSaveDir.createDirectory();
		fileList = airSaveDir.getDirectoryListing();
	}
	catch (error:Error)
	{
		clearOutput();
		outputText("Error reading save directory: " + airSaveDir.url + " (" + error.message + ")");
		return;
	}
	clearOutput();
	outputText("<b><u>Slot: Sex,  Game Days Played</u></b>\r");

	var i:uint = 0;
	for (var fileCount:uint = 0; fileCount < fileList.length; fileCount++)
	{
		// We can only handle maxSlots at this time
		if (i >= maxSlots)
			break;

		// Only check files expected to be save files
		var pattern:RegExp = /\.coc$/i;
		if (!pattern.test(fileList[fileCount].url))
			continue;

		gameObjects[i] = getGameObjectFromFile(fileList[fileCount]);
		outputText(loadSaveDisplay(gameObjects[i], String(i+1)));

		if (gameObjects[i].data.exists)
		{
			//trace("Creating function with indice = ", i);
			(function(i:int):void		// messy hack to work around closures. See: http://en.wikipedia.org/wiki/Immediately-invoked_function_expression
			{
				slots[i] = function() : void 		// Anonymous functions FTW
				{
					trace("Loading save with name ", fileList[fileCount].url, " at index ", i);
					clearOutput();
					loadGameObject(gameObjects[i]);
					outputText("Slot " + String(i+1) + " Loaded!");
					statScreenRefresh();
					doNext(playerMenu);
				}
			})(i);
		}
		else
		{
			slots[i] = null;		// You have to set the parameter to 0 to disable the button
		}
		i++;
	}
	menu();
	var s:int = 0;
	while (s < 14) {
		//if (slots[s] != null) addButton(s, "Slot " + (s + 1), slots[s]);
		if (slots[s] != null) addButton(s, "Slot " + (s + 1), selectLoadButton, gameObjects[s], "CoC_" + String(s+1));
		s++;
	}
	addButton(14, "Back", returnToSaveMenu);
}

public function getGameObjectFromFile(aFile:File):Object
{
	var stream:FileStream = new FileStream();
	var bytes:ByteArray = new ByteArray();
	try
	{
		stream.open(aFile, FileMode.READ);
		stream.readBytes(bytes);
		stream.close();
		return bytes.readObject();
	}
	catch (error:Error)
	{
		clearOutput();
		outputText("Failed to read save file, " + aFile.url + " (" + error.message + ")");
	}
	return null;
 }

}

public function loadScreen():void
{
	var slots:Array = new Array(saveFileNames.length);

	clearOutput();
	outputText("<b><u>Slot: Sex,  Game Days Played</u></b>\r");

	for (var i:int = 0; i < saveFileNames.length; i += 1)
	{
		var test:Object = SharedObject.getLocal(saveFileNames[i], "/");
		outputText(loadSaveDisplay(test, String(i + 1)));
		if (test.data.exists/* && test.data.flags[2066] == undefined*/)
		{
			//trace("Creating function with indice = ", i);
			(function(i:int):void		// messy hack to work around closures. See: http://en.wikipedia.org/wiki/Immediately-invoked_function_expression
			{
				slots[i] = function() : void 		// Anonymous functions FTW
				{
					trace("Loading save with name", saveFileNames[i], "at index", i);
					if (loadGame(saveFileNames[i])) {
						doNext(playerMenu);
						showStats();
						statScreenRefresh();
						clearOutput();
						outputText("Slot " + i + " Loaded!");
					}
				}
			})(i);
		}
		else
		{
			slots[i] = null;		// You have to set the parameter to 0 to disable the button
		}
	}
	menu();
	var s:int = 0;
	while (s < 14) {
		if (slots[s] != 0) addButton(s, "Slot " + (s+1), slots[s]);
		s++;
	}
	addButton(14, "Back", returnToSaveMenu);
}

public function saveScreen():void
{
	mainView.nameBox.x = mainView.mainText.x;
	mainView.nameBox.y = 620;
	mainView.nameBox.width = 550;
	mainView.nameBox.text = "";
	mainView.nameBox.maxChars = 54;
	mainView.nameBox.visible = true;
	/*
	//removing extra mutations from save
	for each(var mutation:PerkType in IMutationsLib.mutationsArray("")){
		if (player.perkv1(mutation) == 0) player.removePerk(mutation);
	}
	player.removePerk(IMutationsLib.MutationsTemplateIM);
	 */

	// var test; // Disabling this variable because it seems to be unused.
	if (flags[kFLAGS.HARDCORE_MODE] > 0)
	{
		saveGame(flags[kFLAGS.HARDCORE_SLOT]);
		clearOutput();
		outputText("You may not create copies of Hardcore save files! Your current progress has been saved.");
		doNext(playerMenu);
		return;
	}

	clearOutput();
	if (player.slotName != "VOID")
		outputText("<b>Last saved or loaded from: " + player.slotName + "</b>\r\r");
	outputText("<b><u>Slot: Sex,  Game Days Played</u></b>\r");

	var saveFuncs:Array = [];


	for (var i:int = 0; i < saveFileNames.length; i += 1)
	{
		var test:Object = SharedObject.getLocal(saveFileNames[i], "/");
		outputText(loadSaveDisplay(test, String(i + 1)));
		trace("Creating function with indice = ", i);
		(function(i:int) : void		// messy hack to work around closures. See: http://en.wikipedia.org/wiki/Immediately-invoked_function_expression
		{
			saveFuncs[i] = function() : void 		// Anonymous functions FTW
			{
				trace("Saving game with name", saveFileNames[i], "at index", i);
				saveGame(saveFileNames[i], true);
			}
		})(i);

	}


	if (player.slotName == "VOID")
		outputText("\r\r");

	outputText("<b>Leave the notes box blank if you don't wish to change notes.\r<u>NOTES:</u></b>");
	menu();
	var s:int = 0;
	while (s < 14) {
		addButton(s, "Slot " + (s+1), saveFuncs[s]);
		s++;
	}
	addButton(14, "Back", returnToSaveMenu);
}

public function saveLoad(e:MouseEvent = null):void
{
	mainView.eventTestInput.x = -10207.5;
	mainView.eventTestInput.y = -1055.1;
	//Hide the name box in case of backing up from save
	//screen so it doesnt overlap everything.
	mainView.nameBox.visible = false;
	var autoSaveSuffix:String = "";
	if (player && player.autoSave) autoSaveSuffix = "ON";
	else autoSaveSuffix = "OFF";

	clearOutput();
	outputText("<b>Where are my saves located?</b>\n");
	outputText("<i>In Windows Vista/7 (IE/FireFox/Other)</i>: <pre>Users/{username}/Appdata/Roaming/Macromedia/Flash Player/#Shared Objects/{GIBBERISH}/</pre>\n\n");
	outputText("In Windows Vista/7 (Chrome): <pre>Users/{username}/AppData/Local/Google/Chrome/User Data/Default/Pepper Data/Shockwave Flash/WritableRoot/#SharedObjects/{GIBBERISH}/</pre>\n\n");
	outputText("Inside that folder it will saved in a folder corresponding to where it was played from.  If you saved the CoC.swf to your HDD, then it will be in a folder called localhost.  If you played from my website, it will be in fenoxo.com.  The save files will be labelled CoC_1.sol, CoC_2.sol, CoC_3.sol, etc.</i>\n\n");
	outputText("<b>Why do my saves disappear all the time?</b>\n<i>There are numerous things that will wipe out flash local shared files.  If your browser or player is set to delete flash cookies or data, that will do it.  CCleaner will also remove them.  CoC or its updates will never remove your savegames - if they disappear something else is wiping them out.</i>\n\n");
	outputText("<b>When I play from my HDD I have one set of saves, and when I play off your site I have a different set of saves.  Why?</b>\n<i>Flash stores saved data relative to where it was accessed from.  Playing from your HDD will store things in a different location than fenoxo.com or FurAffinity.</i>\n");
	outputText("<i>If you want to be absolutely sure you don't lose a character, copy the .sol file for that slot out and back it up! <b>For more information, google flash shared objects.</b></i>\n\n");
	outputText("<b>Why does the Save File and Load File option not work?</b>\n");
	outputText("<i>Save File and Load File are limited by the security settings imposed upon CoC by Flash. These options will only work if you have downloaded the game from the website, and are running it from your HDD. Additionally, they can only correctly save files to and load files from the directory where you have the game saved.</i>");
	menu();
	addButton(1, "Load", loadScreen);
	addButton(2, "Delete", deleteScreen);
	addButton(6, "Load File", openSave);

	if (EventParser.badEnded) {
		addButton(14, "Back", EventParser.gameOver, true);
		return;
	}
	if (!player) {
		addButton(14, "Back", CoC.instance.mainMenu.mainMenu);
		return;
	}
	if (inDungeon) {
		addButton(14, "Back", playerMenu);
		return;
	}
	if (gameStateGet() == 3) {
		addButton(0, "Save", saveScreen);
		addButton(5, "Save to File", saveToFile);
		addButton(3, "AutoSave: " + autoSaveSuffix, autosaveToggle);
		addButton(14, "Back", CoC.instance.mainMenu.mainMenu);
	}
	else
	{
		addButton(0, "Save", saveScreen);
		addButton(5, "Save to File", saveToFile);
		addButton(3, "AutoSave: " + autoSaveSuffix, autosaveToggle);
		addButton(14, "Back", playerMenu);
	}
	if (flags[kFLAGS.HARDCORE_MODE] >= 1) {
		removeButton(5); //Disable "Save to File" in Hardcore Mode.
	}
}

private function saveToFile():void {
	saveGameObject(null, true);
}

private function autosaveToggle():void {
	player.autoSave = !player.autoSave;
	saveLoad();
}

public function deleteScreen():void
{
	clearOutput();
	outputText("Slot,  Race,  Sex,  Game Days Played\n");


	var delFuncs:Array = [];


	for (var i:int = 0; i < saveFileNames.length; i += 1)
	{
		var test:Object = SharedObject.getLocal(saveFileNames[i], "/");
		outputText(loadSaveDisplay(test, String(i + 1)));
		if (test.data.exists)
		{
			//slots[i] = loadFuncs[i];

			trace("Creating function with indice = ", i);
			(function(i:int):void		// messy hack to work around closures. See: http://en.wikipedia.org/wiki/Immediately-invoked_function_expression
			{
				delFuncs[i] = function() : void 		// Anonymous functions FTW
				{
					flags[kFLAGS.TEMP_STORAGE_SAVE_DELETION] = saveFileNames[i];
					confirmDelete();
				}
			})(i);
		}
		else
			delFuncs[i] = null;	//disable buttons for empty slots
	}

	outputText("\n<b>ONCE DELETED, YOUR SAVE IS GONE FOREVER.</b>");
	menu();
	var s:int = 0;
	while (s < 14) {
		if (delFuncs[s] != null) addButton(s, "Slot " + (s+1), delFuncs[s]);
		s++;
	}
	addButton(14, "Back", returnToSaveMenu);
	/*
	choices("Slot 1", delFuncs[0],
			"Slot 2", delFuncs[1],
			"Slot 3", delFuncs[2],
			"Slot 4", delFuncs[3],
			"Slot 5", delFuncs[4],
			"Slot 6", delFuncs[5],
			"Slot 7", delFuncs[6],
			"Slot 8", delFuncs[7],
			"Slot 9", delFuncs[8],
			"Back", returnToSaveMenu);*/
}

public function confirmDelete():void
{
	clearOutput();
	outputText("You are about to delete the following save: <b>" + flags[kFLAGS.TEMP_STORAGE_SAVE_DELETION] + "</b>\n\nAre you sure you want to delete it?");
	simpleChoices("No", deleteScreen, "Yes", purgeTheMutant, "", null, "", null, "", null);
}

public function purgeTheMutant():void
{
	var test:* = SharedObject.getLocal(flags[kFLAGS.TEMP_STORAGE_SAVE_DELETION], "/");
	trace("DELETING SLOT: " + flags[kFLAGS.TEMP_STORAGE_SAVE_DELETION]);
	var blah:Array = ["been virus bombed", "been purged", "been vaped", "been nuked from orbit", "taken an arrow to the knee", "fallen on its sword", "lost its reality matrix cohesion", "been cleansed", "suffered the following error: (404) Porn Not Found", "been deleted"];

	trace(blah.length + " array slots");
	var select:Number = rand(blah.length);
	clearOutput();
	outputText(flags[kFLAGS.TEMP_STORAGE_SAVE_DELETION] + " has " + blah[select] + ".");
	test.clear();
	doNext(deleteScreen);
}

public function confirmOverwrite(slot:String):void {
	mainView.nameBox.visible = false;
	clearOutput();
	outputText("You are about to overwrite the following save slot: " + slot + ".");
	outputText("\n\n<i>If you choose to overwrite a save file from the original CoC, it will no longer be playable on the original version. I recommend you use slots 10-14 for saving on the mod.</i>");
	outputText("\n\n<b>ARE YOU SURE?</b>");
	doYesNo(createCallBackFunction(saveGame, slot), saveScreen);
}

public function saveGame(slot:String, bringPrompt:Boolean = false):void
{
	var saveFile:* = SharedObject.getLocal(slot, "/");
	if (player.slotName != slot && saveFile.data.exists && bringPrompt) {
		confirmOverwrite(slot);
		return;
	}
	player.slotName = slot;
	saveGameObject(slot, false);
}

public function loadGame(slot:String):void
{
	var saveFile:* = SharedObject.getLocal(slot, "/");

	// Check the property count of the file
	var numProps:int = 0;
	for (var prop:String in saveFile.data)
	{
		numProps++;
	}

	var sfVer:*;
	if (saveFile.data.version == undefined)
	{
		sfVer = versionProperties["legacy"];
	}
	else
	{
		sfVer = versionProperties[saveFile.data.version];
	}

	if (!(sfVer is Number))
	{
		sfVer = versionProperties["latest"];
	} else {
		sfVer = sfVer as Number;
	}

	trace("File version "+(saveFile.data.version || "legacy")+"expects propNum " + sfVer);

	if (numProps < sfVer)
	{
		trace("Got " + numProps + " file properties -- failed!");
		clearOutput();
		outputText("<b>Aborting load.  The current save file is missing a number of expected properties.</b>\n\n");

		var backup:SharedObject = SharedObject.getLocal(slot + "_backup", "/");

		if (backup.data.exists)
		{
			outputText("Would you like to load the backup version of this slot?");
			menu();
			addButton(0, "Yes", loadGame, (slot + "_backup"));
			addButton(1, "No", saveLoad);
		}
		else
		{
			menu();
			addButton(0, "Next", saveLoad);
		}
	}
	else
	{
		trace("Got " + numProps + " file properties -- success!");
		// I want to be able to write some debug stuff to the GUI during the loading process
		// Therefore, we clear the display *before* calling loadGameObject
		clearOutput();

		loadGameObject(saveFile, slot);
		loadPermObject();
		outputText("Game Loaded");

		if (player.slotName == "VOID")
		{
			trace("Setting in-use save slot to: " + slot);
			player.slotName = slot;
		}
		statScreenRefresh();
		doNext(playerMenu);
		EventParser.badEnded = false; //reset bad end if we're going from it
	}
}

//Used for tracking achievements.
public function savePermObject(isFile:Boolean):void {
	//Initialize the save file
	var saveFile:*;
	var backup:SharedObject;
	if (isFile)
	{
		saveFile = {};

		saveFile.data = {};
	}
	else
	{
		saveFile = SharedObject.getLocal("CoC_Main", "/");
	}

	saveFile.data.exists = true;
	saveFile.data.version = ver;

	var processingError:Boolean = false;
	var dataError:Error;

	try {
		var i:int;
		//flag settings
		saveFile.data.flags = [];
		for (i = 0; i < achievements.length; i++) {
			if (flags[i] != 0) {
				saveFile.data.flags[i] = 0;
			}
		}

		// saving global settings
		for each (var globalFlag:int in kFLAGS.GLOBAL_FLAGS_ARRAY)
			saveFile.data.flags[globalFlag] = flags[globalFlag];

		//achievements
		saveFile.data.achievements = [];
		for (i = 0; i < achievements.length; i++)
		{
			// Don't save unset/default achievements
			if (achievements[i] != 0)
			{
				saveFile.data.achievements[i] = achievements[i];
			}
		}
        if (CoC.instance.permObjVersionID != 0)
            saveFile.data.permObjVersionID = CoC.instance.permObjVersionID;
    }
	catch (error:Error)
	{
		processingError = true;
		dataError = error;
		trace(error.message);
	}
	trace("done saving achievements");
}

public function loadPermObject():void {
	var saveFile:* = SharedObject.getLocal("CoC_Main", "/");
	trace("Loading achievements!");
	//Initialize the save file
	//var saveFile:Object = loader.data.readObject();
	if (saveFile.data.exists)
	{
		//Load saved flags.
		if (saveFile.data.flags)
			for each (var globalFlag:int in kFLAGS.GLOBAL_FLAGS_ARRAY)
				if (saveFile.data.flags[globalFlag] != undefined) flags[globalFlag] = saveFile.data.flags[globalFlag];

		//achievements, will check if achievement exists.
		if (saveFile.data.achievements) {
			for (var i:int = 0; i < achievements.length; i++)
			{
				if (saveFile.data.achievements[i] != undefined)
					achievements[i] = saveFile.data.achievements[i];
			}
		}

		if (saveFile.data.permObjVersionID != undefined) {
            CoC.instance.permObjVersionID = saveFile.data.permObjVersionID;
            trace("Found internal permObjVersionID:", CoC.instance.permObjVersionID);
        }

if (CoC.instance.permObjVersionID < 1039900) {
            // apply fix for issue #337 (Wrong IDs in kACHIEVEMENTS conflicting with other achievements)
			achievements[kACHIEVEMENTS.ZONE_EXPLORER] = 0;
			achievements[kACHIEVEMENTS.ZONE_SIGHTSEER] = 0;
			achievements[kACHIEVEMENTS.GENERAL_PORTAL_DEFENDER] = 0;
			achievements[kACHIEVEMENTS.GENERAL_BAD_ENDER] = 0;
            CoC.instance.permObjVersionID = 1039900;
            savePermObject(false);
            trace("PermObj internal versionID updated:", CoC.instance.permObjVersionID);
        }
	}
}

/*

OH GOD SOMEONE FIX THIS DISASTER!!!!111one1ONE!

*/
//FURNITURE'S JUNK
public function saveGameObject(slot:String, isFile:Boolean):void
{
	//Autosave stuff
	if (player.slotName != "VOID")
		player.slotName = slot;

	var backupAborted:Boolean = false;

	saveAllAwareClasses(CoC.instance); //Informs each saveAwareClass that it must save its values in the flags array
    var counter:Number = player.cocks.length;
	//Initialize the save file
	var saveFile:*;
	var backup:SharedObject;
	if (isFile)
	{
		saveFile = {};

		saveFile.data = {};
	}
	else
	{
		saveFile = SharedObject.getLocal(slot, "/");
	}

	//Set a single variable that tells us if this save exists

	saveFile.data.exists = true;
	saveFile.data.version = ver;
	flags[kFLAGS.SAVE_FILE_INTEGER_FORMAT_VERSION] = SAVE_FILE_CURRENT_INTEGER_FORMAT_VERSION;

	saveFile.data.ss = {};
	for (var key:String in _saveableStates) {
		try {
			var ss:SaveableState  = _saveableStates[key];
			saveFile.data.ss[key] = ss.saveToObject();
		} catch (e:Error) {
			CoC_Settings.error("Error saving ss."+key+": "+e.getStackTrace());
		}
	}

	//CLEAR OLD ARRAYS

	//Save sum dataz
	trace("SAVE DATAZ");
	saveFile.data.short = player.short;
	saveFile.data.a = player.a;

	//Notes
	if (mainView.nameBox.text != "")
	{
		saveFile.data.notes = mainView.nameBox.text;
		notes = mainView.nameBox.text;
	}
	else
	{
		saveFile.data.notes = notes;
		mainView.nameBox.visible = false;
	}
	if (flags[kFLAGS.HARDCORE_MODE] > 0)
	{
		saveFile.data.notes = "<font color=\"#ff0000\">HARDCORE MODE</font>";
	}
	var processingError:Boolean = false;
	var dataError:Error;

	try
	{
		//flags
		saveFile.data.flags = [];
		for (var i:int = 0; i < flags.length; i++)
		{
			// Don't save unset/default flags
			if (flags[i] != 0)
			{
				saveFile.data.flags[i] = flags[i];
			}
		}
		saveFile.data.counters = [];

		//CLOTHING/ARMOR
		saveFile.data.armorId = player.armor.id;
		saveFile.data.weaponId = player.weapon.id;
		saveFile.data.weaponRangeId = player.weaponRange.id;
		saveFile.data.weaponFlyingSwordsId = player.weaponFlyingSwords.id;
		saveFile.data.headJewelryId = player.headJewelry.id;
		saveFile.data.necklaceId = player.necklace.id;
		saveFile.data.jewelryId = player.jewelry1.id;
		saveFile.data.jewelryId2 = player.jewelry2.id;
		saveFile.data.jewelryId3 = player.jewelry3.id;
		saveFile.data.jewelryId4 = player.jewelry4.id;
		saveFile.data.miscJewelryId = player.miscJewelry1.id;
		saveFile.data.miscJewelryId2 = player.miscJewelry2.id;
		saveFile.data.shieldId = player.shield.id;
		saveFile.data.upperGarmentId = player.upperGarment.id;
		saveFile.data.lowerGarmentId = player.lowerGarment.id;
		saveFile.data.armorName = player.modArmorName;
		saveFile.data.vehiclesId = player.vehicles.id;

		//saveFile.data.weaponName = player.weaponName;// uncomment for backward compatibility
		//saveFile.data.weaponVerb = player.weaponVerb;// uncomment for backward compatibility
		//saveFile.data.armorDef = player.armorDef;// uncomment for backward compatibility
		//saveFile.data.armorPerk = player.armorPerk;// uncomment for backward compatibility
		//saveFile.data.weaponAttack = player.weaponAttack;// uncomment for backward compatibility
		//saveFile.data.weaponPerk = player.weaponPerk;// uncomment for backward compatibility
		//saveFile.data.weaponValue = player.weaponValue;// uncomment for backward compatibility
		//saveFile.data.armorValue = player.armorValue;// uncomment for backward compatibility

		//PIERCINGS
		saveFile.data.nipplesPierced = player.nipplesPierced;
		saveFile.data.nipplesPShort = player.nipplesPShort;
		saveFile.data.nipplesPLong = player.nipplesPLong;
		saveFile.data.lipPierced = player.lipPierced;
		saveFile.data.lipPShort = player.lipPShort;
		saveFile.data.lipPLong = player.lipPLong;
		saveFile.data.tonguePierced = player.tonguePierced;
		saveFile.data.tonguePShort = player.tonguePShort;
		saveFile.data.tonguePLong = player.tonguePLong;
		saveFile.data.eyebrowPierced = player.eyebrowPierced;
		saveFile.data.eyebrowPShort = player.eyebrowPShort;
		saveFile.data.eyebrowPLong = player.eyebrowPLong;
		saveFile.data.earsPierced = player.earsPierced;
		saveFile.data.earsPShort = player.earsPShort;
		saveFile.data.earsPLong = player.earsPLong;
		saveFile.data.nosePierced = player.nosePierced;
		saveFile.data.nosePShort = player.nosePShort;
		saveFile.data.nosePLong = player.nosePLong;

		saveFile.data.stats = {};
		for each(var k:String in player.statStore.allStatNames()) {
			var stat:Jsonable = player.statStore.findStat(k) as Jsonable;
			if (stat) {
				saveFile.data.stats[k] = (stat as Jsonable).saveToObject();
			}
		}
		//MAIN STATS
		saveFile.data.str = player.str;
		saveFile.data.tou = player.tou;
		saveFile.data.spe = player.spe;
		saveFile.data.inte = player.inte;
		saveFile.data.wis = player.wis;
		saveFile.data.lib = player.lib;
		saveFile.data.sens = player.sens;
		saveFile.data.cor = player.cor;
		saveFile.data.fatigue = player.fatigue;
		saveFile.data.mana = player.mana;
		saveFile.data.soulforce = player.soulforce;
		saveFile.data.wrath = player.wrath;
		//Combat STATS
		saveFile.data.HP = player.HP;
		saveFile.data.lust = player.lust;
		saveFile.data.teaseLevel = player.teaseLevel;
		saveFile.data.teaseXP = player.teaseXP;
		//Mastery

        //Mastery attributes
        saveFile.data.combatMastery = [];
		for(i = 0; i < player.combatMastery.length; i++) {
            saveFile.data.combatMastery.push({index:i, level:player.combatMastery[i].level, experience:player.combatMastery[i].experience});
        }

//
//        saveFile.data.masteryFeralCombatLevel = player.masteryFeralCombatLevel;
//		saveFile.data.masteryFeralCombatXP = player.masteryFeralCombatXP;
//		saveFile.data.masteryGauntletLevel = player.masteryGauntletLevel;
//		saveFile.data.masteryGauntletXP = player.masteryGauntletXP;
//		saveFile.data.masteryDaggerLevel = player.masteryDaggerLevel;
//		saveFile.data.masteryDaggerXP = player.masteryDaggerXP;
//		saveFile.data.masterySwordLevel = player.masterySwordLevel;
//		saveFile.data.masterySwordXP = player.masterySwordXP;
//		saveFile.data.masteryAxeLevel = player.masteryAxeLevel;
//		saveFile.data.masteryAxeXP = player.masteryAxeXP;
//		saveFile.data.masteryMaceHammerLevel = player.masteryMaceHammerLevel;
//		saveFile.data.masteryMaceHammerXP = player.masteryMaceHammerXP;
//		saveFile.data.masteryDuelingSwordLevel = player.masteryDuelingSwordLevel;
//		saveFile.data.masteryDuelingSwordXP = player.masteryDuelingSwordXP;
//		saveFile.data.masteryPolearmLevel = player.masteryPolearmLevel;
//		saveFile.data.masteryPolearmXP = player.masteryPolearmXP;
//		saveFile.data.masterySpearLevel = player.masterySpearLevel;
//		saveFile.data.masterySpearXP = player.masterySpearXP;
//		saveFile.data.masteryWhipLevel = player.masteryWhipLevel;
//		saveFile.data.masteryWhipXP = player.masteryWhipXP;
//		saveFile.data.masteryExoticLevel = player.masteryExoticLevel;
//		saveFile.data.masteryExoticXP = player.masteryExoticXP;
//		saveFile.data.masteryArcheryLevel = player.masteryArcheryLevel;
//		saveFile.data.masteryArcheryXP = player.masteryArcheryXP;
//		saveFile.data.masteryThrowingLevel = player.masteryThrowingLevel;
//		saveFile.data.masteryThrowingXP = player.masteryThrowingXP;
//		saveFile.data.masteryFirearmsLevel = player.masteryFirearmsLevel;
//		saveFile.data.masteryFirearmsXP = player.masteryFirearmsXP;
//		saveFile.data.dualWSLevel = player.dualWSLevel;
//		saveFile.data.dualWSXP = player.dualWSXP;
//		saveFile.data.dualWNLevel = player.dualWNLevel;
//		saveFile.data.dualWNXP = player.dualWNXP;
//		saveFile.data.dualWLLevel = player.dualWLLevel;
//		saveFile.data.dualWLXP = player.dualWLXP;
//		saveFile.data.dualWFLevel = player.dualWFLevel;
//		saveFile.data.dualWFXP = player.dualWFXP;
		//Mining
		saveFile.data.miningLevel = player.miningLevel;
		saveFile.data.miningXP = player.miningXP;
		//Farming
		saveFile.data.farmingLevel = player.farmingLevel;
		saveFile.data.farmingXP = player.farmingXP;
		//Herbalism
		saveFile.data.herbalismLevel = player.herbalismLevel;
		saveFile.data.herbalismXP = player.herbalismXP;
		//Hunger
		saveFile.data.hunger = player.hunger;
		//LEVEL STATS
		saveFile.data.XP = player.XP;
		saveFile.data.level = player.level;
		saveFile.data.negativeLevel = player.negativeLevel;
		saveFile.data.gems = player.gems;
		saveFile.data.perkPoints = player.perkPoints;
		saveFile.data.statPoints = player.statPoints;
		saveFile.data.superPerkPoints = player.superPerkPoints;
		saveFile.data.ascensionPerkPoints = player.ascensionPerkPoints;
		//Appearance
		saveFile.data.startingRace = player.startingRace;
		saveFile.data.gender = player.gender;
		saveFile.data.femininity = player.femininity;
		saveFile.data.thickness = player.thickness;
		saveFile.data.tone = player.tone;
        if(player.hasPerk(PerkLib.TitanicSize))
            saveFile.data.tallness = player.tallness / 5;
        else
            saveFile.data.tallness = player.tallness;
		saveFile.data.hairType = player.hairType;
		saveFile.data.hairStyle = player.hairStyle;
		saveFile.data.gillType = player.gills.type;
		saveFile.data.armType = player.arms.type;
		saveFile.data.hairLength = player.hairLength;
		saveFile.data.beardLength = player.beardLength;
		saveFile.data.eyeType = player.eyes.type;
		saveFile.data.eyeColor = player.eyes.colour;
		saveFile.data.skinColor3 = player.skinColor3;
		saveFile.data.beardStyle = player.beardStyle;
		saveFile.data.tongueType = player.tongue.type;
		saveFile.data.earType = player.ears.type;
		saveFile.data.antennae = player.antennae.type;
		saveFile.data.horns = player.horns.count;
		saveFile.data.hornType = player.horns.type;
		saveFile.data.rearBody = player.rearBody.type;
		saveFile.data.bodyMaterials = [];
		for (i = 0; i < player.bodyMaterials.length; i++) {
			saveFile.data.bodyMaterials[i] = player.bodyMaterials[i].saveToObject();
		}
		player.facePart.saveToSaveData(saveFile.data);
		//player.underBody.saveToSaveData(saveFile.data);
		player.lowerBodyPart.saveToSaveData(saveFile.data);
		player.skin.saveToSaveData(saveFile.data);
		player.tail.saveToSaveData(saveFile.data);
		player.clawsPart.saveToSaveData(saveFile.data);
		player.arms.saveToSaveData(saveFile.data);
		saveFile.data.wingDesc = player.wings.desc;
		saveFile.data.wingType = player.wings.type;
		saveFile.data.hipRating = player.hips.type;
		saveFile.data.buttRating = player.butt.type;

		//Sexual Stuff
		saveFile.data.balls = player.balls;
		saveFile.data.cumMultiplier = player.cumMultiplier;
		saveFile.data.ballSize = player.ballSize;
		saveFile.data.hoursSinceCum = player.hoursSinceCum;
		saveFile.data.fertility = player.fertility;

		//Preggo stuff
		saveFile.data.pregnancyIncubation = player.pregnancyIncubation;
		saveFile.data.pregnancyType = player.pregnancyType;
		saveFile.data.pregnancy2Incubation = player.pregnancy2Incubation;
		saveFile.data.pregnancy2Type = player.pregnancy2Type;
		saveFile.data.buttPregnancyIncubation = player.buttPregnancyIncubation;
		saveFile.data.buttPregnancyType = player.buttPregnancyType;

		/*myLocalData.data.furnitureArray = new Array();
		   for (var i:Number = 0; i < GameArray.length; i++) {
		   myLocalData.data.girlArray.push(new Array());
		   myLocalData.data.girlEffectArray.push(new Array());
		 }*/

		saveFile.data.cocks = [];
		saveFile.data.vaginas = [];
		saveFile.data.breastRows = [];
		saveFile.data.perks = [];
		saveFile.data.statusAffects = [];
		saveFile.data.ass = [];
		saveFile.data.keyItems = [];
		saveFile.data.itemStorage = [];
		saveFile.data.pearlStorage = [];
		saveFile.data.gearStorage = [];
		//Set array
		for (i = 0; i < player.cocks.length; i++)
		{
			saveFile.data.cocks.push([]);
		}
		//Populate Array
		for (i = 0; i < player.cocks.length; i++)
		{
			saveFile.data.cocks[i].cockThickness = player.cocks[i].cockThickness;
			saveFile.data.cocks[i].cockLength = player.cocks[i].cockLength;
			saveFile.data.cocks[i].cockType = player.cocks[i].cockType.Index;
			saveFile.data.cocks[i].knotMultiplier = player.cocks[i].knotMultiplier;
			saveFile.data.cocks[i].pierced = player.cocks[i].pierced;
			saveFile.data.cocks[i].pShortDesc = player.cocks[i].pShortDesc;
			saveFile.data.cocks[i].pLongDesc = player.cocks[i].pLongDesc;
			saveFile.data.cocks[i].sock = player.cocks[i].sock;
		}
		//Set Vaginal Array
		for (i = 0; i < player.vaginas.length; i++)
		{
			saveFile.data.vaginas.push([]);
		}
		//Populate Vaginal Array
		for (i = 0; i < player.vaginas.length; i++)
		{
			saveFile.data.vaginas[i].type = player.vaginas[i].type;
			saveFile.data.vaginas[i].vaginalWetness = player.vaginas[i].vaginalWetness;
			saveFile.data.vaginas[i].vaginalLooseness = player.vaginas[i].vaginalLooseness;
			saveFile.data.vaginas[i].fullness = player.vaginas[i].fullness;
			saveFile.data.vaginas[i].virgin = player.vaginas[i].virgin;
			saveFile.data.vaginas[i].labiaPierced = player.vaginas[i].labiaPierced;
			saveFile.data.vaginas[i].labiaPShort = player.vaginas[i].labiaPShort;
			saveFile.data.vaginas[i].labiaPLong = player.vaginas[i].labiaPLong;
			saveFile.data.vaginas[i].clitPierced = player.vaginas[i].clitPierced;
			saveFile.data.vaginas[i].clitPShort = player.vaginas[i].clitPShort;
			saveFile.data.vaginas[i].clitPLong = player.vaginas[i].clitPLong;
			saveFile.data.vaginas[i].clitLength = player.vaginas[i].clitLength;
			saveFile.data.vaginas[i].recoveryProgress = player.vaginas[i].recoveryProgress;
		}
		//NIPPLES
		saveFile.data.nippleLength = player.nippleLength;
		//Set Breast Array
		for (i = 0; i < player.breastRows.length; i++)
		{
			saveFile.data.breastRows.push([]);
				//trace("Saveone breastRow");
		}
		//Populate Breast Array
		for (i = 0; i < player.breastRows.length; i++)
		{
			//trace("Populate One BRow");
			saveFile.data.breastRows[i].breasts = player.breastRows[i].breasts;
			saveFile.data.breastRows[i].breastRating = player.breastRows[i].breastRating;
			saveFile.data.breastRows[i].nipplesPerBreast = player.breastRows[i].nipplesPerBreast;
			saveFile.data.breastRows[i].lactationMultiplier = player.breastRows[i].lactationMultiplier;
			saveFile.data.breastRows[i].milkFullness = player.breastRows[i].milkFullness;
			saveFile.data.breastRows[i].fuckable = player.breastRows[i].fuckable;
			saveFile.data.breastRows[i].fullness = player.breastRows[i].fullness;
		}
		/*
		//removing extra mutations from save
		for each(var mutation:PerkType in IMutationsLib.mutationsArray("")){
			if (player.perkv1(mutation) == 0) player.removePerk(mutation);
		}
		player.removePerk(IMutationsLib.MutationsTemplateIM);
		*/

		//Set Perk Array
		//Populate Perk Array
		player.perks.forEach(function (perk:PerkClass, ...args):void {
			var savePerk: Object = {
				id: perk.ptype.id,
				value1: perk.value1,
				value2: perk.value2,
				value3: perk.value3,
				value4: perk.value4
			};
			saveFile.data.perks.push(savePerk);
		});

		//Populate Status Array
		for each(var statusEffect:StatusEffectClass in player.statusEffects) {
			var saveStatusEffect: Object = {
				statusAffectName: statusEffect.stype.id,
				value1: statusEffect.value1,
				value2: statusEffect.value2,
				value3: statusEffect.value3,
				value4: statusEffect.value4
			};
			saveFile.data.statusAffects.push(saveStatusEffect);
		}
		//Set keyItem Array
		for (i = 0; i < player.keyItems.length; i++)
		{
			saveFile.data.keyItems.push([]);
				//trace("Saveone keyItem");
		}
		//Populate keyItem Array
		for (i = 0; i < player.keyItems.length; i++)
		{
			//trace("Populate One keyItemzzzzzz");
			saveFile.data.keyItems[i].keyName = player.keyItems[i].keyName;
			saveFile.data.keyItems[i].value1 = player.keyItems[i].value1;
			saveFile.data.keyItems[i].value2 = player.keyItems[i].value2;
			saveFile.data.keyItems[i].value3 = player.keyItems[i].value3;
			saveFile.data.keyItems[i].value4 = player.keyItems[i].value4;
		}
		// Potions
		saveFile.data.potions = [];
		for (i = 0; i < player.potions.length; i++) {
			saveFile.data.potions[i] = {};
			saveFile.data.potions[i].id = player.potions[i].type.ID;
			saveFile.data.potions[i].count = player.potions[i].count;
		}
		// Set storage slot array
		for (i = 0; i < itemStorageGet().length; i++)
		{
			saveFile.data.itemStorage.push([]);
		}

		//Populate storage slot array
		for (i = 0; i < itemStorageGet().length; i++)
		{
			//saveFile.data.itemStorage[i].shortName = itemStorage[i].itype.id;// For backward compatibility
			saveFile.data.itemStorage[i].id = (itemStorageGet()[i].itype == null) ? null : itemStorageGet()[i].itype.id;
			saveFile.data.itemStorage[i].quantity = itemStorageGet()[i].quantity;
			saveFile.data.itemStorage[i].unlocked = itemStorageGet()[i].unlocked;
		}
		//Set gear slot array
		for (i = 0; i < gearStorageGet().length; i++)
		{
			saveFile.data.gearStorage.push([]);
		}

		//Populate gear slot array
		for (i = 0; i < gearStorageGet().length; i++)
		{
			//saveFile.data.gearStorage[i].shortName = gearStorage[i].itype.id;// uncomment for backward compatibility
			saveFile.data.gearStorage[i].id = (gearStorageGet()[i].isEmpty()) ? null : gearStorageGet()[i].itype.id;
			saveFile.data.gearStorage[i].quantity = gearStorageGet()[i].quantity;
			saveFile.data.gearStorage[i].unlocked = gearStorageGet()[i].unlocked;
		}

		//Set gear slot array
		for (i = 0; i < pearlStorageGet().length; i++)
		{
			saveFile.data.pearlStorage.push([]);
		}

		//Populate pearl slot array
		for (i = 0; i < pearlStorageGet().length; i++)
		{
			//saveFile.data.pearlStorage[i].shortName = pearlStorage[i].itype.id;// uncomment for backward compatibility
			saveFile.data.pearlStorage[i].id = (pearlStorageGet()[i].isEmpty()) ? null : pearlStorageGet()[i].itype.id;
			saveFile.data.pearlStorage[i].quantity = pearlStorageGet()[i].quantity;
			saveFile.data.pearlStorage[i].unlocked = pearlStorageGet()[i].unlocked;
		}
		saveFile.data.ass.push([]);
		saveFile.data.ass.analWetness = player.ass.analWetness;
		saveFile.data.ass.analLooseness = player.ass.analLooseness;
		saveFile.data.ass.fullness = player.ass.fullness;
		//EXPLORED
		saveFile.data.exploredLake = SceneLib.exploration.counters.lake;
		saveFile.data.exploredMountain = SceneLib.exploration.counters.mountainsMid;
		saveFile.data.exploredForest = SceneLib.exploration.counters.forestOuter+SceneLib.exploration.counters.forestInner;
		saveFile.data.exploredDesert = SceneLib.exploration.counters.desertOuter;
		saveFile.data.explored = SceneLib.exploration.counters.explore;
		saveFile.data.gameState = gameStateGet();

		//Time and Items
		saveFile.data.minutes = model.time.minutes;
		saveFile.data.hours = model.time.hours;
		saveFile.data.days = model.time.days;
		saveFile.data.autoSave = player.autoSave;

		//PLOTZ
        saveFile.data.monk = JojoScene.monk;
        saveFile.data.sand = SandWitchScene.rapedBefore;
        saveFile.data.beeProgress = 0; //Now saved in a flag. getGame().beeProgress;

		saveFile.data.isabellaOffspringData = [];
		for (i = 0; i < SceneLib.isabellaScene.isabellaOffspringData.length; i++) {
			saveFile.data.isabellaOffspringData.push(SceneLib.isabellaScene.isabellaOffspringData[i]);
		}

		//ITEMZ. Item1s
		saveFile.data.itemSlot1 = [];
		saveFile.data.itemSlot1.quantity = player.itemSlot1.quantity;
		saveFile.data.itemSlot1.id = player.itemSlot1.itype.id;
		saveFile.data.itemSlot1.unlocked = true;

		saveFile.data.itemSlot2 = [];
		saveFile.data.itemSlot2.quantity = player.itemSlot2.quantity;
		saveFile.data.itemSlot2.id = player.itemSlot2.itype.id;
		saveFile.data.itemSlot2.unlocked = true;

		saveFile.data.itemSlot3 = [];
		saveFile.data.itemSlot3.quantity = player.itemSlot3.quantity;
		saveFile.data.itemSlot3.id = player.itemSlot3.itype.id;
		saveFile.data.itemSlot3.unlocked = true;

		saveFile.data.itemSlot4 = [];
		saveFile.data.itemSlot4.quantity = player.itemSlot4.quantity;
		saveFile.data.itemSlot4.id = player.itemSlot4.itype.id;
		saveFile.data.itemSlot4.unlocked = true;

		saveFile.data.itemSlot5 = [];
		saveFile.data.itemSlot5.quantity = player.itemSlot5.quantity;
		saveFile.data.itemSlot5.id = player.itemSlot5.itype.id;
		saveFile.data.itemSlot5.unlocked = true;

		saveFile.data.itemSlot6 = [];
		saveFile.data.itemSlot6.quantity = player.itemSlot6.quantity;
		saveFile.data.itemSlot6.id = player.itemSlot6.itype.id;
		saveFile.data.itemSlot6.unlocked = true;

		saveFile.data.itemSlot7 = [];
		saveFile.data.itemSlot7.quantity = player.itemSlot7.quantity;
		saveFile.data.itemSlot7.id = player.itemSlot7.itype.id;
		saveFile.data.itemSlot7.unlocked = player.itemSlot7.unlocked;

		trace("slot 7 is unlocked: "+player.itemSlot7.unlocked);
        trace("slot 7 has item: "+player.itemSlot7.itype.id);
		saveFile.data.itemSlot8 = [];
		saveFile.data.itemSlot8.quantity = player.itemSlot8.quantity;
		saveFile.data.itemSlot8.id = player.itemSlot8.itype.id;
		saveFile.data.itemSlot8.unlocked = player.itemSlot8.unlocked;

		saveFile.data.itemSlot9 = [];
		saveFile.data.itemSlot9.quantity = player.itemSlot9.quantity;
		saveFile.data.itemSlot9.id = player.itemSlot9.itype.id;
		saveFile.data.itemSlot9.unlocked = player.itemSlot9.unlocked;

		saveFile.data.itemSlot10 = [];
		saveFile.data.itemSlot10.quantity = player.itemSlot10.quantity;
		saveFile.data.itemSlot10.id = player.itemSlot10.itype.id;
		saveFile.data.itemSlot10.unlocked = player.itemSlot10.unlocked;

		saveFile.data.itemSlot11 = [];
		saveFile.data.itemSlot11.quantity = player.itemSlot11.quantity;
		saveFile.data.itemSlot11.id = player.itemSlot11.itype.id;
		saveFile.data.itemSlot11.unlocked = player.itemSlot11.unlocked;

		saveFile.data.itemSlot12 = [];
		saveFile.data.itemSlot12.quantity = player.itemSlot12.quantity;
		saveFile.data.itemSlot12.id = player.itemSlot12.itype.id;
		saveFile.data.itemSlot12.unlocked = player.itemSlot12.unlocked;

		saveFile.data.itemSlot13 = [];
		saveFile.data.itemSlot13.quantity = player.itemSlot13.quantity;
		saveFile.data.itemSlot13.id = player.itemSlot13.itype.id;
		saveFile.data.itemSlot13.unlocked = player.itemSlot13.unlocked;

		saveFile.data.itemSlot14 = [];
		saveFile.data.itemSlot14.quantity = player.itemSlot14.quantity;
		saveFile.data.itemSlot14.id = player.itemSlot14.itype.id;
		saveFile.data.itemSlot14.unlocked = player.itemSlot14.unlocked;

		saveFile.data.itemSlot15 = [];
		saveFile.data.itemSlot15.quantity = player.itemSlot15.quantity;
		saveFile.data.itemSlot15.id = player.itemSlot15.itype.id;
		saveFile.data.itemSlot15.unlocked = player.itemSlot15.unlocked;

		saveFile.data.itemSlot16 = [];
		saveFile.data.itemSlot16.quantity = player.itemSlot16.quantity;
		saveFile.data.itemSlot16.id = player.itemSlot16.itype.id;
		saveFile.data.itemSlot16.unlocked = player.itemSlot16.unlocked;

		saveFile.data.itemSlot17 = [];
		saveFile.data.itemSlot17.quantity = player.itemSlot17.quantity;
		saveFile.data.itemSlot17.id = player.itemSlot17.itype.id;
		saveFile.data.itemSlot17.unlocked = player.itemSlot17.unlocked;

		saveFile.data.itemSlot18 = [];
		saveFile.data.itemSlot18.quantity = player.itemSlot18.quantity;
		saveFile.data.itemSlot18.id = player.itemSlot18.itype.id;
		saveFile.data.itemSlot18.unlocked = player.itemSlot18.unlocked;

		saveFile.data.itemSlot19 = [];
		saveFile.data.itemSlot19.quantity = player.itemSlot19.quantity;
		saveFile.data.itemSlot19.id = player.itemSlot19.itype.id;
		saveFile.data.itemSlot19.unlocked = player.itemSlot19.unlocked;

		saveFile.data.itemSlot20 = [];
		saveFile.data.itemSlot20.quantity = player.itemSlot20.quantity;
		saveFile.data.itemSlot20.id = player.itemSlot20.itype.id;
		saveFile.data.itemSlot20.unlocked = player.itemSlot20.unlocked;

		saveFile.data.itemSlot21 = [];
		saveFile.data.itemSlot21.quantity = player.itemSlot21.quantity;
		saveFile.data.itemSlot21.id = player.itemSlot21.itype.id;
		saveFile.data.itemSlot21.unlocked = player.itemSlot21.unlocked;

		saveFile.data.itemSlot22 = [];
		saveFile.data.itemSlot22.quantity = player.itemSlot22.quantity;
		saveFile.data.itemSlot22.id = player.itemSlot22.itype.id;
		saveFile.data.itemSlot22.unlocked = player.itemSlot22.unlocked;

		saveFile.data.itemSlot23 = [];
		saveFile.data.itemSlot23.quantity = player.itemSlot23.quantity;
		saveFile.data.itemSlot23.id = player.itemSlot23.itype.id;
		saveFile.data.itemSlot23.unlocked = player.itemSlot23.unlocked;

		saveFile.data.itemSlot24 = [];
		saveFile.data.itemSlot24.quantity = player.itemSlot24.quantity;
		saveFile.data.itemSlot24.id = player.itemSlot24.itype.id;
		saveFile.data.itemSlot24.unlocked = player.itemSlot24.unlocked;

		saveFile.data.itemSlot25 = [];
		saveFile.data.itemSlot25.quantity = player.itemSlot25.quantity;
		saveFile.data.itemSlot25.id = player.itemSlot25.itype.id;
		saveFile.data.itemSlot25.unlocked = player.itemSlot25.unlocked;

		saveFile.data.itemSlot26 = [];
		saveFile.data.itemSlot26.quantity = player.itemSlot26.quantity;
		saveFile.data.itemSlot26.id = player.itemSlot26.itype.id;
		saveFile.data.itemSlot26.unlocked = player.itemSlot26.unlocked;

		saveFile.data.itemSlot27 = [];
		saveFile.data.itemSlot27.quantity = player.itemSlot27.quantity;
		saveFile.data.itemSlot27.id = player.itemSlot27.itype.id;
		saveFile.data.itemSlot27.unlocked = player.itemSlot27.unlocked;

		saveFile.data.itemSlot28 = [];
		saveFile.data.itemSlot28.quantity = player.itemSlot28.quantity;
		saveFile.data.itemSlot28.id = player.itemSlot28.itype.id;
		saveFile.data.itemSlot28.unlocked = player.itemSlot28.unlocked;

		saveFile.data.itemSlot29 = [];
		saveFile.data.itemSlot29.quantity = player.itemSlot29.quantity;
		saveFile.data.itemSlot29.id = player.itemSlot29.itype.id;
		saveFile.data.itemSlot29.unlocked = player.itemSlot29.unlocked;

		saveFile.data.itemSlot30 = [];
		saveFile.data.itemSlot30.quantity = player.itemSlot30.quantity;
		saveFile.data.itemSlot30.id = player.itemSlot30.itype.id;
		saveFile.data.itemSlot30.unlocked = player.itemSlot30.unlocked;

		saveFile.data.itemSlot31 = [];
		saveFile.data.itemSlot31.quantity = player.itemSlot31.quantity;
		saveFile.data.itemSlot31.id = player.itemSlot31.itype.id;
		saveFile.data.itemSlot31.unlocked = player.itemSlot31.unlocked;

		saveFile.data.itemSlot32 = [];
		saveFile.data.itemSlot32.quantity = player.itemSlot32.quantity;
		saveFile.data.itemSlot32.id = player.itemSlot32.itype.id;
		saveFile.data.itemSlot32.unlocked = player.itemSlot32.unlocked;

		saveFile.data.itemSlot33 = [];
		saveFile.data.itemSlot33.quantity = player.itemSlot33.quantity;
		saveFile.data.itemSlot33.id = player.itemSlot33.itype.id;
		saveFile.data.itemSlot33.unlocked = player.itemSlot33.unlocked;

		saveFile.data.itemSlot34 = [];
		saveFile.data.itemSlot34.quantity = player.itemSlot34.quantity;
		saveFile.data.itemSlot34.id = player.itemSlot34.itype.id;
		saveFile.data.itemSlot34.unlocked = player.itemSlot34.unlocked;

		saveFile.data.itemSlot35 = [];
		saveFile.data.itemSlot35.quantity = player.itemSlot35.quantity;
		saveFile.data.itemSlot35.id = player.itemSlot35.itype.id;
		saveFile.data.itemSlot35.unlocked = player.itemSlot35.unlocked;

		saveFile.data.itemSlot36 = [];
		saveFile.data.itemSlot36.quantity = player.itemSlot36.quantity;
		saveFile.data.itemSlot36.id = player.itemSlot36.itype.id;
		saveFile.data.itemSlot36.unlocked = player.itemSlot36.unlocked;

		saveFile.data.itemSlot37 = [];
		saveFile.data.itemSlot37.quantity = player.itemSlot37.quantity;
		saveFile.data.itemSlot37.id = player.itemSlot37.itype.id;
		saveFile.data.itemSlot37.unlocked = player.itemSlot37.unlocked;

		saveFile.data.itemSlot38 = [];
		saveFile.data.itemSlot38.quantity = player.itemSlot38.quantity;
		saveFile.data.itemSlot38.id = player.itemSlot38.itype.id;
		saveFile.data.itemSlot38.unlocked = player.itemSlot38.unlocked;

		saveFile.data.itemSlot39 = [];
		saveFile.data.itemSlot39.quantity = player.itemSlot39.quantity;
		saveFile.data.itemSlot39.id = player.itemSlot39.itype.id;
		saveFile.data.itemSlot39.unlocked = player.itemSlot39.unlocked;

		saveFile.data.itemSlot40 = [];
		saveFile.data.itemSlot40.quantity = player.itemSlot40.quantity;
		saveFile.data.itemSlot40.id = player.itemSlot40.itype.id;
		saveFile.data.itemSlot40.unlocked = player.itemSlot40.unlocked;

		saveFile.data.itemSlot41 = [];
		saveFile.data.itemSlot41.quantity = player.itemSlot41.quantity;
		saveFile.data.itemSlot41.id = player.itemSlot41.itype.id;
		saveFile.data.itemSlot41.unlocked = player.itemSlot41.unlocked;

		saveFile.data.itemSlot42 = [];
		saveFile.data.itemSlot42.quantity = player.itemSlot42.quantity;
		saveFile.data.itemSlot42.id = player.itemSlot42.itype.id;
		saveFile.data.itemSlot42.unlocked = player.itemSlot42.unlocked;

		saveFile.data.itemSlot43 = [];
		saveFile.data.itemSlot43.quantity = player.itemSlot43.quantity;
		saveFile.data.itemSlot43.id = player.itemSlot43.itype.id;
		saveFile.data.itemSlot43.unlocked = player.itemSlot43.unlocked;

		saveFile.data.itemSlot44 = [];
		saveFile.data.itemSlot44.quantity = player.itemSlot44.quantity;
		saveFile.data.itemSlot44.id = player.itemSlot44.itype.id;
		saveFile.data.itemSlot44.unlocked = player.itemSlot44.unlocked;

		saveFile.data.itemSlot45 = [];
		saveFile.data.itemSlot45.quantity = player.itemSlot45.quantity;
		saveFile.data.itemSlot45.id = player.itemSlot45.itype.id;
		saveFile.data.itemSlot45.unlocked = player.itemSlot45.unlocked;

		saveFile.data.itemSlot46 = [];
		saveFile.data.itemSlot46.quantity = player.itemSlot46.quantity;
		saveFile.data.itemSlot46.id = player.itemSlot46.itype.id;
		saveFile.data.itemSlot46.unlocked = player.itemSlot46.unlocked;

		saveFile.data.itemSlot47 = [];
		saveFile.data.itemSlot47.quantity = player.itemSlot47.quantity;
		saveFile.data.itemSlot47.id = player.itemSlot47.itype.id;
		saveFile.data.itemSlot47.unlocked = player.itemSlot47.unlocked;

		saveFile.data.itemSlot48 = [];
		saveFile.data.itemSlot48.quantity = player.itemSlot48.quantity;
		saveFile.data.itemSlot48.id = player.itemSlot48.itype.id;
		saveFile.data.itemSlot48.unlocked = player.itemSlot48.unlocked;

		saveFile.data.itemSlot49 = [];
		saveFile.data.itemSlot49.quantity = player.itemSlot49.quantity;
		saveFile.data.itemSlot49.id = player.itemSlot49.itype.id;
		saveFile.data.itemSlot49.unlocked = player.itemSlot49.unlocked;

		saveFile.data.itemSlot50 = [];
		saveFile.data.itemSlot50.quantity = player.itemSlot50.quantity;
		saveFile.data.itemSlot50.id = player.itemSlot50.itype.id;
		saveFile.data.itemSlot50.unlocked = player.itemSlot50.unlocked;


		// Keybinds
        saveFile.data.controls = CoC.instance.inputManager.SaveBindsToObj();
		saveFile.data.world = [];
		saveFile.data.world.x = [];
		for each(var npc:XXCNPC in XXCNPC.SavedNPCs){
			npc.save(saveFile.data.world.x);
		}
	}
	catch (error:Error)
	{
		processingError = true;
		dataError = error;
		trace(error.message);
	}


	trace("done saving");
	// Because actionscript is stupid, there is no easy way to block until file operations are done.
	// Therefore, I'm hacking around it for the chaos monkey.
	// Really, something needs to listen for the FileReference.complete event, and re-enable saving/loading then.
	// Something to do in the future
	if (isFile && !processingError)
	{
		if (!(CoC.instance.monkey.run))
		{
			//outputText(serializeToString(saveFile.data), true);
			var bytes:ByteArray = new ByteArray();
			bytes.writeObject(saveFile);
			CONFIG::AIR
			{
				// saved filename: "name of character".coc
				var airSaveDir:File = File.documentsDirectory.resolvePath(savedGameDir);
				var airFile:File = airSaveDir.resolvePath(player.short + ".coc");
				var stream:FileStream = new FileStream();
				try
				{
					airSaveDir.createDirectory();
					stream.open(airFile, FileMode.WRITE);
					stream.writeBytes(bytes);
					stream.close();
					clearOutput();
					outputText("Saved to file: " + airFile.url);
					doNext(playerMenu);
				}
				catch (error:Error)
				{
					backupAborted = true;
					clearOutput();
					outputText("Failed to write to file: " + airFile.url + " (" + error.message + ") Go to application and change CoC permission to allow storage of data");
					doNext(playerMenu);
				}
			}
			CONFIG::STANDALONE
			{
				file = new FileReference();
				file.save(bytes, null);
				clearOutput();
				outputText("Attempted to save to file.");
			}
		}
	}
	else if (!processingError)
	{
		// Write the file
		saveFile.flush();

		// Reload it
		saveFile = SharedObject.getLocal(slot, "/");
		backup = SharedObject.getLocal(slot + "_backup", "/");
		var numProps:int = 0;

		// Copy the properties over to a new file object
		for (var prop:String in saveFile.data)
		{
			numProps++;
			backup.data[prop] = saveFile.data[prop];
		}

		// There should be 124 root properties minimum in the save file. Give some wiggleroom for things that might be omitted? (All of the broken saves I've seen are MUCH shorter than expected)
		if (numProps < versionProperties[ver])
		{
			clearOutput();
			outputText("<b>Aborting save.  Your current save file is broken, and needs to be bug-reported.</b>\n\nWithin the save folder for CoC, there should be a pair of files named \"" + slot + ".sol\" and \"" + slot + "_backup.sol\"\n\n<b>We need BOTH of those files, and a quick report of what you've done in the game between when you last saved, and this message.</b>\n\n");
			outputText("When you've sent us the files, you can copy the _backup file over your old save to continue from your last save.\n\n");
			outputText("Alternatively, you can just hit the restore button to overwrite the broken save with the backup... but we'd really like the saves first!");
			trace("Backup Save Aborted! Broken save detected!");
			backupAborted = true;
		}
		else
		{
			// Property count is correct, write the backup
			backup.flush();
		}

		if (!backupAborted) {
			clearOutput();
			outputText("Saved to slot" + slot + "!");
		}
	}
	else
	{
		outputText("There was a processing error during saving. Please report the following message:\n\n");
		outputText(dataError.message);
		outputText("\n\n");
		outputText(dataError.getStackTrace());
	}

	if (!backupAborted)
	{
		doNext(playerMenu);
	}
	else
	{
		menu();
		addButton(0, "Next", playerMenu);
		addButton(9, "Restore", restore, slot);
	}

}

public function restore(slotName:String):void
{
	clearOutput();
	// copy slot_backup.sol over slot.sol
	var backupFile:SharedObject = SharedObject.getLocal(slotName + "_backup", "/");
	var overwriteFile:SharedObject = SharedObject.getLocal(slotName, "/");

	for (var prop:String in backupFile.data)
	{
		overwriteFile.data[prop] = backupFile.data[prop];
	}

	overwriteFile.flush();

	clearOutput();
	outputText("Restored backup of " + slotName);
	menu();
	doNext(playerMenu);
}

public function openSave():void
{

	// Block when running the chaos monkey
	if (!(CoC.instance.monkey.run))
	{
		CONFIG::AIR
		{
			loadScreenAIR();
		}
		CONFIG::STANDALONE
		{
			file = new FileReference();
			file.addEventListener(Event.SELECT, onFileSelected);
			file.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			file.browse();
		}
		//var fileObj : Object = readObjectFromStringBytes("");
		//loadGameFile(fileObj);
	}
}


public function onFileSelected(evt:Event):void
{
	CONFIG::AIR
	{
		airFile.addEventListener(Event.COMPLETE, onFileLoaded);
		airFile.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
		airFile.load();
	}
	CONFIG::STANDALONE
	{
		file.addEventListener(Event.COMPLETE, onFileLoaded);
		file.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
		file.load();
	}
}

public function onFileLoaded(evt:Event):void
{
	var tempFileRef:FileReference = FileReference(evt.target);
	trace("File target = ", evt.target);
	loader = new URLLoader();
	loader.dataFormat = URLLoaderDataFormat.BINARY;
	loader.addEventListener(Event.COMPLETE, onDataLoaded);
	loader.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
	try
	{
		var req:* = new URLRequest(tempFileRef.name);
		loader.load(req);
	}
	catch (error:Error)
	{
		clearOutput();
		outputText("<b>!</b> Save file not found, check that it is in the same directory as the CoC.swf file.\n\nLoad from file is not available when playing directly from a website like furaffinity or fenoxo.com.");
	}
}

public function ioErrorHandler(e:IOErrorEvent):void
{
	clearOutput();
	outputText("<b>!</b> Save file not found, check that it is in the same directory as the CoC_" + ver + ".swf file.\r\rLoad from file is not available when playing directly from a website like furaffinity or fenoxo.com.");
	doNext(returnToSaveMenu);
}

private function returnToSaveMenu():void {
	var f:MouseEvent;
	saveLoad(f);
}

public function onDataLoaded(evt:Event):void
{
	//var fileObj = readObjectFromStringBytes(loader.data);
	try {
		// I want to be able to write some debug stuff to the GUI during the loading process
		// Therefore, we clear the display *before* calling loadGameObject
		clearOutput();
		outputText("Loading save...");
		trace("OnDataLoaded! - Reading data", loader, loader.data.readObject);
		var tmpObj:Object = loader.data.readObject();
		trace("Read in object = ", tmpObj);

		CONFIG::debug
		{
			if (tmpObj == null) {
				throw new Error("Bad Save load?"); // Re throw error in debug mode.
			}
		}
		loadGameObject(tmpObj);
		outputText("Loaded Save");
		statScreenRefresh();
	}
	catch (rangeError:RangeError)
	{
		clearOutput();
		outputText("<b>!</b> File is either corrupted or not a valid save");
		doNext(returnToSaveMenu);
	}
	catch (error:Error)
	{
		clearOutput();
		outputText("<b>!</b> Unhandled Exception");
		outputText("[pg]Failed to load save. The file may be corrupt!");

		doNext(returnToSaveMenu);
	}
	//playerMenu();
}

/**
 * Upgrade loaded saveFile.data object to most recent version
 * so the loadGameObject can proceed without hacks
 */
private function unFuckSaveDataBeforeLoading(data:Object):void {
	if (data.tail === undefined) {
		var venomAsCount:Boolean = data.tailType == Tail.FOX;
		data.tail = {
			type    : data.tailType,
			venom   : venomAsCount ? 0 : data.tailVenum,
			recharge: data.tailRecharge,
			count   : (data.tailType == 0) ? 0 : venomAsCount ? data.tailVenum : 1
		}
	}
}
public function loadGameObject(saveData:Object, slot:String = "VOID"):void
{
    var game:CoC = CoC.instance;
	var spillyFix:Boolean = false;
	game.isLoadingSave = true;
	inDungeon = false;
	inRoomedDungeon = false;
	inRoomedDungeonResume = null;

	//Autosave stuff
	if(player){
        player.slotName = slot;
	}
	trace("Loading save!");

	var saveFile:* = saveData;
	var data:Object = saveFile.data;
	if (saveFile.data.exists)
	{

		//KILL ALL COCKS;
		player = new Player();
		game.flags = new DefaultDict();
		model.player = player;

		//trace("Type of saveFile.data = ", getClass(saveFile.data));

		inventory.clearStorage();
		inventory.clearPearlStorage();
		inventory.clearGearStorage();
		player.short = saveFile.data.short;
		player.a = saveFile.data.a;
		notes = saveFile.data.notes;

		//flags
		for (var i:int = 0; i < flags.length; i++)
		{
			if (saveFile.data.flags[i] != undefined)
				flags[i] = saveFile.data.flags[i];
		}
		if (saveFile.data.versionID != undefined) {
			game.versionID = saveFile.data.versionID;
			trace("Found internal versionID:", game.versionID);
		}
		unFuckSaveDataBeforeLoading(saveFile.data);
		//PIERCINGS

		//trace("LOADING PIERCINGS");
		player.nipplesPierced = saveFile.data.nipplesPierced;
		player.nipplesPShort = saveFile.data.nipplesPShort;
		player.nipplesPLong = saveFile.data.nipplesPLong;
		player.lipPierced = saveFile.data.lipPierced;
		player.lipPShort = saveFile.data.lipPShort;
		player.lipPLong = saveFile.data.lipPLong;
		player.tonguePierced = saveFile.data.tonguePierced;
		player.tonguePShort = saveFile.data.tonguePShort;
		player.tonguePLong = saveFile.data.tonguePLong;
		player.eyebrowPierced = saveFile.data.eyebrowPierced;
		player.eyebrowPShort = saveFile.data.eyebrowPShort;
		player.eyebrowPLong = saveFile.data.eyebrowPLong;
		player.earsPierced = saveFile.data.earsPierced;
		player.earsPShort = saveFile.data.earsPShort;
		player.earsPLong = saveFile.data.earsPLong;
		player.nosePierced = saveFile.data.nosePierced;
		player.nosePShort = saveFile.data.nosePShort;
		player.nosePLong = saveFile.data.nosePLong;
		if (saveFile.data.level > CoC.instance.levelCap) { //vanilla import with op levels
			player.level = CoC.instance.levelCap;
			spillyFix = true;
		} else player.level = saveFile.data.level;
		if (saveFile.data.negativeLevel == undefined) {
			player.negativeLevel = 0; // TODO: (lvl) handle save upgrading for old clone buff v3/v4 in save updater?
		} else {
			player.negativeLevel = saveFile.data.negativeLevel;
		}

		if (saveFile.data.statPoints == undefined)
			player.statPoints = 0;
		else if (spillyFix) player.statPoints = 0; //because I can
		else player.statPoints = saveFile.data.statPoints;

		if (data.stats) {
			player.statStore.forEachStat(function(stat:IStat):void {
				if (stat is BuffableStat) {
					(stat as BuffableStat).removeAllBuffs();
				}
			});
			for (var k:String in data.stats) {
				var statdata:* = data.stats[k];
				var stat:IStat = player.statStore.findStat(k);
				if (stat && stat is Jsonable) {
					(stat as Jsonable).loadFromObject(statdata, false);
				}
			}
		} else {
			// we load old save, compensate stat points
			player.statPoints = player.level*5;
		}

		//MAIN STATS

		player.cor = saveFile.data.cor;
		player.fatigue = saveFile.data.fatigue;
		player.mana = saveFile.data.mana;
		player.soulforce = saveFile.data.soulforce;
		player.wrath = saveFile.data.wrath;

		//Combat STATS
		player.HP = saveFile.data.HP;
		player.lust = saveFile.data.lust;
		if (saveFile.data.teaseXP == undefined)
			player.teaseXP = 0;
		else
			player.teaseXP = saveFile.data.teaseXP;
		if (saveFile.data.teaseLevel == undefined)
			player.teaseLevel = 0;
		else
			player.teaseLevel = saveFile.data.teaseLevel;
/*
       09 {combat: "Whip", 		level:0, experience:0, melee: true, desc:"<b>Dao of Whip</b>"},
       10 {combat: "Exotic", 		level:0, experience:0, melee: true, desc:"<b>Dao of Exotic</b>"},
       11 {combat: "Archery", 	level:0, experience:0, melee: false, desc:"\n<b>Dao of Archery</b>"},
       12 {combat: "Throwing", 	level:0, experience:0, melee: false, desc:"<b>Dao of Throwing Weapons</b>"},
       13 {combat: "Firearms", 	level:0, experience:0, melee: false, desc:"<b>Dao of Firearms</b>"},
       14 {combat: "DualSmall", 	level:0, experience:0, melee: true, desc:"\n<b>Dual Wield Mastery - Small</b>"},
       15 {combat: "DualNormal", 	level:0, experience:0, melee: true, desc:"<b>Dual Wield Mastery - Normal</b>"},
       16 {combat: "DualLarge", 	level:0, experience:0, melee: true, desc:"<b>Dual Wield Mastery - Large</b>"},
       17 {combat: "DualFirearm", level:0, experience:0, melee: false, desc:"<b>Dual Wield Mastery - Firearms</b>"},
       18 {combat: "Small", 		level:0, experience:0, melee: true, desc:"\n<b>Weapon Mastery - Small</b>"},
       19 {combat: "Normal", 		level:0, experience:0, melee: true, desc:"<b>Weapon Mastery - Normal</b>"},
       20 {combat: "Large", 		level:0, experience:0, melee: true, desc:"<b>Weapon Mastery - Large</b>"},
       21 {combat: "Range", 		level:0, experience:0, melee: false, desc:"<b>Weapon Mastery - Ranged</b>"}
*/
        //Mastery
    	if(saveFile.data.combatMastery != undefined)
        	player.loadCombatMastery(saveFile.data.combatMastery);
        else {
            if (saveFile.data.masteryFeralCombatXP != undefined) player.combatMastery[0].experience = saveFile.data.masteryFeralCombatXP;
            if (saveFile.data.masteryFeralCombatLevel != undefined) player.combatMastery[0].level = saveFile.data.masteryFeralCombatLevel;
            if (saveFile.data.masteryGauntletXP != undefined) player.combatMastery[1].experience = saveFile.data.masteryGauntletXP;
            if (saveFile.data.masteryGauntletLevel != undefined) player.combatMastery[1].level = saveFile.data.masteryGauntletLevel;
            if (saveFile.data.masteryDaggerXP != undefined) player.combatMastery[2].experience = saveFile.data.masteryDaggerXP;
            if (saveFile.data.masteryDaggerLevel != undefined) player.combatMastery[2].level = saveFile.data.masteryDaggerLevel;
            if (saveFile.data.masterySwordXP != undefined) player.combatMastery[3].experience = saveFile.data.masterySwordXP;
            if (saveFile.data.masterySwordLevel != undefined) player.combatMastery[3].level = saveFile.data.masterySwordLevel;
            if (saveFile.data.masteryAxeXP != undefined) player.combatMastery[4].experience = saveFile.data.masteryAxeXP;
            if (saveFile.data.masteryAxeLevel != undefined) player.combatMastery[4].level = saveFile.data.masteryAxeLevel;
            if (saveFile.data.masteryMaceHammerXP != undefined) player.combatMastery[5].experience = saveFile.data.masteryMaceHammerXP;
            if (saveFile.data.masteryMaceHammerLevel != undefined) player.combatMastery[5].level = saveFile.data.masteryMaceHammerLevel;
            if (saveFile.data.masteryDuelingSwordXP != undefined) player.combatMastery[6].experience = saveFile.data.masteryDuelingSwordXP;
            if (saveFile.data.masteryDuelingSwordLevel != undefined) player.combatMastery[6].level = saveFile.data.masteryDuelingSwordLevel;
            if (saveFile.data.masteryPolearmXP != undefined) player.combatMastery[7].experience = saveFile.data.masteryPolearmXP;
            if (saveFile.data.masteryPolearmLevel != undefined) player.combatMastery[7].level = saveFile.data.masteryPolearmLevel;
            if (saveFile.data.masterySpearXP != undefined) player.combatMastery[8].experience = saveFile.data.masterySpearXP;
            if (saveFile.data.masterySpearLevel != undefined) player.combatMastery[8].level = saveFile.data.masterySpearLevel;
            if (saveFile.data.masteryWhipXP != undefined) player.combatMastery[9].experience = saveFile.data.masteryWhipXP;
            if (saveFile.data.masteryWhipLevel != undefined) player.combatMastery[9].level = saveFile.data.masteryWhipLevel;
            if (saveFile.data.masteryExoticXP != undefined) player.combatMastery[10].experience = saveFile.data.masteryExoticXP;
            if (saveFile.data.masteryExoticLevel != undefined) player.combatMastery[10].level = saveFile.data.masteryExoticLevel;
            if (saveFile.data.masteryArcheryXP != undefined) player.combatMastery[11].experience = saveFile.data.masteryArcheryXP;
            if (saveFile.data.masteryArcheryLevel != undefined) player.combatMastery[11].level = saveFile.data.masteryArcheryLevel;
            if (saveFile.data.masteryThrowingXP != undefined) player.combatMastery[12].experience = saveFile.data.masteryThrowingXP;
            if (saveFile.data.masteryThrowingLevel != undefined) player.combatMastery[12].level = saveFile.data.masteryThrowingLevel;
            if (saveFile.data.masteryFirearmsXP != undefined) player.combatMastery[13].experience = saveFile.data.masteryFirearmsXP;
            if (saveFile.data.masteryFirearmsLevel != undefined) player.combatMastery[13].level = saveFile.data.masteryFirearmsLevel;
            if (saveFile.data.dualWSXP != undefined) player.combatMastery[14].experience = saveFile.data.dualWSXP;
            if (saveFile.data.dualWSLevel != undefined) player.combatMastery[14].level = saveFile.data.dualWSLevel;
            if (saveFile.data.dualWNXP != undefined) player.combatMastery[15].experience = saveFile.data.dualWNXP;
            if (saveFile.data.dualWNLevel != undefined) player.combatMastery[15].level = saveFile.data.dualWNLevel;
            if (saveFile.data.dualWLXP != undefined) player.combatMastery[16].experience = saveFile.data.dualWLXP;
            if (saveFile.data.dualWLLevel != undefined) player.combatMastery[16].level = saveFile.data.dualWLLevel;
            if (saveFile.data.dualWFXP != undefined) player.combatMastery[17].experience = saveFile.data.dualWFXP;
            if (saveFile.data.dualWFLevel != undefined) player.combatMastery[17].level = saveFile.data.dualWFLevel;
        }

		//Mining
		if (saveFile.data.miningXP == undefined)
			player.miningXP = 0;
		else
			player.miningXP = saveFile.data.miningXP;
		if (saveFile.data.miningLevel == undefined)
			player.miningLevel = 0;
		else
			player.miningLevel = saveFile.data.miningLevel;
		//Farming
		if (saveFile.data.farmingXP == undefined)
			player.farmingXP = 0;
		else
			player.farmingXP = saveFile.data.farmingXP;
		if (saveFile.data.farmingLevel == undefined)
			player.farmingLevel = 0;
		else
			player.farmingLevel = saveFile.data.farmingLevel;
		//Herbalism
		if (saveFile.data.herbalismXP == undefined)
			player.herbalismXP = 0;
		else
			player.herbalismXP = saveFile.data.herbalismXP;
		if (saveFile.data.herbalismLevel == undefined)
			player.herbalismLevel = 0;
		else
			player.herbalismLevel = saveFile.data.herbalismLevel;
		//Hunger
		if (saveFile.data.hunger == undefined)
			player.hunger = 50;
		else
			player.hunger = saveFile.data.hunger;
		//LEVEL STATS
		player.XP = saveFile.data.XP;
		player.gems = saveFile.data.gems || 0;
		if (saveFile.data.perkPoints == undefined)
			player.perkPoints = 0;
		else if (spillyFix) player.perkPoints = player.level - saveFile.data.perks.length;
		else player.perkPoints = saveFile.data.perkPoints;

		if (saveFile.data.superPerkPoints == undefined)
			player.superPerkPoints = 0;
		else
			player.superPerkPoints = saveFile.data.superPerkPoints;

		if (saveFile.data.ascensionPerkPoints == undefined)
			player.ascensionPerkPoints = 0;
		else
			player.ascensionPerkPoints = saveFile.data.ascensionPerkPoints;

		//Appearance
		if (saveFile.data.startingRace != undefined)
			player.startingRace = saveFile.data.startingRace;
		if (saveFile.data.femininity == undefined)
			player.femininity = 50;
		else
			player.femininity = saveFile.data.femininity;
		//EYES
		if (saveFile.data.eyeType == undefined)
			player.eyes.type = Eyes.HUMAN;
		else
			player.eyes.type = saveFile.data.eyeType;
		if (saveFile.data.eyeColor == undefined)
			CoC.instance.transformations.EyesChangeColor(["brown"]).applyEffect(false);
		else
			CoC.instance.transformations.EyesChangeColor([saveFile.data.eyeColor]).applyEffect(false);
		if (saveFile.data.skinColor3 == undefined)
			player.skinColor3 = "black";
		else
			player.skinColor3 = saveFile.data.skinColor3;
		//BEARS
		if (saveFile.data.beardLength == undefined)
			player.beardLength = 0;
		else
			player.beardLength = saveFile.data.beardLength;
		if (saveFile.data.beardStyle == undefined)
			player.beardStyle = 0;
		else
			player.beardStyle = saveFile.data.beardStyle;
		//BODY STYLE
		if (saveFile.data.tone == undefined)
			player.tone = 50;
		else
			player.tone = saveFile.data.tone;
		if (saveFile.data.thickness == undefined)
			player.thickness = 50;
		else
			player.thickness = saveFile.data.thickness;


            player.tallness = saveFile.data.tallness;
		if (saveFile.data.hairType == undefined)
			player.hairType = Hair.NORMAL;
		else
			player.hairType = saveFile.data.hairType;
		if (saveFile.data.hairStyle == undefined)
			player.hairStyle = 0;
		else
			player.hairStyle = saveFile.data.hairStyle;
		if (saveFile.data.gillType != undefined)
			player.gills.type = saveFile.data.gillType;
		else if (saveFile.data.gills == undefined)
			player.gills.type = Gills.NONE;
		else
			player.gills.type = saveFile.data.gills ? Gills.ANEMONE : Gills.NONE;
		player.hairLength = saveFile.data.hairLength;
		player.lowerBodyPart.loadFromSaveData(data);
		player.arms.loadFromSaveData(data);
		player.wings.loadFromSaveData(data);
		player.skin.loadFromSaveData(data);
		player.clawsPart.loadFromSaveData(data);
		player.facePart.loadFromSaveData(data);
		player.tail.loadFromSaveData(data);
		if (data.bodyMaterials == undefined) {
			player.hairColor = data.hairColor;
			if (data.skin && data.skin.base && data.skin.coat) {
				player.furColor        = player.hairColor;
				player.skin.base.color = data.skin.base.color;
				player.skin.coat.color = data.skin.coat.color;
			} else {
				player.skinColor = stringOr(data.skinTone, player.skinColor);
				player.furColor  = stringOr(data.furColor, player.furColor);
				player.chitinColor       = stringOr(data.chitinColor, player.chitinColor);
				player.scaleColor        = stringOr(data.scalesColor, player.scaleColor);
			}
			
		} else {
			for (i = 0; i < player.bodyMaterials.length; i++) {
				if (data.bodyMaterials[i]) {
					player.bodyMaterials[i].loadFromObject(data.bodyMaterials[i], false);
				}
			}
		}
		
		if (saveFile.data.tongueType == undefined)
			player.tongue.type = Tongue.HUMAN;
		else
			player.tongue.type = saveFile.data.tongueType;
		if (saveFile.data.earType == undefined)
			player.ears.type = Ears.HUMAN;
		else
			player.ears.type = saveFile.data.earType;
		if (saveFile.data.antennae == undefined)
			player.antennae.type = Antennae.NONE;
		else
			player.antennae.type = saveFile.data.antennae;
		player.horns.count = saveFile.data.horns;
		if (saveFile.data.hornType == undefined)
			player.horns.type = Horns.NONE;
		else
			player.horns.type = saveFile.data.hornType;

		// <mod name="Dragon patch" author="Stadler76">
		if (saveFile.data.rearBodyType != undefined)
			saveFile.data.rearBody = saveFile.data.rearBodyType;
		player.rearBody.type = (saveFile.data.rearBody == undefined) ? RearBody.NONE : saveFile.data.rearBody;

		player.wings.desc = saveFile.data.wingDesc;
		player.wings.type = saveFile.data.wingType;
		player.hips.type = saveFile.data.hipRating;
		player.butt.type = saveFile.data.buttRating;

		//Sexual Stuff
		player.balls = saveFile.data.balls;
		player.cumMultiplier = saveFile.data.cumMultiplier;
		player.ballSize = saveFile.data.ballSize;
		player.hoursSinceCum = saveFile.data.hoursSinceCum;
		player.fertility = saveFile.data.fertility;

		//Preggo stuff
		player.knockUpForce(saveFile.data.pregnancyType, saveFile.data.pregnancyIncubation);
		player.knockUpForce(saveFile.data.pregnancy2Type, saveFile.data.pregnancy2Incubation, 1);
		player.buttKnockUpForce(saveFile.data.buttPregnancyType, saveFile.data.buttPregnancyIncubation);

		var hasViridianCockSock:Boolean = false;

		//ARRAYS HERE!
		//Set Cock array
		for (i = 0; i < saveFile.data.cocks.length; i++)
		{
			player.createCock();
		}
		//Populate Cock Array
		for (i = 0; i < saveFile.data.cocks.length; i++)
		{
			player.cocks[i].cockThickness = saveFile.data.cocks[i].cockThickness;
			player.cocks[i].cockLength = saveFile.data.cocks[i].cockLength;
			player.cocks[i].cockType = CockTypesEnum.ParseConstantByIndex(saveFile.data.cocks[i].cockType);
			player.cocks[i].knotMultiplier = saveFile.data.cocks[i].knotMultiplier;
			if (saveFile.data.cocks[i].sock == undefined)
				player.cocks[i].sock = "";
			else
			{
				player.cocks[i].sock = saveFile.data.cocks[i].sock;
				if (player.cocks[i].sock == "viridian") hasViridianCockSock = true;
			}
			if (saveFile.data.cocks[i].pierced == undefined)
			{
				player.cocks[i].pierced = 0;
				player.cocks[i].pShortDesc = "";
				player.cocks[i].pLongDesc = "";
			}
			else
			{
				player.cocks[i].pierced = saveFile.data.cocks[i].pierced;
				player.cocks[i].pShortDesc = saveFile.data.cocks[i].pShortDesc;
				player.cocks[i].pLongDesc = saveFile.data.cocks[i].pLongDesc;

				if (player.cocks[i].pShortDesc == "null" || player.cocks[i].pLongDesc == "null")
				{
					player.cocks[i].pierced = 0;
					player.cocks[i].pShortDesc = "";
					player.cocks[i].pLongDesc = "";
				}
			}
				//trace("LoadOne Cock i(" + i + ")");
		}
		//Set Vaginal Array
		for (i = 0; i < saveFile.data.vaginas.length; i++)
		{
			player.createVagina();
		}
		//Populate Vaginal Array
		for (i = 0; i < saveFile.data.vaginas.length; i++)
		{
			player.vaginas[i].vaginalWetness = saveFile.data.vaginas[i].vaginalWetness;
			player.vaginas[i].vaginalLooseness = saveFile.data.vaginas[i].vaginalLooseness;
			player.vaginas[i].fullness = saveFile.data.vaginas[i].fullness;
			player.vaginas[i].virgin = saveFile.data.vaginas[i].virgin;
			if (saveFile.data.vaginas[i].type == undefined) player.vaginas[i].type = 0;
			else player.vaginas[i].type = saveFile.data.vaginas[i].type;
			if (saveFile.data.vaginas[i].labiaPierced == undefined) {
				player.vaginas[i].labiaPierced = 0;
				player.vaginas[i].labiaPShort = "";
				player.vaginas[i].labiaPLong = "";
				player.vaginas[i].clitPierced = 0;
				player.vaginas[i].clitPShort = "";
				player.vaginas[i].clitPLong = "";
				player.vaginas[i].clitLength = VaginaClass.DEFAULT_CLIT_LENGTH;
				player.vaginas[i].recoveryProgress = 0;
			}
			else
			{
				player.vaginas[i].labiaPierced = saveFile.data.vaginas[i].labiaPierced;
				player.vaginas[i].labiaPShort = saveFile.data.vaginas[i].labiaPShort;
				player.vaginas[i].labiaPLong = saveFile.data.vaginas[i].labiaPLong;
				player.vaginas[i].clitPierced = saveFile.data.vaginas[i].clitPierced;
				player.vaginas[i].clitPShort = saveFile.data.vaginas[i].clitPShort;
				player.vaginas[i].clitPLong = saveFile.data.vaginas[i].clitPLong;
				player.vaginas[i].clitLength = saveFile.data.vaginas[i].clitLength;
				player.vaginas[i].recoveryProgress = saveFile.data.vaginas[i].recoveryProgress;


				// backwards compatibility
				if(saveFile.data.vaginas[i].clitLength == undefined) {
					player.vaginas[i].clitLength = VaginaClass.DEFAULT_CLIT_LENGTH;
					trace("Clit length was not loaded, setting to default.");
				}

				if(saveFile.data.vaginas[i].recoveryProgress == undefined) {
					player.vaginas[i].recoveryProgress = 0;
					trace("Stretch counter was not loaded, setting to 0.");
				}
			}
				//trace("LoadOne Vagina i(" + i + ")");
		}
		//NIPPLES
		if (saveFile.data.nippleLength == undefined)
			player.nippleLength = .25;
		else
			player.nippleLength = saveFile.data.nippleLength;
		//Set Breast Array
		for (i = 0; i < saveFile.data.breastRows.length; i++)
		{
			player.createBreastRow();
				//trace("LoadOne BreastROw i(" + i + ")");
		}
		//Populate Breast Array
		for (i = 0; i < saveFile.data.breastRows.length; i++)
		{
			player.breastRows[i].breasts = saveFile.data.breastRows[i].breasts;
			player.breastRows[i].nipplesPerBreast = saveFile.data.breastRows[i].nipplesPerBreast;
			//Fix nipplesless breasts bug
			if (player.breastRows[i].nipplesPerBreast == 0)
				player.breastRows[i].nipplesPerBreast = 1;
			player.breastRows[i].breastRating = saveFile.data.breastRows[i].breastRating;
			player.breastRows[i].lactationMultiplier = saveFile.data.breastRows[i].lactationMultiplier;
			if (player.breastRows[i].lactationMultiplier < 0)
				player.breastRows[i].lactationMultiplier = 0;
			player.breastRows[i].milkFullness = saveFile.data.breastRows[i].milkFullness;
			player.breastRows[i].fuckable = saveFile.data.breastRows[i].fuckable;
			player.breastRows[i].fullness = saveFile.data.breastRows[i].fullness;
			if (player.breastRows[i].breastRating < 0)
				player.breastRows[i].breastRating = 0;
		}

		// Force the creation of the default breast row onto the player if it's no longer present
		if (player.breastRows.length == 0) player.createBreastRow();

		//CLOTHING/ARMOR

		function loadEquipment(slot:int, clazz:Class, savedId:String, savedName:String, defaultValue:Equipable):Boolean {
			var itype:ItemType;
			if (savedId) {
				itype = ItemType.lookupItem(savedId);
				if (itype && itype is clazz) {
					player.internalEquipItem(slot, itype as Equipable, false, true);
					return true;
				}
			}
			if (savedName) {
				for each (itype in ItemType.getItemLibrary()) {
					if (itype is clazz && (itype as Equipable).name == savedName) {
						player.internalEquipItem(slot, itype as Equipable, false, true);
						return true;
					}
				}
			}
			return camp.saveUpdater.onUnknownEquipmentItem(player, saveFile.data, slot, savedId, savedName, defaultValue);
		}

		var found:Boolean;
		var itype:ItemType;
		loadEquipment(ItemConstants.SLOT_WEAPON_MELEE, Weapon, saveFile.data.weaponId, saveFile.data.weaponName, WeaponLib.FISTS);
		loadEquipment(ItemConstants.SLOT_WEAPON_RANGED, WeaponRange, saveFile.data.weaponRangeId, saveFile.data.weaponRangeName, WeaponRangeLib.NOTHING);
		loadEquipment(ItemConstants.SLOT_FLYING_SWORD, FlyingSwords, saveFile.data.weaponFlyingSwordsId, saveFile.data.weaponFlyingSwordsName, FlyingSwordsLib.NOTHING);
		loadEquipment(ItemConstants.SLOT_SHIELD, Shield, saveFile.data.shieldId,  saveFile.data.shieldName, ShieldLib.NOTHING);
		loadEquipment(ItemConstants.SLOT_JEWELRY_MISC_1, MiscJewelry, saveFile.data.miscJewelryId,  saveFile.data.miscjewelryName, MiscJewelryLib.NOTHING);
		loadEquipment(ItemConstants.SLOT_JEWELRY_MISC_2, MiscJewelry, saveFile.data.miscJewelryId2,  saveFile.data.miscjewelryName2, MiscJewelryLib.NOTHING);
		loadEquipment(ItemConstants.SLOT_HEAD, HeadJewelry, saveFile.data.headJewelryId, saveFile.data.headjewelryName, HeadJewelryLib.NOTHING);
		loadEquipment(ItemConstants.SLOT_NECK, Necklace, saveFile.data.necklaceId, saveFile.data.necklaceName, NecklaceLib.NOTHING);
		loadEquipment(ItemConstants.SLOT_RING_1, Jewelry, saveFile.data.jewelryId, saveFile.data.jewelryName, JewelryLib.NOTHING);
		loadEquipment(ItemConstants.SLOT_RING_2, Jewelry, saveFile.data.jewelryId2, saveFile.data.jewelryName2, JewelryLib.NOTHING);
		loadEquipment(ItemConstants.SLOT_RING_3, Jewelry, saveFile.data.jewelryId3, saveFile.data.jewelryName3, JewelryLib.NOTHING);
		loadEquipment(ItemConstants.SLOT_RING_4, Jewelry, saveFile.data.jewelryId4, saveFile.data.jewelryName4, JewelryLib.NOTHING);
		loadEquipment(ItemConstants.SLOT_VEHICLE, Vehicles, saveFile.data.vehiclesId, saveFile.data.vehiclesName, VehiclesLib.NOTHING);
		loadEquipment(ItemConstants.SLOT_UNDER_TOP, Undergarment, saveFile.data.upperGarmentId, saveFile.data.upperGarmentName,UndergarmentLib.NOTHING);
		loadEquipment(ItemConstants.SLOT_UNDER_BOTTOM, Undergarment, saveFile.data.lowerGarmentId, saveFile.data.lowerGarmentName, UndergarmentLib.NOTHING);
		found = loadEquipment(ItemConstants.SLOT_ARMOR, Armor, saveFile.data.armorId, saveFile.data.armorName, ArmorLib.COMFORTABLE_UNDERCLOTHES);
		if (!found){
			for each (itype in ItemType.getItemLibrary()){
				if (itype is Armor){
					var a:Armor = itype as Armor;
					if (a.value == saveFile.data.armorValue &&
							a.def == saveFile.data.armorDef &&
							a.perk == saveFile.data.armorPerk){
						player.setArmor(a,false,true);
						//player.armor = a;
						player.modArmorName = saveFile.data.armorName;
						found = true;
						break;
					}
				}
			}
		}

		var hasHistoryPerk:Boolean = false;
		var hasLustyRegenPerk:Boolean = false;
		var addedSensualLover:Boolean = false;

		//This below is some weird witchcraft.... It doesn't update/swap anything, but somehow this fixes the id mismatch from mutations?
		var mutationsShift:Array = [];
		for each (var pPerk2:IMutationPerkType in IMutationsLib.mutationsArray("All")){
			mutationsShift.push(pPerk2.id);
		}
		mutationsShift.push(IMutationsLib.MutationsTemplateIM.id);
		//Possibly ID updating.

		//Populate Perk Array
		for (i = 0; i < saveFile.data.perks.length; i++)
		{
			var id:String = saveFile.data.perks[i].id || saveFile.data.perks[i].perkName;
			var value1:Number = saveFile.data.perks[i].value1;
			var value2:Number = saveFile.data.perks[i].value2;
			var value3:Number = saveFile.data.perks[i].value3;
			var value4:Number = saveFile.data.perks[i].value4;

			// Fix saves where the Whore perk might have been malformed.
			if (id == "History: Whote") id = "History: Whore";

			// Fix saves where the Lusty Regeneration perk might have been malformed.
			if (id == "Lusty Regeneration")
			{
				hasLustyRegenPerk = true;
			}
			else if (id == "LustyRegeneration")
			{
				id = "Lusty Regeneration";
				hasLustyRegenPerk = true;
			}
			// Some shit checking to track if the incoming data has an available History perk
			if (id.indexOf("History:") != -1) {
				hasHistoryPerk = true;
			}

			//Mutations will be handled there instead.
			if (MutationsLib.mutationsUpdate(id)) continue;

			var ptype:PerkType = PerkType.lookupPerk(id);
			if (ptype == null) {
				camp.saveUpdater.onUnknownPerk(player, saveFile.data, id, value1, value2, value3, value4);
				//(saveFile.data.perks as Array).splice(i,1);
				// NEVER EVER EVER MODIFY DATA IN THE SAVE FILE LIKE THIS. EVER. FOR ANY REASON.
			} else {
//				trace("Creating perk : " + ptype);
				var cperk:PerkClass = new PerkClass(ptype, value1, value2, value3, value4);

				if (isNaN(cperk.value1)) {
					if (cperk.perkName == "Wizard's Focus") {
						cperk.value1 = .3;
					} else {
						cperk.value1 = 0;
					}

					trace("NaN byaaaatch: " + cperk.value1);
				}

				if (cperk.perkName == "Wizard's Focus") {
					if (cperk.value1 == 0 || cperk.value1 < 0.1) {
						trace("Wizard's Focus boosted up to par (.5)");
						cperk.value1 = .5;
					}
				}
				player.addPerkInstance(cperk);
			}
		}

		for each (var mutations:IMutationPerkType in IMutationsLib.mutationsArray("")){
			if (player.hasPerk(mutations) && !player.statStore.hasBuff("perk_" + mutations.id)) mutations.updateDynamicPerkBuffs(player);
		}

		// Fixup missing History: Whore perk IF AND ONLY IF the flag used to track the prior selection of a history perk has been set
		if (!hasHistoryPerk && flags[kFLAGS.HISTORY_PERK_SELECTED] != 1)
		{
			player.createPerk(PerkLib.HistoryWhore, 0, 0, 0, 0);
		}

		// Fixup missing Lusty Regeneration perk, if the player has an equipped viridian cock sock and does NOT have the Lusty Regeneration perk
		if (hasViridianCockSock && !hasLustyRegenPerk)
		{
			player.createPerk(PerkLib.LustyRegeneration, 0, 0, 0, 0);
		}

		if (flags[kFLAGS.TATTOO_SAVEFIX_APPLIED] == 0)
		{
			// Fix some tatto texts that could be broken
			if (flags[kFLAGS.VAPULA_TATTOO_LOWERBACK] is String && (flags[kFLAGS.VAPULA_TATTOO_LOWERBACK] as String).indexOf("lower back.lower back") != -1)
			{
				flags[kFLAGS.VAPULA_TATTOO_LOWERBACK] = (flags[kFLAGS.VAPULA_TATTOO_LOWERBACK] as String).split(".")[0] + ".";
			}


			var refunds:int = 0;

			if (flags[kFLAGS.JOJO_TATTOO_LOWERBACK] is String)
			{
				refunds++;
				flags[kFLAGS.JOJO_TATTOO_LOWERBACK] = 0;
			}

			if (flags[kFLAGS.JOJO_TATTOO_BUTT] is String)
			{
				refunds++;
				flags[kFLAGS.JOJO_TATTOO_BUTT] = 0;
			}

			if (flags[kFLAGS.JOJO_TATTOO_COLLARBONE] is String)
			{
				refunds++;
				flags[kFLAGS.JOJO_TATTOO_COLLARBONE] = 0;
			}

			if (flags[kFLAGS.JOJO_TATTOO_SHOULDERS] is String)
			{
				refunds++;
				flags[kFLAGS.JOJO_TATTOO_SHOULDERS] = 0;
			}

			player.gems += 50 * refunds;
			flags[kFLAGS.TATTOO_SAVEFIX_APPLIED] = 1;
		}

		if (flags[kFLAGS.FOLLOWER_AT_FARM_MARBLE] == 1)
		{
			flags[kFLAGS.FOLLOWER_AT_FARM_MARBLE] = 0;
			trace("Force-reverting Marble At Farm flag to 0.");
		}

		//Set Status Array
		for (i = 0; i < saveFile.data.statusAffects.length; i++)
		{
			if (saveFile.data.statusAffects[i].statusAffectName == "Lactation EnNumbere") continue; // ugh...
			var name:String = saveFile.data.statusAffects[i].statusAffectName;
			value1 = saveFile.data.statusAffects[i].value1;
			value2 = saveFile.data.statusAffects[i].value2;
			value3 = saveFile.data.statusAffects[i].value3;
			value4 = saveFile.data.statusAffects[i].value4;
			var stype:StatusEffectType = StatusEffectType.lookupStatusEffect(name);
			if (stype == null){
				if (StatusEffectType.RemovedIds.indexOf(name) < 0) {
					camp.saveUpdater.onUnknownStatusEffect(player, saveFile.data, name, value1,value2,value3,value4);
				}
				continue;
			}
			player.createStatusEffect(stype,
					value1,
					value2,
					value3,
					value4);
		}
		//Make sure keyitems exist!
		if (saveFile.data.keyItems != undefined)
		{
			//Set keyItems Array
			for (i = 0; i < saveFile.data.keyItems.length; i++)
			{
				player.createKeyItem("TEMP", 0, 0, 0, 0);
			}
			//Populate keyItems Array
			for (i = 0; i < saveFile.data.keyItems.length; i++)
			{
				player.keyItems[i].keyName = saveFile.data.keyItems[i].keyName;
				player.keyItems[i].value1 = saveFile.data.keyItems[i].value1;
				player.keyItems[i].value2 = saveFile.data.keyItems[i].value2;
				player.keyItems[i].value3 = saveFile.data.keyItems[i].value3;
				player.keyItems[i].value4 = saveFile.data.keyItems[i].value4;
					//trace("KeyItem " + player.keyItems[i].keyName + " loaded.");
			}
		}
		
		function loadItem(storage:ItemSlotClass, savedIS:*):void {
			if (!savedIS || !(savedIS.shortName || savedIS.id) || !savedIS.quantity || savedIS.quantity == 0) {
				storage.emptySlot();
				return;
			}
			storage.unlocked = !!savedIS.unlocked;
			var id:String = savedIS.id;
			if (savedIS.shortName) {
				if (savedIS.shortName.indexOf("Gro+") != -1)
					id = "GroPlus";
				else if (savedIS.shortName.indexOf("Sp Honey") != -1)
					id = "SpHoney";
			}
			itype = ItemType.lookupItem(id || savedIS.shortName);
			if (itype == null) {
				camp.saveUpdater.onUnknownInventoryItem(player, saveFile.data, id, savedIS.shortName, savedIS.quantity, storage);
			} else {
				storage.setItemAndQty(itype, savedIS.quantity);
			}
		}
		
		//Set storage slot array
		if (saveFile.data.itemStorage == undefined)
		{
			//trace("OLD SAVES DO NOT CONTAIN ITEM STORAGE ARRAY");
		}
		else
		{
			//Populate storage slot array
			for (i = 0; i < saveFile.data.itemStorage.length; i++)
			{
				//trace("Populating a storage slot save with data");
				inventory.createStorage();
				var storage:ItemSlotClass = itemStorageGet()[i];
				var savedIS:* = saveFile.data.itemStorage[i];
				loadItem(storage, savedIS);
			}
		}

		//Set pearl slot array
		if (saveFile.data.pearlStorage == undefined)
		{
			//trace("OLD SAVES DO NOT CONTAIN ITEM STORAGE ARRAY - Creating new!");
			inventory.initializePearlStorage();
		}
		else
		{
			for (i = 0; i < saveFile.data.pearlStorage.length && pearlStorageGet().length < 98; i++)
			{
				pearlStorageGet().push(new ItemSlotClass(ItemSlotClass.STORAGE_PEARL));
					//trace("Initialize a slot for one of the item storage locations to load.");
			}
			//Populate storage slot array
			for (i = 0; i < saveFile.data.pearlStorage.length && i < pearlStorageGet().length; i++)
			{
				//trace("Populating a storage slot save with data");
				storage = pearlStorageGet()[i];
				loadItem(storage, saveFile.data.pearlStorage[i]);
			}
		}

		//Set gear slot array
		if (saveFile.data.gearStorage == undefined)
		{
			//trace("OLD SAVES DO NOT CONTAIN ITEM STORAGE ARRAY - Creating new!");
			inventory.initializeGearStorage();
		}
		else
		{
			for (i = 0; i < saveFile.data.gearStorage.length && gearStorageGet().length < 90; i++)
			{
				gearStorageGet().push(new ItemSlotClass());
					//trace("Initialize a slot for one of the item storage locations to load.");
			}
			//Populate storage slot array
			for (i = 0; i < saveFile.data.gearStorage.length && i < gearStorageGet().length; i++)
			{
				//trace("Populating a storage slot save with data");
				storage = gearStorageGet()[i];
				loadItem(storage, saveFile.data.gearStorage[i]);
			}
		}

		//Set soulforce
		if (saveFile.data.soulforce == undefined) player.soulforce = 25;
		//Set wisdom
		if (saveFile.data.wis == undefined) player.wisStat.train.value = 15;
		//Set wrath
		if (saveFile.data.wrath == undefined) player.wrath = 0;
		//Set mana
		if (saveFile.data.mana == undefined) player.mana = 50;

		//player.cocks = saveFile.data.cocks;
		player.ass.analLooseness = saveFile.data.ass.analLooseness;
		player.ass.analWetness = saveFile.data.ass.analWetness;
		player.ass.fullness = saveFile.data.ass.fullness;

		//Shit
		gameStateSet(saveFile.data.gameState);

		//Days
		//Time and Items
		model.time.minutes = saveFile.data.minutes;
		model.time.hours = saveFile.data.hours;
		model.time.days = saveFile.data.days;
		if (saveFile.data.autoSave == undefined)
			player.autoSave = false;
		else
			player.autoSave = saveFile.data.autoSave;

		//PLOTZ
		JojoScene.monk = saveFile.data.monk;
		SandWitchScene.rapedBefore      = saveFile.data.sand;

		if (saveFile.data.beeProgress != undefined && saveFile.data.beeProgress == 1) SceneLib.forest.beeGirlScene.setTalked(); //Bee Progress update is now in a flag
			//The flag will be zero for any older save that still uses beeProgress and newer saves always store a zero in beeProgress, so we only need to update the flag on a value of one.

		SceneLib.isabellaScene.isabellaOffspringData = [];
		if (saveFile.data.isabellaOffspringData == undefined) {
			//NOPE
		}
		else {
			for (i = 0; i < saveFile.data.isabellaOffspringData.length; i += 2) {
				SceneLib.isabellaScene.isabellaOffspringData.push(saveFile.data.isabellaOffspringData[i], saveFile.data.isabellaOffspringData[i+1])
			}
		}

		// Potions
		if (saveFile.data.potions) {
			for (i = 0; i< saveFile.data.potions.length; i++) {
				var potionId:String = saveFile.data.potions[i].id;
				var potionCount:Number = saveFile.data.potions[i].count;
				var potionType:PotionType = PotionType.ALL_POTIONS[potionId];
				if (potionType) {
					player.potions.push( { type: potionType, count: potionCount});
				} else {
					trace("/!\\ Unknown potion ID "+ potionId);
				}
			}
		}

		//ITEMZ. Item1
		if (saveFile.data.itemSlot1.shortName)
		{
			if (saveFile.data.itemSlot1.shortName.indexOf("Gro+") != -1)
				saveFile.data.itemSlot1.id = "GroPlus";
			else if (saveFile.data.itemSlot1.shortName.indexOf("Sp Honey") != -1)
				saveFile.data.itemSlot1.id = "SpHoney";
		}
		if (saveFile.data.itemSlot2.shortName)
		{
			if (saveFile.data.itemSlot2.shortName.indexOf("Gro+") != -1)
				saveFile.data.itemSlot2.id = "GroPlus";
			else if (saveFile.data.itemSlot2.shortName.indexOf("Sp Honey") != -1)
				saveFile.data.itemSlot2.id = "SpHoney";
		}
		if (saveFile.data.itemSlot3.shortName)
		{
			if (saveFile.data.itemSlot3.shortName.indexOf("Gro+") != -1)
				saveFile.data.itemSlot3.id = "GroPlus";
			else if (saveFile.data.itemSlot3.shortName.indexOf("Sp Honey") != -1)
				saveFile.data.itemSlot3.id = "SpHoney";
		}
		if (saveFile.data.itemSlot4.shortName)
		{
			if (saveFile.data.itemSlot4.shortName.indexOf("Gro+") != -1)
				saveFile.data.itemSlot4.id = "GroPlus";
			else if (saveFile.data.itemSlot4.shortName.indexOf("Sp Honey") != -1)
				saveFile.data.itemSlot4.id = "SpHoney";
		}
		if (saveFile.data.itemSlot5.shortName)
		{
			if (saveFile.data.itemSlot5.shortName.indexOf("Gro+") != -1)
				saveFile.data.itemSlot5.id = "GroPlus";
			else if (saveFile.data.itemSlot5.shortName.indexOf("Sp Honey") != -1)
				saveFile.data.itemSlot5.id = "SpHoney";
		}

		player.itemSlot1.unlocked = true;
		player.itemSlot1.setItemAndQty(ItemType.lookupItem(
				saveFile.data.itemSlot1.id || saveFile.data.itemSlot1.shortName),
				saveFile.data.itemSlot1.quantity);
		player.itemSlot2.unlocked = true;
		player.itemSlot2.setItemAndQty(ItemType.lookupItem(
				saveFile.data.itemSlot2.id || saveFile.data.itemSlot2.shortName),
				saveFile.data.itemSlot2.quantity);
		player.itemSlot3.unlocked = true;
		player.itemSlot3.setItemAndQty(ItemType.lookupItem(
				saveFile.data.itemSlot3.id || saveFile.data.itemSlot3.shortName),
				saveFile.data.itemSlot3.quantity);
		player.itemSlot4.unlocked = true;
		player.itemSlot4.setItemAndQty(ItemType.lookupItem(
				saveFile.data.itemSlot4.id || saveFile.data.itemSlot4.shortName),
				saveFile.data.itemSlot4.quantity);
		player.itemSlot5.unlocked = true;
		player.itemSlot5.setItemAndQty(ItemType.lookupItem(
				saveFile.data.itemSlot5.id || saveFile.data.itemSlot5.shortName),
				saveFile.data.itemSlot5.quantity);
		player.itemSlot6.unlocked = true;
		player.itemSlot6.setItemAndQty(ItemType.lookupItem(
				saveFile.data.itemSlot6.id || saveFile.data.itemSlot6.shortName),
				saveFile.data.itemSlot6.quantity);
		//Extra slots from the mod.
		if (saveFile.data.itemSlot7 != undefined && saveFile.data.itemSlot8 != undefined && saveFile.data.itemSlot9 != undefined && saveFile.data.itemSlot10 != undefined && saveFile.data.itemSlot11 != undefined && saveFile.data.itemSlot12 != undefined && saveFile.data.itemSlot13 != undefined
			 && saveFile.data.itemSlot14 != undefined && saveFile.data.itemSlot15 != undefined && saveFile.data.itemSlot16 != undefined && saveFile.data.itemSlot17 != undefined && saveFile.data.itemSlot18 != undefined && saveFile.data.itemSlot19 != undefined && saveFile.data.itemSlot20 != undefined) {
		player.itemSlot7.unlocked = saveFile.data.itemSlot7.unlocked;
		player.itemSlot7.setItemAndQty(ItemType.lookupItem(
				saveFile.data.itemSlot7.id || saveFile.data.itemSlot7.shortName),
				saveFile.data.itemSlot7.quantity);
        player.itemSlot8.unlocked = saveFile.data.itemSlot8.unlocked;
		player.itemSlot8.setItemAndQty(ItemType.lookupItem(
				saveFile.data.itemSlot8.id || saveFile.data.itemSlot8.shortName),
				saveFile.data.itemSlot8.quantity);
		player.itemSlot9.unlocked = saveFile.data.itemSlot9.unlocked;
		player.itemSlot9.setItemAndQty(ItemType.lookupItem(
				saveFile.data.itemSlot9.id || saveFile.data.itemSlot9.shortName),
				saveFile.data.itemSlot9.quantity);
		player.itemSlot10.unlocked = saveFile.data.itemSlot10.unlocked;
		player.itemSlot10.setItemAndQty(ItemType.lookupItem(
				saveFile.data.itemSlot10.id || saveFile.data.itemSlot10.shortName),
				saveFile.data.itemSlot10.quantity);
		player.itemSlot11.unlocked = saveFile.data.itemSlot11.unlocked;
		player.itemSlot11.setItemAndQty(ItemType.lookupItem(
				saveFile.data.itemSlot11.id || saveFile.data.itemSlot11.shortName),
				saveFile.data.itemSlot11.quantity);
		player.itemSlot12.unlocked = saveFile.data.itemSlot12.unlocked;
		player.itemSlot12.setItemAndQty(ItemType.lookupItem(
				saveFile.data.itemSlot12.id || saveFile.data.itemSlot12.shortName),
				saveFile.data.itemSlot12.quantity);
		player.itemSlot13.unlocked = saveFile.data.itemSlot13.unlocked;
		player.itemSlot13.setItemAndQty(ItemType.lookupItem(
				saveFile.data.itemSlot13.id || saveFile.data.itemSlot13.shortName),
				saveFile.data.itemSlot13.quantity);
		player.itemSlot14.unlocked = saveFile.data.itemSlot14.unlocked;
		player.itemSlot14.setItemAndQty(ItemType.lookupItem(
				saveFile.data.itemSlot14.id || saveFile.data.itemSlot14.shortName),
				saveFile.data.itemSlot14.quantity);
		player.itemSlot15.unlocked = saveFile.data.itemSlot15.unlocked;
		player.itemSlot15.setItemAndQty(ItemType.lookupItem(
				saveFile.data.itemSlot15.id || saveFile.data.itemSlot15.shortName),
				saveFile.data.itemSlot15.quantity);
		player.itemSlot16.unlocked = saveFile.data.itemSlot16.unlocked;
		player.itemSlot16.setItemAndQty(ItemType.lookupItem(
				saveFile.data.itemSlot16.id || saveFile.data.itemSlot16.shortName),
				saveFile.data.itemSlot16.quantity);
		player.itemSlot17.unlocked = saveFile.data.itemSlot17.unlocked;
		player.itemSlot17.setItemAndQty(ItemType.lookupItem(
				saveFile.data.itemSlot17.id || saveFile.data.itemSlot17.shortName),
				saveFile.data.itemSlot17.quantity);
		player.itemSlot18.unlocked = saveFile.data.itemSlot18.unlocked;
		player.itemSlot18.setItemAndQty(ItemType.lookupItem(
				saveFile.data.itemSlot18.id || saveFile.data.itemSlot18.shortName),
				saveFile.data.itemSlot18.quantity);
		player.itemSlot19.unlocked = saveFile.data.itemSlot19.unlocked;
		player.itemSlot19.setItemAndQty(ItemType.lookupItem(
				saveFile.data.itemSlot19.id || saveFile.data.itemSlot19.shortName),
				saveFile.data.itemSlot19.quantity);
		player.itemSlot20.unlocked = saveFile.data.itemSlot20.unlocked;
		player.itemSlot20.setItemAndQty(ItemType.lookupItem(
				saveFile.data.itemSlot20.id || saveFile.data.itemSlot20.shortName),
				saveFile.data.itemSlot20.quantity);
		}
		if (saveFile.data.itemSlot21 != undefined && saveFile.data.itemSlot22 != undefined && saveFile.data.itemSlot23 != undefined && saveFile.data.itemSlot24 != undefined && saveFile.data.itemSlot25 != undefined
		 && saveFile.data.itemSlot26 != undefined && saveFile.data.itemSlot27 != undefined && saveFile.data.itemSlot28 != undefined && saveFile.data.itemSlot29 != undefined && saveFile.data.itemSlot30 != undefined
		 && saveFile.data.itemSlot31 != undefined && saveFile.data.itemSlot32 != undefined && saveFile.data.itemSlot33 != undefined && saveFile.data.itemSlot34 != undefined && saveFile.data.itemSlot35 != undefined
		 && saveFile.data.itemSlot36 != undefined && saveFile.data.itemSlot37 != undefined && saveFile.data.itemSlot38 != undefined && saveFile.data.itemSlot39 != undefined && saveFile.data.itemSlot40 != undefined
		 && saveFile.data.itemSlot41 != undefined && saveFile.data.itemSlot42 != undefined && saveFile.data.itemSlot43 != undefined && saveFile.data.itemSlot44 != undefined && saveFile.data.itemSlot45 != undefined
		 && saveFile.data.itemSlot46 != undefined && saveFile.data.itemSlot47 != undefined && saveFile.data.itemSlot48 != undefined && saveFile.data.itemSlot49 != undefined && saveFile.data.itemSlot50 != undefined) {
		player.itemSlot21.unlocked = saveFile.data.itemSlot21.unlocked;
		player.itemSlot21.setItemAndQty(ItemType.lookupItem(
				saveFile.data.itemSlot21.id || saveFile.data.itemSlot21.shortName),
				saveFile.data.itemSlot21.quantity);
		player.itemSlot22.unlocked = saveFile.data.itemSlot22.unlocked;
		player.itemSlot22.setItemAndQty(ItemType.lookupItem(
				saveFile.data.itemSlot22.id || saveFile.data.itemSlot22.shortName),
				saveFile.data.itemSlot22.quantity);
		player.itemSlot23.unlocked = saveFile.data.itemSlot23.unlocked;
		player.itemSlot23.setItemAndQty(ItemType.lookupItem(
				saveFile.data.itemSlot23.id || saveFile.data.itemSlot23.shortName),
				saveFile.data.itemSlot23.quantity);
		player.itemSlot24.unlocked = saveFile.data.itemSlot24.unlocked;
		player.itemSlot24.setItemAndQty(ItemType.lookupItem(
				saveFile.data.itemSlot24.id || saveFile.data.itemSlot24.shortName),
				saveFile.data.itemSlot24.quantity);
		player.itemSlot25.unlocked = saveFile.data.itemSlot25.unlocked;
		player.itemSlot25.setItemAndQty(ItemType.lookupItem(
				saveFile.data.itemSlot25.id || saveFile.data.itemSlot25.shortName),
				saveFile.data.itemSlot25.quantity);
		player.itemSlot26.unlocked = saveFile.data.itemSlot26.unlocked;
		player.itemSlot26.setItemAndQty(ItemType.lookupItem(
				saveFile.data.itemSlot26.id || saveFile.data.itemSlot26.shortName),
				saveFile.data.itemSlot26.quantity);
		player.itemSlot27.unlocked = saveFile.data.itemSlot27.unlocked;
		player.itemSlot27.setItemAndQty(ItemType.lookupItem(
				saveFile.data.itemSlot27.id || saveFile.data.itemSlot27.shortName),
				saveFile.data.itemSlot27.quantity);
		player.itemSlot28.unlocked = saveFile.data.itemSlot28.unlocked;
		player.itemSlot28.setItemAndQty(ItemType.lookupItem(
				saveFile.data.itemSlot28.id || saveFile.data.itemSlot28.shortName),
				saveFile.data.itemSlot28.quantity);
		player.itemSlot29.unlocked = saveFile.data.itemSlot29.unlocked;
		player.itemSlot29.setItemAndQty(ItemType.lookupItem(
				saveFile.data.itemSlot29.id || saveFile.data.itemSlot29.shortName),
				saveFile.data.itemSlot29.quantity);
		player.itemSlot30.unlocked = saveFile.data.itemSlot30.unlocked;
		player.itemSlot30.setItemAndQty(ItemType.lookupItem(
				saveFile.data.itemSlot30.id || saveFile.data.itemSlot30.shortName),
				saveFile.data.itemSlot30.quantity);
		player.itemSlot31.unlocked = saveFile.data.itemSlot31.unlocked;
		player.itemSlot31.setItemAndQty(ItemType.lookupItem(
				saveFile.data.itemSlot31.id || saveFile.data.itemSlot31.shortName),
				saveFile.data.itemSlot31.quantity);
		player.itemSlot32.unlocked = saveFile.data.itemSlot32.unlocked;
		player.itemSlot32.setItemAndQty(ItemType.lookupItem(
				saveFile.data.itemSlot32.id || saveFile.data.itemSlot32.shortName),
				saveFile.data.itemSlot32.quantity);
		player.itemSlot33.unlocked = saveFile.data.itemSlot33.unlocked;
		player.itemSlot33.setItemAndQty(ItemType.lookupItem(
				saveFile.data.itemSlot33.id || saveFile.data.itemSlot33.shortName),
				saveFile.data.itemSlot33.quantity);
		player.itemSlot34.unlocked = saveFile.data.itemSlot34.unlocked;
		player.itemSlot34.setItemAndQty(ItemType.lookupItem(
				saveFile.data.itemSlot34.id || saveFile.data.itemSlot34.shortName),
				saveFile.data.itemSlot34.quantity);
		player.itemSlot35.unlocked = saveFile.data.itemSlot35.unlocked;
		player.itemSlot35.setItemAndQty(ItemType.lookupItem(
				saveFile.data.itemSlot35.id || saveFile.data.itemSlot35.shortName),
				saveFile.data.itemSlot35.quantity);
		player.itemSlot36.unlocked = saveFile.data.itemSlot36.unlocked;
		player.itemSlot36.setItemAndQty(ItemType.lookupItem(
				saveFile.data.itemSlot36.id || saveFile.data.itemSlot36.shortName),
				saveFile.data.itemSlot36.quantity);
		player.itemSlot37.unlocked = saveFile.data.itemSlot37.unlocked;
		player.itemSlot37.setItemAndQty(ItemType.lookupItem(
				saveFile.data.itemSlot37.id || saveFile.data.itemSlot37.shortName),
				saveFile.data.itemSlot37.quantity);
		player.itemSlot38.unlocked = saveFile.data.itemSlot38.unlocked;
		player.itemSlot38.setItemAndQty(ItemType.lookupItem(
				saveFile.data.itemSlot38.id || saveFile.data.itemSlot38.shortName),
				saveFile.data.itemSlot38.quantity);
		player.itemSlot39.unlocked = saveFile.data.itemSlot39.unlocked;
		player.itemSlot39.setItemAndQty(ItemType.lookupItem(
				saveFile.data.itemSlot39.id || saveFile.data.itemSlot39.shortName),
				saveFile.data.itemSlot39.quantity);
		player.itemSlot40.unlocked = saveFile.data.itemSlot40.unlocked;
		player.itemSlot40.setItemAndQty(ItemType.lookupItem(
				saveFile.data.itemSlot40.id || saveFile.data.itemSlot40.shortName),
				saveFile.data.itemSlot40.quantity);
		player.itemSlot41.unlocked = saveFile.data.itemSlot41.unlocked;
		player.itemSlot41.setItemAndQty(ItemType.lookupItem(
				saveFile.data.itemSlot41.id || saveFile.data.itemSlot41.shortName),
				saveFile.data.itemSlot41.quantity);
		player.itemSlot42.unlocked = saveFile.data.itemSlot42.unlocked;
		player.itemSlot42.setItemAndQty(ItemType.lookupItem(
				saveFile.data.itemSlot42.id || saveFile.data.itemSlot42.shortName),
				saveFile.data.itemSlot42.quantity);
		player.itemSlot43.unlocked = saveFile.data.itemSlot43.unlocked;
		player.itemSlot43.setItemAndQty(ItemType.lookupItem(
				saveFile.data.itemSlot43.id || saveFile.data.itemSlot43.shortName),
				saveFile.data.itemSlot43.quantity);
		player.itemSlot44.unlocked = saveFile.data.itemSlot44.unlocked;
		player.itemSlot44.setItemAndQty(ItemType.lookupItem(
				saveFile.data.itemSlot44.id || saveFile.data.itemSlot44.shortName),
				saveFile.data.itemSlot44.quantity);
		player.itemSlot45.unlocked = saveFile.data.itemSlot45.unlocked;
		player.itemSlot45.setItemAndQty(ItemType.lookupItem(
				saveFile.data.itemSlot45.id || saveFile.data.itemSlot45.shortName),
				saveFile.data.itemSlot45.quantity);
		player.itemSlot46.unlocked = saveFile.data.itemSlot46.unlocked;
		player.itemSlot46.setItemAndQty(ItemType.lookupItem(
				saveFile.data.itemSlot46.id || saveFile.data.itemSlot46.shortName),
				saveFile.data.itemSlot46.quantity);
		player.itemSlot47.unlocked = saveFile.data.itemSlot47.unlocked;
		player.itemSlot47.setItemAndQty(ItemType.lookupItem(
				saveFile.data.itemSlot47.id || saveFile.data.itemSlot47.shortName),
				saveFile.data.itemSlot47.quantity);
		player.itemSlot48.unlocked = saveFile.data.itemSlot48.unlocked;
		player.itemSlot48.setItemAndQty(ItemType.lookupItem(
				saveFile.data.itemSlot48.id || saveFile.data.itemSlot48.shortName),
				saveFile.data.itemSlot48.quantity);
		player.itemSlot49.unlocked = saveFile.data.itemSlot49.unlocked;
		player.itemSlot49.setItemAndQty(ItemType.lookupItem(
				saveFile.data.itemSlot49.id || saveFile.data.itemSlot49.shortName),
				saveFile.data.itemSlot49.quantity);
		player.itemSlot50.unlocked = saveFile.data.itemSlot50.unlocked;
		player.itemSlot50.setItemAndQty(ItemType.lookupItem(
				saveFile.data.itemSlot50.id || saveFile.data.itemSlot50.shortName),
				saveFile.data.itemSlot50.quantity);
		}
		for (var key:String in _saveableStates) {
			var ss:SaveableState = _saveableStates[key];
			try {
				if (saveFile.data.ss && key in saveFile.data.ss) {
					ss.loadFromObject(saveFile.data.ss[key], true);
				} else {
					ss.loadFromObject(null, true);
				}
			} catch (e:Error) {
				CoC_Settings.error("Error loading ss."+key+": "+e.getStackTrace())
			}
		}
		loadAllAwareClasses(CoC.instance); //Informs each saveAwareClass that it must load its values from the flags array
        unFuckSave();

		// Control Bindings
		if (saveFile.data.controls != undefined)
		{
			game.inputManager.LoadBindsFromObj(saveFile.data.controls);
		}

		XXCNPC.unloadSavedNPCs();
		if(saveFile.data.world == undefined){saveFile.data.world = [];}
		if(saveFile.data.world.x == undefined){saveFile.data.world.x = [];}
		for each(var savedNPC:* in saveFile.data.world.x){
			if(savedNPC.myClass != undefined){
                var ref:Class = getDefinitionByName(savedNPC.myClass) as Class;
                ref["instance"].load(saveFile.data.world.x);
			}
		}
		camp.saveUpdater.postLoadSaveObject(player, saveFile.data);

		player.updateRacialAndPerkBuffs();
		doNext(playerMenu);
		EventParser.badEnded = false; //reset bad end if we're going from it
	}
	game.isLoadingSave = false;
	mainView.statsView.hide(); // to reset animations
}

public function unFuckSave():void
{
	//Fixing shit!

	// Fix duplicate elven bounty perks
	if (player.hasPerk(PerkLib.ElvenBounty)) {
		//Fix fudged preggers value
		if (player.perkv1(PerkLib.ElvenBounty) == 15) {
			player.setPerkValue(PerkLib.ElvenBounty,1,0);
			player.addPerkValue(PerkLib.ElvenBounty,2,15);
		}
	}

	if (player.hasStatusEffect(StatusEffects.KnockedBack))
	{
		player.removeStatusEffect(StatusEffects.KnockedBack);
	}

	if (player.hasStatusEffect(StatusEffects.Tentagrappled))
	{
		player.removeStatusEffect(StatusEffects.Tentagrappled);
	}

	if (isNaN(model.time.minutes)) model.time.minutes = 0;
	if (isNaN(model.time.hours)) model.time.hours = 0;
	if (isNaN(model.time.days)) model.time.days = 0;

	if (player.hasStatusEffect(StatusEffects.SlimeCraving) && player.statusEffectv4(StatusEffects.SlimeCraving) == 1) {
		player.changeStatusValue(StatusEffects.SlimeCraving, 3, player.statusEffectv2(StatusEffects.SlimeCraving)); //Duplicate old combined strength/speed value
		player.changeStatusValue(StatusEffects.SlimeCraving, 4, 1); //Value four indicates this tracks strength and speed separately
	}

	// Fix issues with corrupt cockTypes caused by a error in the serialization code.

	//trace("CockInfo = ", flags[kFLAGS.RUBI_COCK_TYPE]);
	//trace("getQualifiedClassName = ", getQualifiedClassName(flags[kFLAGS.RUBI_COCK_TYPE]));
	//trace("typeof = ", typeof(flags[kFLAGS.RUBI_COCK_TYPE]));
	//trace("is CockTypesEnum = ", flags[kFLAGS.RUBI_COCK_TYPE] is CockTypesEnum);
	//trace("instanceof CockTypesEnum = ", flags[kFLAGS.RUBI_COCK_TYPE] instanceof CockTypesEnum);


	if (!(flags[kFLAGS.RUBI_COCK_TYPE] is CockTypesEnum || flags[kFLAGS.RUBI_COCK_TYPE] is Number)) { // Valid contents of flags[kFLAGS.RUBI_COCK_TYPE] are either a CockTypesEnum or a number

		trace("Fixing save (goo girl)");
		outputText("\n<b>Rubi's cockType is invalid. Defaulting him to human.</b>\n");
		flags[kFLAGS.RUBI_COCK_TYPE] = 0;
	}


	if (!(flags[kFLAGS.GOO_DICK_TYPE] is CockTypesEnum || flags[kFLAGS.GOO_DICK_TYPE] is Number)) { // Valid contents of flags[kFLAGS.GOO_DICK_TYPE] are either a CockTypesEnum or a number

		trace("Fixing save (goo girl)");
		outputText("\n<b>Latex Goo-Girls's cockType is invalid. Defaulting him to human.</b>\n");
		flags[kFLAGS.GOO_DICK_TYPE] = 0;
	}

	var flagData:Array = String(flags[kFLAGS.KATHERINE_BREAST_SIZE]).split("^");
	if (flagData.length < 7 && flags[kFLAGS.KATHERINE_BREAST_SIZE] > 0) { //Older format only stored breast size or zero if not yet initialized
		SceneLib.telAdre.katherine.breasts.cupSize = flags[kFLAGS.KATHERINE_BREAST_SIZE];
        SceneLib.telAdre.katherine.breasts.lactationLevel = BreastStore.LACTATION_DISABLED;
    }

	if (flags[kFLAGS.SAVE_FILE_INTEGER_FORMAT_VERSION] < 816) {
		//Older saves don't have pregnancy types for all impregnable NPCs. Have to correct this.
		//If anything is detected that proves this is a new format save then we can return immediately as all further checks are redundant.
		if (flags[kFLAGS.AMILY_INCUBATION] > 0) {
			if (flags[kFLAGS.AMILY_PREGNANCY_TYPE] != 0) return; //Must be a new format save
			flags[kFLAGS.AMILY_PREGNANCY_TYPE] = PregnancyStore.PREGNANCY_PLAYER;
		}
		if (flags[kFLAGS.AMILY_OVIPOSITED_COUNTDOWN] > 0) {
			if (flags[kFLAGS.AMILY_BUTT_PREGNANCY_TYPE] != 0) return; //Must be a new format save
			if (player.hasPerk(PerkLib.SpiderOvipositor))
				flags[kFLAGS.AMILY_BUTT_PREGNANCY_TYPE] = PregnancyStore.PREGNANCY_DRIDER_EGGS;
			else
				flags[kFLAGS.AMILY_BUTT_PREGNANCY_TYPE] = PregnancyStore.PREGNANCY_BEE_EGGS;
		}

		if (flags[kFLAGS.COTTON_PREGNANCY_INCUBATION] > 0) {
			if (flags[kFLAGS.COTTON_PREGNANCY_TYPE] != 0) return; //Must be a new format save
			flags[kFLAGS.COTTON_PREGNANCY_TYPE] = PregnancyStore.PREGNANCY_PLAYER;
		}

		if (flags[kFLAGS.EMBER_INCUBATION] > 0) {
			if (flags[kFLAGS.EMBER_PREGNANCY_TYPE] != 0) return; //Must be a new format save
			flags[kFLAGS.EMBER_PREGNANCY_TYPE] = PregnancyStore.PREGNANCY_PLAYER;
		}

		if (flags[kFLAGS.FEMALE_SPIDERMORPH_PREGNANCY_INCUBATION] > 0) {
			if (flags[kFLAGS.FEMALE_SPIDERMORPH_PREGNANCY_TYPE] != 0) return; //Must be a new format save
			flags[kFLAGS.FEMALE_SPIDERMORPH_PREGNANCY_TYPE] = PregnancyStore.PREGNANCY_PLAYER;
		}

		if (flags[kFLAGS.HELSPAWN_AGE] > 0) {
			SceneLib.helScene.pregnancy.knockUpForce(); //Clear Pregnancy, also removed any old value from HEL_PREGNANCY_NOTICES
		}
		else if (flags[kFLAGS.HEL_PREGNANCY_INCUBATION] > 0) {
			if (flags[kFLAGS.HELIA_PREGNANCY_TYPE] > 3) return; //Must be a new format save
			//HELIA_PREGNANCY_TYPE was previously HEL_PREGNANCY_NOTICES, which ran from 0 to 3. Converted to the new format by multiplying by 65536
			//Since HelSpawn's father is already tracked separately we might as well just use PREGNANCY_PLAYER for all possible pregnancies
			flags[kFLAGS.HELIA_PREGNANCY_TYPE] = (65536 * flags[kFLAGS.HELIA_PREGNANCY_TYPE]) + PregnancyStore.PREGNANCY_PLAYER;
		}

		if (flags[kFLAGS.KELLY_INCUBATION] > 0) {
			if (flags[kFLAGS.KELLY_PREGNANCY_TYPE] != 0) return; //Must be a new format save
			flags[kFLAGS.KELLY_PREGNANCY_TYPE] = PregnancyStore.PREGNANCY_PLAYER;
		}

		if (flags[kFLAGS.MARBLE_PREGNANCY_TYPE] == PregnancyStore.PREGNANCY_PLAYER) return; //Must be a new format save
		if (flags[kFLAGS.MARBLE_PREGNANCY_TYPE] == PregnancyStore.PREGNANCY_OVIELIXIR_EGGS) return; //Must be a new format save
		if (flags[kFLAGS.MARBLE_PREGNANCY_TYPE] == 1) flags[kFLAGS.MARBLE_PREGNANCY_TYPE] = PregnancyStore.PREGNANCY_PLAYER;
		if (flags[kFLAGS.MARBLE_PREGNANCY_TYPE] == 2) flags[kFLAGS.MARBLE_PREGNANCY_TYPE] = PregnancyStore.PREGNANCY_OVIELIXIR_EGGS;

		if (flags[kFLAGS.PHYLLA_DRIDER_INCUBATION] > 0) {
			if (flags[kFLAGS.PHYLLA_VAGINAL_PREGNANCY_TYPE] != 0) return; //Must be a new format save
			flags[kFLAGS.PHYLLA_VAGINAL_PREGNANCY_TYPE] = PregnancyStore.PREGNANCY_DRIDER_EGGS;
			flags[kFLAGS.PHYLLA_DRIDER_INCUBATION] *= 24; //Convert pregnancy to days
		}

		if (flags[kFLAGS.SHEILA_PREGNANCY_INCUBATION] > 0) {
			if (flags[kFLAGS.SHEILA_PREGNANCY_TYPE] != 0) return; //Must be a new format save
			flags[kFLAGS.SHEILA_PREGNANCY_TYPE] = PregnancyStore.PREGNANCY_PLAYER;
			if (flags[kFLAGS.SHEILA_PREGNANCY_INCUBATION] >= 4)
				flags[kFLAGS.SHEILA_PREGNANCY_INCUBATION] = 0; //Was ready to be born
			else
				flags[kFLAGS.SHEILA_PREGNANCY_INCUBATION] = 24 * (4 - flags[kFLAGS.SHEILA_PREGNANCY_INCUBATION]); //Convert to hours and count down rather than up
		}

		if (flags[kFLAGS.SOPHIE_PREGNANCY_TYPE] != 0 && flags[kFLAGS.SOPHIE_INCUBATION] != 0) return; //Must be a new format save
		if (flags[kFLAGS.SOPHIE_PREGNANCY_TYPE] > 0 && flags[kFLAGS.SOPHIE_INCUBATION] == 0) { //She's in the wild and pregnant with an egg
			flags[kFLAGS.SOPHIE_INCUBATION] = flags[kFLAGS.SOPHIE_PREGNANCY_TYPE]; //SOPHIE_PREGNANCY_TYPE was previously SOPHIE_WILD_EGG_COUNTDOWN_TIMER
			flags[kFLAGS.SOPHIE_PREGNANCY_TYPE] = PregnancyStore.PREGNANCY_PLAYER;
		}
		else if (flags[kFLAGS.SOPHIE_PREGNANCY_TYPE] == 0 && flags[kFLAGS.SOPHIE_INCUBATION] > 0) {
			flags[kFLAGS.SOPHIE_PREGNANCY_TYPE] = PregnancyStore.PREGNANCY_PLAYER;
		}

		if (flags[kFLAGS.TAMANI_DAUGHTERS_PREGNANCY_TYPE] != 0) return; //Must be a new format save
		if (flags[kFLAGS.TAMANI_DAUGHTER_PREGGO_COUNTDOWN] > 0) {
			flags[kFLAGS.TAMANI_DAUGHTERS_PREGNANCY_TYPE]   = PregnancyStore.PREGNANCY_PLAYER;
			flags[kFLAGS.TAMANI_DAUGHTER_PREGGO_COUNTDOWN] *= 24; //Convert pregnancy to days
			flags[kFLAGS.TAMANI_DAUGHTERS_PREGNANCY_COUNT]  = player.statusEffectv3(StatusEffects.Tamani);
		}

		if (flags[kFLAGS.TAMANI_PREGNANCY_TYPE] != 0) return; //Must be a new format save
		if (player.hasStatusEffect(StatusEffects.TamaniFemaleEncounter)) player.removeStatusEffect(StatusEffects.TamaniFemaleEncounter); //Wasn't used in previous code
		if (player.hasStatusEffect(StatusEffects.Tamani)) {
			if (player.statusEffectv1(StatusEffects.Tamani) == -500) { //This used to indicate that a player had met Tamani as a male
				flags[kFLAGS.TAMANI_PREGNANCY_INCUBATION] = 0;
				flags[kFLAGS.TAMANI_MET]                  = 1; //This now indicates the same thing
			}
			else flags[kFLAGS.TAMANI_PREGNANCY_INCUBATION] = player.statusEffectv1(StatusEffects.Tamani) * 24; //Convert pregnancy to days
			flags[kFLAGS.TAMANI_NUMBER_OF_DAUGHTERS] = player.statusEffectv2(StatusEffects.Tamani);
			flags[kFLAGS.TAMANI_PREGNANCY_COUNT]     = player.statusEffectv3(StatusEffects.Tamani);
			flags[kFLAGS.TAMANI_TIMES_IMPREGNATED]   = player.statusEffectv4(StatusEffects.Tamani);
			if (flags[kFLAGS.TAMANI_PREGNANCY_INCUBATION] > 0) flags[kFLAGS.TAMANI_PREGNANCY_TYPE] = PregnancyStore.PREGNANCY_PLAYER;
			player.removeStatusEffect(StatusEffects.Tamani);
		}

		if (flags[kFLAGS.EGG_WITCH_TYPE] == PregnancyStore.PREGNANCY_BEE_EGGS || flags[kFLAGS.EGG_WITCH_TYPE] == PregnancyStore.PREGNANCY_DRIDER_EGGS) return; //Must be a new format save
		if (flags[kFLAGS.EGG_WITCH_TYPE] > 0) {
			if (flags[kFLAGS.EGG_WITCH_TYPE] == 1)
				flags[kFLAGS.EGG_WITCH_TYPE] = PregnancyStore.PREGNANCY_BEE_EGGS;
			else
				flags[kFLAGS.EGG_WITCH_TYPE] = PregnancyStore.PREGNANCY_DRIDER_EGGS;
			flags[kFLAGS.EGG_WITCH_COUNTER] = 24 * (8 - flags[kFLAGS.EGG_WITCH_COUNTER]); //Reverse the count and change to hours rather than days
		}

		if (player.buttPregnancyType == PregnancyStore.PREGNANCY_BEE_EGGS) return; //Must be a new format save
		if (player.buttPregnancyType == PregnancyStore.PREGNANCY_DRIDER_EGGS) return; //Must be a new format save
		if (player.buttPregnancyType == PregnancyStore.PREGNANCY_SANDTRAP_FERTILE) return; //Must be a new format save
		if (player.buttPregnancyType == PregnancyStore.PREGNANCY_SANDTRAP) return; //Must be a new format save
		if (player.buttPregnancyType == 2) player.buttKnockUpForce(PregnancyStore.PREGNANCY_BEE_EGGS, player.buttPregnancyIncubation);
		if (player.buttPregnancyType == 3) player.buttKnockUpForce(PregnancyStore.PREGNANCY_DRIDER_EGGS, player.buttPregnancyIncubation);
		if (player.buttPregnancyType == 4) player.buttKnockUpForce(PregnancyStore.PREGNANCY_SANDTRAP_FERTILE, player.buttPregnancyIncubation);
		if (player.buttPregnancyType == 5) player.buttKnockUpForce(PregnancyStore.PREGNANCY_SANDTRAP, player.buttPregnancyIncubation);

		//If dick length zero then player has never met Kath, no need to set flags. If her breast size is zero then set values for flags introduced with the employment expansion
		if (flags[kFLAGS.KATHERINE_BREAST_SIZE] != 0) return; //Must be a new format save
		if (flags[kFLAGS.KATHERINE_DICK_LENGTH] != 0) {
			flags[kFLAGS.KATHERINE_BREAST_SIZE] = BreastCup.B;
			flags[kFLAGS.KATHERINE_BALL_SIZE] = 1;
			flags[kFLAGS.KATHERINE_HAIR_COLOR] = "neon pink";
			flags[kFLAGS.KATHERINE_HOURS_SINCE_CUM] = 200; //Give her maxed out cum for that first time
		}

		if (flags[kFLAGS.URTA_PREGNANCY_TYPE] == PregnancyStore.PREGNANCY_BEE_EGGS) return; //Must be a new format save
		if (flags[kFLAGS.URTA_PREGNANCY_TYPE] == PregnancyStore.PREGNANCY_DRIDER_EGGS) return; //Must be a new format save
		if (flags[kFLAGS.URTA_PREGNANCY_TYPE] == PregnancyStore.PREGNANCY_PLAYER) return; //Must be a new format save
		if (flags[kFLAGS.URTA_PREGNANCY_TYPE] > 0) { //URTA_PREGNANCY_TYPE was previously URTA_EGG_INCUBATION, assume this was an egg pregnancy
			flags[kFLAGS.URTA_INCUBATION] = flags[kFLAGS.URTA_PREGNANCY_TYPE];
			if (player.hasPerk(PerkLib.SpiderOvipositor))
				flags[kFLAGS.URTA_PREGNANCY_TYPE] = PregnancyStore.PREGNANCY_DRIDER_EGGS;
			else
				flags[kFLAGS.URTA_PREGNANCY_TYPE] = PregnancyStore.PREGNANCY_BEE_EGGS;
		}
		else if (flags[kFLAGS.URTA_INCUBATION] > 0) { //Assume Urta was pregnant with the player's baby
			flags[kFLAGS.URTA_PREGNANCY_TYPE] = PregnancyStore.PREGNANCY_PLAYER;
			flags[kFLAGS.URTA_INCUBATION] = 384 - flags[kFLAGS.URTA_INCUBATION]; //Reverse the pregnancy counter since it now counts down rather than up
		}

		if (flags[kFLAGS.EDRYN_PREGNANCY_TYPE] > 0 && flags[kFLAGS.EDRYN_PREGNANCY_INCUBATION] == 0) {
			//EDRYN_PREGNANCY_TYPE was previously EDRYN_BIRF_COUNTDOWN - used when Edryn was pregnant with Taoth
			if (flags[kFLAGS.EDRYN_PREGNANCY_INCUBATION] > 0)
				flags[kFLAGS.URTA_FERTILE] = PregnancyStore.PREGNANCY_PLAYER;          //These two variables are used to store information on the pregnancy Taoth
			flags[kFLAGS.URTA_PREG_EVERYBODY] = flags[kFLAGS.EDRYN_PREGNANCY_INCUBATION]; //is overriding (if any), so they can later be restored.
			flags[kFLAGS.EDRYN_PREGNANCY_INCUBATION] = flags[kFLAGS.EDRYN_PREGNANCY_TYPE];
			flags[kFLAGS.EDRYN_PREGNANCY_TYPE] = PregnancyStore.PREGNANCY_TAOTH;
		}
		else if (flags[kFLAGS.EDRYN_PREGNANCY_INCUBATION] > 0 && flags[kFLAGS.EDRYN_PREGNANCY_TYPE] == 0) flags[kFLAGS.EDRYN_PREGNANCY_TYPE] = PregnancyStore.PREGNANCY_PLAYER;
	}
	if (flags[kFLAGS.BEHEMOTH_CHILDREN] > 0) {
		if (flags[kFLAGS.BEHEMOTH_CHILDREN] >= 1 && flags[kFLAGS.BEHEMOTH_CHILD_1_BIRTH_DAY] <= 0) flags[kFLAGS.BEHEMOTH_CHILD_1_BIRTH_DAY] = model.time.days;
		if (flags[kFLAGS.BEHEMOTH_CHILDREN] >= 2 && flags[kFLAGS.BEHEMOTH_CHILD_2_BIRTH_DAY] <= 0) flags[kFLAGS.BEHEMOTH_CHILD_2_BIRTH_DAY] = model.time.days;
		if (flags[kFLAGS.BEHEMOTH_CHILDREN] >= 3 && flags[kFLAGS.BEHEMOTH_CHILD_3_BIRTH_DAY] <= 0) flags[kFLAGS.BEHEMOTH_CHILD_3_BIRTH_DAY] = model.time.days;
	}
	if ((flags[kFLAGS.D3_GARDENER_DEFEATED] > 0 && flags[kFLAGS.D3_CENTAUR_DEFEATED] > 0 && flags[kFLAGS.D3_STATUE_DEFEATED] > 0) && flags[kFLAGS.D3_JEAN_CLAUDE_DEFEATED] == 0) flags[kFLAGS.D3_JEAN_CLAUDE_DEFEATED] = 1;
	if (pearlStorageGet().length < 98) {
		while (pearlStorageGet().length < 98) {
			pearlStorageGet().push(new ItemSlotClass());
		}
	}
	if (gearStorageGet().length < 90) {
		while (gearStorageGet().length < 90) {
			gearStorageGet().push(new ItemSlotClass());
		}
	}
	if (player.hasKeyItem("Laybans") >= 0) {
		flags[kFLAGS.D3_MIRRORS_SHATTERED] = 1;
	}
	shiftKeyDown = false;
}

    private function saveAllAwareClasses(game:CoC):void {
        for (var sac:int = 0; sac < _saveAwareClassList.length; sac++) _saveAwareClassList[sac].updateBeforeSave(game);
    }

    private function loadAllAwareClasses(game:CoC):void {
        for (var sac:int = 0; sac < _saveAwareClassList.length; sac++) _saveAwareClassList[sac].updateAfterLoad(game);
    }

    public static function saveAwareClassAdd(newEntry:SaveAwareInterface):void {
        _saveAwareClassList.push(newEntry);
    }

	public static function registerSaveableState(ss:SaveableState):void {
		var name:String = ss.stateObjectName();
		if (name in _saveableStates && _saveableStates[name] != ss) throw new Error("Duplicate saveable state named "+name);
		_saveableStates[name] = ss;
	}
	public function resetSaveableStates():void {
		for (var key:String in _saveableStates) {
			var ss:SaveableState = _saveableStates[key];
			ss.resetState();
		}
	}

}
}
