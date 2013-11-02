//import flash.ui.Mouse;
//Assign listeners!  IMPORTANT - keyboard listener placed in startup.as!

b1Text.addEventListener(MouseEvent.CLICK, buttonEvent);
b2Text.addEventListener(MouseEvent.CLICK, buttonEvent);
b3Text.addEventListener(MouseEvent.CLICK, buttonEvent);
b4Text.addEventListener(MouseEvent.CLICK, buttonEvent);
b5Text.addEventListener(MouseEvent.CLICK, buttonEvent);
b6Text.addEventListener(MouseEvent.CLICK, buttonEvent);
b7Text.addEventListener(MouseEvent.CLICK, buttonEvent);
b8Text.addEventListener(MouseEvent.CLICK, buttonEvent);
b9Text.addEventListener(MouseEvent.CLICK, buttonEvent);
b0Text.addEventListener(MouseEvent.CLICK, buttonEvent);
//This is already done in InitialiseUI.as
//temp = 0;
//while(temp < 10) {
	//buttons[temp].addEventListener(MouseEvent.CLICK, buttonEvent);
	//temp++;
//}
newGameText.addEventListener(MouseEvent.CLICK, newGameGo);
newGameBG.addEventListener(MouseEvent.CLICK, newGameGo);
appearanceText.addEventListener(MouseEvent.CLICK, appearance);
appearanceBG.addEventListener(MouseEvent.CLICK, appearance);
dataText.addEventListener(MouseEvent.CLICK, saveLoad);
dataBG.addEventListener(MouseEvent.CLICK, saveLoad);
levelText2.addEventListener(MouseEvent.CLICK, levelUpGo);
levelBG.addEventListener(MouseEvent.CLICK, levelUpGo);
perksBG.addEventListener(MouseEvent.CLICK, displayPerks);
perksText.addEventListener(MouseEvent.CLICK, displayPerks);
statsText.addEventListener(MouseEvent.CLICK, displayStats);
statsBG.addEventListener(MouseEvent.CLICK, displayStats);

