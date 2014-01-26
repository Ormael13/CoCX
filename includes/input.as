public function executeButtonClick(button:int = 0):void {
	mainView.clickButton( button );
}

//DROPDOWN BOX STUFF
// import fl.controls.ComboBox; 
// import fl.data.DataProvider; 
// import flash.net.navigateToURL; 
 
public function changeHandler(event:Event):void {
 	//Store perk name for later addition
 	tempPerk = ComboBox(event.target).selectedItem.perk;
	mainView.aCb.move(210, 80);
	outputText("You have selected the following perk:\n\n", true);
	outputText("<b>" + tempPerk.perkName + ":</b> " + tempPerk.perkLongDesc + "\n\nIf you would like to select this perk, click <b>Okay</b>.  Otherwise, select a new perk, or press <b>Skip</b> to make a decision later.", false);
	simpleChoices("Okay",114,"Skip",115,"",0,"",0,"",0);
}


 /*HOLY SHIT THIS HOW TO DO URL LINKS!
public function changeHandler(event:Event):void { 
    var request:URLRequest = new URLRequest(); 
    request.url = ComboBox(event.target).selectedItem.data; 
    navigateToURL(request); 
    mainView.aCb.selectedIndex = -1; 
}*/

public function displayControls():void
{
	mainView.hideAllMenuButtons();
	inputManager.DisplayBindingPane();
	
	choices("Reset Ctrls", resetControls,
			"Clear Ctrls", clearControls,
			"Null", 0,
			"Null", 0,
			"Null", 0,
			"Null", 0,
			"Null", 0,
			"Null", 0,
			"Null", 0,
			"Back", hideControls);
}

public function hideControls():void
{
	inputManager.HideBindingPane();
	
	settingsScreen();
}

public function resetControls():void
{
	inputManager.HideBindingPane();
	
	outputText("Are you sure you want to reset all of the currently bound controls to their defaults?", true);
	
	doYesNo(resetControlsYes, displayControls);
}

public function resetControlsYes():void
{
	inputManager.ResetToDefaults();
	
	outputText("Controls have been reset to defaults!\n\n", true);
	
	doNext(displayControls);
}

public function clearControls():void
{
	inputManager.HideBindingPane();
	
	outputText("Are you sure you want to clear all of the currently bound controls?", true);
	
	doYesNo(clearControlsYes, displayControls);
}

public function clearControlsYes():void
{
	inputManager.ClearAllBinds();
	
	outputText("Controls have been cleared!", true);
	
	doNext(displayControls);
}