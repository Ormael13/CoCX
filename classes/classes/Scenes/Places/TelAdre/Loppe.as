package classes.Scenes.Places.TelAdre {
	import classes.GlobalFlags.kFLAGS;

	public class Loppe extends TelAdreAbstractContent {
public function Loppe(){

}
//const LOPPE_FURRY:int = 684;
//const LOPPE_FERTILE:int = 685;
//const LOPPE_KIDS:int = 686;
//const LOPPE_TRAINING:int = 687;
//const LOPPE_KIDS_LIMIT:int = 688;
//const LOPPE_URTA_CHATS:int = 689;
//const LOPPE_PC_MET_UMA:int = 690;
//const LOPPE_TIMES_SEXED:int = 691;
//const LOPPE_DENIAL_COUNTER:int = 692;
//const LOPPE_DISABLED:int = 693;
//const TIMES_ASKED_LOPPE_ABOUT_LOPPE:int = 694;
//const LOPPE_MET:int = 695;

private function loppeCapacity():int {
	return 90;
}
//Tags/Booleans (C)
/*QB Note: I've never actually done this before, so I'm probably missing a few.
LoppeRace: 0 toggles Loppe in \"<i>laquine-girl</i>\" form (human with bunny ears/legs and horse cock/tail), 1 toggles Loppe in \"<i>laquine-morph</i>\" form (anthro bunny with horse tail & horse cock)
LoppeBreed: 0 means Loppe is sterile, 1 means Loppe is fertile.
LoppeKids: Counter to check how many kids you and Loppe have had.
LoppeTraining: Counter to see how far Loppe's progressed on her training.
LoppeKidsLimit: The limit of kids Loppe can have with the PC before stopping, initially set to 8, but later can be expanded.
LoppeChats: Boolean to check if PC's seen the play along version of Urta chat.
LoppeMetUma: Boolean to check if PC already met Uma.
LoppeSexed: Boolen to determine if PC's had sex with Loppe at least once already.
LoppeDenial: Counter for determining when Loppe is willing to go through with the Orgasm Denial scene again. Decrements by 1 every day if higher than 1; at 1 she's willing, at 0 she's never done it before (and is willing).
*/

//Appearance (edited) (C)
private function appearanceOfLoppe():void {
	clearOutput();
	if (flags[kFLAGS.LOPPE_FURRY] == 0) {
		outputText("Loppe is a 6'2\" bunny-girl with deep brown eyes set in her pretty face.  Shoulder-length black hair and a pair of snow-white rabbit ears adorn the top of her head, tilted and lying backward to conceal the insides.  Curiously, her face is that of a normal human woman.");
		outputText("\n\nHer body is covered in smooth olive-colored skin, save for her wrists, where she has a pair of fluffy cushion-like fur bracelets; her legs are what you would expect of a bunny, curved and with elongated furry feet; her fur color is snow-white.  Her butt is firm and girly; it fills out her shorts nicely.  If you were to look at her from behind, her hips and butt would form a perfect heart shape.  A long, elegantly-cared for black horse's tail falls from her butt, easily reaching to the back of her knees.");

		outputText("\n\nShe usually has a smile on her face, which is nice, and her tight-fitting shorts reveal her slender-but-powerful legs but struggle to contain her hefty package.  Covering her chest, she has a tight-fitting sleeveless top that holds her C-cup breasts snugly together.");

		outputText("\n\nFrom what you recall, her phallus looks like that of a horse; it is 14</i>\" long and about 2.5</i>\" wide, with a heavy sack dangling beneath her sheath.");

		outputText("\n\nHer pussy is tight, despite the amount of action she must get; you wonder how she manages to keep it that way.  Although if you ask, all it earns you is a sultry smile and a wink.");
	}
	//Appearance (Anthro) (edited) (C)
	else {
		outputText("Loppe is a 6'2</i>\" bunny-morph with deep brown eyes set above her soft muzzle.  Shoulder-length black hair and a pair of snow-white rabbit ears adorn the top of her head; both ears flop backward at an angle.  Her face used to be that of a human woman, but it has since returned to 'normal' ever since you helped her rid herself of her curse.");
		outputText("\n\nHer body is covered in silky smooth snow-white fur, and on her wrists she has a pair of fluffy cushion-like fur bracelets; her legs are what you would expect of a bunny, curved and with elongated furry feet, white-furred like the rest of her.");
		outputText("\n\nShe usually has a smile on her face, which is nice, and her tight-fitting short reveal her slender, but powerful legs but struggle to contain her hefty package; covering her chest, she has a tight-fitting sleeveless top that holds her C-cup breasts snuggly together.");
		outputText("\n\nFrom what you recall, her phallus looks like that of a horse; it is 14</i>\" long and about 2.5</i>\" wide.  A heavy sack dangles beneath her sheath.");
		outputText("\n\nHer pussy is tight, despite the amount of action she must get; it's a mystery how she manages to keep it that way.  Although if you ask, it would probably just earn you a sultry smile and a wink.");
	}
	menu();
	addButton(0,"Next",loppeGenericMeetings);
}


//First Meeting (edited) (C)
//Happens randomly when choosing to go into the bar after 16:00
public function loppeFirstMeeting():void {
	clearOutput();
	outputText("Wandering towards the bar, you notice an unusual commotion; there are a lot more people hanging around here than is usual for the time of day.  Feeling curious, you go over to investigate, and ask a bystander what all of this is about.");
	outputText("\n\n\"<i>You don't know?  Today we're having a show at the bar.  A dancer is going to be dancing for us.  You should go and have a look, it's very beautiful!</i>\"");
	outputText("\n\nDo you watch the show?");
	//[Yes][Not Now][Uninterested]
	menu();
	addButton(0,"Yes",yesToMeetingLoppe);
	addButton(1,"Not Now",mebbeLaterToLoppe);
	addButton(2,"Uninterested",noLoppeInterest);
	//no spacebar default here
}

//[=Uninterested=]
private function noLoppeInterest():void {
	clearOutput();
	outputText("Dancers aren't really your thing, and you shake your head.");
	//(disable repeat and NPC)
	flags[kFLAGS.LOPPE_DISABLED] = 1;
	menu();
	addButton(0,"Next",telAdre.barTelAdre);
}

//[=Not Now=]
private function mebbeLaterToLoppe():void {
	clearOutput();
	outputText("You're not really in the mood for this right now, so you leave the bar.");
	//(go to T'A main menu, repeat event in 15 days.)
	menu();
	addButton(0,"Next",telAdre.telAdreMenu);
}

//[=Yes=]
private function yesToMeetingLoppe():void {
	clearOutput();
	flags[kFLAGS.LOPPE_MET] = 1;
	outputText("There's no harm in staying a while...");

	outputText("\n\nYou make your way through the crowd, pushing past the doorway to try and find a table to sit down at.  The place is really jam-packed, and it's not helped by the fact that a small makeshift stage has been set up in the center of the room.  The bartender is working flat-out to provide drinks for all the thirsty people, and you wonder where in the world you'll find a place to sit down and watch.  After a lot of elbowing, narrowly avoiding being stepped on, and small confusions, you manage to find what you think is a good place to watch the 'show'.");
	//--Next--
	menu();
	addButton(0,"Next",yesToLoppeMeetingTwo);
}

private function yesToLoppeMeetingTwo():void {
	clearOutput();

	outputText(images.showImage("loppe-show-at-bar"));
	outputText("Suddenly the bar goes silent and the lights dim; a figure clad in a white mantle steps onto the stage; discarding the covering with a swift movement, it reveals the comely visage of a bunny-girl - a literal bunny-girl, in that apart from the obvious bunny ears and the hints of rabbit-like legs, she actually looks otherwise human despite the prevalence of anthropomorphic animals in this city.");

	outputText("\n\nA strange, exotic robe adorned with floral designs decorates her body, and her face is completely white, delicately painted to make her look like a porcelain doll; her eyes are shaded with a red eyeliner and her lips with a crimson lipstick.  The black hair atop her head is done in a small bun, perched just above her flattened bunny ears.  She smiles at her audience and takes a pair of fans out of her long sleeves, opening them and beginning to motion in graceful, fluid movements.  You watch mesmerized as an unusual, but calming, music begins playing in the background; while the small makeshift stage begins to glow with a strange substance, the dancer begins going through her preparatory motions.");

	outputText("\n\nThe grace and speed with which she moves are admirable.  Whoever this strange woman is, she's obviously honed her body quite well.  This promises to be quite an interesting spectacle.");

	outputText("\n\nThe crowd begins cheering as finally the dancer begins, striking poses that seem next to impossible in those restrictive robes of hers; she surprises you even more when she begins singing in tune with the music, a beautifully melodic voice that silences the crowd and echoes throughout the room.  Every single one of the patrons gathered today watch the show enraptured, while the bartender takes this small reprieve to rest for a spell.");

	outputText("\n\nSuddenly the eyes of the dancer turn towards you, deep brown and gentle, but filled with a mysterious intensity that makes her look even more exotic.  Throughout the dance you have the impression the woman glances your way whenever she can, and yet her movements and motions are so natural, so fluid, you have to wonder if she's really looking at you or just going through the choreographed motions of her dance.");

	outputText("\n\nFinally, at the climax of the song, the dancer's robe is set aglow, likely by the same substance that covers the stage, giving her a shining silver aura that illuminates the whole room and dazzles the watchers!");

	outputText("\n\nThe dancer spins one last time, slowly crouching and looking at you over her opened pair of fans, as the glow in her robes and the stage begin to fade.  The patrons, entranced, miss the ending of the show and begin to clap and cheer only a short while after the lights have gone back on inside the bar.  The dancer's eyes stay locked on you, even as a few of the patrons attempt to approach the stage and touch her. A pair of city guards enter the bar and make their way through the crowd, likely to open a passage for her egress.");

	outputText("\n\nYou watch her as she goes, and then get up to try to leave, elbowing your way through the crowd");
	//[(corr < 40)]
	if (player.cor < 40) outputText(" as politely as possible. It felt nice to see a display like that here; makes it feel a little less like a wasteland of sex-mad monsters and a little more like home");
	outputText(".");

	outputText("\n\nAs you exit the bar you hear someone say, \"<i>Hey!  Wait up!</i>\"");

	outputText("\n\nYou pause, wondering who it might be, and turn around to see who's calling with one concealed hand carefully ready to defend yourself; can't be too careful, after all.  Even if Tel'Adre isn't full of rapist monsters, that doesn't mean there aren't common muggers.  A tired bunny-girl clad in light-blue robes similar to the ones the dancer was wearing runs toward you.  In fact, staring at her, you're quite certain she <i>is</i> the bunny-girl who was just dancing.  You cautiously greet her, wondering what she wants.");

	outputText("\n\nTaking a moment to catch her breath, the bunny-girl smiles at you.  \"<i>Hello!  You're a new face... I don't think I've ever seen you around the city before; how long has it been since you moved?</i>\"");

	outputText("\n\nYou look at her and state that you don't live here in the city; you're just visiting.  She raises an eyebrow at that.  \"<i>Really?  So there are other places out there that are safe too?</i>\" she asks, covering her mouth, startled.");

	outputText("\n\n\"<i>Oh, where are my manners...?</i>\"  She extends her hand, cutting off any reply.   \"<i>I'm Loppe; pleased to meet you, umm...</i>\"");

	outputText("\n\nYou smile, share your own name in turn and then shake her hand.  It's quite a coincidence to see someone who has the same race as the dancer that was just eyeballing you in the Wet Bitch so soon afterward.  Loppe giggles, then comes clean.  \"<i>Yeah, that was me... did you enjoy the show?  Ah, actually, let's not talk about it here in the street... did you maybe want to come with me to this little bakery I know?  They make a mean carrot cake.</i>\"");
	//[Sure] [Not Really]
	menu();
	addButton(1,"Not Really",notReallyInterestedInLoppe);
	addButton(0,"Sure",sureBakeryWithLoppe);
}
//[=Not Really=]
private function notReallyInterestedInLoppe():void {
	clearOutput();
	outputText("You decline, and the girl gives you a look of disappointment.");
	outputText("\n\n\"<i>Well, that's... too bad.  Erm, if you change your mind, look me up, ok?  I spend a lot of time in the gym.  Gotta keep fit and maintain my dancer's body!</i>\"  For emphasis, or perhaps enticement, she runs her hands along her frame, flattening the robes to show off her curves... and a suspicious bulge tenting between her legs.  Following your gaze down to it, the girl turns bright red, claps a hand over her crotch and excuses herself, mumbling as she goes.");

	outputText("\n\n\"<i>Dammit, came on too strong...</i>\"");
	menu();
	addButton(0,"Next",telAdre.barTelAdre);
}

//[=Sure=]
private function sureBakeryWithLoppe():void {
	clearOutput();
	outputText("You consider the time of day, and the girl offering, and decide that it can't hurt.  Loppe smiles and takes your hand, leading you towards a nearby bakery.");

	outputText("\n\n\"<i>Carrot cake!</i>\" she happily pips to nobody in particular.  \"<i>With a side of chocolate-chip cookies, and some cupcakes.  Can't wait!</i>\"");

	outputText("\n\nThe carrot cake was something you could have seen coming, but what's with the cookies and cupcakes?  Is one little, dainty-looking bunny-girl really going to eat all that?");

	outputText("\n\nLoppe shrugs and smiles.  \"<i>I love sweets, and dancing works up an appetite.</i>\"  Then she gives you a seductive glance.  \"<i>You aren't going to deny a dainty-looking bunny-girl her pleasure, are you... sugar?</i>\"  She lets the last word roll off her tongue in a provocative manner.");

	outputText("\n\nYou tell her that you aren't, you just didn't expect her to have such an appetite.  With a playful smile, you ask what other not-so-dainty secrets she's hiding; does she burp loudly to show she enjoyed her meal?  Loppe smiles mischievously, \"<i>Oh, my sweet " + player.mf("boy","girl") + "...  When I get my hands on something I like, I eat it up whole...</i>\"  Slowly, you feel a foot gently glide across your [legs].");

	//(Low Libido)
	if (player.lib < 33) outputText("\n\nWell, now.  This is a different kind of world, indeed, but this feels a little too quick.  You're not sure you're all that comfortable with the bunny-girl feeling you up under the table, cute as she may be.  An awkward silence falls over the both of you as you try to think of a polite way to stop or slow her advances without telling her off... thankfully, the waitress arrives to take your orders.");
	//(Moderate Libido)
	else if (player.lib < 66) outputText("\n\nWell, now.  This is a different kind of world, indeed, but this feels a little too quick.  Still, it's not entirely unwelcome, and while you decide to leave your hand where it is, you allow her to continue, not hiding that you recognize what she's doing and you rather like it.  However, the waitress stops your playing around with her approach.");
	//(High Libido)
	else outputText("\n\nWell, now.  You surreptitiously slide a hand under the table and start stroking her calf through her robe, casually commenting that she must have quite an appetite for such a little lady.");

	outputText("\n\n\"<i>Yes; I'm positively ravenous...</i>\" she replies, and hikes her foot a little higher, not only intent on feeling you up, but also inviting you to do the same to her.");

	outputText("\n\nYou keep your hand where it is for now; there's a waitress ready for your orders.");

	outputText("\n\nLoppe clicks her tongue in disappointment and quietly retracts her foot.  \"<i>You know what I want, sugar.</i>\"  She smiles lasciviously, reinforcing the double entendre behind her apparently innocuous words.");

	//(if PC has >= 30 gems)
	if (player.gems >= 30) {
		outputText("\n\nYou tell the waitress, a fetching young cat-woman, what you'd like, and pull out the thirty gems needed to cover the tab; as mostly specialty items not on the usual menu, the price is a bit higher.");
		//[(corr > 40)
		if (player.cor > 40) outputText("  A small voice inside wonders if she'd eat so extravagantly were she footing her own bill.");
		//remove 30 gems
		player.gems -= 30;
		statScreenRefresh();
	}
	else {
		outputText("\n\nAs mostly specialty items not on the usual menu, the price for her items is a bit high.  You look at Loppe and admit you don't have the money on you to pay for the both of you.  The dancer smiles at you.  \"<i>Don't worry about it, [name]; I asked you out, so it's my treat.  Go ahead and order whatever you want.</i>\"  You thank Loppe and tell the waitress, a fetching young cat-woman, what you'd like; Loppe takes thirty gems from her pocket and hands them over.");
	}

	outputText("\n\nThe waitress jots down your order, snatches up the gems, and then walks off, tail swishing above a feminine butt.  You turn to look at Loppe, and notice she's staring with interest at the waitress's ass. \"<i>She's got quite a nice ass... I wouldn't mind getting behind that,</i>\" Loppe comments quietly, watching the cat-woman's tail swish.");
	outputText("\n\nLoppe giggles at your expression and answers the unspoken question.  \"<i>I do, [name].  It's not really girl-on-girl, though.</i>\"  Loppe stays silent for a long moment, then sighs reluctantly and gently but firmly takes your hand and places it over her crotch, where you can feel a most unfeminine bulge. She holds it there, then lets you go, looking at you all the while.");

	outputText("\n\n\"<i>... So?</i>\" she carefully asks.  \"<i>I do have a pussy as well, by the way.  I'm hermaphroditic.  This is the part where you can tell me to... fuck off, or go away, or something similar, if you like.  I've dated enough to know when someone isn't into me... and I'm not made of glass; I won't break, so don't worry.</i>\"  Despite her tough display you do notice a bit of moisture gather in her eyes.");
	//[Okay]  [NoWay]
	menu();
	addButton(0,"StickAround",okayLoppeLetsGo);
	addButton(1,"Go Away",NoWayLoppe);
}
//[=NoWay=]
//Removes Loppe from game.
private function NoWayLoppe():void {
	clearOutput();
	outputText("Loppe lets out a breath she had obviously been holding in a bitter sigh, the ghost of the words, \"<i>I knew it</i>\" echoing faintly as she does so.  \"<i>Well, I understand.  I just had to give it a try all the same.  It was nice talking to you, [name].  Might see you again, someday.  Sorry for wasting your time...</i>\"");

	outputText("\n\nShe drains her drink and stands up, walking out on you and her snack.");
	flags[kFLAGS.LOPPE_DISABLED] = 1;
	doNext(camp.returnToCampUseOneHour);
}

//[=Okay=]
private function okayLoppeLetsGo():void {
	clearOutput();
	outputText("Loppe looks at you, studying you to see if you're mocking her.  But when she detects only honesty, she sighs and breaths a sigh of relief.  \"<i>Sugar, you really are sweet.  I can't tell you the number of times I've been rejected just because I'm a herm... anyways, we can chat later.  Our food is here.</i>\"  She points toward the waitress holding your orders in a tray.  You nod to her in agreement and turn your attention towards the food, ready to savor the sweets.");

	outputText("\n\nLoppe's dress robe - a kimono, as she calls it - is very well-made, and it really hides her package well.  You wouldn't have thought she was a hermaphrodite if she hadn't revealed it during your little tête-à-tête.  You ask if her deception is, perhaps, intentional? She did say she got rejected plenty of times for being a herm.");

	outputText("\n\n\"<i>Haha, I have no problems with my sex.  It's just coincidence that this kimono is really good at hiding it.</i>\"  Loppe grins at you, then gives you a sultry look.");

	outputText("\n\n\"<i>Hey, [name],</i>\" she says quietly, \"<i>you're really " + player.mf("handsome","beautiful") + ", y'know?  And kind... how about a quick stop at my place, before we say goodbye?</i>\"");

	//[Yes][No]
	menu();
	addButton(0,"Yes",yesLoppesHouse);
	addButton(1,"No",noLoppesHouse);
}

//[=No=]
private function noLoppesHouse():void {
	clearOutput();
	outputText("Loppe gives a disappointed sigh, but smiles at you all the same.  \"<i>I understand... if you ever feel like talking some more, you can find me in the gym.  I need to keep myself in tip-top shape for my dancing shows, after all.</i>\"");
	outputText("\n\nShe sighs again, picks up her last cookie, and leaves.");
	//Loppe can now be found in the Gym
	doNext(camp.returnToCampUseOneHour);
}

//[=Yes=]
private function yesLoppesHouse():void {
	clearOutput();
	//Loppe can now be found in the Gym
	outputText("The dancer smiles mischievously at you.  \"<i>Wonderful.  I'm going to show you just how great my body looks without this dress.  You wouldn't believe how much time I spend in the gym, working out.</i>\"  Loppe grabs her last cookie in one hand and your arm in the other, leading you away - presumably to her house.  Enroute, she giggles constantly, provoking a question from you.");

	outputText("\n\n\"<i>I always get giddy when I can spend time with a sexy thing like you...</i>\" she replies, \"<i>but I was just recalling some of my earlier encounters.  I should warn you, I tend to get very, and I do mean <b>very</b> carried away during the act.  Things can get pretty intense.</i>\"");

	//(Min Lust >= 50)
	if (player.minLust() >= 50) {
		outputText("\n\nYou grin and warn her that your appetite is a lot higher than normal; you are usually so aroused that you have no doubt you can go at it a lot more than the average person.");
		outputText("\n\nLoppe shoots you a sultry look.  \"<i>Well, sugar, I guess I'll just have to take care of this 'endless lust' of yours, huh?</i>\"  She tightens her hold on your hand and starts walking faster, eager to get you to her place.");
	}
	//(else High Libido)
	else if (player.lib >= 70) {
		outputText("\n\nYou smirk back and announce that you like it intense.  Perhaps she's the one who should watch out?");
		outputText("\n\n\"<i>Oh, I like the sound of that... let's go, sugar!</i>\"  Loppe tightens her hold on your hand and starts walking faster, eager to get you to her place.");
	}
	//(else High Toughness and has beaten mino mob)
	else if (player.tou >= 70) {
		outputText("\n\nYou tell her that you're confident in your stamina.  Truth be told, you can withstand a fight with a whole mob of minotaurs and still have enough energy left to fight off demons.");
		outputText("\n\nLoppe smirks.  \"<i>So if I manage to tire you out, that would make me stronger than a mob of minotaurs, right?  Okay!  Challenge accepted!</i>\"  She tightens her hold on your hand and starts walking faster, eager to get you to her place.");
	}
	else {
		outputText("\n\nYou bite your lip eagerly, hoping that you haven't gotten in over your head with this girl.");
	}
	//(Continue on \"<i>Sex</i>\")
	menu();
	addButton(0,"Next",loppeSexChoice,true);
}

//Generic Meeting (edited) (C)
//Loppe can be found from 6:00 to 15:00 (yeah she works out like a boss!)
public function loppeGenericMeetings():void {
	clearOutput();
	outputText("You decide to approach the bunny-girl.  Loppe smiles and wipes the sweat off her brow with the towel.  \"<i>Hey there, [name], nice seeing you around here.  So... do you want to do something?  Talk, maybe?  Or go to my place for a 'workout'?</i>\" she asks with a smirk.");
	//Appearance
	//Talk
	//Sex
	//Special Training (Available after talking about \"<i>Your Job</i>\" at least once)
	//Meet Uma (Must have spoken about Loppe's mother and shagged Loppe at least once before.)
	menu();
	addButton(0,"Appearance",appearanceOfLoppe);
	addButton(1,"Talk",talkWithLoppe);
	addButton(2,"Sex",loppeSexChoice);
	addButton(4,"Leave",telAdre.telAdreMenu);
	//Leave (Return to Tel'Adre menu)
}

//Talk (edited) (C)
private function talkWithLoppe():void {
	clearOutput();
	outputText("That 'workout' is going to have to be postponed; you have some questions.");
	outputText("\n\nLoppe giggles, and her horse-tail waves as she does so.  \"<i>I'd much rather let my body speak for me, but alright.  Let's go to the cafeteria; I could use a break anyway.</i>\"  You follow her and find a seat in a booth on the corner.");

	outputText("\n\n\"<i>Okay then, what do you want to talk about?</i>\"");

	menu();
	//Loppe
	addButton(0,"Loppe",talkWithLoppeAboutLoppe);
	//Children (available after having sex with Loppe at least once)
	if (flags[kFLAGS.LOPPE_TIMES_SEXED] > 0) addButton(1,"Children",askLoppeAboutChildren);
	//Gossip (after sexin' once)
	if (flags[kFLAGS.LOPPE_TIMES_SEXED] > 0) addButton(2,"Gossip",gossipWithLoppe);
	//Working (after [Loppe]
	if (flags[kFLAGS.TIMES_ASKED_LOPPE_ABOUT_LOPPE] > 0) addButton(3,"Working",talkWithLoppeAboutWorking);
	//Her Mom (available after choosing \"<i>Loppe</i>\" at least once)
	if (flags[kFLAGS.TIMES_ASKED_LOPPE_ABOUT_LOPPE] > 0) addButton(4,"Her Mom",chatWithLoppeAboutHerMom);
	//Her Village (after [Loppe]
	if (flags[kFLAGS.TIMES_ASKED_LOPPE_ABOUT_LOPPE] > 0) addButton(5,"Her Village",chatWithLoppeAboutLoppesVillage);
	//The curse (unfinished; available after choosing \"<i>Loppe</i>\" at least once)
	//Fondle (after "Loppe"; see appropriate section)
	if (flags[kFLAGS.TIMES_ASKED_LOPPE_ABOUT_LOPPE] > 0 && flags[kFLAGS.LOPPE_TIMES_SEXED] > 0) addButton(6,"Tease Her",fondleAndTease);
	addButton(14,"Back",loppeGenericMeetings);
}

//Loppe (edited) (C)
private function talkWithLoppeAboutLoppe():void {
	clearOutput();
	outputText("You tell the laquine that you're curious about her, that you'd like to know more about her: who she is, where she comes from, et cetera.");

	outputText("\n\nLoppe nods.  \"<i>Okay, but it's kind of a long story, so I hope you have time.</i>\"");

	outputText("\n\nYou wouldn't have expected anything else, and rest your chin on a hand patiently.");

	outputText("\n\nLoppe acknowledges your gesture and scratches her own in thought.  \"<i>Hmm.  Where do I begin... I suppose my family is as good a start as any.  I was born in a small village to the far east.  We were a tiny but friendly community; my mother was a healer specialising in the traditional medicine of our ancestors.  My father... well, I never met my father.  But as you can tell, I'm a mix of leporid and equine... a laquine, if you will,</i>\" she finishes with a giggle.");

	outputText("\n\nThat raises the question of just how she came to be.");

	outputText("\n\nLoppe smiles, not insulted, and shrugs her shoulders.  \"<i>Well, it's unusual, I can tell you that... Although I have never been treated differently because of my mixed blood. Mom says my father was just the cutest bunny there is, it was love at first sight.</i>\"");

	outputText("\n\nYou tell her that from what her mom says, Loppe definitely must take after her dad's side of the family, giving her a winsome grin. Loppe smiles at you.");

	//(if first dialogue)
	if (flags[kFLAGS.TIMES_ASKED_LOPPE_ABOUT_LOPPE] == 0) {
		outputText("\n\n\"<i>Flatterer...  To tell the truth I used to look a lot more like my dad, but then came the curse...</i>\"");
		outputText("\n\nCurse?");

		outputText("\n\nLoppe shakes her head. \"<i>There are actually more than one species of bunny in this world.  You may have seen the cute ones with the ears and human faces... my father was a bit more like our animal cousins; fuzzy, cuddly... also lethal with a sword, though that's less related.  All the fun stuff.</i>\"");
	}
	else {
		outputText("\n\n\"<i>Flatterer... if you keep this up I might just have to drag you back to my place,</i>\" she replies with a smirk.");
	}
	outputText("\n\nSmiling, you move on; Loppe said her parents were in love - at first sight, according to her - but when you asked, she said she never knew her father.");
	outputText("\n\nLoppe shakes her head.  \"<i>Well... for some reason my father left us. My mother was furious when she woke up to find her gone, but still misses her greatly.</i>\"");
	outputText("\n\n'Her'? So, Loppe inherited her multiple endowments from one of her parents.  Or perhaps both?");
	outputText("\n\nLoppe grins at you.  \"<i>Well, I do take after my father in more ways than one.  Mom is a normal female.  She's actually a lesbian, and didn't know about my father being a herm.  You can imagine her surprise when she found out.</i>\"  She giggles.  \"<i>Though my mother might prefer girls, I don't think she minded my father's extra bits... otherwise I wouldn't be here now, would I?</i>\"");

	outputText("\n\n\"<i>Okay, moving on...  Our tribe, like many others, was attacked by demons.  I managed to escape along with my mother, but it was tough finding a new place to settle down, and the wilderness is very dangerous.  So we travelled, seeking a place of safety, until we heard of Tel'Adre.</i>\"  Loppe's usually happy face suddenly becomes apprehensive.");

	outputText("\n\n\"<i>On our trip to this place, we were ambushed by a demon... I had to protect my mother, so I offered myself as the demon's willing sex toy if she would let my mother go.  Of course my mother protested, but the demon silenced her by tying her up with black magic.  Then she proposed a challenge.  She said I could pick a game and if she managed to win the game, both my mother and I would become her slaves; if I won, we could both go.</i>\"  Loppe's eyes glint with mischief.");

	outputText("\n\n\"<i>I figured it was some kind of trap, so I suggested something the demon didn't expect.  A bout of sex.  And whomever outlasted the other would be the winner.  As you can see... I won.</i>\"  She grins at you.");

	outputText("\n\nYou tell her that was very brave - but very foolish.  How did she know the demon would actually keep her word?  What made her think she could actually win a contest like that, anyway?");

	outputText("\n\n\"<i>I have always had a very active sex drive.  I didn't know if I was going to win, but I had to try anyways.  The demon said she was very pleased with my choice, and would give me a boon.  So she turned me into this human-bunny-horse hybrid and gave me an even higher sex drive so I'd be a match for her.</i>\"  Loppe's face turns grim.");

	outputText("\n\n\"<i>That was a huge mistake... for her.  Under her lust-boosting spell, I just went absolutely nuts.  We had sex for hours on end; by the time I was done with her, she was knocked out cold in a pool of our mixed fluids and I set my eyes on my mother... still bound...</i>\"  She bites her lower lip.");
	outputText("\n\n\"<i>I nearly... nevermind.  I'm not going into any more detail about that.  Thanks for the chat.</i>\"");
	outputText("\n\nSurprised at the abrupt end, you rise when Loppe does, and return her thanks.");
	outputText("\n\n\"<i>I guess I'll see you later then.</i>\"");
	//set LoppeChat = 1
	flags[kFLAGS.TIMES_ASKED_LOPPE_ABOUT_LOPPE] = 1;
	doNext(camp.returnToCampUseOneHour);
}

//Children (edited) (C)
//req LoppeSexed > 0 and LoppeChat > 0
private function askLoppeAboutChildren():void {
	clearOutput();
	outputText("You decide to ask Loppe for her thoughts on children.  Has she considered having any?");
	outputText("\n\n\"<i>Kids, huh?  I suppose I've never given it much thought, but I guess I'd be willing if I ever found the right person, you know?  Don't want a rehash of my mom's story... plus I have my job as a dancer right now.  But I suppose I would like to have children in the future, to give my mom a bunch of grandkids... I'm sure she would like that,</i>\" Loppe finishes with a smile.");
	outputText("\n\nIt makes sense she wouldn't want to be a mother right now... but, what about being a father?  How can she control that?");
	outputText("\n\nLoppe grins at you.  \"<i>I have taken special measures to ensure neither my partners nor I will end up with an unexpected package.</i>\"");
	//(If EdrynKids or CottonKids =>1:
	if (flags[kFLAGS.EDRYN_NUMBER_OF_KIDS] + flags[kFLAGS.COTTON_KID_COUNT] > 0) outputText("\n\nYou warn her that might not be enough, as you've learned the hard way you're a bit too potent for most herbal contraceptives to handle.");

	outputText("\n\nLoppe winks.  \"<i>I know herbs aren't totally reliable for a fact, plus I've been around, so I realized I needed something a bit more... permanent... some time ago.  I've had a local wizard place a spell on me to make me completely sterile; and if I ever want to have kids, all I need to do is say a small incantation and the spell vanishes.</i>\"");

	outputText("\n\nYou nod your head in approval; that makes a lot of sense.  After all, with her little problem, you rather doubt condoms would hold up to how much she can put out... changing the subject, you ask what kind of person she's waiting for.");

	outputText("\n\nLoppe giggles.  \"<i>Why the question?  Could it be that you're interested?  Well I've certainly thought about removing the spell once or twice, but first I'd like to complete my training in acupuncture and do-in, plus I'd need a partner able to put up with my... well, my stamina.  I usually wear out my lovers way too fast, and that can't be healthy for a relationship.  To be quite honest... I wouldn't mind giving <b>us</b> a shot... once the time is right.  I really did enjoy our little escapade.</i>\"  Loppe favors you with a sultry look.");

	outputText("\n\nSmiling back at her, you let her draw her own conclusions about your interest level.  For a change of subject, you ask if Loppe really does like kids - or the idea of having kids, anyway.");

	outputText("\n\n\"<i>I think I already answered that.  I do love kids, and I would very much like to have my own; I can only hope that I'll be a mother - or maybe a father - half as good as my mom is, though.  But that's enough about me... what about you, [name]?  Where do you stand on the subject?</i>\"");

	outputText("\n\nYou contemplate that little matter for a moment; how do you feel about kids?");

	menu();
	//[Don't Want][Maybe][Someday][Soon][No Opinion]
	addButton(0,"Don't Want",loppeIDontReallyWantKidsYouStupidTwat);
	addButton(1,"Maybe",loppeKidsAreOkayIfYoureARabbitOrSumthin);
	addButton(2,"Someday",loppeIWantKidsSomedayJeezeQuitHasslingMe);
	addButton(3,"Soon",loppeIWantKidsSoonOkayCanWeFuck);
	addButton(4,"No Opinion",noOpinionOnLoppeArt);
}

//[No Opinion] (spacebar default)
private function noOpinionOnLoppeArt():void {
	clearOutput();
	outputText("You decline to answer, waving the question off.  Loppe raises an eyebrow at that.  \"<i>Haven't thought about it either, huh?</i>\"");
	outputText("\n\n\"<i>Just making conversation,</i>\" you reply.");

	outputText("\n\nLoppe nods, finishes her meal quietly, and departs.  \"<i>See you later, [name].</i>\"");
	doNext(camp.returnToCampUseOneHour);
}

//[=Don't Really Want Them=]
private function loppeIDontReallyWantKidsYouStupidTwat():void {
	clearOutput();
	outputText("You confess you aren't really a 'kids' person; you don't think you could ever envision yourself as a parent, especially in this crazy world.");

	outputText("\n\n\"<i>I see...</i>\" Loppe says, a bit disappointed.  \"<i>Well, it's good to know your opinion on the matter.  If you'll excuse me, I should get back to my exercises.</i>\"");

	outputText("\n\nYou watch her go, then casually remove yourself from your seat and exit.");
	doNext(camp.returnToCampUseOneHour);
}


//[=They're Okay=]
private function loppeKidsAreOkayIfYoureARabbitOrSumthin():void {
	clearOutput();
	outputText("You finally announce that you're hardly what you'd call interested in being a parent, but you think that you could eventually see yourself having kids.  You don't think you'd be too upset if one day you found you were going to have a little bundle of joy, but you must admit you probably wouldn't go and try to have kids on purpose.");
	outputText("\n\n\"<i>So, you'll just leave that to chance?  Or are you waiting for that someone special as well?</i>\" Loppe asks.");
	outputText("\n\nShe grins at you.  \"<i>No need to answer.  I'm sure you'll find someone special if you look.  Anyways, it's good to know your opinion on the matter.  If you'll excuse me, I should get back to my exercises.</i>\"");
	outputText("\n\nShe rises from her seat and departs.");
	doNext(camp.returnToCampUseOneHour);
}
//[=Someday=]
private function loppeIWantKidsSomedayJeezeQuitHasslingMe():void {
	clearOutput();
	outputText("You always saw yourself as having children at some point in your future.  Coming through the portal, though, you gave up on that dream; when you first arrived, it seemed like the world had nothing in it but imps and goblins and other twisted monsters - what kind of family could you make with people like that?");
	outputText("\n\nLoppe smiles at you. \"<i>I know the world might be a bit screwed up now, but I have hope that everything will go back to normal... or at least close enough.  So... do you have anyone 'dear' to you yet?  Any plans for a family, as of right now?</i>\"");
	outputText("\n\nYou slyly suggest that you'll tell her who you like as soon as she tells you.");
	outputText("\n\nLoppe grins at you.  \"<i>I might be interested in someone, actually... anyway, it's good to know your opinion on the matter.  If you'll excuse me, I should get back to my exercises.</i>\"");
	outputText("\n\nYou watch her go, then casually remove yourself from your seat and leave.");
	doNext(camp.returnToCampUseOneHour);
}
//[=Soon=]
private function loppeIWantKidsSoonOkayCanWeFuck():void {
	clearOutput();
	outputText("With a faint smile, you declare that having children is definitely in your future.  You want to be a parent; all you need is to find somebody who feels similar to you.");

	outputText("\n\nLoppe smiles at you.  \"<i>I'm sure you will.  Maybe, if the time is right, I might be willing to help you build you a nice, big family... just maybe.</i>\"  Loppe shoots you a sultry stare.");
	outputText("\n\nHmm... is that a suggestion?");
	outputText("\n\nLoppe grins at you.  \"<i>Oh... I don't know.  I'm sure a " + player.mf("handsome","beautiful") + " person like you has already drawn quite a few stares,</i>\" Loppe teases, batting her eyes at you.  \"<i>But, if the time is right, and you ask nicely... I'm pretty sure there's a certain bunny-girl around here who wouldn't mind...</i>\"");

	outputText("\n\nWell, you'll keep that in mind.  Realizing how much time has gone past, you politely excuse yourself.");

	outputText("\n\n\"<i>It was nice chatting with you, [name].  Come visit me soon,</i>\" Loppe says, giving you a little peck on the cheek.");
	doNext(camp.returnToCampUseOneHour);
}

//Gossip (edited) (C)
//req LoppeSexed > 0
//Player can pick the character they want to talk about via buttons; if no options are present, auto-leave.
//Must also have met the character they want to talk about at least once, and said character must not have been disabled from the game. Otherwise we might have awkward results...
private function gossipWithLoppe():void {
	clearOutput();
	outputText("You ask Loppe if she has any comments on the other residents of Tel'Adre.  The laquine smiles at you.  \"<i>It's not polite to pry into other people's lives, y'know?</i>\"");
	outputText("\n\nLoppe closes her eyes, weighing your request carefully, before replying, \"<i>Even so, I think I'll humor you... I do get to meet all sorts of people in my line of work.  But you'll have to be a bit more specific; why don't you tell me who you'd like to talk about?</i>\"");
	menu();
	//Build menu - see notes above func name
	//Urta
	addButton(0,"Urta",gossipWithLoppeAboutUrta);
	//Scylla (Must have helped her enough times to know she needs cum to survive.)
	if (flags[kFLAGS.NUMBER_OF_TIMES_MET_SCYLLA] > 0) addButton(1,"Scylla",gossipWithLoppeAboutScylla);
	//Jasun
	if (flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00179] > 0) addButton(2,"Jasun",gossipWithLoppeAboutJasun);
	//Heckel
	if (flags[kFLAGS.MET_HECKEL] > 0) addButton(3,"Heckel",gossipWithLoppeAboutHeckel);
	//Edryn
	addButton(4,"Edryn",gossipWithLoppeAboutEdryn);
	//Lottie
	if (flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00281] > 0) addButton(5,"Lottie",gossipWithLoppeAboutLottie);
	//Cotton
	if (flags[kFLAGS.COTTON_MET_FUCKED] > 0) addButton(6,"Cotton",gossipWithLoppeAboutCotton);
	//Back (spacebar default)
	addButton(14,"Back",talkWithLoppe);
}

