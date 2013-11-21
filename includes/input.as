import classes.InputManager;

// Hooking things to MainView.
mainView.onNewGameClick = newGameGo;
mainView.onAppearanceClick = appearance;
mainView.onDataClick = saveLoad;
mainView.onLevelClick = levelUpGo;
mainView.onPerksClick = displayPerks;
mainView.onStatsClick = displayStats;

mainView._executeButtomButtonClick = executeButtonClick;

var inputManager:InputManager = new InputManager(stage);

// function buttonEvent(e:MouseEvent):void {
// 	mouseOverText.visible = false;
// 	var buttonIndex:int = 0;
// 	//Set temp equal to the button that was clicked.
// 	while(buttonIndex < 10) {
// 		if(e.target == gButtons[buttonIndex]) break;
// 		buttonIndex++;
// 	}
// 	if(e.target == b1Text) buttonIndex = 0;
// 	else if(e.target == b2Text) 
// 		buttonIndex = 1;
// 	else if(e.target == b3Text) 
// 		buttonIndex = 2;
// 	else if(e.target == b4Text) 
// 		buttonIndex = 3;
// 	else if(e.target == b5Text) 
// 		buttonIndex = 4;
// 	else if(e.target == b6Text) 
// 		buttonIndex = 5;
// 	else if(e.target == b7Text) 
// 		buttonIndex = 6;
// 	else if(e.target == b8Text) 
// 		buttonIndex = 7;
// 	else if(e.target == b9Text) 
// 		buttonIndex = 8;
// 	else if(e.target == b0Text) 
// 		buttonIndex = 9;
// 	//Standard method.
// 	//trace("FUNC LENGTH" + funcs.length);
// 	executeButtonClick(buttonIndex);
// }

function executeButtonClick(button:int = 0):void {
	if(funcs.length == 0) {
		trace("Calling eventParser on buttonEvents[" + String( button ) + "]:",
			buttonEvents[ button ]);
		eventParser(buttonEvents[button]);
	}
	else if(funcs.length - 1 < button) {
		trace("ERROR: INVALID FUNCTION LOCATION");
	}
	else if(funcs[button] == null) {
		trace("ERROR: NULL FUNCTION");
	}
	else {
		//Store the arg and function and then clear those arrays so we can go back to regular
		//codes if necessary.
		hideMenus();
		var func = funcs[button];
		var arg = args[button];
		funcs = new Array();
		args = new Array();
		trace("Calling Func: " + func + "ARG: " + arg);
		if(arg == -9000) func();
		else func(arg);
	}
}


inputManager.AddBindableControl(
	"Show Stats",
	"Show the stats pane when available",
	function():void {
		if (mainView.menuButtonIsVisible(MainView.MENU_STATS) && player.str > 0)
		{
			displayStats(undefined);
		}
	});

inputManager.AddBindableControl(
	"Level Up",
	"Show the level up page when available",
	function():void {
		if (mainView.menuButtonIsVisible(MainView.MENU_LEVEL) && player.str > 0)
		{
			levelUpGo(undefined);
		}
	});

inputManager.AddBindableControl(
	"Quicksave 1",
	"Quicksave the current game to slot 1",
	function():void {
		if (mainView.menuButtonIsVisible(MainView.MENU_DATA) && player.str > 0)
		{
			mainView.nameBox.text = "";
			saveGame("CoC_1");
			outputText("Game saved to slot 1!", true);
			doNext(1);
		}
	});
	
inputManager.AddBindableControl(
	"Quicksave 2",
	"Quicksave the current game to slot 2",
	function():void {
		if (mainView.menuButtonIsVisible(MainView.MENU_DATA) && player.str > 0)
		{
			mainView.nameBox.text = "";
			saveGame("CoC_2");
			outputText("Game saved to slot 2!", true);
			doNext(1);
		}
	});
	
