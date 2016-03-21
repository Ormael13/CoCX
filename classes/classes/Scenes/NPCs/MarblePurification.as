//MARBLE_BOYS = Number of boys birthed
//MARBLE_PURIFIED = Marble purified
//CLARA_PURIFIED = Is clara purified?
//CLARA_IMPRISONED = Is Clara Imprisoned?
//CLARA_RELEASED = Is Clara released?
//MARBLE_BREAST_SIZE = the size of her titons (0=DD cup, 1=G, 2=HH, 3=J)
//MARBLE_TIME_SINCE_NURSED_IN_HOURS = Really fucking obvious.

/*
flags[kFLAGS.MARBLE_PURIFICATION_STAGE] : 0 = unstarted
flags[kFLAGS.MARBLE_PURIFICATION_STAGE] : 1 = Started, gathering labova
flags[kFLAGS.MARBLE_PURIFICATION_STAGE] : 2 = Potions gathered, need to talk to Rathazul
flags[kFLAGS.MARBLE_PURIFICATION_STAGE] : 3 = Started wiv Ratazul
flags[kFLAGS.MARBLE_PURIFICATION_STAGE] : 4 = Marble is out getting her sister
flags[kFLAGS.MARBLE_PURIFICATION_STAGE] : 5 = QUEST COMPLETE
*/

