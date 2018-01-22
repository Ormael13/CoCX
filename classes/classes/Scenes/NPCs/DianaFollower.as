/**
 * ...
 * @author Ormael
 */
package classes.Scenes.NPCs 
{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	
	public class DianaFollower extends NPCAwareContent
	{
		
		public function DianaFollower() 
		{}

public function dianaAffection(changes:Number = 0):Number
{
	flags[kFLAGS.DIANA_AFFECTION] += changes;
	//if (flags[kFLAGS.DIANA_AFFECTION] > 100) flags[kFLAGS.DIANA_AFFECTION] = 100;
	if (flags[kFLAGS.DIANA_AFFECTION] > 10) flags[kFLAGS.DIANA_AFFECTION] = 10;
	return flags[kFLAGS.DIANA_AFFECTION];
}
//0-10 affection - Horse-morph; 10-90 affection - Unicorn; 90-100 affection Alicorn
public function repeatLakeEnc():void
{
	clearOutput();
	outputText("As you explore the lake area, you run into a");
	if (flags[kFLAGS.DIANA_LVL_UP] >= 4) outputText("n alicorn");
	else if (flags[kFLAGS.DIANA_LVL_UP] >= 2) outputText("n unicorn");
	else outputText(" white furred horse morph");
	outputText(".\n\nAt first she doesn’t notice you, to busy examining a flower. You walk to her to say hi, but the sound of your feet on dry leaves immediately alerts her. She turns over with a startled  expression and grabs her staff to defend herself, lunging for a set of preemptive strikes as she begins to attack you.\n\n");
	outputText("\"<i>Eeeeep! Go away, you fiend! I’m not handing over my virginity to you!!!!</i>\"\n\n");
	outputText("Well seems you got a fight on your hands.\n\n");
	outputText("You are under attack by a");
	if (flags[kFLAGS.DIANA_LVL_UP] >= 4) outputText("n alicorn!");
	else if (flags[kFLAGS.DIANA_LVL_UP] >= 2) outputText("n unicorn!");
	else outputText(" horse morph!");
	startCombat(new Diana());
	doNext(playerMenu);
}
public function repeatPlainsEnc():void
{
	
}
public function repeatBattlefieldEnc():void
{
	
}
public function wonOverDiana():void
{
	clearOutput();
	outputText("The horse morph kneels down defeated. Seems you can do whatever you want with her now. So, what will it be?\n\n");
	menu();
	addButtonDisabled(0, "Rape", "Sex scenes not yet coded.");
	addButton(1, "Spare", wonOverDianaSpare);
}
public function wonOverDianaRape():void
{
	
}
public function wonOverDianaSpare():void
{
	clearOutput();
	outputText("You tell the girl you will let her go. You have no business with her.\n\n");
	outputText("At first she looks at you in confusion, then nods before running off in the forest. Maybe next time the two of you could meet on more friendly dispositions.\n\n");
	/*flags[kFLAGS.DIANA_DEFEATS_COUNTER]++;
	if (flags[kFLAGS.DIANA_DEFEATS_COUNTER] == 1 && flags[kFLAGS.DIANA_LVL_UP] == 0) {
		if (player.hasStatusEffect(StatusEffects.CampSparingNpcsTimers2)) player.addStatusValue(StatusEffects.CampSparingNpcsTimers2, 4, 30);
		else player.createStatusEffect(StatusEffects.CampSparingNpcsTimers1, 0, 0, 0, 18);
		flags[kFLAGS.DIANA_DEFEATS_COUNTER] = 0;
		flags[kFLAGS.DIANA_LVL_UP] = 1;
	}
	if (flags[kFLAGS.DIANA_DEFEATS_COUNTER] == 1 && flags[kFLAGS.DIANA_LVL_UP] == 1) {
		if (player.hasStatusEffect(StatusEffects.CampSparingNpcsTimers2)) player.addStatusValue(StatusEffects.CampSparingNpcsTimers2, 4, 36);
		else player.createStatusEffect(StatusEffects.CampSparingNpcsTimers2, 0, 0, 0, 18);
		flags[kFLAGS.DIANA_DEFEATS_COUNTER] = 0;
		flags[kFLAGS.DIANA_LVL_UP] = 2;
	}
	if (flags[kFLAGS.DIANA_DEFEATS_COUNTER] == 2 && flags[kFLAGS.DIANA_LVL_UP] == 2) {
		if (player.hasStatusEffect(StatusEffects.CampSparingNpcsTimers2)) player.addStatusValue(StatusEffects.CampSparingNpcsTimers2, 4, 36);
		else player.createStatusEffect(StatusEffects.CampSparingNpcsTimers2, 0, 0, 0, 18);
		flags[kFLAGS.DIANA_DEFEATS_COUNTER] = 0;
		flags[kFLAGS.DIANA_LVL_UP] = 3;
	}
	if (flags[kFLAGS.DIANA_DEFEATS_COUNTER] == 2 && flags[kFLAGS.DIANA_LVL_UP] == 3) {
		if (player.hasStatusEffect(StatusEffects.CampSparingNpcsTimers2)) player.addStatusValue(StatusEffects.CampSparingNpcsTimers2, 4, 36);
		else player.createStatusEffect(StatusEffects.CampSparingNpcsTimers2, 0, 0, 0, 18);
		flags[kFLAGS.DIANA_DEFEATS_COUNTER] = 0;
		flags[kFLAGS.DIANA_LVL_UP] = 4;
	}
	dianaAffection(5);*/
	cleanupAfterCombat();
	return;
}
public function lostToDiana():void
{
	clearOutput();
	outputText("The horse morph kicks you in the face, knocking you unconscious. When you wake up, you realise she got away with some of your gems. Guess that's not the worst thing that could happen, right?\n\n");
	cleanupAfterCombat();
	return;
}
	}
}