inputManager.AddBindableControl(
	"Quicksave 3",
	"Quicksave the current game to slot 2",
	function():void {
		if (mainView.menuButtonIsVisible(MainView.MENU_DATA) && player.str > 0)
		{
			mainView.nameBox.text = "";
			saveGame("CoC_3");
			outputText("Game saved to slot 3!", true);
			doNext(1);
		}
	});
	
inputManager.AddBindableControl(
	"Quicksave 4",
	"Quicksave the current game to slot 4",
	function():void {
		if (mainView.menuButtonIsVisible(MainView.MENU_DATA) && player.str > 0)
		{
			mainView.nameBox.text = "";
			saveGame("CoC_4");
			outputText("Game saved to slot 4!", true);
			doNext(1);
		}
	});
	
inputManager.AddBindableControl(
	"Quicksave 5",
	"Quicksave the current game to slot 5",
	function():void {
		if (mainView.menuButtonIsVisible(MainView.MENU_DATA) && player.str > 0)
		{
			mainView.nameBox.text = "";
			saveGame("CoC_5");
			outputText("Game saved to slot 5!", true);
			doNext(1);
		}
	});
	
inputManager.AddBindableControl(
	"Quickload 1",
	"Quickload the current game from slot 1",
	function():void {
		if (mainView.menuButtonIsVisible(MainView.MENU_DATA))
		{
			var saveFile:* = SharedObject.getLocal("CoC_1", "/");
			if (saveFile.data.exists)
			{
				if (loadGame("CoC_1"))
				{
					showStats();
					statScreenRefresh();
					outputText("Slot 1 Loaded!", true);
					doNext(1);
				}
			}
		}
	});

inputManager.AddBindableControl(
	"Quickload 2",
	"Quickload the current game from slot 2",
	function():void {
		if (mainView.menuButtonIsVisible(MainView.MENU_DATA))
		{
			var saveFile:* = SharedObject.getLocal("CoC_2", "/");
			if (saveFile.data.exists)
			{
				if (loadGame("CoC_2"))
				{
					showStats();
					statScreenRefresh();
					outputText("Slot 2 Loaded!", true);
					doNext(1);
				}
			}
		}
	});
	
inputManager.AddBindableControl(
	"Quickload 3",
	"Quickload the current game from slot 3",
	function():void {
		if (mainView.menuButtonIsVisible(MainView.MENU_DATA))
		{
			var saveFile:* = SharedObject.getLocal("CoC_3", "/");
			if (saveFile.data.exists)
			{
				if (loadGame("CoC_3"))
				{
					showStats();
					statScreenRefresh();
					outputText("Slot 3 Loaded!", true);
					doNext(1);
				}
			}
		}
	});
	
inputManager.AddBindableControl(
	"Quickload 4",
	"Quickload the current game from slot 4",
	function():void {
		if (mainView.menuButtonIsVisible(MainView.MENU_DATA))
		{
			var saveFile:* = SharedObject.getLocal("CoC_4", "/");
			if (saveFile.data.exists)
			{
				if (loadGame("CoC_4"))
				{
					showStats();
					statScreenRefresh();
					outputText("Slot 4 Loaded!", true);
					doNext(1);
				}
			}
		}
	});
	
inputManager.AddBindableControl(
	"Quickload 5",
	"Quickload the current game from slot 5",
	function():void {
		if (mainView.menuButtonIsVisible(MainView.MENU_DATA))
		{
			var saveFile:* = SharedObject.getLocal("CoC_5", "/");
			if (saveFile.data.exists)
			{
				if (loadGame("CoC_5"))
				{
					showStats();
					statScreenRefresh();
					outputText("Slot 5 Loaded!", true);
					doNext(1);
				}
			}
		}
	});
	
inputManager.AddBindableControl(
	"Show Menu",
	"Show the main menu",
	function():void {
		if (mainView.menuButtonIsVisible(MainView.MENU_NEW_MAIN) && mainView.menuButtonHasLabel(MainView.MENU_NEW_MAIN, "Main Menu"))
		{
			mainMenu(undefined);
		}
	});

