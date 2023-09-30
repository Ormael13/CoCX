/**
 * ...
 * @author Ormael, written by Dragon Hearts/Liadri
 */
package classes.Scenes.NPCs 
{
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.Items.*;

import coc.view.ButtonDataList;

public class NadiaFollower extends NPCAwareContent
	{

/*
DIANA_FOLLOWER - status:
    0 - unknown
    1 - intermediate
    2 - "slightly corrupted"
    3 - vag raped, locked
    4 - unused, but probably corrupted too
    5 - wants you
    6 - follower

*/

public function repeatEnc():void {
	clearOutput();
	outputText("As you explore the area, you run into ");
	if (flags[kFLAGS.DIANA_LVL_UP] >= 8 && flags[kFLAGS.DIANA_FOLLOWER] != 3) outputText("Nadia");
	else if (flags[kFLAGS.DIANA_LVL_UP] >= 2) outputText("a unicorn");
	else outputText("a white furred horse morph");
	outputText(".\n\nAt first she doesn’t notice you, given how busy she is examining a flower. You walk closer to greet her, but the sound of your feet on dry leaves immediately alerts her. She turns over with a startled expression as she grabs her staff to defend herself, lunging for a set of preemptive strikes as she begins to attack you.\n\n");
	outputText("\"<i>Eeeeep! Go away, you fiend! ");
    if (flags[kFLAGS.DIANA_FOLLOWER] == 0)
        outputText("I’m not handing over my virginity to you");
	else if (flags[kFLAGS.DIANA_FOLLOWER] < 3)
        outputText("You stained my soul enough as it is. I don’t want any more of your corruption!");
	else
        outputText("You've already taken my virginity. What else do you want?!");
	outputText("!!!!!</i>\"\n\nYou prepare yourself as it seems you have a fight on your hands.\n\n");
	outputText("You are under attack by a");
	if (flags[kFLAGS.DIANA_LVL_UP] >= 8) outputText("n alicorn!");
	else if (flags[kFLAGS.DIANA_LVL_UP] >= 2) outputText(" unicorn!");
	else outputText(" horse morph!");
	startCombat(new Diana());
	doNext(playerMenu);
}
public function postNameEnc():void {
	clearOutput();
	outputText("As you explore the area, you run into Nadia.\n\n");
	outputText("At first, she doesn’t notice you, to busy examining a flower. You walk to her to say hi, but the sound of your feet on dry leaves immediately alerts her. She turns over with a startled  expression and grabs her staff to defend herself, but relax as she realises it’s you.\n\n");
	outputText("\"<i>Oh hello [name]! I didn’t expect you. Say while you happen to be there, I’m in need of a sparring partner.</i>\". She takes a few steps towards you, spinning her staff with one hand. \"<i>Would you mind having a friendly fight with me?</i>\"\n\n");
	menu();
	addButton(1, "Sure", postNameEncSure);
	addButton(3, "Not Now", postNameEncNotNow);
}
public function postNameEncSure():void {
	outputText("Well why not? You could use a warmup yourself.\n\n");
	outputText("\"<i>Thank you [name], chances to improve myself are rare in these lands and I need all the training I can get to reach my goal and dreams.</i>\"\n\n");
	outputText("She grabs her staff and adopt a fighting stance, ready for combat.\n\n");
	outputText("You are fighting Nadia!");
	startCombat(new Diana());
	doNext(playerMenu);
}
public function postNameEncNotNow():void {
	outputText("You don’t have time for sparring right now. Nadia looks slightly disappointed, but she nods respectfully as you head out back to camp.\n\n");
	endEncounter();
}
	}
}