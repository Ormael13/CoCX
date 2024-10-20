/**
	 * Anzu the Avian Deity
	 * @author Coalsack
	 */
	package classes.Scenes.Dungeons.AnzuPalace
{
import classes.BodyParts.Tongue;
import classes.CoC;
import classes.GlobalFlags.*;
import classes.Items.*;
import classes.PerkLib;
import classes.Scenes.Dungeons.DungeonAbstractContent;
import classes.StatusEffects;

use namespace CoC;

	public class AnzuScene extends DungeonAbstractContent// implements TimeAwareInterface
	{
		public function AnzuScene()
		{}

		public function anzuAffection(amount:int = 0):int {
			flags[kFLAGS.ANZU_AFFECTION] += amount;
			if (flags[kFLAGS.ANZU_AFFECTION] < 0) flags[kFLAGS.ANZU_AFFECTION] = 0;
			if (flags[kFLAGS.ANZU_AFFECTION] > 100) flags[kFLAGS.ANZU_AFFECTION] = 100;
			return flags[kFLAGS.ANZU_AFFECTION];
		}
		public function anzuRelationshipLevel():int {
			if (flags[kFLAGS.ANZU_RELATIONSHIP_LEVEL] < 1 && flags[kFLAGS.ANZU_PALACE_UNLOCKED] > 0) flags[kFLAGS.ANZU_RELATIONSHIP_LEVEL] = 1;
			return flags[kFLAGS.ANZU_RELATIONSHIP_LEVEL];
		}
		public function anzuSexCounter():int {
			return flags[kFLAGS.ANZU_ANAL_CATCH_COUNTER] + flags[kFLAGS.ANZU_VAGINAL_CATCH_COUNTER] + flags[kFLAGS.ANZU_BLOWN_YOU_COUNTER] + flags[kFLAGS.ANZU_SUCKED_OFF_COUNTER] + flags[kFLAGS.ANZU_ANAL_PITCH_COUNTER] + flags[kFLAGS.ANZU_FED_COUNTER];
		}


		//INTRO
		public function initialPalaceEncounter():void {
			clearOutput();
			outputText("Wandering across the snow and forest covered hills of the Rift, you continue to travel without finding anything of interest. Without warning, a torrential gust of wind nearly blows you over. Taking a moment to orient yourself, you catch your footing, only to see the makings of a blizzard flying in upon the wind. Thinking fast, you search for a place for refuge. A nearby hill covered in thick pines catches your eye. It’s far from ideal, but better than nothing.");
			outputText("\n\nWhen the blizzard settles down, you look towards the horizon, where an exceptionally large hill which you haven’t seen before catches your attention. It looks completely normal, being covered with a forest of snowy pines, but has a strange detail: something that looks like a building is jutting out on one of its sides.");
			outputText("\n\nBewildered, you decide to approach the hill to see it more clearly, holding your [weapon] incase something comes out from the hills. You walk for awhile towards your goal, only to find that the hill in question is farther than you thought. After another hour, your suspicions are confirmed. There’s a building located near the hill’s summit surrounded by a forest. Even from hundreds of meters away it looks like some kind of palace, probably built for giants given its dimensions. Judging by the state of the building, it’s probably inhabited.");
			outputText("\n\nThat’s when you realize that, with the distance you have already walked, you haven’t encountered any enemies. If the palace is inhabited by giants or valkyries, why aren’t there any guards patrolling around it? It’s possible that whatever lives inside could be dangerous enough to scare everything else away from this location.");
			outputText("\n\nWhat should you do?");
			menu();
			addButton(0, "Approach", apporachInitialPalace);
			addButton(1, "Leave", leaveInitialPalace);
		}

		private function apporachInitialPalace():void {
			clearOutput();
			outputText("What could go wrong? You’re the Champion of Ingnam after all. If you’ve survived minotaurs, demons, giants and everything else that Mareth has to offer, whatever lives in that building shouldn’t be a problem if it decides to attack you. ");
			if (flags[kFLAGS.LETHICE_DEFEATED] > 0 || flags[kFLAGS.CORRUPTED_MARAE_KILLED] > 0 || flags[kFLAGS.PURE_MARAE_ENDGAME] > 0) outputText("Even the so-called gods and lords of this land couldn’t stand against your might, so whoever, or whatever who resides there surely won’t be a threat.");
			else outputText("Besides, after the snowstorm, you’ve been frozen to the bones. Hopefully inside will be warmer.");
			outputText("\n\nHiding yourself in the treeline, you approach within a few feet of the building. On a closer inspection, the palace looks to be in good condition. ");
			if (player.inte < 60) {
				outputText("\n\nCourageously, you approach a half open window on one of the sides of the palace and carefully climb through.");
				outputText("\n\nThe inside is cozy, proof that someone was here not long ago. A fireplace warms the interior. Several shelves are placed along the wall, each filled with antique-looking books. The furniture has a peculiar appearance, decorated with patterns and designs you haven’t seen anywhere else in Mareth. Decorations in linen and silk cover the wall, while velvet covered armchairs provide a comfy place for rest, and the floor is decorated with numerous rugs. A staircase leads to the upper floors.");
				outputText("\n\nWhile examining this room, a sudden thundering noise comes from upstairs. Quickly, you run to hide in a dimly lit corner of the main hall, waiting to see who the owner of the palace is. Then the source of said noise comes down the stairs.");
				outputText("\n\nBefore you is a kind of avian, about eighteen feet tall, with an intimidating appearance, and judging by his expression, highly irritated by the discovery that he isn’t alone in his house. Perhaps entering without permission wasn’t the smartest idea…");
				outputText("\n\nUnfortunately, he doesn’t give you much time to think about it, because either your hiding place was terrible, or he has to deal with intruders so often that now he can detect them easily. Before you realize it, the avian approaches you menacingly, and in the blink of an eye, grabs you by the neck and holds you a few feet in the air. He really must hate unannounced visitors. ");
				outputText("\n\n\"<i>What the hell do you think you are doing here?</i>\" demands the avian in an annoyed voice. \"<i>And who are you anyway?!</i>\" ");
				outputText("\n\nHe then releases you, dropping you on the floor.");
				outputText("\n\nMuttering an apology with the air that remains in your lungs, you proceed to introduce yourself and explain how you discovered his house while exploring the hills. Since the palace could be empty, and you were freezing outside, you’ve decided to enter.");
				outputText("\n\n\"<i>Well, that explains your presence here.</i>\" He says, still angry \"<i>But that does not justify the fact you stormed into my home.</i>\"");
				if (player.cor < 66) {
					outputText("\n\nA little ashamed, you tell him that invading his home wasn’t your intention, besides, you hadn’t expected such a violent reaction from him when he saw you.");
					outputText("\n\n\"<i>Maybe I overreacted a little.</i>\"");
				}
				else {
					outputText("\n\nWell, neither is there reason for him to behave like a lunatic and running down the stairs to kill the first living being he sees. But, analyzing the situation more carefully, getting in the bad mood of a guy ");
					if (player.tallness >= 120) outputText("nearly twice");
					else if (player.tallness >= 96 && player.tallness < 120) outputText("twice");
					else if (player.tallness >= 60 && player.tallness < 96) outputText("thrice");
					else if (player.tallness >= 48 && player.tallness < 60) outputText("four times");
					else if (player.tallness >= 40 && player.tallness < 48) outputText("five times");
					else if (player.tallness < 40) outputText("six times");
					outputText(" your size isn’t a great idea.");
				}
				outputText("\n\nNow, you have time to examine him more carefully. Like you thought, he’s about eighteen feet tall, looking pretty much like an anthro bird, with golden-orange hair tipped in red feathers, a head covered in golden and orange feathers in an autumnal pattern, and eyes with turquoise irises and a dark turquoise sclera.");
				outputText("\n\nHis build is strong and imposing, wearing purple robes studded with gold and amethyst. Under his robes he appears to wear a white shirt and brown pants. Judging from the bulge in his pants he is no \"<i>little</i>\" man. On his back he has four wings covered in a pattern of gold, light green, and dark teal feathers with purple feathers on the tips. Behind him, a tail made of a fan of turquoise feathers, equally ending on purple tips, swishes from side to side, while he awaits patiently your answer.");
				outputText("\n\n\"<i>Well, are you going to say something?</i>\"");
				outputText("\n\nYou try to get on his good side, complementing his house and attempting to explain about your quest; making it clear that you didn’t have bad intentions when you entered his palace. While you talk, his initial irritation starts to fade. ");
				outputText("\n\nAfter awhile, he even invites you to sit in one of his armchairs. He proceeds to explain how his full name is Anzu Anunna, formerly, the god protector of the city of Mittani, back in his former world. The fact of encountering ");
				if (flags[kFLAGS.MET_MARAE] > 0) outputText("another god besides Marae ");
				if (flags[kFLAGS.URTA_QUEST_STATUS] >= 1) outputText("and Taoth surprises you");
				else outputText("a god living in this place on Mareth surprises you. Intrigued you ask him more and he explains how, before arriving in Mareth, he was the god of fire and storms in another realm. Anzu talks with you for a while, and before you can realize, its almost night.");
				outputText("\n\nYou excuse yourself, and after apologizing once more, explain how you have go back to your camp before it gets too late.");
				outputText("\n\n\"<i>Your little home invasion wasn’t funny to me. But, I liked having someone over as interesting company for the first time in years. You know [name], you look like a nice " + player.mf("boy", "girl") + ", even though you stormed into my house. Come again later if you want, but next time, use the door,</i>\" Anzu says as he pats your shoulder.");
			}
			else {
				outputText("\n\nWell, if the place is inhabited, storming in would likely leave a bad impression to the palace’s owner, whoever they are.");
				outputText("\n\nWalking towards the palace facade, you easily find the door. It’s huge, about twenty-four feet of solid iron. A little doubtful, you knock the door three times. Initially, it looks like there is no one inside as there is no answer, but soon heavy steps are heard gradually approaching the door.");
				outputText("\n\nA little nervous, you aren’t prepared for what comes out of the door. A kind of anthro bird, about eighteen feet tall, with golden-orange hair tipped in red feathers, a head covered in golden and orange feathers in an autumnal pattern, and eyes with turquoise irises and a dark turquoise sclera, which are staring at you.");
				outputText("\n\nHis build is strong and imposing, wearing purple robes studded with gold and amethyst. Under his robes he appears to wear a white shirt and brown pants. Judging from the bulge in his pants he is no \"<i>little</i>\" man. On his back he has four wings covered in a pattern of gold, light green, and dark teal feathers with purple feathers on the tips. Behind him, a tail made of a fan of turquoise feathers, equally ending on purple tips, swishes from side to side, while he awaits patiently your answer.");
				outputText("\n\n\"<i>Do you have something to say to me, or are you going to keep staring at me for the rest of the day</i>\"");
				outputText("\n\nA little ashamed, you explain how you, while exploring the Rift, were caught in a blizzard . After wandering for a while, you found this place and thought you could rest inside, but when you approached, realized that it was inhabited.");
				outputText("\n\n\"<i>Bad things can happen to anyone. It’s not my fault or my problem. Get lost.</i>\" the avian answers coldly.");
				outputText("\n\nYou tell him that both of you are apparently the only sane beings in the Rift. Most of the creatures outside are hostile or sex-crazy. In a situation like that, you need to protect each other.");
				outputText("\n\n\"<i>Look, " + player.mf("boy", "girl") + " I’m fine. I don’t need the protection of anyone</i>\"");
				outputText("\n\nHmm, looks like this guy has a bit of a temper. Politely, you ask him if he can let you come inside only for a moment to recover heat.");
				outputText("\n\n\"<i>If you’re going to be so insistent, come inside " + (player.tallness < 84 ? "little " : "") + player.mf("boy", "girl") + ". Just don’t break anything</i>\"");
				outputText("\n\nYou thank him, and introduce yourself. The sight of the building’s interior surprises you. Far more extravagant than anything which you would've expected. A fireplace warms the interior. There are several shelves, filled with antique-looking books. The furniture has a particular appearance, decorated with patterns and designs you have not seen anywhere else in Mareth. Decorations in linen and silk cover the walls, while velvet covered armchairs provide a comfy place for rest, and the floor is decorated with numerous rugs. A staircase leads to the upper floors, where the avian was probably resting before you knocked on the door.");
				outputText("\n\n\"<i>Take a seat here, " + player.mf("boy", "girl") + "</i>\" The avian says, pointing at one armchair near the fireplace.. \"<i>If you want to get warm, sit there. You’ll recover from the cold air faster.</i>\"");
				outputText("\n\nYou thank him and realize that you don’t know his name yet.");
				outputText("\n\n\"<i>My name? Well I suppose I can give it. Name’s Anzu, god of fire and storms, and all those things</i>\" He says, waving his hands exaggeratedly.");
				outputText("\n\nA god? Besides Marae " + (flags[kFLAGS.URTA_QUEST_STATUS] >= 1 ? "and Taoth" : "") + ", you haven’t known any deity in Mareth. Incredulous, you ask him again.");
				outputText("\n\n\"<i>An almost empty shell of what once was a mighty god, but technically, I’m still a god.</i>\"");
				outputText("\n\nThat answer was more depressing than you expected. You ask him if he wants to talk for a while. ");
				outputText("\n\n\"<i>I usually don’t have guests.</i>\" Anzu suspires. \"<i>Well, after all this time, a little chat would mean no harm for me.</i>\"");
				outputText("\n\nYou and Anzu talk for a little while. You explain to him that you’re the Champion of Ingnam, and your mission in Mareth. Although a little cold and distant. He begins to open up after a few questions. Anzu explains that his full name is Anzu Annuna, and how he was the protective god of an ancient city called Mittani in a realm very different to Mareth. He was forced to leave his realm after getting into trouble with the rest of the gods in his former home.");
				outputText("\n\nAfter talking about the adventures both of you have experienced in Mareth, you see a lot of time has passed, and probably the best idea would be to go back to the camp.");
				outputText("\n\nYou thank him for letting you in, but explain that it’s time for you to go back to your camp.");
				outputText("\n\n\"<i>[name], it was good to have company for the first time in… years. If you get caught in another snowstorm in the Rift, or simply want to talk, come here again.</i>\"");
			}
			outputText("\n\n<b>Anzu's Palace is now accessible from Dungeons submenu under Places menu.</b>");
			flags[kFLAGS.ANZU_PALACE_UNLOCKED] = 1;
			endEncounter();
		}

		private function leaveInitialPalace():void {
			clearOutput();
			outputText("Well, if this place looks dangerous enough to keep giants away, then it probably means whatever lives here is something that you want to avoid. Since it doesn’t look like an area inhabited by demons, it's none of your business.");
			endEncounter();
		}

		public function anzuTransition():void {
			if (anzuRelationshipLevel() == 1) {
				outputText("Coming back to the avian’s home, you wander around the insides for a while without finding Anzu. When you’re almost leaving, you hear a noise in the upper floor. On the third floor, you quickly recognize the sound of the beating of wings. You go upstairs until reaching the roof. There, you finally spot Anzu, who is flying over the building. When he sees you there, he waves to you. After drawing a few circles in the air, he lands next to you.");
				outputText("\n\n\"<i>So, you came again, " + player.mf("boy", "girl") + ".  Anyway, seeing how this place is the opposite of one of those tents that you have, and since I don’t mind that you rest your butt in my living room, this place was a good opportunity to escape from your camp. Either that or you got caught again by another ‘snow storm’ </i>\"");
				outputText("\n\nPutting aside his joke, a nice and warm spot against the chill Rift is a good place to visit, but actually, you only wanted to spend time with him again. That is, if he has time.");
				outputText("\n\n\"<i>Sure?</i>\" he says, a little surprised by the fact \"<i>Well, it’s not as if I’m expecting someone else. We should get inside.</i>\"");
				outputText("\n\nYou follow him to the living room. There the two of you delight on the heat from the fireplace. After chatting a little about unimportant things, you ask him about what he was doing outside before.");
				outputText("\n\n\"<i>Oh, that. I usually fly around the Rift for keeping my flight abilities in good shape. And, meanwhile I can explore the hills for something interesting. You know, looking for some Jotun or valkyrie that get too close to the palace, or finding a new place for loot or something, things like that. Most of the time I find nothing, today not being the exception.</i>\"");
				outputText("\n\nThat must be disappointing.");
				outputText("\n\n\"<i>Yes, but it’s exercise regardless. It gives me something to do besides reading and practicing alchemy. And how about you, how do you spend your free time in Mareth?</i>\"");
				outputText("\n\nSince your principal task was to protect the portal, and the camp is situated in the barrens, there isn’t much that you can do there. You relate to him about some of your endeavours in the land, fighting monsters in the wilderness and hunting demons across the lands. Judging by the look he gives when you say that, he surely knows how most of the fights in this land end.");
				outputText("\n\n\"<i>And how about your friends? Since you’re wandering here and there, I suppose that you’ve met some interesting people.</i>\"");
				if (player.hasStatusEffect(StatusEffects.TelAdre)) outputText("You tell him about the friends that you’ve made in Tel’Adre." + camp.hasCompanions() ? "You think about all the people you've met and the thought of the friends you've made in your camp come to mind as you talk about them." : "");
				else if (camp.hasCompanions()) outputText("You tell him about the companions in your camp.");
				outputText("After that, you tell him about the adventures that you and your friends had, and how, even in the biggest troubles, the fact that they keep supporting you was the thing that gave you the necessary strength to continue in the fight.");
				if (!player.hasStatusEffect(StatusEffects.TelAdre) && !camp.hasCompanions()) outputText("You tell him about the friends that you had back on Ingnam, and  how you used to spend the afternoons playing and having fun together.");
				outputText("\n\nWhile you explain, Anzu grows uncomfortable as you talk to him more. Seeing his discomfort, you look at him, but he dismisses you and motions to you to keep talking. You finish telling him how much you appreciate their company, and how your life here would be quite boring and depressing if you would’ve spent all this time alone. When your tale ends, you finally ask him if something you said is bothering him.");
				outputText("\n\n\"<i>No, " + player.mf("boy", "girl") + ", it’s nothing.</i>\" He answers with a half-hidden sigh. \"<i>I think that I’ll go get a glass of water. Talking too much makes my mouth dry.</i>\"");
				outputText("\n\nThat sounded like an obvious excuse. Thinking about what could be wrong with him, you follow the avian to the kitchen. When you arrive there, you find Anzu looking at the kitchen’s old window. Looking below at the trees, down the hill, he lets out another sigh.");
				outputText("\n\n\"<i>Sorry. I should’ve offered you a glass of water too.</i>\"");
				outputText("\n\nThat’s not the problem. Looking him in the eyes, you state that you know something is happening to him. Does it have something to do with your recent conversation?");
				outputText("\n\n\"<i>I’m terrible at hiding it, right?</i>\" he says with a forced laugh.\"<i>The truth is, [name], that despite my attempts to prevent the affairs of my situation from affecting me, deep inside I mourn the fact that I spend my exile in near total isolation, since the denizens that wander the Rift aren’t exactly pleasurable company. Maybe I didn’t realize how bad I felt about it until someone came to show me.</i>\"");
				outputText("\n\nYou tell him that wasn’t your intention, making him feel bad. And what he’s saying isn’t hard to understand. After all, fifteen years alone must be a hard time for anyone, even for someone like Anzu.");
				outputText("\n\n\"<i>It wasn’t your fault. Eventually, the years spent alone make me feel worse. I’ve tried to hide it by distracting my mind with books or anything that catches my attention around here. If anything, I can only thank you.</i>\"");
				outputText("\n\nBy what?");
				outputText("\n\n\"<i>For the fact that you keep visiting me. When you arrived here, the truth is that I saw you as another nuisance, not unlike the harassing Jotuns who used to come here from time to time.");
				outputText("\n\nBut, after a few visits, I found myself enjoying your company. Having someone who listens to me and had interesting things to say, I don’t remember how long it’s been since I had someone like you. And, I wish to call you my friend…and make you know that you’re welcome here.</i>\"");
				outputText("\n\nThat shouldn’t be a problem. You and him are friends now, and that’s what friends do.");
				outputText("\n\n\"<i>Friend. It has been centuries since I could call someone else a friend.</i>\" Anzu says wistfully \"<i>[name], I don’t know what to say…But thanks. And I know I’ve said it before, but feel free to come here again. Really. I don’t mind if your house is a dirty shack or anything, but If you want to rest here someday, or have a place to stop when you’re traveling across the Rift, you know where I am.</i>\"");
				flags[kFLAGS.ANZU_RELATIONSHIP_LEVEL] = 2;
			}
			else if (anzuRelationshipLevel() == 2) {
				outputText("Walking around Anzu’s palace, this time you don’t have to search for him, as you find the avian peacefully sleeping on a couch on the living room. Looks like he isn’t using his usual set of clothing, and only has his robes and underwear covering him.");
				outputText("\n\nApproaching him silently, and seeing now an opportunity which you probably won't have again in a long time, your hand slip inside the folds of the soft fabric, reaching to his chest, and without advertence to him, you start tickling his chest and belly. The avian awakens at the sudden touches, and starts laughing at your constant tickling.");
				outputText("\n\n\"<i>[name], what are you…, no… please no…, stop you… \"</i> he only manages to say, in between laughter.");
				outputText("\n\nSeems you caught him by surprise. Anyways, you won’t have mercy on him. Keeping on the ticking, you start stroking with your fingers the soft feathers of his chest and then making them dance over his belly. You continue your assault for several minutes. ");
				outputText("\n\nIt's funny to see the normally quiet avian laugh for a change, even if it is a forced laugh combined with a bit of squirming, and the sensation of his feathers under your fingers is strange and funny in the same way, like caressing one of the parrots who lived back in Ingnam, the only difference is that this is a huge one. Finally, when you think that he’s had enough for a while, you release him for your tickles, and leave him fall on the couch, still laughing a bit.");
				outputText("\n\n\"<i>Oh, thanks.</i>\" he says, sounding relieved. But soon, his tone suddenly changes. \"<i>That was a smart move, attacking when I was asleep, but, being fair, I think that I’ll repay you for this.</i>\"");
				outputText("\n\nWhat?");
				outputText("\n\nCatching you with your guard low, he returns the tickling attack. He, unlike you, takes less time to attack your weak points, and, maybe because the feathers of his wings tickling your back, or his dancing around your body aided by a feather that he took from his tail, in a couple of minutes you’re laughing so hard tears start forming in your eyes. His payback done, he releases you, letting you recover some air. After laughing for a bit, both of you lie on the couch. ");
				outputText("\n\n\"<i>That was...weird</i>\" He states.");
				outputText("\n\nMaybe, but it was fun after all, and, he enjoyed his payback.");
				outputText("\n\n\"<i>Yeah, I suppose. But why the sudden wish to torture me with tickles?</i>\" Anzu asks.");
				outputText("\n\nHe said not long ago that all this loneliness in his palace made him a little depressed, and a couple of tickles cheer up most people.");
				outputText("\n\n\"<i>Well, I definitely feel like I’m in a better mood now.</i>\" ");
				outputText("\n\nWhile you use him as support to stand up, you notice a sudden hardness in his underwear. Looks like the tickling stimulation aroused him enough to make his cock hard. After discovering this, he quickly covers himself with his robes.");
				outputText("\n\n\"<i>[name], sorry. I wasn’t my intention. It was the tickles you know…and the place…Yes, this damn place. In Mareth one can get aroused even from drinking water and…</i>\"");
				outputText("\n\nSeems like the big parrot is somewhat nervous when it comes to sex. Looking at his raging erection, which bulges proudly through his underwear, you think about what you should do next. Maybe Anzu needs some time alone to relieve himself, or maybe you could help him a bit, and with that take your relationship a step further.");
				flags[kFLAGS.ANZU_RELATIONSHIP_LEVEL] = 3;
				doYesNo(anzuRelatLvl3Help, anzuRelatLvl3Dont);
				return;
			}
			else if (anzuRelationshipLevel() == 3) {
				outputText("The familiar warmness of the palace’s interior welcomes you once more. And, again, Anzu isn’t in the living room. Well, this is his house after all, he can wander around the insides as he pleases. Going upstairs, you quickly find him on the third floor.");
				outputText("\n\nAnzu is watching the snowy hills through the window down the hall. Approaching him, you notice that instead of his usual purple robes, he is wearing a violet and blue coat. On the back of the coat, patterns made of gems simulate in some way the constellations, absent on Mareth, that he used to see in the skies of his home world. You attract his attention and greet him, after which you join him at the window.");
				outputText("\n\n\"<i>Hey, [name] I only was watching the view for a while. I’ve heard that in most of Mareth it never rains or snows, but here occasionally we have snow falling. Must be because of the distance from the demonic strongholds. Isn’t too common either. Once or twice every two weeks. </i>\"");
				outputText("\n\nIt’s a good thing that at least there is something like rain here. And with the somewhat less red sky, this place is, despite the cold, a paradise compared to Mareth areas which are at the mercy of demons.");
				outputText("\n\n\"<i>Yeah, in many ways, I’m a lucky guy</i>\" he answers \"<i>By the way, have you realized how the time seems to go slower when snow falls? Seeing how each snowflake falls from the sky until it finds its way to the rest, forming a mantle over the hills. I couldn’t ask for a better view, except of course that of a starry night.</i>\"");
				outputText("\n\nYou ask him if that has something to do with his current suit.");
				outputText("\n\n\"<i>Oh, you’ve noticed it.</i>\" he says. \"<i>Well, [name], this is nothing less than the suit that I used as a member of the Council of the Annuna. The official attire. Recently I found it on a pile of clothes in the vaults of the palace. I used to wear it only in formal occasions but, since has been a while, I felt a little nostalgic about the good times that I had there.</i>\"");
				outputText("\n\nLooks like even with the bad things which happened to him in Mittani, Anzu still has good memories from his home. And he has stayed away a long time, but exactly, how bad has it been for him? Since he has lived many centuries, the time passed here shouldn’t be too long.");
				outputText("\n\n\"<i>You may think that for someone who has lived as long as me fifteen years is nothing, but the fact is, the time is capricious with you. When you are in lost in happiness and pleasure, the days, months, even the years pass easily, and the time slips between your fingers like water. In the other hand, when you are stressed, desolated, or, like on my case, alone, the time seems to advance slower every second that passes.");
				outputText("\n\nThat was until you arrived of course. The first friend that I had in…centuries. An unexpected gift who found its way to my home, and when I found it, I realized that it was the best gift which I could have received.");
				outputText("\n\nWandering around the Rift, I’ve thought how in the world I met a " + player.mf("boy", "girl") + " like you, and how empty my life would feel without a friend like you. I used to daydream about how things could have been if I had been more successful on my attempt to take over my world. That did me no good, because the more I thought about it, the more depressed I felt. But your mere presence and company here have made my exile much less lonely, and your friendship was the thing that made me almost forget all the bad things that have happened to me, and to embrace my life here.</i>\"");
				outputText("\n\n\"<i>[name], you’ve truly been the best friend I could asked for. But lately, each time that you visit me, I’ve started to feel different. I don’t know how to say it…This is the first time on my entire existence I’ve felt like this. Well, I think that I…</i>\"");
				outputText("\n\nYes?");
				outputText("\n\n\"<i>I think that even after we are friends and all, and the fact of we don’t mind…em...relieving pressure, together…</i>\"");
				outputText("\n\nOh, you’re understanding the way of he’s going. After a few doubts, he puts his hand on yours and finally says:");
				outputText("\n\n\"<i>I think… I now think of you as more than a friend. You see…despite being a god, sometimes I could be a little unsure, and explaining this kind of thing is difficult for me, but…I think, no, I’m sure what I feel about you is not only friendship, because, [name], I think that I’ve fallen in love with you. ");
				outputText("\n\nI know how things are, if you don’t feel that, or if I’m being too pushy…I’ll understand it. But please, say to me what you feel about me.\"</i>");
				flags[kFLAGS.ANZU_RELATIONSHIP_LEVEL] = 4;
				doYesNo(anzuRelatLvl4Sex, anzuRelatLvl4Dont);
				return;
			}
			doNext(anzuMenus);
		}
		private function anzuRelatLvl3Help():void {
			clearOutput();
			outputText("What kind of friend would leave him to suffer alone? You tell him that he has no reason to be ashamed. In fact, you’d like to help him to get some release.");
			outputText("\n\n\"<i>What? No [name]. I couldn’t ask you such a thing. Well, we’re friends and all, but this is asking too much...</i>\"");
			outputText("\n\nFriends help each other, right? And it was the fault of your tickle attack after all. What could happen to him if he wanders outside in that state? Would you let your friend, weakened by lust, get ravaged by a Jotun or a yeti in the wilderness?");
			outputText("\n\n\"<i>You don’t have to do it, " + player.mf("boy", "girl") + ". I’ll jerk off in the bath for a while and I’ll be good.</i>\"");
			outputText("\n\nAnswering him that he shouldn’t have any reason to feel embarrassed, you state to him that he’s your friend, and you really want to help him. With all the time that you’ve spent close, in a land like this, it's normal for a couple of friends to release their mundane desires together, especially if one of them hasn’t anyone else to help.");
			outputText("\n\n\"<i>Well, I haven’t said this to you before, but the idea of you and me...you know, doing things together...doesn’t sound too bad. In fact, I’d like to try it... If you agree, of course.</i>\"");
			outputText("\n\nThen, if both of you are okay with it, why don’t start already? You motion to Anzu, who quickly strips away his underwear, revealing the forty-inch monster between his legs. The years spent alone probably made his libido get high enough to make him antsy at the promise of some release in the hands of another.");
			outputText("\n\nBoth of you recline on the couch. with your body resting over Anzu’s huge frame. Not wishing to make him wait much longer, you put your hand on one of his balls, softly caressing the feathers on the huge nut, which is already pulsating in expectation of a prompt release. Your free hand finds its way to the other, and soon you’re feeling the cum in them ready to go outside. ");
			outputText("\n\nSatisfied with the foreplay, you put one hand on the base of Anzu’s meat and start pumping it. Your other hand goes to the tip, and, taking some of the pre, which is dribbling from it, smears it over the sides of his cock. Then it joins your other hand, jerking off the sides of his shaft.");
			outputText("\n\n\"<i>[name], you are incredible. If you keep doing that this way, I’ll…</i>\"");
			outputText("\n\nHe hasn’t enough time to finish, because soon your efforts drive him to orgasm. His cock wildly twitches, releasing jet after jet of cum into the air. The seemingly unending flow of semen covers both of your hands and Anzu’s belly.");
			outputText("\n\nSeeing the sticky mess all over him, the avian laughs and takes a little onto his fingers, licking it. Following his example, you dance your tongue across his belly feathers, licking clean the cum from his chest and belly, and swallowing the remaining semen from your hands. When your finish, he takes you in his arms with a soft hug.");
			outputText("\n\n\"<i>Hey [name], thanks for that.</i>\" Anzu says with a soft smile. \"<i>You have no idea of how long I’ve waited for someone to do that with me.</i>\"");
			outputText("\n\nYou answer him that there’s nothing to thank you for. After all what’s giving a simple handjob to one of your closest friends? You’ll do it again for him, or even more.");
			outputText("\n\n\"<i>No, " + player.mf("boy", "girl") + ", I really appreciate it.</i>\" he replies \"<i>But overall, I want to thank you for being my friend. I’ve spent so many years alone here without a true friend .Even before I arrived, I had few people who I could call my real friends. For me, you’re one of them. Even with the weird traveling geography of Mareth, traveling to here must be a nuisance, and you keep visiting me.");
			outputText("\n\nYou’re the first one to have real interest in listening to me in hundreds of years. And I’ve got to say without you, the afternoons sometimes get really lonely.</i>\"");
			outputText("\n\nThe avian keeps you in his embrace for a while. You put your head on his chest and hear the soft pulse of his heart. Four wings surround your back, caressing you softly with their long feathers. You drift to sleep in your friend’s arms.");
			outputText("\n\nWhen you’re awake, you found yourself resting on the couch, with a now fully dressed Anzu flexing his arms near you.");
			outputText("\n\n\"<i>Oh, you’re already awake.</i>\" He says when he sees you.");
			outputText("\n\nWith a smile, you thank him for letting you help him, but seeing how it is getting late, you excuse yourself and say that you should return to the camp.");
			outputText("\n\n\"<i>It’s okay. The champion thing and all that, right?</i>\" He answers \"<i>Well, by now, you should have memorized where this place is so you can visit me anytime you want. I really enjoy when you’re here. And please, over all things, [name], keep yourself safe.</i>\"");
			outputText("\n\nWaving goodbye to the avian, you return to you camp.");
			dynStats("lus", 40, "scale", false);
			endEncounter();
		}
		private function anzuRelatLvl3Dont():void {
			clearOutput();
			outputText("Excusing yourself, you ask him if he needs to attend something, you’ll give him the time.");
			outputText("\n\n\"<i>Oh, thanks…</i>\" he says, quickly catching your idea. \"<i>Suddenly, I feel as if my bladder is full. I need to use the bathroom as soon as I can.</i>\"");
			outputText("\n\nHurrying to the mentioned room, the avian leaves you alone in the living room, enjoying the warmness of the fireplace. After a few seconds, the obvious sound of someone jerking off is heard across the hall. Judging from the size of Anzu’s...attributes, he’ll have much to clean up after he finishes.");
			endEncounter();
		}

		private function anzuRelatLvl4Sex():void {
			clearOutput();
			outputText("You answer him that you love him back too. The avian lowers himself until both of you meet eye to eye. His arms surround you, and soon you’re in the warmness of his embrace. Soon, the force of his grip becomes so strong it threatens to leave you without air.");
			outputText("\n\n\"<i>Thanks [name]. You have no idea how happy I feel knowing that you feel the same way!</i>\"");
			outputText("\n\nMaybe if he lets you breath a little, you could express your happiness too.");
			outputText("\n\n\"<i>Sorry, I was overwhelmed by the emotion.</i>\"");
			outputText("\n\nHe releases you, and while you recover air, you manage to see the avian wiping some tears of happiness from his eyes. He hides that when he realizes you’re looking at him");
			outputText("\n\n\"<i>I suppose that officially makes us, erm, lovers</i>\"");
			outputText("\n\nOf course. And what about if both of you celebrate this with a bit of fun?");
			outputText("\n\n\"<i>Right here?...Well, we can go to my bedroom, on my bed, you know.</i>\"");
			anzuSexMenu(false);
		}
		private function anzuRelatLvl4Dont():void {
			clearOutput();
			outputText("You give an uncomfortable look at the avian, who despite being initially confused to your reaction, quickly understands what you mean, releasing you from his embrace.");
			outputText("\n\n\"<i>Sorry [name], I think I let my mind fly around those strange ideas.</i>\" He says, visibly embarrassed \"<i>But if you don’t feel that way…</i>\"");
			outputText("\n\nThere is a long awkward silence, but you decide to calm down the situation by telling him that you don’t want to make him feel bad, you make clear who you still think on him as one of your best friends, and you hope that won’t be a problem.");
			outputText("\n\n\"<i>No, there isn’t any problem. Weird things that I shouldn’t have been thinking. Must be the Marethian air. And maybe it’s a good idea for both of us to stay away from that line, because after your cross it, things generally get very complicated.</i>\"");
			outputText("\n\nGood. You’ll be sad if your refusal damaged the friendship between both of you. ");
			outputText("\n\n\"<i>But… you’ll keep visiting me, right? Even if we aren’t, you know…</i>\"");
			outputText("\n\nOf course. After all, this is the only civilized place in the Rift where you can talk to someone. And above all, this is the home of your friend.");
			outputText("\n\n\"<i>Thanks, [name]. Even if you haven’t accepted my offer, it’s still a great thing having you around.</i>\"");
			outputText("\n\nYou say your goodbyes to Anzu, and return to the camp, leaving your avian friend to his own thoughts.");
			flags[kFLAGS.ANZU_AFFECTION] = 50;
			flags[kFLAGS.ANZU_RELATIONSHIP_LEVEL] = 3;
			endEncounter();
		}

		//MENU & INTERACTIONS
		public function anzuMenus():void {
			clearOutput();
			outputText("\"<i>Do you need anything?</i>\" Anzu asks patiently.");
			menu();
			addButton(0, "Appearance", anzuAppearance).hint("Take a closer look at the avian deity.");
			addButton(1, "Talk", anzuTalkMenu).hint("Get to know Anzu better.");
			if (flags[kFLAGS.ANZU_RELATIONSHIP_LEVEL] >= 3) addButton(2, "Sex", anzuSexMenu).hint("Have some sexy times with the sexy avian deity.");
			else addButtonDisabled(2, "Sex", "Maybe if Anzu likes you better, he will let you do that.");
			if (dungeonLoc == DUNGEON_ANZU_ROOF) {
				if (player.canFly()) {
					if (flags[kFLAGS.ANZU_RELATIONSHIP_LEVEL] >= 4) addButton(3, "Race Him", null).hint("Challenge Anzu to a race and have some fun!");
					else addButtonDisabled(3, "Race Him", "Maybe if Anzu likes you better, he'll consider letting you race against him.");
				}
				else addButtonDisabled(3, "Race Him", "You'll need a pair of flight-enabling wings to do that.");
			}
			addButton(14, "Back", playerMenu);
		}

		//Appearance
		private function anzuAppearance():void {
			clearOutput();
			outputText("Anzu is a 18'2\" tall avian, with a strong and athletic build, worthy of a god.");
			outputText("\n\nHis head is shaped like that of a predatory bird, with a beak and a long tongue. His ears have some resemblance with that of a cat, but they’re somewhat more elongated and streamlined, more adapted to flight. A gold earring with an amethyst gemstone hangs from his left ear. His hair is made of a crest of golden-orange fluffy feathers, with bright red feathers on the tip of his hair. The rest of his head is covered in orange feathers which shade to golden in an autumnal pattern. His eyes have a turquoise iris with a dark turquoise sclera.");
			outputText("\n\nAnzu’s hands are almost human in shape, but are covered in a layer of small golden scales with small claws on the tips. His arms have a soft layer of golden feathers that reach almost to his wrists. A bracer of gold rests on each one of them. On his chest he has a pair of flat manly pecs, covered in feathers.");
			outputText("\n\nHis body is a colorful pattern of feathers, shading from the autumnal colors from his head to light green on his forearms, chest and sides. The light green shades to dark teal when it reaches his underbelly and legs, ending with a bright violet on his fetlocks. On his back he has four large wings, covered in a pattern of golden feathers which shades to light green and finally to teal, with colorful purple details at the tips. A long feathered tail displays above his butt in a fan of turquoise feathers with purple feathers in the tip. His impressive wingspan, in addition to the multicolored visage of his feathers gives him a regal and majestic visage.");
			outputText("\n\nHis feet, too big to fit any footwear, are much like that of a bird, with hooked talons, partially hidden by some feathered fetlocks.");
			outputText("\n\nCovered for now in his clothing, his avian cock is 38 inches long and 4.8 inches wide, with two cantaloupe sized balls hanging below. His robes hide the gargantuan bulge relatively well, but you still can see the outline of his penis sometimes.");
			outputText("\n\nFor clothing, he usually wears a white shirt and dark brown pants, and over them he has a luxurious purple robe, decorated in gold and amethyst.");
			doNext(anzuMenus);
		}

		//Talk
		private function anzuTalkMenu():void {
			clearOutput();
			outputText("\"<i>What would you like to talk about, " + player.mf("boy", "girl") + "?</i>\" Anzu asks.");
			menu();
			addButton(0, "His Past", anzuTalkPast).hint("Ask Anzu about his past.");
			addButton(1, "The Palace", anzuTalkPalace).hint("Ask Anzu about the palace he currently lives in.");
			addButton(2, "Glacial Rift", anzuTalkRift).hint("Ask Anzu about the Glacial Rift.");
			addButton(3, "His Powers", anzuTalkPowers).hint("Ask Anzu about his powers. Surely as a deity, he has some interesting powers?");
			addButton(4, "Marae & Lethice", anzuTalkMaraeAndLethice).hint("Ask Anzu what he thinks about Marae and Lethice.");
			addButton(14, "Back", anzuMenus);
		}

		private function anzuTalkPast():void {
			clearOutput();
			//outputText(images.showImage("anzu-talk-past"));
			outputText("You ask Anzu about what was he doing before he lived in Mareth. He said he was an empty shell of his former power, and he protected a city called Mittani.");
			outputText("\n\n\"<i>First of all, I should explain to you about my full name,</i>\" Anzu says, \"<i>The Annuna is the common surname of the fifty powerful gods which are part of the council of gods that rule my former world. They're commonly known as the Council of the Annuna</i>\"");
			outputText("\n\n\"<i>Generally, being selected to protect a city is a great honour, especially for medium or low ranking gods, as few members of the Council are sent to fulfill that labour. In my case Mittani was the city I was sent to. Honestly, I was hoping to be sent to Lagash, located near the coast, because everything around Mittani was dirt and sand.</i>\"");
			outputText("\n\n\"<i>The people of Mittani received me well. The protection of the city was simple. I had to learn about making rain and growing plants in case of famine, but this is principally the job of the fertility goddess, so I didn’t have to do much. If the stupid leaders started a war with another city, my work was to assure victory. That caused trouble if the other city was also protected by a god of the council. When that happened, I and whichever god protected the opposing city sorted whoever would be the winner. If I lost the sort, I did nothing for the city and, after defeat, I chastised the city’s population for not praying or worshipping me enough. And if I won the sort, the other god did nothing, My city would win and the people would celebrate my greatness. Either way, I always got more people praying and worshipping me.</i>\"");
			outputText("\n\nWell, that’s cruel. What if many people died in the war? The gods of the Council, at least could try to reduce or prevent unnecessary deaths?");
			outputText("\n\n\"<i>[name], you have to understand something</i>\" Anzu says, looking seriously at you \"<i>Most gods in my realm only help those that worship them when it is convenient for them, because in the end we gods don’t care about the fate or the pain of mortals.</i>\"");
			outputText("\n\nNow, that's cruel.");
			outputText("\n\n\"<i>You already know life is cruel. Life is never kind. Besides, kind hearts don’t obtain glory. If I had a weak heart, I surely wouldn’t have survived.</i>\"");
			outputText("\n\nWhat went wrong? After all, something serious had to happen to make Anzu leave behind the city he protected, his privileges of being a god and his position in the Council of Annuna to come to this desolate realm.");
			outputText("\n\n\"<i>Besides the work of protecting the city, I still was under the orders of the major gods in the council. After some time, I got tired of the tasks from the high ranking members of the Council. The leaders had certain valuable objects known as Tablets of Destiny, and the one that had them in his power would be recognized as the new leader of the Council. One night, I stole the tablets from Leader’s place and took them with me. I went to my temple in Mittani, but shortly after, Enki, the current leader of the council, sent Ninurta to kill me.");
			outputText("\n\nThe damn bastard, who by the way was the one that stole from me my right of being the protector of Lagash, I fought outside of the walls of Mittani. The fight lasted for three days and four nights. On the last night, the idiot shot me with nine arrows from his damn bow. When he thought I was dead and started searching for the Tablets, I snuck up behind him and stabbed him in the back with enough force that it pierced him through. I ripped his head off afterwards to make sure he was dead.");
			outputText("\n\nWhen the Council heard of the death of Ninurta, they sent a group of eleven gods to hunt me down. I gathered all which I could carry in the chariot I stole from Ninurta and the things I couldn’t carry were sealed with my magic into some urns. It’s thanks to my magic that this palace is in good shape. When I was about to open a portal in Mittani, which would have allowed me to escape from my world, the hunters from the Council arrived. The city was almost empty when they arrived, probably due to the angry winds, which scourged the place from my battle with Ninurta, forcing the inhabitants to flee, which was lucky for them. I still carried the Tablets of Destiny, and used them as an energy conduit to open the portal. That was when I was attacked. ");
			outputText("\n\nSeeing how I was surrounded by enemies, and I had not recovered enough from the fight with Ninurta and opening the portal weakened me even more, I made a decision. With no other choice, and taking advantage of not needing the tablets anymore for keeping the portal open, I overloaded the energy in the Tablets, which quickly drained the energy from my body, leaving me with only a fifth of my original power. ");
			outputText("\n\nThen I smashed the Tablets just as the hunters launched themselves at me. The energy I infused in them was enough to kill the eleven idiots. Quickly I crossed the portal with the chariot and the urns. It was an...enlightening experience. I felt dizzy for hours, though. ");
			outputText("\n\nThe portal left me in the Rift, and luckily both the urns and the chariot were in good shape. I wandered for days across the hills before I found this place. When I came here it was inhabited by a group of winged women: valkyries, which I later learnt they’re called. Though weakened, I was still a god, and throwing them out was easy enough. After that, I reconditioned the place to fit my image. Besides killing the occasional giant that comes here to prove his courage, I’ve lived in peace here for fifteen years.</i>\"");
			outputText("\n\nYou thank Anzu for his explanation.");
			cheatTime(0.25);
			anzuAffection(5);
			flags[kFLAGS.ANZU_TALKED_PAST] = 1;
			doNext(playerMenu);
		}
		private function anzuTalkPalace():void {
			clearOutput();
			//outputText(images.showImage("anzu-talk-palace"));
			outputText("He said something about valkyries living here before he arrived. How was the palace before?");
			outputText("\n\n\"<i>The group of women that used to live here before? With them, this place looked a little more rustic back then. Wooden tables, iron decorations, weapons hanging on the walls, and a fountain containing something they call mead. I had to redecorate the place after I threw them out.</i>\"");
			outputText("\n\nAnzu makes a hand gesture to indicate you to follow him.");
			outputText("\n\n\"<i>I had to plaster the inner walls because the most of the bricks were exposed. After that, I decorated the walls and columns with silk and linen. The first floor, as you can see, has four principal areas, all connected to the principal hall.");
			outputText("\n\nTo the left, where we’re standing now, is the living room. Almost all of the furniture and vases, which are here now, were the ones I could bring with myself from Mittani. The books, which you see on the shelves, are general history books, told from the mortal point of view of course, very lacking in terms of general knowledge but still quite interesting.");
			outputText("\n\nNow, to the right side of the hall, is the dining room. I kept most of the furniture that the valkyries left behind. Behind the dining room is the kitchen. The staircase at the end of the hall leads to the basement and another, near the entrance, leads to the second floor. The door near the end of the hall leads to the bathroom. With the cold, a warm bath is always appreciated.</i> ");
			outputText("\n\n\"<i>What’s in the basement?</i>\" You ask.");
			outputText("\n\n\"<i>Come and see it yourself</i>\" Anzu answers.");
			outputText("\n\nBoth of you go downstairs to the basement, and the first thing which catches your attention is a chariot. You ask Anzu if this is the chariot in which he arrived on when he traveled to Mareth.");
			outputText("\n\n\"<i>Yes, I kept the chariot I stole from Ninurta here. It stays here most of the time as I have very little use for it</i>\" Anzu explains, and proceed to point to a door located behind the chariot.");
			outputText("\n\n\"<i>Behind this door is the armory. Name a kind of weapon, and you’ll find it inside: swords, bows, axes, spears, halberds, and...I’m starting to sound like a weapon seller. Maybe I’ll show you the weapons in more detail later, for now, follow me to the second floor.</i>\"");
			outputText("\n\nAfter returning to the first floor, you go upstairs to the second floor. The floor is shaped in a U like disposition. There are three rooms, two to the sides and one located at the end, with the hall connecting the three rooms and the staircases.");
			outputText("\n\n\"<i>Now, " + player.short + " if you look to the left, you’ll see my bedroom.</i>\" He points a pretty large room and beckons you to follow him inside.");
			outputText("\n\nWow, this is a huge room. You could fit inside this room almost all of your " + camp.homeDesc() + " located in your camp! You ask Anzu what was this place before it became his bedroom.");
			outputText("\n\n\"<i>Apparently, it was the valkyrie’s common dormitories before I arrived. There was almost thirty of them, and after I threw out all the old and small beds, the space left was more than enough for most of my things. As you can see, I repaired the walls and decorated it in a similar way to the living room. I put a small fireplace here too. And that large thing is my bed.</i>\" He says, pointing to a huge mattress covered with linen sheets.");
			outputText("\n\nAround the fireplace mentioned by Anzu, there are some armchairs. The scent of flowers catch your attention for a moment, and you see many vases with them around the bedroom.");
			outputText("\n\n\"<i>I tried to replicate here my sanctuary in the Temple of Mittani, and besides the cold, I think I did a good job. Apart from my bedroom, on this floor you can find my study, and the rest of the books in the palace. These books contain information from my realm.</i>");
			outputText("\n\nAfter showing you the study, he points the third room, on the right side of the floor.");
			outputText("\n\n\"<i>This room has no standard use. Generally I use it for random things when it becomes necessary.</i>\"");
			outputText("\n\nYou follow him to the third floor. Similar to the second in shape, the only difference resides in the fact of here are only two large rooms, while a hall crosses the floor.");
			outputText("\n\n\"<i>Well, there are the vaults of the palace.</i>\" explains Anzu, pointing to the left  \"<i>All the gold, jewels, carpets, or anything with a high value is stored here. In the room to the right I have some special equipment. I use it to measure the changes of energy in the area around the palace, while isn’t useful to detect individual approaches, a group of three or more individuals is immediately detected.");
			outputText("\n\nWhen I need to check my own levels of energy, or use a new spell that I haven’t tried, I use the negative zone in the room, which allows me to practice without destroying anything.</i>\"");
			outputText("\n\nYou admire for a while the gems that lie exposed around the room, none like you’ve ever seen on Mareth, before returning to his side and walk along the hall in the third floor. The hall ends in a huge window with a beautiful view of the Rift. Anzu walks to your side and sees across the window for a while.");
			outputText("\n\n\"<i>A little cold at start, but when you get accustomed, it becomes really nice. You know, if you want to have a better view, you can follow me to the roof.</i>\"");
			outputText("\n\nThe roof of the palace, surrounded by the forest pines, lead to a truly magnificent view. The hills extend for all the horizon, while the soft sound of the wind brings peace to your mind. Above you, the sky, framed by the treetops completes the setting.");
			if (flags[kFLAGS.LETHICE_DEFEATED] > 0) {
				outputText("\n\n\"<i>When I’m bored or feel too nostalgic, I use to go here in the night. Makes me focus in what I have now. Previously, those stars didn't appear in the sky but for some reason those stars returned.</i>\"");
				outputText("\n\nYou tell Anzu of how you defeated Lethice, and he congratulates you in your efforts, even giving you an appreciative nod for making the stars return. You chat in the top of the palace with Anzu about the constellations and shooting stars until the cold makes you ask him to go inside again.");
			}
			else {
				outputText("\n\n\"<i>When I’m bored or feel too nostalgic, I use to go here in the night. Makes me focus in what I have now. In the end, the only thing that I really miss from my former world, are the things that I can’t have when looking at the sky.</i>\"");
				outputText("\n\nYou give him a confused look.");
				outputText("\n\n\"<i>Stars.</i>\"");
				outputText("\n\nThe lack of the stars in the night sky can be a little depressing. You recall how in the night, back on Ingnam you used to sit on the grass and count the stars of the sky. You chat in the top of the palace with Anzu about the constellations and shooting stars until the cold makes you ask him to go inside again.");
			}
			outputText("\n\nBack in the living room, you thank him for having showed his palace to you.\n");
			cheatTime(0.25);
			anzuAffection(5);
			flags[kFLAGS.ANZU_TALKED_PALACE] = 1;
			doNext(playerMenu);
		}
		private function anzuTalkRift():void {
			clearOutput();
			//outputText(images.showImage("anzu-talk-rift"));
			outputText("Besides exploring and fighting some monsters, you know very few things about the Rift. Since Anzu has been living here for fifteen years, he could explain to you some details about the land. And, you still have doubts about how exactly he ended up in this place, and not, for example, the plains, or like you, the barrens.");
			outputText("\n\n\"<i>The Rift is likely one of the largest areas in the realm of Mareth, although I admit that I’ve yet to explore much outside the Rift. The weather is always snowy, and usually has sudden snowstorms. A multitude of hills, mostly covered in forests across the land. All the trees are pines, etc.");
			outputText("\n\nAbout the inhabitants, most of them are hostile. The Jotuns, or Ice Giants, wander across the hills, sometimes carrying trees, which they use as maces. The valkyries, winged women, cross the skies looking for someone worthy for challenge themselves. Besides that, they’re not exactly evil, and after our first encounter, we haven’t had any problems.");
			outputText("\n\nSome years ago, there used to be a kind of ice demons. They were pale white, with white hair, and had a strong addiction to the cum of certain creatures. While not so strong individually, they formed groups to hunt and \"<i>harvest</i>\" other inhabitants of the Rift, especially Jotuns, since they represented the biggest source of cum in the area. Because of the general nuisance they were, a force composed of valkyries, yeti and Jotuns drove them to extinction in a couple of years. Even I helped with killing some thousands. Since they hadn’t had connections with the demons in warmer lands, they fell quickly and eventually disappeared.");
			outputText("\n\nAbout the non-hostile inhabitants, I don’t know much. There used to be a dwarf mine and a kind of elven court located in the Rift before my arrival, but they’re abandoned now. They probably perished at the hands of the ice demons, but nevertheless, both the court of the mines are good sources of loot.");
			outputText("\n\nA tribe of reindeer-morphs live not far from here. It seems they feel safer living near the hills around the palace, probably because my presence keeping most of giants and yeti away.</i>\"");
			outputText("\n\nAnd about your second question");
			outputText("\n\n\"<i>Calm down " + player.mf("boy", "girl") + ", I’m going for parts. You don’t believe I opened the portal to the first world which appeared, right?");
			outputText("\n\nUsing the astronomical oculus from the temple of Mittani, I was able to see the principal realms. Many of them were uninhabitable, and some others were protected by gods that could make my stance very difficult. Mareth was in a middle of a war, and my arrival was probably unnoticed. Originally, I planned to land in the plains, but, because the war was very close to that land, I opted for the Rift, far from any forces of the factions. And I’ve living there since then.</i>\"");
			cheatTime(0.25);
			anzuAffection(5);
			flags[kFLAGS.ANZU_TALKED_RIFT] = 1;
			doNext(playerMenu);
		}
		private function anzuTalkPowers():void {
			clearOutput();
			//outputText(images.showImage("anzu-talk-powers"));
			outputText("Anzu said before he was a powerful deity. What are his powers exactly?");
			outputText("\n\n\"<i>The term ‘god of storms’ mean anything to you?</i>\" Anzu says mockingly");
			outputText("\n\nWell, that’s obvious, but being more specific, what kind of things he can do?");
			outputText("\n\n\"<i>Well, actually, that’s not a bad question, since most people tend to misunderstand the nature of my power over storms.</i>\"");
			outputText("\n\nReally?, When you heard ‘god of storms’ the first thing that hit your mind was him having a sort of powers related to lightnings and thunder, given the electric nature of the storms.");
			outputText("\n\n\"<i>That’s what I’m talking about. People usually put together lightning with thunder, even if they’re two entirely different things. Despite me having a...decent control over lightning, my ability to manipulate electricity leaves much to be desired, and besides, is quite inaccurate. To make things worse, in my actual state, I’m unable to use my electric abilities. The main reason is that generating electricity consumes a huge amount of magic power, since lightning bolts and sparks tend to need some charge and last a few seconds, or if you need them for a while, a continuous energy feeding, and that could be taxing.");
			outputText("\n\nIn compensation, I have power over something much more reliable. That is, the power over the sky forces: water and ice. Back on my home, I used those powers to create blizzards, hail, storms and floods when the situation demanded it. Name any hazard caused by weather and be pretty sure that I’m capable of doing it.</i>\"");
			outputText("\n\nSo he was the one responsible for the storm on the day that you met him?");
			outputText("\n\n\"<i>No. Despite the fact that I change the Rift weather from time to time, to keep my powers in good shape, I usually let nature follow its course. Interfering too much could draw unwanted attention to this place. ");
			outputText("\n\nI practiced a bit of manipulating the currents of wind and air that form the lower and middle parts of the sky. The air, seemingly harmless, hides a terrifyingly destructive power. With the year, I gained the ability of shape the winds into a slashing weapon, able to cut anything, and almost anywhere.  In addition to that, I created a much more complex, and...explosive way of manipulating the air. I start compressing the air around me in a range of more or less a half mile. The sudden lack of air makes any living being in the area faint, making escape almost impossible. Then, I release the compressed air in a single wave, in a 360 degree radius, with a range five times wider than the original area of extraction. Anything in the range is annihilated by the force of the expanding wave. The process of compressing, holding and releasing the air takes from ten to thirty seconds. I’ve been able to compress the air in a range of five miles and holding it for six minutes. The resulting wave reached ten times the original range. For this reason, I used to practice my powers on uninhabited areas of the world, far away from Mittani or any other city protected by the council. But, in case of emergency, I could take the air from fifty miles and released it in a range of a thousand miles</i>\"");
			outputText("\n\nThat seems a bit extreme, even by Anzu’s standards. Did he ever use this ability? ");
			outputText("\n\n\"<i>Only a couple of times. The first was almost two thousand years ago. The Council was in formation. I was a low-ranking member in those times, and the land was inhabited by horrid monstrosities standing hundreds and hundreds of feet tall. Some even reached the thousands. We the Annuna cannot establish our supremacy over the mortals with those creatures wandering around. Then I created and perfected this ability. The rest of the Annuna tried to do the same, with poor results. Impressed by my capacity, Enki elevated me to middle-rank and put me in the front to fight those monstrosities. After a century and half, the beasts were totally eradicated.</i>\"");
			outputText("\n\n\"The second time was five centuries after. A rival group of gods, whose origin is still unknown to me, appeared in the world. Some members of the Council said they came from the stars, outside of our world, as their forms were unrecognizable, even for Enki. Others said they came from a land in the far East, because in this land the apparitions were more frequent. I was sent to explore and inform to the Council what I discovered. Then, they attacked. Our cities in the skies and the mortal cities in the earth were struck by a storm, one from an unnatural source. Then it came to my sight. An abhorrent mass of flesh, which covered all the skies. Around it smaller shapeless masses danced. An urgent meeting was called. The elders in the Council said that if we didn't act soon, we would be doomed.  Enki, considering my success in the fight against the first abominations five centuries ago, formed a group with the purpose to fight the menace. Ninurta, the current \"<i>Champion</i>\" of the Council was called too. Enki asked me to use the explosive wave against the other gods, and I agreed.</i>\"");
			outputText("\n\n\"<i>In less of a week, we departed to the land of Hattusa, the place in the world most close to the outer sky, when the air and the ether mixed together. Enki, Ninurta and I decide to use our special growth to expand the power of our combined attacks.</i>\"");
			outputText("\n\nGrowth?");
			outputText("\n\n\"<i>The Annuna had the ability to increase his body size to gargantuan proportions. Originally, that was done to fight the abominations of the early ages. In that critical moment I was forced to combine both the growth with the explosives. After that crisis, it was done in some moments, when mortals behave in a rebellious way and serves as an intimidatory way to keep them in line. I was one of the most asked to fulfill this labour, not in Mittani, but sometimes in some cities across the desert.</i>\"");
			outputText("\n\nBut, how did the fight end?");
			outputText("\n\n\"<i>As I was saying, Enki, Ninurta and I went to the highest mountain, near the city of Hattusa. When the clouds above the mountain dispersed, the other gods appeared above us. Enki and Ninurta placed themselves to my sides, to prevent from being dragged by the winds force. Then I compressed the air in fifty miles around the mountain. When I was compressing it, Ninurta launched his arrows to the skies, injuring most of the lesser gods, and Enki, taking advantage of the void created by the lack of air, started to burn them with a pure wave of energy. When the wave was ready, Enki launched an attack formed of projectiles of energy and ice, and impulsed it with the force of the expanding wave. The impact destroyed all the lesser gods, but left the principal body untouched. Ninurta launched more arrows while Enki and I repeated the process of wave-energy-ice for a while. Then I realized that the attacks, though powerful, lost force in the higher areas of the sky. Ninurta and I fled closer to the abomination while Enki covered our advance. Now closer, we repeated the procedure, with more clear results. It took from us nine days and nine nights of a constant offensive, but in the end, the rival group of gods, including the biggest abomination were reduced to ashes. I’ve never reached that level of explosion without the body growth all of us can do.");
			outputText("\n\nThe consequences of our battle in Hattusa was the destruction of almost all the life in our world. Fortunately, many of the mortals that worshipped us hid and survived, and in less of one century the order in the world was restored.");
			outputText("\n\nAnd now, physical abilities. Now, that I mentioned all those supernatural things, those abilities can sound a bit mundane.</i>\"");
			outputText("\n\n\"<i>Well, for starters, I was born left handed, but, for practical reasons, became ambidextrous. This was ages before becoming a relevant member of the council, when my close combat was more reliable than my supernatural powers. Now, while I never had fear of unarmed combat, I also have a large arsenal in my armory to choose a weapon. ");
			outputText("\n\nWhen I still was a member of the Council, everyone recognized me by my twin blades: Labarna and Hattusa.</i>\"");
			outputText("\n\nHe says, pointing to a pair of knives on the wall. Almost five feet long each, they’re bathed in a layer of gold. Each one has the shape of a wing, with an intricate pattern of feathers. When you approach to see them better, you notice how the ‘feathers’ protrude past the blade. They are in reality a set of sharp spikes, vicious enough to tear away the flesh of anything unlucky enough to get too close to them.");
			outputText("\n\n\"<i>But, between all those, I prefer this.</i>\"");
			outputText("\n\nAnzu shows you a huge sword, almost eight feet long, covered in gold and decorated with blue and white gems. A bird decorates the pommel, and the blade is decorated with a letters in a strange language.");
			outputText("\n\n\"<i>My favorite weapon for close combat: Etemenanki.</i>\"");
			outputText("\n\nThat’s a strange name. You ask him if it means something in specific.");
			outputText("\n\n\"<i>It means ‘temple of foundation of the Sky and Earth’. Generally, a sword as big as this requires the use of both hands, but I do it well using with one. In the middle of combat, I find useful to change the sword from one hand to another.</i>\"");
			outputText("\n\nYou ask him if you can try it.");
			//This will be worked on
			outputText("\n\nAnzu hands you the sword. An instant after, a burning sensation invades your hand, making you drop the sword.");
			//
			outputText("\n\n\"<i>It's not a weapon that everyone can use. Etemenanki only allows me to use it. This prevents thievery or any attempts to use it against me</i>\"");
			outputText("\n\nAngry, you state that he could’ve prevented you before he gave you the sword, you say.");
			outputText("\n\n\"<i>It’s a little too late now,</i>\" he replies, laughing.");
			outputText("\n\nWhatever, but, since he said he lost most of his energy in the escape from his world, how much of those powers can he use now?");
			outputText("\n\n\"<i>Well, my physical abilities remain intact, but I can’t fight for weeks without a rest like in the past. I can use most of my fire abilities, and the electric fire too. In theory, I could create storms, but the lack of humidity makes it impossible for me. Before, I could make my own water, and make rain, but now I can’t. I have no problems with the growth, but trying to make an expansive wave is probably out of my capacity. I retain my immortality at least. That, and some minor powers here and there, are the only things that make me more than a demigod.</i>\"");
			outputText("\n\nSo...no explosive wave? That’s sad...and a relief, at the same time.");
			cheatTime(0.25);
			anzuAffection(5);
			flags[kFLAGS.ANZU_TALKED_POWERS] = 1;
			doNext(playerMenu);
		}
		private function anzuTalkMaraeAndLethice():void {
			clearOutput();
			//outputText(images.showImage("anzu-talk-marae-lethice"));
			outputText("Anzu said he was aware of the war between Marae and Lethice. After fifteen years in the Rift, he hasn’t been tempted to support one side?");
			outputText("\n\n\"<i>I’ve said before, [name]. I act for myself. Always have been that way. Even before coming here. Besides, even if I sided with you and helped Marae, her followers probably wouldn’t look well on me.</i>\"");
			outputText("\n\nWhy? He has proven to be a nice guy, and by helping Marae, that would make clear to everyone that he is on their side.");
			outputText("\n\n\"<i>" + player.mf("Boy", "Girl") + ". I’ve never been exactly what you call a moral being. Even on their side, they’ll tend to criticize my methods and the way I spend my free time.</i>\"");
			outputText("\n\nBut the sex life in Mareth, and the tastes of their inhabitants has been relaxed and open with the years, with the only condition that they don’t involve corruption.");
			outputText("\n\n\"<i>Corruption isn’t the problem, and I know the new Marethian standards. How to explain it, well, you know how demons boast about orgies and hurting innocent people, but I’ve been doing that for well over two thousand years.</i>\"");
			outputText("\n\nWhat.");
			outputText("\n\n\"<i>I used to have orgies in the place I previously resided in. Not the kind of orgy of you’re accustomed to here in Mareth, and they usually ended bad. Not that I’m saying I miss them, but having a good party without anyone getting accidentally or deliberately killed in the middle of it would be nice.");
			outputText("\n\nBesides, I’ve fought wars for my city. And, like in most wars, many innocent people die. But, it was part of my duty as a patron god of Mittani.</i>\"");
			outputText("\n\nSo, the problem that prevents him from joining Marae’s side is the fear of being criticized?");
			outputText("\n\n\"<i>No. The problem with supporting one side or the other is the same: Mareth would be aware of my presence, and that would make my life here less than pleasant. One side would start harassing me for more support, while the other would become a constant nuisance, trying to get rid of me. For now, I’ll remain neutral.</i>\"");
			outputText("\n\nIs there something that would make him intervene in the war?");
			outputText("\n\n\"<i>There are two circumstances. The most obvious would be, if one faction or both extend the war to the Rift. In that case, my best option would be to join forces with the valkyries, Jotuns, and yetis to send them out of the Rift. They’ve allied themselves before against ice demons.");
			outputText("\n\nThe second thing would be if one faction decides to attack me specifically. As an obvious response, I’ll be forced to side with the opposite side, to prevent further attacks. Since the demons are the more hostile side, they’ll probably be the first ones to invade the Rift or attack me, but, personally, I don’t trust in Marae either.</i>\"");
			outputText("\n\nBut, Marae is the goddess of purity, and most of the original denizens in Mareth support her. Besides, she was the original ruler of this realm. What reasons does he have to distrust her?");
			outputText("\n\n\"<i>There are many aspects. First, the naive attitude of her followers. Most of them fell quickly under the demon attack due to how unprotected they were. Maybe the lack of a menace in centuries made the population too confident in their safety. Today, there are some of her followers that believe that the war will end magically with a single intervention of their beloved goddess.");
			outputText("\n\nAnother thing is the disorganization of her forces. Even the well-trained warriors on her side act in separated groups. Before I said I gave a look around the realm before jumping in, enough to get some general information about the realm situation. That allowed me know where Marae was all the time, the existence of a city called Tel’Adre, the principal races in some zones, and some others details, which helped me to make a decision in the place that I’ll land. Obviously, that was fifteen years ago. By now, many things have changed for sure. But, things didn’t look well for her supporters in those times, and I doubt that they’re better organized now.");
			outputText("\n\nThe attitude of Marae towards her followers doesn’t help. She stays on the Lake, being little more than a decorative figure or a kind of \"<i>symbol of resistance</i>\" instead of an active leader. She could, at least, give advice to her allies about how to act against the demons.</i>\"");
			outputText("\n\nYou tell him about how she was getting corrupted by the fluids coming from the demon factory, thus limiting her actions. When you met her, the first thing she did was send you to stop the corruption from the factory on the lake.");
			outputText("\n\n\"<i>And why didn’t she send someone in the files of their followers, or even better, an entire force, to get rid of that place? All of that could be traced to one word: inefficiency. With all that in mind, the deplorable state of Marae’s forces is not a surprise. How do you even pretend to win a war if you are totally unprepared? And I don’t have the intention of siding with the loser’s side.</i>\"");
			outputText("\n\nReally? He prefers to support the demons? You’ve thought better of him.");
			outputText("\n\n\"<i>Not really, [name]. Lethice’s side isn’t any better. Even with more organized forces, better strategies and a more efficient leader, their goal is totally pointless. Corrupt every living being in this world. And after? There’s the option to invade and corrupt other worlds, but if that was a viable plan, they would've already started. Lethice knows that an invasion to another world sooner or later would end in a disaster. For example, imagine that the demons try to invade my former world.</i>\"");
			outputText("\n\nYou don’t think than an invasion of a world ruled by a multitude of gods, with a character much less benign than Marae would be a good idea.");
			outputText("\n\n\"<i>Exactly. Even with only thirty-seven members, the Council will annihilate the demon forces in a matter of seconds, and, even worse for Lethice, they’ll prepare a punishment expedition. The only reason that they’re not here after me for one, is the fact that they don’t know where I went… or maybe Gilgamesh asked Enki to forgive me. But we’re changing the subject.");
			outputText("\n\nThe corruption of the land has a limit. And with stupid decisions, like stopping the rains, they only make life in Mareth more difficult for them. What’s it worth to be on the strong side if they will do stupid things with their power?</i>\"");
			outputText("\n\nWell, he has a point. Both sides have defects. And while is sad, the fact that he won’t help Marae in the war, it’s a relief that both of you share the same idea about Lethice.");
			outputText("\n\n\"<i>Maybe, if her forces organize better, and she respects my position as an equal in this land, I’ll think about helping her against the demons, but for now, I’m not joining the war.</i>\"");
			cheatTime(0.25);
			anzuAffection(5);
			flags[kFLAGS.ANZU_TALKED_GODS] = 1;
			doNext(playerMenu);
		}

		//Sex
		private function anzuSexMenu(showText:Boolean = true):void {
			if (showText) {
				clearOutput();
				//outputText(images.showImage("anzu-sex-stripping"));
				if (anzuSexCounter() == 0) {
					outputText("You ask Anzu if he is up to a little fun in his bedroom.");
					outputText("\n\n\"<i>Uh, maybe</i>\" he says doubtfully.");
					outputText("\n\nWhy so shy suddenly? Based on the stuff he has told you, he certainly had some experience in what refers to sex when he was living in Mittani.");
					outputText("\n\n\"<i>No, that’s not the problem</i>\"");
					outputText("\n\nThen, what?");
					outputText("\n\n\"<i>Well, you see. I haven’t had any partner on bed since, well, since I arrived there. That was fifteen years ago. Besides relieving myself from time to time, I haven’t been very active and probably I’ve lost most of my practice. Mareth is a different than Mittani, and you must have much more practice than I, and I don’t want to ruin our friendship with a disappointing night on bed.</i>\"");
					outputText("\n\nYou aren’t exactly an expert, and don’t expect the same from him. After all the only thing that you want is a little fun with a close friend.");
					outputText("\n\n\"<i>I’ll do my best so i won't disappoint you, then.</i>\"");
					outputText("\n\nBoth of you hurry to Anzu’s bedroom. The sweet smell of the flowers inundate the air, while the soft heat from the fireplace makes the atmosphere perfect.");
					outputText("\n\nAfter climbing on the bed with his help, Anzu and you roll in the soft linen sheets of the bed for a while, groping and caressing each other. Well, mostly you, since with his huge frame is easy for you pass a hand across his soft and feathered body. After a bit of foreplay, both of you though that is a good time to start the real fun.");
					outputText("\n\n\"<i>Well, you got me here, what do you want to do?</i>\" he asks.");
				}
				else {
					outputText("You ask your avian friend if he is the mood for some fun again.");
					outputText("\n\n\"<i>If you’re ready, I’m ready</i>\" he answers.");
					outputText("\n\nBoth of you hurry to Anzu’s bedroom. The sweet smell of the flowers inundate the air, while the soft heat from the fireplace makes the atmosphere perfect.");
					outputText("\n\nAnzu and you roll in the soft linen sheets of the bed for a while, groping and caressing each other. Well, mostly you, since with his huge frame is easy for you pass a hand across his soft and feathered body. After a bit of foreplay, both of you though that is a good time to start the real fun.");
					outputText("\n\n\"<i>Well, you got me here, what do you want to do?</i>\" he asks.");
				}
			}
			menu();
			addButton(0, "Anal Catch", catchAnalPart1).hint("Have Anzu stuff you anally. \n\nNOTE: This is a REALLY long scene.");
			if (player.hasVagina()) addButton(1, "Vaginal Catch", catchVaginal).hint("Have Anzu fill you vaginally to the brim.");
			else addButtonDisabled(1, "Vaginal Catch", "You need a cooter for that.");
			if (player.hasCock()) addButton(2, "Get Sucked", getBlown).hint("Have Anzu suck you off? Though his beak can prove to be a challenge.");
			else addButtonDisabled(2, "Get Sucked", "You need to have a cock for that.");
			addButton(3, "Blow Him", suckOffDeitysCock).hint("Suck off that big cock. You have the hunch that it will get your belly stuffed.");
			if (player.hasCock()) addButton(4, "Fuck Him", fuckGodlyBirdButt).hint("Put that cock of yours to a good use and fuck that divine ass!");
			else addButtonDisabled(4, "Fuck Him", "You need to have a cock to fuck that divine butt.");
			if (player.lactationQ() >= 100 || player.hasPerk(PerkLib.Feeder)) addButton(5, "Feed Him", feedAnzu).hint("Anzu is certainly thirsty. Put those breasts of yours to a good use.");
			else addButtonDisabled(5, "Feed Him", "This option is only available if you have lactating breasts.");
			addButton(14, "Back", anzuMenus);
		}

		private function catchAnalPart1():void {
			clearOutput();
			//outputText(images.showImage("anzu-sex-anal-catch"));
			if (flags[kFLAGS.ANZU_ANAL_CATCH_COUNTER] == 0) {
				outputText("Looking at the handsome avian, your eyes quickly dart to the huge bulge on his pants. You look it, thinking how must feel to have that thick and huge monster inside. Anzu, who laughs nervously at your staring, seems to have realized what you have on mind.");
				outputText("\n\n\"<i>Wha...what you want to do, [name]?</i>\"");
				outputText("\n\nYou have quite clear what you want. Not in the mood to waste too much time on foreplay, you start teasing him caressing the feathers of his chest and slipping one hand over his crotch. If your idea wasn’t clear enough, now it is.");
				outputText("\n\n\"<i>Are you sure?</i>\" Well, has been a long time since I did that with someone, and well, given its size, it could hurt you...</i>\" He states, pointing the size of his bulge. \"<i>Even if you are okay with that, you’ll certainly end…how to say it, more…loose, after we finish.</i>\"");
				//Variables checking
				outputText("\n\n");
				if (player.analCapacity() < 100) outputText("That certainly could be a difficult task, but");
				else if (player.analCapacity() < 150) outputText("A big one, certainly, but, since you already had some experience with those things, taking it shouldn’t be a problem, and");
				else outputText("Really? Well, you had plenty of experience on Mareth, and despite how big he can be, you could easily take it on a single thrust, besides, you can’t see how his avian manhood is left unattended day after day. Even with the occasional release");
				if (flags[kFLAGS.ANZU_SUCKED_OFF_COUNTER] > 0) outputText(", and blowjob");
				outputText(", nothing compares to a tight and nice hole to slide in his package. And, in a world like this, it’s matter of time before you lose your tightness, and what could be better to lose it with your " + (anzuRelationshipLevel() >= 4 ? "lover" : "friend") + " than with a random monster on the wilderness? For make yourself sure that he won’t object anymore, you slip a hand on his underwear and start caressing his balls. The massive nuts almost groan on their desire for release, prompting a shudder on him, who blushes at your fondling of his intimate parts.");
				outputText("\n\n\"<i>O-okay, if you insist, friend….</i>\" a flustered Anzu answers</i>\" We should get started, then.</i>\"");
				outputText("\n\nStill a little unsure, he starts removing your [armor] while you lean over the bed. After leaving your clothes on the side, he takes off his clothes, dropping them on the floor, leaving him only with his underwear. You display your naked form on the bed, and shake your butt in the air [if (player.tail.type != 0)wagging your [tail]] to entice him. Despite his initial doubts, his arousal becomes obvious, judging by the way his cock starts tenting his underwear. He finally removes it, letting his partially erect cock hang free.");
				outputText("\n\n\"<i>Um…, I think that now we should…</i>\" A nervous Anzu tries to explain \"<i>You know, get something to lube my dick, because, else...</i>\"");
				outputText("\n\nHmm, seems like you have a throbbing and flopping source of lube just in front of you. With that on mind, you motion him to climb next to you. When both of you are on the bed, you grab his cock, whispering on his ear that you know how get all the lube that you could need, prompting an ‘oh’, from the avian. The lustful feeling that invade your bodies, and the increasingly erect cock in your hand tell you exactly what to do next.");
			}
			else {
				outputText("Looking again for another ride in Anzu’s huge rod, you climb over him and ask if the is in the mood for another round on the bed. This time, the avian answer is a huge grin.");
				outputText("\n\n\"<i>Seems like you can’t get enough of my cock, little friend.</i>\" he says, giving your [butt] a playful grope. \"<i>Well, since if that’s what you want, I think that can be arranged.</i>\"  ");
				outputText("\n\nAfter tossing his robes and other clothes to the armchair, he starts undressing you. Far from his nervous initial state, the aroused avian is clearly happy to share his bed with you again. His hands " + player.clothedOrNaked("eagerly take of the upper and lower parts of your [armor] and") + " start caressing your [skin]. You display your " + player.clothedOrNaked("almost ") + "naked form on the bed, and shake your [if (player.tail.type != 0)wagging your [tail]|[butt] in the air] to entice him.  Your reaction isn’t left unnoticed, as he gropes your " + (player.hasBalls() ? "[balls]" : player.hasCock() ? "cock" : "nipples") + player.clothedOrNaked(" when he takes off your underwear, leaving your nude body to his sight", " when he takes advantage of your already-naked state") + ". Finally, he removes his underwear too, dropping it in the floor and leaving his huge avian manhood exposed.");
				outputText("\n\n\"<i>That’s enough teasing for now, little " + player.mf("boy", "girl") + ". Prepare yourself for the real action.</i>\" He whispers on your ear.");
				outputText("\n\nClimbing on the bed, he hugs your" + (player.tallness >= 96 ? ", in comparison," : player.tallness >= 54 ? " small" : " tiny") + " frame on his strong arms. While he embraces you, the feeling of his hardening cock teases your backside. Seems like the avian has gotten much more confidence, and by the look that he’s giving to you, he’ll surely enjoy to be on the dominant position again. He relaxes his body on the bed, flexing his arms and legs, and leaving your face a few inches of his meaty rod.");
				outputText("\n\n\"<i>Well, [name]. I think who you’ll know what to do.</i>\" Anzu tells you, \"<i> And, after all, we’ll need some lube before get started, don’t you?</i>\"");
				outputText("\n\nYou can’t agree more. With his cock in front of you, ready for be lubed, and your body screaming to be taken, there’s not much more to say.");
			}
			doNext(catchAnalPart2);
		}

		private function catchAnalPart2():void {
			clearOutput();
			var wasVirgin:Boolean = player.ass.analLooseness < 1;
			outputText("Climbing over him, you " + (player.hasLongTongue() ? "wrap your nimble tongue around" : "start caressing and licking the sides of") + " his partially hard avian meat. After a bit of licking across its length, you switch you attentions to his tip, taking the point of the tapered penis on your mouth and sliding playfully your tongue on his cumslit. Soon, the forty-inch rod rises to full erection, and the first droplets of pre dribble from his tip and land in your tongue. You remove your mouth and take some of his leaking pre in your hand, smearing it carefully across your soon-to-be ravaged [asshole]. Despite being already lubed by your saliva, you take some more pre and use it for lube every corner of Anzu’s semi-hard maleness.");
			outputText("\n\nThe avian seems to be enjoying this treatment, given how his erection twitches, staining your hands with his dribbling pre. When you are sure that both your [asshole] and his cock are thoroughly lubed, you let him take control.");
			if (flags[kFLAGS.ANZU_ANAL_CATCH_COUNTER] == 0) outputText("\n\n</i>\"Since it’ll be hard to get in anyway, how about...well…we can make the task easier if you simply sit on my…</i>\" the avian says, shyly pointing his penis.");
			else outputText("\n\n\"<i>Now, for a good start, how about making this easier for you, my friend.</i>\" He says, stroking his avian erection \"<i>A nice and slow ride.</i>\"");
			outputText("\n\nFollowing his motion, you let your [butt] rest in front of his leaking erection. Anzu grabs your buttcheeks and starts hotdogging you, dripping his copious pre across your buttcheeks. The combined feeling of wetness on your backside and his tool sliding across your buttcheeks are more than you can manage to endure, so you position you [asshole] just above the tip of his penis.");
			if (flags[kFLAGS.ANZU_ANAL_CATCH_COUNTER] == 0) outputText("\n\n\"<i>So, you want to get started, right? Just be careful when sliding in…</i>\"");
			else outputText("\n\n\"<i>Tired of waiting, hmm? Given that, I’ll let you do the honors. Only remember to take it easy.</i>\"");
			outputText("\n\nFollowing his advice, you slowly take the meaty tool on your anus, letting out a whorish moan as you feel the dripping maleness invading your butt. Already lubricated with his copious amounts of pre, the first inches of his cock slide in easily.");
			player.buttChange(182.4, true);
			if (wasVirgin) {
				outputText("\n\n\"<i>Damn, " + player.mf("boy", "girl") + ". It's way tighter than I expected. How much experience you exactly have doing this?</i>\" the avian asks.");
				outputText("\n\nYou admit that this is your first time with anal" + (player.cockTotal() > 0 ? ", at least in the receiving end" : "") + ".");
				outputText("\n\n\"<i>Wow, you just allowed me to be the first one on have a way with your ass? I can’t believe it.</i>\" A surprised Anzu says, with a sincere smile. \"<i>Let me assure you, [name], that I’ll make you feel like you never felt before… Err, in a good sense, of course.</i>\"");
			}
			outputText("\n\nHis hands go to your hips, grabbing " + (player.isNaga() ? "your coils" : player.isTaur() ? "your rear and hind legs," : "your lower body") + " and making use of his strength to raise up your body, and insert and slip out the first nine inches of his gigantic erection of your ass with teasingly slow pace. Despite his slow motions, " + (player.hasCock() ? "your [cock] rises hard" : "your body tingles") + " at the anal stimulation. When you thought that he finished to play with you, he raises your ass from his cock, leaving only the first inches of his tip teasing the entrance of your backdoor.");
			outputText("\n\n\"<i>Anzu?</i>\" is the only thing that you manage to say, blushing red at the feeling of his tip prodding your butt.");
			outputText("\n\n\"<i>Only playing a little, my friend. You teased me a lot before, and now I’m getting my payback.</i>\"");
			outputText("\n\nHis teasing continues for a while, sliding in a couple of inches and retreating his cock few seconds later. Adding to his teasing, he grabs your chest and, after caressing your [skin], he starts pinching and playing with your nipples, prompting another moan from your lips. Meanwhile, the tapered tip of his avian penis tease the entrance of your [asshole] in such a way, that you reach the point when you can’t help yourself, and pushing his arms aside, you try to get his cock in, sinking as much as you can of the gigantic rod on your ass. Seeing how you are in the limit, he lets you do that, putting his arms behind his head and relaxing on the bed while you do the job. In a single moment, almost fifty inches of the meaty tool spear your ass, and isn’t even the half of it!");
			if (flags[kFLAGS.ANZU_ANAL_CATCH_COUNTER] > 0) outputText("\n\n\"<i>I’m the mood, [name], and with your body to my disposal, I’m gonna give you the ride of your life.</i>\"");
			outputText("\n\nYou take the rod inside your butt in an increasing rhythm, sliding in and out, and taking as much of the avian maleness as you can in each thrust. Moaning as you feel the tick spear " + (player.cockTotal() > 0 ? "ravaging your prostate" : "ravaging your insides") + ". Soon, almost thirty inches of his dribbling penis are spearing you, coating your innards with his pre. Sadly, given its thickness, you can’t manage to get inside more of it, but the stimulation of taking it in and out is quite enough to bring you to the point of orgasm.");
			if (flags[kFLAGS.ANZU_ANAL_CATCH_COUNTER] > 0) outputText("\n\n\"<i>Um, friend…</i>\" A flushed Anzu manages to say. By his look, seems like he’ll orgasm soon, and his words confirm it. \"<i>[name]…I think  I’m getting close</i>\"");
			else outputText("\n\n\"<i>Hey, little friend.</i>\" Anzu says, caressing again the [skinFurScales] of your chest. You look back at him, to find the avian almost as red and flushed as you. </i>\" [name], better get ready for me...</i>\"");
			if (player.gender > 0) {
				outputText("\n\nThe avian’s hands darts to your crotch when your " + (player.hasCock() ? player.hasVagina() ? "hard [cock] is leaking pre, and you wet [vagina] is already dripping" : "hard [cock] is already leaking pre" : "[vagina] is already dripping") + " and starts " + (player.hasCock() ? player.hasVagina() ? "jerking off your raging erection with one hand, while slipping one finger inside your pussy, teasing its insides" : "jerking off your raging erection with his hands" : "slips one finger inside your pussy, teasing its insides") + ".");
				outputText("\n\nHis efforts are prove effective soon, as " + (player.hasCock() ? "your cock, already stimulated by the ravage that your prostate had can’t hold anymore, and with a moan of pure lust, you release your load, " + (player.cumQ() >= 1000 ? "managing to hit your own face, and staining your chest, belly and even Anzu’s legs with your prodigious load" : "managing to cover your chest and belly in white streaks of your own cum") + (player.hasVagina() ? " while, at the same time, your pussy cannot hold the wonderful sensations of his fingering, releasing your girlcum over the avian’s fingers as you hit orgasm" : "") + "." : "Your pussy cannot hold the wonderful sensations of his fingering, releasing your girlcum over the avian’s fingers as you hit orgasm") + ".");
			}
			else {
				outputText("\n\nThe avian’s hands keep teasing your chest, playing with your nipples and caressing your belly.");
			}
			outputText("\n\nYour birdy friend reaches his own orgasm a moment later, and with a powerful avian screech, he releases himself inside you. Soon the first jets of avian semen explode inside your [asshole], swelling your belly more and more with each wave. Already dazed by the blissful sensation of your own orgasm, you take a little to notice the beautiful sensation of his creamy cum flowing inside you, but the feeling of his hot seed, combined by the warmness of your bodies makes you feel like you were in paradise. In fact, the idea of spend the rest of your life here…living in luxury and desire on Anzu’s palace quarters, spending your nights speared on his cock and your mornings eating with him, plus his bed jumping by hot and lustful sex every afternoon, when you think about it, the idea sounds quite appealing.");
			outputText("\n\nThe weight on your now cum-filled belly makes you jump back to the reality. You feel a wet sensation on your neck, and when you turn to see it, you manage to see that Anzu is licking you lovingly.  While doing that, he caresses you inflated belly with one hand while " + (player.hasCock() ? "taking some of your cum" : player.hasVagina() ? "looking at the girlcum on your fingers" : "caressing your nipples with the other") + ". Your " + player.legs() + " remain limp over his belly, stained by the avian seed that escaped from your [asshole].");
			if (flags[kFLAGS.ANZU_ANAL_CATCH_COUNTER] == 0) outputText("\n\n</i>\"Are…are you okay, [name]?</i>\" says a preoccupied avian. After answering him with a pleased nod he relaxes, and surrounds your body on his embrace. \"<i>Great, you leave me for a moment and I started to get nervous. By the way, that was the best time I had in centuries, and I’m happy to see that you enjoyed it too. But, since you worked yourself pretty hard, you should rest for a while before doing anything else.</i>\"");
			else outputText("\n\n\"<i>Whoa, little " + player.mf("boy", "girl") + ", seems like you enjoyed yourself pretty well.</i>\" The avian says, at the time that he embraces your cum filled body. \"<i>But [name], you’d better rest for a while. After all, you took it like a real Champion.</i>\"");
			outputText("\n\nFollowing his advice, you proceed to rest over his impressive frame, with Anzu’s deflated cock still filling your butt, and some of his thick cum leaking from your [asshole]. After some time, you feel a familiar sensation inside you. The avian’s penis is getting hard again! When you’re still surprised by the sudden feeling, Anzu’s hands embrace your chest, as he says.");
			if (flags[kFLAGS.ANZU_ANAL_CATCH_COUNTER] == 0) {
				outputText("\n\n\"<i>Looks like I’m aroused again, [name], and if you don’t mind, I think that we could, you know, have another round at it and all</i>\" a nervous Anzu suggests \"<i>If you don’t want you only need to say it…</i>\"");
				outputText("\n\nSeems like the nervous bird is finally breaking the shell…How you can say no to him? Turning around, your kiss his cheek and answer him that you’d love to have another go with him.");
			}
			else {
				outputText("\n\n\"<i>Hey, [name], seems like I’m still horny, little " + player.mf("boy", "girl") + "</i>\" Anzu says, giving your butt a grope and a playful slap \"<i>And given that I have enough energy for another round, what do you say if I fuck you like you deserve?.</i>\"");
				outputText("\n\nRemembering how energetic was your last romp with him, and what he has in store for you, you can’t help but agree and nod energetically. Maybe is the sight of his magnificent body, or, more probably, his cock still filling your ass, but you can’t resist the idea of having him ravaging your already gaped anus again.");
			}
			outputText("\n\nGrabbing you by the chest and removing your body from his partially hard cock, Anzu stands up from the bed, flexing his arms as he prepares to take you. You’re left on the bed, wondering about what he plans to do with you.");
			if (flags[kFLAGS.ANZU_ANAL_CATCH_COUNTER] == 0)
				outputText("\n\n</i>\"Maybe we could try another position?...If you are okay with that</i>\" he says, as his avian penis arises proudly again.");
			else
				outputText("\n\n\"<i>How about trying something different this time?</i>\" he finally says, as his avian penis arises proudly again.");
			outputText("\n\nAnzu motions you to turn around. Bending over the bed, you’re left with your [butt] on the air, and your recently creamed backside dripping cum over your legs. The avian approaches, and, after giving you cheeks another slap, he inserts one of his digits on your [asshole]. Sliding in easily given the quantities of cum dripping from it, the finger teases your insides for a while, until Anzu gets bored of it, and removes it.");
			outputText("\n\n\"<i>Luckily, seems like we don’t need much preparations this time.</i>\" The avian says, seeing his fingers covered on the fresh semen which leaks from your [asshole].");
			outputText("\n\nLooks like the avian wants to take you in doggy style, and your idea proves true as you feel his towering frame covering your vulnerable body. Soon his head past yours and your body is completely surrounded by his. Even his wings expand to the sides, covering almost all your view from the exterior. In any other moment, you’d feel unnerved at the thought of having your body totally covered under a huge being, but now, you can’t imagine a better place to be. Letting out a moan at the feeling of the weight of his penis resting over your buttcheeks again, you’re surprised by a wet sensation of your face. When you turn to see what is making it, you face with a happy Anzu, his head turned upside down from your point of view, with his tongue extended and licking your face affectionately. When you stare him, he simply moves his head from side to side in a bird-like way, after that, both of you start laughing at his strange antics.");
			outputText("\n\nThat done, the avian hands start fondling your nipples, caressing the soft [skin] between them. " + (player.hasCock() ? "One of his hands slides down to your crotch, playing with your [cock], that is still dripping with the cum from your last orgasm" : player.hasVagina() ? "One of his hands slides down to your crotch, when a playful finger slides into your [vagina] and teases his insides again" : "One of his hands goes to your butt, caressing your cheeks and slapping them playfully") + ". It’s amazing how with his huge size he can manage to reach each corner of your body. Now his nimble fingers are on your belly, and after some caresses, he starts ticking it mercilessly, earning uncontrolled laughs from you. Finished with his foreplay, he prepares to the main part, stroking his dick, and teasing you again, sliding only the tip of it in your needy [asshole].");
			outputText("\n\nThen, without warning, you feel almost eleven inches of pure avian meat invading your [asshole] in a single thrust. Yelping at the sudden intrusion, you’re given a few seconds to rest as the thick penis slides out, before Anzu rams his cock inside again, this time a few inches deeper. You moan like a whore each time that the monster makes its way on your [asshole].");
			outputText("\n\n\"<i>Feeling okay, little " + player.mf("guy", "girl") + "?</i>\" Anzu asks, somewhat worried about your state. You nod in response, earning another grin and a loving lick from the avian. \"<i>Great, because I want to be sure that you’re enjoying this as much as I.</i>\"");
			outputText("\n\nTruth to his word, he combines the energetic pounding that he’s giving to your butt, with an equally vigorous " + (player.hasCock() ? "handjob that he’s giving to your [cock], which has gotten erect under his anal stimulation, pumping its length until your pre starts dripping from it" : player.hasVagina() ? "fingering that he’s giving to your [vagina], playing with his insides with his fingers prompting some girlcum to leak from it" : "massage that he’s doing to your [nipples], as he caress the soft [skin] of your chest") + ". Your entire body is hot under his ministrations, at the time that his thrusts slide his avian manhood inside your ravaged [asshole]. Anzu softly nips you neck with his beak, helping you to keep in position as his erection pistons in and out of your [asshole].");
			outputText("\n\nWith each thrust more and more inches of the huge tool invade your ass. The copious pre that it dribbles mixes with some cum from his last load, leaving your backside sticky with it. Not that you have time to think about it, because almost thirty inches of cock are making its way inside you. For a second you’re worried about him trying to ram his entire cock inside, but your friend seems to recognize the logic limits of your body, and stops at this rate. Not that his vigor diminishes, as he compensates this increasing the speed and strength of his already energetic thrusts. Y" + (player.hasCock() ? "our poor prostate is thoroughly smashed by his invading dick, while y" : "") + "our nipples get as hard as diamonds by your overstimulated state.");
			outputText("\n\nHis huge nuts " + (player.hasCock() ? (player.hasBalls() ? "slap against your body, hitting your own in each thrust" : "hit the underside of your [cock] in each thrust") : "slap against your body") + ". With each hit you can feel the liquid weight of his prodigious load churning inside them, a reminder of what he has stored for you.");
			outputText("\n\nA familiar heat overcomes your bodies as Anzu increase his pace even more. Drop of sweat fall from your body, as the heat between you increases and your breathing becomes heavy, making clear that both of you will climax really soon.");
			if (flags[kFLAGS.ANZU_ANAL_CATCH_COUNTER] == 0) outputText("\n\n[name], friend…I won’t be able…to hold…much longer…</i>\"");
			else outputText("\n\n\"<i>[name]…this time…is a really big one…get ready, my friend.</i>\"");
			outputText(" It’s the only thing that Anzu manages to say between pants.");
			outputText("\n\nThen both of you hit orgasm. ");
			if (player.gender > 0) outputText("You came first, " + (player.hasCock() > 0 ? "when your cock twitches wildly, releasing your load over the sheets" + (player.cumQ() >= 1000 ? ", with enough force to cover most of them and stain the [skin] of your [legs]" : "") + (player.hasVagina() ? ", while your [vagina] moistens your tights with girlcum " : " ") : "when your [vagina] moistens your tights with girlcum") + ". Your entire body quivers as you reach climax, and even when it passes, you’re left panting heavily.");
			outputText("\n\nAfter your orgasm you feel so weak that you fall over the sheets" + (player.hasCock() > 0 ? ", staining your face and chest on your own load" : "") + ". Your [butt] still raised, with Anzu’s cock firmly buried inside and the strength of his thrust serving as support for your backside. Then, you realize that your avian friend is about to climax too. As expected, with another screech of ecstasy, Anzu releases his load inside you. Your anus is creamed again as his cumslit unleashes a torrent of semen, that soon overfill your insides with enough force to make your belly tremble as the seemingly unending waves of cum flow in.");
			player.refillHunger(50);
			outputText("\n\nLooking mesmerized how your already expanded belly expands to the point that you’ll easily pass for a nine-months pregnant woman, you can still feel the las jets of Anzu’s seed overfilling you even more. When his orgasm subsides, he slides out his deflating cock, prompting some of the cum pumped inside you leak from your gaped orifice. Tired after the…energetic…experience, Anzu falls to your side, panting, and with his arms surround your cum-inflated form. Licking again your face the bird gives you a loving look and says");
			outputText("\n\n\"<i>Well, I hope that I fulfilled my promise. do you feel like you never been before?</i>\"");
			outputText("\n\n" + (player.analCapacity() >= 90 ? "Maybe he can't boast of having the most impressive libido on this land, but he surely knows how to plow an ass" : "Of course, and your " + (wasVirgin || player.ass.analLooseness < 3 ? "gaped" : "") + " gaped anus is proof of it.") + " In the end, you got even more than you expected, you answer him. Laughing softly, the avian surrounds your body on his embrace, protecting your " + (player.tallness >= 96 ? "comparatively" : player.tallness >= 50 ? "small" : "tiny") + " frame on his wings. His strong hands caress your semen-filled belly as you drift to sleep on his protective embrace.");
			outputText("\n\nAfter a couple of hours, " + (player.isGoo() ? "you slimy body gradually process the prodigious load deposited into you. As it does that, you feel thoroughly sated by the creamy gift from the avian" : "your body manages to process the gigantic load inside you in some way. When you try to stand up, your legs tremble weakened after the ravaging of your ass suffered. Dammit, Anzu! After such a pounding, you’ll be walking funny for a while") + ".");
			player.orgasm();
			player.slimeFeed();
			anzuAffection(5);
			flags[kFLAGS.ANZU_ANAL_CATCH_COUNTER]++;
			endEncounter();
		}

		private function catchVaginal():void {
			clearOutput();
			//outputText(images.showImage("anzu-sex-vaginal-catch"));
			if (flags[kFLAGS.ANZU_VAGINAL_CATCH_COUNTER] == 0) {
				outputText("Finding yourself on Anzu’s embrace, this time you wonder if the avian would like the idea to get intimate with you, in the most traditional way. The idea of enticing your avian friend on sliding that monster inside your vagina, while he pounds you with enough force to make you scream and finally, having his thick load flooding your womb is something that you can’t resist,  With that on mind, you slip down one of your hands to his crotch, and sliding down his underwear, start grabbing at the girthy meat that lies within. The avian lets out a moan at your sudden touch, but doesn’t remove your hand.");
				outputText("\n\n\"<i>Heh...what are you doing, " + player.mf("boy", "girl") + "?</i>\" he question you, his face blushing red under his autumn colored feathers.");
				outputText("\n\nOnly giving him a little motivation, you answer. After all, you came to his bed to have a little romp together. You suggest him that he should take off his clothes, so you could take care of him better. Nodding eagerly, probably due your touch, Anzu removes his fancy garments, and later, his underclothes" + player.clothedOrNaked(", while you do the same with your [armor]") + ". This finished, you return to your task, sliding your fingers across the avian meat and his feathered balls While you fondle his genitals, the avian, between moans of pleasure, asks you what you want to do with him. Seeing your opportunity, you climb to his shoulder and whisper to his ear that you’d love to have him taking your pussy and mating you like a beast. Both of your eyes dart to his tapered penis, now half hard after your enthusiastic handjob, and the avian gives you a loving smile, but with a hint of worry on it. Surprised by that last thing, you ask him if he has a problem with it.");
				outputText("\n\n\"<i>I don’t know, [name]. Don’t get me wrong, I’d love to do it with you, but look at it,,,</i>\" the avian answers, pointing the gigantic and half hard cock between his legs. \"<i>If you’re not careful you could get hurt...and I don’t want to see that happening." + (player.tallness < 50 ? " Only, look at you...and me." : "") + "</i>\"");
				outputText("\n\nCaressing tenderly the fluffy and colorful feathers of his chest. you state that it " + (player.vaginalCapacity() < 200 ? "shouldn’t" : "won't") + " be a problem. You’re in Mareth after all! Big-cocked monsters are things of everyday, and some of the friends who you’ve made are pretty hung too. " + (player.hasVirginVagina() ? "Overall, you even managed to keep your virginity until now. Why not losing it with someone who you really care, instead of with a random monster in the wilderness? With someone as affective and kind as him on bed, you shouldn’t be worried about anything" : "Now that you are a little experienced on that matter, it only require a little effort to make the experience pleasurable for both of you, and with someone as affective and kind as him on bed, you shouldn’t be worried about anything") + ".");
				outputText("\n\n\"<i>Really, [name]? I’m a little flustered...about you thinking of me in such a way.</i>\" the avian answers.");
				outputText("\n\n\"<i>Well, if you want it too…</i>\" he says, almost whispering this last word. \"<i>I suppose than I could do it for you.</i>\"");
			}
			else {
				outputText("Finding yourself on Anzu’s embrace again, you wonder if he will want to take you again in the most traditional way. The idea of enticing your avian friend on sliding that monster inside your vagina, while he pounds you with enough force to make you scream and finally, having his thick load flooding your womb is something that you can’t resist. With that on mind, you slip down one of your hands to his crotch, and sliding on his underwear, start grabbing the girthy meat that lies within. Anzu gives you a smile as he notices what you’re trying to do, as his cock hardens at you playful grope.");
				outputText("\n\n\"<i>So, you want another round with me, " + player.mf("boy", "girl") + ". Looks like I’m not that bad when is time of take care of my mate.</i>\"");
				outputText("\n\nOf course not. Actually, he was pretty good the last time, and you won’t mind repeating the experience, you answer him, while your hands keep fondling his tapered penis and his soft balls. Soon, his avian manhood is half hard. At that point you stop your handjob and ask him about taking off his clothes, so you can take care of him better.");
				outputText("\n\nHe does it with no hesitations, taking off his fancy garments and tossing them to the floor, doing the same with his underclothes few seconds later, leaving his nude beauty exposed to your eyes. Quickly you follow his example and strip yourself from your [armor]. You take a moment to contemplate your " + (anzuRelationshipLevel() < 4 ? "friend" : "lover") + "'s form while he stands next to the bed, looking the lovely pattern that his colorful feathers take across his body, and his equally colorful wings. Complemented by that gigantic monster that hangs from his legs and his strong complexion, Anzu is all and more than you could ask from an avian. The soft light from the bed and the scent of violets, which emanates from his body, make his toned form even more alluring. But, while you admire his body, some time has passed, and somewhat confused by your continuous staring, Anzu coughs to get your attention again. You state that with a body as attractive as his, you can’t help but ogle at it. His face blushes red behind his feathers at your flattering, as he only says a shy ‘thanks’ as an answer. A little surprised by how quick he undressed, you say him that, given his initial doubts, he’s becoming quite eager each time that you have a romp together.");
				outputText("\n\n\"<i>Hey, it’s your fault, [name]</i>\" \"<i>You’ll end making me a horny beast in no time.</i>\" he answers, while his half hard cock add weight to his statement.");
				outputText("\n\nHmm, that wouldn’t be bad either. Anzu ravaging your body as an unleashed monster, taking you how he wants...but if you wanted that, they are plenty of monsters on the wilderness. You like him as he is, and if he wants to go wild while you’re on bed, go on.");
				outputText("\n\n\"<i>So you want me going crazy when we’re doing it? How about like this?.</i>\" He says as he playfully mimics the pose of a bird of prey, with his wings fully opened and his face contorted awkwardly in some that pretends to be a menacing visage. Both of you start laughing at his obviously fake attempts to look intimidating.");
				outputText("\n\n\"<i>Jokes aside, [name]. I promise you that I’ll take you like anyone before...except me, of course.</i>\"");
				outputText("\n\nIf he’s so sure about that, what are you waiting? nodding, he motions you to go to the center of the bed, and while you lay there, he strokes his now flaccid dick until it reaches full erection..");
			}
			outputText("\n\nReady to begin, you lean over the bed, with your body resting on the soft mattress and the huge frame of Anzu over you. He lets his hard cock fall over the entrance of your nether lips, leaking some pre over them and giving you a sight about that going to come.");
			if (flags[kFLAGS.ANZU_VAGINAL_CATCH_COUNTER] == 0) outputText("\n\n</i>\"Hey, [name]. You know, we need something to lube up my penis, because if we don’t, well...it probably will hurt you when we get started. Then I thought that you could use my pre as lube...if you want to do it, of course.</i>\"");
			else outputText("\n\n\"<i>Uh, " + player.mf("boy", "girl") + ". If you really want to get it, without being split in half, you’d better start to get some lube.</i>\"");
			outputText(" the avian says, pointing the dripping tip of his avian manhood. \n\nNodding, you grab the tip of his penis, and taking some of his copious pre on your hands, you smear it across your nether lips, until they’re slick and lubed. Finished with them, you work with the avian’s cock, smearing the dribbling pre across all its length. After a few layers of pre, its left thoroughly lubed, and ready to pound your body.");
			if (player.hasVirginVagina()) {
				outputText("\n\n\"<i>[name], you’re nice and tight down, here " + player.mf("boy", "girl") + ". How many times...you know, had taken something there?</i>\"");
				outputText("\n\nYou say him that you managed to remain virgin until now, despite the constant dangers of this land.");
				outputText("\n\n\"<i>And you were allowing me to be the first one that could take you...properly?</i>\" says Anzu, blushing as you answer this last question with a nod. \"<i>Well, then the less that I can do is assure that your first time would be unforgettable, nice and slow at the start, and strong and passionate at the end</i>\"");
			}
			outputText("\n\nThen you feel his cock touching the entrance to your pussy. You enjoy the wonderful sensation of the tapered tip of his penis sliding on your [vagina], opening your internal walls as his length finds its way inside you.");
			player.cuntChange(182.4, true);
			outputText("\n\nAnzu gently slides in and out the first few inches, making himself sure that he’s not being too rough with you. The smell of his feathers and the wet feeling of his pre staining the insides of your pussy, combined with the delicious sensation of his penis on you excites your body in a way that you don’t knew possible before. Before you can realize it, both of you are moaning, as the desire starts getting a hold on your bodies. Anzu puts a hand on your [chest], caressing your nipples as he pumps his meat inside your cunt with a steady rhythm. You lose yourself in the blissful sensation as he pounds you with an increasing pace. Then, he suddenly stops. You glance up at him with a puzzled look, and he answers.");
			outputText("\n\n\"<i>Hey, you said before that you’d like to see me go wild. And I’m in the mood for that!</i>\" he says with a huge grin, giving your neck a loving lick.");
			outputText("\n\nOh well, it's not like you haven’t asked for it. Supporting your arms on his neck, you brace yourself, and just in time, as he rams almost half of his pulsating rod into your pussy. \"<i>E-easy,  big boy</i>\" it's all that you manage to say before he shoves his manhood inside you again. Your entire body trembles at the strength of his poundings. Soon you are panting heavily, doing your best for take the vigorous ravaging that Anzu is giving you. After a particularly strong thrust, he manages to shove most of his cock on your [vagina]. You almost can feel his tapered glans tickling you cervix. Unable to endure more, you collapse on the bed, letting him take totally the reins. " + (player.hasCock() ? "Your [cock], left unattended for a while, arises hard and ready after the intense stimulation that your body is receiving, Anzu takes it with one of his hands and starts jerking it playfully. " : "") + "Moaning like a whore, you beg him to take you, to rut with your body like a wild beast, and seems like your words trigger something inside Anzu, because as soon as he hears that, the force of his thrust becomes even bigger, his avian manhood sliding in and out of your pussy his entire man meat while your legs quiver under the vigorous pounding. The heat that emanate from his body says you that he’ll reach his climax soon, and the same could be said about you.");
			outputText("\n\nWith a scream of pleasure, you hit orgasm, painting Anzu’s manhood with your girlcum" + (player.hasCock() ? ", as your cock releases your load over his belly, staining his hand in the process" : "") + ". Shortly after you, he climaxes too, his cumslit releasing flooding waves of spung inside your pussy. You hand caresses your belly as it swells thanks to the generous load that Anzu’s balls are pumping into you, until his load finally ceases, and you're left with a belly proper of a nine-months pregnant mother. The wonderful feeling of his fresh cum filling you makes your body feel like it was on paradise, and the sheets under you, and the sweet scent of the air only make the atmosphere better. While you’re daydreaming about this, you feel a wet sensation. By now, you easily recognize it. Anzu is playfully licking your neck and giving it soft nips. Climbing to his side, you give his cheek a peck.");
			outputText("\n\n\"<i>So, that’s when you get wild</i>\" you say. \"<i>I think that I like it.</i>\"");
			outputText("\n\n\"<i>If that so, what about trying it again sometime?</i>\" the avian asks with a smile.");
			outputText("\n\nSure, you answer, but for now, you’ll need some rest.");
			outputText("\n\n\"<i>Right. I’m tired too, and since we’re on bed already, how about if you snuggle with me until you’re rested?</i>\" Anzu suggests.");
			outputText("\n\nThat sound like a great idea. removing his cum dripping penis from your [vagina], you climb on his chest, resting on it like if he were a huge mattress. Anzu laughs at that sight and proceeds to surround you with his arms, as his winds cover your sides. Completely surrounded by his body, you drift to sleep with his semen still dripping from your abused pussy.");
			player.orgasm();
			player.slimeFeed();
			anzuAffection(5);
			flags[kFLAGS.ANZU_VAGINAL_CATCH_COUNTER]++;
			endEncounter();
		}

		private function getBlown():void {
			clearOutput();
			//outputText(images.showImage("anzu-sex-give-blowjob"));
			if (flags[kFLAGS.ANZU_BLOWN_YOU_COUNTER] == 0) {
				outputText("Deciding to take the initiative, you tell him that you have an uncomfortable pressure " + (player.hasBalls() ? "in your balls" : "on your loins") + ", and if he was kind enough to help you with….");
				outputText("\n\nOn a second thought, you look again at Anzu’s predatory beak, and imagine several circumstances that would be able to kill the mood or worst, result on a painful nightmare. The avian notices how quickly you interrupted you teasing, and proceeds to ask you.");
				outputText("\n\n\"<i>Something happened? Knowing you, I was sure of you were asking me to give you a…</i>\"");
				outputText("\n\nWell, this is now a little uncomfortable. You don’t want to make Anzu feel bad, but in the other hand you neither want to have an otherwise pleasant experience turned into a painful one and…");
				outputText("\n\n\"<i>Hey? [name]? Are you still on this world? Why you stopped your suggestion? Suddenly you realized that you don’t want a blowjob or…Oh, I know what is the problem.</i>\" He says, pointing his beak.");
				outputText("\n\nNot knowing what else to say, you simply nod.");
				outputText("\n\n\"<i>Yeah, I supposed it. Most of the people runs scared at the thought of me servicing them orally, so I’m not offended. With me having a beak instead of lips, is easy to make misconceptions. But, despite the fact I’m a kind of predatory bird, my beak isn’t sharp enough to tear skin, and, even if you’re not comfortable with that, I have this.</i>\"");
				outputText("\n\nAnzu lets out his tongue, surprisingly large. Not as long as the one of a demon, a dragon or a lizan" + (player.hasLongTongue() ? ", or your own" : "") + ", but with the length and slickness right to give a pleasant trip to any cock lucky enough to be lavished on its attentions. Suddenly, the idea of getting a blowjob from him is appealing once more. But for being sure, you make him promise to be careful with the sharpest edges of his beak.");
				outputText("\n\n\"<i>Okay, okay, [name], don’t worry. The last thing in the world that I want now is hurt you. You should know that by now.</i>\"");
				outputText("\n\nSaying him that you feel adventurous enough to endure a beakjob from your avian friend, you accept his offer.");
			}
			else {
				outputText("\"<i>So, my friend, what you have in store for me today?</i>\" Anzu asks you on the bed.");
				outputText("\n\nNow that he asked, you tell him that you have an uncomfortable pressure " + (player.hasBalls() ? " on your balls" : "on your loins") + " and this time you’re in the mood for having some oral attention again, if he is okay with that.");
				outputText("\n\n\"<i>You already lost the fear to my beak, or my last tongue work was good enough to leave you wanting another blowjob?</i>\"");
				outputText("\n\nA mix of the two. The last beakjob wasn’t painful in any way, and you feel adventurous enough to repeat the experience today. Of course, if he keeps his promise to make sure of your skin will be intact by the time you finish. Pleased by your answer, Anzu lets out his long tongue and licks your cheek with it, and, after fondling your crotch teasingly, says.");
				outputText("\n\n\"<i>Then, get ready, my friend.</i>\"");
			}
			outputText("\n\nWhile you rest your back on the comfortable mattress, Anzu approaches you and, putting one hand on your crotch, carefully removes the lower part of your [armor], tossing it on the floor next to the bed and leaving your underwear exposed. Soon, his hands take it away too, leaving your [cock] flopping free on the air.");
			outputText("\n\nJudging for the hungry look of the avian is giving you, the real action will start soon, and your thought proven true, as you feel a wet sensation over the tip of your [cock], quickly seeing that it's Anzu’s tongue undulating across the tip of your penis. The slicked appendage teases your cumslit, and after a while, switches to the sides of your [cock]. The avian’s tongue licks them in a way that has nothing to envy to the best blowjobs given to you in this realm, and proof of it is that in less of a minute, your cock is hard and throbbing.");
			outputText("\n\nAnzu is getting hot too, and while he doesn’t stop his tongue work over your [cock], one of his hands slips down to his crotch and start pumping his huge penis. You haven’t much time to notice this, but just after he starts doing that, his other hand starts " + (player.hasBalls() ? "fondling your [balls]" : "teasing your nipples") + ".");
			outputText("\n\nWith the additional stimulation, your arousal increases even more, to the point of pre starts leaking of your tip. Anzu licks it happily taking it away with his nimble tongue before you can even notice it. The avian’s own erection is so hard that it is leaking pre too, but in much more quantities than yours.");
			outputText("\n\nA naughty idea hits the avian’s mind at that moment, and when you see him slicking his fingers with the copious amount of his own pre, you don’t need much imagination for guessing what he has planned for you. Soon, the delicious feeling of " + (player.ass.analLooseness < 2 ? "his finger gently prodding your [asshole]" : "his fingers teasing the insides of your [asshole]") + ".");
			outputText("\n\nYour misconceptions about getting a blowjob from him quickly prove themselves wrong at the wonderful feeling of his tongue worshipping every inch of your [cock], leaving it thoroughly slicked and covered on his saliva. At the same time his digits keep teasing your ass, and finally, finding their way to your prostate, prodding it gently.");
			outputText("\n\nSoon, the " + (player.hasBalls() ? "pressure on your [balls] become unbearable" + (player.cumQ() >= 1000 ? "You almost can hear them groaning for the painful effort to keep the cum inside them" : "") : "lust in you grows enough to the point that you can't resist longer") + ". With your cock lavished by the avian’s tongue and your prostate teased by his fingers, you finally hit orgasm, letting out your " + (player.cumQ() >= 1000 ? "copious" : "") + " load with enough force to stain most of his face on a single wave. Anzu quickly wraps his tongue around your cumslit, " + (player.cumQ() >= 1000 ? "managing to catch most of your cum in his beak" : "catching all of it on his tongue") + ". With a pleased smile on his beak, he proceeds to lick the remaining cum from his face.");
			outputText("\n\nWith a relieved sigh, you let yourself fall on the bed. Anzu is yet busy, licking your cock clean from any drop of cum that you could've left. That done, your he joins your on the bed. " + (player.cumQ() >= 1000 ? "Now that you can look him closer, you notice how your impressive load managed to make his belly swell a little, despite his impressive frame. While he hugs you tight, you poke playfully his cum-filled belly, earning a blush from the avian." : "Taking you on his arm, you snuggle on the bed for a while.") + "");
			outputText("\n\nEventually both of you fall asleep for a while. By the time you’re awake, you find your clothes carefully folded next to your side to the bed, and a still naked Anzu flexing his arms and legs in front of you.");
			outputText("\n\n\"<i>So, you’re finally awake, huh? And, how was my little tongue work?</i>\" He asks with a smirk \"<i>Not as bad as you’ve though, right?</i>\"");
			outputText("\n\nWell, that was an interesting, and quite pleasant experience. You don’t mind repeating it sometimes. Thanking him again for his, surprisingly, amazing beakjob, you wave goodbye to him, and after getting dressed, return to the peacefulness of your camp.");
			player.orgasm();
			anzuAffection(5);
			flags[kFLAGS.ANZU_BLOWN_YOU_COUNTER]++;
			endEncounter();
		}

		private function suckOffDeitysCock():void {
			clearOutput();
			//outputText(images.showImage("anzu-sex-receive-blowjob"));
			if (flags[kFLAGS.ANZU_SUCKED_OFF_COUNTER] == 0) {
				outputText("Now that you’ve played a bit on the bed, it's time to get into business. The perfumed scent of the avian has been driving you crazy for a while, and now that you have a full sight of his athletic form, you attention goes down to his crotch. The thought of the hefty package inside his pants makes your mouth water. You then say Anzu that if he is stressed you’ll be more than happy to help him relieve pressure.");
				outputText("\n\n\"<i>Relieve pressure?</i>\"...He asks doubtfully.");
				outputText("\n\nPutting your hand on the bulge between his legs, you make yourself very clear about what kind of pressure are you talking about.");
				outputText("\n\n\"<i>Oh, you mean that... </i>\" the avian says with a shy smile \"<i>Well, I use to give myself relief from time to time, but has passed a time, and lately I feel a little…</i>\"");
				outputText("\n\nBy the flushed look on his face when he’s saying this and the tone of his voice, sound like the big bird don’t mind having his nuts emptied. Despite that, Anzu seems a bit shy about that. Seeing how he’ll need a little more motivation, you slip a hand through his underwear.");
				outputText("\n\n\"<i>So, you feel a little pent, up big boy?</i>\" you tease him, fondling his balls.");
				outputText("\n\n\"<i>Y-yes…</i>\" the avian answers, shuddering in delight at you touch.");
				outputText("\n\nYou keep teasing him, asking him if he’d like having your tongue wrapped around his meat while you suck and suck until he blows his load inside you mouth. That seems to give results, because his cock hardens at that thought. Finally, despite his nervousness, he accepts you offer.  Well, you couldn’t help him with his clothes put on, right? you say him.");
				outputText("\n\n\"<i>I think not…</i>\".");
				outputText("\n\nYou decide to take initiative this time and start undressing him. Luckily for you, he already has tossed away his robe, so you start with his shirt, which you leave on the floor, your hand caress the perfectly defined muscles on Anzu’s chest, going down until you reach to his pants. Taking them off too, you leave them on a heap over his shirt.The almost naked avian blushes red as you stare his magnificent body. With only his underwear getting between you and your prize, your take it off, leaving the forty inches of avian maleness exposed to your lustful desires. " + player.clothedOrNaked("You take off your [armor], leaving both of you naked and ready for action."));
			}
			else {
				outputText("Now that you’ve played a bit on the bed, it's time to get into business. The perfumed scent of the avian has been driving you crazy for a while, and now that you have a full sight of his athletic form, you attention goes down to his crotch. The thought of the hefty package inside his pants makes your mouth water. Resting over Anzu’s chest, you ask your avian friend if he wants to \"<i>relieve some pressure</i>\" again, reinforcing your offer with a playful grope to his crotch");
				outputText("\n\n</i>\"Well, how could say I no to such an offer?</i>\" He says, with a little laugh.");
				outputText("\n\nLooks like the big parrot has grown fond of your oral attention, you tell him with a grin. You slip a hand on his underwear and start fondling him. His tongue rolls out of his mouth in delight at your handjobs, before he answers.");
				outputText("\n\n\"<i>And you are getting attached to the taste of my cum.</i>\" he jokes, grabbing his manhood for emphasis. \"<i>Luckily for you, I’m here to please</i>\"");
				outputText("\n\nThen what are you doing dressed? You ask him seductively");
				outputText("\n\n\"<i>Well, since you’re so eager to get me, why you not come here and take them off by yourself?</i>\" he says playfully");
				outputText("\n\nYou jump to his side of the bed. His fancy robe has been tossed away a while ago, so you start with his shirt, which you leave on the floor, your hand caress the perfectly defined muscles on Anzu’s chest, going down until you reach to his pants. Taking them off too, you leave them on a heap over his shirt.The almost naked avian blushes red as you stare his magnificent body. With only his underwear getting between you and your prize, your take it off, leaving the forty inches of avian maleness exposed to your lustful desires. " + player.clothedOrNaked("You take off your [armor], leaving both of you naked and ready for action."));
			}
			outputText("\n\nAnzu reclines on his bed, in all his naked glory. ou take a moment to contemplate his impressive frame, the rainbow patterned colours of his plumage, that, added to the golden tones of his hair, give him a handsome and regal appearance. You delight your view on the tones and strong muscles of his chest, partially hidden beneath a layer of fluffy feathers. On his crotch, his half hard manhood and the pair of avian nuts that hang beneath capt your attention. Putting one finger on his belly, and circling his bellybutton with it, you ask Anzu if he’s ready to be worshipped like a god deserves.");
			if (flags[kFLAGS.ANZU_BLOWN_YOU_COUNTER] == 0) {
				outputText("\n\n\"<i>S-sure</i>\" he answers, flushed at your kinky proposal.");
			}
			else {
				outputText("\n\n\"<i>Well, show me what you have on mind then</i>\" the avian answers.");
			}
			outputText("\n\nYou playfully pass fingers over his belly a moment, caressing it softly. The smell of Anzu feathers, a smell of violets and snow hits your nose when you approach more to his body. The perfumed scent is so wonderful that you bury your face on the feathers of his lower belly. Then, a musky scent attracts you, spurring you to go lower, until you realize that your [face] is just over the avian’s crotch. You start your task licking them, sucking around the heavy orbs, while the feathers that cover them tickle your tongue. The musky scent of them, combined with the soft perfume of his body overwhelms your senses, and before you can notice it, your " + (player.hasCock() ? "[cock] is quickly hardening" : "your [pussy] moistens, and your body is getting infused by lust") + ".");
			outputText("\n\n\"<i>So...this is how you worship a god.</i>\" Anzu laughs, somewhat flustered \"<i>It’s a weird way to do it, but I have to admit that I like it.</i>\"");
			outputText("\n\nSmiling at his approval, you ignore your own lust and return to your main task. You keep worshipping his king-sized balls, warm to your touch, while you can hear the cum inside them churning. Continuing your task, you slowly make your way to your prize: his cock. When you finally reach it, you start licking its sides. Almost forty inches of pure avian meat, and it’s all for you. Taking its tapered glans on your hands, you give it a lick, eliciting a moan from the avian. One of his hands goes down your head, lovingly caressing your " + (player.hairLength > 0 ? "hair" : "[skin]") + ". You get a whiff of the musky and delicious scent of the thick tool before continuing.");
			outputText("\n\nThis time your tongue goes to his tip. Beads of pre leak from his cumslit, and your tongue eagerly delights on then, enjoying as the salty flavour inundates your tastebuds. Soon, the desire is too much, and your start sinking the meaty rod on your eager mouth. Having a long way to the end, you decide to start safely, and, bobbing down on it with pleasure, you engulf in your mouth on the first inches of his length, as your hand wraps around the base of Anzu’s manhood.");
			outputText("\n\nPulling out his cock, you look up to Anzu with a mischievous smile and, in the mood for a bit more of foreplay, you start sliding his cock in and out, while your tongue dances across its surface, as his pre drips from the corners of your mouth.");
			outputText("\n\n" + (player.tallness >= 50 ? (player.isNaga() ? "Taking some of the pre that leaks from his erection mixed with your saliva, you smear it on your tail tip and after making sure that it is well lubed, you slip it on his asshole, wriggling its way to his prostate" : "One of your hands start caressing his balls and finds its way to his anus, where you prod a finger inside a massage his prostate from the insides") : "You try to reach his anus, but due to his impressive frame, looks like you won’t reach much far. Instead, you cup his huge nuts and squeeze them gently") + ". Taken for the desire, Anzu lets out a moan of delight, putting his hands on your head and pushing his cock deeper inside your mouth. You gasp as several inches of the monster are forced on your mouth at once. Seeing your discomfort, he releases your head and lets you take control.");
			outputText("\n\nAfter taking some air, you return to main task. The pointed tip of the avian manhood makes your task easier, but, nevertheless, is a huge way to the end.");
			outputText("\n\n\"<i>Be sure you’re not biting off more of what you can chew</i>\" Anzu jokes lovingly, caressing your scruff.");
			outputText("\n\nPre slides down your throat as you bury more and more of his meat in your mouth, until the pointed tip of his cock reaches the back of your throat. Seeing how you can’t fit more of his titanic cock into your mouth, you focus on enjoying the filling sensation. Your " + (player.hasCock() ? "cock is rock hard, while the rest of your" : player.hasVagina() ? "vagina is drooling girlcum, while the rest of your" : "entire body is shuddering in heat") + ", excited by the delicious taste of Anzu’s pre.");
			outputText("\n\nTaking out his cock a little, you let its tip rest on the back of your tongue and guzzle the dribbling pre leaking on your mouth,  anxious for taste your creamy reward soon. You mouth drools all over his penis, and you lose yourself on the desire for a second, until the salty taste of his meat returns your mind to the job again.");
			outputText("\n\n" + (player.tallness >= 50 ? (player.isNaga() ? "Taking your tip tail out of his anus, you use it to pump the base of his cock" : "Your hand slips out off his anus and starts pumping the base of his cock") : "You take your hands off of his balls and use them to pump the base of his cock") + ", while you continue servicing his meat, bobbing down and forth across every inch of his avian penis. " + (player.hasLongTongue() ? "Your nimble tongue easily wraps around his throbbing meat and skillfully inserting the forked tip on his cumslit, you manage to take the last drops of pre. " : "") + "Between your sucking and the teasing that the avian is enduring, he must be on the brink of orgasm. Confirming your suspicions, Anzu, blushing red, manages to say between moans:");
			outputText("\n\n\"<i>[name], " + player.mf("boy", "girl") + " here it comes</i>\"");
			outputText("\n\nWith that his cumslit releases his load on your mouth. The first flood of semen inundates your mouth, with a strangely creamy and sweet taste that makes you want more. Wave after wave fill your throat, but determined to don’t let it waste, you keep drinking. You don’t care when the size of his load start to distend your stomach, the only thing that you want on this moment is more and more of his delicious seed.");
			player.refillHunger(80);
			if (player.gender > 0) outputText("\n\nWhile his load fills you, the excitement of having his hot seed on your mouth drags you to climax " + (player.hasCock() ? "spilling your load on the sheets" : "creaming your pussy in delight") + ".");
			outputText("\n\nAfter the seventh wave, the flow of semen distends your belly to the point that you look several months pregnant. You caress your now gravid stomach unthinkingly, as the last tides of cum finish to flood your gullet. When his orgasm subsides, Anzu lets his cock slide out of your mouth bathing your face and chest and staining heavily your [skin] with the leaking cum. Spent, the avian mutters:");
			outputText("\n\n\"<i>Thanks, [name]. I really needed that. But seems like I overfilled you this time. Do you want to rest with me?</i>\"");
			outputText("\n\nYou agree, jumping to his side with difficulty due the weight of his cum in your belly. Seeing your predicament, he helps you to stand up, and then embraces your body with both arms, surrounding it with his feathered wings. Soon, you are sleeping peacefully with his cum swirling in your belly and a satisfied look on both of your faces.");
			outputText("\n\nAfter a relaxing nap, and a thoroughly fulfilling meal, you bid farewell to your avian friend and return to your camp.");
			dynStats("lus", 30, "scale", false);
			anzuAffection(5);
			flags[kFLAGS.ANZU_SUCKED_OFF_COUNTER]++;
			endEncounter();
		}

		private function fuckGodlyBirdButt():void {
			clearOutput();
			//outputText(images.showImage("anzu-sex-analpitch"));
			outputText("In the mood for some bird butt, you tell Anzu that you'd like a turn on his ass.");
			if (flags[kFLAGS.ANZU_ANAL_PITCH_COUNTER] == 0) {
				outputText("\n\n\"<i>Well, you see, being, that I am…I never, well, had anything, or anyone, you know…back there…and…</i>\"");
				outputText("\n\nOh, It’s that. Well, there is a first time for everything. And you’ll make it a pleasant experience for both of you.");
				outputText("\n\n\"<i>If you say that...[name]. I think that I’ll trust in you.</i>\"");
				outputText("\n\nYou take off his robes and let them fall to the floor. He strips from his vest and pants, dropping them in the armchair" + player.clothedOrNakedLower(", while you remove your [armor]") + ". This done, you remove his underwear, leaving his avian cock bounce free in the air.");
				outputText("\n\nThen, you instruct him to lean on the bed, while you open his legs and caress the softness of his feathered buttcheeks. You prod one of your fingers inside his tight anus and find your way to his prostate while other caress his balls. The big bird blushes red under your ministrations.");
				outputText("\n\n\"<i>[name],...what are you doing?</i>\"");
				outputText("\n\nOnly assuring than his first time will be pleasant.");
			}
			else {
				outputText("\n\n\"<i>Okay [name]. I’m starting to like it</i>\" Anzu answers, blushing a bit");
				outputText("\n\nSure? He is a little too eager to only ‘start’ to liking it.");
				outputText("\n\n\"<i>Right, right. I really like it.</i>\" he admits. \"<i>But it’s your fault after all!</i>\"");
				outputText("\n\nWhile you remove your [armor]. He eagerly strips himself, dropping his robes and other clothes in a nearby armchair, and leaving his avian cock bounce free in the air.");
				outputText("\n\nHe leans on the soft mattress of his bed, while you open his legs and caress the softness of his feathered buttcheeks. You prod one of your fingers inside his tight anus and find your way to his prostate while other caress his balls. The big bird blushes red under your ministrations.");
			}
			outputText("\n\nYou tell him to relax, while you take care of him. Soon, your efforts start to give result,  when his huge cock arises. After a little more stimulation, pre starts to leak copiously from his avian maleness. Taking some in your hands, you start smearing it on his asshole" + (player.isTaur() ? "" : ", and then on your [cock]") + ".");
			outputText("\n\nYou decide to tease him for a bit, hotdogging your cock between his buttcheeks, moistening his butt feathers with your pre.");
			outputText("\n\nThen your cock meet the entrance of his rosebud, then, you start to penetrating him, slowly at the start, inch by inch, and then you increase your pace, until half of you cock is buried inside. A moan of delight escapes from Anzu’s mouth while you thrust inside him. If the hardness of his cock proof anything, he must be really enjoying this.");
			outputText("\n\nSeeing how you’ve had enough foreplay, you shove the rest of your cock at once. With the amount of pre covering, it slips inside easily. Anzu gasps at the sudden intrusion, but quickly relaxes at the feeling of you cock sliding inside and outside his anus.");
			outputText("\n\nYou increase the rhythm of your thrusts until you’re close to climax. Your avian companion, close too, tries to jerk off, but he is too overstimulated to do that. After a few attempts, he lets you take enterally the charge of the situation, letting his tongue roll outside his beak, while enjoying the feeling of your cock in his anus.");
			if (player.cumQ() < 1000) {
				outputText("\n\nFinally, you release your load inside him, filling his insides with your cum. Seeing how he hasn’t got his release yet, you grab his cock and start jerking him.");
			}
			else {
				outputText("\n\nYou stuff the bird so full of cum, that of Anzu’s belly, despite his size, manage to gain a considerable bulge. " + (player.hasKnot() ? "Some of your cum tries to escape, but your knot prevents any drop to waste, inflating even more the poor avian’s belly. " : "Even some of your cum overflows his hole, painting his butt feathers white. ") + "Seeing how he hasn’t got his release yet, you grab his cock and start jerking him.");
			}

			outputText("\n\nA few seconds later, Anzu cums too. Most of his cum lands on his face and belly, leaving him a sticky mess, but some of it manage to hit you in the face. While he licks clean his face with his long tongue, you " + (player.hasLongTongue() ? "lick his cum from your face" : "use the feathers of his tail to whip his cum from your face") + ".");
			outputText("\n\nYou remove your cock, letting a little of your flow from his asshole. Then, you recline over him, licking his cum off his chest. The feeling of his feathers tickles your tongue. Anzu then hugs you with both arms, and says, blushing:");
			outputText("\n\n\"<i>[name], that was...great. I haven’t had so much fun in a while</i>\" he admits.");
			outputText("\n\nYou tell him that you had a great time too.");
			outputText("\n\nTired, you fall asleep over him, using his body as a huge pillow. He covers you with his wings, while both of you take a nap.");
			player.orgasm();
			flags[kFLAGS.ANZU_ANAL_PITCH_COUNTER]++;
			endEncounter();
		}

		private function feedAnzu():void {
			clearOutput();
			//outputText(images.showImage("anzu-sex-feeding"));
			if (flags[kFLAGS.ANZU_FED_COUNTER] == 0) {
				outputText("While resting with him on the bed, you feel a familiar weight on your breasts. Sensing the milky gift barely contained by your [chest], why not share a little of it with your avian " + (anzuRelationshipLevel() >= 4 ? "lover" : "friend") + "?");
				outputText("\n\nYour ask Anzu if he suddenly felt thirsty. He doesn’t seem to understand what exactly you’re offering him, as he asks:");
				outputText("\n\n\"<i>Thirsty, hmm?... Not so much, but if you want something I can go to the kitchen and…</i>\"");
				outputText("\n\nMaking the things more clear, you explain that you’re offering to sate his thirst with your milk, cupping your filled breasts while you do so. ");
				if (player.cockTotal() > 0) outputText("His eyes dart to your crotch, focusing on your [cock] but, you dispel his misguided idea, jiggling your tits again to entice him. ");
				else outputText("\n\nThe avian seems unsure at the idea.");
				outputText("\n\n\"<i>Well, this is a bit, how to say it, weird. You know, I left to be a little kid some thousands years ago, and the idea that someone catching me doing this is, embarrassing</i>\"");
				//Will need to put a check for quest completion here
				//TODO: check if Revamp is finished
				//if (true) {
					outputText("\n\nAnd how much people he can see hanging around the palace now? Besides, it’s nothing to be ashamed. You only want to share a very intimate moment with him, if he is okay with that.");
					outputText("\n\n\"<i>Well, if you put it in that way, I suppose that I haven’t any reason to say no?</i>\"");
				/*}
				else { // 9999
					outputText("\n\nMaybe you have in home some guests by now, but who are them to judge him, anyways? Besides, for the way that he regards them, he doesn’t seem like the kind of guy that gets worried about everyone’s opinion about him.");
					outputText("\n\n\"<i>Heh, it’s hard to don’t notice it, right?</i>\"  he answers, with a soft laugh \"<i>Alright, you win. I’ll give it a try.</i>\"");
					outputText("\n\nPutting one of his hand of your breasts shyly, he starts cupping them, caressing the soft orbs with his huge but surprisingly nimble fingers. Taking a little more confidence, he teases one of your nipples with the point of one of his short claws, prompting a jet of milk squirt off, with enough force and aim to hit him on the face.");
					outputText("\n\nThe surprised avian blushes as he sees your milk dripping from his face. Somewhat nervous, he takes some of it and licks it with his tongue.");
				}*/
			}
			else {
				outputText("\n\nWhile resting with him on the bed, you feel a familiar weight on your breasts. Sensing the milky gift barely contained by your [chest], why not share a little of it with your avian " + (anzuRelationshipLevel() < 4 ? "friend" : "lover") + "?");
				outputText("\n\nYour ask Anzu if he suddenly felt thirsty. This time he agrees without too much hesitation.");
				if (player.cockTotal() > 0) outputText("Darting his sight to your crotch, he tries to slip a hand inside the lower part of your [armor]. Taking his misguided hand and putting in on your breasts, you make clear what you want to do.");
				outputText("\n\n\"<i>Oh, you mean that milk…well, it may not be as tasty as the other</i>\" he answers, his eyes remaining on the bulge of your clothes.  \"<i>But, well, I’m up to it.</i>\"");
				outputText("\n\nYou take his hand and put it on your breasts, letting him fondle them. He caresses the soft orbs with his huge but surprisingly nimble fingers. Having lost his initial doubts, he soon is teasing your nipples, making some of your milk drips from them.");
			}
			outputText("\n\nHe keeps caressing the soft [skin] of your breasts, prompting more drops of milk dribble from your nipples.");
			outputText("\n\nYou suddenly feel how he removes his hands from your breasts, but, before you can protest, he grabs your chest again, and now with his tongue, he teases your nipples, licking them clean from the milk that started leaking.");
			outputText("\n\nOpening wide his beak, he fondles your breasts, forcing more milk out. You leave the milky goodness fall on his tongue. He drinks it all with a pleased gesture, that makes you think that, despite his initial protests, he really likes it. Soon, his tongue focuses again on your nipples licking the rich milk as it comes out.");
			outputText("\n\nYou motion him for he lies on his back while you feed him. Somewhat confused, he does so. Luckily for you, he is much less heavy than you expected, and most of his weight is carried by the bed under you.");
			outputText("\n\nIt’s kind of cute, though. Anzu laying on your chest, happily drinking your milk like a little child, only that this little child is " + (player.tallness >= 96 ? "way larger" : "many times larger than you") + ". His tongue coils gently around your nipples, making them ooze streaks of white that are quickly cleaned by the eager avian.");
			outputText("\n\n\"<i>So, the little baby is liking his meal?</i>\" you tease him.");
			outputText("\n\n\"<i>Hey, I’m not a baby!</i>\" He protests, only to be hit by a streak of white on the face, that is quickly cleaned by his nimble tongue.");
			outputText("\n\n\"<i>Okay, big boy, but you are clearly enjoying yourself.</i>\" You answer him, after realizing the noticeable erection between his legs.");
			outputText("\n\n\"<i>Heh, sorry, it's only that…</i>\" he says, his cheeks blushing red. \"<i>Well, being so close of you, makes me feel a little flustered.</i>\"");
			outputText("\n\nWell, seems like he is really enjoying it, after all. After the pleasant treatment that you breasts are receiving, the soon let out the real flow, that is quickly swallowed by the big bird. You let him rest his head on your breast while he sucks your milk.");
			if (player.lactationQ() < 500) outputText("\n\nAfter a while, your breast found themselves depleted again until Anzu’s playful ministrations. Giving the avian a look, you can see him licking the white spots of milk that dribbled to the sides of his beak. When he realizes that you are looking at him, he blushes and says.");
			else outputText("\n\nYour prodigious bounty keep producing milk for a long time, making the task of drinking it all increasingly difficult for your avian friend. When the flow of milk finally ends, his belly has swelled a bit despite the size of his owner. You give it a playful poke, earning a blush from the overfilled avian.");
			if (flags[kFLAGS.ANZU_FED_COUNTER] == 0) {
				outputText("\n\n\"<i>Huh, that was…nice.</i>\"");
				outputText("\n\nYou say that you’re glad that he liked his drink, and despite his embarrassment, he managed to even enjoy it. Anzu answers with a soft laugh, and giving your breast a look, he asks you.");
				outputText("\n\n\"<i>So, i'd like to repeat it again, when your breasts feel to full again… Well if you don’t mind</i>\"");
				outputText("\n\nOf course, but for now, they’re quite empty. You’ll return to the camp for rest and return to him when you’re in the mood to give him milk again. After saying your goodbyes to the avian, you find your way through the Rift and return safely to your camp.");
			}
			else {
				outputText("\n\n\"<i>Tasty, as always, [name]. Thanks again, for letting me have a drink.</i>\" Anzu says, hugging your upper body in the soft embrace of his warm feathers.");
				outputText("\n\nYou stay this for a while, with the heat of the avian breath on you neck, and his feathers tickling your [skin]. After some more cuddling, you stand up and redress yourself, not without giving Anzu a last view of your bare chest. The avian then asks:");
				outputText("\n\n\"<i>You’ll return here again when your breasts feel too full, right?</i>\" He asks, looking at you with his cheeks somewhat red in mild embarrassment \"<i>I’ve grown a taste for your milk…</i>\"");
				outputText("\n\nSure, you answer him, but for now, you have to let them rest for a bit. After saying your goodbyes to the avian, you find your way through the Rift and return safely to your camp.");
			}
			dynStats("lus", 20, "sen", -1);
			player.milked();
			flags[kFLAGS.ANZU_FED_COUNTER]++;
			endEncounter();
		}

		//Dinner
		public function dinnerWithAnzu():void {
			clearOutput();
			dungeonLoc = DUNGEON_ANZU_DINING_ROOM;
			if (model.time.hours == 8) {
				//outputText(images.showImage("anzu-prep-breakfast"));
				if (flags[kFLAGS.ANZU_TIMES_DINED_BREAKFAST] == 0) {
					outputText("Arriving early to his palace, you search for Anzu until you find him in the kitchen, naked except for an apron. He is cooking some eggs in a frying pan, while watching how some pieces of bacon are cooking in another. The avian is so busy with his labour that he doesn’t notice your arrival.");
					outputText("\n\nYou cough a bit for announcing your presence.");
					outputText("\n\n\"<i>[name]! I wasn’t expecting you came here so early.</i>\" He says, a little embarrassed by the fact you found him almost naked. \"<i>I woke up only a few minutes ago and, since I was hungry, came here to make me something to eat.</i>\"");
					outputText("\n\nThat’s explain him being naked. But, from where he got the eggs and the meat?");
					outputText("\n\n\"<i>I bought some of my supplies from the reindeer people, and others, while foraging the rift. I manage to find berries, eggs, and some creatures who provide me the meat that I’m cooking now, and I buy bread, flour, milk, nuts, butter, cheese, beer and wine from the reindeers. A wanderer merchant travels around the borders of the Rift, and sells me sugar, salt, pepper and spices. Sometimes I get fish on the frozen lakes between the hills.</i>\"");
					outputText("\n\nDistracted from the food, he lets the eggs burn while he is explaining this. When you try to prevent him, it’s too late.");
					outputText("\n\n\"<i>Damn! No matter, I have more, I’ll cook them later.</i>\" He says. \"<i>Anyways, I usually eat alone. Maybe, If you want,… you can make me company while I cook, and later, have breakfast with me.</i>\" Anzu offers.");
				}
				else {
					outputText("You find Anzu in the kitchen again. The avian is as naked as before, with only his apron put on.  He is cooking some eggs in one pan, and putting some pieces of sliced bread in a plate next to the stove. This time, he notices you as soon as you approach to the door.");
					outputText("\n\n\"<i>Hi, [name]. You caught me making the breakfast. I always wake up hungry in the mornings.</i>\"");
					outputText("\n\nJudging for all the eggs, bacon and bread that he has taken from make his breakfast, he definitely is saying the truth. Then, he looks at you and says:");
					outputText("\n\n\"<i>You see, not all of this is really for me. After your last visit, I was hoping to see you again... and I prepared an extra portion and…</i>\"");
					outputText("\n\nAnd?");
					outputText("\n\n\"<i>Well… do you want to have breakfast with me again?</i>\"");
				}
				doYesNo(eatFoodWithAnzu, dontEatFoodWithAnzu);
			}
			else if (model.time.hours == 13) {
				//outputText(images.showImage("anzu-prep-lunch"));
				outputText("When you arrive to the palace, a smell of meat cooking attracts your attention. The smell leads you to the kitchen, and when your enter, you find Anzu taking some roasted steaks from a grill. Looks like this time he has left behind his robes, and now he’s wearing a white apron over his set of shirt and pants. When putting the steaks on a plate, he manages to look you and says.");
				outputText("\n\n\"<i>[name]. You’re here! Looks like you’ve arrived just in time. As you see, I’m cooking the meal.</i>\" He says, pointing the tables around him.");
				outputText("\n\nOn the tables near the stove are many slices of what once were a huge cheese, some pieces of bread, with some bunches of grapes on the left. Isn’t too much for a midday lunch?");
				outputText("\n\n\"<i>You see, I usually eat much more food at noon than in the dinner. Since I’ve almost finished with the main dish, you could help me, and then we could eat together. If you want, of course.</i>\"");
				doYesNo(eatFoodWithAnzu, dontEatFoodWithAnzu);
			}
			else {
				if (flags[kFLAGS.ANZU_TIMES_DINED_DINNER] == 0) {
					outputText("The noises of someone moving things is heard even from the hall. When you approach to the kitchen, you manage to hear the voice of an irritated Anzu. Dressed only in his usual set of shirt and pants, covered with an apron instead of his robes, he goes around the kitchen searching for something desperately.");
					outputText("\n\n\"Where in hell I put those damn blueberries?! Raspberries, strawberries, cloudberries, but no trace of blueberries!\"");
					outputText("\n\nWhat could be doing Anzu with blueberries? Whatever that is, the fact of he can’t find them doesn’t make him happy. Maybe this isn’t the best time for showing yourself. Your feelings are proven right when a dish flies over your head, smashing to pieces in a nearby wall. You’re about to leave when he stops you.");
					outputText("\n\n\"[name], excuse me. I’m a little frustrated.\"");
					outputText("\n\nHis frustration has something to do with blueberries?");
					outputText("\n\n\"Yeah. Actually, I was trying to cook a cheesecake with blueberries for dinner, but I can’t find the damn fruits anywhere.\"");
					outputText("\n\nTrying to calm him down, you tell that you’ll help him to find the blueberries. Looking around the kitchen with attention, after a short inspection, you manage to find them on the table where Anzu has put some eggs and flour, partially hidden by the other ingredients. You let out a little laugh at your discover, and then reveal him where the blueberries were all the time.");
					outputText("\n\n\"Oh, they are there!\" He says, visibly embarrassed. \"I probably was too busy looking in the cabinets that I don’t realize that I already had put them with the rest of the ingredients.\"  \"Now, since you’re here, maybe you could help me to finish this faster. I’ve lost many time searching for those fruits.");
					outputText("\n\nSeeing how he is a little stressed, the best of you can do is leave him for a while, because it could turn into a dangerous situation if he can’t find another ingredient.");
					outputText("\n\n\"No, no. Sorry, my friend. I have all the remaining ingredients there.\" He says, pointing to the table, where sugar, butter, and a bottle of milk lies. \"I promise to not get mad with you, even if you burn half of the kitchen.\"");
					outputText("\n\nLooks like he’s asking you for help to finish the cake, and have a nice dinner after that.");
				}
				else {
					outputText("Coming again to the kitchen, a much calmer Anzu is mixing the ingredients for another cake. Like the last time, he’s using the usual apron over his shirt and pants.");
					outputText("\n\nYou ask him if he's lost the blueberries again.");
					outputText("\n\n\"No, I’m not losing the damn fruits again.\" He says, pointing a quite visible and labeled flash with one hand. \"Just when you arrived, I was preparing myself to make a cake with some of them. Do you want to join me?");
					outputText("\n\nLooks like he’s asking you for help to finish the cake, and have a nice dinner after that.");
				}
				doYesNo(eatFoodWithAnzu, dontEatFoodWithAnzu);
			}

		}

		private function eatFoodWithAnzu():void {
			clearOutput();
			//Determine amount to refill hunger
			var hungerRefillAmount:int = 50;
			hungerRefillAmount -= Math.floor(player.hunger / 4);
			if (hungerRefillAmount < 20) hungerRefillAmount = 20;
			if (model.time.hours == 8) {
				outputText("You answer giving him a quick peck on his cheek and saying that you’d love to have breakfast with him.");
				outputText("\n\n\"<i>Excellent.</i>\" He says \"<i>If you want, you could help me to make the food ready</i>\"");
				outputText("\n\nAccepting his offer, you start helping him to do the breakfast. Taking some butter from the cabinets, you take with you the slices of breads in the plate and smear them with the butter, and put them in the stove until the butter on it melts. After that, you put them on a big plate.");
				outputText("\n\nMeanwhile, Anzu is busy with the eggs. He added a couple more for you after seeing your arrival. After serving the eggs in two plates, he starts frying bacon in another pan. What would be a couple of eggs without bacon?");
				outputText("\n\nWhen the bacon is ready, he put it next to the eggs and spreads salt and pepper on them. After serving the plates with eggs and bacon, he points you some bottles with milk and the cabinet when the glasses are stored.");
				outputText("\n\nYou fill a jar with milk and put it on a nearby table, where two glasses and a plate with bread is waiting. Anzu leaves the plate with the bread on the dining room, and returns for the jar with milk and the glasses, while you carry the plates with eggs and bacon.");
				outputText("\n\nWhile eating, you manage to look how he hasn’t bothered to get dressed to the breakfast, and now without his apron, exhibits his naked body to you without shame. The breakfast is quite delicious. Anzu certainly had a lot of practice cooking for himself all that years, you think while savouring the perfectly spiced eggs and the bacon.");
				player.refillHunger(hungerRefillAmount);
				outputText("\n\nAfter eating, both of you chat for a while. Anzu tells your more stories of his former world, while he listens about some of your adventures in Mareth and about your home back on Ingnam.");
				flags[kFLAGS.ANZU_TIMES_DINED_BREAKFAST]++;
			}
			else if (model.time.hours == 13) {
				//outputText(images.showImage("anzu-dining-lunch"));
				outputText("With your appetite open by the wonderful smell of the steaks, you accept Anzu’s offer.");
				outputText("\n\n\"We must start now, then. There are some dishes that still need be finished.\"");
				outputText("\n\nAsking him about what you should do, he instructs you about how make the second dish. Taking a pot from one cabinet, you shred the chunks of cheese inside it, and mix them. After that, you place the pot on a burner until all the cheese on it melts. You put the pot with the burner on a plate next to a bowl with some pieces of bread and two large forks. It’s a little difficult to carry those things to the dining room, specially with the melted cheese, but you manage to arrive to the table with the food safe.");
				outputText("\n\nMeanwhile, Anzu has already left the plates with the roasted steaks on the table and now he’s busy washing the grapes in the sink, and after assuring that all of them are clean, he puts them on a bowl. He proceeds lo leave them in the dining room with the rest of the dishes, and hurries to the cellar. A few minutes after, he comes back with two glasses and a bottle of wine.");
				outputText("\n\n\"Hope you like the white wine. It’s the only one that the reindeers have to sell me.\"");
				outputText("\n\nSure. A glass of wine is a luxury, which, even on Ingnam, you rarely had. He serves one glass for you and another of him.");
				outputText("\n\nWhile you dip the bread in the cheese, you start finding increasingly amusing the way of Anzu, and you spend your time. There has been a while since your had another opportunity to make a decent homemade meal. But for now you have things more important to attend, like the roasted steak in front of who is making your mouth water. After both of you finish your food, you chat with Anzu for a while. ");
				player.refillHunger(hungerRefillAmount);
				outputText("\n\n\"And [name], what’s going on that city in the desert. Tolk, no Toll, Tel’Adre was its name, right? \" he asks \"I’ve had few opportunities to going beyond the Rift limits, let alone exploring a zone so far as the desert, and for the things you’ve told me, I wonder how big it is, how they keep themselves safe, and things like that .\"");
				outputText("\n\nHmm, how to start. You explain to him that the city is protected by a kind of magical barrier that prevent demons to find it. The city itself if pretty big, as far as compared to the rest of settlements of you’ve found in Mareth. Great part of the city are formed by the housing complexes, most of them are unoccupied, though, and in the center the city the principal building are the bakery, the bar, the gym, the shops on the market, a mostly abandoned park, the mage’s tower, and the Watch headquarters.");
				outputText("\n\nYou give him more details about the bakery and its particular workers, especially its chef. The gym isn’t less strange either, especially with the additional exercise programs that some trainers are willing to teach. The mage’s tower is the heavily protected plate where most mages reside, keeping the barrier stable. Not much is what can you say about the park, little more than a patch of neglected dirt and grass between the city’s blocks. In the center are some restaurants too, while the market has a pawn shop, and some others specialized in selling construction materials, weapons, armours, clothes. An acupuncture treatment clinic and a tattoo parlor have their places on the market too. Finally, you explain all you know about the Watch and how they protect the city from both the inside as from the outside menaces.");
				if (flags[kFLAGS.URTA_VIXEN_AND_CREAM_COUNTER] == 0) {
					outputText("After chatting about this and that with Anzu for some time, you thank him for the meal, say your goodbyes and return to your camp.");
				}
				else {
					outputText("\n\n\"And how about the bar?\" Anzu asks \"You’ve mentioned a bar before. Is there some good wine there?\"");
					outputText("\n\nOh, the Wet Bitch, how you could forget it!");
					outputText("\n\n\"Wet Bitch, what a name. It’s only me or that’s a little unimaginative. At least, I know what I could find inside with only reading its name on the front.\"");
					outputText("\n\nNot exactly. Well, not at all. Besides its name, it has most of the things who a normal bar has. Chairs, tables, drinks, people chatting and laughing, and given the uninhibited air from Mareth, people having sex in the back rooms or even in front of all.");
					outputText("\n\n\"You must know that by experience, Am I right?\"");
					outputText("\n\nYou admit that you’ve had your romps here and there.");
				}
				flags[kFLAGS.ANZU_TIMES_DINED_LUNCH]++;
			}
			else {
				outputText("Nothing like a good dinner to end a good day, you tell him.");
				outputText("\n\nHappy to have your help, Anzu explains to you the process to make the cake. While you heat the oven following his instructions, he makes the base mixing some biscuit crumbs and butter on a large, round tin putting it on the oven. After that, he points you the blueberries and motions you to work with them.");
				outputText("\n\nHe starts whisking up the creamy cheese with some eggs, sugar and flour. Meanwhile, you're busy with the blueberries, putting them on a pan with some sugar and water and mixing them until the contents of the pan becomes sauce.");
				outputText("\n\nAnzu, who already has finished with the cheesecake mixture, pours some of it over the biscuit base, and you spoon most of the blueberry sauce with the cheese mix. Then, he covers it with the remaining cheesecake mix and softens the surface with a spoon. Finally, he lets you drizzle the remaining blueberry sauce over the cake and ripple it over the cake.");
				outputText("\n\nBoth of you put the cake on the oven and let it cook for some minutes. When it’s ready, Anzu takes the cake out of the tin and cut it in slices.");
				outputText("\n\nHe goes to the dining room with the cake and two dishes, while you follow him with the milk and the glasses.");
				outputText("\n\nEnjoying the sweet taste of the cheesecake with your friend, both of you talk a little about your adventures. While talking, both of you indulge in more slices of the delicious cake. Soon enough the plate with the cake is empty.");
				player.refillHunger(hungerRefillAmount);
				outputText("\n\n\"I think the cake for tonight was a total success.\" Anzu says proudly.");
				outputText("\n\nYou can’t agree more. But, seeing how late is, the better is that you return to your camp. After thanking the avian for the dinner, you wave off and return to your camp.");
				flags[kFLAGS.ANZU_TIMES_DINED_DINNER]++;
			}
			inDungeon = false;
			endEncounter();
		}
		private function dontEatFoodWithAnzu():void {
			clearOutput();
			if (model.time.hours == 8) {
				outputText("You thank him for his offer, but state how you already had your breakfast.");
				outputText("\n\n\"<i>Oh, it’s okay</i>\" he says, a little disappointed. \"<i>Well, if you change your mind, you know where find me on the mornings.</i>\"");
				outputText("\n\nLeaving the cooking avian to his own matters, you return to your camp.");
			}
			else if (model.time.hours == 13) {
				outputText("Excusing yourself, you tell him that you don’t have much time now. Maybe in another opportunity.");
				outputText("\n\n\"<i>No matter, friend. If you change your mind and want to eat with me, come here tomorrow, or another day.</i>\" He says, pointing the empty dining room. \"<i>I have more than enough room for us</i>\"");
				outputText("\n\nYou’ll see. After waving bye to Anzu, you come back to your camp.");

			}
			else {
				outputText("Telling him that, for the moment, you don’t want to have dinner, you thank him anyways.");
				outputText("\n\n\"Well, friend, I’ll be here is you change your mind\" he answers.");
				outputText("\n\nLeaving Anzu with the cake, you wave off him and return to your camp.");
			}
			inDungeon = false;
			endEncounter();
		}


		//------------
		// BATHING (2PM)
		//------------
		public function anzuBathTimeBeginning():void {
			clearOutput();
			outputText("Wandering again across the halls of the palace, you notice than Anzu isn't in his usual spot at this time of the day, reading a book in the tranquility of his living room. Actually, he isn’t in the kitchen either. A little confused about his whereabouts you search him across the palace, a task a bit difficult given its dimensions and the quantity of rooms.");
			outputText("\n\nAfter an infructuous search you end looking at the window of the third floor, thinking that he may be gone outside, until you realize that you haven’t searched in one of the most obvious places: his bedroom. Joining action to the thought, you return downstairs to the first floor, and opening the gate to the opulent room, you find it empty. Seems like the bird doesn’t want to be found today.");
			outputText("\n\nJust when you’re about to return to the camp, you manage to hear a low whistle coming from the end of hall, behind the large portion of the floor occupied by Anzu’s room. Soon you remember that this must be the bathroom, and that would explain the avian’s absence. Upon getting closer to the door, your nose is assaulted by a fragrance even more exquisite than the sweet scent of violets that perfumes the rooms.");
			outputText("\n\nAs you push the door open, you spot the avian relaxing in his bath, or rather a pool from the look of its size. ");
			outputText("\n\nFilled with a water so crystalline that you can see its bottom, despite some bubbles and soap here and there, the pool is big enough to give Anzu room to stretch his arms and legs easily, and even to have a couple of partner. Hell, this thing is big enough to gather most of your lovers inside. Scattered on a near table are a few flasks containing which must be aromatic oils from the scent you recognize some kinds of aromatic woods, and lavender.");
			outputText("\n\nWhile you’re busy appreciating the scents, your giant lover notices your presence on the door and waves you over");
			outputText("\n\n\"<i>Hey, [name]! Seems like you couldn’t resist the temptation of seeing me naked again, huh?</i>\" the avian says, greeting you with a playful grin.");
			outputText("\n\nYou explain that you were looking for him, and since you didn’t find him in any room, you came here, thinking that he could be here, and just as you thought, here it is, the bird on his bath.");
			outputText("\n\n\"<i>Well, you found me. I usually take a bath at this time of day to relax. The warm water does wonders to the muscles you know, and, for the way that you keep smelling the room, seems like you appreciate the lavender oil that I’ve poured on the bath.</i>\"");
			outputText("\n\nYeah, it’s a pretty pleasant and calm smell.");
			outputText("\n\n\"<i>Hmm, I could use a little of company, [name]. Besides, there’s plenty of space inside.</i>\"  Anzu offers.");
			outputText("\n\nSeems like the bird want to take his bath with you, but knowing him, you’ll probably end a bit sticky throughout your bath. What do you say?");
			doYesNo(anzuBathTimeAccept, anzuBathTimeDecline);
		}

		private function anzuBathTimeAccept():void {
			clearOutput();
			outputText("Well, a warm bath sounds nice at this time of the day, and Anzu seems to be enjoying it, so, why not? " + player.clothedOrNaked("Leaving your " + player.armorDescript() + "aside, on a nearby table, y", "Y") + "ou get in the pool, not without making sure that Anzu gets a good view of your naked body when entering on it. When you return the look, you manage to see his avian manhood under the water, hanging limp and lazy between his legs. Even in its unaroused state, it remains quite impressive. Under it, a pair of huge, feather-covered, nuts lie, moving slightly with the water.");
			outputText("\n\n\"<i>Ehh, you…you look pretty nice today, [name]</i>\"  the avian says, interrupting your ogling of his privates, while blushing deeply without keeping his eyes away of your body and " + (player.hasCock() ? "hanging [cock] that swings playfully as you descend upon the pool" : "your exposed nether lips as your descend upon the pool") + ".");
			outputText("\n\nYou place yourself on the pool as gingerly as you can, [if (tallness >= 120)sitting|standing] on the tiles no too far away from him. The water itself is pleasantly warm, and the relaxing scents of oils mixed with the soap perfumed scent soon get to your body, as you start feeling your mind calmer, and your body more relaxed.");
			outputText("\n\n\"<i>It's quite nice, right?</i>\" Anzu says, standing to get closer to you. \"<i>I'm not a fan of taking baths on frozen lakes, and I'm pretty sure that in the worst areas of Mareth, having a bath or even water is even a luxury, so I thought, that, me having this bath, and you, having to stand the driest deserts and worse things, I’ll be good for you taking a break and relax, and I guessed that I’ll be good for both of us if we two...em...share this bath together, and...</i>\" Anzu continues, blushing in a bit of embarrassment as he talks.");
			outputText("\n\nSeeing the giant and usually confident bird so flustered and nervous when talking to you is quite a cute sight. You reassure him telling that you're very grateful that he decide to share his bath with you.");
			outputText("\n\n\"<i>No, seriously, it was nothing. Being alone all the time isn't fun, so every moment that I can spend with you is special. And everything that I have, is here to be shared with my special someone.</i>\" Anzu says, blushing as red as a tomato when saying this least.");
			outputText("\n\nStaring at the pool of teal that are his eyes, you don't realize when, but soon you feel your [if (tallness >= 120)frame|[if (tallness >= 80)smaller frame|much smaller frame]] surrounded but his strong arms. The feeling of his wet feathers tickles your damp [skin], and you giggle at the sensation, and soon your lifted a little by his arms, as he envelops you in a strong hug. His hand caress your back, and he whispers on your ear lovingly:");
			outputText("\n\n\"<i>Thanks, [name]. For taking your time to get this forgotten place in the middle of the snow. Thanks for spending your time visiting this lonely and exiled god. But above everything, thanks for staying with me and being the most wonderful companion that I could be asked</i>\".");
			outputText("\n\nThe two of you keep the hug for a while, until the avian notices that some time has passed and, still blushing, breaks the hug.");
			outputText("\n\n\"<i>Heh, sorry. I got too cheesy for a moment.</i>\" Anzu says, sitting again to your side. \"<i>Anyways, the idea is that we take a bath together, and since you're my guest, I could being take care of you...of course, if you wish</i>\"");
			outputText("\n\nSince he’s been nothing but nice, how you could refuse his offer?, you tell him playfully. When he hears this, he smiles at you and takes one of the aromatic soaps that are on a plate on his side of the pool.");
			outputText("\n\nLooking at your smaller body at his side, he suggests: \"<i>[if (tallness < 120)I'll be more comfortable for you if you sit down while I take care of you,|Well, I'll be better if I go closer to take care of you, and...if you're okay with it...you could sit on my lap...while I...you know.]</i>\" Anzu says nervously.");
			outputText("\n\nSeeming no harm on his offering you sit on his lap, and he, faithful to his word, starts scrubbing softly your body with the soap, then massaging your back and shoulders working tenderly each sore muscle. While you enjoy his ministrations, you sit better, resting your legs over their own while he carefully rubs the soap on your [skin], [if (tallness >= 100)aided for his larger frame|aided by his towering frame]. As he does that, you realize that your butt is resting pretty close of the avian crotch, and that your close contact is making the big avian more than a bit flustered, if his erect cock is proof of anything.");
			outputText("\n\nWell, given how hot and bothered Anzu is getting from rubbing naked against your body, you could take this as an invitation for a more...intimate intercourse with the bathing bird, given that you’ll probably end a bit dirty (and quite filled) in the end. On the other side, you could simply leave your kinkyness aside for a while and simply enjoy the bath with him.");
			dynStats("lus", 30, "scale", false);
			menu();
			addButton(0, "Sexy times", anzuBathTimeSex);
			addButton(1, "Just relax", anzuBathTimeRelax);
		}

		private function anzuBathTimeSex():void {
			clearOutput();
			//outputText(images.showImage("anzu-bathtime-sex"));
			outputText("You take the initiative, rubbing your backside against Anzu’s maleness, who stands proudly erect, now smearing your back with avian pre, that is quickly washed away by the water.");
			outputText("\n\n\"<i>Heh, seems like a got a bit...., you know...[name]</i>\" Anzu says with a soft laugh, yet a bit embarrassed, after seeing his raging erection over your back. \"<i>And, having you so close, it’s no wonder that I eventually got a bit excited.</i>\"  he admits.");
			outputText("\n\nHmm, seems like it can’t be helped, at least with someone that gets aroused so quickly like him, you remark.");
			outputText("\n\nReclining your body against his, and rubbing your backside against his penis, you enjoy for a second the slimy sensation of his pre on your " + player.skin.desc + " while your upper body rests over his belly, the feeling of his wet and soapy feathers being and odd but quite pleasant sensation.");
			outputText("\n\nAfter some more rubbing, you start grinding your [ass] against his iron hard erection, one of your hands going down to knead softly his hefty sack. A look back reveals to you that your teasing had the desired effect, as Anzu face is blushing red, his breaths turning to half-measured pants, as the horny avian does useless efforts to hide his overexcited state.");
			outputText("\n\nSoon, he gives up, and realizing that you aren’t being exactly a nice visitor, leaving him on that state, you finally ask him:");
			outputText("\n\n\"<i>So, do you want to...relieve some pressure while we bath?</i>\"");
			player.fatigue -= 30;
			anzuSexMenu(false);
		}

		private function anzuBathTimeRelax():void {
			clearOutput();
			//outputText(images.showImage("anzu-bathtime-relax"));
			outputText("As fun as it could be, you decided to take a bath for cleanse your body, no for making it dirtier, so your attention diverges from Anzu's rod. ");
			outputText("\n\nNow focusing on having all stressful thing that plague Mareth of your mind, you let your [legs] rest on the tiled bottom of the indoor pool, while your body enjoys the warm feeling of water on your [skinfurscales]. Your mind diverges to peaceful thoughts, away from this cursed place, reminiscences of your home on Ingnam, your village, and about all the good things that you have found that this land, that despite its cursed nature, has allowed to survive fills your mind and calm your troubled body.");
			outputText("\n\nAfter a while, a tickling sensations distracts you from those musings, and you turn back your head to find Anzu pouring a small receptacle containing a pearlish pink, oily liquid over your back and shoulders and rubbing it softly over your [skinfurscales]. It’s floral and pleasant smells tells your quickly that it must be a kind of aromatic soap.");
			outputText("\n\n\"<i>Rose’s essence, quite good for relieving tension and calming the mind and soul, at least, that’s what people says </i>\" Anzu confirms, at the time that pours a bit more on your head and gives it the same treatment.");
			outputText("\n\nWith, your body thoroughly covered in a layer of pinkish soap, he starts giving your arms and back a massage, having care to tend to your most weary muscles. He turns being quite good at that, all the tension on your body disappearing, aided without a doubt in the calming water surrounding you.");
			outputText("\n\nAfter he’s assured that every bit on your body has been thoroughly massaged and cleaned, he takes some clean water and start pouring it over you, wiping away the soap from your [skinFurScales], carefully cleaning with his fingers every bit of you.");
			outputText("\n\nFeeling in the mood to return the favor, you ask Anzu to turn back, so you can help the avian to get himself clean too.");
			outputText("\n\n\"<i>Oh, that’s not necessary, [name]. I’m doing this as a favor to you.</i>\"");
			outputText("\n\nThen, you chastise him, he should allow you to bathe him, as a favor.");
			dynStats("lus", 20, "scale", false);
			player.fatigue -= 30;
			inDungeon = false;
			endEncounter();
		}
		private function anzuBathTimeDecline():void {
			clearOutput();
			outputText("Not in the mood of getting your " + player.skin.desc + " wet (and sticky) at this time of day, you thank him for his offer but explain that you’re not exactly in the mood to get wet. Bidding him farewell, you leave him to his own matters and return to your camp.");
			inDungeon = false;
			endEncounter();
		}

		//------------
		// SLEEPING (8PM)
		//------------
		public function sleepWithAnzuInvitation():void {
			clearOutput();
			//outputText(images.showImage("anzu-bed-begin"));
			outputText("Satisfied in many senses, you feel a bit drowsy after all that cooking, eating and fucking, you let out a loud yawn and extend your body on one of the comfy couches in the living room.");
			outputText("\n\n\"<i>Hey there, little friend</i>\" Anzu salutes you, as he returns too from the kitchen. \"<i>Feeling a bit tired after all that…exercise</i>\" he jokes.");
			outputText("\n\nDespite how wonderful his cooking is, and how a pleasant experience are the romps on his company, the body gets exhausted eventually, you point him.");
			outputText("\n\n\"<i>Yeah, [name]. I’m feeling a bit tired too.</i>\" Anzu answers, giving a yawn even louder that your last one. \"<i>You’ll see, even gods need to sleep, and I was heading to my room right now. I presume that you were about to leave to that camp of yours? </i>\"");
			outputText("\n\nYes, he’s not wrong. You were taking a quick rest before departing.");
			outputText("\n\n\"<i>I see.</i>\" He says, sitting next to you. The sudden increase of weight makes the couch shift a little, and you are drafted into the avian feathered arms, with his scaled hands caressing your [skin] \"<i>Since you’re a bit tired, right now the better thing would be to rest, preferably in a comfy and cozy place, don’t you? And, as I said, I’m going to my room, so if you like, you could sleep here tonight. I’m pretty sure that " + (camp.getCampPopulation() < 2 ? "the portal can handle itself for a night" : "the portal can handle itself for a night, and if not, your companions can take care of it") + ".</i>\"");
			outputText("\n\nWell, the truth is that your camp isn’t the major target of the demon forces, and since your arrival there hasn’t been anything interesting around it besides the random imp or goblin. Maybe you should consider Anzu’s offer and spend a relaxed night in love and luxury instead of a night on the wastelands. What do you say?");
			doYesNo(acceptSleepingWithAnzu, declineSleepingWithAnzu);
		}

		private function declineSleepingWithAnzu():void {
			clearOutput();
			outputText("Tired as you are, a task is a task. You answer the avian that sadly, you have to keep guard tonight on the portal, so it will be on another time. Though a bit disappointed, the avian quickly cheers up and nuzzles your neck playfully, then he hugs you again and helps you to stand up. Gathering your things, you make it to the door, not without getting another playful nibble as you leave.");
			outputText("\n\n\"<i>Be careful on your way to the camp, little friend</i>\" he says from the door while waving you. Waving him back you cross the Rift and return to your camp.");
			inDungeon = false;
			endEncounter();
		}

		private function acceptSleepingWithAnzu():void {
			clearOutput();
			//outputText(images.showImage("anzu-bed-mid"));
 			outputText("Well, with him as company, who wouldn’t want to stay in the palace for the night, you answer. The avian, overjoyed, despite being almost as tired as you, hugs you even tighter and proceeds to carry you on his arms, a " + (player.tallness >= 120 ? "a simple task, given his strength" : "a very easy task, given his strength and much larger frame") + ".");
			outputText("\n\nSuddenly lifted from the ground by a couple of softly feathered arms, you let your body relax as  you let out a loud yawn. While on his arms you can feel his strong muscles embracing you, and you rest you head on his shoulder, " + (player.hairLength > 0 ? "while he ruffles your hair lovingly" : "rubs your neck, as he walks to his room") + ".");
			outputText("\n\nAfter going upstairs, he finally arrives to the door, opening it with a soft push. The now familiar and perfumed scent of the bedroom greets you once more, as you're carefully placed on the gargantuan bed.");
			outputText("\n\nClosing the door after him, the avian proceeds to remove some bed’s cover and puts you in a more comfortable position. " + player.clothedOrNaked("After he takes off his clothes and put them in a nearby drawer, you realize that you’re so tired that mustering the effort of taking your own is almost impossible. A bit sheepishly, you call Anzu over.") + "");
			outputText("\n\n\"<i>Hey, [name].</i>\" sitting on the bed next to you, naked except for his undies. \"<i>Do you plan to sleep in your [armor] tonight?</i>\"");
			outputText("\n\nActually, you were about to ask him to a little help with that….");
			outputText("\n\n\"<i>So tired for even undressing, huh? I’ll have to try to not tire out so much on our romps, then, don’t you?</i>\"");
			outputText("\n\nNah, it's okay, you reply. Most of you drowsiness comes from the accumulated nights of worry guarding the portal and your camp. Now that you have quite the comfy bed at your disposal, you have to enjoy it as much as you can, but seems like your body got the signal to rest way's faster than your mind.");
			outputText("\n\n\"<i>Seems like it can’t be helped, then</i>\" he says with a smile \"<i>Being a Champion is quite harder than i though. But since you asked, I’ll be more than happy to aid you with that.</i>\"");
			if (player.armor.isNothing) { //Not wearing clothes/armour?
				if (!player.lowerGarment.isNothing || !player.upperGarment.isNothing) //Wearing underwear only
					outputText("\n\nLuckily, you decided to came to the Rift with light clothing, and with that you mean only with your underwear. Why in Mareth you decided to came to this cold place almost naked is beyond your own understanding, but somehow you managed to get to the Palace without getting frozen, and now, you haven’t to do the seemingly herculean work of taking off your armor to sleep.");
				else //Naked
					outputText("\n\nLuckily, you decided to came to the Rift with light clothing, and with that you mean absolutely naked. Why in Mareth you decided to came to this cold place naked is beyond your own understanding, but somehow you managed to get to the Palace without getting frozen, and now, you haven’t to do the seemingly herculean work of taking off your armor to sleep.");
			}
			else {
				outputText("\n\nSoon, you feel the avian scaled hands over your [armor], taking it from your body, and then, carefully folding it and placing on the drawer too. Then you’re left on your underwear, over the soft sheets of the bed.");
				outputText("\n\nYou lie almost naked on the bed clothing, and the cushiony feeling of the sheets makes your body and mind even more ready to sleep, to the point that you barely recognize Anzu’s form coming closing to you to take your underwear from you.");
			}
			outputText("\n\nAlready half-asleep, you feel some sheets being pulled to cover your body. Shortly after, Anzu gets on the bed next to you and hugs you a last time on the day before turning off the lights with what seems to be a kind of mechanical artifact on the side of the bed. Anyways, is not like if you’re putting too much attention, tired as you are.");
			outputText("\n\n\"<i>Good night, [name]</i>\" you manage to hear from him before closing your eyes.");
			outputText("\n\nSoon enough, you mind slips away, carried by many days of fatigue, as you fall asleep on bed, with your feathered companion at your side...");
			doNext(sleepingWithAnzuPart2);
		}

		private function sleepingWithAnzuPart2():void {
			clearOutput();
			outputText("<b>At some moment, near midnight…</b>");
			outputText("\n\nYaaaawn.");
			outputText("\n\nWhat time of the night is? You can’t say the exact hour without a moon on the night sky that you manage to see through the window, but if your inner clock works well, you are pretty sure that it’s barely past midnight.");
			outputText("\n\nExtending your arms and flexing your [legs] on the soft linen sheet, you realize that you're lying next to Anzu, who has your head resting on his shoulder as his two left wings cover your back as a kind of feathered cloak. The warmth of his body as he hugs your smaller frame proving to be a pleasant sensation. You rest your head on the feathers of his chest, feeling his strong muscles and the soft pulse of his heartbeat as you try to get asleep again.");
			outputText("\n\nAfter a couple of minutes trying to get back to sleep, you find yourself failing after many attempts of returning to the dreamland. A sudden rumble on your belly distracts you from it, as you realize that a midnight snack would be pleasant, and with some luck, your body will be more prompt to rest after it. As you think about what you could get as a snack on the Palace, you remember that there’s still some leftovers of your last dinner together on the kitchen. Anzu surely wouldn’t mind if you take of bit of them.");
			outputText("\n\nDo you attempt to get some midnight 'snack' or just go back to sleep?");
			doYesNo(sleepingWithAnzuBlowjob, sleepingWithAnzuNoBJ);
		}

		private function sleepingWithAnzuBlowjob():void {
			clearOutput();
			//outputText(images.showImage("anzu-bed-blowjob"));
			outputText("Softy disentangling yourself from the avian’s embrace, you try to get off from the unsurprisingly tall bed, without luck, as your " + player.feet() + " get stuck with something as you climb down the bed. Then, a familiar wetness near the area where your [leg] got stuck, reinforced with a tugging from the thing that refrains you from leaving, makes you turn back, only to found that the thing entangled with your " + player.foot() + " is nothing less than the avian’s underwear.");
			outputText("\n\nSofty disentangling yourself from the avian’s embrace, you try to get off from the unsurprisingly tall bed, without luck, as your " + player.feet() + " get stuck with something as you climb down the bed. Then, a familiar wetness near the area where your [leg] got stuck, reinforced with a tugging from the thing that refrains you from leaving, makes you turn back, only to found that the thing entangled with your " + player.foot() + " is nothing less than the avian’s underwear.");
			outputText("\n\nWhat a…curious way to get stuck. Adjusting yourself to get your " + player.foot() + " free, you end in an even more uncomfortable position, as you end up with your " + player.faceDesc() + " on Anzu’s crotch, and your " + (player.isNaga() ? "tail swishing over" : "[legs] resting on") + " the huge avian’s lower belly. In this position, you get a much closer look to the avian’s underwear, and realize that its cloth is tented and with a wet spot on the top. This, added to the subtle noises and moves that he makes from time to time, is a clear signal that the avian is having a…rather naughty dream.");
			outputText("\n\nDistracted as you were from your task of going down to eat something, and a bit horny for the close contact and avian musk from you are subject, you come up with an idea. Why not get off the bird while you get a snack at the same time?");
			outputText("\n\nWith this thought on mind, your start to take away his underwear, slow enough to not awake him, you reveal the prize under it: his gigantic manhood. This will do it nicely, you think to yourself, and, in the end,... isn’t like he won’t enjoy it, right? You’re pretty sure that he’ll have pleasant dreams tonight, if the happy rumbles coming from his beak as you touch him were proof of anything.");
			outputText("\n\nTaking his meat on hand, your realize that, aroused by his naughty dream, the avian’s penis is hard and throbbing, some pre leaking from it and wetting its tip. You rub your [nose/snout/beak] along its length, enjoying the arousing scent of avian musk. Not wanting to waste any time, you proceed to lick the pre pouring from his cumslit, tasting again his exciting and sinful essence.");
			outputText("\n\nOnce all his pre has been licked from the hard rod, you proceed to give slobbery licks along all its surface with your " + (player.tongue.type == Tongue.SNAKE ? "forked" : player.hasLongTongue() ? "long" : "") + " tongue, the salty taste of his exhilarating your body, your " + (player.hasCock() ? "hard [cock] leaking over his lower belly" : player.hasVagina() ? "pussy leaking over his lower belly" : "featureless crotch tingling with sensation") + ".");
			outputText("\n\nSeems like the big bird liked your attentions, as his pants and moans, and more exactly, his rocking hard erection says. Back to business, you take the tip of his huge penis on your " + (9999 == 0 ? "[beak] having care to not apply to much pressure, as that would wake him" : "lips having care to not wake him") + ".");
			outputText("\n\nBit by bit you engulf more and more inches of bird meat on your " + player.face() + ", " + (player.tallness >= 120 ? "and despite having some problems with the final inches, manage to get most of it on your " + player.face() + " on your throat" : player.tallness >= 60 ? "and having troubles past fifteen inches, as its tip touches the back of your throat, you decide to stop at this point" : "the tip itself being a mouthful, you struggle to get past a few inches though your throat") + ". Nevertheless, you try to make the most of it and take as much of his dick as you can.");
			outputText("\n\nWith the monster penis deep throat on you, you start sucking, pumping with your hands the  of his penis that was left out of your mouth. After a few pump and some vigorous sucks, the aroused moans from the sleeping avian are clear signals about that he’s gonna cum soon. Not waiting to want a second more, you increase the pace of your deepthroating, and your efforts are quickly rewarded");
			outputText("\n\n\"<i>Gahh!</i>\" the still asleep Anzu shout, releasing with that a torrent of white and creamy goodness right to your gullet. ");
			outputText("\n\nThe cummy effluvia from his orgasm starts flooding your stomach your belly " + (player.tallness >= 120 ? "extending a bit" : player.tallness >= 60 ? "getting overfilled and rounded" : "quickly inflated and distended") + " by the sheer amount of cum produced by the avian. Cum that overflows his belly reaches your gullet and mouth and soon, it becomes too much for your overwhelmed throat to handle, so you pull his, now half-flaccid dick, off of your mouth, the final jets of cum splattering all over your face and chest, and some even falling over your still open mouth. ");
			player.refillHunger(80);
			outputText("\n\nThe scent and the feeling of his cum over and inside you proves soon to be too much for you, and you end creaming yourself, as your " + (player.hasCock() ? "cum splatters and stain Anzu’s belly feathers" : player.hasVagina() ? "girlcum leaks over Anzu’s belly feathers" : "") + ".");
			outputText("\n\nEven with that, you manage you take his dick in your hands and catch the last one in your mouth, and despite being the last and weakest, it's still manages to overfill your mouth and cheeks, so much that cum leaks again of the corners of your mouth. But soon, a noise distracts your from enjoying this too much.");
			outputText("\n\n\"<i>Huh, wha...what time is it?</i>\" Anzu awakes, a bit confused. The he sees you, lying over his belly with your hands on his dick, and your cheeks filled with a mouthful of his cum, some of it leaking from your mouth. ");
			outputText("\n\nA bit embarrassed, you flash a cum-bathed smile back to the avian, some cum escaping from the corners of the mouth in the process, and explain that, while you wanted a snack, you fell over him, and got to the idea of getting him off and having a treat at the same, and that you hope that he doesn’t get too upset by that.");
			outputText("\n\nThe avian simply laughs and takes your cum-filled form in his arms, and after giving your smaller body a loving squeeze, he says");
			outputText("\n\n\"<i>Upset? For a blowjob from my lover? Why? If anything, I should thank you. But, if you were so hungry and horny, you simply could be asked. I’m your host tonight, after all , and I’ll be more than happy to give you a cummy meal.</i>\"");
			outputText("\n\nAnzu states, playfully poking your cum-inflated stomach. Both of you laugh for a bit and soon, thanks to the vigorous exercise and the hearty lunch in the middle of the night, you catch your sleep again, cuddled on the bigger frame of your avian friend, that falls asleep not much later.");
			dynStats("lus", 20, "scale", false);
			doNext(wakeUpWithAnzuGoodMorningBirdie);
		}

		private function sleepingWithAnzuNoBJ():void {
			clearOutput();
			outputText("You shake your head and close your eyes. It takes quite a while but eventually, you succeed in catching your sleep again and make your way back to the dreamland.");
			doNext(wakeUpWithAnzuGoodMorningBirdie);
		}

		private function wakeUpWithAnzuGoodMorningBirdie():void {
			clearOutput();
			camp.cheatSleepUntilMorning();
			outputText("Reinvigorated by the refreshing sleep, you get up in the first hours of the morning, still cuddled with Anzu, that wakes up between yawns.");
			outputText("\n\nGetting off the bed with his aid, both you get dressed, not without some frisky grope from each other in the process, and after eating the breakfast that Anzu cooks for you in the early morning, you give the avian a deep kiss, and bid him farewell, returning to the camp with a smile on your face.");
			if (player.hunger < player.maxHunger() - 20) player.refillHunger(30);
			else player.refillHunger(player.maxHunger() + 10 - player.hunger);
			inDungeon = false;
			doNext(playerMenu);
		}

	}

}
