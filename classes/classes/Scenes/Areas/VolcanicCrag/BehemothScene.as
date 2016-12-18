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
				outputText("As you stop to take a breath, the barren landscape relentlessly hot and devoid of decent shelter, you notice you're not alone. A massive horned creature is on patrol, and you stiffen as his pointy ears prickle, listening.\n\n");
				outputText("Mareth has made you paranoid, but you've survived this far.\n\n");
				outputText("\"<em>Howdy, stranger!</em>\" the monster calls, and you get up to greet him.  \"<em>Don't see too many people around here,</em>\" he admits, and you can't exactly say you're surprised.  \"<em>Landscape like this, ain't that many people who want to be friendly, eh?</em>\"\n\n");
				outputText("Somehow you suspect that's not precisely it, but he likely knows that already.  You try not to stare at his hulking muscles or the spines along his back, both only barely obscured by his purple fur, and you introduce yourself, wanting to match his friendliness.\n\n");
				outputText("As expected, he's delighted, and he claps you on the back like you're already best friends. \"<em>" + player.short + ", eh?  They call me the Behemoth; least, they did last time I had people to talk to!  What brings you out here?</em>\"\n\n");
				outputText("Whatever the answer, it probably isn't the giant cock pressing up against his red loincloth.  Right?");
			}
			else {
				outputText("As you're exploring the swelting landscape, you spot the familiar face going about his day.  \"<i>Hello again, " + player.short + ",</i>\" he says as he strides up, his deep chest leaving his voice a pleasant rumble.  \"<em>Looking for a spar?  Or ... something else?</em>\" His mouth twitches into what might be a smile, and he flexes his arm, emphasizing both his claws and loincloth.  Looks like he's looking for a good time, no matter what it is.");
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
			if (timesSexed() >= 2) addButton(3, "His Cum", talkAboutHisCum, null, null, null, "Talk to the behemoth about the special properties of his cum."); 
			else addButtonDisabled(3, "His Cum", "Have sex with the behemoth at least twice to unlock this.");
			if (flags[kFLAGS.BEHEMOTH_CHILDREN] > 0) addButton(4, "Children", talkAboutHisChildren, null, null, null, "Talk to the behemoth about his son" + (flags[kFLAGS.BEHEMOTH_CHILDREN] == 1 ? "" : "s") + ".");
			else addButtonDisabled(4, "???", "Have at least 1 child with him to unlock this.");
			addButton(14, "Back", behemothMenu);
		}
		
		private function talkAboutYourself():void {
			clearOutput();
			outputText("You tell the behemoth about your origins and hometown, and the yearly tradition that led you to be sent through the portal as the champion of Ingnam.  He listens attentively, something complicated in his face, and you wonder how long it's been since he's heard someone speak this much.");
			outputText("\n\n\"<i>Ingnam sounds nice,</i>\" he says eventually, a bit wistful.  \"<i>I came from a portal from another world, too.</i>\"  He doesn't elaborate, however, leaving you to tell him about your travels.");
			if (flags[kFLAGS.FACTORY_SHUTDOWN] > 0) {
				outputText("\n\nHe's intrigued as you tell him about Marae's quest for you to shut down the factory, too. ");
				if (flags[kFLAGS.FACTORY_SHUTDOWN] == 1) {
					outputText("\"<i>Wow, you're quite the hero! Well done: we'll need her help if we're to get out of this.</i>\" he says, his tail swishing with pride.");
				}
				else if (flags[kFLAGS.FACTORY_SHUTDOWN] == 2) {
					outputText("\"<i>Sounds like you just made it worse,</i>\" he says frankly, his brow creasing in worry. \"<i>Do you think it'll be okay?</i>\"");
				}
			}
			if (flags[kFLAGS.DEFEATED_ZETAZ] > 0) {
				outputText("\n\nYou tell the behemoth about how you've managed to take revenge upon Zetaz, the imp who raped you when you first came through the portal. ");
				outputText("\n\n\"<i>Not bad!</i>\" he says, clapping you on the back. \"<i>I knew this guy once -- wouldn't leave me alone no matter what I did, and I was a lot younger then, you know?  Years later, I got to find him again and tear him apart with these,</i>\" he boasts, wiggling his claws, and you stare at him in disbelief.  \"<i>Yep. Don't think anybody could even find all the pieces afterward, though don't ask me what I did with them.</i>\"");
			}
			if (flags[kFLAGS.CORRUPTED_MARAE_KILLED] > 0) {
				outputText("\n\nNext, you go back to the story of the factory and tell the behemoth about the clean-up: slaying the corrupted goddess Marae.  He thinks you're joking at first, but you assure him it's true and he whistles. \"<i>You actually KILLED a goddess? Wow, you're even stronger than I am!</i>\" From him, that's quite the admission.");
			}
			if (flags[kFLAGS.LETHICE_DEFEATED] > 0) {
				outputText("\n\nYou do a lot of embellishing as you tell him about taking down the demons in Lethice's stronghold, though the story barely needs it. ");
				outputText("\n\n\"<i>Holy shit,</i>\" he says, and he offers a hand for a high five. You return it, and both of you beam with pride as you settle back down. \"<i>Guess you did what you came here for,</i>\" he adds, and he's a bit wistful. ");
				if (player.armor == armors.LTHCARM) {
					outputText("It doesn't stop him from admiring your lethicite armor, though. \"<i>Wow, Lethice actually managed to harvest enough for that?  Pretty clever, though I notice it doesn't cover your groin.</i>\"");
					if (player.lowerGarment.name == "nothing") outputText("\n\nHe blushes when he looks " + (player.hasCock() ? "at your [cock] hanging freely " : "") + "through the opening, and you're tempted to tease him.");
				}
			}
			outputText("\n\nAfter chatting for a good while, you and the behemoth part ways and you return to your camp.");
			doNext(camp.returnToCampUseOneHour);
		}
		private function talkAboutBehemoth():void {
			clearOutput();
			outputText("You ask the behemoth about himself. What is he, exactly?");
			outputText("\n\n\"<i>Nobody calls me by my old name; just call me the Behemoth and that's good enough, eh?  We're a proud race known for our strength, and we love to prove it, too, but there ain't too much of us around anymore. Here, let me show you something,</i>\" the behemoth says, and he pulls out some books.");
			if (flags[kFLAGS.CODEX_ENTRY_BEHEMOTH] <= 0) {
				flags[kFLAGS.CODEX_ENTRY_BEHEMOTH] = 1;
				outputText("\n\n<b>New codex entry unlocked: Behemoths!</b>");
			}
			outputText("\n\n\"<i>Check through those; they ought to answer everything you're looking for,</i>\" he says, and you thank him.");
			outputText("\n\n\"<i>Thank <b>you,</b></i>\" he corrects, and he laughs as he pushes his hair and mane back.  You try asking him what's wrong, but he shakes his head.  \"<i>I don't want to talk about it right now,</i>\" he admits. \"<i>My past ain't the greatest; let's just worry about the now for now, okay?</i>\"");
			outputText("You nod, and you wrap your arms around him to give him a hug, before making your farewells and your way back to camp.");
			if (flags[kFLAGS.BEHEMOTH_TALK_LEVEL] <= 1) flags[kFLAGS.BEHEMOTH_TALK_LEVEL]++;
			doNext(camp.returnToCampUseOneHour);
		}
		private function talkAboutSadStory():void {
			clearOutput();
			outputText("You ask the behemoth if he's willing to tell you more about himself.");
			outputText("\n\n\He takes a deep breath and nods agreement, though he itches his ear like he's shy. \"<i>Make yourself at home and then we'll talk, all right?</i>\" he says, leading the way to his tent.  He holds the flap open for you to enter, and no matter the size of it, it's a little cramped with the two of you in it as he takes a seat and gestures to the other chair.\n\n");
			if (player.isBiped() || player.isGoo()) outputText("You turn it to face the behemoth and then sit down, intrigued.");
			else outputText("You move it out of the way and find a comfortable position for you to listen to him on the floor rug.");
			//Early life
			outputText("\n\nThe behemoth clears his throat, uncertain how to begin, and you suspect he hasn't shared this too often.  \"<i>I don't have many complaints about my childhood,</i>\" he admits, his claws in his mane as he thinks.  \"<em>When I was a year old -- that's adolescence for us; we're adults around our second birthday -- I saw my father participate in the Feats of Strength.  It's a three-day competition and whoever does the best is declared tribe leader, and of course that was my father.  He was the biggest and strongest of all of us and I was so proud.</i>\"\n\n");
			outputText("But of course that's not the end of it, and you wait patiently for him to continue.\n\n");
			outputText("\"<i>It was good for a long while,</i>\" he says, \"<i>but when my second birthday rolled around, my father told me I was the one to be sent through the portal.  I argued with him, of course, but he's the tribe leader: what was I supposed to do?  If you get told you gotta go or your whole world will be doomed, you do it, no matter that I think it's bullshit.  He gave me two hundred gems to support myself with and then tossed me through and that was it: no matter how I tried, the portal wouldn't let me go back and I was stuck here.</i>\"");
			outputText("\n\nThat story sounds familiar, you comment, and he grins toothily.  He clearly didn't stay at the portal forever, though, and you ask him what he did after he realized he's stuck.\n\n");
			outputText("\"<i>Took up exploring, naturally,</i>\" he says proudly. \"<i>There's an oni named Izumi in the high mountains, and she claims to be the Font of All Strength.  'course, me being me, I had to test that, and we dueled for ages.  I won eventually, as you could expect, and after we were done fighting, we took up fucking.  Strength like that needs appreciating, you know, especially since she ain't corrupted.  Good clean fun doesn't come around too often, you know?</i>\"");
			//Tel'Adre
			if (player.statusEffectv1(StatusEffects.TelAdre) >= 1) {
				outputText("\n\nThere's a whole city that's still pure, you point out.  Has he ever visited Tel'Adre?");
				outputText("\n\n\"<i>Of course!  It's pretty great, and that fox Urta who hangs out at the Wet Bitch is hot as hell.  No clue what that name's about, though: the one bar that's not corrupted ought to show it somehow, but there's no accounting for taste, eh?</em>\"  He laughs, but he doesn't really mind.  \"<em>And then there's the bakery -- try the brownies if you haven't; they're great -- and there ain't many places better to hang out than that gym of theirs.  Yeah, you can definitely say I've been there before.</i>\"");
			}
			//Behemoth the Imp Slayer!
			outputText("\n\n\"<i>What really gets me, though, is how when I'm walking about, all the imps run away from me except for this one fucker.  I let him come up to me, 'cause I'm a nice guy like that, but he got that sly look on his face and tried to force himself on me and big mistake.  For him, I mean.  I clocked him right in the jaw and he flies back, but he didn't have the sense to cut and run and tried AGAIN.</i>\"\n\n");
			outputText("Yeah, you've met imps like that, and you nod along.  \"<i>I try to be nice, but that just ticked me off, so I picked him up and tore him to shreds.  Kept the skull, though,</i>\" he adds, picking up an imp skull to show it to you, and that's definitely an imp skull, all right.  \"<i>Scares the shit out of the rest of them when I show it off and laugh.  Wanna see?</i>\"\n\n");
			outputText("Nah, you'll trust him on that, you assure him, but the behemoth looks disappointed, so you relent.  He stands up and poses with the skull in his hand as he shows off his muscles, then lets out this menacing bestial cackle.  Yep, you can definitely see why the imps don't mess with him anymore.  ... At least not the smarter ones.\n\n");
			outputText("You ask him if he has anything else he wants to share, and he starts to shake his head, before slicking his hair back and nodding, resolute.\n\n");
			//Sad story.
			outputText("\"<i>This ain't a happy story,</i>\" he warns you, but you're interested in hearing anyway and he continues. \"<i>Even though I gave up on heading back home after a few weeks, I still kept checking the portal time and again, you know?  Habit, I guess.  For ages it was locked, but one day ... one day I try and get back through, but there's nothing there.  Nothing living, anyway: just destruction and the burnt-out remains of where my village used to be, and a lot of corpses.  Most of who I can't identify by this time, mind, us growing up pretty quick and it being a while since I was there.  I gave everybody proper burials, and I think I know which one was my old pa, and then I did the only thing I could do: pack up all the stuff I could salvage, move back to Mareth, and lock away the portal.</i>\"\n\n");
			outputText("You let him finish, and you know he's not the only one this could happen to.  You're a champion, too, after all.\n\nYou move up close to him and then pull him into a hug, his fur and body noticably warmer than your own, and even with the tent being too warm for two people, he needs this.  \"<i>Thanks for listening,</i>\" he says eventually, and you shrug.  Anytime, you assure him, and you ask him if there's anything else he wants to share.\n\n");
			outputText("\"<i>I'm kinda lonely,</i>\" he admits, and he gives you a considering look before shaking his head and dismissing the thought.  \"<i>You ever meet anybody pure who wants to help me start a whole family of behemoths, you let me know, okay?</i>\"\n\nYou assure him you will, and the both of you make your farewells before you return to your own camp.");
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
				outputText("\n\n\"<i>Heh, guess I won,</i>\" he says. \"<i>I'll take care of you until you recover, but in exchange ....</i>\"\n\n He rifles through your pouch, taking " + gemsLost + " gems before picking you up.  You black out ....");
				HPChange(player.maxHP() / 2, false);
				player.changeFatigue(-50);
				return;
			}
			if (player.HP <= 0) outputText("You collapse from your injuries.");
			else outputText("You collapse from your overwhelming desires.");
			outputText("\n\n\"<i>Heh, I won,</i>\" he says, grinning. \"<i>I'll give back some of your money if you beat me next time, but either way, I'm gonna fuck your ass.  I'll be gentle, I promise.</i>\"\n\n He rifles through your pouch, taking " + gemsLost + " gems.");
			doNext(analCatchBehemoth);
		}
		
		public function giveBirthToBehemoth():void {
			clearOutput();
			outputText("These cramps are nearly unbearable, and you hurry off to the volcanic crag to find the father of your unborn child! He spots you almost immediately, jittering with excitement. \"<i>What, already?</i>\" he quips, but you're too preoccupied to find much humor in it and he helps you to his tent, his tail up and swishing like a cat's.\n\n")
			outputText("He's expanded it in preparation, and he deftly lays out a leather blanket for you on his bed before helping you " + player.clothedOrNaked(" out of your [armor] and ") + "onto the bed. Gods, to get this weight out of you!\n\n")
			outputText("Labor takes agonisingly long, but he's with you the whole time and you're proud to be helping him bring back his race. He massages your [legs] when they get stiff from having to hold you in the right position, and you're tempted to ask for another dose of his energising cum, no matter that it's what got you into this mess. To hell with it: you ask him to fap onto you, and whether or not it works, it's a beautiful distraction, and soon you're schlicking yourself in the hopes an orgasm will get this baby out of you faster.\n\n");
			if (player.findPerk(PerkLib.BroodMother) > 0) {
				outputText("You've had many children during your time in Mareth, and you're still grateful for each father decent enough to stay with you and help.  It's nearly novel to be covered in cum during this because you <i>want</i> to be, not because some imp took advantage of you, and you curl up afterwards against his soft fur, his muscles comforting to push up against.\n\n") }
			outputText("Eventually, you make one final push larger than the rest and a small furry creature pops out of your womb and cunt, thankfully currently devoid of spines. \"<i>Wow,</i>\" the behemoth says, wiping off your new offspring before setting him to your breasts, his infant claws too soft to hurt as he kneads you. \"<i>I love you,</i>\" he says, still mindblown, and you smile at him as he watches you both in utter amazement. ");
			player.cuntChange(48, true);
			player.orgasmVaginal();
			flags[kFLAGS.BEHEMOTH_CHILDREN]++;
			if (flags[kFLAGS.BEHEMOTH_CHILDREN] == 1) {
				outputText("\"<i>I can't believe I finally have a family.  Thank you so much.,</i>\"");
				flags[kFLAGS.BEHEMOTH_CHILD_1_BIRTH_DAY] = model.time.days;
			}
			else if (flags[kFLAGS.BEHEMOTH_CHILDREN] == 2) {
				outputText("\"<i>Two kids! Thank you for making sure my son wouldn't be lonely.</i>\"");
				flags[kFLAGS.BEHEMOTH_CHILD_2_BIRTH_DAY] = model.time.days;
			}
			else if (flags[kFLAGS.BEHEMOTH_CHILDREN] == 3) {
				outputText("\n\n\"<i>Three kids is a good number,</i>\" he says drowsily, and he gives you a kiss as you all rest for a while together.");
				flags[kFLAGS.BEHEMOTH_CHILD_3_BIRTH_DAY] = model.time.days;
			}
			outputText("\n\nEventually, you know you should return to your camp. \"<i>I'll take good care of him, I promise,</i>\" he says as you make your goodbyes, and you walk back to your camp with a goofy smile on your face.");
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
			player.orgasmDick();
			flags[kFLAGS.BEHEMOTH_ANAL_PITCH]++;
			if (kGAMECLASS.inCombat) combat.cleanupAfterCombat();
			else doNext(camp.returnToCampUseOneHour);
		}
		
		private function analCatchBehemoth():void {
			var isVirgin:Boolean = (player.looseness(false) == 0);
			clearOutput();
			outputText(images.showImage("behemoth-anal-catch"), false);
			if (player.HP <= 0 || player.lust >= player.maxLust()) {
				outputText("The behemoth looks you over with a friendly leer as your face heats.  \"<i>Turn around,</i>\" he says, and you scramble to obey, too tired to do otherwise. \"<i>That's a nice ass," + player.mf("dude", "lady") + ", but I'd like to see more of it, yeah?</i>\"\n\n");
			}
			else {
				outputText("You definitely want that " + (silly() ? "dig bick": "big dick") + " in your [ass] and you tell him such.  \"Not in the tent,\" he says with amusement, and he leads you outside.  \n\n");
			}
			outputText("" + player.clothedOrNaked("You strip hurriedly, tossing your [armor] into a quick pile, because with claws and strength like that, you don't know how much care he'd take, then glance to make sure your belongings look safe.  ") + "The hot air's pleasant on your body, and your skin prickles as you present your [butt] to the behemoth, turning your head to watch him.  \"<i>Nice ass,</i>\" he says after a whistle, then twists his loincloth to free his massive prick.  \"<i>I'll be gentle, I promise.</i>\"\n\n");
			outputText("You swallow in trepidation, but he's been good to you so far, and you ");
			if (player.isBiped()) outputText("bend down on all fours");
			else if (player.isTaur()) outputText("rest your front legs down");
			else if (player.isNaga()) outputText("twist your tail to show off your cloaca");
			else if (player.isGoo()) outputText("shift your malleable body");
			outputText(" as you wait for him to do what he wants.  You watch him walk up to you, his feline paws silent on the rocks, and you shiver as his firm hands caress your [butt] gently, his claws only the slightest pressure as your breath hitches.\n\n");
			outputText("He doesn't do more than that, though.  Not yet.  He simply releases your ass then prowls around in front of you, your [eyes] on his cock the whole time, and you don't dare move though your [skin] prickles.  \"<i>I need some lube,</i>\" he says gently, trawling a claw under your jaw, and you open your mouth obediently as he slides his length in, the warmth so much more present than the heat of the crag.\n\n");
			outputText("You suck on it, hoping your saliva will be enough to take his monster cock, but you're only just getting started when he pulls out, precum beading on the humanoid tip.  \"<i>That'll do,</i>\" he says, though you doubt it, and he moves behind you ");
			if (player.isBiped()) outputText("lifting your legs and taking most of your weight onto his arms.");
			else if (player.isTaur()) outputText("lifting your rear legs and raising your ass for easier access.");
			else if (player.isNaga()) outputText("lifting your whole body as you wind your tail around him.");
			else if (player.isGoo()) outputText("to pull your gooey ass to the right level.");
			outputText("\n\nYour jaw clenches, nervous despite his strength, and he eases the tip of his cock into your backdoor as gravity pushes you onto him, his length slowly sliding into your [ass].\n\n");
			player.buttChange(45, true, true, true);
			if (isVirgin) outputText("\"<i>You're tight enough for me to be your first,</i>\" he observes, and you shoot him a glare. \"<i>What, really?  What luck!</i>\"  You wonder if he means for him or you, but it's just as true either way.  ");
			if (player.looseness(false) < 3) outputText("You're tight enough you only move a little at a time, ");
			else outputText("You've done this enough times for your ass to welcome him with ease, ");
			outputText("but you're still surprised when you feel his ballsack touch you that he fit in that well painlessly, no matter his size.  He lifts you back up a little faster, leaving only the head in your ass, and you whine from the lack of pressure, eager to be filled and your energy already restoring.  Your [ass] clamps down to keep him from escaping, though the bit of you that can still think doubts he'd want to, and he pushes back in, ");
			if (player.hasCock()) outputText("your " + (player.cocks.length == 1 ? "cock": "cocks") + " springing to full erectness");
			if (player.hasCock() && player.hasVagina()) outputText(" and ");
			if (player.hasVagina()) outputText("femspunk leaking from your " + player.vaginaDescript()); 
			outputText(".\n\n\"<i>You good so far?</i>\" he asks, and you groan for more as you touch yourself and try to grind down on him, most of your weight already under his control.  He laughs, but he does go faster, his hands squeezing your waist as his claws edge just shy of causing pain and you moan, his obscene length sliding easily through your ass as he thrusts faster, pulling you onto his cock as much as he's pushing into you, and you think you might black out a little.\n\n");
			if (flags[kFLAGS.BEHEMOTH_ANAL_CATCH] <= 0) outputText("\"<i>Don't let my balls deceive you,</i>\" he says, voice rough with sex, and it's hard to listen to him with how thoroughly he's pounding you.  You can feel their size banging against your ass, and they're definitely large, but ....  \"<i>Behemoths like me, we make a LOT of cum, more than minotaurs or that fox-herm, and I'm gonna give you all of it.</i>\"\n\n");
			outputText("You feel like you've been his cock sleeve your whole existence and wish it could last forever, but he holds your ass up for a moment and pauses.  \"<i>Bottom's up!</i>\" he announces, and he slams you back down onto his cock as he presses into you and holds it, his cock twitching as it starts spurting and doesn't stop, the amount surging into a cum fountain right into your bowels, filling you up beyond what you think you could take as your belly swells. By the gods, how much can there BE?!\n\n");
			player.refillHunger(70, false);
			outputText("His orgasm gives you energy, and you cum as well, feeling rejuvenated as ");
			if (player.hasCock()) {
				outputText("your " + (player.cocks.length == 1 ? "cock": "cocks") + "shoot ");
				if (player.cumQ() < 50) outputText("small ropes of jism all over the ground and yourself.");
				else if (player.cumQ() >= 50 && player.cumQ() < 250) outputText("ropes of jism all over the ground and yourself.");
				else if (player.cumQ() >= 250 && player.cumQ() < 500) outputText("jets of cum all over the ground and yourself, puddling on your belly.");
				else if (player.cumQ() >= 500 && player.cumQ() < 2500) outputText("torrents of cum all over the ground and yourself, puddling on the rocky ground.");
				else outputText("waves after waves of your seed that never seem to end as you're left completely soaked and your cum pools on the rocks, dribbling down enough everyone will know you had a good time.");
			}
			if (player.hasCock() && player.hasVagina()) outputText("  As you watch the show, ");
			if (player.hasVagina()) {
				if (player.averageVaginalWetness() < 4) outputText("femspunk seeps down your [legs]");
				else outputText("femspunk spurts out of your cunt and splashes onto the ground");
				outputText(" as your " + player.vaginaDescript() + " clenches relentlessly on your fingers, hard enough to bruise.");  
			}
			if (player.gender == 0) outputText("your whole body shakes in overwhelming pleasure.");
			outputText("  You'd collapse if you were under your own power, but the behemoth carefully lifts you off his cock and spooge floods out of your [ass], coating his legs and the hard ground.  He waits for the dripping to slow before setting you down gently and lying next to you, the two of you sharing the wet spot.  \"<i>I love having someone to fuck,</i>\" he says warmly, his arm over you in claim as you feel his muscles spasm in aftershocks and you rest for a while, sure nothing would pick a fight with him.\n\n");
			outputText("You wake up some time later and kiss his cheek before letting him know you'll be going.  \"<i>See you later,</i>\" he says as he lets you up, though he doesn't bother getting up. The main thing you remember as " + player.clothedOrNaked("he watches you redress and ") + "you walk back to your camp is his expression of utter contentment, and your mood carries on for the rest of the day.");
			player.orgasmAnal();
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
			player.orgasmVaginal();
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
