package classes.Scenes.NPCs{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.GlobalFlags.kGAMECLASS;
	
	public class IsabellaFollowerScene extends NPCAwareContent {
		
	public function IsabellaFollowerScene()
	{
	}

	/*===========================
Izzy Affection stat.
=============================
Follower option procs at 50 affection.
Damaging her physically in combat reduces it by 1.
Rape scenes she does not like reduce it by 10.
Talking her into accepting you tall adds 20.
Being short when you meet her adds 10.
Lovey Dovey stuff adds between 2 and 5.

=============================
Benefits of In-Camp Isabella
=============================
Adds flag that upticks by one every day Isabella goes unmilked by someone else unless set to less than zero by an event; unlocks fatigue-restoring milk item at 10 if b-milkers are installed at farm (sample midnight trigger: if Izzymilkedyet flag >= 0, add 1)
Throat Punch?
Isabella modifies armor to provide additional +1 bonus?
Optional Morning Oral for small-membered males*/

/*===========================
Variable List
===========================*/
//ISABELLAS CUNT CAPACITY: 164!

//const ISABELLA_TIMES_OFFERED_FOLLOWER:int = 367;
//const ISABELLA_AFFECTION:int = 368;
//const ISABELLA_FOLLOWER_ACCEPTED:int = 369;
//const ISABELLA_PLAINS_DISABLED:int = 370;
//const ISABELLA_CAMP_DISABLED:int = 371;
//const ISABELLA_ACCENT_TRAINING_PERCENT:int = 372;
//const ISABELLA_ACCENT_TRAINING_COOLDOWN:int = 373;
//const ISABELLA_ACCENT_FORCED_ON:int = 374;
//const ISABELLA_MILKED_YET:int = 375;
//const ISABELLA_BLOWJOBS_DISABLED:int = 376;
//const ISABELLA_MORNING_FELLATIO_COUNT:int = 377;
//const ISABELLA_TIME_SINCE_LAST_HOTDOGGING:int = 378;
//const ISABELLA_TIMES_HOTDOGGED:int = 379;
//const ISABELLA_MILK_COOLDOWN:int = 380;
//const ISABELLA_MURBLE_BLEH:int = 381;
//const ISABELLA_SPARRING_INTRO:int = 382;
//const ISABELLA_PROBOVA_BURP_COUNT:int = 383;
//const FOUND_ISABELLA_AT_FARM_TODAY:int = 707;

override public function isabellaFollower():Boolean {
	return flags[kFLAGS.ISABELLA_FOLLOWER_ACCEPTED] == 1 && flags[kFLAGS.ISABELLA_CAMP_DISABLED] == 0;

}
override public function isabellaAccent():Boolean {
	if (flags[kFLAGS.ISABELLA_ACCENT_TRAINING_PERCENT] < 100) return true;
	if (flags[kFLAGS.ISABELLA_ACCENT_FORCED_ON]) return true;
	return false;
}
internal function isabellaAffection(mod:int = 0):int {
	flags[kFLAGS.ISABELLA_AFFECTION] += mod;
	if (flags[kFLAGS.ISABELLA_AFFECTION] > 100) flags[kFLAGS.ISABELLA_AFFECTION] = 100;
	else if (flags[kFLAGS.ISABELLA_AFFECTION] < 0) flags[kFLAGS.ISABELLA_AFFECTION] = 0;
	return flags[kFLAGS.ISABELLA_AFFECTION];
}

public function isabellaSprite():void
{
	spriteSelect(31);
}

public function isabellaKnockUpAttempt():void {
	if (flags[kFLAGS.ISABELLA_POTENCY_STATE] == 1 && !isabellaScene.pregnancy.isPregnant) { //Pregnancy is enabled
		//Set chance
		var chance:int = 30;
		chance += Math.floor(Math.sqrt(player.cumQ()));
		chance -= isabellaScene.totalIsabellaChildren();
		if (chance > 70) chance = 70;
		chance += player.virilityQ() * 100;
		if (chance > 90) chance = 90;
		//Attempt to knock up!
		if (rand(100) < chance) isabellaScene.pregnancy.knockUpForce(PregnancyStore.PREGNANCY_PLAYER, PregnancyStore.INCUBATION_ISABELLA);
		trace("Isabella got PREGNANT!");
	}
}

//Isabella Moves In Intro
internal function isabellaMoovesInGreeting():void {
	spriteSelect(31);
	clearOutput();
	if (flags[kFLAGS.ISABELLA_TIMES_OFFERED_FOLLOWER] == 0) {
		outputText("Isabella gives you a warm smile when you wander into her camp and spikes the sharp edge of her shield into the ground, leaving it standing next to her.  Her big brown eyes are filled with warmth and affection for a friend as she greets you, saying, \"<i>Velcome back, " + player.short + ".  Did you miss little old me?</i>\"\n\n", false);
		
		outputText("You ", false);
		if (player.cor < 33) outputText("smile, and admit that you do enjoy the time you spend with her.", false);
		else if (player.cor < 66) outputText("grin and joke that she probably missed you more.", false);
		else outputText("smirk and wonder if you missed her or her magnificent body.", false);
		outputText("  Isabella takes a deep breath before rising to her full, seven-foot-plus height. \"<i>" + player.short + ", I have thought long and hard on zis,</i>\" she begins.  \"<i>I vould like to join you at your camp and assist you on your quest.  It seems a worthy cause.</i>\"  The tall cow-girl brushes her unruly red locks back and admits, \"<i>I could use ze companionship...</i>\"\n\n", false);
		
		outputText("Well, you didn't expect that.  While you muse over the idea, Isabella sashays up to give you a hug.  Her tits ", false);
		if (player.tallness < 80) outputText("crush around your head, smothering you in heavy, milk-filled breast flesh", false);
		else outputText("squeeze against your " + player.chestDesc() + ", the four hard nipples capping each milk-flooded breast pressing on your own.", false);
		outputText("  You blush and squirm a little from the dark-hued warrioress's affections, yet you endure them all the same.\n\n", false);
		
		outputText("Do you invite her to camp?", false);
		doYesNo(moveTheBitchIn,turnDownIsabellaFollower);
	}
	//Repeat Offer
	else {
		outputText("You stumble into Isabella's camp and find her hard at work on her shield.  Currently she's banging dents out of it with a huge hammer.  She barely looks up when you arrive, but from what you can see, the corners of the cow-girl's mouth are curled up in a warm smile.  The dark-skinned beauty pauses long enough look up and ask, \"<i>Have you thought about mein offer?  Ve could do more good working together zen apart.</i>\"  She finishes her task and jams the edge of the shield into the ground, the hunk of metal vibrating slightly from the sudden impact.\n\n", false);
		
		outputText("Isabella still seems to think that moving in would be a good idea; do you accept her proposal, or demur for now?  She doesn't seem too dead-set on the idea.", false);
		//(Raise threshold for next occurance to current affection + 15)
		//[Accept - Use standard] [Normal Menu Options]
		var suck:Function = null;
		if (player.hasCock()) {
			if (player.cocks[player.shortestCockIndex()].cockLength < 9)
				suck = isabellaScene.izzyGivesSmallWangsFreeOral;
		}
		choices("Talk", isabellaScene.talkWithIsabella, "Drink", isabellaScene.nomOnMommaIzzysTits, "Get Licked", suck,
			"Fight 4 Rape", isabellaScene.fightIsabella, "Offer Oral", isabellaScene.volunteerToSlurpCowCunt, "Accept Offer", moveTheBitchIn,
			"", null, "", null, "", null, "Leave", camp.returnToCampUseOneHour);
	}
	flags[kFLAGS.ISABELLA_TIMES_OFFERED_FOLLOWER]++;
}
//Decline Izzy Initial Moving Offer (-10 affection) 
private function turnDownIsabellaFollower():void {
	spriteSelect(31);
	isabellaAffection(-10);
	clearOutput();
	outputText("You push back from Isabella's smothering embrace with a little bit of frustration.  As soon as she realizes what's going on, the heavy-breasted woman's cheeks color in embarrassment and she retreats to her shield, her hands kneading the hard metal edge nervously.  You inform her that it would be best she remain here for now, at least until you've succeeded in your mission and brought peace to this strange place.\n\n", false);
	
	outputText("Isabella sighs and slumps down against her metal defender at your words.  Eventually, she answers, \"<i>I... understand, " + player.short + ".  I shall continue mein lonely vigil.  Vas zere somezing else I could do for you, ja?</i>\"\n\n", false);
	var suck:Function = null;
	if (player.hasCock()) {
		if (player.cocks[player.shortestCockIndex()].cockLength < 9)
			suck = isabellaScene.izzyGivesSmallWangsFreeOral;
	}
	choices("Talk", isabellaScene.talkWithIsabella, "Drink", isabellaScene.nomOnMommaIzzysTits, "Get Licked", suck,
		"Fight 4 Rape", isabellaScene.fightIsabella, "Offer Oral", isabellaScene.volunteerToSlurpCowCunt, "", null,
		"", null, "", null, "", null, "Leave", camp.returnToCampUseOneHour);
}
//Move Ze Bitch In! 
private function moveTheBitchIn():void {
	spriteSelect(31);
	clearOutput();
	outputText("As soon as you nod, Isabella smiles and tears her shield out of the ground, setting off a small avalanche of dirt and pebbles across her rugs.  The industrious cow-girl starts packing up her things immediately.  \"<i>It vas time to move out of zis little camp any how,</i>\" she declares as she folds her chair into a chest.  You get an eyeful of her generous backside, the plump rump swaying and jiggling back and forth with every movement Isabella's efforts generate.  It's almost hypnotizing, even half-hidden as it is under her olive-toned skirt.  A breeze blows the hem partway up, and though it doesn't go far, you watch with an intrigued, vacant stare.\n\n", false);
	
	outputText("Isabella catches you staring and gives you a sultry, seductive look as she ask, \"<i>Mmm, do you see something you like, " + player.short + "?  Do you like to watch mein butt while I work?  If zat is ze case zen ve vill never get anything done once I move in!</i>\"  You hesitantly look up at her face, and she laughs with a voice that tinkles like ringing bells.  \"<i>You can vatch me like zat if you want, but I vould rather you help me move all zis,</i>\" the cow-girl mentions.  You smile ruefully and help your ", false);
	if (camp.hasCompanions()) outputText("newest ", false);
	outputText("camp follower gather and move her possessions to your camp.  It takes the better part of an hour, but the entire decor is coming with you, so it may just be worth it.\n\n", false);
	outputText("\n\n(<b>Isabella now available in the lovers menu.</b>)");
	flags[kFLAGS.ISABELLA_COUNTDOWN_TO_CONTRACEPTIONS] = 240;
	flags[kFLAGS.ISABELLA_AFFECTION] = 100;
	flags[kFLAGS.ISABELLA_FOLLOWER_ACCEPTED] = 1;
	flags[kFLAGS.ISABELLA_PLAINS_DISABLED] = 1;
	doNext(camp.returnToCampUseOneHour);
}

//Follower Summoned Text: 
public function callForFollowerIsabella():void {
	spriteSelect(31);
	clearOutput();
	if (flags[kFLAGS.FOLLOWER_AT_FARM_ISABELLA] == 0)
	{
		outputText("You get Isabella's attention and call the busty cow-girl your way.  She seems a bit consterned as she breaks away from her previous task, but as she closes in towards you, she's all smiles.  You're given plenty of time to appreciate the curvaceous beauty's body while she ambles over.\n\n", false);
		
		outputText("The cow-girl is about seven and a half feet tall.  Instead of feet, she has hooves, complete with fur that grows part-way up her legs.  Her olive skirt only covers the upper portion of her dusky, spotted thighs, and it flares out deliciously from her swaying hips.  Isabella's top is sheer, white silk that barely hides anything from you, least of all her exotic, quad-tipped nipples.  Unlike most of the rest of her, her face is not spotted with dark and white patches.  Instead it is pure, unbroken chocolate in color.  Two small, bovine horns sprout from her head, emerging from the tangle of her unruly, red curls.  She even has a pair of cow ears that flick back and forth from time to time.\n\n", false);
		
		outputText("Isabella ", false);
		if (player.tallness < 72) outputText("picks you up in her arms and embraces you with a crushing hug, nearly burying you in her boobflesh before she lets you go.", false);
		else outputText("gives you a crushing hug, smashing her tits flat against your body.", false);
		outputText("  She says, \"<i>", false);
		if (isabellaAccent()) outputText("Hi " + player.short + "!  Vat do you need from Izabella?", false);
		else outputText("Hiya " + player.short + "!  Anything I can help you with?", false);
		outputText("</i>\"", false);
		if (player.hasCock()) {
			if (player.shortestCockLength() > 9)
			{
				outputText("\n\nSadly, you're too big for Isabella to be interested in providing you with morning blowjobs.");
			}
			else
			{
				if (flags[kFLAGS.ISABELLA_BLOWJOBS_DISABLED] == 0) 
				{
					outputText("\n\nYou could ask Isabella not to suck you off in the morning. (In Sex Menu)", false);
				}
				else 
				{
					outputText("\n\nYou could ask Isabella to give you blowjobs in the morning. (In Sex Menu)", false);
				}
			}
		}
	}
	else
	{
		outputText("Isabella puts down the milk canister she’s carrying and wipes her brow at your approach.");

		if (isabellaAccent()) outputText("\n\n“<i>Guten tag, [name]. What can Isabella help you with?</i>”");
		else outputText("\n\n“<i>Hello [name]. What can Isabella help you with?</i>”");
	}
	
	menu();
	addButton(0, "Appearance", isabellasAppearance, null, null, null, "Examine Isabella's detailed appearance.");
	addButton(1, "Talk", isabellaTalkMenu, null, null, null, "Ask Isabella about something.")
	addButton(2, "Sex", campIzzySexMenu, null, null, null, "Have some sex with the cow-girl.");
	addButton(3, "Spar", isabellaSparMenu, null, null, null, "Get into a quick battle with Isabella!");
	if (flags[kFLAGS.ISABELLA_ACCENT_TRAINING_PERCENT] < 100) addButton(4, "Accent Coach", isabellasAccentCoaching, null, null, null, "Teach Isabella to talk in normal accent.");
	else addButton(4, "Accent Uncoach", isabellaAccentUncoaching, null, null, null, "Let Isabella talk the way she wants. This will pretty much throw away all the coaching progress you've made.");
	if (flags[kFLAGS.ISABELLA_MILKED_YET] < 0) addButton(5, "Get Milk", getMilk, null, null, null, "Get a bottle of Isabella's milk.");
	if (player.hasItem(consumables.PROBOVA) && player.gender > 0) {
		outputText("\n\n<b>Isabella would probably drink a bottle of Pro Bova if you gave it to her.</b>", false);
		addButton(6, "GiveProBova", isabellaBurps, null, null, null, "Give a bottle of Pro Bova to Isabella?", "Give Pro Bova");
	}
	if (player.hasItem(consumables.OVIELIX) && isabellaScene.pregnancy.isPregnant && flags[kFLAGS.ISABELLA_PREGNANCY_BOOSTED] == 0) {
		outputText("\n\n<b>You can give Isabella a bottle of Ovi Elixir to take ten days off her pregnancy although it only works once per pregnancy.</b>", false);
		addButton(7, "GiveOviElixir", isabellaTakesOviElixir, null, null, null, "Give a bottle of Ovi Elixir to Isabella? This will shorten her current pregnancy by ten days but you cannot do it again until she gives birth.", "Give Ovi Elixir");
	}
	if (flags[kFLAGS.FOLLOWER_AT_FARM_ISABELLA] == 0 && flags[kFLAGS.FARM_CORRUPTION_STARTED] == 1) addButton(10, "Farm Work", sendToFarm);
	if (flags[kFLAGS.FOLLOWER_AT_FARM_ISABELLA] == 1) addButton(10, "Go Camp", backToCamp);
	
	if (flags[kFLAGS.FOLLOWER_AT_FARM_ISABELLA] == 1) addButton(14, "Back", kGAMECLASS.farm.farmCorruption.rootScene);
	else addButton(14, "Back", camp.campLoversMenu);
}

private function sendToFarm():void
{
	clearOutput();
	isabellaSprite();
	
	outputText("“<i>Do you think you could do me a favor?</i>” you say to the Teutonic tit-monster. “<i>There’s a farm near here, down by the lake. I need anyone who is strong, and vigilant, and... has a lot of milk...</i>” To your relief, Isabella responds well to the idea.");

	if (isabellaAccent()) outputText("\n\n“<i>Ja, I know of this place from mein own travels. The baurehund is very kind, yes? She let me use the milk machines whenever I wanted. If her farm is now unsere farm, I will gladly help!</i>”");
	else outputText("\n\n“<i>Yes, I know of this place from my own travels. The farmdog is very kind, yes? She let me use the milk machines whenever I wanted. If her farm is now our farm, I will gladly help!</i>”");

	outputText("\n\nShe happily packs up and then sways off in the direction of the lake. She will get along very well with Whitney, you think, as well as providing the farm with a great deal of both strength and milk.");
	
	flags[kFLAGS.FOLLOWER_AT_FARM_ISABELLA] = 1;
	
	doNext(camp.returnToCampUseOneHour);
}

private function backToCamp():void
{
	clearOutput();
	isabellaSprite();
	
	outputText("“<i>Could you head back to camp? It’s just... it’s getting a little lonely at night up there.</i>” Your gambit pays off and Isabella pinches your cheek in delight.");

	if (isabellaAccent()) outputText("\n\n“<i>Aww, is mein little kuschelbar getting all cold and lonely by [himself]? Isabella will come back and keep you warm, ja, very warm indeed!</i>”");
	else outputText("\n\n“<i>Aww, is my little teddybear getting all cold and lonely by [himself]? Isabella will come back and keep you warm, yes, very warm indeed!</i>” You leave her to pack up her things and go.");
	
	flags[kFLAGS.FOLLOWER_AT_FARM_ISABELLA] = 0;
	
	doNext(kGAMECLASS.farm.farmCorruption.rootScene);
}

private function isabellasAppearance():void {
	clearOutput();
	
	if (isabellaScene.pregnancy.isPregnant) {
		switch(isabellaScene.pregnancy.event) {
			case 1:
				outputText("The cow-girl is about seven and a half feet tall. Instead of feet, she has hooves, complete with fur that grows part-way up her legs. Her olive skirt only covers the upper portion of her dusky, spotted thighs, and it flares out deliciously from her swaying hips. Isabella's top is sheer, white silk that barely hides anything from you, least of all her exotic, quad-tipped nipples. Unlike most of the rest of her, her face is not spotted with dark and white patches. Instead it is pure, unbroken chocolate in color. Two small, bovine horns sprout from her head, emerging from the tangle of her unruly, red curls. She even has a pair of cow ears that flick back and forth from time to time. Very little has changed since you two decided to have a child. Despite the fact that Isabella is off her birth controlling herbs, "); 
				if (player.cumQ() >= 500) outputText("and your potent babymaking skills, "); 
				outputText("you cannot help but question as to whether or not your seed was \"planted\" in the Bovine Braud's womb.");
				break;
			case 2:
				outputText("The cow-girl is about seven and a half feet tall. Instead of feet, she has hooves, complete with fur that grows part-way up her legs. Her olive skirt only covers the upper portion of her dusky, spotted thighs, and it flares out deliciously from her swaying hips. Since you did the deed you often find her on her plump, toned, derriere. ");
				if (player.lib >= 60) outputText("Every once in a while when the wind blows just right you get a pleasing view of her well lubricated womanhood between her legs. "); 
				outputText("Several times you've asked her if she is okay but she assures you it is just swollen ankles. Isabella's top is sheer, white silk that barely hides anything from you, least of all her exotic, quad-tipped nipples, and what you hope is a new slightly protruding baby bump. Unlike most of the rest of her, her face is not spotted with dark and white patches. Instead it is pure, unbroken chocolate in color. Two small, bovine horns sprout from her head, emerging from the tangle of her unruly, red curls. She even has a pair of cow ears that flick back and forth from time to time.");
				break;
			case 3:
				outputText("The cow-girl is about seven and a half feet tall. Instead of feet, she has hooves, complete with fur that grows part-way up her legs. Her olive skirt only covers the upper portion of her dusky, spotted thighs, and it flares out deliciously from her swaying hips. Isabella's top is sheer, white silk that clings tightly to her distended stomach and hides almost nothing from you, least of all her exotic, quad-tipped nipples. Unlike most of the rest of her, her face is not spotted with dark and white patches. Instead it is pure, unbroken chocolate in color except for her cheeks which are now constantly flushed. In your peripheral vision you swear she is constantly eying you. Two small, bovine horns sprout from her head, emerging from the tangle of her unruly, red curls. She even has a pair of cow ears that flick back and forth from time to time.");
				break;
			case 4:
				outputText("The cow-girl is about seven and a half feet tall. Instead of feet, she has hooves, complete with fur that grows part-way up her legs. There is an uneasiness in her gait due to, what you can only assume, is a shift in balance because of the new precious cargo she carries. Her olive skirt only covers the upper portion of her dusky, spotted thighs, and it flares out deliciously from her swaying hips. Isabella's top is sheer, white silk and is having trouble containing her nicely rounded belly. You aren't sure but you would swear her breasts are swelling up as well. Unlike most of the rest of her, her face is not spotted with dark and white patches. Instead it is pure, unbroken chocolate in color. Two small, bovine horns sprout from her head, emerging from the tangle of her unruly, red curls. She even has a pair of cow ears that flick back and forth from time to time. Every once in a while her hands fly up to rub her temples to soothe her returning headaches.");
				break;
			case 5:
				outputText("The cow-girl is about seven and a half feet tall. Instead of feet, she has hooves, complete with fur that grows part-way up her legs. She can walk now without too much trouble, you must admit she carries children well. Her olive skirt only covers the upper portion of her dusky, spotted thighs, and it flares out deliciously from her swaying hips. Isabella's top cannot contain her large tummy which pops out slightly underneath. Your throat feels a little parched looking at the consistently wet stains near her quad tipped nipples. It would seem that her pregnancy has increased her already potent milk production. Unlike most of the rest of her, her face is not spotted with dark and white patches. Instead it is pure, unbroken chocolate in color. You cannot help but feel bad when you see her flinch from a cramp making it's way through her body. Two small, bovine horns sprout from her head, emerging from the tangle of her unruly, red curls. She even has a pair of cow ears that flick back and forth from time to time.");
				break;
			case 6:
				outputText("The cow-girl is about seven and a half feet tall. Instead of feet, she has hooves, complete with fur that grows part-way up her legs. Her olive skirt only covers the upper portion of her dusky, spotted thighs, and it flares out deliciously from her swaying hips. Isabella's top is made of a fine silk, and it clings tightly to her recently expanded bosom and stomach. Unfortunately for the once exquisite garment, the cowgirls increased lactation has stained the white blouse. Unlike most of the rest of her, her face is not spotted with dark and white patches. Instead it is pure, unbroken chocolate in color. You often find yourself avoiding her gaze. You remember hearing about mothers back in Ingham going through mood swings but nothing could have prepared you for this! It seems as though when she isn't yelling at you, she's smothering you. Two small, bovine horns sprout from her head, emerging from the tangle of her unruly, red curls. She even has a pair of cow ears that flick back and forth from time to time.");
				break;
			case 7:
				outputText("The cow-girl is about seven and a half feet tall. Instead of feet, she has hooves, complete with fur that grows part-way up her legs. Her olive skirt only covers the upper portion of her dusky, spotted thighs, and it flares out deliciously from her swaying hips. You're surprised she's managed to retain her figure with how much more she's been eating lately. You make a mental note to check on your food stores later when you hear her stomach growl again. Isabella's top is made of a fine silk and once had a pure white color that contrasted nicely with her skin. Now the fragile thing looks like its about to split in two! Her breasts are barely contained by the straining garment, and her belly almost completely pops out underneath it, the bovine braud allowing her top to ride over the swell of her stomach to prevent it from tearing apart. Unlike most of the rest of her, her face is not spotted with dark and white patches. Instead it is pure, unbroken chocolate in color. Two small, bovine horns sprout from her head, emerging from the tangle of her unruly, red curls. A fine layer of sweat clings to her brow despite the fact that it is relatively cool outside.She even has a pair of cow ears that flick back and forth from time to time.");
				break;
			case 8:
				outputText("Isabella seems to sleep a lot more nowadays. It seems her pregnancy has had quite a large drain on her energy.The cow-girl is about seven and a half feet tall, when standing. Instead of feet, she has hooves, complete with fur that grows part-way up her legs. Her olive skirt only covers the upper portion of her dusky, spotted thighs, and it flares out deliciously from her swaying hips. Isabella no longer wears her fine silk shirt, not wanting to damage it any further. Her impressive bust sways ever so slightly whenever she moves and her nipples have perked up because of the cool air. She is constantly caressing the heavy load of her rounded belly and occasionally casts a glance your way. Unlike most of the rest of her, her face is not spotted with dark and white patches. Instead it is pure, unbroken chocolate in color. Struck across the woman's face is a look of pure satisfaction and bliss. It seems despite all the hardships she couldn't be happier. Two small, bovine horns sprout from her head, emerging from the tangle of her unruly, red curls. She even has a pair of cow ears that flick back and forth from time to time.");
				break;
			case 9:
				outputText("The cow-girl is about seven and a half feet tall. Instead of feet, she has hooves, complete with fur that grows part-way up her legs. Her olive skirt only covers the upper portion of her dusky, spotted thighs, and it flares out deliciously from her swaying hips. The large woman knees shake slightly when she stands. You find yourself staring at the Bovine's large, exposed bust as it shifts with every breath, her poor exotic nipples slowly leaking out milk in a constant trickle that leaves her melon-like belly glazed and slick, already prepared to feed your offspring. Every once in awhile, you hear a giggle escape the braud as she rubs her large swollen belly. Upon further questioning she simply responds that \"it kicked.\" Unlike most of the rest of her, her face is not spotted with dark and white patches. Instead it is pure, unbroken chocolate in color. Two small, bovine horns sprout from her head, emerging from the tangle of her unruly, red curls. She even has a pair of cow ears that flick back and forth from time to time. Isabella seems to be suffering chronic bouts of pain (mock contractions, perhaps?), but still manages to smile when she sees you look her way. You don't think it'll be long now.");
				break;
		}
	}
	else {
		outputText("The cow-girl is about seven and a half feet tall. Instead of feet, she has hooves, complete with fur that grows part-way up her legs. Her olive skirt only covers the upper portion of her dusky, spotted thighs, and it flares out deliciously from her swaying hips. Isabella's top is sheer, white silk that barely hides anything from you, least of all her exotic, quad-tipped nipples. Unlike most of the rest of her, her face is not spotted with dark and white patches. Instead it is pure, unbroken chocolate in color. Two small, bovine horns sprout from her head, emerging from the tangle of her unruly, red curls. She even has a pair of cow ears that flick back and forth from time to time.");
	}
	doNext(callForFollowerIsabella);
}

private function campIzzySexMenu():void {
	spriteSelect(31);
	var tentacle:Function = null;
	if (izzyTentacleRapeBool() && player.lust >= 33) tentacle = tentacleBoneFollowerIzzy;
	var hotdog:Function = null;
	var bjToggle:Function = null;
	var bjTogText:String = "";
	var getSucked:Function = null;
	if (player.hasCock()) {
		if (flags[kFLAGS.ISABELLA_BLOWJOBS_DISABLED] == 0) {
			bjTogText = "No BJs";
		}
		else {
			bjTogText = "Plz BJs";
		}
		bjToggle = toggleIsabellasMorningWoodChopping;
		if (player.shortestCockLength() <= 9 && player.lust >= 33) getSucked = isabellaScene.izzyGivesSmallWangsFreeOral;
	}
	outputText("\n\n", false);
	outputText("You could get a drink of Isabella's delicious milk, straight from the tap.", false);
	if (tentacle != null) outputText("  Or you could take advantage of your numerous tentacles to show her a truly grand time.", false);
	if (getSucked != null) outputText("  Or you could have her suck you off now, since she seems quite taken with the size of your penis.", false);
	outputText("  There's always the opportunity to climb under her skirt and service her as well.", false);
	if (player.lust < 33) outputText("  <b>You aren't aroused enough to initiate sex.</b>", false);
	if (player.hasCock() && player.lust >= 33) hotdog = repeatGermanBratwurstInCamp;
	var fuckHer:Function = null;
	if (player.cockThatFits(164) >= 0 && player.lust >= 33) fuckHer = fuckIsabella;
	choices(bjTogText, bjToggle, "Drink Milk", isabellaScene.nomOnMommaIzzysTits, "Hotdog", hotdog, "Service Her", isabellaScene.volunteerToSlurpCowCunt, "TentacleSex", tentacle,
		"Get Sucked", getSucked, "Fuck Her", fuckHer, "", null, "", null, "", null);
	addButton(14, "Back", callForFollowerIsabella);
}


//Accent Coaching
private function isabellasAccentCoaching():void {
	spriteSelect(31);
	clearOutput();
	//Cooldown rejection
	if (flags[kFLAGS.ISABELLA_ACCENT_TRAINING_COOLDOWN] > 1) {
		outputText("Isabella shakes her head and says, \"<i>Nein.  I do not vish to spend time on zis now.</b>\"", false);
		//Back to follower menu!
		doNext(callForFollowerIsabella);
		return;
	}	
	/*(req's 100% teach score to replace dialogue.  Success 
	based on inte)*/
	//(FIRST TIME) 
	if (flags[kFLAGS.ISABELLA_ACCENT_TRAINING_PERCENT] == 0) {
		outputText("You tell Isabella you'd like to offer her lessons in order to reduce her accent and make her more understandable.  She folds her arms across her chest and protests, \"<i>You have an accent too, nein?</i>\"\n\n", false);
		outputText("Chuckling, a little, you nod, but note that yours is far closer to the people of this land than her own.  She agrees, albeit reluctantly.\n\n", false);
		flags[kFLAGS.ISABELLA_ACCENT_TRAINING_PERCENT] = 1;
	}
	//Autosuccess at inte >= 60)
	//Autofail at inte < 20)
	//50/50 shot at inte 40ish
	var result:Number = player.inte / 5 + rand(9);
	var accentChange:Number = 0;
	//(Success/Fail texts)
	if (result < 12) {
		temp = rand(3);
		if (temp == 0) outputText("You spend an hour speaking with Isabella, but ultimately, you wind up making little, if any, progress.  The cow-girl seems a bit dispirited at the failure, but she gives you a big hug anyway.", false);
		//(FAIL2) 
		else if (temp == 1) {
			outputText("In spite of your efforts to teach the foreign cow-girl, she doesn't seem to make any progress.  The worst part is, she keeps slumping down when you correct her, which only sets her bosom to jiggling, her cleavage looking larger than ever before.  You wind up quite distracted by the time the two of you get finished.", false);
			dynStats("lus", 10);
		}
		//(FAIL3) 
		else {
			outputText("No matter what you do, you can't get the normally-industrious cow-girl to focus right now.  She's obviously bored with your attempts to teach her, and she spends the entire lesson trying to tease you with her body.  It's more effective than you care to admit", false);
			if (player.hasCock()) outputText(", and you leave the lesson with certain stiffness in your loins.", false);
			else if (player.hasVagina()) outputText(", and you leave the lesson with wet panties.", false);
			else outputText(".", false);
			//(+big lust)
			dynStats("lus", 25);
		}
	}
	else if (result < 14) {
		temp = rand(2);
		if (temp == 0) outputText("You spend an hour going over Isabella's language and diction with her.  She seems to make a little progress with it, which makes her happy, but you feel that in the grand scheme of things, she could do better.", false);
		else outputText("You go over Isabella's word choice with her and try to correct her whenever she uses the wrong word or slips into her native tongue.  She seems to make a modicum of progress, yet the downward cast of her eyes shows just how much better she feels she could have done.", false);
		accentChange = 4 + rand(5);
	}
	else if (result <= 20) {
		temp = rand(2);
		if (temp == 0) outputText("You spend an hour trying to teach Isabella how to speak properly.  While she is often flustered by her mistakes, she makes notable improvements from this session.  By the time you two finish, she seems quite pleased with herself.", false);
		else if (temp == 1) outputText("You go over Isabella's word choice with her and try to correct her whenever she uses the wrong word or slips into her native tongue.  It takes some time, but you're happy to tell Isabella that she seems to be making significant progress.", false);
		accentChange = 8 + rand(8);
	}
	else {
		temp = rand(2);
		if (temp == 0) outputText("You sit down with Isabella to work on her language once again.  She gets quite involved in the lesson, and the cow-girl makes large strides toward lessening her accent.", false);
		else outputText("You go over Isabella's word choice with her in an effort to reduce her accent.  In short order, the cow-girl is looking at you with rapt, attentive eyes, hanging on to your every word as you help her disguise her tongue to match those she's surrounded by.", false);
		accentChange = 12 + rand(10);
	}
	if (flags[kFLAGS.ISABELLA_ACCENT_TRAINING_PERCENT] < 100 && flags[kFLAGS.ISABELLA_ACCENT_TRAINING_PERCENT] + accentChange >= 100) 
		outputText("<b>\n\nIsabella proudly says, \"<i>I think I've learned everything you have to teach, " + player.short + ".</i>\"  You smile at the progress she's made and applaud.  There's little else you can teach for her.</b>", false);
	else if (flags[kFLAGS.ISABELLA_ACCENT_TRAINING_PERCENT] < 90 && flags[kFLAGS.ISABELLA_ACCENT_TRAINING_PERCENT] + accentChange >= 90)
		outputText("<b>  Isabella can often speak without her accent when she tries to, though she doesn't seem to be doing so in everyday conversation yet.  She's so close though!</b>", false);
	else if (flags[kFLAGS.ISABELLA_ACCENT_TRAINING_PERCENT] < 75 && flags[kFLAGS.ISABELLA_ACCENT_TRAINING_PERCENT] + accentChange >= 75) 
		outputText("<b>  Isabella will sometimes manage to say a sentence or two without a single mistake during the lessons.  It's good progress!</b>", false);
	else if (flags[kFLAGS.ISABELLA_ACCENT_TRAINING_PERCENT] < 50 && flags[kFLAGS.ISABELLA_ACCENT_TRAINING_PERCENT] + accentChange >= 50) 
		outputText("<b>  Isabella has gained enough control over her language to speak properly... if she talks about half as fast as normal.</b>", false);
	else if (flags[kFLAGS.ISABELLA_ACCENT_TRAINING_PERCENT] < 25 && flags[kFLAGS.ISABELLA_ACCENT_TRAINING_PERCENT] + accentChange >= 25)
		outputText("<b>  Isabella is getting better during your lessons.  Generally she can pick out most of her mistakes if she pauses to think over what she just said.</b>", false);	
	else if (flags[kFLAGS.ISABELLA_ACCENT_TRAINING_PERCENT] < 10 && flags[kFLAGS.ISABELLA_ACCENT_TRAINING_PERCENT] + accentChange >= 10) 
		outputText("<b>  Isabella has made enough progress that if she thinks about it, she will sometimes catch her mistakes on her own.</b>", false);
		
	//Bump up accent level appropriately.
	flags[kFLAGS.ISABELLA_ACCENT_TRAINING_PERCENT] += accentChange;
	if (flags[kFLAGS.ISABELLA_ACCENT_TRAINING_PERCENT] > 100) flags[kFLAGS.ISABELLA_ACCENT_TRAINING_PERCENT] = 100;
	//4 to 12 hour cooldown
	flags[kFLAGS.ISABELLA_ACCENT_TRAINING_COOLDOWN] = 4 + rand(13);
	doNext(camp.returnToCampUseOneHour);
}

//Reverse Isabella's accent back to her normal accent.
private function isabellaAccentUncoaching():void {
	clearOutput();
	outputText("You tell Isabella that she can go back to her old accent however she likes. Her eyes widen and says, \"<i>Zank you, " + player.short + "!</i>\"\n\n", true)
	outputText("<b>Isabella's accent is now reverted. You'll have to coach her all over again if you ever change your mind.</b>", false)
	flags[kFLAGS.ISABELLA_ACCENT_TRAINING_PERCENT] = 0;
	doNext(callForFollowerIsabella);
}	

//Morning Wakeup Call 
public function isabellaMorningWakeupCall():void {
	spriteSelect(31);
	flags[kFLAGS.ISABELLA_MORNING_FELLATIO_COUNT]++;
	var x:Number = player.shortestCockIndex();
	outputText("\n", false);
	outputText("Sighing happily, your dream takes on a markedly sexual tone, a bevy of delightful sensations wrapping around your loins in your sleep.  Your " + player.hipDescript() + " pump slightly as your body reacts to the hot, pleasant feelings emanating from your now-stiff cock.  The turgid member is like a lightning rod, shuddering every few seconds under an assault of thunderous pleasure-strikes.  You let out a sleepy, contented sigh as your body starts to stir to wakefulness.  The tactile sensations seem so similar to a hot, tight cunt, and yet so achingly different.  Sometimes, a few places are left exposed to the cool morning air, the breeze chilling that portion of your member's skin in sensual contrast with the heat of whatever is squeezing the rest of it.\n\n", false);
	
	outputText("There's a quiet, almost inaudible squishing noise prodding at your muzzy consciousness, like the irritating drip of a leaky faucet; you do the only thing a half-asleep, pleasure-drunk " + player.mf("man","herm") + " can do in a situation like this: blink open your eyes and glance down toward your groin.  There's a tangle of curly crimson hair blocking your view of your crotch, flanked by two down-turned, cute cow-ears.  ", false);
	if (flags[kFLAGS.ISABELLA_MORNING_FELLATIO_COUNT] == 1) outputText("Isabella is fellating you!?", false);
	else outputText("Isabella is giving you one of her traditional good-morning blowjobs.", false);
	outputText("  Her massive, malleable tongue moulds around your " + player.cockDescript(x) + " as she works to enhance your pleasure.  A trickle of warm, creamy milk escapes the heavy jugs resting on your " + player.legs() + ", showing you just how much she enjoys dispensing oral pleasure.  The tangled, crimson mass of hair slowly begins to bob up and down upon your loins, and Isabella's big brown eyes look up at you with radiant happiness, the corners of her mouth curling into a cock-filled smile.\n\n", false);
	
	outputText("You groan out loud at the sight of the sexy cow-girl's mischievous gaze.  She's face-fucking your " + player.cockDescript(x) + " without any difficulty and laying languid, lascivious licks over every part of your maleness simultaneously.  Your cock is utterly, helpless bound up by her thick oral organ.  It twitches inside her mouth-muscle's embrace, helplessly releasing rivulets of pre-cum that disappear into Isabella's throat as fast as you can produce them.  You can see her cheeks hollowing as she begins to pull the tongue-wrapped dick deep into her maw, the suction making your " + player.cockDescript(x) + " grow dangerously sensitive to the cow-girl's whims.\n\n", false);
	
	outputText("\"<i>Oh fuck!</i>\" you groan without meaning to, lifting your " + player.hipDescript() + " to press your ", false);
	if (player.balls > 0) outputText(player.ballsDescriptLight() + " against her chin, the cum-bloated orbs bouncing and shuddering with your " + player.cockDescript(x) + " as release nears.", false);
	else {
		outputText(player.cockDescript(x) + " the whole way into her mouth, the slippery, hot cow-girl's lips sealing tightly around your ", false);
		if (player.hasSheath()) outputText("sheath", false);
		else outputText("base", false);
		outputText(".", false);
	}
	outputText("  Isabella brushes her hair back to watch your reaction; her shining eyes never leave your face as she kicks her efforts into overdrive, pumping and stroking your " + player.cockDescript(x) + " with nothing more than her tongue's moist heat.\n\n", false);
	
	outputText("Isabella hums softly, more a feeling of slight, slow vibration than any proper sound.  Her sensual purr combines with the fevered pumping of her tongue to push you far beyond your limit.  Starting deep inside you, your body submits to her pleasure and releases the warmth of your orgasm.", false);
	if (player.balls > 0) outputText("  Your balls clench tightly as they release your seed", false);
	else outputText("  You clench tightly and release your seed", false);
	outputText(" to the cow-girl's vacuum-tight lips, ejaculating a nice, thick load of spooge to fill her hungry mouth.", false);
	if (player.cockTotal() > 1) {
		outputText("  At the same time, you cum from ", false);
		if (player.cockTotal() > 2) outputText("the rest of your " + player.multiCockDescriptLight(), false);
		else outputText("the one penis she's left untouched", false);
		outputText(", spraying across your belly and " + player.chestDesc() + ".  Isabella, ever attentive, grabs the twitching cock", false);
		if (player.cockTotal() > 2) outputText("s", false);
		outputText(" and pumps to help ease the lusty tension from your body.", false);
	}
	if (player.cumQ() < 250) outputText("  She slurps it all down with a smile, giving you a happy wink as her throat swallows the last of your salty load.", false);
	else if (player.cumQ() < 500) outputText("  She swallows hard, but even with her talents, Isabella can't quite get it all down.  The cum-dribbling red-head gives you a wink as you finish, gathering the spooge with her fingers to swallow down the excess.", false);
	else {
		outputText("  She gurgles from the volume of jizz suddenly forced into her mouth, spunk spurting out from the corners of her stuffed mouth.  The prodigious cum-shot doesn't seem to phase her in the least, as she simply forces herself down harder and relaxes her throat, allowing you to deposit your cum directly into her quickly-rounding belly.", false);
		if (player.cumQ() >= 2000) outputText("  Even that fails when Isabella's body becomes too semen-stuffed to take any more, and the cow-girl pulls you out of her mouth to let you spray the rest on her face.  Her tongue strokes you like a hand throughout the entire thing, encouraging you to make as big of a mess as possible.", false);
		outputText("  Once you finish, she gives you a wink and slurps up some of the cum that escaped.", false);
	}
	outputText("\n\n", false);
	
	outputText("The orally-fixated red-head shudders and quietly moans as she rises, her pleasure evident on her stained fingers as they withdraw from under her rumpled skirt.  Isabella's silky white top is utterly soaked with sweet-smelling cream, an aroma echoed by the ", false);
	if (player.cumQ() >= 2000) outputText("spunk-tainted ", false);
	outputText("milk-puddle around your " + player.legs() + ".  She sighs and says, \"<i>", false);
	if (flags[kFLAGS.ISABELLA_MORNING_FELLATIO_COUNT] == 1) {
		if (isabellaAccent()) outputText("Mmm, your penis has such tasty treats for me.  Keep zat cock small enough for mein mouth and I vill be happy to tend to it every morning, ja?", false);
		else outputText("Mmm, your penis has such tasty treats for me.  Keep that cock small enough for my mouth and I'll be happy to tend to it every morning, okay?", false);
	}
	else if (player.cumQ() >= 500) {
		if (isabellaAccent()) outputText("Yum!  You cum so hard for momma Izabella, don't you?</i>\"  The sated cow-girl gives your " + player.cockDescript(x) + " an affectionate squeeze before murmuring, \"<i>So yummy...", false);
		else outputText("Yum!  You cum so hard for momma Isabella, don't you?</i>\"  The sated cow-girl gives your " + player.cockDescript(x) + " an affectionate squeeze before murmuring, \"<i>So yummy...", false);
	}
	else {
		if (isabellaAccent()) outputText("I hope you did not mind me getting zat snack...", false);
		else outputText("I hope you didn't mind me getting that snack...", false);
	}
	outputText("</i>\"\n\n", false);
	
	outputText("You slump down while the tension oozes from your frame.  By the time you can move again, Isabella has walked off towards her section of camp.  Is it just you, or does her ass have a particularly sensuous sway this morning?", false);
	player.orgasm();
	dynStats("sen", -1.5);
	doNext(playerMenu);
}
//No BJ's Plz 
private function toggleIsabellasMorningWoodChopping():void {
	spriteSelect(31);
	clearOutput();
	if (flags[kFLAGS.ISABELLA_BLOWJOBS_DISABLED] == 0) {
		outputText("You let Isabella know that you'd rather manage your morning wood yourself, and if possible, save up your cum rather than having her drain it every morning.  She looks a little disappointed but agrees to leave you be in the morning.  Before you go, she offers, \"<i>", false);
		if (isabellaAccent()) outputText("Just let Isabella know if you change your mind, ja?</i>\"", false);
		else outputText("Just let me know if you change your mind, all right?</i>\"", false);
		flags[kFLAGS.ISABELLA_BLOWJOBS_DISABLED] = 1;
	}
	else {
		outputText("You ", false);
		if (player.cor < 33) outputText("blush and ", false);
		else if (player.cor >= 66) outputText("smirk and ", false);
		outputText("let Isabella know that if she's still interested, you'd like her to suck you off in the mornings again.  Her face colors, but you see her eight nipple-tips poking hard at her silk shirt as she answers, \"<i>", false);
		if (player.cocks[player.shortestCockIndex()].cockLength > 9) 
		{
			if (isabellaAccent()) outputText("I vill, but only once you shrink zat monster down.  I cannot handle somezing like zat!", false);
			else outputText("I will, but only once you shrink that monster down.  I can't handle something like that!", false);
		}
		else {
			if (isabellaAccent()) outputText("Of course; ve vouldn't vant you to be out zere battling demons unsated.  Who knows vat vould happen?", false);
			else outputText("Of course; we wouldn't want you to be out there battling demons unsated.  Who knows what would happen?", false);
		}
		outputText("</i>\"", false);
		flags[kFLAGS.ISABELLA_BLOWJOBS_DISABLED] = 0;
	}
	//To Izzy SEX menu
	doNext(campIzzySexMenu);
}
//Repeatable Campsex: Hot Dogginz' 
private function repeatGermanBratwurstInCamp():void {
	spriteSelect(31);
	clearOutput();
	var x:Number = player.smallestCockIndex();
	outputText("You ask Isabella if she would mind helping you blow off some pressure before you go back out.  She glances down at " + player.sMultiCockDesc() + " and ", false);
	if (flags[kFLAGS.ISABELLA_TIME_SINCE_LAST_HOTDOGGING] < 5 && flags[kFLAGS.ISABELLA_TIME_SINCE_LAST_HOTDOGGING] > 0) {
		if (isabellaAccent()) outputText("mumbles, \"<i>Already?  Did I not just take care of you?</i>\"  The blushing cow-girl teases, \"<i>Are you really zat horny, or do you just like mein heiny that much?", false);
		else outputText("mumbles, \"<i>Already?  Didn't I just take care of you?</i>\"  The blushing cow-girl teases, \"<i>Are you really that horny, or do you just like my heiny that much?", false);
	}
	else if (player.cockArea(x) > 38) {
		//If too big, use the biggest dick for hotdoggin!
		x = player.biggestCockIndex();
		if (isabellaAccent()) outputText("gasps, \"<i>Oh yes, I see.  It looks so pent up... a shame it is too big to get ze full treatment in mein caboose.  You vill still cum for mein cheeks though, ja?", false);
		else outputText("gasps, \"<i>Oh yes, I see.  It looks so pent up... a shame it's too big for you to get the full treatment in my caboose.  You'll still cum for my cheeks though, right?", false);
	}
	else {
		if (isabellaAccent()) outputText("gleefully muses, \"<i>Oooh, I see.  Of course I vill help you, " + player.short + "!</i>\"  She traces a finger around " + player.oMultiCockDesc() + "' outline and continues, \"<i>It vould be mein pleasure to squeeze it all out into mein caboose.  Zat is what you vant, nein?", false);
		else outputText("gleefully muses, \"<i>Oooh, I see.  Of course I'll help you, " + player.short + "!</i>\"  She traces a finger around " + player.oMultiCockDesc() + "' outline and continues, \"<i>It would be my pleasure to squeeze it all out into my caboose.  That is what you want, no?", false);
	}
	outputText("</i>\"\n\n", false);
	
	if (player.cor < 33) outputText("Coloring red, you sheepishly answer in the affirmative.", false);
	else if (player.cor < 66) outputText("Not seeing a reason to hide it, you admit as much.", false);
	else outputText("With a knowing twinkle in your eye, you agree with the busty woman's intuition, rocking your hips enticingly.  Her eyes glue to your manhood for a moment, before she remembers herself and meets your gaze.", false);
	outputText("  Isabella folds her arms across her belly, putting just enough pressure on the sides of her mountainous melons to make them jiggle and swell up inside her top.  The cleavage seems on the verge of busting from her top by the time she laughs, \"<i>Eyes up here, big " + player.mf("boy","girl") + ".</i>\"  Like a kid caught with his hand in the cookie jar, you ", false);
	if (player.cor < 33) outputText("feel the weight of shame settling over you", false);
	else if (player.cor < 66) outputText("feel mildly ashamed", false);
	else outputText("color at getting caught staring", false);
	outputText(", but Isabella doesn't dwell on it.  She pivots her lush hips around to present her backside, lifts her skirt to reveal her bare bottom, and begins to flex her muscles, causing the creamy dark flesh to shake and jiggle.\n\n", false);
	
	outputText("\"<i>Are you going to stare, or undress for me?</i>\" the cow-girl asks, never slowing down with her skilled, teasing jiggles.  You undress, but so long as she sways like that, your eyes stay firmly locked on delicious, swollen rump.  Your " + player.armorName + " falls in a pile behind you, finally releasing " + player.sMultiCockDesc() + " to taste the air.  The sumptuous, sweat-slicked cheeks wobble against each other in a way that promises a heaven of sensation for anyone lucky enough to slip into their capacious crack-cleavage.  You can't help but feel elated when you realize she's going to let you feel that.\n\n", false);

	if (isabellaAccent()) outputText("Isabella crooks a finger at you and commands, \"<i>Come, sit down, but lean back so Isabella has plenty of room to vork at milking zis naughty ", false);
	else outputText("Isabella crooks a finger at you and commands, \"<i>Come, sit down, but lean back so I have plenty of room to work at milking this naughty ", false);
	if (player.cockArea(x) <= 38) outputText("little ", false);
	outputText("snake...</i>\"\n\n", false);
	
	outputText("Approaching slowly, you drink in your cow-girl companion's curvy body, devouring every detail of her body.  From her curvy thighs and bubblelicious ass to her pale, creamy spots, her body seems sculpted to titillate any eyes lucky enough to drink in her fertile frame.  Isabella swivels her shaking derriere around, slapping her bronzed ass against you.  The surprising impact pushes you down into the camp chair she previously indicated, teasing you from the brief skin-to-crotch contact as she takes complete charge of the situation.  " + player.SMultiCockDesc() + " stands out from your loins, pulsing hard, just aching for another touch of Isabella's bottom.\n\n", false);
	
	outputText("The confident woman continues her gyrations, knowing all too well the effect she's having on you.  \"<i>No, not yet,</i>\" she commands as her sweat-dripping butt sways dangerously close to " + player.oMultiCockDesc() + ".  Isabella raises her marvelous backside higher, bringing it up in front of your face.  She wiggles slowly before spreading her legs wide, allowing you to see her glistening vagina and tightly-clenched pucker peaking past her dusky cheeks.  ", false);
	if (isabellaAccent()) outputText("\"<i>So wet,</i>\" ", false);
	else outputText("\"<i>So vet,</i>\" ", false);
	outputText("she moans before resuming her shaking, ", false);
	if (isabellaAccent()) outputText("\"<i>So hot... Am I making you hot, " + player.short + "?  Is your cock twitching for me yet?  Aching and leaking and dribbling a mess all over itself, ja?</i>\"\n\n", false);
	else outputText("\"<i>So hot... Am I making you hot, " + player.short + "?  Is your cock twitching for me yet?  Aching and leaking and dribbling a mess all over itself?</i>\"\n\n", false);
	
	outputText("You nod, catching a whiff of her musky pussy's aroma without meaning to.  It's not like you could avoid it, with her body mere inches in front of your " + player.face() + ", shaking so perfectly and so closely that an occasional droplet catches on your nose.  Your hands clamp around the chair with an iron grip as you fight not to rise and rape her tender, teasing asshole on the spot.  " + player.SMultiCockDesc() + " is trickling and dribbling, bouncing with your heartbeats as your " + player.legs() + " shiver and shake with denied lusts.  You NEED to do something... to fuck, thrust, or just fap... anything - your " + player.multiCockDescriptLight() + " can't take it anymore!\n\n", false);
	
	outputText("Drawn up by your dick, you let go of your grip on the cow-crafted chair and start to rise into Isabella.  She expertly drops her bouncy butt into your " + player.chestDesc() + ".  It knocks you back down into place while she scolds, ", false);
	if (isabellaAccent()) outputText("\"<i>I said not yet.  Do you vant me to help you cum or not?</i>\"", false);
	else outputText("\"<i>I said not yet.  Do you want me to help you cum or not?</i>\"", false);
	outputText("  You nod to her, feeling a little more in control after having your urges interrupted by the object of your desire.  Isabella looks back at you with lidded eyes and whispers, ", false);
	if (isabellaAccent()) outputText("\"<i>Good " + player.mf("boy","girl") + ".  Relax, Momma Isabella vill take care of you.</i>\"\n\n", false);
	else outputText("\"<i>Good " + player.mf("boy","girl") + ".  Relax, Momma Isabella will take care of you.</i>\"\n\n", false);
	
	outputText("The curvaceous cow-girl's stance shifts slightly, her teasing, shaking dance coming to a stop for just a moment as she adjusts to rest her rump against your " + player.cockDescript(x) + ".  ", false);
	if (player.cockTotal() == 2) outputText("The other penis is shoved to the side, forgotten about as Isabella selects the lucky fuck-stick.  ", false);
	else if (player.cockTotal() > 2) outputText("The other penises are shoved aside, forgotten about as Isabella selects the lucky fuck-stick.  ", false);
	outputText("She arches her body and slides up and down your " + player.cockDescript(x) + ", gradually increasing the weight she's pressing on it with every stroke.  Your dripping member slips into Isabella's tightly-compressed ass-cleavage with a wet-sounding *POP*.  Her derriere is so hot... so sweat-slicked... so... so... perfectly tight.  You aren't even fucking her yet", false);
	if (player.cockArea(x) <= 38) outputText(", though with your dick completely devoured by her big butt-cheeks, you may as well be.", false);
	else outputText(", as the mast rising from the top of her crack indicates.", false);
	outputText("  Yet, you know without a doubt that there would be no shame in cumming right now and turning the red-head's tight ass-crack into a cum-filled canyon.\n\n", false);
	
	//(Small enough for buttfukkins)
	if (player.cockArea(x) <= 38) {
		if (isabellaAccent()) outputText("\"<i>Oh my, does mein behind feel so good zat your cute, delectable cock vill squirt all over me before you even get to feel ze best part?</i>\" teases Isabella as she flexes one side and then the other, forcing your " + player.cockDescript(x) + " to bend in response to the two dueling masses of her booty cheeks.  She keeps teasing you as she caresses your member with her hefty butt.  \"<i>You have such a naughty look on your face, drooling on yourself from just a little bit of play with Momma Isabella.  No, don't stop, I want to watch the ecstasy spread through you while I work your nice, hot cock.  My asshole wants to kiss it... Can I kiss your dick with my asshole?</i>\"", false);
		else outputText("\"<i>Oh my, does my ass-job feel so good that your cute, delectable cock is gonna squirt all over me before you even get to feel the best part?</i>\" teases Isabella as she flexes one side and then the other, forcing your " + player.cockDescript(x) + " to bend in response to the two dueling masses of her booty cheeks.  She keeps teasing you as she caresses your member with her hefty butt.  \"<i>You have such a naughty look on your face, drooling on yourself from just a little bit of play with Momma Isabella.  No, don't stop, I want to watch the ecstasy spread through you while I work your nice, hot cock.  My asshole wants to kiss it... Can I kiss your dick with my asshole?</i>\"", false);
		//(if libido <=15:  
		if (silly() && (player.lust < 50 || player.lib <= 20)) {
			outputText("  Your cock immediately deflates from her laughable doujin-tier pillow talk and falls out of her buttcheeks.  You'll be posting that line to 4chan later for laughs.", false);
			dynStats("lus", -99);
			doNext(camp.returnToCampUseOneHour);
			return;
		}
		outputText("  She doesn't even let you answer.  Her back-and-forth flexing abruptly halts as she switches to an up and down motion, hotdogging your " + player.cockDescript(x) + " in the tight vice of her spotted backside.\n\n", false);
		
		outputText("You grab hold of the chair again with both hands, struggling not to cum while Isabella's ass slides over your member.  It's so hot, wet, and sensual that you're trembling from the effort of holding still, but you manage, knowing the longer you hold back, the better the finish will be.  She slowly pumps your " + player.cockDescript(x) + " in her anal valley while you whine and moan, your face taking on a more lurid, sexual expression with every passing moment.  When at last you feel you can hold back no longer, you groan, \"<i>G-gonna... gonna-cum-soon!</i>\"\n\n", false);
		
		if (isabellaAccent()) outputText("Isabella roughly lifts up and tuts, \"<i>No, zat vill not do.</i>\"  ", false);
		else outputText("Isabella roughly lifts up and tuts, \"<i>No, that will not do.</i>\"  ", false);
		outputText("You whine, trembling beneath her as she denies you penetration.  Then, she changes her angle and presses down.  Her pillowy cheeks slide around your cock, hugging it tightly as the cow-girl's wrinkled pucker comes to rest atop your " + player.cockHead(x) + ".  You both gasp at the sudden, electric sensation, immobilized by the new feeling for only the briefest of moments.  Then, Isabella is pressing down, her anus dilating to allow your lust-swollen shaft entrance to her back-door.  Her asshole is even tighter than her butt's cleavage was moments before, and as the cinching, puckered ring works its way towards your base, you know you won't be able to cum until it loosens a little.\n\n", false);
	
		outputText("The owner of the perfectly-tight pucker asks, \"<i>Do I have to worry about you cumming yet?  No?  I didn't think so.</i>\"  She wiggles her rump against your groin, grinding those sweat-soaked buns on your hips and belly for a moment hard enough to rock the chair.  Your " + player.cockDescript(x) + " tries to dribble, tries to leak, but it's clutched so tightly that not even the smallest trickle of release can escape.  Slowly at first, the bovine beauty begins sliding up, dragging that ring around you with agonizing slowness and allowing the bottom-most portions to feel the sensual caress of her cheeks once again.  Then, once she's just below the tip, she plunges down, faster this time, and you feel almost like your cock is being crushed from stem to stern.\n\n", false);
		
		if (isabellaAccent()) outputText("Knowing there's nothing to do now but wait for her sphincter to loosen, you slump back and watch Isabella's corset-bound midriff bounce atop you, her jugs so huge that you can see plenty of side-boob quaking from every shift in momentum.  Each time her bottom smacks into you, ripples of vibration jiggle through the fat of her rump, a sight that only makes your " + player.cockDescript(x) + " grow harder inside her.  Isabella, now bouncing much faster, looks back and says, \"<i>Such a yummy, perfect little cock you have for me, ja.  So nice to squeeze as it fills me.  You keep getting harder too, don't you?  Is your dick going to pop inside me?  Vill it burst and spurt out all zat messy seed so zat ze champion can think straight again?  Or is zis veak little cock going to be unable to cum and let me ride it all day?</i>\"\n\n", false);
		else outputText("Knowing there's nothing to do now but wait for her sphincter to loosen, you slump back and watch Isabella's corset-bound midriff bounce atop you, her jugs so huge that you can see plenty of side-boob quaking from every shift in momentum.  Each time her bottom smacks into you, ripples of vibration jiggle through the fat of her rump, a sight that only makes your " + player.cockDescript(x) + " grow harder inside her.  Isabella, now bouncing much faster, looks back and says, \"<i>Such a yummy, perfect little cock you have for me.  So nice to squeeze as it fills me.  You keep getting harder too, don't you?  Is your dick going to pop inside me?  Will it burst and spurt out all that messy seed so that the champion can think straight again?  Or is this weak little cock going to be unable to cum and let me ride it all day?</i>\"\n\n", false);
		
		if (isabellaAccent()) outputText("In spite of her teases, the continued stretching friction of the fuck is making her tight ring relax around you.  Every bump, bounce, and squeeze seems to bring you closer than before, your backed-up fluids threatening to squirt out at any moment.  You know it's coming soon, but you can't tell when.  Isabella doesn't seem to mind your discomfort, as she is bouncing hard and fast, tugging on her nipples to squeeze thick streams of milk from them as she moans.  Her whole body tenses and shakes, and as her milk turns to cream, you realize she's cumming, just from riding your cock!  Her orgasm drags on and on, turning the rug below you into a milk-sodden mess.  Yet, once she finishes, her anal sphincter goes lax, letting your " + player.cockDescript(x) + " finally spend its seed.  Isabella groans and asks, \"<i>Oooh, did you just cum in mein butt?  You are still cumming, no?</i>\"  She starts bouncing up and down slowly, milking your dick while it orgasmically contracts, spraying thick strands of pent-up seed deep into Isabella's darkest recesses.  The curvy cow-girl keeps talking dirty, saying, \"<i>Yes, give it to me.  Give me all that nasty cum you have pent up.  Let my ass slurp up your cum so you do not vaste it.  Such a messy, naughty " + player.mf("boy","girl") + ".</i>\"\n\n", false);
		else outputText("In spite of her teases, the continued stretching friction of the fuck is making her tight ring relax around you.  Every bump, bounce, and squeeze seems to bring you closer than before, your backed-up fluids threatening to squirt out at any moment.  You know it's coming soon, but you can't tell when.  Isabella doesn't seem to mind your discomfort, as she is bouncing hard and fast, tugging on her nipples to squeeze thick streams of milk from them as she moans.  Her whole body tenses and shakes, and as her milk turns to cream, you realize she's cumming, just from riding your cock!  Her orgasm drags on and on, turning the rug below you into a milk-sodden mess.  Yet, once she finishes, her anal sphincter goes lax, letting your " + player.cockDescript(x) + " finally spend its seed.  Isabella groans and asks, \"<i>Oooh, did you just cum in my butt?  You're still cumming aren't you?</i>\"  She starts bouncing up and down slowly, milking your dick while it orgasmically contracts, spraying thick strands of pent-up seed deep into Isabella's darkest recesses.  The curvy cow-girl keeps talking dirty, saying, \"<i>Yes, give it to me.  Give me all that nasty cum you've got pent up.  Let my ass slurp up your cum so you don't waste it somewhere.  Such a messy, naughty " + player.mf("boy","girl") + ".</i>\"\n\n", false);
		
		outputText("Isabella's words motivate you to spend every ounce, every stored-up drop of seed into her hungry back-door.  ", false);
		if (player.cumQ() >= 1000) {
			outputText("Her pleased expression shifts slightly as her belly bloats from the fluid injection", false);
			if (player.cumQ() >= 2000) outputText(", eventually growing to a pregnant-looking curve", false);
			outputText(".  She whimpers slightly and murmurs, \"<i>Such a fertile " + player.mf("boy","girl") + "... Momma Izzy can take it.</i>\"  ", false);
		}
		outputText("Your " + player.cockDescript(x) + " writhes in bliss for what seems like forever, but before you know it, you're coming back down to Earth.  Isabella whispers, \"<i>Good " + player.mf("boy","girl") + ",</i>\" to you and stands up, ignoring the cum that drips from her dark pucker to stain " + player.sMultiCockDesc() + ".  She helps you up, and her hand tussles your hair affectionately.  Then she turns towards her side of camp, walking a little bow-legged as she leaves.", false);
	}
	//(Big dicks) 
	else {
		if (isabellaAccent()) outputText("\"<i>Oh my, does mein ass feel zat good on ze huge, pervy thing you call a dick?</i>\" teases Isabella as she flexes one side then the other, forcing your " + player.cockDescript(x) + " to bend in response to the two dueling masses of her booty cheeks.  She keeps talking, \"<i>You have such a naughty look on your face, drooling all over yourself like a dog.  Is that what having a big dick does to you?  Does it make you so horny and weak-willed that you'll waste your cum all over my ass?</i>\"  Isabella stops her back-and-forth flexing in order to begin bouncing up and down.  Her soft, flexing buns caress your " + player.cockDescript(x) + " from base ", false);
		else outputText("\"<i>Oh my, does my ass-job feel that good on that huge, pervy thing you call a dick?</i>\" teases Isabella as she flexes one side then the other, forcing your " + player.cockDescript(x) + " to bend in response to the two dueling masses of her booty cheeks.  She keeps talking, \"<i>You have such a naughty look on your face, drooling all over yourself like a dog.  Is that what having a big dick does to you?  Does it make you so horny and weak-willed that you'll waste your cum all over my ass?</i>\"  Isabella stops her back-and-forth flexing in order to begin bouncing up and down.  Her soft, flexing buns caress your " + player.cockDescript(x) + " from base ", false);
		if (player.cocks[x].cockLength > 48) outputText("to as high as she can reach on the towering shaft's length", false);
		else outputText("to " + player.cockHead(x), false);
		outputText(" as she does so, drawing an anguished moan from your shivering, lust-overloaded body.\n\n", false);
	
		outputText("You grab back onto the chair as pleasure sweeps through your well-endowed body, whimpering, \"<i>G-gonna... gonna... gonna-cum-soon...</i>\"\n\n", false);
		
		outputText("Isabella reaches between her legs to ", false);
		if (player.balls > 0) outputText("squeeze your balls", false);
		else if (player.hasVagina()) outputText("rub your soaked vulva and " + player.clitDescript(), false);
		else outputText("caress your taint", false);
		if (isabellaAccent()) outputText(".  She teases you with a slight undercurrent of disdain in her melodious voice, \"<i>Cumming already?  Very vell, go on zen.  Let your disgusting, obscene cock control you.  I can feel it trickling and dribbling on mein bum.  Do vat your fat, over-sized dick commands and cum all over Momma Isabella's butt.  Big, thick pricks always seem to cum vay too fast.</i>\"\n\n", false);
		else outputText(".  She teases you with a slight undercurrent of disdain in her melodious voice, \"<i>Cumming already?  Very well, go on then.  Let your disgusting, obscene cock control you.  I can feel it trickling and dribbling on my bum.  Do what your fat, over-sized dick commands and cum all over Momma Isabella's butt.  Big, thick pricks always seem to cum way too fast.</i>\"\n\n", false);
		
		outputText("You shudder, trying to hold still and prolong the pleasure, but " + player.sMultiCockDesc() + " is jerking up and down, defiantly grinding itself through the hot, slippery valley of Isabella's ass.  The " + player.cockHead(x) + " bounces above like a flag-pole in a hurricane, and then you can bear it no longer.  You're cumming... cumming so very hard.  Your whole body locks tight, back arching slightly from the strain.  Isabella slides down to the bottom of your convulsing pole and resumes rolling your " + player.cockDescript(x) + " between her bronzed ass-cheeks, causing your eruptions of seed to form lazy 'S' shapes in the air before splattering down on her heaving bottom.", false);
		if (player.cumQ() <= 200) outputText("  Her ass gets a nice glaze from your over-sized cock, though the cow-girl stands up just before you finish, letting the last spurt weakly drip on your belly.", false);
		else if (player.cumQ() <= 500) outputText("  Her ass is completely glazed by your over-sized cock's heavy cum-flow in short order, though she stands up off of you to let you spurt the last few drizzles on your own belly.", false);
		else {
			outputText("  Her ass, back, hair, and your own crotch are soon flooded with the complete deluge of spunk that shoots from you.  The cow-girl doesn't seem to mind indulging you, but as the stuff is running down her thick thighs, she stands up, letting you baste your belly with the last of your cream.", false);
		}
		outputText("\n\n", false);
		
		outputText("Isabella moans and rubs her hands around the curve of her ass, smearing the jism all over her chocolatey skin.  She even takes a handful of excess and smears it over her dripping cunny, shuddering with her own muted climax as she walks away, slightly bow-legged from pleasure.", false);
	}
	flags[kFLAGS.ISABELLA_TIME_SINCE_LAST_HOTDOGGING] = 1;
	flags[kFLAGS.ISABELLA_TIMES_HOTDOGGED]++;
	player.orgasm();
	dynStats("lib", -1);
	doNext(camp.returnToCampUseOneHour);
}

private function izzyTentacleRapeBool():Boolean {
	spriteSelect(31);
	var counter:Number = 0;
	temp = player.cockTotal();
	while(counter < player.countCocksOfType(CockTypesEnum.TENTACLE) && temp > 0) {
		temp--;
		//Does this dick work for it?
		if (player.cocks[temp].cockType == CockTypesEnum.TENTACLE && player.cocks[temp].cockLength >= 24) {
			counter++;
		}
	}
	if (counter >= 3) return true;
	else return false;
}

//Tentacle Rape (edited, but see notes -Z)
//needs 3 cocks: 2 to tie her and lift her up and at least 
//one for penetration
private function tentacleBoneFollowerIzzy():void {
	spriteSelect(31);
	//Tentacle dick index holders
	var t1:int = -1;
	var t2:int = -1;
	var t3:int = -1;
	var t4:int = -1;
	var t5:int = -1;
	var t6:int = -1;
	var t7:int = -1;
	var t8:int = -1;
	var t9:int = -1;
	var t10:int = -1;
	
	var counter:Number = 0;
	temp = player.cocks.length;
	while(counter < player.countCocksOfType(CockTypesEnum.TENTACLE) && temp > 0) {
		temp--;
		//Does this dick work for it?
		if (player.cocks[temp].cockType == CockTypesEnum.TENTACLE && player.cocks[temp].cockLength >= 24) {
			counter++;
			//Set the tentacle array up
			if (t1 == -1) t1 = temp;
			else if (t2 == -1) t2 = temp;
			else if (t3 == -1) t3 = temp;
			else if (t4 == -1) t4 = temp;
			else if (t5 == -1) t5 = temp;
			else if (t6 == -1) t6 = temp;
			else if (t7 == -1) t7 = temp;
			else if (t8 == -1) t8 = temp;
			else if (t9 == -1) t9 = temp;
			else if (t10 == -1) t10 = temp;
		}
	}
	clearOutput();
	//(as written it also requires them in slots 0 through 2, 
	//and logically they would need to be a minimum of 15-20 
	//inches; also needs a mention in the beginning of just //
	//where and when she herself undresses -Z)

	outputText("You grin at Isabella as you nonchalantly remove your " + player.armorName + ", exposing your monstrous tentacle-cocks, fully erect, to her frightened face.  Crossing your arms, you stand before her, dicks squirming all over.  \"<i>", false);
	if (isabellaAccent()) outputText("Oh, mein Gott!  Zey... zey are... so hug- vait, vat, vat are you doing?", false);
	else outputText("My God!  They... they are... so hug- wait, what are you doing?", false);
	outputText("</i>\"\n\n", false);

	if (isabellaAccent()) outputText("Without a word, you adroitly guide your squirming bunch of tentacle peckers toward her body, slowly encircling her. In no time your " + player.cockDescript(t1) + " is already wrapping her supple waist, quickly followed by your " + player.cockDescript(t2) + "; using the combined strength of your inhumanly powerful pair of dick muscles, you lift her off the ground.  \"<i>Oh... you're a kinky boy, aren't you? Well, if that's what you want...</i>\"", false);
	else outputText("Without a word, you adroitly guide your squirming bunch of tentacle peckers toward her body, slowly encircling her. In no time your " + player.cockDescript(t1) + " is already wrapping her supple waist, quickly followed by your " + player.cockDescript(t2) + "; using the combined strength of your inhumanly powerful pair of dick muscles, you lift her off the ground.  \"<i>Oh... you are a kinky boy, ja?  Vell, if zat is vhat you vant...</i>\"", false);
	outputText("  Struggling at first, she eventually succumbs to the manipulating and caressing tips of " + player.oMultiCockDesc() + "; already quite aroused by the contact of her wriggling body, your peckers start dribbling pre-cum. You copiously smear her body with your own juices, painting her belly and her breast with translucent goo. The rubbery friction of your penile floras running all over her naked skin is teasing her, and you can feel her shiver and tremble as you ruthlessly grope her with your flexible genitalia.\n\n", false);
	
	//[if wings]
	if (player.canFly() && player.str >= 90) {
		outputText("\"<i>Time for a wild ride, sweetheart.</i>\"  You flap your " + player.wingDesc + " wings, mobilizing all your muscles in order to lift yourself off.  The weight you are burdened with is absurdly heavy, and you groan and pant in your attempts at taking off; eventually, you manage to part from the possessive surface little by little, grunting in triumph as you see your redoubled effort paying off; soon you're way up in the sky and Isabella's dickflesh prison is wobbling back and forth as you drag her under you. If it weren't for your colossal tentacle strength, the poor cow-girl would probably crash to the earth in a matter of seconds.  You keep ascending until Isabella realizes how high you both are and shrieks.  \"<i>", false);
		if (isabellaAccent()) outputText("But... but vait!  I'm going to fall- I'm going to...</i>\"\n\n", false);
		else outputText("But... but wait!  I'm going to fall- I'm going to...</i>\"\n\n", false);
		
		outputText("You firmly assure that you're holding her all right, that you're never going to let her down and she should be ashamed to doubt your steadfast tentacle peckers.  You fly left and right, doing aimless zigzags and alternatively swooping down and rising up as you gain more and more momentum; this cocktail of insane speed, near-danger, and sexual teasing is sending shudders down your spine.  You laugh in exhilaration, flying everywhere and marvelling at the sight of Mareth lying below while you savagely grope your partner.\n\n", false);
	}
	
	outputText("After toying with her for a while, you decide to bring your other tentacle dicks into the game; with expert precision, you move your " + player.cockDescript(t3) + " to her face.  Moaning under your gentle ministrations, she doesn't even notice the protruding mammoth about to lodge inside her drooling mouth. With a ferocious thrust you slam it all the way between her pulpy lips. Her sighs of pleasure are abruptly muffled as you block her windpipe with vegetal dickflesh. You start ramming your meat up and down her throat, its raw musk making her dizzy.  She tries to accommodate the monster stretching her mouth by moving her tongue around your erect " + player.cockDescript(t3) + ", squeezing it there and there, fondling your veins and milking your urethra of your pre-cum. You groan from the tongue-teasing and start filling her stomach with oozing fluid; the intimate contact makes her squirm a little more under the almost unbearable arousal. She's doing an expert job with her mouth, and her throat feels so good, so tender...  You try to stuff more of your " + player.cockDescript(t3) + " inside her, always wanting more pleasure; the additional pressure almost sends her over the edge as she eagerly gobbles your vegetal rod.\n\n", false);
	
	//[if demon tongue]
	if (player.tongueType == TONGUE_DEMONIC || player.tongueType == TONGUE_SNAKE || player.tongueType == TONGUE_DRACONIC) {
		outputText("Using your long, extensible tongue, you decide to take a lick at her body.  Your tongue darts forward and gently locates her supple tits; you bring Isabelle closer with your vigorous tentacle dicks and start suckling at her breasts, drinking drops of her tasty milk one at a time.  Your constant stimulations arouse her more and more, and soon her nipples are releasing a regular trickle of her essence. You mercilessly drink her, probing your tongue around either of her udders as if to dig deeper to the source of this wonderful ambrosia. You keep gulping milk until you reach satiation, and then you drink some more. It's sweet, savory and invigorating; you could feed off her breasts for days.  You suckle her until her body shakes from the steady tactile provocation, before darting your tongue back.\n\n", false);
		//end d-tongue inset
	}

	//[if 4th tentacle dick] - BUTT
	if (t4 >= 0) outputText("You remember another of your pricks not being put to use, and the sexy girl in your tentacle-embrace still has holes left to fill. You quickly proceed to maneuver your " + player.cockDescript(t4) + " toward her little pucker; the tentacle moves around her and starts poking around, trying to find the entrance of her backdoor. You miss several times, every dick-stab making her shudder in tension. You enthusiastically press her bountiful buttocks with the tip of your " + player.cockDescript(t4) + ", enjoying the soft texture; finally, you grow bored of playing with her ass and ram your tentacle pecker into her anus, stretching it beyond its normal capacity.  Fortunately, the flexibility of your vegetal dong allows it to fit in entirely as it compresses itself and pushes its way through her colon.  You quickly fill her interior with your junk and start thrusting back and forth as you feel a rough but wonderful friction against her insides.  Isabella's eyes widen under the sheer violation and you can feel her moan silently, unable to fully express her powerful sentiment with her mouth filled by cock.  She then abandons herself to you, letting you play with her body as you solemnly stare at her eyes, arms crossed and tentacles deployed.\n\n", false);
	//[if 5th tentacle cock] - VAG
	if (t5 >= 0) outputText("But you still have junk left, and another one of her holes isn't being taken care of. You quickly move to remedy that; in a matter of seconds another " + player.cockDescript(t5) + " is already pointing at her exquisite pussy.  You prick it for a while in a teasing manner; she has already lost control of her own body, with two of her holes being thoroughly penetrated, and she can't help but thrash wildly as you start plowing her.  Your " + player.cockDescript(t5) + " seems almost unable to fit as her vagina muscles keep squeezing it and massaging it while you try to force it in... gods, she is so tight!  The steely grip of her cunt almost  makes you cum instantly, but you regain your composure with difficulty and force yourself to endure the wave of pleasure threatening to take over your crotch.  Her beautiful body deserves more than a mere cum-injection at first penetration; she obviously needs to be thoroughly fucked and rammed in order to satisfy the both of you.  Once you've managed to fit the maximum amount of your vegetal shaft in her love-tunnel, you adopt a more comfortable thrusting pace and alternately fuck each of her holes, making sure that she has at least one tower of dickflesh deep inside her at every instant.  You are both considerably aroused and appreciable ropes of pre-cum, as well as drool and girlcum, are being spilled out of her every hole; soon your camp is resonating with loud squelching noises from the triple penetration.\n\n", false);
	//[if 6th cock] - DOUBLE VAG STUFF
	if (t6 >= 0) outputText("But wait, that's not enough.  Another of your tentacle peckers is being left behind, unsatisfied.  With a coy smile, you agitate it in front of Isabella's eyes as she tries to get used to being triple-penetrated in the air.  Her eyes, first filled with longing, are becoming worried as she wonders what could possibly be done with your " + player.cockDescript(t6) + ".  A sudden stretch down there makes her realize that you're going to fill her with some more junk; pressing your " + player.cockDescript(t5) + " against one side of her nether-lips, you forcefully bring your " + player.cockDescript(t6) + " to her already stuffed vaginal entrance, trying to fit one more rod.  After a few unsuccessful attempts that make her clench and tense repeatedly, you finally manage to get a few inches inside; you then easily slide in the rest of your vegetal meat, effectively double-penetrating her cunt. Your " + player.cockDescript(t6) + " soon matches your " + player.cockDescript(t5) + " in speed and intensity, your pair of dicks literally competing with each other in a ruthless cunt-ravaging contest.\n\n", false);
	//[if 7th cock] - TITS
	if (t7 >= 0) {
		outputText("Abundantly entranced by the sight of her nude body being violated, you want to abuse it even more. Her enormous, jiggling tits are too tempting for you to resist; before you even think of it your " + player.cockDescript(t7) + " is already slithering against her naked flesh, sneaking along her naked belly as it finds a way between her watermelon-like globes. They start leaking their own delicious milk, her fluids joining your own as her body is being painted white. With ease and expert precision you slide your rod between her boobs, making them bounce and spin as you effortlessy titfuck her. Her breasts are so soft... your " + player.cockDescript(t7) + ", almost moving of its own will, decides to encircle her enticing orbs of flesh, grinding against her hard nipples and leaking sap-like pre-cum all over her chest.", false);
		//[if 8th cock] - TITS 2
		if (t8 >= 0) outputText("  It is soon joined by your " + player.cockDescript(t8) + ", each prick taking care of a nipple, teasing the holes with shallow penetrations by her hard nubs, the pre-cum battling against the flow of milk in the opposite direction and stretching your urethra with a sensation that makes you shiver wildly.", false);
		outputText("  You keep man-, or dick-, handling her tits while the rest of your peckers viciously pound her; your ", false);
		if (t8 >= 0) outputText("pair of boob-fondling pricks almost tremble in rage, unable to find any hole left to fill. This only makes them tit-fuck her harder and faster.", false);
		else outputText("boob-fondling prick almost trembles in rage, unable to find any hole left to fill. This only makes it tit-fuck her harder and faster.", false);
		outputText("\n\n", false);
	}
	//[if 9th or 10th cock]
	if (t9 >= 0) {
		outputText("Sadly, there is only so much space that can fit your voluminous junk.  Your companion doesn't have the gaping, slutty holes of a succubus and there's no way you could fit more dick inside her anywhere. Your remaining pecker", false);
		if (t10 >= 0) outputText("s are left with nothing to stuff, writhing in frustration.  You think it would be fair to put them to use: you wrap one around her wrists, binding her hands and immobilizing her to ease the penetration of the others, then run the tip across the unused parts of her body, and simply enjoy the caress of her delicate skin against your " + player.cockDescript(t9) + ", feeling her shiver under your fluid tentacle motion.  Your remaining " + player.cockDescript(t10) + " wraps around her face, squeezing her cheeks and pointing its tip toward her eyes, in order to make sure her every sense is saturated with cock.", false);
		else outputText(" is left with nothing to stuff, writhing in frustration.  You think it would be fair to put it to use: you wrap it around her wrists, binding her hands and immobilizing her to ease the penetration of the others, then run the tip across the unused parts of her body, and simply enjoy the caress of her delicate skin against your " + player.cockDescript(t9) + ", feeling her shiver under your fluid tentacle motion.", false);
		outputText("\n\n", false);
	}
	
	outputText("This thorough tentacle fuck has made you tired and ridiculously aroused.  Your ", false);
	if (player.canFly() && player.str >= 90) outputText("wings and your ", false);
	outputText(player.multiCockDescriptLight() + " did all the work; your groin feels sore from the sheer effort deployed in order to engage in a maximally effective penetration.  As you keep pumping, grinding and teasing her with your wriggling rods, you feel a pressure growing in your crotch and all the way up your urethras; you accelerate the thrusting pace even as ", false);
	if (player.canFly() && player.str >= 90) outputText("you descend, setting your " + player.feet() + " on the soil again but still holding Isabella herself in the air; ", false);
	outputText("you feel your climax coming closer and closer.  Isabella's body is literally swooning in pleasure and her face displays all signs of an intense incoming climax.  The sight of your lover's bliss is enough to launch you over the edge; with an amazingly inhuman might, you cum. The spunk boils furiously as it spurts out of " + player.sMultiCockDesc() + ". You give in to your powerful orgasm as you coat her with white goo, filling her throat", false);
	if (t4 >= 0) {
		outputText(", ", false);
		if (t5 < 0) outputText("and ", false);
		outputText("her colon", false);
	}
	if (t5 >= 0) {
		outputText(", ", false);
		if (t7 < 0 || t10 < 0) outputText("and ", false);
		outputText("her pussy", false);
		if (player.cumQ() >= 1500) outputText(" until she looks 8 months pregnant", false);
	}
	if (t7 >= 0) outputText("; drowning her nipples with your spunk", false);
	//[if 10th cock]
	if (t10 >= 0) outputText(", and cuming on her face as you stare at her", false);
	outputText(".  Her luscious eyes are ", false);
	if (t10 < 0) outputText("eventually", false);
	else outputText("immediately", false);
	outputText(" masked in fluid as you unload your baby-batter on her.  There isn't a single spot of flesh that isn't being smeared with your sap; there isn't a single hole that isn't being loaded to full capacity with thick seed.", false);
	if (t4 >= 0) {
		outputText("  Her own rectal ", false);
		if (t5 >= 0) outputText("and vaginal ", false);
		outputText("squirts look ridiculous as her body is literally drenched in torrents of semen.", false);
	}
	outputText("  You keep soaking her with your lust-fueled fountain of spooge until your ", false);
	if (player.balls > 0) outputText("sack ", false);
	else outputText("groin ", false);
	outputText("feels empty, devoid of any fluid left to spray on her.  ", false);
	
	outputText("You keep holding her with " + player.sMultiCockDesc() + " for a moment, both of you enjoying the powerful embrace as you literally dick-hug her.  The entirety of her body is dripping with your jism but she doesn't seem to care.  Eventually, you put her down, letting her splat in the puddle of juices that formed below your junk-prison.  At last, you unfold your arms.\n\n", false);
	player.orgasm();
	dynStats("lib", -1, "sen", -1, "cor", .3);
	doNext(camp.returnToCampUseOneHour);
}

//Milking Isabella (dey terk Merble's jerb!)
//(not technically edited since the editor wrote it, huck huck)

//triggers when Izzy Milked Yet flag >= 10 and PC has Bmilker at farm; unless negative, flag gets reset to 0 if PC nurses from her in any nursing scene written later
//PC wasn't thinking about the pressure; titties get swole
public function milktasticLacticLactation():void {
	spriteSelect(31);
	clearOutput();
	if (isabellaAccent()) outputText("\"<i>Ohh, mein milkers...</i>\"\n\n", false);
	else outputText("\"<i>Ohh, my milkers...</i>\"\n\n", false);

	outputText("Isabella's moans distract you and you look over.  She's rubbing her breasts gingerly, wincing as she tests her strange nipples with a finger.  Do you go and check on her?", false);
	
	//[Yes][No]
	doYesNo(izzyMilkingMeinMilkersMya,izzyMilkYourselfDamnit);
}

//[No]
private function izzyMilkYourselfDamnit():void {
	//set Izzy Milked Yet flag to 0
	//in other words, she handles it herself somehow but it repeats after another ten days without milking her
	flags[kFLAGS.ISABELLA_MILKED_YET] = 0;
	camp.returnToCampUseOneHour();
}
//[Yes]
private function izzyMilkingMeinMilkersMya():void {
	spriteSelect(31);
	clearOutput();
	if (player.cor < 50) outputText("Concerned", false);
	else outputText("Idly", false);
	outputText(", you walk over to see what the matter is.  She looks up at you, misery clouding her usually cheerful, smiling face.  \"<i>", false);
	if (isabellaAccent()) outputText("Ahh, " + player.short + "... it has been sooo long since I have been properly milked, mein poor breasts are as full as zey have ever been.  I have been trying to release ze pressure myself, but zere are just not enuff hours in ze day vis everything else I must do, und mein nipples get quite sore, ja?", false);
	else outputText("Ahh, " + player.short + "... it's been sooo long since I've been properly milked, my poor breasts are fuller than they've ever been.  I have been trying to release the pressure myself, but there are just not enough hours in the day with everything else I must do, and my nipples get quite sore.", false);
	outputText("</i>\"\n\n", false);

	outputText("She's right; her tits are bigger than you've ever seen them, and not so much jiggling as sloshing audibly.  You frown in commiseration, and she fixes you with a hopeful, teary stare.  \"<i>", false);
	if (isabellaAccent()) outputText("Do you zink you could help me vis mein milkers?  Zere must be more zan a week's vorth stored up!</i>\"\n\n", false);
	else outputText("Do you think you could help me with my milkers?  There must be more than a week's worth stored up!</i>\"\n\n", false);
	
	outputText("As much as your mouth waters at the idea of drinking her frothy, creamy milk, you completely doubt your ability to handle that much of it without going into sugar shock, and tell her so.  Crestfallen, she begins to sob, and peals, \"<i>", false);
	if (isabellaAccent()) outputText("Zen -sniff- vat", false);
	else outputText("Then -sniff- what", false);
	outputText(" am I to do with all of my milk?  Boo hoo hoo!</i>\"\n\n", false);
	
	outputText("The sight of the proud warrioress so emotionally distraught is ", false);
	if (player.cor < 33) outputText("unbearable, but you quickly", false);
	else outputText("kind of arousing, actually, but at length you", false);
	outputText(" decide on a solution to her problem; a trip to Whitney's farm and a few hours spent in your milker stall to bleed off all that pressure.  You quickly announce her salvation - resisting the temptation to strike a heroic pose - and Isabella jumps from her seat and tackles you with a hug, flinching when her sore nipples bump your " + player.chestDesc() + ".\n\n", false);

	if (isabellaAccent()) outputText("\"<i>Ohh, " + player.short + ", I had forgotten all about zose milkers vith all ze verk around camp!  Yes, let us go zere immediately!</i>\"\n\n", false);
	else outputText("\"<i>Ohh, " + player.short + ", I had forgotten all about those milkers with all the work around camp!  Yes, let us go there immediately!</i>\"\n\n", false);
	
	//--next--
	doNext(izzyMilkingMeinMilkersMya2);
}
private function izzyMilkingMeinMilkersMya2():void {
	spriteSelect(31);
	clearOutput();
	outputText("In no time at all, Isabella has taken her place in your stall and you've helped her fasten the harnesses on and attach the milker cups.  The machinery whirrs and lifts her heavy form in the air ", false);
	
	//([PC fatness and muscle density check right hurr]
	if (player.thickness <= 50) outputText("with creaking effort, initially calibrated to your slender form as it was", false);
	else outputText("startlingly quickly, being already set to your much weightier bulk", false);
	outputText(".  The process begins in earnest and Isabella groans as the suction on her finger-chafed nipples begins.  ", false);
	if (isabellaAccent()) outputText("\"<i>Oooh, mein udders... zey feel as zough zey vill pop already!</i>\"\n\n", false);
	else outputText("\"<i>Oooh, my udders... they feel as though they will pop already!</i>\"\n\n", false);

	outputText("Sure enough, first a trickle and then a gush of Isabella's ivory breast-milk wicks down the tube and into the thirsty machine.  The clanging suction continues for nearly an hour, Isabella's groans quickly turning to bovine bellows of relief as the pressure in her mammaries begins to abate.  After a while you notice the soft pad of another person's footsteps on the barn floor behind you, and look over your shoulder.\n\n", false);

	outputText("\"<i>Heya " + player.short + "!  And heya Isabella; haven't seen you in a while!</i>\"  Whitney declares.  \"<i>I figured it was just you using the machine,</i>\" she angles her head at you, \"<i>but when I heard a different voice drifting out of the barn door I about dropped the load of stable muck I was tossing!  I was sneaking in the barn when I finally recognized who it was!  I see you get into your milking as much as ever, hon.</i>\"  The dog-morph shoots a surreptitious glance at Isabella's skirt, where a trickle of girlcum is staining the front.\n\n", false);
	
	outputText("The cow-girl, all smiles and lolling tongue, still manages to nod briskly at the farmer.  \"<i>", false);
	if (isabellaAccent()) outputText("Zat's right, I - oooh - had ssso m-much to do that I had no time to empty oh-oh-out mah-mah-my... my... MOOOOOO-ilkers!  Ah, ah, ah!</i>\"  Isabella twitches and arches her back as the dark spot on the front of her skirt widens appreciably; she just had an orgasm from having her immense load of milk drained!  Whitney gives a wry smile when she notices you staring, and pats you on the shoulder.  \"<i>Used to happen a lot before, too,</i>\" she whispers.  \"<i>She'd come in after a week complaining how sore her tits were, cream the machine, and cream herself.  I offered to put her up on the farm so she wouldn't have to wait so long, but she wouldn't hear of it.  Too independent, I guess; just like you.</i>\"  Whitney removes her hand and walks over to the bottling station, turning it on.\n\n", false);
	else outputText("That's right, I - oooh - had ssso m-much to do that I had no time to empty oh-oh-out mah-mah-my... my... MOOOOOO-ilkers!  Ah, ah, ah!</i>\"  Isabella twitches and arches her back as the dark spot on the front of her skirt widens appreciably; she just had an orgasm from having her immense load of milk drained!  Whitney gives a wry smile when she notices you staring, and pats you on the shoulder.  \"<i>Used to happen a lot before, too,</i>\" she whispers.  \"<i>She'd come in after a week complaining how sore her tits were, cream the machine, and cream herself.  I offered to put her up on the farm so she wouldn't have to wait so long, but she wouldn't hear of it.  Too independent, I guess; just like you.</i>\"  Whitney removes her hand and walks over to the bottling station, turning it on.\n\n", false);

	if (isabellaAccent()) outputText("As the flow abates, the harness lowers Isabella, flushed and panting, to the ground.  You walk over to check on her and she weakly throws her arms around you, rubbing her still-nude-but-relieved breasts against you as she delivers a sloppy kiss.  \"<i>Ohh, " + player.short + ", zank you so much for reminding me of zis place.</i>\"\n\n", false);
	else outputText("As the flow abates, the harness lowers Isabella, flushed and panting, to the ground.  You walk over to check on her and she weakly throws her arms around you, rubbing her still-nude-but-relieved breasts against you as she delivers a sloppy kiss.  \"<i>Ohh, " + player.short + ", thank you so much for reminding me of this place.</i>\"\n\n", false);

	outputText("Whitney returns, handing warm bottles of milk to both of you.  \"<i>Here you go: fresh from the pump.  Isabella, do you think you're going to stop by more from now on?  I could set aside your old stall.</i>\"\n\n", false);

	if (isabellaAccent()) outputText("The warrioress nods emphatically.  \"<i>Ja, it vould help sooo much vith how busy I am now!  Is zis okay, " + player.short + "?  For me to visit once a day und relieve the pressure on mein milkers?</i>\"\n\n", false);
	else outputText("The warrioress nods emphatically.  \"<i>Yes, it would help sooo much with how busy I am now!  Is this okay, " + player.short + "?  For me to visit once a day and relieve the pressure on my milkers?</i>\"\n\n", false);

	outputText("You ", false);
	if (player.cor > 50) outputText("briefly consider forbidding her outright in order to see that exquisite look of pained pleasure on her face again, but you don't think she'd comply.", false);
	else outputText("don't really see a problem with it as long as she has some left to slake your thirst, but that's the question, isn't it?", false);
	outputText("  What do you say?", false);

	//[I'll Allow It][Mine Mine MINE!]
	simpleChoices("Allow It", AllowIzzyMilkerUse, "MINE!", noMilkingMilky, "", null, "", null, "", null);
}

//[I'll Allow It]
private function AllowIzzyMilkerUse():void {
	spriteSelect(31);
	clearOutput();
	outputText("With a smile, you tell Isabella she's free to come here whenever she's feeling pent-up, as long as there's enough left for you to have some fun together when you want to.  Isabella hugs you again, tits and nipples pressing into your ", false);
	if (player.tallness < 72) outputText("face", false);
	else outputText("chest", false);
	outputText(", as she assures you you'll always come first while she's with you.\n\n", false);
	if (player.hasCock()) outputText("(You have a hunch that you might be able to catch her using the milkers at the farm if you 'explore' there, provided she hasn't been recently milked.)\n\n");
	//get 1 Izzit Milk or Cream? item, set Izzy Milked Yet flag to -1, which adds [GetMilk] button to follower menu
	flags[kFLAGS.ISABELLA_MILKED_YET] = -1;
	inventory.takeItem(consumables.IZYMILK, camp.returnToCampUseOneHour);
}

//[Mine Mine MINE!]
private function noMilkingMilky():void {
	spriteSelect(31);
	clearOutput();
	outputText("You grin at Isabella and pull her over to you.  Wrapping one arm around her waist, you tell her that this was only a stopgap; you'll be the one to take care of all her needs from now on.  To emphasize your point, you ", false);
	if (player.cor > 50) outputText("roughly grab", false);
	else outputText("gently caress", false);
	outputText(" the sensitive nipples on her left breast; she moans in ", false);
	if (player.cor > 50) outputText("painful ", false);
	outputText("arousal at your touch, blushing at putting on such a show in front of Whitney.  The farmer shrugs.  \"<i>Y'all please yourselves.  Milker'll be here if you need it.</i>\"\n\n", false);
	//get 1 Izzit Milk or Cream? item, set Izzy Milked Yet flag to -2, which adds [GetMilk] button to follower menu
	flags[kFLAGS.ISABELLA_MILKED_YET] = -2;
	inventory.takeItem(consumables.IZYMILK, camp.returnToCampUseOneHour);
}

//[GetMilk] 
//follower menu button 
//(only appears if Izzy Milked Yet flag < 0)
private function getMilk():void {
	spriteSelect(31);
	clearOutput();
	outputText("You tell Isabella that you want a bottle of her milk.  ", false);
	//Izzy overmilked
	if (flags[kFLAGS.ISABELLA_MILK_COOLDOWN] > 0) {
		outputText("Isabella shakes her head and tells you she", false);
		if (flags[kFLAGS.ISABELLA_MILKED_YET] == -1) outputText("'s out of bottled milk right now, and that you should check back later.", false);
		else outputText("'s still sore from last time, and that you should wait till later.", false);
		doNext(callForFollowerIsabella);
		return;
	}
	//[(if Izzy Milked Yet flag = -1)
	if (flags[kFLAGS.ISABELLA_MILKED_YET] == -1) {
		if (isabellaAccent()) outputText("Isabella nods, and fetches you one of the spares from her latest milking session at the farm.  \"<i>Here you go!  Less zan twenty-four hours old, ja?</i>\"", false);
		else outputText("Isabella nods, and fetches you one of the spares from her latest milking session at the farm.  \"<i>Here you go!  Less than twenty-four hours old, okay?</i>\"\n\n", false);
	}
	else {
		outputText("Isabella nods, holding an empty bottle out to you and pulling her top down to expose her well-marbled bosom.  \"<i>Remember, your promise...</i>\"\n\n", false);

		outputText("You smile wryly and begin teasing and pulling the nipples of one breast even as you lean over to the other and pop two of its teats into your mouth.  \"<i>", false);
		if (isabellaAccent()) outputText("Ja, zat feels great... hurry and let out mein milk...</i>\"", false);
		else outputText("Ooh, that feels great... hurry and let out my milk...</i>\"", false);
	
		outputText("\n\nThe stimulation quickly sets off several creamy flows, one into the bottle and two more into your stomach, the rest dripping to the ground as Isabella leans into you.  Before long both your containers are full, and you release her nipples.  \"<i>", false);
		if (isabellaAccent()) outputText("Zat", false);
		else outputText("That", false);
		outputText(" felt gooood... thank you!</i>\" Isabella says, breathily; the telltale wet spot is back on the front of her skirt.  You manage not to get caught staring at it, but the aroma of her arousal combined with her quivering, grateful breastflesh makes you consider sticking around for more fun...\n\n", false);
	}
	//get 1 Izzit Milk or Cream? item, lose some fatigue and gain some lust if Izzy Milked Yet flag = -2
	flags[kFLAGS.ISABELLA_MILKED_YET] = -2;
	flags[kFLAGS.ISABELLA_MILK_COOLDOWN] = 7 + rand(4);
	inventory.takeItem(consumables.IZYMILK, camp.returnToCampUseOneHour);
}
//TDM's Angry Murble
public function angryMurble():void {
	clearOutput();
	outputText("You come to Isabella's part of the camp with Marble in tow, supposing now is as good a time as ever to introduce the two.  Marble greats Isabella warmly but immediately starts bombarding her with questions about her origin.  From her persistence, it seems she is interested in meeting another cow-girl.  Though a little overwhelmed, Isabella recovers quickly, explaining her origins and the impurity of her cow-girl nature.  Marble is visibly disappointed.\n\n", false);
	
	outputText("\"<i>The topic of conversation gradually shifts to the reason why Marble has come to the camp.  Marble seems to be happy to meet your friend, and is eager to spend some more time with her in the future.  Isabella, on the other hand, seems a little off-put regarding Marble's actions.  Only time will tell how the two take to each other.", false);
	flags[kFLAGS.ISABELLA_MURBLE_BLEH] = 2;
	doNext(playerMenu);
}

//Sparring
//normal isabella combat + status affect "sparring"
//v1 = 1, normal sparring.
//v2 = 2, 'light' sparring.
private function isabellaSparMenu():void {
	spriteSelect(31);
	clearOutput();
	if (flags[kFLAGS.ISABELLA_SPARRING_INTRO] == 0) {
		outputText("Isabella smiles when you suggest sparring and vigorously nods, exclaiming, \"<i>", false);
		if (isabellaAccent()) outputText("Zis vill be good for both of us, ya!?</i>\"  The beaming cow-girl taps a finger to her chin and suggests, \"<i>Ve should set up out on ze edges of the plains, so ve don't damage zis camp.</i>\"", false);
		else outputText("This ought to be good for both of us!</i>\"  The beaming cow-girl taps a finger to her chin and suggests, \"<i>Why don't we set up a faux camp on the edge of the plains, so we don't damage this one.  Okay?</i>\"", false);
		
		outputText("  That seems logical.  This will be like a trip down memory lane.\n\n", false);
		flags[kFLAGS.ISABELLA_SPARRING_INTRO] = 1;
	}
	else outputText("You suggest a sparring session.  ", false);
	if (isabellaAccent()) outputText("Isabella asks, \"<i>Vhat stakes should ve use?  Vould you rather we spar light or fight like ze creatures of zis world?</i>\"", false);
	else outputText("Isabella asks, \"<i>How should we fight?  Would you rather we spar light or fight like the creatures of this world?</i>\"", false);
	outputText("\n\n(Do you spar 'light' with no consequences for losing, or would you rather spar 'hard' (with full consequences for loss/win)?)", false);
	simpleChoices("Light", createCallBackFunction(sparring, 2), "Hard", createCallBackFunction(sparring, 1), "", null, "", null, "Back", callForFollowerIsabella);
}

private function sparring(type:int = 1):void {
	spriteSelect(31);
	clearOutput();
	if (flags[kFLAGS.ISABELLA_SPARRING_INTRO] == 1) {
		outputText("You and Isabella hike to the border of the plains with some old furniture and worn out blankets, arranging a faux camp for you to fight around.  Once it is finished, you take a quick breather before getting started.\n\n", false);
		flags[kFLAGS.ISABELLA_SPARRING_INTRO] = 2;
	}
	else {
		outputText("You and Isabella hike to the border of the plains, where you set up the make-shift camp for your sparring sessions.\n\n", false);
	}
	outputText("Isabella lifts her shield and raps her knuckles against the solid steel, making a loud, gong-like sound that carries for some distance.  You raise your " + player.weaponName + " and prepare to fight.  It's on!", false);
	if (type == 1) outputText("  The knowledge that you're playing for keeps makes your heart beat faster.", false);
	startCombat(new Isabella());
	monster.createStatusEffect(StatusEffects.Sparring,type,0,0,0);
	//No gems.
	monster.gems = 0;
	//Nerf XP if light mode
	if (type == 2) monster.XP = Math.round(monster.XP / 2);
	spriteSelect(31);
}

//Isabella Burps

//first time (Z)
private function isabellaBurps():void {
	player.consumeItem(consumables.PROBOVA);
	spriteSelect(31);
	clearOutput();
	//First time
	if (flags[kFLAGS.ISABELLA_PROBOVA_BURP_COUNT] == 0) {
		if (isabellaAccent()) outputText("\"<i>Vhat is zat, dear?</i>\"", false);
		else outputText("\"<i>What do you have there?</i>\"", false);
		outputText(" Isabella asks innocently, inspecting the bottle of cloudy fluid you're offering her.  You reveal the contents to be Pro Bova, basically a supercharged version of what she took to become as she is now.  Her eyes cloud a bit as she absentmindedly presses her oversized bosom together, the most obvious indication of her changes.  \"<i>And you ", false);
		if (isabellaAccent()) outputText("v", false);
		else outputText("w", false);
		outputText("ould like me to drink more?</i>\" she asks, only a hint of trepidation in her rich voice.  ", false);
		if (isabellaAccent()) outputText("\"<i>Vell... nuzzing irreversible can happen, ja?</i>\"", false);
		else outputText("\"<i>Well... there's nothing we can't change back, right?</i>\"", false);
		outputText("\n\n", false);
		
		outputText("At your assurance that she won't change beyond the obvious extra cow-girl aspects, she visibly calms, beaming at you and reaching for the potion.  \"<i>", false);
		if (isabellaAccent()) outputText("Bottoms up, in zat case!", false);
		else outputText("Bottoms up, in that case!", false);
		outputText("</i>\" she exclaims, uncorking the Pro Bova and gulping the whole thing down.  \"<i>Not too bad,</i>\" she comments, smacking her lips in satisfaction a couple times. \"<i>Now, whe-...</i>\"\n\n", false);
	
		outputText("Her thought is completely cut off by an angry gurgling in her gut.  She grunts, hitting her stomach with her balled-up hand a few times in an attempt to quiet the rude organ, but her attempt is only rewarded with another, louder belly growl.  You exchange glances, both of you wondering what exactly the potion will do – and did – to her.  Isabella curiously inspects her arm as if to spot any signs of change, finding nothing but chocolate-colored skin and the calloused hands of a working woman.  Suddenly, the cow-girl flinches, wincing and clutching her tummy.  For a moment, you consider asking her what's the matter, but you quickly figure it out yourself as your gaze drops south.  Her gut, usually flat and firm, is bloated considerably, rounding out to a little pot belly and slowly growing.\n\n", false);
	
		outputText("Both of you are at a loss for words, alternating glances from each other to her belly in quick succession.  Isabella straightens unexpectedly, now gripping her stomach with both hands.  \"<i>Tight...</i>\" she moans through gritted teeth. \"<i>Moving...</i>\"\n\n", false);
		
		outputText("Her eyes widen as realization strikes her.  \"<i>Back away,</i>\" she warns, weakly waving an arm at you. \"<i>Allergy...</i>\" It seems as if something might be coming. Do you flee from the pained cow-girl, or do you attempt to assist her with her problem?  Though, judging by her reaction, assistance might be a poor plan...", false);
	
		//put 'run' and 'help' buttons root hurr
		simpleChoices("Run", runAwayFromIzzyBurps, "Help", getIzzyBurped, "", null, "", null, "", null);
	}
	//Repeat
	else {
		//Repeat encounter (Z)
		outputText("She chuckles heartily as you pull another Pro Bova from your inventory and hand it to her, and she takes it with only a moment's hesitation.  \"<i>", false);
		if (isabellaAccent()) outputText("You are quite sure about zis, ja?</i>\" she asks to confirm, shaking the bottle at you gently.  \"<i>You know vhat zis does to me.</i>\"  Your mischievous smile is the only answer she needs.  She easily gulps down the potion, already rubbing her belly in apparent anticipation.  She notices your curious glance and answers with a nervous chuckle.  \"<i>It is one of zose zings, ja?</i>\" she tries to explain while waiting for the onset of her reaction.  \"<i>Making you more like me... it is comforting somehow.</i>\"\n\n", false);
		else outputText("You're sure about this, huh?</i>\" she asks to confirm, shaking the bottle at you gently.  \"<i>You know what this does to me.</i>\"  Your mischievous smile is the only answer she needs.  She easily gulps down the potion, already rubbing her belly in apparent anticipation.  She notices your curious glance and answers with a nervous chuckle.  \"<i>It's one of those things...</i>\" she tries to explain while waiting for the onset of her reaction.  \"<i>Making you more like me... it's comforting somehow.</i>\"\n\n", false);

		outputText("\"<i>Aaah, I can feel it,</i>\" she warns, and sure enough, the bottom hem of her top lifts to reveal an unhurriedly-swelling ponch.  \"<i>Are you ready, or are you having second thoughts?</i>\"  Your gaze falls to her gurgling pot-belly as you mull over her question.  Do you see any harm in getting another dose of Izzy-gas, or would you like to duck out of this one?", false);
		simpleChoices("Run", runAwayFromIzzyBurps, "Stay", getIzzyBurped, "", null, "", null, "", null);
	}
}

//run
private function runAwayFromIzzyBurps():void {
	clearOutput();
	spriteSelect(31);
	//First time
	if (flags[kFLAGS.ISABELLA_PROBOVA_BURP_COUNT] == 0) {
		outputText("Allowing common sense to dictate your judgment, you step back from the dark-skinned woman, backing up until she stops waving at you.  She grimaces in an evident cross of pain and... pleasure?  Her cheeks are puffing up and chest, puffing out.  Despite yourself, you can't help but admire the way her 'udders' sit on her out-thrust torso, jiggling constantly from the tremors running through her body.  Finally, when she can't seem to hold herself back any longer, her mouth flies open as wide as you've ever seen it, a gigantic burp thundering out.  A visible misty cloud issues from her gaping gob, gaining volume and hovering ominously around her as subsequent belches ripple forth.  In an attempt to free all of the offending gas from her poor body, Isabella roughly squishes her midsection, wincing at each emission as she forces them out.\n\n", false);
	
		outputText("The gaseous assault eventually diminishes, her belly returning to a healthy state and the cloud dispersing.  After waiting a few minutes to confirm the end of the episode, Isabella stomps up to you, a fierce blush painting her cheeks.  \"<i>", false);
		if (isabellaAccent()) outputText("Vat did you give me?  Zat was zimply embarrassing!", false);
		else outputText("What did you give me? That was simply embarrassing!", false);
		outputText("</i>\" she complains, lip drooped in an upset pout.  You can't help but agree, but you do point out that nothing bad happened, after all.\n\n", false);
		
		outputText("\"<i>...True,</i>\" she concedes, a bit of her bluster lost at the realization.  \"<i>", false);
		if (isabellaAccent()) outputText("It seems mein body rejected zis 'Pro Bova' for one reason or another.</i>\"  No harm, no foul, you offer hopefully, and she nods.  \"<i>But make sure to seriously zink before giving me a potion again!</i>\" she warns, waggling a foreboding finger your way.  You think back to that cloud of gas, and what the probable effect of such a thing would be in close proximity.  Even if you wanted to test that out, however, you'd need another Pro Bova...", false);
		else outputText("It seems my body rejected this 'Pro Bova' for one reason or another.</i>\"  No harm, no foul, you offer hopefully, and she nods.  \"<i>But make sure to seriously think before giving me a potion again!</i>\" she warns, waggling a foreboding finger your way.  You think back to that cloud of gas, and what the probable effect of such a thing would be in close proximity.  Even if you wanted to test that out, however, you'd need another Pro Bova...", false);
		//Back to follower menu
		doNext(callForFollowerIsabella);
	}
	else {
		//outta there
		outputText("Allowing common sense to dictate your actions, you step back from the dark-skinned woman while explaining your change of heart.  She nods her consent before cradling her churning gut, grimacing in discomfort and only a little guilty pleasure.  Her cheeks and chest predictably puff up.  You take the chance to admire her rack, the ponderous belly only accentuating the huge, beautiful bosom, jiggling constantly from the tremors running through her body.  Finally, when she can't seem to hold herself back any longer, her mouth flies open as wide as you've ever seen it, a gigantic burp thundering out.  A visible misty cloud issues from her gaping gob, gaining volume and hovering ominously around her as subsequent belches ripple forth.  In an attempt to free all of the offending gas from her poor body, Isabella roughly squishes her midsection, wincing at each emission as she forces them out.\n\n", false);

		if (isabellaAccent()) outputText("The gaseous assault eventually diminishes, her belly returning to a healthy state and the cloud dispersing.  She sighs in relief as she pats her tummy, looking to you with a hint of disappointment darkening her expression.  \"<i>I zink I am getting used to zis,</i>\" she sighs as you approach.  \"<i>It vould be so much more fun if you were here to... enjoy it vith me.  Zink about zat next time you bring me one of zese, okay?</i>\"\n\n", false);
		else outputText("The gaseous assault eventually diminishes, her belly returning to a healthy state and the cloud dispersing.  She sighs in relief as she pats her tummy, looking to you with a hint of disappointment darkening her expression.  \"<i>I'm getting used to this,</i>\" she sighs as you approach.  \"<i>It would be so much more fun if you were here to... enjoy it with me.  Think about that next time you bring me one of these, okay?</i>\"\n\n", false);
		
		outputText("At your nod, she smiles in satisfaction and moves away.  You can't be sure, but you almost swear you hear her burp once more.", false);
		doNext(callForFollowerIsabella);
	}
}

//help (ya dumbo)
private function getIzzyBurped():void {
	clearOutput();
	spriteSelect(31);
	flags[kFLAGS.ISABELLA_PROBOVA_BURP_COUNT]++;
	//First time
	if (flags[kFLAGS.ISABELLA_PROBOVA_BURP_COUNT] == 1) {
		outputText("You completely ignore the warning, immediately moving to help your cow-girl companion with her upset stomach problems. She casts a disbelieving look at you, vocally stumbling over a dozen different protests. Determined as you are, however, you dutifully rub her belly, intent on alleviating her pains.  \"<i>You... you.... dummkopf! ",false);
		if (isabellaAccent()) outputText("V", false);
		else outputText("W", false);
		outputText("hat-</i>\" she sputters, the last syllable mysteriously cut off. Curious about the interruption, you look up from your massaging to her face. Isabella's cheeks are seriously inflated, as if she was attempting to hold back... oh.  Ooooooh.  Almost theatrical in its timing, her first echoing belch strikes you the same time as realization dawns upon you, the surprisingly sweet-smelling gust blasting your " + player.hairDescript() + " behind you.\n\n", false);
	
		outputText("Lurching back, you unintentionally press her stomach even harder, doubling her over – but not before drawing another face-full of burp.  You stagger out of a sudden cloud of mist surrounding Isabella's upper body, but not without having taken a couple breaths of the stuff.  After removing yourself from ground zero, you face the cow-girl once more, only to find her kneeling, rubbing her stomach with one hand while burping into the other.  A blush so red it seems almost like she's turning into an imp streaks across her face as her onslaught of gas continues.\n\n", false);
		
		outputText("The humiliating belch-frenzy begins to calm, occurring less and less frequently until it finally ceases.  Isabella plops to the ground, sighing a breath of release as the misty cloud surrounding her finally begins to disperse.", false);
		
		var changed:Boolean = false;
		//no new paragraph, but this obviously shouldn't happen with characters who already have hooves, cow/bull horns, lactating breasts, or a penis smaller than 8 inches. If you want to simply disable the following for those with the first two while simply adding a 'more' to the lactation or an 'even smaller' to the wang growing, I don't blame you, but if you could go in and 'if cow feet don't look at this shit' and whatever with each individual part, it'd probably read the best. Your call, you probably want to get done with this sooner than later. tl;dr it would be cool if you could make it fit as many of the criteria that apply at once.
		if (player.lowerBody != LOWER_BODY_TYPE_HOOFED || player.horns <= 0 || player.hornType != HORNS_COW_MINOTAUR) {
			outputText("  With that whole affair over with, you go to stand... and find yourself falling once more.", false);
		}
		if (player.lowerBody != LOWER_BODY_TYPE_HOOFED) {
			//[if no hooves present already]
			if (player.isTaur()) outputText("  Confused, you quickly inspect yourself before your gaze settles on your hooves – or should you say, your SINGLE PAIR of hooves.  Triggered by what you surmise are the Pro Bova's fumes, your centaur body has vanished, leaving you with a single pair of cow-like hooves.", false);
			else outputText("  Confused, you quickly inspect yourself before your gaze settles on your " + player.feet() + " – or should you say, former " + player.feet() + ".  Triggered by what you surmise are the Pro Bova's fumes, your " + player.feet() + " have quickly and painlessly refashioned themselves into cloven hooves – not unlike those Isabella is currently sporting.", false);
			changed = true;
		}
		//[if no cow horns present]
		if (player.horns <= 0 || player.hornType != HORNS_COW_MINOTAUR) {
			if (player.horns > 0 && player.hornType > HORNS_NONE) outputText("  Your existing horns quiver, then reform into those of a " + player.mf("bull","cow"), false);
			else outputText("  Two nubs sprout from your forehead, swiftly thickening and growing into a large pair of curved bovine horns", false);
			outputText(", throwing your center of balance off and aborting yet another attempt to right yourself.", false);
			changed = true;
		}
		//[if no cow ears]
		if (player.earType != EARS_COW) {
			outputText("  Your ears wiggle a bit, then simply migrate higher up your head, lengthening and widening as they go.  Before you know it, you have cow ears.", false);
			changed = true;
		}
		//[if no cow tail]
		if (player.tailType != TAIL_TYPE_COW) {
			if (player.tailType > TAIL_TYPE_NONE) outputText("  The tip of your tail reshapes into a burst of fur, the entire length changing to match.", false);
			else outputText("  A tail creeps out of your " + player.armorName + ", perking up and growing rapidly.  A flare of fur bursts from the tip, the rest of the length changing to match.", false);
			changed = true;
		}
		//([Female/herm: if breasts smaller than G-cup and not lactating a whole lot]
		if (player.hasVagina() && player.biggestTitSize() < 15 && player.biggestLactation() < 2) {
			outputText("  Unbeknownst to you, Isabella's potent cow-gas has gone to town on your " + player.breastDescript(0) + ", growing them to an obnoxious G-cup... no, not exactly growing, you realize, but filling... you give one of your swollen teats a squeeze, not quite surprised by the gout of milk that stains your " + player.armorName + ".\n\n", false);
			changed = true;
		}
		//([Female/herm: if breasts >G-cup and lactating]
		else if (player.hasVagina() && player.biggestLactation() >= 2) {
			outputText("  Propped up as you are with your soft " + player.breastDescript(0) + " nestling under your chin, you can easily see the growing puddle of alabaster liquid seeping into the ground.  You heave yourself up, the effort rewarded with a jet of milk shot into the air as your evidently over-laden boobs jostle about inside your " + player.armorName + ". It seems the effects of Isabella's gas has ramped your lactation to overdrive.", false);
			changed = true;
		}
		//both cases, flavor text
		//[Male/herm: if penis <18 inches & testicles smaller than however long in diameter a baseball is]
		if (player.hasCock() && player.longestCockLength() < 18) {
			outputText("  A pressure builds in your crotch, at first subtle, then incredibly obnoxious to the point where you're forced to undo the lower portion of your " + player.armorName + " to seek some sort of relief.  Your shock is total as you stare at your former " + player.cockDescript(0) + ", now measuring at least 18 inches long – a condition that Isabella has already noticed and is clearly formulating a gripe about.", false);
			if (player.balls < 0) outputText("  Two testicles fall into a scrotum near the base of your enlarged meat, already swelling into baseball-sized balls o' fun.", false);
			else if (player.ballSize < 4) outputText("  Your testicles engorge in the transformative powers of the cow-girl's violent reaction to the Pro Bova, growing to baseball-sized in short order.", false);
			changed = true;
		}
		//[if female/herm and player race not cow-girl]
		if (changed && player.hasVagina() && player.race() != "cow-girl") {
			outputText("  \"<i>Goodness, look at you!</i>\" Isabella exclaims, waving away the remnant wisps of the gassy mist.  \"<i>Surely, you're giving me a run for ", false);
			if (isabellaAccent()) outputText("mein money now, ja?", false);
			else outputText("my money now, darling!", false);
			outputText("</i>\"  Considering your current condition, you can't really disagree.  She happily approaches and sweeps you up into a big hug, squishing your tits into hers and wiggling about happily, transferring waves of jiggle-inducing energy into your tits.  \"<i>", false);
			if (isabellaAccent()) {
				if (player.tallness < 87) outputText("Now, if only ve could make you a bit taller, ve vould be twins!", false);
				else if (player.tallness < 95) outputText("Und look at zat, you're as grown up as me!", false);
				else outputText("Zough, of course, you do have me beat in ze height department!", false);
			}
			else {
				if (player.tallness < 87) outputText("Now, if only we could make you a bit taller, we would be twins!", false);
				else if (player.tallness < 95) outputText("And look at that, you're as grown up as me!", false);
				else outputText("Though, of course, you do have me beat in the height department!", false);
			}
			outputText("</i>\"\n\n", false);
		}
		//[if male and player race not cowboy]
		else if (changed && player.hasCock() && player.race() != "cow-morph") {
			outputText("  \"<i>", false);
			if (isabellaAccent()) outputText("Nein nein nein nein, zis von't do at all!", false);
			else outputText("No, no! This is awful!", false);
			outputText("</i>\" she cries as she approaches, eyes locked on your oversized genitalia.", false);
			if (player.longestCockLength() < 18) {
				if (isabellaAccent()) outputText("  \"<i>Zis did not have to be any bigger!  Vhat a tragedy! Your poor little wiener!</i>\"", false);
				else outputText("  \"<i>This did not have to be any bigger!  What a tragedy! Your poor little wiener!</i>\"", false);
				outputText("  You raise an eyebrow at her selective worry, indicating just how cow-like you've become.  ", false);
				if (isabellaAccent()) outputText("\"<i>...Yah, zat is important too, but mein poor pussy...</i>\"", false);
				else outputText("\"<i>I suppose that's important too, but what about my poor girl-parts?</i>\"", false);
			}
			outputText("\n\n", false);
		}
		//[if no changes occurred]
		else {
			outputText("  Isabella stands, inspecting you curiously.  \"<i>It seems ", false);
			if (isabellaAccent()) outputText("mein... gas... did not harm you any, ja?  Zat is good, right?</i>\"  You manage a weak smile and nod, more than a little relieved everything turned out well in the end.\n\n", false);
			else outputText("my... gas... didn't harm you any, did it?  That's good, right?</i>\"  You manage a weak smile and nod, more than a little relieved everything turned out well in the end.\n\n", false);
		}
		//'sorry for burping in your face bro'
		outputText("For a while the busty woman simply shuffles from hoof to hoof, kicking the ground and fiddling with her hair.  \"<i>... I suppose an apology is in order,</i>\" she finally mumbles between pursed and pouty lips.  She approaches slowly, but in lieu of any actual begs of forgiveness, she slips a hand around your head and brings you in for a lingering smooch.  Her eyes twinkle with undeniable lust as she slowly draws back, tongue licking up the small bridge of drool between your lips.  \"<i>Do you accept my apology?</i>\" she asks wryly.\n\n", false);
		if (changed) player.createStatusEffect(StatusEffects.BurpChanged,0,0,0,0);
	}
	else {
		//let's go Izzy I can dig it
		outputText("You get in close, nuzzling against your cow-girl lover as you wait for the inevitable.  Playfully, you press a hand against her bloated belly, slipping a little eruction and a feigned huff of exasperation from her.  \"<i>Wait your - urp - turn!</i>\" she scolds, the act of speaking forcing another preemptive burp from her depths.\n\n", false);
		
		outputText("Determined to punish you from your impertinence, she draws back, sucking in a huge breath before wrapping you in a big hug.  Her belly squishes against your frame, squeezing a good amount of her backed-up gas up her throat.  You marvel at the bulge in her throat as the effluvium attempts to escape, and at the last moment, you remember how close you are to her currently-sealed lips.  The only effect your struggles have is pressing harder against her ballooning stomach, however.  Braaaaap!  Her thunderous belch blows your head back, forcing you to dangle loosely in her grasp as the gaseous assault begins.  Isabella begins giggling between burps, clearly amused at your light-hearted reaction.\n\n", false);

		outputText("She rewards you by freeing one of her arms and wrapping it around your head, pulling you in between her gleaming ebony melons.  Shaking about and wrapping your head in a marshmallowy shroud of comfort, Isabella continues to force burps out, not content until all of the gas is gone.  She pulls you out of your fleshy prison after the oral venting subsides, dragging you down to the ground with her as her gassy magic begins to take hold.\n\n", false);
		
		//if meets any requirements for cow-y TF
		if (player.lowerBody != LOWER_BODY_TYPE_HOOFED || player.horns <= 0 || player.hornType != HORNS_COW_MINOTAUR || player.earType != EARS_COW || player.tailType != TAIL_TYPE_COW || (player.hasCock() && player.longestCockLength() < 18)) {
			outputText("You're not surprised when you take the now-familiar cow-" + player.mf("boy","girl") + " form, ", false);
			if ((!player.hasCock() || rand(2) == 0) && player.hasVagina()) outputText("Isabella beaming with eagerness at your sloshing and swelling bosom.\n\n", false);
			else if (player.hasCock()) outputText("Isabella not able to keep a little frustration from her face as your dick grows to enviable size.\n\n", false);
		}
		//if all requirements already filled (already a busty cow-girl/well-endowed cowboy)
		else outputText("Predictably, her sweet-smelling fumes do nothing but further exacerbate your sex-drive, and from the look in her eyes, she's looking forward to it.\n\n", false);

		//'sorry for burping in your face bro'
		outputText("Isabella smiles and draws you in for a smooth.  \"<i>I suppose I should really apologize again,</i>\" she muses as she slowly draws back, tongue licking up the small bridge of drool between your lips.  \"<i>Do you accept my apology?</i>\" she asks wryly.", false);
	}
	doYesNo(acceptCowpology,declineIzzysCowBurpApology);
}
//no
private function declineIzzysCowBurpApology():void {
	clearOutput();
	spriteSelect(31);
	if (flags[kFLAGS.ISABELLA_PROBOVA_BURP_COUNT] == 1) {
		outputText("As strange as the situation is, you're too weirded out to reassure Isabella, at least for now, and you relay that to her.  Though crestfallen, she takes the news well, apologizing - sincerely and soberly - once more before moving back to her designated camping spot.  ", false);
		if (player.findStatusEffect(StatusEffects.BurpChanged) >= 0) {
			outputText("  Happily, after about an hour, you go back to your old form, leaving the belch-borne bovine bounty behind.", false);
			player.removeStatusEffect(StatusEffects.BurpChanged);
		}
	}
	//no
	else {
		outputText("Despite your strangely inspired lust, you turn the cow-girl down.  Though crestfallen, she takes the news well, apologizing - sincerely and soberly - once more before moving back to her designated camping spot.  Happily, after about an hour, you get back to normal.", false);
	}
	doNext(camp.returnToCampUseOneHour);
}

//yes
private function acceptCowpology():void {
	clearOutput();
	spriteSelect(31);
	//Clear burps!
	if (player.findStatusEffect(StatusEffects.BurpChanged) >= 0)
		player.removeStatusEffect(StatusEffects.BurpChanged);
	player.orgasm();
	dynStats("sen", -1);
	//FIRST TIME
	if (flags[kFLAGS.ISABELLA_PROBOVA_BURP_COUNT] == 1) {
		outputText("Flashing a smirk, you beckon her your way, stripping from your " + player.armorName + ".  With delicate and deliberate motions you pull the hem of Isabella's milk-stained blouse down, reaching into the depths of her cleavage and taking hold of her oversized breasts.  It takes effort to heave the heavy, fluid-filled mammaries up and out of her shirt.  Once exposed to the open air, her quadruplet of nipples twitch and stiffen, only swelling further as you alternatingly tease her teats with the edge of your fingernail.  You trace little circles along the areola, running up and over the nubs; your gentle-but-devastating caressing technique sets Isabella all a-shiver, knees knocking together in hardly-contained ecstasy.  If given enough time, you figure you could push the cow-girl to climax merely from nipple stimulation, but your own body demands satisfaction as well.\n\n", false);
		//male: titjoob (Z)
		if (player.hasCock()) {
			outputText("Figuring to put your oversized organ to use, you pull Isabella's tits apart and slap your hard length between them.  As soon as she figures out your intentions, the cow-girl moves to take over, mashing her pillowy endowments together around your maleness.  Perhaps it was from the gas, but what should be a simple titty-fuck is driving you insane with pleasure; her warm, sweaty boob flesh contours to the curves of your shaft and head as well as any pussy.  You can't help yourself – you begin to pump your hips, your tip poking out to dance tantalizingly above Isabella's face before withdrawing, only to peek out again seconds later.  The cow-girl smiles and opens wide, her long tongue slithering free from its shelter.\n\n", false);
			
			outputText("She expertly licks and flicks at the underside of your cock during your next thrust, sending an almost electric current of pleasure through you.  You two find a rhythm quickly, grinding, thrusting, and licking in perfect unison.  As you come closer to orgasm, you begin increasing the pace; your lover is more than happy to match.  Suddenly, Isabella releases her hold on her bosom and instead wraps her arms around your " + player.buttDescript() + ", pulling you toward her and her wide-open mouth. Your legs catch on her boobs, but she doesn't even notice, closing her full lips around as much of your shaft as she can fit.  As good as her warm, wet mouth feels, her tongue demands the majority of your attention.  It besieges your junk completely, wrapping around the shaft, tickling the undercarriage, and even stroking – a perfect prehensile ejaculatory aid.\n\n", false);
			
			outputText("You can't hold out anymore, and Isabella senses it – she even raises her head to make it easier for you to grab hold.  Hot globs of sperm move through your urethra at record speed, and with an urgency spurred on by ecstasy, you shove yourself as far into her as you can manage.  She takes a surprising amount of meat with nary a sputter, merely moaning happily at your pending donation.", false);
			if (player.cumQ() < 100) outputText("  You spurt your seed deep into her throat, marveling at the speed at which she gulps it down.", false);
			else if (player.cumQ() <= 500) outputText("  Warm cum pumps directly into Isabella's throat, bulging her neck slightly as she happily swallows it up.", false);
			else if (player.cumQ() <= 1000) outputText("  Her eyes bulge a bit at the amount of semen you're able to pour into her mouth, bulging both her cheeks and neck as she struggles to keep up with you. She breathes a sigh of relief against your dick after she manages to swallow the stuff.", false);
			else outputText("  Isabella adopts an expression of genuine concern as you cum – and cum – and cum, rope after rope of jism painting the walls of her esophagus.  She can hardly keep up with the sheer amount of semen, and even though she's rapidly swallowing as much as she can, seed still spills from the corner of her mouth and her nostrils.  Finally, your valve shuts, so to speak, and she gulps enough of it to be able to breathe again.  Her belly is noticeably rounded after the fact, but she simply rubs it, seeming mightily satisfied.", false);
			outputText("\n\n", false);
			
			if (isabellaAccent()) outputText("\"<i>Zat vas perfect,</i>\" Isabella moans as she finally pulls her lips away from your still-trembling member.  You smile and dismount, helping her to her feet.  The new addition causes the contents of her stomach to shift again and forces a little burp from her lips.  \"<i>Excuse me,</i>\" she mumbles, and you share a laugh at the whole experience.  With a wink, she walks back to her bunk.  You can feel the effects of Isabella's gas fading, and as you slowly return to normal over the next hour, you contemplate the consequences of feeding her more Pro Bova.  It might be cool...", false);
			else outputText("\"<i>That was perfect,</i>\" Isabella moans as she finally pulls her lips away from your still-trembling member.  You smile and dismount, helping her to her feet.  The new addition causes the contents of her stomach to shift again and forces a little burp from her lips.  \"<i>Excuse me,</i>\" she mumbles, and you share a laugh at the whole experience.  With a wink, she walks back to her bunk.  You can feel the effects of Isabella's gas fading, and as you slowly return to normal over the next hour, you contemplate the consequences of feeding her more Pro Bova.  It might be cool...", false);
		}
		//female: mutual boob suck-a suck-a
		else {
			outputText("Isabella decides to take the initiative, hefting one of your own breasts and dragging it to her mouth.  The feeling of her puffy lips closing around your already-sensitive nipple sets you back on your heels.  Determined to not allow her to get the upper hand, you open wide and engulf her four milk-leaking nubs.  The two of you go at it like a contest, sucking one breast while kneading the other.  Her blush darkens as the showoff continues, but her arousal doesn't really register with you until your thigh brushes against hers.  A ponderous amount of liquid arousal smears against your " + player.skinFurScales() + ".\n\n", false);
		
			outputText("You lower the cow-girl to the ground and follow her down, both of you still enthusiastically suckling.  With her free hand she roams your form, sliding down the contours of your waist and giving your " + player.buttDescript() + " a playful squeeze.  Giving a muffled little groan of satisfaction, you follow suit, slipping a hand down her belly.  Your fingers part her thick, soaking lips and slip inside.  It takes a mere few seconds of tickling her little clitty until it swells into your hand.  Isabella's knees knock together, but her suckling efforts only redouble.\n\n", false);
	
			outputText("She reaches your opening and plunges in, and suddenly the competition's stakes double; first to lactate, and first to cum.  Poor Isabella has the disadvantage of being a cow-girl for longer, however; you can feel her nipples twitching, and you suspect you've won the first leg of the competition.  A gush of warm, creamy milk pumps into your mouth, and you're forced to rapidly swallow to keep up with her spraying mammaries.\n\n", false);
			
			outputText("The lactation seems to be her breaking point, however.  She grinds against your hand a couple of times before cumming, hard.  A torrential wave of girl-cum flows past your fingers to pool on the ground, an ecstatic cry accompanying her orgasm.  You cum soon after, filling both her palm and her cheeks with your orgiastic fluids.\n\n", false);
	
			outputText("A few minutes later both of you stir from your post-orgasmic lethargy, lying in the aftermath of your short-but-sweet adventure.  Without words, Isabella blows a kiss at you and rolls to her feet, shambling back to her bunk.  You lie there for the rest of the hour, feeling the effects of her burpy influence fade slowly away.", false);
		}
	}
	//REPEAT
	else {
		outputText("Flashing a smirk, you beckon her your way, stripping from your " + player.armorName + ".  With delicate and deliberate motions you pull the hem of Isabella's milk-stained blouse down, reaching into the depths of her cleavage and taking hold of her oversized breasts.  It takes effort to heave the heavy, fluid-filled mammaries up and out of her shirt.  Once exposed to the open air, her quadruplet of nipples twitch and stiffen, only swelling further as you alternatingly tease her teats with the edge of your fingernail.  You trace little circles along the areola, running up and over the nubs; your gentle-but-devastating caressing technique sets Isabella all a-shiver, knees knocking together in hardly-contained ecstasy.  If given enough time, you figure you could push the cow-girl to climax merely from nipple stimulation, but your own body demands satisfaction as well.\n\n", false);
		//male
		if (player.hasCock() && (!player.hasVagina() || rand(2) == 0)) {
			outputText("Figuring to put your oversized organ to use, you pull Isabella's tits apart and slap your hard length between them.  As soon as she has figured out your intentions, the cow-girl moves to take over, mashing her pillowy endowments together around your maleness.  Perhaps it was from the gas, but what should be a simple titfuck is driving you insane with pleasure; her warm, sweaty boob flesh contours to the curves of your shaft and head as well as any pussy.  You can't help yourself – you begin to pump your hips, your tip poking out to dance tantalizingly above Isabella's face before withdrawing, only to peek out again seconds later.  The cow-girl smiles and opens wide, her long tongue slithering free from its shelter.\n\n", false);

			outputText("She expertly licks and flicks at the underside of your cock during your next thrust, sending an almost electric current of pleasure through you.  You two find a rhythm quickly, grinding, thrusting, and licking in perfect unison.  As you come closer to orgasm, you begin increasing the pace; your lover is more than happy to match.  Suddenly, Isabella releases her hold on her bosom and instead wraps her arms around your " + player.buttDescript() + ", pulling you toward her and her wide-open mouth. Your legs catch on her boobs, but she doesn't even notice, closing her full lips around as much of your shaft as she can fit.  As good as her warm, wet mouth feels, her tongue demands the majority of your attention.  It besieges your junk completely, wrapping around the shaft, tickling the undercarriage, and even stroking – a perfect prehensile ejaculatory aid.\n\n", false);
			
			outputText("You can't hold out anymore, and Isabella senses it – she even raises her head to make it easier for you to grab hold.  Hot globs of sperm move through your urethra at record speed, and with an urgency spurred on by ecstasy, you shove yourself as far into her as you can manage.  She takes a surprising amount of meat with nary a sputter, merely moaning happily at your pending donation.  ", false);
			if (player.cumQ() < 100) outputText("You spurt your seed deep into her throat, marveling at the speed at which she gulps it down.", false);
			else if (player.cumQ() < 500) outputText("Warm cum pumps directly into Isabella's throat, bulging her neck slightly as she happily swallows it up.", false);
			else if (player.cumQ() < 1000) outputText("Her eyes bulge a bit at the amount of semen you're able to pour into her mouth, bulging both her cheeks and neck as she struggles to keep up with you. She breathes a sigh of relief against your dick after she manages to swallow the stuff.", false);
			else outputText("Isabella adopts an expression of genuine concern as you cum – and cum – and cum, rope after rope of jism painting the walls of her esophagus.  She can hardly keep up with the sheer amount of semen, and even though she's rapidly swallowing as much as she can, seed still spills from the corner of her mouth and her nostrils.  Finally, your valve shuts, so to speak, and she gulps enough of it to be able to breathe again.  Her belly is noticeably rounded after the fact, but she simply rubs it, seeming mightily satisfied.", false);
			outputText("\n\n", false);
			
			if (isabellaAccent()) outputText("\"<i>Zat vas perfect,</i>\" Isabella moans as she finally pulls her lips away from your still-trembling member.  You smile and dismount, helping her to her feet.  The new addition causes the contents of her stomach to shift again and forces a little burp from her lips.  \"<i>Excuse me,</i>\" she mumbles, and you share a laugh at the whole experience.  With a wink, she walks back to her bunk.  You can feel the effects of Isabella's gas fading, and as you slowly return to normal over the next hour, you contemplate the consequences of feeding her more Pro Bova.  It might be cool...", false);
			else outputText("\"<i>That was perfect,</i>\" Isabella moans as she finally pulls her lips away from your still-trembling member.  You smile and dismount, helping her to her feet.  The new addition causes the contents of her stomach to shift again and forces a little burp from her lips.  \"<i>Excuse me,</i>\" she mumbles, and you share a laugh at the whole experience.  With a wink, she walks back to her bunk.  You can feel the effects of Isabella's gas fading, and as you slowly return to normal over the next hour, you contemplate the consequences of feeding her more Pro Bova.  It might be cool...", false);
		}
		//female
		else {
			outputText("Isabella decides to take the initiative, hefting one of your own breasts and dragging it to her mouth.  The feeling of her puffy lips closing around your already-sensitive nipple sets you back on your heels.  Determined to not allow her to get the upper hand, you open wide and engulf her four milk-leaking nubs.  The two of you go at it like a contest, sucking one breast while kneading the other.  Her blush darkens as the showoff continues, but her arousal doesn't really register with you until your thigh brushes against hers.  A ponderous amount of liquid arousal smears against your " + player.skinFurScales() + ".\n\n", false);

			outputText("You lower the cow-girl to the ground and follow, both of you still enthusiastically suckling.  With her free hand she roams your form, sliding down the contours of your waist, giving your " + player.buttDescript() + " a playful squeeze.  Giving a muffled little groan of satisfaction, you follow suit, slipping a hand down her belly.  Your fingers part her thick, soaking lips and slip inside.  It takes a mere few seconds of tickling her little clitty until it swells into your hand.  Isabella's knees knock together, but her suckling efforts only redouble.\n\n", false); 

			outputText("She reaches your opening and plunges in, and suddenly the competition's stakes double; first to lactate, and first to cum.  Poor Isabella has the disadvantage of being a cow-girl for longer, however; you can feel her nipples twitching, and you suspect you've won the first leg of the competition.  A gush of warm, creamy milk pumps into your mouth, and you're forced to rapidly swallow to keep up with her spraying mammaries.\n\n", false);

			outputText("The lactation seems to be her breaking point, however.  She grinds against your hand a couple of times before cumming, hard.  A torrential wave of girl-cum flows past your fingers to pool on the ground, an ecstatic cry accompanying her orgasm.  You cum soon after, filling both her palm and her cheeks with your orgiastic fluids.\n\n", false);
			
			outputText("A few minutes later both of you stir from your post-orgasmic lethargy, lying in the aftermath of your short-but-sweet adventure.  Without words, Isabella blows a kiss at you and rolls to her feet, shambling back to her bunk.  You lie there for the rest of the hour, feeling the effects of her burpy influence fade slowly away.", false);
		}
	}
	doNext(camp.returnToCampUseOneHour);
}

//Get Licked in Return (seems incompatible with centaurs/driders due to lap-sitting)
internal function receiveAllTheCowTOngues():void {
	clearOutput();
	spriteSelect(31);
	outputText("Isabella pulls you up into her lap when you agree.  You recline against her, the two of you sinking into the plush cushions of her big chair; ");
	if (player.tallness <= 78) outputText("you are nearly absorbed by the great big mounds of Isabella's titflesh, sliding between her massive, milky mammaries.");
	else outputText("Isabella nuzzles at your neck, your massive frame nearly crushing her into the chair.");
	outputText("  Gently, the cow-girl slips her arms around your body, walking each of her fingers up your sides to your chest.  She cups your [chest], squeezing and caressing your sensitive flesh.  Her strong fingers sink into your tits until you let out a soft moan, gasping with pleasure as she stimulates your boobs.");

	outputText("\n\nYou feel a surprisingly strong gush of fem-lube trickle out of your [pussy], staining your thighs and running onto Isabella's mottled skin.  Seeing your juices spatter onto her, Isabella gives your tits a particularly rough squeeze and pinches your nipples[if (isLactating = true) , causing a squirt of thick, creamy breastmilk to pour out of you].  ");
	if (isabellaAccent()) outputText("\"<i>I hope you are not zinking about cumming yet, mein friend,</i>\" she chides, kneading your titflesh a little more gently. \"<i>Ve have not even gotten zu ze pussy-licking yet, after all...</i>\"");
	else outputText("\"<i>I hope you're not thinking about cumming yet, [name],</i>\" she chides, kneading your titflesh a little more gently. \"<i>We haven't even gotten to the good part yet...</i>\"");

	outputText("\n\nYou try to restrain yourself, but her ministrations are nearly overwhelming - what else would you expect but the utmost expertise from a cow-girl with such productive teats as Isabella?  As you bite your lower lip, she continues her assault on your [chest]; the brunt of her efforts relocate to your helplessly sensitive nipples, squeezing and pinching[if (isLactating = true) \" until milk flows freely down your chest, giving you a veritable milk-bath\"].  Overwhelmed, you cry and lean back into Isabella's bosom hard enough to make her leak, coating your " + player.skinFurScales() + " in warm milk.");
	
	if (isabellaAccent()) outputText("\n\n\"<i>Mmm, I am zinking zhat is quite enough of zhat,</i>\"");
	else outputText("\n\n\"<i>Mmm, I think that's enough of that!</i>\"");
	outputText(" Isabella says, taking you by the shoulders and, displaying her impressive strength, flips the two of you around, so that you are sitting in her chair and she is atop you.  ");
	if (isabellaAccent()) outputText("\"<i>Time fur ze main course,</i>\"");
	else outputText("\"<i>Time for the main course,</i>\"");
	outputText(" she adds, licking her lips with her big, wide cow-tongue.  She [if (isBiped = true) spreads your [legs]|adjusts your lower body] so that your [pussy] is on display, already drenched with your juices, begging to be filled or pleasured.");

	outputText("\n\nGently, Isabella brings her face just over your groin and begins to blow, making you shiver as a wave of cool air brushes over you.  You gasp and shudder at the slight yet pleasant sensation, and your heart hammers in your chest as Isabella directs another breath to your [clit], washing your pleasure buzzer in warm, forceful air.  Simultaneously, Isabella puts her hands on either side of your cunt, pulling your lips taut - another trickle of fem-lube leaks out of your passage, leaving a stain in the fabric of her chair.");

	outputText("\n\n\"<i>Tsk!  Naughty girl,</i>\" Isabella laughs, even as the absorbent material soaks up the wet spot as if it had never happened.  ");
	if (isabellaAccent()) outputText("\"<i>Ve vill have to teach you to be mindful vhere you leak!</i>\"");
	else outputText("\"<i>Looks like I'll have to teach you to watch where you leak!</i>\"");
	
	outputText("\n\nAs 'punishment', Isabella puts her mouth right up your [pussy] and lets her huge, wide tongue loll out, inches and inches pouring out of her mouth until your twat is covered by the warm, wet muscle.  You groan as Isabella makes a single long, slow lick from bottom to top, dragging her delightfully soft tongue across your sensitive flesh and finishing with a teasing flick across your [clit] that nearly sends you over the edge."); 

	outputText("\n\nYou manage to pry your fingers off the chair's armrests and, as Isabella retracts her tongue, you put both hands on her head and force her back.  The cow-girl goes wide-eyed for a moment, but allows you to guide her face into your twat and obediently begins to lick in earnest.  Isabella's tongue practically flies out of her mouth, slurping across your [pussy].  You groan in abandon as her huge cow-tongue licks your quivering cunt, its wide tip occasionally slipping in past your lips and lapping at your inner walls to send lightning-bolts of pleasure from your groin to your spine, and cry out as she dives into you.");

	outputText("\n\nYou can feel orgasm fast approaching.  Digging your fingers into Isabella's scalp to push her face further into your crotch so that just a little more of her great big tongue can delve into you.  Finally, you feel the very tip of her licker flick against the mouth of your cervix.");

	outputText("\n\nThat touch to your deepest reaches sets you off.  You cry out and cum, clamping down hard on Isabella's head and  tongue so that she cannot pull out, entrapped as you squirt fem-cum onto her face and hair, soaking her in your juices as you buck your hips");
	if (player.clitLength < 1) outputText(", your clit grinding into her nose,");
	outputText(" until you've finally soaked her in enough cum to let her out.");

	outputText("\n\nYou grunt as she exits, but your orgasm carries on and on until you're a half-conscious wreck, writhing in Isabella's chair as the cow looms over you, a self-satisfied grin on her face.  ");
	if (isabellaAccent()) outputText("\"<i>Vell, how vas zhat, [name]?</i>\"");
	else outputText("\"<i>Well, what did you think?</i>\"");
	outputText(" she asks coyly, licking a bit of your femspray off her cheek.");

	outputText("\n\nYou give her a weak thumbs-up before passing out for a quick nap in her comfy chair.");
	if (isabellaAccent()) outputText("  A bit confused, she nonetheless leaves and returns with a drink, setting it beside you before leaving you to your rest.");
	player.orgasm();
	dynStats("sen", -1);
	doNext(camp.returnToCampUseOneHour);
}


//Ey bitch u wan sum fuk? (Or, how Isabella learned to love the dick regardless of size and shape) (Z)
private function fuckIsabella():void {
	clearOutput();
	spriteSelect(31);
	//AREA FOR SCENE ACCESS: (164);
	var x:int = player.shortestCockIndex();
	if (player.cocks[x].cockLength >= 9) x = player.cockThatFits(164);
	var y:int = x + 1;
	
	//{New Option in Isabella's [Sex] Menu: [Fuck Her]} -- Requires sex-ready lust & a cock she is capable of taking
	outputText("You ask Isabella if she wouldn't mind helping you blow off some steam; it's evident for anyone to see that you're flushed with arousal, your [cock " + y + "] straining against the material of your [armor].  Looking at the state of you, Isabella ");
	//[if cock in her size: 
	if (player.cocks[x].cockLength < 9) outputText("pulls your small [cockFit " + y + "] out of your armor, preparing to suck you off as normal.  You grab her shoulders to stop her, more interested in... giving back, this time.");
	else {
		outputText("cocks an eyebrow at you, crossing her arms over her tremendous bust.  \"<i>[name],</i>\" she sighs, ");
		if (isabellaAccent()) outputText("\"<i>I don't know about zhat... I'm more partial to ze cute little cocks... Zey fit me so vell...</i>\"");
		else outputText("\"<i>I don't know about that... You know I like 'em cute and tiny. They just fit me so well...</i>\"");
	}

	//{If cock within her \"<i>I likes me some shota</i>\" range}
	if (player.cocks[x].cockLength < 9) {
		if (isabellaAccent()) outputText("\n\n\"<i>Oh, ja!</i>\"");
		else outputText("\n\n\"<i>Oh, yeah!</i>\""); 
		outputText(" Isabella says, straightening herself up");
		if (player.tallness < 72) outputText(" to tower over your diminutive frame");
		outputText(".  ");
		if (isabellaAccent()) outputText("\"<i>Your tiny little cock ist zo cute, [name], I just couldn't zay no...</i>\"");
		else outputText("\"<i>You've got just the cutest little cock, [name]... how could I say no?</i>\"");
	}
	//{If cock bigger than she likes}
	else {
		outputText("\n\nYou urge her to reconsider, saying you really need to get off, and you're sure she's got some lust built up of her own... \"<i>Eh,</i>\" the big red-head says, looking sharply away.  ");
		if (isabellaAccent()) outputText("\"<i>I zuppose I could do vith some relief of mein own...  Very vell, [name].  Ve vill have zex, you und I.</i>\"");
		else outputText("\"<i>I guess I could do with some relief of my own...  Okay, [name], let's do it.</i>\"");
	}
	outputText("\n\nWith a lusty grin, Isabella reaches behind her back and begins to undo the laces of her corset.  A moment later, and her massive milky mammaries pop free of their restraints, the huge soft orbs jiggling freely with every breath their owner takes.  Your bovine friend quickly pulls you out of your [armor] too, letting you stand naked in the breeze, your [cock " + y + "] hardening at the occasional brush or stroke she gives it.");

	outputText("\n\nOnce denuded, Isabella drops to her knees and cups her huge breasts, hefting them up around your [cock " + y + "].  You shudder as her warm, soft titflesh envelops your prick, ");
	if (player.cockArea(x) < 50) outputText("utterly engulfing your length");
	else outputText("surrounding a fair amount of your massive shaft");
	outputText(".  Slowly, the cow-girl begins to work her tits along your cock, rubbing her smooth, mottled skin up and down, up and down, occasionally venturing to lick you with her huge, wide tongue, nearly wrapping you in wet muscle between strokes of her breasts.");

	outputText("You groan with pleasure and stroke the cow-girl's dark red hair, urging her on and, with a bit of force, controlling her pace, making sure she goes just as fast as you like.  She obliges you, licking and titfucking you to your pleasure until you feel ready to burst; only then do you push her back, roughly putting her on the ground and spreading her thick, cloven legs.");

	if (isabellaAccent()) outputText("\n\n\"<i>Nicht zo rough!</i>\"");
	else outputText("\n\n\"<i>Not so rough!</i>\"");
	outputText(" she cries, but does not hesitate to open her thighs for you and expose her slick cunt and the tight ring of her anus, nearly hidden between her big butt-cheeks.  You set to work on her as soon as you catch sight of her twat, burying your face in her groin and slurping at her slit with your tongue, lapping at the little trickles of girl-lube clinging to her inner walls.  She moans loudly, her high singing voice warbling into a drawn-out \"<i>MOOOOOOOOOOO!</i>\" as your tongue teases and caresses her cherry-nub; she grabs your [hair] and pushes you in further as you begin to suckle her clit.  You continue to lap at her womanhood and its bud until she's leaking everywhere, her pussy positively soaked from your ministrations.  Contented in your efforts, you shove her hands off you and get onto your knees, your [cock " + y + "] flopping heavily onto her wet crotch.");

	outputText("\n\nYou slide your dick across her entrance, coating yourself in her slick lubricants in preparation.  Again the cow-girl bellows loudly as you slip your shaft into her, stretching her pussy-lips into a warm embrace.  ");
	//[(dick fitzwell)
	if (player.cockArea(x) < 80) outputText("Ordinarily tight, Isabella is practically soaked with lube, making the effort to cram your cock into her an easy task; soon your hips are pressed against her raised ass, her thick thighs wrapped around your body.  ");
	outputText("Rearing back, you slam your groin into Isabella's, grinning as she sprays femlube around your prick, obviously enjoying the [cockFit " + y + "] inside her.");

	outputText("\n\nYou pick up the pace, giving her nice, strong thrusts until the ground is sodden with her juices and errant blobs of your pre-cum.  Hardly satisfied by the simple missionary position, though, you grab Isabella by the shoulders and pull her up, latching onto one of her eight large nipples and gulping down a quick-flowing stream of milk.  She groans and moos, stroking your hair as you nurse from her and slam your dick into her at once, giving and taking from the cow-girl until she throws her head back and screams, cumming hard around your dick.  You thrust your way through it, riding out her powerful contractions and bucking until she's panting and heaving, and her flow's dropped to but a trickle in your mouth.");

	outputText("\n\nThat simply won't do.  You twist Isabella around, forcing her onto all fours like the cow she is.  Exhausted from her double-orgasm, she can only grunt in protest as you slide your dick back into her, your hips soon coming to rest against her abundant, cushiony ass.  You plow into her, sinking your fingers into her squishy cheeks as you pound her soaked cunt, her lube and femcum helping you to slam in and out of her at break-pelvis speeds.  She moos, but it turns into a yelp when you shove her face in the ground and yank on her tail, causing her passage to constrict, vice-like, around you.");

	outputText("\n\nSlick and tight, Isabella's cow-cunt is the perfect hole for your needy [cock " + y + "].  You roar and, yanking her tail one last time, cum into her, splattering her innermost depths with your hot baby batter ");
	if (player.cumQ() <= 250) outputText("until you're utterly spent");
	else if (player.cumQ() <= 1000) outputText("until cum spurts out of her passage and stains her thighs");
	else outputText("until her belly begins to bloat with the sheer amount of cream you're stuffing into her");
	outputText(".\n\n");
	outputText("You give Isabella a final swat on the ass, and laugh as the haughty cow-girl collapses in the pool of spunk and femcum you've made beneath her, utterly exhausted.");
	//{If Izzy's favorite cocksize:}
	if (player.cocks[x].cockLength < 9) {
		if (isabellaAccent()) outputText("\n\n\"<i>Zhis is vhy I prefer ze small ones, ja?</i>\" the cow-girl groans happily, scooping a bit of your cum from her cunt and slurping it up.  \"<i>Zo cute, zo small... and yet zo POWERVUL!</i>\"");
		else outputText("\n\n\"<i>That's why I LOVE the tiny ones,</i>\" the cow-girl groans happily, scooping a bit of your cum from her cunt and slurping it up.  \"<i>So small, so cute... but so fucking POWERFUL!</i>\"");
	}
	else {
		if (isabellaAccent()) outputText("\n\n\"<i>Maybe I am wrong about ze big cocks, ja?  Zhat was... You are sehr gut, mein [name].</i>\"");
		else outputText("\n\n\"<i>Gods, was I ever wrong about big cocks.  That was... You're incredible with that thing, [name].</i>\"");
	}
	outputText("\n\nYou grin and rub the big cow's hair before getting dressed.");
	player.orgasm();
	dynStats("sen", -1);
	isabellaKnockUpAttempt();
	doNext(camp.returnToCampUseOneHour);
}

//Isabella at the Farm
//Savin
//Introduction
//(Chance to play when you EXPLORE the farm after Isabella moves to camp)
public function findIzzyMilking():void {
	clearOutput();
	outputText("As you wander around Whitney's farm, your exploration brings you back toward the barn.  Wiping the sweat from your brow after nearly an hour under the hot sun, you lean back against the hard wooden wall to take a breather - only to hear a faint, yet clearly ecstatic, mooing coming from inside.  You step over to the nearest window and, peering inside, are surprised to see a familiar towering cowgirl leaning over a railing, a pair of oversized milkers chugging away at her massive mounds.  Seeing her mooing softly as the milkers suckle the thick cream from her teats soon has you well aroused at the sight... and you think you could give her a sexy surprise while she's getting milked.");
	
	menu();
	flags[kFLAGS.FOUND_ISABELLA_AT_FARM_TODAY] = 1;
	//[Fuck her] [Leave]
	addButton(0,"Fuck Her",fuckIsabellaInTheBarn);
	addButton(4,"Leave",camp.returnToCampUseOneHour);
	  
}

//Fuck Her (Male/Dick'd Herms)
private function fuckIsabellaInTheBarn():void {
	var x:int = player.biggestCockIndex();
	clearOutput();
	outputText("You quietly slip into the barn and make your way over to Isabella's stall.  Silently opening the door, you're afforded a good look at the nude, bent-over cowgirl, your eyes drinking in her lush curves and thick, soft ass - and the glistening pussy between her meaty thighs, slightly parted by a pair of mottle-skinned fingers rubbing and teasing at her big clit.");
	
	outputText("\n\nStripping out of your [armor], you sidle up behind the distracted bovine and grab your " + player.cockDescript(x) + ", giving it a few quiet strokes until it's nice and hard.  Then, with a grin, you let it pop free of your grasp so that it flops down between Isabella's gropable cheeks, quickly buried beneath her yielding flesh.");
	
	outputText("\n\n\"<i>Mooooooo!</i>\" she cries out in alarm, struggling to lean back to see her assailant while tangled up in the milking tubes.  Chuckling, you give her a pat on the ass and tell her to relax...  it's just you.");
	outputText("\n\n");
	if (isabellaAccent()) outputText("\"<i>Ach, [name]?  Vhat do you think you are doing?  Sneaking up on people like zhat...</i>\"");
	else outputText("\"<i>Oh, [name]?  What do you think you're doing, huh?  Sneaking up on people like that...</i>\"");
	outputText("\n\nYou feign an apology, but feeling your dick trapped between her fleshy cheeks, you can't help but rock your [hips] back, slowly hotdogging your [cock] through her butt.");
	if (isabellaAccent()) outputText("\n\n\"<i>Mmm...  Vhat do you zay you help me mit ze milkers...  and I vhon't ask you to stop...</i>\"");
	else outputText("\n\n\"<i>Mmm...  what do you say you help me with a little milking, and I won't ask you to stop...</i>\"");
	
	outputText("\n\nYou quickly agree, and reach around the big cowgirl's shoulders to pull the milker tubes off her breasts, leaning down until your [chest] press");
	if (player.biggestTitSize() < 1) outputText("es");
	outputText(" against her back, your [cock] pushing further and further between her cheeks until you lay hands upon her eight nipples, taking her many buds between your fingers until a hesitant trickle of milk flows forth over your hands, pouring onto the barn floor as you give the cow a more sensual milking.  Your fingers glide across her nipples, going from one large, needy teat to the next, gently caressing her milky breasts until Isabella's head rolls back in a throaty moo, her backside clenching powerfully around your prick.  You let out a low groan, reminded for a moment of your own needs.  You start to move your hips, slowly starting to fuck Isabella's asscheeks as you bury your chin in her shoulder, pressing kisses all along the nape of her neck.");
	
	outputText("\n\nAfter a moment of basking in your affections, Isabella turns and catches you, pressing her lips to yours as one of her powerful arms hooks around your waist.  She opens her mouth, inviting your tongue to enter, playing across her own, inhumanly wide and warm.  You drag your tip across the flat of her tongue, feeling her hot, ragged breath flitting into your throat.  Between movements of your mouth, you reach up to cup Isabella's cheek, brushing away a strand of auburn hair to look into her bright, luminous eyes, each a well of white in the dim barn stall.");
	
	outputText("\n\nShe breaks the kiss, lithe strands of saliva hanging between your lips and hers, still connecting you even as the cowgirl silently mouths, \"<i>I want you....</i>\"  You kiss her again, but this time your hand traces down from her cheek, caressing and cupping every curve as it makes its way down to her thick, fleshy thighs.  Your fingers slide into the tangled red brush between Isabella's legs, the tips just teasing the lips of her womanhood.  She moans into your mouth, her wide tongue slipping past yours as you start to tease her pleasure nub and outer lips, giving her tantalizing bursts of pleasure without the satisfaction of penetration.");

	outputText("\n\nWith each of your movements, Isabella's cheeks clench, tormenting the " + player.cockDescript(x) + " trapped between your belly and her backside.  Your hips move slowly against her, gently pushing into her soft, forgiving flesh before leaning back until just the " + player.cockHead(x) + " remains caught in her tender embrace.  Between kisses and caresses, you hear your love begging for more, for you to slide your thick shaft into her eager hole, but not yet...  not yet...");
	
	outputText("\n\nYou break the long kiss, nuzzling your cheek against Isabella's even as the hand not busy between her legs comes free of her soft breast and gives her a gentle push downward.  The cowgirl looks quizzically at you, but soon yields as you pull her away from the milking machine and onto the ground, getting her onto her hands and knees with you firmly placed behind her.  Your hips rock back, freeing your prick from her lush cheeks as you part them with your hands, revealing her most private parts.  The bovine gasps as your tongue flicks out, running from taint to clit, and lavishing kisses and suckles upon her slick slit as you go.");
	
	outputText("\n\nA throaty moo urges you on as you bury yourself in Isabella's cunt, slipping your tongue tantalizingly past her lips..  only to withdraw and caress her nub instead.");
	if (isabellaAccent()) outputText("  \"<i>I vhant it...  please, [name], do not tease me so...</i>\"");
	else outputText("  \"<i>Come on, [name], give it to me already...  enough with the teasing...</i>\"");
	outputText("  The quivering of her legs only spurs you on, causing you to wet a pair of fingers in her now-dripping cunt before sliding them up her cheeks, to her other, untouched hole.");
	
	outputText("\n\nYour fingers dive in easily, but without warning.  Isabella throws her head back, crying out with surprise and ecstasy.  In an instant, your digits are buried in her up to the last knuckle, easily spreading her asshole apart so that your thumb can plunge in at the same time your whole tongue invades her slit, filling her completely and from two sides.  With your sudden, unexpected double penetration, Isabella's entire body clenches, barely holding back the floodgates.  It takes only a few quick, potent thrusts into her backside to send her screaming over, her operatic voice reverberating through the barn as she climaxes, clenching down hard upon your fingers and tongue.  With a smile, you make to help her through it, roughly finger-fucking her behind as your face is drenched in a liberal coating of femcum.");
	
	//[Next]
	menu();
	addButton(0,"Next",isabellaBarnFuckPartII);
}

private function isabellaBarnFuckPartII():void {
	clearOutput();
	outputText("Isabella collapses, shuddering and twitching after her orally-induced orgasm.  Playfully, you cup a hand around one of her well-milked breasts and roll her over, spreading her furry legs around your hips.  A slight groan escapes Isabella's lips as you loom over her, quickly taking one of her eight needy teats into your mouth.  A stream of ultra-sweet cream pours out at the slightest touch of your tongue, running down your throat just as fast as you can swallow.  The cow never seems to run out as you suckle from her, your head rising and falling with her heaving chest as she recovers from the squirting, thigh-quaking orgasm you just put her through.");
	player.refillHunger(25);
	outputText("\n\nAs you continue to drain mouthful after mouthful of sweet cream from Isabella's full bosoms, you slowly move up on her, letting the crotch of your [armor] brush along the lips of her sodden box.  Isabella shudders, still so very, very sensitive after cumming mere moments before.  Your hand drifts down across your lover's soft, yielding flesh, your knuckles brushing along her supple thighs and many shapely curves before a lone digit comes to circle her prominent cherry nub.  Izzy's head rolls back, her breath catching in her throat as your tip makes a long, sensuous pass over her rose-red clit.  However, before you devolve into another righteous fingerfucking, you withdraw from her wet slit, moving a hand to your [armor] to free your [cock].  With a few quick movements, your fingers are coated in the milky sheen of your [cock smallest]'s drooling excitement.  The throbbing shaft slips out from your grasp and glistens in the light, the underside of your pre-cum smothered tool covering her ready snatch and rubbing against the clit you just finished teasing.");

	outputText("\n\n\"<i>Oh, [name]...</i>\" the cowgirl groans as a single languid movement of your hips brings your [cock smallest] to her eager fuckhole, your crown just passing between her lips to kiss the warm mouth of her cunny.  Isabella takes hold of your shoulders, further burying your face into her pillowy bosom as her fur-covered thighs wrap around your [hips], urging you ever onward, her legs pushing another inch of your prick into her.  You get the hint and start easing into her, letting Isabella's powerful legs guide you in, ushering your [cock smallest] into her warm, welcoming vaginal embrace.");
	//{If small/Isabella-sized cock}
	if (player.cocks[player.smallestCockIndex()].cockLength < 9) {
		outputText("  You slide easily into her, until your [hips] press into Isabella's thighs, your groins joined together.  ");
		if (isabellaAccent()) outputText("\"<i>Mmm, zuch a nice fit,</i>\"");
		else outputText("\"<i>Mmm, that's a nice fit,</i>\"  Isabella sighs, her vaginal muscles gently caressing your shaft.");
	}
	//{If medium cock}
	else if (player.smallestCockArea() < 40) {
		outputText("  Your cock enters her, stretching Isabella's walls apart until your [cock smallest] comes to caress the closed mouth of her cervix, eagerly brushing up against the entrance to her womb.  ");
		if (isabellaAccent()) outputText("\"<i>Ach, so big</i>\"");
		else outputText("\"<i>It's so big,</i>\"");
		outputText(" Isabella grunts, her cunt already working hard to milk your prick.");
	}
	//{If big fucking cock}
	else {
		outputText("  Isabella bites her lip as your oversized prick stretches her wide, whimpering that you'll tear her apart as your [cock smallest] pushes into her womb, her cervical lips clamping hard around your first inches of thick cockflesh.  \"<i>Aaaaahhhhhh, ");
		if (isabellaAccent()) outputText("It iz sehr too big, zo huge?</i>\"");
		else outputText("God it's so huge, I... it's tearing me apart!</i>\"");
	}
	outputText("\n\nOnce you're as far into Isabella as you can go, she relaxes her death grip on your [ass], and you start to move your hips, slowly rocking yourself back and dragging inches of thick cockmeat slowly, tantalizingly out of her.  Isabella moans lewdly, arching her back as you leave her box empty, her inner depths left gaping as you withdraw...  before plunging back in.  She cries out in ecstasy as you hammer back in with a single thrust, throwing yourself ");
	if (player.smallestCockArea() <= 164) outputText("in up to the hilt, smearing her wildly contracting walls with thick smears of leaking pre");
	else outputText("in until your [cock smallest] batters into her womb, thick globs of pre smearing her seed-catcher");
	outputText(".  Your wrap your arms firmly around your lover's shoulders, hugging her tight as you piston your [cock smallest] into her, starting to move harder and faster with each buck of your [hips].  Isabella cries out again, her open mouth a perfect opportunity to slip your tongue in, running the tip along her own's wide, pink surface.  Her lips lock around you, suckling on your tongue as you had on her teats a moment before, tasting herself on you through the kiss.");
	
	outputText("\n\nShe breaks the short kiss for a moment, just long enough to grasp one of her huge, milky jugs and cup it up, letting her lips wrap around one of the little nubs.  You join, taking another of her four teats into your mouth, your lips close enough to touch as you each enjoy the sweet cream flowing freely from her bosom.  With every thrust, though, Isabella's ample chest quivers, boob-quakes rolling across her chest as you hammer her cunt, sending splashes of her vaginal lubricant arcing out even as trickles of milk run freely down her jiggling cleavage.");
	
	if (isabellaAccent()) outputText("\n\n\"<i>Ach, [name], do eet harder!  Fuck me like ze animal I am...");
	else outputText("\n\n\"<i>Oh, [name]!  Fuck me!  Fuck me harder, yeah, just like the animal I am...");
	outputText("  Ahhhh, I'm cumming!</i>\"  You groan as Isabella shrieks her pleasure, her muscles squeezing and milking your [cock smallest] as they contract, her orgasm rocking her entire body, thighs quivering and tits bouncing.  She convulses wildly, screaming as you pound her harder, throwing every last ounce of power you have left into the final seconds until you, too, soar over the edge, the first jets of your hot jizz spurting into her, filling Isabella with your potent seed.  You nearly cry out as waves of orgasmic pleasure crash through your body, setting every nerve afire with an overload of sensation.");
	
	outputText("\n\nIsabella buries her face against your [chest] this time, little gasps and pants shuddering through her as your final erratic thrusts finish inside her, smearing the lips of her cunt with white as you slowly withdraw.  \"<i>");
	if (isabellaAccent()) outputText("[name], zhat was...  ah, [name]");
	else outputText("Oh, wow, [name], that was...  that was incredible!");
	outputText("</i>\" Isabella gasps between ragged breaths.  \"<i>");
	if (isabellaAccent()) outputText("You really know how to please a voman, nein?");
	else outputText("You really know how to show a girl a good time, don't you?");
	outputText("</i>\"");
	
	outputText("\n\nYou laugh, and rest your head in the pillowy warmth of her milk-stained bosom.  You're nearly ready to drift off into a post-coitus drowse when you hear a sharp voice behind you, \"<i>Isabella?  You alright in there?</i>\"");
	
	outputText("\n\nYou look over your shoulders as Whitney throws the door open, her pitchfork at the ready, as if expecting some demon.  You grin sheepishly, your bare [ass] staring the farmer girl right in the face as your trouser snake drips onto the barn floor.  Silently, Whitney turns on a heel and withdraws, closing the door behind her.  A silent moment passes before you and Isabella erupt in laughter, both reaching for your clothes.");
	player.orgasm();
	dynStats("lib", -1, "sen", -3);
	player.changeFatigue(-25);
	isabellaKnockUpAttempt();
	doNext(camp.returnToCampUseTwoHours);
}

//------------
// TALK/PREG
//------------
private function isabellaTalkMenu():void {
	clearOutput();
	outputText("What would you like to discuss with Isabella?");
	if (debug) {
		outputText("\n\n<b><u>DEBUG:</u></b>");
		if (isabellaScene.isabellaOffspringData.length > 0) {
			for (var i:int = 0; i < isabellaScene.isabellaOffspringData.length; i += 2) {
				outputText("\nType: " + isabellaScene.isabellaOffspringData[i] + "; Age: " + (model.time.days - isabellaScene.isabellaOffspringData[i+1]) + " day" + (model.time.days - isabellaScene.isabellaOffspringData[i+1] == 1 ? "" : "s"));
			}
		}
	}
	menu();
	addButton(0, "Just Talk", isabellaScene.talkWithIsabella, null, null, null, "Have a chat with Isabella to pass the time.");
	if (flags[kFLAGS.ISABELLA_COUNTDOWN_TO_CONTRACEPTIONS] == -1) addButton(1, "Contraception", toggleIsabellaContraceptives, null, null, null, flags[kFLAGS.ISABELLA_POTENCY_STATE] == 1 ? "Tell Isabella to start using the contraceptive herbs. This should prevent Isabella from getting pregnancy although it does not cancel any existing pregnancies." : "Tell Isabella to stop using the contraceptive herbs. This will allow you to get her pregnant.");
	if ((isabellaScene.totalIsabellaChildren() > 0 || isabellaScene.pregnancy.isPregnant) && flags[kFLAGS.ISABELLA_COWMOTHER] < 1) addButton(2, "Cowify", isabellaCowifyPrompt, null, null, null, "Ask Isabella if she can turn into something special.");
	addButton(4, "Back", callForFollowerIsabella);
}

public function isabellaTalksAboutPotentialPregnancy():void {
	spriteSelect(31);
	outputText("\nAs you head for your " + (camp.homeDesc() == "cabin" ? "bed" : "sleeping bag") + ", looking forward to the end of another long day, you notice Isabella approaching, seeming strangely nervous for the bovine warrior-woman.  You call out to her in greeting, asking if something is the matter.");
	outputText("\n\n\"<i>Ah, [name], I was hoping to see you.</i>\" She replies.  Nervously looking at the ground, pawing at the dry earth with one cloven hoof, she suddenly blurts out, \"<i>what do you think of children, [name]?</i>\"");
	outputText("\n\nYou look at her in surprise and ask why she is asking you that.  Isabella retains her nervous expression, before awkwardly beginning, \"<i>I... well, I always thought that, one day, I would have a family, but first I had to find a man who was worthy, and then there was the adventuring and... well, I never had the chance before I ended up in this world.  But, now that I have you... I understand that there are many reasons not to, but, if you do want to start a family with me, I am willing. Okay? I just wanted to tell you that, and for you to remember that.</i>\"");
	outputText("\n\nThat said and done, the bovine warrior beats a hasty retreat, allowing you to get to bed.  Admittedly, with something to think over while you sleep.");
	outputText("\n\n<b>You can now talk to Isabella about whether she should be on contraceptives or not.</b>");
	flags[kFLAGS.ISABELLA_COUNTDOWN_TO_CONTRACEPTIONS] = -1;
	flags[kFLAGS.ISABELLA_POTENCY_STATE] = -1; //Indicates she's on contraceptives.
}

private function toggleIsabellaContraceptives():void {
	clearOutput();
	if (flags[kFLAGS.ISABELLA_POTENCY_STATE] == 1) { //Not on contraceptives
		outputText("You tell Isabella that you think maybe it’s best if she starts taking her contraceptives again.");
		outputText("\n\nThe cowgirl nods her head reasonably. \"<i>Da, this makes sense.  It is a hard life we live out here; the times they are too dangerous to reasonably expect you to look after a pregnant woman and then a little baby, yes?");
		if (isabellaScene.totalIsabellaChildren() > 0) outputText(" Besides, we have " + num2Text(isabellaScene.totalIsabellaChildren()) + " small " + (isabellaScene.totalIsabellaChildren() == 1 ? "baby" : "babies") + " to look after already.");
		outputText("</i>\"\n\nYou thank her for understanding, and then head back to the main part of the camp.");
		outputText("\n\n<b>(Isabella can no longer get pregnant.)</b>");
		flags[kFLAGS.ISABELLA_POTENCY_STATE] = -1;
	}
	else { //On contraceptives
		outputText("You tell Isabella that, if she still wants to have a family with you, you would like to be the father of her children.");
		outputText("\n\nIsabella’s face lights up. \"<i>Of course I still want you, silly [man].</i>\" She grabs you in a fierce hug, squeezing you into her breasts so hard that you can feel milk seeping from her eight nipples" + player.clothedOrNaked(" and staining your clothes") + ".");
		if (isabellaScene.totalIsabellaChildren() > 0) outputText("\n\nShe grins at you wickedly. \"<i>" + Num2Text(isabellaScene.totalIsabellaChildren()) + " small " + (isabellaScene.totalIsabellaChildren() == 1 ? "baby" : "babies") + " was not enough, hmm? You are wanting more?</i>\"");
		outputText("\n\nYou just smile at her, enjoy the hug for several moments, then politely wriggle free and excuse yourself.");
		outputText("\n\n<b>(Isabella can now get pregnant.)</b>");
		flags[kFLAGS.ISABELLA_POTENCY_STATE] = 1;
	}
	doNext(playerMenu);
}

private function isabellaCowifyPrompt():void {
	clearOutput();
	if (flags[kFLAGS.ISABELLA_COWMOTHER] == 0) {
		outputText("As you chat to the expectant warrior-woman, you notice an occasional sad expression when she touches her bulging belly, and ask her what the matter is.  “It is nothing, [name].” She replies, at first, but you can tell that’s not the truth and continue probing until she sighs and explains.  \"<i>It is just, well... I am not human any more, but, from what I heard on the plains, my little babies will be human.  I do not regret giving up my humanity, but I do worry sometimes how it will affect them, to have a literal cow-woman like myself for a mother.</i>\"");
		outputText("\n\nYou note that does sound like a bit of a worry, but, well, it’s not as if either of you have a way of changing that.");
		outputText("\n\nIsabella’s face morphs into a strange expression, at once pleased and nervous.  \"<i>Well, that is not entirely true.  You see, I encountered a demon, some time ago in the plains, and after a little... persuasion... they gave me something.</i>\"  She turns and begins rummaging through her chest of belongings, giving you an excellent view of her ass as she does so, before turning back towards you with a tightly-wrapped bundle of dense cloth.  Gingerly she unwraps it, exposing to you a small shard of some crystalline material.");
		if (player.hasKeyItem("Marae's Lethicite") >= 0) outputText("\n\nYou recognize it instantly as a shard of lethicite, though obviously not as powerful as the one you stole from the corrupted goddess.  You tell her that such a crystal could almost assuredly change her into truly being the cowgirl she looks like, and cause that trait to breed true in your children.");
		else outputText("\n\nYou ask what the crystal is.  \"<i>It is called lethicite, and it is the source of the demonic shapeshifting powers.”  Isabella explains.  “I think... I think that, with this, I could make myself truly be what I appear to be, and pass on what I am to our children.</i>\"");
		outputText("\n\nShe looks at you, nervous and uncertain.  \"<i>I...I do not know what would be best for our children, [name]. Tell me, do you think I should use it?</i>\"");
	}
	else {
		outputText("You wonder if you should tell Isabella to use that lethicite on herself...");
	}
	doYesNo(yesToIsabellaTF, noToIsabellaTF);
}

private function yesToIsabellaTF():void {
	clearOutput();
	outputText("You tell Isabella that, after much consideration, you think she should use the lethicite on herself.  After all, didn’t her transformations make her bigger and stronger than any normal human?  While you do seek to topple the lord of the demons, you doubt that will make them all just vanish into the wind, so passing that strength on to her children would be the kindest thing to do.");
	outputText("\n\n\"<i>...I had not thought of that.</i>\" Isabella admits.  She then " + (flags[kFLAGS.ISABELLA_COWMOTHER] == 0.5 ? "retrieves the wrapped bundle from her belongs and opens it before she " : "") + "takes the shard of crystalised soul-stuff in one hand, gently dropping the blankets to the ground next to her hoof.  She wraps her other hand around it and closes her eyes, looking like she is praying, before starting to gently murmur to herself.  You realise that what she’s speaking must be her own language; it expands upon her normal accent and thickens it until you cannot understand a word she is saying.  You idly wonder if maybe she can teach it to you before you are interrupted by a blinding flash of light.  When you can see again, Isabella is blinking her own vision back and opens her hands, revealing nothing.");
	outputText("\n\n\"<i>Well... I guess that is that.</i>\" She declares, giving you a crooked smile.  \"<i>I suppose we will not know if it worked until this little one comes out to say hello.</i>\" She notes, rubbing her swollen midriff.");
	outputText("\n\nYou agree with her, and suggest she have a lie down; that must have drained her, after all.  Isabella looks a little skeptical, but evidently figures that a bit of rest is well-deserved, so she just nods and, awkwardly reclaiming the blanket, heads off to have a nap, leaving you to go away.");
	flags[kFLAGS.ISABELLA_COWMOTHER] = 1;
	doNext(playerMenu);
}

private function noToIsabellaTF():void {
	clearOutput();
	if (flags[kFLAGS.ISABELLA_COWMOTHER] == 0) {
		outputText("You tell Isabella that you think she should stay just the way she is - at least, until you’ve had a chance to think it over.  The bovine braud looks thankful and nods in understanding, wrapping the lethicite back up and putting it away.  You excuse yourself and wander back to your part of the camp, giving the matter some thought.");
	}
	else {
		outputText("You decide that it’s best to leave Isabella the way she is and instead choose to ask her something else.");
		doNext(isabellaTalkMenu);
		return;
	}
	flags[kFLAGS.ISABELLA_COWMOTHER] = 0.5;
	doNext(playerMenu);
}

private function isabellaTakesOviElixir():void {
	clearOutput();
	outputText("(Placeholder) You give a bottle of Ovi Elixir to Isabella. She ingests the contents inside.");
	if (isabellaScene.pregnancy.incubation > 240) isabellaScene.pregnancy.knockUpForce(isabellaScene.pregnancy.type, isabellaScene.pregnancy.incubation - 240);
	else isabellaScene.pregnancy.knockUpForce(isabellaScene.pregnancy.type, 1);
	flags[kFLAGS.ISABELLA_PREGNANCY_BOOSTED] = 1;
	doNext(playerMenu);
}

private function babyMF(male:String, female:String, gender:int):String {
	if (gender == 1) return male;
	else return female;
}

//Isabella Gives Birth!
public function isabellaGivesBirth():void {
	spriteSelect(31);
	var babyGender:int = 0;
	//Decide the gender (If Isabella is a cowmother, human offsprings will always be male. The rest is cowgirls.)
	var babyGenderChooser:int = rand(100);
	if (flags[kFLAGS.ISABELLA_COWMOTHER] < 1) {
		if (babyGenderChooser < 45) babyGender = 1; //It's a BOY!
		else if (babyGenderChooser < 90) babyGender = 2; //It's a GIRL!
		else babyGender = 3; //It's a HERMAPHRODITE!
	}
	else {
		if (babyGenderChooser < 10) babyGender = 1; //It's a BOY! (Human)
		else if (babyGenderChooser < 80) babyGender = 2; //It's a GIRL! (Cowgirl)
		else babyGender = 3; //It's a HERMAPHRODITE! (Cowgirl)
	}
	//Main text
	outputText("\nA loud lowing sound reaches your ears as you prepare to turn in for the night.  It reminds you of a cow in distress, and for a moment  you find yourself wondering where it could be coming from.  Then, logic smacks you right between the ears and you realise what must be happening, which sends you pelting across the camp to Isabella’s \"<i>territory</i>\".");
	outputText("\n\nThere, as you expected, you find the bovine braud leaning against a convenient boulder, stripped naked and with one hand wrapped around her distended midriff.  She sees you and manages to give you a weak smile, but doesn’t bother trying to speak.  Instead, she lets out a very bovine bellow as another contraction hits.  You promptly move to support her, standing behind her and reaching around her as best you can to cuddle and rub and support her overstuffed womb and the frantically wriggling baby doing its level best to leave it.");
	outputText("\n\nFinally, several hours later, Isabella lets out one final bellow of pain and her newborn child slips its way free of her womb and into your waiting arms.");
	if (flags[kFLAGS.ISABELLA_COWMOTHER] < 1) { //Not cowmother
		outputText("\n\nThe wriggling infant you hold in your hands is a beautiful, perfectly formed little human child; a quick look between its legs confirms it is a " + (babyGender == 1 ? "boy" : babyGender == 2 ? "girl" : "hermaphrodite") + ". [He] has your " + player.hairColor + " hair, and you think maybe your eyes, but " + babyMF("his", "her", babyGender) + " skin is " + (rand(2) == 0 ? "warm chocolate brown" : "milky white") + ", like a single-toned version of " + babyMF("his", "her", babyGender) + " mother.  With a paternal smile of adoration, you announce the baby’s gender to Isabella and hand " + babyMF("him", "her", babyGender) + " over.");
		outputText("\n\nIsabella takes " + babyMF("him", "her", babyGender) + " with a smile of motherly delight, already forgetting about the strain of birth now that she can hold her " + babyMF("son", "daughter", babyGender) + ".  \"<i>Isn’t " + babyMF("he", "she", babyGender) + " just beautiful, [name]?</i>\" She asks.  You agree that " + babyMF("he", "she", babyGender) + " is, watching as the delighted new mother puts her new baby to her ever-seeping quad-nipples; the smell of the bountiful milk helps guide the infant to her breast and " + babyMF("he", "she", babyGender) + " is soon sucking away with the greedy enthusiasm of the newborn.  With a soft groan of effort, Isabella sinks to the ground, seating herself against the boulder to nurse her new " + babyMF("son", "daughter", babyGender) + ".");
	}
	else { //COW MOTHER!
		if (babyGender == 1) { //Perfectly normal human baby, always male.
			outputText("\n\nTo your " + (isabellaScene.getIsabellaChildType(IsabellaScene.OFFSPRING_HUMAN_BOYS) > 0 ? "continued" : "") + " surprise, the baby is not a bovine like Isabella, but a perfectly formed and completely human boy.  His skin is pale white, and he seems to take more after you than her, even having your eyes and " + player.hairColor + " hair.  Still you doubt Isabella would ever care; he’s her son, after all.");
		}
		else {
			outputText("The baby is, unsurprisingly, a little cowgirl, just like her mother, with " + (rand(2) == 0 ? "her mom’s milk-white-spotted chocolate skin" : "a strange reversal of her mother’s skin tone, being white with spots of chocolate brown") + ". She doesn’t have horns yet, but you’re certain she’ll grow into them in time, and she already has the bovine ears, tail, and hooved legs of her mother, not to mention the eight tiny little nipples, in two patches of four, that you know will grow into spectacular milky breasts like her mother has. ");
			if (babyGender == 3) outputText("One thing she does have that her mother lacks, however, is a juvenile yet very masculine appendage swinging between her legs.  The shape of it kind of reminds you of a minotaur’s distinctive masculinity, but you quietly confirm that she also has an infantile vagina there as well; she’s a herm.");
		}
		outputText("\n\nWith a paternal smile of adoration, you announce the baby’s gender to Isabella and hand " + babyMF("him", "her", babyGender) + " over.");
		outputText("\n\nIsabella takes " + babyMF("him", "her", babyGender) + " with a smile of motherly delight, already forgetting about the strain of birth now that she can hold her " + babyMF("son", "daughter", babyGender) + ".  “Isn’t " + babyMF("he", "she", babyGender) + " just beautiful, [name]?” She asks. " + (babyGender == 1 ? "\"<i>It’s strange that it didn’t work on him... but he’s just so precious this way.</i>\"" : "") + " You agree that " + babyMF("he", "she", babyGender) + " is, watching as the delighted new mother puts her new baby to her ever-seeping quad-nipples; the smell of the bountiful milk helps guide the infant to her breast and " + babyMF("he", "she", babyGender) + " is soon sucking away with the greedy enthusiasm of the newborn.  With a soft groan of effort, Isabella sinks to the ground, seating herself against the boulder to nurse her new " + babyMF("son", "daughter", babyGender) + ".");
	}
	outputText("\n\nYou gently fetch a blanket for the new mother and " + babyMF("son", "daughter", babyGender) + ", wrapping them both in its warm softness even as Isabella continues to nurse.  You ask if there’s anything else she needs, but the bovine braud simply gives you a blissful smile and shakes her head.  You kiss her gently on the cheek and quietly withdraw to let mother and child bond.");
	//Increment children count
	var offspringType:int = babyGender;
	if (flags[kFLAGS.ISABELLA_COWMOTHER] >= 1 && babyGender >= 2) offspringType += 2;
	isabellaScene.isabellaOffspringData.push(offspringType, model.time.days);
	flags[kFLAGS.ISABELLA_PREGNANCY_BOOSTED] = 0;
	isabellaScene.pregnancy.knockUpForce(); //CLEAR!
}

}
}
