// Hooking things to MainView.
this.mainView.onNewGameClick = newGameGo;
this.mainView.onAppearanceClick = appearance;
this.mainView.onDataClick = saveLoad;
this.mainView.onLevelClick = levelUpGo;
this.mainView.onPerksClick = displayPerks;
this.mainView.onStatsClick = displayStats;

this.mainView._executeButtomButtonClick = executeButtonClick;

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
		trace("FUNC: " + func + "ARG: " + arg);
		if(arg == -9000) func();
		else func(arg);
	}
}


//Hugeass keyboard parser
function keyboard(e:KeyboardEvent):void {
	if(eventTestInput.x == 207.5) return;
	if(nameBox.visible && stage.focus == nameBox) return;
    var saveFile;
	var currEvent:Number = 0;
	var f:MouseEvent = undefined;
	trace("Keyboard key inputted.  Keycode: " + e.keyCode);
	//Cheat Code stuff!
	if(flags[CHEAT_ENTERING_COUNTER] == 0) {
		if(e.keyCode == 38) flags[CHEAT_ENTERING_COUNTER]++;
		else flags[CHEAT_ENTERING_COUNTER] = 0;
	}
	else if(flags[CHEAT_ENTERING_COUNTER] == 1) {
		if(e.keyCode == 40) flags[CHEAT_ENTERING_COUNTER]++;
		else flags[CHEAT_ENTERING_COUNTER] = 0;
	}
	else if(flags[CHEAT_ENTERING_COUNTER] == 2) {
		if(e.keyCode == 37) flags[CHEAT_ENTERING_COUNTER]++;
		else flags[CHEAT_ENTERING_COUNTER] = 0;
	}
	else if(flags[CHEAT_ENTERING_COUNTER] == 3 && player.str > 0 && b1Text.text.indexOf("Game Over") == -1) {
		if(e.keyCode == 39) {
			giveHumanizer();
			return;
		}
		else flags[CHEAT_ENTERING_COUNTER] = 0;
	}
	//Stats Hotkey
	if(e.keyCode == 83 && statsBG.visible && player.str > 0) {
		displayStats(f);
		return;
	}
	//Level up Hotkey
	if(e.keyCode == 76 && levelBG.visible && player.str > 0) {
		levelUpGo(f);
		return;
	}
	//f1 pressed - save in slot 1
	if(e.keyCode == 112 && dataBG.visible && player.str > 0) {
		nameBox.text = "";
		saveGame("CoC_1");
		outputText("Game saved to slot 1!", true);
		doNext(1);
		return;
	}
	//f2 pressed - save in slot 2
	if(e.keyCode == 113 && dataBG.visible && player.str > 0) {
		nameBox.text = "";
		saveGame("CoC_2");
		outputText("Game saved to slot 2!", true);
		doNext(1);
		return;
	}
	//f3 pressed - save in slot 3
	if(e.keyCode == 114 && dataBG.visible && player.str > 0) {
		nameBox.text = "";
		saveGame("CoC_3");
		outputText("Game saved to slot 3!", true);
		doNext(1);
		return;
	}
	//f4 pressed - save in slot 4
	if(e.keyCode == 115 && dataBG.visible && player.str > 0) {
		nameBox.text = "";
		saveGame("CoC_4");
		outputText("Game saved to slot 4!", true);
		doNext(1);
		return;
	}
	//f5 pressed - save in slot 5
	if(e.keyCode == 116 && dataBG.visible && player.str > 0) {
		nameBox.text = "";
		saveGame("CoC_5");
		outputText("Game saved to slot 5!", true);
		doNext(1);
		return;
	}
	//f6 pressed - load slot 1
	if(e.keyCode == 117 && dataBG.visible) {
		saveFile = SharedObject.getLocal("CoC_1","/");
		if(saveFile.data.exists) {
			if(loadGame("CoC_1")) {
				showStats();
				statScreenRefresh();
				outputText("Slot 1 Loaded!", true);
				doNext(1);
			}
		}
	}
	//f7 pressed - load slot 2
	if(e.keyCode == 118 && dataBG.visible) {
		saveFile = SharedObject.getLocal("CoC_2","/");
		if(saveFile.data.exists) {
			if(loadGame("CoC_2")) {
				showStats();
				statScreenRefresh();
				outputText("Slot 2 Loaded!", true);
				doNext(1);
			}
		}
	}
	//f8 pressed - load slot 3
	if(e.keyCode == 119 && dataBG.visible) {
		saveFile = SharedObject.getLocal("CoC_3","/");
		if(saveFile.data.exists) {
			if(loadGame("CoC_3")) {
				showStats();
				statScreenRefresh();
				outputText("Slot 3 Loaded!", true);
				doNext(1);
			}
		}
	}
	//f9 pressed - load slot 4
	if(e.keyCode == 120 && dataBG.visible) {
		saveFile = SharedObject.getLocal("CoC_4","/");
		if(saveFile.data.exists) {
			if(loadGame("CoC_4")) {
				showStats();
				statScreenRefresh();
				outputText("Slot 4 Loaded!", true);
				doNext(1);
			}
		}
	}
	//f10 pressed - load slot 5
	if(e.keyCode == 121 && dataBG.visible) {
		saveFile = SharedObject.getLocal("CoC_5","/");
		if(saveFile.data.exists) {
			if(loadGame("CoC_5")) {
				showStats();
				statScreenRefresh();
				outputText("Slot 5 Loaded!", true);
				doNext(1);
			}
		}
	}
	//Backspace pressed! New Game!
	if(e.keyCode == 8 && newGameBG.visible && newGameText.text == "Main Menu") {
		//newGameGo(f);
		mainMenu(f);
		return;
	}
	//D Pressed! call data!"
	if(e.keyCode == 68 && dataBG.visible) {
		saveLoad(f);
		return;
	}
	//A pressed! call appearance!"
	if(e.keyCode == 65 && appearanceBG.visible) {
		appearance(f);
		return;
	}
	//N pressed! Equal to no!"
	if(e.keyCode == 78 && b2Text.text == "No" && b2Text.visible == true) {
		currEvent = button2Choice;
		//eventParser(currEvent);
		executeButtonClick(1);
		return;
	}
	//Y pressed! Equal to Yes!"
	if(e.keyCode == 89 && b1Text.text == "Yes" && b1Text.visible == true) {
		currEvent = buttonEvents[0];
		//eventParser(currEvent);
		executeButtonClick(0);
		return;
	}
	if(e.keyCode == 80 && perksText.visible == true && perksBG.visible == true) {
		displayPerks(f);
		return;
	}
	//If 32 pressed or 13 pressed (enter/space) - NEXT
	if(e.keyCode == 13 || e.keyCode == 32) {
		if(b0Text.visible && ((b0Text.text == "Nevermind" || b0Text.text == "Abandon" || b0Text.text == "Next" || b0Text.text == "Return" || b0Text.text == "Back" || b0Text.text == "Leave" || b0Text.text == "Resume"))) {
			mouseOverText.visible = false;
			//eventParser(button0Choice);
			executeButtonClick(9);
			return;
		}
		if(b1Text.visible && ((b1Text.text == "Next" || b1Text.text == "Return" || b1Text.text == "Back"))) {
			mouseOverText.visible = false;
			//eventParser(button1Choice);
			executeButtonClick(0);
			return;
		}
		if(b5Text.visible && ((b5Text.text == "Nevermind" || b5Text.text == "Next" || b5Text.text == "Return" || b5Text.text == "Back" || b5Text.text == "Leave"))) {
			mouseOverText.visible = false;
			//eventParser(button5Choice);
			executeButtonClick(4);
			return;
		}
		if(b6Text.visible && ((b6Text.text == "Next" || b6Text.text == "Return" || b6Text.text == "Back"))) {
			mouseOverText.visible = false;
			//eventParser(button6Choice);
			executeButtonClick(5);
			return;
		}
		
		return;
	}
	//Home key cycles background presets!
	if(e.keyCode == 36) {
		if(!mainView.textBGWhite.visible) mainView.textBGWhite.visible = true;
		else if(!mainView.textBGTan.visible) mainView.textBGTan.visible = true;
		else {
			mainView.textBGTan.visible = false;
			mainView.textBGWhite.visible = false;
		}
	}		
	//If 1 key pressed!
	if(e.keyCode == 49) {
		if(b1Text.visible == false)
		{
			trace("Key 1 pressed while inactive.");
			return;
		}
		mouseOverText.visible = false;
		//eventParser(currEvent);
		executeButtonClick(0);
		return;
	}
	//If 2 key pressed!
	if(e.keyCode == 50) {
		if(b2Text.visible == false)
		{
			trace("Key 2 pressed while inactive.");
			return;
		}
		mouseOverText.visible = false;
		executeButtonClick(1);
		return;
	}
	//If 3 key pressed!
	if(e.keyCode == 51) {
		if(b3Text.visible == false)
		{
			trace("Key 3 pressed while inactive.");
			return;
		}
		mouseOverText.visible = false;
		executeButtonClick(2);
		return;
	}
	//If 4 key pressed, or enter when text is "leave", "back", or "return".
	if(e.keyCode == 52) {
		if(b4Text.visible == false)
		{
			trace("Key 4 pressed while inactive.");
			return;
		}
		mouseOverText.visible = false;
		executeButtonClick(3);
		return;
	}
	if(e.keyCode == 53) {
		if(b5Text.visible == false)
		{
			trace("Key 5 pressed while inactive.");
			return;
		}
		mouseOverText.visible = false;
		executeButtonClick(4);
		return;
	}
	if(e.keyCode == 54 || e.keyCode == 81) {
		if(b6Text.visible == false)
		{
			trace("Key 6 pressed while inactive.");
			return;
		}
		mouseOverText.visible = false;
		executeButtonClick(5);
		return;
	}
	if(e.keyCode == 55 || e.keyCode == 87) {
		if(b7Text.visible == false)
		{
			trace("Key 7 pressed while inactive.");
			return;
		}
		mouseOverText.visible = false;
		executeButtonClick(6);
		return;
	}
	if(e.keyCode == 56 || e.keyCode == 69) {
		if(b8Text.visible == false)
		{
			trace("Key 8 pressed while inactive.");
			return;
		}
		mouseOverText.visible = false;
		executeButtonClick(7);
		return;
	}
	if(e.keyCode == 57 || e.keyCode == 82) {
		if(b9Text.visible == false)
		{
			trace("Key 9 pressed while inactive.");
			return;
		}
		mouseOverText.visible = false;
		executeButtonClick(8);
		return;
	}
	if(e.keyCode == 48 || e.keyCode == 84) {
		if(b0Text.visible == false)
		{
			trace("Key 0 pressed while inactive.");
			return;
		}
		mouseOverText.visible = false;
		executeButtonClick(9);
		return;
	}
	//Save box
	if(e.keyCode == 68 && dataBG.visible == true) {

	}
	
}


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
 
var aCb:ComboBox = new ComboBox(); 
aCb.dropdownWidth = 200; 
aCb.width = 200; 
aCb.scaleY = 1.1;
aCb.move(-1250, -1550); 
aCb.prompt = "Choose a perk"; 
aCb.dataProvider = new DataProvider(perkList); 
aCb.addEventListener(Event.CHANGE, changeHandler); 
 
addChild(aCb);

function changeHandler(event:Event):void { 
 	//Store perk name for later addition
 	tempPerk = ComboBox(event.target).selectedItem.label; 
	aCb.move(210, 80);
	outputText("You have selected the following perk:\n\n", true);
	outputText("<b>" + tempPerk + ":</b> " + perkLongDescription(tempPerk) + "\n\nIf you would like to select this perk, click <b>Okay</b>.  Otherwise, select a new perk, or press <b>Skip</b> to make a decision later.", false);
	simpleChoices("Okay",114,"Skip",115,"",0,"",0,"",0);
}


 /*HOLY SHIT THIS HOW TO DO URL LINKS!
function changeHandler(event:Event):void { 
    var request:URLRequest = new URLRequest(); 
    request.url = ComboBox(event.target).selectedItem.data; 
    navigateToURL(request); 
    aCb.selectedIndex = -1; 
}*/