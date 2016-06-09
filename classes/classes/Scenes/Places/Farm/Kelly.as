package classes.Scenes.Places.Farm{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.GlobalFlags.kGAMECLASS;

	public class Kelly extends AbstractFarmContent implements TimeAwareInterface {

//const KELT_BREAK_LEVEL:int = 725;
//const KELLY_CUNT_TYPE:int = 726;
//const NEVER_RESIST_KELT:int = 727;
//const WHITNEY_FLIPPED_OUT_OVER_KELLY:int = 728;
//const TIMES_PUNISHED_KELLY:int = 729;
//const TIMES_RIM_JOBBED_BY_KELLY:int = 730;
//const TIMES_RIDDEN_KELLY_FOR_PUNISHMENT:int = 731;
//const KELLY_BONUS_TIT_ROWS:int = 732;
//const KELLY_LACTATING:int = 733;
//const KELLY_DISOBEYING_COUNTER:int = 734;
//const KELLY_VAGINALLY_FUCKED_COUNT:int = 735;
//const KELLY_BONUS_BOOB_ROWS:int = 904;
//const KELLY_INCUBATION:int = 905;
//const KELLY_TIMES_PEPPERED:int = 906;
//const KELLY_HEAT_TIME:int = 907;
//const KELLY_KIDS:int = 908;
//const KELLY_FIRST_KID_GENDER:int = 909;
//const KELLY_HAIR_COLOR:int = 976;
//const KELLY_TALK_N_HAND_TIMES:int = 977;
//const KELLY_TIMES_REWARDED:int = 978;
//const KELLY_TIMES_DIED_HAIR:int = 979;
//const KELLY_TIMES_APPLESAUCED:int = 980;
//const KELLY_REWARD_COOLDOWN:int = 981;
//Items
//Besides, the PC needs 15 succubi Milk to turn Kelt female. If the PC has a pink egg, only 10 are needed. If the PC has a large pink egg (or two pink eggs), only 5 are needed. 

//Effects
/*You can start mind-breaking Kelt as soon as he's done with your first lesson and you meet the above requirements.
Kelt will first try to turn himself back male, in order to continue the mind breaking process you need to keep your stats at the same level or above and get more succubi milk.

Every encounter raises corruption by 5, except the last one that raises corruption by 8. In order to achieve the last encounter your corruption level must not be lower than it was at the third encounter.*/

		public var pregnancy:PregnancyStore;

		public function Kelly()
		{
			pregnancy = new PregnancyStore(kFLAGS.KELLY_PREGNANCY_TYPE, kFLAGS.KELLY_INCUBATION, 0, 0);
			pregnancy.addPregnancyEventSet(PregnancyStore.PREGNANCY_PLAYER, 280, 200, 100);
												//Event: 0 (= not pregnant),  1,   2,   3,  4 (< 100)
			CoC.timeAwareClassAdd(this);
		}

		//Implementation of TimeAwareInterface
		public function timeChange():Boolean
		{
			pregnancy.pregnancyAdvance();
			trace("\nKelly time change: Time is " + model.time.hours + ", incubation: " + pregnancy.incubation + ", event: " + pregnancy.event);
			if (model.time.hours > 23) {
				if (flags[kFLAGS.KELLY_REWARD_COOLDOWN] > 0 && model.time.days % 3 == 0) flags[kFLAGS.KELLY_REWARD_COOLDOWN] = 0;
				if (flags[kFLAGS.KELT_BREAK_LEVEL] >= 4) flags[kFLAGS.KELLY_DISOBEYING_COUNTER]++;
			}
			if (pregnancy.isPregnant && pregnancy.incubation == 0) {
				kellyPopsOutARunt();
				pregnancy.knockUpForce(); //Clear Pregnancy
				return true;
			}
			return false;
		}
	
		public function timeChangeLarge():Boolean {
			return false;
		}
		//End of Interface Implementation
		
private function hasPinkEgg():Boolean {
	return (player.hasItem(consumables.PINKEGG) || player.hasItem(consumables.L_PNKEG));
}

//Encounters
//First encounter
public function breakingKeltOptions():void {
	clearOutput();
	spriteSelect(35);
	if ((!player.hasCock() && flags[kFLAGS.KELT_BREAK_LEVEL] == 0) ||flags[kFLAGS.NEVER_RESIST_KELT] == 1 || player.statusEffectv2(StatusEffects.Kelt) >= 40 || player.findStatusEffect(StatusEffects.Kelt) < 0) {
		farm.keltScene.keltEncounter();
		return;
	}
	if (flags[kFLAGS.KELT_BREAK_LEVEL] > 0) {
		if (!player.hasCock()) {
			outputText("You can't keep trying to break Kelt without the proper tool to do it with.");
			menu();
			addButton(0,"Next",farm.farmExploreEncounter);
			return;
		}
		resistKeltsBSBreakHimIntro();
		return;
	}
	outputText("Having met Kelt, you know he's liable to subject you to plenty of abuse in exchange for training.  Are you going to endure it, resist, or never resist?");
	menu();
	addButton(0,"Endure",farm.keltScene.keltEncounter);
	addButton(1,"Resist",resistKeltsBSBreakHimIntro);
	addButton(2,"Never",neverBreakKeltIntoKelly);
	addButton(4,"FIGHT!",fightToBeatKelt);
}

public function fightToBeatKelt():void {
	outputText("Deciding you've had enough with Kelt, you ready your " + player.weaponName + ". Kelt readies his bow. \"<i>Do you really think you can beat me, slut?</i>\"", true);
	flags[kFLAGS.KELT_KILL_PLAN] = 1;
	startCombat(new Kelt());
}

//Resist
private function resistKeltsBSBreakHimIntro():void {
	clearOutput();
	spriteSelect(35);
	if (flags[kFLAGS.KELT_BREAK_LEVEL] == 0) {
		outputText("You are more and more annoyed by Kelt's rudeness and dick-waving.  The centaur may be imposing at first and his archery skills are impressive, but you're sure that behind his false display of virility, there's nothing an experienced champion like you can't deal with.  With your superior strength and speed, you could probably take him by surprise and teach him a good lesson.  Of course, you won't ever be able to learn archery from him after that.");
		//[if (PC doesn't have items)
		if (!(player.hasItem(consumables.SUCMILK,15) || (player.hasItem(consumables.SUCMILK,10) && hasPinkEgg()) || (player.hasItem(consumables.P_S_MLK,10) && hasPinkEgg()) || player.hasItem(consumables.P_S_MLK,15))) {
			outputText(" Unfortunately, you don't have anything that could be useful to tame his arrogant maleness.  You want items that would make his disgracious horsecock and balls shrink.  A nice set of breasts on his human chest would be fine, too.  You know you're going to need A LOT of such items - or very potent ones.");
			menu();
			addButton(0,"Next",farm.farmExploreEncounter);
		}
		else {
			outputText("\n\nDo you take his maleness down and teach him the lesson he deserves?");
			//Yes/Not Yet/Never
			menu();
			addButton(0,"Yes",breakKeltGo);
			addButton(1,"Not Yet",farm.farmExploreEncounter);
			addButton(2,"Never",neverBreakKeltIntoKelly);
		}
	}
	else if (flags[kFLAGS.KELT_BREAK_LEVEL] == 1) {
		outputText("You set out to go get Kelt, eager to teach this slut another lesson of your own.  You explore the farm for a bit before spotting the centaur behind the barn.  However, Kelt seems to have changed since last time: he somehow changed back his gender.  That rebellious little bitch!  Although he doesn't look as aggressively masculine as before, and his chest still bears some man-tits, he has gotten back his stern, rude face and you can clearly see a fat prick hanging from his backside.  It doesn't seem to be as big as it was before, though.  He must have grown it in a hurry.");
		//back to farm]
		//[if you don't have the items:
		if (!(player.hasItem(consumables.SUCMILK,10) || player.hasItem(consumables.P_S_MLK,10) || (player.hasItem(consumables.SUCMILK,5) && hasPinkEgg()) || (player.hasItem(consumables.P_S_MLK,5) && hasPinkEgg()))) {
			outputText("\n\nYou'd gladly teach him another lesson so he can keep his true gender and learn his place, but you don't have anything to turn him female again.  You should fetch appropriate items to begin the 'lesson'.</i>\"");
			//back to farm]
			menu();
			addButton(0,"Next",farm.farmExploreEncounter);
			return;
		}
		menu();
		addButton(0,"Next",secondKeltBreaking);
	}
	//Third encounter
	else if (flags[kFLAGS.KELT_BREAK_LEVEL] == 2) {
		outputText("You saunter up to the back of the farm, eager to meet the centaur-slut for another 'lesson'.  The creature is quite a weird sight when you spot her: instead of the gorgeous woman whose face you had splattered with spooge, what you see is an androgynous hybrid sporting a tiny, ridiculous microdick and a little pair of tits that can't fill more than a B-cup bra.  Even the face is ambiguous about its gender.  Although Kelly is now strong in the centaur's body, Kelt seems to have regained a little control.  You have to fix this.");
		//[if (less than 5 succubi milk)
		if (!(player.hasItem(consumables.SUCMILK,5) || player.hasItem(consumables.P_S_MLK,5)))
		{
			outputText("You must acquire enough Succubi Milk to remove any male remnants off Kelly's body before confronting 'him' again.");
			menu();
			addButton(0,"Next",farm.farmExploreEncounter);
			return;
		}
		outputText("\n\nYou casually approach the centaur, shaking a vial of Succubi milk with a broad grin; your intentions are clear.  Kelt whinnies, his voice higher than ever, \"<i>Not again!</i>\"  A puff of a very feminine odor reaches your nostrils - nothing at all like the masculine scent he usually exudes.  Is he coming to like this?");
		outputText("\n\nYou don't have time to consider it any further - Kelt draws his bow, ready to fight!");
		//[Start Combat]
		startCombat(new Kelt());
		spriteSelect(35);
	}
	else if (flags[kFLAGS.KELT_BREAK_LEVEL] == 3) {
		spriteSelect(-1);
		finalKeltBreaking();
	}
	else {
		spriteSelect(-1);
		approachKelly();
	}
}



//Never: the PC will never be asked that question again, forever locking the quest.
//Not Now: Nothing happens. The PC may carry on lessons like normal and they can still begin the mind-breaking process whenever they wish as long as they meet the above requirements.
//Yes: Carry on the mindbreak

private function neverBreakKeltIntoKelly():void {
	clearOutput();
	spriteSelect(35);
	flags[kFLAGS.NEVER_RESIST_KELT] = 1;
	outputText("You decide that trying to break Kelt is something you'd never want to do.  Besides, he's teaching you a useful skill, and there's just something charming about that bastard...");
	menu();
	addButton(0,"Go To Kelt",farm.keltScene.keltEncounter);
	addButton(1,"Go Home",camp.returnToCampUseOneHour);
}


private function breakKeltGo():void {
	clearOutput();
	spriteSelect(35);
	outputText("You approach the uppity centaur with glinting eyes, determined to take him down.  Kelt mistakes your anger for desire and sneers.");
	
	outputText("\n\n\"<i>What do you want, you little "+ player.mf("sissy", "bitch") +"?  I'm done with you.  I'm already doing you a favor by teaching you a skill sluts like you will never use nor master.</i>\"");
	
	outputText("\n\nWith a cold, calm voice, you inform him that you don't want to learn archery from him anymore.");
	
	outputText("\n\n\"<i>Fine.  Why don't you just fuck off then? I don't have time to waste with bitchy sluts.  Unless you're craving my cock?  Is that why you're still staring at me like you're going to jump me at any second?  A good centaur dick, right down your throat, that's what you-</i>\"");
	
	outputText("\n\nWHAM!  ");
	if (player.tallness < 70) outputText("You jump up, and y");
	else outputText("Y");
	outputText("our [weapon] hits Kelt's forehead, knocking him back.  He didn't even dodge or defend himself; the hit brought him down immediately.");
	
	outputText("\n\nYou make sure he's knocked out and start dragging him toward the nearby barn.  His centaur body is incredibly heavy, but ultimately, it's no match for your strength.  It only takes a couple of minutes to bring him to a hidden spot in the barn, just behind a haystack.  No one will see you here.");
	
	outputText("\n\nThe floor is strewn with all kinds of ropes.  So, you grab some and tie him up while he's still unconscious.  You bind his forelegs, his hind legs and his arms to make sure he can't escape.  Then, you slip out of the barn to fetch a funnel: you find a few near Whitney's milking machines and scoop one out.  When you're back, ready for Kelt's lesson, he has already awakened.  The equine beast is thrashing and yanking at his restraints, to no avail.");
	
	outputText("\n\n\"<i>What the fuck are you doing?  Where am I?  I swear, I'm going to wreck your ass when I get out of this-</i>\"");
	
	outputText("\n\n\"<i>I've noticed how you keep talking about fucking.  Whether it is sucking cock or taking it in the ass, you just won't shut up about it - not to mention how hard you are when you see me.  You think I didn't notice that aroused musk whenever I got close to you?  You think I didn't see your mammoth erection popping out during our \"<i>archery lesson</i>\"?  You stink of lust, you man-whore.  So, I was wondering: could it be that you are the one craving a big fat dick in your throat?  Hence... this little lesson... this experiment.</i>\"");
	
	outputText("\n\nWith a cruel smile, you pull all your bottles of Succubi Milk out of your pouches");
	if (hasPinkEgg()) {
		outputText(", as well as the egg");
	}
	outputText(".  You grab a nearby keg and pour down vial after vial until it's half-full.  The creamy substance exudes strong female scents that arouse both of you.");
	
	if (hasPinkEgg()) {
		outputText("  You then throw the egg into the keg before stirring the whole mixture, grinning as you prepare Kelt a whole new meal.");
	}

	outputText("\n\n\"<i>No, No - Fuck, no.  I know what you're going to do.  Don't even - don't even try.</i>\"");
	
	//Skip ()s if PC was naked before engaging in the mindbreaking quest
	outputText("\n\nYou keep stirring the ivory fluid, ");
	if (!player.isTaur()) outputText("pulling [eachCock] out of your [armor] and stroking yourself with your free hand");
	else {
		outputText("slapping your hardening dick");
		if (player.cockTotal() > 1) outputText("s");
		outputText(" against your belly in anticipation");
	}
	outputText(".  You might as well add some flavor to the meal.");
	
	outputText("\n\n\"<i>You can't just tie me up and make me swallow a bunch of shit.  That's just... not the way it works - not here.  I'm serious, don't do it.  You will regret it.</i>\"");
	
	if (player.isTaur()) outputText("\n\nAs you masturbate the way only a half-horse can,");
	else outputText("\n\nAs you touch yourself,");
	outputText(" small droplets of pre-cum begin dripping out of your " + player.multiCockDescriptLight() + " before being swallowed by the potent, feminine mixture down below.  The white spots are drowning in that milky goo, but you're confident that Kelt will be able to recognize the taste.");
	
	outputText("\n\n\"<i>Hey dipshit - I have a job here, and if you do this, you're going to fuck shit up for everybody.  Not to mention, I'm gonna come back and kick your ass once I get loose!  Besides, I've got a few sluts that need tending to.</i>\"");
	
	outputText("\n\nWhen you've leaked a sufficient amount of pre, you stop masturbating.  [EachCock] is already rock-hard, and you will have to put ");
	if (player.cockTotal() == 1) outputText("it");
	else outputText("them");
	outputText(" to use later.  You lift the keg and walk up to Kelt.");
	
	outputText("\n\n\"<i>Several 'wives', right?  How many people did you trick into getting accustomed to your unholy aura?  Did you actually think your centaur musk would get me on my knees and make me suck your dick like one of the countless sluts you've had?  Actually, I'm sure your 'wives' wouldn't mind seeing you feel what it's like to be a breeder.</i>\"");
	
	outputText("\n\n\"<i>To be a WHAT?  No!  No!  Don't fucking do this!  Don't d-MMMPH!</i>\"");
	
	outputText("\n\nYou shove the funnel up his mouth and finally end his useless quibbling.  Kelt bucks around violently in a desperate attempt to break his bonds, but he's helpless as you bring the milk keg to the funnel and begin pouring the demonic substance down his throat.  Unable to spit or gargle, he swallows it all, even as the potency of the feminizing potion begins to kick in.");
	
	outputText("\n\nThe effects are strong and swift.  His naked chest burgeons and expands: wave after wave of flesh added until it fully grows into a nice, big pair of breasts.  His facial features soften, his lips thicken and become soft, plump even.  His body hair shrinks and falls off, his coarse hands and arms becoming frail and delicate.  Even his voice gradually shifts as he drinks, the pitch of his moans becoming higher and higher.  When the transformation has taken full effect, the creature standing before you is now a lovely young centauress with a pair of womanly hips, squeezable E-cup breasts, and the most adorable face.  Instead of that aggressive, rutting male musk, she now exudes a powerful scent evoking that of a mare in heat.  Too thin to be held by your restraints, her arms slip out, and she begins to cry, covering her new face with her hands.  The only thing in common with that old bastard is her eyes: even adorned with cute, fluttering eyelashes, you can see the same glint of defiance and fear, albeit mixed with arousal now.");
	
	outputText("\n\nYou look down to check on the centaur's genitals, confirming what you've expected: the erect prick and heavy, hanging ballsack are gone, only to be replaced by a shining and rather enticing pussy.  It looks rather human in appearance, probably because of the potion that grew it.  Despite still being virginal, it drips abundant rivulets of moisture.");
	
	outputText("\n\n\"<i>What have you done to me?!</i>\"  Even the sound of her sobs is delightful to hear, as they're far from the rude, heavy tone the male Kelt used to insult you with.");
	
	outputText("\n\n\"<i>Shh... it's for your own good.</i>\"");
	
	outputText("\n\nWith a disarming smirk, you ");
	if (!player.isTaur()) outputText("fully whip out your [cock biggest] and shove it between her busty tits and slowly start grinding");
	else outputText("step over her, shoving your [cock biggest] between her busty tits, grinding it through that smooth valley");
	outputText(".");
	
	outputText("\n\n\"<i>Get... get your junk away from me!</i>\"  Her voice sounds so girlish and cute now, and you can't help but laugh at her protests.  You stare at her incredulously.  \"<i>You say that as if you weren't going to suck it right now.</i>\"");
	
	outputText("\n\nThe slut breaks eye-contact uncomfortably, before looking ");
	if (player.isTaur()) outputText("back ");
	outputText("down ");
	if (player.isTaur()) outputText("under you ");
	outputText("at your [cock biggest], still pressing against her heavy chest. She looks back up, fear and shame in her eyes, then back at your [cock biggest].  She then sticks her tongue out, understanding she has no choice but to endure this, and whimpers as she gets closer to your tip, giving it only a very quick lick.  Some time passes before she gives it another timid one.  Then another one, this time longer than the last.  Then a fourth one, bolder.  She goes little by little, but you can tell she's gradually getting accustomed to your own dick-scent.  You soon lose count of how often she licks your [cock biggest], and she never stops, as if she were somehow drawn to it - maybe that succubi milk was just what she needed.");
	
	outputText("\n\nA few minutes later, she wraps her tongue around your length like a proper cocksucker, never daring to make eye-contact as she blows you.  Her tongue was tickling at first, but now you're starting to enjoy her tongue-fondling on your dick.  You encourage her, telling her to use her whole mouth.  She nods and sobs before holding her breath and trying to deepthroat you.  The first attempt fails pathetically: not used to dick-flesh knocking at the back of her throat, she drools helplessly as she spits back your meaty rod.  Annoyed at her clumsiness, you ");
	if (player.isTaur()) outputText("dance your hindlegs about in order to ");
	outputText("cockslap her.");
	
	outputText("\n\n\"<i>You bitch!  That's not how it's done!  How can you be of any use as a cocksucker if you can't even suck cock right?</i>\"");
	
	outputText("\n\nShe whines a miserable apology before trying to take you again in her mouth.");
	
	outputText("\n\n\"<i>No.  Since you can't suck cock to save your life, you are unfit to receive my cum.  Use these instead,</i>\" you suggest, pointing at her luxurious chest.  \"<i>You left me unsatisfied with your failed deepthroat, and the gods know I could use a proper tit-job.</i>\"");
	
	outputText("\n\nThe centauress nods weakly and proceeds to wrap her bountiful flesh orbs around your [cock biggest].  She is as awkward as she was with her mouth, but you don't actually need her to fuck her tits.  Groaning in frustrated lust, you ");
	if (player.isTaur()) outputText("step over her, moving your hips back and forth to thrust through her more-than-ample cleavage.");
	else outputText("grab her nipples and begin to thrust your pecker against her boob valley.");
	outputText("  She occasionally gives your tip a wet kiss, trying to make up for her mistakes.  You ignore her and thrust harder, her round melons squeezing your shaft rhythmically.");
	
	outputText("\n\nEventually the pressure and your desire are too much to bear, and you climax with a raging grunt.  You watch with fascination the globs of semen being blasted on her beautiful face as you cum hard.  She cries softly in humiliation, but her own lusty eyes betray her.  Before they are covered with spooge, that is.  You never let go of her tits until you've shot the last of your jizz-rope.  When you're done with her, she is a dripping polluted mess; even her torso is covered with white splotches.  You notice that her tongue unconsciously slurps all the stains around her mouth, too.  Her sudden thirst for your cum must come from the pre you've poured into her 'meal'. Somehow she is still crying even as her eyes are blinded by your seed.");
	
	outputText("\n\n\"<i>Well, that was mediocre.  When I come back you better be able to give a decent blowjob.  Until then, piss off, slut.</i>\"");
	
	outputText("\n\nYou walk away before she can uncover her eyes; you don't have any business here now that you've used her.");
	//consume items for 1x scene.
	if (hasPinkEgg()) {
		if (player.hasItem(consumables.PINKEGG)) player.consumeItem(consumables.PINKEGG);
		else player.consumeItem(consumables.L_PNKEG);
		if (player.hasItem(consumables.SUCMILK,10))
			player.consumeItem(consumables.SUCMILK,10);
		else 
			player.consumeItem(consumables.P_S_MLK,10);

	}
	else
	{
		if (player.hasItem(consumables.SUCMILK,15))
			player.consumeItem(consumables.SUCMILK,15);
		else 
			player.consumeItem(consumables.P_S_MLK,15);
	}
		
	player.orgasm();
	dynStats("cor", 5);
	flags[kFLAGS.KELT_BREAK_LEVEL] = 1;
	doNext(camp.returnToCampUseOneHour);
}

//Second encounter
/*10 succubi milk (or 1 pink egg - large or small - and 5 succubi milk) */
private function secondKeltBreaking():void {
	clearOutput();
	spriteSelect(35);
	outputText("You stroll up to Kelt, not afraid to tame the beastman a second time.  As soon as he spots you, he snorts and tramples the floor furiously.  At the same time, he turns his head back as if he was ready to gallop at any moment.  Torn between his fear of you and his desire for revenge, he doesn't dare charge you, but he doesn't move away either.  You profit from his indecision to walk straight up to him until you are face to face.  But his masculine visage doesn't appeal to you, for your main focus is the tool hanging between his hind legs.");
	
	outputText("\n\nYou point at it and laugh.");
	
	outputText("\n\n\"<i>Awww, look at that!  The little slut is trying to be a big bad boy again... ain't that sweet?  Do you know it would look great on a girl?  I imagine you tried to be cute because there's no way that little finger would be a substitute for a proper dong.</i>\"");
	
	outputText("\n\n\"<i>You... you fucking bastard.  YOU made it like this!</i>\"");
	
	outputText("\n\n\"<i>No, you did.  Last time I checked you were an eager big-tittied whore lusting after my cock.  You cried because you couldn't deepthroat it properly, remember?</i>\"");
	
	outputText("\n\n\"<i>You sneaky little prick, I'm going to make you pay for this.</i>\"");
	
	outputText("\n\nIt's a fight!");
	startCombat(new Kelt());
	spriteSelect(35);
}


//Defeat Him In Fight #1
internal function defeatKellyNDBREAKHIM():void {
	clearOutput();
	//Cut these: You swing your [weapon], ready to use force against the restless centaur if necessary.
	//Cut these: \"<i>Easy now, okay? You don't have your bow, and you know what I can do with my [weapon]. Now if you just calm down I promise I'll be much nicer this time.</i>\"
	//lust/HP: 
	if (monster.lust >= monster.eMaxLust()) outputText("Kelt moans, mauling at his mantits in his lust before he realizes what's going on");
	else outputText("Kelt groans, slumping slightly from all the damage you've done to him");
	outputText(".  You close in, saying, \"<i>Easy now, okay?  You know what I can do with my [weapon].  Now if you just calm down, I promise I'll be much nicer this time.</i>\"");
	
	outputText("\n\nHe slowly retreats as you advance, snorting and grumbling as he does so.  Suddenly, he turns around and storms off in the fence's direction, with the obvious intention to escape.");
	
	outputText("\n\nLike hell! You aren't going to let him slip away like that.  ");
	//NO NEW PG.  FORK FOR CENTAURS AND NON}
	//NON CENTAURS}
	if (!player.isTaur()) {
		outputText("Of course, your speed is no match to that of a four-legged warrior, but you don't actually need to outrun him.  You rush to Kelt's hindquarters and lunge at him, managing to get a good grip on his flanks.  You wriggle a bit in order to adopt a more comfortable position but a few seconds later you're on his back, effectively mounting him.");
		outputText("\n\nNeedless to say, Kelt doesn't like this at all.  He arches his back, rears back, and fidgets repeatedly in desperate attempts to get you off him, but you latch on firmly.  Seeing that he won't get rid of you easily, he becomes enraged.  He snorts, whinnies and shakes his back like a horse gone crazy.  You do your best to cling to his neck and never let go of him, determined to tame the beast.  You let him exhaust himself, riding him out as his fits of rage become less and less violent.  At last he drops on his legs, yielding to you.");
		
		outputText("\n\nSatisfied, you unmount him and begin to drag him again to the barn.  ");
	}
	//CENTAURS
	else {
		outputText("Of course, you can keep up with the four-legged warrior as a centaur yourself, but you don't actually need to outrun him - not for long.  You come up alongside the defeated archer and lean into him, pushing to the side and causing him to flounder in the mud, hooves flailing.  He can barely even try to right himself before you're towering overtop of him and looking down victoriously.");
		
		outputText("\n\nKicking him for good measure, you quickly grab a loop of rope from a nearby fence and return, looping it around the beaten bully's body.  He staggers up as you begin to pull, morosely allowing himself to be led into the barn for another lesson.  You do your best to keep the impromptu leash tight, determined to tame this beast.  At times he struggles, but you let him completely exhaust himself.  ");
	}
	//MERGE BACK - ALL PATHS
	outputText("Kelt hardly shows any resistance, sometimes walking, sometimes letting himself be hauled like a beast of burden.  When you reach the barn, he's too tired to oppose you as you tie him up again.  When he's fully bound again, you remove your [armor] and pull out your items, ready to prepare another 'meal' for the centaur.  You empty all your bottles in the keg you used last time; in your haste, some of your sweat drips into the container, but you shrug it off.  After all, the bitch is going to get accustomed to your bodily fluids in one way or another.");
	
	outputText("\n\nYou grab the funnel and put it in his mouth, smirking.  \"<i>Now you should be familiar with this. Since you decided to be an obstinate bitch, this is going to be rough.  I really hope that you've improved since last time.</i>\"");
	
	outputText("\n\nKelt doesn't reply; the only thing that comes out of his mouth is a choking noise as you make him chug down your milky potion.  Since he's retained some feminine features, not much is needed to transform him back into the lovely female you titty-fucked last time.  His cock and balls quickly shrink back to his groin flesh, and his tits grow even further than they did before.  When he's done gulping the last drop of milk, your little cocksucking slut is back.  She's crying again, but you don't care.  She'll get used to it.");
	
	outputText("\n\n\"<i>There, that's much better.  You look beautiful when you're a girl, did you know that?  Now I should find a proper name for you, Kelt is no fit name for a fine woman like you.  What about Kelly? Shouldn't be too hard to remember, even for a dumb slut like you.  What do you think, Kelly?</i>\"");
	
	outputText("\n\nThe centauress doesn't respond, still sobbing.  You grow impatient and slap her with your [cock biggest].");
	
	outputText("\n\n\"<i>Answer, you wench!  Your rightful [master] asked you a question.  Do you like the name Kelly?</i>\"");
	
	outputText("\n\nShe bursts into tears again, any attempt at a reply breaking off into another sob. You cockslap her repeatedly as you roar, \"<i>Do you think I have time to waste on whiny bitches like you?  You're even lucky I'm taking care of finding you a proper name.  I should call you Cumbucket or Sugarcunt because that's exactly what you are.  So what do you think?  Do you want to be called Cumbucket, Cumbucket?</i>\"");
	
	//(Silly:)
	if (silly() && kGAMECLASS.amilyScene.amilyFollower() && kGAMECLASS.amilyScene.amilyCorrupt()) outputText("\n\nSomewhere, Amily perks up, \"<i>[Master]?</i>\"  How many cumbuckets do you need anyway?");
	
	outputText("\n\nThe broken centauress manages to shake her head convulsively.  Satisfied, you stop slapping her.");
	
	outputText("\n\n\"<i>Good.  Kelly it is, then.</i>\"");
	
	outputText("\n\nWith a smile, you grab her head and ");
	if (player.isTaur()) outputText("push her underneath you towards");
	else outputText("pull her close to");
	outputText(" your erect " + player.multiCockDescriptLight() + ".");
	
	outputText("\n\n\"<i>The first time I let you get accustomed to the taste, now you know how it's done.  Get to work, bitch.</i>\"");
	
	outputText("\n\nWork she does, much faster than last time.  Instead of shyly poking your junk with her tongue, she gives it long, sweet slurps, using her hands to get a better grip");
	if (player.balls > 0) outputText(" and fondling your [balls] with great care");
	outputText(".  Her lips regularly wrap around your [cock biggest] in near-perfect sucking motions.  She's getting better at this.");

	outputText("\n\nGroaning an encouragement, you pull her head closer and pin it against your groin, putting the cocksucker to the test.  Amazingly, she manages to keep your wang inside for a few seconds.  You close your eyes and moan, your whole body receiving rippling waves of pleasure from your deepthroated meat.  This heavenly moment doesn't last long, unfortunately; unable to take any more dick-flesh, the whore coughs again and withdraws from your length.  Your pulsating [cock biggest] suddenly feels cold, even as the centauress slavers on it.");
	
	outputText("\n\n\"<i>Better, but still not enough.</i>\"  You ");
	if (!player.isTaur()) outputText("cock-");
	outputText("slap the bitch for good measure, but you don't really mean it, as you are still feeling the last tingles of pleasure from her deepthroating.  Kelly mumbles a nervous apology before taking you again in her mouth, trying to compensate by giving the sweetest dick-licking she can.  Unable to take you whole, she focuses on your tip, kissing it and caressing it with her tongue.  You can tell she's somewhat enjoying it too: her whining seems to have stopped somewhat and she is a little more passionate in her tongue slurps.");
	
	outputText("\n\nHer ministrations have a certain effect on you, but you need more than a few tickles from a cocksucker apprentice.  You pull ");
	if (player.isTaur()) outputText("your genitals and equine body back ");
	outputText("out of her mouth and grope her tits; since she couldn't deepthroat you for more than a few seconds, you won't give her your cum this time either.  However, as your hands knead the girl's soft melons, you can feel her nipples are noticeably stiffening.  Amused, you toy with them for a moment, twisting and tweaking them until you can hear Kelly sigh.  The sorrow on her face is gradually replaced by an expression of repressed, violent lust.  She's more than ready for her boob-job.");
	
	outputText("\n\nA ");
	if (player.isTaur()) outputText("quick step and ");
	outputText("heavy thrust");
	if (player.isTaur()) outputText(" later");
	outputText(", and your [cock biggest] is entrapped within Kelly's breast valley.  You grind against her chest, your tip repeatedly poking her mouth and forcing her to suck it.  However, the centauress does show a little more enthusiasm this time; she sometimes squeezes her tits on her own, and her lips are avidly clinging to your rod at every occasion they get.  You know the slut is starting to get off to it, even though she would never acknowledge it - for now.  This only makes you harder and hornier.");
	
	outputText("\n\nYou fuck her tits faster and faster until your [cock biggest] can't take any more boobflesh: it quivers on its own, the ultimate signal of your incoming climax.  Before you know it, you blast Kelly's face with your spooge.  A seemingly endless stream pours from your dong and paints the centaur-slut white, even moreso than before.  The few ropes that make it into her mouth are quickly swallowed down by the eager whore, and her tongue shamelessly slurps all the cum she can reach from her mouth.  She's getting addicted to your juices, wherever they come from.  A couple more days with this treatment and she'll turn into a complete cumslut, only craving your baby-batter.  This sure would be a nice change from the arrogant dick you used to see before, you think to yourself as you squeeze out the last drops of goo onto her face.");
	
	outputText("\n\nYou don't bother to speak anymore, just walking away as you pick up your [armor] and consider the future possibilities.  The bitch obviously enjoyed this 'lesson' more than she did last time.  Could it be that she's finally learning her true place?  Now all you need is another bunch of succubi milk, just in case the old Kelt within her stirs up in your absence...");
	player.orgasm();
	dynStats("cor", 5);
	//consume items for 1x scene.
	if (hasPinkEgg()) {
		if (player.hasItem(consumables.PINKEGG)) player.consumeItem(consumables.PINKEGG);
		else player.consumeItem(consumables.L_PNKEG);
		if (player.hasItem(consumables.SUCMILK,5))
			player.consumeItem(consumables.SUCMILK,5);
		else 
			player.consumeItem(consumables.P_S_MLK,5);

	}
	else 
	{

		if (player.hasItem(consumables.SUCMILK,10))
			player.consumeItem(consumables.SUCMILK,10);
		else 
			player.consumeItem(consumables.P_S_MLK,10);
	}

	player.orgasm();
	dynStats("cor", 5);
	flags[kFLAGS.KELT_BREAK_LEVEL] = 2;
	combat.cleanupAfterCombat();
}

//Win Second Fight (Third Feminizing Encounter):
internal function breakingKeltNumeroThree():void {
	clearOutput();
	if (monster.HP < 1) outputText("Slumping down, ");
	else outputText("Moaning, ");
	outputText("he doesn't attempt to escape or attack you.  Before he can do anything, you're already on him. His reactions appear to be a lot slower since he began discovering his new craving for your dick.  He just stares at you nervously, waiting for your next move.");
	
	outputText("\n\n\"<i>That's a shame.  Such a beautiful girl... and you ruined her.  You don't seem to have fully understood your place.  Fortunately I have here something to remind you.</i>\"");
	
	outputText("\n\nWithout further ado, you forcefully open his mouth and shove the bottle in it.  You jerk his head back by pulling his hair until the milky substance finally enters his digestive system.  Without waiting for the first effects, you pull him to the barn.");
	
	outputText("\n\n\"<i>Come on.  Let's go someplace more... private.</i>\"");
	
	outputText("\n\nThe beastman doesn't resist; he doesn't cooperate either.  He just meekly walks in your direction, following you until you reach the usual spot in the barn where you taught him his previous two 'lessons'.  He lets you bind him to the restraints, acting like a lifeless doll for you to manipulate as you wish.  However, you notice a faint spark of arousal in his eyes as you begin to undress yourself.");
	
	outputText("\n\nYou don't need any funnel to make him gulp down two more Succubi Milk vials.  Femininity is already powerfully ingrained in him due to your last two sessions, and when he's done drinking, Kelly is fully back.  You quickly check down below: no sign of any dick, no matter how absurdly small. On the other hand, a nice, young and fresh pussy is dripping with warm moisture.  Its pink presence seems to welcome you back.");
	
	outputText("\n\nYou look back at her and ask bluntly: \"<i>What's your name?</i>\"");
	
	outputText("\n\nShe remains silent.  She hasn't said a word since you spotted her, you remark.  But this time she's going to speak.  You pull her hair, slap her a few times - sometimes with your free hand");
	if (!player.isTaur()) outputText(", sometimes with your [cock] -");
	outputText(" and yell: \"<i>What's your name?</i>\"");
	
	outputText("\n\nThe slut finally gives in after a few slaps and screams.");
	
	outputText("\n\n\"<i>Kelll... y!  I'm Kelly!</i>\"");
	
	outputText("\n\n\"<i>What are you?</i>\"");
	
	outputText("\n\n\"<i>I'm a centaur... ess.  I'm your centauress.</i>\"");
	
	outputText("\n\n\"<i>Good.  What are you here for?</i>\"");
	
	outputText("\n\n\"<i>I'm here to suck your cock.  I'm here to take it whole.</i>\"");
	
	outputText("\n\n\"<i>Then what in Lethice's name are you waiting for?  It ain't gonna suck itself.</i>\"");
	
	outputText("\n\nShe tries to grip your [cock biggest] with her thin hands but you've grown too impatient: you vigorously force it through her lips and begin to fuck her face ruthlessly.  She coughs, drools and tries to scream, but you don't let her have any say in the matter.  You pump away, treating her mouth like a warm and wet onahole.  Your pecker is soon coated with her saliva and twitching with lust, but you don't care.  Besides, the slut is rapidly adapting to your [cock biggest].  Her tongue fondles you carefully, and her lips squeeze you as tightly as they can.  You can definitely tell her recent dick sucking experience made her skillful as a fellatrix. She'll make a good cumslut, you idly think as you move her head up and down your length.");
	
	outputText("\n\nYou decide to test Kelly once more; with a mighty ");
	if (player.isTaur()) outputText("push from behind");
	else outputText("pull");
	outputText(", you pin her head against your groin and shove your wang down her throat.  This time, the centauress doesn't seem to be hindered or about to choke.  She takes the entirety of your length and sucks you up like the good little whore she is.  Your entrapped cock is squeezed so tightly that you feel like it's about to explode; not willing to reach your climax so soon, you swiftly pull out of her mouth.");
	
	outputText("\n\n\"<i>That's better.  That's much better, Kelly.  Now you are a decent cocksucker.  But that's still not enough.  I am not content with meek obedience, nor even with the most abject submission.  When you suck my dick, it must be of your own free will.  I want you to crave it. I want you to grovel at my feet and beg for one more drop of my spunk.  When I finally give it to you, it must be the greatest present you've ever had.  I don't want you to try your damn best to please your [master]; I want you to get off to it.  Do you see what I mean?</i>\"");
	
outputText("\n\nKelly remains quiet for a couple of seconds before slowly muttering, \"<i>Please [Master], give me your cock.  I want nothing more in the world.  I'll squeeze you until you're milked dry.  Please, let me suck your dick!</i>\"");
	
	outputText("\n\n\"<i>You're making a great effort, slut.  But I know you're not genuine.  You're ready to be a good cumslut, but not my good cumslut.  But don't worry, I'll take care of this in a minute.  Now jerk me off.</i>\"");
	
	outputText("\n\nYou move [oneCock] toward her face as you speak.  The centaur girl nods silently before seizing a handful of your junk and slowly stroking it.  Her hands move along your length, rubbing and massaging all the sensitive points.  She tries to use her mouth too but you don't let her; instead, you have her point your meat toward the old keg you used before.  Kelly's eyes widen slightly as she understands what you have in mind, but she doesn't slow down the dick-stroking pace.  You close your eyes and enjoy the sensation of Kelly's delicate palm and fingers handling your dick-flesh with great care.");
	
	outputText("\n\nYou briskly reach ");
	if (player.isTaur()) outputText("down, pushing her");
	else outputText("forward to grab one of her tits and grope it");
	outputText(" convulsively as you feel your lust rise.  ");
	if (!player.isTaur()) outputText("Soon one breast isn't enough to contain your lust-driven energy and you reach for the other one with your free hand.  Your constant nipple-teasing has an effect on");
	else outputText("Soon, you cannot contain your lust, and you begin to buck against her hands, whinnying with delight.  The rigid, pulsing dick-flesh in her mouth has an effect on");
	outputText(" Kelly at last: you can hear her moan and sigh, and her hands move erratically on your " + player.multiCockDescriptLight() + ", sometimes violently yanking it as she loses control.  This brings all kinds of painful yet pleasurable tingles to your body, and only entices you to feel her up even more.");
	
	outputText("\n\nA familiar warmth builds in your loins ");
	if (player.balls > 0) outputText("and your [balls] churn ");
	outputText("as you feel your climax coming.  ");
	if (!player.isTaur()) outputText("You squeeze Kelly's boobs so harshly she screams in pain, and y");
	else outputText("Y");
	outputText("ou release a loud groan yourself.  You cum hard, your quivering [cock biggest] spraying spooge in steady jets directly into the keg.  You maintain your grip on the centauress");
	if (!player.isTaur()) outputText("' breasts");
	outputText(", heedless of her pain and only caring about your own orgasm.  You feel her soft hands squeezing your junk there and there in order to milk the last drop of cum and making sure none of it remains stuck in your urethra.  When you're done riding out your orgasm, you walk up to the keg and pour down the two bottles of Succubi Milk you have left.  The copious amount of baby-batter mixes with the alright-alabaster fluid to form a bubbling ivory mixture that you bring close to Kelly's lips.");
	
	outputText("\n\n\"<i>Drink.</i>\"");
	
	outputText("\n\nShe obeys, albeit a little too slowly.  Impatient, you lift the keg and forcibly make her gulp down the sticky substance until she can barely breathe.  You spill some juice to the side and onto her legs but she's drunk most of it.  The potion has quick effects on her, rapidly taking over her body and making feel her dizzy.");
	
	outputText("\n\n\"<i>Ohhh...</i>\" Her breasts expand further, her pussy drips even more rivulets in sheer arousal.  Her eyes roll back and her breath grows short as she stares longingly at you.  You marvel at the effects: she's finally being turned into a horny cumslut!  Now all you have to do is wait for her to digest the hefty potion and come back to deliver the last dose.");
	//consume items for 1x scene.

	if (player.hasItem(consumables.SUCMILK,5))
		player.consumeItem(consumables.SUCMILK,5);
	else 
		player.consumeItem(consumables.P_S_MLK,5);

	player.orgasm();
	dynStats("cor", 5);
	flags[kFLAGS.KELT_BREAK_LEVEL] = 3;
	combat.cleanupAfterCombat();
}

//Fourth encounter
/*This one requires you not to have lost any corruption since the last encounter you had with her (so if you did, just get back to your former corruption level).*/
private function finalKeltBreaking():void {
	clearOutput();
	outputText("You resolutely walk up to the centaur slut for her final lesson.  This time you don't even need to find her: she rushes to you on her own, her eyes glinting with need.");
	outputText("\n\n\"<i>[Master], [Master]!  You're finally here.  I-I haven't been sleeping well since you left.  I've been dreaming about you... about your cock.  I haven't been able to eat properly, it's like I'm in a state of constant hunger that can't be satisfied... except by you.</i>\"");
	
	outputText("\n\nWith a coy grin, you ask her what she wants from you.");
	
	outputText("\n\n\"<i>I want... I want your cum!  When you made me drink that potion, it felt like the most wonderful thing in the world, and I'd rather die than not be allowed to taste it ever again.  Please let me drink from you.  Fuck, I want your dick so bad!  Let me suck it, I promise I'll make you feel so good you'll give it all to me.</i>\"");
	
	outputText("\n\nYou laugh triumphantly as you whip your " + player.multiCockDescriptLight() + " out of your [armor]; the slut is more than ready!");
	
	outputText("\n\n\"<i>While you were busy whining like a whore my junk has been aching for a good blowjob; how about you stop talking and start sucking?</i>\"");
	
	outputText("\n\nThe centauress cries in excitement and ");
	if (player.isTaur()) outputText("kneels down");
	else outputText("bends over");
	outputText(" to reach for your [cock biggest].  She sucks with eagerness and passion; you don't even need to pull her head as it moves on its own around your length.  ");
	if (player.balls > 0) outputText("Her free hands moves down on your groin and caresses your [balls] with expert care and precision; obviously her previous experience in groping has had an effect on her current skills.  ");
	outputText("Her hunger for your meaty junk seems to be insatiable, for after moments of dick kissing and licking, she decides to take the entirety of your length.  Her eyes are voracious as her fat lips swallow inch after inch of dick-flesh.");
	
	outputText("\n\nYou savor this moment; your [cock biggest] is literally radiating with pleasure, and you find yourself staggering multiple times, your body almost unable to bear the sheer pleasure provided by the needy centaur-slut.  Her fingers cling to your ");
	if (player.isTaur()) outputText("hindleg haunches");
	else outputText("[butt]");
	outputText(", always pulling your groin closer to her avid mouth as she relentlessly throatfucks herself on you.  Your [cock biggest] is being squeezed and massaged in the most divine way as it knocks against her warm esophagus, and you're tempted to cum in her right now, right here. But you need to finish the 'lesson'; with great regret, you softly ");
	if (player.isTaur()) outputText("back away");
	else outputText("push the centaur girl away");
	outputText(" and pull out of her mouth. Wailing with displeasure, the cock-slut decides to give your meat a couple of sad licks, disappointed to see her phallic prize withdrawing from her.  She quickly regains her enthusiasm, however.");
	
	outputText("\n\nYou don't even need to tell her to use her boobs; after a while of dick slurping, she wraps them around your rod and pumps ferociously, her eyes filled with raw need.  After being slathered with hot saliva from the long deepthroating, her breasts make all kind of squelching noises as they repeatedly squeeze your [cock biggest].");
	if (!player.isTaur()) outputText("You grope her bountiful tits and pull them closer to you as you fuck them.  ");
	outputText("Her breast valley feels almost as tight as a vagina; and due to the generous amounts of drool coating your lance, it is almost as wet.  Moreover, Kelly is now openly moaning from the tit-job, as if you were actually fucking her.  She obviously has no shame anymore in letting everyone in the farm know how much she enjoys grinding her soft melons against a stranger's junk.  These thoughts make you dreamingly wonder what her virgin pussy feels like, and make you even stiffer.  With a lust-filled grunt, you thrust deeper, your dick-flesh fighting for every inch between the girl's busty tits.  Your genitals are now dangerously pulsating in arousal, threatening to cum at any time.");
	
	outputText("\n\nKelly is more than ready to be baptized as your personal centaur cumslut.  A pressure builds in your crotch, unmistakingly the signal of a coming orgasm.  Somehow you know this one is going to be much more powerful than usual, as it seems to boil furiously deep in your loins.  You're going to blast this bitch so full of spooge she'll be forever marked as yours. In the heat of impending climax, you yell, \"<i>What's your name, slut?</i>\"");
	
	outputText("\n\n\"<i>Kelly!  I'm Kelly!</i>\"");
	
	outputText("\n\n\"<i>What are you?</i>\"");
	
	outputText("\n\n\"<i>Your centauress slut!</i>\"");
	
	outputText("\n\n\"<i>What are you here for?</i>\"");
	
	outputText("\n\n\"<i>I'm here to suck your cock and to please you until you're milked dry.  I'm here to feed off your cum!</i>\"");
	
	outputText("\n\n\"<i>Good girl.  Take it all, bitch.");
	if (silly()) outputText("  CUM CANNON!");
	outputText("</i>\"  A familiar power gathers inside you, and you decide to tap into it.  You pull out of her tits and cum really, really hard.");
	
	outputText("\n\nA mighty fountain of spunk erupts from [eachCock].  Powered by your corruption, it rains down on Kelly's body and finds its way through every pore of her body.  You find yourself spraying more spooge jets than you thought yourself capable of, and somehow the entirety of Kelly is soon painted white and sticky with goo.  The slut raises her hands as if she wanted to gather some more, smiling beatifically as you baptize her.  You cum and cum, not even feeling the flow of seed at this point; you only ride out the endless orgasm as you turn the former archer into your eager personal slut.  Kelly lets out a very high-pitched screech, ecstasy taking over her body as it fully distorts into that of a female, utterly submissive creature.  You can actually feel the creature's already weakened aura shriveling and disappearing into oblivion.  The old Kelt is thoroughly erased from her; perhaps that cry was an ultimate protest against an unavoidable fate?  There's no way to know, as the newborn Kelly is now totally in control and screaming to the world how much she enjoys her orgasm.  The only thing you see is a busty centauress covered in ever-flowing white spunk; the only thing you hear is her loud and constant moaning.");
	
	outputText("\n\nThe cum-flow eventually starts to ebb; less and less goo pours from your " + player.multiCockDescriptLight() + " and your orgasm gradually fades out.  When your euphoric pleasure wears off, you finally get a good look at the creature standing before you.");

	outputText("\n\nShe doesn't seem to have changed much in appearance: she still sports the same nice pair of bouncy tits that seem to ask you to cup them with your hands, and her face is even more cutely feminine than ever.  Nevertheless, you can tell by subtle modifications of her body language that corruption has taken a good hold in her: the way her eyes glow with craving need, her moist pussy that drips seemingly unnatural amounts of juices, and her tail adopts shapes that remind you that of a demon.  Even the way she smiles shows that she feels more than meek pleasure in serving you.");
	
	outputText("\n\n\"<i>How can I please my [master]?  Maybe you'd like your meat to be licked clean?</i>\"");
	
	outputText("\n\n\"<i>Uhh... Yeah, I guess you can probably do that.</i>\"");
	
	outputText("\n\nBefore you even uttered the last word she's already bending over for your groin, slurping at it with wolfish appetite.  She stares at you with needy eyes as she cleans and swallows every last remaining bit of goo still staining your groin.  When she's done, you give her a good cockslap to remind her of her place.");
	
	outputText("\n\n\"<i>Today is an important day.  Today, you've learned your true place as a cumslut.  You've learned how to suck dick, how to please your [master], and most importantly, how to accept your place.  Did you notice how you came hard when you received my seed?  That's because you were finally discovering your true self: a cum-receptacle.  As long as you were resisting you could never feel real pleasure.  Look at what you used to be before: a whiny bitch that only licked with the most annoying reluctance.  Now compare that with what you are now: a good healthy slut that actually came from giving me head. Would you switch places with your former self?</i>\"");
	
	outputText("\n\n\"<i>Of course not, [Master]!  How could I?  I was a poor, repressed bitch in denial back then.  Now I just want to die for your dick.  It just feels... so right to milk it.</i>\"");
	
	outputText("\n\n\"<i>That's because it is right.  Your place is here.  As long as I have a drop of sperm left in my body, you'll never miss any occasion to slurp it, and you know it.</i>\"");
	
	outputText("\n\n\"<i>Never.</i>\"");
	
	outputText("\n\n\"<i>Good girl.</i>\"");
	
	outputText("\n\nSatisfied, you pat Kelly's butt and walk away, still recovering from the supernatural orgasm.  Now that you've acquired a new pet, there's a whole new range of possibilities that are open for you...");
	player.orgasm();
	dynStats("cor", 8);
	flags[kFLAGS.KELT_BREAK_LEVEL] = 4;
	doNext(camp.returnToCampUseOneHour);
}


//Kelt Defeats PC after 1st Breaking But Before Last
internal function keltFucksShitUp():void {
	clearOutput();
	outputText("As you collapse, defeated, Kelt saunters up, shouldering his bow.  \"<i>Who's the bitch now,</i>\" he taunts, rearing back as his voice cracks in a rather emasculated manner.  \"<i>You are!</i>\"  His hooves come down on your back, and concussive waves of pain roll through your body as you're trampled black and blue.  Then, you see blackness.");
	menu();
	addButton(0,"Next",keltFucksShitUpII);
	
}
private function keltFucksShitUpII():void {
	clearOutput();
	outputText("You awaken at the periphery of the farm, thankful to be alive.  Kelt is nowhere to be seen.  You have to wonder if Whitney saved you or the dumb beast was too stupid to finish you off.  Whatever the case, you head back to camp to lick your wounds.  ");
	if (!flags[kFLAGS.KELT_KILL_PLAN] == 1){
		outputText("<b>The worst indignity of all is that he broke a lot of your succubi milks.</b>  He'll likely have regained some more of his maleness by the time you're ready to attempt teaching him another lesson.");
		player.consumeItem(consumables.SUCMILK,5);
		
		//Roll Kelt back one obedience level - at the worst he drops to the level of the first fight
		flags[kFLAGS.KELT_BREAK_LEVEL]--;
		if (flags[kFLAGS.KELT_BREAK_LEVEL] < 1) flags[kFLAGS.KELT_BREAK_LEVEL] = 1;
	}
	combat.cleanupAfterCombat();
}


//Appearance
private function kellyAppearance():void {
	clearOutput();
	outputText("Kelly is a 6 foot 3 inch tall centauress with a svelte body and generous curves.  Her feminine face is pretty human in appearance, and her lovely traits would be adorably innocent if it weren't for her emerald eyes shining with lusty need whenever she looks at you.  Plump lips that seem to have been made for cock-sucking adorn her hungry mouth.  A long, single " + flags[kFLAGS.KELLY_HAIR_COLOR]);
	//[chestnut brown/sable black/garish purple/bright pink/slutty blonde) 
	outputText(" braid hangs between her shoulders, giving you easy leverage when you have your way with her.  Her torso is likewise human-looking, only stopping below her navel where her equine part starts growing.  She stands on four horse hooves, her lower body looking almost like a horse's- aside from the pointed " + flags[kFLAGS.KELLY_HAIR_COLOR] + " demon's tail which sprouts where her horse tail should, and her cute, pink, human-like asshole.");
	//[chestnut brown/sable black/garish purple/bright pink/slutty blonde]
	
	outputText("\n\nShe sports a pair of soft DD-cup breasts.  Each one is ornate with a 0.5 inch nipple, often rock-hard in arousal.");
	if (flags[kFLAGS.KELLY_BONUS_BOOB_ROWS] > 0) outputText("  Beneath those, she has a second row of jiggly tits, just aching to be squeezed.");
	if (pregnancy.isPregnant) outputText("  Drops of milk often dribble from her tits, betraying her potent lactation.");
	//[enter vagina text] 
	outputText("\n\nKelly has a ");
	//[virgin]
	if (flags[kFLAGS.KELLY_VAGINALLY_FUCKED_COUNT] == 0) outputText("virgin, ");
	if (flags[kFLAGS.KELLY_CUNT_TYPE] == 0) outputText("pink pussy");
	else outputText("puffy, black mare-cunt");
	outputText(" placed below her hindquarters.  It is almost constantly dripping rivulets of moisture when you're around.  Its shining openness seems to welcome you in her warmth.");
	if (flags[kFLAGS.KELLY_HEAT_TIME] > 0 && !pregnancy.isPregnant) outputText("<b>  There is so much leaking from her that you think she might be in heat, rendering her more receptive to impregnation.</b>");
	outputText("\n\nShe has a human-like asshole, placed right between her horse butt-cheeks where it belongs.");
	
	switch (pregnancy.event) {
		case 1: outputText("\n\n<b>Her barrel-like belly is bulging slightly more than it normally does.</b>");
				break;
		case 2: outputText("\n\n<b>Her pregnancy is becoming obvious, her horse belly more and more distended each day.</b>");
				break;
		case 3: outputText("\n\n<b>Her belly is swollen and often wiggles around as your rambunctious offspring moves inside her.</b>");
				break;
		case 4: outputText("\n\n<b>Her body is absolutely bloated with new life and she moves with a slow, deliberate sway.  Even her boobs and lips seem more swollen and sensitive than usual: her skin is flushed and her expression is one of deep, motherly content.  She can't be far from giving birth now.</b>");
				break;
		default:
	}
	if (farm.farmCorruption.hasTattoo("kelly"))
	{
		outputText("\n\n");
		if (farm.farmCorruption.kellyFullTribalTats())
		{
			outputText("She is covered from head to tail in tribal tattoos, erotic lines snaking all over her naked frame, giving her the look of a barely tamed savage.")
		}
		else
		{
			if (farm.farmCorruption.numTattoos("kelly") > 1) outputText("She has the following tattoos emblazoned across her body:\n");
			else outputText("She has ");

			if (flags[kFLAGS.KELLY_TATTOO_COLLARBONE] != 0) outputText(flags[kFLAGS.KELLY_TATTOO_COLLARBONE] + "\n");
			if (flags[kFLAGS.KELLY_TATTOO_SHOULDERS] != 0) outputText(flags[kFLAGS.KELLY_TATTOO_SHOULDERS] + "\n");
			if (flags[kFLAGS.KELLY_TATTOO_LOWERBACK] != 0) outputText(flags[kFLAGS.KELLY_TATTOO_LOWERBACK] + "\n");
			if (flags[kFLAGS.KELLY_TATTOO_BUTT] != 0) outputText(flags[kFLAGS.KELLY_TATTOO_BUTT] + "\n");
			outputText("\n");
		}
	}

	//Kids flavour text
	if (flags[kFLAGS.KELLY_KIDS] > 0) {
		if (flags[kFLAGS.KELLY_KIDS] == 1) {
			outputText("\nKelly's ");
			if (flags[kFLAGS.KELLY_FIRST_KID_GENDER] == 1) outputText("son");
			else outputText("daughter");
			outputText(" is off in a separate field; still very young, you can see ");
			if (flags[kFLAGS.KELLY_FIRST_KID_GENDER] == 1) outputText("him playing in the distance, lost in his own little world.");
			else outputText("her playing in the distance, lost in her own little world.");
		}
		else if (flags[kFLAGS.KELLY_KIDS] == 2) outputText("\n\nThe " + num2Text(flags[kFLAGS.KELLY_KIDS]) + " children you have had with Kelly are off in a separate field; the sound of their play drifts over the grasslands to your ears.  Kelly evidently prefers to keep her brood away from what you do with her, a remarkably sensible attitude coming from a centauress cumslut.  Maybe motherhood genuinely suits her?");
		else outputText("\n\nThe " + num2Text(flags[kFLAGS.KELLY_KIDS]) + " children you have had with Kelly are as ever off in a separate field, the distance sounds of their acting out the wars and drama of childhood drifting out over the grasslands to your ears.");
		outputText("\n");
	}
	menu();
	addButton(0,"Next",approachKelly);
}
private function approachKelly():void {
	clearOutput();
	//Fix hair color!
	if (flags[kFLAGS.KELLY_HAIR_COLOR] == 0) flags[kFLAGS.KELLY_HAIR_COLOR] = "chestnut brown";
	//PUNISH SCENES IF APPROPRIATE
	if (flags[kFLAGS.KELLY_VAGINALLY_FUCKED_COUNT] > 0 && flags[kFLAGS.TIMES_PUNISHED_KELLY] == 0 && rand(3) == 0 && player.hasCock()) {
		flags[kFLAGS.KELLY_DISOBEYING_COUNTER] = 0;
		punishKelly();
		return;
	}
	
	//Descriptions and Flavour Text
	if (flags[kFLAGS.FARM_CORRUPTION_STARTED] == 0) outputText("You aren't welcome on the farm proper, but you can go visit Kelly's field.");
	
	//09:00-11:00, 2 or more children:
	if (model.time.hours >= 9 && model.time.hours <= 11 && flags[kFLAGS.KELLY_KIDS] >= 2) {
		outputText("\n\nKelly is standing in the shadow of her barn, an expression of blissful contentment on her face as she nurses your ");
		if (flags[kFLAGS.KELLY_KIDS] > 2) outputText("two youngest ");
		outputText("children with ");
		if (flags[kFLAGS.KELLY_BONUS_BOOB_ROWS] > 0) outputText("the top row of ");
		outputText("her milk-laden tits.  When she dreamily opens her eyes and sees you standing there, she nudges them off gently.");
		outputText("\n\n\"<i>That's enough, little ones.  Mommy needs her daddy time now.</i>\"  Your two centaur children make grumpy 'awww's as they are pulled away from her oozing nipples, but they freeze when they turn around and see you, their milk slathered mouths open in a kind of awe.  They clop off in a hurry as Kelly rearranges her hair and gets up to greet you, the peace in her emerald eyes slowly burnt away by desire.");
	}
	//15:00-16:00, 4 or more children:
	else if (model.time.hours >= 15 && model.time.hours <= 16 && flags[kFLAGS.KELLY_KIDS] >= 4) {
		outputText("\n\nYou see Kelly standing in the middle of her field, surrounded by her children.  She has the butts set up and, judging by the way she is talking and gesturing with the bow in her hand, is teaching your brood how to shoot.  Trying to, anyway: her big, bare boobs make things a bit difficult.  You see she's actually gone to the trouble of constructing adorable little mini-bows, which the group of centaur children are all threading mini-arrows on as she points, and with expressions of deep concentration, pulling tight, taking aim, and... there's a cacophony of whistling, and arrows wind up everywhere but the target.  The sound of shouting and crying echoes across the field as Kelly begins to ball out the one who somehow managed to shoot an arrow through her braid.");
		outputText("\n\nYou decide to come back a bit later.  Your kids need all the help they can get.");
		doNext(camp.returnToCampUseOneHour);
		return;
	}
	//Standard:
	else {
		outputText("\n\nAs soon as you enter the big, grassy expanse beyond the barns, your centaur slave canters over, radiating happiness and hunger.");
		outputText("\n\n\"<i>[Master], you've come to visit! Is it feeding time?</i>\"");
	}	
	menu();
	addButton(0,"Appearance",kellyAppearance);
	if (player.lust < 33) outputText("\n<b>You aren't aroused enough to pursue sex with your toy right now.</b>");
	else addButton(1,"Sex",kellySexMenu);
	if (flags[kFLAGS.KELLY_CUNT_TYPE] == 0) {
		if (player.hasItem(consumables.EQUINUM)) {
			addButton(5,"Give Equinum",giveKellyEquinum);
			outputText("\nYou could give her equinum to gift her with a proper horse-cunt.");
		}
		else outputText("\nIf you had equinum, you could give her a proper horse-cunt.");
	}
	else if (flags[kFLAGS.KELLY_CUNT_TYPE] == 1) {
		if (player.hasItem(consumables.SUCMILK)) {
			addButton(5,"Give SucMilk",giveKellySuccubiMilk);
			outputText("\nYou could give her a succubi milk to get rid of that horse-pussy you gave her before.");
		}
		else outputText("\nIf you had succubi milk, you could use that to give her a more human-like vagina.");
	}
	if (player.hasItem(consumables.CANINEP)) {
		outputText("\nYou could give her a canine pepper");
		if (flags[kFLAGS.KELLY_BONUS_BOOB_ROWS] == 0) outputText(", but who knows how it will change her");
		outputText(".");
		addButton(6,"Give CanineP",giveKellyAPepper);
	}
	if (flags[kFLAGS.KELLY_VAGINALLY_FUCKED_COUNT] > 0 && flags[kFLAGS.KELLY_DISOBEYING_COUNTER] >= 3 && player.hasCock()) {
		outputText("\n<b>It looks like Kelly has taken to pleasuring herself again in your absense.  Do you want to take care of that?</b>");
		addButton(7,"Punish",punishKelly);
	}
	if (flags[kFLAGS.TIMES_PUNISHED_KELLY] > 0 && flags[kFLAGS.KELLY_REWARD_COOLDOWN] == 0 && rand(3) == 0) {
		outputText("\n<b>Kelly looks in fine spirits today. Perhaps she's done something worth getting a reward?</b>\n");
		addButton(8,"Reward",rewardKelly);
	}
	
	//Showing up resets Kelly's desire not to fap without you
	flags[kFLAGS.KELLY_DISOBEYING_COUNTER] = 0;

	if (flags[kFLAGS.FARM_CORRUPTION_STARTED] == 0)	addButton(14, "Leave", camp.returnToCampUseOneHour);
	else addButton(14, "Back", farm.farmCorruption.rootScene);
}

private function kellySexMenu():void {
	menu();
	if (player.hasCock() && player.lust >= 33) {
		if (player.cockThatFits(300) >= 0 || flags[kFLAGS.KELLY_CUNT_TYPE] == 1) {
			if (pregnancy.isPregnant) addButton(0,"Preg Fuck",kellyPregSex);
			else if (!player.isTaur()) addButton(0,"Fuck Cunt",fuckKellysCunt);
			else addButton(0,"Fuck Cunt",taurOnTaurSexKelly);
			if (flags[kFLAGS.KELLY_VAGINALLY_FUCKED_COUNT] == 0) addButton(0,"VirginFuck",takeKellysVirginity);
			if (player.countCocksOfType(CockTypesEnum.TENTACLE) >= 2) addButton(1,"TentaFuck",tentaFuckKelly);
		}
		else outputText("\n<b>You're too big to fuck her vagina.</b>");
		if (flags[kFLAGS.KELLY_BONUS_BOOB_ROWS] == 0 && player.cockThatFits(18,"length") < 0 && !player.isTaur()) {
			outputText("\n<b>You're too big to fuck her tits.  Maybe if you gave her something to make her grow more...</b>");
		}
		else if (!player.isTaur()) addButton(2,"Titfuck",kellyTitJob);
		addButton(3,"Blowjob",kellyBJsAhoy);
		addButton(4,"Talk And HJ",talkNHandToKelly);
	}
	addButton(14,"Back",approachKelly);
	
}
//Regular scenes
//Vaginal
//Virginity paragraph
//[Not Virginal]
private function fuckKellysCunt():void {
	clearOutput();
	flags[kFLAGS.KELLY_VAGINALLY_FUCKED_COUNT]++;
	var x:int = player.cockThatFits(300);
	if (x < 0) x = player.smallestCockIndex();
	outputText("You strip out of your [armor] in a hurry, intent on claiming your equine slut from behind.  As soon as [eachCock] flops free, Kelly takes notice, her hand coming in front of her mouth in surprise.");
	
	outputText("\n\n\"<i>Are we... are you going to fuck me, [Master]?</i>\"  Kelly asks excitedly, pawing at the ground with a forehoof.");
	
	outputText("\n\nSmiling roguishly, you nod, gesturing with a single digit that she should turn around.  Kelly immediately spins about, kicking up clods of dirt in her haste.  She coyly looks over her shoulder and asks, \"<i>Are you going to take my pussy today, [Master]?</i>\"  She wiggles her powerful, equine backside back and forth as she continues, \"<i>My cunt could use another dose from your dick.</i>\"");
	
	outputText("\n\nYou smack the impertinent wench on her hindquarters for fun and come alongside her, grabbing one of her tits in your hand and squeezing it.  \"<i>You randy cunt.  All it takes a glimpse of my dick to get these nipples hard and that juicy cunt of yours oozing, huh?  I don't know why you ever thought you were in charge of anything - you're just a sodden-twatted whore that gets wet from the thought of being used, aren't you?</i>\"");
	
	outputText("\n\nKelly moans, \"<i>Y-yes!  Yes, I'm a submissive, cock-loving slut!</i>\"  She swishes her tail fanning the scent of her moist slit everywhere.  \"<i>Please, [Master], don't tease me any more!  I'm so ready for you, and you're so right!</i>\"");
	
	outputText("\n\nYou pinch her nipple painfully and say, \"<i>I'll take you when I'm good and ready.  Now be a good little bitch and lift that tail - I want to make sure you're ready.</i>\"  Kelly obeys without question, her tail immediately raising to reveal her glittering mound.  You don't even have to look to know she's utterly, achingly wet, dripping with girlish moisture.  It pays to keep your pets guessing, and you dip your fingers into that moist opening, prying it open to examine the interior.  Her smooth inner walls slowly ripple before your eyes.  Meanwhile, you can see more of her clear juices dripping down the walls and into a channel that drips out over her clit.  You prod the little nub, eliciting a whinny of pleasure from your centaur slut, even going so far to give it a gentle, little pinch.  Enough to make her rear back but not do any damage.");
	
	outputText("\n\n\"<i>Satisfactory,</i>\" you flatly declare, wiping your hand on her haunches.  Kelly beams with pride, even though what you said really wasn't a compliment at all.  All she did is soak herself like a good slut should - that's nothing deserving of praise.  ");
	if (player.tallness < 72) {
		outputText("You turn around to get a stool, since your ");
		if (player.tallness < 52) outputText("diminutive ");
		outputText("height makes reaching her pussy a difficult task.  ");
	}
	outputText("Holding your " + player.cockDescript(x) + " in one hand, you press your " + player.cockHead(x) + " against her entrance.   The steamy cunt pulses wetly around your girth, slowly spreading its thick lips to accept your rigid endowment.");
	if (player.cockTotal() > 1) {
		outputText("  Your other erection");
		if (player.cockTotal() > 2) outputText("s hang");
		else outputText(" hangs");
		outputText(" down below, collecting her drippings and smearing across her belly.");
	}
	outputText("  You slowly slide inside the tight tunnel, feeling Kelly's powerful muscles squeeze delightfully around you, massaging your " + player.cockDescript(x) + " with slow undulations.");
	
	outputText("\n\nKelly moans unrepentantly, loud enough for anyone nearby to hear.  Her hands move to her nipples and pinch at the tight buds, tugging and squeezing the only erogenous zones she can reach.  You ");
	if (player.cockArea(x) >= 300) outputText("bottom out inside her");
	else outputText("slide as far into her as she can handle");
	outputText(" and smack her ass for good measure.  She's so fucking warm!  You sit there for a moment, just to revel in the hot, slippery heat.  Then, you draw back, exposing yourself to the cool air - but only for a moment.  You slam your hips back into the tight centaur-twat without hesitation, the force of the impact jolting the larger woman's body forward.");
	outputText("\n\n\"<i>Yessss,</i>\" Kelly moans as she's impaled, her breasts jiggling as she paws at them.  \"<i>Ple-ooohhhh... please don't stop, [Master]!</i>\"  She begins to push her body against you, the silken tunnel she calls a cunt twitching rhythmically around your " + player.cockDescript(x) + " each time you hit the apex of your strokes.  You squeeze her haunches as you 'ride' her.  She loves every moment of it, even when you slap her butt for good measure, spurring her to bounce herself atop your rod faster and faster.");
	
	outputText("\n\nKelly's moans are getting louder and more passionate with every thrust.  Indeed, the contractions in her horse-like channel are more powerful each time you hit bottom, and tiny squirts of lube are escaping with each squeeze.  Bending over her back, you focus your attention completely on the feel of her velvety cock-sleeve, closing your eyes as you begin to jackhammer your hips in earnest.  Wet slaps echo out from each bone-jarring impact, the pleasure too great for you to slow now.");
	
	outputText("\n\nA familiar throb of excitement in your loins");
	if (player.balls > 0) outputText(" and roiling balls");
	outputText(" leaves no doubt that climax is fast approaching.  Kelly cums first, splattering your [hips] with her ");
	if (flags[kFLAGS.KELLY_CUNT_TYPE] > 0) outputText("fragrant ");
	outputText("centaur-cum, soaking your [legs] immediately.  Her pussy goes wild, the once-ordered spasms going wild, wringing your " + player.cockDescript(x) + " with uncoordinated motions.  A moment later, all those wild contractions sync up into intense, dick-massaging waves.  The power of her equine lower half becomes obvious when her twat seems to suck you inside, squeezing you off to orgasm.");
	
	outputText("\n\nJism sprays from your cock almost immediately, and you throw back your head and swat her ass again in your excitement, barely feeling her pussy-juices as they continue to squirt out in smaller sprays.  All of your attention is focused on the iron-hard, ecstatic tool between your legs as it pulses out fresh squirts of jism, one after another.");
	if (player.cumQ() >= 500) outputText("  Her pussy seems like a soggy, cum-soaked sex-toy before you're even halfway done.");
	if (player.cumQ() >= 1200) {
		outputText("  The sheer amount of spunk exploding into her womb actually rounds her belly a little");
		if (player.cumQ() >= 4000) outputText(", until she's so pregnant with spooge that she can barely stand");
		outputText(".  ");
	}
	outputText("You lay immobile on her back, panting while her wonderful cunt drains you of every drop.");
	
	outputText("\n\nOnce your lust is spent, you reach forward to grope a tit, commenting, \"<i>Atta girl.  Now why don't you lay down and rest a while");
	if (!pregnancy.isPregnant) outputText(" so the cum can turn you into a proper broodmare");
	else outputText(", maybe knit some for the kids you're going to be pumping out for me non-stop");
	outputText(".</i>\"");
	
	outputText("\n\nYou slide back off, landing with a fresh spring in your step.  Then, you pick up your [armor] and head off to find Kelly's blanket - you need something to wipe all the cum and slime off your [legs] with.");
	player.orgasm();
	kellyPreggers();
	doNext(camp.returnToCampUseOneHour);
}

//Centaur on Centaur Sex
/*Requires a centaur lower body.*/
private function taurOnTaurSexKelly():void {
	clearOutput();
	flags[kFLAGS.KELLY_VAGINALLY_FUCKED_COUNT]++;
	var x:int = player.cockThatFits(300);
	if (x < 0) x = player.smallestCockIndex();
	outputText("Admiring your [armor], you slowly remove the portions that cover your animal-like bottom half, wondering how you could ever handle having to wear pants.  Letting [eachCock] swing free below you, smacking against your belly when erect - now that's life.  That's how you were meant to be!  You go ahead and undo the top parts of your gear as well, not wanting anything to come between you and the slutty fem-centaur just a few feet away.  She's keeping her eyes down submissively, but she keeps casting glances under your lower half, licking her lips whenever she gets a good look at [oneCock].");
	
	outputText("\n\nSeeking to tease her even more, you circle around her front, letting her admire your nudity as you drink her feminine curves, particularly the large swells of her chest.  You grope on without asking or warning, simply taking of what's yours, squeezing and testing your property.  Kelly bites her lower lip, her hindlegs trotting about, the attention obviously arousing her delicate, cum-hungry sensibilities.  She quietly mouths, \"<i>Please,</i>\" but you have no intention of giving it to her just yet.");
	
	outputText("\n\n\"<i>Lie down,</i>\" you command, turning yourself around.  She does, of course.  It's not like she has any choice in the matter.  She's been broken as effectively as any saddle-trained pony, only her training is of a decidedly different nature.  You back up, presenting her with your ");
	if (player.balls > 0) outputText("[sack]");
	else outputText("taint");
	outputText(", pressing it into her face, letting your sweat and the scent of your groin smother as effectively as your presence.  Her tongue extends, knowing what you want even before you have to ask.  She licks you, tentatively and then with increasing levels of confidence, smearing saliva all over your flesh as she licks up every drop of sweat, orally lubricating you with hot, wet tongue.");
	if (player.balls > 0) outputText("  Your [balls] tingle pleasantly from the attention, and you groan when she sucks one into her mouth, worshipping it with her lips.");
	outputText("\n\nSuitably turned on, you drag yourself away from Kelly, your skin popping out of her mouth with a lewd pop.  She's blushing when you turn around, openly groping her fat tits and casting lascivious looks towards your member");
	if (player.cockTotal() > 1) outputText("s");
	outputText(".  You gesture for her to rise and turn around, which she does");
	if (player.tallness < 60) outputText(" before sitting back down (she's too tall to take standing up) and lifting her tail");
	else outputText(" before lifting her tail");
	outputText(".  You prance forward, and with a mighty lurch, you mount your mare, climbing atop her, wrapping your hands around her middle for leverage.  She wiggles under your weight, but tries to hold her back-end still while you try to align yourself with her.  Getting in position isn't as easy as it was when you had a humanoid lower body, but when you do finally feel your " + player.cockDescript(x) + " butting up against that warm, wet orifice, the satisfaction is many times greater.");
	
	outputText("\n\nYou lurch forward, plunging yourself deep inside the engorged, ");
	if (flags[kFLAGS.KELLY_CUNT_TYPE] == 0) outputText("pink pussy");
	else outputText("black horse-cunt");
	outputText(", sheathing yourself in that muscular, deep canal.  The lips cling snugly about your [sheath] as you slide into Kelly's velvet pussy, her inner walls squeezing rhythmically around you.  You adjust position, getting accustomed to mounting her like the mare she is, and get a handhold on her big, rounded breasts, squeezing her pebbly nipples between your thumb and forefinger.  She moans, placing her palms over your hands and pressing your harder into her chest, begging, \"<i>Yes!  Fuck me, [Master]!  Give me your cum!</i>\"");
	
	outputText("\n\nYou can't see Kelly's face from here, but by the tone and inflection of her words, she's clearly loving it.  Her pussy seems to get hotter and wetter each time you mount her, letting your body slide back before pistoning up and inside again, your [sheath] bumping into her rigid clit with every thrust.  Dripping centaur-juice runs down your ");
	if (player.balls > 0) outputText("[sack]");
	else outputText("hindlegs");
	outputText(", splattering out in fresh waves from Kelly's ");
	if (flags[kFLAGS.KELLY_CUNT_TYPE] > 0) outputText("musky ");
	outputText("womanhood.  With her body firmly under your own, where it belongs, you firmly assert your control, grabbing her hair in one hand and yanking.  You tug her head back as you bottom out, your body filled with the pleasure of mating like the beasts that you are.");
	
	outputText("\n\nKelly groans through her pain, \"<i>Ooohh, yes, give me your foal, [Master]!  My pussy needs it!</i>\"  True to her words, her walls begin to tug at your " + player.cockDescript(x) + " with familiar, milking contractions, squeezing you from base to " + player.cockHead(x) + " again and again.  Her fluids gush out everywhere, turning the ground underneath her to mud as she climaxes.  You pinch her nipples as the heat builds within you, and when you can take it no more, you reward your cum-slut with the liquid orgasm she so craved.  Jism basts her inner walls when you explode.  Again and again, your muscles clench with ecstatic blast, ejaculating thick flows of your lust straight into the cum-dumpster's spasming cunny.  ");
	if (player.cumQ() >= 1000) {
		outputText("  Her belly grows round with the liquid weight of your spunk");
		if (player.cumQ() >= 4000) outputText(", and when she grows too full to hold any more, waves of alabaster spooge roll out of her abused nether-lips, adding to the messy sex-puddle below");
		outputText(".  ");
	}
	outputText("Thoroughly creamed, the centaur cum-dump sighs in satisfaction while you dismount her.");
	
	outputText("\n\nKelly starts to move, then immediately slips in the lubed mud below, legs flailing wildly.");
	if (player.cor < 50) outputText("  You feel a little bad for her and help her up - she did just milk your dick in the way that only a centaur can.");
	else outputText("  You snicker and walk away - she's already served her purpose.");
	kellyPreggers();
	player.orgasm();
	doNext(camp.returnToCampUseOneHour);
}

//Tentacle
//Requires two or more tentacle dicks.

private function tentaFuckKelly():void {
	clearOutput();
	outputText("With a mischievous grin, you remove your [armor], fully revealing your " + player.multiCockDescriptLight() + ".  The plant-like appendages wriggle around the horny centauress, inspecting her body from every angle.  You feel your own lust rising as the tentacle peckers grow harder, their green heads turning pink in arousal.  Kelly stammers, confused: \"<i>W-what are you-</i>\"");
	
	var one:int = -1;
	var two:int = -2;
	var three:int = -3;
	var four:int = -4;
	var five:int = -5;
	var temp:int = 0;
	while(temp < player.totalCocks()) {
		if (player.cocks[temp].cockType == CockTypesEnum.TENTACLE) {
			if (one < 0) one = temp;
			else if (two < 0) two = temp;
			else if (three < 0) three = temp;
			else if (four < 0) four = temp;
			else if (five < 0) five = temp;
		}
		temp++;
	}
	
	outputText("\n\nSLAM!  You profit from the slut's babbling to shove your " + player.cockDescript(one) + " right into her gaping mouth, forcefully filling her throat with dick-flesh.  Her lips instinctively cling to your shaft, sucking it like a popsicle.  Drops of pre-cum are quickly swallowed and ingested by the hungry whore as they escape your urethra.  You begin thrusting in and out of her warm mouth, but her lips squeeze your rod so tight that you have to fight for every inch.  As you stuff her full of your " + player.cockDescript(one) + ", you can hear her endless muffled moans; the slut is obviously getting off to the taste of your meaty junk.  Completely driven with lust, the green tentacle prick is vibrating on its own as it fucks Kelly's throat, sending you soft, prickling sensations.  You can't help but release a grunt as the centaur slut fellates you so expertly.");
	outputText("\n\nKelly is doing an incredible job with her mouth, teasing you into oblivion.  Your " + player.cockDescript(two) + " is convulsing recklessly in frustration, begging to be stuffed into some warm hole.  Therefore, you naturally direct it toward the centauress' wet snatch; it is easily spottable due to the regular streams of juices that ooze from it.  Moreover, the slut is incredibly turned on from sucking you off, and the fem-spunk trails are even thicker than usual.  It doesn't take long for your secondary tentacle dong to reach the entrance of her moist love-tunnel.  You grind the tip of your " + player.cockDescript(two) + " against it, using her genitals as a masturbation aid.  When it is hard as bark and ready to go, you ram it through Kelly's fuck-hole, utterly piercing her from behind.");
	
	outputText("\n\nYou ream the centaur slut from both sides, making her whinny and thrash violently.  She tramples the floor with her hooves, arches her back and screams in ecstasy through the inches of dick-flesh blocking her throat; she is completely heedless of the world beside the two hard vegetal poles fully impaling her on either end.  You pump away in rhythm, synchronizing each thrust in both holes.  Her twat is almost inhumanly hot, and gloriously tight.  However, the slut tries her best to wrap her lips even tighter around your main flexible pecker, and her tongue is teasing your " + player.cockDescript(one) + " in the most excruciating way.  You stuff the mare slut full of your green appendages, treating her body like a bipolar cocksleeve.");
	
	//[if (cocks > 2)
	if (three >= 0) {
		outputText("\n\nThe display of Kelly trembling in pleasure as you spit her like a pig on your duo of plant-like pricks is enticing, and your " + player.cockDescript(three) + " is aching with need.  It almost moves on its own volition toward the woman's perky tits, ready for a good boobjob.  The supple green wang lodges itself between the busty melons; the slut instantly begins to squeeze her heavy globes around the rod of dick-flesh, fully entrapping it in her bosom.  Her tits are so tender and soft you feel like your tentacle pecker is about to melt.  Groaning in pleasure, you thrust your " + player.cockDescript(three) + " up and down as the titty-fucked whore accompanies your motion.  You grind in rhythm so the slut doesn't forget your other tentacle dongs.  Fortunately, Kelly quickly picks up your intention and soon you can't tell which member is providing you with the most pleasure; her mouth, vagina and soft tits are all working in conjunction, and you are fully lost in a never-ending spiral of ecstasy.");
	}
	//if (cocks > 3)
	if (four >= 0) {
		outputText("\n\nYour " + player.cockDescript(four) + " trembles furiously, unable to find some body part that isn't taken by its colleagues.  You grin wickedly as an idea comes to your mind.  The protruding appendage writhes as it threads its way toward Kelly's right hand; the slut is still focusing on your " + player.cockDescript(three) + ", squeezing her tits as tightly as she can.  Needless to say, she is surprised when another tentacle shoves itself in the way, right under her palm.  She doesn't lose her composure, though; using her forearm to press on her chest, her hand quickly grabs hold of your tree-like pecker and begins stroking your length.  Although her handjob doesn't feel as warm and tight as the wet depths of her love-tunnel or her throat, or even the squelching contact of her tender boob-flesh, she teases you efficiently with her fingers.  Her hand massages your " + player.cockDescript(four) + " and clutches it like a vice, milking some drops of pre-cum out of your shaft.  She takes care of the most sensitive points and often makes you moan when she squeezes the towering rod.");
	}
	//[if (cocks > 4)
	if (five >= 0) {
		outputText("\n\nKelly still has a free hand, and your " + player.cockDescript(five) + " is left alone, flustered.  The squirming tentacle quickly finds a comfortable spot near her boob, but this time you don't need to do anything; the eager slut catches the vegetal rod and begins to stroke it furiously.  Her hands pump along your lengths in turn; both pricks are so hard that you don't know which one will cum first.  Her fingers move across the surface of your meaty green dongs with expert care, teasing you more and more.  You enjoy the double handjob, your duo of plant-like dongs ready to explode in a mess of cum.");
	}
	//[if (cocks > 5)
	if (player.countCocksOfType(CockTypesEnum.TENTACLE) > 5) {
		outputText("\n\nSadly, there is no body part to fill or grind against for your remaining tentacle junk; you just wrap it around her horny body, crawling against every spot of skin that isn't occupied by some tentacle dong.");
	}
	outputText("\n\nEventually the slutty mare's holes and flesh are starting to drain your stamina; a pressure builds in your crotch as the imminent release arrives. With a raging grunt, you pump harder and faster, not caring in the least about the fuck-toy within your tentacle embrace.  [EachCock] jiggles in extreme arousal as they have their way with the quivering lump of horny flesh that you call Kelly.  At last the pressure is too much to bear, and you blast her with everything you have.  Torrents of spunk boil as they find their way up your urethras and utterly fill the centauress' holes.  Her lips contract lewdly around your " + player.cockDescript(one) + ", ready to swallow everything it squirts.  At the same time, her tight twat seems to be crunching your " + player.cockDescript(two) + " like a vice; you can't help but pump more and more ropes of jism into the slut's waiting womb.");
	if (three >= 0) {
		outputText("  The remainding tentacle");
		if (four >= 0) outputText("s erupt");
		else outputText(" erupts");
		outputText(" in an unholy fountain of seed, splattering the slut's horny body with white goo. Kelly seems to thoroughly enjoy her cum bath, as she lets out deadened screams of ecstasy.  She clearly gets off on being covered with your spooge; indeed, you can feel her hot pussy squirting load after load of juice, and the drops of spunk with your own to create a puddle of filth on the farm's floor.  You shoot your load on the eager cumdumpster, utterly drenching her until she is sopping wet; not a square inch of skin is spared from this almighty geyser.");
	}
	outputText("\n\nWhen the flow of baby-batter eventually dries up, you'd almost believe Kelly has had a shower if it weren't for the occasional lumps of white goo that stain her whole body.  She doesn't seem to mind looking like a cum-sponge, however; she smiles euphorically as she slurps all the spunk she can reach with her tongue.");
	
	outputText("\n\n\"<i>Ahhh... that was a good cum-bath.  Thank you Master, you can't believe how happy I am!</i>\"");
	
	outputText("\n\nKelly is really hooked up to your seed; she lays to her side and wallows in the puddle of juices, wanting to feel even more of your filth covering her body.  Pleased to see you have such a potent effect on her, ");
	if (player.cor < 33) outputText("but also a bit disgusted to watch such shameless, wanton behavior, ");
	outputText("you walk away, letting the slut enjoy herself.");
	kellyPreggers();
	player.orgasm();
	dynStats("sen", -3);
	doNext(camp.returnToCampUseOneHour);
}

//Makes her cunt become horse-like.
private function giveKellyEquinum():void {
	clearOutput();
	outputText("Taking the long, flared vial in your hand, you get a wicked idea - what if you gave your personal mare-slave a cunt that was better suited to her depraved, animalistic shape?  What if you turned that pretty, pink pussy into a slobbering, black mare-cunt?");
	
	outputText("\n\nKelly sees you behind her and nervously asks, \"<i>[Master]?  What are you doing?</i>\"");
	
	outputText("\n\n\"<i>Hush pet, I'm just finishing what I started.  Soon you'll have a cunt fit for dumping gallons of jizz into, just like you wanted.</i>\"");
	
	outputText("\n\n\"<i>Oh, right,</i>\" Kelly demurely replies, lifting her tail to further expose her prominant, womanly folds, \"<i>Whatever you want, [Master].</i>\"");
	
	outputText("\n\nSmiling cruelly, you give her bodacious rump a smack followed by a rough squeeze.  Kelly moans, shimmying her hindlegs and juicy bottom closer to you in response.  You immediately uncork the vial, place the flared bottle into that welcome honey-hole, and push it deep inside her.  Your centaur toy whinnies in delight, her wide-spread cunt rippling around the vial as it empties, convulsively milking it as if it was a tiny horse-cock.  You guess that even with a human cunt, some instincts must stay the same.  A trickle of her feminine ooze dripples out from her clenching snatch, mixed with a tiny amount of the potion.  Most of it seems to travel deeper inside her, and you can tell from the clear end of the bottle that it's fully emptied.  There's nothing to do now but pull it out and enjoy the changes as they happen.  You do so with a smile.");
	
	outputText("\n\nAt first, all you observe is a disappointed moan.  Kelly backs up, hooves stamping impatiently as she tries to bring her pussy closer to you, eager for more.  \"<i>What did you put in me, [Master]?  That didn't feel like cum,</i>\"  she dares to ask.  You swat her square across her equine ass, sending her scampering a few feet away, still trailing dripping fem-slime.  She moans immediately, her plump pussy lips shining with a reflective sheen.  Her feminine odor gets slightly stronger as well, though each time you catch a whiff of it, it's a little bit different - less human and somehow more... potent.  Her glossy pink lips begin to bulge, thickening before your eyes.  Her slit lengthens as well, the clit growing bigger and harder than before to match the larger curtains that are her labia.  Bigger and bigger, her vulvae swell, until those plump, soaked outer lips leave you no doubt that they were designed to part for the biggest, fattest erections possible.  Their coloration darkens to purple, then jet black, a sloppy onyx veil just begging for a cock.");
	flags[kFLAGS.KELLY_CUNT_TYPE] = 1;
	outputText("\n\n<b>Kelly has now has a soaking-wet horsecunt!</b>");
	player.consumeItem(consumables.EQUINUM);
	menu();
	addButton(0,"Next",approachKelly);
}
//Succubi Milk - Rehumanizes Her Pussy
private function giveKellySuccubiMilk():void {
	clearOutput();
	outputText("You produce a vial of succubi milk and dangle it before Kelly, the ivory demon-juice sloshing audibly inside.  Kelly licks her lips immediately, running her hands across her perky nipples without meaning to.  She asks, \"<i>[Master], is that what I think it is?</i>\"");
	
	outputText("\n\nNodding, you uncork it and hand it to her.  \"<i>I got tired of you having that nasty-ass horse-pussy and figured it was time you had a tight, little human-cunt to better service me,</i>\" you comment as she begins to drink.  Kelly moans as she guzzles it, spattering feminine lubricants behind her as she messily orgasms, just from drinking the tainted potion!  She convulsively spurts and gulps again and again, climaxing as her body takes in the treat you conditioned it to love.");
	
	outputText("\n\nCircling behind her, you lift her tail and watch her pussy get smaller, more petite, even as it squirts fragrant discharges of lubricant behind it.  You're careful to enjoy it, but you enjoy watching its color lighten in hue to a rosy pink, the lips shrinking to more human-like proportions and shape.  Even her clitty gets a little smaller, looking exactly like something you'd expect to find on one of the girls back home.  Of course, none of the girls back home were your person brood-mare sex-slave.");
	
	outputText("\n\nKelly finishes the drink with a self-satisfied smile, and she cheerful says, \"<i>Thank you for the treat, [Master].</i>\"");
	
	outputText("\n\nYou swat her rump affectionately and nod, not deigning to give her the pleasure of your praise.");
	flags[kFLAGS.KELLY_CUNT_TYPE] = 0;
	outputText("\n\n<b>Kelly now has a human-like pussy.</i>");
	player.consumeItem(consumables.SUCMILK);
	menu();
	addButton(0,"Next",approachKelly);
}

//Punish(C)
private function punishKelly():void {
	clearOutput();
	flags[kFLAGS.TIMES_PUNISHED_KELLY]++;
	//First time: 
	if (flags[kFLAGS.TIMES_PUNISHED_KELLY] == 1) {
		outputText("You don't say anything immediately when Kelly prances to a bouncing halt in front of you; instead, you take your time to do a slow circuit around her, taking her in as if she were a piece of property, which of course she is.  You know the effect you have upon the centauress and you grin quietly to yourself as you draw in close to her without touching; your aura presses upon her and her breath quickens, her always-ready pussy moistening even further.  You pause next to her back end and gently press a finger against her labia.");
		outputText("\n\n\"<i>It must be difficult,</i>\" you say as you gently trace the line of her wet opening, \"<i>being this turned on and not being able to do anything about it.</i>\"");
		
		outputText("\n\n\"<i>Like you wouldn't believe, [Master] ...oooh,</i>\" she moans as you circle her clitoris, already bulging out of its hood.");
		
		outputText("\n\n\"<i>Such a wanton bitch, and yet so helpless.  I bet with a slut-hole like this out of reach all you can think about most of the time is cock, am I right?</i>\"  You laugh as you move your hand upwards to tease at her pink, human-like asshole; pressing your fingers gently against it at first and then using the girl-slime covering them to penetrate it, pushing in and out of her tight warmth with two digits slowly.  \"<i>Even your ass is begging for my dick, just like the rest of your whore body.  You like that, don't you?  Being a helpless, hopeless whore?</i>\"");
		
		outputText("\n\n\"<i>It's why I need you, [Master],</i>\" says Kelly between gasps. \"<i>Servicing you, being the best cumslut I can possibly be, that's what I exist for.  If I don't do it, I don't get satisfied.  Although...</i>\" She trails off.  You stop fingering her.");
		
		outputText("\n\n\"<i>Go on,</i>\" you say gently.");
		
		outputText("\n\n\"<i>Well,</i>\" she says hesitantly; you resume your soft, insistent pressure upon her wet lips as she talks. \"<i>I- I sometimes get off by rubbing myself against a tree or one of the standing stones.  It's not perfect, it's not as good as your cock, but when the urge gets unbearable... ohh... it does.  You aren't mad, are you [Master]?</i>\" she says anxiously, peering back over her shoulder with wide, green eyes.");
		
		outputText("\n\n\"<i>For telling the truth?  No,</i>\" you say.  You let her sag with relief as you look at her flanks and take in a number of scuffs and mild abrasions across her backside; you'd never have attached any importance to them if she'd said nothing.  You make a note of them as you penetrate her vagina fully with your fingers, dipping into her hot, wet hole and curling at her tunnel until she's moaningly close to orgasm, before stopping, striding back around to her front end and taking her chin between two fingers.  \"<i>However,</i>\" you say calmly, \"<i>I'm still going to have to punish you.  If you aren't getting off, that's because <b>I</b> have decided you aren't allowed.  Why do you think I keep you in this shape?  Because it's the only way a complete slut like you can learn, with your hands away from your goodies.  You get pleasure when you give <b>me</b> pleasure, is that understood?</i>\"  Kelly manages a small nod, looking terrified.  \"<i>But... this is mainly my fault,</i>\" you go on, in a more lenient tone.  \"<i>Of course a cocksleeve like you couldn't be expected to act any different.  We'll do some lessons, and we'll both learn from them.  What do you say?</i>\"");
		
		outputText("\n\n\"<i>Please, [Master],</i>\" says Kelly in a humble voice.  \"<i>Punish me so I can learn to become a better cumslut for you.  It's all I want.</i>\"  You look at the centauress with the plump, cock sucking lips and the bare love pillows, who is not even capable of looking you in the eye, and a memory comes back to you; of a big, bearded horseman with hard, rugged good looks, moving with casual assuredness towards you, sneering down with complete contempt.  You've been struggling to control your own arousal at how your unfortunate slave has taken your abuse, but the simple truth of the transformation you have wrought upon this being sends blood rushing to your groin, and now you ponder the best way of going about this.");
	}
	//Repeat: (Suggested activations: PC does not have sex with Kelly for 3+ days, Kelly in heat but wasn't fucked during that period) 
	else {
		outputText("You can see guilt written in mile high letters upon Kelly's face as she bounces to a halt in front of you.  You let her stew as, with a poker face, you begin your usual slow inspection of her, letting the aura of your closeness sink into her.  She tenses when you touch the fresh abrasions upon her butt, and you tut slowly.");
		outputText("\n\n\"<i>Have you been a bad little cumslut, Kelly?</i>\"");
		
		outputText("\n\n\"<i>Y-yes, [Master], I have,</i>\" she whispers after a short pause.  You keep a firm hand pressed upon her ass.");
		
		outputText("\n\n\"<i>Do you need punishing?</i>\"");
		
		outputText("\n\n\"<i>Yes, [Master], I do,</i>\" she says, slightly louder and straightening her back.  You smile softly.  Such a good girl.");
	}
	menu();
	if (flags[kFLAGS.TIMES_RIDDEN_KELLY_FOR_PUNISHMENT] > 0 && player.statusEffectv1(StatusEffects.TelAdre) < 1) {
		outputText("You'd like to take Kelly for a ride, but you don't have any good ideas for public places to humiliate her.");
	}
	else addButton(1,"Ride",rideKellyForPunishment);
	addButton(0,"Rimjob",getARimjobFromKelly);
	addButton(4,"Back",approachKelly);
	
}

//Rimjob/Ride/Riding crop
//Rimjob(C)
private function getARimjobFromKelly():void {
	var x:int = player.cockThatFits(300);
	if (x < 0) x = player.smallestCockIndex();
	clearOutput();
	flags[kFLAGS.TIMES_RIM_JOBBED_BY_KELLY]++;
	outputText("\"<i>You aren't worthy of my dick,</i>\" you say, as you slowly peel off your [armor]; you do it facing away from Kelly so that she can take in your [butt] as you slowly wriggle free of your underclothing.  \"<i>But I still need servicing.  So...</i>\"");
	
	//[Naga: 
	if (player.isNaga()) outputText("\n\nYou slither into her and, wriggling upwards, beginning the process of wrapping your long, patterned tail around her powerful form.  Kelly murmurs disquietly but stays still as you weave under and over her; you stop level to her face, her entire frame swaddled in your coils.  You trace the line of her chin with your hand as you take a moment to enjoy the sensation of this big, soft creature against your warm scales, at your mercy; then you slowly rise above her until her face is level with your genital slit before, with sinuous grace, twisting your body so that her mouth is now facing your [butt].");
	
	//[Centaur:]
	else if (player.isTaur()) outputText("\n\nYou gesture at the ground.  \"<i>Lie down,</i>\" you command.  Kelly carefully folds her body up to do so, until her horse half is prostrate and only her human half is propped up.  You lead yourself back until your rear end is near to her face; grinning to yourself, you slowly brush your semi-erect " + player.cockDescript(x) + " against her soft face, teasing her with the idea that you've changed your mind; you cannot see her but from the small bitten off grunts and moans you know she's struggling with the urge to wrap her lips around it.  Finally, you carefully lean downwards, so that instead of your dick she's faced with your [butt].");
	
	//[Biped/Other:
	else outputText("\n\nYou gesture at the ground.  \"<i>Lie down,</i>\" you command.  Carefully Kelly folds her body up to do so, until her horse half is prostrate and only her human half is propped up.  You step forwards and for a few moments slowly brush your semi-erect " + player.cockDescript(x) + " against her soft face, teasing her with the idea that you've changed your mind; she struggles with the urge to wrap her lips around it, emitting small bitten off grunts and moans to your ministrations.  Finally, with a grin you pull away and turn around, so that her mouth is now facing your [butt].");
	
	outputText("\n\nYou flare your [hips] and present your [asshole] to her.  \"<i>So service me.</i>\"  Without waiting for a response you press your butthole onto her mouth.");
	
	outputText("\n\nShe is unpracticed at first; you feel her teeth rub against your hole and you hiss.  The mere sound of your annoyance makes her whimper around your [ass] and her teeth seem to vanish, replaced with a sucking, eager wetness.  ");
	if (player.isNaga()) outputText("With reptilian litheness, you slowly lean backwards and press your hands onto the back of her head, pushing her face further between your cheeks.  ");
	else if (!player.isTaur()) outputText("You lean backwards and press your hands onto the back of her head, pushing her face further between your cheeks.  ");
	outputText("You laugh at the sensation of her tongue as it pushes into your anal passage, slathering it with worshipful attention, perhaps hoping the sooner she gets you off the sooner this can end.");
	//[Not Centaur: 
	if (!player.isTaur()) outputText("  You smirk and grip her hair, moving her head in rhythm with your own movements.");
	else outputText("  You gyrate your [butt] this way and that, moving her head in rhythm with your own movements.");
	
	//[Pussy: 
	if (player.hasVagina()) outputText("\n\nYou feel thin fingers brush against your [vagina], slowly rubbing against the sensitive folds of your labia before circling your [clit] in virtually the same motion you used upon her earlier.  You decide to allow this; she's learnt a valuable lesson you weren't even aware you were teaching, and the dual movements of her tongue in your ass and her warm fingers slicking across your wet pussy are delightful.");
	
	outputText("\n\nHer tongue probes deeper and deeper into you, her plump lips pressing into your [asshole] until she touches something sensitive.  Your " + player.cockDescript(x) + " immediately reacts, twitching upwards restlessly.");
	
	outputText("\n\n\"<i>That's it,</i>\" you breathe. \"<i>Good girl.  Keep doing that...</i>\"  As she gently pushes and flicks her warm mouth muscle against your prostate, your dick");
	if (player.cockTotal() > 1) outputText("s harden");
	else outputText(" hardens");
	outputText(" until after minutes of blissful pleasure you are bulging with need.  Her saliva coats your opening as you clench your muscles and trap her tongue deep in you before roughly rubbing your [ass] against her, face fucking her for all you are worth; the soft, slippery sensation inside you is immense and you pick up the pace.");
	if (player.isNaga()) outputText("  You clench her almost bone crushingly tight in your coils as rut overtakes you.");
	
	outputText("\n\n\"<i>Oh, you're soooo good at that,</i>\" you sigh.  \"<i>You are just as good an asslicker as you are a cocksucker.  Maybe we'll do it this way every time from now on.  Would you like that? Worshipping your [Master]'s ass for your cumfix?  Should I keep you around just for when I need the sweat cleaned from my crack");
	if (player.balls > 0) outputText(" and balls");
	if (player.hasVagina()) outputText(" and pussy");
	outputText("?  I can't say it's something you don't deserve for being such a shameless slut, and I don't doubt you'd enjoy every minute of it.</i>\"");
	
	outputText("\n\nIf anything your harsh words make Kelly work harder; she wriggles her tongue this way and that with your rough movements and moans, the vibrations translating straight down your cock");
	if (player.hasVagina()) outputText("; she slides as many fingers as she can into your [vagina] and frigs you as best she can");
	outputText(".  Grunting, you reach your peak.  Your " + player.cockDescript(x) + " opens wide and you ejaculate streams of cum, splattering into the dust in front of you, your whole body clenching and seizing around the warm, wet muscle wedged in your [butt].");
	//[Pussy:]
	if (player.hasVagina()) outputText("  Your female sex orgasms in tandem, your wet flesh seizing up around Kelly's fingers and spattering her arm and chest with girl juices.");
	
	outputText("\n\nYou give three final thrusts against Kelly's face to work out every last drop and then, spent, you slowly pull away, spit trailing from your ass to your slave's lips.  You insouciantly flare your cheeks in front of her after she has withdrawn, waiting, and grin when you feel a hesitant lick against one.  You turn around to take a good look at her.  She is panting for breath, her pupils dilated as she stares back up at you; her own arousal, of course, is unabated.  Finally, she finds some words.");
	
	//[First time: 
	if (flags[kFLAGS.TIMES_RIM_JOBBED_BY_KELLY] == 1) {
		outputText("\n\n\"<i>Th- thank you for the lesson, [Master],</i>\" she says.  You shake your head, smiling at her ignorance.");
		
		outputText("\n\n\"<i>That wasn't the lesson.</i>\"  You wave at the rivulets of your own cum in front of you casually.  ");
		if (player.cumQ() >= 700) outputText("You, as ever, have produced a veritable oozing lake of the stuff.  ");
		outputText("\"<i>That is your lesson.  You need your jizz and I don't want the camp to be untidy.  Off you go.</i>\"  Kelly pauses for a moment as she stares at the off-white mess, and then slowly gets up, trots over to you, gets down again and begins to lick up your carelessly spent seed from the dirt.  You stand over for a moment until she looks up; you see nothing but total devotion in her eyes as she happily swallows one glob of the most delicious, most satisfying substance in the world to her and then starts on the next.  You rub her behind the ear and then leave her to her meal.");
		//[High cum:
		if (player.cumQ() >= 1000) outputText("  She is, after all, going to be here for a while.");
	}
	//[Repeat: 
	else {
		outputText("\n\n\"<i>Th-thank you for the lesson, [Master],</i>\" she says.  She knows the drill by now; she quickly gets to her feet and then trots over to the off-white slimy mess you have created.  What a good girl.  Before she can get started you present your " + player.cockDescript(x) + "; she murmurs thanks for the gift and licks your oozing head spotless first before getting on with the main meal.  You rub her behind the ear as she licks away at the spent seed at your feet and then leave her to it.");
		if (player.cumQ() >= 1000) outputText("  She is, after all, going to be here for a while.");
	}
	player.orgasm();
	dynStats("sen", 3, "cor", 1);
	doNext(camp.returnToCampUseOneHour);
}

//Ride(C)
//(Assumes Kelly is at camp; minor revisions required otherwise)
private function rideKellyForPunishment():void {
	var x:int = player.cockThatFits(300);
	if (x < 0) x = player.smallestCockIndex();
	clearOutput();
	flags[kFLAGS.TIMES_RIDDEN_KELLY_FOR_PUNISHMENT]++;
	//First Time: 
	if (flags[kFLAGS.TIMES_RIDDEN_KELLY_FOR_PUNISHMENT] == 1) 
	{
		outputText("You stroke Kelly's side thoughtfully.  What would be a good punishment for a centaur? Several ideas immediately occur, but all require... equipment.  You tap your chin as a plan of action falls into place.");
		//[PC is 6'5</i>\" or less, not a centaur:
		if (player.tallness < 78 && !player.isTaur()) 
		{
			outputText("\n\nWithout warning you suddenly swing yourself onto Kelly's back.  She squawks in surprise and almost rears, but you put a firm but comforting hand on her shoulder as you settle yourself and she calms down.");
			//[Naga:]
			if (player.isNaga()) outputText("  Your reptilian half is hardly ideal for riding a horse but eventually you reach a happy compromise; you perch upon her with your long tail wrapped around her barrel-like lower body.");
			//[Drider:]
			else if (player.isDrider()) outputText("  Your spider half is hardly ideal for riding a horse but eventually you reach a happy compromise; you perch upon her with your long, chitinous legs wrapped carefully around her barrel-like lower body.  You must look utterly bizarre but feel reasonably comfortable.");
			outputText("  You lean in close to her human half and wrap your arms around her waist, drinking in the sweet scent of her pale skin; you know your own smell and power is pressing upon her senses and she whimpers softly as you slide your hands up her stomach until they are clutching her ");
			if (flags[kFLAGS.KELLY_BONUS_TIT_ROWS] > 0) outputText("top row of ");
			outputText("breasts.");
			
			outputText("\n\n\"<i>All right, pony slut,</i>\" you sigh into her ear.  \"<i>I want you to ride us to the farm.  You remember where that is, don't you?  It's where I taught you who you really are.  We're going to learn some more lessons there.  Won't that be fun? Go gently because...</i>\" you grip her breasts tighter, squeezing her nipples between your fingers");
			if (flags[kFLAGS.KELLY_LACTATING] > 0) outputText(" hard enough to produce thin arcs of milk");
			outputText(".  The centauress gasps, her breath already ragged. \"<i>...I've got to hold onto something.  Now, giddy up!</i>\" Kelly jolts into action, stumbles slightly at the extra weight, before righting and trotting in the direction of the farm; you keep yourself steady by maintaining a firm grip upon her breasts.");
			//[PC is riding: 
			outputText("\n\nAlthough it's only a short trip, your [butt] is plenty sore by the time you get to the farm, and you KNOW you're going to need better equipment if you're to do this properly.  You bring Kelly to a halt with a \"<i>woah there</i>\" and a tug upon her ponytail.  Then, you leave her behind the barn as you search the barn for what you need, hoping Whitney doesn't find you.");
		}
		//[PC is 6'6</i>\" or more/centaur:
		else 
		{
			outputText("\n\nYou consider for a moment making her ride you where you need to go; but no, your size makes that impossible.  Instead you sigh and slide an arm around her waist, breathing in her sweet scent.");
			
			outputText("\n\n\"<i>You're useless to me as a steed,</i>\" you breathe into her ear, knowing your own smell and power are inundating her senses.  The centauress's breath comes ragged as your hand slides up and down her front, across her smooth stomach to lazily cup a breast and hold a nipple.  ");
			if (flags[kFLAGS.KELLY_LACTATING] > 0) 
			{
				if (flags[kFLAGS.KELLY_BONUS_TIT_ROWS] > 0) outputText("All four of h");
				else outputText("H");
				outputText("er swollen teats immediately begin to dribble milk, and she moans.  ");
			}
			outputText("\"<i>So we will have to find some other way you can serve me.  We're going to go across to the farm.  You remember where that is, don't you?  It's where I taught you who you really are.  We're going to learn some more lessons there.  Won't that be fun?</i>\" You let go and set off at a ");
			if (!player.isTaur()) outputText("march");
			else outputText("canter");
			outputText(" and after a pause she follows; deliberately led towards your destination.");
			
			outputText("\n\nYou leave her behind the barn with a curt \"<i>stay</i>\", and then look around for what you need, hoping to avoid Whitney.");
		}
		outputText("\n\nIt doesn't take long to find a smaller horse-barn near the larger structure, which doesn't look to have been used in quite some time.  You enter the musky, straw-strewn darkness and rummage through the crates.  You laugh out loud at what you find.  There's all you need here, and more.");
		
		outputText("\n\nKelly watches you with quiet, wide-eyed pensiveness as you return.  You feel a pinch of pity for your slut as you throw down a heap of metal and leather; after all, you made her the way she is.  Still, she's got to learn.");
		
		outputText("\n\n\"<i>How do centaurs feel about being ridden?</i>\" you ask casually, as you pull out a wrap and saddle and set them upon her back.");
		
		outputText("\n\n\"<i>For most it's... taboo, [Master],</i>\" she answers lowly.  She makes a shuddering sigh as you fix stirrups to her and begin to fit her head with the leather straps of a harness.  \"<i>Something you would only allow a close friend or lover to do.  Even then, never with... with gear.  That is the invention of biped races for their animals, and to wear it is... is...</i>\"");
		
		outputText("\n\n\"<i>Like you are owned,</i>\" you suggest.  The harness is giving you some trouble as it was never intended to be fitted upon a human head, but you find with some readjustment it suits your purpose; you let go of it gently, it holds, and you lead the reins back across her back.  Carefully, you lift the last three objects you intend to use today up to her eyes.  \"<i>Like you are a lesser creature.  Like you are there to be used.</i>\" She doesn't reply but you can feel the thump of her heartbeat as you fit the blinkers to each side of her pretty face. \"<i>Tell me... what is the centaur equivalent for bitch?</i>\" Kelly mumbles something.  You face her head on and fix the last object to the straps near her face, before gently stroking her soft, smooth cheek until she looks you in the eye.");
		
		outputText("\n\n\"<i>Ass,</i>\" she says, this time just loud enough for you to hear.  You smile crookedly.");
		
		outputText("\n\n\"<i>How very appropriate.  Open wide.</i>\" Tremblingly she does so, and you place the bit between her teeth.  It says a lot about Mareth, you think as you walk to her side, that it is shaped rather like a ball gag, holes and all.  You aren't quite finished; with some long, leather straps you take her arms and bind them tightly behind her back.");
	
		//[PC rider:]
		if (player.tallness < 78 && !player.isTaur()) 
		{
			outputText("\n\nYou take a moment to admire your bound and gagged slut, replete with saddle, harness, reigns and blinkers.  There are a number of other things you found in Whitney's stable, but you'll save them for another day.  She gasps as you jump onto her back, but stays level; already she's learning.  You crack the reigns and she emits a muffled whimper.");
			
			outputText("\n\n\"<i>Giddy up then, ass,</i>\" you say.  \"<i>Once around the farm and then back to the camp.   Lift those legs high; fat titted sluts like you need plenty of exercise to burn off all that manfat you suck down.</i>\"");
			
			outputText("\n\nKelly sets off at a canter and you hold the reigns");
			if (player.isBiped()) outputText(", set your feet into the stirrups");
			outputText(" and enjoy the ride.  The experience is greatly more comfortable and you luxuriate in the breeze upon your " + player.skinFurScales() + ", the gentle, comforting undulation of the farm and grasslands around you, and increasingly the smell of sweat and horniness rising off the rosy skin of your pony bitch.  Her boobs bounce up and down with her own movements, accentuated by having her arms tied behind her, and although she seems to resolve to suffer in silence to begin with, the air in front of you is soon full of muffled whines and moans.  You make a 'tchk-tchk' noise and dig into her side, urging her to go faster.  Cows raise their heads from their grazing to stare at you incuriously as you gallop past; an utterly stunned Whitney watches you from her place underneath the tree, her book forgotten in her hands.  You wonder if she can recognise your mount, and you grin at the thought.");
			
			outputText("\n\nEventually you arrive back at camp, and not a moment too soon.  Your nostrils are full of the smell of Kelly, and the sight of her hot, moist skin has you practically chomping at the bit yourself.  You slide off her, stagger slightly as you rip off your [armor], and then without any further ado grip her hindquarters and sink your straining " + player.cockDescript(x) + " straight into her cunt.  It is absolutely soaked with arousal, and you encounter virtually no resistance as you thrust your hips into her soft butt, immediately beginning to fuck her as hard as you can.  In your sex-daze you realize you are still clutching the reigns; you pull at them intermittently as you push as much of yourself into the centauress's hot, grasping warmth as you can, making her rear, squeal, and then scream around her gag to the dual sensation of her [master]'s dick burying itself into her and the harness pulling tight upon her head and bit, thrusting back into you as best she can.");
			
			outputText("\n\nNeither of you are in any condition to keep this up for long, and after five minutes of fevered fucking, you groan as you clutch Kelly's ass hard, clenching and pouring yourself into her, your " + player.cockDescript(x) + " surging line after line of cum into her.  She moans breathily and happily to the heavenly sensation of being filled with your seed, her vagina milking you for every drop it can get.  You don't even know how many times she orgasmed; her pussy dribbled and gushed the entire time you were in her.");
		}
		//[PC not rider:
		else 
		{
			outputText("\n\nYou take a moment to admire your slut, replete with saddle, harness, reigns and blinkers, bound and gagged.  There are a number of other things you found in Whitney's stable but you'll save them for another day.  You gather up the reigns and crack them; she emits a muffled whimper.");
			
			outputText("\n\n\"<i>Giddy up then, ass,</i>\" you say.  \"<i>I cannot ride you, so you shall have to be a show pony.  Once around the farm and then back to the camp.  Lift those legs high; fat titted sluts like you need plenty of exercise to burn off all that manfat you suck down.</i>\"  You set off and give the reigns a stiff tug; Kelly quickly sets off at a trot behind you.");
			
			outputText("\n\nIt's a lovely day and you luxuriate in the breeze upon the skin, the gentle, comforting undulation of the farm and grasslands around you, and increasingly the smell of sweat and horniness rising off the rosy skin of your pony bitch.  Her boobs bounce up and down with her own movements, accentuated by having her arms tied behind her, and although she seems to resolve to suffer in silence to begin with, the air behind you is soon full of muffled whines and moans.  You make a tchk tchk noise and urge her to go faster; such is your own size you are easily able to keep up with her as she begins a light gallop.  Cows raise their heads from their grazing to stare at you incuriously as you race past; an absolutely stunned Whitney watches you from her place underneath the tree, her book forgotten in her hands.  You wonder if she can recognise your mount and you grin at the thought.");
			
			if (!player.isTaur()) 
			{
				outputText("\n\nEventually you arrive back at camp, and not a moment too soon.  Your nostrils are full of the smell of Kelly, the sight of her hot, moist skin and you are practically champing at the bit yourself.  You bring her to a halt, rip off your [armor], and then without any further ado grip her hindquarters and sink your straining " + player.cockDescript(x) + " straight into her cunt.  It is absolutely soaked with arousal and you encounter virtually no resistance as you thrust your hips into her soft butt and immediately begin to fuck her as hard as you can.  In your sex daze, you realize you are still clutching the reins; you pull at them intermittently as you push as much of yourself in the centauress hot, grasping warmth as you can, the force making her rear.  She squeals, then screams around her gag to the dual sensation of her [master]'s dick burying itself in her and the harness pulling tight upon her head and bit, thrusting back into you as best she can.");
				outputText("\n\nNeither of you are in any condition to keep this up for long, and after five minutes of fevered fucking, you groan as you clutch Kelly's ass firmly and pour yourself into her, your " + player.cockDescript(x) + " surging line after line of cum into her.  She moans breathily and happily to the heavenly sensation of being filled with your seed, her vagina milking you for every drop it can get.  You don't even know how many times she orgasmed; her pussy dribbled and gushed the entire time you were inside her.");
			}
			//Centaur: 
			else 
			{
				outputText("\n\nEventually you arrive back at camp, and not a moment too soon.  Your nostrils are full of the smell of Kelly, the sight of her hot, moist skin and you are practically champing at the bit yourself; even her rippling horse body speaks directly to your own, urging you irresistibly to mount her.  You bring her to a shuddering halt, rip off your [armor], and then without any further ado rear onto her back and sink your straining " + player.cockDescript(x) + " straight into her cunt.  It is absolutely soaked with arousal and you encounter virtually no resistance as you thrust your hips into her soft butt and immediately begin to fuck her as hard as you can.  In your sex daze you realize you are still clutching the reigns; you pull at them intermittently as you push as much of yourself in the centauress hot, grasping warmth as you can, making her rear, squealing and then screaming around her gag to the dual sensation of her [master]'s dick burying itself in her and the harness pulling tight upon her head and bit, thrusting back into you as best she can.");
				outputText("\n\nYou wish you could live forever in these luscious moments; it is so indefinably right to be reared over your eager submissive, encompassing her with your own flesh as you penetrate her deep wetness, both your human and horse parts cry out for it; mounting her, breeding her, imprinting yourself upon her and making her yours.  Neither of you are in any condition to keep it up for long though, and after five minutes of this fevered fucking you groan as you clutch Kelly's breasts hard and pour yourself into her, your " + player.cockDescript(x) + " surging line after line of cum into her.  She moans breathily and happily to the heavenly sensation of being filled with your seed, her vagina milking you for every drop it can get.  You don't even know how many times she orgasmed; her pussy dribbled and gushed the entire time you were inside her.");
			}
		}
		kellyPreggers();
		//All go to: 
		outputText("\n\nFinally, you withdraw; you take a long moment to catch your breath before turning to Kelly.  She is panting hard too as she watches you slowly and carefully dismantle the riding gear off her.  The last thing you take off her is the ball bit; you remove it from her mouth, trailing saliva, interested to hear what will come out.");
		
		outputText("\n\n\"<i>Th-that was a good lesson, [Master],</i>\" she says eventually, her mouth open and heaving in breath.  \"<i>I think I learnt a lot.  My favorite bit was where you fucked me silly at the end, though.  Could we just skip to that next time?</i>\"  You laugh and say as long as she's a good little cumslut from now on, you will always skip to that part.  Otherwise... you nod at the pile of riding gear... you'll have to teach her more lessons... and the next one will be harder.  She swallows, not taking her eyes off the gear.");
		
		outputText("\n\n\"<i>I understand, [Master].  I'm so lucky to have you to teach me how to be good!</i>\" You send her on her way with a swat on the backside.");
		//(\"<i>Horsewhip</i>\" option opened in main \"<i>Punish</i>\" menu)
	}
	//First repeat: 
	else if (flags[kFLAGS.TIMES_RIDDEN_KELLY_FOR_PUNISHMENT] == 2) {
		outputText("Without another word, you stride over to the stones underneath which you secreted the riding gear.  Kelly watches you with deep apprehension, and then bursts into protests as you return, carrying the heap of clinking leather and metal.");
		
		outputText("\n\n\"<i>No, [Master] please no, I don't want that, I've learnt my lesson, I'll be good for now on, punish me any way you see fit but not that...</i>\"");
		
		outputText("\n\n\"<i>Shush now, ass,</i>\" you say calmly; the epithet immediately silences her. \"<i>This is for your own good, you know that.  Hard lessons are the best lessons, and you will thank me for it later.  Now stay still.</i>\"  She sets her jaw and does as you ask; you soothingly remark upon her bravery as you equip her as you did before, saddle, stirrups, harness, blinkers and bit, before firmly binding her arms behind her back.  You've got an extra treat for her this time, though.  You rummage around in the saddlebags and then lift them up so she can see them in her limited sightline, and her eyes widen.");
		
		outputText("\n\n\"<i>I think they were originally supposed to be fixed upon a mantle for festivals or something,</i>\" you say conversationally, as you fix the pink tassels to each of her erect nipples. \"<i>But as you can see... they fit upon a slut's fuck pillows perfectly well.");
		if (flags[kFLAGS.KELLY_BONUS_TIT_ROWS] > 0) outputText("  Just as well there were four of them, eh?");
		outputText("</i>\" You step back to admire the effect.  Kelly stares back at you behind her leather straps and ball gag, her tasselled boobs forced outwards by her arms bound behind her back.  You laugh and stroke her face; she closes her eyes and bends into it, enjoying the simple motion of her [Master]'s hand.");
		
		outputText("\n\n\"<i>You look so adorable like that,</i>\" you say.  \"<i>But it's no good if only I can see you, is it?</i>\"  She opens her eyes wide to that.");
		
		//PC rider: 
		if (player.tallness < 78 && !player.isTaur()) {
			outputText("\n\nWithout another word you grab hold of her waist and swing yourself onto her back.  \"<i>Head towards the desert,</i>\" you breathe into her ear as you take hold of the reigns.  \"<i>I think you know where we're going,</i>\" Kelly whimpers, and then sets off at a trot.");
			
			outputText("\n\nThanks to Mareth's warped geography it doesn't take you long to arrive at the gates of Tel'Adre.  The guards on duty raise their eyebrows at your mount, her tassels flicking and whipping gaily in the warm breeze, sweat beading on her skin.");
			
			outputText("\n\n\"<i>Don't worry about her,</i>\" you call up casually. \"<i>She's just learning a lesson.</i>\" You have no idea how this works as a valid explanation, but already knowing your face and having seen all manner of centaur entering and leaving all day long, the cat and hare let her pass after a cursory magical examination.  The crystal glows, but not enough to straight-up deny Kelly entrance.");
			
			outputText("\n\nUpon the close streets though everyone stares; even for as liberal a place as Tel'Adre the sight of a " + player.race() + " riding a practically naked, bound and gagged centauress draws a slight hush and open mouths.  The centaur you canter past in particular look absolutely gobsmacked; by turns unbelieving, disgusted, or shocked into laughter.  Nobody attempts to stop you though and you affect to be completely unaware of the attention; you after all are a champion upon an important errand.  But you know the attention and pure humiliation are soaking into Kelly when she makes a sobbing, muffled moan.");
			
			outputText("\n\n\"<i>Did you come here before I owned you, ass?</i>\" you wonder aloud.  \"<i>You know, before I gave you those big bouncing tits everyone is staring at, or that nice succulent hole I replaced your dick with.   I bet you did- you knew exactly where I wanted you to go.  Perhaps you even found some of your \"<i>wives</i>\" here, back in the day.  Probably strode these cobbles like you owned them.  I bet you were kicked out for being that much of an asshole, or for raping the wrong person.  Awww, don't be upset!</i>\" You kindly reach around her blinkers and wipe her tears away.  \"<i>You're a different person now, and you're learning to be better, bit by bit.  Isn't that right?</i>\" Kelly manages a choked \"<i>uh huh</i>\" and you grin.");
			
			outputText("\n\nYou make her stop and leave her outside a cosmetics shop you spot; you return carrying a box of ribbons.  When you approach her back end, you are almost keeled over by the pheromone stench coming off it - her pussy is absolutely soaked.  The centauress is breathing heavily, trying valiantly to do what you are doing and not notice the clutches of people and centaur stopping, staring and muttering to themselves. What a masochist, you think to yourself in wonder.  The smell of her eager pussy has swarmed over your brain and then unstoppably down into your groin, leaving there a hot, leaden weight of need, and there's only one thing to do.");
			
			outputText("\n\nYou lead her down a side alley - giving a hard look to the onlookers which makes most of them remember they have business elsewhere - and then, braced against her formidable weight, fuck her hard.  She mums and hums and whinnies around her gag, her tassels twirling merrily as you jerk her body furiously, lost in her mass and her wet, clenching tunnel.  It's a secluded area but you can still hear giggles and gasps at the fringes of your conscience; they are meaningless to you but you suspect to Kelly they are as loud as voices in her ear.  Her pussy spasms around your " + player.cockDescript(x) + " and absolutely soaks your [hips] with girl juice; in response you grab her flanks and cum, sighing raggedly as you shoot your load deep into her, orgasm clenching your body.  You withdraw slowly, noting with satisfaction that her pussy is now drooling your ejaculate.");
			
			outputText("\n\n\"<i>Good girl,</i>\" you say at last. \"<i>Have a present.</i>\" You withdraw your box of ribbons and tie one around her demonic tail.  \"<i>When we leave I want you to hold your tail up high.  So everyone can see the present your [master] gave you.</i>\"  You take her ragged moan to mean she understands exactly your intent.");
			
			outputText("\n\nYou leave Tel'Adre exactly the way you came, you saddled calmly upon Kelly's back, twitching your reigns occasionally to direct her; she rears her tail up high so that everyone can see her oozing cream pie, her bow bobbing just as prettily as her tassels as you leave a wet trail behind you.");
		}
		//PC not rider: 
		else {
			outputText("You grab hold of the reigns and stride off; after a short jerk Kelly follows behind you.  \"<i>We're heading to the desert,</i>\" you announce.  \"<i>I think you can maybe guess where.  Remember; flick those legs high, prance a little, make those tassels whirl.  You represent your [Master], and you don't want " + player.mf("him","her") + " to look bad, do you?</i>\"  There's a muffled whimper in response.");
			outputText("\n\nThanks to Mareth's warped geography it doesn't take you long to arrive at the gates of Tel'Adre.  The guards on duty raise their eyebrows at your partner, her tassels flicking and whipping gaily in the warm breeze, sweat beading on her skin.");
			
			outputText("\n\n\"<i>Don't worry about her,</i>\" you call up casually.  \"<i>She's just learning a lesson.</i>\"  You have no idea how this works as a valid explanation, but already knowing you and having seen all manner of centaur entering and leaving all day long, the cat and hare morph turn away.");
			
			outputText("\n\nUpon the close streets though everyone stares; even for as liberal a place as Tel'Adre the sight of a " + player.race() + " leading a practically naked bound and gagged centauress draws a slight hush and open mouths.  The centaurs you canter past in particular look absolutely gobsmacked; by turns unbelieving, disgusted, or shocked into laughter.  Nobody attempts to stop you though and you affect to be completely unaware of the attention; you after all are a champion upon an important errand.  But you know the attention and pure humiliation is soaking into Kelly when she makes a sobbing, muffled moan.");
			
			outputText("\n\n\"<i>Did you come here before I owned you, ass?</i>\" you wonder aloud.  \"<i>You know, before I gave you those big bouncing tits everyone is staring at, or that nice succulent hole I replaced your dick with.  I bet you did - you knew exactly where I wanted you to go.  Perhaps you even found some of your \"<i>wives</i>\" here, back in the day.  Probably strode these cobbles like you owned them.  I bet you were kicked out for being that much of an asshole, or for raping the wrong person.  Awww, don't be upset!</i>\"  You kindly reach around her blinkers and wipe her tears away.  \"<i>You're a different person now, and you're learning to be better, bit by bit.  Isn't that right?</i>\"  Kelly manages a choked \"<i>uh huh</i>\" and you grin.");
			
			outputText("\n\nYou make her stop and leave her outside a cosmetics shop you spot; you return carrying a box of ribbons.  When you approach her back end, you are almost keeled over by the pheromone stench coming off it - her pussy is absolutely soaked.  The centauress is breathing heavily, trying valiantly to do what you are doing and not notice the clutches of people and centaurs stopping, staring and muttering to themselves. What a masochist, you think to yourself in wonder.  The smell of her eager pussy has swarmed over your brain and then unstoppably down into your groin, leaving there a hot, leaden weight of need, and there's only one thing to do.");
			
			outputText("\n\nYou lead her down a side alley- giving a hard look to the onlookers which makes most of them remember they have business elsewhere - and then, braced against her formidable weight, fuck her hard.  She mums and hums and whinnies around her gag, her tassels twirling merrily as you jerk her body furiously, lost in her mass and her wet, clenching tunnel.  It's a secluded area but you can still hear giggles and gasps at the fringes of your conscience; they are meaningless to you but you suspect to Kelly they are as loud as voices in her ear.  Her pussy spasms around your " + player.cockDescript(x) + " and absolutely soaks your [hips] with girl juice; in response you grab her flanks and cum, sighing raggedly as you shoot your load deep into her, orgasm clenching your body.  You withdraw slowly, noting with satisfaction that her pussy is now drooling with your ejaculate.");
			outputText("\n\n\"<i>Good girl,</i>\" you say at last.  \"<i>Have a present.</i>\"  You withdraw your box of ribbons and tie one around her demonic tail. \"<i>When we leave I want you to hold your tail up high.  So everyone can see the present your [master] gave you.</i>\"  You take her ragged moan to mean she understands exactly your intent.");

			outputText("\n\nYou leave Tel'Adre exactly the way you came, you calmly striding ahead of Kelly, twitching your reigns occasionally to direct her; she rears her tail up high so that everyone can see her oozing cream pie, her bow bobbing just as prettily as her tassels as you leave a wet trail behind you.");
		}
		outputText("\n\nThis final humiliation has her breathing wetly and volubly into her gag by the time you are back to camp, somewhere between pants of desire and sobs of misery.  You strip her of her gear and to show you can be a kind [Master] too you let her suck you off, the hard, shame-tinted memory of the last couple of hours suffixed by the joy of what she does best.");
		//[Not centaur: 
		if (!player.isTaur()) outputText("   You sigh and enjoy the sight of her pretty head bobbing over your groin, your " + player.cockDescript(x) + " encapsulated in soft shifting blankets of wet mouth flesh, your ears filled with her slurps and muffled sighs.  You are quickly pushed towards a new high by the worshipful treatment; you give her what she wants and cum in her mouth, letting her savor your texture and flavor; she closes her eyes and swallows, orgasm shuddering through her as it hits her stomach.  You smile and hold her face as she basks in an afterglow earned from pure debasement.");
		else outputText("  You sigh and enjoy your " + player.cockDescript(x) + " encapsulated in soft shifting blankets of wet mouth flesh, your ears filled with her slurps and muffled sighs.  You are quickly pushed towards a new high by the worshipful treatment; you give her what she wants and cum in her mouth, letting her savor your texture and flavor; she closes her eyes and swallows, orgasm shuddering through her as it hits her stomach.  You smile, turn and hold her face as she basks in an afterglow earned from pure debasement.");
		
		outputText("\n\n\"<i>What do you say?</i>\"");
		
		outputText("\n\n\"<i>Thank you, [Master],</i>\" she says, smiling at you devotedly.  Her voice hardens.  \"<i>You were right.  I deserved that punishment, because from it I will learn to make sure you never have to do it again.  I will be the most obedient cumslut there ever was!</i>\"  You smile and tell her to run along for now.  Your smile widens as you watch her leave.  You know for a fact from the events of today that Kelly will never learn; as a complete masochist she will seek your punishments again and again, consciously or subconsciously.  And you want nothing more than to make her happy.");
		kellyPreggers();
	}
	//Second+ repeat: 
	else {
		outputText("Without another word, you stride over to the stones underneath which you secreted the riding gear.  Kelly watches you with deep apprehension, and then bursts into protests as you return, carrying the heap of clinking leather and metal.");
		
		outputText("\n\n\"<i>No [Master] please no, I don't want that, I've learnt my lesson, I'll be good for now on, punish me any way you see fit but not that...</i>\"");
		
		outputText("\n\n\"<i>Shush now, ass,</i>\" you say calmly; the epithet immediately silences her.  \"<i>This is for your own good, you know that.  Hard lessons are the best lessons, and you will thank me for it later.  Now stay still.</i>\"  She sets her jaw and does as you ask; you soothingly remark upon her bravery as you equip her as you did before, saddle, stirrups, harness, blinkers and bit, before firmly binding her arms behind her back.  She does whine when you fit the tassels and ribbon upon her, which earns her a solid slap on the butt.");
		
		outputText("\n\n\"<i>I don't know why you have to be so difficult about this,</i>\" you sigh.  \"<i>You know you earned this, and you look adorable with it all on.</i>\"");
		
		//PC rider: 
		if (player.tallness < 78 && !player.isTaur())
		{
			outputText("\n\nWithout another word you grab hold of her waist and swing yourself onto her back.  \"<i>You know where you're going,</i>\" you breathe into her ear.  Kelly whimpers, and then sets off at a trot.");
			
			outputText("\n\nThanks to Mareth's warped geography it doesn't take you long to arrive at the gates of Tel'Adre.  The guards on duty look at you, then look away.  Evidently word is getting around.");
			
			outputText("\n\nUpon the close streets though everyone stares; even for as liberal a place as Tel'Adre the sight of a " + player.race() + " riding a practically naked bound and gagged centauress draws a slight hush and open mouths, even among the ones who have already seen this display.  The centaur you canter past in particular look absolutely gobsmacked; by turns unbelieving, disgusted, or shocked into laughter.  Nobody attempts to stop you though and you affect to be completely unaware of the attention; you after all are a champion upon an important errand.  But you know the attention and pure humiliation are soaking into Kelly when she makes a sobbing, muffled moan.");
			
			outputText("\n\n\"<i>Awww, don't be upset!</i>\"  You kindly reach around her blinkers and wipe her tears away.  \"<i>Everyone might be able to see you're an owned little cocksleeve, you might see faces from back when you had things like dignity and respect, but this is how you'll learn to be better, bit by bit.  Isn't that right?</i>\" Kelly manages a choked \"<i>uh huh</i>\" and you grin.");
			
			outputText("\n\nYou make her stop and leave her outside a sex shop you spot; you return carrying an unmarked box.  When you approach her back end, you are almost keeled over by the pheromone stench coming off it - her pussy is absolutely soaked.  The centauress is breathing heavily, trying valiantly to do what you are doing and not notice the clutches of people and centaur stopping, staring and muttering themselves.  Although you were expecting it, the smell of her eager pussy still hits your bloodstream like a sugar high, racing down to your groin, leaving there a hot, leaden weight of need.");
			
			outputText("\n\nYou lead her down a side alley - giving a hard look to the onlookers which makes most of them remember they have business elsewhere- and then, braced against her formidable weight, slowly dip your " + player.cockDescript(x) + " into her cunt until it is completely slathered in girl slime.  She sighs to the agonisingly gentle treatment and then gives out a muffled cry out of shock as you withdraw completely and, using the lubrication she provided, push into her tight asshole.");
			
			outputText("\n\nIt takes a while to work her loose enough to fuck, but she of course is a naturally talented buttslut, her orifices only too eager to accept you.  She mums and hums and whinnies around her gag to the intense sensation, her tassels twirling merrily as you jerk her body furiously, lost in her mass and her tight, clenching tunnel.  It's a secluded area but you can still hear giggles and gasps at the fringes of your conscience; they are meaningless to you but you suspect to Kelly they are as loud as voices in her ear.  Her pussy spasms against your [hips] and absolutely soaks them with girl juice; in response you grab her flanks and cum, sighing raggedly as you shoot your load deep into her, orgasm clenching your body.  You withdraw slowly, noting with satisfaction that her ass is now gaping and drooling your ejaculate.");
			
			outputText("\n\n\"<i>Good girl,</i>\" you say at last. \"<i>Have a present.</i>\"  You bring out the box you bought and withdraw a buttplug, gleaming a dull purple in the sunlight which filters down into the tall alley.  \"<i>I know you got upset when you lost my cum so easily the first time,</i>\" you say as you wedge it into your mare, who groans.  \"<i>So now you'll be able to savor it all the way home! Now remember... tail high...</i>\"");
			
			outputText("\n\nYou leave Tel'Adre exactly the way you came, you saddled calmly upon Kelly's back, twitching your reigns occasionally to direct her; she rears her tail up high so that everyone can see the purple sex toy sunk into her, her bow bobbing just as prettily as her tassels as, her bowels sloshing with your seed.");
		}
		//PC not rider: 
		else {
			outputText("\n\nWithout another word you grab hold of the reigns and jerk them.  \"<i>You know where you're going,</i>\" you breathe into her ear.  Kelly whimpers, and then sets off behind you at a trot.");
			outputText("\n\nThanks to Mareth's warped geography it doesn't take you long to arrive at the gates of Tel'Adre.  The guards on duty look at you, then look away.  Evidently word is getting around.");
			
			outputText("\n\nUpon the close streets though everyone stares; even for as liberal a place as Tel'Adre the sight of a " + player.race() + " leading a practically naked bound and gagged centauress around like a show horse draws a slight hush and open mouths, even among the ones who have already seen this display.  The centaur you canter past in particular look absolutely gobsmacked; by turns unbelieving, disgusted, or shocked into laughter.  Nobody attempts to stop you though and you affect to be completely unaware of the attention; you after all are a champion upon an important errand.  But you know the attention and pure humiliation are soaking into Kelly when she makes a sobbing, muffled moan.");
			
			outputText("\n\n\"<i>Awww, don't be upset!</i>\" You kindly reach around her blinkers and wipe her tears away.  \"<i>Everyone might be able to see you're an owned little cocksleeve, you might see faces from back when you had things like dignity and respect, but this is how you'll learn to be better, bit by bit.  Isn't that right?</i>\" Kelly manages a choked \"<i>uh huh</i>\" and you grin.");
			
			outputText("\n\nYou make her stop and leave her outside a sex shop you spot; you return carrying an unmarked box.  When you approach her back end, you are almost keeled over by the pheromone stench coming off it- her pussy is absolutely soaked.  The centauress is breathing heavily, trying valiantly to do what you are doing and not notice the clutches of people and centaur stopping, staring and muttering themselves.  Although you were expecting it, the smell of her eager pussy still hits your bloodstream like a sugar high, racing down to your groin to leaving there a hot, leaden weight of need.");
			
			outputText("\n\nYou lead her down a side alley - giving a hard look to the onlookers which makes most of them remember they have business elsewhere - and then, braced against her formidable weight, slowly dip your " + player.cockDescript(x) + " into her cunt until it is completely slathered in girl slime.  She sighs to the agonizing treatment and then gives out a muffled cry out in shock as you withdraw completely and, using the lubrication she provided, push into her tight asshole.");
			
			outputText("\n\nIt takes a while to work her loose enough to fuck, but she of course is a naturally talented buttslut, her orifices only too eager to accept you.  She mums and hums and whinnies around her gag to the intense sensation, her tassels twirling merrily as you jerk her body furiously, lost in her mass and her tight, clenching tunnel.  It's a secluded area but you can still hear giggles and gasps at the fringes of your conscience; they are meaningless to you but you suspect to Kelly they are as loud as voices in her ear.  Her pussy spasms against your [hips] and absolutely soaks them with girl juice; in response you grab her flanks and cum, sighing raggedly as you shoot your load deep into her, orgasm clenching your body.  You withdraw slowly, noting with satisfaction that her ass is now gaping and drooling your ejaculate.");
			
			outputText("\n\n\"<i>Good girl,</i>\" you say at last. \"<i>Have a present.</i>\"  You bring out the box you bought and withdraw a buttplug, gleaming a dull purple in the sunlight which filters down into the tall alley.  \"<i>I know you got upset when you lost my cum so easily the first time,</i>\" you say as you wedge it into your mare, who groans.  \"<i>So now you'll be able to savor it all the way home! Now remember... tail high...</i>\"");
			
			outputText("\n\nYou leave Tel'Adre exactly the way you came, you calmly leading Kelly, twitching your reigns occasionally to direct her; she rears her tail up high so that everyone can see the purple sex toy sunk into her, her bow bobbing just as prettily as her tassels, her bowels sloshing with your seed.");
		}
		//All go to: 
		outputText("\n\nThis final humiliation has her breathing wetly and volubly into her gag by the time you are back to camp, somewhere between pants of desire and sobs of misery.  You strip her of her gear, throw the butt plug away and to show you can be a kind [Master] too you let her suck you off, the hard, shame-tinted memory of the last couple of hours suffixed by the joy of what she does best.");
		//[Not centaur: 
		if (!player.isTaur()) outputText("  You sigh and enjoy the sight of her pretty head bobbing over your groin, your " + player.cockDescript(x) + " encapsulated in soft shifting blankets of wet mouth flesh, your ears filled with her slurps and muffled sighs.  You are quickly pushed towards a new high by the worshipful treatment; you give her what she wants and cum in her mouth, letting her savor your texture and flavor; she closes her eyes and swallows, orgasm shuddering through her as it hits her stomach.  You smile and hold her face as she basks in an afterglow earned from pure debasement.");
		//[Centaur:]
		else outputText("  You sigh and enjoy your " + player.cockDescript(x) + " encapsulated in soft shifting blankets of wet mouth flesh, your ears filled with her slurps and muffled sighs.  You are quickly pushed towards a new high by the worshipful treatment; you give her what she wants and cum in her mouth, letting her savor your texture and flavor; she closes her eyes and swallows, orgasm shuddering through her as it hits her stomach.  You smile, turn and hold her face as she basks in an afterglow earned from pure debasement.");
		
		outputText("\n\n\"<i>What do you say?</i>\"");
		
		outputText("\n\n\"<i>Thank you, [Master],</i>\" she says, smiling at you devotedly.  Her voice hardens. \"<i>You were right.  I deserved that punishment, because from it I will learn to make sure you never have to do it again.  I will be the most obedient cumslut there ever was!</i>\" You smile and tell her to run along for now.  Your grin widens as you watch the girl who never learns leave.");
	}
	player.orgasm();
	dynStats("sen", -1, "cor", .5);
	doNext(camp.returnToCampUseOneHour);
}


private function takeKellysVirginity():void {
	clearOutput();
	var x:int = player.cockThatFits(300);
	if (x < 0) x = player.smallestCockIndex();
	
	outputText("You tell Kelly that you intend to come claim the prize you broke her for - her virgin ");
	if (flags[kFLAGS.KELLY_CUNT_TYPE] == 1) outputText("horse-");
	outputText("cunt.");
	
	outputText("\n\nThe female centaur fidgets nervously, her hoof pawing at the dirt indecisively, her hands wringing. \"<i>Will it hurt?</i>\" she asks.  Her body shudders nervously, shaking her large, pert breasts enticingly.  Confidently, you place your hand on her arm and give a reassuring squeeze.");
	
	outputText("\n\n\"<i>For a slut like you?  Kelly, you were made to be a sex toy.  Getting fucked will be as right and natural as breathing.</i>\"  Your submissive little mare gives a wan smile, flushing hotly.  Her nipples have already perked up, and you can smell her feminine arousal in the air, the potent fragrance already stirring the burgeoning hardness concealed within your [armor].  Yes, this little filly is going to love it.");
	
	outputText("\n\nYou command, \"<i>Lie down on your flank.  I don't want your legs going out on me mid-fuck once you realize how good being my breeding bitch can be.</i>\"");
	
	outputText("\n\nNodding meekly, Kelly lowers herself to the ground and flops onto her side with an absolute lack of grace.   Her tail curls up behind her back in order to expose her ");
	if (flags[kFLAGS.KELLY_CUNT_TYPE] == 1) outputText("lust-swollen, black-lipped fuck-hole");
	else outputText("blooming, pink-tinged pussy");
	outputText(" to your roving eyes.  She asks, \"<i>Is th-th-this good, [Master]?</i>\"");
	
	outputText("\n\nYou kneel behind her, pushing a thumb into that slick entrance, testing it, rubbing in tiny circles, admiring the webs of moist lubricant that hang across that entrance as you slowly accustom it to penetration.  Kelly begins to make quiet sounds of pleasure, little \"<i>Ahhhs</i>\" and \"<i>Oooohs</i>\" that leave no doubt as to her state.  Her clitty quickly grows erect from your attentions, a taut bud that makes her moan whenever you brush a wet digit across it.  Her steamy hole is soon as ready as your thumb can make it, so you switch to inserting your middle and index fingers into the juicy slit, spreading her entrance around the dual intruders.  She whimpers as you forcibly open her, dilating her sodden");
	if (flags[kFLAGS.KELLY_CUNT_TYPE] == 1) outputText(", equine");
	outputText(" cunt until her hymen is easily visible.  You rub every sensitive fold that you can get to");
	
	if (flags[kFLAGS.KELLY_CUNT_TYPE] == 1) outputText(", taking time to squeeze her plush, onyx vulva teasingly.  Kelly whinnies in response, overtaken by her potent equine instincts.");
	else outputText(", taking time to fondle her slick labia.  Kelly moans in response, overtaken by the sensations you're forcing through her.");
	
	outputText("\n\n\"<i>You like that, don't you, cunt?</i>\" you ask, still molesting your equestrian toy with faster strokes.");
	
	outputText("\n\nKelly moans, \"<i>Y-yes!  It feels so good... it's... oohhhh... it's so sensitive!  Like I'm gonna be cumming all the time, just from your fingers...</i>\"  She fidgets nervously, vaginal muscles contracting around your busy hand as she nears orgasm.  There's a virtual torrent of fem-slime leaking out around your intruding, molesting digits, puddling underneath her.  She's finally ready.");
	
	outputText("\n\nThe four-legged slut cries out in displeasure as you stop fingerfucking her.  \"<i>Please, please don't stop!</i>\"  Her tanned cheeks are flushed ruddy red, and she's shamelessly toying with her nipples, shifting her hindlegs eagerly, her cunt squishing audibly with hunger.");
	
	outputText("\n\n\"<i>I'm not stopping, you dumb horse-cunt,</i>\" you answer, accompanied by a rough smack to her haunches.  \"<i>You're mine, and to you there's no greater pleasure than serving me - even if you don't get to cum.  You got that, bitch?</i>\"  You spank her again, watching the heavy flow of lubricant intensify.  The air is inundated with her rich, female odor, a testament to just how true your words ring.  Kelly pants, pleading with her eyes and lifting one of her hind-legs as high as her beastly body will allow, to spread herself as open as possible.  Her tail flicks about anxiously while your pet abuses her own nipples, lost in the throes of submissive bliss.");
	
	outputText("\n\nDeciding that it's time to finally claim your new slut's maidenhead, you ");
	if (!player.isTaur()) outputText("get down behind her and line your " + player.cockDescript(x) + " with her dribbling lips.");
	else outputText("lie down behind her, sliding your hindlegs behind hers in order to properly align your " + player.cockDescript(x) + " with her dribbling lips.");
	outputText("  The first contact of " + player.cockHead(x) + " on her feminine mound sends an electric current of pleasure through your member, one that has you immediately and heedlessly pushing forward, sliding your full, sensitive phallus as deeply into that slick opening as you can.  That turns out not to be very far, as you almost immediately hit her virginal hymen.  It blocks off the rest of that hot, dripping hole almost spitefully.");
	
	outputText("\n\nYou squeeze Kelly's ");
	if (player.isTaur()) outputText("breast as you snuggle up behind her, centaur to centaur,");
	else outputText("ass");
	outputText(" and laugh, \"<i>Here it comes, you eager whore!</i>\"  Then, you spear through her entrance with one powerful thrust.  In that second, her pussy somehow gets even hotter and warmer around your girth, and you sink yourself as deeply as you can");
	if (player.cockArea(x) <= 300)
	{
		outputText(", nestling your [sheath] up against her ");
		if (flags[kFLAGS.KELLY_CUNT_TYPE] == 1) outputText("plump, equine cunt-lips");
		else outputText("slippery, pink cunt-lips");
	}
	else outputText(", pressing your " + player.cockHead(x) + " up against the barrier her cervix makes");
	outputText(".  A pinkish froth oozes out around you, tinted by the few drops of blood that claiming her generated.  Kelly made a pained face as you took her, but now, she's back to panting and moaning like a whore.");
	
	outputText("\n\nYou pull on her tail as you begin to slide in and out, asking, \"<i>Did you like that, slut?  Does your cunt like being broken in by a real " + player.mf("man","breeder") + "'s cock?</i>\"");
	
	outputText("\n\nKelly moans, \"<i>Y-yes!  My... pussy...  My pussy feels so good!  It's so good to be yours, [Master]!</i>\"  Her eyes cross slightly as her pussy begins to squeeze down around you, driven by instinctual desires the lust-crazed centauress barely understands.  She's been so conditioned to obey that when her body tells her to do something (like milk your " + player.cockDescript(x) + "), she doesn't question - she simply, deliciously complies, her pussy growing ever-wetter from her submissiveness.");
	
	outputText("\n\nWith the pain of her deflowering little more than a memory, Kelly is free to give in to the pleasure you're forcing through her powerful, centaur frame.  She cums almost immediately, moist fluids spattering your groin, the fruit of her passion mixed with all the wetness-enhancing drugs you force-fed her when you created her.  Her channel's gentle milking motions accelerate, squeezing tighter and tighter around you, more forcefully.  It feels good, but you endure, sawing your [hips] in and out of her again and again, determined to enjoy this pleasure as long as you can.");
	
	outputText("\n\nKelly squirms and moans, shuddering again and again as you drive her to orgasm after orgasm.  After a few climaxes as juicy as the first, Kelly's eyes roll back and her tongue lolls out. She stops talking, simply grunting every time you slam against her and moaning with each draw back.  You fuck her until you're sure her body will never forget the feeling of wrapping around your " + player.cockDescript(x) + ", and then you fuck her some more.  You fuck her until her human half flops down on the ground like the rest of her, limply spasming while her well-plowed vagina nervelessly spasms around you.");
	
	outputText("\n\nGlorying over your conquest, you finally allow yourself release, and the long-pent-up fruit of your mating rushes forth with a surge of accompanying bliss.  You throw your head back as you erupt inside the trembling horse-girl's pussy, basting the inside of her quim white, all the way from her slit to her cervix.");
	if (player.cumQ() >= 500) {
		outputText("  You even have enough jism to make sure that some is squirting into her womb and drizzling out of her entrance, mixing with her clear fluids to make a runny, off-wet mess down her rump.");
		if (player.cumQ() >= 1500) outputText("  In no time flat, her belly has begun to round slightly, puffed up with spunk.");
		if (player.cumQ() >= 3500) outputText("  That doesn't stop you from seeding it even further, pumping her poor horse-gut until it jiggles and jostles with your spermy cargo.  There's no way she'll forget this.");
	}
	
	outputText("\n\nYou pull out with a self-satisfied sigh, admiring ");
	if (flags[kFLAGS.KELLY_CUNT_TYPE] == 0) outputText("the redness of her well-used cunt.");
	else outputText("the shining juices that drip from her oh-so-equine entrance, gilding the smooth onyx lips with a slimey sheen.");
	outputText("  Kelly has passed out in a puddle of her own making, and you leave her like that, getting dressed without a backwards glance.");
	kellyPreggers();
	player.orgasm();
	dynStats("sen", -3, "cor", .5);
	flags[kFLAGS.KELLY_VAGINALLY_FUCKED_COUNT]++;
	doNext(camp.returnToCampUseOneHour);
}

//TFs
//Canine Pepper
private function giveKellyAPepper():void {
	clearOutput();
	//First: 
	if (flags[kFLAGS.KELLY_TIMES_PEPPERED] == 0) {
		outputText("You instruct Kelly to open wide; you've got something that will allow her to serve her [master] even better.  You imagine she once saw Whitney farm these things, but if your centauress slave knows its properties she doesn't show it; dutifully she opens her mouth, making an \"<i>aaaaaaah</i>\" noise until you pop the glossy red fruit onto her tongue.  You stand back and watch as she munches thoughtfully and then swallows.");
		
		outputText("\n\n\"<i>S'quite nice.  Spicy.  I don't know what it's supposed to do th-oh.  Ohhhh...</i>\" She closes her eyes and moans as flesh burgeons and balloons underneath her tits.  Nubs form in the softness and then darken, leaving her finally with a second row of breasts- smaller than her first but still at least C cups.  You smirk and take a few steps back and forth to properly take in her new curves; the soft obscenity of it is perfect for a slaveslut like her, and [eachCock] begins to harden at the thought of sliding it between those four pillows.");
		
		outputText("\n\nThe tits aren't the only thing the pepper has done to Kelly.  As her hands roam uncertainly over her new anatomy her breath comes in short gasps, her eyes locked upon you, even more filled with helpless lust than usual.  You can practically smell the pheromones radiating off her; she has gone into heat.");
		
		outputText("\n\n\"<i>[Master], please...</i>\" she moans.  You draw into her, cup one of her new breasts and gently play with a nipple until you can hear the steady drip of her pussy juices on the dirt behind her, before saying maybe later; she needs to get used to her new body and you don't have time to satisfy the needs of a slut right now.  You turn and leave with a satisfied smile, the sound of the fitful hooves and whimper of a centaur impossibly turned on and incapable of doing anything about it in your ears.");
		//[Second row of breasts added]
		//[Kelta 15% more likely to conceive for 2 days]
		flags[kFLAGS.KELLY_BONUS_BOOB_ROWS] = 1;
		flags[kFLAGS.KELLY_HEAT_TIME] = 48;
	}
	//Repeat:
	else {
		outputText("You grin and dangle the pepper in front of Kelly's face wordlessly.  The centauress knows what's coming and color spreads across her cheeks; however, she still opens wide and accepts the \"<i>gift</i>\", chewing slowly and swallowing.");
		//If no second row:
		if (flags[kFLAGS.KELLY_BONUS_BOOB_ROWS] == 0) {
			outputText("\n\nShe closes her eyes and moans as flesh burgeons and balloons underneath her tits.  Nubs form in the softness and then darken, leaving her finally with a second row of breasts- smaller than her first but still at least C cups.  You smirk and take a few steps back and forth to properly take in her new curves; the soft obscenity of it is perfect for a slaveslut like her and [eachCock] begins to harden at the thought of sinking it between those four pillows.");
			outputText("\n\nThe tits aren't the only thing the pepper has done to Kelly.  As her hands roam uncertainly over her new anatomy her breath comes in short gasps, her eyes lock upon you, even more filled with helpless lust than usual.  You can practically smell the pheromones radiating off her; she has gone into heat.");
			
			outputText("\n\n\"<i>[Master], please...</i>\" she moans.  You draw into her, cup one of her new breasts and gently play with a nipple until you can hear the steady drip of her pussy juices on the dirt behind her, before saying maybe later; she needs to get used to her new body and you don't have time to satisfy the needs of a slut right now.  You turn and leave with a satisfied smile, the sound of the fitful hooves and whimper of a centaur impossibly turned on and incapable of doing anything about it in your ears.");
		}
		//If second row:
		else {
			outputText("\n\nThere are no outward effects this time, but it was the inward effect you were looking for, and sure enough Kelly begins to click her hooves fretfully as heat overtakes her, the smell of hopelessly horny mare quickly becoming overwhelming.");
			outputText("\n\n\"<i>[Master], please fuck me,</i>\" she whimpers. \"<i>Fuck me until I can't walk anymore, fuck me until all I can taste is your essence, I need your seed anyway and being like this... this... is unbearable.</i>\" You laugh and rub her flank, telling her she's so cute when she's desperate and who knows? If she's a good girl you might deign to meet her request.  You turn and leave.");
			//[Kelta 15% more likely to conceive for 2 days]
		}
		flags[kFLAGS.KELLY_HEAT_TIME] += 48;
	}
	flags[kFLAGS.KELLY_TIMES_PEPPERED]++;
	player.consumeItem(consumables.CANINEP);
	doNext(camp.returnToCampUseOneHour);
}

//Titjob
//[Requires: Not a centaur]
//[If [dick0] larger than 18 inches: Requires Kelly have 4 breasts]
private function kellyTitJob():void {
	clearOutput();
	
	var x:int;
	
	if (flags[kFLAGS.KELLY_BONUS_BOOB_ROWS] == 0) x = player.cockThatFits(18,"length");
	else x = player.biggestCockIndex();
	
	outputText("As Kelly eagerly trots towards you your eyes are naturally drawn to her breasts, bouncing gently with her swaying canter.  They are just slightly too big and pert to be of non-demonic origin; every step she takes makes them palpitate, her fat, tan curves dancing for you in the sunlight, her erect nipples begging to be touched and teased");
	//[Lactation:
	if (pregnancy.isPregnant) outputText(", glittering beads of milk flicking here and there as she advances");
	outputText(".  The weight of them must be a constant reminder to her of the obscene changes you have wrought upon her body, of the deep need you have implanted into her mind, of the fact she is shaped the way she is because you have willed it.  Your " + player.cockDescript(x) + " is straining against your [armor] by the time Kelly has come to a halt in front of you, her lips parting and her nipples hardening even further as she pushes into your aura.  She grins coquettishly when she sees where you're staring, turning her eyes downwards and then slowly back to yours.");
	outputText("\n\n\"<i>Does [Master] see something " + player.mf("he","she") + " likes?</i>\" There is no question in your lust reddened mind of how you're going to satisfy yourself.");
	
	outputText("\n\n\"<i>On the ground,</i>\" you grunt, so quickened by need you can barely annunciate as you shed your clothes.  Kelly has her hooves folded obediently beneath her before you've even got your undergarments off, her grin replaced by a solemn, needful expression as your " + player.cockDescript(x) + " strains outwards, her pupils dilating, licking her plump lips unconsciously.  You smile and manage to control your urge long enough to tease her with your length a bit first, rubbing your prick slowly against her soft face, smearing her with your musk, pulling away slightly every time you feel her hot breath upon it, trying to latch her lips onto it or presenting her tongue.  You slide slowly downwards, resting it finally between her big, warm breasts.");
	
	//Dick 17 inches or less:
	if (player.cocks[x].cockLength <= 18) {
		outputText("\n\nYou hold her by the shoulders and begin to move your " + player.cockDescript(x) + " up and down her valley, sighing as Kelly clasps her breasts and squashes her softness into your length, encapsulating it in her warm, yielding flesh.  Pre leaks from your tip to the shifting, pillowy pleasure inundating your hard cock, slicking Kelly's tender skin with your scent and providing you with the lubrication you need to pick up the pace.  The centauress coos as you grip her harder and begin to fuck her pillows, her eyes closed as she is swallowed by your presence and feral smell, each second you spend using her like this making her more and more sensitive and pliant to your touch.  She is an expert by now at servicing you; as you thrust into her she rolls her wrists so that your dick is caught in gentle boobquakes, her breasts pressing tightly upon your prick from all angles one second and then pulling away the next, pressing in like the tightest pussy imaginable and then pulling away to leave nothing but yielding softness...");
		if (pregnancy.isPregnant) outputText("\n\nThe constant drizzle of milk expressing from her engorged nipples is too delicious to leave alone; you force yourself to stop your rut for a moment to tweak her damp, brown nubs, rubbing and then pressing them firmly between thumb and forefinger until her deep sighs turn into throaty moans.  You gently rub your " + player.cockDescript(x) + " over the milky streams you've caused to run down her front in rivulets, coating it in warm whiteness before sliding back into her valley.  The added lubrication make her glisteningly wet orbs practically frictionless; you growl at the slippery, encompassing warmth, fucking her now for all your worth whilst her fingers replace yours on her nipples, her mouth open in ecstasy as she replicates the sensation you pressed upon her, squeezing thin streams of milk everywhere.");
		outputText("  Her expression is one of deep concentration and as you quicken the pace and thrust further upwards she bends her chin down to lick at your head as it presents itself between her pressed together tits.");
	
		outputText("\n\n\"<i>Ooh...</i>\" she moans as she rolls her tongue around her mouth. \"<i>Why do you taste so godsdamn good, [Master]?</i>\" You are too busy to reply; your cock bulging now with real need you thrust your cock between her cleavage with all you've got, lost to everything but that sleeve of hot, wet flesh.");
		//[Kelly has four tits:
		if (flags[kFLAGS.KELLY_BONUS_BOOB_ROWS] > 0) {
			outputText("\n\nYour [hips] press upon the softness of her lower pair of tits; it dimly occurs to you what a fine idea growing a few extra inches of dickmeat to take full advantage of the shape of your centauress slave might be.");
		}
		outputText("\n\nKelly's tongue flicks intermittently over your head and she moves her boobs up and down briskly, rubbing your dick in an alternating motion as you thrust yourself upwards to a body-seizing high.  Sweat beads your brow and you throw your head back as you cum; your ears are full of the slippery sound of prick against boob and the ecstatic, muffled sounds Kelly makes as she opens her mouth wide and swallows your first load whole.  Your seed rises upwards and outwards and you ride your pulsing orgasm, thrusting your [hips] with each surge to blast your slave with jizz.");
		//[Low cum: 
		if (player.cumQ() <= 250) outputText("\n\nWhen you have finally emptied yourself, you sigh and step back to admire your handiwork.  You've given her a pretty impressive facial, her brow and cheeks splattered with your cream; however what is in range of her tongue is quickly disappearing.\n\n\"<i>Mmm... thank you for the load, [Master]!</i>\" She says, contented pleasure glittering in her eyes as she guides another oozing dollop of addiction down her throat.  You tell her she's quite welcome as you use her braid to wipe your dick clean, climb back into your [armor], and leave her to enjoy her fix.");
		else outputText("\n\nYou go on and on, driven by a deep impulse to coat her with your potency, your dick flexing out string after string of jism until it aches with pleasure and you are dripping with sweat.  After what seems like minutes upon end of orgasm, you finally sigh and step back to admire your handiwork.  Kelly's face, shoulders and hair are absolutely plastered with cum, her eyes pasted shut.  As you watch her tongue emerges and does a wide circuit of her mouth, drawing in a big dollop of jizz which is then swallowed with a hum of pure contentment.\n\n\"<i>Mmm... I'm so lucky to have a [Master] who is so virile,</i>\" she purrs.  She unsticks her eyes with her fingers and gazes at you with contented pleasure as she licks her digits clean of oozing addiction. \"<i>Thank you for giving this cumslut what she needs, [Master]!</i>\" You tell her she's quite welcome as you use her braid to wipe your dick clean, climb back into your [armor], and leave her to enjoy her fix.");
	}
	//Dick >17 inches, Kelly has four breasts:
	else {
		outputText("\n\nYou lead your prestigious prick down and down, sliding a vertical path over her warm torso until it is wedged between all four of her breasts.  Kelly is almost shaken out of her cock daze when she looks down, laughing at the sight.");
		outputText("\n\n\"<i>So that's why you made me grow four of them!</i>\" Of course, you say; your slaves have to be suitably shaped to be able to properly service a [Master] as mighty as you.  Now, you say as you hold her by the shoulders and begin to move your " + player.cockDescript(x) + " up and down her long, twin valley, hush and properly attend to your cumslut duties.");
		outputText("\n\nYou sigh as Kelly obediently clasps her top breasts and squashes her softness into your length, encapsulating it in her warm, yielding flesh.  You clasp her bottom boobs and do the same; whilst not as big as her first row, there is still more than enough plush fatness there to wrap your girth in warmth.  Pre leaks from your tip to the shifting, pillowy pleasure inundating your hard cock, slicking Kelly's tender skin with your scent; you slowly pull your " + player.cockDescript(x) + " all the way down and then up again, ensuring the full valley is given the lubrication you need to pick up the pace.  The centauress coos as you grip her harder and begin to fuck her pillows, her eyes closed as she is swallowed by your presence and feral smell, each second you spend using her like this making her more and more sensitive and pliant to your touch.");
		outputText("\n\nShe is an expert by now at servicing you; as you thrust into her she rolls her wrists so that your dick is caught in gentle boobquakes, her breasts pressing tightly upon your prick from all angles one second and then pulling away the next, pressing in like the tightest pussy imaginable and then pulling away to leave nothing but yielding softness... you try and mimic the movement with the boobs you are holding, but you simply don't have the experience at serving your prick that she does; the base of your totem-like cock is caught in soft, savage kneading whilst your more sensitive top half is being treated to a mercurial, gentle massage.");
		if (pregnancy.isPregnant) outputText("\n\nThe constant drizzle of milk expressing from her engorged nipples is too delicious to leave alone; you force yourself to stop your rut for a moment to tweak her damp, brown nubs, rubbing and then pressing them firmly between thumb and forefinger until her deep sighs turn into throaty moans.  You gently rub your " + player.cockDescript(x) + " over the milky streams you've caused to run down her front in rivulets, running it over all four of her tits until it is coated with warm whiteness, before sliding back into her obscene valley.  The added lubrication make her glisteningly wet orbs practically frictionless; you growl at the slippery, encompassing warmth, fucking her now for all your worth whilst her fingers replace yours on her nipples, her mouth open in ecstasy as she replicates the sensation you pressed upon her, squeezing thin streams of milk everywhere.");
		outputText("  Her expression is one of deep concentration and as you quicken the pace and thrust further upwards she bends her chin to lick at your head as it presents itself between her pressed together tits.");
		outputText("\n\n\"<i>Ooh...</i>\" she moans as she rolls her tongue around her mouth. \"<i>Why do you taste so godsdamn good, [Master]?</i>\" You are too busy to reply; your cock bulging now with real need you thrust your cock between her extensive cleavage with all you've got, lost to everything but that sleeve of hot, wet flesh.  Kelly's tongue flicks intermittently over your head and she moves her boobs up and down briskly, rubbing your dick in an alternating motion.  You squeeze her bottom row brutally hard, making her gasp as you thrust yourself upwards to a body-seizing high.  Sweat beads your brow and you throw your head back as you cum; your ears are full of the slimy sound of prick against boob and the ecstatic, muffled sounds Kelly makes as she opens her mouth wide and swallows your first load whole.  Your seed rises upwards and outwards and you ride your pulsing orgasm, thrusting your [hips] with each surge to blast your slave with jizz.");
		if (player.cumQ() < 250) outputText("\n\nWhen you have finally emptied yourself, you sigh and step back to admire your handiwork.  You've given her a pretty impressive facial, her brow and cheeks splattered with your cream; however what is in range of her tongue is quickly disappearing.\n\n\"<i>Mmm... thank you for the load, [Master]!</i>\" she says, contented pleasure glittering in her eyes as she guides another oozing dollop of addiction down her throat.  You tell her she's quite welcome as you use her braid to wipe your dick clean, climb back into your [armor], and leave her to enjoy her fix.");
		//High cum:
		else outputText("\n\nYou go on and on, driven by a deep impulse to coat her with your potency, your dick flexing out string after string of jism until it aches with pleasure and you are dripping with sweat.  After what seems like minutes upon end of orgasm, you finally sigh and step back to admire your handiwork.  Kelly's face, shoulders and hair are absolutely plastered with cum, her eyes pasted shut.  As you watch her tongue emerges and does a wide circuit of her mouth, drawing in a big dollop of jizz which is then swallowed with a hum of pure contentment.\n\n\"<i>Mmm... I'm so lucky to have a [Master] who is so virile,</i>\" she purrs.  She unsticks her eyes with her fingers and gazes at you with contented pleasure as she licks them clean of oozing addiction.  \"<i>Thank you so much for giving me what I need, [Master]!</i>\" You tell her she's quite welcome as you use her braid to wipe your dick clean, climb back into your [armor], and leave her to enjoy her fix.");
	}
	player.orgasm();
	dynStats("sen", -3);
	doNext(camp.returnToCampUseOneHour);
}


//Preggers
/*Chance for Kelta to be pregnant is 1% for every 20 mL, capping at 80%.*/
private function kellyPreggers():void {
	if (pregnancy.isPregnant) return;
	var x:int = Math.round(player.cumQ() / 20);
	if (x > 80) x = 80;
	if (flags[kFLAGS.KELLY_HEAT_TIME] > 0) x += 15;
	if (rand(100) + 1 <= 80) {
		pregnancy.knockUpForce(PregnancyStore.PREGNANCY_PLAYER, PregnancyStore.INCUBATION_CENTAUR - 84);
		trace("Kelly knocked up.");
	}
}
	
//Sex scene
//notice this could be adapted into a normal scene minus the paragraph referring to her pregnancy
private function kellyPregSex():void {
	clearOutput();
	var x:int;
	if (flags[kFLAGS.KELLY_CUNT_TYPE] == 1) x = player.biggestCockIndex();
	else x = player.cockThatFits(300);
	if (x < 0) x = player.smallestCockIndex();
	outputText("Maybe because of her pregnancy, the slut seems to release even more powerful scents out of her slick pussy; you actually have a clear view of her wide, parted lips exuding sexual musk.  You want to take her right now, right there, and deposit on her unborn offspring the load they truly deserve.  As if it weren't enough, Kelly is releasing copious amount of juices and whinnies meekly from time to time, as if her pregnancy makes her uneasy and she needs a big fat cock to release her tension.");
	outputText("\n\nYou remove your [armor] and watch your " + player.multiCockDescriptLight() + " grow into a rock-hard erect state under the aphrodisiac scent; you're ready to stuff the breeding mare before you.  Driven mad with lust, you jump the centaur's behind and slap her angrily, making her moan and snort in submissive pleasure.  You can't take it anymore and with feverish excitement, you grab hold of [oneCock] and plunge it deep into Kelly's dark recesses.");
 	
	outputText("\n\nThe centauress moans, screams and arches her back, but you firmly slap her ass to keep her in control.  Grasping her motherly hips for leverage, you begin to thrust in and out of her unbelievably wide love-tunnel, knowing that its boiling warmth and size are made to accustom monstrous equine members.");
	
	//if you don't have a large horsecock:
	if (player.cocks[x].cockType != CockTypesEnum.HORSE) outputText("\n\nToo bad she gets yours instead.");
	outputText("\n\nAs you pound her scented fuck-hole, you feel the hybrid slut gradually calming down and getting used to your ruthless manners; even when you slap her, the cries you hear are definitely due to lust- and pleasure-driven.  She begins to thrust in response, adapting her own hip movements to yours in order to receive more cock.  Her hot insides are sticky and smear your pole with all kinds of fluids, making obscene yet arousing squishing noises.  An enormous trail of juices leaks from her abused cunt, polluting the floor and turning it into a muddy puddle.  Your feet begin to slip in it as you move back and forth to get a better grip to fuck that centaur-pussy, but your mind doesn't register the dirtiness of the act.  Still entranced by Kelly's animalistic efflux, you solely focus on slamming as much of your [cock] as you can into her welcoming innards. You pound and pound until your legs feel wobbly and your arms grow sore, and you pound her a little more.");
	outputText("\n\nAs you have your way with the slutty centauress, you notice her bloated belly swings from side to side, making her unable to keep a stable foothold.  The bitch can't even stand properly, it seems; encouraged by that display of weakness, you give her a particularly powerful dick-push, forcing her to drop on her hind legs; weighed down by the heavy centaur-load she's carrying, she's unable to get back up, and just wiggles her pussy at you as her face lies in the dirt. With ferocious joy, you keep impaling her in earnest until you're both groaning in raw animal pleasure.  Her belly is crushed by the rest of her own body, and she seemingly enjoys getting cunt-ravaged with little care for her offspring. Amazed by the power you have over her very instincts, you give her one last dong-piercing before pouring down your load.");
 
	outputText("\n\nYou grasp her generous hips and lock yourself into her cunt as it milks you with inhuman contractions. Your " + player.cockDescript(x) + " feels sucked in, squeezed and stretched to the point you believe it might rip.  However, this little worry is quickly drowned in a sea of never-ending ecstasy, as torrents after torrents of cum are being injected into the centauress' waiting womb; you know you won't be able to knock her up more than she already is but you've made her appear more pregnant than ever.  Kelly moans, whinnies and shudders as she absorbs more and more cum into her body until she looks ready to give birth to a full tribe.  When you're done and pull out, a fountain of various fluids spurts out of her manhandled cunt, and the slut sighs in satisfaction.  She does look more healthy than before despite having been forced to eat dirt like the whore she is.  Maybe your cum will have beneficial properties to your unborn centaur kids?");
	
	player.orgasm();
	dynStats("sen", -4);
	doNext(camp.returnToCampUseOneHour);
}
 
//Giving birth
public function kellyPopsOutARunt():void {
	outputText("\n<b><u>As you visit the barn where your centaur slave usually resides, you see something unusual...</u></b>");
	outputText("\nKelly is laying on a haystack, her face red and slick with sweat but radiating tired happiness.  Curled into one of her milk-engorged breasts, hanging and suckling voraciously, is a tiny little creature that looks exactly like her mother.");
	
	outputText("\n\n\"<i>[name]! You're here! Say hi to your new kid!</i>\"");
	
	var gender:int = rand(2) + 1;
	outputText("\n\nInterested, you approach and get a better view of your union with your centaur slut.  The little foal seems to have grown quickly, probably due to the corrupting effects of ");
	if (gender == 2) outputText("her");
	else outputText("his");
	outputText(" mother's milk.");
 
	//[if female]
	if (gender == 2) outputText("\n\nA few, cute protrusions have already somewhat developed and burgeoned on her chest, although they're probably not bigger than A-cups.  Her adorable face that looks exactly like her mother's - yet with some traits that are disturbingly similar to yours - is adorned with two thirsty, perfect-for-cocksucking lips that cling to Kelly's breasts with energy, driven by an instinctive and corrupted obstination to live, grow fast and multiply beyond reason.  It's difficult to believe that your little girl will become anything other than a delicious slut just like her mother.");
	//[if male]
	else outputText("\n\nYou notice a nub hanging from his backside; his little penis is already fairly long, and would probably look more at home on a fully-grown human.  Anger and thirst are distorting his well-defined, boyish face as he sucks, driven by an instinctive and corrupted obstination to live, grow fast and multiply beyond reason.  It's difficult to believe that your little boy will become anything other than the rutting man-whore that his mother used to be.");
	
	outputText("\n\nSatisfied to see your offspring will grow strong and healthy for you, you pat Kelly's head, tell her she's a good breeding slut and walk away; the motherly centaur sighs at the compliment.  \"<i>Thank you, [name]!  You were right, this really is my place, being used and breeding beautiful sluts for you.  I hope you will treat them as well as you treated me!</i>\"");
	//[if corr > 80]
	if (player.cor > 80) outputText("\n\nYou grin as vivid pictures of how you'll be treating your soon-to-be-grown kids draw themselves in your mind. Right now they're still a little young, but someday...\n");
	if (flags[kFLAGS.KELLY_KIDS] == 0) flags[kFLAGS.KELLY_FIRST_KID_GENDER] = gender;
	flags[kFLAGS.KELLY_KIDS]++;
	if (gender == 1) flags[kFLAGS.KELLY_KIDS_MALE]++;
}

//Talk n Hand
private function talkNHandToKelly():void {
	clearOutput();
	//First: You tell her you'd just like to talk.
	if (flags[kFLAGS.KELLY_TALK_N_HAND_TIMES] == 0) {
		outputText("\"<i>Talk?  Oh, that's the least interesting thing I can do with my mouth, [Master],</i>\" Kelly purrs.  That may be, you say, but she can amuse you with her hands whilst she amuses you with her voice.  The centaur gets the picture and grins.  ");
		//Not Centaur: 
		if (!player.isTaur()) {
			outputText("She helps you take off the lower half of your [armor] as you set yourself down and then wraps her warm hand around ");
			if (player.cockTotal() == 1) outputText("[oneCock], gently tugging it.  It quickly hardens with the pleasing friction she coils around it.");
			else outputText("first your [cock], then your [cock 2], gently tugging until they are both hard from the pleasing friction she coils around them.");
		}
		//Centaur:
		else {
			outputText("You leisurely clop yourself around so your back end is facing her and sigh as ");
			if (player.cockTotal() == 1) outputText("a warm hands wraps itself around your [cock] and then begins to gently tug, quickly hardening it with pleasing coils of friction.");
			else outputText("a warm hand wraps around first your [cock] and then your [cock 2] before beginning to gently tug, both quickly hardening from the pleasing coils of friction.");
		}
	}
	//Repeat: 
	else {
		outputText("You tell her you'd like to... talk.");
		outputText("\n\nGrinning, your centaur slave ");
		if (!player.isTaur()) {
			outputText("slides off the lower half of your [armor] as you set yourself down and then grasps your cock");
			if (player.cockTotal() > 1) outputText("s");
			outputText(" with her soft hands.  You sigh as she begins to gently pump, making ");
			if (player.cockTotal() > 1) outputText("them");
			else outputText("it");
			outputText(" harden quickly.");
		}
		else {
			outputText("trots around behind you.  You sigh as ");
			if (player.cockTotal() == 1) outputText("a warm hands wraps itself around your [cock] and then begins to gently tug, quickly hardening it with pleasing coils of friction.");
			else outputText("a warm hand wraps around first your [cock] and then your [cock 2] before beginning to gently tug, both quickly hardening from the pleasing coils of friction.");
		}
	}
	flags[kFLAGS.KELLY_TALK_N_HAND_TIMES]++;
	//(Randomly generated)
	var temp:int = rand(5);
	//1.
	if (temp == 0) {
		outputText("\n\nYou ask what happened to the wives she mentioned she had.");
		outputText("\n\n\"<i>Who?</i>\" Kelly says, stopping her pumping for a moment.  \"<i>Oh, those two.  I wouldn't worry about them, [Master].  I never told them where I worked, because I never wanted them to know I worked for a woman.  Funny, isn't it.");
		if (!player.hasVagina()) {
			//Male: 
			outputText("  Now I </i>do<i> work for a man, and I spend most days polishing his [cock biggest]!");
		}
		//Futa:
		else outputText("  Now I am a woman, I work for another woman, and I spend most days polishing her [cock biggest]!");
		outputText("</i>\"  She laughs musically as she continues to rub your straining meat.  <i>\"They'll be alright, [Master].  They were never bound to me as tightly as I am to you, I was never as strong or as clever as you- and I was always waiting for someone to make me into a submissive cockslave, I just never realized it.  They'll probably shake out of it and go their separate ways eventually, find new lives.  Unless...</i>\"  She pauses again. \"<i>Unless you want me to go find them, [Master]?  Make them part of your glorious harem instead?  Make them see how inferior a [master] I really was?</i>\"  You tell her to keep pumping, close your eyes and imagine not one but three mare sluts serving you: imagining three plump, hungry mouths slathering up and down your [cock biggest] at the same time, ");
		//1< cock:
		if (player.cockTotal() > 1) outputText("imagining thrusting every single one of your cocks into a wet, willing hole, ");
		//vagina:
		else if (player.hasVagina()) outputText("imagining one of them tongue-fucking your [vagina] as you buck into another's tight cunt, ");
		outputText("imagining the symphony of feminine squeals and moans as you cum....  Kelly coos as you bark wordlessly, jizz surging powerfully out of your " + player.multiCockDescriptLight() + ".  She keeps masturbating you, pumping you with gentle, insistent pressure until you are spent.  Once you're done, she bends in and licks you clean, humming happily as she laps at your [cockHead] with her soothing, seeking tongue.");
		
		outputText("\n\nAble to think slightly clearer with your blood settled, you decide against telling Kelly to go fetch her erstwhile harem - it's dangerous to send such a vulnerable slave wandering around in the wilderness for something that's probably long gone, and taking care of just one centaur cumslut is draining enough as it is.");
		if (player.cor < 70) outputText("  Plus, the thought of making Kelt's victims pay the price for his own crimes makes you feel uncomfortable.");
		outputText("  You tell Kelly you appreciate the thought as you pick yourself up and leave, but you think you need to save your energy and cum for the really special case that she is.  The centaur shivers with glee.");
		
		outputText("\n\n\"<i>Thank you so much, [Master]!</i>\"");
	}
	//2. 
	else if (temp == 1) {
		outputText("\n\n\"<i>So,</i>\" says Kelly with feigned casualness as she masturbates you.  \"<i>When can I move in with you, [Master]?  I don't mind if you've got other sluts, you know.  I know someone as virile as you needs many.</i>\"  You sigh, enjoying the coils of pleasure around your [cocks], receding then tightening, wondering how you'll field this one.  Your rising seed pushes open a black doorway in your mind and you smirk.");
		
		outputText("\n\n\"<i>You can move in with me once you've paid me back.</i>\"");
		outputText("\n\n\"<i>Paid... paid you back? What do you mean?</i>\"");
		outputText("\n\n\"<i>For all the trouble I went through, bringing out your true self.  That pretty, needy pussy, those big whorish jugs, that thirst for cum, all the things you enjoy so much....  Do you know how difficult getting all that succubus milk together was?  It doesn't grow on trees, slave.  Then there's all that rich jizz I have to keep feeding you.  I'm rendering YOU a service when I use your wanton body, not the other way around.  Every time I deign to plug one of your slut-holes with hot cock, you are falling more and more in debt with me.</i>\"");
		
		outputText("\n\n\"<i>I-I'm sorry [Master],</i>\" Kelly whispers, her hot hands sliding up and down your [cock]");
		if (player.cockTotal() > 1) outputText(" and [cock 2]");
		outputText(".  \"<i>Of course I can never repay you for what you've done for me.  I wasn't thinking.</i>\"");
		
		outputText("\n\n\"<i>It was never your strong point.</i>\"  You close your eyes, enjoying the waves of undulating pleasure she is sending up and down your [cock].  \"<i>Now, a few years of dedicated service here, bearing and raising my children, serving my body how and when I see fit....  Why, you could be sat beside my throne, sucking my [cock biggest] day and night, within a decade.</i>\"  You feel Kelly's hot breath on your [cock biggest] and wonder which she is now imagining - the bit about your imaginary throne, or the bit about the decade of fucking and breeding before it.  More black blossoms in your head as you surge past the point of no return.  \"<i>And if you thought I did things to make you squeal here, bitch... just wait until I get you home.</i>\"  You groan as you cum, a fountain of white, pulsing pleasure, spurting everywhere.  Once you're done, Kelly bends in and licks you clean, humming happily as she laps at your [cockHead] with her soothing, seeking tongue.");
		
		outputText("\n\n\"<i>Thank you, [Master],</i>\" she says once she's done, looking at you with her adoring green eyes.  \"<i>I'll never repay you, but maybe I can prove to you I am the best breeding mare cumslut you will ever need in the years to come!</i>\"  You give her a stroke behind the jaw and then go on your way.");
	}
	//3.
	else if (temp == 2) {
		outputText("\n\nYou ask if all centaurs have sub-dom relationships.");
		
		outputText("\n\n\"<i>Oh, no [Master],</i>\" Kelly replies as she continues to pump you.  \"<i>We aren't like the demons if that's what you mean, we think about and treat sex just like anyone else.  We do go into heat or rut though, and combined with the problems with, y'know, getting relief it makes some of us get... edgy.  In the old days when we ruled the plains you sometimes got bands of males roaming the countryside, raping and even enslaving everything with a warm hole they came across when it got real bad.  I guess that's where the image of the arrogant, aggressive centaur comes from.  But I don't think we're any worse than, say, humans when it comes to that kind of thing.</i>\"  It's a fair point, you think, as you close your eyes and let your centaur slave masturbate you to the vinegar strokes, grunting wordlessly as you cum, jetting your spunk in long lines ");
		if (!player.isTaur()) outputText("into the air");
		else outputText("onto the ground");
		outputText(".  Kelly nuzzles your [cocks] when you're done, slurping obscenely as she polishes your nobhead");
		if (player.cockTotal() > 1) outputText("s");
		outputText(" to a shine.  You thank her with a slap on the ass and leave.");
	}
	//4.
	else if (temp == 3) {
		outputText("\n\nYou ask about the domineering aura that she seemed to have, before you transformed her.");
		outputText("\n\n\"<i>That's a long story, [Master].</i>\"  Move your hands slowly then, you say.  Kelly tinkles with laughter and complies, moving her smooth hands up and down your [cocks] at an almost tortuously slow pace.  \"<i>So, back before the demons showed up, I was in a small tribe of centaur who lived in the plains.  I hated the leader - I thought he was an old fuddy duddy that wouldn't let us do fun stuff like attack the gnolls, or let me do with the mares as I would.  I always thought I was well-respected because I was strong, and tough, and brought in lots of kills - but then one day they all turned around and told me they were kicking me out!  For being an asshole!  Oh man, was I pissed.  But there were a lot more of them than there were of me, so I had no choice but to hit the road.</i>\"");
		outputText("\n\nShe sighs, tracing a bulging vein on your [cock] absently.  \"<i>I made out to myself that I was better off without them, a lone wolf with nothing holding him back - but it wasn't like that [Master], it sucks being on your own in the wilderness.  I was almost beside myself with loneliness and rage when the demon approached me.</i>\"  She strokes your raphe with a single finger and you grunt a warning as your seed rises - she pulls back momentarily. \"<i>He said he'd been watching me, and his kind were interested in - how did he put it? - accommodating the centaur tribes.  He said he'd give me a gift which would let me become a great leader of my kind - let me take my rightful place at the head of my tribe, with all the mares I could ever want.  Well, do you think I was going to turn that down after more than a year mooching around on my own, [Master]?</i>\"");
		
		outputText("\n\nShe pauses and you sigh as she bends in and ");
		if (player.balls == 0) outputText("suckles and laps at the very base of your [cock] for a time");
		else outputText("suckles and laps at your [balls] for a time");
		outputText(".  It's a beautiful tactic - the sound and sensation is wonderful but it also cools your cock down just a bit.");
		
		outputText("\n\n\"<i>So yeah,</i>\" she goes on once she's done, wrapping her hand around your [cock] again, \"<i>I accepted the demon's blessing.  It made me feel... strong.  Made things a lot clearer in my mind.  I marched right back to my tribe, beat the old leader into a pulp, and declared myself the new leader - and anyone who disagreed, I'd kill.  No one dared argue.  I guess even then my new aura was beginning to work.</i>\"  She clicks her tongue thoughtfully as she continues to work your bulging meat.  \"<i>I had made two of them into my full-time bitches before the rest had enough.  Woke up one morning and they had gone, to Tel'Adre or who knows where.  Smarter and braver than I took them for.  I guess that demon of mine was pretty busy, because it seemed like what I did to my tribe happened all over for the centaur- we used to be everywhere in the plains, but after the demons took over we just disintegrated.</i>\"");
		
		outputText("\n\nYou want to concentrate on what she's saying but it's difficult when you're champing at the bit, your cock bulging urgently in Kelly's deliberately gentle wringing grasp.  Perhaps guessing this, the centaur goes quiet and begins to pump you hard, jerking you unrelentingly until you blow your load, sweat beading your brow as you spurt cum everywhere, your tensing, flexing orgasm going on for what seems like minutes.  It's a generous payload and Kelly makes appreciative noises as she licks up what hangs from [eachCock] when you're done.  In a husk you ask what happened after that.");
		
		outputText("\n\n\"<i>Well, you know most of the rest [Master],</i>\" she says, smacking her lips.  \"<i>I had to feed two breeding mares and my growing brood, and I already knew hunting on my own barely allowed just one centaur to get by, so eventually I fetched up with Whitney, who paid me to guard her farm.  And then I met you, who broke my aura and showed me who I truly was.</i>\"  She looks at you reverently.  \"<i>I was a miserable bastard, you know that?  Even when I was in charge of my tribe, I was miserable.  Now, worshipping your [cocks]");
		if (flags[kFLAGS.KELLY_KIDS] > 0) outputText(" and bearing and raising your children");
		outputText(", I'm a hundred times happier.  I just used a demon's curse to get my way - you did it all on your own.  You showed me what true strength and dominance is, [Master]!</i>\"");
		
		outputText("\n\nYou should probably take a mind-broken cumslut's praise with a pinch of salt, but you do feel a glow of gratification which reaches beyond your groin.  You give your loyal servant a kiss on the cheek, dress yourself, and head back to camp.");
	}
	//5.
	else {
		if (!farm.farmCorruption.whitneyCorrupt())
		{
			outputText("\n\nYou ask if she has had much to do with Whitney, before or now.");
			
			outputText("\n\n\"<i>Not really,</i>\" says Kelly.  There's a hard note in her voice as she works her arms, masturbating your bulging meat.  \"<i>Before we just kept away from each other.  She knew about my wives and my aura but she didn't care, as long as I kept the imps and gnolls away and I didn't try it on her.  Of course it occurred to me, but... there's a cold edge to that woman.  Keeps it hidden, but there is - how else has she lived out here on her own for this long?  I didn't want to find out what she's hiding, plus I really needed the job.</i>\"  She's definitely pumping you aggressively, jerking your [cocks] with brisk movements until the flesh under her tight grasp is singing with blood.");
			outputText("\n\nYou close your eyes and arch your neck to the sensation.  \"<i>Now when she sees me, she just gives me this really disgusted look.  Fucking bitch.  She thinks I'm so terrible now but thought everything was just great back when I was her pet demon-tainted rapist?  Bitch!</i>\"  She's really rubbing you furiously now and you groan as you surge to your high, trapped in a warm, smooth paint-shaker of a handjob.  She keeps up her growl as you tense and cum, opening your mouth as you ride it, flexing out buckets of spunk ");
			if (!player.isTaur()) outputText("into the air");
			else outputText("onto the ground");
			outputText(".");
			outputText("\n\n\"<i>But you'll show her one day, right [Master]?  Oh, what I'd give to see her grovelling in the dirt and licking your [feet].  You'll make her do that one day, won't you [Master]?  On that day... you'll remember to bring me along, right?</i>\"  She looks up at you, grinning, malicious fire in her green eyes.  You feel dizzy with your intense orgasm and are slightly taken aback there is still so much spite left in your cute pony cock-sleeve.  When you've recovered, you say maybe one day, but for now she's not finished with her job.");
			
			outputText("\n\n\"<i>Oh!  Sorry [master], please excuse me.</i>\"  She bends in and sends her tongue looping and curling deliciously over your aching, oozing [cockHead] until it is gleaming.  You redress and give her a harder slap than usual on the ass as you leave.");
		}
		else
		{
			outputText("\n\n“<i>[Master],</i>” trills Kelly, drawing the last syllable out, her tone one of mocking pique underpinned by dark glee. “<i>You promised me you would let me be there when you made Whitney yours!</i>”");

			outputText("\n\nYou reply stiffly that you promised no such thing. You want to add more but you are lost in the shift of her hand around your [cock], making both your sex and your mind feel red, sweet and full.");

			outputText("\n\n“<i>You are so mean, [master]. I guess I will just have to imagine what it was like.</i>” Her voice has lowered to a playful husk. “<i>Did she resist? Did she spend days and weeks pretending she didn’t feel the creep of your influence, that she didn’t feel her heart quicken when you gave her orders? That she didn’t even notice you or the way you had taken possession of her home? I bet she did – stuck up bitch spent her whole life acting that way. Bet it became a struggle when heat began to run to her pussy every time you passed her.</i>”");

			outputText("\n\nShe knows exactly what she’s doing. Her hand moves slowly but surely over your bulging meat, and you close your eyes allowing your slave’s gloating, lascivious tones fill your head. “<i>Did you make her get on her knees? Make her sit up and beg for it? No... you didn’t </i>make<i> her do anything, did you? Prissy britches did it all by herself when it got unbearable, didn’t she. She got out the deeds to this place. She smashed her toy crossbow. She made herself a collar, and handed the leash to you. That’s how it was for butter-wouldn’t-melt, wasn’t it? All... by... herself.</i>”");
 
			outputText("\n\nYou tense and cum, opening your mouth as you ride it, flexing out buckets of spunk");
			if (!player.isTaur()) outputText(" into the air");
			else outputText(" onto the ground");
			outputText(". The smooth woggle of flesh around your [cock] coils you expertly through your exultant orgasm, wringing out every last drop before plump, wet lips come to rest on your [cockHead biggest], kissing and licking it quite clean. Kelly looks extremely pleased with herself, glancing up at you once she’s done.");

			outputText("\n\nYou gather yourself, and tell her with as much sternness as you can muster that Whitney is your right hand on this farm, and whatever else she may think of her she must follow the dog woman’s orders to the letter.");

			outputText("\n\n“<i>Of course,</i>” replies Kelly innocently. “<i>Right hands are important things to have. I am certain that Mistress Whitney makes a very effective right hand for you, [master].</i>” You redress and give her a harder slap than usual on the ass as you leave.");
		}
	}
	player.orgasm();
	doNext(camp.returnToCampUseOneHour);
}
//Reward
//Requirements: PC used “punish” at least once, 3+ days have gone by and “punish” has not proced*
private function rewardKelly():void {
	flags[kFLAGS.KELLY_REWARD_COOLDOWN] = 1;
	clearOutput();
	//First time: 
	if (flags[kFLAGS.KELLY_TIMES_REWARDED] == 0) {
		outputText("There seems to be an added bounce to Kelly's canter today.  She prances a bit playfully in front of you, grinning, whipping her demonic tail so that the high, sweet smell of her gushing pussy is in the air.  You realize she is calling your attention to her backside, which is unmarked.");
		outputText("\n\n\"<i>I've been good, [Master].  So very, very... good.</i>\"  Color is high in her cheeks, and although she's smiling proudly there is real desperation burning in her green eyes as she gazes at you.  \"<i>We'll fuck now, right?  It's so hard being good.  After a while I can't think of anything but your cock and how wonderful it tastes and feels.  Last night it was so bad I blew my own fingers thinking about you...</i>\"  She demonstrates graphically.  \"<i>But I didn't cum.  I've learnt my lesson [Master], now please fuck me!</i>\"");
		outputText("\n\nIt's difficult not to laugh at this earnest outpouring, and yet you can't help but feel a fond glow for your centaur slave, who has fought against her slutty nature to keep herself locked into a constant state of burning arousal just to please you.  Maybe it's time for a bit of kind [Master]-ing and provide her with some sort of reward, aside from fucking her rotten.");
	}
	//Repeat:
	else {
		outputText("Kelly holds her head up proudly as you inspect her, running your hand slowly over her backside.   It's nice and smooth.  You smile at her benevolently and tell her that since she's been such a good cumslut, you're going to reward her.  She claps excitedly.");
		outputText("  \"<i>Hurray!</i>\"");
	}
	flags[kFLAGS.KELLY_TIMES_REWARDED]++;
	//*Don't know how the current “punish” system works so leave the function up to you.  Ideally each option should turn up 50% of the time after first punish
	
	menu();
	//Hair Dye/Apple Sauce
	//[chestnut brown/sable black/garish purple/bright pink/slutty blonde) 
	if (player.cockThatFits(300) >= 0 && player.hasCock()) addButton(0,"Applesauce",giveKellyAppleSauce);
	if (player.hasItem(consumables.BLACK_D) && flags[kFLAGS.KELLY_HAIR_COLOR] != "sable black") addButton(1,"Black Dye",dyeKellysBitchAssHair,consumables.BLACK_D);
	if (player.hasItem(consumables.BLOND_D) && flags[kFLAGS.KELLY_HAIR_COLOR] != "slutty blonde") addButton(2,"Blond Dye",dyeKellysBitchAssHair,consumables.BLOND_D);
	if (player.hasItem(consumables.PURPDYE) && flags[kFLAGS.KELLY_HAIR_COLOR] != "garish purple") addButton(3,"Purple Dye",dyeKellysBitchAssHair,consumables.PURPDYE);
	if (player.hasItem(consumables.PINKDYE) && flags[kFLAGS.KELLY_HAIR_COLOR] != "bright pink") addButton(4,"Pink Dye",dyeKellysBitchAssHair,consumables.PINKDYE);
	if (player.hasItem(consumables.BROWN_D) && flags[kFLAGS.KELLY_HAIR_COLOR] != "chestnut brown") addButton(5,"Brown Dye",dyeKellysBitchAssHair,consumables.BROWN_D);
	
	addButton(14,"Back",approachKelly);
}

//Hair Dye
//Requires: Black dye, purple dye, blonde dye, pink dye, brown dye in inventory.  Dye can't be given if her hair is that color already, e.g. brown can't be given straight away
private function dyeKellysBitchAssHair(color:ItemType):void {
	clearOutput();
	outputText("You tell her you've brought her a gift as you rummage around in your pockets.  Kelly looks apprehensive but pleasant surprise forms on her face when she catches the small vial of dye you throw at her.");
	outputText("\n\n\"<i>Oh wow, thanks [Master]! It's been ages since I did my hair.");
	if (flags[kFLAGS.KELLY_TIMES_DIED_HAIR] == 0) {
		outputText("</i>\"\n\nShe stops and thinks.  \"<i>In fact, I don't think I've ever done my hair.  ");
	}
	outputText("This'll be so much fun!</i>\"  You walk over to the barn with her and pour some water into a wide bucket.  She lets down her braid and you spend a pleasant quarter of an hour or so helping her work the sharp-smelling substance into her long, luscious hair.  When you're done, you step back to admire the effect.  Amazingly the color is not only sinking into her hair but also into her tail, her demon spade slowly bleaching with the hue you chose.");
	flags[kFLAGS.KELLY_TIMES_DIED_HAIR]++;
	//Black dye:
	if (color == consumables.BLACK_D) {
		outputText("\n\nKelly whips her jet black hair to look at it, trotting back and forth and considering, swishing her equally black tail.\n\n\"<i>Mmm.  Not sure how much I like this, [Master],</i>\" she says eventually.  \"<i>It's very... severe, isn't it?</i>\"  You say you picked it because you think it will contrast well with the substance she's most often covered in.  Kelly laughs fondly as she begins the long process of retying her braid.\n\n\"<i>Oh, [Master].  Always thinking two moves ahead.  Thank you for your reward!</i>\"");
		flags[kFLAGS.KELLY_HAIR_COLOR] = "sable black";
		player.consumeItem(consumables.BLACK_D);
	}
	//Blonde dye: 
	else if (color == consumables.BLOND_D) {
		outputText("\n\nKelly whips her bonny, flaxen hair to look at it, and then bounces it happily with her hands.  Her blonde tail whips back and forth briskly.");
		outputText("\n\n\"<i>This feels... right, [Master].  Very right.</i>\"  She looks at you lustfully.  \"<i>Wanna see if we have more fun?</i>\"  You say you'll definitely be back later to test that theory out.");
		
		outputText("\n\n\"<i>Don't stay away too long,</i>\" she purrs, as she begins the long process of retying her braid.  You feel your bottle blonde bitch's eyes on you for a long time after you head out of the field.");
		player.consumeItem(consumables.BLOND_D);
		flags[kFLAGS.KELLY_HAIR_COLOR] = "slutty blonde";
	}
	//Purple dye: 
	else if (color == consumables.PURPDYE) {
		outputText("\n\nKelly whips her virulently purple hair to look at it, trotting back and forth and considering, wagging her equally purple tail.");
		outputText("\n\n\"<i>Like the goblins, I guess?  I don't know how much I like this color, [Master].</i>\"  You say it'll serve as a constant reminder to her that she's a cock hungry breeding machine.  Kelly nods thoughtfully as she begins the long process of retying her braid.");
		outputText("\n\n\"<i>You're right [Master], I would hate to ever forget that.  Thank you for your reward!</i>\"");
		flags[kFLAGS.KELLY_HAIR_COLOR] = "garish purple";
		player.consumeItem(consumables.PURPDYE);
	}
	//Pink dye:
	else if (color == consumables.PINKDYE) {
		outputText("\n\nKelly smiles with delight as she whips her bubblegum pink hair around to look at it, even prancing a bit so that her equally pink tail bounces.");
		outputText("\n\n\"<i>Ooh I like this, it makes me feel so... girly.  I feel pink inside!</i>\"  You certainly do, you say.  Kelly giggles as she begins the long process of retying her braid.  She even sounds bubblier.");
		outputText("\n\n\"<i>Thank you for your reward, [Master]!</i>\"");
		player.consumeItem(consumables.PINKDYE);
		flags[kFLAGS.KELLY_HAIR_COLOR] = "bright pink";
	}
	//Brown dye: Kelly smiles as she examines the regained chestnut brown color of her hair and tail.
	else if (color == consumables.BROWN_D) {
		outputText("\n\n\"<i>I'd almost forgotten what it looked like.</i>\"  She sighs, twisting a lock of it in a finger.  She looks quite different with her hair down - it reaches almost to her flanks.  \"<i>You'll bring more dye, right?  I'd love to do more colors.</i>\"  That depends, you say, on her being good.  Kelly sets her jaw determinedly as she begins the long process of retying her braid.");
		outputText("\n\n\"<i>Of course, [Master].  Thank you for your reward!</i>\"");
		flags[kFLAGS.KELLY_HAIR_COLOR] = "chestnut brown";
		player.consumeItem(consumables.BROWN_D);
	}
	else outputText("\n\nYO dog, " + color + " is definitely not working right. Please report this to fenoxo using the report a bug link on the site.");
	menu();
	addButton(0,"Next",approachKelly);
}
 
//Apple Sauce
//Req Dick that fits.
private function giveKellyAppleSauce():void {
	clearOutput();
	//First time:
	if (flags[kFLAGS.KELLY_TIMES_APPLESAUCED] == 0) {
		outputText("You tap your chin idly and ask Kelly what she likes eating.  Aside from dick, you add, rolling your eyes as she opens her mouth eagerly.");
		outputText("\n\n\"<i>Oh.  Um.  Well...</i>\" she furrows her brow as if remembering a very distant time.  \"<i>I used to like fruit.</i>\"  She laughs a bit.  \"<i>A stereotype really, you know, horses and apples?  Whitney even planted me a couple of apple trees across the back, but I never took care of them because I was a bit of a jerk-off back then.</i>\"");
		outputText("\n\nAt least your jerk off-ing is put to good use these days, you say kindly.  \"<i>That's nice of you to say, [Master],</i>\" replies the centaur solemnly.  She's wringing her hands, her thoughts elsewhere.");
		if (!farm.farmCorruption.whitneyCorrupt()) outputText(" \"<i>I'd like to go and check on it, but... I don't think Whitney likes me much anymore.  I'd hate to cause more trouble than I already have.</i>\"");
		else outputText("“<i>I'd like to go and check on it, but... I’d hate to get into Mistress Whitney’s bad books.  I’ve caused enough trouble already.</i>”");
		outputText(" You 'pfft' and wave your hand airily to show what YOU think of Whitney.  You tell her to stay put - as her treat, you'll go check on the orchard and bring back some apples for her, if there are any.");
		outputText("\n\n\"<i>You will?  I- well, thank you so much [Master], but you'll be careful, won't you?</i>\" she says fretfully, still wringing her hands.  You go into her barn, grab a metal bowl and then stride off gallantly, as if setting off to take on Lethice herself, when in fact your epic quest involves jumping over a fence and walking 200 yards through some light woodland.");
		
		outputText("\n\nThe three or four apple trees the farm dog planted back here have long since gone wild, covered in lichen and fighting for space with the bigger trees which crowd them.  Despite that, they and the ground beneath them are speckled with ripe looking apples.  You quickly gather a few, munching on one speculatively as you do.  It's sweet and crunchy, but- could it use a kick of some sort?  You laugh as the devilish, filthy idea forms.  Well, why not?  Apples are a distant second when it comes to Kelly's favorite forms of sustenance after all....");
		outputText("\n\nYou grab a smooth stone, wipe it clean, and then begin to mash the apples in the bowl, picking out the stalks and seeds where you can.  You look critically at the mush you've created.  Yep, you're definitely going to need some form of syrupy substance to make this work.  ");
		if (!player.isTaur()) {
			outputText("You remove the bottom half of your [armor] and grip your [cock].  You close your eyes, begin to stroke yourself and sigh as you think of Kelly- her fine, bountiful curves, her cute, dimpling face, how she unconsciously licks her cock-sucking lips when she sees you coming, how she begs for it, how sweetly she moans when you thrust deep into her tight, wet holes... your body clenches as you orgasm, spurting streamer after streamer of spunk into the apple mash.");
			if (player.hasVagina()) outputText("\n\nYour [vagina] quivers and clenches, and gasping with the dual orgasm which is clutching your body you stand over the bowl and let some of your femcum drip into it.  Taste my summer flavor Kelly, you think wildly, and laugh with a slightly manic edge.");
			//[High cum:]
			if (player.cumQ() >= 750) outputText("  The bowl quickly begins to brim as your [cock] torrents out cum, and eventually you have to turn away, grunting out the last jets of filth into the undergrowth.");
		}
		//[Centaur:]
		else {
			outputText("You position your lower half over the bowl.  Your [cock] is already semi-turgid with the idea of what you're going to do, and it begins to bulge as you close your eyes, sigh and think of Kelly- her fine, bountiful curves, her cute, dimpling face, how she unconsciously licks her cock-sucking lips when she sees you coming, how she begs for it, how sweetly she moans when you thrust deep into her tight, wet holes... your body clenches as you orgasm, spurting streamer after streamer of spunk into the apple mash.");
			if (player.hasVagina()) outputText("\n\nYour [vagina] quivers and clenches, and gasping with the dual orgasm which is clutching your body you stand over the bowl and let some of your femcum drip into it.  Taste my summer flavor Kelly, you think wildly, and laugh with a slightly manic edge.");
			//[High cum:
			if (player.cumQ() >= 750) outputText("  Your [cock] torrents out cum, and eventually you have to clop away, grunting out the last jets of filth onto the ground to avoid overflowing the bowl.");
		}
		
		outputText("\n\nYou exhale, set yourself down and enjoy the afterglow at leisure in the peaceful woodland glade, taking the time to recover as you work your musky, gooey sex into the mixture using the stone.  Eventually you're left with a gooey, yellow green mash.  Kelly green, you think, and laugh.  The mixed aroma of sex and fructose hovers in your nose.  Satisfied, you pick yourself up and take the bowl, brimming with apple sauce a la [name], back to the fields.  Kelly is upon you the moment you come back in sight, whinnying with concern.");
		
		outputText("\n\n\"<i>You're all right!  You were gone so long I thought something terrible had happened, I thought you and the apples had been carried off by demons, I didn't know what to do...</i>\"  You laugh at her absurd worry, before coughing, taking on a magnanimous tone and saying you've located the orchard, Whitney won't be troubling her over it, with a bit of work it will produce plenty of apples, and what's more you've brought her some.  Delight blows away the worry lines on her face.");
		
		outputText("\n\n\"<i>Oh, thank you so much, [Master]!  I could blow you a thousand times and it wouldn't be enough to repay you, I'm not worthy of a [Master] who is as brave and noble as you, I- wait, what's this?</i>\"  She looks at the gloop in the bowl you've given her in bewilderment.  Apples, you say, grinning knowingly.  \"<i>But it smells more like... like... ooh.</i>\"  Her pupils dilate and her mouth opens, saliva forming in her mouth.  Your grin widening, you slide an arm around her human waist, drinking in her warm, horny scent as you lead her unresistingly to the barn.");
	}
	//Repeat:
	else {
		outputText("\n\nYou go to the barn and grab your trusty metal bowl.  Kelly knows what this means: she clasps her hands eagerly, her horse half clopping backwards and forwards impatiently as she watches you walk casually towards the forest.");
		outputText("\n\nThe small grove of apple trees has changed significantly from when you first found it.  Somebody has begun cutting the encroaching wild trees right back and pruned the rosaceae themselves so they aren't tangling into each other anymore- they look considerably happier.");
		if (flags[kFLAGS.KELLY_KIDS] > 1) outputText("  Somebody has even cleared an oblong patch of earth alongside the trees- a piece of card stuck into it is scrawled with a childish hand which declares it to be “CAROTS”.  You marvel at it all.  Who would have imagined your lust for horse pussy would have turned a pointless asshole into a loving mother who gardens with her children?  Really, you deserve a medal for your efforts.");
		
		outputText("\n\nYou take your time picking the best apples which catch your eye before mashing them up, once again removing the seeds and stalks.  Then, with a wicked smile, you ");
		if (!player.isTaur()) {
			outputText("grasp your semi-turgid cock and drift into a fond reverie of Kelly- the way her boobs bounce when she canters towards you, the way her green eyes burn when they fall upon your [eachCock], the way she gasps when you slap her ass, how sweetly she moans when you thrust deep into her tight, wet holes, the galaxy of filthy things you still have left to do to her....  Your body clenches as you orgasm, spurting streamer after streamer of spunk into the apple mash.");
			if (player.hasVagina()) outputText("  Your [vagina] quivers and clenches, and once again, gasping with the dual orgasm which is clutching your body, you stand over the bowl and let some of your femcum drip into it.");
			//[High cum:
			if (player.cumQ() >= 750) outputText("  The bowl quickly begins to brim as your [cock] torrents out cum, and eventually you have to turn away, grunting out the last jets of filth into the undergrowth.");
		}
		//[Centaur:
		else {
			outputText("position your lower half over the bowl, your [cock] already semi-turgid as you drift into a fond reverie of Kelly- the way her boobs bounce when she canters towards you, the way her green eyes burn when they fall upon your [eachCock], how sweetly she moans when you thrust deep into her tight, wet holes, the galaxy of filthy things you still have left to do to her....  Your body clenches as you orgasm, spurting streamer after streamer of spunk into the apple mash.");
			if (player.hasVagina()) outputText("  Your [vagina] quivers and clenches, and once again, gasping with the dual orgasm which is clutching your body, you stand over the bowl and let some of your femcum drip into it.");
			//High cum:
			if (player.cumQ() >= 750) outputText("  Your [cock] torrents out cum, and eventually you have to clop away, grunting out the last jets of filth onto the ground to avoid overflowing the bowl.");
		}
		outputText("\n\nYou exhale, set yourself down and enjoy the afterglow at leisure in the peaceful woodland glade, taking the time to recover as you work your musky, gooey sex into the mixture using the stone.  Eventually you're left with a gooey, yellow green mash- kelly green.  The mixed aroma of sex and fructose hovers in your nose as you pick yourself up and take the bowl, brimming with apple sauce a la [name], back to the fields.  There's a wide and knowing grin on Kelly's face when you swagger back up to her.");
			
		outputText("\n\n\"<i>What have you made, [Master]?  Something for the Tel'Adre fair?");
		if (silly()) outputText("  Parsley, sage, rosemary and c...");
		outputText("  Ooh!</i>\"  You slap her ass and grab her around her supple, human waist as you pass her.  Laughing, you walk into the barn together.");
	}
	//[merge]
	var x:int = player.cockThatFits(300);
	var y:int = player.cockThatFits2(300);
	//Not Centaur: 
	if (!player.isTaur()) {
		outputText("\n\nThe mere smell of the apple sauce has got Kelly's vagina dribbling, and in the close, warm environment of the barn the cloying, sweet smell radiating off her has got [eachCock] rock hard again, and your arousal urges you to work quickly.  You lead her to a shelf roughly level with her collarbone and place the bowl of apples sauce on it.  Transfixed by it, swallowing audibly, the centaur reaches for it automatically.  You catch her hand.");
		outputText("\n\n\"<i>No.  Put them here.</i>\"  You set each one on either side of the bowl so she is clasping it.  \"<i>Don't lift it until you have to.  That's it...</i>\"  You watch, pulling off piece after piece of your [armor], as she dips her head into the bowl, scoops up a long lap of the green mash with her tongue and guides it into her wet mouth.  Her throat works and she closes her eyes.  Behind her, the intermittent dripping of her femcum on the straw turns into a steady trickle and you shake off the last of your underclothes in a hurry, stride over to her hindquarters and push your " + player.cockDescript(x) + " against her sopping pussy gently, gripping her " + flags[kFLAGS.KELLY_HAIR_COLOR] + " tail to her side so she doesn't inadvertently flick you with it.");
		outputText("\n\nShe is radiating heat and her wet depths suck at your " + player.cockHead(x) + " deliciously.  Still, you hold back on your pulsing need to bury your cock into her, pressing at her entrance softly until you see her head go down again, and the sloppy sound of a centaur trying to draw as much apple sauce into her mouth as she can reaches your ears.  With a contented sigh, you slide your " + player.cockDescript(x) + " into her, exulting in the hot slickness which envelops your sex bit by bit.");
		if (player.cocks[x].cockThickness >= 4) outputText("  Your girth spreads her fuck tunnel wide and you grunt at the delicious tightness of it as you pack her full of cock.");
		
		outputText("\n\n\"<i>Oh [Master]...</i>\" Kelly groans, arching her head back from her feed.  A series of clenches grip your [cock] and a sudden gush of fluid warms your ");
		if (player.balls > 0) outputText("[balls]");
		else outputText("thighs");
		outputText(".  Did she cum already?  It's fortunate you've already taken the edge off, because you're not sure how long you would otherwise be able to last against her impossibly turned on, sucking, clinching pussy.  As it is... you grip her huge, muscled backside and pull yourself almost all the way out of her fleshy pocket then spear your way in again, steadily in and then out, working your way into a slow, sensual rhythm.  Ahead of you Kelly's head sinks and bobs, and your ears are full of her wet, muffled chews, gulps and moans as she gorges herself on your sweet, sticky sex whilst you gently fuck her.");
		
		//1 < cock:
		if (y >= 0) {
			outputText("\n\nYour eyes fasten upon her tight, puckered asshole as lust grips you closer, a tiny puddle of human pink buried in her heaving brown horse flesh.  Your breath coming heavily now you withdraw your " + player.cockDescript(x) + " from her wet softness, dripping with her lubrication.  Quickly you push it against her puckered anus whilst lining up your " + player.cockDescript(y) + " with her gaping vagina.");
			outputText("\n\nYou wait for Kelly's head to descend towards the bowl again and then thrust forward, penetrating both her holes at the same time.  She cries out from the intense sensation and then bucks back into you, helping you sink your " + player.cockDescript(x) + " deeper and deeper into her ass, spreading her deliciously tight anal passage whilst your " + player.cockDescript(y) + " slides effortlessly into the fleshy folds of her cunt.  You slap her ass exultantly, making her squeak again, as you find your limit before resuming the same rhythm, fucking both her sopping vagina and tight, hot ass now with deep, slow strokes.");
		}
		outputText("\n\nYou keep driving into her nice and measured for long minutes, leisurely enjoying the hot mass of your mare whilst keeping a handle on your own lust, waiting for her to get close to finishing her meal.  You lose track of the number of times Kelly orgasms.  Devouring a fruity cum fix whilst being fucked by you completely overwhelms her senses, and she spasms around your cocks again and again, spurting femcum onto your legs and the ground helplessly, clopping her hooves feverishly as she quivers.  The sight of beads of sweat rolling down her rosy human back are almost too much, but you manage to hold back until finally she picks up the bowl and takes it to her lips to pour the last of the green sweet down her gullet.");
		outputText("\n\nWith her head thrown back it's easy for you to grip her " + flags[kFLAGS.KELLY_HAIR_COLOR] + " braid and use it for leverage as you fuck into her with everything you've got, bucking into her tight, hot flesh ");
		if (player.balls > 0) outputText(", your [balls] slapping into her thighs demandingly ");
		outputText("as you push towards your reward.  Panting, Kelly thrusts back into you as best she can, resisting your frenetic tugs to her hair so that the big, final slather of apple sauce can slide out of the bowl and into her mouth.  She screams around the wet, gooey mouthful and her vagina quivers and seizes your bulging " + player.cockDescript(x) + " in milking ripples");
		if (y >= 0) outputText(" as her anus clenches around your " + player.cockDescript(x));
		outputText(".  With a wordless shout, you tense up and orgasm in tandem, surging line after line of glorious into her wet, churning depths, lost in the ageless sensation of filling a breeding slut's holes with thick seed for what seems like oceans of blissful time.");
	}
	//Centaur: 
	else {
		outputText("\n\nThe mere smell of the apple sauce has got Kelly's vagina dribbling, and in the close, warm environment of the barn the cloying, sweet smell radiating off her has got [eachCock] rock hard again, and your arousal urges you to work quickly.  With a “hup” you mount her, settling yourself onto her warm, rippling back, surrounding her with your heavy flesh, smell and presence, your [chest] pressing into her back as you bring the bowl around her head.  Transfixed by it, swallowing audibly, the centaur reaches for it automatically.");
		outputText("\n\nYou tut mockingly and pull it away until she lowers her hands, then bring it in close to her face.  Her hands fall on her erect nipples as she dips her head into the bowl, scoops up a long lap of the green mash with her tongue and guides it into her wet mouth.  Her throat works and she closes her eyes.  The intermittent dripping of her femcum on the straw behind you turns into a steady trickle and your own arousal urgent now, you push your " + player.cockDescript(x) + " against her sopping pussy gently.  She is radiating heat and her wet depths suck at your " + player.cockHead(x) + " deliciously.");
		outputText("\n\nStill, you hold back on your pulsing need to bury your cock into her, pressing at her entrance softly until you touch the brim of the bowl against her teeth and watch her tongue slide out again, the sloppy sound of a centaur trying to draw as much apple sauce into her mouth as she can inundating your ears.  With a contented sigh, you slide your " + player.cockDescript(x) + " into her, exulting in the hot slickness which envelops your sex bit by bit.");
		if (player.cocks[x].cockThickness >= 4) outputText("  Your girth spreads her fuck tunnel wide and you grunt at the delicious tightness of it as you pack her full of cock.");
		
		outputText("\n\n\"<i>Oh [Master]...</i>\" Kelly groans, arching her head back from her feed so it spoons into your neck.  A series of clenches grip your " + player.cockDescript(x) + " and a sudden gush of fluid warms your ");
		if (player.balls > 0) outputText("[balls]");
		else outputText("thighs");
		outputText(".  Did she cum already?  It's fortunate you've already taken the edge off, because you're not sure how long you would otherwise be able to last against her impossibly turned on, sucking, clinching pussy.  As it is, you grip her muscled backside with your own huge hindquarters and pull yourself almost all the way out of her fleshy pocket before spearing your way in again, steadily in and then out, working your way into a slow, sensual rhythm.  Kelly's head sinks and bobs in front of you, and your ears are full of her wet, muffled chews, gulps and moans as she gorges herself on your sweet, sticky sex whilst you gently hump her.");
		
		//1 < cock:
		if (y >= 0) {
			outputText("\n\nYou think about her tight, puckered asshole beneath you as lust grips you closer, a tiny puddle of human pink buried in her heaving brown horse flesh.  Your breath coming heavily now you withdraw your " + player.cockDescript(x) + " from her wet softness, dripping with her lubrication.  Quickly you push it against her puckered anus whilst lining up your " + player.cockDescript(y) + " with her gaping vagina.  You wait for Kelly's head to descend towards the bowl again and then thrust forward, penetrating both her holes at the same time.  She cries out from the intense sensation and then bucks back into you, helping you sink your " + player.cockDescript(x) + " deeper and deeper into her ass, spreading her deliciously tight anal passage whilst your " + player.cockDescript(y) + " slides effortlessly into the fleshy folds of her cunt.  You grab one of her soft tits and squeeze exultantly, making her squeak again, as you find your limit before resuming the same rhythm, fucking both her sopping vagina and tight, hot ass now with deep, slow strokes.");
		}
		
		outputText("\n\nYou keep driving into her nice and measured for long minutes, leisurely enjoying the hot mass of your mare whilst keeping a handle on your own lust, waiting for her to get close to finishing her meal.  You lose track of the number of times Kelly orgasm's.  Being fed a fruity cum fix whilst being mounted by you has completely overwhelmed her senses, and she spasms around your cocks again and again, spurting femcum onto your legs and the ground helplessly clopping her hooves feverishly as she quivers.  The sight of beads of sweat rolling down her rosy human back are almost too much, but you manage to hold back until finally you see all that the bowl is a quarter empty.");
		outputText("\n\nYou grip her " + flags[kFLAGS.KELLY_HAIR_COLOR] + " braid and force her head to arch back before pushing the bowl against her lips, tipping the last of the green sweet down her gullet whilst you begin to fuck into her with everything you've got, bucking into her tight, hot flesh");
		if (player.balls > 0) outputText(", your [balls] slapping into her thighs demandingly");
		outputText(" as you push towards your reward.");
		outputText("\n\nPanting, Kelly thrusts back into you as best she can, resisting your frenetic tugs to her hair so that the big, final slather of apple sauce can slide out of the bowl and into her mouth.  She screams around the wet, gooey mouthful and her vagina quivers and seizes your bulging " + player.cockDescript(x) + " in milking ripples");
		if (y >= 0) outputText(" as her anus clenches around your " + player.cockDescript(y));
		outputText(".  With a wordless shout, you tense up and orgasm in tandem, surging line after line of glorious into her wet, churning depths, lost to the ageless sensation of filling a breeding mare's holes with thick seed for what seems like blissful oceans of time.");
	}
	//[merge]
	
	outputText("\n\nYou pool onto the floor when you are finished, ");
	if (player.isBiped()) outputText("giving at the knees, ");
	outputText("your aching cock still weakly clenching.  In a beatific daze you listen to the sound of a tongue eagerly exploring every inch of a metal surface, before a bowl hits the ground.  A hand is offered to you and woozily you take it.  As soon as you are up Kelly pulls you into a fervent, passionate kiss, her soft lips pushing into yours.  The smell of apples envelops you.  You tense for a moment but decide to allow it.  It's her treat, after all.");
	outputText("\n\nYou bend your head, sink your fingers into her hair and gently tangle your tongue with hers.  ");
	if (player.cor < 60) outputText("The taste of cum glazing her apple breath is off-putting but what did you really expect?");
	else outputText("You don't like to admit it but you do taste pretty good, even to yourself.  You push your tongue further into Kelly's mouth hungrily, working your jaw as you savage her mouth with your lips and tongue in search of that fruity, horny flavour, making her 'mmm' with delight and respond in kind.");
	
	//First:
	if (flags[kFLAGS.KELLY_TIMES_APPLESAUCED]  == 0) {
		outputText("\"<i>That was the best treat ever [Master],</i>\" she murmurs when you break away, gazing into your eyes lovingly.  \"<i>I liked apples but never quite as much as that.  Wow.</i>\"  You hold her face and say she should look after that orchard: who knows, maybe she'll be good enough to deserve a second helping.  Kelly smiles eagerly.");
		outputText("\n\n\"<i>I will be [Master], you watch!</i>\"  You dress yourself and amble out of the stable with her before sending her on her way with a loving, jiggling swat to her boobs.");
	}
	//Repeat:
	else {
		outputText("\"<i>That tastes better every time you make it [Master],</i>\" she purrs when you break away, gazing into your eyes lovingly.  \"<i>You should go into business with it.</i>\"  You grin at the idea and say who knows?  Maybe Mareth will eventually behave well enough to appreciate it as much as she does.  \"<i>I long for that day every moment of every day,</i>\" your slave replies fervently, stroking the hand you're holding her face with.");
		outputText("\n\nYou dress yourself and amble back out of the stable with her before sending her on her way with a loving, jiggling swat to her boobs.");
	}
	player.orgasm();
	dynStats("sen", -2);
	flags[kFLAGS.KELLY_TIMES_APPLESAUCED]++;
	doNext(camp.returnToCampUseOneHour);
}

//Blowjob
private function kellyBJsAhoy():void {
	clearOutput();
	outputText("You step into Kelly, a question fading on her lips as you put your arms around her waist and answer it by drawing her face into yours.  You kiss her hungrily, pushing your tongue into her hot mouth.  It's almost an instinctive reaction - it's difficult to look at her face and not be drawn to her plump, pert lips, to not want to touch them, to use them.  And godsdamn, does she know how to use them.  She responds to your kiss in kind, humming blissfully as she eagerly accepts your tongue, rolling and curling it with her own, entwined like two lovers, drawing it further into her warm wetness as her pillowy boobs push into your [chest], her sweet, horny smell invading your nostrils as her overfull lips mash into your own, rubbing at your philtrum gently.");
	outputText("\n\nYou are already ragingly hard, [eachCock] throbbing to the idea of those warm, expert folds of flesh sliding over ");
	if (player.cockTotal() == 1) outputText("it");
	else outputText("them");
	outputText(".  You pull away, catching Kelly's tongue with your own lips teasingly as you do, so you can watch her very slowly withdraw it, licking her lips so they glisten, her eyes shining with a depthless, green desire.  You murmur that it's time to put that mouth to use it was made for.  She's folding her legs beneath her before you've finished speaking, her hungry jade eyes never leaving yours.");
	
	//Not Centaur: 
	if (!player.isTaur()) {
		outputText("\n\nYour [cock biggest] strains outwards as you slide out of your [armor], and you grin as you draw in close to Kelly's face, letting the heavy, demanding smell of your musk envelop her.  Her skin flushes and her breath comes more rapidly as you brush her cheek with it.  You smile and gently but firmly tell her to put her hands under her tits, close her eyes, open her mouth and then be still.  You admire the sight as you languidly rub yourself, your pretty centaur slave presenting her big round breasts to you and her tongue out, waiting to take your load whole.");
		outputText("\n\nYou step in and tease her with your [cock biggest], softly brushing her face with your [cockHead biggest], working the musky smell deep into her head.  She closes her eyes and breathes out deeply, enveloping your crotch in warm air.");
		if (player.cocks[player.biggestCockIndex()].cockType == CockTypesEnum.HORSE) outputText("  You wonder whether the fact it is a horse cock, protruding proudly out of its sheath, makes it particularly difficult for her to resist, that it triggers some deep urge hardwired into her.  There's no way to really judge, but it seems like you've only just begun to tantalize her with it that the air below you is filled with bitten off grunts and moans, her mouth and head unconsciously bending towards your flared stallion prick as you rub it into her, always keeping it tantalizingly out of reach of her mouth.");
		outputText("  Finally, after about a minute of this tender torture, she groans from deep within her throat.");
		
		outputText("\n\n\"<i>Please [Master], let me swallow you, let me taste your strength, let me feel like a slut should,</i>\" she begs.  \"<i>I'll make it so good for you you'll never want anyone else, just like I will never want anyone else.  Just... let me drink your cum!</i>\"  You let a long second go by.");
		
		outputText("\n\n\"<i>Go on then,</i>\" you say, trying to keep the amused tone out of your voice.  \"<i>Show me why you deserve it.  Nice and slow.</i>\"  Her hands still holding up her gorgeous fuck udders, Kelly lets out a small whinny of pleasure and bends into your crotch, kissing the base of your bulging [cock biggest] longingly as she gets to work.");
		//If PC has anything else aside from cock:
		if (player.hasVagina()) outputText("  You're in no hurry, and with a slight roll of your [hips] you direct her to start at the back and work her way up.");
		
		//Vagina and balls: 
		if (player.balls > 0 && player.hasVagina()) {
			outputText("\n\nKelly brushes your [balls] out of the way as she burrows deep into your groin, her hot tongue finally pressing against your [vagina], oozing already in sympathy to the lust which has gripped your male sex.  She is a bit of a stranger to your female anatomy but she's a quick and eager learner, tracing your entrance with the tip of her tongue before pushing her plush lips into your opening, covering your outer lips and your clit in shifting softness as she burrows into your tunnel with her tongue, curling deep into you as she worships every inch she can reach with her flexible mouth muscle, lapping up every trace of sweet moisture she finds with vocal pleasure.");
			outputText("\n\nYou close your eyes and lose yourself for a while, very gently thrusting your [hips] into her hot mouth as she makes your [vagina] glow with pleasure, sending small spasms of ecstasy shooting through your core, keeping your [cock biggest] straining.  It'd be so easy to ride her face to orgasm... but no, you signed up for the whole ten yards here and she isn't even close to being finished.  With a bit of encouragement with your hips, you get her to pull away from your beading muff and move on to your balls.  She sighs as she begins to lavish them with worshipful attention.");
			//[Normal balls:
			if (player.ballSize <= 8) {
				outputText("\n\nAfter curling her tongue here and there over each sensitive orb, bathing them in saliva, she envelops each one in her mouth, sucking gently first one, then the second");
				if (player.balls > 2) outputText(", then the third, then the fourth");
				outputText(", then back to the first one, a slow and sensual repetition.  She moans intermittently as she does it, and you're not sure if it's intentionally to send delightful shivers of sensation through your scrotum and up the spine of [eachCock], or it's simply because the sheer degradation of the act fills her with deep, shameful lust.  Supporting her soft, ");
				if (pregnancy.isPregnant) outputText("milk-laden ");
				outputText("breasts whilst slavishly polishing the [balls] of the " + player.mf("man","woman") + " who made her into, well, a ball-licking bitch.  Whatever the cause the result is the same: pleasure thrums through your groin and up your [cock biggest], and you close your eyes, lost to the sensations of her skillful tongue.");
			}
			//[Huge balls:
			else {
				outputText("\n\nAfter curling her tongue here and there over each sensitive orb, bathing them in saliva, she attempts to envelop one in her mouth.  She can't though- your testicles, bulging and tight with arousal, are simply too big.  After a short pause she goes back to licking them, lapping at their surface tenderly, licking all around each one for every trace of salt and musk, wetly caressing first one, then the second");
				if (player.balls > 2) outputText(", then the third, then the fourth");
				outputText(", then back to the first one, a slow and sensual repetition.  The warm air is punctuated with desperate 'ahh, ahn, ahh's as she surrenders herself to the deep, shameful lust of the act, supporting her soft");
				if (pregnancy.isPregnant) outputText(", milk laden");
				outputText(" breasts whilst slavishly polishing the [balls] of the " + player.mf("man","woman") + " who made her into, well, a ball-licking bitch.");
				//[Dominika dreams:
				if (flags[kFLAGS.NUMBER_OF_TIMES_MET_SCYLLA] > 0 && flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00150] > 0) outputText("  You are gripped by a sudden but thrilling velvet-edged sense of déjà vu.  Has this scene not repeated somewhere else?");
			}
		}
		//Vagina:
		else if (player.hasVagina()) {
			outputText("\n\nKelly's hot tongue presses against your [vagina], oozing already in sympathy to the lust which has gripped your male sex.  She is a bit of a stranger to your female anatomy but she's a quick and eager learner, tracing your entrance with the tip of her tongue before pushing her plush lips into your opening, covering your outer lips and your clit in shifting softness as she burrows into your tunnel with her tongue, curling deep into you as she worships every inch she can reach with her flexible mouth muscle, lapping up every trace of sweet moisture she finds with vocal pleasure.");
			outputText("\n\nYou close your eyes and lose yourself for a while, very gently thrusting your [hips] into her hot mouth as she makes your [vagina] glow with pleasure, sending small spasms of ecstasy shooting through your core, keeping your [cock biggest] straining.  It'd be so easy to ride her face to orgasm, but no, you signed up for the whole ten yards here and she isn't close to being finished.  With a bit of encouragement with your hips, you get her to pull away from your beading muff and move up to your cock.");
		}
		//Balls:
		else if (player.balls > 0) {
			outputText("\n\nKelly's hot tongue presses against your [balls] and you sigh as she begins to lavish them with worshipful attention.  ");
			//[Normal balls:]
			if (player.ballSize <= 8) {
				outputText("After curling her tongue here and there over each sensitive orb, bathing them in saliva, she envelops each one in her mouth, sucking gently first one, then the second");
				if (player.balls >= 4) outputText(", then the third, then the fourth");
				outputText(", then back to the first one, a slow and sensual repetition.  She moans intermittently as she does it, and you're not sure if it's intentionally to send delightful shivers of sensation through your scrotum and up the spine of [eachCock], or it's simply because the sheer degradation of the act, supporting her soft, ");
				if (pregnancy.isPregnant) outputText("milk-laden ");
				outputText("breasts whilst slavishly polishing the [balls] of the " + player.mf("man","woman") + " who made her into, well, a ball-licking bitch, fills her with deep, shameful lust.  Whatever the cause, the result is the same: pleasure thrums through your groin and up your [cock biggest], and you close your eyes, lost to the sensations of her skillful tongue.");
			}
			//Huge balls:
			else {
				outputText("After curling her tongue here and there over each sensitive orb, bathing them in saliva, she attempts to envelop one in her mouth.  She can't though; your testicles, bulging and tight with arousal, are simply too big.  After a short pause she goes back to licking them, lapping at their surface tenderly, licking all around each one for every trace of salt and musk, wetly caressing first one, then the second");
				if (player.balls >= 4) outputText(", then the third, then the fourth");
				outputText(", then back to the first one, a slow and sensual repetition.  The warm air is punctuated with desperate 'ahh, ahn, ahh's as she surrenders herself to the deep, shameful lust of the act, supporting her soft ");
				if (pregnancy.isPregnant) outputText(", milk laden");
				outputText(" breasts whilst slavishly polishing the [balls] of the " + player.mf("man","woman") + " who made her into, well, a ball-licking bitch.");
				//Dominika dreams:
				if (flags[kFLAGS.NUMBER_OF_TIMES_MET_SCYLLA] > 0 && flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00150] > 0) outputText("  You are gripped by a sudden but thrilling, velvet-edged sense of déjà vu.  Has this scene not repeated somewhere else?");
			}			
		}
		//[merge]
		outputText("\n\nBreathing heavily, she presses her lips against the base of your [cock biggest] again before slowly working her way up, licking here and kissing softly there as she goes.  ");
		if (player.biggestCockLength() > 15) outputText("It's a long way up and the effect is like a lift slowly rising, turning on a glow of lights on each level as it goes.  ");
		outputText("Finally she reaches your [cockHead biggest], and after resting her lips on your crown for a short time, moving them ever-so-gently to tantalize the most sensitive part of your bulging erection, she opens wide and envelops you, gripping the end of your dick in a soft, wet cave of shifting pleasure.  She slowly impales herself on it, her plump lips encapsulating more and more of your dick in sucking mouth flesh, and then it recedes, eventually even retreating from the crown as she goes back to licking and kissing the length.");
		outputText("\n\nYou look down with a mix of bemusement and amazement.  She doesn't return your gaze, her eyes closed and her hands on her boobs.  She continues to suck, lick and kiss your [cock biggest], slathering every inch she can reach with attention.  She really isn't trying to get any kind of reaction out of you.  She is completely bent upon worshipping your cock.  She finds a vein bulging with blue urgency and traces it upwards; the act makes you sigh and dribble pre-cum with pleasure.  Rising upwards, Kelly spreads her masterful tongue across your cum-slit and whimpers as the musky taste hits the back of her throat.");
		outputText("\n\nGrinning, you fully take in the image of your big boobed cumslut barely able to control her arousal as she laps at the very end of your cock with her hot tongue, and close your eyes as it causes you to dribble out even more pre.  It's enough.  Kelly moans as she sips the tiny stream down and shudders, her eyes rolling as femcum volubly spatters the ground behind her.  You shake your head in amazement.  It's so tempting to join her in orgasm and coat her with the load that is now pressing insistently on your cock... but no.  You aren't done yet, not by a long shot.");
		
		outputText("\n\n\"<i>It's lovely that you're such a bitch you can cum just from lapping up the smallest trickle of my weakest juices,</i>\" you say, letting amusement soak into your words.  \"<i>But we aren't here for you.  What can you do for me?</i>\"  The centaur only has eyes for your prick, licking her plump lips instinctively as she gathers her breath, her ardour and hunger not dimmed in the slightest.  She swathes your [cockHead biggest] in her mouth again, her head bobbing purposefully as your length is swallowed by the roiling wetness again, this time working rhythmically, ribbing it with pliant pleasure.  You sigh as you begin to lose yourself in the soft but purposeful motion, revolving your hips now with the pulse of her movements.");
		outputText("\n\nBit by bit, she takes more and more of your [cock biggest] into her milking redness.");
		if (player.biggestCockLength() > 12) outputText("  She can't take all of your dick but she tries her best, thrusting her head down as she crams her mouth with your thick hardness until you are touching her tonsils.  Lust crowding you now, you take hold of her head and force her further down your [cock biggest], gently but purposefully pushing further into her tight throat with each thrust.  You manage to hold back on your urge to simply face fuck her as hard as you can, instead taking hold of the base of her braid and moving her back and forth on your length as sensually as you can, drawing your dick back from the delicious tightness of her throat so she can breathe deep and spend a moment worshipping your [cockHead biggest] with her tongue and lips, eliciting a moaned 'mmm' from her each time before penetrating her gullet again.");
		//[Cock <12: 
		else outputText("  Her mouth is a good fit for your dick and you soon find your limit, touching the back of her throat with each gentle thrust.  You manage to hold back on your urge to simply face fuck her as hard as you can, instead taking hold of the base of her braid and moving her back and forth on your length as sensually as you can, drawing your dick back to the entrance of her mouth so she can worship your [cockHead biggest] with her tongue and lips, eliciting a moaned 'mmm' or from her each time before thrusting deep into her maw again.");
		outputText("\n\nShe runs her tongue forward along the underbelly of your [cock biggest] as you thrust inwards and then backwards as you withdraw, creating the sweetest friction imaginable, and you find you are breathing hard, running close to the wind now as you thrust into her sucking, milking mouth harder and harder.  The more vigorously you do it, the louder Kelly's muffled sighs and slurps of pleasure become.");
		
		outputText("\n\nShe has been holding her boobs out to you this whole time, and it seems churlish not to accept such a pleasant invitation.  You hold yourself right back, letting her tongue and caress your engorged cockhead for a long moment, waiting until her hums turn into outright gasps of arousal, then thrust as deep as you can into her juicy mouth, holding her head as you face fuck your way to your pent up high.  At the last moment");
		if (player.balls > 0) outputText(", as you feel your [balls] clench");
		outputText(", you pull out, grip your [cock biggest] at the base, point it at your cumslut's big creamy tits and groan as your bulging cock tenses.  She 'aww's in deep disappointment as the dick is torn away from her but she obediently presents her fat, pert breasts, and her breathy sigh is what you hear as orgasm clenches you.  Your cock slit dilates and you spurt out rope after rope of jizz");
		if (flags[kFLAGS.KELLY_BONUS_BOOB_ROWS] > 0) outputText(" onto all four of her tits");
		outputText(".  The sensation of deep release is ecstatic, the sight of your cock cream pasting your slave's softness delicious.");
		if (player.cumQ() >= 750) outputText("\n\nAs ever you can barely control yourself once you get going, and it feels like you cum for minutes on end, painting not just her chest but her face and stomach, not stopping until she is absolutely caked and dripping with your potent sex.");
		if (player.hasVagina()) outputText("\n\nYour female sex clenches and orgasms in sympathy, and you feel fluid dribble down your [hips] as you continue to paint Kelly.  Your only dim regret is that there's no way of soaking her with that, too.");
		outputText("  Finally you are spent.");
	}
	//Centaur:
	else {
		outputText("\n\nYou feel your [cock biggest] straining downwards as you slide out of your [armor], and you grin as you draw in close to Kelly, letting the smell of your demanding musk envelop her as you stand over her, drooping your cock against her face.  Her skin flushes and her breath comes more rapidly as you brush her cheek with it.  You smile, step back and gently but firmly tell her to put her hands under her tits, close her eyes, open her mouth and then be still.");
		outputText("\n\nYou admire the sight for a moment.  Blood surges into your [cock biggest] as you look at your pretty centaur slave presenting her big, round breasts to you with her tongue out, waiting patiently to take your load whole.  You clop in and tease her again with your [cock biggest], softly brushing her face with your [cockHead biggest], working the musky smell deep into her head.  She closes her eyes and breathes out deeply, enveloping your crotch in warm air.");
		//Horse cock:
		if (player.cocks[player.biggestCockIndex()].cockType == CockTypesEnum.HORSE) outputText("\n\nYou wonder whether the fact that you are a centaur and it is a horse cock, protruding proudly out of its sheath, makes it particularly difficult for her to resist, that your animal musk triggers some deep urge hardwired into her.  There's no way to really judge, but it seems like you've only just begun to tantalize her with it that the air below your barrel-like body is filled with bitten off grunts and moans as you rub her with your flared stallion prick, always keeping it tantalizingly out of reach of her mouth.");
		outputText("  Finally, after about a minute of this tender torture, you hear her groan from deep within her throat.");
		
		outputText("\"<i>Please [Master], let me swallow you, let me taste your strength, let me feel like a slut should,</i>\" she begs. \"<i>I'll make it so good for you you'll never want anyone else, just like I will never want anyone else.  Just... let me drink your cum!</i>\"");
		outputText("\n\nYou let a long second go by.");
		outputText("\n\n\"<i>Go on then,</i>\" you say, trying to keep the amused tone out of your voice. \"<i>Show me why you deserve it.  Nice and slow.  And keep your hands where they are.</i>\"  Kelly lets out a small whinny of pleasure and bends into your crotch, kissing the base of your [cock biggest] longingly as she gets to work.");
		//If PC has anything else aside from a single cock:
		if (player.cockTotal() > 1 || player.hasVagina()) outputText("  You're in no hurry, and with a slight roll of your [hips] you direct her to start at the front and work her way down.");
		
		//Vagina and balls:
		if (player.hasVagina() && player.balls > 0) {
			outputText("\n\nKelly brushes your [balls] out of the way as she burrows deep into your groin, her hot tongue finally pressing against your [vagina], oozing already in sympathy to the lust which has gripped your male sex.  She is a bit of a stranger to your female anatomy but she's a quick and eager learner, tracing your entrance with the tip of her tongue before pushing her plush lips into your opening, covering your outer lips and your clit in shifting softness as she burrows into your tunnel with her tongue, curling deep into you as she worships every inch she can reach with her flexible mouth muscle, lapping up every trace of sweet moisture she finds with vocal pleasure.");
			outputText("\n\nYou close your eyes and lose yourself for a while, very gently thrusting your [hips] into her hot mouth as she makes your [vagina] glow with pleasure, sending small spasms of ecstasy shooting through your core, keeping your [cock biggest] straining.  It'd be so easy to ride her face to orgasm... but no, you signed up for the whole ten yards here and she isn't even close to being finished.  With a bit of encouragement with your hips, you get her to pull away from your beading muff and move on to your balls.  She sighs as she begins to lavish them with worshipful attention.");
			//[Normal balls:
			if (player.ballSize <= 8) {
				outputText("\n\nAfter curling her tongue here and there over each sensitive orb, bathing them in saliva, she envelops each one in her mouth, sucking gently first one, then the second");
				if (player.balls >= 4) outputText(", then the third, then the fourth");
				outputText(", then back to the first one, a slow and sensual repetition.  She moans intermittently as she does it, and you're not sure if it's intentionally to send delightful shivers of sensation through your scrotum and up the spine of [eachCock], or it's simply because the sheer degradation of the act fills her with deep, shameful lust- supporting her soft");
				if (pregnancy.isPregnant) outputText(", milk-laden");
				outputText(" breasts whilst slavishly polishing the [balls] of the centaur who made her into, well, a ball-licking bitch.  Whatever the cause the result is the same.  Pleasure thrums through your groin and up your [cock biggest] and you close your eyes, lost to the sensations of her skillful tongue.");
			}
			//[Huge balls:
			else {
				outputText("\n\nAfter curling her tongue here and there over each sensitive orb, bathing them in saliva, she attempts to envelop one in her mouth.  She can't though - your testicles, bulging and tight with arousal, are simply too big.  After a short pause she goes back to licking them, lapping at their surface tenderly, licking all around each one for every trace of salt and musk, wetly caressing first one, then the second");
				if (player.balls >= 4) outputText(", then the third, then the fourth");
				outputText(", then back to the first one, a slow and sensual repetition.  The warm air is punctuated with desperate 'ahh, ahn, ahh's as she surrenders herself to the deep, shameful lust of the act, supporting her soft");
				if (pregnancy.isPregnant) outputText(", milk laden");
				outputText(" breasts whilst slavishly polishing the [balls] of the centaur who made her into, well, a ball-licking bitch.");
				if (flags[kFLAGS.NUMBER_OF_TIMES_MET_SCYLLA] > 0 && flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00150] > 0) outputText("  You are gripped by a sudden but thrilling, velvet-edged sense of déjà vu.  Has this scene not repeated somewhere else?");
			}
		}
		//Vagina: 
		else if (player.hasVagina()) {
			outputText("\n\nKelly's hot tongue presses against your [vagina], oozing already in sympathy to the lust which has gripped your male sex.  She is a bit of a stranger to your female anatomy but she's a quick and eager learner, tracing your entrance with the tip of her tongue before pushing her plush lips into your opening. She covers your outer lips and your clit in shifting softness as she burrows into your tunnel with her tongue, curling deep into you as she worships every inch she can reach with her flexible mouth muscle.  Lapping up every trace of sweet moisture she finds, Kelly hums with vocal pleasure.");
			outputText("\n\nYou close your eyes and lose yourself for a while, very gently thrusting your [hips] into her hot mouth as she makes your [vagina] glow with pleasure, sending small spasms of ecstasy shooting through your core, keeping your [cock biggest] straining.  It'd be so easy to ride her face to orgasm... but no, you signed up for the whole ten yards here, and she isn't close to being finished.  With a bit of encouragement with your hips, you get her to pull away from your beading muff and move down to your cock.");
		}
		//Balls: 
		else if (player.balls > 0) {
			outputText("\n\nKelly's hot tongue presses against your [balls] and you sigh as she begins to lavish them with worshipful attention.  ");
			//[Normal balls:
			if (player.ballSize <= 8) {
				outputText("  After curling her tongue here and there over each sensitive orb, bathing them in saliva, she envelops each one in her mouth, sucking gently first one, then the second");
				if (player.balls >= 4) outputText(", then the third, then the fourth");
				outputText(", then back to the first one, a slow and sensual repetition.  She moans intermittently as she does it, and you're not sure if it's intentionally to send delightful shivers of sensation through your scrotum and up the spine of [eachCock], or it's simply because the sheer degradation of the act, supporting her soft");
				if (pregnancy.isPregnant) outputText(", milk-laden");
				outputText(" breasts whilst slavishly polishing the [balls] of the centaur who made her into, well, a ball-licking bitch, fills her with deep, shameful lust.  Whatever the cause the result is the same; pleasure thrums through your groin and up your [cock biggest] and you close your eyes, lost to the sensations of her skillful tongue.");
			}
			//[Huge balls:
			else {
				outputText("  After curling her tongue here and there over each sensitive orb, bathing them in saliva, she attempts to envelop one in her mouth.  She can't though - your testicles, bulging and tight with arousal, are simply too big.  After a short pause, she goes back to licking them, lapping at their surface tenderly, licking all around each one for every trace of salt and musk, wetly caressing first one, then the second");
				if (player.balls >= 4) outputText(", then the third, then the fourth");
				outputText(", then back to the first one, a slow and sensual repetition.  The warm air is punctuated with desperate 'ahh, ahn, ahh's as she surrenders herself to the deep, shameful lust of the act, supporting her soft");
				if (pregnancy.isPregnant) outputText(", milk-laden");
				outputText(" breasts whilst slavishly polishing the [balls] of the centaur who made her into, well, a ball-licking bitch.");
				if (flags[kFLAGS.NUMBER_OF_TIMES_MET_SCYLLA] > 0 && flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00150] > 0) outputText("  You are gripped by a sudden but thrilling, velvet-edged sense of déjà vu.  Has this scene not repeated somewhere else?");
			}
		}
		//[merge]
		outputText("\n\nBreathing heavily, she presses her lips against the base of your [cock biggest] again before slowly working her way down, licking here and kissing softly there as she goes.");
		//[Cock >15 inches:
		if (player.biggestCockLength() > 15) {
			outputText("  It's a long way down and the effect is like a lift slowly descending, turning on a glow of lights on each level as it goes.");
		}
		outputText("  Finally she reaches your [cockHead biggest], and after resting her lips on your crown for a short time, moving them ever-so-gently to tantalize the most sensitive part of your bulging erection, she opens wide and envelops you, gripping the end of your dick in a soft, wet cave of shifting pleasure.  She slowly impales herself on it, her plump lips encapsulating more and more of your dick in sucking mouth flesh... and then it recedes, eventually even retreating from the crown as she goes back to licking and kissing the length.");
		outputText("\n\nYou close your eyes and lose yourself to the slow, worshipping rhythms of her tongue.  She finds a vein bulging with blue urgency and traces it upwards.  The act makes you sigh and dribble pre-cum with pleasure.  You feel a masterful tongue run across your cum-slit, and then hear a high whimper as the musky taste hits the back of her throat.  Grinning, you close your eyes and imagine the scene below you, your big boobed cumslut barely able to control her arousal as she laps at the very end of your cock with her hot tongue.  The thought causes you to dribble out even more pre.");
		outputText("\n\nIt's enough.  Kelly moans as she sips the tiny stream down.  In front of you, femcum volubly spatters the ground behind her horse frame.  You shake your head in amazement.  It's so tempting to join her in orgasm and coat her with the load that is now pressing insistently on your cock... but no.  You aren't done yet, not by a long shot.");
		
		outputText("\n\n\"<i>It's lovely that you're such a bitch you can cum just from lapping up the smallest trickle of my weakest juices,</i>\" you say, letting amusement soak into your words.  \"<i>But we aren't here for you.  What can you do for me?</i>\"  After a short pause, Kelly responds by swathing your [cockHead biggest] in her mouth again, her head bobbing purposefully as your length is swallowed by the roiling wetness again, this time working rhythmically, ribbing it with pliant pleasure.  You sigh as you begin to lose yourself in the soft but assiduous motion, revolving your hips now with the pulse of her movements.");
		outputText("\n\nBit by bit, she takes more and more of your [cock biggest] into her milking redness.  ");
		//[Cock >12:
		if (player.biggestCockLength() > 12) {
			outputText("  She can't take all of your dick but she tries her best, thrusting her head down as she crams her mouth with your thick hardness until you are touching her tonsils.  Lust crowding you now, you thrust your back haunches forward, forcing her further down your [cock biggest], gently but purposefully pushing further into her tight throat with each thrust.  You manage to hold back on your urge to simply face fuck her as hard as you can, instead moving her back and forth on your length as sensually as you can, drawing your dick back from the delicious tightness of her throat so she can breathe deep and spend a moment worshipping your [cockHead biggest] with her tongue and lips, eliciting a moaned “mmm” from her each time before penetrating her gullet again.");
		}
		//[Cock <12: 
		else {
			outputText("  Her mouth is a good fit for your dick and you soon find your limit, touching the back of her throat with each gentle thrust.  You manage to hold back on your urge to simply face fuck her as hard as you can, instead moving your haunches back and forth as sensually as you can, drawing your dick back to the entrance of her mouth so she can worship your [cockHead biggest] with her tongue and lips, eliciting a moaned “mmm” from her each time before thrusting deep into her maw again.");
		}
		outputText("\n\nShe runs her tongue forward along the underbelly of your [cock biggest] as you thrust inwards and then backwards as you withdraw, creating the sweetest friction imaginable, and you find you are breathing hard, running close to the wind now as you thrust into her sucking, milking mouth harder and harder.  The more vigorously you do it the louder Kelly's muffled slurps and sighs of pleasure become.");
		
		outputText("\n\nShe has been holding her boobs out to you this whole time, and it seems churlish not to accept such a pleasant invitation.  You hold yourself right back, letting her tongue and caress your engorged cockhead for a long moment, waiting until her hums turn into outright gasps of arousal, then thrust as deep as you can into her juicy mouth, fucking that juicy, slutty hole all the way up to your pent up high.  At the last moment");
		if (player.balls > 0) outputText(", as you feel your [balls] clench");
		outputText(", you pull out and point your [cock biggest] downwards.  She 'aww's in deep disappointment as the dick is torn away from her, but you shush her.");
		
		outputText("\n\n\"<i>I'm going to cum now,</i>\" you grit out, your pulse as heavy and hard in your head as the load in your cock is.  \"<i>If you want to drink my leavings down like a shameless, whimpering, ");
		if (player.hasVagina()) outputText("pussy-licking, ");
		if (player.balls > 0) outputText("ball-sucking ");
		outputText("cock addict, you will have to do a good job of catching it on those whore pillows of yours.</i>\"  With that, you thrust your hindquarters forward.  Her breathy groan is what you hear as orgasm clenches you.");
		outputText("\n\nYour cock slit dilates and you spurt out rope after rope of jizz");
		if (flags[kFLAGS.KELLY_BONUS_BOOB_ROWS] > 0) outputText(" onto all four of her tits");
		outputText(".  The sensation of deep release is ecstatic, the sound of your cock cream spattering onto your slave's softness delicious.");
		//[Vagina:
		if (player.hasVagina()) outputText("  Your female sex clenches and orgasms in sympathy, and you feel fluid dribble down your [hips] as you continue to paint Kelly.  Your only dim regret is that there's no way of soaking her with that, too.");
		outputText("\n\nFinally you are spent.  You clop around to admire your handiwork.");
		//Low cum:
		if (player.cumQ() < 750) outputText("  Kelly has done a sterling job of catching your load; you've frosted her boobs with long strokes quite convincingly.");
		else {
			outputText("  As ever, your virility has gotten the better of you.  Kelly looks like she's in an ecstatic trance.  You've completely pasted not just ");
			if (flags[kFLAGS.KELLY_BONUS_BOOB_ROWS] > 0) outputText("all four of ");
			outputText("her boobs with alabaster ooze, but her stomach, face and hair.  She's holding a reservoir of the stuff in her cleavage.");
		}
	}
	//[merge]
	outputText("\n\n\"<i>Thank you for using me, [Master],</i>\" she says once you're finished, grinning happily as she gazes at the off-white goo splattered across her breasts, her cheeks rosy with exertion.  \"<i>But, couldn't you have made it in my mouth?  I would have swallowed it all down, you know.  I'm a good girl.</i>\"");
	outputText("\n\nYou laugh as you settle yourself down facing towards her");
	if (!player.isTaur()) outputText(", still clutching your pleasantly aching prick");
	outputText(", saying you know she is, but it's a lot more pleasing to you to see her get her fix this way.  Quickly cottoning on, the centaur stares at you with her lustful green eyes as she lifts a cum-spattered boob to her mouth.");
	
	outputText("\n\nYou watch as Kelly licks herself clean, sending her mouth slowly sliding across her soft, sensitive curves, lapping up every rivulet of your thick seed she can reach.  At first, she does it to put on a show for you, holding your eyes with a winsome smile as she bends her tongue into her pliant flesh and hooks another stream of cum into her maw with an exaggerated smack of her lips.  But the effect your fluids have on her quickly takes over, and she laps at her boobs with increasing urgency, a flush high on her cheeks as your warm jizz slides down her throat, scratching her itch, making her yet more needy, more addicted to you with each load she swallows.");
	if (flags[kFLAGS.KELLY_BONUS_BOOB_ROWS] > 0) outputText("\n\nShe can't reach her lower row of tits with her tongue, so she simply runs her hands over them, sighing as she rubs your musk into her horny skin and hard nipples before running her tongue across her palms.");
	outputText("  She leaves a trail of cum leaking down a nipple until at last, closing her eyes, she tenses and orgasms with a muffled sigh as her wet tongue pushes over her erect nub and guides the last of your fix into her mouth.");
	
	//[Libido <50: 
	if (player.lib < 50) {
		outputText("\n\nYou stroke yourself languidly to the obscene display and your [cock biggest] is hard again by the time she's finished.  It'd be so easy to stay here and do it with her again, and again, and again... but no, there are plenty of other places you need to be and you are quite spent.  You say goodbye to your cumslut centaur with a fond kiss on the forehead and a slap on the ass before leaving the farm behind you.");
	}
	//Libido >50:
	else {
		outputText("\n\nYou stroke yourself languidly to the obscene display, and your [cock biggest] is straining urgently again before she's even half done.  Although your intention was to leave once she had finished, you find yourself letting her gaze hungrily into your eyes again, letting her press her hands on your [chest]");
		if (player.hasVagina()) outputText(", letting her sensually lick you out again until your [vagina] is gleaming with arousal");
		if (player.balls > 0) outputText(", letting her needily suckle on your [balls] again until they are inflamed with renewed pressure");
		outputText(", letting her engulf your [cock biggest] with her plump lips again, letting her soft, muffled moans fill your ears as her head bobs over your groin until you clench and cum again, jetting every last drop you have remaining into that beautiful, filthy, juicy little mouth.  Kelly swallows it all down, and goes on licking your clean [cockHead biggest] until you order her with a slight groan to stop.");
		
		outputText("\n\n\"<i>See?  I'm a good girl, [Master].  Never doubt it!</i>\" she says with a wide grin, putting her arms around your waist and gazing up at you, profoundly proud of herself.  You suppose you should be mad at her for taking advantage of your out-of-control libido, but it's difficult to get really angry with a slave who sucks dick quite as well as she does.  After you've rested for a short while, you say goodbye to your cumslut centaur with a fond kiss on the forehead and a slap on the ass, before leaving the farm behind you.");
	}
	player.orgasm();
	dynStats("sen", -2);
	doNext(camp.returnToCampUseOneHour);
}
}
}
