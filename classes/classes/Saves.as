package classes
{

	import classes.GlobalFlags.kGAMECLASS;
	import classes.Scenes.Inventory;
	import classes.Scenes.Places.TelAdre.Katherine;

	CONFIG::AIR 
	{
		import flash.filesystem.File;
		import flash.filesystem.FileMode;
		import flash.filesystem.FileStream;
	}
	
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	import flash.net.URLLoader;
	import flash.net.SharedObject;
	import flash.events.MouseEvent;
	import flash.events.IOErrorEvent;
	import classes.Items.*;
	import classes.GlobalFlags.kFLAGS;
	import flash.net.URLLoaderDataFormat;


public class Saves extends BaseContent {

	private static const SAVE_FILE_CURRENT_INTEGER_FORMAT_VERSION:int		= 816;
		//Didn't want to include something like this, but an integer is safer than depending on the text version number from the CoC class.
		//Also, this way the save file version doesn't need updating unless an important structural change happens in the save file.
	
	private var gameStateGet:Function;
	private var gameStateSet:Function;
	private var itemStorageGet:Function;
	private var gearStorageGet:Function;
	
	public function Saves(gameStateDirectGet:Function, gameStateDirectSet:Function) {
		gameStateGet = gameStateDirectGet; //This is so that the save game functions (and nothing else) get direct access to the gameState variable
		gameStateSet = gameStateDirectSet;
	}

	public function linkToInventory(itemStorageDirectGet:Function, gearStorageDirectGet:Function):void {
		itemStorageGet = itemStorageDirectGet;
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

public function cloneObj(obj:Object):Object
{
	var temp:ByteArray = new ByteArray();
	temp.writeObject(obj);
	temp.position = 0;
	return temp.readObject();
}

public function getClass(obj:Object):Class
{
	return Class(flash.utils.getDefinitionByName(flash.utils.getQualifiedClassName(obj)));
}

//ASSetPropFlags(Object.prototype, ["clone"], 1);

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
				if (saveFile.data.flags[kFLAGS.GAME_DIFFICULTY] >= 3)
					holding += "<font color=\"#FF0000\">EXTREME</font>";
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
		outputText("Error reading save directory: " + airSaveDir.url + " (" + error.message + ")", true);
		return;		
	}
	outputText("<b><u>Slot: Sex,  Game Days Played</u></b>\r", true);
	
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
		outputText(loadSaveDisplay(gameObjects[i], String(i+1)), false);
				
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
	var s:int = 0
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
		outputText("Failed to read save file, " + aFile.url + " (" + error.message + ")", true);
	}
	return null;
 }

}

