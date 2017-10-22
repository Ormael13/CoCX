public function executeButtonClick(button:int = 0):void {
	mainView.clickButton( button );
}

//DROPDOWN BOX STUFF
// import fl.controls.ComboBox; 
// import fl.data.DataProvider; 
// import flash.net.navigateToURL; 

//Change handler is only used for selecting perks. Moved to engineCore with the other perk selection code


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
	classes.EngineCore.menu();
	classes.EngineCore.addButton(0, "Reset Ctrls", resetControls);
	classes.EngineCore.addButton(1, "Clear Ctrls", clearControls);
	classes.EngineCore.addButton(4, "Back", hideControls);
}

public function hideControls():void
{
	inputManager.HideBindingPane();
	
	gameSettings.settingsScreenMain();
}

public function resetControls():void
{
	inputManager.HideBindingPane();

	classes.EngineCore.clearOutput();
	classes.EngineCore.outputText("Are you sure you want to reset all of the currently bound controls to their defaults?");
	
	classes.EngineCore.doYesNo(resetControlsYes, displayControls);
}

public function resetControlsYes():void
{
	inputManager.ResetToDefaults();

	classes.EngineCore.clearOutput();
	classes.EngineCore.outputText("Controls have been reset to defaults!\n\n");
	
	classes.EngineCore.doNext(displayControls);
}

public function clearControls():void
{
	inputManager.HideBindingPane();

	classes.EngineCore.clearOutput();
	classes.EngineCore.outputText("Are you sure you want to clear all of the currently bound controls?");
	
	classes.EngineCore.doYesNo(clearControlsYes, displayControls);
}

public function clearControlsYes():void
{
	inputManager.ClearAllBinds();

	classes.EngineCore.clearOutput();
	classes.EngineCore.outputText("Controls have been cleared!");
	
	classes.EngineCore.doNext(displayControls);
}