//Urta:
private function gossipWithLoppeAboutUrta():void {
	clearOutput();
	//(if UrtaSex or UrtaLover flags are NOT active)
	if (flags[kFLAGS.TIMES_FUCKED_URTA] <= 0 || flags[kFLAGS.URTA_COMFORTABLE_WITH_OWN_BODY] == -1) {
		outputText("\"<i>Ah, so you've met Watch Captain Urta?  She's famous around here, you know; people say she's a legendary bare-knuckle brawler and one of the toughest guards on the force.  The only problem is that she's not really that easy to approach... I guess she prefers to keep to herself.  Although she acts very friendly with that pretty centauress, Edryn.</i>\"");
		outputText("\n\nLoppe taps her lips thinking of what else she could add, but shrugs.  \"<i>I guess that's all I have on her - I don't really know her that well.  Sorry!</i>\"");
		doNext(camp.returnToCampUseOneHour);
	}
	else if (flags[kFLAGS.LOPPE_URTA_CHATS] == 0) {
		outputText("Loppe smirks at you.  \"<i>I heard she's been getting along nicely with a certain outsider; you wouldn't happen to know anything about that, would you, [name]?</i>\"");
		//[It's Me] [No]
		menu();
		addButton(0,"It's Me",itsMeFuckingUrtaLoppe);
		addButton(1,"No",noLoppeWhosFuckingUrta);
	}
	//(if LoppeUrtaKnowledge > 0)
	else {
		outputText("\"<i>Urta again, huh?</i>\"  Loppe stares you, but her curious expression turns into one of smug triumph, like a cat that's caught a mouse.  \"<i>So... she has a big horse-cock.  I'm beginning to see a pattern here, sugar.   You like women with huge equine parts?  Is that why you hang out with me?  With Urta?</i>\"");
		menu();
		//[Play Along][Admit][Deny]
		addButton(0,"Play Along",playAlongWivLoppesesUrtaGossip);
		addButton(1,"Admit",admitToLoppeThatYouLoveZeHorsecock);
		addButton(2,"Deny",denyToLoppeThatYouLoveZeHorsecock);
	}
}

//[=No=]
private function noLoppeWhosFuckingUrta():void {
	clearOutput();
	outputText("You shake your head, claiming that you have no idea what she's talking about.  Loppe looks at you, then shrugs, clearly not caring if you don't have any gossip on the subject to share.");
	//end scene
	doNext(camp.returnToCampUseOneHour);
}
//[=It's Me=]
private function itsMeFuckingUrtaLoppe():void {
	clearOutput();
	//set LoppeUrtaKnowledge = 1
	flags[kFLAGS.LOPPE_URTA_CHATS] = 1;
	outputText("Loppe is surprised at this news.  \"<i>Really?  I would never have guessed... anyways, that is not important right now!  Give me all the juicy details of your rendezvous!  I thought I saw her packing something non-regulation into her trousers, but... let's just say the watch uniforms aren't as concealing as a kimono.</i>\"  She looks at you expectantly, like a rabbit that's found the literal carrot patch.  You smile back, then gently tap her on the nose to chastise.");
	outputText("\n\nThe dancer pouts at you.  \"<i>That's not fair.  You wanted me to gossip, but you're not willing give up any gossip of your own?</i>\" She makes a motion of mock hurt.  \"<i>How could you take advantage of a poor laquine, [name]?  Am I right, at least?  Is it big?</i>\"");
	outputText("\n\nIn the face of her insistence, you turn your empty glass on its side, then stand your coaster on its rim quite a ways apart.  She stares at them for a few seconds before your meaning becomes clear.");
	outputText("\n\n\"<i>Really!?  But, then... mine's only... how is that even possible?  I'm literally hung like a horse!</i>\" the half-breed herm protests disjointedly.");

	outputText("\n\nThat earns her a raised eyebrow.");

	outputText("\n\n\"<i>Oh my goodness!  Her, too?</i>\" Loppe blurts, before rallying.  \"<i>Well... bigger doesn't mean better,</i>\" she says, still sounding a little defensive - maybe jealous, \"<i>I'm pretty sure I can give you a ride like she could never hope to.  Just call her over and get us a room and I'll show you what I mean, sugar.</i>\"");
	outputText("\n\n\"<i>Perhaps,</i>\" you laugh.");
	outputText("\n\nLoppe grins encouragingly, as though her offer were completely serious.  \"<i>Well, anyways... I'd say you'd be in more position to gossip about her than I would.  </i>You<i> can tell </i>me<i> about her next time.  For now, I'm going to go work off these calories.</i>\"");
	dynStats("lus", 10+player.lib/10);
	doNext(camp.returnToCampUseOneHour);
	//End Scene
}

//[=Play Along=]
private function playAlongWivLoppesesUrtaGossip():void {
	clearOutput();
	outputText("And... what would she do if, hypothetically, you <i>did</i> have a fetish for dickgirls ready to give a stallion an inferiority complex?");
	outputText("\n\nLoppe gives it some thought.  \"<i>There's not enough paper in Tel'Adre to list the things I would do, sugar.  It'd be a long, hard punishment, but I'm sure we could eventually come - to a mutual understanding.</i>\" Loppe winks at you, laying special emphasis on the last words.");
	outputText("\n\nYou exaggeratedly shiver at the prospect, and tell her she's starting to paint a very pretty picture... reaching out with a [foot], you gently stroke her calf, asking if she's sure she'd be okay with that.");
	outputText("\n\n\"<i>As sure as the day is bright,</i>\" she replies with a smile.  Her paw twitches and starts brushing against you as well.");
	outputText("\n\nWell then, maybe it's her lucky day, but...  Loppe clearly likes the idea of you having a fetish for her body, but are you going to like what Loppe wants to do to you with it?");
	outputText("\n\n\"<i>Sugar... you have no idea.  I'd take you home and let you get <b>very</b> acquainted with all the finer anatomical features of my body.  While you're doing that, I'd be getting <b>very</b> acquainted with all of yours.  And then I'd let you do whatever you want to me and my 'little' horsey.  Then we could 'ride' all day long...</i>\"  Loppe says dreamily, giving you a winning smile.");
	outputText("\n\n\"<i>Sure,</i>\" you agree, preparing to let the other shoe fall.  \"<i>Of course, this is all totally hypothetical...</i>\"");
	outputText("\n\nLoppe goes slack-jawed.  \"<i>Awww, don't be like that...</i>\"  She takes your hand, moves it under the table and presses it against the bulge in her shorts.  You think you can almost feel the seams of her tights protesting against the strain. \"<i>You're not just going to leave me like this... right, sugar?</i>\"");
	outputText("\n\nHer voice is almost liquid with desperation and lust, and you sadistically rub her straining bulge, playing your fingers absently over the stretched material, then 'remember' that you had plans to meet with Urta.");
	outputText("\n\n\"<i>Sugar, wait up!  I know you said she's bigger and yada, yada, yada.  But size isn't everything... I doubt she is able to keep up as long as I am, or that she's as experienced as I am, so let's just tuck ourselves in a corner and you can help me with this... please?  Pretty please?  With cream on top?  Or bottom, or wherever you want it?  Just a quickie, so I can go back to working out?</i>\"  Loppe is on the verge of begging, and a pained look contorts her face as you hear the distinct sound of a seam ripping.  Loppe's hands dart to her shorts, trying to hold it together against her straining erection.  \"<i>Fuck!</i>\" she hisses.");
	outputText("\n\nYou could just leave her like this or give her some relief... though you'd better be quick if you choose the latter.   You could always slide under the table and help blow off her steam, but a small part of you wonders just how upset she'd be if you kept rubbing her until her seams gave out and she creamed herself.");
	dynStats("lus", 10+player.lib/10);
	//[Suck] [Handjob] [Kiss 'n' Run]
	//See the Tease section for these scenes//
	//Tease Menu options!
	fondleAndTease(false);
}

//[=Admit=]
private function admitToLoppeThatYouLoveZeHorsecock():void {
	clearOutput();
	outputText("You look her in the eyes and tell her she's hit the nail on the head; you do have a fetish for chicks with dicks, and having a horsecock makes a dickgirl even sexier to you.");
	outputText("\n\n\"<i>Huh.</i>\"  Loppe rubs her chin.  \"<i>Y'know?  I always thought I'd be getting a lover despite my endowments... certainly not because of them.</i>\"");
	outputText("\n\nSo, she doesn't think less of you for it...");
	outputText("\n\nLoppe bursts out laughing when you raise the question.  \"<i>Of course not, sugar!  A sweet thing like you could never be a freak. We all have preferences, y'know?</i>\"");
	outputText("\n\nRelief washes over you; she's taking it much better than you dared hope.  She actually doesn't even seem mad... you ask again, to be sure she's fine with your fixation.");
	outputText("\n\n\"<i>Sugar, of course I'm okay... no woman's going to get mad when she hears that her body is more attractive than any other, if you say it carefully enough and look as cute as you do.</i>\"  Loppe smiles.  \"<i>Frankly, I like the idea of being your walking wet dream.</i>\"");

	outputText("\n\nHer smile turns into a studied expression.  \"<i>Tell me something though.  What about Urta?  How do you feel about her?  Just curious,</i>\" Loppe quickly amends, taking a sip of her drink.");

	outputText("\n\nYou briefly recount the circumstances of your acquaintance with the watch captain, up to the present.");

	outputText("\n\nLoppe smiles at you.  \"<i>Good for you, sugar.  I'm sure Urta is very fond of you.  Still... that is quite a stroke of luck...</i>\"");
	outputText("\n\nTo find two women built that way in one city?  Yes it is, you concede.");
	outputText("\n\nLoppe nods.  \"<i>That is an oddly specific fetish though... don't you think?</i>\"");
	outputText("\n\nWell... compared to things like feet, hair, pregnant bellies, chubby people, and more, is it so strange?");
	outputText("\n\nLoppe taps her chin in thought.  \"<i>Maybe you're right...</i>\"   Then she dismisses the subject and shoots you a come-hither look, resting her chin on both hands and lowering her eyelids at you.  \"<i>So, sugar, want me to help you enact your wet dreams?  I'm just as happy getting my workout in the comforts of home, y'know... ?</i>\"");
	//[Yes] [No]
	menu();
	addButton(0,"Yes", loppeSexChoice,true);
	addButton(1,"No",dontLoppesHouse4Fucks);
}


//[Admit -> No]
private function dontLoppesHouse4Fucks():void {
	clearOutput();
	outputText("Loppe raspberries you.  \"<i>You tell me you love herms with big horse cocks and now you won't have sex with me?  You're one big tease, [name].</i>\"");
	outputText("\n\nThe dancer finishes her drink and leaves you, with a sly glance out of the corner of her eye.  It's unlikely that you've heard the last of this...");
	//return to wherever
	doNext(camp.returnToCampUseOneHour);
}

//[=Deny=]
private function denyToLoppeThatYouLoveZeHorsecock():void {
	clearOutput();
	outputText("Not in the mood to play along with Loppe's little game, you simply state that your reasons are your own and will stay that way for now.");
	outputText("\n\n\"<i>Aww, sugar.  You're no fun...</i>\" Loppe says, pouting at your refusal to play along with her games.  \"<i>But you're really sweet, so I guess I can forgive you.</i>\"  The dancer gets up and gives you a quick peck on the cheek.  \"<i>I should get back to my training now.  I'll see you later!</i>\"");
	outputText("\n\nLoppe waves and runs off to get back to her routine.");
	//return to wherever location
	doNext(camp.returnToCampUseOneHour);
}

//Scylla:
private function gossipWithLoppeAboutScylla():void {
	clearOutput();
	outputText("\"<i>The nun who likes sucking on dicks?</i>\" Loppe asks you.  \"<i>Yes, I've run into her at the Wet Bitch.  She offered to blow me too.  I was tempted, y'know?  She has those wonderful looking lips... nice big breasts too... but ultimately I wound up refusing.  It's just... not right.</i>\"");
	outputText("\n\nHuh... if there were anyone you'd be willing to bet would gladly accept Scylla's offer, that would be Loppe.");
	outputText("\n\n\"<i>It's just that she's a nun, y'know?  Or at least looks like one.  I mean... I'm not sure if this is some kind of fetish of hers or she really is a nun, but it'd be just weird to have one sucking me dry.</i>\"");
	outputText("\n\nSo, Loppe's got no naughty nun fetish.  It's a little surprising to hear her turn down a willing date, though.");
	outputText("\n\n\"<i>No, I just don't like the idea of a nun blowing me.</i>\"  Loppe states matter-of-factly.  You feel strangely that there's more to this than Loppe's willing to say, but decide to drop it.");
	doNext(camp.returnToCampUseOneHour);
}

//Jasun:
private function gossipWithLoppeAboutJasun():void {
	clearOutput();
	outputText("\"<i>The male shark living in the pools of the gym?  Oh boy, is he self-obsessed.  He spends his days swimming and bodybuilding; looks almost cubical because of how much time he spends with the weights and things.  He's also an arrogant prat, but fortunately he's easy to ignore and he doesn't go sticking his nose into trouble.  Just brush him off and he's harmless.</i>\"");
	outputText("\n\nSounds like Loppe has had to deal with him herself.");
	outputText("\n\n\"<i>I went for a swim in the pools once, had the inconvenience of running into him,</i>\" Loppe replies.  \"<i>Bastard seems to hate anything and anyone that has a cock of their own; all I did was say hello - I wasn't even trying to flirt - and he tells me to stay away, calls me a floozy!  What a jerk.</i>\"");
	doNext(camp.returnToCampUseOneHour);
}

