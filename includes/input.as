function executeButtonClick(button:int = 0):void {
	mainView.clickButton( button );
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

function displayControls():void
{
	inputManager.DisplayBindingPane();
	
	choices("Reset Ctrls", resetControls,
			"Null", 0,
			"Null", 0,
			"Null", 0,
			"Null", 0,
			"Null", 0,
			"Null", 0,
			"Null", 0,
			"Null", 0,
			"Back", hideControls);
}

function hideControls():void
{
	inputManager.HideBindingPane();
	
	settingsScreen();
}

function resetControls():void
{
	inputManager.HideBindingPane();
	
	outputText("Are you sure you want to reset all of the currently bound controls to their defaults?", true);
	
	doYesNo(resetControlsYes, displayControls);
}

function resetControlsYes():void
{
	inputManager.ResetToDefaults();
	
	outputText("Controls have been reset to defaults!\n\n", true);
	outputText("TODO: Actually make resetting work!");
	
	doNext(displayControls);
}