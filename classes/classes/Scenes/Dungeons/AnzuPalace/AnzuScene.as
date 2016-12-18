package classes.Scenes.Dungeons.AnzuPalace 
{
	import classes.BaseContent;
	import classes.TimeAwareInterface;
	import classes.GlobalFlags.*;
	import classes.StatusEffects;
	import classes.Scenes.Dungeons.DungeonCore;
	/**
	 * Anzu the Avian Deity by Coalsack
	 * @author Kitteh6660
	 */
	public class AnzuScene extends BaseContent// implements TimeAwareInterface
	{
		
		public function AnzuScene() 
		{
			
		}
		
		public function anzuAffection(amount:int = 0):int {
			flags[kFLAGS.ANZU_AFFECTION] += amount;
			if (flags[kFLAGS.ANZU_AFFECTION] < 0) flags[kFLAGS.ANZU_AFFECTION] = 0;
			if (flags[kFLAGS.ANZU_AFFECTION] > 100) flags[kFLAGS.ANZU_AFFECTION] = 100;
			return flags[kFLAGS.ANZU_AFFECTION];
		}
		public function anzuRelationshipLevel():int {
			return flags[kFLAGS.ANZU_RELATIONSHIP_LEVEL];
		}
		public function anzuSexCounter():int {
			return flags[kFLAGS.ANZU_ANAL_CATCH_COUNTER] + flags[kFLAGS.ANZU_VAGINAL_CATCH_COUNTER] + flags[kFLAGS.ANZU_BLOWN_YOU_COUNTER] + flags[kFLAGS.ANZU_SUCKED_OFF_COUNTER];
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
					outputText("\n\nWell, neither is there reason for him to behave like a lunatic and running down the stairs to kill the first living being he sees. But, analyzing the situation more carefully, getting in the bad mood of a guy (if height>96) twice (else if height ) three (else if height ) four (else) five times your size isn’t a great idea.");
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
				outputText("\n\nA little nervous, you aren’t prepared for what comes out of the door. A kind of anthro bird, about eighteen feet tall, with golden-orange hair tipped in red feathers, a head covered in golden and orange feathers in an autumnal pattern, and eyes with turquoise irises and a dark turquoise sclera which is staring at you.");
				outputText("\n\nHis build is strong and imposing, wearing purple robes studded with gold and amethyst. Under his robes he appears to wear a white shirt and brown pants. Judging from the bulge in his pants he is no \"<i>little</i>\" man. On his back he has four wings covered in a pattern of gold, light green, and dark teal feathers with purple feathers on the tips. Behind him, a tail made of a fan of turquoise feathers, equally ending on purple tips, swishes from side to side, while he awaits patiently your answer.");
				outputText("\n\n\"<i>Do you have something to say to me, or are you going to keep staring at me for the rest of the day</i>\"");
				outputText("\n\nA little ashamed, you explain how you, while exploring the Rift, were caught in a blizzard . After wandering for awhile, you found this place and thought you could rest inside, but when you approached, realized that it was inhabited.");
				outputText("\n\n\"<i>Bad things can happen to anyone. It’s not my fault or my problem. Get lost.</i>\" the avian answers coldly.");
				outputText("\n\nYou tell him that both of you are apparently the only sane beings in the Rift. Most of the creatures outside are hostile or sex-crazy. In a situation like that, you need to protect each other.");
				outputText("\n\n\"<i>Look, " + player.mf("boy", "girl") + " I’m fine. I don’t need the protection of anyone</i>\"");
				outputText("\n\nHmm, looks like this guy has a bit of a temper. Politely, you ask him if he can let you come inside only for a moment to recover heat.");
				outputText("\n\n\"<i>If you’re going to be so insistent, come inside " + (player.tallness < 84 ? "little " : "") + player.mf("boy", "girl") + ". Just don’t break anything</i>\"");
				outputText("\n\nYou thank him, and introduce yourself. The sight of the building’s interior surprises you. Far more fancy that anything which you had expected. A fireplace warms the interior. There are several shelves, filled with antique-looking books. The furniture has a particular appearance, decorated with patterns and designs you have not seen anywhere else in Mareth. Decorations in linen and silk cover the wall, while velvet covered armchairs provide a comfy place for rest, and the floor is decorated with numerous rugs. A staircase leads to the upper floors, where the avian was probably resting before you knocked on the door.");
				outputText("\n\n\"<i>Take a seat here, " + player.mf("boy", "girl") + "</i>\" The avian says, pointing at one armchair near the fireplace.. \"<i>If you want to get warm, sit there. You’ll recover from the cold air faster.</i>\"");
				outputText("\n\nYou thank him and realize that you don’t know his name yet.");
				outputText("\n\n\"<i>My name? Well I suppose I can give it</i>\" \"<i>Name’s Anzu, god of fire and storms, and all those things</i>\" He says, waving his hands exaggeratedly.");
				outputText("\n\nA god? Besides Marae " + (flags[kFLAGS.URTA_QUEST_STATUS] >= 1 ? "and Taoth" : "") + ", you haven’t known any deity in Mareth. Incredulous, you ask him again.");
				outputText("\n\n\"<i>An almost empty shell of what once was a mighty god, but technically, I’m still a god</i>\"");
				outputText("\n\nThat answer was more depressing than you expected. You ask him if he wants to talk for a while. ");
				outputText("\n\n\"<i>I usually don’t have guests.</i>\" Anzu suspires. \"<i>Well, after all this time, a little chat would mean no harm for me.</i>\"");
				outputText("\n\nYou and Anzu talk for a little while. You explain to him you’re the Champion of Ingnam, and your mission in Mareth. Although a little cold and distant. He begins to open up after a few questions. Anzu explains that his full name is Anzu Annuna, and how he was the protective god of an ancient city called Mittani in a realm very different to Mareth. He was forced to leave his realm after getting into trouble with the rest of the gods in his former home.");
				outputText("\n\nAfter talking about the adventures both of you have experienced in Mareth, you see a lot of time has passed, and probably the best idea would be to go back to the camp.");
				outputText("\n\nYou thank him for letting you in, but explain that it’s time for you to go back to your camp.");
				outputText("\n\n\"<i>[name], it was good to have company for the first time in… years. If you get caught in another snowstorm in the Rift, or simply want to talk, come here again.</i>\"");
			}
			outputText("<b>Anzu's Palace is now accessible from Places menu.</b>");
			flags[kFLAGS.ANZU_PALACE_UNLOCKED] = 1;
			doNext(camp.returnToCampUseOneHour);
		}
		
		private function leaveInitialPalace():void {
			clearOutput();
			outputText("Well, if this place looks dangerous enough to keep giants away, then it probably means whatever lives here is something that you want to avoid. Since it doesn’t look like an area inhabited by demons, it's none of your business.");
			doNext(camp.returnToCampUseOneHour);
		}
		
		public function anzuTransition():void {
			if (flags[kFLAGS.ANZU_RELATIONSHIP_LEVEL] == 1) {
				outputText("Coming back to the avian’s home, you wander around the insides for a while without finding Anzu. When you’re almost leaving, you hear a noise in the upper floor. On the third floor, you quickly recognize the sound of the beating of wings. You go up stairs until reaching the roof. There, you finally spot Anzu, who is flying over the building. When he sees you there, he waves to you. After drawing a few circles in the air, he lands next to you.");
				outputText("\n\n\"<i>So, you came again, " + player.mf("boy", "girl") + ".  Anyway, seeing how this place is the opposite of one of those tents that you have, and since I don’t mind that you rest your butt in my living room, this place was a good opportunity to escape from your camp. Either that or you got caught again by another ‘snow storm’ </i>\"");
				outputText("\n\nPutting aside his joke, a nice and warm spot against the chill Rift is a good place to visit, but actually, you only wanted to spend time with him again. That is, if he has time.");
				outputText("\n\n\"<i>Sure?</i>\" he says, a little surprised by the fact \"<i>Well, it’s not as if I’m expecting someone else. We should get inside.</i>\"");
				outputText("\n\nYou follow him to the living room. There both of you delight on the heat from the fireplace. After chatting a little about unimportant things, you ask him about what he was doing outside before.");
				outputText("\n\n\"<i>Oh, that. I usually fly around the Rift for keeping my flight abilities in good shape. And, meanwhile I can explore the hills for something interesting. You know, looking for some Jotun or valkyrie that get too close to the palace, or finding a new place for loot something, things like that. Most of the time I find nothing, today not being the exception.</i>\"");
				outputText("\n\nThat must be disappointing.");
				outputText("\n\n\"<i>Yes, but it’s exercise regardless. It gives me something to do besides reading and practicing alchemy. And how about you, how do you spend your free time in Mareth?</i>\"");
				outputText("\n\nSince your principal task was to protect the portal, and the camp is situated in the barrens, there isn’t much that you can do there. You relate to him about some of your endeavours in the land, fighting monsters in the wilderness and hunting demons across the lands. Judging by the look he gives when you say that, he surely knows how most of the fights in this land end.");
				outputText("\n\n\"<i>And how about your friends. Since you’re wandering here and there, I suppose that you’ve met some interesting people.</i>\"");
				if (player.findStatusEffect(StatusEffects.TelAdre) >= 0) outputText("You tell him about the friends that you’ve made in Tel’Adre" + camp.hasCompanions() ? "and your companions in the camp." : "");
				else if (camp.hasCompanions()) outputText("You tell him about the companions in your camp.");
				outputText("After that, you tell him about the adventures that you and your friends had, and how, even in the biggest troubles, the fact that they keep supporting you was the thing that gave you the necessary strength to continue in the fight.");
				if (player.findStatusEffect(StatusEffects.TelAdre) < 0 && !camp.hasCompanions()) outputText("You tell him about the friends that you had back on Ingnam, and  how you used to spend the afternoons playing and having fun together.");
				outputText("\n\nWhile you explain, Anzu grows uncomfortable as you talk to him more. Seeing his discomfort, you look at him, but he dismisses you and motions to you to keep talking. You finish telling him how much you appreciate their company, and how your life here would be quite boring and depressing if you would’ve spent all this time alone. When your tale ends, you finally ask him if something you said is bothering him.");
				outputText("\n\n\"<i>No, " + player.mf("boy", "girl") + ", it’s nothing.</i>\" He answers with a half-hidden sigh. \"<i>I think that I’ll go get a glass of water. Talking too much makes my mouth dry.</i>\"");
				outputText("\n\nThat sounded like an obvious excuse. Thinking about what could be wrong with him, you follow the avian to the kitchen. When you arrive there, you find Anzu looking at the kitchen’s old window. Looking below at the trees, down the hill, he lets out another sigh.");
				outputText("\n\n\"<i>Sorry. I should’ve offered you a glass of water too.</i>\"");
				outputText("\n\nThat’s not the problem. Looking him in the eyes, you state that you know something is happening to him. Does it have something to do with your recent conversation?");
				outputText("\n\n\"<i>I’m terrible at hiding it, right?</i>\" he says with a forced laugh.\"<i>The truth is, [name], that despite my attempts to prevent the affairs of my situation from affecting me, deep inside I mourn the fact that I spend my exile in near total isolation, since the denizens that wander the Rift aren’t exactly pleasurable company. Maybe I didn’t realize how bad I felt about it until someone came to show me.</i>\"");
				outputText("\n\nYou tell him that wasn’t your intention, making him feel bad. And what he’s saying isn’t hard to understand. After all, fifteen years alone must be a hard time for anyone, even for someone like Anzu.");
				outputText("\n\n\"<i>It wasn’t your fault. Eventually, the years spent alone make me feel worse. I’ve tried to hide it by distracting my mind with books or anything who catches my attention around here. If anything, I can only thank you.</i>\"");
				outputText("\n\nBy what?");
				outputText("\n\n\"<i>For the fact that you keep visiting me. When you arrived here, the truth is that I saw you as another nuisance, not unlike the harassing Jotuns who used to come here from time to time.");
				outputText("\n\nBut, after a few visits, I found myself enjoying your company. Having someone who listens to me and had interesting things to say, I don’t remember how long it’s been since I had someone like you. And, I wish to call you my friend…and make you know that you’re welcome here.</i>\"");
				outputText("\n\nThat shouldn’t be a problem. You and him are friends now, and that’s what friends do.");
				outputText("\n\n\"<i>Friend. It has been centuries since I could call someone else a friend.</i>\" Anzu says wistfully \"<i>[name], I don’t know what to say…But thanks. And I know I’ve said it before, but feel free to come here again. Really. I don’t mind if your house is a dirty shack or anything, but If you want to rest here someday, or have a place to stop when you’re traveling across the Rift, you know where I am.</i>\"");
				flags[kFLAGS.ANZU_RELATIONSHIP_LEVEL] = 2;
			}
			else if (flags[kFLAGS.ANZU_RELATIONSHIP_LEVEL] == 2) {
				outputText("Walking around Anzu’s palace, this time you don’t have to search for him, as you find the avian peacefully sleeping on a couch on the living room. Looks like he isn’t using his usual set of clothing, and only has his robes and underwear covering him.");
				outputText("\n\nApproaching him silently, and seeing now an opportunity which you probably won't have again in a long time, your hand slip inside the folds of the soft fabric, reaching to his chest, and without advertence to him you start tickling his chest and belly. The avian awakens at the sudden touches, and starts laughing at your constant tickling.");
				outputText("\n\n\"<i>[name], what are you…, no… please no…, stop you… \"<i> he only manages to say, in between laughter.");
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
			else if (flags[kFLAGS.ANZU_RELATIONSHIP_LEVEL] == 3) {
				outputText("The familiar warmness of the palace’s interior welcomes you once more. And, again, Anzu isn’t in the living room. Well, this is his house after all, he can wander around the insides as he pleases. Going upstairs, you quickly find him on the third floor.");
				outputText("\n\nAnzu is watching the snowy hills through the window down the hall. Approaching him, you notice that instead of his usual purple robes, he is wearing a violet and blue coat. On the back of the coat, patterns made of gems simulate in some way the constellations, absent on Mareth, that he used to see in the skies of his home world. You attract his attention and greet him, after which you join him at the window.");
				outputText("\n\n\"<i>Hey, [name] I only was watching the view for a while. I’ve heard that in most of Mareth it never rains or snows, but here occasionally we have snow falling. Must be because of the distance from the demonic strongholds. Isn’t too common either. Once or twice every two weeks. </i>\"");
				outputText("\n\nIt’s a good thing that at least there is something like rain here. And with the somewhat less red sky, this place is, despite the cold, a paradise compared to Mareth areas which are at the mercy of demons.");
				outputText("\n\n\"<i>Yeah, in many ways, I’m a lucky guy</i>\" he answers \"<i>By the way, have you realized how the time seems to go slower when snow falls? Seeing how each snowflake falls from the sky until it finds its way to the rest, forming a mantle over the hills. I couldn’t ask for a better view, except of course that of a starry night.");
				outputText("\n\nYou ask him if that has something to do with his current suit.");
				outputText("\n\n\"<i>Oh, you’ve noticed it.</i>\" he says. \"<i>Well, [name], this is nothing less than the suit that I used as a member of the Council of the Annuna. The official attire. Recently I found it on a pile of clothes in the vaults of the palace. I used to wear it only in formal occasions but, since has been a while, I felt a little nostalgic about the good times that I had there.</i>\"");
				outputText("\n\nLooks like even with the bad things which happened to him in Mittani, Anzu still has good memories from his home. And he has stayed away a long time, but exactly, how bad has it been for him? Since he has lived many centuries, the time passed here shouldn’t be too long.");
				outputText("\n\n\"<i>You may think that for someone who has lived as long as me fifteen years is nothing, but the fact is, the time is capricious with you. When you are in lost in happiness and pleasure, the days, months, even the years pass easily, and the time slips between your fingers like water. In the other hand, when you are stressed, desolated, or, like on my case, alone, the time seems to advance slower every second that passes.");
				outputText("\n\nThat was until you arrived of course. The first friend that I had in…centuries. An unexpected gift who found its way to my home, and when I found it, I realized that it was the best gift which I could have received.");
				outputText("\n\nWandering around the Rift, I’ve thought how in the world I met a " + player.mf("boy", "girl") + " like you, and how empty my life would feel without a friend like you. I used to daydream about how things could have been if I had been more successful on my attempt to take over my world. That did me no good, because the more I thought about it, the more depressed I felt. But your mere presence and company here have made my exile much less lonely, and your friendship was the thing that made me almost forget all the bad things that have happened to me, and to embrace my life here.");
				outputText("\n\n\"<i>[name], you’ve truly been the best friend I could asked for. But lately, each time that you visit me, I’ve started to feel different. I don’t know how to say it…This is the first time on my entire existence I’ve felt like this. Well, I think that I…</i>\"");
				outputText("\n\nYes?");
				outputText("\n\n\"<i>I think that even after we are friends and all, and the fact of we don’t mind…em...relieving pressure, together…</i>\"");
				outputText("\n\nOh, you’re understanding the way of he’s going. After a few doubts, he puts his hand on yours and finally says:");
				outputText("\n\n\"<i>I think… I now think of you as more than a friend. You see…despite being a god, sometimes I could be a little unsure, and explaining this kind of thing is difficult for me, but…I think, no, I’m sure what I feel about you is not only friendship, because, [name], I think that I’ve fallen in love with you. ");
				outputText("\n\nI know how things are, if you don’t feel that, or if I’m being too pushy…I’ll understand it. But please, say to me what you feel about me.");
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
			outputText("\n\nThen, if both of you are okay with it, why don’t start already? You motion to Anzu, who quickly strips away his underwear, revealing the forty inch monster between his legs. The years spent alone probably made his libido get high enough to make him antsy at the promise of some release in the hands of another.");
			outputText("\n\nBoth of you recline on the couch. with your body resting over Anzu’s huge frame. Not wishing to make him wait much longer, you put your hand on one of his balls, softly caressing the feathers on the huge nut, which is already pulsating in expectation of a prompt release. Your free hand finds its way to the other, and soon you’re feeling the cum in them ready to go outside. ");
			outputText("\n\nSatisfied with the foreplay, you put one hand on the base of Anzu’s meat and start pumping it. Your other hand goes to the tip, and, taking some of the pre which is dribbling from it, smears it over the sides of his cock. Then it joins your other hand, jerking off the sides of his shaft.");
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
			dynStats("lus", 40);
			doNext(camp.returnToCampUseOneHour);
		}
		private function anzuRelatLvl3Dont():void {
			clearOutput();
			outputText("Excusing yourself, you ask him if he needs to attend something, you’ll give him the time.");
			outputText("\n\n\"<i>Oh, thanks…</i>\" he says, quickly catching your idea. \"<i>Suddenly, I feel as if my bladder is full. I need to use the bathroom as soon as I can.</i>\"");
			outputText("\n\nHurrying to the mentioned room, the avian leaves you alone in the living room, enjoying the warmness of the fireplace. After a few seconds, the obvious sound of someone jerking off is heard across the hall. Judging from the size of Anzu’s...attributes, he’ll have much to clean up after he finishes.");
			doNext(camp.returnToCampUseOneHour);
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
			doNext(camp.returnToCampUseOneHour);
		}
		
		//MENU & INTERACTIONS
		public function anzuMenus():void {
			clearOutput();
			outputText("\"<i>Do you need anything?</i>\" Anzu asks patiently.");
			menu();
			addButton(0, "Appearance", anzuAppearance, null, null, null, "Take a closer look at the avian deity.");
			addButton(1, "Talk", anzuTalkMenu, null, null, null, "Get to know Anzu better.");
			//if (flags[kFLAGS.ANZU_RELATIONSHIP_LEVEL] >= 3) addButton(2, "Sex", anzuSexMenu, null, null, null, "Have some sexy times with the sexy avian deity.");
			//else addButtonDisabled(2, "Sex", "Maybe if Anzu likes you better, he will let you do that.");
			addButtonDisabled(2, "Sex", "Coming Soon!");
			if (kGAMECLASS.dungeonLoc == DungeonCore.DUNGEON_ANZU_ROOF) {
				if (player.canFly()) {
					if (flags[kFLAGS.ANZU_RELATIONSHIP_LEVEL] >= 4) addButton(3, "Race Him", null, null, null, null, "Challenge Anzu to a race and have some fun!");
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
			addButton(0, "His Past", anzuTalkPast, null, null, null, "Ask Anzu about his past.");
			addButton(1, "The Palace", anzuTalkPalace, null, null, null, "Ask Anzu about the palace he currently lives in.");
			addButton(2, "Glacial Rift", anzuTalkRift, null, null, null, "Ask Anzu about the Glacial Rift.");
			addButton(3, "His Powers", anzuTalkPowers, null, null, null, "Ask Anzu about his powers. Surely as a deity, he has some interesting powers?");
			addButton(4, "Marae & Lethice", anzuTalkMaraeAndLethice, null, null, null, "Ask Anzu what he thinks about Marae and Lethice.");
			addButton(14, "Back", anzuMenus);
		}
		
		private function anzuTalkPast():void {
			clearOutput();
			outputText("You ask Anzu about what was he doing before he lived in Mareth. He said he was a empty shell of his former power, and he protected a city called Mittani.");
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
			outputText("\n\nWhen the Council heard of the death of Ninurta, they sent a group of eleven gods to hunt me down. I gathered all which I could carry in the chariot I stole from Ninurta and the things I couldn’t carry were sealed with my magic into some urns. It’s thanks to my magic that this palace is in good shape. When I was about to open a portal in Mittani which would have allowed me to escape from my world, the hunters from the Council arrived. The city was almost empty when they arrived, probably due to the angry winds which scourged the place from my battle with Ninurta, forcing the inhabitants to flee, which was lucky for them. I still carried the Tablets of Destiny, and used them as an energy conduit to open the portal. That was when I was attacked. ");
			outputText("\n\nSeeing how I was surrounded by enemies, and I had not recovered enough from the fight with Ninurta and opening the portal weakened me even more, I made a decision. With no other choice, and taking advantage of not needing the tablets anymore for keeping the portal open, I overloaded the energy in the Tablets, which quickly drained the energy from my body, leaving me with only a fifth of my original power. ");
			outputText("\n\nThen I smashed the Tablets just as the hunters launched themselves at me. The energy I infused in them was enough to kill the eleven idiots. Quickly I crossed the portal with the chariot and the urns. It was an...enlightening experience. I felt dizzy for hours, though. ");
			outputText("\n\nThe portal left me in the Rift, and luckily both the urns and the chariot were in good shape. I wandered for days across the hills before I found this place. When I came here it was inhabited by a group of winged women: valkyries which I later learnt they’re called. Though weakened, I was still a god, and throwing them out was easy enough. After that, I reconditioned the place to fit my image. Besides killing the occasional giant that comes here to prove his courage, I’ve lived in peace here for fifteen years.</i>\"");
			outputText("\n\nYou thank Anzu for his explanation.");
			cheatTime(0.25);
			flags[kFLAGS.ANZU_AFFECTION] += 5;
			flags[kFLAGS.ANZU_TALKED_PAST] = 1;
			doNext(anzuTalkMenu);
		}
		private function anzuTalkPalace():void {
			clearOutput();
			outputText("He said something about valkyries living here before he arrived. How was the palace before?");
			outputText("\n\n\"<i>The group of women that used to live here before? With them, this place looked a little more rustic back then. Wooden tables, iron decorations, weapons hanging on the walls, and a fountain containing something they call mead. I had to redecorate the place after I threw them out.</i>\"");
			outputText("\n\nAnzu makes a hand gesture to indicate you to follow him.");			
			outputText("\n\n\"<i>I had to plaster the inner walls because the most of the bricks were exposed. After that, I decorated the walls and columns with silk and linen. The first floor, as you can see, has four principal areas, all connected to the principal hall.");			
			outputText("\n\nTo the left, where we’re standing now, is the living room. Almost all of the furniture and vases which are here now were the ones which I could bring with myself from Mittani. The books which you see on the shelves are general history books, told from the mortal point of view of course, very lacking in term of general knowledge but still quite interesting.");			
			outputText("\n\nNow, to the right side of the hall, is the dining room. I kept most of the furniture that the valkyries left behind. Behind the dining room is the kitchen. The staircase at the end of the hall leads to the basement and another, near the entrance, leads to the second floor. The door near the end of the hall leads to the bathroom. With the cold, a warm bath is always appreciated. ");			
			outputText("\n\n\"<i>What’s in the basement?</i>\" You ask.");
			outputText("\n\n\"<i>Come and see it yourself</i>\" Anzu answers.");
			outputText("\n\nBoth of you go downstairs to the basement, and the first thing which catches your attention is a chariot. You ask Anzu if this is the chariot in which he arrived on when he travelled to Mareth.");
			outputText("\n\n\"<i>Yes, I kept the chariot I stole from Ninurta here. It stays here most of the time as I have very little use for it</i>\" Anzu explains, and proceed to point to a door located behind the chariot.");
			outputText("\n\n\"<i>Behind this door is the armory. Name a kind of weapon, and you’ll find it inside: swords, bows, axes, spears, halberds, and...I’m starting to sound like a weapon seller. Maybe I’ll show you the weapons in more detail later, for now, follow me to the second floor.</i>\"");
			outputText("\n\nAfter returning to the first floor, you go upstairs to the second floor. The floor is shaped in a U like disposition. There are three rooms, two to the sides and one located at the end, with the hall connecting the three rooms and the staircases.");
			outputText("\n\n\"<i>Now, [playername] if you look to the left, you’ll see my bedroom.</i>\" He points a pretty large room and beckons you to follow him inside.");			
			outputText("\n\nWow, this is a huge room. You could fit inside this room almost all of your " + camp.homeDesc() + " located in your camp! You ask Anzu what was this place before it became his bedroom.");			
			outputText("\n\n\"<i>Apparently, it was the valkyrie’s common dormitories before I arrived. There was almost thirty of them, and after I threw out all the old and small beds, the space left was more than enough for most of my things. As you can see, I repaired the walls and decorated it in a similar way to the living room. I put a small fireplace here too. And that large thing is my bed.</i>\" He says, pointing to a huge mattress covered with linen sheets.");			
			outputText("\n\nAround the fireplace which Anzu mentioned, there are some armchairs. The scent of flowers catch your attention for a moment, and you see many vases with them around the bedroom.");			
			outputText("\n\n\"<i>I tried to replicate here my sanctuary in the Temple of Mittani, and besides the cold, I think I did a good job. Apart from my bedroom, on this floor you can find my study, and the rest of the books in the palace. These books contain information from my realm.");			
			outputText("\n\nAfter showing you the study, he points the third room, in the right side of the floor.");
			outputText("\n\n\"<i>This room has no standard use. Generally I use it for random things when it becomes necessary.</i>\"");
			outputText("\n\nYou follow him to the third floor. Similar to the second in shape, the only difference resides in the fact of here are only two large rooms, while a hall crosses the floor.");
			outputText("\n\n\"<i>Well, there are the vaults of the palace.</i>\" explains Anzu, pointing to the left  \"<i>All the gold, jewels, carpets, or anything with a high value is stored here. In the room to the right I have some special equipment. I use it to measure the changes of energy in the area around the palace, while isn’t useful to detect individual approaches, a group of three or more individuals is immediately detected.");
			outputText("\n\nWhen I need to check my own levels of energy, or use a new spell that I haven’t tried, I use the negative zone in the room, which allows me to practice without destroying anything.</i>\"");
			outputText("\n\nYou admire for a while the gems that lie exposed around the room, none like you’ve ever seen on Mareth, before returning to his side and walk along the hall in the third floor. The hall ends in a huge window with a beautiful view of the Rift. Anzu walks to your side and sees across the window for a while.");
			outputText("\n\n\"<i>A little cold at start, but when you get accustomed, it becomes really nice. You know, if you want to have a better view, you can follow me to the roof.</i>\"");
			outputText("\n\nThe roof of the palace, surrounded by the forest pines, lead to a truly magnificent view. The hills extend for all the horizon, while the soft sound of the wind brings peace to your mind. Above you, the sky, framed by the treetops completes the setting.");
			if (flags[kFLAGS.LETHICE_DEFEATED] > 0) {
				outputText("\n\n\"<i>When I’m bored or feel too nostalgic, I use to go here in the night. Makes me focus in what I have now. In the end, the only thing that I really miss from my former world, are the things that I can’t have when looking at the sky.</i>\"");			
				outputText("\n\nYou give him a confused look.");	
				outputText("\n\n\"<i>Stars.</i>\"");	
				outputText("\n\nThe lack of the stars in the night sky can be a little depressing. You recall how in the night, back on Ingnam you used to sit on the grass and count the stars of the sky. You chat in the top of the palace with Anzu about the constellations and shooting stars until the cold makes you ask him to go inside again.");	
			}
			else {
				outputText("\n\n\"<i>When I’m bored or feel too nostalgic, I use to go here in the night. Makes me focus in what I have now. Previously, those stars didn't appear in the sky but for some reason those stars returned.</i>\"");			
				outputText("\n\nYou tell Anzu of how you defeated Lethice and he congratulates you in your efforts, even giving you an appreciative nod for making the stars return. You chat in the top of the palace with Anzu about the constellations and shooting stars until the cold makes you ask him to go inside again.");
			}
			outputText("\n\nBack in the living room, you thank him for having showed his palace to you.");			
			cheatTime(0.25);
			flags[kFLAGS.ANZU_AFFECTION] += 5;
			flags[kFLAGS.ANZU_TALKED_PALACE] = 1;
			doNext(anzuTalkMenu);
		}
		private function anzuTalkRift():void {
			clearOutput();
			outputText("Besides exploring and fighting some monsters, you know very few things about the Rift. Since Anzu has been living here for fifteen years, he could explain to you some details about the land. And, you still have doubts about how exactly he ended up in this place, and not, for example, the plains, or like you, the barrens.");
			outputText("\n\n\"<i>The Rift is likely one of the largest areas in the realm of Mareth, although I admit that I’ve yet to explore much outside the Rift. The weather is always snowy, and usually has sudden snowstorms. A multitude of hills, mostly covered in forests across the land. All the trees are pines, etc.");
			outputText("\n\nAbout the inhabitants, most of them are hostile. The Jotuns, or Ice Giants, wander across the hills, sometimes carrying trees which they use as maces. The valkyries, winged women, cross the skies looking for someone worthy for challenge themselves. Besides that, they’re not exactly evil, and after our first encounter, we haven’t had any problems.");
			outputText("\n\nSome years ago, there used to be a kind of ice demons. They were pale white, with white hair, and had a strong addiction to the cum of certain creatures. While not so strong individually, they formed groups to hunt and \"<i>harvest</i>\" other inhabitants of the Rift, especially Jotuns, since they represented the biggest source of cum in the area. Because of the general nuisance they were, a force composed of valkyries, yeti and Jotuns drove them to extinction in a couple of years. Even I helped with killing some thousands. Since they hadn’t had connections with the demons in warmer lands, they fell quickly and eventually disappeared.");
			outputText("\n\nAbout the non-hostile inhabitants, I don’t know much. There used to be a dwarf mine and a kind of elven court located in the Rift before my arrival, but they’re abandoned now. They probably perished at the hands of the ice demons, but nevertheless, both the court of the mines are good sources of loot.");
			outputText("\n\nA tribe of reindeer-morphs live not far from here. It seems they feel safer living near the hills around the palace, probably because my presence keeping most of giants and yeti away.</i>\"");
			outputText("\n\nAnd about your second question");
			outputText("\n\n\"<i>Calm down " + player.mf("boy", "girl") + ", I’m going for parts. You don’t believe I opened the portal to the first world which appeared, right?");
			outputText("\n\nUsing the astronomical oculus from the temple of Mittani, I was able to see the principal realms. Many of them were uninhabitable, and some others were protected by gods that could make my stance very difficult. Mareth was in a middle of a war, and my arrival was probably unnoticed. Originally, I planned to land in the plains, but, because the war was very close to that land, I opted for the Rift, far from any forces of the factions. And I’ve living there since then.</i>\"");
			cheatTime(0.25);
			flags[kFLAGS.ANZU_AFFECTION] += 5;
			flags[kFLAGS.ANZU_TALKED_RIFT] = 1;
			doNext(anzuTalkMenu);
		}
		private function anzuTalkPowers():void {
			clearOutput();
			outputText("Anzu said before he was a powerful deity. What are his powers exactly?");
			outputText("\n\n\"<i>The term ‘god of storms’ mean anything to you?</i>\" Anzu says mockingly");
			outputText("\n\nWell, that’s obvious, but being more specific, what kind of things he can do?");
			outputText("\n\n\"<i>Well, actually, that’s not a bad question, since most people tend to misunderstand the nature of my power over storms.</i>\"");
			outputText("\n\nReally?, When you heard ‘god of storms’ the first thing that hit your mind was him having a sort of powers related to lightnings and thunder, given the electric nature of the storms.");
			outputText("\n\n\"<i>That’s what I’m talking about. People usually put together lightning with thunder, even if they’re two entirely different things. Despite me having a...decent control over lightning, my ability to manipulate electricity leaves much to be desired, and besides, is quite inaccurate. To make things worse, in my actual state, I’m unable to use my electric abilities. The main reason is that generating electricity consumes a huge amount of magic power, since lightning bolts and sparks tend to need some charge and last a few seconds, or if you need them for a while, a continuous energy feeding, and that could be taxing.");
			outputText("\n\nIn compensation, I have power over something much more reliable. That is, the power over the sky forces: water and ice. Back on my home, I used those powers to create blizzards, hail, storms and floods when the situation demanded it. Name any hazard caused by weather and be pretty sure that I’m capable of doing it.</i>\"");
			outputText("\n\nHmm, so he was the responsible of the storm that you find the day that you met him?");
			outputText("\n\n\"<i>No. Despite the fact that I change the Rift weather from time to time, to keep my powers in good shape, I usually let nature follow its course. Interfering too much could draw unwanted attention to this place. ");
			outputText("\n\nI practiced a bit of manipulating the currents of wind and air that form the lower and middle parts of the sky. The air, seemingly harmless, hides a terrifyingly destructive power. With the year, I gained the ability of shape the winds into a slashing weapon, able to cut anything, and almost anywhere.  In addition to that, I created a much more complex, and...explosive way of manipulating the air. I start compressing the air around me in a range of more or less a half mile. The sudden lack of air makes any living being in the area faint, making escape almost impossible. Then, I release the compressed air in a single wave, in a 360 degree radius, with a range five times wider than the original area of extraction. Anything in the range is annihilated by the force of the expanding wave. The process of compressing, holding and releasing the air takes from ten to thirty seconds. I’ve been able to compress the air in a range of five miles and holding it for six minutes. The resulting wave reached ten times the original range. For this reason, I used to practice my powers on uninhabited areas of the world, far away from Mittani or any other city protected by the council. But, in case of emergency, I could take the air from fifty miles and released it in a range of a thousand miles</i>\"");
			outputText("\n\nThat seem a bit extreme, even by Anzu’s standards. Did he ever use this ability? ");
			outputText("\n\nOnly a couple of times. The first was almost two thousand years ago. The Council was in formation. I was a low-ranking member in those times, and the land was inhabited by horrid monstrosities standing hundreds and hundreds of feet tall. Some even reached the thousands. We the Annuna cannot establish our supremacy over the mortals with those creatures wandering around. Then I created and perfected this ability. The rest of the Annuna tried to do the same, with poor results. Impressed by my capacity, Enki elevated me to middle-rank and put me in the front to fight those monstrosities. After a century and half, the beasts were totally eradicated.");
			outputText("\n\nThe second time was five centuries after. A rival group of gods, whose origin is still unknown to me, appeared in the world. Some members of the Council said they came from the stars, outside of our world, as their forms were unrecognizable, even for Enki. Others said they came from a land in the far East, because in this land the apparitions were more frequent. I was sent to explore and inform to the Council what I discovered. Then, they attacked. Our cities in the skies and the mortal cities in the earth were struck by a storm, one from a unnatural source. Then it came to my sight. An abhorrent mass of flesh, which covered all the skies. Around it smaller shapeless masses danced. An urgent meeting was called. The elders in the Council said that if we didn't act soon, we would be doomed.  Enki, considering my success in the fight against the first abominations five centuries ago, formed a group with the purpose to fight the menace. Ninurta, the current \"<i>Champion</i>\" of the Council was called too. Enki asked me to use the explosive wave against the other gods, and I agreed.");
			outputText("\n\nIn less of a week, we departed to the land of Hattusa, the place in the world most close to the outer sky, when the air and the ether mixed together. Enki, Ninurta and I decide to use our special growth to expand the power of our combined attacks.");
			outputText("\n\nGrowth?");
			outputText("\n\nThe Annuna had the ability to increase his body size to gargantuan proportions. Originally, that was done to fight the abominations of the early ages. In that critical moment I was forced to combine the both the growth with the explosives. After that crisis, it was done in some moments, when mortals behave in a rebellious way and serves as an intimidatory way to keep them in line. I was one of the most asked to fulfill this labour, not in Mittani, but sometimes in some cities across the desert.");
			outputText("\n\nBut, how did the fight end?");
			outputText("\n\n\"<i>As I was saying, Enki, Ninurta and I went to the highest mountain, near the city of Hattusa. When the clouds above the mountain dispersed, the other gods appeared above us. Enki and Ninurta placed themselves to my sides, to prevent to being dragged by the winds force. Then I compressed the air in fifty miles around the mountain. When I was compressing it, Ninurta launched his arrows to the skies, injuring most of the lesser gods, and Enki, taking advantage of the void created by the lack of air, started to burn them with a pure wave of energy. When the wave was ready, Enki launched an attack formed of projectiles of energy and ice, and impulsed it with the force of the expanding wave. The impact destroyed all the lesser gods, but left the principal body untouched. Ninurta launched more arrows while Enki and I repeated the process of wave-energy-ice for a while. Then I realized that the attacks, though powerful, lost force in the higher areas of the sky. Ninurta and I fled closer to the abomination while Enki covered our advance. Now closer, we repeated the procedure, with more clear results. It took from us nine days and nine nights of a constant offensive, but in the end, the rival group of gods, including the biggest abomination were reduced to ashes. I’ve never reached that level of explosion without the body growth all of us can do.");
			outputText("\n\nThe consequences of our battle in Hattusa was the destruction of almost all the life in our world. Fortunately, many of the mortals that worshipped us hid and survived, and in less of one century the order in the world was restored.");
			outputText("\n\nAnd now, physical abilities. Now, that I mentioned all those supernatural things, those abilities can sound a bit mundane.</i>\"");
			outputText("\n\n\"<i>Well, for start, I was born left handed, but, for practical reasons, became ambidextrous. This was ages before becoming a relevant member of the council, when my close combat was more reliable than my supernatural powers. Now, while I never had fear of unarmed combat, I also have a large arsenal in my armory to choose a weapon. ");
			outputText("\n\nWhen I still was a member of the Council, everyone recognized me by my twin blades: Labarna and Hattusa.</i>\"");
			outputText("\n\nHe says, pointing to a pair of knives on the wall. Almost five feet long each, they’re bathed in a layer of gold. Each one has the shape of a wing, with an intricate pattern of feathers. When you approach to see them better, you notice how the ‘feathers’ protrude past the blade. They are in reality a set of sharp spikes, vicious enough to tear away the flesh of anything unlucky enough to get too close to them.");
			outputText("\n\n\"<i>But, between all those, I prefer this.</i>\"");
			outputText("\n\nAnzu shows you a huge sword, almost eight feet long, covered in gold and decorated with blue and white gems. A bird decorates the pommel, and the blade is decorated with a letters in a strange language.");
			outputText("\n\n\"<i>My favorite weapon for close combat: Etemenanki.</i>\"");
			outputText("\n\nThat’s a strange name. You ask him if it means something in specific.");
			outputText("\n\n\"<i>It means ‘temple of foundation of the Sky and Earth’. Generally, a sword as big requires the use of both hands, but I do it well using with one. In the middle of combat, I find useful to change the sword from one hand to another.</i>\"");
			outputText("\n\nYou ask him if you can try it.");
			//This will be worked on
			outputText("\n\nAnzu hands you the sword. An instant after, a burning sensation invades your hand, making you drop the sword.");
			//
			outputText("\n\n\"<i>Is not a weapon that everyone can use. Etemenanki only allows me to use it.  This result useful when someone tries to use it against me.</i>\"");
			outputText("\n\nAngry, you state that he could’ve prevented you before he gave you the sword, you say.");
			outputText("\n\n\"<i>It’s a little too late now.</i>\" He answers, laughing.");
			outputText("\n\nWhatever, but, since he said he lost most of his energy in the escape from his world, how much of those powers can he use now?");
			outputText("\n\n\"<i>Well, my physical abilities remain intact, but I can’t fight for weeks without a rest like in the past. I can use most of the my fire abilities, and the electric fire too. In theory, I could create storms, but the lack of humidity makes it impossible for me. Before, I could make my own water, and make rain, but now I can’t. I have no problems with the growth, but trying to make an expansive wave is probably out of my capacity. I retain my immortality at least. That, and some minor powers here and there, are the only things that make me more than a demigod.</i>\"");
			outputText("\n\nSo...no explosive wave? That’s sad...and a relief, at the same time.");
			cheatTime(0.25);
			flags[kFLAGS.ANZU_AFFECTION] += 5;
			flags[kFLAGS.ANZU_TALKED_POWERS] = 1;
			doNext(anzuTalkMenu);
		}
		private function anzuTalkMaraeAndLethice():void {
			clearOutput();
			outputText("Anzu said he was aware of the war between Marae and Lethice. After fifteen years in the Rift, he hasn’t been tempted to support one side?");
			outputText("\n\n\"<i>I’ve said before, [name]. I act for myself. Always have been that way. Even before coming here. Besides, even if I sided with you and helped Marae, her followers probably wouldn’t look well on me.</i>\"");
			outputText("\n\nWhy? He has proven to be a nice guy, and by helping Marae, that would make clear to everyone that he is on their side.");
			outputText("\n\n\"<i>" + player.mf("Boy", "Girl") + ". I’ve never been exactly what you call a moral being. Even on their side, they’ll tend to criticize my methods and the way I spend my free time.</i>\"");
			outputText("\n\nBut the sex life in Mareth, and the tastes of their inhabitants has been relaxed and open with the years, with the only condition that they don’t involve corruption.");
			outputText("\n\n\"<i>Corruption isn’t the problem, and I know the new Marethian standards. How to explain it, well, you know how demons boast about orgies and hurting innocent people, but I’ve been doing that for well over two thousand years.</i>\"");
			outputText("\n\nWhat.");
			outputText("\n\n\"<i>I used to have orgies in the place that I used to live. Not the kind of orgy of you’re accustomed in Marae, and usually end bad. Not I’m saying I miss them, but having a good party without anyone getting accidentally or deliberately killed in the middle of it would be nice.");
			outputText("\n\nBesides, I’ve fought wars for my city. And, like in most wars, many innocent people die. But, it was part of my duty as a patron god of Mittani.</i>\"");
			outputText("\n\nSo, the problem that prevents him from joining Marae’s side is the fear of being criticized?");
			outputText("\n\n\"<i>No. The problem with supporting one side or the other is the same: Mareth would be aware of my presence, and that would make my life here less than pleasant. One side would start harassing me for more support, while the other would become a constant nuisance, trying to get rid of me. For now, I’ll remain neutral.</i>\"");
			outputText("\n\nThere is something that would make him intervene in the war?");
			outputText("\n\n\"<i>There are two circumstances. The most obvious would be, if one faction or both extend the war to the Rift. In that case, my best option would be to join forces with the valkyries, Jotuns, and yetis to send them out of the Rift. They’ve allied themselves before against ice demons.");
			outputText("\n\nThe second thing would be if one faction decides to attack me specifically. As an obvious response, I’ll be forced to side with the opposite side, to prevent further attacks. Since the demons are the more hostile side, they’ll be probably the first ones on invade the Rift or attack me, but, personally, I don’t trust in Marae either.</i>\"");
			outputText("\n\nBut, Marae is the goddess of purity, and most of the original denizens in Mareth support her. Besides, she was the original ruler of this realm. What reasons does he have to distrust her?");
			outputText("\n\n\"<i>There are many aspects. First, the naive attitude of her followers. Most of them fell quickly under the demon attack due to how unprotected they were. Maybe the lack of a menace in centuries made the population too confident in their safety. Today, there are some of her followers that believe that the war will end magically with a single intervention of their beloved goddess.");
			outputText("\n\nAnother thing is the disorganization of her forces. Even the well trained warriors on her side act in separated groups. Before I said I gave a look around the realm before jumping in, enough to get some general information about the realm situation. That allowed me know where Marae was all the time, the existence of a city called Tel’Adre, the principal races in some zones, and some others details, which helped me to make a decision in the place that I’ll land. Obviously, that was fifteen years ago. By now, many things have changed for sure. But, things didn’t look well for her supporters in those times, and I doubt that they’re better organized now.");
			outputText("\n\nThe attitude of Marae towards her followers doesn’t help. She stays on the Lake, being little more than a decorative figure or a kind of \"<i>symbol of resistance</i>\" instead of an active leader. She could, at least, give advice to her allies about how to act against the demons.</i>\"");
			outputText("\n\nYou tell him about how she was getting corrupted by the fluids coming from of the demon factory, thus limiting their actions. When you met her, the first thing she did was send you to stop the corruption from the factory on the lake.");
			outputText("\n\n\"<i>And why she didn’t send someone in the files of their followers, or even better, a entire force, to get rid of that place? All of that could be traced to one word: inefficiency. With all that in mind, the deplorable state of Marae’s forces is not a surprise. How do you even pretend to win a war if you are totally unprepared? And I don’t have the intention of siding with the loser’s side.</i>\"");
			outputText("\n\nReally? He prefers support the demons? You’ve thought better of him.");
			outputText("\n\n\"<i>Not really, [name]. Lethice’s side isn’t any better. Even with more organized forces, better strategies and a more efficient leader, their goal is totally pointless. Corrupt every living being in this world. And after? There’s the option to invade and corrupt other worlds, but if that was a viable plan, they would've already started. Lethice knows than an invasion to another world sooner or later would end in a disaster. For example, imagine than the demons try to invade my former world.</i>\"");
			outputText("\n\nYou don’t think than an invasion of a world ruled by a multitude of gods, with a character much less benign than Marae would be a good idea.");
			outputText("\n\n\"<i>Exactly. Even with only thirty-seven members, the Council will annihilate the demon forces in a matter of seconds, and, even worse for Lethice, they’ll prepare a punishment expedition. The only reason that they’re not here after me in one, is the fact that they don’t know where I went… or maybe Gilgamesh asked Enki to forgive me. But we’re changing the subject.");
			outputText("\n\nThe corruption of the land has a limit. And with stupid decisions, like stopping the rains, they only make life in Mareth more difficult for them. What’s it worth to be on the strong side if they will do stupid things with their power?</i>\"");
			outputText("\n\nWell, he has a point. Both sides have defects. And while is sad, the fact that he won’t help Marae in the war, it’s a relief that both of you share the same idea about Lethice.");
			outputText("\n\n\"<i>Maybe, if her forces organize better, and she respects my position as an equal in this land, I’ll think about helping her against the demons, but for now, I’m not joining the war.</i>\"");
			cheatTime(0.25);
			flags[kFLAGS.ANZU_AFFECTION] += 5;
			flags[kFLAGS.ANZU_TALKED_GODS] = 1;
			doNext(anzuTalkMenu);
		}
		
		//Sex
		private function anzuSexMenu(clear:Boolean = true):void {
			if (clear) clearOutput();
			outputText("Still coming soon.");
			/*if (flags[kFLAGS.ANZU_TIMES_SEXED] == 0) {
				outputText("You ask Anzu if he is up to a little fun in his bedroom.");
				outputText("\n\n“Uh, maybe” he says doubtfully.");
				outputText("\n\nWhy so shy suddenly? Based on the stuff he has told you, he certainly had some experience in what refers to sex when he was living in Mittani.");
				outputText("\n\n“No, that’s not the problem”");
				outputText("\n\nThen, what?");
				outputText("\n\n“Well, you see. I haven’t had any partner on bed since, well, since I arrived there. That was fifteen years ago. Besides relieving myself from time to time, I haven’t been very active and probably I’ve lost most of my practice. Mareth is a different than Mittani, and you must have much more practice than I, and I don’t want to ruin our friendship with a disappointing night on bed.”");
				outputText("\n\nYou aren’t exactly an expert, and don’t expect the same from him. After all the only thing who you want is a little fun with a close friend.");
				outputText("\n\n“I’ll do my best so i won't disappoint you, then.”");
				outputText("\n\nBoth of you hurry to Anzu’s bedroom. The sweet smell of the flowers inundate the air, while the soft heat from the fireplace makes the atmosphere perfect.");
				outputText("\n\nAfter climbing on the bed with his help, Anzu and you roll in the soft linen sheets of the bed for a while, groping and caressing each other. Well, mostly you, since with his huge frame is easy for you pass a hand across his soft and feathered body. After a bit of foreplay, both of you though who is a good time to start the real fun.");
				outputText("\n\n“Well, you got me here, what do you want to do?” he asks.");
			}
			else {
				outputText("You ask to your avian friend if the is the mood for some fun again.");
				outputText("\n\n“If you’re ready, I’m ready” he answers.");
				outputText("\n\nBoth of you hurry to Anzu’s bedroom. The sweet smell of the flowers inundate the air, while the soft heat from the fireplace makes the atmosphere perfect.");
				outputText("\n\nAnzu and you roll in the soft linen sheets of the bed for a while, groping and caressing each other. Well, mostly you, since with his huge frame is easy for you pass a hand across his soft and feathered body. After a bit of foreplay, both of you though who is a good time to start the real fun.");
				outputText("\n\n“Well, you got me here, what do you want to do?” he asks.");
			}
			menu();
			addButton(0, "Anal Catch", catchAnal);
			addButton(1, "Vaginal Catch", catchVaginal);
			addButton(2, "Get Sucked", getBlown);
			addButton(3, "Blow Him", suckOffDeitysCock);
			addButton(4, "Fuck Him", fuckGodlyBirdButt);
			addButton(5, "Feed Him", feedAnzu);*/
			addButton(14, "Back", anzuMenus);
		}
		
		private function catchAnalPart1():void {
			clearOutput();
			if (flags[kFLAGS.ANZU_ANAL_CATCH_COUNTER] == 0) {
				outputText("Looking at the handsome avian, your eyes quickly dart to the huge bulge on his pants. You look it, thinking how must feel to have that thick and huge monster inside. Anzu, who laughs nervously at your staring, seems to have realized what you have on mind.");
				outputText("\n\n“Wha...what you want to do, [name]?”");
				outputText("\n\nYou have quite clear what you want. Not in the mood to waste too much time on foreplay, you start teasing him caressing the feathers of his chest and slipping one hand over his crotch. If your idea wasn’t clear enough, now it is.");
				outputText("\n\n“Are you sure?” Well, has been a long time since I did that with someone, and well, given its size, it could hurt you...” He states, pointing the size of his bulge. “Even if you are okay with that, you’ll certainly end…how to say it, more…loose, after we finish.”");
				//Variables checking
				outputText("\n\n");
				if (player.analCapacity() < 100) outputText("That certainly could be a difficult task, but");
				else if (player.analCapacity() < 150) outputText("A big one, certainly, but, since you already had some experience with those things, taking it shouldn’t be a problem, and");
				else outputText("Really? Well, you had plenty of experience on Mareth, and despite how big he can be, you could easily take it on a single thrust, besides, you can’t see how his avian manhood is left unattended day after day. Even with the occasional release");
				if (flags[kFLAGS.ANZU_SUCKED_OFF_COUNTER] > 0) outputText(", and blowjob");
				outputText(", nothing compares to a tight and nice hole to slide in his package. And, in a world like this, it’s matter of time before you lose your tightness, and what could be better to lose it with your " + (anzuRelationshipLevel() >= 4 ? "lover" : "friend") + " than with a random monster on the wilderness? For make yourself sure that he won’t object anymore, you slip a hand on his underwear and start caressing his balls. The massive nuts almost groan on their desire for release, prompting a shudder on him, who blushes at your fondling of his intimate parts.");
				outputText("\n\n“O-okay, if you insist, friend….” a flustered Anzu answers” We should get started, then.”");
				outputText("\n\nStill a little unsure, he starts removing your [armor] while you lean over the bed. After leaving your clothes on the side, he takes off his clothes, dropping them on the floor, leaving him only with his underwear. You display your naked form on the bed, and shake your butt in the air " + (player.tailType > 0 ? "wagging your " + player.tailDescript() : "") + " to entice him. Despite his initial doubts, his arousal becomes obvious, judging by the way his cock starts tenting his underwear. He finally removes it, letting his partially erect cock hang free.");
				outputText("\n\n“Um…, I think that now we should…” A nervous Anzu tries to explain “You know, get something to lube my dick, because, else...”");
				outputText("\n\nHmm, seems like you have a throbbing and flopping source of lube just in front of you. With that on mind, you motion him to climb next to you. When both of you are on the bed, you grab his cock, whispering on his ear who you know how get all the lube that you could need, prompting an ‘oh’, from the avian. The lustful feeling that invade your bodies, and the increasingly erect cock in your hand tell you exactly what to do next.");
			}
			else {
				outputText("Looking again for another ride in Anzu’s huge rod, you climb over him and ask if the is in the mood for another round on the bed. This time, the avian answer is a huge grin.");
				outputText("\n\n“Seems like you can’t get enough of my cock, little friend.” he says, giving your [butt] a playful grope. “Well, since if that’s what you want, I think that can be arranged.”  ");
				outputText("\n\nAfter tossing his robes and other clothes to the armchair, he starts undressing you. Far from his nervous initial state, the aroused avian is clearly happy to share his bed with you again. His hands eagerly take of the upper and lower parts of your [armour] and start caressing your [skin]. You display your almost naked form on the bed, and shake your (if tails<1) [butt] in the air (else if tails=1) wagging your tail (else if tails>1) wagging your tails for entice him.  Your reaction isn’t left unnoticed, as he gropes your (if player has balls) [balls], (else if cocks>1) cock (else) nipples when he takes of your underwear, leaving your nude body to his sight. Finally, he removes his underwear too, dropping it in the floor and leaving his huge avian manhood exposed.");
				outputText("\n\n“That’s enough teasing for now, little (boy/girl). Prepare yourself for the real action.” He whispers on your ear.");
				outputText("\n\nClimbing on the bed, he hugs your (if player height>96), in comparison, (else if player height<50 and>50) small (else if player height<50) tiny frame on his strong arms. While he embraces you, the feeling of his hardening cock teases your backside. Seems like the avian has gotten much more confidence, and by the look that he’s giving to you, he’ll surely enjoy to be on the dominant position again. He relaxes his body on the bed, flexing his arms and legs, and leaving your face a few inches of his meaty rod.");
				outputText("\n\n“Well, [name]. I think who you’ll know what to do.” Anzu says you” And, after all, we’ll need some lube before get started, don’t you?”");
				outputText("\n\nYou can’t agree more. With his cock in front of you, ready for be lubed, and your body screaming to be taken, there’s not much more to say.");
			}
			doNext(catchAnalPart2);
		}
		
		private function catchAnalPart2():void {
			clearOutput();
			var wasVirgin:Boolean = player.ass.virgin;
			outputText("Climbing over him, you (if snake, dragon or demon tongue) wrap your nimble tongue around (else) start caressing and licking the sides of  his partially hard avian meat. After a bit of licking across its length, you switch you attentions to his tip, taking the point of the tapered penis on your mouth and sliding playfully your tongue on his cumslit. Soon, the forty-inch rod rises to full erection, and the first droplets of pre dribble from his tip and land in your tongue. You remove your mouth and take some of his leaking pre in your hand, smearing it carefully across your soon-to-be ravaged [asshole]. Despite being already lubed by your saliva, you take some more pre and use it for lube every corner of Anzu’s semi-hard maleness.");
			outputText("\n\nThe avian seems to be enjoying this treatment, given how his erection twitches, staining your hands with his dribbling pre. When you are sure that both your [asshole] and his cock are thoroughly lubed, you let him take control.");
			if (flags[kFLAGS.ANZU_ANAL_CATCH_COUNTER] == 0) outputText("\n\n”Since it’ll be hard to get in anyway, how about...well…we can make the task easier if you simply sit on my…” the avian says, shyly pointing his penis (else) ");
			else outputText("\n\n“Now, for a good start, how about making this easier for you, my friend.” He says, stroking his avian erection “A nice and slow ride.”");
			outputText("\n\nFollowing his motion, you let your [butt] rest in front of his leaking erection. Anzu grabs your buttcheeks and starts hotdogging you, dripping his copious pre across your buttcheeks. The combined feeling of wetness on your backside and his tool sliding across your buttcheeks are more than you can manage to endure, so you position you [asshole] just above the tip of his penis.");
			if (flags[kFLAGS.ANZU_ANAL_CATCH_COUNTER] == 0) outputText("\n\n“So, you want to get started, right? Just be careful when sliding in…”");
			else outputText("\n\n“Tired of waiting, hmm? Given that, I’ll let you do the honors. Only remember to take it easy.”");
			outputText("\n\nFollowing his advice, you slowly take the meaty tool on your anus, letting out a whorish moan as you feel the dripping maleness invading your butt. Already lubricated with his copious amounts of pre, the first inches of his cock slide in easily.");
			player.buttChange(182.4, true);
			if (wasVirgin) {
				outputText("\n\n“Damn, " + player.mf("boy", "girl") + ". It's way tighter than I expected. How much experience you exactly have doing this?” the avian asks.");
				outputText("\n\nYou admit that this is your first time with anal" + (player.cockTotal() > 0 ? ", at least in the receiving end" : "") + ".");
				outputText("\n\n“Wow, you just allowed me to be the first one on have a way with your ass? I can’t believe it.” A surprised Anzu says, with a sincere smile. “Let me assure you, [name], that I’ll make you feel like you never felt before… Err, in a good sense, of course.”");
			}
			outputText("\n\nHis hands go to your hips, grabbing " + (player.isNaga() ? "your coils" : player.isTaur() ? "your rear and hind legs," : "your lower body") + " and making use of his strength to raise up your body, and insert and slip out the first nine inches of his gigantic erection of your ass with teasingly slow pace. Despite his slow motions, your body (if cocks>1) your [cock] rises hard at the anal stimulation. When you thought that he finished to play with you, he raises your ass from his cock, leaving only the first inches of his tip teasing the entrance of your backdoor.");
			outputText("\n\n“Anzu?” is the only thing that you manage to say, blushing red at the feeling of his tip prodding your butt.");
			outputText("\n\n“Only playing a little, my friend. You teased me a lot before, and now I’m getting my payback.”");
			outputText("\n\nHis teasing continues for a while, sliding in a couple of inches and retreating his cock few seconds later. Adding to his teasing, he grabs your chest and, after caressing your [skin], he starts pinching and playing with your nipples, prompting another moan from your lips. Meanwhile, the tapered tip of his avian penis tease the entrance of your [asshole] in such a way, that you reach the point when you can’t help yourself, and pushing his arms aside, you try to get his cock in, sinking as much as you can of the gigantic rod on your ass. Seeing how you are in the limit, he lets you do that, putting his arms behind his head and relaxing on the bed while you do the job. In a single moment, almost fifty inches of the meaty tool spear your ass, and isn’t even the half of it!");
			if (flags[kFLAGS.ANZU_ANAL_CATCH_COUNTER] > 0) outputText("\n\n“I’m the mood, [name], and with your body to my disposal, I’m gonna give you the ride of your life.”");
			outputText("\n\nYou take the rod inside your butt in an increasing rhythm, sliding in and out, and taking as much of the avian maleness as you can in each thrust. Moaning as you feel the tick spear (if cocks>0) ravaging your prostate (else) ravaging your insides. Soon, almost thirty inches of his dribbling penis are spearing you, coating your innards with his pre. Sadly, given its thickness, you can’t manage to get inside more of it, but the stimulation of taking it in and out is quite enough to bring you to the point of orgasm.");
			if (flags[kFLAGS.ANZU_ANAL_CATCH_COUNTER] > 0) outputText("\n\n“Um, friend…” A flushed Anzu manages to say. By his look, seems like he’ll orgasm soon, and his words confirm it. “[name]…I think  I’m getting close”");
			else outputText("\n\n“Hey, little friend.” Anzu says, caressing again the [skin] of your chest. You look back at him, to find the avian almost as red and flushed as you. ” [name], better get ready for me...”");
			if (player.gender > 0) {
				outputText("\n\nThe avian’s hands darts to your crotch when your (if cock>0) hard [cock] is already leaking pre (else if cock>0 and vagina>0) hard [cock] is leaking pre, and you wet [vagina] is already dripping. (else) [vagina] is already dripping");
				outputText("\n\nand starts (if cock>0) jerking off your raging erection with his hands. (else if cock>0 and vagina>0) jerking off your raging erection with one hand, while slipping one finger inside your pussy, teasing its insides (else) slips one finger inside your pussy, teasing its insides.");
				outputText("\n\nHis efforts are prove effective soon, as (if cock>0) your cock, already stimulated by the ravage who your prostate had can’t hold anymore, and with a moan of pure lust, you release your load, (if cum output>1000) managing to hit your own face, and staining your chest, belly and even Anzu’s legs with your prodigious load. (else) managing to cover your chest and belly in white streaks of your own cum. (else if cock>0 and vagina>0) your cock, already stimulated by the ravage who your prostate had can’t hold anymore, and with a moan of pure lust, you release your load, (if cum output>1000) managing to hit your own face, and staining your chest, belly and even Anzu’s legs with your prodigious load. (else) managing to cover your chest and belly in white streaks of your own cum, at the same time, your pussy cannot hold the wonderful sensations of his fingering, releasing your girlcum over the avian’s fingers as you hit orgasm. (else). Your pussy cannot hold the wonderful sensations of his fingering, releasing your girlcum over the avian’s fingers as you hit orgasm.");
			}
			else {
				outputText("\n\nThe avian’s hands keep teasing your chest, playing with your nipples and caressing your belly.");
			}
			outputText("\n\nYour birdy friend reaches his own orgasm a moment later, and with a powerful avian screech, he releases himself inside you. Soon the first jets of avian semen explode inside your [asshole], swelling your belly more and more with each wave. Already dazed by the blissful sensation of your own orgasm, you take a little to notice the beautiful sensation of his creamy cum flowing inside you, but the feeling of his hot seed, combined by the warmness of your bodies makes you feel like you were in paradise. In fact, the idea of spend the rest of your life here…living in luxury and desire on Anzu’s palace quarters, spending your nights speared on his cock and your mornings eating with him, plus his bed jumping by hot and lustful sex every afternoon, when you think about it, the idea sounds quite appealing.");
			outputText("\n\nThe weight on your now cum-filled belly makes you jump back to the reality. You feel a wet sensation on your neck, and when you turn to see it, you manage to see who Anzu is licking you lovingly.  While doing that, he caresses you inflated belly with one hand while (if cock>0) taking some of your cum (else if vagina>0) looking at the girlcum on your fingers (else) caressing your nipples with the other. (if naga) Your coils (else) Your [legs] remain limp over his belly, stained by the avian seed who escaped from your [asshole].");
			if (flags[kFLAGS.ANZU_ANAL_CATCH_COUNTER] == 0) outputText("\n\n”Are…are you okay, [name]?” says a preoccupied avian. After answering him with a pleased nod he relaxes, and surrounds your body on his embrace. “Great, you leave me for a moment and I started to get nervous. By the way, that was the best time who I had on centuries, and I’m happy to see that you enjoyed it too. But, since you worked yourself pretty hard, you should rest for a while before doing anything else.”");
			else outputText("\n\n”Whoa, little (boy/girl), seems like you enjoyed yourself pretty well.” The avian says, at the time that he embraces your cum filled body. “But [name], you’d better rest for a while. After all, you took it like a real Champion.”");
			outputText("\n\n");
			outputText("\n\n");
			outputText("\n\n");
			outputText("\n\n");
			outputText("\n\n");
			outputText("\n\n");
			
			player.orgasmAnal();
			flags[kFLAGS.ANZU_AFFECTION] += 5;
			flags[kFLAGS.ANZU_ANAL_CATCH_COUNTER]++;
			doNext(camp.returnToCampUseOneHour);
			/*


Following his advice, you proceed to rest over his impressive frame, with Anzu’s deflated cock still filling your butt, and some of his thick cum leaking from your [asshole]. After some time, you feel a familiar sensation inside you. The avian’s penis is getting hard again! When you’re still surprised by the sudden feeling, Anzu’s hands embrace your chest, as he says.
(first time) “Looks like I’m aroused again, [name], and if you don’t mind, I think that we could, you know, have another round at it and all” a nervous Anzu suggests “If you don’t want you only need to say it…”
 
Seems like the nervous bird is finally breaking the shell…How you can say no to him? Turning around, your kiss his cheek and answer him who you’d love to have another go with him.
 
(repeat) “Hey, [name], seems like I’m still horny, little (boy/girl)” Anzu says, giving your butt a grope and a playful slap “And given that I have enough energy for another round, what do you say if I fuck you like you deserve?.”
 
Remembering how energetic was your last romp with him, and what he has in store for you, you can’t help but agree and nod energetically. Maybe is the sight of his magnificent body, or, more probably, his cock still filling your ass, but you can’t resist the idea of having him ravaging your already gaped anus again.
 
Grabbing you by the chest and removing your body from his partially hard cock, Anzu stands up from the bed, flexing his arms as he prepares to take you. You’re left on the bed, wondering about what he plans to do with you.
 
(first time) ”Maybe we could try another position?...If you are okay with that” he says, as his avian penis arises proudly again (next time)“How about trying something different this time?” he finally says, as his avian penis arises proudly again.
 
Anzu motions you to turn around. Bending over the bed, you’re left with your [butt] on the air, and your recently creamed backside dripping cum over your legs. The avian approaches, and, after giving you cheeks another slap, he inserts one of his digits on your [asshole]. Sliding in easily given the quantities of cum dripping from it, the finger teases your insides for a while, until Anzu gets bored of it, and removes it.
 
“Luckily, seems like we don’t need much preparations this time.” The avian says, seeing his fingers covered on the fresh semen who leaks from your [asshole]
 
Looks like the avian wants to take you in doggy style, and your idea proves true as you feel his towering frame covering your vulnerable body. Soon his head past yours and your body is completely surrounded by his. Even his wings expand to the sides, covering almost all your view from the exterior. In any other moment, you’d feel unnerved at the thought of having your body totally covered under a huge being, but now, you can’t imagine a better place to be. Letting out a moan at the feeling of the weight of his penis resting over your buttcheeks again, you’re surprised by a wet sensation of your face. When you turn to see what is making it, you face with a happy Anzu, his head turned upside down from your point of view, with his tongue extended and licking your face affectionately. When you stare him, he simply moves his head from side to side in a bird-like way, after that, both of you start laughing at his strange antics.
 
That done, the avian hands start fondling your nipples, caressing the soft [skin] between them. (if cocks>0) One of his hands slides down to your crotch, playing with your [cock], that is still dripping with the cum from your last orgasm. (else if vagina>1) One of his hands slides down to your crotch, when a playful finger slides into your [vagina] and teases his insides again. (else) One of his hands goes to your butt, caressing your cheeks and slapping them playfully. It’s amazing how with his huge size he can manage to reach each corner of your body. Now his nimble fingers are on your belly, and after some caresses, he starts ticking it mercilessly, earning uncontrolled laughs from you. Finished with his foreplay, he prepares to the main part, stroking his dick, and teasing you again, sliding only the tip of it in your needy [asshole]
 
Then, without warning, you feel almost eleven inches of pure avian meat invading your [asshole] in a single thrust. Yelping at the sudden intrusion, you’re given a few seconds to rest as the thick penis slides out, before Anzu rams his cock inside again, this time a few inches deeper. You moan like a whore each time that the monster makes its way on your [asshole]
 
“Feeling okay, little (guy/girl)?” Anzu asks, somewhat worried about your state. You nod in response, earning another grin and a loving lick from the avian. “Great, because I want to be sure that you’re enjoying this as much as I.”
 
Truth to his word, he combines the energetic pounding that he’s giving to your butt, with an equally vigorous (if cocks>0) handjob that he’s giving to your [cock], which has gotten erect under his anal stimulation, pumping its length until your pre starts dripping from it (else if vagina>1) fingering that he’s giving to your [vagina], playing with his insides with his fingers prompting some girlcum to leak from it (else) massage that he’s doing to your [nipples], as he caress the soft [skin] of your chest. Your entire body is hot under his ministrations, at the time that his thrusts slide his avian manhood inside your ravaged [asshole]. Anzu softly nips you neck with his beak, helping you to keep in position as his erection pistons in and out of your [asshole].
 
With each thrust more and more inches of the huge tool invade your ass. The copious pre that it dribbles mixes with some cum from his last load, leaving your backside sticky with it. Not that you have time to think about it, because almost thirty inches of cock are making its way inside you. For a second you’re worried about him trying to ram his entire cock inside, but your friend seems to recognize the logic limits of your body, and stops at this rate. Not that his vigor diminishes, as he compensates this increasing the speed and strength of his already energetic thrusts. (if cocks>0) Your poor prostate is thoroughly smashed by his invading dick, while your nipples get as hard as diamonds by your overstimulated state.

His huge nuts (if player has balls and cocks>0) slap against your body, hitting your own in each thrust (else if cocks>0) hit the underside of your [cock] in each thrust (else) slap against your body. With each hit you can feel the liquid weight of his prodigious load churning inside them, a reminder of what he has stored for you.
A familiar heat overcomes your bodies as Anzu increase his pace even more. Drop of sweat fall from your body, as the heat between you increases and your breathing becomes heavy, making clear that both of you will climax really soon.
 
(first time) [name], friend…I won’t be able…to hold…much longer…” (next time) “[name]…this time…is a really big one…get ready, my friend.” It’s the only thing that Anzu manages to say between pants.
 
Then both of you hit orgasm. (if not genderless) You came first, (if cocks>0) when your cock twitches wildly, releasing your load over the sheets (if cum output>1000), with enough force to cover most of them and stain the [skin] of your [legs] (else if cock>1 and vagina>0) when your cock twitches wildly, releasing your load over the sheets (if cum output>1000), with enough force to cover most of them and stain the [skin] of your [legs], while your [vagina] moistens your tights with girlcum. (else if vagina>1) when your [vagina] moistens your tights with girlcum.Your entire body quivers as you reach climax, and even when it passes, you’re left panting heavily.
 
After your orgasm you feel so weak that you fall over the sheets (if cocks>1) staining your face and chest on your own load. Your [butt] still raised, with Anzu’s cock firmly buried inside and the strength of his thrust serving as support for your backside. Then, you realize that your avian friend is about to climax too. As expected, with another screech of ecstasy, Anzu releases his load inside you. Your anus is creamed again as his cumslit unleasehs a torrent of semen, that soon overfill your insides with enough force to make your belly tremble as the seemingly unending waves of cum flow in.
 
Looking mesmerized how your already expanded belly expands to the point that you’ll easily pass for a nine-months pregnant woman, you can still feeling the las jets of Anzu’s seed overfilling you even more. When his orgasm subsides, he slides out his deflating cock, prompting some of the cum pumped inside you leak from your gaped orifice. Tired after the…energetic…experience, Anzu falls to your side, panting, and with his arms surround your cum-inflated form. Licking again your face the bird gives you a loving look and says
 
“Well, I hope that I fulfilled my promise. do you feel like you never been before?”
 
(if player has been fucked by a minotaur, Loppe, or a big cocked NPC) Maybe he can't boast of having the most impressive libido on this land, but he surely know how plow an ass, (else) Of course, and your (if anal cap<150) gaped anus if proof of it. In the end, you got even more than you expected, you answer him. Laughing softly, the avian surrounds your body on his embrace, protecting your (if player height>96) comparatively (else (if player height<96 and>50) small (else) tiny frame on his wings. His  strong hands caress your semen-filled belly as you drift to sleep on his protective embrace.
 
After a couple of hours, (if goo) you slimy body gradually process the prodigious load deposited into you. As it does that, you feel thoroughly sated by the creamy gift from the avian. (else) your body manages to process the gigantic load inside you in some way. When you try to stand up, your legs tremble weakened after the ravaging of your ass suffered. Dammit, Anzu! After such a pounding, you’ll be walking funny for a while.

			
			*/
		}
		
		private function catchVaginal():void {
			/*
			(first time)
 
Finding yourself on Anzu’s embrace, this time you wonder if the avian would like the idea to get intimate with you, in the most traditional way. The idea of enticing your avian friend on sliding that monster inside your vagina, while he pounds you with enough force to make you scream and finally, having his thick load flooding your womb is something that you can’t resist,  With that on mind, you slip down one of your hands to his crotch, and sliding down his underwear, start grabbing at the girthy meat who lies within. The avian lets out a moan at your sudden touch, but don’t removes your hand.
 
“Heh...what are you doing, (boy/girl)?” he question you, his face blushing red under his autumn colored feathers.
 
Only giving him a little motivation, you answer. After all, you came to his bed to have a little romp together. You suggest him that he should take off his clothes, so you could take care of him better. Nodding eagerly, probably due your touch, Anzu removes his fancy garments, and later, his underclothes (if player isn’t naked), while you do the same with your [armor]. This finished, you return to your task, sliding your fingers across the avian meat and his feathered balls While you fondle his genitals, the avian, between moans of pleasure, asks you what you want to do with him. Seeing your opportunity, you climb to his shoulder and whisper to his ear that you’d love to have him taking your pussy and mating you like a beast. Both of your eyes dart to his tapered penis, now half hard after your enthusiastic handjob, and the avian gives you a loving smile, but with a hint of worry on it. Surprised by that last thing, you ask him if he has a problem with it.
 
“I don’t know, [name]. Don’t get me wrong, I’d love to do it with you, but look at it,,,” the avian answers, pointing the gigantic and half hard cock between his legs. “If you’re not careful you could get hurt...and I don’t want to see that happening.(if player height<50) Only, look at you...and me.”
 
Caressing tenderly the fluffy and colorful feathers of his chest. you state that it (if vaginal capacity<500) shouldn’t (else) won’t be a problem. You’re in Mareth after all! Big-cocked monsters are things of everyday, and some of the friends who you’ve made are pretty hung too. (if virgin) Overall, you even managed to keep your virginity until now. Why not losing it with someone who you really care, instead of with a random monster in the wilderness? With someone as affective and kind as him on bed, you shouldn’t be worried about anything. (if not virgin) Now that you are a little experienced on that matter, it only require a little effort to make the experience pleasurable for both of you, and with someone as affective and kind as him on bed, you shouldn’t be worried about anything.
 
“Really, [name]? I’m a little flustered...about you thinking of me in such a way.” the avian answers.


“Well, if you want it too…” he says, almost whispering this last word. “I suppose than I could do it for you.”
 
(next time, repeat)
 
Finding yourself on Anzu’s embrace again, you wonder if he will want to take you again in the most traditional way. The idea of enticing your avian friend on sliding that monster inside your vagina, while he pounds you with enough force to make you scream and finally, having his thick load flooding your womb is something that you can’t resist. With that on mind, you slip down one of your hands to his crotch, and sliding on his underwear, start grabbing the girthy meat who lies within. Anzu gives you a smile as he notices what you’re trying to do, as his cock hardens at you playful grope.
 
“So, you want another round with me, (boy/girl). Looks like I’m not that bad when is time of take care of my mate.”
 
Of course not. Actually, he was pretty good the last time, and you won’t mind repeating the experience, you answer him, while your hands keep fondling his tapered penis and his soft balls. Soon, his avian manhood is half hard. At that point you stop your handjob and ask him about taking off his clothes, so you can take care of him better.
 
He does it with no hesitations, taking off his fancy garments and tossing the to the floor, doing the same with his underclothes few seconds later, leaving his nude beauty exposed to your eyes. Quickly you follow his example and strip yourself from your [armor]. You take a moment to contemplate your (if relatlvl=3) friend’s (else if relatlvl=4) lover’s form while he stands next to the bed, looking the lovely pattern that his colorful feathers take across his body, and his equally colorful wings. Complemented by that gigantic monster that hangs from his legs and his strong complexion, Anzu is all and more than you could ask from an avian. The soft light from the bed and the scent of violets which emanates from his body, make his toned form even more alluring. But, while you admire his body, some time has passed, and somewhat confused by your continuous staring, Anzu coughs to get your attention again. You state that with a body as attractive as his, you can’t help but ogle at it. His face blushes red behind his feathers at your flattering, as he only says a shy ‘thanks’ as an answer. A little surprised by how quick he undressed, you say him that, given his initial doubts, he’s becoming quite eager each time that you have a romp together.
 
“Hey, it’s your fault, [name]” “You’ll end making me a horny beast in no time.” he answers, while his half hard cock add weight to his statement.
 
Hmm, that wouldn’t be bad either. Anzu ravaging your body as an unleashed monster, taking you how he wants...but if you wanted that, they are plenty of monsters on the wilderness. You like him as he is, and if he wants to go wild while you’re on bed, go on.
 
“So you want me going crazy when we’re doing it? How about like this?.” He says as he playfully mimics the pose of a bird of prey, with his wings fully opened and his face contorted awkwardly in some that pretends to be a menacing visage. Both of you start laughing at his obviously fake attempts to look intimidating.
 
“Jokes aside, [name]. I promise you that I’ll take you like anyone before...except me, of course.”
 
If he’s so sure about that, what are you waiting? nodding, he motions you to go to the center of the bed, and while you lay there, he strokes his now flaccid dick until it reaches full erection..
 
//Scene continues
 
Ready for start, you lean over the bed, with your body resting on the soft mattress and the huge frame of Anzu over you. He lets his hard cock fall over the entrance of your nether lips, leaking some pre over them and giving you a sight about that going to come.
 
(first time) ”Hey, [name]. You know, we need something to lube up my penis, because if we don’t, well...it probably will hurt you when we get started. Then I thought that you could use my pre as lube...if you want to do it, of course.”(repeat) “Uh, (boy/girl). If you really want to get it, without being split in half, you’d better start to get some lube.” the avian says, pointing the dripping tip of his avian manhood.
 
Nodding, you grab the tip of his penis, and taking some of his copious pre on your hands, you smear it across your nether lips, until they’re slick and lubed. Finished with them, you work with the avian’s cock, smearing the dribbling pre across all its length. After a few layers of pre, its left thoroughly lubed, and ready to pound your body.
 
(if virgin) “[name], you’re nice and tight down, here (boy/girl). How many times...you know, had taken something there?”
 
You say him that you managed to remain virgin until now, despite the constant dangers of this land.
 
“And you were allowing me to be the first one that could take you...properly?” says Anzu, blushing as you answer this last question with a nod. “Well, then the less that I can do is assure that your first time would be unforgettable, nice and slow at the start, and strong and passionate at the end”
 
Then you feel his cock touching the entrance to your pussy. You enjoy the wonderful sensation of the tapered tip of his penis sliding on your [vagina], opening your internal walls as his length finds its way inside you. (if virgin) [Your hymen has been torn, robbing you from your virginity].
 
Anzu gently slides in and out the first few inches, making himself sure that he’s not being too rough with you. The smell of his feathers and the wet feeling of his pre staining the insides of your pussy, combined with the delicious sensation of his penis on you excites your body in a way that you don’t knew possible before. Before you can realize it, both of you are moaning, as the desire starts getting a hold on your bodies. Anzu puts a hand on your [chest], caressing your nipples as he pumps his meat inside your cunt with a steady rhythm. You lose yourself in the blissful sensation as he pounds you with an increasing pace. Then, he suddenly stops. You glance up at him with a puzzled look, and he answers.
 
“Hey, you said before that you’d like to see me go wild. And I’m in the mood for that!” he says with a huge grin, giving your neck a loving lick.
 
Oh well, it's not like you haven’t asked for it. Supporting your arms on his neck, you brace yourself, and just in time, as he rams almost half of his pulsating rod into your pussy. “E-easy,  big boy” it's all that you manage to say before he shoves his manhood inside you again. Your entire body trembles at the strength of his poundings. Soon you are panting heavily, doing your best for take the vigorous ravaging that Anzu is giving you. After a particularly strong thrust, he manages to shove most of his cock on your [vagina]. You almost can feel his tapered glans tickling you cervix. Unable to endure more, you collapse on the bed, letting him take totally the reins (if cocks>0) Your [cock], left unattended for a while, arises hard and ready after the intense stimulation that your body is receiving, Anzu takes it with one of his hands and starts jerking it playfully. Moaning like a whore, you beg him to take you, to rut with your body like a wild beast, and seems like your words trigger something inside Anzu, because as soon as he hear that, the force of his thrust becomes even bigger, his avian manhood sliding in and out of your pussy his entire man meat while your legs quiver under the vigorous pounding. The heat that emanate from his body says you that he’ll reach his climax soon, and the same could be said about you.
 
With a scream of pleasure, you hit orgasm, painting Anzu’s manhood with your girlcum (if cocks>0) as your cock releases your load over his belly, staining his hand in the process. Shortly after you, he climax too, his cumslit releasing flooding waves of spung inside your pussy. You hand caresses your belly as it swells thanks to the generous load that Anzu’s balls are pumping into you, until his load finally ceases and you're left with a belly proper of a nine-months pregnant mother. The wonderful feeling of his fresh cum filling you makes your body feel like it was on paradise, and the sheets under you, and the sweet scent of the air only make the atmosphere better. While you’re daydreaming about this, you feel a wet sensation. By now, you easily recognize it. Anzu is playfully licking your neck and giving it soft nips. Climbing to his side, you give his cheek a peck.
 
“So, that’s when you get wild” you say. “I think that I like it.”
 
“If that so, what about trying it again sometime?” the avian asks with a smile.
 
Sure, you answer, but for now, you’ll need some rest.
 
“Right. I’m tired too, and since we’re on bed already, how about if you snuggle with me until you’re rested?” Anzu suggests.
 
That sound like a great idea. removing his cum dripping penis from your [vagina], you climb on his chest, resting on it like if he were a huge mattress. Anzu laughs at that sight and proceeds to surround you with his arms, as his winds cover your sides. Completely surrounded by his body, you drift to sleep with his semen still dripping from your abused pussy.

			*/
		}
		
		private function getBlown():void {
			/*
			(first time)
 
Deciding to take the initiative, you tell him that you have an uncomfortable pressure (if player has balls) in your balls (else) on your loins, and if he was kind enough to help you with….
 
On a second thought, you look again at Anzu’s predatory beak, and imagine several circumstances who would be able to kill the mood or worst, result on a painful nightmare. The avian notices how quickly you interrupted you teasing, and proceeds to ask you.
 
“Something happened? Knowing you, I was sure of you were asking me to give you a…”
 
Well, this is now a little uncomfortable. You don’t want to make Anzu feel bad, but in the other hand you neither want to have an otherwise pleasant experience turned into a painful one and…
 
“Hey? [name]? Are you still on this world? Why you stopped your suggestion? Suddenly you realized who you don’t want a blowjob or…Oh, I know what is the problem.” He says, pointing his beak.
 
Not knowing what else to say, you simply nod.
 
“Yeah, I supposed it. Most of people runs scared at the thought of me servicing them orally, so I’m not offended. With me having a beak instead of lips, is easy to make misconceptions. But, despite the fact I’m a kind of predatory bird, my beak isn’t sharp enough to tear skin, and, even if you’re not comfortable with that, I have this.”
 
Anzu lets out his tongue, surprisingly large. Not as long as the one of a demon, a dragon or a lizan (if player has one of those tongues) or your own, but with the length and slickness right to give a pleasant trip to any cock lucky enough to be lavished on its attentions. Suddenly, the idea of getting a blowjob from him is appealing once more. But for being sure, you make him promise to be careful with the sharpest edges of his beak.
 
“Okay, okay, [name], don’t worry. The last thing in the world who I want now is hurt you. You should know that by now.”
 
Saying him that you feel adventurous enough to endure a beakjob from your avian friend, you accept his offer.
 
(next time, repeat)
 
“So, my friend, what you have in store for me today?” Anzu asks you on the bed.
 
Now that he asked, you tell him that you have an uncomfortable pressure (if player has balls) on your balls (else) on your loins and this time you’re on the mood for having some oral attention again, if he is okay with that.
 
“You already lost the fear to mi beak, or my last tongue work was good enough to leave you wanting another blowjob?”
 
A mix of the two. The last beakjob wasn’t painful in any way, and you feel adventurous enough to repeat the experience today. Of course, if he keep his promise to make sure of your skin will be intact at the time who you finish. Pleased by your answer, Anzu lets out his long tongue and licks your cheek with it, and, after fondling your crotch teasingly, says.
 
“Then, get ready, my friend.”
 
//Scene continues
 
While you rest your back on the comfortable mattress, Anzu approaches you and, putting one hand on your crotch, carefully removes the lower part of your [armor], tossing it on the floor next to the bed and leaving your underwear exposed. Soon, his hands take it away too, leaving your [cock] (if tentacle) wriggling (else) flopping free on the air.
 
Judging for the hungry look of the avian is giving you, the real action will start soon, and your thought proven true, as you feel a wet sensation over the tip of your [cock], quickly seeing that it's Anzu’s tongue undulating across the tip of your penis. The slicked appendage teases your cumslit, and after a while, switches to the sides of your [cock]. The avian’s tongue licks them in a way who has nothing to envy to the best blowjobs given to you in this realm, and proof of it is who in less of a minute, your cock is hard and throbbing.
 
Anzu is getting hot too, and while he doesn’t stop his tongue work over your [cock], one of his hands slips down to his crotch and start pumping his huge penis. You haven’t much time to notice this, but just after he starts doing that, his other hand starts (if player has balls) fondling your [balls] (else) teasing your nipples.
 
With the additional stimulation, your arousal increases even more, to the point of pre starts leaking of your tip. Anzu licks it happily taking it away with his nimble tongue before you can even notice it. The avian’s own erection is so hard who is leaking pre too, but in much more quantities than yours.
 
A naughty idea hits the avian’s mind in that moment, and when you see him slicking his fingers with the copious amount of his own pre, you don’t need much imagination for guessing what he has planned for you. Soon, the delicious feeling of (if anus stretching<2) his finger gently prodding your [asshole] (else if anus stretching>2) his fingers teasing the insides of your [asshole].
 
Your misconceptions about getting a blowjob from him quickly prove themselves wrong at the wonderful feeling of his tongue worshipping every inch of your [cock], leaving it thoroughly slicked and covered on his saliva. At the same time his digits keep teasing your ass, and finally, finding their way to your prostate, prodding it gently.
 
Soon, the (if player has balls) pressure on your [balls] become unbearable (if cum output>1000) You almost can hear them groaning for the painful effort to keep the cum inside them (else) lust in you grows enough to the point who you can't resist longer. With your cock lavished by the avian’s tongue and your prostate teased by his fingers, you finally hit orgasm, letting out your (if cumoutput>1000) copious load with enough force to stain most of his face on a single wave. Anzu quickly wraps his tongue around your cumslit, (in cum output>1000) managing to catch most of your cum in his beak (else) catching all of it on his tongue. With a pleased smile smile on his beak, he proceeds to lick the remaining cum from his face.
 
With a relieved sigh, you let yourself fall on the bed. Anzu is yet busy, licking your cock clean from any drop of cum who you could've left. That done, your he joins your on the bed. (if cum output>1000) Now who you can look him closer, you notice how your impressive load managed to make his belly swell a little, despite his impressive frame. While he hugs you tight, you poke playfully his cum-filled belly, earning a blush from the avian. (else) Taking you on his arm, you snuggle on the bed for a while.
 
Eventually both of you fall asleep for a while. By the time who you’re awake, you find your clothes carefully folded next to your side to the bed, and a still naked Anzu flexing his arms and legs in front of you.
 
“So, you’re finally awake, huh? And, how was my little tongue work?” He asks with a smirk “Not as bad as you’ve though, right?”
 
Well, that was an interesting, and quite pleasant experience. You don’t mind repeating it sometimes. Thanking him again for his, surprisingly, amazing beakjob, you wave goodbye to him, and after getting dressed, return to the peacefulness of your camp.

			*/
		}
		
		private function suckOffDeitysCock():void {
			/*
			(first time)
 
Now that you’ve played a bit on the bed, it time to get into business. The perfumed scent of the avian has been driving you crazy for a while, and now that you have a full sight of his athletic form, you attention goes down to his crotch. The thought of the hefty package inside his pants makes your mouth water. You then say Anzu that if he is stressed you’ll be more than happy to help him relieve pressure.
 
“¿Relieve pressure?”...He asks doubtfully.
 
Putting your hand on the bulge between his legs, you make yourself very clear about what kind of pressure are you talking about.
 
“Oh, you mean that... “ the avian says with a shy smile ”Well, I use to give myself relief from time to time, but has passed a time, and lately I feel a little…”
 
By the flushed look on his face when he’s saying this and the tone of his voice, sound like the big bird don’t mind having his nuts emptied. Despite that, Anzu seems a bit shy about that. Seeing how he’ll need a little more motivation, you slip a hand through his underwear.
 
“So, you feel a little pent, up big boy?” you tease him, fondling his balls.
 
“Y-yes…” the avian answers, shuddering in delight at you touch.
 
You keep teasing him, asking him if he’d like having your tongue wrapped around his meat while you suck and suck until he blows his load inside you mouth. That seems to give results, because his cock hardens at that thought. Finally, despite his nervousness, he accepts you offer.  Well, you couldn’t help him with his clothes put on, right? you say him.
 
“I think not…”.
 
You decide to take initiative this time and start undressing him. Luckily for you, he already has tossed away his robe, so you start with his shirt, which you leave on the floor, your hand caress the perfectly defined muscles on Anzu’s chest, going down until you reach to his pants. Taking them off too, you leave them on a heap over his shirt.The almost naked avian blushes red as you stare his magnificent body. With only his underwear getting between you and your prize, your take it off, leaving the forty inches of avian maleness exposed to your lustful desires. (if not naked) You take off your [armor], leaving both of you naked and ready for action.
 
(next time, repeatable)
 
Now that you’ve played a bit on the bed, it time to get into business. The perfumed scent of the avian has been driving you crazy for a while, and now that you have a full sight of his athletic form, you attention goes down to his crotch. The thought of the hefty package inside his pants makes your mouth water. Resting over Anzu’s chest, you ask to your avian friend if he wants to “relieve some pressure” again, reinforcing your offer with a playful grope to his crotch
 
”Well, how could say I no to such an offer?” He says, with a little laugh.
 
Looks like the big parrot has grown fond of your oral attention, you say him with a grin. You slip a hand on his underwear and start fondling him. His tongue rolls out of his mouth in delight at your handjobs, before he answers.
 
“And you are getting attached to the taste of my cum.” he jokes, grabbing his manhood for emphasis. “Luckily for you, I’m here to please”
 
Then what are you doing dressed? You ask him seductively
 
“Well, since you’re so eager to get me, why you not come here and take them off by yourself?” he says playfully
 
You jump to his side of the bed. His fancy robe has been tossed away a while ago, so you start with his shirt, which you leave on the floor, your hand caress the perfectly defined muscles on Anzu’s chest, going down until you reach to his pants. Taking them off too, you leave them on a heap over his shirt.The almost naked avian blushes red as you stare his magnificent body. With only his underwear getting between you and your prize, your take it off, leaving the forty inches of avian maleness exposed to your lustful desires. (if not naked) You take off your [armor], leaving both of you naked and ready for action.
 
//Scene continues
 
Anzu reclines on his bed, in all his naked glory. ou take a moment to contemplate his impressive frame, the rainbow patterned colours of his plumage, that, added to the golden tones of his hair, give him a handsome and regal appearance. You delight your view on the tones and strong muscles of his chest, partially hidden beneath a layer of fluffy feathers. On his crotch, his half hard manhood and the pair of avian nuts that hang beneath capt your attention. Putting one finger on his belly, and circling his bellybutton with it, you ask Anzu if he’s ready to be worshipped like a god deserves.
 
(first time) “S-sure” he answers, flushed at your kinky proposal. (next time, repeat) “Well, show me what you have on mind then” the avian answers.
 
You playfully pass fingers over his belly a moment, caressing it softly. The smell of Anzu feathers, a smell of violets and snow hits your nose when you approach more to his body. The perfumed scent is so wonderful that you bury your face on the feathers of his lower belly. Then, a musky scent attracts you, spurring you to go lower, until you realize that your [face] is just over the avian’s crotch. You start your task licking them, sucking around the heavy orbs, while the feathers that cover them tickle your tongue. The musky scent of them, combined with the soft perfume of his body overwhelms your senses, and before you can notice it, your (if cocks>0) [cock] is quickly hardening (else) your [pussy] moistens and your body is getting infused by lust.
 
“So...this is how you worship a god.” Anzu laughs, somewhat flustered “It’s a weird way to do it, but I have to admit that I like it.”
 
Smiling at his approval, you ignore your own lust and return to your main task. You keep worshipping his king sized balls, warm to your touch, while you can hear the cum inside them churning. Continuing your task, you slowly make your way to your prize: his cock. When you finally reach it, you start licking its sides. Almost forty inches of pure avian meat, and it’s all for you. Taking its tapered glans on your hands, you give it a lick, eliciting a moan from the avian. One of his hands goes down your head, lovingly caressing your hair (if bald) [skin]. You get a whiff of the musky and delicious scent of the thick tool before continuing.
 
This time your tongue goes to his tip. Beads of pre leak from his cumslit and your tongue eagerly delights on then, enjoying as the salty flavour inundates your tastebuds. Soon, the desire is too much, and your start sinking the meaty rod on your eager mouth. Having a long way to the end, you decide to start safely, and, bobbing down on it with pleasure, you engulf in your mouth on the first inches of his length, as your hand wraps around the base of Anzu’s manhood.
 
Pulling out his cock, you look up to Anzu with a mischievous smile and, in the mood for a bit more of foreplay, you start sliding his cock in and out, while your tongue dances across its surface, as his pre drips from the corners of your mouth.
 
(if player height>50 and not naga) One of your hands start caressing his balls and finds its way to his anus, where you prod a finger inside a massage his prostate from the insides (else if naga) Taking some of the pre that leaks from his erection mixed with your saliva, you smear it on your tail tip and after making sure that it is well lubed, you slip it on his asshole, wriggling its way to his prostate. (else, if player height<50) You try to reach his anus, but due his impressive frame, looks like you won’t reach much far. Instead, you cup his huge nuts and squeeze them gently. Taken for the desire, Anzu lets out a moan of delight, putting his hands on your head and pushing his cock deeper inside your mouth. You gasp as several inches of the monster are forced on your mouth at once. Seeing your discomfort, he releases your head and lets you take control.
 
After taking some air, you return to main task. The pointed tip of the avian manhood makes your task easier, but, nevertheless, is a huge way to the end.

“Be sure you’re not biting off more of what you can chew” Anzu jokes lovingly, caressing your scruff.

Pre slides down your throat as you bury more and more of his meat in your mouth, until the pointed tip of his cock reaches the back of your throat. Seeing how you can’t fit more of his titanic cock into your mouth, you focus on enjoying the filling sensation. Your (if cocks>0) cock is rock hard, while the rest of your (else if vagina>0) vagina is drooling girlcum, while the rest of your (else) entire body is shuddering in heat, excited by the delicious taste of Anzu’s pre.
 
Taking out his cock a little, you let its tip rest on the back of your tongue and guzzle the dribbling pre leaking on your mouth,  anxious for taste your creamy reward soon. You mouth drools all over his penis, and you lose yourself on the desire for a second, until the salty taste of his meat returns your mind to the job again.
 
(if player height>50 and not naga) Your hand slips out off his anus and starts pumping the base of his cock, (if player height>50 and naga) Taking your tip tail out of his anus, you use it to pump the base of his cock, (else if player height<50) You take your hands off of his balls and use them to pump the base of his cock, while you continue servicing his meat, bobbing down and forth across every inch of his avian penis.(if snake, demon or dragon tongue) Your nimble tongue easily wraps around his throbbing meat and skillfully inserting the forked tip on his cumslit, you manage to take the last drops of pre. Between your  sucking and the teasing that the avian is enduring, he must be on the brink of orgasm. Confirming your suspicions, Anzu, blushing red, manages to say between moans:

“[name], (boy/girl) here it comes”

With that his cumslit releases his load on your mouth. The first flood of semen inundates your mouth, with a strangely creamy and sweet taste that makes you want more. Wave after wave fill your throat, but determined to don’t let it waste, you keep drinking. You don’t care when the size of his load start to distend your stomach, the only thing that you want on this moment is more and more of his delicious seed.
 
(if not genderless) While his load fills you, the excitement of having his hot seed on your mouth drags you to climax (if cocks>0) spilling your load on the sheets (else if vagina>0) creaming your pussy on delight.
 
After the seventh wave, the flow of semen distends your belly to the point that you look several months pregnant. You caress your now gravid stomach unthinkingly, as the last tides of cum finish to flood your gullet. When his orgasm subsides, Anzu lets his cock slide out of your mouth bathing your face and chest and staining heavily your [skin] with the leaking cum. Spent, the avian mutters:
 
“Thanks, [name]. I really needed that. But seems like I overfilled you this time. Do you want to rest with me?”
 
You agree, jumping to his side with difficulty due the weight of his cum in your belly. Seeing your predicament, he help you to stand up, and then embraces your body with both arms, surrounding it with his feathered wings. Soon, you are sleeping peacefully with his cum swirling in your belly and a satisfied look on both of your faces.
 
After a relaxing nap, and a thoroughly fulfilling meal, you bid farewell to your avian friend and return to your camp.

			*/
		}
		
		private function fuckGodlyBirdButt():void {
			/*
			In the mood for some bird butt, you tell Anzu that you’d like a turn on his ass.
 
(first time)
 
“Well, you see, being, that I am…I never, well, had anything, or anyone, you know…back there…and…”

Oh, It’s that. Well there is a first time for everything. And you’ll make it a pleasant experience for both of you.
 
“If you say that...[name]. I think that I’ll trust in you.”
 
You take off his robes and let them fall to the floor. He strips from his vest and pants, dropping them in the armchair(if not naked), while you remove your [armor]. This done, you remove his underwear, leaving his avian cock bounce free in the air.
 
Then, you instruct him to lean on the bed, while you open his legs and caress the softness of his feathered buttcheeks. You prod one of your fingers inside his tight anus and find your way to his prostate while other caress his balls. The big bird blushes red under your ministrations.
 
“[name],...what are you doing?”

Only assuring than his first time will be pleasant.
 
(next time, repeating scene)

“Okay [name]. I’m starting to like it” Anzu answers, blushing a bit

Sure? He is a little too eager to only ‘start’ to liking it.

“Right, right. I really like it.” he admits. “But it’s your fault after all!”
 
While you remove your [armor]. He eagerly strips himself, dropping his robes and other clothes in a nearby armchair, and leaving his avian cock bounce free in the air.
 
He leans on the soft mattress of his bed, while you open his legs and caress the softness of his feathered buttcheeks. You prod one of your fingers inside his tight anus and find your way to his prostate while other caress his balls. The big bird blushes red under your ministrations.
//Scene continues.
 
You tell him to relax, while you take care of him. Soon, your efforts start to give result,  when his huge cock arises. After a little more stimulation, pre starts to leak copiously from his avian maleness. Taking some in your hands, you start smearing it on his asshole (if player isn’t a centaur) , and then in your [cock].
 
You decide to tease him for a bit, hotdogging your cock between his buttcheeks, moistening his butt feathers with your pre.
 
Then your cock meet the entrance of his rosebud, then, you start to penetrating him, slowly at the start, inch by inch, and then you increase your pace, until half of you cock is buried inside. A moan of delight escapes from Anzu’s mouth while you thrust inside him. If the hardness of his cock proof anything, he must be really enjoying this.
 
Seeing how you’ve had enough foreplay, you shove the rest of your cock at once. With the amount of pre covering, it slip inside easily. Anzu gasps at the sudden intrusion, but quickly relaxes at the feeling of you cock sliding inside and outside his anus.
 
You increase the rhythm of your thrusts until you’re close to climax. Your avian companion, close too, tries to jerk off, but he is too overstimulated to do that. After a few attempts, he lets you take enterally the charge of the situation, letting his tongue roll outside his beak, while enjoying the feeling of your cock in his anus.
 
(if cum output<1000)

Finally, you release your load inside him, filling his insides with your cum. Seeing how he hasn’t got his release yet, you grab his cock and start jerking him..

(else, if cumOutput>1000)

You stuff the bird so full of cum, that of Anzu’s belly, despite his size, manage to gain a considerable bulge. (if player has knot) Some of your cum tries to escape, but your knot prevents any drop to waste, inflating even more the poor avian’s belly. (else) Even some of your cum overflows his hole, painting his butt feathers white. Seeing how he hasn’t got his release yet, you grab his cock and start jerking him
 
A few seconds later, Anzu cums too. Most of his cum lands on his face and belly, leaving him a sticky mess, but some of it manage to hit you in the face. While he licks clean his face with his long tongue, you (if player has a dragon, snake or demon tongue) lick his cum from your face (else) use the feathers of his tail to whip his cum from your face.
 
You remove your cock, letting a little of your flow from his asshole. Then, you recline over him, licking his cum off his chest. The feeling of his feathers tickles your tongue. Anzu then hugs you with both arms, and says, blushing:
 
“[name], that was...great. I haven’t had so much fun in a while” he admits.
 
You tell him that you had a great time too.
 
Tired, you fall asleep over him, using his body as a huge pillow. He covers you with his wings, while both of you take a nap.
			*/
		}
		
		private function feedAnzu():void {
			/*
			While resting with him on the bed, you feel a familiar weight on your breasts. Sensing the milky gift barely contained by your [chest], why not share a little of it with your avian (if relatlvl=3) friend? (else if relatlvl=4) lover?

Your ask Anzu if he suddenly felt thirsty. He don’t seem to understand what exactly you’re offering him, as he asks:

“Thirsty, hmm?... Not so much, but if you want something I can go to the kitchen and…”

Making the things more clear, you explain that you’re offering to sate his thirst with your milk, cupping your filled breasts while you do so. (if player cocks>1) his eyes darts to your crotch, focusing on your [cock] but, you dispel his misguided idea, jiggling your tits again to entice him. 
(else) The avian seems unsure at the idea.

“Well, this is a bit, how to say it, weird. You know, I left to be a little kid some thousands years ago, and the idea that someone catching me doing this is, embarrassing”

(if no quests are completed)

And how much people he can see hanging around the palace now? Besides, it’s nothing to be ashamed. You only want to share a very intimate moment with him, if he is okay with that.

“Well, if you put it in that way, I suppose that I haven’t any reason to say no?”

(if quest 1 is done)

Maybe you have in home some guests by now, but who are them to judge him, anyways? Besides, for the way that he regards them, he doesn’t seems like the kind if guy that gets worried about everyone’s opinion about him.

“Heh, it’s hard to don’t notice it, right?”  he answers, with a soft laugh “Alright, you win. I’ll give it a try.”

Putting one of his hand of your breasts shyly, he starts cupping them, caressing the soft orbs with his huge but surprisingly nimble fingers. Taking a little more confidence, he teases one of your nipples with the point of one of his short claws, prompting a jet of milk squirt off, with enough force and aim to hit him on the face.

The surprised avian blushes as he see your milk dripping from his face. Somewhat nervous, he takes some of it and licks it with his tongue.

(next time, repeat)

While resting with him on the bed, you feel a familiar weight on your breasts. Sensing the milky gift barely contained by your [chest], why not share a little of it with your avian (if relatlvl=3) friend? (else if relatlvl=4) lover?
Your ask Anzu if he suddenly felt thirsty. This time he agrees without too much hesitation. (if cocks>0) Darting his sight to your crotch, he tries to slip a hand inside the lower part of your [armor]. Taking his misguided hand and putting in on your breasts, you make clear what you want to do.

“Oh, you mean that milk…well, it may not be as tasty as the other” he answers, his eyes remaining on the bulge of your clothes.  “But, well, I’m up to it.”

(else) You take his hand and put it on your breasts, letting him fondle them. He caresses the soft orbs with his huge but surprisingly nimble fingers. Having lost his initial doubts, he soon is teasing your nipples, making some of your milk drips from them.

//Scene continues

He keeps caressing the soft [skin] of your breasts, prompting more drops of milk dribble from your nipples.

You suddenly feel how he removes his hands from your breasts, but, before you can protest, he grabs your chest again, and now with his tongue, he teases your nipples, licking them clean from the milk that started leaking.

Opening wide his beak, he fondles your breasts, forcing more milk out. You leave the milky goodness fall on his tongue. He drinks it all with a pleased gesture, that makes you think that, despite his initial protests, he really likes it. Soon, his tongue focuses again on your nipples licking the rich milk as it comes out.

You motion him for he lays on his back while you feed him. Somewhat confused, he does so. Luckily for you, he is much less heavy than you expected and most of his weight is carried by the bed under you.

It’s kind of cute, though. Anzu laying on your chest, happily drinking your milk like a little child, only that this little child is (if player height>96) way larger (else) many times larger than you. His tongue coils gently around your nipples, making them ooze streaks of white that are quickly cleaned by the eager avian.

“So, the little baby is liking his meal?” you tease him.

“Hey, I’m not a baby!” He protests, only to be hit by a streak of white on the face, that is quickly cleaned by his nimble tongue.

“Okay, big boy, but you are clearly enjoying yourself.” You answer him, after realizing the noticeable erection between his legs.

“Heh, sorry, it's only that…” he says, his cheeks blushing red. “Well, being so close of you, makes me feel a little flustered.”

Well, seems like he is really enjoying it, after all. After the pleasant treatment that you breasts are receiving, the soon let out the real flow, that is quickly swallowed by the big bird. You let him rest his head on your breast while he sucks your milk.

(if milk output is <500) After a while, your breast found themselves depleted again until Anzu’s playful ministrations. Giving the avian a look, you can see him licking the white spots of milk that dribbled to the sides of his beak. When he realizes that you are looking at him, he blushes and says.

(else if milk output Is > 500) Your prodigious bounty keep producing milk for a long time, making the task of drinking it all increasingly difficult for your avian friend. When the flow of milk finally ends, his belly has swelled a bit despite the size of his owner. You give it a playful poke, earning a blush from the overfilled avian.

(first time)

“Huh, that was…nice.”

You say that you’re glad that he liked his drink, and despite his embarrassment, he managed to even enjoy it. Anzu answers with a soft laugh, and giving your breast a look, he asks you.

“So, i'd likei’dyou’d like to repeat it again, when your breasts feel to full again…Well  if you don’t’ mind”

Of course, but for now, they’re quite empty. You’ll return to the camp for rest and return to him when you’re in the mood to give him milk again. After saying your goodbyes to the avian, you find your way through the Rift and return safely to your camp.

(next time, repeat)

“Tasty, as always, [name]. Thanks again, for letting me have a drink.” Anzu says, hugging your upper body in the soft embrace of his warm feathers.
 
You stay this for a while, with the heat of the avian breath on you neck, and his feathers tickling your [skin]. After some more cuddling, you stand up and redress yourself, not without giving Anzu a last view of your bare chest. The avian then asks:

“You’ll return here again when your breasts feel too full, right?” He asks, looking at you with his cheeks somewhat red in mild embarrassment ”I’ve grown a taste for your milk…”

Sure, you answer him, but for now, you have to let them rest for a bit. After saying your goodbyes to the avian, you find your way through the Rift and return safely to your camp.
			*/
		}
		
		
		//Racing
		private function racingWithAnzu():void {
			clearOutput();
			outputText("Coming Soon...");
			doNext(anzuMenus);
		}
		
		//Dinner
		private function dinnerWithAnzu():void {
			clearOutput();
			if (model.time.hours < 8) {
				if (flags[kFLAGS.ANZU_TIMES_DINED_BREAKFAST] == 0) {
					outputText("Arriving early to his palace, you search for Anzu until you find him in the kitchen, naked except for an apron. He is cooking some eggs in a frying pan, while watching how some pieces of bacon are cooking in another. The avian is so busy with his labour that he doesn’t notice your arrival.");
					outputText("\n\nYou cough a bit for announcing your presence.");
					outputText("\n\n“[name]! I wasn’t expecting you came here so early.” He says, a little embarrassed by the fact you found him almost naked. “I woke up only a few minutes ago and, since I was hungry, came here to make me something to eat.”");
					outputText("\n\nThat’s explain him being naked. But, from where he got the eggs and the meat?");
					outputText("\n\n“I bought some of my supplies from the reindeer people, and others, while foraging the rift. I manage to find berries, eggs, and some creatures who provide me the meat who I’m cooking now, and I buy bread, flour, milk, nuts, butter, cheese, beer and wine from the reindeers. A wanderer merchant travels around the borders of the Rift, and sells me sugar, salt, pepper and spices. Sometimes I get fish on the frozen lakes between the hills.”");
					outputText("\n\nDistracted from the food, he lets the eggs burn while he is explaining this. When you try to prevent him, it’s too late.");
					outputText("\n\n“Damn! No matter, I have more, I’ll cook them later.” He says. “Anyways, I usually eat alone. Maybe, If you want,… you can make me company while I cook, and later, have breakfast with me.” Anzu offers.");
				}
				else {
					outputText("You find Anzu in the kitchen again. The avian is as naked as before, with only his apron put on.  He is cooking some eggs in one pan, and putting some pieces of sliced bread in a plate next to the stove. This time, he notices you as soon as you approach to the door.");
					outputText("\n\n“Hi, [name]. You caught me making the breakfast. I always wake up hungry in the mornings.”");
					outputText("\n\nJudging for all the eggs, bacon and bread that he has taken from make his breakfast, he definitely is saying the truth. Then, he looks at you and says:");
					outputText("\n\n“You see, not all of this is really for me. After your last visit, I was hoping to see you again... and I prepared an extra portion and…”");
					outputText("\n\nAnd?");
					outputText("\n\n“Well… do you want to have breakfast with me again?”");
				}
				doYesNo(eatFoodWithAnzu, dontEatFoodWithAnzu);
			}
			else if (model.time.hours < 16) {
				if (flags[kFLAGS.ANZU_TIMES_DINED_LUNCH] == 0) {
					outputText("When you arrive to the palace a smell of meat cooking attracts your attention. The smell leads you to the kitchen, and when your enter, you find Anzu taking some roasted steaks from a grill. Looks like this time he has left behind his robes and now he’s wearing a white apron over his set of shirt and pants. When putting the steaks on a plate, he manages to look you and says.");
					outputText("\n\n“[name]. You’re here! Looks like you’ve arrived just in time. As you see, I’m cooking the meal.” He says, pointing the tables around him.");
					outputText("\n\nOn the tables near the stove are many slices of what once were a huge cheese, some pieces of bread, with some bunches of grapes on the left. Isn’t too much for a midday lunch?");
					outputText("\n\n“You see, I usually eat much more food at noon than in the dinner. Since I’ve almost finished with the main dish, you could help me, and then we could eat together. If you want, of course.”");
				}
				else {
					
				}
				doYesNo(eatFoodWithAnzu, dontEatFoodWithAnzu);
			}
			else {
				if (flags[kFLAGS.ANZU_TIMES_DINED_DINNER] == 0) {
					outputText("");
				}
				else {
					
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
			//Scene GO!
			if (model.time.hours < 8) {
				outputText("You answer giving him a quick peck on his cheek and saying who you’d love to have breakfast with him.");
				outputText("\n\n“Excellent.” He says “If you want, you could help me to make the food ready”");
				outputText("\n\nAccepting his offer, you start helping him to do the breakfast. Taking some butter from the cabinets, you take with you the slices of breads in the plate and smear them with the butter, and put them in the stove until the butter on it melts. After that, you put them on a big plate.");
				outputText("\n\nMeanwhile, Anzu is busy with the eggs. He added a couple more for you after seeing your arrival. After serving the eggs in two plates, he start frying bacon in another pan. What would be a couple of eggs without bacon?");
				outputText("\n\nWhen the bacon is ready, he put it next to the eggs and spreads salt and pepper on them. After serving the plates with eggs and bacon, he points you some bottles with milk and the cabinet when the glasses are stored.");
				outputText("\n\nYou fill a jar with milk and put it on a nearby table, where two glasses and the plate with bread is waiting. Anzu leaves the plate with the bread on the dining room, and returns for the jar with milk and the glasses, while you carry the plates with eggs and bacon.");
				outputText("\n\nWhile eating, you manage to look how he hasn’t bothered to get dressed to the breakfast, and now without his apron, exhibits his naked body to you without shame. The breakfast is quite delicious. Anzu certainly had a lot of practice cooking for himself all that years, you think while savouring the perfectly spiced eggs and the bacon.");
				player.refillHunger(hungerRefillAmount);
				outputText("\n\nAfter eating, both of you chat for a while. Anzu tells your more stories of his former world, while he listen some of your adventures in Mareth and about your home back on Ingnam.");
				if (flags[kFLAGS.ANZU_RELATIONSHIP_LEVEL] >= 4) {
					if (flags[kFLAGS.ANZU_TIMES_HIGH_REL_BREAKFAST] == 0) outputText("\n\n<b>A </b>");
				}
				flags[kFLAGS.ANZU_TIMES_DINED_BREAKFAST]++;
			}
			else if (model.time.hours < 16) {
				outputText("");
				outputText("\n\n");
				outputText("\n\n");
				outputText("\n\n");
				outputText("\n\n");
				outputText("\n\n");
				flags[kFLAGS.ANZU_TIMES_DINED_LUNCH]++;
			}
			else {
				outputText("");
				outputText("\n\n");
				outputText("\n\n");
				outputText("\n\n");
				outputText("\n\n");
				outputText("\n\n");
				flags[kFLAGS.ANZU_TIMES_DINED_DINNER]++;
			}
			kGAMECLASS.dungeonLoc = DungeonCore.DUNGEON_ANZU_DINING_ROOM;
			doNext(camp.returnToCampUseOneHour);
		}
		private function dontEatFoodWithAnzu():void {
			clearOutput();
			//Scene GO!
			if (model.time.hours < 8) {
				outputText("You thank him for his offer, but state how you already had your breakfast.");
				outputText("\n\n“Oh, it’s okay” he says, a little disappointed. “Well, if you change your mind, you know where find me on the mornings.”");
				outputText("\n\nLeaving the cooking avian to his own matters, you return to your camp.");
			}
			else if (model.time.hours < 16) {
				outputText("Excusing yourself, you tell him that you don’t have much time now. Maybe in another opportunity.");
				outputText("\n\n“No matter, friend. If you change your mind and want to eat with me, come here tomorrow, or another day.” He says, pointing the empty dining room. “I have more than enough room for us”");
				outputText("\n\nYou’ll see. After waving bye to Anzu, you come back to your camp.");

			}
			else {
				outputText("");
				outputText("\n\n");

			}
			clearOutput();
		}
		
		private function diningSexGoodness():void {
			if (model.time.hours < 8) {
				if (flags[kFLAGS.ANZU_TIMES_HIGH_REL_BREAKFAST] == 0) {
					outputText("\n\nAfter some talking your throat becomes somewhat dry, and both of you indulge on the milk from the glasses. You wonder, from where he got the milk.");
					outputText("\n\n“I bought it from the reindeers. They say it was reindeer milk, from their breasts. I wasn’t sure about it, and only bought it after I’d assured myself if it was drinkable.”");
					outputText("\n\nHmm. If not as tasty as the cow-milk you’ve drunk before, the reindeer milk is indeed tasty. When drinking the last drops of it from the glass, a particularly kinky idea crosses your mind. Maybe the smell of Anzu arouses you, or the breakfast awake another kind of hunger, of simply you woke up particularly horny this morning, but you don’t want to end this meal without a taste of Anzu’s own ‘milk’.");
					outputText("\n\nPlayfully, you approach him, and putting your arms around him, ask Anzu if he had more milk to spare. Looking how his eyes dart to the jar with milk, seems like he doesn’t understand you very well. You make yourself more clear putting one hand on his crotch, and taking advantage of his naked situation, start caressing his feathered balls.");
					outputText("\n\n“[name], what are you doi…” Anzu manages to say, blushing red at the sudden touch.");
					outputText("\n\nWhile your fingers run across his cock, you explain who you had enough of reindeer milk, and now you’re craving a taste of that he has to offer. The flustered avian finally gets your idea.");
					outputText("\n\n“Oh, you are talking about that ‘milk’. Actually,I don’t know if…”");
					outputText("\n\nCome on. He said before that he want to share his food with you, and the only thing you want is to give this breakfast a good ending, thanking him for the food at the same time.");
					outputText("\n\n“Well, if that makes me...you…both of us happy, there isn’t reason for not doing it.”");
				}
				else {
					outputText("\n\nAfter enjoying the reindeer milk, you hug Anzu, and with a hand on his crotch, say who you want to taste another sample of his special ‘milk’.");
					outputText("\n\n“So, is that how you want to end the breakfast.” He answers, blushing a little “Okay, my friend, go on.”");
					outputText("\n\nReclining on the soft carpet on the dining room, you bury your nose in his crotch, smelling the sweet scent of violets who emanates from him. After enjoying the soft smell for a little, you pass your " + player.tongueDescript() + " across his feathered balls, licking each corner of the fuzzy orbs. Moving to his cock, you start licking the underside of the huge rod. ");
					outputText("\n\nWhen you reach his pointed tip, you taste the little bit of pre who is already leaking, and then, put the first few inches of his hot shaft in your mouth. One of your hands keep caressing his balls while the other start pumping the base of his meat.");
					outputText("\n\nQuickly the thick sausage rises to full erection, and you  engulf more and more inches of it. Sliding in and out of the huge rod, you start tasting his pre dribbling all over your mouth. The hand pumping his meat goes down your  (if cocks>0) [cock], and starts jerking off feverishly (else if vagina>0) slides a pair of digits inside your [vagina], ands starts masturbating (else if genderless) slides two fingers inside your [asshole] stimulating your prostate, while you keep sucking off his rich meat.");
					outputText("\n\nSoon, it becomes clear how Anzu is close to cumming, and your suspicions are confirmed when he takes his both hands and starts thrusting his avian shaft inside your mouth even more. The sudden entrance of even more inches of cock in your mouth makes you stop masturbating and seek support on his legs. Finally, he hits orgasm and says:");
					outputText("\n\n“Fuck, [name], here I go.”");
					outputText("\n\nWith that, he releases the first jet of whiteness on your wanting mouth. You gulp it down with delight, in time to catch the next round. Wave after wave of creamy cum finds its way through your mouth, filling your belly until it start expanding by the excess of fluid. After the eleventh wave, the stream of semen slows down, leaving only a little trickle. Anzu releases your head, dripping the last drops of his cum over your face.");
					outputText("\n\nHe helps you to stand up, and after giving you a big hug, he says..");
					outputText("\n\n“Even if that’s not the way I expected the meal to end, I’m happy to see who you liked it.”");
					outputText("\n\nYou answer him that that was a really tasty and fulfilling breakfast, in all senses. Licking the remaining cum on your face, you say goodbye to Anzu, and after thanking him for the food again, return to your camp.");
				}
				flags[kFLAGS.ANZU_TIMES_HIGH_REL_BREAKFAST]++;
			}
			else if (model.time.hours < 16) {
				
			}
			else {
				
			}
		}
		
		//Bathing
		
		//Sleeping
	}

}