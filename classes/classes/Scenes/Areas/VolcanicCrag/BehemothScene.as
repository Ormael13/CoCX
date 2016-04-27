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
			else addButtonDisabled(2, "Sex", "You are not aroused enough to initiate sex with the Behemoth.");
			if (flags[kFLAGS.BEHEMOTH_TALKED_ABOUT_CUM] > 0) addButton(3, "Get Cum", getCum, null, null, null, "Get some of Behemoth's cum!");
			else addButtonDisabled(3, "???", "You need to have talked to the Behemoth about his cum.");
			addButton(4, "Leave", camp.returnToCampUseOneHour);
		}
		
		public function behemothIntro():void {
			clearOutput();
			if (flags[kFLAGS.MET_BEHEMOTH] <= 0) {
				outputText("As you're exploring the infernal landscape, you are drawn to the sight of a creature you've never seen before: a muscular male bipedal purple-skinned horned creature with spikes on his back. You guess he is sentient as he's wearing a loincloth. Underneath his loincloth is a large cock and a duo of balls; you estimate his cock to be 18 inches long and 2½ inches thick but it's hard for sure as his cock is flaccid. You estimate his balls to be three inches across. You approach the creature and he says to your surprise, \"<i>Hello there. Not many even dared to approach me. Either it's me or it's the landscape.</i>\"");
				outputText("\n\nYou introduce yourself and the creature says, \"<i>" + player.short + ", eh? I'm the mighty Behemoth. It's good to see someone like you; I was so lonely. So what do you want?</i>\" He smiles.");
			}
			else {
				outputText("As you're exploring the infernal landscape, you spot the familiar purple-skinned creature. The behemoth approaches you with a smile and says, \"<i>Hello again, " + player.short + ". So feeling up for fighting? Or want to have sex?</i>\"");
			}
			flags[kFLAGS.MET_BEHEMOTH]++;
			behemothMenu();
		}
		
		//Talk
		public function talkToBehemothMenu():void {
			clearOutput();
			outputText(images.showImage("behemoth-talk"), false);
			outputText("You ask the behemoth if he's willing to have a conversation with you. The behemoth says, \"<i>Of course. What would you like to talk about?</i>\"");
			menu();
			addButton(0, "Yourself", talkAboutYourself, null, null, null, "Talk to the behemoth about yourself.");
			addButton(1, "Behemoth", talkAboutBehemoth, null, null, null, "Talk to the behemoth about himself.");
			if (flags[kFLAGS.BEHEMOTH_TALK_LEVEL] >= 1) addButton(2, "His Past", talkAboutSadStory, null, null, null, "Talk to the behemoth about his past.");
			else addButtonDisabled(2, "His Past", "Talk to the behemoth at least once to unlock this.");
			if (timesSexed() >= 2) addButton(3, "His Cum", talkAboutHisCum, null, null, null, "Talk to the behemoth about the special properties of his cum and how he managed to cum that much despite his ball size."); 
			else addButtonDisabled(3, "His Cum", "Have sex with the behemoth at least twice to unlock this.");
			if (flags[kFLAGS.BEHEMOTH_CHILDREN] > 0) addButton(4, "Children", talkAboutHisChildren, null, null, null, "Talk to the behemoth about his son" + (flags[kFLAGS.BEHEMOTH_CHILDREN] == 1 ? "" : "s") + ".");
			else addButtonDisabled(4, "???", "Have at least 1 child with him to unlock this.");
			addButton(14, "Back", behemothMenu);
		}
		
		private function talkAboutYourself():void {
			clearOutput();
			outputText("You tell the behemoth about your origins, where you originally lived in, how you've came to be the champion of Ingnam and sent through the portal. ");
			outputText("\n\n\"<i>Ingnam? That sounds like a nice place. I used to live in another world too and like you, I've went to this world through a portal.</i>\"");
			if (flags[kFLAGS.FACTORY_SHUTDOWN] > 0) {
				outputText("\n\nYou tell the behemoth about how you've managed to shut down the factory. ");
				if (flags[kFLAGS.FACTORY_SHUTDOWN] == 1) {
					outputText("\"<i>Wow, you're quite the hero! I'm glad you've managed to save Marae,</i>\" he smiles.");
				}
				else if (flags[kFLAGS.FACTORY_SHUTDOWN] == 2) {
					outputText("\"<i>Don't you think you should have shut down the factory properly? You've only managed to worsen the corruption,</i>\" he says with a bit of worried look.");
				}
			}
			if (flags[kFLAGS.DEFEATED_ZETAZ] > 0) {
				outputText("\n\nYou tell the behemoth about how you've managed to find and defeat Zetaz, the original imp who tried to rape you in the first place after you've entered the portal. ");
				outputText("\n\nThe behemoth remarks and says, \"<i>That's great! I had a similar story. I had a rival who bullied and mocked me from my childhood. Years later, I've finally got my revenge on him and literally ripped him apart with my bare hands.</i>\" Your jaws drop when he mentions being able to rip someone apart with his strength. He says, \"<i>Yes, seriously. I actully did it. After that, I've had his meat." + (silly() ? " Besides, I wouldn't want to traumatize the player reading whatever we're saying or make the player squick.</i>\"": "") + " "); //Fourth wall breaker
				if (silly()) outputText("Did he just break the fourth wall?");
			}
			if (flags[kFLAGS.LETHICE_DEFEATED] > 0) {
				outputText("\n\nNext, You tell the behemoth about how you've managed to get past the obstacles in Lethice's stronghold and eventually overthrow Lethice, the Queen of the Demons. ");
				outputText("\n\nThe behemoth smiles and says, \"<i>You have fulfilled your role as a Champion! I'm happy for you!</i>\" ");
				if (player.armor == armors.LTHCARM) {
					outputText("The behemoth looks at your strange lethicite armor. \"<i>Wow, Lethice actually managed to harvest enough lethicite to make an armor? Clever use of lethicite. I notice it doesn't cover your groin,</i>\" the Behemoth says. ");
					if (player.lowerGarment.name == "nothing") outputText("He blushes when he looks at your " + (player.hasCock() ? "[cock] hanging freely from the opening" : "groin") + ".");
				}
			}
			if (flags[kFLAGS.CORRUPTED_MARAE_KILLED] > 0) {
				outputText("\n\nNext, you tell the behemoth on how you've slain Marae, the corrupted goddess of Mareth. The behemoth drops his jaws at what you've done. \"<i>You actually KILLED a goddess? Wow, that's quite an amazing feat for a mortal to defeat a deity. You're even stronger than I am! I normally fear the wrath of the gods but you're brave,</i>\" he chuckles.");
			}
			outputText("\n\nAfter chatting for a good while, you and the behemoth part ways and you return to your camp.");
			doNext(camp.returnToCampUseOneHour);
		}
		private function talkAboutBehemoth():void {
			clearOutput();
			outputText("You ask the behemoth about himself. What is he, exactly?");
			outputText("\n\n\"<i>I don't have an actual name but everybody calls me Behemoth. We were a proud race known for incredible strength, feats, and contests. Here, let me show you something,</i>\" the behemoth says and shows you the codex entry on behemoths.");
			if (flags[kFLAGS.CODEX_ENTRY_BEHEMOTH] <= 0) {
				flags[kFLAGS.CODEX_ENTRY_BEHEMOTH] = 1;
				outputText("\n\n<b>New codex entry unlocked: Behemoths!</b>");
			}
			outputText("\n\n\"<i>I suggest you read the codex entry; it contains detailed information,</i>\" the behemoth says.");
			outputText("\n\nYou thank him for the codex entry. \"<i>You're always welcome,</i>\" the behemoth says with a smile. His face begins to shift from a happy to a sad look. \"<i>Something wrong?</i>\" you ask. The behemoth replies, \"<i>Well... I had a rough past. I'd rather not talk about it for now. Why not come back later?</i>\" You nod and wrap your arms around the behemoth, giving him a hug before you say farewell and make your way back to camp.");
			if (flags[kFLAGS.BEHEMOTH_TALK_LEVEL] <= 1) flags[kFLAGS.BEHEMOTH_TALK_LEVEL]++;
			doNext(camp.returnToCampUseOneHour);
		}
		private function talkAboutSadStory():void {
			clearOutput();
			outputText("You ask the behemoth if he's willing to share his story.");
			outputText("\n\n\"<i>All right, just come to my tent and we'll talk,</i>\" the behemoth says as he escorts you to his tent and gestures for you to enter.");
			outputText("\n\nThe behemoth sits on one of the chairs and invites you to take a seat. ");
			if (player.isBiped() || player.isGoo()) outputText("You walk over to the vacant chair and sit on it so you're facing the behemoth.");
			else outputText("Due to your irregular lower half, you move the chair aside and adjust your position so you're facing the behemoth.");
			//Early life
			outputText("\n\nThe behemoth clears his throat and says, \"<i>I had a great childhood. I get to watch my father participate into something called \"Feats of Strength\". I was just a year old back then but mind you, we reach maturity in two years so I'd guess the equivalent to nine human years. It lasts three days and whoever had the most points get to become the tribe leader. My father emerged victorious in the Feat of Strength and became the leader of the tribe I lived in.</i>\"");
			outputText("\n\n\"<i>What's next?</i>\" you ask.");
			outputText("\n\n\"<i>When my second birthday comes, my father told me that I was meant to be sent through the portal. I was like \"WHAT?\" and my father claimed that should the sacrifice fail, my homeworld would be doomed. Of course, I don't believe that but I got sent into the portal anyway and I can't come back. The portal wouldn't let me go back at all. For the first two weeks, I check up on the portal if it opens but to no avail. Luckily, before I got sent, I was given two hundred gems. So I spend some time exploring the realms of this world.</i>\"");
			outputText("\n\nOkay, so he's an explorer. What sort of something interesting did he find?");
			outputText("\n\n\"<i>I've met that Oni named Izumi in the high mountains. She claims to be the 'Font of All Strength' and while she's indeed strong, I'm even stronger! The duel lasted for quite some time but I emerged victorious and in the end, I had sex with her. I'm quite relieved to find someone who's pure.</i>\"");
			//Tel'Adre
			if (player.statusEffectv1(StatusEffects.TelAdre) >= 1) {
				outputText("\n\nYou ask the behemoth if he ever visited Tel'Adre.");
				outputText("\n\n\"<i>Of course. It's a really nice place and there is that hermaphrodite gray fox named Urta who usually hang out at \"The Wet Bitch\". I have no idea why the bar has such suggestive name. Anyways, I've made a stop at the bakery and tried out the delicious brownies. I've worked out at the gym; it's a pretty great place to hang out!</i>\"");
			}
			//Behemoth the Imp Slayer!
			outputText("\n\n\"<i>When I'm taking a stroll on the path to visit various regions, I've seen imps. All of them ran away from me except for one. I let the imp approach me but I could see his face twisting into a grin and he tries to force himself. It's a HUGE mistake for him. I punched him square in the chin and he reels back. But he gets up and tries to force himself on me again so I picked him up and ripped him with my strength. I let out a laugh like this,</i>\" the behemoth laughs like a beast and says, \"<i>I even took his skull to remind the imps to never mess with me.</i>\" The behemoth gets up and grabs the imp skull and shows it to you and says, \"<i>This is real. You can see the horns protruding from this skull.</i>\" You look at the skull; it definitely looks and feels real. The behemoth gets up, puts the imp skull away and sits down.");
			outputText("\n\n\"<i>Anything else?</i>\" you ask.");
			//Sad story.
			outputText("\n\n\"<i>This part is tragic. By the time I'm allowed to go back through the portal, I was horrified to find out what happened. My village... destroyed. My tribe... dead. The whole landscape is ravaged. I've spent time searching for survivors but to no avail. Not a trace of life. So I give my family a proper burial and packed up all my stuff before finally moving back to Mareth and locked away the portal,</i>\" the behemoth says, tears leaking from his eyes.");
			outputText("\n\nThis is quite sad. You wrap your arms around the behemoth and give him an assuring hug. He says, \"<i>Thank you for comforting me. I needed some company anyways.</i>\" You ask him if he has anything left.");
			outputText("\n\n\"<i>I'm afraid that's pretty much my entire story but I only hope to find someone who's pure and willing to bear children and start a new family,</i>\" the behemoth says. You thank him for telling you the story. \"<i>You're always welcome,</i>\" the behemoth says with a smile. You give him a farewell and walk back to camp.");
			if (flags[kFLAGS.BEHEMOTH_TALK_LEVEL] <= 2) flags[kFLAGS.BEHEMOTH_TALK_LEVEL]++;
			doNext(camp.returnToCampUseOneHour);
		}
		private function talkAboutHisCum():void {
			clearOutput();
			outputText("You ask the behemoth about the properties of his cum and how he can cum that much.");
			outputText("\n\n\"<i>My cum makes people stronger. Whenever I get the cum inside their bodies or people drink my cum, they gain a bit of strength and toughness. For the question about how I can cum that much, that's a natural for our race. In fact, we end up using our cum for sauce and for bathing. My balls may be three inches across but I can definitely cum as much as I want to, up to two hundred litres!</i>\" the behemoth says, \"<i>Hey, want some of my cum? You'll get to bring it with you!</i>\"");
			outputText("\n\nSeems like the behemoth is offering you his cum. Do you want it?");
			flags[kFLAGS.BEHEMOTH_TALKED_ABOUT_CUM] = 1;
			doYesNo(getCum, noThanks);
		}
		private function talkAboutHisChildren():void {
			clearOutput();
			outputText("You ask the behemoth how his son" + (flags[kFLAGS.BEHEMOTH_CHILDREN] > 1 ? "s are": " is") + " doing.");
			if (flags[kFLAGS.BEHEMOTH_CHILDREN] == 1) outputText("\n\n\"<i>He's doing great</i>\"");
			else outputText("\n\n\"<i>They're doing great</i>\"");
			outputText(", the behemoth says smilingly. You are happy to know that your family is going well and you're going to spend quality time.");
			//Interact!
			var chooser:int = rand(4);
			if (chooser == 0) {
				//Story-telling!
				
			}
			outputText("\n\nPLACEHOLDER");
			dynStats("lib", -1, "lus", -20, "resisted", false, "noBimbo", true);
			doNext(camp.returnToCampUseOneHour);
		}
		//Cum offer
		private function getCum():void {
			clearOutput();
			outputText("You definitely want his cum! The behemoth smiles at you and says, \"<i>I'll start.</i>\" He moves his loincloth aside and begins stroking his cock to full mast.");
			outputText("\n\nThe behemoth moans in pleasure as he squeezes his balls and jerks himself off with his hands. He yells, \"<i>I'm going to cum! Get the bottle!</i>\"");
			outputText("\n\nYou pull out an empty bottle and points his cock towards the bottle opening. The behemoth finally reaches his orgasm as he cums, filling the bottle entirely and it overflows, the excessive cum spilling all over the thirsty earth. The behemoth eventually finishes orgasming and says, \"<i>If you ever need more, feel free to ask.</i>\" ");
			inventory.takeItem(consumables.BHMTCUM, camp.returnToCampUseOneHour);
		}
		private function noThanks():void {
			clearOutput();
			outputText("You politely decline the offer. \"<i>All right. Just come back anytime, okay?</i>\" the behemoth says. You say your goodbye to the behemoth and make your way back to your camp.");
			doNext(camp.returnToCampUseOneHour);
		}
		
		//Combat
		private function startFight():void {
			clearOutput();
			outputText("You tell him that you're here to fight. \"<i>All right! Get ready,</i>\" he says with a grin and claws raised.");
			startCombat(new Behemoth());
			monster.createStatusEffect(StatusEffects.Spar,0,0,0,0);
		}
		
		public function winAgainstBehemoth():void {
			clearOutput();
			if (monster.HP <= 0) outputText("The behemoth falls down on his knees, too badly beaten to continue fighting.");
			else outputText("The behemoth falls down on his knees, too turned on to continue fighting.");
			outputText("\n\n\"<i>You have managed to beat me. Nothing beats a good workout,</i>\" he says.");
			//Get some gems back.
			if (flags[kFLAGS.BEHEMOTH_GEMS] >= 5) {
				var gemsBonus:int = (flags[kFLAGS.BEHEMOTH_GEMS] / 2);
				if (gemsBonus < 5) gemsBonus = 5;
				flags[kFLAGS.BEHEMOTH_GEMS] -= gemsBonus;
				monster.gems += gemsBonus;
			}
			menu();
			if (player.lust >= 33) addButton(0, "Sex", behemothSexMenu, true, null, null, "Initiate sexy time with the Behemoth.");
			addButton(4, "Leave", combat.cleanupAfterCombat);
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
			if (doSFWloss()) {
				outputText("\n\n\"<i>I win and you know what that means? I'll take some of your gems,</i>\" he says and he takes " + gemsLost + " gems from your pouch, \"<i>I'll take care of you while you're recovering.</i>\" You black out...");
				HPChange(player.maxHP() / 2, false);
				player.changeFatigue(-50);
				return;
			}
			if (player.HP <= 0) outputText("You collapse from your injuries.");
			else outputText("You collapse from your overwhelming desires.");
			outputText("\n\n\"<i>I win and you know what that means? I'll take some of your gems and I get to fuck your ass. Don't you worry, I'll be gentle,</i>\" he says with a grin. He takes " + gemsLost + " gems from your pouch. \"<i>I will give you some of your gems back should you beat me,</i>\" he says.");
			doNext(analCatchBehemoth);
		}
		
		public function giveBirthToBehemoth():void {
			clearOutput();
			outputText("The pain in your womb is getting unbearable. You realize it's time for you to give birth to the behemoth! You make your way to the behemoth's tent in the volcanic crag to see the behemoth smiling at you.");
			outputText("\n\n\"<i>I'll help you. Lay on my bed,</i>\" the behemoth says" + player.clothedOrNaked(" as he assists you in removing your [armor]") + ". You lay on the bed and spread your [legs]. The labour is getting intense but you know the behemoth is already excited.");
			outputText("\n\n\"<i>Push,</i>\" the behemoth instructs. That's your encouragement as you start pushing, taking deep breath between pushes. Eventually, your ordeal is over as the newborn behemoth finally comes out of your womb. \"<i>You've done great!</i>\" the behemoth says, smilingly.");
			player.cuntChange(48, true);
			flags[kFLAGS.BEHEMOTH_CHILDREN]++;
			if (flags[kFLAGS.BEHEMOTH_CHILDREN] == 1) {
				outputText("\n\n\"<i>Look at that. Our first child. I'm finally happy to finally have a family! You're now a mother,</i>\" the behemoth says. You smile at him and you spend some time breastfeeding your newborn.");
				flags[kFLAGS.BEHEMOTH_CHILD_1_BIRTH_DAY] = model.time.days;
			}
			else if (flags[kFLAGS.BEHEMOTH_CHILDREN] == 2) {
				outputText("\n\n\"<i>My second child! Now my first son won't be lonely!</i>\" the behemoth says smilingly. ");
				flags[kFLAGS.BEHEMOTH_CHILD_2_BIRTH_DAY] = model.time.days;
			}
			else if (flags[kFLAGS.BEHEMOTH_CHILDREN] == 3) {
				outputText("\n\n\"<i>My third child! I think I have enough children, thank you. I love you,</i>\" the behemoth says smilingly as he gives you a kiss.");
				flags[kFLAGS.BEHEMOTH_CHILD_3_BIRTH_DAY] = model.time.days;
			}
			outputText("\n\nYou rest for a while and breastfeed your newborn. Eventually, you know you should return to your camp. \"<i>I'll take good care of him,</i>\" the behemoth says. You give him a goodbye and walk back to your camp.");
			player.knockUpForce(); //Clear!
			doNext(camp.returnToCampUseOneHour);
		}
		
		//Sex menu
		private function behemothSexMenu(victory:Boolean = false):void {
			clearOutput();
			if (victory) {
				outputText("You tell the behemoth that you'd love to blow off some steam after a fight session. He says, \"<i>Of course. What would you like to do?</i>\" ");
			}
			else {
				outputText("You tell the behemoth that you're here to have sex with him. He looks at you and says, \"<i>I'm game. What would you like to do?</i>\" ");
			}
			menu();
			if (player.hasCock()) {
				if (player.cockThatFits(72) >= 0) addButton(0, "Anal Fuck", analPitchBehemoth, null, null, null, "Anally penetrate the behemoth.");
				else outputText("\n\n<b>Unfortunately, your cock is too big to fit in his butthole.</b>");
			}
			else addButtonDisabled(0, "Anal Fuck", "You need a cock for this.");
			addButton(1, "GetAnalFucked", analCatchBehemoth, null, null, null, "Have him penetrate you anally.");
			if (player.hasVagina()) addButton(2, "GetVagFucked", vagCatchBehemoth, null, null, null, "Have him penetrate you vaginally.");
			else addButtonDisabled(2, "GetVagFucked", "You need a vagina for this.");
			addButton(3, "Suck His Cock", suckThatBigCock, null, null, null, "Suck his wonderful cock and get stuffed with cum!");
			if (timesSexed() >= 3) addButton(4, "Cum Bath", haveACumBathLiterally, null, null, null, "Have a (literal) cum bath!");
			else addButtonDisabled(4, "Cum Bath", "Have sex with the behemoth enough times to unlock this!");
			if (flags[kFLAGS.WATERSPORTS_ENABLED] > 0) {
				if (timesSexed() >= 3) addButton(5, "Watersports", watersportsWithBehemoth, null, null, null, "Do some urine activity with him.");
				else addButtonDisabled(5, "Watersports", "Have sex with the behemoth enough times to unlock this!");
			}
			if (!kGAMECLASS.inCombat) addButton(14, "Nevermind", camp.returnToCampUseOneHour);
			else addButton(14, "Nevermind", combat.cleanupAfterCombat);
		}
		
		private function analPitchBehemoth():void {
			var x:int = player.cockThatFits(48);
			clearOutput();
			outputText(images.showImage("behemoth-anal-pitch"), false);
			outputText("You tell the behemoth that you're going to take him from behind. \"<i>All right, let's get this started,</i>\" he says. " + player.clothedOrNaked("The two of you strip yourselves naked. You toss your " + player.armorName + " into a neat pile. ") + "The behemoth removes his loincloth, revealing his large cock.");
			outputText("\n\n\"<i>Bend over,</i>\" you instruct the behemoth with a smirk. He gives you a nod as he gets down into a doggy position.");
			outputText("\n\nYou give his butt-cheeks a gentle caress" + (player.cor >= 30 ? " followed by a sudden spank which causes him to yelp in surprise": " to assure him that you're going to be gentle.") + ".");
			outputText("\n\nHe lifts his spiked tail to give you a good look at his entire backside. You spit on your hands and apply the saliva all over your " + player.cockDescript(x) + " to get it well-lubricated.");
			outputText("\n\nThe behemoth clenches his teeth in preparation for what's coming. You slowly sink your entire " + player.cockDescript(x) + " into his tight rear entrance. By god, he's tight! \"<i>What are you waiting for? Fuck my ass!</i>\" He demands with a grin.");
			outputText("\n\nThat's all the encouragement you need. You grunt with pleasure as his sphincter clamps down on your " + player.cockDescript(x) + ". You pound his ass, slowly but surely. His cock hardens to full erection, indicating that he's definitely enjoying being penetrated.");
			outputText("\n\n\"<i>Yes! I love it when you fuck my ass like that,</i>\" he cries with pleasure as precum leaks from his cock. You reach over to caress his pecs and belly and slowly rub them. You swear you can hear him purr.");
			outputText("\n\nEventually, you can hold back no more. You let out a scream in pleasure as you unload right into his bowels");
			if (player.cumQ() < 250) outputText("");
			else if (player.cumQ() >= 250 && player.cumQ() < 1000) outputText(", filling it completely");
			else if (player.cumQ() >= 1000) outputText(", filling it completely and stuffing his stomach");
			outputText(".");
			outputText("The behemoth shoots huge torrents of cum, far more than his balls could possibly hold. You watch him cumming and cumming, never seeming to stop. He does stop and by the time he finished cumming, he has created quite the pool! With the two of you exhausted from the ordeal, you lay on top of him and rest for a while.");
			outputText("\n\nYou give him a kiss on one of his cheeks and let him know that you'll be going. \"<i>See you later,</i>\" the behemoth says with a smile on his face. You redress and leave back to your camp.");
			player.orgasm();
			flags[kFLAGS.BEHEMOTH_ANAL_PITCH]++;
			if (kGAMECLASS.inCombat) combat.cleanupAfterCombat();
			else doNext(camp.returnToCampUseOneHour);
		}
		
		private function analCatchBehemoth():void {
			var isVirgin:Boolean = (player.looseness(false) == 0);
			clearOutput();
			outputText(images.showImage("behemoth-anal-catch"), false);
			if (player.HP <= 0 || player.lust >= player.maxLust()) {
				outputText("You have no choice but to accept the fact that the behemoth is going to penetrate you anally. He looks at you with a grin and says, \"<i>Go on, strip for me. I want to see your wonderful butt, " + player.mf("dude", "chick") + ".</i>\"\n\n");
			}
			else {
				outputText("You definitely want that " + (silly() ? "dig bick": "big dick") + " in your [ass]. ");
			}
			outputText("" + player.clothedOrNaked("You strip out of your [armor] until you're naked. You make sure to toss your [armor] into a neat pile. ") + "You present your naked body and more importantly, your [butt] to the behemoth. He shifts his loincloth aside to expose his large pecker and says excitedly, \"<i>Now that's some wonderful butt-cheeks you've got there! I'll go gentle on you and make sure you enjoy the experience.</i>\"");
			if (player.isBiped()) outputText("\n\nYou get down on all fours");
			else if (player.isTaur()) outputText("\n\nYou adjust your pose so your [butt] is at the right height");
			else if (player.isNaga()) outputText("\n\nYou shift your body and tail until your [ass] is accessible");
			else if (player.isGoo()) outputText("\n\nYou shift your gooey body");
			outputText(" and prepare for whatever he has in store for you. The behemoth walks to you and caress your [butt] gently. He walks around you and sticks his manhood into your mouth. He smiles and says, \"<i>I need them lubed up. I want you to suck it good!</i>\"");
			outputText("\n\nYou have no choice; you're going to coat his length in saliva. After all, he needs a good lubricant so you can take his monster cock. You can already taste the precum but the behemoth pulls his cock out of your mouth. \"<i>That'll do. I'm going to start now,</i>\" he says as he gets behind you.");
			outputText("\n\nYou clench your teeth and ready for whatever's coming. You feel the tip of his cock entering your backdoor. As time passes, more and more of his length slides into your [ass].");
			player.buttChange(45, true, true, true);
			if (isVirgin) outputText("\"<i>Gods, that's tight! It's a good thing you've been saving your virginity for me,</i>\" The behemoth says with a smile.");
			if (player.looseness(false) < 3) outputText(" It takes a bit of effort for him to slide his cock inside due to your tightness.");
			else outputText(" He easily slides his entire length into your [ass].");
			outputText("\n\nEven though his cock is large, you don't feel any sign of discomfort. The behemoth slides his cock back and forth with your [ass] clamping down. ");
			if (player.hasCock()) outputText("Your " + (player.cocks.length == 1 ? "cock": "cocks") + " springs to full erectness and precum leaks from your " + player.multiCockDescript() + ". ");
			if (player.hasCock() && player.hasVagina()) outputText("At the same time, ");
			if (player.hasVagina()) outputText("" + (player.hasCock() ? "femspunk": "Femspunk") + " leaks from your " + player.vaginaDescript() + "."); 
			outputText("\n\n\"<i>I'm going to pace up a bit,</i>\" the behemoth announces. He gradually increases his thrusting pace. With each thrust, you moan in pleasure and enjoy every moment of being fucked. ");
			if (flags[kFLAGS.BEHEMOTH_ANAL_CATCH] <= 0) outputText("He says, \"<i>I'm sure you've never known about how much a behemoth can cum. In fact, I'm capable of producing a lot of cum, far beyond what a minotaur can produce. Or even that fox-herm in Tel'Adre! Don't let the size of my balls deceive you,</i>\" he says with a chuckle. You recall his balls being three inches in length.");
			outputText("\n\nIt seems take forever but all good things must come to an end. \"<i>I'm going to cum!</i>\" The behemoth announces. With a cry of pleasure and glee, he unleashes a huge amount of cum into your bowels. His cum surges through your intestines and up to your belly. By the gods, you feel so full! You look down to notice that your belly definitely got swollen. ");
			player.refillHunger(70, false);
			outputText("His orgasm triggers yours too.\n\n");
			if (player.hasCock()) {
				outputText("You cum, ");
				if (player.cumQ() < 50) outputText("shooting small ropes of jism all over the ground.");
				else if (player.cumQ() >= 50 && player.cumQ() < 250) outputText("shooting ropes of jism all over the ground.");
				else if (player.cumQ() >= 250 && player.cumQ() < 500) outputText("shooting jets of cum all over the ground, forming a small puddle.");
				else if (player.cumQ() >= 500 && player.cumQ() < 2500) outputText("shooting torrents of cum all over the ground, forming a medium puddle of your seed.");
				else outputText("shooting waves after waves of your seed that never seem to end. A large puddle of cum forms after you eventually stop cumming.");
			}
			if (player.hasCock() && player.hasVagina()) outputText("At the same time, ");
			if (player.hasVagina()) {
				if (player.averageVaginalWetness() < 4) outputText("" + (player.hasCock() ? "femspunk": "Femspunk") + " bursts from your " + player.vaginaDescript() + " and seeps down your [legs].");
				else outputText("" + (player.hasCock() ? "femspunk": "Femspunk") + " gushes from your " + player.vaginaDescript() + " and splashes onto the ground."); 
			}
			if (player.gender == 0) outputText("Your entire body rocks from the overwhelming pleasure.");
			outputText(" You finally recover from your orgasmic high and fall down, exhausted. The behemoth finally slides his cock out of your cum-stuffed [ass] and lays next to you. \"<i>It feels great to have someone to fuck,</i>\" the behemoth says.");
			outputText("\n\nHe lays on top of you and the two of you rest for a while. You wake up some time later and you give the behemoth a kiss on one of his cheeks and let him know that you'll be going. \"<i>See you later,</i>\" the behemoth says with a smile on his face. You " + player.clothedOrNaked("redress and ") + "walk back to your camp, oddly feeling a bit better.");
			player.orgasm();
			player.slimeFeed();
			HPChange(player.maxHP() / 4, false);
			flags[kFLAGS.BEHEMOTH_ANAL_CATCH]++;
			dynStats("str", 0.5, "tou", 0.5);
			HPChange(50 + (player.maxHP() / 5), false);
			if (kGAMECLASS.inCombat) combat.cleanupAfterCombat();
			else doNext(camp.returnToCampUseOneHour);
		}
		
		private function vagCatchBehemoth():void {
			var isVirgin:Boolean = player.hasVirginVagina()
			clearOutput();
			outputText(images.showImage("behemoth-vag-catch"), false);
			//Sorry, no centaur variant.
			outputText("You definitely want that " + (silly() ? "dig bick": "big dick") + " in your [vagina]. ");
			outputText("" + player.clothedOrNaked("You strip out of your [armor] until you're naked. You make sure to toss your [armor] into a neat pile. ") + "You present your naked body and more importantly, your [vagina] to the behemoth.  You notice that his erection is tenting under his loincloth. He shifts it aside to expose his large pecker and says excitedly, \"<i>Now that's some wonderful pussy you've got there! I'll go gentle on you and make sure you enjoy the experience.</i>\"");
			outputText("\n\nThe behemoth guides you to his bed and instructs you to lie down on the bed, which you follows obediently. You spread your [legs] to expose your womanhood" + (player.hasCock() ? " and manhood": "") + ". The Behemoth gives you a smile and slowly slides his long, prehensile tongue into your muff. \"<i>Gotta loosen you up first. Learned that the hard way with those goblins. Poor gals never stood a chance.</i>\" Ecstasy floods your system as he licks your [pussy]. Behemoth’s rough tongue slowly inches its way in, rubbing in all your pleasure spots. You end up cumming when the tongue forces it way into your womb. Behemoth slowly stands up and removes his femcum covered tongue out of your [pussy]. He licks his lips and says, “<i>Delicious... that should do it. Now for the main course.</i>” Behemoth holds his massive cock in his hand and positions it right outside your vagina. You can’t take it anymore and yell \"<i>Stop teasing me and fuck me with your ginormous cock already!</i>\" That was all the motivation Behemoth needed. In one quick stroke he penetrates your cooter and pushes it in all the way to your womb.");
			player.cuntChange(45, true, true);
			if (isVirgin) outputText("\n\n\"<i>I'm so glad you've saved your virginity for me. By the time people reached the endgame levels, none of them are virgin,</i>\" the behemoth says with a smile. ");
			outputText("\n\nThe Behemoth starts to piston inside and out of your [pussy] and picks up the pace gradually. ");
			if (flags[kFLAGS.BEHEMOTH_CHILDREN] <= 0) outputText("\"<i>I want to be a father someday. If I could start a family, that would be great,</i>\" the Behemoth says. ");
			outputText("\n\nHis cock feels great in your [vagina]! His cock feels great in your cooter! You continue to moan and groan in pleasure as the Behemoth continues to pound away with cervix-breaking force. ");
			outputText("Your [chest] keeps rocking back and forth" + (player.isLactating() ? ", spilling milk" : "") + ".");
			outputText("Your eyes widen as the behemoth announces, \"<i>Got to cum!</i>\" and unleashes his full torrents of cum right into your womb. Your womb is assaulted by Behemoth’s hot jizz. Overflowing with pleasure, you hook your legs together behind Behemoth while he fills you up. By Marae, how much is he cumming? You're already stuffed with your belly bulging forwards as if you were 9 months and he’s still not stopping. Gradually the amount pouring in slows down and when Behemoth finally pull out his cock, all the excessive cum spills out of your cunt. ");
			if (player.hasCock()) outputText("Your [cock] shoots ropes of jism at the Behemoth.");
			outputText("\n\nSpent, the behemoth lays next to you and says, \"<i>I love you, " + player.mf("dude", "chick") + "." + (flags[kFLAGS.BEHEMOTH_VAGINAL_CATCH] == 0 ? " If you ever get pregnant, I want to let you know that pregnancy lasts <b>two months</b>. My cum won't fertilize your womb if you're not pure enough." : "") + "</i>\" You smile at him while rubbing your cum-filled belly and fall into a nice nap.");
			outputText("\n\n<b>Some time later...</b>");
			outputText("\n\nYou wake up from your nap refreshed and invigorated and give the Behemoth a kiss before you " + player.clothedOrNaked("redress yourself in your [armor], and ") + "make your way back to your camp.");
			player.orgasm();
			player.slimeFeed();
			if (flags[kFLAGS.BEHEMOTH_CHILDREN] < 3 && player.cor < 25 + player.corruptionTolerance()) player.knockUp(PregnancyStore.PREGNANCY_BEHEMOTH, PregnancyStore.INCUBATION_BEHEMOTH, 50 + (flags[kFLAGS.BEHEMOTH_CHILDREN] * 15) + player.cor);
			flags[kFLAGS.BEHEMOTH_VAGINAL_CATCH]++;
			dynStats("str", 0.5, "tou", 0.5);
			HPChange(50 + (player.maxHP() / 5), false);
			if (kGAMECLASS.inCombat) combat.cleanupAfterCombat();
			else doNext(camp.returnToCampUseOneHour);
		}
		
		
		private function suckThatBigCock():void {
			clearOutput();
			var hungerRefill:int = 100 - player.hunger;
			if (hungerRefill < 40) hungerRefill = 40;
			outputText(images.showImage("behemoth-blowjob"), false);
			outputText("Your eyes draw near the big bulge in his loincloth and you lick your lips as if you're hungry. ");
			if (player.findStatusEffect(StatusEffects.LustyTongue) >= 0) {
				outputText("Your body tingles with arousal as your " + player.tongueDescript() + " makes contact with your lips. ");
				dynStats("lus", 30);
			}
			outputText("The behemoth looks at you with a grin and says, \"<i>See something you want, " + player.short + "?</i>\" You give him a nod and smile.");
			outputText("\n\nYou move his loincloth aside to reveal his monster cock. Now that's a " + (silly() ? "dig bick": "big dick") + "! Time for a little foreplay; you stroke his cock and the behemoth lets out a moan. \"<i>I love it when you do this! It gets my dick really nice and hard,</i>\" he says. You give his balls a caress and you swirl your finger around his cockhead. Precum leaks from his cock.");
			outputText("\n\nSatisfied with the precum leaking, you slowly slide his cock into your mouth, trying to suppress your gag reflex. His cock slides in inch by inch until it reaches the back of your mouth. \"<i>Whoa, ease up, " + player.mf("boy", "girl") + ". I don't want you to choke on my cock. You know you don't have to swallow my entire cock length,</i>\" he says with a smile.");
			outputText("\n\nYour " + player.tongueDescript() + " swirls around his cock and you bob your head up and down eagerly; the behemoth lets out a purr and moan happily as you're giving his cock a good sucking.");
			outputText("\n\nYou continue to suck his meaty cock until the behemoth announces, \"<i>Gonna cum! Prepare to get stuffed!</i>\" Your eyes widen as cum erupts from his cock and into your mouth. You have no choice but to swallow the delicious behemoth-cum and you lose count after the tenth jet of cum. Your belly practically inflates with cum.");
			player.refillHunger(hungerRefill);
			player.slimeFeed();
			outputText("\n\nThe behemoth pulls his cock out of your mouth and the rest of the cum spills all over the earth. With his orgasm eventually coming to an end, the behemoth looks at you with your swollen belly. \"<i>I really stuffed you, didn't I? At least you won't have to eat for a bit,</i>\" he chuckles. You tell him that yes, he did stuff you with cum!");
			outputText("\n\nYou lay next to him and rest for an hour before you say your goodbyes to the behemoth and walk back to your camp.");
			flags[kFLAGS.BEHEMOTH_COCK_SUCKED]++;
			dynStats("str", 0.5, "tou", 0.5, "lus", 30);
			if (kGAMECLASS.inCombat) combat.cleanupAfterCombat();
			else doNext(camp.returnToCampUseOneHour);
		}
		
		private function haveACumBathLiterally():void {
			clearOutput();
			outputText(images.showImage("behemoth-cum-bath"), false);
			outputText("The behemoth looks at you and says, \"<i>Really? You want a cum bath? " + (flags[kFLAGS.BEHEMOTH_CUM_BATH] <= 0 ? "You're in luck as I can make a cum bath, literally! Yes, a literal cum bath. Don't let the size of my balls fool you; I can cum much higher than what you think my balls can hold." : "No problem, I'm going to give you another cum bath.") + "</i>\"");
			if (flags[kFLAGS.BEHEMOTH_CUM_BATH] <= 0) {
				outputText("\n\nYou are already eager for a literal cum bath! ");
				if (silly()) outputText("There has never been a literal cum bath in this game! ");
				outputText("You are curious to what it actually feels like.");
			}
			outputText("\n\n\"<i>Come to my tent, I have something,</i>\" the behemoth says. You give him a nod and " + (player.isGoo() || player.isNaga() ? "slither": "walk") + " with him all the way to his tent. " + (flags[kFLAGS.BEHEMOTH_CUM_BATH] <= 0 ? "The tent is fairly large and looks like several people could comfortably sleep in there.": "") + " The behemoth gestures for you to enter and you enter along with him.");
			if (flags[kFLAGS.BEHEMOTH_TENT] <= 0) {
				outputText("\n\nThe tent is nicely decorated with a bed at one corner with an end table beside it. A bookshelf holds various books, implying that the behemoth is actually an intelligent race, capable of reading and writing. At another corner is a chair and a table where the behemoth would sit and eat or study.");
				outputText("\n\nWhat catches your eye the most is the empty metal basin at the center that looks like it could hold two people. \"<i>Do you like my tent?</i>\" The behemoth asks. You tell him that yes, you like his tent. He smiles at you and gives you a thank. ");
				flags[kFLAGS.BEHEMOTH_TENT] = 1;
			}
			outputText("\n\n" + (player.armor == armors.GOOARMR ? "Valeria pours from your armor before you remove your armor" : "You remove your [armor]") + ", put it into a neat pile on his bed and " + (player.isGoo() || player.isNaga() ? "slither": "walk") + " over to the basin. \"<i>This is where I will cum into. Get into basin and I'll take care from there,</i>\" the behemoth instructs.");
			outputText("\n\nYou get into the basin as told and watch the behemoth moves his loincloth aside to reveal his huge prick. He smiles at you and says, \"<i>I'm going to start now. You can help by caressing my balls to make me reach orgasm faster.</i>\" He begins stroking his cock and you reach over to caress his 3-inch balls. In no time at all, his cock springs to full erection, already leaking precum. Fantasies and thoughts fill the behemoth's mind and he masturbates in earnest.");
			outputText("\n\nEventually, he can hold back no more. \"<i>Can't hold back! Gotta cum,</i>\" he announces as he finally unleashes huge torrents of cum into the basin. It seems to never end and the basin is being filled with cum up to your neck. You sit back and relax as the behemoth finishes cumming, cock still dripping with semen. He removes his loincloth and places it next to your [armor].");
			outputText("\n\n\"<i>I'm going to join,</i>\" he says. He steps into the cum-filled basin and reclines back. With the " + (player.armor == armors.GOOARMR ? "three" : "two") + " of you now having a literal cum bath, you relax for some time. ");
			if (flags[kFLAGS.BEHEMOTH_CUM_BATH] <= 0) outputText("You never knew having a literal cum bath felt so good!");
			outputText("\n\nThe behemoth moves over to kiss you and you let out a deep groan and moan as his tongue probes the inside of your mouth. He retracts back and says, \"<i>I love you.</i>\" ");
			if (player.armor == armors.GOOARMR) outputText("Valeria says, \"<i>Thanks for the fluids!</i>\"");
			outputText("\n\nYou caress his cheeks and recline back...");
			outputText("\n\n<b>One hour later...</b>");
			outputText("\n\nYou get out of the cum-filled basin and " + (player.isGoo() ? "absorb the cum into your gooey body": "shake the excessive cum off") + " before " + player.clothedOrNaked("getting yourself re-dressed into your [armor] and") + " rustle the behemoth's hair.  \"<i>See you later. Come back anytime for more fun,</i>\" the behemoth says. You give him a final kiss before you make your way back to camp, already feeling a lot better.");
			flags[kFLAGS.BEHEMOTH_CUM_BATH]++;
			HPChange(player.maxHP() / 2, false);
			player.changeFatigue(-50);
			if (player.armor == armors.GOOARMR) kGAMECLASS.valeria.feedValeria(100);
			dynStats("str", 0.5, "tou", 0.5, "lus", 30);
			player.slimeFeed();
			if (kGAMECLASS.inCombat) combat.cleanupAfterCombat();
			else doNext(camp.returnToCampUseTwoHours);
		}
		
		private function watersportsWithBehemoth():void {
			clearOutput();
			outputText(images.showImage("behemoth-watersports"), false);
			outputText("\<i>You want to do some watersports with me? Of course,</i>\" the behemoth chuckles, \"<i>just follow me to my tent.</i>\"");
			outputText("\n\nYou follow the behemoth all the way to his tent and he gestures for you to enter and you enter along with him.");
			if (flags[kFLAGS.BEHEMOTH_TENT] <= 0) {
				outputText("\n\nThe tent is nicely decorated with a bed at one corner with an end table beside it. A bookshelf holds various books, implying that the behemoth is actually an intelligent race, capable of reading and writing. At another corner is a chair and a table where the behemoth would sit and eat or study.");
				outputText("\n\nWhat catches your eye the most is the empty metal basin at the center that looks like it could hold two people. \"<i>Do you like my tent?</i>\" The behemoth asks. You tell him that yes, you like his tent. He smiles at you and gives you a thank. ");
				flags[kFLAGS.BEHEMOTH_TENT] = 1;
			}
			//outputText("\n\n\"<i>So, what would you like? Bucket or golden shower?</i>\"");
			//menu();
			//addButton(0, "Bucket", watersportsBucket, null, null, null, "Just urinate into the bucket together and do a bit of foreplay.");
			//addButton(1, "Get Showered", watersportsShower, null, null, null, "Get showered in behemoth's urine!");
			flags[kFLAGS.BEHEMOTH_WATERSPORTS]++;
			outputText("\n\n");
			watersportsBucket();
			
		}
		
		private function watersportsBucket():void {
			//clearOutput();
			outputText("The behemoth grabs the bucket nearby and says, \"<i>Let's get started.</i>\" He moves his loincloth aside and lowers the bucket so his cock goes over the rim, pointing towards the inside of the bucket. Stream of urine flows from his cock into the bucket.");
			if (player.isTaur()) {
				outputText("\n\nUnfortunately, you have to wait until the behemoth finishes peeing. Having a tauric body surely puts you at a disadvantage.");
				outputText("\n\nThe behemoth is aware of your body type, sighs and says \"<i>I guess it's not a good idea being a 'taur. We could have peed together. Oh well, I'll just finish up and let you release the pressure.</i>\"");
				outputText("\n\nHe eventually finishes peeing and the bucket is filled three-quarter-way with urine before he sets the bucket under your rear legs.");
				if (player.hasCock()) outputText("\n\nFortunately, having a cock really helps. The behemoth holds the bucket under your [cock] and you finally release the pressure into the bucket");
				else if (player.hasVagina()) outputText("\n\nBeing a female centaur, this is getting tricky. The behemoth says, \"<i>Fortunately, I DO read books and I've learned about the anatomy some time ago. I can help you.</i>\" He holds up the bucket so you can release the urine from your [vagina] into the bucket");
				else outputText("\n\nDespite your genderlessness, you know you can still release. The behemoth holds up the bucket and you open the floodgates");
				outputText(", your urine mingling with the behemoth's.");
				awardAchievement("Urine Trouble", kACHIEVEMENTS.GENERAL_URINE_TROUBLE, true, true, false);
				outputText("\n\nUnfortunately, by the time you finish peeing, there isn't pretty much anything else to do. \"<i>I'm sorry but I'm not really interested in centaurs. I don't really hate centaurs; I just find it a bit awkward. But you're always welcome to come back,</i>\" the behemoth says.");
			}
			else {
				outputText("\n\nYou join him in filling the bucket with warm yellow liquid. You " + player.clothedOrNakedLower((player.armor == armors.LTHCARM && player.lowerGarment.name == "nothing") ? "take advantage of the opening in your lethicite armor, " : "open up your [armor], "));
				if (player.hasCock()) { //Cock has priority over vagina.
					outputText("aim your " + player.cockDescript(player.biggestCockIndex()) + " into the bucket and let out a pressure as your urine mingles with the behemoth's.");
				}
				else if (player.hasVagina() && !player.hasCock()) { //Vagina but no cock.
					outputText("move over the bucket and let out the pressure as your urine mingles with the behemoth's.");
				}
				else { //Genderless can still urinate.
					outputText("move over the bucket and let out the pressure despite your genderlessness as your urine mingles with the behemoth's.");
				}
				awardAchievement("Urine Trouble", kACHIEVEMENTS.GENERAL_URINE_TROUBLE, true, true, false);
				outputText("\n\n\"<i>I love you,</i>\" the behemoth says with a smile. You smile back at him and you eventually finish peeing. The behemoth is still peeing and the bucket is more than halfway full with mixed urine.");
				outputText("\n\n\"<i>Don't go yet!</i>\" he chuckles. You watch as the bucket is being filled nearly to the brim with urine. Fortunately, the urine stream does get thinner and stops as the behemoth finishes peeing. He sets the urine-filled bucket down, walks over to you and gives your [chest] a good caress.");
				outputText("\n\nThe behemoth gives you a lingering kiss on your " + (timesSexed() >= 5 ? "lips": "cheeks") + " before you make your way back to camp.");
			}
			if (kGAMECLASS.inCombat) combat.cleanupAfterCombat();
			else doNext(camp.returnToCampUseOneHour);
		}
		
		private function watersportsShower():void {
			clearOutput();
			outputText("PLACEHOLDER");
			if (kGAMECLASS.inCombat) combat.cleanupAfterCombat();
			else doNext(camp.returnToCampUseOneHour);
		}
		
	}

}