//MOUSE OVERRRRRRZ
statsBG.addEventListener(MouseEvent.ROLL_OVER, buttonOn);
statsBG.addEventListener(MouseEvent.ROLL_OUT, buttonOff);
statsText.addEventListener(MouseEvent.ROLL_OUT, buttonOff);
statsText.addEventListener(MouseEvent.ROLL_OVER, buttonOn);
newGameBG.addEventListener(MouseEvent.ROLL_OVER, buttonOn);
newGameBG.addEventListener(MouseEvent.ROLL_OUT, buttonOff);
levelText2.addEventListener(MouseEvent.ROLL_OVER, buttonOn);
levelText2.addEventListener(MouseEvent.ROLL_OUT, buttonOff);
newGameText.addEventListener(MouseEvent.ROLL_OVER, buttonOn);
newGameText.addEventListener(MouseEvent.ROLL_OUT, buttonOff);
appearanceBG.addEventListener(MouseEvent.ROLL_OVER, buttonOn);
appearanceBG.addEventListener(MouseEvent.ROLL_OUT, buttonOff);
appearanceText.addEventListener(MouseEvent.ROLL_OVER, buttonOn);
appearanceText.addEventListener(MouseEvent.ROLL_OUT, buttonOff);
dataBG.addEventListener(MouseEvent.ROLL_OVER, buttonOn);
dataBG.addEventListener(MouseEvent.ROLL_OUT, buttonOff);
dataText.addEventListener(MouseEvent.ROLL_OVER, buttonOn);
dataText.addEventListener(MouseEvent.ROLL_OUT, buttonOff);
perksBG.addEventListener(MouseEvent.ROLL_OVER, buttonOn);
perksBG.addEventListener(MouseEvent.ROLL_OUT, buttonOff);
perksText.addEventListener(MouseEvent.ROLL_OVER, buttonOn);
perksText.addEventListener(MouseEvent.ROLL_OUT, buttonOff);
gButtons[0].addEventListener(MouseEvent.ROLL_OVER, buttonOn);
gButtons[0].addEventListener(MouseEvent.ROLL_OUT, buttonOff);
b1Text.addEventListener(MouseEvent.ROLL_OVER, buttonOn);
b1Text.addEventListener(MouseEvent.ROLL_OUT, buttonOff);
gButtons[1].addEventListener(MouseEvent.ROLL_OVER, buttonOn);
gButtons[1].addEventListener(MouseEvent.ROLL_OUT, buttonOff);
b2Text.addEventListener(MouseEvent.ROLL_OVER, buttonOn);
b2Text.addEventListener(MouseEvent.ROLL_OUT, buttonOff);
gButtons[2].addEventListener(MouseEvent.ROLL_OVER, buttonOn);
gButtons[2].addEventListener(MouseEvent.ROLL_OUT, buttonOff);
b3Text.addEventListener(MouseEvent.ROLL_OVER, buttonOn);
b3Text.addEventListener(MouseEvent.ROLL_OUT, buttonOff);
gButtons[3].addEventListener(MouseEvent.ROLL_OVER, buttonOn);
gButtons[3].addEventListener(MouseEvent.ROLL_OUT, buttonOff);
b4Text.addEventListener(MouseEvent.ROLL_OVER, buttonOn);
b4Text.addEventListener(MouseEvent.ROLL_OUT, buttonOff);
gButtons[4].addEventListener(MouseEvent.ROLL_OVER, buttonOn);
gButtons[4].addEventListener(MouseEvent.ROLL_OUT, buttonOff);
b5Text.addEventListener(MouseEvent.ROLL_OVER, buttonOn);
b5Text.addEventListener(MouseEvent.ROLL_OUT, buttonOff);
gButtons[5].addEventListener(MouseEvent.ROLL_OVER, buttonOn);
gButtons[5].addEventListener(MouseEvent.ROLL_OUT, buttonOff);
b6Text.addEventListener(MouseEvent.ROLL_OVER, buttonOn);
b6Text.addEventListener(MouseEvent.ROLL_OUT, buttonOff);
gButtons[6].addEventListener(MouseEvent.ROLL_OVER, buttonOn);
gButtons[6].addEventListener(MouseEvent.ROLL_OUT, buttonOff);
b7Text.addEventListener(MouseEvent.ROLL_OVER, buttonOn);
b7Text.addEventListener(MouseEvent.ROLL_OUT, buttonOff);
gButtons[7].addEventListener(MouseEvent.ROLL_OVER, buttonOn);
gButtons[7].addEventListener(MouseEvent.ROLL_OUT, buttonOff);
b8Text.addEventListener(MouseEvent.ROLL_OVER, buttonOn);
b8Text.addEventListener(MouseEvent.ROLL_OUT, buttonOff);
gButtons[8].addEventListener(MouseEvent.ROLL_OVER, buttonOn);
gButtons[8].addEventListener(MouseEvent.ROLL_OUT, buttonOff);
b9Text.addEventListener(MouseEvent.ROLL_OVER, buttonOn);
b9Text.addEventListener(MouseEvent.ROLL_OUT, buttonOff);
gButtons[9].addEventListener(MouseEvent.ROLL_OVER, buttonOn);
gButtons[9].addEventListener(MouseEvent.ROLL_OUT, buttonOff);
b0Text.addEventListener(MouseEvent.ROLL_OVER, buttonOn);
b0Text.addEventListener(MouseEvent.ROLL_OUT, buttonOff);

function buttonEvent(e:MouseEvent):void {
	mouseOverText.visible = false;
	var buttonIndex:int = 0;
	//Set temp equal to the button that was clicked.
	while(buttonIndex < 10) {
		if(e.target == gButtons[buttonIndex]) break;
		buttonIndex++;
	}
	if(e.target == b1Text) buttonIndex = 0;
	else if(e.target == b2Text) 
		buttonIndex = 1;
	else if(e.target == b3Text) 
		buttonIndex = 2;
	else if(e.target == b4Text) 
		buttonIndex = 3;
	else if(e.target == b5Text) 
		buttonIndex = 4;
	else if(e.target == b6Text) 
		buttonIndex = 5;
	else if(e.target == b7Text) 
		buttonIndex = 6;
	else if(e.target == b8Text) 
		buttonIndex = 7;
	else if(e.target == b9Text) 
		buttonIndex = 8;
	else if(e.target == b0Text) 
		buttonIndex = 9;
	//Standard method.
	//trace("FUNC LENGTH" + funcs.length);
	executeButtonClick(buttonIndex);
}

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


