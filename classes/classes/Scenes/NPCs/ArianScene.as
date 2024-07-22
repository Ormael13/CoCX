package classes.Scenes.NPCs{
import classes.*;
import classes.BodyParts.Tail;
import classes.GlobalFlags.kACHIEVEMENTS;
import classes.GlobalFlags.kFLAGS;
import classes.Items.Equipable;
import classes.display.SpriteDb;

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
			EventParser.timeAwareClassAdd(this);
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
	if(flags[kFLAGS.ARIAN_COCK_SIZE] < 0 || flags[kFLAGS.ARIAN_COCK_SIZE] > 3) return 0;
	else if(flags[kFLAGS.ARIAN_COCK_SIZE] == 1) return 9;
	else if(flags[kFLAGS.ARIAN_COCK_SIZE] == 2) return 16;
	else return 36;
}

public static const arianCapacity:Number = 50;

override public function arianFollower():Boolean {
	return flags[kFLAGS.ARIAN_FOLLOWER] > 0;
}
public function arianMF(boy:String,girl:String):String {
	if(flags[kFLAGS.ARIAN_COCK_SIZE] > 0) {
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
	if(arg != 0) {
		flags[kFLAGS.ARIAN_HEALTH] += arg;
		if(flags[kFLAGS.ARIAN_HEALTH] > 100) flags[kFLAGS.ARIAN_HEALTH] = 100;
		else if(flags[kFLAGS.ARIAN_HEALTH] < 0) flags[kFLAGS.ARIAN_HEALTH] = 0;
	}
	return flags[kFLAGS.ARIAN_HEALTH];
}
public function arianChestAdjective():String {
	var buffer:String = "";
	var temp:int = rand(10);
	if(flags[kFLAGS.ARIAN_BREASTS] == 0) return "";
	else if(flags[kFLAGS.ARIAN_BREASTS] == 1) {
		if(temp <= 4) buffer += "small";
		else if(temp <= 6) buffer += "petite";
		else if(temp <= 8) buffer += "perky";
		else buffer += "palm-filling";
	}
	else if(flags[kFLAGS.ARIAN_BREASTS] == 2) {
		if(temp <= 3) buffer += "generous";
		else if(temp <= 5) buffer += "hand-filling";
		else if(temp <= 7) buffer += "bouncy";
		else buffer += "shapely";
	}
	else {
		if(temp <= 3) buffer += "large";
		else if(temp <= 5) buffer += "voluptuous";
		else if(temp <= 6) buffer += "jiggly";
		else if(temp <= 7) buffer += "bra-bursting";
		else if(temp <= 8) buffer += "bountiful";
		else buffer += "huge";
	}
	return buffer;
}
public function arianChest():String {
	var buffer:String = "";
	//Men get no cool descriptions!
	if(flags[kFLAGS.ARIAN_BREASTS] == 0) return "chest";

	//Tits ahoy!
	if(rand(2) == 0) buffer += arianChestAdjective() + " ";

	//Name 'dose titays
	var temp:int = rand(10);
	if(temp <= 2) buffer += "tits";
	else if(temp <= 5) buffer += "breasts";
	else if(temp <= 7) buffer += "pillows";
	else buffer += "boobs";
	return buffer;
}


//Initial Meeting
//Happens randomly while visiting Tel'Adre. If player doesn't choose to help, Arian is removed from the game.
//If you don't help, Arian is removed from the game.
public function meetArian():void {
	clearOutput();
	spriteSelect(SpriteDb.s_arian);
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

	outputText("You approach the hooded figure with caution, asking if they're all right; it feels a little silly to say that, but you can't think of much else to say.");

	outputText("\n\n\"<i>Just... help me up,</i>\" a masculine voice asks, between coughs.");

	outputText("\n\nYou lean down and offer the stranger your shoulder, letting them place their arm across your neck before you stand upright, helping pull them to their feet.  Once the hooded figure is standing, the hood slides off [arian eir] head, to reveal a reptilian muzzle that could only belong to some sort of lizard.  His scales are white, almost absurdly so, and he takes deep breaths, trying to calm down his coughing fit.");
	camp.codex.unlockEntry(kFLAGS.CODEX_ENTRY_LIZANS);
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
	spriteSelect(SpriteDb.s_arian);
	outputText(images.showImage("arian-park"));
	outputText("As you enter the ragged remnants of the park, you spot the sickly lizan, Arian, sitting at his usual bench, and greet him.  \"<i>Oh, hello there [name].  Good to see you.</i>\"  He waves lazily.");

	//Visit 1
	if (flags[kFLAGS.ARIAN_PARK] == 1) {
		outputText("\n\nFeeling ");
		if(player.cor < 50) outputText("curious");
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

		outputText("\n\n\"<i>Ah...  Now we're getting to why I'm in such a miserable state.  You see I've found a new way to use white magic; one that results in far more powerful spells;  problem is it is very unhealthy for the caster.</i>\"  [arian Ey] smiles at you weakly.  \"<i>In order to achieve a state of complete concentration, I stop all my bodily functions.  My heart stops beating, I stop breathing, I dedicate all of my being to the spell I wish to cast.  This is very dangerous, but thanks to this I am able to achieve a degree of concentration that no other mage can.</i>\"  He gauges your reaction.  \"<i>So what would you say?  Impressive?  Reckless?  Stupid?</i>\"");
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
		if(player.cor > 66) outputText(", whilst privately thinking to yourself how useless that looks - no wonder they can't fight the demons if this is the best they're capable of");
		outputText(".");

		outputText("\n\n\"<i>Now let me show you what I can do with my technique.</i>\"  He closes his eyes once more and focuses.  His white scales begin glowing as his power increases and you gasp as energy virtually explodes from hand to hand, a cascade of lightning coruscating between his hands with enough fury to consume anything that falls between them.  He stops when he racks and begins coughing.  Now, that is more impressive, you have to admit to yourself.");

		outputText("\n\n\"<i>I guess I might have overdone it.</i>\"  He smiles at you goofily, then coughs in what is obviously meant to cover his embarrassment.  \"<i>Thanks for keeping me company, I enjoy our chats a lot, [name].  You've been a great friend for me.</i>\"  You accept the compliment and tell him that it was nothing");
		if(player.cor >= 66) outputText(", keeping your real reasons for bothering with him to yourself");
		outputText(".");

		outputText("\n\n\"<i>Could I bother you one more time though?</i>\" Arian asks shyly.  \"<i>Would you mind helping me home?  My aides are probably pestering the guard to come and find me right about now, and I feel like I got my share of fresh air for the moment.</i>\"");

		outputText("\n\nYou decide that it wouldn't be too much trouble, and tell Arian that you'll give him a hand to get home.");

		outputText("\n\nArian leads you to the doorsteps of his house, and unhooking his arm from around your shoulder he takes your hands in [arian eir] own and smiles at you.  \"<i>Thank you for the help, and for listening to my story.</i>\"  Then looking into you eyes expectantly, he asks, \"<i>Listen [name].  I would love it if you could visit me once in a while.  It can be very lonely here and although my aides are always by my side there are things I simply can't talk about with them.  So... could you find time to visit a sickly mage?</i>\"");

		outputText("\n\nYou assure him you'll think about it; it's time he went inside and had some rest.  \"<i>Thank you, I'll be seeing you then.</i>\"  He releases your hand and slowly walks inside, barely getting the door open before two pairs of arms grab him and drag him in, closing the door behind him.  You shrug it off and head back towards camp; that diversion was nice, but you have other things to do.");
		//Player returns to (Tel'Adre / camp).
		//Arian's House replaces Park in Tel'Adre menu.
		outputText("\n\n(<b>The park has been removed from Tel'Adre's menu.  Arian's house has been added to the 'Homes' submenu.</b>");
		arianHealth(5);
	}
	arianHealth(1);
	flags[kFLAGS.ARIAN_PARK]++;
	doNext(camp.returnToCampUseOneHour);
}

//First Visit
public function visitAriansHouse(back:Boolean = false):void {
	clearOutput();
	spriteSelect(SpriteDb.s_arian);
	if (flags[kFLAGS.ARIAN_HEALTH] < 29 || flags[kFLAGS.ARIAN_VIRGIN] == 1 && !back) arianHealth(1);
	if (arianFollower()) {
		if (arianMF("m", "f") == "f")
			outputText(images.showImage("arianfemale-tent"));
		else
			outputText(images.showImage("arianmale-tent"));
		outputText("You approach the enchanted tent and slip easily inside the doors to the luxurious interior.  ");
		if ((flags[kFLAGS.ZENJI_PROGRESS] == 8 || flags[kFLAGS.ZENJI_PROGRESS] == 9) && rand(100) < 10 && !player.hasStatusEffect(StatusEffects.ZenjiArian)) {
			outputText("As you approach Arian’s tent and enter you overhear the sounds of a bed squeaking coming from [arian eir] room. You pause for a moment, is Arian jerking off?\n\n");
			outputText("No, it’s way too noisy and a little too violent for the small lizan. As you get closer to eavesdrop you can hear faint growling… it sounds like Zenji. You never would’ve expected this from Zenji, but apparently he’s managed to subdue Arian. Given the sounds of the moaning, Arian is enjoying [arian emself] perhaps a little too much.\n\n");
			outputText("\"<i>Ah… Z-Zenji…</i>\" Arian mutters through pleasured groans.\n\n");
			outputText("Zenji seemingly only gives a low growl in response.\n\n");
			outputText("You sigh and wait on Arian’s couch, they’ll finish eventually and Arian will really hear it from you.\n\n");
			outputText("After a few minutes and several loud moans from the two of them, their pace begins to slow down.\n\n");
			outputText("Arian emerges from the room after several more minutes pass, flustered with Zenji standing coyly behind him.\n\n");
			outputText("Arian notices you and blushes, [arian eir] entire body practically turns red as Zenji casually leaves the tent after giving Arian a kiss on the cheek.\n\n");
			outputText("You sigh and ask Arian if it was worth it.\n\n");
			outputText("\"<i>Do you really want me to answer that?</i>\" Arian replies sheepishly.\n\n");
			outputText("You shake your head. What a horny archmage [arian ey]’s become, and [arian ey] deserves some punishment.\n\n");
			outputText("Arian looks at you with hints of fear in [arian eir] eyes. You pull [arian em] down onto your lap, lifting up [arian eir] robes, revealing [arian eir] petite behind. You raise [arian eir] tail up with your free hand, holding it up and leaving [arian em] unable to defend himself before giving it a firm and swift spank.\n\n");
			outputText("Arian squeals as you do so. You’re not surprised that [arian ey]’s enjoying it, but you’re having fun at [arian eir] expense anyway.\n\n");
			outputText("After several more spanks [arian eir] behind is left red from the heat as [arian ey] kneels on the couch, [arian eir] ass was pounded too hard from both you and Zenji for [arian em] to be able to sit properly for quite some time now.\n\n");
			outputText("You ask if [arian ey]’s learned [arian eir] lesson yet. Arian seems even more flustered before giving you a sheepish nod.\n\n");
			outputText("You decide to leave him for now, he’ll need some time to recover from the entire ordeal.\n\n");
			player.createStatusEffect(StatusEffects.ZenjiArian, 4, 0, 0, 0);
			doNext(camp.campLoversMenu);
			return;
		}
		else {
			var temp:int = rand(10);
			if(temp == 0) {
				outputText("However, Arian isn't here right now, so you instead make yourself comfortable on the couch.  After a few minutes, Arian [arian emself] walks in through the entrance.  \"<i>Oh, [name].  I wasn't aware you were here... have you been waiting for long?</i>\" [arian ey] asks.  You tell [arian em] not very long.  \"<i>That's good to hear.  So, what can I do for you?</i>\" [arian ey] asks, with a smile.");
			}
			else if(temp == 1) {
				outputText("Inside, the lizan is sitting at a table, fastidiously drinking from a cup of something hot while pouring over an arcane-looking text.  You politely cough to draw [arian eir] attention and [arian ey] looks at you, smiling.  \"<i>Hello, [name].  I was just catching up on my studies.  Can I offer you a cup of tea, or maybe something else?</i>\" [arian ey] asks.");
			}
			else if(temp <= 2) {
				outputText("The lizan is currently busy tinkering with some occult-looking paraphernalia when you find [arian em].  You politely cough to attract [arian eir] attention, then do so again when [arian ey] fails to heed that.  It's only on the third attempt that [arian ey] looks up apologetically from [arian eir] work.  \"<i>Ah, [name]; I'm sorry, but I was preoccupied with something.</i>\" [arian ey] states in an apologetic tone, indicating the mess on [arian eir] desk.  \"<i>Was there something you wanted?</i>\" [arian ey] asks.");
			}
			else if(temp <= 4) {
				outputText("The smell of fresh cooking fills the air and you can see Arian happily sitting down at his couch with a plate of something just cooked.  \"<i>Oh, [name]; I was just about to eat, can I offer you a dish?  Or if you'd rather do something else, this can wait,</i>\" the lizan tells you with a smile.");
			}
			else if(temp <= 6) {
				outputText("You don't have to look far to find Arian; [arian ey]'s currently curled up and asleep on the couch.  As you contemplate whether or not to wake [arian em], [arian ey] suddenly stirs and uncoils himself, stretching and yawning hugely in a way that lets you see every last needle-like tooth in [arian eir] mouth.  [arian Ey] then sees you and gives you a smile. \"<i>Ah, [name]; I was just having a little nap.  Something on your mind?</i>\"");
			}
			else if(temp <= 8) {
				outputText("A strange smell hits your nose as you enter the tent; it takes you a few moments, but then you place it, your ears pricking as you hear Arian letting out some very familiar groans of release.  With a smirk, you sneak up and lean over the couch, looking right into the eyes of Arian, [arian eir] fingers still glistening with ");
				if(flags[kFLAGS.ARIAN_COCK_SIZE] > 0) {
					if(flags[kFLAGS.ARIAN_VAGINA] > 0) outputText("mixed sexual fluids");
					else outputText("jizz");
				}
				else outputText("femjizz");
				outputText(" and, indeed, still hovering over [arian eir] ");
				if(flags[kFLAGS.ARIAN_COCK_SIZE] > 0) {
					if(flags[kFLAGS.ARIAN_VAGINA] > 0) outputText("twin sexual slits");
					else {
						outputText("cock");
						if(flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText("s");
					}
				}
				else outputText("pussy");
				outputText(".  For a long moment, [arian ey] just stares back at you; if lizans could blush, you're certain [arian ey]'d be red as a beet.  \"<i>[name]! I was- I was just....  Oh, this is embarrassing,</i>\" [arian ey] mutters, looking at [arian eir] feet.");

				outputText("\n\nYou flash the flustered lizan a knowing smile, telling [arian em] not to worry; there is nothing you haven't seen before under [arian eir] robes.  Arian shivers in a way that just speaks volumes about [arian eir] embarrassment.  You ask if, perhaps, [arian ey] would like you to step outside while [arian ey] makes [arian emself] decent?  Not that you mind the sight....");
				outputText("\n\n\"<i>P-please.</i>\" Arian stammers, still unable to meet your gaze.  You gently tap [arian em] on the nose and move outside.  A short while later you hear [arian em] yell, \"<i>C-come in!</i>\"");
				outputText("\n\nYou can't wipe the smirk off your face, as you return and see that Arian is, indeed, decent and there doesn't seem to be any trace of the mess [arian ey]'d made earlier.  You walk up to the still flustered lizan and tell [arian em] that if [arian ey]'s feeling edgy, you'd be happy to help [arian em] deal with it.");
				outputText("\n\n\"<i>Th-that's all right....  So, um, you wanted something, [name]?</i>\" [arian Ey] asks, desperately trying to change the topic.");
			}
		}
		arianHomeMenu();
	}
	else {
		if (arianMF("m", "f") == "f")
			outputText(images.showImage("arianfemale-tent"));
		else
			outputText(images.showImage("arianmale-tent"));
		if(flags[kFLAGS.ARIAN_PARK] == 4) {
			flags[kFLAGS.ARIAN_PARK]++;
			outputText("Deciding to visit the sickly, Lizan mage, Arian, you promptly start walking.  The house is fairly large, at least two stories tall, but it looks pretty ordinary; there's nothing about it to make it really stand out from the other buildings in the neighborhood.  It's only the small brass plate on the door that says \"<i>Arian, Magus</i>\" that provides any clue that a wizard lives here.  There is a knocker on the front door, solid brass, carved in the shape of a leering grotesque, and you take hold of the handle and loudly bang it against the door to announce your presence.");

			outputText("\n\n\"<i>One minute!</i>\"  You hear a feminine voice yell from inside.  After hearing the clicking of a latch the door slowly opens to reveal what looks like a tan-furred female ferret looking at you with bespectacled brown eyes; she is not very tall, and her body is clad in loose comfortable robes that hide her curves well.  She adjusts her glasses and asks, \"<i>How may I help you, " + player.mf("sir","ma'am") + "?</i>\"");

			outputText("\n\nYou explain you're an acquaintance of Arian the wizard, and you came to see him.  With a smile the ferret steps aside.  \"<i>Please come in.</i>\"  You promptly step inside, getting your first look at Arian's home.  The exterior and the interior match quite well; it looks very normal in here.  Aside from a few nice vases and potted flowers, nothing else stands out.");

			outputText("\n\nThe ferret girl slowly closes the door behind you, closing the latch before she dusts her robes and turns to you.  \"<i>I'm afraid we haven't been properly introduced just yet, " + player.mf("sir","ma'am") + ".  My name is Laika and I'm one of master Arian's aides.</i>\"  She curtsies with a smile and adds, \"<i>Pleased to meet you... umm....</i>\"  You smile and tell her your name.  She closes her eyes and nods.  \"<i>Ah, yes, [name]....</i>\"  Suddenly she opens her eyes wide open.  \"<i>Wait a moment... [name]!?</i>\"  She advances on you, threatening you with a wooden spoon.  \"<i>You! You're the one who helped master Arian get away!</i>\"  She yells with a frown, poking your [chest] with her spoon.");

			outputText("\n\nYou ask if that's really such a big deal; all he wanted was to go and sit in a park.  Laika points an accusing finger at you and is about to say something when a masculine voice interrupts her.  \"<i>Sis! What's the problem?</i>\" Slowly, another tan-furred ferret emerges from the hallway nearby, clad in robes much like his sister's.  If Laika were to remove her spectacles, they would look like identical twins.");

			outputText("\n\n\"<i>Boon, this is the....</i>\"  Boon raises his hands, stopping Laika mid-sentence.  \"<i>Yes, sister.  Half the neighborhood knows by now.</i>\"  He walks up to his sister and slowly pushes her back towards the kitchen.  \"<i>Let me handle this, sis.  Just finish doing the dishes and cool your head down, I've already finished with my chores, so I can attend to our visitor.</i>\"");

			outputText("\n\nLaika glares at both you and her brother, but complies.  Sighing, Boon turns to you.  \"<i>Hello, [name].  I'm Boon, Laika's brother and master Arian's apprentice.  You'll have to forgive my sister, she's rather... passionate... when it comes to our master, but she does have a point.  What if master Arian had collapsed?  Or needed his medicine?</i>\"");

			outputText("\n\nBefore you can protest he stops you.  \"<i>You know what, it doesn't matter.  He would've found a way to run off whether you were there or not.  So, thanks for keeping him company.</i>\"  You accept the thanks with your usual grace, then ");
			if(player.cor < 33) outputText("curiously");
			else if(player.cor < 66) outputText("casually");
			else outputText("indifferently");
			outputText(" ask why he's thanking you.");

			outputText("\n\nBoon smiles and motions for you to follow, leading you upstairs.  \"<i>You see... master Arian didn't always enjoy taking long walks... I don't really know what has made  him suddenly take a liking for long walks around the city, but his condition does not allow him to do so, and he's just too stubborn to admit it.  So we kinda have to reel him in, or he will end up passing out in one of the rough parts of the city.</i>\"  Boon explains, turning on a hallway.  \"<i>Still, master looked really happy when he came back.  I'm glad he wound up meeting someone nice like you, instead of a mugger or a thief.</i>\"  Boon smiles at you.");

			outputText("\n\nHe stops at a wooden door and turns the knob.  \"<i>Of course!</i>\"  Once he does open the door, you're treated to a surprising sight.  Boon slaps his forehead with an open palm and groans.  Arian is standing on his bed, halfway out of the window, a surprised look plastered on his white face.");

			outputText("\n\n\"<i>Master Arian... I'm going to close this door and pretend I didn't just catch you trying to run away again.  I hope that when I open this door again I'll see you back in bed, or I'll sic Laika on you.</i>\"  At the mention of Laika, Arian shudders.  You just stand behind Boon, looking at the scene play out. Boon closes the door and waits a few moments before opening the door once again and motioning you in.  \"<i>Master Arian, you have a visitor.</i>\"");

			outputText("\n\nYou head inside at the ferret's gesture, wondering if Arian has stayed or not.  To your pleasant surprise, he is seated inside his bed, tucked somewhat sulkily under the covers.  You tell him that you wanted to come and visit, apologizing if you're interrupting something important.");

			outputText("\n\nArian smiles at you.  \"<i>Not at all.  Boon, you may leave us for now.</i>\"  Boon bows and leaves, closing the door behind him.  Arian sighs, removing his covers to sit up properly on the bed and motioning towards a nearby chair.  \"<i>Just make yourself at home; I'm really glad you came to see me.  I was wondering if I'd ever get to see you again.</i>\"");

			outputText("\n\nYou tell him that you couldn't resist coming to see him, even as you ");
			if(!player.isTaur()) outputText("pull up a chair");
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
			if(flags[kFLAGS.ARIAN_VAGINA] > 0 && flags[kFLAGS.ARIAN_HERM_CHAT] == 1) {
				outputText("Figuring that Arian would enjoy your company, you make your way with confidence through the streets leading to the lizan's home.  Soon enough, you find yourself standing before the stately home in which [arian ey] and [arian eir] ferret associates dwell. You pound heartily on the knocker to announce your presence.");
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
				outputText("\n\n\"<i>Sorry to leave you unattended, [name], but we're kinda busy; do you think you can make the way to " + arianMF("master","mistress") + " Arian's room by yourself?</i>\"  Laika asks.");
				outputText("\n\nYou assure the ferrets that it's fine, and you understand how busy they are.  Remembering where Arian's room is from the last time you visited, you proceed to make your way to it, finding the door to be closed, as usual.  You slowly rap your knuckles on the closed door, trying to announce your presence without being a nuisance at the same time.");
			}
			//(if ArianGirlHermChat == 1)
			if(flags[kFLAGS.ARIAN_HERM_CHAT] == 1) {
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
			else if(flags[kFLAGS.ARIAN_HEALTH] < 10) {
				outputText("\n\nYou hear a faint cough through the door.  \"<i>Come in.</i>\"  You hear a tired voice say.  Gently clasping the doorknob, you slowly open the door, careful of startling the sickly lizan.");
				outputText("\n\nArian smiles at you as you enter.  \"<i>Oh, hello [name].  I'm glad you came.</i>\"  He slowly sits up and motions to a chair nearby.  \"<i>Make yourself at home.</i>\"");
				outputText("\n\nYou pull the offered chair and sit next to his bed, smiling at [arian em].");
				outputText("\n\n\"<i>So, is there anything you'd like to do?  Maybe talk?</i>\"  Arian asks.  You reply that talking is fine.");
			}
			//10-19 health:
			else if(flags[kFLAGS.ARIAN_HEALTH] < 20) {
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
					outputText("\n\n\"<i>Come in!</i>\"  You hear Arian say, detecting a slight pep to [arian eir] voice.  You step inside and smile at Arian as you close the door behind you.  [arian Ey] smiles back at you and motions towards a nearby chair.");
					if(!player.isTaur()) outputText("\n\nYou pull the chair and sit next to [arian eir] bed.");
					else outputText("\n\nYou simply sit beside [arian eir] bed.");
					outputText("\n\nArian smiles at you and asks, \"<i>So... what do you want to do today?</i>\"");
				}

			}
			//30-49 health:
			else if(flags[kFLAGS.ARIAN_HEALTH] < 50) {
				outputText("\n\nYou hear the sound of drawers being pulled open and forcefully closed.  \"<i>C-come in!</i>\"  You hear Arian announce.  Curious as to what [arian ey]'s up to, you open the door  and step inside to see Arian sitting on [arian eir] work desk.  [arian Ey] slowly turns on [arian eir] swivel chair to gaze at you with a smile.  \"<i>Hello, [name]!</i>\"  [arian Ey] motions to a nearby chair.  \"<i>I was just working on a little project, nothing important.  So, make yourself at home!</i>\"  [arian Ey] smiles happily at you.");
				outputText("\n\nYou enter the room, wondering what [arian ey] might have been working on, but decide it's probably nothing.  You note [arian ey]'s made quite an improvement in health since you first met [arian em].");
				outputText("\n\nYou pull the chair and sit next to [arian em], asking why [arian ey]'s thanking you;  [arian Ey] did all the hard work and made  [arian emself] get better, you merely provided the incentive to try, you tell  [arian em].  \"<i>You've given me much more than that, and for that I thank you.</i>\"");
				outputText("\n\nYou stop and consider a moment, wondering what you should do now that you're here with the lizan.");
			}
			//50-74 health
			else if(flags[kFLAGS.ARIAN_HEALTH] < 75) {
				outputText("\n\n\"<i>[name], is that you?  Come in!</i>\"  You hear Arian happily say.  You open the door and step in to find Arian sitting by [arian eir] table, a book is laying on the table and a mug of tea in [arian eir] hand.  [arian Ey] motions to a chair nearby as [arian ey] sips [arian eir] tea.  \"<i>Pull up a chair. May I offer you some tea?</i>\"");
				outputText("\n\nYou politely decline the tea and ");
				if(!player.isTaur()) outputText("take the offered chair");
				else outputText("the offered chair");
				outputText(".");
				outputText("\n\nArian sets [arian eir] mug down and smiles at you.  \"<i>So, to what do I owe the pleasure of your visit?</i>\"");
			}
			//75-100 health:
			else {
				outputText("\n\nArian opens the door, smiling brightly at you.  \"<i>Hello [name]!  Come in!</i>\"  [arian Ey] says, stepping back and holding the door for you.  You step in and Arian closes the door behind you and embraces you in a friendly hug.  You return [arian eir] hug with one of your own.");
				outputText("\n\nBreaking the hug Arian leads you to [arian eir] table");
				if(!player.isTaur()) outputText(" and offers you the chair nearby");
				outputText(",  taking a" + player.isTaur ? "nother" : "" + " chair for [arian em]self.  \"<i>I love when you come visit, [name].  So, what are we going to do today?</i>\" [arian ey] asks, expectantly.");
			}
			//(Display Options)
			arianHomeMenu();
		}
	}
}

private function arianHomeMenu(back:Boolean = false):void {
	sceneHunter.print("Arian's health: " + arianHealth() + " out of 100.");
	menu();
	if (!back && flags[kFLAGS.ARIAN_S_DIALOGUE] == 0) addButton(0, "Next", arianStoryDialogue1);
	else if (!back && flags[kFLAGS.ARIAN_S_DIALOGUE] == 1 && arianHealth() >= 20) addButton(0, "Next", arianStoryDialogue2);
	else if (!back && flags[kFLAGS.ARIAN_S_DIALOGUE] == 2 && arianHealth() >= 30) addButton(0, "Next", arianDialogue3);
	else if (!back && flags[kFLAGS.ARIAN_S_DIALOGUE] == 3 && arianHealth() >= 50) addButton(0, "Next", arianImbue);
	else if (!back && flags[kFLAGS.ARIAN_S_DIALOGUE] == 4 && arianHealth() >= 75) addButton(0, "Next", arianPlot4);
	else if (!back && flags[kFLAGS.ARIAN_S_DIALOGUE] == 5 && arianHealth() >= 100) addButton(0,"Next",arianPlot5);
	//If no story dialogue
	else {
		addButton(0,"Talk",talkToArianChoices);
		if(flags[kFLAGS.ARIAN_S_DIALOGUE] >= 2) addButton(1,"Sex",arianSexMenu).disableIf(player.lust < 33, "Not aroused enough!");
		if(flags[kFLAGS.ARIAN_S_DIALOGUE] >= 1) addButton(3,"Give Item",giveArianAnItem);
		if(player.hasKeyItem("Arian's Talisman") >= 0 || player.hasKeyItem("Arian's Charged Talisman") >= 0)
			addButton(2,"Talisman",imbueTalisman);
		if(flags[kFLAGS.ARIAN_S_DIALOGUE] >= 5) addButton(4,"Treat Corr.",treatCorruption);
		if(arianFollower()) addButton(5,"Appearance",arianAppearance);
		addButton(6, "Cursed Item", removeCursedItem)
				.hint("Ask Arian to remove your cursed item. Costs 500 gems. ")
				.disableIf(arianHealth() < 75, "Arian is too weak")
				.disableIf(player.gems < 500, "Ask Arian to remove your cursed item. Costs 500 gems (Can't afford).")
				.disableIf(player.equippedKnownCursedItems().length == 0, "Arian can remove cursed items, but you're not wearing any.")
				.disableIf(flags[kFLAGS.ARIAN_S_DIALOGUE] < 3, "???", "???");
		if(player.weaponRange == weaponsrange.SAGITTB) addButton(7, "Cursed Bow", removeCursedItem2)
				.hint("Ask Arian to remove your cursed bow. Costs 500 gems. ")
				.disableIf(arianHealth() < 75, "Arian is too weak")
				.disableIf(player.gems < 500, "Ask Arian to remove your cursed bow. Costs 500 gems (Can't afford).")
				.disableIf(flags[kFLAGS.ARIAN_S_DIALOGUE] < 3, "???", "???");
		if(model.time.hours >= 17 && arianFollower()) addButton(8,"Sleep With",sleepWithArian,true);
		if(flags[kFLAGS.SLEEP_WITH] == "Arian") addButton(8,"NoSleepWith",dontSleepWithArian);
		if(!arianFollower()) addButton(14,"Back",telAdre.telAdreMenu);
		else addButton(14,"Back",camp.campLoversMenu);
	}
}

private function removeCursedItem2():void {
	clearOutput();
	outputText("As Arian proceed with the purification ritual you struggle in pain at first as you feel the cursed weapon in your hand resist the unbinding before release washes over you as your grip opens dropping the malevolent item on the ground. ");
	outputText("Arian wrap the item in blessed cloth in order to seal its malice before handing you the neutralized cursed item back. Sure you can equip it again anytime but now you know the risks.\n\n");
	player.gems -= 500;
	player.removeStatusEffect(StatusEffects.TookSagittariusBanefulGreatBow);
	player.createStatusEffect(StatusEffects.TookSagittariusBanefulGreatBow,1,0,0,0);
	if (player.statStore.hasBuff('Sagittarius Curse')) player.buff("Sagittarius Curse").remove();
	if (player.statStore.hasBuff('Sagittarius Focus')) player.buff("Sagittarius Focus").remove();
	player.unequipWeaponRange(false,true);
	inventory.takeItem(weaponsrange.SAGITTB, arianHomeMenu);
}
private function removeCursedItem():void {
	clearOutput();
	var item:ItemType = player.equippedKnownCursedItems()[0];
	if (item == null) {
		outputText("<b>ERROR</b> empty equippedKnownCursedItems")
		doNext(arianHomeMenu)
		return;
	}
	var slot:int = player.slotOfEquippedItem(item as Equipable);
	if (slot == -1) {
		outputText("<b>ERROR</b> slot -1")
		doNext(arianHomeMenu)
		return;
	}
	outputText("You ask Arian to help with "+item.longName+" you're unable to remove. Arian focuses his powers and with several consecutive incantation and great difficulty manages to release the curse bindings.\n\n<i>\"That should work. I could only remove the curse from you though. Try not to equip this item again.\"</i>\n\n");
	// arianHealth(-10);
	player.gems -= 500;
	inventory.unequipSlotToInventory(arianHomeMenu, slot, false, true);
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
	if(player.lizardCocks() > 0) outputText(" just like yours");
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
	outputText("\n\nSlowly you approach the hiding lizard, and sit on his bed.  You let him know you're flattered to be his object of desire, and that there's no need to hide himself.  If he felt this way about you, he should just have said so.");
	outputText("\n\nArian peeks from under his covers.  \"<i>Y - You mean you're not mad at me?</i>\"  You smile and tell him you aren't.  Arian visibly relaxes, letting his covers fall on his chest.");
	//(if PC is male)
	if(player.hasCock() && !player.hasVagina()) {
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
		outputText("\n\nOnce you toss your [armor] on the floor, however, Arian's eyes widen as he realizes you're not entirely female; he eyes your [cocks] and the moistening pussy between your legs with equal parts wonder and arousal.");
		outputText("\n\n\"<i>I... you... I never... wow....</i>\"  You call Arian's name, breaking his trance.  \"<i>S-Sorry for staring,</i>\" he quickly apologizes, but you just chuckle at his reaction and tell him he doesn't have to worry about this.");
		outputText("\n\n\"<i>I never imagined you would have both... err... genders,</i>\" [arian ey] says nervously.  You just smile at him and ask if he has a problem with that.");
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
	if(player.hasCock() && player.cockThatFits(arianCapacity) >= 0) addButton(0,"Penetrate",giveArianAnal);
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
	outputText("\n\nIt barely takes a second for the effects to start.  As soon as he puts the bottle back inside the drawer, he collapses on the nearby chair.  At first, you consider calling for help, but any thought of doing so leaves your mind when you see Arian's shaft visibly shrinking, soon entering the recesses of his genital slit.  As soon as his shaft disappears inside, his genital slit closes up, the skin connecting and leaving only smooth scales in his groin; lower, between his - or should it be her now? - legs, another slit opens up, soon spreading open as a small erect clit emerges from the wet folds.  Moisture leaks, wetting the wooden chair; the smell of aroused female fills the small bedroom and you feel your blood surging to your [cocks].");
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
	if (player.cockThatFits(arianCapacity) == -1)
		addButton(0, "Next", getBlownByArian);
	else
		addButton(0, "Next", giveArianAnal);

}
//[=Like Girls=]
private function youLikeGirlsNotSickLizardDudes():void {
	clearOutput();
	outputText("You tell him that you prefer females.... Arian looks at you expectantly.  \"<i>So... if I was a girl... then you wouldn't mind?</i>\"");
	outputText("\n\nYou scratch your chin in thought; and let him know that if he was a girl, then you wouldn't mind at all.  \"<i>Okay then... I... I'll do it!</i>\"");
	outputText("\n\nYou raise your eyebrows. What is he planning on doing?");
	outputText("\n\nArian gets up and strips off his robes, exposing himself completely, then slowly walks toward his work desk and opens a drawer.  Reaching inside, he pulls out a mysterious bottle labelled with a pink egg.  He turns to look at you and uncorks the bottle, then downs the whole bottle.");
	outputText("\n\nIt barely takes a second for the effects to start.  As soon as he puts the bottle back inside the drawer, he collapses on the nearby chair.  At first, you consider calling for help, but any thought of doing so leaves your mind when you see Arian's shaft visibly shrinking, soon entering the recesses of his genital slit.  As soon as his shaft disappears inside, his genital slit closes up, the skin connecting and leaving only smooth scales in his groin; lower, between his - or should it be her now? - legs, another slit opens up, soon spreading open as a small erect clit emerges from the wet folds.  Moisture leaks, wetting the wooden chair; the smell of aroused female fills the small bedroom, and you feel your blood surging to your [cocks].");
	outputText("\n\nThe transformation is not over yet though; a throaty feminine moan precedes the appearance of a pair of small perky breasts, complete with sensitive little nipples.  You watch in a daze as the transformation finishes, Arian's face growing softer, rounder, girly; the same happens to her body, her hips grow larger, the same does her butt, becoming fuller and attractive, giving her a beautiful, if slender, figure.");
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
	outputText("You feel like you'd like to know a bit more about Arian, so you ask if [arian ey] would mind sharing some of [arian eir] history with you.  After all, as a survivor from at least the early days of the demon war, and a wizard to boot, [arian ey]'s got to have some stories up [arian eir] voluminous sleeves.");
	outputText("\n\nArian nods.  \"<i>I guess it isn't fair that I'm the only one that gets to hear your stories... but before we start....  How long ago do you think this whole demon trouble started?</i>\"");
	outputText("\n\nYou shrug your shoulders; ");
	//PC has met Marae:
	if(flags[kFLAGS.MET_MARAE] >= 1) outputText("Marae herself told you they showed up about, what, 20-30 years ago?");
	else outputText("you'd guess a long while ago given the general mess they seem to have made of the world.");

	outputText("\n\nArian nods.  \"<i>Good guess....  And how old do I look?</i>\"");

	outputText("\n\nYou look the reptilian wizard up and down, contemplating. Then you profess you aren't really familiar with people covered in scales, but you'd guess somewhere in [arian eir] mid-20s?");
	outputText("\n\nArian nods and smiles.  \"<i>I'm actually 23 years old....  So I can't tell you much about how this whole trouble started, I was only a child back then... and my parents made sure to keep me sheltered from all that as well....</i>\"  Arian stares in the distance.  \"<i>Sheltered, I guess that word defines me pretty well.  I've been sheltered from the world for the most of my life.</i>\"");
	outputText("\n\nYou ask why; what has made [arian eir] parents shelter him from the world outside?");

	outputText("\n\nArian looks back at you.  \"<i>Well, the world was a mess, so they thought it would be best if I just stayed in the academy; they told me stories of young lizans walking outside who were dragged away by demons to take part in terrible rituals.  They weren't entirely wrong I guess, but that was a really cruel thing to say to a child.  Although, they were just looking after me, in the end, and as curious as I am....  Well, let's not dwell on that.</i>\"  Arian clears [arian eir] throat.  \"<i>So, I've been at the academy for as long as I can remember.  I told you about how I used to live buried in books right?</i>\"");

	outputText("\n\nYou nod your head and admit that [arian ey] did indeed tell you that.");
	outputText("\n\n\"<i>Well, what I didn't tell you is that books used to be the only thing I cared about as well.</i>\"");
	outputText("\n\nYou comment that it does seem kind of odd that a self-professed bookworm would be so desperate to get out and stretch [arian eir] legs, now that [arian ey] mentions it.  Arian laughs at that.  \"<i>Yes, quite a change wouldn't you say?</i>\"  Then, with a sigh, [arian ey] says, \"<i>It's ironic actually.  Since I couldn't go outside, all I had were the books; and the books had become my world: I read them, loved them, lived in them, and mastered them. With the time I spent reading, it was quite an easy path towards wizardhood.  As soon as I was of age, I joined the academy formally, and during my testing I was shown to have skills greater than or on par with my testers. In the end, they didn't see a need to instruct me, so they declared me a master of the art and assigned to me my pupils: Laika and Boon.</i>\"");
	outputText("\n\nDid [arian ey] enjoy having students of [arian eir] own to teach?");
	outputText("\n\nArian's eyes light up in recollection.  \"<i>Enjoy it?  I loved it!  These two... they became much more than mere pupils; they were my friends.  I can even say they're part of my family.  Having grown up alone, ignored by my elders, who were too busy with their next research project to pay any attention to me, and with nothing but books to keep me entertained.  Can you imagine how many friends I had?</i>\"");
	outputText("\n\nYou must confess that the situation [arian ey]'s describing sounds quite lonely.");

	outputText("\n\n\"<i>So you can imagine how thrilled I was to get not one, but two people who would have to pay attention to every single instruction I gave them.</i>\"  Arian looks down, a slight tinge of regret on [arian eir] face.  \"<i>I was pretty mean at first.  I wound up taking my frustrations out on them, but thankfully they found it in their hearts to forgive me.  We've been very close ever since.</i>\"  Arian smiles.");
	outputText("\n\nYou tell [arian eir] that it's good to hear they got to know each other properly; is that why Arian gave particular attention to ensuring they escaped when [arian eir] academy was attacked?");
	outputText("\n\nArian shakes [arian eir] head.  \"<i>Not exactly.  It was my intention to defeat all of the invading demons; I was arrogant and it has costed me greatly.  I only managed to save Boon and Laika because they were the closest to me when the wave of dark magic hit us.  I used much of my power and concentration to resist the wave's effects... it was brutal.</i>\"");

	outputText("\n\nDoes that have something to do why [arian ey]'s so frail now - the stress of shielding [arian em]self and [arian eir] apprentices from the demons' black magic?");

	outputText("\n\n\"<i>Yes, actually. I'm not going to get into any specifics right now, but my method of casting spells causes damage to the caster's body, which is why I'm in such a miserable state.</i>\"  Arian sighs.  \"<i>Now I can't even go for a walk....</i>\"");
	outputText("\n\nYou reach out a hand and pat [arian em] on the shoulder; you don't really think it'll make [arian em] feel any better, but it's what they always used to do when people got like this back in your village.  As you pat [arian eir] shoulder, you realize [arian ey] still hasn't told you what has made  [arian em] change [arian eir] attitude so much.  Even as you continue giving [arian em] comforting touches, you ask why it bothers [arian em] being bedridden now if [arian ey] was an antisocial stay-at-home bookworm before.");
	outputText("\n\n\"<i>Oh, yes.  I got sidetracked, sorry.</i>\" Arian grins at you and says, \"<i>I escaped the academy.</i>\"  You scratch the back of your neck; this isn't much of an explanation.  Noticing the confusion in your face, Arian explains, \"<i>The academy didn't have any windows.  Something about preserving our privacy and ensuring no external elements would interrupt our studies.  It doesn't matter now.  So, before escaping the academy with Boon and Laika in tow, I hadn't even gazed at the sky.</i>\"");

	outputText("\n\nYou blink in surprise; [arian ey]'d never even seen the sky?  How could they keep anyone so constrained?  What - did [arian ey] hatch indoors and was never allowed outside?");
	outputText("\n\nArian sighs.  \"<i>Well, I did tell you my parents kept me inside the academy at all times.</i>\"  [arian Ey] sighs once again.  \"<i>I never knew the world was so big, or so beautiful.  I'd been missing out.  I want to go out and see more.  All the good and the bad.</i>\"  Arian looks down.  \"<i>But the truth is I can't, not like this.</i>\"  [arian Ey] sighs in exasperation.");

	outputText("\n\nYou try to cheer the depressed lizan up, exhorting that [arian ey] needs to be optimistic about things; after all, amongst all the crazy potions and tonics, surely there's something that can make a drinker healthier and stronger?");
	outputText("\n\nArian sighs.  \"<i>I have tried so many already.  Boon and Laika have been all over Tel'Adre trying to find something to help me get better, but nothing seems to work....</i>\"");
	outputText("\n\nYou press the subject and ask [arian em] if [arian ey] really doesn't know or hasn't heard about anything that could help at all.");

	outputText("\n\nArian furrows [arian eir] brows in deep thought.  \"<i>I think... I heard there might be something after all.  Something... vitality... I don't recall its name right now.  It's some kind of tonic or tea that is supposed to help you get tougher and stronger.</i>\"");
	outputText("\n\nAll right, it's settled then.  You tell Arian you're going to help [arian em] out, but [arian ey] must promise to behave and stay in bed; if [arian ey] keeps going out like when you first met [arian em] [arian ey]'s never going to get better.");
	outputText("\n\nArian sighs.  \"<i>I know I shouldn't go out, but sometimes I feel like I'm going insane if I stay cooped up in here.  I've spent so much time inside at the academy, and besides that, you have no obligation to help me at all.  I couldn't trouble you by sending you to look after some kind of medicine I don't even know where to find.</i>\"");
	outputText("\n\nYou tell [arian em] that you understand how that must make [arian em] feel. Still, running around all the time clearly isn't doing [arian em] any good. Furthermore, it's no trouble at all; you want to help. Hmm... what if you promise to drop in now and then - share some of your stories about life in the wasteland, let [arian em] live vicariously through your actions?  Will that encourage [arian em] to stay in bed and avoid overexerting [arian em]self?");
	outputText("\n\nArian smiles at your offer.  \"<i>Well, that would certainly help.  I enjoy your company; there's something about you that.  Well... I guess you help me relax, and hearing about the world is not so bad either.  But I really wanted to see it.</i>\"");

	outputText("\n\nAnd see it [arian ey] will, but only if [arian ey] listens to you and gives [arian em]self a real chance to recover!  You insist that [arian ey] start relaxing; it's probably the tension as well as the punishment [arian ey] puts [arian em]self through in the name of boredom that's keeping [arian eir] from making any major recovery.");
	outputText("\n\n\"<i>Maybe you're right.  All right then, I'll trust you [name].  I've been stuck inside the academy for many years... I guess I can hold out for a few weeks longer, as long as you come visit me.</i>\"  [arian Ey] extends [arian eir] hand.  \"<i>Deal?</i>\"");

	outputText("\n\nYou give [arian em] a firm handshake, pronouncing that it's a deal.  Arian smiles at you before opening [arian eir] maw into a wide yawn.  \"<i>Sorry about that, [name].  I guess I'm a bit sleepy....</i>\"");
	outputText("\n\nYou smile, and tell [arian em] that it's all right and [arian ey] needs [arian eir] sleep, so [arian ey] had best get into bed. Arian nods and tucks [arian em]self in.  \"<i>Thank you, [name].</i>\"  You bid [arian em] goodnight and gently close [arian eir] door behind you.  On your way out you let Boon and Laika know Arian is sleeping, then you make your way back to camp.");
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
	outputText("You look Arian over, remarking that [arian ey] seems to be getting better after all.");
	outputText("\n\n\"<i>Thanks to you.</i>\" Arian smiles, then [arian ey] looks down and sighs.  You ask [arian em] what's wrong.");
	outputText("\n\n\"<i>I've been having... erm, confusing dreams lately.</i>\" Arian explains. Curious, you ask [arian em] what sorts of dreams; not bad ones, you hope.");
	outputText("\n\nArian quickly says, \"<i>No! Not bad ones! Just... unusual I'd say....</i>\"");
	outputText("\n\nYou look at [arian em] questioningly.  \"<i>Maybe it's best if I tell you....</i>\"");
	outputText("\n\nArian clears [arian eir] throat and begins explaining, \"<i>First I'm standing somewhere - I don't know where - in Tel'Adre.  I'm all alone, but I'm happy; I'm expecting someone.  When the person I'm expecting arrives, we talk - I don't remember the subject now.</i>\" Arian fidgets.");
	outputText("\n\nYou tell [arian em] [arian ey] needs to try and remember what happened if [arian ey] wants to really hear what you think, but so far it doesn't sound so strange.");
	outputText("\n\n\"<i>You see, the strange part is... it's what happens later.</i>\"  Arian blushes in embarrassment.  \"<i>We go to my room and I... I'm sorry I can't talk about it!</i>\"  Arian blushes even more.");
	outputText("\n\nIt doesn't take you long to figure out what kind of dreams [arian ey]'s been having.  With a faint smile on your lips, you give [arian em] a comforting pat on the shoulder and tell [arian em] that there's nothing to worry about in having such dreams.");
	outputText("\n\nArian looks at you, still embarrassed.  \"<i>But the person I meet... I don't know if it would be appropriate.... Maybe the corruption is getting to me?</i>\"");
	outputText("\n\nYou ask [arian em] why [arian ey] feels like that - what's wrong with [arian eir] dream lover?  ...Is he worried because [arian eir] lover is a boy?  Or maybe a girl with a cock?");
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
	outputText("Though you do feel a little curious, you decide to stop making [arian em] uncomfortable, and tell [arian em] that it's okay, you'll let [arian em] get some sleep now.");
	outputText("\n\n\"<i>Thanks, [name].  I'll see you later then.</i>\"  Arian tucks [arian em]self in.  You watch until [arian ey]'s settled in, and then start the trek back to your home-away-from home in the Marethian wilderness.");
	doNext(camp.returnToCampUseOneHour);
}

//=Pry=
private function arianStoryPry():void {
	clearOutput();
	outputText("Oh, no, you're not letting [arian em] wriggle out of this that easily.  You playfully tap [arian eir] nose and tell [arian em] [arian ey] should come clean and confess");
	if (player.cor < 40) outputText("; [arian ey]'ll sleep better with the burden off [arian eir] conscience");
	outputText(".");
	outputText("\n\nArian closes [arian eir] eyes and admits.  \"<i>It's someone close!</i>\"  He blurts out, hiding himself under the covers.");
	outputText("\n\nWell, now, that's intriguing... still, no matter how you try, [arian ey] won't say anything more and [arian ey] won't come out.  It's quite clear what's going on so all you can do is sigh, do your best to pat [arian eir] head through the covers, and tell [arian em] you'll come back another day and that you're sorry for being so nosey.  You then turn and walk out the door, heading down the stairs and back to camp.");
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
	outputText("You tell [arian em] that sounds fascinating.  You'd love to learn how to cast spells the way [arian ey] can, and you're grateful [arian ey] wants to take you on as an apprentice.  Especially when [arian ey]'s already so busy with the ones [arian ey] already has.  Arian rubs the back of [arian eir] neck.  \"<i>Sorry, [name].  But I can't actually teach you how to cast spells the same way I do....  That would take years to teach, not to mention it's very dangerous; I mean, look at what it's done to me....</i>\"  [arian Ey] smiles at you.  \"<i>But I could still teach you about magic in general - how to cast more spells, how to make them more powerful, the principles behind every spell....  Basically, theory that might help you in the pursuit of magical studies.  I spent my whole childhood buried in books, so I'm sure I could help you out somehow.</i>\"");

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
	outputText("\n\nArian opens a drawer in [arian eir] work desk and removes a small package, neatly wrapped and adorned with a small ribbon.  \"<i>For you.</i>\"  Arian says, handing over the gift.");

	outputText("\n\nYou reach out and gently take it from [arian em], carefully opening the package.  A part of you briefly wonders if it might be an engagement ring, then dismisses the thought - surely not, not even here in Tel'Adre.  Once the package is open, you gaze upon a silver necklace: the design is intricate and exotic - very beautiful.  Held by its unusual chain lies a small silver plate with a rune adorning the center, although you don't recognize the rune.");
	outputText("\n\nArian smiles at you.  \"<i>Do you like it?  I made it myself.</i>\"");

	outputText("\n\nYou study the fascinating piece, and tell [arian em] the honest truth: it's beautiful.  You never would have expected [arian em] to be such a crafts[arian man].  Arian blushes at your flattery.  \"<i>Thanks, I'm glad you like it.  But let me explain - that is not a common necklace; it's actually a magical talisman.  I wanted to give you something that would be useful in your adventures,</i>\" Arian explains.");

	outputText("\n\nYou smile at [arian em], and promptly hang the necklace around your neck, telling [arian em] it's as thoughtful as it is attractive.  Arian blushes.  \"<i>There is just a... well, a tiny problem.</i>\"");

	outputText("\n\nYou freeze nervously.  Problem...?  You wonder if putting it on was such a good idea now.  Arian nods.  \"<i>I haven't actually imbued the talisman with any spell, since I don't have any ingredients to do so.  Sorry, [name].</i>\"  Arian looks down disappointed.");

	outputText("\n\nYou heave a sigh of relief; is that all?  Well, what if you just bring [arian em] some ingredients next time you drop in, hmm?  Would that help [arian em] put the finishing touches on it?");

	outputText("\n\nArian smiles and nods.  \"<i>Of course.  But I should warn you that the talisman can only hold one spell, although once it's been imbued with a spell you may use it to your heart's content... I mean... as long as you don't get too tired doing so....  I have a list of spells and things that I need to complete a spell; all you have to do is bring the ingredients and tell me which spell you want.</i>\"");

	outputText("\n\nYou thank Arian; such a gift is bound to be useful in your travels.");

	outputText("\n\nArian bites [arian eir] lower lips.  \"<i>So... is there anything you'd like to do?  Maybe....</i>\" Arian blushes.  \"<i>You could thank me properly... for the gift.</i>\" [arian Ey] eyes you up and down, resting [arian eir] gaze on the floor as [arian ey] fidgets.");

	outputText("\n\nOh-hooo....  Your smoldering eyes burn holes in the nervously embarrassed lizan, and you give [arian em] your sexiest glare as you ask whatever [arian ey] means by \"<i>thanking [arian em] properly</i>\"...?  You reach out and stroke the side of [arian eir] face to emphasize your words, watching [arian em] shudder anticipatorily at your touch.");

	outputText("\n\nArian swallows audibly.  \"<i>I... I... I want you!</i>\" Arian blurts out, averting your gaze in embarrassment, fidgeting even more in what you've come to recognize as a sign [arian ey] is aroused.");

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
	outputText("You approach the awkwardly amorous lizan and place your arms around [arian eir] neck.  Leaning in close, you whisper into [arian eir] ear that [arian ey] only had to ask.");
	//(Display Sex Menu)
	arianSexMenu(false);
}

//=No=
private function noPlotSexNauArian():void {
	clearOutput();
	outputText("You apologize to the lizan, telling [arian em] that you aren't in the mood right now....");
	outputText("\n\nArian looks a bit disappointed, but doesn't press the issue.  \"<i>Oh... Okay then, but... maybe, next time?</i>\" [arian ey] asks hopefully, smiling nervously despite [arian eir] embarrassment....");

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

	outputText("\n\nYou tell [arian em] that, even if it's only once every 24 hours, that could be a very useful trick, and thank [arian em] for being willing to make such a sacrifice on your behalf.");

	outputText("\n\nArian smiles brightly at you.  \"<i>No problem.  I'd do anything for you.</i>\"  [arian Ey] gazes into your eyes in silence... perhaps a bit too long....  You clear your throat and Arian seems to snap out of [arian eir] trance.  \"<i>Oh!  Umm... is there something you want to do?</i>\"  [arian Ey] fidgets.");

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

	outputText("\n\n\"<i>I wanted to ask you if we could... well... live together?</i>\"  Arian bites [arian eir] lower lip.");

	outputText("\n\nYou explain to Arian about the portal, and your mission as the champion - how due to your duties, you cannot just move here and live with [arian em].");

	outputText("\n\nArian quickly adds, \"<i>Oh... no....  You wouldn't be moving here.  I would be the one moving in with you....");
	if(camp.companionsCount() > 1) outputText("  There are other people living with you already, so what's one more?  Right?");
	outputText("</i>\"");

	outputText("\n\nYou ponder [arian eir] request...  On one hand, having someone who understands magic would be of great help for your quest, and you've come to enjoy Arian's company, but what about Boon and Laika?");

	outputText("\n\n\"<i>I've spoken with them already and I believe they are ready to pursue their magical studies on their own.  They've been caring for me for a long time; I think it's time they lived their lives for themselves.  Besides, we won't be separated for good; I'll come and visit every once in a while.</i>\"  Arian smiles hopefully at you.");

	outputText("\n\nWell... when [arian ey] puts it that way... what should you do?");
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
	outputText("You tell Arian you'd be delighted to have [arian em] move in with you.  Arian's face lights up like a kid's who's been given a bucket of candy.  \"<i>Really!?  Great!  I'll pack my stuff and we can go right away!</i>\"");

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
	outputText("You tell Arian you'd like to talk to [arian em].  Arian smiles at the prospect of chatting with you.  \"<i>I love talking with you; so what do you want to talk about?</i>\"");
	menu();
	if(flags[kFLAGS.ARIAN_VIRGIN] > 0) addButton(0,"Sexy Talk",arianSexingTalk);
	if(flags[kFLAGS.ARIAN_S_DIALOGUE] >= 3) addButton(1,"Teach Magic",arianMagicLessons);
	if(arianFollower()) addButton(2,"Scales",arianScalesTalk);
	if(!arianFollower() && flags[kFLAGS.ARIAN_S_DIALOGUE] >= 6) addButton(4, "Invite2Camp", inviteArianToCamp);
	if (TyrantiaFollower.TyrantiaFollowerStage == 5) addButton(5, "Tyrantia", TyrantiaEggQuestArian);
	if(flags[kFLAGS.ARIAN_VIRGIN] == 0 && flags[kFLAGS.ARIAN_S_DIALOGUE] < 3) outputText("\n\n<b>Arian doesn't have much to talk about right now.  Maybe you ought to just visit him from time to time or find him an item that would help combat [arian eir] sickness.</b>");
	addButton(14,"Back",arianHomeMenu);
}

private function TyrantiaEggQuestArian():void {
	clearOutput();
	outputText("You ask your wizard-lizard about Purifying the unborn. You explain Tyrantia’s situation, and why she struggles so much with it. [arian Ey] gives you an odd look, and shakes [arian eir] head.\n\n");
	outputText("\"<i>I’m afraid not. I’m sorry, but my anti-corruption magic can harm, and someone with less constitution could even be injured by it. What you’re thinking simply isn’t possible. Not in the way you’re thinking. My spell would be quite destructive to such a vulnerable little one.</i>\" Arian puts a hand on your shoulder. \"<i>I wish I could help you, I really do.</i>\" Arian seems genuinely sad about your situation. You thank Arian for [arian eir] time, leaving.");
	advanceMinutes(15);
	doNext(talkToArianChoices);
}

private function arianScalesTalk():void {
	clearOutput();
	if (flags[kFLAGS.ARIAN_SCALES] < 1) {
		outputText("You ask Arian if [arian ey]’d like to bring some color into [arian eir] life, because, given that [arian ey]’s totally recovered from [arian eir] past sickness, bringing a bit of color to [arian eir] scales could improve [arian eir] looks a bit.\n\n");
		outputText("\"<i>I’d never thought about it. The white coloration on my scales has been with me my entire life, so I've grown quite accustomed to them being that way.</i>\"\n\n");
		outputText("\"<i>Even when I recovered from my condition, I still saw it as something normal. Actually, I’m not even sure if their color was something related to my sickness, or their natural hue. Now, since I’m fully recovered, I’m not opposed to a color change, to celebrate my recovering, but...</i>\"\n\n");
		outputText("But?\n\n");
		outputText("\"<i>Most Marethians change the color of their bodies with dyes, but those dyes only work for hair and similar features, like fur or feathers. Scales have a surface that rejects most mixtures and won’t allow them to get changed, so how would you manage to get my scales dyed?</i>\"\n\n");
		outputText("Luckily for [arian em], you answer, you had thought over the same problem earlier, so you spoke with the camp’s alchemist, and, using some Reptilium, and a few special dyes that you chose especially for Arian, you managed to make some dyes that’ll give [arian em] a totally new look, if [arian ey]’s ok using them, of course.");
	}
	else {
		outputText("You ask Arian if [arian ey]’d like to change the color of [arian eir] scales.\n\n");
		outputText("Arian smiles, saying \"<i>I'm still open to whatever you want to bring me.</i>\"")
	}
	if (flags[kFLAGS.ARIAN_SCALES] < 1) flags[kFLAGS.ARIAN_SCALES] = 1;
	doNext(camp.returnToCampUseOneHour);
}

//Magic:
//Magic Lessons, teaches white magic and increases int. Up to 100.
//Gain a pretty nice boost, 4 lessons per day, only.
private function arianMagicLessons():void {
	clearOutput();
	arianHealth(1);
	outputText("You ask Arian if [arian ey] wouldn't mind giving you some magic lessons.");

	//(if ArianMLesson >= 4)
	if(flags[kFLAGS.ARIAN_LESSONS] >= 4) {
		outputText("\n\nArian raises [arian eir] hand, stopping you in your tracks.  \"<i>I appreciate your enthusiasm, [name].  But first you must rest and let the lessons of the day sink in.  I promise I'll teach you more tomorrow.</i>\"  Arian smiles at you.");

		outputText("\n\nMaybe [arian ey]'s right... you tell [arian em] you'll ask [arian em] to teach you more tomorrow and excuse yourself.");
		doNext(camp.returnToCampUseOneHour);
		return;
	}
	outputText("\n\nArian nods.  \"<i>Of course!  Now where do I begin....</i>\"");

	//(if PC int < 25) //Basics!
	if(player.inte < 25) {
		outputText("\n\nYou let Arian know you're actually pretty new to magic in general, so maybe [arian ey] could teach you a few basics?  Arian nods.  \"<i>Very well...</i>\"  Arian clears [arian eir] throat.");
		outputText("\n\n\"<i>The basis of all magic is mental strength, or more appropriately, your willpower - the desire, the wish, the passion to make something that is not... be.  Which is the reason mages study so hard to begin with.</i>\"");
		outputText("\n\nYou pay attention to Arian's every word, making mental notes of the more important lessons....");

		outputText("\n\n\"<i>And that is all; any questions?</i>\"  Arian patiently awaits your reply.  You sigh, tired after a long lesson on the fundamentals of magic and spellcasting.  You tell [arian em] that you don't have any questions for now... but you'd like to repeat the lesson some other time.");
		outputText("\n\nArian smiles at you.  \"<i>Of course, [name].  If you have any doubts or would like me to repeat, all you have to do is ask.  I'll make sure to always have time for you.</i>\"");
		outputText("\n\nYou thank the lizan for the lesson and ");
		if(!arianFollower()) outputText("make your way back to your camp.");
		else outputText("return to your duties.");
	}
	//(else if PC int < 50 //Teach Charge Weapon if PC doesn't know.
	else if(player.inte < 50 || !player.hasStatusEffect(StatusEffects.KnowsCharge)) {
		outputText("\n\nYou tell Arian you've got the fundamentals down, so why not cover something a bit more advanced?");
		outputText("\n\nArian taps [arian eir] chin in thought, then smiles.  \"<i>I know!  Let's talk about channeling.</i>\"");
		outputText("\n\nChanneling? You ask.");
		outputText("\n\n\"<i>Yes, the art of focusing your spell within a conduit - in short, enchanting objects.</i>\"");
		outputText("\n\nYou smile and tell Arian this sounds like an interesting subject....");
		outputText("\n\n\"<i>So remember: don't overcharge your conduit or the results could be disastrous....  Just ask Boon,</i>\" Arian chuckles.");
		outputText("\n\nYou wonder whatever could have happened that was so funny.  But for the moment the lesson has tired you, so you thank Arian for the lesson and excuse yourself ");
		if(!arianFollower()) outputText(", making your way back to camp.");
		else outputText(", exiting [arian eir] tent and going about your business.");
		//(if PC doesn't know Charge Weapon)
		if(!player.hasStatusEffect(StatusEffects.KnowsCharge)) {
			outputText("\n\nAs you ");
			if(!player.isNaga()) outputText("walk");
			else outputText("slither");
			outputText(" away, you start pondering Arian's lesson of the day.  You wonder if you could perhaps apply the channeling principle to strengthen your [weapon] in combat.");
			outputText("\n\nThat would be very helpful; you'll have to try it sometime.");
			player.createStatusEffect(StatusEffects.KnowsCharge,0,0,0,0);
		}
	}
	else if (player.inte < 75 || !player.hasStatusEffect(StatusEffects.KnowsBlind)) {
		outputText("<b>Game Note: This isn't canon and will be re-written soonish.</b>");
		//Teach Blind if PC doesn't know.
		outputText("\n\nYou say you have a pretty good understanding of how magic works now, so you'd like [arian em] to get started on the more complex theories.");
		outputText("\n\nArian rubs [arian eir] chin in thought.  \"<i>Hmm.... Aha!  Let's discuss conjuration.  This is where we start getting to the more complex theories and methods.  I know I don't have to say it, but pay attention.  Conjuration is an important art for any mage.</i>\"");
		outputText("\n\nYou nod as Arian begins lecturing you on the finer points of the art of conjuration.");
		outputText("\n\nArian wasn't kidding; this is quite a complex subject...");
		outputText("\n\n\"<i>Now to finish our lesson, I'll give you a practical example of how to effectively use conjuration to defend yourself.  So pay attention, [name].  Conjured objects are generally weaker than real objects, so conjuring a shield or a suit of armor or even a weapon is no good.  Not to mention it's quite complicated.  A suit of armor is made not only of metal, but of other components as well - you'd have to conjure and maintain each individually.  Instead, conjure a simple element that can turn the tide of the battle in your favor.</i>\"");
		//(if PC doesn't know Blind)
		if(!player.hasStatusEffect(StatusEffects.KnowsBlind)) {
			outputText("\n\nLike what?  You ask in curiosity.");
			outputText("\n\nArian lifts a closed fist.  \"<i>Mind your eyes.</i>\"  You nod.  Arian points [arian eir] fist towards a nearby wall and opens [arian eir] hand.  A bright flash of light shoots out of [arian eir] hand to hit the wall harmlessly.  \"<i>This was the element of light.  I produced a bright light capable of temporarily blinding whoever happens to be looking at it when it's exposed.</i>\"");
			outputText("\n\nYou note how such a spell could be useful for you in combat.  Arian grins at you.  \"<i>I'm glad this lesson was helpful, [name].  Come here and I'll teach you how to properly conjure it.</i>\"");
			outputText("\n\nYou spend a few minutes learning how to properly use the spell, and after some practice you can reliably use the spell whenever you want to.  You thank Arian for the lesson and for teaching you a new spell.  Then bidding farewell to the grinning lizan, you leave, promising to visit [arian em] again soon.");
			player.createStatusEffect(StatusEffects.KnowsBlind,0,0,0,0);
			//Return to camp.
		}
		else {
			outputText("\n\nYou understand what Arian's talking about.  [arian Ey] means that rather than conjuring a barrier, it's best to conjure something akin to a bright light to try and blind your foe.");
			outputText("\n\nArian nods pridefully. \"<i>Very well, [name]!  That's exactly what I mean.</i>\"");
			outputText("\n\nYou spend a few more minutes talking to Arian before thanking [arian em] for the lesson and bidding farewell to the grinning lizan, you promise to visit [arian em] again soon.");
		}
	}
	else {
		//Teach Whitefire if PC doesn't know.
		outputText("<b>Game Note: This isn't canon and will be re-written soonish.</b>");
		outputText("\n\nYou ask Arian if [arian ey] wouldn't mind hearing some of your own theories about magic; you've been giving the subject a lot of thought lately.");
		outputText("\n\n[arian Ey] looks at you, eyes alight with interest at what you have to say.  \"<i>Please, do share your thoughts.</i>\"  You explain that if you are able to use magic to conjure elements, with a little concentration it might also be possible to alter these elements on the fly; you convey the method you theorized to the lizan mage.");
		outputText("\n\nIf you can conjure elements at will, would it be possible to also alter them?  You could have one element start out as a non-volatile substance within your hands and then hurl it towards a target whilst also focusing upon changing its nature, thus creating an explosive reaction.  For instance, you can start out with a small gathering of dust and quickly change it into a highly combustible element and make it look like as if you made the air explode.");
		outputText("\n\nOnce you're done, Arian grins at you.  \"<i>That's very good, [name].  Indeed, alteration is another art a mage must master in order to be considered a true master; let me give you a more detailed explanation....</i>\"");
		outputText("\n\nYou listen attentively to the lizan....");
		outputText("\n\n\"<i>And that's about it.  There were mages researching this subject at the academy, but then the whole trouble with the demons happened... maybe someday we can resume our research in this area.</i>\"");
		outputText("\n\nYou let Arian know that this conversation was very interesting; the knowledge [arian ey] shared with you today is bound to be useful in your adventures.");
		outputText("\n\n[arian Ey] grins happily at you.  \"<i>I'm glad to be of use, [name].  Please come back soon; I would love to discuss more of it with you.</i>\"");
		outputText("\n\nYou thank Arian and promise to return sometime soon.  You excuse yourself and ");
		if(!arianFollower()) outputText("begin the trek home.");
		else outputText("exit [arian eir] tent.");
		//(if PC doesn't know Whitefire)
		if(!player.hasStatusEffect(StatusEffects.KnowsWhitefire)) {
			outputText("\n\nAs you walk, you ponder what you discussed with Arian and conclude that by combining conjuration with alteration, you could quickly and easily create an expanding conflagration of flames, burning your foes in combat.");
			outputText("\n\nYou should put that into practice sometime soon.");
			player.createStatusEffect(StatusEffects.KnowsWhitefire,0,0,0,0);
		}
	}
	flags[kFLAGS.ARIAN_LESSONS]++;
	dynStats("int", 1);
	player.trainStat("int", +2, player.trainStatCap("int",50));
	player.trainStat("int", +1, player.trainStatCap("int",75));
	doNext(camp.returnToCampUseOneHour);
}
//Sex:
//Available after the first time you have sex. (ArianVirgin > 0)
private function arianSexingTalk():void {
	clearOutput();
	arianHealth(1);
	outputText("You smirk knowingly at [arian em] and ask how [arian ey] feels about sex now that [arian ey]'s had [arian eir] first time?");

	outputText("\n\nArian bites [arian eir] lower lip in embarrassment.  \"<i>I... umm... can't we talk about something else?</i>\"  You shake your head and tell [arian em] there's nothing to be ashamed of.  The two of you have already shared intimacy after all; and you'd like to know [arian eir] kinks and wishes as well.");
	outputText("\n\nArian blushes, and takes a deep breath.  \"<i>Okay....</i>\"");
	//Block about penis. Should only show up if Arian has a cock at all.
	if (flags[kFLAGS.ARIAN_COCK_SIZE] != 0) {
		//Arian talks about his lack of a second penis.
		if (flags[kFLAGS.ARIAN_DOUBLE_COCK] == 0) {
			outputText("\n\n\"<i>I've always resented my lack of a second dick,</i>\" Arian admits.");
			outputText("\n\nReally?");
			outputText("\n\n\"<i>Well, lizans like me usually have two, and I only have one....  I've always thought I was freakish and usually avoided any kind of sexual contact, not that it was hard to avoid it, since I usually had my muzzle buried in a book.  Maybe I wasn't as social because of that... or... I don't know.  The point is, I never hoped to find someone who'd... you know....</i>\"  Arian fidgets, smiling nervously at you.");

			outputText("\n\nYou smile right back at [arian em].  You happen to find Arian is adorable, especially when [arian ey] gets all shy like that.  But if [arian eir] lack of a matching dick is such a big problem, maybe you could find something in your journey to help [arian em] remedy that.  Would [arian ey] like that?");
			outputText("\n\n\"<i>Oh... I suppose there might be something that can do that.  Although I suppose it doesn't matter that much now.  Unless you'd like me to get a second one?</i>\"");
			outputText("\n\nYou ponder the idea, but decide that Arian is fine just the way [arian ey] is; maybe someday though...");
		}
		//Arian has 2 penis, thankful for the PC's help in that department.
		else
		{
			outputText("\n\n\"<i>I had always resented my lack of a second dick,</i>\" Arian admits.  \"<i>But I guess I don't have to worry about this anymore, thanks to you.</i>\"  [arian Ey] smiles at you.");
			outputText("\n\nYou tell [arian em] that it was no trouble; double the pleasure, double the fun, right?");
			outputText("\n\nArian blushes.  \"<i>I guess....</i>\"");
			outputText("\n\nAlthough... that means [arian ey]'d have double the work if [arian ey] intends to masturbate.  \"<i>Umm... why would you say that?</i>\"  Arian asks nervously.");
			outputText("\n\nYou chuckle, and tell [arian em] you haven't forgotten that time you caught [arian em] masturbating.");
			outputText("\n\nArian laughs nervously.");
		}
		outputText("\n\nWhat about [arian eir] size though?  In this world it's quite easy to do something about that, if size is a problem.");
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
			outputText("\n\n\"<i>It's a lot bigger than I'm comfortable with, to be honest.  But you said you liked it, so I'm keeping it.</i>\"  You see [arian eir] robes beginning to tent, and can't help but tease the shy lizan.  It seems that despite [arian eir] complaints, [arian ey] enjoys having a monster between [arian eir] legs... one that [arian ey] can't hope to hide.");
			outputText("\n\nArian blushes.  \"<i>I... okay, I admit it... it feels pretty good... and is kinda kinky, too... Still, if you think I should be smaller... I wouldn't mind.</i>\"");
		}
		outputText("\n\nYou tell Arian you'll think about it....");
	}
	//End of Cock Block. Innuendos ahoy!
	//(if ArianVagina > 0) //Talk about Arian's new oviposition perk
	if(flags[kFLAGS.ARIAN_VAGINA] > 0) {
		outputText("\n\nArian sighs and flushes; the distinct smell of an aroused female begins to permeate the room.  That and the lizan's cute fidgeting are a dead giveaway of [arian eir] current state.");
		outputText("\n\n[arian Ey] sighs and licks [arian eir] lips.  \"<i>I never imagined I would ever turn into a girl... much less that I would know what being a girl is like....  Everything feels different... but not in a bad way... just weird, I guess.</i>\"");
		outputText("\n\nYou tell [arian em] that's understandable, and ask how [arian ey]'s feeling about that.");
		outputText("\n\n\"<i>I feel sick for no apparent reason.  I have the strangest urges I didn't have.  My chest feels heavy.  And above all else....</i>\"  Arian looks at you and blushes.");
		outputText("\n\nAnd above all else?  You ask.");
		outputText("\n\nArian averts [arian eir] eyes.  \"<i>Just being close to you makes me... hot....</i>\"");
		outputText("\n\nReaaaally?  You smirk at [arian em], and [arian ey] flushes even more.  \"<i>T-there's also the eggs... so many eggs....</i>\"");
		outputText("\n\nEggs?");
		outputText("\n\n\"<i>Yes, eggs.  Lizan females lay eggs throughout their entire fertile period... I... have to deal with this monthly... and whenever the time to lay comes around I find myself thinking....</i>\"");
		outputText("\n\nThinking?");
		outputText("\n\n\"<i>About you.</i>\"  Arian admits.");
		outputText("\n\nIf that's the case, maybe you should help [arian em] lay sometime.");
		outputText("\n\n\"<i>I think, I'd like that... sometime,</i>\" [arian ey] replies.");
		if(arianFollower()) outputText("\n\nYou tell [arian em] you'll make sure to stop by when [arian ey]'s close to laying then.\n\n\"<i>I'll be waiting for you.</i>\"  Arian smiles.");
		else outputText("\n\nAs much as you'd like that, Boon and Laika, especially, are bound to berate you if they see you leaving [arian eir] room with an egg in hand.\n\nArian giggles, \"<i>That's true.  Maybe we can find a way to be alone then?</i>\"\n\nMaybe....");
	}
	outputText("\n\nYou look Arian over, and decide to ask what [arian eir] preferred form of sex is.");
	//Finally discuss Arian's preferred sex acts. [Arian Ey] slowly takes a liking for anal.
	if(flags[kFLAGS.ARIAN_ANAL_XP] < 33) {
		//No preference... yet.
		outputText("\n\n[arian Ey] rubs [arian eir] chin in thought, but in the end [arian ey] simply shrugs and says, \"<i>I guess I don't really have a preference... so I'm good with whatever you feel like doing.</i>\"  Arian smiles at you.");
		outputText("\n\nMaybe [arian ey]'s not sure yet because you haven't played with [arian em] enough yet.... Perhaps you should try doing more... stuff?");
		outputText("\n\nArian smiles nervously at you and slowly nods in agreement.");
	}
	else if (flags[kFLAGS.ARIAN_ANAL_XP] < 66) {
		//Kinda like anal, thought it was going to hurt but it feel nice...
		outputText("\n\n[arian Ey] rubs [arian eir] chin in thought.  \"<i>To be honest... ever since you... umm... put it back there....</i>\"  Arian blushes.  \"<i>I've been thinking that anal is not so bad... I was scared that it might hurt at first... and while it does hurt a bit, it also feels nice.</i>\"");
		outputText("\n\nYou're surprised to hear that.  Not everyone enjoys anal sex.");
		outputText("\n\nArian averts [arian eir] eyes.  \"<i>I'm not saying I enjoy it... but I don't mind if it's you....</i>\"");
	}
	//Anal feels good, just as good as any other action if not better
	//(else if (ArianAnalXP <= 100))
	else if(flags[kFLAGS.ARIAN_ANAL_XP] <= 100) {
		outputText("\n\n[arian Ey] blushes.  \"<i>I'm... I like it when you use my ass... it feels really good,</i>\" [arian ey] admits.");
		outputText("\n\nOh, really?  You ask.  It's rare to find someone who actually enjoys anal sex, much less someone willing to admit it openly.  This is something you certainly didn't expect from the shy lizan.");
		outputText("\n\nArian bites [arian eir] lower lip and smiles nervously at you.  \"<i>I guess that makes me a pervert for liking it?</i>\"");
		outputText("\n\nYou chuckle.  Maybe... considering the things you've seen in this world, you'd be hard pressed to find what kind of rule defines a pervert.  But that doesn't matter; you enjoy using [arian eir] ass too.  Arian smiles at you.");
	}
	else {
		//Anal is definitely what Arian prefers, although [Arian ey] likes other stuff too, [Arian ey] prefers anal.
		outputText("\n\n[arian ey] blushes and averts [arian eir] eyes.  \"<i>I can't stop thinking about when you use my ass... it feels really good... and if I had to say if there's anything I like... then it's that.... I hope it feels good for you, too.</i>\"  Arian smiles at you, nervously.");
		outputText("\n\nThat's... quite forward of [arian em]... you didn't expect an admission like that.  But you like it; [arian eir] ass certainly feels good, and you're glad it is pleasurable and that Arian likes it so much.");
		outputText("\n\nArian takes a glance at your crotch.");

		//if PC has no cock)
		if(!player.hasCock()) {
			outputText("\n\nBut [arian ey] sighs in disappointment when [arian ey] sees no bulge.  \"<i>Maybe... you could grow your dick back and... never mind....</i>\"  Arian averts [arian eir] eyes.");
			outputText("\n\nYou tell [arian em] you'll think about it.");
		}
		else {
			outputText("\n\n[arian Ey] smiles nervously at you and begins fidgeting.  \"<i>Perhaps... you'd like to... well... use me again?  Please?</i>\" Arian asks hopefully.");
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
	outputText("How could you refuse such a request?  You tell [arian em] to strip and get ready.");
	outputText("\n\nArian jumps to the task and eagerly strips, laying down in bed and swaying [arian eir] tail back and forth as [arian ey] waits for you to do the same.");
	//(Go to Give Anal)
	menu();
	addButton(0,"Next",giveArianAnal);
}

//[=No=]
private function goddamnitNoYouButtSlut():void {
	clearOutput();
	outputText("You apologize, but you really can't do that right now.  [arian Ey] looks a bit disappointed, but smiles at you all the same.  \"<i>Oh... okay.  Next time then?</i>\"");
	outputText("\n\nYou nod.");
	sexTalkFinish(false);
}

private function sexTalkFinish(newl:Boolean = false):void {
	if(newl) clearOutput();
	else outputText("\n\n");
	outputText("Satisfied with your little chat, you pat the lizan's head and excuse yourself, heading back to camp.");
	doNext(camp.returnToCampUseOneHour);
}

//Invite to Camp:
//Only available if ArianHealth == 100.
private function inviteArianToCamp():void {
	clearOutput();
	outputText("You ask the lizan if [arian ey] still really wants to leave [arian eir] comfortable home in the city and come out to live with you in your little camp in the wastelands?");
	outputText("\n\n\"<i>Of course I do!</i>\" Arian says enthusiastically.");
	outputText("\n\nWell, if [arian ey] really wants to do that... though why [arian ey] would want to do that escapes you... [arian Ey] can come and move in.  But [arian ey] will need to bring [arian eir] own tent and sleeping bag and stuff like that, you warn the overenthusiastic lizard-");
	if(flags[kFLAGS.ARIAN_COCK_SIZE] > 0) {
		if(flags[kFLAGS.ARIAN_VAGINA] == 0) outputText("man");
		else outputText("herm");
	}
	else outputText("woman");
	outputText(".");

	outputText("\n\n\"<i>Great! I'll pack up and we can go right away!</i>\" Arian announces happily.");

	//(Story Dialogue Links here.)
	outputText("\n\nArian opens a small closet and brings out a pair of small bags.  One of them is tightly closed and seems close to bursting, the other looks completely empty.  [arian Ey] takes a few neatly folded spare sets of clothes and gently packs them inside [arian eir] bag, then turns and walks to [arian eir] work desk where [arian ey] picks up a few more trinkets and bags them all.");

	outputText("\n\nHaving done that, Arian grabs both bags in [arian eir] hands and happily announces, \"<i>All done!</i>\"");
	outputText("\n\nYou look at the bags skeptically and ask what kind of joke the lizan is trying to pull over you.");

	outputText("\n\nArian looks at you in confusion.  \"<i>Joke?  What do you mean by joke?</i>\"");

	outputText("\n\n[arian Ey] can't seriously expect you to believe that's all [arian ey] intends on taking.");
	outputText("\n\nArian looks at [arian eir] bags and shrugs.  \"<i>Everything I need is in here.  I packed some stuff in advance, plus a few more clothes and some things I've been working on.  It's really all I need, trust me.</i>\"  Arian smiles.");
	outputText("\n\nYou sigh softly, and resign yourself to having to come back and fetch the stuff [arian ey] forgot in a day or so.  You tell [arian em] to say goodbye to [arian eir] apprentices; you're leaving now.");
	outputText("\n\nArian nods and tails you down the stairs towards the entryway.  \"<i>Boon!  Laika!</i>\"  Arian calls.  Within moments the twin ferrets present themselves, and upon seeing the bags in Arian's hands Boon smiles and Laika begins tearing up.");
	outputText("\n\nArian drops [arian eir] bags and opens [arian eir] arms, inviting the twins into a hug, which they happily accept.");
	outputText("\n\n\"<i>I'm happy for you, " + arianMF("master","mistress") + ", I really am,</i>\" Boon says.");
	outputText("\n\n\"<i>Make sure you're taking care of yourself, " + arianMF("master","mistress") + ".  Don't forget to bathe regularly and eat well... and contact us once in a while... and visit on the holidays,</i>\" Laika says, sniffing.");

	outputText("\n\nArian smiles at [arian eir] pupils.  \"<i>I'm not your " + arianMF("master","mistress") + " anymore.  From now on you're full-fledged mages.  Remember all that you learned, and I'm sure you'll be okay.</i>\"");
	outputText("\n\nBoon is the first to break the hug, followed shortly by Laika.  The twins then turn to you.");

	outputText("\n\n\"<i>Please, [name], take good care of the " + arianMF("mas","mis") + "... err... Arian.  [arian Ey] might be a handful sometimes, but [arian ey]'s a really good person,</i>\" Boon says with a bow.");

	outputText("\n\n\"<i>If " + arianMF("master","mistress") + "... I mean... if Arian gives you any trouble call us and we'll come running to give [arian em] a good scolding,</i>\" Laika says with a bow.");
	outputText("\n\n\"<i>Please don't sic Laika on me!</i>\" Arian pleads.");
	outputText("\n\nYou smile and laugh softly at the three; they really are just like family, aren't they? You promise that you'll take good care of their teacher and that you'll call them if [arian ey] needs them to spank [arian em].");

	outputText("\n\n\"<i>Come on, I'm not that bad, am I?</i>\" Arian protests.  Boon and Laika look at each other, then look at you, wearing expressions identical to your own.  Finally you all nod in unison.  Arian sighs....");
	outputText("\n\nHaving said your farewells, you begin the long trek back home... bringing with you a new ally (and lover) in tow.");
	menu();
	addButton(0,"Next",takeYerLizardHomePartII);
}

private function takeYerLizardHomePartII():void {
	clearOutput();
	outputText("Upon arriving at the camp, the first thing Arian notices is the shimmering portal.  \"<i>Is this... where you came from?</i>\" [arian ey] asks.");
	outputText("\n\nYou nod your head and confirm that, yes, this was your doorway from your world into Mareth.");
	outputText("\n\n\"<i>I heard that sometimes people from other worlds wandered into Mareth through portals, but I have never seen one up close before.</i>\"  Arian stares deeply at the portal.  \"<i>It's beautiful... and menacing, too.</i>\"  Shaking [arian em]self out of [arian eir] reverie, Arian takes an open spot close to your ");
	if (flags[kFLAGS.CAMP_BUILT_CABIN] > 0) outputText("cabin.  \"<i>That's a nice cabin you've got here,</i>\" [arian Ey] says.  You thank [arian em] for the appreciation.");
	else outputText("tent.");
	outputText("\n\n[arian Ey] sets [arian eir] overfull bag down and asks, \"<i>Is it okay if I stay here?</i>\"");
	outputText("\n\nYou tell the reptilian wizard that should be fine.  But surely even someone with [arian eir] scaly hide can't just sleep out in the open on bare earth?");
	outputText("\n\nArian laughs. \"<i>Of course not, silly.  I'm going to set up my own tent here.</i>\"");
	outputText("\n\nTent, you repeat questioningly. You tell [arian em] that you never saw [arian em] bring a tent here.");
	outputText("\n\n\"<i>Oh, I see... you might want to take a step back then,</i>\" Arian warns you with a wry smile.");
	outputText("\n\nYou wonder what the weird wizard has in mind, but do as [arian ey] says; you're not stupid enough to ignore a warning like that.");
	outputText("\n\nArian snaps [arian eir] fingers and the overfull bag bursts into an explosion of cloth.  You watch in amazement as a rather simple yet sturdy tent erects itself without any help.  It takes only a minute or so until the tent is set up in its appropriate spot, a small tarp covering the opening that leads inside.");
	outputText("\n\n\"<i>In case you have forgotten, [name], I happen to be a master mage,</i>\" Arian says with a proud smile.");
	outputText("\n\nYou look at the surprise tent and shake your head.  Truly, you hadn't forgotten... but you didn't know magic could be used for something as mundane as this.  [arian Ey] really surprised you this time.");
	outputText("\n\nArian slowly walks towards the entrance and holds the tarp for you.  \"<i>Care to take a peek inside?</i>\"  You nod and follow the lizan into the tent.");

	outputText("\n\nAs you walk inside you can't help but gasp in amazement... clearly you have underestimated the lizan.  The inside of the tent is pretty big comparing to the outside, and you see all the tools and facilities one would need to live in the wilderness with relative comfort.");

	outputText("\n\nIn one corner you see what looks like a small kitchen of sorts, complete with a wide assortment of utensils.  In the opposite corner you see a work desk much like the one Arian had set up in [arian eir] house.  Sitting in the middle of the room is a comfy-looking couch with a small table in front of it.  Further inside you see a comfortable looking bed with a few bookshelves and a small wardrobe sitting nearby.  A soft rug covers the floor of the tent and looking up you see what looks like a small magic lamp, lighting up the whole tent so you can clearly see how comfortable Arian is going to be compared to you");
	if(camp.followersCount() > 1) outputText(" and your other companions");
	outputText(".");

	outputText("\n\n\"<i>So what do you think?  Cozy?</i>\" Arian asks.");
	outputText("\n\nYou tell [arian em] it looks very cozy indeed. ");
	if (flags[kFLAGS.CAMP_CABIN_FURNITURE_BED] <= 0) outputText("In fact, you jest, you just might bring your sleeping roll in here and sleep with the lizan instead of in your own " + (CoC.instance.flags[kFLAGS.CAMP_BUILT_CABIN] == 1 ? "cabin" : "tent") + "Arian averts [arian eir] eyes and then smiles at you nervously.  \"<i>T-there's no need for you to bring your sleeping bag... </i>");
	else outputText("In fact, you jest, you just might have to forgo your own bed and sleep with the lizan instead of in your own cabin. Arian averts [arian eir] eyes and then smiles at you nervously. \"<i>W-well... </i>");
	outputText("<i>If you want to stay in here I'd be happy to share my bed with you.</i>\" ");
	outputText("\n\nYou tell the lizan it was just a jest... still, you drawl, you'll keep that in mind. ");
	outputText("Maybe you will drop by some night.");

	outputText("\n\n[arian Ey] nods.  \"<i>You're always welcome here whenever you want.</i>\"");

	outputText("\n\nYou politely excuse yourself, saying you should let the lizan make [arian emself] comfortable in [arian eir] new home, and step back outside.");
	//flag arian as follower
	flags[kFLAGS.ARIAN_FOLLOWER] = 1;
	flags[kFLAGS.ARIAN_SCALES] = 0.5;
	if (player.hasKeyItem("Radiant shard") >= 0) player.addKeyValue("Radiant shard",1,+1);
	else player.createKeyItem("Radiant shard", 1,0,0,0);
	outputText("\n\n<b>Before fully settling in your camp as if remembering something Arian pulls a shining shard from [arian eir] inventory and hand it over to you as a gift. You acquired a Radiant shard!</b>");
	doNext(camp.returnToCampUseOneHour);
}

//Sex
//ArianHealth must be at least 20 before you can even pick Sex as an option.
private function arianSexMenu(output:Boolean = true):void {
	if(output) {
		clearOutput();
		outputText("You ask Arian if [arian ey] feels strong enough to do a little lovemaking.");
		//(if ArianHealth < 30)
		if (flags[kFLAGS.ARIAN_HEALTH] < 30) {
			outputText("\n\n[arian Ey] smiles nervously at you.  \"<i>I... of course.  I'd love to.  What do you feel like doing?</i>\"");
		}
		else if (flags[kFLAGS.ARIAN_HEALTH] < 50) {
			outputText("\n\n[arian Ey] smiles nervously and averts [arian eir] eyes.  \"<i>Of course.  I want to learn more about you: your body, your thoughts, everything.  So... what do you want to do?</i>\"");
		}
		//(if ArianHealth < 75)
		else if (flags[kFLAGS.ARIAN_HEALTH] < 75) {
			outputText("\n\n[arian Ey] smiles and averts [arian eir] eyes.  \"<i>I would love to.  This isn't just thanks for my gift is it?</i>\"");
			outputText("\n\nYou assure [arian em] that's not the case; you just feel in the mood.");
			outputText("\n\nArian looks at you happily.  \"<i>Okay... what do you feel like doing?</i>\"");
		}
		//(if ArianHealth < 100)
		else if (flags[kFLAGS.ARIAN_HEALTH] < 100) {
			outputText("\n\n[arian Ey] smiles tenderly at you.  \"<i>I always have enough strength for lovemaking, [name].  What do you feel like doing?</i>\"");
		}
		//(if ArianHealth == 100) //Also used for follower Arian.
		else {
			outputText("\n\n[arian Ey] smiles and strokes your [face].  \"<i>Do you even need to ask?</i>\"");
		}
		outputText("\n\nYou smile at your lizan lover and begin shedding your [armor].  Arian follows in suit, settling down on [arian eir] bed and watching you enraptured as [arian ey] awaits your decision.  Once you're naked, much to the lizan's delight, you smile at [arian em] and consider your options....");
	}
	//(Display Options)
	sceneHunter.print("His anal XP increases, and has 3 stages, affecting both Anal-Pitch and DP scenes. Try yourself!");
	menu();
	addButton(0,"Anal Pitch",giveArianAnal).disableIf(player.cockThatFits(arianCapacity) < 0,
		"Req. a cock fitting "+arianCapacity+" area!");
	addButton(1,"Get Blown",getBlownByArian).disableIf(!player.hasCock(), "Req. a cock!");
	if(flags[kFLAGS.ARIAN_COCK_SIZE] > 0) {
		addButton(5,"Anal Catch",getButtWreckedByArian);
		addButton(6,"Blow " + arianMF("Him","Her"),suckAriansDick);
		addButton(7,"Get Fucked",getPenetratedByArianAndHisHitlerMustache).disableIf(!player.hasVagina(), "Req. a vagina!");
		addButton(8, "Docking", arianDocking).disableIf(player.cockThatFits(30) < 0 || flags[kFLAGS.ARIAN_COCK_SIZE] >= 3,
			"Req. a cock fitting 30 area, and Arian's cock must not be too big!");
	}
	if(flags[kFLAGS.ARIAN_VAGINA] > 0) {
		addButton(9, "Fuck Vagina", penetrateArian).disableIf(player.cockThatFits(arianCapacity) < 0,
			"Req. a cock fitting " + arianCapacity + " area!");
		addButton(10,"Double Pen",doublePenetrateArian).disableIf(player.countCocks(-1, arianCapacity) < 2,
			"Req. 2 cocks fitting " + arianCapacity + " area!");
		addButton(11,"Dildo Fun",arianDildoFun).disableIf(!player.hasVagina()
			|| player.hasKeyItem("Dildo") < 0 && player.hasKeyItem("Deluxe Dildo") < 0, "Req. a vagina and any dildo!");
	}
	addButton(14,"Back",arianHomeMenu);
}

//Give Anal:
//Modified by AnalXP.
//PC must have a cock that fits (cock area 50 or less)
private function giveArianAnal():void {
	var x:int = player.cockThatFits(arianCapacity);
	clearOutput();
	arianHealth(3);
	flags[kFLAGS.ARIAN_ANAL_XP] += 10;
	if(flags[kFLAGS.ARIAN_ANAL_XP] >= 100) flags[kFLAGS.ARIAN_ANAL_XP] = 100;
	flags[kFLAGS.ARIAN_VIRGIN] += 1;
	if (arianMF("m", "f") == "f")
		outputText(images.showImage("arianfemale-home-giveArianAnal"));
	else
		outputText(images.showImage("arianmale-home-giveArianAnal"));

	// This breaks the capacity-restriction, but it's a quickfix to make the scene stop crashing in lieu of writing new
	// content to work around the player not being able to call this scene from earlier interactions with Arian.
	if (x == -1)
		x = player.smallestCockIndex();

	outputText("You tell Arian that, if [arian ey]'s willing, you'd like to take [arian em] from behind.");
	//AnalXP < 33
	//Tight, sensitive enough to orgasm. (It hurts... but feels good)
	if(flags[kFLAGS.ARIAN_ANAL_XP] < 33) {
		outputText("\n\n[arian Ey] fidgets, biting [arian eir] lower lip.  \"<i>I... okay.  J - Just be gentle, ok?  I'm still tight back there.</i>\"  [arian Ey] hesitantly rolls onto [arian eir] hands and knees, lifting [arian eir] tail out of the way to give you a glimpse of [arian eir] puckered hole.");
		outputText("\n\nYou promise Arian that you will, sidling yourself onto [arian eir] bed behind [arian em].  You reach out with one hand and stroke the base of [arian eir] tail, gently admiring its cool, smooth-textured surface before running your hand down to rub across [arian eir] asscheeks.  Mmm... [arian ey] has a very nice ass, you tell [arian em], groping [arian em] in an effort to display your admiration for the lush, full, surprisingly soft cheeks.  Yes, for someone who was born male, [arian ey] truly has a wonderful ass, so deliciously full and round and soft.");
		//(if ArianVagina < 1)
		if(flags[kFLAGS.ARIAN_VAGINA] < 1) {
			outputText("\n\n\"<i>I - I can't help it, I was born this way... that isn't a bad thing is it?</i>\" Arian asks, fidgeting and shuddering as you stroke [arian eir] behind.  From [arian eir] tone, it's clear that [arian ey]'s torn between being flattered and being embarrassed at your evident approval of [arian eir] butt.  You don't bother answering [arian eir] question, instead you just firmly grip [arian eir] scaly buttcheek, eliciting a gasp from the flustered lizan.");
		}
		else {
			outputText("\n\n\"<i>Y - Yes... I was born like this... and being a ");
			if(flags[kFLAGS.ARIAN_COCK_SIZE] == 0) outputText("girl");
			else outputText("herm");
			outputText(" isn't going to make it any smaller either.</i>\"  Arian fidgets and shudders as you stroke [arian eir] behind.");
		}
		outputText("\n\nYou tell [arian em] that you don't know why [arian ey] was born with it, but you certainly appreciate it.  Your wandering eyes close in on ");
		if(flags[kFLAGS.ARIAN_VAGINA] > 0) {
			outputText("the puffy lips of [arian eir] drooling vagina");
			if(flags[kFLAGS.ARIAN_COCK_SIZE] > 0) outputText(" and ");
		}
		if(flags[kFLAGS.ARIAN_COCK_SIZE] > 0) {
			outputText(arianMF("his","her") + " erecting ");
			if(flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText("pair of reptilian pricks");
			else outputText("reptilian prick");
		}
		outputText(".  Oh, someone's excited about this.  Why, you almost half-expected [arian eir] ass to start drooling like a pussy, [arian ey]'s obviously that turned on by the idea of you fucking [arian eir] ass.  You emphasize your point by gently worming one probing finger into the virgin-like tightness of [arian eir] anus.  Wow, [arian ey]'s so tight....");

		outputText("\n\n\"<i>Ow!  B-be gentle... please,</i>\" Arian protests, but despite that you feel [arian em] gently pushing against your intruding digit.  You tell [arian em] that you'll try, but [arian ey] is making this hard on you; [arian ey]'s so eager for you to start fucking [arian eir] ass, isn't [arian ey]?  It's hard to control yourself when [arian ey]'s just begging for it.  You gently grind your [cock] under the base of [arian eir] tail, in between [arian eir] girly asscheeks, to emphasize your point.");

		outputText("\n\n\"<i>I... yes....  I-I want it, too.  It's going to hurt, but I want it.... I-I want you to do it,</i>\" Arian admits, burying [arian eir] face in the covers in an attempt to hide [arian eir] shameless admission.  [arian Ey] braces [arian em]self, holding [arian eir] pillow tightly in [arian eir] clawed hands and bracing [arian em]self for the next step.");

		outputText("\n\nYou begin jerking yourself off, using slow, careful strokes to bring precum dribbling from your cock, smearing it across your shaft in an effort to lube it for your lizan lover.  Finally deciding you've made yourself slick enough, unable to resist making your move, you take hold of [arian eir] butt for support and begin pushing your " + cockDescript(x) + " against [arian eir] virginal back door.  Arian lets out a girly yelp and [arian eir] sphincter suddenly clenches up, halting your entry.  You ask what's wrong.");
		outputText("\n\n\"<i>N-nothing... you just surprised me... that's all.</i>\"  Even though [arian ey]'s not admitting it, you can tell that Arian is very tense.  You lean over the nervous lizan and envelop [arian em] in a soft hug, telling [arian em] it's okay; you're not going to hurt [arian em], you're going to make [arian em] feel very good, but first [arian ey] needs to relax or this will be painful when it shouldn't be.");

		outputText("\n\nArian sighs and relaxes, loosening [arian eir] sphincter enough to allow an easier penetration.  You don't risk delaying any more and promptly, but carefully, slide yourself into [arian em] before [arian ey] can tense up again.  Damn, but [arian ey]'s so tight back here!  You have to push hard to make any progress, and it takes a lot of care to ensure you don't hurt the lizan in your press to penetrate [arian eir] bowels.  \"<i>Ah!  It's in!</i>\"  Arian shudders, struggling to remain relaxed while you plow into [arian eir] depths.  Finally, after a few more careful thrusts, you feel yourself bottom out in your shuddering lizan lover.");

		outputText("\n\nArian trembles and moans in pained pleasure as [arian ey] finally feels your [hips] resting flush against [arian eir] backside.  [arian Ey] pants in obvious pleasure as [arian eir] watertight little rosebud adjusts to your girth and length.  \"<i>H-how does it feel?  G-good?</i>\"");

		outputText("\n\nYou tell [arian em] that it feels wonderful; [arian ey]'s so tight and firm back here... to be honest, [arian ey]'s almost too tight; you can feel [arian eir] heartbeat with every involuntary contraction of [arian eir] anal walls, squeezing your cock like it's trying to wring it off and swallow it.  Arian chuckles.  \"<i>I'm not going to lie, [name].  It hurts, but it also feels good.  I think... maybe you should start moving?</i>\"");

		outputText("\n\nOh, and suddenly [arian ey]'s an expert on this, hmm?  You agree [arian ey] has a point.  You start to withdraw yourself from [arian em], fighting against the squeezing walls and intense suction all the way, then painstakingly pushing yourself back in, worming your way in inch by inch until you have plunged yourself all the way into [arian eir] depths, only to start again.  Arian moans and groans with each movement.  \"<i>It's starting to feel good now... really good.  Don't stop.</i>\"");

		outputText("\n\nTime fades away as you continue to squeeze your shaft in and out of Arian's tight, delicious little ass.  Soon - all too soon - the unmistakable feeling of orgasm starts boiling up from " + (player.balls == 0 ? "the base of your cock" : "the bottom of your balls") + "");
		outputText(" and you warn Arian that you're going to cum inside [arian em] if you keep going.  [arian Ey] drools in pained pleasure, for a moment you wonder if [arian ey] even heard you.  \"<i>Cum.  Cum inside me.  I want it... all of it! Ah!</i>\"");

		outputText("\n\nYou groan and cry out as you promptly fulfill [arian eir] request.");

		//(Low Cum Amount)
		if(player.cumQ() < 250) {
			outputText("\n\nEven though your load might pale in comparison to other creatures native to Mareth, you have no doubt that you're more than enough to fill Arian's tight ass flush with cum.  You unload inside [arian em] with short, controlled thrusts.");
		}
		//(Medium Cum Amount)
		else if(player.cumQ() < 1000) {
			outputText("\n\nYou begin dumping your prodigious amount of cum inside your willing lizan lover.  The more you unload into [arian eir] tight ass the more pleasurable [arian eir] slick muscle spasms feel, milking you for more and more cum, such a lewd little hole, this puckered rosebud of Arian's.  You sigh as [arian eir] belly inflates and some of your spent seed begins dripping from around Arian's little hole.");
		}
		//(High Cum Amount)
		else {
			outputText("\n\nFor a moment you hesitate....  Arian is clearly inexperienced and you know your load is nothing if not enormous; you worry if the inexperienced lizan will be able to handle you, but your worries are soon forgotten; it's much too late to worry about it now.  Your spunk jets inside the moaning lizan like a fire hose, dowsing both your and [arian eir] flames of lust with its immense output of white, creamy goodness.  [arian Eir]'s belly protrudes like a gravid woman's belly - no, actually, it's even wider, and yet the lizan's lewd little hole never tires as it milks you, even though by now Arian is beyond full - copious amounts of cum leak from around your " + cockDescript(x) + " as [arian eir] ass fails to contain it all.");
		}
		outputText("\n\nYour orgasm triggers the lizan's own, and [arian ey] bites into the pillow, groaning with ecstasy as [arian ey] cums [arian em]self, ");
		if(flags[kFLAGS.ARIAN_COCK_SIZE] > 0) outputText("spewing forth large gobs of cum of [arian eir] own " + (flags[kFLAGS.ARIAN_VAGINA] > 0 ? "and " : ""));
		if(flags[kFLAGS.ARIAN_VAGINA] > 0) outputText("wetting both your and [arian eir] legs with a healthy serving of lizan pussy juice");
		outputText(".  You shudder and gasp until, utterly spent, you can't resist sinking down atop Arian and bearing [arian em] into the comforting embrace of the bed.  You lay there, recovering your strength from your most delightful exertions, wriggling to give the lizan a proper snuggling while you lay there.");

		outputText("\n\nArian pants tiredly.  \"<i>[name], was I any good?</i>\" [arian ey] asks hopefully.");

		outputText("\n\nYou tell [arian em] that [arian ey] was wonderful, though you can't resist a wry smirk and a note that [arian ey] was wonderful for an amateur.  With a little practice though, well....");

		outputText("\n\nArian turns [arian eir] head to look at you with a tired, but happy smile.  \"<i>I'm glad you liked it.  It hurt, and I'll probably be sore later.... But it was worth it.  I liked it....</i>\"  Then [arian ey] laughs.  \"<i>If all I need is some practice, I'm hoping you will help me with that?</i>\"");

		outputText("\n\nYou laugh and reply that you'll consider it, but right now you're quite sated, thank you.  \"<i>Great....</i>\"  Arian's maw opens into a huge, lazy yawn.  \"<i>I think I'll take a nap now....</i>\"");
		outputText("\n\nYou pat the lizan playfully on the head and tell [arian em] to get some rest.  You watch as [arian ey] settles down to sleep off the excitement of your sex, then carefully redress yourself and leave [arian em] to rest.");
		//PC returns to camp menu
	}
	//AnalXP < 66
	//Loose, sensitive enough to make Arian scream in pleasure. (It's like a tight vagina, feels like one too, minor pain)
	else if(flags[kFLAGS.ARIAN_ANAL_XP] < 66) {
		outputText("\n\n[arian Ey] fidgets, smiling at you nervously.  \"<i>Okay, but don't be too rough.  I might have gotten a bit used to it, but you're still capable of giving me quite a stretch.</i>\"  Arian rolls onto [arian eir] hands and knees, tail waving excitedly as you catch a glimpse of [arian eir] stretched hole.  [arian Ey] looks back at you, shooting you [arian eir] best seductive look and wiggling [arian eir] hips side to side.");
		outputText("\n\nYou smile at [arian em] and gently stroke [arian eir] swaying tail.  [arian Ey] sighs and lays down on the bed, reaching behind with [arian eir] hands to spread [arian eir] buttcheeks apart for you; [arian eir] tail strokes your side lovingly.  You reach your hands down and gently bat Arian's away, then begin to caress [arian eir] luxurious ass, even as you tell [arian em] that [arian ey]'s got a very sexy rear and you're going to enjoy fucking [arian eir] back passage oh so very much.");
		outputText("\n\nArian raises [arian eir] behind, giving you better access, then looks at you with a glimmer in [arian eir] eyes.  \"<i>I'm going to enjoy this, too.</i>\"");

		outputText("\n\nYou slick your fingers up with some saliva, noisily smacking your tongue around the digits to make it as lewd as possible, and then gently start to probe at Arian's black pucker, seeking entry in an effort to gauge how stretched [arian ey] is.  Your digits slide in easily enough, meeting only a token resistance as you slowly invade [arian eir] bowels.\n\n\"<i>Ah... this feels good....</i>\"\n\nYou raise an eyebrow, though you know [arian ey] can't really see you from this position, and ask if [arian ey]'s really getting to be such a buttslut that even this feels good?");
		outputText("\n\nArian turns as much as [arian ey] can to look at you.  \"<i>Lizan females have assholes that are as sensitive as vaginas to accommodate their mate's dual penises.</i>\"  [arian Ey] stops [arian eir] explanation momentarily to moan in pleasure as you begin stroking [arian eir] insides.");
		//(if ArianVagina < 1)
		if(flags[kFLAGS.ARIAN_VAGINA] < 1) {
			outputText("\n\n\"<i>This shouldn't apply to me, since I'm male.  Ah!  But I guess I'm starting to develop some sensitivity back there.  It really feels good... hmm....</i>\"");
			outputText("\n\nYou smile and comment that you wouldn't be surprised; if it's natural for [arian eir] kind to enjoy taking it up the ass, well, it makes sense that a male would quickly grow to like it, too... especially with all the practice the two of you have been doing....");
		}
		else {
			outputText("\n\n\"<i>This didn't apply to me, since I was originally male.  Ah!  B-but I guess since I'm a girl now, I'm starting to develop some sensitivity back there.  It really feels good....  Hmm....</i>\"");
			outputText("\n\nYou smile and comment that since [arian ey]'s a " + arianMF("maleherm","girl") + " now, should [arian eir] ass have gotten the sensitivity boost by default if that's the case?");
			outputText("\n\n\"<i>I don't know... maybe so... but ");
			if (flags[kFLAGS.ARIAN_BREASTS] < 1) {
				outputText("with transformatives, you never know,</i>\" Arian replies, lifting [arian em]self off the matress, exposing [arian eir] flat chest. \"<i>After all, until we used the Reducto, it gave me boobs too!</i>\"");
				outputText("\n\nYou can't resist sneaking a rub of [arian eir] flat chest, admitting that that was a surprising change. Arian gasps and drops chest-first onto the bed. \"<i>It's still sensitive, too.</i>\"");
			}
			else {
				outputText(" then again, lizan females don't have these either,</i>\"  Arian replies, lifting [arian em]self off the mattress to show you [arian eir]");
				if(flags[kFLAGS.ARIAN_BREASTS] == 1) outputText(" perky");
				else if(flags[kFLAGS.ARIAN_BREASTS] == 2) outputText(" rounded");
				else outputText(" pillowy");
				outputText(" mounds.");
				outputText("\n\nYou can't resist sneaking an admiring grope of the lizan's presented bosom, admitting that gaining breasts in exchange for anal affinity sounds like a fair trade, but you aren't complaining about Arian's bust either.  Arian gasps and drops chest-first onto the bed.  \"<i>They are sensitive, too.</i>\"  Arian smiles nervously at you.");
			}
		}
		outputText("\n\nYou sneak a probing hand under and up between Arian's legs.  Oh, ho!  You grin as");
		if(flags[kFLAGS.ARIAN_COCK_SIZE] > 0) {
			outputText(" a");
			if(flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText(" pair of dripping cocks");
			else outputText(" dripping cock");
			if(flags[kFLAGS.ARIAN_VAGINA] > 0) outputText(" and");
		}
		if(flags[kFLAGS.ARIAN_VAGINA] > 0) outputText(" a sopping wet pussy");
		outputText(" greet");
		if((flags[kFLAGS.ARIAN_VAGINA] == 0 && flags[kFLAGS.ARIAN_DOUBLE_COCK] == 0) || (flags[kFLAGS.ARIAN_VAGINA] == 1 && flags[kFLAGS.ARIAN_COCK_SIZE] == 0)) outputText("s");
		outputText(" your touch.  What a little slut [arian ey] is turning into; [arian ey]'s already raring to go, and even knowing it's going to be [arian eir] ass that's getting fucked, too!");

		outputText("\n\nArian pants and moans.  \"<i>[name], please. Stop teasing me.  I want you.</i>\"  [arian Ey] looks back at you with eyes full of desire.  [arian Ey] humps against your intruding fingers in [arian eir] ass in obvious excitement.");

		outputText("\n\nWell, if [arian ey]'s that eager to get started....  You deliver a playful slap on [arian eir] ass, which ripples delightfully at the impact and sends a crack echoing through the lizan's ");
		if(arianFollower()) outputText("tent");
		else outputText("bedchamber");
		outputText(".  You sink your fingers into the smoothly scaled skin of [arian eir] butt, and promptly thrust your " + cockDescript(x) + " into [arian eir] back passage; not with the gentleness you showed Arian as an anal virgin, but not with brutal force, either.  The practice the lizan's had with pleasuring your cock with [arian eir] ass is obvious - you slide in as if it's been lubed, with what little resistance it poses quickly giving way under the insistent pressure of your thrusts.  It's not as painfully tight as it was, the looseness letting you move more freely without fear of hurting your lover, but at the same time it grips you like a well-trained pussy, holding you deliciously tight and eagerly sucking you into its depths.");

		outputText("\n\nArian moans lewdly at your intrusion.  \"<i>Ah, I can feel you inside me.  I love this feeling... so full....  Do you like my ass, [name]?  Does it feel good when you use me like this?</i>\"");

		outputText("\n\nYes, you hiss, yes it feels good... does [arian ey] really enjoy this so much?  You never stop your thrusts, relentlessly pounding into [arian eir] greedy little ");
		if(flags[kFLAGS.ARIAN_VAGINA] < 1) outputText("boypussy");
		else outputText("nether-pussy");
		outputText(".  \"<i>Yesssss.... Oh, sometimes it hurts a bit, but the feeling, the pleasure, the pain.... It's heavenly.</i>\"");
		outputText("\n\nSmiling wryly, you lean over Arian's back and whisper into [arian eir] ear, that if [arian ey] likes this so much... you'll just have to fuck [arian em] more.  Having said that, you quicken your pace, drawing a pleasured, shuddering moan from your lizan lover.  \"<i>Ah!  [name]!  If you keep this up you're going to make me - Ah!</i>\"  Make [arian em] what now?  \"<i>C-cuuuuum~</i>\"");

		outputText("\n\nArian's ass tightens around your " + cockDescript(x) + " as [arian eir] ");
		if(flags[kFLAGS.ARIAN_COCK_SIZE] > 0) {
			if(flags[kFLAGS.ARIAN_DOUBLE_COCK] == 0) outputText("cock spews its load");
			else outputText("twin cocks spew their loads");
			outputText(" on the bedsheets");
			if(flags[kFLAGS.ARIAN_VAGINA] > 0) outputText(" and [arian eir] ");
		}
		if(flags[kFLAGS.ARIAN_VAGINA] > 0) outputText("contracting pussy paints your lower body with lizan femcum");
		outputText(". Arian is only capable of moaning and shuddering as [arian eir] powerful orgasm rocks the poor lizan to [arian eir] core.  The extra tightness of [arian eir] contracting butthole increases the friction on your " + cockDescript(x) + ", pushing you ever closer to the climax.");

		outputText("\n\nSeeing no point in holding back yourself, you cry out as you give yourself over to the feeling of climax, orgasm ripping its way through you from the ");
		if(player.balls == 0) outputText("base of your spine");
		else outputText("depths of your balls");
		outputText(".  Arian, completely blissed out, lays limply on [arian eir] bed, [arian eir] butt held up by your gripping hands.  With a final deep thrust you finally go over the edge.");

		//(Low Cum Amount)
		if(player.cumQ() < 250) outputText("\n\nYou pump [arian eir] insides with as much cum as you can muster, filling [arian em] with your liquid love while the lizan gasps, moans, and grips you tightly with [arian eir] distended sphincter.  You are quickly spent though, and after a couple more tugs, you feel the lizan's contracting rosebud relax to let you pull out of [arian eir] depths.");
		//(Medium Cum Amount)
		else if(player.cumQ() < 1000) outputText("\n\n[arian Eir] butt feels so good that you can't help but paint it in white.  Gob after gob of searing hot cum flows from your " + player.cockHead(x) + " and into the lizan's willing bowels.  You can't help but continue thrusting inside [arian eir] deliciously slick insides, even as [arian eir] distended sphincter tries its best to hold you in place.  By the time you're done, Arian looks like [arian ey]'s three months pregnant; after a few final thrusts, you're confident you've given [arian em] all that you can muster for the moment and pull out of the lizan's hungry ass.");
		//(High Cum Amount)
		else {
			outputText("\n\nYou bury yourself as deep as you can into the lizan's behind and brace yourself, holding onto [arian eir] hips as the first of many jets of cum finally escapes your throbbing " + cockDescript(x) + ".  You can feel the groaning lizan shudder with each blast that you pump into [arian eir] inviting interior; each of your sticky ropes of cum filling [arian em] up until [arian eir] belly looks as big as a beach ball.  Arian's contracted sphincter tries its best to hold your prodigious load in, but it can't hope to contain it all; soon white jism explodes from around the seal of your cock.  Trails of your pleasure run down the lizan's legs to soak the bedsheets along with the lizan's own fluids.  One final jet pushes Arian off your shaft, and you gaze at the messy results of your recent activities.");
		}

		outputText("\n\nFor a moment you admire your handiwork, but all too soon the exhaustion of your recent tryst catches up to you and you collapse atop the lizan, almost as blissed out as [arian ey] is....");

		outputText("\n\n\"<i>That... that was the best, [name].  I never hoped that sex could feel this good,</i>\" Arian remarks between pants. [arian Ey] rolls around, looking at you with a smiling face, then yawns widely, displaying [arian eir] sharp teeth to you. \"<i>So sleepy... could use a nap now....</i>\"");

		outputText("\n\nYou smile and pet the lizan's head, telling [arian em] that you wish you could understand how a talking lizard could be just so adorable.  You watch [arian em] as [arian ey] drifts off to sleep, then quietly slide from [arian eir] bed, get dressed and leave the ");
		if(!arianFollower()) outputText("room");
		else outputText("tent");
		outputText(".");
	}
	//AnalXP <= 100
	//Very Loose, sensitive enough to make Arian cum just from insertion. (Feels better than anything else. Yep, Arian really becomes a buttslut at this point)
	else {
		outputText("\n\n[arian Ey] fidgets and moans as [arian ey] eagerly rolls onto [arian eir] hands and knees, lifting [arian eir] tail out of the way and spreading [arian eir] cheeks to give you a glimpse of [arian eir] throbbing, loose, puckered hole.  Arian pants and looks back at you in excitement.  \"<i>I'm all ready for you, [name].  Just go ahead and fill me up.</i>\"  [arian Ey] grins at you.  It's clear to see that Arian likes the idea of being taken, but there really is no need to rush... you'd rather savor this, plus teasing your eager lizan lover is always a bonus.");

		outputText("\n\nYou smirk fiercely and ask teasingly if this is really the proud, independent mage Arian lying before you with [arian eir] tail in the air and [arian eir] ass up, a buttslut yearning and anxious to be fucked like an animal.  Arian looks back at you, pleadingly.  \"<i>Aww, come on, don't tease me.  Can't you see how much I need this?</i>\"");

		outputText("\n\nHow much does [arian ey] need it, you ask?  Enough to beg for it, like the little buttslut [arian ey] is, hmm?  If [arian ey] can convince you [arian ey] wants it enough, you'll give it to [arian em], you tell [arian em].  Arian's tail encircles your waist, and pulls you towards [arian eir] quivering rosebud.  \"<i>Come on... fill me up.  I'm so hot it feels like I'm on fire!  Fill me up, please?</i>\"");

		outputText("\n\nWhat a naughty, naughty little buttslut [arian ey] is, you croon, and deliver a playful slap to [arian eir] ass, before squeezing the luscious round buttock, fingers creeping into [arian eir] crevice to probe at [arian eir] back passage.  To your surprise, the slight pressure you're exerting makes [arian eir] orifice ripple and flex; [arian ey]'s trained [arian eir] ass so well [arian ey] can even try to deliberately grab you with it and suck you in.");

		outputText("\n\nArian moans and bucks against your fingers, eager to get more of you inside.  \"<i>Ah... yessss... more...</i>\"  [arian Ey] groans.  Looking under [arian em], you can see that [arian eir] ");
		if(flags[kFLAGS.ARIAN_VAGINA] > 0) outputText("wet gash is positively leaking lizan juices");
		if(flags[kFLAGS.ARIAN_VAGINA] > 0 && flags[kFLAGS.ARIAN_COCK_SIZE] > 0) outputText(" and [arian eir] ");
		if(flags[kFLAGS.ARIAN_COCK_SIZE] > 0) outputText("erect cock is already leaking pre like a sieve");
		outputText(".  You can hardly believe how far Arian has come; you ask [arian em] if it really feels that good?  \"<i>More than you can... ah... imagine, now fill me up!</i>\" [arian ey] demands with a sense of urgency.");

		outputText("\n\nSeeing no reason to delay any longer, and figuring [arian ey] must be well-trained enough now that you don't need to be gentle, you promptly extract your fingers from the lizan's greedy ass and then slam your shaft home in one fierce thrust, asking if this is what [arian ey] wanted.");

		outputText("\n\nArian gasps and opens [arian eir] maw in a silent scream.  [arian Eir] ass contracts, milking you; ");
		if(flags[kFLAGS.ARIAN_VAGINA] > 0) {
			outputText("[arian eir] pussy clenches, spilling a flood of juices; ");
			if(flags[kFLAGS.ARIAN_COCK_SIZE] > 0) outputText(" and ");
		}
		if(flags[kFLAGS.ARIAN_COCK_SIZE] > 0) outputText("his cock throbs and shoots rope after rope of cum onto the bedsheets");
		outputText(". Overwhelmed by your sudden intrusion, Arian collapses forward, burying [arian eir] face on [arian eir] pillow and dragging you on top of [arian em].  \"<i>Ah... [name], you feel so good.  It's amazing.  I never thought buttsex could ever feel this good.</i>\"");

		outputText("\n\nYou almost blink in surprise; you were just throwing the term buttslut around as a joke, you didn't think Arian was really like that.  Still, there are far more important matters - like digging your way into the depths of [arian eir] greedy little ass with your " + cockDescript(x) + "!  You squeeze the lizan's scaly butt and begin to rut [arian em] like an animal, thrusting your way in and out of [arian eir] back passage with all the eagerness you can muster.");

		outputText("\n\n[arian Ey] screams in pleasure, muffled by [arian eir] pillow.  [arian Eir] ass strives to pull you in as far as you can go, contracting, milking, gripping; even though Arian's just climaxed, you can see [arian eir] ");
		if(flags[kFLAGS.ARIAN_COCK_SIZE] > 0) {
			if(flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText("cocks are");
			else outputText("cock is");
			outputText(" still rock hard, and surprisingly, still leaking ropes of cum");
			if(flags[kFLAGS.ARIAN_VAGINA] > 0) outputText(", and [arian eir] ");
		}
		if(flags[kFLAGS.ARIAN_VAGINA] > 0) outputText("pussy squirting juices against your [legs] with each shuddering impact of your [hips]");
		outputText(". \"<i>Ah! Yes! More, give me more! Harder! Faster!</i>\" Arian pleads, before biting on [arian eir] pillow in pleasure.");

		outputText("\n\nYou see no reason not to give it to [arian em] how [arian ey] wants, and keep thrusting - it's surprisingly difficult to pull out, though, as the lizan's hungry nethers keep trying to stubbornly hold you in.  Greedily [arian eir] inner walls ripple and flex, caressing and squeezing in an effort to milk you into giving up your precious seed.");

		outputText("\n\nYou can feel the pressure on [arian eir] sphincter increasing and guess Arian must be close to another orgasm; you're not very far yourself, and if [arian ey] keeps squeezing and massaging your " + cockDescript(x) + " like this, you feel you'll blow any moment now.  Before you finally reach the inevitable abyss of your orgasm, you decide to lean over [arian em], hugging [arian eir] midriff just so you can pound [arian em] harder.  It's surprising that Arian only seems to be feeling pleasure, others would be screaming in pain with how rough you're being, yet [arian ey] bucks back against you with all [arian eir] might, trying to get you deeper.  You ask [arian em] if [arian ey]'s really okay, if it doesn't hurt [arian em] even a bit?");

		outputText("\n\n\"<i>No! Ah, yes!  Cum inside me, [name]!  I need your seed inside my naughty ass.  I need to feel you filling me up, using me like the buttslut I am!  I want to cum with you!</i>\"  You lift a brow, of all the people you know, Arian is the last one you'd expect to hear this from... what would [arian eir] apprentices say if they heard their " + arianMF("master","mistress") + " begging to be used like that?  \"<i>Ah... I don't care, just fill me up with your hot, slimy spunk!</i>\"  It would seem the lizan mage is too far gone to give you a straight answer.  You'll have to talk to [arian em] after this.");

		outputText("\n\nWith that in mind, you give yourself over to the pleasures of your reptilian lover and [arian eir] naughty little ass, allowing the building orgasm to finally reach its climax and boil from your body in a gush of salty spooge.");

		//(Low Cum amount)
		if(player.cumQ() < 250) {
			outputText("\n\nYou spill your load, deep into Arian's bowels, [arian eir] ass working overtime to ensure not even a single drop of seed is left in you.  \"<i>Ah!  I can feel it!  Yes!</i>\"  [arian Ey] screams, in ecstasy.  Gob after gob of cum travels down your urethra and into Arian's blooming rosebud, you almost feel bad when you run dry and are unable to give [arian em] anymore; even as [arian eir] ass continues to impatiently milk you. \"<i>...Aww. No more?</i>\" [arian ey] jokes.");
		}
		//(Medium Cum amount)
		else if(player.cumQ() < 1000) {
			outputText("\n\nYou dig deep into [arian eir] ass, intent on delivering your load as far inside the lizan's slutty ass as you can.  \"<i>Ah!  You feel so good!  Give it to me!  Yesss!</i>\" [arian ey] screams in ecstasy.  You can feel your cum travelling down your urethra, forcing Arian's sphincter to loosen up enough so you can finally cum inside [arian em] with the force of hose.  You reach down to massage the blissed out lizan's belly, feeling it inflate and expand with each potent jet.  By the time you're done, Arian has formed a small pot belly.  \"<i>Already over?  No more?</i>\"  [arian Ey] jokes.  You give [arian em] a wry smile and pound into [arian em] one last time, spilling one last jet into [arian eir] belly.  \"<i>Aaaah, yesss...</i>\"");
		}
		//(High Cum amount)
		else {
			outputText("\n\nYou have no doubt Arian will appreciate your prodigious load, so you make sure to press as deep as you can into [arian eir] ass to ensure [arian ey] will keep it all inside, then finally let your cum flow out of you and into the cock and cum hungry ass, eagerly massaging your shaft.  \"<i>I can feel it!  It's going to be a big one!  Shoot it!</i>\" [arian ey] screams in ecstasy.  You groan and begin dumping obscene amounts of seed into your lizan lover.  The first few jets inflate [arian eir] belly slightly, and you dart a hand to feel it expand with every subsequent blast of sticky jism.  \"<i>So much cum!  So good... more!</i>\"  Arian demands, blissed out by your pumping appendage.  [arian Eir] ass never stops its assault on your " + cockDescript(x) + " intent on massaging you as you orgasm, even as you fill Arian beyond full and some cum begins backflowing out of [arian eir] ass.  \"<i>Hmm, yesss... so full....</i>\"  You pound into [arian em] a few more times, ensuring you spill every last drop of cum.");
		}
		outputText("\n\nPleased and pleasured, Arian holds you still with [arian eir] tail and rolls around on [arian eir] back, your dick still buried inside [arian em].  You gasp with the sudden friction and fall on top of the lizan, just in time to receive a kiss from your lizan lover.  [arian Ey] grips you with both [arian eir] hands and legs, then finally quakes as [arian eir] second orgasm overtakes [arian em].");
		if(flags[kFLAGS.ARIAN_VAGINA] > 0) {
			outputText("  [arian Eir] cunt grips the air and blasts one last jet of wetness at your crotch.");
		}
		if(flags[kFLAGS.ARIAN_COCK_SIZE] > 0) outputText("  [arian Eir] throbbing cock flexes and shoots one last rope of lizan-cum against your belly.");
		outputText("  [arian Eir] ass grips you forcefully, forming a vacuum and finally loosens.  \"<i>That... that wash da best,</i>\"  Arian slurs, before finally collapsing on [arian eir] bed.");

		outputText("\n\nYou find yourself collapsing on top of the collapsed lizan, heaving to regain your breath after such a vigorous fuck.  Finally, you regain sufficient energy to pull yourself free of the absent-minded sucking of [arian eir] ass, which wetly slurps shut afterwards to hold your seed inside.  \"<i>I feel so empty when you're not inside,</i>\" Arian utters tiredly.");

		//(ArianAssChat == 0)
		if(flags[kFLAGS.ARIAN_ASS_CHAT] == 0) {
			outputText("\n\nYou shake your head slowly in disbelief, telling [arian em] [arian ey]'s really let [arian emself] go.  Arian averts [arian eir] gaze in embarrassment.  \"<i>I... sorry.  It's just that it feels so good, and I can't... sorry.</i>\"  [arian Ey] looks away, moving [arian eir] tail into [arian eir] hands. You sigh softly and stroke [arian eir] scaly face, telling him it's not a bad thing that [arian ey] enjoys [arian em]self, it's just you're surprised at how \"<i>into it</i>\" [arian ey] gets.  [arian Ey] doesn't need to debase [arian em]self for you, this is supposed to be good for both of you.");

			outputText("\n\n\"<i>I... I'm not really trying to debase myself.  I guess I lose a bit of control when it comes to anal, because it really feels that good for me.  You're not mad at for being like that... for liking being fucked from behind.  Are you?</i>\"");

			outputText("\n\nYou tell [arian em] you certainly aren't; you were just making sure that [arian ey] was really enjoying [arian em]mself, that [arian ey]'s not under the conception [arian ey] has to act that way for you to do this to [arian em].  Arian breaths a sigh of relief.  \"<i>No, I... sorry if my being like that offends you.  I thought you enjoyed it too, since you were teasing me, but maybe I should change?</i>\"");

			outputText("\n\nYou shake your head; [arian ey] is who [arian ey] is, and you're quite comfortable with it.  If you really didn't enjoy playing with [arian em] like that, well, you'd stop sexing [arian eir] ass, wouldn't you?  Arian bites [arian eir] lower lip and smiles nervously at you. \"<i>So, you like my ass?</i>\"");

			outputText("\n\nYes.  Yes you do, you declare.  \"<i>Good, because I like you in my ass, so I don't have to change?</i>\"");

			outputText("\n\nYou still have to confess it was a shock that someone as respectable as Arian is would get so enthusiastically into anal - and on the receiving end, no less - but you don't want [arian em] to change just for your sake.");

			outputText("\n\n\"<i>This is all new to me.  I'd never been with anyone before you came, so there is no problem if I act like... well, like that?  Because I could change if it really bothers you...</i>\"");

			outputText("\n\nNo, there's nothing about [arian eir] behavior you want to change... besides, you think [arian ey]'s kind of sexy when [arian ey] gets like that.  At that Arian perks up.  \"<i>Really?</i>\"  Yes, really, you reply. [arian Ey] smiles happily at you.  \"<i>So... do you want to go again?</i>\"");

			outputText("\n\nYou chuckle. Not right this moment, no, you tell [arian em]; the two of you just had a pretty intense session, you need a few moments to recover; besides that you have other matters that need your attention.  Arian looks down in disappointment, pouting.  Now, now, there's no need for that, you can always have some fun another time.  \"<i>All right then... see you later?</i>\"  You nod.  \"<i>Ok... I'll be waiting.</i>\"");

			outputText("\n\nYou promptly gather your clothes and quietly make your way ");
			if(!arianFollower()) outputText("back to Tel'Adre's streets, and from there back to camp.");
			else outputText("out of [arian eir] tent.");
			flags[kFLAGS.ARIAN_ASS_CHAT]++;
		}
		else {
			outputText("\n\nYou pat Arian gently on [arian eir] ass and comment playfully that [arian ey] is such an unabashed buttslut, isn't [arian ey]?  Still, did [arian ey] get enough cock up [arian eir] ass for a while?");

			outputText("\n\nArian smiles wryly at you.  \"<i>I guess I've got enough to hold me for a while now, but I could always use another dose.</i>\"");

			outputText("\n\nWell, this greedy little lizard of yours will have to wait until you're ready.  But if [arian ey]'s good, maybe you'll come back later, you tell [arian em], playfully tapping [arian em] on the snout for emphasis.  \"<i>Okay, I'll be waiting.</i>\"  [arian Ey] grins happily.");
			outputText("\n\nSmiling back at [arian em], you gather your clothes and quietly make your way ");
			if(!arianFollower()) outputText("back to Tel'Adre's streets, and from there back to camp.");
			else outputText("out of [arian eir] tent.");
		}
	}
	player.sexReward("no", "Dick");
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
	outputText("You trail your hand down your belly, pondering what to do.  Arian doesn't seem to notice, instead staring with anticipation at your erection.  You idly swing your hips from side to side, and notice with amusement that the lizan seems to follow it.  Building on that train of thought, you ask if [arian ey] would be willing to suck you off.");

	//(if ArianHasBlown == 0)
	if(flags[kFLAGS.ARIAN_HAS_BLOWN] == 0) {
		outputText("\n\nThe lizan averts [arian eir] eyes, snapping out of [arian eir] reverie.");
		if(flags[kFLAGS.ARIAN_COCK_SIZE] == 3) outputText("  You notice Arian's exposed shaft slowly hardening at your invitation.");
		outputText("  \"<i>I... Can I really?</i>\"");

		outputText("\n\nYou smile and note [arian ey] almost sounds eager to do that, though you admonish [arian em] to be careful; it's a sensitive body part and, while you don't doubt [arian eir] affections, that doesn't make [arian eir] teeth any less sharp.");

		outputText("\n\nArian nods eagerly.  \"<i>I promise I will be careful.  I wouldn't dream of hurting you, [name].</i>\"  You nod in return, and tell the lizan that you'll trust [arian em], settling on [arian eir] bed and giving [arian em] full access to what's between your [legs].");
	}
	else {
		outputText("\n\nThe lizan smiles at you and licks [arian eir] lips.  \"<i>I would love to!</i>\" [arian ey] replies eagerly.  You smile and remind [arian em] to be careful with [arian eir] teeth.");

		outputText("\n\nArian acknowledges your concern by nodding emphatically.  \"<i>Sure, I would never hurt you, [name].</i>\"");

		outputText("\n\nSatisfied with [arian eir] reply, tell [arian em] you'll trust [arian em] and settle on [arian eir] bed and giving [arian em] full access to what's between your legs.");
	}

	outputText("\n\nArian rolls on top of you and reaches for your [cock biggest], caressing it almost reverently.  Looking at [arian eir] face, you see [arian em] eyeing your cock up and down, sizing it up.  [arian Ey] looks at you and smiles; then without breaking eye contact [arian ey] extends [arian eir] tongue to lick at your [cockHead biggest] and slowly take your cock in, careful to purse [arian eir] lips so [arian eir] teeth won't hurt you.");

	outputText("\n\nYou shudder in pleasure at the sensation; the interior of [arian eir] mouth is warmer than you expected, but smooth in texture and silky soft.  Something long and wet wriggles around your [cock biggest]; for a heartbeat, you'd almost think it's a slimy snake, but then logic hits and you realize it's Arian's long, prehensile tongue, which [arian ey] is using to coil around and entangle your intruding shaft.");

	outputText("\n\nWith one powerful slurp, [arian ey] coaxes a small jet of pre out of your [cock biggest], which Arian is only too happy to drink down, moaning at the first taste of your seed; this in turn sends wonderful vibrations along your length, coaxing even more pre into [arian eir] hungry maw.");

	//(If ArianHasBlown == 0)
	if(flags[kFLAGS.ARIAN_HAS_BLOWN] == 0) {
		outputText("\n\nAs you gasp in pleasure, you cannot help but wonder when did Arian get so skillful with [arian eir] mouth; you thought [arian ey] said [arian ey] was a virgin before you came along.");
		outputText("\n\nYou ask if Arian's sure [arian ey] was a virgin until [arian ey] met you.");
		outputText("\n\nArian lets go of your cock, kissing its [cockHead biggest] before replying, \"<i>Yes, I'm sure... but I practiced a lot on myself...</i>\"");

		outputText("\n\nOn [arian em]self?!  You blurt out; just how flexible is [arian ey]?!");

		outputText("\n\nArian smiles nervously and bites [arian eir] lower lip.  \"<i>I'm a mage, remember?  There's a lot of things you can do with magic, but this isn't about me, [name].  It's about you... so let me show you what I learned.</i>\" [arian Ey] plants a kiss on your [cockHead biggest] before slowly wrapping around it with [arian eir] tongue and sucking you right back into [arian eir] cock-hungry maw.");

		outputText("\n\nYou moan, agreeing that, yes, this is far more important.");
	}
	else {
		outputText("\n\nAs you gasp in pleasure, you cannot help but ask if Arian's been practicing by [arian emself] while you were away.");
		outputText("\n\n[arian Ey] lets go of your cock, kissing its [cockHead biggest] before replying, \"<i>No, I don't need to practice on myself anymore.  I got you to help with that now, right?</i>\"  Arian plants a kiss on your [cock biggest], before slowly wrapping it around [arian eir] tongue and sucking you right back into [arian eir] cock-hungry maw.");
		outputText("\n\nYou moan and tell [arian em] that as long as [arian ey] keeps giving you great head, you're more than happy to help [arian em] practice.");
	}

	outputText("\n\nYou thrust your [cock biggest] as deeply into the lizan's eager little mouth as [arian ey] will let you... oooh, what would they say, if they could see a proud spellcaster like [arian em] sucking you off like this?");

	outputText("\n\nArian doesn't bother replying, not that [arian ey] could with a mouthful of cock.  [arian Ey] braces [arian em]self on your [hips] and begins truly blowing you; intent on draining you of your seed with strong, wet, slurping sucks that resound from the small cracks of the lizan's maw not filled with your [cock biggest].");

	outputText("\n\nYou groan and gasp and hump the lizan's face for all you're worth.  You can feel the familiar pressure of seed building up deep inside you, sparks of pleasure becoming the budding crescendo of orgasm, and you wonder if you should warn Arian of what's coming...");

	outputText("\n\n[arian Ey] never slows down, even as [arian ey] looks up to you, trying to catch a glimpse of your face to make sure [arian ey]'s pleasuring you well.  When your eyes meet, you swear you can see the lizan mage smiling at you, even thought [arian eir] mouthful of cock prevents you from catching a good glimpse of [arian eir] face.  [arian Ey] moans with delight as you take hold of [arian eir] head and begin guiding [arian em].");

	outputText("\n\nWith a few last huffs and gasps, it finally comes.  Orgasm rips through your flesh and sends your cum cascading from out of your [cock biggest] into Arian's suckling mouth - no point worrying about whether or not [arian ey] wants it in the mouth now, it's here and [arian ey]'ll just have to deal with it.");

	outputText("\n\nArian is surprised when the first jet of cum hits [arian em] straight in [arian eir] throat, but never stops sucking.  Somehow Arian manages to drink your cum as fast as you can pump it into [arian eir] eager maw; by the time you're done, Arian has developed a ");
	if(player.cumQ() < 250) outputText("small");
	else if(player.cumQ() < 1500) outputText("big");
	else outputText("huge");
	outputText(" pot belly. [arian Ey] lets go of your dick with a sigh of pleasure and lays back on the bed.  \"<i>Ah... I'm full.</i>\"");

	outputText("\n\nYou tell [arian em] that [arian ey] looks full");
	if(player.cumQ() >= 1500) outputText(", in fact, you're amazed [arian ey] didn't pop with how much [arian ey] drank");
	outputText("; is [arian ey] sure [arian ey]'s all right?");

	outputText("\n\nArian yawns, revealing [arian eir] toothy maw.  \"<i>Yes, I just need a nap.</i>\"  You chuckle and tell [arian em] that [arian ey] should at least get under the covers.  \"<i>Too... tired to bother.</i>\"  Arian replies with a second yawn.  Seeing no reason not to be gallant, you step forward and help Arian climb to [arian eir] feet");
	if(player.cumQ() >= 1000) outputText(" which, considering the fact [arian ey] looks like a mother ready to birth a toddler from the size of [arian eir] belly, isn't as easy as you'd think");
	outputText(".  Letting the lizan use your shoulder, you pull [arian eir] sheets up and help [arian em] back in the bed, where [arian ey] flops down with a protest of springs");
	if(player.cumQ() >= 250) outputText(", [arian eir] gut audibly sloshing as the cum inside is churned by the impact");
	outputText(".");

	outputText("\n\n\"<i>Thanks, [name].</i>\"  Arian yawns once more and closes [arian eir] eyes.  You smile and give the sleeping lizan an affectionate pat on the head; then dress yourself and make your way");
	if(!arianFollower()) outputText(" back to camp, stopping only to notify Laika and Boon that Arian is sleeping.");
	else outputText(" out of Arian's tent.");
	player.sexReward("saliva","Dick");
	flags[kFLAGS.ARIAN_HAS_BLOWN]++;
	doNext(camp.returnToCampUseOneHour);
}

//Penetrate:
//Arian must be herm/female.
//PC must have a cock that fits (cock area 50 or less)
private function penetrateArian():void {
	var x:int = player.cockThatFits(arianCapacity);
	if(x < 0) x = player.smallestCockIndex();
	clearOutput();
	flags[kFLAGS.ARIAN_VIRGIN] += 1;
	arianHealth(3);

	outputText(images.showImage("arianfemale-home-penetrate"));
	outputText("You admire the transgendered lizan's body, from [arian eir] feminized features, down past [arian eir] [arian chest], all the way to [arian eir] shapely thighs.  You tell Arian that the change looks very good on [arian em]; few boys would really be so naturally pretty when turned into a ");
	if(flags[kFLAGS.ARIAN_COCK_SIZE] > 0) outputText(arianMF("maleherm.", "dickgirl."));
	else outputText("girl.");

	outputText("\n\nArian smiles and averts [arian eir] eyes, rubbing one arm.  \"<i>You really think so?</i>\"  [arian Ey] bites [arian eir] lower lip in nervousness.");

	outputText("\n\nYou nod your head, insisting that you do think so.  With a lustful purr, you ask just how [arian ey] would like to try out [arian eir] girl parts, maybe see just how pretty [arian ey] can feel with the right... encouragement?");

	outputText("\n\n\"<i>Of course!  I would love it.  So what should I do?</i>\" [arian ey] asks, tail waving lazily behind [arian em] as [arian ey] awaits further instructions.  \"<i>Should I help you get ready first?</i>\"  [arian Ey] looks down between your legs to see your half-erect cock");
	if(player.cockTotal() > 1) outputText("s");
	outputText(".  \"<i>Err... readier?</i>\"  [arian ey] asks, smiling nervously.");

	outputText("\n\nYou smile, and tell [arian em] that, seeing as how this is fairly new to [arian em], you'll try and let [arian em] take charge.  You sashay over to [arian eir] bed and lay down on your back, [eachCock] jutting proudly into the air, before telling Arian you want [arian em] to straddle you.");

	outputText("\n\n[arian Ey] nods, [arian eir] liquid lust dropping over your [legs] as [arian ey] straddles you");
	if(flags[kFLAGS.ARIAN_COCK_SIZE] == 3) {
		outputText(", [arian eir] exposed cock");
		if(flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText("s");
		outputText(" hardening at what [arian ey]'s about to do");
	}
	else if(flags[kFLAGS.ARIAN_COCK_SIZE] > 0) {
		outputText(", [arian eir] bulbous cock");
		if(flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText("s peeking out of their");
		else outputText(" peeking out of its");
		outputText(" hiding place, already at full mast in anticipation");
	}
	outputText(".  Arian swallows audibly.  \"<i>What now?</i>\" [arian ey] asks, already panting in lust.");

	outputText("\n\nYou gently reach up and take hold of the lizan's hips, telling [arian em] that first, you need to connect, slowly guiding [arian em] down, feeling [arian eir] all-too-human folds parting around the tip of your cock.");

	outputText("\n\nArian moans and tries to speed things up by impaling herself on [oneCock], but the pleasure of the insertion makes [arian em] lose [arian eir] balance and [arian ey] falls face down on your [chest].  \"<i>Ah!  S-sorry!</i>\"  [arian Ey] smiles nervously at you.");

	outputText("\n\nYou smile at [arian em] and pat [arian em] on the cheek, telling [arian em] to take it easy; there's no need to rush this.  With painstaking deliberation, you continue gently inserting yourself into the ");
	if(flags[kFLAGS.ARIAN_COCK_SIZE] == 0) outputText("female");
	else outputText("herm");
	outputText(" lizan, until you have managed to hilt yourself inside of [arian em].");

	outputText("\n\nArian shudders, rubbing [arian eir] stretched pussy lips against your groin.  \"<i>This feels so good.  I never thought I'd ever feel something like this.  Your cock is filling me up, and I love it.  I can feel everything... every little twitch, every little vein, the texture... everything.</i>\"");

	outputText("\n\nYou whisper to [arian em] that the best is yet to come, and then start to slowly buck your hips up and down, gradually increasing the tempo, murmuring in pleasure as you feel [arian eir] slick, wet netherlips hungrily kissing you in response.");

	outputText("\n\nArian moans throatily, gyrating [arian eir] hips against your intruding shaft, until [arian ey] starts to slowly rise and fall, trying [arian eir] best to keep up with your rhythm.  \"<i>So wet... I'm so wet, and the sounds!  I feel so hot... sexy... wanted.  Oh, [name] fuck me!  Take me!</i>\" [arian ey] says, supporting [arian em]self on either side of your head, looking down at you with half-lidded, lust-driven eyes, panting hotly down at you as [arian ey] bucks [arian eir] hips against your thrusts.");
	if(flags[kFLAGS.ARIAN_COCK_SIZE] > 0) {
		outputText("  [arian Eir] ");
		if(flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText("twin shafts");
		else outputText("shaft");
		outputText(" bobs just out of your field of vision, leaking pre all over your belly.");
	}
	outputText("\n\nYou smile at the lizan, who is clearly adjusting to [arian eir] new gender with aplomb, and procede to pick up the pace, trying to match the increasing tempo of [arian eir] thrusts and ensure [arian ey] enjoys [arian em]self as much as possible.  It's no sacrifice, after all, especially given the way [arian eir] cunt is sucking hungrily on your cock, grinding with walls that ripple harder and harder as you thrust into [arian em] more and more vigorously.");

	if (flags[kFLAGS.ARIAN_BREASTS] > 0) outputText("\n\nArian smiles down at you, licking [arian eir] lips.  \"<i>[name], please,</i>\" [arian ey] moans throatily, half to show [arian ey]'s paying attention, half from pleasure. \"<i>My breasts... please?</i>\"  [arian Ey] asks, panting, never stopping [arian eir] bucking against you.");
	outputText("\n\nYou unthinkingly reach up and take the lizan's [arian chestAdj] bosom in your hands, caressing the small, cherry-like nubs of [arian eir] nipples, caressing the so-so-smooth scales that cover it, creating a texture at once alien and erotic.  Arian sighs in pleasure as you continue to massage [arian eir] breasts.  \"<i>Do you like them?  My breasts?  Does it feel weird that I have breasts, despite being a lizan?</i>\"  You hoarsely whisper to [arian eir] that you love them, and while it was strange at first, there's certainly many odder things about this world, and you think they're part of [arian eir] natural charms.");

	outputText("\n\nArian moans appreciatively and grinds [arian eir] hips against you.  \"<i>I'm so happy to hear you say that; you really know how to make a girl feel appreciated.</i>\"  You note that it feels a little strange to hear Arian so easily referring to \"<i>herself</i>\" as a girl.  Arian fidgets and averts [arian eir] eyes.  \"<i>I-I can't help it.  When you're buried in my pussy I just... feel girly - pretty.</i>\"  That might be because [arian ey] is so very pretty, you can't resist saying, even as you continue to thrust into [arian em].  \"<i>Oh [name]... F-fuck me.  Make me feel beautiful!  Make me cum!  I want you to fuck me as hard as you can.  Please....</i>\"");

	outputText("\n\nYou promise [arian em] you will, but with [arian em] on top, you can't really exert that much control.  Swinging [arian eir] tail to the side along with [arian eir] body, Arian quickly rolls over, never breaking contact, nor stopping bucking against you, even as [arian eir] legs close behind you and [arian ey] loops [arian eir] arms around your neck.  [arian Ey] looks up at you, panting, with half-lidded eyes, then [arian ey] smiles.  \"<i>What about now?</i>\"");
	if(flags[kFLAGS.ARIAN_COCK_SIZE] > 0) {
		outputText("  [arian Eir] cock");
		if(flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText("s twitch as they spurt ");
		else outputText(" twitches as it spurts ");
		outputText("a small rope of pre over [arian eir] belly, anticipating what's to come as [arian ey] braces [arian em]self for the inevitable pounding you're about to give [arian em].");
	}
	outputText("\n\nNow, you tell [arian em], you can really start, and you do your best to live up to your promise, pounding [arian em] as hard and fast as you can, without being so rough that you hurt [arian em] in the process.  \"<i>Ahm... yesssss... so good.  Fuck me raw!  Oh!  Paint my walls with your hot cum!</i>\"");

	outputText("\n\nArian has quite the dirty mouth on [arian em], you manage to joke, even as you pound [arian em] with all you have.");
	outputText("\n\n\"<i>That's... Ah!</i>\"  Arian's words catch in [arian eir] throat, and instead [arian ey] moans, \"<i>J-just cum!  Please!  I need it!</i>\"");

	outputText("\n\nWell, it's rude to cum before a " + arianMF("maleherm", "lady") + ", so you're not giving in, not until [arian ey] cums first, you manage to gasp, though in truth you're struggling to keep from blowing.  \"<i>Oh!  Cum!  Cum with meeeee!</i>\"");

	outputText("\n\n");
	if(flags[kFLAGS.ARIAN_COCK_SIZE] > 0) {
		outputText("Arian's ");
		if(flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText("twin cocks throb");
		else outputText("cock throbs");
		outputText(" as [arian ey] splashes [arian eir] [arian chest] and face with [arian eir] own futa-lizan seed.  ");
	}
	outputText("[arian Eir] walls grip you tightly, almost painfully, as a flood of juices hits the " + player.cockHead(x) + " of your " + cockDescript(x) + " with the force of a tidal wave, only to spill around [arian eir] spread nethers and run down your lower body.  [arian Eir] sopping wet pussy works overtime, trying its best to pull you in as deep as possible, intent on sucking all the cum out of ");
	if(player.balls == 0) outputText("you");
	else outputText("your [balls]");
	outputText(".");

	outputText("\n\nFinally having kept your promise, you give yourself over to the inevitable. ");
	if(player.hasVagina()) outputText(" A wash of fluids spills down your body from your cunt as it spasms in release and y");
	else outputText("Y");
	outputText("ou unleash your essence right into the lizan's burning womb.");

	//(Low Cum amount)
	if(player.cumQ() < 250) {
		outputText("\n\nArian's pussy is clamping down so hard on your dick, that you can feel it as the cum stretches your urethra, gathering at the tip, and exploding outwards.  Contracting walls carrying the seed deep into the awaiting womb that lies beyond.  You hug the shuddering lizan tightly as you thrust against [arian em] a few more times, delivering the last few ropes of cum and collapsing atop [arian em].");
	}
	//(Medium Cum amount)
	else if(player.cumQ() < 1000) {
		outputText("\n\nYou forcible stretch Arian's wet pussy with the sheer volume of the load traversing your cum-sleeve.  You imagine yourself, covering the lizan's canal in white... all the way to [arian eir] cervix.  The weak barrier barely containing the enormous load that forces it open, to spatter and sit inside [arian eir] womb.  \"<i>Ahh... so full,</i>\" Arian says, tongue lolling out.  You hug [arian em] tightly against you, an action [arian ey]'s happy to return, and slowly you feel it.  [arian Eir] slender belly gains volume, sloshing with the cum you just deposited in it.  Once spent, you collapse and sigh.");
	}
	//(High Cum amount)
	else {
		outputText("\n\nYou threaten to blow the poor lizan straight off your " + cockDescript(x) + " with the sheer force of your cum.  Hosing down [arian eir] walls to the point [arian ey] can't hope to contain all of your powerful jets, you draw [arian em] close, and Arian groans, returning the gesture with a tight hug of [arian eir] own.  \"<i>Ugh, my belly... so much... so good,</i>\" [arian ey] moans, and you continue to torment [arian eir] body with your prodigious load.  The sheets under the two of you have since turned into a wet mess of mixed juices, covering both of your lower bodies in the aftermath of you tryst; and it's not until you thrust into [arian em] a couple more times, to ensure you're completely spent, that you collapse on top of [arian em], slightly propped up by the protruding, pregnant-looking belly you've given [arian em].");
	}

	outputText("\n\n\"<i>Aaahhhh...</i>\"  Arian sighs.  \"<i>Sex... feels so good.</i>\"  Caressing the back of your head, [arian ey] gently pulls you into a quick kiss.  \"<i>If this is how it'll feel every time we do this, then I have no regrets about turning into a girl,</i>\" [arian ey] says, one hand snaking it's way between the two of you to rub [arian eir] ");
	if(player.cumQ() < 250) outputText("lean");
	else if(player.cumQ() < 1000) outputText("full");
	else outputText("overfilled");
	outputText(" belly.  \"<i>Stay with me, like this, a little longer?</i>\" Arian asks.");

	outputText("\n\nYou take [arian eir] free hand in your own and tell [arian em] that, if [arian ey] wants you to, you can stay for at least a little while longer.  \"<i>I'd like that... just a while.</i>\"  Arian does [arian eir] best to nuzzle you.  With no compelling reason not to, you nuzzle [arian em] back and content yourself with laying there, enjoying the mutual afterglow.");

	outputText("\n\nEventually, though, you announce that you should probably get going.  As nice as it is to stay here with [arian em], you have duties to attend to.  Arian smiles at you, and gives you a little peck on the lips.  \"<i>I understand, but come see me again soon, please.</i>\"  You promise [arian em] you will and extract yourself from the affectionate lizan's embrace.  You quickly find your clothes and get dressed, then leave.");
	player.sexReward("vaginalFluids","Dick");
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
	if(flags[kFLAGS.ARIAN_ANAL_XP] < 33) outputText("\n\n\"<i>I don't know... won't it hurt, are you sure?</i>\"");
	//(if AnalXP < 66)
	else if(flags[kFLAGS.ARIAN_ANAL_XP] < 66) outputText("\n\n\"<i>I like it when you use my ass, but if you want me to use yours, I would gladly comply.  That is, if you're sure you want me to...?</i>\"");
	//(if AnalXP <= 100)
	else outputText("\n\n\"<i>I really love it when you fill me up, and personally I'd prefer we do it that way, but if you're really sure you want me to, I'll try and make you feel as good as you feel inside me.</i>\"");

	outputText("\n\nYou smile seductively and nod, telling [arian em] that you're sure you want [arian em] to do you that way.");

	outputText("\n\n\"<i>Okay, then.  How should we do this?  I don't want to do something wrong and end up hurting you...</i>\"");

	outputText("\n\nYou smirk and reach out a hand to caress the lizan's [arian chest], stage-whispering to [arian em] that [arian ey] just needs to lie down on [arian eir] bed and you'll take care of things from there...");

	outputText("\n\nArian swallow audibly, but complies.  Slowly [arian ey] lets [arian em]self fall back onto [arian eir] bed, fidgeting as [arian eir] ");
	if(flags[kFLAGS.ARIAN_COCK_SIZE] >= 3) {
		outputText("exposed cock");
		if(flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText("s harden");
		else outputText(" hardens");
		outputText(" to full mast.");
	}
	else {
		outputText("cock");
		if(flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText("s peek out of their");
		else outputText(" peeks out of its");
		outputText(" hiding place, rising to full mast.");
	}

	outputText("\n\nYou sashay yourself towards the prone lizan, straddling [arian eir] legs and reaching out to grasp [arian eir] ");
	if(flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText("primary ");
	outputText("cock.  Slowly and gently you begin to stroke its strange, knobbly surface, your fingers eliciting moans and gasps from Arian as [arian ey] shudders under your touch.  Precum begins to ooze from the reptilian prick's head, and you purposefully rub it into [arian eir] shaft as a kind of makeshift lubricant.");

	outputText("\n\n\"<i>Ohm... T-this feels great, [name], b-but if you keep this up, I won't be able to hold back!</i>\" Arian pants, [arian eir] shaft");
	if(flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText("s");
	outputText(" throbbing against your hands.");

	outputText("\n\nWell, that would be a shame; it might be a little rough, but you'll have to make do with what you've got.  With that in mind, you cease your stroking, and start sliding yourself up Arian's body, until your [ass] is positioned above [arian eir] jutting prick.  With slow, deliberate motions, you slowly start to impale yourself upon it...");

	player.buttChange(arianCockSize(),true,true,false);

	outputText("\n\n\"<i>Argh!  T-this is too much!</i>\"  With a groan of pleasure Arian shoots [arian eir] cum into your bowels, lubricating it enough to allow you to easily slide down onto [arian eir] shaft.");
	if(flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText("  [arian Eir] other shaft twiches and sprays your " + (player.tailType == Tail.NONE ? "back" : "tail") + ".");

	outputText("\n\nYou sigh and cluck your tongue; Arian really needs to work on [arian eir] stamina - [arian ey] loses [arian emself] to the pleasure too easily, which you gently point out to [arian em].");

	outputText("\n\n\"<i>S-sorry...</i>\"  Well, it can't be helped.  You'll just have to try again some other time... \"<i>No!  Wait!</i>\"  Arian grabs your hips.  \"<i>I-I can still go on!</i>\"  Really?  Because you're pretty sure you can feel [arian em] going soft right this instant...  \"<i>Y-yes... just give me a moment.</i>\"");

	outputText("\n\nArian looks up at you, panting; [arian eir] hands begin roaming your body, caressing your [hips], your [butt], your [chest].  For a moment, you actually feel [arian eir] bulbous shaft throb within you, but maybe [arian ey] needs a little push to make things go faster?  You smirk.");

	outputText("\n\nWith that, you bend over and kiss [arian em], slipping your tongue into [arian eir] mouth to wrestle with [arian eir] own long, dexterous tongue.  Withdrawing, you send a hand reaching down between [arian eir] legs, squeezing [arian eir] ass, ");
	if(flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText("stroking [arian eir] other cock and sliding it between your ass cheeks, ");
	outputText("caressing the base of [arian eir] tail.  With a devious grin, you begin to gently but insistently slide your finger into [arian eir] ");
	if(flags[kFLAGS.ARIAN_ANAL_XP] > 66) outputText("eager ");
	outputText("ass, probing for [arian eir] prostrate...");

	outputText("\n\nThe reaction is almost instantaneous; Arian moans into your kiss and you feel [arian eir] lizan cock");
	if(flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText("s");
	else outputText(" practically jump back to full mast, even surprising you with Arian's eagerness.");

	outputText("\n\nYou grin and coyly muse to yourself that maybe Arian makes up for [arian eir] quickness at climaxing with the speed with which [arian ey] can recover.");

	outputText("\n\nArian bites [arian eir] lower lip nervously.  \"<i>I can't help myself if you keep touching me like that.</i>\"  [arian Ey] closes [arian eir] eyes and turns to the side, [arian eir] hands clutching your [hips] and [arian eir] toes curling behind you.  You can't help but gently pat [arian em] on [arian eir] head and tell [arian em] that [arian ey] looks really cute when [arian ey] acts like an embarrassed virgin, especially after having already cum inside you.  Arian just turns to smile nervously at you.  \"<i>I... can we... start moving now?</i>\"");

	outputText("\n\nYes, yes you can, you tell [arian em], and for emphasis you begin to rise and fall, ");
	if(flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText("sliding [arian eir] neglected prick through your ass-cheeks, ");
	outputText("clenching your inner walls to grip and feel the excitingly unusual lumpy, bulbous texture of [arian eir] shaft inside you.  You moan and gasp, telling [arian em] that [arian ey] feels so unique, and yet [arian ey] stimulates you so wonderfully.");

	outputText("\n\nThe lizan mage can barely contain [arian emself] as [arian ey] tosses and turns on [arian eir] bed, gasping and moaning at your ministrations.  You lick your lips as you continue to ride [arian em], ");
	if(player.hasVagina()) outputText("cunt dripping with arousal");
	if(player.hasCock() && player.hasVagina()) outputText(" and ");
	if(player.hasCock()) {
		outputText("cock");
		if(player.cockTotal() > 1) outputText("s");
		outputText(" drooling precum onto [arian eir] belly");
	}
	if (player.gender == 0) outputText("null body shiverring with pleasure")//Would look weird without Genderless text.
	outputText(".  You're so close now, you can feel it.  You tell Arian you're going to cum, and beg [arian em] to cum with you.");

	outputText("\n\nAs if on cue, Arian gasps and [arian eir] shaft");
	if(flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText("s twitch");
	else outputText(" twitches");
	outputText(", signaling [arian eir] oncoming orgasm.  [arian Ey] grabs the sheets on [arian eir] bed and curls [arian eir] toes.  \"<i>...[name]!</i>\"  Jet after jet of lizan spunk paints your bowels white");
	if(flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText(", as well as your butt");
	outputText(", as Arian climaxes");
	if (flags[kFLAGS.ARIAN_VAGINA] > 0) outputText(", [arian eir] own pussy clenching and drizzling juices on the matted sheets beneath the two of you.");
	else outputText(".");

	outputText("\n\nWith a cry of glee, you orgasm, giving yourself over to the pleasures of the act.  Your ass clenches around the bulbous shaft intruding in your bowels, trying to wring it of all its delicious load.");
	if(player.hasCock()) outputText("  [EachCock] spasms and shoots rope after rope of cum, painting Arian's [arian chest] white, as well as the groaning lizan's face.");
	if(player.hasVagina()) outputText("  Your [pussy], though unattended, joins in the perverted display, leaking copious amount of fluids on top of the prone lizan.");

	outputText("\n\n\"<i>Ahhhhh...</i>\"  Arian sighs, going limp on [arian eir] bed.  You follow shortly, laying down on top of [arian em], embracing [arian em] as [arian ey] does the same.  \"<i>[name], you're amazing.</i>\"");

	outputText("\n\nWith a pleased grin, you tell [arian em] that [arian ey]'s not too shabby [arian em]self, either.  So, how did [arian ey] like being the pitcher?");

	//(if AnalXP < 33)
	if(flags[kFLAGS.ARIAN_ANAL_XP] < 33) {
		outputText("\n\n\"<i>Wow, that felt really good.  Did it feel good for you too, [name]?  I hope it did... wow,</i>\"  Arian pants.");

		outputText("\n\nYou smile and pat your lover on the head, assuring [arian em] that it was good for you, too.");

		outputText("\n\n\"<i>I'm glad,</i>\" [arian ey] replies, nuzzling you in affection.");
	}
	//(if AnalXP < 66)
	else if(flags[kFLAGS.ARIAN_ANAL_XP] < 66) {
		outputText("\n\n\"<i>You ass feels so good on my cock, [name].  I can only hope it feels this good when you're inside me.  Though to be honest, I think I like it best when our roles are reversed.</i>\"");
		outputText("\n\nYou insist that it does, though you can't resist grinning and warning Arian [arian ey] might be getting too much into catching when it comes to this situation.");
		outputText("\n\n\"<i>It just feels so good when you're doing me from behind, but doing you is good too.</i>\"  [arian Ey] smiles.");
	}
	//(if AnalXP <= 100)
	else {
		outputText("\n\n\"<i>That was great!  Now why don't you return the favor and use me instead?  After watching you sit on my shaft like that, I want to be fucked too.</i>\"  [arian Ey] bites [arian eir] lower lip, tail waving as best as it can underneath the two of you.");
		outputText("\n\nYou laugh; Arian, you are such a greedy little buttslut, aren't you?  That's what you say to him.");

		outputText("\n\nGrinning nervously, [arian ey] says, \"<i>I can't help it.  It feels really good.  Besides, you made me that way, so take some responsibility.</i>\"  Then [arian ey] swallows.  \"<i>Not that I mean to imply I didn't like it... or anything of the sort.</i>\"");

		outputText("\n\nAnd what if you want to be the catcher sometimes, huh?  [arian Ey]'s got such a wonderful cock, how can [arian ey] deny you the pleasure of taking it up the ass?  [arian Ey]'s so greedy, you tell [arian em], playfully tapping [arian em] on the nose.  [arian Ey] whimpers.  \"<i>Okay, I like being the pitcher too, but can you do me now?  Please?</i>\"  [arian Ey] asks, eagerly wiggling [arian eir] hips.");
		outputText("\n\nYou contemplate it...");
		//(if PC has a cock){
		if(player.hasCock()) {
			player.sexReward("cum","Anal");
			dynStats("sen", 2);
			//[Yes: Play the \"<i>PC fucks Arian's ass</i>\" scene]
			//[No: You tell Arian you've had enough fun for now; maybe later, after you've both recovered.]
			menu();
			addButton(0,"Yes",giveArianAnal).hint("return the favor; fuck Arian's ass").disableIf(player.cockThatFits(50) < 0,"You're too big to fit inside Arian's ass, though");
			addButton(1,"No",camp.returnToCampUseOneHour);
			return;
		}
		else{
			outputText("\n\nYou chuckle at [arian eir] eagerness, but point out you're not properly equipped to help [arian em] at the moment, so maybe later.");
			outputText("\n\nArian whimpers in disappointment.");
		}
		outputText("\n\n\"<i>I guess I need a nap now.  Care to join me?</i>\" [arian ey] asks, yawning widely.  You tell [arian em] the offer is tempting, but you really need to get going and attend to other things.  You stroke [arian eir] cheek and tell [arian em] to get some rest to build [arian eir] strength back up - after all, it wasn't really that long ago that [arian ey] was so sick.  Arian nods.  \"<i>Okay, see you soon?</i>\"");
		outputText("\n\nYou promise [arian ey] will, and plant a quick kiss on [arian eir] brow.  As the lizan settles down to rest, you quietly redress yourself and leave [arian em] to [arian eir] slumbers.");
	}
  player.sexReward("cum","Anal");
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
	outputText("You make a show of lewdly licking your lips and ask Arian if [arian ey]'d be willing to let you have a little taste of lizan essence...?");
	outputText("\n\n\"<i>Are you sure?  I could do something for you if you feel like,</i>\" Arian offers.");

	outputText("\n\nYou shake your head insistently; you want to do something for [arian em] this time, you tell your reptilian lover.");
	outputText("\n\n\"<i>Ok... if that's what you really want to do.  So... what should I do?</i>\" the lizan mage asks, fidgeting in barely contained excitement, tapping [arian eir] fingers in anticipation.");

	outputText("\n\nJust get on the bed, you instruct [arian em]; you're certain you can take care of the rest.");

	outputText("\n\n\"<i>All right,</i>\" Arian replies nervously, [arian eir] ");
	if(flags[kFLAGS.ARIAN_COCK_SIZE] > 3) {
		if(flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText("exposed cocks hardening to full mast");
		else outputText("exposed cock hardening to full mast");
	}
	else {
		outputText("cock");
		if(flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText("s emerging from their");
		else outputText(" emerging from its");
		outputText(" hiding place, already fully erect");
		outputText(".");
	}
	outputText("\n\nYou approach [arian em] and position yourself before [arian em], contemplating how to begin.  You reach out with one hand and start to stroke [arian eir] ");
	if(flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText("uppermost ");
	outputText("cock, marveling at the strange textures of its bumpy, knobbly, bulbous surface.  It feels so strange to you, and you continue to stroke it eagerly.");

	outputText("\n\nArian can only moan at your ministrations, eagerly humping your hand, desperate for your touch.  \"<i>Oh, my... it... it feels so good when it's someone else's hand...</i>\" [arian Eir] ");
	if(flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText("twin shafts tremble and throb against your hand; pre quickly forming on the tips only to slowly slide down the bulbous surface of Arian's lizan pricks");
	else outputText("shaft trembles and throbs against your hand; pre quickly forming on the tip only to slowly slide down the bulbous surface of Arian's lizan prick");
	outputText(".  You continue to slide your hand along the increasingly slick surface, playfully asking if your hand really feels that good to [arian em]?");

	outputText("\n\n\"<i>Yesssss... Oh!  If you keep this up I won't be able to last long.</i>\"  Arian pants, [arian eir] three-toed feet curling with each stroke, hands gripping the sheets tightly.");

	outputText("\n\nYou smile at [arian em] with an innocent expression quite out of place for what you're doing, and then lean in to give [arian eir] cock");
	if(flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText("s");
	outputText(" a long, loving, slurpy lick.  The taste is surprising; a sort of sugary-tinted spice, not the usual salt of another creature.  It's actually quite pleasant, and you find yourself running your tongue up and down [arian eir] prick as if it were some kind of candied stick, eagerly sucking and slobbering as you coax more of [arian eir] yummy goo from its strangely-shaped tip.");

	outputText("\n\nArian contorts with each loving lick, grunting and groaning in pleasure.  \"<i>[name], I'm going to cum!</i>\"  [arian Ey] warns you, and judging by the way [arian eir] shaft is throbbing [arian ey] looks just about ready.");

	outputText("\n\nIn other circumstances, you'd probably tease [arian em] about having no staying power, but, seeing how the wind's blowing, you instead put your mouth to better use and envelop [arian eir] cock, suckling and slurping like a baby on a nipple as more of that strange spicy-sweet cum trickles steadily into your mouth.");

	outputText("\n\nUnable to hold back any longer, Arian's hands pull on the sheets as [arian eir] ");
	if(flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText("twin cocks throb");
	else outputText("cock throbs");
	outputText(" one more time and erupts into your waiting mouth");
	if(flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText(" and chin");
	outputText(".  [arian Eir] legs close around your back, effectively keeping you from moving too far away as [arian ey] finishes giving you all of [arian eir] load.");

	outputText("\n\nYou simply go with what [arian ey] wants and focus on guzzling down every last drop, continuing to lick and tease even as you swallow mouthful after creamy mouthful");
	if (flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText(", oblivious to the second cock spewing cum all over your [chest] in your eagerness");
	outputText(".  ");
	outputText("After [arian ey] finally finishes, you continue to lick and suckle for a few minutes longer, making sure you've lapped up every last drop.  Then and then alone do you lift your head, flirtatiously licking your lips to tease the now-spent lizan.");

	outputText("\n\nArian watches you slack jawed and panting.  \"<i>That... that was great!</i>\"  [arian ey] exclaims happily.  \"<i>I hope I didn't taste too bad.  I mean, I heard there is food that can make it taste better, but... well....</i>\" [arian Ey] smiles nervously.");

	outputText("\n\nYou confess that, truthfully, the taste was unusual, but hardly unpleasant.  So, did your little lizard like the way you licked [arian eir] lolly to reach the creamy center?  You jest.");

	outputText("\n\n\"<i>Yes, I liked it very much!  Though I hope you'll let me return the favor... somehow,</i>\"  [arian Ey] says, releasing you from between [arian eir] legs, while [arian eir] tail lazily curls to gently massage your neck in a sign of affection.");

	//[NoCock:
	if(!player.hasCock()) outputText("\n\nYou tell [arian ey] you'll think of some way [arian ey] can return the favor,");
	else outputText("\n\nWell, you happen to have a creamy lolly of your own that [arian ey] could lick, you tease,");
	outputText(" rolling your neck in pleasure as [arian ey] rubs it with [arian eir] reptilian tail.");

	outputText("\n\nArian bites [arian eir] lips and twirls [arian eir] fingers.  \"<i>Well, I hope I can do something... anything... for you soon.  I really enjoy spending time with you, [name].</i>\" [arian Ey] smiles at you.");

	outputText("\n\nSmiling wryly, you jokingly tell the lizan mage that the only reason [arian ey] happens to enjoy your company is because of all the sex [arian ey]'s getting.  Arian gasps and immediately blurts out, \"<i>No! Of course not!  I would love to be in your company even if we didn't do anything!</i>\"  [arian Ey] gasps once more and shamefully hides [arian eir] face when [arian ey] realizes [arian ey]'s sporting another erection.  \"<i>S-sorry!  I can't help it!</i>\" [arian ey] fumbles, trying to cover [arian emself].");

	outputText("\n\nYou just smile and pat [arian em] on the cheek, telling [arian em] that [arian ey]'s adorable when [arian ey] blushes.  You give [arian eir] newly-stiffened cock a good firm stroke");
	if(flags[kFLAGS.ARIAN_VAGINA] > 0) outputText(" and tickle [arian eir] cunt with a finger");
	outputText(" for emphasis, kiss [arian em] gently on the tip of [arian eir] nose, and then get your clothes together, planning on getting dressed and heading back out again.");

	outputText("\n\n\"<i>Uuuh... see you soon?</i>\"");
	outputText("\n\nYou throw [arian em] a smirk over your shoulder, shake your [ass] for [arian eir] benefit, and head on out.");
	player.sexReward("cum", "Lips");
	dynStats("lus", 10+player.lib/5, "scale", false);
	doNext(camp.returnToCampUseOneHour);
}

//Get Penetrated:
//PC must have a vagina.
//Arian must have a cock.
private function getPenetratedByArianAndHisHitlerMustache():void {
	clearOutput();
	if (flags[kFLAGS.ARIAN_DOUBLE_COCK]) {
		outputText("Would you like Arian to use only one cock, or double-penetrate you with [Arian eir] package?");
		menu();
		addButton(0, "One cock", getFuckedScene, false);
		addButton(1, "Get DP", getFuckedScene, true);

	} else {
		sceneHunter.print("Arian could use more than one cock... if [Arian ey] had more.");
		getFuckedScene(false);
	}
}

private function getFuckedScene(dp:Boolean = false):void {
	clearOutput();
	flags[kFLAGS.ARIAN_VIRGIN] += 1;
	arianHealth(3);
	if (flags[kFLAGS.ARIAN_VAGINA] > 0)
		outputText(images.showImage("arianfemale-home-getpenetrated"));
	else
		outputText(images.showImage("arianmale-home-getpenetrated"));
	outputText("You look at Arian's ");
	if(flags[kFLAGS.ARIAN_COCK_SIZE] < 3) outputText("slit, and think of what it's hiding in there");
	else {
		outputText("exposed cock");
		if(dp) outputText("s");
	}
	outputText("; then you turn to look at Arian and ask [arian em] how would [arian ey] feel about giving [arian eir] ");
	if(dp) outputText("twin cocks");
	else outputText("cock");
	outputText(" a bit of a workout?");

	outputText("\n\nArian swallows audibly.  \"<i>Are you suggesting that we... and that I... put it in?</i>\"  Grinning, you nod in affirmation, telling [arian em] that there's no need to be shy about it... at least not since your relationship escalated to the current level.");

	outputText("\n\n\"<i>Ok... how do you want to do this?</i>\"  You motion for the lizan to get up.  Arian eagerly complies and gets off [arian eir] bed.  You teasingly take [arian eir] place on the bed, looking up at [arian em] as you ");
	if(player.isBiped()) outputText("spread your [legs] and ");
	outputText("expose your [vagina] to [arian eir] viewing pleasure.  The reaction is almost instantaneous; Arian's ");
	if(flags[kFLAGS.ARIAN_COCK_SIZE] >= 3) outputText("exposed");
	else outputText("hidden");
	if(dp) outputText(" twin shafts immediately fill");
	else outputText(" shaft immediately fills");
	outputText(" with blood, growing fully erect in ");
	if(dp) outputText("their");
	else outputText("its");
	outputText(" bulbous, throbbing glory.");

	outputText("\n\nWith a smile, you tell [arian em] that despite [arian eir] initial bout of shyness, [arian eir] body seems to know exactly what to do.  Arian simply laughs in nervousness.  You wait for a short while, until finally you tell [arian em] that [arian ey] should position [arian emself] at your opening");
	if(dp) outputText("s");
	outputText(" and get ready to thrust in; otherwise neither of you are going to be feeling good any time soon.");

	outputText("\n\nSnapping to [arian eir] senses, Arian quickly ");
	outputText("kneels between your [legs]");
	outputText(", aligning the tip of ");
	if(dp) outputText("each of ");
	outputText(arianMF("his","her") + " ");
	outputText("shaft");
	if(dp) outputText("s");
	outputText(" with your [vagina]");
	if(dp) outputText(" and [asshole]");
	outputText(".  [arian Ey] looks at you, waiting for you to confirm that [arian ey] should indeed get going.  You smile and nod");
	if(player.hasLongTail()) outputText(", looping your tail around [arian eir] waist");
	outputText(".");

	outputText("\n\nArian smiles right back at you and finally begins easing [arian emself] inside you.");

	//(if ArianDblCock == 1) //DP PC
	if(dp) {
		outputText("\n\nHesitantly, the lizan tries to fit both of [arian eir] cocks into your [vagina] and [asshole] at the same time.  You sigh at the intrusion and look at [arian eir] face; Arian has a look of absolute bliss on [arian eir], you can even see that the lizan is beginning to drool a bit.  The texture of Arian's twin cocks might be very similar, but they feel entirely different on both your ass and pussy.");

		outputText("\n\nThe bulbous orbs dotting the length work somewhat like beads, as they work over your resistance, each time one of them presses in, you moan and brace yourself for the next, larger bulb.  Gently but insistently Arian presses forward, quite happy to try and take both of your holes at the same time.  \"<i>This isn't hurting you, is it?</i>\" [arian ey] asks, still understandably nervous about your relationship.");

		outputText("\n\nYou shake your head and tell [arian em] that you're fine.  [arian Eir] cocks just feel... different... from what you're used to seeing around; you remark that they seem built to rub against your most sensitive spots inside both your ass and your vagina.  Still, if [arian ey] doesn't hurry up and fill you up, you might have to take matters into your own hands.  It's not nice to keep a girl waiting.");

		outputText("\n\nArian fumbles and begins penetrating you with more gusto.  \"<i>S-sorry, I just don't want to hurt you...</i>\"  You sigh and tell [arian em] that you aren't made of glass.  [arian Ey] can be a little rough, though if [arian ey] overdoes it you'll have to stop [arian em].  Still, you can take something like this!");

		outputText("\n\nYou take hold of [arian eir] arms and pull [arian em] up towards you, making the lizan lose [arian eir] balance and fully penetrate you.");
		//(Enlargement/Virginity loss messages)
		player.cuntChange(arianCockSize(),true,true,false);
		player.buttChange(arianCockSize(),true,true,false);

		outputText("\n\nThe lizan moans in shock at the deed, as if [arian ey] still can't believe this is actually happening.  [arian Eir] fingers clutch you tightly, but [arian ey] doesn't make any further motions - more likely [arian ey] can't bring himself to thrust just yet, still full of that nervous virgin behavior.");
	}
	else
	{ //Only one pole for that hole.
		outputText("\n\nArian nervously begins to thrust [arian eir] strange, bumpy cock into your cunt, timidly inserting an inch or two and then withdrawing, as if unable to bring [arian em]self to fully penetrate you.");

		outputText("\n\nYou moan at the initial intrusion, and sigh as [arian ey] pulls out.  Impatient and bothered by [arian eir] impromptu teasing, you ask what's gotten into [arian em] to make [arian em] withdraw?  You're already more than ready for this.");

		outputText("\n\n\"<i>I-I'm sorry, it's just....  Well, I'm not used to this, you know.</i>\"  Arian's eyes are downcast, and you're certain you can see a faint tinge of red around [arian eir] face, [arian eir] albinism allowing [arian em] to blush in a way you're not sure a normal lizan could.  \"<i>It... it's so overwhelming to finally be with a woman, never mind a woman like you.</i>\"");

		outputText("\n\nSighing at the lizan's inexperience, you gently take [arian eir] hands in yours and guide them around you, telling [arian em] to hug you");
		if(player.hasLongTail()) outputText(", further encouraging [arian em] to do so, by looping your tail around [arian eir] waist");
		outputText(".  The lizan doesn't need much encouragement to comply, easily snuggling against you, breast to breast, and sighing softly.  \"<i>I'm sorry.  Sometimes I wonder why you bother doing something like this, with someone like me,</i>\" [arian ey] says, a hint of sadness in [arian eir] voice.");

		outputText("\n\nYou reply that you bother because Arian is cute and you happen to like [arian em].  [arian Ey] should forget about [arian eir] insecurities and give [arian emself] some credit.  Still, you are horny, and judging by the prodding you feel on your [leg], so is [arian ey].  You don't bother saying anything more, gently reaching down to align [arian eir] shaft with your [vagina] and then pinch on the base of [arian eir] tail.");

		outputText("\n\nArian lets out a tiny squeak of shock at the pinching sensation, which instinctively makes [arian em] thrust [arian emself] forward, embedding [arian emself] in you to the hilt.");
		//(Enlargement/Virginity loss messages)
		player.cuntChange(arianCockSize(),true,true,false);

		outputText("\n\nYou gasp in pleasure at the sudden intrusion; then hug your lizan lover closer, stroking [arian eir] back.  You ask if that was so difficult?");

		outputText("\n\n\"<i>N-not difficult, no.  But hard, all the same,</i>\" Arian replies.  Did [arian ey] just make a joke?");
	}

	outputText("\n\nSmiling, you gently tap [arian em] on the nose and tell [arian em] that unless [arian ey] expects you to do all the work, the two of you won't get anything done if [arian ey] just lets [arian eir] shaft");
	if(dp) outputText("s");
	outputText(" sit inside you.");

	outputText("\n\nThe lizan promptly makes [arian em]self busy, awkwardly thrusting in and out, pumping in a clumsy attempt to pleasure you both.  While you appreciate [arian eir] enthusiasm, just randomly thrusting inside you won't give you the pleasure you so crave.  You tell Arian to stop for a moment.");

	outputText("\n\nArian does so, blinking curiously at you.  \"<i>Did I hurt you?  Am I doing something wrong?  I'm sorry!</i>\" the lizan blurts you.  Laughing, you tell [arian em] to calm down.  [arian Ey] didn't do anything wrong, and [arian ey] certainly didn't hurt you.  \"<i>So, what's wrong then?</i>\" Arian asks.  [arian Ey] then blinks in realisation and pouts.  \"<i>I'm not doing that badly, am I?</i>\"  Rubbing [arian eir] back, you tell [arian em] that just thrusting [arian em]self inside you without any technique won't make you feel good.");

	outputText("\n\n\"<i>I'm sorry,</i>\" [arian ey] sighs.  It's ok, you tell [arian em], you'll just have to guide [arian em] through the process.  Grasping on the base of [arian eir] tail, you begin guiding the inexperienced lizan, using [arian eir] tail like a control stick.");

	outputText("\n\nArian moans and shivers at the pleasure, but it doesn't stop [arian em] from catching on; indeed, [arian ey] proves [arian em]self a quick study and starts to preempt your ‘instructions'.  \"<i>I-I can't tell you how incredible this is, [name].  You're so warm and wet inside,</i>\" [arian ey] murmurs to you, too caught up in the sensations of sex to really flatter you.");

	outputText("\n\nYou moan alongside your lizan lover, replying that [arian ey] feels just as good.  [arian Eir] ");
	if(dp) outputText("twin bulbous shafts feel");
	else outputText("bulbous shaft feels");
	outputText(" exquisite, and ");
	if(dp) outputText("their");
	else outputText("its");
	outputText(" bumps massage your entrance");
	if(dp) outputText("s");
	outputText(" unlike anything else.  You praise the lizan on being a quick study, letting go of [arian eir] tail and grabbing onto [arian eir] scaly shoulders instead, giving [arian em] a few more directions so [arian ey] can catch your most sensitive spots.");

	outputText("\n\nArian suddenly clenches and gasps, moaning several times and arching [arian eir] back before [arian ey] can't hold it back anymore and climaxes inside of you, filling your [cunt] ");
	if(dp) outputText("and [ass] ");
	outputText("with [arian eir] sticky wet seed.");

	outputText("\n\nYou moan as [arian ey] fills you with [arian eir] lizan seed, then immediately sigh in disappointment as [arian ey] slumps down on top of you, nuzzling against you tenderly.  \"<i>That was incredible.  Hey, what's wrong?  Why didn't you cum?</i>\" Arian asks, curious yet sated.  Well, you just didn't have time to, but it's okay.  You'll find some way to relieve yourself, and it did feel good for the time it lasted.  You pat [arian eir] head, smiling at the lizan, despite being annoyed at not being able to climax.");

	outputText("\n\n\"<i>You mean, I didn't...?  No, no that's not acceptable!</i>\"  Arian growls.  To your surprise, you suddenly feel [arian eir] flaccid member");
	if(dp) outputText("s");
	outputText(" swelling inside you, the lizan grabbing your shoulders and starting to thrust [arian em]self back into you once more.");

	outputText("\n\nYou groan in as much surprise as pleasure, bracing yourself against Arian as [arian ey] begins fucking you with as much enthusiasm as when you two started.  You are genuinely impressed.  This is not something a newcomer to sex would be able to pull off.  You decide to thank and congratulate the lizan for [arian eir] dedication with a kiss.");

	outputText("\n\nArian promptly redoubles [arian eir] efforts, while trying to kiss you back in appreciation of the gesture.  You lose yourself in the pleasure and closeness of the act, fucking and kissing.  Slowly you feel a familiar pressure build in your loins, and you know it won't be long before you finally achieve your so, so desired, orgasm.");

	outputText("\n\nArian [arian emself] lets out a cry of relief; having finally achieved [arian eir] goal in helping you orgasm means [arian ey] can give in to the sensations [arian ey] is being overwhelmed by, spraying your ");
	if(dp) outputText("cavities");
	else outputText("cavity");
	outputText(" with a second helping of lizan spunk, dredging up every last drop of jizz left in [arian eir] internal balls before, with a groan, [arian ey] sinks down atop you.  Arian's orgasm pushes you over the edge, and you find your pussy ");
	if(dp) outputText("and ass ");
	outputText("contracting, trying ");
	if(dp) outputText("their");
	else outputText("its");
	outputText(" best to milk the poor lizan of all [arian ey] is worth, until finally with one last spasm, you slump down and release the lizan shaft");
	if(dp) outputText("s");
	outputText(" deeply embedded inside you, some of your mixed juices running down to mat Arian's bed.");

	outputText("\n\n[arian Ey] lays there, panting softly from the exertion, then somehow finds the strength to give you a weak yet cheeky grin.  \"<i>So, how was I this time?</i>\" [arian ey] asks.  Panting, you tell [arian em] that [arian ey] was great.  You didn't expect [arian em] to be able to get a second erection so quickly, especially after having just cum.  \"<i>Well, I've learned a few tricks at the academy from some of the more, uh, restricted tomes, shall we say?  Not enough that I can do anything major, or even worth teaching, but enough for... something like this....</i>\"");

	outputText("\n\nGrinning at [arian em], you question just why would [arian ey] have picked up this one particular spell?  Arian does that weird pseudo-blush of [arian eirs] again.  \"<i>A fellow can dream of finding someone special someday, can't they?</i>\"  That's all [arian ey]'ll say on the subject, despite your coaxing.");

	outputText("\n\nYou decide to drop the subject for the moment and tell [arian em] that as enjoyable as it was to spend time with [arian em], you must return to your duties now.  Arian simply nods, wearing [arian eir] best stoic expression.  \"<i>I understand... but, please, come back when you can, all right?</i>\"  You smile and tell [arian em] you will, caressing [arian eir] scaly cheek, then with a cheeky grin, let [arian em] know that next time you expect at least four more performances from [arian em].  Arian's eyes bulge at your suggestion, half in fear and half in lust.  \"<i>I... I can't possibly do that!  I mean, I don't have the energy,</i>\"  [arian Ey] declares, swallowing audibly and averting [arian eir] eyes.");

	outputText("\n\nGrinning, you pull [arian em] into a final kiss, telling [arian em] this is just something for [arian em] to think about.  Having said that, you quickly redress and excuse yourself, leaving one flustered lizan behind to rest.");
	player.sexReward("cum","Vaginal");
	if (dp) player.sexReward("cum","Anal");
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
	var x:int = player.cockThatFits(arianCapacity);
	var y:int = player.cockThatFits2(arianCapacity);
	outputText("You look over your feminine lizard lover, and feel your [cocks] starting to stir in your [armor].  Since you have enough tools for the job, and Arian has enough holes, you ask if Arian would be willing to let you fuck [Arian em] in both [Arian eir] ass and pussy at the same time?");

	outputText("\n\nArian bites [arian eir] lower lip, fidgeting a bit at your suggestion.  \"<i>Sure.  I mean... that's the way sex is supposed to be with lizan females, and I do have the parts now.</i>\"");

	outputText("\n\nArian rolls around, laying face down on [arian eir] bed, [arian eir] rump held high to allow you easy access to both [arian eir] ");
	if(flags[kFLAGS.ARIAN_ANAL_XP] <= 33) outputText("tight");
	else if(flags[kFLAGS.ARIAN_ANAL_XP] <= 66) outputText("loose");
	else outputText("throbbing");
	outputText(" ass and dripping wet vagina; a pair of clawed hands reach behind to spread [arian eir] butt open for you.  \"<i>Okay, I'm ready.</i>\"  Arian says, looking behind at you.");

	outputText("\n\nYou sidle gently into the bed behind [arian em] and gently squeeze [arian eir] full, round cheeks, rubbing them before moving your hand into [arian eir] crack in an effort to massage both anus and pussy at the same time.  You roll the palm of your hand against [arian eir] back passage and stroke [arian eir] softly scaled vulva lips with your fingers, asking how that feels.  \"<i>G-good,</i>\" Arian replies, shuddering.");

	//(if ArianAnalXP < 33)
	if(flags[kFLAGS.ARIAN_ANAL_XP] < 33) {
		outputText("\n\nYou slide your finger inside of Arian's pussy, getting it nice and slick with [arian eir] juices, and then remove your hand; lining the finger up with [arian eir] ass, you start pressing insistently against [arian eir] back hole; it takes some effort, but finally [arian eir] back passage yields and Arian moans as your finger presses past [arian eir] sphincter and into [arian eir] warm innards.  You smile and tell Arian [arian ey]'s really tight back here.");

		outputText("\n\n\"<i>Hmm... we don't get to use my ass much, so of course it'll be tight.  Just try not to be too rough, please?  It kinda hurts.</i>\"");

		outputText("\n\nYou assure [arian em] that you'll be gentle; and with [arian eir] pussy getting some as well, it should be easier for [arian em] to adjust.  That said, you carefully align your shafts and start to press them home.  It takes some effort to push inside [arian eir] ass, but [arian eir] pussy readily accepts you into its warm, wet embrace.");

		outputText("\n\n\"<i>Ooohhh!</i>\" Arian's initial cry of pain turns into a deep moan of pleasure as you finally make your way inside.  You stop to give [arian em] some time to adjust.  \"<i>I feel so stuffed... it hurts, but feels good at the same time.  Hhmmm... keep moving, please.</i>\"  You do as [arian ey] asks, and slowly push yourself to the hilt.");
	}
	//(else if ArianAnalXP < 66)
	else if(flags[kFLAGS.ARIAN_ANAL_XP] < 66) {
		outputText("\n\nYou know Arian's no stranger to anal sex, but you still figure it's polite to lube your finger up to some extent first.  Your fingers stroke and caress, sliding in and out of [arian eir] moist depths, and you remove your hand to begin probing into [arian eir] tailhole.  The well-trained orifice happily accepts you, posing little resistance as you begin sliding your femcum-slick digits inside.");

		outputText("\n\n\"<i>Aah, that feels nice.  I feel like such a girl, being treated like that...</i>\"");

		outputText("\n\nWell, of course, [arian ey] is a girl, you grin.  Why shouldn't you treat [arian em] like this, especially if it makes [arian em] happy?  \"<i>W-well, I'm not really a girl.  I mean... not originally, but it does make me happy.  Why don't you stick it in?</i>\"  [arian Ey] smiles nervously back at you.");

		outputText("\n\nWell, if [arian ey]'s really so interested.  You quickly align yourself and start to press forward, gently inserting yourself into the two eager holes your lover has.  \"<i>Yesssss... don't stop until I'm fully stuffed,</i>\" Arian says, [arian eir] tail wagging lazily above.  With a chuckle, you tap it away so you can finish pressing [arian em], all the way to the hilt.");
	}
	else {
		outputText("\n\nFor politeness' sake more than anything, you painstakingly rub and massage Arian's dripping wet cunny with your fingers, getting them nice and lubed before you start poking at the greedy little hole under Arian's tail.  You don't meet any resistance at all; indeed, it seems to deliberately wrinkle itself in order to slurp your fingers inside, the muscles squeezing in an effort to hold you in there.  You smile to yourself, telling Arian that [arian eir] little rosebud is indeed a naughty little thing, and you didn't expect any less.");

		outputText("\n\nArian shudders in pleasure, pushing back to allow [arian eir] ass to suck more of your finger in.  \"<i>Hmm... it's like that thanks to you.  Not that I'm complaining.  I love it when you take me from behind.</i>\"");

		outputText("\n\nDoes [arian ey] really, now, you ask?  Are both of [arian eir] greedy little holes anxious for a nice sausage to stuff themselves with, hmm?  \"<i>Yesss.... I need you.  Please... make me feel good... like a girl,</i>\" Arian begs.");

		outputText("\n\nWell, if that's what [arian ey] wants, who are you to deny [arian em]?  You promptly position yourself and begin slowly sliding yourself home.");

		outputText("\n\n\"<i>Hmm... come on, [name].  You know you can go faster than that, don't tease me!</i>\"  Arian protests, pushing back at you, while [arian eir] tail wraps itself around your waist to pull you inside.");

		outputText("\n\nWell, both [arian eir] holes need a little tenderness, you point out.  Still, you hasten your pace, pushing inside [arian eir] hungry holes until you've hilted yourself.");
	}

	outputText("\n\nYou moan and squeeze Arian's scaly yet luscious asscheeks, asking how [arian ey] enjoys [arian eir] double-serve of stuffing?  Rolling [arian eir] hips against your own, [arian ey] replies, \"<i>Let's just say that I'm beginning to get why we lizans are built the way we are.  Take me now!</i>\" [arian ey] demands.");

	outputText("\n\nYou deliver a slap to [arian eir] perky little butt, the crack of flesh on flesh ringing out as you then tell [arian em] not to get greedy; there's no race to be won here.  \"<i>Ow!  B-but... I want you!</i>\"  [arian Ey] pushes back at you insistently.  And you want [arian em] as well, you tell [arian em], but still, no need to be so bossy.  Arian pouts.  \"<i>Sorry...</i>\"");

	outputText("\n\nThat's better, you say.  With that, you start to thrust yourself into [arian eir] two holes.  Penetrating both of Arian's holes is a unique feeling; [arian eir] ass hugs your " + cockDescript(y) + " tightly, trying to prevent you from moving as it does its best to keep you hilted deeply within; while [arian eir] pussy, so slick and moist, massages your shaft expertly. For a moment you wonder if you even have to move.");

	outputText("\n\n\"<i>Oooh, [name]... you have no idea how wonderful this feels.  I feel so full... so good... so wanted... I love you!  Fertilize my eggs!</i>\"  You groan and smirk, commenting that maybe Arian's getting a bit too caught up in this, unless [arian ey]'s telling you that this ex-boy really wants to be a mother?  \"<i>Me... a mother... d-don't stop!  I want you as deep inside me as possible!</i>\"  You moan as [arian eir] two holes ripple around your intruding shafts, striving to suck you deeper and deeper inside of [arian em].  You allow [arian em] to lead, but warn [arian em] that you just might end up making [arian em] a mother whether [arian ey] wants to be or not if [arian ey] doesn't temper [arian eir] enthusiasm.");

	outputText("\n\n\"<i>What do you think I'm trying to do!?  Now get in here and paint my womb white!</i>\" Arian snaps, bracing [arian em]self on [arian eir] bed and allowing [arian eir] ass and pussy both to suck you in with surprising force.  As soon as you're hilted within both holes, [arian eir] ass clamps shut on your " + cockDescript(y) + ", while [arian eir] pussy's contractions begin truly milking you for all you're worth.  Stuck as you are, you have no option but to sit back and enjoy [arian eir] contractions as you feel yourself nearing the edge of an inevitable orgasm.");

	outputText("\n\nYou still can't quite drown your surprise at how this is making [arian em] act, but if that's what [arian ey] wants.  Besides, with the vice-like grip [arian eir] holes have on your cocks, it's not as if you have a choice, right?  You thrust two, three more times with all the ferocity you can muster, grab [arian eir] ass and holler as your climax finally erupts from your twin dicks.");

	//(Low Cum Amount)
	if(player.cumQ() <= 250) {
		outputText("\n\nYour [cocks] explode inside Arian's eager holes, giving them the liquid warmth they so crave.  The massage that your two cocks are receiving only enhance the intense feeling, and you find yourself cumming more than usual.  They don't stop massaging you for more, even as you stop unloading.");

		outputText("\n\n\"<i>More, I need more for my eggs!</i>\" Arian demands, yet you are truly spent...");
	}
	//(Medium Cum Amount)
	else if(player.cumQ() <= 1000) {
		outputText("\n\nLiquid lust floods Arian's insides, as your [cocks] do their best to relieve ");
		if(player.balls == 0) outputText("themselves");
		else outputText("your [balls]");

		outputText(" of their load; a load Arian is not only pleased to accept, but also eager to relieve you of every single stray drop off.  The tightness of [arian eir] ass, pressing down on your " + cockDescript(y) + ", [arian eir] pussy milking on your " + cockDescript(x) + ".  How could anyone refuse such an invitation?  You let yourself go, stuffing the eager lizan with more cum than you thought yourself capable of producing.");

		outputText("\n\n\"<i>M-more,</i>\" Arian pleads, even as [arian eir] belly starts to distend.");
	}
	//(High Cum Amount)
	else {
		outputText("\n\nYou cum with such force, that if Arian's ass wasn't clamping down on your " + cockDescript(y) + " so tightly, you'd be sure [arian ey] was going to get pushed off.  \"<i>So much cum!  Yesssss!</i>\" Arian moans, as you quickly give [arian eir] usually lithe belly a very blatant bump.  Even though your prodigious amount of cum is enough to completely fill the eager lizan-girl, [arian eir] ass and pussy work overtime to ensure you're completely spent; and you have no desire to resist.");

		outputText("\n\nBy the time you're finished, Arian's belly is positively bulging.  \"<i>Ahhh... eggs... cum... yes...</i>\" [arian ey] states in a stupor.");
	}
	outputText("\n\nArian's ass goes slack around your " + cockDescript(y) + ", and [arian ey] slowly slides off your shaft to plop on [arian eir] bed; eyes closed in bliss, as [arian ey] takes a short nap.");

	//(if ArianDblPenChat == 0)
	if(flags[kFLAGS.ARIAN_DOUBLE_PENETRATION_CHAT] == 0) {
		outputText("\n\nBreathing a sigh of relief, you gently pat Arian on the ass and comment that you didn't expect [arian em] to be so eager to lay a batch of fertilized eggs, and you certainly didn't expect [arian em] to be so... bossy.");

		outputText("\n\nArian's eyes snap open and [arian ey] quickly rolls around to look you in the eyes.  \"<i>Oh my!  Please, forgive me, [name].  I swear I don't know what came over me.  It was... sorry!</i>\"  [arian Ey] bows [arian eir] head down in shame.");

		outputText("\n\nYou just laugh.  So, it looks like [arian ey] wasn't really in control, huh?  Well, you should have figured [arian ey]'d have problems with it; this is a situation [arian ey] was never really supposed to be in, after all.");

		outputText("\n\n\"<i>I'm really sorry...</i>\"");

		outputText("\n\nYou tell [arian em] that [arian ey] doesn't need to apologise, but you do need to know; are you going to be a father now?  Is [arian ey] really pregnant as a result of the sex you just had with [arian em]?");

		outputText("\n\nArian shakes [arian eir] head.  \"<i>Not really.  I didn't have a clutch of eggs for you to fertilize, so the answer is no,</i>\" [arian ey] says, with a slight tinge of disappointment.");

		outputText("\n\nYou ask why [arian ey] sounds so disappointed; [arian ey] lived [arian eir] life as a male before [arian ey] met you - does [arian ey] really want to embrace womanhood so thoroughly as to lay a clutch of eggs?");

		outputText("\n\nArian covers [arian eir] face and shakes [arian eir] body in a way that you can only describe as... girly.  \"<i>Sorry, I have all these urges, and... well... I wouldn't be opposed to laying a clutch fathered by you, to be honest.</i>\"");

		outputText("\n\nYou're not sure what to say about that, so you simply ask if [arian ey] enjoyed herself.");

		outputText("\n\n\"<i>Very much!</i>\"  Arian grins happily.  You smile and pat [arian em] on the head, telling [arian em] that's good to hear; maybe you should do this again sometime?");

		outputText("\n\n\"<i>I'd like it if we did.</i>\"");

		outputText("\n\nYou tell [arian em] you'll remember that, then politely redress and make your way out of [arian eir] ");
		if(!arianFollower()) outputText("bedchambers");
		else outputText("tent");
		outputText(".");
	}
	else {
		outputText("\n\nBreathing a sigh of relief, you gently pat Arian on the ass and comment that it's always a surprise how [arian ey] acts bossy when you're having sex like that.");

		outputText("\n\nArian lazily opens [arian eir] eyes and rolls around to face you, rubbing [arian eir] belly.  \"<i>Hmm, I don't know why I act like that.  I just can't control it.</i>\"");

		outputText("\n\nYou tell [arian em] it's actually funny to see [arian em] change like that, since normally [arian ey] would never demand anything of you.  You would never have guessed [arian ey] had that... bossy side to [arian em].  Arian bites [arian eir] lower lip.  \"<i>Sorry about that by the way.</i>\"");

		outputText("\n\nYou shake your head, telling [arian em] it's no trouble then gently pat [arian em] on [arian eir] head and re-dress, excusing yourself out of [arian eir] ");
		if(!arianFollower()) outputText("bedchambers");
		else outputText("tent");
		outputText(".");
	}
	player.sexReward("vaginalFluids","Dick");
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
	outputText("You set your eyes on Arian's genital slit, and then smile at [arian em].  You ask how [arian ey]'d feel about ‘hiding' your cock, rather than [arian eirs], inside [arian eir] slit?");

	outputText("\n\nArian shudders a bit.  \"<i>That... would feel kinda weird, I think, but it's not unheard of among certain lizan couples.  If you want to try that, I'm okay with it.</i>\"");

	outputText("\n\nYou tell [arian em] that, yes, you want to try it - you're sorry, but it just sounds so kinky; and besides that, ");
	//(if ArianDblCock == 0)
	if(flags[kFLAGS.ARIAN_DOUBLE_COCK] == 0) {
		outputText("didn't [arian ey] always want to have two dicks?  Well, now it's [arian eir] chance to find out what it'd be like.");
	}
	else {
		outputText("[arian ey]'s already hiding two in there... an extra cock won't make such a huge difference, would it?");
	}

	outputText("\n\n\"<i>I suppose you're right.  Okay then, let's try.</i>\"  Arian lays on [arian eir] back, spreading [arian eir] legs to give you access to [arian eir] genital slit, gently touching the soft folds that hide [arian eir] ");
	if(flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText("pair of ");
	outputText("pecker");
	if(flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText("s");
	outputText(" from your prying eyes.");

	outputText("\n\nYou gently push away [arian eir] hands, running your fingers over the strange, almost woman-like folds, rubbing against the soft, smooth scales that cover [arian em] there.  You gently massage [arian em], making [arian em] groan softly at the stimulation, before working up the courage to begin gently probing inside.  It's wet and slick, the muscles squeezing your fingers tightly, and you don't have too far to go before you can feel yourself touching the bulbous, unmistakable shape");
	if(flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText("s");
	outputText(" of Arian's dick");
	if(flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText("s");
	outputText(".  You brush your fingers against the tip");
	if(flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText("s");
	outputText(", seeing what kind of reaction that will elicit from your scaly lover.");

	outputText("\n\nArian groans.  \"<i>Hmm, if you keep doing that, I won't be able to keep it inside for you.</i>\"");

	outputText("\n\nYou tell [arian em] that would be a crying shame, and gently remove your fingers.  Arian whimpers in disappointment.  \"<i>Awww, I was fine with having a handjob instead.</i>\"  [arian Ey] smiles mischievously at you.");

	outputText("\n\nOh no, you tell [arian em]; you started out with something more unusual in mind, and you're going to finish it.  Quickly giving your own [cock smallest] a few strokes to help coax it into the right mindset, you aim it into Arian's cock-slit and, looping your arms around [arian eir] neck for balance, begin to press forward and gently feed it into the literal boy-pussy.");

	outputText("\n\nThe fit is so very tight, warmer than the rest of [arian em] for reasons you don't care enough to contemplate at this moment, and slick with lubricating fluids.  It's so strange, yet so hot... and once you have your [cock smallest]");
	if(flags[kFLAGS.ARIAN_DOUBLE_COCK] == 0) outputText(" brushing up against [arian eir] own lizan pecker");
	else outputText("sandwiched between [arian eir] two lizard dicks");
	outputText(", the friction is absolutely incredible, sending sparks of pleasure cascading along your shaft.  You moan in delicious lust and tell Arian that this is absolutely incredible.");

	outputText("\n\n[arian Eir] expression is difficult to read; you can tell there is an obvious discomfort in the lizan's face, but at the same time, [arian ey]'s panting in excitement.  \"<i>Ugh, It feels stuffed... but also good.  Your cock rubbing against my own... t-try moving your hips.</i>\"");

	outputText("\n\nYou shift your arms from around [arian eir] neck to around [arian eir] waist and do as [arian ey] asks, pulling your hips back and then inserting them forward, just like you were trying to fuck a pussy.  The slimy, knobbly, bulbous texture of [arian eir] ");
	if(flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText("twin cocks");
	else outputText("cock");
	outputText(" slides across your intruding shaft as you go, and [arian eir] sheathe-walls grip and squeeze as best they can, leaving you moaning and panting like a bitch in heat.  Arian's moans of pleasure join yours, [arian eir] twitching bulbous shaft");
	if(flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText("s");
	outputText(" massaging your [cock smallest] almost like a vagina would.  Shaky hands grab a hold of your shoulders, helping you down and up on Arian's male slit.  \"<i>Oh, Marae!  It feels like I'm getting an internal handjob... it feEels so... so good!  H - harder... almost cumming!</i>\" [arian ey] pleads, as [arian ey] breathes hotly on your face; panting like a bitch in heat.");

	outputText("\n\nNot, you gasp back, if you don't come first... With that desperate promise (warning? Plea? Who cares?) you piston yourself back and forth four more times and then howl at the ceiling above as you cum into Arian's makeshift vagina.");

	//(Low Cum Amount)
	if(player.cumQ() < 250) {
		outputText("\n\nEven if your load is not that big to begin with; there is little room inside Arian's cramped genital slit, and you soon find yourself overflowing the little crevice.");
	}
	//(Medium Cum Amount)
	else if(player.cumQ() < 1000) {
		outputText("\n\nYour load is big enough to give females a bit of a potbelly, but Arian's slit being so shallow by comparison, means your cum practically erupts out of [arian eir] overfilled crevice.");
	}
	//(high Cum Amount)
	else {
		outputText("\n\nYour prodigious load is so huge, not even goblins can hope to hold all of it inside.  So it's no wonder all it takes is a single jet to make Arian's little crevice erupt with backflow of your cum, painting your belly as well as [arian eirs] with a perverted geyser of white.");
	}

	outputText("\n\nSpent, you slump down on the lizan's [arian chest].  With a sense of urgency Arian looks pleadingly at you, feebly pushing your shoulders away.  \"<i>P-pull out, please!</i>\"");

	outputText("\n\nYou ask [arian em] what's wrong, too caught up in the feelings of your release to obey [arian em] immediately. \"<i>Need... to cum... no room!</i>\" [arian ey] says, groaning.  Realizing what's wrong, you hasten to obey - you don't want [arian em] to burst!  You pull your cum-slick shaft from [arian eir] cock-slit, waiting to see if [arian ey]'ll manage to poke [arian eir] own cock");
	if(flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText("s");
	outputText(" out before cumming.");

	outputText("\n\nArian groans in relief as a small white eruption comes out of [arian eir] cum-filled slit, soaking [arian eir] white scales in your combined jism.  Then, a ");
	if(flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText("pair of cummy masts emerge");
	else outputText("cummy mast emerges");
	outputText(" to feebly shoot a couple more ropes of jism, before returning limply to ");
	if(flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText("their");
	else outputText("its");
	outputText(" hiding place.  \"<i>Ahhh,</i>\" is all Arian says, before slumping down.");

	outputText("\n\nYou pat [arian em] on the shoulder in a friendly fashion and, with a wicked grin on your face, ask if [arian ey] enjoyed that too.");

	outputText("\n\nArian sighs and looks at you.  \"<i>It was good.  Weird... but good.  Though, I don't think I'd ever felt so much pressure on my balls before; if you hadn't pulled out in time, I might have busted a nut.</i>\"  [arian Ey] smiles tiredly.");

	outputText("\n\nYou draw [arian em] into a deep kiss, holding [arian em] tight and kissing [arian em] until [arian eir] need for air forces you to disengage. Cocking your head to the side, you stroke [arian eir] face gently, telling [arian em] that you're glad [arian ey] wasn't hurt. After all, you need your little lap-lizard in tiptop shape.");

	outputText("\n\nArian gives you a winning grin.  \"<i>I wonder why,</i>\"  [arian ey] says, rubbing at [arian eir] used slit.");

	outputText("\n\nYou tell [arian em] the sex is nice, but there's other things in [arian eir] favor too.  Then, you kiss [arian em] again before [arian ey] can ask what those are.  While [arian ey]'s left reeling, blissed out and goofy from the sexual overwhelm, you quietly slip out of [arian eir] bed, pull your clothes back on and slip away, blowing [arian em] a kiss before you depart.");

	//Player returns to camp
	player.sexReward("cum","Dick");
	dynStats("sen", 1);
	doNext(camp.returnToCampUseOneHour);
}

//Give Item
private function giveArianAnItem():void {
	clearOutput();
	outputText("Thinking about the many items in your possession, you ask if Arian would be willing to take something for you?");

	//(if ArianHealth < 10) //May not give anything.
	if(flags[kFLAGS.ARIAN_HEALTH] < 10) {
		outputText("\n\n\"<i>Uhh... I'd rather not.  I'm not feeling very well, and I don't think it's wise for me to be drinking anything, well... strange.</i>\"");

		outputText("\n\nYou nod your head in understanding and change the subject; if you want to give Arian any of the potions you've found, you'll need to nurse [arian em] back to strength first.");
		//Display other Arian interaction options
		arianHomeMenu();
		return;
	}
	else if(flags[kFLAGS.ARIAN_HEALTH] < 20) { //May only give Vitality T.
		outputText("\n\n\"<i>Is it medicine you've brought me?  If so I'll be happy to take it; otherwise I think we should wait until I'm better; especially after that scolding you gave me earlier...</i>\"");

		//If PC has Vitality T. go to Give VT section. Otherwise, play below:
		if(!player.hasItem(consumables.VITAL_T)) {
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
	if(flags[kFLAGS.ARIAN_HEALTH] >= 20) {
		addButton(0, consumables.P_DRAFT.shortName, giveIncubusDraftToArian)
			.disableIf(!player.hasItem(consumables.P_DRAFT), "You don't have any.");
		addButton(1, consumables.P_S_MLK.shortName, succubiMilkForArian)
			.disableIf(!player.hasItem(consumables.P_S_MLK), "You don't have any.");
		addButton(2, consumables.LACTAID.shortName, giveArianLactaid)
			.disableIf(!player.hasItem(consumables.LACTAID), "You don't have any.");
		addButton(3, consumables.REDUCTO.shortName, giveArianReducto)
			.disableIf(!player.hasItem(consumables.REDUCTO), "You don't have any.");
		addButton(4, consumables.REPTLUM.shortName, giveArianReptilum)
			.disableIf(!player.hasItem(consumables.REPTLUM), "You don't have any.");
		if(arianFollower() && flags[kFLAGS.ARIAN_SCALES] != 0) {
			if(flags[kFLAGS.ARIAN_SCALES] != 1) addButton(5, useables.VIALCLE.shortName, giveArianScalesDyeVial1)
				.disableIf(!player.hasItem(useables.VIALCLE), "You don't have any.");
			if(flags[kFLAGS.ARIAN_SCALES] != 2) addButton(6, useables.VIALTUR.shortName, giveArianScalesDyeVial2)
				.disableIf(!player.hasItem(useables.VIALTUR), "You don't have any.");
			if(flags[kFLAGS.ARIAN_SCALES] != 3) addButton(7, useables.VIALPIN.shortName, giveArianScalesDyeVial3)
				.disableIf(!player.hasItem(useables.VIALPIN), "You don't have any.");
			if(flags[kFLAGS.ARIAN_SCALES] != 4) addButton(8, useables.VIALRAI.shortName, giveArianScalesDyeVial4)
				.disableIf(!player.hasItem(useables.VIALRAI), "You don't have any.");
		}
	}
	if (flags[kFLAGS.ARIAN_HEALTH] < 100) addButton(10,"Vital Tinct",arianVitalityTincture)
			.disableIf(!player.hasItem(consumables.VITAL_T), "You don't have any.");
	addButton(14,"Back",arianHomeMenu, true);
}

//Vitality Tincture:
//increases ArianHealth by 4.
//Remove this option once Arian's health hits 100.
private function arianVitalityTincture():void {
	clearOutput();
	outputText("Fishing around amongst your pockets, you withdraw a vial of that strange potion Giacomo peddles and offer it to the sickly lizan, explaining it will bolster [arian eir] constitution and fill [arian em] with permanent vitality.");

	outputText("\n\nArian smiles gratefully at you.  \"<i>Thanks for doing this for me, [name].</i>\"");

	outputText("\n\nYou tell [arian em] it's no trouble, then smirk and note it's not as if that sleazy peddler's hard to find out there in the wasteland, anyway.  You see the look on the lizan's face and hasten to assure [arian em] that you're certain the potion works, you just don't trust that weasely merchant as far as you can throw him.");

	outputText("\n\n\"<i>If you say so...</i>\" Arian takes the potion and uncorks the vial.  \"<i>Here goes.</i>\"  [arian Ey] chugs the potion down at once, making a face once [arian ey]'s done.  \"<i>Ugh... If I didn't know better I'd say you're trying to murder my taste buds.</i>\"");

	outputText("\n\nSurely it's not that bad?  The potion smelled vaguely like cherries, it can't be as bad as [arian ey]'s is making it to be...");

	outputText("\n\nArian shakes [arian eir] head.  \"<i>It's medicine... medicine is never good.  And it has cherries.  I hate cherries,</i>\" Arian notes in disgust.");

	outputText("\n\nYou apologize, but, hey, medicine just tends to taste nasty anyway.  Still, it's doing [arian em] the world of good, now isn't it?");

	outputText("\n\n\"<i>I guess I do feel better.  Thank you [name].</i>\" Arian smiles at you, already looking a bit better.");
    if (arianHealth(10) == 100)
        outputText(" \"<i>In fact... I don't think I need those potions anymore. I'll probably keep a couple of them just in case, but since I don't use my magic too often these days, I'm completely fine.</i>\"");

	outputText("\n\nYou smile and stroke the lizan gently on [arian eir] head, telling [arian em] that [arian ey]'s welcome.  Now, you think it's time [arian ey] laid [arian em]self back down and got some rest; give the medicine time to work.  You promise you'll try and come back to see [arian em] later, but right now, [arian ey] needs to get some more rest.  Arian nods and settles [arian em]self on [arian eir] bed.");

	player.consumeItem(consumables.VITAL_T);
	doNext(camp.returnToCampUseOneHour);
}

//P. Incubus Draft:
//Increase Cock(s) size. Gives one cock if Arian lacks any.
//If cock(s) size is maxed, next dose reduces breast size.
//If at min breast size, next dose reverts Arian to male. (Lose breasts and vagina.)
private function giveIncubusDraftToArian():void {
	clearOutput();
	player.consumeItem(consumables.P_DRAFT);
	outputText("Fishing around in your pockets, your hand closes on the vial of purified incubus draft.  You offer this to Arian, asking if [arian ey] would like to ");
	if(flags[kFLAGS.ARIAN_COCK_SIZE] > 0) outputText("make [arian eir] cock bigger");
	else outputText("have a touch of [arian eir] old malehood back");
	outputText(".");

	outputText("\n\nArian blushes.  \"<i>I don't mind the way I am now, but if you want me to take it I'd be happy to.</i>\"  Arian smiles nervously at you.");

	outputText("\n\nYou tell [arian em] that you would like [arian em] to take it, and hold it out to the lizan with greater emphasis.  Arian takes the draft, uncorks it and chugs it down.");

	if(flags[kFLAGS.ARIAN_COCK_SIZE] == 0) {
		flags[kFLAGS.ARIAN_COCK_SIZE]++;
		outputText("\n\nThe changes start at once.  Arian shudders as a wave of arousal hits [arian em] and quickly opens [arian eir] robes to watch in awe as a slit appears above [arian eir] juicy feminine cunt.  It overflows with natural lubricant, and for a moment you think Arian is growing a second vagina.  The thought is quickly forgotten as you watch a reptilian, bulbous, purple dick emerge from its depths; it grows to an average size before Arian moans and cums, spraying [arian emself] with [arian eir] newly acquired tool.");

		outputText("\n\nYou make a show of smirking and shaking your head.  My, but Arian needs to work on [arian eir] control, now doesn't [arian ey]?  To think [arian ey]'d cum just from growing a sweet little cock like this.  You reach out and stroke the hermaphroditic member, gently trailing your fingers across its reptilian bumps and nodules.  A tiny part of you shivers in anticipation of it plumbing into your ");
		if(player.hasVagina()) outputText("[vagina] and ");
		outputText("[asshole].");

		outputText("\n\n\"<i>Wait!  I'm still sensi-Ahhh!</i>\"  Arian's shaft throbs and another jet of cum arches through the air to hit [arian em] squarely on [arian eir] face.  Panting, Arian says, \"<i>I-I think I need a rest now...</i>\"  [arian Ey] collapses on [arian eir] bed, prehensile, reptilian tail waving about in a display of enjoyment.");

		outputText("\n\nA part of you wonders if maybe [arian ey]'s hoping you'll join [arian em] in bed, but then you take a closer look and concede that [arian ey] is genuinely tired.  You stroke [arian em] affectionately on [arian eir] scaly cheek and politely excuse yourself, heading back to camp.");
		dynStats("lus", 10+player.lib/20, "scale", false);
	}
	else if(flags[kFLAGS.ARIAN_COCK_SIZE] < 3) {
		flags[kFLAGS.ARIAN_COCK_SIZE]++;
		dynStats("lus", 10+player.lib/20, "scale", false);
		outputText("\n\nThe changes start at once. Arian shudders as a wave of arousal hits [arian em] and quickly opens [arian eir] robes to watch [arian eir] ");
		if(flags[kFLAGS.ARIAN_DOUBLE_COCK] == 0) outputText("shaft emerges from its hiding place.  It throbs and grows, settling in its");
		else outputText("pair of shafts emerge from their hiding place.  They throb and grow, settling in their");
		outputText(" new size as Arian moans and cums all over [arian em]self.");

		outputText("\n\nYou gently flick a strand of cum off of the lizan's belly.  So, how does [arian ey] like the new and improved lizard cock?  Arian swallows audibly and tries to retract [arian eir] cock");
		if(flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText("s back into their");
		else outputText(" back into its");
		outputText(" slit.");
		if(flags[kFLAGS.ARIAN_COCK_SIZE] == 2) {
			dynStats("lus", 10+player.lib/20, "scale", false);
			outputText("\n\n[arian Ey] manages to tuck it in, although you have the impression you wouldn't have to reach too far inside to feel its tip.");

			outputText("\n\n\"<i>It's a tight fit, but I think I can still keep it inside,</i>\" Arian sighs in pleasure.  \"<i>It did feel good though; thank you, [name].</i>\"");

			outputText("\n\nYou smirk and tell [arian em] that maybe you'll ask [arian em] to show you how it feels in an up-close and private demonstration later, but, for now, you'll let [arian em] get some sleep.  Arian nods, blushing.  \"<i>I'm looking forward to it.</i>\"  [arian Ey] smiles nervously at you.");

			outputText("\n\nYou smirk and pat [arian eir] head, tell [arian em] you'll come back for it when you can, and then politely excuse yourself.");
		}
		else {
			outputText("\n\n[arian Ey] manages to retract ");
			if(flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText("them");
			else outputText("it");
			outputText(" until two thirds are inside, then it doesn't look like [arian ey] can take in anymore.\n\n\"<i>W-Wow, ");

			if(flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText("they're so big I can't even manage to hide them,</i>\" Arian pants as the tip of [arian eir] cocks hang");
			else outputText("\n\n\"it's so big I can't even manage to hide it,</i>\" Arian pants as the tip of [arian eir] cock hangs");
			outputText(" limply, exposed for all to see.");

			outputText("\n\nYou can't resist reaching down and gently tweaking the exposed tip.  Mmm... your little " + arianMF("boy-toy","herm-toy") + " is going to be a very naughty thing from now on, you tease, unless [arian ey] intends to start wearing a loincloth?");

			outputText("\n\nArian shudders at your touch.  \"<i>I-I'd have to ask Boon for one of [arian eir].  I don't have any here.</i>\"  Arian blushes.");

			outputText("\n\nYou smile playfully at [arian em] and ask if [arian ey] would like you to go and fetch one now?");

			outputText("\n\n\"<i>N-No!  I couldn't stand it if Boon and Laika found out I look like this,</i>\" Arian says, pointing towards [arian eir] exposed shaft");
			if(flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText("s");
			outputText(".");

			//if ArianHerm:
			if(flags[kFLAGS.ARIAN_VAGINA] > 0) {
				outputText("\n\nYou can't resist quirking an eyebrow and asking if this is really more embarrassing than revealing that [arian ey]'d grown an egg-filled womb and a pussy to use with it?  \"<i>Well, yes!  They'll give you a hard time too for getting me to do this, you know?</i>\" Arian protests.");

				outputText("\n\nYou smile and tap [arian em] playfully on the nose, pointing out the difference between you and [arian em] is that you don't care what two overprotective ferrets have to say about how [arian ey] looks.  You think [arian ey]'s hot like this.  Arian blushes at that.  \"<i>Then... I'll go without wearing a loincloth?</i>\"  You tell [arian em] that'd be very naughty, but you think it'd be kind of sexy, too.  Arian smiles nervously, \"<i>Ok, then that's what I'll do... c-can't wait to use it...</i>\" [arian Eir] tip");
				if(flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText("s start");
				else outputText(" starts");
				outputText(" hardening, no longer able to hide [arian eir] excitement inside [arian eir] protective slit.");
			}
			else {
				outputText("\n\nYou admit it probably would be a bit embarrassing, especially if Boon's bigger than Arian is now.  [arian Ey] blushes.  \"<i>Well, he really isn't. If anything it might be tight.  I might have to go without one...</i>\"");

				outputText("\n\nYou raise an eyebrow, and ask if [arian ey]'s not secretly at least a little happy about that?  After all, big dicks seem to be pretty admired in this sex-mad world.  Arian looks away in embarrassment, but smiles all the same.  \"<i>It is pretty big, isn't it?  I guess it's not that bad.</i>\"");

				outputText("\n\nYou point out you wouldn't have given the lizan such a big dick if you didn't think they were sexy.  To be honest, you'd kind of like to know [arian ey] was going around with this impressive monster hanging out under [arian eir] robes; it's very flattering.  \"<i>T-then I won't use one.</i>\"  Arian's cock hardens a bit.  \"<i>Although it might be hard to hide my... urges.</i>\"  Arian looks at you nervously.");
			}
			outputText("\n\nYou give the lizan a kiss on the cheek, and ask if [arian ey]'s sure [arian ey] doesn't want to give it a test run before you go.  Arian's cock hardens, pointing at you and throbbing at the idea, even as a small droplet of cum gathers on [arian eir] tip; Arian fumbles and makes an attempt to hide [arian eir] excitement.  \"<i>T-this is going to take some getting used to...</i>\"");

			outputText("\n\nYou apologize and tell the lizan you've teased [arian em] enough; you'll give [arian em] a chance to calm down, and politely excuse yourself to head back to camp.");
		}
	}
	//(else if ArianBreasts > 1) //Boob shrinkage.
	else if(flags[kFLAGS.ARIAN_BREASTS] > 1 && (!flags[kFLAGS.HYPER_HAPPY])) {
		flags[kFLAGS.ARIAN_BREASTS]--;
		outputText("\n\nArian shudders as [arian ey] feels the changes sweep through [arian em], but rather than settling on [arian eir] huge lizan shaft, the warmth that precedes change settles on [arian eir] breasts.  Arian moans and kneads [arian eir] mounds as they shrink to a smaller size.");
		outputText("\n\n\"<i>Well, at least my chest won't feel so heavy anymore.  I hope you're not disappointed?</i>\" Arian asks, panting.");
		outputText("\n\nYou just smile back at [arian em] and tell [arian em] you can live with it.  Arian sighs.  \"<i>Good, they did feel kinda nice, though.</i>\"  You detect a hint of disappointment in [arian eir] voice.");
		outputText("\n\nConfused, you comment that [arian ey] was hatched as a boy; you'd have thought [arian ey]'d be more comfortable to be flatter up there.  [arian Ey] blushes. \"<i>I-....  You've convinced me there are... perks related to that.</i>\"  [arian Ey] bites [arian eir] lower lip.  \"<i>Not that I miss having big breasts.  My back will also thank me, but they did feel nice and....</i>\"  Arian giggles.  \"<i>Laika would always give me the funniest looks, since she's kinda... flat.</i>\"");

		outputText("\n\nYou wonder if maybe Laika had ulterior motives for those looks, but keep that thought to yourself. You ask if Arian would like to do something, or if you should leave [arian em] to get on with [arian eir] work? [arian Ey] looks at you expectantly. \"<i>I wouldn't refuse if you wanted to do anything.</i>\", [arian eir] dick growing hard at your suggestion.");
		//Display sex menu
		arianSexMenu(false);
		return;
	}
	else if(flags[kFLAGS.ARIAN_BREASTS] == 1 && (!flags[kFLAGS.HYPER_HAPPY])) {
		outputText("\n\nArian shudders as [arian ey] feels the changes sweep through [arian em], but rather than settling on [arian eir] huge lizan shaft, the warmth that precedes change settles on [arian eir] breasts.  Arian moans and kneads [arian eir] mounds as they shrink until they are completely gone.  [arian Eir] nipples follow suit, being replaced by smooth scales.");
		flags[kFLAGS.ARIAN_BREASTS] = 0;
		if (rand(6) == 0) { //Now she's a maleherm
			outputText("\n\nA few more subtle changes occur as Arian's body shift towards the masculine and finally settles down. [arian Ey] breaths a sigh of relief.");
			outputText("\n\n\"<i>I guess I'm a typical Lizan herm--or maleherm now?<i>\" Arian's voice sounds more masculine as well.");
			outputText("\n\nYou note that seems to be the case. So, is [arian ey] going to miss being even half-girl? Arian rubs [arian eir] chin.  \"<i>Well, it was weird, but it was kinda nice too.</i>\"  [arian Ey] looks at you, smiling nervously.  \"<i>I'd spend some time in the mornings looking in the mirror.  I guess I didn't look so bad as a girly-herm?</i>\"");
			outputText("\n\nYou note that [arian ey] was quite pretty, but you think [arian ey]'s just as handsome now.");

			outputText("\n\nArian rubs [arian eir] belly. \"<i>At least I can still lay eggs.</i>\"");
			outputText("\n\nYou raise an eyebrow at this; isn't it painful for [arian em]?");
			outputText("\n\n[arian Ey] smiles at you. \"<i>It doesn't hurt that much.</i>\" Then [arian ey] blushes. \"<i>It feels kinda nice... actually</i>\"");

			outputText("\n\nYou just shake your head and clap [arian em] on the shoulder. Well, maybe you'll leave [arian em] like this, if [arian ey]'s really happy being a maleherm.");
			outputText("\n\nArian averts [arian eir] eyes. \"<i>W-well, I do enjoy this... but I also won't mind changing... if that's what you want.</i>\"");
			outputText("\n\nYou'll keep that in mind, you let [arian em] know.");
		}
		else { //Now she's male again
			outputText("\n\nArian moans as another change happens below; [arian ey] spreads [arian eir] legs and watches in wonder as the lips of [arian eir] wet fuckhole join together, becoming smooth scales as well.  A few more subtle changes occur as Arian's body shift towards the masculine and finally settles down.  Arian breaths a sigh of relief.");

			outputText("\n\n\"<i>I guess I'm male now?</i>\" Arian's voice sounds more masculine as well.");
			flags[kFLAGS.ARIAN_VAGINA] = 0;
			outputText("\n\nYou note that seems to be the case.  So, is [arian ey] going to miss being even half-girl?  Arian rubs [arian eir] chin.  \"<i>Well, it was weird, but it was kinda nice too.</i>\"  [arian Ey] looks at you, smiling nervously.  \"<i>I'd spend some time in the mornings looking in the mirror.  I guess I didn't look so bad as a girl?</i>\"");
			outputText("\n\nYou note that [arian ey] was quite pretty, but you think [arian ey]'s just as handsome now.  Besides, being all-guy means no more dealing with eggs, right?");
			outputText("\n\nArian blushes, averting [arian eir] eyes in embarrassment.  \"<i>It wasn't that bad... the whole deal with the eggs I mean.</i>\"");
			outputText("\n\n[arian Ey] can really say that?  After actually going through the painful process of laying them?  Because, if [arian ey] can, well, you think you'd have to call Arian one of the manliest men you've met in this world.");

			outputText("\n\nArian smiles at you.  \"<i>It didn't hurt that much.</i>\"  Then [arian ey] blushes.  \"<i>It felt kinda nice... actually.</i>\"");

			outputText("\n\nYou just shake your head and clap [arian em] on the shoulder.  Well, maybe you'll give [arian em] [arian eir] vagina back, if [arian ey] really didn't mind being half-girl that much.  But, right now, you think [arian ey] should try and get used to being all-man again.");

			outputText("\n\nArian averts [arian eir] eyes.  \"<i>Of course.  If that's what you think.</i>\"");

			outputText("\n\nYou reply that is what you think.  So, does [arian ey] feel up to doing anything else, or should you leave [arian em] to get some rest?");

			outputText("\n\nArian's cock begins hardening.  \"<i>Well, I wouldn't mind doing anything else... if you want to.</i>\"");

	}}
	else if(flags[kFLAGS.ARIAN_VAGINA] > 0 && (!flags[kFLAGS.HYPER_HAPPY])){
		outputText("\n\nArian shudders as [arian ey] feels the changes sweep through [arian em], but rather than settling on [arian eir] huge lizan shaft, the warmth that precedes change settles between [arian eir] legs, and [arian ey] watches in wonder as the lips of [arian eir] wet fuckhole join together, becoming smooth scales as well. \"<i>I guess I'm male now?</i>\"");
		flags[kFLAGS.ARIAN_VAGINA] = 0;
		outputText("\n\nYou note that seems to be the case.  So, is [arian ey] going to miss being a maleherm?  Arian rubs [arian eir] chin.  \"<i>Well, it was weird, but it was kinda nice too.</i>\"  [arian Ey] looks at you, smiling nervously.");
		outputText("\n\nYou note that being all-guy means no more dealing with eggs, right?");
		outputText("\n\nArian blushes, averting [arian eir] eyes in embarrassment.  \"<i>It wasn't that bad... the whole deal with the eggs I mean.</i>\"");
		outputText("\n\nHe can really say that?  After actually going through the painful process of laying them?  Because, if [arian ey] can, well, you think you'd have to call Arian one of the manliest men you've met in this world.");

		outputText("\n\nArian smiles at you.  \"<i>It didn't hurt that much.</i>\"  Then [arian ey] blushes.  \"<i>It felt kinda nice... actually.</i>\"");

		outputText("\n\nYou just shake your head and clap [arian em] on the shoulder.  Well, maybe you'll give [arian em] [arian eir] vagina back, if [arian ey] really didn't mind being half-girl that much.  But, right now, you think [arian ey] should try and get used to being all-man again.");

		outputText("\n\nArian averts [arian eir] eyes.  \"<i>Of course.  If that's what you think.</i>\"");

		outputText("\n\nYou reply that is what you think.  So, does [arian ey] feel up to doing anything else, or should you leave [arian em] to get some rest?");

		outputText("\n\nArian's cock begins hardening.  \"<i>Well, I wouldn't mind doing anything else... if you want to.</i>\"");
	}
	else { //Nothing happens.
		outputText("\n\nArian moans and you can see [arian ey]'s getting turned on, if the hardening tip");
		if(flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText("s of [arian eir] exposed shafts are");
		else outputText(" of [arian eir] exposed shaft is");
		outputText(" any indication, but you don't detect any change besides that.");
		outputText("\n\n\"<i>I guess this is my limit?</i>\" Arian pants.");
		outputText("\n\nYou admit that seems to be the case, and ask if [arian ey]'d be willing to do something else, seeing as how that was a bust?  \"<i>Uhh... Sure.  What do you want to do?</i>\"");
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
	if(flags[kFLAGS.ARIAN_VAGINA] > 0) outputText("further ");
	outputText("in touch with [arian eir] feminine side.  For you?");

	outputText("\n\nArian bites [arian eir] lower lip.  \"<i>For you?  Of course I wouldn't mind it.</i>\"  You pass over the bottle, and watch as [arian ey] removes the cork and drinks its contents.");

	//(if ArianVagina == 0) //Arian... you look so pretty!
	if(flags[kFLAGS.ARIAN_VAGINA] == 0) {
		flags[kFLAGS.ARIAN_VAGINA]++;
		if(flags[kFLAGS.ARIAN_BREASTS] == 0) flags[kFLAGS.ARIAN_BREASTS]++;

		outputText("\n\nArian gasps and moans, a throaty, girly moan. [arian Ey] opens [arian eir] robes to watch as the changes sweep through [arian em].  First the smooth scales of [arian eir] chest begin flaking off, making way for a pair of erect nipples; following the growth of said nipples, [arian eir] previously flat chest begins inflating, growing into perky scaly breasts.  Down below, Arian feels a wave of heat gather between [arian eir] legs; once [arian ey] spreads them, [arian ey] gasps.  A slit appears, the surrounding scales become smaller and softer, forming what looks like a tight little pussy.  [arian Eir] newly formed labia puff up and juices begin flowing freely from the moist passage, even as Arian's little pleasure buzzer appears to slightly part [arian eir] labia in a clear invitation for you to explore its depths.");
		outputText("\n\nYou drag your eyes away from Arian's new vagina and look the newly hermified lizan in the eyes, asking if [arian ey] feels all right. [arian Ey] pants, questing hands wandering towards [arian eir] breasts to gently grope them. \"<i>Hot... so hot...</i>\" Arian's shaft");
		if(flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText("s harden fully out of their");
		else outputText(" hardens fully out of its");
		outputText(" hiding place, rock hard and throbbing.");
		outputText("\n\nYou tell [arian em] you'll get [arian em] something cold to drink, turning towards the door.  \"<i>H-hurry, please!</i>\"  You need no further encouragement and quickly race to the kitchen, where you grab a jug of water from the coldbox and run back with it, as quickly as you dare.");

		outputText("\n\nAs soon as you enter Arian's room, [arian ey] sweeps the jug from your hands and begins downing the water.  You watch in amazement as [arian ey] drains the jug of all its water, some stray droplets falling on [arian eir] exposed scales, forming small rivulets that trace [arian eir] increasingly feminine curves.  Once Arian is done [arian ey] sighs with relief, quietly handing you the jug and wiping [arian eir] lips with a forearm.  \"<i>Thanks, [name].  I really needed that.</i>\" [arian Ey] smiles at you, no longer hot to the point of boiling.  [arian Eir] previously erect cock");
		if(flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText("s");
		outputText(" having already softened and retracted");
		//if ArianCockSize >= 3:
		if(flags[kFLAGS.ARIAN_COCK_SIZE] == 3) outputText(" as far as it'll go");
		outputText(" into its protective slit.");

		outputText("\n\nYou cautiously ask if Arian is feeling okay; [arian ey]'s just undergone quite the dramatic change. [arian Ey] looks [arian emself] over, running [arian eir] hands across [arian eir] newly feminized body.  \"<i>I guess I'm fine.  I certainly feel fine, at least.</i>\"");

		outputText("\n\nYou can't help noting [arian ey] looks pretty fine, too.  Arian blushes at your comment.  \"<i>Umm... thanks.</i>\"  One of Arian's questing hands find [arian eir] newly formed slit, and [arian ey] gasps in pleasure as [arian ey] circles [arian eir] soft labia with a clawed finger, smearing some of [arian eir] juices on [arian eir] finger.  [arian Ey] lifts the finger to [arian eir] face and watch the moisture drip from [arian eir] digit; then, without sparing a thought, [arian ey] takes the finger into [arian eir] mouth and begins lightly sucking on the digit.");

		outputText("\n\nYou pointedly cough and tell [arian em] that, while you're not necessarily minding if [arian ey] wants to try out [arian eir] new body, does [arian ey] really want to put on a show for you, or would [arian ey] rather you leave?  Arian snaps out of [arian eir] trance, blushing in embarrassment.  \"<i>Oh! Sorry!</i>\"  Arian attempts to cover [arian eir] breasts and crotch with [arian eir] arms. [arian Ey] fidgets a bit, then smiles nervously at you.  \"<i>Umm, Maybe you'd like to help me get used to my new body?</i>\" Arian averts [arian eir] eyes, blushing furiously at what [arian ey] just said.");
		outputText("\n\nYou step forward and gently run your hands over [arian eir] newfound breasts. Well, if that's what [arian ey]'s in the mood for, you're game.");

	}
	else if(flags[kFLAGS.ARIAN_BREASTS] < 1) { //Flat chest grows
		flags[kFLAGS.ARIAN_BREASTS]++;
		outputText("\n\nWarmth sweeps through Arian's body, eliciting a gasp and a moan. Soon the warmth settles on [arian eir] chest, and [arian ey] opens [arian eir] robes to gaze at the change that is taking place.");
		outputText("\n\nYou both watch as the smooth scales of [arian eir] chest begin flaking off, making way for a pair of erect nipples; following the growth of said nipples, [arian eir] previously flat chest begins inflating, growing into perky scaly breasts.");
		outputText("\n\nArian gropes [arian eir] newly formed breasts tentatively and gasps in pleasure at their softness and sensitivity. \"<i>It feels nice.</i>\"  Looking at you with a blush, Arian asks, \"<i>Would you like to touch them?</i>\"");

		outputText("\n\nSeeing no reason to pass up the opportunity, you reach out and gently take hold of them, rolling their weight around in your hands.  You make a show of remarking to Arian that you had no idea scaly boobs could be so wonderfully soft and perky.");

		outputText("\n\nArian gasps and sighs as you gently massage [arian eir] breasts.  \"<i>[name]... this feels good.</i>\"");

		outputText("\n\nYou note it feels pretty nice for you as well.  Still, does [arian ey] maybe want to turn things up a notch in the intimacy department?  Arian blushes.  \"<i>You won't hear me complain.</i>\"  [arian Ey] starts fidgeting");
			if(flags[kFLAGS.ARIAN_COCK_SIZE] >= 3) outputText(" and [arian eir] exposed shaft begins to grow hard");
			outputText(".");
	}
	else if(flags[kFLAGS.ARIAN_BREASTS] < 3 && flags[kFLAGS.ARIAN_BREASTS] > 0) {
		flags[kFLAGS.ARIAN_BREASTS]++;
		outputText("\n\nWarmth sweeps through Arian's body, eliciting a gasp and a moan.  Soon the warmth settles on [arian eir] mounds, and [arian ey] opens [arian eir] robes to gaze at the change that is taking place.");

		//(if ArianBreasts == 2)
		if(flags[kFLAGS.ARIAN_BREASTS] == 2) {
			outputText("\n\nArian's perky breasts inflate into perfect, soft-looking mounds.  Arian gropes [arian eir] newly enlarged breasts tentatively and gasps in pleasure at their softness and sensitivity.  \"<i>It feels nice.</i>\"  Looking at you with a blush, Arian asks, \"<i>Would you like to touch them?</i>\"");

			outputText("\n\nSeeing no reason to pass up the opportunity, you reach out and gently take hold of them, rolling their weight around in your hands.  You make a show of remarking to Arian that you had no idea scaly boobs could be so wonderfully soft and perky.");

			outputText("\n\nArian gasps and sighs as you gently massage [arian eir] breasts.  \"<i>[name]... this feels good.</i>\"");

			outputText("\n\nYou note it feels pretty nice for you as well.  Still, does Arian maybe want to turn things up a notch in the intimacy department?  Arian blushes.  \"<i>You won't hear me complain.</i>\"  [arian Ey] starts fidgeting");
			if(flags[kFLAGS.ARIAN_COCK_SIZE] >= 3) outputText(" and [arian eir] exposed shaft begins to grow hard");
			outputText(".");
		}
		else {
			outputText("\n\nArian's generous mounds inflate once more. [arian Ey] gasps in pleasure, their growth also enhancing the lizan's sensitivity.  Once their expansion is finished, Arian lifts the huge orbs in awe.  \"<i>T-they're huge... and so heavy.</i>\"  [arian Ey] rolls the breasts in [arian eir] hands, gently touching [arian eir] soft scales and sensitive nipples, gasping and panting in pleasure.");

			outputText("\n\nYou note they look pretty big as well; why, [arian ey] must be the bustiest lizan you've ever seen.  Arian blushes, and bites [arian eir] lower lip.  \"<i>Do you like them?</i>\"  You give [arian em] a flat look and reach out to caress the breasts.  If you didn't like big breasts, well, why would you have asked [arian em] to grow them this big?  But is [arian ey] comfortable with them being like this?");
			outputText("\n\nArian shudders at your touch.  \"<i>They are kind of heavy, but if you really like them, I don't mind keeping them.</i>\" [arian Ey] smiles nervously at you.  \"<i>I hope you will help me carry them?</i>\"  [arian Ey] fidgets");
			if(flags[kFLAGS.ARIAN_COCK_SIZE] == 3) outputText(" and you see [arian eir] exposed shaft slowly rising to point at you");
			outputText(".");

			outputText("\n\nYou cup the bountiful scaly bosom in your hands and tell [arian em] that's something you're quite willing to do.  Still, perhaps [arian ey]'d rather... take the weight off of [arian eir] feet, mm?  You finish, leaning in to dart a playful lick across the tip of [arian eir] snout to make your insinuations more obvious.");
			outputText("\n\nArian blushes furiously, but smiles at you all the same.  \"<i>I... would love to.</i>\"");
		}
	}
	//(else If ArianCockSize > 1) //Dick shrinkage.
	else if(flags[kFLAGS.ARIAN_COCK_SIZE] > 1 && (!flags[kFLAGS.HYPER_HAPPY])){
		outputText("\n\nWarmth flows throughout Arian's body, and [arian ey] moans in obvious pleasure.  Then, [arian ey] opens [arian eir] robes and looks at [arian eir] rock-hard bulbous shaft.  It throbs as if edging a massive orgasm, but much to Arian's surprise it starts to shrink, until it finally grows limp and hides itself in its protective slit.  \"<i>I... didn't expect that,</i>\" [arian ey] remarks.");

		outputText("\n\nYou note it's not that surprising; the potion in question is a feminizer, so it must be shrinking away the only trace of [arian eir] masculinity left - [arian eir] cock");
		if(flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText("s");
		outputText(".  \"<i>Oh... that's good.  Right?</i>\" Arian looks at you nervously.  You think it over, and confess that while you are more attracted to women than men, you won't force Arian to become fully female if [arian ey] doesn't want to.");
		outputText("\n\nArian smiles at your consideration.  \"<i>Thank you, [name], but if you'd prefer me to be a girl... err... completely female, I wouldn't object.  I'm fine either way.</i>\" [arian Ey] grins.");

		outputText("\n\nYou ask, then, if Arian's so comfortable with [arian eir] girly side, maybe [arian ey]'d like to try out [arian eir] more female parts?  Arian blushes and averts [arian eir] eyes, nodding lightly.");
	}
	else if(flags[kFLAGS.ARIAN_COCK_SIZE] == 1 && flags[kFLAGS.ARIAN_DOUBLE_COCK] >= 1 && (!flags[kFLAGS.HYPER_HAPPY])) {
		outputText("\n\nWarmth flows throughout Arian's body, and [arian ey] moans in obvious pleasure.  Then [arian ey] opens [arian eir] robes and looks at [arian eir] pair of rock-hard bulbous shafts.  They throb as if edging a massive orgasm, but much to Arian's surprise they begin to merge, until only one reptilian dick remains; finally it grows limp and recedes into its hiding place.  \"<i>They fused into one,</i>\" Arian remarks.");

		outputText("\n\nMaybe it's because of the increasingly high femininity the milk is bestowing on [arian em], you suggest?");

		outputText("\n\n\"<i>Maybe... that's good, right?</i>\" Arian asks.  You simply meet [arian eir] gaze levelly and tell [arian em] that it's good if [arian ey] wants it to be good; if [arian ey]'s uncomfortable with what you're doing to [arian em], [arian ey] needs to tell you and you'll stop, you promise.");

		outputText("\n\n\"<i>No!  I'm fine!</i>\" Arian insists.  \"<i>I'm just not used to, well... reshaping my body like this.  But if you think I look better this way, then I'm happy to comply.</i>\"  Arian smiles.");

		outputText("\n\nYou tell [arian em] that, for what it's worth, you do think [arian ey]'s beautiful, then give [arian em] a lustful grin and ask if [arian ey]'d like you to show [arian em] just how beautiful?");
		outputText("\n\nArian blushes.  \"<i>I... show me...</i>\"");
		flags[kFLAGS.ARIAN_DOUBLE_COCK] = 0;
	}
	else if(flags[kFLAGS.ARIAN_COCK_SIZE] == 1 && (!flags[kFLAGS.HYPER_HAPPY])) {
		flags[kFLAGS.ARIAN_COCK_SIZE] = 0;
		outputText("\n\nWarmth flows throughout Arian's body, and [arian ey] moans in obvious pleasure.  Then, [arian ey] opens [arian eir] robes and look at [arian eir] rock-hard bulbous shaft.  It throbs and slowly recedes back into its hiding place.  An indignant rope of cum shoots into the air, splashing on [arian eir] belly as the slit containing the last of [arian eir] malehood finally closes up, leaving only smooth scales in its wake.  Arian pants, \"<i>Looks like I'm completely female now.</i>\"");

		outputText("\n\nYou agree with [arian eir] summary, and then note [arian ey]'s taking this quite calmly.  You mean, it had to be a shock just growing a pussy and laying eggs all the time, but now [arian ey] doesn't even have [arian eir] cock to go with it.");

		outputText("\n\nArian looks at you, blushing.  \"<i>Do you think I'm pretty?</i>\"");

		outputText("\n\nYou tell [arian eir] that, yes, [arian ey] makes a very pretty girl.");

		outputText("\n\nArian fidgets.  \"<i>Then, that's all I need.</i>\"  [arian Ey] smiles at you.");

		outputText("\n\nYou just look at [arian em] steadily; is [arian ey] really sure about that?  You did this to [arian em], surely you can bring [arian em] something to undo it, if only partially?");

		outputText("\n\nArian shakes [arian eir] head.  \"<i>I'm fine, [name].  Really. If I didn't want or wasn't okay with anything I'd have said so by now.  So trust me when I say I'm fine.  Besides, this doesn't feel half bad, and I get to have you.</i>\"  [arian Ey] blushes.");

		outputText("\n\n\"<i>Get to have you.... or perhaps,</i>\" you grin, \"<i>the proper question should be how, hmm?</i>\"");

		outputText("\n\nArian bites [arian eir] lower lip.  \"<i>Umm, we could do something I guess.  If you're up for it?</i>\"  Arian fidgets.");
	}
	else { //Nothing happens.
		outputText("\n\nWarmth flows throughout Arian's body, and [arian ey] moans in obvious pleasure.  But suddenly, the warmth goes away, and [arian ey] opens [arian eir] robes to inspect the changes.  Nothing seems changed.  \"<i>I guess I can't get any more girly than being an actual girl,</i>\" Arian remarks.");

		outputText("\n\nYou note that's the obvious imposition.  Still, if [arian ey] wants to at least grow [arian eir] penis back, you're sure you can find [arian em] something, you offer; [arian ey]'s clearly devoted to you, a little token kindness won't hurt you, you think.");

		outputText("\n\nArian shakes [arian eir] head.  \"<i>No, I'm fine.  Unless you want me to have a penis?</i>\"");

		outputText("\n\nYou tell [arian em] that you'll think about it; right now, you want to take the all-new, all-girl Arian out for a spin... if [arian ey]'ll let you, of course?");

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
	outputText("Your hand closes around the vial of lactation-inducing potion that is Lactaid.  You almost reject it automatically, but then you stop and think.  There's odder things in this world, after all.  You remove the vial and ask Arian if [arian ey] would be willing to let you see what lizan milk tastes like.");

	outputText("\n\n\"<i>I don't know.  Lizans don't actually lactate, since we lay eggs, so I don't know if this...</i>\"  Arian squints [arian eir] eyes to read the label on the vial you're holding.  \"<i>...Lactaid will even work.  But if you want to try, I suppose it couldn't hurt... right?</i>\"  Arian smiles nervously.");

	outputText("\n\nYou assure the lizan that, at worst, it'd just fail to do anything, and hand the vial of lactaid to [arian em].  [arian Ey] takes the offered bottle and smiles at you.  \"<i>All right.</i>\"");

	outputText("\n\nArian removes the cork and downs thick milky liquid, passing you the emptied vial.  \"<i>That tasted kinda nice...</i>\"");

	outputText("\n\nThe two of you sit in awkward silence, awaiting for anything to happen.");

	if(flags[kFLAGS.ARIAN_BREASTS] == 0) {
		outputText("\n\nAfter some time, Arian sighs and opens [arian eir] robes, rubbing [arian eir] chest.  \"<i>I don't think it worked.  At least... I don't feel any different.</i>\"");

		outputText("\n\nYou note that's strange, and wonder what could have stopped it working.  You shrug and suggest maybe it was Arian's lack of existing breasts?  Still, no harm done; would Arian maybe like to do something else instead?");

		outputText("\n\nHe shrugs and closes [arian eir] robes.  \"<i>I'm sorry it didn't work, [name].  If you want to do something else, just say so.</i>\"  Arian smiles at you.");
		menu();
		addButton(0,"Next",giveArianAnItem);
	}
	else { //Lizard milk! Recover some HP and fatigue.
		fatigue(-15);
		HPChange(player.maxHP() * .2, false);
		outputText("\n\nAfter some time, Arian begins panting, sweating as [arian eir] body temperature goes up.  \"<i>I feel... hot.</i>\"  In an attempt to lower [arian eir] body temperature, Arian discards [arian eir] robes and lays down on [arian eir] bed, fanning [arian emself] with [arian eir] clawed hands.");

		outputText("\n\nYou approach [arian em] cautiously, asking if [arian ey]'s okay.");

		outputText("\n\n\"<i>My breasts feel ticklish.</i>\"  Suddenly, Arian gasps in pleasure");
		if(flags[kFLAGS.ARIAN_COCK_SIZE] == 3) outputText(", [arian eir] exposed cock growing hard as [arian ey] flushes with arousal");
		outputText(".  [arian Eir] hands grip the sheets and you watch [arian eir] ");
		if(flags[kFLAGS.ARIAN_BREASTS] == 1) outputText("perky");
		else if(flags[kFLAGS.ARIAN_BREASTS] == 2) outputText("luscious");
		else outputText("pillowy");
		outputText(" breasts grow before your eyes.  \"<i>My breasts... d-do something, [name]!</i>\" Arian pleads.  Unsure of what you should be doing, you grab [arian eir] breasts and begin kneading them as they grow in your hands; [arian eir] erect nipples poking your palms.  \"<i>Ah... that feels good!  Don't stop!</i>\"");

		outputText("\n\nYou can't resist a wry comment asking if this was maybe a ploy by Arian to get you to massage [arian eir] breasts?  Because [arian ey] seriously didn't need to play games if that's what [arian ey] wanted.  [arian Eir] only reply is a moan of pleasure.  You chuckle and shake your head, continuing the massage, and that's when you notice dampness growing across your palms; lifting your hand up, you visually confirm and report to Arian that it worked; [arian ey]'s making milk.  That must be why [arian eir] breasts grew; to make room for the milk.");

		outputText("\n\n\"<i>G-great.  So, I guess it worked.  What do we do now?</i>\" Arian asks, still panting.");

		outputText("\n\nDoes [arian ey] really have to ask?  You tease.  Giving [arian eir] newly bountiful breasts a squeeze, you bend down and kiss [arian eir] right nipple, softly sucking it between your lips.  The first few drops are not what you might have expected; it's surprisingly warm, with a taste reminiscent of sweet milk and herbal tea that you find tasty and relaxing all at once.  You need no further incentive to start suckling in earnest, rolling your reptilian lover's nipple around with your tongue to coax forth more yummy lizan milk.");

		outputText("\n\nArian moans and begins caressing the back of your head.  \"<i>Hmm, this is so weird, but not bad weird.  I never dreamed I would ever have breasts, much less nurse someone... with my own milk that is.  How does it taste?  Is it good?</i>\"  Arian asks, softly stroking your [hair].");

		outputText("\n\nRather than answer verbally, you take a particularly deep suckle and release [arian eir] nipple, holding the milk in your mouth as you pull the surprised lizan into a kiss, letting [arian em] literally taste [arian eir] own medicine as you pass the milk from your mouth to [arian eirs].  Arian is too stunned to do anything but gulp down the offered milk.  [arian Ey] drops [arian eir] hands and focuses only on sucking down the offered milk.  Once you've run out of milk, you break the kiss, playfully lick a stray droplet from the corner of [arian eir] mouth, then return your attention to [arian eir] breast.  The lizan mage hugs your head to [arian eir] breast, still stunned.  \"<i>D-drink all you want,</i>\" [arian ey] says in a daze.");

		outputText("\n\nYou need no further encouragement and start thirstily draining Arian of all the milk [arian ey] has to offer, the lizan moaning and sighing as [arian ey] writhes gently underneath you.  Finally, any questions about whether or not the effects of this Lactaid are permanent are answered; you've drunk [arian em] dry, and with a quiet burp you get off of [arian em], somewhat gingerly touching your strained belly.");
		player.refillHunger(10 + (10 * flags[kFLAGS.ARIAN_BREASTS]));
		outputText("\n\nArian sighs in relief.  \"<i>That felt nice.  Maybe we can do it again sometime?</i>\"");

		outputText("\n\nIf [arian ey]'s willing, then certainly, you tell [arian em], but you'll need to track down another vial first.  You think Arian should have a rest before then.  [arian Ey] nods and kneads [arian eir] now emptied breasts.");

		//(if ArianBreasts < 3)
		if(flags[kFLAGS.ARIAN_BREASTS] < 3) {
			flags[kFLAGS.ARIAN_BREASTS]++;
			outputText("\n\n\"<i>Is it me or... are they bigger?</i>\" Arian asks curiously, looking at you and holding [arian eir] scaly orbs.");
			outputText("\n\nYou look at them curiously, and then decide (and tell [arian em]) that, yes, they have gotten bigger.  Probably a side effect of expanding to contain and produce the milk [arian ey] just fed you.");
		}
		outputText("\n\nArian smiles tiredly.  \"<i>I think I'll rest for a little bit now... maybe you should too?</i>\"  [arian Ey] suggests, pointing at your bloated belly.");

		outputText("\n\nYou agree, and ask if [arian ey]'ll be okay if you show yourself out.  Arian nods and yawns.  \"<i>I'll see you later then, [name].</i>\"");

		outputText("\n\nYou leave [arian em] to get some sleep and quietly show yourself out, planning to work off your meal elsewhere.");
		doNext(camp.returnToCampUseOneHour);
	}
}

//Reducto:
//Reduces the size of a part
//Has a Back option, it displays no text, just cancels the interaction and goes back to previous menu.
private function giveArianReducto():void {
	clearOutput();
	outputText("Eyeing Arian up and down, you fish your pouches for a tube of Reducto.  Once you've found it, you hand it over to Arian and tell [arian em] you'd like [arian em] to reduce something for you.");
	outputText("\n\n\"<i>Umm... sure, which part?</i>\"");
	//(Display Options)
	menu();
	if(flags[kFLAGS.ARIAN_BREASTS] > 0) addButton(0,"Breasts",useReductoOnAriansBreasts);
	if(flags[kFLAGS.ARIAN_COCK_SIZE] > 0) addButton(1,"Cock",useReductoOnArianCocks);
	addButton(2,"Asshole",useReductoOnAriansAsshole);

}

//Breasts:
//Cannot go flat (NOT ANYMORE! Maleherms FTW!)
private function useReductoOnAriansBreasts():void {
	clearOutput();
	player.consumeItem(consumables.REDUCTO);
	outputText("You point at Arian's ");
	if(flags[kFLAGS.ARIAN_BREASTS] == 1) outputText("small");
	else if(flags[kFLAGS.ARIAN_BREASTS] == 2) outputText("generous");
	else outputText("pillowy");
	outputText(" breasts.  \"<i>Okay... I suppose it would be good to lose a bit of weight up here and spare my back.</i>\" [arian Ey] smiles, opening the tube of Reducto and [arian eir] robes; then squeezing the contents of the paste [arian eir] hands.");

	outputText("\n\nArian kneads [arian eir] breasts, lathering the paste all over them.  You can't help but note that this is kinda sexy. [arian Eir] breasts glisten in the light of the room.  Once [arian ey] is done, [arian ey] cleans [arian eir] hands with a piece of cloth that was laying nearby and waits for the Reducto's effect.");

	//(if ArianBreasts > 1)
	if(flags[kFLAGS.ARIAN_BREASTS] > 1 || (flags[kFLAGS.ARIAN_BREASTS] == 1 && rand(6) == 0)) {
		outputText("\n\nArian gasps and the two of you watch as [arian eir] breasts slowly shrink, setting into a smaller size.  You reach forward and feel [arian eir] breasts; it's a much better fit for your hands now.");
		outputText("\n\nArian sighs.  \"<i>So... better now?</i>\"  You nod in response.  \"<i>Great!  Is there something else you'd like to do?</i>\"");
		flags[kFLAGS.ARIAN_BREASTS]--;
	}
	else {
		outputText("The two of you watch Arian's breasts, but nothing seems to be changing.  You reach forward to feel them, and indeed they haven't shrunk down at all.");
		outputText("\n\n\"<i>Umm... I...</i>\"  Before Arian can continue, you tell [arian em] that it's fine, you'll just have to find another way to get rid of [arian eir] breasts.  \"<i>Okay.  So, is there anything else you'd like to do?</i>\"");
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
	outputText("You point at [arian eir] crotch, mentioning that you'd like [arian em] to be smaller.");
	outputText("\n\n\"<i>Oh, ok then.</i>\"  Arian opens [arian eir] robes and squeezes the tube of Reducto on an open palm.");

	if(flags[kFLAGS.ARIAN_COCK_SIZE] == 3) {
		flags[kFLAGS.ARIAN_COCK_SIZE]--;
		outputText("\n\nThen, [arian ey] slowly teases [arian eir] ");
		if(flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText("pair of exposed lizard cocks");
		else outputText("exposed lizard cock");
		outputText(" into full erection.  Finally [arian ey] begins applying the paste.");

		outputText("\n\nThe changes are almost immediate; Arian groans and watches as [arian eir] oversized dick");
		if(flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText("s slowly shrink");
		else outputText(" slowly shrinks");
		outputText(" to a more manageable size.  Once the transformation is complete Arian tries to fully retract [arian eir] cock");
		if(flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText("s back into their");
		else outputText(" back into its");
		outputText(" hiding place; it's a tight fit, but it fits.");

		outputText("\n\n\"<i>Phew.  I won't say I didn't enjoy being that size, but it feels a lot more natural and comfortable now that I don't have to walk about exposed.</i>\"  You nod in agreement.  \"<i>So, is there anything else you'd like to do?</i>\"");
		//(Back to Options menus)
	}
	else if(flags[kFLAGS.ARIAN_COCK_SIZE] == 2) {
		flags[kFLAGS.ARIAN_COCK_SIZE]--;
		outputText("\n\nThen, [arian ey]slowly teases [arian eir] slit, coaxing [arian eir] serpentine shaft");
		if(flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText("s from their");
		else outputText(" from its");
		outputText(" tight hiding place, and into full erection.  Finally [arian ey] begins applying the Reducto.");

		outputText("\n\nIt takes mere moments for the changes to occur; Arian groans in slight discomfort as [arian eir] cock");
		if(flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText("s return to their");
		else outputText(" returns to its");
		outputText(" original size.  Once the transformation is complete, [arian ey] retracts ");
		if(flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText("them");
		else outputText("it");
		outputText(" back into [arian eir] genital slit.");

		outputText("\n\n\"<i>Well, it seems I'm back to being average sized,</i>\" Arian says with a tinge of disappointment.   You tell [arian em] that average can be good too, in fact you happen to like average.  The lizan instantly cheers up and smiles at you.  \"<i>Thanks, [name].  Is there anything else you'd like to do, now?</i>\"");
	}
	else if(flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) {
		outputText("Then, [arian ey] coaxes [arian eir] twin reptilian-peckers out of their hiding place.  Finally [arian ey] applies the paste to both shafts in turn.");

		outputText("\n\nIt takes a short while for anything to happen, but when it does Arian groans.  \"<i>S-something feels different.  Ugh, this feels weird.</i>\"  You two watch as [arian eir] shafts slowly reduce in size, then to your surprise merge together forming one average-sized cock, much like the one Arian sported before.");

		outputText("\n\n\"<i>I guess I'm back to begin a lizan with a single cock,</i>\" Arian says with a slight tinge of regret.  You cheer [arian em] up by saying that's the way you prefer it, besides is it really that bad, having only one cock?  Arian smiles at you.  \"<i>I guess it isn't too bad, just unusual for my species, but if you like me like this, then I'm okay with it.</i>\"  You nod and pat [arian em] gently on the head.  \"<i>So... is there anything else you'd like to do?</i>\"");
		//(Back to Options menus)
	}
	else
	{ //Nothing happens
		outputText("\n\nThen coaxes [arian eir] snake-dick out of its hiding place.  Finally [arian ey] applies the paste on [arian eir] dick and wait patiently for the changes to begin.");

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
	outputText("You ask Arian to hand the tube of reducto back over to you, telling [arian em] that you want to make [arian em] a little tighter when you do [arian em] from behind.  The lizard-");
	if(flags[kFLAGS.ARIAN_COCK_SIZE] > 0) {
		if(flags[kFLAGS.ARIAN_VAGINA] == 0) outputText("man");
		else outputText("herm");
	}
	else outputText("woman");
	outputText(" does as you ask, allowing you to smear your fingers generously with the shrinking cream, even as [arian ey] anticipates your next request and removes [arian eir] clothes before lying down, bum up in the air and tail slowly swishing to and fro, [arian eir] anus exposed and waiting for your ministrations.");
	//(if AnalXP == 1)
	if(flags[kFLAGS.ARIAN_ANAL_XP] <= 1) {
		outputText("\n\n\"<i>I don't know if I can get any tighter than this, but... go ahead,</i>\" Arian says, smiling nervously at you.");
		outputText("\n\nYou poke and prod gently but insistently at Arian's ass, but are forced to concede the truth; you can barely get one of your fingers inside [arian eir] tight anus, and you have little reason to suspect that it would do much good even if you could get it inside.");

		outputText("\n\n\"<i>I guess it's no use after all,</i>\" Arian chuckles.  \"<i>I imagine if you did manage to apply it you'd make my ass disappear.  Now that would be weird.</i>\"");

		outputText("\n\n[arian Ey]'s not wrong there, you agree.  Still, would [arian ey] maybe like to do something else, seeing as how that was a bust?  Arian nods.  \"<i>Of course.  What would you like to do?</i>\"");
	}
	//(else if AnalXP < 33)
	else if(flags[kFLAGS.ARIAN_ANAL_XP] < 33) {
		outputText("\n\n\"<i>I think I'm still pretty tight back there, but if you want me to be tighter, go ahead,</i>\" Arian says, smiling nervously at you.");

		outputText("\n\nYou gently press your fingers against the hole in question; like Arian noted, it's tight and resists your effort, but you manage, with some difficulty, to slide first one finger and then the other inside, allowing you to start coating the inner walls with Reducto cream.  You can feel the walls growing taut as you work - indeed, it promptly shrinks down almost painfully around your fingers, and you have to struggle as hard to pull them out as you had to push them in to begin with.");

		outputText("\n\nArian groans as you finally manage to pull your fingers out.  \"<i>I don't think it'll feel that much different when you decide to put it back there again, but I hope it'll feel good for you anyway.  Just promise you'll be gentle, ok?</i>\"");

		outputText("\n\nYou promise [arian em] that you'll take care of [arian em].  \"<i>So, anything else you'd like to do?</i>\"");
		flags[kFLAGS.ARIAN_ANAL_XP] = 1;
	}
	else if (flags[kFLAGS.ARIAN_ANAL_XP] < 66) {
		flags[kFLAGS.ARIAN_ANAL_XP] -= 33;
		outputText("\n\n\"<i>To be honest, I had kind of gotten used to the feeling... sorta.  It will be a bit painful to go back to being that tight back there, but if that's what you'd like, go ahead,</i>\" Arian says, smiling at you.");

		outputText("\n\nYou slide two fingers easily inside [arian eir] stretched out back passage, rubbing the interior of [arian eir] anus with the magical shrinking cream.  You end up applying a third finger for ease of application; [arian ey]'s certainly loose enough to take it.  You can feel it shrinking around you as you work, but you still have little difficulty sliding your fingers back out.");

		outputText("\n\nArian moans as you pull out your fingers.  \"<i>And I was just getting used to being taken from behind.  Somehow I get the feeling it won't feel just as good, but I'm glad to make a little sacrifice for you.</i>\"  [arian Ey] smiles at you.");

		outputText("\n\nYou smile back, thanking [arian em] for catering to your wishes, even though [arian ey] doesn't have to.  Arian grins at you.  \"<i>Don't worry about that.  I want to make you feel good...</i>\"  Stroking [arian eir] exposed ass, you tell [arian em] that [arian eir] efforts are appreciated and promise to make [arian em] feel just as good in return.  Arian smiles.  \"<i>Okay, it's a deal.  So, anything else you'd like to do?</i>\"");
	}
	else if (flags[kFLAGS.ARIAN_ANAL_XP] <= 100) {
		flags[kFLAGS.ARIAN_ANAL_XP] -= 33;
		outputText("\n\n\"<i>I just know it won't feel quite as good back there if you shrink my ass, but maybe this is for the best?  Perhaps I might have let the feeling get to me.  Maybe I did become too much of a buttslut...</i>\"  Arian lowers [arian eir] head.");

		outputText("\n\nYou can't resist patting the lizan's head and assuring [arian em] that, yeah, [arian ey] is a slut when it comes to [arian eir] ass, but the way [arian ey] goes about being a slut is honestly kind of cute.  You just want to see if tightening [arian em] back up will make things even better, now [arian ey]'s got the experience of loving a great assfuck.");

		outputText("\n\nYou push your way into Arian's butt and almost find your whole hand sliding down [arian eir] well-trained 'boyslut pussy', which prompts a lewd moan from the anal-loving lizan");
		if(flags[kFLAGS.ARIAN_COCK_SIZE] > 0) {
			outputText(", [arian eir] cock");
			if(flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText("s suddenly jolting from their sheathe");
			else outputText(" suddenly jolting from its sheathe");
			if(flags[kFLAGS.ARIAN_VAGINA] > 0) outputText(" and ");
		}
		if(flags[kFLAGS.ARIAN_VAGINA] > 0) {
			if(flags[kFLAGS.ARIAN_COCK_SIZE] == 0) outputText(", ");
			outputText("[arian eir] pussy growing wet from the stimulation");
		}
		outputText(".  You playfully shake your head and slap [arian em] on the butt, then use it for balance as you start to pump the blade of your fist inside and out, smearing the cream copiously around to restore some of [arian eir] once-virginal anal tightness to [arian em].  Eventually, you've used up all the cream and [arian eir] ass definitely feels tighter, so you decide to pull out.");

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
	outputText("Fingering the vial of reptilium, you smirk to yourself.  Quickly wiping it off your face, you instruct Arian to close [arian eir] eyes and open [arian eir] mouth, as you have a special surprise for [arian em].");

	outputText("\n\nArian, quickly complies.  \"<i>Okay, but can you at least tell me what is this about?</i>\"  [arian ey] asks in curiosity.");

	outputText("\n\nYou cluck your tongue in a disappointed tone and point out that a surprise isn't a surprise if you tell [arian em] what it is.");

	outputText("\n\n\"<i>Aww, fine then, but I hope this isn't a practical joke... not that I don't trust you, [name].</i>\"  [arian Ey] smiles nervously.");

	outputText("\n\nYou assure [arian em] that [arian ey]'ll enjoy this, but first, to make sure [arian ey] doesn't go peeking... you grab a handy strip of cloth and wind it about [arian eir] face, covering [arian eirs] eyes in a makeshift blindfold.");

	outputText("\n\n\"<i>Aww, come on, you can trust me.  I promise not to peek!</i>\"");

	outputText("\n\nYou tell [arian em] it's more fun this way, popping the bottle of Reptilium open as you do so and following your words up by tipping it into the lizan's carelessly open mouth.");

	outputText("\n\n\"<i>I sweagrlpff-</i>\" the lizan's protests are cut short by the stream of cool reptilum being poured down [arian eir] throat.  [arian Ey] chokes a bit, but quickly adapts, drinking eagerly.  When you finish tipping the bottle and remove it from [arian eir] lips, Arian coughs a bit and licks [arian eir] lips.  \"<i>Hmm... that tasted good, what was it?</i>\"");

	outputText("\n\nYou tell [arian em] [arian ey]'ll just have to wait to find out, taking off [arian eir] blindfold and smiling wryly at [arian em].  \"<i>Umm... ok...</i>\"");
	//(if ArianFirstRept == 1)
	if(flags[kFLAGS.ARIAN_FIRST_REPTILUM] == 0) {
		outputText("\n\nThe two of you sit there in wait... but oddly nothing happens.  You ask Arian if [arian ey]'s feeling any different.");
		outputText("\n\n\"<i>No. I feel fine.</i>\"");
		outputText("\n\nThat's weird... was it a bust then?");
	}
	else {
		outputText("\n\nYou chuckle inwardly, any time now...");
	}
	outputText("\n\nArian suddenly shakes [arian eir] head, blinking as if trying to focus; then [arian ey] turns to look at you, and gives you a silly smile.  \"<i>Hey, [name].  Did you know you have a very beautiful aura?  All the colors.  I wonder what it tastes like.</i>\"");
	flags[kFLAGS.ARIAN_FIRST_REPTILUM]++;
	//(if ArianFirstRept == 1)
	if(flags[kFLAGS.ARIAN_FIRST_REPTILUM] == 1) outputText("\n\nYou blink; aura?  What is the lizan talking about?  And what would make [arian em] think colors are tasty - or even edible?");
	else outputText("\n\nChuckling, you tell [arian em] that if [arian ey]'s so curious, [arian ey] should try it.");

	outputText("\n\nArian suddenly gets up and takes a lick off your cheek.  \"<i>Yum... didn't know rainbows tasted like cloud ice-cream.</i>\"  [arian Ey] begins laughing uncontrollably.  You wipe [arian eir] saliva off your cheek and look in amazement as [arian ey] continues to laugh for no apparent reason.");

	outputText("\n\n\"<i>Hey [name], cats are flexible right?  Think I would turn into one if I could lick my butt?  I'd be a sexy kitten!</i>\"  Arian does away with [arian eir] robes, tossing them around and bending over as far as [arian ey] can in an attempt to lick at [arian eir] butt.  \"<i>J-just a bit more....  Help me here, [name]!  I want to turn into a cat so we can roleplay!  I'll be Mittens and you can be Fishbreath!</i>\"");

	//(if ArianFirstRept == 1)
	if(flags[kFLAGS.ARIAN_FIRST_REPTILUM] == 1) {
		outputText("\n\nFeeling a touch nervous, you ask if [arian ey]'s feeling all right.  \"<i>All right?  I'm super!</i>\" [arian ey] replies, giggling madly.");
	}
	else outputText("\n\nYou were kinda waiting for this part.  [arian Ey] might not know it, but Arian's flexibility is truly impressive for a non-feline.  Just a few extra inches of tongue and [arian ey] actually manages to lick [arian eir] belly!");

	outputText("\n\nAt one point the bending lizan gives up and falls flat on [arian eir] back, then gets right up eyeing you with a glow in [arian eir] eyes.  \"<i>That was a stupid idea!  I know just how to make it!  I can lick your butt instead!  Do you think it tastes like cloud ice-cream like your rainbow aura?</i>\"");

	outputText("\n\nYou shake your head and tell [arian em] you'd rather [arian ey] didn't lick your butt.  Why don't you go and get [arian em] some candy instead?  \"<i>Candy!?  I love candy!  You can smear chocolate on yourself and I could lick it clean! Then we'd get chocolate flavored cloud ice-cream with [race] musk!  What a great idea!  Get your undies off so I can get started!</i>\"  [arian Ey] pounces on you, effectively removing your underpants and exposing your ");
	if(player.hasCock()) {
		outputText(multiCockDescriptLight());
		if(player.hasVagina()) outputText(" and ");
	}
	if(player.hasVagina()) outputText("[vagina]");
	if(!player.hasVagina() && !player.hasCock()) outputText("genderless crotch");
	outputText(".  \"<i>Hmm, that looks much tastier than candy actually.</i>\"  [arian Ey] licks your ");
	if(player.hasCock()) outputText("cock from base to tip");
	else if(player.hasVagina()) outputText("pussy all the way from the back to the tip of your [clit]");
	else outputText("your sweaty crotch");
	outputText(".  \"<i>Yummy!  I could use seconds, but roleplay time is over; let's... masturbate each other!</i>\"  [arian Ey] begins stroking [arian eir] ");

	if (flags[kFLAGS.ARIAN_VAGINA] > 0)
		outputText(images.showImage("arianfemale-home-mutualmasturbation"));
	else
		outputText(images.showImage("arianmale-home-mutualmasturbation"));

		if(flags[kFLAGS.ARIAN_COCK_SIZE] == 1) {
		outputText("quickly erecting lizan cock");
		if(flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText("s");
		if(flags[kFLAGS.ARIAN_VAGINA] > 0) outputText(" and [arian eir] ");
	}
	if(flags[kFLAGS.ARIAN_VAGINA] > 0) outputText("slavering vagina");
	outputText(".");

	outputText("\n\nArian must be high; normally [arian ey] needs a little encouragement to put on a show like this.  Still, who are you to pass up on a free show from your lizan lover?");

	outputText("\n\nLaughing and moaning uncontrollably Arian says, \"<i>Wow, [name].  Your hands feel really good!  Kind of familiar too!</i>\"");

	outputText("\n\n[arian Ey]'s clearly so daffy that [arian ey] doesn't realize [arian ey]'s the one touching [arian em]self.  Still, this is amusing, rather than scary, so you're content to watch and let the show play out.  It's kind of a turn on...");
	dynStats("lus", (5+player.lib/10), "scale", false);

	var tfed:Boolean = false;
	outputText("\n\nArian's giggling suddenly stops as [arian ey] finally orgasms, ");
	if(flags[kFLAGS.ARIAN_COCK_SIZE] > 0) {
		outputText("shooting thick ropes of cum up into the air to land on [arian eir] ");
		if(flags[kFLAGS.ARIAN_BREASTS] == 0) outputText("chest");
		else if(flags[kFLAGS.ARIAN_BREASTS] == 1) outputText("perky little breasts");
		else if(flags[kFLAGS.ARIAN_BREASTS] == 2) outputText("soft breasts");
		else outputText("pillowy breasts");
		if(flags[kFLAGS.ARIAN_VAGINA] > 0) outputText(" while [arian eir] vagina does");
	}
	else outputText("[arian eir] vagina doing")
	if(flags[kFLAGS.ARIAN_VAGINA] > 0) outputText(" its best to soak [arian eir] bed with lizan femcum");
	outputText(".");

	outputText("\n\nLooking at you dizzily, Arian smiles and says, \"<i>That was fun, [name].  You have truly gifted hands!</i>\"  You repress a laugh; this was just too much fun, and tell [arian em] that credit is due where it's due.  You leave it to the dazed lizan to eventually decipher if you're saying you were the one with the gifted hands or you were encouraging [arian em] to recognize that [arian ey] is the one with the gifted hands.");

	//(if (random <= 50%) && (ArianDblCock == 0) && (ArianCockSize != 0)
	if(rand(2) == 0 && flags[kFLAGS.ARIAN_DOUBLE_COCK] == 0 && flags[kFLAGS.ARIAN_COCK_SIZE] > 0) {
		outputText("\n\n\"<i>Ugh... something feels weird...</i>\"  Arian looks down at [arian eir] crotch.  You follow [arian eir] eyes and see a second cock growing.  It grows until it's the same size as Arian's original cock, and once the transformation is over, Arian bursts out in uncontrollable laughter.");

		outputText("\n\n\"<i>Look, [name]!  You did me so hard I'm seeing double!</i>\"  [arian Ey] moves [arian eir] hands to touch [arian eir] sensitive twin members.  \"<i>Whoa! I'm feeling double too!</i>\"  Eventually the laughter dies down and the lizan collapses on [arian eir] back, snoring in a quick nap.");
		tfed = true;
	}
	else {
		outputText("\n\nArian's mouth opens into a wide yawn.  \"<i>Hmm... nappy time...</i>\"  [arian Ey] flops on [arian eir] back and begins snoring in a quick nap.");
	}

	outputText("\n\nYou chortle quietly to yourself.  Talk about your anticlimactic finishers.   Still, you can't resist stroking Arian gently on the head; looks like [arian ey] quite enjoyed [arian emself] with that.  You remove your hand in surprise when Arian suddenly gets up, rubbing at [arian eir] eyes.  \"<i>Wha... hey [name].  Sorry, I guess I fell asleep.</i>\"  Looking down at [arian emself], [arian ey] realizes the state [arian ey]'s in.  For a moment [arian ey] looks confused... but then smiles.  \"<i>I guess we wound up having sex, right?  Was it good?  Sorry, but I'm a bit dizzy and can't recall exactly what happened.</i>\"");
	outputText("\n\nYou tell [arian em] it was definitely interesting.  [arian Ey] really seemed to get wired up off of your little surprise.");

	if(tfed) {
		outputText("\n\n\"<i>Hmm... I still feel sensitive all over...</i>\"  [arian Eir] hand absently touches [arian eir] still half-erect twin dicks.  \"<i>Wha?</i>\"  Looking down at [arian eir] crotch, Arian finally realizes [arian ey] has two dicks.");

		outputText("\n\n\"<i>Two... but, I was....  Was that you, [name]?</i>\"");

		outputText("\n\nYou smile and nod your head; does [arian ey] like them?");

		outputText("\n\n\"<i>Like them?  I love them!  You have no idea how much I longed to... to... to actually have two dicks like most of my people.  Thank you so much for this wonderful suprise [name]!</i>\"  [arian Ey] grins happily at you.");
		flags[kFLAGS.ARIAN_DOUBLE_COCK] = 1;
	}
	else {
		outputText("\n\n\"<i>I guess I did...</i>\"  [arian Ey] smiles tiredly at you.  \"<i>Thank you for the wonderful surprise, [name].</i>\"");
	}
	outputText("\n\nYou laugh lightly and tell [arian em] that you should be the one thanking [arian em].");

	outputText("\n\nThe lizan looks at you in confusion, and is about to ask you something when a yawn interrupts [arian eir] line of thought.  \"<i>Ok... I'm glad you liked whatever we did...  -gonna take a nap now.</i>\"");

	outputText("\n\nYou gently pull the covers up over the tired lizan, stroke [arian eir] head fondly, and quietly excuse yourself from [arian eir] sleeping quarters.");

	//Player gains Lust.
	doNext(camp.returnToCampUseOneHour);
}

private function giveArianScalesDyeVial1():void {
	player.destroyItems(useables.VIALCLE, 1);
	flags[kFLAGS.ARIAN_SCALES] = 1;
	giveArianScalesDyeVial();
}

private function giveArianScalesDyeVial2():void {
	player.destroyItems(useables.VIALTUR, 1);
	flags[kFLAGS.ARIAN_SCALES] = 2;
	giveArianScalesDyeVial();
}

private function giveArianScalesDyeVial3():void {
	player.destroyItems(useables.VIALPIN, 1);
	flags[kFLAGS.ARIAN_SCALES] = 3;
	giveArianScalesDyeVial();
}

private function giveArianScalesDyeVial4():void {
	player.destroyItems(useables.VIALRAI, 1);
	flags[kFLAGS.ARIAN_SCALES] = 4;
	giveArianScalesDyeVial();
}

private function giveArianScalesDyeVial():void {
	clearOutput();
	outputText("Holding the vial on your hand, you call for Arian’s attention, and ask [arian em] to follow you to the nearest point of the stream.\n\n");
	outputText("[arian Ey] gives you an inquisitive look, but quickly catches your intention as [arian ey] sees the vial on your hands. In a few moments, you reach to the water, where you ask [arian em] to remove [arian eir] clothes, as you can’t make the vial work with them put on.\n\n");
	outputText("\"<i>Oh, okay,</i>\" [arian ey] says, with a bit of embarrassment on [arian eir] face. You boop [arian em] nose playfully, stating that you’ve had seen [arian em] naked many times before.\n\n");
	outputText("[arian Ey] smiles in return, letting [arian eir] clothes fall to the ground, leaving [arian eirs] body exposed to your ogling. You look at the exposed scales, covering the most of the lizan’s body");
	if (flags[kFLAGS.ARIAN_VAGINA] == 1) {
		outputText(", except for a bit of naked skin in ");
		if (flags[kFLAGS.ARIAN_BREASTS] > 0 && flags[kFLAGS.ARIAN_COCK_SIZE] == 0) outputText("the outline of her pussy and her nipples");
		if (flags[kFLAGS.ARIAN_BREASTS] == 0 && flags[kFLAGS.ARIAN_COCK_SIZE] > 0) outputText("the outline of his pussy");
		if (flags[kFLAGS.ARIAN_BREASTS] > 0 && flags[kFLAGS.ARIAN_COCK_SIZE] > 0) outputText("her nipples, as well as the outlines of her pussy and slit");
	}
	else outputText(", except for a bit of naked skin in the outline of his slit")
	outputText(". The color in [arian eir] scales compliments well [arian eir] lithe body, and their texture is so smooth that makes you run a hand playfully over [arian eir] scaly buttcheecks, earning a surprised giggle from the lizan.\n\n");
	outputText("Now back to business. You take the vial, and using a pot that you’ve brought from Arian’s tent when you came, mix its contents with clear water. Soon enough, you have the mixture done, and motion Arian to come close, so you can pour the liquid over [arian em].\n\n");
	outputText("As you let the vial contents flow over [arian eir] body, the lizan’s scales bathe thoroughly in the ");
	if (flags[kFLAGS.ARIAN_SCALES] <= 1) outputText("white");
	if (flags[kFLAGS.ARIAN_SCALES] == 2) outputText("turquoise");
	if (flags[kFLAGS.ARIAN_SCALES] == 3) outputText("purplish-pink");
	if (flags[kFLAGS.ARIAN_SCALES] == 4) outputText("rainbow-colored");
	outputText(" liquid.\n\n");
	outputText("\"<i>Whoa, it’s cold!</i>\" Arian gasps, shuddering as the fluid makes contact with [arian eir] scales.");
	outputText("In a matter of seconds, the fluid starts working over [arian em], and you can notice how [arian eir] scales ");
	if (flags[kFLAGS.ARIAN_SCALES] <= 1) {
		outputText("recover their original white coloration. The white returns to all of [arian eir] body, the brown markings on [arian eir] back reappears, leaving [arian eir] color as before.\n\n");
	}
	if (flags[kFLAGS.ARIAN_SCALES] == 2) {
		outputText("slowly acquire a blue-greenish coloration. [arian Eir] back, head, and tail, as well as [arian eir] upper arms and legs swiftly change to a bright turquoise, while [arian eir] sides and lower arms and legs instead take a lighter turquoise coloration. The remaining scales, on [arian eir] belly, chest and crotch, turn into a lovely light-gold.");
	}
	if (flags[kFLAGS.ARIAN_SCALES] == 3) {
		outputText("slowly acquire a pinkish coloration. A lovely pink overcomes the scales on [arian eir] head, back, tail, as well as [arian eir] upper arms and legs, with some purplish accents here and there, while [arian eir] sides and lower legs and arms get a lilac coloration. [arian Eir] underbelly gets a pink-white coloration, completing the set.");
	}
	if (flags[kFLAGS.ARIAN_SCALES] == 4) {
		outputText("slowly acquire what you call only as an explosion of color. An almost pink ruby-red overcomes the scales on Arian’s head, complimented by orange. Said orange turns into golden at the lizan’s shoulders and upper arms, then to a chartreuse green at [arian eir] back, sides and lower arms. [arian Eir] butt and legs acquire a light blue coloration, while the scales on [arian eir] feet and tail turn into a bluish violet. The remaining scales, on [arian eir] belly, chest and crotch, turn into a lovely light-gold.");
	}
	outputText("\n\nThe color settled, [arian ey]  washes [arian emself] on the stream to clean the residuary fluids. Handing [arian em] a towel, you admire Arian’s new coloration, while [arian ey] seemingly does the same. Looking at you for your opinion about [arian eir] new look, you reassure the cute lizan with a hug, telling [arian em] how stunning [arian ey] looks in [arian eir] new scales. Both of you return to the tent with your hands held, while you think of all the funtimes that you’ll have with you newly colored lizan.");
	doNext(camp.returnToCampUseOneHour);
}

//Treat Corruption
//Not with the power of friendship, but with magic!
//Balancing it is up to Fen.
//Reduce corruption, maybe libido, once per day.
private function treatCorruption():void {
	clearOutput();
	outputText("You ask Arian if [arian ey] thinks [arian ey] can help you reduce some of the taint that has infected your soul.");

	if(flags[kFLAGS.ARIAN_TREATMENT] == 1) {
		outputText("\n\nArian solemnly shakes [arian eir] head.  \"<i>Sorry, [name].  But I have already treated you once today, and if I did it again it could be hazardous to you... sorry.</i>\"");

		outputText("\n\nYou apologize.  You had forgotten how much that taxes [arian em], and you will come back for further treatments tomorrow.  However, there is something else [arian ey] can help you with...");
		arianHomeMenu();
		//Back to previous menu.
	}
	else {
		outputText("\n\nArian nods.  \"<i>Of course!  Just hold my hands.</i>\"  [arian Ey] extends [arian eir] hands, waiting for you to get into position.");

		outputText("\n\nYou take hold of [arian eir] smoothly-scaled hands with your own, and wait patiently for [arian em] to begin.");

		outputText("\n\n\"<i>Now I need you to close your eyes, and focus on breathing... deeply and calmly.  You should feel a weird electric sensation, but try to relax.</i>\"");

		outputText("\n\nYou nod your head, close your eyes, and begin to slowly, rhythmically inhale and exhale, calming yourself down as instructed.");

		outputText("\n\nIt takes a while, but eventually you begin to feel the strange sensation Arian told you about.  It courses through your arms, and spreads throughout your body.  After a moment, you feel your body going numb with the sensation, and that's when you notice something else....  For a moment, it feels like you're being hugged tightly by a ghost.  It feels like it's there and isn't at the same time.  Invisible hands roam your body, and slowly, you feel like pieces of you are being removed.  It's not a bad sensation, and it certainly doesn't hurt, but it's... uncomfortable.");

		outputText("\n\n\"<i>That's enough.  You can open your eyes now,</i>\" Arian says, as all the strange sensations coursing through your body abruptly stop.  You release the lizan mage's clawed hands and realize that you're panting... as if you had exerted some sort of physical activity.");

		outputText("\n\nNoticing your concern Arian smiles.  \"<i>Don't worry, [name].  Just take a few moments to regain your breath and you should feel better.</i>\"");

		outputText("\n\nYou do as you are instructed, and note that, once you do feel better, you literally feel better; your thoughts are less clouded by corruption than they were before");
		dynStats("cor", -1);
		fatigue(20);
		if(player.cor == 0) outputText(" - in fact, you're quite sure that Arian has purified you entirely");
		outputText(".  You thank the lizan for [arian eir] magical treatment.");

		outputText("\n\n\"<i>You're welcome,</i>\" [arian ey] replies with a smile.  \"<i>Just remember that we can only do this once per day.  Any more and it would be hazardous, for both of us.</i>\"");

		outputText("\n\nYou acknowledge what [arian ey] is saying, promise you'll try and be more careful in the future, thank [arian em] once more, and then excuse yourself.");
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
	outputText("You tell Arian that, if it's not too much trouble, you'd like [arian em] to ");
	if(player.hasKeyItem("Arian's Talisman") >= 0) outputText("place a spell in the enchanted talisman [arian ey] created for you");
	else outputText("change the spell in the talisman [arian ey] created for you");

	outputText(".\n\n\"<i>Of course.</i>\"  Arian goes to [arian eir] work desk to fetch a small parchment and present it to you.  \"<i>Here's all the spells I can Imbue your talisman with and the materials needed.</i>\"");

	outputText("\n\nYou start observing the parchment, contemplating your choices.  So, what spell will you have [arian em] place in the talisman?");

	/*The list:
	Healing Spell: 2x Wet Cloth and 2x Vitality T. - Heals the PC, no chance for failure.
	Lust Reduction Spell: 2x Lust Draft and 1x Fuck Draft. - Reduces the PC's current lust, no chance for failure.
	Shielding Spell: 2x Black Chitin and 1x Tough Silk. - Increases defense for the duration of the battle.
	Dispelling Spell: 1x White Book and 1x Black Book. - Cancels all magical and alchemical effects currently affecting the PC, beneficial or not. (Does not cancel the effects of demon's lust aura.)
	Immolation Spell: 2x Goblin Ale and 1x Sweet Gossamer. - Deals fire damage over time.
	Ice Prison Spell: 2x Icicle and 1x Numb Rock. - Deal ice damage and freeze (stuns).
	//Back is also present as an option, and returns PC to previous menu.
	*/
	outputText("\n\n<b>Shielding Spell:</b> Two Black Chitin and One Tough Silk - Increases defense for the duration of the battle.");
	outputText("\n<b>Immolation Spell:</b> 2x Goblin Ale and 1x Sweet Gossamer - Deals fire damage over time.");
	outputText("\n<b>Ice Prison Spell:</b> 2x Icicle and 1x Numb Rock - Deals ice damage and freeze (stuns).");
	menu();
	if(player.hasItem(useables.B_CHITN,2) && player.hasItem(useables.T_SSILK)) addButton(0,"Shielding",arianSpellPlace,"Shielding Spell");
	if(player.hasItem(consumables.GOB_ALE,2) && player.hasItem(consumables.S_GOSSR)) addButton(1,"Immolation",arianSpellPlace,"Immolation Spell");
	if(player.hasItem(consumables.ICICLE_,2) && player.hasItem(consumables.NUMBROX)) addButton(2,"Ice Prison", arianSpellPlace,"Ice Prison Spell");
	addButton(14,"Back",arianHomeMenu);
}

private function arianSpellPlace(spell:String):void {
	clearOutput();
	outputText("You tell Arian that you want [arian em] to place the " + spell + " spell in your talisman for you.");

	outputText("\n\n\"<i>Okay. Please, hand me the ingredients and I'll have it imbued in a moment.</i>\"  [arian Ey] smiles at you.  Fishing around amongst your belongings, you gather the necessary items and hold them out to the lizan.");

	outputText("\n\nArian eagerly nabs the offered ingredients and moves to [arian eir] work desk.  [arian Ey] takes a nearby bowl and fills it with water, then looks around.  \"<i>Hmm... I'm forgetting something... oh, right!  I'm going to have to ask you for your talisman, too, [name].</i>\"  [arian Ey] extends a hand to you.");

	outputText("\n\nYou can't resist noting you were expecting [arian em] to say that, plucking it from your neck and passing it to the reptilian wizard.");

	outputText("\n\n\"<i>Erm... right.  Now I need to focus.</i>\"  [arian Ey] places your talisman in the bowl, submerging it in water, then closes [arian eir] eyes and begins focusing [arian eir] magic.  Shortly after, the ingredients you offered suddenly burst into flames, burning until only their ashes are left; the ashes float into the bowl and mix with the water inside.");

	outputText("\n\nA soft hum emanates from within the bowl and the water begins glowing.  It doesn't take long for the humming to fade; Arian reaches inside the bowl and lifts your talisman for you to see.  \"<i>Here you go, [name].</i>\"");

	outputText("\n\nYou thank [arian em] and accept the talisman, feeling the pulsating energies within for a few moments before placing it back around your neck.  You thank Arian for [arian eir] help, assuring [arian em] that this will surely help you in your travels through these lands.");

	outputText("\n\n(<b>Your talisman has been imbued with the " + spell + ". You can use it from the M. Specials menu in combat.</b>)\n\n");
	clearCharges();
	if(spell == "Shielding Spell") {
		player.createStatusEffect(StatusEffects.ShieldingSpell,0,0,0,0);
		//Shielding Spell: 2x Black Chitin and 1x Tough Silk. - Increases defense for the duration of the battle.
		player.consumeItem(useables.B_CHITN,2);
		player.consumeItem(useables.T_SSILK);
	}
	if(spell == "Immolation Spell") {
		player.createStatusEffect(StatusEffects.ImmolationSpell,0,0,0,0);
		//Immolation Spell: 2x Goblin Ale and 1x Sweet Gossamer. - Deals fire damage over time.
		player.consumeItem(consumables.GOB_ALE,2);
		player.consumeItem(consumables.S_GOSSR);
	}
	if (spell == "Ice Prison Spell") {
		player.createStatusEffect(StatusEffects.IcePrisonSpell,0,0,0,0);
		//Immolation Spell: 2x Icicle and 1x Numb Rock. - Deals ice damage and feeze (stuns).
		player.consumeItem(consumables.ICICLE_,2);
		player.consumeItem(consumables.NUMBROX);
	}
	//If charged, stay chargggggeeed
	if(player.hasKeyItem("Arian's Talisman") >= 0) {
		player.removeKeyItem("Arian's Talisman");
		player.createKeyItem("Arian's Charged Talisman",0,0,0,0);
	}
	doNext(camp.returnToCampUseOneHour);
}
private function clearCharges():void {
	if(player.hasStatusEffect(StatusEffects.ShieldingSpell)) player.removeStatusEffect(StatusEffects.ShieldingSpell);
	if(player.hasStatusEffect(StatusEffects.ImmolationSpell)) player.removeStatusEffect(StatusEffects.ImmolationSpell);
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
	if(newl) clearOutput();
	spriteSelect(SpriteDb.s_arian);
	flags[kFLAGS.SLEEP_WITH] = "Arian";
	outputText("Tired after a whole day of adventuring, you decide to retire and catch some shut-eye.  While going through the day's events, you recall Arian had offered to let you stay in [arian eir] tent and sleep with [arian em] in [arian eir] bed.  Your tired body could surely use a soft bed today, and maybe a certain lizan to keep you company too.  With that in mind, you head to [arian eir] tent.");

	outputText("\n\nInside, you find the " + arianMF("male","girly") + " lizan standing naked before [arian eir] bed, stretching [arian eir] arms and tail as widely as they can and groaning with satisfaction as [arian eir] joints pop.  Apparently not having noticed you arrive, [arian ey] hums to [arian emself] as [arian ey] busies [arian emself] with the covers of [arian eir] bed, bending over and letting you get a good look at [arian eir] sweet ass.  You appreciate the view for a few moments, and then gently cough to announce your presence.");

	outputText("\n\nStartled, Arian tries [arian eir] best to cover [arian eir] privates and finally notices you standing just inside.  \"<i>Oh, hello [name].  S-sorry, I'm not decent... I was just getting ready to turn in.  Can I help you with something?</i>\"");

	outputText("\n\nYou smile at [arian em] and ask if that invitation to join [arian em] in bed for the night still stands.  You just don't really feel like going to bed alone tonight, you explain.");

	outputText("\n\nArian nods enthusiastically.  \"<i>Of course!  Let me just put some comfortable robes on.  Usually I just sleep naked, but since you're here....</i>\"");

	outputText("\n\nYou quickly interject that if that's how [arian ey] prefers to sleep, well, [arian ey] doesn't need to change that for you.  If it'll make [arian em] more comfortable, in fact, you'll sleep naked with [arian em] as well.");

	outputText("\n\n\"<i>Really?  Umm... well, they say it's easier to share body heat with skin contact, so...</i>\"  Arian trails off twirling [arian eir] fingers, no longer bothering to cover [arian emself] up.");

	outputText("\n\nYou make no secret of your visual appreciation, telling [arian em] that the view is definitely nice, and then you start to strip down, making a little show out of it for your lizan lover.");

	outputText("\n\nArian fidgets and watches enraptured as you peel off each piece of your [armor].  ");
	if(flags[kFLAGS.ARIAN_COCK_SIZE] > 0) {
		outputText("You can clearly see [arian eir] exposed cock");
		if(flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText("s");
		outputText(" stiffening at the sight.  ");
	}
	if(flags[kFLAGS.ARIAN_VAGINA] > 0) outputText("You can tell that [arian ey] is aroused by the little show, despite [arian eir] body doing a good job of hiding it.  ");
	outputText("You just let [arian em] squirm, pretending you don't see [arian eir] reactions, and then, indicating the bed, you ask which of you should get in first.");

	outputText("\n\nArian steps aside and motions for you to hop in first.  \"<i>Don't worry, I've cleaned the sheets recently, so there shouldn't be a problem... in case you're worried.</i>\"");

	outputText("\n\nWorried?  You smirk and ask whatever you could be worried about, even as you saunter over and slide yourself onto the bed.  You smile and wiggle with appreciation, telling Arian how wonderful [arian eir] sheets and soft mattress feel after so long sleeping in a bedroll on the hard ground.");

	outputText("\n\nArian smiles at you.  \"<i>I'm glad you're comfortable.  Just know that I'll always have a spot for you under my bedsheets.</i>\"  Oh?  Is that a proposal of a little... light exercise before bed, hmm?  You tease the lizan.  Averting [arian eir] gaze and biting [arian eir] lower lip, Arian quickly blurts out.  \"<i>No!  I mean... I wouldn't mind... but I, umm....  I'll just be getting in under the covers, if you don't mind.</i>\"  You chuckle and motion for [arian em] to come hither.");

	outputText("\n\nArian lays down beside you, and scoots over, trying to get as close as possible to you.  You promptly wrap your arms around [arian eir] waist, and then wrap your [legs] around [arian em] for good measure, nuzzling yourself against [arian eir] smooth scales.");

	outputText("\n\nArian sighs in happiness at your close contact.  \"<i>It feels so good to have your " + player.skinFurScales() + " against my scales.  So warm...</i>\" [arian ey] sidles up against you, [arian eir] tail draping over your waist as [arian ey] sinks into your embrace.  You just squeeze [arian em] a little tighter and hold [arian em] close, saying nothing aside from a quiet whisper to sleep well.  \"<i>Good night, [name],</i>\" [arian ey] whispers back, before extending a hand toward the globe illuminating the tent and snapping [arian eir] fingers, shutting down the light.");
	awardAchievement("My Tent's (not) Better Than Yours", kACHIEVEMENTS.GENERAL_MY_TENT_NOT_BETTER, true, true);
	//(if AnalXP <33)
	if(flags[kFLAGS.ARIAN_ANAL_XP] < 33) {
		outputText("\n\nA strange sensation, combined with a soft sound, stirs you from your sleep.  You realize that Arian is stirring in [arian eir] sleep, softly mumbling to [arian em]self as [arian eir] tail gently swishes to and fro under the covers, sometimes accidentally running its warm length over your " + player.skinFurScales() + ".");

		outputText("\n\nAt first you think the lizan might actually be awake, but under further inspection you realize that [arian ey] is just sleep-talking.  Should you listen in or just go back to sleep?");
		menu();
		addButton(0,"Listen",listenToLowAnalXPArian);
		addButton(1,"Sleep",dontListenToLowAnalXPArian);
	}
	//(else if AnalXP <66)
	else if(flags[kFLAGS.ARIAN_ANAL_XP] < 66) {
		outputText("\n\nYou awaken blearily to the sound of soft whimpering, the feeling of hips rubbing softly and repeatedly against your groin, and the sensation of a long, smoothly-scaled tail flickering across your [chest].  Looks like Arian is dreaming something... probably something erotic, too.");
		outputText("\n\nShould you listen in, and perhaps tease [arian em]?  Or just go back to sleep?");
		//[Listen][Sleep]
		menu();
		addButton(0,"Listen",listenToMediumAnalXPArian);
		addButton(1,"Sleep",dontListenToMediumAnalXPArian);
	}
	else { //AnalXP <= 100
		outputText("\n\nYou wake up, confused and wondering what's disturbing your sleep.  When you wake up, you almost think Arian's also awake; [arian ey]'s insistently moaning in pleasure, grinding [arian eir] ass feverishly against your crotch, tail thrashing around wildly.  Why, that little cheeky lizard; [arian ey]'s having a wet dream!");
		outputText("\n\nShould you tease [arian em] a bit?  Or try to calm [arian em] down and go back to sleep?");
		//[Tease][Sleep]
		menu();
		addButton(0,"Tease",teaseHighAnalXPArian);
		addButton(1,"Sleep",dontTeaseHighAnalXPArian);
	}
}

//[=Sleep=]
private function dontListenToLowAnalXPArian():void {
	clearOutput();
	outputText("You gently stroke the lizan's side and plant a soft, gentle kiss on [arian eir] neck.  At your ministrations, Arian sighs and slowly falls still again.  You wait, but it seems that whatever dreams [arian ey] was having have faded and [arian ey]'s truly asleep now, allowing you to go back to sleep yourself.");
	menu();
	addButton(0,"Next",camp.sleepWrapper);
}

//[=Listen=]
private function listenToLowAnalXPArian():void {
	clearOutput();
	flags[kFLAGS.ARIAN_MORNING] = 1;
	outputText("You turn you head to try and catch what Arian might be dreaming about.");
	outputText("\n\n\"<i>In my ass?  Are you sure?</i>\"");
	outputText("\n\nWell, now; looks like Arian might be dreaming about anal sex.  You wonder what to do....  Well, since it's basically [arian eir] fault that you are awake, you feel a little payback is in order.  You whisper in [arian eir] ear that you are sure.");
	outputText("\n\n\"<i>But sausages belong inside breads,</i>\" Arian whimpers.  \"<i>But... if you're sure... okay....</i>\"  Under the covers you feel Arian wiggling [arian eir] butt against you, [arian eir] tail lifting to make room for the \"<i>sausage</i>\".");
	//(if PC has a cock)
	if(player.hasCock()) {
		outputText("\n\nYou wonder for a moment if maybe this is fair, but decide that, if [arian ey]'s obviously dreaming about it eagerly....  Your hand slips under the covers to start stroking your [cock smallest], gently coaxing yourself to erection.  Once you've gotten yourself sufficiently stiff, you wrap your arms around the lizan's waist for balance and start pushing yourself in.");
	}
	else {
		outputText("\n\nGiven you're rather lacking in the penis department, you decide to make do with your fingers; they should be close enough for someone new to anal like [arian em], right?  Copiously lubricating your middle finger with saliva, you wriggle it between [arian eir] soft asscheeks and begin gently pushing it into [arian eir] tight little pucker.");
	}
	outputText("\n\nBefore you can even drive an inch in, Arian suddenly says, \"<i>No!  Wait!  I'm not ready yet!  I need to bake for a few more minutes before you can put the sausage in... and add more milk...</i>\"");
	outputText("\n\n...Okay, this is getting weird enough.  You're not really sure you can stay in the mood to fuck [arian eir] ass.");
	outputText("\n\n\"<i>[name]... just let me bake overnight.  I'll be ready tomorrow.  G'night...</i>\"  Having said that, Arian finally calms down.");
	outputText("\n\nYou wonder if maybe Arian always dreamed of being a baker instead of a wizard... or if [arian ey] just had a midnight craving for pastries  With a soft sigh, you make yourself settle down and try to get back to sleep.");
	dynStats("lus", 15, "scale", false);
	menu();
	addButton(0,"Next",camp.sleepWrapper);
}

//[=Sleep=]
private function dontListenToMediumAnalXPArian():void {
	clearOutput();
	outputText("You gently stroke the lizan's side and plant a soft, gentle kiss on [arian eir] neck.  At your ministrations, Arian sighs and slowly falls still again.  You wait, but it seems that whatever dreams [arian ey] was having have faded and [arian ey]'s truly asleep now, allowing you to go back to sleep yourself.");
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
	outputText("\n\n...Muffins?  [arian Ey]'s kicking and squirming like that... over a dream about muffins?  Feeling mischievous, and maybe a little insulted, you lean over [arian eir] ear and whisper that you've got some very special muffins for him.");
	outputText("\n\n\"<i>Really?  What flavor?</i>\"");
	outputText("\n\nYou tell [arian em] it's a surprise.");
	outputText("\n\n\"<i>Hmm, okay then.  Shove it in.</i>\"  Arian lifts [arian eir] tail out of the way, wiggling [arian eir] hips against you.");

	//(if PC has a cock)
	if(player.hasCock()) {
		outputText("\n\nWell, if this is what [arian ey] wants, you're happy to oblige.  Your hand slips under the covers to start stroking your [cock smallest], gently coaxing yourself to erection.  Once you've gotten yourself sufficiently stiff, you wrap your arms around the lizan's waist for balance and start pushing yourself in.");
	}
	else {
		outputText("\n\nGiven you're rather lacking in the penis department, you decide to make do with your fingers; it is what [arian ey] wants, right?  Copiously lubricating your middle finger with saliva, you wriggle it between [arian eir] soft asscheeks and begin gently pushing it into [arian eir] tight little pucker.");
	}

	outputText("\n\nArian moans.  \"<i>Such a familiar flavor...  Why didn't you tell me you were [name] flavored?  I love muffins... I love [name] muffins...</i>\"");
	outputText("\n\nYou blink in surprise; is Arian really asleep, you wonder?  No, [arian ey]'s got to be awake, otherwise how could [arian ey] realize you're actually fucking [arian eir] ass?  \"<i>Hmm... tasty...</i>\"  You lean over the lizan, ");
	if(player.hasCock()) outputText("cock");
	else outputText("finger");
	outputText(" still worming its way into [arian eir] fuckable ass, but it really does look like [arian ey]'s fast asleep.  Weird.  \"<i>So many muffins... all [name] flavored...</i>\"  [arian ey] calms down and begins snoring lightly.");
	outputText("\n\nUnbelievable... if you didn't know better you'd think that Arian is the one doing the teasing here.  Still... [arian ey]'s fast asleep right now, and you don't feel like fucking [arian em] in [arian eir] sleep");
	if(player.cor >= 66) outputText(", despite the silly lizan being deserving of it");
	outputText(".");
	if(player.hasCock()) outputText(" But as payback, [arian ey]'s going to sleep with you inside, not that it seems like it'll be much of a problem to [arian em]... Too bad you can't hold an erection all the time while asleep, so you know eventually you'll slip out...");
	dynStats("lus", 15, "scale", false);
	menu();
	addButton(0,"Next",camp.sleepWrapper);
}

//[=Sleep=]
private function dontTeaseHighAnalXPArian():void {
	clearOutput();
	outputText("You gently stroke the lizan's side and plant a soft, gentle kiss on [arian eir] neck.  At your ministrations, Arian sighs and slowly falls still again.  You wait, but it seems that whatever dreams [arian ey] was having have faded and [arian ey]'s truly asleep now, allowing you to go back to sleep yourself.");
	menu();
	addButton(0,"Next",camp.sleepWrapper);
}

//[=Tease=]
private function teaseHighAnalXPArian():void {
	clearOutput();

	if (flags[kFLAGS.ARIAN_VAGINA] > 0)
		outputText(images.showImage("arianfemale-camp-dreamingArian"));
	else
		outputText(images.showImage("arianmale-camp-dreamingArian"));
	flags[kFLAGS.ARIAN_MORNING] = 1;
	outputText("\n\nFirst, you decide to check what exactly is Arian dreaming about...");
	outputText("\n\n\"<i>...[name]... no... don't stuff that turkey... stuff me....  I wanna be tasty too.</i>\"");
	outputText("\n\nIs [arian ey] dreaming about food, or sex?");
	//(if PC has a cock)
	if(player.hasCock()) {
		outputText("\n\nAh well, why not indulge a little?  You take one hand and begin to sensuously stroke your shaft, aiming to get yourself nice and erect, while with the fingers of the other you slide into the lizan's tailhole, seeing if your teasing will get a reaction and prove [arian ey] wants [arian eir] butt fucked.");
		outputText("\n\n\"<i>Hmm... hehe.  It's so little... [name]... you can do better.</i>\"");
		outputText("\n\nOkay, it seems there's no need to hesitate anymore.  Your cock rock-solid with anticipation, you wriggle yourself into the proper position and thrust yourself bluntly up [arian eir] ass.  Arian moans lewdly in [arian eir] sleep, [arian eir] well-trained pucker easily, nay, eagerly taking you in a single thrust, the hungry muscles sliding wetly across your length and then clamping down in an effort to suck you inside.");
		outputText("\n\n\"<i>Oooh... that's what I'm talking about... make me tasty...</i>\" Arian's hips eagerly begin thrusting against you in an attempt to force you even deeper into [arian eir] contracting rosebud; every time you push inside, the flesh surrounding your [cock smallest] yields, allowing you easy access; and every time you pull out, Arian's sphincter grips you tightly, as if trying to prevent you from leaving its tight embrace.  It feels good, despite being a bit difficult to get into proper rhythm.");
		outputText("\n\nStill, you persevere despite the awkwardness, leaning over and whispering into Arian's ear, asking if [arian ey] wants to be stuffed nice and full.");
		outputText("\n\n\"<i>More than full... I want to be as big as Miss Turkey...</i>\"");
		outputText("\n\nIs that so, you ask?  Does [arian ey] really want a big squishy belly, stuffed full of hot, salty " + player.mf("man","herm") + "-goo?");
		outputText("\n\n\"<i>Hmm, yessss... put the sauce inside me,</i>\" Arian hisses in obvious pleasure.");
		outputText("\n\nAlready hot and bothered, you don't need much more encouragement.  A few final thrusts, brutal in your eagerness, and you give yourself over to climax, cumming as long and hard as you can into Arian's greedy little butt.");
		outputText("\n\nYou cum as hard as you can, but find yourself unable to cum as much you're used to, due to the fact you're still half-asleep.  \"<i>Hmm, no... more stuffing.  I need it for my muffins...</i>\"  You try your best, but just can't dredge up anything more of note, and tell Arian that [arian ey]'ll need to get some sleep and you'll stuff [arian em] in the morning.  Arian whimpers, but seems to calm down for the time being... now maybe you can get some proper sleep.");
		outputText("\n\nYou try to pull out of the lizan's trained ass, but find yourself unable to.  Well, this is not exactly how you saw yourself spending the night today, but you're too tired to put much of an effort extracting your [cock smallest] from the lizan's greedy butthole.  You get as comfortable as you can, given your current position, and close your eyes...");
		player.sexReward("no", "Dick");
	}
	else {
		outputText("\n\nPity you don't have the necessary parts to play with [arian em], though.  Still, maybe if you do something a little special for him, [arian ey]'ll calm down and let you get some sleep...?");
		outputText("\n\nWith anyone else, you'd probably lube your fingers up first; given what a total buttslut Arian's turned [arian emself] into, though, you doubt [arian ey] needs it.  Gently, you begin pressing against [arian eir] puckered tailhole with two fingers; eagerly it slips open, allowing you access with what you'd swear was a soft slurping sound. The interior is wet and slick, more like an aroused pussy than a normal anus, and you start to slowly thrust your fingers in and out of the warm, wet depths.");
		outputText("\n\nPulling your hand out becomes increasingly difficult as Arian's ass basically sucks you in like a vacuum.  \"<i>Ohh... not stuffing... but feels good too....</i>\"");

		outputText("\n\nYou wonder if maybe you should grow a cock... that, or try to tighten up Arian's ass so [arian ey] stops being so obsessed with getting it stuffed full of cock.  As you ponder this deep conundrum, you continue pistoning your fingers into the buttslut lizan's ass; you wonder if you can make [arian em] cum with just this alone...?");

		outputText("\n\n\"<i>Hmm, you missed a spot.</i>\"  Arian begins humping your fingers eagerly, trying to shove them as deep inside [arian eir] greedy ass as [arian ey] can.");
		outputText("\n\nYou continue pumping inside of the clearly pleased lizan for a while, but eventually you grow bored; as much as [arian ey] might be enjoying this, it's not really doing anything for you, and you still want to get some sleep.  You give [arian em] one last, deep thrust, and then try to withdraw your fingers only to find that you can't.  The greedy lizard-ass won't let you go!");
		outputText("\n\n\"<i>No, if you remove the stuffing the bagels won't be tasty...</i>\" Arian mutters, still asleep.");
		outputText("\n\nYou give a few more tugs, then sigh in disgruntlement.  Looks like you'll just have to put up with this; you're too sleepy to wake [arian em] up.  Still, Arian's in for a tongue-lashing in the morning, you note to yourself, even as you drift off to sleep.");
		dynStats("lus", 15, "scale", false);
	}
	menu();
	addButton(0,"Next",camp.sleepWrapper);
}
//Waking up
//Always happens the morning after sleeping with Arian.
//Outcome slightly modified by AnalXP.
public function wakeUpAfterArianSleep():void {
	clearOutput();
	spriteSelect(SpriteDb.s_arian);
	if (player.hasCock()) {
		if (arianMF("m", "f") == "f")
			outputText(images.showImage("arianfemale-camp-dreamingArian"));
		else
			outputText(images.showImage("arianmale-camp-dreamingArian"));
		//(if AnalXP < 33)
		if(flags[kFLAGS.ARIAN_ANAL_XP] < 33) {
			//(PC tried but didn't manage to get their cocks in. Even tho you slept with it inside, you do go flaccid at some point in the night.)
			outputText("Your eyes open, and you suddenly realize that whatever dreams you were having... are now gone.  You make note of the still sleeping lizan right next to you and recall last night's events.  You wonder if Arian will remember any of that...");
			outputText("\n\nGetting yourself out of bed, you start to stretch your muscles, cracking joints and generally waking yourself up.  While you are doing this, the lizan yawns loudly, slowly coming awake as well.  Rubbing the sleep out of [arian eir] eyes, Arian utters.  \"<i>Morning, [name].  Sleep well?</i>\"  [arian ey] turns to look at you and suddenly hides [arian emself] under the covers.");
			outputText("\n\nYou give [arian em] a wide grin and repeat the sentiment, assuring [arian em] that you did indeed sleep well.  Aww, why's [arian ey] being so shy?  It's far too late for either of you to be worried about being naked around each other.");
			outputText("\n\nArian's head pokes from under the covers.  \"<i>I suppose you're right... but that's still an impressive sight,</i>\"  [arian ey] says pointing at your erect cock");
			if(player.cockTotal() > 1) outputText("s");
			outputText(".");

			outputText("\n\nWell, Arian gives you quite an incentive to sprout it.  Even in [arian eir] sleep, [arian ey]'s a masterful tease, you tell [arian em].");
			outputText("\n\nArian grins apologetically.  \"<i>Sorry... didn't mean to tease you or anything, [name].  Do you want me to help you with that?</i>\"");
			outputText("\n\n\"<i>Well, if you're so inclined</i>\", you tell [arian em], though the grin on your face makes it obvious you'd welcome a little attention from your reptilian playmate.");
			outputText("\n\n\"<i>All right!  Sit down,</i>\" [arian ey] says, getting up and motioning towards [arian eir] bed.");

			outputText("\n\nYou easily catch on to what the lizan has in mind and, with a smile, do as you are told, baring your crotch so to give [arian em] the best access.");

			outputText("\n\nArian promptly nuzzles your [cocks], rubbing [arian eir] face all over ");
			if(player.cockTotal() == 1) outputText("it");
			else outputText("them");
			outputText(" shamelessly until a dollop of pre forms on the tip of your [cock biggest].  \"<i>[name]?</i>\"  You give a deliberate groan, playing up how much you're enjoying this for Arian's benefit and smiling at [arian em].  \"<i>Thanks for the breakfast,</i>\"  [arian ey] says with a smile, then proceeds to take the entirety of your [cock] past [arian eir] lips and down [arian eir] throat.  You can't resist chuckling and patting [arian em] on the head.");

			outputText("\n\nThe lizan mage looks up as best as [arian ey] can while bobbing on your shaft, trying to gauge your reaction and making sure [arian ey]'s doing a good job of blowing you.  You smile and make it quite clear that you're enjoying this, then let out a hollow moan as your morning wood goes soft with a decent-sized explosion of cum into the lizan's sucking mouth.");
			outputText("\n\nArian's eyes bulge with surprise and [arian ey] begins drinking down in earnest, moaning in enjoyment, which proves to be a mistake... shortly after a particularly lengthy moan, [arian ey] tries to swallow and winds up choking.  Some cum escapes [arian em] through [arian eir] nose and [arian ey] quickly pulls away, coughing.  Unfortunately for [arian em], you're still cumming, and the result that even as [arian ey] gags and splutters, you keep on spurting cum all over [arian eir] face until you've emptied yourself.  You sigh in relief, then, with a hint of guilt, ask Arian if [arian ey]'s all right?");
			outputText("\n\nWiping your seed off [arian eir] eyes, [arian ey] says, \"<i>I'm fine... should have been more careful... and don't worry about the facial either, all I need is a few moments to clean myself up.</i>\"  [arian ey] gets up and walks towards a jug filled with water [arian ey] keeps nearby.");
			outputText("\n\nYou quietly get up, pull your clothes on and start heading off to another busy day as Champion.  As you go, you can't help but notice your reptilian lover is licking [arian eir] face clean of cum and washing it down with the water, rather than washing [arian em]self off.");
		}
		else if(flags[kFLAGS.ARIAN_ANAL_XP] < 66) {
			outputText("With a wide yawn, you open your eyes and realize your dreams have been chased away by your sudden bout of wakefulness.  Arian seems to still be asleep; you take a short moment to snuggle up to the curled lizan, rubbing your erect cock up [arian eir] butt crack.  Despite going soft and slipping out of the lizan's warm innards, you still have to contend with a morning wood... so you dutifully hump yourself between the lizan's buttcheeks, poking the base of [arian eir] tail with your protruding shaft.");

			outputText("\n\n\"<i>Hmm, I'm awake already, stop poking me,</i>\" Arian protests, rubbing the sleep off [arian eir] eyes and turning to look at you over [arian eir] shoulder.  \"<i>Morning, [name].  You don't have to keep poking me under the tail to wake me up,</i>\" [arian ey] says, a bit grumpy.  Then [arian ey] realizes that your hands are still occupied hugging [arian em], so what's poking [arian em] is...  \"<i>Oh!  Sorry about that, [name]!  I thought you wanted something... I mean, maybe you do want something?</i>\"  [arian ey] smiles nervously at you.");

			outputText("\n\nYou make a show of pursing your lips.  The question might be, you decide, does Arian want to do something?  After all, those were rather mixed signals [arian ey] sent you last night...");
			outputText("\n\n\"<i>Mixed signals?  Did I do something in the night!?</i>\" [arian ey] asks worried.");
			outputText("\n\nWell, you tell [arian em], first [arian ey] started acting like [arian ey] really, really wanted you to fuck [arian eir] ass.  Then, just when you were getting all steamed up and ready to start, [arian ey] suddenly stopped.  So you were left to try and get back to sleep despite a raging hard-on.  It was really rather annoying, you tell [arian em].");
			outputText("\n\n\"<i>Oh... umm... sorry.  I was probably sleep talking.  Doesn't happen too often, but well....  Sorry, I had no intention of getting you all worked up for nothing.</i>\"");

			outputText("\n\nYou tell [arian em] that's a start.  Still, you think Arian might want you to work off this morning wood with [arian em], hmm?  Would [arian ey] like it if you held [arian em] close and gave [arian eir] ass a good hard fuck?");
			outputText("\n\nArian scratches [arian eir] chin, smiling nervously.  \"<i>Well, I wouldn't be opposed, if you want to.</i>\"");
			outputText("\n\nYou promptly seize the lizan in a tight embrace, already guiding your [cock smallest] towards " + arianMF("his naughty boy-pussy","her tail-hole") + " with a smile on your face.  You teasingly muse aloud about who was saying you were giving [arian em] the choice to say no?");
			outputText("\n\nArian jumps a bit at being suddenly grabbed, but doesn't resist, instead, [arian ey] positions [arian emself] to give you easy access to [arian eir] rosebud.  \"<i>Drat!  And here I thought I would be able to escape punishment from getting you all worked up,</i>\"  Arian replies with a smile.");
			outputText("\n\nYou waste no further time, pushing your way firmly inside the hole that has so captivated you.  The lizan's tight muscles grip and squeeze you most wonderfully, and you thrust yourself back and forth as quickly and firmly as you can manage without actually hurting [arian em].");
			outputText("\n\n\"<i>Ah... [name], you really know how to work my ass, don't you?  Hmm... if anyone told me anal feels this good back then I would have said they're insane, but - Oh!... this wonderful dick of yours feels so good.</i>\"  Arian sighs and begins humping back at you.  \"<i>There's no better way to get ready for a full day ahead of us than having sex with you like this,</i>\" [arian ey] says dreamily.");
			outputText("\n\nYou thrust and moan and groan, losing yourself in the pleasures of sex with your reptilian lover of ass-fucking.  Eventually, the inevitable happens and, with one final cry, you release your steaming spunk up Arian's tailhole.");
			outputText("\n\n\"<i>Haaa... I can feel your seed filling me up, washing my ass with your wonderful cream!  Ah, [name]... I love you.  We should do this more often!</i>\"  Arian says in delight as you finish pumping [arian eir] ass full of jism with a few more thrusts.");
			outputText("\n\nMaybe we should do this more often, you tell Arian.  The two of you stay locked in an embrace for a little while longer, enjoying this morning's afterglow until Arian decides to break the silence.  \"<i>Maybe we should get ready for the day ahead?  Not that I mind staying like this all day.</i>\"");
			outputText("\n\nYou agree, and messily pull yourself free of the lizan's tight ass, getting off of your lover's back and stretching out your stiff muscles.  Arian does the same, taking care to keep [arian eir] ass closed as tightly as possible, to avoid losing any of your earlier deposit.  \"<i>Say, [name].  If you put your clothes on now, they're going to get all dirty.  So, why not get that cleaned up?</i>\" the lizan mage comments, pointing at your cum-slickened shaft.");
			outputText("\n\nYou agree with the lizan, and start looking around for a convenient rag to clean yourself off with.  But before you can spot one, you feel a familiar lizan's mouth encompass your shaft and begin sucking earnestly, making sure to get your shaft squeaky clean, even as you begin sporting another erection.  With a slurp, Arian pulls free of your shaft, leaving it to bob in the cool air of the morning as [arian ey] grins at you, wiping [arian eir] mouth with the back of [arian eir] arm.  \"<i>There.  I cleaned you up.</i>\"  [arian Ey] grins.");

			outputText("\n\nYou chuckle and tap the sneaky little lizard on [arian eir] nose, pointing out that [arian ey] did do so, but now [arian ey] got you hard again.  So, what are you supposed to do like this?  As pleasant as it sounds, you can't spend the day buried in [arian eir] tight little ass.  For emphasis, you spank the lizan sharply on the closest ass-cheek, producing a gobbet of cum trickling from [arian eir] used tailhole.");

			outputText("\n\nArian yelps, moving [arian eir] hands to plug [arian eir] behind.  [arian Ey] looks at you and smiles nervously.  \"<i>Sorry, [name].  I couldn't contain myself.  It looked so tasty,</i>\"  [arian ey] licks [arian eir] lips for emphasis.");

			outputText("\n\nYou smile and chuckle; for a respected mage, Arian really has such a perverted side, and you tell [arian em] this.  As [arian ey] looks embarrassed, you sigh and declare you'll just have to put up with it, and start to redress yourself.");

			outputText("\n\n\"<i>Sorry about that.  I'll make it up to you later, if you want,</i>\"  [arian ey] offers, walking towards a small closet to fetch a towel.  You tell [arian em] that you'll hold [arian em] up to that, finish redressing, and head outside to start your day.");
		}
		else { // AnalXP <= 100
			//(PC fucked and came inside Arian, couldn't pull out. Wake up with a morning wood and surprisingly... still inside the lizan.)
			outputText("\n\nYou feel a sudden urge to hump and wake up, only to find yourself still deeply lodged inside the greedy lizan's wanton rosebud.  Recalling the previous night and your little quickie in the night, you smile.  It's no wonder you're feeling particularly rested this morning.  [arian Eir] greedy butt is as clingy as it was during the night... refusing to yield and let your shaft go.");
			outputText("\n\nWell, if [arian ey]'s really that desperate for a buttfuck... you wrap your arms around your reptilian lover's waist, both affectionately and as a way to maintain your position, and start to thrust your pelvis, pistoning your morning wood inside the insatiable asshole you've encouraged in your lover.");
			outputText("\n\nArian moans and begins bucking back; then after a couple pumps [arian ey] opens [arian eir] eyes.  \"<i>Oh... [name]?  Oh!  This feels good...  W-what are you doing?</i>\"");
			outputText("\n\nJust giving [arian em] what [arian ey] clearly wants so badly, you reply in a distracted tone; you're starting to get into a nice rhythm here and you don't want to lose it.");
			outputText("\n\nArian moans, and begins humping back at you eagerly.  \"<i>Oh... you might feel more comfortable in this position.</i>\"  [arian Ey] rolls around on the bed, until [arian ey] is face down on [arian eir] pillow, while [arian eir] butt and tail are high up in the air to give you full access to [arian eir] eager butt.");
			outputText("\n\nIf you weren't already buried inside of [arian em], you'd pounce right into [arian eir] ass.  Instead, you redouble your efforts, savoring the delicious interior of your little buttslut's ass and [arian eir] now-deliberate efforts to milk your cock of its cum.");
			outputText("\n\n\"<i>Hmm... harder... faster,</i>\"  Arian begs, in between moans of pleasure.  Seeing no reason to deny [arian em], you pick up the pace, roughly pounding [arian em] for all you're worth.");
			outputText("\n\nWith a groan, you feel [arian eir] sphincter contract, pulling you even deeper inside.  Looking down, you realize ");
			if(flags[kFLAGS.ARIAN_VAGINA] > 0) {
				outputText("[arian eir] pussy is squirting [arian eir] juices all over your lower body");
				if(flags[kFLAGS.ARIAN_COCK_SIZE] > 0) {
					outputText(" and ");
				}
			}
			if(flags[kFLAGS.ARIAN_COCK_SIZE] > 0) {
				outputText("[arian eir] ");
				if(flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText("twin shafts are");
				else outputText("shaft is");
				outputText(" squirting white ropes of lizan cum all over the bedsheets");
			}
			outputText("; what a naughty little lizan.");

			outputText("\n\nYou can't resist playfully teasing Arian that [arian ey] is such a buttslut.  ");
			if(!player.hasVagina()) outputText("Did [arian ey] always know [arian ey] wanted a man to top [arian em], or is this development new to [arian em]?");
			else outputText("Does [arian ey] really get off on having a girl with a dick of her own fuck [arian em] like a girl, hmm?");

			outputText("\n\n\"<i>No... but I love it regardless!  Fill me with your seed, please!</i>\"  Arian begs, moaning and eagerly awaiting your deposit.");
			outputText("\n\nYou thrust into [arian em] thrice more, then, with a hollow cry, let out all the seed you can to sate your lovely little buttslut's thirst.  And this time, you can properly focus on cumming, too.");
			//(Low cum amount)
			if(player.cumQ() <= 200) outputText("\n\nThe first jet of cum of the day spurts forth from your tip to paint the eager lizan's insides.  \"<i>Ahhh... that's the way you do it,</i>\"  Arian says, tongue lolling out in pleasure as your cock finishes throbbing and shooting inside.");
			//(Medium cum amount)
			else if(player.cumQ() <= 750) {
				outputText("\n\nString after string of cum leaves your tool to paint the lizan's bowels white with the results of your morning escapade, even swelling [arian eir] belly a bit.  \"<i>Oh, yessss... breakfast.... Hah,</i>\"  Arian says, tongue lolling out in pleasure as [arian ey] anally devours your pent-up cum.");
			}
			//(High cum amount)
			else outputText("\n\nA veritable eruption explodes from within your cock and out of your tip, flooding the lizan's buttslut with the results [arian ey] craved.  \"<i>Yesssss!  Best... morning... ever,</i>\"  [arian ey] says, completely blissed out, tongue lolling out, as your prodigious amount of cum inflates [arian em] like a balloon.");

			outputText("\n\n\"<i>Hmm... [name], I loved waking up like this.  How about sleeping with me again tonight,</i>\"  Arian suggests, smiling in [arian eir] afterglow.");

			outputText("\n\nYou are silent for a moment, instead concentrating on pulling your cock out of the lizan's ass.  Once you are free, you slap [arian em] playfully on the butt and tell [arian em] you'll think about it.");
			outputText("\n\n\"<i>Hmm... please do...</i>\"  Arian's mouth opens in a wide yawn.  \"<i>Still a bit sleepy.  I think I'll take a nap now, if you'll excuse me.</i>\"");
			outputText("\n\nYou chuckle and tell Arian [arian ey]'s such a lazy little lizard, stroking [arian eir] head affectionately before getting dressed and leaving to start your day.");
		}
		player.sexReward("no", "Dick");
	}
	else { //PC has no cock
		//These do not link to a sex scene. No cocks, no sex in the morning, sorry girls/genderless.
		//(if AnalXP < 33)
		if(flags[kFLAGS.ARIAN_ANAL_XP] < 33) {
			outputText("You awaken with a yawn, still snuggling against your scaly sleeping partner.  You slip quietly from the bed and give a good stretch, enjoying the feeling but trying not to wake Arian up.  Shortly after you're done, the lizan's maw opens into a wide toothy yawn of [arian eir] own, rubbing the sleep off [arian eir] eyes, [arian ey] looks about until [arian ey] spots you.  \"<i>Good morning, [name]!</i>\"  [arian ey] says cheerfully, getting up and lazily stretching [arian emself] as well.  \"<i>Sleep well?</i>\"");
			outputText("\n\nYou tell [arian em] that you did, and ask if [arian ey] enjoyed having you in [arian eir] bed as well?  \"<i>I did!  I really enjoyed having you spend the night with me.</i>\"  [arian Ey] grins, prehensile tail swishing lazily behind.");
			outputText("\n\nWell, if that's the case, you reply, you might just consider sleeping with [arian em] more often.  You wink as you tell [arian em] this, kind of hoping [arian ey]'ll blush - it's such an odd sight to see.  Arian doesn't disappoint, fidgeting a bit as [arian eir] cheeks get slightly rose-tinted.  \"<i>I hope you will come more often,</i>\" [arian ey] replies, always grinning.  \"<i>Maybe we should get ready for the day?</i>\"");
			outputText("\n\nYou tell [arian em] that's a good idea, and start fishing for your clothes.  Without shame, you start getting dressed in front of [arian em], wondering if [arian ey]'ll appreciate the views you're giving [arian em].  Arian starts dressing up [arian emself], stopping every once in a while to appreciate your body... though you know [arian ey]'s looking, [arian ey] shyly averts [arian eir] eyes.  You smile and give [arian em] an appreciative shake of your booty, just so [arian ey] knows you like the attention, before focusing on getting dressed.");
			outputText("\n\nOnce you're both fully dressed, Arian smiles at you.  \"<i>[name], have a nice day... and please come visit me soon.</i>\"  You promise you will, and start heading out.");
			outputText("\n\n\"<i>Wait!  Before you go, could you... never mind...</i>\"  The lizan fidgets a bit and turns away, walking towards [arian eir] work desk.  With a knowing smirk on your face, you walk back and grab [arian em] shoulder, forcefully spinning [arian em] around and kissing [arian em] witless.  You pause for a moment to admire the blissfully stunned, dopey look on your lover's face, then walk off to begin yet another day.");
			dynStats("lus", 10, "scale", false);
		}
		else if(flags[kFLAGS.ARIAN_ANAL_XP] < 66) {
			outputText("You awaken with a yawn, still snuggling against your scaly sleeping partner.  You slip quietly from the bed and give a good stretch, enjoying the feeling but trying not to wake Arian up.  Shortly after you're done, the lizan's maw opens into a wide toothy yawn of [arian eir] own, rubbing the sleep off [arian eir] eyes, [arian ey] looks about until [arian ey] spots you.  \"<i>Good morning, [name]!</i>\" [arian ey] says cheerfully, getting up and lazily stretching [arian emself] as well.  \"<i>Sleep well?</i>\"");

			outputText("\n\nYou did and ask if [arian ey] also slept well.  Rather than replying, the lizan bites [arian eir] lower lip and begins fidgeting in what appears to be embarrassment.  You ask what the matter is, your expression making it clear you aren't going anywhere until [arian ey] talks about it.");
			outputText("\n\n\"<i>Well, I did sleep well.  It's just that I also had the strangest... dream.</i>\"  [arian Ey] swallows audibly.  Oh?  And what was this dream about?  You ask in a playful tone, but you think you have an idea already...");
			outputText("\n\n\"<i>Uhh... well, I was... and then... I... had things... done to me...</i>\" [arian ey] explains nervously.");

			outputText("\n\nYou shake your head and tell [arian em] that you didn't understand a word of that.  Fidgeting, the lizan recomposes [arian emself] and begins explaining once more.  \"<i>I-I dreamt I was... well... a muffin and... uhh... I needed my fillings, but the baker kept teasing me by putting the wrong needles in my... bottom... and... well... there was no cream... so... uuh...</i>\"  Embarrassed beyond belief, the lizan just stops talking and just fiddles [arian eir] fingers, white cheeks tinted with the distinct rosy-pink tone that comes with embarrassment.");
			outputText("\n\nYou smile and can't resist stroking your fingers across the lizan's still naked ass, squeezing the round plumpness of [arian eir] cheeks and stroking [arian eir] slutty butt-pucker, just to see how [arian ey]'ll] react.  Arian whimpers, as [arian eir] ");
			if(flags[kFLAGS.ARIAN_COCK_SIZE] > 0) {
				if(flags[kFLAGS.ARIAN_COCK_SIZE] >= 3) outputText("exposed ");
				outputText("bulbous shaft");
				if(flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText("s begin");
				else outputText(" begins");
				outputText(" sporting an erection");
				if(flags[kFLAGS.ARIAN_COCK_SIZE] < 3) {
					outputText(", poking ");
					if(flags[kFLAGS.ARIAN_DOUBLE_COCK] == 1) outputText("its tip");
					else outputText("their tips");
					outputText(" out of Arian's genital slit");
				}
				if(flags[kFLAGS.ARIAN_VAGINA] > 0) outputText(", and [arian eir] ")
				else outputText(".");
			}
			if(flags[kFLAGS.ARIAN_VAGINA] > 0) outputText("moist pussy begins forming a stream of juices that gently runs its course through the inside of Arian's thighs, evaporating before hitting the floor due to the lizan's currently elevated body heat.");
			outputText(" [arian Ey] pants, eyes glazed.  \"<i>Uhh... [name]...</i>\"");

			outputText("\n\nYou smile at [arian em] gently and step back, pulling on your clothes and giving [arian em] a tender kiss on the cheek before you slap [arian eir] bum and head off to start another day.  \"<i>[name].  Visit me soon... please?</i>\" you hear Arian say as you leave, still panting and flustered due to [arian eir] arousal.");
			dynStats("lus", 10, "scale", false);
		}
		else { // AnalXP <= 100
			outputText("You yawn quietly as you find yourself waking up to another new day.  You note that your hand doesn't feel as cramped as you'd expected; in fact, it turns out that your little buttslut must have let your fingers go sometime after you'd gone back to sleep.  You sigh gently and pat Arian on the back; the thought slips into your mind that maybe [arian ey] would like it more if you'd grow a new cock, so you can fuck [arian em] up the ass the way [arian ey] clearly enjoys so much...");
			outputText("\n\nArian yawns widely, licking [arian eir] lips and turning to the side to greet you with a sleepy smile.  \"<i>Morning, [name],</i>\" [arian ey] says, rubbing the sleep off [arian eir] eyes; [arian eir] tail slowly creeps its way over your midriff.  \"<i>Sleep well?</i>\"");

			outputText("\n\nYou tell [arian em] that you did, though there was a little problem in the middle of the night, a knowing smirk on your features as you say this.  Concerned, Arian asks, \"<i>What happened.</i>\"");

			outputText("\n\nOh, nothing that probably couldn't be solved by your regrowing a cock, you joke.  Arian looks confused.  \"<i>Whatever do you mean by that?</i>\"");

			outputText("\n\nYou just smile at [arian em] and tell [arian em] not to worry [arian eir] pretty little head, or [arian eir] cute little butt.  You pat [arian em] on the ass playfully, then swing your [legs] off of the bed and get up, ready to start getting dressed.  Arian still looks mildly confused, but decides to get off bed and start getting dressed as well.  During the whole process [arian ey] keeps shooting you longing glances.");

			outputText("\n\nYou finish pulling your clothes on and, unable to resist your curiosity, ask your little love-lizard why [arian ey] keeps looking at you like that?");

			outputText("\n\nArian fiddles [arian eir] fingers.  \"<i>What you said earlier.  I... would really appreciate it if you grew a nice, big, thick cock... full of cum...</i>\"  Arian trails off, licking [arian eir] lips dreamily and fidgeting slightly.");

			outputText("\n\nYou teasingly ask if [arian ey]'s really gotten that used to you reaming [arian eir] ass like that - why, you would have thought [arian ey]'d prefer it if you stopped.  Arian averts [arian eir] eyes and bites [arian eir] lower lip.  \"<i>No, I mean....  I didn't like it... much... at first.  But, I guess the feeling kinda grew on me, and... well... I've been feeling just so empty lately.</i>\"  [arian Ey] swallows audibly.  \"<i>What I mean to say is... yes, I like it when you poke me back there.</i>\"  [arian Ey] hides [arian eir] face in embarrassment, though [arian ey] fidgets in what you've come to recognize as an indication [arian ey] is aroused.  You can't resist smiling, then stepping over to clasp the still-naked lizan's bum, fingers slipping around to gently tease the entrance of [arian eir] well-trained back pucker, which flexes and tries to entice your fingers inside.  You tell [arian em] you'll consider growing a cock back, tap [arian em] on the nose with the very fingers you were just teasing [arian em] with, and then leave to start a new day.");
			dynStats("lus", 10, "scale", false);
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
	spriteSelect(SpriteDb.s_arian);
	flags[kFLAGS.ARIAN_EGG_EVENT] = 1;
	if(flags[kFLAGS.ARIAN_EGG_CHAT] == 0) {
		flags[kFLAGS.ARIAN_EGG_CHAT]++;

		outputText("As you are about to enter Arian's tent, you hear a moan emanate from within.  Those aren't moans of pleasure though.  They are moans of discomfort.  Wondering if the lizan is all right, you decide to enter [arian eir] tent.");

		outputText("\n\nArian is laying on [arian eir] bed, naked, as [arian ey] rubs [arian eir] belly in a slow circular motion.  You rush to [arian eir] side and ask what happened?");

		outputText("\n\n\"<i>Uh?  Oh, hello [name].  Just feeling a bit sick, that's all.</i>\"  Arian smiles, somewhat embarrassed, and adds, \"<i>You see... it's that time... when girls... y'know.</i>\"  [arian Ey] giggles.");

		outputText("\n\nYou sigh in relief, for a moment you thought [arian eir] health problems might have returned.  So... this means [arian ey]'s growing a clutch of eggs inside [arian em]?");

		outputText("\n\nArian nods in confirmation.  \"<i>That's right.  Lizan females grow unfertilized eggs inside them and must lay those every 30 days.  Today just happens to be my day.  This is the time when a male would... fertilize... the eggs and then the female would lay a clutch of fertile eggs.</i>\"");

		outputText("\n\nYou listen attentively, then a question hits you.  Wouldn't lizans overpopulate if they lay eggs in clutches?  Or are those clutches particularly small?");

		outputText("\n\nArian shakes [arian eir] head.  \"<i>No. Usually we lay clutches of 10 or so eggs, but despite all the eggs being fertilized, not all of them will mature into a healthy baby.  Usually only one or a couple manage to mature.</i>\"  That's sad to hear, you comment. [arian Ey] smiles and shrugs.  \"<i>It's just the way we're built...</i>\"");

		outputText("\n\nYou ask if anyone could fertilize [arian eir] egg. Arian, fidgets and bites [arian eir] lower lip.  \"<i>Well... yes.  Why do you ask?  Are you... maybe... interested?</i>\"  You give it some thought... and tell [arian em] that you were just curious, but who knows... maybe in the future.");

		outputText("\n\nArian averts [arian eir] eyes, smiling happily.  \"<i>Maybe, but I have to say this is not the way I saw myself having a family.  I always thought I'd be the one helping lay... you know?</i>\"  You nod, does that make [arian em] uncomfortable? [arian Ey] shakes [arian eir] head.  \"<i>Not at all, if there's anyone I'd pick to father my children, that would certainly be you, [name].</i>\"  [arian Ey] smiles at you, and you smile right back at [arian em].");

		outputText("\n\nSo... unless you plan on having a family with [arian em]... sex is out of the question.  Arian blurts out, \"<i>No!</i>\"  You recoil in surprise at [arian eir] sudden outburst; [arian ey] covers [arian eir] mouth and smiles nervously.  \"<i>S-sorry... must be the hormones making me moody... regardless... no.  I have placed an enchantment on myself, and you won't be able to impregnate me unless we remove that.  So... someday when we're both ready and willing... hehe.</i>\"  [arian Ey] fidgets, laughing nervously.");

		outputText("\n\nYou tell [arian em] that it's reassuring to hear that [arian ey]'s being careful about this matter.");
		outputText("\n\n\"<i>Of course, parenthood is a big responsibility,</i>\" Arian notes.");

		outputText("\n\nYou nod your head.  Then, curious, you ask what [arian ey]'ll do with the eggs after [arian ey]'s laid them, if there's going to be nothing inside of them?");

		outputText("\n\n\"<i>Usually we'd just eat them, since they're rich in protein and good for the health of the mother, but I think I can try and create something useful for you.  You know how there are magical colored eggs that are said to have transformative effects, right?  I could try to use my magic and grow a few eggs with the color of your choosing.</i>\"");

		outputText("\n\nYou tell [arian em] that could be very helpful in your quest, but you don't want [arian em] to strain [arian em]self; can [arian ey] do it without hurting [arian em]self?");

		outputText("\n\nArian puffs [arian eir] chest out proudly.  \"<i>Of course I can!  Though magic can be unpredictable sometimes, I am a master mage, and something as simple as imbuing my own eggs with magic is no trouble at all...  but I appreciate your concern all the same.</i>\"  [arian Ey] smiles at you.");

		outputText("\n\nIf that's the case, you tell [arian em], then you would appreciate it if [arian ey] could try creating colored eggs for you from [arian eir] unfertilized eggs.");

		outputText("\n\n\"<i>Sure!  Which color do you want?</i>\"");
	}
	else {
		outputText("As you are about to enter Arian's tent, you hear a moan emanate from within.  Seems like it's that time of the month again...");
		outputText("\n\nAs you enter the tent, you are greeted with the sight of Arian laying on [arian eir] bed, naked, as [arian ey] rubs [arian eir] belly in a slow circular motion. [arian Ey] spots you walking towards [arian em] and greets you with a smile.  \"<i>Hello, [name].  I have a new clutch of eggs growing inside me, would you like me to try and create a colored egg for you?</i>\"");
	}
	//(Display Color Options, in the future you will also have the option of telling her you want to fertilise her eggs.) (Also include a leave option.)
	menu();
	addButton(0,"Brown",pickAnEggArian,"brown");
	addButton(1,"Purple",pickAnEggArian,"purple");
	addButton(2,"Blue",pickAnEggArian,"blue");
	addButton(3,"Pink",pickAnEggArian,"pink");
	addButton(4,"White",pickAnEggArian,"white");
	addButton(5,"Rubber",pickAnEggArian,"rubbery black");
	addButton(6,"No, Thanks",leaveEggs);
}

//Pick a color
private function pickAnEggArian(color:String = "pink"):void {
	clearOutput();
	flags[kFLAGS.ARIAN_EGG_COLOR] = color;
	outputText("You tell Arian you'd like [arian em] to make you a " + color + " egg.");
	outputText("\n\n\"<i>All right,</i>\" [arian ey] replies, closing [arian eir] eyes and beginning to focus [arian eir] magic.");
	outputText("\n\nYou watch in wonder as a " + color + " light seems to gather within Arian's belly, slowly fading away.  The lizan mage smiles and opens [arian eir] eyes, tail waving lazily behind [arian em] in happiness.  \"<i>It's done.  I tried to get all my eggs imbued, but I won't know if I was successful or not until they're laid.</i>\"");

	outputText("\n\nYou thank [arian em] for [arian eir] efforts, give [arian em] a quick peck on the cheek, and then encourage [arian em] to get some rest.  Arian nods.  \"<i>I should be ready to lay tomorrow, so don't forget to visit.</i>\"");
	outputText("\n\nYou nod in understanding and wave to [arian em] as you leave [arian eir] tent.");
	flags[kFLAGS.ARIAN_EGG_COUNTER] = 1;
	doNext(camp.returnToCampUseOneHour);
}
//Leave
private function leaveEggs():void {
	clearOutput();
	outputText("You tell [arian em] that you don't want any colored eggs from [arian em] this month.  The lizan nods, deciding it's not necessary for [arian em] to spell out that this means [arian ey]'ll just produce ordinary eggs and eat them for breakfast after [arian ey]'s laid them.  \"<i>So, do you want something?</i>\" [arian ey] asks.");
	doNext(camp.returnToCampUseOneHour);
}

//Display Arian options
//Arian Lays Colored Eggs
//Happens the day after Egging Event, always happens the first time the PC visits.
//Even if you miss, trigger it the next visit anyways, so as long as you don't miss the egging event, you don't miss out on your colored eggs.
//Randomly decide between small or large egg, I'd say 50% chance of either.
public function arianLaysEggs():void {
	clearOutput();
	spriteSelect(SpriteDb.s_arian);
	var color:String = flags[kFLAGS.ARIAN_EGG_COLOR];
	flags[kFLAGS.ARIAN_EGG_COUNTER] = 0;
	outputText("As you approach the tent, you wonder if Arian's ready to lay those eggs...  Your contemplations are promptly interrupted as you hear a pained moan coming from inside.  Seems like [arian ey] is in labor!  Without delay, you rush inside, to be greeted by the sight of naked lizan-");
	if(flags[kFLAGS.ARIAN_COCK_SIZE] > 0) outputText("herm");
	else outputText("girl");
	outputText(" squatting over a wooden basin, one hand between [arian eir] legs, massaging [arian eir] dripping treasure, while the other is rubbing [arian eir] belly to try and coax the eggs out of [arian em].");

	outputText("\n\nYou see [arian em] sway momentarily, too focused on the task at hand to even notice you.  Fearing [arian ey] might lose [arian eir] balance and fall, you quickly move behind [arian em], hugging and steadying [arian em].");

	outputText("\n\nThe lizan ");
	if(flags[kFLAGS.ARIAN_COCK_SIZE] > 0) outputText("herm" + arianMF("-boy", ""));
	else outputText("female");
	outputText(" is sucking in great lungfuls of air, slowly hissing them out as [arian ey] soldiers on through the contractions of [arian eir] womb.  So intent on [arian eir] labors is [arian ey] that [arian ey] doesn't recognize your presence, at first.  After a few moments, however, [arian eir] eyes finally recognize you're there and [arian ey] gives you a brave smile.  \"<i>Ah, hello, [name]; sorry you had to catch me like this - I was hoping I'd have this over and done before you saw it,</i>\" [arian ey] notes apologetically.");

	outputText("\n\nYou scold [arian em], telling [arian em] [arian ey] should've called you when [arian ey] was getting ready to lay; you would have gladly helped.  You tighten the hug, bringing [arian em] closer to your chest, one hand moving to meet hers as [arian ey] slowly massages [arian eir] belly.  You entwine your fingers with [arian eirs] and help [arian em] massage [arian eir] belly.");

	outputText("\n\n\"<i>Mmm... thank you, [name], that does feel nicer when it's someone else.  This wouldn't be so bad if I knew it was going to be a baby at the end of it, but I go through all this for nothing more than a quick snack.  I can kind of understand why harpies have always been so nuts about getting fertilized when they're full of eggs, now: it's not so much that they - or I - want to be moms so badly as it is just so annoying to go through this for absolutely no reward at the end of it,</i>\" the lizan notes, sighing heavily and leaning against you for support.");

	outputText("\n\nStill, you are very thankful for [arian em] doing this for you.  Then you note that [arian ey] seems to really have fallen into [arian eir] role as a " + arianMF("hermboy","girl") + ".  You would never expect to hear this kind of comment from someone who was a man before... but it's cute that Arian is acting this way, and you enjoy [arian em] the way [arian ey] is now.  You give [arian em] a peck on the cheek for emphasis.  Now, [arian ey] has a clutch to lay, and you'll be here during all the steps necessary to do so.  You take [arian eir] hand off [arian eir] belly and place it against your midriff, then proceed to rub [arian eir] belly by yourself. With your other hand, you release [arian em] and do the same, your hand massaging [arian eir] pussy lips, replacing [arian eir] hand shortly as you tease and massage the contracting opening to [arian eir] depths.");

	outputText("\n\nThe lizan moans throatily.  \"<i>Mmm... you really do have magic fingers, don't you?</i>\"  [arian Ey] says, then winces.  \"<i>Ahg, that was a nasty one - they'll be coming out any minute now,</i>\" [arian ey] notes in a surprisingly level tone, moaning softly as [arian eir] abdominal muscles flex and contract.");

	outputText("\n\nNever stopping your ministrations, you ask what you should do?  Arian doesn't have time to answer though, as you feel one of the egg shaped lumps beginning its journey down the lizan's birth canal.  You feel [arian eir] pussy dilating, far faster than it should on any woman, and for a moment you worry as the egg passes quickly, falling into your waiting hand.  You barely have time to safely place it on the basin as another egg soon falls into your hand.  Arian's belly vibrates with the rapid contractions, rapidly reducing in size as the eggs make their way out.");

	outputText("\n\n\"<i>Nnng... once it finally starts, it's over quick, so don't worry, [name].  I'll be done in a minute,</i>\" [arian ey] promises you.");

	outputText("\n\nYou nod, though [arian ey] can't see you from this position.  You whisper that [arian ey] is a very brave girl to face this kind of ordeal... and you can't deny that seeing [arian em] laying eggs like this has a certain appeal. [arian Ey] looks very sexy. You tell [arian em] that this is good practice for when [arian ey]'s laying fertile eggs. You hope [arian ey]'ll look as sexy as [arian ey] looks now, once the time comes.");

	outputText("\n\nThe lizan laughs, a rather pitch-switching sound as [arian eir] uterus continues flexing.  \"<i>If you really think I'm sexy like this, [name], then I sure hope we'll end up doing this for real sooner rather than later. Oooh... not much more left in me now,</i>\" [arian ey] says, closing [arian eir] eyes and continuing to push. As [arian ey] said, within moments, [arian eir] belly is flat as normal, while the last few eggs have clattered into the straw-lined basin [arian ey]'s been squatting over.  With a hissing sigh of relief, [arian ey] gingerly straightens up and steps over it. \"<i>I... can you please get me some cool water, [name]? I have a jug over there?</i>\" [arian ey] asks, pointing in the appropriate direction.");

	outputText("\n\nOf course you can, you reply. You gently help [arian em] down on the floor from [arian eir] squat, and head towards the jug [arian ey] indicated.  Looking about, you quickly spot a mug and fill it with water, bringing the cool liquid back to the panting lizan.  [arian Ey] takes it from you and gulps down a sizable mouthful of it, then pours some over [arian eir] head.  \"<i>Ohhh... that feels better.  Why don't you check the eggs, see if our little experiment worked?  I'm just going to regain my strength,</i>\" [arian ey] suggests.");

	outputText("\n\nYou nod your head, and begin sorting through the eggs.  Most of them look like common eggs, not that much different from large chicken eggs.  Eventually, you find one that seems to be appropriate.  Separating this egg from the others, you check one more time and find out that Arian only managed to lay one " + color + " egg.  Still, that's good enough for you.  You take the egg and turn to place it gently on the nearby counter.  When you turn to check up on Arian though, you spot the lizan casually lifting one of the \"<i>normal</i>\" eggs, sizing it up.");

	outputText("\n\nArian pays no attention to you, instead hungrily inspecting [arian eir] just-laid egg.  A trickle of drool oozes out of the corner of [arian eir] mouth and is lapped up with a quick flick of a long tongue before [arian ey] opens [arian eir] jaws and crams the whole egg inside.  [arian Ey] mouths it around before [arian ey] manages to puncture it, audibly sucking out the insides before spitting the crushed but still-intact eggshell out into [arian eir] hand.  [arian Ey] grabs another and gobbles it down with the same eagerness as before, spitting out the shell after sucking out the contents.");

	outputText("\n\nYou cough, trying to remind the hungry lizan before you, that you're still in the room...");

	outputText("\n\n[arian Ey] pauses, just about to cram another egg into [arian eir] mouth, and looks sheepish.  \"<i>Ah... sorry, [name].  I'm just so hungry and, well, it's not like there's anything else in these things, right?  Or did you want to try one?</i>\" [arian ey] suddenly suggests, offering [arian eir] latest 'treat' to you.");

	outputText("\n\nYou politely refuse, telling [arian em] that [arian ey] probably needs it more than you do, since [arian ey] just went through labor.  Anyways you should probably be going.  You thank the lizan for the " + color + " egg and tell [arian em] to enjoy [arian eir]... meal... and point out that, while you personally appreciate the view, [arian ey] should probably put on some clothes later.");
	outputText("\n\nArian gasps and quickly covers [arian em]self, smiling nervously to you.  \"<i>Thank you for pointing that out, [name].  Although,</i>\" [arian ey] giggles nervously.  \"<i>If you'd rather I stay naked, I'm willing to do that for you...</i>\"  You give the idea some thought... but decide to tell [arian em] that you'd prefer [arian ey] put on some clothes next time you visit.  Otherwise you miss out on having [arian em] sensuously strip for you, you laugh.");

	outputText("\n\n\"<i>Well, that's one way to look at it, I guess.</i>\"  Arian laughs.  \"<i>So, if you don't want to join me, a lady needs to have [arian eir] breakfast,</i>\" [arian ey] tells you, then swallows another egg whole, letting out a very unladylike belch.  \"<i>Okay, that was a bit too much to swallow,</i>\" [arian ey] admits, blood flushing the pale scales of [arian eir] face in one of [arian eir] pseudo-blushes.");

	outputText("\n\nYou laugh at Arian's reaction, telling [arian em] that you don't mind.  You should go right now.  You turn to pocket the egg and leave Arian's tent, bidding the lizan farewell before you do.\n\n");
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
	if(flags[kFLAGS.TIMES_ARIAN_DILDOED] == 0) {
		outputText("Looking over your reptilian " + arianMF("boy","girl") + "friend, your eyes go down [arian eir] body");
		if(flags[kFLAGS.ARIAN_COCK_SIZE] > 0) {
			outputText(", past [arian eir] cock");
			if(flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText("s");
		}
		outputText(", to [arian eir] dripping wet pussy, clearly yearning for some action.  Reflecting that your own love-lips feel the same way, you decide to try something fun and present to Arian the dildo that you ");
		if(player.hasKeyItem("Dildo") >= 0) outputText("bought from Giacomo");
		else outputText("got from Tamani");
		outputText(", asking if [arian ey]'s willing to give this a try.");

		outputText("\n\nThe lizan averts [arian eir] eyes in embarrassment.  \"<i>Umm... I guess I'm okay with it?</i>\"  [arian Ey] fidgets a bit.  \"<i>But I've never used anything when... much less something like that.</i>\"");

		outputText("\n\nYou shush [arian em] gently, assuring [arian em] that it'll be all right; you'll be here to help [arian em] get comfortable with it and to show [arian em] how to use it right.  Besides, it's much better than [arian eir] fingers....");

		outputText("\n\n\"<i>A-All right then.</i>\"  [arian Ey] smiles nervously.");
	}
	else {
		outputText("You present your dildo to Arian again, telling [arian em] that this time, you want to play with your toys - after all, [arian ey] enjoyed it so much the first time.");

		outputText("\n\nArian fidgets in embarrassment.  \"<i>Okay.</i>\"");
	}
	flags[kFLAGS.TIMES_ARIAN_DILDOED]++;

	outputText("\n\nYou carefully put the dildo down beside the pillow before turning to Arian and pulling [arian em] into an embrace, arms around [arian eir] waist, before spinning [arian em] around, sweeping [arian em] off [arian eir] feet, and dropping [arian em] flat on the bed.  [arian Ey] giggles nervously as you slide yourself into position, straddling [arian em] and pinning [arian eir] wrists to the bed beside [arian eir] head, leaving [arian em] helpless.  Your tongue slides out of your lips in a lecherous gesture before you bend your head down and kiss [arian em] first on one dark nipple, and then on the other.  Arian wriggles and squirms underneath you as you start to plant quick, soft, gentle kisses up [arian eir] torso and towards [arian eir] neck, diligently kissing your way towards [arian eir] lips.  Once there, you plant a butterfly kiss on [arian eir] lips, but that's not enough; you release your grip on [arian eir] wrists and instead place a soft but authoritative palm on each of [arian eir] cheeks, pinning [arian em] in place as you passionately consume [arian eir] lips with your own.");

	outputText("\n\nYour lizan lover reciprocates your kiss, [arian eir] scaled arms wrapping around you as [arian ey] hugs you tightly, legs instinctively spreading to allow you access.  You continue to suckle at [arian eir] lips, forcefully probing at them with your tongue to see if [arian ey] will allow you access.  Even as you do this, you settle yourself more comfortably upon [arian eir] body and slide a hand down [arian eir] torso, over [arian eir] belly until you reach between [arian eir] legs.  ");

	if(flags[kFLAGS.ARIAN_COCK_SIZE] > 0) {
		outputText("Ignoring [arian eir] cock");
		if(flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText("s");
		outputText(", y");
	}
	else outputText("Y");
	outputText("ou slide first one finger into [arian eir] slick pussy and then another, gently caressing [arian eir] inner labia to see if you can find [arian eir] sweet spots.  Arian's eyes open in surprise as the first pang of pleasure hits [arian em], [arian ey] moans into your kiss.  [arian Eir] tongue darts to dance with your own in excitement.");

	outputText("\n\nYou allow [arian eir] tongue to wrestle with yours, suckling lewdly upon it and watching as Arian writhes and moans underneath you, totally in your thrall.  But, enough is enough when it comes to a warm-up; you break the kiss and remove your hand from [arian eir] cunt.  Arian protests feebly, but you shush [arian em], caressing [arian eir] cheek as you declare that the time for warming up is over.  With your other hand, you reach for the nearby dildo and then slap it between [arian eir] [arian chest].  It's time [arian ey] put on a little show for you....");

	outputText("\n\nThe lizan mage swallows nervously, but nods in understanding.  You give [arian em] one last kiss for being so obedient, squeeze [arian eir] breasts in passing, and then drag yourself off of [arian em], deliberately scraping your [vagina] over [arian eir] belly as you go and shivering with pleasure at the sensations [arian eir] smoothly scaly skin sends through your cunt.  You hop off of the bed and reposition yourself sitting upright at the base, where you have a perfect seat for whatever [arian ey] plans on doing next.");

	outputText("\n\nArian takes the dildo in hand, gripping and releasing it to watch the rubber shift under [arian eir] touch.  [arian Ey] looks nervously at you one more time and then opens [arian eir] mouth wide.  [arian Ey] slips the dildo between [arian eir] lips, suckling softly, wetting it with [arian eir] saliva.  Not bad, not bad at all for a beginner, and you nod your head, encouraging [arian em] that [arian ey]'s getting off to a good start.  Arian blinks in understanding and continues to lather the rubber shaft in saliva.");

	outputText("\n\n[arian Ey] pops the dildo out of [arian eir] mouth, satisfied with its current wetness.  With one hand, [arian ey] cups a breast and rubs the tip of the dildo on [arian eir] erect nipple, moaning at the stimulation.  [arian Eir] eyes glance at you to see if [arian ey]'s pleasing you.  You shift so that [arian ey] can see your naked form, letting [arian em] watch as your hands slip teasingly down to your love canal's entrance.  You moan softly, starting to frig yourself in excitement at the show [arian ey]'s putting on.  Emboldened by your display, Arian smiles and licks the tip of the dildo once more.  [arian Ey] moans as [arian ey] strokes [arian eir] other nipple, setting the dildo between [arian eir] breasts to run its length along [arian eir] cleavage.  Whenever the dildo grows dry, [arian ey] takes it back to [arian eir] mouth to lather it again with a drawn out slurp.  [arian Ey]'s starting to get in the mood, you notice.");

	outputText("\n\nYou clap your hands all of a sudden, startling Arian out of [arian eir] oral ravishing.  You crawl your way up to [arian em], your motions smooth and seductive, gently taking the dildo from [arian eir] unresisting fingers as you coil yourself around [arian em].  [arian Ey]'s been putting on a very nice show, you stage whisper to [arian em], but this isn't really what you wanted to see.  You're going to give [arian em] a hand and show [arian em] just how good this can really be....");

	outputText("\n\nYou start by seductively wrapping your own tongue around the dildo, sloppily kissing it and slurping on it, sucking eagerly at the taste of [arian eir] saliva and making sure it's good and sodden with both your mixed juices.  Then, you hold the dripping wet toy up to [arian em] for [arian eir] inspection.  [arian Ey] looks at the dildo enraptured, panting in excitement.  Then, now that [arian ey]'s good and excited, you bring the dildo down to the junction of [arian eir] legs, ");
	if(flags[kFLAGS.ARIAN_COCK_SIZE] > 0) {
		outputText("brushing it tantalizingly across the sensitive skin of [arian eir] pre-oozing cock");
		if(flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText("s");
		outputText(", before ");
	}
	outputText("brushing it against [arian eir] outer lips, stroking it up and down each labium, rubbing it against [arian eir] clitoris, gently pushing the very tip of it into [arian eir] cunt only to then withdraw it before it can really start to stretch [arian eir] cunt.");

	outputText("\n\nArian moans and fidgets as you play with [arian eir] body, moaning and gasping at the friction generated by the rubber dildo.  \"<i>Oh, [name].  T-that feels great!</i>\" [arian ey] moans in delight, bucking against the dildo in an attempt to find purchase.");

	outputText("\n\nIf it feels so good, then why doesn't [arian ey] prove it, you ask [arian em], continuing to tease [arian em] with the dildo but refusing to put it in, your free hand stroking your [clit] and fingerfucking your [vagina] at an excited pace.  Isn't [arian ey] just dying to have this fake-cock between [arian eir] legs, spreading [arian eir] pussy wide and stretching out [arian eir] gut until [arian ey]'s a helpless puddle of fuck?  Why doesn't [arian ey] show you that's what [arian ey] wants?");

	outputText("\n\nArian looks at you in confusion.  \"<i>Prove it? ...Ah!</i>\" [arian ey] moans loudly, bucking wildly against your teases.  Yes, prove it... and with that, you take a firm grip on the dildo and roughly thrust it as far into Arian's cunt as the horny lizan will let it enter!  The " + arianMF("", "she-") + "lizan's maw opens in a look of surprise; instead of a scream, all [arian ey] can manage is a gasp.  You make sure to commit the image to memory for moments.  Arian closes [arian eir] eyes and moans - a throaty moan, a moan of pleasure.  [arian Eir] face contorts as [arian eir] vaginal walls clamp down on the rubbery intruder.  ");
	if(flags[kFLAGS.ARIAN_COCK_SIZE] > 0) {
		outputText("[arian Eir] cock");
		if(flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText("s throb");
		else outputText("throbs");
		outputText(" as a jet of whiteness escapes. ");
	}
	outputText("You can feel it... the suddenness of your penetration brought the poor lizan mage to an instant orgasm.");

	outputText("\n\nGrinning wickedly to yourself, you sprawl yourself across your reptilian " + arianMF("boy","girl") + "friend, hungrily kissing [arian em] and sucking [arian eir] long, prehensile tongue into your mouth to play with it - and to muffle any further screams of ecstasy.  With one hand, you grope [arian eir] [arian chestAdj] boobs, while with the other you continue to plunge the dildo back and forth inside of [arian em], sliding it out - not easy, with how tightly [arian ey] grips it in [arian eir] cunt - before roughly pounding it home again, a repetitive motion to burrow for [arian eir] cervix and to leave [arian em] a quivering pile under you.  The poor lizan is helpless against your relentless assault.  All Arian manages is squeals of pleasure and wanton moans of desperate lust.");

	outputText("\n\nYou keep this up for minute after delightfully entertaining minute, before you decide that [arian ey]'s had [arian eir] fun; now it's your turn.  You try to tug the dildo free of [arian eir] clenching cunt, but [arian ey] just quakes and moans as another orgasm rips through [arian eir] body - [arian ey]'s holding the toy so tightly inside [arian em] that you can't get it out!  You let go of it and pat [arian eir] cheek, tauntingly complaining that [arian ey]'s not being fair.");

	outputText("\n\nArian groans, opening [arian eir] eyes slightly to look at you.  \"<i>W-What do you... mean by that?</i>\" [arian ey] asks, clearly not recovered after [arian eir] climax.");

	outputText("\n\nWhy, [arian ey]'s hogging the dildo all to [arian em]self, you reply, making another failed attempt at pulling it free for emphasis.  [arian Ey] gets to get off, but you get no fun for yourself - now, does that seem fair to [arian em]?  Hmm?  Arian pants, shaking [arian eir] head.  \"<i>Sorry...</i>\"  [arian Ey] attempts to even out [arian eir] breathing enough to at least speak normally.");

	outputText("\n\n\"<i>Sorry, [name].  I don't think you can pull the dildo out of me yet.  That would... well... it would be too much for me.  So please.  Just don't, at least for now.</i>\"  You crawl off of [arian em] slightly, so [arian ey] can move more freely and so you can watch [arian em] at work.  \"<i>I think I can help you with your problem though.</i>\"  Interested, you give [arian em] the signal to go ahead.  [arian Ey] begins chanting a spell and within moments you watch in amusement.  Your dildo's base begins extruding itself, growing into a familiar phallic shape.  Soon enough you're looking at an exact replica of the dildo currently buried in your lizan girlfriend.  Clever girl....");

	outputText("\n\nArian smiles tiredly.  \"<i>There.  Forgive me, [name], but I'm too tired to move right now.</i>\"  That's all right; you can move for [arian em], you reply, already shifting yourself into position, bringing your [vagina] into alignment to start impaling yourself on your now double-ended dildo.");

	outputText("\n\nYou shift and thrash, moaning lewdly as you stroke every spot that you know will bring you pleasure; in your aroused state, it's easy to get into things.  Each thrust you make earns an ecstatic groan from your girlfriend as it shifts the dildo inside [arian eir] over-aroused pussy.  You hump and you grind and you squeeze, a tug of war between your two netherlips as you and Arian fight for possession of your favorite toy.  You can feel the pleasure overwhelming you, sparks of arousal setting your brain on fire; you're close... oh, gods, you're so close!");

	outputText("\n\nWith one mighty clench and tug, you pull the dildo free of Arian's love-hole, throwing your head back and crying out as you climax, the waves of orgasm washing through you, your whole body quaking in pleasure.  When at last it ends, you let yourself fall limply back on the bed with a sigh of relief, your pussy slackening and letting your dildo fall free.");

	outputText("\n\nOnce you catch your breath, you absently reach down and bring your favorite toy up to your face, you watch as it slowly reverts back to its original form, though still dripping with your mixed juices.  Smiling openly, you inform Arian that you may just be the luckiest " + player.mf("boy", "girl") + " in Mareth, to have a " + arianMF("herm-boy", "girl") + "friend like [arian em].");

	outputText("\n\nArian pants, still winded, though [arian eir] breathing seems to have returned to a more normal level.  [arian Ey] can't help but grin at your compliment.  \"<i>Don't be silly, [name].  I'm the lucky one.  But I'm really glad you think so highly of me.</i>\"  Why shouldn't you?  [arian Ey] gave up [arian eir] birth-gender, just to better please you - why, any girl who passed up a chance to snap up someone as sweet as Arian was a fool, but they'll never amend their mistake, because [arian ey]'s all yours now.  With that you slither around in the bed so that you can glomp onto your " + arianMF("herm-boy", "girl") + "friend, rubbing your " + player.skinFurScales() + " cheek against [arian eir] own smooth scales, hugging [arian em] tightly to you.");

	outputText("\n\nArian rubs [arian em]self back at you affectionately.  \"<i>I love you, [name].</i>\"  You just hold [arian em] and let [arian em] feel your warmth.  Then, you realise you're still holding a sopping wet dildo in one hand, and you casually present it to Arian, holding it in front of [arian eir] face and telling [arian em] to clean it.  Before [arian ey] can protest, you point out that <b>[arian ey]</b> got the most fun out of it, and <b>[arian ey]</b> made most of the mess, so that makes it <b>[arian eir]</b> responsibility to clean it up.  You waggle it in front of [arian eir] snout for emphasis.");

	outputText("\n\nArian blinks at your words, but concedes with a smile.  \"<i>Of course.</i>\"  [arian Ey] opens [arian eir] mouth and lets [arian eir] tongue roll out, inviting you to place the dildo into [arian eir] open mouth.  You promptly slide the fake-cock gently home, letting [arian em] start at [arian eir] own pace.");

	outputText("\n\n[arian Ey] cleans it diligently, and from the looks of it, [arian ey]'s also enjoying [arian em]self immensely.  Arian's eyes are closed most of the time, but you notice that [arian ey] opens them to glance at you and smile to [arian em]self.  Whatever's going through [arian eir] head must be very pleasant.  It takes only a couple of minutes before you pull the dildo out to inspect it.  Lizan spit shines in the light of the ambience, and from what you can see... there's not a single trace of your, or Arian's, juices left on the dildo.  With a smile, you pat your lizan on the head, congratulating [arian em] on a job well done.");

	outputText("\n\n\"<i>Thank you, but I'm not done yet.</i>\"  You look at [arian em], wondering what [arian ey] has in mind.  Arian slithers along your body, until [arian eir] face is hovering your [vagina].  A knowing smirk crosses your lips and you relax, eager to let [arian em] get to work.  [arian Ey] gently spreads your legs and begins licking, making sure to drink in all of your juice.");

	outputText("\n\nYou gasp and shudder, moaning softly as [arian ey] pleasures your oversensitive love canal.  It doesn't take long, maybe a minute or two, before you are writhing in a mini-orgasm, your female fluids gushing into your lover's eager mouth, bathing [arian eir] probing tongue.  [arian Ey] makes sure to lap it all, not keen on letting even a single drop be wasted.  \"<i>Hmm, delicious,</i>\" Arian says as [arian ey] licks [arian eir] lips clean of leftovers.");

	outputText("\n\nYou heave a sigh of contentment and authoritatively drag your little lizan slut into your arms, wrapping yourself around [arian em] in a cuddle and making it quite clear you don't intend to let [arian em] go anywhere any time soon.  Fortunately, [arian ey] seems quite eager to be there, and so you shut your eyes and allow yourself to slowly drift off to sleep.  Before you fully embrace unconsciousness, though, you place a gentle hand on Arian's pussy, stroking [arian em] softly - not to arouse [arian em] yet again, but just to let [arian em] feel a loving touch there, in the place that brings you both such pleasures....");

	player.sexReward("vaginalFluids","Vaginal");
	dynStats("sen", -2);
	doNext(camp.returnToCampUseOneHour);
}
private function arianAppearance():void {
	clearOutput();
	outputText("Arian is a 5ft ");
	if (flags[kFLAGS.ARIAN_VAGINA] == 1 && flags[kFLAGS.ARIAN_COCK_SIZE] == 0 && flags[kFLAGS.ARIAN_BREASTS] > 0) outputText("2in");
	else outputText("3in");
	outputText(" lizan with a lean body and an overall lithe complexion and a ");
	if (flags[kFLAGS.ARIAN_BREASTS] > 0 && flags[kFLAGS.ARIAN_VAGINA] == 1) outputText("soft, feminine");
	if (flags[kFLAGS.ARIAN_BREASTS] == 0 && flags[kFLAGS.ARIAN_COCK_SIZE] > 0) outputText("masculine");
	outputText(" figure.\n\n");
	outputText("Arian’s head is reptilian in shape, with a long snout. The teeth in [arian eir] mouth, tough sharp as those of a lizan, look much less menacing and predatory as the others that you’ve seen. ");
	outputText("Like [arian eir] body, the lizan’s head is covered ");
	if (flags[kFLAGS.ARIAN_SCALES] <= 1) outputText("entirely in white scales, probably a harmless remnant of [arian em] time of sickness");
	if (flags[kFLAGS.ARIAN_SCALES] == 2) outputText("in bright turquoise scales, turning a lighter shade of the same color upon reaching to [arian eir] neck, while [arian eir] inner neck has creamy-gold colored scales");
	if (flags[kFLAGS.ARIAN_SCALES] == 3) outputText("in lovely pink scales, turning a into a pinkish-white upon reaching to [arian eir] neck. Purplish-pink accents surround [arian eir] eyes and upper head");
	if (flags[kFLAGS.ARIAN_SCALES] == 4) outputText("in scales, the ones on [arian eir] head a soft, almost pinkish ruby-red, softly turning to orange-golden at [arian eir] neck. [arian Eir] inner neck has a creamy-golden coloration");
	outputText(". [arian Eir] ears are small holes at the sides of [arian eir] head, utterly concealed from view given its small size. Coming from Arian’s snout, a long, forked tongue slips out from time to time.\n\n");
	outputText("Situated upon [arian eir] chest are two ");
	if (flags[kFLAGS.ARIAN_BREASTS] == 0) outputText("manly pecs");
	else outputText("" + arianChestAdjective() + "breasts, each one with a 0.5 inch nipple protruding from them");
	outputText(".\n\n");
	outputText("Arian’s body is thoroughly covered in scales, the ");
	if (flags[kFLAGS.ARIAN_SCALES] <= 1) outputText("white of [arian eir] head remaining on most of the lizan’s body, except for a few brown markings on [arian eir] back and tail. [arian Eir] chest and underbelly is covered too by white scales, though a bit more greyish");
	if (flags[kFLAGS.ARIAN_SCALES] == 2) outputText("bright turquoise of [arian eir] head remaining on the lizan’s upper arms and legs, as well as on [arian eir] back and tail. [arian Eir] lower arms and legs, and [arian eir] sides have a lighter shade of turquoise. Light-golden scales cover Arian’s chest, underbelly and crotch");
	if (flags[kFLAGS.ARIAN_SCALES] == 3) outputText("purple-pink of [arian eir] head remaining on the lizan’s upper arms, legs, as well as on [arian eir] back and tail. [arian Eir] lower arms and legs, and [arian eir] sides have a lilac coloration. Pink-white scales cover Arian’s chest, underbelly and crotch");
	if (flags[kFLAGS.ARIAN_SCALES] == 4) outputText("ruby-red and orange of [arian eir] head turning into golden upon reaching the lizan’s shoulders. The same golden scales cover [arian eir] upper arms. [arian Eir] chest and underbelly have a lighter, creamy-golden set of scales. On [arian eir] back, sides and lower arms, the scales turn into a chartreuse green, later into a light blue at the lizan’s butt and legs, to end with a violet coloration at the end of the tail");
	outputText(".\n\n");
	outputText("Arian’s hips are ");
	if (flags[kFLAGS.ARIAN_VAGINA] == 0 && flags[kFLAGS.ARIAN_BREASTS] == 0) outputText("nice and well-formed, but nevertheless, boyish and average-looking");
	else outputText("soft and rounded, albeit not too thick");
	outputText(". [arian Eir] butt has a rounded shape with a firm appearance that ");
	if (flags[kFLAGS.ARIAN_VAGINA] == 0 && flags[kFLAGS.ARIAN_BREASTS] == 0) outputText("is soft, at least,");
	else outputText("has a delightful softness, just");
	outputText(" enough to get a good grope.\n\n");
	outputText("From [arian eir] backside emerges a long, reptilian tail covered in ");
	if (flags[kFLAGS.ARIAN_SCALES] <= 1) outputText("white");
	if (flags[kFLAGS.ARIAN_SCALES] == 2) outputText("turquoise");
	if (flags[kFLAGS.ARIAN_SCALES] == 3) outputText("purplish-pink");
	if (flags[kFLAGS.ARIAN_SCALES] == 4) outputText("rainbow-colored");
	outputText(" scales, lashing from side to side as [arian ey] walks.\n\n");
	if (flags[kFLAGS.ARIAN_COCK_SIZE] > 0) {
		outputText("Concealed most of the time on a genital slit on [arian eir] crotch a ");
		if (flags[kFLAGS.ARIAN_COCK_SIZE] == 1) outputText("6\" long and 1.5\" thick");
		if (flags[kFLAGS.ARIAN_COCK_SIZE] == 2) outputText("10\" long and 2\" thick");
		if (flags[kFLAGS.ARIAN_COCK_SIZE] == 3) outputText("14\" long and 3\" thick");
		if (flags[kFLAGS.ARIAN_DOUBLE_COCK] == 0) outputText(" penis emerges when aroused. It’s ");
		if (flags[kFLAGS.ARIAN_DOUBLE_COCK] > 0) outputText(" pair of penises emerge when aroused. They’re ");
		outputText("purple colored, with and odd, bumpy shape. Unlike those of most races, Arian’s testicles are internal, protecting them from any external damage.\n\n");
		if (flags[kFLAGS.ARIAN_VAGINA] == 1) outputText("Under [arian eir] slit [arian ey]");
	}
	if (flags[kFLAGS.ARIAN_VAGINA] == 1) {
		if (flags[kFLAGS.ARIAN_COCK_SIZE] == 0) outputText("[arian Ey]");
		outputText(" has a soft, tight pussy, with a 0.2 inch clit. The womb that lies within is perfectly adapted to oviposition.\n\n");
	}
	outputText("[arian Ey] has a pair of scaly legs, ending in reptilian feet with claws adapted to grasp, though the harmless nature of the lizan has made them look much less menacing that they could be.");
	doNext(visitAriansHouse, true);
}
}
}
