package classes.Scenes.Areas.VolcanicCrag 
{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.GlobalFlags.kACHIEVEMENTS;
	
	public class BehemothScene extends BaseContent
	{
		
		public function BehemothScene() 
		{
		}
		
		public function timesSexed():int {
			return flags[kFLAGS.BEHEMOTH_ANAL_PITCH] + flags[kFLAGS.BEHEMOTH_ANAL_CATCH] + flags[kFLAGS.BEHEMOTH_VAGINAL_CATCH] + flags[kFLAGS.BEHEMOTH_COCK_SUCKED] + flags[kFLAGS.BEHEMOTH_CUM_BATH] + flags[kFLAGS.BEHEMOTH_WATERSPORTS]
		}


		private function behemothMenu():void {
			menu();
			addButton(0, "Fight", startFight, null, null, null, "Challenge the Behemoth.");
			addButton(1, "Talk", talkToBehemothMenu, null, null, null, "Talk to Behemoth and discuss.");
			if (player.lust >= 33) addButton(2, "Sex", behemothSexMenu, false, null, null, "Initiate sexy time with the Behemoth.");
			addButton(4, "Leave", camp.returnToCampUseOneHour);
		}
		
		public function behemothIntro():void {
			clearOutput();
			if (flags[kFLAGS.MET_BEHEMOTH] <= 0) {
				outputText("As you're exploring the infernal landscape, you are drawn to the sight of a creature you've never seen before: a muscular male bipedal purple-skinned horned creature with spikes on his back.  You guess he is sentient as he's wearing a loincloth.  Underneath his loincloth is a large cock and a duo of balls; you estimate his cock to be 18 inches long and 2½ inches thick but it's hard for sure as his cock is flaccid.  You estimate his balls to be three inches across.  You approach the creature and he says to your surprise, \"<i>Hello there.  Not many even dared to approach me.  Either it's me or it's the landscape.</i>\"");
				outputText("\n\nYou introduce yourself and the creature says, \"<i>" + player.short + ", eh?  I'm the mighty Behemoth.  So what do you want?  Up for battling or interested in sex?</i>\"");
			}
			else {
				outputText("As you're exploring the infernal landscape, you spot the familiar purple-skinned creature.  The behemoth approaches you with a smile and says, \"<i>Hello again, " + player.short + ".  So feeling up for fighting?  Or want to have sex?</i>\"");
			}
			flags[kFLAGS.MET_BEHEMOTH]++;
			behemothMenu();
		}
		
		//Talk
		public function talkToBehemothMenu():void {
			clearOutput();
			outputText("You ask the behemoth if he's willing to have a conversation with you.  The behemoth says, \"<i>Of course.  What would you like to talk about?</i>\"");
			menu();
			addButton(0, "Yourself", talkAboutYourself, null, null, "Talk to the behemoth about yourself.");
			//addButton(1, "Behemoth", eventParser, 9999, null, null, "Talk to the behemoth about himself.");
			//if (timesSexed() >= 2) addButton(2, "His Cum", eventParser, 9999, null, null, "Talk to the behemoth about the special properties of his cum and how he managed to cum that much despite his ball size."); 
			addButton(14, "Back", behemothMenu);
		}
		
		private function talkAboutYourself():void {
			clearOutput();
			outputText("You tell the behemoth about your origins, where you originally lived in, how you've came to be the champion of Ingnam and sent through the portal.  ");
			outputText("\n\n\"<i>Ingnam?  That sounds like a nice place.  I used to live in another world too and like you, I've went to this world through a portal.</i>\"");
			if (flags[kFLAGS.FACTORY_SHUTDOWN] > 0) {
				outputText("\n\nYou tell the behemoth about how you've managed to shut down the factory.  ");
				if (flags[kFLAGS.FACTORY_SHUTDOWN] == 1) {
					outputText("\"<i>Wow, you're quite the hero!  I'm glad you've managed to save Marae,</i>\" he smiles.");
				}
				else if (flags[kFLAGS.FACTORY_SHUTDOWN] == 2) {
					outputText("\"<i>Don't you think you should have shut down the factory properly?  You've only managed to worsen the corruption,</i>\" he says with a bit of worried look.");
				}
			}
			if (flags[kFLAGS.DEFEATED_ZETAZ] > 0) {
				outputText("\n\nYou tell the behemoth about how you've managed to find and defeat Zetaz, the original imp who tried to rape you in the first place after you've entered the portal.  ");
				outputText("\n\nThe behemoth remarks and says,\"<i>That's great!  I had a similar story.  I had a rival who bullied and mocked me from my childhood.  Years later, I've finally got my revenge on him and literally ripped him apart with my bare hands.</i>\"  Your jaws drop when he mentions being able to rip someone apart with his strength.  He says, \"<i>Yes, seriously.  I actully did it.  After that, I've had his meat." + (silly() ? "  Besides, I wouldn't want to traumatize the player reading whatever we're saying or make the player squick.</i>\"": "") + "  "); //Fourth wall breaker
				if (silly()) outputText("Did he just break the fourth wall?");
			}
			if (flags[kFLAGS.CORRUPTED_MARAE_KILLED] > 0) {
				outputText("\n\nNext, you tell the behemoth on how you've slain Marae, the corrupted goddess of Mareth.  The behemoth drops his jaws at what you've done.  \"<i>You actually KILLED a goddess?  Wow, that's quite an amazing feat for a mortal to defeat a deity.  You're even stronger than I am!  I normally fear the wrath of the gods but you're brave,</i>\" he chuckles.");
			}
			outputText("\n\nAfter chatting for a good while, you and the behemoth part ways and you return to your camp.");
			doNext(camp.returnToCampUseOneHour);
		}
		private function talkAboutBehemoth():void {
			clearOutput();
			doNext(camp.returnToCampUseOneHour);
		}
		private function talkAboutHisCum():void {
			clearOutput();
			doNext(camp.returnToCampUseOneHour);
		}
		//Combat
		private function startFight():void {
			clearOutput();
			outputText("You tell him that you're here to fight.  \"<i>All right! Get ready,</i>\" he says with a grin and claws raised.");
			startCombat(new Behemoth());
		}
		
		public function winAgainstBehemoth():void {
			clearOutput();
			if (monster.HP <= 0) outputText("The behemoth falls down on his knees, too badly beaten to continue fighting.");
			else outputText("The behemoth falls down on his knees, too turned on to continue fighting.");
			outputText("\n\n\"<i>You have managed to beat me.  Nothing beats a good workout,</i>\" he says.");
			//Get some gems back.
			if (flags[kFLAGS.BEHEMOTH_GEMS] >= 5) {
				var gemsBonus:int = (flags[kFLAGS.BEHEMOTH_GEMS] / 2);
				if (gemsBonus < 5) gemsBonus = 5;
				flags[kFLAGS.BEHEMOTH_GEMS] -= gemsBonus;
				monster.gems += gemsBonus;
			}
			menu();
			if (player.lust >= 33) addButton(0, "Sex", behemothSexMenu, true, null, null, "Initiate sexy time with the Behemoth.");
			addButton(4, "Leave", cleanupAfterCombat);
		}
		
		public function loseToBehemoth():void {
			clearOutput();
			var gemsLost:int = (player.gems / 20);
			if (gemsLost < 20) gemsLost = 20;
			if (gemsLost > 500) gemsLost = 500;
			if (gemsLost > player.gems) gemsLost = player.gems; //Keeps gems from going into negatives.
			flags[kFLAGS.BEHEMOTH_GEMS] += gemsLost;
			player.gems -= gemsLost;
			statScreenRefresh();
			kGAMECLASS.inCombat = false;
			if (player.HP <= 0) outputText("You collapse from your injuries.");
			else outputText("You collapse from your overwhelming desires.");
			outputText("\n\n\"<i>I win and you know what that means?  I'll take some of your gems and I get to fuck your ass.  Don't you worry, I'll be gentle,</i>\" he says with a grin.  He takes " + gemsLost + " gems from your pouch.  \"<i>I will give you some of your gems back should you beat me,</i>\" he says.");
			doNext(analCatchBehemoth);
		}
		
		//Sex menu
		private function behemothSexMenu(victory:Boolean = false):void {
			clearOutput();
			if (victory) {
				outputText("You tell the behemoth that you'd love to blow off some steam after a fight session.  He says, \"<i>Of course.  What would you like to do?</i>\"");
			}
			else {
				outputText("You tell the behemoth that you're here to have sex with him.  He looks at you and says, \"<i>I'm game.  What would you like to do?</i>\"");
			}
			menu();
			if (player.hasCock()) {
				if (player.cockThatFits(48) >= 0) addButton(0, "Anal Fuck", analPitchBehemoth, null, null, null, "Anally penetrate the behemoth.");
				else outputText("\n\n<b>Unfortunately, your cock is too big to fit in his butthole.</b>");
			}
			addButton(1, "GetAnalFucked", analCatchBehemoth, null, null, null, "Have him penetrate you anally.");
			if (player.hasVagina()) addButton(2, "GetVagFucked", vagCatchBehemoth, null, null, null, "Have him penetrate you vaginally.");
			addButton(3, "Suck His Cock", suckThatBigCock, null, null, null, "Suck his wonderful cock and get stuffed with cum!");
			if (timesSexed() >= 3) addButton(4, "Cum Bath", haveACumBathLiterally, null, null, null, "Have a (literal) cum bath!");
			else addButton(4, "LOCKED", eventParser, 9999, null, null, "Have sex with the behemoth enough times to unlock this!");
			if (flags[kFLAGS.WATERSPORTS_ENABLED] > 0) {
				if (timesSexed() >= 3) addButton(5, "Watersports", watersportsWithBehemoth, null, null, null, "Do some urine activity with him. (Placeholder)");
				else addButton(5, "LOCKED", eventParser, 9999, null, null, "Have sex with the behemoth enough times to unlock this!");
			}
			if (!kGAMECLASS.inCombat) addButton(14, "Nevermind", camp.returnToCampUseOneHour);
			else addButton(14, "Nevermind", cleanupAfterCombat);
		}
		
		private function analPitchBehemoth():void {
			var x:int = player.cockThatFits(48);
			clearOutput();
			outputText("You tell the behemoth that you're going to take him from behind.  \"<i>All right, let's get this started,</i>\" he says.  The two of you strip yourselves naked.  You toss your " + player.armorName + " into a neat pile.\"");
			outputText("\n\n\"<i>Bend over,</i>\" you instruct the behemoth with a smirk.  He gives you a nod as he gets down into a doggy position.");
			outputText("\n\nYou give his butt-cheeks a gentle caress" + (player.cor >= 30 ? " followed by a sudden spank which causes him to yelp in surprise": " to assure him that you're going to be gentle.") + ".");
			outputText("\n\nHe lifts his spiked tail to give you a good look at his entire backside. You spit on your hands and apply the saliva all over your " + player.cockDescript(x) + " to get it well-lubricated.");
			outputText("\n\nThe behemoth clenches his teeth in preparation for what's coming.  You slowly sink your entire " + player.cockDescript(x) + " into his tight rear entrance.  By god, he's tight!  \"<i>What are you waiting for?  Fuck my ass!</i>\" He demands with a grin.");
			outputText("\n\nThat's all the encouragement you need.  You grunt with pleasure as his sphincter clamps down on your " + player.cockDescript(x) + ".  You pound his ass, slowly but surely.  His cock hardens to full erection, indicating that he's definitely enjoying being penetrated.");
			outputText("\n\n\"<i>Yes!  I love it when you fuck my ass like that,</i>\" he cries with pleasure as precum leaks from his cock.  You reach over to caress his pecs and belly and slowly rub them.  You swear you can hear him purr.");
			outputText("\n\nEventually, you can hold back no more.  You let out a scream in pleasure as you unload right into his bowels");
			if (player.cumQ() < 250) outputText("");
			else if (player.cumQ() >= 250 && player.cumQ() < 1000) outputText(", filling it completely");
			else if (player.cumQ() >= 1000) outputText(", filling it completely and stuffing his stomach");
			outputText(".");
			outputText("The behemoth shoots huge torrents of cum, far more than his balls could possibly hold.  You watch him cumming and cumming, never seeming to stop.  He does stop and by the time he finished cumming, he has created quite the pool!  With the two of you exhausted from the ordeal, you lay on top of him and rest for a while.");
			outputText("\n\nYou give him a kiss on one of his cheeks and let him know that you'll be going.  \"<i>See you later,</i>\" the behemoth says with a smile on his face.  You redress and leave back to your camp.");
			player.orgasm();
			flags[kFLAGS.BEHEMOTH_ANAL_PITCH]++;
			if (kGAMECLASS.inCombat) cleanupAfterCombat();
			else doNext(camp.returnToCampUseOneHour);
		}
		
		private function analCatchBehemoth():void {
			var isVirgin:Boolean = false
			clearOutput();
			if (player.HP <= 0 || player.lust >= player.maxLust()) {
				outputText("You have no choice but to accept the fact that the behemoth is going to penetrate you anally.  He looks at you with a grin and says, \"<i>Go on, strip for me.  I want to see your wonderful butt, " + player.mf("dude", "chick") + ".</i>\"\n\n");
			}
			else {
				outputText("You definitely want that " + (silly() ? "dig bick": "big dick") + " in your [ass].  ");
			}
			outputText("You strip out of your [armor] until you're naked.  You make sure to toss your [armor] into a neat pile.  You present your naked body and more importantly, your [butt] to the behemoth.  He shifts his loincloth aside to expose his large pecker and says excitedly, \"<i>Now that's some wonderful butt-cheeks you've got there!  I'll go gentle on you and make sure you enjoy the experience.</i>\"");
			if (player.isBiped()) outputText("\n\nYou get down on all fours");
			else if (player.isTaur()) outputText("\n\nYou adjust your pose so your [butt] is at the right height");
			else if (player.isNaga()) outputText("\n\nYou shift your body and tail until your [ass] is accessible");
			else if (player.isGoo()) outputText("\n\nYou shift your gooey body");
			outputText(" and prepare for whatever he has in store for you.  The behemoth walks to you and caress your [butt] gently.  He walks around you and sticks his manhood into your mouth.  He smiles and says, \"<i>I need them lubed up.  I want you to suck it good!</i>\"");
			outputText("\n\nYou have no choice; you're going to coat his length in saliva.  After all, he needs a good lubricant so you can take his monster cock.  You can already taste the precum but the behemoth pulls his cock out of your mouth.  \"<i>That'll do.  I'm going to start now,</i>\" he says as he gets behind you.");
			outputText("\n\nYou clench your teeth and ready for whatever's coming.  You feel the tip of his cock entering your backdoor.  As time passes, more and more of his length slides into your [ass].");
			player.buttChange(45, true, true, true);
			if (isVirgin) outputText("\"<i>Gods, that's tight!  It's a good thing you've been saving your virginity for me,</i>\" The behemoth says with a smile.");
			if (player.looseness(false) < 3) outputText("  It takes a bit of effort for him to slide his cock inside due to your tightness.");
			else outputText("  He easily slides his entire length into your [ass].");
			outputText("\n\nEven though his cock is large, you don't feel any sign of discomfort.  The behemoth slides his cock back and forth with your [ass] clamping down.  ");
			if (player.hasCock()) outputText("Your " + (player.cocks.length == 1 ? "cock": "cocks") + " springs to full erectness and precum leaks from your " + player.multiCockDescript() + ".  ");
			if (player.hasCock() && player.hasVagina()) outputText("At the same time, ");
			if (player.hasVagina()) outputText("" + (player.hasCock() ? "femspunk": "Femspunk") + " leaks from your " + player.vaginaDescript() + "."); 
			outputText("\n\n\"<i>I'm going to pace up a bit,</i>\" the behemoth announces.  He gradually increases his thrusting pace.  With each thrust, you moan in pleasure and enjoy every moment of being fucked.  ");
			if (flags[kFLAGS.BEHEMOTH_ANAL_CATCH] <= 0) outputText("He says, \"<i>I'm sure you've never known about how much a behemoth can cum.  In fact, I'm capable of producing a lot of cum, far beyond what a minotaur can produce.  Or even that fox-herm in Tel'Adre!  Don't let the size of my balls deceive you,</i>\" he says with a chuckle.  You recall his balls being three inches in length.");
			outputText("\n\nIt seems take forever but all good things must come to an end. \"<i>I'm going to cum!</i>\" The behemoth announces.  With a cry of pleasure and glee, he unleashes a huge amount of cum into your bowels.  His cum surges through your intestines and up to your belly.  By the gods, you feel so full!  You look down to notice that your belly definitely got swollen.  ");
			player.refillHunger(70, false);
			outputText("His orgasm triggers yours too.\n\n");
			if (player.hasCock()) {
				outputText("You cum, ");
				if (player.cumQ() < 50) outputText("shooting small ropes of jism all over the ground.");
				else if (player.cumQ() >= 50 && player.cumQ() < 250) outputText("shooting ropes of jism all over the ground.");
				else if (player.cumQ() >= 250 && player.cumQ() < 500) outputText("shooting jets of cum all over the ground, forming a small puddle.");
				else if (player.cumQ() >= 500 && player.cumQ() < 2500) outputText("shooting torrents of cum all over the ground, forming a medium puddle of your seed.");
				else outputText("shooting waves after waves of your seed that never seem to end.  A large puddle of cum forms after you eventually stop cumming.");
			}
			if (player.hasCock() && player.hasVagina()) outputText("At the same time, ");
			if (player.hasVagina()) {
				if (player.averageVaginalWetness() < 4) outputText("" + (player.hasCock() ? "femspunk": "Femspunk") + " bursts from your " + player.vaginaDescript() + " and seeps down your [legs].");
				else outputText("" + (player.hasCock() ? "femspunk": "Femspunk") + " gushes from your " + player.vaginaDescript() + " and splashes onto the ground."); 
			}
			if (player.gender == 0) outputText("Your entire body rocks from the overwhelming pleasure.");
			outputText("  You finally recover from your orgasmic high and fall down, exhausted.  The behemoth finally slides his cock out of your cum-stuffed [ass] and lays next to you. \"<i>It feels great to have someone to fuck,</i>\" the behemoth says.");
			outputText("\n\nHe lays on top of you and the two of you rest for a while.  You wake up some time later and you give the behemoth a kiss on one of his cheeks and let him know that you'll be going.  \"<i>See you later,</i>\" the behemoth says with a smile on his face.  You redress and leave back to your camp, oddly feeling a bit better.");
			player.orgasm();
			player.slimeFeed();
			HPChange(player.maxHP() / 4, false);
			flags[kFLAGS.BEHEMOTH_ANAL_CATCH]++;
			dynStats("str", 0.5, "tou", 0.5);
			if (kGAMECLASS.inCombat) cleanupAfterCombat();
			else doNext(camp.returnToCampUseOneHour);
		}
		
		private function vagCatchBehemoth():void {
			clearOutput();
			outputText("You definitely want that " + (silly() ? "dig bick": "big dick") + " in your [vagina].  ");
			outputText("You strip out of your [armor] until you're naked.  You make sure to toss your [armor] into a neat pile.  You present your naked body and more importantly, your [vagina] to the behemoth.  He shifts his loincloth aside to expose his large pecker and says excitedly, \"<i>Now that's some wonderful pussy you've got there!  I'll go gentle on you and make sure you enjoy the experience.</i>\"");
			player.cuntChange(45, true, true, true);
			outputText("\n\n(PLACEHOLDER) And then you were vaginally fucked.  ");
			if (player.hasCock()) outputText("You manage to cum as well.");
			player.orgasm();
			player.slimeFeed();
			player.knockUp(PregnancyStore.PREGNANCY_BEHEMOTH, PregnancyStore.INCUBATION_BEHEMOTH);
			flags[kFLAGS.BEHEMOTH_VAGINAL_CATCH]++;
			dynStats("str", 0.5, "tou", 0.5);
			if (kGAMECLASS.inCombat) cleanupAfterCombat();
			else doNext(camp.returnToCampUseOneHour);
		}
		
		
		private function suckThatBigCock():void {
			clearOutput();
			outputText("Your eyes draw near the big bulge in his loincloth and you lick your lips as if you're hungry.  ");
			if (player.findStatusAffect(StatusAffects.LustyTongue) >= 0) {
				outputText("Your body tingles with arousal as your " + tongueDescript() + " makes contact with your lips.  ");
				dynStats("lus", 30);
			}
			outputText("The behemoth looks at you with a grin and says, \"<i>See something you want, " + player.short + "?</i>\"  You give him a nod and smile.");
			outputText("\n\nYou move his loincloth aside to reveal his monster cock.  Now that's a  " + (silly() ? "dig bick": "big dick") + "!  Time for a little foreplay; you stroke his cock and the behemoth lets out a moan.  \"<i>I love it when you do this!  It gets my dick really nice and hard,</i>\" he says.  You give his balls a caress and you swirl your finger around his cockhead.  Precum leaks from his cock.");
			outputText("\n\nSatisfied with the precum leaking, you slowly slide his cock into your mouth, trying to suppress your gag reflex.  His cock slides in inch by inch until it reaches the back of your mouth.  \"<i>Whoa, ease up, " + player.boyGirl() + ".  I don't want you to choke on my cock.  You know you don't have to swallow my entire cock length,</i>\" he says with a smile.");
			outputText("\n\nYour " + tongueDescript() + " swirls around his cock and you bob your head up and down eagerly; the behemoth lets out a purr and moan happily as you're giving his cock a good sucking.");
			outputText("\n\nYou continue to suck his meaty cock until the behemoth announces, \"Gonna cum! Prepare to get stuffed!\"  Your eyes widen as cum erupts from his cock and into your mouth.  You have no choice but to swallow the delicious behemoth-cum and you lose count after the tenth jet of cum.  Your belly practically inflates with cum.");
			player.refillHunger(100);
			player.slimeFeed();
			outputText("\n\nThe behemoth pulls his cock out of your mouth and the rest of the cum spills all over the earth.  With his orgasm eventually coming to an end, the behemoth looks at you with your swollen belly.  \"<i>I really stuffed you, didn't I?  At least you won't have to eat for a bit,</i>\" he chuckles.  You tell him that yes, he did stuff you with cum!");
			outputText("\n\nYou lay next to him and rest for an hour before you say your goodbyes to the behemoth and walk back to your camp.");
			flags[kFLAGS.BEHEMOTH_COCK_SUCKED]++;
			dynStats("str", 0.5, "tou", 0.5);
			if (kGAMECLASS.inCombat) cleanupAfterCombat();
			else doNext(camp.returnToCampUseOneHour);
		}
		
		private function haveACumBathLiterally():void {
			clearOutput();
			outputText("The behemoth looks at you and says, \"<i>Really?  You want a cum bath?  " + (flags[kFLAGS.BEHEMOTH_CUM_BATH] <= 0 ? "You're in luck as I can make a cum bath, literally!  Yes, a literal cum bath.  Don't let the size of my balls fool you; I can cum much higher than what you think my balls can hold." : "No problem, I'm going to give you another cum bath.") + "</i>\"");
			if (flags[kFLAGS.BEHEMOTH_CUM_BATH] <= 0) {
				outputText("\n\nYou are already eager for a literal cum bath!  ");
				if (silly()) outputText("There has never been a literal cum bath in this game!");
				outputText("You are curious to what it actually feels like.");
			}
			outputText("\n\n\"<i>Come to my tent, I have something,</i>\" the behemoth says.  You give him a nod and " + (player.isGoo() || player.isNaga() ? "slither": "walk") + " with him all the way to his tent.  " + (flags[kFLAGS.BEHEMOTH_CUM_BATH] <= 0 ? "The tent is fairly large and looks like several people could comfortably sleep in there.": "") + "  The behemoth gestures for you to enter and you enter along with him.");
			if (flags[kFLAGS.BEHEMOTH_TENT] <= 0) {
				outputText("\n\nThe tent is nicely decorated with a bed at one corner with an end table beside it.  A bookshelf holds various books, implying that the behemoth is actually an intelligent race, capable of reading and writing.  At another corner is a chair and a table where the behemoth would sit and eat or study.");
				outputText("\n\nWhat catches your eye the most is the empty metal basin at the center that looks like it could hold two people.  \"<i>Do you like my tent?</i>\" The behemoth asks.  You tell him that yes, you like his tent.  He smiles at you and gives you a thank.  ");
				flags[kFLAGS.BEHEMOTH_TENT] = 1;
			}
			outputText("\n\nYou remove your [armor], put it into a neat pile on his bed and " + (player.isGoo() || player.isNaga() ? "slither": "walk") + " over to the basin.  \"<i>This is where I will cum into.  Get into basin and I'll take care from there,</i>\" the behemoth instructs.");
			outputText("\n\nYou get into the basin as told and watch the behemoth moves his loincloth aside to reveal his huge prick.  He smiles at you and says, \"<i>I'm going to start now.  You can help by caressing my balls to make me reach orgasm faster.</i>\"  He begins stroking his cock and you reach over to caress his 3-inch balls.  In no time at all, his cock springs to full erection, already leaking precum.  Fantasies and thoughts fill the behemoth's mind and he masturbates in earnest.");
			outputText("\n\nEventually, he can hold back no more.  \"<i>Can't hold back!  Gotta cum,</i>\" he announces as he finally unleashes huge torrents of cum into the basin.  It seems to never end and the basin is being filled with cum up to your neck.  You sit back and relax as the behemoth finishes cumming, cock still dripping with semen.  He removes his loincloth and places it next to your [armor].");
			outputText("\n\n\"<i>I'm going to join,</i>\" he says.  He steps into the cum-filled basin and reclines back.  With the two of you now having a literal cum bath, you relax for some time.  ");
			if (flags[kFLAGS.BEHEMOTH_CUM_BATH] <= 0) outputText("You never knew having a literal cum bath felt so good!");
			outputText("\n\nThe behemoth moves over to kiss you and you let out a deep groan and moan as his tongue probes the inside of your mouth.  He retracts back and says, \"<i>I love you.</i>\"");
			outputText("\n\nYou caress his cheeks and recline back...");
			outputText("\n\n<b>One hour later...</b>");
			outputText("\n\nYou get out of the cum-filled basin and " + (player.isGoo() ? "absorb the cum into your gooey body": "shake the excessive cum off") + " before getting yourself re-dressed into your [armor] and rustle the behemoth's hair.   \"<i>See you later.  Come back anytime for more fun,</i>\" the behemoth says.  You give him a final kiss before you make your way back to camp, already feeling a lot better.");
			flags[kFLAGS.BEHEMOTH_CUM_BATH]++;
			HPChange(player.maxHP(), false);
			fatigue(-50);
			dynStats("str", 0.5, "tou", 0.5, "lus", 30);
			player.slimeFeed();
			if (kGAMECLASS.inCombat) cleanupAfterCombat();
			else doNext(camp.returnToCampUseTwoHours);
		}
		
		private function watersportsWithBehemoth():void {
			clearOutput();
			outputText("\<i>You want to do some watersports with me?  Of course,</i>\" the behemoth chuckles, \"just follow me to my tent.\"");
			outputText("\n\nYou follow the behemoth all the way to his tent and he gestures for you to enter and you enter along with him.");
			if (flags[kFLAGS.BEHEMOTH_TENT] <= 0) {
				outputText("\n\nThe tent is nicely decorated with a bed at one corner with an end table beside it.  A bookshelf holds various books, implying that the behemoth is actually an intelligent race, capable of reading and writing.  At another corner is a chair and a table where the behemoth would sit and eat or study.");
				outputText("\n\nWhat catches your eye the most is the empty metal basin at the center that looks like it could hold two people.  \"<i>Do you like my tent?</i>\" The behemoth asks.  You tell him that yes, you like his tent.  He smiles at you and gives you a thank.  ");
				flags[kFLAGS.BEHEMOTH_TENT] = 1;
			}
			outputText("\n\n\"<i>So, what would you like?  Bucket or golden shower?</i>\"");
			menu();
			addButton(0, "Bucket", watersportsBucket, null, null, null, "Just urinate into the bucket together and do a bit of foreplay.");
			//addButton(1, "Get Showered", eventParser, 9999, null, null, "Get showered in behemoth's urine!  \n\n(Not yet implemented)");
			flags[kFLAGS.BEHEMOTH_WATERSPORTS]++;
		}
		
		private function watersportsBucket():void {
			clearOutput();
			outputText("Bucket, of course!  The behemoth grabs the bucket nearby and says, \"<i>Let's get started.</i>\"  He moves his loincloth aside and lowers the bucket so his cock goes over the rim, pointing towards the inside of the bucket.  Stream of urine flows from his cock into the bucket.");
			if (player.isTaur()) {
				outputText("\n\nUnfortunately, you have to wait until the behemoth finishes peeing.  Having a tauric body surely puts you at a disadvantage.");
				outputText("\n\nPLACEHOLDER");
			}
			else {
				outputText("\n\nYou join him in filling the bucket with warm yellow liquid.  You open up your [armor], ");
				if (player.hasCock()) { //Cock has priority over vagina.
					outputText("aim your " + cockDescript(player.biggestCockIndex()) + " into the bucket and let out a pressure as your urine mingles with the behemoth's.");
				}
				else if (player.hasVagina() && !player.hasCock()) { //Vagina but no cock.
					outputText("move over the bucket and let out the pressure as your urine mingles with the behemoth's.");
				}
				else { //Genderless can still urinate.
					outputText("move over the bucket and let out the pressure despite your genderlessness as your urine mingles with the behemoth's.");
				}
				outputText("  \"<i>I love you,</i>\" the behemoth says with a smile.  You smile back at him and you eventually finish peeing.  The behemoth is still peeing and the bucket is more than halfway full with mixed urine.");
				outputText("\n\n\"<i>Don't go yet!</i>\" he chuckles,\"<i>After this, we'll do a bit of foreplay.</i>\"  You watch as the bucket is being filled nearly to the brim with urine.  Fortunately, the urine stream does get thinner and stops as the behemoth finishes peeing.  He sets the urine-filled bucket down, walks over to you and gives your [chest] a good caress.");
				outputText("(PLACEHOLDER)");
			}
			if (kGAMECLASS.inCombat) cleanupAfterCombat();
			else doNext(camp.returnToCampUseOneHour);
		}
		
		private function watersportsShower():void {
			clearOutput();
			outputText("PLACEHOLDER");
			if (kGAMECLASS.inCombat) cleanupAfterCombat();
			else doNext(camp.returnToCampUseOneHour);
		}
		
	}

}