

public function eventTestingPane():void
{


	outputText(<![CDATA[



[screen startup |

**This is the header of the first scene (in BOLD)**

Content! This is the first paragraph of content.
As you can see, paragraphs are automatically reconstituted from
multiple lines. Proper paragraph breaks are demarcated by
two line breaks.

We can also do *italic* and **bold** text!

Lorem ipsum dolor sit amet, consectetur adipisicing elit,
sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
Ut enim ad minim veniam, quis nostrud exercitation
ullamco laboris nisi ut aliquip ex ea commodo consequat.
Duis aute irure dolor in reprehenderit in voluptate velit esse
cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat
cupidatat non proident, sunt in culpa qui officia
deserunt mollit anim id est laborum.

If you want a hard line break, use two spaces ("  ")
at the end of a line before the \\ n character
to tell the markdown parser to insert a
hard line-break

[button page_2 | Page 2]
[if (hasCock = true) [button page_2 | HasCockBtn]]
[if (hasVagina = true) [button page_2 | HasVagBtn]]
[button last_page | Last Page]
[button exit | Leave Early ]

]

[screen page_2 |

THIS IS THE SECOND SCREEN

Sed ut perspiciatis unde omnis iste natus error sit voluptatem
accusantium doloremque laudantium, totam rem aperiam,
eaque ipsa quae ab illo inventore veritatis et quasi architecto
beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem
quia voluptas sit aspernatur aut odit aut fugit, sed quia
consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt.
Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur,
adipisci velit, sed quia non numquam eius modi tempora incidunt ut
labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad
minima veniam, quis nostrum exercitationem ullam corporis
suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur?
Quis autem vel eum iure reprehenderit qui in ea voluptate velit
esse quam nihil molestiae consequatur, vel illum qui dolorem
eum fugiat quo voluptas nulla pariatur?

[button last_page | Last Page]
]
[screen last_page |

This is the last page

At vero eos et accusamus et iusto odio dignissimos ducimus qui
blanditiis praesentium voluptatum deleniti atque corrupti quos
dolores et quas molestias excepturi sint occaecati cupiditate non
provident, similique sunt in culpa qui officia deserunt mollitia
animi, id est laborum et dolorum fuga. Et harum quidem rerum facilis
est et expedita distinctio. Nam libero tempore, cum soluta nobis
est eligendi optio cumque nihil impedit quo minus id quod maxime
placeat facere possimus, omnis voluptas assumenda est, omnis dolor
repellendus. Temporibus autem quibusdam et aut officiis debitis
aut rerum necessitatibus saepe eveniet ut et voluptates repudiandae
sint et molestiae non recusandae. Itaque earum rerum hic tenetur
a sapiente delectus, ut aut reiciendis voluptatibus maiores alias
consequatur aut perferendis doloribus asperiores repellat.


[button exit | All Done! ]
]




	]]>, true, true);

	//trace("Maintext content @ eventTestingPane = ", mainText.htmlText.length)
	//menu();
	//addButton(9, "Back", debugPane)
}

/*





*/

public function eventTester():void {
	outputText("", true);
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
	simpleChoices("Proceed",eventTesterGo,"",0,"",0,"",0,"Back",eventTesterExit);
}

public function eventTesterGo():void
{
	mainView.hideTestInputPanel();

	var temp:String = mainView.eventTestInput.text

	trace("Temp = ", temp);

	menu();
	outputText(temp, true, true);

	addButton(9, "Back", eventTester)
	flushOutputTextToGUI();
	// simpleChoices("Change Text",eventTester,"",0,"",0,"",0,"Exit",eventTesterExit);
	return;
}

public function eventTesterExit():void
{
	mainView.hideTestInputPanel();
	debugPane();

	return;
}