/*LEGACY CODE!
function buttonEvent1(e:MouseEvent):void
{
	mouseOverText.visible = false;
	if(funcs.length == 0 || button1Choice == 0)
	{
		outputText("\nInactive Button.  This is an error, please contact Fenoxo and describe the circumstances that lead you here.", true);
		return;
	}
	else if(button1Choice != 9998) {
		trace("Button pressed for: " + button1Choice);
		eventParser(button1Choice);
	}
	else {
		trace("Button pressed for: " + String(funcs[0]));
		funcs[0]();
		funcs = new Array();
		args = new Array();
	}
}
function buttonEvent2(e:MouseEvent):void
{
	if(button2Choice == 0)
	{
		outputText("\nInactive Button.  This is an error, please contact Fenoxo and describe the circumstances that lead you here.", true);
		return;
	}
	mouseOverText.visible = false;
	trace("Button pressed for: " + button2Choice);
	eventParser(button2Choice);
}
function buttonEvent3(e:MouseEvent):void
{
	if(button3Choice == 0)
	{
		outputText("\nInactive Button.  This is an error, please contact Fenoxo and describe the circumstances that lead you here.", true);
		return;
	}
	mouseOverText.visible = false;
	trace("Button pressed for: " + button3Choice);
	eventParser(button3Choice);
}
function buttonEvent4(e:MouseEvent):void
{
	if(button4Choice == 0)
	{
		outputText("\nInactive Button.  This is an error, please contact Fenoxo and describe the circumstances that lead you here.", true);
		return;
	}
	mouseOverText.visible = false;
	trace("Button pressed for: " + button4Choice);
	eventParser(button4Choice);
}
function buttonEvent5(e:MouseEvent):void
{
	if(button5Choice == 0)
	{
		outputText("\nInactive Button.  This is an error, please contact Fenoxo and describe the circumstances that lead you here.", true);
		return;
	}
	mouseOverText.visible = false;
	trace("Button pressed for: " + button5Choice);
	eventParser(button5Choice);
}
function buttonEvent6(e:MouseEvent):void
{
	if(button6Choice == 0)
	{
		outputText("\nInactive Button.  This is an error, please contact Fenoxo and describe the circumstances that lead you here.", true);
		return;
	}
	mouseOverText.visible = false;
	trace("Button pressed for: " + button6Choice);
	eventParser(button6Choice);
}
function buttonEvent7(e:MouseEvent):void
{
	if(button7Choice == 0)
	{
		outputText("\nInactive Button.  This is an error, please contact Fenoxo and describe the circumstances that lead you here.", true);
		return;
	}
	mouseOverText.visible = false;
	trace("Button pressed for: " + button7Choice);
	eventParser(button7Choice);
}
function buttonEvent8(e:MouseEvent):void
{
	if(button8Choice == 0)
	{
		outputText("\nInactive Button.  This is an error, please contact Fenoxo and describe the circumstances that lead you here.", true);
		return;
	}
	mouseOverText.visible = false;
	trace("Button pressed for: " + button8Choice);
	eventParser(button8Choice);
}
function buttonEvent9(e:MouseEvent):void
{
	if(button9Choice == 0)
	{
		outputText("\nInactive Button.  This is an error, please contact Fenoxo and describe the circumstances that lead you here.", true);
		return;
	}
	mouseOverText.visible = false;
	trace("Button pressed for: " + button9Choice);
	eventParser(button9Choice);
}
function buttonEvent0(e:MouseEvent):void
{
	if(button0Choice == 0)
	{
		outputText("\nInactive Button.  This is an error, please contact Fenoxo and describe the circumstances that lead you here.", true);
		return;
	}
	mouseOverText.visible = false;
	trace("Button pressed for: " + button0Choice);
	eventParser(button0Choice);
}*/

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
		if(!textBGWhite.visible) textBGWhite.visible = true;
		else if(!textBGTan.visible) textBGTan.visible = true;
		else {
			textBGTan.visible = false;
			textBGWhite.visible = false;
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