inputManager.AddBindableControl(
	"Data Menu",
	"Show the save/load menu",
	function():void {
		if (mainView.menuButtonIsVisible(MainView.MENU_DATA))
		{
			saveLoad(undefined);
		}
	});
	
inputManager.AddBindableControl(
	"Appearance Page",
	"Show the appearance page",
	function():void {
		if (mainView.menuButtonIsVisible(MainView.MENU_APPEARANCE))
		{
			appearance(undefined);
		}
	});
	
inputManager.AddBindableControl(
	"No",
	"Respond no to any available prompt",
	function():void {
		if (mainView.getButtonText(1) == "No" && mainView.buttonIsVisible(1))
		{
			executeButtonClick(1);
		}
	});
	
inputManager.AddBindableControl(
	"Yes",
	"Respond yes to any available prompt",
	function():void {
		if (mainView.getButtonText(0) == "Yes" && mainView.buttonIsVisible(0))
		{
			executeButtonClick(0);
		}
	});
	
inputManager.AddBindableControl(
	"Show Perks",
	"Show the perks page",
	function():void {
		if (mainView.menuButtonIsVisible(MainView.MENU_PERKS))
		{
			displayPerks(undefined);
		}
	});

inputManager.AddBindableControl(
	"Continue",
	"Respond to continue",
	function():void {
		// Button 9
		if (mainView.buttonIsVisible(9) && mainView.buttonTextIsOneOf(9, [ "Nevermind", "Abandon", "Next", "Return", "Back", "Leave", "Resume" ]))
		{
			trace( "keyboard(): processing space bar for button 9",
				mainView.buttonIsVisible( 9 ) ? "(visible)" : "(hidden)",
				mainView.getButtonText( 9 ) );
			mainView.toolTipView.hide();
			executeButtonClick(9);
			return;
		}
		
		// Button 0
		if (mainView.buttonIsVisible(0) && mainView.buttonTextIsOneOf(0, [ "Next", "Return", "Back" ]))
		{
			trace( "keyboard(): processing space bar for button 0",
				mainView.buttonIsVisible( 0 ) ? "(visible)" : "(hidden)",
				mainView.getButtonText( 0 ) );
			mainView.toolTipView.hide();
			executeButtonClick(0);
			return;
		}
		
		// Button 4
		if (mainView.buttonIsVisible(4) && mainView.buttonTextIsOneOf(4, [ "Nevermind", "Next", "Return", "Back", "Leave" ]))
		{
			trace( "keyboard(): processing space bar for button 4",
				mainView.buttonIsVisible( 4 ) ? "(visible)" : "(hidden)",
				mainView.getButtonText( 4 ) );
			mainView.toolTipView.hide();
			executeButtonClick(4);
			return;
		}
		
		// Button 5
		if (mainView.buttonIsVisible(5) && mainView.buttonTextIsOneOf(5, [ "Next", "Return", "Back" ]))
		{
			trace( "keyboard(): processing space bar for button 5",
				mainView.buttonIsVisible( 5 ) ? "(visible)" : "(hidden)",
				mainView.getButtonText( 5 ) );
			mainView.toolTipView.hide();
			executeButtonClick(5);
			return;
		}
	});
	
inputManager.AddBindableControl(
	"Cycle Background",
	"Cycle the background fill of the text display area",
	function():void {
		if (!mainView.textBGWhite.visible)
		{
			mainView.textBGWhite.visible = true;
		}
		else if (!mainView.textBGTan.visible)
		{
			mainView.textBGTan.visible = true;
		}
		else
		{
			mainView.textBGWhite.visible = false;
			mainView.textBGTan.visible = false;
		}
		
	});
	