private function gossipWithLoppeAboutHeckel():void {
	clearOutput();
	outputText("You ask if Loppe's ever had a run-in with a herm hyena who's usually running in the track at the gym.");
	outputText("\n\nAt this, Loppe scowls.  \"<i>Oh, her?  Yeah, I've seen her once or twice.  Thinks she runs the gym.  Alpha bitch my sweet bunny ass...</i>\" she grumbles to herself.  \"<i>Her name's Heckel.  Don't know too much about her except she wandered in from the plains one day; she lives to prove she's stronger than everyone, and she's a real jerkass.  Why do you ask?</i>\"");
	outputText("\n\nYou shrug. At that, she shakes her head.  \"<i>Maybe there's more than what you see with her, but she's too caught up in that precious 'queen bitch of the universe' routine of hers.  I don't mind catching, but I expect a little respect while I do it - I am not going to let anyone just throw me down, bust their nut in my ass and then fall asleep on me.</i>\"  She lets out an indignant huff at the thought.  \"<i>Plus, you try and compliment her on anything about her femininity, she goes nuts!  Personally, I wouldn't be too surprised to hear she used to be a guy and she's overcompensating since she grew a pussy and boobs.</i>\"");
	outputText("\n\nLoppe obviously doesn't like her too much, and her expression warns you to cut the conversation short and thank her for the info.  \"<i>Sure thing, sugar.  Sorry, she and I... didn't exactly have a pleasant acquaintanceship.  I do my best to stay out of her way, but if she ever tries to bully me, well, I'll stand up for myself.</i>\"");
	doNext(camp.returnToCampUseOneHour);
}

//Edryn:
private function gossipWithLoppeAboutEdryn():void {
	clearOutput();
	outputText("\"<i>That pretty centauress watchwoman that hangs in the Wet Bitch when she's off duty?  Yes, it's no secret that she specializes in particular sorts of wetwork for those with... compatible endowments,</i>\" Loppe says, giving you a lecherous wink.");
	outputText("\n\nSomething in her look suggests a question to you.");
	outputText("\n\n\"<i>Well... maybe I've used her once or twice,</i>\" the dancer admits.  \"<i>But she costs 200 gems a ride and, frankly, she thinks I overdo things too much, so she wouldn't have me back even if I wanted to pay that much.</i>\"  Loppe looks rather sheepish as she smiles nervously, then looks right at you.  \"<i>Well... I shouldn't need her anyways, right?  Not as long as you come see me once in a while.</i>\"");
	doNext(camp.returnToCampUseOneHour);
}

//Lottie:
private function gossipWithLoppeAboutLottie():void {
	clearOutput();
	outputText("\"<i>That pig-girl that started hanging around the gym in the evenings?  I heard about her... I believe she wants to get fit,</i>\" Loppe comments conversationally.");
	//(if PC's training Lottie)
	if (flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00299] == 1) {
		outputText("\n\n\"<i>Seems like she found a gym buddy.  That's great; poor thing could really use some help with that.  She tries hard in short bursts, but she needs to actually stick with it and eat a proper diet.  Ah, I suppose I should hide the carrot cake before saying that, huh?</i>\"");
	}
	//(else if PC's met Lottie)
	else if (flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00281] > 0) {
		outputText("\n\n\"<i>Poor girl hasn't found a real partner to help her yet.  Maybe you could give her a little attention if you're going to be around?  I bet she'd be grateful.</i>\"");
	}
	else {
		outputText("\n\n\"<i>I thought about helping, but I'm not very good at training others.  I'm afraid if I did invite her to work out with me, and I mean actually work out, I'd kill her from exhaustion; I tend to get a bit carried away, and she is, well, let's just say she doesn't really look like she's ever tried seriously working out before.  I actually talked to her a little, once, and it looks like she's always tried fad dieting before now.</i>\"  Loppe smiles nervously.");
	}
	doNext(camp.returnToCampUseOneHour);
}

//Cotton:
private function gossipWithLoppeAboutCotton():void {
	clearOutput();
	outputText("\"<i>That pretty horse-girl that's always practicing yoga?  Not really, but she looks friendly.  As does that beast in her shorts.</i>\"  Loppe flinches at the memory of it.  \"<i>I'm very familiar with Cotton's not so little friend... though you'll find out that size isn't everything, sugar.  For instance, can she last long enough to fuck every little ounce of energy out of you?  I don't think so...</i>\"");
	outputText("\n\nUncharacteristically defensive... perhaps Loppe has a bit of a complex?");
	outputText("\n\nThe dancer giggles, snapping you out of your musing.  \"<i>That technique she has is something, but mine's not bad either.  I'm game for some fun anytime, especially if it's with a cutie like you, sugar.</i>\" She reaches out to give your cheek a small caress.");
	doNext(camp.returnToCampUseOneHour);
}

//Working (edited)
//req LoppeChat > 0
private function talkWithLoppeAboutWorking():void {
	clearOutput();
	outputText("Her curse naturally impacts her social life, but what about work?  How do she and her mother put food on the table?");
	outputText("\n\nLoppe smiles and shakes her head.  \"<i>Well, I am training to become a proficient masseuse and acupuncturist.  Most of my income comes from dancing though, which is why I work so hard to maintain my figure.  But I've always admired mom's work... and if I learned her trade I'd be able to take some weight off her shoulders, plus we'd get to spend more time together.</i>\"");
	outputText("\n\n\"<i>I see... do you enjoy it?  Is it difficult?</i>\"");
	outputText("\n\nLoppe nods.  \"<i>Yes, I do enjoy it.  It's a lot less stressful than dancing, y'know... and it also helps people, so what's not to like?  As for studying it... it IS kind of difficult.  But lucky for me, my mom is an excellent teacher.</i>\"");
	outputText("\n\nLoppe taps her chin in thought when you prompt her for more details.  \"<i>Well... first I have to know all the pressure points in the body of the patient; which is not easy since there is a wide variety in species, plus the cases of mutation when you have someone with body-parts from different species.  Then I have to know how to read the flow of the patient's body, which means I have to know what each reaction from the pressure points means.  Then I need to learn how much pressure, or how many needles, are needed to fix that particular problem.  Then I analyze the patient's energy flow again... and, well, it's complicated.</i>\"  She grins nervously.");
	outputText("\n\n\"<i>It'd be faster if I had someone to work with, but I can't risk botching mom's work by training on her customers, so progress is slow...</i>\"");
	outputText("\n\nYou nod your head in understanding, and tuck that fact away in the back of your head.  Realizing how much time has passed, you politely tell Loppe that it's time to go.");
	outputText("\n\n\"<i>Oh, ok.  I should get back to my exercises anyways.</i>\"  Loppe gets up and gives you a little peck on the cheek.  \"<i>It was nice chatting with you; come see me soon.</i>\"");
	//set LoppeChat = 2
	flags[kFLAGS.TIMES_ASKED_LOPPE_ABOUT_LOPPE] = 2;
	doNext(camp.returnToCampUseOneHour);
}

//Her Mother (edited)
private function chatWithLoppeAboutHerMom():void {
	clearOutput();
	//req LoppeChat > 0
	outputText("Loppe rubs her chin, deep in thought.  \"<i>Where do I start?  I guess by saying that my mom is a super mom.  She raised me all on her own, and she's always had time for me, despite having to keep up with her job.  I love her very much.</i>\"");
	outputText("\n\nRemembering what Loppe mentioned when you last talked about her family life, you ask if she could tell you a bit more about her mother.  For example, what's her name?  What sort of person is she?");
	outputText("\n\n\"<i>I never did mention mom's name, did I?  Her name is Uma, and she's a horse.  She's a really nice person, and is very good with her hands... then again, she has to be, being a masseuse and acupuncturist.  She's always smiling and is very positive, although she can be kinda scary when she's mad,</i>\" Loppe adds, with a smirk.");
	outputText("\n\nYou can't resist smiling and asking if Loppe has maybe been a bad little girl for her poor hard-working mom in the past?");
	outputText("\n\n\"<i>Oh, no.  I've always been good, but I can't say the same of a few clients who weren't respectful enough...</i>\" Loppe says, looking away in no specific direction.");
	outputText("\n\nHah... does Uma know about her little girl's 'adventures'?  Dancing for crowded bars at night, propositioning strange people like yourself?  Why, whatever would she say if she found out?");
	outputText("\n\n\"<i>Well... maybe she doesn't know EVERYTHING about her little girl...</i>\" Loppe smiles.  \"<i>But seriously though, I think mom knows I'm no stranger to sex, and she definitely doesn't believe I had a desk job at the guard, even though Urta's tried to help me convince her.  Yet she doesn't touch the subject, and I'm not crazy enough to bring it up.  Behind that gentle, caring smile of hers hides a terrible monster that would visit unspeakable punishment to those who would dare defy her.</i>\"  Loppe giggles at her own joke.");
	outputText("\n\nSurely she could have thought of something more believable than a secretary for the Watch...");
	outputText("\n\nLoppe shrugs.  \"<i>I was on the spot, and that was the only thing I could think of at the moment.  I was... busy, you see,</i>\" Loppe grins.");
	outputText("\n\nYou sigh softly and shake your head in amusement, then change the subject.  Has Uma found any girlfriends since Loppe's father ran out on them?");
	outputText("\n\nLoppe shakes her head.  \"<i>As far as I can tell, mom isn't seeing anyone.  And that's the way it's been, ever since I was a little girl.  I don't think mom could bear to have a relationship after my father... but she doesn't let that get to her either, as far as I can tell...  Why the sudden interest in my mom's sex life, anyway?  You interested in her?</i>\"");
	outputText("\n\nYou ignore the question and point out that if Uma's got a girlfriend of her own, never mind if she's been playing the field, well, she can't really get upset if her daughter's found herself a lover... or several.");
	//(If PC is male:)
	if (player.gender == 1) outputText("  Well, from what Loppe's told you, Uma wouldn't be attracted to you anyway.");
	outputText("\n\nLoppe giggles and grins. \"<i>Silly [name].  I don't need several lovers.  Just one... the perfect one.  And I don't think my mom would be upset either way.  She knows I'm a big girl now.</i>\"");

	if (flags[kFLAGS.LOPPE_PC_MET_UMA] == 0)
	{
		outputText("\n\nSo, if she's so confident that her mom wouldn't disapprove of her daughter's sexual awakening... what about your relationship?\n\n");
		outputText("Loppe looks you over, thoughtful.  \"<i>To be honest... I don't think she would mind.  Want me to introduce you to her?  To become my 'official' " + player.mf("boy", "girl") + "friend?  I know I certainly wouldn't mind having a 'serious' relationship with a cutie like you.</i>\"  The dancer winks at you. \"<i>How about it Sugar, do you wanna go visit my mom?</i>\"");
	}

	menu();

	if (flags[kFLAGS.LOPPE_PC_MET_UMA] == 0)
	{
		addButton(0, "Visit Mom", telAdre.umasShop.firstVisitPart1);
		addButton(1, "Mebbe Later", camp.returnToCampUseOneHour);
	}
	else
	{
		addButton(0, "Next", camp.returnToCampUseOneHour);
	}

}

//Her Village (edited)
//req LoppeChat > 0
private function chatWithLoppeAboutLoppesVillage():void {
	clearOutput();
	outputText("You ask if Loppe would be willing to tell you about her village.");
	outputText("\n\nAt this, Loppe smiles.  \"<i>It was quiet and peaceful.  We lived by a river far from here, on floodplains.  We grew crops, wove linen, made art... we were just your basic nobodies; do no harm to others and all that.  We knew of the demons, but we trusted in our isolation and peaceful ways to keep ourselves from needing armaments.</i>\"  She shakes her head sadly, obviously well aware now of what a foolish belief that was.");
	outputText("\n\n\"<i>Our customs... well, it's kind of hard to be specific; your strange is my normal and all that.</i>\"  She laughs.  \"<i>Most of us dressed like I did when we met... well, if they could afford it.  To be honest, kimonos are very expensive garb - if you had them, you usually didn't wear them except to formal occasions; festivals, parties, that kind of thing,</i>\" the dancer elaborates.");

	outputText("\n\n\"<i>The usual was a shirt with an open front that was wrapped so one side overlapped the other, tied together with a waistband, another wrapping around the loins that wasn't much more than a glorified loincloth, and long trousers with wide-opening, almost robe-like legs.  Of course, if you were going out in the fields, often you'd just wear the shirt and the underpants.</i>\"  The laquine grins at you.");

	outputText("\n\nYou nod in understanding, moving the conversation back to her dancing.  \"<i>Well, there's no story to it, sugar; dancing is dancing.  It's just something we loved to do in the village.  Oh, there are stories behind individual dances, roles they're intended to be used to act out, but mostly it's just our favorite way of unwinding and cutting loose.  I always admired the beautiful dancers when I was growing up.  When I realized just how good on my feet I was, I started practicing and, well, here I am.</i>\"");

	outputText("\n\nTo demonstrate, she finishes her last mouthful and hops nimbly from her chair to her feet.  \"<i>I'll see you soon, sweet.</i>\"");
	doNext(camp.returnToCampUseOneHour);
}

//Sex
private function loppeSexChoice(bakery:Boolean = false):void {
	clearOutput();
	//First Time Intro (edited)
	if (flags[kFLAGS.LOPPE_TIMES_SEXED] == 0) {
		//first-time only output, if not coming from bakery date
		if (!bakery) {
			outputText("That 'workout' seems like a nice option right now.");
			outputText("\n\nLoppe lifts an eyebrow and smiles at you.  \"<i>Are you sure, sugar?  I tend to get carried away, so it can be pretty intense.</i>\"");
			//(Min Lust >= 50)
			if (player.minLust() >= 50) {
				outputText("\n\nYou grin and warn her that your appetite is a lot higher than normal; you are usually so aroused that you have no doubt you can go at it a lot more than the average person.");
				outputText("\n\nLoppe shoots you a sultry look.  \"<i>Well, sugar, I guess I'll just have to take care of this 'endless lust' of yours, huh?</i>\" She tightens her hold on your hand and starts walking faster, eager to get you to her place.");
			}
			//(else High Libido)
			else if (player.lib >= 70) {
				outputText("\n\nYou smirk back and announce that you like it intense.  Perhaps she's the one who should watch out?");
				outputText("\n\n\"<i>Oh, I like the sound of that... let's go, sugar!</i>\"  Loppe tightens her hold on your hand and starts walking faster, eager to get you to her place.");
			}
			//(else High Toughness and has beaten mino mob)
			else if (player.tou >= 70) {
				outputText("\n\nYou tell her that you're confident in your stamina.  Truth be told, you can withstand a fight with a whole mob of minotaurs and still have enough energy left to fight off demons.");
				outputText("\n\nLoppe smirks.  \"<i>So if I manage to tire you out, that would make me stronger than a mob of minotaurs, right?  Okay!  Challenge accepted!</i>\"  She tightens her hold on your hand and starts walking faster, eager to get you to her place.");
			}
			//(else)
			else {
				outputText("\n\nYou tell her that, even despite that, you still want this.");
				//[(lib>40)]
				if (player.lib >= 40) outputText(".. it almost sounds exciting.");
			}
			outputText("\n\n\"<i>It's your call, sugar, but once I get going I don't think I'll be able to stop myself, so I hope you're willing to forgive me for anything that I might do.</i>\"");

			outputText("\n\nOminous... or perhaps intriguing, depending on your point of view.\n\n");
			//end of non-bakery section, continue with remainder
		}
		//bakery date output starts from here!
		outputText("It's not very difficult to reach Loppe's place; it happens to be located only a few blocks away from the gym, behind a small shop with the sign \"<i>Kemono's Oriental Clinic</i>\".");

		outputText("\n\nOnce you get to the front door you're surprised to see that Loppe's house is most unusual.  The structure is the same as all other houses in Tel'Adre but the decoration is what sets it apart, it is covered in symbols that just don't any make sense to you; noticing your confusion, Loppe explains, \"<i>Mom drew these, it's supposed to be something to help ward off bad influences.  It's a cultural thing.</i>\" Loppe grins.");
		//[(corr < 40)]
		if (player.cor < 40) outputText("  You tell her they're quite nice... though privately you're curious what the interior looks like.");
		else outputText("  They don't seem to work very well - after all, <i>you're</i> here.");

		outputText("\n\nLoppe smiles and produces a key.  With a click the door unlocks and the two of you step inside.  If the exterior was unusual, the interior is even moreso; the first thing that catches your eye is the door; it's a sliding door, covered with some sort of film or paper that effectively prevents anyone from seeing beyond it.  Why they would need something like that, considering whoever got in had to get past the front door, is anyone's guess...");

		outputText("\n\n\"<i>Mom!  I'm home!</i>\" Loppe yells, and waits for a response.  When none comes, she grins at you.  \"<i>Looks like we're in the clear, c'mon!</i>\"  She slides the door open and leads you inside.  You note a distinct lack of chairs and the tables seem a bit too low; after some thought, you guess that you're supposed to lower yourself to the ground in order to accommodate the furniture.  You also note that most of the floor seems to be covered in a soft carpet, which feels great under your [feet].  You admire it as Loppe takes you to the back of the house, to a door marked with the image of a cute little bunny chewing on a carrot.");

		outputText("\n\n\"<i>Here we are, sugar.  My room.</i>\"  Loppe makes a show of opening the door and letting you peer inside.");
		outputText("\n\nWanting to be polite, and curious, you do what she's clearly inviting you to do and take a look.  The interior is quite homey; a sizable but modest bed is covered with soft cushions and blankets, and the remaining space is filled with a vanity table, a large closet, and some small shelves.  You see a number of books, but the topmost shelf gives pride of place to three well-loved stuffed dolls.  Loppe notices where you're looking and gives you a sheepish grin.  \"<i>Ah... a girl sometimes likes to keep her old comforters,</i>\" she offers defensively, clearly embarrassed that you've seen them.");

		outputText("\n\nYou politely slip inside, waiting for her to join you.  Loppe closes the door behind her, and with a practiced flourish removes her clothes, shortly followed by her underwear. You're surprised to see the laquine's forwardness, but you suppose this is what you came here for after all, so you smile and strip off your [armor].");

		outputText("\n\nLoppe admires you as you undress, giving you ample opportunity to admire her back.  As you examine each other, your eyes set on her hardening horse-cock.  It swells to an impressive size and points the same direction as her eyes - it certainly didn't look this big when it was tucked inside her tight shorts.");

		outputText("\n\n\"<i>So, sugar,</i>\" she says, interrupting your reverie, \"<i>we can do this however you like.  I don't really mind pitching or catching, especially with a cutie like you.</i>\"  Loppe winks at you, posing for your benefit.\n\n");

		//[(any cock fits area 80)
		if (player.hasCock()) {
			if (player.smallestCockArea() <= loppeCapacity()) outputText("Pulling her onto your dick would result in some cowgirl fun, though you'd have to deal with her cock pointed right at you when she came.  ");
			else outputText("As good as it would feel to shove your [cock smallest] into her cunt, the nervous looks she's giving it tell you what her response would probably be.  ");
		}
		//[(any cock)
		if (player.hasCock()) outputText("You could just whip it out and ask what she thinks of it, compared to hers - it might lead to some cross words and crossed swords, though.  ");
		if (player.hasVagina()) outputText("You could take her monster length vaginally, but if her libido is what she claims, you'll probably wind up quite stretched.  ");
		//[(boobs >= boobjob req)
		if (player.biggestTitSize() >= 5) outputText("Her hardening horsecock looks like it would fit between your [chest], an act likely to net you a messy demonstration of her enthusiasm.  ");
		outputText("There's always the option to receive her anally, though with her vaunted libido, you'd probably end up so flooded with her cum that it would wash from your mouth.  Or you could be a prick-tease and leave.");
		//Display sex options
		//[Cowgirl][Frot][TakeVaginal][Boobjob][TakeAnal][Bail]
	}
	//Repeat Intro (edited)
	else {
		outputText("Loppe's other 'workout' sounds pretty good right now.");
		outputText("\n\nThe dancer grins and gives you a little peck on the lips.  \"<i>Can't get enough laquine loving, can you?</i>\"");

		//(High Min Lust)
		if (player.minLust() >= 50) {
			outputText("\n\nWell, after all, how many people can actually sate your hunger for sex?");
			outputText("\n\nLoppe grins at you.  \"<i>I just knew you'd come back for more.</i>\"  She takes your hand in hers and fairly drags you along, already heading for the door.");
		}
		//(High Libido)
		else if (player.lib >= 70) {
			outputText("\n\nYou thought you held out pretty well last time.");
			outputText("\n\nLoppe smiles teasingly at you.  \"<i>Really?  Care to remind me who was snoring on my bed, too spent to stay awake?</i>\"");
			outputText("\n\nWho, indeed?  Didn't Loppe herself fall asleep at the same time?  Your lover giggles.  \"<i>I was just being nice, sugar; I thought you'd like to sleep with someone besides you.  But if you're so confident in your abilities, why don't you follow me and show me just what you're made of?</i>\"");
		}
		//(High Toughness)
		else if (player.tou >= 70) {
			outputText("\n\nThe test of your stamina was nice; now you want a rematch.");
			outputText("\n\nLoppe grins at you.  \"<i>I'm always up for a rematch... literally.</i>\"  The statement draws your eyes to the bulge in her shorts, and you note that it is indeed bigger than usual.  Loppe doesn't bother saying anything else; she takes your hand and begins leading you back to her home.");
		}
		else {
			outputText("\n\nShe slips her hand in yours, then changes her mind and pulls you close for a hug.  \"<i>Come on, I'm going to take you home and treat you to a nice time.</i>\"");
		}
		outputText("\n\nYou quickly arrive at the front door, and once Loppe checks if the coast is clear, she leads the way into her room.  The girl is quickly nude, discarding her garments carelessly about her girlish room and accidentally hitting you in the face with her bra.  \"<i>Oops, sorry,</i>\" she giggles.");

		outputText("\n\nYou wonder if that was deliberate or not... still, you follow suit, stripping off your [armor] and presenting yourself to the sexy herm smiling at you.");

		outputText("\n\n\"<i>How will you be having me, sugar?</i>\" she asks, hopefully.\n\n");

		//[(any cock fits area 80)
		if (player.hasCock()) {
			if (player.smallestCockArea() <= loppeCapacity()) outputText("Pulling her onto your dick would result in some cowgirl fun, though you'd have to deal with her cock pointed right at you when she came.  ");
			else outputText("As good as it would feel to shove your [cock smallest] into her cunt, the nervous looks she's giving it tell you what her response would probably be.  ");
		}
		//[(any cock)
		if (player.hasCock()) outputText("You could just whip it out and ask what she thinks of it, compared to hers - it might lead to some cross words and crossed swords, though.  ");
		if (player.hasVagina()) outputText("You could take her monster length vaginally, but if her libido is what she claims, you'll probably wind up quite stretched.  ");
		//[(boobs >= boobjob req)
		if (player.biggestTitSize() >= 5) outputText("Her hardening horsecock looks like it would fit between your [chest], an act likely to net you a messy demonstration of her enthusiasm.  ");
		outputText("There's always the option to receive her anally, though with her vaunted libido, you'd probably end up so flooded with her cum that it would wash from your mouth.  Or you could be a prick-tease and leave.");
		//[(loppesexed)
		outputText("  Just jerking that cock and squeezing it so hard her balls swell up when she comes, though, that might be fun.  It'd be interesting to see how big they can get.");

		//Display sex options
		//[Cowgirl][CockWorship][TakeVaginal][Boobjob][TakeAnal][Squeezejob][Bail]
	}
	if (player.lust < 33) {
		player.lust = 33;
		dynStats("lus", .2);
	}
	//Display sex options
	//[Cowgirl][Frot][TakeVaginal][Boobjob][TakeAnal][Bail]
	menu();
	//if (flags[kFLAGS.LOPPE_TIMES_SEXED] > 0)
	if (player.hasCock() && player.lust >= 33) {
		if (player.cockThatFits(loppeCapacity()) >= 0)
			addButton(0,"Cow-girl",loppeRidesCocks);
	}
	if (player.hasCock() && player.lust >= 33)
		addButton(1,"Get BJ",loppeWorshipsDicks);
	if (player.hasVagina() && player.lust >= 33)
		addButton(2,"TakeVaginal",getFuckedInYerTwatYaCunt);
	if (player.biggestTitSize() >= 4) addButton(3,"Boob-job",boobjobLoppe);
	if (flags[kFLAGS.LOPPE_TIMES_SEXED] > 0) addButton(4,"SqueezeJob",loppeSqueezedickWhateverThatIs);
	if (player.isTaur() && player.lust >= 33) addButton(5,"TakeAnal",getAssFuckedByLoppeAsACentaur);
	else if (player.lust >= 33) addButton(5,"TakeAnal",getButtFuckedNonHoarseByLoppe);
	addButton(14,"Leave",beATeaseAndLeaveLoppeAfterSexInvite);
}