package classes.Scenes.NPCs {
	import adobe.utils.CustomActions;
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.GlobalFlags.kGAMECLASS;

	public class MarblePurification extends NPCAwareContent{

	public function MarblePurification()
	{
	}


	/*Purifying Marble
	Quest starts a few days after recruiting Marble to camp if they’re not addicted to her.  She will approach the PC and tell them that not nursing her is a real burden for her, and ask them to help her purify herself.  This quest will not start if the PC’s corruption is over 50, or has any corrupt character in camp (corrupt Jojo, corrupt Amily, Vapula).
	She suggests that the TF item of her race, LaBova might be a good place to start, if you can find a means of reversing its effects.  Or, if you’ve already got Rath recruited, she will suggest that he could be able to get what you need.
	You then need to give Marble at least three doses of purified LaBova (enough to get Rath in camp), plus more if you’ve done any corrupting of her before.
	At this point, Marble will admit that while the first (few) doses did affect her, they don’t seem to be doing anything anymore.  She suggests that Rath might have an answer, and the two of you talk to him directly.  If Rath has not been recruited, then she will suggest that you should try and convince the alchemist to come to the camp, and then going to talk to him will happen after he is recruited.
	Rath will ask for a fresh sample of Marble’s milk and will start to study it.  The next day he will admit that he can’t really come up with a solution from just the one sample, he needs milk from another Lacta Bovine, preferably one who is closely related to Marble.
	Marble offers to go back home and bring one of her family members to donate the milk he needs to figure out the formula, but it will take her some time to cross the mountains and get back home.  So the PC has to decide when they want her to go.
	When they do send her away, she will leave for at least 2 days, and then come back with her youngest sister in tow (Marble is the oldest, Ophelia was the middle one and the book lover, Clara is the youngest and the one who is more or less the ideal LB who really likes the idea of getting others addicted to her once she finds out about their addictive milk).
	At this point, Clara will give Rath the fresh sample he needs, and then get everyone to gather around the firepit while she makes some tea for them and tell a funny story.  The tea she serves everyone is drugged, to try and put them to asleep to steal the PC as her own milk addicted slave.  She feels that the PC is fair game since he broke his addiction to Marble.
	I’m not sure how the next sequence will play out right now, but there will be the possibility of the PC getting a bad end if Clara gets her way.  If the PC manages to avoid getting bad ended, Clara will leave and Rath will finish the formula.  Current plan:
	Marble has spent the last day or two talking to her sister and generally having a friendly chat.  Clara isn't too bad up until she hears that the PC isn't addicted anymore, and that Lacta Bovine's milk is addictive.
	Marble is quite trusting of her sister given her time apart, and wants to think that her sister isn't as bad as she was when she was a kid.
	And up until that point, she hasn't seemed to have been that way.
	The player can guess what is coming up, but otherwise it comes down to an int check on the PC as to whether or not they see it coming.  The player will have some hints.
	(low intelligence) The PC is put to sleep and wakes up with their head on Clara’s breast, already starting to feel the effects of the new addiction.  They then are given the choice to either give in, or fight her.  The fight in this case is greatly at the PC’s disadvantage.
	(moderate intelligence) Clara will put everyone else to sleep and then turn to the PC.  She will first tell them to come quietly and drink her milk, and then get really mad if they refuse and attack them.
	(high intelligence) The PC realizes what’s going on and get’s everyone not to drink the tea.  At this point, Clara panics, grabs Marble’s hammar and decks her from behind.  If there are other fighter followers, at this point the PC and them will overwhelm Clara.  If not, then she will attack the PC to try and beat them before Marble has a chance to recover.  What follows is a fight where after a certain amount of turns pass, Marble gets back up and helps take Clara out.  So the fight ends if you can last for a certain number of turns.
	Marble taking the formula will be the last step in her purification.
	At this point Marble is purified.
	There were plans to let you use a pure pearl as well, but that would cause you to skip over too much content related to Marble's personality and race for it to be practical to write two forms of Marble's post-purification content.
	
	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////*/
	
	//Marble wants to be purified
	//This scene takes place 3-4 days after Marble joins the PC in camp
	//The PC must have the Marble Resistant perk, must not have the Marble’s Milk perk to trigger this scene, they must have below 50 corruption, and they cannot have any corrupt followers in camp.  If at any time the PC's corruption goes over 50, or they gain a corrupt follower, the quest is cancelled.  The quest can be continued if they once again drop under 50 corruption and lose all corrupt followers.
	public function BLUHBLUH():void {
		clearOutput();
	 	outputText("When you return to camp, you find Marble seated at the campfire, staring gloomily into the ashes. Curious, you approach your bovine lover and ask her what the matter is. She looks up at you, her ");
		if (flags[kFLAGS.MARBLE_BOVA_LEVEL] <= 1) outputText("human");
		else outputText("bovine");
	 	outputText(" head still in her hands, and sighs loudly. <i>\"I’m sorry, sweetie, I just... I’ve tried to ignore it, but I just don’t feel comfortable here.\"</i>");
	 	outputText("\n\nYou ask her what’s wrong; doesn’t she like being with you?");
		if (amilyScene.amilyFollower() && !amilyScene.amilyCorrupt() || followerKiha() || flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00238] == 1)
		{
		 	outputText("  ...Has she been fighting with ");
			if (amilyScene.amilyFollower() && !amilyScene.amilyCorrupt()) outputText("Amily");
			else if (followerKiha()) outputText("Kiha");
			else outputText("Izma");
		 	outputText("?");
		}

	 	outputText("\n\n\"<i>No, no, it’s nothing like that. I do like being with you... and that’s the problem,</i>\" is the glum cowgirl’s response. At your obvious confusion, she begins to explain. \"<i>You remember that incident with my milk and its addictive side-effects?</i>\" she asks. At your nod, she goes on, <i>\"Well, I’ve tried to be strong since then, for your sake - I love you for being you and I don’t want you to be addicted to me; to depend on me for your daily survival... that’s not love - but it’s so hard. I’ve never felt so good as when you were drinking from me, sweetie; I <b>need</b> to give my milk, and having a living person drink it is so much more... well, satisfying than the milkers are.</i>\" She turns to look at the ground, obviously too ashamed to look at you. \"<i>When we make love, it’s so hard for me to resist taking my breast and forcing the nipple into your mouth, to make you drink the milk I make and truly feel like you love me...</i>\"");
	 	outputText("\n\nYou tell her that you appreciate how strong she’s being, and ask if there’s any way you can help her to get over this problem of hers.");
	 	outputText("\n\nMarble hesitantly looks up at you, brows furrowed in thought. \"<i>Well, it’s the corruption that makes my milk addictive in the first place, so we need to find a way to purify me.  The most corrupted part of me is my milk, so that’s where we should start,</i>\" she suggests, rubbing her chin in thought.");
	 	outputText("\n\nYou contemplate the possibilities, and make some suggestions on things that could reduce her corruption.");
		if (player.hasItem(consumables.PURHONY)) outputText("  You then recall that bottle of honey the bee-girl gave you, and ask if maybe it might work?");
		if (player.findStatusEffect(StatusEffects.PureCampJojo) >= 0) outputText("  You remember how Jojo helped you become pure, and suggest maybe his meditations could assist Marble?");

	 	outputText("\n\nMarble shakes her head before continuing, \"<i>No, I think we should focus on something linked to my race.  Maybe we can use the LaBova stuff that my mother taught me to drink if I was ever turned into something else.  It’s probably corrupted in its raw form, but maybe there is some way it could be purified to counter the corrupt effects? I think you’d need an alchemist to purify it, though...</i>\" she trails off, musing at the possibility.");
	 	outputText("\n\nYou point out that LaBova is very rare, and ask how you’d go about getting enough of it to help Marble.");
	 	outputText("\n\n\"<i>Don’t you worry about that, sweetie.</i>\" is the determined reply. \"<i>LaBova is made from chemically treated lacta bovine milk,</i>\" she jiggles her bountiful bosom for emphasis, \"<i>and I know someone who can make me as much of the stuff I need if I give them the milk and supplies... wait, are you saying you want to help me?</i>\" she asks you meekly.");
	 	outputText("\n\nYou proclaim that’s what you said; after all, what are mates for? With surprising speed for such a bulky girl, Marble explodes out of her seat, sweeping you into your arms and smothering you enthusiastically into her huge tits. She squeezes you passionately, tears of joy trickling from her eyes, then lets you go and gives you a quick kiss before walking away, visibly much happier after talking to you.");
		//Marble is now on her Purification Route
		//While on her Purification Route, Marble’s Presents will always be LaBova
		//Once Marble is purified, the "get presents" option reverts to its default options.
		flags[kFLAGS.MARBLE_PURIFICATION_STAGE] = 1;
		doNext(camp.returnToCampUseOneHour);
	}

	//PC Gives P.Labova
	//Play this scene when PC chooses the "P.Labova" button in Marble’s options
	//After Marble has enough purified Labova to put her below 30 corruption, this scene no longer plays; play the "P.Labova Doesn’t Work Any More" scene
	//This option is only available if the PC’s corruption is under 50, and the purification quest is active.
	public function giveMarblePureQuestLabova():void
	{
		clearOutput();
		player.consumeItem(consumables.P_LBOVA);
	 	outputText("You tell Marble that you managed to get some LaBova alchemically purified, and you want her to drink some.");
		//First time
		if (flags[kFLAGS.TIMES_GIVEN_MARBLE_PURE_LABOVA] == 0)
		{
			//Marble’s corruption is reduced by 4
			player.addStatusValue(StatusEffects.Marble, 4, -4);
			outputText("\n\nYour bovine lover meets your eyes calmly and nods, holding out her hand for the vial, which you hand over to her. She opens the bottle of creamy, milk-based fluid and chugs it down without hesitation.");
		 	outputText("\n\nShe promptly drops the empty bottle on the ground, where it smashes, her hands going to her stomach and pressing themselves against it. She grimaces in pain, her stomach audibly gurgling as it rebels against the alien fluid she’s forced herself to drink. She arches her back and lets out a pained moan as her ");
			if (player.statusEffectv2(StatusEffects.MarbleSpecials) == 4) outputText("eight");
			else outputText("two");
		 	outputText(" nipples suddenly discharge themselves, soaking her shirt and actually managing to spurt visible arcs of milk through the fabric. Minutes go past as the milk sprays everywhere, but then it stops as suddenly as it started. Marble sighs in relief and pats her belly. \"<i>That really didn’t feel very good... hope I don’t have to go through that too often.</i>\" She then realizes her shirt is sopping wet. \"<i>Aw, no, my shirt! I haven’t milked myself since I was a little girl,</i>\" she complains, pulling the milk-sodden garment off of herself and eyeing it sadly. \"<i>I’ll need to hang this out to dry and wear one of my spares...</i>\" she mumbles, even as you politely leave her to take care of that.");
		}
		//P.Labova doesn’t work any more
		//Play this scene automatically when PC gives Marble the first Labova after reaching her "quota"
		else if (player.statusEffectv4(StatusEffects.MarbleSpecials) <= 30)
		{
		 	outputText("\n\nWithout ceremony, you pass the bottle of purified LaBova to Marble, who chugs it down. You wait for the usual reaction, but, to your surprise, nothing happens. You ask the cowgirl if she feels all right.");
		 	outputText("\n\n\"<i>I... don’t feel different in the slightest, sweetie,</i>\" Marble replies, looking as confused as you feel. \"<i>I guess this stuff just isn’t working any more - I must need something with more potency than that to fully purify myself,</i>\" she muses.");
		 	outputText("\n\nYou ask if she has any ideas on finishing the job.");
		 	outputText("\n\n\"<i>Well... I’m not really sure; I mean, corruption isn’t something that just washes off like old grease. The demons wouldn’t have the world over a ledge if it was that easy to undo.</i>\" The cowgirl tells you. She rubs her lower lip thoughtfully. \"<i>...I suggest you go and speak to Rathazul; he might have an idea.</i>\" Marble shrugs as she finishes. You digest this information, promise to look into it, and then walk away, leaving her to her musings.");
		 	flags[kFLAGS.MARBLE_PURIFICATION_STAGE] = 2;
		}
		//Every other time
		else
		{
			//Marble’s corruption is reduced by 4
			player.addStatusValue(StatusEffects.Marble, 4, -4);
			outputText("\n\nYour bovine lover meets your eyes calmly and nods, holding out her hand for the vial, which you hand over to her. She opens the bottle of creamy, milk-based fluid and chugs it down without hesitation.");
		 	outputText("\n\nShe quickly hurries to remove her shirt lest she stain it again, allowing her great, heavy");
			if (flags[kFLAGS.MARBLE_BOVA_LEVEL] > 1) outputText(", fur covered");
		 	outputText(" breasts to dangle freely. Stoically she bears the pain as her stomach loudly rumbles and groans, holding her breasts up proudly as her ");
			if (player.statusEffectv2(StatusEffects.MarbleSpecials) == 4) outputText("eight");
			else outputText("two");
		 	outputText(" nipples begin spray milk everywhere - you have to take a step back to avoid being squirted yourself. Finally, Marble’s breasts stop their spraying, leaving the two of you standing in a milky puddle of mud. The cowgirl pulls her shirt back on over her body. \"<i>That stuff still tastes vile, but I guess it’s worth it. I just hope it finishes working soon.</i>\" she tells you. You assure her that you believe in her ability to get through this, and then head back to the main part of your camp.");
		}
		flags[kFLAGS.TIMES_GIVEN_MARBLE_PURE_LABOVA]++;
		doNext(camp.returnToCampUseOneHour);
	}
	
	
	//Display default Marble interaction options

	//PC visits Rathazul
	//Play this scene when next the PC meets Rathazul
	//The PC must have played Rathazul’s introductory scene to trigger this scene
	//The PC must have triggered Marble’s "LaBova don’t work no more" scene to trigger this scene
	public function visitRathazulToPurifyMarbleAfterLaBovaStopsWorkin():void
	{
		clearOutput();
		//if (Rathazul is not in camp)
		if (player.findStatusEffect(StatusEffects.CampRathazul) < 0)
		{
		 	outputText("You spot the elderly alchemist's camp on the lake once more.\n\n");
		}
	 	outputText("As you approach the rodentine alchemist, you remember Marble’s problems and resolve to ask him if he can possibly help you. Once he finishes greeting you, you politely return the greeting and ask if he would be willing to lend his opinion on a problem you have.");
	 	outputText("\n\n\"<i>A problem? Well, I’m not much more than a tired old potion-brewer these days, but I’ll try,</i>\" the elderly rat responds.");

	 	outputText("\n\nYou explain to him about Marble and her relationship with you, about the problems you had with her addictive milk and her efforts to cure herself. Rathazul looks thoughtful and strokes his furry chin. <i>\"You say you’ve tried using those bottles of LaBova that I purified for you?\"</i> You reply in the positive. \"<i>Well... I might be able to do something to finish the job... but I would need lacta bovine milk to study first.</i>\"");
	 	outputText("\n\nYou smile and thank him for the information, then turn to return to Marble, promising to be back with some of her milk as fast as you can.");
		//if (Rathazul is not in camp)
		//the quest is written under the assumption that Rath is in your camp.  I recently found out it is possible to lock him out of being a follower, so I added in this section to ensure that he is.
		if (player.findStatusEffect(StatusEffects.CampRathazul) < 0)
		{
		 	outputText("\n\n\"<i>Whoa, hold on there, " + player.mf("boy","girl") + ",</i>\" Rathazul stops you, \"<i>Hearing about your quest for purification makes my heart feel warm again for the first time in years.  In exchange for helping you out in this endeavor, please allow me stay at your camp.  I'm sure you'd appreciate saving yourself the trouble of going back and forth for each little thing.</i>\"");
		 	outputText("\n\nConsidering just how important his help has been in purifying Marble, you doubt that you'd be able to get any further without his help, and agree to let him stay in your camp.");
		 	outputText("\n\n<i>\"Then let me gather my things, and you can show me your camp.\"</i>  This takes very little time, and in very short order the two of you have arrived in your camp.  \"<i>I'll set my stuff up while you go talk to your mate.</i>\"");
			//Rathazul is set as a follower
			player.createStatusEffect(StatusEffects.CampRathazul, 0, 0, 0, 0);
		}
		//{Next}
		menu();
		addButton(0,"Next",pageTwoOfVisitingTheRatForMurblesPurification);
	}
	public function pageTwoOfVisitingTheRatForMurblesPurification():void
	{
		clearOutput();
	 	outputText("Fortunately, Marble is at your camp rather than off at Whitney’s, and your bovine lover looks up at you hopefully as you approach. \"<i>Did he say he could help?</i>\" she asks, excitedly.");
	 	outputText("\n\nYou nod your head in response and tell her that he needs a sample of her milk before he can do anything. You are about to start looking for something to put some in, when she smirks and pulls out a bottle. \"<i>I just got back from getting myself milked; will this do, sweetie?</i>\" she teases you.");
	 	outputText("\n\nYou accept the bottle and thank her; she seizes this as an opportunity to peck you on the cheek before you go racing off to Rathazul.");
	 	outputText("\n\nThe old rat looks up with a faint grin as you come skidding to a halt in front of him, and then calmly accepts the bottle that you give him. \"<i>It will take me at least a day to finish testing this; I will let you know what I find,</i>\" he tells you.");
	 	outputText("\n\nYou thank him for his help, tell him that Marble will also appreciate it, and then calmly head back to camp. Behind you, Rathazul begins busying himself with the strange equipment he does his work with.");
	 	flags[kFLAGS.MARBLE_PURIFICATION_STAGE] = 3;
	 	flags[kFLAGS.MARBLE_RATHAZUL_COUNTER_1] = 24;
	 	
		doNext(camp.returnToCampUseOneHour);
	}

	//Rathazul’s Report
	//This scene occurs automatically the first morning after Rathazul receives Marble’s milk
	public function rathazulsMurbelReport():void
	{
		clearOutput();
		flags[kFLAGS.MARBLE_RATHAZUL_COUNTER_1] = 0;
	 	outputText("When you wake and join Marble ");
		if (kGAMECLASS.camp.companionsCount() > 2) outputText("and your other followers ");
	 	outputText("for breakfast this morning, you find a bleary-eyed Rathazul waiting at the campfire. Marble clucks her tongue and gives him a mug of something strong, which he accepts gratefully, noisily slurping down a mouthful. He takes a seat, staring into his mug, and then sighs softly.");
	 	outputText("\n\n\"<i>I’m afraid I have some bad news... while that one sample you gave me was very useful and I do have a prototype formula finished, I’m not entirely sure it is safe for Marble to drink.  I’d like some milk from another lacta bovine, preferably one who hasn’t been purified the way you have, so I can complete my work.</i>\" he tells Marble, who looks thoughtful.");
	 	outputText("\n\n\"<i>Hmm... I have two sisters; would milk from one of them work?</i>\" she asks.");
	 	outputText("\n\n\"<i>Milk from a relative would probably be the best of all.</i>\" Rathazul enthuses.");
	 	outputText("\n\n\"<i>Then that’s the solution!</i>\" Marble declares, full of cheer. But then her face falls. \"<i>But it’ll take me a few days to get from here to home, and then more to get back. " + player.short + ", I don’t want to leave you here alone if you need my help,</i>\" she insists.");
	 	outputText("\n\nDo you tell her it’s okay, or tell her you’re not ready to send her away?");
		//[Go] [Stay]
		menu();
		addButton(0,"Go",murbleShouldGoRunAlongAndGetHerCuntySisterSoTheyCanBeCuntsTogether);
		addButton(1,"Stay",stayHereAndDontGoGetYerSisterShesABitch);
	}

	//[=Stay=]
	public function stayHereAndDontGoGetYerSisterShesABitch():void
	{
		clearOutput();
	 	outputText("You shake your head and tell Marble that you still need her at the camp; you’ll tell her when you can spare her.");
	 	outputText("\n\nMarble sighs softly and nods her head. \"<i>Alright, sweetie, if that’s the way you feel. But please don’t take too long, alright? We’re so close to...</i>\" she hesitates a moment before finishing, \"<i>fixing me at last.</i>\"");
	 	outputText("\n\nWith that said, the three of you finish your meals.  Rathazul shambles off to get some much-needed sleep.  Marble prepares for her morning training, and you prepare yourself for another day in Mareth.");
		//Marble now has the "Go" option in her buttons when interacting with her through the "followers" menu
		//The "Go" button links to the same "Go" scene as choosing "Go" when Rathazul first makes his report
		doNext(camp.returnToCampUseOneHour);
	}
	//[=Go=]
	public function murbleShouldGoRunAlongAndGetHerCuntySisterSoTheyCanBeCuntsTogether():void
	{
		clearOutput();
	 	outputText("You tell Marble that if she needs some time off to go and see her family for this matter, it’s okay with you.");
	 	outputText("\n\nThe cowgirl’s face lights up in a joyous smile and she promptly grabs you in the tightest hug she can muster. <i>\"Thank you! I’ll be back as quickly as I can, okay? Don’t worry, sweetie, I know the way home and I know how to take care of myself.\"</i>  She promptly drops you and starts hurrying around the campsite, gathering things and mumbling to herself as she plans out how to get back home to get some of the precious lacta bovine milk she needs.");
	 	outputText("\n\nYou give her a hand, and soon she has a travel kit packed and is heading off: first to Whitney’s to explain where she’ll be for the next few days, and then to her home across the mountains.");
		//Marble will be out of camp for 5 days, returning at dawn of the sixth day
		flags[kFLAGS.MARBLE_PURIFICATION_STAGE] = 4;
		flags[kFLAGS.MARBLE_RATHAZUL_COUNTER_2] = 240;
		flags[kFLAGS.SLEEP_WITH] = "";
		doNext(camp.returnToCampUseOneHour);
	}
	
	//Clara Appears in Camp
	//happens at the start of the sixth day after sending Marble to her family.
	//Clara is the youngest of Marble’s sisters, she is great at cracking funny jokes, and telling stories, and has an overall upbeat nature.  She does have this almost sinister smile that sometimes appears on her face when looking at the PC.  She looks like Marble in most respects, other than having black and white blotched pattern fur, and being a bit shorter and less endowed than Marble.  She is 6’2", and has GG cup breasts.
	public function claraShowsUpInCampBECAUSESHESACUNT():void
	{
		clearOutput();
		flags[kFLAGS.MARBLE_RATHAZUL_COUNTER_2] = 0;
	 	outputText("As you get up, you hear the voices of two happy women chatting pleasantly to each other; you recognize one as Marble, but the other is a stranger to you. Whoever they are, they’re clearly getting along very well, and both sound quite excited.  <i>\"Morning sweetie!</i>\"  Marble excitedly exclaims at the sight of you coming out of your " + camp.homeDesc() + ".  <i>\"Let me introduce you to my sister, Clara.</i>\"");
	 	outputText("\n\nThe other woman, whom you presume is Clara, certainly does look like she is related to Marble.  She is obviously another Lacta Bovine, with many of the same features as ");
		//[Marble has cow face or not]
		if (flags[kFLAGS.MARBLE_BOVA_LEVEL] <= 1) outputText("your mate has");
		else outputText("what your mate use to have");
	 	outputText("; cow legs, ears, horns, and large breasts.  However, she doesn’t have Marble’s brown fur, instead having black and white blotched fur across her legs and ears and a mane of white hair atop her head.  She is wearing a one piece thick cloth dress, with a great deal of fancy embroidery decorating it.  You also guess that she’s a bit smaller than Marble, in both the chest and height departments.");

	 	outputText("\n\nSeeming to have a fair idea of what you’re thinking, Clara chimes in sarcastically, \"<i>Thinking you might have picked the wrong girl, charmer?</i>\"  She waits a moment, giving you a serious look, before bursting out laughing and says, \"<i>No, I’m just messing with you.  Marble’s told me all about you two loovers, and I just had to meet you.</i>\"  Marble certainly doesn’t seem to mind the comment, and in fact seems to be enjoying the joke.");
	 	outputText("\n\nYou can’t help but notice that Clara sometimes draws out the o’s, almost like moos, and wonder why she does that; Marble doesn’t, after all. Maybe it’s a speech impediment. You decide to be polite and ignore it, introducing yourself to Clara and telling her it’s nice to meet one of Marble’s family... though you have to say, as you turn to Marble and meet her eye with a knowing smirk, you kind of expected her to bring a bottle of milk back, not a whole cowgirl.");
	 	outputText("\n\n\"<i>Like I said, I just had to meet you after Marble told me about the struggle you two went through to avoid getting addicted to her.</i>\"  She says cheerfully, looking you in the eye");
		if (player.inte >= 60) outputText(" with a odd smile on her face");
	 	outputText(".  \"<i>It shows a lot about Marble that she respected your decision to not be hooked on moorning milk.  Just don't tell anyone else, you could start a moo-vement!</i>\"  Marble bursts out laughing at this, and you can’t help but give a chuckle as well.  \"<i>Now, who’s the alchemy genius that needs mooi?</i>\" she says, while making a small show of standing up.");
	 	outputText("\n\nYou tell her that you’ll introduce her to him, and promptly begin leading Marble’s sister over to the part of camp where Rathazul keeps his personal sleeping roll and all of his equipment. The elderly rat-morph is awake and boiling a cup of something strong-smelling over one of his bunsen burners when you get there. He looks past you at Clara, and raises an eyebrow. \"<i>Marble’s sister, I presume?</i>\" he asks.");
	 	outputText("\n\n\"<i>Uh, yeah,</i>\" Clara slowly intones, obviously taken aback by the elderly rat’s appearance.  You guess she was expecting something else.  \"<i>Good, could you please give me a bottle of your milk then?  I need it to make the formula,</i>\" Rathazul informs her.  She hesitates for a moment, then her eyes light up and she turns to you and says, \"<i>Would you do the honors of helping me get the milk our friend here needs?  Just don’t suck too hard!  We wouldn’t want you going down the fast path to another addiction, would we?</i>\"  She chuckles");
		if (player.inte >= 60) outputText(" somewhat unconvincingly");
	 	outputText(".");

	 	outputText("\n\nBefore you have a chance to respond, Marble steps forward and puts her hand on Clara’s shoulder and somewhat curtly tells her sister that, \"<i>There is a farm nearby with milkers that we can use to get the milk that our friend needs.</i>\"");
	 	outputText("\n\nClara looks at her sister, an irked expression on her face, making you recall the fights you often saw between older and younger siblings back in Ingnam. \"<i>Ooh come on sis, there’s nothing wrong with getting out a little this way... besides, it will be a lot faster this way, and more fun.</i>\"  She turns to you, whispers the last bit in your ear then gives you a wink.");
	 	outputText("\n\nAt this point Rathazul suddenly interjects. \"<i>If " + player.short + " gets the milk by suckling on your breasts, " + player.mf("he","she") + " would probably contaminate it with " + player.mf("his","her") + " saliva and make it useless. I need it to be as pure as possible; hand-milking would be preferable, if you can do that, but if you must use the milkers at Whitney’s farm, that will suffice.</i>\"");

	 	outputText("\n\nClara glares at the alchemist at this.  Then Marble shakes her head, before informing you all that, \"<i>Sorry, we Lacta Bovines can’t get milked by hand all that well, the milkers would work best.  Don’t worry, it shouldn’t take too long.</i>\"  She pulls on her younger sister’s shoulder again, and Clara gives one more stomp of her hoof before following her older sister out of the camp.");
	 	outputText("\n\nYou turn back to Rathazul, and notice that he is looking oddly concerned about something.  He then says something under his breath before turning back to his cup.  All you catch sounds like \"<i>up to no good.</i>\"");
		//page break
		menu();
		addButton(0,"Next",partTwoOfClaraShowingUpAndBeingACunt);
	}
	
	public function partTwoOfClaraShowingUpAndBeingACunt():void 
	{
		clearOutput();
	 	outputText("You turn back to the camp and continue going about your morning routine.  By the time you’re ready to head out, the girls have come back from the farm, bearing a bottle of Clara’s milk.  The spotted bovine’s foul mood seems to have improved as well.");
		//PC greets Clara and is told that her mood was improved from using the milkers, she is surprised at how satisfying that was.
	 	outputText("\n\n\"<i>Hey there, charmer!</i>\" Clara says cheerfully, \"<i>I was surprised at how goood it felt to use those milkers, have you seen the setup that Marble’s got there?  I think Ophelia would kill for a suite like that.  Marble, would you please give that bottle to the rat?</i>\"  Marble gives her sister a look, then takes the bottle and goes over to the alchemist’s corner of the camp.");
		//Clara tells you not to run off anywhere, she is going to make something to celebrate Marble’s impending purification.
	 	outputText("\n\nYour new acquaintance clops up to you and puts her hand on your shoulder, \"<i>Now don’t you run off anywhere.  I want to make you, and everyone else in your camp, some tea to help start the day.  I’m pretty goood at it, so you won’t be sorry!</i>\" she casually informs you with a laugh before heading off to the campfire and pulling some supplies out of a pack you presume she brought with her.  You suppose you might as well wait a little while before leaving, you’ll also get a chance to hear what Rath’s initial thoughts are on the new sample.");
		//Clara calls everyone in the camp for a drink of tea that she has prepared.  Each follower must respond in a way such that it is believable for them.  Only Rathazul does not join in, having already had his own thing, and being busy on the formula.
	 	outputText("\n\nAfter a moment Marble comes back and asks you what Clara is up to.  You let her know about the apparent morning tea that you’ll all be getting, to which Marble looks pleased about.  You ask her why that improved her mood, and Marble tells you that she had a chance to sample Clara’s tea when she was back home, and it was pretty good.");
		//Get followers for tea
		//Set a temp integer variable that will track the number of followers agreeing to come for tea.
		//if (any of the following followers are in camp)
		var teaDrinkers:int = 0;
		if (kGAMECLASS.camp.companionsCount() >= 3)
		{
		 	outputText("\n\nMarble suggests that you should gather up the others while Clara is still making it, it shouldn’t take too long.  You nod, and head off, leaving Clara and Marble at the campfire.");
			//Go to each of the followers you have in turn, and ask them if they want some morning tea.  All followers capable of fighting must agree to the tea, non-fighters can agree or refuse.  Remember that this scene cannot come up if the PC is very corrupted, and scenes for the very corrupt followers don’t necessarily need to be written.
			//(Amily is in camp)
			if (amilyScene.amilyFollower() && !amilyScene.amilyCorrupt())
			{
				//Amily’s response to being asked to have tea
			 	outputText("\n\nWhen you approach Amily about having tea with Clara, she smiles brightly. \"<i>I haven’t enjoyed something like that in ages... it kind of reminds me of the old days.</i>\" She trails off, looking a little sad, but then shakes it off. \"<i>Sure, I’m game.</i>\"");
				//temp follower variable ++
				teaDrinkers++;
			}
			//if (Bimbo Sophie is in camp)
			//Bimbo Sophie’s response to being asked to have tea
			if (bimboSophie())
			{
			 	outputText("\n\nYou aren’t sure why you’re bothering, but you find Sophie off doing her thing and ask her if she wants to have some tea.  \"<i>Sure thing, sounds fun,</i>\" she giggles.  Well, you suppose that wasn’t exactly the response you were expecting, but you tell her where to go anyway and continue on.");
				//temp follower variable ++
				teaDrinkers++;
			}
			//if (Helia is in camp)
			//Helia’s response to being asked to have tea
			if (followerHel())
			{
			 	outputText("\n\nYou walk over to Hel's hammock at the edge of camp and ask the fiery berserker if she'd like to join you for a cup of tea.  She cocks an eyebrow, \"<i>Don't you have something a little, uh, stronger somewhere?</i>\"  Still, with a little urging, she agrees to go to the campfire.");
				//temp follower variable ++
				teaDrinkers++;
			}
			// if (isabella is in camp)
			if (isabellaFollower())
			{
				outputText("\n\nYou head towards the corner of the camp that Isabella claims as her own and ask if the cow-girl warrioress would like to share some tea with the rest of you.");
				
				if (isabellaAccent())
				{
					outputText("  Isabella jumps from her chair, “<i>Tea?  Ooh, ja!  I hear tea und milk iz sehr gut combination, ja?</i>”  Well, she seems rather enthusiastic if nothing else.");
				}
				else
				{
					outputText("  Isabella jumps from her chair, “<i>Tea? Ooh, yes!  I hear tea and milk is a really good combination, yes? I've never had the opportunity to try it though...</i>”  Well, she seems rather enthusiastic if nothing else.");
				}
				
				teaDrinkers++;
			}
			//if (Izma is in camp)
			//Izma’s response to being asked to have tea
			if (flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00238] == 1)
			{
			 	outputText("\n\nYou take a short walk over to the stream that Izma likes to bathe in and call her over.  She asks you what’s up and you let her know what Clara’s got brewing.  The tigershark snorts. \"<i>No thank you; I don’t trust anything that might have milk in it from one of those damn cows,</i>\" she snaps, showing her teeth in a predatory expression of disdain. You try to argue that she’s being rude and distrustful of Marble’s sister, but the tigershark won’t listen, instead pointedly pushing away from the shore and diving into the depths - such as they are - of the stream.");
			 	outputText("\n\nYou wait for several minutes, but she doesn’t resurface; deciding that there’s no point in asking any more, you leave her to sulk on the riverbed.");
			}
			//if (pure Jojo is in camp)
			//pure Jojo’s response to being asked to have tea
			if (player.findStatusEffect(StatusEffects.PureCampJojo) >= 0)
			{
			 	outputText("\n\nWhen you get to Jojo’s meditation spot and ask him if he is interested in coming to the campfire for tea, the murine monk looks surprised, but nods his head. <i>\"Tea would be delightful, thank you. It’s been a long time since I was able to enjoy a civil activity such as that.\"</i>");
				//temp follower variable ++
				teaDrinkers++;
			}
			//if (Kiha is in camp)
			//Kiha’s response to being asked to have tea
			if (followerKiha())
			{
			 	outputText("\n\nKiha rolls her eyes. \"<i>Tea, doofus? Next you're going to be offering me crumpets and scones while we discuss economics. Shouldn't we be getting ready to battle Lethice instead?</i>\" Seeing the disappointment on your face, she relents. <i>\"Oh all right, I'll come along, but only because I'm feeling a little thirsty.</i>\"");
				//temp follower variable ++
				teaDrinkers++;
			}
		 	outputText("\n\nFinally, you head on over to Rathazul’s workspace and ask the elderly rat if he is interested in some of Clara’s tea.");
		}
		else
		{
		 	outputText("\n\nMarble suggests that you go ask Rathazul if he wants any tea while Clara is still making it, it shouldn’t take too long.  You nod, and head off, leaving Clara and Marble at the campfire.");
		 	outputText("\n\nYou head on over to Rathazul’s workspace and ask the elderly rat if he is interested in some of Clara’s tea.");
		}
		flags[kFLAGS.MURBLE_TEA_DRINKER_COUNT] = teaDrinkers;
		//Rathazul’s response to being asked if he wants some tea (since Rath needs to be in camp for this scene to trigger, he isn’t a part of the if statements).
	 	outputText("\n\nRathazul looks at you surprised for a moment, then shakes his head.  \"<i>Thank you for the offer, but I have some already over there.</i>\"  He indicates the foul smelling cup (that was tea?!), and turns back to his work on Clara’s milk.  Aw well.  With Marble still back at the campfire, you guess that’s everyone.");

		//continue to Clara's drugging attempt, new page
		menu();
		addButton(0,"Next",dumbshitCowCuntsTryToDrugYouBecauseTheyreCunts,teaDrinkers);
	}
	//Clara’s drugging attempt
	//Clara attempts to drug everyone in the camp with the tea that she has served.  The PC’s intelligence determines what course of action the PC can take here, and whether or not they realize what is going on.
	public function dumbshitCowCuntsTryToDrugYouBecauseTheyreCunts(teaDrinkers:int):void
	{
		clearOutput();
	 	outputText("Upon returning to the center of activity, you find a rather annoyed looking Marble sitting off to the side while Clara busies herself with a large number of cups from her pack.  Curious over what happened, you sit down next to Marble while watching Clara check the temperature of the pot.  After a moment, you ask your bovine lover why she is just watching.  \"<i>After I got the fire started, Clara insisted that I’d get in the way and ruin the tea if I tried to help,</i>\" she grumbles in annoyance.");
		
	 	outputText("\n\nA moment later the kettle Clara has on the fire starts to let out a high pitched whistling noise and is removed with an exclamation of, \"<i>It’s ready!</i>\"  The younger sibling stands up and looks around, before turning to you and asking if everyone is here.  When you nod in the affirmative, she smiles and starts pouring cups and handing them out.");

		//if (temp follower variable >=1) { She does ask your companions to wait to drink until everyone has a cup. }
		//Run a check of the PC’s intelligence, and proceed to either the low/medium/high intelligence outcome based on what that level of intelligence is.
		//new page
		if (player.inte >= 60) addButton(0,"Next",highIntelligenceOutcomesVsCowCuntDrugs);
		else if (player.inte >= 30) addButton(0,"Next",mediumIntelligenceReactsToDrugging);
		else addButton(0,"Next",lowIntelligenceGetsDruggedByCowSluts);
	}
	//Low Intelligence Outcome
	//Always happens if the PC’s intelligence is too low.  Characters with mid or high intelligence can voluntarily trigger this scene anyway.
	//Clara tricks everyone into drinking the drugged tea, and the PC wakes up outside the camp with their mouth on Clara’s chest.  They have the choice to either fight back, or give in.  If they fight back, they’ll be at a severe disadvantage.
	public function lowIntelligenceGetsDruggedByCowSluts():void
	{
		clearOutput();
	 	outputText("Once everyone has a cup, Clara smiles at all of you and holds her own cup up to her mouth and says, \"<i>To Marble’s purification and meeting new friends.</i>\"");
		//automatically drink tea
		//Drink tea
		//new function, go here if the PC decides to drink the tea even after being warned
	 	outputText("\n\nYou sip the tea you were given like all the others gathered around.  The taste is quite delightful and relaxing, a bit bitter, but it only adds to the effect.  You lower your cup and smile at Clara, telling her how wonderful it tasted.  Clara smirks and in a husky voice speaks, \"<i>I’m glad you liked it, my darling...</i>\"  Wait, what?");

		//Marble’s response
	 	outputText("\n\nMarble puts her hand to her forehead, before demanding, \"<i>What, what are you doing Clara?!</i>\"  Clara turns to her sister and with that smirking face tells her, \"<i>I’m collecting the catch that you decided to foolishly throw away.</i>\"  Marble falls to the ground as you feel yourself start to slip thanks to the drugged tea.  Just before you pass out, the visage of a pretty young woman fills your vision and says, \"<i>Come on now, let’s run away toogether.</i>\"");

		//new page 
		menu();
		addButton(0,"Next",partTwoOfLowIntelligencePCsFallingForTheIncrediblyObviousCowCuntsTrap);
		
	}
	public function partTwoOfLowIntelligencePCsFallingForTheIncrediblyObviousCowCuntsTrap():void
	{
		//set PC’s health to max, fatigue to 40, and lust to 50.  Advance time by 6 hours.
		player.fatigue = 40;
		player.HP = player.maxHP();
		player.lust = 50;
		clearOutput();
	 	outputText("You become aware of a pleasant warm feeling throughout your body, and the soft echo of a pleasant tune in your mind.  It feels like you’re on the top of the world, and nothing could be better.  Everything seems right.  For a while you just float there on the sea of bliss and pleasantness.  You occupy yourself by thinking about how good this feels, and what it reminds you of.  It isn’t easy to figure it out since the tune keeps brushing the thoughts out of your mind, but you don’t mind; you just relax in the euphoric feeling and let your thoughts float along.");
	 	outputText("\n\nFinally you think of Marble’s face, then her chest, and realize that this feeling feels a lot like when you used to nurse her.  For some reason, this makes you feel anxious and worried.  Confused, you force yourself to focus, trying to get rid of the worry.  However, this only makes you feel more and more worried until your eyes fly open, and are met with a large cow-girl bust.  It isn’t the bust of the bovine you were imagining that you were staring at, but of a more recent acquaintance.");
	 	outputText("\n\nNoticing your eyes open, Clara looks down at you and smiles, stopping the tune she was humming.  \"<i>Awake are we?  That’s okay, you’re almost done anyway,</i>\" she chuckles wickedly.  You try to ask her what she means, only for you to find your mouth is full of milk collected from the teat it was fastened too.  Slightly panicked, you push away from Marble’s sister and take stock of your situation.  The heifer isn’t expecting this response and doesn’t have a chance to react before you’re out of her arms.");
	 	outputText("\n\nYou find yourself in an underground cellar, with Clara looking at you with a sick smile on her face.  No one else is in sight.  Putting your hand to your ");
		if (flags[kFLAGS.MARBLE_BOVA_LEVEL] <= 1) outputText("face");
		else outputText("muzzle");
	 	outputText(", you try to figure out what the heck is going on.  You remember meeting Marble’s sister, then getting tea, and then...  What did Clara say to Marble?  You groan slightly, your body feeling an odd old craving.");

	 	outputText("\n\n\"<i>Wondering what’s happening?  Don’t you worry your pretty head about it.  You’re just being made ready to be my mate and slave for the rest of my life.  Come on back to my breast darling. I’ll get you good and addicted soon,</i>\" your kidnaper intones with an increasingly crazed look on her face.");
	 	outputText("\n\nYour body desperately wants to do what she is saying; you can feel it.  You have no idea how long you’ve been drinking from her, but you’re definitely close to becoming completely dependent on Clara.  Due to your current location, it will be impossible to get away without getting past Clara, and that’s going to be really hard given your current condition.  With each moment your desire to submit to her only becomes stronger.  Still, if you want to escape this insane cow-girl, you’re going to need to fight her.  At least ");
		//(if player is not using fists)
		if (player.weaponName != "fists") outputText("your [weapon] is nearby, and ");
	 	outputText(" you’re still wearing your [armor].");
		//PC chooses fight or submit.
		menu();
		addButton(0, "Fight", fightCowCuntAfterBeingTotesMcGoatsDrugged);
		addButton(1, "Submit", voluntarilyChooseCowCuntBadEndYouBad);
	}
	
	//Chose fight
	public function fightCowCuntAfterBeingTotesMcGoatsDrugged():void {
		clearOutput();
	 	outputText("You steel yourself, ");
		if (player.weaponName == "fists") outputText("raise your fists");
		else outputText("grab your " + player.weaponName);
	 	outputText(" and get ready to fight to free yourself from this mad milkmaid’s mammaries.  Realizing your intentions, Clara’s face turns from a crazed grin to an angry glare.  With barely contained fury, she screams at you, \"<i>Oh don’t you worry darling, I will <b>make</b> you love drinking my milk!</i>\" before standing up, hefting a nasty looking heavy mace, and charging at you.");
		//go to Clara’s fight
		startCombatWithMarbleSister(false);


	}
	public function startCombatWithMarbleSister(inCamp:Boolean = true):void
	{
		startCombat(new Clara());
		player.createStatusEffect(StatusEffects.NoFlee,0,0,0,0);
		if (inCamp && player.findStatusEffect(StatusEffects.ClaraFoughtInCamp) < 0) player.createStatusEffect(StatusEffects.ClaraFoughtInCamp,0,0,0,0);
	}
	//Chose submit
	public function voluntarilyChooseCowCuntBadEndYouBad():void
	{
		clearOutput();
	 	outputText("Giving into the desires that your addiction has granted you, you return to Clara’s breast, much to the young cow-girl’s moans and sighs of pleasure.  \"<i>Ahh, yes, that's a goood " + player.mf("boy","girl") + ",</i>\" is whispered in your ear.");
		//go to Clara’s bad end
		menu();
		addButton(0,"Next",loseToClara,false);
	}
	
	//Medium Intelligence Outcome
	//The PC realizes that something is wrong with the situation after Clara invites everyone to drink.  The PC can hesitate to drink the tea if they have medium intelligence, or drink it anyway.  Hesitation causes the PC to not be drugged while everyone else is.
	public function mediumIntelligenceReactsToDrugging():void
	{
		clearOutput();
	 	outputText("While Clara is handing out the cups, you can’t help but think how strange everything about this feels.  You can’t put your finger on what exactly is wrong, but neither can you put the unsettling feeling out of your mind.");
	 	outputText("\n\nOnce everyone has a cup, Clara smiles at all of you and holds her own cup up to her mouth and says, \"<i>To Marble’s purification and meeting new friends.</i>\"  You carefully consider your own cup; you feel like maybe you shouldn’t drink this....");
	 	outputText("\n\nDo you drink the tea anyway?");

		menu();
		addButton(0,"Drink Tea",lowIntelligenceGetsDruggedByCowSluts);
		addButton(1,"Don't",mediumIntelligenceDoesntDrinkCowCuntsTea);
		//player chooses either to drink or not to drink.  Drinking is the same as the low intelligence auto drink.
	}

	//Don’t drink tea
	//new function, go here if the PC decides not to call Clara out but doesn’t drink the tea either.
	//Everyone but the PC is drugged, they then either go away with Clara, or fight her on even ground.
	public function mediumIntelligenceDoesntDrinkCowCuntsTea():void
	{
		clearOutput();
	 	outputText("You can’t shake the feeling that there is something wrong with this tea, and just consider it for a few moments.  \"<i>Uh, aren’t you going to drink your tea, charmer?  It is really goood,</i>\" your server says slowly, looking over at you with a nervous expression on her face.  You start to say something, but are interrupted when you hear Marble suddenly gasp and cry out, \"<i>Clara, what the hell did you put in this stuff?</i>\" before gasping for breath a few more times and falling over.");

		if (kGAMECLASS.camp.companionsCount()) outputText("\n\nYou rush over to your fallen companion");
		else outputText("\n\nYou rush over to one of your fallen companions");
	 	outputText(" to see what has happened, only to find that she has passed out.  Noticing the tea cup again, you turn around to face the person who prepared it.  Clara stands behind you with a disturbing smile on her face.  You demand to know what was in the tea, like Marble did before.");

	 	outputText("\n\n\"<i>You really are a smart " + player.mf("boy","girl") + ",</i>\" the girl speaks, ignoring your question, \"<i>I shoould have known you wouldn’t be so easy to trick.</i>\"  You make your demand of her once more.  \"<i>Don’t worry about them, my darling.  They’ll be awake in an hour or so, but by that time we’ll be long goone.</i>\"");
	 	outputText("\n\nGone?  You wonder, why would you be gone?  \"<i>Isn’t it obvious?  This is our chance to run away toogether, and not have to worry about old romantic baggage!</i>\" she cries out with a crazed grin on her face, \"<i>You’re the perfect milk mate for me, and I won’t let you slip out of my fingers.  If I have to force you to come away with me and get hoooked on my milk, I will.  So don’t make this hard on yourself.  Oh, and if you try to run, I will kill Marble, that rat, and anyone else you’ve got in this camp.  Now, drink, your, tea.</i>\"  She pulls open her shirt and then holds up another cup towards you, all the while looking more and more deranged.");
	 	outputText("\n\nIt seems you’re going to have to either give into her desires, or fight her.  There is no other option, and after the episode with the tea, it will be a one-on-one fight.");
		//PC chooses: fight or submit
		menu();
		addButton(0,"Fight",mediumIntelligencesFightCowCunts);
		addButton(1,"Submit",mediumIntelligencesSubmitCowCunts);
	}

	//Fight
	public function mediumIntelligencesFightCowCunts():void
	{
		clearOutput();
	 	outputText("You ready yourself for battle as Clara pulls an angry looking heavy mace out and says, \"<i>Fine, we’ll doo this the hard way.</i>\"");
		//start battle with Clara
		startCombatWithMarbleSister(true);
	}
	//Submit
	public function mediumIntelligencesSubmitCowCunts():void
	{
		clearOutput();
	 	outputText("You sigh and accept the cup from the cow-girl’s hands and down its contents.  In moments, your vision clouds over, and you fall into her soft arms.  Just before everything goes black, you hear a voice say, \"<i>Come on now, lets run away toogether.  I’ll make sure you’re addicted before you next wake up.</i>\"");
		//go to bad end
		menu();
		addButton(0,"Next",loseToClara,false);
	}
	//High Intelligence Outcome
	//The PC realizes that Clara does not have good intentions and that there is likely something wrong with the tea as she is passing it out.  They have the option of calling her out on it while she is still passing the tea out, say nothing but don’t drink the tea, or say nothing and drink the tea anyway.  The later two options lead to the moderate and low intelligence options respectively.
	public function highIntelligenceOutcomesVsCowCuntDrugs(teaDrinkers:int = 0):void
	{
		clearOutput();
	 	outputText("It is obvious to you that Clara is up to something; she’s been behaving oddly every time she’s spoken to you, and this sharing of tea seems even odder.  You carefully watch as she counts up cups and starts pouring them out, then starts handing them out.  You also notice that her ingredients also included something from outside her tea kit.");
	 	outputText("\n\nDecision time: are you going to call her out on her strange behavior in front of ");
		if (teaDrinkers <= 1) outputText("Marble");
		else outputText("your followers");
	 	outputText(", just not drink any tea yourself, or drink it anyway?");
		//Player chooses to drink tea, not drink tea, or Call Clara Out.  Choosing to drink is the same as the low intelligence drinking, choosing not to drink is the same as the mid intelligence option.
		menu();
		addButton(0,"Drink Tea",lowIntelligenceGetsDruggedByCowSluts);
		addButton(1,"Don't Drink",mediumIntelligenceDoesntDrinkCowCuntsTea);
		addButton(2,"CallHerOut",highIntelligenceCallClaraOut);
	}
	//Call Clara Out
	//If they call Clara out, then Clara panics while giving Marble her tea.  She takes Marble out with her mace and then confronts what is left of the party.
	public function highIntelligenceCallClaraOut():void
	{
		clearOutput();
	 	outputText("You stop Clara when she goes to hand Marble a cup and calmly ask her why she hasn’t given herself a cup too?  \"<i>Oh, I uh,</i>\" she stutters uncertainly.  You continue to push her and ask what the vial of extra fluid she added to the pot was just after she finished.  \"<i>Uh, just some special flavoring!</i>\" comes out in a nervous exclamation.");
	 	outputText("\n\nAt this point, Clara seems visibly shaken, and just keeps looking between the confused and suspicious glances she is getting.  \"<i>DAMN IT!</i>\" she shrieks as she drops Marble’s cup to the ground.  The recipient of the fine tea cries out in surprise as well, before trying to catch the falling cup.  Clara sees this as an opportunity and decides to draw a heavy looking mace.  She winds up with that blunt weapon and bashes your bovine lover over the head, hard, before Marble has a chance to respond to your warning.");
	 	outputText("\n\nThere is a stunned silence as Marble falls to the ground, and for a few moments afterwards.  The perpetrator turns her gaze to you with a crazed look in her eye, before yelling, \"<i>It didn’t have to be this way!  No one would have had to have been hurt if you’d just drank your tea quietly and come away with me, but no, you just had to be too smart for your own damn good.</i>\"");
		//proceed to one of the following depending on whether or not a combat ready follower is in camp.  Sorry for the trouble this is to code...

		//Other fighters in camp
		//if there are any other fighting companions in camp, they overwhelm Clara with the PC resulting in an auto-win.
		if (camp.companionsCount() >= 3)
		{
		 	outputText("\n\nClara starts to advance on you with her mace out, and eyes in rage, but hesitates when she realizes that other guests to the tea party have stood up as well, and readied their weapons.");
			//if (Amily is in camp)
			if (amilyScene.amilyFollower())
			{
			 	outputText("\n\nSnarling with a surprisingly savage expression for such a normally meek mouse, Amily whips out her familiar blowgun and loads it with a dart from somewhere about her person, falling back to ensure she is a safe distance for firing.");
			}
			//if (Helia is in camp)
			if (followerHel())
			{
			 	outputText("\n\n\"<i>You bitch, you'll pay for that,</i>\" Hel growls, drawing the scimitar from her hip and leveling it right at the woman in defiant challenge.");
			}
			//if (Isabella is in camp)
			if (isabellaFollower())
			{
			 	outputText("\n\n\"<i>Little bitch!</i>\"  The cowgirl snarls, standing up to her full impressive height.  \"<i>I will teach you not to try something like this again.</i>\"  Isabella grabs her shield and brandishes it prominently, ready to use it for defense and to bludgeon.");
			}
			//if (Jojo is in camp)
			if (player.findStatusEffect(StatusEffects.CampRathazul) >= 0)
			{
			 	outputText("\n\n\"<i>I wouldn’t have done that if I were you,</i>\" Jojo says, rising off the ground and retrieving his staff.  Falling into a combat pose, his face contorts into an almost uncharacteristic visage of anger directed at the woman before you.");
			}
			//if (Kiha is in camp)
			if (followerKiha())
			{
			 	outputText("\n\nThe dragon-girl Kiha wastes no time; unceremoniously spitting flames and swinging her axe with murderously brutal intent, radiating threat even as she waits for the moment to spring into attack.");
			}
		 	outputText("\n\nYou stand up as well and ready your " + player.weaponName + ", since even with such opposition it looks like the mad cow-girl still plans on fighting you.  A few minutes and bruises later, her beaten body proves this to have been a bit of a mistake on her part.");

			//Proceed to after combat in camp.
			menu();
			addButton(0,"Next",defeatClaraCuntInAFight, true);
		}
		//No other fighters in camp
		//if Marble is the only fighting follower, then the PC fights Clara on even ground for x number of rounds, before Marble wakes back up and ends the fight.
		else
		{
		 	outputText("\n\nClara rips open her shirt and starts to advance on you with her mace out, eyes in rage.  You stand up yourself and ready for a fight.");
			outputText("\n\nWith Marble down for the count, it looks like you’re on your own for this fight.");
			//continue on to fighting Clara in camp
			startCombatWithMarbleSister(true);
		}
	}
	
	public function loseToClara(combat:Boolean = true):void
	{
		clearOutput();
		//PC loses via health	
		if (combat)
		{
			if (player.HP < 1) outputText("Your body gives out from the strain, and you fall to the ground.  The last thing you hear before you pass out, is Clara’s triumphant laughter.");
			//proceed to loss scene
			//PC loses via lust
			else outputText("You just can’t fight it anymore, and desperately start to masturbate in front of Clara.  Laughing triumphantly, Clara walks up to you and forces a pill down your throat.  A moment later, you pass out.");
			outputText("\n\n");
		}
		//proceed to loss scene
		//Loss scenes against Clara
		//Intro
		//Overall, I think this should be a fairly brutal bad end towards the PC, as a counter to Marble’s kinder partner version.  Lots of taunting?  Or just her abusing her powers of control a lot without constantly rubbing it in the PC’s face?

		//PC wakes up laying down on a bed roll.  They feel very groggy and weak.  After a moment, they realize that they’ve got a strong craving for milk and that they need to drink it if they’re going to survive.  Clara then shows up and proceeds to demonstrate her control over the PC, taking great pleasure in it.

	 	outputText("You dream of odd things, distorted images that you called out for help to.  Then you were dragged away.  You kept seeing more shapes that felt familiar and important somehow, but you couldn’t focus on them.  You’d call again and again, only to be dragged away by something else again.  Eventually your cries for help become weaker and halfhearted; you know what’s going to happen next, so why bother?  Suddenly you realize that it is a cow-girl that is dragging you away; her face looks like Marble’s at first, then it splits into a huge, wicked smile, and you panic.");
	 	outputText("\n\nWith great effort, you open your eyes.  You feel incredibly weak, and the desire to go back to sleep is almost overpowering.  It doesn’t help that your head is spinning like a top, but the adrenalin rush from your recent nightmare allows you to force back the lethargy and drag yourself up off the ground and take in your surroundings.");
	 	outputText("\n\nIt looks like you’re in an enclosed building with stone walls, similar to a cellar.  Given the amount of dust around the walls, this place hasn’t been used in a long time.  There is one entrance to the room.  It's a hallway that turns a corner just outside the room and moves beyond your view.  You were lying down on a bedroll, ");
		//(height check, <70/70-82/>82)
		if (player.tallness < 70) outputText("much too big for you.");
		else if (player.tallness <= 82) outputText("just your size.");
		else outputText("way too small for your stature.");
	 	outputText("  You also find that you aren’t wearing your " + player.armorName + ", and your " + player.weaponName + " is nowhere to be seen.  ");
		//ifPC does not have: dick has more than 40 area, or breasts bigger then HHH cup, or centaur lower body, or naga lower body, or slime lower body, or drider lower body)
		if ((player.hasCock() && player.smallestCockArea() <= 40) && player.biggestTitSize() <= 25 && !player.isTaur() && !player.isNaga() && !player.isGoo() && !player.isDrider())
		 	outputText("Instead a plain but rather slim form fitting two piece garb adorns your body.  Whoever dressed you in that definitely wanted your bodily assets to be fully visible to anyone looking at you.");
		else outputText("You’re completely naked.");
		
		//new page
		menu();
		addButton(0,"Next",losingToCowCuntsPageII);
	}
	public function losingToCowCuntsPageII():void
	{
		clearOutput();
	 	outputText("It is then that you realize with a shock that a familiar urge is welling up inside you.  No, it is much stronger than you remember it being before.  You want breastmilk.  You <i>need</i> breastmilk, and if you don’t get it, you’ll die.  To make matters worse, you know whose breastmilk it is too.  Clara, Marble’s younger sister, has fatally addicted you to her milk.");
	 	outputText("\n\nAlmost as if on cue, you feel her presence getting closer to you, and your captor steps inside the room.  \"<i>Ah, yoour awake then?</i>\" she coos, \"<i>Feeling up for some milk, I hope?</i>\"  You can’t help yourself, you need that milk, so you nod.  \"<i>Goood, keeping you asleep for a while loooks like it was the right chooice.</i>\"  She laughs uproariously.");
	 	outputText("\n\n\"<i>Now, my milk slave, aren’t you going to come over here and get that milk?  Oh that’s right, you can’t without my permission, can you?</i>\" she laughs again at you, as you continue to stare at her.  ");
		//if (PC said to Marble they wanted to get addicted)
		if (player.statusEffectv3(StatusEffects.Marble) == 1)
		{
		 	outputText("\"<i>Oh?  Wondering how I know about that?  Marble told me when she was explaining about you breaking free of the addiction.  Unlike her, I’m going to make sure you behave yourself.</i>\"  ");
		} 
		else
		{
		 	outputText("\"<i>Confused?  That was one of the things Marble found out when she was researching the nature of her addiction.  She said she didn’t want to trouble you with that knowledge, but I don’t see why.</i>\"  ");
		}
	 	outputText("This woman is nothing like her sister, she loves the power she has over you, and loves to show you just how much she has.");

	 	outputText("\n\nClara leans down and puts her face right in front of yours.  \"<i>I think that if you want to drink some of my milk, you’re going to have to do some things for me.</i>  Her voice is soft, but the meaning couldn’t be harder.  \"<i>From now on, you aren’t allowed to go anywhere without my say so, and I’m the only one you’re allowed to love.  Either emotionally or physically.  Understand?</i>\"  You shudder, and think of ");
		if (kGAMECLASS.camp.loversCount() == 1) outputText("Marble");
		else outputText("the others");
	 	outputText(".  Then your eyes drop down to Clara’s chest, and you think of your need.");

	 	outputText("\n\nIt feels like you’re ordering the deaths of everyone you’ve ever cared about, but you do nod your head.  \"<i>That’s not goood enough, " + player.mf("lover-boy","lover-girl") + ".  I want to hear you say, ‘I love you, I love only you, and I will love only you.’  If you don’t, then there will be no milk for you.</i>\"  An exaggerated sad expression falls across her face, and it sounds like she is chastising a misbehaving child as she says that.");
	 	outputText("\n\nYou hesitate, and in response the white haired cow-girl slaps you across the face.  \"<i>Say it!</i>\" she shrieks, her face a picture of madness.");
	 	outputText("\n\nJust barely above a whisper, you say, \"<i>I love you, I love only you, and I will love only you.</i>\"");
	 	outputText("\n\n\"<i>Louder!</i>\" Clara yells, the barest hint of a smile playing across her features.");
	 	outputText("\n\n\"<i>I love you, I love only you, and I will love only you.</i>\"");
	 	outputText("\n\n\"<i>LOUDER!</i>\" Clara yells even louder, a huge smile painted across her face.");

	 	outputText("\n\n\"<i>I LOVE YOU, I LOVE ONLY YOU, AND I WILL LOVE ONLY YOU!</i>\"");

	 	outputText("\n\n\"<i>YESSSSS!</i>\" the mad woman shrieks, with unfocused eyes and a look of absolute bliss.  She pants for a few moments then looks at you again and quietly says, \"<i>You’re mine now, all mine.</i>\"");

		//new page
		menu();
		addButton(0,"Next",cowCuntBadEndPartIII);
	}
	//Nursing from Clara
	//The PC then nurses from Clara.  Them being unable to do anything else should be emphasized.  Clara should also make a demand of the PC related to their lovers and quest as a condition for nursing.
	public function cowCuntBadEndPartIII():void
	{
		clearOutput();
	 	outputText("Her gaze is not a pleasant one, to say the least.  \"<i>Aw, don’t be afraid,</i>\"  She coos in response to your expression.  \"<i>You’ve earned the right to drink my milk.  You should be happy!</i>\"  Still smiling, she reaches up and opens up her shirt.  The sight of her bountiful mammaries brings your need back to the top of your priorities, pushing fear out of the way.  You can’t help but lick your lips.  \"<i>Ooh, I like that face.  You’ll have to show it to me more often.  Now, come and drink your fill.</i>\"");
	 	outputText("\n\nAs if the floodgates have been opened, you rush forward and latch onto one of her nipples, surprising both you and Clara.  It doesn’t take long for her to recover, and she pulls you into an embrace against her chest.  However, you hardly even care.  All that matters to you right now is the sweet honey that is flowing through your lips and down your throat.  There is nothing more wonderful in the world than the drug you’re gorging yourself on right now.  Not even Marble’s milk compares.");
	 	outputText("\n\n\"<i>Such enthusiasm!</i>\" a distant voice calls out above you, \"<i>Not even Oophelia talking about the latest adventures of Mighty Moo and Bovine Lass can compare to this!</i>\"  You feel fingers run ");
		if (player.hairLength > 0) outputText("through your " + player.hairDescript());
		else outputText("across your scalp");
	 	outputText(", then they suddenly grip down tight.  \"<i>Let’s see if you can pick up the pace.  Drink faster, my love slave!</i>\"  You do as the voice asks, and loud moans of pleasure follow.");

	 	outputText("\n\nYou suck as hard as you possibly can: you need to!  You can’t possibly care about anything else than satisfying your need, and you want to do it in the best possible way for the subject of your love.  You don’t know how long this continues for, but eventually you’re pulled back abruptly from the tap from which the elixir of the gods flows.  You notice that your [leg] is wet.  You look down and find that Clara’s dress is soaked, right in front of her womanhood.  \"<i>Time to switch nipples, " + player.mf("lover-boy","lover-girl") + "</i>\" Clara says breathlessly, calling your gaze back up.  \"<i>This time, we’re going to try it a bit slower.</i>\"");
		//new page
		menu();
		addButton(0,"Next",cowCuntBadEndPartIV);
	}

	public function cowCuntBadEndPartIV():void
	{
		clearOutput();
	 	outputText("Now you get a chance to see a softer side to Clara.  The cow-girl gently takes your head and guides you to the other nipple.  She continues to hold you with one arm as you gently start drinking.  With her other hand, she caresses you.  She starts with your head, slowly cleaning up your " + player.hairDescript() + ".  Your feeder then delivers a small pinch to your cheek, and you hear her say, \"<i>You really are a damn sexy piece of woork.</i>\"");
	 	outputText("\n\nHer hand moves down your body, and finds itself on your [chest].  She toys a bit with the nipples, giggling at your reaction, then moves down to your stomach and pokes you.  Your reaction only promotes more laughter.  You guess that she wants to get a <i>feel</i> for her new toy, and your thoughts are confirmed when she grips your legs, continuing to test you for any places that might be suitable targets for tickling you.");
	 	outputText("\n\nEventually the pokings and proddings wind down, and the young cow-girl becomes more interested in your naughty bits now.  ");
		//if (player is male)
		if (player.hasCock() && !player.hasVagina())
		{
		 	outputText("At this point your " + player.multiCockDescriptLight() + " is rock hard, and Clara gives it a few strokes.  She does seem to lose interest surprisingly quick though.");
		}
		else if (player.hasVagina() && !player.hasCock())
		{
		 	outputText("You’ve become quite wet at this point, and Clara gives your " + player.vaginaDescript() + " a few rubs, before tugging on your " + player.clitDescript() + " once.");
		}
		else if (player.hasCock() && player.hasVagina())
		{
		 	outputText("Your arousal at this point is quite apparent on the whole of your genitals.  Clara gives you a few touches and caresses, but doesn’t seem all that interested.");
		}
		else
		{
		 	outputText("Or rather, your lack of thereof.  Clara doesn’t seem to mind too much; Marble must have told her about this part of you too.");
		}
		//Clara fingers the PC’s asshole
	 	outputText("\n\nIt then becomes rather apparent exactly what Clara really wants to play with now, and you feel her fingers slip down and around your body.  She gets herself a handful of your " + player.buttDescript() + ", and then slips her fingers into your crevice.  That finger doesn't stop until it's pushed itself inside your " + player.assholeDescript() + " and triggered a response that makes Clara laugh with delight.  Feeling emboldened, the bovine girl thrusts another finger into your back entrance and starts wiggling them around.");
	 	outputText("\n\nBy now you’re so over aroused from nursing that you cum on the spot from her playing with your ass.  The nipple that you’d been sucking on up until now slips out of your mouth, and the woman holding you lies you back on the ground, smiling.  Clearly your orgasm did not go unnoticed by her.  \"<i>I’m definitely going to have to find new ways to play with you after this,</i>\" she says, that crazed smile back on her face, \"<i>but for now, I think it is time for soome sex.</i>\"");

		//Proceed to either the has fitted cock, no fitted cock, or has not cock variants.
		menu();
		if (!player.hasCock()) addButton(0,"Next",cocklessPCsGetAbusedByCowCunts);
		else if (player.cockThatFits(20) < 0) addButton(0,"Next",cockTooBigForCowCuntageBadEndage);
		else addButton(0,"Next",badEndDickThatFitsClara);
	}

	//Clara’s vaginal capacity is 20 (she is a virgin that has not trained her vagina at all.  Marble used a 2x8 inch large dildo almost daily before she met the PC, this is not counting the handle, she also did have sex with her second boyfriend)
	//PC has a cock that fits
	//Clara complements the PC on managing to avoid letting their cock grow to "stupidly big" proportions like so many other natives of the world, and then proceeds to violate them with her vagina.  Make a note that she is a virgin.  She promises them that they will continue to meet her needs for much time to come.

	//cock n is the largest cock that will fit in Clara’s 20 capacity
	public function badEndDickThatFitsClara():void
	{
		clearOutput();
		var x:int = player.cockThatFits(20);
		if (x < 0) x = player.smallestCockIndex();

		//if (PC does not have: dick has more than 40 area, or breasts bigger then HHH cup, or centaur lower body, or naga lower body, or slime lower body, or drider lower body)
		if ((player.hasCock() && player.smallestCockArea() <= 40) && player.biggestTitSize() <= 25 && !player.isTaur() && !player.isNaga() && !player.isGoo() && !player.isDrider())
		{
		 	outputText("In seconds she’s freed you of the form fitting garment that you woke up in.  ");
		}
	 	outputText("You’re still erect from the arousal that nursing from Clara gave you.  The young cow-girl straddles your calves and gives your " + player.cockDescript(x) + " a slight flick with her finger and continues to smile broadly at you.  \"<i>One thing that I was really worried about was that you woouldn’t have a penis that I could actually fit inside me.  Thankfully, that isn’t the case, and that pretty pecker is just my size!</i>\"  She pulls apart the lips of her womanhood before continuing, \"<i>This will be my first time ever putting anything in here, take note just how special of a slave you are to me!</i>\"");

	 	outputText("\n\nWell, she certainly isn’t wasting any time, as the very next instant she has lowered her opened labia onto the tip of your " + player.cockDescript(x) + ".  The passage is already wet and slick, thanks to her previous orgasm.  Immediately, an expression of both pain and pleasure crosses over the bovine woman’s face and she starts to pant.  You lift up your hands, bClara issues a sharp command that you aren’t to do anything at all while she has the sex she wants.  You can’t do much else but just lie back and take it.");
	 	outputText("\n\nThe woman using you as a sex toy takes things almost agonizingly slowly.  For some time she only puts the tip in, and stirs it around her entrance with her fingers while panting in unfamiliar pleasure.  There isn’t much question that she is indeed a virgin; she quite clearly has no idea what she is doing.  Of course, any attempts to help her just get you an icy glare and you return to waiting for what she intends to do next.");
	 	outputText("\n\nFinally, Clara stops teasing you, and lowers herself down.  She gives several cute sounding gasps and long oos before the whole of your length is inside her,  at which point she promptly creams herself and cries out, \"<i>Moo!</i>\"  Her orgasm is quite a wet one, liberally drenching your waist and crotch.");
	 	outputText("\n\nAny fears that you’re going to be left wanting are quickly dispelled, as when the once virgin woman finishes her second orgasm, she starts to violently pump her body up and down.  The abrupt change in the kind of sex you’re having catches you off guard and blows your mind almost instantly.  Clara isn’t doing much better, as all that is coming out of her mouth at this point is just mindless pleasure-filled babbling.");
	 	outputText("\n\nThe sex is not much more than a blur of pleasurable sensations, lust addled nonsense, the wet slapping of two bodies hitting one another, and the bouncing of two giant breasts.  It is worth noting that Clara does improve her sexual skills quite considerably during the interim.  Once you get to the end of the frantic lovemaking, she adds hip rotations, pelvic thrusts, and rubbing to her desperate pumping.");
	 	outputText("\n\nBy that time the two of you are completely exhausted, and Clara collapses on top of you.  She grips your arms before wrapping you up in a big hug against her chest.  \"<i>I’ll never let you leave me, you’re mine forever and ever...</i>\" she whispers in your ear before falling asleep.  You aren’t sure if you should be happy or not at that prospect.");
		menu();
		addButton(0,"Next",finalBadEndWithCowCunt);
	}
	
	//PC does not have a cock that fits, but does have at least one cock
	//Clara gets upset over the PC’s cock(s) being too big to fit her.  If the PC can fit Marble, she will have a bit of a rant on Marble talking about learning to accept larger cocks.
	public function cockTooBigForCowCuntageBadEndage():void
	{
		clearOutput();
	 	outputText("\"<i>Now, we do have one problem.  ");
		if (player.cockTotal() > 1) 
		{
		 	outputText("All of your penises are");
		}
		else outputText("Your penis is");
	 	outputText(" too big for a virgin like me to fit!  How the hell am I suppose to get that inside me?</i>\"  Clara stands up and starts stomping around the room.  ");
		//if (PC has at least one dick that will fit inside Marble’s current capacity)
		if (player.cockThatFits(marbleScene.marbleCuntCapacity()) >= 0)
		{
		 	outputText("\"<i>‘It’s not a flaw, it’s a feature,’ she said, ‘This is why we train ourselves to take big endowments,’ she said!  Fuck you Marble!  I’m not sticking that stupid big thing inside me.</i>\"  ");
		}
		else
		{
		 	outputText("\n\n\"<i>Now it seems Marble’s frustrations are also my frustrations.  ‘Oh he is just a wonderful person!’ she said, ‘I could never force him to change his body for me,’ she said!  Fuck you Marble!  What good is a lover if you can’t actually fuck them!</i>\"  ");
		}
	 	outputText("She continues ranting for several minutes before turning to you.  \"<i>YOOU!  Didn’t you ever stop to consider the needs of dainty girls like me before you started abusing transformatives?</i>\"  She sighs, apparently running out of steam.  \"<i>Who knew this plan would be so hard?");
	 	outputText("\n\n\"<i>Well, I can’t actually fuck you, but I guess I can get something else from you.  Just remember that the first thing that we’re fixing is that size problem of yours, got it?</i>\"");

		//Proceed to cockless scene.
		menu();
		addButton(0,"Next",cocklessPCsGetAbusedByCowCunts);
	}
	//PC is cockless
	//The PC is made to eat Clara out, while also being assured that soon enough they’ll be changed to better suit Clara’s needs.
	public function cocklessPCsGetAbusedByCowCunts():void
	{
		clearOutput();
	 	outputText("Clara straddles your head with her legs and looks down at you.  \"<i>Now you’re going to lick me until I’m satisfied.  Also, don’t you dare doo anything unless I tell you to, got it?</i>\"  She doesn’t wait for a response.  \"<i>Goood, now let's get started.</i>\"  The cow-girl promptly drops her snatch onto your face.");
		//if (PC has a long tongue)
		if (player.tongueType > 0)
		{
			//PC tentatively probes Clara’s insides, and she is very surprised at just how much tongue they have.  She orders them to stop, and just use the tip to lick her labia and clit.
		 	outputText("\n\n\"<i>Lick my hole, stick yourself way inside!</i>\" Clara orders.  You tentatively push your " + player.tongueDescript() + " into the entrance of the slit that has been roughly lowered onto your face.  You soon find your goal and begin the process of filling her with your great lengths of inhuman mouth muscle.  Clara gasps in surprise and quickly exclaims, \"<i>What are you dooing?!  What is that?  Stop!</i>\"  You do as requested and remove your appendage from her depths.  The cow-girl pants for a moment then speaks again, \"<i>Okay, that’s a bit much to start with.  Uh, I didn’t think your tongue would be that long!  Now, let’s try again.  Using just the tip of your tongue, lick me.</i>\"");
			//Spend some time with the PC licking Clara while she gives orders and directions while the PC hears the results of their work.  Clara then orgasms.
		 	outputText("\n\nYou start again, and using just the tip, you lick the sides of folds of the woman above you, prompting an encouraging groan of pleasure.  \"<i>Yes, keep doing that.</i>\" Clara instructs while sighing.  Thick drops of lubricant start to fill the folds that your tongue is probing, and you lap up her nectar while continuing to explore all parts of the labia that you can find.");
		 	outputText("\n\n\"<i>Mhh, huh, ah, higher!</i>\"  You obey, and move up to Clara’s clit, and the hood around it.  She has already become heavily engorged, and the instant your " + player.tongueDescript() + " touches the bovine woman’s erect love button, she lets out a low shriek of pleasure!  \"<i>Woah!  Wah, mah, mooo!</i>\" she cries out as a torrent of fluid sprays from her womanhood and drenches your face.  Clara is unquestionably an inexperienced virgin, given her rapid and unexpected orgasm.  She spends several moments trying to catch her breath.");
			//Now feeling bolder, Clara has the PC use the full extent of their tongue to penetrate her.  Clara orgasms again fairly shortly thereafter.
		 	outputText("\n\nFinally, she settles down and tells you, \"<i>Okay, I need more of that.  Use that strange tongue of yours.  Fill me!</i>\"  You do just that, and bring out the full length of your inhuman pussy licker.  In seconds, Clara starts to pant and squeal in pleasure as you fill her depths, and taste great amounts of her lubricant.  To make things as enjoyable for Clara as possible, you bring the base of your tongue to her clit, while you simultaneously pump yourself in and out of her depths.");
		 	outputText("\n\nFor a while all you hear is the loud squelching of your licker in her womanhood, and the young cow-girl’s cries of pleasure above you.  Then you suddenly don’t hear anything at all, thanks to the hands that have been clamped down onto your ears.  Clara suddenly takes a much more active role in the oral you’re giving her and starts to roughly ride your face.  In response, you intensify your tongue teasing and spin your length about her interior.");
		 	outputText("\n\nAbruptly, a large torrent of fluid comes rushing down the hole you’ve been pleasing.  Much to your dismay, the flood of fluid actually forces your " + player.tongueDescript() + " out of her passage before nearly drowning you in girl cum.  You cough and sputter for several seconds until air finally returns to your lungs.  What energy you had before now is now gone.");
			//Clara expresses her appreciation of this unexpected feature of her new slave, but does say that she has plans for them to offer her another means of pleasing her as well.
		 	outputText("\n\nClara finally releases your head from her death grip, and lets you move around again.  \"<i>Wow, " + player.mf("lover-boy","lover-girl") + ".  I never imagined you’d be able to do that!  I guess the slave I got had an unexpected feature.  I’m still going to be changing you up to give me anoother kind of pleasure, but damn!  Look at what you made me doo!</i>\"  She indicates the large pool of vaginal fluids covering the floor.  The bedroll you woke up on is completely ruined.");
		 	outputText("\n\n\"<i>I guess you’re going to need new sleeping arrangements noow,</i>\" the young bovine remarks, \"<i>Still, I think you earned a place in my bed.</i>\"  She reaches down and scoops up your exhausted form and takes you out of the room.  Just before you pass out in her arms, you hear her whisper in your ears, \"<i>I’ll never let you leave me, you’re mine forever and ever...</i>\" You aren’t sure if you should be happy or not at that prospect.");
		}
		else
		{
			//PC tentatively gives a few licks at Clara’s mound.  She promptly starts giving directions and orders to the PC, while the PC hears the results of their efforts.  Clara’s inexperience with the whole situation should be highlighted.
		 	outputText("\n\n\"<i>Lick my hole!</i>\" Clara orders.  You tentatively do just that, and run your tongue around her mound a bit.  The taste of her previous orgasm is still in there.  She gives an approving moan, \"<i>Mhh, goood, keep doing that.</i>\"  You repeat the action a few more times to more moans and taste fresh cow-girl lubricant flow into your mouth.  \"<i>Yes, now, uh... lick deeper?</i>\"");
		 	outputText("\n\nIt doesn’t sound like the woman above you is all that sure what she wants you to do; still, you’d better do what she told you to do.  You dig deeper around her folds and push your tongue into the entrance of her vagina.  Regardless of her earlier uncertainty, Clara does seem to like what you’re doing.  \"<i>Ahh, hmm, higher!</i>\" she commands, and you dedicate your full attention to her clitoris.  You run rings around the small, engorged button and dig deeply into the hood with your tongue.  \"<i>Mah, ha, mooo!</i>\" the bovine woman cries out, and a rush of fluids floods out of her womanhood, getting your chin and neck wet.");
			//Clara has her first orgasm, and feels a bit emboldened.  She asks the PC to start probing deeper and faster.  She also starts to ride their face by actively grinding herself into them.
		 	outputText("\n\nThe girl you just licked to her second orgasm spends a moment panting above you, enjoying the afterglow.  She then pulls herself back so you can see her face.  She is smiling down at you, with that same unsettling glint as before.  \"<i>We aren’t done yet, not by a long shot.</i>\" she casually informs you, and moves back over your face.  She then promptly drops herself down onto your mouth rather forcefully and starts grinding herself across your face while commanding you to lick her once more.");
			//if (PC has a muzzle)
			if (player.hasMuzzle())
			{
				//the PC’s efforts to tongue Clara are quickly forgotten, as she simply starts to fuck herself on their muzzle.
			 	outputText("\n\nYou try to do what you did to her before, but Clara’s movements make that rather difficult.  Your facial structure doesn’t do very many favors in that regard, especially when the cow-girl decides that she’d rather use your muzzle as a living dildo.  She doesn’t even bother to give you any commands anymore and simply starts bouncing up and down on your face, using it to penetrate herself.  Cries of pleasure fill your ears, along with loud squelching as your mouth and nose are trapped in her womanhood.  \"<i>Ooh, ha, yeah, more!</i>\"  You aren’t sure why she bothers, she isn’t even letting you do anything anyway.");
				//Clara eventually satisfies herself and concludes that oral isn’t all it is cracked up to be.  She has plans for the PC so that they can please her better.
			 	outputText("\n\nIt doesn’t take her too long to finish up, and your face is drenched in the proof of her orgasm.  This doesn’t seem to be enough, and Clara starts bouncing again for round three.  By the time that the cow-woman does stop, you’re barely conscious thanks to the difficulties you have breathing while your mouth and nose are inside a vagina.");
			}
			else
			{
				//The PC tries to keep up with Clara’s demands, but she just ends up fucking their face raw.
			 	outputText("\n\nYou resume licking away at the cow-girl’s womanhood, but it is rather awkward with the way that she is currently riding you.  Eventually you do manage to get a good rhythm with Clara’s rough rubbing.  She evidently enjoys your efforts, as she starts moaning quite loudly, and then creams herself for a second time on your face.  Your visage is once again flooded with the proof of her orgasm.  \"<i>Yes, yes, more!</i>\" she cries out, and then starts riding your face even harder and faster than before.");
				//Clara eventually satisfies herself and concludes that oral isn’t all it is cracked up to be.  She has plans for the PC so that they can please her better.
			 	outputText("\n\nThat’s it, Clara is going too fast and hard for you.  You can barely breath around the mound that is being incessantly ground into your face, and the cow-woman isn’t even bothering to give commands anymore anyway.  Fortunately, Clara doesn’t go for much longer, and lets you free of her arch.  You’re barely conscious by this point.");
			}
		 	outputText("\n\nYou manage to recover for long enough to notice that Clara seems a bit disappointed. \"<i>You know, that really wasn’t all I thought ooral was cracked up to be,</i>\" she comments.  \"<i>I’m definitely going to be looking for another way to make you able to please me.  It isn’t like you’re in any position to complain or stop me anyway; you’re mine now.</i>\"  The last thing you see before passing out is that sick grin of hers, and the last thing you hear are those worrying words filling your ears.  \"<i>Forever, and ever...</i>\"");
		}
		//Proceed to bad end
		menu();
		addButton(0,"Next",finalBadEndWithCowCunt);
	}

	//Bad End: Clara’s Milk Slave
	//Jump ahead a significant amount of time, and drop in on the PC doing a job for Clara, then slaving around for her while she lounges around, then a sex scene where she takes her pleasure out of the PC, and finally a nursing scene.  At this point, the PC will have one dick that is to Clara’s exact prefered specifications.  I think a cat one with proportions of 9x1.6 is appropriate.

	//Clara now has a nice house or cottage out in the woods.  She has two other husbands in addition to the PC that are also addicted to her milk.  The PC is higher in power then those other two.
	public function finalBadEndWithCowCunt():void
	{
		clearOutput();
	 	outputText("Years later...");
	 	outputText("\n\nYou’re walking along a forested path, the latest catches from your snares slung over your shoulder.  Today was a good day.  There should be plenty of meat for Tim to make a good meal for all of you, plus leftovers to last for at least several days.  No doubt that Sam will be especially happy to see you got his favorite; wild turkey.  It has been getting harder and harder to find good game these days with the increasing levels of corruption.  That isn’t to say that the forest was ever free of it, but it has definitely been getting worse since you ended your quest.");
	 	outputText("\n\nYou come to your destination: a clearing in the woods.  The familiar structure of a two story cottage comes into view through the foliage, one that all those years ago you, Tim, and Sam built for your loving wife.  The structure has undergone some upgrades since then, mind you.  It didn’t have a second story originally, but the mistress of the \"castle\" hasn’t requested any more changes, so its current state of being has lasted for over a year.  You’ve had plenty of time to get attached to the current look.  Sam’s pretty happy about that too, since renovations usually mean that the garden has to be relocated... again.");
		//Interaction with one husband in the garden, a friendly and talkative fox-morph.
	 	outputText("\n\nSpeaking of that friendly fox, there he is now; picking some strawberries and potatoes for supper.  You call out to him in greeting and head over to have a more personal talk.  \"<i>Hey there " + player.short + ", afternoon!</i>\" a broad smile accompanies this declaration, it’s always a friendly face from him.  Sam gets up and dusts off the day’s dirt, then takes a look at the bounty to be served as the main course of tonight’s meal.  \"<i>Hot damn!  Is that a turkey you’ve got there?</i>\"  At your nod, it looks almost like his face would split in two with the way he’s grinning.  \"<i>Well, don’t let me keep you.  Get that bird to Tim right away!</i>\"  Nodding once more to your fellow, you continue onward.");
		//Interaction with the other in the kitchen or work room, a timid cat-boy.
	 	outputText("\n\n\"<i>Sam, that you?  Is " + player.short + " back with something?</i>\" a timid voice calls out when you let yourself through the cottage door.  You reply by asking him to come and see for himself.  A short, slim, feline male comes racing into the room.  Catching sight of just what something you brought back was, a look of amazement crosses his face.  \"<i>Woah, now that’s a catch!  I’m glad to see you managed to get something this time, the girls won’t stop asking for something other than veggies...</i>\"  You move into the kitchen with him, while two excited cow-girls come clopping out.  If things get really bad, you’ll have to start harvesting tainted meat.  Tim grimaces, \"<i>I’m not looking forward to that, I kinda like having kids that actually stay as kids right now.</i>\"");
	 	outputText("\n\nYou give the small feline a pat on the head.  He shouldn’t worry too much right now, we’re actually in good shape today.  That cute face perks up, \"<i>You’re right " + player.short + ".  I’m sure you’ll be able to figure something out anyway, that’s why you’re the first husband.</i>\"  That certainly is true.  There is no way you could ever let down your loved ones, especially your mistress.  You wash up, and go up stairs.  She will want to see you before supper.  She always does.");
		//PC goes to serve and service Clara, they perform demeaning things for Clara for her amusement, and she then gives them the milk they need.
	 	outputText("\n\nThere isn’t a whole lot to the second floor, other than a small landing at the top of the stairs, and the door to your mistress’s bedroom.  A small chill runs down your spine as you raise your hand and knock on the door while calling out who it is.  \"<i>Back then?  Come in, first husband.  I want to satisfy myself on you.</i>\"  You were afraid of that.  <i>No you weren’t, you love satisfying your mistress!</i>");
	 	outputText("\n\nEven as the struggle in your mind to decide whether to feel fearful or joyful continues, you reflexively open the door and enter into <i>her</i> bedroom.  It’s a large room with several wardrobes and jewelry boxes scattered around the walls of the room.  One wall is dominated by a massive vanity with three mirrors, though it rarely gets much use save for putting on necklaces and earrings.  Of course, the main feature of the room is the grand bed set up on the back wall.  It’s easily ten feet by ten feet in size, and it’s upon this that your white haired and cruel (<i>beautiful</i>) eyed owner lounges; busying herself admiring the many facets of her fineries and bodily adornments.");
	 	outputText("\n\nClara has grown in the years since she came into possession of you, through multiple pregnancies and two more slaves.  Her breasts are now easily into the I cup range, and her hips have widened considerably.  Vanity is certainly something that she has grown into with her newfound power.  What hasn’t changed, are her crazed gaze and wicked smile.  <i>Everything about her is more beautiful and wonderful, you only wish to dedicate yourself even more as she grows more lovely!</i>");
	 	outputText("\n\n\"<i>Coome here milk slave.  Beg for your sustenance and maybe I will indulge you,</i>\" she says with a dismissive wave.  With reluctance (<i>reverence</i>) you get down on the ground in front of her, <i>it feels right to acknowledge your superior</i>.  After several minutes of postulating yourself, the voice of the vane and voluptuous woman above you calls out once more, \<i>Goood, speak now " + player.short + ".</i>\"  Turning your head up, with great hesitance (<i>eagerness!</i>) you recite the same demeaning words you have said every day for the last several years.");
	 	outputText("\n\n\"<i>My mistress, my goddess.  I exist to serve you.  My life is yours, your milk is my life.  I shall debase myself to the lowest of the lows, or overcome the mightiest of the mighty should you command it.  Please take pity on this one who is unworthy, and grant to me my lifeblood.</i>\"");
	 	outputText("\n\nFinally Clara turns to look at you.  Brimming with satisfaction, she opens up her dress and commands you to drink of her breast.  Satisfying your need goes much the same way it has every day.  <i>Milk, sweet delicious milk, need, need, need.  Must serve mistress.</i>  You can’t really control yourself, you <i>NEED!  Service, am I doing things right?  I will please you</i> damn slavedriver.  <i>Most wonderful lady!  Please forgive my insolent thoughts.  Need, need, NEED!</i>");
	 	outputText("\n\nOnce you’ve finished drinking, mistress directs you to lie down on her bed.  She wants to use you for her pleasure.  As always, you’re happy to comply.  Just as things have been for so long, she mounts your custom prepared equipment: a kitty cock, 9 by 1.6 inches.  You are just happy that you can serve as her sex toy so well.  It fills you with such joy to watch the body of the most beautiful woman in the world bounce on top of yours, in that fine dress with her chest still exposed and tumbling around above you.");
	 	outputText("\n\nThis is your life now.  Reduced to the milk addicted slave of a Lacta Bovine, you have abandoned your mission just to serve and be used for the rest of your life.");
		//game over
		getGame().gameOver();
	}

	//Win scenes against Clara
	//PC defeats Clara outside camp
	public function defeatClaraCuntInAFight(cheated:Boolean = false):void
	{
		if (cheated) clearOutput();
		else
		{
			//Clara is taken out by Marble
			//If the camp fight lasts 10 rounds
			if (player.statusEffectv1(StatusEffects.ClaraCombatRounds) >= 10 && player.findStatusEffect(StatusEffects.ClaraFoughtInCamp) >= 0)
			{
				clearOutput();
			 	outputText("A loud boom reverberates through the air as Marble uses her hammer to strike Clara on the back of the head, returning the favor that took her out earlier.  Your assailant drops to the ground instantly, ending the fight right there.  You consider asking if the young bovine will be all right, but given that Marble seems to have picked herself back up in a hurry, that is unlikely to be a problem.  Instead you ask your mate to see how she is holding up.  Other than a bump on the head, Marble tells you she'll be fine.  Bovine fortitude is once again proven to be formidable as Clara stirs on the ground.  In less than a minute, you and Marble are standing over the defeated, but conscious, form of your lover's sister.");
			}
			//Continue to common camp victory
			//PC drags Clara back to camp, was originally planning on putting more rapes here, but 7 with Marble are probably enough.
			else if (player.findStatusEffect(StatusEffects.ClaraFoughtInCamp) < 0)
			{
			 	outputText("Worried about the others, you head out of the cellar and drag Clara and her things with you.  Thanks to the strange way that travel works in this world, it doesn't take you long to find your way back to camp.  You catch your followers there just before they head out to go looking for you and dump your would be kidnaper before them.  Marble steps up next to you and looks down at her sister.");
				//continue to common victory
			}
			//PC Defeats Clara in camp
			//PC gets to rape Clara with Marble, if they wish to.
			else
			{
				//if (PC either stopped Clara from drugging everyone, or Marble was the only one drugged)
				if (kGAMECLASS.camp.companionsCount() <= 2)
				{
				 	outputText("With Clara incapacitated for now, you go to check on Marble and make sure she is all right.  Thankfully she seems to be fine.  You don't plan on underestimating a bovine's fortitude again in the near future.  Since her sister won't be going anywhere soon, you wait for a while to let her recover.  This doesn't take too long, and soon you and your lover are standing over the defeated form of the young bovine.");
				}
				else
				{
				 	outputText("With Clara incapacitated for now, you go and check on your followers to make sure they're alright.  Thankfully, it seems that they're just asleep.  On a whim, you check through the calculating cow's pack to see if she has anything to counter the effects of her drug.  As luck would have it, she does have a conveniently labeled pouch of herbs for just that purpose.  Since the young bovine won't be going anywhere soon, you administer the wake up herbs to your camp crew.  This doesn't take long, and soon you and Marble are standing over the defeated form of your lover's sister.");
				}
				//Continue to common camp victory
			}
			outputText("\n\n");
		}
		//Common victory
		//Raping or punishing Clara in camp with your followers
	 	outputText("\"<i>Clara, what the hell were you trying to pull there?</i>\" Marble demands of her sister, her hands shaking in rage.");
	 	outputText("\n\n\"<i>Getting a mate, what doo you think?  I was going to take " + player.mf("lover-boy","lover-girl") + " here away to live with me,</i>\" comes the incredulous reply.");
	 	outputText("\n\n\"<i>Getting a... out of my sweetie?!  We're already mates, where do you go off thinking you can just come in here and steal " + player.mf("him","her") + "?</i>\"");
	 	outputText("\n\n\"<i>No sis, you had your chance.  " + player.short + " isn't addicted to you, that means that " + player.mf("he","she") + "'s up for grabs.  That's how things work for our race.</i>\"");

	 	outputText("\n\n\"<i>What?  That can't be right...</i>\" Marble's shaking is getting worse.");
	 	outputText("\n\n\"<i>Uh yeah it is, dad is addicted to mom, remember how she made sure he did anything we wanted?</i>\"");
	 	outputText("\n\n\"<i>Daddy?  No, he was a wonderful person, he wasn't...</i>\"");
	 	outputText("\n\n\"<i>YES HE WAS!  What are you, stupid sis?  I can't believe you don't even remember the big argument that mom and dad got in when you asked to be trained how to fight.  'Battle is no place for a woman,' dad went on and on about, 'there was no way he'd train a girl.'  Well, a few hours of withdrawal shut up that little rebellion.  Mom even watched him during your sessions to make absolutely sure he didn't skimp up or seriously hurt you.</i>\"");
	 	outputText("\n\nMarble looks at her hands in horror, just barely above a whisper you manage to hear her say, \"<i>His hands were shaking, just like " + player.short + "'s...</i>\"");
	 	outputText("\n\n\"<i>Finally you're getting it.  Damn it sis, I can't believe that it took you this long to realize it.  Mom used threats on dad to get him to do what she wanted all the time.  I mean seriously, don't you feel an incredible urge to nurse people?  Find a good mate and get them addicted to you?</i>\"  Clara leans forward, \"<i>Tell me, did you ever consider starting a loving relationship with someone who didn't nurse from you?</i>\"");
	 	outputText("\n\nMarble clenches her hands and seethes at Clara.  \"<i>I, I...</i>\"");
	 	outputText("\n\n\"<i>Admit it, you don't feel like '" + player.mf("lover-boy","lover-girl") + "' here actually cares for you.  How could they if they won't drink your milk?  You're a Lacta Bovine, giving your milk is the most important thing in the world to you.  This isn't love.  Without " + player.mf("him","her") + " actually being addicted to you, it's just a one sided infatuation.  I was doing you a favor by taking " + player.mf("him","her") + " away from you.</i>\"");
	 	outputText("\n\nYour cow-girl companion continues to shake in anger, but also fear and frustration.  \"<i>I, I, YES!  I want to addict " + player.short + " to my milk!  I want to so much!  I'm so afraid that " + player.mf("he","she") + " won't stay by my side, but I also feel so bottled up.  "); //no new paragraph

		//if (PC has another lover in camp)
		if (kGAMECLASS.camp.loversCount() > 1)
		{
		 	outputText("I'm not even " + player.short + "'s only mate.  " + player.mf("He","She") + " can satisfy their needs, but can't satisfy mine?  "); //no new paragraph
		}
	 	outputText("The frustration of not being able to nurse, someone, anyone, but especially my mate is tearing me apart!</i>\"  Marble stops screaming and her head drops.  All that's coming out of her now is heavy breathing.");

	 	outputText("\n\n\"<i>There, you see?  Now I'm sure you understand why me and " + player.short + " here belong toogether.  I won't deny the proper order of things, and I'll make sure that " + player.mf("he","she") + " leads a fulfilling life as my milk slave.  " + player.mf("He","She") + "'ll even by my first husband!</i>\"");
	 	outputText("\n\nTentatively you ask what Clara means by first husband?");

	 	outputText("\n\nClara laughs at your question, \"<i>Of course!  I deserve more than the typical Lacta Bovine.  You're going to help me find at least two more husbands, build me the perfect hoome, care for my young, and take care of my every need.  You should feel hoonoored.</i>\"");

	 	outputText("\n\nMarble says something under her breath.");

	 	outputText("\n\n\"<i>What was that sis?</i>\"");

	 	outputText("\n\nMarble takes a deep breath, then says, \"<i>That isn't love.</i>\"");
	 	outputText("\n\nThe younger cow-girl scoffs, \"<i>Haven't you been listening to me sis?  " + player.mf("He","She") + "'ll be addicted to me.  That.  Is.  Love.  How else can you show just how much you care?</i>\"");

	 	outputText("\n\n\"<i>No, that's what our corrupt instincts tell us,</i>\" the lacta bovine you care for starts quietly.  \"<i>Love is caring about someone, and being cared about in turn.  It means that you're willing to change for the benefit of who you love.</i>\"  The strength of her voice grows, \"<i>Forcing what you think is your perfect mate onto someone isn't love.  That's slavery.  That's evil.</i>\"");

	 	outputText("\n\n\"<i>Really?  Didn't you say that the reason you were purifying yourself was so that " + player.mf("he","she") + " would nurse from you again?  Sounds pretty selfish to me after what you were saying about doing things for who you 'love'.</i>\"");
	 	outputText("\n\n\"<i>Well, that might be true, but there is more to it than that,</i>\" a shadow crosses over Marble's face for a moment before she says softly, \"<i>Even if it hurts me.</i>\"");
	 	outputText("\n\n\"<i>Then if " + player.short + " loves you so much, why can't " + player.mf("he","she") + " change for your sake?  Why can't they become addicted to show just how much they love you?</i>\"");
	 	outputText("\n\nMarble swallows before saying, \"<i>Do you have any idea of what " + player.short + " is trying to do?  " + player.mf("He","She") + " is trying to defeat the demons!  To stop the corruption for good!</i>\"");
	 	outputText("\n\nAt this Clara bursts out laughing, \"<i>Oh, and save the world I take it?  This " + player.race() + "?  Don't be ridiculous.</i>\"");
	 	outputText("\n\nMarble starts quivering in rage once more.");
	 	outputText("\n\n\"<i>Seriously, there is no damn way someone as pathetic as " + player.short + " could accomplish that,</i>\" she continues while struggling to her feet.  \"<i>You need to be like a twenty foot giant, champion fighter, god master of magic to pull a stunt like wiping out the demons.  " + player.short + " is none of those things.  Do you really think someone who could would actually care about a lowly Lacta Bovine like you?</i>\"  Clara pokes her finger into Marble's chest.  \"<i>I guess the saying among our kind is right, 'the first daughter has the sourest milk.'</i>\"");
	 	outputText("\n\nYou can't help but muse that a cow-girl's endurance is something that should never be underestimated.  Their strength certainly isn't as great, but is still more than an average human's by a fair margin.  Making someone who is quite strong completely enraged is generally a bad idea.  Especially when that someone has been working on a farm for close to a year lifting increasingly heavy loads and training with a massive hammer.");
	 	outputText("\n\nClara doesn't stand a chance.  In a matter of moments, she's brought to the ground once more, tightly bound up in a thick rope.  \"<i>Time to teach you a lesson!</i>\"  Marble yells with a look of rage in her eyes.");
	 	outputText("\n\nHow should you punish Clara?  You could let Marble spank Clara, ");
		//(if PC either has a cock with an area under 20 or a vagina) 
		if ((player.hasCock() && player.cockThatFits(20) >= 0) || player.hasVagina()) outputText("use Marble's unstable state of mind to get her into a forceful threesome with Clara, ");
		//(if PC either has a cock that will fit Marble, or has a vagina)
		if ((player.hasCock() && player.cockThatFits(marbleScene.marbleCuntCapacity()) >= 0) || player.hasVagina()) outputText("have sex in front of Clara so she can see what your love really is, ");
		//(if Marble is a futa)
		if (flags[kFLAGS.MARBLE_DICK_TYPE] > 0) outputText("egg Marble into violating Clara with her cock, ");
	 	outputText(" or try to calm Marble down so that she doesn't do anything to her sister.");

		menu();
		//PC chooses what kind of victory scene they want to do to Clara.
		//options are: Spank (can always do), Threesome (if the PC has a cock that is under 20 area, or a vagina), "NTR" (if PC has a cock that will fit Marble, or a vagina), Marble cock (if Marble has a cock), and Calm down (always possible).
		addButton(0,"Spank",murbleSpanksCowCunt);
		if ((player.hasCock() && player.cockThatFits(20) >= 0) || player.hasVagina()) addButton(1,"Threesome",pcAndMurbleDoubleTeamCowButt);
		if ((player.hasCock() && player.cockThatFits(marbleScene.marbleCuntCapacity()) >= 0) || player.hasVagina()) addButton(2,"NTR",NTRIsClearlyTheWorstFetishWhyWouldYouWriteThisOMG);
		if (flags[kFLAGS.MARBLE_DICK_TYPE] > 0) addButton(3,"Marble Cock",futaMarbleIsAHugeCowToCowCuntAndStuffsCowCuntsCuntFullOfCowCock);
		addButton(4,"Calm Down",calmMurblesFatAssDown);
	}
	//Marble spanks Clara
	//Just let Marble punish Clara like the bad girl she is.
	public function murbleSpanksCowCunt():void
	{
		clearOutput();
	 	outputText("Marble seems to have a good idea on how to punish Clara already, so you just sit back and watch.");
	 	outputText("\n\nThe older sister puts the younger one over her knee and raises her hand up in the air.  \"<i>Uh sis, what do you think you're doing?</i>\"  The hand comes down, and gives a dull thwack on impact.  \"<i>OOE!</i>\"  The hand goes up once more, then brought down along with another dull thwack.  \"<i>OOE!  Stop it!</i>\"");
	 	outputText("\n\n\"<i>Not until you learn how much what you did to me hurts.</i>\"");
	 	outputText("\n\n\"<i>What?!  OOE!</i>\"");
	 	outputText("\n\nYou calmly suggest to Marble that her hits might have more of the desired effect if they were on a bare bottom.  She nods at your suggestion, and promptly rolls up Clara's dress.  \"<i>Hey?  What are you doing?!</i>\"  Your mate ignores the question and removes her sibling's... wait, are those, <i>lacy black panties</i>?  Well, looks like the use of underwear is one more difference between the sisters.");
	 	outputText("\n\nWith the white haired bovine's pale bare bottom high in the air, Marble gruffly commands, \"<i>Now, say you're sorry for trying to kidnap " + player.short + ".</i>\"");
	 	outputText("\n\n\"<i>No!  I was...</i>\"  There is a loud sharp smack as Marble's hand comes down hard onto her sister's unprotected rear, leaving an angry red mark.  \"<i>OOIE!  Ooie, ooie, ooie.</i>\" Clara whimpers as small tears of pain start to flow down her cheeks.");
	 	outputText("\n\n\"<i>Say you're sorry,</i>\" comes the command once more, this time through gritted teeth.");
	 	outputText("\n\n\"<i>This isn't fair!  You can't just...</i>\"  Another sharp smack as the force of a powerful fighter's palm strikes tender tush once more, leaving another red mark across the first.  The young bovine cries out, \"<i>Stop it, please!</i>\"");
	 	outputText("\n\nThe elder bovine raises her arm once more and shouts, \"<i>Then say you're sorry!</i>\"  She doesn't even wait for a response before bringing down her punishment harder than ever.  The hit is so forceful, that the wrongdoer flies out of her judge's lap and lands a short ways away, face first in the dirt, squealing and sobbing like a small child the whole way.");
	 	outputText("\n\nAt this point, Clara doesn't even bother trying to reason with her sister anymore.  Instead, a frantic struggle with the tight bonds of rope trapping her begins in a desperate attempt to escape Marble's justice.  The executioner ignores the futile display for now and instead looks around the camp for a few moments.  Eventually she finds what she's looking for and tears off a long leather strap from one of your supply bags.  With a few gentle taps on her hand, the brown haired sibling seems to be satisfied, and turns her furious gaze back to the malefactor.");
	 	outputText("\n\nYou mention to the girl on the ground that she should take a look at what her sister found.  Those tear filled eyes open wide in absolute terror at the sight.  \"<i>You're, hah, you're crazy!</i>\" she manages to gasp out between sobs.  Like most of the pitiful girl's comments up until now, this one is ignored.  The harsh mistress of the law has come, and that mistress is going to make a bad bovine's bum blue.");
	 	outputText("\n\nMarble picks her sister up off the ground and roughly tosses her onto one of the sitting logs around the firepit.  Clara continues to sob and beg for the abuse to stop, but it is all in vain.  Marble squats down slightly behind her, winds up, and brings down the first of many harsh smacks against her rear end.  Your mate doesn't let up on her punishment until every last inch of Clara's heinous hindquarters has been covered in blue welts.  By this point, the wannabe kidnapper and slaver is nothing but a slobbering, incoherent mess.");
		//continue to calm Marble down
		menu();
		addButton(0,"Next",calmMurblesFatAssDown);
	}
	//PC and Marble rape Clara
	//Double team Clara, will be rough forceful sex.
	public function pcAndMurbleDoubleTeamCowButt():void
	//does not work with centaur, naga, drider, or goo bodies.  However, I don't particularly want to just say you can't do this scene if you have them.
	{
		clearOutput();
		var x:int = player.cockThatFits(20);
	 	outputText("You step forward and suggest to Marble that the two of you should work together to punish Clara.  She nods and asks what you have in mind.  Well, you were thinking that a sexual punishment from the two of you would be appropriate.");
	 	outputText("\n\n\"<i>What?  I don't want to have a threesome with my sister!  Only " + player.short + " should be able to touch me!</i>\"");
	 	outputText("\n\nThat outburst from the younger sibling seems to have been enough to convince your lover to go along with it.  If it wasn't for her current mood, you doubt that she'd ever have agreed.");
	 	outputText("\n\nThe two of you strip yourselves and the bound malefactor down.  Then, you both consider the naked tied-up girl, deciding how to go about this.  ");
		//if (PC has a cock under 20 area, and Marble has a cock)
		if ((player.hasCock() && x >= 0) && flags[kFLAGS.MARBLE_DICK_TYPE] > 0)
		{
			//n is the index of the PC's biggest cock under 20 area.
		 	outputText("Eventually you pull her up and sandwich her between your bodies.  Marble expresses an aversion to anal, so you take the backside while she takes the front.  \"<i>Hey, you can't do this to me!  I don't want to lose my virginity to my sister!</i>\" Clara cries out indignantly.");
		 	outputText("\n\n\"<i>Well, are you saying you've learned your lesson?  Are you going to apologize for trying to take my sweetie away from me?</i>\"");
		 	outputText("\n\n\"<i>What?  Fuck noo, your </i>sweetie<i> should be mine.</i>\"");
		 	outputText("\n\nMarble looks to the side of her sister's head, and gives you a solemn nod.  You take that as an invitation to begin the violation and grab a good grip of Clara's expansive rear.  Then you prod your " + player.cockDescript(x) + " at the entrance to her anus, prompting a gasp and plea from the woman you're about to penetrate to stop.  Her sister doesn't heed her begging, and neither do you.");
		 	outputText("\n\nThere is a sharp gasp from the girls in front of you as you push into Clara's ass while Marble takes her vagina.  \"<i>Nooo,</i>\" comes a cross between a whimper and a moan in front of you, \"<i>It wasn't suppose to be this way....</i>\"  You ignore that and instead start to push and pull inside the young cow-girl's back entrance, while enjoying the feeling of Marble's member moving in an out of the other opening against your own.  It isn't often you get to double team someone like this.");
		 	outputText("\n\nYou wipe a trickle of sweat off of your face and continue to revel in the feeling of filling up a cow-girl's wide bum, with dual stimulation from both her contractions against your member and the other shaft so close you can feel it sliding against you through the cow-girl.  At the same time, you can hear loud moaning coming from the two girls.  The familiar earthy 'ahhs' and subdued moos from Marble, along with the sharp gasps, 'oohs', and long loud moos from her younger sister.  Clara hasn't actually protested the situation for some time now, the dual penetration clearly too much for her virgin mind to endure.");
		 	outputText("\n\nSuddenly Clara's anus clamps down sharply on your " + player.cockDescript(x) + " and she lets out a long, \"<i>Moooo!</i>\" in orgasm.  She certainly came fast from this; you've barely even begun to build up your own pleasure.  You look around her to see that Marble seems to be rather surprised about this as well.  \"<i>Should we continue?</i>\" she asks somewhat uncertainly, then considers her sister again with a frown.  You shrug your shoulders and suggest that a little longer is just what you both need and well within the bounds of a reasonable punishment.  Your partner agrees, and the fucking resumes.");
		 	outputText("\n\nThis time Clara's anus is much more relaxed and accommodating to your violation.  It almost seems to invite you in when you push forward and try to keep there when you pull back.  Maybe the gangbang has brought out her natural skills at anal sex?  It's hard to say, but it's definitely enjoyable.  A quick check on the elder sister's face reveals that she is certainly enjoying this as well, but the sounds coming from the younger sister suggest that she is enjoying this the most.  Then again, it is hard to tell if that babbling is from pleasure or just from a complete mental breakdown.");
		 	outputText("\n\nIt doesn't take much longer for you and Marble to rush to your peaks and fill up the cow-girl holes together.  Clara seems to have fallen just short of her peak when the two of you pull back, and she seems to suddenly regain her composure.  \"<i>Wait, what?  Noo!  You can't just, uh....  What am I saying?!</i>\"  It looks like she's having a bit of a crisis deciding if she wants to cum or is too bothered by the thought of what just happened to her.");
		 	outputText("\n\n\"<i>Damn it all, why couldn't " + player.short + " have taken the front?  Now I'll never be able to experience it for the first time with my perfect mate!  You're evil, sister.</i>\"  Marble looks like she is about to blow up once more at that comment....");
		} //else if (PC has a cock, Marble does not)
		else if ((player.hasCock() && x >= 0) && flags[kFLAGS.MARBLE_DICK_TYPE] == 0)
		{
			//n is the index of the PC's biggest cock under 20 area.
		 	outputText("\n\nEventually you push her down on all fours.  You stand behind her, while Marble stands in front of her sister's face.  \"<i>Wait, do you actually think I'll service yoou?</i>\" Clara asks indignantly.");
		 	outputText("\n\n\"<i>You will if you don't want me to twist your ears,</i>\" comes the response.  You prod your " + player.cockDescript(x) + " up against her tight asshole and suggest that you might be taking a different entrance if she doesn't cooperate for her punishment.  \"<i>Of course, if you're sorry for what you tried to do to " + player.short + "...</i>\" Marble suggests.");
		 	outputText("\n\n\"<i>What?  Why the hell would I be sorry for that?  Moop!</i>\"  In goes your length into her virginal pussy.  \"<i>Hey!  Yo-mmph,</i>\" and she is silenced as her face is forced into Marble's womanhood.  You give her a moment to get use to the sensation, then begin thrusting into her opening in earnest.  At the same time, Marble twists her sister's ears a bit and reminds her what to do before letting out a sigh of pleasure when Clara evidently complies.");
		 	outputText("\n\nThere is no question that you're the first to claim this lady's most personal of places.  She is very tight, and the muscles contract and convulse against your intrusion reflexively and without direction.  Every thrust is met with a whole new adventure of contractions, relaxations, and unpracticed craziness.  Of course, it's quite obvious that Clara is enjoying things despite her earlier protests.  Her cunny is soaking wet.");
		 	outputText("\n\nWhile continuing to savor the unpredictableness of Clara's interior, you turn your attention to how your partner in the punishment threesome is enjoying the experience.  Unfortunately, the younger sister's inexperience with pussy licking is showing.  Marble's expression is a mix of both enjoyment and exasperation.  Hoping to give your mate a little more of the former, you grab the cow-tail that's swishing around the bountiful rear you're connect to through your cunt claiming cock, and give it a tug.  You tell Clara that she needs to do a better job of pleasing your love.  She needs to work that cow-tongue, get all the way in there and pay special attention to... this.  With that last word, you give her clitoris a little rub.");
		 	outputText("\n\nInstantly Marble's expression changes and she lets out a long low moan.  As a reward, you switch from quick thrusts to a slow rub against her entrance.  This proves to be quite a reward indeed as you feel a flood of Clara's juices spill out onto your groin from around the " + player.cockDescript(x) + " teasing her insides.  You, however, aren't finished yet.  You start a mix of both thrusting into her womanhood, and twisting your length around her innards.");
		 	outputText("\n\nA muffled, but loud, moaning moo starts to rise out of the before you, somewhat complementing the quieter sighs and gasps you're more familiar with coming from your mate.  The whole situation is incredibly lewd, and you're loving every second of it.  It isn't often that you get to have three sweaty bodies slapping and slobbering on one another.  The fact that one of them is tied up might bother you a little, if she wasn't so clearly enjoying herself.");
		 	outputText("\n\nIn fact, she is enjoying herself so much that she cums a second time before either you or Marble reach your peaks.  Still, you and Marble do manage to bring yourselves over the top just after that and ride out the afterglow together.  Clara stumbles to the ground, coughing and sputtering from the proof of Marble's orgasm while yours spills out of her lower hole.");
		 	outputText("\n\n\"<i>Gah, sis, does your milk taste as bad as your pussy juices?  No wonder " + player.short + " didn't want yoou!</i>\"  Another shock of anger shoots through Marble's features.  Is she going to try and inflict more punishment on her sister?");
		}
		//else if (PC does not have a cock, Marble does)
		else if (flags[kFLAGS.MARBLE_DICK_TYPE] > 0)
		{
		 	outputText("\n\nEventually you push her down on all fours.  You stand in front of her while Marble stands behind her sister's backside.  \"<i>Hey, you can't do this to me!  I don't want to looose my virginity to my sister!</i>\" Clara cries out indignantly.");
		 	outputText("\n\nYou grab ahold of her ears and give them a slight tug.  She'd better go along with her punishment like a good girl, or you'll be adding some extra pain onto her head.  \"<i>Of course, if you're sorry for what you tried to do to " + player.short + "...</i>\" Marble suggests.");
		 	outputText("\n\n\"<i>What?  Why the hell would I be sorry for that?  Moop!</i>\"  There is a low slurp as your mate pushes her newly acquired seven inch shaft deep inside her sister's womanhood.  \"<i>Hey!  Yo-mmph,</i>\"  You silence her with your " + player.vaginaDescript() + ", roughly forcing it into her face.  You give a slight twist to the young bovine's ears to remind her what she should be doing, and right away her tongue comes out and starts giving you experimental licks.");
		 	outputText("\n\nYou let out a sigh and see how Marble is doing.  The older cow-girl is certainly enjoying herself.  It isn't often she gets this into sex involving her cock, but the urgency of her thrusts, the blissful expression of her face, and the happy low groans and moans certainly suggest that she is enjoying herself immensely.");
		 	outputText("\n\nFor your own sexual experience, you're rather underwhelmed so far.  The malefactor's skills at oral certainly leave something to be desired.  She's barely doing much more than just lightly licking the edges, barely even teasing you.  Sensing that you aren't having a good time, Marble grabs her sister's tail and gives it a good tug.  \"<i>Hey, 'sis', I see you aren't doing a good job up there.  You damn well better work that tongue deep inside " + player.mf("him","her") + ", or I'll be using your tail as a leash.  Put that length to work!</i>\"  That little display certainly seems to have gotten the message through as the real performance now begins.");
		 	outputText("\n\nNow you feel the natural power of a cow-girl's tongue at giving pleasure to a woman's parts.  Her pussy-licker is at least twice as long as a normal human's, able to easily explore your folds and go deep inside your interior.  \"<i>Good girl, be sure to pay special attention to this little button here,</i>\" comes further instructions, accompanied by Marble reaching down under her sister's legs and fingering what must be the would-be-thief's clitoris.  You're sure that's what she just touched because it triggered a shudder through Clara's body and a loud cry of orgasm into your mound.");
		 	outputText("\n\nYou express your disappointment to Marble at her sister's unfinished performance, so the fucking continues.  Thankfully, it seems that the bad bovine did get the message and has started to tease and suck on your " + player.clitDescript() + " as well as continuing with her teases of your folds and depths.  You'd almost feel bad for doing what you two are doing to her if she wasn't evidently enjoying it as much as she is.  Muffled but loud gasps and moos are constantly being uttered into your " + player.vaginaDescript() + " by the bound girl between you and your lover.  Her breath upon your womanhood only serves to make you feel even better.");
		 	outputText("\n\nShe is enjoying herself so much that she cums a second time before either you or Marble reach your peaks.  Still, you and Marble do manage to bring yourselves over the top just after that and ride out the afterglow together.  Clara stumbles to the ground, coughing and sputtering from the proof of your orgasm while Marble's spills out of her lower hole.");
		 	outputText("\n\n“<i>Damn it all, why did you have to do that?  Now I'll never be able to experience it for the first time with my perfect mate!  You're evil, sister.</i>\"  Marble looks like she is about to blow up once more at that comment...");
		}
		else 
		//PC and Marble only have their vaginas
		{
		 	outputText("\n\nEventually you roll her onto her back.  Then Marble sits down on her sister's face while you put your mouth to Clara's womanhood and raise your " + player.buttDescript() + " up into the air so that your mate can reach your own " + player.vaginaDescript() + ".");
		 	outputText("\n\nThis little triangle is about all you can think of doing since there isn't a whole lot three girls can do to one another if one of them is tied up, that is if you're looking for everyone to get pleasure out of the experience.  \"<i>Okay, what the hell is this?  Doo you really think I'm going to actually service -mmph!</i>\"  The naughty girl is interrupted when her elder sister smothers her face in cow-girl pussy.");
		 	outputText("\n\n\"<i>If you don't do a good job of pleasing me....  Well, I can just grind myself all over your face,</i>\" your mate responds.  You offer up that you won't be letting Clara reach her peak if she does a poor job either.  To make your point clear, you give a small lick to the rim of the malefactor's mound and assure her that you'll be driving her to the edge but never let her cross over.");
		 	outputText("\n\nMarble then lifts herself slightly off her sister's face and suggests, \"<i>You know, you could get out of this whole situation if you just admit you did something wrong and say you're sorry...</i>\"");
		 	outputText("\n\n\"<i>Haven't I already told you that I was dooing the right thing?  Why would I -mmph!</i>\"  Once again she is silenced by a mouth full of another girl's snatch.  It looks like the punishment is on, and you start to mercilessly tease the cow-girl mound in front of your face.  Instantly she starts to squirm under your ministrations, desperately trying to get you to actually penetrate her or touch her emerging clitoris.  You don't give her that mercy, not yet.");
		 	outputText("\n\nNow you get to experience the pleasure of Marble's tongue starting to tease your " + player.vaginaDescript() + " with her bovine tongue.  It's easily twice the length of a human's and quite adept at pleasuring a woman's passages.  Your mate is certainly quite willing to put it to that very use, using it to plunge deep inside your depths and also expertly explore and pleasure your " + player.clitDescript() + ".");
		 	outputText("\n\nMeanwhile, the young cow-girl under your care continues to squirm and struggle more and more urgently.  You take a short break to suggest to her that all she needs to do is properly please Marble if she wants relief.  Finally, you hear an approving moan from your mate and take that as your cue to dive deep into Clara's needy nethers.  Almost instantly, a muffled but clearly audible moan of pleasure rises out of the woman.");
		 	outputText("\n\nYou let out your own moan of pleasure, the elder bovine's ministrations of your lower lips have driven you close to the edge of orgasm.  She expertly knows how to use that pussy licker of hers, grasps just what places to tease and just when to switch to what part.  Then she sucks on your love button, pushing you over the edge.");
		 	outputText("\n\nIt's around the same time that the girl under you cries out a long loud moo through Marble's womanhood, signalling her surrender to your lips.  You pull back and see your mate regard her sister with disappointment, you poke the bad bound girl in the belly and tell her to finish the job.  She gasps and returns to licking cow-girl snatch enough to bring out a nice low moan and moo from your mate's body.");
		 	outputText("\n\nYour hot and sweaty bodies separate from one another, each face bearing the fluids of one another's orgasms.  Clara is coughing and sputtering, \"<i>Gah, sis, does your milk taste as bad as your pussy juices?  No woonder " + player.short + " didn't want you!</i>\"  Another shock of anger shoots through Marble's features.  Is she going to try and inflict more punishment on her sister?");
		}
		player.orgasm();
		//proceed to calm Marble down
		menu();
		addButton(0,"Next",calmMurblesFatAssDown);
	}
	//NTR Clara
	//The PC and Marble have unusually rough and passionate sex in front of Clara, this is to show how much more real your love is to Marble.  It only serves to piss off Clara and make her jealous.
	//does not work with centaur or drider bodies.  However, I don't particularly want to just say you can't do this scene if you have them.
	public function NTRIsClearlyTheWorstFetishWhyWouldYouWriteThisOMG():void {
		clearOutput();
	 	outputText("You ");
	 	outputText("step forward and tell Marble that you think that since Clara thinks your love for one another isn't real, how about the two of you show her just how real it is?  \"<i>Good idea, " + player.short + ",</i>\" your lover tersely replies through her still seething visage and steps forwards.  In an instant you're forcibly pulled into a strong passionate kiss upon humanlike lips while a decidedly inhumanly long tongue invades your mouth.  “<i>Wait, are you two just gooing to fuck right in front of me?</i>\" comes an incredulous voice from somewhere behind the woman you're kissing.  Neither of you pay it any mind and continue to taste, devour, and lavish affection on each other's mouths.  An angry grunt comes once more from the woman you're showing what loves means to, and sounds of a struggle accompany it.");
	 	outputText("\n\nProper lovemaking does not stop at kissing.  You have to be sure to show a would be thief the whole process.  Your partner is already working on that matter through efforts to free your body from the " + player.armorName + " that contains it.  Not one to be outdone, you begin to remove the familiar top that oh-so-often holds bovine breasts at bay.  With Marble's melons free, she immediately pulls your head down into the great valley of flesh her breasts create.");
	 	outputText("\n\nFrom there, you decide it is time to let your partner lead for a while.  She is quite happy to roll her massive melons around your face while you snuggle against the wonderfully smooth skin.  Abruptly, you feel the woman whose breasts you're trapped within turn around.  \"<i>The fuck is this, sis?</i>\"  The voice is spitting mad now.  You can hear that it's behind you, evidently someone wants to make sure the audience gets a full view of your sexual escapade.");
	 	outputText("\n\nAfter a little more rack riding, Marble decides that it is time to get onto the main event.  She uncharacteristically violently forces you into a sitting position and tears the rest of your garments off.  You don't even get a chance to pull off her skirt before ");
		//if (PC has a cock that fits)
		var x:int = player.cockThatFits(marbleScene.marbleCuntCapacity());
		if (player.hasCock() && x >= 0)
		{
		 	outputText("she drops herself onto your " + player.cockDescript(x) + ".  Since your bovine mate isn't in the habit of wearing any form of undergarments, her skirt doesn't really do much to get in the way of penetration.  A shriek of dismay accompanies this act.");
		 	outputText("\n\nThere is no hesitation after you've been mounted.  Instantly you're being roughly ridden by a beast that has been awakened in Marble, and there is nothing that can stop it.  A loud slapping sound fills the air with each drop of her hips, then they rise up again and drop once more.  What is essentially a hollow jackhammer seems to be running on your lap right now, and its operator's hands are holding firm to your shoulders to make sure you stay in place.");
		}
		//else if (PC has a vagina and Marble has a cock)
		else if (player.hasVagina() && flags[kFLAGS.MARBLE_DICK_TYPE] > 0)
		{
		 	outputText("she drops herself onto the ground next to you.  Abruptly, she lifts you up and drops your womanhood onto the member you gave her.  Since your bovine mate isn't in the habit of wearing any form of undergarments, her skirt doesn't really do much to get in the way of penetration.  A shriek of dismay accompanies this act.");
		 	outputText("\n\nThere is no hesitation after you've been invaded, instantly you're being roughly lifted and dropped by a beast that has been awakened in Marble, and there is nothing that can stop it.  A loud slapping sound fills the air with each drop of your hips, only for them to be lifted up and dropped once more.  Your " + player.hipDescript() + " have been essentially turned into a jackhammer right now, and its operator shows no signs allowing you to stray from your place on her lap.");
		}
		//else if (PC has a vagina and Marble does not have a cock)
		else if (player.hasVagina())
		{
		 	outputText("she drops herself onto your legs, and grabs one of them.  Instantly, your two womanhoods are being grinded against one another with great force and urgency.  Since your bovine mate isn't in the habit of wearing any form of undergarments, her skirt doesn't really do much to get in the way of tribadism.  A shriek of dismay accompanies this act.");
		 	outputText("\n\nThere has been a beast awakened in Marble, and there is nothing that can stop it.  Loud squelching noises can be heard coming from your combined pussies as she roughly scissors you.  What is essentially a high speed vibrator seems to be running on your [legs] right now, and its operator's hands are firmly holding your them to make sure you stay in place.");
		}
	 	outputText("\n\nRough sex has a tendency to be rather short but eventful.  In this aspect, this particular escapade is no different.  What sets it apart is an incessant chorus of furious shouting and insults from an extremely jealous cow-girl.  It barely takes a minute before a sharp orgasm passes through your bodies, and in almost an instant, it is over.  Your sweaty bodies separate, and you get a chance to see Marble's face once more.  She's crying.");
	 	outputText("\n\nThe cause of this sadness is rather likely to be from the extreme verbal abuse that a woman red with rage has been heaping at her.  \"<i>What the fuck is wroong with you!?  Having sex like that with my mate right in froont of me while I'm tied up!  You deserve to be locked away, </i>sister<i>.</i>\"  That last word is essentially spat out.  Evidently Clara didn't enjoy the display, nor did Marble particularly care for her response.  The elder sister rises up, and steps towards her sister, fists clenched in furry.");
		//set lust to 0
		player.orgasm();
		//Proceed to calm Marble down
		menu();
		addButton(0,"Next",calmMurblesFatAssDown);
	}
	//Futa Marble rapes Clara
	//Similar to the threesome, but Marble is the only participant.
	public function futaMarbleIsAHugeCowToCowCuntAndStuffsCowCuntsCuntFullOfCowCock():void
	{
		clearOutput();
	 	outputText("You call out to Marble and suggest that she should use her new \"appendage\" to punish Clara.  She hesitates for a moment, then nods.  You doubt that you could have ever gotten her to do something like that if she wasn't as worked up as she is.");
	 	outputText("\n\n\"<i>What new appendage?</i>\" Clara asks in apprehension, a picture of fear now painted across her face.  Marble lifts up her skirt and reveals her growing erection.  \"<i>What the hell?!</i>\" is the response to this revelation.  Under normal circumstances, your mate is filled with trepidation when it comes using her seven inch cock.  Now, she only shows eagerness when she pushes Clara onto her back and positions her sister's legs against her torso.  \"<i>No, no, no, I'm not about to looose my virginity to my sister, I'm not about to looose my virginity to my sister.  DAMN IT MARBLE, STOP!</i>\"");
	 	outputText("\n\nThe older sister hesitates for a moment, \"<i>Are you sorry for trying to steal " + player.short + " from me?</i>\"");
	 	outputText("\n\n\"<i>What?  No, why would I be?</i>\"");
	 	outputText("\n\nMarble squats down in front of her sister's vaginal virgin opening.");
	 	outputText("\n\n\"<i>Hey, you can't do that!  I was doing you a favor!  AYEEEE!</i>\"  Futa cock meets an entrance that has never known an intruder before.  Clara gasps and pants in shock as her sister offers a few moments of reprieve.  Then that sister starts to thrust into her defiled opening.");
	 	outputText("\n\n\"<i>Wha, maa, no please!</i>\"  Evidently, her wishes are not going to be met, despite her renewed and furious struggle against her bonds.  The younger sister's punishment will continue so long as she refuses to change her tune, and that tune seems to be quite difficult to change.  Even so, it sounds like her body is really enjoying the treatment, much to her dismay.  Each of the powerful thrusts into Clara's openings are making her moan in pleasure while, at the same time, she continues to weep at the shame of it all.");
	 	outputText("\n\nFor her part, Marble seems to be enjoying this on several levels.  She is definitely eager to punish her sister, and at the same time, the still unfamiliar pleasure of having a dick rubbing and sliding around inside a pussy is making her give her own song of ecstasy.  You put a good effort into watching and making sure the punishment is done properly, at least that's what you tell yourself.  You're not exactly the most attentive to the sex, but the swaying and bouncing of their massive mammaries with each movement is mesmerising.");
	 	outputText("\n\nYour mate's carefully paced thrusts are becoming more and more frantic, bringing out louder and louder moans from the younger cow-girl.  \"<i>Maa, what, ooo, haa.</i>\"  She can't even raise her voice in protest anymore.  The first-timer is far too blown away from the feeling of the sex.  She still struggles against her bonds, but you think that she's more likely trying to play with her wildly bouncing breasts.  Loud squelching accompanies the sexual sounds coming off the two sweaty girls, one tied up and the other humping.  Both are making similar sounds at this point, but it isn't too hard to tell them apart.  The younger sister's have a much stronger cow blend to them, while Marble's are much quieter.");
	 	outputText("\n\nA loud, \"<i>MOOOO!</i>\" abruptly rises in crescendo out of the random moans, gasps, and gibbering mess that use to be Clara.  However, her sister doesn't stop with that orgasm and continues to pound away, bringing back the babbling wreck for a few more moments.  Then, Marble's own orgasm rises out in her characteristic gasp and long low moan.  A much more subdued moo then the younger sister's.");
	 	outputText("\n\nThe futa in this equation pants for a few moments, then asks, \"<i>Have... you, ha... learned your lesson now?</i>\"  When the answer comes in an incoherent moan, it looks like Marble might be about to start round two!");
	 	dynStats("lus",20);
		//proceed to Calm Marble down
		menu();
		addButton(0,"Next",calmMurblesFatAssDown);
	}
	//Calm Marble down
	//The end to all other punishment scenes, or if the player doesn't want to punish Clara.
	public function calmMurblesFatAssDown():void
	{
		clearOutput();
	 	outputText("That's enough.  You put your hand on Marble's shoulder and she turns to you in surprise.  Her body is still shaking with barely controlled rage, eyes filled with pain and anger mixed together, the flood of tears is just barely kept at bay.  You tell her to calm down and take a deep breath while wrapping your arms tightly around her body.  Instantly her body freezes in place for several moments, then she bursts into tears and ");
		//if ((PC taller than 6'8" and Marble not cow-morph) or (PC taller than 7'2" and Marble cow-morph))
		if ((player.tallness >= 80 && flags[kFLAGS.MARBLE_BOVA_LEVEL] < 2) || (player.tallness >= 86 && flags[kFLAGS.MARBLE_BOVA_LEVEL] >= 2))
		{
		 	outputText("tightly hugs herself against your body.  Gently stroking her hair, you're happy to be a shoulder for her to cry on, given both your affection for the gentle girl and the awareness that you're able to help her feel better.");
		} 
		//else if (PC taller than 5 feet)
		else if (player.tallness >= 60)
		{
		 	outputText("returns the hug.  Rocking back and forth against one another, you're happy to be here for her, given both your affection for the lovely lady and the warm feeling of being so close to one you care so much for.");
		}
		else
		{
		 	outputText("scoops you up, hugging you tightly into her chest.  Sandwiched between her massive mammaries, you're happy to serve as her temporary comfort doll, given both your affection for the big bovine and the pleasant accommodation of her bountiful breasts.");
		}
	 	outputText("\n\nEventually the two of you separate, and you get a chance to see Marble's face once more.  While her eyes are red, puffy, and rimmed with tears, they shine with joy, matching the great smile on her lips.  \"<i>Thank you sweetie, without you, I would have been more like... her,</i>\" she indicates her sister, a small frown once again creasing her features.");
	 	outputText("\n\nYou suggest that now would probably be a good time to check on Rathazul, before deciding what to do with Clara.  \"<i>Good idea, it will give me some time to clear my head.</i>\"  The two of you leave the tied up bovine where she is and head over to the elderly alchemist's side of the camp.");
		//Proceed to Rathazul finishing Marble's Potion.
		menu();
		addButton(0,"Next",rathazulFinishingMarblesPotion);
	}
	//Rathazul Finishing Marble’s Potion
	public function rathazulFinishingMarblesPotion():void
	{
		//Initial check
		clearOutput();
	 	outputText("The rather colorful events of the morning seem to have gone largely unnoticed by the elderly rat.  He is uncharacteristically engrossed in the whitish bubbling formula in front of him, so much so that he doesn't actually notice when you and Marble come up to him.  The two of you are surprised that he doesn't address your presence at all.  It's several moments before you clear your throat and announce your presence.  Starting, the camp's alchemist turns to you blinking in confusion for another moment, then addresses you, \"<i>Ah, " + player.short + ", Marble.  Good news, you two!  This will likely be very potent and capable of purifying cow-girls in very small doses.  Even those who have not yet been fed doses of purified LaBova.  However, it may not be effective on those unrelated to you.</i>\"");
	 	outputText("\n\n\"<i>So does that mean it is ready?</i>\" your mate asks.");
	 	outputText("\n\n\"<i>No, not quite yet.  The process should be done in about half an hour.  ");
		//if (PC has kids with Marble)
		if (flags[kFLAGS.MARBLE_KIDS] > 0)
		{
		 	outputText("Then we'll be ready to purify you and your child");
			if (flags[kFLAGS.MARBLE_KIDS] > 0) outputText("ren");
		 	outputText(".  ");
		}
	 	outputText("So come back a little later.</i>\"  The rodent returns to his reactions.");

	 	outputText("\n\nYou turn to your cow-girl lover and ask her what she'd like to do in the meantime.  She hesitates, visibly bothered by something.  \"<i>Actually, I think I need some time on my own to think about what my sister said.  Come and get me when the formula is finished, okay?</i>\"  You nod and she heads off to the edge of the camp.");
	 	outputText("\n\nYou've got some time to kill now, you guess.  Is there something you want to spend it doing?");
	
		menu();
		addButton(0,"Next",theFormulaIsDone);
	}
	//Let Marble know the formula is done
	public function theFormulaIsDone():void
	{
		clearOutput();
	 	outputText("Rathazul tells you that the formula is ready, so you head over to Marble to let her know.");
		//Scene adapted from Rayfire's scene
	 	outputText("\n\nYou find her sitting on a ruined low stone wall at the edge of camp, still deep in thought.  It takes a few moments for you to scramble up next to her, and you take a seat just a short ways from her.  She gives a hard sigh and fiddles with her brown hair a bit before resuming her long thought. It's not until you tap her shoulder and call out her name that she turns to you with a startled look.  \"<i>S-Sweetie!</i>\" she calls out in a surprised manner and looks up at you, eyes lidded with dried tears.  You ask if she minds you sitting next to her and she agrees half-heartedly.  You both sit in silence for a few minutes before she brings up the courage to even utter a word to you.");
	 	outputText("\n\n\"<i>S-So sweetie, how is your condition, are you okay?</i>”  You assure her you're okay, nothing you haven't dealt with before.  \"<i>Oh that's great, I've been worrying about that for a while now.</i>\"  She looks at you and gives a forced smile.  \"<i>Rathazul has finished the potion now I take it?  You came to pick me up?</i>\"  Marble starts to get up, but you stop her and grab her hands when you realize that they are trembling severely, both out of nerves and worry. It's in her face that you can see that the poor bovine woman was putting up a front, masking the pain she feels while trying not to worry you.");
	 	outputText("\n\nYou calmly tell Marble that you're quite certain that she wouldn't have come out here to think on her own for so long if all she was worried about was your condition.  There is something else bothering her, something that she doesn't want you to worry about.  You're here for her just as she is there for you.  You ask her to just tell you what is wrong.");
	 	outputText("\n\nMarble's forced smile fades and her features resume the crestfallen look she had earlier, thinking about the right words to say to you.  Seeing as there is no other way around the conversation she says, \"<i>To be honest sweetie, you're right, I'm not all right.</i>\"  There is a moment's hesitation before she continues, \"<i>Oh " + player.short + ", so much has happened in such a short time and it's all that's on my mind. After all the things that Clara has said I just don't know what to do.</i>\"");
	 	outputText("\n\nYou recall everything that Clara has revealed and ask Marble if it's about her parents and her race.  \"<i>Yes, hearing about how my father's addiction was like and the way my mother used it to manipulate him, my race's methods to find a mate, and finally thinking about my own instincts and desires, then it all falls together.</i>\"");
	 	outputText("\n\nYou feel a sense of dread as she says that, but you tell her to go on.  \"<i>Well for starters, I really don't want to believe that daddy would train me just because mother forced him into it.  I've always thought that daddy wanted to train me because he was worried about the dangers I would face on my own one day, especially with the corruption spreading over the years.  When I left home, I felt that he was proud of my abilities.  The idea that he would train me only because my mother forced him to because he needed her milk to survive is something I would never have believed until today.</i>\"");
	 	outputText("\n\nYou tell her that even if that was true, her father still taught her out of love and concern.  She can't deny that she had some good memories of her dad teaching her how to swing a hammer.");
	 	outputText("\n\n\"<i>But sweetie, that's just the thing.  Do you know how hard it is for a small girl to keep a giant hammer in her hands after it hits something?  Dad had infinite patience with me, no matter how many times I screwed up.  Mother was always there when we were training, watching.  Sometimes when I dropped my practice mallet in a heavy swing, dad would look over his shoulder nervously and lick his lips, take a deep breath, and tell me to keep at it.</i>\"");
	 	outputText("\n\nShe takes in another breath of air and deeply sighs, then fixes you with a stern look.  \"<i>Sweetie, I want you to know that I don't agree with everything that Clara had said, but some things I can't deny.  I saw what you were like while addicted to me, and I know what kind of an effect that can have.  It isn't too much of a stretch to think what years of that could do to someone.  What bothers me the most right now is that I never actually knew my real dad.  No one could really have been that perfect of a parent.  All I knew was what my mother turned him into through her milk.</i>\"");
	 	outputText("\n\n\"<i>The day when I met you, I felt that you were just one of the cutest things that I've ever seen.  I immediately took a liking to you after you helped me out with my breasts.  You spent time with me, talked to me, worked alongside me, and every day my affection for you grew stronger.  I didn't think it was love at first, but everyday I looked forward to a visit from you.</i>\"  You give a warm smile hearing those words from her, happy to know your feelings were mutual as your relationship advanced.  \"<i>I was so happy when you agreed to drink the milk directly from my breasts.  It made me so happy to nurse someone like that again and remember the utter bliss I felt from that.</i>\"");
	 	outputText("\n\n<i>\"Unfortunately that time didn't last long and before I knew it I had addicted you.  ");
		//if (PC said they wanted to be addicted)
		if (player.statusEffectv3(StatusEffects.Marble) == 1)
		{
		 	outputText("When you said that you wanted to rely on my milk, it felt like you'd just given me the world.  Then, the power I suddenly held over you made my instincts kick in, and I started to turn into something like my mom.  When you resisted, it felt like a betrayal, but my love for you proved stronger than that.  The day you stopped me from slipping away for good, when you revealed your feelings for me, that you cared more about me than my milk, I felt wonderful, and my love for you blossomed full bloom that day.  ");
		}
		else
		{
		 	outputText("When you told me why you couldn't rely on my milk, the memories of all who I let drink directly from my breasts hit me all at once, and I didn't know what to think about all that.  What saved me was your love.  It went beyond the bliss of giving milk, and I thought that it was all I'd actually need.  The day you stopped me from running away for good, when you revealed your feelings for me, that you cared more about me than my milk, I felt wonderful and my love for you blossomed full bloom that day.  ");
		}
	 	outputText("Of course, you know what happened next,</i>\" she sighs.");

	 	outputText("\n\nYou remember; that's how the whole effort to purify her started in the first place.  It's what brought Clara to your camp.");
	 	outputText("\n\nMarble laughs, \"<i>I barely lasted a few days....  You know how it bothers me when I can't nurse you like any other Lacta Bova out there?  As Clara said, I do want to addict you to my milk and fully mark you as mine.  I want to make sure I'm the only woman to share a bed with you and keep you all to myself.  Every day, I have to fight my instincts not to just push you down and force my milk down your throat.  The milkers help ease the burden some, but they can only do so much for me.</i>\"");
	 	outputText("\n\n\"<i>The most troubling part about all this is that I think of what my mom did to my dad, and that I would have done the same thing to you.  If you had become addicted to me, I wouldn't have even realized I was doing it either.  You would have been slowly twisted into my perfect mate, and as sick as that sounds, I genuinely want that.  Almost every part of my being wants that so much.  Ever since I was a little girl, I've dreamt of having a mate just like daddy...</i>\"");
	 	outputText("\n\nMarble looks at you once more, somewhat passively.  You swear her expression is that of someone waiting for her execution.  \"<i>So, " + player.short + ", now you know the real me.  Can you still love me?</i>\"  You reach out to your lover's face and caress her cheek.  She then takes your hand and holds it tight against her face. In an instant, her stoicism shatters, and tears look to be on the verge of streaming down her face once more.  You tell her that everything will work out; it'll just take one step at a time.");

	 	outputText("\n\n\"<i>B-But sweetie...!</i>\"  You reassure her that even if what Clara said had some truth to her words, even if she said your relationship with Marble was only a one-sided romance, it wouldn't change the fact that you love her with all your heart.  Even if she did addict you to her milk, you would have stayed by her side and continued to love her.  You once again tell her it was her you were in love with, not what she could give you, and nothing would change that fact.");
	 	outputText("\n\nMarble bursts into tears and pulls you into a nearly back-breaking hug, calling out your name and declaring her love for you as she continues to embrace you.  She gives you a deep kiss and you return it wholeheartedly.  When she finally lets you go, she jumps down from the wall, giving you a delightful, beautiful smile.  \"<i>You really are too good for me, " + player.short + ".  I feel a lot better now.</i>\"");
	 	outputText("\n\nYou jump down as well, smiling back, then laugh and remind Marble that she needs to remember that soon, all her instincts will be washed away, and she'll be able to live her life the way she thinks is right, not the way that Clara thinks is right, not the way her mother thinks is right, not the way her race thinks is right.  Marble will be living Marble's life the way that Marble thinks is right.  Plus, maybe you'll just start a race of pure cow-girls with her?  The smile on Marble's face only gets bigger at this.");
	 	outputText("\n\nJust before you leave, you see Marble's expression darken once more.  \"<i>I know I want to change my race, but what about the other Lacta Bovines out there?</i>\"  Couldn't they purify themselves as well?  \"<i>Well, some of them can, but any that already have people addicted to them are out.  They'd be killing their mates, since they need to drink the addictive stuff to survive.  Plus I don't think all of them would want purification.\"</i>  You suppose if they warn people and only addict people that are willing, that would be fine.  The two of you start the short trip back across the camp.");
	 	outputText("\n\nMarble snorts, \"<i>Then we have people like Clara.  She takes the evils of my race to a whole new level.  What are we going to do with her?  I don't want to keep her prisoner, but if we let her go, she'll just find someone else to addict.</i>\"");
	 	outputText("\n\nWe could cut the monster's claws, you suggest.");
	 	outputText("\n\n\"<i>You mean, purify her?  That's brilliant!  Goddess knows, if anyone deserves that, it's her.  We won't have to lock her up to know she's safe, and she'll have to find something better to do with her life then getting slaves!</i>\"");

		//continue to Marble is purified
		menu();
		addButton(0,"Next",purifyMarbleComplete);
	}

	//Marble is purified
	public function purifyMarbleComplete():void
	{
		clearOutput();
	 	outputText("The two of you arrive at Rathazul's workspace, and find the owner awaiting you, holding a bottle of whitish fluid with gold streaks running throughout.  \"<i>So is that the formula?</i>\"  Marble asks looking at the bottle.");
	 	outputText("\n\n\"<i>Yes is it, one dose, and you'll be freed of the corruption from your body.  I was surprised at how effective it seems to be.</i>\"");
	 	outputText("\n\nMarble holds her hand out, prompting Rathazul to grab an empty cup and pour a small amount of the fluid into it.  She takes the cup from him and gives a sniff of the bizarre liquid, then prepares to drink.  You stop her and suggest that she should take her top off so that the problem of milk streams don't come up again.  Marble nods and thanks you for reminding her and hands you the cup.  She then pulls off her plain top, letting out her massive mammalia.");
	 	outputText("\n\nActually, now that you consider her breasts, you notice that they actually seem to be a bit smaller than they use to be.  Perhaps that was a side effect of the purification process?  Well, not something to worry about too much, there are ways to change one's body in this world.");
	 	outputText("\n\nWith her top out of the way, you return the cup and Marble once again prepares to drink.  After a few moments of her just staring at the cup, you suggest that the longer she waits for it, the harder it will be.  \"<i>Yeah, thanks sweetie,</i>\" she replies halfheartedly, then sighs, lifts up the cup, and downs the contents.");
	 	outputText("\n\nYour bovine lover grimaces at the taste and hands the cup back to Rathazul.  Her lips move from side to side, and her brow furrows in uncertainty as the effects of the potion start to play out.  As was expected, the first thing that happens is a stream of milk pouring out of her breasts, though not as strong as the ones from the purified LaBova.  This one is shorter and more subdued.  However, you can visibly see her breasts shrinking as the milk comes out.");
	 	outputText("\n\nShe then grabs her breasts in surprise, and seems to weigh them, getting a feel for the change.  \"<i>Can't say I'm too happy about this...</i>\" she mutters.  Then there is a sharp intake of breath, and her eyes go wide.  Her body starts to sway and then fall over.  Thankfully, you're easily able to catch her and gently lower her body to the ground.  Checking her yields the same wide eyes and unfocused expression.");
	 	outputText("\n\nYou call out to her in worry, begging for her to come back to you.  After a moment, her eyes go back into focus, and you hear her voice call out hesitantly, \"<i>" + player.short + "?</i>\"  You let out a sigh of relief and ask how she feels.  \"<i>I feel... different.  Like I'm seeing the world for the first time.</i>\"  You help her to her feet.  \"<i>I guess that makes sense, I was born corrupt, so being purified is something I've never felt before.  It'll be a while before I can really give you an idea of what this is like.  What I can say is that my mind feels... clean, free.</i>\"");
	 	outputText("\n\nWell, there is one way to know for certain, and you offer to give her pure milk a taste test.  \"<i>Ah, you don't know how good that offer makes me feel sweetie, come on!</i>\"  You don't need to be told twice, in an instant you're upon her breasts.  For a moment after your lips wrap around her sweet teats, nothing meets your tongue.  Fear that perhaps Marble has become dry fills you, then, a trickle of flavor caresses your tongue.  A new milk is coming out, different from the old drugged stuff that is so familiar to you.  There is no mistaking it; it is pure, safe, and delicious.  You draw back, smile at Marble, and relay this revelation.  Marble laughs, \"<i>I'm sorry that I haven't got too much to give right now, but just give me a little time, and I'll give you a delicious feast of pure Lacta Bovine breastmilk.</i>\"");
	 	outputText("\n\n\"<i>Then good news!  The experiment was a success!</i>\" Rathazul suddenly cries out, interrupting your heart to heart.  Ah well, there wasn't much else to say anyway.");

		//if (PC has had kids with Marble)
		if (flags[kFLAGS.MARBLE_KIDS] > 0)
		{
			//Purifying kids
		 	outputText("\n\n\"<i>Now that we know it works, we should purify your child");
			if (flags[kFLAGS.MARBLE_KIDS] > 1) outputText("ren");
		 	outputText(" right away.  Give ");
			if (flags[kFLAGS.MARBLE_KIDS] == 1) outputText("her");
			else outputText("each");
		 	outputText(" a two drop dose,</i>\" the alchemist instructs you and hands over the bottle of his formula.");

		 	outputText("\n\nYou and Marble waste no time in heading over to the nursery and feed ");
			if (flags[kFLAGS.MARBLE_KIDS] > 1) outputText("each of ");
		 	outputText("your child");
			if (flags[kFLAGS.MARBLE_KIDS] > 1) outputText("ren");
		 	outputText(" two drops of the formula.  ");
			if (flags[kFLAGS.MARBLE_KIDS] > 1) outputText("They ");
			else outputText("She ");
		 	outputText("take");
			if (flags[kFLAGS.MARBLE_KIDS] == 1) outputText("s");
		 	outputText(" it easily enough, and while there are no outward effects, ");
			if (flags[kFLAGS.MARBLE_KIDS] == 1) outputText("your ");
			else outputText("each ");
		 	outputText("child does report feeling like something was lifted from ");
			if (flags[kFLAGS.MARBLE_KIDS] > 1) outputText("their");
			else outputText("her");
		 	outputText(" mind.");

		 	outputText("\n\nIt's with very light hearts and spirits you and the father of your children return to report the results of the formula.  \"<i>Excellent!  I will be sure to watch them closely to be sure that there are no lingering effects, but you and your family are likely now the first pure bovine-kin on Mareth in a long time.</i>\"");
		}
		//continue to Dealing with Clara
		menu();
		addButton(0,"Next",dealingWithCowCuntPostPurification);
	}

	//Dealing with Clara
	//She can be made to promise to never try and take the PC again, and then sent away.  She can also be forcibly purified with Rathazul's formula, forever making her incapable of addicting the PC or anyone else to her milk.  A later expansion that brings her back or have her be found somewhere else can be written.
	public function dealingWithCowCuntPostPurification():void
	{
		clearOutput();
	 	outputText("Now there is only one more loose end in this whole effort to purify Marble: her sister.");
	 	outputText("\n\nShe is still laying on the ground, tied up next to the firepit.  Fittingly, a couple of discarded cups lay next to her, and her tea pot lays overturned at her feet.  Your return does not go unnoticed.  \"<i>Finally remembered me, huh?  You damn evil people, do you have any idea what kind of a person I am?</i>\"");
	 	outputText("\n\n\"<i>The kind who thinks they deserve the world thanks to a parent spoiling them horribly as a child,</i>\" Marble responds.  \"<i>However, you do deserve one thing.  Thank you, sister, for giving me your milk.  I've been purified now, and my milk is safe for anyone to drink.</i>\"");
	 	outputText("\n\n\"<i>Congratulations!  You're not a Lacta Bovine anymore.  It isn't like I was trying to stop you from doing that, but now you sure as hell don't deserve a mate anymore.  You can't even claim one.</i>\"  Clara turns her attention to you, \"<i>Did you hear that, " + player.mf("lover-boy","lover-girl") + "?  You don't deserve a pseudo Lacta Bovine like her.  I can give you want you really want.</i>\"");

	 	outputText("\n\n\"<i>I can't believe this Clara, why are you even bothering at this point?</i>\"");
	 	outputText("\n\n\"<i>Fuck off, mutant,</i>\" she dismisses her sister in an instant.  \"<i>I want to tell my destined mate what kind of a life " + player.mf("he","she") + " is missing out on!  I know you still want true Lacta Bovine milk.  Once you've tasted it, you'll know that you truly want it forever.  Come away with me, be my slave, and you'll be truly happy again!</i>\" A sick smile plays over her face, her madness clear for all to see.");
	 	outputText("\n\nMarble sighs, then speaks once more, \"<i>I figured you should know at least that, sister, before we decided what to do with you.</i>\"  She turns to you, \"<i>Well, " + player.short + ", you were the one she tried to kidnap and enslave.  What do you think we should do with her?</i>\"");
	 	outputText("\n\nAs you and Marble were discussing before, purifying Clara would be a very fitting punishment for her.  It will forever prevent her from ever addicting anyone to her, and you won't need to worry about letting her out.  Of course, she certainly won't like that one bit.");

		//PC chooses to purify or not to purify.
		menu();
		addButton(0,"Purify",purifyMurblesSister);
		addButton(1,"Don't",dontPurifyClara);
	}

	//Purify
	public function purifyMurblesSister():void
	{
		clearOutput();
	 	outputText("You ask Marble for the bottle of Rathazul's formula.  She nods, hands it to you and says, \"<i>Yeah, I think that's the best choice too.</i>\"");
	 	outputText("\n\nYou approach the bound form of Clara and inform her that you're prepared to untie her.  She just has to drink a few drops from the bottle you're holding.");
	 	outputText("\n\nShe considers the bottle, then curls her lip.  \"<i>What, yoou got something in there to break my mind?  Some sort of corrupt juice?  Whatever, it isn't like I've got much of a choice,</i>\" comes the sarcastic reply.  Nevertheless, she does drink several drops without complaint.");
	 	outputText("\n\nA few moments later, you calmly inform Clara that she just drank the fluid that was used to purify Marble.  Since it was made partially from her milk, it should be quite effective on her.  A look of absolute horror slowly spreads across her face and she panics, struggling against her bonds with all her strength, desperate to stop what is about to happen.");
	 	outputText("\n\nEvidently, the purified LaBova did get Marble through the worst of purification.  A huge gush of milk starts to pour out of the bound bovine's breasts, flooding the ground around her.  At the same time, she lets out a huge, \"<i>Noooooo!</i>\" as the corruption is banished from her body along with the precious addictive nature of her milk.  \"<i>You can't do this to me!  This is who I am!  You have no right to take that away!</i>\"");
	 	outputText("\n\nGiven that she just tried to take away someone else's life, any right she might have had to choose her own life is probably gone.  This will give her plenty of time to reflect on what she's done, and is probably far more effective than any form of sexual punishment would have been.  You don't hesitate to tell her this.");
	 	outputText("\n\nWhen the process finishes, Clara is remarkably silent, and doesn't offer any more resistance to her bonds.  Now the question is what to do with her.");
	 	outputText("\n\nYou guess you could also build a cage in the camp if you really want to keep an eye on her yourself.  That will make her another mouth to feed, and you'll have to hear her ranting every day.  Still, the saying does go, \"keep your enemies closer.\"");
	 	outputText("\n\nIf you're feeling especially generous, you could just let her go, with not more than a promise to never come back or try to kidnap you again.");
	 	flags[kFLAGS.CLARA_PURIFIED] = 1;
		//PC makes their choice: Tel'Adre, camp cage, let go."
		menu();
		addButton(0,"Cage",cageDatCowCunt);
		addButton(1,"Let Go",letGoOfMarblesCowCuntSister);
	}

	//Camp Cage
	public function cageDatCowCunt():void
	{
		clearOutput();
	 	outputText("You say that you're going to be keeping Clara a prisoner in the camp.  She deserves to be imprisoned so she'll no longer be a threat to anyone anymore.  Marble looks uncertain at you and asks if you're sure she needs to be locked up now that she's been purified.  You say you're certain, and your mate nods to you and says that she trusts your judgment on this matter.");
	 	outputText("\n\nIt takes you and Marble about an hour to fashion a cage out of logs from the forest thanks to her excellent carpentry skills.  You then untie Clara from her bonds and put her into her new home.  She'll be in there for some time, but at least you know she won't be able to hurt anyone that way.  The purified cow-girl offers no resistance this whole time, and is eerily silent once inside her cell.  You do occasionally catch her angrily staring at you.");
	 	flags[kFLAGS.CLARA_IMPRISONED] = 1;
		//Clara is marked as having been purified and caged in camp.
		//continue to purification quest final
		menu();
		addButton(0,"Next",purificationQuestFinal);
	}
	//Let go
	public function letGoOfMarblesCowCuntSister():void
	{
		clearOutput();
	 	outputText("You say that now that Clara is no danger to anyone any more, she is free to go, so long as she promises to never bother you or your followers again.  Marble nods at this and says she agrees with your decision.");
	 	outputText("\n\nYou and Marble untie Clara from her bonds, give her her things, and escort her out of the camp.  She doesn't even look at either of you until she is at the edge and you tell her to leave and never come back.  She gives you one look, a look of pure rage and anger, of one who is swearing vengeance, then as soon as it started, it is over.  She steps out of the camp, and warps away into the world.");
		//Clara is marked as having been purified and released.
		//continue to purification quest final
		menu();
		addButton(0,"Next",purificationQuestFinal);
	}

	//Don't purify
	public function dontPurifyClara():void
	{
		clearOutput();
	 	outputText("No, you'll offer her the mercy of letting her keep her precious corruption.  Marble tells you she will respect your decision on that matter.  Now the question is what to do with her.");
	 	outputText("\n\nYou guess you could also build a cage in the camp if you really want to keep an eye on her yourself.  That will make her another mouth to feed, and you'll have to hear her ranting every day.  Still, the saying does go, \"keep your enemies closer.\"");
	 	outputText("\n\nIf you're feeling especially generous, you could just let her go, with not more than a promise to never come back or try to kidnap you again.");
		//PC makes their choice: Tel'Adre, camp cage, let go."
		menu();
		addButton(0,"Cage",stickUnpurifiedClaraInACage);
		addButton(1,"Let Go",letCorruptCowCuntGo);
	}

	//Camp Cage
	public function stickUnpurifiedClaraInACage():void
	{
		clearOutput();
	 	outputText("You say that you're going to be keeping Clara a prisoner in the camp.  She deserves to be imprisoned so she'll be no threat to anyone anymore.  Marble nods to you and says that she trusts your judgment on this matter.");
	 	outputText("\n\n\"<i>So that's it then.  You're just going to lock me up in a cage?  You can't do that!  I'm fucking Clara, daughter of Hana!  You can't just throw me in a damn cage!</i>\"  Despite her protests, she can't offer any real resistance, bound as she is.");
	 	outputText("\n\nIt takes you and Marble about an hour to fashion a cage out of logs from the forest thanks to her excellent carpentry skills.  You then untie Clara from her bonds and put her into her new home.  She'll be in there for some time, but at least you know she won't be able to hurt anyone that way.  The bars certainly don't do much to cut out the noise of her taunts and demands, unfortunately.");
		//Clara is marked as having not been purified and caged in camp
		flags[kFLAGS.CLARA_IMPRISONED] = 1;
		//continue to purification quest final
		menu();
		addButton(0,"Next",purificationQuestFinal);
	}

	//Let go
	public function letCorruptCowCuntGo():void
	{
		clearOutput();
	 	outputText("You say that you're going to let Clara go, but she has to promise to never return, bother you or anyone in your camp ever again.  Marble gives you a look of shock and asks if you're absolutely certain you want to do that.  When you give her the affirmative, she sighs and says that she'll trust your judgment on this matter.");
	 	outputText("\n\n\"<i>Really?  After all that, you're just going to let me go?  Fine.  I promise to never return or bother any of you ever again.</i>\"");
	 	outputText("\n\nYou release her from her bonds, give her her things, and escort her from the camp.  She gives you a wicked smile, then steps out of the camp and warps away.  You hope that wasn't a mistake.");
		//Clara is marked as having not been purified and released
		//continue to purification quest final
		menu();
		addButton(0,"Next",purificationQuestFinal);
	}

	//Purification quest final
	public function purificationQuestFinal():void
	{
		clearOutput();
	 	outputText("\"<i>It has been quite the morning, hasn't it sweetie?</i>\"  It certainly has been, but at least now, your lover is finally free of her corruption once and for all.");
	 	outputText("\n\nYou've gained 500 exp for helping Marble attain purity.");
		//increase exp by x
		player.XP += 500;
		//Marble corruption is set to 10
		flags[kFLAGS.MARBLE_PURIFICATION_STAGE] = 5;
		flags[kFLAGS.MARBLE_PURIFIED] = 1;
		player.changeStatusValue(StatusEffects.Marble,4,10);
		getGame().inCombat = false;
		player.clearStatuses(false);
		//Marble's breast size is set to 0 (integer, 0=DD cups, 1=G cups, 2=HH, 3=J)
		//advance time of day by 4 hours
		//end event
		doNext(camp.returnToCampUseFourHours);
	}

	//Purified Succubus milk
	//Used to increase Marble's bust size.
	public function purifiedSuccubusMilkForPureMarbles():void
	{
		clearOutput();
	 	outputText("Do you want to ask Marble to grow her breasts bigger?");
		//PC chooses yes or no
		menu();
		addButton(0, "Yes", actuallyGrowPureMarblesTittiesForFunzies);
		addButton(1, "No", marbleScene.giveItem);
	}
	//if yes
	public function actuallyGrowPureMarblesTittiesForFunzies():void
	{
		clearOutput();
	 	outputText("You offer Marble a bottle of purified succubus milk and tell her that you'd like her to make her bust bigger.");
		//if (Marble's breast size < 3)
		if (flags[kFLAGS.MARBLE_BREAST_SIZE] < 3)
		{
		 	outputText("\n\n\"<i>Alright, if you say so.</i>\"  Marble lifts the bottle to her mouth, and drinks the substance down.  She lets out a soft sigh and starts massaging her bouncy tit flesh as it expands outwards.  Through her shirt, you can see her " + kGAMECLASS.marbleScene.marbleBreastSize() + " breasts balloon into ");
			//increase Marble's breast size by 1
			flags[kFLAGS.MARBLE_BREAST_SIZE]++;
			outputText(kGAMECLASS.marbleScene.marbleBreastSize() + " melons!");
			//if (Marble's breast size == 1)
			if (flags[kFLAGS.MARBLE_BREAST_SIZE] == 1)
			{
			 	outputText("\n\nYour mate examines her now larger bust, and gets a feel for it.  \"<i>Hmm, not quite what I'm used too, but it's better than those tiny things that I used to have.  Thank you sweetie!</i>\"");
			}
			//else if (Marble's breast size == 2)
			else if (flags[kFLAGS.MARBLE_BREAST_SIZE] == 2)
			{
			 	outputText("\n\nYour mate gives her chest a shake, then smiles happily.  \"<i>Thank you so much sweetie!  Now this feels much better, a good balance, nice weight, and just think of what I could do to you with these girls.</i>\"");
			}
			else
			{
			 	outputText("\n\nYour mate tentatively grips her massive mammaries.  \"<i>Wow, sweetie, isn't this a bit much?  I don't think I'll grow my girls any more than this.</i>\"  She stretches her shoulders a bit.  \"<i>Ow, I hope this pain in my shoulders doesn't last...</i>\"");
			}
			//remove a bottle of pure succubus milk from the PC's inventory
			player.consumeItem(consumables.P_S_MLK);
			//increase Marble's lust by 5
			flags[kFLAGS.MARBLE_LUST] += 5;
			if (flags[kFLAGS.MARBLE_LUST] > 100) flags[kFLAGS.MARBLE_LUST] = 100;
		}
		else
		{
		 	outputText("\n\n\"<i>Sorry sweetie,</i>\" she says handing the bottle back to you, \"<i>I think my breasts are big enough as they are.</i>\"");
			//no effect
		}
		doNext(marbleScene.giveItem);
	}

	//Reducto
	//Used to shrink Marble's breasts
	public function pureMurbleUsesReducto():void
	{
		clearOutput();
	 	outputText("Do you want to ask Marble to shrink her breasts down?");
		menu();
		addButton(0, "Yes", pureMurblePCChoosesYesToShrinkeyTits);
		addButton(1, "No", marbleScene.giveItem);
	}

	//if yes
	public function pureMurblePCChoosesYesToShrinkeyTits():void
	{
		clearOutput();
	 	outputText("You offer Marble a jar of reducto and tell her you'd like her to reduce her bust's size a bit.");
		if (flags[kFLAGS.MARBLE_BREAST_SIZE] > 0)
		{
		 	outputText("\n\n\"<i>Alright, if you say so.</i>\"  Marble opens the jar of reducto, lifts up her top, and slathers the green gel onto her breasts.  She lets out a soft sigh as the substance takes effect, and her tremendous " + kGAMECLASS.marbleScene.marbleBreastSize() + " tits slowly shrink in size, becoming a pair of more modest ");
			//decrease Marble's breast size by 1
			flags[kFLAGS.MARBLE_BREAST_SIZE]--;
			outputText(kGAMECLASS.marbleScene.marbleBreastSize() + " sized breasts.");
			if (flags[kFLAGS.MARBLE_BREAST_SIZE] == 0)
			{
			 	outputText("\n\nYour mate grips one of her sizable DDs, and gives an exaggerated sigh.  \"<i>This is just so tiny.  Remember that I'm only doing this because I care about you sweetie.  I'm not going to shrink them any further.</i>\"");
			}
			//else if (Marble's breast size ==1)
			else if (flags[kFLAGS.MARBLE_BREAST_SIZE] == 1)
			{
			 	outputText("\n\nYour mate gives an experimental bounce of her now reduced chest, \"<i>Hmm, I guess this isn't too bad, do you like the new me, sweetie?</i>\"");
			}
			else
			{
			 	outputText("\n\nYou mate gives her shoulders a roll, then stretches her back.  \"<i>Oh, that's such a relief!</i>\" she says to you with a huge smile, \"<i>Thank you so much sweetie, this is about the right size for me.</i>\"");
			}
			//remove a jar of reducto from the PC's inventory
			player.consumeItem(consumables.REDUCTO);
			//decrease Marble's lust by 5
			flags[kFLAGS.MARBLE_LUST] -= 5;
			if (flags[kFLAGS.MARBLE_LUST] < 0) flags[kFLAGS.MARBLE_LUST] = 0;
		}
		else 
		{
		 	outputText("\n\n\"<i>What?  Sweetie, I'm already so tiny, I'm afraid I couldn't bring myself to get any smaller.  Sorry.</i>\"  She hands you back the jar of reducto.");
		}
		doNext(marbleScene.giveItem);
	}

	//Lactaid
	//Increase Marble's time since last nursed/milked by 10 hours, allowing a PC to instantly nurse from her again.
	public function lactaidForPureMurble():void
	{
		clearOutput();
	 	outputText("You hand Marble a bottle of lactaid, and ask her to drink it.  She nods to you and brings the flask to her lips.  \"<i>Doesn't taste too bad.  Ooo!</i>\" she cries out in surprise, then lets out a sensual moan and starts caressing and playing with her bovine breasts through her top.  She tweaks her nipples, and squeezes the tit flesh in earnest, then lets out one long sigh that sounds almost like a moo.  \"<i>I might have just had a small tit orgasm there...</i>\"  She shakes her head and focuses on you again.  \"<i>Sweetie, I think that just filled up my breasts with a lot of milk.  I have plenty now, if you're interested...</i>\"");
		//increase Marble's time since last nursed by 10
		flags[kFLAGS.MARBLE_TIME_SINCE_NURSED_IN_HOURS] += 10;
		//increase Marble's lust by 20
		flags[kFLAGS.MARBLE_LUST] += 20;
		if (flags[kFLAGS.MARBLE_LUST] < 0) flags[kFLAGS.MARBLE_LUST] = 0;
		player.consumeItem(consumables.LACTAID);
		doNext(marbleScene.giveItem);
	}

	//Nursing from Pure Marble
	public function nursingFromPureMarble():void
	{
		clearOutput();
		//if (time since last nursing is < 4 hours)
		if (flags[kFLAGS.MARBLE_TIME_SINCE_NURSED_IN_HOURS] < 4)
		{
		 	outputText("Feeling a bit thirsty, you ask Marble if there’s any chance she has some milk for you.  She gives you a sad look and informs you that no, she hasn't yet built up enough milk for you to have more.  Purifying her has made it take a bit longer for her to produce milk.");
			doNext(marbleScene.interactWithMarbleAtCamp);
		}
		else
		{
		 	outputText("Feeling a bit thirsty, you ask Marble if theres any chance she has some milk for you.  She smiles at you and tells you she was worried you'd never ask, then leads you to a familiar, secluded part of the rocks around the camp.");
		 	outputText("\n\nOnce you arrive, your lover teases you a bit by grabbing her " + kGAMECLASS.marbleScene.marbleBreastSize() + " breasts through her top and playing around with them for a moment.  The bouncy flesh rolls around her hands in a very pleasant manner, and you feel your mouth water in anticipation of the delicious milk hidden within.");
		 	outputText("\n\nYou're given a sultry smile, and Marble hooks her shirt with her thumb pulling it up over her chest, letting her bovine bust spill forth.  The invitation to partake in her revitalizing and rich fluids comes not long after, and you waste no time in doing just that.  ");
			if (player.tallness < 65)
			{
			 	outputText("The tall cow-lady takes a seat on the rocks and you jump onto her lap, ");
			} 
			else if (player.tallness < 84)
			{
			 	outputText("You lean forward and ");
			}
			else
			{
			 	outputText("You lift up the cow-lady to get access, ");
			}
		 	outputText("in seconds your lips are wrapped around her teats, and her wonderful milk is flowing forth.");

		 	outputText("\n\nWhile her pure milk doesn't have the same effect as when it was addictive, you must admit that it's still extremely delicious.  The rich liquid gushes out, filling your mouth with bliss evoking sweetness. This time around, the flow's speed is far from unmanageable and so you drink with a steady pace rather than wild abandon. Greedily gulping down the white gold, it soothes your dry throat and waiting stomach. Thanks to the comparably moderate stream, you are actually able to appreciate the pleasant feel of the nipple that your lips are clamped to.");
		 	outputText("\n\nWhile savoring the taste, you think that you should give some special attention to the fleshy nub in your mouth, and let your tongue play over the tip.  A few flicks and then a careful circle yields a very pleasant groan.  At the same time, Marble's hands run across your face and head while she mutters gentle words of encouragement and gratitude.");
		 	outputText("\n\nAs you drink, you feel the aches and pains of the day wash away, and new energy fills your body.  The strengthening properties have vanished with the corruption and although the healing properties are weaker, they yet remain.  The flow starts to slow, and you take that as the cue to switch over to the other tit.  A satisfying sigh of pleasure accompanies this switch, and the gentle bovine gives your head a gentle hug, stroking the back of your head.");
			player.refillHunger(30);
		 	outputText("\n\nFinally, your tender moment with your mate comes to an end, and the last of her milk flows down your throat.  You separate, and a small burp escapes your lips.  Marble giggles at this and tells you to come and see her again whenever you're feeling thirsty.  She should be ready to nurse you again in about four hours.");
			//Restore 20% of PC's health
			HPChange(Math.round(player.maxHP()*.2),false);
			//Restore 30 fatigue
			player.changeFatigue(-30);
			//increase lust by 15
			kGAMECLASS.stats(0,0,0,0,0,0,15,0);
			//increase Marble lust by 10
			flags[kFLAGS.MARBLE_LUST] += 10;
			flags[kFLAGS.MARBLE_TIME_SINCE_NURSED_IN_HOURS] = 0;
			if (flags[kFLAGS.MARBLE_LUST] > 0) flags[kFLAGS.MARBLE_LUST] = 100;
			doNext(camp.returnToCampUseOneHour);
		}
	}

	//Marble leaves because you’re too corrupted (above 60)
	//Happens during the purification quest once Marble's corruption is under 30.  If a corrupt follower has been recruited at this point, she will also leave.
	//Marble will warn the PC if their corruption is getting too high (over 50), and leaves when at 60.
	//Warning about corruption
	public function marbleWarnsPCAboutCorruption():void
	{
		clearOutput();
	 	outputText("Marble comes up to you with a worried look on her face.  \"<i>Uh, sweetie?  I'm getting worried about you.  You're trying to put so much effort into freeing me of corruption, but you seem to be slipping away yourself...</i>\"  She looks at the ground, rubs her hands a few times desperately trying to spit the words out.  \"<i>I don't think I'll be able to stay by your side if you keep falling like that.  Please find a way to clear yourself of the corruption that's gripping you!</i>\"");
	 	outputText("\n\nShe runs off, not looking back.  You get the impression that she really doesn't like what she just said, and she's desperately trying to avoid letting what's happening to you bother her.  Should you really care though?");
	 	flags[kFLAGS.MARBLE_WARNED_ABOUT_CORRUPTION] = 1;
		//end event
		doNext(playerMenu);
	}
	//Leaving from corruption
	//PC's corruption is now too high.
	public function marbleLeavesThePCOverCorruption():void
	{
		clearOutput();
	 	outputText("Marble approaches you with a somber expression on her face, her things strapped to a pack on her back");
		//if (PC has more than one child with Marble)
		if (flags[kFLAGS.MARBLE_KIDS] > 1) outputText(" , and with her children in tow");
		//else if (PC has one child with Marble)
		else if (flags[kFLAGS.MARBLE_KIDS] == 1) outputText(", and holding her child's hand");
	 	outputText(".  \"<i>I'm sorry sweetie.  I tried to warn you, but-</i>\" she stops for a moment and takes a deep breath to steady herself.  ");
		//if (PC has at least one child with Marble)
		if (flags[kFLAGS.MARBLE_KIDS] > 0)
		{
		 	outputText("\"<i>Mommy, what's wrong?</i>\"  The young one holding Marble's hand asks nervously.\"<i>Hush now, little one.  We have to go away for awhile,</i>\" the bovine mother responds and turns back to you.  ");
		}
	 	outputText("\"<i>You've gotten too corrupted, and I can't stay here with you anymore.  Please find a way to free yourself from the taint within you so that I can come back.  Goodbye.</i>\"");
	 	outputText("\n\nSo, the woman whom you helped escape from the grip of corruption, leaves you behind, driven away thanks to your own fall to the very same force from which you freed her.");
		//Marble and her kids (if any) are removed from the farm and camp, she will only return once the PC's corruption is below 40, and Vapula, Holi, Corrupted Jojo, and Corrupted Amily are not in camp.
		flags[kFLAGS.MARBLE_LEFT_OVER_CORRUPTION] = 1;
		player.removeStatusEffect(StatusEffects.CampMarble);
		doNext(camp.returnToCampUseOneHour);
	}
	//Marble comes back after your corruption drops below 40
	public function pureMarbleDecidesToBeLessOfABitch():void
	{
		//happens after Marble has left the PC due to their corruption getting too high, and there are no corrupt followers in camp.  She returns during the day once the PC's corruption has gone below 40.
		clearOutput();
	 	outputText("While checking your traps to ensure that they're still working, you hear a voice call out from outside the camp, \"<i>Sweetie!</i>\"  You look up and see the smiling face of Marble");
		//if (PC has at least one child with Marble)
		if (flags[kFLAGS.MARBLE_KIDS] > 0) outputText(" and that of your child");
		//if (PC has two or more children with Marble) 
		if (flags[kFLAGS.MARBLE_KIDS] > 1) outputText("ren");
	 	outputText(" just outside the camp.  She must have somehow found out about your purification.");

	 	outputText("\n\nShe excitedly runs up to you and gives you a big hug, holding you very tightly to her chest.  After several moment of embracing you, Marble gently whispers in your ear, \"<i>I'm so glad you managed to free yourself from the worst of the taint.</i>\"  She pulls back from you and asks if you mind if she moves back into the camp.  How could you say no to her?");
		//re-add Marble and her kids to the camp and farm
		player.createStatusEffect(StatusEffects.CampMarble,0,0,0,0);
		flags[kFLAGS.MARBLE_LEFT_OVER_CORRUPTION] = 0;
		flags[kFLAGS.MARBLE_WARNED_ABOUT_CORRUPTION] = 0;
		flags[kFLAGS.FOLLOWER_AT_FARM_MARBLE] = 0;
		doNext(camp.returnToCampUseOneHour);
	}
	//Clara prison camp descriptions
	//displayed in the camp description if Clara was imprisoned in camp.
	public function claraCampAddition():void
	{
		outputText("Nearby the portal sits a large wooden cage for keeping Marble's sister Clara prisoner.  It is tall enough for her to stand in and long enough for her to lie down completely.  ");
		//if (Clara was purified)
		if (flags[kFLAGS.CLARA_PURIFIED] > 0)
		{
			if (rand(10)==0) outputText("You catch Clara staring at you for a moment, then her gaze once again returns to some distant mountain top.  She has not taken her purification well.");
			else outputText("As always, Clara sits within, staring off into the distance.  She has not taken her purification well.");
		}
		else
		{
			//if (time of day <= 7 OR >= 20)
			if (kGAMECLASS.time.hours <= 7 || kGAMECLASS.time.hours >= 20) outputText("Clara is laying sprawled out on the ground of her cage, snoring loudly.");
			else
			{
				temp = rand(4);
				switch (temp)
				{
					case 0:
						outputText("Clara is currently fidgeting with her clothing, it looks like she's doing some repairs or embroidery.  It's one of the few grateful moments of quiet you get from her.");
						break;
					case 1:
						outputText("Clara is heckling and throwing insults at your followers right now.  It's very annoying, but everyone ignores her.");
						break;
					case 2:
						outputText("Clara is currently engaged in trying to tempt you into letting her out of her cage and becoming addicted to her.  It's much the same as all of her previous attempts....");
						break;
					case 3:
						outputText("Clara is currently loudly whining about the conditions of her confinement to anyone who is willing to listen, which is no one.");
						break;
				}
			}
		}
		outputText("  ");
	}
}
}
