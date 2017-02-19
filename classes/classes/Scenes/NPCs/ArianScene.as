package classes.Scenes.NPCs{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.GlobalFlags.kACHIEVEMENTS;

// ARIAN_FOLLOWER:int = 933;
// ARIAN_PARK:int = 934; //-1 = disabled, 1 = helped.
// ARIAN_HEALTH:int = 935; //Higher is better.
// ARIAN_ANAL_XP:int = 936;

// ARIAN_CAPACITY:int = 937;
// ARIAN_COCK_SIZE:int = 938;
// ARIAN_DOUBLE_COCK:int = 939;
// ARIAN_VAGINA:int = 940;
// ARIAN_BREASTS:int = 941;
// ARIAN_VIRGIN:int = 942;

// ARIAN_S_DIALOGUE:int = 943;
// ARIAN_HERM_CHAT:int = 944;
// ARIAN_ASS_CHAT:int = 945;
// ARIAN_LESSONS:int = 946;
// ARIAN_DOUBLE_PENETRATION_CHAT:int = 947;
// ARIAN_FIRST_REPTILUM:int = 948;
// ARIAN_TREATMENT:int = 949;
// ARIAN_EGG_CHAT:int = 952;
// ARIAN_EGG_EVENT:int = 953;
// ARIAN_EGG_COLOR:int = 954;
// ARIAN_EGG_COUNTER:int = 955;

// ARIAN_HAS_BLOWN:int = 950;
// ARIAN_MORNING:int = 951;
// TIMES_ARIAN_DILDOED:int = 983;

/*Design Notes
Arian has a \"<i>health</i>\" stat that goes from 0 to 100. Where 0 equals very sick and 100 equals healthy. This also works as a sort of affection meter.
Interacting with the PC will improve Arian's health; be it talking, giving items or sex.

Talking improves Arian's health by 1. Sex improves it by 2 and giving him Vitality T. improves it by 4.

At 100 health Arian insists on joining the PC's camp as a follower, you can deny him that and invite him later when you feel like it.

Talking to Arian can improve the PC's intelligence (Up to 100) and teaches white spells at 35, 50 and 75 intelligence. Arian must also be at health level 30 or greater in order to teach spells.

Boon and Laika cannot be interacted with directly, at least for now.

AnalXP increases with buttsecks and reduces with reducto. Necessary to measure how much Arian loves it up the ass.

Flags and variables:
ArianHealth: Arian's current \"<i>health</i>\", the bigger the better!
ArianAnalXP: How experient Arian is with anal sex (on the receiving end only!). Depending on how experient he is, you might get scene variations. (Anal Capacity is always 50!)
ArianVirgin: If you had sex with Arian at any point and talked about it. 0 = virgin, 1 = not a virgin.
ArianCockSize: What is Arian's current cock(s) size. He only has 4 sizes, starting at 1 and up to 3. 0 = no cock(s), 1 = 6</i>\" long, 1.5</i>\" thick cock(s), 2 = 8</i>\" long, 2</i>\" thick cock(s), 3 = 12</i>\" long, 3</i>\" thick cock(s).
ArianGirlHermChat: If you had Boon and Laika speak to you after modifying Arian's gender. 0 = didn't modify Arian's gender, 1 = Modified Arian's Gender, 2 = already spoke with Boon and Laika.
ArianDblCock: Flag to verify if Arian has 2 cocks or not. 0 = 1 cock, 1 = 2 cocks. Second cock is always the same size as the first one.
ArianVagina: Flag to verify if Arian has a vagina, starts at 0. 0 = no vag, 1 = has a vag. (Capacity of 50!)
ArianBreasts: Arian's breast size, 4 sizes. 0 = flat, 1 = B-cup, 2 = D-cup, 3 = DD-cup. (Nipples match breast size.)
ArianSDialogue: Controls which Special Dialogues PC has already gone through, they're supposed to only happen once. Numerical value starting at 0, up to 6 (disabled).
ArianFollower: If Arian is a follower or not. 0 = not a follower, 1 = is a follower.
ArianMLesson: How many times Arian has taught the PC that day. Resets every day. 0 up to 4.
ArianHasBlown: Boolean to see if player has gone through Get Blown once already. 0 = false, 1 = true.
ArianAssChat: Boolean to see if player has already fucked arian at >66 AnalXP.  0 = false, 1 = true.
ArianTreatment: Checks if PC has already treated corruption with Arian that day, resets everyday. 0 = false, 1 = true.
ArianFirstRept: If PC gave Arian some Reptilum already. 0 = false, 1 = true.
ArianDblPenChat: If PC had the chat after Double Pen already. 0 = false, 1 = true.
ArianEggEvent: Flag to verify the state of the Egg Event. Set it to 1 every 30 days. 0 = inactive, 1 = active, can pick color now. 2-7 = Color has been picked, number indicates which color. 8 = Fertilized Eggs, for reference in case of an expansion.
ArianEggChat: If PC has already talked to Arian about her egglaying. 0 = false, 1 = true.
ArianPark: Originally set to 0, it will be set to 1 if the PC chooses to help him in the first meeting. otherwise set to -1 and disable him.  Increases each subsequent visit in order to determine when their relationship should evolve.  Max = 3.

Note: Will need something to verify which pronoun to use, he or she. You'll probably want to use a function for that Fen.

Health Thresholds:
0 health: You may only Talk.
10 health: You may start giving him Vitality Tincture.
20 health: You may give him TF items & sex him if you want.
30 health: Arian will start teaching the PC spells, will start preparing something special for the PC.
50 health: Arian completes the Talisman and gives it to PC, unlocks Imbue Talisman option.
75 health: Arian is healthy enough to start giving the PC magical therapy to reduce Corruption. (Limit of one per day.)
100 health: Arian joins as a follower. Can imbue the talisman with more spells.

AnalXP Thresholds:
0: Anal Virgin. Same as <33, except there is a virgin blurb.
< 33: Tight, sensitive enough to orgasm. (It hurts... but feels good)
< 66: Loose, sensitive enough to make Arian scream in pleasure. (It's like a tight vagina, feels like one too, minor pain)
<= 100: Very Loose, sensitive enough to make Arian cum just from insertion. (Feels better than anything else. Yep, Arian really becomes a buttslut at this point)
Planned expansions:
Naga TF
Corruption Path (Arian's body is drastically altered, but [Arian eir] personality only suffers minor alterations.)
(Unlikely) Boon and Laika
*/
	public class ArianScene extends NPCAwareContent implements TimeAwareInterface
	{
		public function ArianScene()
		{
			CoC.timeAwareClassAdd(this);
		}

		//Implementation of TimeAwareInterface
		public function timeChange():Boolean
		{
			if (flags[kFLAGS.ARIAN_EGG_COUNTER] > 0) flags[kFLAGS.ARIAN_EGG_COUNTER]++;
			if (model.time.hours > 23) {
				if (arianScene.arianFollower() && flags[kFLAGS.ARIAN_VAGINA] > 0) flags[kFLAGS.ARIAN_EGG_EVENT]++;
				flags[kFLAGS.ARIAN_LESSONS] = 0;
				flags[kFLAGS.ARIAN_TREATMENT] = 0;
			}
			return false;
		}
	
		public function timeChangeLarge():Boolean {
			return false;
		}
		//End of Interface Implementation

private function arianCockSize():Number {
	if (flags[kFLAGS.ARIAN_COCK_SIZE] < 0 || flags[kFLAGS.ARIAN_COCK_SIZE] > 3) return 0;
	else if (flags[kFLAGS.ARIAN_COCK_SIZE] == 1) return 9;
	else if (flags[kFLAGS.ARIAN_COCK_SIZE] == 2) return 16;
	else return 36;
}

override public function arianFollower():Boolean {
	return flags[kFLAGS.ARIAN_FOLLOWER] > 0;
}
public function arianMF(boy:String,girl:String):String {
	if (flags[kFLAGS.ARIAN_COCK_SIZE] > 0) {
		if (flags[kFLAGS.ARIAN_VAGINA] > 0) {
			if (flags[kFLAGS.ARIAN_BREASTS] == 0) return boy;
			else return girl;
		}
		else if (flags[kFLAGS.ARIAN_BREASTS] >= 2) return girl;
		else return boy;
	}
	return girl;
}
public function arianHealth(arg:Number = 0):Number {
	if (arg != 0) {
		flags[kFLAGS.ARIAN_HEALTH] += arg;
		if (flags[kFLAGS.ARIAN_HEALTH] > 100) flags[kFLAGS.ARIAN_HEALTH] = 100;
		else if (flags[kFLAGS.ARIAN_HEALTH] < 0) flags[kFLAGS.ARIAN_HEALTH] = 0;
	}
	return flags[kFLAGS.ARIAN_HEALTH];
}
public function arianChestAdjective():String {
	var buffer:String = "";
	var temp:int = rand(10);
	if (flags[kFLAGS.ARIAN_BREASTS] == 0) return "";
	else if (flags[kFLAGS.ARIAN_BREASTS] == 1) {
		if (temp <= 4) buffer += "small";
		else if (temp <= 6) buffer += "petite";
		else if (temp <= 8) buffer += "perky";
		else buffer += "palm-filling";
	}
	else if (flags[kFLAGS.ARIAN_BREASTS] == 2) {
		if (temp <= 3) buffer += "generous";
		else if (temp <= 5) buffer += "hand-filling";
		else if (temp <= 7) buffer += "bouncy";
		else buffer += "shapely";
	}
	else {
		if (temp <= 3) buffer += "large";
		else if (temp <= 5) buffer += "voluptuous";
		else if (temp <= 6) buffer += "jiggly";
		else if (temp <= 7) buffer += "bra-bursting";
		else if (temp <= 8) buffer += "bountiful";
		else buffer += "huge";
	}
	return buffer;
}
public function arianChest():String {
	var buffer:String = "";
	//Men get no cool descriptions!
	if (flags[kFLAGS.ARIAN_BREASTS] == 0) return "chest";
	
	//Tits ahoy!
	if (rand(2) == 0) buffer += arianChestAdjective() + " ";
	
	//Name 'dose titays
	var temp:int = rand(10);
	if (temp <= 2) buffer += "tits";
	else if (temp <= 5) buffer += "breasts";
	else if (temp <= 7) buffer += "pillows";
	else buffer += "boobs";
	return buffer;
}


//Initial Meeting
//Happens randomly while visiting Tel'Adre. If player doesn't choose to help, Arian is removed from the game.
//If you don't help, Arian is removed from the game.
public function meetArian():void {
	clearOutput();
	outputText("As you wander Tel'Adre's streets, you pass by one of the many dark alleys that litter the half-empty city; you hear the sound of hacking, rasping coughs.  Following your ears, you see a hooded figure wrapped in a form-concealing cloak slumped against the wall, bent over and coughing loudly, wheezing for breath.  They really don't sound very well at all... on the other hand, it could be a setup for muggers or something.  Maybe you shouldn't try playing the good samaritan here...");
	//[Help] [Don't Help]
	
	menu();
	addButton(0,"Help",helpArianWhenYouMeetHim);
	addButton(1,"Don't Help",dontHelpArianWhenYouMeetHim);
	addButton(2,"Never Help",dontHelpArianWhenYouMeetHim,true);
}

//[=Don't Help=]
private function dontHelpArianWhenYouMeetHim(never:Boolean = false):void {
	clearOutput();
	outputText("Not liking the risks it presents - after all, they could be a mugger, or have something nasty and highly contagious - you keep on walking.  You've not gone too far before a pair of figures, elegantly dressed ferret-morphs, nearly slam into you, running quickly.  You shout at them to watch where they're going, but they ignore you, instead heading straight for the alleyway you just passed.  You watch as they grab the hooded figure and pull them to their feet.  The ferrets start chattering at their target; though you can't make out precisely what they're saying, it sounds like a scolding, even as they take a bottle from a pouch they're carrying and make the hooded figure drink it.  The cloaked man's coughs start to subside, and they promptly take an arm each and half-lead, half-carry him away.  You wonder what that was all about, but decide it doesn't matter and press on.");
	//Disable the bitch if appropriate.
	if (never) {
		flags[kFLAGS.ARIAN_PARK] = -1;
	}
	else {
		flags[kFLAGS.NOT_HELPED_ARIAN_TODAY] = 1;
	}
	//Player enters Tel'Adre main screen
	menu();
	addButton(0,"Next",telAdre.telAdreMenu);
}

//[=Help=]
private function helpArianWhenYouMeetHim():void {
	clearOutput();

	flags[kFLAGS.ARIAN_PARK] = 1;
	flags[kFLAGS.ARIAN_COCK_SIZE] = 1;
	flags[kFLAGS.ARIAN_CAPACITY] = 50;
	
	outputText("You approach the hooded figure with caution, asking if they're all right; it feels a little silly to say that, but you can't think of much else to say.");
	
	outputText("\n\n\"<i>Just... help me up,</i>\" a masculine voice asks, between coughs.");
	
	outputText("\n\nYou lean down and offer the stranger your shoulder, letting them place their arm across your neck before you stand upright, helping pull them to their feet.  Once the hooded figure is standing, the hood slides off [Arian eir] head, to reveal a reptilian muzzle that could only belong to some sort of lizard.  His scales are white, almost absurdly so, and he takes deep breaths, trying to calm down his coughing fit.");
	if (flags[kFLAGS.CODEX_ENTRY_LIZANS] <= 0) {
		flags[kFLAGS.CODEX_ENTRY_LIZANS] = 1;
		outputText("\n\n<b>New codex entry unlocked: Lizans!</b>")
	}		
	outputText("\n\nOnce it seems like he's calmed down, he looks at you and you gaze at his auburn slitted eyes.  \"<i>Thank you very much.</i>\"  He politely nods at you.  \"<i>Would you mind helping me one more time though?  I'm trying to avoid some people and I'd really appreciate it if you could help me go to a park nearby.</i>\"");
	
	outputText("\n\nYou ask him if he's in some kind of trouble first.  \"<i>No, of course not.  My aides are just a tad overprotective, that's all,</i>\" he insists, coughing a bit.");

	outputText("\n\nYou consider your options, then decide it can't hurt to take him, conveying your decision to the sickly lizard-man.");
	
	outputText("\n\nIt doesn't take long before you arrive at what looks like a small abandoned park; the grass has grown wild in some patches, while in others it is dry and withered.  The lizan points at a nearby bench and you help him sit.  With a sigh the lizan slumps back and closes his eyes with a smile.");
	
	outputText("\n\n\"<i>Thank you very much for helping me get here.  If I had to stay in bed even for a second longer, I swear I would have gone mad.</i>\"");
	
	outputText("\n\nStay in bed?  You noticed the coughing; has he caught some kind of sickness?");
	
	outputText("\n\n\"<i>Err, not really.  I'm just going through some health problems right now...</i>\" He trails off.  You wonder if maybe it has something to do with the whiteness of his scales - they look so abnormally pale - but leave the matter.  Instead, you ask who he is and why he was in that alley where you found him.");
	
	outputText("\n\nThe lizan gasps and covers his mouth, startled.  \"<i>Oh, forgive me.  How rude, I should have introduced myself before.</i>\"  He clears his throat and starts, \"<i>My name is Arian, and as you can see, I'm a lizan.  I just wanted to go out for a little while, but my aides are intent on keeping me in bed; they say I'm not well enough to be going out... but I say if anyone knows my body, that would be me!  And if I feel like going out, then so the gods help me, I will!</i>\"  He finishes forcefully, before realizing he's rambling.  \"<i>Oh, forgive me... this really isn't your problem, sorry for troubling you,</i>\" he says, letting his head hang.");

	outputText("\n\nYou tell him it's all right.  It sounds like he's been cooped up by his aides for a long time.  \"<i>Yes, sometimes I just feel like getting a bit of fresh air, so I just come to this park.</i>\"  He smiles to himself.  \"<i>I shouldn't keep you though.  Thank you for your help... err?</i>\"  You tell the lizan your name.  \"<i>I will be fine now, so I'll be seeing you.</i>\"  He smiles at you in a friendly way.");
	
	outputText("\n\nYou decide to leave him for the moment, and head back to the camp.");
	//(Park added to TA's Menu.  It will later be replaced by Arian's house.)
	outputText("\n\n(<b>The park has been added to Tel'Adre's menu.</b>)");

	arianHealth(1);
	doNext(camp.returnToCampUseOneHour);
}

//Further Park Visits
//You need to get through the entirety of Arian's park dialogue before you can do anything meaningful with him.
//But you can just spam it if you want, there is no schedule and Arian will magically be at the park whenever you go there.
//Use variable ArianPark to determine the number of visits.
public function visitThePark():void {
	clearOutput();
	outputText(images.showImage("arian-park"));
	outputText("As you enter the ragged remnants of the park, you spot the sickly lizan, Arian, sitting at his usual bench, and greet him.  \"<i>Oh, hello there [name].  Good to see you.</i>\"  He waves lazily.");
	
	//Visit 1
	if (flags[kFLAGS.ARIAN_PARK] == 1) {
		outputText("\n\nFeeling ");
		if (player.cor < 50) outputText("curious");
		else outputText("bored");
		outputText(", you decide to ask him what his story is.");
		
		outputText("\n\nHe gives you an apologetic smile.  \"<i>I guess I should start at the beginning; it's a bit of a long story though, so why don't you take a seat?</i>\"  He motions for you to sit beside him.");
		
		outputText("\n\nYou do as he says.");
		
		outputText("\n\n\"<i>I'm actually a mage; I've been training in the magical arts ever since I was a kid.  If you're wondering about my strange white scales, I have them because I was born with something called albinism, some kind of hereditary disease... I'm not really sure, but that's beside the point.  I spent most of my youth inside, stuck at home, studying the white arts.  People always said I had a way with magic, some even called me a genius.  Some genius, huh?  I can't even walk a few blocks without help.</i>\"  He finishes with a cough, as if for emphasis.");
		
		outputText("\n\nYou ask if he's really a mage - you thought all the mages in Tel'Adre were kept away from the general populace, projecting the spells that keep the city safe from the demons.");
		
		outputText("\n\n\"<i>Oh, yes, I really am a mage.  But I don't belong to the covenant that protects this town... You see, I'm not fit for the job.  And besides that, with my magic... it would kill me....</i>\"");
		
		outputText("\n\nHow is that so?");
		//(PC has at least 1 Black or White Magic spell:)
		if (player.hasSpells()) {
			outputText("  You thought spellcasting merely took fatigue and the proper mindset, not life force, and you express that sentiment to the lizan.");
		}
		
		outputText("\n\n\"<i>Ah...  Now we're getting to why I'm in such a miserable state.  You see I've found a new way to use white magic; one that results in far more powerful spells;  problem is it is very unhealthy for the caster.</i>\"  [Arian Ey] smiles at you weakly.  \"<i>In order to achieve a state of complete concentration, I stop all my bodily functions.  My heart stops beating, I stop breathing, I dedicate all of my being to the spell I wish to cast.  This is very dangerous, but thanks to this I am able to achieve a degree of concentration that no other mage can.</i>\"  He gauges your reaction.  \"<i>So what would you say?  Impressive?  Reckless?  Stupid?</i>\"");
		outputText("\n\nYou admit that's an impressive feat to pull off... but, can't he just cast magic the usual way?  Wouldn't that be better for him, if his technique is so much more draining and physically challenging than the conventional style?");
		
		outputText("\n\n\"<i>Yes, you are correct my friend.  And while I do use my magic in the traditional fashion now, that simply was not an option.</i>\"  He coughs.  \"<i>But that is a story for another time, I think I've held you enough for now.</i>\"  He closes his eyes and leans back.");
		
		outputText("\n\nYou excuse yourself and head back to camp.");
	}
	//Visit 2
	else if (flags[kFLAGS.ARIAN_PARK] == 2) {
		outputText("\n\nAfter you make yourself comfortable, you suggest that he continue his story.  He looks at you in surprise at first, but he smiles shortly afterwards.  \"<i>Very well, where was I?</i>\"  He rubs his chin in thought.  \"<i>Ah, yes.</i>\"");
		
		outputText("\n\nHe clears his throat.  \"<i>I had to use my power to help my friends.  You see, our academy had been overrun by demons and I tried to fight them.  But... of course I was not strong enough to defeat all of them or save everyone.  All I could do was protect my pupils and myself.</i>\"  He coughs, but smiles all the same.");
		
		outputText("\n\nSo, he's not originally from Tel'Adre?  You suggest he should go into details, tell you about his academy.");
		
		outputText("\n\nArian smiles.  \"<i>Very well.  The academy was a place of study, where mages of all kinds gathered.  It was renowned for its extensive library and for being one of the best academies to learn about white magic.  It was pretty far from this city, but since the demons attacked I wouldn't expect it to still be standing.  Things got pretty ugly before my pupils and I made our escape.</i>\"");
		
		outputText("\n\nYou indicate you understand and he should go on.");
		
		outputText("\n\n\"<i>The demons caught us by surprise... they covered the academy in their corrupt black magic, and turned some of the best and most powerful mages into mindless fucktoys.  If I hadn't been to one of the warded practice rooms I would have been taken too.</i>\"  He coughs.  \"<i>There were so many of them... my pupils were in their room, and by the time I fought my way over they were on the verge of being taken by a pair of incubi.  They were affected by the initial wave of black magic, but thankfully my white magic was enough to set them free.</i>\"");
		
		outputText("\n\nYou show that you're still paying attention and he continues.");
		
		outputText("\n\n\"<i>After saving them, I quickly realized that there was no way we could fight the demons off, so we ran as far and as fast as we could.  By the time we made it far enough that I could relax I had already used too much of my magic; and as a result... well... you're looking at it.</i>\"  He coughs for emphasis.");
		
		outputText("\n\nYou tell him that you've heard enough for this time, so it's probably best if he saves his strength and calls it quits there.  \"<i>Very well.  I'll be seeing you then, [name].</i>\"  He waves you off.");
	}
	//Visit 3
	else if (flags[kFLAGS.ARIAN_PARK] == 3) {
		outputText("\n\nYou bring up the last conversation you had with Arian and ask him whatever happened to his apprentices.");
		
		outputText("\n\nHe smiles.  \"<i>You see... my apprentices are actually my aides now.  They swore to live their lives in my service as my aides.</i>\"  So, he's been avoiding his apprentices?");
		
		outputText("\n\n\"<i>They are worried about me all the time.  Maybe too worried... and it's not like I don't appreciate their concern, but sometimes I feel smothered.  Make no mistake, I love them like family, but I like to get out sometimes too.</i>\"  You give a nod in response, figuring it's what he wants to see.");
		outputText("\n\n\"<i>Anyway, there is not much more to my story.  We made our escape and wandered about the desert, until we found Tel'Adre.  They were nice enough to take us in and so here we are.</i>\"  He motions to the area surrounding the two of you.");
		
		outputText("\n\n\"<i>So, [name]?</i>\"  You look at him in response.  \"<i>Can I interest you in a magical demonstration?</i>\"  You answer in the positive.");
		
		outputText("\n\nHe holds his hands apart from each other, palm facing palm.  \"<i>Here's what you can normally do with White Magic.</i>\"  He closes his eyes and focus.  You watch as arcs of electrical energy, like a tiny current of lightning, sparkles and crackles from one hand to the next.  You comment that's quite a sight");
		if (player.cor > 66) outputText(", whilst privately thinking to yourself how useless that looks - no wonder they can't fight the demons if this is the best they're capable of");
		outputText(".");
		
		outputText("\n\n\"<i>Now let me show you what I can do with my technique.</i>\"  He closes his eyes once more and focuses.  His white scales begin glowing as his power increases and you gasp as energy virtually explodes from hand to hand, a cascade of lightning coruscating between his hands with enough fury to consume anything that falls between them.  He stops when he racks and begins coughing.  Now, that is more impressive, you have to admit to yourself.");
		
		outputText("\n\n\"<i>I guess I might have overdone it.</i>\"  He smiles at you goofily, then coughs in what is obviously meant to cover his embarrassment.  \"<i>Thanks for keeping me company, I enjoy our chats a lot, [name].  You've been a great friend for me.</i>\"  You accept the compliment and tell him that it was nothing");
		if (player.cor >= 66) outputText(", keeping your real reasons for bothering with him to yourself");
		outputText(".");
		
		outputText("\n\n\"<i>Could I bother you one more time though?</i>\" Arian asks shyly.  \"<i>Would you mind helping me home?  My aides are probably pestering the guard to come and find me right about now, and I feel like I got my share of fresh air for the moment.</i>\"");
		
		outputText("\n\nYou decide that it wouldn't be too much trouble, and tell Arian that you'll give him a hand to get home.");
		
		outputText("\n\nArian leads you to the doorsteps of his house, and unhooking his arm from around your shoulder he takes your hands in [Arian eir] own and smiles at you.  \"<i>Thank you for the help, and for listening to my story.</i>\"  Then looking into you eyes expectantly, he asks, \"<i>Listen [name].  I would love it if you could visit me once in awhile.  It can be very lonely here and although my aides are always by my side there are things I simply can't talk about with them.  So... could you find time to visit a sickly mage?</i>\"");
		
		outputText("\n\nYou assure him you'll think about it; it's time he went inside and had some rest.  \"<i>Thank you, I'll be seeing you then.</i>\"  He releases your hand and slowly walks inside, barely getting the door open before two pairs of arms grab him and drag him in, closing the door behind him.  You shrug it off and head back towards camp; that diversion was nice, but you have other things to do.");
		//Player returns to (Tel'Adre / camp).
		//Arian's House replaces Park in Tel'Adre menu.
		outputText("\n\n(<b>The park has been removed from Tel'Adre's menu.  Arian's house has been added to the homes submenu.</b>");
		arianHealth(5);
	}
	arianHealth(1);
	flags[kFLAGS.ARIAN_PARK]++;
	doNext(camp.returnToCampUseOneHour);
}
	
//First Visit
public function visitAriansHouse():void {
	clearOutput();
	if (flags[kFLAGS.ARIAN_HEALTH] < 29 || flags[kFLAGS.ARIAN_VIRGIN] == 1) arianHealth(1);
	if (arianFollower()) {
		if (arianMF("m", "f") == "f")
			outputText(images.showImage("arianfemale-tent"));
		else
			outputText(images.showImage("arianmale-tent"));
		outputText("You approach the enchanted tent and slip easily inside the doors to the luxurious interior.  ");
		var temp:int = rand(10);
		if (temp == 0) {
			outputText("However, Arian isn't here right now, so you instead make yourself comfortable on the couch.  After a few minutes, Arian [Arian emself] walks in through the entrance.  \"<i>Oh, [name].  I wasn't aware you were here... have you been waiting for long?</i>\" [Arian ey] asks.  You tell [Arian em] not very long.  \"<i>That's good to hear.  So, what can I do for you?</i>\" [Arian ey] asks, with a smile.");
		}
		else if (temp == 1) {
			outputText("Inside, the lizan is sitting at a table, fastidiously drinking from a cup of something hot while poring over an arcane-looking text.  You politely cough to draw [Arian eir] attention and [Arian ey] looks at you, smiling.  \"<i>Hello, [name].  I was just catching up on my studies.  Can I offer you a cup of tea, or maybe something else?</i>\" [Arian ey] asks.");
		}
		else if (temp <= 2) {
			outputText("The lizan is currently busy tinkering with some occult-looking paraphernalia when you find [Arian em].  You politely cough to attract [Arian eir] attention, then do so again when [Arian ey] fails to heed that.  It's only on the third attempt that [Arian ey] looks up apologetically from [Arian eir] work.  \"<i>Ah, [name]; I'm sorry, but I was preoccupied with something.</i>\" [Arian ey] states in an apologetic tone, indicating the mess on [Arian eir] desk.  \"<i>Was there something you wanted?</i>\" [Arian ey] asks.");
		}
		else if (temp <= 4) {
			outputText("The smell of fresh cooking fills the air and you can see Arian happily sitting down at his couch with a plate of something just cooked.  \"<i>Oh, [name]; I was just about to eat, can I offer you a dish?  Or if you'd rather do something else, this can wait,</i>\" the lizan tells you with a smile.");
		}
		else if (temp <= 6) {
			outputText("You don't have to look far to find Arian; [Arian ey]'s currently curled up and asleep on the couch.  As you contemplate whether or not to wake [Arian em], [Arian ey] suddenly stirs and uncoils himself, stretching and yawning hugely in a way that lets you see every last needle-like tooth in [Arian eir] mouth.  [Arian ey] then sees you and gives you a smile. \"<i>Ah, [name]; I was just having a little nap.  Something on your mind?</i>\"");
		}
		else if (temp <= 8) {
			outputText("A strange smell hits your nose as you enter the tent; it takes you a few moments, but then you place it, your ears pricking as you hear Arian letting out some very familiar groans of release.  With a smirk, you sneak up and lean over the couch, looking right into the eyes of Arian, [Arian eir] fingers still glistening with ");
			if (flags[kFLAGS.ARIAN_COCK_SIZE] > 0) {
				if (flags[kFLAGS.ARIAN_VAGINA] > 0) outputText("mixed sexual fluids");
				else outputText("jizz");
			}
			else outputText("femjizz");
			outputText(" and, indeed, still hovering over [Arian eir] ");
			if (flags[kFLAGS.ARIAN_COCK_SIZE] > 0) {
				if (flags[kFLAGS.ARIAN_VAGINA] > 0) outputText("twin sexual slits");
				else {
					outputText("cock");
					if (flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText("s");
				}
			}
			else outputText("pussy");
			outputText(".  For a long moment, [Arian ey] just stares back at you; if lizans could blush, you're certain [Arian ey]'d be red as a beet.  \"<i>[name]! I was- I was just....  Oh, this is embarrassing,</i>\" [Arian ey] mutters, looking at [Arian eir] feet.");
			
			outputText("\n\nYou flash the flustered lizan a knowing smile, telling [Arian em] not to worry; there is nothing you haven't seen before under [Arian eir] robes.  Arian shivers in a way that just speaks volumes about [Arian eir] embarrassment.  You ask if, perhaps, [Arian ey] would like you to step outside while [Arian ey] makes [Arian emself] decent?  Not that you mind the sight....");
			outputText("\n\n\"<i>P-please.</i>\" Arian stammers, still unable to meet your gaze.  You gently tap [Arian em] on the nose and move outside.  A short while later you hear [Arian em] yell, \"<i>C-come in!</i>\"");
			outputText("\n\nYou can't wipe the smirk off your face, as you return and see that Arian is, indeed, decent and there doesn't seem to be any trace of the mess [Arian ey]'s made earlier.  You walk up to the, still flustered, lizan and tell [Arian em] that if [Arian ey]'s feeling edgy, you'd be happy to help [Arian em] deal with it.");
			outputText("\n\n\"<i>Th-that's all right....  So, um, you wanted something, [name]?</i>\" [Arian Ey] asks, desperately trying to change the topic.");
		}
		arianHomeMenu();
	}
	else {
		if (arianMF("m", "f") == "f")
			outputText(images.showImage("arianfemale-tent"));
		else
			outputText(images.showImage("arianmale-tent"));
		if (flags[kFLAGS.ARIAN_PARK] == 4) {
			flags[kFLAGS.ARIAN_PARK]++;
			outputText("Deciding to visit the sickly, Lizan mage, Arian, you promptly start walking.  The house is fairly large, at least two stories tall, but it looks pretty ordinary; there's nothing about it to make it really stand out from the other buildings in the neighborhood.  It's only the small brass plate on the door that says \"<i>Arian, Magus</i>\" that provides any clue that a wizard lives here.  There is a knocker on the front door, solid brass, carved in the shape of a leering grotesque, and you take hold of the handle and loudly bang it against the door to announce your presence.");
			
			outputText("\n\n\"<i>One minute!</i>\"  You hear a feminine voice yell from inside.  After hearing the clicking of a latch the door slowly opens to reveal what looks like a tan-furred female ferret looking at you with bespectacled brown eyes; she is not very tall, and her body is clad in loose comfortable robes that hide her curves well.  She adjusts her glasses and asks, \"<i>How may I help you, " + player.mf("sir","ma'am") + "?</i>\"");
			
			outputText("\n\nYou explain you're an acquaintance of Arian the wizard, and you came to see him.  With a smile the ferret steps aside.  \"<i>Please come in.</i>\"  You promptly step inside, getting your first look at Arian's home.  The exterior and the interior match quite well; it looks very normal in here.  Aside from a few nice vases and potted flowers, nothing else stands out.");
			
			outputText("\n\nThe ferret girl slowly closes the door behind you, closing the latch before she dusts her robes and turns to you.  \"<i>I'm afraid we haven't been properly introduced just yet, " + player.mf("sir","ma'am") + ".  My name is Laika and I'm one of master Arian's aides.</i>\"  She curtsies with a smile and adds, \"<i>Pleased to meet you... umm....</i>\"  You smile and tell her your name.  She closes her eyes and nods.  \"<i>Ah, yes, [name]....</i>\"  Suddenly she opens her eyes wide open.  \"<i>Wait a moment... [name]!?</i>\"  She advances on you, threatening you with a wooden spoon.  \"<i>You! You're the one who helped master Arian get away!</i>\"  She yells with a frown, poking your [chest] with her spoon.");
			
			outputText("\n\nYou ask if that's really such a big deal; all he wanted was to go and sit in a park.  Laika points an accusing finger at you and is about to say something when a masculine voice interrupts her.  \"<i>Sis! What's the problem?</i>\" Slowly, another tan-furred ferret emerges from the hallway nearby, clad in robes much like his sister's.  If Laika were to remove her spectacles, they would look like identical twins.");
			
			outputText("\n\n\"<i>Boon, this is the....</i>\"  Boon raises his hands, stopping Laika mid-sentence.  \"<i>Yes, sister.  Half the neighborhood knows by now.</i>\"  He walks up to his sister and slowly pushes her back towards the kitchen.  \"<i>Let me handle this, sis.  Just finish doing the dishes and cool your head down, I've already finished with my chores, so I can attend to our visitor.</i>\"");
			
			outputText("\n\nLaika glares at both you and her brother, but complies.  Sighing, Boon turns to you.  \"<i>Hello, [name].  I'm Boon, Laika's brother and master Arian's apprentice.  You'll have to forgive my sister, she's rather... passionate... when it comes to our master, but she does have a point.  What if master Arian had collapsed?  Or needed his medicine?</i>\"");

			outputText("\n\nBefore you can protest he stops you.  \"<i>You know what, it doesn't matter.  He would've found a way to run off whether you were there or not.  So, thanks for keeping him company.</i>\"  You accept the thanks with your usual grace, then ");
			if (player.cor < 33) outputText("curiously");
			else if (player.cor < 66) outputText("casually");
			else outputText("indifferently");
			outputText(" ask why he's thanking you.");
			
			outputText("\n\nBoon smiles and motions for you to follow, leading you upstairs.  \"<i>You see... master Arian didn't always enjoy taking long walks... I don't really know what made him suddenly take a liking for long walks around the city, but his condition does not allow him to do so, and he's just too stubborn to admit it.  So we kinda have to reel him in, or he will end up passing out in one of the rough parts of the city.</i>\"  Boon explains, turning on a hallway.  \"<i>Still, master looked really happy when he came back.  I'm glad he wound up meeting someone nice like you, instead of a mugger or a thief.</i>\"  Boon smiles at you.");
			
			outputText("\n\nHe stops at a wooden door and turns the knob.  \"<i>Of course!</i>\"  Once he does open the door, you're treated to a surprising sight.  Boon slaps his forehead with an open palm and groans.  Arian is standing on his bed, halfway out of the window, a surprised look plastered on his white face.");
			
			outputText("\n\n\"<i>Master Arian... I'm going to close this door and pretend I didn't just catch you trying to run away again.  I hope that when I open this door again I'll see you back in bed, or I'll sic Laika on you.</i>\"  At the mention of Laika, Arian shudders.  You just stand behind Boon, looking at the scene play out. Boon closes the door and waits a few moments before opening the door once again and motioning you in.  \"<i>Master Arian, you have a visitor.</i>\"");
			
			outputText("\n\nYou head inside at the ferret's gesture, wondering if Arian has stayed or not.  To your pleasant surprise, he is seated inside his bed, tucked somewhat sulkily under the covers.  You tell him that you wanted to come and visit, apologizing if you're interrupting something important.");
			
			outputText("\n\nArian smiles at you.  \"<i>Not at all.  Boon, you may leave us for now.</i>\"  Boon bows and leaves, closing the door behind him.  Arian sighs, removing his covers to sit up properly on the bed and motioning towards a nearby chair.  \"<i>Just make yourself at home; I'm really glad you came to see me.  I was wondering if I'd ever get to see you again.</i>\"");
			
			outputText("\n\nYou tell him that you couldn't resist coming to see him, even as you ");
			if (!player.isTaur()) outputText("pull up a chair");
			else outputText("seat your tauric body on the floor");
			outputText(".  You rack your brains for polite conversation, and finally ask how he's been since you saw him last.");
			
			outputText("\n\n\"<i>Well, I had to take some extra medicine after that little stunt at the park.  But that aside, I've been well.</i>\"  Arian smiles.  \"<i>What about you, my friend?  How have you been?  Have you done anything interesting between now and our last meeting?  I don't get to go out much, so I'd love to hear about whatever you can tell me about the world outside.</i>\"  Arian awaits your reply expectantly.");
			
			outputText("\n\nYou rack your brains; what can you tell him? Finally, you shrug and start talking about your travels in the wilderness beyond Tel'Adre.  Seeing how much exploration excites him, you take particular care to detail the many different places you've seen, how hard it is to know what you'll find with the strange \"<i>shifting</i>\" that the demons seem to have caused across the land, and all the many sex-mad monsters you've encountered in your travels.");
			
			outputText("\n\nArian listens attentively, like a child being told a story.  When you're done Arian smiles at you.  \"<i>Wow, you must be really busy.  And you still found time to be with a sickly mage.  Thank you so much for coming; it really means a lot to me.</i>\"  Arian takes your hand between his.  Despite yourself, you feel a swell of pride at the attention he's showing you; you squeeze his hand gently and promise him that you'll make sure and come back again if he's always going to be this attentive a listener.  It's nice to hear people are interested in your stories.");
			
			outputText("\n\nYou two continue to chatter for a while longer, but eventually you feel you must leave.  Arian looks visibly disappointed, but smiles at you all the same.  \"<i>Okay, I hope to see you soon, [name].</i>\"  Clearing his throat, Arians yells, \"<i>Boon!</i>\"  Mere moments later Boon opens the door.  \"<i>Yes, master Arian?</i>\"");
			
			outputText("\n\n\"<i>Boon, would you please escort [name] out?</i>\"  Boon nods and smiles.  \"<i>Of course, master.  Please come with me, [name].</i>\"  You say one last farewell to the smiling lizan and start on your way out of the house.  Once at the doorsteps, Boon stops you.  \"<i>Hey, [name].  You're an adventurer right?</i>\"");
			
			outputText("\n\nYou confirm that you are, yes.  Boon takes your hand in his and bows.  \"<i>Please! If you find a potion or herb or any other kind of medicine that could help, bring it for our master!  We've looked all over Tel'Adre but have been unable to find anything effective.  So please!  If you find something, bring it to us!</i>\"");
			
			outputText("\n\nYou promise to keep an eye out.  You then head back out to check up on your camp.");
			//PC returns to Tel'Adre menu screen
			//PC begins Arian romance quest
			//1 hour passes.
			doNext(camp.returnToCampUseOneHour);
		}
		else {
			//Subsequent Visits
			//His health affects the greeting you receive when seeing him.
			//If you modified Arian's gender, skip this intro once.
			//If you turned Arian into a girl/herm:
			//This plays at your next visit to Arian's place if you had him become a herm/girl.
			//Occurs only once, and after this intro plays as usual.
			//Don't increment ArianGirlHermChat yet!
			if (flags[kFLAGS.ARIAN_VAGINA] > 0 && flags[kFLAGS.ARIAN_HERM_CHAT] == 1) {
				outputText("Figuring that Arian would enjoy your company, you make your way with confidence through the streets leading to the lizan's home.  Soon enough, you find yourself standing before the stately home in which [Arian ey] and [Arian eir] ferret associates dwell. You pound heartily on the knocker to announce your presence.");
				outputText("\n\n\"<i>Coming!</i>\"  You hear Laika yell.  Shortly after the ferret girl opens the door.  Once she sees it's you, she doesn't bother greeting you; she drags you in and slams the door behind you.");
				outputText("\n\n\"<i>You!  What did you do to master Arian!?</i>\"  She threatens you with a duster.  Boon rushes in to check on the commotion, drying his wet hands with a piece of cloth.  \"<i>Sis, what's going... on...</i>\"  He looks at the scene and sighs.");
				outputText("\n\n\"<i>This... this... pervert had the nerve to come back after...</i>\"  Boon raises his hands in an attempt to silence his sister, not bothering to let her finish.  \"<i>Yes, yes, I know.  But it was master... uum... mistress Arian's decision, sis.  She told us herself.</i>\"");
				outputText("\n\nLaika's angry stare turns to her brother.  \"<i>Boon! I can't believe you're okay with this! I swear I should....</i>\"  Boon glares at Laika, obviously taking the role of big brother.  \"<i>Sis, we already spoke with mas... mistress Arian about this.  She likes [name], so much that she was willing to go through with her... umm... transformation.  Besides that, ever since [name] started visiting, mistress Arian's health has only gotten better, and you can't deny that, sis.</i>\"");
				outputText("\n\nLaika turns her angry glare back at you.  \"<i>You... you got lucky this time!</i>\"  She storms out of the entryway.");
				outputText("\n\nBoon looks at you apologetically.  \"<i>Sorry about that, [name].  But don't worry, I'm sure my sis will come around eventually; just give her some time.</i>\"  He smiles at you.  \"<i>If you'll excuse me, I have some chores that need doing; do you mind heading off to mistress Arian's room on your own?</i>\"");
				outputText("\n\nHaving watched the display in silence, you give him a friendly smile and assure him you'll be fine.  \"<i>Great! See you later.</i>\"  He turns and leaves you.");
				outputText("\n\nRemembering where Arian's room is from the last time you visited, you proceed to make your way to it, finding the door to be closed, as usual.  You slowly rap your knuckles on the closed door, trying to announce your presence without being a nuisance at the same time.");
			}
			else {
				outputText("Figuring that Arian would enjoy your company, you make your way with confidence through the streets leading to the lizan's home.  Soon enough, you find yourself standing before the stately home in which he and his ferret associates dwell.  You pound heartily on the knocker to announce your presence.");
				outputText("\n\n\"<i>Coming!</i>\"  You hear Laika yell.  Shortly after the ferret girl opens the door and greets you.  \"<i>Hello [name].  Came to visit " + arianMF("master","mistress") + " Arian?  Please come in!</i>\"  She motions for you to enter the house.  You thank her for the polite invitation and step through the doorway.  The sound of dishes being washed draws your attention to the nearby kitchen, where you see Boon diligently washing a pan.  He looks up and waves at you with a soapy hand.  You return the gesture.");
				outputText("\n\n\"<i>Sorry to leave you unattended [name], but we're kinda busy; do you think you can make the way to " + arianMF("master","mistress") + " Arian's room by yourself?</i>\"  Laika asks.");
				outputText("\n\nYou assure the ferrets that it's fine, and you understand how busy they are.  Remembering where Arian's room is from the last time you visited, you proceed to make your way to it, finding the door to be closed, as usual.  You slowly rap your knuckles on the closed door, trying to announce your presence without being a nuisance at the same time.");
			}
			//(if ArianGirlHermChat == 1)
			if (flags[kFLAGS.ARIAN_HERM_CHAT] == 1) {
				outputText("\n\nBefore you can say anything, you hear the distinct sound of Laika's yell.  It seems Boon and Laika are still engaged in a heated argument.  Arian winces and immediately apologizes to you.");
				outputText("\n\n\"<i>Sorry about that, [name].  I guess I should've been more considerate of the shock it would be to change like this.</i>\"");
				outputText("\n\nYou don't say anything, and just listen in as Boon and Laika stop their quarreling.  Arian smiles at you.  \"<i>They may argue, but they're good people.  Usually it only takes a moment before they settle their differences.</i>\"");
				outputText("\n\nYou're inclined to agree, it's not often you see siblings getting along like that.  Something's been bothering you though...  You ask Arian if she regrets changing.");
				outputText("\n\nArian gasps and quickly adds.  \"<i>No!  Of course not!  Sure everything feels different now... and I find myself having urges and desires I didn't have before.</i>\"");
				outputText("\n\nCurious, you ask what kind of urges.");
				outputText("\n\nThe transgendered lizard blushes in embarrassment.  \"<i>Well... I've been thinking about laying eggs a lot, recently,</i>\" Arian says nervously.");
				outputText("\n\nYou laugh, well that's certainly something she wouldn't be doing as a male.");
				outputText("\n\nArian quickly changes the subject though.  \"<i>So... what do you want to do today?</i>\"");
				//ArianGirlHermChat++;
				flags[kFLAGS.ARIAN_HERM_CHAT]++;
			}
			//0-9 health:
			else if (flags[kFLAGS.ARIAN_HEALTH] < 10) {
				outputText("\n\nYou hear a faint cough through the door.  \"<i>Come in.</i>\"  You hear a tired voice say.  Gently clasping the doorknob, you slowly open the door, careful of startling the sickly lizan.");
				outputText("\n\nArian smiles at you as you enter.  \"<i>Oh, hello [name].  I'm glad you came.</i>\"  He slowly sits up and motions to a chair nearby.  \"<i>Make yourself at home.</i>\"");
				outputText("\n\nYou pull the offered chair and sit next to his bed, smiling at [Arian em].");
				outputText("\n\n\"<i>So, is there anything you'd like to do?  Maybe talk?</i>\"  Arian asks.  You reply that talking is fine.");
			}
			//10-19 health:
			else if (flags[kFLAGS.ARIAN_HEALTH] < 20) {
				outputText("\n\nYou hear the distinct groan of someone stretching from behind the door.  \"<i>Come in,</i>\" you hear a tired voice say.  Quietly but calmly you open the door and slip gently inside.");
				outputText("\n\nArian smiles as you enter, sitting on his bed.  \"<i>Hello, [name].  I'm glad to see you.</i>\"  He motions to a nearby chair.  \"<i>Please, make yourself at home.</i>\"");
				outputText("\n\nYou take the nearby chair and sit next to his bed.  With a smile you ask how he is.");
				outputText("\n\n\"<i>I'm fine, thanks.  So... to what do I owe the pleasure of your visit today?</i>\"");
				//Display options
			}
			//20-29 health:
			else if (flags[kFLAGS.ARIAN_HEALTH] < 30) {
				//Repeat this until the PC decides to sex Arian up somehow.
				if (flags[kFLAGS.ARIAN_VIRGIN] == 0 && flags[kFLAGS.ARIAN_S_DIALOGUE] == 2) {
					outputText("\n\nYou hear a faint moan.  \"<i>Oh... [name].</i>\"");
					outputText("\n\nIs he... no, he couldn't be.  Arian's still too sickly to get horny... isn't he?  You wonder if you should try and spy on him - or maybe listen at the keyhole?  Then again, you could just barge on in - after all, it's not like he's really playing with himself, right?");
					//[Eavesdrop] [Peep] [Barge In] [Leave]
					menu();
					addButton(0,"Eavesdrop",eavesDropOnArian);
					addButton(1,"Peep",peepOnArian);
					addButton(2,"Barge In",bargeInOnArian);
					addButton(3,"Leave",leaveFappingArian);
					return;
				}
				//(else)
				else {
					outputText("\n\n\"<i>Come in!</i>\"  You hear Arian say, detecting a slight pep to [Arian eir] voice.  You step inside and smile at Arian as you close the door behind you.  [Arian Ey] smiles back at you and motions towards a nearby chair.");
					if (!player.isTaur()) outputText("\n\nYou pull the chair and sit next to [Arian eir] bed.");
					else outputText("\n\nYou simply sit beside [Arian eir] bed.");
					outputText("\n\nArian smiles at you and asks, \"<i>So... what do you want to do today?</i>\"");
				}
				
			}
			//30-49 health:
			else if (flags[kFLAGS.ARIAN_HEALTH] < 50) {
				outputText("\n\nYou hear the sound of drawers being pulled open and forcefully closed.  \"<i>C-come in!</i>\"  You hear Arian announce.  Curious as to what [Arian ey]'s up to, you open the door  and step inside to see Arian sitting on [Arian eir] work desk.  [Arian Ey] slowly turns on [Arian eir] swivel chair to gaze at you with a smile.  \"<i>Hello, [name]!</i>\"  [Arian Ey] motions to a nearby chair.  \"<i>I was just working on a little project, nothing important.  So, make yourself at home!</i>\"  [Arian Ey] smiles happily at you.");
				outputText("\n\nYou enter the room, wondering what [Arian ey] might have been working on, but decide it's probably nothing.  You note [Arian ey]'s made quite an improvement in health since you first met [Arian em].");
				outputText("\n\nYou pull the chair and sit next to [Arian em], asking why [Arian ey]'s thanking you;  [Arian Ey] did all the hard work and made  [Arian emself] get better, you merely provided the incentive to try, you tell  [Arian em].  \"<i>You've given me much more than that, and for that I thank you.</i>\"");
				outputText("\n\nYou stop and consider a moment, wondering what you should do now that you're here with the lizan.");
			}
			//50-74 health
			else if (flags[kFLAGS.ARIAN_HEALTH] < 75) {
				outputText("\n\n\"<i>[name], is that you?  Come in!</i>\"  You hear Arian happily say.  You open the door and step in to find Arian sitting by [Arian eir] table, a book is laying on the table and a mug of tea in [Arian eir] hand.  [Arian Ey] motions to a chair nearby as [Arian ey] sips [Arian eir] tea.  \"<i>Pull up a chair. May I offer you some tea?</i>\"");
				outputText("\n\nYou politely decline the tea and ");
				if (!player.isTaur()) outputText("take the offered chair");
				else outputText("the offered chair");
				outputText(".");
				outputText("\n\nArian sets [Arian eir] mug down and smiles at you.  \"<i>So, to what do I owe the pleasure of your visit?</i>\"");
			}
			//75-100 health:
			else {
				outputText("\n\nArian opens the door, smiling brightly at you.  \"<i>Hello [name]!  Come in!</i>\"  [Arian Ey] says, stepping back and holding the door for you.  You step in and Arian closes the door behind you and embraces you in a friendly hug.  You return [Arian eir] hug with one of your own.");
				outputText("\n\nBreaking the hug Arian leads you to [Arian eir] table");
				if (!player.isTaur()) outputText(" and offers you the chair nearby");
				outputText(".  Taking another for [Arian em]self.  \"<i>I love when you come visit, [name].  So, what are we going to do today?</i>\" [Arian ey] asks, expectantly.");
			}
			//(Display Options)
			arianHomeMenu();
		}
	}
}

private function arianHomeMenu():void {
	menu();
	if (flags[kFLAGS.ARIAN_S_DIALOGUE] == 0 && arianHealth() >= 10) addButton(0,"Next",arianStoryDialogue1);
	else if (flags[kFLAGS.ARIAN_S_DIALOGUE] == 1 && arianHealth() >= 20) addButton(0,"Next",arianStoryDialogue2);
	else if (flags[kFLAGS.ARIAN_S_DIALOGUE] == 2 && arianHealth() >= 30) addButton(0,"Next",arianDialogue3);
	else if (flags[kFLAGS.ARIAN_S_DIALOGUE] == 3 && arianHealth() >= 50) addButton(0,"Next",arianImbue);
	else if (flags[kFLAGS.ARIAN_S_DIALOGUE] == 4 && arianHealth() >= 75) addButton(0,"Next",arianPlot4);
	else if (flags[kFLAGS.ARIAN_S_DIALOGUE] == 5 && arianHealth() >= 100) addButton(0,"Next",arianPlot5);
	//If no story dialogue
	else {
		addButton(0,"Talk",talkToArianChoices);
		if (flags[kFLAGS.ARIAN_S_DIALOGUE] >= 2) addButton(1,"Sex",arianSexMenu);
		if (flags[kFLAGS.ARIAN_S_DIALOGUE] >= 1) addButton(3,"Give Item",giveArianAnItem);
		if (player.hasKeyItem("Arian's Talisman") >= 0 || player.hasKeyItem("Arian's Charged Talisman") >= 0)
			addButton(2,"Talisman",imbueTalisman);
		if (flags[kFLAGS.ARIAN_S_DIALOGUE] >= 5) addButton(4,"Treat Corr.",treatCorruption);
		if (model.time.hours >= 17 && arianFollower()) addButton(8,"Sleep With",sleepWithArian,true);
		if (flags[kFLAGS.SLEEP_WITH] == "Arian") addButton(8,"NoSleepWith",dontSleepWithArian);
		if (!arianFollower()) addButton(14,"Back",telAdre.telAdreMenu);
		else addButton(14,"Back",camp.campLoversMenu);
	}
}

private function dontSleepWithArian():void {
	clearOutput();
	outputText("You decide not to sleep with Arian at night, for now.");
	flags[kFLAGS.SLEEP_WITH] = "";
	arianHomeMenu();
}

//[=Eavesdrop=]
private function eavesDropOnArian():void {
	clearOutput();
	outputText(images.showImage("arian-fap"));
	outputText("You sidle up to the door, pressing your ear against the wood and start to listen intently.");
	outputText("\n\n\"<i>Curse my illness... curse my dreams... oh, [name]... if only you knew....</i>\"  Arian pants and moans, the distinct fapping sound of a hand slapping reaches your ears.  \"<i>Ah! The things you do to me... the things I wish you would do to me... ah....</i>\"");
	dynStats("int", 1);
	menu();
	addButton(0,"Barge In",bargeInOnArian);
	addButton(4,"Leave",leaveFappingArian);
}

//[=Peep=]
private function peepOnArian():void {
	clearOutput();
	outputText(images.showImage("arian-fap"));
	outputText("Curious, you decide to take a little peek through the lock; you press yourself against it as best you can, looking through into the bedroom beyond.  True to what your ears heard, the sickly albino's health has improved enough for him to focus on more... carnal matters.  Naked from the waist down, he sits on the edge of his bed, groinal slit disgorging a single, average-sized phallus.  Maybe 6 inches long, it's a bright purple-red color, covered in strange lumps");
	if (player.countCocksOfType(CockTypesEnum.LIZARD) > 0) outputText(" just like yours");
	outputText(", though this isn't stopping him from enthusiastically stroking himself off.");
	
	outputText("\n\n\"<i>Curse my illness... curse my dreams... oh, [name]... if only you knew....</i>\"  Arian pants and moans, the distinct sound of fapping quite audible from where you are.  He whimpers softly and bites his lip, clearly nearing the brink.  \"<i>Ah! The things you do to me... the things I wish you would do to me... ah....</i>\"  He groans to himself.");
	
	outputText("\n\nYou ponder this curious development.  So, the reptile has developed a crush on you?  He thinks you're attractive?  Well, now... should you give him the chance to finish himself off, or should you head in now - either to tell him off, or offer him something a bit better than his hand to play with?");
	dynStats("int", 1);
	//[Barge In - Leads on to \"<i>Barge In</i>\" scene from first choice] [Leave]
	menu();
	addButton(0,"Barge In",bargeInOnArian);
	addButton(4,"Leave",leaveFappingArian);
}

//[=Leave=]
private function leaveFappingArian():void {
	clearOutput();
	outputText("You decide to let Arian have some privacy and leave for the moment... after all, what the lizan mage does in his free time is not really your business....");
	outputText("\n\nAs you make your way back to the entryway, Boon sees you and asks, \"<i>Leaving already? Usually you stay with master Arian for at least an hour... what happened?</i>\"");
	outputText("\n\nYou tell Boon that Arian seems to be a bit busy at the moment, so you'll just come back later.");
	outputText("\n\n\"<i>Busy, huh?  Well if you want I could call him for you; master Arian is always happy to see you any time.</i>\"  Boon smiles starting on his way towards Arian's bedroom.  You quickly stop him though, explaining that it's best to let Arian have some privacy for now. \"<i> Are you sure, [name]?  It's no trouble at all, I assure you.</i>\"  You insist that he shouldn't bother Arian right now.  Boon shrugs.  \"<i>If you say so... anyways, do come visit later.  Ever since you started visiting master Arian, he has been a lot less rebellious, not to mention he seems to be getting healthier and happier.</i>\"");
	outputText("\n\nYou promise to return later and bid him farewell.  You step outside and make your way back to your camp.");
	//Return to camp
	doNext(camp.returnToCampUseOneHour);
}

//[=Barge in=]
private function bargeInOnArian():void {
	clearOutput();
	outputText(images.showImage("arian-fap"));
	outputText("With a wry smirk you turn the knob and find that Arian's door is unlocked; without missing a beat, you open the door and step in right in time to see a sticky rope of pre paint Arian's slender belly as he scrambles to cover himself up.");
	outputText("\n\n\"<i>[name]!  W-Wait, I can explain!  I swear I... I... oh, Marae!</i>\"  He hides himself under the covers of his bed, his white-scaled face red with shame.");
	outputText("\n\nSlowly you approach the hiding lizard, and sit on his bed.  You let him know you're flattered to be his object of desire, and that there's no need to hide himself.  If he felt this way about you he should just have said so.");
	outputText("\n\nArian peeks from under his covers.  \"<i>Y - You mean you're not mad at me?</i>\"  You smile and tell him you aren't.  Arian visibly relaxes, letting his covers fall on his chest.");
	//(if PC is male)
	if (player.hasCock() && !player.hasVagina()) {
		outputText("\n\n\"<i>I just assumed... since we're both male....</i>\" He explains himself, fidgeting.  \"<i>I didn't know if you... well... if you would mind that....</i>\"");
		outputText("\n\nYou raise your eyebrow; it seems that Arian is not opposed to some male on male.... What do you tell him?");
		//[Don't mind] [Like Girls]
		menu();
		addButton(0,"Don't Mind",youDontMindBeingGayForArian);
		addButton(1,"Like Girls",youLikeGirlsNotSickLizardDudes);
	}
	//(else if PC is genderless)
	else if (!player.hasCock() && !player.hasVagina()) {
		outputText("\n\n\"<i>I just assumed... since we're both male....</i>\"  He fidgets with his hands.  \"<i>I didn't know if you... well... if you would mind that....</i>\"");
		outputText("\n\nYou stop him in his tracks, and tell him you're not exactly male.  You strip your undergarments and let Arian gaze in fascination at your crotch - your clean, smooth, genderless crotch.  Not believing what he is seeing Arian crawls forward to touch your crotch, mesmerized.  \"<i>How?  You... I... we can't....</i>\"  You silence him with a finger, and tell him there's plenty you two can do.");
		//(Display Sex Menu)
		arianSexMenu(false);
	}
	//(else if PC is female)
	else if (!player.hasCock() && player.hasVagina()) {
		outputText("\n\n\"<i>It's just that... well... you're so beautiful and I'm... I didn't think you....</i>\"  He trails off.");
		outputText("\n\nYou tell him he looks adorable, especially when he's acting like a hopeless virgin.  At the mention of the word ‘virgin' Arian recoils.  Surprised by this development, you ask him if he really is a virgin.");
		outputText("\n\nArian hides his face once more inside his covers and says in a whisper, \"<i>Yes....</i>\"");
		outputText("\n\nYou pull the covers off his face and say, \"<i>Well... we'll have to fix that then.</i>\"  You slip off his bed and begin stripping off your [armor].  Arian shyly does the same, stripping off his robes until he is laying in his bed, completely naked.");
		//(Proceed to Get Penetrated)
		menu();
		addButton(0,"Next",getPenetratedByArianAndHisHitlerMustache);
	}
	//(else) //if PC is a herm
	else {
		outputText("\n\n\"<i>It's just that... well... you're so beautiful and I'm... I didn't think you....</i>\"  He trails off.");
		outputText("\n\nYou tell him he looks adorable, especially when he's acting like a hopeless virgin.  At the mention of the word ‘virgin' Arian recoils, surprised by this development you ask him if he really is a virgin.");
		outputText("\n\nArian hides his face once more inside his covers and says in a whisper, \"<i>Yes....</i>\"");
		outputText("\n\nYou pull the covers off his face and say, \"<i>Well... we'll have to fix that then.</i>\"  You slip off his bed and begin stripping off your [armor].  Arian shyly does the same, stripping off his robes until he is laying in his bed, completely naked.");
		outputText("\n\nOnce you toss your [armor] on the floor, however, Arian's eyes widen as he realizes you're not entirely female; he eyes your " + player.multiCockDescriptLight() + " and the moistening pussy between your legs with equal parts wonder and arousal.");
		outputText("\n\n\"<i>I... you... I never... wow....</i>\"  You call Arian's name, breaking his trance.  \"<i>S-Sorry for staring,</i>\" he quickly apologizes, but you just chuckle at his reaction and tell him he doesn't have to worry about this.");
		outputText("\n\n\"<i>I never imagined you would have both... err... genders,</i>\" [Arian ey] says nervously.  You just smile at him and ask if he has a problem with that.");
		outputText("\n\nArian quickly blurts out, \"<i>No!  Of course not!  Never!  I just... well... to be honest I don't mind that you have extra... umm... parts; in fact I think that is... kinda... sexy.</i>\"  He looks at you, cheeks red in shame over his admission.  \"<i>So... umm... my point is... I don't mind if you....</i>\"  Arian swallows audibly.  \"<i>If you decide to penetrate me... that is if you don't mind me being male... I don't mean to offend you or anything!  I just heard that some girls like you prefer... other girls....</i>\"  He looks away in shame.");
		outputText("\n\nYou rub your chin in thought....");
		//[Like Male] [Prefer Female]
		menu();
		addButton(0,"Like Male",hermsLikeMaleArian);
		addButton(1,"Like Female",hermsLikeFemaleArian);
	}

}

//[=Like Male=]
private function hermsLikeMaleArian():void {
	clearOutput();
	outputText("You tell him that's not the case for you; you don't have a problem with him being a guy.  In fact, you think he looks very cute, earning you a nervous smile.  Arian relaxes, letting you look over his body and decide what you want to do....");
	//(Should you penetrate him or mount him?)
	//Penetrate - (Proceed to appropriate scene)
	//Get Penetrated - (Proceed to appropriate scene)
	menu();
	if (player.hasCock() && player.cockThatFits(50) >= 0) addButton(0,"Penetrate",giveArianAnal);
	addButton(1,"Get Penetrated",getPenetratedByArianAndHisHitlerMustache);
}
//[=Prefer Female=]
private function hermsLikeFemaleArian():void {
	clearOutput();
	outputText("You tell him that while you do like to play with guys once in a while, you prefer girls.");
	outputText("\n\n\"<i>So... you'd prefer if I was a girl... right?</i>\"");
	outputText("\n\nYou scratch your chin in thought, and imagine how he would look as a girl; then you tell him you'd love it if he was a girl.  \"<i>Okay then... I... I'll do it!</i>\"");
	outputText("\n\nYou raise your eyebrows in surprise.  What is he planning on doing?");
	outputText("\n\nArian gets up and off the bed, not minding that he's exposing himself completely; then slowly walks toward his work desk and opens a drawer.  Reaching inside, he pulls out a mysterious bottle labelled with a pink egg.  He turns to look at you as he uncorks the bottle and then downs its contents.");
	outputText("\n\nIt barely takes a second for the effects to start.  As soon as he puts the bottle back inside the drawer, he collapses on the nearby chair.  At first you consider calling for help, but any thought of doing so leaves your mind when you see Arian's shaft visibly shrinking, soon entering the recesses of his genital slit.  As soon as his shaft disappears inside, his genital slit closes up, the skin connecting and leaving only smooth scales in his groin; lower, between his - or should it be her now? - legs, another slit opens up, soon spreading open as a small erect clit emerges from the wet folds.  Moisture leaks, wetting the wooden chair; the smell of aroused female fills the small bedroom and you feel your blood surging to your " + player.multiCockDescriptLight() + ".");
	outputText("\n\nThe transformation is not over yet though; a throaty feminine moan precedes the appearance of a pair of small perky breasts, complete with sensitive little nipples.  You watch in a daze as the transformation finishes, Arian's face growing softer, rounder, girly; the same happens to her body, her hips grow larger, as does her butt, becoming fuller and attractive, giving her a beautiful, if slender, figure.");
	outputText("\n\nWith a nervous smile, she asks, \"<i>S-So? How do I look now...?</i>\"");
	outputText("\n\nYou don't bother replying; you walk up to her and gently help her up.  Then you push her gently towards the bed and begin stripping.  Arian smiles and lays down.");
	//(Proceed to Penetrate)
	flags[kFLAGS.ARIAN_HERM_CHAT] = 1;
	flags[kFLAGS.ARIAN_VAGINA] = 1;
	flags[kFLAGS.ARIAN_COCK_SIZE] = 0;
	flags[kFLAGS.ARIAN_BREASTS] = 1;
	menu();
	addButton(0,"Next",penetrateArian);
}

//[=Don't mind=]
private function youDontMindBeingGayForArian():void {
	clearOutput();
	outputText("You tell him that you don't have a problem with males, as long as they're cute.  You smile at him.  \"<i>You... do you really think I'm cute?</i>\"");
	outputText("\n\nYou nod, it's not everyday you see a grown man acting like a hopeless virgin.  At the mention of the word ‘virgin' Arian recoils.... Surprised by this development you ask him if he really is a virgin.");
	outputText("\n\nArian hides his face once more inside his covers and says in a whisper, \"<i>Yes....</i>\"");
	outputText("\n\nWell, we'll have to fix that then.  You pull the covers off his face.  Slipping off his bed, you begin stripping off your [armor].  Arian shyly does the same, stripping out of his robes until he is laying in his bed, completely naked.\n\n");
	//(Proceed Give Anal)
	
	// Redirecting the scene if the players cock is too big for the anal scene... not ideal, but its a QWIKFIX™
	menu();
	if (player.cockThatFits(50) == -1)
	{
		addButton(0, "Next", getBlownByArian);
	}
	else
	{
		addButton(0, "Next", giveArianAnal);
	}
	
}
//[=Like Girls=]
private function youLikeGirlsNotSickLizardDudes():void {
	clearOutput();
	outputText("You tell him that you prefer females.... Arian looks at you expectantly.  \"<i>So... if I was a girl... then you wouldn't mind?</i>\"");
	outputText("\n\nYou scratch your chin in thought; and let him know that if he was a girl, then you wouldn't mind at all.  \"<i>Okay then... I... I'll do it!</i>\"");
	outputText("\n\nYou raise your eyebrows. What is he planning on doing?");
	outputText("\n\nArian gets up and strips off his robes, exposing himself completely, then slowly walks toward his work desk and opens a drawer.  Reaching inside, he pulls out a mysterious bottle labelled with a pink egg.  He turns to look at you and uncorks the bottle, then downs the whole bottle.");
	outputText("\n\nIt barely takes a second for the effects to start.  As soon as he puts the bottle back inside the drawer, he collapses on the nearby chair.  At first you consider calling for help, but any thought of doing so leaves your mind when you see Arian's shaft visibly shrinking, soon entering the recesses of his genital slit.  As soon as his shaft disappears inside, his genital slit closes up, the skin connecting and leaving only smooth scales in his groin; lower, between his - or should it be her now? - legs, another slit opens up, soon spreading open as a small erect clit emerges from the wet folds.  Moisture leaks, wetting the wooden chair; the smell of aroused female fills the small bedroom, and you feel your blood surging to your " + player.multiCockDescriptLight() + ".");
	outputText("\n\nThe transformation is not over yet though; a throaty feminine moan precedes the appearance of a pair of small perky breasts, complete with sensitive little nipples.  You watch in a daze as the transformation finishes, Arian's face growing softer, rounder, girly; the same happens to her body, her hips grows larger as does her butt, becoming fuller and attractive, giving her a beautiful, if slender, figure.");
	outputText("\n\nWith a nervous smile, she asks, \"<i>S-So? How do I look now...?</i>\"");
	outputText("\n\nYou don't bother replying; you walk up to her and help her up then gently push her towards the bed as you begin stripping.  Arian smiles and lays down. ");
	//(Proceed to Penetrate)
	menu();
	flags[kFLAGS.ARIAN_HERM_CHAT] = 1;
	flags[kFLAGS.ARIAN_VAGINA] = 1;
	flags[kFLAGS.ARIAN_BREASTS] = 1;
	flags[kFLAGS.ARIAN_COCK_SIZE] = 0;
	menu();
	addButton(0,"Next",penetrateArian);
}

//Story Dialogue
//Story Dialogue precedes all other interactions with Arian if the PC qualifies for any.
//They should happen whenever Arian reaches a new threshold.
//All of them occur only once.
//((if ArianHealth >= 10) && (ArianSDialogue == 0))//May give Vitality T. and Arian will accept it.
private function arianStoryDialogue1():void {
	arianHealth(1);
	clearOutput();
	outputText("You feel like you'd like to know a bit more about Arian, so you ask if he would mind sharing some of [Arian eir] history with you.  After all, as a survivor from at least the early days of the demon war, and a wizard to boot, he's got to have some stories up [Arian eir] voluminous sleeves.");
	outputText("\n\nArian nods.  \"<i>I guess it isn't fair that I'm the only one that gets to hear your stories... but before we start....  How long ago do you think this whole demon trouble started?</i>\"");
	outputText("\n\nYou shrug your shoulders; ");
	//PC has met Marae: 
	if (flags[kFLAGS.MET_MARAE] >= 1) outputText("Marae herself told you they showed up about, what, 20-30 years ago?");
	else outputText("you'd guess a long while ago given the general mess they seem to have made of the world.");
	
	outputText("\n\nArian nods.  \"<i>Good guess....  And how old do I look?</i>\"");
	
	outputText("\n\nYou look the reptilian wizard up and down, contemplating. Then you profess you aren't really familiar with people covered in scales, but you'd guess somewhere in [Arian eir] mid-20s?");
	outputText("\n\nArian nods and smiles.  \"<i>I'm actually 23 years old....  So I can't tell you much about how this whole trouble started, I was only a child back then... and my parents made sure to keep me sheltered from all that as well....</i>\"  Arian stares in the distance.  \"<i>Sheltered, I guess that word defines me pretty well.  I've been sheltered from the world for most of my life.</i>\"");
	outputText("\n\nYou ask why; what made [Arian eir] parents shelter him from the world outside?");
	
	outputText("\n\nArian looks back at you.  \"<i>Well, the world was a mess, so they thought it best if I just stayed in the academy; they told me stories of young lizans walking outside who were dragged away by demons to take part in terrible rituals.  They weren't entirely wrong I guess, but that was a really cruel thing to say to a child.  Although, they were just looking after me, in the end, and as curious as I am....  Well, let's not dwell on that.</i>\"  Arian clears [Arian eir] throat.  \"<i>So, I've been at the academy for as long as I can remember.  I told you about how I used to live buried in books right?</i>\"");
	
	outputText("\n\nYou nod your head and admit that he did indeed tell you that.");
	outputText("\n\n\"<i>Well, what I didn't tell you is that books used to be the only thing I cared about as well.</i>\"");
	outputText("\n\nYou comment that it does seem kind of odd that a self-professed bookworm would be so desperate to get out and stretch [Arian eir] legs, now that he mentions it.  Arian laughs at that.  \"<i>Yes, quite a change wouldn't you say?</i>\"  Then, with a sigh, he says, \"<i>It's ironic actually.  Since I couldn't go outside, all I had were the books; and the books had become my world: I read them, loved them, lived in them, and mastered them. With the time I spent reading, it was quite an easy path towards wizardhood.  As soon as I was of age, I joined the academy formally, and during my testing I was shown to have skills greater than or on par with my testers. In the end, they didn't see a need to instruct me, so they declared me a master of the art and assigned me my pupils: Laika and Boon.</i>\"");
	outputText("\n\nDid he enjoy having students of [Arian eir] own to teach?");
	outputText("\n\nArian's eyes light up in recollection.  \"<i>Enjoy it?  I loved it!  These two... they became much more than mere pupils; they were my friends.  I can even say they're part of my family.  Having grown up alone, ignored by my elders, who were too busy with their next research project to pay any attention to me, and with nothing but books to keep me entertained.  Can you imagine how many friends I had?</i>\"");
	outputText("\n\nYou must confess that the situation he's describing sounds quite lonely.");
	
	outputText("\n\n\"<i>So you can imagine how thrilled I was to get not one, but two people who would have to pay attention to every single instruction I gave them.</i>\"  Arian looks down, a slight tinge of regret on [Arian eir] face.  \"<i>I was pretty mean at first.  I wound up taking my frustrations out on them, but thankfully they found it in their hearts to forgive me.  We've been very close ever since.</i>\"  Arian smiles.");
	outputText("\n\nYou tell him that it's good to hear they got to know each other properly; is that why Arian gave particular attention to ensuring they escaped when [Arian eir] academy was attacked?");
	outputText("\n\nArian shakes [Arian eir] head.  \"<i>Not exactly.  It was my intention to defeat all of the invading demons; I was arrogant and it cost me greatly.  I only managed to save Boon and Laika because they were the closest to me when the wave of dark magic hit us.  I used much of my power and concentration to resist the wave's effects... it was brutal.</i>\"");
	
	outputText("\n\nDoes that have something to do why he's so frail now - the stress of shielding himself and [Arian eir] apprentices from the demons' black magic?");
	
	outputText("\n\n\"<i>Yes, actually. I'm not going to get into any specifics right now, but my method of casting spells causes damage to the caster's body, which is why I'm in such a miserable state.</i>\"  Arian sighs.  \"<i>Now I can't even go for a walk....</i>\"");
	outputText("\n\nYou reach out a hand and pat him on the shoulder; you don't really think it'll make him feel any better, but it's what they always used to do when people got like this back in your village.  As you pat [Arian eir] shoulder, you realize he still hasn't told you what made him change [Arian eir] attitude so much.  Even as you continue giving him comforting touches, you ask why it bothers him being bedridden now if he was an antisocial stay-at-home bookworm before.");
	outputText("\n\n\"<i>Oh, yes.  I got sidetracked, sorry.</i>\" Arian grins at you and says, \"<i>I escaped the academy.</i>\"  You scratch the back of your neck; this isn't much of an explanation.  Noticing the confusion in your face, Arian explains, \"<i>The academy didn't have any windows.  Something about preserving our privacy and ensuring no external elements would interrupt our studies.  It doesn't matter now.  So, before escaping the academy with Boon and Laika in tow, I hadn't even gazed at the sky.</i>\"");
	
	outputText("\n\nYou blink in surprise; he'd never even seen the sky?  How could they keep anyone so constrained?  What - did he hatch indoors and was never allowed outside?");
	outputText("\n\nArian sighs.  \"<i>Well, I did tell you my parents kept me inside the academy at all times.</i>\"  He sighs once again.  \"<i>I never knew the world was so big, or so beautiful.  I'd been missing out.  I want to go out and see more.  All the good and the bad.</i>\"  Arian looks down.  \"<i>But the truth is I can't, not like this.</i>\"  He sighs in exasperation.");
	
	outputText("\n\nYou try to cheer the depressed lizan up, exhorting that he needs to be optimistic about things; after all, amongst all the crazy potions and tonics, surely there's something that can make a drinker healthier and stronger?");
	outputText("\n\nArian sighs.  \"<i>I have tried so many already.  Boon and Laika have been all over Tel'Adre trying to find something to help me get better, but nothing seems to work....</i>\"");
	outputText("\n\nYou press the subject and ask him if he really doesn't know or have heard about anything that could help at all.");
	
	outputText("\n\nArian furrows [Arian eir] brows in deep thought.  \"<i>I think... I heard there might be something after all.  Something... vitality... I don't recall its name right now.  It's some kind of tonic or tea that is supposed to help you get tougher and stronger.</i>\"");
	outputText("\n\nAll right, it's settled then.  You tell Arian you're going to help him out, but he must promise to behave and stay in bed; if he keeps going out like when you first met him he's never going to get better.");
	outputText("\n\nArian sighs.  \"<i>I know I shouldn't go out, but sometimes I feel like I'm going insane if I stay cooped up in here.  I've spent so much time inside at the academy, and besides that, you have no obligation to help me at all.  I couldn't trouble you by sending you to look after some kind of medicine I don't even know where to find.</i>\"");
	outputText("\n\nYou tell him that you understand how that must make him feel.  Still, running around all the time clearly isn't doing him any good.  Furthermore, it's no trouble at all; you want to help.  Hmm... what if you promise to drop in now and then - share some of your stories about life in the wasteland, let him live vicariously through your actions?  Will that encourage him to stay in bed and avoid overexerting himself?");
	outputText("\n\nArian smiles at your offer.  \"<i>Well, that would certainly help.  I enjoy your company; there's something about you that.  Well... I guess you help me relax, and hearing about the world is not so bad either.  But I really wanted to see it.</i>\"");
	
	outputText("\n\nAnd see it he will, but only if he listens to you and gives himself a real chance to recover!  You insist that he start relaxing; it's probably the tension as well as the punishment he puts himself through in the name of boredom that's keeping him from making any major recovery.");
	outputText("\n\n\"<i>Maybe you're right.  All right then, I'll trust you [name].  I've been stuck inside the academy for many years... I guess I can hold out for a few weeks longer, as long as you come visit me.</i>\"  He extends [Arian eir] hand.  \"<i>Deal?</i>\"");

	outputText("\n\nYou give him a firm handshake, pronouncing that it's a deal.  Arian smiles at you before opening [Arian eir] maw into a wide yawn.  \"<i>Sorry about that, [name].  I guess I'm a bit sleepy....</i>\"");
	outputText("\n\nYou smile, and tell him that it's all right and he needs [Arian eir] sleep, so he had best get into bed. Arian nods and tucks himself in.  \"<i>Thank you, [name].</i>\"  You bid him goodnight and gently close [Arian eir] door behind you.  On your way out you let Boon and Laika know Arian is sleeping, then you make your way back to camp.");
	//ArianSDialogue++;
	flags[kFLAGS.ARIAN_S_DIALOGUE]++;
	//player returns to camp.
	doNext(camp.returnToCampUseOneHour);
}

////((if ArianHealth >= 20) && (ArianSDialogue == 1)) 
//Can sex Arian.
private function arianStoryDialogue2():void {
	clearOutput();
	arianHealth(1);
	outputText("You look Arian over, remarking that he seems to be getting better after all.");
	outputText("\n\n\"<i>Thanks to you.</i>\" Arian smiles, then he looks down and sighs.  You ask him what's wrong.");
	outputText("\n\n\"<i>I've been having... erm, confusing dreams lately.</i>\" Arian explains. Curious, you ask him what sorts of dreams; not bad ones, you hope.");
	outputText("\n\nArian quickly says, \"<i>No! Not bad ones! Just... unusual I'd say....</i>\"");
	outputText("\n\nYou look at him questioningly.  \"<i>Maybe it's best if I tell you....</i>\"");
	outputText("\n\nArian clears [Arian eir] throat and begins explaining, \"<i>First I'm standing somewhere - I don't know where - in Tel'Adre.  I'm all alone, but I'm happy; I'm expecting someone.  When the person I'm expecting arrives, we talk - I don't remember the subject now.</i>\" Arian fidgets.");
	outputText("\n\nYou tell him he needs to try and remember what happened if he wants to really hear what you think, but so far it doesn't sound so strange.");
	outputText("\n\n\"<i>You see, the strange part is... it's what happens later.</i>\"  Arian blushes in embarrassment.  \"<i>We go to my room and I... I'm sorry I can't talk about it!</i>\"  Arian blushes even more.");
	outputText("\n\nIt doesn't take you long to figure out what kind of dreams he's been having.  With a faint smile on your lips, you give him a comforting pat on the shoulder and tell him that there's nothing to worry about in having such dreams.");
	outputText("\n\nArian looks at you, still embarrassed.  \"<i>But the person I meet... I don't know if it would be appropriate.... Maybe the corruption is getting to me?</i>\"");
	outputText("\n\nYou ask him why he feels like that - what's wrong with [Arian eir] dream lover?  ...Is he worried because [Arian eir] lover is a boy?  Or maybe a girl with a cock?");
	outputText("\n\nArian swallows audibly.  \"<i>No, that's not the point....  I mean... maybe... just... just forget about it....  I'm feeling a bit tired.... Do you mind if we talk some other time?</i>\"");
	//ArianSDialogue++;
	flags[kFLAGS.ARIAN_S_DIALOGUE]++;
	//[Drop It] [Pry]
	menu();
	addButton(0,"Drop It",arianStory2DropIt);
	addButton(1,"Pry",arianStoryPry);
}

//=Drop It=
private function arianStory2DropIt():void {
	clearOutput();
	outputText("Though you do feel a little curious, you decide to stop making him uncomfortable, and tell him that it's okay, you'll let him get some sleep now.");
	outputText("\n\n\"<i>Thanks, [name].  I'll see you later then.</i>\"  Arian tucks himself in.  You watch until he's settled in, and then start the trek back to your home-away-from home in the Marethian wilderness.");
	doNext(camp.returnToCampUseOneHour);
}

//=Pry=
private function arianStoryPry():void {
	clearOutput();
	outputText("Oh, no, you're not letting him wriggle out of this that easily.  You playfully tap [Arian eir] nose and tell him he should come clean and confess");
	if (player.cor < 40) outputText("; he'll sleep better with the burden off [Arian eir] conscience");
	outputText(".");
	outputText("\n\nArian closes [Arian eir] eyes and admits.  \"<i>It's someone close!</i>\"  He blurts out, hiding himself under the covers.");
	outputText("\n\nWell, now, that's intriguing... still, no matter how you try, he won't say anything more and he won't come out.  It's quite clear what's going on so all you can do is sigh, do your best to pat [Arian eir] head through the covers, and tell him you'll come back another day and that you're sorry for being so nosey.  You then turn and walk out the door, heading down the stairs and back to camp.");
	doNext(camp.returnToCampUseOneHour);
}

//((if ArianHealth >= 30) && (ArianSDialogue == 2))
 //Will Teach Magic
private function arianDialogue3():void {
	clearOutput();
	arianHealth(1);
	outputText("Before you can say anything, Arian asks you, \"<i>[name], I've been wondering....  Do you have any interest in magic?  You've done so much for me; I believe I should return the favor somehow.</i>\"");
	//ArianSDialogue++;
	flags[kFLAGS.ARIAN_S_DIALOGUE]++;
	//[Yes] [No]
	menu();
	addButton(0,"Yes",yesArianShouldMagicTeach);
	addButton(1,"No",noArianShouldntMagicTeach);
}

//=Yes=
private function yesArianShouldMagicTeach():void {
	clearOutput();
	outputText("You tell [Arian em] that sounds fascinating.  You'd love to learn how to cast spells the way [Arian ey] can, and you're grateful [Arian ey] wants to take you on as an apprentice.  Especially when [Arian ey]'s already so busy with the ones [Arian ey] already has.  Arian rubs the back of [Arian eir] neck.  \"<i>Sorry, [name].  But I can't actually teach you how to cast spells the same way I do....  That would take years to teach, not to mention it's very dangerous; I mean, look at what it's done to me....</i>\"  [Arian Ey] smiles at you.  \"<i>But I could still teach you about magic in general - how to cast more spells, how to make them more powerful, the principles behind every spell....  Basically, theory that might help you in the pursuit of magical studies.  I spent my whole childhood buried in books, so I'm sure I could help you out somehow.</i>\"");
	
	outputText("\n\nYou smirk and point out that's basically what you meant, but you're definitely still interested either way.  Arian nods happily.  \"<i>Okay, then, where to start....</i>\"");
	
	//(Go to Talk about Magic)
	menu();
	addButton(0,"Next",arianMagicLessons);
}

//=No=
private function noArianShouldntMagicTeach():void {
	clearOutput();
	outputText("You think it over for a moment, and then tell Arian that while you are flattered by the offer and willing to consider it, you can't say that you want to study magic right this moment.  You'd like to discuss it at some other time, please.");
	outputText("\n\nArian nods happily.  \"<i>Certainly, I'd be happy to be of some help to you.  So... is there something you'd like to do today?</i>\"");
	
	//(display options) 
	arianHomeMenu();
}

//((if ArianHealth >= 50) && (ArianSDialogue == 3))
//Give Talisman, Imbue unlocked.
private function arianImbue():void {
	clearOutput();
	arianHealth(1);
	outputText("Before you can say anything, Arian gasps, \"<i>Oh, [name].  I have a surprise for you.</i>\"  Arian says with a smile.");
	
	outputText("\n\nA surprise?  What is it?");
	outputText("\n\nArian opens a drawer in [Arian eir] work desk and removes a small package, neatly wrapped and adorned with a small ribbon.  \"<i>For you.</i>\"  Arian says, handing over the gift.");
	
	outputText("\n\nYou reach out and gently take it from [Arian em], carefully opening the package.  A part of you briefly wonders if it might be an engagement ring, then dismisses the thought - surely not, not even here in Tel'Adre.  Once the package is open, you gaze upon a silver necklace: the design is intricate and exotic - very beautiful.  Held by its unusual chain lies a small silver plate with a rune adorning the center, although you don't recognize the rune.");
	outputText("\n\nArian smiles at you.  \"<i>Do you like it?  I made it myself.</i>\"");
	
	outputText("\n\nYou study the fascinating piece, and tell [Arian em] the honest truth: it's beautiful.  You never would have expected [Arian em] to be such a crafts[Arian man].  Arian blushes at your flattery.  \"<i>Thanks, I'm glad you like it.  But let me explain - that is not a common necklace; it's actually a magical talisman.  I wanted to give you something that would be useful in your adventures,</i>\" Arian explains.");
	
	outputText("\n\nYou smile at [Arian em], and promptly hang the necklace around your neck, telling [Arian em] it's as thoughtful as it is attractive.  Arian blushes.  \"<i>There is just a... well, a tiny problem.</i>\"");
	
	outputText("\n\nYou freeze nervously.  Problem...?  You wonder if putting it on was such a good idea now.  Arian nods.  \"<i>I haven't actually imbued the talisman with any spell, since I don't have any ingredients to do so.  Sorry, [name].</i>\"  Arian looks down disappointed.");
	
	outputText("\n\nYou heave a sigh of relief; is that all?  Well, what if you just bring [Arian em] some ingredients next time you drop in, hmm?  Would that help [Arian em] put the finishing touches on it?");
	
	outputText("\n\nArian smiles and nods.  \"<i>Of course.  But I should warn you that the talisman can only hold one spell, although once it's been imbued with a spell you may use it to your heart's content... I mean... as long as you don't get too tired doing so....  I have a list of spells and things that I need to complete a spell; all you have to do is bring the ingredients and tell me which spell you want.</i>\"");
	
	outputText("\n\nYou thank Arian; such a gift is bound to be useful in your travels.");
	
	outputText("\n\nArian bites [Arian eir] lower lips.  \"<i>So... is there anything you'd like to do?  Maybe....</i>\" Arian blushes.  \"<i>You could thank me properly... for the gift.</i>\" [Arian Ey] eyes you up and down, resting [Arian eir] gaze on the floor as [Arian ey] fidgets.");
	
	outputText("\n\nOh-hooo....  Your smoldering eyes burn holes in the nervously embarrassed lizan, and you give [Arian em] your sexiest glare as you ask whatever [Arian ey] means by \"<i>thanking [Arian em] properly</i>\"...?  You reach out and stroke the side of [Arian eir] face to emphasize your words, watching [Arian em] shudder anticipatorily at your touch.");
	
	outputText("\n\nArian swallows audibly.  \"<i>I... I... I want you!</i>\" Arian blurts out, averting [Arian eir] gaze in embarrassment, fidgeting even more in what you've come to recognize as a sign [Arian ey] is aroused.");
	
	outputText("\n\nDo you have sex with Arian?");
	player.createKeyItem("Arian's Talisman",0,0,0,0);
	//ArianSDialogue++;
	flags[kFLAGS.ARIAN_S_DIALOGUE]++;
	//[Yes] [No]
	menu();
	addButton(0,"Yes",yesPlotSexArian);
	addButton(1,"No",noPlotSexNauArian);
}

//=Yes=
private function yesPlotSexArian():void {
	clearOutput();
	outputText("You approach the awkwardly amorous lizan and place your arms around [Arian eir] neck.  Leaning in close, you whisper into [Arian eir] ear that [Arian ey] only had to ask.");
	//(Display Sex Menu)
	arianSexMenu(false);
}

//=No=
private function noPlotSexNauArian():void {
	clearOutput();
	outputText("You apologize to the lizan, telling [Arian em] that you aren't in the mood right now....");
	outputText("\n\nArian looks a bit disappointed, but doesn't press the issue.  \"<i>Oh... Okay then, but... maybe, next time?</i>\" [Arian ey] asks hopefully, smiling nervously despite [Arian eir] embarrassment....");
	
	outputText("\n\n Maybe next time, you agree. Arian grins at you.  \"<i>Okay, then.  Is there something else you'd like to do?</i>\"");
	
	//(Display Options)
	arianHomeMenu();
}

//((if ArianHealth >= 75) && (ArianSDialogue == 4))
 //Will treat Corruption.
private function arianPlot4():void {
	clearOutput();
	arianHealth(1);
	outputText("Before you can say anything, Arian says, \"<i>Oh, I have good news, [name]!</i>\"");
	outputText("\n\nGood news?  What is it?");
	outputText("\n\n\"<i>I'm feeling well enough that I think I can channel my magic through you and help you if you feel you're getting overwhelmed by this world's corruption.  But due to the intensity of the treatment, I don't think I'd be able to do it more than once per day....</i>\"");
	
	outputText("\n\nYou tell [Arian em] that, even if it's only once every 24 hours, that could be a very useful trick, and thank [Arian em] for being willing to make such a sacrifice on your behalf.");
	
	outputText("\n\nArian smiles brightly at you.  \"<i>No problem.  I'd do anything for you.</i>\"  [Arian Ey] gazes into your eyes in silence... perhaps a bit too long....  You clear your throat and Arian seems to snap out of [Arian eir] trance.  \"<i>Oh!  Umm... is there something you want to do?</i>\"  [Arian Ey] fidgets.");
	
	//(Display Options)
	//ArianSDialogue++;
	flags[kFLAGS.ARIAN_S_DIALOGUE]++;
	arianHomeMenu();
}

//((if ArianHealth == 100) && (ArianSDialogue == 5))
private function arianPlot5():void {
	clearOutput();
	arianHealth(1);
	outputText("Before you can say anything, Arian stops you.  \"<i>I've been meaning to ask you something, [name].  I've been feeling a lot better lately; in fact, I may be even better than I was before.</i>\"  Arian blushes.");
	
	outputText("\n\n\"<i>I wanted to ask you if we could... well... live together?</i>\"  Arian bites [Arian eir] lower lip.");

	outputText("\n\nYou explain to Arian about the portal, and your mission as the champion - how due to your duties, you cannot just move here and live with [Arian em].");
	
	outputText("\n\nArian quickly adds, \"<i>Oh... no....  You wouldn't be moving here.  I would be the one moving in with you....");
	if (camp.companionsCount() > 1) outputText("  There are other people living with you already, so what's one more?  Right?");
	outputText("</i>\"");
	
	outputText("\n\nYou ponder [Arian eir] request...  On one hand, having someone who understands magic would be of great help for your quest, and you've come to enjoy Arian's company, but what about Boon and Laika?");
	
	outputText("\n\n\"<i>I've spoken with them already and I believe they are ready to pursue their magical studies on their own.  They've been caring for me for a long time; I think it's time they lived their lives for themselves.  Besides, we won't be separated for good; I'll come and visit every once in a while.</i>\"  Arian smiles hopefully at you.");
	
	outputText("\n\nWell... when [Arian ey] puts it that way... what should you do?");
	//ArianSDialogue++;
	flags[kFLAGS.ARIAN_S_DIALOGUE]++;
	//[Accept] [Deny]
	menu();
	addButton(0,"Accept",acceptArianMovingIntoCamp);
	addButton(1,"Deny",denyAriansMoveIn);
}

//[=Accept=]
private function acceptArianMovingIntoCamp():void {
	clearOutput();
	outputText("You tell Arian you'd be delighted to have [Arian em] move in with you.  Arian's face lights up like a kid's who's been given a bucket of candy.  \"<i>Really!?  Great!  I'll pack my stuff and we can go right away!</i>\"");
	
	//(Skip to ‘Invite to Camp')
	menu();
	addButton(0,"Next",inviteArianToCamp);
}

//[=Deny=]
private function denyAriansMoveIn():void {
	clearOutput();
	outputText("You tell Arian you'd like some time to think about it.  Arian looks disappointed at first, but smiles at you all the same.  \"<i>I understand... no pressure....  So, what are we going to do today?</i>\"");
	
	//(Display Options)
	arianHomeMenu();
}

//Talk
private function talkToArianChoices():void {
	clearOutput();
	outputText("You tell Arian you'd like to talk to [Arian em].  Arian smiles at the prospect of chatting with you.  \"<i>I love talking with you; so what do you want to talk about?</i>\"");

	menu();
	if (flags[kFLAGS.ARIAN_VIRGIN] > 0) addButton(0,"Sexy Talk",arianSexingTalk);
	if (flags[kFLAGS.ARIAN_S_DIALOGUE] >= 3) addButton(1,"Teach Magic",arianMagicLessons);
	if (!arianFollower() && flags[kFLAGS.ARIAN_S_DIALOGUE] >= 6) addButton(4,"Invite2Camp",inviteArianToCamp);
	if (flags[kFLAGS.ARIAN_VIRGIN] == 0 && flags[kFLAGS.ARIAN_S_DIALOGUE] < 3) outputText("\n\n<b>Arian doesn't have much to talk about right now.  Maybe you ought to just visit him from time to time or find him an item that would help combat [Arian eir] sickness.</b>");
	addButton(14,"Back",arianHomeMenu);
}

//Magic:
//Magic Lessons, teaches white magic and increases int. Up to 100.
//Gain a pretty nice boost, 4 lessons per day, only.
private function arianMagicLessons():void {
	clearOutput();
	arianHealth(1);
	outputText("You ask Arian if [Arian ey] wouldn't mind giving you some magic lessons.");
	
	//(if ArianMLesson >= 4)
	if (flags[kFLAGS.ARIAN_LESSONS] >= 4) {
		outputText("\n\nArian raises [Arian eir] hand, stopping you in your tracks.  \"<i>I appreciate your enthusiasm, [name].  But first you must rest and let the lessons of the day sink in.  I promise I'll teach you more tomorrow.</i>\"  Arian smiles at you.");
		
		outputText("\n\nMaybe [Arian ey]'s right... you tell [Arian em] you'll ask [Arian em] to teach you more tomorrow and excuse yourself.");
		doNext(camp.returnToCampUseOneHour);
		return;
	}
	outputText("\n\nArian nods.  \"<i>Of course!  Now where do I begin....</i>\"");
	
	//(if PC int < 25) //Basics!
	if (player.inte < 25) {
		outputText("\n\nYou let Arian know you're actually pretty new to magic in general, so maybe [Arian ey] could teach you a few basics?  Arian nods.  \"<i>Very well...</i>\"  Arian clears [Arian eir] throat.");
		outputText("\n\n\"<i>The basis of all magic is mental strength, or more appropriately, your willpower - the desire, the wish, the passion to make something that is not... be.  Which is the reason mages study so hard to begin with.</i>\"");
		outputText("\n\nYou pay attention to Arian's every word, making mental notes of the more important lessons....");
		
		outputText("\n\n\"<i>And that is all; any questions?</i>\"  Arian patiently awaits your reply.  You sigh, tired after a long lesson on the fundamentals of magic and spellcasting.  You tell Arian that you don't have any questions for now... but you'd like to repeat the lesson some other time.");
		outputText("\n\nArian smiles at you.  \"<i>Of course, [name].  If you have any doubts or would like me to repeat, all you have to do is ask.  I'll make sure to always have time for you.</i>\"");
		outputText("\n\nYou thank the lizan for the lesson and ");
		if (!arianFollower()) outputText("make your way back to your camp.");
		else outputText("return to your duties.");
	}
	//(else if PC int < 50 //Teach Charge Weapon if PC doesn't know.
	else if (player.inte < 50) {
		outputText("\n\nYou tell Arian you've got the fundamentals down, so why not cover something a bit more advanced?");
		outputText("\n\nArian taps [Arian eir] chin in thought, then smiles.  \"<i>I know!  Let's talk about channeling.</i>\"");
		outputText("\n\nChanneling? You ask.");
		outputText("\n\n\"<i>Yes, the art of focusing your spell within a conduit - in short, enchanting objects.</i>\"");
		outputText("\n\nYou smile and tell Arian this sounds like an interesting subject....");
		outputText("\n\n\"<i>So remember: don't overcharge your conduit or the results could be disastrous....  Just ask Boon,</i>\" Arian chuckles.");
		outputText("\n\nYou wonder whatever could have happened that was so funny.  But for the moment the lesson has tired you, so you thank Arian for the lesson and excuse yourself ");
		if (!arianFollower()) outputText(", making your way back to camp.");
		else outputText(", exiting [Arian eir] tent and going about your business.");
		
		//(if PC doesn't know Charge Weapon)
		if (player.findStatusEffect(StatusEffects.KnowsCharge) < 0) {
			outputText("\n\nAs you ");
			if (!player.isNaga()) outputText("walk");
			else outputText("slither");
			outputText(" away, you start pondering Arian's lesson of the day.  You wonder if you could perhaps apply the channeling principle to strengthen your [weapon] in combat.");
			outputText("\n\nThat would be very helpful; you'll have to try it sometime.");
			player.createStatusEffect(StatusEffects.KnowsCharge,0,0,0,0);
		}
	}
	else if (player.inte < 75) {
		outputText("<b>Game Note: This isn't canon and will be re-written soonish.</b>");
		//Teach Blind if PC doesn't know.
		outputText("\n\nYou say you have a pretty good understanding of how magic works now, so you'd like [Arian em] to get started on the more complex theories.");
		outputText("\n\nArian rubs [Arian eir] chin in thought.  \"<i>Hmm.... Aha!  Let's discuss conjuration.  This is where we start getting to the more complex theories and methods.  I know I don't have to say it, but pay attention.  Conjuration is an important art for any mage.</i>\"");
		outputText("\n\nYou nod as Arian begins lecturing you on the finer points of the art of conjuration.");
		outputText("\n\nArian wasn't kidding; this is quite a complex subject...");
		outputText("\n\n\"<i>Now to finish our lesson, I'll give you a practical example of how to effectively use conjuration to defend yourself.  So pay attention, [name].  Conjured objects are generally weaker than real objects, so conjuring a shield or a suit of armor or even a weapon is no good.  Not to mention it's quite complicated.  A suit of armor is made not only of metal, but of other components as well - you'd have to conjure and maintain each individually.  Instead, conjure a simple element that can turn the tide of the battle in your favor.</i>\"");
		//(if PC doesn't know Blind)
		if (player.findStatusEffect(StatusEffects.KnowsBlind) < 0) {
			outputText("\n\nLike what?  You ask in curiosity.");
			outputText("\n\nArian lifts a closed fist.  \"<i>Mind your eyes.</i>\"  You nod.  Arian points [Arian eir] fist towards a nearby wall and opens [Arian eir] hand.  A bright flash of light shoots out of [Arian eir] hand to hit the wall harmlessly.  \"<i>This was the element of light.  I produced a bright light capable of temporarily blinding whomever happens to be looking at it when it's exposed.</i>\"");
			outputText("\n\nYou note how such a spell could be useful for you in combat.  Arian grins at you.  \"<i>I'm glad this lesson was helpful, [name].  Come here and I'll teach you how to properly conjure it.</i>\"");
			outputText("\n\nYou spend a few minutes learning how to properly use the spell, and after some practice you can reliably use the spell whenever you want to.  You thank Arian for the lesson and for teaching you a new spell.  Then bidding farewell to the grinning lizan, you leave, promising to visit [Arian em] again soon.");
			player.createStatusEffect(StatusEffects.KnowsBlind,0,0,0,0);
			//Return to camp.
		}
		else {
			outputText("\n\nYou understand what Arian's talking about.  [Arian Ey] means that rather than conjuring a barrier, it's best to conjure something akin to a bright light to try and blind your foe.");
			outputText("\n\nArian nods pridefully.  \"<i>Very well, [name]!  That's exactly what I mean.</i>\"");
			outputText("\n\nYou spend a few more minutes talking to Arian before  thanking [Arian em] for the lesson and bidding farewell to the grinning lizan, you promise to visit [Arian em] again soon.");
		}
	}
	else { 
		//Teach Whitefire if PC doesn't know.
		outputText("<b>Game Note: This isn't canon and will be re-written soonish.</b>");
		outputText("\n\nYou ask Arian if [Arian ey] wouldn't mind hearing some of your own theories about magic; you've been giving the subject a lot of thought lately.");
		outputText("\n\nArian looks at you, eyes alight with interest at what you have to say.  \"<i>Please, do share your thoughts.</i>\"  You explain that if you are able to use magic to conjure elements, with a little concentration it might also be possible to alter these elements on the fly; you convey the method you theorized to the lizan mage.");
		outputText("\n\nIf you can conjure elements at will, would it be possible to also alter them?  You could have one element start out as a non-volatile substance within your hands and then hurl it towards a target whilst also focusing upon changing its nature, thus creating an explosive reaction.  For instance, you can start out with a small gathering of dust and quickly change it into a highly combustible element and make it look like as if you made the air explode.");
		outputText("\n\nOnce you're done, Arian grins at you.  \"<i>That's very good, [name].  Indeed, alteration is another art a mage must master in order to be considered a true master; let me give you a more detailed explanation....</i>\"");
		outputText("\n\nYou listen attentively to the lizan....");
		outputText("\n\n\"<i>And that's about it.  There were mages researching this subject at the academy, but then the whole trouble with the demons happened... maybe someday we can resume our research in this area.</i>\"");
		outputText("\n\nYou let Arian know that this conversation was very interesting; the knowledge [Arian ey] shared with you today is bound to be useful in your adventures.");
		outputText("\n\nArian grins happily at you.  \"<i>I'm glad to be of use, [name].  Please come back soon; I would love to discuss more of it with you.</i>\"");
		outputText("\n\nYou thank Arian and promise to return sometime soon.  You excuse yourself and ");
		if (!arianFollower()) outputText("begin the trek home.");
		else outputText("exit [Arian eir] tent.");
		//(if PC doesn't know Whitefire)
		if (player.findStatusEffect(StatusEffects.KnowsWhitefire) < 0) {
			outputText("\n\nAs you walk, you ponder what you discussed with Arian and conclude that by combining conjuration with alteration, you could quickly and easily create an expanding conflagration of flames, burning your foes in combat.");
			outputText("\n\nYou should put that into practice sometime soon.");
			player.createStatusEffect(StatusEffects.KnowsWhitefire,0,0,0,0);
		}
	}
	flags[kFLAGS.ARIAN_LESSONS]++;
	dynStats("int", 1);
	if (player.inte < 75) dynStats("int", 1);
	if (player.inte < 50) dynStats("int", 1);
	doNext(camp.returnToCampUseOneHour);
}
//Sex:
//Available after the first time you have sex. (ArianVirgin > 0)
private function arianSexingTalk():void {
	clearOutput();
	arianHealth(1);
	outputText("You smirk knowingly at [Arian em] and ask how [Arian ey] feels about sex now that [Arian ey]'s had [Arian eir] first time?");
	
	outputText("\n\nArian bites [Arian eir] lower lip in embarrassment.  \"<i>I... umm... can't we talk about something else?</i>\"  You shake your head and tell [Arian em] there's nothing to be ashamed of.  The two of you have already shared intimacy after all; and you'd like to know [Arian eir] kinks and wishes as well.");
	outputText("\n\nArian blushes, and takes a deep breath.  \"<i>Okay....</i>\"");
	//Block about penis. Should only show up if Arian has a cock at all.
	if (flags[kFLAGS.ARIAN_COCK_SIZE] != 0) {
		//Arian talks about his lack of a second penis.
		if (flags[kFLAGS.ARIAN_DOUBLE_COCK] == 0) {
			outputText("\n\n\"<i>I've always resented my lack of a second dick,</i>\" Arian admits.");
			outputText("\n\nReally?");
			outputText("\n\n\"<i>Well, lizans like me usually have two, and I only have one....  I've always thought I was freakish and usually avoided any kind of sexual contact, not that it was hard to avoid it, since I usually had my muzzle buried in a book.  Maybe I wasn't as social because of that... or... I don't know.  The point is, I never hoped to find someone who'd... you know....</i>\"  Arian fidgets, smiling nervously at you.");
			
			outputText("\n\nYou smile right back at [Arian em].  You happen to find Arian is adorable, especially when [Arian ey] gets all shy like that.  But if [Arian eir] lack of a matching dick is such a big problem, maybe you could find something in your journey to help [Arian em] remedy that.  Would [Arian ey] like that?");
			outputText("\n\n\"<i>Oh... I suppose there might be something that can do that.  Although I suppose it doesn't matter that much now.  Unless you'd like me to get a second one?</i>\"");
			outputText("\n\nYou ponder the idea, but decide that Arian is fine just the way [Arian ey] is; maybe someday though...");
		}
		//Arian has 2 penis, thankful for the PC's help in that department.
		else 
		{ 
			outputText("\n\n\"<i>I had always resented my lack of a second dick,</i>\" Arian admits.  \"<i>But I guess I don't have to worry about this anymore, thanks to you.</i>\"  Arian smiles at you.");
			outputText("\n\nYou tell [Arian em] that it was no trouble; double the pleasure, double the fun, right?");
			outputText("\n\nArian blushes.  \"<i>I guess....</i>\"");
			outputText("\n\nAlthough... that means [Arian ey]'d have double the work if [Arian ey] intends to masturbate.  \"<i>Umm... why would you say that?</i>\"  Arian asks nervously.");
			outputText("\n\nYou chuckle, and tell [Arian em] you haven't forgotten that time you caught [Arian em] masturbating.");
			outputText("\n\nArian laughs nervously.");
		}
		outputText("\n\nWhat about [Arian eir] size though?  In this world it's quite easy to do something about that, if size is a problem.");
		//Now deal with Cock Sizes, properly.
		//Regular Cock.
		if (flags[kFLAGS.ARIAN_COCK_SIZE] == 1) {
			outputText("\n\n\"<i>Well, I don't have any complaints, personally.  I feel good no matter what we do.  Even if you don't touch me there.  But if you want me to grow bigger, or maybe want me to get rid of it... I don't have any objections.</i>\"");
		}
		//Big Cock.
		else if (flags[kFLAGS.ARIAN_COCK_SIZE] == 2) {
			outputText("\n\n\"<i>I'm certainly a lot bigger than I hoped to ever get.  Sometimes it's a tight fit... in my slit I mean... but I kinda like it, and that also means it'll feel better for you if we... I mean... if you want to...  Not that I mind, I'm happy just being with you.  And if you want to change it somehow... I wouldn't mind.</i>\"");
		}
		 //Huge Cock.
		else if (flags[kFLAGS.ARIAN_COCK_SIZE] == 3) {
			outputText("\n\n\"<i>It's a lot bigger than I'm comfortable with, to be honest.  But you said you liked it, so I'm keeping it.</i>\"  You see [Arian eir] robes beginning to tent, and can't help but tease the shy lizan.  It seems that despite [Arian eir] complaints, [Arian ey] enjoys having a monster between [Arian eir] legs... one that [Arian ey] can't hope to hide.");
			outputText("\n\nArian blushes.  \"<i>I... okay, I admit it... it feels pretty good... and is kinda kinky, too... Still, if you think I should be smaller... I wouldn't mind.</i>\"");
		}
		outputText("\n\nYou tell Arian you'll think about it....");
	}
	//End of Cock Block. Innuendos ahoy!
	//(if ArianVagina > 0) //Talk about Arian's new oviposition perk
	if (flags[kFLAGS.ARIAN_VAGINA] > 0) {
		outputText("\n\nArian sighs and flushes; the distinct smell of an aroused female begins to permeate the room.  That and the lizan's cute fidgeting are a dead giveaway of [Arian eir] current state.");
		outputText("\n\nArian sighs and licks [Arian eir] lips.  \"<i>I never imagined I would ever turn into a girl... much less that I would know what being a girl is like....  Everything feels different... but not in a bad way... just weird, I guess.</i>\"");
		outputText("\n\nYou tell [Arian em] that's understandable, and ask how [Arian ey]'s feeling about that.");
		outputText("\n\n\"<i>I feel sick for no apparent reason.  I have the strangest urges I didn't have.  My chest feels heavy.  And above all else....</i>\"  Arian looks at you and blushes.");
		outputText("\n\nAnd above all else?  You ask.");
		outputText("\n\nArian averts [Arian eir] eyes.  \"<i>Just being close to you makes me... hot....</i>\"");
		outputText("\n\nReaaaally?  You smirk at [Arian em].  Arian flushes even more.  \"<i>T-there's also the eggs... so many eggs....</i>\"");
		outputText("\n\nEggs?");
		outputText("\n\n\"<i>Yes, eggs.  Lizan females lay eggs throughout their entire fertile period... I... have to deal with this monthly... and whenever the time to lay comes around I find myself thinking....</i>\"");
		outputText("\n\nThinking?");
		outputText("\n\n\"<i>About you.</i>\"  Arian admits.");
		outputText("\n\nIf that's the case, maybe you should help [Arian em] lay sometime.");
		outputText("\n\n\"<i>I think, I'd like that... sometime,</i>\" Arian replies.");
		if (arianFollower()) outputText("\n\nYou tell [Arian em] you'll make sure to stop by when [Arian ey]'s close to laying then.\n\n\"<i>I'll be waiting for you.</i>\"  Arian smiles.");
		else outputText("\n\nAs much as you'd like that, Boon and Laika, especially, are bound to berate you if they see you leaving [Arian eir] room with an egg in hand.\n\nArian giggles, \"<i>That's true.  Maybe we can find a way to be alone then?</i>\"\n\nMaybe....");
	}
	outputText("\n\nYou look Arian over, and decide to ask what [Arian eir] preferred form of sex is.");
	//Finally discuss Arian's preferred sex acts. [Arian Ey] slowly takes a liking for anal.
	if (flags[kFLAGS.ARIAN_ANAL_XP] < 33) {
		//No preference... yet.
		outputText("\n\nArian rubs [Arian eir] chin in thought, but in the end [Arian ey] simply shrugs and says, \"<i>I guess I don't really have a preference... so I'm good with whatever you feel like doing.</i>\"  Arian smiles at you.");
		outputText("\n\nMaybe [Arian ey]'s not sure yet because you haven't played with [Arian em] enough yet.... Perhaps you should try doing more... stuff?");
		outputText("\n\nArian smiles nervously at you and slowly nods in agreement.");
	}
	else if (flags[kFLAGS.ARIAN_ANAL_XP] < 66) { 
		//Kinda like anal, thought it was going to hurt but it feel nice...
		outputText("\n\nArian rubs [Arian eir] chin in thought.  \"<i>To be honest... ever since you... umm... put it back there....</i>\"  Arian blushes.  \"<i>I've been thinking that anal is not so bad... I was scared that it might hurt at first... and while it does hurt a bit, it also feels nice.</i>\"");
		outputText("\n\nYou're surprised to hear that.  Not everyone enjoys anal sex.");
		outputText("\n\nArian averts [Arian eir] eyes.  \"<i>I'm not saying I enjoy it... but I don't mind if it's you....</i>\"");
	}
	//Anal feels good, just as good as any other action if not better
	//(else if (ArianAnalXP <= 100))
	else if (flags[kFLAGS.ARIAN_ANAL_XP] <= 100) {
		outputText("\n\nArian blushes.  \"<i>I'm... I like it when you use my ass... it feels really good,</i>\" Arian admits.");
		outputText("\n\nOh, really?  You ask.  It's rare to find someone who actually enjoys anal sex, much less someone willing to admit it openly.  This is something you certainly didn't expect from the shy lizan.");
		outputText("\n\nArian bites [Arian eir] lower lip and smiles nervously at you.  \"<i>I guess that makes me a pervert for liking it?</i>\"");
		outputText("\n\nYou chuckle.  Maybe... considering the things you've seen in this world, you'd be hard pressed to find what kind of rule defines a pervert.  But that doesn't matter; you enjoy using [Arian eir] ass too.  Arian smiles at you.");
	}
	else {
		//Anal is definitely what Arian prefers, although [Arian ey] likes other stuff too, [Arian ey] prefers anal.
		outputText("\n\nArian blushes and averts [Arian eir] eyes.  \"<i>I can't stop thinking about when you use my ass... it feels really good... and if I had to say if there's anything I like... then it's that.... I hope it feels good for you, too.</i>\"  Arian smiles at you, nervously.");
		outputText("\n\nThat's... quite forward of [Arian em]... you didn't expect an admission like that.  But you like it; [Arian eir] ass certainly feels good, and you're glad it is pleasurable and that Arian likes it so much.");
		outputText("\n\nArian takes a glance at your crotch.");
		
		//if PC has no cock)
		if (!player.hasCock()) {
			outputText("\n\nBut sighs in disappointment when [Arian ey] sees no bulge.  \"<i>Maybe... you could grow your dick back and... nevermind....</i>\"  Arian averts [Arian eir] eyes.");
			outputText("\n\nYou tell [Arian em] you'll think about it.");
		}
		else {
			outputText("\n\n[Arian Ey] smiles nervously at you and begins fidgeting.  \"<i>Perhaps... you'd like to... well... use me again?  Please?</i>\" Arian asks hopefully.");
			//[Yes][No]
			menu();
			addButton(0,"Yes",yesYouButtslutIllFuckYou);
			addButton(1,"No",goddamnitNoYouButtSlut);
			return;
		}
	}
	sexTalkFinish();
}

		
//[=Yes=]
private function yesYouButtslutIllFuckYou():void {
	clearOutput();
	outputText("How could you refuse such a request?  You tell [Arian em] to strip and get ready.");
	outputText("\n\nArian jumps to the task and eagerly strips, laying down in bed and swaying [Arian eir] tail back and forth as [Arian ey] waits for you to do the same.");
	//(Go to Give Anal)
	menu();
	addButton(0,"Next",giveArianAnal);
}

//[=No=]
private function goddamnitNoYouButtSlut():void {
	clearOutput();
	outputText("You apologize, but you really can't do that right now.  Arian looks a bit disappointed, but smiles at you all the same.  \"<i>Oh... okay.  Next time then?</i>\"");
	outputText("\n\nYou nod.");
	sexTalkFinish(false);
}

private function sexTalkFinish(newl:Boolean = false):void {
	if (newl) clearOutput();
	else outputText("\n\n");
	outputText("Satisfied with your little chat, you pat the lizan's head and excuse yourself, heading back to camp.");
	doNext(camp.returnToCampUseOneHour);
}

//Invite to Camp:
//Only available if ArianHealth == 100.
private function inviteArianToCamp():void {
	clearOutput();
	outputText("You ask the lizan if [Arian ey] still really wants to leave [Arian eir] comfortable home in the city and come out to live with you in your little camp in the wastelands?");
	outputText("\n\n\"<i>Of course I do!</i>\" Arian says enthusiastically.");
	outputText("\n\nWell, if [Arian ey] really wants to do that... though why [Arian ey] would want to do that escapes you... [Arian ey] can come and move in.  But [Arian ey] will need to bring [Arian eir] own tent and sleeping bag and stuff like that, you warn the overenthusiastic lizard-");
	if (flags[kFLAGS.ARIAN_COCK_SIZE] > 0) {
		if (flags[kFLAGS.ARIAN_VAGINA] == 0) outputText("man");
		else outputText("herm");
	}
	else outputText("woman");
	outputText(".");
	
	outputText("\n\n\"<i>Great! I'll pack up and we can go right away!</i>\" Arian announces happily.");

	//(Story Dialogue Links here.)
	outputText("\n\nArian opens a small closet and brings out a pair of small bags.  One of them is tightly closed and seems close to bursting, the other looks completely empty.  Arian takes a few neatly folded spare sets of clothes and gently packs them inside [Arian eir] bag, then turns and walks to [Arian eir] work desk where [Arian ey] picks up a few more trinkets and bags them all.");
	
	outputText("\n\nHaving done that, Arian grabs both bags in [Arian eir] hands and happily announces, \"<i>All done!</i>\"");
	outputText("\n\nYou look at the bags skeptically and ask what kind of joke the lizan is trying to pull over you.");
	
	outputText("\n\nArian looks at you in confusion.  \"<i>Joke?  What do you mean by joke?</i>\"");

	outputText("\n\n[Arian Ey] can't seriously expect you to believe that's all [Arian ey] intends on taking.");
	outputText("\n\nArian looks at [Arian eir] bags and shrugs.  \"<i>Everything I need is in here.  I packed some stuff in advance, plus a few more clothes and some things I've been working on.  It's really all I need, trust me.</i>\"  Arian smiles.");
	outputText("\n\nYou sigh softly, and resign yourself to having to come back and fetch the stuff [Arian ey] forgot in a day or so.  You tell [Arian em] to say goodbye to [Arian eir] apprentices; you're leaving now.");
	outputText("\n\nArian nods and tails you down the stairs towards the entryway.  \"<i>Boon!  Laika!</i>\"  Arian calls.  Within moments the twin ferrets present themselves, and upon seeing the bags in Arian's hands Boon smiles and Laika begins tearing up.");
	outputText("\n\nArian drops [Arian eir] bags and opens [Arian eir] arms, inviting the twins into a hug, which they happily accept.");
	outputText("\n\n\"<i>I'm happy for you, " + arianMF("master","mistress") + ", I really am,</i>\" Boon says.");
	outputText("\n\n\"<i>Make sure you're taking care of yourself, " + arianMF("master","mistress") + ".  Don't forget to bathe regularly and eat well... and contact us once in awhile... and visit on the holidays,</i>\" Laika says, sniffing.");
	
	outputText("\n\nArian smiles at [Arian eir] pupils.  \"<i>I'm not your " + arianMF("master","mistress") + " anymore.  From now on you're full-fledged mages.  Remember all that you learned, and I'm sure you'll be okay.</i>\"");
	outputText("\n\nBoon is the first to break the hug, followed shortly by Laika.  The twins then turn to you.");
	
	outputText("\n\n\"<i>Please, [name], take good care of the " + arianMF("mas","mis") + "... err... Arian.  [Arian Ey] might be a handful sometimes, but [Arian ey]'s a really good person,</i>\" Boon says with a bow.");
	
	outputText("\n\n\"<i>If " + arianMF("master","mistress") + "... I mean... if Arian gives you any trouble call us and we'll come running to give [Arian em] a good scolding,</i>\" Laika says with a bow.");
	outputText("\n\n\"<i>Please don't sic Laika on me!</i>\" Arian pleads.");
	outputText("\n\nYou smile and laugh softly at the three; they really are just like family, aren't they? You promise that you'll take good care of their teacher and that you'll call them if [Arian ey] needs them to spank [Arian em].");
	
	outputText("\n\n\"<i>Come on, I'm not that bad, am I?</i>\" Arian protests.  Boon and Laika look at each other, then look at you, wearing expressions identical to your own.  Finally you all nod in unison.  Arian sighs....");
	outputText("\n\nHaving said your farewells, you begin the long trek back home... bringing with you a new ally (and lover) in tow.");
	menu();
	addButton(0,"Next",takeYerLizardHomePartII);
}

private function takeYerLizardHomePartII():void {
	clearOutput();
	outputText("Upon arriving at the camp, the first thing Arian notices is the shimmering portal.  \"<i>Is this... where you came from?</i>\" Arian asks.");
	outputText("\n\nYou nod your head and confirm that, yes, this was your doorway from your world into Mareth.");
	outputText("\n\n\"<i>I heard that sometimes people from other worlds wandered into Mareth through portals, but I have never seen one up close before.</i>\"  Arian stares deeply at the portal.  \"<i>It's beautiful... and menacing, too.</i>\"  Shaking [Arian em]self out of [Arian eir] reverie, Arian takes an open spot close to your ");
	if (flags[kFLAGS.CAMP_BUILT_CABIN] > 0) outputText("cabin.  \"<i>That's some nice cabin you've got here,</i>\" Arian says.  You thank him for the appreciation.");
	else outputText("tent.");
	outputText("\n\n[Arian Ey] sets [Arian eir] overfull bag down and asks, \"<i>Is it okay if I stay here?</i>\"");
	outputText("\n\nYou tell the reptilian wizard that should be fine.  But surely even someone with [Arian eir] scaly hide can't just sleep out in the open on bare earth?");
	outputText("\n\nArian laughs.  \"<i>Of course not, silly.  I'm going to set up my own tent here.</i>\"");
	outputText("\n\nTent? You repeat.  You tell [Arian em] that you never saw [Arian em] bring a tent here.");
	outputText("\n\n\"<i>Oh, I see... you might want to take a step back then,</i>\" Arian warns you with a wry smile.");
	outputText("\n\nYou wonder what the weird wizard has in mind, but do as [Arian ey] says; you're not stupid enough to ignore a warning like that.");
	outputText("\n\nArian snaps [Arian eir] fingers and the overfull bag bursts into an explosion of cloth.  You watch in amazement as a rather simple yet sturdy tent erects itself without any help.  It takes only a minute or so until the tent is set up in its appropriate spot, a small tarp covering the opening that leads inside.");
	outputText("\n\n\"<i>In case you have forgotten, [name], I happen to be a master mage,</i>\" Arian says with a proud smile.");
	outputText("\n\nYou look at the surprise tent and shake your head.  Truly, you hadn't forgotten... but you didn't know magic could be used for something as mundane as this.  [Arian Ey] really surprised you this time.");
	outputText("\n\nArian slowly walks towards the entrance and holds the tarp for you.  \"<i>Care to take a peek inside?</i>\"  You nod and follow the lizan into the tent.");
	
	outputText("\n\nAs you walk inside you can't help but gasp in amazement... clearly you have underestimated the lizan.  The inside of the tent is pretty big comparing to the outside, and you see all the tools and facilities one would need to live in the wilderness with relative comfort.");
	
	outputText("\n\nIn one corner you see what looks like a small kitchen of sorts, complete with a wide assortment of utensils.  In the opposite corner you see a work desk much like the one Arian had set up in [Arian eir] house.  Sitting in the middle of the room is a comfy-looking couch with a small table in front of it.  Further inside you see a comfortable looking bed with a few bookshelves and a small wardrobe sitting nearby.  A soft rug covers the floor of the tent and looking up you see what looks like a small magic lamp, lighting up the whole tent so you can clearly see how comfortable Arian is going to be compared to you");
	if (camp.followersCount() > 1) outputText(" and your other companions");
	outputText(".");
	
	outputText("\n\n\"<i>So what do you think?  Cozy?</i>\" Arian asks.");
	outputText("\n\nYou tell [Arian em] it looks very cozy indeed.  ");
	if (flags[kFLAGS.CAMP_CABIN_FURNITURE_BED] <= 0) outputText("In fact, you jest, you just might bring your sleeping roll in here and sleep with the lizan instead of in your own tent.  Arian averts [Arian eir] eyes and then smiles at you nervously.  \"<i>T-there's no need for you to bring your sleeping bag.... </i>");
	else outputText("\"");
	outputText("<i>If you want to stay in here I'd be happy to share my bed with you.</i>\" ");
	if (flags[kFLAGS.CAMP_CABIN_FURNITURE_BED] <= 0) outputText("\n\nYou tell the lizan it was just a jest... still, you drawl, you'll keep that in mind. ");
	outputText("Maybe you will drop by some night.");
	
	outputText("\n\nArian nods.  \"<i>You're always welcome here whenever you want.</i>\"");
	
	outputText("\n\nYou politely excuse yourself, saying you should let the lizan make [Arian emself] comfortable in [Arian eir] new home, and step back outside.");
	//flag arian as follower
	flags[kFLAGS.ARIAN_FOLLOWER] = 1;
	doNext(camp.returnToCampUseOneHour);
}

//Sex
//ArianHealth must be at least 20 before you can even pick Sex as an option.
private function arianSexMenu(output:Boolean = true):void {
	if (output) {
		clearOutput();
		outputText("You ask Arian if [Arian ey] feels strong enough to do a little lovemaking.");
		//(if ArianHealth < 30)
		if (flags[kFLAGS.ARIAN_HEALTH] < 30) {
			outputText("\n\nArian smiles nervously at you.  \"<i>I... of course.  I'd love to.  What do you feel like doing?</i>\"");
		}
		else if (flags[kFLAGS.ARIAN_HEALTH] < 50) {
			outputText("\n\nArian smiles nervously and averts [Arian eir] eyes.  \"<i>Of course.  I want to learn more about you: your body, your thoughts, everything.  So... what do you want to do?</i>\"");
		}
		//(if ArianHealth < 75)
		else if (flags[kFLAGS.ARIAN_HEALTH] < 75) {
			outputText("\n\nArian smiles and averts [Arian eir] eyes.  \"<i>I would love to.  This isn't just thanks for my gift is it?</i>\"");
			outputText("\n\nYou assure [Arian em] that's not the case; you just feel in the mood.");
			outputText("\n\nArian looks at you happily.  \"<i>Okay... what do you feel like doing?</i>\"");
		}
		//(if ArianHealth < 100)
		else if (flags[kFLAGS.ARIAN_HEALTH] < 100) {
			outputText("\n\nArian smiles tenderly at you.  \"<i>I always have enough strength for lovemaking, [name].  What do you feel like doing?</i>\"");
		}
		//(if ArianHealth == 100) //Also used for follower Arian.
		else {
			outputText("\n\nArian smiles and strokes your [face].  \"<i>Do you even need to ask?</i>\"");
		}
		outputText("\n\nYou smile at your lizan lover and begin shedding your [armor].  Arian follows in suit, settling down on [Arian eir] bed and watching you enraptured as [Arian ey] awaits your decision.  Once you're naked, much to the lizan's delight, you smile at [Arian em] and consider your options....");
	}
	//(Display Options)
	menu();
	if (player.hasCock()) {
		//PC must have a cock that fits (cock area 50 or less)
		if (player.cockThatFits(50) >= 0) addButton(0,"Anal - Pitch",giveArianAnal);
		//Get Blown:
		//PC must have a cock.
		addButton(2,"Get Blown",getBlownByArian);
		//Penetrate:
		//Arian must be herm/female.
		//PC must have a cock that fits (cock area 50 or less)
		if (player.cockThatFits(flags[kFLAGS.ARIAN_CAPACITY]) >= 0 && flags[kFLAGS.ARIAN_VAGINA] > 0) 
			addButton(4,"Fuck Vagina",penetrateArian);
		//Double Pen Arian:
		//PC must have at least 2 cocks that fit. That means two cocks with a cock area of <= 50.
		//This isn't meant to give AnalXP, but given the fact that Arian's ass will get pen'd it would also be justified. Up to you Fen!
		if (player.cockThatFits(50) >= 0 && player.cockThatFits2(50) >= 0 && flags[kFLAGS.ARIAN_VAGINA] > 0) addButton(8,"Double Pen",doublePenetrateArian);
		//Docking
		//ArianCockSize needs to be below 3. (ArianDblCock does not affect this decision.) 
		//PC cock area must be <= 30.
		if (player.smallestCockArea() <= 30 && flags[kFLAGS.ARIAN_COCK_SIZE] < 3 && flags[kFLAGS.ARIAN_COCK_SIZE] > 0) addButton(7,"Docking",arianDocking);
	}
	//Get Anal:
	//Arian must have a cock.
	if (flags[kFLAGS.ARIAN_COCK_SIZE] > 0) addButton(1,"Anal - Catch",getButtWreckedByArian);
	//Blow:
	//Arian must have a cock.
	if (flags[kFLAGS.ARIAN_COCK_SIZE] > 0) addButton(3,"Blow " + arianMF("Him","Her"),suckAriansDick);
	
	//PC must have a vagina.
	if (player.hasVagina()) {
		//Get Penetrated:
		//Arian must have a cock.
		if (flags[kFLAGS.ARIAN_COCK_SIZE] > 0) addButton(5,"Get Fucked",getPenetratedByArianAndHisHitlerMustache);
		if (flags[kFLAGS.ARIAN_VAGINA] > 0 && (player.hasKeyItem("Dildo") >= 0 || player.hasKeyItem("Deluxe Dildo") >= 0)) {
			addButton(6,"Dildo Fun",arianDildoFun);
		}
	}
	addButton(14,"Back",arianHomeMenu);
}

//Give Anal:
//Modified by AnalXP.
//PC must have a cock that fits (cock area 50 or less)
private function giveArianAnal():void {
	var x:int = player.cockThatFits(50);
	clearOutput();
	arianHealth(3);
	flags[kFLAGS.ARIAN_ANAL_XP] += 10;
	if (flags[kFLAGS.ARIAN_ANAL_XP] >= 100) flags[kFLAGS.ARIAN_ANAL_XP] = 100;
	flags[kFLAGS.ARIAN_VIRGIN] += 1;
	if (arianMF("m", "f") == "f")
		outputText(images.showImage("arianfemale-home-giveArianAnal"));	
	else	
		outputText(images.showImage("arianmale-home-giveArianAnal"));	
	
	// This breaks the capacity-restriction, but it's a quickfix to make the scene stop crashing in lieu of writing new 
	// content to work around the player not being able to call this scene from earlier interactions with Arian.
	if (x == -1)
	{
		x = player.smallestCockIndex();
	}
		
	outputText("You tell Arian that, if [Arian ey]'s willing, you'd like to take [Arian em] from behind.");
	//AnalXP < 33
	//Tight, sensitive enough to orgasm. (It hurts... but feels good)
	if (flags[kFLAGS.ARIAN_ANAL_XP] < 33) {
		outputText("\n\n[Arian Ey] fidgets, biting [Arian eir] lower lip.  \"<i>I... okay.  J - Just be gentle, ok?  I'm still tight back there.</i>\"  Arian hesitantly rolls onto [Arian eir] hands and knees, lifting [Arian eir] tail out of the way to give you a glimpse of [Arian eir] puckered hole.");
		outputText("\n\nYou promise [Arian em] that you will, sidling yourself onto [Arian eir] bed behind [Arian em].  You reach out with one hand and stroke the base of [Arian eir] tail, gently admiring its cool, smooth-textured surface before running your hand down to rub across [Arian eir] asscheeks.  Mmm... [Arian ey] has a very nice ass, you tell [Arian em], groping [Arian em] in an effort to display your admiration for the lush, full, surprisingly soft cheeks.  Yes, for someone who was born male, [Arian ey] truly has a wonderful ass, so deliciously full and round and soft.");
		//(if ArianVagina < 1)
		if (flags[kFLAGS.ARIAN_VAGINA] < 1) {
			outputText("\n\n\"<i>I - I can't help it, I was born this way... that isn't a bad thing is it?</i>\" Arian asks, fidgeting and shuddering as you stroke [Arian eir] behind.  From [Arian eir] tone, it's clear that [Arian ey]'s torn between being flattered and being embarrassed at your evident approval of [Arian eir] butt.  You don't bother answering [Arian eir] question, instead you just firmly grip [Arian eir] scaly buttcheek, eliciting a gasp from the flustered lizan.");
		}
		else {
			outputText("\n\n\"<i>Y - Yes... I was born like this... and being a ");
			if (flags[kFLAGS.ARIAN_COCK_SIZE] == 0) outputText("girl");
			else outputText("herm");
			outputText(" isn't going to make it any smaller either.</i>\"  Arian fidgets and shudders as you stroke [Arian eir] behind.");
		}
		outputText("\n\nYou tell [Arian em] that you don't know why [Arian ey] was born with it, but you certainly appreciate it.  Your wandering eyes close in on ");
		if (flags[kFLAGS.ARIAN_VAGINA] > 0) {
			outputText("the puffy lips of [Arian eir] drooling vagina");
			if (flags[kFLAGS.ARIAN_COCK_SIZE] > 0) outputText(" and ");
		}
		if (flags[kFLAGS.ARIAN_COCK_SIZE] > 0) {
			outputText(arianMF("his","her") + " erecting ");
			if (flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText("pair of reptilian pricks");
			else outputText("reptilian prick");
		}
		outputText(".  Oh, someone's excited about this.  Why, you almost half expect [Arian eir] ass to start drooling like a pussy, [Arian ey]'s obviously that turned on by the idea of you fucking [Arian eir] ass.  You emphasize your point by gently worming one probing finger into the virgin-like tightness of [Arian eir] anus.  Wow, [Arian ey]'s so tight....");
		
		outputText("\n\n\"<i>Ow!  B-be gentle... please,</i>\" Arian protests, but despite that you feel [Arian em] gently pushing against your intruding digit.  You tell [Arian em] that you'll try, but [Arian ey] is making this hard on you; [Arian ey]'s so eager for you to start fucking [Arian eir] ass, isn't [Arian ey]?  It's hard to control yourself when [Arian ey]'s just begging for it.  You gently grind your [cock] under the base of [Arian eir] tail, in between [Arian eir] girly asscheeks, to emphasize your point.");
		
		outputText("\n\n\"<i>I... yes....  I-I want it, too.  It's going to hurt, but I want it.... I-I want you to do it,</i>\" Arian admits, burying [Arian eir] face in the covers in an attempt to hide [Arian eir] shameless admission.  [Arian Ey] braces [Arian em]self, holding [Arian eir] pillow tightly in [Arian eir] clawed hands and bracing [Arian em]self for the next step.");
		
		outputText("\n\nYou begin jerking yourself off, using slow, careful strokes to bring precum dribbling from your cock, smearing it across your shaft in an effort to lube it for your lizan lover.  Finally deciding you've made yourself slick enough, unable to resist making your move, you take hold of [Arian eir] butt for support and begin pushing your " + player.cockDescript(x) + " against [Arian eir] virginal back door.  Arian lets out a girly yelp and [Arian eir] sphincter suddenly clenches up, halting your entry.  You ask what's wrong.");
		outputText("\n\n\"<i>N-nothing... you just surprised me... that's all.</i>\"  Even though [Arian ey]'s not admitting it, you can tell that Arian is very tense.  You lean over the nervous lizan and envelop [Arian em] in a soft hug, telling [Arian em] it's okay; you're not going to hurt [Arian em], you're going to make [Arian em] feel very good, but first [Arian ey] needs to relax or this will be painful when it shouldn't be.");
		
		outputText("\n\nArian sighs and relaxes, loosening [Arian eir] sphincter enough to allow an easier penetration.  You don't risk delaying any more and promptly, but carefully, slide yourself into [Arian em] before [Arian ey] can tense up again.  Damn, but [Arian ey]'s so tight back here!  You have to push hard to make any progress, and it takes a lot of care to ensure you don't hurt the lizan in your press to penetrate [Arian eir] bowels.  \"<i>Ah!  It's in!</i>\"  Arian shudders, struggling to remain relaxed while you plow into [Arian eir] depths.  Finally, after a few more careful thrusts, you feel yourself bottom out in your shuddering lizan lover.");
		
		outputText("\n\nArian trembles and moans in pained pleasure as [Arian ey] finally feels your [hips] resting flush against [Arian eir] backside.  [Arian Ey] pants in obvious pleasure as [Arian eir] watertight little rosebud adjusts to your girth and length.  \"<i>H-how does it feel?  G-good?</i>\"");
		
		outputText("\n\nYou tell [Arian em] that it feels wonderful; [Arian ey]'s so tight and firm back here... to be honest, [Arian ey]'s almost too tight; you can feel [Arian eir] heartbeat with every involuntary contraction of [Arian eir] anal walls, squeezing your cock like it's trying to wring it off and swallow it.  Arian chuckles.  \"<i>I'm not going to lie, [name].  It hurts, but it also feels good.  I think... maybe you should start moving?</i>\"");
		
		outputText("\n\nOh, and suddenly [Arian ey]'s an expert on this, hmm?  You agree [Arian ey] has a point.  You start to withdraw yourself from [Arian em], fighting against the squeezing walls and intense suction all the way, then painstakingly pushing yourself back in, worming your way in inch by inch until you have plunged yourself all the way into [Arian eir] depths, only to start again.  Arian moans and groans with each movement.  \"<i>It's starting to feel good now... really good.  Don't stop.</i>\"");
		
		outputText("\n\nTime fades away as you continue to squeeze your shaft in and out of Arian's tight, delicious little ass.  Soon - all too soon - the unmistakable feeling of orgasm starts boiling up from ");
		if (player.balls == 0) outputText("the base of your cock");
		else outputText("the bottom of your balls");
		outputText(" and you warn Arian that you're going to cum inside [Arian em] if you keep going.  Arian drools in pained pleasure, for a moment you wonder if [Arian ey] even heard you.  \"<i>Cum.  Cum inside me.  I want it... all of it! Ah!</i>\"");
		
		outputText("\n\nYou groan and cry out as you promptly fulfill [Arian eir] request.");
		
		//(Low Cum Amount)
		if (player.cumQ() < 250) {
			outputText("\n\nEven though your load might pale in comparison to other creatures native to Mareth, you have no doubt that you're more than enough to fill Arian's tight ass flush with cum.  You unload inside [Arian em] with short, controlled thrusts.");
		}
		//(Medium Cum Amount)
		else if (player.cumQ() < 1000) {
			outputText("\n\nYou begin dumping your prodigious amount of cum inside your willing lizan lover.  The more you unload into [Arian eir] tight ass the more pleasurable [Arian eir] slick muscle spasms feel, milking you for more and more cum, such a lewd little hole this puckered rosebud of Arian's.  You sigh as [Arian eir] belly inflates and some of your spent seed begins dripping from around Arian's little hole.");
		}
		//(High Cum Amount)
		else {
			outputText("\n\nFor a moment you hesitate....  Arian is clearly inexperienced and you know your load is nothing if not enormous; you worry if the inexperienced lizan will be able to handle you, but your worries are soon forgotten; it's much too late to worry about it now.  Your spunk jets inside the moaning lizan like a fire hose, dowsing both your and [Arian eir] flames of lust with its immense output of white, creamy goodness.  Arian's belly protrudes like a gravid woman's belly - no, actually, it's even wider, and yet the lizan's lewd little hole never tires as it milks you, even though by now Arian is beyond full - copious amounts of cum leak from around your " + player.cockDescript(x) + " as [Arian eir] ass fails to contain it all.");
		}
		outputText("\n\nYour orgasm triggers the lizan's own, and [Arian ey] bites into the pillow, groaning with ecstasy as [Arian ey] cums [Arian em]self, ");
		if (flags[kFLAGS.ARIAN_COCK_SIZE] > 0) outputText("spewing forth large gobs of cum of [Arian eir] own");
		if (flags[kFLAGS.ARIAN_COCK_SIZE] > 0 && flags[kFLAGS.ARIAN_VAGINA] > 0) outputText(" and ");
		if (flags[kFLAGS.ARIAN_VAGINA] > 0) outputText("wetting both your and [Arian eir] legs with a healthy serving of lizan pussy juice");
		outputText(".  You shudder and gasp until, utterly spent, you can't resist sinking down atop Arian and bearing [Arian em] into the comforting embrace of the bed.  You lay there, recovering your strength from your most delightful exertions, wriggling to give the lizan a proper snuggling while you lay there.");
		
		outputText("\n\nArian pants tiredly.  \"<i>[name], was I any good?</i>\" [Arian ey] asks hopefully.");
		
		outputText("\n\nYou tell [Arian em] that [Arian ey] was wonderful, though you can't resist a wry smirk and a note that [Arian ey] was wonderful for an amateur.  With a little practice though, well....");
		
		outputText("\n\nArian turns [Arian eir] head to look at you with a tired, but happy smile.  \"<i>I'm glad you liked it.  It hurt, and I'll probably be sore later.... But it was worth it.  I liked it....</i>\"  Then [Arian ey] laughs.  \"<i>If all I need is some practice, I'm hoping you will help me with that?</i>\"");
		
		outputText("\n\nYou laugh and reply that you'll consider it, but right now you're quite sated, thank you.  \"<i>Great....</i>\"  Arian's maw opens into a huge, lazy yawn.  \"<i>I think I'll take a nap now....</i>\"");
		outputText("\n\nYou pat the lizan playfully on the head and tell [Arian em] to get some rest.  You watch as [Arian ey] settles down to sleep off the excitement of your sex, then carefully redress yourself and leave [Arian em] to rest.");
		//PC returns to camp menu
	}
	//AnalXP < 66
	//Loose, sensitive enough to make Arian scream in pleasure. (It's like a tight vagina, feels like one too, minor pain)
	else if (flags[kFLAGS.ARIAN_ANAL_XP] < 66) {
		outputText("\n\n[Arian Ey] fidgets, smiling at you nervously.  \"<i>Okay, but don't be too rough.  I might have gotten a bit used to it, but you're still capable of giving me quite a stretch.</i>\"  Arian rolls onto [Arian eir] hands and knees, tail waving excitedly as you catch a glimpse of [Arian eir] stretched hole.  [Arian Ey] looks back at you, shooting you [Arian eir] best seductive look and wiggling [Arian eir] hips side to side.");
		outputText("\n\nYou smile at [Arian em] and gently stroke [Arian eir] swaying tail.  Arian sighs and lays down on the bed, reaching behind with [Arian eir] hands to spread [Arian eir] buttcheeks apart for you; [Arian eir] tail strokes your side lovingly.  Your hands reach down and gently bat [Arian eir] hands away, then begin to caress [Arian eir] luxurious ass, even as you tell [Arian em] that [Arian ey]'s got a very sexy rear and you're going to enjoy fucking [Arian eir] back passage oh so very much.");
		outputText("\n\nArian raises [Arian eir] behind, giving you better access, then looks at you with a glimmer in [Arian eir] eyes.  \"<i>I'm going to enjoy this, too.</i>\"");
		
		outputText("\n\nYou slick your fingers up with some saliva, noisily smacking your tongue around the digits to make it as lewd as possible, and then gently start to probe at Arian's black pucker, seeking entry in an effort to gauge how stretched [Arian ey] is.  Your digits slide in easily enough, meeting only a token resistance as you slowly invade Arian's bowels.\n\n\"<i>Ah... this feels good....</i>\"\n\nYou raise an eyebrow, though you know [Arian ey] can't really see you from this position, and ask if [Arian ey]'s really getting to be such a buttslut that even this feels good?");
		outputText("\n\nArian turns as much as [Arian ey] can to look at you.  \"<i>Lizan females have assholes that are as sensitive as vaginas to accommodate their mate's dual penises.</i>\"  [Arian Ey] stops [Arian eir] explanation momentarily to moan in pleasure as you begin stroking [Arian eir] insides.");
		//(if ArianVagina < 1)
		if (flags[kFLAGS.ARIAN_VAGINA] < 1) {
			outputText("\n\n\"<i>This shouldn't apply to me, since I'm male.  Ah!  But I guess I'm starting to develop some sensitivity back there.  It really feels good... hmm....</i>\"");
			outputText("\n\nYou smile and comment that you wouldn't be surprised; if it's natural for [Arian eir] kind to enjoy taking it up the ass, well, it makes sense that a male would quickly grow to like it, too... especially with all the practice the two of you have been doing....");
		}
		else {
			outputText("\n\n\"<i>This didn't apply to me, since I was originally male.  Ah!  B-but I guess since I'm a girl now, I'm starting to develop some sensitivity back there.  It really feels good....  Hmm....</i>\"");
			outputText("\n\nYou smile and comment that since [Arian ey]'s a girl now, should [Arian eir] ass have gotten the sensitivity boost by default if that's the case?");
			outputText("\n\n\"<i>I don't know... maybe so... but then again, lizan females don't have these either,</i>\"  Arian replies, lifting herself off the mattress to show you [Arian eir]");

			if (flags[kFLAGS.ARIAN_BREASTS] == 1) outputText(" perky");
			else if (flags[kFLAGS.ARIAN_BREASTS] == 2) outputText(" rounded");
			else outputText(" pillowy");
			outputText(" mounds.");
			
			outputText("\n\nYou can't resist sneaking an admiring grope of the lizan's presented bosom, admitting that gaining breasts in exchange for anal affinity sounds like a fair trade, but you aren't complaining about Arian's bust either.  Arian gasps and drops chest-first onto the bed.  \"<i>They are sensitive, too.</i>\"  Arian smiles nervously at you.");
		}
		outputText("\n\nYou sneak a probing hand under and up between Arian's legs.  Oh ho!  You grin as");
		if (flags[kFLAGS.ARIAN_COCK_SIZE] > 0) {
			outputText(" a");
			if (flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText(" pair of dripping cocks");
			else outputText(" dripping cock");
			if (flags[kFLAGS.ARIAN_VAGINA] > 0) outputText(" and");
		}
		if (flags[kFLAGS.ARIAN_VAGINA] > 0) outputText(" a sopping wet pussy");
		outputText(" greet");
		if ((flags[kFLAGS.ARIAN_VAGINA] == 0 && flags[kFLAGS.ARIAN_DOUBLE_COCK] == 0) || (flags[kFLAGS.ARIAN_VAGINA] == 1 && flags[kFLAGS.ARIAN_COCK_SIZE] == 0)) outputText("s");
		outputText(" your touch.  What a little slut Arian is turning into; [Arian ey]'s already raring to go, and even knowing it's going to be [Arian eir] ass that's getting fucked, too!");
		
		outputText("\n\nArian pants and moans.  \"<i>[name], please. Stop teasing me.  I want you.</i>\"  [Arian Ey] looks back at you with eyes full of desire.  [Arian Ey] humps against your intruding fingers in [Arian eir] ass in obvious excitement.");
		
		outputText("\n\nWell, if [Arian ey]'s that eager to get started....  You deliver a playful slap on [Arian eir] ass, which ripples delightfully at the impact and sends a crack echoing through the lizan's ");
		if (arianFollower()) outputText("tent");
		else outputText("bedchamber");
		outputText(".  You sink your fingers into the smoothly scaled skin of [Arian eir] butt, and promptly thrust your " + player.cockDescript(x) + " into [Arian eir] back passage; not with the gentleness you showed Arian as an anal virgin, but not with brutal force, either.  The practice the lizan's had with pleasuring your cock with [Arian eir] ass is obvious - you slide in as if it's been lubed, with what little resistance it poses quickly giving way under the insistent pressure of your thrusts.  It's not as painfully tight as it was, the looseness letting you move more freely without fear of hurting your lover, but at the same time it grips you like a well-trained pussy, holding you deliciously tight and eagerly sucking you into its depths.");
		
		outputText("\n\nArian moans lewdly at your intrusion.  \"<i>Ah, I can feel you inside me.  I love this feeling... so full....  Do you like my ass, [name]?  Does it feel good when you use me like this?</i>\"");
		
		outputText("\n\nYes, you hiss, yes it feels good... does [Arian ey] really enjoy this so much?  You never stop your thrusts, relentlessly pounding into [Arian eir] greedy little ");
		if (flags[kFLAGS.ARIAN_VAGINA] < 1) outputText("boypussy");
		else outputText("nether-pussy");
		outputText(".  \"<i>Yesssss.... Oh, sometimes it hurts a bit, but the feeling, the pleasure, the pain.... It's heavenly.</i>\"");
		outputText("\n\nSmiling wryly, you lean over Arian's back and whisper into [Arian eir] ear, that if [Arian ey] likes this so much... you'll just have to fuck [Arian em] more.  Having said that, you quicken your pace, drawing a pleasured, shuddering moan from your lizan lover.  \"<i>Ah!  [name]!  If you keep this up you're going to make me - Ah!</i>\"  Make [Arian em] what now?  \"<i>C-cuuuuum~</i>\"");
		
		outputText("\n\nArian's ass tightens around your " + player.cockDescript(x) + " as [Arian eir] ");
		if (flags[kFLAGS.ARIAN_COCK_SIZE] > 0) {
			if (flags[kFLAGS.ARIAN_DOUBLE_COCK] == 0) outputText("cock spews its load");
			else outputText("twin cocks spew their loads");
			outputText(" on the bedsheets");
			if (flags[kFLAGS.ARIAN_VAGINA] > 0) outputText(" and [Arian eir] ");
		}
		if (flags[kFLAGS.ARIAN_VAGINA] > 0) outputText(" contracting pussy paints your lower body with lizan femcum");
		outputText(".  Arian is only capable of moaning and shuddering as [Arian eir] powerful orgasm rocks the poor lizan to [Arian eir] core.  The extra tightness of [Arian eir] contracting butthole increases the friction on your " + player.cockDescript(x) + ", pushing you ever closer to the climax.");
		
		outputText("\n\nSeeing no point in holding back yourself, you cry out as you give yourself over to the feeling of climax, orgasm ripping its way through you from the ");
		if (player.balls == 0) outputText("base of your spine");
		else outputText("depths of your balls");
		outputText(".  Arian, completely blissed out, lays limply on [Arian eir] bed, [Arian eir] butt held up by your gripping hands.  With a final deep thrust you finally go over the edge.");
		
		//(Low Cum Amount)
		if (player.cumQ() < 250) outputText("\n\nYou pump Arian's insides with as much cum as you can muster, filling [Arian em] with your liquid love while the lizan gasps, moans, and grips you tightly with [Arian eir] distended sphincter.  You are quickly spent though, and after a couple more tugs, you feel the lizan's contracting rosebud relax to let you pull out of [Arian eir] depths.");
		//(Medium Cum Amount)
		else if (player.cumQ() < 1000) outputText("\n\nArian's butt feels so good that you can't help but paint it in white.  Gob after gob of searing hot cum flows from your " + player.cockHead(x) + " and into the lizan's willing bowels.  You can't help but continue thrusting inside [Arian eir] deliciously slick insides, even as Arian's distended sphincter tries its best to hold you in place.  By the time you're done, Arian looks like [Arian ey]'s three months pregnant; after a few final thrusts, you're confident you've given [Arian em] all that you can muster for the moment and pull out of the lizan's hungry ass.");
		//(High Cum Amount)
		else {
			outputText("\n\nYou bury yourself as deep as you can into the lizan's behind and brace yourself, holding onto [Arian eir] hips as the first of many jets of cum finally escapes your throbbing " + player.cockDescript(x) + ".  You can feel the groaning lizan shudder with each blast that you pump into [Arian eir] inviting interior; each of your sticky ropes of cum filling [Arian em] up until [Arian eir] belly looks as big as a beach ball.  Arian's contracted sphincter tries its best to hold your prodigious load in, but it can't hope to contain it all; soon white jism explodes from around the seal of your cock.  Trails of your pleasure run down the lizan's legs to soak the bedsheets along with the lizan's own fluids.  One final jet pushes Arian off your shaft, and you gaze at the messy results of your recent activities.");
		}
		
		outputText("\n\nFor a moment you admire your handiwork, but all too soon the exhaustion of your recent tryst catches up to you and you collapse atop the lizan, almost as blissed out as [Arian ey] is....");
		
		outputText("\n\n\"<i>That... that was the best, [name].  I never hoped that sex could feel this good,</i>\" Arian remarks between pants.  Arian rolls around, looking at you with a smiling face, then yawns widely, displaying [Arian eir] sharp teeth to you.  \"<i>So sleepy... could use a nap now....</i>\"");
		
		outputText("\n\nYou smile and pet the lizan's head, telling [Arian em] that you wish you could understand how a talking lizard could be just so adorable.  You watch [Arian em] as [Arian ey] drifts off to sleep, then quietly slide from [Arian eir] bed, get dressed and leave the ");
		if (!arianFollower()) outputText("room");
		else outputText("tent");
		outputText(".");
	}
	//AnalXP <= 100
	//Very Loose, sensitive enough to make Arian cum just from insertion. (Feels better than anything else. Yep, Arian really becomes a buttslut at this point)
	else {
		outputText("\n\n[Arian Ey] fidgets and moans as [Arian ey] eagerly rolls onto [Arian eir] hands and knees, lifting [Arian eir] tail out of the way and spreading [Arian eir] cheeks to give you a glimpse of [Arian eir] throbbing, loose, puckered hole.  Arian pants and looks back at you in excitement.  \"<i>I'm all ready for you, [name].  Just go ahead and fill me up.</i>\"  [Arian Ey] grins at you.  It's clear to see that Arian likes the idea of being taken, but there really is no need to rush... you'd rather savor this, plus teasing your eager lizan lover is always a bonus.");
		
		outputText("\n\nYou smirk fiercely and ask teasingly if this is really the proud, independent mage Arian lying before you with [Arian eir] tail in the air and [Arian eir] ass up, a buttslut yearning and anxious to be fucked like an animal.  Arian looks back at you, pleadingly.  \"<i>Aww, come on, don't tease me.  Can't you see how much I need this?</i>\"");
		
		outputText("\n\nHow much does [Arian ey] need it, you ask?  Enough to beg for it, like the little buttslut [Arian ey] is, hmm?  If [Arian ey] can convince you [Arian ey] wants it enough, you'll give it to [Arian em], you tell [Arian em].  Arian's tail encircles your waist, and pulls you towards [Arian eir] quivering rosebud.  \"<i>Come on... fill me up.  I'm so hot it feels like I'm on fire!  Fill me up, please?</i>\"");
		
		outputText("\n\nWhat a naughty, naughty little buttslut [Arian ey] is, you croon, and deliver a playful slap to [Arian eir] ass, before squeezing the luscious round buttock, fingers creeping into [Arian eir] crevice to probe at [Arian eir] back passage.  To your surprise, the slight pressure you're exerting makes [Arian eir] orifice ripple and flex; [Arian ey]'s trained [Arian eir] ass so well [Arian ey] can even try to deliberately grab you with it and suck you in.");
		
		outputText("\n\nArian moans and bucks against your fingers, eager to get more of you inside.  \"<i>Ah... yessss... more...</i>\"  [Arian Ey] groans.  Looking under [Arian em], you can see that [Arian eir] ");
		if (flags[kFLAGS.ARIAN_VAGINA] > 0) outputText("wet gash is positively leaking lizan juices");
		if (flags[kFLAGS.ARIAN_VAGINA] > 0 && flags[kFLAGS.ARIAN_COCK_SIZE] > 0) outputText(" and [Arian eir] ");
		if (flags[kFLAGS.ARIAN_COCK_SIZE] > 0) outputText("erect cock is already leaking pre like a sieve");
		outputText(".  You can hardly believe how far Arian has come; you ask [Arian em] if it really feels that good?  \"<i>More than you can... ah... imagine, now fill me up!</i>\" [Arian ey] demands with a sense of urgency.");
		
		outputText("\n\nSeeing no reason to delay any longer, and figuring [Arian ey] must be well-trained enough now that you don't need to be gentle, you promptly extract your fingers from the lizan's greedy ass and then slam your shaft home in one fierce thrust, asking if this is what [Arian ey] wanted.");
		
		outputText("\n\nArian gasps and opens [Arian eir] maw in a silent scream.  [Arian Eir] ass contracts, milking you; ");
		if (flags[kFLAGS.ARIAN_VAGINA] > 0) outputText("[Arian eir] pussy clenches, spilling a flood of juices; ");
		if (flags[kFLAGS.ARIAN_VAGINA] > 0 && flags[kFLAGS.ARIAN_COCK_SIZE] > 0) outputText(" and ");
		if (flags[kFLAGS.ARIAN_COCK_SIZE] > 0) outputText("his cock throbs and shoots rope after rope of cum onto the bedsheets");
		outputText(". Overwhelmed by your sudden intrusion, Arian collapses forward, burying [Arian eir] face on [Arian eir] pillow and dragging you on top of [Arian em].  \"<i>Ah... [name], you feel so good.  It's amazing.  I never thought buttsex could ever feel this good.</i>\"");
		
		outputText("\n\nYou almost blink in surprise; you were just throwing the term buttslut around as a joke, you didn't think Arian was really like that.  Still, there are far more important matters - like digging your way into the depths of Arian's greedy little ass with your " + player.cockDescript(x) + "!  You squeeze the lizan's scaly butt and begin to rut [Arian em] like an animal, thrusting your way in and out of [Arian eir] back passage with all the eagerness you can muster.");
		
		outputText("\n\nArian screams in pleasure, muffled by [Arian eir] pillow.  [Arian Eir] ass strives to pull you in as far as you can go, contracting, milking, gripping; even though Arian's just climaxed, you can see [Arian eir] ");
		if (flags[kFLAGS.ARIAN_COCK_SIZE] > 0) {
			if (flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText("cocks are still rock hard, and surprisingly, still leaking ropes of cum");
			else outputText("cock is still rock hard, and surprisingly, still leaking ropes of cum");
			if (flags[kFLAGS.ARIAN_VAGINA] > 0) outputText(", and [Arian eir]");
		}
		if (flags[kFLAGS.ARIAN_VAGINA] > 0) outputText(" pussy squirting juices against your [legs] with each shuddering impact of your [hips]");
		outputText(".  \"<i>Ah!  Yes!  More, give me more!  Harder!  Faster!</i>\" Arian pleads, before biting on [Arian eir] pillow in pleasure.");
		
		outputText("\n\nYou see no reason not to give it to [Arian em] how [Arian ey] wants, and keep thrusting - it's surprisingly difficult to pull out, though, as the lizan's hungry nethers keep trying to stubbornly hold you in.  Greedily [Arian eir] inner walls ripple and flex, caressing and squeezing in an effort to milk you into giving up your precious seed.");
		
		outputText("\n\nYou can feel the pressure on [Arian eir] sphincter increasing and guess Arian must be close to another orgasm; you're not very far yourself, and if [Arian ey] keeps squeezing and massaging your " + player.cockDescript(x) + " like this, you feel you'll blow any moment now.  Before you finally reach the inevitable abyss of your orgasm, you decide to lean over [Arian em], hugging [Arian eir] midriff just so you can pound [Arian em] harder.  It's surprising that Arian only seems to be feeling pleasure, others would be screaming in pain with how rough you're being, yet Arian bucks back against you with all [Arian eir] might, trying to get you deeper.  You ask [Arian em] if [Arian ey]'s really okay, if it doesn't hurt [Arian em] even a bit?");
		
		outputText("\n\n\"<i>No! Ah, yes!  Cum inside me, [name]!  I need your seed inside my naughty ass.  I need to feel you filling me up, using me like the buttslut I am!  I want to cum with you!</i>\"  You lift a brow, of all the people you know, Arian is the last one you'd expect to hear this from... what would [Arian eir] apprentices say if they heard their " + arianMF("master","mistress") + " begging to be used like that?  \"<i>Ah... I don't care, just fill me up with your hot, slimy spunk!</i>\"  It would seem the lizan mage is too far gone to give you a straight answer.  You'll have to talk to [Arian em] after this.");
		
		outputText("\n\nWith that in mind, you give yourself over to the pleasures of your reptilian lover and [Arian eir] naughty little ass, allowing the building orgasm to finally reach its climax and boil from your body in a gush of salty spooge.");
		
		//(Low Cum amount)
		if (player.cumQ() < 250) {
			outputText("\n\nYou spill your load, deep into Arian's bowels, [Arian eir] ass working overtime to ensure not even a single drop of seed is left in you.  \"<i>Ah!  I can feel it!  Yes!</i>\"  [Arian Ey] screams, in ecstasy.  Gob after gob of cum travels down your urethra and into Arian's blooming rosebud, you almost feel bad when you run dry and are unable to give [Arian em] anymore; even as [Arian eir] ass continues to impatiently milk you. \"<i>...Aww. No more?</i>\" [Arian ey] jokes.");
		}
		//(Medium Cum amount)
		else if (player.cumQ() < 1000) {
			outputText("\n\nYou dig deep into [Arian eir] ass, intent on delivering your load as far inside the lizan's slutty ass as you can.  \"<i>Ah!  You feel so good!  Give it to me!  Yesss!</i>\" [Arian ey] screams in ecstasy.  You can feel your cum travelling down your urethra, forcing Arian's sphincter to loosen up enough so you can finally cum inside [Arian em] with the force of hose.  You reach down to massage the blissed out lizan's belly, feeling it inflate and expand with each potent jet.  By the time you're done, Arian has formed a small pot belly.  \"<i>Already over?  No more?</i>\"  [Arian Ey] jokes.  You give [Arian em] a wry smile and pound into [Arian em] one last time, spilling one last jet into [Arian eir] belly.  \"<i>Aaaah, yesss...</i>\"");
		}
		//(High Cum amount)
		else {
			outputText("\n\nYou have no doubt Arian will appreciate your prodigious load, so you make sure to press as deep as you can into [Arian eir] ass to ensure [Arian ey] will keep it all inside, then finally let your cum flow out of you and into the cock and cum hungry ass, eagerly massaging your shaft.  \"<i>I can feel it!  It's going to be a big one!  Shoot it!</i>\" [Arian ey] screams in ecstasy.  You groan and begin dumping obscene amounts of seed into your lizan lover.  The first few jets inflate [Arian eir] belly slightly, and you dart a hand to feel it expand with every subsequent blast of sticky jism.  \"<i>So much cum!  So good... more!</i>\"  Arian demands, blissed out by your pumping appendage.  [Arian Eir] ass never stops its assault on your " + player.cockDescript(x) + " intent on massaging you as you orgasm, even as you fill Arian beyond full and some cum begins backflowing out of [Arian eir] ass.  \"<i>Hmm, yesss... so full....</i>\"  You pound into [Arian em] a few more times, ensuring you spill every last drop of cum.");
		}
		outputText("\n\nPleased and pleasured, Arian holds you still with [Arian eir] tail and rolls around on [Arian eir] back, your dick still buried inside [Arian em].  You gasp with the sudden friction and fall on top of the lizan, just in time to receive a kiss from your lizan lover.  [Arian Ey] grips you with both [Arian eir] hands and legs, then finally quakes as [Arian eir] second orgasm overtakes [Arian em].");
		if (flags[kFLAGS.ARIAN_VAGINA] > 0) {
			outputText("  [Arian Eir] cunt grips the air and blasts one last jet of wetness at your crotch.");
		}
		if (flags[kFLAGS.ARIAN_COCK_SIZE] > 0) outputText("  [Arian Eir] throbbing cock flexes and shoots one last rope of lizan-cum against your belly.");
		outputText("  [Arian Eir] ass grips you forcefully, forming a vacuum and finally loosens.  \"<i>That... that wash da best,</i>\"  Arian slurs, before finally collapsing on [Arian eir] bed.");
		
		outputText("\n\nYou find yourself collapsing on top of the collapsed lizan, heaving to regain your breath after such a vigorous fuck.  Finally, you regain sufficient energy to pull yourself free of the absent-minded sucking of [Arian eir] ass, which wetly slurps shut afterwards to hold your seed inside.  \"<i>I feel so empty when you're not inside,</i>\" Arian utters tiredly.");
		
		//(ArianAssChat == 0)
		if (flags[kFLAGS.ARIAN_ASS_CHAT] == 0) {
			outputText("\n\nYou shake your head slowly in disbelief, telling Arian [Arian ey]'s really let [Arian emself] go.  Arian averts [Arian eir] gaze in embarrassment.  \"<i>I... sorry.  It's just that it feels so good, and I can't... sorry.</i>\"  [Arian Ey] looks away, moving [Arian eir] tail into [Arian eir] hands. You sigh softly and stroke [Arian eir] scaly face, telling him it's not a bad thing that [Arian ey] enjoys himself, it's just you're surprised at how \"<i>into it</i>\" [Arian ey] gets.  [Arian Ey] doesn't need to debase himself for you, this is supposed to be good for both of you.");
			
			outputText("\n\n\"<i>I... I'm not really trying to debase myself.  I guess I lose a bit of control when it comes to anal, because it really feels that good for me.  You're not mad at for being like that... for liking being fucked from behind.  Are you?</i>\"");
			
			outputText("\n\nYou tell [Arian em] you certainly aren't; you were just making sure that [Arian ey] was really enjoying himself, that [Arian ey]'s not under the conception [Arian ey] has to act that way for you to do this to [Arian em].  Arian breaths a sigh of relief.  \"<i>No, I... sorry if my being like that offends you.  I thought you enjoyed it too, since you were teasing me, but maybe I should change?</i>\"");
			
			outputText("\n\nYou shake your head; [Arian ey] is who [Arian ey] is, and you're quite comfortable with it.  If you really didn't enjoy playing with [Arian em] like that, well, you'd stop sexing [Arian eir] ass, wouldn't you?  Arian bites [Arian eir] lower lip and smiles nervously at you. \"<i>So, you like my ass?</i>\"");
			
			outputText("\n\nYes.  Yes you do, you declare.  \"<i>Good, because I like you in my ass, so I don't have to change?</i>\"");
			
			outputText("\n\nYou still have to confess it was a shock that someone as respectable as Arian is would get so enthusiastically into anal - and on the receiving end, no less - but you don't want [Arian em] to change just for your sake.");
			
			outputText("\n\n\"<i>This is all new to me.  I'd never been with anyone before you came, so there is no problem if I act like... well, like that?  Because I could change if it really bothers you...</i>\"");
			

			outputText("\n\nNo, there's nothing about [Arian eir] behavior you want to change");
			//(any physical TFs made to Arian:
			if (9999 == 9999) outputText(" as hypocritical as that may be");
			outputText("... besides, you think [Arian ey]'s kind of sexy when [Arian ey] gets like that.  At that Arian perks up.  \"<i>Really?</i>\"  Yes, really, you reply.  Arian smiles happily at you.  \"<i>So... do you want to go again?</i>\"");
			
			outputText("\n\nYou chuckle. Not right this moment, no, you tell [Arian em]; the two of you just had a pretty intense session, you need a few moments to recover; besides that you have other matters that need your attention.  Arian looks down in disappointment, pouting.  Now, now, there's no need for that, you can always have some fun another time.  \"<i>All right then... see you later?</i>\"  You nod.  \"<i>Ok... I'll be waiting.</i>\"");
			
			outputText("\n\nYou promptly gather your clothes and quietly make your way ");
			if (!arianFollower()) outputText("back to Tel'Adre's streets, and from there back to camp.");
			else outputText("out of [Arian eir] tent.");
			flags[kFLAGS.ARIAN_ASS_CHAT]++;
		}
		else {
			outputText("\n\nYou pat Arian gently on [Arian eir] ass and comment playfully that [Arian ey] is such an unabashed buttslut, isn't [Arian ey]?  Still, did [Arian ey] get enough cock up [Arian eir] ass for a while?");
			
			outputText("\n\nArian smiles wryly at you.  \"<i>I guess I've got enough to hold me for a while now, but I could always use another dose.</i>\"");
			
			outputText("\n\nWell, this greedy little lizard of yours will have to wait until you're ready.  But if [Arian ey]'s good, maybe you'll come back later, you tell [Arian em], playfully tapping [Arian em] on the snout for emphasis.  \"<i>Okay, I'll be waiting.</i>\"  [Arian Ey] grins happily.");
			outputText("\n\nSmiling back at [Arian em] you gather your clothes and quietly make your way ");
			if (!arianFollower()) outputText("back to Tel'Adre's streets, and from there back to camp.");
			else outputText("out of [Arian eir] tent.");
		}
	}
	player.orgasm();
	dynStats("sen", -2);
	doNext(camp.returnToCampUseOneHour);
}

//Get Blown:
//PC must have a cock.
private function getBlownByArian():void {
	clearOutput();
	flags[kFLAGS.ARIAN_VIRGIN] += 1;
	arianHealth(3);
	if (arianMF("m", "f") == "f")
		outputText(images.showImage("arianfemale-home-getbj"));	
	else	
		outputText(images.showImage("arianmale-home-getbj"));
	outputText("You trail your hand down your belly, pondering what to do.  Arian doesn't seem to notice, instead staring with anticipation at your erection.  You idly swing your hips from side to side, and notice with amusement that the lizan seems to follow it.  Building on that train of thought, you ask if [Arian ey] would be willing to suck you off.");
	
	//(if ArianHasBlown == 0)
	if (flags[kFLAGS.ARIAN_HAS_BLOWN] == 0) {
		outputText("\n\nThe lizan averts [Arian eir] eyes, snapping out of [Arian eir] reverie.");
		if (flags[kFLAGS.ARIAN_COCK_SIZE] == 3) outputText("  You notice Arian's exposed shaft slowly hardening at your invitation.");
		outputText("  \"<i>I... Can I really?</i>\"");
		
		outputText("\n\nYou smile and note [Arian ey] almost sounds eager to do that, though you admonish [Arian em] to be careful; it's a sensitive body part and, while you don't doubt [Arian eir] affections, that doesn't make [Arian eir] teeth any less sharp.");
		
		outputText("\n\nArian nods eagerly.  \"<i>I promise I will be careful.  I wouldn't dream of hurting you, [name].</i>\"  You nod in return, and tell the lizan that you'll trust [Arian em], settling on [Arian eir] bed and giving [Arian em] full access to what's between your [legs].");
	}
	else {
		outputText("\n\nThe lizan smiles at you and licks [Arian eir] lips.  \"<i>I would love to!</i>\" [Arian ey] replies eagerly.  You smile and remind [Arian em] to be careful with [Arian eir] teeth.");
		
		outputText("\n\nArian acknowledges your concern by nodding emphatically.  \"<i>Sure, I would never hurt you, [name].</i>\"");
		
		outputText("\n\nSatisfied with [Arian eir] reply, tell [Arian em] you'll trust [Arian em] and settle on [Arian eir] bed and giving [Arian em] full access to what's between your legs.");
	}
	
	outputText("\n\nArian rolls on top of you and reaches for your [cock biggest], caressing it almost reverently.  Looking at Arian's face, you see [Arian em] eyeing your cock up and down, sizing it up.  Arian looks at you and smiles; then without breaking eye contact [Arian ey] extends [Arian eir] tongue to lick at your [cockHead biggest] and slowly take your cock in, careful to purse [Arian eir] lips so [Arian eir] teeth won't hurt you.");
	
	outputText("\n\nYou shudder in pleasure at the sensation; the interior of Arian's mouth is warmer than you expected, but smooth in texture and silky soft.  Something long and wet wriggles around your [cock biggest]; for a heartbeat, you'd almost think it's a slimy snake, but then logic hits and you realize it's Arian's long, prehensile tongue, which [Arian ey] is using to coil around and entangle your intruding shaft.");
	
	outputText("\n\nWith one powerful slurp, Arian coaxes a small jet of pre out of your [cock biggest], which Arian is only too happy to drink down, moaning at the first taste of your seed; this in turn sends wonderful vibrations along your length, coaxing even more pre into Arian's hungry maw.");
	
	//(If ArianHasBlown == 0)
	if (flags[kFLAGS.ARIAN_HAS_BLOWN] == 0) {
		outputText("\n\nAs you gasp in pleasure, you cannot help but wonder when did Arian get so skillful with [Arian eir] mouth; you thought [Arian ey] said [Arian ey] was a virgin before you came along.");
		outputText("\n\nYou ask if Arian's sure [Arian ey] was a virgin until [Arian ey] met you.");
		outputText("\n\nArian lets go of your cock, kissing its [cockHead biggest] before replying, \"<i>Yes, I'm sure... but I practiced a lot on myself...</i>\"");
	
		outputText("\n\nOn [Arian em]self?!  You blurt out; just how flexible is [Arian ey]?!");
		
		outputText("\n\nArian smiles nervously and bites [Arian eir] lower lip.  \"<i>I'm a mage, remember?  There's a lot of things you can do with magic, but this isn't about me, [name].  It's about you... so let me show you what I learned.</i>\"  Arian plants a kiss on your [cockHead biggest] before slowly wrapping around it with [Arian eir] tongue and sucking you right back into [Arian eir] cock-hungry maw.");
		
		outputText("\n\nYou moan, agreeing that, yes, this is far more important.");
	}
	else {
		outputText("\n\nAs you gasp in pleasure, you cannot help but ask if Arian's been practicing by [Arian emself] while you were away.");
		outputText("\n\nArian lets go of your cock, kissing its [cockHead biggest] before replying, \"<i>No, I don't need to practice on myself anymore.  I got you to help with that now, right?</i>\"  Arian plants a kiss on your [cock biggest], before slowly wrapping it around [Arian eir] tongue and sucking you right back into [Arian eir] cock-hungry maw.");
		outputText("\n\nYou moan and tell [Arian em] that as long as [Arian ey] keeps giving you great head, you're more than happy to help [Arian em] practice.");
	}
	
	outputText("\n\nYou thrust your [cock biggest] as deeply into the lizan's eager little mouth as [Arian ey] will let you... oooh, what would they say, if they could see a proud spellcaster like [Arian em] sucking you off like this?");
	
	outputText("\n\nArian doesn't bother replying, not that [Arian ey] could with a mouthful of cock.  [Arian Ey] braces [Arian em]self on your [hips] and begins truly blowing you; intent on draining you of your seed with strong, wet, slurping sucks that resound from the small cracks of the lizan's maw not filled with your [cock biggest].");
	
	outputText("\n\nYou groan and gasp and hump the lizan's face for all you're worth.  You can feel the familiar pressure of seed building up deep inside you, sparks of pleasure becoming the budding crescendo of orgasm, and you wonder if you should warn Arian of what's coming...");
	
	outputText("\n\nArian never slows down, even as [Arian ey] looks up to you, trying to catch a glimpse of your face to make sure [Arian ey]'s pleasuring you well.  When your eyes meet, you swear you can see the lizan mage smiling at you, even thought [Arian eir] mouthful of cock prevents you from catching a good glimpse of [Arian eir] face.  [Arian Ey] moans with delight as you take hold of [Arian eir] head and begin guiding [Arian em].");
	
	outputText("\n\nWith a few last huffs and gasps, it finally comes.  Orgasm rips through your flesh and sends your cum cascading from out of your [cock biggest] into Arian's suckling mouth - no point worrying about whether or not [Arian ey] wants it in the mouth now, it's here and [Arian ey]'ll just have to deal with it.");
	
	outputText("\n\nArian is surprised when the first jet of cum hits [Arian em] straight in [Arian eir] throat, but never stops sucking.  Somehow Arian manages to drink your cum as fast as you can pump it into [Arian eir] eager maw; by the time you're done, Arian has developed a ");
	if (player.cumQ() < 250) outputText("small");
	else if (player.cumQ() < 1500) outputText("big");
	else outputText("huge");
	outputText(" pot belly.  [Arian Ey] lets go of your dick with a sigh of pleasure and lays back on the bed.  \"<i>Ah... I'm full.</i>\"");
	
	outputText("\n\nYou tell [Arian em] that [Arian ey] looks full");
	if (player.cumQ() >= 1500) outputText(", in fact, you're amazed [Arian ey] didn't pop with how much [Arian ey] drank");
	outputText("; is [Arian ey] sure [Arian ey]'s all right?");
	
	outputText("\n\nArian yawns, revealing [Arian eir] toothy maw.  \"<i>Yes, I just need a nap.</i>\"  You chuckle and tell [Arian em] that [Arian ey] should at least get under the covers.  \"<i>Too... tired to bother.</i>\"  Arian replies with a second yawn.  Seeing no reason not to be gallant, you step forward and help Arian climb to [Arian eir] feet");
	if (player.cumQ() >= 1000) outputText(" which, considering the fact [Arian ey] looks like a mother ready to birth a toddler from the size of [Arian eir] belly, isn't as easy as you'd think");
	outputText(".  Letting the lizan use your shoulder, you pull [Arian eir] sheets up and help [Arian em] back in the bed, where [Arian ey] flops down with a protest of springs");
	if (player.cumQ() >= 250) outputText(", [Arian eir] gut audibly sloshing as the cum inside is churned by the impact");
	outputText(".");
	
	outputText("\n\n\"<i>Thanks, [name].</i>\"  Arian yawns once more and closes [Arian eir] eyes.  You smile and give the sleeping lizan an affectionate pat on the head; then dress yourself and make your way");
	if (!arianFollower()) outputText(" back to camp, stopping only to notify Laika and Boon that Arian is sleeping.");
	else outputText(" out of Arian's tent.");
	player.orgasm();
	flags[kFLAGS.ARIAN_HAS_BLOWN]++;
	doNext(camp.returnToCampUseOneHour);
}

//Penetrate:
//Arian must be herm/female.
//PC must have a cock that fits (cock area 50 or less)
private function penetrateArian():void {
	var x:int = player.cockThatFits(50);
	if (x < 0) x = player.smallestCockIndex();
	clearOutput();
	flags[kFLAGS.ARIAN_VIRGIN] += 1;
	arianHealth(3);

	outputText(images.showImage("arianfemale-home-penetrate"));
	outputText("You admire the transgendered lizan's body, from [Arian eir] feminized features, down past [Arian eir] [arian chest], all the way to [Arian eir] shapely thighs.  You tell Arian that the change looks very good on [Arian em]; few boys would really be so naturally pretty when turned into a ");
	if (flags[kFLAGS.ARIAN_COCK_SIZE] > 0) outputText(arianMF("maleherm.", "dickgirl."));
	else outputText("girl.");
	
	outputText("\n\nArian smiles and averts [Arian eir] eyes, rubbing one arm.  \"<i>You really think so?</i>\"  [Arian Ey] bites [Arian eir] lower lip in nervousness.");
	
	outputText("\n\nYou nod your head, insisting that you do think so.  With a lustful purr, you ask just how [Arian ey] would like to try out [Arian eir] girl parts, maybe see just how pretty [Arian ey] can feel with the right... encouragement?");
	
	outputText("\n\n\"<i>Of course!  I would love it.  So what should I do?</i>\" [Arian ey] asks, tail waving lazily behind [Arian eir] as [Arian ey] awaits further instructions.  \"<i>Should I help you get ready first?</i>\"  [Arian Ey] looks down between your legs to see your half-erect cock");
	if (player.cockTotal() > 1) outputText("s");
	outputText(".  \"<i>Err... readier?</i>\"  [Arian Ey] asks, smiling nervously.");
	
	outputText("\n\nYou smile, and tell [Arian em] that, seeing as how this is fairly new to [Arian em], you'll try and let [Arian em] take charge.  You sashay over to [Arian eir] bed and lay down on your back, [eachCock] jutting proudly into the air, before telling Arian you want [Arian em] to straddle you.");
	
	outputText("\n\nArian nods, [Arian eir] liquid lust dropping over your [legs] as [Arian ey] straddles you");
	if (flags[kFLAGS.ARIAN_COCK_SIZE] == 3) {
		outputText(", [Arian eir] exposed cock");
		if (flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText("s");
		outputText(" hardening at what [Arian ey]'s about to do");
	}
	else if (flags[kFLAGS.ARIAN_COCK_SIZE] > 0) {
		outputText(", [Arian eir] bulbous cock");
		if (flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText("s peeking out of their");
		else outputText(" peeking out of its");
		outputText(" hiding place, already at full mast in anticipation");
	}
	outputText(".  Arian swallows audibly.  \"<i>What now?</i>\" [Arian ey] asks, already panting in lust.");
	
	outputText("\n\nYou gently reach up and take hold of the lizan's hips, telling [Arian em] that first, you need to connect, slowly guiding [Arian em] down, feeling [Arian eir] all-too-human folds parting around the tip of your cock.");
	
	outputText("\n\nArian moans and tries to speed things up by impaling herself on [oneCock], but the pleasure of the insertion makes [Arian em] lose [Arian eir] balance and [Arian ey] falls face down on your [chest].  \"<i>Ah!  S-sorry!</i>\"  [Arian Ey] smiles nervously at you.");
	
	outputText("\n\nYou smile at [Arian em] and pat [Arian em] on the cheek, telling [Arian em] to take it easy; there's no need to rush this.  With painstaking deliberation, you continue gently inserting yourself into the ");
	if (flags[kFLAGS.ARIAN_COCK_SIZE] == 0) outputText("female");
	else outputText("herm");
	outputText(" lizan, until you have managed to hilt yourself inside of [Arian em].");

	outputText("\n\nArian shudders, rubbing [Arian eir] stretched pussy lips against your groin.  \"<i>This feels so good.  I never thought I'd ever feel something like this.  Your cock is filling me up, and I love it.  I can feel everything... every little twitch, every little vein, the texture... everything.</i>\"");
	
	outputText("\n\nYou whisper to [Arian em] that the best is yet to come, and then start to slowly buck your hips up and down, gradually increasing the tempo, murmuring in pleasure as you feel [Arian eir] slick, wet netherlips hungrily kissing you in response.");
	
	outputText("\n\nArian moans throatily, gyrating [Arian eir] hips against your intruding shaft, until [Arian ey] starts to slowly rise and fall, trying [Arian eir] best to keep up with your rhythm.  \"<i>So wet... I'm so wet, and the sounds!  I feel so hot... sexy... wanted.  Oh, [name] fuck me!  Take me!</i>\" [Arian ey] says, supporting herself on either side of your head, looking down at you with half-lidded, lust-driven eyes, panting hotly down at you as [Arian ey] bucks [Arian eir] hips against your thrusts.");
	if (flags[kFLAGS.ARIAN_COCK_SIZE] > 0) {
		outputText("  [Arian Eir] ");
		if (flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText("twin shafts");
		else outputText("shaft");
		outputText(" bobbing just out of your field of vision, leaking pre all over your belly.");
	}
	outputText("\n\nYou smile at the lizan, who is clearly adjusting to [Arian eir] new gender with aplomb, and procede to pick up the pace, trying to match the increasing tempo of [Arian eir] thrusts and ensure [Arian ey] enjoys herself as much as possible.  It's no sacrifice, after all, especially given the way [Arian eir] cunt is sucking hungrily on your cock, grinding with walls that ripple harder and harder as you thrust into [Arian eir] more and more vigorously.");
	
	outputText("\n\nArian smiles down at you, licking [Arian eir] lips.  \"<i>[name], please,</i>\" [Arian ey] moans throatily, half to show [Arian ey]'s paying attention, half from pleasure. \"<i>My breasts... please?</i>\"  [Arian Ey] asks, panting, never stopping [Arian eir] bucking against you.");
	outputText("\n\nYou unthinkingly reach up and take the lizan's [arian chestAdj] bosom in your hands, caressing the small, cherry-like nubs of [Arian eir] nipples, caressing the so-so-smooth scales that cover it, creating a texture at once alien and erotic.  Arian sighs in pleasure as you continue to massage [Arian eir] breasts.  \"<i>Do you like them?  My breasts?  Does it feel weird that I have breasts, despite being a lizan?</i>\"  You hoarsely whisper to [Arian eir] that you love them, and while it was strange at first, there's certainly many odder things about this world, and you think they're part of [Arian eir] natural charms.");
	
	outputText("\n\nArian moans appreciatively and grinds [Arian eir] hips against you.  \"<i>I'm so happy to hear you say that; you really know how to make a girl feel appreciated.</i>\"  You note that it feels a little strange to hear Arian so easily referring to \"<i>herself</i>\" as a girl.  Arian fidgets and averts [Arian eir] eyes.  \"<i>I-I can't help it.  When you're buried in my pussy I just... feel girly - pretty.</i>\"  That might be because [Arian ey] is so very pretty, you can't resist saying, even as you continue to thrust into [Arian eir].  \"<i>Oh [name]... F-fuck me.  Make me feel beautiful!  Make me cum!  I want you to fuck me as hard as you can.  Please....</i>\"");

	outputText("\n\nYou promise [Arian em] you will, but with [Arian eir] on top, you can't really exert that much control.  Swinging [Arian eir] tail to the side along with [Arian eir] body, Arian quickly rolls over, never breaking contact, nor stopping bucking against you, even as [Arian eir] legs close behind you and [Arian ey] loops [Arian eir] arms around your neck.  [Arian Ey] looks up at you, panting, with half-lidded eyes, then [Arian ey] smiles.  \"<i>What about now?</i>\"");
	if (flags[kFLAGS.ARIAN_COCK_SIZE] > 0) {
		outputText("  [Arian Eir] cock");
		if (flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText("s twitch as they spurt ");
		else outputText(" twitches as it spurts ");
		outputText("a small rope of pre over [Arian eir] belly, anticipating what's to come as [Arian ey] braces herself for the inevitable pounding you're about to give [Arian em].");
	}
	outputText("\n\nNow, you tell [Arian em], you can really start, and you do your best to live up to your promise, pounding [Arian em] as hard and fast as you can, without being so rough that you hurt [Arian em] in the process.  \"<i>Ahm... yesssss... so good.  Fuck me raw!  Oh!  Paint my walls with your hot cum!</i>\"");
	
	outputText("\n\nArian has quite the dirty mouth on [Arian em], you manage to joke, even as you pound [Arian em] with all you have.");
	outputText("\n\n\"<i>That's... Ah!</i>\"  Arian's words catch in [Arian eir] throat, and instead [Arian ey] moans, \"<i>J-just cum!  Please!  I need it!</i>\"");
	
	outputText("\n\nWell, it's rude to cum before a " + arianMF("maleherm", "lady") + ", so you're not giving in, not until [Arian ey] cums first, you manage to gasp, though in truth you're struggling to keep from blowing.  \"<i>Oh!  Cum!  Cum with meeeee!</i>\"");
	
	outputText("\n\n");
	if (flags[kFLAGS.ARIAN_COCK_SIZE] > 0) {
		outputText("Arian's ");
		if (flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText("twin cocks throb");
		else outputText("cock throbs");
		outputText(" as [Arian ey] splashes [Arian eir] [arian chest] and face with [Arian eir] own futa-lizan seed.  ");
	}
	outputText("[Arian Eir] walls grip you tightly, almost painfully, as a flood of juices hit the " + player.cockHead(x) + " of your " + player.cockDescript(x) + " with the force of a tidal wave, only to spill around [Arian em] spread nethers and run down your lower body.  [Arian Eir] sopping wet pussy works overtime, trying its best to pull you in as deep as possible, intent on sucking all the cum out of ");
	if (player.balls == 0) outputText("you");
	else outputText("your [balls]");
	outputText(".");
	
	outputText("\n\nFinally having kept your promise, you give yourself over to the inevitable. ");
	if (player.hasVagina()) outputText(" A wash of fluids spills down your body from your cunt as it spasms in release and y");
	else outputText("Y");
	outputText("ou unleash your essence right into the lizan's burning womb.");
	
	//(Low Cum amount)
	if (player.cumQ() < 250) {
		outputText("\n\nArian's pussy is clamping down so hard on your dick, that you can feel it as the cum stretches your urethra, gathering at the tip, and exploding outwards.  Contracting walls carrying the seed deep into the awaiting womb that lies beyond.  You hug the shuddering lizan tightly as you thrust against [Arian em] a few more times, delivering the last few ropes of cum and collapsing atop [Arian em].");
	}
	//(Medium Cum amount)
	else if (player.cumQ() < 1000) {
		outputText("\n\nYou forcible stretch Arian's wet pussy with the sheer volume of the load traversing your cum-sleeve.  You imagine yourself, covering the lizan's canal in white... all the way to [Arian eir] cervix.  The weak barrier barely containing the enormous load that forces it open, to spatter and sit inside [Arian eir] womb.  \"<i>Ahh... so full,</i>\" Arian says, tongue lolling out.  You hug [Arian em] tightly against you, an action [Arian ey] happy to return, and slowly you feel it.  [Arian Eir] slender belly gains volume, sloshing with the cum you just deposited in it.  Once spent, you collapse and sigh.");
	}
	//(High Cum amount)
	else {
		outputText("\n\nYou threaten to blow the poor lizan straight off your " + player.cockDescript(x) + " with the sheer force of your cum.  Hosing down [Arian eir] walls to the point [Arian ey] can't hope to contain all of your powerful jets, you draw [Arian em] close, and Arian groans, returning the gesture with a tight hug of [Arian eir] own.  \"<i>Ugh, my belly... so much... so good,</i>\" [Arian ey] moans, and you continue to torment [Arian eir] body with your prodigious load.  The sheets under the two of you have since turned into a wet mess of mixed juices, covering both of your lower bodies in the aftermath of you tryst; and it's not until you thrust into [Arian em] a couple more times, to ensure you're completely spent, that you collapse on top of [Arian em], slightly propped up by the protruding, pregnant-looking belly you've given [Arian em].");
	}
	
	outputText("\n\n\"<i>Aaahhhh...</i>\"  Arian sighs.  \"<i>Sex... feels so good.</i>\"  Caressing the back of your head, [Arian ey] gently pulls you into a quick kiss.  \"<i>If this is how it'll feel every time we do this, then I have no regrets about turning into a girl,</i>\" [Arian ey] says, one hand snaking it's way between the two of you to rub [Arian eir] ");
	if (player.cumQ() < 250) outputText("lean");
	else if (player.cumQ() < 1000) outputText("full");
	else outputText("overfilled");
	outputText(" belly.  \"<i>Stay with me, like this, a little longer?</i>\" Arian asks.");
	
	outputText("\n\nYou take [Arian eir] free hand in your own and tell [Arian em] that, if [Arian ey] wants you to, you can stay for at least a little while longer.  \"<i>I'd like that... just a while.</i>\"  Arian does [Arian em] best to nuzzle you.  With no compelling reason not to, you nuzzle [Arian em] back and content yourself with laying there, enjoying the mutual afterglow.");
	
	outputText("\n\nEventually, though, you announce that you should probably get going.  As nice as it is to stay here with [Arian em], you have duties to attend to.  Arian smiles at you, and gives you a little peck on the lips.  \"<i>I understand, but come see me again soon, please.</i>\"  You promise [Arian em] you will and extract yourself from the affectionate lizan's embrace.  You quickly find your clothes and get dressed, then leave.");
	player.orgasm();
	dynStats("sen", -1);
	doNext(camp.returnToCampUseOneHour);
}

//Get Anal:
//Arian must have a cock.
private function getButtWreckedByArian():void {
	clearOutput();
	flags[kFLAGS.ARIAN_VIRGIN] += 1;
	arianHealth(3);
	if (flags[kFLAGS.ARIAN_VAGINA] > 0)	
		outputText(images.showImage("arianfemale-home-getArianAnal"));	
	else	
		outputText(images.showImage("arianmale-home-getArianAnal"));
	outputText("With a lick of your lips with your tongue, you ask how Arian would like to be on the pitching end of anal?");
	//(if AnalXP < 33)
	if (flags[kFLAGS.ARIAN_ANAL_XP] < 33) outputText("\n\n\"<i>I don't know... won't it hurt, are you sure?</i>\"");
	//(if AnalXP < 66)
	else if (flags[kFLAGS.ARIAN_ANAL_XP] < 66) outputText("\n\n\"<i>I like it when you use my ass, but if you want me to use yours, I would gladly comply.  That is, if you're sure you want me to...?</i>\"");
	//(if AnalXP <= 100)
	else outputText("\n\n\"<i>I really love it when you fill me up, and personally I'd prefer we do it that way, but if you're really sure you want me to, I'll try and make you feel as good as you feel inside me.</i>\"");
	
	outputText("\n\nYou smile seductively and nod, telling [Arian em] that you're sure you want [Arian em] to do you that way.");
	
	outputText("\n\n\"<i>Okay, then.  How should we do this?  I don't want to do something wrong and end up hurting you...</i>\"");
	
	outputText("\n\nYou smirk and reach out a hand to caress the lizan's [arian chest], stage-whispering to [Arian em] that [Arian ey] just needs to lie down on [Arian eir] bed and you'll take care of things from there...");
	
	outputText("\n\nArian swallow audibly, but complies.  Slowly [Arian ey] lets [Arian em]self fall back onto [Arian eir] bed, fidgeting as [Arian eir] ");
	if (flags[kFLAGS.ARIAN_COCK_SIZE] >= 3) {
		outputText("exposed cock");
		if (flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText("s harden");
		else outputText(" hardens");
		outputText(" to full mast.");
	}
	else {
		outputText(arianMF("his","her") + " cock");
		if (flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText("s peek out of their");
		else outputText(" peeks out of its");
		outputText(" hiding place, rising to full mast.");
	}
	
	outputText("\n\nYou sashay yourself towards the prone lizan, straddling [Arian eir] legs and reaching out to grasp [Arian eir] ");
	if (flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText("primary ");
	outputText("cock.  Slowly and gently you begin to stroke its strange, knobbly surface, your fingers eliciting moans and gasps from Arian as [Arian ey] shudders under your touch.  Precum begins to ooze from the reptilian prick's head, and you purposefully rub it into [Arian eir] shaft as a kind of makeshift lubricant.");
	
	outputText("\n\n\"<i>Ohm... T-this feels great, [name], b-but if you keep this up, I won't be able to hold back!</i>\" Arian pants, [Arian eir] shaft");
	if (flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText("s");
	outputText(" throbbing against your hands.");
	
	outputText("\n\nWell, that would be a shame; it might be a little rough, but you'll have to make do with what you've got.  With that in mind, you cease your stroking, and start sliding yourself up Arian's body, until your [ass] is positioned above [Arian eir] jutting prick.  With slow, deliberate motions, you slowly start to impale yourself upon it...");
	
	player.buttChange(arianCockSize(),true,true,false);
	
	outputText("\n\n\"<i>Argh!  T-this is too much!</i>\"  With a groan of pleasure Arian shoots [Arian eir] cum into your bowels, lubricating it enough to allow you to easily slide down onto [Arian eir] shaft.");
	if (flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) {
		outputText("  [Arian Eir] other shaft twiches and sprays your ");
		if (player.tailType == TAIL_TYPE_NONE) outputText("back");
		else outputText("tail");
		outputText(".");
	}
	
	outputText("\n\nYou sigh and cluck your tongue; Arian really needs to work on [Arian eir] stamina - [Arian ey] loses [Arian emself] to the pleasure too easily, which you gently point out to [Arian em].");
	
	outputText("\n\n\"<i>S-sorry...</i>\"  Well, it can't be helped.  You'll just have to try again some other time... \"<i>No!  Wait!</i>\"  Arian grabs your hips.  \"<i>I-I can still go on!</i>\"  Really?  Because you're pretty sure you can feel [Arian em] going soft right this instant...  \"<i>Y-yes... just give me a moment.</i>\"");
	
	outputText("\n\nArian looks up at you, panting; [Arian eir] hands begin roaming your body, caressing your [hips], your [butt], your [chest].  For a moment, you actually feel [Arian eir] bulbous shaft throb within you, but maybe [Arian ey] needs a little push to make things go faster?  You smirk.");
	
	outputText("\n\nWith that, you bend over and kiss [Arian em], slipping your tongue into [Arian eir] mouth to wrestle with [Arian eir] own long, dexterous tongue.  Withdrawing, you send a hand reaching down between [Arian eir] legs, squeezing [Arian eir] ass, ");
	if (flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText("stroking [Arian eir] other cock and sliding it between your ass cheeks, ");
	outputText("caressing the base of [Arian eir] tail.  With a devious grin, you begin to gently but insistently slide your finger into [Arian eir] ");
	if (flags[kFLAGS.ARIAN_ANAL_XP] > 66) outputText("eager ");
	outputText("ass, probing for [Arian eir] prostrate...");
	
	outputText("\n\nThe reaction is almost instantaneous; Arian moans into your kiss and you feel [Arian eir] ");
	if (flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText("pair of lizan-cocks practically jump");
	else outputText("lizan-cock practically jump");
	outputText(" back to full mast, even surprising you with Arian's eagerness.");
	
	outputText("\n\nYou grin and coyly muse to yourself that maybe Arian makes up for [Arian eir] quickness at climaxing with the speed with which [Arian ey] can recover.");
	
	outputText("\n\nArian bites [Arian eir] lower lip nervously.  \"<i>I can't help myself if you keep touching me like that.</i>\"  [Arian Ey] closes [Arian eir] eyes and turns to the side, [Arian eir] hands clutching your [hips] and [Arian eir] toes curling behind you.  You can't help but gently pat [Arian em] on [Arian eir] head and tell [Arian em] that [Arian ey] looks really cute when [Arian ey] acts like an embarrassed virgin, especially after having already cum inside you.  Arian just turns to smile nervously at you.  \"<i>I... can we... start moving now?</i>\"");
	
	outputText("\n\nYes, yes you can, you tell [Arian em], and for emphasis you begin to rise and fall, ");
	if (flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText("sliding [Arian eir] neglected prick through your ass-cheeks, ");
	outputText("clenching your inner walls to grip and feel the excitingly unusual lumpy, bulbous texture of [Arian eir] shaft inside you.  You moan and gasp, telling [Arian em] that [Arian ey] feels so unique, and yet [Arian ey] stimulates you so wonderfully.");
	
	outputText("\n\nThe lizan mage can barely contain [Arian emself] as [Arian ey] tosses and turns on [Arian eir] bed, gasping and moaning at your ministrations.  You lick your lips as you continue to ride [Arian em], ");
	if (player.hasVagina()) outputText("cunt dripping with arousal");
	if (player.hasCock() && player.hasVagina()) outputText(" and ");
	if (player.hasCock()) {
		outputText("cock");
		if (player.cockTotal() > 1) outputText("s");
		outputText(" drooling precum onto [Arian eir] belly");
	}
	outputText(".  You're so close now, you can feel it.  You tell Arian you're going to cum, and beg [Arian em] to cum with you.");
	
	outputText("\n\nAs if on cue, Arian gasps and [Arian eir] shaft");
	if (flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText("s twitch");
	else outputText(" twitches");
	outputText(", signaling [Arian eir] oncoming orgasm.  [Arian Ey] grabs the sheets on [Arian eir] bed and curls [Arian eir] toes.  \"<i>...[name]!</i>\"  Jet after jet of lizan spunk paints your bowels white");
	if (flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText(", as well as your butt");
	outputText(", as Arian climaxes");
	if (flags[kFLAGS.ARIAN_VAGINA] > 0) outputText(", [Arian eir] own pussy clenching and drizzling juices on the matted sheets beneath the two of you.");
	else outputText(".");
	
	outputText("\n\nWith a cry of glee, you orgasm, giving yourself over to the pleasures of the act.  Your ass clenches around the bulbous shaft intruding in your bowels, trying to wring it of all its delicious load.");
	if (player.hasCock()) outputText("  [EachCock] spasms and shoots rope after rope of cum, painting Arian's [arian chest] white, as well as the groaning lizan's face.");
	if (player.hasVagina()) outputText("  Your [pussy], though unattended, joins in the perverted display, leaking copious amount of fluids on top of the prone lizan.");
	
	outputText("\n\n\"<i>Ahhhhh...</i>\"  Arian sighs, going limp on [Arian eir] bed.  You follow shortly, laying down on top of [Arian em], embracing [Arian em] as [Arian ey] does the same.  \"<i>[name], you're amazing.</i>\"");
	
	outputText("\n\nWith a pleased grin, you tell [Arian em] that [Arian ey]'s not too shabby [Arian em]self, either.  So, how did [Arian ey] like being the pitcher?");
	
	//(if AnalXP < 33)
	if (flags[kFLAGS.ARIAN_ANAL_XP] < 33) {
		outputText("\n\n\"<i>Wow, that felt really good.  Did it feel good for you too, [name]?  I hope it did... wow,</i>\"  Arian pants.");
		
		outputText("\n\nYou smile and pat your lover on the head, assuring [Arian em] that it was good for you, too.");
		
		outputText("\n\n\"<i>I'm glad,</i>\" [Arian ey] replies, nuzzling you in affection.");
	}
	//(if AnalXP < 66)
	else if (flags[kFLAGS.ARIAN_ANAL_XP] < 66) {
		outputText("\n\n\"<i>You ass feels so good on my cock, [name].  I can only hope it feels this good when you're inside me.  Though to be honest, I think I like it best when our roles are reversed.</i>\"");
		outputText("\n\nYou insist that it does, though you can't resist grinning and warning Arian [Arian ey] might be getting too much into catching when it comes to this situation.");	
		outputText("\n\n\"<i>It just feels so good when you're doing me from behind, but doing you is good too.</i>\"  [Arian Ey] smiles.");
	}
	//(if AnalXP <= 100)
	else {
		outputText("\n\n\"<i>That was great!  Now why don't you return the favor and use me instead?  After watching you sit on my shaft like that, I want to be fucked too.</i>\"  [Arian Ey] bites [Arian eir] lower lip, tail waving as best as it can underneath the two of you.");
		outputText("\n\nYou laugh; Arian, you are such a greedy little buttslut, aren't you?  That's what you say to him.");
		
		outputText("\n\nGrinning nervously, [Arian ey] says, \"<i>I can't help it.  It feels really good.  Besides, you made me that way, so take some responsibility.</i>\"  Then [Arian ey] swallows.  \"<i>Not that I mean to imply I didn't like it... or anything of the sort.</i>\"");
		
		outputText("\n\nAnd what if you want to be the catcher sometimes, huh?  [Arian Ey]'s got such a wonderful cock, how can [Arian ey] deny you the pleasure of taking it up the ass?  [Arian Ey]'s so greedy, you tell him, playfully tapping him on the nose.  [Arian Ey] whimpers.  \"<i>Okay, I like being the pitcher too, but can you do me now?  Please?</i>\"  [Arian Ey] asks, eagerly wiggling [Arian eir] hips.");
		outputText("\n\nYou contemplate it...");
		//(if PC has a cock){
		if (player.hasCock()) {
			player.orgasm();
			dynStats("sen", 2);
			player.slimeFeed();
			//[Yes: Play the \"<i>PC fucks Arian's ass</i>\" scene]
			//[No: You tell Arian you've had enough fun for now; maybe later, after you've both recovered.]
			menu();
			if (player.cockThatFits(50) >= 0 && player.hasCock()) addButton(0,"Yes",giveArianAnal);
			else outputText(".  You're too big to fit inside Arian's ass, though.");
			addButton(1,"No",camp.returnToCampUseOneHour);
			return;
		}
		else{
			outputText("\n\nYou chuckle at [Arian eir] eagerness, but point out you're not properly equipped to help [Arian em] at the moment, so maybe later.");
			outputText("\n\nArian whimpers in disappointment.");
		}
		outputText("\n\n\"<i>I guess I need a nap now.  Care to join me?</i>\" [Arian ey] asks, yawning widely.  You tell him the offer is tempting, but you really need to get going and attend to other things.  You stroke [Arian eir] cheek and tell [Arian em] to get some rest to build [Arian eir] strength back up - after all, it wasn't really that long ago that [Arian ey] was so sick.  Arian nods.  \"<i>Okay, see you soon?</i>\"");
		outputText("\n\nYou promise [Arian ey] will, and plant a quick kiss on [Arian eir] brow.  As the lizan settles down to rest, you quietly redress yourself and leave [Arian em] to [Arian eir] slumbers.");
	}
	player.orgasm();
	dynStats("sen", 2);
	doNext(camp.returnToCampUseOneHour);
}

//Blow:
//Arian must have a cock.
private function suckAriansDick():void {
	clearOutput();
	flags[kFLAGS.ARIAN_VIRGIN] += 1;
	arianHealth(3);
	if (flags[kFLAGS.ARIAN_VAGINA] > 0)	
		outputText(images.showImage("arianfemale-home-suckariandick"));	
	else	
		outputText(images.showImage("arianmale-home-suckariandick"));
	outputText("You make a show of lewdly licking your lips and ask Arian if [Arian ey]'d be willing to let you have a little taste of lizan essence...?");
	outputText("\n\n\"<i>Are you sure?  I could do something for you if you feel like,</i>\" Arian offers.");
	
	outputText("\n\nYou shake your head insistently; you want to do something for [Arian em] this time, you tell your reptilian lover.");
	outputText("\n\n\"<i>Ok... if that's what you really want to do.  So... what should I do?</i>\" the lizan mage asks, fidgeting in barely contained excitement, tapping [Arian eir] fingers in anticipation.");
	
	outputText("\n\nJust get on the bed, you instruct [Arian em]; you're certain you can take care of the rest.");
	
	outputText("\n\n\"<i>All right,</i>\" Arian replies nervously, [Arian eir] ");
	if (flags[kFLAGS.ARIAN_COCK_SIZE] > 3) {
		if (flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText("exposed cocks hardening to full mast");
		else outputText("exposed cock hardening to full mast");
	}
	else {
		outputText("cock");
		if (flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText("s emerging from their");
		else outputText(" emerging from its");
		outputText(" hiding place, already fully erect");
		outputText(".");
	}
	outputText("\n\nYou approach [Arian em] and position yourself before [Arian em], contemplating how to begin.  You reach out with one hand and start to stroke [Arian eir] ");
	if (flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText("uppermost ");
	outputText("cock, marveling at the strange textures of its bumpy, knobbly, bulbous surface.  It feels so strange to you, and you continue to stroke it eagerly.");
	
	outputText("\n\nArian can only moan at your ministrations, eagerly humping your hand, desperate for your touch.  \"<i>Oh, my... it... it feels so good when it's someone else's hand...</i>\" [Arian Eir] ");
	if (flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText("twin ");
	outputText("shaft");
	if (flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText("s tremble");
	else outputText(" trembles");
	outputText(" and throb");
	if (flags[kFLAGS.ARIAN_DOUBLE_COCK] == 0) outputText("s");
	outputText(" against your hand; pre quickly forming on the tip");
	if (flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText("s");
	outputText(" only to slowly slide down the bulbous surface of Arian's lizan prick");
	if (flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText("s");
	outputText(".  You continue to slide your hand along the increasingly slick surface, playfully asking if your hand really feels that good to [Arian em]?");
	
	outputText("\n\n\"<i>Yesssss... Oh!  If you keep this up I won't be able to last long.</i>\"  Arian pants, [Arian eir] three-toed feet curling with each stroke, hands gripping the sheets tightly.");
	
	outputText("\n\nYou smile at [Arian em] with an innocent expression quite out of place for what you're doing, and then lean in to give [Arian eir] cock");
	if (flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText("s");
	outputText(" a long, loving, slurpy lick.  The taste is surprising; a sort of sugary-tinted spice, not the usual salt of another creature.  It's actually quite pleasant, and you find yourself running your tongue up and down [Arian eir] prick as if it were some kind of candied stick, eagerly sucking and slobbering as you coax more of [Arian eir] yummy goo from its strangely-shaped tip.");
	
	outputText("\n\nArian contorts with each loving lick, grunting and groaning in pleasure.  \"<i>[name], I'm going to cum!</i>\"  [Arian Ey] warns you, and judging by the way [Arian eir] shaft is throbbing [Arian ey] looks just about ready.");
	
	outputText("\n\nIn other circumstances, you'd probably tease [Arian em] about having no staying power, but, seeing how the wind's blowing, you instead put your mouth to better use and envelop [Arian eir] cock, suckling and slurping like a baby on a nipple as more of that strange spicy-sweet cum trickles steadily into your mouth.");
	
	outputText("\n\nUnable to hold back any longer, Arian's hands pull on the sheets as [Arian eir] ");
	if (flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText("twin cocks throb");
	else outputText("cock throbs");
	outputText(" one more time and erupts into your waiting mouth");
	if (flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText(" and chin");
	outputText(".  [Arian Eir] legs close around your back, effectively keeping you from moving too far away as [Arian ey] finishes giving you all of [Arian eir] load.");
	
	outputText("\n\nYou simply go with what [Arian ey] wants and focus on guzzling down every last drop, continuing to lick and tease even as you swallow mouthful after creamy mouthful");
	if (flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText(", oblivious to the second cock spewing cum all over your [chest] in your eagerness");
	outputText(".  ");
	player.refillHunger(15);
	outputText("After [Arian ey] finally finishes, you continue to lick and suckle for a few minutes longer, making sure you've lapped up every last drop.  Then and then alone do you lift your head, flirtatiously licking your lips to tease the now-spent lizan.");
	
	outputText("\n\nArian watches you slack jawed and panting.  \"<i>That... that was great!</i>\"  [Arian ey] exclaims happily.  \"<i>I hope I didn't taste too bad.  I mean, I heard there is food that can make it taste better, but... well....</i>\" [Arian Ey] smiles nervously.");
	
	outputText("\n\nYou confess that, truthfully, the taste was unusual, but hardly unpleasant.  So, did your little lizard like the way you licked [Arian eir] lolly to reach the creamy center?  You jest.");
	
	outputText("\n\n\"<i>Yes, I liked it very much!  Though I hope you'll let me return the favor... somehow,</i>\"  [Arian Ey] says, releasing you from between [Arian eir] legs, while [Arian eir] tail lazily curls to gently massage your neck in a sign of affection.");
	
	//[NoCock: 
	if (!player.hasCock()) outputText("\n\nYou tell [Arian ey] you'll think of some way [Arian ey] can return the favor,");
	else outputText("\n\nWell, you happen to have a creamy lolly of your own that [Arian ey] could lick, you tease,");
	outputText(" rolling your neck in pleasure as [Arian ey] rubs it with [Arian eir] reptilian tail.");
	
	outputText("\n\nArian bites [Arian eir] lips and twirls [Arian eir] fingers.  \"<i>Well, I hope I can do something... anything... for you soon.  I really enjoy spending time with you, [name].</i>\" [Arian Ey] smiles at you.");
	
	outputText("\n\nSmiling wryly, you jokingly tell the lizan mage that the only reason [Arian ey] happens to enjoy your company is because of all the sex [Arian ey]'s getting.  Arian gasps and immediately blurts out, \"<i>No! Of course not!  I would love to be in your company even if we didn't do anything!</i>\"  [Arian Ey] gasps once more and shamefully hides [Arian eir] face when [Arian ey] realizes [Arian ey]'s sporting another erection.  \"<i>S-sorry!  I can't help it!</i>\" [Arian ey] fumbles, trying to cover [Arian emself].");

	outputText("\n\nYou just smile and pat [Arian em] on the cheek, telling [Arian em] that [Arian ey]'s adorable when [Arian ey] blushes.  You give [Arian eir] newly-stiffened cock a good firm stroke");
	if (flags[kFLAGS.ARIAN_VAGINA] > 0) outputText(" and tickle [Arian eir] cunt with a finger");
	outputText(" for emphasis, kiss [Arian em] gently on the tip of [Arian eir] nose, and then get your clothes together, planning on getting dressed and heading back out again.");
	
	outputText("\n\n\"<i>Uuuh... see you soon?</i>\"");
	outputText("\n\nYou throw [Arian em] a smirk over your shoulder, shake your [ass] for [Arian eir] benefit, and head on out.");
	
	dynStats("lus", 10+player.lib/5);
	doNext(camp.returnToCampUseOneHour);
}

//Get Penetrated:
//PC must have a vagina.
//Arian must have a cock.
private function getPenetratedByArianAndHisHitlerMustache():void {
	clearOutput();
	flags[kFLAGS.ARIAN_VIRGIN] += 1;
	arianHealth(3);
	if (flags[kFLAGS.ARIAN_VAGINA] > 0)	
		outputText(images.showImage("arianfemale-home-getpenetrated"));	
	else	
		outputText(images.showImage("arianmale-home-getpenetrated"));
	outputText("You look at Arian's ");
	if (flags[kFLAGS.ARIAN_COCK_SIZE] < 3) outputText("slit, and think of what it's hiding in there");
	else {
		outputText("exposed cock");
		if (flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText("s");
	}
	outputText("; then you turn to look at Arian and ask [Arian em] how would [Arian ey] feel about giving [Arian eir] ");
	if (flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText("twin cocks");
	else outputText("cock");
	outputText(" a bit of a workout?");
	
	outputText("\n\nArian swallows audibly.  \"<i>Are you suggesting that we... and that I... put it in?</i>\"  Grinning, you nod in affirmation, telling [Arian em] that there's no need to be shy about it... at least not since your relationship escalated to the current level.");
	
	outputText("\n\n\"<i>Ok... how do you want to do this?</i>\"  You motion for the lizan to get up.  Arian eagerly complies and gets off [Arian eir] bed.  You teasingly take [Arian eir] place on the bed, looking up at [Arian em] as you ");
	if (player.isBiped()) outputText("spread your [legs] and ");
	outputText("expose your [vagina] to [Arian eir] viewing pleasure.  The reaction is almost instantaneous; Arian's ");
	if (flags[kFLAGS.ARIAN_COCK_SIZE] >= 3) outputText("exposed");
	else outputText("hidden");
	if (flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText(" twin shafts immediately fill");
	else outputText(" shaft immediately fills");
	outputText(" with blood, growing fully erect in ");
	if (flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText("their");
	else outputText("its");
	outputText(" bulbous, throbbing glory.");
	
	outputText("\n\nWith a smile, you tell [Arian em] that despite [Arian eir] initial bout of shyness, [Arian eir] body seems to know exactly what to do.  Arian simply laughs in nervousness.  You wait for a short while, until finally you tell [Arian em] that [Arian ey] should position [Arian emself] at your opening");
	if (flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText("s");
	outputText(" and get ready to thrust in; otherwise neither of you are going to be feeling good any time soon.");
	
	outputText("\n\nSnapping to [Arian eir] senses, Arian quickly ");
	outputText("kneels between your [legs]");
	outputText(", aligning the tip of ");
	if (flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText("each of ");
	outputText(arianMF("his","her") + " ");
	outputText("shaft");
	if (flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText("s");
	outputText(" with your [vagina]");
	if (flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText(" and [asshole]");
	outputText(".  [Arian Ey] looks at you, waiting for you to confirm that [Arian ey] should indeed get going.  You smile and nod");
	if (player.hasLongTail()) outputText(", looping your tail around [Arian eir] waist");
	outputText(".");
	
	outputText("\n\nArian smiles right back at you and finally begins easing [Arian emself] inside you.");
	
	//(if ArianDblCock == 1) //DP PC
	if (flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) {
		outputText("\n\nHesitantly, the lizan tries to fit both of [Arian eir] cocks into your [vagina] and [asshole] at the same time.  You sigh at the intrusion and look at [Arian eir] face; Arian has a look of absolute bliss on [Arian eir], you can even see that the lizan is beginning to drool a bit.  The texture of Arian's twin cocks might be very similar, but they feel entirely different on both your ass and pussy.");
		
		outputText("\n\nThe bulbous orbs dotting the length work somewhat like beads, as they work over your resistance, each time one of them presses in, you moan and brace yourself for the next, larger bulb.  Gently but insistently Arian presses forward, quite happy to try and take both of your holes at the same time.  \"<i>This isn't hurting you, is it?</i>\" [Arian ey] asks, still understandably nervous about your relationship.");
		
		outputText("\n\nYou shake your head and tell [Arian em] that you're fine.  [Arian Eir] cocks just feel... different... from what you're used to seeing around; you remark that they seem built to rub against your most sensitive spots inside both your ass and your vagina.  Still, if [Arian ey] doesn't hurry up and fill you up, you might have to take matters into your own hands.  It's not nice to keep a girl waiting.");

		outputText("\n\nArian fumbles and begins penetrating you with more gusto.  \"<i>S-sorry, I just don't want to hurt you...</i>\"  You sigh and tell [Arian em] that you aren't made of glass.  [Arian Ey] can be a little rough, though if [Arian ey] overdoes it you'll have to stop [Arian em].  Still, you can take something like this!");
		
		outputText("\n\nYou take hold of [Arian eir] arms and pull [Arian em] up towards you, making the lizan lose [Arian eir] balance and fully penetrate you.");
		//(Enlargement/Virginity loss messages)
		player.cuntChange(arianCockSize(),true,true,false);
		player.buttChange(arianCockSize(),true,true,false);
		
		outputText("\n\nThe lizan moans in shock at the deed, as if [Arian ey] still can't believe this is actually happening.  [Arian Eir] fingers clutch you tightly, but [Arian ey] doesn't make any further motions - more likely [Arian ey] can't bring himself to thrust just yet, still full of that nervous virgin behavior.");
	}
	else 
	{ //Only one pole for that hole.
		outputText("\n\nArian nervously begins to thrust [Arian eir] strange, bumpy cock into your cunt, timidly inserting an inch or two and then withdrawing, as if unable to bring [Arian em]self to fully penetrate you.");
		
		outputText("\n\nYou moan at the initial intrusion, and sigh as [Arian ey] pulls out.  Impatient and bothered by [Arian eir] impromptu teasing, you ask what's gotten into [Arian em] to make [Arian em] withdraw?  You're already more than ready for this.");
		
		outputText("\n\n\"<i>I-I'm sorry, it's just....  Well, I'm not used to this, you know.</i>\"  Arian's eyes are downcast, and you're certain you can see a faint tinge of red around [Arian eir] face, [Arian eir] albinism allowing [Arian em] to blush in a way you're not sure a normal lizan could.  \"<i>It... it's so overwhelming to finally be with a woman, never mind a woman like you.</i>\"");
		
		outputText("\n\nSighing at the lizan's inexperience, you gently take [Arian eir] hands in yours and guide them around you, telling [Arian em] to hug you");
		if (player.hasLongTail()) outputText(", further encouraging [Arian em] to do so, by looping your tail around [Arian eir] waist");
		outputText(".  The lizan doesn't need much encouragement to comply, easily snuggling against you, breast to breast, and sighing softly.  \"<i>I'm sorry.  Sometimes I wonder why you bother doing something like this, with someone like me,</i>\" [Arian ey] says, a hint of sadness in [Arian eir] voice.");
		
		outputText("\n\nYou reply that you bother because Arian is cute and you happen to like [Arian em].  [Arian Ey] should forget about [Arian eir] insecurities and give [Arian emself] some credit.  Still, you are horny, and judging by the prodding you feel on your [leg], so is Arian.  You don't bother saying anything more, gently reaching down to align [Arian eir] shaft with your [vagina] and then pinch on the base of [Arian eir] tail.");
		
		outputText("\n\nArian lets out a tiny squeak of shock at the pinching sensation, which instinctively makes [Arian em] thrust [Arian emself] forward, embedding [Arian emself] in you to the hilt.");
		//(Enlargement/Virginity loss messages)
		player.cuntChange(arianCockSize(),true,true,false);
		
		outputText("\n\nYou gasp in pleasure at the sudden intrusion; then hug your lizan lover closer, stroking [Arian eir] back.  You ask if that was so difficult?");
		
		outputText("\n\n\"<i>N-not difficult, no.  But hard, all the same,</i>\" Arian replies.  Did [Arian ey] just make a joke?");
	}
	
	outputText("\n\nSmiling, you gently tap [Arian em] on the nose and tell [Arian em] that unless [Arian ey] expects you to do all the work, the two of you won't get anything done if [Arian ey] just lets [Arian eir] shaft");
	if (flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText("s");
	outputText(" sit inside you.");
	
	outputText("\n\nThe lizan promptly makes [Arian em]self busy, awkwardly thrusting in and out, pumping in a clumsy attempt to pleasure you both.  While you appreciate [Arian eir] enthusiasm, just randomly thrusting inside you won't give you the pleasure you so crave.  You tell Arian to stop for a moment.");
	
	outputText("\n\nArian does so, blinking curiously at you.  \"<i>Did I hurt you?  Am I doing something wrong?  I'm sorry!</i>\" the lizan blurts you.  Laughing, you tell [Arian em] to calm down.  [Arian Ey] didn't do anything wrong, and [Arian ey] certainly didn't hurt you.  \"<i>So, what's wrong then?</i>\" Arian asks.  [Arian Ey] then blinks in realisation and pouts.  \"<i>I'm not doing that badly, am I?</i>\"  Rubbing [Arian eir] back, you tell [Arian em] that just thrusting [Arian em]self inside you without any technique won't make you feel good.");
	
	outputText("\n\n\"<i>I'm sorry,</i>\" [Arian ey] sighs.  It's ok, you tell [Arian em], you'll just have to guide [Arian em] through the process.  Grasping on the base of [Arian eir] tail, you begin guiding the inexperienced lizan, using [Arian eir] tail like a control stick.");
	
	outputText("\n\nArian moans and shivers at the pleasure, but it doesn't stop [Arian em] from catching on; indeed, [Arian ey] proves [Arian em]self a quick study and starts to preempt your ‘instructions'.  \"<i>I-I can't tell you how incredible this is, [name].  You're so warm and wet inside,</i>\" [Arian ey] murmurs to you, too caught up in the sensations of sex to really flatter you.");
	
	outputText("\n\nYou moan alongside your lizan lover, replying that [Arian ey] feels just as good.  [Arian Eir] ");
	if (flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText("twin bulbous shafts feel");
	else outputText("bulbous shaft feels");
	outputText(" exquisite, and ");
	if (flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText("their");
	else outputText("its");
	outputText(" bumps massage your entrance");
	if (flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText("s");
	outputText(" unlike anything else.  You praise the lizan on being a quick study, letting go of [Arian eir] tail and grabbing onto [Arian eir] scaly shoulders instead, giving [Arian em] a few more directions so [Arian ey] can catch your most sensitive spots.");
	
	outputText("\n\nArian suddenly clenches and gasps, moaning several times and arching [Arian eir] back before [Arian ey] can't hold it back anymore and climaxes inside of you, filling your [cunt] ");
	if (flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText("and [ass] ");
	outputText("with [Arian eir] sticky wet seed.");
	
	outputText("\n\nYou moan as [Arian ey] fills you with [Arian eir] lizan seed, then immediately sigh in disappointment as [Arian ey] slumps down on top of you, nuzzling against you tenderly.  \"<i>That was incredible.  Hey, what's wrong?  Why didn't you cum?</i>\" Arian asks, curious yet sated.  Well, you just didn't have time to, but it's okay.  You'll find some way to relieve yourself, and it did feel good for the time it lasted.  You pat Arian's head, smiling at the lizan, despite being annoyed at not being able to climax.");
	
	outputText("\n\n\"<i>You mean, I didn't...?  No, no that's not acceptable!</i>\"  Arian growls.  To your surprise, you suddenly feel [Arian eir] flaccid member");
	if (flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText("s");
	outputText(" swelling inside you, the lizan grabbing your shoulders and starting to thrust [Arian em]self back into you once more.");
	
	outputText("\n\nYou groan in as much surprise as pleasure, bracing yourself against Arian as [Arian ey] begins fucking you with as much enthusiasm as when you two started.  You are genuinely impressed.  This is not something a newcomer to sex would be able to pull off.  You decide to thank and congratulate the lizan for [Arian eir] dedication with a kiss.");
	
	outputText("\n\nArian promptly redoubles [Arian eir] efforts, while trying to kiss you back in appreciation of the gesture.  You lose yourself in the pleasure and closeness of the act, fucking and kissing.  Slowly you feel a familiar pressure build in your loins, and you know it won't be long before you finally achieve your so, so desired, orgasm.");
	
	outputText("\n\nArian [Arian emself] lets out a cry of relief; having finally achieved [Arian eir] goal in helping you orgasm means [Arian ey] can give in to the sensations ");
	if (flags[kFLAGS.ARIAN_VAGINA] == 0) outputText("[Arian ey] himself ");
	else outputText("[Arian ey] ");
	outputText("is being overwhelmed by, spraying your ");
	if (flags[kFLAGS.ARIAN_DOUBLE_COCK] == 0) outputText("cavity");
	else outputText("cavities");
	outputText(" with a second helping of lizan spunk, dredging up every last drop of jizz left in [Arian eir] internal balls before, with a groan, [Arian ey] sinks down atop you.  Arian's orgasm pushes you over the edge, and you find your pussy ");
	if (flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText("and ass ");
	outputText("contracting, trying ");
	if (flags[kFLAGS.ARIAN_DOUBLE_COCK] == 0) outputText("its");
	else outputText("their");
	outputText(" best to milk the poor lizan of all [Arian ey] is worth, until finally with one last spasm, you slump down and release the lizan shaft");
	if (flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText("s");
	outputText(" deeply embedded inside you, some of your mixed juices running down to mat Arian's bed.");
	
	outputText("\n\n[Arian Ey] lays there, panting softly from the exertion, then somehow finds the strength to give you a weak yet cheeky grin.  \"<i>So, how was I this time?</i>\" [Arian ey] asks.  Panting, you tell [Arian em] that [Arian ey] was great.  You didn't expect [Arian em] to be able to get a second erection so quickly, especially after having just cum.  \"<i>Well, I've learned a few tricks at the academy from some of the more, uh, restricted tomes, shall we say?  Not enough that I can do anything major, or even worth teaching, but enough for... something like this....</i>\"");
	
	outputText("\n\nGrinning at [Arian em], you question just why would [Arian ey] have picked up this one particular spell?  Arian does that weird pseudo-blush of [Arian eirs] again.  \"<i>A fellow can dream of finding someone special someday, can't they?</i>\"  That's all [Arian ey]'ll say on the subject, despite your coaxing.");
	
	outputText("\n\nYou decide to drop the subject for the moment and tell [Arian em] that as enjoyable as it was to spend time with [Arian em], you must return to your duties now.  Arian simply nods, wearing [Arian eir] best stoic expression.  \"<i>I understand... but, please, come back when you can, all right?</i>\"  You smile and tell [Arian em] you will, caressing [Arian eir] scaly cheek, then with a cheeky grin, let [Arian em] know that next time you expect at least four more performances from [Arian em].  Arian's eyes bulge at your suggestion, half in fear and half in lust.  \"<i>I... I can't possibly do that!  I mean, I don't have the energy,</i>\"  [Arian Ey] declares, swallowing audibly and averting [Arian eir] eyes.");
	
	outputText("\n\nGrinning, you pull [Arian em] into a final kiss, telling [Arian em] this is just something for [Arian em] to think about.  Having said that, you quickly redress and excuse yourself, leaving one flustered lizan behind to rest.");
	player.orgasm();
	dynStats("sen", -1);
	doNext(camp.returnToCampUseOneHour);
}

//Double Pen Arian:
//PC must have at least 2 cocks that fit. That means two cocks with a cock area of <= 50.
//This isn't meant to give AnalXP, but given the fact that Arian's ass will get pen'd it would also be justified. Up to you Fen!
private function doublePenetrateArian():void {
	clearOutput();
	flags[kFLAGS.ARIAN_VIRGIN] += 1;
	arianHealth(3);
	outputText(images.showImage("arianfemale-home-doublepenetrate"));	
	var x:int = player.cockThatFits(flags[kFLAGS.ARIAN_CAPACITY]);
	var y:int = player.cockThatFits2(flags[kFLAGS.ARIAN_CAPACITY]);
	outputText("You look over your feminine lizard lover, and feel your " + player.multiCockDescriptLight() + " starting to stir in your [armor].  Since you have enough tools for the job, and Arian has enough holes, you ask if Arian would be willing to let you fuck [Arian em] in both [Arian eir] ass and pussy at the same time?");
	
	outputText("\n\nArian bites [Arian eir] lower lip, fidgeting a bit at your suggestion.  \"<i>Sure.  I mean... that's the way sex is supposed to be with lizan females, and I do have the parts now.</i>\"");
	
	outputText("\n\nArian rolls around, laying face down on [Arian eir] bed, [Arian eir] rump held high to allow you easy access to both [Arian eir] ");
	if (flags[kFLAGS.ARIAN_ANAL_XP] <= 33) outputText("tight");
	else if (flags[kFLAGS.ARIAN_ANAL_XP] <= 66) outputText("loose");
	else outputText("throbbing");
	outputText(" ass and dripping wet vagina; a pair of clawed hands reach behind to spread [Arian eir] butt open for you.  \"<i>Okay, I'm ready.</i>\"  Arian says, looking behind at you.");
	
	outputText("\n\nYou sidle gently into the bed behind [Arian em] and gently squeeze [Arian eir] full, round cheeks, rubbing them before moving your hand into [Arian eir] crack in an effort to massage both anus and pussy at the same time.  You roll the palm of your hand against [Arian eir] back passage and stroke [Arian eir] softly scaled vulva lips with your fingers, asking how that feels.  \"<i>G-good,</i>\" Arian replies, shuddering.");
	
	//(if ArianAnalXP < 33)
	if (flags[kFLAGS.ARIAN_ANAL_XP] < 33) {
		outputText("\n\nYou slide your finger inside of Arian's pussy, getting it nice and slick with [Arian eir] juices, and then remove your hand; lining the finger up with [Arian eir] ass, you start pressing insistently against [Arian eir] back hole; it takes some effort, but finally [Arian eir] back passage yields and Arian moans as your finger presses past [Arian eir] sphincter and into [Arian eir] warm innards.  You smile and tell Arian [Arian ey]'s really tight back here.");
		
		outputText("\n\n\"<i>Hmm... we don't get to use my ass much, so of course it'll be tight.  Just try not to be too rough, please?  It kinda hurts.</i>\"");
		
		outputText("\n\nYou assure [Arian em] that you'll be gentle; and with [Arian eir] pussy getting some as well, it should be easier for [Arian em] to adjust.  That said, you carefully align your shafts and start to press them home.  It takes some effort to push inside [Arian eir] ass, but [Arian eir] pussy readily accepts you into its warm, wet embrace.");
		
		outputText("\n\n\"<i>Ooohhh!</i>\" Arian's initial cry of pain turns into a deep moan of pleasure as you finally make your way inside.  You stop to give [Arian em] some time to adjust.  \"<i>I feel so stuffed... it hurts, but feels good at the same time.  Hhmmm... keep moving, please.</i>\"  You do as [Arian ey] asks, and slowly push yourself to the hilt.");
	}
	//(else if ArianAnalXP < 66)
	else if (flags[kFLAGS.ARIAN_ANAL_XP] < 66) {
		outputText("\n\nYou know Arian's no stranger to anal sex, but you still figure it's polite to lube your finger up to some extent first.  Your fingers stroke and caress, sliding in and out of [Arian eir] moist depths, and you remove your hand to begin probing into [Arian eir] tailhole.  The well-trained orifice happily accepts you, posing little resistance as you begin sliding your femcum-slick digits inside.");
		
		outputText("\n\n\"<i>Aah, that feels nice.  I feel like such a girl, being treated like that...</i>\"");
		
		outputText("\n\nWell, of course, [Arian ey] is a girl, you grin.  Why shouldn't you treat [Arian em] like this, especially if it makes [Arian em] happy?  \"<i>W-well, I'm not really a girl.  I mean... not originally, but it does make me happy.  Why don't you stick it in?</i>\"  [Arian Ey] smiles nervously back at you.");
		
		outputText("\n\nWell, if [Arian ey]'s really so interested.  You quickly align yourself and start to press forward, gently inserting yourself into the two eager holes your lover has.  \"<i>Yesssss... don't stop until I'm fully stuffed,</i>\" Arian says, [Arian eir] tail wagging lazily above.  With a chuckle, you tap it away so you can finish pressing [Arian em], all the way to the hilt.");
	}
	else {
		outputText("\n\nFor politeness' sake more than anything, you painstakingly rub and massage Arian's dripping wet cunny with your fingers, getting them nice and lubed before you start poking at the greedy little hole under Arian's tail.  You don't meet any resistance at all; indeed, it seems to deliberately wrinkle itself in order to slurp your fingers inside, the muscles squeezing in an effort to hold you in there.  You smile to yourself, telling Arian that [Arian eir] little rosebud is indeed a naughty little thing, and you didn't expect any less.");
		
		outputText("\n\nArian shudders in pleasure, pushing back to allow [Arian eir] ass to suck more of your finger in.  \"<i>Hmm... it's like that thanks to you.  Not that I'm complaining.  I love it when you take me from behind.</i>\"");
		
		outputText("\n\nDoes [Arian ey] really, now, you ask?  Are both of [Arian eir] greedy little holes anxious for a nice sausage to stuff themselves with, hmm?  \"<i>Yesss.... I need you.  Please... make me feel good... like a girl,</i>\" Arian begs.");
		
		outputText("\n\nWell, if that's what [Arian ey] wants, who are you to deny [Arian em]?  You promptly position yourself and begin slowly sliding yourself home.");
		
		outputText("\n\n\"<i>Hmm... come on, [name].  You know you can go faster than that, don't tease me!</i>\"  Arian protests, pushing back at you, while [Arian eir] tail wraps itself around your waist to pull you inside.");
		
		outputText("\n\nWell, both [Arian eir] holes need a little tenderness, you point out.  Still, you hasten your pace, pushing inside [Arian eir] hungry holes until you've hilted yourself.");
	}
	
	outputText("\n\nYou moan and squeeze Arian's scaly yet luscious asscheeks, asking how [Arian ey] enjoys [Arian eir] double-serve of stuffing?  Rolling [Arian eir] hips against your own, [Arian ey] replies, \"<i>Let's just say that I'm beginning to get why we lizans are built the way we are.  Take me now!</i>\" [Arian ey] demands.");
	
	outputText("\n\nYou deliver a slap to [Arian eir] perky little butt, the crack of flesh on flesh ringing out as you then tell [Arian em] not to get greedy; there's no race to be won here.  \"<i>Ow!  B-but... I want you!</i>\"  [Arian Ey] pushes back at you insistently.  And you want [Arian em] as well, you tell [Arian em], but still, no need to be so bossy.  Arian pouts.  \"<i>Sorry...</i>\"");
	
	outputText("\n\nThat's better, you say.  With that, you start to thrust yourself into [Arian eir] two holes.  Penetrating both of Arian's holes is a unique feeling; [Arian eir] ass hugs your " + player.cockDescript(y) + " tightly, trying to prevent you from moving as it does its best to keep you hilted deeply within; while [Arian eir] pussy, so slick and moist, massages your shaft expertly. For a moment you wonder if you even have to move.");
	
	outputText("\n\n\"<i>Oooh, [name]... you have no idea how wonderful this feels.  I feel so full... so good... so wanted... I love you!  Fertilize my eggs!</i>\"  You groan and smirk, commenting that maybe Arian's getting a bit too caught up in this, unless [Arian ey]'s telling you that this ex-boy really wants to be a mother?  \"<i>Me... a mother... d-don't stop!  I want you as deep inside me as possible!</i>\"  You moan as [Arian eir] two holes ripple around your intruding shafts, striving to suck you deeper and deeper inside of [Arian eir].  You allow them to lead, but warn [Arian em] that you just might end up making [Arian em] a mother whether [Arian ey] wants to be or not if [Arian ey] doesn't temper [Arian eir] enthusiasm.");
	
	outputText("\n\n\"<i>What do you think I'm trying to do!?  Now get in here and paint my womb white!</i>\" Arian snaps, bracing [Arian em]self on [Arian eir] bed and allowing [Arian eir] ass and pussy both to suck you in with surprising force.  As soon as you're hilted within both holes, [Arian eir] ass clamps shut on your " + player.cockDescript(y) + ", while [Arian eir] pussy's contractions begin truly milking you for all you're worth.  Stuck as you are, you have no option but to sit back and enjoy [Arian eir] contractions as you feel yourself nearing the edge of an inevitable orgasm.");
	
	outputText("\n\nYou still can't quite drown your surprise at how this is making [Arian em] act, but if that's what [Arian ey] wants.  Besides, with the vice-like grip [Arian eir] holes have on your cocks, it's not as if you have a choice, right?  You thrust two, three more times with all the ferocity you can muster, grab [Arian eir] ass and holler as your climax finally erupts from your twin dicks.");
	
	//(Low Cum Amount)
	if (player.cumQ() <= 250) {
		outputText("\n\nYour " + player.multiCockDescriptLight() + " explode inside Arian's eager holes, giving them the liquid warmth they so crave.  The massage that your two cocks are receiving only enhance the intense feeling, and you find yourself cumming more than usual.  They don't stop massaging you for more, even as you stop unloading.");
		
		outputText("\n\n\"<i>More, I need more for my eggs!</i>\" Arian demands, yet you are truly spent...");
	}
	//(Medium Cum Amount)
	else if (player.cumQ() <= 1000) {
		outputText("\n\nLiquid lust floods Arian's insides, as your " + player.multiCockDescriptLight() + " do their best to relieve ");
		if (player.balls == 0) outputText("themselves");
		else outputText("your [balls]");

		outputText(" of their load; a load Arian is not only pleased to accept, but also eager to relieve you of every single stray drop off.  The tightness of [Arian eir] ass, pressing down on your " + player.cockDescript(y) + ", [Arian eir] pussy milking on your " + player.cockDescript(x) + ".  How could anyone refuse such an invitation?  You let yourself go, stuffing the eager lizan with more cum than you thought yourself capable of producing.");
		
		outputText("\n\n\"<i>M-more,</i>\" Arian pleads, even as [Arian eir] belly starts to distend.");
	}
	//(High Cum Amount)
	else {
		outputText("\n\nYou cum with such force, that if Arian's ass wasn't clamping down on your " + player.cockDescript(y) + " so tightly, you'd be sure [Arian ey] was going to get pushed off.  \"<i>So much cum!  Yesssss!</i>\" Arian moans, as you quickly give [Arian eir] usually lithe belly a very blatant bump.  Even though your prodigious amount of cum is enough to completely fill the eager lizan-girl, [Arian eir] ass and pussy work overtime to ensure you're completely spent; and you have no desire to resist.");
		
		outputText("\n\nBy the time you're finished, Arian's belly is positively bulging.  \"<i>Ahhh... eggs... cum... yes...</i>\" [Arian ey] states in a stupor.");
	}
	outputText("\n\nArian's ass goes slack around your " + player.cockDescript(y) + ", and Arian slowly slides off your shaft to plop on [Arian eir] bed; eyes closed in bliss, as [Arian ey] takes a short nap.");
	
	//(if ArianDblPenChat == 0)
	if (flags[kFLAGS.ARIAN_DOUBLE_PENETRATION_CHAT] == 0) {
		outputText("\n\nBreathing a sigh of relief, you gently pat Arian on the ass and comment that you didn't expect [Arian em] to be so eager to lay a batch of fertilized eggs, and you certainly didn't expect [Arian em] to be so... bossy.");
		
		outputText("\n\nArian's eyes snap open and [Arian ey] quickly rolls around to look you in the eyes.  \"<i>Oh my!  Please, forgive me, [name].  I swear I don't know what came over me.  It was... sorry!</i>\"  [Arian Ey] bows [Arian eir] head down in shame.");
		
		outputText("\n\nYou just laugh.  So, it looks like [Arian ey] wasn't really in control, huh?  Well, you should have figured [Arian ey]'d have problems with it; this is a situation [Arian ey] was never really supposed to be in, after all.");
		
		outputText("\n\n\"<i>I'm really sorry...</i>\"");
		
		outputText("\n\nYou tell [Arian em] that [Arian ey] doesn't need to apologise, but you do need to know; are you going to be a father now?  Is [Arian ey] really pregnant as a result of the sex you just had with [Arian em]?");
		
		outputText("\n\nArian shakes [Arian eir] head.  \"<i>Not really.  I didn't have a clutch of eggs for you to fertilize, so the answer is no,</i>\" [Arian ey] says, with a slight tinge of disappointment.");
		
		outputText("\n\nYou ask why [Arian ey] sounds so disappointed; [Arian ey] lived [Arian eir] life as a male before [Arian ey] met you - does [Arian ey] really want to embrace womanhood so thoroughly as to lay a clutch of eggs?");
		
		outputText("\n\nArian covers [Arian eir] face and shakes [Arian eir] body in a way that you can only describe as... girly.  \"<i>Sorry, I have all these urges, and... well... I wouldn't be opposed to laying a clutch fathered by you, to be honest.</i>\"");
		
		outputText("\n\nYou're not sure what to say about that, so you simply ask if [Arian ey] enjoyed herself.");
		
		outputText("\n\n\"<i>Very much!</i>\"  Arian grins happily.  You smile and pat [Arian em] on the head, telling [Arian em] that's good to hear; maybe you should do this again sometime?");
		
		outputText("\n\n\"<i>I'd like it if we did.</i>\"");
		
		outputText("\n\nYou tell [Arian em] you'll remember that, then politely redress and make your way out of [Arian eir] ");
		if (!arianFollower()) outputText("bedchambers");
		else outputText("tent");
		outputText(".");
	}
	else {
		outputText("\n\nBreathing a sigh of relief, you gently pat Arian on the ass and comment that it's always a surprise how [Arian ey] acts bossy when you're having sex like that.");
		
		outputText("\n\nArian lazily opens [Arian eir] eyes and rolls around to face you, rubbing [Arian eir] belly.  \"<i>Hmm, I don't know why I act like that.  I just can't control it.</i>\"");
		
		outputText("\n\nYou tell [Arian em] it's actually funny to see [Arian em] change like that, since normally [Arian ey] would never demand anything of you.  You would never have guessed [Arian ey] had that... bossy side to [Arian eir].  Arian bites [Arian eir] lower lip.  \"<i>Sorry about that by the way.</i>\"");
		
		outputText("\n\nYou shake your head, telling [Arian em] it's no trouble then gently pat [Arian em] on [Arian eir] head and re-dress, excusing yourself out of [Arian eir] ");
		if (!arianFollower()) outputText("bedchambers");
		else outputText("tent");
		outputText(".");
	}
	player.orgasm();
	dynStats("sen", -2);
	doNext(camp.returnToCampUseOneHour);
}

//Docking
//ArianCockSize needs to be below 3. (ArianDblCock does not affect this decision.) 
//PC cock area must be <= 30.
private function arianDocking():void {
	clearOutput();
	flags[kFLAGS.ARIAN_VIRGIN] += 1;
	arianHealth(3);
	if (flags[kFLAGS.ARIAN_VAGINA] > 0)	
		outputText(images.showImage("arianfemale-home-docking"));	
	else	
		outputText(images.showImage("arianmale-home-docking"));
	outputText("You set your eyes on Arian's genital slit, and then smile at [Arian em].  You ask how [Arian ey]'d feel about ‘hiding' your cock, rather than [Arian eirs], inside [Arian eir] slit?");
	
	outputText("\n\nArian shudders a bit.  \"<i>That... would feel kinda weird, I think, but it's not unheard of among certain lizan couples.  If you want to try that, I'm okay with it.</i>\"");
	
	outputText("\n\nYou tell [Arian em] that, yes, you want to try it - you're sorry, but it just sounds so kinky; and besides that, ");
	//(if ArianDblCock == 0)
	if (flags[kFLAGS.ARIAN_DOUBLE_COCK] == 0) {
		outputText("didn't [Arian ey] always want to have two dicks?  Well, now it's [Arian eir] chance to find out what it'd be like.");
	}
	else {
		outputText("[Arian ey]'s already hiding two in there... an extra cock won't make such a huge difference, would it?");
	}
	
	outputText("\n\n\"<i>I suppose you're right.  Okay then, let's try.</i>\"  Arian lays on [Arian eir] back, spreading [Arian eir] legs to give you access to [Arian eir] genital slit, gently touching the soft folds that hide [Arian eir] ");
	if (flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText("pair of ");
	outputText("pecker");
	if (flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText("s");
	outputText(" from your prying eyes.");
	
	outputText("\n\nYou gently push away [Arian eir] hands, running your fingers over the strange, almost woman-like folds, rubbing against the soft, smooth scales that cover [Arian em] there.  You gently massage [Arian em], making [Arian em] groan softly at the stimulation, before working up the courage to begin gently probing inside.  It's wet and slick, the muscles squeezing your fingers tightly, and you don't have too far to go before you can feel yourself touching the bulbous, unmistakable shape");
	if (flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText("s");
	outputText(" of Arian's dick");
	if (flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText("s");
	outputText(".  You brush your fingers against the tip");
	if (flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText("s");
	outputText(", seeing what kind of reaction that will elicit from your scaly lover.");
	
	outputText("\n\nArian groans.  \"<i>Hmm, if you keep doing that, I won't be able to keep it inside for you.</i>\"");
	
	outputText("\n\nYou tell [Arian em] that would be a crying shame, and gently remove your fingers.  Arian whimpers in disappointment.  \"<i>Awww, I was fine with having a handjob instead.</i>\"  [Arian Ey] smiles mischievously at you.");
	
	outputText("\n\nOh no, you tell [Arian em]; you started out with something more unusual in mind, and you're going to finish it.  Quickly giving your own [cock smallest] a few strokes to help coax it into the right mindset, you aim it into Arian's cock-slit and, looping your arms around [Arian eir] neck for balance, begin to press forward and gently feed it into the literal boy-pussy.");
	
	outputText("\n\nThe fit is so very tight, warmer than the rest of [Arian em] for reasons you don't care enough to contemplate at this moment, and slick with lubricating fluids.  It's so strange, yet so hot... and once you have your [cock smallest]");
	if (flags[kFLAGS.ARIAN_DOUBLE_COCK] == 0) outputText(" brushing up against [Arian eir] own lizan pecker");
	else outputText("sandwiched between [Arian eir] two lizard dicks");
	outputText(", the friction is absolutely incredible, sending sparks of pleasure cascading along your shaft.  You moan in delicious lust and tell Arian that this is absolutely incredible.");
	
	outputText("\n\nArian's expression is difficult to read; you can tell there is an obvious discomfort in the lizan's face, but at the same time, [Arian ey]'s panting in excitement.  \"<i>Ugh, It feels stuffed... but also good.  Your cock rubbing against my own... t-try moving your hips.</i>\"");
	
	outputText("\n\nYou shift your arms from around [Arian eir] neck to around [Arian eir] waist and do as [Arian ey] asks, pulling your hips back and then inserting them forward, just like you were trying to fuck a pussy.  The slimy, knobbly, bulbous texture of [Arian eir] ");
	if (flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText("twin cocks ");
	else outputText("cock ");
	outputText("slides across your intruding shaft as you go, and [Arian eir] sheathe-walls grip and squeeze as best they can, leaving you moaning and panting like a bitch in heat.  Arian's moans of pleasure join yours, [Arian eir] twitching bulbous shaft");
	if (flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText("s");
	outputText(" massaging your [cock smallest] almost like a vagina would.  Shaky hands grab a hold of your shoulders, helping you down and up on Arian's male slit.  \"<i>Oh, Marae!  It feels like I'm getting an internal handjob... it feEels so... so good!  H - harder... almost cumming!</i>\" [Arian ey] pleads, as [Arian ey] breathes hotly on your face; panting like a bitch in heat.");
	
	outputText("\n\nNot, you gasp back, if you don't come first... with that desperate promise (warning? Plea? Who cares?) you piston yourself back and forth four more times and then howl at the ceiling above as you cum into Arian's makeshift vagina.");
	
	//(Low Cum Amount)
	if (player.cumQ() < 250) {
		outputText("\n\nEven if your load is not that big to begin with; there is little room inside Arian's cramped genital slit, and you soon find yourself overflowing the little crevice.");
	}
	//(Medium Cum Amount)
	else if (player.cumQ() < 1000) {
		outputText("\n\nYour load is big enough to give females a bit of a potbelly, but Arian's slit being so shallow by comparison, means your cum practically erupts out of [Arian eir] overfilled crevice.");
	}
	//(high Cum Amount)
	else {
		outputText("\n\nYour prodigious load is so huge, not even goblins can hope to hold all of it inside.  So it's no wonder all it takes is a single jet to make Arian's little crevice erupt with backflow of your cum, painting your belly as well as Arian's with a perverted geyser of white.");
	}
	
	outputText("\n\nSpent, you slump down on the lizan's [arian chest].  With a sense of urgency Arian looks pleadingly at you, feebly pushing your shoulders away.  \"<i>P-pull out, please!</i>\"");
	
	outputText("\n\nYou ask [Arian em] what's wrong, too caught up in the feelings of your release to obey [Arian em] immediately. \"<i>Need... to cum... no room!</i>\" [Arian ey] says, groaning.  Realizing what's wrong, you hasten to obey - you don't want [Arian em] to burst!  You pull your cum-slick shaft from [Arian eir] cock-slit, waiting to see if [Arian ey]'ll manage to poke [Arian eir] own cock");
	if (flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText("s");
	outputText(" out before cumming.");
	
	outputText("\n\nArian groans in relief as a small white eruption comes out of [Arian eir] cum-filled slit, soaking [Arian eir] white scales in your combined jism.  Then, a ");
	if (flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText("pair of cummy masts emerge");
	else outputText("cummy mast emerges");
	outputText(" to feebly shoot a couple more ropes of jism, before returning limply to ");
	if (flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText("their");
	else outputText("its");
	outputText(" hiding place.  \"<i>Ahhh,</i>\" is all Arian says, before slumping down.");
	
	outputText("\n\nYou pat [Arian em] on the shoulder in a friendly fashion and, with a wicked grin on your face, ask if [Arian ey] enjoyed that too.");
	
	outputText("\n\nArian sighs and looks at you.  \"<i>It was good.  Weird... but good.  Though, I don't think I'd ever felt so much pressure on my balls before; if you hadn't pulled out in time, I might have busted a nut.</i>\"  [Arian Ey] smiles tiredly.");
	
	outputText("\n\nYou draw [Arian em] into a deep kiss, holding [Arian em] tight and kissing [Arian em] until [Arian eir] need for air forces you to disengage. Cocking your head to the side, you stroke [Arian eir] face gently, telling [Arian em] that you're glad [Arian ey] wasn't hurt. After all, you need your little lap-lizard in tiptop shape.");
	
	outputText("\n\nArian gives you a winning grin.  \"<i>I wonder why,</i>\"  [Arian ey] says, rubbing at [Arian eir] used slit.");
	
	outputText("\n\nYou tell [Arian em] the sex is nice, but there's other things in [Arian eir] favor too.  Then, you kiss [Arian em] again before [Arian ey] can ask what those are.  While [Arian ey]'s left reeling, blissed out and goofy from the sexual overwhelm, you quietly slip out of [Arian eir] bed, pull your clothes back on and slip away, blowing [Arian em] a kiss before you depart.");
	
	//Player returns to camp
	player.orgasm();
	dynStats("sen", 1);
	doNext(camp.returnToCampUseOneHour);
}

//Give Item
private function giveArianAnItem():void {
	clearOutput();
	outputText("Thinking about the many items in your possession, you ask if Arian would be willing to take something for you?");
	
	//(if ArianHealth < 10) //May not give anything.
	if (flags[kFLAGS.ARIAN_S_DIALOGUE] < 1) {
		outputText("\n\n\"<i>Uhh... I'd rather not.  I'm not feeling very well, and I don't think it's wise for me to be drinking anything, well... strange.</i>\"");
		
		outputText("\n\nYou nod your head in understanding and change the subject; if you want to give Arian any of the potions you've found, you'll need to nurse him back to strength first.");
		//Display other Arian interaction options
		arianHomeMenu();
		return;
	}
	else if (flags[kFLAGS.ARIAN_HEALTH] < 20) { //May only give Vitality T.
		outputText("\n\n\"<i>Is it medicine you've brought me?  If so I'll be happy to take it; otherwise I think we should wait until I'm better; especially after that scolding you gave me earlier...</i>\"");
		
		//If PC has Vitality T. go to Give VT section. Otherwise, play below:
		if (!player.hasItem(consumables.VITAL_T)) {
			outputText("\n\nYou admit you don't have any medicine on you at the moment, and change the subject.");
			arianHomeMenu();
			return;
		}
		//Display other Arian interaction options
	}
	else { //Anything goes baby.
		outputText("\n\n\"<i>Well, I guess it's okay.  I don't think you'd ever give me anything harmful, and if you have anything to... err... spice up the sex, I'd be happy to take it.</i>\"  Arian blushes.");
		//Display PC inventory
	}
	
	menu();
	if (flags[kFLAGS.ARIAN_S_DIALOGUE] == 0 && arianHealth() >= 10) arianStoryDialogue1();
	else if (flags[kFLAGS.ARIAN_S_DIALOGUE] == 1 && arianHealth() >= 20) arianStoryDialogue2();
	else if (flags[kFLAGS.ARIAN_S_DIALOGUE] == 2 && arianHealth() >= 30) arianDialogue3();
	else if (flags[kFLAGS.ARIAN_S_DIALOGUE] == 3 && arianHealth() >= 50) arianImbue();
	else if (flags[kFLAGS.ARIAN_S_DIALOGUE] == 4 && arianHealth() >= 75) arianPlot4();
	else if (flags[kFLAGS.ARIAN_S_DIALOGUE] == 5 && arianHealth() >= 100) arianPlot5();
	else {
		if (player.hasItem(consumables.VITAL_T)) addButton(0,"Vital Tinct",arianVitalityTincture);
		if (flags[kFLAGS.ARIAN_HEALTH] >= 20) {
			if (player.hasItem(consumables.P_DRAFT)) addButton(1,"P. Incubi D",giveIncubusDraftToArian);
			if (player.hasItem(consumables.P_S_MLK)) addButton(2,"P. Suc.Milk",succubiMilkForArian);
			if (player.hasItem(consumables.LACTAID)) addButton(3,"Lactaid",giveArianLactaid);
			if (player.hasItem(consumables.REDUCTO)) addButton(4,"Reducto",giveArianReducto);
			if (player.hasItem(consumables.REPTLUM)) addButton(5,"Reptilum",giveArianReptilum);
		}
		addButton(14,"Back",arianHomeMenu);
	}
}

//Vitality Tincture:
//increases ArianHealth by 4.
//Remove this option once Arian's health hits 100.
private function arianVitalityTincture():void {
	clearOutput();
	outputText("Fishing around amongst your pockets, you withdraw a vial of that strange potion Giacomo peddles and offer it to the sickly lizan, explaining it will bolster [Arian eir] constitution and fill [Arian em] with permanent vitality.");
	
	outputText("\n\nArian smiles gratefully at you.  \"<i>Thanks for doing this for me, [name].</i>\"");
	
	outputText("\n\nYou tell [Arian em] it's no trouble, then smirk and note it's not as if that sleazy peddler's hard to find out there in the wasteland, anyway.  You see the look on the lizan's face and hasten to assure [Arian em] that you're certain the potion works, you just don't trust that weasely merchant as far as you can throw him.");
	
	outputText("\n\n\"<i>If you say so...</i>\" Arian takes the potion and uncorks the vial.  \"<i>Here goes.</i>\"  [Arian Ey] chugs the potion down at once, making a face once [Arian ey]'s done.  \"<i>Ugh... If I didn't know better I'd say you're trying to murder my taste buds.</i>\"");

	outputText("\n\nSurely it's not that bad?  The potion smelled vaguely like cherries, it can't be as bad as Arian is making it to be...");
	
	outputText("\n\nArian shakes [Arian eir] head.  \"<i>It's medicine... medicine is never good.  And it has cherries.  I hate cherries,</i>\" Arian notes in disgust.");
	
	outputText("\n\nYou apologize, but, hey, medicine just tends to taste nasty anyway.  Still, it's doing [Arian em] the world of good, now isn't it?");
	
	outputText("\n\n\"<i>I guess I do feel better.  Thank you [name].</i>\" Arian smiles at you, already looking a bit better.");
	
	outputText("\n\nYou smile and stroke the lizan gently on [Arian eir] head, telling [Arian em] that [Arian ey]'s welcome.  Now, you think it's time [Arian ey] laid [Arian em]self back down and got some rest; give the medicine time to work.  You promise you'll try and come back to see [Arian em] later, but right now, [Arian ey] needs to get some more rest.  Arian nods and settles [Arian em]self on [Arian eir] bed.");
	
	player.consumeItem(consumables.VITAL_T);
	arianHealth(10);
	menu();
	addButton(0,"Next",giveArianAnItem);
}

//P. Incubus Draft:
//Increase Cock(s) size. Gives one cock if Arian lacks any.
//If cock(s) size is maxed, next dose reduces breast size.
//If at min breast size, next dose reverts Arian to male. (Lose breasts and vagina.)
private function giveIncubusDraftToArian():void {
	clearOutput();
	player.consumeItem(consumables.P_DRAFT);
	outputText("Fishing around in your pockets, your hand closes on the vial of purified incubus draft.  You offer this to Arian, asking ");
	if (flags[kFLAGS.ARIAN_COCK_SIZE] > 0) outputText("if [Arian ey] would like to make [Arian eir] cock bigger");
	else outputText("if [Arian ey]'d like to have a touch of [Arian eir] old malehood back");
	outputText(".");
	
	outputText("\n\nArian blushes.  \"<i>I don't mind the way I am now, but if you want me to take it I'd be happy to.</i>\"  Arian smiles nervously at you.");
	
	outputText("\n\nYou tell [Arian em] that you would like [Arian em] to take it, and hold it out to the lizan with greater emphasis.  Arian takes the draft, uncorks it and chugs it down.");
	
	if (flags[kFLAGS.ARIAN_COCK_SIZE] == 0) {
		flags[kFLAGS.ARIAN_COCK_SIZE]++;
		outputText("\n\nThe changes start at once.  Arian shudders as a wave of arousal hits [Arian em] and quickly opens [Arian eir] robes to watch in awe as a slit appears above [Arian eir] juicy feminine cunt.  It overflows with natural lubricant, and for a moment you think Arian is growing a second vagina.  The thought is quickly forgotten as you watch a reptilian, bulbous, purple dick emerge from its depths; it grows to an average size before Arian moans and cums, spraying herself with [Arian eir] newly acquired tool.");
		
		outputText("\n\nYou make a show of smirking and shaking your head.  My, but Arian needs to work on [Arian eir] control, now doesn't [Arian ey]?  To think [Arian ey]'d cum just from growing a sweet little cock like this.  You reach out and stroke the hermaphroditic member, gently trailing your fingers across its reptilian bumps and nodules.  A tiny part of you shivers in anticipation of it plumbing into your ");
		if (player.hasVagina()) outputText("[vagina] and ");
		outputText("[asshole].");
		
		outputText("\n\n\"<i>Wait!  I'm still sensi-Ahhh!</i>\"  Arian's shaft throbs and another jet of cum arches through the air to hit [Arian em] squarely on [Arian eir] face.  Panting, Arian says, \"<i>I-I think I need a rest now...</i>\"  [Arian Ey] collapses on [Arian eir] bed, prehensile, reptilian tail waving about in a display of enjoyment.");
		
		outputText("\n\nA part of you wonders if maybe [Arian ey]'s hoping you'll join [Arian em] in bed, but then you take a closer look and concede that [Arian ey] is genuinely tired.  You stroke [Arian em] affectionately on [Arian eir] scaly cheek and politely excuse yourself, heading back to camp.");
		dynStats("lus", 10+player.lib/20);
	}
	else if (flags[kFLAGS.ARIAN_COCK_SIZE] < 3) {
		flags[kFLAGS.ARIAN_COCK_SIZE]++;
		dynStats("lus", 10+player.lib/20);
		outputText("\n\nThe changes start at once. Arian shudders as a wave of arousal hits [Arian em] and quickly opens [Arian eir] robes to watch [Arian eir] ");
		if (flags[kFLAGS.ARIAN_DOUBLE_COCK] == 0) outputText("shaft emerges from its hiding place.  It throbs and grows, settling in its");
		else outputText("pair of shafts emerge from their hiding place.  They throb and grow, settling in their");
		outputText(" new size as Arian moans and cums all over [Arian em]self.");
		
		outputText("\n\nYou gently flick a strand of cum off of the lizan's belly.  So, how does [Arian ey] like the new and improved lizard cock?  Arian swallows audibly and tries to retract [Arian eir] cock");
		if (flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText("s back into their");
		else outputText(" back into its");
		outputText(" slit.");
		if (flags[kFLAGS.ARIAN_COCK_SIZE] == 2) {
			flags[kFLAGS.ARIAN_COCK_SIZE]++;
			dynStats("lus", 10+player.lib/20);
			outputText("\n\n[Arian Ey] manages to tuck it in, although you have the impression you wouldn't have to reach too far inside to feel its tip.");
			
			outputText("\n\n\"<i>It's a tight fit, but I think I can still keep it inside,</i>\" Arian sighs in pleasure.  \"<i>It did feel good though; thank you, [name].</i>\"");
			
			outputText("\n\nYou smirk and tell [Arian em] that maybe you'll ask [Arian em] to show you how it feels in an up-close and private demonstration later, but, for now, you'll let [Arian em] get some sleep.  Arian nods, blushing.  \"<i>I'm looking forward to it.</i>\"  [Arian Ey] smiles nervously at you.");
			
			outputText("\n\nYou smirk and pat [Arian eir] head, tell [Arian em] you'll come back for it when you can, and then politely excuse yourself.");
		}
		else {
			outputText("\n\n[Arian Ey] manages to retract ");
			if (flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText("them");
			else outputText("it");
			outputText(" until two thirds are inside, then it doesn't looks like [Arian ey] can take in anymore.");
			
			if (flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText("\n\n\"<i>W-Wow, they're so big I can't even manage to hide them,</i>\" Arian pants as the tip of [Arian eir] cocks hang limply, exposed for all to see.");
			else outputText("\n\n\"<i>W-Wow, it's so big I can't even manage to hide it,</i>\" Arian pants as the tip of [Arian eir] cock hangs limply, exposed for all to see.");

			outputText("\n\nYou can't resist reaching down and gently tweaking the exposed tip.  Mmm... your little " + arianMF("boy-toy","herm-toy") + " is going to be a very naughty thing from now on, you tease, unless [Arian ey] intends to start wearing a loincloth?");
			
			outputText("\n\nArian shudders at your touch.  \"<i>I-I'd have to ask Boon for one of [Arian eir].  I don't have any here.</i>\"  Arian blushes.");
			
			outputText("\n\nYou smile playfully at [Arian em] and ask if [Arian ey] would like you to go and fetch one now?");
			
			outputText("\n\n\"<i>N-No!  I couldn't stand it if Boon and Laika found out I look like this,</i>\" Arian says, pointing towards [Arian eir] exposed shaft");
			if (flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText("s");
			outputText(".");
			
			//if ArianHerm:
			if (flags[kFLAGS.ARIAN_VAGINA] > 0) {
				outputText("\n\nYou can't resist quirking an eyebrow and asking if this is really more embarrassing than revealing that [Arian ey]'d grown an egg-filled womb and a pussy to use with it?  \"<i>Well, yes!  They'll give you a hard time too for getting me to do this, you know?</i>\" Arian protests.");
				
				outputText("\n\nYou smile and tap [Arian em] playfully on the nose, pointing out the difference between you and [Arian em] is that you don't care what two overprotective ferrets have to say about how [Arian ey] looks.  You think [Arian ey]'s hot like this.  Arian blushes at that.  \"<i>Then... I'll go without wearing a loincloth?</i>\"  You tell [Arian em] that'd be very naughty, but you think it'd be kind of sexy, too.  Arian smiles nervously, \"<i>Ok, then that's what I'll do... c-can't wait to use it...</i>\" [Arian Eir] tip");
				if (flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText("s");
				outputText(" starts hardening, no longer able to hide Arian's excitement inside [Arian eir] protective slit.");
			}
			else {
				outputText("\n\nYou admit it probably would be a bit embarrassing, especially if Boon's bigger than Arian is now.  Arian blushes.  \"<i>Well, [Arian ey] really isn't. If anything it might be tight.  I might have to go without one...</i>\"");
				
				outputText("\n\nYou raise an eyebrow, and ask if [Arian ey]'s not secretly at least a little happy about that?  After all, big dicks seem to be pretty admired in this sex-mad world.  Arian looks away in embarrassment, but smiles all the same.  \"<i>It is pretty big isn't it?  I guess it's not that bad.</i>\"");
				
				outputText("\n\nYou point out you wouldn't have given the lizan such a big dick if you didn't think they were sexy.  To be honest, you'd kind of like to know [Arian ey] was going around with this impressive monster hanging out under [Arian eir] robes; it's very flattering.  \"<i>T-then I won't use one.</i>\"  Arian's cock hardens a bit.  \"<i>Although it might be hard to hide my... urges.</i>\"  Arian looks at you nervously.");
			}
			outputText("\n\nYou give the lizan a kiss on the cheek, and ask if [Arian ey]'s sure [Arian ey] doesn't want to give it a test run before you go.  Arian's cock hardens, pointing at you and throbbing at the idea, even as a small droplet of cum gathers on [Arian eir] tip; Arian fumbles and makes an attempt to hide [Arian eir] excitement.  \"<i>T-this is going to take some getting used to...</i>\"");
			
			outputText("\n\nYou apologize and tell the lizan you've teased [Arian em] enough; you'll give [Arian em] a chance to calm down, and politely excuse yourself to head back to camp.");
		}
	}
	//(else if ArianBreasts > 1) //Boob shrinkage.
	if (flags[kFLAGS.ARIAN_BREASTS] > 1 && (!flags[kFLAGS.HYPER_HAPPY])) {
		flags[kFLAGS.ARIAN_BREASTS]--;
		outputText("\n\nArian shudders as [Arian ey] feels the changes sweep through [Arian em], but rather than settling on [Arian eir] huge lizan shaft, the warmth that precedes change settles on [Arian eir] breasts.  Arian moans and kneads [Arian eir] mounds as they shrink to a smaller size.");
		outputText("\n\n\"<i>Well, at least my chest won't feel so heavy anymore.  I hope you're not disappointed?</i>\" Arian asks, panting.");
		outputText("\n\nYou just smile back at [Arian em] and tell [Arian em] you can live with it.  Arian sighs.  \"<i>Good, they did feel kinda nice, though.</i>\"  You detect a hint of disappointment in [Arian eir] voice.");
		outputText("\n\nConfused, you comment that Arian was hatched as a boy; you'd have thought [Arian ey]'d be more comfortable to be flatter up there.  Arian blushes. \"<i>I-....  You've convinced me there are... perks related to that.</i>\"  Arian bites [Arian eir] lower lip.  \"<i>Not that I miss having big breasts.  My back will also thank me, but they did feel nice and....</i>\"  Arian giggles.  \"<i>Laika would always give me the funniest looks, since [Arian ey]'s kinda... flat.</i>\"");
		
		outputText("\n\nYou wonder if maybe Laika had ulterior motives for those looks, but keep that thought to yourself. You ask if Arian would like to do something, or if you should leave [Arian em] to get on with [Arian eir] work? Arian looks at you expectantly. \"<i>I wouldn't refuse if you wanted to do anything.</i>\", [Arian eir] dick growing hard at your suggestion.");
		//Display sex menu
		arianSexMenu(false);
		return;
	}
	else if (flags[kFLAGS.ARIAN_BREASTS] == 1 && (!flags[kFLAGS.HYPER_HAPPY])) { //Now you are male again.
		outputText("\n\nArian shudders as [Arian ey] feels the changes sweep through [Arian em], but rather than settling on [Arian eir] huge lizan shaft, the warmth that precedes change settles on [Arian eir] breasts.  Arian moans and kneads [Arian eir] mounds as they shrink until they are completely gone.  [Arian Eir] nipples follow suit, being replaced by smooth scales.");
		
		outputText("\n\nArian moans as another change happens below; [Arian ey] spreads [Arian eir] legs and watch in wonder as the lips [Arian eir] wet fuckhole join together, becoming smooth scales as well.  A few more subtle changes occur as Arian's body shift towards the masculine and finally settles down.  Arian breaths a sigh of relief.");

		outputText("\n\n\"<i>I guess I'm male now?</i>\" Arian's voice sounds more masculine as well.");
		flags[kFLAGS.ARIAN_BREASTS] = 0;
		flags[kFLAGS.ARIAN_VAGINA] = 0;
		outputText("\n\nYou note that seems to be the case.  So, is [Arian ey] going to miss being even half-girl?  Arian rubs [Arian eir] chin.  \"<i>Well, it was weird, but it was kinda nice too.</i>\"  [Arian Ey] looks at you, smiling nervously.  \"<i>I'd spend some time in the mornings looking in the mirror.  I guess I didn't look so bad as a girl?</i>\"");
		outputText("\n\nYou note that [Arian ey] was quite pretty, but you think [Arian ey]'s just as handsome now.  Besides, being all-guy means no more dealing with eggs, right?");
		outputText("\n\nArian blushes, averting [Arian eir] eyes in embarrassment.  \"<i>It wasn't that bad... the whole deal with the eggs I mean.</i>\"");
		outputText("\n\nHe can really say that?  After actually going through the painful process of laying them?  Because, if [Arian ey] can, well, you think you'd have to call Arian one of the manliest men you've met in this world.");
		
		outputText("\n\nArian smiles at you.  \"<i>It didn't hurt that much.</i>\"  Then [Arian ey] blushes.  \"<i>It felt kinda nice... actually.</i>\"");
		
		outputText("\n\nYou just shake your head and clap him on the shoulder.  Well, maybe you'll give him [Arian eir] vagina back, if [Arian ey] really didn't mind being half-girl that much.  But, right now, you think [Arian ey] should try and get used to being all-man again.");
		
		outputText("\n\nArian averts [Arian eir] eyes.  \"<i>Of course.  If that's what you think.</i>\"");
		
		outputText("\n\nYou reply that is what you think.  So, does [Arian ey] feel up to doing anything else, or should you leave him to get some rest?");
		
		outputText("\n\nArian's cock begins hardening.  \"<i>Well, I wouldn't mind doing anything else... if you want to.</i>\"");
		
	}
	else { //Nothing happens.
		outputText("\n\nArian moans and you can see [Arian ey]'s getting turned on, if the hardening tip of [Arian eir] exposed shaft is any indication, but you don't detect any change besides that.");
		outputText("\n\n\"<i>I guess this is my limit?</i>\" Arian pants.");
		outputText("\n\nYou admit that seems to be the case, and ask if [Arian ey]'d be willing to do something else, seeing as how that was a bust?  \"<i>Uhh... Sure.  What do you want to do?</i>\"");
	}
	//Back to Arian's Menu
	menu();
	addButton(0,"Next",giveArianAnItem);
}



//P. Subbi's Milk:
//Gives Vagina and Breasts, also feminine curves if Arian was male.
//Extra doses increase breasts size.
//If breasts is at maximum size, extra doses reduce Cock Size. Removing first the second cock and then the first one if necessary.
private function succubiMilkForArian():void {
	clearOutput();
	player.consumeItem(consumables.P_S_MLK);
	outputText("Fishing out the bottle of purified demon's milk, you ask if Arian is willing to get ");
	if (flags[kFLAGS.ARIAN_VAGINA] > 0) outputText("further ");
	outputText("in touch with [Arian eir] feminine side.  For you?");
	
	outputText("\n\nArian bites [Arian eir] lower lip.  \"<i>For you?  Of course I wouldn't mind it.</i>\"  You pass over the bottle, and watch as [Arian ey] removes the cork and drinks its contents.");
	
	//(if ArianVagina == 0) //Arian... you look so pretty!
	if (flags[kFLAGS.ARIAN_VAGINA] == 0) {
		flags[kFLAGS.ARIAN_VAGINA]++;
		if (flags[kFLAGS.ARIAN_BREASTS] == 0) flags[kFLAGS.ARIAN_BREASTS]++;

		outputText("\n\nArian gasps and moans, a throaty, girly moan. [Arian Ey] opens [Arian eir] robes to watch as the changes sweep through [Arian eir].  First the smooth scales of [Arian eir] chest begin flaking off, making way for a pair of erect nipples; following the growth of said nipples, [Arian eir] previously flat chest begins inflating, growing into perky scaly breasts.  Down below, Arian feels a wave of heat gather between [Arian eir] legs; once [Arian ey] spreads them, [Arian ey] gasps.  A slit appears, the surrounding scales become smaller and softer, forming what looks like a tight little pussy.  Arian's newly formed labia puff up and juices begin flowing freely from the moist passage, even as Arian's little pleasure buzzer appears to slightly part [Arian eir] labia in a clear invitation for you to explore its depths.");
		outputText("\n\nYou drag your eyes away from Arian's new vagina and look the newly hermified lizan in the eyes, asking if [Arian ey] feels all right.  Arian pants, questing hands wandering towards [Arian eir] breasts to gently grope them. \"<i>Hot... so hot...</i>\" Arian's shaft hangs fully out of its hiding place, rock hard and throbbing.");
		outputText("\n\nYou tell [Arian em] you'll get [Arian em] something cold to drink, turning towards the door.  \"<i>H-hurry, please!</i>\"  You need no further encouragement and quickly race to the kitchen, where you grab a jug of water from the coldbox and run back with it, as quickly as you dare.");
		
		outputText("\n\nAs soon as you enter Arian's room, [Arian ey] sweeps the jug from your hands and begins downing the water.  You watch in amazement as Arian drains the jug of all its water, some stray droplets falling on [Arian eir] exposed scales, forming small rivulets that trace Arian's increasingly feminine curves.  Once Arian is done [Arian ey] sighs with relief, quietly handing you the jug and wiping [Arian eir] lips with a forearm.  \"<i>Thanks, [name].  I really needed that.</i>\"  Arian smiles at you, no longer hot to the point of boiling.  [Arian Eir] previously erect cock");

		if (flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText("s");
		outputText(" having already softened and retracted");
		//if ArianCockSize >= 3:
		if (flags[kFLAGS.ARIAN_COCK_SIZE] == 3) outputText(" as far as it'll go");
		outputText(" into its protective slit.");
		
		outputText("\n\nYou cautiously ask if Arian is feeling okay; [Arian ey]'s just undergone quite the dramatic change.  Arian looks herself over, running [Arian eir] hands across [Arian eir] newly feminized body.  \"<i>I guess I'm fine.  I certainly feel fine, at least.</i>\"");
		
		outputText("\n\nYou can't help noting [Arian ey] looks pretty fine, too.  Arian blushes at your comment.  \"<i>Umm... thanks.</i>\"  One of Arian's questing hands find [Arian eir] newly formed slit, and [Arian ey] gasps in pleasure as [Arian ey] circles [Arian eir] soft labia with a clawed finger, smearing some of [Arian eir] juices on [Arian eir] finger.  [Arian Ey] lifts the finger to [Arian eir] face and watch the moisture drip from [Arian eir] digit; then, without sparing a thought, [Arian ey] takes the finger into [Arian eir] mouth and begin lightly sucking on the digit.");
		
		outputText("\n\nYou pointedly cough and tell [Arian em] that, while you're not necessarily minding if [Arian ey] wants to try out [Arian eir] new body, does [Arian ey] really want to put on a show for you, or would [Arian ey] rather you leave?  Arian snaps out of [Arian eir] trance, blushing in embarrassment.  \"<i>Oh! Sorry!</i>\"  Arian attempts to cover [Arian eir] breasts and crotch with [Arian eir] arms. [Arian Ey] fidgets a bit, then smiles nervously at you.  \"<i>Umm, Maybe you'd like to help me get used to my new body?</i>\" Arian averts [Arian eir] eyes, blushing furiously at what [Arian ey] just said.");
		outputText("\n\nYou step forward and gently run your hands over [Arian eir] newfound breasts. Well, if that's what [Arian ey]'s in the mood for, you're game.");

	}
	else if (flags[kFLAGS.ARIAN_BREASTS] < 3) {
		flags[kFLAGS.ARIAN_BREASTS]++;
		outputText("\n\nWarmth sweeps through Arian's body, eliciting a gasp and a moan.  Soon the warmth settles on Arian's mounds, and [Arian ey] opens [Arian eir] robes to gaze at the change that is taking place.");
		
		//(if ArianBreasts == 2)
		if (flags[kFLAGS.ARIAN_BREASTS] == 2) {
			outputText("\n\nArian's perky breasts inflate into perfect, soft-looking mounds.  Arian gropes [Arian eir] newly enlarged breasts tentatively and gasps in pleasure at their softness and sensitivity.  \"<i>It feels nice.</i>\"  Looking at you with a blush, Arian asks, \"<i>Would you like to touch them?</i>\"");
			
			outputText("\n\nSeeing no reason to pass up the opportunity, you reach out and gently take hold of them, rolling their weight around in your hands.  You make a show of remarking to Arian that you had no idea scaly boobs could be so wonderfully soft and perky.");
			
			outputText("\n\nArian gasps and sighs as you gently massage [Arian eir] breasts.  \"<i>[name]... this feels good.</i>\"");
			
			outputText("\n\nYou note it feels pretty nice for you as well.  Still, does Arian maybe want to turn things up a notch in the intimacy department?  Arian blushes.  \"<i>You won't hear me complain.</i>\"  [Arian Ey] starts fidgeting");
			if (flags[kFLAGS.ARIAN_COCK_SIZE] >= 3) outputText(" and [Arian eir] exposed shaft begins to grow hard");
			outputText(".");
		}
		else {
			outputText("\n\nArian's generous mounds inflate once more.  Arian gasps in pleasure, their growth also enhancing the lizan's sensitivity.  Once their expansion is finished, Arian lifts the huge orbs in awe.  \"<i>T-they're huge... and so heavy.</i>\"  [Arian Ey] rolls the breasts in [Arian eir] hands, gently touching [Arian eir] soft scales and sensitive nipples, gasping and panting in pleasure.");
			
			outputText("\n\nYou note they look pretty big as well; why, [Arian ey] must be the bustiest lizan you've ever seen.  Arian blushes, and bites [Arian eir] lower lip.  \"<i>Do you like them?</i>\"  You give [Arian em] a flat look and reach out to caress the breasts.  If you didn't like big breasts, well, why would you have asked [Arian em] to grow them this big?  But is [Arian ey] comfortable with them being like this?");
			outputText("\n\nArian shudders at your touch.  \"<i>They are kind of heavy, but if you really like them, I don't mind keeping them.</i>\"  Arian smiles nervously at you.  \"<i>I hope you will help me carry them?</i>\"  [Arian Ey] fidgets");
			if (flags[kFLAGS.ARIAN_COCK_SIZE] == 3) outputText(" and you see [Arian eir] exposed shaft slowly rising to point at you");
			outputText(".");
			
			outputText("\n\nYou cup the bountiful scaly bosom in your hands and tell [Arian em] that's something you're quite willing to do.  Still, perhaps [Arian ey]'d rather... take the weight off of [Arian eir] feet, mm?  You finish, leaning in to dart a playful lick across the tip of [Arian eir] snout to make your insinuations more obvious.");
			outputText("\n\nArian blushes furiously, but smiles at you all the same.  \"<i>I... would love to.</i>\"");
		}
	}
	//(else If ArianCockSize > 1) //Dick shrinkage.
	else if (flags[kFLAGS.ARIAN_COCK_SIZE] > 1 && (!flags[kFLAGS.HYPER_HAPPY])){
		outputText("\n\nWarmth flows throughout Arian's body, and [Arian ey] moans in obvious pleasure.  Then, [Arian ey] opens [Arian eir] robes and looks at [Arian eir] rock-hard bulbous shaft.  It throbs as if edging a massive orgasm, but much to Arian's surprise it starts to shrink, until it finally grows limp and hides itself in its protective slit.  \"<i>I... didn't expect that,</i>\" Arian remarks.");
		
		outputText("\n\nYou note it's not that surprising; the potion in question is a feminizer, so it must be shrinking away the only trace of [Arian eir] masculinity left - [Arian eir] cock");
		if (flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText("s");
		outputText(".  \"<i>Oh... that's good.  Right?</i>\" Arian looks at you nervously.  You think it over, and confess that while you are more attracted to women than men, you won't force Arian to become fully female if [Arian ey] doesn't want to.");
		outputText("\n\nArian smiles at your consideration.  \"<i>Thank you, [name], but if you'd prefer me to be a girl... err... completely female, I wouldn't object.  I'm fine either way.</i>\"  Arian grins.");
		
		outputText("\n\nYou ask, then, if Arian's so comfortable with [Arian eir] girly side, maybe [Arian ey]'d like to try out [Arian eir] more female parts?  Arian blushes and averts [Arian eir] eyes, nodding lightly.");
	}
	else if (flags[kFLAGS.ARIAN_COCK_SIZE] == 1 && flags[kFLAGS.ARIAN_DOUBLE_COCK] >= 1 && (!flags[kFLAGS.HYPER_HAPPY])) {
		outputText("\n\nWarmth flows throughout Arian's body, and [Arian ey] moans in obvious pleasure.  Then [Arian ey] opens [Arian eir] robes and looks at [Arian eir] pair of rock-hard bulbous shafts.  They throb as if edging a massive orgasm, but much to Arian's surprise they begin to merge, until only one reptilian dick remains; finally it grows limp and recedes into its hiding place.  \"<i>They fused into one,</i>\" Arian remarks.");
		
		outputText("\n\nMaybe it's because of the increasingly high femininity the milk is bestowing on [Arian em], you suggest?");
		
		outputText("\n\n\"<i>Maybe... that's good, right?</i>\" Arian asks.  You simply meet [Arian eir] gaze levelly and tell [Arian em] that it's good if [Arian ey] wants it to be good; if [Arian ey]'s uncomfortable with what you're doing to [Arian em], [Arian ey] needs to tell you and you'll stop, you promise.");
		
		outputText("\n\n\"<i>No!  I'm fine!</i>\" Arian insists.  \"<i>I'm just not used to, well... reshaping my body like this.  But if you think I look better this way, then I'm happy to comply.</i>\"  Arian smiles.");
		
		outputText("\n\nYou tell [Arian em] that, for what it's worth, you do think [Arian ey]'s beautiful, then give [Arian em] a lustful grin and ask if [Arian ey]'d like you to show [Arian em] just how beautiful?");
		outputText("\n\nArian blushes.  \"<i>I... show me...</i>\"");
		flags[kFLAGS.ARIAN_DOUBLE_COCK] = 0;
	}
	else if (flags[kFLAGS.ARIAN_COCK_SIZE] == 1 && (!flags[kFLAGS.HYPER_HAPPY])) {
		flags[kFLAGS.ARIAN_COCK_SIZE] = 0;
		outputText("\n\nWarmth flows throughout Arian's body, and [Arian ey] moans in obvious pleasure.  Then, [Arian ey] opens [Arian eir] robes and look at [Arian eir] rock-hard bulbous shaft.  It throbs and slowly recedes back into its hiding place.  An indignant rope of cum shoots into the air, splashing on [Arian eir] belly as the slit containing the last of [Arian eir] malehood finally closes up, leaving only smooth scales in its wake.  Arian pants, \"<i>Looks like I'm completely female now.</i>\"");
		
		outputText("\n\nYou agree with [Arian eir] summary, and then note [Arian ey]'s taking this quite calmly.  You mean, it had to be a shock just growing a pussy and laying eggs all the time, but now [Arian ey] doesn't even have [Arian eir] cock to go with it.");
		
		outputText("\n\nArian looks at you, blushing.  \"<i>Do you think I'm pretty?</i>\"");
		
		outputText("\n\nYou tell [Arian eir] that, yes, [Arian ey] makes a very pretty girl.");
		
		outputText("\n\nArian fidgets.  \"<i>Then, that's all I need.</i>\"  [Arian Ey] smiles at you.");
		
		outputText("\n\nYou just look at [Arian em] steadily; is [Arian ey] really sure about that?  You did this to [Arian eir], surely you can bring [Arian em] something to undo it, if only partially?");
		
		outputText("\n\nArian shakes [Arian eir] head.  \"<i>I'm fine, [name].  Really. If I didn't want or wasn't okay with anything I'd have said so by now.  So trust me when I say I'm fine.  Besides, this doesn't feel half bad, and I get to have you.</i>\"  [Arian Ey] blushes.");
		
		outputText("\n\n\"<i>Get to have you.... or perhaps,</i>\" you grin, \"<i>the proper question should be how, hmm?</i>\"");
		
		outputText("\n\nArian bites [Arian eir] lower lip.  \"<i>Umm, we could do something I guess.  If you're up for it?</i>\"  Arian fidgets.");
	}
	else { //Nothing happens.
		outputText("\n\nWarmth flows throughout Arian's body, and [Arian ey] moans in obvious pleasure.  But suddenly, the warmth goes away, and Arian opens [Arian eir] robes to inspect the changes.  Nothing seems changed.  \"<i>I guess I can't get any more girly than being an actual girl,</i>\" Arian remarks.");
		 
		outputText("\n\nYou note that's the obvious imposition.  Still, if [Arian ey] wants to at least grow [Arian eir] penis back, you're sure you can find [Arian em] something, you offer; [Arian ey]'s clearly devoted to you, a little token kindness won't hurt you, you think.");
		
		outputText("\n\nArian shakes [Arian eir] head.  \"<i>No, I'm fine.  Unless you want me to have a penis?</i>\"");
		
		outputText("\n\nYou tell [Arian em] that you'll think about it; right now, you want to take the all-new, all-girl [Arian em] out for a spin... if [Arian ey]'ll let you, of course?");
		
		outputText("\n\nArian smiles and fidgets. \"<i>I could go for a spin...</i>\"");
	}
	//Display Sex Options.
	arianSexMenu(false);
}
//Lactaid:
//Triggers Scene with temporary lactation
//If Arian has breasts, Increases breasts size by 1.
private function giveArianLactaid():void {
	clearOutput();
	player.consumeItem(consumables.LACTAID);
	outputText("Your hand closes around the vial of lactation-inducing potion that is Lactaid.  You almost reject it automatically, but then you stop and think.  There's odder things in this world, after all.  You remove the vial and ask Arian if [Arian ey] would be willing to let you see what lizan milk tastes like.");
	
	outputText("\n\n\"<i>I don't know.  Lizans don't actually lactate, since we lay eggs, so I don't know if this...</i>\"  Arian squints [Arian eir] eyes to read the label on the vial you're holding.  \"<i>...Lactaid will even work.  But if you want to try, I suppose it couldn't hurt... right?</i>\"  Arian smiles nervously.");
	
	outputText("\n\nYou assure the lizan that, at worst, it'd just fail to do anything, and hand the vial of lactaid to [Arian em].  [Arian Ey] takes the offered bottle and smiles at you.  \"<i>All right.</i>\"");
	
	outputText("\n\nArian removes the cork and downs thick milky liquid, passing you the emptied vial.  \"<i>That tasted kinda nice...</i>\"");
	
	outputText("\n\nThe two of you sit in awkward silence awaiting for anything to happen.");
	
	if (flags[kFLAGS.ARIAN_BREASTS] == 0) {
		outputText("\n\nAfter some time, Arian sighs and opens [Arian eir] robes, rubbing [Arian eir] chest.  \"<i>I don't think it worked.  At least... I don't feel any different.</i>\"");
		
		outputText("\n\nYou note that's strange, and wonder what could have stopped it working.  You shrug and suggest maybe it was Arian's lack of existing breasts?  Still, no harm done; would Arian maybe like to do something else instead?");
		
		outputText("\n\nHe shrugs and closes [Arian eir] robes.  \"<i>I'm sorry it didn't work, [name].  If you want to do something else, just say so.</i>\"  Arian smiles at you.");
		menu();
		addButton(0,"Next",giveArianAnItem);
	}
	else { //Lizard milk! Recover some HP and fatigue.
		player.changeFatigue(-15);
		HPChange(player.maxHP() * .2, false);
		outputText("\n\nAfter some time, Arian begins panting, sweating as [Arian eir] body temperature goes up.  \"<i>I feel... hot.</i>\"  In an attempt to lower [Arian eir] body temperature, Arian discards [Arian eir] robes and lays down on [Arian eir] bed, fanning herself with [Arian eir] clawed hands.");
		
		outputText("\n\nYou approach [Arian em] cautiously, asking if [Arian ey]'s okay.");
		
		outputText("\n\n\"<i>My breasts feel ticklish.</i>\"  Suddenly, Arian gasps in pleasure");
		if (flags[kFLAGS.ARIAN_COCK_SIZE] == 3) outputText(", [Arian eir] exposed cock growing hard as [Arian ey] flushes with arousal");
		outputText(".  [Arian Eir] hands grip the sheets and you watch [Arian eir] ");
		if (flags[kFLAGS.ARIAN_BREASTS] == 1) outputText("perky");
		else if (flags[kFLAGS.ARIAN_BREASTS] == 2) outputText("luscious");
		else outputText("pillowy");
		outputText(" breasts grow before your eyes.  \"<i>My breasts... d-do something, [name]!</i>\" Arian pleads.  Unsure of what you should be doing, you grab [Arian eir] breasts and begin kneading them as they grow in your hands; [Arian eir] erect nipples poking your palms.  \"<i>Ah... that feels good!  Don't stop!</i>\"");
		
		outputText("\n\nYou can't resist a wry comment asking if this was maybe a ploy by Arian to get you to massage [Arian eir] breasts?  Because [Arian ey] seriously didn't need to play games if that's what [Arian ey] wanted.  [Arian Eir] only reply is a moan of pleasure.  You chuckle and shake your head, continuing the massage, and that's when you notice dampness growing across your palms; lifting your hand up, you visually confirm and report to Arian that it worked; [Arian ey]'s making milk.  That must be why [Arian eir] breasts grew; to make room for the milk.");
		
		outputText("\n\n\"<i>G-great.  So, I guess it worked.  What do we do now?</i>\" Arian asks, still panting.");
		
		outputText("\n\nDoes [Arian ey] really have to ask?  You tease.  Giving [Arian eir] newly bountiful breasts a squeeze, you bend down and kiss [Arian eir] right nipple, softly sucking it between your lips.  The first few drops are not what you might have expected; it's surprisingly warm, with a taste reminiscent of sweet milk and herbal tea that you find tasty and relaxing all at once.  You need no further incentive to start suckling in earnest, rolling your reptilian lover's nipple around with your tongue to coax forth more yummy lizan milk.");
		
		outputText("\n\nArian moans and begins caressing the back of your head.  \"<i>Hmm, this is so weird, but not bad weird.  I never dreamed I would ever have breasts, much less nurse someone... with my own milk that is.  How does it taste?  Is it good?</i>\"  Arian asks, softly stroking your [hair].");
		
		outputText("\n\nRather than answer verbally, you take a particularly deep suckle and release [Arian eir] nipple, holding the milk in your mouth as you pull the surprised lizan into a kiss, letting [Arian em] literally taste [Arian eir] own medicine as you pass the milk from your mouth to " + arianMF("his", "hers") + ".  Arian is too stunned to do anything but gulp down the offered milk.  [Arian Ey] drops [Arian eir] hands and focuses only on sucking down the offered milk.  Once you've run out of milk, you break the kiss, playfully lick a stray droplet from the corner of [Arian eir] mouth, then return your attention to [Arian eir] breast.  The lizan mage hugs your head to [Arian eir] breast, still stunned.  \"<i>D-drink all you want,</i>\" [Arian ey] says in a daze.");
		
		outputText("\n\nYou need no further encouragement and start thirstily draining Arian of all the milk [Arian ey] has to offer, the lizan moaning and sighing as [Arian ey] writhes gently underneath you.  Finally, any questions about whether or not the effects of this Lactaid are permanent are answered; you've drunk [Arian em] dry, and with a quiet burp you get off of [Arian em], somewhat gingerly touching your strained belly.");
		player.refillHunger(10 + (10 * flags[kFLAGS.ARIAN_BREASTS]));		
		outputText("\n\nArian sighs in relief.  \"<i>That felt nice.  Maybe we can do it again sometime?</i>\"");

		outputText("\n\nIf [Arian ey]'s willing, then certainly, you tell [Arian em], but you'll need to track down another vial first.  You think Arian should have a rest before then.  [Arian Ey] nods and kneads [Arian eir] now emptied breasts.");
		
		//(if ArianBreasts < 3)
		if (flags[kFLAGS.ARIAN_BREASTS] < 3) {
			flags[kFLAGS.ARIAN_BREASTS]++;
			outputText("\n\n\"<i>Is it me or... are they bigger?</i>\" Arian asks curiously, looking at you and holding [Arian eir] scaly orbs.");
			outputText("\n\nYou look at them curiously, and then decide (and tell [Arian em]) that, yes, they have gotten bigger.  Probably a side effect of expanding to contain and produce the milk [Arian ey] just fed you.");
		}
		outputText("\n\nArian smiles tiredly.  \"<i>I think I'll rest for a little bit now... maybe you should too?</i>\"  [Arian Ey] suggests, pointing at your bloated belly.");
		
		outputText("\n\nYou agree, and ask if [Arian ey]'ll be okay if you show yourself out.  Arian nods and yawns.  \"<i>I'll see you later then, [name].</i>\"");
		
		outputText("\n\nYou leave [Arian em] to get some sleep and quietly show yourself out, planning to work off your meal elsewhere.");
		doNext(camp.returnToCampUseOneHour);
	}
}

//Reducto:
//Reduces the size of a part
//Has a Back option, it displays no text, just cancels the interaction and goes back to previous menu.
private function giveArianReducto():void {
	clearOutput();
	outputText("Eyeing Arian up and down, you fish your pouches for a tube of Reducto.  Once you've found it, you hand it over to Arian and tell [Arian em] you'd like [Arian em] to reduce something for you.");
	outputText("\n\n\"<i>Umm... sure, which part?</i>\"");
	//(Display Options)
	menu();
	if (flags[kFLAGS.ARIAN_BREASTS] > 0) addButton(0,"Breasts",useReductoOnAriansBreasts);
	if (flags[kFLAGS.ARIAN_COCK_SIZE] > 0) addButton(1,"Cock",useReductoOnArianCocks);
	addButton(2,"Asshole",useReductoOnAriansAsshole);
	
}

//Breasts:
//Cannot go flat (NOT ANYMORE! Maleherms FTW!)
private function useReductoOnAriansBreasts():void {
	clearOutput();
	player.consumeItem(consumables.REDUCTO);
	outputText("You point at Arian's ");
	if (flags[kFLAGS.ARIAN_BREASTS] == 1) outputText("small");
	else if (flags[kFLAGS.ARIAN_BREASTS] == 2) outputText("generous");
	else outputText("pillowy");
	outputText(" breasts.  \"<i>Okay... I suppose it would be good to lose a bit of weight up here and spare my back.</i>\"  Arian smiles, opening the tube of Reducto and [Arian eir] robes; then squeezing the contents of the paste [Arian eir] hands.");
	
	outputText("\n\nArian kneads [Arian eir] breasts, lathering the paste all over [Arian eir] breasts.  You can't help but note that this is kinda sexy.  Arian's breasts glisten in the light of the room.  Once [Arian ey] is done, [Arian ey] cleans [Arian eir] hands with a piece of cloth that was laying nearby and waits for the Reducto's effect.");
	
	//(if ArianBreasts > 1)
	if (flags[kFLAGS.ARIAN_BREASTS] > 1 || (flags[kFLAGS.ARIAN_BREASTS] == 1 && rand(6) == 0)) {
		outputText("\n\nArian gasps and the two of you watch as [Arian eir] breasts slowly shrink, setting into a smaller size.  You reach forward and feel [Arian eir] breasts; it's a much better fit for your hands now.");
		outputText("\n\nArian sighs.  \"<i>So... better now?</i>\"  You nod in response.  \"<i>Great!  Is there something else you'd like to do?</i>\"");
		flags[kFLAGS.ARIAN_BREASTS]--;
	}
	else {
		outputText("The two of you watch Arian's breasts, but nothing seems to be changing.  You reach forward to feel them, and indeed they haven't shrunk down at all.");
		outputText("\n\n\"<i>Umm... I...</i>\"  Before Arian can continue, you tell [Arian em] that it's fine, you'll just have to find another way to get rid of [Arian eir] breasts.  \"<i>Okay.  So, is there anything else you'd like to do?</i>\"");
	}
	//(Back to Options menus)
	menu();
	addButton(0,"Next",giveArianAnItem);
}
//Cock(s):
//Removes 2nd cock if at minimum size.
//Cannot remove cocks.
private function useReductoOnArianCocks():void {
	clearOutput();
	player.consumeItem(consumables.REDUCTO);
	outputText("You point at [Arian eir] crotch, mentioning that you'd like [Arian em] to be smaller.");
	outputText("\n\n\"<i>Oh, ok then.</i>\"  Arian opens [Arian eir] robes and squeezes the tube of Reducto on an open palm.");
	
	if (flags[kFLAGS.ARIAN_COCK_SIZE] == 3) {
		flags[kFLAGS.ARIAN_COCK_SIZE]--;
		outputText("\n\nThen, [Arian ey] slowly teases [Arian eir] ");
		if (flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText("pair of exposed lizard cocks");
		else outputText("exposed lizard cock");
		outputText(" into full erection.  Finally [Arian ey] begins applying the paste.");
		
		outputText("\n\nThe changes are almost immediate; Arian groans and watches as [Arian eir] oversized dick");
		if (flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText("s");
		outputText(" slowly shrink");
		if (flags[kFLAGS.ARIAN_DOUBLE_COCK] == 0) outputText("s");
		outputText(" to a more manageable size.  Once the transformation is complete Arian tries to fully retract [Arian eir] cock");
		if (flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText("s back into their");
		else outputText(" back into its");
		outputText(" hiding place; it's a tight fit, but it fits.");
		
		outputText("\n\n\"<i>Phew.  I won't say I didn't enjoy being that size, but it feels a lot more natural and comfortable now that I don't have to walk about exposed.</i>\"  You nod in agreement.  \"<i>So, is there anything else you'd like to do?</i>\"");
		//(Back to Options menus)
	}
	else if (flags[kFLAGS.ARIAN_COCK_SIZE] == 2) {
		flags[kFLAGS.ARIAN_COCK_SIZE]--;
		outputText("\n\nThen, [Arian ey]slowly teases [Arian eir] slit, coaxing [Arian eir] serpentine shaft");
		if (flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText("s from their tight hiding place");
		else outputText(" from its tight hiding place");
		outputText(", and into full erection.  Finally [Arian ey] begins applying the Reducto.");
		
		outputText("\n\nIt takes mere moments for the changes to occur; Arian groans in slight discomfort as [Arian eir] cock");
		if (flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText("s return to their");
		else outputText(" returns to its");
		outputText(" original size.  Once the transformation is complete, [Arian ey] retracts ");
		if (flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText("them");
		else outputText("it");
		outputText(" back into [Arian eir] genital slit.");
		
		outputText("\n\n\"<i>Well, it seems I'm back to being average sized,</i>\" Arian says with a tinge of disappointment.   You tell [Arian em] that average can be good too, in fact you happen to like average.  The lizan instantly cheers up and smiles at you.  \"<i>Thanks, [name].  Is there anything else you'd like to do, now?</i>\"");
	}
	else if (flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) {
		outputText("Then, [Arian ey] coaxes [Arian eir] twin reptilian-peckers out of their hiding place.  Finally [Arian ey] applies the paste to both shafts in turn.");
		
		outputText("\n\nIt takes a short while for anything to happen, but when it does Arian groans.  \"<i>S-something feels different.  Ugh, this feels weird.</i>\"  You two watch as [Arian eir] shafts slowly reduce in size, then to your surprise merge together forming one average-sized cock, much like the one Arian sported before.");
		
		outputText("\n\n\"<i>I guess I'm back to begin a lizan with a single cock,</i>\" Arian says with a slight tinge of regret.  You cheer [Arian em] up by saying that's the way you prefer it, besides is it really that bad, having only one cock?  Arian smiles at you.  \"<i>I guess it isn't too bad, just unusual for my species, but if you like me like this, then I'm okay with it.</i>\"  You nod and pat [Arian em] gently on the head.  \"<i>So... is there anything else you'd like to do?</i>\"");
		//(Back to Options menus)
	}
	else
	{ //Nothing happens
		outputText("\n\nThen coaxes [Arian eir] snake-dick out of its hiding place.  Finally [Arian ey] applies the paste on [Arian eir] dick and wait patiently for the changes to begin.");
		
		outputText("\n\nThe two of you wait for a while, but when no change happens Arian speaks up, \"<i>I guess... nothing changed?</i>\"  You're inclined to agree, something should've happened already.  Well that doesn't matter, you'll just have to try something else.  \"<i>Okay... so, anything else you'd like to do?</i>\"");
	}
	//(Back to Options menus)
	menu();
	addButton(0,"Next",giveArianAnItem);
}

//Sphincter:
//Lose AnalXP, can't reduce it past 1.
//How much AnalXP should be lost per use is up to Fen.
private function useReductoOnAriansAsshole():void {
	clearOutput();
	player.consumeItem(consumables.REDUCTO);
	outputText("You ask Arian to hand the tube of reducto back over to you, telling [Arian em] that you want to make [Arian em] a little tighter when you do [Arian em] from behind.  The lizard-");
	if (flags[kFLAGS.ARIAN_COCK_SIZE] > 0) {
		if (flags[kFLAGS.ARIAN_VAGINA] == 0) outputText("man");
		else outputText("herm");
	}
	else outputText("woman");
	outputText(" does as you ask, allowing you to smear your fingers generously with the shrinking cream, even as [Arian ey] anticipates your next request and removes [Arian eir] clothes before lying down, bum up in the air and tail slowly swishing to and fro, [Arian eir] anus exposed and waiting for your ministrations.");
	//(if AnalXP == 1)
	if (flags[kFLAGS.ARIAN_ANAL_XP] <= 1) {
		outputText("\n\n\"<i>I don't know if I can get any tighter than this, but... go ahead,</i>\" Arian says, smiling nervously at you.");
		outputText("\n\nYou poke and prod gently but insistently at Arian's ass, but are forced to concede the truth; you can barely get one of your fingers inside [Arian eir] tight anus, and you have little reason to suspect that it would do much good even if you could get it inside.");
		
		outputText("\n\n\"<i>I guess it's no use after all,</i>\" Arian chuckles.  \"<i>I imagine if you did manage to apply it you'd make my ass disappear.  Now that would be weird.</i>\"");
		
		outputText("\n\n[Arian Ey]'s not wrong there, you agree.  Still, would [Arian ey] maybe like to do something else, seeing as how that was a bust?  Arian nods.  \"<i>Of course.  What would you like to do?</i>\"");
	}
	//(else if AnalXP < 33)
	else if (flags[kFLAGS.ARIAN_ANAL_XP] < 33) {
		outputText("\n\n\"<i>I think I'm still pretty tight back there, but if you want me to be tighter, go ahead,</i>\" Arian says, smiling nervously at you.");
		
		outputText("\n\nYou gently press your fingers against the hole in question; like Arian noted, it's tight and resists your effort, but you manage, with some difficulty, to slide first one finger and then the other inside, allowing you to start coating the inner walls with Reducto cream.  You can feel the walls growing taut as you work - indeed, it promptly shrinks down almost painfully around your fingers, and you have to struggle as hard to pull them out as you had to push them in to begin with.");
		
		outputText("\n\nArian groans as you finally manage to pull your fingers out.  \"<i>I don't think it'll feel that much different when you decide to put it back there again, but I hope it'll feel good for you anyway.  Just promise you'll be gentle, ok?</i>\"");
		
		outputText("\n\nYou promise [Arian em] that you'll take care of [Arian em].  \"<i>So, anything else you'd like to do?</i>\"");
		flags[kFLAGS.ARIAN_ANAL_XP] = 1;
	}
	else if (flags[kFLAGS.ARIAN_ANAL_XP] < 66) {
		flags[kFLAGS.ARIAN_ANAL_XP] -= 33;
		outputText("\n\n\"<i>To be honest, I had kind of gotten used to the feeling... sorta.  It will be a bit painful to go back to being that tight back there, but if that's what you'd like, go ahead,</i>\" Arian says, smiling at you.");
		
		outputText("\n\nYou slide two fingers easily inside [Arian eir] stretched out back passage, rubbing the interior of [Arian eir] anus with the magical shrinking cream.  You end up applying a third finger for ease of application; [Arian ey]'s certainly loose enough to take it.  You can feel it shrinking around you as you work, but you still have little difficulty sliding your fingers back out.");
		
		outputText("\n\nArian moans as you pull out your fingers.  \"<i>And I was just getting used to being taken from behind.  Somehow I get the feeling it won't feel just as good, but I'm glad to make a little sacrifice for you.</i>\"  [Arian Ey] smiles at you.");
		
		outputText("\n\nYou smile back, thanking [Arian em] for catering to your wishes, even though [Arian ey] doesn't have to.  Arian grins at you.  \"<i>Don't worry about that.  I want to make you feel good...</i>\"  Stroking [Arian eir] exposed ass, you tell [Arian em] that [Arian eir] efforts are appreciated and promise to make [Arian em] feel just as good in return.  Arian smiles.  \"<i>Okay, it's a deal.  So, anything else you'd like to do?</i>\"");
	}
	else if (flags[kFLAGS.ARIAN_ANAL_XP] <= 100) {
		flags[kFLAGS.ARIAN_ANAL_XP] -= 33;
		outputText("\n\n\"<i>I just know it won't feel quite as good back there if you shrink my ass, but maybe this is for the best?  Perhaps I might have let the feeling get to me.  Maybe I did become too much of a buttslut...</i>\"  Arian lowers [Arian eir] head.");
		
		outputText("\n\nYou can't resist patting the lizan's head and assuring [Arian em] that, yeah, [Arian ey] is a slut when it comes to [Arian eir] ass, but the way [Arian ey] goes about being a slut is honestly kind of cute.  You just want to see if tightening [Arian em] back up will make things even better, now [Arian ey]'s got the experience of loving a great assfuck.");
		
		outputText("\n\nYou push your way into Arian's butt and almost find your whole hand sliding down [Arian eir] well-trained 'boyslut pussy', which prompts a lewd moan from the anal-loving lizan");
		if (flags[kFLAGS.ARIAN_COCK_SIZE] > 0) {
			outputText(", [Arian eir] cock");
			if (flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText("s suddenly jolting from their sheathe");
			else outputText(" suddenly jolting from its sheathe");
			if (flags[kFLAGS.ARIAN_VAGINA] > 0) outputText(" and ");
		}
		if (flags[kFLAGS.ARIAN_VAGINA] > 0) {
			if (flags[kFLAGS.ARIAN_COCK_SIZE] == 0) outputText(", ");
			outputText("[Arian eir] pussy growing wet from the stimulation");
		}
		outputText(".  You playfully shake your head and slap [Arian em] on the butt, then use it for balance as you start to pump the blade of your fist inside and out, smearing the cream copiously around to restore some of [Arian eir] once-virginal anal tightness to him.  Eventually, you've used up all the cream and [Arian eir] ass definitely feels tighter, so you decide to pull out.");
		
		outputText("\n\nArian whimpers.  \"<i>It feels a bit less sensitive now, but I'm sure it'll still feel pretty good when you do me from behind.</i>\"  Arian smiles.  \"<i>Anything else you'd like to do?</i>\"");
	}
	//Back
	menu();
	addButton(0,"Next",giveArianAnItem);
}

//Reptilum:
//Makes Arian horny and high, like giving catnip to a cat in some ways. 
//Chance to make Arian grow a second dick, if [Arian ey] has only one. (high chance: 50%)
private function giveArianReptilum():void {
	clearOutput();
	player.consumeItem(consumables.REPTLUM);
	outputText("Fingering the vial of reptilium, you smirk to yourself.  Quickly wiping it off your face, you instruct Arian to close [Arian eir] eyes and open [Arian eir] mouth, as you have a special surprise for [Arian em].");
	
	outputText("\n\nArian, quickly complies.  \"<i>Okay, but can you at least tell me what is this about?</i>\"  [Arian ey] asks in curiosity.");
	
	outputText("\n\nYou cluck your tongue in a disappointed tone and point out that a surprise isn't a surprise if you tell [Arian em] what it is.");
	
	outputText("\n\n\"<i>Aww, fine then, but I hope this isn't a practical joke... not that I don't trust you, [name].</i>\"  [Arian Ey] smiles nervously.");
	
	outputText("\n\nYou assure [Arian em] that [Arian ey]'ll enjoy this, but first, to make sure [Arian ey] doesn't go peeking... you grab a handy strip of cloth and wind it about [Arian eir] face, covering [Arian eirs] eyes in a makeshift blindfold.");
	
	outputText("\n\n\"<i>Aww, come on, you can trust me.  I promise not to peek!</i>\"");

	outputText("\n\nYou tell [Arian em] it's more fun this way, popping the bottle of Reptilium open as you do so and following your words up by tipping it into the lizan's carelessly open mouth.");
	
	outputText("\n\n\"<i>I sweagrlpff-</i>\" the lizan's protests are cut short by the stream of cool reptilum being poured down [Arian eir] throat.  [Arian Ey] chokes a bit, but quickly adapts, drinking eagerly.  When you finish tipping the bottle and remove it from [Arian eir] lips, Arian coughs a bit and licks [Arian eir] lips.  \"<i>Hmm... that tasted good, what was it?</i>\"");
	
	outputText("\n\nYou tell [Arian em] [Arian ey]'ll just have to wait to find out, taking off [Arian eir] blindfold and smiling wryly at [Arian em].  \"<i>Umm... ok...</i>\"");
	//(if ArianFirstRept == 1)
	if (flags[kFLAGS.ARIAN_FIRST_REPTILUM] == 0) {
		outputText("\n\nThe two of you sit there in wait... but oddly nothing happens.  You ask Arian if [Arian ey]'s feeling any different.");
		outputText("\n\n\"<i>No. I feel fine.</i>\"");
		outputText("\n\nThat's weird... was it a bust then?");
	}
	else {
		outputText("\n\nYou chuckle inwardly, any time now...");
	}
	outputText("\n\nArian suddenly shakes [Arian eir] head, blinking as if trying to focus; then [Arian ey] turns to look at you, and gives you a silly smile.  \"<i>Hey, [name].  Did you know you have a very beautiful aura?  All the colors.  I wonder what it tastes like.</i>\"");
	flags[kFLAGS.ARIAN_FIRST_REPTILUM]++;
	//(if ArianFirstRept == 1)
	if (flags[kFLAGS.ARIAN_FIRST_REPTILUM] == 1) outputText("\n\nYou blink; aura?  What is the lizan talking about?  And what would make [Arian em] think colors are tasty - or even edible?");
	else outputText("\n\nChuckling, you tell [Arian em] that if [Arian ey]'s so curious, [Arian ey] should try it.");
	
	outputText("\n\nArian suddenly gets up and takes a lick off your cheek.  \"<i>Yum... didn't know rainbows tasted like cloud ice-cream.</i>\"  [Arian Ey] begins laughing uncontrollably.  You wipe [Arian eir] saliva off your cheek and look in amazement as [Arian ey] continues to laugh for no apparent reason.");
	
	outputText("\n\n\"<i>Hey [name], cats are flexible right?  Think I would turn into one if I could lick my butt?  I'd be a sexy kitten!</i>\"  Arian does away with [Arian eir] robes, tossing them around and bending over as far as [Arian ey] can in an attempt to lick at [Arian eir] butt.  \"<i>J-just a bit more....  Help me here, [name]!  I want to turn into a cat so we can roleplay!  I'll be Mittens and you can be Fishbreath!</i>\"");
	
	//(if ArianFirstRept == 1)
	if (flags[kFLAGS.ARIAN_FIRST_REPTILUM] == 1) {
		outputText("\n\nFeeling a touch nervous, you ask if [Arian ey]'s feeling all right.  \"<i>All right?  I'm super!</i>\" [Arian ey] replies, gigling madly.");
	}
	else outputText("\n\nYou were kinda waiting for this part.  [Arian Ey] might not know it, but Arian's flexibility is truly impressive for a non-feline.  Just a few extra inches of tongue and [Arian ey] actually manages to lick [Arian eir] belly!");
	
	outputText("\n\nAt one point the bending lizan gives up and falls flat on [Arian eir] back then gets right up eyeing you with a glow in [Arian eir] eyes.  \"<i>That was a stupid idea!  I know just how to make it!  I can lick your butt instead!  Do you think it tastes like cloud ice-cream like your rainbow aura?</i>\"");
	
	outputText("\n\nYou shake your head and tell [Arian em] you'd rather [Arian ey] didn't lick your butt.  Why don't you go and get [Arian em] some candy instead?  \"<i>Candy!?  I love candy!  You can smear chocolate on yourself and I could lick it clean! Then we'd get chocolate flavored cloud ice-cream with " + player.race() + " musk!  What a great idea!  Get your undies off so I can get started!</i>\"  [Arian Ey] pounces on you, effectively removing your underpants and exposing your ");
	if (player.hasCock()) {
		outputText(player.multiCockDescriptLight());
		if (player.hasVagina()) outputText(" and ");
	}
	if (player.hasVagina()) outputText("[vagina]");
	if (!player.hasVagina() && !player.hasCock()) outputText("genderless crotch");
	outputText(".  \"<i>Hmm, that looks much tastier than candy actually.</i>\"  [Arian Ey] licks your ");
	if (player.hasCock()) outputText("cock from base to tip");
	else if (player.hasVagina()) outputText("pussy all the way from the back to the tip of your [clit]");
	else outputText("your sweaty crotch");
	outputText(".  \"<i>Yummy!  I could use seconds, but roleplay time is over; let's... masturbate each other!</i>\"  [Arian Ey] begins stroking [Arian eir] ");
	
	if (flags[kFLAGS.ARIAN_VAGINA] > 0)	
		outputText(images.showImage("arianfemale-home-mutualmasturbation"));	
	else	
		outputText(images.showImage("arianmale-home-mutualmasturbation"));
	
		if (flags[kFLAGS.ARIAN_COCK_SIZE] == 1) {
		outputText("quickly erecting lizan cock");
		if (flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText("s");
		if (flags[kFLAGS.ARIAN_VAGINA] > 0) outputText(" and [Arian eir] ");
	}
	if (flags[kFLAGS.ARIAN_VAGINA] > 0) outputText("slavering vagina");
	outputText(".");
	
	outputText("\n\nArian must be high; normally [Arian ey] needs a little encouragement to put on a show like this.  Still, who are you to pass up on a free show from your lizan lover?");
	
	outputText("\n\nLaughing and moaning uncontrollably Arian says, \"<i>Wow, [name].  Your hands feel really good!  Kind of familiar too!</i>\"");
	
	outputText("\n\n[Arian Ey]'s clearly so daffy that [Arian ey] doesn't realize [Arian ey]'s the one touching [Arian em]self.  Still, this is amusing, rather than scary, so you're content to watch and let the show play out.  It's kind of a turn on...");
	dynStats("lus", (5+player.lib/10));
	
	var tfed:Boolean = false;
	outputText("\n\nArian's giggling suddenly stops as [Arian ey] finally orgasms, ");
	if (flags[kFLAGS.ARIAN_COCK_SIZE] > 0) {
		outputText("shooting thick ropes of cum up into the air to land on [Arian eir] ");
		if (flags[kFLAGS.ARIAN_BREASTS] == 0) outputText("chest");
		else if (flags[kFLAGS.ARIAN_BREASTS] == 1) outputText("perky little breasts");
		else if (flags[kFLAGS.ARIAN_BREASTS] == 2) outputText("soft breasts");
		else outputText("pillowy breasts");
		if (flags[kFLAGS.ARIAN_VAGINA] > 0) outputText(" while ");
	}
	if (flags[kFLAGS.ARIAN_VAGINA] > 0) outputText("[Arian eir] vagina doing its best to soak [Arian eir] bed with lizan femcum");
	outputText(".");
	
	outputText("\n\nLooking at you dizzily, Arian smiles and says, \"<i>That was fun, [name].  You have truly gifted hands!</i>\"  You repress a laugh; this was just too much fun, and tell Arian that credit is due where it's due.  You leave it to the dazed lizan to eventually decipher if you're saying you were the one with the gifted hands or you were encouraging [Arian em] to recognize that [Arian ey] is the one with the gifted hands.");
	
	//(if (random <= 50%) && (ArianDblCock == 0) && (ArianCockSize != 0)
	if (rand(2) == 0 && flags[kFLAGS.ARIAN_DOUBLE_COCK] == 0 && flags[kFLAGS.ARIAN_COCK_SIZE] > 0) {
		outputText("\n\n\"<i>Ugh... something feels weird...</i>\"  Arian looks down at [Arian eir] crotch.  You follow [Arian eir] eyes and see a second cock growing.  It grows until it's the same size as Arian's original cock, and once the transformation is over, Arian bursts out in uncontrollable laughter.");
		
		outputText("\n\n\"<i>Look, [name]!  You did me so hard I'm seeing double!</i>\"  [Arian Ey] moves [Arian eir] hands to touch [Arian eir] sensitive twin members.  \"<i>Whoa! I'm feeling double too!</i>\"  Eventually the laughter dies down and the lizan collapses on [Arian eir] back, snoring in a quick nap.");
		tfed = true;
	}
	else {
		outputText("\n\nArian's mouth opens into a wide yawn.  \"<i>Hmm... nappy time...</i>\"  [Arian Ey] flops on [Arian eir] back and begins snoring in a quick nap.");
	}
	
	outputText("\n\nYou chortle quietly to yourself.  Talk about your anticlimactic finishers.   Still, you can't resist stroking Arian gently on the head; looks like [Arian ey] quite enjoyed [Arian emself] with that.  You remove your hand in surprise when Arian suddenly gets up, rubbing at [Arian eir] eyes.  \"<i>Wha... hey [name].  Sorry, I guess I fell asleep.</i>\"  Looking down at [Arian emself], [Arian ey] realizes the state [Arian ey]'s in.  For a moment [Arian ey] looks confused... but then smiles.  \"<i>I guess we wound up having sex, right?  Was it good?  Sorry, but I'm a bit dizzy and can't recall exactly what happened.</i>\"");
	outputText("\n\nYou tell [Arian em] it was definitely interesting.  [Arian Ey] really seemed to get wired up off of your little surprise.");
	
	if (tfed) {
		outputText("\n\n\"<i>Hmm... I still feel sensitive all over...</i>\"  [Arian Eir] hand absently touches [Arian eir] still half-erect twin dicks.  \"<i>Wha?</i>\"  Looking down at [Arian eir] crotch, Arian finally realizes [Arian ey] has two dicks.");
		
		outputText("\n\n\"<i>Two... but, I was....  Was that you, [name]?</i>\"");
		
		outputText("\n\nYou smile and nod your head; does [Arian ey] like them?");
		
		outputText("\n\n\"<i>Like them?  I love them!  You have no idea how much I longed to... to... to actually have two dicks like most of my people.  Thank you so much for this wonderful suprise [name]!</i>\"  [Arian Ey] grins happily at you.");
		flags[kFLAGS.ARIAN_DOUBLE_COCK] = 1;
	}
	else {
		outputText("\n\n\"<i>I guess I did...</i>\"  [Arian Ey] smiles tiredly at you.  \"<i>Thank you for the wonderful surprise, [name].</i>\"");
	}
	outputText("\n\nYou laugh lightly and tell [Arian em] that you should be the one thanking [Arian em].");
	
	outputText("\n\nThe lizan looks at you in confusion, and is about to ask you something when a yawn interrupts [Arian eir] line of thought.  \"<i>Ok... I'm glad you liked whatever we did...  -gonna take a nap now.</i>\"");

	outputText("\n\nYou gently pull the covers up over the tired lizan, stroke [Arian eir] head fondly, and quietly excuse yourself from [Arian eir] sleeping quarters.");
	
	//Player gains Lust.
	doNext(camp.returnToCampUseOneHour);
}

//Treat Corruption
//Not with the power of friendship, but with magic!
//Balancing it is up to Fen.
//Reduce corruption, maybe libido, once per day.
private function treatCorruption():void {
	clearOutput();
	outputText("You ask Arian if [Arian ey] thinks [Arian ey] can help you reduce some of the taint that has infected your soul.");
	
	if (flags[kFLAGS.ARIAN_TREATMENT] == 1) {
		outputText("\n\nArian solemnly shakes [Arian eir] head.  \"<i>Sorry, [name].  But I have already treated you once today, and if I did it again it could be hazardous to you... sorry.</i>\"");
		
		outputText("\n\nYou apologize.  You had forgotten how much that taxes [Arian em], and you will come back for further treatments tomorrow.  However, there is something else [Arian ey] can help you with...");
		arianHomeMenu();
		//Back to previous menu.
	}
	else {
		outputText("\n\nArian nods.  \"<i>Of course!  Just hold my hands.</i>\"  [Arian Ey] extends [Arian eir] hands, waiting for you to get into position.");
		
		outputText("\n\nYou take hold of [Arian eir] smoothly-scaled hands with your own, and wait patiently for [Arian em] to begin.");
		
		outputText("\n\n\"<i>Now I need you to close your eyes, and focus on breathing... deeply and calmly.  You should feel a weird electric sensation, but try to relax.</i>\"");
		
		outputText("\n\nYou nod your head, close your eyes, and begin to slowly, rhythmically inhale and exhale, calming yourself down as instructed.");
		
		outputText("\n\nIt takes a while, but eventually you begin to feel the strange sensation Arian told you about.  It courses through your arms, and spreads throughout your body.  After a moment, you feel your body going numb with the sensation, and that's when you notice something else....  For a moment, it feels like you're being hugged tightly by a ghost.  It feels like it's there and isn't at the same time.  Invisible hands roam your body, and slowly, you feel like pieces of you are being removed.  It's not a bad sensation, and it certainly doesn't hurt, but it's... uncomfortable.");
		
		outputText("\n\n\"<i>That's enough.  You can open your eyes now,</i>\" Arian says, as all the strange sensations coursing through your body abruptly stop.  You release the lizan mage's clawed hands and realize that you're panting... as if you had exerted some sort of physical activity.");
		
		outputText("\n\nNoticing your concern Arian smiles.  \"<i>Don't worry, [name].  Just take a few moments to regain your breath and you should feel better.</i>\"");
		
		outputText("\n\nYou do as you are instructed, and note that, once you do feel better, you literally feel better; your thoughts are less clouded by corruption than they were before");
		dynStats("cor", -1);
		player.changeFatigue(20);
		if (player.cor == 0) outputText(" - in fact, you're quite sure that Arian has purified you entirely");
		outputText(".  You thank the lizan for [Arian eir] magical treatment.");
		
		outputText("\n\n\"<i>You're welcome,</i>\" [Arian ey] replies with a smile.  \"<i>Just remember that we can only do this once per day.  Any more and it would be hazardous, for both of us.</i>\"");
		
		outputText("\n\nYou acknowledge what [Arian ey] is saying, promise you'll try and be more careful in the future, thank [Arian em] once more, and then excuse yourself.");
		flags[kFLAGS.ARIAN_TREATMENT]++;
		doNext(camp.returnToCampUseOneHour);
	}
}


//Imbue Talisman
//Make it as generic as possible, so more stuff can be added or removed without compromising too much time.
//if PC doesn't have the sufficient materials, option doesn't show up.
//Perhaps introduce a cooldown to the talisman?
//Ultimately, balance is in Fen's hands.
private function imbueTalisman():void {
	clearOutput();
	outputText("You tell Arian that, if it's not too much trouble, you'd like [Arian em] to ");
	if (player.hasKeyItem("Arian's Talisman") >= 0) outputText("place a spell in the enchanted talisman [Arian ey] created for you");
	else outputText("change the spell in the talisman [Arian ey] created for you");
	
	outputText(".\n\n\"<i>Of course.</i>\"  Arian goes to [Arian eir] work desk to fetch a small parchment and present it to you.  \"<i>Here's all the spells I can Imbue your talisman with and the materials needed.</i>\"");
	
	outputText("\n\nYou start observing the parchment, contemplating your choices.  So, what spell will you have [Arian em] place in the talisman?");
	
	/*The list:
	//Back is also present as an option, and returns PC to previous menu.
	*/
	outputText("\n\n<b>Dispelling Spell:</b> 1x White Book and 1x Black Book - Cancels all magical and alchemical effects currently affecting the PC, beneficial or not. (Does not cancel the effects of demon's lust aura.)");
	outputText("\n<b>Healing Spell:</b> 2x Wet Cloth and 2x Vitality T. - Heals the user, no chance for failure. More powerful than standard healing spell.");
	outputText("\n<b>Immolation Spell:</b> 2x Goblin Ale and 1x Sweet Gossamer - Sets your opponent on fire, dealing damage over time.");
	outputText("\n<b>Lust Reduction Spell:</b> 2x Lust Draft and 1x Fuck Draft. - Reduces the PC's current lust, no chance for failure.");
	outputText("\n<b>Shielding Spell:</b> 2x Black Chitin and 1x Tough Silk - Increases defense for the duration of the battle.");
	menu();
	//Dispelling
	if (player.hasItem(consumables.W__BOOK, 1) && player.hasItem(consumables.B__BOOK, 1))
		addButton(0, "Dispelling", arianSpellPlace, "Dispelling Spell", null, null, "Cancels all magical and alchemical effects currently affecting the PC, beneficial or not. (Does not cancel the effects of demon's lust aura.)");
	else
		addButtonDisabled(0, "Dispelling", "You don't have the required ingredients.");
	//Healing
	if (player.hasItem(consumables.WETCLTH, 2) && player.hasItem(consumables.VITAL_T, 2))
		addButton(1, "Healing", arianSpellPlace, "Healing Spell", null, null, "Heals the user, no chance for failure. More powerful than standard healing spell.");
	else
		addButtonDisabled(1, "Healing", "You don't have the required ingredients.");
	//Immolation
	if (player.hasItem(consumables.GOB_ALE, 2) && player.hasItem(consumables.S_GOSSR))
		addButton(2, "Immolation", arianSpellPlace, "Immolation Spell", null, null, "Sets your opponent on fire, dealing damage over time.");
	else
		addButtonDisabled(2, "Immolation", "You don't have the required ingredients.");
	//Lust Reduction
	if (player.hasItem(consumables.L_DRAFT, 2) && player.hasItem(consumables.F_DRAFT, 1))
		addButton(3, "Lust Reduc", arianSpellPlace, "Lust Reduction Spell", null, null, "Reduces the user's current lust, no chance for failure.", "Lust Reduction");
	else
		addButtonDisabled(3, "Lust Reduc", "You don't have the required ingredients.", "Lust Reduction");
	//Shielding
	if (player.hasItem(useables.B_CHITN, 2) && player.hasItem(useables.T_SSILK))
		addButton(4, "Shielding", arianSpellPlace, "Shielding Spell", null, null, "Increases defense for the duration of the battle.");
	else
		addButtonDisabled(4, "Shielding", "You don't have the required ingredients.");
	//CANCEL!
	addButton(14,"Back",arianHomeMenu);
}

private function arianSpellPlace(spell:*):void {
	clearOutput();
	outputText("You tell Arian that you want [Arian em] to place the " + spell + " spell in your talisman for you.");
	
	outputText("\n\n\"<i>Okay. Please, hand me the ingredients and I'll have it imbued in a moment.</i>\"  [Arian Ey] smiles at you.  Fishing around amongst your belongings, you gather the necessary items and hold them out to the lizan.");
	
	outputText("\n\nArian eagerly nabs the offered ingredients and moves to [Arian eir] work desk.  [Arian Ey] takes a nearby bowl and fills it with water, then looks around.  \"<i>Hmm... I'm forgetting something... oh, right!  I'm going to have to ask you for your talisman, too, [name].</i>\"  [Arian Ey] extends a hand to you.");
	
	outputText("\n\nYou can't resist noting you were expecting [Arian em] to say that, plucking it from your neck and passing it to the reptilian wizard.");
	
	outputText("\n\n\"<i>Erm... right.  Now I need to focus.</i>\"  [Arian Ey] places your talisman in the bowl, submerging it in water, then closes [Arian eir] eyes and begins focusing [Arian eir] magic.  Shortly after, the ingredients you offered suddenly burst into flames, burning until only their ashes are left; the ashes float into the bowl and mix with the water inside.");
	
	outputText("\n\nA soft hum emanates from within the bowl and the water begins glowing.  It doesn't take long for the humming to fade; Arian reaches inside the bowl and lifts your talisman for you to see.  \"<i>Here you go, [name].</i>\"");
	
	outputText("\n\nYou thank [Arian em] and accept the talisman, feeling the pulsating energies within for a few moments before placing it back around your neck.  You thank Arian for [Arian eir] help, assuring [Arian em] that this will surely help you in your travels through these lands.");
	
	outputText("\n\n(<b>Your talisman has been imbued with the " + spell + ". You can use it from the M. Specials menu in combat.</b>)\n\n");
	clearCharges();
	if (spell == "Dispelling Spell") {
		spell = 1;
		player.consumeItem(consumables.W__BOOK, 2);
		player.consumeItem(consumables.B__BOOK, 2);
	}
	if (spell == "Healing Spell") {
		spell = 2;
		player.consumeItem(consumables.WETCLTH, 2);
		player.consumeItem(consumables.VITAL_T, 2);
	}
	if (spell == "Immolation Spell") {
		spell = 3;
		player.consumeItem(consumables.GOB_ALE, 2);
		player.consumeItem(consumables.S_GOSSR);
	}
	if (spell == "Lust Reduction Spell") {
		spell = 4;
		player.consumeItem(consumables.L_DRAFT, 2);
		player.consumeItem(consumables.F_DRAFT);
	}
	if (spell == "Shielding Spell") {
		spell = 5;
		player.consumeItem(useables.B_CHITN, 2);
		player.consumeItem(useables.T_SSILK);
	}
	//If charged, stay chargggggeeed
	if (player.hasKeyItem("Arian's Talisman") >= 0) {
		player.removeKeyItem("Arian's Talisman");
		player.createKeyItem("Arian's Charged Talisman", spell, 0, 0, 0);
	}
	doNext(camp.returnToCampUseOneHour);
}
private function clearCharges():void {
	if (player.findStatusEffect(StatusEffects.ShieldingSpell) >= 0) player.removeStatusEffect(StatusEffects.ShieldingSpell);
	if (player.findStatusEffect(StatusEffects.ImmolationSpell) >= 0) player.removeStatusEffect(StatusEffects.ImmolationSpell);
}
public function clearTalisman():void {
	player.removeKeyItem("Arian's Charged Talisman");
	player.createKeyItem("Arian's Talisman",0,0,0,0);
}

//Follower Stuff:
//Camp Modifier
/*9999
The small tent that Arian dwells in is in its usual place in a quiet corner of the camp. You're not sure if he's inside, taking advantage of its uncannily larger interior, or out on one of his usual strolls outside of the camp.
*/
//Approach Arian


//Sleep With Arian
public function sleepWithArian(newl:Boolean = false):void {
	if (newl) clearOutput();
	flags[kFLAGS.SLEEP_WITH] = "Arian";
	outputText("Tired after a whole day of adventuring, you decide to retire and catch some shut-eye.  While going through the day's events, you recall Arian had offered to let you stay in [Arian eir] tent and sleep with [Arian em] in [Arian eir] bed.  Your tired body could surely use a soft bed today, and maybe a certain lizan to keep you company too.  With that in mind, you head to [Arian eir] tent.");
	
	outputText("\n\nInside, you find the " + arianMF("male","girly") + " lizan standing naked before [Arian eir] bed, stretching [Arian eir] arms and tail as widely as they can and groaning with satisfaction as [Arian eir] joints pop.  Apparently not having noticed you arrive, [Arian ey] hums to [Arian emself] as [Arian ey] busies [Arian emself] with the covers of [Arian eir] bed, bending over and letting you get a good look at [Arian eir] sweet ass.  You appreciate the view for a few moments, and then gently cough to announce your presence.");
	
	outputText("\n\nStartled, Arian tries [Arian eir] best to cover [Arian eir] privates and finally notices you standing just inside.  \"<i>Oh, hello [name].  S-sorry, I'm not decent... I was just getting ready to turn in.  Can I help you with something?</i>\"");
	
	outputText("\n\nYou smile at [Arian em] and ask if that invitation to join [Arian em] in bed for the night still stands.  You just don't really feel like going to bed alone tonight, you explain.");
	
	outputText("\n\nArian nods enthusiastically.  \"<i>Of course!  Let me just put some comfortable robes on.  Usually I just sleep naked, but since you're here....</i>\"");
	
	outputText("\n\nYou quickly interject that if that's how [Arian ey] prefers to sleep, well, [Arian ey] doesn't need to change that for you.  If it'll make [Arian em] more comfortable, in fact, you'll sleep naked with [Arian em] as well.");
	
	outputText("\n\n\"<i>Really?  Umm... well, they say it's easier to share body heat with skin contact, so...</i>\"  Arian trails off twirling [Arian eir] fingers, no longer bothering to cover [Arian emself] up.");
	
	outputText("\n\nYou make no secret of your visual appreciation, telling [Arian em] that the view is definitely nice, and then you start to strip down, making a little show out of it for your lizan lover.");
	
	outputText("\n\nArian fidgets and watches enraptured as you peel off each piece of your [armor].  ");
	if (flags[kFLAGS.ARIAN_COCK_SIZE] > 0) {
		outputText("You can clearly see [Arian eir] exposed cock");
		if (flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText("s");
		outputText(" stiffening at the sight.  ");
	}
	if (flags[kFLAGS.ARIAN_VAGINA] > 0) outputText("You can tell that [Arian ey] is aroused by the little show, despite [Arian eir] body doing a good job of hiding it.  ");
	outputText("You just let [Arian em] squirm, pretending you don't see [Arian eir] reactions, and then, indicating the bed, you ask which of you should get in first.");
	
	outputText("\n\nArian steps aside and motions for you to hop in first.  \"<i>Don't worry, I've cleaned the sheets recently, so there shouldn't be a problem... in case you're worried.</i>\"");
	
	outputText("\n\nWorried?  You smirk and ask whatever you could be worried about, even as you saunter over and slide yourself onto the bed.  You smile and wiggle with appreciation, telling Arian how wonderful [Arian eir] sheets and soft mattress feel after so long sleeping in a bedroll on the hard ground.");
	
	outputText("\n\nArian smiles at you.  \"<i>I'm glad you're comfortable.  Just know that I'll always have a spot for you under my bedsheets.</i>\"  Oh?  Is that a proposal of a little... light exercise before bed, hmm?  You tease the lizan.  Averting [Arian eir] gaze and biting [Arian eir] lower lip, Arian quickly blurts out.  \"<i>No!  I mean... I wouldn't mind... but I, umm....  I'll just be getting in under the covers, if you don't mind.</i>\"  You chuckle and motion for [Arian em] to come hither.");

	outputText("\n\nArian lays down beside you, and scoots over, trying to get as close as possible to you.  You promptly wrap your arms around [Arian eir] waist, and then wrap your [legs] around [Arian em] for good measure, nuzzling yourself against [Arian eir] smooth scales.");
	
	outputText("\n\nArian sighs in happiness at your close contact.  \"<i>It feels so good to have your " + player.skinFurScales() + " against my scales.  So warm...</i>\" [Arian ey] sidles up against you, [Arian eir] tail draping over your waist as [Arian ey] sinks into your embrace.  You just squeeze [Arian em] a little tighter and hold [Arian em] close, saying nothing aside from a quiet whisper to sleep well.  \"<i>Good night, [name],</i>\" [Arian ey] whispers back, before extending a hand toward the globe illuminating the tent and snapping [Arian eir] fingers, shutting down the light.");
	awardAchievement("My Tent's (not) Better Than Yours", kACHIEVEMENTS.GENERAL_MY_TENT_NOT_BETTER, true, true);
	//(if AnalXP <33)
	if (flags[kFLAGS.ARIAN_ANAL_XP] < 33) {
		outputText("\n\nA strange sensation, combined with a soft sound, stirs you from your sleep.  You realize that Arian is stirring in [Arian eir] sleep, softly mumbling to [Arian em]self as [Arian eir] tail gently swishes to and fro under the covers, sometimes accidentally running its warm length over your " + player.skinFurScales() + ".");
		
		outputText("\n\nAt first you think the lizan might actually be awake, but under further inspection you realize that [Arian ey] is just sleep-talking.  Should you listen in or just go back to sleep?");
		menu();
		addButton(0,"Listen",listenToLowAnalXPArian);
		addButton(1,"Sleep",dontListenToLowAnalXPArian);
	}
	//(else if AnalXP <66)
	else if (flags[kFLAGS.ARIAN_ANAL_XP] < 66) {
		outputText("\n\nYou awaken blearily to the sound of soft whimpering, the feeling of hips rubbing softly and repeatedly against your groin, and the sensation of a long, smoothly-scaled tail flickering across your [chest].  Looks like Arian is dreaming something... probably something erotic, too.");
		outputText("\n\nShould you listen in, and perhaps tease [Arian em]?  Or just go back to sleep?");
		//[Listen][Sleep]
		menu();
		addButton(0,"Listen",listenToMediumAnalXPArian);
		addButton(1,"Sleep",dontListenToMediumAnalXPArian);
	}
	else { //AnalXP <= 100
		outputText("\n\nYou wake up, confused and wondering what's disturbing your sleep.  When you wake up, you almost think Arian's also awake; [Arian ey]'s insistently moaning in pleasure, grinding [Arian eir] ass feverishly against your crotch, tail thrashing around wildly.  Why, that little cheeky lizard; [Arian ey]'s having a wet dream!");
		outputText("\n\nShould you tease [Arian em] a bit?  Or try to calm [Arian em] down and go back to sleep?");
		//[Tease][Sleep]
		menu();
		addButton(0,"Tease",TeaseHighAnalXPArian);
		addButton(1,"Sleep",dontTeaseHighAnalXPArian);
	}
}

//[=Sleep=]
private function dontListenToLowAnalXPArian():void {
	clearOutput();
	outputText("You gently stroke the lizan's side and plant a soft, gentle kiss on [Arian eir] neck.  At your ministrations, Arian sighs and slowly falls still again.  You wait, but it seems that whatever dreams [Arian ey] was having have faded and [Arian ey]'s truly asleep now, allowing you to go back to sleep yourself.");
	menu();
	addButton(0,"Next",camp.sleepWrapper);
}

//[=Listen=]
private function listenToLowAnalXPArian():void {
	clearOutput();
	flags[kFLAGS.ARIAN_MORNING] = 1;
	outputText("You turn you head to try and catch what Arian might be dreaming about.");
	outputText("\n\n\"<i>In my ass?  Are you sure?</i>\"");
	outputText("\n\nWell, now; looks like Arian might be dreaming about anal sex.  You wonder what to do....  Well, since it's basically [Arian eir] fault that you are awake, you feel a little payback is in order.  You whisper in [Arian eir] ear that you are sure.");
	outputText("\n\n\"<i>But sausages belong inside breads,</i>\" Arian whimpers.  \"<i>But... if you're sure... okay....</i>\"  Under the covers you feel Arian wiggling [Arian eir] butt against you, [Arian eir] tail lifting to make room for the \"<i>sausage</i>\".");
	//(if PC has a cock)
	if (player.hasCock()) {
		outputText("\n\nYou wonder for a moment if maybe this is fair, but decide that, if [Arian ey]'s obviously dreaming about it eagerly....  Your hand slips under the covers to start stroking your [cock smallest], gently coaxing yourself to erection.  Once you've gotten yourself sufficiently stiff, you wrap your arms around the lizan's waist for balance and start pushing yourself in.");
	}
	else {
		outputText("\n\nGiven you're rather lacking in the penis department, you decide to make do with your fingers; they should be close enough for someone new to anal like [Arian em], right?  Copiously lubricating your middle finger with saliva, you wriggle it between [Arian eir] soft asscheeks and begin gently pushing it into [Arian eir] tight little pucker.");
	}
	outputText("\n\nBefore you can even drive an inch in, Arian suddenly says, \"<i>No!  Wait!  I'm not ready yet!  I need to bake for a few more minutes before you can put the sausage in... and add more milk...</i>\"");
	outputText("\n\n...Okay, this is getting weird enough.  You're not really sure you can stay in the mood to fuck [Arian eir] ass.");
	outputText("\n\n\"<i>[name]... just let me bake overnight.  I'll be ready tomorrow.  G'night...</i>\"  Having said that, Arian finally calms down.");
	outputText("\n\nYou wonder if maybe Arian always dreamed of being a baker instead of a wizard... or if [Arian ey] just had a midnight craving for pastries  With a soft sigh, you make yourself settle down and try to get back to sleep.");
	dynStats("lus", 15);
	menu();
	addButton(0,"Next",camp.sleepWrapper);
}

//[=Sleep=]
private function dontListenToMediumAnalXPArian():void {
	clearOutput();
	outputText("You gently stroke the lizan's side and plant a soft, gentle kiss on [Arian eir] neck.  At your ministrations, Arian sighs and slowly falls still again.  You wait, but it seems that whatever dreams [Arian ey] was having have faded and [Arian ey]'s truly asleep now, allowing you to go back to sleep yourself.");
	camp.sleepRecovery(false);
	menu();
	addButton(0,"Next",camp.sleepWrapper);
}
//[=Listen=]
private function listenToMediumAnalXPArian():void {
	clearOutput();
	flags[kFLAGS.ARIAN_MORNING] = 1;
	outputText("You turn you head to try and catch what Arian might be dreaming about.");
	outputText("\n\n\"<i>Hmm... no, not my muffins.</i>\"");
	outputText("\n\n...Muffins?  [Arian Ey]'s kicking and squirming like that... over a dream about muffins?  Feeling mischievous, and maybe a little insulted, you lean over [Arian eir] ear and whisper that you've got some very special muffins for him.");
	outputText("\n\n\"<i>Really?  What flavor?</i>\"");
	outputText("\n\nYou tell [Arian em] it's a surprise.");
	outputText("\n\n\"<i>Hmm, okay then.  Shove it in.</i>\"  Arian lifts [Arian eir] tail out of the way, wiggling [Arian eir] hips against you.");
	
	//(if PC has a cock)
	if (player.hasCock()) {
		outputText("\n\nWell, if this is what [Arian ey] wants, you're happy to oblige.  Your hand slips under the covers to start stroking your [cock smallest], gently coaxing yourself to erection.  Once you've gotten yourself sufficiently stiff, you wrap your arms around the lizan's waist for balance and start pushing yourself in.");
		outputText("\n\nArian moans.  \"<i>Such a familiar flavor.  Why didn't you tell me you were [name] flavored?  I love muffins.  I love [name] muffins.</i>\"");
		outputText("\n\nYou blink in surprise; is Arian really asleep, you wonder?  No, [Arian ey]'s got to be awake, otherwise how could [Arian ey] realize you're actually fucking [Arian eir] ass?  \"<i>Hmm... tasty...</i>\"  You lean over the lizan, ");
		if (player.hasCock()) outputText("cock");
		else outputText("finger");
		outputText(" still worming its way into [Arian eir] fuckable ass, but it really does look like [Arian ey]'s fast asleep.  Weird.  \"<i>So many muffins... all [name] flavored...</i>\"  [Arian ey] calms down and begins snoring lightly.");
		outputText("\n\nUnbelievable... if you didn't know better you'd think that Arian is the one doing the teasing here.  Still... [Arian ey]'s fast asleep right now, and you don't feel like fucking [Arian em] in [Arian eir] sleep");
		if (player.cor >= 66) outputText(", despite the silly lizan being deserving of it");
		outputText(".  But as payback, [Arian ey]'s going to sleep with you inside, not that it seems like it'll be much of a problem to [Arian em]... Too bad you can't hold an erection all the time while asleep, so you know eventually you'll slip out...");
	}
	else {
		outputText("\n\nGiven you're rather lacking in the penis department, you decide to make do with your fingers; it is what [Arian ey] wants, right?  Copiously lubricating your middle finger with saliva, you wriggle it between [Arian eir] soft asscheeks and begin gently pushing it into [Arian eir] tight little pucker.");
		outputText("\n\nArian moans.  \"<i>Such a familiar flavor... why didn't you tell me you were [name] flavored?  I love muffins... I love [name] muffins...</i>\"");
		outputText("\n\nYou blink in surprise; is Arian really asleep, you wonder?  No, [Arian ey]'s got to be awake, otherwise how could [Arian ey] realize you're actually fucking [Arian eir] ass?  \"<i>Hmm... tasty...</i>\"  You lean over the lizan, finger still worming its way into [Arian eir] fuckable ass, but it really does look like [Arian ey]'s fast asleep.  Weird.  \"<i>So many muffins... all [name] flavored....</i>\"  [Arian Ey] calms down and begins snoring lightly.");
		outputText("\n\nUnbelievable... if you didn't know better you'd think that Arian is the one doing the teasing here.  Still... [Arian ey]'s fast asleep right now, and you don't feel like fucking [Arian em] in [Arian eir] sleep");
		if (player.cor >= 66) outputText(", despite the silly lizan being deserving of it");
		outputText(".");
	}
	dynStats("lus", 15);
	menu();
	addButton(0,"Next",camp.sleepWrapper);
}

//[=Sleep=]
private function dontTeaseHighAnalXPArian():void {
	clearOutput();
	outputText("You gently stroke the lizan's side and plant a soft, gentle kiss on [Arian eir] neck.  At your ministrations, Arian sighs and slowly falls still again.  You wait, but it seems that whatever dreams [Arian ey] was having have faded and [Arian ey]'s truly asleep now, allowing you to go back to sleep yourself.");
	menu();
	addButton(0,"Next",camp.sleepWrapper);
}

//[=Tease=]
private function TeaseHighAnalXPArian():void {
	clearOutput();
	
	if (flags[kFLAGS.ARIAN_VAGINA] > 0)	
		outputText(images.showImage("arianfemale-camp-dreamingArian"));	
	else	
		outputText(images.showImage("arianmale-camp-dreamingArian"));
	flags[kFLAGS.ARIAN_MORNING] = 1;
	outputText("\n\nFirst, you decide to check what exactly is Arian dreaming about...");
	outputText("\n\n\"<i>...[name]... no... don't stuff that turkey... stuff me....  I wanna be tasty too.</i>\"");
	outputText("\n\nIs [Arian ey] dreaming about food, or sex?");
	//(if PC has a cock)
	if (player.hasCock()) {
		outputText("\n\nAh well, why not indulge a little?  You take one hand and begin to sensuously stroke your shaft, aiming to get yourself nice and erect, while with the fingers of the other you slide into the lizan's tailhole, seeing if your teasing will get a reaction and prove [Arian ey] wants [Arian eir] butt fucked.");
		outputText("\n\n\"<i>Hmm... hehe.  It's so little... [name]... you can do better.</i>\"");
		outputText("\n\nOkay, it seems there's no need to hesitate any more.  Your cock rock-solid with anticipation, you wriggle yourself into the proper position and thrust yourself bluntly up [Arian eir] ass.  Arian moans lewdly in [Arian eir] sleep, [Arian eir] well-trained pucker easily, nay, eagerly taking you in a single thrust, the hungry muscles sliding wetly across your length and then clamping down in an effort to suck you inside.");
		outputText("\n\n\"<i>Oooh... that's what I'm talking about... make me tasty...</i>\" Arian's hips eagerly begin thrusting against you in an attempt to force you even deeper into [Arian eir] contracting rosebud; every time you push inside, the flesh surrounding your [cock smallest] yields, allowing you easy access; and every time you pull out, Arian's sphincter grips you tightly, as if trying to prevent you from leaving its tight embrace.  It feels good, despite being a bit difficult to get into proper rhythm.");
		outputText("\n\nStill, you persevere despite the awkwardness, leaning over and whispering into Arian's ear, asking if [Arian ey] wants to be stuffed nice and full.");
		outputText("\n\n\"<i>More than full... I want to be as big as Miss Turkey...</i>\"");
		outputText("\n\nIs that so, you ask?  Does [Arian ey] really want a big squishy belly, stuffed full of hot, salty " + player.mf("man","herm") + "-goo?");
		outputText("\n\n\"<i>Hmm, yessss... put the sauce inside me,</i>\" Arian hisses in obvious pleasure.");
		outputText("\n\nAlready hot and bothered, you don't need much more encouragement.  A few final thrusts, brutal in your eagerness, and you give yourself over to climax, cumming as long and hard as you can into Arian's greedy little butt.");
		outputText("\n\nYou cum as hard as you can, but find yourself unable to cum as much you're used to, due to the fact you're still half-asleep.  \"<i>Hmm, no... more stuffing.  I need it for my muffins...</i>\"  You try your best, but just can't dredge up anything more of note, and tell Arian that [Arian ey]'ll need to get some sleep and you'll stuff [Arian em] in the morning.  Arian whimpers, but seems to calm down for the time being... now maybe you can get some proper sleep.");
		outputText("\n\nYou try to pull out of the lizan's trained ass, but find yourself unable to.  Well, this is not exactly how you saw yourself spending the night today, but you're too tired to put much of an effort extracting your [cock smallest] from the lizan's greedy butthole.  You get as comfortable as you can, given your current position, and close your eyes...");
		player.orgasm();
	}
	else {
		outputText("\n\nPity you don't have the necessary parts to play with [Arian em], though.  Still, maybe if you do something a little special for him, [Arian ey]'ll calm down and let you get some sleep...?");
		outputText("\n\nWith anyone else, you'd probably lube your fingers up first; given what a total buttslut Arian's turned [Arian emself] into, though, you doubt [Arian ey] needs it.  Gently, you begin pressing against [Arian eir] puckered tailhole with two fingers; eagerly it slips open, allowing you access with what you'd swear was a soft slurping sound. The interior is wet and slick, more like an aroused pussy than a normal anus, and you start to slowly thrust your fingers in and out of the warm, wet depths.");
		outputText("\n\nPulling your hand out becomes increasingly difficult as Arian's ass basically sucks you in like a vacuum.  \"<i>Ohh... not stuffing... but feels good too....</i>\"");
		
		outputText("\n\nYou wonder if maybe you should grow a cock... that, or try to tighten up Arian's ass so [Arian ey] stops being so obsessed with getting it stuffed full of cock.  As you ponder this deep conundrum, you continue pistoning your fingers into the buttslut lizan's ass; you wonder if you can make [Arian em] cum with just this alone...?");
		
		outputText("\n\n\"<i>Hmm, you missed a spot.</i>\"  Arian begins humping your fingers eagerly, trying to shove them as deep inside [Arian eir] greedy ass as [Arian ey] can.");
		outputText("\n\nYou continue pumping inside of the clearly pleased lizan for a while, but eventually you grow bored; as much as [Arian ey] might be enjoying this, it's not really doing anything for you, and you still want to get some sleep.  You give [Arian em] one last, deep thrust, and then try to withdraw your fingers only to find that you can't.  The greedy lizard-ass won't let you go!");
		outputText("\n\n\"<i>No, if you remove the stuffing the bagels won't be tasty...</i>\" Arian mutters, still asleep.");
		outputText("\n\nYou give a few more tugs, then sigh in disgruntlement.  Looks like you'll just have to put up with this; you're too sleepy to wake [Arian em] up.  Still, Arian's in for a tongue-lashing in the morning, you note to yourself, even as you drift off to sleep.");
		dynStats("lus", 15);
	}
	menu();
	addButton(0,"Next",camp.sleepWrapper);
}
//Waking up
//Always happens the morning after sleeping with Arian.
//Outcome slightly modified by AnalXP.
public function wakeUpAfterArianSleep():void {
	clearOutput();
	if (player.hasCock()) {
		if (arianMF("m", "f") == "f")
			outputText(images.showImage("arianfemale-camp-dreamingArian"));	
		else	
			outputText(images.showImage("arianmale-camp-dreamingArian"));
		//(if AnalXP < 33)
		if (flags[kFLAGS.ARIAN_ANAL_XP] < 33) {
			//(PC tried but didn't manage to get their cocks in. Even tho you slept with it inside, you do go flaccid at some point in the night.)
			outputText("Your eyes open, and you suddenly realize that whatever dreams you were having... are now gone.  You make note of the still sleeping lizan right next to you and recall last night's events.  You wonder if Arian will remember any of that...");
			outputText("\n\nGetting yourself out of bed, you start to stretch your muscles, cracking joints and generally waking yourself up.  While you are doing this, the lizan yawns loudly, slowly coming awake as well.  Rubbing the sleep out of [Arian eir] eyes, Arian utters.  \"<i>Morning, [name].  Sleep well?</i>\"  [Arian ey] turns to look at you and suddenly hides [Arian emself] under the covers.");
			outputText("\n\nYou give [Arian em] a wide grin and repeat the sentiment, assuring [Arian em] that you did indeed sleep well.  Aww, why's [Arian ey] being so shy?  It's far too late for either of you to be worried about being naked around each other.");
			outputText("\n\nArian's head pokes from under the covers.  \"<i>I suppose you're right... but that's still an impressive sight,</i>\"  [Arian ey] says pointing at your erect cock");
			if (player.cockTotal() > 1) outputText("s");
			outputText(".");
			
			outputText("\n\nWell, Arian gives you quite an incentive to sprout it.  Even in [Arian eir] sleep, [Arian ey]'s a masterful tease, you tell [Arian em].");
			outputText("\n\nArian grins apologetically.  \"<i>Sorry... didn't mean to tease you or anything, [name].  Do you want me to help you with that?</i>\"");
			outputText("\n\n\"<i>Well, if you're so inclined</i>\", you tell [Arian em], though the grin on your face makes it obvious you'd welcome a little attention from your reptilian playmate.");
			outputText("\n\n\"<i>All right!  Sit down,</i>\" [Arian ey] says, getting up and motioning towards [Arian eir] bed.");
			
			outputText("\n\nYou easily catch on to what the lizan has in mind and, with a smile, do as you are told, baring your crotch so to give [Arian em] the best access.");
			
			outputText("\n\nArian promptly nuzzles your " + player.multiCockDescriptLight() + ", rubbing [Arian eir] face all over ");
			if (player.cockTotal() == 1) outputText("it");
			else outputText("them");
			outputText(" shamelessly until a dollop of pre forms on the tip of your [cock biggest].  \"<i>[name]?</i>\"  You give a deliberate groan, playing up how much you're enjoying this for Arian's benefit and smiling at [Arian em].  \"<i>Thanks for the breakfast,</i>\"  [Arian ey] says with a smile, then proceeds to take the entirety of your [cock] past [Arian eir] lips and down [Arian eir] throat.  You can't resist chuckling and patting [Arian em] on the head.");
			
			outputText("\n\nThe lizan mage looks up as best as [Arian ey] can while bobbing on your shaft, trying to gauge your reaction and making sure [Arian ey]'s doing a good job of blowing you.  You smile and make it quite clear that you're enjoying this, then let out a hollow moan as your morning wood goes soft with a decent-sized explosion of cum into the lizan's sucking mouth.");
			outputText("\n\nArian's eyes bulge with surprise and [Arian ey] begins drinking down in earnest, moaning in enjoyment, which proves to be a mistake... shortly after a particularly lengthy moan, [Arian ey] tries to swallow and winds up choking.  Some cum escapes [Arian em] through [Arian eir] nose and [Arian ey] quickly pulls away, coughing.  Unfortunately for [Arian em], you're still cumming, and the result that even as [Arian ey] gags and splutters, you keep on spurting cum all over [Arian eir] face until you've emptied yourself.  You sigh in relief, then, with a hint of guilt, ask Arian if [Arian ey]'s all right?");
			outputText("\n\nWiping your seed off [Arian eir] eyes, [Arian ey] says, \"<i>I'm fine... should have been more careful... and don't worry about the facial either, all I need is a few moments to clean myself up.</i>\"  [Arian ey] gets up and walks towards a jug filled with water [Arian ey] keeps nearby.");
			outputText("\n\nYou quietly get up, pull your clothes on and start heading off to another busy day as Champion.  As you go, you can't help but notice your reptilian lover is licking [Arian eir] face clean of cum and washing it down with the water, rather than washing [Arian em]self off.");
		}
		else if (flags[kFLAGS.ARIAN_ANAL_XP] < 66) {
			outputText("With a wide yawn, you open your eyes and realize your dreams have been chased away by your sudden bout of wakefulness.  Arian seems to still be asleep; you take a short moment to snuggle up to the curled lizan, rubbing your erect cock up [Arian eir] butt crack.  Despite going soft and slipping out of the lizan's warm innards, you still have to contend with a morning wood... so you dutifully hump yourself between the lizan's buttcheeks, poking the base of [Arian eir] tail with your protruding shaft.");
			
			outputText("\n\n\"<i>Hmm, I'm awake already, stop poking me,</i>\" Arian protests, rubbing the sleep off [Arian eir] eyes and turning to look at you over [Arian eir] shoulder.  \"<i>Morning, [name].  You don't have to keep poking me under the tail to wake me up,</i>\" [Arian ey] says, a bit grumpy.  Then [Arian ey] realizes that your hands are still occupied hugging [Arian em], so what's poking [Arian em] is...  \"<i>Oh!  Sorry about that, [name]!  I thought you wanted something... I mean, maybe you do want something?</i>\"  [Arian ey] smiles nervously at you.");
			
			outputText("\n\nYou make a show of pursing your lips.  The question might be, you decide, does Arian want to do something?  After all, those were rather mixed signals [Arian ey] sent you last night...");
			outputText("\n\n\"<i>Mixed signals?  Did I do something in the night!?</i>\" [Arian ey] asks worried.");
			outputText("\n\nWell, you tell [Arian em], first [Arian ey] started acting like [Arian ey] really, really wanted you to fuck [Arian eir] ass.  Then, just when you were getting all steamed up and ready to start, [Arian ey] suddenly stopped.  So you were left to try and get back to sleep despite a raging hard-on.  It was really rather annoying, you tell [Arian em].");
			outputText("\n\n\"<i>Oh... umm... sorry.  I was probably sleep talking.  Doesn't happen too often, but well....  Sorry, I had no intention of getting you all worked up for nothing.</i>\"");
			
			outputText("\n\nYou tell [Arian em] that's a start.  Still, you think Arian might want you to work off this morning wood with [Arian em], hmm?  Would [Arian ey] like it if you held [Arian em] close and gave [Arian eir] ass a good hard fuck?");
			outputText("\n\nArian scratches [Arian eir] chin, smiling nervously.  \"<i>Well, I wouldn't be opposed, if you want to.</i>\"");
			outputText("\n\nYou promptly seize the lizan in a tight embrace, already guiding your [cock smallest] towards " + arianMF("his naughty boy-pussy","her tail-hole") + " with a smile on your face.  You teasingly muse aloud about who was saying you were giving [Arian em] the choice to say no?");
			outputText("\n\nArian jumps a bit at being suddenly grabbed, but doesn't resist, instead, [Arian ey] positions [Arian emself] to give you easy access to [Arian eir] rosebud.  \"<i>Drat!  And here I thought I would be able to escape punishment from getting you all worked up,</i>\"  Arian replies with a smile.");
			outputText("\n\nYou waste no further time, pushing your way firmly inside the hole that has so captivated you.  The lizan's tight muscles grip and squeeze you most wonderfully, and you thrust yourself back and forth as quickly and firmly as you can manage without actually hurting [Arian em].");
			outputText("\n\n\"<i>Ah... [name], you really know how to work my ass, don't you?  Hmm... if anyone told me anal feels this good back then I would have said they're insane, but - Oh!... this wonderful dick of yours feels so good.</i>\"  Arian sighs and begins humping back at you.  \"<i>There's no better way to get ready for a full day ahead of us than having sex with you like this,</i>\" [Arian ey] says dreamily.");
			outputText("\n\nYou thrust and moan and groan, losing yourself in the pleasures of sex with your reptilian lover of ass-fucking.  Eventually, the inevitable happens and, with one final cry, you release your steaming spunk up Arian's tailhole.");
			outputText("\n\n\"<i>Haaa... I can feel your seed filling me up, washing my ass with your wonderful cream!  Ah, [name]... I love you.  We should do this more often!</i>\"  Arian says in delight as you finish pumping [Arian eir] ass full of jism with a few more thrusts.");
			outputText("\n\nMaybe we should do this more often, you tell Arian.  The two of you stay locked in an embrace for a little while longer, enjoying this morning's afterglow until Arian decides to break the silence.  \"<i>Maybe we should get ready for the day ahead?  Not that I mind staying like this all day.</i>\"");
			outputText("\n\nYou agree, and messily pull yourself free of the lizan's tight ass, getting off of your lover's back and stretching out your stiff muscles.  Arian does the same, taking care to keep [Arian eir] ass closed as tightly as possible, to avoid losing any of your earlier deposit.  \"<i>Say, [name].  If you put your clothes on now, they're going to get all dirty.  So, why not get that cleaned up?</i>\" the lizan mage comments, pointing at your cum-slickened shaft.");
			outputText("\n\nYou agree with the lizan, and start looking around for a convenient rag to clean yourself off with.  But before you can spot one, you feel a familiar lizan's mouth encompass your shaft and begin sucking earnestly, making sure to get your shaft squeaky clean, even as you begin sporting another erection.  With a slurp, Arian pulls free of your shaft, leaving it to bob in the cool air of the morning as [Arian ey] grins at you, wiping [Arian eir] mouth with the back of [Arian eir] arm.  \"<i>There.  I cleaned you up.</i>\"  [Arian Ey] grins.");
			
			outputText("\n\nYou chuckle and tap the sneaky little lizard on [Arian eir] nose, pointing out that [Arian ey] did do so, but now [Arian ey] got you hard again.  So, what are you supposed to do like this?  As pleasant as it sounds, you can't spend the day buried in [Arian eir] tight little ass.  For emphasis, you spank the lizan sharply on the closest ass-cheek, producing a gobbet of cum trickling from [Arian eir] used tailhole.");
			
			outputText("\n\nArian yelps, moving [Arian eir] hands to plug [Arian eir] behind.  [Arian ey] looks at you and smiles nervously.  \"<i>Sorry, [name].  I couldn't contain myself.  It looked so tasty,</i>\"  [Arian ey] licks [Arian eir] lips for emphasis.");
			
			outputText("\n\nYou smile and chuckle; for a respected mage, Arian really has such a perverted side, and you tell [Arian em] this.  As [Arian ey] looks embarrassed, you sigh and declare you'll just have to put up with it, and start to redress yourself.");
			
			outputText("\n\n\"<i>Sorry about that.  I'll make it up to you later, if you want,</i>\"  [Arian ey] offers, walking towards a small closet to fetch a towel.  You tell [Arian em] that you'll hold [Arian em] up to that, finish redressing, and head outside to start your day.");
		}
		else { // AnalXP <= 100
			//(PC fucked and came inside Arian, couldn't pull out. Wake up with a morning wood and surprisingly... still inside the lizan.)
			outputText("\n\nYou feel a sudden urge to hump and wake up, only to find yourself still deeply lodged inside the greedy lizan's wanton rosebud.  Recalling the previous night and your little quickie in the night, you smile.  It's no wonder you're feeling particularly rested this morning.  [Arian Eir] greedy butt is as clingy as it was during the night... refusing to yield and let your shaft go.");
			outputText("\n\nWell, if [Arian ey]'s really that desperate for a buttfuck... you wrap your arms around your reptilian lover's waist, both affectionately and as a way to maintain your position, and start to thrust your pelvis, pistoning your morning wood inside the insatiable asshole you've encouraged in your lover.");
			outputText("\n\nArian moans and begins bucking back; then after a couple pumps [Arian ey] opens [Arian eir] eyes.  \"<i>Oh... [name]?  Oh!  This feels good...  W-what are you doing?</i>\"");
			outputText("\n\nJust giving [Arian em] what [Arian ey] clearly wants so badly, you reply in a distracted tone; you're starting to get into a nice rhythm here and you don't want to lose it.");
			outputText("\n\nArian moans, and begins humping back at you eagerly.  \"<i>Oh... you might feel more comfortable in this position.</i>\"  [Arian Ey] rolls around on the bed, until [Arian ey] is face down on [Arian eir] pillow, while [Arian eir] butt and tail are high up in the air to give you full access to [Arian eir] eager butt.");
			outputText("\n\nIf you weren't already buried inside of [Arian em], you'd pounce right into [Arian eir] ass.  Instead, you redouble your efforts, savoring the delicious interior of your little buttslut's ass and [Arian eir] now-deliberate efforts to milk your cock of its cum.");
			outputText("\n\n\"<i>Hmm... harder... faster,</i>\"  Arian begs, in between moans of pleasure.  Seeing no reason to deny [Arian em], you pick up the pace, roughly pounding [Arian em] for all you're worth.");
			outputText("\n\nWith a groan, you feel [Arian eir] sphincter contract, pulling you even deeper inside.  Looking down, you realize ");
			if (flags[kFLAGS.ARIAN_VAGINA] > 0) {
				outputText(arianMF("his","her") + " pussy is squirting [Arian eir] juices all over your lower body");
				if (flags[kFLAGS.ARIAN_COCK_SIZE] > 0) {
					outputText(" and ");
				}
				else outputText("; ");
			}
			else if (flags[kFLAGS.ARIAN_COCK_SIZE] > 0) {
				outputText(arianMF("his","her") + " ");
				if (flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText("twin shafts are");
				else outputText("shaft is");
				outputText(" squirting white ropes of lizan cum all over the bedsheets;");
			}
			outputText(" what a naughty little lizan.");
			
			outputText("\n\nYou can't resist playfully teasing Arian that [Arian ey] is such a buttslut.  ");
			if (!player.hasVagina()) outputText("Did [Arian ey] always know [Arian ey] wanted a man to top [Arian em], or is this development new to [Arian em]?");
			else outputText("Does [Arian ey] really get off on having a girl with a dick all [Arian eir] own fuck [Arian em] like a girl, hmm?");
			
			outputText("\n\n\"<i>No... but I love it regardless!  Fill me with your seed, please!</i>\"  Arian begs, moaning and eagerly awaiting your deposit.");
			outputText("\n\nYou thrust into [Arian em] thrice more, then, with a hollow cry, let out all the seed you can to sate your lovely little buttslut's thirst.  And this time, you can properly focus on cumming, too.");
			//(Low cum amount)
			if (player.cumQ() <= 200) outputText("\n\nThe first jet of cum of the day spurts forth from your tip to paint the eager lizan's insides.  \"<i>Ahhh... that's the way you do it,</i>\"  Arian says, tongue lolling out in pleasure as your cock finishes throbbing and shooting inside.");
			//(Medium cum amount)
			else if (player.cumQ() <= 750) {
				outputText("\n\nString after string of cum leaves your tool to paint the lizan's bowels white with the results of your morning escapade, even swelling [Arian eir] belly a bit.  \"<i>Oh, yessss... breakfast.... Hah,</i>\"  Arian says, tongue lolling out in pleasure as [Arian ey] anally devours your pent up cum.");
			}
			//(High cum amount)
			else outputText("\n\nA veritable eruption explodes from within your cock and out of your tip, flooding the lizan's buttslut with the results [Arian ey] craved.  \"<i>Yesssss!  Best... morning... ever,</i>\"  [Arian ey] says, completely blissed out, tongue lolling out, as your prodigious amount of cum inflates [Arian em] like a balloon.");
			
			outputText("\n\n\"<i>Hmm... [name], I loved waking up like this.  How about sleeping with me again tonight,</i>\"  Arian suggests, smiling in [Arian eir] afterglow.");
			
			outputText("\n\nYou are silent for a moment, instead concentrating on pulling your cock out of the lizan's ass.  Once you are free, you slap [Arian em] playfully on the butt and tell [Arian em] you'll think about it.");
			outputText("\n\n\"<i>Hmm... please do...</i>\"  Arian's mouth opens in a wide yawn.  \"<i>Still a bit sleepy.  I think I'll take a nap now, if you'll excuse me.</i>\"");
			outputText("\n\nYou chuckle and tell Arian [Arian ey]'s such a lazy little lizard, stroking [Arian eir] head affectionately before getting dressed and leaving to start your day.");
		}
		player.orgasm();
	}
	else { //PC has no cock
		//These do not link to a sex scene. No cocks, no sex in the morning, sorry girls/genderless.
		//(if AnalXP < 33)
		if (flags[kFLAGS.ARIAN_ANAL_XP] < 33) {
			outputText("You awaken with a yawn, still snuggling against your scaly sleeping partner.  You slip quietly from the bed and give a good stretch, enjoying the feeling but trying not to wake Arian up.  Shortly after you're done, the lizan's maw opens into a wide toothy yawn of [Arian eir] own, rubbing the sleep off [Arian eir] eyes, [Arian ey] looks about until [Arian ey] spots you.  \"<i>Good morning, [name]!</i>\"  [Arian ey] says cheerfully, getting up and lazily stretching [Arian emself] as well.  \"<i>Sleep well?</i>\"");
			outputText("\n\nYou tell [Arian em] that you did, and ask if [Arian ey] enjoyed having you in [Arian eir] bed as well?  \"<i>I did!  I really enjoyed having you spend the night with me.</i>\"  [Arian Ey] grins, prehensile tail swishing lazily behind.");
			outputText("\n\nWell, if that's the case, you reply, you might just consider sleeping with [Arian em] more often.  You wink as you tell [Arian em] this, kind of hoping [Arian ey]'ll blush - it's such an odd sight to see.  Arian doesn't disappoint, fidgeting a bit as [Arian eir] cheeks get slightly rose-tinted.  \"<i>I hope you will come more often,</i>\" [Arian ey] replies, always grinning.  \"<i>Maybe we should get ready for the day?</i>\"");
			outputText("\n\nYou tell [Arian em] that's a good idea, and start fishing for your clothes.  Without shame, you start getting dressed in front of [Arian em], wondering if [Arian ey]'ll appreciate the views you're giving [Arian em].  Arian starts dressing up [Arian emself] stopping every once in awhile to appreciate your body... though you know [Arian ey]'s looking [Arian ey] shyly averts [Arian eir] eyes.  You smile and give [Arian em] an appreciative shake of your booty, just to know you like the attention, before focusing on getting dressed.");
			outputText("\n\nOnce you're both fully dressed, Arian smiles at you.  \"<i>[name], have a nice day... and please come visit me soon.</i>\"  You promise you will, and start heading out.");
			outputText("\n\n\"<i>Wait!  Before you go, could you... never mind...</i>\"  The lizan fidgets a bit and turns away, walking towards [Arian eir] work desk.  With a knowing smirk on your face, you walk back and grab [Arian em] shoulder, forcefully spinning [Arian em] around and kissing [Arian em] witless.  You pause for a moment to admire the blissfully stunned, dopey look on your lover's face, then walk off to begin yet another day.");
			dynStats("lus", 10);
		}
		else if (flags[kFLAGS.ARIAN_ANAL_XP] < 66) {
			outputText("You awaken with a yawn, still snuggling against your scaly sleeping partner.  You slip quietly from the bed and give a good stretch, enjoying the feeling but trying not to wake Arian up.  Shortly after you're done, the lizan's maw opens into a wide toothy yawn of [Arian eir] own, rubbing the sleep off [Arian eir] eyes, [Arian ey] looks about until [Arian ey] spots you.  \"<i>Good morning, [name]!</i>\" [Arian ey] says cheerfully, getting up and lazily stretching [Arian emself] as well.  \"<i>Sleep well?</i>\"");
			
			outputText("\n\nYou did and ask if [Arian ey] also slept well.  Rather than replying, the lizan bites [Arian eir] lower lip and begins fidgeting in what appears to be embarrassment.  You ask what the matter is, your expression making it clear you aren't going anywhere until [Arian ey] talks about it.");
			outputText("\n\n\"<i>Well, I did sleep well.  It's just that I also had the strangest... dream.</i>\"  [Arian Ey] swallows audibly.  Oh?  And what was this dream about?  You ask in a playful tone, but you think you have an idea already...");
			outputText("\n\n\"<i>Uhh... well, I was... and then... I... had things... done to me...</i>\" [Arian ey] explains nervously.");
			
			outputText("\n\nYou shake your head and tell [Arian em] that you didn't understand a word of that.  Fidgeting, the lizan recomposes [Arian emself] and begins explaining once more.  \"<i>I-I dreamt I was... well... a muffin and... uhh... I needed my fillings, but the baker kept teasing me by putting the wrong needles in my... bottom... and... well... there was no cream... so... uuh...</i>\"  Embarrassed beyond belief, the lizan just stops talking and just fiddles [Arian eir] fingers, white cheeks tinted with the distinct rosy-pink tone that comes with embarrassment.");
			outputText("\n\nYou smile and can't resist stroking your fingers across the lizan's still naked ass, squeezing the round plumpness of [Arian eir] cheeks and stroking [Arian eir] slutty butt-pucker, just to see how [Arian ey]'ll] react.  Arian whimpers, ");
			if (flags[kFLAGS.ARIAN_COCK_SIZE] > 0) {
				outputText(arianMF("his","her") + " ");
				if (flags[kFLAGS.ARIAN_COCK_SIZE] >= 3) outputText("exposed ");
				outputText("bulbous shaft");
				if (flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText("s begin");
				else outputText(" begins");
				outputText(" sporting an erection");
				if (flags[kFLAGS.ARIAN_COCK_SIZE] < 3) {
					outputText(", poking ");
					if (flags[kFLAGS.ARIAN_DOUBLE_COCK] == 1) outputText("its tip");
					else outputText("their tips");
					outputText(" out of Arian's genital slit");
				}
				outputText(".");
			}
			else if (flags[kFLAGS.ARIAN_VAGINA] > 0) outputText("and [Arian eir] moist pussy, begins forming a stream of juices that gently run its course through the inside of Arian's thighs, evaporating before hitting the floor due to the lizan's currently elevated body heat.");
			outputText("  [Arian Ey] pants, eyes glazed.  \"<i>Uhh... [name]...</i>\"");
			
			outputText("\n\nYou smile at [Arian em] gently and step back, pulling on your clothes and giving [Arian em] a tender kiss on the cheek before you slap [Arian eir] bum and head off to start another day.  \"<i>[name].  Visit me soon... please?</i>\" you hear Arian say as you leave, still panting and flustered due to [Arian eir] arousal.");
			dynStats("lus", 10);
		}
		else { // AnalXP <= 100
			outputText("You yawn quietly as you find yourself waking up to another new day.  You note that your hand doesn't feel as cramped as you'd expected; in fact, it turns out that your little buttslut must have let your fingers go sometime after you'd gone back to sleep.  You sigh gently and pat Arian on the back; the thought slips into your mind that maybe [Arian ey] would like it more if you'd grow a new cock, so you can fuck [Arian em] up the ass the way [Arian ey] clearly enjoys so much...");
			outputText("\n\nArian yawns widely, licking [Arian eir] lips and turning to the side to greet you with a sleepy smile.  \"<i>Morning, [name],</i>\" [Arian ey] says, rubbing the sleep off [Arian eir] eyes; [Arian eir] tail slowly creeps its way over your midriff.  \"<i>Sleep well?</i>\"");
			
			outputText("\n\nYou tell [Arian em] that you did, though there was a little problem in the middle of the night, a knowing smirk on your features as you say this.  Concerned, Arian asks, \"<i>What happened.</i>\"");
			
			outputText("\n\nOh, nothing that probably couldn't be solved by your regrowing a cock, you joke.  Arian looks confused.  \"<i>Whatever do you mean by that?</i>\"");
			
			outputText("\n\nYou just smile at [Arian em] and tell [Arian em] not to worry [Arian eir] pretty little head, or [Arian eir] cute little butt.  You pat [Arian em] on the ass playfully, then swing your [legs] off of the bed and get up, ready to start getting dressed.  Arian still looks mildly confused, but decides to get off bed and start getting dressed as well.  During the whole process [Arian ey] keeps shooting you longing glances.");
			
			outputText("\n\nYou finish pulling your clothes on and, unable to resist your curiosity, ask your little love-lizard why [Arian ey] keeps looking at you like that?");
			
			outputText("\n\nArian fiddles [Arian eir] fingers.  \"<i>What you said earlier.  I... would really appreciate it if you grew a nice, big, thick cock... full of cum...</i>\"  Arian trails off, licking [Arian eir] lips dreamily and fidgeting slightly.");
			
			outputText("\n\nYou teasingly ask if [Arian ey]'s really gotten that used to your reaming [Arian eir] ass like that - why, you would have thought [Arian ey]'d prefer if it you stopped.  Arian averts [Arian eir] eyes and bites [Arian eir] lower lip.  \"<i>No, I mean....  I didn't like it... much... at first.  But, I guess the feeling kinda grew on me, and... well... I've been feeling just so empty lately.</i>\"  [Arian Ey] swallows audibly.  \"<i>What I mean to say is... yes, I like it when you poke me back there.</i>\"  [Arian Ey] hides [Arian eir] face in embarrassment, though [Arian ey] fidgets in what you've come to recognize as an indication [Arian ey] is aroused.  You can't resist smiling, then stepping over to clasp the still-naked lizan's bum, fingers slipping around to gently tease the entrance of [Arian eir] well-trained back pucker, which flexes and tries to entice your fingers inside.  You tell him you'll consider growing a cock back, tap him on the nose with the very fingers you were just teasing him with, and then leave to start a new day.");
			dynStats("lus", 10);
		}
	}
	flags[kFLAGS.ARIAN_MORNING] = 0;
	doNext(playerMenu);
}

//Egging Event
//Only if Arian has a vagina.
//Every 30 days, ArianEggEvent is set to 1. Allowing this event happen.
//It always happens the first time you visit Arian, every 30th day.
//If you don't visit Arian, you miss this event, and the eggs [Arian ey] would be laying.
public function arianEggingEvent():void {
	clearOutput();
	flags[kFLAGS.ARIAN_EGG_EVENT] = 1;
	if (flags[kFLAGS.ARIAN_EGG_CHAT] == 0) {
		flags[kFLAGS.ARIAN_EGG_CHAT]++;

		outputText("As you are about to enter Arian's tent, you hear a moan emanate from within.  Those aren't moans of pleasure though.  They are moans of discomfort.  Wondering if the lizan is all right, you decide to enter [Arian eir] tent.");
		
		outputText("\n\nArian is laying on [Arian eir] bed, naked, as [Arian ey] rubs [Arian eir] belly in a slow circular motion.  You rush to [Arian eir] side and ask what happened?");
		
		outputText("\n\n\"<i>Uh?  Oh, hello [name].  Just feeling a bit sick, that's all.</i>\"  Arian smiles, somewhat embarrassed, and adds, \"<i>You see... it's that time... when girls... y'know.</i>\"  [Arian Ey] giggles.");
		
		outputText("\n\nYou sigh in relief, for a moment you thought [Arian eir] health problems might have returned.  So... this means [Arian ey]'s growing a clutch of eggs inside [Arian eir]?");
		
		outputText("\n\nArian nods in confirmation.  \"<i>That's right.  Lizan females grow unfertilized eggs inside them and must lay those every 30 days.  Today just happens to be my day.  This is the time when a male would... fertilize... the eggs and then the female would lay a clutch of fertile eggs.</i>\"");
		
		outputText("\n\nYou listen attentively, then a question hits you.  Wouldn't lizans overpopulate if they lay eggs in clutches?  Or are those clutches particularly small?");
		
		outputText("\n\nArian shakes [Arian eir] head.  \"<i>No. Usually we lay clutches of 10 or so eggs, but despite all the eggs being fertilized, not all of them will mature into a healthy baby.  Usually only one or a couple manage to mature.</i>\"  That's sad to hear, you comment.  Arian smiles and shrugs.  \"<i>It's just the way we're built...</i>\"");
		
		outputText("\n\nYou ask if anyone could fertilize [Arian eir] egg.  Arian, fidgets and bites [Arian eir] lower lip.  \"<i>Well... yes.  Why do you ask?  Are you... maybe... interested?</i>\"  You give it some thought... and tell [Arian em] that you were just curious, but who knows... maybe in the future.");
		
		outputText("\n\nArian averts [Arian eir] eyes, smiling happily.  \"<i>Maybe, but I have to say this is not the way I saw myself having a family.  I always thought I'd be the one helping lay... you know?</i>\"  You nod, does that make [Arian em] uncomfortable?  Arian shakes [Arian eir] head.  \"<i>Not at all, if there's anyone I'd pick to father my children, that would certainly be you, [name].</i>\"  [Arian Ey] smiles at you, and you smile right back at [Arian em].");
		
		outputText("\n\nSo... unless you plan on having a family with [Arian em]... sex is out of the question.  Arian blurts out, \"<i>No!</i>\"  You recoil in surprise at [Arian eir] sudden outburst; [Arian ey] covers [Arian eir] mouth and smiles nervously.  \"<i>S-sorry... must be the hormones making me moody... regardless... no.  I have placed an enchantment on myself, and you won't be able to impregnate me unless we remove that.  So... someday when we're both ready and willing... hehe.</i>\"  [Arian Ey] fidgets, laughing nervously.");
		
		outputText("\n\nYou tell [Arian em] that it's reassuring to hear that [Arian ey]'s being careful about this matter.");
		outputText("\n\n\"<i>Of course, parenthood is a big responsibility,</i>\" Arian notes.");
		
		outputText("\n\nYou nod your head.  Then, curious, you ask what [Arian ey]'ll do with the eggs after [Arian ey]'s laid them, if there's going to be nothing inside of them?");
		
		outputText("\n\n\"<i>Usually we'd just eat them, since they're rich in protein and good for the health of the mother, but I think I can try and create something useful for you.  You know how there are magical colored eggs that are said to have transformative effects, right?  I could try to use my magic and grow a few eggs with the color of your choosing.</i>\"");
		
		outputText("\n\nYou tell [Arian em] that could be very helpful in your quest, but you don't want [Arian em] to strain [Arian em]self; can [Arian ey] do it without hurting [Arian em]self?");
		
		outputText("\n\nArian puffs [Arian eir] chest out proudly.  \"<i>Of course I can!  Though magic can be unpredictable sometimes, I am a master mage, and something as simple as imbuing my own eggs with magic is no trouble at all...  but I appreciate your concern all the same.</i>\"  [Arian Ey] smiles at you.");
		
		outputText("\n\nIf that's the case, you tell [Arian em], then you would appreciate it if [Arian ey] could try creating colored eggs for you from [Arian eir] unfertilized eggs.");
		
		outputText("\n\n\"<i>Sure!  Which color do you want?</i>\"");
	}
	else {
		outputText("As you are about to enter Arian's tent, you hear a moan emanate from within.  Seems like it's that time of the month again...");
		outputText("\n\nAs you enter the tent, you are greeted with the sight of Arian laying on [Arian eir] bed, naked, as [Arian ey] rubs [Arian eir] belly in a slow circular motion.  [Arian Ey] spots you walking towards [Arian em] and greets you with a smile.  \"<i>Hello, [name].  I have a new clutch of eggs growing inside me, would you like me to try and create a colored egg for you?</i>\"");
	}
	//(Display Color Options, in the future you will also have the option of telling her you want to fertilise her eggs.) (Also include a leave option.)
	menu();
	addButton(0,"Brown",pickAnEggArian,"brown");
	addButton(1,"Purple",pickAnEggArian,"purple");
	addButton(2,"Blue",pickAnEggArian,"blue");
	addButton(3,"Pink",pickAnEggArian,"pink");
	addButton(4,"White",pickAnEggArian,"white");
	addButton(5,"Rubber",pickAnEggArian,"rubbery black");
	addButton(6,"No Thanks",leaveEggs);
}

//Pick a color
private function pickAnEggArian(color:String = "pink"):void {
	clearOutput();
	flags[kFLAGS.ARIAN_EGG_COLOR] = color;
	outputText("You tell Arian you'd like [Arian em] to make you a " + color + " egg.");
	outputText("\n\n\"<i>All right,</i>\" Arian replies, closing [Arian eir] eyes and beginning to focus [Arian eir] magic.");
	outputText("\n\nYou watch in wonder as a " + color + " light seems to gather within Arian's belly, slowly fading away.  The lizan mage smiles and opens [Arian eir] eyes, tail waving lazily behind [Arian eir] in happiness.  \"<i>It's done.  I tried to get all my eggs imbued, but I won't know if I was successful or not until they're laid.</i>\"");
	
	outputText("\n\nYou thank [Arian em] for [Arian eir] efforts, give [Arian eir] a quick peck on the cheek, and then encourage [Arian em] to get some rest.  Arian nods.  \"<i>I should be ready to lay tomorrow, so don't forget to visit.</i>\"");
	outputText("\n\nYou nod in understanding and wave to [Arian em] as you leave [Arian eir] tent.");
	flags[kFLAGS.ARIAN_EGG_COUNTER] = 1;
	doNext(camp.returnToCampUseOneHour);
}
//Leave
private function leaveEggs():void {
	clearOutput();
	outputText("You tell [Arian em] that you don't want any colored eggs from [Arian em] this month.  The lizan nods, deciding it's not necessary for [Arian em] to spell out that this means [Arian ey]'ll just produce ordinary eggs and eat them for breakfast after [Arian ey]'s laid them.  \"<i>So, do you want something?</i>\" [Arian ey] asks.");
	doNext(camp.returnToCampUseOneHour);
}

//Display Arian options
//Arian Lays Colored Eggs
//Happens the day after Egging Event, always happens the first time the PC visits.
//Even if you miss, trigger it the next visit anyways, so as long as you don't miss the egging event, you don't miss out on your colored eggs.
//Randomly decide between small or large egg, I'd say 50% chance of either.
public function arianLaysEggs():void {
	clearOutput();
	var color:String = flags[kFLAGS.ARIAN_EGG_COLOR];
	flags[kFLAGS.ARIAN_EGG_COUNTER] = 0;
	outputText("As you approach the tent, you wonder if Arian's ready to lay those eggs...  Your contemplations are promptly interrupted as you hear a pained moan coming from inside.  Seems like Arian is in labor!  Without delay, you rush inside, to be greeted by the sight of naked lizan-");
	if (flags[kFLAGS.ARIAN_COCK_SIZE] > 0) outputText("herm");
	else outputText("girl");
	outputText(" squatting over a wooden basin, one hand between [Arian eir] legs, massaging [Arian eir] dripping treasure, while the other is rubbing [Arian eir] belly to try and coax the eggs out of [Arian em].");
	
	outputText("\n\nYou see [Arian em] sway momentarily, too focused on the task at hand to even notice you.  Fearing [Arian ey] might lose [Arian eir] balance and fall, you quickly move behind [Arian em], hugging and steadying [Arian em].");
	
	outputText("\n\nThe lizan ");
	if (flags[kFLAGS.ARIAN_COCK_SIZE] > 0) outputText("herm" + arianMF("-boy", ""));
	else outputText("female");
	outputText(" is sucking in great lungfuls of air, slowly hissing them out as [Arian ey] soldiers on through the contractions of [Arian eir] womb.  So intent on [Arian eir] labors is [Arian ey] that [Arian ey] doesn't recognize your presence, at first.  After a few moments, however, [Arian eir] eyes finally recognize you're there and [Arian ey] gives you a brave smile.  \"<i>Ah, hello, [name]; sorry you had to catch me like this - I was hoping I'd have this over and done before you saw it,</i>\" [Arian ey] notes apologetically.");
	
	outputText("\n\nYou scold [Arian em], telling [Arian em] [Arian ey] should've called you when [Arian ey] was getting ready to lay; you would have gladly helped.  You tighten the hug, bringing [Arian em] closer to your chest, one hand moving to meet hers as [Arian ey] slowly massages [Arian eir] belly.  You entwine your fingers with hers and help [Arian em] massage [Arian eir] belly.");
	
	outputText("\n\n\"<i>Mmm... thank you, [name], that does feel nicer when it's someone else.  This wouldn't be so bad if I knew it was going to be a baby at the end of it, but I go through all this for nothing more than a quick snack.  I can kind of understand why harpies have always been so nuts about getting fertilized when they're full of eggs, now: it's not so much that they - or I - want to be moms so badly as it is just so annoying to go through this for absolutely no reward at the end of it,</i>\" the lizan notes, sighing heavily and leaning against you for support.");

	outputText("\n\nStill, you are very thankful for [Arian em] doing this for you.  Then you note that [Arian ey] seems to really have fallen into [Arian eir] role as a " + arianMF("hermboy","girl") + ".  You would never expect to hear this kind of comment from someone who was a man before... but it's cute that Arian is acting this way, and you enjoy [Arian em] the way [Arian ey] is now.  You give [Arian em] a peck on the cheek for emphasis.  Now, [Arian ey] has a clutch to lay, and you'll be here during all the steps necessary to do so.  You take [Arian eir] hand off [Arian eir] belly and place it against your midriff, then proceed to rub [Arian eir] belly by yourself.  Your other hand, releases [Arian em] and does the same with the hand massaging [Arian eir] pussy lips, replacing [Arian eir] hand shortly as you tease and massage the contracting opening to [Arian eir] depths.");

	outputText("\n\nThe lizan moans throatily.  \"<i>Mmm... you really do have magic fingers, don't you?</i>\"  [Arian Ey] says, then winces.  \"<i>Ahg, that was a nasty one - they'll be coming out any minute now,</i>\" [Arian ey] notes in a surprisingly level tone, moaning softly as [Arian eir] abdominal muscles flex and contract.");

	outputText("\n\nNever stopping your ministrations, you ask what you should do?  Arian doesn't have time to answer though, as you feel one of the egg shaped lumps beginning its journey down the lizan's birth canal.  You feel [Arian eir] pussy dilating, far faster than it should on any woman, and for a moment you worry as the egg passes quickly, falling into your waiting hand.  You barely have time to safely place it on the basin as another egg soon falls into your hand.  Arian's belly vibrates with the rapid contractions, rapidly reducing in size as the eggs make their way out.");

	outputText("\n\n\"<i>Nnng... once it finally starts, it's over quick, so don't worry, [name].  I'll be done in a minute,</i>\" [Arian ey] promises you.");
	
	outputText("\n\nYou nod, though [Arian ey] can't see you from this position.  You whisper that [Arian ey] is a very brave girl to face this kind of ordeal... and you can't deny that seeing [Arian eir] laying eggs like this has a certain appeal.  [Arian Ey] looks very sexy.  You tell [Arian em] that this is good practice for when [Arian ey]'s laying fertile eggs.  You hope [Arian ey]'ll look as sexy as [Arian ey] looks now, once the time comes.");

	outputText("\n\nThe lizan laughs, a rather pitch-switching sound as [Arian eir] uterus continues flexing.  \"<i>If you really think I'm sexy like this, [name], then I sure hope we'll end up doing this for real sooner rather than later.  Oooh... not more left in me now,</i>\" [Arian ey] says, closing [Arian eir] eyes and continuing to push.  As [Arian ey] said, within moments, [Arian eir] belly is flat as normal, while the last few eggs have clattered into the straw-lined basin [Arian ey]'s been squatting over.  With a hissing sigh of relief, [Arian ey] gingerly straightens up and steps over it.  \"<i>I... can you please get me some cool water, [name]?  I have a jug over there?</i>\" [Arian ey] asks, pointing in the appropriate direction.");
	
	outputText("\n\nOf course you can, you reply.  You gently help [Arian em] down on the floor from [Arian eir] squat, and head towards the jug [Arian ey] indicated.  Looking about, you quickly spot a mug and fill it with water, bringing the cool liquid back to the panting lizan.  [Arian Ey] takes it from you and gulps down a sizable mouthful of it, then pours some over [Arian eir] head.  \"<i>Ohhh... that feels better.  Why don't you check the eggs, see if our little experiment worked?  I'm just going to regain my strength,</i>\" [Arian ey] suggests.");
	
	outputText("\n\nYou nod your head, and begin sorting through the eggs.  Most of them look like common eggs, not that much different from large chicken eggs.  Eventually, you find one that seems to be appropriate.  Separating this egg from the others, you check one more time and find out that Arian only managed to lay one " + color + " egg.  Still, that's good enough for you.  You take the egg and turn to place it gently on the nearby counter.  When you turn to check up on Arian though you spot the lizan, casually lifting one of the \"<i>normal</i>\" eggs, sizing it up.");
	
	outputText("\n\nArian pays no attention to you, instead hungrily inspecting [Arian eir] just-laid egg.  A trickle of drool oozes out of the corner of [Arian eir] mouth and is lapped up with a quick flick of a long tongue before [Arian ey] opens [Arian eir] jaws and crams the whole egg inside.  [Arian Ey] mouths it around before [Arian ey] manages to puncture it, audibly sucking out the insides before spitting the crushed but still-intact eggshell out into [Arian eir] hand.  [Arian Ey] grabs another and gobbles it down with the same eagerness as before, spitting out the shell after sucking out the contents.");
	
	outputText("\n\nYou cough, trying to remind the hungry lizan before you, that you're still in the room...");

	outputText("\n\nShe pauses, just about to cram another egg into [Arian eir] mouth, and looks sheepish.  \"<i>Ah... sorry, [name].  I'm just so hungry and, well, it's not like there's anything else in these things, right?  Or did you want to try one?</i>\" [Arian ey] suddenly suggests, offering [Arian eir] latest 'treat' to you.");

	outputText("\n\nYou politely refuse, telling [Arian em] that [Arian ey] probably needs it more than you do, since [Arian ey] just went through labor.  Anyways you should probably be going.  You thank the lizan for the " + color + " egg and tell [Arian em] to enjoy [Arian eir]... meal... and point out that, while you personally appreciate the view, [Arian ey] should probably put on some clothes later.");
	outputText("\n\nArian gasps and quickly covers [Arian em]self, smiling nervously to you.  \"<i>Thank you for pointing that out, [name].  Although,</i>\" [Arian ey] giggles nervously.  \"<i>If you'd rather I stay naked, I'm willing to do that for you...</i>\"  You give the idea some thought... but decide to tell [Arian em] that you'd prefer [Arian ey] put on some clothes next time you visit.  Otherwise you miss out on having [Arian em] sensuously strip for you, you laugh.");
	
	outputText("\n\n\"<i>Well, that's one way to look at it, I guess.</i>\"  Arian laughs.  \"<i>So, if you don't want to join me, a lady needs to have [Arian eir] breakfast,</i>\" [Arian ey] tells you, then swallows another egg whole, letting out a very unladylike belch.  \"<i>Okay, that was a bit too much to swallow,</i>\" [Arian ey] admits, blood flushing the pale scales of [Arian eir] face in one of [Arian eir] pseudo-blushes.");
	
	outputText("\n\nYou laugh at Arian's reaction, telling [Arian em] that you don't mind.  You should go right now.  You turn to pocket the egg and leave Arian's tent, bidding the lizan farewell before you do.\n\n");
	//(PC obtains (Large) Egg of the [color] asked message.)
	var itype:ItemType;
	if (flags[kFLAGS.ARIAN_EGG_COLOR] == "brown") itype = consumables.L_BRNEG;
	else if (flags[kFLAGS.ARIAN_EGG_COLOR] == "purple") itype = consumables.L_PRPEG;
	else if (flags[kFLAGS.ARIAN_EGG_COLOR] == "blue") itype = consumables.L_BLUEG;
	else if (flags[kFLAGS.ARIAN_EGG_COLOR] == "pink") itype = consumables.L_PNKEG;
	else if (flags[kFLAGS.ARIAN_EGG_COLOR] == "white") itype = consumables.L_WHTEG;
	else if (flags[kFLAGS.ARIAN_EGG_COLOR] == "rubbery black") itype = consumables.L_BLKEG;
	inventory.takeItem(itype, camp.returnToCampUseOneHour);
}
//DildoFun
private function arianDildoFun():void {
	//As usual, nothing we write is centaur compatible.
	//Cocks are going to be more or less forgotten here.
	//PC must have the dildo sex toy from Giacomo to access this scene
	//PC and Arian must both have vaginas to access this scene
	clearOutput();
	//1st time:
	if (flags[kFLAGS.TIMES_ARIAN_DILDOED] == 0) {
		outputText("Looking over your reptilian girlfriend, your eyes go down [Arian eir] body");
		if (flags[kFLAGS.ARIAN_COCK_SIZE] > 0) {
			outputText(", past [Arian eir] cock");
			if (flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText("s");
		}
		else outputText(",");
		outputText(" to [Arian eir] dripping wet pussy, clearly yearning for some action.  Reflecting that your own love-lips feel the same way, you decide to try something fun and present to Arian the dildo that you ");
		if (player.hasKeyItem("Dildo") >= 0) outputText("bought from Giacomo");
		else outputText("got from Tamani");
		outputText(", asking if [Arian ey]'s willing to give this a try.");
		
		outputText("\n\nThe lizan averts [Arian eir] eyes in embarrassment.  \"<i>Umm... I guess I'm okay with it?</i>\"  [Arian Ey] fidgets a bit.  \"<i>But I've never used anything when... much less something like that.</i>\"");
		
		outputText("\n\nYou shush [Arian em] gently, assuring [Arian em] that it'll be all right; you'll be here to help [Arian em] get comfortable with it and to show [Arian em] how to use it right.  Besides, it's much better than [Arian eir] fingers....");
		
		outputText("\n\n\"<i>A-All right then.</i>\"  [Arian Ey] smiles nervously.");
	}
	else {
		outputText("You present your dildo to Arian again, telling [Arian em] that this time, you want to play with your toys - after all, [Arian ey] enjoyed it so much the first time.");
		
		outputText("\n\nArian fidgets in embarrassment.  \"<i>Okay.</i>\"");
	}
	flags[kFLAGS.TIMES_ARIAN_DILDOED]++;
	
	outputText("\n\nYou carefully put the dildo down beside the pillow before turning to Arian and pulling [Arian em] into an embrace, arms around [Arian eir] waist, before spinning [Arian em] around, sweeping [Arian em] off [Arian eir] feet, and dropping [Arian em] flat on the bed.  [Arian Ey] giggles nervously as you slide yourself into position, straddling [Arian em] and pinning [Arian eir] wrists to the bed beside [Arian eir] head, leaving [Arian em] helpless.  Your tongue slides out of your lips in a lecherous gesture before you bend your head down and kiss [Arian em] first on one dark nipple, and then on the other.  Arian wriggles and squirms underneath you as you start to plant quick, soft, gentle kisses up [Arian eir] torso and towards [Arian eir] neck, diligently kissing your way towards [Arian eir] lips.  Once there, you plant a butterfly kiss on [Arian eir] lips, but that's not enough; you release your grip on [Arian eir] wrists and instead place a soft but authoritative palm on each of [Arian eir] cheeks, pinning [Arian em] in place as you passionately consume [Arian eir] lips with your own.");
	
	outputText("\n\nYour lizan lover reciprocates your kiss, [Arian eir] scaled arms wrapping around you as [Arian ey] hugs you tightly, legs instinctively spreading to allow you access.  You continue to suckle at [Arian eir] lips, forcefully probing at them with your tongue to see if [Arian ey] will allow you access.  Even as you do this, you settle yourself more comfortably upon [Arian eir] body and slide a hand down [Arian eir] torso, over [Arian eir] belly until you reach between [Arian eir] legs.  ");

	if (flags[kFLAGS.ARIAN_COCK_SIZE] > 0) {
		outputText("Ignoring [Arian eir] cock");
		if (flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText("s");
		outputText(", y");
	}
	else outputText("Y");
	outputText("ou slide first one finger into [Arian eir] slick pussy and then another, gently caressing [Arian eir] inner labia to see if you can find [Arian eir] sweet spots.  Arian's eyes open in surprise as the first pang of pleasure hits [Arian em], [Arian ey] moans into your kiss.  [Arian Eir] tongue darts to dance with your own in excitement.");
	
	outputText("\n\nYou allow [Arian eir] tongue to wrestle with yours, suckling lewdly upon it and watching as Arian writhes and moans underneath you, totally in your thrall.  But, enough is enough when it comes to a warm up; you break the kiss and remove your hand from [Arian eir] cunt.  Arian protests feebly, but you shush [Arian em], caressing [Arian eir] cheek as you declare that the time for warming up is over.  With your other hand, you reach for the nearby dildo and then slap it between [Arian eir] [arian chest].  It's time [Arian ey] put on a little show for you....");
	
	outputText("\n\nThe lizan mage swallows nervously, but nods in understanding.  You give [Arian em] one last kiss for being so obedient, squeeze [Arian eir] breasts in passing, and then drag yourself off of [Arian em], deliberately scraping your [vagina] over [Arian eir] belly as you go and shivering with pleasure at the sensations [Arian eir] smoothly scaly skin sends through your cunt.  You hop off of the bed and reposition yourself sitting upright at the base, where you have a perfect seat for whatever [Arian ey] plans on doing next.");
	
	outputText("\n\nArian takes the dildo in hand, gripping and releasing it to watch the rubber shift under [Arian eir] touch.  [Arian Ey] looks nervously at you one more time and then opens [Arian eir] mouth wide.  [Arian Ey] slips the dildo between [Arian eir] lips, suckling softly, wetting it with [Arian eir] saliva.  Not bad, not bad at all for a beginner, and you nod your head, encouraging [Arian em] that [Arian ey]'s getting off to a good start.  Arian blinks in understanding and continues to lather the rubber shaft in saliva.");
	
	outputText("\n\nShe pops the dildo out of [Arian eir] mouth, satisfied with its current wetness.  With one hand, [Arian ey] cups a breast and rubs the tip of the dildo on [Arian eir] erect nipple, moaning at the stimulation.  [Arian Eir] eyes glance at you to see if [Arian ey]'s pleasing you.  You shift so that [Arian ey] can see your naked form, letting [Arian em] watch as your hands slip teasingly down to your love canal's entrance.  You moan softly, starting to frig yourself in excitement at the show [Arian ey]'s putting on.  Emboldened by your display, Arian smiles and licks the tip of the dildo once more.  [Arian Ey] moans as [Arian ey] strokes [Arian eir] other nipple, setting the dildo between [Arian eir] breasts to run its length along [Arian eir] cleavage.  Whenever the dildo grows dry, [Arian ey] takes it back to [Arian eir] mouth to lather it again with a drawn out slurp.  [Arian Ey]'s starting to get in the mood, you notice.");
	
	outputText("\n\nYou clap your hands all of a sudden, startling Arian out of [Arian eir] oral ravishing.  You crawl your way up to [Arian em], your motions smooth and seductive, gently taking the dildo from [Arian eir] unresisting fingers as you coil yourself around [Arian em].  [Arian Ey]'s been putting on a very nice show, you stage whisper to [Arian em], but this isn't really what you wanted to see.  You're going to give [Arian em] a hand and show [Arian em] just how good this can really be....");
	
	outputText("\n\nYou start by seductively wrapping your own tongue around the dildo, sloppily kissing it and slurping on it, sucking eagerly at the taste of [Arian eir] saliva and making sure it's good and sodden with both your mixed juices.  Then, you hold the dripping wet toy up to [Arian em] for [Arian eir] inspection.  [Arian Ey] looks at the dildo enraptured, panting in excitement.  Then, now that [Arian ey]'s good and excited, you bring the dildo down to the junction of [Arian eir] legs, ");
	if (flags[kFLAGS.ARIAN_COCK_SIZE] > 0) {
		outputText("brushing it tantalizingly across the sensitive skin of [Arian eir] pre-oozing cock");
		if (flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText("s");
		outputText(" before");
	}
	outputText(" brushing it against [Arian eir] outer lips, stroking it up and down each labia, rubbing it against [Arian eir] clitoris, gently pushing the very tip of it into [Arian eir] cunt only to then withdraw it before it can really start to stretch [Arian eir] cunt.");
	
	outputText("\n\nArian moans and fidgets as you play with [Arian eir] body, moaning and gasping at the friction generated by the rubber dildo.  \"<i>Oh, [name].  T-that feels great!</i>\" [Arian ey] moans in delight, bucking against the dildo in an attempt to find purchase.");
	
	outputText("\n\nIf it feels so good, then why doesn't [Arian ey] prove it, you ask [Arian em], continuing to tease [Arian em] with the dildo but refusing to put it in, your free hand stroking your [clit] and fingerfucking your [vagina] at an excited pace.  Isn't [Arian ey] just dying to have this fake-cock between [Arian eir] legs, spreading [Arian eir] pussy wide and stretching out [Arian eir] gut until [Arian ey]'s a helpless puddle of fuck?  Why doesn't [Arian ey] show you that's what [Arian ey] wants?");
	
	outputText("\n\nArian looks at you in confusion.  \"<i>Prove it? ...Ah!</i>\" [Arian ey] moans loudly, bucking wildly against your teases.  Yes, prove it... and with that, you take a firm grip on the dildo and roughly thrust it as far into Arian's cunt as the horny lizan will let it enter!  The " + arianMF("", "she-") + "lizan's maw opens in a look of surprise; instead of a scream, all [Arian ey] can manage is a gasp.  You make sure to commit the image to memory for moments.  Arian closes [Arian eir] eyes and moans - a throaty moan, a moan of pleasure.  [Arian Eir] face contorts as [Arian eir] vaginal walls clamp down on the rubbery intruder.  ");
	if (flags[kFLAGS.ARIAN_COCK_SIZE] > 0) {
		outputText("[Arian Eir] cock");
		if (flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText("s throb");
		else outputText("throbs");
		outputText(" throb as a jet of whiteness escape them.  ");
	}
	outputText("You can feel it... the suddenness of your penetration brought the poor lizan mage to an instant orgasm.");
	
	outputText("\n\nGrinning wickedly to yourself, you sprawl yourself across your reptilian girlfriend, hungrily kissing [Arian em] and sucking [Arian eir] long, prehensile tongue into your mouth to play with it - and to muffle any further screams of ecstasy.  With one hand, you grope [Arian eir] [arian chestAdj] boobs, while with the other you continue to plunge the dildo back and forth inside of [Arian em], sliding it out - not easy, with how tightly [Arian ey] grips it in [Arian eir] cunt - before roughly pounding it home again, a repetitive motion to burrow for [Arian eir] cervix and to leave [Arian eir] a quivering pile under you.  The poor lizan is helpless against your relentless assault.  All Arian manages is squeals of pleasure and wanton moans of desperate lust.");
	
	outputText("\n\nYou keep this up for minute after delightfully entertaining minute, before you decide that [Arian ey]'s had [Arian eir] fun; now it's your turn.  You try to tug the dildo free of [Arian eir] clenching cunt, but [Arian ey] just quakes and moans as another orgasm rips through [Arian eir] body - [Arian ey]'s holding the toy so tightly inside [Arian eir] that you can't get it out!  You let go of it and pat [Arian eir] cheek, tauntingly complaining that [Arian ey]'s not being fair.");
	
	outputText("\n\nArian groans, opening [Arian eir] eyes slightly to look at you.  \"<i>W-What do you... mean by that?</i>\" [Arian ey] asks, clearly not recovered after [Arian eir] climax.");
	
	outputText("\n\nWhy, [Arian ey]'s hogging the dildo all to [Arian em]self, you reply, making another failed attempt at pulling it free for emphasis.  [Arian Ey] gets to get off, but you get no fun for yourself - now, does that seem fair to [Arian em]?  Hmm?  Arian pants, shaking [Arian eir] head.  \"<i>Sorry...</i>\"  [Arian Ey] attempts to even out [Arian eir] breathing enough to at least speak normally.");

	outputText("\n\n\"<i>Sorry, [name].  I don't think you can pull the dildo out of me yet.  That would... well... it would be too much for me.  So please.  Just don't, at least for now.</i>\"  You crawl off of [Arian em] slightly, so [Arian ey] can move more freely and so you can watch [Arian em] at work.  \"<i>I think I can help you with your problem though.</i>\"  Interested, you give [Arian em] the signal to go ahead.  [Arian Ey] begins chanting a spell and within moments you watch in amusement.  Your dildo's base begins extruding itself, growing into a familiar phallic shape.  Soon enough you're looking at an exact replica of the dildo currently buried in your lizan girlfriend.  Clever girl....");

	outputText("\n\nArian smiles tiredly.  \"<i>There.  Forgive me, [name], but I'm too tired to move right now.</i>\"  That's all right; you can move for [Arian em], you reply, already shifting yourself into position, bringing your [vagina] into alignment to start impaling yourself on your now double-ended dildo.");
	
	outputText("\n\nYou shift and thrash, moaning lewdly as you stroke every spot that you know will bring you pleasure; in your aroused state, it's easy to get into things.  Each thrust you make earns an ecstatic groan from your girlfriend as it shifts the dildo inside [Arian eir] over-aroused pussy.  You hump and you grind and you squeeze, a tug of war between your two netherlips as you and Arian fight for possession of your favorite toy.  You can feel the pleasure overwhelming you, sparks of arousal setting your brain on fire; you're close... oh, gods, you're so close!");
	
	outputText("\n\nWith one mighty clench and tug, you pull the dildo free of Arian's love-hole, throwing your head back and crying out as you climax, the waves of orgasm washing through you, your whole body quaking in pleasure.  When at last it ends, you let yourself fall limply back on the bed with a sigh of relief, your pussy slackening and letting your dildo fall free.");
	
	outputText("\n\nOnce you catch your breath, you absently reach down and bring your favorite toy up to your face, you watch as it slowly reverts back to its original form, though still dripping with your mixed juices.  Smiling openly, you inform Arian that you may just be the luckiest " + player.mf("boy", "girl") + " in Mareth, to have a " + arianMF("herm-boy", "girl") + "friend like [Arian em].");
	
	outputText("\n\nArian pants, still winded, though [Arian eir] breathing seems to have returned to a more normal level.  [Arian Ey] can't help but grin at your compliment.  \"<i>Don't be silly, [name].  I'm the lucky one.  But I'm really glad you think so highly of me.</i>\"  Why shouldn't you?  [Arian Ey] gave up [Arian eir] birth-gender, just to better please you - why, any girl who passed up a chance to snap up someone as sweet as Arian was a fool, but they'll never amend their mistake, because [Arian ey]'s all yours now.  With that you slither around in the bed so that you can glomp onto your " + arianMF("herm-boy", "girl") + "friend, rubbing your " + player.skinFurScales() + " cheek against [Arian eir] own smooth scales, hugging [Arian eir] tightly to you.");

	outputText("\n\nArian rubs [Arian em]self back at you affectionately.  \"<i>I love you, [name].</i>\"  You just hold [Arian em] and let [Arian em] feel your warmth.  Then, you realise you're still holding a sopping wet dildo in one hand, and you casually present it to Arian, holding it in front of [Arian eir] face and telling [Arian em] to clean it.  Before [Arian ey] can protest, you point out that <b>[Arian ey]</b> got the most fun out of it, and <b>[Arian ey]</b> made most of the mess, so that makes it <b>[Arian em]</b> responsibility to clean it up.  You waggle it in front of [Arian eir] snout for emphasis.");
	
	outputText("\n\nArian blinks at your words, but concedes with a smile.  \"<i>Of course.</i>\"  [Arian Ey] opens [Arian eir] mouth and lets [Arian eir] tongue roll out, inviting you to place the dildo into [Arian eir] open mouth.  You promptly slide the fake-cock gently home, letting [Arian em] start at [Arian eir] own pace.");
	
	outputText("\n\nShe cleans it diligently, and from the looks of it, [Arian ey]'s also enjoying [Arian em]self immensely.  Arian's eyes are closed most of the time, but you notice that [Arian ey] opens them to glance at you and smile to [Arian em]self.  Whatever's going through [Arian eir] head must be very pleasant.  It takes only a couple minutes before you pull the dildo out to inspect it.  Lizan spit shines in the light of the ambience, and from what you can see... there's not a single trace of your, or Arian's, juices left on the dildo.  With a smile, you pat your lizan on the head, congratulating [Arian em] on a job well done.");
	
	outputText("\n\n\"<i>Thank you, but I'm not done yet.</i>\"  You look at [Arian em], wondering what [Arian ey] has in mind.  Arian slithers along your body, until [Arian eir] face is hovering your [vagina].  A knowing smirk crosses your lips and you relax, eager to let [Arian em] get to work.  [Arian Ey] gently spreads your legs and begins licking, making sure to drink in all of your juice.");
	
	outputText("\n\nYou gasp and shudder, moaning softly as [Arian ey] pleasures your oversensitive love canal.  It doesn't take long, maybe a minute or two, before you are writhing in a mini-orgasm, your female fluids gushing into your lover's eager mouth, bathing [Arian eir] probing tongue.  [Arian Ey] makes sure to lap it all, not keen on letting even a single drop be wasted.  \"<i>Hmm, delicious,</i>\" Arian says as [Arian ey] licks [Arian eir] lips clean of leftovers.");
	
	outputText("\n\nYou heave a sigh of contentment and authoritatively drag your little lizan slut into your arms, wrapping yourself around [Arian em] in a cuddle and making it quite clear you don't intend to let [Arian em] go anywhere any time soon.  Fortunately, [Arian ey] seems quite eager to be there, and so you shut your eyes and allow yourself to slowly drift off to sleep.  Before you fully embrace unconsciousness, though, you place a gentle hand on Arian's pussy, stroking [Arian em] softly - not to arouse [Arian em] yet again, but just to let [Arian em] feel a loving touch there, in the place that brings you both such pleasures....");

	player.orgasm();
	dynStats("sen", -2);
	doNext(camp.returnToCampUseOneHour);
}
}
}