//Male
//Cowgirl Cock Ride: (edited)
//Loppe's vag capacity = 80-100
private function loppeRidesCocks():void {
	clearOutput();
	outputText(images.showImage("loppe-rides-your-cocks"));
	outputText("Looking over the hermaphroditic, horse-cocked bunny-girl, you contemplate your options.  You settle yourself ");
	//[(not centaur)]
	if (!player.isTaur()) outputText("on her bed, making yourself comfortable, and start suggestively stroking yourself");
	//(centaur)
	else outputText("cumbersomely on the floor, rolling over and spreading your hindlegs to expose yourself");
	outputText(".  Quietly, you ask Loppe how she would feel about indulging her feminine half.");

	outputText("\n\n\"<i>I would love to, sugar!</i>\"  Loppe gazes at your " + player.multiCockDescriptLight() + ".");
	//[(2 fit cocks)
	var x:int = player.cockThatFits(loppeCapacity());
	var y:int = player.cockThatFits2(loppeCapacity());

	if (y >= 0 && player.cockTotal() == 2) outputText("  \"<i>In fact... I could just eat both of those up.</i>\"");
	//(3+ fit cocks)
	else if (y >= 0 && player.cockTotal() == 3) outputText("  \"<i>But I'm afraid I'll only be able to handle two of them.</i>\"");
	if (player.cockTotal() > 1 && y >= 0) outputText("\n\nBetter than the usual reaction... at least she's willing to give more than one some love.");

	outputText("\n\nLoppe pushes you on your back and gently takes hold of ");
	if (y >= 0) outputText("two of ");
	outputText("your cock");
	if (y >= 0) outputText("s");
	outputText(", rubbing gently.  \"<i>Just sit back and leave everything in my capable hands, sugar.</i>\"");

	outputText("\n\nYour lover starts slowly, stroking you and milking small beads of pre, which she promptly smears all over, getting your dick");
	if (y >= 0) outputText("s");
	outputText(" nice and slick.  You gasp in pleasure and surprise as you feel Loppe's erect cock sidle up to yours, helping lube you with its leaking pre. Raising up your hips, you clumsily try to ");
	if (y < 0) outputText("slide your shaft against her");
	else outputText("pinion her shaft between your");
	outputText(" own, shivering from the sensation of your sensitive " + player.skin() + " against her proud horseflesh, already drooling even though you can plainly feel that it's only half-erect.");
	if (player.balls > 0) outputText("  Your [balls] gently brush and rub against her own swollen cum-factories, and you can't wait to empty your overfilled sac into her waiting womb.");

	outputText("\n\n\"<i>Okay, that's enough foreplay!</i>\" Loppe announces suddenly, eyeing your " + player.cockDescript(x) + " with a hunger that you never expected to see on her face.  Loppe quickly straddles you, aligning it with her pussy");
	if (y >= 0) outputText("; its neighbor is aimed for her tight rosebud");
	outputText(".  \"<i>Itadakimasu!</i>\" Loppe says, licking her lips as she finally slides you home.");

	outputText("\n\nYou moan softly; she's so warm inside, burning with lust and dripping with arousal, her innards stretching so perfectly to fit around every contour and groove of your shaft");
	if (player.cockTotal() > 1) outputText("s");
	outputText(", yet squeezing you as tightly as a velvety vise.  In fact, she's gripping you so hard that you can't seem to push yourself any further into her depths; she's squeezing you much too tightly to move in or out, an outright amazing feat, if Loppe gets half as much action as she claims to.");

	outputText("\n\nUnfortunately for you, Loppe seems utterly consumed in her lust.  She pants and drools as she begins to brutally gyrate her hips atop you, bouncing on your prick");
	if (y >= 0) outputText("s");
	outputText(" with happy squeals of pleasure and happiness, softly accompanied by the wet sounds of your coupling.  You gasp and cry, savoring every motion as she squeezes and wriggles, her inner walls rippling so deliciously around your cock");
	if (y >= 0) outputText("s");
	outputText(", stroking them in the most delicious way.  You thrust your hips, trying to slip deeper inside her, but still she's holding you at bay.");

	outputText("\n\nLoppe doesn't bother answering your plea, instead doubling over and delivering a kiss on your lips to try and silence you.  Her hips grind against your own, forcing you to fully hilt yourself within her despite the seal formed by her constricting cunt");
	if (y >= 0) outputText(" and watertight ass");
	outputText(".  The sensation borders on the thin line between pleasure and pain, and you can't help but moan into Loppe's kiss; you wrap your ");
	if (player.isDrider()) outputText("spindly legs");
	else if (player.isTaur()) outputText("forelegs");
	else outputText("arms");
	outputText(" around the bunny-girl's ");
	if (flags[kFLAGS.LOPPE_FURRY] == 0) outputText("silky-smooth");
	else outputText("softly furred");
	outputText(" back and hold her tight against you, her long horse-cock sandwiched between your bellies, smearing both of you with drooling precum, rivers of the stuff flowing out steadily with every thrust and grind the two of you make.");

	outputText("\n\n\"<i>Brace yourself, sugar!  Here comes your cream!</i>\" Loppe yells in rapture, arching her back so powerfully it's like she's trying to pull herself free of your embrace.");

	outputText("\n\n");
	//[(not horse)]
	if (!player.isTaur()) {
		outputText("<b>You realize that if you keep holding onto Loppe, you're going to end up with a face covered in herm-cum - if you act quickly, though, you can avoid the impromptu facial.  You could even turn her hose of a cock back on her.</b>");
		//[NoFace] [Facial] [HoseHer]
		menu();
		addButton(0,"NoFace",loppeRidesYouNoFaceJizz);
		addButton(1,"Facial",loppeRidesYouSpunksInYourEye);
		addButton(2,"HoseHer",loppeRidesYouHoseHer);
	}
	else {
		menu();
		addButton(0,"Next",loppeRidesYouNoFaceJizz);
	}
	dynStats("lus=", player.maxLust(), "resisted", false);
}

//{If NoFace:
private function loppeRidesYouNoFaceJizz():void {
	clearOutput();
	var y:int = player.cockThatFits2(loppeCapacity());

	outputText("You let go of the horse-dicked rabbit and she gratefully swivels herself fully upright, cock jutting out over your belly - instinctively, your ");
	if (player.isTaur()) outputText("foreleg tucks under her cock, angling it away from your body.");
	else outputText("hand lunges forward and places itself underneath, fingers curling around as you push it further up, aiming it over your shoulder.  You can feel it throbbing like mad against your fingers, can feel the impressive bulge of semen as it distends her urethra and surges up towards her flared tip.");
	outputText("  With an ululation of ecstasy, she literally explodes into orgasm, a great gout of cum visibly flying through the air with such force you can hear it splattering against the wall.  This is followed by a second eruption, then a third, a fourth... they just keep coming!  All the while, she bounces, moans, and writhes, her rapacious pussy gripping and squeezing");
	if (y >= 0) outputText(" while her ass suckles on your second cock with just as much eagerness");
	outputText(".");

	outputText("\n\nIt's too much to resist and, fighting to keep yourself from accidentally leaning your head into the line of fire, you cry out as you give yourself over to orgasm.");
	loppeRidesPCCockFinal();
}

//{If Facial:}
private function loppeRidesYouSpunksInYourEye():void {
	clearOutput();
	var x:int = player.cockThatFits(loppeCapacity());
	var y:int = player.cockThatFits2(loppeCapacity());

	outputText("You keep your ");
	if (player.isDrider()) outputText("legs");
	else outputText("arms");
	outputText(" wrapped around your lover, welcoming what's approaching as her horse-prick throbs and her flared tip inflates.  With a rapturous howl the laquine's cumslit opens like a floodgate, spurting jet after jet of cum onto your [chest], [face] and even the wall behind you; her own pillowy breasts and face are splashed with the force of her orgasm.  Her tight pussy contracts, milking your " + player.cockDescript(x) + " for all its worth");
	if (y >= 0) outputText(", while her anal ring constricts your " + player.cockDescript(y) + " tightly, intent on holding you in place");
	outputText(".");

	outputText("\n\nThe smell of her juices fills the air and floods your nostrils, the copious cum painting itself over both your bodies in great smears that make things deliciously slick and slippery.  The combination of this stimulus with the expert milking of her wonderfully tight nethers and your own hyper-aroused state renders you unable to hold out any more.  With a great shout of your own, you unleash your orgasm into her waiting depths.");
	player.slimeFeed();
	loppeRidesPCCockFinal();
}

//{If HoseHer:
private function loppeRidesYouHoseHer():void {
	clearOutput();

	outputText("You let go of Loppe, and she gratefully swivels herself fully upright, cock jutting out over your belly - your hand lunges forward and places itself palm upright underneath the shaft, fingers curling around as you push it further up and up until it's pointing, as best you can make it, at her face!  You can feel it throbbing like mad against your fingers, can feel the impressive bulge of semen as it distends her urethra and surges up towards her flared tip.  With an ululation of ecstasy, she literally explodes into orgasm, cum geysering from her cock and squarely into her face, causing her to choke and splutter at the surprise facial, the pearly spooge splattering down her throat and onto her breasts.  With a laugh she shakes her head, closing her eyes and opening her mouth; even as she continues to bounce and buck and grind against you, her cock keeps spurting cum, and she clumsily tries to catch it, eagerly swallowing down mouthful after mouthful.  She's actually quite good at it, but despite her best efforts, her hair, ears, face and breasts end up completely plastered in cum... not that this stops her from milking you with her lower hole");
	if (player.cockTotal() > 1) outputText("s");
	outputText(" until you can't help it and cum yourself.");
	loppeRidesPCCockFinal();
}


private function loppeRidesPCCockFinal():void {
	var x:int = player.cockThatFits(loppeCapacity());
	var y:int = player.cockThatFits2(loppeCapacity());

	outputText(images.showImage("loppe-rides-your-cock"));
	outputText("\n\nYour " + player.cockDescript(x) + " gushes fluids into her hungry womb");
	if (y >= 0 || player.hasVagina()) {
		outputText(", while ");
		if (y>= 0) outputText("your second " + player.cockDescript(y) + " just as easily pumps her perverted ass full of baby juice");
		if (y>= 0 && player.hasVagina()) outputText(" and ");
		if (player.hasVagina()) {
			outputText("your [vagina] ");
			if (player.wetness() < 3) outputText("drizzles");
			else if (player.wetness() < 5) outputText("spatters");
			else outputText("gushes");
			outputText(" femcum onto the bed below you, forgotten during the act but not unsympathetic to her ministrations");
		}
	}
	outputText(".  You cry out as you cum long and hard, arching your back off of the bed in your pleasure before finishing and collapsing, gasping for breath as, above you, the laquine comes to her own climactic end.");

	outputText("\n\nLoppe slumps atop you, rubbing your bodies together as her hips slow down.  Spent from your recent orgasm, you resolve to just wrap your ");
	if (player.isDrider() || player.isTaur()) outputText("forelegs");
	else outputText("arms");
	outputText(" around her, pulling her into a post-coital cuddle.  Her wet cock quietly slaps against your belly as she embraces you back, clearly savoring the closeness the same way you are.  However, moments later, you feel Loppe's hips start to twitch, slowly building into more lustful thrustings, seconds before Loppe pushes herself back into a deliberately upright position, her pace building steadily.  With a lusty smile and a mischievous twinkle in her eyes, Loppe looks you straight in the eye as she proclaims, \"<i>It's time for round two, [name]!</i>\"");

	//(High libido or High Min lust)
	if (player.lib >= 70 || player.minLust() >= 50) {
		outputText("\n\nYou remember what she told you about her libido and shrug; what's another round, after all?  You're happy to finally have someone capable of sating your endless hunger for sex.  [EachCock] begins to harden again, and the girl on top of you gives you a knowing smile.");
	}
	//(Medium libido or Medium Min lust)
	else if (player.lib >= 50 || player.minLust() >= 35) {
		outputText("\n\nYou remember what she told you about her libido, but another round?  So soon?  Sighing, you tell Loppe that you just can't handle so much sex in such a short notice; she'd have to at least give you a few moments to recover.");
	}
	else {
		outputText("\n\nWhat!?  Round two?  Now?  You sigh in exasperation... she did warn you about her libido, but this is ridiculous!  You just can't work yourself into another erection... especially after having just climaxed...");
	}

	outputText("\n\nLoppe quietly disentangles herself from your half-staff ");
	outputText(player.multiCockDescriptLight() + " and slides down your body, pressing her soft, cum-slickened breasts against you.  You moan as the smooth curves of her chest press against [eachCock]; the cum-slick ");
	if (flags[kFLAGS.LOPPE_FURRY] == 0) outputText("skin");
	else outputText("fur");
	outputText(" give you the impression of being wrapped in the moist folds of a woman's sex.  As Loppe slides further down you feel her teasingly licking at the tip");
	if (y >= 0) outputText("s");
	outputText(" of your " + player.multiCockDescriptLight() + ".");

	outputText("\n\nThe skillful dance of her warm, wet tongue on the sensitive skin of your post-orgasmic member");
	if (y >= 0) outputText("s");
	outputText(" pull");
	if (y < 0) outputText("s");
	outputText(" an involuntary shudder from you; the erotic stimulation sends blood pulsing back into your veins, and your shaft");
	if (y >= 0) outputText("s rise");
	else outputText(" rises");
	outputText(" to full mast again, so swiftly ");
	if (y < 0) outputText("it almost smacks");
	else outputText("they almost smack");
	outputText(" the laquine on her nose, leaving you ready to be mounted by her once again.");

	outputText("\n\n\"<i>I can't remember the last time I've had so much fun with anyone else,</i>\" Loppe whispers, shivering.  \"<i>Now, sugar... it's time for another session, and you'd best be ready for overtime");
	if (player.minLust() <= 30 && player.lib <= 50) outputText("; if I have to stop to tend to you after every coupling, I'll never get these empty");
	outputText(".</i>\"  She points with a smirk to her swollen balls.  Er... didn't she just blow her load? Her balls look at least as full as, if not fuller than, when you started, and they nearly slosh with eagerness to be rid of their cargo!");

	outputText("\n\nLoppe straddles you and with a mischievous smirk, she says, \"<i>I'm not stopping until I'm completely satisfied, sugar.  So sit back and relax; this could take some time.</i>\"  She doesn't bother waiting for an answer before she sinks, impaling herself upon your shaft");
	if (y >= 0) outputText("s");
	outputText(" once more.  You moan as once again you follow the lusty dickgirl into the throes of pleasure...");

	outputText("\n\n<b>One hour and several orgasms later...</b>");

	outputText("\n\n\"<i>Thanks, sugar.  You're the best!  I feel completely satisfied!</i>\" Loppe says, happily smiling and hugging you tightly.  As she snuggles up to you, you can feel the distinct bump of her gravid-looking belly rubbing against your " + player.skin() + "; the cum-filled flesh deforms as the pressure pushes some of the skin-stretching load out of her nethers and further smears the proof of your pleasure on your entwined lower halves, but even so she still looks ready to pop with three or four kids.  You consider answering her, but find that you lack the will to do so... in fact, you lack the energy to do anything at all, Loppe having fucked you until you were shooting blanks");
	//[(if high cum amount)]
	if (player.cumQ() >= 500) outputText(" despite your usually messy orgasms");
	outputText(".");

	outputText("\n\nOnce Loppe has made herself comfortable, she gives you a little peck on the cheek, then slowly extends her tongue to lick an errant droplet of cum from your nose.  She sets her head on your shoulder and begins snoring lightly; sleep has apparently claimed the satisfied herm.  It's not long before Loppe's soft snoring and warm embrace lull you into a sleepy afterglow as well.");

	outputText("\n\n<b>Two hours later...</b>");

	outputText("\n\nYou wake with a start, feeling a momentary surge of panic; how long were you out, and where are you?  Still in Loppe's room... but where's all the mess?  The dripping laquine jizz, the puddles of mixed fluids splattered all over the floor, the sopping-wet, sex-stinking bedclothes you were wrapped in?");

	outputText("\n\n\"<i>Morning!</i>\" Loppe says.  You turn to look at her and notice that she's dressed in what looks like a very comfortable bathrobe; in her hands she holds a tray containing a loaf of bread and a cup of what you presume to be some sort of herbal tea.  Looking further down you notice that her gigantic belly has been reduced to normal proportions, giving the dancing bunny-girl the slim, slender silhouette she had when you first met her.  You open your mouth to ask her a few questions, but your rumbling stomach interrupts you before you can say anything.");

	outputText("\n\nLoppe giggles, sauntering over to you and helping you up, before offering you the tray with a small peck on the cheek.  \"<i>Here you go; I made these especially for you.  Eat up!</i>\"  Ravenously, you dig into the humble fare, finding it takes the edge off of your fatigue... though your muscles still feel drained and weak from the amount of 'exercise' you gave them.");

	//(First Time)
	if (flags[kFLAGS.LOPPE_TIMES_SEXED] == 0) {
		outputText("\n\nLoppe zeroes in on a trembling hand and takes the tray from you as you finish, then grins nervously.  \"<i>Sorry about that, sugar.  I guess I might have overdone it, but it was so exciting being with someone new.  If it was too much, I'll be happy to make it up to you - maybe a date, or... maybe another, much slower session.</i>\"  She looks slyly at you.  \"<i>Whichever you're up for.</i>\"");
		outputText("\n\nBefore you have a chance to answer, she leans in and captures your lips in a kiss.");
	}
	else {
		outputText("\n\nLoppe takes the tray from your hands and grins at you. \"<i>Sorry about that.  I still can't quite control myself, especially not when I have a cutie like you as my lover.  But... thanks for coming back again.  You're sweet, sugar!</i>\"");
	}
	outputText("\n\nReleasing you, Loppe points to a nearby chair.  \"<i>I've laid out your [armor] over there, but feel free to stay as long as you want to.</i>\"  You thank her for the kind offer, but the last thing you need are imps or goblins getting into your supplies and making off with your things.  You redress yourself, negligently allowing Loppe glimpses of your naked body as you do so");
	//[(Exhibitionist)
	if (flags[kFLAGS.PC_FETISH] > 0) outputText("; it gives you something of a thrill, though nowhere near as much as taking them off for her in the first place did");
	outputText(".  Finished, you depart.");
	player.orgasm();
	dynStats("tou", .5, "lib", .5, "sen", -4);
	flags[kFLAGS.LOPPE_TIMES_SEXED]++;
	//3 hours pass.
	doNext(camp.returnToCampUseFourHours);
}

//Cock Worship: (edited)
//Obviously, PC needs a cock.
//For tentacle variant, you need a tentacle cock 14</i>\" long or more.
//Not available to centaurs.
private function loppeWorshipsDicks():void {
	clearOutput();
	outputText(images.showImage("loppe-worships-your-cock"));
	outputText("As your eyes sweep over the naked half-breed's form, they focus on her equine masculinity, already standing proud and eager at the prospect of sex.  Distinctly aware of your own male appendage");
	if (player.cockTotal() > 1) outputText("s");
	outputText(", you conversationally ask Loppe what she thinks of your [cock biggest], an idea starting to form in your mind.");

	//(if cock area <= 17.5)
	if (player.biggestCockArea() <= 17.5) {
		outputText("\n\n\"<i>What do I think about your dick?  Well... it's much smaller than my own, but it's cute.  And to be honest I wouldn't mind having it fill me up, even if you won't be able to go that deep.</i>\"");
		outputText("\n\nLoppe laughs.  \"<i>Or, were you thinking I'd care about who has the biggest dick between us?  As long as you can hump me till I blow a load of my own, I'm fine.  And, to be entirely honest, lately I find myself getting off on anything... so, as long as you don't mind a little tussle in the bed, I certainly don't mind getting on with a cutie like you.</i>\"  She winks and blows you a kiss.");
	}
	else if (player.biggestCockArea() <= 35) {
		outputText("\n\n\"<i>What do I think about your dick?  Well, it's about the same size as mine, which is good, I think... and it looks hard too.  I can see the veins bulge each time it throbs.  Looks tasty... and I wouldn't mind having something like that inside me.</i>\"  She nods appreciatively.");
	}
	else { //cock area > 35
		outputText("\n\n\"<i>What do I think about your dick?  Well... it's huge!  So big, hard and juicy - that's a cock I can really get my hands around.  To be honest with you, I'm having a hard time not taking it for a spin.  Such a wonderful looking member... ");
		//[(if cock area > Loppe's capacity)
		if (player.biggestCockArea() > loppeCapacity()) outputText("even if it does look too big to fit.");
		else outputText("or maybe I should get a taste first?");
		outputText("</i>\"  She licks her lips.");
	}
	outputText("\n\nDrawing confidence from her words, you look directly at your lover.  \"<i>Show me exactly how much you like it, then.</i>\"");

	outputText("\n\n\"<i>Hmm, are you implying what I think you're implying, sugar?  To be honest, I'd rather be inside someone or have someone inside me... maybe even both!</i>\"  Loppe laughs.  \"<i>But since it's you who's asking...  I can't deny a request from a sweet thing like you now, can I?</i>\"  She motions towards her bed.");

	outputText("\n\nYou seat yourself, giving her perfect access to your stiffening manhood and making it obvious you're ready to begin.");

	outputText("\n\nLoppe kneels before you, leaning in to inhale your musk.  \"<i>Mmm... strong and sexy.  Just the way I like it.</i>\"  She licks her lips.  Gently, she closes a hand around your shaft, pumping and pressing on you, milking a few dollops of pre.  You murmur appreciatively, shivering at the skilled pressure she applies to your sensitive manhood, but you wait patiently for her to proceed.");

	outputText("\n\nLoppe sucks the pre off your [cockHead biggest], making a show of swallowing slowly.  \"<i>I might pop just from blowing you, sugar,</i>\" she chuckles.  \"<i>That's how tasty you are... gimme more of that juicy cock.</i>\"  She leans in and begins licking you, from base to tip and back down, lathering the entirety of your [cock] in her warm saliva.  She only stops to deliver appreciative kisses to the underside of your member, moaning every time she does so... nuzzling into your crotch, seemingly unconcerned with steadily leaking pre that's sticking to her hair or her rabbit-like ears.");

	outputText("\n\nYou grab hold of the bed for support, moaning audibly at her skilled lips and tongue as they caress your throbbing, sensitive prick.  A part of you wants to just thrust your cock into her lips already, but you force yourself to be patient; there must be more to come, and who's to say it won't be even better?");

	outputText("\n\nThe laquine looks seductively up to you, half-smiling as she licks her way up your shaft, catching a stray bead of pre that runs down your length.  Once she arrives at your [cockHead biggest], instead of working her way back to the base, she closes her lips and kisses your cumslit with a feather-like touch that sends electric jolts of pleasure running through your body.  Without warning she takes your tip into her mouth, caressing your glans with her tongue as she fondles your dick passionately, moaning and sending vibrations running along your length.  Her hands busy themselves with your shaft, never stopping their wonderful massage.");

	outputText("\n\nLoppe's smile is like a promise of what's to come, and she does not disappoint.  As if her fingers were not enough, her tongue also contributes to your dick-massage, pushing all of your right buttons... it's a wonder you haven't lost it already.  The half-breed herm gives your [cockHead biggest] a long lick as she pulls away shortly.  \"<i>Come on, sugar.  Let me taste you.</i>\"  She smiles as she leans over your shaft once more, blowing lightly on your crown, before taking it inside her mouth and sucking sharply.");

	outputText("\n\nWith a moan, hollow and deep with longing, unable to even think of warning Loppe that it's coming, you orgasm right into the laquine's mouth.  Your ejaculate feels like molten magma as it boils up from inside of you, consuming your cock with the most delicious warmth of pure bliss as you splurt gush after gush into your partner.  So intense is the feeling - and so eagerly does she suck, lick, and swallow, caressing your cock even as she gulps down each mouthful - that even when the haze clears and you stop cumming, your cock is still rock-hard.");

	outputText("\n\nLoppe unlatches from you with a <b>'pop'</b>.  \"<i>Thanks for the meal, sugar,</i>\" she grins.  \"<i>Now... I can see you're still hard, so how about some more fun?  Hmm?  I'll be wanting to have some of my own, of course.</i>\"  She unbends, to rest your wet shaft in her cleavage.");

	outputText("\n\nUsing her hands and arms, Loppe grinds her soft boobs against your [cock biggest], milking a few more dollops of cum from you, slickening her breasts, as well as your saliva-coated prick.  You shudder and instinctively thrust your cock into her soft ");
	if (flags[kFLAGS.LOPPE_FURRY] > 0) outputText("fluffy ");
	outputText("cleavage; her ");
	if (flags[kFLAGS.LOPPE_FURRY] == 0) outputText("skin");
	else outputText("fur");
	outputText(" against your [cock biggest] sends tingles of pleasure rippling through your loins.  The half-breed doesn't stop her ministrations, barely noticing your reaction.  All she does is giggle as you continue pumping more of your slick pre all over her breasts.  Murmuring and moaning appreciatively, you continue to thrust and grind, eagerly spilling pre-cum all over your herm lover's cleavage and midriff, though you can't prevent one sudden spurt from landing right on her face");
	//[(lib > 40)
	if (player.lib >= 40) outputText(" - nor would you want to; she looks just right covered in your fluids");
	outputText(".");

	outputText("\n\n\"<i>All ready!</i>\"  Loppe declares, letting go of your slick shaft and delivering a parting peck.  You wonder what exactly you're ready for, other than the obvious... it doesn't stop you from continuing to thrust in anticipation of your second release.");

	outputText("\n\nLoppe pushes you back onto the bed and straddles you, stroking her equine-prick in order to milk more pre and spread it over her shaft.  \"<i>It's time to give this wonderful [cock biggest] of yours a ride of its own,</i>\" she hums.  She aligns her tool with your own, rubbing your slick lengths together as she begins humping.  You grind and slide your wet, pre-smeared shaft against hers, groaning and hissing at the sparks of pleasure the slippery friction sends surging into your brain.");

	outputText("\n\nLoppe pants over you, humping your shaft as she looks deeply into your eyes with a gaze fogged by pleasure.  You can feel the warmth emanating from her equine endowment as she leaks copious amounts of pre over your own shaft.  With a gasp of surprise and without slowing her rhythm, Loppe cums.  Rope after sticky rope of cum splashes across your belly and your [chest].  You squeeze her ass, feeling her tail swishing across your fingers as you grind and rut against her, cock to cock");
	if (player.balls > 0) outputText(" and balls to balls");
	outputText(", the delicious friction pushing you over the edge.");

	outputText("\n\n\"<i>Can you see... how much I love... your cock, now?</i>\"  Loppe asks, panting.  Panting right back, you answer her with your eyes as your cock proclaims its love for her, dropping the last dike of resistance and yielding to your overreaching orgasm.  The pleasure of cumming fills your addled brain again as you spray your cock-juice all over your lover's belly, breasts, face and dick, soaking her with every last drop you can dredge up.  Your orgasm triggers another of Loppe's own, and with a groan, she gives you a coating of her own issue.  After spewing the last of her load onto you, she collapses and gives you a gooey hug, followed by a slimy kiss on your cheek.");

	outputText("\n\n\"<i>You're the best, sugar.</i>\"  You simply nod, too dazed to really listen.  She humps you a couple more times, noting your softening member.  Giggling, she says,  \"<i>It's too early for you to go soft on me, [name].  I still have a lot of appreciation to show you... and I'm sure you still want to show your appreciation for me too.  So get ready for round two!</i>\"  She leers at you, licking her lips in blatant anticipation.");

	//Low Libido:
	if (player.lib < 33 && player.minLust() < 30) outputText("\n\nYou groan from the depths of your throat; Loppe and her libido...");

	//{Moderate Libido:
	else if (player.lib < 66 && player.minLust() < 50) outputText("\n\nWith a wince of equal parts anticipated pleasure and pain, you ready yourself for a long session.");
	//High Libido:
	else outputText("\n\nYour fatigue ebbs away, chased off by your eagerness for more of the incredible sex you just had.");

	outputText("\n\n<b>One hour and many orgasms later...</b>");
	outputText("\n\nLoppe screams as she cums one last time, sprinkling you in white again.  Finally spent, she collapses atop you.  \"<i>I guess that was enough appreciation, right sugar?  I mean... I love you and your cock so much that I bet I could draw a couple more loads of appreciation if you really wanted,</i>\" she pants, smiling at you.  You just shake your head, barely able to see Loppe's face - a quick wipe with your hand removes the worst of the caked-on semen (yours, hers, you can't tell whose) from your face.");

	outputText("\n\n\"<i>You sure?</i>\" she asks, giggling.   \"<i>Alright then... my cock feels so sensitive I'd probably end up appreciating you right away, anyways, and there's no fun in that, right?  How about a nap instead?</i>\"  Without a word in reply, you lie back and closing your eyes.  You think you feel Loppe snuggle up against you, but you fall asleep too quickly to be sure.");

	outputText("\n\n<b>Two hours later...</b>");

	outputText("\n\nA familiar feeling emanates from your crotch... a distinct sucking and bobbing feeling.  Your eyes open and you awaken with a gasp as you blast a fresh batch of cum into Loppe's eager mouth.  She withdraws with a slurp and smiles gleefully at you.  \"<i>Morning, sleepyhead!  Rest well?  Want me to wake you up some more?</i>\" she asks, licking her lips.  \"<i>I placed your stuff on the chair over there.  And don't worry, it's all cleaned too.  See you later on?  For more 'appreciation', of course...</i>\"");
	player.orgasm();
	dynStats("tou", .5, "lib", .5, "sen", -4);
	flags[kFLAGS.LOPPE_TIMES_SEXED]++;
	doNext(camp.returnToCampUseFourHours);
}

