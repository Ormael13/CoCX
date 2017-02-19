package classes.Scenes.Places.Farm {
	import classes.*;
	import classes.GlobalFlags.kFLAGS;

	public class KeltScene extends AbstractFarmContent{

		public var kelly:Kelly = new Kelly();
		
	public function KeltScene()
	{
	}

	/*Kelt the Centaur Archer
A Corruption of Champions Event by Ourakun

Foreword
Thank you again for accepting my game idea, Fenoxo. This file has been updated to try and make things a little more streamlined, and to make Submissiveness growth a little more gradual. Please use this file instead of the last one I sent you. Most of the events are identical, though, so if you have done any coding from the first, it should not be too different.

Also: As you implied that you are making a centaur herd, I felt it might be important to state that I consider Kelt to be quite different from centaurs as a group. Please do not feel compelled to tie his rather abusive storyline into theirs, or to make them anything like him. You may, of course, use him however you like...I just don't want you to feel it necessary. Thank again, and I hope you like it.

Ourakun

Premise
One of the things I feel CoC could use more of is slow corruption. That is not a complaint, of course...I enjoy the game quite a bit. But when I play, I tend to avoid corrupting events at first, then sort of slide into them as I imagine my character grows more and more jaded. I enjoy a slow fall, rather than an immediate one.

To that end, I created an event centered around slowly corrupting a player into a sexual situation, rather than a monster that rapes or is raped. This event is more about atmosphere than it is about immediate gratification. Making the player feel like their character is seduced into the fall...in a manner of speaking. In actuality, there is very little seduction.

Kelt is designed as an alpha male...someone with an inherently dominent personality who seeks to control others. The idea is that a character who continuously visits the centaur will grow more submissive to him as time goes on, as his abrasive personality breaks their spirit. By the end, they pleasure him willingly.

This event includes two hidden stats. The first is a measure of skill at archery, which would be a new weapon for the players. This would be on a scale from 0-100, and measure the player's effectiveness with a bow. The higher the skill, the more damage the weapon would do. The second hidden stat is Submissive. This measures how dominent Kelt is over the player, making them more and more easily controlled. Some players will avoid this, for as long as they can. Others will dive right in. And some who dislike this sort of thing, would never get involved. Ideally, all three situations are covered in this event.

Event Guide
Here is a basic summary of how the event progresses.

First visit—Introduction scene. keltFirstTime();
Second visit—Normal encounter keltMainEncounter()
Third visit—Normal encounter keltMainEncounter()
Fourth visit—Naked Requirement keltRequiresNakedness()
Fifth visit onwards—Normal encounter, raising Submissiveness. Varients for nudity.
60+ Submissiveness—Blowjob Requirement
75+ Submissiveness, 60+ Lust—Lust Encounter
100 Submissiveness or Centaur body—Bad End (Unfinished)
Player in Heat—Normal encounter, Heat varient
Pregnancy—Centaur child (Unfinished)

Archery - 0 to 100.  [Bow] Weapon does more damage as skill rises.

Submissiveness - 0 to 100.  Determines submissiveness to kelt. 

STATUSES:
"NakedOn"
"BlowjobOn"
"Kelt" - v1 = Archery, v2 = Submissiveness, v3 = total encounters.
"KeltOff" - Turns off Kelt */

private function bowSkill(diff:Number):Number {
	player.addStatusValue(StatusEffects.Kelt,1,diff);
	if (player.statusEffectv1(StatusEffects.Kelt) >= 100) player.changeStatusValue(StatusEffects.Kelt,1,100);
	return player.statusEffectv1(StatusEffects.Kelt);
}

//Function to choose which Kelt Encounter to load.
public function keltEncounter():void {
	spriteSelect(35);
	//Clear screen, set next button, and count how many times hes been encountered
	clearOutput();
	player.addStatusValue(StatusEffects.Kelt,3,1);
	//If First Encounter
	if (player.findStatusEffect(StatusEffects.Kelt) < 0) {
		player.createStatusEffect(StatusEffects.Kelt,0,0,1,0);
		keltFirstTime();
	}
	//Repeated encounter
	else {
		//Second/Third Events - Normal
		if (player.statusEffectv3(StatusEffects.Kelt) <= 3) {
			keltMainEncounter();
			return;
		}
		//Bad Ends
		if (player.statusEffectv2(StatusEffects.Kelt) >= 130) {
			if (((player.lib + player.lust) < 30 && player.inte >= 50) || player.findStatusEffect(StatusEffects.KeltBadEndWarning) < 0)
			{
				player.createStatusEffect(StatusEffects.KeltBadEndWarning, 0, 0, 0, 0);
				outputText("You race towards the farm, only one thought on your mind.  Kelt... your master, your love, your hunger.  Your head is filled with thoughts of his cock, and you fancifully dream of how he will use it on you today.  Once, you had a mission of some kind... an important duty.  The stray thought vanishes almost instantly, though.  Of course you have a duty!  To be fucked by Kelt, whenever he wants to!\r\r")
				outputText("Suddenly, another thought crosses your mind. You have a feeling that if you meet him, it could be the end of your adventures. Do you give in to your thoughts and submit to Kelt for the final time or resist?")
				doYesNo(keltSubmissiveBadEnd, defySubmission);
				addButton(4, "FIGHT!", defySubmissionAndFight);
			}
			else keltSubmissiveBadEnd();
			return;
		}
		//Centaur bad end
		if (player.isTaur() && player.statusEffectv2(StatusEffects.Kelt) >= 100 && player.gender > 1) {
			if (player.inte > rand(40) && player.statusEffectv2(StatusEffects.Kelt) < 130 && player.findStatusEffect(StatusEffects.KeltBadEndWarning) < 0) {
				player.createStatusEffect(StatusEffects.KeltBadEndWarning,0,0,0,0);
				outputText("You approach the farm, ready for another archery lesson.  Kelt is oblivious to your presence, busy practicing with his own bow for the moment.  The wind shifts and blows his musk your way.  Unconsciously, you breathe deeply, sending heat racing between your rear legs.  Alarm bells go off in your mind as you realize what his presence is doing to you, and you run away to your camp before he can notice you.  It's clear to you that you can't resist him much longer; the next time you meet him, you'll probably volunteer to become his brood-mare.  Perhaps you should avoid Kelt and the farm until you feel his influence less keenly.", true);
				dynStats("lus", player.lib/5 + 10);
				doNext(camp.returnToCampUseOneHour);
			}
			else keltCentaurBadEnd();
			return;
		}
		//Naked event if its time for it
		if (player.statusEffectv3(StatusEffects.Kelt) == 4 && player.findStatusEffect(StatusEffects.NakedOn) < 0) {
			keltRequiresNakedness();
			return;
		}
		//60+ Submissiveness—First Time Blowjob Requirement
		if (player.statusEffectv2(StatusEffects.Kelt) >= 40 && player.findStatusEffect(StatusEffects.KeltBJ) < 0) {
			keltRequiresBlowjobs();
			return;
		}
		//75+ Submissiveness, 60+ Lust—Lust Encounter
		//Remaining events
		if (player.statusEffectv3(StatusEffects.Kelt) > 4) {
			keltMainEncounter();
		}
	}
}

//Introduction
private function keltFirstTime():void {
	outputText("As you approach Whitney's farm, you notice a figure in the pastures, way in the distance.  It seems to be someone riding a horse, to your surprise... possibly even Whitney herself.  You hadn't expected to find real horses in this forsaken realm.  If you could somehow trade for one, it would be a real help.  Energized by the idea, you hop the fence, approaching the distant figure.\r\r", false);
	outputText("As you get closer, however, the figure comes into view.  The rider is not Whitney, but rather a muscular man.  And the horse has no head... where its head should be is... with a start, you realize that this is no horse and rider.  The figure is a large, male centaur!\r\r", false);
	outputText("Wariness growing, you slow down.  But it is too late... the centaur has seen you.  With a snort, he gallops closer, imposingly tall.  You drop into a fighting stance, ready if he should attack you, and the centaur draws to a halt a few feet away.\r\rHe looks scornfully at you, and laughs, ", false);
	outputText("\"<i>Don't be stupid.  You'd never even get close to me.  If I wanted to kill you, you would have been dead a long time ago.  My name is Kelt.</i>\"\r\r", false);
	outputText("He touches a longbow that is strung around his chest.  The size of the bow is enough to convince you.  If he can draw back a bow that thick, he would surely have enough power to hit you from almost across the field.  A weapon like that could be very useful in fending off some of the monsters in this land.  The centaur notices you looking, and grins arrogantly.\r\r", false);
	outputText("\"<i>Like my bow?  As well you should.  This is a real warrior's weapon!  If you want to learn someday, visit me again.  Maybe if you're not too stupid, you will be able to learn something.  I won't cross my fingers.</i>\"\r\r", false);
	outputText("He laughs again derisively, and trots off.  You bristle slightly... he is irritatingly arrogant.  But if he can teach you to use a weapon like that, it may be worth putting up with his company...", false);
	doNext(camp.returnToCampUseOneHour);
}

private function defySubmission():void {
	outputText("In defiance to your submissiveness to Kelt, you suddenly shake your head and return to your camp.", true)
	doNext(camp.returnToCampUseOneHour);
}
private function defySubmissionAndFight():void {
	outputText("In defiance to your submissiveness to Kelt, you suddenly shake your head and you finally decide. That's it. That centaur must be punished! It's time you turn the tables against him.", true)
	doNext(kelly.fightToBeatKelt);
}

public function fightToBeatKeltVictoryHP():void {
	outputText("Too weak to continue fighting, Kelt collapses.", true)
	chooseToFinishKelt()
}	
public function fightToBeatKeltVictoryLust():void {
	outputText("Overwhelmed by his desires, Kelt collapses.", true)
	chooseToFinishKelt()
}	

private function chooseToFinishKelt():void {
	combat.cleanupAfterCombat();
	outputText("\n\nYou step over to the defeated centaur, wondering what you should do.", false)
	addButton(0, "Kill Him", youBadEndKeltForGood);
	addButton(1, "Rape Him", fuckKeltsShitUp);
	addButton(4, "TakeBow&Leave", leaveKelt4Good);
}

//Give Kelt the Bad End!
private function youBadEndKeltForGood():void {
	clearOutput();
	outputText("Without a second thought, you grab Kelt by his neck. The centaur yells \"<i>Nooooo! Don't you do that, bitch!</i>\"\n\n");
	outputText("With an abrupt twist, you snap his neck, ending his life. You grab the bow from Kelt. Seeing how it looks stronger than your flimsy bow, you snap the old bow and throw it onto the ground. You are proud of the newly-taken bow.\n\n");
	outputText("<b>(You got Kelt's Bow!)</b>");
	player.removeKeyItem("Bow");
	player.createKeyItem("Kelt's Bow", 0, 0, 0, 0);
	//player.removeStatusEffect(StatusEffects.Kelt);
	player.createStatusEffect(StatusEffects.KeltOff, 0, 0, 0, 0);
	dynStats("cor", 10);
	flags[kFLAGS.KELT_KILLED] = 1;
	doNext(camp.returnToCampUseOneHour);
}

private function leaveKelt4Good():void {
	clearOutput();
	outputText("Determining he's not worth your time, you walk away. Somehow, you've got the feeling that you won't be seeing him again.");
	outputText("You also find the bow that Kelt left behind. Seeing how it looks stronger than your flimsy bow, you snap the old bow and throw it onto the ground. You are proud of the newly-taken bow.\n\n");
	outputText("<b>(You got Kelt's Bow!)</b>");
	player.removeKeyItem("Bow");
	player.createKeyItem("Kelt's Bow", 0, 0, 0, 0);
	player.createStatusEffect(StatusEffects.KeltOff, 0, 0, 0, 0);
	doNext(camp.returnToCampUseOneHour);
}

//Naked Requirement
private function keltRequiresNakedness():void {
	outputText("Once more, you encounter Kelt the centaur at Whitney's farm.  You approach him to ask for another archery lesson, but Kelt is already scowling at you as you draw near.\r\r", false);
	outputText("\"<i>I can't teach you like this,</i>\" he sneers.  \"<i>Your balance is all fucked up.  I know colts who can shoot better than you.  You really want to learn the skill?  Then you're gonna have to practice like a centaur.  You'd never see me wearing armor!</i>\"\r\r", false);
	outputText("He slaps a hand on his bare chest proudly, and you realize that he means for you to strip down naked.  When you protest, his eyes narrow with irritation, and his sneer becomes more cruel.\r\r", false);
	outputText("\"<i>Didn't know you were a coward, too.  That's fine... go fuck off, then.  You can't handle it, then go back to your camp and braid your hair, or something.  If you wait long enough, I'm sure a nice minotaur will come along to make you his bitch.  'Bout all you're good for, right?</i>\"\r\r", false);
	outputText("Do you obey his demand?", false);
	if (player.cor > 70 - player.corruptionTolerance() && player.inte > 40 && !player.isTaur()) {
		outputText("\n\n<b>If you fight back and take him down a peg, you might never see him again...</b>");
		simpleChoices("Reluctantly", keltReluctantlyGetNaked, "Eagerly", keltEagerlyGetNaked, "Fight Back", keltResistance, "", null, "Never", keltRefuseNakedness);
		return;
	}
	else simpleChoices("Reluctantly", keltReluctantlyGetNaked, "Eagerly", keltEagerlyGetNaked, "", null, "", null, "Never", keltRefuseNakedness);
	//(Corruption higher than 60 automatically chooses eagerly)
	if (player.cor + player.lib + player.lust >= 180) {
		outputText(" Of course you do.  You love putting on a show.", false);
		// go eagerly.
		doNext(keltEagerlyGetNaked);
	}
}

//Naked Requirement, Never
private function keltRefuseNakedness():void {
	spriteSelect(35);
	outputText("You adamantly refuse, determined to not give this arrogant centaur the satisfaction.  Kelt sneers at you derisively, and gives you several pieces of advice as to what could fit up your rear end.  As his insults grow more colorful, you turn and leave; his mocking laughter follows behind you.  You resolve to not bother with him anymore.\r\r(Somehow you know you'll never encounter him again.)", true);
	//(Kelt never encountered again)
	player.createStatusEffect(StatusEffects.KeltOff,0,0,0,0);
	doNext(camp.returnToCampUseOneHour);
}
//Naked Requirement, Eagerly
private function keltEagerlyGetNaked():void {
	doNext(camp.returnToCampUseOneHour);
	spriteSelect(35);
	clearOutput();
	outputText("You have no problem " + player.clothedOrNaked("stripping down", "being") + " naked in front of Kelt, even enjoying the process a little bit.  Judging by his leer, Kelt is enjoying it too.  He seems aroused by his power over you more than anything else... and you find yourself admitting that you're a little aroused by it as well.\r\r", false);
	outputText("You " + player.clothedOrNaked("remove your top first, slowly revealing your " + player.allBreastsDescript(), "show off your " + player.allBreastsDescript()) + ".  Kelt is pacing around you, eyes locked on your chest hungrily.  As you let your top fall to the ground, he laughs mockingly, though, ", false);
	if (player.gender == 1 && player.biggestTitSize() < 1) outputText("\"<i>What are you, a girl?  Get on with it so I can see what I'm dealing with.</i>\"\r\r", false);
	else {
		if (player.biggestTitSize() == 0) outputText("\"<i>Oops!  Could have sworn I'd find a pair of tits on you.  That's okay... I'm sure you'll hit puberty some day!</i>\"\r\r", false);
		//(Too small, A to DD: 
		else if (player.biggestTitSize() <= 5) outputText("\"<i>Ha! No wonder you cover up like a sniveling human!  Any centaur maiden would be ashamed to go out in public with " + num2Text(player.totalBreasts()) + " mosquito bites like that!  What do they call you back home... 'Tiny Tits'?  Or maybe they all just assume you're a guy!</i>\"\r\r",false);
		//(Medium, E to HHH:
		else if (player.biggestTitSize() <= 11) outputText("\"<i>Uh oh, boys... look out!  Miss Melons here has been putting on a little weight!  How did someone like you become an adventurer?  From the waist up, you're good for whoring and not much else!</i>\"\r\r", false);
		//(Big, Watermelon and beyond:
		else outputText("\"<i>Oooh, doesn't that look yummy?  Be honest... you wanna learn to shoot?  You'll be slapping yourself in the tits with every shot!  Heh... I bet that's the way you like it too!  Time to change your profession, slut.  Wet nurse and milk cow... they're just about all you're suited for!</i>\"\r\r", false);
	}
	outputText("Despite his harsh comments, you can see the lust in Kelt's eyes, and are more than a little turned on by his derisive laughter.  His critique only becomes more lewd when you continue.  " + player.clothedOrNaked("As you remove the lower half of your clothes, stripping completely naked", "As you perform a pelvic thrust and slowly spin around") +", he eyes your ass and lets out a crude hoot of scornful delight, ", false);
	//(Too small, Firm to Shapely:
	if (player.buttRating < 6) outputText("\"<i>Well, someone works out!  Got a nice, tight little ass there! Probably a little too tight, huh?  Don't worry, you can tell me... do the mean old monsters hurt when they fuck that poor little ass of yours? HA!</i>\"\r\r", false);
	//(Medium, Large to Heavy:
	else if (player.buttRating < 13) outputText("\"<i>Hey, nice little cushion you got back here!  Do you get that from sitting around all day?  Nah, can't be that.  I'm sure you get more than a workout on this baby... of course, cock is no substitute for a little exercise, you know!</i>\"\r\r", false);
	//(Big, Voluminous and beyond:
	else outputText("\"<i>Now there's a rear end I could get behind!  For someone who claims to be a hero, you sure are built like a fucktoy!  With an ass like that, you remind me of my last lay... of course, she was a horse!</i>\"\r\r", false);
	outputText("He slaps your ass with his open palm, getting in a good grope while he's at it.  His animalistic musk is in your nostrils, making you feel dizzy and more than a little aroused.  He grins widely, then walks around to your front, ", false);
	//(No Cock:
	if (player.totalCocks() == 0) outputText("\"<i>Well, aren't you a pretty little thing, all together.  You and I will get along real nice, that's for sure!</i>\"\r\r", false);
	else {
		//(Any Cock: 
		outputText("and almost inevitably, his eyes drop down to your " + player.cockDescript(0) + ".  He snorts, ", false);
		//(Human Cock:
		if (player.cocks[0].cockType == CockTypesEnum.HUMAN) outputText("\"<i>Heh.  Just sporting the normal model, huh?  You know there's a phrase around here... hung like a human!  Trust me... it's not a compliment.  ", false);
		//(Dog Cock:
		if (player.cocks[0].cockType == CockTypesEnum.DOG) outputText("\"<i>Oh, lookie here!  We got ourselves a little doggie dong!  Well, cock or not, you'll always be a bitch to me, mutt.  ", false);
		//(Horse Cock: 
		if (player.cocks[0].cockType == CockTypesEnum.HORSE) outputText("\"<i>Now that's just sad.  Getting a little envious of me, huh?  Had to go out and get a nice horsecock all your own?  Should have asked.  I'd have given you a taste of mine!  ", false);
		//(Tentacle Cock or other weirdness
		if (player.cocks[0].cockType.Index >= 3) outputText("\"<i>Hah!  I'll bite... what the fuck are you supposed to be?  That a cock, or just an ugly, misplaced tail?  HA!  ", false);
		//(Small Size, ?-10 inches:
		if (player.cocks[0].cockLength <= 10) outputText("\"So, when you poke a woman with that, does she notice?  Or do you have to tell her when to start faking her orgasm?</i>\"\r\r", false);
		//(Medium Size, 11-20 inches: 
		else if (player.cocks[0].cockLength <= 20) outputText("\"Still, at least you've got a decent sized cock.  You know, for a colt.  Maybe you'll get lucky, and the real women will take pity on you!</i>\"\r\r", false);
		//(Big Size, 21 inches and beyond:
		else outputText("\"Now if only they could find a way to get you to stop stepping on your own cock every other step, maybe you'd be a real man!  Can you even get it up, at this point?  Or would that tip you over?  Ha!</i>\"\r\r", false);
	}
	outputText("He looks you over one last time, and sneers condescendingly.  \"<i>Well, it ain't much as far as heroes go.  But it's better than nothing.  Fine, I'll teach ya some more.  But I don't want to see those damn clothes again.  You'll learn the way I tell you to learn, got it?</i>\"\r\r", false);
	outputText("You nod, almost grateful for the excuse to go naked.  From the way Kelt is eyeing your ass, you think he'll enjoy it too.\r\r", false);
	//(Naked on. Every visit, player will automatically strip.)
	player.createStatusEffect(StatusEffects.NakedOn,0,0,0,0);
	//(+10 Submissive)
	player.addStatusValue(StatusEffects.Kelt,2,10);
	dynStats("lus", int(player.lib/10) +5);
	keltMainEncounter2();
}

//Naked Requirement, Reluctantly
private function keltReluctantlyGetNaked():void {

	doNext(camp.returnToCampUseOneHour);
	spriteSelect(35);
	clearOutput();
	outputText("You are uncomfortable with the idea of being naked in front of this crude, cruel taskmaster.  But he is good at what he does, and if this is the only way to convince him to teach you, then you'll just have to get it over with.  You agree to his terms reluctantly, and begin to strip off your " + player.armorDescript() + ".\r\r", false);		   
	outputText("You " + player.clothedOrNaked("remove your top first, slowly revealing your " + player.allBreastsDescript(), "show off your " + player.allBreastsDescript()) + ".  Kelt is pacing around you, eyes locked on your chest hungrily.  As you let your top fall to the ground, he laughs mockingly, ", false);
	if (player.gender == 1 && player.biggestTitSize() < 1) outputText("\"<i>What are you, a girl?  Get on with it so I can see what I'm dealing with.</i>\"\r\r", false);
	else {
		if (player.biggestTitSize() == 0) outputText("\"<i>Oops!  Could have sworn I'd find a pair of tits on you.  That's okay... I'm sure you'll hit puberty some day!</i>\"\r\r", false);
		//(Too small, A to DD: 
		else if (player.biggestTitSize() <= 5) outputText("\"<i>Ha! No wonder you cover up like a sniveling human!  Any centaur maiden would be ashamed to go out in public with " + num2Text(player.totalBreasts()) + " mosquito bites like that!  What do they call you back home... 'Tiny Tits'?  Or maybe they all just assume you're a guy!</i>\"\r\r",false);
		//(Medium, E to HHH:
		else if (player.biggestTitSize() <= 11) outputText("\"<i>Uh oh, boys... look out!  Miss Melons here has been putting on a little weight!  How did someone like you become an adventurer?  From the waist up, you're good for whoring and not much else!</i>\"\r\r", false);
		//(Big, Watermelon and beyond:
		else outputText("\"<i>Oooh, doesn't that look yummy?  Be honest... you wanna learn to shoot?  You'll be slapping yourself in the tits with every shot!  Heh... I bet that's the way you like it too!  Time to change your profession, slut.  Wet nurse and milk cow... they're just about all you're suited for!</i>\"\r\r", false);
	}
	outputText("Even with his harsh comments, you can see the lust in Kelt's eyes.  He is obviously enjoying seeing your naked flesh.  Despite the embarrasment, you are determined to not let his remarks get to you.  His critique only becomes more lewd as you continue, though.  " + player.clothedOrNaked("As you remove the lower half of your clothes, stripping completely naked", "As you perform a pelvic thrust and slowly spin around") +", he eyes your ass and lets out a crude hoot of scornful delight, ", false);
	//(Too small, Firm to Shapely:
	if (player.buttRating < 6) outputText("\"<i>Well, someone works out!  Got a nice, tight little ass there! Probably a little too tight, huh?  Don't worry, you can tell me... do the mean old monsters hurt when they fuck that poor little ass of yours? HA!</i>\"\r\r", false);
	//(Medium, Large to Heavy:
	else if (player.buttRating < 13) outputText("\"<i>Hey, nice little cushion you got back here!  Do you get that from sitting around all day?  Nah, can't be that.  I'm sure you get more than a workout on this baby... of course, cock is no substitute for a little exercise, you know!</i>\"\r\r", false);
	//(Big, Voluminous and beyond:
	else outputText("\"<i>Now there's a rear end I could get behind!  For someone who claims to be a hero, you sure are built like a fucktoy!  With an ass like that, you remind me of my last lay... of course, she was a horse!</i>\"\r\r", false);
	outputText("He slaps your " + player.buttDescript() + " with his open palm, getting in a good grope while he's at it.  His animalistic musk is in your nostrils, making you feel dizzy and somehow even a little aroused.  The centaur's obvious enjoyment of your body is a little flattering, even if his words are cruel.  He paces around to your front, a shameless grin on his face while he taunts you, ", false);
	//(No Cock:
	if (player.totalCocks() == 0) outputText("\"<i>Well, aren't you a pretty little thing, all together.  You and I will get along real nice, that's for sure!</i>\"\r\r", false);
	else {
		//(Any Cock: 
		outputText("and almost inevitably, his eyes drop down to your " + player.cockDescript(0) + ".  He snorts, ", false);
		//(Human Cock:
		if (player.cocks[0].cockType == CockTypesEnum.HUMAN) outputText("\"<i>Heh.  Just sporting the normal model, huh?  You know there's a phrase around here... hung like a human!  Trust me... it's not a compliment.  ", false);
		//(Dog Cock:
		if (player.cocks[0].cockType == CockTypesEnum.DOG) outputText("\"<i>Oh, lookie here!  We got ourselves a little doggie dong!  Well, cock or not, you'll always be a bitch to me, mutt.  ", false);
		//(Horse Cock: 
		if (player.cocks[0].cockType == CockTypesEnum.HORSE) outputText("\"<i>Now that's just sad.  Getting a little envious of me, huh?  Had to go out and get a nice horsecock all your own?  Should have asked.  I'd have given you a taste of mine!  ", false);
		//(Tentacle Cock or other weirdness
		if (player.cocks[0].cockType.Index >= 3) outputText("\"<i>Hah!  I'll bite... what the fuck are you supposed to be?  That a cock, or just an ugly, misplaced tail?  HA!  ", false);
		//(Small Size, ?-10 inches:
		if (player.cocks[0].cockLength <= 10) outputText("\"So, when you poke a woman with that, does she notice?  Or do you have to tell her when to start faking her orgasm?</i>\"\r\r", false);
		//(Medium Size, 11-20 inches: 
		else if (player.cocks[0].cockLength <= 20) outputText("\"Still, at least you've got a decent sized cock.  You know, for a colt.  Maybe you'll get lucky, and the real women will take pity on you!</i>\"\r\r", false);
		//(Big Size, 21 inches and beyond:
		else outputText("\"Now if only they could find a way to get you to stop stepping on your own cock every other step, maybe you'd be a real man!  Can you even get it up, at this point?  Or would that tip you over?  Ha!</i>\"\r\r", false);
	}
	outputText("He looks you over one last time, and sneers condescendingly.  \"<i>Well, it ain't much as far as heroes go.  But it's better than nothing.  Fine, I'll teach ya some more.  But when I tell you to strip, you do it a little faster next time... or I might not be so generous.</i>\"\r\r", false);
	outputText("You nod, a little irritated at his callous nature.  You're not entirely sure you want to be naked in front of this crude centaur... but for now, at least, he'll teach you a little more.  Though the way he eyes your ass does make you feel a little uncomfortable.\r\r", false);	
	//(+7 Submissive)
	player.addStatusValue(StatusEffects.Kelt,2,7);
	dynStats("lus", int(player.lib/10) +5);
	keltMainEncounter2();
}

//Blowjob Requirement
private function keltRequiresBlowjobs():void {
	spriteSelect(35);
	player.createStatusEffect(StatusEffects.KeltBJ,0,0,0,0);
	outputText("Crossing the field of Whitney's farm, your heart begins to beat a little bit faster as you spy Kelt the centaur off in the distance.  You can't help but admire his powerful flanks and his proud stature as he runs freely.  Perhaps a little pleased with yourself, you also take a good look at his dangling equipment, sheathed yet sizable.  The sight is entrancing.\r\r", false);
	outputText("A grin crosses your face, despite yourself.  Kelt can be insufferable sometimes.  Most times.  Okay, at all times.  But there is something about him that makes you feel... right, somehow.  Sure he insults you... but he is so strong, so powerful.  So masculine, for lack of a better word.  Infuriating, arrogant, and utterly in control.  Somehow, the combination makes you feel weak at the knees.\r\r", false);
	outputText("\"<i>Enjoying the sights, are we?</i>\"\r\r", false);
	outputText("You blink, startled.  While you were thinking, Kelt approached you, and you were staring directly at his crotch.  He leers down at you with an arrogant grin.  Flushed, you stammer out that you're here for more archery lessons.  He snorts, clearly amused.\r\r", false);
	outputText("\"<i>Yeah, I'll bet.  When they talk about firing shafts, whore, they're talking about arrows.  Bet you would prefer the other kind though, huh?</i>\"\r\r", false);
	outputText("He paces around you, in an almost predatory fashion.  His thick flanks brush up against you, and the smell of him is so potent you feel a little dizzy.  Heady and musky, the scent is like a keen aphrodisiac, cutting straight to your core.  You whimper a little, and Kelt raises an eyebrow.  Is it you, or does he almost look satisfied?\r\r", false);
	outputText("\"<i>Well, I think you've had enough freebies.  Maybe I don't wanna teach you anymore.  After all... what do I get from it?  I spend all day teaching a moron how not to shoot [him]self in the foot, and I got nothing to show for it.  I think it's about time you put down a little payment.</i>\"\r\r", false);
	outputText("You nod automatically, fumbling for the pouch you store gems in.  Kelt casually backhands you as you do so, knocking you to the ground.  Your cheek burns hotly, and your head has cleared a little from the pain.  Kelt is sneering down at you, but there is something darkly pleased in his expression.\r\r", false);
	outputText("\"<i>I don't want your fucking money.  What am I gonna buy... hentai comics and scholar tea?  Fuck off.  You want to learn more about archery?  Then it's about time you showed some gratitude.</i>\"\r\r", false);
	outputText("He pushes you over with ease, toppling you facedown into the mud.  Sputtering, you try to rise, only to find that Kelt has moved so that he stands above you, hooves on either side of your head.  Wiping slime from your face, you realize why.  Beneath the barrel of his stomach, his massive cock is slowly dropping from his sheath, growing larger by the second.\r\r", false);
	outputText("You can't help but stare at the engorged head, flaring out from the tip of the mottled shaft.  Above you, Kelt snorts, sounding more like an impatient horse than a person, and moves forward slightly; his half-erect member presses against your cheek.  You let out a startled yelp as the hot, damp flare presses against your face, staining your cheek with a thick dollop of precum.  Kelt grunts again, more urgently.\r\r", false);
	outputText("\"<i>You know the price, slut. You want archery lessons, and I want to blow my load in that throat of yours. Everyone wins. Now get started.</i>\"\r\r", false);
	outputText("You swallow hard.  You don't have to take this!  Kelt is an arrogant, abusive, well-hung, enticing, delicious... you shake your head, thoughts clouded.  The cock grows larger and thicker by the second, and the musk of it delights your senses.  Part of you reasons that one little blowjob won't hurt... right?", false);
	outputText("\r\rDo you submit?", false);
	//(Corruption higher than 80 automatically chooses Eagerly)
	if (player.cor + player.lib + player.lust >= 200 && player.inte < 60) {
		outputText("  Of course you do, slut that you are.", false);
		doNext(keltBlowjobRequirementEagerly);
		return;
	}
	simpleChoices("Shamefully", keltBlowjobRequirementShamefully, "Eagerly", keltBlowjobRequirementEagerly, "Never!", keltBlowjobRequirementNever, "", null, "FIGHT!", kelly.fightToBeatKelt);
	//Never!			Shamefully			Eagerly
	if (player.inte > 40 && player.cor > 70 - player.corruptionTolerance() && !player.isTaur()) {
		outputText("\n\n<b>If you fight back and take him down a peg, you might never see him again...</b>");
		addButton(3, "Fight Back", keltResistance);
	}
}

//Blowjob Requirement, Never
private function keltBlowjobRequirementNever(newl:Boolean = true):void {
	spriteSelect(35);
	if (newl) clearOutput();
	outputText("You struggle, trying to hold onto your fragmented thoughts. Something about Kelt's scent, or presence, is overwhelming.  The temptation to give in is almost overpowering, but you set your teeth, close your eyes, and furiously try to ignore your hammering heart.\r\r", false);
	outputText("Kelt's feet move almost uncertainly, hooves pawing at the ground and resetting themselves.  He almost seems confused for a moment, hips bucking forward experimentally.  When there is no further sensation, his confusion begins to be replaced by anger.\r\r", false);
	outputText("He spends a few moments cursing you, swollen cock still sometimes pumping forward as though expecting you to latch on at any moment. The centaur is obviously unused to rejection.  The temptation bites harder than ever as his cruel words shame you.  Wouldn't it be easier to just give in?  To give this powerful male what he wants, so he'll like you again?  The cock hovers teasingly within reach, just waiting to give you a glorious taste... but you fight the alien urge, and keep your mouth shut.\r\r", false);
	outputText("You have just a moment to react, as the tone suddenly shifts.  Kelt, who has been stomping and cussing angrily, has decided on a new target.  Training remembered, you roll to the side just as Kelt rears and brings his front two hooves down where your head was moments earlier.\r\r", false);
	outputText("Kelt moves towards you, eyes blazing, and you drop into a crouched stance automatically.  Even so, you are overwhelmed by another blow to the face as Kelt furiously lashes out at you.  You scramble to defend yourself, but the attack, such as it was, is over as soon as it began.  The abusive centaur is already moving away, frustration clear with every step.\r\r", false);
	outputText("\"<i>Stupid slut.  Refuse me, huh?  ME?  Well FUCK you and the [legs] you walked in on!  You wanna shoot arrows, go learn how to do it yourself!  Better idea... go to the fucking desert, find a demon, and fucking BEG him to make you his ass slave.  Go on!  Fuck off, slut!</i>\"\r\r", false);
	outputText("His words hurt more than you thought, and you turn around, fleeing.  Kelt continues to curse violently at you as you run, but does not follow.  Your head is swimming, confused.  Did you really want to submit to a monster like him?  What did he do to you?  One way or another, it is clear that you are not welcome here anymore.  The thought fills you with that same, strange need, as well as a desire to literally crawl back, and take that glorious cock worshipfully into your mouth, like a good slave.\r\r", false);
	outputText("But the feeling is weaker now.  Whatever is was that kept you bound to him seems to be fading now, albeit slowly.  A shiver of desire runs through you, even so.  It may be a long recovery.\r\r", false);
	//(Kelt never encountered again)
	player.createStatusEffect(StatusEffects.KeltOff,0,0,0,0);
	doNext(camp.returnToCampUseOneHour);
}

//Blowjob Requirement, Shamefully
private function keltBlowjobRequirementShamefully(newl:Boolean = true):void {
	spriteSelect(35);
	if (newl) clearOutput();
	player.slimeFeed();
	outputText(images.showImage("kelt-farm-shamefulbj"));
	outputText("The thought of going through with it is appalling.  The thought of not wrapping your lips around that glorious member is equally unthinkable.\r\r", false);
	outputText("Face flushed with lust and shame, you reach up hesitently to wrap your hand around the growing member, feeling its wondrous heat.  Kelt lets out a satisfied groan, his hips bucking forward involuntarily.  The flared head of his massive cock drools precum lewdly, and you hesitate once more, torn.  But with the warmth of his cock beneath your hand, there is no going back.\r\r", false);
	outputText("Leaning forward, you lap meekly at the head, tasting his precum on the tip of your tongue.  The salty, gooey ooze sets your senses on fire with need... have you ever tasted something so wonderful?  A second taste begets a third, and a fourth, and soon enough, you have stretched your lips wide to suck in that swollen head, intent on slurping every little drop you can.\r\r", false);
	outputText("The head of the massive cock barely fits between your lips, but the creaking of your jaws is worth it as your mouth is filled with the taste of Kelt's seed.  You nurse at it, almost hungrily, and wince as you feel a splurt of it plaster your throat.  The crude thought of what you are doing is painful, but you cannot help taking pleasure in the hot taste of centaur cum.  It is like a reward for giving up every ounce of pride you had.\r\r", false);
	outputText("Kelt does not give you long to mourn your loss.  One of his hooves paws restlessly at the ground, animalistic, as he pushes his hips forward once again.  You gag slightly as the flared head rams into the back of your throat insistently.  Hoping to give some relief to your impatient abuser, you begin masturbating the length of his cock with your hands, even while suckling on the tip.  His underside shivers a little with pleasure, and you feel a shaming little burst of pleasure for pleasing him.\r\r", false);
	outputText("\"<i>Mmm...I knew it from the moment I saw you.  Quite the talented little cocksucker you are.  Deeper, bitch.  I want you to choke on my spunk.</i>\"\r\r", false);
	outputText("You try your best to ignore the cruel words, even as some part of you quivers with pleasure.  Degrading and insulting as this is,  the thought of pleasuring this powerful creature fills you with a strange sort of happiness.  You open wider, leaning forward and trying to suck in more glorious cock.  Your teacher obliges you with a thrust of the hips, and his head pushes crudely into the recesses of your throat.  You gag for air, wincing as your throat is spread wide, but Kelt lets out a groan of satisfaction, pumping his hips steadily in an attempt to bury more of his member down your gullet.\r\r", false);
	outputText("\"<i>Ahhh, yeah... fuck, bitch, you sure feel pretty good.  I could get used to this.  How about you, huh?  You like the taste of my cock, little whore?</i>\"\r\r", false);
	outputText("It hurts to admit it, but you do.  It tastes wonderful, and every so often, a hot little splurt of precum slides down your throat.  His heavy testicles, each easily the size of a cantelope, sway back and forth enticingly below him, right before your eyes.  You imagine how full those nuts must be, building up jet after jet of spunk just for you; ready to explode and seed your belly full of his cum.  Your last resistance crumbles, and you redouble your efforts, desperate to bring relief to your great master.\r\r", false);
	outputText("Your diligence is soon rewarded.  With a grunt of need, Kelt shoves forward one last time, burying almost half of his nearly three-foot length deep inside your throat as his cock tenses, then explodes.  You are paralyzed, split open by the massive cock as it begins unloading thick blasts of salty cream deep straight into your stomach.  Your throat is spread so tightly you can feel every splurt pulse down the length of his erection, again and again, ceaselessly.  Your stomach is bloated moments later, but still his orgasm continues, your belly visibly bulging periodically as another stream of seed is planted deep inside you.\r\r", false);
	outputText("By the time he finishes, the last few spurts are almost painful to your poor distended stomach, stretching visibly outwards from your clothes.  As the centaur's cock softens, it slides out of your abused throat easily, a slimy trail of goo coating the member.  Released, you collapse to your knees, coughing as the massive load begins settling in your stomach.  The only taste in your mouth is the musky scent of Kelt's cock, and the salty cum that trailed after it.", false);
	player.refillHunger(50);
	outputText("\r\rKelt moves aside, looking down at you with a smug look of satisfaction.  You weakly wave him off, embarrassed by what you just did, and he laughs nastily.\r\r", false);
	outputText("\"<i>Get used to it, bitch.  Gotta say, you took that pretty well.  Barely a drop lost.  Good.  Because if you tried to spit up my cum, I'd have to make sure to deposit a second load.</i>\"\r\r", false);
	outputText("\"<i>Here's the rule.  You want archery lessons?  Fine.  I'll keep teaching you, stupid bitch that you are.  But when I say so, you kneel and take your turn.  If I have to teach an ugly slut like you, the least you can do is choke one down.  Lesson's over.  See you tomorrow, bitch.</i>\"\r\r", false);
	outputText("He leaves, obviously quite pleased with himself, as you lie, exhausted, in a small pool of his cum.  The smell of it clings to you, even after you push yourself upright and begin hobbling back to camp, arms clutched around your swollen stomach.  Part of you is humiliated, and never wants to see Kelt again.  The other part?  Well, the other part is anxiously hoping that he'll be feeling horny enough again next time to give you another chance to suck his cock.\r\r", false);
	outputText("It may be unhealthy, to keep going back to him.  Of course, you could always say no, right?  He is a good teacher.  And... and would it be so bad to suck him off a few more times?  That wouldn't be so bad... would it?\r\r", false);
	//(Blowjob Off, but activated.)
	//(+7 Submissiveness)
	player.addStatusValue(StatusEffects.Kelt,2,7);
	doNext(camp.returnToCampUseOneHour);
}

//Blowjob Requirement, Eagerly
private function keltBlowjobRequirementEagerly(newl:Boolean = true):void {
	spriteSelect(35);
	// This is never called with arguments, so newl will always be true. Can this be simplified?
	if (newl) clearOutput();
	player.slimeFeed();
	outputText(images.showImage("kelt-farm-eagerbj"));
	outputText("It is like someone answered your prayers.  You eagerly agree, babbling your thanks to Kelt as you are faced with the massive cock, growing harder and harder.  He snorts scornfully.\r\r", false);
	outputText("\"<i>I didn't ask for your thanks, slut,</i>\" he says cruelly.  \"<i>I asked for you to suck my cock.  Now open wide and choke it down, or I'm aiming for your ass.</i>\"\r\r", false);
	outputText("That thought sends another quiver of pleasure through you, but you leap to obey Kelt's orders, even so.  Maybe if you do a good enough job, he'll fuck your ass too...?  Face flushed with excitement, you reach up to wrap your hand around the growing member, feeling its wondrous heat.  Kelt lets out a satisfied groan, his hips bucking forward involuntarily.  The flared head of his massive cock drools precum lewdly, and you immediately lean forward, lapping hungrily.  No sense in letting even a single drop go to waste!\r\r", false);
	outputText("The salty, gooey ooze sets your senses on fire with need... have you ever tasted something so wonderful?  A second taste begets a third, and a fourth, and soon enough, you have stretched your lips wide to suck in that swollen head, intent on slurping every little drop you can.  The head of the massive cock barely fits between your lips, but the creaking of your jaws is worth it as your mouth is filled with the taste of Kelt's seed.\r\r", false);
	outputText("You nurse at it, almost hungrily, and almost melt with pleasure as you feel a splurt of it plaster your throat.  It feels so right, to be here for Kelt's use.  That he would choose you to unload his heavenly cum upon... it is all you could ever want out of life.  If you spent the rest of your days swallowing his spare spunk, you could be happy.\r\r", false);
	outputText("Kelt does not give you long to savor your fulfillment.  One of his hooves paws restlessly at the ground, animalistic, as he pushes his hips forward once again.  You gag slightly as the flared head rams into the back of your throat insistently.  Understanding that his needs must come first, you begin masturbating the length of his cock with your hands, even while trying to slurp more of it into your mouth.  His underside shivers a little with pleasure, and you feel a little burst of pride... he's enjoying it!\r\r", false);
	outputText("\"<i>Mmm... I knew it from the moment I saw you.  Quite the talented little cocksucker you are.  Deeper, bitch.  I want you to choke on my spunk.</i>\"\r\r", false);
	outputText("His insulting words cause a feeling of deep-seated happiness to well up inside you.  How could you have known, before?  You thought yourself a hero, a Champion... but this is what feels right.  A slutty, cocksucking whore... that's what you were meant to be!  You open wider, leaning forward and trying to suck in more glorious cock.  Your master obliges you with a thrust of the hips, and his head pushes crudely into the recesses of your throat.  You gag for air, wincing as your throat is spread wide, but Kelt lets out a groan of satisfaction, pumping his hips steadily in an attempt to bury more of his member down your gullet.\r\r", false);
	outputText("\"<i>Ahhh, yeah... fuck, bitch, you sure feel pretty good.  I could get used to this.  How about you, huh?  You like the taste of my cock, little whore?</i>\"\r\r", false);
	outputText("You barely hear the words, so enflamed are your senses.  His cock tastes wonderful, and every so often, a hot little splurt of precum slides down your throat.  His heavy testicles, each easily the size of a cantelope, sway back and forth enticingly below him, right before your eyes.  You imagine how full those nuts must be, building up jet after jet of spunk just for you; ready to explode, to seed your belly full of his cum.  Your last bit of self worth crumbles, and you redouble your efforts, desperate to bring relief to your great master; desperate to be fucked, at any cost.\r\r", false);
	outputText("Your dilligence is soon rewarded.  With a grunt of need, Kelt shoves forward one last time, burying almost half of his nearly three-foot length deep inside your throat as his cock tenses, then explodes.  You are paralyzed with ecstasy, split open by the massive cock as it begins unloading thick blasts of salty cream deep into your stomach.  Your throat is spread so tightly you can feel every splurt pulse down the length of his erection, again and again, ceaselessly.  Your stomach is bloated moments later, but still his orgasm continues, your belly visibly bulging periodically as another stream of seed is planted deep inside you.", false);
	player.refillHunger(50);
	outputText("\r\rBy the time he finishes, the last few splurts are almost painful to your poor distended stomach, stretching visibly outwards from your clothes.  As the centaur's cock softens, it begins sliding out of your abused throat easily, a slimy trail of goo coating the member.  Wanting more despite your swollen stomach, you desperately suckle on the length of it, trying to get every drop you can.  The only taste in your mouth is the musky scent of Kelt's cock, and the salty cum that trailed after it.\r\r", false);
	outputText("In time, Kelt moves aside, and you release his cock in accordance with his unspoken wishes, feeling lousy.  If only you had been a little faster, sexier... maybe he would have become erect again, and given you more!  Even so, he looks down at you with a smug look of satisfaction that fills you with contentment.  Weakly, moving around your bloated stomach gingerly, you raise your ass into the air, looking back at him hopefully.  Kelt laughs out loud, cruel and spiteful.\r\r", false);
	outputText("\"<i>Still horny, bitch?  Hah!  I knew you were a slut, but who would have guessed you would be this needy?  Sit down, you stupid bitch.  I'll fuck you when I say so, not when you ask.  But this wasn't too bad.  For being such an ugly whore, at least you make a good cumdump.  So if you want more lessons, here's the rule.  Before you fire a single shot, you swallow a load of my cum.  If I have to work with a total slut, I may as well see your belly full of my spunk.  Got it, slag?  Next time you wanna shoot, get down on your knees first, and open wide.</i>\"\r\r", false);
	outputText("He leaves, obviously quite pleased with himself, and your legs give out from under you, weak from your experience.  Even so, you frantically masturbate, knowing true bliss as you lie within a small pool of his spunk.  The smell of it clings to you, even after you push yourself upright and begin hobbling back to camp, arms clutched around your swollen stomach.  This is what happiness feels like... used and full of sperm.\r\r", false);
	outputText("Still, part of you feels unsteady about this whole thing.  Are you becoming a little too dependent on Kelt?  It may be unhealthy to keep going back to him.  And there are others out there, right?  But... but you can't get the centaur out of your head.  It feels right to kneel at his feet; to be his slutty little cumdump.  It is becoming hard to remember why you came here in the first place...\r\r", false);
	//(Blowjob On.)
	player.createStatusEffect(StatusEffects.BlowjobOn,0,0,0,0);
	//(+15 Submissiveness)
	player.addStatusValue(StatusEffects.Kelt,2,15);
	doNext(camp.returnToCampUseOneHour);
}

//Normal Encounter
private function keltMainEncounter():void {
	spriteSelect(35);
	outputText("Once more, you encounter Kelt the centaur at Whitney's farm.  He smirks at you, and asks if the fool has come once more to learn from the master.\r\r", false);
	//(Submissive 0-30: 
	if (player.statusEffectv2(StatusEffects.Kelt) <= 30) outputText("You grind your teeth in irritation, but swallow your pride enough to ask him for help.  ", false);
	//(Submissive 30-70:
	else if (player.statusEffectv2(StatusEffects.Kelt) <= 70) outputText("You nod reluctantly, and Kelt grins.  He may be arrogant, but he is rather good.  ", false);
	//(Submissive 70-100: 
	else outputText("You nod enthusiastically, almost begging him to teach you.  ", false);

	//(Before Naked Requirement)
	if (player.statusEffectv3(StatusEffects.Kelt) <= 3) {
		outputText("Kelt seems to find the idea of training a human almost comical, but suggests that if you want to follow him around for a while, he has no problem with it.  Though his attitude is annoying, you resolve to learn what you can.\r\r", false);
	}
	//Stuff that happes after naked requirement
	else {
		keltMainEncounterAfterNakedReq();
		return;
	}
	//Continue encounter stuff
	keltMainEncounter2();
}
	
private function keltMainEncounterAfterNakedReq():void {
	//After naked requirement
	//(Naked On)
	if (player.findStatusEffect(StatusEffects.NakedOn) >= 0) {
		outputText("He nods, smirking slightly, and gestures at your clothes impatiently.  With some pleasure, you strip down before him, discarding your clothes with a little flair.  Kelt is grinning by the end, openly admiring your body, and you feel a little more aroused for obeying his dominant command.\r\r", false);
		//(+5 Submissive)
		player.addStatusValue(StatusEffects.Kelt,2,3);
	}
	//(Naked Off)
	else {
		//(40% Chance:
		if (rand(10) <= 5) {
			outputText("Kelt looks down your body scornfully, and claims he is unwilling to teach you unless you are willing to learn naked again.  ", false);
			//(Corruption 60+, or Submissive 60+: 
			if ((player.cor + player.lib + player.lust >= 180 && player.inte < 30) || player.statusEffectv2(StatusEffects.Kelt) >= 60) {
				outputText("This time, the idea turns you on a little, and you agree automatically, stripping naked before Kelt with enthusiasm.  He obviously enjoys the show, and you are incredibly aroused by his attention.  Part of you reasons that if training naked is better, maybe you should just strip down right away, each time?  The thought is more than a little stimulating.", false);
				if ((player.cor + player.lib + player.lust >= 220 && player.inte < 40) || player.statusEffectv2(StatusEffects.Kelt) >= 70) {
					outputText("  <b>With a lusty smile, you decide to ALWAYS get naked before practicing.</b>", false);
					player.createStatusEffect(StatusEffects.NakedOn,0,0,0,0);
				}
				outputText("\r\r", false);
				//[+5 Submissive])
				player.addStatusValue(StatusEffects.Kelt,2,7);
			}
			//(Otherwise:
			else {
				outputText("\r\rYou're not certain you want to practice naked again... particularly with the way Kelt is looking at you, his arrogant smirk plastered on his face.  Do you agree to his terms?", false);
				//(Yes[+5 Submissive]			No[Never event])
				//Link this to reluctant && never
				simpleChoices("Yes", keltReluctantlyGetNaked, "No", keltRefuseNakedness, "", null, "", null, "FIGHT!", kelly.fightToBeatKelt);
				if (player.inte > 40 && player.cor > 70 - player.corruptionTolerance() && !player.isTaur()) {
					outputText("\n\n<b>If you fight back and take him down a peg, you might never see him again...</b>");
					addButton(2, "Fight Back",keltResistance);
				}
				return;
			}
		}
		//(Otherwise: 
		else {
			outputText("Kelt looks at your clothes sourly once more, and mocks you for what he calls 'human sensitivity'.  He does not, however, directly tell you to take them off.\r\r", false);
			//(Corruption 60+, or Submissive 60+:
			if ((player.cor + player.lib + player.lust >= 180 && player.inte < 40)|| player.statusEffectv2(StatusEffects.Kelt) >= 60) {
				outputText("This time, though, the idea turns you on a little.  You ask Kelt if he would prefer to see you naked, and begin stripping down in front of him.  He seems surprised but obviously enjoys the show, and you are incredibly aroused by his attention.  Part of you reasons that if training naked is better, maybe you should just strip down right away, each time?  The thought is more than a little stimulating.", false);
				if ((player.cor + player.lib + player.lust >= 220 && player.inte < 40) || player.statusEffectv2(StatusEffects.Kelt) >= 75) {
					outputText("  <b>You cast a seductive smile Kelt's way and decide you should always strip before practice</b>.", false);
					player.createStatusEffect(StatusEffects.NakedOn,0,0,0,0);
				}
				outputText("\r\r", false);
				dynStats("lus", int(player.lib/10) +5);
			}
			//(Otherwise: 
			else outputText("You ignore his barbed comments as best as you can, and soon enough, he leaves the matter alone, instead critiquing your archery skills.\r\r", false);
		}
	}
	keltMainEncounter2();
}

//Normal Encounter 2
private function keltMainEncounter2():void {
	//Used for randomization
	var temporary:Number = 0;
	//(No bow equipped)
	if (player.hasKeyItem("Bow") < 0) {
		outputText("\"<i>Here,</i>\" Kelt says, tossing you a spare bow.  \"<i>You can use this, for right now.  We train colts on it... you know, before their balls drop.  Should be just about right for your level.  Keep it if you want.</i>\"\r\r", false);
		outputText("Despite his mocking description, the bow he gives you really is a decent weapon.  You take it up and start towards the practice field, Kelt following behind.\r\r", false);
		if (player.hasKeyItem("Bow") < 0) player.createKeyItem("Bow",0,0,0,0);
	}
	//(Bow equipped)
	else {
		outputText("Kelt sneers as he looks at your bow, \"<i>You're still using that rotten old thing?  Well, it will do.  We'll just have to shoot for the close targets.</i>\"\r\r", false);
		outputText("Together, the two of you head off to the practice field.\r\r", false);
	}
	//IF BLOWJOB HAS HAPPENED ALREADY, chances to repeat
	if (player.statusEffectv2(StatusEffects.Kelt) >= 60 && rand(4) == 0 && player.findStatusEffect(StatusEffects.KeltBJ) >= 0) {
		keltMainEncounterPostBlowjob();
		return;
	}
	keltMainEncounter3();
}

private function keltMainEncounter3():void {
	var temporary:Number = 0;
	//(Clothed)
	if (player.findStatusEffect(StatusEffects.NakedOn) < 0) {
		outputText("Kelt is arrogant, crude, and all too often cruel as he mocks your attempts at archery again and again.  Despite all this, however, he obviously does know what he's doing.  You try to ignore his insults and lewd comments as best as you can and focus on the archery.  In the end, you feel you've learned a lot, though Kelt remains snide.\r\r", false);
		temp = rand(4);
		//(25% Chance: 
		if (temp == 0) outputText("\"<i>Oh, yes.  Looks like you're shaping up to be a pretty accurate archer.  Just make sure you only fight blind giants.  You know, massive targets that have no chance to dodge.  You'll do fine.</i>\"\r\r", false);
		//(25% Chance: 
		if (temp == 1) outputText("\"<i>Ha!  You want to become an archer?  Here's a hint... stop thinking about sucking cock for two seconds and AIM.</i>\"\r\r", false);
		//(25% Chance: 
		if (temp == 2) outputText("\"<i>See the red dot, in the middle of the target?  Imagine that's your ass, and the arrow is a big, fat, minotaur cock.  That should help you hit the target.</i>\"\r\r", false);
		//(25% Chance: 
		if (temp == 3) {
			if (player.race() != "centaur") outputText("\"<i>If you were a centaur, I'd recommend suicide.  Since you're a " + player.race() + ", I'd say your best option is to fuck off.</i>\"\r\r", false);
			else outputText("\"<i>As a centaur, I'd recommend suicide.  Really, it's that or man the fuck up.</i>\"\r\r", false);
		}
		//player.addStatusValue(StatusEffects.Kelt,1,5+rand(4));
		if (player.statusEffectv1(StatusEffects.Kelt) < 90) bowSkill(5+rand(4));
		else bowSkill(1);
	}
	//NAKERS
	else {
		//(Naked, Player in Heat:)
		if (player.inHeat && player.gender > 1) {
			outputText(images.showImage("kelt-farm-female-inheat"));
			outputText("You line up as normal to begin practicing, shooting at the distant targets while Kelt criticizes your technique... usually in as loud, lewd, and offensive a way as possible.  Today, however, he seems particularly energetic.  He looms over you, distractingly close, his hooves stomping at the ground like an anxious horse.  His insults are as harsh as ever... perhaps even more cruel than usual as he mocks your attempts to hit the targets.\r\r", false);
			outputText("One shot goes wide, and Kelt furiously demands that you go to retrieve the arrow, lodged in a nearby bale of hay.  You do so quickly, snapping to obey his orders with a little shiver of pleasure.  Somehow, it feels right to obey his every wish; to do what you can to satisfy him.  His scent has been distracting you... the rich, masculine power of him.  How had you never noticed before what a spectacular creature Kelt was?\r\r", false);
			outputText("You lean over to pluck the arrow from the haystack, and feel a sharp blow to the back of your head, knocking you over and sending your consciousness spinning.  Dizzily, you realize Kelt is standing over you, tossing aside the bow he just used to crack you in the head.  Between his horse legs, a massive manhood is dropping from his sheath, flanked by testes the size of softballs.  A lewd grin is on his face.\r\r", false);
			outputText("\"<i>Did you think I wouldn't notice, slut?  You reek like a mare in heat.  I could smell it on you the moment you arrived.  Fortunately, I know just what to do with a fertile bitch.  Let's put a baby centaur in that tight pussy of yours.</i>\"\r\r", false);
			outputText("Kelt's forelegs rear up just enough to plant them around your shoulders, his massive weight bearing down on you.  The bale of hay lifts you just high enough to line up with his fat erection, which presses between your asscheeks even now.\r\r", false);
			//(Submissive, 0-30: 
			if (player.statusEffectv2(StatusEffects.Kelt) <= 30) outputText("You struggle as best as you can, but Kelt weighs a good deal more than you do.  As his thrusting hips anxiously press his cock to your nether-lips, you realize this is going to happen, whether you want it to or not.  The thought fills you with an undeniable shiver of pleasure.\r\r", false);
			//(Submissive, 30-70: 
			else if (player.statusEffectv2(StatusEffects.Kelt) <= 70) outputText("You put forth a token effort to escape, but it is obvious from the beginning that there is no way to get out from under the heavy weight of the centaur.  Besides, the desire running through you is palpable... in a way, you want this to happen.  So much so that as Kelt is thrusting, trying to line up his cock, you raise your hips to help him out, silently longing for penetration.\r\r", false);
			//(Submissive, 70-100: 
			else outputText("The masculine scent of him is overpowering, desperate.  Your body wants nothing more than to submit to Kelt's ferocious desires, and your mind agrees.  Eagerly, you thrust your hips up, reaching back with one hand to guide his cock to your wet pussy.  Kelt snorts his approval, and you feel a shivering tremor of lust run through you.\r\r", false);
		
			outputText("The centaur's cock has truly equine proportions, being easily two and a half feet long and over three inches thick.  ", false);
			//(Vagina, Small: 
			if (player.vaginalCapacity() <= 16) outputText("The fit seems impossible, but Kelt could care less about your comfort, and shoves the flared head into you without hesitation.  You let out a scream, feeling like you are being torn apart by his cock as it rudely presses against your insides, spreading you wide open.  Kelt thrusts with growing frustration, but can fit no more than half his cock inside of you, despite his best efforts.  Every twitch makes you cry out as your tight pussy squeezes and milks that massive organ.\r\r", false);
			//(Vagina, Medium: 
			else if (player.vaginalCapacity() <= 40) outputText("Even for you, Kelt's cock seems oversized as he presses the flared head of his massive manhood against your netherlips.  Even so, he does not hesitate, lunging forward and spearing you on his manhood without hesitation.  You let out a groan as that massive organ spreads you wide open, straining your bounderies and almost certainly stretching you out even further.  The centaur's thrusts are relentless, but even at his best, he can only fit in about three fourths of his cock.  He snorts, frustrated... but you are so filled that your head is spinning with pleasure.\r\r", false);
			//(Vagina, Large: 
			else outputText("It seems like a perfect fit for your gaping, hungry pussy as Kelt rams the flared head deep into you.  You feel that glorious manhood filling you like few cocks can these days, spreading you wide and searching out your depths.  Kelt lets out a pleased laugh when he bottoms out with you just barely able to accommodate his size.  His heavy balls slap pleasantly against your ass as you groan with pleasure, filled to the core with cock.", false);
			player.cuntChange(50,true,true,false);
			outputText("\n\n");
			outputText("From then on, the ride only becomes rougher.  Kelt begins pumping his hips steadily, deep and hard, intent on burying as much of his manhood as possible with each thrust.  He gives little thought to your pleasure, but it hardly matters.  With a cock that size, you cannot help but moan with each buck of his hips.\r\r", false);
			outputText("\"<i>Not too bad, not too bad!  You make for a pretty decent fuck!  Maybe after you bear a couple of my foals, I'll add you to my harem.  You'd like that, wouldn't you?  You just can't wait to get a bellyful of centaurs, can you?</i>\"\r\r", false);
			//(Submissive, 0-30: 
			if (player.statusEffectv2(StatusEffects.Kelt) <= 30) outputText("You shiver and groan, unable to help yourself.  It is clear that Kelt has every intention of breeding you, and you are helpless to stop the urges of your body.  Terrifying images of being raped daily by this cruel beast fill your head... of your belly swelling with his young again and again.  You let out a moaning cry, and orgasm helplessly even as Kelt laughs.\r\r", false);
			//(Submissive, 30-70: 
			else if (player.statusEffectv2(StatusEffects.Kelt) <= 70) outputText("The thought of that fills you with a dreadful shiver of lust, from your head to your toes.  Your body longs to be bred, again and again, and the idea of submitting to this powerful creature is so powerfully erotic that you cum on the spot, orgasming with delightful abandon.  The thought of being this centaur's breeding slave feels so right!\r\r", false);
			//(Submissive, 70-100: 
			else outputText("You whimper in the afirmative helplessly, shivering with delight.  You have a feeling deep inside you that this powerful creature, this paragon of manhood, is your master, and you but his breeding slave.  Your pussy squeezes and milks his member, trying to urge out that explosion of cum that will make you his forever.  The knowledge that your great master will impregnate you soon, filling you with his seed, sends you over the edge into a mind-wracking orgasm.\r\r", false);
			outputText("\"<i>Alright, slut... here comes your baby!</i>\"\r\r", false);
			outputText("You feel a bloom of warmth as the centaur's cock bursts within you, pumping thick semen straight into your womb.  The quantity is unbelievable, and you orgasm again just from the sensation of his steaming spunk filling your belly.  Each little twitch of his cock sends sprays of seed and juices squelching from your overstuffed pussy, the majority of it being trapped inside.  Your stomach begins to swell slightly from the sheer quantity, and you all but dissolve into a puddle of satiated goo.\r\r", false);
			outputText("Some time later, Kelt's enormous cock softens enough to slip out of your abused cunt, a virtual torrent of cum flowing out afterwards.  You lay on the bale of hay, panting tiredly, hands pressed to your full belly.  Kelt looks down at you, and snorts.\r\r", false);
			outputText("\"<i>That's a good look for you.  Come back tomorrow if it doesn't take, slut.  I'll be glad to do the job again.</i>\"\r\r", false);
			player.slimeFeed();
			player.orgasm();
			outputText("He leaves you without another word.", false);
			//(+5 Submissive)
			player.addStatusValue(StatusEffects.Kelt,2,5);
			//(Pregnancy Chance)
			player.knockUp(PregnancyStore.PREGNANCY_KELT, PregnancyStore.INCUBATION_CENTAUR, 50);
				//Should be equivalent to the old way, but now Kelt does all the usual things like checking for contraceptives and fertilizing eggs if PC can oviposit
			if (player.pregnancyType == PregnancyStore.PREGNANCY_KELT) trace("PLAYER GOT KNOCKED UP BY KELT");
			doNext(camp.returnToCampUseOneHour);
			return;
		}
		temporary = rand(5);
		//(Naked, 60% Chance)
		if (temporary <= 2) {
			outputText("The lesson proceeds as normal, with you taking shots while Kelt arrogantly critiques your style, tossing out colorful and creative insults whenever possible.  He has no shame about mocking your body as much as he laughs at your archery, and makes several crude comments about what it might be good for.", false);
			//(Submissive, 0-30:
			if (player.statusEffectv2(StatusEffects.Kelt) <= 30) outputText("You try to ignore the foul remarks, telling yourself that this is simply the way he is.  It does not help, though, that at times you feel Kelt's eyes wandering across you lustfully.  At least some of his comments are not mockeries, but suggestions.  The entire experience makes you feel a little more uncomfortable around the abusive centaur.", false);
			//(Submissive, 30-70: 
			else if (player.statusEffectv2(StatusEffects.Kelt) <= 70) outputText("Despite yourself, some of his cruder comments make you blush.  By now, you're getting used to the oft times depraved sexuality of the demon world... but it is a little humiliating to subject yourself to this kind of treatment... and, to your shame, sometimes it's a little arousing.  Though Kelt is insulting, cruel, and crude, you also notice real lust in some of his glances.  By the end of the lesson, you are flushed with arousal as well as exertion.", false);
			//(Submissive, 70-100:
			else outputText("Of course, Kelt's words only distract you even more from hitting the target.  Not because you are angry... but because you are aroused.  Somehow, his lewd comments and crude jibes make you shiver with anticipation.  He's just so powerful, so masculine.  Kelt seems well aware of the effect he has on you, and once reaches out to slap your ass heartily.  By the end of the training, you feel intensely horny.", false);
			dynStats("lus", 10);
			//player.addStatusValue(StatusEffects.Kelt,1,4);
			if (player.statusEffectv1(StatusEffects.Kelt) < 90) bowSkill(4);
			else bowSkill(1);
			doNext(camp.returnToCampUseOneHour);
			return;
		}
		//(No Breasts—Do standard Naked event)
		if (player.biggestTitSize() == 0 && temporary == 3) temporary = 4;
		//(Naked, 20% Chance)
		if (temporary == 3) {
			outputText("The practice begins as normal, but something is a little different today.  To your surprise, Kelt's regular insults and comments seem to be a little less harsh and a little more bemused.  Although he still insults your achievements and mocks your failures, he almost seems entertained by your efforts.  His apparent good mood is not necessarily better... without his usual fiery insults, you are a little unsure of how your progress is going.  One shot goes long, and to your surprise, Kelt doesn't yell at you.  Instead, he laughs heartily.  Flushed and a little embarrased, you ask what you did wrong.\r\r", false);
			outputText("\"<i>Isn't it obvious?</i>\" he asks, grinning down at you in sardonic amusment. \"<i>You were way off balance.  Of course, I would be too, if I had a couple of extra pounds of fat hanging off my chest.</i>\"\r\r", false);
			outputText("Indignantly, you cover your breasts with your hands, telling him to be serious.  He laughs again, more cruelly this time.\r\r", false);
			outputText("\"<i>I am being serious.  Women aren't warriors.  And those with tits do not become warriors.  I just think it's funny. You, begging me to teach you, while you have those udders hanging off your chest!</i>\"\r\r", false);
			outputText("To your surprise, he suddenly leans forward, fist moving towards your head.  You raise your arms to deflect the blow, but he changes tactics suddenly and grabs one of your " + player.breastDescript(0) + " instead.  You stiffen, but before you can react further, he squeezes them brutally, mauling your breasts roughly with his hands.\r\r", false);
			//(Small Size, A-DD: 
			if (player.biggestTitSize() <= 5) outputText("\"<i>Ha!  Even with your itty-bitty-titty, you have to admit to a certain... weakness, is it?  Awfully sensitive, aren't they?  Ooh, am I making the little girl wet?  Naughty slut!</i>\"\r\r", false);
			//(Medium Size, E-HHH:
			else if (player.biggestTitSize() <= 11) outputText("\"<i>Just look at these mommy melons!  You want to be an archer?  I'm amazed you don't slap yourself in the tits with every shot!  Easy target to grab onto.  But hey, I bet you like it that way.  Like it when people grope these fat titties of yours?</i>\"\r\r", false);
			//(Big Size, Watermelon and beyond:
			else outputText("\"<i>Look at you! You're a miracle of science, you are... any other creature would break their back, trying to haul these milk bags around!  Tell the truth, now... which one of your parents was actually a cow?</i>\"\r\r", false);
			outputText("Despite his cruel words, you can't help but groan a little bit as he brutalizes your sensitive chest.  Kelt seems to take a good deal of pleasure in how helpless you are, pinching and flicking your " + player.nippleDescript(0) + "s.\r\r", false);
			//(Milk)
			if (player.biggestLactation() > 1) {
				outputText("Inevitably, beads of milk appear on the tips of your breasts, and Kelt lets out a hoot of laughter.\r\r", false);
				outputText("\"<i>Oh, boy!  Mommy here brought snacks for everyone!  Don't mind if I do!</i>\"\r\r", false);
				outputText("Without hesitation, he lowers his lips to your engorged breast, suckling on the nipple.  He is immediately rewarded with a jet of milk, and you whimper slightly with pleasure as the centaur begins aggressively suckling your tit.  He drinks down your sweet, warm cream hungrily, and you are so enthralled with the sensations of release that you are powerless to stop him as he takes his fill of you.  The other hand continues to crudely grope your unattended teat, and despite yourself, you can feel your arousal building.  At last, Kelt releases you, wiping his mouth with an arrogant grin.\r\r", false);
				outputText("\"<i>Not bad, for a cow.  You certainly seemed to enjoy it too.</i>\"\r\r", false);
				outputText("Even released, your teat continues to drizzle slightly, spilling your milk shamefully on the ground as Kelt continues to squeeze your breasts.\r\r", false);
				//You've now been milked, reset the timer for that
				player.addStatusValue(StatusEffects.Feeder,1,1);
				player.changeStatusValue(StatusEffects.Feeder,2,0);
			}
			outputText("\"<i>Take it from me, bitch.  Know your place.  Breasts are for women, and women are for fucking until their bellies are full of foals.  'Teach me archery, Kelt!'  Ha!  Now that's a joke.</i>\"\r\r", false);
			outputText("Flicking your erect teats painfully one last time, Kelt walks away, laughing loudly to himself.", false);
			doNext(camp.returnToCampUseOneHour);
			//(+5 Submissive)
			player.addStatusValue(StatusEffects.Kelt,2,5);
			//player.addStatusValue(StatusEffects.Kelt,1,4);
			if (player.statusEffectv1(StatusEffects.Kelt) < 90) bowSkill(4);
			else bowSkill(1);
			return;
		}
		//(Naked, 20% Chance)
		if (temporary == 4)
		{
			outputText("Nothing you do today seems to please your tutor, however.  He roars at you for every mistake, explodes at every misfire, and merely sneers contemptuously at every actual hit.  While his contempt for your efforts is nothing new, he seems particularly agitated today.  His aggressive behavior begins to distract you, and finally, you make a huge mistake.  Your shot goes flying, nowhere near the target, and Kelt is suddenly right behind you.\r\r", false);
			outputText("\"<i>You stupid slut!</i>\" he roars out, backhanding you with casual contempt.  You stumble to the ground, dazed but uninjured, as he rants.  \"<i>Hit the FUCKING target!  It's not hard, you dirty whore!  Maybe if you weren't so focused on FUCKING DICK you'd be able to get a single shot in!  Stand up... I said stand up, fucker!</i>\"\r\r", false);
			outputText("Thrown off guard by his aggressive attitude, you hastily stand, and at his command, face the target, trembling slightly. Kelt looms over you from behind, and grabs you roughly by the hair.  Then, with his other hand, he crudely shoves two fingers up your ass.  You let out a cry of shock, but Kelt growls and tightens his grip on your hair.\r\r", false);
			outputText("\"<i>THERE.  Is that what you fucking wanted, whore?  Something nice to fill that ass of yours?  Bet it feels good, huh? Bet you were fucking DREAMING of a nice, fat cock up your ass.  Well, here you go!  Feel better now that you're being fucked, slut?</i>\"\r\r", false);
			outputText("He lifts up with his fingers, painfully raising you off the ground with his great strength.  You squirm, aroused despite yourself by this sudden intrusion, and Kelt growls, lowering you to the ground and releasing your hair.  Moments later, your bow is in your hand... though Kelt has still not removed his fingers.\r\r", false);
			outputText("\"<i>Okay.  Now that our little bitch is getting an assfuck, maybe she'll be satisfied enough to hit the fucking target.  Now shoot... and don't you dare fuck this up again.</i>\"\r\r", false);
			outputText("Groaning, distracted and unnerved, you hurriedly line up the shot as best as you can.  Kelt's fingers flex, forcing you to stand up straighter.  Your arm shakes as you take aim, and you can feel Kelt's hot breath on your hair, and then the arrow is flying!  Ten meters... five... bullseye!\r\r", false);
			outputText("With a snort, Kelt shoves you to the ground, removing his fingers as he does so.  Wincing, you sit up with the centaur staring down at you snidely.\r\r", false);
			outputText("\"<i>Lesson's over for now.  Next time it's my cock, slut.</i>\"\r\r", false);
			outputText("He walks away without another word, taking some of your dignity with him.", false);
			//(+5 Submissive)
			dynStats("lus", 15);
			player.addStatusValue(StatusEffects.Kelt,2,5);
			//player.addStatusValue(StatusEffects.Kelt,1,4);
			if (player.statusEffectv1(StatusEffects.Kelt) < 90) bowSkill(4);
			else bowSkill(1);
			bowSkill(4);
			doNext(camp.returnToCampUseOneHour);
			return;
		}
	}
	doNext(camp.returnToCampUseOneHour);
}

private function keltMainEncounterPostBlowjob():void {
	//(Blowjob Requirement On)
	if (player.findStatusEffect(StatusEffects.BlowjobOn) >= 0) {
		//(Submissiveness 75+, Lust 60+)
		if (player.lust >= 75 || player.statusEffectv2(StatusEffects.Kelt) >= 90 && rand(2) == 0) {
			outputText(images.showImage("kelt-farm-smallbarn"));
			outputText("It is almost too much to wait for your meeting with Kelt today.  His familiar musk enflames your senses, making you ache with need.  You try to wriggle your ass enticingly for Kelt as the two of you walk, eager to start in on the usual blowjob.  Even you don't usually hunger after it this much, but a need for Kelt's cock fills you to the core.  You long for nothing more than to service your mighty stud.\r\r", false);
			outputText("To your surprise, Kelt leads you not towards the practice field, but towards a small barn, near the edge of the field.  When you meekly ask why he's taken you here, his brow clouds and he lashes out, striking you with casual violence.  ", false);
			outputText("\"<i>Bitch!  I said get in there.  Do I need to repeat myself, you stupid whore?\"</i>\r\r", false);
			outputText("Scrambling to your feet and babbling apologies, you hastily open the door to the barn, entering immediately.  Before you is a thin, upraised table, with straps in it, like saddle stirrups.  Your heart leaps excitedly, and Kelt laughs a little to himself as he tells you to get on, facedown.  You hasten to comply.\r\r", false);
			outputText("Lying on the rough table with your feet in the stirrups, your ass is suspended at just the right height.  Kelt moves with obvious hunger, running his finger along your nethers.", false);
			//(Penis:
			if (player.totalCocks() > 0) outputText("  Your " + player.cockDescript(0) + " is rock hard, but he ignores it almost contemptuously.  You almost feel ashamed of it, compared to the slowly-growing manhood between his legs.", false);
			//(Vagina:
			if (player.hasVagina()) outputText("  For a moment, his fingers trace the line of your exposed " + player.vaginaDescript(0) + ", giving you the slightest of warnings before he crudely jams two fingers deep inside, as though scouting out your depths.  You whimper urgently at the treatment, and more so as Kelt removes his fingers, licking with obvious pleasure.", false);
			outputText("\r\r\"<i>Oh?  Like that, do you?  Well, we're not here for what you like.  You're here to satisfy me, slut.  And I know what I'm after.</i>\"\r\r", false);
			outputText("You flinch slightly as his two front hooves land forcefully on either side of your head, as Kelt mounts you from behind.  You can feel his massive cock pressing firmly into your back, drooling a warm little blob of precum between your shoulder blades. For a few, anxious moments, you tremble and bite your lip, waiting for him to line up his shot.  You almost cum on the spot as the flared head of his member presses squarely between your " + player.buttDescript() + ".\r\r", false);
			outputText("Kelt doesn't hesitate.  With an almost primal snarl, he rams his cock forward, anxious to sink himself deep into your ass.  With no lube and no foreplay, you let out a cry as the massive cock splits you open.  Fortunately, it drools precum eagerly into your backside, making the next thrust easier, though no less forceful.  Kelt shows no mercy, trying to fit himself inside your ");
			if (player.tallness < 112) outputText("smaller ");
			outputText("body with no concern for your well being.", false);
			player.buttChange(70,true, true, false);
			outputText("\r\r", false);
			outputText("You can't help it... at the thought of being used as his worthless fucktoy, you suffer a mild orgasm of your own, crying out your submission to this powerful creature.", false);
			//(Penis: 
			if (player.totalCocks() > 0) outputText("  Beneath you, pressed firmly into the harsh wood of the mounting board, your " + player.cockDescript(0) + " erupts, splattering your stomach with your own cum.  As the thick semen slides down towards your face, you begin slipping on your own warm seed, rocking back and forth with each harsh pounding Kelt delivers to your backside.", false);
			//(Vagina:
			if (player.hasVagina()) outputText("  Your poor, neglected pussy quivers with delight, convulsing without even being touched.  Thick juices run freely down your leg, dripping off to splatter the hay below you as you moan like a bitch in heat.", false);
			//(Genderless: 
			if (player.gender == 0) outputText("  Never before has a complete lack of genitalia been so frustrating... or pleasurable.  Not being able to physically cum, the explosions of climax simply rack up within your body... waves of cascading pleasure with no release and no mercy.", false);
			outputText("\r\rIf anything, your orgasm only seems to spur Kelt on, causing him to push deeper and faster.  The idea of fitting his massive, nearly three-foot cock into your bowels seems ludicrous, but the aggressive centaur obviously has no intention of taking 'no' for an answer.  With each powerful thrust of his hips, he sinks more cock deep within your ass, filling you, stretching you, ripping you open with still more to come.  It is almost a terrible relief when you feel his massive testicles colide with your ass, buried at last to the hilt. Even in victory, Kelt is snide.  ", false);
			if (player.looseness(false) < 3) outputText("\"<i>Fuck!  About time!  Sure got a tight little ass back here, but don't worry, slut.  We'll stretch it out in no time. I promise you this... you'll be getting a lot more of my cock from now on, so you'd better be ready!</i>\"\r\r", false);
			else if (player.looseness(false) < 5) outputText("\"<i>Fuck!  About time!  Sure got a nice ass back here, but don't worry, slut.  We'll turn it into a real gaper soon.  It's a good thing you've been practicing... you'll be getting a lot more of my cock from now on, so you'd better be ready!</i>\"\n\n");
			else outputText("\"<i>Fuck!  About time!  Sure got a nice, stretched out little pucker back here, but don't worry, slut.  I'll train into to squeeze down just right in no time.  I promise you this... you'll be getting a lot more of my cock from now on, so you'd better be ready!</i>\"\n\n");
			outputText("You lose track of time, moaning and whimpering beneath your master as he ruthlessly takes his pleasure from your distended ass.  Did you cum again?  Almost certainly... but it is hard to focus on that one sensation.  The much greater sensation welling up within you is a sense of rightness.  This is where you belong; this is where you are happy.  As his cock begins to swell within you, preparing to unload his spunk deep inside, your voice rises in a cry of jubilation.  Impaled upon your master's cock, now and forever, being filled with his seed... you could want nothing more.\r\r", false);
			outputText("The torrent of jizz is pumped into you lewdly, Kelt's heavy testicles blasting burst after burst into your bowels, filling your belly with hot centaur cum.  He doesn't relent until well after your ass has been filled to the point of making you sick... at one point you cough up a mouthful of his cum, only to weakly try to swallow it back down.  It is your master's cum... it belongs inside you.\r\r", false);
			outputText("When Kelt pulls out, he leaves behind your ravaged asshole, spread wide and filled with cum.  You whimper as he withdraws, but are unable to move, unable to think.  You dimly hear him laughing at you again, and taste his cum once more as he dips a finger into your gaping asshole and presses it to your lips.\r\r", false);
			outputText("\"<i>Now stay there for a while, bitch.  Let it get good and stuck up there.  Come back tomorrow, and maybe, if you're lucky, I'll fuck you again.  You do, after all, make a pretty good cumdump.</i>\"\r\r", false);
			outputText("It's some hours later before you rouse yourself, clenching your ass as best as you can to keep the tide inside.  Despite your efforts, a steady trail oozes down your leg, marking your path as you slowly, happily trudge back to your camp.", false);
			doNext(camp.returnToCampUseTwoHours);
			player.slimeFeed();
			//(+10 Submissiveness)
			if (player.buttChange(70,true)) outputText("\r\r", false);
			player.addStatusValue(StatusEffects.Kelt,2,10);
			player.orgasm();
			dynStats("cor", 1);
			return;
		}
		//(Otherwise)
		else {
			outputText(images.showImage("kelt-farm-eagerbj"));
			outputText("As you move out to the practice field, you feel Kelt's eyes on you, staring intensely and maybe a little hungrily.  Knowing what is coming, you deliberately sway your hips as best as you can, trying to show off for his benefit.  It apparently helps, as you only get about halfway before Kelt growls in a familiar tone of voice, \"<i>On your knees, bitch.</i>\"\r\r", false);
			outputText("Excitement rushing through you, you anxiously kneel before him, mouth wide open and heart fluttering.  Kelt immediately moves over you, grinding his cock forcefully into your face.  He seems to enjoy teasing you with it above anything else, as you wait anxiously for his command, nuzzling his cock but unable to do more until he allows it.\r\r", false);
			outputText("\"<i>Alright, bitch.  Swallow my cock.</i>\"\r\r", false);
			outputText("Nothing could give you more pleasure.  Experienced by now, you open wide enough to slurp the head of his member in greedily, taking a mere moment to savor the wonderful taste of his precum before opening your throat to his use.  Grunting to himself, Kelt takes your invitation gladly, and you begin deepthroating him worshipfully, stroking his exposed shaft and fondling his bloated testicles when possible, trying to encourage every drop of wonderful cum.\r\r", false);
			outputText("Though he lasts some time, it is still too short before he groans aloud and begins spewing thick seed into your stomach.  Rapturous, you gulp it down eagerly, feeling it warm your insides and slide into your stuffed belly.  By the time he is finished, your stomach is so packed it aches... but the feeling of contentment at being full of his seed once more is far more satisfying.  Kelt allows you to clean his cock before pulling away.\r\r", false);
			outputText("\"<i>Pretty good, slut.  I knew there was a reason I kept you around.  I've indulged you enough, though.  Get over there and shoot some arrows, before I get bored with you.</i>\"\r\r", false);
			outputText("You hardly remember the rest of the training.  You're far too distracted by the fullness of your belly, and the thought of maybe getting a little more.  Kelt seems almost bored by the end, despite your attempts to entice him during the lesson, and leaves soon afterwards, to your chagrin.", false);
			player.slimeFeed();
			//(+5 Submissiveness)
			player.addStatusValue(StatusEffects.Kelt,2,5);
			//player.addStatusValue(StatusEffects.Kelt,1,3);
			bowSkill(3);
			dynStats("lus", 20, "cor", 1);
			doNext(camp.returnToCampUseOneHour);
			return;
		}
	}
	//(Blowjob Requirement Off, 40% Chance)
	else if (rand(10) <= 3) {
		outputText("You move towards the practice field, trying to ignore the way Kelt openly and hungrily eyes your naked body.  He has become more and more open about his lust for you.  Despite yourself, you can't help but enjoy his attentions.\r\r", false);
		outputText("Once at the field, you move to draw an arrow and begin practice, when Kelt roughly pushes you down to your knees.\r\r", false);
		outputText("\"<i>Not today, bitch.  I think it's time you gave a little back.  So be a good little whore, and get to work on my cock.  I'm gonna bust a nut in that pretty little mouth before I do any more teaching.</i>\"\r\r", false);
		outputText("A shiver of desire and a tremor of fear run through you.  You had hoped to avoid this requirement.  A hunger lies within you... the thought of once more slurping down centaur cum is all but irresistible.  But you fear that with each time, you are losing yourself more and more...\r\r", false);
		//(Submissiveness +80, or Corruption +80)
		if (player.cor + player.lib + player.lust >= 220 && player.statusEffectv2(StatusEffects.Kelt) >= 80) {
			outputText("You try to resist the need.  You honestly try.  But this time, there is just no stopping it.  Your desire for Kelt to cum within you again is so great, you fall to your knees immediately before him, waiting hungrily for your treat.  A part of you wonders why you ever resisted in the first place... in fact, why not suck him off before every lesson?  Surely that would make him like you more...\r\r", false);
			doNext(keltSubmitGivingBJ);
			return;
		}
		//Otherwise)
		else {
			outputText("Despite the need, despite the desire, you are still in control of yourself enough to make a choice.  Do you submit to the centaur's will, and your own hunger?  Or will you somehow find the strength to walk away?", false);
			//Submit				Resist!
			simpleChoices("Submit", keltSubmitGivingBJ, "Resist", keltResistGivingBJ, "", null, "", null, "FIGHT!", kelly.fightToBeatKelt);
			return;
		}
	}
	keltMainEncounter3();
}
	
//(Resist)
private function keltResistGivingBJ():void {
	spriteSelect(35);
	clearOutput();
	outputText("Summoning what remains of your fragmented willpower, you resist the need, apologizing to Kelt and turning to walk away.  It hurts to do so, aching within your chest with an almost physical need to go back; to apologize and kneel before him worshipfully.\r\r", false);
	outputText("To your surprise, however, Kelt does not seem particularly bothered.  In fact, he laughs as you leave.\r\r", false);
	outputText("\"<i>Keep fooling yourself, bitch.  I'll be waiting when you get hungry.</i>\"  \r\rKelt leaves, refusing to teach you now.", false);
	//(-5 Submissiveness)
	player.addStatusValue(StatusEffects.Kelt,2,-5);
	dynStats("lus", 5);
	doNext(camp.returnToCampUseOneHour);
}
//(Submit)
private function keltSubmitGivingBJ():void {
	spriteSelect(35);
	player.slimeFeed();
	clearOutput();
	outputText("\"<i>There we go.  Who's a good little whore?  Who's a hungry little slut?  Okay, bitch... time to fill that belly of yours.  Open wide.</i>\"\r\r", false);
	outputText("Reluctantly, with shame burning in your cheeks and desire ravaging your mind, you lower yourself before him and do just that.\r\r", false);
	if (player.statusEffectv2(StatusEffects.Kelt) >= 90) {
		player.createStatusEffect(StatusEffects.BlowjobOn,0,0,0,0);
	}
	keltReluctantGivingBJ();
	doNext(continueAfterBJ);
}
//Continue training post BJ
private function continueAfterBJ():void {
	spriteSelect(35);
	outputText("After a brief rest, you manage to get back to practicing archery.  ", true);
	keltMainEncounter3();
}
//(Reluctant Blowjob)
private function keltReluctantGivingBJ():void {
	spriteSelect(35);
	player.slimeFeed();
	clearOutput();
	outputText(images.showImage("kelt-farm-reluctantbj"));
	outputText("Kelt immediately moves over you, grinding his cock forcefully into your face.  He seems to enjoy teasing you with it above anything else as you wait anxiously for his command, nuzzling his cock but unable to do more until he allows it.  The musky scent of it fills you with a desire you don't dare admit to... but is present all the same.\r\r", false);
	outputText("\"<i>Alright, bitch.  Swallow my cock.</i>\"\r\r", false);
	outputText("Nothing could give you more pleasure.  You try to restrain yourself, forcing yourself to stroke the shaft experimentally a few times... but your hunger will not be contained.  Flushed with need, you open wide enough to slurp the head of his member in greedily, savoring the glorious taste of that wonderful precum.  Grunting to himself with satisfaction, Kelt pushes his hips forward insistantly.  Without even thinking about it, you open your throat to him, gagging slightly as his cock pushes past your tonsils and once more splits open your throat.  Those swollen testicles hang teasingly out of reach, and thoughts of his cum warming your belly urge you on further to swallow more and more wondrous cock.\r\r", false);
	outputText("Kelt does not hesitate, and does more than his fair share.  Whenever you are reluctant, he firmly shoves forward, coaxing more out of your throat than you were willing to give.  Though he lasts some time, it is still too short before he groans aloud and begins spewing thick seed into your stomach.  You can feel the gooey wads warm your insides and slide into your stuffed belly, and shudder with satisfaction despite yourself.  His thick loads belong inside of you, his hungry, needy little cumdump.  By the time he is finished, your stomach is so full it aches... but the feeling of contentment at being full of his seed once more is far more cruelly satisfying to your bruised ego.  You almost feel incomplete as his slimy cock softens and withdraws from your aching throat... but you resist the need to lick it clean.", false);
	player.refillHunger(50);
	outputText("\r\r\"<i>Pretty good, slut.  I knew there was a reason I kept you around.  Come back next time, and maybe I'll actually teach you something.  Or, who knows?  Maybe I'll just give you another snack, huh?  Ha!</i>\"\r\r", false);
	outputText("Meekly you nod, humiliated and full of cum.  The worst part, by far, is how happy you are on the inside.  You try to tell yourself that this is wrong, that Kelt is an arrogant, cruel creature, and that this is the last time.  But you don't really believe that.  Despite the lies you tell yourself, you look forward to the next time he decides to use you.\r\r", false);	
	dynStats("lus", 5);
	//(+5 Submissiveness)*/
	player.addStatusValue(StatusEffects.Kelt,2,5);
	doNext(camp.returnToCampUseOneHour);
}

//Bad Ends
//(Centaur)
private function keltCentaurBadEnd():void {
	spriteSelect(35);
	clearOutput();
	outputText("You trot towards the farm, pleased with the way your powerful centaur form moves.  You have only one thought in your mind... showing up Kelt for all those insults he tossed out.  After all that, it should be quite satisfying to hear him admire your new equine form, so like his.  A rogue thought pushes through your head that maybe he will do more than just admire it, and a shiver of pleasure runs through you, despite yourself.\r\r", false);
	outputText("Once you spot him on the horizon, you rush forward, galloping at full speed, heart pounding.  The need to be closer to him, to smell him once more, is suddenly overpowering... all consuming.  You slow to a trot as you get closer, and look to savor the expression on his face when he sees you. He seems surprised for just a moment, then darkly amused.  Slowly, he approaches you.\r\r", false);
	outputText("\"<i>So... just had to get a taste of what it is like, huh?  Good for you... I like you this way.  Yes... I can work with this.</i>\"\r\r", false);
	outputText("He paces around you, and you stand at attention, quivering with pleasure at his compliments.  Involuntarily, you feel your horselike tail raise high into the air, as if to show off your nethers as well.  Kelt takes a moment to inspect them, obviously enjoying himself.\r\r", false);
	//(Male)
	if (player.gender == 1) {
		outputText("\"<i>Hmph.  Still technically male, huh?  What, you call this a cock?</i>\"\r\r", false);
		outputText("Roughly he seizes hold of your crotch, making you whinny slightly.  Whether from pain or pleasure, however, is harder to tell.  You feel strange, conflicting emotions... primarily a need to be with Kelt, to pleasure Kelt, to fuck Kelt... the urgency surprises you.  Even more surprising is the fact that your cock is entirely flaccid.\r\r", false);
		outputText("\"<i>Well, I've got no use for males, slut.  Fortunately, you still have something I can use in the meantime.</i>\"\r\r", false);
		outputText("His legs rear suddenly, wrapping around the barrel of your body. You let out a startled protestation, but do not move... your body won't let you.  In fact, if anything, you push back against him, eager and ready.  Part of you is joyous, in fact.  What you wanted wasn't to fuck Kelt!  ", false);
		outputText("<b>... It was for him to fuck you!</b>\r\r", false);
		outputText("Kelt does not hesitate in aserting his dominance, and immediately pushes his shaft towards your ass, inserting it with ease. You let out an almost feral cry of pleasure, and Kelt laughs nastily as he gets a better grip and sinks his erection in deeper, humping away at your hindquarters needfully.  His human hands wrap around you, taking hold of your chin and forcing you to turn enough to face him as he savors your wincing moans.\r\r", false);
		outputText("\"<i>As I thought,</i>\" he sneers, thrusting particularly hard and making you whimper with need.  \"<i>You're no stud.  Just another gelding, wishing to be a real woman.  Well, I could use another cumdump, slut.  So consider this your initiation.  You're mine now, to use whenever I feel like it.  Hope you like the feeling of my cock, bitch.  It's gonna be the only thing you feel for a long time.</i>\"\r\r", false);
		outputText("He thrusts in once more ruthlessly, completely filling your " + player.assholeDescript() + " as he ruthlessly snarls, cumming forcefully deep within you.  Your cock remains flaccid the entire time... it's obvious who the male is in this situation.  As his hot seed pumps into your abused ass, the last resistance you had crumbles, and you moan like a mare in heat, desperate for more.  Kelt obliges, never going soft, and prepares to deliver a second load to his newest harem member.  Again and again, you beg him for more, embracing your new life without regret.\r\r", false);
	}
	//(Genderless)
	if (player.gender == 0) {
		outputText("\"<i>Ha!  What the fuck are you supposed to be?  No cock, no cunt?  Well, no matter, bitch.  You've still got what I want.</i>\"\r\r", false);
		outputText("Roughly he shoves a couple of fingers into your asshole, making you whinny slightly.  Whether from pain or pleasure, however, is harder to tell.  You feel strange, conflicting emotions... primarily a need to be with Kelt, to pleasure Kelt, to fuck Kelt... the urgency surprises you.  But how... and with what?\r\r", false);
		outputText("\"<i>Well, man or woman, it doesn't matter to me.  You're still only good for one thing.  Time to give you a purpose, slut.</i>\"\r\r", false);
		outputText("His legs rear suddenly, wrapping around the barrel of your body.  You let out a startled protestation, but do not move... your body won't let you.  In fact, if anything, you push back against him, eager and ready.  Part of you is joyous, in fact.  What you wanted wasn't to fuck Kelt!  ", false);
		outputText("<b>... It was for him to fuck you!</b>\r\r", false);
		outputText("Kelt does not hesitate in aserting his dominance, and immediately pushes his shaft towards your ass, inserting it with ease.  You let out an almost feral cry of pleasure, and Kelt laughs nastily as he gets a better grip and sinks his erection in deeper, humping away at your hindquarters needfully.  His human hands wrap around you, taking hold of your chin and forcing you to turn enough to face him as he savors your wincing moans.\r\r", false);
		outputText("\"<i>As I thought,</i>\" he sneers, thrusting particularly hard and making you whimper with need.  \"<i>You're no stud.  Just another gelding, wishing to be a real woman.  Well, I could use another cumdump, slut.  So consider this your initiation.  You're mine now, to use whenever I feel like it.  Hope you like the feeling of my cock, bitch.  It's gonna be the only thing you feel for a long time.</i>\"\r\r", false);
		outputText("He thrusts in once more ruthlessly, completely filling your ass as he ruthlessly snarls, cumming forcefully deep within you.  It fills you with an intense, unknowable joy to be used in this way, to have found your purpose!  As his hot seed pumps into your abused ass, the last resistance you had crumbles, and you moan like a mare in heat, desperate for more.  Kelt obliges, never going soft, and prepares to deliver a second load to his newest harem member.  Again and again, you beg him for more, embracing your new life without regret.", false);
	}
	//(Female, Hermaphrodite)
	if (player.gender >= 2) {
		//(Hermaphrodite)
		if (player.gender == 3) {
			clearOutput();
			outputText("\"<i>Ooh, the slut is packing is she?  Tell me, how's that cock working out for you?</i>\"\r\r", false);
			outputText("It isn't, of course.  Not at all... you are entirely flaccid, and Kelt knows it.  He grasps the base of your cock roughly, giving it a few experimental tugs, laughing derisively as he does so.  There is no reaction... save that your cunt gets a little wetter.\r\r", false);
			outputText("\"<i>Well, no matter.  This here is what I came for.</i>\"\r\r", false);
		}
		//(Both)
		outputText("Crudely, Kelt pushes three fingers into your exposed pussy, making you whinny slightly.  He laughs to himself, then pushes four fingers in... then his whole fist.  You whimper and moan, unable to tell yourself to walk away.  He pumps his hand experimentally for a moment, taking pleasure in how easily he disarms you.  Horny and needful, you couldn't stop him if you tried.\r\r", false);
		outputText("\"<i>Aww... we sure got a pretty little filly here, don't we?  Still, a filly isn't really happy unless she's being fucked.  Unless her stomach is full of foals for her master.  And since you've gone to the trouble of preparing yourself for me, bitch... I guess I'll just have to do the job.</i>\"\r\r", false);
		outputText("His legs rear suddenly, wrapping around the barrel of your body.  You let out a startled protestation, but do not move... your body won't let you.  In fact, if anything, you push back against him, eager and ready.  Your vagina drools anxiously, ready for him, ready to be seeded with his foals.  Part of you is joyous, in fact.  What you wanted wasn't to fuck Kelt!", false);
		outputText("<b>... It was for him to fuck you!</b>\r\r", false);
		outputText("Kelt does not hesitate in aserting his dominance, and immediately pushes his shaft forward, finding his mark and spreading your needy entrance wide instantly.  You let out a feral cry of pleasure, Kelt laughing nastily as he gets a better grip and sinks his erection in deeper, humping away at your hindquarters needfully.  His human hands wrap around you, taking hold of your chin and forcing you to turn enough to face him as he savors your wincing moans.\r\r", false);
		outputText("\"<i>As I thought,</i>\" he sneers, thrusting particularly hard and making you whimper with need.  \"<i>Archery... what a joke!  Breeding sluts don't shoot arrows.  They get fucked until they're pregnant, then get fucked again.  They kneel and suck me off when I say so, and their stomachs swell with my young.  Well, I could use another cumdump, slut.  So consider this your initiation.  You're mine now, to use whenever I feel like it.  Hope you like the feeling of my cock, bitch.  It's gonna be the only thing you feel for a long time.</i>\"\r\r", false);
		outputText("He thrusts in once more ruthlessly, burying the whole length of his cock as he ruthlessly snarls, cumming forcefully deep within you.  You feel his warmth explode within you, seeking out your fertile eggs, ready to knock you up with your master's foals, and cum yourself.  As his hot seed pumps into your womb, the last resistance you had crumbles, and you moan like a mare in heat, praying for twins.  Kelt, never going soft, continues thrusting urgently, preparing to deliver a second load to his newest harem member.  Again and again, you beg him for more, embracing your new life without regret.", false);
	}
	doNext(keltBadEndEpilogue);
}

//(Human) bad end
private function keltSubmissiveBadEnd():void {
	spriteSelect(35);
	clearOutput();
	outputText("You race towards the farm, only one thought on your mind.  Kelt... your master, your love, your hunger.  Your head is filled with thoughts of his cock, and you fancifully dream of how he will use it on you today.  Once, you had a mission of some kind... an important duty.  The stray thought vanishes almost instantly, though.  Of course you have a duty!  To be fucked by Kelt, whenever he wants to!\r\r", false);
	outputText("Almost as soon as you arrive, your clothes are falling off of you, ripped off with an urgency that betrays your lust.  Kelt eyes the display with cruel amusement, then steps forward and takes your chin by the hand, inspecting you imperiously.  The scent of him fills your nose, the need for his cock fills your thoughts.  Impishly, you suggest that you are in need of another 'archery' lesson.\r\r", false);
	outputText("His face clouds over darkly.  That's all the warning you get before he strikes you hard across the face, sending you spinning to the ground with a grunt.  The pain fills you with happiness, and urgently you raise your ass needfully into the air, hoping he will take you then and there.  Kelt snarls at you, and you tremble slightly, but keep your ass high.\r\r", false);
	outputText("\"<i>Archery?  I've had enough of this game, bitch.  I've decided that I won't be teaching you archery anymore.</i>\"\r\r", false);
	outputText("A sense of dread fills you.  No more lessons?  No more... Kelt?  Then, another shock of pain as he roughly grabs you by the hair, drags you over to a nearby bale of hay, and throws you onto it facedown.  Moments later, his heavy weight rests on top of you, swollen cock pressing into your back.\r\r", false);
	outputText("\"<i>No, no more archery.  Time for your real education, bitch.  Lesson one... you are a slut, only here for my pleasure.  No more adventuring, no more exploring.  From now on, you are nothing but a hole for me to bust a nut into.  Got it?</i>\"\r\r", false);
	outputText("You whimper with joy, thanking him over and over again.  A great weight has been lifted, your true purpose revealed.  How could you have not known it before?  Kelt is your master, and you are nothing but his needy slut!  The revelation fills you with ecstasy.  Eagerly you thrust back up against him, eager to be filled, desperate for satisfaction.  He grinds into you, grinning wickedly all the time.  Then, mercifully, he pulls back enough to line up his shot, and fills your ass with his cock.\r\r", false);
	outputText("\"<i>Ungh!  There's a good bitch.  From now on, you're mine, and mine only.  If you dare to fuck another creature, I will kill you.  Be a good slut, though, and maybe I'll give you a few foals to fill that belly.  Now moan for me, bitch.  I wanna hear you scream as I make you mine.</i>\"\r\r", false);
	outputText("Scream you do, but with pleasure, as his cock erupts deep within your bowels.  This is what you wanted... this is what you always wanted.  Kelt grunts with contented release, then begins thrusting again, cock still hard as he prepares to dump a second load into his newest harem member.  Again and again, you beg him for more, embracing your new life without regret.", false);
	doNext(keltBadEndEpilogue);
}

//Bad End 2
private function keltBadEndEpilogue():void {
	spriteSelect(35);
	clearOutput();
	outputText("The next year, after a few suggested mutations from your master...\r\rThe heroine hesitatingly moved forward, crossing the field with the sort of practiced caution that had so far kept her safe in this strange land.  The farm should be somewhere nearby, if she had figured things correctly.  Of course, who could tell with this ever-shifting landscape?\r\r", false);
	outputText("A sudden sound caught her attention.  A lewd, squishing noise, the sound of horses crying out.  A monster?  Whatever it was, it was coming from behind the barn.  Readying her sword, the heroine moved forward cautiously, ready to confront danger.\r\r", false);
	outputText("What she found was not what she expected.  Two centaurs, wrapped in carnal bliss.  Well, the " + (player.findPerk(PerkLib.BroBody) >= 0 || player.findPerk(PerkLib.FutaForm) >= 0 || player.gender == 3 ? "hermaphrodite" : "female") + ", at least, seemed wrapped in carnal bliss.  She groaned worshipfully beneath her mate, whimpering and kneading her own watermelon sized breasts as the powerful male pumped her again and again with his oversized, equine cock.  Even as the heroine watched, fascinated, the female centaur orgasmed explosively, shouting her satisfaction to the high heavens.  If the thick puddle of juices " + (player.findPerk(PerkLib.BroBody) >= 0 || player.findPerk(PerkLib.FutaForm) >= 0 || player.gender == 3 ? "and cum " : "") + "below them " + (player.findPerk(PerkLib.BroBody) >= 0 || player.findPerk(PerkLib.FutaForm) >= 0 || player.gender == 3 ? "were" : "was") + " any judge, this must have been her last orgasm among many.  She was almost half the size of her mate, and clearly savoring every thrust of his oversized cock into her distended equine cunt, lewdly thrusting back and begging him to cum inside her again.\r\r", false);
	outputText("In time, the male obliged, pulling cruelly on the centauress' hair as he let out a low roar and came forcefully.  The heroine stared in wonder as his massive balls convulsed again and again, pumping his mare full of seed.  If she listened, she could actually hear the lewd squish of every blast of semen as it filled her, pumping steady gouts of babycream into her womb." + (player.findPerk(PerkLib.BroBody) >= 0 || player.findPerk(PerkLib.FutaForm) >= 0 || player.gender == 3 ? " At the same time, she spurts a large amount of futa-cum, an obvious sign that she's a hermaphrodite." : "") + "\r\r", false);
	outputText("The centaur dismounted as soon as he was satisfied, ignoring the abused mare after his needs were met.  He was obviously the dominant one, and his mate looked after him with hungry eyes, wanting more.  Two more centaurs... young females, by the look of it, emerged from the barn, hurrying over towards their mother and happily latching onto her breasts.  The mother cooed happily, letting them nurse from her full breasts, even while looking after their retreating father hopefully.  The heroine could see, looking closely, how distended the mare's stomach was... she was probably pregnant with yet another foal.  Somehow, the image seemed terribly erotic to the heroine, who bit her lip anxiously.\r\r", false);
	outputText("\"<i>Enjoying the show, fucker?  She's not bad, for a quick fuck now and then.  A little clingy, but makes for a good cumdump.  What... you jealous?</i>\"\r\r", false);
	outputText("The heroine paled, and turned around to face the male, berating herself for letting him sneak up on her.  Brandishing her sword, she tried to step backwards, wary of an attack.  The centaur eyed her sword amusedly, then broke out into a nasty laugh, ", false);
	outputText("\"<i>Ha!  Little bitch human, who thinks she knows how to use a sword.  You use that little stick to ward off the big bad monsters when they come for your little pussy?  Give me a break.  This is a real man's weapon.</i>\"\r\r", false);
	outputText("He touched the bow strung across his broad chest arrogantly.  The heroine hesitated, looking at the weapon.  They had bows like that in her home town, but she didn't have one.  It could be a useful tool... and the centaur seemed to know what he was doing with it.  He didn't seem threatening... maybe a little arrogant, and more than a little rude.  Maybe...\r\r", false);
	outputText("The centaur noticed her looking, and grinned.  \"<i>You like what you see?  Maybe I could teach you a few things.  If you're not as stupid as that slut, of course.</i>\"\r\r", false);
	outputText("He waved confidently at the mare, still nursing her young with a rapturous look on her face.  Cum slowly oozed out of her pussy, pooling on the ground beneath her, and the heroine felt a little envious for a moment.  Most horses had harems, the virile male satisfying many women at once.  How many times a day was this mare fucked?\r\r", false);
	outputText("The centaur grinned, knowingly.  His musk was heavy on the air, a thick, animalistic scent of masculinity.  \"<i>Well, I could do with a little distraction anyway.  Stupid whore may be a good fuck, but a man needs to... spread out a little.  Come back tomorrow, and maybe I can knock some fucking sense into that empty head of yours.  My name's Kelt.</i>\"\r\r", false);
	getGame().gameOver();
}
//Requires 40+ int & 70+ corruption to resist his 'aura'.
private function keltResistance():void {
	spriteSelect(35);
	outputText("You close your eyes, ", true);
	if (player.faceType == FACE_HORSE || player.faceType == FACE_DOG) outputText("a low growl building in the back of your throat", false);
	else outputText("fighting anger-fueled muscle-spasms", false); 
	outputText(" as Kelt's insults go too far.  You've had just about enough of his disingenuous assertions!\r\r", false);
	outputText("An idea on how to put him in his place slowly forms in the back of your mind, though you're sure pulling it off would humiliate the puffed-up centaur into never his showing his face around the farm again.  Do you do it?", false);
	doYesNo(fuckKeltsShitUp,keltResistancePussyOut);
}
private function keltResistancePussyOut():void {
	spriteSelect(35);
	outputText("You suppress your anger for now.  Yes; Kelt's an asshole, but he's taught you a lot, and would it hurt to humor the cute stud?  You shake your head, uncomfortable with the out-of-place thought.  You leave in a hurry, unable to face your master.", true);
	//(+2 submission)
	player.addStatusValue(StatusEffects.Kelt,2,2);
	doNext(camp.returnToCampUseOneHour);
}

private function fuckKeltsShitUp():void {
	spriteSelect(35);
	clearOutput();
	//If naga folks
	if (player.faceType == FACE_SNAKE_FANGS && player.tongueType == TONGUE_SNAKE && player.lowerBody == LOWER_BODY_TYPE_NAGA) {
		outputText(images.showImage("kelt-farm-naga-subkelt"));
		outputText("Feigning a coy smile, you lick your lips with your forked tongue and beckon Kelt towards you.  The foolish stud trots over to you saying \"<i>That's more like it, worm.  Maybe when I'm done with your mouth, I'll let you have my dick in your ass, too.</i>\"  His sheath ripples and swells as his thick member begins to slowly droop out from the folded skin, hanging towards the ground.  It continues growing as he comes closer and closer, until it finally begins to grow rigid and arc towards your face.  You feel a moment of self-doubt as you breathe in his wonderful scent - wouldn't it be better, safer to just give in?  No, says a cold, reptile voice in your head.  You are the predator here and he, arrogant prey, has stepped into your trap.  Make him pay.  Make him know where his place in the world is.\r\r", false);

		outputText("You open your mouth and, instead of attaching yourself to Kelt's cock, you lash out at lightning speed, wrapping your arms around his flanks and biting into his backside.  The satisfaction you take from burying your fangs into such a fine piece of meat is almost as great as the squeal of surprised pain it draws from Kelt.  \"<i>What are you doing, you stupid bitch?  Get off.  Now!</i>\"  You don't bother giving him a response.  He lashes out with his powerful hind legs, but you are well ahead of him; wriggling upwards you begin to wrap your long coils around his equine back.  He tries to trap your lower half under his hooves, but the poison you sank into him is already taking effect - unable to coordinate, he can only stab at you woozily.  You skilfully trip him to his knees with a flick of your scaled tip, before weaving under him and over, then around his human upper half.  He struggles weakly with his arms, but with your venom coursing through him he is simply no match for your strong, muscular coils.  You stop when you are level with his face, his arms and entire frame swaddled and trapped in your long, patterned tail.\r\r", false);

		outputText("You take a moment to indulge in the sensation - the feeling of this big, muscled creature against your warm scales, at your mercy.  His panicky heartbeat reverberates through your frame, and he glowers at you, unable to resist, as you languidly trace the line of his proud jaw with your finger.  \"<i>Let me go now, and I promise I won't kill you.  I may have to beat you, but I won't kill you,</i>\" he growls.  You are barely listening - you are staring into his eyes.  There is something there aside from anger - is it fear?  You smirk, and slowly begin to rise above him, until your genital slit is level with his face.  As you do so, you slide the tip of your tail towards Kelt's member and gently flick its end; he grits his teeth as his big horse cock begins to strain to attention again.  You gently circumnavigate his head, tormenting him as you speak.\r\r", false);
		//If male/hermaphrodite 
		if (player.hasCock()) {
			//Single cock: 
			if (player.cockTotal() == 1) {
				outputText("\"<i>Pretty pony stepped on a snake.  Now pretty pony has to pay the price,</i>\" you say, sighing as you part your lips and allow your " + player.cockDescript(0) + " to slide out and feel the fresh air.\n\n\"<i>You put that in my mouth and I will bite it off,</i>\" snarls Kelt.\n\n\"<i>Will you?</i>\" you sneer. \"<i>I will grow one back.  You, on the other hand, will die a slow, agonising death.  Be smart.</i>\" He stares up at you, and yes, it's fear: pure, animalistic fear of a horse for a viper.  You open your mouth and bare your fangs in a wide, triumphant smile at him; venom dribbles down your chin.  He lowers his eyes and opens his mouth in submission.  Needing no further invitation, you slide your " + player.cockDescript(0) + " into his mouth, massaging your hands into his hair as you do so.\r\r", false);
				
				outputText("He is unpracticed at first, unsure; you feel his teeth rub against your length and for a moment you wonder if he actually will carry through his threat.  You tease at his horsecock with your tail, circling his head faintly and then, gently, sticking the very tip of it into his urethra.  He moans around your " + player.cockDescript(0) + " and his teeth seem to vanish, replaced with a sucking, eager wetness.  You slowly begin to feed more of your length into him.\r\r", false);
			}
			//Multiple dick: 
			else {
				outputText("\"<i>Pretty pony stepped on a snake.  Now pretty pony has to pay the price,</i>\" you say, sighing as you part your lips and allow your cocks to slide out and feel the fresh air.  You idly slap your " + player.cockDescript(0) + " against his face. \"<i>You put that in my mouth and I will bite it off,</i>\" snarls Kelt.\n\n\"<i>Will you?</i>\" you sneer.  \"<i>I will fuck your mouth with the next one. Then I'll grow the first one back and come and fuck you with that one again!  Be smart.</i>\"  He stares up at you, and yes, it's fear: pure, animalistic fear of a horse for a viper.  You open your mouth and bare your fangs in a wide, triumphant smile at him; venom dribbles down your chin.  He lowers his eyes and opens his mouth in submission.  Needing no further invitation, you slide your " + player.cockDescript(0) + " into his mouth, massaging your hands into his hair as you do so; your semi-distended " + player.cockDescript(1) + " bumps into his chin, an impossible-to-ignore reminder of your threat.\r\r", false);
				
				outputText("He is unpracticed at first, unsure; you feel his teeth rub against your length and for a moment you wonder if he actually will carry through his threat.  You tease at his horsecock with your tail, circling his head faintly and then, gently, sticking the very tip of it into his urethra.  He moans around your " + player.cockDescript(0) + " and his teeth seem to vanish, replaced with a sucking, eager wetness.  You slowly begin to feed more of your length into him.\r\r", false);
			}
			if (player.cocks[0].cockLength <= 10) {
				if (player.balls > 0) outputText("Your " + player.ballsDescriptLight() + " bump into his chin as your cock finds the back of his throat. ", false);
				else outputText("Your genital slit bumps into his chin as your cock finds the back of his throat. ", false);
				outputText("He is now entirely engaged with your length, moving his head back and forth as his tongue slathers it with attention, perhaps in the hope that the sooner he gets you off the sooner this nightmare will end.  You smirk and grip his hair, moving his head in rhythm with your own movements.\r\r", false);
				
				outputText("You feel a mighty groan around your " + player.cockDescript(0) + " and Kelt's cock begin to pulse against your tail urgently.  Quickly and expertly, you wrap the end around the centaur's penis tightly, denying him release and rewarding yourself with another pained, muffled squeal reverberating through your prick.\r\r", false);
				
				outputText("\"<i>Ah, ah, ah,</i>\" you hiss.  \"<i>Sluts don't get off before their masters.</i>\"  A wicked idea strikes you.  Whilst still holding onto the centaur's cock with your coils, you begin to wind the tip of your tail towards Kelt's ass.  It isn't easy; you have invested the entirety of your frame into holding onto the centaur, so it is by measures that you constrict him tighter as your tail inches towards his anus.  He is bone -crushingly gripped in your coils by the time you find his sphincter, which you softly but surely sink your tip into.  Kelt struggles with the last of his strength against this final humiliation, but there is nothing he can do; with your venom plaguing his limbs, your coils wrapped hard around his frame, and your cock buried in his face, you have robbed him of everything.  His saliva coats your ", false);
				if (player.balls > 0) outputText(player.ballsDescriptLight(), false);
				else outputText("crotch", false);
				outputText(" as you begin to roughly push and pull him against your dick using his hair, feeding your tail into his ass by increments.  You feel your tip touch something which pulses, and you gently probe it as you roughly fuck his mouth, beginning to reach your peak.  Kelt only manages a few muffled screams as you milk his prostate while continuing to deny his cock release, before you silence him with a torrent of cum, which you pour directly down his throat.\r\r", false);

				outputText("\"<i>Oh, you're soooo good at that,</i>\" you sigh, as he silently drinks your seed, his face a rictus of agonised arousal.  \"<i>That's right, take it all down.  Who would've guessed that you're a champion cock sucker?  Maybe if you drop the tough guy act, I'll let you do it some more.  We can find some pink dye for you, maybe some succubus milk, and then you can look like the pretty pony you... really... are!</i>\"\r\r", false);

				outputText("You punctuate these last words with three final thrusts and then, spent, slowly withdraw your " + player.cockDescript(0) + " from his mouth, spit and cum trailing on your captive's lips.  Smirking, you loosen your bonds just a little by withdrawing your tail from his ass.  Kelt doesn't even orgasm; he raggedly moans as cum simply drools out of his abused dick by the bucket load.\r\r", false);
				
			}
			//If >10 inches: 
			else {
				outputText("Slowly but surely you feed more of your formidable member into his mouth until you feel the back of his throat, with most of your " + player.cockDescript(0) + " still outside his lips.  The centaur is now entirely engaged with your length, moving his head back and forth as his tongue slathers it with attention, perhaps in the hope that the sooner he gets you off the sooner this nightmare will end.  You smirk and grip his hair, moving his head in rhythm with your own movements.\r\r", false);

				outputText("You feel a mighty groan around your " + player.cockDescript(0) + " and your snake tip feels Kelt's cock begin to pulse urgently.  Quickly and expertly, you wrap the end of your tail around the centaur's penis tightly, denying him release and rewarding yourself with another pained, muffled squeal reverberating through your cock.\r\r", false);

				outputText("\"<i>Ah, ah, ah,</i>\" you hiss.  \"<i>Sluts don't get off before their masters.</i>\"  A wicked idea strikes you.  Whilst still holding onto the centaur's cock with your coils, you begin to wind the tip of your tail towards Kelt's ass.  It isn't easy; you have invested the entirety of your frame into holding onto the centaur, so it is by measures that you constrict him tighter as your tail inches towards his anus.  He is bone-crushingly gripped in your coils by the time you find his sphincter, which you softly but surely sink your tip into.  Kelt struggles with the last of his strength against this final humiliation, but there is nothing he can do; with your venom plaguing his limbs, your coils wrapped hard around his frame, and your cock buried in his face, you have robbed him of everything.  Slowly you begin to feed even more of your " + player.cockDescript(0) + " into his mouth, until you see his throat bulge with your manhood.  The tightness of it is sensational and you groan.  You let him get used to the sensation of deepthroating you before you begin to pick up the pace, ramming the majority of your dick into his mouth until your " + player.ballsDescriptLight() + " begin to slap against his chin.  At your other end you feel your snake tip touch something which pulses, and you gently probe it as you continue to roughly fuck his mouth, beginning to reach your peak.  Kelt only manages a few muffled screams as you milk his prostate while continuing to deny his cock release, before you silence him with a torrent of cum, pouring it directly into his stomach.\r\r", false);
				
				outputText("\"<i>Oh, you're soooo good at that,</i>\" you sigh, as he silently drinks your seed, his face a rictus of agonised arousal.  \"<i>That's right, take it all down.  Who would've guessed that you're a champion cock sucker?  Maybe if you drop the tough guy act, I'll let you do it some more.  We can find some pink dye for you, maybe some succubus milk, and then you can look like the pretty pony you... really... are!</i>\"\r\r", false);

				outputText("You punctuate these last words with three final thrusts and then, spent, slowly withdraw your " + player.cockDescript(0) + " from his mouth, spit and cum trailing on your captive's lips.  Smirking, you loosen your bonds just a little by withdrawing your tail from his ass.  Kelt doesn't even orgasm; he raggedly moans as cum simply drools out of his abused dick by the bucket load.", false);
			}
		}
		//If Female: 
		else if (player.hasVagina()) {
			outputText("\"<i>Pretty pony stepped on a snake.  Now pretty pony has to pay the price,</i>\" you say, sighing as you part your lips and allow your " + player.vaginaDescript(0) + " to open and feel the fresh air. \"<i>You put your bud in my mouth and I will bite it off,</i>\" snarls Kelt. \"<i>Will you?</i>\" you sneer.  \"<i>I will grow one back.  You, on the other hand, will die a slow, agonising death.  Be smart.</i>\"  He stares up at you, and yes, it's fear: pure, animalistic fear of a horse for a viper. You open your mouth and bare your fangs in a wide, triumphant smile at him; venom dribbles down your chin.  He lowers his eyes and opens his mouth in submission. Needing no further invitation, you lower your " + player.vaginaDescript(0) + " onto his tongue, massaging your hands into his hair as you do so.\r\r", false);

			outputText("He is unpracticed at first, unsure; you feel his teeth rub against your " + player.clitDescript() + " and for a moment you wonder if he actually will carry through his threat.  You tease at his horsecock with your tail, circling his head faintly and then, gently, sticking the very tip of it into his urethra.  He moans against your " + player.vaginaDescript(0) + " and his teeth seem to vanish, replaced with a sucking, eager wetness.  You press your abdomen against him tightly, forcing your " + player.clitDescript() + " into his mouth and his tongue into your wet hole.\r\r", false);

			outputText("Girl cum begins to drip down Kelt's chin.  He is now entirely engaged with your " + player.vaginaDescript(0) + ", moving his head back and forth as his tongue slathers your clit with attention, perhaps in the hope that the sooner he gets you off the sooner this nightmare will end.  You smirk and grip his hair, forcing his head this way and that so that no corner of your pink opening goes without attention.\r\r", false);

			outputText("You feel a mighty groan and Kelt's cock begin to pulse urgently against your tail.  Quickly and expertly, you wrap the end around the centaur's penis tightly, denying him release and rewarding yourself with another pained, muffled squeal reverberating through your cunt.\r\r", false);

			outputText("\"<i>Ah, ah, ah,</i>\" you hiss.  \"<i>Sluts don't get off before their masters.</i>\"  A wicked idea strikes you.  Whilst still holding onto the centaur's cock with your coils, you begin to wind the tip of your tail towards Kelt's ass.  It isn't easy; you have invested the entirety of your frame into holding onto the centaur, so it is by measures that you constrict him tighter as your tail inches towards his anus.  He is bone-crushingly gripped in your coils by the time you find his sphincter, which you softly but surely sink your tip into.  Kelt struggles with the last of his strength against this final humiliation, but there is nothing he can do; with your venom plaguing his limbs, your coils wrapped hard around his frame, and his face buried in your genitals, you have robbed him of everything.  His saliva coats your opening as you clench your muscles and trap his tongue in your " + player.vaginaDescript(0) + " before roughly rubbing yourself against him, face-fucking him for all you are worth; the sensation you get from bouncing your clit against his upper lip is immense and you pick up the pace.  At your other end you feel your tip touch something which pulses deep in his anal passage, and you gently probe it as you roughly fuck his mouth, beginning to reach your peak.  Kelt only manages a few muffled screams as you milk his prostate while continuing to deny his cock release, before you silence him with a waterfall of girl cum, which in ecstasy you slather his entire face with.\r\r", false);
			
			outputText("\"<i>Oh, you're soooo good at that,</i>\" you sigh, as he silently accepts this treatment, his face a rictus of agonised arousal.  \"<i>That's right, keep using your tongue on me.  Like that, yes!  Who would've guessed that you're a champion carpet diver?  Maybe if you drop the tough guy act, I'll let you do it some more.  We can find some pink dye for you, maybe some succubus milk, and then you can look like the pretty pony you... really... are!</i>\"\r\r", false);
	
			outputText("You punctuate these last words with three final thrusts against his face and then, spent, you slowly pull away, spit and slime trailing on your captive's lips.  Smirking, you loosen your bonds just a little by withdrawing your tail from his ass.  Kelt doesn't even orgasm; he raggedly moans as cum simply drools out of his abused dick by the bucket load.\r\r", false); 
		}
		//If Genderless:
		else {
			outputText("\"<i>Pretty pony stepped on a snake.  Now pretty pony has to pay the price,</i>\" you say. \"<i>What are you going to do, freak; read poetry at me?</i>\" sneers Kelt. \"<i>Form a book circle so we can discuss what it means to have no fucking genitals in a world built on lust?  Or is there some other way sexless nothings like you get.. .off...</i>\" he trails off as, with sinuous grace, you twist your body so that his mouth is now facing your " + player.buttDescript() + ".  You smile beatifically at him over your shoulder as you flare your " + player.hipDescript() + " and present your " + player.assholeDescript() + " to him. \"<i>I have noticed you are good at wagging your pretty little tongue, pony.  It saddens me to see you waste that talent, so I have found a good use for it.  Do otherwise and you will die a slow, agonising death.  Be smart.</i>\"  He stares up at you, and yes, it's fear: pure, animalistic fear of a horse for a viper.  You open your mouth and bare your fangs in a wide, triumphant smile at him; venom drips down your chin.  He lowers his eyes and opens his mouth in submission.  Needing no further invitation, you press your " + player.assholeDescript() + " onto him.\r\r", false);

			outputText("He is unpracticed at first, unwilling; you feel his teeth rub against your hole");
			outputText(". You tease at his horsecock with your tail, circling his head faintly and then, gently, sticking the very tip of it into his urethra.  He moans around your " + player.buttDescript() + " and his teeth seem to vanish, replaced with a sucking, eager wetness.  With reptilian litheness, you slowly lean backwards and press your hands onto the back of his head, pushing his face more into yourself.  You giggle at the sensation as his tongue pushes into your anal passage, slathering it with attention, perhaps in the hope that the sooner he gets you off the sooner this nightmare will end.  Smirking and gripping his hair, you move his head in rhythm with your own sinuous movements.\r\r", false);
			
			outputText("You feel a mighty groan reverberate through you and Kelt's cock begin to pulse urgently against your tail.  Quickly and expertly, you wrap the end around the centaur's penis tightly, denying him release and rewarding yourself with another pained, muffled squeal reverberating through your ass.\r\r", false);

			outputText("\"<i>Ah, ah, ah,</i>\" you hiss.  \"<i>Sluts don't get off before their masters.</i>\"  A wicked idea strikes you.  Whilst still holding onto the centaur's cock with your coils, you begin to wind the tip of your tail towards Kelt's ass.  It isn't easy; you have invested the entirety of your frame into holding onto the centaur, so it is by measures that you constrict him tighter as your tail inches towards his anus.  He is bone-crushingly gripped in your coils by the time you find his sphincter, which you softly but surely sink your tip into.  Kelt struggles with the last of his strength against this final humiliation, but there is nothing he can do; with your venom plaguing his limbs, your coils wrapped hard around his frame, and his tongue buried in your ass, you have robbed him of everything.  His saliva coats your opening as you clench your muscles and trap his tongue deep inside before roughly rubbing your " + player.buttDescript() + " against him, face-fucking him for all you are worth; the soft, slippery sensation inside you is immense and you pick up the pace.  At your other end you feel your tip touch something which pulses deep in his anal passage, and you gently probe it as you roughly fuck his mouth, beginning to reach your peak.  Kelt only manages a few muffled screams as you milk his prostate while continuing to deny his cock release, before you feel something clench inside of you and you begin to ride your strange but satisfying anal orgasm.\r\r", false);

			outputText("\"<i>Oh, you're soooo good at that,</i>\" you sigh, as he silently accepts the utter humiliation, his face a rictus of agonised arousal.  \"<i>That's right, keep using your tongue on me.  Like that, yes!  Who would've guessed that you're a champion ass licker?  Maybe if you drop the tough guy act, I'll let you do it some more.  We can find some pink dye for you, maybe some succubus milk, and then you can look like the pretty pony you... really... are!</i>\"\r\r", false);

			outputText("You punctuate these last words with three final backward thrusts against his face and then, spent, you slowly pull away, spit trailing from your ass onto your captive's lips.  Smirking, you loosen your bonds just a little by withdrawing your tail from his ass.  Kelt doesn't even orgasm; he raggedly moans as cum simply drools out of his abused dick by the bucket load.\r\r", false);
		}
		//All go to: 
		outputText("You take your time unknotting yourself from the centaur, continuing to enjoy the feeling of your scales brushing against his thoroughbred form.  Kelt is in no shape to retaliate against you; your poison and treatment of him has left him semi-comatose.  His eyes are wide open and vague, as if he can't quite believe what just happened.  You leisurely put on your " + player.armorName + " and then, with a smile, give him an affectionate slap on the spot you bit him and slither off.  You wonder if he will ever be able to face you again.", false);
	}
	//Standard anti-kelt scene
	else {
		outputText(images.showImage("kelt-farm-subkelt"));
		outputText("Feigning a coy smile, you drop to your knees and beckon Kelt towards you.  The foolish stud trots over saying, \"<i>That's more like it, slut.  Maybe when I'm done with your mouth, I'll let you have my dick in your ass too.</i>\"  His sheath ripples and swells as his thick member begins to slowly droop out from the folded skin, hanging towards the ground.  It continues growing as he comes closer and closer, until it finally begins to grow rigid and arc up to point at your face.  You breathe in your master's wonderful scent an — No!  You won't cave in to him this time!\r\r", false);
		outputText("You grip his dick just below the flare and yank it down hard, stepping up and back until you're behind the beast.  His flexible horse-dick seems to be handling the angle well, so you pull it back further until Kelt dances about uncomfortably, trying to relax the pressure on his exposed member.  He barks, \"<i>You really have no fucking clue what you're doing, do you, bitch?</i>\"\r\r", false);
		outputText("Your cheeks color, but your anger drives away the urge to submit.  A quick jerk on his flared dong makes Kelt whinny painfully, and he lashes out with a vicious kick from his hind legs.  You anticipate such a move, and dodge, bending his length further just as his backside starts lifting up.  The pain robs his kick of any strength, and you're able to sidestep one leg and force the other aside with a block before it can connect.  He lands hard, wobbling and whinnying uncomfortably, even starting to cry, \"<i>Ah, oww... please, just stop hurting me!</i>\"\r\r", false);
		if (player.tallness < 50 || player.totalCocks() == 0) {
			if (player.tallness < 50) outputText("Realizing you're too short to dominate him properly, you come up with another plan.  ", false);
			outputText("You give his ass a hard smack before you ball up your hand into a fist.  \"<i>Who's the bitch now?!</i>\" you taunt, punching forwards into his asshole.  He cries out at the sudden discomfort, but you feel his dick thicken perceptibly in your hand.  You open your hand when you bump into an apple sized knot inside him, and give it a small, experimental squeeze.  Kelt whinnies and squirts like a garden-hose, splattering a generous helping of clear pre-cum into the grass.  You grin wolfishly and constrict your fingers around the organ.  His horse-cock twitches and flares in your hand, unloading a massive squirt of cum from the stimulation.\r\r", false);
		}
		else {
			outputText("You give his ass a hard smack and line your " + player.cockDescript(0) + " with his massive pucker.  Pressing forwards, you punch deep into his asshole and taunt, \"<i>Who's the bitch now, you fucking cock-sleeve?</i>\"  You feel your head bump across the hard knot of his prostate, and on contact you can feel his dick twitch in your hand, unloading a torrent of pre-cum into the dirt.  Porking the poor centaur, you laugh as he whinnies in pain, but every time you thrust back inside he spurts more and sticky pre until you feel his cock flare in your hand and start unloading.\r\r", false);
		}
		outputText("Pulling out with a wet-sounding 'SCHLIIICK', you wash off the filth with a nearby bucket, probably set up by the centaur when he was planning on using YOU.  You grab a lasso and pull it up over his dick, ignoring his protests as you knot it tightly about his still-leaking member.  Kelt whines, \"<i>What are you dooooiiiing?!?</i>\"\r\r", false);
		outputText("\"<i>Bitches aren't supposed to get off first, slut.</i>\"  You pull the rope up between his ass-cheeks and walk forwards, looping it over his shoulder.  Now in front of him, you give the rope a yank, watching his face contort with pain as the rope digs into his ass and pulls his cock backwards until it looks like a second tail.  Ignoring his tears and blubbering protests, you lead him to a nearby bench and climb atop it, undoing your " + player.armorName + " with one hand.  He looks down at your now-exposed crotch and shudders, openly crying.\r\r", false);
		if (player.gender == 0) {
			outputText("You turn around, bending over to expose your " + player.assholeDescript() + ".  \"<i>Lick it, bitch,</i>\" you command.  When he doesn't, you give the rope a pull, and his hooves paw at the dirt in pain.  \"<i>I said LICK!</i>\" you scream, and this time he does.  His tongue slips between your " + player.assDescript() + ".  \"<i>Deeper,</i>\" you sigh, and he complies, no longer capable of resistance.  You make him tonguefuck you until you come to a shuddering orgasm.\r\r", false);
		}
		else if (player.hasVagina() && (player.totalCocks() == 0 || rand(2) == 0)) {
			outputText("You spread your " + player.legs() + " and expose your " + player.vaginaDescript(0) + ".  \"<i>Lick it, bitch,</i>\" you command.  When he doesn't, you give the rope a pull, and his hooves paw at the dirt in pain.  \"<i>I said LICK!</i>\" you scream, and this time he does.  His tongue slips between your puffy folds ", false);
			if (player.vaginas[0].vaginalWetness < VAGINA_WETNESS_SLICK) outputText("tasting them experimentally.  ", false);
			else outputText("immediately becoming slick with your fuck-me-juices.  ", false);
			outputText("\"<i>Deeper,</i>\" you sigh, and he complies, no longer capable of resistance.  You make him tonguefuck you until you come to a shuddering, cunt-clenching orgasm.", false);
			if (player.totalCocks() > 0) outputText("Your " + player.cockDescript(0) + " splatters cock-cream into his hair, further humiliating him.", false);
			outputText("\r\r", false);
		}
		else {
			outputText("You spread your " + player.legs() + " and expose your " + player.cockDescript(0) + ".  \"<i>Lick it, bitch,</i>\" you command.   When he doesn't, you give the rope a pull, and his hooves paw at the dirt in pain.  \"<i>I said LICK!</i>\" you scream, and this time he does.  His slightly rough tongue slides up and down your length, gingerly tasting your prick-skin.  \"<i>Take it deep,</i>\" you sigh, and he complies, no longer capable of any form of resistance.  He opens wide and buries his face into your crotch ", false);
			if (player.cocks[0].cockLength < 10) outputText("taking the entire thing easily as his tongue licks you to ", false);
			else if (player.cocks[0].cockLength < 25) outputText("taking the entire thing deep into his throat.  Apparently centaurs lack a gag-reflex, and you can see his throat stretched around you as you're brought to ", false);
			else outputText("taking as much as he can deep into his throat.  Even though his entire neck is distorted by your massive member, his throat simply isn't long enough to take any more.  You writhe as the throat-fucking brings you to ", false);
			outputText("an explosive orgasm.  You deposit your cream directly into his belly, making him burp when you pull out, dripping on the centaur's abused lips.\r\r", false);
		}
		outputText("Taking pity on him, you turn and release the rope, shoving his exhausted body over.  He hits the ground hard and his tightly bound cock bounces in the dirt underneath him.  You gingerly untie the bulging centaur-shaft, noting how massively bloated it is with pent up arousal.  As each layer of rope is peeled off, cum starts to leak from him in greater and greater quantities.  With the release of the last knot, he begins spurting helplessly.  You pat his flank and say, \"<i>Good bitch.  Now why don't you go find some succubus milk so you can look the part?</i>\"\r\r", false);
		outputText("You redress before the comatose centaur gets a chance to come to his senses, and wonder if he'll recover enough of his pride to face you again.", false);
	}
	player.orgasm();
	dynStats("int", 2, "cor", 4);
	player.createStatusEffect(StatusEffects.KeltOff,0,0,0,0);
	doNext(camp.returnToCampUseOneHour);
}
}
}
