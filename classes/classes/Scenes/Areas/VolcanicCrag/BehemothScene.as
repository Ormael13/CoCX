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
		
		public function behemothIntro():void {
			clearOutput();
			if (flags[kFLAGS.MET_BEHEMOTH] <= 0) {
				outputText("As you're exploring the infernal landscape, you are drawn to the sight of a creature you've never seen before: a male bipedal purple-skinned horned creature with spikes on his back.  You guess he is sentient as he's wearing a loincloth.  Underneath his loincloth is a large cock and a duo of balls; you estimate his cock to be 18 inches long and 2½ inches thick but it's hard for sure as his cock is flaccid.  You estimate his balls to be three inches across.  You approach the creature and he says to your surprise, \"<i>Hello there.  Not many even dared to approach me.  Either it's me or it's the landscape.</i>\"");
				outputText("\n\nYou introduce yourself and the creature says, \"<i>" + player.short + ", eh?  I'm the mighty Behemoth.  So what do you want?  Up for battling or interested in sex?</i>\"");
			}
			else {
				outputText("As you're exploring the infernal landscape, you spot the familiar purple-skinned creature.  The behemoth approaches you with a smile and says, \"<i>Hello again, " + player.short + ".  So feeling up for some fights?  Or want to have sex?</i>\"");
			}
			flags[kFLAGS.MET_BEHEMOTH]++;
			menu();
			addButton(0, "Fight", startFight, null, null, null, "Challenge the Behemoth.");
			addButton(1, "Talk", eventParser, 9999, null, null, "Talk to Behemoth and discuss.  \n\n(Not yet implemented, wait until next snapshot!)");
			if (player.lust >= 33) addButton(2, "Sex", behemothSexMenu, false, null, null, "Initiate sexy time with the Behemoth.");
			addButton(4, "Leave", camp.returnToCampUseOneHour);
		}
		
		private function startFight():void {
			clearOutput();
			outputText("You tell him that you're here to fight.  \"<i>All right! Get ready,</i>\" he says with a grin and claws raised.");
			startCombat(new Behemoth());
		}
		
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
			if (player.hasVagina()) addButton(2, "GetVagFucked", vagCatchBehemoth, null, null, null, "Have him penetrate you vaginally. \n\n(Placeholder)");
			//addButton(3, "Suck His Cock", eventParser, 9999, null, null, "Suck his wonderful cock and get stuffed with cum! \n\n(Not yet implemented, wait until next snapshot!)");
			//addButton(4, "Cum Bath", eventParser, 9999, null, null, "Have a (literal) cum bath. \n\n(Not yet implemented, wait until next snapshot!)");
			//if (flags[kFLAGS.WATERSPORTS_ENABLED] > 0) addButton(5, "Watersports", eventParser, 9999, null, null, "Do some urine activity with him. \n\n(Not yet implemented, wait until next snapshot!)");
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
		
		private function analPitchBehemoth():void {
			var x:int = player.cockThatFits(48);
			clearOutput();
			outputText("You tell the behemoth that you're going to take him from behind.  \"<i>All right, let's get this started,</i>\" he says.  The two of you strip yourselves naked.  You toss your " + player.armorName + " into a neat pile.\"");
			outputText("\n\n\"<i>Bend over,</i>\" you instruct the behemoth.  He gives you a nod as he gets down into a doggy position.");
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
			HPChange(player.maxHP() / 4, false);
			flags[kFLAGS.BEHEMOTH_ANAL_CATCH]++;
			if (kGAMECLASS.inCombat) cleanupAfterCombat();
			else doNext(camp.returnToCampUseOneHour);
		}
		
		private function vagCatchBehemoth():void {
			clearOutput();
			outputText("You definitely want that " + (silly() ? "dig bick": "big dick") + " in your [vagina].  ");
			outputText("You strip out of your [armor] until you're naked.  You make sure to toss your [armor] into a neat pile.  You present your naked body and more importantly, your [vagina] to the behemoth.  He shifts his loincloth aside to expose his large pecker and says excitedly, \"<i>Now that's some wonderful pussy you've got there!  I'll go gentle on you and make sure you enjoy the experience.</i>\"");
			player.cuntChange(45, true);
			outputText("\n\n(PLACEHOLDER) And then you were vaginally fucked.  ");
			if (player.hasCock()) outputText("You manage to cum as well.");
			player.orgasm();
			player.knockUp(PregnancyStore.PREGNANCY_BEHEMOTH, PregnancyStore.INCUBATION_BEHEMOTH);
			if (kGAMECLASS.inCombat) cleanupAfterCombat();
			else doNext(camp.returnToCampUseOneHour);
		}
		
		
		private function suckThatBigCock():void {
			clearOutput();
			outputText("PLACEHOLDER");
			if (kGAMECLASS.inCombat) cleanupAfterCombat();
			else doNext(camp.returnToCampUseOneHour);
		}
		
		private function haveACumBathLiterally():void {
			clearOutput();
			outputText("PLACEHOLDER");
			if (kGAMECLASS.inCombat) cleanupAfterCombat();
			else doNext(camp.returnToCampUseOneHour);
		}
		
		private function watersportsWithBehemoth():void {
			clearOutput();
			outputText("PLACEHOLDER");
			if (kGAMECLASS.inCombat) cleanupAfterCombat();
			else doNext(camp.returnToCampUseOneHour);
		}
		
	}

}