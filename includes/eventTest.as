

function eventTestingPane():void
{
	

	outputText(<![CDATA[



[screen startup | THIS IS THE STARTUP SCREEN  [button next_step | Next Page][button exit | Done! ][button amilyCorruptSexMenu | FuncCall ]]
[screen next_step | THIS IS THE SECOND SCREEN [button exit | Done! ]]




	]]>, true, true);

	//trace("Maintext content @ eventTestingPane = ", mainText.htmlText.length)
	//menu();
	//addButton(9, "Back", debugPane)
}


function eventTester():void {
	outputText("", true);
	mainView.showTestInputPanel();
	//mainView.eventTestInput.text = "Paste test event text here.";
	simpleChoices("Proceed",eventTesterGo,"",0,"",0,"",0,"Back",eventTesterExit);
}

function eventTesterGo():void 
{
	mainView.hideTestInputPanel();
	
	var temp = mainView.eventTestInput.text

	trace("Temp = ", temp);

	menu();
	outputText(temp, true, true);

	addButton(9, "Back", eventTester)
	flushOutputTextToGUI();
	// simpleChoices("Change Text",eventTester,"",0,"",0,"",0,"Exit",eventTesterExit);
	return;
}

function eventTesterExit():void 
{
	mainView.hideTestInputPanel();
	eventParser(debugPane);
	return;
}