inputManager.AddBindableControl(
	"Button 1",
	"Activate button 1",
	function():void {
		if (mainView.buttonIsVisible(0))
		{
			mainView.toolTipView.hide();
			executeButtonClick(0);
		}
	});

inputManager.AddBindableControl(
	"Button 2",
	"Activate button 2",
	function():void {
		if (mainView.buttonIsVisible(1))
		{
			mainView.toolTipView.hide();
			executeButtonClick(1);
		}
	});
	
inputManager.AddBindableControl(
	"Button 3",
	"Activate button 3",
	function():void {
		if (mainView.buttonIsVisible(2))
		{
			mainView.toolTipView.hide();
			executeButtonClick(2);
		}
	});
	
inputManager.AddBindableControl(
	"Button 4",
	"Activate button 4",
	function():void {
		if (mainView.buttonIsVisible(3))
		{
			mainView.toolTipView.hide();
			executeButtonClick(3);
		}
	});
	
inputManager.AddBindableControl(
	"Button 5",
	"Activate button 5",
	function():void {
		if (mainView.buttonIsVisible(4))
		{
			mainView.toolTipView.hide();
			executeButtonClick(4);
		}
	});
	
inputManager.AddBindableControl(
	"Button 6",
	"Activate button 6",
	function():void {
		if (mainView.buttonIsVisible(5))
		{
			mainView.toolTipView.hide();
			executeButtonClick(5);
		}
	});
	
inputManager.AddBindableControl(
	"Button 7",
	"Activate button 7",
	function():void {
		if (mainView.buttonIsVisible(6))
		{
			mainView.toolTipView.hide();
			executeButtonClick(6);
		}
	});
	
inputManager.AddBindableControl(
	"Button 8",
	"Activate button 8",
	function():void {
		if (mainView.buttonIsVisible(7))
		{
			mainView.toolTipView.hide();
			executeButtonClick(7);
		}
	});
	
inputManager.AddBindableControl(
	"Button 9",
	"Activate button 9",
	function():void {
		if (mainView.buttonIsVisible(8))
		{
			mainView.toolTipView.hide();
			executeButtonClick(8);
		}
	});
	
inputManager.AddBindableControl(
	"Button 10",
	"Activate button 10",
	function():void {
		if (mainView.buttonIsVisible(9))
		{
			mainView.toolTipView.hide();
			executeButtonClick(9);
		}
	});

inputManager.AddBindableControl(
	"Cheat! Give Hummus",
	"Cheat code to get free hummus",
	function(keyCode:int):void {
		if (flags[CHEAT_ENTERING_COUNTER] == 0)
		{
			if (keyCode == 38)
			{
				flags[CHEAT_ENTERING_COUNTER]++;
			}
			else
			{
				flags[CHEAT_ENTERING_COUNTER] = 0;
			}
		}
		else if (flags[CHEAT_ENTERING_COUNTER] == 1)
		{
			if (keyCode == 40)
			{
				flags[CHEAT_ENTERING_COUNTER]++;
			}
			else
			{
				flags[CHEAT_ENTERING_COUNTER] = 0;
			}
		}
		else if (flags[CHEAT_ENTERING_COUNTER] == 2)
		{
			if (keyCode == 37)
			{
				flags[CHEAT_ENTERING_COUNTER]++;
			}
			else
			{
				flags[CHEAT_ENTERING_COUNTER] = 0;
			}
		}
		else if (flags[CHEAT_ENTERING_COUNTER] == 3)
		{
			if (keyCode == 39)
			{
				if (player.str > 0 && mainView.getButtonText(0).indexOf("Game Over") == -1)
				{
					giveHumanizer();
				}
			}
			else
			{
				flags[CHEAT_ENTERING_COUNTER] = 0;
			}
		}
	},
	true);

