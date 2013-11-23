// Hooking things to MainView.
// mainView.onNewGameClick = newGameGo;
// mainView.onAppearanceClick = appearance;
// mainView.onDataClick = saveLoad;
// mainView.onLevelClick = levelUpGo;
// mainView.onPerksClick = displayPerks;
// mainView.onStatsClick = displayStats;


// mainView._executeButtomButtonClick = executeButtonClick;

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
	mainView.clickButton( button );
}


//Hugeass keyboard parser
function keyboard(e:KeyboardEvent):void {
	if(mainView.eventTestInput.x == 207.5) return;
	if(mainView.nameBox.visible && stage.focus == mainView.nameBox) return;
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
	else if(flags[CHEAT_ENTERING_COUNTER] == 3 && player.str > 0 && mainView.getButtonText( 0 ).indexOf("Game Over") == -1) {
		if(e.keyCode == 39) {
			giveHumanizer();
			return;
		}
		else flags[CHEAT_ENTERING_COUNTER] = 0;
	}
	//Stats Hotkey
	if(e.keyCode == 83 && mainView.menuButtonIsVisible( MainView.MENU_STATS ) && player.str > 0) {
		displayStats(f);
		return;
	}
	//Level up Hotkey
	if(e.keyCode == 76 && mainView.menuButtonIsVisible( MainView.MENU_LEVEL ) && player.str > 0) {
		levelUpGo(f);
		return;
	}
	//f1 pressed - save in slot 1
	if(e.keyCode == 112 && mainView.menuButtonIsVisible( MainView.MENU_DATA ) && player.str > 0) {
		mainView.nameBox.text = "";
		saveGame("CoC_1");
		outputText("Game saved to slot 1!", true);
		doNext(1);
		return;
	}
	//f2 pressed - save in slot 2
	if(e.keyCode == 113 && mainView.menuButtonIsVisible( MainView.MENU_DATA ) && player.str > 0) {
		mainView.nameBox.text = "";
		saveGame("CoC_2");
		outputText("Game saved to slot 2!", true);
		doNext(1);
		return;
	}
	//f3 pressed - save in slot 3
	if(e.keyCode == 114 && mainView.menuButtonIsVisible( MainView.MENU_DATA ) && player.str > 0) {
		mainView.nameBox.text = "";
		saveGame("CoC_3");
		outputText("Game saved to slot 3!", true);
		doNext(1);
		return;
	}
	//f4 pressed - save in slot 4
	if(e.keyCode == 115 && mainView.menuButtonIsVisible( MainView.MENU_DATA ) && player.str > 0) {
		mainView.nameBox.text = "";
		saveGame("CoC_4");
		outputText("Game saved to slot 4!", true);
		doNext(1);
		return;
	}
	//f5 pressed - save in slot 5
	if(e.keyCode == 116 && mainView.menuButtonIsVisible( MainView.MENU_DATA ) && player.str > 0) {
		mainView.nameBox.text = "";
		saveGame("CoC_5");
		outputText("Game saved to slot 5!", true);
		doNext(1);
		return;
	}
	//f6 pressed - load slot 1
	if(e.keyCode == 117 && mainView.menuButtonIsVisible( MainView.MENU_DATA )) {
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
	if(e.keyCode == 118 && mainView.menuButtonIsVisible( MainView.MENU_DATA )) {
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
	if(e.keyCode == 119 && mainView.menuButtonIsVisible( MainView.MENU_DATA )) {
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
	if(e.keyCode == 120 && mainView.menuButtonIsVisible( MainView.MENU_DATA )) {
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
	if(e.keyCode == 121 && mainView.menuButtonIsVisible( MainView.MENU_DATA )) {
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
	if(e.keyCode == 8 && mainView.menuButtonIsVisible( MainView.MENU_NEW_MAIN ) && mainView.menuButtonHasLabel( MainView.MENU_NEW_MAIN, "Main Menu" )) {
		//newGameGo(f);
		mainMenu(f);
		return;
	}
	//D Pressed! call data!"
	if(e.keyCode == 68 && mainView.menuButtonIsVisible( MainView.MENU_DATA )) {
		saveLoad(f);
		return;
	}
	//A pressed! call appearance!"
	if(e.keyCode == 65 && mainView.menuButtonIsVisible( MainView.MENU_APPEARANCE )) {
		appearance(f);
		return;
	}
	//N pressed! Equal to no!"
	if(e.keyCode == 78 && mainView.getButtonText( 1 ) == "No" && mainView.buttonIsVisible( 1 )) {
		currEvent = button2Choice;
		//eventParser(currEvent);
		executeButtonClick(1);
		return;
	}
	//Y pressed! Equal to Yes!"
	if(e.keyCode == 89 && mainView.getButtonText( 0 ) == "Yes" && mainView.buttonIsVisible( 0 )) {
		currEvent = buttonEvents[0];
		//eventParser(currEvent);
		executeButtonClick(0);
		return;
	}
	if(e.keyCode == 80 && mainView.menuButtonIsVisible( MainView.MENU_PERKS ) ) {
		displayPerks(f);
		return;
	}
	//If 32 pressed or 13 pressed (enter/space) - NEXT
	if(e.keyCode == 13 || e.keyCode == 32) {
		// b0text is at index 9.  b0Text actually sorta means b10Text...
		if( mainView.buttonIsVisible( 9 ) && mainView.buttonTextIsOneOf( 9, [ "Nevermind", "Abandon", "Next", "Return", "Back", "Leave", "Resume" ] )) {
			trace( "keyboard(): processing space bar for button 9",
				mainView.buttonIsVisible( 9 ) ? "(visible)" : "(hidden)",
				mainView.getButtonText( 9 ) );
			mainView.toolTipView.hide();
			//mouseOverText.visible = false;
			//eventParser(button0Choice);
			executeButtonClick(9);
			return;
		}
		if( mainView.buttonIsVisible( 0 ) && mainView.buttonTextIsOneOf( 0, [ "Next", "Return", "Back" ] )) {
			trace( "keyboard(): processing space bar for button 0",
				mainView.buttonIsVisible( 0 ) ? "(visible)" : "(hidden)",
				mainView.getButtonText( 0 ) );
			mainView.toolTipView.hide();
			//mouseOverText.visible = false;
			//eventParser(button1Choice);
			executeButtonClick(0);
			return;
		}
		if( mainView.buttonIsVisible( 4 ) && mainView.buttonTextIsOneOf( 4, [ "Nevermind", "Next", "Return", "Back", "Leave" ] )) {
			trace( "keyboard(): processing space bar for button 4",
				mainView.buttonIsVisible( 4 ) ? "(visible)" : "(hidden)",
				mainView.getButtonText( 4 ) );
			mainView.toolTipView.hide();
			//mouseOverText.visible = false;
			//eventParser(button5Choice);
			executeButtonClick(4);
			return;
		}
		if( mainView.buttonIsVisible( 5 ) && mainView.buttonTextIsOneOf( 5, [ "Next", "Return", "Back" ] )) {
			trace( "keyboard(): processing space bar for button 5",
				mainView.buttonIsVisible( 5 ) ? "(visible)" : "(hidden)",
				mainView.getButtonText( 5 ) );
			mainView.toolTipView.hide();
			//mouseOverText.visible = false;
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
		//if(b1Text.visible == false)
		if( ! mainView.buttonIsVisible( 0 ) )
		{
			trace("Key 1 pressed while inactive.");
			return;
		}
		//mouseOverText.visible = false;
		mainView.toolTipView.hide();
		//eventParser(currEvent);
		executeButtonClick(0);
		return;
	}
	//If 2 key pressed!
	if(e.keyCode == 50) {
		//if(b2Text.visible == false)
		if( ! mainView.buttonIsVisible( 1 ) )
		{
			trace("Key 2 pressed while inactive.");
			return;
		}
		//mouseOverText.visible = false;
		mainView.toolTipView.hide();
		executeButtonClick(1);
		return;
	}
	//If 3 key pressed!
	if(e.keyCode == 51) {
		//if(b3Text.visible == false)
		if( ! mainView.buttonIsVisible( 2 ) )
		{
			trace("Key 3 pressed while inactive.");
			return;
		}
		//mouseOverText.visible = false;
		mainView.toolTipView.hide();
		executeButtonClick(2);
		return;
	}
	//If 4 key pressed, or enter when text is "leave", "back", or "return".
	if(e.keyCode == 52) {
		//if(b4Text.visible == false)
		if( ! mainView.buttonIsVisible( 3 ) )
		{
			trace("Key 4 pressed while inactive.");
			return;
		}
		//mouseOverText.visible = false;
		mainView.toolTipView.hide();
		executeButtonClick(3);
		return;
	}
	if(e.keyCode == 53) {
		//if(b5Text.visible == false)
		if( ! mainView.buttonIsVisible( 4 ) )
		{
			trace("Key 5 pressed while inactive.");
			return;
		}
		//mouseOverText.visible = false;
		mainView.toolTipView.hide();
		executeButtonClick(4);
		return;
	}
	if(e.keyCode == 54 || e.keyCode == 81) {
		//if(b6Text.visible == false)
		if( ! mainView.buttonIsVisible( 5 ) )
		{
			trace("Key 6 pressed while inactive.");
			return;
		}
		//mouseOverText.visible = false;
		mainView.toolTipView.hide();
		executeButtonClick(5);
		return;
	}
	if(e.keyCode == 55 || e.keyCode == 87) {
		//if(b7Text.visible == false)
		if( ! mainView.buttonIsVisible( 6 ) )
		{
			trace("Key 7 pressed while inactive.");
			return;
		}
		//mouseOverText.visible = false;
		mainView.toolTipView.hide();
		executeButtonClick(6);
		return;
	}
	if(e.keyCode == 56 || e.keyCode == 69) {
		//if(b8Text.visible == false)
		if( ! mainView.buttonIsVisible( 7 ) )
		{
			trace("Key 8 pressed while inactive.");
			return;
		}
		//mouseOverText.visible = false;
		mainView.toolTipView.hide();
		executeButtonClick(7);
		return;
	}
	if(e.keyCode == 57 || e.keyCode == 82) {
		//if(b9Text.visible == false)
		if( ! mainView.buttonIsVisible( 8 ) )
		{
			trace("Key 9 pressed while inactive.");
			return;
		}
		//mouseOverText.visible = false;
		mainView.toolTipView.hide();
		executeButtonClick(8);
		return;
	}
	if(e.keyCode == 48 || e.keyCode == 84) {
		//if(b0Text.visible == false)
		if( ! mainView.buttonIsVisible( 9 ) )
		{
			trace("Key 0 pressed while inactive.");
			return;
		}
		//mouseOverText.visible = false;
		mainView.toolTipView.hide();
		executeButtonClick(9);
		return;
	}
	//Save box
	if(e.keyCode == 68 && mainView.menuButtonIsVisible( MainView.MENU_DATA )) {

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