//Female
//Get Vagina-Fucked: (edited)
private function getFuckedInYerTwatYaCunt():void {
	clearOutput();
	outputText(images.showImage("loppe-sticks-it-in-your-vagoo"));
	outputText("As you contemplate the delicious possibilities that the herm presents, your eyes are drawn to her admirable piece of horse-meat.  With a half-grin, you settle yourself on her bed, ");
	//[(mans)
	if (!player.isTaur()) outputText("spreading your labia in an invitation that needs no words.");
	else outputText("exposing your rump and spreading your hind legs in your best effort to make her feel welcome.");

	outputText("\n\nLoppe smirks at you and winks.  \"<i>Don't worry; I'll treat you like a ");
	//[(femininity <= 40)
	if (player.femininity > 50) outputText("princess.  A sexy, smoking hot princess");
	else outputText("prince.  A dashing, dandy prince");
	outputText(" that I intend to fill up with my laquine love.</i>\"  She wastes no time and pounces on the bed, ready to bury her face between your [legs], licking her lips while taking deep breaths to inhale as much of your pheromones as she can.  You blink at the speed with which she moves, but smile, repositioning yourself to give her better access");
	//[(herm non-horse)
	if (player.gender == 3 && !player.isTaur()) {
		outputText(", though she needs to move aside " + player.sMultiCockDesc() + " ");
		if (player.balls > 0) outputText("and [balls] ");
		outputText("to really get at your cunt");
	}
	outputText(".");

	outputText("\n\n\"<i>Sugar, you have no idea how good you smell.  Oh, I just have to get a taste of that sweet-looking pussy of yours.</i>\"  Loppe dives forward");
	//[(not horse and herm)
	if (!player.isTaur() && player.gender == 3) {
		outputText(", under your ");
		if (player.balls > 0) outputText("[sack]");
		else outputText(player.multiCockDescriptLight());
		outputText(",");
	}
	outputText(" to lick and kiss your sensitive labia.  You arch your back and thrust your crotch at her, letting the laquine have your precious pussy to taste and suckle and ravage... she's pretty good with that tongue of hers.  Loppe lifts her head and wipes her face with her arm.  \"<i>I'm even better with this,</i>\" she says, mirroring your thoughts and holding her painfully erect equine-shaft.  You watch as it throbs, every vein bulging visibly, balls engorged as they churn up a load of cum to deposit in your waiting womb.  She ducks to take another lick, tasting you like one tastes a fine wine.");

	if (player.vaginas[0].virgin) {
		outputText("\n\n\"<i>You taste like a virgin, [name].  But that's impossible, right?  There's no way a hottie like you would let a silly horse-bunny like me be your first.</i>\"");
		//[(low corr)]
		if (player.cor < 50) outputText("  You look coy, for her benefit, and cast your eyes down shyly.");
		else outputText("  You do your best to warn her away from the topic with your eyes, eager to get on with the fuck.");
		//(not for horsez)
		if (!player.isTaur()) outputText("\n\nLoppe gasps and persists.  \"<i>Wow... I'll actually get to be your first... are you sure that's okay?</i>\"");

		outputText("\n\nYou reach out ");
		if (player.cor < 50) outputText("and tap her playfully on the nose");
		else outputText("in your irritation and squeeze her face imploringly");
		outputText(".  Would you be here, with your clothes off in Loppe's bed, if you weren't okay with it?");

		outputText("\n\nShe swallows audibly and grins.  \"<i>I assure you I'll be gentle and that I'll make your first time as memorable as I can.  You're not leaving this room until you are completely satisfied, I promise!</i>\"");
	}
	//(else if vaginalLooseness < 3)
	else if (player.looseness() < 3) outputText("\n\n\"<i>You taste so sweet... I knew I was right to call you 'sugar', sugar!</i>\" Loppe comments with a smile and lick of her lips.  \"<i>But enough foreplay!</i>\"");
	else outputText("\n\n\"<i>I see I'm not dealing with a rookie,</i>\" she muses.  \"<i>You must be quite experienced.  But no worries, I'm pretty skillful with my tool; I assure you I'll give you a ride unlike any other!</i>\"");

	outputText("\n\nLoppe aligns her flared tip with your [vagina] and finally pushes herself in, plumbing your depths with her delicious, juicy horse-prick; pre-cum helps her entrance as she pushes as far as she can inside your depths with flared tip caressing your walls as she finally");
	if (player.vaginalCapacity() >= 35) outputText(" bottoms out, completely hilted inside you");
	//[else:
	else outputText(" bumps against your cervix");
	outputText(". You moan in delight as she sinks into you");
	if (player.vaginas[0].virgin) outputText(", repressing a shiver of pain as she tears through your hymen, taking your virginity");
	else if (player.vaginalCapacity() < 35) outputText(", forcing your entrance wide to accommodate herself");
	outputText(".");
	//cuntchange, but suppress standard messages
	player.cuntChange(35,true,true,false);

	outputText("\n\n\"<i>Ah, It feels even better than it tastes...</i>\" Loppe says airily as she begins humping you, her powerful hips working to bring both of you closer to the edge and beyond.");
	//[(not horse)
	if (!player.isTaur()) outputText("  You wrap your [legs] around her hips as best you can, thrusting in your efforts to meet her strong rhythm, feeling your cunt rippling around her wonderfully long, thick horsecock.");

	outputText("\n\nLoppe's technique is exquisite; she gyrates her hips with each thrust, making sure to press her flare against that special spot inside you that makes you scream in pleasure, once she sees your reaction, she deliberately drags her tip across it with each pass, depositing huge amounts of pre.");

	outputText("\n\nYou hiss and shudder, writhing across the bedsheets as your lover works her magic on you, filling you with pleasure.  Juices flow wet and thick from your pussy");
	if (player.hasCock()) outputText(", precum begins to drool from your " + player.multiCockDescriptLight());
	outputText(".");

	//Not Centaur:
	if (!player.isTaur()) {
		outputText("\n\nYou grab Loppe's face to kiss her passionately. One hand strokes her long, dark hair, while the other slides down her back - it takes some work to position yourself right, but you're finally able to grasp her balls, kneading and jiggling them in the palm of your hand, fingers curling around to tickle their way into her wet, dripping cunt.\n\nLoppe breaks the kiss and gasps. \"<i>If you... ah... keep this up, sugar, you'll be getting a healthy dose of laquine love anytime now.  Oh, right there!</i>\" Loppe moves to kiss along your collarbone and suckle on your neck.\n\nWell, now, if that isn't encouraging in its own right... your free hand starts to play with her long, rabbit-like ears - after all, those should be sensitive, right?  Them being erogenous zones makes as much sense as anything about your relationship with Loppe does - even as your busy hand continues to massage her balls and her pussy, flicking her clit and pumping your increasingly juice-smeared fingers into her neglected, greedily-sucking hole, you grind your hips into hers, gyrating in a countermeasure to her own motions");
		if (player.gender >= 3) outputText(" and smearing both your bellies with herm-pre");
		outputText(".");
	}
	//Centaur:
	else {
		outputText("\n\nYou find yourself pushing back against her, lifting your [butt] to better receive Loppe's thrusts, even forcing her back as you do so.");
		outputText("\n\n\"<i>S-sugar, if you keep this up, you're going to knock me off the bed,</i>\"  Loppe says in-between pants.  Softly, but loud enough to be heard over the lewd slaps of sex, you tell your lover that she's free to give up and let you take control if you're too much for her.");
		outputText("\n\n\"<i>Don't be silly,</i>\" she retorts.  \"<i>If you want it rough, all you have to do is ask!</i>\"  With that exclamation, she begins thrusting against you with all her might, grunting each time your hips collide.");
		outputText("\n\nYou can't reach Loppe to play with her using your fingers, so instead you try talking dirty, alternately teasing the horse-dicked hybrid about her inadequacies and praising her skills.  \"<i>Keep talking, sugar.  I'm going to stuff this wonderful pussy of yours full of laquine love!</i>\"  Loppe grunts, redoubling her pace.  Apparently she's not too shamed; the cock inside you is swollen and hard, and something about the way it twitches tells you that the dancer will be finishing soon.");
		outputText("\n\nWith a pointed comment about her not being enough of a stallion to please a proper mare and a laugh for emphasis, you push your hips back with extra force, moaning at the feeling of her horse-cock inside your mare's cunt.  The lusty half-breed doesn't bother replying, she just thrusts against you as hard as she can, pistoning in and out of your [vagina] with abandon.  Each slap of your hips sends pleasure rippling through you.  You gasp and moan, flicking your fingers across your [nipples] for further stimulus.  You rut back against your hybrid herm lover as hard as you can... just a little more, oh, you're so close!");
	}
	outputText("\n\nLoppe gasps and screams, almost neighing, as you feel her cock bulge right before the first of many ropes of cum splatter against the walls of your womb.  You cry out in delight as the sensation of steaming hot spunk gushing into you sets your inflamed nerves alight; your cunt squeezes down on her cock rapturously as you shudder and heave your way to your own climax");
	if (player.hasCock()) {
		outputText(", neglected cock fountaining cum ");
		if (player.cumQ() < 500) outputText("between you and painting you both");
		else outputText("gushing onto the bedsheets and smearing your belly");
		outputText(" with this aspect of your dual-sexed orgasm");
	}
	outputText(".");

	outputText("\n\nLoppe's endless ropes of semen fill you to the brim within instants; the excess jets out of the seal formed by her cock, smearing her bedsheets with the results of your coupling.  By the time she's spent you're lying in a pool of your combined juices, completely matted with cum and utterly satisfied.  Loppe sighs and smiles at you.  \"<i>So... how did you like your ride, sugar?</i>\" she asks, lightly humping you with her slowly softening horse-prick as she leans over you.");

	outputText("\n\nYou smile, stroke her cheek, and give her a kiss.  Loppe grins happily at you. \"<i>... Let's not waste any time and get started with round 2!</i>\" She says excitedly");
	if (!player.isTaur() && player.hasCock()) outputText(", giving you a quick peck on the cheek and licking a small gob of cum that seems to have stuck to your chin");
	outputText(".");

	outputText("\n\nAlready...?  Loppe smiles and gives you a kiss, straight on the lips; as the two of you lock lips you can feel her cock, still buried inside you, hardening once more.  It throbs as it fills you up again, still leaking cum.  Breaking the kiss, Loppe gives you a seductive glance and says as innocently as she can.  \"<i>You did say anytime, sugar... and the time is now!</i>\"  You barely have time to protest before she begins humping you once more, droplets of your previous session splattering about with each slap of your hips...");

	outputText("\n\n<b>One hour and some orgasms later...</b>");

	outputText("\n\nYou gasp and moan, heaving in lungfuls of air as if they might be the last ones you'll ever take.  Your whole body is slack, nerves still tingling with pleasure even despite the all-consuming fog of exhaustion sweeping you.  There's not a muscle in you that hasn't been fucked loose with a mixture of fatigue and overwhelming pleasure.  Your stomach bulges obscenely, bigger than any normal sized pregnancy, jiggling and audibly sloshing with each breath you take as your movement jostles the laquine cream that has been crammed into you until you can't take any more.  You've gone numb from the waist down, but you're dimly aware of the slow slurping noise as Loppe's cum oozes steadily from your cunt.");

	outputText("\n\nLoppe wipes the sweat off her brow.  \"<i>Phew... I guess this is what they call ridden hard and put away wet.  I'm totally spent!</i>\"  She rolls to the side, giving you a peck on the cheek before she asks, \"<i>So... are you satisfied, sugar?  I mean... I might be limp now, but I can always whip up another erection if you want to go again.  I know it won't be hard with a hottie like you laying beside me.</i>\"  She smiles.");

	outputText("\n\nYou shake your head, not sure if you'd even feel her going to work again, so tired and raw are you. Loppe gives you a mischievous smirk and says, \"<i>Really?  Then you don't mind if I take another shot?  I wanna make sure I gave every single little spot of you some lovin'.</i>\"");

	outputText("\n\nWords fail you, and you give her ");
	//[(low corr)
	if (player.cor < 50) outputText("a pleading look... and if there's maybe a trace of horror dancing in the depths of your eyes, well, that's understandable, isn't it?");
	else outputText("an incendiary glare, letting her know just what you think of her posturing.");
	outputText("  Loppe bursts out laughing.  \"<i>Just kidding, sugar.  If we go another round I think my dick might fall off.</i>\"");

	outputText("\n\nYou stare at her a few moments, then laugh once - the awkward wobbles in your belly stifle any more.  A fate like that would serve her right for getting so carried away.  Loppe blows you a raspberry and then hugs you close, basking in your warmth while riding out her afterglow.");

	outputText("\n\nSidling up to you lover as best you can, you snuggle into her soft embrace.  A little rest can't hurt, right?  You take a look at the room around you, observing the copious smears of fluid all over the bedding and the floor - she's lucky her cock was buried in your cunt, or you're certain the walls and ceilings would be drenched in the stuff as well.  Wondering how lucky you yourself are to be so thoroughly worn out, you close your eyes and sink into oblivion.");

	outputText("\n\n<b>Two hours later...</b>");
	outputText("\n\nWhen you awaken, you feel much better.  You automatically right yourself, and find to your surprise that it's as effortless an action as always - your absurdly distended gut is gone.  In fact, you've been tucked carefully into clean, dry linen, and the floor is bare.  The stench of sex that should be suffocating you is entirely absent; you could hardly believe there was sex in here at all, nevermind the unmasked fuckfest you just had.");
	outputText("\n\n\"<i>Oh, you're awake.  Great!  I brought something to eat,</i>\" Loppe says, casually walking towards you with a tray containing a sandwich and some milk.");

	outputText("\n\nYour belly rumbles, reminding you that even if you don't look like it, you still just woke up after a marathon sex session, and you gratefully accept her offer of food.");
	if (silly()) outputText("  \"<i>Da! Sandvich is kredit to team!</i>\"");

	//(First Time)
	if (flags[kFLAGS.LOPPE_TIMES_SEXED] == 0) {
		outputText("\n\nLoppe grins nervously as you ravenously tuck into your meal, hovering by your side until you finish.  Once you're done, she gives you a sheepish smile.  \"<i>Sorry about that.  I guess I might have overdone it, but it was so exciting being with someone new.  If it was too much, I'll be happy to make it up to you - maybe a date, or... maybe another, much slower session.</i>\"  She looks slyly at you.  \"<i>Whichever you're up for.</i>\"");
		outputText("\n\nBefore you have a chance to answer, she leans in and captures your lips in a kiss.");
	}
	//Else
	else {
		outputText("\n\nLoppe watches you feast with an amused, loving smile.  \"<i>Sorry about that.  I still can't quite control myself, especially not when I have a cutie like you as my lover.  But... thanks for coming back again.  You're sweet, sugar!</i>\"");
	}
	outputText("\n\nWiping off the remnants of the post-sex meal, you're briefly disappointed that there isn't more - you're still only halfway home from famished.  \"<i>Sorry, but that's all that I had time to make,</i>\" Loppe apologizes.  Then she grins,  \"<i>Looks like you enjoyed it, though; I knew you'd want something after the 'workout'.  If you want, I can also draw you a bath.</i>\"");

	outputText("\n\nYou think it over, but then laugh and turn her down; just how can you trust her not to follow you into the bath and stuff you so full you can't get out of it?");
	//[Libido >=50:
	if (player.lib >= 50 || player.minLust() >= 30) outputText("  Not that you didn't just titillate yourself thinking of it...");
	outputText("  Your lover laughs, \"<i>Okay, you got me there... but, anyway, I have some chores to run for my mom, so I guess I'll see you later?</i>\"");

	outputText("\n\nYou slide out from beneath the covers and start redressing yourself.  Once you're done, Loppe steals a quick peck on the lips before you head out.");
	//3 hours pass.
	player.slimeFeed();
	flags[kFLAGS.LOPPE_TIMES_SEXED]++;
	player.orgasm();
	dynStats("tou", .5, "lib", .5, "sen", -4);
	doNext(camp.returnToCampUseFourHours);
}


