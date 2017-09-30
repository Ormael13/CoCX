/**
 * ...
 * @author Liadri
 */
package classes.Scenes.NPCs 
{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	
	public class ElectraFollower extends NPCAwareContent
	{
		
		public function ElectraFollower() 
		{}
		
//flag ELECTRA_TALKED_ABOUT_HER]: 0 - not know her name, 1 - know her name

public function electraAffection(changes:Number = 0):Number
{
	flags[kFLAGS.ELECTRA_AFFECTION] += changes;
	if (flags[kFLAGS.ELECTRA_AFFECTION] > 100) flags[kFLAGS.ELECTRA_AFFECTION] = 100;
	return flags[kFLAGS.ELECTRA_AFFECTION];
}

public function firstEnc():void
{
	clearOutput();
	outputText("As you wander the mountain you hear the sound of echoing thunder through this time around it clearly didn’t come from the sky. You see multiple imps and even a minotaur run away from the spot where the sound was heard. As you go there to see what’s going on you come upon a single girl with animal morph features. She's panting on the ground a hand under her dress.\n\n");
	outputText("\"<i>Ahhhh someone... someone help me get rid of this maddening desire... rape me... fuck me I don’t care how you do it. Gah why are they all fleeing!...come back come back so I can get rid of my itches... Come back so we can FUCK!</i>\"\n\n");
	outputText("She suddenly realizes you are there and her eyes glimmers with a hint of barely contained madness. She stands up on her hind leg, still playing with her pussy, and eyes you up with a manic smile on her face as electricity starts to dance in the air around her.\n\n");
	outputText("\"<i>You will be my lightning rod!!!!</i>\"");
	outputText("\n\nYou are under attack by a Raiju!");
	if (flags[kFLAGS.CODEX_ENTRY_RAIJU] <= 0) {
		flags[kFLAGS.CODEX_ENTRY_RAIJU] = 1;
		outputText("\n\n<b>New codex entry unlocked: Raiju!</b>")
	}
	startCombat(new Electra());
	doNext(playerMenu);
}

public function repeatEnc():void
{
	clearOutput();
	outputText("As you wander the mountain you hear the sound of echoing thunder through this time around it clearly didn’t come from the sky. You see multiple imps and even a minotaur run away from the spot where the sound was heard. As you go there to see what’s going on you come upon the Raiju girl/Electra again. She's panting on the ground a hand under her dress and masturbating like there is no tomorrow.\n\n");
	outputText("\"<i>Ahhhh someone... someone help me get rid of this maddening desire... rape me... fuck me I don’t care how you do it. Gah why are they all fleeing!...come back come back so I can get rid of my itches... Come back so we can FUCK!</i>\"\n\n");
	outputText("Shit! If she sees you now she will definitively attack but just as you are about to leave she suddenly realizes you are there and her eyes glimmers with a hint of barely contained madness. She stands up on her hind leg, still playing with her pussy, and eyes you up with a manic smile on her face as electricity starts to dance in the air around her.\n\n");
	outputText("\"<i>Just who I need for relief!  Now stay still, I will make it short!!!</i>\"");
	outputText("\n\nYou are under attack by ");
	if (flags[kFLAGS.ELECTRA_TALKED_ABOUT_HER] >= 1) outputText("Electra");
	else outputText("a Raiju");
	outputText(" again!");
	startCombat(new Electra());
	doNext(playerMenu);
}



	}
}