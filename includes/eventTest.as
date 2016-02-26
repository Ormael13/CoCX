//Disabled due to Markdown.
public function eventTester():void {
	clearOutput();
	mainView.showTestInputPanel();
	mainView.eventTestInput.text = <![CDATA[
[screen startup |

"Paste test event text here."

[button urtaQuest.infertilityQuestions | infertilityQuestions]
[button forest.kitsuneScene.enterTheTrickster | enterTheTrickster]
[button forest.kitsuneScene.kitsuneShrine | kitsuneShrine]
[button forest.kitsuneScene.defeatTheKitsunes | defeatTheKitsunes]
[button exit | Exit ]
]

]]>;

	;
	simpleChoices("Proceed",eventTesterGo,"",null,"",null,"",null,"Back",eventTesterExit);
}

public function eventTesterGo():void
{
	mainView.hideTestInputPanel();

	var temp:String = mainView.eventTestInput.text

	trace("Temp = ", temp);

	menu();
	outputText(temp, true, true);

	addButton(14, "Back", eventTester)
	flushOutputTextToGUI();
	return;
}

public function eventTesterExit():void
{
	mainView.hideTestInputPanel();
	debugPane();

	return;
}
