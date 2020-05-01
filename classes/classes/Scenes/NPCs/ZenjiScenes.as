/**
 * ...
 * @author Pyromania
 */
package classes.Scenes.NPCs 
{
import classes.*;
//import classes.BodyParts.Tongue;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.SceneLib;
import classes.display.SpriteDb;
	
	public class ZenjiScenes extends NPCAwareContent
	{
		
		public function ZenjiScenes() 
		{}
		
public function part1TrollEncounter():void {
//	spriteSelect(SpriteDb.s_zenji);
	clearOutput();
	outputText("As you are trekking your way through the foliage of the bog, clearing a path through the flora and making sure to watch your step, you are suddenly halted by a deep, brassy voice coming from nearby.\n\n");
	outputText("\"<i>Ahaha, ¿Que eres? A new one steps into my grounds.</i>\" The voice speaks with a slight lisp and a vaguely spanish accent.\n\n");
	outputText("You turn to your left and see what looks to be a tall, muscular humanoid. He is easily over 8 feet tall, standing on a tree branch and hanging onto one above him with his muscular arms over his head. He's covered head to toe in dense fuzz with a fairly long tail sprouting behind him. He is supporting a very large and intimidatingly muscular physique. You’re not quite sure who or what he could be."+(flags[kFLAGS.ROGAR_PHASE] > 0 ? " You think that perhaps he’s an orc like Ro’Gar, but he doesn’t have the same body shape, completely different facial structure and has far more fur on his body.":"")+"\n\n");
	outputText("\"<i>Heheh, If you want to enter I don't ask for much, ya see?</i>\" He chuckles, \"<i>You can pay  a toll for de troll, 25 gems to enter, or perhaps you have something else to offer, something dat could require a lot from you if you tink you can take de challenge.</i>\"\n\n");
	outputText("You sigh, it's pretty much the same thing, all anybody asks for in this land is either sex or gems and this alleged troll as he called himself seems no different. You consider if giving him proper payment is worth it.\n\n");
	menu();
	addButton(0, "Pay w Gems", part1TrollEncounterPayWithGems);
	addButton(1, "Sex", part1TrollEncounterSex);
	//addButton(2, "Challenge?", part1TrollEncounterChallange);
	//addButton(3, "Leave", part1TrollEncounterLeave);
	addButton(4, "Leave", part1TrollEncounterLeave);
}

public function part1TrollEncounterLeave():void {
	outputText("You decide that it's not worth paying whatever he's demanding to venture into who knows where.\n\n");
	outputText("\"<i>Eh? You’re just gonna leave me like dat? You don' want ta even try to fight me?</i>\" He chuckles, \"<i>Your loss.</i>\"\n\n");
	outputText("You return back to your camp following the path that you made along your way.\n\n");
	doNext(camp.returnToCampUseOneHour);
}

public function part1TrollEncounterFight():void {
//	spriteSelect(SpriteDb.s_zenji);
	clearOutput();
	
}

public function part1TrollEncounterChallange():void {
	outputText("You look up to him and ask just what did he mean by 'challenge'?\n\n");
	outputText("He hops down from the tree, standing just over a foot away from you. \"<i>Heheh, I challenge you to a battle of skill, if you can beat me at ma own game, den I’ll let you pass.</i>\"\n\n");
	outputText("\"<i>So, which will it be, do you prefer to compete against me in a battle of wits, power or speed? I will test you inside, but don't ya go snoopin.</i>\"\n\n");
	outputText("He gestures for you to follow and you do so. Once inside, you consider just what do you want to challenge him on.\n\n");
	menu();
	addButton(0, "Strength", part1TrollEncounterLeave);
	addButton(1, "Toughness", part1TrollEncounterLeave);
	addButton(2, "Speed", part1TrollEncounterLeave);
	addButton(3, "Intelligence", part1TrollEncounterLeave);
	addButton(4, "Wisdom", part1TrollEncounterLeave);
}
public function part1TrollEncounterChallangeStrength():void {
//	spriteSelect(SpriteDb.s_zenji);
	clearOutput();
	outputText("You decide that it's not worth paying whatever he's demanding to venture into who knows where.\n\n");
	outputText("\"<i>Eh? You’re just gonna leave me like dat? You don' want ta even try to fight me?</i>\" He chuckles, \"<i>Your loss.</i>\"\n\n");
	outputText("You decide that it's not worth paying whatever he's demanding to venture into who knows where.\n\n");
	outputText("\"<i>Eh? You’re just gonna leave me like dat? You don' want ta even try to fight me?</i>\" He chuckles, \"<i>Your loss.</i>\"\n\n");
	outputText("You decide that it's not worth paying whatever he's demanding to venture into who knows where.\n\n");
	/*if () {
		outputText("You decide that it's not worth paying whatever he's demanding to venture into who knows where.\n\n");
		outputText("\"<i>Eh? You’re just gonna leave me like dat? You don' want ta even try to fight me?</i>\" He chuckles, \"<i>Your loss.</i>\"\n\n");
		outputText("You decide that it's not worth paying whatever he's demanding to venture into who knows where.\n\n");
		outputText("\"<i>Eh? You’re just gonna leave me like dat? You don' want ta even try to fight me?</i>\" He chuckles, \"<i>Your loss.</i>\"\n\n");
	}
	else if () {
		outputText("You decide that it's not worth paying whatever he's demanding to venture into who knows where.\n\n");
		outputText("\"<i>Eh? You’re just gonna leave me like dat? You don' want ta even try to fight me?</i>\" He chuckles, \"<i>Your loss.</i>\"\n\n");
		outputText("You decide that it's not worth paying whatever he's demanding to venture into who knows where.\n\n");
		outputText("\"<i>Eh? You’re just gonna leave me like dat? You don' want ta even try to fight me?</i>\" He chuckles, \"<i>Your loss.</i>\"\n\n");
	}
	else {
		outputText("You decide that it's not worth paying whatever he's demanding to venture into who knows where.\n\n");
		outputText("\"<i>Eh? You’re just gonna leave me like dat? You don' want ta even try to fight me?</i>\" He chuckles, \"<i>Your loss.</i>\"\n\n");
		outputText("You decide that it's not worth paying whatever he's demanding to venture into who knows where.\n\n");
		outputText("\"<i>Eh? You’re just gonna leave me like dat? You don' want ta even try to fight me?</i>\" He chuckles, \"<i>Your loss.</i>\"\n\n");
	}*/
	doNext(camp.returnToCampUseOneHour);
}
public function part1TrollEncounterChallangeToughness():void {
//	spriteSelect(SpriteDb.s_zenji);
	clearOutput();
	outputText("You decide that it's not worth paying whatever he's demanding to venture into who knows where.\n\n");
	outputText("\"<i>Eh? You’re just gonna leave me like dat? You don' want ta even try to fight me?</i>\" He chuckles, \"<i>Your loss.</i>\"\n\n");
	outputText("You decide that it's not worth paying whatever he's demanding to venture into who knows where.\n\n");
	outputText("\"<i>Eh? You’re just gonna leave me like dat? You don' want ta even try to fight me?</i>\" He chuckles, \"<i>Your loss.</i>\"\n\n");
	outputText("You decide that it's not worth paying whatever he's demanding to venture into who knows where.\n\n");
	/*if () {
		outputText("You decide that it's not worth paying whatever he's demanding to venture into who knows where.\n\n");
		outputText("\"<i>Eh? You’re just gonna leave me like dat? You don' want ta even try to fight me?</i>\" He chuckles, \"<i>Your loss.</i>\"\n\n");
		outputText("You decide that it's not worth paying whatever he's demanding to venture into who knows where.\n\n");
		outputText("\"<i>Eh? You’re just gonna leave me like dat? You don' want ta even try to fight me?</i>\" He chuckles, \"<i>Your loss.</i>\"\n\n");
	}
	else if () {
		outputText("You decide that it's not worth paying whatever he's demanding to venture into who knows where.\n\n");
		outputText("\"<i>Eh? You’re just gonna leave me like dat? You don' want ta even try to fight me?</i>\" He chuckles, \"<i>Your loss.</i>\"\n\n");
		outputText("You decide that it's not worth paying whatever he's demanding to venture into who knows where.\n\n");
		outputText("\"<i>Eh? You’re just gonna leave me like dat? You don' want ta even try to fight me?</i>\" He chuckles, \"<i>Your loss.</i>\"\n\n");
	}
	else {
		outputText("You decide that it's not worth paying whatever he's demanding to venture into who knows where.\n\n");
		outputText("\"<i>Eh? You’re just gonna leave me like dat? You don' want ta even try to fight me?</i>\" He chuckles, \"<i>Your loss.</i>\"\n\n");
		outputText("You decide that it's not worth paying whatever he's demanding to venture into who knows where.\n\n");
		outputText("\"<i>Eh? You’re just gonna leave me like dat? You don' want ta even try to fight me?</i>\" He chuckles, \"<i>Your loss.</i>\"\n\n");
	}*/
	doNext(camp.returnToCampUseOneHour);
}
public function part1TrollEncounterChallangeSpeed():void {
//	spriteSelect(SpriteDb.s_zenji);
	clearOutput();
	outputText("You decide that it's not worth paying whatever he's demanding to venture into who knows where.\n\n");
	outputText("\"<i>Eh? You’re just gonna leave me like dat? You don' want ta even try to fight me?</i>\" He chuckles, \"<i>Your loss.</i>\"\n\n");
	outputText("You decide that it's not worth paying whatever he's demanding to venture into who knows where.\n\n");
	outputText("\"<i>Eh? You’re just gonna leave me like dat? You don' want ta even try to fight me?</i>\" He chuckles, \"<i>Your loss.</i>\"\n\n");
	outputText("You decide that it's not worth paying whatever he's demanding to venture into who knows where.\n\n");
	/*if () {
		outputText("You decide that it's not worth paying whatever he's demanding to venture into who knows where.\n\n");
		outputText("\"<i>Eh? You’re just gonna leave me like dat? You don' want ta even try to fight me?</i>\" He chuckles, \"<i>Your loss.</i>\"\n\n");
		outputText("You decide that it's not worth paying whatever he's demanding to venture into who knows where.\n\n");
		outputText("\"<i>Eh? You’re just gonna leave me like dat? You don' want ta even try to fight me?</i>\" He chuckles, \"<i>Your loss.</i>\"\n\n");
	}
	else if () {
		outputText("You decide that it's not worth paying whatever he's demanding to venture into who knows where.\n\n");
		outputText("\"<i>Eh? You’re just gonna leave me like dat? You don' want ta even try to fight me?</i>\" He chuckles, \"<i>Your loss.</i>\"\n\n");
		outputText("You decide that it's not worth paying whatever he's demanding to venture into who knows where.\n\n");
		outputText("\"<i>Eh? You’re just gonna leave me like dat? You don' want ta even try to fight me?</i>\" He chuckles, \"<i>Your loss.</i>\"\n\n");
	}
	else {
		outputText("You decide that it's not worth paying whatever he's demanding to venture into who knows where.\n\n");
		outputText("\"<i>Eh? You’re just gonna leave me like dat? You don' want ta even try to fight me?</i>\" He chuckles, \"<i>Your loss.</i>\"\n\n");
		outputText("You decide that it's not worth paying whatever he's demanding to venture into who knows where.\n\n");
		outputText("\"<i>Eh? You’re just gonna leave me like dat? You don' want ta even try to fight me?</i>\" He chuckles, \"<i>Your loss.</i>\"\n\n");
	}*/
	doNext(camp.returnToCampUseOneHour);
}
public function part1TrollEncounterChallangeIntelligence():void {
//	spriteSelect(SpriteDb.s_zenji);
	clearOutput();
	outputText("You decide that it's not worth paying whatever he's demanding to venture into who knows where.\n\n");
	outputText("\"<i>Eh? You’re just gonna leave me like dat? You don' want ta even try to fight me?</i>\" He chuckles, \"<i>Your loss.</i>\"\n\n");
	outputText("You decide that it's not worth paying whatever he's demanding to venture into who knows where.\n\n");
	outputText("\"<i>Eh? You’re just gonna leave me like dat? You don' want ta even try to fight me?</i>\" He chuckles, \"<i>Your loss.</i>\"\n\n");
	outputText("You decide that it's not worth paying whatever he's demanding to venture into who knows where.\n\n");
	/*if () {
		outputText("You decide that it's not worth paying whatever he's demanding to venture into who knows where.\n\n");
		outputText("\"<i>Eh? You’re just gonna leave me like dat? You don' want ta even try to fight me?</i>\" He chuckles, \"<i>Your loss.</i>\"\n\n");
		outputText("You decide that it's not worth paying whatever he's demanding to venture into who knows where.\n\n");
		outputText("\"<i>Eh? You’re just gonna leave me like dat? You don' want ta even try to fight me?</i>\" He chuckles, \"<i>Your loss.</i>\"\n\n");
	}
	else if () {
		outputText("You decide that it's not worth paying whatever he's demanding to venture into who knows where.\n\n");
		outputText("\"<i>Eh? You’re just gonna leave me like dat? You don' want ta even try to fight me?</i>\" He chuckles, \"<i>Your loss.</i>\"\n\n");
		outputText("You decide that it's not worth paying whatever he's demanding to venture into who knows where.\n\n");
		outputText("\"<i>Eh? You’re just gonna leave me like dat? You don' want ta even try to fight me?</i>\" He chuckles, \"<i>Your loss.</i>\"\n\n");
	}
	else {
		outputText("You decide that it's not worth paying whatever he's demanding to venture into who knows where.\n\n");
		outputText("\"<i>Eh? You’re just gonna leave me like dat? You don' want ta even try to fight me?</i>\" He chuckles, \"<i>Your loss.</i>\"\n\n");
		outputText("You decide that it's not worth paying whatever he's demanding to venture into who knows where.\n\n");
		outputText("\"<i>Eh? You’re just gonna leave me like dat? You don' want ta even try to fight me?</i>\" He chuckles, \"<i>Your loss.</i>\"\n\n");
	}*/
	doNext(camp.returnToCampUseOneHour);
}
public function part1TrollEncounterChallangeWisdom():void {
//	spriteSelect(SpriteDb.s_zenji);
	clearOutput();
	outputText("You decide that it's not worth paying whatever he's demanding to venture into who knows where.\n\n");
	outputText("\"<i>Eh? You’re just gonna leave me like dat? You don' want ta even try to fight me?</i>\" He chuckles, \"<i>Your loss.</i>\"\n\n");
	outputText("You decide that it's not worth paying whatever he's demanding to venture into who knows where.\n\n");
	outputText("\"<i>Eh? You’re just gonna leave me like dat? You don' want ta even try to fight me?</i>\" He chuckles, \"<i>Your loss.</i>\"\n\n");
	outputText("You decide that it's not worth paying whatever he's demanding to venture into who knows where.\n\n");
	/*if () {
		outputText("You decide that it's not worth paying whatever he's demanding to venture into who knows where.\n\n");
		outputText("\"<i>Eh? You’re just gonna leave me like dat? You don' want ta even try to fight me?</i>\" He chuckles, \"<i>Your loss.</i>\"\n\n");
		outputText("You decide that it's not worth paying whatever he's demanding to venture into who knows where.\n\n");
		outputText("\"<i>Eh? You’re just gonna leave me like dat? You don' want ta even try to fight me?</i>\" He chuckles, \"<i>Your loss.</i>\"\n\n");
	}
	else if () {
		outputText("You decide that it's not worth paying whatever he's demanding to venture into who knows where.\n\n");
		outputText("\"<i>Eh? You’re just gonna leave me like dat? You don' want ta even try to fight me?</i>\" He chuckles, \"<i>Your loss.</i>\"\n\n");
		outputText("You decide that it's not worth paying whatever he's demanding to venture into who knows where.\n\n");
		outputText("\"<i>Eh? You’re just gonna leave me like dat? You don' want ta even try to fight me?</i>\" He chuckles, \"<i>Your loss.</i>\"\n\n");
	}
	else {
		outputText("You decide that it's not worth paying whatever he's demanding to venture into who knows where.\n\n");
		outputText("\"<i>Eh? You’re just gonna leave me like dat? You don' want ta even try to fight me?</i>\" He chuckles, \"<i>Your loss.</i>\"\n\n");
		outputText("You decide that it's not worth paying whatever he's demanding to venture into who knows where.\n\n");
		outputText("\"<i>Eh? You’re just gonna leave me like dat? You don' want ta even try to fight me?</i>\" He chuckles, \"<i>Your loss.</i>\"\n\n");
	}*/
	doNext(camp.returnToCampUseOneHour);
}

public function part1TrollEncounterSex():void {
	outputText("You eye him once more, he's tall, easily standing over 8 feet, he's only dressed in a loin cloth and some fur bracers as the rest of his muscular body is covered in light green fuzz. It could be worse, his chiseled face definitely is rather handsome.\n\n");
	outputText("You take him on his offer and decide that you're willing to pay his toll with your body.\n\n");
	outputText("\"<i>Ehhh, what?</i>\" He raises an eyebrow at you, \"<i>Now, now, don't be hasty, I didn' offer dat.</i>\"\n\n");
	outputText("You're not sure what to say, he's actually declining an offering for sex?\n\n");
	outputText("\"<i>Ya know, you really are bold, I'll tell ya what,</i>\" He says as he hops off the tree, \"<i>If you can best me in one of the challenges of my choosing, I’ll let ya pass, it's a good deal, no?</i>\"\n\n");
	menu();
	//addButton(1, "Challenge?", part1TrollEncounterLeave);
	addButton(3, "Leave", part1TrollEncounterLeave);
}

public function part1TrollEncounterPayWithGems():void {
	outputText("You pull out 25 gems from your gem pouch, as you do so he hops down from the tree. He holds out a four-fingered palm, awaiting your payment and you fork the gems over. The entire time he looks directly into your eyes, but at the same time there seems to be a tinge of disappointment within his.\n\n");
	outputText("As you enter the opening in the bog you search around the area and wonder what makes it so special that he wanted to guard it against you.\n\n");
	outputText("You spend some more time looking around the area and stumble upon [completely random non-key item].\n\n");
	outputText("You decide to head back home afterwards as there doesn't appear to be anything else of interest right now.\n\n");
	doNext(camp.returnToCampUseOneHour);
}

public function part1TrollEncounter6():void {
	
}

public function part1TrollEncounter7():void {
	
}

		
	}
}