// Insert the default bindings
inputManager.BindKeyToControl(83, "Show Stats");
inputManager.BindKeyToControl(76, "Level Up");
inputManager.BindKeyToControl(112, "Quicksave 1");
inputManager.BindKeyToControl(113, "Quicksave 2");
inputManager.BindKeyToControl(114, "Quicksave 3");
inputManager.BindKeyToControl(115, "Quicksave 4");
inputManager.BindKeyToControl(116, "Quicksave 5");
inputManager.BindKeyToControl(117, "Quickload 1");
inputManager.BindKeyToControl(118, "Quickload 2");
inputManager.BindKeyToControl(119, "Quickload 3");
inputManager.BindKeyToControl(120, "Quickload 4");
inputManager.BindKeyToControl(121, "Quickload 5");
inputManager.BindKeyToControl(8, "Show Menu");
inputManager.BindKeyToControl(68, "Data Menu");
inputManager.BindKeyToControl(65, "Appearance Page");
inputManager.BindKeyToControl(78, "No");
inputManager.BindKeyToControl(89, "Yes");
inputManager.BindKeyToControl(80, "Show Perks");
inputManager.BindKeyToControl(13, "Continue");
inputManager.BindKeyToControl(32, "Continue");
inputManager.BindKeyToControl(36, "Cycle Background");
inputManager.BindKeyToControl(49, "Button 1");
inputManager.BindKeyToControl(50, "Button 2");
inputManager.BindKeyToControl(51, "Button 3");
inputManager.BindKeyToControl(52, "Button 4");
inputManager.BindKeyToControl(53, "Button 5");
inputManager.BindKeyToControl(54, "Button 6");
inputManager.BindKeyToControl(55, "Button 7");
inputManager.BindKeyToControl(56, "Button 8");
inputManager.BindKeyToControl(57, "Button 9");
inputManager.BindKeyToControl(48, "Button 10");
inputManager.BindKeyToControl(81, "Button 6");
inputManager.BindKeyToControl(87, "Button 7");
inputManager.BindKeyToControl(69, "Button 8");
inputManager.BindKeyToControl(82, "Button 9");
inputManager.BindKeyToControl(84, "Button 10");



//DROPDOWN BOX STUFF
// import fl.controls.ComboBox; 
// import fl.data.DataProvider; 
// import flash.net.navigateToURL; 
 
var perkList:Array = new Array( 
    {label:"Pretend Strength Perk"},
    {label:"Pretend Speed Perk"}
 	/*{label:"Pretend Strength Perk",  
                data:2}, 
    {label:"Pretend Speed Perk",  
                data:3}*/
); 
 
//var mainView.aCb:ComboBox = new ComboBox(); 
//mainView.aCb.dropdownWidth = 200; 
//mainView.aCb.width = 200; 
//mainView.aCb.scaleY = 1.1;
//mainView.aCb.move(-1250, -1550); 
//mainView.aCb.prompt = "Choose a perk"; 
mainView.aCb.dataProvider = new DataProvider(perkList); 
mainView.aCb.addEventListener(Event.CHANGE, changeHandler); 
 
addChild(mainView.aCb);

function changeHandler(event:Event):void { 
 	//Store perk name for later addition
 	tempPerk = ComboBox(event.target).selectedItem.label; 
	mainView.aCb.move(210, 80);
	outputText("You have selected the following perk:\n\n", true);
	outputText("<b>" + tempPerk + ":</b> " + perkLongDescription(tempPerk) + "\n\nIf you would like to select this perk, click <b>Okay</b>.  Otherwise, select a new perk, or press <b>Skip</b> to make a decision later.", false);
	simpleChoices("Okay",114,"Skip",115,"",0,"",0,"",0);
}


 /*HOLY SHIT THIS HOW TO DO URL LINKS!
function changeHandler(event:Event):void { 
    var request:URLRequest = new URLRequest(); 
    request.url = ComboBox(event.target).selectedItem.data; 
    navigateToURL(request); 
    mainView.aCb.selectedIndex = -1; 
}*/
