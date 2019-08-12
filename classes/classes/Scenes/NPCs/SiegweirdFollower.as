/**
 * ...
 * @author Liadri
 */
package classes.Scenes.NPCs 
{
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.Monsters.ImpLord;
import classes.Scenes.NPCs.Siegweird;
import classes.display.SpriteDb;

public class SiegweirdFollower extends NPCAwareContent
	{
		
		public function SiegweirdFollower() 
		{}

public function siegweirdFirstEncounter():void
{
	//spriteSelect(SpriteDb.);
	clearOutput();
	outputText("You are traveling through the blight ridge when you hear a sound. It would seem that amongst the many armors that litter the floor, at least one is actually sitting.\n\n");
	outputText("\"<i>Mmmmmmm…..</i>\"");
	outputText("Ok, that strange spherical armor set definitively made a sound.\n\n");
	outputText("\"<i>Mmmmmmmnmmmmmmm...</i>\"");
	outputText("You poke the helmet and the knight inside, because it’s clearly a knight, suddenly looks at you, surprised. It's a bear morph with white fur, for all you can tell of the ursine face in the big round helmet, and he looks quite pensive.\n\n");
	outputText("\"<i>I’ve been unable to solve this problem for days, but I’m in quite a pickle as my sword was stolen by an imp somewhere on the ridge.. Mmmmm… I’m sure there is a way to recover it.</i>\"");
	menu();
	addButton(1, "Help him", siegweirdFirstEncounterHelpHim).hint("Helping him may lead to recrutiment (if all went according to the plan) so that will lock out chance to get Alvina. So think carefully fi you sure you want get him over Alvina.");
	addButton(3, "Do not help him", siegweirdFirstEncounterDoNotHelpHim).hint("later on PC will be still able meet him and get offer to help.");
}
public function siegweirdFirstEncounterHelpHim():void
{
	//spriteSelect(SpriteDb.);
	clearOutput();
	outputText("You leave the weird bear knight to his monologue and start searching for the imp in question. A few hours later your efforts are rewarded, an imp suddenly pops out of nowhere, trying to attack you with the greatsword you were looking for!\n\n");
	flags[kFLAGS.SIEGWEIRD_FOLLOWER] = 2;
	player.createStatusEffect(StatusEffects.SiegweirdImp,0,0,0,0);
	startCombat(new ImpLord());
}
public function siegweirdFirstEncounterDoNotHelpHim():void
{
	flags[kFLAGS.SIEGWEIRD_FOLLOWER] = 1;
	doNext(camp.returnToCampUseOneHour);
}

public function siegweirdFirstEncounterPostFight():void
{
	outputText("You kick the imp away and take the sword. Going back to the outskirts of the ridge, where the knight should still be. As soon as you get there you present it to him, asking the bear morph if this was what he was looking for.\n\n");
	outputText("\"<i>My sword! Wonderful, I’m saved and so is my quest! Thank you, traveler. I, Siegweird, paladin of Catelyna, thank you for your assistance!</i>\"");
	cleanupAfterCombat();
	if (player.statusEffectv1(StatusEffects.AlvinaTraining2) == 3) siegweirdFirstEncounterPostFightAnotherFight();
	else siegweirdFirstEncounterPostFightJoin();
}
public function siegweirdFirstEncounterPostFightJoin():void
{
	outputText("Is this buffoon really a paladin? You weren't sure about him until now. That and the fact he openly claim to be a holy warrior in the middle of enemy territory either makes him the dumbest or the strongest warrior around here. Does that mean he actually knows magic?\n\n");
	outputText("\"<i>My, of course I do. I was trained in the use of white magic as well as swords. Perhaps I could teach you if you promise to help me on my glorious quest to defeat the demons.</i>\"");
	outputText("Well he sure is an enthusiastic one. You tell him you would gladly take him to your camp and Siegweird fellows you there.\n\n");
	outputText("<b>Siegweird has joined you as a follower.</b>\n\n");
	flags[kFLAGS.SIEGWEIRD_FOLLOWER] = 4;
	flags[kFLAGS.ALVINA_FOLLOWER] = 12;
	doNext(camp.returnToCampUseSixHours);
}
public function siegweirdFirstEncounterPostFightAnotherFight():void
{
	outputText("The paladin suddenly notice your demonic outlook and looks at you in stupor just before he starts swearing and charging at you.\n\n");
	outputText("\"<i>Damn it! can’t believe I was helped out by a demon, this has to be a trick and I won’t fall for it. Die, fiend!</i>\"");
	startCombat(new Siegweird());
}
public function siegweirdFirstEncounterPostFightAnotherFightWon():void
{
	outputText("You proceed to finish off the bear morph and collect his holy symbol as proof of his demise. Alvina will be very pleased about this.\n\n");
	outputText("<b>You obtained Siegweird holy symbol!</b>\n\n");
	player.createKeyItem("Siegweird holy symbol", 0, 0, 0, 0);
	flags[kFLAGS.SIEGWEIRD_FOLLOWER] = 3;
	doNext(camp.returnToCampUseSixHours);
}
public function siegweirdFirstEncounterPostFightAnotherFightLost():void
{
	outputText("Siegweird look at your kneeling form for a moment then the last thing you see is his sword rushing for your neck as he finish you off.\n\n");
	EventParser.gameOver();
}

public function siegweirdMainCampMenu():void
{
	//spriteSelect(SpriteDb.s_archmage_alvina_shadowmantle2_16bit);
	clearOutput();
	outputText("You wave a hearty hello to Siegweidd who respond likewise. Though only after mumbling his classic mmmmmh for a moment realising you addressing him shortly after.\n\n");
	outputText("\"<i>Oh?! Good day [name] how is the world treating you?!</i>\"\n\n");
	menu();
	addButton(14, "Back", camp.campFollowers);
}

	}

}