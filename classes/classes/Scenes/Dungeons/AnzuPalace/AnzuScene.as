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
			if (flags[kFLAGS.ANZU_RELATIONSHIP_LEVEL] >= 3) addButton(2, "Sex", anzuSexMenu, null, null, null, "Have some sexy times with the sexy avian deity.");
			else addButtonDisabled(2, "Sex", "Maybe if Anzu likes you better, he will let you do that.");
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
			outputText("\n\n\"<i>Calm down (boy/girl), I’m going for parts. You don’t believe I opened the portal to the first world which appeared, right?");
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
			outputText("\n\n\"<i>(Boy/girl). I’ve never been exactly what you call a moral being. Even on their side, they’ll tend to criticize my methods and the way I spend my free time.</i>\"");
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
			outputText("Coming Soon...");
			menu();
			addButton(14, "Back", anzuMenus);
		}
		
		//Racing
		private function racingWithAnzu():void {
			clearOutput();
			outputText("Coming Soon...");
			doNext(anzuMenus);
		}
		
		//Dinner
		
		//Bathing
		
		//Sleeping
	}

}