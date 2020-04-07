package classes.Scenes.NPCs 
{
import classes.*;
import classes.BodyParts.Face;
import classes.BodyParts.Tail;
import classes.GlobalFlags.kFLAGS;
import classes.Items.Armor;
import classes.Scenes.SceneLib;

use namespace CoC;

public class SamirahScene extends NPCAwareContent implements TimeAwareInterface {
//SAMIRAH_FOLLOWER flag: 0-4 normal naga to naga scenes, 5 - Samirah 0-100% affection scenes, 6 to 9 - on quest to bring repti-tongue potion, 10 - w obozie
public function samirahAffection(changes:Number = 0):Number {	
	flags[kFLAGS.SAMIRAH_AFFECTION] += changes;
	if (flags[kFLAGS.SAMIRAH_AFFECTION] > 100) flags[kFLAGS.SAMIRAH_AFFECTION] = 100;
	return flags[kFLAGS.SAMIRAH_AFFECTION];
}

//Implementation of TimeAwareInterface
public function timeChange():Boolean {
	return false;
}
public function timeChangeLarge():Boolean {
	if (model.time.hours == 6 && flags[kFLAGS.SLEEP_WITH] == "Samirah" && !prison.inPrison) {
		samirahMorningWakeupCall();
		return true;
	}
	return false;
}
//End of Interface Implementation

public function desertEncounters():void {
	if (flags[kFLAGS.SAMIRAH_AFFECTION] < 20) {
		outputText("You head back into the desert yet again and see the naga from atop a nearby dune slowly trailing off further into the desert. She goes along her way, her body weaving back and forth as if moving to some mysterious beat. As you get closer, you can hear her humming her tune, her motions becoming unlike the last few times, she spots you from far away and slithers up to you. A coy smile lies on her plump lips as she comes close.\n\n");
		outputText("\"<i>Ahh, so you’ve returned, have you~? It’s so nice to be in your gracious company again. I’ve just been meandering, really. The desert nowadays has so few interesting creatures to converse with, save for you of course.</i>\" She idly begins inspecting her nails, her coy smile shifting into an annoyed frown, \"<i>the demons just want to rape, ");
		outputText("the sand witches are too obsessed with refilling their ranks or whatever else it is they’re doing, and the few rare times I find those ant-morphs they just scurry off back into their tunnels! Ugh, you really don’t know how happy I get when I see you.</i>\"\n\n");
		outputText("You can’t help but agree with her sentiment. The desert, as far as you know it, has just been a near constant fight, save for the few times you travel to Tel’ Adre" + (SceneLib.dungeons.checkSandCaveClear() ? " or go to meet the sand witches" : "") + ".\n\n");
		outputText("\"<i>And I really wish those prudes in Tel’ Adre lightened up a little. Even if they don’t want to admit it, they’re as fuck happy as the Sand Witches! Too bad they aren’t so adept at carrying interesting conversation.</i>\"\n\n");
		outputText("Finished with her inspection, she raises her slitted eyes towards your [eyes], a small smile returning to her lips.\n\n");
		outputText("\"<i>But you did not come here in the hopes that I regale you with my gossip. How are you... you know, despite all the times we have met, we still haven’t exchanged names. My name is Samirah Dalijah, but you can just call me Samirah.</i>\"\n\n");
		outputText("You tell her that your name is [name].\n\n");
		outputText("Cradling her head in a hand while propping the arm up with one crossed underneath, she regards you with an amused smile.\n\n");
		outputText("\"<i>That is a strange name for a naga. But you weren’t born one, so an exotic name like that is expected. And now that we have exchanged names...</i>\"\n\n");
		nagaDefaultSexScene();
	}
	else if (flags[kFLAGS.SAMIRAH_AFFECTION] >= 20 && flags[kFLAGS.SAMIRAH_AFFECTION] < 100) {
		outputText("As you explore the desert you run into Samirah atop a nearby dune slowly trailing off further into the desert. She goes along her way, her body weaving back and forth. As you get closer she spots you from far away and slithers up to you. A smiling at the chance to talk to a friendly face.\n\n");
		outputText("\"<i>Good day [name] it's nice of you to visit me all the way in this lost wasteland.</i>\"\n\n");
		outputText("You share with her some stories of your latest adventures the naga listening attentively. Once your done Samirah simply ask you out.\n\n");
		outputText("\"<i>It's been a long and boring day out there and I’m somewhat antsy, are you in the mood for some bonding?</i>\"\n\n");
		menu();
		addButton(1, "Yes", samirahYesSex);
		addButton(3, "No", samirahNoSex);
	}
	else {
		if (flags[kFLAGS.SAMIRAH_FOLLOWER] == 9) {
			outputText("Samirah spots you from a dune and slither over right away.\n\n");
			outputText("\"<i>Have you reconsidered [name]? Would you mind if I came along with you back to your camp? Living in the desert tends to get boring after a while and I would like to stay closer to you from now on.</i>\"\n\n");
			menu();
			addButton(1, "Yes", samirahYesCamp);
			addButton(3, "No", samirahNoCamp);
		}
		else if (flags[kFLAGS.SAMIRAH_FOLLOWER] == 8) {
			outputText("You head back to the desert and quickly spot Samirah sunbathing on a sand dune. She notices you and slithers over to you as you bring the potion to her.\n\n");
			outputText("\"<i>What is this item you brought [name]?</i>\"\n\n");
			outputText("You tell her that this is something that will help her understand the language of the people of Mareth. She doesn’t question you, but simply grabs the potion and chugs it down. It doesn’t seem to have much of an effect on Samirah, which causes her to look at you as if to ask you if this was a joke, when a sand witch pops out of nowhere, asking if she can cast a spell on you. Samirah’s pointed ears twitch as the both of you reply.\n\n");
			outputText("\"<i>No thanks, I know how that whole song and dance ends!</i>\"\n\n");
			outputText("The witch leaves, pissed at your brutal replies, as the both of you look at each other. Samirah looks at you quite surprised.\n\n");
			outputText("\"<i>Wow, it worked! I can understand the two legs now! Thank you [name]. Say, I have been thinking about it and there is something I would like to ask you. You see, this place is kind of desolate and unsafe, even to me, so would you mind if I came along with you this time? Living in the desert tends to get boring after a while and I would like to stay closer to you from now on.</i>\"\n\n");
			menu();
			addButton(1, "Yes", samirahYesCamp);
			addButton(3, "No", samirahNoCamp);
		}
		else if (flags[kFLAGS.SAMIRAH_FOLLOWER] == 6 || flags[kFLAGS.SAMIRAH_FOLLOWER] == 7) {
			outputText("As you explore the desert you run into Samirah atop a nearby dune slowly trailing off further into the desert. She goes along her way, her body weaving back and forth. As you get closer she spots you from far away and slithers up to you. A smiling at the chance to talk to a friendly face.\n\n");
			outputText("\"<i>Good day [name] it's nice of you to visit me all the way in this lost wasteland.</i>\"\n\n");
			outputText("Samirah also ask about the whole deal with the alchemist but for now you have yet to bring something back with you. You share with her some stories of your latest adventures the naga listening attentively. Once your done Samirah simply ask you out.\n\n");
			outputText("\"<i>It's been a long and boring day out there and I’m somewhat antsy, are you in the mood for some bonding?</i>\"\n\n");
			menu();
			addButton(1, "Yes", samirahYesSex);
			addButton(3, "No", samirahNoSex);
		}
		else {
			outputText("You decide to head back into the desert and spot Samirah atop a nearby dune, basking in the golden glow of the sun, her form absolutely radiant. You catch yourself staring just a bit too long and shake yourself from the stupor. Had you wished to take the initiative in this encounter, your previous hesitation has made that all but impossible. Samirah is already making her way towards you. ");
			outputText("A sly grin on her face as she slithers towards her companion. Once she’s near you, she wraps herself and her tail around you in a warm hug.\n\n");
			outputText("\"<i>Welcome back, lover mine~. You were staring for quite a while, [name], but that is to be expected when I am the focus of your attentions.</i>\" She pulls back with a knowing smile on her lips. \"<i>Come to keep little old me company? Between hunting for food and trying to make contact with the natives of this dimension, there is nothing interesting to do. ");
			outputText("I’ve tried holding conversations with the natives recently. Since our talks are so interesting, I hoped that there would be some among their kind that would be the same. But their speech pattern is so strange. How am I supposed to even understand them if they don’t have a tail to begin with?</i>\"\n\n");
			outputText("Wait, not only is there no way that she can be understood by anyone, but she also has absolutely no idea of what people are saying? And what does the tail have to do with how language is perceived?\n\n");
			outputText("\"<i>Of course I can’t understand them! How can they even properly speak without tails? I can guess their mood by their facial expression, but that's about it.</i>\"\n\n");
			outputText("You remember about Rathazul’s knack for alchemy and head home, leaving Samirah to her thoughts as you tell her you're coming back with a solution.\n\n");
			outputText("\"<i>Be safe and come back soon [name]! This desert isn’t the same without you around.</i>\"\n\n");
			flags[kFLAGS.SAMIRAH_FOLLOWER] = 6;
			doNext(camp.returnToCampUseOneHour);
		}
	}
}
public function samirahYesSex():void {
	clearOutput();
	outputText("\"<i>Well now this is perfect. How would you like us to proceed?</i>\"\n\n");
	menu();
	addButton(0, "Like before", nagaDefaultSexScene);
	if (player.hasCock()) {
		addButton(1, "Fuck Her", samirahFuckHer);
		addButton(2, "FuckHerWild", samirahFuckHerWild);
		addButton(3, "Tongue Job", samirahTongueJob);
	}
	if (player.hasVagina()) {
		addButton(4, "Tail Pen", samirahTailPenetration);
		if (player.isNaga() || player.tailType == Tail.DRACONIC || player.tailType == Tail.LIZARD || player.tailType == Tail.SALAMANDER || player.tailType == Tail.CAVE_WYRM) addButton(5, "Twin Tail Fuck", samirahTwinTailFuck);
	}
}
public function samirahNoSex():void {
	clearOutput();
	outputText("You apologize to her but right now you’re really not in the mood. Samirah shrug it off saying that shel find a different way to appease herself. The pair of you separate a while later, you still got more adventures ahead of you.\n\n");
	doNext(camp.returnToCampUseOneHour);
}
public function samirahYesCamp():void {
	clearOutput();
	outputText("The naga smiles, her two snake fang tips showing cutely from under her lips"+(player.isNaga() ? "and her tail entwining with yours" : "")+".\n\n");
	outputText("\"<i>It will be good not to be alone anymore. I do not have any items with me and, truthfully, I don’t need anything from here, so settling down with you should be easy.</i>\"\n\n");
	outputText("She slithers by your side all the way back to your camp.\n\n");
	outputText("(<b>Samirah has been added to the Lovers menu!</b>)\n\n");
	flags[kFLAGS.SAMIRAH_FOLLOWER] = 10;
	doNext(camp.returnToCampUseOneHour);
}
public function samirahNoCamp():void {
	clearOutput();
	outputText("You would prefer her to stay in the desert for now.\n\n");
	outputText("\"<i>I understand, this might be a bit sudden. Take your time to consider it.</i>\"\n\n");
	outputText("You wave goodbye and head back to camp.\n\n");
	if (flags[kFLAGS.SAMIRAH_FOLLOWER] < 9) flags[kFLAGS.SAMIRAH_FOLLOWER] = 9;
	doNext(camp.returnToCampUseOneHour);
}

public function samirahMainCampMenu():void {
	clearOutput();
	if (rand(2) == 0 && flags[kFLAGS.CAMP_UPGRADES_HOT_SPRINGS] >= 4) {
		outputText("Samirah gives you one of her tight naga hugs, saying that the heated pool is a blessing in her eyes. She is the most assiduous user, jumping in during the morning and colder days, unlike most of the camp members who only use it to bathe at nightfall.\n\n");
		outputText("\"<i>It’s really nice to not depend on sunlight to get fully awake, let’s take a bath together sometime, okay?</i>\"\n\n");
		doNext(samirahMainCampMenu2);
	}
	else if (rand(2) == 0 && (player.couatlScore() >= 11 || player.vouivreScore() >= 11)) {
		outputText("Samirah is admiring your wings and body with a star-struck face, almost like a kid seeing the beach for the first time.\n\n");
		outputText("\"<i>Wow... My homeland had legends about winged nagas, but to see one in the flesh, it’s amazing!</i>\"\n\n");
		outputText("You can see her fingers twitching, so you fold your wings into her reach, nodding your permission to touch.\n\n");
		outputText("\"<i>Your "+(player.vouivreScore() >= 11 ? "feathers are so soft" : "scales are so pretty")+", it must be quite the experience to be able to fly...</i>\"\n\n");
		outputText("After she had her fix of your wings, you state what you came for.\n\n");
		outputText("\"<i>Is that so? How can I help you?</i>\"\n\n");
		doNext(samirahMainCampMenu2);
	}
	else if (rand(2) == 0 && flags[kFLAGS.CEANI_FOLLOWER] > 0) {
		outputText("As you go to check on Samirah you notice Ceani are sunbathing next to each other. Samirah heaves a content sigh as Ceani grabs a fish from a nearby bucket and eats it like a snack.\n\n");
		outputText("The two of them notice you and Ceani excuses herself before leaving the both of you in private.\n\n");
		outputText("\"<i>It's a great day to be sunbathing, [name], you should try it.</i>\"\n\n");
		doNext(samirahMainCampMenu2);
	}
	else if (rand(2) == 0 && arianScene.arianFollower()) {
		outputText("Arian and Samirah seem to be in the middle of a conversation on the topic of hypnosis. It seems Samirah’s strange ability caught Arian’s interest and "+(flags[kFLAGS.ARIAN_COCK_SIZE] > 0 ? "he" : "she")+" is not going to let go until "+(flags[kFLAGS.ARIAN_COCK_SIZE] > 0 ? "he" : "she")+" can record everything about it in a book. You interrupt the discussion by coughing, Arian finally taking notice of you\n\n");
		outputText("\"<i>We will continue this conversation later. You are unique in the way that most naga cannot use a common language and I really need to record all of this for posterity’s sake.</i>\"\n\n");
		outputText("Arian departs to "+(flags[kFLAGS.ARIAN_COCK_SIZE] > 0 ? "his" : "her")+" tent leaving you with Samirah.\n\n");
		outputText("\"<i>Well hello, [name], how are you today? Arian is such a good listener.</i>\"\n\n");
		doNext(samirahMainCampMenu2);
	}
	else if (rand(2) == 0 && player.hasStatusEffect(StatusEffects.PureCampJojo)) {
		outputText("You check on Samirah who to your surprise is watching Jojo do his daily set of trainings. She sighs as you come over.\n\n");
		outputText("\"<i>I really don't get what’s so cool about monks. I couldn’t do the crane stance even if I wanted to, mostly because I have no legs.</i>\"\n\n");
		outputText("What about the snake stance?\n\n");
		outputText("\"<i>Well now, that's something I would consider. So tell me [name], did you need anything?</i>\"\n\n");
		doNext(samirahMainCampMenu2);
	}
	else if (rand(2) == 0 && flags[kFLAGS.LUNA_FOLLOWER] >= 4 && flags[kFLAGS.LUNA_FOLLOWER] < 7 && !player.hasStatusEffect(StatusEffects.LunaOff)) {
		outputText("Samirah seems troubled as Luna passes next to her with dirty laundry.\n\n");
		outputText("\"<i>Miss Luna is there any reason why you currently have the smell of a wet dog?</i>\"\n\n");
		outputText("The maid outright jumps as if struck by lightning dropping the laundry to the ground.\n\n");
		outputText("\"<i>Certainly not! You must be mistaking it for that of dog morphs. After working for a few months in Tel’Adre this is a scent that tends to stick to your clothes.</i>\"\n\n");
		outputText("She walk away in a rush leaving you to the naga care.\n\n");
		outputText("\"<i>Well… what an awkward woman. So how can I help you lover?</i>\"\n\n");
		doNext(samirahMainCampMenu2);
	}
	else if (rand(2) == 0 && followerHel()) {
		outputText("You see Samirah about to pounce on Helia, but before you can warn the salamander, the naga already got her in a coil.\n\n");
		outputText("\"<i>You are so warm, can we stay like this for a while?</i>\"\n\n");
		outputText("That went better than you expected, and Helia seems to not care in the least to share her natural fire.\n\n");
		outputText("\"<i>Feel free to enjoy the heat, naga hugs are the best!</i>\"\n\n");
		outputText("Then the pair notice you watching them, beckoning you to join them in their embrace.\n\n");
		outputText("\"<i>Come here lover, there’s always going to be a space for you.</i>\"\n\n");
		outputText("The two scaled females are of the same mind when it comes to you, but you say you want to talk with Samirah, so the salamander decides to set off to the plains.\n\n");
		outputText("\"<i>What a nice girl, I really like her. What do you need me for?</i>\"\n\n");
		doNext(samirahMainCampMenu2);
	}
	else if (rand(2) == 0 && flags[kFLAGS.CHI_CHI_FOLLOWER] > 2) {
		outputText("As you were checking your camp and the people living in, you hear a shout from where Chi Chi usually leaves her dummies.\n\n");
		outputText("\"<i>Stay back! I already know what your intentions are!</i>\"\n\n");
		outputText("The fiery mouse is poised to attack Samirah, who only has eyes for the sources of heat.\n\n");
		outputText("\"<i>I only got coiled around you that one time, I never wanted to hurt you.</i>\"\n\n");
		outputText("Wishing to spare the mouse from further exertion and the naga from getting a whooping, you get Samirah’s attention. She huffs at the mouse who is currently kicking dummies into smithereens.\n\n");
		outputText("\"<i>That one gave me a few hits last time. How was I supposed to know she was still injured if she hides her wounds? Is there something I can do for you?</i>\"\n\n");
		//outputText("\"<i>Well I guess she just don’t like hugs from people other than you [name]. Is there something I can do for you?</i>\"\n\n");post marriage chi chi
		doNext(samirahMainCampMenu2);
	}
	else if (rand(2) == 0 && emberScene.followerEmber()) {
		outputText("You had been searching for Samirah for a chat all over the camp, until you spot her glinting scales by Ember’s cave, seems like she’s trying to get the dragon to answer to her.\n\n");
		outputText("\"<i>I only want to cuddle a little, you body has a pleasant warmth. Let me wrap around you, please?</i>\"\n\n");
		outputText("The proud dragon stays silent, but you can clearly see that Ember keeps stepping back with Samirah’s advances.\n\n");
		outputText("Taking pity on the dragon, you call for the naga, giving Ember a breach to fly away. Samirah pouts at the lost chance, coiling up to face you.\n\n");
		outputText("\"<i>Why is that dragon so resistant? I just want to warm up. Did you call me for help by the way?</i>\"\n\n");
		doNext(samirahMainCampMenu2);
	}
	else if (rand(2) == 0 && (sophieFollower() || bimboSophie()) && flags[kFLAGS.FOLLOWER_AT_FARM_SOPHIE] == 0) {
		outputText("As you walk past the section your harpy lover chose for her nest, you suddenly hear screeching that promise bloody murder, so you rush over to see what happened. It seems that Samirah got too close for the harpy’s liking.\n\n");
		outputText("\"<i>Stay away from my eggs! My chicks aren’t food!</i>\"\n\n");
		outputText("Wow, it’s rare to see Sophie going ballistic, she keeps swooping in circles to make the naga retreat.\n\n");
		outputText("\"<i>I’m not interested in your nest, I just wanted to rest on those rocks.</i>\"\n\n");
		outputText("Samirah slithers away from the furious mama hen and sights you, getting a smile despite the rude treatment she just received.\n\n");
		outputText("\"<i>I’ll keep in mind to keep distance, her talons looked very sharp. Do you have time for a chat?</i>\"\n\n");
		doNext(samirahMainCampMenu2);
	}
	else if (rand(2) == 0 && amilyScene.amilyFollower() && !amilyScene.amilyCorrupt()) {
		outputText("A feeling of dread covers you when you finally figure what was nagging at the back of your mind, and as if on cue, you see the mouse morph run past you, blowpipe on hands as the naga is in a coil behind you.\n\n");
		outputText("\"<i>Why is there a naga here!? We got to make her retreat now, [name]!</i>\"\n\n");
		outputText("You stifle a groan at the situation, jumping on Amily to disarm her while she was focused on Samirah, keeping her pinned and the blowpipe away from reach.\n\n");
		outputText("\"<i>Are you out of your mind [name]?! Give it back!</i>\"\n\n");
		outputText("Samirah just sighs in exasperation. Her eyelids are drooped and her face seems to ask ‘are you an idiot?’ to Amily, making the mouse get pissed off and try to throw you off.\n\n");
		outputText("\"<i>OH! I’ll wipe that look off your face!</i>\"\n\n");
		outputText("You apply a grapple on Amily and convince her, with much difficulty, to blow off steam somewhere else. Samirah thanks you for making the mouse leave her alone, for now.\n\n");
		outputText("\"<i>It seems that she is quite the prejudiced one, I hope she can come around. Can we talk? I want to take my mind off her.</i>\"\n\n");
		doNext(samirahMainCampMenu2);
	}
	else samirahMainCampMenu2();
}
public function samirahMainCampMenu2():void {
	clearOutput();
	outputText("You walk toward Samirah feeling like having some interaction with your reptilian lover today.\n\n");
	if (model.time.hours >= 19) outputText("She's coiled trying to preserve her heat as the last rays of sunlight slowly disappears");
	else outputText("She’s as her usual resting on some warm ground and sunbathing. She opens her eyelids as you approach");
	outputText(".\n\n\"<i>Good ");
	if (model.time.hours >= 19) outputText("evening");
	else outputText((model.time.hours <= 11 ? "morning" : "afternoon"));
	outputText(" [name] how are you doing?</i>\"\n\n");
	menu();
	addButton(0, "Appearance", samirahAppearance).hint("Examine Samirah's detailed appearance.");
	addButton(1, "Talk", samirahMainTalkMenu);
	addButton(2, "Sex", samirahMainSexMenu);
	//addButton(3, "Items", );
	if (flags[kFLAGS.SLEEP_WITH] != "Samirah") addButton(4, "Sleep With", samirahSleepToggle);
	else addButton(4, "Sleep Alone", samirahSleepToggle);
	if (flags[kFLAGS.SAMIRAH_HYPNOSIS] > 0) {
		if (player.isNaga()) addButton(6, "Hypnosis", samirahHypnosisTraining);
		else addButtonDisabled(6, "Hypnosis", "You need a naga body to train into hypnosis...");
	}
	addButton(14, "Back", camp.campLoversMenu);
}

public function samirahAppearance():void {
	clearOutput();
	outputText("Samirah Dalijah is a female naga that stands roughly 5’7 tall on her tail with sun kissed skin with well taken care of shoulder length dark chocolate hair, Samirah’s eyes shimmer like amber her face being more on the rounder side with kissable lips and a cute nose.\n\n");
	outputText("She has D cup breasts with wide hips that are speckled in light yellow scales all over her hips and lower back slowly transitioning to her serpent tail turning into a brighter green which are a mixture of greens, light greenish yellow, and light yellow colored scales with a light sandy colored underbelly.\n\n");
	outputText("Her privates are located at the intersection between her tail and human body hidden inside a cloaca and for all you know it's deep enough your arm could fit inside.\n\n");
	menu();
	addButton(14, "Back", samirahMainCampMenu2);
}

public function samirahMainTalkMenu():void {
	clearOutput();
	outputText("\"<i>What did you want to talk about [name]?</i>\"\n\n");
	menu();
	addButton(0, "Her", samirahTalkHer);
	addButton(1, "Homeworld", samirahTalkHomeworld);
	addButton(2, "Hypnosis", samirahTalkHypnosis);
	if (flags[kFLAGS.SAMIRAH_CLOTHES] < 1) addButton(5, "Clothes", samirahTalkClothes);
	//addButton(6, "Scale color", samirahTalkScaleColor);flags[kFLAGS.SAMIRAH_SCALES]
	addButton(14, "Back", samirahMainCampMenu2);
}
public function samirahTalkHer():void {
	clearOutput();
	outputText("What can she tell you about herself? Actually, why did she come to the hell hole that is Mareth in the first place?\n\n");
	outputText("\"<i>Well it was kind of an accident. Our caravan entered an area of an unstable dimensional rift and got pulled in, I think there was one or two males and a few females with me but we all got separated on our way here. Truth be told, I heard some fell prey to strange magic, got caught by the demons or were changed by the land’s transformatives, turning into different creatures. Of course even amongst the naga exist various subspecies.</i>\"\n\n");
	/*if (meet gorgon) {
		outputText("Now that she mentions it, is it normal for naga to develop petrification powers or even snake hair?\n\n");
		outputText("\"<i>Actually, yes. Albeit uncommon, it can happens to very gifted individuals. The few born within this rare breed have a gaze so strong it turns prey to stone. I guess the snake hair is just a symptom of it.</i>\"\n\n");
	}*/
	outputText("You thank Samirah for her time and go back to your things.\n\n");
	cheatTime2(10);
	doNext(samirahMainTalkMenu);
}
public function samirahTalkHomeworld():void {
	clearOutput();
	outputText("So what does the naga homeworld look like exactly?\n\n");
	outputText("\"<i>I’m from Gobis, a world of sun and sand. Well it’s a large land of sandy dunes with an oasis every now and then. We travel between sandstorms for sustenance and resources, as not to despoil the land of everything. Even then, a naga can survive alone in the Gobis desert for several weeks before running out of water or food.</i>\"\n\n");
	outputText("So, wait, they never experienced any cold weather there?\n\n");
	outputText("\"<i>Of course not! Else we would spend our days hibernating. Nights in the world of Gobis are cold and us naga spend all of it sleeping, otherwise, we would be hunting night and day.</i>\"\n\n");
	cheatTime2(10);
	doNext(samirahMainTalkMenu);
}
public function samirahTalkHypnosis():void {
	clearOutput();
	outputText("You inquire on the nagas’ weird ability to hypnotise their prey. Just how do they do it?\n\n");
	outputText("\"<i>Well that's a weird question [name]. Truth be told holding someone in a trance is as easy for me as breathing is to you, but I think it’s all about maintaining eye contact and using the proper movement. If the target’s will is weak it should be somewhat easy to capture and break.</i>\"\n\n");
	if (player.isNaga()) {
		outputText("You nod, thanking her for the information but ask if she could teach you how to properly use it yourself. Truth be told hypnosis doesn’t seem to be something you can use naturally even as a naga.\n\n");
		outputText("\"<i>Well, now this is odd, I thought you would have figured out by now but I guess since you are a former human you may lack some instinctive knowledge your confused body simply cannot process. In these circumstances I could show you what it is to be a naga.</i>\"\n\n");
		outputText("Samirah gives you the ABC of proper hypnosis, starting with the gaze."+(player.isFemale() ? " You never thought a proper belly dance would help maintain an opponent captive of your gaze either, is the whole thing just about capturing the target attention?" : "")+"\n\n");
		outputText("\"<i>The point is to give a show the target wants to see so to force its gaze toward you and capture it. Once its attention is caught it should be easy for you to maintain it for as long as you want. Once that is done you can do tons of things to your prey and even go so far as to have it do things to you.</i>\"\n\n");
		flags[kFLAGS.SAMIRAH_HYPNOSIS] = 1;
		cheatTime2(20);
	}
	else {
		outputText("You nod, thanking her for the information.\n\n");
		cheatTime2(10);
	}
	doNext(samirahMainTalkMenu);
}
public function samirahTalkClothes():void {
	clearOutput();
	outputText("You inquire on the clothes most naga wear back in her homeworld.\n\n");
	outputText("\"<i>Truthfully, while I normally wouldn’t go naked, this land quickly teaches you it's easier to not wear anything rather than being dressed when it comes down to finding prey. However I still have some clothes from my homeland in my stash at what's left of the caravan. Let me get them for you.</i>\"\n\n");
	outputText("She heads out and comes back an hour later with a large chest. She pulls out several lascivious and colorful dresses clearly made for a naga. The top piece consists of a collar and a black silk bikini connected with a pink veil at the breast intersection. It is accompanied by two sleeves, embellished with golden trim and golden bangles. As you expected it seems to be what you would see on a desert seductress. ");
	outputText("The bottom is similar to a panty of the same design save that it has but a single hole and is made to hang around a naga waist. Around the length of the panty is a pink veil that goes down to what would be the knee on a human body.");
	if (player.isFemale()) {
		if (player.isNaga()) {
			outputText(" Well now that you think of it you are almost jealous. Not to mention that going commando isn’t exactly your style either. Ever since you became a naga you had to go without any form of bottom undergarment. You ask Samirah if she would mind giving you one of these lovely dresses since she has no use for them at the time.\n\n");
			outputText("\"<i>I guess my grounds below to you now hunter. I will have to head out and hunt elsewhere...</i>\"\n\n");
			outputText("Samirah helps you put the dress on, and you got to admit, it indeed looks beautiful on you, even going so far as to put the accent on your assets. Samirah brings out a mirror out of her stash so you can look yourself up.You slither right and left and even dance a little, giggling as you admire yourself. Samirah was right about it, your curves do sure look beautiful. She then stashes the mirror and talks to you about the dress.\n\n");
			outputText("\"<i>The dress is yours, take good care of it.</i>\"\n\n");
			flags[kFLAGS.SAMIRAH_CLOTHES] = 1;
			if (player.armorName == "nothing") {
				player.setArmor(armors.NAGASLK);
				doNext(camp.returnToCampUseOneHour);
			}
			else if (player.armorName != "goo armor") {
				inventory.takeItem(player.setArmor(armors.NAGASLK), camp.returnToCampUseOneHour);
			}
			else {
				player.armor.removeText();
				player.setArmor(armors.NAGASLK);
				doNext(camp.returnToCampUseOneHour);
			}
		}
		else {
			outputText(" Of course despite how nice it would look on you it was made with a snake tail in mind and your current body simply won’t allow you to wear it.");
			cheatTime2(60);
			doNext(samirahMainTalkMenu);
		}
	}
	else {
		cheatTime2(60);
		doNext(samirahMainTalkMenu);
	}
}
public function samirahTalkScaleColor():void {
	clearOutput();
	outputText("\"<i>I guess my grounds below to you now hunter. I will have to head out and hunt elsewhere...</i>\"\n\n");
	outputText("Unlike the last few times, she spots you from far away and slithers up to you.\n\n");
	outputText("\"<i>I guess my grounds below to you now hunter. I will have to head out and hunt elsewhere...</i>\"\n\n");
	outputText("Unlike the last few times, she spots you from far away and slithers up to you.\n\n");
	cheatTime2(10);
	doNext(samirahMainTalkMenu);
}

public function samirahMainSexMenu():void {
	clearOutput();
	outputText("Samirah smile and ask out.\n\n");
	outputText("\"<i>Are you in the mood for some coiling?</i>\"\n\n");
	menu();
	addButton(0, "JustDoIt!!!", nagaDefaultSexScene).hint("Sex scene like at desert before she told her name.");
	if (player.hasCock()) {
		addButton(1, "Fuck Her", samirahFuckHer);
		addButton(2, "FuckHerWild", samirahFuckHerWild);
		addButton(3, "Tongue Job", samirahTongueJob);
	}
	if (player.hasVagina()) {
		addButton(4, "Tail Pen", samirahTailPenetration);
		if (player.isNaga() || player.tailType == Tail.DRACONIC || player.tailType == Tail.LIZARD || player.tailType == Tail.SALAMANDER || player.tailType == Tail.CAVE_WYRM) addButton(5, "Twin Tail Fuck", samirahTwinTailFuck);
	}
	addButton(14, "Back", samirahMainCampMenu2);
}

public function nagaDefaultSexScene():void {
	if (flags[kFLAGS.SAMIRAH_FOLLOWER] >= 10) clearOutput();
	if (player.gender == 1 || (player.gender == 3 && rand(2) == 0)) {
		if (player.cockArea(0) > 35) {
			outputText("The kiss continues as both of your bodies rub together sensually, your tails continuing to wrap around one another. There is a pulsing in your [cock] as it starts to grow hard against Samirah soft belly. Feeling this, Samirah gently pulls away, slowly letting your tongue out of her mouth as she does so. Her hands make their way over your shoulders, down your abs, and stop at your [cocks].\n\n"); 
			outputText("\"<i>You're quite the big boy, aren't you?</i>\" she says as she wraps both of her hands around your now throbbing [cock]. She starts to slide her hands up and down your length. Sticking out her tongue, she wraps it around the tip and licks at the pre that is starting to leak out.\n\n");
			outputText("A hiss of pleasure escapes your lips as Samirah strokes and licks at your [cock], her talented fingers and tongue bringing you into a further state of arousal. Samirah stops her caressing and brings your [cock] to her chest, pressing her breasts around it. She slowly starts to slide her body up and down your shaft, using her tongue to bring some of your pre and lubricate her body. Once she is satisfied with her body's slickness, she quickens her pace.\n\n");
			outputText("You moan in pleasure as Samirah takes the tip of your member into her mouth and starts to suck. You can feel her deft tongue licking every inch of your cock head.\n\n");
			outputText("At your limit, you let out a yell as you cum into her mouth. ");
			if(player.cumQ() > 250) outputText("Her cheeks bulge with the volume and she struggles to swallow as much of it as she can. ");
			if(player.cumQ() > 1000) outputText("Her cheeks bulge out with the sheer volume of your cum and she is forced to release you from her mouth to avoid drowning in your seed. ");
			outputText("You collapse onto the sand and lay there, basking in the warm glow of your orgasm. Samirah slides onto your chest and gives you a kiss. \"<i>I rather enjoyed that,</i>\" she hisses into your ear, \"<i>We should do this more often.</i>\"\n\n");
			outputText("She gives you one last kiss before slithering off"+(flags[kFLAGS.SAMIRAH_FOLLOWER] < 10 ? " into the desert. You watch as she leaves and blow her a kiss goodbye before she disappears from your sight" : "")+".\n\n");
		}
		else {
			outputText("The kiss continues and both of your bodies rub together sensually, your tails continuing to wrap around one another. There is a pulsing in your [cocks] as ");
			if(player.cockTotal() == 1) outputText("it starts ");
			else outputText("they start ");
			outputText("to grow hard against Samirah soft belly. Feeling this, Samirah gently pulls away, slowly letting your tongue out of her mouth as she does so. Her hands make their way over your shoulders, down your abs, and stop at your [cocks].\n\n");
			if(player.cockTotal() == 1) outputText("Gently she starts to stroke the length of your [cock] with one hand while circling the tip with the other. ");
			if(player.cockTotal() == 2) outputText("She takes one in each of her hands and gently strokes them up and down. Every few seconds she stops at the tip to rub her palms over them. ");
			if(player.cockTotal() >= 3) outputText("She takes one in each hand, stroking them slowly and making sure to pay attention to the tip. Every so often she switches to a different dick to make sure that each and every one of your throbbing cocks has some love given to them. ");
			outputText("A hiss of pleasure escapes your lips as Samirah strokes your [cocks], her talented fingers bringing you further into a state of arousal. She stops her caress and brings her hand to a scaly covering at her crotch, spreading it wide to reveal her soft pussy.\n\n");
			if(player.cockTotal() == 1) outputText("She carefully lines it up with your member and starts to tease the tip before gently inserting the first few inches. ");
			if(player.cockTotal() == 2) outputText("She carefully lines it up with both of your members and starts to tease their tips before gently inserting the first few inches. ");
			if(player.cockTotal() >= 3) outputText("She carefully lines it up with one of your members and starts to tease the tip before gently inserting the first few inches. ");
			outputText("She pulls her hips back slightly before pushing them back down, swallowing a bit more of you into her.  As she pulls back the second time, she shifts her arms to rest on your shoulders and grips your back tightly as she pushes you deeper inside of her.\n\n");
			outputText("Every thrust brings you deeper inside of her pussy, its soft walls massaging you. It seems like her pussy managed to swallow your entire cock in no time at all. Samirah pauses for a moment, your hips pressed together, panting. You shift your arms up a little higher to rest at her waist and lower your head to nuzzle at her neck. Samirah leans her head into yours and wraps one of her arms around your head. ");
			outputText("Once more she pulls back her hips before thrusting them back onto your cock. No longer is she slowly bringing you inside her, now she thrusts herself onto you, going faster and faster. Your tails tighten around each other as you reach climax. A sudden yell escapes your throat as you cum inside of her, your tail squeezing hard enough to crush a lesser being. Samirah shudders in your grip as she reaches her own climax. ");
			if(player.cumQ() > 250) outputText("You quickly fill her with your seed to the point where she overflows, leaving her pussy dripping with semen afterwards.");
			else if(player.cumQ() > 1000) outputText("Her stomach quickly swells from the sheer volume of seed pumped into her. The sperm that her womb is unable to hold starts to gush out from her stuffed cunt.");
			outputText("\n\nThe two of you lay there for a moment, basking in the warm glow of orgasm. Eventually Samirah slowly unwraps her tail from your own and gives you a kiss on the forehead. \"<i>I look forward to our next encounter,</i>\" she whispers softly into your ear before slithering off"+(flags[kFLAGS.SAMIRAH_FOLLOWER] < 10 ? " into the desert.  You watch as she leaves and wave her a kiss goodbye before she disappears from your sight" : "")+".\n\n");
		}
		samirahAffection(20);
		player.sexReward("vaginalFluids","Dick");
		doNext(camp.returnToCampUseOneHour);
	}
	else if (player.hasVagina()) {
		outputText("The kiss continues and you can feel your " + breastDescript(0) + " pressing against her own. You kiss her harder, pressing your body as close to her as you can, enjoying the feeling of your two bodies entwined together. You wrap your tail around hers, trying to make every part of your body touch every part of hers. The feeling of her scaled tail rubbing against your body sends shivers of ecstasy down your spine. You pull away from her mouth and move your head to kiss at her neck, ");
		if (player.faceType == Face.SNAKE_FANGS) outputText("carefully nibbling at it so as to not break the skin. ");
		else outputText("nibbling gently at it. ");
		outputText("Traveling down, you pause at her collarbone, letting go of her hips to bring your hands up to her perfectly rounded breasts. A moan escapes Samirah lips as you massage her erect nipples. Your mouth continues its trek down Samirah supple body and you make sure to pause on each breast, circling inward and stopping on each nipple to suck gently on them.\n\n");
 		outputText("Once more your hands move down Samirah body, making their way across her sides as your mouth simultaneously kisses at the smooth flesh of her exposed belly. Goose pimples slowly begin to appear, denoting how much she enjoys it. You pause at her hips, hovering over the slit at her crotch. One of your hands slide down to the slit and you start to stroke at it gently as you kiss at the area around it. Your partner shudders a bit, overcome by the sensations. Slowly you slide a finger into her, hearing a gasp of pleasure as you move it around inside her. ");
		outputText("You twist your fingers deeper inside of her, feeling the moist walls of her love canal press around your finger. Carefully you move your hand and push another of your fingers inside, then a third, moving them to massage her innermost depths. Samirah whole body is shuddering with arousal at your touch. It would be easy enough to bring her to a climax like this, but you decide that you want to make a slight change to the situation.\n\n");
		outputText("You slide your fingers out of her and lift yourself up to look into her flushed face. \"<i>N-no,</i>\" she pants. \"<i>Don't stop... So close...</i>\"\n\n");
		outputText("You place a finger onto her luscious lips. \"<i>Shhhhh,</i>\" you say lovingly. \"<i>All good things must come to an end, but I'm not done yet.</i>\"\n\n");
		outputText("You untangle the end of your tail from hers and bring it up between the two of you, sliding it between your " + breastDescript(0) + " and inserting it sensually into your mouth. You suck on the end, making sure to coat it liberally before bringing it down to Samirah awaiting slit.\n\n");
		outputText("The tip of your tail slides into her soft folds, eliciting a gasp from her. You press further into her, feeling the walls of her pussy tighten over the length of your improvised shaft. Now that you are free of any length constraints, you decide you can now finish her off with the most intense orgasm she has ever had. Your scaly tail slowly crawls inside the depths of your friend, taking its time to tickle every lump, to tease all the sensitive bits while she grips you with all of her strength. Your friend pulls herself to your body, ");
		outputText("hugging you tight and squishing her breasts against your own. She wraps her arms around you, and begins to whisper things into your ear, \"<i>P-please... more... deeper...</i>\"\n\n");
		outputText("You simply run your tongue around her ear, gently nibbling on it as you slowly impale your naga lover on your thick, nimble tail. Her tail whips back and forth across the sand as she slowly succumbs to the intense pleasure of your deep, intimate penetration. You begin to wriggle your own tail inside your naga friend and her response is immediate. First, she shudders as a chill of excitement rushes up her spine. As the sensation overwhelms her, she lets out a wail of satisfaction followed by a series of loud moans in time with your tail's ");
		outputText("various jerks and twists inside her. As Samirah begins to climax, driven over the edge by your tail's intense sensations, her tail begins to flick about wildly. In a stroke of genius, you manage to grab the end of her tail, holding it more or less steady against your own " + clitDescript() + ". As her tail wiggles back and forth, it drives your " + clitDescript() + " insane, rubbing it back and forth over and over again. You prolong your friend's climax by driving your wriggling tail ever deeper inside her and soon you find yourself close to orgasm. ");
		outputText("As you feel your own climax commence, you clench your teeth and lean against your partner, your breasts mashing together and your juices beginning to intermingle. As you both begin to calm down again, chests heaving, the only thing you can think to do is kiss your partner.\n\n");
		outputText("She returns your kiss, but while you are distracted she prepares herself to help you in the same way you helped her. She begins to rub her tail along your " + vaginaDescript(0) + ", getting it wet. As you feel her scaly member begin to slide inside your own " + vaginaDescript(0) + ", the very thought gets you excited. Although somewhat jumpy, she is able to push at a modest rate, slowly inching her tail inside you, very much like the way you did to her. As you continue to passionately kiss each other, ");
		outputText("your tongues wrapping around one another and your arms wrapped around each other's warm bodies, you cannot think of a better place to be. Soon, you and your partner are tail-fucking each other in unison, your lips never parting, your bodies never separating. The both of you collapse upon the sand, too focused on one another to care about the surroundings. That is how it carried on for what seemed like a beautiful, passionate eternity. You wake up several hours later, lying on the sand next to your friend, ");
		outputText("and you can't help but notice how cute she looks asleep. Your tails are still buried within one another, testament to the intensity of your lovemaking. You loved until the both of you collapsed, side by side, juices dripping out into the dry desert sands. You slowly remove your tail from inside her body, and simultaneously pull hers from your " + vaginaDescript(0) + ". You kiss her on the cheek, and are just close enough to hear her whisper, \"<i>Will we ever meet again?</i>\" You lean in close, and whisper a simple \"<i>Yes.</i>\" ");
		outputText("Then, you leave her to her well-deserved rest, and slowly meander back to your camp, your brain still intoxicated with passion.\n\n");
		player.cuntChange(30,true,false,true);
		samirahAffection(20);
		player.sexReward("Default","Vaginal",true,false);
		doNext(camp.returnToCampUseFourHours);
	}
	else {
		outputText("Samirah looks down and suddenly giggles at your stark lack of fun-bits. You turn away in embarrassment and start to head back to your camp.\n\n");
		outputText("\"<i>Wait,</i>\" Samirah reaches out and places a hand on your shoulder. \"<i>I didn't mean to insult you. I've never seen anyone else quite like you.</i>\" She slides her hand down your body. \"<i>I wonder if you can show me just what a body like yours can do.</i>\"\n\n");
		outputText("Enjoying this new shift in the conversation, you coil around her and position your head over the scaly covering over her pussy. A soft hiss escapes Samirah as you slide your tongue into her, twirling it around to caress every inch of her. Her hands make their way to your head and press you deeper into her.\n\n");
		if (1 == 0) outputText("You move your tongue faster and deeper into her pussy, your forked tongue reaching deeper than any human tongue ever could. ");
		else outputText("You move your tongue faster and faster into her pussy, reaching as far in as you possibly can. ");
		outputText("Samirah grips your head tightly to her and suddenly thrusts her hips in orgasm, her girl cum coating your tongue and mouth.\n\n");
		outputText("You uncoil yourself and slowly gather your things, Samirah lying on the sand panting.\n\n");
		outputText("\"<i>We should do this more often,</i>\" she says before you head off.\n\n");
		samirahAffection(20);
		doNext(camp.returnToCampUseOneHour);
	}
}
public function samirahFuckHer():void {
	if (flags[kFLAGS.SAMIRAH_FOLLOWER] >= 10) clearOutput();
	outputText("You gingerly slide one of your fingers inside her, feeling for depth as well as for wetness. Samirah coos softly, unable to withhold her moans.\n\n");
	outputText("\"<i>Please don’t hold back lover, I can barely wait.</i>\"\n\n");
	outputText("You slowly begin moving your fingers in and out of her wet snatch, petting her underbelly with your free hand. You can tell that she is tense; the look on her face is a mix of passion and anticipation. She smiles as you place your warm meaty, [cock] against her belly. She falls still as your length rubs against her. You look deeply into her amber eyes as you wrap your arms around her, and after a moment of hesitation, you kiss her passionately. She relaxes in your arms and returns the kiss, abandoning herself to your will.\n\n");
	outputText("Chills run down your spine as her delicate forked tongue tangles with your own, and you gently press the tip of your [cock] against her scaly, moist pussy-lips. Her tail slowly wraps around your legs as she moans in a soft and vaguely hissing voice. You slowly sink your engorged member into her depths, pausing for a moment to let her adjust to your presence, before beginning to pump away, kissing her passionately as you both get caught up in the wonderful sensations of your intertwined bodies. Her tight passage massages your length, ");
	outputText("and her scaly body rubbing on your skin only encourages you to go further as you rock back and forth in her embrace. You gradually increase your pace, hearing her moans become louder as she moves her hips in time with yours. Your fingers dig into her smooth backside as you continue thrusting into her, pleasure building for what seems like a wonderful eternity. You finally reach your limit, thrusting frantically until you climax, shooting thick ropes of sperm deep inside her as the both of you wail with excitement.\n\n");
	outputText("You slowly untangle yourself from the panting naga and leave her to rest, basking in the warmth of sex and sun.\n\n");
	samirahAffection(20);
	player.sexReward("vaginalFluids","Dick");
	doNext(camp.returnToCampUseOneHour);
}
public function samirahFuckHerWild():void {
	if (flags[kFLAGS.SAMIRAH_FOLLOWER] >= 10) clearOutput();
	outputText("Samirah drapes her arms around your shoulders in a friendly hug, pressing her chest firmly against you. You respond by wrapping your arms around her waist and pulling her closer to you.\n\n");
	outputText("Your snake lover lets out a soft moan and leans her head forward, pressing her lips against yours. You squeeze her body even more firmly in response, the tips of your tails wrapping around one another. You open your mouth and press your tongue against her lips. She offers no resistance and you begin caressing the inside of her mouth with your tongue, circling her fangs as she uses her own tongue to gently stroke your own.\n\n");
	outputText("The kiss continues and both of your bodies rub together sensually, your tails continuing to wrap around one another. There is a pulsing in your [cock] as it starts to grow hard against the naga’s soft belly. Feeling this, Samirah gently pulls away, slowly letting your tongue out of her mouth. As she does so her hands make their way over your shoulders, down your abs, and stops at your [cock].\n\n");
	outputText("Gently she starts to stroke the length of your [cock] with one hand while circling the tip with the other. A hiss of pleasure escapes your lips as the naga strokes your [cock], her talented fingers bringing you further into a state of arousal. She stops her caress and brings her hand to a scaly covering at her crotch, spreading it wide to reveal her soft pussy.\n\n");
	outputText("She carefully lines your member up with her opening and starts to tease the tip before gently inserting the first few inches. She pulls her hips back slightly before pushing them back down, swallowing a bit more of you into her. As she pulls back the second time, she shifts her arms to rest on your shoulders and grips your back tightly as she pushes you deeper inside of her.\n\n");
	outputText("Every thrust brings you deeper inside of her pussy, its soft walls massaging you. It seems like her pussy manages to swallow your entire cock in no time at all. Samirah pauses for a moment, your hips pressed together, panting. You shift your arms up a little higher to rest at her waist and lower your head to nuzzle at her neck. She leans her head into yours and wraps one of her arms around your head. Once more she pulls back her hips before thrusting them back onto your cock. ");
	outputText("No longer is she slowly bringing you inside her, now she thrusts herself onto you, going faster and faster. Your tails tighten around each other as you reach climax. A sudden yell escapes your throat as you cum inside of her, your tail squeezing hard enough to crush a lesser being. The naga shudders in your grip as she reaches her own climax.\n\n");
	outputText("The two of you lay there for a moment, basking in the warm glow of orgasm. Eventually Samirah slowly unwraps her tail from your own and gives you a kiss.\n\n");
	outputText("\"<i>That was wonderful [name], let’s do this more often.</i>\"\n\n");
	samirahAffection(20);
	player.sexReward("vaginalFluids","Dick");
	doNext(camp.returnToCampUseOneHour);
}
public function samirahTongueJob():void {
	if (flags[kFLAGS.SAMIRAH_FOLLOWER] >= 10) clearOutput();
	outputText("As you entangle with Samirah, she lets out a soft moan and leans her head forward, pressing her lips against yours. You squeeze her body even more firmly in response, the tips of your tails wrapping around one another. You open your mouth and press your tongue against her lips. She offers no resistance and you begin caressing the inside of her mouth with your tongue, circling her fangs as she uses her own tongue to gently stroke your own.\n\n");
	outputText("The kiss continues as both of your bodies rub together sensually, your tails continuing to wrap around one another. There is a pulsing in your [cock] as it starts to grow hard against the naga’s soft belly. Feeling this, the naga gently pulls away, slowly letting your tongue out of her mouth. As she does so, her hands make their way over your shoulders, down your abs, and stop at your [cock].\n\n");
	outputText("\"<i>You’re quite the big boy, aren’t you?</i>\" she says as she wraps both of her hands around your now throbbing [cock]. She starts to slide her hands up and down your length. Sticking out her tongue, she wraps it around the tip and licks at the pre that is already starting to leak out.\n\n");
	outputText("A hiss of pleasure escapes your lips as the naga strokes and licks at your [cock], her talented fingers and tongue bringing you into a further state of arousal. The naga stops her caressing and brings your [cock] to her chest, pressing her breasts around it. She slowly starts to slide her body up and down your shaft, using her tongue to bring some of your pre and lubricate her body. Once she is satisfied with her body’s slickness, she quickens her pace.\n\n");
	outputText("You moan in pleasure as the naga takes the tip of your member into her mouth and starts to suck. You can feel her deft tongue licking every inch of your cock head.\n\n");
	outputText("At your limit, you let out a yell as you cum into her mouth. You collapse onto the dirt and lay there, basking in the warm glow of your orgasm. The naga slides onto your chest and gives you a kiss. \"<i>I rather enjoyed that,</i>\" she hisses into your ear, \"<i>We should do this more often.</i>\"\n\n");
	samirahAffection(20);
	player.sexReward("saliva","Dick");
	doNext(camp.returnToCampUseOneHour);
}
public function samirahTailPenetration():void {
	if (flags[kFLAGS.SAMIRAH_FOLLOWER] >= 10) clearOutput();
	outputText("\"<i>Um let's see what I can do… how about this pose first?</i>\"\n\n");
	outputText("The lust within you builds as you view the naga lying slumped on the ground in front of you, her coils twitching and tail tip marking the dirt. Stepping forward, you gather her human half into your arms and she moans softly as your breasts rub against hers. Smiling, you languidly lick her neck, her skin smooth and dry beneath your tongue. Reaching down, you grab the end of her tail and bring it to your dripping pussy, rubbing it back and forth across your entrance. Under your caresses, Samirah rises, slowly circling you, ");
	outputText("winding herself around you again and again as you continue to use her tail tip to stimulate yourself. She comes to a stop, her coils now loosely around half your body, as she once again faces you, her tail twitching hungrily in your grasp. You lean forward to kiss her, caught up in the moment, as Samirah tail twitches out of your grasp and suddenly spears upwards; you gasp and moan in pleasure as it dives into your moist pussy. Once again grinding your body against hers, your stiff nipples rub against one another, ");
	outputText("eliciting more moans from the both of you. Her coils tighten slowly, squeezing your body in a tight hug as her tail thrashes wildly inside you, driving you closer and closer to your limit. With a scream of ecstasy, you climax, your juices spurting out and coating her tail, your arms squeeze her tightly as you continue to cum. Samirah slowly unwinds herself, smiling somewhat shyly at you as you stand there, panting, your moisture on her scales quickly drying under the sun.\n\n");
	outputText("\"<i>I hope you liked it.</i>\"\n\n");
	outputText("That, you sure did!\n\n");
	samirahAffection(20);
	player.sexReward("Default","Vaginal",true,false);
	doNext(camp.returnToCampUseOneHour);
}
public function samirahTwinTailFuck():void {
	if (flags[kFLAGS.SAMIRAH_FOLLOWER] >= 10) clearOutput();
	outputText("Samirah starts by draping her arms around your shoulders in a friendly hug and pressing her chest firmly against you. In response, you slowly wrap your arms around her waist and pull her closer. Samirah’s face is only a few inches away from yours, her tail battering the ground in anticipation as she whispers into your ear.\n\n");
	outputText("\"<i>Feel like resuming where we last left off?</i>\"\n\n");
	outputText("You quickly agree to her idea, letting your hand trail down to her waist line. The fragile balance breaks as she lets out a soft moan and leans her head forward, pressing her lips against yours. You squeeze her body even more firmly against yours in response, the tips of your tails wrapping around one another. You open your mouth and press your tongue against her lips. She offers no resistance and you begin caressing the inside of her mouth with your tongue, circling her fangs as she uses her own tongue to gently stroke your own.\n\n");
	outputText("The kiss continues and you can feel your breasts pressing against her own. You kiss her harder, pressing your body as close as you can, enjoying the feeling of your two bodies entwined together. You wrap your tail around hers, trying to make every part of your body touch every part of hers. The feeling of her scaled tail rubbing against your body sends shivers of ecstasy down your spine. You pull away from her mouth and move your head to kiss at her neck, ");
	outputText("carefully nibbling at it so as to not break the skin. Traveling down, you pause at her collarbone, letting go of her hips to bring your hands up to her perfectly rounded breasts. A moan escapes the naga’s lips as you massage her erect nipples. Your mouth continues its trek down the naga’s supple body and you make sure to pause on each breast, circling inward and stopping on each nipple to suck gently on them.\n\n");
	outputText("Once more your hands move down Samirah’s body, making their way across her sides as your mouth simultaneously kisses at the smooth flesh of her exposed belly. Goosebumps slowly begin to appear, denoting how much she enjoys it. You pause at her hips, hovering over the slit at her crotch. One of your hands slide down to the slit and you start to stroke at it gently as you kiss the area around it. Your lover shudders a bit, overcome by the sensations. Slowly you slide a finger into her, hearing a gasp of pleasure as you move it around inside her. ");
	outputText("You twist your finger deeper inside of her, feeling the moist walls of her love canal press around it. Carefully you move your hand and push another of your fingers inside, then a third, moving them to massage her innermost depths. The naga’s whole body is shuddering with arousal at your touch. It would be easy enough to bring her to a climax like this, but you decide that you want to make a slight change to the situation.\n\n");
	outputText("You slide your fingers out of her and lift yourself up to look into her flushed face. \"<i>N-no,</i>\" Samirah pants. \"<i>Don’t stop... So close...</i>\"\n\n");
	outputText("You place a finger onto her luscious lips. \"<i>Shhhhh,</i>\" you say lovingly. \"<i>All good things must come to an end, but I’m not done yet.</i>\"\n\n");
	outputText("You untangle the end of your tail from hers and bring it up between the two of you, sliding it between your palmable breasts and inserting it sensually into your mouth. You suck on the end, making sure to coat it liberally before bringing it down to Samirah’s awaiting slit.\n\n");
	outputText("The tip of your tail slides into her soft folds, eliciting a gasp from her. You press further into her, feeling the walls of her pussy tighten over the length of your improvised shaft. Now that you are free of any length constraints, you decide you can now finish her off with the most intense orgasm she has ever had. Your scaly tail slowly crawls inside the depths of your lover, taking its time to tickle every lump, to tease all the sensitive bits while she grips you with all of her strength. ");
	outputText("Samirah pulls herself closer to your body, hugging you tight and squishing her breasts against yours. She wraps her arms around you, and begins to whisper things into your ear, \"<i>P-please... more... deeper...</i>\"\n\n");
	outputText("You simply run your tongue around her ear, gently nibbling on it as you slowly impale your naga lover on your thick, nimble tail. Her tail whips back and forth across the sand as she slowly succumbs to the intense pleasure of your deep, intimate penetration. You begin to wriggle your own tail inside your naga friend and her response is immediate. First, she shudders as a chill of excitement rushes up her spine. As the sensation overwhelms her, she lets out a wail of satisfaction followed by a series of loud moans in time with your tail’s ");
	outputText("various jerks and twists inside her. As the naga girl begins to climax, driven over the edge by your tail’s intense sensations, her tail begins to flick about wildly. In a stroke of genius, you manage to grab the end of her tail, holding it more or less steady against your own [clit]. As her tail wiggles back and forth, it drives your [clit] insane, rubbing it over and over again. You prolong your friend’s climax by driving your wriggling tail ");
	outputText("ever deeper inside her and soon you find yourself close to orgasm. As you feel your own climax commence, you clench your teeth and lean against your partner, your breasts mashing together and your juices beginning to intermingle. As you both begin to calm down again, chests heaving, the only thing you can think to do is to kiss your partner.\n\n");
	outputText("She returns your kiss, but, while you are distracted she prepares herself to help you in the same way you helped her. She begins to rub her tail along your [vagina], getting it wet. As you feel her scaly member begin to slide inside your own [vagina], the very thought gets you excited. Although somewhat jumpy, she is able to push at a modest rate, slowly inching her tail inside you, very much like the way you did to her. As you continue to passionately kiss each other, your tongues wrapping around one another and your arms ");
	outputText("wrapped around each other’s warm bodies, you cannot think of a better place to be. Soon, you and your partner are tail-fucking each other in unison, your lips never parting, your bodies never separating. The both of you collapse upon the sand, too focused on one another to care about the surroundings. That is how it carried on for what seemed like a beautiful, passionate eternity. You wake up several hours later, lying on the ground next to your friend, and you can’t help but notice how cute she looks asleep. ");
	outputText("Your tails are still buried within one another, testament to the intensity of your lovemaking. You had sex until the both of you collapsed, side by side, juices dripping out into the ground. You slowly remove your tail from inside her body, and simultaneously pull hers from your [vagina]. You kiss her on the cheek, and are just close enough to hear her whisper. \"<i>No matter how many times we do this it’s always a wonderful experience.</i>\"\n\n");
	outputText("You simply entwine your tail with hers and lay against her for a while, your brain still intoxicated with passion. You wake up an hour later ready to resume adventuring and highly satisfied.\n\n");
	samirahAffection(20);
	player.sexReward("Default","Vaginal",true,false);
	doNext(camp.returnToCampUseFourHours);
}

private function samirahSleepToggle():void {
	clearOutput();
	if(flags[kFLAGS.SLEEP_WITH] != "Samirah") {
		outputText("Samirah sighs in relief.\n\n");
		outputText("\"<i>The nights have been so cold out there [name]. I gladly accept.</i>\"\n\n");
		flags[kFLAGS.SLEEP_WITH] = "Samirah";
	}
	else {
		outputText("Samirah shivers.\n\n");
		outputText("\"<i>It's all fine [name]. I will find some other way to keep myself warm. Thankfully I still have that blanket.</i>\"\n\n");
		flags[kFLAGS.SLEEP_WITH] = "";
	}
	menu();
	addButton(0,"Next", samirahMainCampMenu2);
}
private function sleepWith(arg:String = ""):void {
	flags[kFLAGS.SLEEP_WITH] = arg;
}
public function samirahMorningWakeupCall():void {
	outputText("\n\n");
	outputText("When you wake up you see Samirah’s two snake pupils looking at you with a playful expression mixed with lust. Her body is warm from the morning sun on her scale and skins.\n\n");
	outputText("\"<i>Good morning [name] are you in the mood for a morning treat?</i>\"\n\n");
	menu();
	addButton(0, "JustDoIt!!!", nagaDefaultSexScene).hint("Sex scene like at desert before she told her name.");
	if (player.hasCock()) {
		addButton(1, "Fuck Her", samirahFuckHer);
		addButton(2, "FuckHerWild", samirahFuckHerWild);
		addButton(3, "Tongue Job", samirahTongueJob);
	}
	if (player.hasVagina()) {
		addButton(4, "Tail Pen", samirahTailPenetration);
		if (player.isNaga() || player.tailType == Tail.DRACONIC || player.tailType == Tail.LIZARD || player.tailType == Tail.SALAMANDER || player.tailType == Tail.CAVE_WYRM) addButton(5, "Twin Tail Fuck", samirahTwinTailFuck);
	}
}

public function samirahHypnosisTraining():void {
	clearOutput();
	if (flags[kFLAGS.SAMIRAH_HYPNOSIS] == 6) {
		outputText("Samirah sigh and apologize.\n\n");
		outputText("\"<i>Sorry [name] you already know all I could teach you.</i>\"\n\n");
		doNext(samirahMainCampMenu2);
	}
	else if (flags[kFLAGS.SAMIRAH_HYPNOSIS] == 5) {
		outputText("You proceed to study hypnosis and other mind trick with Samirah and finish today’s session successfully, even managing to get a small lizard that crawled into your camp to look at your eyes for as long as you wished it to, going so far as to pick it up. You thank the naga for her time.\n\n");
		outputText("\"<i>It was nothing really [name] all I did was help you unlock your innate ability as a naga. Use what you learned well.</i>\"\n\n");
		outputText("<b>Learned how to tease using a belly dance.</b>\n\n");
		outputText("<b>Learned Distract.</b>\n\n");
		outputText("<b>Learned Hypnosis.</b>\n\n");
		flags[kFLAGS.SAMIRAH_HYPNOSIS]++;
		doNext(camp.returnToCampUseOneHour);
	}
	else if (flags[kFLAGS.SAMIRAH_HYPNOSIS] == 3 || flags[kFLAGS.SAMIRAH_HYPNOSIS] == 1) {
		outputText("You proceed to study hypnosis and other mind tricks with Samirah and finish today’s session successfully, even managing to get a small lizard that crawled into your camp to look at your eyes for a while. You thank the naga for her time, having learned quite a bit. She couldn't teach you everything yet but you sure are making progress.\n\n");
		outputText("\"<i>It was nothing really [name] all I did was help you unlock your innate ability as a naga. You still need a few more sessions before we are done, thankfully you learn quickly.</i>\"\n\n");
		flags[kFLAGS.SAMIRAH_HYPNOSIS]++;
		doNext(camp.returnToCampUseOneHour);
	}
	else {
		outputText("\"<i>Sorry [name] but you need to let what you have learned sink in before I teach you further.</i>\"\n\n");
		doNext(samirahMainCampMenu2);
	}
}
}
}