public function loadScreen():void
{
	var slots:Array = new Array(saveFileNames.length);
		
	outputText("<b><u>Slot: Sex,  Game Days Played</u></b>\r", true);
	
	for (var i:int = 0; i < saveFileNames.length; i += 1)
	{
		var test:Object = SharedObject.getLocal(saveFileNames[i], "/");
		outputText(loadSaveDisplay(test, String(i + 1)), false);
		if (test.data.exists/* && test.data.flags[2066] == undefined*/)
		{
			//trace("Creating function with indice = ", i);
			(function(i:int):void		// messy hack to work around closures. See: http://en.wikipedia.org/wiki/Immediately-invoked_function_expression
			{
				slots[i] = function() : void 		// Anonymous functions FTW
				{
					trace("Loading save with name", saveFileNames[i], "at index", i);
					if (loadGame(saveFileNames[i])) 
					{
						doNext(playerMenu);
						showStats();
						statScreenRefresh();
						outputText("Slot " + i + " Loaded!", true);
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
	var s:int = 0
	while (s < 14) {
		if (slots[s] != 0) addButton(s, "Slot " + (s+1), slots[s]);
		s++;
	}
	addButton(14, "Back", returnToSaveMenu);
}

public function saveScreen():void
{
	mainView.nameBox.x = 210;
	mainView.nameBox.y = 620;
	mainView.nameBox.width = 550;
	mainView.nameBox.text = "";
	mainView.nameBox.visible = true;
	
	// var test; // Disabling this variable because it seems to be unused.
	if (flags[kFLAGS.HARDCORE_MODE] > 0)
	{
		saveGame(flags[kFLAGS.HARDCORE_SLOT])
		outputText("You may not create copies of Hardcore save files! Your current progress has been saved.", true);
		doNext(playerMenu);
		return;
	}
	
	clearOutput();
	if (player.slotName != "VOID")
		outputText("<b>Last saved or loaded from: " + player.slotName + "</b>\r\r", false);
	outputText("<b><u>Slot: Sex,  Game Days Played</u></b>\r", false);
	
	var saveFuncs:Array = [];
	
	
	for (var i:int = 0; i < saveFileNames.length; i += 1)
	{
		var test:Object = SharedObject.getLocal(saveFileNames[i], "/");
		outputText(loadSaveDisplay(test, String(i + 1)), false);
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
		outputText("\r\r", false);
	
	outputText("<b>Leave the notes box blank if you don't wish to change notes.\r<u>NOTES:</u></b>", false);
	menu();
	var s:int = 0
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
	var autoSaveSuffix:String = ""
	if (player.autoSave) autoSaveSuffix = "ON";
	else autoSaveSuffix = "OFF";
	
	clearOutput();
	outputText("<b>Where are my saves located?</b>\n", false);
	outputText("<i>In Windows Vista/7 (IE/FireFox/Other): <pre>Users/{username}/Appdata/Roaming/Macromedia/Flash Player/#Shared Objects/{GIBBERISH}/</pre>\n\n", false);
	outputText("In Windows Vista/7 (Chrome): <pre>Users/{username}/AppData/Local/Google/Chrome/User Data/Default/Pepper Data/Shockwave Flash/WritableRoot/#SharedObjects/{GIBBERISH}/</pre>\n\n", false);
	outputText("Inside that folder it will saved in a folder corresponding to where it was played from.  If you saved the CoC.swf to your HDD, then it will be in a folder called localhost.  If you played from my website, it will be in fenoxo.com.  The save files will be labelled CoC_1.sol, CoC_2.sol, CoC_3.sol, etc.</i>\n\n", false);
	outputText("<b>Why do my saves disappear all the time?</b>\n<i>There are numerous things that will wipe out flash local shared files.  If your browser or player is set to delete flash cookies or data, that will do it.  CCleaner will also remove them.  CoC or its updates will never remove your savegames - if they disappear something else is wiping them out.</i>\n\n", false);
	outputText("<b>When I play from my HDD I have one set of saves, and when I play off your site I have a different set of saves.  Why?</b>\n<i>Flash stores saved data relative to where it was accessed from.  Playing from your HDD will store things in a different location than fenoxo.com or FurAffinity.</i>\n", false);
	outputText("<i>If you want to be absolutely sure you don't lose a character, copy the .sol file for that slot out and back it up! <b>For more information, google flash shared objects.</b></i>\n\n", false);
	outputText("<b>Why does the Save File and Load File option not work?</b>\n");
	outputText("<i>Save File and Load File are limited by the security settings imposed upon CoC by Flash. These options will only work if you have downloaded the game from the website, and are running it from your HDD. Additionally, they can only correctly save files to and load files from the directory where you have the game saved.</i>");
	//This is to clear the 'game over' block from stopping simpleChoices from working.  Loading games supercede's game over.
	if (mainView.getButtonText( 0 ) == "Game Over")
	{
		temp = 777;
		mainView.setButtonText( 0, "save/load" );
	}
	menu();
	//addButton(0, "Save", saveScreen);
	addButton(1, "Load", loadScreen);
	addButton(2, "Delete", deleteScreen);
	//addButton(5, "Save to File", saveToFile);
	addButton(6, "Load File", loadFromFile);
	//addButton(8, "AutoSave: " + autoSaveSuffix, autosaveToggle);
	addButton(14, "Back", kGAMECLASS.gameOver, true);
	
	
	if (temp == 777) {
		addButton(14, "Back", kGAMECLASS.gameOver, true);
		return;
	}
	if (player.str == 0) {
		addButton(14, "Back", kGAMECLASS.mainMenu);
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
		addButton(14, "Back", kGAMECLASS.mainMenu);
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

private function loadFromFile():void {
	openSave();
	showStats();
	statScreenRefresh();
}

private function autosaveToggle():void {
	player.autoSave = !player.autoSave;
	saveLoad();
}

public function deleteScreen():void
{
	outputText("Slot,  Race,  Sex,  Game Days Played\n", true);
	

	var delFuncs:Array = [];
	
	
	for (var i:int = 0; i < saveFileNames.length; i += 1)
	{
		var test:Object = SharedObject.getLocal(saveFileNames[i], "/");
		outputText(loadSaveDisplay(test, String(i + 1)), false);
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
	
	outputText("\n<b>ONCE DELETED, YOUR SAVE IS GONE FOREVER.</b>", false);
	menu();
	var s:int = 0
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
	outputText("You are about to delete the following save: <b>" + flags[kFLAGS.TEMP_STORAGE_SAVE_DELETION] + "</b>\n\nAre you sure you want to delete it?", true);
	simpleChoices("No", deleteScreen, "Yes", purgeTheMutant, "", null, "", null, "", null);
}

public function purgeTheMutant():void
{
	var test:* = SharedObject.getLocal(flags[kFLAGS.TEMP_STORAGE_SAVE_DELETION], "/");
	trace("DELETING SLOT: " + flags[kFLAGS.TEMP_STORAGE_SAVE_DELETION]);
	var blah:Array = ["been virus bombed", "been purged", "been vaped", "been nuked from orbit", "taken an arrow to the knee", "fallen on its sword", "lost its reality matrix cohesion", "been cleansed", "suffered the following error: (404) Porn Not Found", "been deleted"];
	
	trace(blah.length + " array slots");
	var select:Number = rand(blah.length);
	outputText(flags[kFLAGS.TEMP_STORAGE_SAVE_DELETION] + " has " + blah[select] + ".", true);
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
		outputText("<b>Aborting load.  The current save file is missing a number of expected properties.</b>\n\n", true);
		
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
		outputText("Game Loaded");
		temp = 0;
		
		if (player.slotName == "VOID")
		{
			trace("Setting in-use save slot to: " + slot);
			player.slotName = slot;
		}
		loadPermObject();
		statScreenRefresh();
		doNext(playerMenu);
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
		var i:int
		//flag settings
		saveFile.data.flags = [];
		for (i = 0; i < achievements.length; i++) {
			if (flags[i] != 0)
			{
				saveFile.data.flags[i] = 0;
			}			
		}
		saveFile.data.flags[kFLAGS.NEW_GAME_PLUS_BONUS_UNLOCKED_HERM] = flags[kFLAGS.NEW_GAME_PLUS_BONUS_UNLOCKED_HERM];
		
		saveFile.data.flags[kFLAGS.SHOW_SPRITES_FLAG] = flags[kFLAGS.SHOW_SPRITES_FLAG];
		saveFile.data.flags[kFLAGS.SILLY_MODE_ENABLE_FLAG] = flags[kFLAGS.SILLY_MODE_ENABLE_FLAG];
		saveFile.data.flags[kFLAGS.WATERSPORTS_ENABLED] = flags[kFLAGS.WATERSPORTS_ENABLED];
		
		saveFile.data.flags[kFLAGS.USE_OLD_INTERFACE] = flags[kFLAGS.USE_OLD_INTERFACE];
		saveFile.data.flags[kFLAGS.USE_OLD_FONT] = flags[kFLAGS.USE_OLD_FONT];
		saveFile.data.flags[kFLAGS.BACKGROUND_STYLE] = flags[kFLAGS.BACKGROUND_STYLE];
		saveFile.data.flags[kFLAGS.IMAGEPACK_OFF] = flags[kFLAGS.IMAGEPACK_OFF];
		saveFile.data.flags[kFLAGS.SPRITE_STYLE] = flags[kFLAGS.SPRITE_STYLE];
		saveFile.data.flags[kFLAGS.SFW_MODE] = flags[kFLAGS.SFW_MODE];
		saveFile.data.flags[kFLAGS.WATERSPORTS_ENABLED] = flags[kFLAGS.WATERSPORTS_ENABLED];
		saveFile.data.flags[kFLAGS.USE_12_HOURS] = flags[kFLAGS.USE_12_HOURS];
		saveFile.data.flags[kFLAGS.AUTO_LEVEL] = flags[kFLAGS.AUTO_LEVEL];
		saveFile.data.flags[kFLAGS.USE_METRICS] = flags[kFLAGS.USE_METRICS];
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
	trace("Loading achievements!")
	//Initialize the save file
	//var saveFile:Object = loader.data.readObject();
	if (saveFile.data.exists)
	{
		//Load saved flags.
		if (saveFile.data.flags) {
			if (saveFile.data.flags[kFLAGS.NEW_GAME_PLUS_BONUS_UNLOCKED_HERM] != undefined) flags[kFLAGS.NEW_GAME_PLUS_BONUS_UNLOCKED_HERM] = saveFile.data.flags[kFLAGS.NEW_GAME_PLUS_BONUS_UNLOCKED_HERM];
			
			if (saveFile.data.flags[kFLAGS.SHOW_SPRITES_FLAG] != undefined) flags[kFLAGS.SHOW_SPRITES_FLAG] = saveFile.data.flags[kFLAGS.SHOW_SPRITES_FLAG];
			if (saveFile.data.flags[kFLAGS.SILLY_MODE_ENABLE_FLAG] != undefined) flags[kFLAGS.SILLY_MODE_ENABLE_FLAG] = saveFile.data.flags[kFLAGS.SILLY_MODE_ENABLE_FLAG];
			
			if (saveFile.data.flags[kFLAGS.USE_OLD_INTERFACE] != undefined) flags[kFLAGS.USE_OLD_INTERFACE] = saveFile.data.flags[kFLAGS.USE_OLD_INTERFACE];
			if (saveFile.data.flags[kFLAGS.USE_OLD_FONT] != undefined) flags[kFLAGS.USE_OLD_FONT] = saveFile.data.flags[kFLAGS.USE_OLD_FONT];
			if (saveFile.data.flags[kFLAGS.BACKGROUND_STYLE] != undefined) flags[kFLAGS.BACKGROUND_STYLE] = saveFile.data.flags[kFLAGS.BACKGROUND_STYLE];
			if (saveFile.data.flags[kFLAGS.IMAGEPACK_OFF] != undefined) flags[kFLAGS.IMAGEPACK_OFF] = saveFile.data.flags[kFLAGS.IMAGEPACK_OFF];
			if (saveFile.data.flags[kFLAGS.SPRITE_STYLE] != undefined) flags[kFLAGS.SPRITE_STYLE] = saveFile.data.flags[kFLAGS.SPRITE_STYLE];
			if (saveFile.data.flags[kFLAGS.SFW_MODE] != undefined) flags[kFLAGS.SFW_MODE] = saveFile.data.flags[kFLAGS.SFW_MODE];
			if (saveFile.data.flags[kFLAGS.WATERSPORTS_ENABLED] != undefined) flags[kFLAGS.WATERSPORTS_ENABLED] = saveFile.data.flags[kFLAGS.WATERSPORTS_ENABLED];
			if (saveFile.data.flags[kFLAGS.USE_12_HOURS] != undefined) flags[kFLAGS.USE_12_HOURS] = saveFile.data.flags[kFLAGS.USE_12_HOURS];
			if (saveFile.data.flags[kFLAGS.AUTO_LEVEL] != undefined) flags[kFLAGS.AUTO_LEVEL] = saveFile.data.flags[kFLAGS.AUTO_LEVEL];
			if (saveFile.data.flags[kFLAGS.USE_METRICS] != undefined) flags[kFLAGS.USE_METRICS] = saveFile.data.flags[kFLAGS.USE_METRICS];
		}
		//achievements, will check if achievement exists.
		if (saveFile.data.achievements) {
			for (var i:int = 0; i < achievements.length; i++)
			{
				if (saveFile.data.achievements[i] != undefined)
					achievements[i] = saveFile.data.achievements[i];
			}
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
	
	CoC.saveAllAwareClasses(getGame()); //Informs each saveAwareClass that it must save its values in the flags array
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
				
		//CLOTHING/ARMOR
		saveFile.data.armorId = player.armor.id;
		saveFile.data.weaponId = player.weapon.id;
		saveFile.data.jewelryId = player.jewelry.id;
		saveFile.data.shieldId = player.shield.id;
		saveFile.data.upperGarmentId = player.upperGarment.id;
		saveFile.data.lowerGarmentId = player.lowerGarment.id;
		saveFile.data.armorName = player.modArmorName;
		
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
		
		//MAIN STATS
		saveFile.data.str = player.str;
		saveFile.data.tou = player.tou;
		saveFile.data.spe = player.spe;
		saveFile.data.inte = player.inte;
		saveFile.data.lib = player.lib;
		saveFile.data.sens = player.sens;
		saveFile.data.cor = player.cor;
		saveFile.data.fatigue = player.fatigue;
		//Combat STATS
		saveFile.data.HP = player.HP;
		saveFile.data.lust = player.lust;
		saveFile.data.teaseLevel = player.teaseLevel;
		saveFile.data.teaseXP = player.teaseXP;
		//Prison STATS
		saveFile.data.hunger = player.hunger;
		saveFile.data.esteem = player.esteem;
		saveFile.data.obey = player.obey;
		saveFile.data.obeySoftCap = player.obeySoftCap;
		saveFile.data.will = player.will;
		
		saveFile.data.prisonItems = player.prisonItemSlots;
		//saveFile.data.prisonArmor = prison.prisonItemSlotArmor;
		//saveFile.data.prisonWeapon = prison.prisonItemSlotWeapon;
		//LEVEL STATS
		saveFile.data.XP = player.XP;
		saveFile.data.level = player.level;
		saveFile.data.gems = player.gems;
		saveFile.data.perkPoints = player.perkPoints;
		saveFile.data.statPoints = player.statPoints;
		saveFile.data.ascensionPerkPoints = player.ascensionPerkPoints;
		//Appearance
		saveFile.data.startingRace = player.startingRace;
		saveFile.data.gender = player.gender;
		saveFile.data.femininity = player.femininity;
		saveFile.data.thickness = player.thickness;
		saveFile.data.tone = player.tone;
		saveFile.data.tallness = player.tallness;
		saveFile.data.furColor = player.furColor;
		saveFile.data.hairColor = player.hairColor;
		saveFile.data.hairType = player.hairType;
		saveFile.data.gills = player.gills;
		saveFile.data.armType = player.armType;
		saveFile.data.hairLength = player.hairLength;
		saveFile.data.beardLength = player.beardLength;
		saveFile.data.eyeType = player.eyeType;
		saveFile.data.beardStyle = player.beardStyle;
		saveFile.data.skinType = player.skinType;
		saveFile.data.skinTone = player.skinTone;
		saveFile.data.skinDesc = player.skinDesc;
		saveFile.data.skinAdj = player.skinAdj;
		saveFile.data.faceType = player.faceType;
		saveFile.data.tongueType = player.tongueType;
		saveFile.data.earType = player.earType;
		saveFile.data.earValue = player.earValue;
		saveFile.data.antennae = player.antennae;
		saveFile.data.horns = player.horns;
		saveFile.data.hornType = player.hornType;
		// <mod name="Predator arms" author="Stadler">
		saveFile.data.clawTone = player.clawTone;
		saveFile.data.clawType = player.clawType;
		// </mod>
		saveFile.data.wingDesc = player.wingDesc;
		saveFile.data.wingType = player.wingType;
		saveFile.data.lowerBody = player.lowerBody;
		saveFile.data.legCount = player.legCount;
		saveFile.data.tailType = player.tailType;
		saveFile.data.tailVenum = player.tailVenom;
		saveFile.data.tailRecharge = player.tailRecharge;
		saveFile.data.hipRating = player.hipRating;
		saveFile.data.buttRating = player.buttRating;
		
		//Sexual Stuff
		saveFile.data.balls = player.balls;
		saveFile.data.cumMultiplier = player.cumMultiplier;
		saveFile.data.ballSize = player.ballSize;
		saveFile.data.hoursSinceCum = player.hoursSinceCum;
		saveFile.data.fertility = player.fertility;
		saveFile.data.clitLength = player.clitLength;
		
		//Preggo stuff
		saveFile.data.pregnancyIncubation = player.pregnancyIncubation;
		saveFile.data.pregnancyType = player.pregnancyType;
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
		//Set Perk Array
		//Populate Perk Array
		for (i = 0; i < player.perks.length; i++)
		{
			saveFile.data.perks.push([]);
			//trace("Saveone Perk");
			//trace("Populate One Perk");
			saveFile.data.perks[i].id = player.perk(i).ptype.id;
			//saveFile.data.perks[i].perkName = player.perk(i).ptype.id; //uncomment for backward compatibility
			saveFile.data.perks[i].value1 = player.perk(i).value1;
			saveFile.data.perks[i].value2 = player.perk(i).value2;
			saveFile.data.perks[i].value3 = player.perk(i).value3;
			saveFile.data.perks[i].value4 = player.perk(i).value4;
			//saveFile.data.perks[i].perkDesc = player.perk(i).perkDesc; // uncomment for backward compatibility
		}
		
		//Set Status Array
		for (i = 0; i < player.statusEffects.length; i++)
		{
			saveFile.data.statusAffects.push([]);
				//trace("Saveone statusEffects");
		}
		//Populate Status Array
		for (i = 0; i < player.statusEffects.length; i++)
		{
			//trace("Populate One statusEffects");
			saveFile.data.statusAffects[i].statusAffectName = player.statusEffect(i).stype.id;
			saveFile.data.statusAffects[i].value1 = player.statusEffect(i).value1;
			saveFile.data.statusAffects[i].value2 = player.statusEffect(i).value2;
			saveFile.data.statusAffects[i].value3 = player.statusEffect(i).value3;
			saveFile.data.statusAffects[i].value4 = player.statusEffect(i).value4;
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
		//Set storage slot array
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
		saveFile.data.ass.push([]);
		saveFile.data.ass.analWetness = player.ass.analWetness;
		saveFile.data.ass.analLooseness = player.ass.analLooseness;
		saveFile.data.ass.fullness = player.ass.fullness;
		//EXPLORED
		saveFile.data.exploredLake = player.exploredLake;
		saveFile.data.exploredMountain = player.exploredMountain;
		saveFile.data.exploredForest = player.exploredForest;
		saveFile.data.exploredDesert = player.exploredDesert;
		saveFile.data.explored = player.explored;
		saveFile.data.foundForest = getGame().foundForest;
		saveFile.data.foundDesert = getGame().foundDesert;
		saveFile.data.foundMountain = getGame().foundMountain;
		saveFile.data.foundLake = getGame().foundLake;
		saveFile.data.gameState = gameStateGet();
		
		//Time and Items
		saveFile.data.minutes = model.time.minutes;
		saveFile.data.hours = model.time.hours;
		saveFile.data.days = model.time.days;
		saveFile.data.autoSave = player.autoSave;
		
		//PLOTZ
		saveFile.data.whitney = getGame().whitney;
		saveFile.data.monk = getGame().monk;
		saveFile.data.sand = getGame().sand;
		saveFile.data.giacomo = getGame().giacomo;
		saveFile.data.beeProgress = 0; //Now saved in a flag. getGame().beeProgress;
		
		saveFile.data.isabellaOffspringData = [];
		for (i = 0; i < kGAMECLASS.isabellaScene.isabellaOffspringData.length; i++) {
			saveFile.data.isabellaOffspringData.push(kGAMECLASS.isabellaScene.isabellaOffspringData[i]);
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
		saveFile.data.itemSlot4.unlocked = player.itemSlot4.unlocked;
		
		saveFile.data.itemSlot5 = [];
		saveFile.data.itemSlot5.quantity = player.itemSlot5.quantity;
		saveFile.data.itemSlot5.id = player.itemSlot5.itype.id;
		saveFile.data.itemSlot5.unlocked = player.itemSlot5.unlocked;
		
		saveFile.data.itemSlot6 = [];
		saveFile.data.itemSlot6.quantity = player.itemSlot6.quantity;
		saveFile.data.itemSlot6.id = player.itemSlot6.itype.id;
		saveFile.data.itemSlot6.unlocked = player.itemSlot6.unlocked;
		
		saveFile.data.itemSlot7 = [];
		saveFile.data.itemSlot7.quantity = player.itemSlot7.quantity;
		saveFile.data.itemSlot7.id = player.itemSlot7.itype.id;
		saveFile.data.itemSlot7.unlocked = player.itemSlot7.unlocked;
		
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

		
		// Keybinds
		saveFile.data.controls = getGame().inputManager.SaveBindsToObj();
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
				outputText("Saved to file: " + airFile.url, true);
				doNext(playerMenu);
			}
			catch (error:Error)
			{
				backupAborted = true;
				outputText("Failed to write to file: " + airFile.url + " (" + error.message + ")", true);
				doNext(playerMenu);
			}
		}
		CONFIG::STANDALONE
		{
			file = new FileReference();
			file.save(bytes, null);
			outputText("Attempted to save to file.", true);
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
			outputText("<b>Aborting save.  Your current save file is broken, and needs to be bug-reported.</b>\n\nWithin the save folder for CoC, there should be a pair of files named \"" + slot + ".sol\" and \"" + slot + "_backup.sol\"\n\n<b>We need BOTH of those files, and a quick report of what you've done in the game between when you last saved, and this message.</b>\n\n", true);
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
		
		if (!backupAborted)
			outputText("Saved to slot" + slot + "!", true);
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
	
	outputText("Restored backup of " + slotName, true);
	menu();
	doNext(playerMenu);
}

public function openSave():void
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
		outputText("<b>!</b> Save file not found, check that it is in the same directory as the CoC.swf file.\n\nLoad from file is not available when playing directly from a website like furaffinity or fenoxo.com.",true);
	}
}

public function ioErrorHandler(e:IOErrorEvent):void
{
	outputText("<b>!</b> Save file not found, check that it is in the same directory as the CoC_" + ver + ".swf file.\r\rLoad from file is not available when playing directly from a website like furaffinity or fenoxo.com.", true);
	doNext(returnToSaveMenu);
}

private function returnToSaveMenu():void {
	var f:MouseEvent;
	saveLoad(f);
}

public function onDataLoaded(evt:Event):void
{
	//var fileObj = readObjectFromStringBytes(loader.data);
	try
	{
		// I want to be able to write some debug stuff to the GUI during the loading process
		// Therefore, we clear the display *before* calling loadGameObject
		outputText("Loading save...", true);
		trace("OnDataLoaded! - Reading data", loader, loader.data.readObject);
		var tmpObj:Object = loader.data.readObject();
		trace("Read in object = ", tmpObj);
		
		CONFIG::debug 
		{
			if (tmpObj == null)
			{
				throw new Error("Bad Save load?"); // Re throw error in debug mode.
			}
		}
		loadGameObject(tmpObj);
		outputText("Loaded Save");
	}
	catch (rangeError:RangeError)
	{
		outputText("<b>!</b> File is either corrupted or not a valid save", true);
		doNext(returnToSaveMenu);
	}
	catch (error:Error)
	{
		outputText("<b>!</b> Unhandled Exception", true);
		outputText("[pg]Failed to load save. The file may be corrupt!");

		doNext(returnToSaveMenu);
	}
	loadPermObject();
	statScreenRefresh();
	//playerMenu();
}

public function loadGameObject(saveData:Object, slot:String = "VOID"):void
{
	var game:CoC = getGame();
	game.dungeonLoc = 0;
	//Not needed, dungeonLoc = 0 does this:	game.inDungeon = false;
	game.inDungeon = false; //Needed AGAIN because fuck includes folder. If it ain't broke, don't fix it!
	game.inRoomedDungeon = false;
	game.inRoomedDungeonResume = null;

	//Autosave stuff
	player.slotName = slot;

	var counter:Number = player.cocks.length;
	trace("Loading save!")
	//Initialize the save file
	//var saveFile:Object = loader.data.readObject();
	var saveFile:* = saveData;
	if (saveFile.data.exists)
	{

		//KILL ALL COCKS;
		player = new Player();
		flags = new DefaultDict();
		model.player = player;		
		
		//trace("Type of saveFile.data = ", getClass(saveFile.data));
		
		inventory.clearStorage();
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
		
		//MAIN STATS
		player.str = saveFile.data.str;
		player.tou = saveFile.data.tou;
		player.spe = saveFile.data.spe;
		player.inte = saveFile.data.inte;
		player.lib = saveFile.data.lib;
		player.sens = saveFile.data.sens;
		player.cor = saveFile.data.cor;
		player.fatigue = saveFile.data.fatigue;

		//CLOTHING/ARMOR
		var found:Boolean = false;
		if (saveFile.data.weaponId){
			player.setWeaponHiddenField((ItemType.lookupItem(saveFile.data.weaponId) as Weapon) || WeaponLib.FISTS);
		} else {
			player.setWeapon(WeaponLib.FISTS);
			//player.weapon = WeaponLib.FISTS;
			for each (var itype:ItemType in ItemType.getItemLibrary()) {
				if (itype is Weapon && (itype as Weapon).name == saveFile.data.weaponName){
					player.setWeaponHiddenField(itype as Weapon || WeaponLib.FISTS);
					found = true;
					break;
				}
			}
		}
		if (saveFile.data.shieldId){
			player.setShieldHiddenField((ItemType.lookupItem(saveFile.data.shieldId) as Shield) || ShieldLib.NOTHING);
		} else {
			player.setShield(ShieldLib.NOTHING);
			//player.weapon = WeaponLib.FISTS;
			for each (itype in ItemType.getItemLibrary()) {
				if (itype is Shield && (itype as Shield).name == saveFile.data.shieldName){
					player.setShieldHiddenField(itype as Shield || ShieldLib.NOTHING);
					found = true;
					break;
				}
			}
		}
		if (saveFile.data.jewelryId){
			player.setJewelryHiddenField((ItemType.lookupItem(saveFile.data.jewelryId) as Jewelry) || JewelryLib.NOTHING);
		} else {
			player.setJewelry(JewelryLib.NOTHING);
			for each (itype in ItemType.getItemLibrary()) {
				if (itype is Jewelry && (itype as Jewelry).name == saveFile.data.jewelryName){
					player.setJewelryHiddenField(itype as Jewelry || JewelryLib.NOTHING);
					found = true;
					break;
				}
			}
		}
		if (saveFile.data.upperGarmentId){
			player.setUndergarmentHiddenField((ItemType.lookupItem(saveFile.data.upperGarmentId) as Undergarment) || UndergarmentLib.NOTHING, UndergarmentLib.TYPE_UPPERWEAR);
		} else {
			player.setUndergarment(UndergarmentLib.NOTHING);
			for each (itype in ItemType.getItemLibrary()) {
				if (itype is Undergarment && (itype as Undergarment).name == saveFile.data.upperGarmentName){
					player.setUndergarmentHiddenField(itype as Undergarment || UndergarmentLib.NOTHING, UndergarmentLib.TYPE_UPPERWEAR);
					found = true;
					break;
				}
			}
		}
		if (saveFile.data.lowerGarmentId){
			player.setUndergarmentHiddenField((ItemType.lookupItem(saveFile.data.lowerGarmentId) as Undergarment) || UndergarmentLib.NOTHING, UndergarmentLib.TYPE_LOWERWEAR);
		} else {
			player.setUndergarment(UndergarmentLib.NOTHING);
			for each (itype in ItemType.getItemLibrary()) {
				if (itype is Undergarment && (itype as Undergarment).name == saveFile.data.lowerGarmentName){
					player.setUndergarmentHiddenField(itype as Undergarment || UndergarmentLib.NOTHING, UndergarmentLib.TYPE_LOWERWEAR);
					found = true;
					break;
				}
			}
		}
		if (saveFile.data.armorId){
			player.setArmorHiddenField((ItemType.lookupItem(saveFile.data.armorId) as Armor) || ArmorLib.COMFORTABLE_UNDERCLOTHES);
			if (player.armor.name != saveFile.data.armorName) player.modArmorName = saveFile.data.armorName;
		} else {
			found = false;
			player.setArmor(ArmorLib.COMFORTABLE_UNDERCLOTHES);
			//player.armor = ArmorLib.COMFORTABLE_UNDERCLOTHES;
			for each (itype in ItemType.getItemLibrary()) {
				if (itype is Armor && (itype as Armor).name == saveFile.data.armorName){
					player.setArmorHiddenField(itype as Armor || ArmorLib.COMFORTABLE_UNDERCLOTHES);
					found = true;
					break;
				}
			}
			if (!found){
				for each (itype in ItemType.getItemLibrary()){
					if (itype is Armor){
						var a:Armor = itype as Armor;
						if (a.value == saveFile.data.armorValue &&
								a.def == saveFile.data.armorDef &&
								a.perk == saveFile.data.armorPerk){
							player.setArmor(a);
							//player.armor = a;
							player.modArmorName = saveFile.data.armorName;
							found = true;
							break;
						}
					}
				}
			}
		}

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
		//Prison STATS
		if (saveFile.data.hunger == undefined)
			player.hunger = 50;
		else
			player.hunger = saveFile.data.hunger;
		if (saveFile.data.esteem == undefined)
			player.esteem = 50;
		else
			player.esteem = saveFile.data.esteem;
		if (saveFile.data.obey == undefined)
			player.obey = 0;
		else
			player.obey = saveFile.data.obey;
		if (saveFile.data.will == undefined)
			player.will = 50;
		else
			player.will = saveFile.data.will;
		if (saveFile.data.obeySoftCap == undefined)
			player.obeySoftCap = true;
		else
			player.obeySoftCap = saveFile.data.obeySoftCap;
		//Prison storage
		//Items
		if (saveFile.data.prisonItems == undefined) {
			trace("Not found");
			player.prisonItemSlots = [];
		}
		else {
			trace("Items FOUND!");
			//for (var k:int = 0; k < 10; i++) {
				player.prisonItemSlots = saveFile.data.prisonItems;
			//}
		}
		//Armour
		/*if (saveFile.data.prisonArmor == undefined) {
			trace("Armour not found");
			prison.prisonItemSlotArmor = null;
		}
		else {
			trace("Armour FOUND!");
			if (saveFile.data.prisonArmor is ItemType) {
				trace("Loading prison armour");
				prison.prisonItemSlotArmor = saveFile.data.prisonArmor;
			}
		}
		//Weapon
		if (saveFile.data.prisonWeapon == undefined) {
			trace("Weapon not found");
			prison.prisonItemSlotWeapon = null;
		}
		else {
			trace("Weapon FOUND!");
			if (saveFile.data.prisonWeapon is ItemType) {
				trace("Loading prison weapon");
				prison.prisonItemSlotWeapon = saveFile.data.prisonWeapon;
			}
		}*/
		//LEVEL STATS
		player.XP = saveFile.data.XP;
		player.level = saveFile.data.level;
		player.gems = saveFile.data.gems;
		if (saveFile.data.perkPoints == undefined)
			player.perkPoints = 0;
		else
			player.perkPoints = saveFile.data.perkPoints;
		
		if (saveFile.data.statPoints == undefined)
			player.statPoints = 0;
		else
			player.statPoints = saveFile.data.statPoints;

		if (saveFile.data.ascensionPerkPoints == undefined)
			player.ascensionPerkPoints = 0;
		else
			player.ascensionPerkPoints = saveFile.data.ascensionPerkPoints;
		
		//Appearance
		if (saveFile.data.startingRace != undefined)
			player.startingRace = saveFile.data.startingRace;
		player.gender = saveFile.data.gender;
		if (saveFile.data.femininity == undefined)
			player.femininity = 50;
		else
			player.femininity = saveFile.data.femininity;
		//EYES
		if (saveFile.data.eyeType == undefined)
			player.eyeType = EYES_HUMAN;
		else
			player.eyeType = saveFile.data.eyeType;
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
		if (saveFile.data.furColor == undefined || saveFile.data.furColor == "no")
			player.furColor = saveFile.data.hairColor;
		else
			player.furColor = saveFile.data.furColor;
		player.hairColor = saveFile.data.hairColor;
		if (saveFile.data.hairType == undefined)
			player.hairType = 0;
		else
			player.hairType = saveFile.data.hairType;
		if (saveFile.data.gills == undefined)
			player.gills = false;
		else
			player.gills = saveFile.data.gills;
		if (saveFile.data.armType == undefined)
			player.armType = ARM_TYPE_HUMAN;
		else
			player.armType = saveFile.data.armType;
		player.hairLength = saveFile.data.hairLength;
		player.skinType = saveFile.data.skinType;
		if (saveFile.data.skinAdj == undefined)
			player.skinAdj = "";
		else
			player.skinAdj = saveFile.data.skinAdj;
		player.skinTone = saveFile.data.skinTone;
		player.skinDesc = saveFile.data.skinDesc;
		//Silently discard SKIN_TYPE_UNDEFINED
		if (player.skinType == SKIN_TYPE_UNDEFINED)
		{
			player.skinAdj = "";
			player.skinDesc = "skin";
			player.skinType = SKIN_TYPE_PLAIN;
		}
		//Convert from old skinDesc to new skinAdj + skinDesc!
		if (player.skinDesc.indexOf("smooth") != -1)
		{
			player.skinAdj = "smooth";
			if (player.skinType == SKIN_TYPE_PLAIN)
				player.skinDesc = "skin";
			if (player.skinType == SKIN_TYPE_FUR)
				player.skinDesc = "fur";
			if (player.skinType == SKIN_TYPE_SCALES)
				player.skinDesc = "scales";
			if (player.skinType == SKIN_TYPE_GOO)
				player.skinDesc = "goo";
		}
		if (player.skinDesc.indexOf("thick") != -1)
		{
			player.skinAdj = "thick";
			if (player.skinType == SKIN_TYPE_PLAIN)
				player.skinDesc = "skin";
			if (player.skinType == SKIN_TYPE_FUR)
				player.skinDesc = "fur";
			if (player.skinType == SKIN_TYPE_SCALES)
				player.skinDesc = "scales";
			if (player.skinType == SKIN_TYPE_GOO)
				player.skinDesc = "goo";
		}
		if (player.skinDesc.indexOf("rubber") != -1)
		{
			player.skinAdj = "rubber";
			if (player.skinType == SKIN_TYPE_PLAIN)
				player.skinDesc = "skin";
			if (player.skinType == SKIN_TYPE_FUR)
				player.skinDesc = "fur";
			if (player.skinType == SKIN_TYPE_SCALES)
				player.skinDesc = "scales";
			if (player.skinType == SKIN_TYPE_GOO)
				player.skinDesc = "goo";
		}
		if (player.skinDesc.indexOf("latex") != -1)
		{
			player.skinAdj = "latex";
			if (player.skinType == SKIN_TYPE_PLAIN)
				player.skinDesc = "skin";
			if (player.skinType == SKIN_TYPE_FUR)
				player.skinDesc = "fur";
			if (player.skinType == SKIN_TYPE_SCALES)
				player.skinDesc = "scales";
			if (player.skinType == SKIN_TYPE_GOO)
				player.skinDesc = "goo";
		}
		if (player.skinDesc.indexOf("slimey") != -1)
		{
			player.skinAdj = "slimey";
			if (player.skinType == SKIN_TYPE_PLAIN)
				player.skinDesc = "skin";
			if (player.skinType == SKIN_TYPE_FUR)
				player.skinDesc = "fur";
			if (player.skinType == SKIN_TYPE_SCALES)
				player.skinDesc = "scales";
			if (player.skinType == SKIN_TYPE_GOO)
				player.skinDesc = "goo";
		}
		player.faceType = saveFile.data.faceType;
		if (saveFile.data.tongueType == undefined)
			player.tongueType = TONGUE_HUMAN;
		else
			player.tongueType = saveFile.data.tongueType;
		if (saveFile.data.earType == undefined)
			player.earType = EARS_HUMAN;
		else
			player.earType = saveFile.data.earType;
		if (saveFile.data.earValue == undefined)
			player.earValue = 0;
		else
			player.earValue = saveFile.data.earValue;
		if (saveFile.data.antennae == undefined)
			player.antennae = ANTENNAE_NONE;
		else
			player.antennae = saveFile.data.antennae;
		player.horns = saveFile.data.horns;
		if (saveFile.data.hornType == undefined)
			player.hornType = HORNS_NONE;
		else
			player.hornType = saveFile.data.hornType;

		// <mod name="Predator arms" author="Stadler">
		player.clawTone = (saveFile.data.clawTone == undefined) ? ""               : saveFile.data.clawTone;
		player.clawType = (saveFile.data.clawType == undefined) ? CLAW_TYPE_NORMAL : saveFile.data.clawType;
		// </mod>

		player.wingDesc = saveFile.data.wingDesc;
		player.wingType = saveFile.data.wingType;
		player.lowerBody = saveFile.data.lowerBody;
		player.tailType = saveFile.data.tailType;
		player.tailVenom = saveFile.data.tailVenum;
		player.tailRecharge = saveFile.data.tailRecharge;
		player.hipRating = saveFile.data.hipRating;
		player.buttRating = saveFile.data.buttRating;
		
		if (saveFile.data.legCount == undefined) {
			if (player.lowerBody == LOWER_BODY_TYPE_DRIDER_LOWER_BODY) {
				player.legCount = 8;
			}
			else if (player.lowerBody == LOWER_BODY_TYPE_CENTAUR) {
				player.legCount = 4;
				player.lowerBody = LOWER_BODY_TYPE_HOOFED;
			}
			else if (player.lowerBody == LOWER_BODY_TYPE_PONY) {
				player.legCount = 4;
			}
			else if (player.lowerBody == LOWER_BODY_TYPE_DEERTAUR) {
				player.legCount = 4;
				player.lowerBody = LOWER_BODY_TYPE_CLOVEN_HOOFED;
			}
			else if (player.lowerBody == LOWER_BODY_TYPE_NAGA) {
				player.legCount = 1;
			}
			else if (player.lowerBody == LOWER_BODY_TYPE_GOO) {
				player.legCount = 1;
			}
			else player.legCount = 2;
		}
		else
			player.legCount = saveFile.data.legCount;
		
		//Sexual Stuff
		player.balls = saveFile.data.balls;
		player.cumMultiplier = saveFile.data.cumMultiplier;
		player.ballSize = saveFile.data.ballSize;
		player.hoursSinceCum = saveFile.data.hoursSinceCum;
		player.fertility = saveFile.data.fertility;
		player.clitLength = saveFile.data.clitLength;
		
		//Preggo stuff
		player.knockUpForce(saveFile.data.pregnancyType, saveFile.data.pregnancyIncubation);
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
			}
			else
			{
				player.vaginas[i].labiaPierced = saveFile.data.vaginas[i].labiaPierced;
				player.vaginas[i].labiaPShort = saveFile.data.vaginas[i].labiaPShort;
				player.vaginas[i].labiaPLong = saveFile.data.vaginas[i].labiaPLong;
				player.vaginas[i].clitPierced = saveFile.data.vaginas[i].clitPierced;
				player.vaginas[i].clitPShort = saveFile.data.vaginas[i].clitPShort;
				player.vaginas[i].clitPLong = saveFile.data.vaginas[i].clitPLong;
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
		
		var hasHistoryPerk:Boolean = false;
		var hasLustyRegenPerk:Boolean = false;
		var addedSensualLover:Boolean = false;
		
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
			if (id.indexOf("History:") != -1)
			{
				hasHistoryPerk = true;
			}
			
			var ptype:PerkType = PerkType.lookupPerk(id);
			
			if (ptype == null) 
			{
				trace("ERROR: Unknown perk id="+id);
				
				//(saveFile.data.perks as Array).splice(i,1);
				// NEVER EVER EVER MODIFY DATA IN THE SAVE FILE LIKE THIS. EVER. FOR ANY REASON.
			}
			else
			{
				trace("Creating perk : " + ptype);
				player.createPerk(ptype,value1,value2,value3,value4);
			
				if (isNaN(player.perk(player.numPerks - 1).value1)) 
				{
					if (player.perk(player.numPerks - 1).perkName == "Wizard's Focus") 
					{
						player.perk(player.numPerks - 1).value1 = .3;
					}
					else
					{
						player.perk(player.numPerks).value1 = 0;
					}
					
					trace("NaN byaaaatch: " + player.perk(player.numPerks - 1).value1);
				}
			
				if (player.perk(player.numPerks - 1).perkName == "Wizard's Focus") 
				{
					if (player.perk(player.numPerks - 1).value1 == 0 || player.perk(player.numPerks - 1).value1 < 0.1) 
					{
						trace("Wizard's Focus boosted up to par (.5)");
						player.perk(player.numPerks - 1).value1 = .5;
					}
				}
			}
		}
		
		// Fixup missing History: Whore perk IF AND ONLY IF the flag used to track the prior selection of a history perk has been set
		if (hasHistoryPerk == false && flags[kFLAGS.HISTORY_PERK_SELECTED] != 0)
		{
			player.createPerk(PerkLib.HistoryWhore, 0, 0, 0, 0);
		}
		
		// Fixup missing Lusty Regeneration perk, if the player has an equipped viridian cock sock and does NOT have the Lusty Regeneration perk
		if (hasViridianCockSock == true && hasLustyRegenPerk == false)
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
			var stype:StatusEffectType = StatusEffectType.lookupStatusEffect(saveFile.data.statusAffects[i].statusAffectName);
			if (stype == null){
				CoC_Settings.error("Cannot find status affect '"+saveFile.data.statusAffects[i].statusAffectName+"'");
				continue;
			}
			player.createStatusEffect(stype,
					saveFile.data.statusAffects[i].value1,
					saveFile.data.statusAffects[i].value2,
					saveFile.data.statusAffects[i].value3,
					saveFile.data.statusAffects[i].value4);
				//trace("StatusEffect " + player.statusEffect(i).stype.id + " loaded.");
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
				if (savedIS.shortName)
				{
					if (savedIS.shortName.indexOf("Gro+") != -1)
						savedIS.id = "GroPlus";
					else if (savedIS.shortName.indexOf("Sp Honey") != -1)
						savedIS.id = "SpHoney";
				}
				if (savedIS.quantity>0)
					storage.setItemAndQty(ItemType.lookupItem(savedIS.id || savedIS.shortName), savedIS.quantity);
				else
					storage.emptySlot();
				storage.unlocked = savedIS.unlocked;
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
			for (i = 0; i < saveFile.data.gearStorage.length && gearStorageGet().length < 45; i++)
			{
				gearStorageGet().push(new ItemSlotClass());
					//trace("Initialize a slot for one of the item storage locations to load.");
			}
			//Populate storage slot array
			for (i = 0; i < saveFile.data.gearStorage.length && i < gearStorageGet().length; i++)
			{
				//trace("Populating a storage slot save with data");
				storage = gearStorageGet()[i];
				if ((saveFile.data.gearStorage[i].shortName == undefined && saveFile.data.gearStorage[i].id == undefined)
                        || saveFile.data.gearStorage[i].quantity == undefined
						|| saveFile.data.gearStorage[i].quantity == 0)
					storage.emptySlot();
				else
					storage.setItemAndQty(ItemType.lookupItem(saveFile.data.gearStorage[i].id || saveFile.data.gearStorage[i].shortName),saveFile.data.gearStorage[i].quantity);
				storage.unlocked = saveFile.data.gearStorage[i].unlocked;
			}
		}
		//player.cocks = saveFile.data.cocks;
		player.ass.analLooseness = saveFile.data.ass.analLooseness;
		player.ass.analWetness = saveFile.data.ass.analWetness;
		player.ass.fullness = saveFile.data.ass.fullness;
		
		//Shit
		gameStateSet(saveFile.data.gameState);
		player.exploredLake = saveFile.data.exploredLake;
		player.exploredMountain = saveFile.data.exploredMountain;
		player.exploredForest = saveFile.data.exploredForest;
		player.exploredDesert = saveFile.data.exploredDesert;
		player.explored = saveFile.data.explored;
		game.foundForest = saveFile.data.foundForest;
		game.foundDesert = saveFile.data.foundDesert;
		game.foundMountain = saveFile.data.foundMountain;
		game.foundLake = saveFile.data.foundLake;
		
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
		game.whitney = saveFile.data.whitney;
		game.monk = saveFile.data.monk;
		game.sand = saveFile.data.sand;
		if (saveFile.data.giacomo == undefined)
			game.giacomo = 0;
		else
			game.giacomo = saveFile.data.giacomo;
		if (saveFile.data.beeProgress != undefined && saveFile.data.beeProgress == 1) game.forest.beeGirlScene.setTalked(); //Bee Progress update is now in a flag
			//The flag will be zero for any older save that still uses beeProgress and newer saves always store a zero in beeProgress, so we only need to update the flag on a value of one.
			
		kGAMECLASS.isabellaScene.isabellaOffspringData = [];
		if (saveFile.data.isabellaOffspringData == undefined) {
			//NOPE
		}
		else {
			for (i = 0; i < saveFile.data.isabellaOffspringData.length; i += 2) {
				kGAMECLASS.isabellaScene.isabellaOffspringData.push(saveFile.data.isabellaOffspringData[i], saveFile.data.isabellaOffspringData[i+1])
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
		player.itemSlot4.unlocked = saveFile.data.itemSlot4.unlocked;
		player.itemSlot4.setItemAndQty(ItemType.lookupItem(
				saveFile.data.itemSlot4.id || saveFile.data.itemSlot4.shortName),
				saveFile.data.itemSlot4.quantity);
		player.itemSlot5.unlocked = saveFile.data.itemSlot5.unlocked;
		player.itemSlot5.setItemAndQty(ItemType.lookupItem(
				saveFile.data.itemSlot5.id || saveFile.data.itemSlot5.shortName),
				saveFile.data.itemSlot5.quantity);
		//Extra slots from the mod.
		if (saveFile.data.itemSlot6 != undefined && saveFile.data.itemSlot7 != undefined && saveFile.data.itemSlot8 != undefined && saveFile.data.itemSlot9 != undefined && saveFile.data.itemSlot10 != undefined) {
		player.itemSlot6.unlocked = saveFile.data.itemSlot6.unlocked;
		player.itemSlot6.setItemAndQty(ItemType.lookupItem(
				saveFile.data.itemSlot6.id || saveFile.data.itemSlot6.shortName),
				saveFile.data.itemSlot6.quantity);
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
		}
		
		CoC.loadAllAwareClasses(getGame()); //Informs each saveAwareClass that it must load its values from the flags array
		unFuckSave();
		
		// Control Bindings
		if (saveFile.data.controls != undefined)
		{
			game.inputManager.LoadBindsFromObj(saveFile.data.controls);
		}
		doNext(playerMenu);
	}
}

public function unFuckSave():void
{
	//Fixing shit!

	// Fix duplicate elven bounty perks
	if (player.findPerk(PerkLib.ElvenBounty) >= 0) {
		//CLear duplicates
		while(player.perkDuplicated(PerkLib.ElvenBounty)) player.removePerk(PerkLib.ElvenBounty);
		//Fix fudged preggers value
		if (player.perkv1(PerkLib.ElvenBounty) == 15) {
			player.setPerkValue(PerkLib.ElvenBounty,1,0);
			player.addPerkValue(PerkLib.ElvenBounty,2,15);
		}
	}
	
	if (player.findStatusEffect(StatusEffects.KnockedBack) >= 0)
	{
		player.removeStatusEffect(StatusEffects.KnockedBack);
	}
	
	if (player.findStatusEffect(StatusEffects.Tentagrappled) >= 0)
	{
		player.removeStatusEffect(StatusEffects.Tentagrappled);
	}

	if (isNaN(model.time.minutes)) model.time.minutes = 0;
	if (isNaN(model.time.hours)) model.time.hours = 0;
	if (isNaN(model.time.days)) model.time.days = 0;

	if (player.gems < 0) player.gems = 0; //Force fix gems
	
	if (player.findStatusEffect(StatusEffects.SlimeCraving) >= 0 && player.statusEffectv4(StatusEffects.SlimeCraving) == 1) {
		player.changeStatusValue(StatusEffects.SlimeCraving, 3, player.statusEffectv2(StatusEffects.SlimeCraving)); //Duplicate old combined strength/speed value
		player.changeStatusValue(StatusEffects.SlimeCraving, 4, 1); //Value four indicates this tracks strength and speed separately
	}
	
	// Fix issues with corrupt cockTypes caused by a error in the serialization code.
		
	//trace("CockInfo = ", flags[kFLAGS.RUBI_COCK_TYPE]);
	//trace("getQualifiedClassName = ", getQualifiedClassName(flags[kFLAGS.RUBI_COCK_TYPE]));
	//trace("typeof = ", typeof(flags[kFLAGS.RUBI_COCK_TYPE]));
	//trace("is CockTypesEnum = ", flags[kFLAGS.RUBI_COCK_TYPE] is CockTypesEnum);
	//trace("instanceof CockTypesEnum = ", flags[kFLAGS.RUBI_COCK_TYPE] instanceof CockTypesEnum);



	if (!(flags[kFLAGS.RUBI_COCK_TYPE] is CockTypesEnum || flags[kFLAGS.RUBI_COCK_TYPE] is Number))	
	{ // Valid contents of flags[kFLAGS.RUBI_COCK_TYPE] are either a CockTypesEnum or a number

		trace("Fixing save (goo girl)");
		outputText("\n<b>Rubi's cockType is invalid. Defaulting him to human.</b>\n");
		flags[kFLAGS.RUBI_COCK_TYPE] = 0;
	}


	if (!(flags[kFLAGS.GOO_DICK_TYPE] is CockTypesEnum || flags[kFLAGS.GOO_DICK_TYPE] is Number))	
	{ // Valid contents of flags[kFLAGS.GOO_DICK_TYPE] are either a CockTypesEnum or a number

		trace("Fixing save (goo girl)");
		outputText("\n<b>Latex Goo-Girls's cockType is invalid. Defaulting him to human.</b>\n");
		flags[kFLAGS.GOO_DICK_TYPE] = 0;
	}

	var flagData:Array = String(flags[kFLAGS.KATHERINE_BREAST_SIZE]).split("^");
	if (flagData.length < 7 && flags[kFLAGS.KATHERINE_BREAST_SIZE] > 0) { //Older format only stored breast size or zero if not yet initialized
		getGame().telAdre.katherine.breasts.cupSize			= flags[kFLAGS.KATHERINE_BREAST_SIZE];
		getGame().telAdre.katherine.breasts.lactationLevel	= BreastStore.LACTATION_DISABLED;
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
			if (player.findPerk(PerkLib.SpiderOvipositor) >= 0)
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
			kGAMECLASS.helScene.pregnancy.knockUpForce(); //Clear Pregnancy, also removed any old value from HEL_PREGNANCY_NOTICES
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
		if (player.findStatusEffect(StatusEffects.TamaniFemaleEncounter) >= 0) player.removeStatusEffect(StatusEffects.TamaniFemaleEncounter); //Wasn't used in previous code
		if (player.findStatusEffect(StatusEffects.Tamani) >= 0) {
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
			flags[kFLAGS.KATHERINE_BREAST_SIZE]		= BREAST_CUP_B;
			flags[kFLAGS.KATHERINE_BALL_SIZE]		= 1;
			flags[kFLAGS.KATHERINE_HAIR_COLOR]		= "neon pink";
			flags[kFLAGS.KATHERINE_HOURS_SINCE_CUM] = 200; //Give her maxed out cum for that first time
		}

		if (flags[kFLAGS.URTA_PREGNANCY_TYPE] == PregnancyStore.PREGNANCY_BEE_EGGS) return; //Must be a new format save
		if (flags[kFLAGS.URTA_PREGNANCY_TYPE] == PregnancyStore.PREGNANCY_DRIDER_EGGS) return; //Must be a new format save
		if (flags[kFLAGS.URTA_PREGNANCY_TYPE] == PregnancyStore.PREGNANCY_PLAYER) return; //Must be a new format save
		if (flags[kFLAGS.URTA_PREGNANCY_TYPE] > 0) { //URTA_PREGNANCY_TYPE was previously URTA_EGG_INCUBATION, assume this was an egg pregnancy
			flags[kFLAGS.URTA_INCUBATION] = flags[kFLAGS.URTA_PREGNANCY_TYPE];
			if (player.findPerk(PerkLib.SpiderOvipositor) >= 0)
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
				flags[kFLAGS.URTA_FERTILE]            = PregnancyStore.PREGNANCY_PLAYER;          //These two variables are used to store information on the pregnancy Taoth
			flags[kFLAGS.URTA_PREG_EVERYBODY]        = flags[kFLAGS.EDRYN_PREGNANCY_INCUBATION]; //is overriding (if any), so they can later be restored.
			flags[kFLAGS.EDRYN_PREGNANCY_INCUBATION] = flags[kFLAGS.EDRYN_PREGNANCY_TYPE];
			flags[kFLAGS.EDRYN_PREGNANCY_TYPE]       = PregnancyStore.PREGNANCY_TAOTH;
		}
		else if (flags[kFLAGS.EDRYN_PREGNANCY_INCUBATION] > 0 && flags[kFLAGS.EDRYN_PREGNANCY_TYPE] == 0) flags[kFLAGS.EDRYN_PREGNANCY_TYPE] = PregnancyStore.PREGNANCY_PLAYER;
	}
	if (flags[kFLAGS.BEHEMOTH_CHILDREN] > 0) {
		if (flags[kFLAGS.BEHEMOTH_CHILDREN] >= 1 && flags[kFLAGS.BEHEMOTH_CHILD_1_BIRTH_DAY] <= 0) flags[kFLAGS.BEHEMOTH_CHILD_1_BIRTH_DAY] = model.time.days;
		if (flags[kFLAGS.BEHEMOTH_CHILDREN] >= 2 && flags[kFLAGS.BEHEMOTH_CHILD_2_BIRTH_DAY] <= 0) flags[kFLAGS.BEHEMOTH_CHILD_2_BIRTH_DAY] = model.time.days;
		if (flags[kFLAGS.BEHEMOTH_CHILDREN] >= 3 && flags[kFLAGS.BEHEMOTH_CHILD_3_BIRTH_DAY] <= 0) flags[kFLAGS.BEHEMOTH_CHILD_3_BIRTH_DAY] = model.time.days;
	}
	if (flags[kFLAGS.LETHICE_DEFEATED] > 0 && flags[kFLAGS.D3_JEAN_CLAUDE_DEFEATED] == 0) flags[kFLAGS.D3_JEAN_CLAUDE_DEFEATED] = 1; 
	if (gearStorageGet().length < 45) {
		while (gearStorageGet().length < 45) {
			gearStorageGet().push(new ItemSlotClass());
		}
	}
	if (player.hasKeyItem("Laybans") >= 0) {
		flags[kFLAGS.D3_MIRRORS_SHATTERED] = 1;
	}
	//Rigidly enforce rank caps
	if (player.perkv1(PerkLib.AscensionDesires) > getGame().charCreation.MAX_DESIRES_LEVEL) player.setPerkValue(PerkLib.AscensionDesires, 1, getGame().charCreation.MAX_DESIRES_LEVEL);
	if (player.perkv1(PerkLib.AscensionEndurance) > getGame().charCreation.MAX_ENDURANCE_LEVEL) player.setPerkValue(PerkLib.AscensionEndurance, 1, getGame().charCreation.MAX_ENDURANCE_LEVEL);
	if (player.perkv1(PerkLib.AscensionFertility) > getGame().charCreation.MAX_FERTILITY_LEVEL) player.setPerkValue(PerkLib.AscensionFertility, 1, getGame().charCreation.MAX_FERTILITY_LEVEL);
	if (player.perkv1(PerkLib.AscensionMoralShifter) > getGame().charCreation.MAX_MORALSHIFTER_LEVEL) player.setPerkValue(PerkLib.AscensionMoralShifter, 1, getGame().charCreation.MAX_MORALSHIFTER_LEVEL);
	if (player.perkv1(PerkLib.AscensionMysticality) > getGame().charCreation.MAX_MYSTICALITY_LEVEL) player.setPerkValue(PerkLib.AscensionMysticality, 1, getGame().charCreation.MAX_MYSTICALITY_LEVEL);
	if (player.perkv1(PerkLib.AscensionTolerance) > getGame().charCreation.MAX_TOLERANCE_LEVEL) player.setPerkValue(PerkLib.AscensionTolerance, 1, getGame().charCreation.MAX_TOLERANCE_LEVEL);
	if (player.perkv1(PerkLib.AscensionVirility) > getGame().charCreation.MAX_VIRILITY_LEVEL) player.setPerkValue(PerkLib.AscensionVirility, 1, getGame().charCreation.MAX_VIRILITY_LEVEL);
	if (player.perkv1(PerkLib.AscensionWisdom) > getGame().charCreation.MAX_WISDOM_LEVEL) player.setPerkValue(PerkLib.AscensionWisdom, 1, getGame().charCreation.MAX_WISDOM_LEVEL);
	//Rigidly enforce cock size caps
	if (player.hasCock()) {
		for (var i:int = 0; i < player.cocks.length; i++) {
			if (player.cocks[i].cockLength > 499.9) player.cocks[i].cockLength = 499.9;
			if (player.cocks[i].cockThickness > 99.9) player.cocks[i].cockThickness = 99.9;
		}
	}
	//Unstick shift key flag
	flags[kFLAGS.SHIFT_KEY_DOWN] = 0;
}

//This is just the save/load code - from it you can get 
//strings from the save objects, and load games from strings. 
//What you do with the strings, and where you get them from 
//is not handled here. For this to work right, you'll need to
//modify saveGameObject() to use an int or something instead 
//of a boolean to identify the save type (0 = normal, 
//1 = file, 2 = text and so on), and modify the if/else at the 
//bottom, which currently checks if a boolean is true for 
//using the file saving code, else it uses slot saving.

//Arrays for converting a byte array into a string
public static const encodeChars:Array = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '+', '/'];
public static const decodeChars:Array = [-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 62, -1, -1, -1, 63, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, -1, -1, -1, -1, -1, -1, -1, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, -1, -1, -1, -1, -1, -1, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, -1, -1, -1, -1, -1];

//ByteArray > String
public function b64e(data:ByteArray):String
{
	var out:Array = [];
	var i:int = 0;
	var j:int = 0;
	var r:int = data.length % 3;
	var len:int = data.length - r;
	var c:int;
	while (i < len)
	{
		c = data[i++] << 16 | data[i++] << 8 | data[i++];
		out[j++] = encodeChars[c >> 18] + encodeChars[c >> 12 & 0x3f] + encodeChars[c >> 6 & 0x3f] + encodeChars[c & 0x3f];
	}
	if (r == 1)
	{
		c = data[i++];
		out[j++] = encodeChars[c >> 2] + encodeChars[(c & 0x03) << 4] + "==";
	}
	else if (r == 2)
	{
		c = data[i++] << 8 | data[i++];
		out[j++] = encodeChars[c >> 10] + encodeChars[c >> 4 & 0x3f] + encodeChars[(c & 0x0f) << 2] + "=";
	}
	return out.join('');
}

//String > ByteArray
public function b64d(str:String):ByteArray
{
	var c1:int;
	var c2:int;
	var c3:int;
	var c4:int;
	var i:int;
	var len:int;
	var out:ByteArray;
	len = str.length;
	i = 0;
	out = new ByteArray();
	while (i < len)
	{
		// c1  
		do
		{
			c1 = decodeChars[str.charCodeAt(i++) & 0xff];
		} while (i < len && c1 == -1);
		if (c1 == -1)
		{
			break;
		}
		// c2      
		do
		{
			c2 = decodeChars[str.charCodeAt(i++) & 0xff];
		} while (i < len && c2 == -1);
		if (c2 == -1)
		{
			break;
		}
		
		out.writeByte((c1 << 2) | ((c2 & 0x30) >> 4));
		
		// c3  
		do
		{
			c3 = str.charCodeAt(i++) & 0xff;
			if (c3 == 61)
			{
				return out;
			}
			c3 = decodeChars[c3];
		} while (i < len && c3 == -1);
		if (c3 == -1)
		{
			break;
		}
		
		out.writeByte(((c2 & 0x0f) << 4) | ((c3 & 0x3c) >> 2));
		
		// c4  
		do
		{
			c4 = str.charCodeAt(i++) & 0xff;
			if (c4 == 61)
			{
				return out;
			}
			c4 = decodeChars[c4];
		} while (i < len && c4 == -1);
		if (c4 == -1)
		{
			break;
		}
		out.writeByte(((c3 & 0x03) << 6) | c4);
	}
	return out;
}

//This loads the game from the string
public function loadText(saveText:String):void
{
	//Get the byte array from the string
	var rawSave:ByteArray = b64d(saveText);
	
	//Inflate
	rawSave.inflate();
	
	//Read the object
	var obj:Object = rawSave.readObject();
	
	//Load the object
	loadGameObject(obj);
}

//*******
//This is the modified if for initialising saveFile in saveGameObject(). It assumes the save type parameter passed is an int, that 0 means a slot-save, and is called saveType.
/*
   if (saveType != 0)
   {
   saveFile = new Object();

   saveFile.data = new Object();
   }
   else
   {
   saveFile = SharedObject.getLocal(slot,"/");
   }
   //*******
   //This stuff is for converting the save object into a string, should go down in saveGameObject(), as an else-if (if saveType == 2, etc)
   var rawSave:ByteArray = new ByteArray;

   //Write the object to the byte array
   rawSave.writeObject(saveFile);

   //Deflate
   rawSave.deflate();

   //Convert to a Base64 string
   var saveString:String = b64e(rawSave);
 */
//*******
}
}
