package classes.Scenes.Places.TelAdre{
	import classes.*;
	import classes.GlobalFlags.*;
	import classes.Scenes.NPCs.Urta;

	public class KatherineEmployment extends TelAdreAbstractContent {
		//This class holds all the employment quest specific content for Katherine. It's split off to reduce the size of Katherine.as

		private static const KBIT_TRAINING_TALK_EDRYN:int	=    4;
		private static const KBIT_TRAINING_TALK_URTA:int	=    8;
		private static const KBIT_TRAINING_TALK_KATH:int	=   16;
		private static const KBIT_TRAINING_URTA_HELP:int	=   32;

		public function KatherineEmployment() {}

		public function get edryn():Edryn { return telAdre.edryn; }

		public function get katherine():Katherine { return telAdre.katherine; }

		public function get threesome():KatherineThreesome { return telAdre.katherineThreesome; }

		public function get urta():Urta { return kGAMECLASS.urta; }

		public function employmentTalk():void
		{
			clearOutput();
			outputText("You ask Katherine if she’s ever thought about trying to get a job, so she can settle into a home of her own and get off the streets.\n\n");
			outputText("“<i>Oh, sure, plenty of times.</i>”  The feline shrugs.  “<i>But it’s never worked out; nobody’s ever been willing to hire me... I guess I just don’t look very employable.</i>”  She sighs and picks at a thread hanging from her usual tatters.\n\n");
			outputText("You ask if she’d like you to look around for her.  You don’t know why, but folks in this world seem to take a liking to you on sight; maybe you’ll have better luck persuading somebody in town to take her on as an apprentice of some kind?\n\n");
			outputText("Kath visibly thinks it over, then gives you a loving smile.  “<i>I’d really appreciate that,</i>” she beams.  “<i>It’d be nice to have somewhere other than an empty alley to spend time with you.</i>”  She pokes sadly at the meager nest she’s made from rubbish, ashamed that this is all she has.\n\n");
			outputText("You tell her that you’ll go and take a look right now, and promise to be back as quickly as you can.");
			doNext(tryShops);
		}
	
		private function tryShops():void
		{
			clearOutput();
			outputText("You look around the city for a shop that might be a good place for Kath to work.  Shrugging, you start with the nearest building - the Pawn Broker’s.\n\n");
			outputText("As you approach Oswald, the dog-morph sighs and looks right at you.  “<i>I suppose you’re here to ask if I’ll give a job to that cat who’s always skulking out back, yes?</i>”  You nod, surprised that he would have figured it out, he smiles at your surprise.  “<i>I heard the two of you talking from the backroom.</i>”  Then his face turns solemn and he replies, “<i>Sorry; I know this seems cold, but I’m already living hand to mouth as it is - I can’t afford to take on a partner.</i>”\n\n");
			outputText("You tell him that you understand, and you’ll try elsewhere.  “<i>Good luck,</i>” he says as you exit his shop.\n\n");
			outputText("Weighing the options a little more carefully, of the shops around town, it seems like the Bakery would be the easiest place for Kath to get situated in.  It seems like there are a variety of jobs and learning how to prepare food would be a good skill for the vagrant to pick up.  You enter the Bakery.\n\n");
			outputText("Once inside, you saunter up to the counter and ask the centauress currently manning the shop if she’s interested in hiring any more workers.  She immediately shakes her head.  “<i>Sorry, friend, but we’re fully staffed already; we don’t need anybody else right now.  But even if we did, do you - or whoever you may be asking for - know how to bake?</i>”\n\n");
			outputText("You stop for a moment and think about it... in the end you conclude that Kath probably doesn’t even know what a kitchen looks like on the inside.  It’d probably be a bit overwhelming to jump into something so complex.  Thanking her for her time, you take your leave and decide to try somewhere else...\n\n");
			outputText("Looking around once more, you figure you’ll try the local Blacksmith.  Since that shop is the one responsible for supplying the watch, they must need more workers, right?  Kath couldn’t do any of the actual crafting, but there’s always chores that need to be handled in a forge.  As far as you know, Yvonne works alone, so she might welcome an extra set of hands.  With that in mind you enter the Blacksmith.\n\n");
			outputText("When you spot Yvonne hammering away at a steel breastplate, you approach and ask her if she might be inclined to hire an assistant, or maybe an apprentice.  The dog-woman nods her head slowly.  “<i>Well... that contract with the City Watch does give me quite a bit of work to do.  Another pair of hands would be useful... do you know someone?  More importantly, do they know how to work with metal?</i>”\n\n");
			outputText("You reply that you do know somebody, but you can’t really say they know anything about being a blacksmith.  Yvonne sighs heavily and shakes her head.  “<i>Sorry, but I don’t really have the time to train fresh meat.  If this friend of yours wants a job, they need to look elsewhere.</i>”\n\n");
			outputText("Sighing, you thank Yvonne for her time and wish her a good day.  Once outside you consider your other options... hmm... how about the Gym?  That doesn’t look like it’d be too much work for the cat-girl, especially if she gets a desk job.  You head over, a bit hopeful.\n\n");
			outputText("Seeing the buxom centauress receptionist, you approach her and ask if the Gym could use additional staff - maybe someone to take over from her when she’s on break, or even just to clean the place up. She considers your offer for a while before politely shaking her head.  “<i>Sorry, but what we’re really looking for are trainers to help our clients.  Does the person you’re asking for have any experience in fitness?</i>”\n\n");
			outputText("You admit that she’s probably not really qualified to train anyone in how to exercise or help people get fit.  The centauress sighs.  “<i>Then I’m afraid I cannot help you...</i>”");
			if (player.tone >= 75) {
				outputText("  She takes a second look at you and notices your well defined muscles.  “<i>Hey... maybe you’d be willing to come work here?  With a body like that, you must really know how to work out, huh?</i>”\n\n");
				outputText("You tell her that you appreciate the offer, and keep it in mind, but you currently have other engagements that demand the bulk of your time.");
			}
			outputText("\n\nYou thank her for her time and tell her you’ll just have to look elsewhere.  The centauress smiles at you and wishes you good luck.\n\n");
			outputText("You consider your remaining options... what about Yara?  Sure her business might not exactly be booming, but you never know until you ask, right?  With that in mind you decide to enter the Piercing Studio.\n\n");
			outputText("Stepping inside, you greet Yara with a friendly nod.  Drumming her fingernails on the counter, she returns the gesture with a half-smile.  “<i>Welcome, can I help you with anything?</i>”\n\n");
			outputText("You tell her that you have a friend who is looking for a job, and you were hoping the studio might be able to take her on in some fashion.\n\n");
			outputText("Yara thinks it over.  “<i>I don’t really need anyone else at the moment, but I understand it must be rough... does she know anything about piercings?  You need to have a special touch for this kind of work, especially considering some of the sensitive parts my clients might request to be pierced.</i>”\n\n");
			outputText("You know for a fact Kath’s never been pierced, so you have to admit she probably doesn’t know anything; but surely Yara can teach her on the job?\n\n");
			outputText("“<i>I might... but I’d need someone to help me train her, so if you’d be willing to volunteer we could see about training this friend of yours.  Hope she has a steady hand, otherwise things can hurt... Oh!  And make sure she has no bad habits, like drinking, or addiction to some kind of drug or substance.  When people suffer from withdrawal, they tend to shake...</i>”\n\n");
			outputText("You sigh and admit that you’re not certain you can spare the time to help train her in such a fashion.  You’d certainly be willing to drop by and help out, but you aren’t able to get into Tel’Adre on any kind of regular schedule, what with all the things you have to do in the wastelands.\n\n");
			outputText("“<i>Then I’m afraid I can’t help you...</i>” Yara says, sadly.  You thank her just the same and take your leave.\n\n");
			outputText("By now, the pattern seems pretty clear and you’re running out of options... only the Tailor shop and the Weaponsmith remain.  Considering the Weaponsmith doesn’t look like the most charitable of people, you decide to try your luck with Victoria.\n\n");
			outputText("Once inside, you immediately ask the little corgi-girl if she’d be willing to take on a hired hand to help out around the place.\n\n");
			outputText("“<i>Sorry, but I’m afraid I’m not really interested in hiring anyone at this point in time.  Why do you ask, anyway?</i>”  The petite anthropomorphic corgi asks you.  You explain about Katherine and she clucks her tongue sympathetically.  “<i>I’m really sorry, but I can’t help you.  Maybe one of the other shops?</i>” she suggests.\n\n");
			outputText("You smile and thank her for time, letting her know that you will try; then leave the shop.\n\n");
			outputText("Your only remaining option is the Weaponsmith... dreading the task ahead, you steel yourself and approach the old dog-morph.\n\n");
			outputText("“<i>What? Spit it out, I’m in a hurry!</i>” the bad-tempered man snarls at you when he sees you hesitating.  Once he hears what you want, though, he starts to rant and rave and swear, cursing you and Katherine with language fouler than anything you’ve heard since coming here.  You beat a hasty retreat when it looks like he’s seriously contemplating throwing a red-hot sword-blade fresh from the mold at you.\n\n");
			outputText("...Cranky old coot.\n\n");
			outputText("It looks like no one is willing to take Kath in... you’ll have to think of something else...");
			doNext(tryTheWatch);
		}

		private function tryTheWatch():void {
			clearOutput();
			outputText("You sigh in disappointment.  Absolutely nothing; not one person in Tel’Adre seems to be willing to hire Kath.  You’re about to go back to Katherine in defeat, when suddenly you stop, inspiration striking you in a flash of brilliance: The City Watch surely always needs new recruits, right?  Especially given all the rape-crazy monsters out there in the world.");
			
			var pissedOffUrta:Boolean  = (flags[kFLAGS.URTA_COMFORTABLE_WITH_OWN_BODY] == -1);
			var pissedOffEdryn:Boolean = (flags[kFLAGS.EDRYN_NEVER_SEE_AGAIN] == 1);
			if (pissedOffUrta && pissedOffEdryn) { //Well aren't you a giant dick
				outputText("\n\nSince you're not exactly on the best terms with either Edryn or Urta you decide to go to the nearest watch house and ask for advice.  You're greeted by an older dog morph manning the front desk.  “<i>What can I help you with?</i>” he asks, pulling out a fresh piece of paper from beneath the desk.  You explain that you're interested in what it takes to join the watch, what skills they look for in potential recruits.  He looks you up and down and says “<i>I doubt you'd have much trouble getting in.</i>”\n\n");
				outputText("After some further explaining you learn that the watch needs officers who can survive outside the city, handle themselves in fights and who will behave properly when dealing with the public.\n\n");
				outputText("You leave the watch station hopeful that some time training with you will make Kath a decent watch candidate.");
				flags[kFLAGS.KATHERINE_TRAINING] = 3; //Player can now talk to Kath about getting a job in the watch
			}
			else {
				outputText("  You should try talking to Urta or Edryn; they might be able to help you see if there’s a way to get Katherine into the watch.");
				flags[kFLAGS.KATHERINE_TRAINING] = 2; //Player will now be able to talk to Edryn and/or Urta about Kath
			}
			doNext(camp.returnToCampUseOneHour);
		} //KATHERINE_TRAINING gets set to 1 by talking to her about vagrancy

		public function canTalkToEdryn():Boolean {
			return flags[kFLAGS.KATHERINE_UNLOCKED] == 1 && flags[kFLAGS.KATHERINE_TRAINING] > 1 && (flags[kFLAGS.KATHERINE_TRAINING] & KBIT_TRAINING_TALK_EDRYN) == 0;
		}

		public function talkToEdryn():void
		{
//Triggers when you go to talk to Edryn in the Wet Bitch and
//    (KATHERINE_UNLOCKED == 1 && KATHERINE_TRAINING > 0
//    && (KATHERINE_TRAINING & KBIT_TRAINING_TALK_EDRYN) == 0)
			clearOutput();
			outputText("You approach the");
			if (edryn.pregnancy.isPregnant) outputText(" gorging");
			outputText(" centauress and make yourself comfortable in the seat across from her, which makes Edryn");
			if (edryn.pregnancy.isPregnant) outputText(" stop her pregnancy-induced feasting, stifle a belch and");
			outputText(" smile happily at you.  “<i>Hello " + player.short + ", what’s on your mind?</i>” she asks.\n\n");
			outputText("You ask if there might be any positions available in the Watch?  You wanted to talk to her about joining it.\n\n");
			outputText("Edryn stares at you in surprise.  “<i>Well, yes, we always have room for new recruits... don’t tell me that you want to give up the adventurer’s life and settle down as a watch" + player.mf("man", "woman") + "?</i>”  She asks.");
			var edrynKidsPlus:int = flags[kFLAGS.EDRYN_NUMBER_OF_KIDS] + (edryn.pregnancy.isPregnant ? 1 : 0);
			if (edrynKidsPlus > 0) {
				outputText("  She then widens her eyes in surprise");
				if (edryn.pregnancy.isPregnant) outputText(", one hand brushing against her swollen equine belly as best it can");
				outputText(".  “<i>Don’t tell me this has to do with the " + (edrynKidsPlus > 1 ? "kids" : "baby") + ".  I mean, it’s not that I don’t appreciate the sentiment and all, but you don’t have to do this because of me!</i>” she protests.");
			}
			outputText("\n\nYou quickly explain that you aren’t asking because you want to sign up yourself; you’re asking on behalf of a friend who is unemployed and, frankly, doesn’t have any other options.\n\n");
			outputText("“<i>Oh. I see,</i>” Edryn says, rubbing her chin thoughtfully.  “<i>Well, it’s a simple matter of joining, you just need to come to the Watch house and ask, but there is one little problem.  All watch recruits need to pass certain tests - survival, self defense, things to prove they can actually do what we need them to do, you understand?</i>”\n\n");
			outputText("Of course, you reply, before admitting you’re not certain if Katherine - the person you’re asking for - has those skills.\n\n");
			outputText("“<i>Well, you’re an adventurer, right?  You’ve probably seen more action than some of our veterans, never mind the usual wet-behind-the-ears rookie.</i>”  Edryn shrugs, waving her hand flippantly.  “<i>So, show her a few tricks before you send her down our way; I’m sure with your coaching, she’ll get in for sure.</i>”\n\n");
			outputText("You smile and thank the centauress for her help.  “<i>It was nothing,</i>” she replies, looking quite pleased at your thanks all the same.\n\n");
			flags[kFLAGS.KATHERINE_TRAINING] |= KBIT_TRAINING_TALK_EDRYN; //Using a mask so it doesn’t matter what order you talk to Edryn and Urta in
			var cockFitIndex:int = player.cockThatFits(300);
			if ((cockFitIndex >= 0 && player.cockArea(cockFitIndex) >= 24) && (player.lowerBody == LOWER_BODY_TYPE_HOOFED || player.countCocksOfType(CockTypesEnum.HORSE) > 0 || player.cor > 50 || player.statusEffectv1(StatusEffects.Edryn) > 0)) {
				outputText("“<i>So... I don’t suppose there’s anything else you might have on your mind...?</i>”  She gives you a coy look and fiddles with a nipple through her shirt.");
				doYesNo((edryn.pregnancy.isPregnant ? pregnantEdrynSexSelector : edryn.edrynSexSelecter), telAdre.barTelAdre);
			}
			else {
				outputText("Your business done, you leave the bar; now, how to tell Katherine that if she wants a job, she’ll need to join the Watch...?");
				doNext(telAdre.telAdreMenu);
			}
		}

		private function pregnantEdrynSexSelector():void {
			menu();
			addButton(0,"Preg. Fuck", edryn.fuckPregEdryn);
			addButton(1,"Eat,Rut,Fuck", edryn.eatEdrynPussyLikeABawss);
		}

		public function canTalkToUrta():Boolean {
			return !urta.urtaDrunk() && flags[kFLAGS.KATHERINE_UNLOCKED] == 1 && flags[kFLAGS.KATHERINE_TRAINING] > 1 && (flags[kFLAGS.KATHERINE_TRAINING] & KBIT_TRAINING_TALK_URTA) == 0;
		}

		public function talkToUrta():void
		{
//Triggers when you go to talk to Urta in the Wet Bitch
//    (KATHERINE_UNLOCKED == 1 && KATHERINE_TRAINING > 0 && (KATHERINE_TRAINING & KBIT_TRAINING_TALK_URTA) == 0)
			clearOutput();
			outputText("You tell Urta that you actually need to talk to her about something business related.  The gray-furred vixen gives you a quizzical expression.  “<i>Oh?  What do you mean?</i>”\n\n");
			outputText("You explain Katherine’s situation; how you met the cat, her life as an unemployed, homeless vagrant, her desire to find an honest living, and your hopes that Urta can help you get her a place in the Watch.\n\n");
			outputText("The vulpine herm sighs and taps a finger on the table.  “<i>Just because I’m letting you into my pants doesn’t mean you can just walk all over the rules, you know? ...But, well, we do always need recruits... still, she’ll have to pass the tests to get in, just like anyone else.</i>”\n\n");
			outputText("Tests, you ask?  Urta nods, takes a fortifying gulp from her mug, and explains, “<i>Yeah, all would-be recruits need to prove they have the skills to defend themselves, take down perps and survive in the wilderness.  So, you want her to join the Watch so bad?  I suggest you take some time out of your day and train her - give her some of the skills you’ve picked up as an adventurer.  After that, she should have no problems.</i>”\n\n");
			flags[kFLAGS.KATHERINE_TRAINING] |= KBIT_TRAINING_TALK_URTA; //Using a mask so it doesn’t matter what order you talk to Edryn and Urta in
			if (urta.urtaLove()) { //Lover Urta
				outputText("She looks quietly at you for a few long moments, then sighs and shakes her head.  “<i>I should be so jealous of her... but, well, it’s not like either of us really went into this thing expecting monogamy, right?  Besides, you’re too noble and cute for me to stay mad at you.</i>”  She winks at you in a flirtatious manner.  “<i>In fact... how about this?  If you want to bring your little kitten to me, I’ll help you whip her into shape.  That’s all the help I can offer you, I’m afraid... But first...</i>”  She sets down her mug, then takes one of your hand and slides it into her lap, where you can feel the distinctive bulge swelling.  “<i>How about giving me a little appreciation for being so nice, hmm?</i>”  She asks, licking her lips and savoring your reaction.\n\n");
			outputText("You figure it’s the least you can do to thank her; you can go and tell Katherine about it when you’re done here, and besides, it’s best to keep her in a good mood, right?");
				simpleChoices("Suck Off", urta.blowUrtaUnderTheTableLuv, "Eat Out", urta.eatUrtaOutNomNomPussy, "", null, "", null, "", null);				
			}
			else { //Fuckbuddy Urta
				outputText("She then sullenly starts gulping her mug down, one hand already waving to a bar attendant for a refill.  Looks like she might be a little jealous... You decide not to push your luck, instead thanking her for the advice and leaving her to her drinking.  Now, all you need to do is figure out how to convince Katherine to join the Watch...");
				doNext(telAdre.telAdreMenu);
			}
		}

		public function talkToKath():void
		{
//Only appears if you’ve talked to Edryn, Urta or the desk sargeant and haven’t yet had this talk with Kath
//    (KATHERINE_UNLOCKED == 1 && KATHERINE_TRAINING >= 3 &&
//    && (KATHERINE_TRAINING & KBIT_TRAINING_TALK_KATH) == 0)
			outputText("\n\nYou tell Katherine that you want to talk about your efforts at finding her a job.  “<i>Really?</i>”  She asks, tail slowly waving in cautious optimism.  You nod your head and tell her that you tried every store in the main street; unfortunately, not one of them wanted to hire anyone.  Kath’s feline ears droop and her tail lolls listlessly on the ground.  “<i>Oh. I see...</i>” she says, sadly.  You hasten to assure her that you did find someone who would employ her, but it won’t be easy.  When her ears perk up, you finally explain that you want to help her get a job as a watchcat.\n\n");
			outputText("She stares at you silently, and then... “<i>WHAT!?</i>”  You wince at the ear-piercing volume she reaches, reminding you of that time you heard somebody step on a cat’s tail back in Ingnam.  “<i>I ran away from home because I didn’t WANT to join the Watch; why in the world would you suggest I join them now?!</i>”  Kath shrieks at you, tail bristling, ears flattened against her skull, baring her needle-like canines at you in outrage.\n\n");
			outputText("You frown at her attitude and tell her that there is no need to get aggressive, after all you’re trying to help her.  Besides that, it’s not like she has much choice.\n\n");
			outputText("“<i>What do you mean I have no choice?!</i>” Kath protests.  “<i>You’re just not looking hard enough for a job!</i>”\n\n");
			outputText("You cross your arms and ask her what kind of skills she has that would make her employable.  Can she cook?  Sew?  Work with metal?  Does she have the firm, precise touch to work with piercings?  Come to think of it... is she even capable of joining the Watch in her current conditions?  Can she fight?  Does she know anything about survival in the wilderness?  Can she be imposing when she might need to uphold the law?\n\n");
			outputText("Kath glowers at you, but then wilts, ears and tail falling limp.  “<i>No.  I survive mainly by running away, and I’ve never been a leader, always a follower - if that.  More often, a hanger-on,</i>” she admits, glumly.\n\n");
			outputText("Then does she intend to keep living in the streets?  Scavenging for food for the rest of her days?  Or does she want to try and make a living?  Do something that matters so that she can eventually retire and live in comfort for her remaining days?  What about a family?  Has she ever considered having one?  How does she hope to support her family if she’s living on the streets?  And what kind of example would she be setting for her kittens?\n\n");
			outputText("“<i>I’ve done alright so far!  As for kids... well, there’s lots of women who have children on the streets.  And I’m not talking one or two, I’m talking dozens - one of the biggest gangs around is a mother and her brood of kids, and she just keeps popping them out.</i>”  Katherine spits back at you, glowering defiantly, stubborn pride refusing to let her concede.\n\n");
			outputText("Really?  So this gang she’s talking about must doing pretty well then... you’re sure they never spent a day going hungry in their lives, and surely none of them ever got caught and had to suffer through jail... and even if they did, you’re sure they’d have been bailed by their family instead of rotting in a cell for who knows how long.  And of course, let’s not get in gang war territory, nobody ever dies in a gang war, right?  Is this the future she really wants for her kids?  For her family?  Because if so, then perhaps you two should stop seeing each other; because you have no desire to raise a family like that or have anything to do with that at all.\n\n");
			outputText("Kath’s lip trembles and her ears and tail droop so low they look like they want to fall off.  “<i>How... how can you say these things to me?  Don’t you know what the Watch does to us homeless?  They’re nothing but bullies and thugs - always chasing us away from empty houses because of some dumb law!</i>”\n\n");
			outputText("Of course they do, Kath herself might be a good person, but can she vouch for all homeless people?  Can she be so sure nobody’s tried using vacant homes for more illicit purposes?  How many drug dealers, thieves, and murderers would love somewhere private and hidden to hide from the Watch?  Isn’t it more important that the city be protected from the demons than invite domestic dissent and possible anarchy?  She might bristle under the yoke of the law, but being some demon’s fucktoy is so much worse.\n\n");
			outputText("“<i>Of course!</i>” she spits, managing to muster enough spirit to bristle her tail with rage.  “<i>But... why are they so unfair to us?  We didn’t ask to be homeless, you know...</i>”\n\n");
			outputText("Then why doesn’t she do something about it?  She could just join the Watch and try to change the system.  You agree that there might be people who didn’t want this kind of life, but there are some who just don’t care.  All they want is a life of thievery and luxury; and they are even willing to hurt good people too... Rubbing your head, you tell her you still remember when they assaulted you with an iron pipe.\n\n");
			outputText("“<i>But that wasn’t-!  I didn’t-!</i>”  She tries to defend the actions of her colleagues, unable to find any arguments that sound even the least bit convincing.\n\n");
			outputText("So?  Can she really honestly say that the watch is all that bad, and the homeless vagrants on the streets are actually just victims?  Katherine says nothing, drooping all over, waiting for you to finish your point and make the knockout blow.  You’re offering her a chance to turn her life around for the better; after all the work you’ve had to look for a job for her, is she going to waste her chance at a better life because of some foolish pride?  Because if she just lets go of it, the two of you would be talking with a roof over your heads, maybe even eating some nice home cooked food; and Kath could be wearing a nice dress, instead of rags.\n\n");
			outputText("“<i>I... all right.  You win.  I’ll take the job,</i>” Kath says, sniffling in shame and wiping a humiliated tear from her right eye.\n\n");
			outputText("You pat the sniffling cat-girl on her head, inviting her into a friendly hug.  It’s okay, you tell her, taking a chance can be frightening, but life is about reaching through fear and risk for something more.  Besides, no matter how unlikely it might seem, she might actually end up liking her job at the Watch.\n\n");
			outputText("“<i>I guess...</i>” she replies, still not sounding sure of it, but willing to accept the hug and the spirit behind it gratefully, tail starting to gently swish.  “<i>Still, even if they’re willing to take me, how will I qualify?  You need to know things to join the Watch now, even I know that - they’re getting choosier, because they don’t think they can spend as much time training new recruits as they used to.</i>”\n\n");
			outputText("Well it’s true that when you asked, you were told Kath would need some basic knowledge before passing the test and joining... but you should be able to help her.  There is plenty you’ve learned adventuring, surely you can pass some of that knowledge to her?  ");
			if (urta.urtaLove()) {
				outputText("Besides that, you also know someone who might just be able to help whip her up into shape.\n\n");
				outputText("“<i>And how do you know they’ll be good enough to meet Watch standards?</i>”  Kath asks, curiously.\n\n");
				outputText("Oh I don’t know... maybe because she’s the captain?  You smile wryly at Kath.  The cat’s jaw drops and she stares to you.  “<i>Wha... how?</i>” she blurts aimlessly.\n\n");
				outputText("You give her a winning smile and simply tell her that you have your ways...  Regardless, if she’s uncomfortable with the idea, you can always train her yourself.  Maybe you won’t be as fast or as thorough as her, since you also have other tasks to handle... but you’re pretty sure you can get Kath trained by yourself.\n\n");
				outputText("“<i>I... well, I guess it’s really up to you; the two of you would know more about this than I do,</i>” she mumbles, a little overwhelmed.  You explain that you have some preparations to take care of, before you can begin.  Until then, you advise her to get some rest, because you don’t intend to let her slack off once the training starts.\n\n");
				outputText("The cat-herm nods her head in understanding.  “<i>I promise I’ll do what you tell me,</i>” she swears, blushing a bit.\n\n");
			}
			else {
				outputText("“<i>I guess... I mean, you survive on your own out in the wilderness, right?  You gotta know something about defending yourself, don’t you?</i>” Kath asks, shrugging her shoulders helplessly.\n\n");
				outputText("You can’t help but give her a look of mild hurt.  You were hoping she’d have some more confidence in you...  “<i>What?  What’s with that look?  It was a compliment!</i>” She protests.\n\n");
				outputText("You shrug... you were just hoping for some more excitement from her part... but that doesn’t really matter.  There are some preparations you have to make before beginning on her training, so for now she should just rest and get ready for what’s to come.  You warn her that you have no intention of holding back or allowing her to slack off on her training, so she should be ready for when you return.\n\n");
				outputText("Katherine nods, doe-eyed, trying to look serious but coming off a bit desperate.  “<i>I don’t know how you plan on cleaning up a mess like me, but I’ll try to follow your lead.</i>”\n\n");
			}
			outputText("Having made your point, you say your goodbye and return to camp.");
			flags[kFLAGS.KATHERINE_TRAINING] |= KBIT_TRAINING_TALK_KATH; //Using a mask so we still know if you’ve talked to Urta. This is important if she’s a lover.
			doNext(camp.returnToCampUseOneHour);
		}

		public function initiateTraining():Boolean
		{ //Only appears if you’ve talked to Kath about joining the watch
			/*  Kath’s training progress is represented by a percentage, that goes from 0 to 100.  When it hit 100% Kath will take and pass the Watch’s admission test
				During the process of training, Kath’s traditional menu is disabled. Visiting Kath automatically initiates a training session.
				< 33% = Train Kath in basic survival. < 66% = Train Kath in weapons use. < 100 % = Train Kath in general guard behaviour. */
			if ((flags[kFLAGS.KATHERINE_TRAINING] & KBIT_TRAINING_TALK_KATH) == 0) return false; //Can't start training yet
			var urtaAvailable:Boolean = urta.urtaAtBar() && !urta.urtaDrunk();
			if (urtaAvailable && (flags[kFLAGS.KATHERINE_TRAINING] & KBIT_TRAINING_URTA_HELP) > 0) {
				initiateTrainingWithUrta();
				return true;
			}
			clearOutput();
			outputText("As you approach Katherine’s alleyway, you take a mental inventory of your preparations, to see if it’s time to begin her training.  You realize that once Kath’s training has begun, she will no longer have time to engage in your usual activities until her training is complete, so perhaps you should postpone the final preparations and just pay her a recreational visit instead?");
			var withUrta:Function = trainKathWithUrta;
			if (!urta.urtaLove() || (flags[kFLAGS.KATHERINE_TRAINING] & KBIT_TRAINING_TALK_URTA) == 0) withUrta = null; //Urta must be a lover and you must have talked about Kath
			if (!urtaAvailable && withUrta != null) {
				outputText("\n\nPerhaps you should wait for a time when you know Urta will be available " + (urta.pregnancy.isPregnant ? "" : "(and sober enough) ") + "to help.");
				withUrta = null; //She has to be in the bar
			}
			simpleChoices("Postpone", postpone, "Train", trainKath, "With Urta", withUrta, "", null, "", null);
			return true;
		}

		private function postpone():void
		{
			outputText("\n\nKath has been living in the streets for quite a while, and even though you promised to help her, one more day isn’t going to hurt... with that in mind you continue on your way to visit her...\n\n");
			katherine.katherineVisitNormal(false);
		}

		private function trainKath():void
		{
			clearOutput();
			outputText("Back in camp you thought long and hard about what it would take to turn Katherine into a watch officer.  You recalled what you learned about the watch and their duties you decided there were three major areas where you need to improve Katherine’s knowledge and skills.\n\n");
			outputText("The watch sometimes has to patrol in the desert around Tel’Adre.  She’s probably never been outside the city, so giving Kath some amount of wilderness survival is going to be necessary.\n\n");
			outputText("Then there are the more martial skills.  Kath has probably never fought alone and every fight she’s been in alone has probably been a fight to escape.  At least with all your skills you can really give her a leg up in combat training.\n\n");
			outputText("Finally there’s Katherine’s attitude.  She can look out for herself and she can throw a good insult while she’s running away, but she doesn’t project authority.  Any criminal who meets her will assume they can win in a fight just because of how meek she acts.  That would mean a lot of fights and that’s why the watch requires a certain bearing in their officers.\n\n");
			outputText("Stepping into the alleyway you put down the sack of spare equipment you gathered at camp and tell Kath that it’s time.  She nervously get up from the old packing crate she was sitting on.  Her tail twitches as she approaches and she asks you what the sack is for.\n\n");
			outputText("You tell her it’s all supplies for her to train with.  Until she finishes training she’s going to have to carry this bundle with her at all times.  Kath picks it up and just manages to heft the sack onto her shoulder.  Hopefully the weight will help build her strength and her endurance.\n\n");
			outputText("You lead Kath through the streets of Tel’Adre and despite having lived here her whole life she doesn’t realize where you’re going until you reach the gates.  “<i>We’re going into the desert?  What if some monster eats me?  I heard there are these man eating nagas out here that love cat flesh.</i>”\n\n");
			if (player.statusEffectv2(StatusEffects.Naga) != 0)
				outputText("You almost laugh.  Of all the dangers of the desert she picks the naga.  There’s only one way the naga would eat Kath and they would both enjoy it.  ");
			outputText("You tell Kath that this is the best way for her to learn survival skills.  Besides you’re always going to be with her out in the desert and you’ve crossed it uncounted times and you’re still here.\n\n");
			outputText("Kath nods, adjusts the sack, steels herself and follows you out into the wastes for some very practical survival training.");
			flags[kFLAGS.KATHERINE_UNLOCKED] = 2; //Indicates you’re now training her alone
			flags[kFLAGS.KATHERINE_TRAINING] = 0;
			doNext(katherineTrainingStage1);
		}

		public function katherineTrainingStage1(clearOut:Boolean = true):void
		{
			if (clearOut) clearOutput();
			outputText((flags[kFLAGS.KATHERINE_TRAINING] == 0 ? "  You" : "Kath readies herself quickly and you") + " lead her on a long, winding trek through the desert sands.  You always keep Tel’Adre in sight so that if the two of you are somehow separated Kath will be able to find her way home.\n\n");
			outputText("You show her some strategies and good tricks for staying alive out here and moving across the sand without tiring yourself as much.  Kath’s good at listening and while she doesn’t improve much you know she’ll do better tomorrow.\n\n");
			outputText("When you aren’t instructing her Kath complains about the sand, the heat and the weight of the sack.  You can tell when she really gets tired because she starts to concentrate more on walking than talking.  You can’t blame her.  The desert is difficult terrain to walk on, that’s why you chose it.\n\n");
			outputText("When she’s out of breath and dragging her feet you tell her to stop.  Apart from a few low dunes this part of the desert is featureless.  Not a single weed is growing here.  You point out to Kath that most people die of thirst in the desert, but the rest die of heat stroke or freeze to death in the night.  You’ll show her things that will help with water later, but right now she should build some kind of shelter to protect against the heat, sun, wind and cold.\n\n");
			outputText("Kath pants a few more times before taking a drink from her canteen and pulling open the sack.");
			switch (rand(3)) {
				case 0: doNext(katherineTrainingStage1Success); break;
				case 1: doNext(katherineTrainingStage1Failure); break;
				case 2: doNext(katherineTrainingStage1Horny);
			}
		}

		private function katherineTrainingStage1Success():void
		{
			clearOutput();
			outputText("She tips out the contents and says, “<i>I’ve lived on the street for almost a year now.  Building and finding shelter?  That I can do.</i>”\n\n");
			outputText("Since Kath is tired it takes a while.  She takes the various bits of wood, fasteners and stakes from the sack and and puts them in separate piles on the ground.  Despite the wind she manages to link the supports and fasteners together and raises the frame.\n\n");
			outputText("Lashing down the canvas takes a lot more effort, but Kath is soon sitting inside a completed tent.  It’s not perfect, the wind can still blow through a few seams and gaps, but it’s not bad either.\n\n");
			outputText("Now shielded from the sun Kath begins to recover some of her usual energy and smiles at you from inside the tent.  “<i>Wanna test this thing out " + player.short + "?</i>”\n\n");
			outputText("It’s not the best idea to get distracted out here so you decline.  Besides, part of Kath’s training is to boost her endurance.  If you laze about all afternoon it won’t help her very much.\n\n");
			outputText("You give Kath some more survival instruction while she breaks the tent back down.  Another long march back to the city and Kath is panting by the time you reach the gates.\n\n");
			outputText("She squeezes your hand and thanks you again for doing this, even if she’s not exactly enjoying it she’s going to keep trying until she can pass that test.");
			flags[kFLAGS.KATHERINE_TRAINING] += 10;
			doNext(camp.returnToCampUseOneHour);
		}

		private function katherineTrainingStage1Failure():void
		{
			clearOutput();
			outputText("She tips out the contents and says, “<i>I’ve lived on the street for almost a year now.  Building and finding shelter?  That I can do.</i>”\n\n");
			outputText("You know things are off to a bad start when Kath begins to assemble the tent frame immediately rather than making sure she's using the right parts.  She’s tired and not thinking too clearly.  Soon she has fasteners attached to the wrong supports.  Then she takes apart one bit of the frame only to assemble it backwards.\n\n");
			outputText("The wind nearly blows the canvas away from her and she ends up sifting some of the sand trying to locate a missing strut.  When she finds it hidden under the canvas she plops down on her butt, exhausted.\n\n");
			outputText("“<i>I know, I screwed up.  They probably wouldn’t give me so much time on the test.</i>”  She sighs and adds, “<i>I’ll do better tomorrow.</i>”\n\n");
			outputText("Before returning to Tel’Adre you go over all the mistakes Kath made so that she understands what she did wrong and will be less likely to screw up next time.\n\n");
			outputText("You almost have to carry her back to the alley behind Oswald’s shop.  Kath flops down onto some softer refuse and curls up for what promises to be a long nap.");
			flags[kFLAGS.KATHERINE_TRAINING] += 5;
			doNext(camp.returnToCampUseOneHour);
		}

		private function katherineTrainingStage1Horny():void
		{
			clearOutput();
			outputText("Kath tips the contents of the sack on the ground.  Then she lies down and pulls the sack itself over her body.  You hope she’s just playing, but when you try explain that the sack hardly qualifies as decent shelter you hear a wet ‘schlick’ noise.\n\n");
			outputText("You’re in the desert, so there are only so many things that could sound so wet.  You rip the sack off her and are treated to a view of Kath with her hands jammed down her pants.\n\n");
			outputText("She sits up, embarrassed despite the fact there’s no one else within a mile.  “<i>Come on " + player.short + " - You had me walking all over the place.  My cock" + katherine.cockMultiple("", "s") + " kept rubbing against my pants.  I need to do this to even think straight.</i>”\n\n");
			outputText("You realize there is no way you’re going to get Kath to do anything useful out here.  On the other hand it’s a nice day and your girlfriend is very, very horny.  Might as well make the most of this trip.");
			flags[kFLAGS.KATHERINE_LOCATION] = Katherine.KLOC_DESERT; //Makes sure the scene happens out in the dunes
			simpleChoices("Oral", katherine.giveKatOralPenisWingWang, "Handjob", katherine.handjobbiesFurrDemCatFurries, "", null, "", null, "", null);
		}

		public function katherineTrainingStage2():void
		{
			outputText("You’re sure Kath’s basic survival skills are now good enough to pass any tests the watch might put her through; now it’s time to work on her combat skills.  You’re still trying to work on her endurance, so you march her even further from Tel’Adre.  Only when you reach a quiet spot on the shores of the lake do you finally stop.\n\n");
			outputText("Katherine is a little winded from the walk" + (player.tou < 50 ? " and frankly so are you" : "") + ".  Kath keeps looking around, examining the lakeshore and the plants that grow nearby.  You tell her not to stray too far.  It might look a lot prettier than the desert but there are dangerous creatures near the lake.  You sit on a large rock and wait for Kath to regain some energy and return.");
			switch (rand(3)) {
				case 0: doNext(katherineTrainingStage2Success); break;
				case 1: doNext(katherineTrainingStage2Failure); break;
				case 2: doNext(katherineTrainingStage2Horny);
			}
		}

		private function katherineTrainingStage2Success():void
		{
			clearOutput();
			outputText("By the time Kath gets back you’ve pulled the training swords and lightweight clubs from the sack.  You show her a variety of moves, some for swords and some for fighting in close with an opponent.  After several minutes of instruction you tell Kath that it’s time to put what she’s learning to practice.\n\n");
			outputText("Both of you square off and Kath bounces from foot to foot looking for an opening.  She tries striking you again and again.  Every once in a while she nails you with a quick hit or a surprise move after a feint.  For your part you manage to knock away her weapon a few times and show her how to defeat some blocks.\n\n");
			outputText("When Kath starts to tire you tell her she did well today and pack up the training aids.  If she keeps showing this kind of improvement it won’t take long before she’s a match for any criminal in Tel’Adre and many monsters outside it.\n\n");
			outputText("She beams at the compliment and the two of you walk back to Tel'Adre arm in arm.");
			flags[kFLAGS.KATHERINE_TRAINING] += 10;
			doNext(camp.returnToCampUseTwoHours); //Use up two hours, go back to camp
		}

		private function katherineTrainingStage2Failure():void
		{
			clearOutput();
			outputText("By the time Kath gets back you’ve pulled the training swords and lightweight clubs from the sack.  Kath grabs some weapons and starts practicing thrusts and swings.  You give her a few pointers and then she assumes a combat stance and tells you she’s ready to party.\n\n");
			outputText("You take up your training sword and begin making some quick, simple thrusts and feints, testing to see if Kath uses the blocks you’ve taught her.  Instead she tries to bat your sword away so she can get in close.\n\n");
			outputText("Time and again you try a manoeuvre you showed her only to see her put up the wrong block.  It’s a bit discouraging so you switch to some hand to hand combat for a while.  Here again Kath’s fighting just seems to be off, though she starts to improve her grappling slowly.\n\n");
			outputText("When you switch back to the training swords Kath does a bit better.  At least she’s not messing up her blocks as often.  She would still lose in most fair fights but you think she’s learning.\n\n");
			outputText("When Katherine is tired enough that you can’t continue you pack up and head back for Tel’Adre.  It hasn’t been the best training session, but you know you managed to get some things across.");
			flags[kFLAGS.KATHERINE_TRAINING] += 5;
			doNext(camp.returnToCampUseTwoHours); //Use up two hours, go back to camp
		}

		private function katherineTrainingStage2Horny():void
		{
			clearOutput();
			outputText("Katherine returns much sooner than you expected and with energy to spare.  Her pupils are dilated and her head and tail both flick continuously from side to side.  “<i>There is the most amazing smell over that way,</i>” she says, pointing inland toward a patch of bushes.\n\n");
			outputText("You don’t need to go over to the bushes to find out what the smell is; it’s all over her.  It’s a sweet-yet-creamy scent, unlike anything back home.  It seems whisker fruits, or at least the blossoms of the tree it comes from, have a certain effect on your feline friend.\n\n");
			outputText("As you smell Katherine she is likewise busy sniffing you.  She rubs her nose against your cheek, her whiskers tickling your face, and says, “<i>This place is really nice... I know what we could do.</i>”");
			flags[kFLAGS.KATHERINE_LOCATION] = Katherine.KLOC_LAKE; //Makes sure the scene happens on the shores of the lake
			var penKath:Function = null;       //Fuck and give options only available for males and herms
			var penAnal:Function = null;
			var penBoth:Function = null;
			var takeVag:Function = null;       //Mount her option is only available to females and herms with a vaginal capacity >= 100
			var takeAnal:Function = null;      //Take Anal option is only available when Kath’s knot size is less than 4</i>”
			var takeVagAndAss:Function = null; //Take both is available for those who meet both the Mount Her and Take Anal requirements
			if (player.cockThatFits(70) > -1) {
				penKath = katherine.penetrateKatsVag;
				penAnal = katherine.pcPenetratesKatAnally;
				if (player.cockThatFits2(70) > -1) penBoth = katherine.pcPenetratesKatDoubly;
			}
			if (player.hasVagina() && player.vaginalCapacity() >= 100) { //Don't want to get knotted together out here at the lake
				takeVag = katherine.letKatKnotYourCuntPussyFuck;
				if (katherine.knotSize < 4 && katherine.cockNumber > 1) takeVagAndAss = katherine.getDoublePennedByKat;
			}
			if (katherine.knotSize < 4) takeAnal = katherine.getPenetrated;
			choices("Fuck Her", penKath, "Give Anal", penAnal, "Give Both", penBoth, "Bath", katherine.bathTime, "", null,
				"Nount Her", takeVag, "Take Anal", takeAnal, "Take Both", takeVagAndAss, "", null, "", null);
		}

		public function katherineTrainingStage3():void
		{
			outputText("Now that you know Kath can handle the job physically all that’s left is teaching her how to act.  First you give Kath a rundown on some of Tel’Adre’s laws and how the watch is expected to enforce them.\n\n");
			outputText("Then you tell Kath to stick the training sword and practice club into her belt.  She does and you then straighten her clothes and adjust her posture so she’s standing up straight." + (player.lust >= 50 ? "  Before you begin her training you take a moment to appreciate what her ramrod straight posture does to Katherine’s chest." : "") + "  You tell Kath that she will have to imagine the uniform and helmet.  Right now she is a watch officer out on patrol.  Kath examines herself, fidgets and mumbles, “<i>I feel kind of silly like this.</i>”");
			if (flags[kFLAGS.KATHERINE_TRAINING] >= 99) {
				doNext(katherineTrainingStage3Success);
			}
			else {
				switch (rand(3)) {
					case 0: doNext(katherineTrainingStage3Success); break;
					case 1: doNext(katherineTrainingStage3Failure); break;
					case 2: doNext(katherineTrainingStage3Horny);
				}
			}
		}

		private function katherineTrainingStage3Success():void
		{
			clearOutput();
			outputText("You press on and tell her that she just found some miscreants trying to pickpocket an older lady and she’s chased one down an alley.  The thief has stopped next to two other people and all three are now claiming he’s been there all afternoon.  Now how is she going to deal with the situation?\n\n");
			outputText("Katherine marches toward you, hand on the grip of her club.  She levels a stare at you and says, “<i>I’m placing you under arrest.  Come with me to the watch house quietly or I will be forced to subdue you.</i>”\n\n");
			outputText("You try to talk your way out of it, but to no avail.  Kath isn’t prepared to let you get away.  She offers to let your friends accompany you as witnesses, but that’s all.  When you still refuse she takes a step forward and pulls out her club.\n\n");
			outputText("Before Kath decides to carry out some more combat training you tell her she did well.  Her stern demeanor cracks in an instant and she gives you a big smile and a hug.\n\n");
			outputText("You go through a number of other scenarios with her, all based on the rules and cases you researched at the library.  Kath makes mistakes but rarely makes them twice and through it all she maintains the bearing expected of a watch officer.\n\n");
			outputText("You leave Katherine to practice by herself for a while, thinking that teaching her how to behave might not take as long as you imagined.");
			flags[kFLAGS.KATHERINE_TRAINING] += 10;
			doNext(camp.returnToCampUseOneHour);
		}

		private function katherineTrainingStage3Failure():void
		{
			clearOutput();
			outputText("You press on and tell her that she just found some miscreants trying to pickpocket an older lady and she’s chased one down an alley.  The thief has stopped next to two other people and all three are now claiming he’s been there all afternoon.  Now how is she going to deal with the situation?\n\n");
			outputText("Katherine marches toward you, hand on the grip of her club.  She levels a stare at you and says, “<i>I’m placing you under arrest.  Come with me to the watch house quietly or I will be forced to subdue you.</i>”\n\n");
			outputText("You manage to throw her off kilter by interrupting her whenever she tries to explain why she wants to arrest you.  You question how she has the right to do that, since there’s no witness here to identify you and you have two other people who swear you’ve been here with them.\n\n");
			outputText("Kath keeps trying so you start insulting her, calling her a police pussy among other things.  You give her a fake address and tell her that if the watch want you they can come find you later - you have things to do now.\n\n");
			outputText("Afterward you take Kath through it again but point out the places where you twisted her words or the truth and how a watch officer could respond if someone tried this.  You take Kath through other scenarios but you get the feeling her heart isn’t in it.  She has a little too much sympathy for the criminals since she’s been in their shoes.\n\n");
			outputText("As you walk towards the city gates you feel you’ve made little progress today, but what progress you did make was hard won.  Katherine will make it, she just needs more time and training.");
			flags[kFLAGS.KATHERINE_TRAINING] += 5;
			if (flags[kFLAGS.KATHERINE_TRAINING] > 99) flags[kFLAGS.KATHERINE_TRAINING] = 99; //Only a successful training session should lead to her completing her training next time.
			doNext(camp.returnToCampUseOneHour);
		}


		private function katherineTrainingStage3Horny():void
		{
			clearOutput();
			outputText("You try to press on and explain the crime she has to deal with but you realize Katherine is shifting uncomfortably.  " + (katherine.cockLength <= 10 ? "At first you aren’t sure why, but Kath’s embarrassment tips you off.  A little bulge is developing between her legs." : "The reason is immediately apparent.  The crotch of Katherine’s pants is bulging thanks to her sizeable dog dick.") + "  “<i>I’m sorry " + player.short + ", I really want to keep training.  It’s just when you were touching me and straightening me up you smelled nice and it feels like its been so long since we had fun.</i>”\n\n");
			outputText("You tell Kath that she needs to control herself.  What if this happened while she was out on patrol?  You are about to start explaining what the criminal is up to when Kath’s tattered pants give way.  Her canine member pops out and smacks audibly against her midriff.\n\n");
			outputText("Kath looks down at her treacherous cock and back up at you.  She straightens up again, assuming the correct posture for a watch officer and puffing her chest out.  In a stern, commanding voice she says, “<i>I arrest officer Katherine for indecent exposure.</i>”\n\n");
			outputText("Then Kath starts to snicker.  You can’t help yourself and both of you are soon sitting on crates laughing like mad.  Kath recovers first and puts her arms around you while her cock pokes into your side.  “<i>I’m sorry " + player.short + ", but after that I just can’t take this seriously.  How about we blow some steam off so this doesn’t happen next time, hmmm?</i>”\n\n");
			outputText("You sigh, but the feel of Katherine’s fuzzy face against your cheek weakens your resolve.  It’s not as though she has to take the test tomorrow, so why not take a break?  Kath whispers in your ear, “<i>So how would you like me, lover?</i>”");
			alleywaySexOptions();
		}

		private function alleywaySexOptions():void
		{
			flags[kFLAGS.KATHERINE_LOCATION] = Katherine.KLOC_STREETS; //Makes sure the scene happens in a Tel’Adre alleyway
			var penKath:Function = null;       //Fuck and give options only available for males and herms
			var penAnal:Function = null;
			var penBoth:Function = null;
			var suckNFucks:Function = null;
			var takeVag:Function = null;       //Mount her option is only available to females and herms with a vaginal capacity >= 100
			var takeAnal:Function = null;      //Take Anal option is only available when Kath’s knot size is less than 4</i>”
			var takeVagAndAss:Function = null; //Take both is available for those who meet both the Mount Her and Take Anal requirements
			var suckNFucked:Function = null;
			if (player.cockThatFits(70) > -1) {
				penKath = katherine.penetrateKatsVag;
				penAnal = katherine.pcPenetratesKatAnally;
				if (player.cockThatFits2(70) > -1) penBoth = katherine.pcPenetratesKatDoubly;
				if (katherine.knotSize <= 4) suckNFucks = katherine.suckNFuck;
			}
			if (player.hasCock() && flags[kFLAGS.KATHERINE_TIMES_SEXED] > 0) suckNFucked = katherine.suckedNFuckedByKat;
			if (player.hasVagina()) {
				takeVag = katherine.letKatKnotYourCuntPussyFuck;
				if (katherine.knotSize < 4 && katherine.cockNumber > 1) takeVagAndAss = katherine.getDoublePennedByKat;
			}
			if (katherine.knotSize < 4) takeAnal = katherine.getPenetrated;
			choices("Fuck Her", penKath, "Give Anal", penAnal, "Give Both", penBoth, "SuckNFuck", suckNFucks, "Bath", (flags[kFLAGS.KATHERINE_TRAINING] >= 100 ? katherine.dateKathBath : null),
				"Mount Her", takeVag, "Take Anal", takeAnal, "Take Both", takeVagAndAss, "SuckNFuckd", suckNFucked, "", null);
		}

		public function katherineTrainingComplete():void
		{
//Triggers when you visit Kath with her training score at or over 100
//    (KATHERINE_UNLOCKED == 2) && (KATHERINE_TRAINING >= 100)
			if (urta.urtaDrunk() || model.time.hours >= 15) {
				if (model.time.hours >= 15)
					outputText("Although Kath is ready for testing you think it would be best to catch Urta while she’s filling out paperwork at the Wet Bitch.  That way you won’t risk interrupting her while she’s doing something important or on patrol.");
				else outputText("Although Kath is ready for testing you don’t think the captain of Tel’Adre’s guard is going to be in any condition to test her.  You’re better off waiting until she’s sober.");
				outputText("\n\nKath is pleased to see you anyway and even more pleased that you feel she’s ready.  “<i>I know I haven’t passed yet, but I’m so excited.  Maybe we could do something to celebrate the end of my training?</i>”  She leans back on the crate and runs her hands over her breasts suggestively.");
				alleywaySexOptions();
				return;
			}
			flags[kFLAGS.KATHERINE_UNLOCKED] = 4; //Indicates Kath is now a member of the watch
			flags[kFLAGS.KATHERINE_LOCATION] = Katherine.KLOC_KATHS_APT; //This ensures that after you talk to Urta Kath will disappear for the rest of the day as she needs to sort stuff out.
			outputText("You tell Kath that you feel she’s ready for testing.  She beams and nervously tries to smooth out her clothes.  The two of you walk to the Wet Bitch where, as expected, you find captain Urta sitting alone at her table reading reports and sipping something from a mug.\n\n");
			if (flags[kFLAGS.URTA_COMFORTABLE_WITH_OWN_BODY] > -1) {
				if (flags[kFLAGS.TIMES_FUCKED_URTA] > 0) { //Urta is either your lover or a fuckbuddy
					outputText("Urta gives you a big smile as you lead Katherine over to her table.  “<i>How’s it going, " + player.short + "?</i>”  When Kath sits down, she adds, “<i>And who’s this?</i>” in a friendly tone.\n\n");
			outputText("You explain to Urta how you’ve been training Kath in the hopes of getting her a job in the watch.  Urta sips from her mug and listens closely as you go over the training.  When you finish Urta says, “<i>" + (urta.urtaLove() ? "You know, I could have given you a hand with that, love" : "Well love, the watch can always use new recruits if they’re well trained") + ".</i>”  Kath’s jaw hits the floor and she asks, “<i>You’re sleeping with the captain of the guard?</i>”\n\n");
			outputText("Urta knocks back her mug and says, “<i>Oh yes, we’ve been sleeping together for a while.  I’m guessing from the look on your face, you two have been sleeping together for a while too, hmmm?  Where have you been hiding her, " + player.short + "?  And why haven’t you introduced us?</i>”");
					flags[kFLAGS.KATHERINE_URTA_AFFECTION] = 1;
					if (urta.urtaLove() && (flags[kFLAGS.AMILY_VISITING_URTA] == 4 || flags[kFLAGS.URTA_KNOWS_PC_HAS_MARBLE_FOLLOWER] > 0)) {
						outputText("\n\nBefore Katherine can respond Urta adds, “<i>Don’t worry, I’m not angry about " + player.short + " sleeping around");
						if (flags[kFLAGS.URTA_OPEN_ABOUT_EDRYN] > 0) outputText(" and " + player.mf("he", "she") + " doesn’t get " + player.mf("his", "her") + " back up when I sleep around");
						outputText(".  Considering the world we live in it’s a fine arrangement.</i>”\n\n");
						outputText("Kath sits there, trying to process what she’s hearing.  Finally she grips your hand tightly and says, “<i>I guess so.  I mean I never thought... but yeah.</i>”  She looks back at you and says, “<i>When you’re outside Tel’Adre you must need relief sometimes.</i>”");
						if (flags[kFLAGS.AMILY_VISITING_URTA] == 4) {
							outputText("\n\nUrta laughs and says “<i>Yeah, I’ve met the ‘relief’ - or some of it anyway.  Her name is Amily and she’s a lot of fun.</i>”  She pats your arm and adds, “<i>Maybe we should introduce them.  You know, a game of cat and mouse or something.</i>”");
							flags[kFLAGS.KATHERINE_AMILY_AFFECTION] = 1;
						}
					}
					outputText("\n\nKath looks a little shellshocked and you don’t want to frighten her any more before her testing, so you give a noncommittal answer and force the conversation back on topic.\n\n");
					outputText("Urta tosses back the last of her drink and stands up.  “<i>Ok then recruit, lets see what you can do.  I’m tough but fair and if you’ve learned from " + player.short + " you should do just fine.</i>”  She starts to lead Kath out of the bar but stops to tell you, “<i>Just wait around here for us " + player.short + ", we’ll be back in a few hours or so.</i>”");
					doNext(katherineTrainingCompleteUrtaLover);
				}
				else { //You've never spoken to her
					outputText("You haven’t spoken to the captain of Tel’Adre’s guard since that first day when you arrived in the city.  Urta is nursing some kind of hard liquor and working her way through piles of reports and other paperwork.  She notices your approach and puts aside her quill.\n\n");
					outputText("“<i>What can I do for you two?</i>” she asks, waving her hand towards the empty seats at the table.\n\n");
					outputText("You both sit down and explain that Katherine wants to join the watch.\n\n");
					outputText("“<i>You’ve heard there are some tests she will have to pass to qualify, right?</i>” Urta asks.\n\n");
					outputText("You tell her you’ve heard about the tests and in fact you’ve been training Kath for some time based on what you’ve learned surviving outside Tel’Adre.\n\n");
					outputText("Urta seems impressed and tosses back the rest of her drink.  In moments she’s packed up all her papers and turns to Kath.  “<i>Alright recruit, follow me.  Let’s see if you’ve got what it takes.</i>”");
					doNext(katherineTrainingCompleteNeverSpokenOrPermanentlyPissed);
				}
			}
			else {
				if (flags[kFLAGS.TIMES_FUCKED_URTA] == 0) { //You ran away that first time, she assumed you hate her cock
					outputText("Urta’s expressions wavers between curiosity, anger and fear when you bring Kath to her table and ask if you and Katherine can talk about the watch.  She does let you both sit down and then says little as you explain how Kath wants to join the watch and how you’ve been training her.\n\n");
					outputText("Urta’s guarded attitude makes Kath nervous, but finally Urta stands up and says, “<i>Alright.  It’s true enough that we need more officers.</i>”  She looks over at Kath “<i>If you’ve got what it takes I’ll hand you a badge this afternoon.  Just follow me.</i>”  She looks back at you and adds “<i>We’ll be back here later if you want to wait up.</i>”");
					doNext(katherineTrainingCompleteUrtaThoughtYouDidntLikeHer);
				}
				else { //You broke up with her over something else and she won’t come back
					outputText("Urta really doesn’t look like she wants to talk to you.  To make sure Katherine has the best chance of being accepted you decide not to get involved.  You give Kath a kiss and send her over alone.  You watch from the corner of the bar while the two of them talk for several minutes.  Finally Urta finishes her drink and leads Kath out of the bar.");
					doNext(katherineTrainingCompleteNeverSpokenOrPermanentlyPissed);
				}
			}
		}

		private function katherineTrainingCompleteUrtaLover():void
		{
			clearOutput();
			outputText("You spend the next few hours alternately waiting in the bar and strolling around the block to stretch your legs, all the while wondering how Kath is doing.  You’ve just stepped back into the bar when you hear footsteps fast approaching from behind.\n\n");
			outputText("Kath races into the bar and leaps into your arms, nearly knocking you off your feet.  “<i>I did it!  I did it!</i>” she cries while hugging you tight enough to squeeze the breath out of you.  “<i>Oh thank you " + player.short + ", I couldn’t have done it without you.  The tests were hard but I knew what she wanted.</i>”\n\n");
			outputText("You stroke her hair and Katherine finally calms down enough to show you her new badge.  “<i>I’m starting tomorrow.  Oh - and that’s not even the best part.  I didn’t know about this, but because I’m in the watch they can give me papers that show I have a good job, that I’m a good citizen.  I forget what it’s called, but it means I’ll be able to get a house really soon cause they know I’m good for it and I’ll be earning a wage.</i>”\n\n");
			outputText("“<i>We just call it housing approval,</i>” says a voice from the door.  Urta is standing there, looking quite pleased.  “<i>Well Kath, you’ve spread the good news, now you’ve got some equipment to pick up at the watch house.</i>”\n\n");
			outputText("Kath nods and says to you “<i>Yes, there’s so much to do.  I’ve got to get going.</i>”  She gives you another kiss and you can feel a certain bulge pressing against your hip.  “<i>I don’t know where my house will be yet, but Captain Urta is going to be making sure I settle in, so I’ll be here at the bar filling out reports from time to time.</i>”\n\n");
			outputText("She says, “<i>Thank you,</i>” again, kisses you again and then races off down the street.  Urta gives you a hug and says, “<i>She’s got a lot of energy that one.  I can see why you like her.</i>”  You can feel her horsecock pressing against you as she continues.  “<i>I’m going to get to know her pretty well on the job.  I understand if you don’t want to share - but it sure would be fun.</i>”\n\n");
			outputText("You run an hand through Urta’s fur and thank her for being so understanding.  Unfortunately you have stayed in town quite a while so you decide that you have to head back to camp to check up on the portal.");
			doNext(camp.returnToCampUseFourHours); //Use up 4 hours, go back to camp
		}
	
	
		private function katherineTrainingCompleteNeverSpokenOrPermanentlyPissed():void
		{
			clearOutput();
			outputText("You go back to Kath’s alley and pace back and forth, waiting.  Hours later Kath races into the alley and leaps into your arms, nearly knocking you off your feet.  “<i>I did it!  I did it!</i>” she cries while hugging you tight enough to squeeze the breath out of you.  “<i>Oh thank you " + player.short + ", I couldn’t have done it without you.  The tests were hard but I knew what she wanted.</i>”\n\n");
			outputText("You stroke her hair and Katherine finally calms down enough to show you her new badge.  “<i>I’m starting tomorrow.  Oh - and that’s not even the best part.  I didn’t know about this, but because I’m in the watch they can give me papers that show I have a good job, that I’m a good citizen.  I forget what it’s called, but it means I’ll be able to get a house really soon cause they know I’m good for it and I’ll be earning a wage.</i>”\n\n");
			outputText("She looks around at the alley and says, “<i>We had some fun times here, but I won’t miss living on the street.</i>”  She gives you a kiss and adds, “<i>I have to run.  I’ve got equipment to pick up and patrol routes to memorize.  Next time you’re in town, look for me at the Wet Bitch; I’ll try to hang around there.</i>”");
			doNext(camp.returnToCampUseFourHours); //Use up 4 hours, go back to camp
		}
		
		private function katherineTrainingCompleteUrtaThoughtYouDidntLikeHer():void
		{
			clearOutput();
			outputText("You spend the next few hours alternately waiting in the bar and strolling around the block to stretch your legs, all the while wondering how Kath is doing.  You’ve just stepped back into the bar when you hear footsteps fast approaching from behind.\n\n");
			outputText("Kath races into the bar and leaps into your arms, nearly knocking you off your feet.  “<i>I did it!  I did it!</i>” she cries while hugging you tight enough to squeeze the breath out of you.  “<i>Oh thank you " + player.short + ", I couldn’t have done it without you.  The tests were hard but I knew what she wanted.</i>”\n\n");
			outputText("You stroke her hair and Katherine finally calms down enough to show you her new badge.  “<i>I’m starting tomorrow.  Oh - and that’s not even the best part.  I didn’t know about this, but because I’m in the watch they can give me papers that show I have a good job, that I’m a good citizen.  I forget what it’s called, but it means I’ll be able to get a house really soon cause they know I’m good for it and I’ll be earning a wage.</i>”\n\n");
			outputText("“<i>We just call it housing approval,</i>” says a voice from the door.  Urta is standing there, looking quite pleased.  “<i>Well Kath, you’ve spread the good news, now you’ve got some equipment to pick up at the watch house.</i>”\n\n");
			outputText("Kath nods and says to you, “<i>Yes, there’s so much to do.  I’ve got to get going.</i>”  She gives you another kiss and you can feel a certain bulge pressing against your hip.  “<i>I don’t know where my house will be yet, but Captain Urta is going to be making sure I settle in, so I’ll be here at the bar filling out reports from time to time.</i>”\n\n");
			outputText("She says, “<i>Thank you,</i>” again, kisses you again and then races off down the street.  Then Urta surprises you by saying, “<i>I want to buy you a drink.</i>”");
			doNext(urtaForgivesYou);
		}

		private function urtaForgivesYou():void
		{
			clearOutput();
			outputText("She leads you over to her table and soon you’re " + (player.isPregnant() ? "drinking some hot chocolate while Urta sips some kind of hard liquor" : "sipping some harsh form of whiskey with her") + ".  Urta starts by complimenting you on Kath’s training.  It seems few candidates are that well prepared on their first attempt to take the tests.  She seems nervous, even acts bit deferential to you.\n\n");
			outputText("From how she’s acting you feel there’s more to this talk than that but it takes a while, and several more drinks, for Urta to work up her courage.  Finally she says, “<i>From the way Katherine acted I know you two are together.</i>”  She tilts her glass and looks at the amber liquid.  “<i>From the testing I can tell Kath is a herm.  I mean, we did some combat tests, some grappling.  It’s kind of hard to miss.</i>”\n\n");
			outputText("After a long pause she adds “<i>So... I think I misjudged you.  That time you saw me, just out back of this place.  A lot of people hate herms and I thought you must be like that.</i>”  She looks down again and adds, “<i>I guess I never gave you the chance to set the record straight.</i>”");
			simpleChoices("Flirt", urta.flirtWithUrta, "Friends", friendsWithUrta, "Destroy Her", destroyUrta, "", null, "", null);
		}

		private function friendsWithUrta():void
		{
			clearOutput();
			outputText("You tell her that you don’t have any problem with herms, in fact you find some of them quite attractive.\n\n");
			outputText("There’s an awkward silence for a few moments.  Then Urta says, “<i>Well you sure seem to be good for Kath.  Anyone who can take a street urchin and train her up into a fine watch recruit is in my good books.  Come and talk to me anytime.</i>”");
			flags[kFLAGS.URTA_COMFORTABLE_WITH_OWN_BODY] = 0; //This pair of values can't happen any other way. It puts Urta into friend mode. She is willing to talk
			flags[kFLAGS.URTA_PC_LOVE_COUNTER] = -1;          //about Kath and share some things about herself but doesn’t assume you want sex when you visit.
			doNext(camp.returnToCampUseFourHours); //Use up 4 hours, go back to camp
		}

		private function destroyUrta():void
		{
			clearOutput();
			outputText("She’s been giving you the cold shoulder all this time and <b>now</b> she wants to make up?  Fuck this fox bitch!  You tell Urta in no uncertain terms that you don't hate herms - you hate her.  She’s a drunk, pushy, ugly bitch and no one will ever love her.  She makes you sick and she’d better leave you and your girl alone.\n\n");
			outputText("Urta looks like she’s about to fly into a rage, but instead you see tears forming in the corners of her eyes.  Soon she’s sobbing into her drink.  You walk out of the bar and head back to camp, sure that Urta is too devastated to ever talk about this to Kath.");
			doNext(camp.returnToCampUseFourHours); //Use up 4 hours, go back to camp
		}

		private function trainKathWithUrta():void
		{
			clearOutput();
			outputText("With a smile, you turn and make your way to the Wet Bitch.  Once inside you easily spot Urta and sit at her table.\n\n");
			outputText("Urta smiles openly and warmly, her tail abandoning it’s habitual position obscuring her sizable cock to instead wag in vulpine greeting.  “<i>Hello, " + player.short + "; so, how is your would-be watchman coming along?</i>” she asks.  Then she takes another look at you and smirks.  “<i>From that look on your face, I’m thinking you’re here to ask for my help, yes?</i>”\n\n");
			outputText("You nod in confirmation, telling Urta that you are here to give her more information on Kath, so the two of you can come up with a good training schedule for her.\n\n");
			outputText("The fox steeples her clawed fingers in front of her face.  “<i>I’m listening,</i>” she tells you.\n\n");
			outputText("Looking around, you suggest that perhaps it would be better to do this in a more private setting, it can’t be good for the people to know that the watch captain is going to be doing a personal favor for someone; this could impact her image.\n\n");
			outputText("Urta looks surprised, then smiles hugely.  “<i>You really do care about me, don’t you?</i>” she asks, as if she almost doesn’t dare believe the idea.  “<i>Come on then, let’s go to my apartment,</i>” she tells you, pushing up from her seat and walking the familiar route to the back door.  There’s a little more of a swish in her hips when she walks than usual; maybe she has hopes of this progressing beyond a training exercise?  Either way, you follow the fox-herm eagerly... perhaps it wouldn’t be bad to mix business and pleasure.\n\n");
			outputText("The route to Urta’s place is quite familiar to you by now, and she surprises you by opening the door and gallantly offering to let you inside first.  An invitation you’re only too happy to take.   You’re reminded of the practice of men holding doors open for ladies back in Ingnam by the gesture.  Once inside you take a seat on her couch and wait for her to sit next to you, so you can start planning.  The over-endowed fox takes a seat with a groan, rubbing her balls through her dress, then faking a yawn as an excuse to sling an arm around your back.  “<i>So... what do you have in mind?</i>” she asks.\n\n");
			outputText("You lay a hand on her thigh and start sharing all you know about Kath; how she is currently homeless; how she lacks any combat experience beyond basic survival; how she tends to get pretty pent up sexually and how that frustration boils over... even giving the details of how you met in the first place...\n\n");
			outputText("Urta nods her head and keeps quiet throughout, quietly digesting what you have to say.  Glancing at you with eyes half-lidded in thought, she quietly asks, “<i>So... do you just have a thing for herms with mismatched dicks?</i>”\n\n");
			outputText("You tell her to focus on what actually matters.  The vulpine watch officer gives you a pleading look, hoping you’ll answer her first question.  With a sigh of defeat you finally ask her if she has a problem with it?  Maybe you do... maybe you don’t, but the fact is the two of you are together, you stress.  You assure her, that if she’s worried about this, you can put her mind at ease.  She’s more than just some fetish to you- you genuinely enjoy being with her.  But, you must admit, the fact that she’s a sexy herm is a definite plus...\n\n");
			outputText("Urta blushes and looks at her feet, idly fiddling with the hem of her dress.  She’s silent for a long time, but finally asks, “<i>So... how do you want me to help you train this... Kath, was it?</i>”\n\n");
			outputText("To be honest, you were hoping she would have a plan... she is the guard captain, and if anyone knows the job, it’d be her.  You ask Urta if she doesn’t have any ideas?\n\n");
			outputText("Urta frowns in thought and scratches the back of her ear.  “<i>Well... the three main requirements of a recruit are basic survival skills, the ability to fight both unarmed and with at least one kind of weapon, and being able to muster the appropriate attitude for a watchman - to be firm and confident no matter the adversary.</i>”\n\n");
			outputText("You tell her you understand... but considering the current state of affairs in Mareth perhaps it would be good to train Kath in the matter of... restraint... as well.  You fear that some demon or perhaps a corrupt individual might be able to take advantage of her that way...\n\n");
			outputText("Urta nods her head.  “<i>Yes, while it’s true that conventional training used to be enough when I joined, these days it’s important to train sexual resistance too...</i>”  Urta ponders the fact for a while longer, then an idea hits her.  “<i>Wait here, I think I have something that can help with that.</i>”  Rising, the fox-woman gets up and ducks out to her room.  The sound of rustling drawers and cabinets filters back to you, until finally you hear a faint, “<i>Aha!</i>”\n\n");
			outputText("Urta walks back into the living room holding a chastity belt; it is made of a combination of leather and metal.  The designs looks like that of a pair of panties, with a padded protrusion in the end made to fit a cock, and a wide oval plating, with a slit cut in the middle to prevent anything from entering the user’s pussy; an iron lock dots the side of the constricting metal panties and opens sideways to allow its victim to step inside and then lock tightly on the side;  you can clearly see it was made to prevent any sort of pleasing touch no matter what you’ve got between your legs.  A simple lock adorns the side of the belt and a pair of keys dangle from the contraption.  You just stare at Urta in awkward silence for a short while before finally asking her why she has something like that handy?\n\n");
			outputText("Urta blushes fiercely.  “<i>I... I wanted to see if maybe it would help with, y’know, my little problem...</i>” she finally manages to blurt out.  She looks off into the distance and scowls.  “<i>But as it turns out I just couldn’t bring myself to keep it on... it was unbearable.</i>”  Really?  Perhaps you could help her by hanging onto the keys for her, that way she wouldn’t have a way of getting it off unless you wanted her to...\n\n");
			outputText("Urta looks at you with a shocked expression; you probably couldn’t have horrified her more if you’d told her you were taking a lifelong vow of celibacy and would never be able to see her again.  You can’t help but burst out laughing, getting up to run your hand along her back, down to her butt.  You tell Urta that there’s no way you’d be able to keep her tied up for too long... Still if the chastity belt didn’t help her, how is it supposed to help Kath?\n\n");
			outputText("“<i>From what you tell me, my libido’s a lot worse than your little kitty-cat’s.  She wouldn’t have it anywhere near as bad as I did,</i>” Urta points out.  She then shrugs.  “<i>Besides, it failed to help me master my libido in the long term, but for short-term motivation, it’s quite effective.</i>”\n\n");
			outputText("That’s true, you admit.  As a final note, you ask if Urta has a place where she could properly train Kath.\n\n");
			outputText("“<i>Well... we use a number of safehouses around the city for new recruits, and lust-resistance training is part of their regime too.  I could commandeer one when you need, justify it as me brushing up on some training of my own?</i>” Urta offers after some deep thought on the subject.\n\n");
			outputText("You tell her that if she could do that, it would be perfect.  You give the matter some thought and conclude that this pretty much settles all that needs to be settled about Kath’s training.\n\n");
			outputText("“<i>Alright, so, is there... anything else that’s on your mind?</i>” Urta asks, hopefully.  You look Urta over... she’s given you such a nice mental image... her being tied up into a chastity belt, unable to cum... perhaps you should see if she’s up for a little practice of her own?  Right here, right now?");
			flags[kFLAGS.KATHERINE_TRAINING] |= KBIT_TRAINING_URTA_HELP; //This indicates that next time we see Kath it’s time for her to train with Urta
			doYesNo(chastityBeltFun, noChastityFunForNow);
		}
		
		private function chastityBeltFun():void
		{
			clearOutput();
			outputText("You lift the chastity belt off her hands and look it over.  Then give her a lusty look.  Realizing what you’re thinking, she protests, “<i>Lover, no, just... no.  I already told you it gets me so worked up I’m ready to burst when I get it off - the last time I dared wear that, when I finally got it off, I damn near flooded the whole house venting the pressure that had built up in my balls!  Please, I love you, but don’t make me wear that again!</i>” she begs you.\n\n");
			outputText("Flooded the house?  Your smile widens and you look at the belt... then back at her again.  You raise your eyebrows, as if asking an unspoken question.  Urta winces and whimpers like the fox she so resembles.  “<i>Please, " + player.short + ", please don’t look at me like that... I don’t want to do it, it hurts when I’m trapped in that thing.</i>”  she pleads.\n\n");
			outputText("You look down at the floor in disappointment... then look back at her, trying to make the best ‘puppy eyes’ you can manage.  Urta does a fullbody wince... and then sighs loudly.  “<i>Why, why can I never resist you, lover?  Alright, give the damn thing here,</i>” she tells you, holding out one hand hesitantly.  “<i>Though I hope you know that you won’t be able to do anything to me while I’m wearing it either, so I don’t see how you plan on getting satisfaction out of me being in it!</i>” she barks defiantly.\n\n");
			outputText("You grin at her as she finally caves to your unspoken request and hand the belt over to her.");
			urta.chastityBeltFun(false);
		}

		private function noChastityFunForNow():void
		{
			clearOutput();
			outputText("Perhaps some other time...  You shake your head and tell Urta that, for now, this is all you had to discuss with her.\n\n");
			outputText("Urta sighs softly, slumping.  “<i>Okay, lover.  Business before pleasure, I can understand that.  I’ll see you around, okay?</i>”  She concludes in a hopeful tone.");
			doNext(camp.returnToCampUseOneHour);
		}
	
		private function initiateTrainingWithUrta():void
		{	//Happens next time you visit Kath after the visit to Urta
			outputText("You approach the alleyway behind the pawn shop, looking for Kath... and sure enough, you spot the cat-herm grooming herself.  Gently coughing to get her attention, you wave a hand at her.\n\n");
			outputText("She looks up and gives you a strained smile.  “<i>Hi, " + player.short + ".  So... uh, something you need?</i>” she asks weakly, clearly still not too enthused about signing up for the Watch.\n\n");
			outputText("You nod, and simply state that, “<i>It’s time</i>”.  You tell her to pack up whatever she needs and wait while you go check up on her trainer.  “<i>Trainer?</i>” Kath repeats, curious.  But she doesn’t press on the matter, instead indicating you should go while she gets her meager belongings together to move out of the alley.\n\n");
			outputText("You find Urta standing at the door of the Wet Bitch; she has chosen to wear her Watch uniform for this task it seems... smiling, you wave to her, trying to draw her attention.\n\n");
			outputText("The Watch-vixen looks at you, smiles and walks over to meet up with you.  “<i>So, you and the puffball kitten ready to start, are you?</i>” she asks, her tone light and fairly friendly despite her words.  Still, you think she’s maybe a little jealous, and you can’t really blame her.\n\n");
			outputText("You decide to ease the tension by drawing her into a quick kiss, then telling her that yes... you’re both ready.  You also warn her that Kath doesn’t seem too enthusiastic about joining the watch... maybe Urta could give her some motivation or something?\n\n");
			outputText("“<i>Motivation?  Like how?  I’m not going to threaten to shove my cock up her ass if she doesn’t perform to my expectations.  I got more pride than that, I’ll have you know,</i>” she warns you.\n\n");
			outputText("You shake your head.  You didn’t mean anything like that... you were hoping Urta would maybe give a pep talk or something along the lines of that.  Threats are not likely to get the reluctant cat going...\n\n");
			outputText("Urta stops and flushes with embarrassment.  “<i>Okay, yeah, pep talk, I think I can pull that off.  Can’t guarantee she’ll listen, but hey, isn’t that always a problem with trying to talk people into doing something, even for their own good?</i>” she rambles.\n\n");
			outputText("You agree with her, but you could use all the help you can get... and so could Kath.  Urta’s lip curls, exposing a very sharp set of chompers in what is quite obviously a jealous scowl.  Realizing what is going on, you decide to ask Urta if she’s really ok with doing this.  You certainly don’t mean to make her uncomfortable...  “<i>No, no, it’s fine...</i>” she turns her head to the side and you almost think you hear her mumble something like, “<i>It’s not like I’m exactly a beacon of monogamy either,</i>” but then she shakes her head.  “<i>It just takes a little getting used to.  That you got a girlfriend on the side is one thing, that you want me to help get her, well, what is basically my job is kind of another thing, you know?</i>” she shrugs her shoulders.\n\n");
			outputText("You nod in understanding, but tell Urta that Kath has it pretty rough.  You were hoping she would be sympathetic, considering her past.  Urta was strong enough to get a better life on her own, but Kath isn’t... besides that, you tell her you’re not trying to replace her or anything like that.\n\n");
			outputText("Urta heaves a sigh.  “<i>Okay, okay, no need for the lectures.  Let’s just go see this cat of yours.</i>”  Despite her gruff tone, her expression makes it obvious she appreciates your words.  She indicates you should lead the way.\n\n");
			outputText("Nodding, you do so.\n\n");
			outputText("You lead Urta to the alleyway behind the pawn shop, and instantly spot Kath sitting on an empty box, a small pouch with what you presume to be her belonging sit nearby.  You approach her and introduce Urta and Kath to one another.\n\n");
			outputText("The two herms awkwardly say hello to each other, and then fall silent, staring, neither willing - able? - to make the first move herself.  You’ll have to break the ice between your mismatched dickgirls.\n\n");
			outputText("Sighing at their social ineptitude... you tell Kath that Urta is actually the captain of the guard, she’s also pretty well-known and respected in Tel’Adre, so she couldn’t be in better hands if she’s hoping to join.\n\n");
			outputText("The cat looks at you dully.  “<i>I know who she is, " + player.short + ".  You sure this booze-hound can stay sober long enough to help?</i>” she jerks a thumb at Urta, who is fuming already.\n\n");
			outputText("“<i>Listen here, pussy cat, I’m doing this as a favor, so knock off the insults,</i>” Urta snaps back.\n\n");
			outputText("“<i>As if you know anything about doing a hard day’s work, anyway; you spend all morning in that cushy bar drinking your ass off, then stagger back home, everyone knows it,</i>” Katherine jeers.  “<i>How’d you even get into the Watch in the first place?</i>”\n\n");
			outputText("“<i>Blood, sweat and tears!</i>” Urta barks, making both of you jump at the venom.  “<i>I know <b>exactly</b> what you’re going through - I was a street punk myself when I was a teenager.  I brawled my way into the Watch, and then clawed my way up the ranks.  I didn’t use any ‘family connections’ - I don’t even <b>have</b> a family!  Everything I have today I worked my tail off for, and if there’s anyone who knows where you’re coming from, it’s me!</i>”\n\n");
			outputText("Kath looks at the fox with what is obviously trying to be a guarded expression, but hints of both awe and fear are blatantly visible.  “<i>...I’m sorry.  I was in the wrong,</i>” she admits.\n\n");
			outputText("Urta inhales deeply and then exhales, loud and slow.  “<i>It’s alright.  Like I said, I know what it’s like on the streets, I know joining the Watch isn’t exactly an attractive option.  But I’m not your enemy here; you treat me with respect, and I’ll do the same to you.  Deal?</i>” she asks, offering a hand to Katherine.\n\n");
			outputText("“<i>Deal,</i>” the cat replies, shaking the fox’s hand.  “<i>So... uh... what do you two have in mind, anyway?</i>” she asks, looking from Urta to you and back again.\n\n");
			outputText("First... you just breath a sigh of relief, for a moment you thought a fight would break out... then you reply that while you have a basic idea of what needs to be done Urta is the one running the show here, so the details are left at her discretion.  But you do know that Urta commandeered a safe house, usually used to train other Watch members for the purpose of training Kath.\n\n");
			outputText("Kath’s eyes widen and she turns to Urta.  “<i>Isn’t that expensive?</i>” she asks, dumbstruck.\n\n");
			outputText("“<i>I’m the captain of the Watch.  Besides, its official purpose is for training Watch members; there’s no price on it.  We got others to use, anyway,</i>” Urta replies.\n\n");
			outputText("“<i>I see.... well,</i>” Kath draws herself up straight, “<i>I swear I’ll do my best to train - I won’t let either of you down.</i>”\n\n");
			outputText("“<i>You say that now.  You mightn’t be so chipper when you see what the training entails,</i>” Urta smirks.\n\n");
			outputText("Katherine looks nervous at that.  “<i>Uh... what does it entail, anyway?</i>” she asks.  Urta just gives her the epitome of a vulpine grin and refuses to say anything.  When Kath turns to look at you looking for an answer, but you just reply with a knowing grin.  You then ask if Urta brought the package?  The one you two agreed upon?\n\n");
			outputText("Urta nods.  “<i>It’s waiting at the safe house, ready to be put to use.</i>”\n\n");
			outputText("“<i>Package?  What package?</i>” Katherine asks, bringing to mind the curious kittens back in Ingnam.\n\n");
			outputText("Neither you nor Urta reply, though; instead, you indicate Urta should start leading the way and she sets off, with you close behind and Kath tagging along at the end, muttering nervously to herself as you go.\n\n");
			outputText("You arrive at what looks like a run-down building in a rather deserted part of Tel’Adre, the front gate is locked tight with an old padlock and chains.  You appraise the building carefully, turning to look at Urta and question if she’s sure the building is safe?  Because it looks like it could come down any minute.\n\n");
			outputText("“<i>Of course it’s safe!</i>” Urta protests, wounded.\n\n");
			outputText("“<i>It looks like a dump,</i>” Katherine points out.  “<i>And I used to live in a dump.  This is worse.</i>”\n\n");
			outputText("You can’t help commenting that you were surprised when you saw Urta’s apartment as being, well, a lot less glamorous then you’d expect for someone of her rank, but if all the Watch’s properties are so run down...\n\n");
			outputText("“<i>We just get whatever places the Council assigns us, okay?</i>” Urta snaps, bristling with hurt pride.  “<i>Do you want to get a job or not, pussy cat?  Believe me, it’s a lot sturdier than it looks, and a lot better kept inside.</i>”");
			if (silly()) {
				outputText("You joke that maybe you should get your ghostbusting gear?  Just in case?\n\n");
				outputText("“<i>There’s no such thing as ghosts!</i>” Urta snaps.");
				if (kGAMECLASS.shouldraFollower.followerShouldra()) {
					outputText("You would beg to differ, you happen to not only know one... but is also carrying one right at this instant...\n\n");
					outputText("“<i>Oh? So why doesn’t he come out and say hello, huh?</i>” Urta snarks, clearly feeling very put out.\n\n");
					outputText("“<i>Don’t mind if I do!</i>” an ethereal voice replies out of your chest.  A familiar face emerges, grinning widely.  “<i>Boo,</i>” Shouldra states, simply.\n\n");
					outputText("Urta and Kath’s jaws drop in unision, both staring dumbfoundedly at Shouldra.  Looks like they’ve never seen a ghost before.  “<i>I can see at least two bodies I wouldn’t mind getting to know better... but first, let’s see what you’re packing...</i>”  Shouldra’s hand emerges from your chest and she makes a few arcane gestures, aimed at both Kath and Urta.  At once, the two’s outfits tent as their mismatched dicks swell as erect as they can between the ghost’s magic and their restraining garments.  Urta yelps in that way she has and tries to cover herself up; Kath just looks surprised, but doesn’t make any effort, figuring that it must be harmless.\n\n");
					outputText("“<i>Wow, jackpot!  Come here my swollen-dicked morsels, let’s have some fun!</i>”  Shouldra lunges after both Kath and Urta, who promptly scamper, not happy with the idea of becoming a ghost’s plaything.  You just watch the spectacle unfold and both the herms and Shouldra vanish from your sight...\n\n");
					outputText("A few minutes later, both Urta and Kath return... panting and with their respective tents visibly absent...\n\n");
					outputText("“<i>Oh, dear sweet Marae’s mercy, we finally lost that freaky ghoulie,</i>” Urta pants, tongue lolling out in a very canine fashion.\n\n");
					outputText("“<i>That’s not funny, " + player.short + "! Kath shouts at you, tail jutting out like someone stuck a broom up her ass and swollen twice its usual girth with bristling hair.\n\n");
					outputText("You just shrug and tell them that - unfortunately - that one is out of your control.  “<i>So why do you put up with her?</i>” they promptly ask, even as they recompose themselves.  You shrug once more, replying that even you don’t know that...");
				}
				else if (flags[kFLAGS.TIMES_MET_SHOULDRA] > 0) {
					outputText("You would beg to differ... you happen to know one actually...\n\n");
					outputText("“<i>...Have you been spending too much time out in the sun, " + player.short + "?</i>”  Urta's the one who said it, but Katherine nods her head in agreement, looking just as concerned that you’ve lost it.\n\n");
					outputText("You just shrug... telling them that if they don’t believe you, maybe you should take them to meet her someday?\n\n");
					outputText("“<i>...Yeah, maybe.</i>”  Is the again-mutual sentiment of both herms.");
				}
				else {
					outputText("You just snicker.");
				}
			}
			outputText("You suggest that Urta just open the gate so the three of you can get in and get started... if Urta says the building won’t collapse, then you trust her... and Kath should too.\n\n");
			outputText("Urta huffs and, trying to salve her wounded dignity, removes a key from a belt pouch, opening the padlock and then pulling the doors open before heading inside, leaving you and Kath to follow.\n\n");
			outputText("The interior is, much as Urta promised, in far better condition than the exterior.  It’s a large and mostly empty space; a small kitchen in one corner, with a large table, some seats and a few bedrolls close by, an assortment of training dummies scattered around the periphery of the single room that dominates the building, and what looks like a maze built out of translucent glass panels.\n\n");
			outputText("“<i>Alright, Katherine.  You can park your gear over in the corner, but, first, you’re probably wondering why you’re here, right?</i>” Urta declares.\n\n");
			outputText("“<i>To learn the skills I need to be in the Watch?</i>” Kath replies, sarcastically.\n\n");
			outputText("“<i>It’s not easy to join the Watch.  Yeah, we’re technically always looking for recruits, but not every wanna-be makes the grade.  I know what it’s like on the streets; I spent a lot of cold, lonely nights, eating out of garbage cans, sleeping in alleys, running away from anyone too big or mean or tough to fight off, cracking heads to keep what was mine when I had to.  And let me tell you, the Watch isn’t that different.  If you’ve survived on the street this long, you can survive in the Watch.</i>”  Urta trails off, clearly not sure what else to say.\n\n");
			outputText("Yep... Urta wasn’t kidding when she said she was bad at giving “<i>pep talks</i>”...  You decide to end this increasingly painful string of nonsense and state the point Urta is trying to make.  Basically, you tell Kath, Urta means that if you work hard, you’re sure to make it into the Watch, and she knows what you have to go through on a daily basis, so she can understand your reluctance to join.  But she shouldn’t give up on joining, because this is her shot at a better life, a better future, and not just for herself;  her friends and Tel’Adre are sure to benefit from a recruit as fine as Kath will be.\n\n");
			outputText("Urta pouts, clearly not too happy at having her thunder stolen, while Kath rolls her eyes.  “<i>Corny much, " + player.short + "?</i>”  Still, there’s a twinkle in her eyes that makes you feel you really have bolstered her spirits.  “<i>So, what does this training consist of, anyway?</i>”\n\n");
			outputText("Upon hearing that, you grin evilly at Urta and ask her if you should get the package?\n\n");
			outputText("Urta shakes her head and passes you the key, indicating silently that you should lock the front door instead.  Nodding in agreement, you concur that this is probably a good idea, there’s no telling how Kath will react.\n\n");
			outputText("The cat-morph watches nervously as you and Urta head your seperate ways.  As the fox rummages amongst the junk on the side, she audibly professes, “<i>Why do I think I’m not going to like this?</i>”\n\n");
			outputText("You tell Kath to relax, this will all be over soon...\n\n");
			outputText("“<i>Okay, now I’m really worried,</i>” she retorts, eyes flicking nervously between you and Urta.\n\n");
			outputText("“<i>Before we begin, you should put this on,</i>” Urta says, holding the chastity belt towards Kath.\n\n");
			outputText("Kath stares at it for several long moments, saying nothing.  You wonder if Urta broke her by showing it to her like that.  “<i>What?</i>” she asks, her tone flat, clearly not comprehending - or wanting to believe - what Urta is telling her.\n\n");
			outputText("“<i>You heard me, put it on,</i>” Urta states impatiently.\n\n");
			outputText("Kath just stares at you, then flattens her ears, bristles her tail, and hisses at you both, holding up one hand with fingers splayed before claws the size of gutting knives suddenly sprout from the tips.  “<i>No way!  I didn’t come here for no kinky sex, bitch!</i>” she spits.\n\n");
			outputText("Urta rolls her eyes.  “<i>It’s not for kinky sex... it’s part of your training.  Demons attack you with lust as well, so we need to make sure you can handle the pressure.</i>”  She takes a few steps towards Kath.  You just watch the show unfold before you...\n\n");
			outputText("Kath spits, just like an angry barn cat.  “<i>Touch me with that and I’ll claw your eyes out!</i>” she warns.\n\n");
			outputText("“<i>Oooh, looks like this kitten has some fire in her after all... I’m the captain of the Watch, I’ve been threatened with things much worse than claws; so if you think that is going to scare me, you’re dead wrong.  Now put on the belt!</i>” Urta growls intimidatingly.\n\n");
			outputText("Kath lets out a surprisingly feral yowl, and then bolts for it, racing towards the other end of the safehouse in hopes of getting away from you and the vulpine captain.\n\n");
			if (silly()) {
				outputText("It’s a long shot... but you decide to try something... You extend a hand and start chanting, “<i>here, kitty, kitty.</i>”\n\n");
				outputText("Urta stops bristling in anticipation of a fight with Kath and instead looks at you in confusion.  “<i>What are you doing, " + player.short + "?</i>”\n\n");
				outputText("You explain this is just a method you used to use in order to get stray cats to approach you back in your village.\n\n");
				outputText("“<i>Oh? Does it really work?</i>” Urta asks, sounding intrigued.\n\n");
				outputText("You stop to think about it... and finally conclude that, no.  Usually it doesn’t...\n\n");
				outputText("“<i>Figures...</i>” Urta huffs in disappointment, even as Kath hisses at you from where she’s accidentally cornered herself.\n\n");
			}
			outputText("“<i>Okay, kitten.  Last chance to get over here and step into the belt,</i>” Urta threatens.\n\n");
			outputText("“<i>Come and make me, voop.</i>” Kath spits, claws extended on all fingers now.\n\n");
			outputText("Urta growls, and you think you hear her mutter “<i>gladly...</i>” under her breath.  Nevertheless Urta rushes Kath with tremendous speed, closing the distance between the two of them in mere moments.  Kath, barely has time to gasp in surprise, before Urta takes one of her arms, twists it and drops Kath facedown on the floor.  She wastes no time, quickly getting the belt in position and trying to close the latch on the dazed feline.  Kath instinctively tries to kick at the fox, but she easily pins her legs to the ground and closes the latch with a triumphant click.  Urta easily dodges a claw aimed at her side and smiles at her success.  “<i>This is what you get for insulting me.</i>”\n\n");
			outputText("“<i>Insulting?</i>” you can’t resist asking.  You’ve never heard the word that Katherine used before.  “<i>It’s not really that bad, but rude all the same - it’s kind of like calling a dog or a wolf a bitch,</i>” Urta replies, gracefully dodging yet another swipe from the thrashing cat underneath.\n\n");
			outputText("You make an understanding noise, then ask if Urta is going to make Katherine keep the belt on permanently - or at least until she gets through this training regime?  “<i>Just until her training is complete.  In fact, here, catch.</i>”  Urta tosses you the spare key to Kath’s bindings.  “<i>Don’t be too nice to her though,</i>” she warns.\n\n");
			outputText("You clarify that you thought the original plan was Kath would wear the belt for a training session and then take it off; is she going to make her keep it on until the entire course of training is over, given how much of a fuss Kath just kicked up over putting it on?\n\n");
			outputText("“<i>Definitely.  If we have to go through that every time we come here to train, we’ll never get any actual training done,</i>” Urta huffs.\n\n");
			outputText("“<i>I’ll be good,</i>” Katherine meekly promises.  “<i>Just don’t make me keep this on - days with no sex? I couldn’t take it!</i>” she pleads.  Urta shakes her head.  “<i>Sorry kitty, I gave you a chance, but you didn’t take it.  So if you want any relief from that belt, you’d better do as we say and train diligently.</i>”\n\n");
			outputText("“<i>I will!  I swear it!  Please, just, please, don’t make me stay in this thing all the time!</i>” the cat whimpers.  Urta pays no heed to Kath’s pleas though.  “<i>If you perform well during the training, I’ll let you off the belt to blow some steam, but until then - get used to it.</i>”\n\n");
			outputText("Kath mewls sadly, but nods her head in dismayed agreement.  For her sake, you hope she’ll try to get back into Urta’s good books.\n\n");
			outputText("Urta turns to you.  “<i>I got things here, lover.  If you want to you can see yourself out, I’ll make sure miss paws here understands fully what she’s gotten herself into.  Don’t forget to visit every once in awhile, I may need your help with one thing or another.</i>”\n\n");
			outputText("You nod your head in understanding.  Turning to Katherine, you wish her well and ask her to try her best; you want her to get this job, for her sake and yours.  You then promise Urta to drop by and see how the training is going; if you can, you’ll try and help out.  “<i>It’s a date, bye lover.</i>”  Urta waves you off, before turning to the whimpering cat-herm on the ground.\n\n");
			outputText("You promptly leave, hoping that the two will be able to come to terms somehow while you’re not there.");
			flags[kFLAGS.KATHERINE_UNLOCKED] = 3; //Indicates you’re now training her with Urta - This also disables meeting Urta in the Wet Bitch
			flags[kFLAGS.KATHERINE_TRAINING] = 0;
			doNext(camp.returnToCampUseOneHour);
		}

		public function katherineTrainingWithUrta():void {
			clearOutput();
			outputText("From Oswald's pawnshop you retrace your steps to the safehouse where Urta is getting Kath into shape and rap your knuckles against the door.\n\n");
			if (flags[kFLAGS.KATHERINE_TRAINING] >= 100)
				katherineTrainingWithUrtaComplete();
			else if (flags[kFLAGS.KATHERINE_TRAINING] >= 66)
				katherineTrainingWithUrtaStage3();
			else if (flags[kFLAGS.KATHERINE_TRAINING] >= 33)
				katherineTrainingWithUrtaStage2();
			else katherineTrainingWithUrtaStage1();
		}
		
		private function katherineTrainingWithUrtaStage1():void {
			outputText("“<i>Come in, " + player.short + "! It’s open!</i>”  You hear Urta’s voice from the other side, followed shortly by a string of yells aimed at someone you can only presume to be Katherine.  “<i>No, no, no!  Sheesh, <b>I</b> can do it better than that, and I spend half my life parked behind a desk filling paperwork!</i>” she yells; evidently, Katherine isn’t doing so well.\n\n");
			outputText("“<i>Is that what you call sitting in a bar and drinking yourself into a stupor?</i>” the cat-herm sarcastically retorts.  You wonder if you’ll hear a whip cracking in response, but the fox-herm evidently has better control of herself than that.\n\n");
			outputText("Sounds like the girls are having a heated argument.  You sigh... so much for them having something in common...  You turn the knob on the door and let yourself in, just in time to see a growling Urta glaring at a panting Kath.\n\n");
			outputText("“<i>When are you going to start taking this seriously, kitty?  These skills are essential if you ever get sent outside the walls!</i>”\n\n");
			outputText("“<i>Since when do you send people out into the desert anyway?  Besides, it’s hard to concentrate when you’re stuck in this stupid thing,</i>” the cat replies, tapping a claw-like fingernail meaningfully on the chastity belt she’s wearing.\n\n");
			outputText("“<i>You can’t seriously be aroused already - I’m the only one here, and it’s not like I’m in heat.  It should only be bothering you if you’re too much of a slut to control yourself!</i>” Urta snaps back.\n\n");
			outputText("Before things can escalate into a fight, you interject, yelling both of them to stay quiet!  This is not helping either of them!  You step between the two girls, crossing your arms and glaring at both of them.  You tell them to apologize to each other so the three of you can carry on.\n\n");
			outputText("Bristling, the two glower half-heartedly at each other and mumble a tired sounding, “<i>sorry,</i>” simultaneously.  You’re not sure if they’re really still hating each other, or they just don’t want to try and get along for whatever reasons.  Still, you suppose this will have to do, for the moment.  Turning to Urta, you ask her about the details of this training.  What exactly is Kath supposed to do?\n\n");
			outputText("“<i>Well, part of being a Watch recruit is being able to look after yourself if you get sent out beyond the city, right?</i>”  The vulpine officer explains.  You nod in agreement, motioning for her to go on.  “<i>So, that means you need to know how to look after yourself out in the wilderness.  We covered firemaking and foraging already - she actually passed those pretty well, quicker than a lot of recruits I’ve seen,</i>” she admits, which makes Kath blink in shock at hearing her skills praised.\n\n");
			outputText("You turn to smile at Kath and then ask.  If Kath did as well as Urta’s saying, what seems to be the problem?\n\n");
			outputText("“<i>The problem is the shelter-finding part of the training,</i>” Urta sighs.  “<i>Living in the streets has made her soft; there’s always an alleyway or a rubbish heap or an abandoned building to hide in.  I mean, yes, it hasn’t rained in the last twenty years, but that doesn’t mean shelter’s not important.  I’m trying to get her to learn how to set up a tent.</i>”\n\n");
			outputText("You nod in agreement.  Even if there is no rain, there are other elements that she would need protection from; for instance, if she ever has to camp in the desert, where there is no cover, and a sandstorm kicks in, she’d be in deep trouble without a tent.\n\n");
			outputText("“<i>That’s exactly right - I’ve been in one of those sandstorms without shelter, and I was terrified I was going to die.  And that was just a gentle one,</i>” the fox agrees.\n\n");
			outputText("Turning to Kath you ask her what is the problem?\n\n");
			outputText("The cat grimaces at you.  “<i>Despite the fact that even if I’m not horny, this belt feels all wrong on me?  I’ve never done anything like this before, and prickvixen’s instructions on how to make a house out of sticks and cloth aren’t exactly easy to understand, you know?</i>”\n\n");
			outputText("“<i>In case you haven’t noticed, you’re a herm too, so lay off the gender insults,</i>” Urta snaps.\n\n");
			outputText("“<i>...It’s supposed to be a nickname, not an insult.  What’s wrong with having a girlcock?</i>” Kath asks, looking puzzled, even as Urta looks angrily sheepish before carefully schooling her features into neutral blankness.\n\n");
			outputText("You step closer to Kath and ask if she’d like you to try and explain how to build a tent for her?  You’ve already erected your own, after all.\n\n");
			outputText("“<i>Please?</i>” Kath begs.  “<i>I could really use some advice from someone who does this for a living.</i>”  She casts a teasing look at Urta, who simply huffs, either too tired or too honest to get upset over it.\n\n");
			outputText("You instruct her carefully, making sure she understands how each piece comes together; you tell her how to tie the tent down, so the wind won’t carry it, how to properly hold the structure together and even how to quickly pack everything up, should she need to move quickly.\n\n");
			outputText("Kath sits there quietly, intently following your every move, listening to everything you say - at least, you hope so.  Finally, she nods and starts to pick up the pieces of her tent...");
			switch (rand(3)) {
				case 0: doNext(katherineTrainingWithUrtaStage1Success); break;
				case 1: doNext(katherineTrainingWithUrtaStage1Failure); break;
				case 2: doNext(katherineTrainingWithUrtaStage1Horny);
			}
		}

		private function katherineTrainingWithUrtaStage1Success():void
		{
			clearOutput();
			outputText("When she’s done, what stands before you is a pretty well-made tent.  Some room for improvement, but, all in all, you think it’s acceptable.  Looking at Urta, she seems to agree; she nods and then smiles at Kath.  “<i>Not bad, kitty, not bad; I’d say you pass this test.</i>”\n\n");
			outputText("“<i>...I did it?</i>” Kath repeats, eyes widened in shock.  “<i>...I did it!</i>” she cheers, dancing with glee in front of you, laughing with joy.\n\n");
			outputText("You laugh at her reaction, clapping in order to congratulate her.  Urta smiles slightly, then schools her face to look stern.  “<i>Alright, kitty, you passed the test - now let’s see you do it again!</i>”\n\n");
			outputText("“<i>What!?  But! ...aw...alright,</i>” Kath sighs, and promptly starts dismantling her tent.  “<i>Hey, seeing as how I did this once already, can I get this stupid belt taken off now?</i>”\n\n");
			outputText("“<i>No,</i>” is all Urta will say on that.\n\n");
			outputText("“<i>That’s not fair!</i>” Kath protests.\n\n");
			outputText("“<i>Do it successfully five times, and I’ll let you take it off.  Heck, do it ten times successfully with it on and without complaining, I’ll even give you a handjob - not that I think you’ve got the balls to take up a challenge like that,</i>” the vulpine herm smirks.\n\n");
			outputText("“<i>You’re on, pricky-vixxy!  I’m gonna enjoy being able to boast that the captain of the guard was sucking on my cock!</i>” Kath crows.\n\n");
			outputText("“<i>Uh, you gotta work your way up to stakes like that, all I’m offering is a handjob, kitty,</i>” Urta points out.  “<i>And stop with the prick-vixen stuff!</i>”\n\n");
			outputText("“<i>You’re just scared because you know I’d win,</i>” Kath replies.\n\n");
			outputText("“<i>Confident, huh?  Fine, let's up the ante then!  Do it ten times in a row and I will blow you... for a whole day... but if you lose... YOU are going to blow me instead!</i>”\n\n");
			outputText("You look at Kath, shaking your head lightly, trying to dissuade her from taking Urta up on her offer.  Even for someone as experienced as yourself, putting a tent up so many times without fail might be a challenge.  Miss one little detail and the tent comes crashing down!  You hope Kath will listen to you on this one...\n\n");
			outputText("“<i>Alright, you’re on; I hope you got room for all I’ve got!</i>” Kath cries excitedly, then practically throws herself at the tent equipment.  You sigh and roll your eyes in exasperation; well, either Kath will learn, or she might actually win by sheer dumb luck.  Either way, you decide it’s time you left and gave them a chance to get on with it.\n\n");
			outputText("You bid farewell to Urta and wish Kath luck, then twist the knob and see yourself out...");
			flags[kFLAGS.KATHERINE_TRAINING] += 16;
			doNext(camp.returnToCampUseOneHour);
		}

		private function katherineTrainingWithUrtaStage1Failure():void
		{
			clearOutput();
			outputText("The end result of all Kath’s hard work, however, isn’t very good.  It looks like a stiff breeze would knock it over... and, seconds later, that’s what happens.  Kath’s face falls and she scuffs idly at the floor with one foot, while Urta sighs and shakes her head gently and you quietly encourage her to try again.\n\n");
			outputText("“<i>I’m going to keep trying this until I get it right,</i>” Kath vows to you.\n\n");
			outputText("“<i>You better; I can’t move on to the next phase until you’ve passed this test,</i>” Urta points out.\n\n");
			outputText("You sigh and tell Kath you also made many mistakes before finally managing to build one.  But what’s important is her determination; as long as she keeps trying, she is bound to make it, and you’ll be cheering for her.\n\n");
			outputText("“<i>You really think so, " + player.short + "?</i>” she asks, looking to you with a hopeful expression.\n\n");
			outputText("“<i>Of course!</i>” you say, smiling.\n\n");
			outputText("She promptly throws her arms around you in a tight squeezing hug.  “<i>Then I’m going to try and try until I get it right.  I want to make you happy,</i>” she insists.\n\n");
			outputText("You return her hug, gently caressing the back of her head.\n\n");
			outputText("“<i>Okay, that’s enough of the fluffy stuff, time to get back to work!</i>” Urta snaps, breaking up your little moment.  Doubtlessly, she’s still not entirely comfortable with seeing you being affectionate with someone else in front of her - and the fact she and Kath aren’t getting along isn't helping, naturally.\n\n");
			outputText("Feeling like there’s nothing else to be done here at the moment, you bid the girls farewell and return to camp.");
			flags[kFLAGS.KATHERINE_TRAINING] += 8;
			doNext(camp.returnToCampUseOneHour);
		}

		private function katherineTrainingWithUrtaStage1Horny():void
		{
			clearOutput();
			outputText("Kath tries and fidgets, but eventually casts the tent equipment aside.  “<i>It’s no use, I’m too horny!  I didn’t get a chance to jerk myself off this morning... and prickvixen here walking around with no pants on and flashing her goods in my face all the time isn’t helping!</i>” she wails.\n\n");
			outputText("“<i>I do not flash my goods in anyone’s face!</i>” Urta protests, blushing with embarrassment.\n\n");
			outputText("“<i>Then what about at breakfast, when you were washing up?  Tail wagging all over the place - I could look right at your pussy every time it wasn’t hanging between your legs,</i>” Kath drawls.\n\n");
			outputText("Looking at Urta you tell her that does seem like something she would do when drunk...\n\n");
			outputText("“<i>I don’t drink that much in the morning, and certainly not while I’m working here!</i>” the vulpine herm retorts indignantly.\n\n");
			outputText("Okay... you apologize.  Still you oughta do something about Kath, she really looks in pain...\n\n");
			outputText("Kath promptly clasps her hands in front of you and stares at you and Urta alike with her eyes as wide and pleading as possible... how is it that she can look so much like an adorable little kitten when she wants to?\n\n");
			outputText("“<i>...Ugh, fine, I guess we can do something for her.  What do you have in mind? ...Besides taking the belt off, of course?</i>” Urta asks.\n\n");
			outputText("Hmm... this is supposed to help Kath develop some resistance to lust, so actually fucking her is out of question.  Maybe a handjob?  Just to help her get her rocks off so she can focus on the task at hand?  Figuring this could also be a great opportunity to help them get along... you suggest Urta should be the one giving her a handjob.\n\n");
			outputText("Both of them look at you as if you just sprouted another head.  “<i>What!  No way!  I don’t want her hands on my dick - besides, what would she know about giving a handjob anyway?</i>”  Kath protests.\n\n");
			outputText("“<i>I’ll have you know I’m an expert when it comes to using my hands on a dick - I’ve got years of practice on my own,</i>” the fox proclaims with wounded dignity.\n\n");
			outputText("“<i>Of course you would, you had nobody else to practice with,</i>” Kath retorts.  Urta flinches at that, looking genuinely wounded.\n\n");
			outputText("“<i>Hey!</i>” you interject.  “<i>That is not something you say to someone who is using her off-time to help you out!  Maybe you should stay in your belt after all... you’ll cool off sometime later...</i>”\n\n");
			outputText("“<i>You wouldn’t!</i>” Kath protests in horror.\n\n");
			outputText("You wouldn’t?  After saying something so inconsiderate, you damn well should!  Or need you remind her that she was in basically the same situation as Urta before you met her?  You wouldn’t blame Urta for leaving her hanging after saying something like that.  If Kath has any hopes of getting out of that belt anytime soon, she’d better apologize!\n\n");
			outputText("The feline herm has the decency to look genuinely ashamed of herself as she turns to Urta, “<i>I’m sorry, Ms. Urta,</i>” she says.\n\n");
			outputText("“<i>...Just Urta, is fine,</i>” Urta grumbles, then heaves a sigh.\n\n");
			outputText("You nod your head, that’s much better now...\n\n");
			outputText("Kath then turns to you.  “<i>Can you let me out of this belt now?  Please?</i>” she begs.  You sigh and tell her that if she wants release, she’d better talk to Urta.  After what she’s done, you don’t really feel like granting her release.\n\n");
			outputText("“<i>Oh, come on!</i>” Kath protests, but you just ignore her.  “<i>Fiiine!</i>” she concedes, the fur on the back of her neck bristling.  She turns to Urta and takes a deep breath.  “<i>Can you grant me release?  Please?</i>”\n\n");
			outputText("Urta just scowls and then storms off; clearly, this was pushing her a bit too far.  So much for things working out between the two of them... You hurry to catch up and try to convince her to cool down and give it a try.  You’d like them to get along; you feel that if they tried they could be really good friends... so why not give Kath a break?\n\n");
			outputText("“<i>...I’d find it easier to give her a break if she’d stop being such a mouthy little -</i>” she trails off, making a sound you’re not sure a human could replicate.  “<i>It’s not that I mind the idea of you and her being together so much, but she keeps trying to push my buttons, and all because I’m part of the Watch!  If she’s not going to try and respect me, why should I respect her?</i>”\n\n");
			outputText("You explain to her that Kath’s had it rough with the Watch... she views the Watch as a bunch of bullies, and you’re trying to show her she was wrong.  Urta heaves a huge sigh, “<i>Yeah, I can understand that, but it’s hard to resist the urge to punch her sometimes when she goes and gets mouthy like that.  I’m a Watchwoman, yeah, but I’m a person too - if she won’t see me as anything other than the enemy, then I’m not sure I should bother helping her.</i>”\n\n");
			outputText("Well... one of them has to give... otherwise this just won’t work.  Seeing no other option, you take hold of Urta’s head and pull her into a kiss, letting your hands wander over her butt and rapidly erecting horse-cock.  The surprised fox stiffens, but then eagerly melts into your embrace, too hungry for your affection to hold onto her frustration with Kath.\n\n");
			outputText("Breaking the kiss you ask her to do this for you... in exchange you’ll make it worth her while.  You smile seductively at her.  “<i>You do not play fair, " + player.short + ",</i>” Urta tells you, tapping you playfully on the nose, a wicked grin curling on her lips.  “<i>What do you have in mind, hmm?  Something special?</i>”\n\n");
			outputText("You suggest that if she gives Kath a hand with her problem... you’d be happy to give her a hand with her own problem.  You gently reach for her shaft, sensuously teasing it with light touches.  Your vulpine partner moans, precum already starting to bubble out of her ever-ready prick.  “<i>Alright, you got a deal, sweet thing.</i>”  She suddenly grabs you and kisses you fiercely, striving to stun you with the intensity of her gesture.  “<i>I’m a lucky girl to have you... I just hope kitty realizes how lucky she is that she’s got you too.</i>”  She says after she finally breaks the liplock.\n\n");
			outputText("You smile at her, and motion for her to lead the way.  She nods, her prick bobbing before her.  Kath looks up in puzzlement as the two of you approach, while Urta tries to avoid blushing as she is exposed to her fellow mismatched herm.  “<i>Alright, seeing as how I’m in the mood too, I guess I can help you.</i>”\n\n");
			outputText("The cat simply shrugs, as if to say ‘what the heck’, and then nods.  Urta produces the key and unlocks the belt, which Kath practically tears off, her " + katherine.cockMultiple("", "twin ") + "doggie-dongs stabbing fiercely into the air, dripping with their need.  She promptly sits herself down on the floor, waiting for Urta to do the same.  With surprising shyness, the herm fox seats herself beside the cat.  “<i>Now, let’s see... you’re " + (katherine.cockLength <= 10 ? "a lot " : "") + " smaller than me, so let’s see how works...</i>” Urta mutters, cracking her fingers.  She then reaches out a hand and closes her fingers gently around Kath’s " + katherine.cockMultiple("", "upper ") + "shaft...\n\n");
			outputText("You could probably try and live up to your promise by giving Urta a handjob yourself, or just leave the two to pleasure each other.");
			var helpThem:Function = katherineTrainingWithUrtaStage1HornyHelp;
			if (player.gender == 0) helpThem = null;
			simpleChoices("Help Out", helpThem, "Leave", katherineTrainingWithUrtaStage1HornyLeave, "", null, "", null, "", null);
		}

		private function katherineTrainingWithUrtaStage1HornyLeave():void
		{
			if (player.gender == 0)
				outputText("\n\nToo bad you don’t have the parts to join on this bonding session... so you politely tell them that you have to go and then leave.");
			else
				outputText("\n\nFiguring you have other things to attend to, and that it gives them a better excuse to bond, you politely tell them that you have to go and then leave.");
			outputText("\n\nBy this time, both of them are starting to moan, Kath’s dark fingers clenching around the red flesh of Urta’s horse prick and beginning to slide up and down its formidable length; you doubt they even notice you going.");
			katherine.katherineAndUrtaHadSex(false);
			doNext(camp.returnToCampUseOneHour);
		}
		
		private function katherineTrainingWithUrtaStage1HornyHelp():void
		{
			threesome.circlejerk();
			doNext(circlejerkTrainingEnding);
		}

		private function circlejerkTrainingEnding():void
		{
			clearOutput();
			outputText("When you come to you're lying on your back - fairly clean, but still matted in some places with the results of your session with the lovely herms.  You stretch the kinks out of your limbs and sit up.  Immediately, you gaze upon Urta, scolding Kath for something she did wrong... both already dressed.  You don’t really catch what’s being said as Kath retorts... so the two are still bickering... you sigh.  Upon closer inspection though... you see something different... rather than scowling at each other they’re... smiling?  Well, well.  It seems these two can get along after all.\n\n");
			outputText("With a groan you rise to your feet, looking around to see if you can spot your " + player.armorName + ".  “<i>Hello, sleepy-head; 'bout time you woke up.</i>” Kath suddenly declares, spotting you getting up.  Urta turns to confirm and smiles.  “<i>Well, I guess we wore you out, huh?</i>” she jokes.  No kidding... you might have to think twice next time you decide to join them...\n\n");
			outputText("“<i>Well, maybe we’ll need to get together like this a little more often; we’re a trio now, aren’t we?</i>” Urta asks, smiling - and not a playful smile, a genuine one.\n\n");
			outputText("“<i>That’s right,</i>” Kath agrees, nodding her head, wearing the same smile.  You chuckle, it seems your little bonding session did work out after all... you tell Urta and Kath that you didn't think they’d grow so fond of each other so quickly.\n\n");
			outputText("“<i>We’re not friends!</i>” Urta promptly protests.  “<i>That’s right!  There’s no way I’m going to be friends with lady truncheon here as long as she keeps strapping me into that belt!</i>” Kath adds.  “<i>Oh yeah?  Well, as long as you keep running that mouth of yours off, I can’t be friends with you either!</i>” Urta snaps back.\n\n");
			outputText("The two start snarling at each other and you sigh, wondering aloud if maybe next time, you should make them shove their dicks in each other’s mouths.  The two herms blush and promptly break off their glaring match.  “<i>I think one of us oughta stick a dick in your mouth...</i>” Kath mumbles in an irked tone.  Urta raises her eyes at the suggestion.  “<i>Which one of us?</i>”  The cat shrugs her shoulders.  “<i>Flip one of those old coin-things?  Heads gets the face, tails gets the ass?</i>”\n\n");
			outputText("“<i>Both of us at the same time?</i>” Urta slowly states, “<i>...You’re kinkier than I thought, pussycat.</i>”\n\n");
			outputText("“<i>Then why are you getting hard at the idea, prickvixen?</i>”\n\n");
			outputText("Uuuh... looks like you’d better be going.  Looking around you quickly spot your " + player.armorName + " and get dressed, then bid the girls farewell, hurrying away back to camp before they get any more ideas.");
			doNext(camp.returnToCampUseOneHour);
		}

		private function katherineTrainingWithUrtaStage2():void
		{
			outputText("The sound of combat echoes from inside the safehouse; it being obvious you’re not going to get Urta or Kath to come and see you, you push on the door - surprisingly, it swings open, not being locked, and you head on inside.\n\n");
			outputText("“<i>Oh, hello, " + player.short + ",</i>” Urta calls to you, looking right at you even as she throws a punch that Katherine narrowly avoids.  The cat growls in frustration and charges at the fox, throwing a clumsy but strong-looking haymaker that Urta ducks, right before she attempts to grab and throw her “<i>trainee</i>”.\n\n");
			outputText("You watch them practice and jokingly ask if they have any popcorn around here?  It’s not everyday you get to watch a literal cat-fight.\n\n");
			outputText("“<i>Calling this a cat-fight would imply that this cat is actually fighting,</i>”  Urta drawls, even as she suddenly lunges forward in a straight-armed punch at her sparring partner.\n\n");
			outputText("To your surprise, Kath actually manages to intercept the blow with her forearm, deflecting it harmlessly but leaving herself wide-open for a palm-thrust from the fox that shoves her onto her ass.\n\n");
			outputText("“<i>Oof!</i>” Kath groans as she hits the floor, but doesn’t complain.\n\n");
			outputText("“<i>Getting better, kitty, but your defence still needs more work,</i>”  Urta says, a soft smile on her lips.  She extends a hand to Kath and, to your surprise, the cat wastes no time in accepting it.  She hauls the black-furred cat-herm to her feet and they both strike a fighting pose, clearly intended to start again.\n\n");
			outputText("Before they can begin anew, you interrupt, telling both girls you’d like to give Kath some instructions of your own.\n\n");
			outputText("“<i>Sure couldn’t hurt - she needs all the help she can get.  Go on, kitty, have yourself a private lesson,</i>”  Urta drawls, then surprises you by giving you a wink.\n\n");
			outputText("“<i>I thought you were supposed to be my private tutor,</i>” Kath deadpans, but she eagerly approaches you.  “<i>So, " + player.short + ", what did you want to tell me?</i>” she asks, curious.\n\n");
			outputText("You ask if she’d like a few pointers?  You’re no expert at hand-to-hand combat, but you did come to this realm without any weapons on you, so you can handle yourself... plus you’ve been travelling all over, facing the dangers of this realm, surely you can impart some of the knowledge you’ve gained to her?\n\n");
			outputText("“<i>Please, " + player.short + ", I’d love to hear some pointers from an expert,</i>”  Kath replies, giving a teasing grin at her vulpine tutor, who simply huffs noisily.\n\n");
			outputText("You loop an arm around her waist and draw her closer, conveying what you can in a hushed tone.  A little ways away, drinking from a small mug of water, Urta’s triangular ears twitch and you wonder if she’s trying to listen in to your conversation somehow... in any case you pull Kath even closer.  Kath clearly does her best to listen to you, but the way she fidgets makes it obvious that your proximity is starting to turn her mind to other matters...\n\n");
			outputText("The cat promptly wriggles out of your grip.  “<i>Alright, foxy, I’m coming for you now!</i>” she taunts Urta gleefully.\n\n");
			outputText("The vulpine officer merely yawns loudly.  “<i>About time, I was starting to fall asleep.  Come at me whenever you’re ready.</i>”\n\n");
			outputText("Before Kath can go, you pull her close once more to give her a light kiss on the lips, wishing her good luck.\n\n");
			outputText("The cat meows softly and breaks away, blushing softly.  “<i>T-thank you, " + player.short + ",</i>” she says, even as she walks away from you.  A certain awkwardness in her step suggests that maybe that wasn’t such a good idea; it looks like you’ve turned her on...\n\n");
			outputText("As the two herms adopt a fighting stance, Urta leers.  “<i>Just be lucky that this isn’t the wasteland, kitty, or I’d be sticking this cock of mine into you and filling you up like an old condom when I win.</i>”\n\n");
			outputText("“<i>Don’t be too confident, my pretty prickvixen,</i>” Kath laughs back.  “<i>Maybe you’d like to make a bet?  Loser has to cook dinner for and hand-feed the winner tonight?</i>”  She suggests.\n\n");
			outputText("“<i>Fine by me - but I hate fish,</i>” Urta warns her.\n\n");
			outputText("You take a seat on a chair nearby, this will be interesting...");
			switch (rand(3)) {
				case 0: doNext(katherineTrainingWithUrtaStage2Success); break;
				case 1: doNext(katherineTrainingWithUrtaStage2Failure); break;
				case 2: doNext(katherineTrainingWithUrtaStage2Horny);
			}
		}

		private function katherineTrainingWithUrtaStage2Success():void
		{
			clearOutput();
			outputText("Kath lunges at Urta, aiming a punch straight at the vixen’s face.  Urta ducks under the blow effortlessly, then charges Kath.  With a confident smirk, Kath intercepts Urta and pulls her down and over her body, throwing the surprised vixen over her head and down on the floor with an audible <b>thud</b>.\n\n");
			outputText("The fox-herm lays there on the floor, looking quite stunned indeed.  She finally shakes her head and looks up at Kath.  “<i>I can’t believe that happened - do you know nobody’s ever beaten me before?  Nice job, Kath.</i>”\n\n");
			outputText("You applaud the cat-herm, clearly the plan worked flawlessly.");
			flags[kFLAGS.KATHERINE_TRAINING] += 16;
			doNext(camp.returnToCampUseOneHour);
		}

		private function katherineTrainingWithUrtaStage2Failure():void
		{
			clearOutput();
			outputText("Kath lunges at Urta, aiming a punch straight at the vixen’s face.  Urta ducks under the blow effortlessly, then charges Kath.  With a confident smirk, Kath intercepts Urta and pulls her down and over her body, trying to throw the surprised vixen over her head, but unfortunately, Urta twists her body around and pins the helpless cat-herm under her into a submission hold.\n\n");
			outputText("“<i>In a hold like this, you’re helpless.  Time to give up, kitty,</i>” Urta says in a matter of fact tone of voice.\n\n");
			outputText("“<i>No way!  I’m not a coward - I won't give up that easily!</i>” Kath protests indignantly.\n\n");
			outputText("Urta sighs softly and begins to tighten her hold.  “<i>You can give up, or you can get hurt, that’s the way this move works.</i>”  Kath furiously struggles and wriggles in the fox’s grip, but eventually decides Urta’s right.  “<i>Alright, aunty, aunty, I give!</i>” she pleads.  Urta promptly lets her go and stands up.  “<i>...Aunty?</i>” she asks, curious.  Kath gets up and shrugs; “<i>I don’t have an uncle,</i>” she replies.\n\n");
			outputText("Urta just shakes her head.  “<i>Anyway, not a bad move, kitty; if I hadn’t noticed what you were trying, you would have beaten me with that move for sure.  Need to work on your speed,</i>” she concludes.\n\n");
			outputText("Kath sighs and says, “<i>Well... is some water too much to ask for?</i>”  You promptly head over to the makeshift kitchen, filling a glass from a sizable jug of water there and bring it to her.  Katherine thanks you and proceeds to eagerly drink it down.  When she’s done she gasps for air and wipes her mouth.  “<i>Alright, I’ll keep working on this until I beat you, foxy!</i>” she vows, dramatically pointing a finger at an amused-looking Urta.");
			flags[kFLAGS.KATHERINE_TRAINING] += 8;
			doNext(camp.returnToCampUseOneHour);
		}

		private function katherineTrainingWithUrtaStage2Horny():void
		{
			clearOutput();
			outputText("Kath lunges toward Urta, trying to goad her into charging just as you suggested.  When Urta closes Kath tries to duck under Urta’s blow and throw her.  Urta realizes what’s happening at the last moment and manages to get an arm around Kath.  The two of them collapse to the ground as a mess of limbs as each of your girlfriends tries to pin the other.\n\n");
			outputText("You think to yourself that the fight could still go either way.  Even though Urta is stronger Kath’s extra flexibility means that pinning her is way more difficult than it should be.  Time and time again Urta locks one of Kath’s arms behind her only to have Kath twist in some impossible way and yank it free again.\n\n");
			outputText("Kath manages to roll on top and wraps her legs around Urta’s waist.  Urta bucks and tries to pry Kath off but she’s locked on like a vice.  You think Kath might just have the upper hand this time - and then she lets out a deep purr and tries to kiss Urta.\n\n");
			outputText("Urta rolls back on top of Kath and pins her firmly to the floor.  “<i>Well puss, that’s what happens when you think with your cock,</i>” Urta says, smiling. “<i>Expect to wake up in some alleyway missing some of your gems and all of your dignity.</i>”\n\n");
			outputText("Urta tries to get up but Kath’s legs are still locked around her waist.  Kath grins and asks “<i>What happened to filling me up like a big condom if you win?</i>”\n\n");
			outputText("“<i>That was <b>if</b> we were in the wasteland.  Get off already!</i>” Urta looks over at you and mutters “<i>You told her what to do, so I blame you for this.</i>”  While Urta uses the key to unlock Kath’s chastity belt you protest that this wasn’t what you suggested.  As Kath’s cock springs free, flicking some drops of pre across the floor Urta cuts you off.  “<i>You wanted to help with her training, so you can help me fill this little kitty.</i>”");
			var spitroast:Function = threesome.spitroastKath;
			if (player.gender == 0) spitroast = null;
			simpleChoices("Spitroast", spitroast, "Leave", katherineTrainingWithUrtaStage2HornyLeave, "", null, "", null, "", null);
		}

		private function katherineTrainingWithUrtaStage2HornyLeave():void
		{
			if (player.gender == 0)
				outputText("\n\nYou gesture toward your featureless crotch and remind Urta that there's no way you're going to be able to help fill Kath.  You wish her the best of luck and wave goodbye as Kath, now free of her chastity belt, wraps herself around Urta once more.");
			else
				outputText("\n\nYou’ve already been away from camp for a while.  You need to get back there and check on the portal.  Besides, Kath and Urta are getting along with each other better every time they have sex.  Katherine starts to lick at one of Urta’s nipples.");
			outputText("  Urta tries to fight her off, calling out, “<i>" + player.short + "!  I need some backup here.  This is <b>your</b> cock hungry kitty.</i>”  Urta tries to bat Kath’s arms away but she’s clearly turned on and you slip out before you get too horny to leave.  You’re sure they’re getting along just fine without you.");
			katherine.katherineAndUrtaHadSex(false);
			doNext(camp.returnToCampUseOneHour);
		}

		private function katherineTrainingWithUrtaStage3():void
		{
			outputText("Much to your surprise, a stiff looking Kath opens the door.  She puffs out her chest and clears her throat.\n\n");
			outputText("“<i>Greetings citizen, how may I help you?</i>” she asks, shakily.\n\n");
			outputText("“<i>No, no, no,</i>” Urta states, appearing behind the depressed-looking cat.  “<i>You need to be confident, but relaxed at the same time.  Oh, hello, " + player.short + "; come on in, I’m just trying to help Kath learn how to talk like a guard.</i>”\n\n");
			outputText("Katherine mumbles something half-hearted, but then steps aside to let you in.\n\n");
			outputText("You come inside and comment that from what you’ve seen, things aren’t going along as planned, huh?\n\n");
			outputText("“<i>No, they’re not.  I don’t know, I used to think I was a bit of a shrinking violet, but Kath here puts me to shame,</i>” Urta says, heaving a melodramatic sigh.\n\n");
			outputText("“<i>You’ve had lots of practice at it, Urta.  I haven’t,</i>” Kath grumbles in return.\n\n");
			outputText("Well, this kind of training is really important.  If Kath can’t sound authoritative when out on patrol how can she expect to be respected?  Or feared, if it comes to that.\n\n");
			outputText("Urta nods her head sagely.  “<i>" + player.short + ", perhaps you’d be willing to help us?  Having somebody else to act as the civilian would probably work better than just the two of us going back and forth,</i>” she suggests.  Kath nods her head, making it clear that she agrees to Urta’s suggestion.\n\n");
			outputText("Considering Urta’s demeanor, it’s more likely that she’s the one doing the intimidating in their exchange, you joke.\n\n");
			outputText("“<i>Well that may be true, but she’s actually pretty good at standing up to me... most of the time,</i>” Urta concedes.  “<i>It’s getting her to be more assertive herself that’s the tricky part.</i>”\n\n");
			outputText("Hmm... well Urta is the specialist, so you’ll leave things in her hands.  Adjusting your " + player.armorName + " you ask what you should do?\n\n");
			outputText("The fox shrugs.  “<i>Just act like a defiant, disrespectful citizen - refuse to listen to her, try to make her back down, just generally encourage her to make you respect her.</i>”\n\n");
			outputText("You nod in understanding, telling her you’ll try.\n\n");
			outputText("“<i>Here, let’s have a demonstration; give you both an idea of what needs to be done.</i>”  The fox declares, then clears her throat.  “<i>Citizen, you are in a restricted area; please leave now.</i>”\n\n");
			outputText("Getting into character, you tell Urta to piss off, this is a free city!  You go wherever you want, whenever you want.\n\n");
			outputText("“<i>Citizen, if you will not obey orders and leave, then I will be forced to take you in,</i>” Urta warns you, meeting your gaze with a cold, level stare of her own.\n\n");
			outputText("You glare right back at her with a menacing gaze.  If she wants to get you out... why doesn’t she come here and make you leave?  Stupid vixen...\n\n");
			outputText("Urta promptly surges forward, seizing your wrists and rapidly pulling you into a powerful wrist-lock.  Even if this weren’t for pretend, you think you’d have a hard time pulling free of it.  “<i>You were warned, " + player.mf("mister", "miss") + "!</i>” she growls.  “<i>Come on now, let’s go, move it!</i>” she barks, pushing you to indicate you should start walking.\n\n");
			outputText("With no other choice, you grudgingly follow her instructions, murmuring a string of insults at her.\n\n");
			outputText("Urta walks you several steps, and then lets you go.  “<i>And there we are.  Fairly simple; you just need to remember that you should resort to violence against a non-monstrous hostile only as a last resort, but that generally isn’t hard to remember.  Now, we just need you to try and pull it off, Kath,</i>” she declares.\n\n");
			outputText("“<i>O-okay... I’ll try,</i>” Kath replies.");
			if (flags[kFLAGS.KATHERINE_TRAINING] >= 99) {
				doNext(katherineTrainingWithUrtaStage3Success);
			}
			else {
				switch (rand(3)) {
					case 0: doNext(katherineTrainingWithUrtaStage3Success); break;
					case 1: doNext(katherineTrainingWithUrtaStage3Failure); break;
					case 2: doNext(katherineTrainingWithUrtaStage3Horny);
				}
			}
		}

		private function katherineTrainingWithUrtaStage3Success():void
		{
			clearOutput();
			outputText("You enact your part while Kath enacts hers... at one point she seems to cower at your harsh words, but then she picks herself up and lunges at you, attempting to wrist-lock you.  Being far more experienced in combat, you manage to escape Kath’s inexperienced hold.  You are about to turn around when Urta interrupts the scene.\n\n");
			outputText("“<i>That’s enough, the pair of you,</i>” the fox states in her most authoritative tone.  Kath immediately lets you go, and Urta favors her with a smile.  “<i>Well done, kitty-Kath; your holds need some work, but you pass this test.</i>”\n\n");
			outputText("You congratulate her as well, at first you really thought she was going to give up trying, but she really pulled through.  However if she truly intends to catch you she’ll have to work a LOT more on her holds, you wink at her.\n\n");
			outputText("With a laugh, Kath throws her arms around you, squeezing you tightly - and then she lets go of you and crosses the distance to sweep Urta up in a delighted hug as well.  Urta looks totally shocked, but then smiles faintly and squeezes Kath back.  “<i>Look at you, you’re like a little kitten with a ball of yarn, aren’t you?</i>” she laughs.");
			outputText("“<i>Well, maybe I am, but I’m so happy - I finally did it!  Doesn’t this mean I’m in the Watch, now?</i>” Kath asks, looking Urta right in the eyes.\n\n");
			outputText("“<i>Now hold on there, kitten; there’s still a couple of tests you’ll need to take to prove you’ve got the skills,</i>” Urta warns, before she grins and declares, “<i>but personally, I’m sure you’ll pass the tests with flying colors.</i>”\n\n");
			outputText("Kath hugs Urta even harder at that, and starts to purr - much to Urta’s surprise, from the look on the vulpine herm’s face.  You repress a smile and tell Kath and Urta that, if they don’t need you anymore, you’ll head back to camp for now.\n\n");
			outputText("“<i>Ah, sure, " + player.short + ", go ahead,</i>” Urta replies in a distracted tone, still cuddling the purring cat-herm and looking kind of spooked at the fact.  You wish Kath luck in her upcoming tests, and then head back to camp.");
			flags[kFLAGS.KATHERINE_TRAINING] += 16;
			doNext(camp.returnToCampUseOneHour);
		}

		private function katherineTrainingWithUrtaStage3Failure():void
		{
			clearOutput();
			outputText("You enact your part while Kath enacts hers... at one point you hurl a string of insults at Kath and, unfortunately, the cat cowers, looking at you with a hurt expression and slumping her shoulders as you continue.\n\n");
			outputText("“<i>Alright, that’s enough, stop it the pair of you!</i>” Urta snaps, suddenly interposing herself between you.\n\n");
			outputText("Kath sniffles, visibly weeping in front of you.  “<i>H-how could you be so cruel to me, " + player.short + "?  I-I thought you cared about me!</i>” she wails.\n\n");
			outputText("You defend that you were just playing your part in this little act... you don’t really think Kath is a waste of time, nor anything of the sort.  You try to calm the crying cat-herm as best as you can.  Unfortunately, Kath doesn’t seem to hear anything you say, being too upset to listen to you, the one who upset her in the first place.\n\n");
			outputText("“<i>Oh, for the love of...</i>” Urta sighs in exasperation, unable to even finish her sentence.  “<i>Alright, alright... there, there, kitty.  It’s okay, we were only playing, you know that,</i>” she says, awkwardly patting Katherine on the shoulder; she obviously isn’t too good at this side of her job.  Still bawling her eyes out, Kath promptly glomps onto Urta, wrapping her arms around the vulpine officer’s midriff and burying her face there.  Urta looks at you with an expression that is at once panicked and unidentifiable, then, hesitantly, wraps her arms back around Kath.\n\n");
			outputText("Now that’s a nice scene... still... you decide to join on the girls, gently patting Kath’s back and hugging her along with Urta.  Eventually, Kath hiccups and sniffles her eyes dry.  “<i>I’m sorry, " + player.short + ", Urta... I just, I couldn’t help it,</i>” she admits, clearly terribly ashamed of losing control of her emotions like that.  You tell Kath that it’s fine... but she shouldn’t let these words get to her.\n\n");
			outputText("“<i>It’s alright, Kath, we understand... words hurt more than any strike.  I know... but you gotta learn to ignore what others say, or you’ll be their victim forever,</i>” Urta tells the cat, stroking her hair in a surprisingly maternal gesture.  Neither you, nor Urta, nor Kath seem willing break the hug, preferring to stay in your current position for a while longer... maybe too long... your arms are starting to hurt...\n\n");
			outputText("Finally, Urta lets go of Kath, and starts shoving at you.  “<i>Alright, let me up, cuddlebug; you were let in too, we didn’t forget about you, so now it’s time to let go,</i>” she says; she’s trying to sound gruff, but she’s obviously joking, and Kath smiles at her soon-to-be superior officer sounding so much like a grumpy kid.\n\n");
			if (silly()) {
				outputText("You joke right back, asking her what bug has bitten her?  Does she need a hug herself to make it all better?  You open your arms in a welcoming fashion and slowly walk up to the retreating vulpine.  “<i>Okay, okay, that’s enough, now stop that, " + player.short + "!</i>” Urta says, backing up warily.  “<i>I don’t know what you got planned, but I’m sure I wouldn’t like it!</i>”  Come now, you say.  She hugged Kath without hesitation... and she used to bicker with the cat-herm all the time, why is she denying your fun now?  You ask, as she slowly backs against a wall.\n\n");
				outputText("“<i>That was!  But she!</i>” Urta starts and stammers, trying to find an excuse to get out of being hugged.\n\n");
				outputText("“<i>Leave captain Urta alone, " + player.short + "!</i>” Kath’s voice suddenly rings out from behind you, and before you know it, the cat has playfully leapt at you and enveloped you in a tight hug.  “<i>Run for it while I distract [him], Urta!</i>” Kath cries out dramatically, spoiling the image she is going for with a delighted giggle; looks like you’ve turned her mood around.  You can’t resist playing along and cursing the cat for foiling your plans of vulpine entrapment.\n\n");
				outputText("“<i>...What ARE you two doing?</i>” Urta says, completely baffled.\n\n");
				outputText("“<i>...Haven’t you ever played games before?</i>” Kath finally asks, looking at Urta with a shocked expression on her face.\n\n");
				outputText("Urta blushes.  “<i>I...er... well... oh, you two are just being ridiculous!</i>” she complains, throwing her arms up in exasperation.\n\n");
				outputText("You and Kath look at each other and then burst out laughing.  Urta looks on with an annoyed expression, triangular ears twitching at the sound of your laughter.  With a mutter and a scowl she storms over and physically separates the pair of you.  “<i>Alright, kitty, that’s enough goofing off!  And you, " + player.short + "; if you aren’t going to help, then maybe you should just leave and let us get on with practicing,</i>” she growls.\n\n");
				outputText("Still smiling, you tell Kath that you’ll stop by later to check up on her, encouraging her to keep trying until she’s able to properly get into the mindset.  “<i>I will, name, don’t you worry - I’m so close now, I won’t let you down!</i>” she vows.\n\n");
				outputText("Then you turn to Urta and wink at her, telling her there’s no need to be such a killjoy... you’ll be happy to help her get over her grumpiness later, in bed.  “<i>I bet you will, " + player.short + ",</i>” Kath jokes.  “<i>But, you know, Urta, if if " + player.short + "’s not giving you enough love, I’ve got a pole you could use to loosen up with.</i>”\n\n");
				outputText("You frown jokingly and tell Kath to find her own fox-herm, you got dibs on this one.  “<i>Dibs?  When did you call that?  And besides, she’s really kind of sexy now that I've got to know her - why shouldn’t I have some fun if she’s willing?</i>” the cat-herm jokes.  You smile confidently and boast of all the experience you have handling this particular piece of horse-dicked fox ass, and tell her of how overfilled Urta’s condoms get when the two of you happen to have some fun.\n\n");
				outputText("“<i>Oh so the two of you have THAT much fun, huh?  Well now I just have to have a piece of that vixen all for myself...</i>” Kath laughs, licking her lips with an exaggerated leer.  Not if you can help it, you argue stepping in front of Urta and blocking Kath’s hungry eyes.  “<i>Move aside, " + player.short + ".  This is a free city, I’m allowed to look at whatever piece of ass I damn well please,</i>” Kath protests, grabbing your arm and trying to get you to move away playfully.\n\n");
				outputText("“<i>You know, I am not some piece of meat you two can fight over!</i>” Urta interjects, blushing fiercely and with her forearm-length prick jutting before her.  “<i>Maybe I ought to shove the two of you full of this here, if you’re so eager for sex!</i>” she blusters.\n\n");
				outputText("You laugh at Urta’s threat, telling her she would like that, wouldn’t she?  Considering her condition?  “<i>Why - you - oooh!</i>” Urta snarls, blushing harder than ever, cock throbbing with pent-up lust.  But unfortunately you really can’t stay, so that will have to wait.  You bid the girls farewell and head out of the safehouse.");
			}
			else outputText("Urta starts giving Kath more instruction on holding up under pressure.  Though she looks a little worn out you would say Kath's in much better spirits than she was when you arrived.  Hopefully she'll learn and do better the next time you visit.  Noticing the time you go to the door and wave to the girls.");
			outputText("\n\n“<i>See you later, " + player.short + "!</i>” Kath calls out to you as you go.\n\n");
			outputText("“<i>You just better bring that sweet ass of yours around some time soon, y’hear?</i>” Urta adds.  She really must be pent up to overcome her shyness and be that direct in public.");
			flags[kFLAGS.KATHERINE_TRAINING] += 8;
			if (flags[kFLAGS.KATHERINE_TRAINING] > 99) flags[kFLAGS.KATHERINE_TRAINING] = 99; //Only a successful training session should lead to her completing her training next time.
			doNext(camp.returnToCampUseOneHour);
		}

		private function katherineTrainingWithUrtaStage3Horny():void
		{
			clearOutput();
			outputText("Kath stands up straight and tells you you’re going to have to leave.  You tell her it’s a public street and you can do what you like.  To emphasize this you slide your hands up your thighs and turn.  It’s a move you’ve had goblins and other monsters pull on you out there in the wilderness.\n\n");
			outputText("Kath stammers slightly as she gets a good look at your ass, the fabric of your clothes pulled tightly across it.  Again she orders you to leave.  You slowly shift your ass from side to side and ask her how long it’s been since she got any.  Katherine purrs, probably hoping you won’t hear her.\n\n");
			outputText("Urta moves in next to Kath and says “<i>We’re going to have to work on that.  It’s a sure bet that perps will <b>whoa!</b></i>”  Kath has got her hands on Urta’s breasts and is purring much more loudly now.  Urta swats her away and back up.  “<i>No Kath, fight it.  This is exactly what some perps will do.</i>”\n\n");
			outputText("Kath starts to rub her own breasts as her torso and tail sway from side to side in a hypnotic dance.  Only her overly flexible spine allows her to move that way.\n\n");
			outputText("Urta shakes her head and says “<i>Well she’s no good to anyone now.  It was your idea to tease her so now you’re going help me calm this kitty.</i>”");
			var spitroast:Function = threesome.spitroastKath;
			var three69:Function = threesome.threeSixtyNine;
			if (player.gender == 0) spitroast = null;
			if (!player.hasCock()) three69 = null;
			simpleChoices("Spitroast", spitroast, "369", three69, "Try Leaving", threesome.roastYou, "", null, "", null);
		}

		private function katherineTrainingWithUrtaComplete():void
		{
			clearOutput();
			outputText("As you approach the safehouse, you wonder what else is on the agenda for Katherine’s training.  However, when you get there, Urta is outside, looking expectantly up and down the streets.  She sees you and grins widely, tail wagging openly in her happiness.\n\n");
			outputText("You smile and wave to the excited vixen, approaching her.  Once you’re close enough you ask what is the reason for all that happiness?  Could it be that she’s just that happy to see you? you joke.\n\n");
			outputText("“<i>You know I’m always happy to see you, " + player.short + ".</i>”  Urta says with a smile - indeed, you think you can see the faintest signs of that familiar stirring in her oversized prick.  “<i>But this time, I've got good news; introducing the Watch’s newest Corporal, Katherine!</i>”  She proclaims in a proud, excited tone, stepping away from the door and performing a surprisingly elegant bow as it flies open and out marches a very proud-looking black cat-morph.  Clad in a new helmet and chainmail jerkin, sporting a decent-looking broadsword at her hip, Kath smiles at you, pride and nervousness mingling on her face as she awaits your opinion.\n\n");
			outputText("You look her over and nod your head in approval, commenting that the look suits Kath well.  Why... if you knew she was going to look so good in her gear, you might have skipped all this training and just gotten her some fetish clothing... then the two of you could...\n\n");
			outputText("Kath promptly lunges for you, latching her arms around your waist - whether she couldn’t stand to hear any more or is just that excited, who can say?  “<i>Thank you, " + player.short + "!  Thank you, thank you, thank you, thank you!</i>” she cheers, laughing wildly with glee and squeezing for all she’s worth.  Then, out of the corner of her eye, she spots the grinning fox-herm watching the display, promptly lets go of you and hurls herself at Urta, knocking her to the floor and cuddling her like a cat possessed.  “<i>And thank you, Urta!  Without the two of you, I wouldn’t... well, I...</i>”\n\n");
			outputText("“<i>It’s alright, Kath, it’s alright.  I knew you had it in you,</i>” Urta says, stroking the cat’s ears.  “<i>Now, if you’d kindly get off of me and help me up...?</i>” she suggests with an embarrassed blush.  Kath promptly blushes as well and stands up, helping her new superior officer to her feet.\n\n");
			outputText("You can’t help but laugh at the little display of affection from Kath.  Still... you’re curious... how was the test?\n\n");
			outputText("Kath grins and points her thumb at herself.  “<i>I aced every last one of the written tests and the practical tests, thanks to the training you guys put me through,</i>” she proudly proclaims.\n\n");
			outputText("Urta nods her head.  “<i>Indeed she did.  I’m proud of how far our little rebel has come.</i>”");
			outputText("\n\nYou clap your hands, congratulating Kath on a job well done, then ask her how it feels - to finally have a job?  Even if it wasn’t her dream job...\n\n");
			outputText("“<i>You can say that again, but a job is a job, and it feels great - finally, I’ll be something more than a homeless vagrant!  I can hold my head high - even go and see my parents again!</i>” Kath cheers.  You smile at the cat-herm, then turn to Urta and take the vixen’s hands in yours, thanking her for her time and patience.  Kath would never have managed it if it weren’t for her.\n\n");
			outputText("Urta smiles and waves her hand in a casual manner.  “<i>It’s okay; I was doing something to help out my " + player.mf("boy", "girl") + "friend; I got a petty criminal off the street and rehabilitated, and, heck, I even netted a cute little assistant to boot.  Though I wouldn’t say no to a little personal thank you later on...</i>” she trails off, winking at you.\n\n");
			outputText("“<i>Wait, assistant?</i>” Kath asks, clearly baffled to hear that.  You can’t help but voice your surprise as well, asking Urta to elaborate.\n\n");
			outputText("“<i>They were originally discussing assigning Kath to another part of the city, but I pulled a few strings and, well, you’re now my official assistant, Corporal Kath.  Which, incidentally, means you’ll be hanging around here where you and " + player.short + " have ample opportunities to bump into each other,</i>” The fox herm explains, giving her a knowing wink as she finishes.  This makes Kath blush and giggle nervously.");
			outputText("“<i>That’s wonderful news!</i>” you say.  This way you'll always be able to see two of your favorite girls anytime.  Now that you have not one... but two girlfriends working in the watch... you ask what you get as a reward, grinning at both of them.\n\n");
			outputText("The two herms look at each other, grin and then look back at you.  “<i>Hmm... what do you say, Kath?  Would a nice, long spitroasting be reward enough?</i>” Urta suggests.  “<i>" + katherine.cockMultiple("I bag " + player.mf("his ass", "her pussy") + ", foxy - you’ll choke [him] on that supersize sausage of yours", "I bag the back end, I got two shafts for the price of one") + ",</i>” Kath purrs.\n\n");
			outputText("The two of them start advancing menacingly towards you, and then they spring...!  ...Only to start smothering you in kisses.  You can’t help but scream at their lunge, only to begin laughing, tossing and turning as the girls continue to kiss you, you try to kiss them back, but the flurry of kisses you’re getting makes the task nearly impossible.  By the time Urta and Kath let you up, you’re panting, and more than a little aroused.  You grin at the girls and tell them you’ll take this as an invitation to seek them out later for some proper “<i>rewards</i>”.  Now then, this begs for a celebration.  “<i>Any ideas?</i>” you ask the two of them.\n\n");
			outputText("“<i>We can all go to the Wet Bitch for a nice stiff drink,</i>” Urta suggests eagerly, tail wagging at the thought.\n\n");
			outputText("“<i>It’d be nice to be inside the bar instead of rummaging through the dustbins outside...</i>” Kath agrees.\n\n");
			outputText("All right... the bar it is then.  You motion extend an arm for each of the herms.  They loop their arms around yours and you lead them away.\n\n");
			doNext(katherineTrainingWithUrtaCompleteContinued);
		}

		private function katherineTrainingWithUrtaCompleteContinued():void
		{
			clearOutput();
			outputText("Later that " + (model.time.hours + 3 > 18 ? "evening" : "day") + "...\n\n");
			outputText("You laugh at Urta’s joke, indicating that if that were you, things would have been very different.  Then you take a sip of your drink.  Kath is currently gulping her way down a very large, fruity-smelling drink, while Urta, having finished her joke, is chugging down yet another " + (urta.pregnancy.isPregnant ? "virgin margarita.  You and Kath already had a laugh about how inappropriate it is for any of you to be drinking something 'virgin'" : "of her favorite bottles of alcohol, the strange amber-colored stuff with the JD label - odd, you can’t remember what it’s called") + ".  The two herms seem to be having a great time here.\n\n");
			outputText("Once you finish your drink you announce that you will have to leave shortly.  “<i>Wha?  Already?  But we're just getting started!</i>” Urta protests.  “<i>Yeah, " + player.short + ".  Don’t be such a spoilsport!</i>” Kath protests alongside, stopping momentarily to sip her drink.  “<i>Wow... tish shtuff is really good... no wonder you’re always here drinking your face off prickvixen,</i>” Kath comments happily.  The vixen laughs drunkenly and retorts “<i>Look who’s slurring their words already!  You’re such a lightweight, my little pussy.</i>”\n\n");
			outputText("You laugh and reply that as much as you’d love to stay, you have to return to your duties... speaking of which... don’t they have duties of their own to return to?  “<i>Not today, sexy!  I officially took the day off - and my little corporal pussy is taking it off with me,</i>” Urta laughs.  “<i>Yeah, you tell [him] boss,</i>” Kath giggles at that statement.  You click your tongue and shake your head... scolding them jokingly, saying that you didn’t get Kath off the streets so they could waste their days away at a bar.\n\n");
			outputText("“<i>Us girls just wanna have fun, right?</i>” Kath asks, looping an arm around Urta.  “<i>That’s right, my sexy little kitten,</i>”  Urta replies, closing her eyes and nuzzling her face into Kath’s breasts.  Kath purrs and starts stroking Urta’s ears, throwing you a hooded gaze that’s clearly inviting you to make a move on her as well.");
			flags[kFLAGS.KATHERINE_UNLOCKED] = 4; //Indicates Kath is now a member of the watch
			flags[kFLAGS.KATHERINE_TRAINING] = 200; //Indicates Training was carried out with Urta's help
			flags[kFLAGS.KATHERINE_LOCATION] = Katherine.KLOC_KATHS_APT; //This ensures that after you talk Kath will disappear for the rest of the day due to stuff she needs to sort out
			flags[kFLAGS.KATHERINE_URTA_AFFECTION] += 10; //Kath and Urta will like each other by the time they’re finished training
			if (flags[kFLAGS.KATHERINE_URTA_AFFECTION] > 28) flags[kFLAGS.KATHERINE_URTA_AFFECTION] = 28; //Make sure they don't like each other too much
			if (player.gender == 0)
				doNext(katherineTrainingWithUrtaCompleteLeave);
			else {
				outputText("That’s an enticing sight... you should really get back to your duties... but on the other hand another hour with the two herm beauties wouldn’t be so bad, would it?  What to do...");
				simpleChoices("Stay", katherineTrainingWithUrtaCompleteStay, "Leave", katherineTrainingWithUrtaCompleteLeave, "", null, "", null, "", null);
			}
		}

		private function katherineTrainingWithUrtaCompleteLeave():void
		{
			clearOutput();
			outputText("You apologize to the amorous herms, but you really have to be going...\n\n");
			outputText("“<i>Aw...</i>” the two sigh, clearly disappointed.  “<i>Well, I guess we’ll just try to have fun without you... but we’ll miss you,</i>” Urta says.  “<i>Yeah, so hurry back, lover,</i>” Kath winks, right before Urta reaches up and, to Kath’s own visible surprise, pulls her into a kiss... damn, but she must be drunk.\n\n");
			outputText("On the way out, you pay your tab and wave to the two girls, who seem too busy with each other to notice... well... you’ll just find out how this ends via gossip later...");
			doNext(camp.returnToCampUseFourHours); //Return to camp, use up four hours
		}

		private function katherineTrainingWithUrtaCompleteStay():void
		{
			clearOutput();
			outputText("You decide that another hour is a necessary sacrifice to make, in order to indulge your lusts, as well as the lusts of the two herms eyeing you with predatory glares of hunger.  You confidently strut back towards the table and tell them that they’ve managed to convince you to stay.  The two shoot up in their seats with an excited cry, then hug each other in glee, rubbing cheeks as they smile their most winning smile.  “<i>Ooh, I can’t wait to get started on some serious fun!</i>” Urta laughs, then blinks in shock as Kath licks her playfully on the tip of her nose.  “<i>Why, you lewd little...</i>” she licks back, which somehow induces the two herms to end up making out with each other...\n\n");
			outputText("You cough, feeling the need to remind the two girls that, not only are you feeling a bit left out... but also that it’s not polite to invite someone over and then forget about them.  The two stop what they’re doing with a visible start, giving you a matching pair of sheepish looks.\n\n");
			outputText("“<i>Right, ah, of course, " + player.short + ".  So, what do you want me to do to you?</i>” Kath purrs, tail languidly waving in delight.\n\n");
			outputText("“<i>Get back in line, kitty-Kath, I want [him] first!</i>” Urta interjects.\n\n");
			outputText("“<i>You?  But I called [him] first!</i>” Kath protests.\n\n");
			outputText("“<i>As your superior officer, I command you to stand down,</i>” Urta says an authoritative manner, puffing out her chest.\n\n");
			outputText("“<i>Cut it back, prickvixen!  I won’t be bullied, even if you are my commanding officer,</i>” Kath shoots back.\n\n");
			outputText("“<i>Why you little... want me to remind you who taught you to stand up for-</i>”\n\n");
			outputText("“<i>Alright, that’s enough,</i>” you interject, physically separating the girls.  There’ll be enough time to discuss what to do in the back-rooms... you’re already drawing enough attention as is, and a bar brawl within the watch is not the kind of news either of them need right now...\n\n");
			outputText("The two herms look at each other, and nod silently, then hug each other and say, “<i>I’m sorry,</i>” in unison.  Then, with a wicked grin, they spring up and hug you, letting you feel the prominent bulges of their erect cocks against your belly.\n\n");
			outputText("Okay, okay, you say, laughing at the two amorous herms.  You don’t know about them, but you really don’t feel like being charged with public indecency... so let’s go to the back-rooms? you suggest once more.\n\n");
			outputText("“<i>Sounds good to me!</i>” they cheer at once.  You lead the girls away, arm in arm, followed by the envious stares of more than a few patrons...");
			var dpKath:Function = (player.hasCock() ? threesome.doublePenetrateKath : null);
			simpleChoices("Let 'em fuck", threesome.doubleStuffKath, "DP Kath", dpKath, "", null, "", null, "", null);
		}

		public function katherineGetsEmployed():void
		{	//This scene plays automatically the first time that the player goes to Tel’Adre after Kath’s training is done
			clearOutput();
			outputText("As you make your way past the familiar sight of the gate guards to Tel’Adre, you think one of them looks familiar.  Then, a moment later, you recognize who she is and stop.  There, grinning widely at you, clad in the usual armor and helmet of the Watch and with a brand-new sword strapped to her waist, is Katherine.\n\n");
			outputText("“<i>Hi, " + player.short + " - what, didn’t you recognize me?</i>” she jokes.  “<i>I finally did it!  I’m in the Watch now - I have a job and a home and everything, and I owe it all to you" + (flags[kFLAGS.KATHERINE_TRAINING] == 200 ? " and Captain Urta" : "") + "!</i>”\n\n");
			outputText("You smile proudly and congratulate her, asking how she’s handling the changes?\n\n");
			outputText("“<i>It’s a bit tough,</i>” she admits, “<i>but I’m going to work hard - it’s so nice to have money in my pockets and a roof to sleep under, now.  No more hiding in alleyways and scavenging through refuse for me!</i>” she grins.\n\n");
			outputText("You ask if you’ll be able to see her around town, now?  The new watch-cat nods her head.  “<i>Yeah; if you’re lucky, you might catch me when I'm on patrol around the markets; that's where I'm going to be assigned most days, so you should run into me eventually.  Otherwise, check for me at the Wet Bitch.  I go there after my shift to wet my whistle and wind down.  I guess in that way I take after Captain Urta a little.</i>”  She steps forward and presses a quick kiss to your lips.  “<i>But, right now, I’m on duty, so off with you.</i>”  She smirks.\n\n");
			//Prevent this scene from repeating
			if (flags[kFLAGS.KATHERINE_TRAINING] == 200)
				flags[kFLAGS.KATHERINE_TRAINING] = 1; //After training is completed the training flag indicates that Urta helped to train Kath
			else flags[kFLAGS.KATHERINE_TRAINING] = 0;
			flags[kFLAGS.KATHERINE_LOCATION] = Katherine.KLOC_KATHS_APT; //Once again she disappears for the rest of the day so we don't find her at the bar right after seeing this encounter
			katherine.giveClothing(Katherine.KBIT_CLOTHES_UNIFORM);
			katherine.giveClothing(Katherine.KBIT_CLOTHES_C_CLOTH);
			telAdre.telAdreMenuShow();
		}

		public function postTrainingAlleyDescription():void
		{
			clearOutput();
			outputText("You go into the alleyway behind Oswald's shop.  It seems empty without a happy cat-morph to greet you.\n\n");
			outputText("Looking closely you notice a few of the secret hiding spots among the crates have been emptied.  Kath must have been here to collect some of her more sentimental possessions.\n\n");
			if (!katherine.isAt(Katherine.KLOC_KATHS_APT)) { //Only possible if she's already been seen on guard duty at the gate and you've slept once since
				outputText("You see a note tucked into the side of the crate Kath used to sleep on.  It says, 'Hi " + player.short + ", everything is going great!  Come and see me at the Wet Bitch.  I'll try to be there from mid-morning to mid-afternoon.  Can't wait to see you again, love you, bye'.  It's signed with a kiss.");
			}
			else if (flags[kFLAGS.KATHERINE_TRAINING] >= 100) {
				outputText("You guess that Urta and other members of the watch will be keeping her busy for the rest of the day.  Wherever she is you know she's being well taken care of.");
			}
			else {
				outputText("You're guessing that her guard detail at the gate will last all day.");
			}
			telAdre.telAdreMenuShow();
		}

	}
}