//Any(C)
//Get Ass-Fucked, for not horses: (edited)(C)
private function getButtFuckedNonHoarseByLoppe():void {
	clearOutput();
	outputText(images.showImage("loppe-sticks-it-in-your-butt"));
	outputText("You swallow as your eyes are drawn to the equine sausage jutting out between the bunny-girl's legs, and know you just have to have it.  Slowly, you spread yourself upon Loppe's bed, scooting up toward the head and pillows and kneeling, [butt] in the air, inviting the laquine to do with you as she will.");

	outputText("\n\nLoppe giggles.  \"<i>So you want it that way, huh?  You sure about this, sugar?</i>\"");

	outputText("\n\nYou nod your head, still silent, letting her take her cue from your actions.  \"<i>Okay then, let's get you prepped up first.</i>\" Loppe insists, moving to her closet.  She opens it and looks around.  \"<i>Hmm... aha!</i>\"  Your lover triumphantly lifts a rather large bottle containing a strange bluish liquid, the label sporting a design featuring an extremely well-hung, happy looking herm with an erection.  \"<i>Good old lubrication!</i>\"");
	outputText("\n\nNow, why do you suppose she has that handy?  Loppe blushes a bit and giggles.  \"<i>Well, a girl has her kinks, sugar.  So it pays to be ready... anyways, you're one to talk, crawling onto my bed and lifting that cute butt up for me.</i>\"");

	outputText("\n\nLoppe moves back towards the bed and gently places the vial beside you.  \"<i>Since you're so eager for this, you may do the honors.</i>\"  She crosses her arms and stands beside the bed, waiting for you to get started; her cock looks painfully erect and throbs visibly.");

	//(PC has Anal Wetness)
	if (player.ass.analWetness > 0) {
		outputText("\n\nYou smirk and fold your arms - you don't need it; your ass makes its own lube.  Loppe's eyes widen in surprise.  \"<i>What? Are you serious?</i>\"  A coy look and an elevated rear invite her to see for herself, but for emphasis, you suck with exaggerated innocence on the tip of a finger.  Already, you can feel your arousal stimulating you, resulting in beads of moisture welling up within your sex-ready hole.  Loppe reaches in and thrusts her index finger into your butt, gasping in surprise.  \"<i>Wow... you really are full of surprises, aren't you, sugar?</i>\"");
		outputText("\n\nYou simply moan and arch your back, so conditioned to anal sex that even this blunt insertion is arousing and wonderfully stimulating rather than painful, as it would have been to a neophyte. To encourage her to get started, you press back against her hand, grinding your ass against the palm.");
		outputText("\n\nLoppe smirks.  \"<i>Have some patience, sugar.  Even if I can get myself pretty slick, it doesn't hurt to have a little something extra to help me ease myself in, y'know?  Plus I want to feel those wonderful hands of yours, so get to work!</i>\"  Loppe presents you her erect horse-prick.");
	}
	else {
		outputText("\n\nYou look at her, finding it a little hard to believe that she doesn't want to do this herself.  Still, you pick up the bottle of lube and examine it.");

		outputText("\n\nSquirting a good measure of the lube into your hands, rolling the thick, sticky, creamy liquid around in your palms, you bend to start massaging it into your ass, worming it into the crack.  That's cold!  You shiver, but stubbornly continue the massage, getting your ass nice and slick, gently inserting lube-coated fingers to stretch it a little in preparation for Loppe's horse-meat sausage.");
		outputText("\n\n\"<i>Sorry to interrupt sugar... but that was meant for me, not for you.  I was hoping to feel your slick hands on this bad boy.</i>\"  She waggles her prick at you; the half-formed flare bobs and weaves through the air.");
	}
	outputText("\n\nYou give her a look of feigned sorrow at your mistake, but promptly apply some lube to your hands and motion her to the bedside.  When she draws close, erection proudly jabbing towards you, you reach out and clasp your slippery hands around its impressive girth; Loppe squeals softly.  \"<i>That's cold!</i>\" she says, shivering from the sensation.  You just smile up at her and begin to stroke her shaft.  Up and down, back and forth, gently twisting your hands around to ensure a nice, even cover across her length.  You grip tightly, pulling in smooth, steady jerks with each pump of your limbs, the lube helping you to slide forward and back.  Loppe moans and smiles at you.  \"<i>That feels great, sugar - keep going!</i>\"");
	outputText("\n\nThe head of her horse-like cock is starting to swell out into its distinctive flare, perfect for stroking all sides of the orifice lucky enough to accept it.  You begin to massage the lube into the engorging flesh, rolling your fingers teasingly over the cumslit.  Your hands, still with a considerable amount of lube on them, find their way back down her length to the opposite end.  There her balls lie, proud and swollen with the hot laquine cream she'll soon be trying to pour into your belly, and under them lies her pussy, already growing damp from the stimulation you're giving her.  You begin to squeeze and knead both; her balls get the attention of one hand while the other slips into her pussy and starts gently probing into its hot, tight, slick depths.");

	outputText("\n\nLoppe gasps in pleasure.  \"<i>H-hey, sugar, what are you doing?  That place doesn't need to be lubed.</i>\"");

	outputText("\n\nYou give her your most mischievous smile and promptly give her balls a playful squeeze.  The bunny-stallion moans hoarsely, precum welling up from her flared head and noisily dripping with a soft splat onto the floor.  You release her shaft and reposition yourself on her bed as you were originally were, telling her that you think she's ready to go.");

	outputText("\n\nLoppe pants and smiles at you.  \"<i>Now you've done it... you got me really going now, so get ready.  I'll give you a ride you won't forget anytime soon!</i>\" your lover hurriedly snatches the vial of lube and puts it away, then literally pounces on your elevated butt and aligns the tip with your moist rosebud.");

	//(if Anal Looseness == 0)
	if (player.ass.analLooseness == 0) {
		outputText("\n\nLoppe presses her flared head against your tight little hole, but it won't go in, despite all the lube.  \"<i>Wow, sugar.  You're really tight here... how many times have you done this before?</i>\"");
		outputText("\n\nYou admit this is your first time.  Loppe's eyes open wide in surprise.  \"<i>Really?  So I get to be the first to spread this gorgeous butt of yours?  Are you sure... ?</i>\"");
		outputText("\n\nYou shake your head and your ass emphatically.  This far in, there's nothing to second-guess.  \"<i>Wow... I'm honored, sugar!</i>\" Loppe gushes.  \"<i>I'll make sure to be as gentle as possible.  Try to relax; it'll make this easier.</i>\"");

		outputText("\n\nHaving said that, she begins to push against your tightly-sealed sphincter, slowly increasing the pressure until her flared tip finally pops in.  You try to relax, like she said, but still can't restrain a soft groan of pleasure-pain as she forces her way inside of you, stretching you in a way you know you'll never completely recover from.");
		//insert anal virginity loss message
		player.buttChange(35,true,true,false);
		outputText("\n\nOnce inside, Loppe slowly slides forward, aided by the lube you've poured on her shaft earlier, until she's as far in as she's going to get.");
	}
	//(else if Anal Looseness < 3)
	else if (player.ass.analLooseness < 3) {
		outputText("\n\nLoppe presses her flared head against your [butt]; it takes a little work, but she manages to pop her tip inside your waiting hole.  You shiver and let out a purr of pleasure at being filled so...");

		outputText("\n\n\"<i>I see that you're no stranger to anal, sugar.  But damn, you're still tight!</i>\" Loppe sighs, shuddering as your sphincter contracts around her shaft.");

		outputText("\n\nYou manage to look at her over your shoulder and tell her it's no fun for your partners if you let yourself get too stretched out; you take good care of yourself.  Loppe leers at you.  \"<i>Don't worry, sugar. I'll take very good care of you, too.</i>\"  She licks her lips salaciously at the thought of what she intends.");
		outputText("\n\nYour eyes twinkle with eagerness; as much fun as banter is, you're waiting for the hard rod in your ass to start moving.  Loppe smiles back and gently humps you, sliding herself in inch by inch until she's as deep in your tight confines as she'll go.  You just purr in pleasure, wiggling your ass back into her crotch in appreciation.");
		player.buttChange(35,true,true,false);
	}
	else {
		outputText("\n\nLoppe presses her flared head against your [butt] and gasps in surprise as her tip all but glides inside without a hitch.  You croon in delight at the welcome feeling of cock up your trained ass once more.  \"<i>Whoa, sugar.  I can see you really enjoy some butt-fun.</i>\"");
		outputText("\n\nHaving an enormous cock and a libido as large as she claims, you would think she'd be pretty used to stimulating herself with a little ass-play as well.  \"<i>Of course I do, once in a while, but I'm not nearly as loose as you are.  But I won't lie and say this doesn't feel good; it's like a moist little pussy...</i>\" Loppe retorts.");
		outputText("\n\nWell, in that case, surely Loppe knows what to do.  You push back against her, sliding several more inches into yourself, and Loppe giggles.  \"<i>Of course I do, sugar.</i>\"  She bucks her hips into you, quickly hilting herself within your gaping, accommodating ass.  You gasp in pleasure and surprise as you suddenly find yourself filled with Loppe's equine-prick, moaning audibly as Loppe settles inside you, and turn to smile at her, eager to see what she can do once she really gets going.");
		player.buttChange(35,true,true,false);
	}
	outputText("\n\nLoppe grabs your [hips], leaning over your back to whisper into your ear.  \"<i>Should I get started, sugar?  Or do you want me to wait while you get used to me?</i>\"");

	outputText("\n\nShivering around the horse-cock spearing your tingling ass, you grind back against your hermaphrodite lover in physical encouragement, impatient with desire.  Loppe giggles, amused by your reactions.");

	outputText("\n\nYou moan as Loppe quickly pulls out, leaving you with a feeling of uncomfortable emptiness; but soon she thrusts herself back inside, filling you up once more.  She initially sets upon a slow, long rhythm but quickly speeds up as your moans and gasps of pleasure encourage her to go further.  \"<i>How is it, sugar?  It feels pretty good back here,</i>\"  Loppe pants, humping you.  You simply nod, groaning softly at the sensations filling you");
	if (player.hasCock()) {
		outputText(", cock");
		if (player.cockTotal() > 1) outputText("s");
		outputText(" dripping pre");
		if (player.hasVagina()) outputText(" and");
	}
	else if (player.hasVagina()) outputText(", ");
	if (player.hasVagina()) outputText(" pussy oozing femlube");
	outputText("... you beg her to go faster, to do it harder!");

	outputText("\n\nLoppe happily complies, thrusting herself deeper and stronger.  ");
	//[(cock)
	if (player.hasCock()) outputText("One of her hands reaches around to grasp your pre-slickned [cock biggest], stroking you in time with her thrusts.  ");
	if (player.gender == 2) outputText("One of her hands reaches around to tease your dripping [vagina] and erect [clit], dipping a finger in every time she bottoms out.  ");
	outputText("Wet slapping noises fill the room, and you gasp in pleasure each time her cum-churning balls slap against ");
	if (player.balls > 0) outputText("yours");
	else outputText("your [butt]");
	outputText(".  Loppe lays down on top of you, panting hotly on your neck, moaning in pleasure each time your sphincter contracts.");

	outputText("\n\nWith a groan, she jams herself as far in as she can, grasping your [hips] tightly.  You can feel her balls churning against your butt, her throbbing dick seemingly growing fatter as cum travels up her urethra; finally, with a moan, she explodes inside you, filling you up with hot laquine cream.  You gasp and shudder as shot after shot of herm-spunk rushes in; you'd almost swear you can hear it slurping and splashing as it cascades into your belly, and you're positive you can feel your stomach start to distend from the glutinous mass of semen building up inside of you.  You struggle to hold back your own orgasm but finally lose the battle, crying out as it rocks through you.");
	if (player.hasVagina()) {
		outputText("  A gush of sexual fluids from your crotch ");
		if (player.wetness() < 3) outputText("spatters");
		else if (player.wetness() < 4) outputText("splashes");
		else if (player.wetness() < 5) outputText("drenches");
		else outputText("completely soaks");
		outputText(" the bed-linen under you.");
	}

	outputText("\n\nWith a hollow, ragged moan you collapse face down into the pillow, falling flat on your stretched stomach.  You nuzzle into the bed linen, feeling Loppe's comforting weight on your back, and make soft sounds of appreciation.  Loppe kisses the back of your neck, dreamily cooing, \"<i>I'm glad you liked it, sugar. Your ass feels so good... I wouldn't mind doing this again. In fact, that sounds good.</i>\" You barely have time to protest as she begins humping you once more, her shaft throbbing and hardening once more as she gets her second wind.");

	outputText("\n\nYou realize she's not going to take no for an answer; clenching the bedding between your fingers, you ready yourself for whatever she has in mind...");

	outputText("\n\n<b>One hour and some orgasms later...</b>");

	outputText("\n\n\"<i>Ahhh... that was great.  My balls feel completely dried out.  I loved it!</i>\" Loppe rolls over to the side, pulling out of your well-used asshole with a wet slurp; her cock is closely followed by a veritable cascade of white spunk.");

	outputText("\n\nYou simply moan incoherently, your brain too fizzed with exhaustion and pleasure to form sentences, leaving you to just lay there and slosh on your impossibly swollen belly.  Utterly bloated, you can't even bring yourself to react.  You try to muster something to reply to her just the same, but all you dredge up is a heavily spunk-scented belch, the thick, salty tang of cum flooding your tongue.");

	outputText("\n\n\"<i>Sugar?  Are you okay?</i>\" Loppe asks worriedly.  You cough and spit up a gobbet of cum.  Loppe must have really enjoyed herself to fill you this full.  You stifle another belch and more spunk drips from your lips.  Loppe smiles nervously.  \"<i>Whoops... I guess I got a little carried away.</i>\"");

	outputText("\n\nStill... it was definitely an interesting ride.  \"<i>Aw, sugar, I'm sure it's not that bad.</i>\"  She gives your [butt] a playful swat, prompting a jet of spunk to spill from your abused ass, and bites her lip apologetically.");

	outputText("\n\nYou run your hands over your distended abdomen... you wouldn't be surprised if she got you pregnant despite this being the wrong hole.");

	outputText("\n\n\"<i>Now you're just being silly; I'm not that virile... nobody's that virile.</i>\"  The laquine pouts, clearly upset.  ");
	//[(has had 1+ satyr babies)
	if (flags[kFLAGS.SATYR_KIDS] > 0) outputText("You laugh softly; hopefully she'll never have to meet the creature that dispelled that same doubt in you.  ");
	outputText("\"<i>I think this is time for sleeping, not joking.</i>\"  With a trace of wounded dignity, she lays herself down and curls into your back, one arm wrapped around your gurgling belly.");

	outputText("\n\nEven if you wanted to get out now, you doubt you could with her arm and the dead weight of her deposit.  Sighing, you relax next to the petulant half-breed and let sleep claim you...");

	outputText("\n\n<b>Two hours later...</b>");

	outputText("\n\nSomething wiggles inside your maw, exploring every little bit of it.  It feels warm... you move your tongue to try and trap this pleasant invader and taste something strange... with a start, you realize it tastes like the cum you burped up earlier, and your stomach heaves a bit.  Opening your eyes reveals Loppe's own; the laquine is lying down on top of you, kissing you deeply to try and lick your mouth clean of her own cum.  She smiles at you with her eyes but doesn't break away, scooping up as much cum as she can from your mouth, sucking on your tongue to try and replace the taste of cum with the taste of her saliva.");

	outputText("\n\nFinally satisfied, she pulls away, a thin strand of saliva linking her lips to your own.  \"<i>Are you alright, sugar?  Want me to get you something to eat?</i>\" Loppe offers.");

	outputText("\n\nYou think it over, then shake your head.  No, you feel too queasy still to really eat anything for a while yet.");

	//(First Time)
	if (flags[kFLAGS.LOPPE_TIMES_SEXED] == 0) {
		outputText("Loppe laughs nervously.  \"<i>Sorry about that.  It's just that I usually can't bag a real cutie like you, and I think I might have gone a bit overboard... is there anyway I can make it up to you?</i>\"");

		outputText("\n\nYou'll tell her if you think of something... though watching her sweat over your meaning is almost recompense enough already.");
		outputText("\n\n\"<i>H-hey, I know for a fact that you enjoyed it too, so try not to think of anything too abusive... unless you want another round?</i>\"");
		//(Low Libido)
		if (player.lib < 33) outputText("\n\nYou give her a flat stare, letting your expression speak for you.");
		//(Medium Libido)
		else if (player.lib < 66) outputText("\n\nYou tell her that maybe you'll take her up on that... some other time.");
		//(High Libido)
		else outputText("\n\nIt's tempting, but no.");
		outputText("\n\nLoppe averts her eyes, rubbing the back of her neck with a sorrowful attitude.  \"<i>Well... I guess I don't have anything clever to say.  I'll understand if you don't come back, but... I really, really did enjoy our time together.</i>\"");
	}
	//(Else)
	else {
		outputText("\n\nLoppe draws you into a short kiss.  \"<i>Sorry... but you know how much I like sex, and you're really cute too.  It's kinda hard to control myself.</i>\"  She smiles seductively at you.  \"<i>Then again, maybe I could just fuck you into staying here with me - that way you wouldn't have to bother leaving and coming back.</i>\"");
		outputText("\n\nShe continues elaborating despite the look you give her.  \"<i>Room and board won't be a problem; I could just double my dancing shifts and I'd have enough saved up to keep you.  Feeding, either... I can just stuff you myself.</i>\"  She grins wickedly, obviously enjoying the mental image.");
	}
	outputText("\n\n\"<i>Anyways, I cleaned your clothes,</i>\" she suddenly declares, obviously changing the subject.  Loppe gets out of the bed to go and get your clothes. You take this opportunity to slip out between the sheets; while your belly is still swollen enough to look like a full-term mother's-to-be, you've shrunk down considerably.  Looking around, you see that Loppe has somehow managed to clean the linens and the floor of the mess that the two of you made... well, really, it was mostly her mess, seeing as how virtually everything pumped out was pumped into you, by her.");

	outputText("\n\nLoppe returns with your [armor] in hand.  \"<i>Here you go, sugar,</i>\" she says, presenting them, then adds, \"<i>Err... you might want to get a bath before putting these on... would you like me to heat some water for you?</i>\"");

	outputText("\n\nA quick hot bath would do wonders.  Especially for helping you, ah, clear some backlog.  Loppe looks mischievous when you answer in the affirmative.  \"<i>As much as I might love to join you, I'd best let you bathe alone; we don't want this to happen again.</i>\"  She taps on your pregnant-looking belly.  \"<i>I don't think I'd be able to help myself if we were to enter a tight little tub together.</i>\"");

	outputText("\n\nLoppe blushes when she sees your expression and looks down; you follow her eyes and, sure enough, her equine member is slowly growing back to full erection again.  You stare at her in disbelief, to which she shrugs casually.  \"<i>I can't help it.  You're hot.</i>\"");

	outputText("\n\n<b>One bath later...</b>");

	outputText("\n\nFeeling clean and refreshed, not to mention much lighter, you leave Loppe's bathroom with a thank-you.  The girl laughs nervously.  \"<i>Again, sorry about that, sugar.  Anyways, I'm in need of a bath of my own.</i>\"");
	player.slimeFeed();
	flags[kFLAGS.LOPPE_TIMES_SEXED]++;
	//3 hours pass
	player.orgasm();
	dynStats("tou", .5, "lib", .5, "sen", -4);
	doNext(camp.returnToCampUseFourHours);
}

//Get Ass-Fucked: Centaur Enhanced Edition (edited)(C)
//Replaces the normal anal scene in case you're a centaur.
private function getAssFuckedByLoppeAsACentaur():void {
	clearOutput();
	outputText(images.showImage("loppe-sticks-it-in-your-butt-you-centaur"));
	outputText("You swallow as your eyes are drawn to the equine sausage jutting out between the bunny-girl's legs, and know you just have to have it.  But is she confident in her ability, even with your shape?");

	outputText("\n\n\"<i>Confident enough,</i>\" she replies, winking at you.  \"<i>I'm not some blushing virgin, after all.  You're hardly the first centaur who wanted to take a shot at me, sugar.</i>\"");

	outputText("\n\nGood, because you feel like having her put that cock of hers to work on your [ass].  You slowly circle her, lazily waving your tail.");

	outputText("\n\n\"<i>Mmm... maybe it's the horse in me, but this sounds like a wonderful idea.  If you're willing to let me loose back there, I'm going to enjoy this...</i>\"  Loppe croons, already advancing towards you, hands reaching out to grab at your flank.  You're more than prepared for her...");
	//[ass wet)
	if (player.ass.analWetness > 0) outputText("  She doesn't even have to bother with lube; your ass is wet enough to accommodate her on its own.");

	outputText("\n\n\"<i>You might be even more eager than me - just give me a moment to set myself up,</i>\"  Loppe insists, giving your [ass] an appreciative slap.  From behind you, you can hear her bustling around, muttering, \"<i>Where did I put my lube?</i>\"  A triumphant exclamation follows, and you hear the wet, sloppy sound of fluid being enthusiastically applied to a sizable cock as the laquine eagerly strokes herself off.  You can already imagine that thick shaft of hers piercing your interior, satiating your hungry bottom with the heavy load contained in those balls.");

	outputText("\n\nSo caught up are you in your fantasy that you don't realize Loppe has finished lubing herself up and is behind you until you feel hands caressing your flanks.  \"<i>Alright, sugar, let's just see what we're getting into...</i>\"  One hand continues to rub your ass, while the other begins pressing something against your black rosebud...");

	//(if Anal Looseness == 0)
	if (player.ass.analLooseness == 0) {
		outputText("\n\nIt won't go in, despite all the lube.  \"<i>Wow, sugar.  You're really tight here... how many times have you done this before?</i>\"");

		outputText("\n\nYou admit this is your first time.  Loppe's eyes open wide in surprise.  \"<i>Really?  So I get to be the first to spread this gorgeous butt of yours?  Are you sure... ?</i>\"");

		outputText("\n\nYou shake your head and your ass emphatically.  This far in, there's nothing to second-guess.  \"<i>Wow... I'm honored, sugar!</i>\" Loppe gushes.  \"<i>I'll make sure to be as gentle as possible.  Try to relax; it'll make this easier.</i>\"");

		outputText("\n\nHaving said that, she begins to push against your tightly-sealed sphincter, slowly increasing the pressure until her flared tip finally pops in.  You try to relax, like she said, but still can't restrain a soft groan of pleasure-pain as she forces her way inside of you, stretching you in a way you know you'll never completely recover from.");
		//insert anal virginity loss message
		player.buttChange(35,true,true,false);

		outputText("\n\nOnce inside, Loppe slowly slides forward, aided by the lube you've poured on her shaft earlier, until she's as far in as she's going to get.");
	}
	//(else if Anal Looseness < 3)
	else if (player.ass.analLooseness < 3) {
		outputText("\n\nLoppe presses her flared head against your [butt]; it takes a little work, but she manages to pop her tip inside your waiting hole.  You shiver and let out a purr of pleasure at being filled so...");
		outputText("\n\n\"<i>I see that you're no stranger to anal, sugar.  But damn, you're still tight!</i>\" Loppe sighs, shuddering as your sphincter contracts around her shaft.");

		outputText("\n\nYou manage to look at her over your shoulder and tell her it's no fun for your partners if you let yourself get too stretched out; you take good care of yourself.  Loppe leers at you.  \"<i>Don't worry, sugar. I'll take very good care of you, too.</i>\"  She licks her lips salaciously at the thought of what she intends.");
		outputText("\n\nYour eyes twinkle with eagerness; as much fun as banter is, you're waiting for the hard rod in your ass to start moving.  Loppe smiles back and gently humps you, sliding herself in inch by inch until she's as deep in your tight confines as she'll go.  You just purr in pleasure, wiggling your ass back into her crotch in appreciation.");
		player.buttChange(35,true,true,false);
	}
	else {
		outputText("\n\nLoppe presses her flared head against your [butt] and gasps in surprise as her tip all but glides inside without a hitch.  You croon in delight at the welcome feeling of cock up your trained ass once more.  \"<i>Whoa, sugar.  I can see you really enjoy some butt-fun.</i>\"");
		outputText("\n\nHaving an enormous cock and a libido as large as she claims, you would think she'd be pretty used to stimulating herself with a little ass-play as well.  \"<i>Of course I do, once in a while, but I'm not nearly as loose as you are.  But I won't lie and say this doesn't feel good; it's like a moist little pussy...</i>\" Loppe retorts.");
		outputText("\n\nWell, in that case, surely Loppe knows what to do.  You push back against her, sliding several more inches into yourself, and Loppe giggles.  \"<i>Of course I do, sugar.</i>\"  She bucks her hips into you, quickly hilting herself within your gaping, accommodating ass.  You gasp in pleasure and surprise as you suddenly find yourself filled with Loppe's equine-prick, moaning audibly as Loppe settles inside you, and turn to smile at her, eager to see what she can do once she really gets going.");
	}
	outputText("\n\nA hand grips either of your hips; the half-breed grinds her crotch against your ass before she pulls herself out and then thrusts back in.  It's a little awkward, but soon she starts to pick up her rhythm, her flared head scraping against your inner walls, her balls slapping meatily against you");
	if (player.balls > 0) outputText("rs");
	else if (player.hasVagina()) outputText("r pussy");
	outputText(".");

	outputText("\n\nYou moan as she gets into her task");
	if (player.hasCock()) outputText(", feeling your erect [cock] press against your underbelly, mashed between your centaur half and the soft carpet of Loppe's room.  You hope she doesn't mind a few stains...  ");
	//(else vag)
	else if (player.hasVagina()) outputText("; your cunt is sopping, making a small pool of juices one the floor.  ");
	else outputText(".  ");
	outputText("She seems more worked up than usual, perhaps because you have a horse-like lower body?  \"<i>Are your instincts acting up?</i>\" you tease her.  \"<i>Or do you just love ass that much?</i>\"");

	outputText("\n\n\"<i>A little from column A... and a whole lot from column B,</i>\" Loppe grunts, without breaking her frantic pace.  \"<i>Instinct's part of it - I'm stallion enough that when I see a nice flank, I wanna fuck it.  But it's the fact that this is you and your incredible ass that's... that's driving me wild!</i>\"  She shudders, spasming so hard you can feel her cock twitching inside of you, eyes rolling in her head as she frantically pistons back and forth, too worked up to care that this is the wrong hole entirely - she's a stallion on a mission, and that mission is to breed you like a proper broodmare.");
	if (player.gender <= 1) outputText("  Even if you are the wrong sex entirely for that.");

	outputText("\n\nHer enthusiasm is contagious, and you find yourself bucking against her with almost as much eagerness as she's using to fuck your [asshole].  The pleasure is exquisite; that flared tip of hers plugs your hole in a most wonderful way... it's almost like every thrust fills up a part of you that was missing, while every pull creates a vacuum that threatens to suck that big horse-dick right where it belongs.  ");
	//[PC has cock:
	if (player.hasCock()) outputText("  The bumps against your prostate send waves of pleasure running through [eachCock] and spreading along your body, until they reach your throat and come out as a ragged groan.  ");
	outputText("If she keeps this up for too much longer, you will pop any moment now...");

	outputText("\n\n\"<i>Ohhh!  G-gonna cum... [name], your ass is incredible!</i>\"  Loppe moans, humping your butt like a herm possessed, delirious with her eagerness to climax.  Precum shoots in spurts easily equal to the orgasms of normal men and dickgirls; when she blows, it's going to be a big one...");

	outputText("\n\nYou clench your ass and groan, shuddering as you try to stop Loppe's movements with your gripping sphincter.  The ferocious climax brought by your anal stimulation sends waves of pleasure coursing along your body, rattling your teeth and making you see stars.");
	if (player.hasCock()) outputText("  [EachCock] spasms and unloads beneath you, smearing you and the carpet below and pooling thickly with fluid forced out by the prostate stimulation.");
	if (player.hasVagina()) outputText("  Your vagina contracts, trying to grip at a phantom member as you spill your fluids on the carpet beneath you.");

	outputText("\n\nThe scent of your orgasm and the feeling of your sphincter clenching around her cock as tightly as it can is too much for Loppe, who roughly slams into you one last time and whinnies with glee as she floods your ass with cum.  She continues to thrust and rut and buck as she fills you with splurt after gush of hot, thick herm spunk.  The liquid warmth of Loppe's orgasm only enhances your afterglow, and slowly you feel yourself filled until you");
	if (player.skinType != SKIN_TYPE_SCALES) outputText(" have goosebumps all over your body");
	else outputText("r scales are practically standing on end");
	outputText(".");

	outputText("\n\n\"<i>Ohhh... you are incredible, [name].  ");
	//[PC has dick that fits)
	if (player.cockThatFits(loppeCapacity()) >= 0) outputText("Though I hope you won't mind riding me, sometime,</i>\" she laughs.  \"<i>");
	outputText("How about another round, hmm?  Big strong 'taur like you should certainly be able to hold a little more loving inside of you, right?</i>\"  She croons happily, running her hands up and down your ass as if trying to entice you.");

	//(Low Libido)
	if (player.lib < 33) {
		outputText("\n\nCentaur or not, you do have your limits...");
		outputText("\n\n\"<i>Oh, I'll be gentle with you,</i>\"  Loppe murmurs... though the way she's looking at you and already starting to hump your ass again, having never pulled out, makes her reassurance less than reassuring.");
	}
	//(Medium Libido)
	else if (player.lib < 66) {
		outputText("\n\nYou stop and consider her words... you still do have some fight left in you.");
		outputText("\n\n\"<i>You want to see what kind of bronco buster I am?  Alright, let's get ready to do some real riding!</i>\" Loppe cheers, already beginning to thrust back and forth.");
	}
	//(High Libido)
	else {
		outputText("\n\nCentaur or not, you wouldn't just stop with a single fuck... if Loppe thinks she's got enough stallion in her to satisfy you, she should get to work ASAP.");
		outputText("\n\nLaquine fingers fix themselves to your [ass] as if glued there and their bearer begins to rut you just as eagerly as before, too caught up in the fucking to care about something as trivial as defending her stallionhood with words.");
	}
	outputText("\n\n<b>One hour and some orgasms later...</b>");

	outputText("\n\nWith a gasp and a moan, Loppe finishes cumming inside you, finally going flaccid.  She half-collapses onto your ass, using your broad horse-body to rest up, panting hard.  WIth a groan, she pulls herself wetly from your used hole.  \"<i>Sugar, you are without a doubt an excellent ass to fuck; I feel so damn satisfied - you've completely drained my balls!  This body of yours is really something; normally, I end up totally flooding the place when I have sex, but it looks like every last drop I came is still inside of you.</i>\"  From the sound of her voice, she's grinning quite proudly.");

	outputText("\n\nYou would say something if you weren't so tired after the multiple orgasms.  You feel completely battered... also, satisfied.  Quite tired too.  Your whole body feels bloated with laquine seed and for a moment you wonder how you'll be able to fit out the door again.  But right now, sleep is more important.  You set down on the floor and close your eyes, intent on getting some rest.");

	outputText("\n\n\"<i>[name]?  [name], are you... oh.</i>\"  Loppe smiles as she sees you've dozed off.  Quietly she slips away to the bed and pulls off her blanket, moving around to carefully seat herself against your bloated stomach, draping her blanket over the both of you and gently resting her head on your distended horse-gut.  \"<i>Sweet dreams, lover-" + player.mf("boy","girl") + ",</i>\" she stage-whispers to you, then closes her eyes, just as eager for some rest, listening to the gurgling of your flooded stomach as she drifts off.");

	outputText("\n\n<b>Two hours later...</b>");

	outputText("\n\nWhen you come to, the first thing you notice is the absence of a certain horny half-breed.  Examining your surrounding you note that much of the mess generated by your last outing seems to be gone.  With a groan you force yourself to stand on your hooves.  Damn, Loppe really did a number on you... you're still heavily bloated and heavy with all the seed she pumped into you earlier.");

	outputText("\n\n\"<i>Hey there, [name]; I see you're up now,</i>\"  Loppe calls to you in greeting as she comes through the door, hair wrapped up in a towel.  \"<i>Bath's free, so you might want to go and offload some of the cargo I gave you.</i>\"");

	outputText("\n\nThat would be great.   \"<i>Come on then... er, might be best I stay behind, actually; looks like you might need a little help getting through the doors,</i>\" she adds, echoing your earlier thought and eying your swollen form as if seeing for the first time just how big she made you.  Slowly, feeling your gut jiggling with every step you make, you head for the door first - true to Loppe's words, you find your bloated belly catching against the doorframe.  With some straining and a helpful shove you manage to pop through and head to the bathroom, the walls scraping against your sides as you go.  Getting into the bathroom takes a little effort as well, despite being built wider than the doorway to Loppe's bedroom.");

	outputText("\n\nOnce in the bathroom, you find another problem - you're just too big to fit inside the tub.  Loppe looks you over, nodding her head.  \"<i>Alright, just stick your tush out so it hangs over the tub - sitting down would be best - and give me a minute to grab something.</i>\"  She hurries off, then returns quickly with a small, dildo-like device.");

	outputText("\n\n\"<i>Meet my spooge-sucker,</i>\" she laughs.  \"<i>I got one of the few goblins they let into this city to build it for me, a couple of months after we moved here.  It's basically a glorified pump - see, when I have sex with somebody, there's almost always bloating involved.  Could be my lover, could be me, it's even been both of us a few times... mmm, I still remember my first double helix.</i>\"  She sighs, then shakes her head.  \"<i>Anyway, this handy little gadget helps me to quickly remove cum from a person.  So... loosen up back here, alright?</i>\"");

	outputText("\n\nConsidering all the time Loppe spent fucking you, you think you're loose enough for that already...");

	outputText("\n\n<b>A few minutes later...</b>");

	outputText("\n\nYou exit the bathroom, much lighter than you were previously.");

	//(First Time)
	if (flags[kFLAGS.LOPPE_TIMES_SEXED] == 0) {
		outputText("\n\n\"<i>I'm sorry I stuffed you that full,</i>\" Loppe apologizes, having the decency to look sheepish.  \"<i>I just get so horny, and my balls fill up so fast, that I just can't help it.  If it makes you feel any better, I wind up just as bloated when I'm the one getting the dick; I can't stop milking a cock until they've stuffed me as full as I can get.</i>\"");

		outputText("\n\nWell... Loppe did warn you about her libido.");

		outputText("\n\n\"<i>I won't lie and promise it won't happen again, but I swear I'll always try to make it as good for you as it is for me.");
	}
	//(else)
	else {
		outputText("\n\n\"<i>You are such a sexy centaur; you do know that, right?</i>\" she asks.  \"<i>I can't tell whether you're hotter normally or when you're inflated like a balloon with all my love for you.");
	}
	outputText("  Anyway, your clothes are back in my room; sorry to fuck and run, but I've got some errands to run before mom gets home - you'll have to see yourself out, okay?</i>\"");

	outputText("\n\nYou nod and head to her room to fetch your [armor].");

	player.orgasm();
	dynStats("tou", .5, "lib", .5, "sen", -4);
	flags[kFLAGS.LOPPE_TIMES_SEXED]++;
	player.slimeFeed();
	doNext(camp.returnToCampUseFourHours);
}


