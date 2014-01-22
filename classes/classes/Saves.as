package classes
{

	import classes.GlobalFlags.kGAMECLASS;

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


public class Saves extends BaseContent{

	public function Saves()
	{
	}


public var file:FileReference;
public var loader:URLLoader;

public var saveFileNames:Array = ["CoC_1", "CoC_2", "CoC_3", "CoC_4", "CoC_5", "CoC_6", "CoC_7", "CoC_8", "CoC_9"];
public var versionProperties:Object = { "legacy" : 100, "0.8.3f7" : 124, "0.8.3f8" : 125, "0.8.4.3":119, "latest" : 119 };

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

public function loadSaveDisplay(slot:String, slotName:String):String
{
	var holding:String = "";
	//Initialize the save file
	var saveFile:* = SharedObject.getLocal(slot, "/");
	//trace(slot+".data="+(function(x){var z=[];for (var i in x){z.push(i);}return z})(saveFile.data).join(","));
	var pfileHolding:Creature;
	if (saveFile.data.exists)
	{
		if (saveFile.data.notes == undefined)
		{
			saveFile.data.notes = "No notes available.";
		}
		holding = slotName;
		holding += ":  <b>";
		holding += saveFile.data.short;
		holding += "</b> - <i>" + saveFile.data.notes + "</i>\r";
		holding += "Days - " + saveFile.data.days + "  Gender - ";
		if (saveFile.data.gender == 0)
			holding += "U";
		if (saveFile.data.gender == 1)
			holding += "M";
		if (saveFile.data.gender == 2)
			holding += "F";
		if (saveFile.data.gender == 3)
			holding += "H";
		holding += "\r";
		return holding;
	}
	return slotName + ":  <b>EMPTY</b>\r     \r";
}

public function loadScreen():void
{
	var test:*;
	
	var slots:Array = new Array(saveFileNames.length);
		
	outputText("<b><u>Slot: Sex,  Game Days Played</u></b>\r", true);
	
	for (var i:int = 0; i < saveFileNames.length; i += 1)
	{
		outputText(loadSaveDisplay(saveFileNames[i], String(i + 1)), false);
		
		
		test = SharedObject.getLocal(saveFileNames[i], "/");
		if (test.data.exists)
		{
			//trace("Creating function with indice = ", i);
			(function(i:int):void		// messy hack to work around closures. See: http://en.wikipedia.org/wiki/Immediately-invoked_function_expression
			{
				slots[i] = function() : void 		// Anonymous functions FTW
				{
					trace("Loading save with name", saveFileNames[i], "at index", i);
					if (loadGame(saveFileNames[i])) 
					{
						doNext(1);
						showStats();
						statScreenRefresh();
						outputText("Slot " + i + " Loaded!", true);
					}
				}
			})(i);
		}
		else
			slots[i] = 0;		// You have to set the parameter to 0 to disable the button
	}
	
	choices("Slot 1", slots[0], 
	"Slot 2", slots[1], 
	"Slot 3", slots[2], 
	"Slot 4", slots[3], 
	"Slot 5", slots[4], 
	"Slot 6", slots[5], 
	"Slot 7", slots[6],
	"Slot 8", slots[7], 
	"Slot 9", slots[8], 
	"Back", 30);
}

public function saveScreen():void
{
	mainView.nameBox.x = 210;
	mainView.nameBox.y = 620;
	mainView.nameBox.width = 550;
	mainView.nameBox.text = "";
	mainView.nameBox.visible = true;
	
	// var test; // Disabling this variable because it seems to be unused.
	
	outputText("", true);
	if (player.slotName != "VOID")
		outputText("<b>Last saved or loaded from: " + player.slotName + "</b>\r\r", false);
	outputText("<b><u>Slot: Sex,  Game Days Played</u></b>\r", false);
	
	var saveFuncs:Array = [];
	
	
	for (var i:int = 0; i < saveFileNames.length; i += 1)
	{
		outputText(loadSaveDisplay(saveFileNames[i], String(i + 1)), false);
		
		
		trace("Creating function with indice = ", i);
		(function(i:int) : void		// messy hack to work around closures. See: http://en.wikipedia.org/wiki/Immediately-invoked_function_expression
		{
			saveFuncs[i] = function() : void 		// Anonymous functions FTW
			{
				trace("Saving game with name", saveFileNames[i], "at index", i);
				saveGame(saveFileNames[i]);
			}
		})(i);
		
	}
	

	if (player.slotName == "VOID")
		outputText("\r\r", false);
	
	outputText("<b>Leave the notes box blank if you don't wish to change notes.\r<u>NOTES:</u></b>", false);
	choices("Slot 1", saveFuncs[0], 
	"Slot 2", saveFuncs[1], 
	"Slot 3", saveFuncs[2], 
	"Slot 4", saveFuncs[3], 
	"Slot 5", saveFuncs[4], 
	"Slot 6", saveFuncs[5], 
	"Slot 7", saveFuncs[6], 
	"Slot 8", saveFuncs[7], 
	"Slot 9", saveFuncs[8], 
	"Back", 30);
}

public function saveLoad(e:MouseEvent = null):void
{
	mainView.eventTestInput.x = -10207.5;
	mainView.eventTestInput.y = -1055.1;
	//Hide the name box in case of backing up from save
	//screen so it doesnt overlap everything.
	mainView.nameBox.visible = false;
	outputText("", true);
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
	if (temp == 777)
	{
		simpleChoices("", 0, "Load", loadScreen, "Load File", -21, "Delete", deleteScreen, "Back", 5025);
		return;
	}
	if (player.str == 0)
	{
		simpleChoices("", 0, "Load", loadScreen, "Load File", -21, "Delete", deleteScreen, "Back", kGAMECLASS.mainMenu);
		return;
	}
	if (inDungeon)
	{
		simpleChoices("", 0, "Load", loadScreen, "Load File", -21, "Delete", deleteScreen, "Back", 1);
		return;
	}
	if (gameState == 3)
		choices("Save",            saveScreen, 
				"Load",            loadScreen, 
				"Load File",      -21, 
				"Delete",          deleteScreen, 
				"Back",            0, 
				"Save to File",   -20, 
				"Load File",      -21, 
				"",                0, 
				"",                0, 
				"",                0);
	else
	{
		if (player.autoSave)
			choices("Save",           saveScreen, 
					"Load",           loadScreen, 
					"AutoSav: ON",    65, 
					"Delete",         deleteScreen, 
					"",               0, 
					"Save to File",  -20, 
					"Load File",     -21, 
					"",               0, 
					"",               0, 
					"Back",           1);
		else
			choices("Save",           saveScreen, 
					"Load",           loadScreen, 
					"AutoSav: OFF",   65, 
					"Delete",         deleteScreen, 
					"",               0, 
					"Save to File",  -20, 
					"Load File",     -21, 
					"",               0, 
					"",               0, 
					"Back",           1);
	}
}

public function deleteScreen():void
{
	var test:*;
	outputText("Slot,  Race,  Sex,  Game Days Played\n", true);
	

	var delFuncs:Array = [];
	
	
	for (var i:int = 0; i < saveFileNames.length; i += 1)
	{
		outputText(loadSaveDisplay(saveFileNames[i], String(i + 1)), false);
		
		
		test = SharedObject.getLocal(saveFileNames[i], "/");
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
			delFuncs[i] = 0;	//disable buttons for empty slots
	}
	
	// outputText(loadSaveDisplay("CoC_1", "1") + loadSaveDisplay("CoC_2", "2") + loadSaveDisplay("CoC_3", "3") + loadSaveDisplay("CoC_4", "4") + loadSaveDisplay("CoC_5", "5") + loadSaveDisplay("CoC_6", "6") + loadSaveDisplay("CoC_7", "7") + loadSaveDisplay("CoC_8", "8") + loadSaveDisplay("CoC_9", "9"), false);
	
	outputText("\n<b>ONCE DELETED, YOUR SAVE IS GONE FOREVER.</b>", false);
	choices("Slot 1", delFuncs[0], 
			"Slot 2", delFuncs[1], 
			"Slot 3", delFuncs[2], 
			"Slot 4", delFuncs[3], 
			"Slot 5", delFuncs[4], 
			"Slot 6", delFuncs[5], 
			"Slot 7", delFuncs[6], 
			"Slot 8", delFuncs[7], 
			"Slot 9", delFuncs[8], 
			"Back", 30);
}

public function confirmDelete():void
{
	outputText("You are about to delete the following save: <b>" + flags[kFLAGS.TEMP_STORAGE_SAVE_DELETION] + "</b>\n\nAre you sure you want to delete it?", true);
	simpleChoices("No", deleteScreen, "Yes", purgeTheMutant, "", 0, "", 0, "", 0);
}

public function purgeTheMutant():void
{
	var test:* = SharedObject.getLocal(flags[kFLAGS.TEMP_STORAGE_SAVE_DELETION], "/");
	trace("DELETING SLOT: " + flags[kFLAGS.TEMP_STORAGE_SAVE_DELETION]);
	var blah:Array = ["been virus bombed", "been purged", "been vaped", "been nuked from orbit", "taken an arrow to the knee", "fallen on its sword", "lost its reality matrix cohesion", "been cleansed", "suffered the following error: (404) Porn Not Found"];
	
	trace(blah.length + " array slots");
	var select:Number = rand(blah.length);
	outputText(flags[kFLAGS.TEMP_STORAGE_SAVE_DELETION] + " has " + blah[select] + ".", true);
	test.clear();
	doNext(deleteScreen);
}

public function saveGame(slot:String):void
{
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
		outputText("", true);

		loadGameObject(saveFile, slot);
		outputText("Game Loaded");
		temp = 0;
		statScreenRefresh();
		
		if (player.slotName == "VOID")
		{
			trace("Setting in-use save slot to: " + slot);
			player.slotName = slot;
		}
		
		doNext(1);
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
	
	//CLEAR OLD ARRAYS
	
	//Save sum dataz
	trace("SAVE DATAZ");
	saveFile.data.short = player.short;
	saveFile.data.a = player.a;
	
	//Notes
	if (mainView.nameBox.text != "")
	{
		saveFile.data.notes = mainView.nameBox.text;
		getGame().notes = mainView.nameBox.text;
	}
	else
		saveFile.data.notes = getGame().notes;
	mainView.nameBox.visible = false;
	
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
		//LEVEL STATS
		saveFile.data.XP = player.XP;
		saveFile.data.level = player.level;
		saveFile.data.gems = player.gems;
		saveFile.data.perkPoints = player.perkPoints;
		
		//Appearance
		saveFile.data.gender = player.gender;
		saveFile.data.femininity = player.femininity;
		saveFile.data.thickness = player.thickness;
		saveFile.data.tone = player.tone;
		saveFile.data.tallness = player.tallness;
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
		saveFile.data.wingDesc = player.wingDesc;
		saveFile.data.wingType = player.wingType;
		saveFile.data.lowerBody = player.lowerBody;
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
		for (i = 0; i < player.perks.length; i++)
		{
			saveFile.data.perks.push([]);
				//trace("Saveone Perk");
		}
		//Populate Perk Array
		for (i = 0; i < player.perks.length; i++)
		{
			//trace("Populate One Perk");
			saveFile.data.perks[i].perkName = player.perks[i].perkName;
			saveFile.data.perks[i].value1 = player.perks[i].value1;
			saveFile.data.perks[i].value2 = player.perks[i].value2;
			saveFile.data.perks[i].value3 = player.perks[i].value3;
			saveFile.data.perks[i].value4 = player.perks[i].value4;
			saveFile.data.perks[i].perkDesc = player.perks[i].perkDesc;
		}
		
		//Set Status Array
		for (i = 0; i < player.statusAffects.length; i++)
		{
			saveFile.data.statusAffects.push([]);
				//trace("Saveone statusAffects");
		}
		//Populate Status Array
		for (i = 0; i < player.statusAffects.length; i++)
		{
			//trace("Populate One statusAffects");
			saveFile.data.statusAffects[i].statusAffectName = player.statusAffects[i].statusAffectName;
			saveFile.data.statusAffects[i].value1 = player.statusAffects[i].value1;
			saveFile.data.statusAffects[i].value2 = player.statusAffects[i].value2;
			saveFile.data.statusAffects[i].value3 = player.statusAffects[i].value3;
			saveFile.data.statusAffects[i].value4 = player.statusAffects[i].value4;
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
		for (i = 0; i < itemStorage.length; i++)
		{
			saveFile.data.itemStorage.push([]);
		}
		
		//Populate storage slot array
		for (i = 0; i < itemStorage.length; i++)
		{
			//saveFile.data.itemStorage[i].shortName = itemStorage[i].itype.id;// For backward compatibility
			saveFile.data.itemStorage[i].id = (itemStorage[i].itype == null)?null:itemStorage[i].itype.id;
			saveFile.data.itemStorage[i].quantity = itemStorage[i].quantity;
			saveFile.data.itemStorage[i].unlocked = itemStorage[i].unlocked;
		}
		//Set gear slot array
		for (i = 0; i < gearStorage.length; i++)
		{
			saveFile.data.gearStorage.push([]);
		}
		
		//Populate gear slot array
		for (i = 0; i < gearStorage.length; i++)
		{
			//saveFile.data.gearStorage[i].shortName = gearStorage[i].itype.id;// uncomment for backward compatibility
			saveFile.data.gearStorage[i].id = (gearStorage[i].isEmpty())?null:gearStorage[i].itype.id;
			saveFile.data.gearStorage[i].quantity = gearStorage[i].quantity;
			saveFile.data.gearStorage[i].unlocked = gearStorage[i].unlocked;
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
		saveFile.data.gameState = gameState;
		
		//Time and Items
		saveFile.data.hours = model.time.hours;
		saveFile.data.days = model.time.days;
		saveFile.data.autoSave = player.autoSave;
		
		//PLOTZ
		saveFile.data.whitney = getGame().whitney;
		saveFile.data.monk = getGame().monk;
		saveFile.data.sand = getGame().sand;
		saveFile.data.giacomo = getGame().giacomo;
		saveFile.data.beeProgress = getGame().beeProgress;
		
		//ITEMZ. Item1s
		saveFile.data.itemSlot1 = [];
		saveFile.data.itemSlot1.quantity = player.itemSlot1.quantity;
		//saveFile.data.itemSlot1.shortName = player.itemSlot1.itype.id;// uncomment for backward compatibility
		saveFile.data.itemSlot1.id = player.itemSlot1.itype.id;
		saveFile.data.itemSlot1.unlocked = player.itemSlot1.unlocked;
		saveFile.data.itemSlot2 = [];
		saveFile.data.itemSlot2.quantity = player.itemSlot2.quantity;
		//saveFile.data.itemSlot2.shortName = player.itemSlot2.itype.id;// uncomment for backward compatibility
		saveFile.data.itemSlot2.id = player.itemSlot2.itype.id;
		saveFile.data.itemSlot2.unlocked = player.itemSlot2.unlocked;
		saveFile.data.itemSlot3 = [];
		saveFile.data.itemSlot3.quantity = player.itemSlot3.quantity;
		//saveFile.data.itemSlot3.shortName = player.itemSlot3.itype.id;// uncomment for backward compatibility
		saveFile.data.itemSlot3.id = player.itemSlot3.itype.id;
		saveFile.data.itemSlot3.unlocked = player.itemSlot3.unlocked;
		saveFile.data.itemSlot4 = [];
		saveFile.data.itemSlot4.quantity = player.itemSlot4.quantity;
		//saveFile.data.itemSlot4.shortName = player.itemSlot4.itype.id;// uncomment for backward compatibility
		saveFile.data.itemSlot4.id = player.itemSlot4.itype.id;
		saveFile.data.itemSlot4.unlocked = player.itemSlot4.unlocked;
		saveFile.data.itemSlot5 = [];
		saveFile.data.itemSlot5.quantity = player.itemSlot5.quantity;
		//saveFile.data.itemSlot5.shortName = player.itemSlot5.itype.id;// uncomment for backward compatibility
		saveFile.data.itemSlot5.id = player.itemSlot5.itype.id;
		saveFile.data.itemSlot5.unlocked = player.itemSlot5.unlocked;
		
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
		if (!(kGAMECLASS.monkey.run))
		{
			file = new FileReference();
			//outputText(serializeToString(saveFile.data), true);
			var bytes:ByteArray = new ByteArray();
			bytes.writeObject(saveFile);
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
		doNext(1);
	}
	else
	{
		menu();
		addButton(0, "Next", eventParser, 1);
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
	doNext(1);
}

public function openSave():void
{

	// Block when running the chaos monkey
	if (!(kGAMECLASS.monkey.run))
	{
		file = new FileReference();
		file.addEventListener(Event.SELECT, onFileSelected);
		file.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
		file.browse();
		//var fileObj : Object = readObjectFromStringBytes("");
		//loadGameFile(fileObj);
	}
}


public function onFileSelected(evt:Event):void
{
	file.addEventListener(Event.COMPLETE, onFileLoaded);
	file.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
	file.load();
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
	doNext(30);
}

public function onDataLoaded(evt:Event):void
{
	//var fileObj = readObjectFromStringBytes(loader.data);
	try
	{
		// I want to be able to write some debug stuff to the GUI during the loading process
		// Therefore, we clear the display *before* calling loadGameObject
		outputText("", true);
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
		doNext(30);
	}
	catch (error:Error)
	{
		outputText("<b>!</b> Unhandled Exception", true);
		outputText("[pg]Failed to load save. The file may be corrupt!");

		doNext(30);
	}
	statScreenRefresh();
	//eventParser(1);
}

public function loadGameObject(saveData:Object, slot:String = "VOID"):void
{
	var game:CoC = getGame();
	game.dungeonLoc = 0;
	game.inDungeon = false;
	var silly:Boolean = false;
	var easy:Boolean = false;
	var sprite:Boolean = false;
	//If at initial title
	if (player.str == 0)
	{
		if (flags[kFLAGS.SHOW_SPRITES_FLAG])
			sprite = true;
		if (flags[kFLAGS.EASY_MODE_ENABLE_FLAG])
			easy = true;
		if (flags[kFLAGS.SILLY_MODE_ENABLE_FLAG])
			silly = true;
	}

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
		game.notes = saveFile.data.notes;
		
		//flags
		
		for (var i:int = 0; i < flags.length; i++)
		{
			if (saveFile.data.flags[i] != undefined)
				flags[i] = saveFile.data.flags[i];
		}
		
		//If at initial title
		if (sprite)
			flags[kFLAGS.SHOW_SPRITES_FLAG] = true;
		flags[kFLAGS.EASY_MODE_ENABLE_FLAG] = easy;
		if (silly)
			flags[kFLAGS.SILLY_MODE_ENABLE_FLAG] = true;
		
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
			player.weapon = WeaponLib.FISTS;
			for each (var itype:ItemType in ItemType.getItemLibrary()) {
				if (itype is Weapon && (itype as Weapon).name == saveFile.data.weaponName){
					player.setWeaponHiddenField(itype as Weapon || WeaponLib.FISTS);
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
			player.armor = ArmorLib.COMFORTABLE_UNDERCLOTHES;
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
							player.armor = a;
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
		
		//LEVEL STATS
		player.XP = saveFile.data.XP;
		player.level = saveFile.data.level;
		player.gems = saveFile.data.gems;
		if (saveFile.data.perkPoints == undefined)
			player.perkPoints = 0;
		else
			player.perkPoints = saveFile.data.perkPoints;
		
		//Appearance
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
			player.tongueType = TONUGE_HUMAN;
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
		player.wingDesc = saveFile.data.wingDesc;
		player.wingType = saveFile.data.wingType;
		player.lowerBody = saveFile.data.lowerBody;
		player.tailType = saveFile.data.tailType;
		player.tailVenom = saveFile.data.tailVenum;
		player.tailRecharge = saveFile.data.tailRecharge;
		player.hipRating = saveFile.data.hipRating;
		player.buttRating = saveFile.data.buttRating;
		
		//Sexual Stuff
		player.balls = saveFile.data.balls;
		player.cumMultiplier = saveFile.data.cumMultiplier;
		player.ballSize = saveFile.data.ballSize;
		player.hoursSinceCum = saveFile.data.hoursSinceCum;
		player.fertility = saveFile.data.fertility;
		player.clitLength = saveFile.data.clitLength;
		
		//Preggo stuff
		player.pregnancyIncubation = saveFile.data.pregnancyIncubation;
		player.pregnancyType = saveFile.data.pregnancyType;
		player.buttPregnancyIncubation = saveFile.data.buttPregnancyIncubation;
		player.buttPregnancyType = saveFile.data.buttPregnancyType;
		
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
			if(saveFile.data.cocks[i].sock == undefined) player.cocks[i].sock = "";
			else player.cocks[i].sock = saveFile.data.cocks[i].sock;
			if(saveFile.data.cocks[i].pierced == undefined) {
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
			if(saveFile.data.vaginas[i].type == undefined) player.vaginas[i].type = 0;
			else player.vaginas[i].type = saveFile.data.vaginas[i].type;
			if(saveFile.data.vaginas[i].labiaPierced == undefined) {
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
		//Set Perk Array
		for (i = 0; i < saveFile.data.perks.length; i++)
		{
			player.createPerk("TEMP", 0, 0, 0, 0);
				//trace("LoadOne Perk i(" + i + ")");
		}
		//Populate Perk Array
		for (i = 0; i < saveFile.data.perks.length; i++)
		{
			player.perks[i].perkName = saveFile.data.perks[i].perkName;
			player.perks[i].value1 = saveFile.data.perks[i].value1;
			player.perks[i].value2 = saveFile.data.perks[i].value2;
			player.perks[i].value3 = saveFile.data.perks[i].value3;
			player.perks[i].value4 = saveFile.data.perks[i].value4;
			if(isNaN(player.perks[i].value1)) {
				if(player.perks[i].perkName == "Wizard's Focus") {
					player.perks[i].value1 = .3;
				}
				else player.perks[i].value1 = 0;
				trace("NaN byaaaatch: " + player.perks[i].value1);
			}
			if(player.perks[i].perkName == "Wizard's Focus") {
				if(player.perks[i].value1 == 0 || player.perks[i].value1 < 0.1) {
					trace("Wizard's Focus boosted up to par (.5)");
					player.perks[i].value1 = .5;
				}
			}
			//If no save data for perkDesc, initialize it.
			if (saveFile.data.perks[i].perkDesc == undefined)
				player.perks[i].perkDesc = "<b>N/A: This is an older character file.</b>";
			else
				player.perks[i].perkDesc = saveFile.data.perks[i].perkDesc;
				//trace("Perk " + player.perks[i].perkName + " loaded.");
		}
		//Set Status Array
		for (i = 0; i < saveFile.data.statusAffects.length; i++)
		{
			player.createStatusAffect("TEMP", 0, 0, 0, 0);
		}
		//Populate Status Array
		for (i = 0; i < saveFile.data.statusAffects.length; i++)
		{
			player.statusAffects[i].statusAffectName = saveFile.data.statusAffects[i].statusAffectName;
			player.statusAffects[i].value1 = saveFile.data.statusAffects[i].value1;
			player.statusAffects[i].value2 = saveFile.data.statusAffects[i].value2;
			player.statusAffects[i].value3 = saveFile.data.statusAffects[i].value3;
			player.statusAffects[i].value4 = saveFile.data.statusAffects[i].value4;
				//trace("StatusAffect " + player.statusAffects[i].statusAffectName + " loaded.");
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
				var storage:ItemSlotClass = itemStorage[i];
				var savedIS:* = saveFile.data.itemStorage[i];
				if (savedIS.shortName && savedIS.shortName.indexOf("Gro+") != -1)
					savedIS.id = "GroPlus";
				storage.setItemAndQty(ItemType.lookupItem(savedIS.id || savedIS.shortName), savedIS.quantity);
				storage.unlocked = savedIS.unlocked;
			}
		}
		//Set gear slot array
		if (saveFile.data.gearStorage == undefined || saveFile.data.gearStorage.length < 18)
		{
			//trace("OLD SAVES DO NOT CONTAIN ITEM STORAGE ARRAY - Creating new!");
			inventory.initializeGearStorage();
		}
		else
		{
			for (i = 0; i < saveFile.data.gearStorage.length && gearStorage.length < 20; i++)
			{
				gearStorage.push(new ItemSlotClass());
					//trace("Initialize a slot for one of the item storage locations to load.");
			}
			//Populate storage slot array
			for (i = 0; i < saveFile.data.gearStorage.length && i < gearStorage.length; i++)
			{
				//trace("Populating a storage slot save with data");
				storage = gearStorage[i];
				if ((saveFile.data.gearStorage[i].shortName == undefined && saveFile.data.gearStorage[i].id == undefined)
                        || saveFile.data.gearStorage[i].quantity == undefined)
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
		gameState = saveFile.data.gameState;
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
		if (saveFile.data.beeProgress == undefined)
			game.beeProgress = 0;
		else
			game.beeProgress = saveFile.data.beeProgress;
		
		//ITEMZ. Item1
		if (saveFile.data.itemSlot1.shortName && saveFile.data.itemSlot1.shortName.indexOf("Gro+") != -1)
			saveFile.data.itemSlot1.id = "GroPlus";
		if (saveFile.data.itemSlot2.shortName && saveFile.data.itemSlot2.shortName.indexOf("Gro+") != -1)
			saveFile.data.itemSlot2.id = "GroPlus";
		if (saveFile.data.itemSlot3.shortName && saveFile.data.itemSlot3.shortName.indexOf("Gro+") != -1)
			saveFile.data.itemSlot3.id = "GroPlus";
		if (saveFile.data.itemSlot4.shortName && saveFile.data.itemSlot4.shortName.indexOf("Gro+") != -1)
			saveFile.data.itemSlot4.id = "GroPlus";
		if (saveFile.data.itemSlot5.shortName && saveFile.data.itemSlot5.shortName.indexOf("Gro+") != -1)
			saveFile.data.itemSlot5.id = "GroPlus";
		player.itemSlot1.unlocked = saveFile.data.itemSlot1.unlocked;
		player.itemSlot1.setItemAndQty(ItemType.lookupItem(saveFile.data.itemSlot1.id),saveFile.data.itemSlot1.quantity);
		player.itemSlot2.unlocked = saveFile.data.itemSlot2.unlocked;
		player.itemSlot2.setItemAndQty(ItemType.lookupItem(saveFile.data.itemSlot2.id),saveFile.data.itemSlot2.quantity);
		player.itemSlot3.unlocked = saveFile.data.itemSlot3.unlocked;
		player.itemSlot3.setItemAndQty(ItemType.lookupItem(saveFile.data.itemSlot3.id),saveFile.data.itemSlot3.quantity);
		player.itemSlot4.unlocked = saveFile.data.itemSlot4.unlocked;
		player.itemSlot4.setItemAndQty(ItemType.lookupItem(saveFile.data.itemSlot4.id),saveFile.data.itemSlot4.quantity);
		player.itemSlot5.unlocked = saveFile.data.itemSlot5.unlocked;
		player.itemSlot5.setItemAndQty(ItemType.lookupItem(saveFile.data.itemSlot5.id),saveFile.data.itemSlot5.quantity);

		unFuckSave();
		
		// Control Bindings
		if (saveFile.data.controls != undefined)
		{
			game.inputManager.LoadBindsFromObj(saveFile.data.controls);
		}
		
		doNext(1);
	}
}

public function unFuckSave():void
{
	//Fixing shit!

	// Fix duplicate elven bounty perks
	if(player.hasPerk("Elven Bounty") >= 0) {
		//CLear duplicates
		while(player.perkDuplicated("Elven Bounty")) player.removePerk("Elven Bounty");
		//Fix fudged preggers value
		if(player.perkv1("Elven Bounty") == 15) {
			player.changePerkValue("Elven Bounty",1,0);
			player.addPerkValue("Elven Bounty",2,15);
		}
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
   if(saveType != 0)
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