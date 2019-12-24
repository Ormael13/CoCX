/**
 * ...
 * @author Ormael, Liadri
 */
package classes.Scenes.NPCs 
{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	
	public class NeisaFollower extends NPCAwareContent implements TimeAwareInterface
	{
		
		public function NeisaFollower() 
		{}//between 6 and 15 she get her counter go up by 1 each night and if it hit 15 she leave at the morning xD
		//neisa follower flag: 1-3 - first exploring river dungeon, 4 i 5 - after first exploring, 6 - left camp due to not paid weekly paycheck (to make her return to camp req. to pay her that mercenary fee with all costs for delay so 10 days of fee not 7 - also her affection should drop to 0/pretty low after leaving camp due to not paid weekly paycheck),
		//7 to 16 - hired and staying in camp (7 to 13 - with PC having not yet paid her weekly paycheck - up to 3 days after deadline stays this way, 14 to 16 - when she's paid in time), 18 - after her affection rise high enough and she move from mercenary to camp member
		public function neisaAffection(changes:Number = 0):Number
		{
			flags[kFLAGS.NEISA_AFFECTION] += changes;
			if (flags[kFLAGS.NEISA_AFFECTION] > 50) flags[kFLAGS.NEISA_AFFECTION] = 50;
			if (flags[kFLAGS.NEISA_AFFECTION] > 150 && flags[kFLAGS.NEISA_FOLLOWER] >= 18) flags[kFLAGS.NEISA_AFFECTION] = 150;
			return flags[kFLAGS.NEISA_AFFECTION];
		}
	
//Implementation of TimeAwareInterface
public function timeChange():Boolean
{
	/*if (pregnancy.isPregnant) {
		pregnancy.pregnancyAdvance();
		if (pregnancy.incubation == 0) {
			isabellaFollowerScene.isabellaGivesBirth();
			return true;
		}
	}*/
	if (model.time.hours > 23) {
		if (flags[kFLAGS.NEISA_FOLLOWER] >= 7 && flags[kFLAGS.NEISA_FOLLOWER] < 17) flags[kFLAGS.NEISA_FOLLOWER]++;
	}
	return false;
}
public function timeChangeLarge():Boolean {
	if (model.time.hours == 6 && flags[kFLAGS.NEISA_FOLLOWER] >= 14 && !prison.inPrison) {
		//spriteSelect(31);
		neisaMorningPaycheckCall();
		return true;
	}
	return false;
}
//Morning Paycheck Call
public function neisaMorningPaycheckCall():void {
	//spriteSelect(31);
	outputText("\n");
	if (flags[kFLAGS.NEISA_FOLLOWER] == 17) {
		outputText("Neisa sighs in disappointment when she realises you are short "+(9 - flags[kFLAGS.SPIRIT_STONES])+" spirit stones.\n\n");
		outputText("\"<i>Why now, you forgot to go change gems for spirit stones? That's fine but until you pay the debt you owe me I'm staying back at the inn.</i>\"\n\n");
		outputText("(<b>Neisa has been removed from Followers menu!</b>)\n\n");
		flags[kFLAGS.NEISA_AFFECTION] = 0;
		flags[kFLAGS.NEISA_FOLLOWER] = 6;
	}
	else if (flags[kFLAGS.NEISA_FOLLOWER] == 16) {
		if (flags[kFLAGS.SPIRIT_STONES] > 8) {
			outputText("You pay the spirit stone you owe Neisa as she comes over to collect.\n\n");
			outputText("\"<i>Better late than never. Please try and be on point for the next pay I shouldn't have to remind you 3 times in a row.</i>\"\n\n");
			flags[kFLAGS.SPIRIT_STONES] -= 9;
			flags[kFLAGS.NEISA_FOLLOWER] = 7;
			neisaAffection(0.5);
		}
		else {
			outputText("Neisa comes over for her payment but you realise you are "+(9 - flags[kFLAGS.SPIRIT_STONES])+" spirit stone"+(flags[kFLAGS.SPIRIT_STONES] == 8 ? "":"s")+" short\n\n");
			outputText("\"<i>Look [name] at this point I'm done trying to find excuses for you. If you can't pay me by tomorrow I'm leaving.</i>\"\n\n");
		}
	}
	else if (flags[kFLAGS.NEISA_FOLLOWER] == 15) {
		if (flags[kFLAGS.SPIRIT_STONES] > 7) {
			outputText("You pay the spirit stone you owe Neisa as she comes over to collect.\n\n");
			outputText("\"<i>Looks like everything is accounted for just try to have it ready faster next time.</i>\"\n\n");
			flags[kFLAGS.SPIRIT_STONES] -= 8;
			flags[kFLAGS.NEISA_FOLLOWER] = 7;
			neisaAffection(1);
		}
		else {
			outputText("Neisa comes over for her payment but you realise you are "+(8 - flags[kFLAGS.SPIRIT_STONES])+" spirit stone"+(flags[kFLAGS.SPIRIT_STONES] == 7 ? "":"s")+" short.\n\n");
			outputText("\"<i>Forgetful memory? You still are "+(8 - flags[kFLAGS.SPIRIT_STONES])+" spirit stone"+(flags[kFLAGS.SPIRIT_STONES] == 7 ? "":"s")+" short pcname. Make sure you got them tomorrow.</i>\"\n\n");
		}
	}
	else {
		if (flags[kFLAGS.SPIRIT_STONES] > 6) {
			outputText("You pay the spirit stone you owe Neisa as she comes over to collect.\n\n");
			outputText("\"<i>Ever happy doing business with you [name].</i>\"\n\n");
			flags[kFLAGS.SPIRIT_STONES] -= 7;
			flags[kFLAGS.NEISA_FOLLOWER] = 7;
			neisaAffection(1.5);
		}
		else {
			outputText("Neisa comes over for her payment but you realise you are "+(7 - flags[kFLAGS.SPIRIT_STONES])+" spirit stone"+(flags[kFLAGS.SPIRIT_STONES] == 6 ? "":"s")+" short.\n\n");
			outputText("\"<i>Heh, I don't mind if you are paying late, mistakes happen. Just make sure you got my pay for tomorrow as well as the missing spirit stones of today.</i>\"\n\n");
		}
	}
	doNext(playerMenu);
}

public function neisaCampMenu():void {
	clearOutput();
	outputText("Neisa noticing your approach slashes the dummy a final time before stopping her training. She sits on a nearby wooden log and looks straight at you.\n\n");
	outputText("\"<i>Well what's up [name] how can I help you?</i>\"\n\n");
	menu();
	addButton(0, "Appearance", neisaAppearance).hint("Examine Neisa appearance.");
	if (flags[kFLAGS.CAMP_UPGRADES_SPARING_RING] >= 2) addButton(1, "Spar", neisaSpar).hint("Do a quick battle with Neisa!");
	//addButton(2, "Talk", talkWithValeria).hint("Discuss with Valeria.");
	//if (player.lust >= 33) addButton(3, "Sex", followersValeriaSex).hint("Initiate sexy time with the armor-goo.");
	if (player.hasPerk(PerkLib.BasicLeadership)) {
		if (flags[kFLAGS.PLAYER_COMPANION_1] == "") addButton(5, "Team", neisaHenchmanOption).hint("Ask Neisa to join you in adventures outside camp.");
		else if (flags[kFLAGS.PLAYER_COMPANION_1] == "Neisa") addButton(5, "Team", neisaHenchmanOption).hint("Ask Neisa to stay in camp.");
		else addButtonDisabled(5, "Team", "You already have other henchman accompany you. Ask him/her to stay at camp before you talk with Neisa about accompaning you.");
	}
	addButton(14, "Back", camp.campFollowers);
}

public function neisaAppearance():void {
	clearOutput();
	outputText("Neisa is a seven feet tall human or at least outwardly looks like one. Her black hair is short and straight and her green eyes always watchful. She could pass for a beautiful woman back home although in Mareth pretty faces are far from uncommon thanks to the whole demonic corruption problem turning every person into sexy temptresses or manly perfection.\n\n");
	outputText("Neisa’s arms are well muscled despite their womanly shape to use a shield and any melee weapon, you suspect she does a rigorous training between jobs. Her legs are those of an adventurer who is used to walking for a long periods of time. She got a well shaped waistline with a girly ass that fits just fine in her armor.\n\n");
	outputText("Similar to most of the impressive gravity defying sizes visible on most women on mareth she sports an I cup set of breasts.\n\n");
	outputText("You have yet to see what she hides under her semi skimpy armor but you suspect she got a pussy and no cock, making her a true female.");
	menu();
	addButton(14, "Back", neisaCampMenu);
}

public function neisaSpar():void {
	clearOutput();
	outputText("Neisa is now following you around.\n\n");
	startCombat(new Neisa());
}
public function neisaSparWon():void {
	clearOutput();
	outputText("Neisa is now following you around.\n\n");//beating neisa
	neisaAffection(3);
	doNext(cleanupAfterCombat);
}
public function neisaSparLost():void {
	clearOutput();
	outputText("Neisa is now following you around.\n\n");//been beaten by neisa
	neisaAffection(1);
	doNext(cleanupAfterCombat);
}

public function neisaHenchmanOption():void {
	clearOutput();
	if (flags[kFLAGS.PLAYER_COMPANION_1] == "") {
		outputText("\"<i>As you command Boss.</i>\"\n\n");
		outputText("Neisa is now following you around.\n\n");
		var strNeisa:Number = 100;
		var meleeAtkNeisa:Number = 12;
		/*if (flags[kFLAGS.ETNA_LVL_UP] >= 1) {
			strEtna += 10 * flags[kFLAGS.ETNA_LVL_UP];
			libEtna += 20 * flags[kFLAGS.ETNA_LVL_UP];
		}*/
		strNeisa *= (1 + (0.2 * player.newGamePlusMod()));
		strNeisa = Math.round(strNeisa);
		meleeAtkNeisa += (1 + (int)(meleeAtkNeisa / 5)) * player.newGamePlusMod();
		player.createStatusEffect(StatusEffects.CombatFollowerNeisa, strNeisa, meleeAtkNeisa, 0, 0);
		flags[kFLAGS.PLAYER_COMPANION_1] = "Neisa";
	}
	else {
		outputText("Neisa is no longer following you around.\n\n");
		player.removeStatusEffect(StatusEffects.CombatFollowerNeisa);
		flags[kFLAGS.PLAYER_COMPANION_1] = "";
	}
	doNext(neisaCampMenu);
	cheatTime(1/12);
}


	}
}