//SqueezeDick: (edited)(C)
//LoppeSexed must be true.
private function loppeSqueezedickWhateverThatIs():void {
	clearOutput();
	outputText(images.showImage("loppe-orgazm-denial"));
	//(if LoppeDenial == 0)
	if (flags[kFLAGS.LOPPE_DENIAL_COUNTER] == 0) {
		outputText("After seeing Loppe's prodigious output, you wonder how she would handle not being able to orgasm.");

		outputText("\n\n\"<i>Different?  What do you have in mind?</i>\"  She asks curiously.");

		outputText("\n\nOrgasm denial - a test to see just how long she can bear being pleasured before climaxing.");

		outputText("\n\n\"<i>I don't know... will that really feel good?</i>\"");

		outputText("\n\nIt's supposed to be like having the longest, hardest orgasm ever when you finally do cum.");

		outputText("\n\n\"<i>Hmm... I like the long, hard orgasm part,  and I haven't ever tried something like this - let's do it!</i>\"");
	}
	//(else if LoppeDenial == 1)
	else if (flags[kFLAGS.LOPPE_DENIAL_COUNTER] == 1) {
		outputText("\n\nWith a wry smile, you hold out a hand in response to her question, curling it into a half-clenched fist.  Loppe follows curiously, then starts when you squeeze it shut.");
		outputText("\n\n\"<i>It was kind of painful last time, but... I won't deny that it felt good.</i>\"  She smiles, then nods.  \"<i>Let's do it.</i>\"");
	}
	else {
		outputText("\n\nWith a wry smile, you hold out a hand in response to her question, curling it into a half-clenched fist.  Loppe follows curiously, then blenches when you squeeze it shut, looking quite queasy.  She looks at you with a sort of apologetic horror.");
		outputText("\n\n\"<i>I don't know, sugar.  I'm still a bit sore from last time... maybe we can do it after I've had some more time to recover?</i>\"");
		//Display Sex Options.
		menu();
		addButton(4,"Back",loppeSexChoice);
		return;
	}
	outputText("\n\nYou sit yourself down comfortably ");
	if (!player.isTaur()) outputText("on");
	else outputText("beside");
	outputText(" the bed and pat the sheets with one hand; Loppe seats herself obediently next to you.  She doesn't bother hiding her excitement, letting her equine endowment bob as she settles herself; she sits beside you as instructed and rests her hands on her lap.  \"<i>Ok, I'm very ready for whatever you got planned,</i>\" Loppe giggles as her cock throbs; a small dollop of precum slowly pools inside her flare.");

	outputText("\n\nYou grin back and slide your hands across hers, worming your way between her fingers in search of access to her base.  Loppe accomodates you, moving her hands to either side to brace herself.  Your own stroke the round, full orbs of her sack as you look forward to seeing what holding an orgasm or two in will do to them.  You cup them in the palm of your hand, awkwardly rolling them around with your fingers, reaching underneath to gently play with Loppe's clit.");

	outputText("\n\n\"<i>Oh!  I like where this is going,</i>\" she giggles, spreading her legs and supporting herself on her elbows to allow you full access to her assets.  \"<i>Knock yourself out, sugar.</i>\"");

	outputText("\n\nYou remove your hand from Loppe's balls and instead close it gently around her mottled pink-and-black shaft, slowly increasing the pressure.  \"<i>Hey, not too tight,</i>\" she chastises, and you ease up a little to avoid spoiling the surprise.  Your hand in place, you start to pump rhythmically, up and down, stroking the bunny-girl's horse-dick.  With your other hand, you caress her breasts, running your thumb in circles around each perky nipple to further tease and tantalize your partner.");

	outputText("\n\nLoppe moans.  \"<i>That feels good... come here, sugar.</i>\"  Loppe pulls you up towards her to deliver a passionate kiss right on your lips.  Her probing tongue seeks entrance into your mouth, tangling your own tongue with hers, caressing, rubbing, tasting and enjoying.  Loppe moans into your kiss, as you continue to caress her, until finally she decides to break the kiss, gasping for breath.  \"<i>Just a small sign of my appreciation.</i>\"");

	outputText("\n\nAll through this, your hands keep busy, one pumping steadily at her shaft, one stroking and caressing her body elsewhere.  You wonder how long she can last before your fingers coax the first orgasm from her...");

	outputText("\n\nAs if answering your unspoken question, you feel her shaft throbbing in your palms, pre leaking from her like a faucet.  \"<i>Keep this up just a little longer and you'll have a very happy laquine on your hands - all over them,</i>\" Loppe giggles.");

	outputText("\n\nYou switch both hands to stroking her shaft, the first now hovering low, close to her leathery sheath, continuing to pump and jerk, but readying itself for what comes next.  And, judging by the way she's wriggling and quietly squealing in glee, Loppe can't be too far from it.");

	outputText("\n\n\"<i>Okay... I can feel it coming... just loosen your hold a little bit and I'll show you how happy I am!</i>\"  Loppe pants, moaning and humping your hands, her balls churning in preparation to finally unload their contents.");

	outputText("\n\n\"<i>Poor girl,</i>\" you reply.  \"<i>You've forgotten the entire point already.</i>\"  Tightening your grip on the base of her shaft, you seal her urethra shut even as the other hand begins to quicken its strokes, pumping her faster and faster and faster...");

	outputText("\n\nThe horny herm gasps and yelps as you render her climax ineffective.  \"<i>C-come on, not even a little?  Just a bit of cum?  A small dollop?  Pretty please?</i>\" she begs.  You shake your head, continuing to pump away.");

	outputText("\n\nLoppe falls back on her bed, moaning loudly as she tries to hump your hands in a vain attempt to ejaculate.  She shudders and you feel the base of her cock suddenly swell, but as your vice-like grip prevents any from leaving, all that cum has no choice but to flow back into Loppe's body; her testicles bulge slightly as the laquine humps and groans.");

	outputText("\n\nYou stop stroking Loppe's cock to fondle her balls, confirming what your eyes tell you; they have actually grown from the backed-up orgasm.  With a gentle pat, you tell Loppe what nice, big, plump balls she has.");

	outputText("\n\n\"<i>Okay... you've had your fun, now let me go so I can cum,</i>\" Loppe whines desperately.");

	outputText("\n\nTeasingly, you chastise Loppe for her impatience; doesn't she know orgasms are like fine wine?  They get better with age.  With that you resume stroking with your spare hand, the first clamped tightly as ever around the base of her shaft, resting gently on her swollen balls.");

	outputText("\n\n\"<i>Oh, Marae... I'm gonna-</i>\"  Loppe doesn't have time to finish her sentence as another orgasm rocks her body and her jaw drops.  Once more you feel her shaft inflate slightly as her cum tries to force its way past your constriction, yet you maintain your firm grip, preventing her from spilling even a single drop.  Loppe's shaft looks positively swollen now, sensitive beyond measure and throbbing, and her cum-churning balls visibly inflate as more and more cum is diverted towards them.");

	outputText("\n\n\"<i>Ah!  [name], I... I can't.  Ah!</i>\"  Loppe shudders, curling her toes and gripping her bed as a third orgasm rocks her.  The increased sensitivity of her prick contributes to a string of serial orgasms; you barely need to do anything but hang on for dear life as her body puts itself through a loop where she attempts to orgasm but fails with sensations so intense that she climaxes again.");

	outputText("\n\nLoppe's testicles visibly grow bigger and bigger; the laquine's balls bulge and swell as orgasm after orgasm floods cum into the increasingly-strained organs.  Risking an explosion, you remove one hand and place it on your lover's right nut - it has to be at least the size of a melon, now!  You stroke the taut skin, feeling its firmness under your fingers, imagining you can hear the cum churning around inside of it.");

	outputText("\n\nLoppe gasps raggedly, trying to recapture her breath.  \"<i>Please... you have to let me go.  It hurts!  I-I need to cum!  If you keep holding me I'm going to explode... ah!  No!  Here it comes again!</i>\"  She warns as you feel her rock hard shaft throb once more; yet another toe curling orgasm approaches, and you're not sure how much more she can physically take.");

	//(Low corruption, no new pg)
	if (player.cor < 50) {
		outputText("  You loosen your grip; this was supposed to be pleasurable, not painful, so it's definitely time to stop.");
		//Goto [Let Go]
		menu();
		addButton(0,"Let Go",letsLoppeGoCum);
		addButton(1,"Hold",superLoppeOrgasmDenialGo);
	}
	//(High Corruption, no new pg)
	else {
		outputText("  You suppose you could let her go... on the other hand, it might be fun to see just how big she'll get if you keep holding her in.");
		menu();
		addButton(0,"Let Go",letsLoppeGoCum);
		addButton(1,"Hold",superLoppeOrgasmDenialGo);
	}
}

//[=Let Go=]
private function letsLoppeGoCum():void {
	clearOutput();
	outputText(images.showImage("loppe-comes-after-orgasm-denial"));
	outputText("As your fingers slacken on the laquine's straining shaft, they're practically pushed away by the violent force of long-delayed ejaculation, which rockets out of her horse-cock with immense speed and volume as you back away.  For an instant you almost think like she's going to punch a hole through the wall.  She screams, both in pleasure and relief as she fountains cum like a perverted geyser.  Spooge flies through the air, spilling all over the room; you manage to avoid the brunt of it, but some droplets inevitably hit you.");
	outputText("\n\nOnce she is done, all Loppe can do is smile goofily at you, dizzy due to her explosive climax.  \"<i>Why are you spinning?</i>\" she asks, disjointedly.");
	outputText("\n\nYou look around at the room, cum dripping wetly from the ceiling, puddling inches deep on the floor... maybe her mother should have installed drains in her bedroom.");

	outputText("\n\nHaving caught her breath and recovered her senses, Loppe looks at you with a smile.  \"<i>No kidding.  I don't think I've ever come so hard before.  You really know how to get a girl worked up, don't you?  I still can't feel my toes.</i>\"  She tries to wiggle them experimentally, but if they're moving, you can't tell under the complete glazing she gave herself.  \"<i>Help me up, we should get cleaned up.</i>\"");

	//[(low corr)
	if (player.cor < 50) {
		outputText("\n\nYou nod and give her a hand to rise to her feet.  Not the brightest idea, in retrospect; she's so numb from the waist down that she promptly collapses against you and it's only your swift action that keeps her from falling.  The creamy-white liquid is now smeared all over your front, and Loppe giggles and delivers a cum-caked kiss straight to your lips.  \"<i>As fun as that was, I think I'll want to wait some time before trying that again.</i>\"");
		outputText("\n\nThe two of you manage to clean up the worst of the mess you've made, and you move to leave.  Loppe draws you into another, much cleaner, kiss before letting you go.  \"<i>See you later, sugar!</i>\"");
	}
	//(high corr)
	else {
		outputText("\n\nYou hold out your hand with some distaste and, when she takes it shakily, pull her to her feet.  She wobbles on them and promptly collapses - only your swift action keeps her from crumpling against you.  The pool of viscous semen on the floor splashes sluggishly as she lands tits-down in it with a grunt.  \"<i>Holy... can't even walk right!  As fun as that was, I think it'll be some time before I feel like another.</i>\"");
		outputText("\n\nLaughing, you move around her and out the door, letting her watch and groan helplessly as you hold it open long enough for her mess to ooze partway into the previously-clean hallway.");

		outputText("\n\n\"<i>Fuck...</i>\"");
	}
	//set LoppeDenial to 4
	flags[kFLAGS.LOPPE_DENIAL_COUNTER] = 3;
	dynStats("lus", 30+player.lib/10, "resisted", false);
	flags[kFLAGS.LOPPE_TIMES_SEXED]++;
	doNext(camp.returnToCampUseOneHour);
}
//[=Hold=]
private function superLoppeOrgasmDenialGo():void {
	clearOutput();
	outputText(images.showImage("loppe-comes-after-moar-orgasm-denial"));
	outputText("For fear of not being able to hold her back anymore, you return both hands to tightly gripping her shaft.  Tears escape Loppe's eyes as she's denied yet again.  \"<i>Stop...</i>\" she says meekly.");

	outputText("\n\nYou give her shaft a few more strokes, prompting another chain reaction of orgasms, and another, and another.  By the time you've stopped drawing them out, Loppe's balls look so inflated you doubt she'd be able to touch the floor, were she to stand.  With one last stroke, you release and watch as the laquine gasps, screaming soundlessly as a veritable eruption of cum splashes violently against the wall, instantly painting the entirety of the room cum white, including both occupants.  But one layer is not enough... the obscene volcano of jism continues to paint in layer after layer, and you're unable to protect anything but your eyes from the white rain showering your naked form.");

	outputText("\n\nBy the time Loppe is finished, her balls have returned to normal size and her shaft hangs limply against her thigh.  You try shaking her, but fail to get any response save for a groan.  It seems the climax was so intense she's passed out.  You laugh at the results of your little experiment, and wonder what the laquine's reaction will be.");

	outputText("\n\n\"<i>[name]... can you come closer... ?</i>\" you hear the sleepy voice of Loppe call after a few minutes.  Wondering what she wants, you lean in to hear.");

	outputText("\n\nLoppe surprises you by wrapping both arms around your neck and pulling you in for a passionate kiss.  \"<i>That was so intense, I probably lost a few pounds!</i>\" she exclaims, laughing happily.");

	outputText("\n\n\"<i>Wow... I mean, I still can't feel my toes.  You really put me out of commission with that one.  Simply amazing!</i>\"");

	outputText("\n\nLoppe looks seriously at you.  \"<i>I <b>was</b> in pain, though, you ass!</i>\" she exclaims.  \"<i>I mean... sure the end results were amazing, but by Marae did it hurt - it felt like my balls were going to explode.  I am absolutely not going to do that again for a while.</i>\"");

	outputText("\n\nWell, that doesn't mean never, does it?  Loppe rubs her chin and rolls her eyes.  \"<i>Yeah... okay.  I did like it... despite the pain.  You're lucky I like you as much as I do.  I'd be kicking anyone else's ass... as soon as I got feeling back in my feet.  Now be a gent and help me up; we need a bath.  And no funny moves during the bath, or I'll tell mom!</i>\"  She raspberries you mockingly.");

	outputText("\n\nYou sigh reluctantly; she's a real spoilsport.  \"<i>And that's exactly why you love me.  I keep you wanting more.  Now, onwards!</i>\"");

	//[(med-high corr)
	if (player.cor >= 66) outputText("\n\nYou leave her assertion unanswered and haul your childish date to the bath; soon, the two of you are clean enough that you can dry yourself off and pull your clothes on.");

	outputText("\n\n\"<i>Bye, sugar!");
	if (player.hasCock()) outputText("  Maybe next time I'll be the one to give you a bit of a holdout!");
	outputText("</i>\"");
	//leave, set LoppeDenial flag = 7
	flags[kFLAGS.LOPPE_DENIAL_COUNTER] = 5;
	//(very high corr)
	if (player.cor >= 90) {
		outputText("\n\nYou laugh softly, staring at her with hooded eyes.  \"<i>I just squeezed your dick until your balls inflated so much that they hurt, then kept torturing you until you came so hard you screamed and fainted.  What makes you think I love you?</i>\"");

		outputText("\n\nLoppe looks hurt and, for once, is at a loss for words.  To torment her further, you give her a smile just warm enough to make her think you might be joking, but not open enough to assuage her doubts.  You leave her like that, confused in a pool of her own wasted seed, as you step out of her room to take advantage of the clean bath first.");
		flags[kFLAGS.LOPPE_DENIAL_COUNTER] = 10;
		//leave, set LoppeDenial flag = 14 (an extra 7 for being a jerk)
	}
	dynStats("lus", 30+player.lib/10, "resisted", false);
	flags[kFLAGS.LOPPE_TIMES_SEXED]++;
	doNext(camp.returnToCampUseOneHour);
}


//Boobjob Loppe: (edited, pending boob size decision)(C)
//Needs DD-(cup) boobs.
private function boobjobLoppe():void {
	clearOutput();
	outputText(images.showImage("loppe-give-her-a-titty-fuck"));
	outputText("You contemplate your options, unthinkingly rubbing your breasts.  As you do so, you notice your lover is observing your hands very keenly.  With a grin, you grope your tits and ask if Loppe likes your display.");
	outputText("\n\n\"<i>Jiggly... wait, what?  What was the question?</i>\"");

	outputText("\n\nSlipping one finger into your prodigious cleavage, you pump it in and out suggestively, watching Loppe's eyes widen.");

	outputText("\n\n\"<i>I love this plan!  I'm excited to be a part of it!</i>\"  She jumps in excitement, letting her horse-cock bob and spill a few dollops of pre.  \"<i>Come on, come on; boobies!</i>\"");

	outputText("\n\nYou laugh inwardly - if this happens, it's going to be at your pace.  That said, \"<i>come on boobies</i>\" is definitely on the agenda.  You kneel before her, bringing your bountiful bosom closer to her achingly hard shaft.  \"<i>Oooh... I can already feel them!</i>\" she chirps, still hopping in place.");

	outputText("\n\nYou cluck your tongue.  \"<i>Stop that and behave, or I'll put them away.</i>\"");

	outputText("\n\n\"<i>But... but... aww, fine.</i>\"  Loppe settles down, leaning back and supporting herself on her hands to allow you free access, while her shaft throbs and drools pre.");

	outputText("\n\nThat's better.  Gently lifting the mismatched horse-dick, you settle it gently into your cleavage.  She's so warm and already so wet; running a hand up and down her length, you slick your tits and her cock alike with the copious amounts of precum bubbling and oozing from her length.");

	outputText("\n\nLoppe can't resist humping you slightly.  \"<i>Sugar, you're so soft...</i>\"  Smiling wanly, you grab your [chest] and do your best to wrap around her horse-dick, pinning the shaft inside.  \"<i>I love it!  Don't stop!</i>\" the girl moans in pleasure.");

	outputText("\n\nEmboldened, you clasp your breasts firmer together and start to rise and fall, slowly scraping your " + player.skin() + " up and down the half-breed's prick.  It feels so hot and firm against your chest, growing increasingly damp as Loppe oozes gouts as voluminous as the cumshots of ordinary men, making your breasts and her prick alike equally slippery and enabling you to stroke her faster and faster. \"<i>K-keep that up and I'm gonna shoot anytime,</i>\" Loppe groans, trying to hump into your cleavage.");

	//[(Normal/Naga tongue)
	if (!player.hasLongTongue()) outputText("\n\nYou bend your head and lean down, letting your tongue flick out of your lips and slide gently across the flared head of Loppe's horse-prick, seductively tasting the sweet-salty flavor of her pre.  \"<i>Ah!  Hmm... I seriously hope you like the taste, because you're getting a faceful anytime now!</i>\"  Loppe moans.");
	//Demon/Dragon:
	else outputText("\n\nYour inhumanly long tongue slithers out of your mouth like a tentacle, swiping itself playfully across Loppe's flare to give you a taste of sweet and salty precum before you send it questing down, curling in a spiral pattern around her long shaft and burrowing into your cleavage to lap and squeeze and massage, filling your senses with the tang of her overheated cock.  \"<i>D-damn, sugar!  Such a wonderful tongue you have,</i>\" she groans, equine member throbbing against your hold.");

	outputText("\n\n\"<i>C-cumming!</i>\" is all the warning you get before Loppe's slit opens wide and she begins spewing rope upon rope of hot jism.  You ");
	if (player.hasLongTongue()) outputText("retract your tongue into your mouth and ");
	outputText("barely shut your eyes in time, continuing to pump and squeeze with your tits even as your lover paints your upper body white in fresh spooge.  You can't see anything; all you know is the wet splashing of cum against your face, the intimate smell of hot, musky cock-cream assaulting your nose with the subtlety of a battering ram, Loppe's ecstatic moans and gasps and howls filling your ears.  Finally, the deluge stops; your hair is soaked in spunk, dripping wetly onto the floor, and you shake your head to try and fling off some of the worst of the gooey gunk, allowing you to look the panting girl in the eyes.");

	outputText("\n\nShe looks back with the hungry stare of a predator eyeing a morsel.  \"<i>Boobies!</i>\" Loppe yells as she pounces you, trying to force you backward onto her bed.");

	//[(non-horse and str < 40 or horse and str < 20)
	if ((player.str < 50 && !player.isTaur()) || (player.str < 30 && player.isTaur())) {
		outputText("  Struggle as you may, you're powerless to stop the drooling laquine as she sends you crashing down on her bed.  The whole piece of furniture shakes ominously with the force of your impact, and for a moment you think it will break apart.");
		outputText("\n\nLeft a bit dizzied after this sudden turn of events, you yelp in surprise when a rock-hard, hot, throbbing horse-cock is shoved between your [chest].  Loppe works over your boobs like a ravenous beast, not caring that she's spewing pre all over your face and even sometimes forcing you to taste her as she pushes her shaft up your mouth.  \"<i>So soft... so hot...</i>\" she moans as she continues to drool in lust.");

		outputText("\n\nYou open your mouth, about to say something - and Loppe promptly shoves her cock-head inside.  With a gag and a splutter at the sudden intrusion, your hands dart to her shaft, but she only feeds it deeper inside of you - she stops, however, before she enters your throat, letting you taste the cum still dripping from her flare.");

		outputText("\n\n\"<i>Tittyfuck AND oral!?  You're the best!  You're making me a very, very happy girl!</i>\"  Loppe exclaims, oblivious to any protests you might make as she begins rutting you even harder.  \"<i>I got a present coming for you riiiight now!  Ah!</i>\"  Groaning sharply, she fills your mouth with huge ropes of spunk, and you have no choice but to swallow...  Without any way to struggle, you do your best to lick at the part of her cock that's in your mouth, ");
		if (player.tongueType > TONGUE_HUMAN) outputText("looping your inhuman tongue around it and stroking for extra stimulus even while ");
		outputText("grabbing your breasts and squeezing the horsemeat between them.  The sooner you help her get over this frenzy, the sooner she'll get off of you... hopefully.  \"<i>Ah, sugar!  I knew you liked it rough!</i>\" your suddenly forceful lover shouts, ominously.");
		outputText("\n\n<b>Many orgasms later...</b>");

		outputText("\n\n\"<i>Aaaah...</i>\"  Loppe sighs, shooting her last (you hope) orgasm down your throat.  Finally, after what seems like an eternity, she withdraws from your mouth and falls nervelessly to lie beside you.  \"<i>Hmm... you look so sexy when you're full, sugar,</i>\" she idly comments, rubbing your amazingly distended belly and making her many mouthfuls of cum swish and churn underneath the skin in response to her motions.");

		outputText("\n\nAny pithy retorts you might have had are drowned out by a belch hard enough to make Loppe's ears flap about as if blown by a strong breeze, the laquine wrinkling her nose as she gets hit in the face by the fumes of your cum-soaked breath.  \"<i>Err... did I do that?</i>\" she asks, smiling nervously");
		if (silly()) outputText(".  You can't help but think of Family Matters");
		outputText(".  You simply nod and groan, hands cradling your distended gut.  Loppe snuggles up against you, rubbing your bloated midriff.  \"<i>Sorry about that... hmm, how about we just cuddle and rest?</i>\"");

		outputText("\n\nWith one last belch for confirmation and possibly chastisement, you allow the herm bunny-hybrid to snuggle up against you, close your eyes, and try to doze off whilst ignoring the complaints of your over-stretched stomach.");
		//goto Two hours later...
	}
	else {
		outputText("  You hold the laquine's arms and force her onto the floor; she lands with an audible \"<i>oomph</i>\" and you grin as you hold the eager herm down.");

		outputText("\n\n\"<i>I need more!</i>\" Loppe cries.  She does, doesn't she?  Well, you're happy to give it to her.  You lift her knees over her head and begin pumping her shaft, forcing her to take a paint-job of her own as she groans and moans in her second orgasm.  Playfully, you ask how she likes being at someone else's mercy in the bedroom; you're not going to let her stop until she's soaked in her own spunk - what does she think of that?");

		outputText("\n\n\"<i>Oh, no!  Please don't make me soak - Ah! myself!</i>\"  Loppe says sarcastically, moaning as she shoots another rope of cum on her breasts.  \"<i>Please!  Please!  Don't make me soak in jism!</i>\"");

		outputText("\n\nOh no; this is her punishment for trying to manhandle you - you offered her a boobjob, you gave her a boobjob; just what did she think she was trying to do when she attempted to push you into bed?");

		outputText("\n\n\"<i>It's just that... you looked so sexy all covered in cum that I couldn't help, ah... myself, sugar.  I was just going to give you another facial,</i>\" she claims, panting and moaning at your treatment.  Adding your other hand, you speed up the tempo; Loppe's just too horny for her own good.");

		outputText("\n\n\"<i>I might be planning on doing you in the mouth too... but just a little...</i>\" she groans as she shoots another rope.  \"<i>Ah... can you let me go and give me another boobjob?  Please?</i>\"");

		outputText("\n\nThe only answer you give is to continue pumping with both hands.");

		outputText("\n\n<b>Many orgasms later...</b>");

		outputText("\n\nWith one last pump and a groan from the glazed laquine, she shoots the last rope of cum straight into her face... right on top of the last five minutes' worth.  She's panting heavily now, and you are, admittedly, getting tired of holding her in this position.  As you step aside, the herm's lower body hits the floor with a splat, landing in the pool of the laquine's own making.  \"<i>Hmm... that was great, sugar,</i>\" Loppe drawls raggedly, reaching up to swipe some cum from her face.  She certainly looks like she enjoyed herself; eying her totally cum-drenched form and the ankle-high puddle that covers the floor of her bedroom, you wonder how her mother would react if she saw this mess...");

		outputText("\n\n\"<i>Hey, sugar?  Mind cuddling with me?  Just a bit?</i>\" she asks, still soaking in her puddle of cum.  She's all slimy and sticky, and your reaction must be apparent in your face.  \"<i>Aww.... come on?  It's not like you're in a better state yourself...</i>\"");

		outputText("\n\nLooking at your own " + player.skinFurScales() + ", now off-white from the glazing she's given you inadvertently, you concede the point to yourself.  Still...");

		outputText("\n\n\"<i>Pleaaase?</i>\" she asks, giving you her best doe eyes.");

		//[(corr >= 60)That's for babies.  Pulling the sheet off of Loppe's bed, you wipe the crust off of your face and chest, then let the stained fabric drop to the floor.  You take one of the stuffed dolls off of her shelf and, raising an eyebrow, toss it at her; her eyes widen as it hits her squarely in the sopping, white tits.  "Cuddle with that.  I need to go."
		//"You jerk, [name]; now I have to wash this!"
		//Laughing, you blow her a kiss and make your way out of the house.
		//end scene
		outputText("\n\n");
		if (player.cor >= 60) outputText("You don't really feel like it, but you figure you had better humor the greedy herm if you want to keep fucking her whenever you like.  ");
		outputText("Oh, well... you reach down and heft the surprised hybrid off of the floor and onto her spattered bed, then slide yourself into it as best you can, wrapping your arms around her.  She hugs you back, then yawning widely.  \"<i>Naptime...</i>\"");
		outputText("\n\nGiven she seems unlikely to let you go, you decide you may as well enjoy a brief doze too.");
	}
	outputText("\n\n<b>Two hours later...</b>");
	outputText("\n\nYou have the distinct feeling that someone is licking your [nipples]... and when you finally open your eyes, you're introduced to a pair of rabbit-like ears.  Loppe looks up, licking a stray dollop of cum from her nose.  \"<i>Hey, sleepyhead!  I was just finishing cleaning you up.</i>\"");
	outputText("\n\nYour face must be showing thoughts, because she looks away defensively.  \"<i>It's not like I licked all of you clean...</i>\"  Loppe protests.  \"<i>Okay... I might have done most of you, but only because you're sweet and I don't mind tasting myself...</i>\"");
	outputText("\n\n\"<i>Anyway, I set your [armor] over there.</i>\"  She points to a chair nearby.   You thank her and pick yourself out of bed ");
	if ((player.str < 50 && !player.isTaur()) || (player.str < 30 && player.isTaur())) outputText("- while your stomach is still heavily swollen and gurgles in protest, it's not bad enough to impair you - ");
	outputText("before going over and dressing yourself.  Loppe waves goodbye to you as you head out once again.");

	flags[kFLAGS.LOPPE_TIMES_SEXED]++;
	player.slimeFeed();
	player.orgasm();
	dynStats("tou", .5, "lib", .5, "sen", -4);
	doNext(camp.returnToCampUseFourHours);
}

//Leave (edited)
private function beATeaseAndLeaveLoppeAfterSexInvite():void {
	clearOutput();
	outputText(images.showImage("loppe-teaze-and-leave"));
	outputText("Despite the hybrid beauty standing stark naked before you, you decide that you aren't in the mood after all.");

	outputText("\n\nLoppe shoots you a look of annoyance and disappointment.  \"<i>Well, if you really don't want to do anything, there's nothing I can do.  But nevertheless, that was very mean of you, [name]; teasing a poor, innocent laquine with the promise of sex...</i>\"  She pouts exaggeratedly, possibly hoping you'll relent.");

	outputText("\n\nCatching on to her playful tone, you ask exactly what innocent laquine you were teasing.");

	outputText("\n\n\"<i>Are you implying I am not innocent?</i>\" Loppe gasps in mock hurt and looks at you accusingly, before caving in and laughing it off.  \"<i>Ok, maybe I'm not.  But in this case, do you think you could at least give this pervy laquine a kiss?</i>\"");

	outputText("\n\nYou smile at her, and step forward to plant a chaste, gentle kiss on her lips.  You half expect the laquine to grab you and start feeding you her tongue, but she simply closes her eyes and pouts, hoping you'll take that step instead.");

	outputText("\n\n\"<i>You're no fun, [name],</i>\" she gripes, when you don't.  \"<i>Hopefully next time you'll be willing to do a lot more than just give me a peck on the lips.</i>\"");

	outputText("\n\nShe smiles wanly at you and walks to her closet, dressing herself in a comfy bathrobe.  \"<i>[name], sorry for being a bad hostess, but can you show yourself out?  I kinda need to take care of a... thing.</i>\"");

	outputText("\n\nYou nod your head, quietly redress yourself, and exit.");
	dynStats("lus", 5+rand(5));
	menu();
	addButton(0,"Next",telAdre.telAdreMenu);
}

//Fondle&Tease (rewritten and edited)(C)
//req LoppeChat > 1
private function fondleAndTease(output:Boolean = true):void {
	if (output) {
		clearOutput();
		outputText("You lean in over the table and tell Loppe you'd like to talk about her.  She looks vaguely confused.  \"<i>Well, I already told you about everything I can think of.  Was there something you wanted to explore in more detail?</i>\"");

		outputText("\n\nSomething like that.  You smile and surreptitiously slip your free hand underneath the table to grab the bulging crotch of her tight shorts, gently squeezing the sheathed horse-prick.  \"<i>I thought we could explore this subject a bit more thoroughly.</i>\"");

		outputText("\n\nLoppe gasps as you massage her rapidly erecting shaft.  She bites her lower lips to stifle a moan and looks at you through half-lidded eyes.  \"<i>Oh, really?  Keep talking... I'm listening.</i>\"");

		outputText("\n\nYou continue to stroke and caress the laquine's masculine equipment through the cloth of her shorts; blood starts to outline her veins against its surface.  \"<i>You make most of your income from dancing... but I saw the way you looked at me from the stage, and I know how high you say your libido is.  Be honest; how many times have you gotten hard from some sexy thing in the audience and given everyone a glimpse while performing?</i>\"");

		outputText("\n\n\"<i>Ahh... m-maybe a few times,</i>\" Loppe says nervously as she closes her eyes and slumps in her seat to give you better access.");

		outputText("\n\nYou grin in amusement, even as your hand continues to work.  Must be hard to conceal... a great big dirty horse's cock.  A shaft that's literally fit for a stallion, long and thick, slapping meatily against her thighs when she dances, with great big cum-filled balls eager to unload into the cute faces and cunts in front of the stage.  Wouldn't be surprising if some of her shows ended with audience participation.  \"<i>N-no, I wouldn't...</i>\" Loppe moans.  \"<i>Not in public... it's illegal.</i>\"");

		outputText("\n\nYour words are clearly getting to her, but it's still a shock when you hear the sound of a seam ripping.  Excitedly, your fingers dance up and down the constricted shaft, dabbling mischievously at the growing dampness as precum begins to trickle from her slit.  Another rip sounds, and this time Loppe notices.  With a gasp and start she scoots back on her chair, almost falling on the floor; she looks at the damp spot on her crotch and quickly moves her hands to cover the enormous bulge that has formed in her tight shorts.  The sound of yet another bursting seam has Loppe scrambling in a panic to keep her straining erection under control.  She turns to look at you with urgency and lust.");

		outputText("\n\n\"<i>Can... can you do a girl a favor?  If this keeps growing it's going to rip my shorts apart!  And right in front of everyone too!  Can we go back to my place and, ah... do something about this little problem of mine?  I'll walk behind you.</i>\"");

		outputText("\n\nYou contemplate your options; you could just run away and leave her to calm down.  On the other hand, you could help.  But, take her home?  Why?  It might be more fun to see if you can keep stroking her until she busts her pants <i>and</i> her nut.  Or else you could be nice and cut her a deal under the table.");
	}
	//[Suck] [Handjob] [Kiss&Run]
	menu();
	addButton(0,"Suck",teaseLoppeNSuck);
	addButton(1,"Handjob",teaseLoppeNHJ);
	addButton(2,"KissNRun",teaseLoppeKissRun);
}

//Handjob (edited)(C)
private function teaseLoppeNHJ():void {
	clearOutput();
	outputText("You know exactly how to help her with her problem.  Loppe looks at you and gives a quizzical little smile.  \"<i>Uh... yeah, I kind of know how you can help me too.  Why do you say that?</i>\" She asks, clearly baffled and obviously expecting you to lead her out of the cafe and back to her place for some quick nookie.");
	outputText("\n\nYou smile mischievously as your hand darts under the table to bat her own away and give her wild stallion a little pinch.  \"<i>W-what are you thinking?  We're exposed here!</i>\" she yelps, sounding surprisingly shy for someone normally so confident in the bedroom.  \"<i>Y-yes, I'd like being touched more, but... not here!  There are people all around!</i>\"");

	outputText("\n\nShe squeals from your next caress, then nervously slaps her hand over her mouth, looking aghast.  \"<i>As long as you keep to yourself, no one is going to know,</i>\" you reply.  Another stroke to her obscene bulge prompts one more seam to burst.");

	outputText("\n\nLoppe swallows nervously, then nods.  \"<i>A-alright, I guess you have a point.  Just... don't do anything too embarrassing?  Please?</i>\" she begs.  You smile and nod at her, then reach inside her shorts to poke at her drooling cumslit, spreading her pre along her sensitive flared tip.");

	outputText("\n\nLoppe trembles, shaking with a cocktail of fear and arousal, biting her lip to keep from whimpering at your ministrations.  Her equine shaft is rapidly stiffening, sheath peeling back as it thrusts itself harder and harder against her shorts - they look like they'll give out anytime now and she's still not even at half-mast, yet.");

	outputText("\n\nThis, of course, is when one of the staff chooses to make his presence known.  \"<i>Excuse me?  Is everything alright?</i>\" he asks, calmly.");

	outputText("\n\n\"<i>I... yes!  Everything's fine!</i>\" Loppe shrieks nervously.  \"<i>I just worked out too hard!</i>\"");

	outputText("\n\nHe politely ignores her overloud voice.  \"<i>Ah, yes, we get that from time to time.  You need to take things easier, miss.  A healthy body is all well and good, but you don't need to get so wound up.</i>\"");

	outputText("\n\n\"<i>I agree,</i>\" you announce.  \"<i>You shouldn't work out so hard, especially when you're stiff.</i>\"   you smile and give her drooling flared tip another soft pinch, gently rubbing around her pre-soaked cumslit.");

	outputText("\n\nLoppe winces, her horse-prick experiencing a surge of motion that sends yet more seams to an untimely grave.  The staff looks puzzled.  \"<i>Did either of you hear that? It sounded like something ripping...</i>\" he notes.");

	outputText("\n\n\"<i>I didn't hear anything.</i>\"  Loppe frantically replies, trying desperately to keep her voice level despite her obvious enjoyment of the way your fingers are dancing across her sensitive, engorged manhood.");

	outputText("\n\n\"<i>She probably just needs time to cool off and recover,</i>\" you say, reaching further ahead to fondle Loppe's now-exposed shaft.");

	outputText("\n\nThe laquine bites her lip, drawing a tiny bead of blood, but otherwise manages to keep herself remarkably in control as she agrees with you.  The server merely nods his head in a slightly bemused way and departs.  Once she's certain he's gone, Loppe hisses, \"<i>Are you trying to get us caught?  This is a respectable gym, not the Wet Bitch!  They'll throw us both out if they find out you're giving me a handy under the table!</i>\"");

	outputText("\n\nYou heave an exaggerated sigh and pull your hand away, telling Loppe that you were really looking forward to some quality time with her, but if she wants you to stop, you'll oblige.  Sitting back, you wait to see her reaction.");

	outputText("\n\nShe lowers her eyes and looks sheepish.  \"<i>I... ah... I didn't say I wanted you to stop,</i>\" she admits.  \"<i>Though... just how do you think one handjob's going to calm me down?</i>\" she asks.  \"<i>If anything, it'll just whet my appetite.</i>\"");

	outputText("\n\n\"<i>We'll see; if you fall off a horse, you get right back on,</i>\" you counter.");

	outputText("\n\nThe laquine's eyes widen and she swallows nervously; you can actually hear her gulping down the lump in her throat.  \"<i>Ah... be gentle?</i>\" she nervously laughs.");

	outputText("\n\nAs you fondle, she squeals softly, wriggling in her seat as precum bubbles and spurts from her erect shaft, now jutting through the hole torn in her shorts.  Her hands latch onto the table, fingernails visibly biting into the wood as she tries to control herself; her arousal is undeniable at this point.  Now that you have gotten your hands nice and slick, it's time to get to the task at hand.");

	outputText("\n\nYou hold Loppe's erect shaft in a firm grip and slowly stroke; she spurts copious amounts of pre with each pump, and all it does is get your hand and her shaft even slicker, helping you achieve an even faster rhythm. Every once in awhile your thumb passes over her flared tip, massaging her distended slit, coaxing more out of her.  The laquine's visibly struggling to keep silent at your ministrations, and the steady deluge of fluids means you barely need to hear her whisper, \"<i>I... I'm gonna...</i>\" to know she's on the verge of climax.");

	outputText("\n\nWith one final stroke on her equine pride, you feel it throb.  But, with a mischievous grin, you take firm hold of the base of her shaft, effectively closing her off and preventing even a single drop from escaping.");

	outputText("\n\n\"<i>W-what are you doing?</i>\" Loppe gasps.  \"<i>Oh, it burns - please, let me go, let me cum!</i>\"  You think you can actually hear more fabric tearing as her denied orgasm backs up inside her and her balls start to physically swell, the pent-up fluid building and building in pressure...");

	outputText("\n\nLoppe manages to voice a strangled groan, even as she thrusts her hips into your grasping hand, dragging her cock through your clenched fingers in an effort to make you release her.  You quickly let go of her shaft to grab her huge balls, fondling them hard enough to push all their liquid burden up and away.");

	outputText("\n\nThe girl gasps audibly as, finally given permission to release, she proceeds to cum like a bomb.  Her cock-head flares wide, slit dilating almost to the point you could fit your fingertip inside, as a thick stream explodes from her overstressed balls and slams into the underside of the table.  You can hear the wet gurgling, glooping, splashing sounds as it sprays on the table and showers your [legs] from the force of impact.  The booth is filled with the heady scent of sexual musk and the table visibly shudders as she ejects gout after gout after gout against it.  Finally, with a groan of blissful release from the bunny-girl herself, it trails away into a wet pattering noise, spurting into the puddle of jism underfoot and drooling heavily down the length of her still-half-erect cock.");

	outputText("\n\nLoppe sighs heavily, slumping back in her chair and giving you a dreamy stare.  \"<i>Oh, man, what a rush...  I'm actually going soft.  Though, how are we going to hide the fact we're soaked from the waist down in bunny-stallion spunk?</i>\" she asks, batting her eyes at you.");

	outputText("\n\nYou look at a nearby napkin dispenser and ask, \"<i>How many napkins do you think there are in that?</i>\"");

	outputText("\n\nLoppe giggles at you; you clean yourselves off as best you can and then sneak out of the gym.  You're pretty sure people notice, though; after all, you both smell like you've been beating off for ten hours straight.");

	outputText("\n\nA small voice sounds behind you as you exit.  \"<i>Oh my!  Look at all this cum!  What a waste... not to worry though!  I know just where to store it!</i>\"");

	//If FertileLoppe flag is not active, no special effects
	//If FertileLoppe flag is active, PC who can become pregnant who uses the Goblin Machine at the Gym will become pregnant with Loppe-daughter if they use it within a week of playing this scene
	dynStats("lus", 10+player.lib/5);
	doNext(camp.returnToCampUseOneHour);
}

//Suck (edited)(C)
private function teaseLoppeNSuck():void {
	clearOutput();
	outputText("You lean over the table and give the laquine a kiss.  Confused, but not displeased, Loppe eagerly returns it, then watches as you break the lip lock and start to slide yourself under the table.  \"<i>Umm... sugar?  What are you doing?</i>\"");

	outputText("\n\nYou stop in your tracks and smile at her; she needs to vent some steam, so you're just going to give her an outlet.  Loppe giggles.  \"<i>Okay!  I'd love that, but there's no need for you to duck under the table; let's go back to my house... you're going to have to walk ahead of me though, since I have a pickle to deal with here.</i>\"");

	outputText("\n\n\"<i>Don't wanna,</i>\" you reply, childishly.  You reach out and caress her swollen cock in emphasis, running your tongue briefly around your lips and giving her a hint as to what you have in mind.");

	outputText("\n\nLoppe shudders at your touch; her equine member jumps at your caress, eager to be freed of its fabric prison, but she protests.  \"<i>If we do that here and someone catches us, we're going to be fined!  Not to mention we might get kicked out of the gym for good!  And that's in the best case; we could go to jail if the guard they call in feels like it!</i>\"");

	outputText("\n\nWell, if she stops kicking up a fuss, nobody will know.  With that, you slide yourself under the table before she can say anything more.  Loppe tries to stop and push you away with a foot, but after a quick tickle on her sole she quickly retracts it, unintentionally spreading her legs for your perusal.");

	outputText("\n\nDespite her flustered embarrassment at what you're doing, it's evidently not enough to turn her off; her crotch is swollen from the stiffening horse-cock concealed beneath.  The stress it's putting on her seams is considerable; they've ruptured enough to create a small hole, giving you a tantalizing glimpse of the prick beneath.  You lean in close and inhale deeply, savoring her unique musk, with the added piquancy of sexual anticipation to spice it further.");

	outputText("\n\nYou eagerly investigate, roughly groping and fondling her as you try to find a zipper or flap, but she's wearing a one-piece pair of shorts.  Well, she can get replacements.  Placing your face against her crotch, you deliver a well-place bite to sever some of the most inconvenient stitches.");

	outputText("\n\n\"<i>S-sugar!</i>\" Loppe gasps, as her sizeable horse-prick all but springs forth, nearly hitting you in the face.  You gaze at her pre-oozing, flared tip; it throbs in the air, high above the hole you just helped it tear; beads of pre slide down its length.  Gazing up at her, you see she's actually biting her nails, attempting to stifle any sounds that might draw attention to her.  She looks around to make sure no one is looking and whispers, \"<i>Can't we at least get to the bathroom or the showers?</i>\"");

	outputText("\n\nYou tap your lips as if considering her plea but give her a little peck, prompting another happy bead of pre to pop out of Loppe's dick, then shake your head.  You roll your tongue out and then lean in, giving it a long, wet, sloppy lick, slowly lavishing your affection across the hot, throbbing flesh, savoring the salty tang.  Once, and then again, just as slowly and delicately as before, trying to wring a reaction from the manhood you're ministering to.");

	outputText("\n\nLoppe's toes curl and her nails dig on the table above; she pants with barely contained lust and swallows audibly, looking down at you.  \"<i>O-ok, you win.  I don't care if you want to do this under the table, as long as you do something.  I really need this!</i>\"");

	outputText("\n\nWith a little wriggling, you manage to slip your fingers down through the same hole her erection is jutting through, allowing you to begin to gently stroke her balls, your touch light as a feather.");

	outputText("\n\n\"<i>I thought you said you wanted to blow me?  Why don't I feel your lips wrapped around my shaft?</i>\" Loppe asks, desperation apparent in her voice.  You laugh starkly; a little foreplay doesn't hurt.  Giving her balls a flick and poking at her clit causes Loppe to gasp, \"<i>Oh, but it hurts!  It hurts a lot!  Can't you see how hard I am!?</i>\"");

	outputText("\n\nLoppe's legs grab you under your arms, pulling you closer to her tool.  \"<i>Please, sugar.  Stop teasing me and help me.  You have no idea how badly I want to put my dick between those wonderful lips of yours!</i>\"");

	outputText("\n\nWith a smile to yourself, you oblige");
	if (player.tongueType > TONGUE_HUMAN) outputText(", inhumanly long tongue looping out to coil wetly around the length");
	outputText(".  You suckle gently, letting the salty tang of hot spunk wash over your tastebuds, and then start to gulp and swallow your way down her prick's sizable length.");

	outputText("\n\n\"<i>Ah!  Oh, yes!  That hits the spot!</i>\" Loppe cries in relief.");

	outputText("\n\nYou smile around your sizable obstruction and back up before slurping and gulping your way down again.  Her sheer length proves something of a hindrance, and her flare butts irritatingly against the back of your throat before you finally force it down and feel her girthy cock stretching your throat as you swallow inch after inch.  Finally, amazingly, you've managed to swallow all 14 inches of it, your nose pressed into her crotch, your nostrils filled with the scent of her over-aroused cunt. Though you can't move too far, you still manage to bob your head up and down, to an extent, eager to help push her over the brink.");

	outputText("\n\nLoppe's panting becomes even more audible and she begins humping against you each time you bob your head.  \"<i>Oh, sugar.  Your mouth feels heavenly; it takes all my self control not to take you right here and now...</i>\"");

	outputText("\n\nYou focus on sucking what's in your mouth and humming, using the vibrations of your throat around her horse-meat to drive her to the breaking point.");

	outputText("\n\nLoppe squeals, perhaps a bit too loudly, and despite the fact that she immediately clamps her mouth shut, holding it closed with her hands, the damage is already done.  Two pairs of hoofed feet clop along the floor of the cafeteria and a familiar voice says, \"<i>Loppe?  I heard someone yelp over here; did anything happen?</i>\"");

	outputText("\n\nLoppe's legs close around you, painfully holding you under the table as she leans over it to hide your face.  From your vantage point you see a familiar set of clothes... and breasts. It seems that nice centauress from the reception was passing by...");

	outputText("\n\n\"<i>Oh, t-that was me!  Sorry to startle you,</i>\" Loppe grins, nervously.");

	outputText("\n\n\"<i>Aha?  Must be why the table's shaking, too.</i>\"  The centauress begins bending over, and before Loppe can protest she spots you, tightly wrapped between Loppe's legs with your mouth full of laquine-dick.  You give her a little finger-wave, and the centauress grins at you from above her massive cleavage.");

	outputText("\n\n\"<i>I see.  Since I'm not working right now, I won't say anything; but don't let me catch you two in displays like this while I am, okay?</i>\"  The centauress walks away, giggling.");

	outputText("\n\nLoppe swallows.  \"<i>Okay... thanks.</i>\"  She relaxes.  Though you can't see her face right now, she's probably as red as a pepper!  Before she can say or do anything, you decide that it's time to put an end to this.  You attack Loppe's cock with all the enthusiasm you can muster, calling up every trick you know to push her over the edge to climax.  You suck, hum, and slurp, feeling a constant cascade of hot pre spurting down your throat into your hungry gullet.");

	outputText("\n\nThe girl groans welcomely.  Her cock throbs, her balls churn, and her neglected pussy drenches her shorts.  Laquine-spunk spurts into your waiting mouth like a veritable hose.  With the bulk of her cock crammed down your throat and anchored by her flare, you have no choice but to gulp and swallow shot after shot, so you just relax your throat and let Loppe's overworked dick do all the pumping for you.  Gushes of cream fill you, swirling in an endless stream down into your belly.");

	outputText("\n\nEventually the thought crosses your mind that this may have been a case of biting off more than you can chew; you've surpassed feeling full to literally feeling bloated, and Loppe's still cumming.  You swallow everything she gives you, feeling the skin of your belly stretching tighter and tighter as your stomach balloons with cum.  At last, Loppe slumps in her chair, spurts one last gush of cream into your throat, and goes slack.");

	outputText("\n\nYou crouch there under the table, catching your breath and willing your stomach to stop rebelling against the inhuman load it's taken in.  Once you're confident you aren't going to be sick, you wetly pull yourself off of Loppe's cock and carefully slip the saliva-slick phallus back into her pants before awkwardly clambering back into your seat.  Your visibly bloated gut hampers you, throwing you off balance and catching against the table, but you manage to make it all the same.");

	outputText("\n\nLoppe is still slumped in her chair.  She looks at you and straightens herself, then smiles at you.  \"<i>So... did you like your cream?</i>\" she asks.");

	outputText("\n\nYou stifle a loud burp; she's definitely one flavor you'll never forget.  Loppe giggles.  \"<i>To be honest, I'm not a fan of the location.  But I enjoyed the action a lot.  Can you walk?</i>\"  Loppe blushes and grins nervously at you, then grabs your hand from under the table and slowly moves it towards her still-throbbing cock.  \"<i>Just help me get home, sugar.  I would walk there myself, but someone bit a hole on my shorts, so I'm not decent...</i>\"");
	outputText("\n\nWith a little struggle to avoid catching your cum-inflated belly on the rim of the table, you get out of your seat and offer your arm playfully to the laquine.  Instead of taking it, Loppe moves behind you and hugs you, tightly pressing her still erect horse-meat against your back.  \"<i>Okay, let's go.</i>\"");

	outputText("\n\nIt's quite awkward walking like this, and you draw a few curious stares as well as a knowing one from the centauress at the reception as you pass by the desk on the way to Loppe's house.");
	//commented lines are for expansion content
	//output refuse without making offer until expansion is implemented
	//It doesn't take long for you to arrive, once at the front door Loppe let's go and opens the door. Then turns to look at you. \"<i>Want to come in, sugar? You could use my bath... I think I left something on your back.</i>\" She smiles seductively. You reach back and sure enough, your back is wet with Loppe's pre-cum.

	//You consider your options. On one hand, the bath sounds nice, but, given the way Loppe's looking at you and her cock is throbbing, you feel that there's more to this offer than a simple bath... On the other hand though... that would mean making it back to camp covered in laquine-spunk...

	//[Accept][Refuse]
	//[=Accept=]
	//[=Refuse=]
	outputText("\n\nLoppe smiles at you, holding her cock in her hand.  \"<i>Alright then, sugar.  I'll be going in then; I have business to handle.  See you later!</i>\"");
	dynStats("lus", 10+player.lib/5);
	doNext(camp.returnToCampUseOneHour);
	player.slimeFeed();
}

//Kiss 'n' Run (edited)(C)
private function teaseLoppeKissRun():void {
	clearOutput();
	outputText("Feeling wicked, you give the bunny-girl's bulging horsecock a few comforting pats, then lean across the table and press your lips against hers.  You kiss her passionately, the relieved laquine closing her eyes and murmuring softly as she sinks into the kiss, her engorged cock literally throbbing under your fingers, but trusting you to help her find the quick release that she needs to spare herself embarrassment.");

	outputText("\n\n... Which is when you promptly pull your hand off of her strained shorts, push yourself off from the table, and back away, telling Loppe that as much as you'd like to play, you have other engagements to pursue.");

	outputText("\n\nLoppe looks at you in shock.  \"<i>H-hey!  You can't just go after getting me all worked up like this!  What am I supposed to do?</i>\" she demands, pointing to her bulging shorts under the table.");

	outputText("\n\nYou advise her to order herself something sweet, sit back, relax, and just try to cool off - it'll go down on its own.  Eventually.");

	dynStats("lus", 5+player.lib/20, "cor", .5);
	doNext(camp.returnToCampUseOneHour);
}
}
}
