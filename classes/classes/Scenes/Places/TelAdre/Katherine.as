package classes.Scenes.Places.TelAdre{
import classes.GlobalFlags.kFLAGS;
import classes.CockTypesEnum;
import classes.Appearance;
public class Katherine extends TelAdreAbstractContent{

	public function Katherine()
	{
	}

//CAPACITY: 70
//const KATHERINE_UNLOCKED:int = 398;
//const KATHERINE_DICK_COUNT:int = 399;
//const KATHERINE_DICK_LENGTH:int = 400;
//const KATHERINE_KNOT_THICKNESS:int = 401;
//const KATHERINE_BALL_SIZE:int = 402;
//const KATHERINE_TIMES_SEXED:int = 403;

private function kathCock():String {
	return NPCCockDescript(CockTypesEnum.DOG,flags[kFLAGS.KATHERINE_DICK_LENGTH]);
}
private function kathCocks():String {
	if(flags[kFLAGS.KATHERINE_DICK_COUNT] < 2) return NPCCockDescript(CockTypesEnum.DOG,flags[kFLAGS.KATHERINE_DICK_LENGTH]);
	else return NPCCockDescript(CockTypesEnum.DOG,flags[kFLAGS.KATHERINE_DICK_LENGTH]) + "s";
}
private function eKathCock():String {
	if(flags[kFLAGS.KATHERINE_DICK_COUNT] < 2) return "her " + NPCCockDescript(CockTypesEnum.DOG,flags[kFLAGS.KATHERINE_DICK_LENGTH]);
	else return "each of her " + NPCCockDescript(CockTypesEnum.DOG,flags[kFLAGS.KATHERINE_DICK_LENGTH]);
}
private function EKathCock():String {
	if(flags[kFLAGS.KATHERINE_DICK_COUNT] < 2) return "Her " + NPCCockDescript(CockTypesEnum.DOG,flags[kFLAGS.KATHERINE_DICK_LENGTH]);
	else return "Each of her " + NPCCockDescript(CockTypesEnum.DOG,flags[kFLAGS.KATHERINE_DICK_LENGTH]);
}
private function oKathCock():String {
	if(flags[kFLAGS.KATHERINE_DICK_COUNT] < 2) return "her " + NPCCockDescript(CockTypesEnum.DOG,flags[kFLAGS.KATHERINE_DICK_LENGTH]);
	else return "one of her " + NPCCockDescript(CockTypesEnum.DOG,flags[kFLAGS.KATHERINE_DICK_LENGTH]);
}
private function OKathCock():String {
	if(flags[kFLAGS.KATHERINE_DICK_COUNT] < 2) return "Her " + NPCCockDescript(CockTypesEnum.DOG,flags[kFLAGS.KATHERINE_DICK_LENGTH]);
	else return "One of her " + NPCCockDescript(CockTypesEnum.DOG,flags[kFLAGS.KATHERINE_DICK_LENGTH]);
}


//(small/moderate/huge)
private function katBalls():String {
	if(flags[kFLAGS.KATHERINE_BALL_SIZE] <= 1) return "small";
	else if(flags[kFLAGS.KATHERINE_BALL_SIZE] <= 3) return "moderate";
	else return "huge";
}
//[average/long]
//(average/long/huge)
private function katCock():String {
	if(flags[kFLAGS.KATHERINE_DICK_LENGTH] <= 10) return "average";
	else if(flags[kFLAGS.KATHERINE_DICK_LENGTH] <= 14) return "long";
	else return "huge";
}


//If player has Silver Bell key item and is at Wet Bitch when Scylla is not busy with her Addicts Anonymous group

public function catMorphIntr():void {
	outputText("\n\nThe cum-drinking nun Scylla is here, apparently resting up between one of her missions.  Recalling the last 'mission' you went on, your hand unthinkingly touches the silver bell you received from that strange herm cat-morph.  Scylla could probably help you find her again.", false);
}

public function katherineGreeting():void {
	outputText("", true);
	//[If Player chooses 'Scylla' button]
	outputText("Scylla smiles when she sees you approaching, and politely greets you.  \"<i>Why, hello, " + player.short + "; it's good to see you.  Do you need something?</i>\"\n\n", false);

	outputText("You tell her that you do, and, showing her the bell you have, you ask her if she remembers that little mission the two of you went on where she ended up ministering to those milk-hungry cats.\n\n", false);

	outputText("Scylla nods, a pleased expression and a soft blush blooming on her features.  \"<i>Yes.  Poor things... to be so hungry as to do something like that.</i>\"  Then she stops and her eyes focus on the bell, glittering with mirth.  \"<i>I take it you want to see the friendly dear who gave you that bell again?</i>\" she asks.  When you admit that is what you hoped she'd help you with, she promptly stands up, decisively.  \"<i>Well then, let's go and re-introduce you two.</i>\"  She smiles softly as she turns and walks away at a brisk pace, forcing you to hurry to catch up.\n\n", false);

	outputText("Scylla takes you on a very different route from the last time you 'encountered' the cat-morphs in question, leading you to a surprisingly seedy part of the city.  Strangely, despite all of the houses you know are empty and uninhabited from the people lost to the demons, there are myriad people around who are quite clearly vagrants.  Centaurs, dog-morphs, cat-morphs, mouse-morphs, fox-morphs, wolf-morphs, and stranger things beside - you think you see something that looks vaguely like a centaur/wolf-morph hybrid at one point.  Curious, you can't help but ask Scylla what you're doing here.\n\n", false);

	outputText("The towering nun suddenly calls out.  \"<i>I did a little asking around after that first incident.  They told me that those cats in particular like to hang out in this part of town.  In fact... there!  Hello!  Mr. Kitty?  I want to talk with you and your friends...  Maybe, if you're thirsty, I can offer you a drink?</i>\"\n\n", false);

	outputText("You're caught off-guard by Scylla's actions, but then spot a familiar-ish feline face peeking warily out from behind a corner.  You make a point of walking away from Scylla, and one of the male cats who basically mugged Scylla for her milk promptly slips out of hiding, the other eleven or so males and females quickly joining him.  The mutated nun, smiling with all three lips, is already innocently removing her habit to expose her huge, milk-filled breasts.  The cats barely hesitate before swarming towards her, pushing and shoving to be the first to start making out with her lipples and drinking their fill of creamy nun-milk.  You watch the situation dispassionately - it is, after all, a lot more voluntary on Scylla's part than it was the first time - and then pull out the silver bell, which you start idly jingling.\n\n", false);

	outputText("\"<i>...Is that really you?  You actually came?</i>\"  A voice from just off to the side sounds; quiet, hesitant, filled with hope, doubt and fear in equal parts.\n\n",false);

	outputText("Looking around, you quickly spot the lonely herm cat-morph, the reason behind your coming here.  Still dressed in her ragged clothes, her too-large shirt covers up her B-cup breasts, while her too-tight pants make her canine sheath and small balls stand out to a casual observer.  Under these calmer conditions, you can make out her eyes, a rather pretty shade of green, while her shoulder-length hair is neon pink, a stark contrast to her black fur.  Funny, you don't recall it being that color before... finally remembering that she's addressed you, you smile and agree.\n\n", false);

	outputText("She looks from you to the small milk-drinking orgy and then shyly indicates an alleyway nearby.  \"<i>Do you want to talk somewhere more privately?</i>\" she asks.  When you indicate your assent, she gives a relieved smile and leads you away.  Once you're out of sight of the other cats, she suddenly hugs you fiercely.  \"<i>I can't believe you actually came!  Oh, I dreamed that this would happen!</i>\"  She purrs, happily rubbing her cheek against you, then pulls away timidly, blushing brightly.  \"<i>I'm sorry... It's just,  I've never had anyone show interest in me before.  Not with this...</i>\"  She strokes the bulge of her puppy pecker meaningfully.  Then, a thought seems to occur to her and she turns a fearful look at you.  \"<i>You - are - interested in me, aren't you?  You didn't come here just to tell me off for liking you?</i>\"  From the tone of her voice, this last question was more a plea than an icebreaker.\n\n", false);

	outputText("You smile and assure her that you are interested... though you have to confess that more intimate conversations may have to wait for another time.  As if on cue, the happy purring of other cat-morphs reaches you in the alleyway as they start to finish up with Scylla.\n\n", false);

	outputText("The dog-dicked cat nods.  \"<i>Right.... hey, there's a pawnshop in the main street - run by a golden retriever named Oswald?  You know it?</i>\"  When you nod your head, she continues, \"<i>Well, Oswald's a pretty nice guy, he buys things I find sometimes and always gives me a fair price even though it's obvious how desperate I am; these guys don't really care whether I'm here or not, so I'll start hanging around in the back alley behind his place.  We can meet up there - is that okay with you?</i>\"\n\n", false);

	outputText("You tell her that sounds much better than needing to get Scylla to come here as a distraction each time.  The silver bell you return to her, with a coy remark that it looks better on her anyway.  Giving you a heartfelt smile, she gently takes it, then reattaches it to her leather collar.\n\n", false);

	outputText("As you walk away, she realizes something.  \"<i>Oh!  My name's Katherine!  What's yours?</i>\" she asks.  With another smile, you tell her. She mouths the name to herself, her eyes a-twinkle with happiness.\n\n", false);

	outputText("The other cats are lying sprawled in the street, swollen with the milk they've drunk from Scylla, who is merrily pulling her habit back on.  She gives you a knowing look but doesn't speak as she leads you back toward the main street.", false);
	outputText("\n\n<b>(Kath's Alley unlocked in Oswald's Pawn shop menu!)</b>", false);

	//Silver Bell key item removed
	player.removeKeyItem("Silver Kitty-Bell");
	flags[kFLAGS.KATHERINE_DICK_COUNT] = 1;
	flags[kFLAGS.KATHERINE_DICK_LENGTH] = 8;
	flags[kFLAGS.KATHERINE_KNOT_THICKNESS] = 6;
	flags[kFLAGS.KATHERINE_BALL_SIZE] = 1;
	//Player can now encounter Katherine by using the Back Alley button at the Pawn Shop
	flags[kFLAGS.KATHERINE_UNLOCKED] = 1;
	doNext(13);
}
	
//Seeing Katherine
public function visitKatherine():void {
	outputText("", true);
	//If Back Alley button is selected
	outputText("The back alley behind Oswald's pawnshop is quite unremarkable, except that it's reasonably clean.  A number of empty crates, old blankets and torn strips of cloth have been assembled into a makeshift \"<i>nest</i>\", the kind of place that a homeless vagrant would use as a resting place.\n\n", false);

	outputText("Katherine the cat is currently ", false);
	var num:Number = rand(5);
	if(num == 0) outputText("sitting in a corner", false);
	else if(num == 1) outputText("pacing back and forth", false);
	else if(num == 2) outputText("sipping furtively at a bottle of milk", false);
	else if(num == 3) outputText("yawning and stretching", false);
	else outputText("waking up from a cat-nap", false);
	outputText(", and she smiles when she sees you.  \"<i>" + player.short + "!  Did you come to see me?</i>\"", false);
	katherineMenu();
}
private function katherineMenu():void {
	//[Sex] [Talk] [Appearance] [Give Item]
	var sex:Function = null;
	if(player.lust >= 33) sex = katherineSex;
	simpleChoices("Sex",sex,"Talk",talkToKatherine,"Appearance",katherinesAppearance,"Give Item",giveKatherineAnItem,"Back",telAdre.telAdreMenu);
}
//Talk
private function talkToKatherine():void {
	outputText("", true);
	outputText("You tell Katherine that you'd like to talk.  The pink-haired black cat looks shy, but excited at that.  \"<i>Okay... what do you want to talk about?</i>\" she asks, nervously looking at her feet.", false);

	//[Racial Tension] [Her History] [Gang] [Dog Cock] [Vagrancy] [Love & Lust]
	choices("RacialTension",katherineDefur,"Her History",katherinesHistory,"Gang",askKatherineAboutGang,"Dog Cock",askKatherineAboutDogCock,"Vagrancy",askKatherineAboutVagrancy,"LoveAndLust",askKatherineAboutLoveAndLust,"",0,"",0,"",0,"Back",katherineMenu);
}

//Talk Scenes
//Racial Tension
private function katherineDefur():void {
	outputText("", true);
	outputText("You comment to Katherine that you can't help but notice that she and all of her.... ah, 'friends' are cats, and the city seems to be mainly populated by dogs.  Does that have anything to do with her basically being a vagrant?\n\n", false);

	outputText("\"<i>Ah... well, I wouldn't go so far as to say it's entirely to blame for us being on the streets, but I confess that it's definitely had a role to play.  Most of the watch are canines of some description and, well, they do tend to think the worst of any cats they suspect of causing trouble.</i>\" Katherine shrugs.\n\n", false);

	outputText("You comment that you would have thought the demonic threat would make people forget about prejudices like that.\n\n", false);

	outputText("\"<i>We're a lot more united now than we were before, but, honestly, old beliefs die hard, you know?  Horses are dumb, sex-crazed brutes, centaurs are horses with big egos and bad attitudes, dogs are dull-witted, wolves are savage, cats are lazy, mice are cowardly, foxes are shiftless... Well, you can see how it goes.</i>\"  The herm cat-morph delivers this proclamation while airly waving one furry hand.  \"<i>Besides, it's not as if there are demons beating on the walls day in and day out to remind us all of the greater threat every morning, you know?</i>\"\n\n", false);

	outputText("You click your tongue reflexively.  Politely thanking Katherine for the talk, you turn and walk away.\n\n", false);
	//Player returns to Tel'Adre Menu Screen or to camp, if code insists on it
	doNext(telAdre.telAdreMenu);
}

//Her History
private function katherinesHistory():void {
	outputText("", true);
	outputText("You tell Katherine you're curious about her.  How did she end up on the streets?  Was she born there - or did she simply lose her family?\n\n", false);

	outputText("\"<i>No, no, nothing quite so dramatic as that.</i>\"  The cat-woman laughs.  \"<i>My people basically all moved to Tel'Adre before I was born - mother used to complain I was kicking in her womb all the way - when our own cities were ransacked by the demons.  We had to settle in the bad parts of the city - we were lucky Tel'Adre had already lost a lot of people, or they might have turned us away.   I was born in the streets, and I've grown up here,</i>\" she explains.\n\n", false);

	outputText("You ask if that means Katherine's entire family are street-people like she is?\n\n", false);

	outputText("\"<i>No, no, nothing of the sort.</i>\"  She looks sheepishly at her hands for a moment.  \"<i>I... uh... it's actually kind of embarrassing.  All right, well... my mother and father always had a talent for dealing with people, getting them what they want and what they need for bargain prices.  So, it didn't take them long to set up and run this little shop together, off the main street.  I grew up living there; a bit cramped, but cozy - it was a quiet, safe life.  Unfortunately, I was what you'd call a rebellious teen; I used to hang out on the street all day long, and refused to go to school or learn a trade.  Then, one night, I decided I'd run away and live in the street full-time, because I heard them talking about sending me to join the Watch as a new recruit.</i>\"\n\n", false);

	outputText("She grins.  \"<i>Unfortunately, that means I've had to be a vagrant ever since; I don't dare go home as I have no intention of ever joining the Watch, but, well, I don't have a single way of earning myself an honest coin.</i>\"\n\n", false);

	outputText("She sees the look you're giving her and hastily anticipates your reaction.  \"<i>But don't worry, I actually like my life!  Nobody telling me what to do, I make my own hours... really, it's not so bad.</i>\"\n\n", false);

	outputText("You're skeptical, but reason there's nothing you can do about it right now.  Politely thanking Katherine for the talk, you turn and walk away.", false);
	//Player returns to Tel'Adre Menu Screen or to camp, if code insists on it
	doNext(telAdre.telAdreMenu);
}

//Gang
private function askKatherineAboutGang():void {
	outputText("", true);
	outputText("You ask Katherine if she can tell you anything about the gang of cats you found her running with.\n\n", false);

	outputText("She looks around, as if expecting them to suddenly appear.  \"<i>Okay... just, promise me you won't tell them anything I tell you?</i>\"  When you give your word, she sighs softly.  \"<i>Well, we're basically just what we look like; a bunch of homeless cats who figured out there was strength in numbers.  We're not really friends, exactly, we just know we can trust each other and we band together to do what we need to do.</i>\"\n\n", false);

	outputText("You ask her just what they actually do; after all, you did first meet them when they ambushed you and Scylla to get at some milk.\n\n", false);

	outputText("Katherine flushes with embarrassment.  \"<i>Yes, well... that's honestly not the first time they've done that.  We all like milk and sometimes have problems getting food, and so we go after lactating women and herms to feed on them - we don't usually mug people,</i>\" she hastily appends, \"<i>so the Watch aren't chasing us constantly.  Much as they may complain, milk thefts with no actual monetary damages generally aren't important enough for them to bother with.</i>\"\n\n", false);

	outputText("You point out that, either way, attacking people for what is basically their bodily fluid has got to be a dangerous risk to take in this city.  A lot of the people around look like they can take care of themselves.\n\n", false);

	outputText("\"<i>You're not wrong there,</i>\" Katherine agrees.  \"<i>We actually used to have another male cat named Joey in our gang, 'til he fell afoul of a 'victim' of ours.</i>\"  Curious, especially by the way she's smiling at the recollection, you ask her to share the tale.\n\n", false);

	outputText("\"<i>Well, he sees this mouse woman one day, dolled up in a long dress with milk seeping from nipples attached to breasts as big as her head, and decides to go after her without the rest of us.  He stumbled back to the gang later that day, gut swollen, face smeared with white, and looking very shocked.</i>\"  She grins wickedly.  \"<i>Turns out she was a hermaphrodite; had a horsecock this big,</i>\"  Here she touches first her elbow, then the tip of her middle finger.  \"<i>And two inches thick.  She apparently led him to a quiet place, acting like she was going to give him the milk he wanted, then she whipped out her dick, knocked him down and tied him up, then made him suck her off - and as she had balls as big and full as her tits under the dress, well...</i>\"\n\n", false);

	outputText("You can't help but picture that in your head and chuckle softly, then ask what happened to him.\n\n", false);

	outputText("\"<i>The others gave him such hell: mocking him for losing to a mouse, teasing him about liking dickgirls, and jeering that at least he got a meal anyway, that he vowed he'd get even; he went back after her again.  And again.  And kept losing.  He didn't always come home with a gut full of dick-milk, but she played with him sexually whenever she won, which was as often as he'd challenge her.  Funny thing was, she never actually raped him, per se - never tried sticking that horsecock up his ass... at least, not if he didn't want her to.  She seemed to think it was all a game and, to be honest, I think he started thinking that way too.  One day, he never came back; he's just shacked up with her permanently, I think.</i>\"\n\n", false);

	outputText("<b>That</b> certainly wasn't the sort of ending you were expecting.  You press her to explain; did they really just move in together?\n\n", false);

	outputText("\"<i>I've actually seen them a few times; they both look very happy, and he's even wearing a little heart tag with her name on it at his neck.</i>\"  The cat-herm shakes her head and sighs.  \"<i>The other cats never talk about him except to call him a wimp and a sellout.  Personally, I can't help but think he was the smart one.</i>\"\n\n", false);

	outputText("Mulling that over, you remember what you were originally talking about and ask her what the gang does aside from milk-muggings.\n\n", false);

	outputText("She shrugs.  \"<i>Panhandling, a little pickpocketing, some stall-robbing...  Mostly we're urban scavengers - you know, sneaking into abandoned homes and things to pick up stuff we can pawn for money.  It's not as easy as it sounds, and the law really cracks down on it, so if they catch us... it won't go easy.  We do that only when we're sure we can get away with it.</i>\"\n\n", false);

	outputText("Politely thanking Katherine for the talk, you turn and walk away.\n\n", false);
	//Player returns to Tel'Adre Menu Screen or to camp, if code insists on it
	doNext(telAdre.telAdreMenu);
}

//Dog Cock
private function askKatherineAboutDogCock():void {
	outputText("", true);
	outputText("You confess to Katherine that you're curious about her dog cock.  How did a cat end up with a canine penis?\n\n", false);

	outputText("Katherine sighs softly.  \"<i>I knew you would ask this eventually.  Well, to answer the obvious question right away, I was born a herm - and no, I never got any grief over it.  The other part happened not too long after I ran away from home to become a street-cat; I was starving hungry, and I was hanging around the markets - one of the traders had managed to bring a load of produce through, so I snuck in and grabbed the first crate of food I could carry on my own before running away.</i>\"  She shrugs.  \"<i>It was full of canine peppers, but my belly was growling, so I started tucking in... Unfortunately, I was too naive to realise that raw canine peppers have their transformative effects, and these were raw peppers. Native Marethians are resistant to interspecies transformation, but that didn't stop me from changing in my most vital part.</i>\"\n\n", false);

	outputText("Your eyes unthinkingly go to her waist, and she nods.  \"<i>I was scared, at first... but it felt so good. Plus, well...</i>\"  She blushes.  \"<i>It made me grow a bit bigger.</i>\"  As you look questioningly, she sheepishly explains, \"<i>You have to understand, big dicks aren't really what we cats are known for, and in this city, where a foot long seems to be the new average, well...</i>\"  She wriggles in embarrassment.  \"<i>So, I hit on what at the time seemed to be a great idea; eat canine peppers until I got as big as I wanted to be, then just steal and eat a whisker fruit to give myself a cat penis back.</i>\"  She sighs.  \"<i>Unfortunately, I didn't realise they weren't just any old peppers - they were knotty canine peppers. They don't make your canine penis grow, they make your knot grow. I ate the whole crate and all I ended up with for my troubles was an eight inch dick - double what I'd originally had, but entirely due to the initial transformation - a bellyache, and, as I was all too quick to find out, a knot so huge that even whores won't fuck me because it'd rip them apart.</i>\"  She sighs lamely.\n\n", false);

	outputText("You ask why she never went with her plan and used a whisker fruit to change it back.\n\n", false);

	outputText("\"<i>Because, soon afterwards, I found out the last trader who regularly brought whisker fruit into the city vanished.  We still get some in, but the big bakeries and restaurants snap them up - you never see them on sale in the market any more.</i>\"  She then looks aside.  \"<i>To be honest, I've kinda grown to like the cock itself... I just wish I could shrink the knot down.  But that would take Reducto salve, and that's incredibly rare and expensive.</i>\"  This last remark is accompanied with a weak shrug.\n\n", false);

	outputText("Curious, you prod her with another question; would she ever change her dog-dick for something else, given the opportunity?\n\n", false);

	outputText("She shakes her head.  \"<i>No... like I said, I'm accustomed to the dog-dick now, I even rather like it.  I just want to change the knot.  I'm not saying I want to get my hands on bulbous peppers or double peppers or anything like that.  Actually, I don't think I'd mind the bulbous peppers, and a double pepper might be interesting.  I definitely would like to get my hands on an overly large pepper or two...</i>\"  She trails off murmuring, half to you, half to herself.\n\n", false);

	outputText("Politely thanking Katherine for the chat, you turn and walk away.", false);
	//Player returns to Tel'Adre Menu Screen or to camp, if code insists on it
	doNext(telAdre.telAdreMenu);
}

//Vagrancy
private function askKatherineAboutVagrancy():void {
	outputText("", true);
	outputText("You ask Katherine to explain to you how exactly she and her friends can be vagrants; with all the empty houses left in the city, you'd think it would be easy for them to find a house in.\n\n", false);

	outputText("Katherine scowls.  \"<i>It's the government's idea.  Basically, they've repossessed all of the houses that are empty, and you can't get into them until and unless you prove you can make enough money to pay taxes and buy a lease.  No money, no house - that's why we, and many others like us, live on the street.  The Watch spends more time cracking vagrants over the head and expelling us from perfectly good empty houses than doing anything useful.</i>\"\n\n", false);

	outputText("You can't help wondering how much of that is true and how much of that is prejudice.  Politely thanking Katherine for the talk, you turn and walk away.", false);
	//Player returns to Tel'Adre Menu Screen or to camp, if code insists on it
	doNext(telAdre.telAdreMenu);
}

//Love & Lust
private function askKatherineAboutLoveAndLust():void {
	outputText("", true);
	outputText("Trying to phrase your question politely, you ask why it was that Katherine wanted to see you again, particularly given the circumstances under which you met.\n\n", false);

	outputText("The dog-dicked herm cat blushes and scrapes one foot nervously along the ground in embarrassment.  \"<i>Well, I... uh...  Truth be told?  You're basically the only person I've ever had sex with.</i>\"\n\n", false);

	outputText("Automatically, your eyes are drawn to her crotch and you can't help asking if her canine member is really that off-putting to others.\n\n", false);

	outputText("\"<i>It is, yeah.  Most cats can't get over it, most dogs can't get over the fact the rest of me is still a cat, and even centauresses are wary of letting me shove what is basically a melon in their cunts.</i>\"  Katherine nods, sadly.  \"<i>But then, you came along... I don't know why you did what you did, but I'm too happy to care.</i>\"  A beatific expression covers her face.\n\n", false);

	outputText("Politely thanking Katherine for the talk, you turn and walk away.", false);
	//Player returns to Tel'Adre Menu Screen or to camp, if code insists on it
	doNext(telAdre.telAdreMenu);
}

//Katherine Appearance:
private function katherinesAppearance():void {
	outputText("", true);
	outputText("Katherine stands before you, nervously watching as you scrutinize her form.  \"<i>Um... do you like what you see?</i>\"  Nervously trying to break the ice and amateurishly trying to flaunt her body, she strikes what might be a sexy pose... in her mind.\n\n", false);

	outputText("Katherine is a lean-built hermaphroditic cat-morph, standing maybe 5' 2\" tall.  Her fur is black, but her shoulder-length hair, often worn forward and obscuring one of her leaf-green eyes, is neon pink.  She wears weatherbeaten, somewhat ragged, clearly second-hand clothing, consisting of a too-large shirt and a very tight pair of shorts.  At your gesture, she meekly undresses herself so that you can get a better look at her.\n\n", false);

	outputText("Palmable B-cup breasts sit on her chest, while just below her belly button sits the unmistakable form of an animalistic penis sheath.  Shyly, her phallus begins to slip from its length; ", false);
	if(flags[kFLAGS.KATHERINE_DICK_COUNT] == 1) outputText("a canine cock", false);
	else outputText("a pair of canine cocks", false);
	outputText(", 1.5\" thick and " + flags[kFLAGS.KATHERINE_DICK_LENGTH] + "\" long reveals ", false);
	if(flags[kFLAGS.KATHERINE_DICK_COUNT] == 1) outputText("itself", false);
	else outputText("themselves", false);
	outputText(", with ", false);
	if(flags[kFLAGS.KATHERINE_DICK_COUNT] == 1) outputText("a ", false);
	outputText(flags[kFLAGS.KATHERINE_KNOT_THICKNESS] + "\" thick knot", false);
	if(flags[kFLAGS.KATHERINE_DICK_COUNT] > 1) outputText("s at their bases.  A pair of " + flags[kFLAGS.KATHERINE_BALL_SIZE] + "\" wide balls sway below her cocks, hanging just above her wet, eager cunt.\n\n", false);
	else outputText(" at its base.  A pair of " + flags[kFLAGS.KATHERINE_BALL_SIZE] + "\" wide balls sway below her cock, hanging just above her wet, eager cunt.\n\n", false);
	
	outputText("When you're finished looking at her she quickly redresses herself, flaunting her rear at you as if by accident and waiting to see what else you want, reassured by your lack of comments.\n\n", false);
	//Display default Katherine options
	katherineMenu();
}

//Give Item:
private function giveKatherineAnItem():void {
	outputText("", true);
	outputText("You tell Katherine that you have a present for her.\n\n", false);
	outputText("The cat-morph's face lights up, but then she guiltily lowers her eyes.  \"<i>I can't - you're too good to me already...</i>\"  You cut her off, insisting that you want to give it to her.  \"<i>Okay, if you're sure... what is it?</i>\"\n\n", false);
	var reducto:Function = null;
	var bulb:Function = null;
	var double2:Function = null;
	var large:Function = null;
	if(player.hasItem(consumables.REDUCTO)) reducto = useReductoOnKat;
	if(player.hasItem(consumables.BULBYPP)) bulb = giveKatABulbousPepper;
	if(player.hasItem(consumables.DBLPEPP)) double2 = giveKatADoublePepper;
	if(player.hasItem(consumables.LARGEPP)) large = giveKatAOverlyLargePepper;
	//[Reducto] [Bulbous Pepper] [Double Pepper] [Overly Large Pepper]
	simpleChoices("Reducto",reducto,"BulbPepper",bulb,"DblPeppr",double2,"LrgPepp",large,"Back",katherineMenu);
}

//Reducto
private function useReductoOnKat():void {
	outputText("", true);
	if(flags[kFLAGS.KATHERINE_DICK_LENGTH] <= 8 && flags[kFLAGS.KATHERINE_KNOT_THICKNESS] <= 2 && flags[kFLAGS.KATHERINE_BALL_SIZE] <= 1) {
		//If min size on all Kat parts reached:
		outputText("She looks at the jar and then visibly thinks about it, but shakes her head.  \"<i>I'm sorry, " + player.short + ", but I don't think it's possible for that stuff to make any of my remaining parts shrink any more...  Or rather, I should say I don't want to get any smaller than I am now, thank you.</i>\"\n\n", false);
		outputText("You nod in understanding and put the jar away.  She looks apologetic.  \"<i>Did you maybe want to do something else?</i>\" she asks.", false);
		//Display main Kat menu
		doNext(giveKatherineAnItem);
	}
	else {
		var knot:Function = null;
		var leng:Function = null;
		var balls:Function = null;
		if(flags[kFLAGS.KATHERINE_DICK_LENGTH] > 8) leng = useReductoOnKatsKock;
		if(flags[kFLAGS.KATHERINE_KNOT_THICKNESS] > 2) knot = useRedoctoOnKatsKnot;
		if(flags[kFLAGS.KATHERINE_BALL_SIZE] > 1) balls = reductoBallSize;
		outputText("You extract the small jar of salve and offer it to her.  Her face lights up in delight.  \"<i>Reducto?!  For me?  It's so expensive!</i>\"  At your nod, she yowls happily and snatches it up, yanking down her shorts to expose her sheath.  All of a sudden, she stops abruptly and looks up at you, a dangerous gleam in her eye.  \"<i>Would you like to... help me apply it?</i>\" she asks, softly.  You nod your head", false);
		if(player.lib > 50) outputText(" with a salacious grin", false);
		outputText(" and she happily plunks down on a nearby crate, holding the precious jar of ointment and waiting for you to begin.\n\n", false);
		outputText("You kneel before her, looking at her sheath ", false);
		if(player.lib > 50) outputText("and planning exactly what you're going to do to it.", false);
		else outputText("and wondering how to begin.", false);
		//[Knot] [Length] [Balls]
		simpleChoices("Knot",knot,"Length",leng,"Balls",balls,"",0,"Back",giveKatherineAnItem);
	}
	
}
private function useRedoctoOnKatsKnot():void {
	outputText("", true);
	outputText("You gently reach out and start to stroke her sheath up and down, feeling the long bone of ", false);
	if(flags[kFLAGS.KATHERINE_DICK_COUNT] > 1) outputText("each of her canine cocks, and rubbing one finger across the exposed tips.  The cat wriggles and squirms, and quickly blooms under your care, until all " + flags[kFLAGS.KATHERINE_DICK_LENGTH] + " inches of both shafts are exposed.  Her knots just barely visible as a bulge at the base of each cock, you start to stroke them next.  Katherine coos and moans as your fingers glide up and down, and the responsive flesh starts to swell like red, hard balloons.  They puff up and up, swelling to full size, " + flags[kFLAGS.KATHERINE_KNOT_THICKNESS] + " inches in diameter.  With the subjects prepared, you stop, leaving Katherine hovering at the edge of release.\n\n", false);
	else outputText("her canine cock, and rubbing one finger across the exposed tip.  The cat wriggles and squirms, and quickly blooms under your care, until all " + flags[kFLAGS.KATHERINE_DICK_LENGTH] + " inches of her shaft is exposed.  Knot just barely visible as a bulge at the base of her cock, you start to stroke it next.  Katherine coos and moans as your fingers glide up and down, and the responsive flesh starts to swell like a red, hard balloon.  It puffs up and up, swelling to full size, " + flags[kFLAGS.KATHERINE_KNOT_THICKNESS] + " inches in diameter.  With the subject prepared, you stop, leaving Katherine hovering at the edge of release.\n\n", false);

	outputText("She is, however, too wound up to do anything, so you are forced to take the Reducto from her slack fingers and smear the foul-smelling gunk across her knot", false);
	if(flags[kFLAGS.KATHERINE_DICK_COUNT] > 1) {
		outputText("s.  She gasps and suddenly lets out a yowl, her cocks visibly spasming as her knots shrink... and then promptly begins spurting cum, which you ", false);
		if(player.lib > 50) outputText("joyously attempt to catch in your mouth like rain", false);
		else outputText("narrowly dodge in surprise", false);
		outputText(", at the expense of dropping and spilling what's left of the salve.  The hard flesh shrinks until the width has dropped by two whole inches, at which point the salve's effects wear off and her climax finishes... though, given that her knots remain swollen and her cocks remain erect, you think she could probably go again.\n\n", false);
	}
	else {
		outputText(".  She gasps and suddenly lets out a yowl, her cock visibly spasming as her knot shrinks... and then promptly begins spurting cum, which you ", false);
		if(player.lib > 50) outputText("joyously attempt to catch in your mouth like rain", false);
		else outputText("narrowly dodge in surprise", false);
		outputText(", at the expense of dropping and spilling what's left of the salve.  The hard flesh shrinks until the width has dropped by two whole inches, at which point the salve's effects wear off and her climax finishes... though, given that her knot remains swollen and her cock remains erect, you think she could probably go again.\n\n", false);
	}
	
	outputText("She rewards you with a glowing, orgasmic smile.  \"<i>That was... incredible.  Thank you so much for the present... did you want to do anything else?  Maybe... have a little fun?</i>\" she asks, her voice low and husky with desire.\n\n", false);
	//use 1x Reducto, reduce Kat knot size by 2, increase PC lust value, go to Kat sex menu
	flags[kFLAGS.KATHERINE_KNOT_THICKNESS] -= 2;
	if(flags[kFLAGS.KATHERINE_KNOT_THICKNESS] < 2) flags[kFLAGS.KATHERINE_KNOT_THICKNESS] = 2;
	dynStats("lus", 10+player.lib/20);
	player.consumeItem(consumables.REDUCTO);
	katSexMenu();
}
//[Cock Length] (unavailable unless Kat cocklength is >8)
private function useReductoOnKatsKock():void {
	outputText("", true);
	outputText("With a gesture, you indicate for her to expose herself.  In obedience, she begins to stroke her sheath and expose its contents, bashfully at first but with increasing vigor as her erection takes hold.  Soon she's masturbating happily with her eyes closed and her head rolled back on her neck, having nearly forgotten what she was doing in the first place.  You ", false);
	if(player.lib > 50) outputText("allow her to continue until her scrotum tightens up and it looks like she'll blow her load with one more touch, and then ", false);
	outputText("clear your throat noisily to regain her focus.  Blushing red underneath her sable fur, she guiltily withdraws her hand from her shivering cock", false);
	if(flags[kFLAGS.KATHERINE_DICK_COUNT] > 1) outputText("s", false);
	outputText(".\n\n", false);

	outputText("With a playful eyebrow, you take a knee in front of the throbbing-hard member", false);
	if(flags[kFLAGS.KATHERINE_DICK_COUNT] > 1) outputText("s", false);
	outputText(" and uncap the salve.  As if to tease, you dip into it and then, at a glacial pace, draw the paste closer to her shaft", false);
	if(flags[kFLAGS.KATHERINE_DICK_COUNT] > 1) outputText("s", false);
	outputText(" while remarking how cold it is compared to the desert air.  She quivers at the comment, setting her ", false);
	if(flags[kFLAGS.KATHERINE_DICK_COUNT] > 1) outputText("twin cocks", false);
	else outputText("cock", false);
	outputText(" to bobbing", false);
	if(player.lib > 50) outputText(", then quivers again as the movement brings her a hair closer to her climax", false);
	outputText(".\n\n", false);

	outputText("Gingerly, you lift your unemployed hand up and tilt her puppy pecker", false);
	if(flags[kFLAGS.KATHERINE_DICK_COUNT] > 1) outputText("s", false);
	outputText(" toward her face and chest; she shivers as you touch the sensitive underside", false);
	if(flags[kFLAGS.KATHERINE_DICK_COUNT] > 1) outputText("s", false);
	outputText(".  As you hold her in that position, ", false);
	if(player.lib > 50) outputText("staring at Katherine with a lewd smirk as she trembles and tries to maintain control, ", false);
	outputText("you bring the occupied hand up and begin rubbing the paste into the shaft", false);
	if(flags[kFLAGS.KATHERINE_DICK_COUNT] > 1) outputText("s", false);
	outputText(" proper with brisk up-and-down strokes.", false);
	if(player.lib > 50) outputText("  Barely any time has passed before Katherine, with a husky groan of protest and acquiescence mingled, begins unloading her steamy cargo; the first squirt stains her shirt while the later and more energetic ones after it reach all the way to her neck and spatter on her chin.", false);
	outputText("  Katherine trembles ", false);
	if(player.lib > 50) outputText("and her orgasm continues ", false);
	outputText("as you apply a goodly amount of paste, smearing it over every inch of the twitching cock", false);
	if(flags[kFLAGS.KATHERINE_DICK_COUNT] > 1) outputText("s", false);
	outputText(" and mingling it with the copious pre-cum from her errant masturbation.  Suddenly a gasp interrupts the chorus of low moans from your felid companion, as the effects begin.  Her shaft", false);
	if(flags[kFLAGS.KATHERINE_DICK_COUNT] > 1) outputText("s spasm and shrink, ", false);
	else outputText(" spasms and shrinks, ", false);
	if(player.lib > 50) outputText("still pushing out the aftershocks of her climax onto her belly, ", false);
	outputText("ending up two inches shorter than before.\n\n", false);

	outputText("\"<i>God, that was... uughh,</i>\" Katherine groans, wiping her fur.  \"<i>I'm still so hard and horny, too... feels like I'll never go soft now.  Do you maybe... wanna help me with that?</i>\"  She turns a hopeful", false);
	if(player.lib > 50) outputText(", if fatigued,", false);
	outputText(" look on you.\n\n", false);
	
	//remove 2 inches from Kat's length, use 1x Reducto, increase PC lust value, go to Kat sex menu
	flags[kFLAGS.KATHERINE_DICK_LENGTH] -= 2;
	if(flags[kFLAGS.KATHERINE_DICK_LENGTH] < 8) flags[kFLAGS.KATHERINE_DICK_LENGTH] = 8;
	dynStats("lus", 10+player.lib/20);
	player.consumeItem(consumables.REDUCTO);
	katSexMenu();
}

//[Ball Size](unavailable until Kat balls >1</i>\")
private function reductoBallSize():void {
	outputText("", true);
	outputText("You extract the small jar of salve and offer it to her.  Her face lights up in delight.  \"<i>Reducto?!  For me?  It's so expensive!</i>\"  At your nod, she yowls happily and snatches it up, yanking down her shorts to expose her sheath.  All of a sudden, she stops abruptly and looks up at you, a dangerous gleam in her eye.  \"<i>Would you like to... help me apply it?</i>\" she asks, softly.  You nod your head", false);
	if(player.lib > 50) outputText(" with a salacious grin", false);
	outputText(" and she happily plunks down on a nearby crate, holding the precious jar of ointment and waiting for you to begin.\n\n", false);

	outputText("With a little help from you, she wriggles out of her shorts, exposing her swollen testes.  You wonder for a moment if the fur on her distended sack will interfere with the process, then decide it can't hurt to try.  Uncertainly, you open the jar and begin smearing your fingers with the salve, which you then start painting across Katherine's balls.  The hermaphrodite feline shivers at your touch, but bites her lip and says nothing as you massage the shrinking cream into her semen-factories, rolling the globular orbs around in the palm of your hand to ensure a thorough, even coating.\n\n", false);

	outputText("You finish applying the salve and watch as they visibly shrink, contracting in on themselves until they have lost two inches in diameter.  It's at that point you realise the man-meat above them is jutting straight up from her sheath, pre-cum starting to bubble from the pointy tip", false);
	if(flags[kFLAGS.KATHERINE_DICK_COUNT] > 1)
	outputText(".  \"<i>Uh... I think shrinking my balls put their contents under pressure.  You wanna help me vent some?</i>\" she meekly suggests, coloring and biting her lip in either embarrassment or anticipation.\n\n", false);
	//use 1x Reducto, reduce Kat ball size by two inches, increase PC lust by small value, go to Kat sex menu
	flags[kFLAGS.KATHERINE_BALL_SIZE] -= 2;
	if(flags[kFLAGS.KATHERINE_BALL_SIZE] < 1) flags[kFLAGS.KATHERINE_BALL_SIZE] = 1;
	dynStats("lus", 10+player.lib/20);
	player.consumeItem(consumables.REDUCTO);
	katSexMenu();
}

//Bulbous Pepper
private function giveKatABulbousPepper():void {
	outputText("", true);
	outputText("You hold out your bulbous canine pepper and ask if she'd like to eat it.\n\n", false);

	//(if Kat still has balls to go)
	if(flags[kFLAGS.KATHERINE_BALL_SIZE] < 5) {
		outputText("\"<i>Oh, sure, why not?  Bigger balls have got to be better, right?</i>\" she replies.  Her tone is sarcastic, but she gives you a friendly wink and then takes the pepper, munching it down.  With a moan and an arched back, she produces a new swell in her tight shorts as you look on, her balls visibly growing.  They roughly double in size, then stop, leaving the cat herm panting.  She throws you a sultry look.  \"<i>So... you wanna give them a test run?</i>\" she purrs.\n\n", false);
		//add 2 to Kat ball size, use 1x Bulby Pepper, Display Katherine Sex options
		flags[kFLAGS.KATHERINE_BALL_SIZE] += 2;
		if(flags[kFLAGS.KATHERINE_BALL_SIZE] > 5) flags[kFLAGS.KATHERINE_BALL_SIZE] = 5;
		dynStats("lus", 10+player.lib/20);
		player.consumeItem(consumables.BULBYPP);
		katSexMenu();
	}
	//(else If KathBallSize maxed at 5 inches)
	else {
		outputText("She looks at the bulbous pepper and then shakes her head.  \"<i>No thank you.  Any bigger and I'm going to have trouble walking, and I think I make enough of a mess now as it is.  Thank you for the offer, though.  Was there anything else?</i>\" she adds, trying to be diplomatic.", false);
		katherineMenu();
	}
}

//Double Pepper
private function giveKatADoublePepper():void {
	outputText("", true);
	//(if Kat has only 1 cock so far)
	if(flags[kFLAGS.KATHERINE_DICK_COUNT] == 1) {
		outputText("You hold out your double canine pepper and ask if she'd like to eat it.\n\n", false);

		outputText("\"<i>Double your fun, huh?  Okay... this is a really weird thing, but if it makes you happy,</i>\" she notes.  She takes the pepper and, pausing only to slip her pants down to expose her sheath, polishes the pepper off with a smack of her lips for good measure.  \"<i>Mmm... Not bad. Oh!</i>\"  She gasps and then arches her back suddenly.\n\n", false);

		outputText("Your gaze goes to her crotch, where her canine cock slides free with deceptive slowness, crowning itself at " + flags[kFLAGS.KATHERINE_DICK_LENGTH] + " inches and filling its knot to " + flags[kFLAGS.KATHERINE_BALL_SIZE] + " inches thick as the knot pops free.  Then the sheath's opening stretches even wider as a second distinctive tip pops up, sliding up and out until she is sporting two bulging dog-cocks, each exactly the same size as the last.  She reaches down and gently strokes one with each hand, casting you a come hither look.\n\n", false);
		//set Kat cock number to 2, use 1x double pepper, Display Katherine Sex options
		flags[kFLAGS.KATHERINE_DICK_COUNT] = 2;
	}
	//(else if she has 2 already)
	else {
		outputText("Katherine looks at the twinned peppers with a puzzled expression.  \"<i>Uh... you do know that it won't make me grow any more cocks, right?  Two's the limit from this thing, as far as I know.</i>\"\n\n", false);

		outputText("You tell her you think she could use a good meal, and you know how much she likes peppers.  The cat gives you a nervous smile and accepts the double pepper.  She eats it daintily, swallows, and then develops a peculiar expression. As she pants loudly, you can see her cocks starting to poke out of her pants.\n\n", false);

		outputText("\"<i>Oh dear...  I think that was maybe a bit too spicy.  You want to help me out with this?</i>\" she purrs, already starting to stroke her twin shafts.\n\n", false);
	}
	dynStats("lus", 10+player.lib/20);
	player.consumeItem(consumables.DBLPEPP);
	katSexMenu();
}
	
//Overly Large Pepper
private function giveKatAOverlyLargePepper():void {
	outputText("", true);
	//(if Kat is not yet capped on size at 16 inches)
	if(flags[kFLAGS.KATHERINE_DICK_LENGTH] < 16) {
		outputText("You ask if Katherine would really like to make her cock bigger, holding up the overly large canine pepper from your inventory.\n\n", false);

		outputText("\"<i>Yes!  Please!</i>\" she says, clearly excited.  She snatches it from your hands and wolfs it down noisily, licking her fingers and then pulling her pants down with obvious excitement.  Her cock", false);
		if(flags[kFLAGS.KATHERINE_DICK_COUNT] > 1) outputText("s", false);
		outputText(" immediately thrust", false);
		if(flags[kFLAGS.KATHERINE_DICK_COUNT] == 1) outputText("s", false);
		outputText(" from her sheath, growing to full size and then a full two inches further before stopping.  She moans softly, licks her lips and smiles at you.  \"<i>Care to have a test run?  Be a shame to let the chance go to waste...</i>\" she purrs.\n\n", false);
		//use 1x large pepper, increase Kat length by 2, Display Katherine Sex options
		dynStats("lus", 10+player.lib/20);
		flags[kFLAGS.KATHERINE_DICK_LENGTH] += 2;
		player.consumeItem(consumables.LARGEPP);
		katSexMenu();
	}
	//else if capped)
	else {
		outputText("She looks at the pepper eagerly, then visibly reins herself in.  \"<i>I'm sorry...  I really would like to eat it, but I have to be practical.  I'm nearly a foot and a half long already!  Momma didn't raise me to be a size queen, and if I get much longer I'll be like that poor sap who leads the guard - can't get a date because there's nobody big enough for me to stick my cock in,</i>\" she declares, crossing her arms and looking firm.\n\n", false);
		outputText("\"<i>Though if you have anything else you're thinking of giving, I'm sure we can salvage the gesture.  Otherwise, thank you for thinking of me,</i>\" she adds, quickly trying to make nice with you.", false);
		//return to main Kat menu
		katherineMenu();
	}
}

//Sex
private function katherineSex():void {
	outputText("", true);
	outputText("You ask Katherine if she feels in the mood to have sex.\n\n", false);

	outputText("The cat herm is visibly startled by your directness, then rallies and gives you an ear-to-ear grin.  \"<i>Mmm...  am I ever...  Any particular preference?</i>\" she asks, swishing her tail languidly from side to side.\n\n", false);
	katSexMenu();
}

private function katSexMenu():void {
	//[Penetrate] [Get Penetrated] [Oral] [Double Helix] [Suckle]
	var penetrate:Function = null;
	var getPen:Function = null;
	var helix:Function = null;
	var suckle:Function = null;
	if(player.lust >= 33) {
		if(player.hasCock()) {
			if(player.cockThatFits(70) >= 0) penetrate = katPenetrate;
		}
		getPen = letKatKnotYou;
		if(player.hasCock() && player.hasVagina() && player.cockThatFits(70) >= 0) helix = katDoubleHelixCraziness;
	}
	if(player.lactationQ() > 0 && player.biggestLactation() >= 1 && player.biggestTitSize() >= 1)
		suckle = suckleTacularKats;
	simpleChoices("Penetration",penetrate,"GetPenetrated",getPen,"Oral",oralKatherineChoices,"DoubleHelix",helix,"Suckle",suckle);
}

//Penetrate
private function katPenetrate():void {
	outputText("", true);
	outputText("You suggest that maybe you could try penetrating one of Katherine's holes.  Without further ado, she strips herself off until she's wearing nothing but a lecherous grin.  She then turns around and leans on a crate, waving her tail to freely show off both her tailhole and her already-dripping cunt above her dangling balls.  \"<i>So, come on in,</i>\" she purrs.\n\n", false);
	//[Vagina] [Anus] [Both(not yet implemented)] [Suck 'n' Fuck]
	var vagina:Function = penetrateKatsVag;
	var anus:Function = pcPenetratesKatAnally;
	var sucknFucks:Function = null;
	if(flags[kFLAGS.KATHERINE_KNOT_THICKNESS] <= 4) sucknFucks = suckNFuck;
	simpleChoices("Vagina",vagina,"Anus",anus,"",0,"SucknFuck",sucknFucks,"",0);
}



//PC Penetrates Kath: Vaginal (doin' a cat doggy-style)
private function penetrateKatsVag():void {
	var x:Number = player.cockThatFits(70);
	outputText("", true);
	outputText("You don't even need to think about it.  Your eyes are locked on the cat-herm's silken, sopping wet pussycat pussy, which is already dribbling femlube down her ", false);
	outputText(katBalls() + " scrotum and puddling it onto the ground in anticipation.  Slipping off your garments, you saunter forward and gently stroke her damp lips, stage-whispering to her that it seems an obvious choice which hole you should take.  Katherine gives a playful giggle, a mewl of arousal, and repositions herself so that it's easier for her to support the two of you.\n\n", false);

	outputText("As soon as she's ready, you waste no time in sliding your " + cockDescript(x) + " home, causing her to yowl in delight at being filled.  Her slippery walls, soft and slick like greased velvet, seem to ripple as if to purposefully swallow your cock, seemingly eager to have you bury yourself to the hilt.  Sopping wet as they are they pose no resistance, allowing you to glide in smooth as butter, yet they grip you and try in vain to hold you in.  Your thrusts and surges elicit the lewdest squelches and slurps, her slobbering cunny drooling all over your shaft and ", false);
	if(player.balls > 0) outputText("both sets of ", false);
	else outputText("her ", false);
	outputText("balls.\n\n", false);

	outputText("\"<i>Oh, yeah!  Yes - AH!  It feels so good!</i>\" Katherine yowls mindlessly, babbling in her delight at your penetrations.  You, for your part, just grab her silken fur, hold onto her narrow hips and keep on thrusting.  While you may have started out firmly in charge, as the pace picks up the cat-herm is the one to take the lead; she pushes back against you, bucking and thrashing so wildly you find yourself having to hang on for dear life as she fucks you senseless.  If it weren't for how wet she is, she'd be rubbing your cock raw from friction and the vice-like grip around your shaft.  You can just make out the way her cock", false);
	if(flags[kFLAGS.KATHERINE_DICK_COUNT] > 1) outputText("s", false);
	outputText(" flail", false);
	if(flags[kFLAGS.KATHERINE_DICK_COUNT] == 1) outputText("s", false);
	outputText(" around, stiff as iron with knot", false);
	if(flags[kFLAGS.KATHERINE_DICK_COUNT] > 1) outputText("s", false);
	outputText(" swollen to full size - she can't be much further from climax...\n\n", false);

	outputText("And, indeed, she's not.  Arching her back in a way that would break a human spine, she lets out an ear splitting scream of ecstasy, making you unconsciously recall nights of being woken up by courting cats back in Ingnam.  Cum gushes like a river from her cock", false);
	if(flags[kFLAGS.KATHERINE_DICK_COUNT] > 1) outputText("s", false);
	outputText(" and her cunny floods over with femspray, splattering you and soaking the ground and everything from your waist down.  As if signalled by her orgasm, your own climax seizes you by surprise.  ", false);
	if(player.hasVagina()) outputText("Your " + vaginaDescript() + " releases its own girl-cum in sympathy, even as y", false);
	else outputText("Y", false);
	outputText("our cock discharges into her depths, flooding her inviting nethers with your spunk, her pussy-lips drinking every last drop you have to give with insatiable greed.", false);
	if(player.cumQ() >= 1500) outputText("  Her belly puffs up and out, swelling like an advancing pregnancy with insatiable speed, until finally you have finished, leaving her with a barrel-sized balloon of a gut, cum audibly sloshing inside her as her motions churn the liquid.", false);
	outputText("  Gasping, having spent yourself, you pull out, letting her nethers drool their sexual fluids onto the ground undisturbed.\n\n", false);

	outputText("Katherine sprawls against the barrel, flicking her tail lazily and purring loudly.  \"<i>Mmm... you have no idea how good you are, lover,</i>\" she tells you, before patting her belly and giggling softly.  \"<i>I'm not saying I want to be a mom just yet", false);
	if(player.cumQ() >= 1500) outputText(" - though, honestly, you may not give me much of a choice - ", false);
	outputText(" but I think your little boys and girls and herms will make people very, very happy when they come of age.</i>\"\n\n", false);

	outputText("With a smile, you scratch her behind the ears in a way that the cats in your village loved, enjoy her contented purr, clean yourself off with some old rags that the cat laid aside, and then politely say goodbye, redressing yourself and heading back out in Tel'Adre.\n\n", false);
	//lust -100, Player returns to Tel'Adre Menu Screen or to camp, if code insists on it
	dynStats("sen", -1, "lus=", 0);
	flags[kFLAGS.KATHERINE_TIMES_SEXED]++;
	doNext(13);
}

//PC Penetrates Kath: Anal
private function pcPenetratesKatAnally():void {
	outputText("", true);
	var x:Number = player.cockThatFits(70);
	outputText("Thinking it over, your gaze falls upon the cat's ebony pucker, and you smile to yourself before telling Katherine that you want a shot at her back door.  Her eyes widen and she swallows hard, then she nods.  \"<i>O-Okay... if you're into that sort of thing...</i>\"\n\n", false);

	outputText("She turns her head back and around and repositions herself so that she's properly supporting herself on the crate, timidly waiting for your approach.  Confidently you saunter up behind her, taking the opportunity to appraise your partner.  It's true that she's nothing to write home about in terms of ass size or perkiness, but her lean butt is solidly muscled and covered in surprisingly luxurious-looking fur considering her probably-irregular diet, and you take this opportunity to run your hands appreciatively through the soft hair.  She coos and wriggles in delight, drawing your attention back to the matter at hand.  Katherine's vagina is already drooling in anticipation, despite her nervousness, and it's a simple matter for you to expose yourself and gather up some of her juices in the palm of your hand.  You painstakingly rub the juices into your " + cockDescript(x) + ", bringing it to full mast even as you get it nice and slick.  Then, you start massaging what's left of your handful of girl-lube into Katherine's tight asshole, making her squeak and moan as you get her wet.  Finally, you ask if she's ready.\n\n", false);

	outputText("\"<i>I-I am!</i>\" She insists, visibly trying to relax.  \"<i>Just... j-jam it in!</i>\"\n\n", false);

	outputText("No further encouragement needed, you press forward and begin sinking yourself into her tight black tailhole.  She moans like a virgin, her " + katCock() + " dog-cock", false);
	if(flags[kFLAGS.KATHERINE_DICK_COUNT] > 1) outputText("s", false);
	outputText(" visibly jolting and her empty kitty-cunt clenching in sympathy as you slide yourself in.  Her anal walls lock around you like a vice of heated silk, gripping you and squeezing as if already trying to wring every last drop of cum out of you.  But you forge on, sliding inch after inch into her bowels until you can slide no more.  Then, slowly, you try to extract yourself - fighting every inch of the way, as her virgin-tight ass tries to suck you back.  Finally drawing most of what you put inside, you slide yourself home again, slamming harder and faster into her hips, then pulling out, repeating this over and over.\n\n", false);
	
	outputText("The herm cat gasps and moans, thrusting her sparsely-fleshed ass back to try and meet your hips as you continue to push, her inner walls milking and squeezing.  \"<i>Ah!  Do you - oh! - know what the - yeah, yeah, fuck me like that, fuck me there! - advantage of a herm - yesyesyes! - girlfriend is, " + player.short + "?</i>\" she manages to gasp out.\n\n", false);

	outputText("You grunt and hiss as you abuse her insides, but manage to spare the breath to admit you don't.\n\n", false);
		
	outputText("\"<i>The advantage is - oh! ah! - I've got both sets of bits, so - ah! ah! AH! - it's good for me, like it'd be good for a guy!</i>\"  She lets out an excited yowl of bliss as you thrust particularly hard.  \"<i>Ohh... You're squeezing my prostate, rubbing all the parts in my ass that make my cock", false);
	if(flags[kFLAGS.KATHERINE_DICK_COUNT] > 1) outputText("s", false);
	outputText(" jump, it's so good back there... so hard, so hot!  Fuck me, fuck me like an animal!</i>\" she screams, starting to jerk her own hips, knot-swollen cock", false);
	if(flags[kFLAGS.KATHERINE_DICK_COUNT] > 1) outputText("s", false);
	outputText(" spewing pre-cum as she mock-humps the air.  She's gonna blow any second now...\n\n", false);
	
	outputText("But you beat her to the punch and, with a howl of your own, you cum inside her, flooding her bowels with your spunk", false);
	if(player.cumQ() >= 500) outputText(" until her belly begins to bulge from all you've dumped in her", false);
	if(player.cumQ() >= 1500) outputText(", swelling out and out until she looks like she could give birth soon and a part of you wonders if maybe she's going to start spouting your cum from her mouth", false);
	outputText(".  In the midst of your orgasm, her own yowling cry goes unnoticed as her cunt spasms, raining femcum down onto the ground below and her ", false);
	if(flags[kFLAGS.KATHERINE_DICK_COUNT] > 1) outputText("cocks spray", false);
	else outputText("cock sprays", false);
	outputText(" cum all along the crate and ground.  Finally, you are spent, and pull yourself wetly from your gasping lover's ass.\n\n", false);

	outputText("She slinks bonelessly to the ground, still quivering from the afterglow, then smiles dreamily up at you", false);
	if(player.cumQ() >= 1500) outputText(", absently cradling her distended belly", false);
	outputText(".  \"<i>What a fuck... can't say I don't prefer it in my pussy, but I'll always be up for another go if you want.</i>\"", false);
	if(player.cumQ() >= 1500) outputText("  She looks at her gut and shakes her head in disbelief.  \"<i>Sheesh... if they ever figure out a way to let folks get pregnant by taking it up the ass, you're gonna knock up every damn person you meet, aren't you, stud?</i>\"", false);
	outputText("\n\n", false);

	outputText("With a smirk at her flattery, you give her a hand getting dressed, then dress yourself and head back out into the street.", false);
	//lust -100, Player returns to Tel'Adre Menu Screen or to camp, if code insists on it
	dynStats("sen", -1, "lus=", 0);
	flags[kFLAGS.KATHERINE_TIMES_SEXED]++;
	doNext(13);
}

//Suck 'n' Fuck (unavailable if knot > 4</i>\")
private function suckNFuck():void {
	var x:Number = player.cockThatFits(70);
	outputText("", true);
	outputText("You think it over, then find your gaze drifting to Katherine's sheath and the canine cockflesh within.  Recalling how you helped the poor herm shrink down her monster knot", false);
	if(flags[kFLAGS.KATHERINE_DICK_COUNT] > 1) outputText("s", false);
	outputText(", and remembering the flexibility of the cats you've seen, you find a very kinky idea coming to you.  You ask Katherine if she'd be willing to try a suck 'n' fuck.\n\n", false);

	outputText("\"<i>Excuse me?</i>\" she asks, raising an eyebrow.  You quickly explain the idea: that you penetrate her vagina at the same time that she performs oral sex on her cock, at which her eyes light up.  \"<i>Sounds kinky - but also genius!  Sure, I'm game.</i>\"  She smiles, and turns around so that she is sitting on the crate instead of leaning on it.\n\n", false);

	outputText("Still smiling, she begins to gently stroke her sheath, balls and pussy, coaxing out her dog cock", false);
	if(flags[kFLAGS.KATHERINE_DICK_COUNT] > 1) outputText("s", false);
	outputText(".  Making sure she's positioned so that she's not going to tumble off in mid-fuck, she takes hold of her thighs and bends over... and over... until she has practically pressed her nose into her own crotch.", false);
	if(player.hasPerk("Flexibility") < 0) outputText("  The sight is enough to make your spine wince in sympathy.", false);
	//(player has Feline Flexibility: 
	else outputText("  You watch how she does it, resolving to test your body and see if you can bend like that.", false);
	outputText("  Having loosened up, she straightens her back until her mouth is hovering in front of the tip of her ", false);
	if(flags[kFLAGS.KATHERINE_DICK_COUNT] > 1) outputText("topmost ", false);
	outputText("dog cock.  Her cat-like tongue, long and flat and bristly looking, reaches out to stroke the rubbery, conical tip, slurping around it and getting it nice and slick.  Then, she opens her mouth and starts bending forward again, gulping down all " + flags[kFLAGS.KATHERINE_DICK_LENGTH] + " inches of dog cock until she reaches the knot.  A moment's hesitation, to muster her courage, and then she engulfs it as well, pressing her nose flat against her own ballsack.\n\n", false);

	outputText("This is your moment, and you step forward, gently but firmly taking hold of her thighs, positioning your " + cockDescript(x) + " against her slavering cunt.  Certain you are in position, you glide it home.  She shudders and audibly slurps on her cock as you sheathe yourself in her slick, velvety, burning hot nether lips.  You pull back and thrust home again, even as she begins to bob her head.\n\n", false);
	
	outputText("It is awkward, at first, the two of you trying to set up mutually complementary rhythms.  She hums and rumbles in her throat, striving to coax the most pleasure from her male genitalia, even as your thrusts and bucks make her cunt slurp and squelch, her copious lubricants slopping across your dick", false);
	if(player.balls > 0) outputText(", your balls,", false);
	outputText(" and your inner thighs.  But, as you keep going, you get into the rhythm and it becomes more pleasurable.\n\n", false);
	
	outputText("It's impossible to describe just how kinky this is; her hot, wet walls wrapped like a silken vise around your cock, her head bobbing and gurgling on her own right in front of you", false);
	if(flags[kFLAGS.KATHERINE_DICK_COUNT] > 1) outputText(", and her lower shaft waving in the air between you as if to conduct the performance", false);
	outputText(".  You thrust into her harder and harder; you can feel your climax coming... but she's the one who comes first.  With a muffled yowl, she squirts femcum from her cunt, splattering your belly in her juices.  The cry is cut off and her lips and cheeks visibly bulge as her knot suddenly inflates, trapping her cock in her own mouth and forcing her to drink every last drop as her balls release their cargo into her.  ", false);
	if(flags[kFLAGS.KATHERINE_BALL_SIZE] <= 1) outputText("She gulps several times, loudly drinking until her balls are empty, but even so she remains locked in place, her knot trapping her until she's fully climaxed.", false);
	else if(flags[kFLAGS.KATHERINE_BALL_SIZE] <= 3) outputText("She has to drink quickly to avoid choking on her own copious discharge, but finally, belly beginning to bulge, she's drunk it all.", false);
	else outputText("With a frantic look she swallows and swallows, and you can't help the frightening thought she may drown in her own spunk.  But, as her belly swells and she looks verifiably pregnant, her balls stop trembling and she's done, panting and taking deep, grateful breathes through her nose.", false);
	outputText("\n\n", false);

	outputText("And now, at last, it's your turn to cum, and with a loud moan you release into her.  ", false);
	if(player.cumQ() <= 250) outputText("You spray everything you have into her sloppy, sopping-wet cunt, allowing it to join the other fluids already dripping from her gash.", false);
	//Moderate Cum + 1</i>\" katballs: 
	else if(player.cumQ() <= 750) {
		if(flags[kFLAGS.KATHERINE_BALL_SIZE] <= 1) outputText("  Her belly bulges as you flood her womb with your sperm, visibly distended from your efforts.", false);
		else outputText("  She looks heavily pregnant by the time you are done, her bellybutton beginning to brush against her chin.", false);
	}
	else {
		if(flags[kFLAGS.KATHERINE_BALL_SIZE] <= 1) outputText("  Your unnatural orgasm leaves her visibly bloated and distended, stomach swollen and round in the curve of her body.", false);
		else outputText("  The cat herm looks panicked as you just keep pouring jet after jet into her body, her womb swelling and her skin already distended from her own massive discharge into her stomach.  Her belly swells out and out until it is visibly pushing against her neck and upper torso, her own body forming an impenetrable barrier that leaves it with nowhere to expand to, the pressure making your cum squirt out in jets that splatter all over the alley.", false);
	}
	outputText("\n\n", false);

	outputText("Your climax finished, you pull out", false);
	if(player.cumQ() > 250) outputText(", allowing a cascade of jism to flow like a perverse waterfall in miniature from her cunt,", false);
	outputText(" and step back to catch your breath.  Your smile at her, initially one of pleased relief, turns to wry grin as you realise she's still knotted up and plugged inside her own mouth.  She looks at you as best she can and blinks.  With a gentle expression you step close and reach out to stroke her ears; nothing sexual, just gentle and relaxing. She closes her eyes and visibly leans into the caresses.\n\n", false);

	outputText("You stay like that until her knot shrinks down and, with a wet popping sound, she uncurls herself.  \"<i>Boy, that was really something,</i>\" she declares in an amazed tone", false);
	if(player.cumQ() > 250) {
		outputText(", slapping her ", false);
		if(player.cumQ() > 750) outputText("hugely ", false);
		outputText("swollen, cum-filled gut for emphasis", false);
	}
	outputText(".  \"<i>I'm ready to try that again if ever you are.</i>\"\n\n", false);
	
	outputText("You promise her you'll remember that.  Redressed, you bid her farewell and head back out into the streets of Tel'Adre.\n\n", false);
	//lust -100, Player returns to Tel'Adre Menu Screen or to camp, if code insists on it
	dynStats("sen", -1, "lus=", 0);
	flags[kFLAGS.KATHERINE_TIMES_SEXED]++;
	doNext(13);
}

//Get Penetrated
private function letKatKnotYou():void {
	var x:Number;
	outputText("", true);
	outputText("You ask Katherine if she'd like to penetrate you.  She looks startled, then grins like the proverbial cat that ate the canary.  \"<i>Well, all right then...</i>\" she declares, swiftly stripping off her clothes.  \"<i>Get undressed, turn around and kneel on the ground.</i>\"  Her canine cock", false);
	if(flags[kFLAGS.KATHERINE_DICK_COUNT] > 1) outputText("s are", false);
	else outputText(" is", false);
	outputText(" already starting to peek out of her sheath, as if to echo her instructions.\n\n", false);

	outputText("You do as you are told, but you can't resist teasing her about wanting 'doggy-style' sex.\n\n", false);

	outputText("The mismatched herm steps up behind you and gives you a playful slap on your " + buttDescript() + ".  \"<i>Well, I've got dog dick", false);
	if(flags[kFLAGS.KATHERINE_DICK_COUNT] > 1) outputText("s", false);
	outputText(", so I'm just doing it the way nature intended,</i>\" she cracks.", false);
	//(if player has anus & vagina: 
	if(player.hasVagina()) outputText("  \"<i>So, which hole do you want me to use?</b>\"", false);
	//[Vagina] [Anus] [Double Penetrate] [Sucked 'n' Fucked]
	var dubs:Function = null;
	if(flags[kFLAGS.KATHERINE_DICK_COUNT] > 1 && player.hasVagina()) dubs = getDoublePennedByKat;
	var sukn:Function = null;
	var vag:Function = null;
	if(player.hasVagina()) vag = letKatKnotYourCuntPussyFuck;
	//This scene requires the PC has a penis and has fucked Kat at least once since moving her
	if(player.hasCock() && flags[kFLAGS.KATHERINE_TIMES_SEXED] > 0) sukn = suckedNFuckedByKat;
	simpleChoices("Vagina",vag,"Anus",getPenetrated,"DblPenetr",dubs,"SuckNFuckd",sukn,"",0);
}

//Get Penetrated (Vaginal)
private function letKatKnotYourCuntPussyFuck():void {
	outputText("", true);
	outputText("You indicate to Katherine that you want it in your " + vaginaDescript() + ".\n\n", false);

	outputText("Her furry hands promptly begin to rub possessively over your " + assDescript() + ", slowly moving up to take hold of your " + hipDescript() + ".  \"<i>Well, all right... if that's what you want...</i>\"  You feel her running ", false);
	if(flags[kFLAGS.KATHERINE_DICK_COUNT] == 1) outputText("her", false);
	else outputText("the topmost", false);
	outputText(" " + flags[kFLAGS.KATHERINE_DICK_LENGTH] + "\" cock against your sensitive pussy lips, letting you feel its rubbery-smooth length, then, drawing back her hips, she suddenly thrusts it home without any hesitation.", false);
	if(flags[kFLAGS.KATHERINE_DICK_COUNT] > 1) {
		outputText("  Her second cock slaps lewdly against your ", false);
		if(player.hasCock()) outputText(multiCockDescriptLight(), false);
		else if(player.balls > 0) outputText(sackDescript(), false);
		else outputText("belly", false);
		outputText(".", false);
	}
	var cunt:Number = player.vaginas[0].vaginalLooseness;
	//(hymen check and stretching)
	player.cuntChange(2 * flags[kFLAGS.KATHERINE_DICK_LENGTH],true,true,false);
	outputText("\n\n", false);

	if(cunt < player.vaginas[0].vaginalLooseness) {
		outputText("You can't help but yelp in shock and look back over your shoulder at Katherine, who has the grace to appear apologetic.  \"<i>Sorry!  But I need to penetrate fast - or would you rather wait until my knot's fully swollen?</i>\"  You concede she has a point, but ask her to remember to be more gentle next time.\n\n", false);
	}

	outputText("Fingers digging into your hips, she begins to thrust back and forth inside of you", false);
	if(flags[kFLAGS.KATHERINE_DICK_COUNT] > 1) outputText(", her second cock still slapping wetly against you and smearing trickles of pre-cum that stretch and dangle as it bounces", false);
	outputText(".  She grunts and groans.  \"<i>Oh- Oh yeah, you're unbelievable!", false);
	if(player.harpyScore() >= 4 || player.sharkScore() >= 4 || player.catScore() >=4 || player.dogScore() >= 4 || player.bunnyScore() >= 4) outputText("  Mmm... yeah, that's it, moan for me, you little slut; who's the alpha, huh?  Katherine's your alpha - go on, say it!</i>\" she yells, pounding herself into you with greater force, her claws extending just far enough to begin biting into your flesh, pinpricks of pain to counter the pleasure.", false);
	else outputText("</i>\"", false);
	outputText("\n\n", false);

	outputText("You moan and gasp, thrusting your ass back into your feline lover's midriff to facilitate your fucking", false);
	if(player.isNaga() || player.tailType == TAIL_TYPE_LIZARD || player.tailType == TAIL_TYPE_DEMONIC) outputText(", snaking your tail up between her breasts and playfully stroking her cheek,", false);
	outputText(" and crying out her name.  You can feel her knot starting to swell inside you even as she picks up the pace with which she hammers into you.\n\n", false);

	outputText("\"<i>Ohhh!  Gonna plug you up; fill you fulla kitty-cat spunk!</i>\" Katherine moans, her knot growing to its maximum size inside of you, anchoring you together so that she can no longer pull out.", false);
	//(stretch check again)
	cunt = player.vaginas[0].vaginalLooseness;
	player.cuntChange(2 * flags[kFLAGS.KATHERINE_DICK_LENGTH],true,true,false);
	outputText("  She lunges forward and grabs your shoulders, trying to push her way in deeper.", false);
	//(if stretched: 
	if(cunt < player.vaginas[0].vaginalLooseness) outputText("  The amount of swollen cockmeat she's stuffing inside you is on the border of being painful, but mostly it's pleasure that fills you.", false);
	else outputText("  Thanks to the glovelike fit your pussy has on her knot, it feels nothing but good to be plugged up like this.", false);
	outputText("\n\n", false);
	
	outputText("You shudder and gasp as your own climax suddenly rocks through you", false);
	if(player.hasVagina()) outputText(", femcum splashing from your " + vaginaDescript(), false);
	if(player.hasCock()) {
		outputText(" and your cocks spurting ", false);
		if(player.cumQ() < 25) outputText("drops", false);
		else if(player.cumQ() < 100) outputText("splashes", false);
		else if(player.cumQ() < 250) outputText("puddles", false);
		else outputText("a veritable lake of spunk into the alleyway", false);
	}
	outputText(".\n\n", false);

	outputText("She suddenly arches her back and lets out a yowl of pleasure as her orgasm follows, rippling through her; she cums, groaning, inside you", false);
	if(flags[kFLAGS.KATHERINE_DICK_COUNT] > 1) outputText(", with more spurting from her second cock to glaze your belly and the ground below", false);
	outputText(".  ", false);
	//(1" balls: 
	if(flags[kFLAGS.KATHERINE_BALL_SIZE] <= 1) outputText("She makes a surprisingly large amount of cum for such small balls, and you can feel it sloshing and slurping inside you, leaving you deliciously full of cat-cream.", false);
	//(3" balls: 
	else if(flags[kFLAGS.KATHERINE_BALL_SIZE] <= 3) outputText("Jet after jet of cum sprays inside you, flooding all the way up into your womb; by the time the dog-dicked cat stops, your belly is starting to bulge from all she's given you.", false);
	//(5" balls: 
	else {
		outputText("She cums and she cums and she cums; how can she hold this much spooge inside her balls?  Your womb is flooded until by the time she finishes, you look certifiably pregnant and ", false);
		//[6" knot: 
		if(flags[kFLAGS.KATHERINE_KNOT_THICKNESS] >= 6) outputText("only her huge knot is keeping everything plugged inside you.", false);
		else outputText("some of it actually starts leaking out around her knot.", false);
	}
	outputText("  Her load spent, she collapses bonelessly onto her back - thanks to her knot, though, she remains plugged inside you and you yelp in shock as her weight pulls you backward.\n\n", false);

	outputText("\"<i>Oops.  Sorry,</i>\" Katherine apologises.  ", false);
	//(6" knot: 
	if(flags[kFLAGS.KATHERINE_KNOT_THICKNESS] >= 6) outputText("\"<i>I'm afraid we're going to have to stay like this until I deflate - I don't want to think about how badly I'd hurt you trying to pull free.", false);
	//(4" knot: 
	else if(flags[kFLAGS.KATHERINE_KNOT_THICKNESS] >= 4) outputText("\"<i>Give me a little while and I should deflate enough that I can pull free of you.", false);
	else outputText("\"<i>If you pull hard enough, I should pop right out of you.", false);
	outputText("</i>\"\n\n", false);
	
	//[(PC is very loose)
	if(player.vaginalCapacity() >= 100) outputText("Nonplussed by the idea of waiting naked and penetrated in a back alley, and eager to see the look on Katherine's face, you pull apart anyway; your thoroughly stretched-out pussy relinquishes the knot with no more than a long sucking noise.  Free of her, you look back over your shoulder.  As you guessed, Katherine is sitting there wordlessly with her mouth open, staring alternately at the abused, cum-drooling lips of your pussy and at the enormous mass of flesh you just managed to pass through it.", false);
	else outputText("You tell her that it's all right; you'll stay here with her until nature takes its course.  Even though you can't really see her, given your respective positions, you know she's smiling.", false);
	outputText("\n\n", false);	

	if(player.vaginalCapacity() < 100) outputText("About an hour later, she's deflated and y", false);
	else outputText("Y", false);
	outputText("ou get dressed, thank her, and head back to your camp.", false);
	//minus lust, slimefeed, Player returns to camp
	dynStats("sen", -1, "lus=", 0);
	player.slimeFeed();
	flags[kFLAGS.KATHERINE_TIMES_SEXED]++;
	doNext(13);
}

//Get Penetrated (Anal)
private function getPenetrated():void {
	outputText("", true);
	outputText("You indicate to Katherine that you want it in your " + assholeDescript() + ".\n\n", false);

	outputText("\"<i>Well, I can't say I'm a big fan of the idea, but okay...</i>\"  Her furry hands promptly begin to rub possessively over your " + buttDescript() + ", slowly moving up to take hold of your " + hipDescript() + ".  \"<i>... if that's what you want.</i>\"  You feel her rubbing her ", false);
	if(flags[kFLAGS.KATHERINE_DICK_COUNT] > 1) outputText("bottom-most ", false);
	outputText("cock against your anus, letting your cheeks feel its rubbery-smooth length, then, drawing back her hips, she suddenly thrusts it between them without any hesitation", false);
	if(flags[kFLAGS.KATHERINE_DICK_COUNT] > 1) outputText(", as her upper cock bounces along your back", false);
	outputText(".\n\n", false);

	outputText("\"<i>Gonna - mmm - need just a bit of lube here...</i>\" she mumbles, dragging her cock");
	if(flags[kFLAGS.KATHERINE_DICK_COUNT] > 1) outputText("s");
	outputText(" between your buttcheeks.  As she says it, her body matches deed to her word and the puppy pecker begins drooling a slick, warm fluid into your asscrack", false);
	if(flags[kFLAGS.KATHERINE_DICK_COUNT] > 1) outputText(", as well as onto the cheeks, with the other bouncing around above them", false);
	outputText(".  With soft hands, she rubs the goo into your pucker and all over her pointed shaft, then a void of sensation as she pulls it from your asscheeks.  Before you can react, she pushes them open again and rams her cock into your anus!", false);
	//(butt hymen check + stretch check)
	var butts:Number = player.ass.analLooseness;
	player.buttChange(flags[kFLAGS.KATHERINE_DICK_LENGTH] * 2,true,true,false);
	outputText("\n\n", false);
	
	if(butts > player.ass.analLooseness) outputText("You can't help but yelp in shock and look back over your shoulder at Katherine, who appears genuinely apologetic.  \"<i>Sorry!  But I need to penetrate sooner rather than later - or would you rather wait until my knot's fully swollen?</i>\"  You concede she has a point, but beg her to be more gentle if there's a next time.\n\n", false);

	outputText("Fingers digging into your hips, she begins to thrust back and forth inside you", false);
	if(flags[kFLAGS.KATHERINE_DICK_COUNT] > 1) outputText(", her secondary cock slapping wetly against your back", false);
	outputText(".  She grunts and groans, \"<i>Oh- Oh yeah, you're unbelievable!", false);
	//[(player has high harpy/shark/cat/dog/bunny score)  
	if(player.harpyScore() >= 4 || player.sharkScore() >= 4 || player.catScore() >=4 || player.dogScore() >= 4 || player.bunnyScore() >= 4)
		outputText("  Mmm... yeah, that's it, moan for me, you little slut; who's the alpha bitch, huh?  Katherine's your alpha - go on, say it!</i>\"  She yells out, pounding herself into you with greater force and her claws extend just far enough to begin biting into your flesh, pinpricks of pain to counter the pleasure.\n\n", false);
	else outputText("</i>\"\n\n", false);
		
	outputText("You moan and gasp, thrusting your ass back into your feline lover's midriff to facilitate your fucking", false);
	if(player.isNaga() || player.tailType == TAIL_TYPE_LIZARD || player.tailType == TAIL_TYPE_DEMONIC) {
		outputText(",  snaking your tail up between her breasts and playfully stroking her cheek,", false);
	}
	outputText(" and crying out her name.  You can feel her knot starting to swell inside you even as she picks up the pace with which she hammers into you.\n\n", false);
	
	outputText("\"<i>Ohhh!  Gonna plug you up; fill you fulla kitty-cat spunk!</i>\" Katherine moans, her knot filling to its maximum size inside of you, anchoring you together so that she can no longer pull out.  She lunges forward and grabs your shoulders, trying to push her way in deeper.", false);
	//(6" knot:
	if(flags[kFLAGS.KATHERINE_KNOT_THICKNESS] >= 6) outputText("  It feels like she's trying to shove a melon inside you; and you cry out in equal parts pain and pleasure at being stuffed so full.", false);
	else if(flags[kFLAGS.KATHERINE_KNOT_THICKNESS] >= 4) outputText("  The amount of swollen cockmeat she's stuffing inside you is on the border of being painful, but mostly it's sheer pleasure that fills you.", false);
	else outputText("  Thanks to her relatively normal-sized knot, it feels nothing but good to be plugged up like this.", false);
	outputText("\n\n", false);

	outputText("You shudder and gasp as your own climax suddenly rocks through you", false);
	if(player.hasVagina()) {
		outputText(", femcum splashing from your " + vaginaDescript(), false);
		if(player.hasCock()) outputText(" and ", false);
	}
	if(player.cockTotal() > 0) {
		if(!player.hasVagina()) outputText(", ", false);
		outputText(sMultiCockDesc() + " spurting ", false);
		if(player.cumQ() < 25) outputText("drops", false);
		else if(player.cumQ() < 100) outputText("splashes", false);
		else if(player.cumQ() < 250) outputText("puddles", false);
		else outputText("a veritable lake of spunk into the alleyway", false);
	}
	outputText(" as your asshole wrings the invader.\n\n", false);

	outputText("She suddenly arches her back and lets out a yowl of pleasure as her orgasm follows, rippling through her; she cums, groaning, inside you", false);
	if(flags[kFLAGS.KATHERINE_DICK_COUNT] > 1) outputText(", with more spurting from her second cock to glaze your back and drool off onto the ground below you", false);
	outputText(".  ", false);
	//(1" balls: 
	if(flags[kFLAGS.KATHERINE_BALL_SIZE] <= 1) outputText("She makes a surprisingly large amount of cum for such small balls, and you can feel it sloshing and slurping inside you, leaving you deliciously full of cat-cream.", false);
	//(3" balls:
	else if(flags[kFLAGS.KATHERINE_BALL_SIZE] <= 3) outputText("Jet after jet of cum sprays inside you, flooding all the way up into your bowels; by the time the dog-dicked cat stops, your belly is starting to bulge from all the cum she's given you.", false);
	//(5" balls: 
	else {
		outputText("She cums and she cums and she cums; how can she hold this much spooge inside her balls?  Your stomach is flooded with cum until, by the time she finishes, you look certifiably pregnant and ", false);
		if(flags[kFLAGS.KATHERINE_KNOT_THICKNESS] >= 6) outputText("only her huge knot is keeping everything plugged inside you", false);
		else outputText("some of it actually starts leaking out around her knot", false);
		outputText("; you stifle a belch and taste her salty, spunk on the back of your tongue", false);
	}
	outputText(".  Her load spent, she collapses bonelessly onto her back - thanks to her knot, though, she remains plugged inside you and you yelp in shock as her weight pulls you backward.\n\n", false);

	outputText("\"<i>Oops.  Sorry,</i>\" Katherine apologises.  ", false);
	//(6" knot: 
	if(flags[kFLAGS.KATHERINE_KNOT_THICKNESS] >= 6) outputText("\"<i>I'm afraid we're going to have to stay like this until I deflate - I don't want to think about how badly I'd hurt you trying to pull free.", false);
	//(4" knot: 
	else if(flags[kFLAGS.KATHERINE_KNOT_THICKNESS] >= 4) outputText("\"<i>Give me a little while and I should deflate enough that I can pull free of you.", false);
	else outputText("\"<i>If you pull hard enough, I should pop right out of you.", false);
	outputText("</i>\"\n\n", false);
	
	outputText("You tell her that it's all right; you'll stay here with her until nature takes its course. Even though you can't really see her, given your respective positions, you know she's smiling.\n\n", false);

	outputText("About an hour later, she's deflated and you are able to get dressed, thank her, and head back to your camp.", false);
	//minus lust, slimefeed, Player returns to camp
	dynStats("sen", -1, "lus=", 0);
	player.slimeFeed();
	flags[kFLAGS.KATHERINE_TIMES_SEXED]++;
	doNext(13);
}

//Get Penetrated (Double)
private function getDoublePennedByKat():void {
	outputText("", true);
	outputText("You indicate to Katherine that you want it in both holes.\n\n", false);

	outputText("She starts in shock at the proposal, then slowly, she nods her head.  \"<i>All right... if that's what you want.</i>\"  Despite her tone, her furry hands promptly begin to rub possessively over your " + assDescript() + ", slowly moving up to take hold of your " + hipDescript() + ".  \"<i>Hmm... this is so kinky, but I think it just might work...</i>\"  She murmurs, mostly to herself, and you feel her running her " + katCock() + " cocks against your sensitive pussy lips and your tingling anus, letting you feel their rubbery-smooth length, then, drawing back her hips, she suddenly thrusts the bottom one home without any hesitation.  The other slides along your asscrack harmlessly.", false);
	player.cuntChange(flags[kFLAGS.KATHERINE_DICK_LENGTH] * 2, true, true, false);
	//[check vag hymen and stretch it]
	outputText("\n\n", false);

	outputText("You can't help but look back over your shoulder at Katherine, who appears rapt with concentration.  \"<i>Sorry!  But this will be tricky... I need to penetrate fast, but I need some lube, too - unless you want to try and take my knot completely dry!</i>\"  She looks down and pushes the upper shaft between your buttcheeks.\n\n", false);

	outputText("Fingers digging into your hips, she begins to thrust back and forth inside of you, dragging one shaft through your pussy and the other through your cheeks.  \"<i>Mmm, you're so good... I could come from this alone,</i>\" she moans.  As if to echo the sentiment, a slow stream of pre-cum infiltrates your asscrack.  \"<i>Ahh, here it comes...</i>\"  She pulls her shafts out just as you feel a minute stiffening of the knots at their bases, and you can hear her smearing her pre-cum", false);
	if(player.hasVagina()) outputText(" and your copious girl-lube", false);
	outputText(" along her lengths.  Your " + assholeDescript() + " does not go neglected either; after she's done rubbing herself to slickness, a palmful of warm gooeyness is pushed into it.  She must already be drooling a huge amount if she's got this much to donate!  Almost on cue, she confirms your hunch with a moan.  \"<i>Ahhh, gotta put it in now!  I can't hold back anymore, I'm sorry!</i>\"  A hot pressure on both holes is the only warning you get before her twin talents are forced into you, sliding easily into your already wet vagina and pushing past your ring by virtue of the tapered shape and the slickness.", false);
	player.buttChange(flags[kFLAGS.KATHERINE_DICK_LENGTH] * 2, true, true, false);
	outputText("\n\n", false);

	outputText("She begins thrusting at once, grunting and groaning as if she were already near her peak.  \"<i>Oh- Oh yeah, you're unbelievable!  It's so weird, I'm fucking two holes at once, but it's so good!</i>\" she cries out.  Her usually firm grip is shaky and unreliable, further evidence of the trouble she's having in controlling her climax.\n\n", false);

	outputText("You thrust your ass back toward your feline lover's midriff with an unseen, malicious smile, intent on forcing her to finish shamefully quickly, and cry out her name in your best bedroom voice.  You can feel her knot starting to swell inside you even as she picks up the pace she hammers into you.\n\n", false);

	outputText("\"<i>Ohhh!  G-gonna plug you up; fill you fu-full...!</i>\" Katherine moans distractedly, her knots filling to their maximum size inside of you and anchoring you together so that she can no longer pull out.  She lunges forward and grabs at your shoulders to push her way in deeper, but slips off weakly as her orgasm arrives.\n\n", false);

	outputText("She suddenly arches her back and lets out a yowl of pleasure as it ripples through her and she cums inside you.  ", false);
	//(1" balls:
	if(flags[kFLAGS.KATHERINE_BALL_SIZE] <= 1) outputText("She makes a surprisingly large amount of cum for such small balls, and you can feel it sloshing and slurping inside you, leaving you deliciously full of cat-cream.", false);
	else if(flags[kFLAGS.KATHERINE_BALL_SIZE] <= 3) outputText("Jet after jet of cum sprays inside you, flooding all the way up into your womb and bowels; by the time the dog-dicked cat stops, your belly is starting to bulge from all the cum she's given you.", false);
	else {
		outputText("She cums and she cums and she cums; how can she hold this much spooge inside her balls?  Your womb and your stomach are flooded with cum until, by the time she finishes, you look certifiably pregnant and ", false);
		if(flags[kFLAGS.KATHERINE_KNOT_THICKNESS] >= 6) outputText("only her huge knots are keeping everything plugged inside you.", false);
		else outputText("some of it actually starts leaking out around her knots.", false);
	}
	outputText("  Her load spent, she collapses bonelessly onto her back - thanks to her knot, though, she remains plugged inside you and you yelp in shock as her weight pulls you backward until you're sitting on her.\n\n", false);

	outputText("\"<i>Oops.  Sorry,</i>\" Katherine apologises.  ", false);
	//(6" knot: 
	if(flags[kFLAGS.KATHERINE_KNOT_THICKNESS] >= 6) outputText("\"<i>I'm afraid we're going to have to stay like this until I deflate - I don't want to think about how badly I'd hurt you trying to pull free.", false);
	//(4" knot: 
	else if(flags[kFLAGS.KATHERINE_KNOT_THICKNESS] >= 4) outputText("\"<i>Give me a little while and I should deflate enough that I can pull free of you.", false);
	else outputText("\"<i>If you pull hard enough, I should pop right out of you.", false);
	outputText("</i>\"\n\n", false);
	
	outputText("You tell her that it's no matter if she can't pull out; you haven't gotten your own orgasm yet.  As you watch her face over your shoulder, her feline eyes widen.  \"<i>Oh!  I'm so sorry... gods, I wasn't even thinking.  What... what are you gonna do?</i>\"\n\n", false);

	outputText("Turning back to hide your wicked grin, you begin to bounce up and down on her knotted, still-hard shafts.", false);
	//[(Katballs >=3</i>\")
	if(flags[kFLAGS.KATHERINE_BALL_SIZE] >= 3) outputText("  Her cum sloshes fluidly inside you, adding to the sensations assaulting your cervix and bowels.", false);
	outputText("\n\n", false);

	outputText("\"<i>O-oh Marae!  It's too much!  Please stop, they're so sensitive right now!</i>\" cries the cat-girl as you continue to ride her knotted shafts, reverse cowgirl style.  She paws at your hips as if to gain respite, but her slack, spent muscles can't keep you from completing your orgasm.  Fueled by her whimper-like moaning and the sensations inside you, it follows soon; as your anus and vagina squeeze her dicks in the throes of climax, a second burst from her follows, stretching your belly", false);
	if(flags[kFLAGS.KATHERINE_BALL_SIZE] >= 5) outputText(" to its limit", false);
	outputText(" as she fills you with a smaller, second load of jizz.", false);
	if(player.hasCock()) outputText("  " + SMultiCockDesc() + " celebrates with arcs of its own semen, spraying them in a patter on her legs and the ground in front of you.", false);
	outputText("  The cat-woman gasps and twitches as her new ejaculation reverberates through her body, but forms no words, only looking up at the walls overhead.", false);
	outputText("\n\n", false);
	
	outputText("About an hour later, she's deflated and you are finally able to rise off of her, get dressed, and head back to your camp.\n\n", false);
	//minus lust, slimefeed, Player returns to Tel'Adre Menu Screen or to camp, if code insists on it
	player.slimeFeed();
	dynStats("sen", -2, "lus=", 0);
	flags[kFLAGS.KATHERINE_TIMES_SEXED]++;
	doNext(13);
}

//Sucked 'n' Fucked
//This scene requires the PC has a penis and has fucked Kat at least once since moving her
private function suckedNFuckedByKat():void {
	var x:Number = player.biggestCockIndex();
	outputText("", true);
	outputText("As you crouch, trying to figure out how you want your herm lover to take you, you start when you feel Katherine's fingers suddenly caressing your " + cockDescript(x) + ".\n\n", false);

	outputText("\"<i>Hmm... I think you deserve a special treat, my sweet.  Roll over onto your back...</i>\" Katherine purrs, giving you a stroke to make you as stiff as possible before releasing you.\n\n", false);

	outputText("Wondering what she has in mind, you do as you are told, rolling onto your back and lying there with your prick aimed at the sky and your ", false);
	if(player.isNaga()) outputText("tail flat", false);
	else outputText("legs spread", false);
	outputText(".  Katherine advances toward you and kneels down, reaching over your stomach and petting your " + chestDesc() + " with a smile.  \"<i>You're very special to me, you know that?  Well, to prove that, I'm going to show you a real good time...</i>\"  She grins, passing her tongue over her lips with exaggerated anticipation.\n\n", false);

	outputText("As you watch, she bends over from where she's sitting until she can lick your " + cockDescript(x) + ", her long, feline tongue running up and down its length, tickling the head.  The sensation is strange; bristly, but not sharp, so it's like being stroked by lots of little tongues at the same time.  pre-cum begins flowing from your cock-tip like water bubbling from an underground spring, and your feline lover visibly savors the taste before leaning back upright, smacking her lips and smiling at your protest.\n\n", false);

	outputText("\"<i>Naughty, naughty; have you forgotten who's fucking whom, this time?</i>\"  She purrs at you, one hand slipping forward to caress ", false);
	if(player.hasVagina()) outputText("your " + vaginaDescript(), false);
	else outputText("between your asscheeks", false);
	outputText(".  Taking hold of your " + hipDescript() + ", she slides her cock", false);
	if(flags[kFLAGS.KATHERINE_DICK_COUNT] > 1) outputText("s", false);
	outputText(" forward until she's hovering at the entrance to your ", false);
	if(flags[kFLAGS.KATHERINE_DICK_COUNT] > 1 && player.hasVagina()) outputText(vaginaDescript() + " and " + assholeDescript(), false);
	else outputText(player.assholeOrPussy(), false);
	outputText(".  Taking a bit of the pre-cum drooling from your prick, she slathers it over her cock", false);
	if(flags[kFLAGS.KATHERINE_DICK_COUNT] > 1) outputText("s", false);
	outputText(".  Then, without further ado, she slides herself into you.", false);
	if(flags[kFLAGS.KATHERINE_DICK_COUNT] > 1 && player.hasVagina()) {
		player.buttChange(flags[kFLAGS.KATHERINE_DICK_LENGTH] * 2, true, true, false);
		player.cuntChange(flags[kFLAGS.KATHERINE_DICK_LENGTH] * 2, true, true, false);
	}
	else if(player.hasVagina()) player.cuntChange(flags[kFLAGS.KATHERINE_DICK_LENGTH] * 2, true, true, false);
	else player.buttChange(flags[kFLAGS.KATHERINE_DICK_LENGTH] * 2, true, true, false);
	outputText("\n\n", false);
	
	outputText("\"<i>Now, then, let's give this a shot...</i>\" she murmurs to herself, beginning to slowly rock back and forth within you, sliding her cock", false);
	if(flags[kFLAGS.KATHERINE_DICK_COUNT] > 1) outputText("s", false);
	outputText(" out and then thrusting home, her knot", false);
	if(flags[kFLAGS.KATHERINE_DICK_COUNT] > 1) outputText("s", false);
	outputText(" starting to swell and stretching you out in all the right ways... if only she wasn't going so slow, this would be so great.  But any complaints about the pace are lost when she bends over again and starts to lap at your " + cockDescript(x) + ", running her tongue over and around it several times before she takes it into her mouth, swallowing inch after inch of " + Appearance.cockNoun(CockTypesEnum.HUMAN) + " until her nose is pressed flat into the base of your belly.  She lets out a muffled grunt that might be \"<i>right</i>\", then tries to manage the task of picking up the pace of her thrusts while sucking and slurping on your " + cockDescript(x) + " at the same time.\n\n", false);

	outputText("You're in no position to complain.  This feels... incredible!  Her mouth around your cock is so hot and wet, her tongue sliding along the underside of your shaft and stroking in a sensation that no human could ever match, greedily sucking on you and hungry for everything you have.  At the same time, she's stretching your hole", false);
	if(player.hasVagina() && flags[kFLAGS.KATHERINE_DICK_COUNT] > 1) outputText("s", false);
	outputText(" so deliciously full, knot", false);
	if(player.hasVagina() && flags[kFLAGS.KATHERINE_DICK_COUNT] > 1) outputText("s", false);
	outputText(" flaring inside you and anchoring you together.  You rock back and forth, thrusting your hips awkwardly in an effort to fuck and be fucked as hard as possible, and feel the oh-so-sweet sensation of release boiling away ", false);
	if(player.balls > 0) outputText("in your " + ballsDescriptLight(), false);
	else outputText("at the base of your spine", false);
	outputText("...\n\n", false);

	outputText("But it's Katherine who cums first.  With a muffled yowl of delight she floods your hole", false);
	if(player.hasVagina() && flags[kFLAGS.KATHERINE_DICK_COUNT] > 1) outputText("s", false);
	outputText(" with her spunk, gushing hot kitty-kum into your depths.  Your belly begins to swell from the spunk, bulging into a visible paunch", false);
	//(balls3</i>\":
	if(flags[kFLAGS.KATHERINE_BALL_SIZE] >= 3) outputText(" and it doesn't stop, growing and growing until you look pregnant and ready to deliver", false);
	if(flags[kFLAGS.KATHERINE_BALL_SIZE] >= 5) outputText(" and then her swollen balls keep on going; by the time they finally run dry, your belly is so heavy with deposited cum that you look like you're having triplets", false);
	outputText(".  She slumps forward with a groan of blissed-out relief, spent from her climax.\n\n", false);

	outputText("And then it's your turn to cum, flooding the startled, oblivious cat's mouth with your remembrance and making her swallow rapidly to keep it down.  ", false);
	//(Low/Normal: 
	if(player.cumQ() <= 250) outputText("She drinks every last drop with gusto, popping wetly off of your cock and licking her lips as she audibly purrs with delight.", false);
	//(High: 
	else if(player.cumQ() <= 600) outputText("She gulps it down desperately, stomach swelling with the influx of spunk, but manages to avoid spilling anything, popping her head free and gasping for breath as soon as she thinks you're done.", false);
	//(Very High: 
	else outputText("You can see a hint of panic at the titanic cascade of fluids coming from your " + cockDescript(x) + ", but it's drowned out by sudden steely-eyed determination to drink every last drop.  Her belly swells out like a waterskin being held in a waterfall, rivulets of cum flooding from her overwhelmed mouth, but she manages to avoid pulling your cock out until you're finished.  Then she weakly manages to detach herself and gives you a triumphant expression, and a faint burp.\n\n", false);

	outputText("With a groan she allows herself to collapse atop you, ", false);
	if(flags[kFLAGS.KATHERINE_BALL_SIZE] < 3) {
		if(player.cumQ() <= 250) outputText(" leaving you lying belly-to-belly", false);
		else outputText(" her cum-bloated belly squishing audibly against your own flat torso", false);
	}
	else {
		if(player.cumQ() <= 250) outputText(" making your cum-swollen gut squelch wetly from the pressure", false);
		else outputText(" your mutually swollen bellies churning and rippling as they cushion the impact", false);
	}
	outputText(".  \"<i>Quite an experience, wasn't it?</i>\"  She grins, her hand tentatively inching towards yours.\n\n", false);

	outputText("You entwine her fingers with your own and agree that it was.\n\n", false);

	outputText("Once her knot", false);
	if(flags[kFLAGS.KATHERINE_DICK_COUNT] > 1 && player.hasVagina()) outputText("s", false);
	outputText(" deflate and you detach, you clean yourself off, get dressed, and head back out into the street.", false);
	//lust -100, slimefeed, Player returns to Tel'Adre Menu Screen or to camp, if code insists on it
	player.slimeFeed();
	dynStats("sen", -1, "lus=", 0);
	flags[kFLAGS.KATHERINE_TIMES_SEXED]++;
	doNext(13);
}

//Oral
private function oralKatherineChoices():void {
	outputText("", true);
	outputText("With a smirk, you suggest a taste test.  Katherine blinks, then smiles. \"<i>Fine by me... but who's going to be the taster?</i>\"\n\n", false);
	var getOral:Function = null;
	//[PC Sucks] [Katherine Laps]
	if(player.gender > 0) getOral = katherineGivesPCOralAllDayLongDotJPG;
	simpleChoices("PC Sucks",giveKatOralPenisWingWang,"Kath.Laps",getOral,"",0,"",0,"",0);
}
//Give Katherine Oral scene, single cock
private function giveKatOralPenisWingWang():void {
	outputText("", true);
	if(flags[kFLAGS.KATHERINE_DICK_COUNT] == 1) {
		outputText("With a small grin, you tell Katherine that you wouldn't mind satisfying her orally.\n\n", false);
	
		outputText("\"<i>But... " + player.short + ", are you sure? I mean, with the knot, that's a lot to work with...  And I don't want to leave you with nothing, either...</i>\"\n\n", false);
	
		outputText("You reassure her that you don't mind at all - in fact, you want to do this and probably will like doing it.\n\n", false);
	
		outputText("Avoiding eye contact and apparently blushing under the fur, Katherine answers.  \"<i>Okay.  If this is really what you want.  Just please, be careful, especially for your own good, okay?</i>\"\n\n", false);
	
		outputText("You motion for her to half-sit on a nearby ", false);
		//([Non-centaur and below 8'6</i>\" tall]
		if(!player.isTaur() && player.tallness < 102) outputText("empty crate", false);
		else outputText("broad stone wall", false);
		outputText(".  Contrary to what she said, she seems pretty eager and, in just a few moments, you have clear vision and access to ", false);
		if(flags[kFLAGS.KATHERINE_DICK_COUNT] > 1) outputText("both dog-dicks", false);
		else outputText("her dog-dick", false);
		outputText(" and her already-wet vagina", false);
		//([if Katherine has her maximum 5 inch balls)] 
		if(flags[kFLAGS.KATHERINE_BALL_SIZE] >= 5) outputText(" although her sizeable testicles mar your view of it somewhat", false);
		outputText(".\n\n", false);
	
		outputText("The puss' pussy is your first target, as you approach her sitting position; as your tongue slowly licks her balls you gently pull them upwards and to the side, completely revealing her increasingly moist pussy.  You tease her about getting so excited but work to please nevertheless", false);
		//([Corruption 70+]
		if(player.cor >= 70) outputText(" - if only to prove your skill and make the kitten ever more dependent on you for release", false);
		outputText(".\n\n", false);
	
		outputText("With a teasing lick, you circle around her clit and slowly move away, then back towards it.  Her cock seems to grow even harder and starts to drip pre-cum, threatening to dirty ", false);
		//([Katherine's cock 8-10 inches] 
		if(flags[kFLAGS.KATHERINE_DICK_LENGTH] < 10) outputText("your face", false);
		else outputText("your hair", false);
		outputText(".  A loud, frustrated mewl from above prompts you to start gently sucking on her clit, rewarding you with a stifled moan and the twitching of the small cat-morph's thighs.  You continue your attentions without pause, slipping the tip of your tongue inside her pussy to taste the generously flowing juices.\n\n", false);
	
		outputText("Deciding this part had enough attention for the moment, you slowly move up to her balls, gently sucking each one inside your mouth.  ", false);
		if(player.tongueType > TONUGE_HUMAN) {
			outputText("You allow your tongue to slide out and wrap about the lower part of her member, just below the barely recognizable thickening of her penis that marks the place where the knot will soon bulge", false);
			if(flags[kFLAGS.KATHERINE_KNOT_THICKNESS] >= 6) outputText(" enormously", false);
			outputText(".  ", false);
		}
		outputText("Katherine moans again as you slowly trace the bottom side of her penis up towards the conical, pointy head.  You gently suck on the tip before slipping one of your fingers inside the cat-morph's pussy . She can't help herself and you feel her squirming, her thighs reflexively wrapping around your hand before she forcibly parts them.  Slowly, you bob your head up and down her cock", false);
		//([Kat length >= 14] 
		if(flags[kFLAGS.KATHERINE_DICK_LENGTH] >= 14) outputText(" having minor problems actually deepthroating the thing", false);
		outputText(".  All the while, you finger her pussy - your hands are positively soaked by her excretions.  Grabbing her cock with the same hand that is now coated in her own juices, you start to jerk her off as you go back down on her clit; your other hand slips inside the cat-morph.\n\n", false);
	
		outputText("She mewls again, clearly doing her best to resist and prolong the pleasure.  After a while of molesting her clit and cock", false);
		if(flags[kFLAGS.KATHERINE_DICK_COUNT] > 1) outputText("s", false);
		outputText(" simultaneously, you decide it's time to get somewhat more serious.\n\n", false);
	
		outputText("Deciding the girl's vagina is sufficiently teased for now, you move back to her erection, opening your mouth and slipping her inside.\n\n", false);
	
		//([Normal tongue] 
		if(player.tongueType == TONUGE_HUMAN || player.tongueType > TONUGE_DEMONIC) outputText("Your hand remains in her pussy, however, adding to the multiple ways with which you please your lover.\n\n", false);
		//[Naga tongue]
		else if(player.tongueType == TONUGE_SNAKE) outputText("The hand that was so far fingering her pushes her balls to the side, as you slowly move down and down her erection. You gently hum into it before going nearly all the way down to the base, Katherine'ss eyes opening wide.  Your long, flexible forked tongue slips out and down, sliding along the side of her left testicle before finding your target: the cat-girl's clitoris.  Your other hand starts to gently tease her lower lips as you slowly move it, mostly pleasing her with your throat muscles and long, flexible tongue.\n\n", false);
		// [Demonic tongue]
		else outputText("The hand that was so far fingering her pushes her balls to the side, as you slowly move down and down her erection.  Stopping just before the place where her knot usually pops out, you decide to give the girl a treat.  Slowly, your incredibly long flexible tongue moves towards your kittenish partner's pussy, giving it a long, sloppy lick.  Katherine's hips shiver and she only barely stops herself from pushing them forward.  Rewarding that show of self-control, you move your tongue up to wrap it around the very base of her penis just as the entire length of your inhuman muscle slips from your mouth; you manage to get the tip of it down, then brush it against the cat-girl's vagina.  Katherine just stares at you wide-eyed as you slip your demonic appendage inside her pussy, effectively pleasing nearly all of her lower's body erogenous zones at once.\n\n", false);
		
		outputText("After a while of slurping on her cock and ", false);
		if(player.tongueType == TONUGE_HUMAN || player.tongueType > TONUGE_DEMONIC) outputText("fingering her", false);
		else if(player.tongueType == TONUGE_SNAKE) outputText("molesting her clit with your tongue", false);
		else outputText("penetrating her with your tongue as you give her head", false);
		outputText(", you decide it's time to slightly change tactics in order not to humiliate the girl by making her blow her load too quickly.  The cat-herm's balls were so far pretty badly treated, and you decide to amend that, slowly withdrawing from your blowjob and sinking your mouth down to her testicles.  You lick them softly before sucking one inside your mouth.\n\n", false);
	
		//{([Normal Tongue]
		if(player.tongueType == TONUGE_HUMAN || player.tongueType > TONUGE_DEMONIC) {
			//[If Katherine's balls are 1 inches wide] 
			if(flags[kFLAGS.KATHERINE_BALL_SIZE] <= 1) outputText("You find it pretty easy to slip your tongue out further and gently lick her clit almost all the time while you're doing it.", false);
			else if(flags[kFLAGS.KATHERINE_BALL_SIZE] <= 2) outputText("You can sometimes reach her pussy while toying with her balls, teasing it with your tongue.", false);
			else outputText("You hoped to play with her pussy too, but the cat-girl's balls are too sizeable to do so with your tongue.  You can almost feel, maybe even hear the semen sloshing inside the big things, ready to shoot out any second.", false);
	
			outputText("You gently slide your fingers over the tip of her cock while teabagging her, but you don't want to give her an overload of sensations yet.\n\n", false);
		}
		//([Snake tongue] 
		else if(player.tongueType == TONUGE_SNAKE) {
			outputText("Balls or no balls in the way, you find it pretty easy to mercilessly toy with the girl's pussy using your long tongue.  You can easily tease her clit and even slip the tip inside, flicking at the sides of her inner walls as she purrs with delight at the gentler attentions and occasionally releases a silent moan.  You stroke ", false);
			if(flags[kFLAGS.KATHERINE_DICK_COUNT] == 1) outputText("her", false);
			else outputText("a", false);
			outputText(" cock at the base - this thing will have to wait for more attention.\n\n", false);
			outputText("You attend to the cat-girl's member while teasing the insides of her pussy with your inhuman tongue, all the while slurping on her testicles.  Katherine has a look of bliss on her face - you think it may be too cruel not to push her to orgasm a bit more quickly than planned.\n\n", false);
		}
		//[Demon Tongue] 
		else {
			outputText("You can feel Katherine shiver with helpless desire once she feels your excessively long tongue sliding over her balls.  You slide it upwards, teasing the knot area of her member, and then back down, oozing it over the poor kitten's clitoris and completely smothering it with your tongue.  Finally, you slip it inside as Katherine releases a loud scream of pleasure, then bites her own hand to silence herself.\n\n", false);
	
			outputText("You attend to the cat-girl's member while teasing the insides of her pussy with your inhuman tongue, all the while slurping on her testicles.  Katherine has a look of bliss on her face - you think it may be too cruel not to push her to orgasm a bit more quickly than planned.\n\n", false);
		}
		
		outputText("You announce that the cat-girl is very welcome to cum soon, since this probably won't be a one time offer and she doesn't have to postpone things so desperately.\n\n", false);
	
		outputText("\"<i>Thank you,</i>\" she gasps before mewling, a small trickle of drool running down her chin.  Somehow, she looks too adorable for you to point that out. \"<i>Ummm... I don't know how you want to finish, but... watch the knot, Ok?  This is really amazing and it'd be such a waste if you were to harm yourself... I get the feeling that it'll start to bulge out really soon.</i>\"\n\n", false);
	
		outputText("You nod, before considering how exactly you will seal the deal and have the cat-girl get off.\n\n", false);
	
		//([Normal tongue]
		if(player.tongueType == TONUGE_HUMAN || player.tongueType > TONUGE_DEMONIC) {
			outputText("Deciding to follow her advice, you dive down to the girl's soaking-wet vagina, gently fondling her testicles as you softly roll them in your hand.  You start eating her out, licking her insides, and teasing her clit as your other hand jerks your hermaphrodite cat lover off.\n\n", false);
	
			outputText("You can feel your hand starting to hit some resistance and you realize her knot is starting to surge with blood. Taking advantage of the moment while you can, you drink her copious feminine juices while your tongue explores the inner walls of the kitty-cunt, then slightly increase your pace above.  With a lot of panting, a mewl and then a growl of ecstasy the cat-girl drenches your face as her pussy wraps tighter around your tongue, her semen flying out of her cock and landing over your hair and your backside.  Her thighs shiver as she closes them around your head, unable to let you go.", false);
			if(flags[kFLAGS.KATHERINE_BALL_SIZE] >= 5) outputText("  You can't help but giggle into the cat-girl's pussy as you feel her drench you with her seed, painting you white.", false);
			outputText("\n\n", false);
		}
		//([Naga tongue] 
		else if(player.tongueType == TONUGE_SNAKE) {
			outputText("With a smirk, you grab her cock around the base and lick your lips as Katherine shivers in anticipation.  Without much care for safety, you dive in, deep-throating the kitten up to the point where your lips meet your fingers.  It isn't the easiest thing you've ever done, but while having her deep down your throat you can extend your tongue far enough to lick her clit again.  The cat-girl is ecstatic at your simultaneous attentions.\n\n", false);
			
			outputText("Soon, you feel the telltale signs of her orgasm appearing.  Katherine is panting loudly, unable to control herself; her knot is bulging out and her pussy is getting wetter and wetter.", false);
			//([Katherine's knot is 6 inches wide]
			if(flags[kFLAGS.KATHERINE_KNOT_THICKNESS] >= 6) outputText("  Regrettably, the cat-girl's bulging knot makes it a lot harder to please her pussy with your long tongue in this position than you'd hoped, and you have to give it up once she's completely swollen.", false);
			//([Player has a naga tail]
			if(player.isNaga()) outputText("  You decide to play the snake part to the very end and, not content to leave her pussy unattended, you slip the tip of your long tail inside her.  She groans in ecstasy, finally reaching orgasm.", false);
			else outputText("  Not content to let her pussy remain unattended, you slip two of your fingers inside her while teasing her clit with your knuckle.  She seems greatly pleased at your attention, as she shivers in orgasm moments afterwards.", false);
	
			outputText("Your ", false);
			if(player.isNaga()) outputText("tail", false);
			else outputText("fingers", false);
			outputText(" get squeezed and drenched while you feel her erection twitch and pulse within your mouth.  You complete your motion, diving to the very verge of her knot and sucking on her intensely as she blows her seed into your mouth and your throat.\n\n", false);
	
			outputText("You greedily swallow your hermaphrodite lover's semen; ", false);
			//([Katherine has 1 inch balls]
			if(flags[kFLAGS.KATHERINE_BALL_SIZE] <= 1) outputText("the amount of it quite high for her size, substituting for a decent warm drink at least.", false);
			else if(flags[kFLAGS.KATHERINE_BALL_SIZE] <= 3) outputText("you can feel thick, generous ropes of her jizz flow into your mouth and down your throat between smaller trickles.  Her orgasm is rather intense and leaves you quite full.", false);
			else outputText("as suggested by the size of her testicles, Katherine cums - a lot.  Wave after wave of semen gushes down your throat, filling your belly to the point of stretching.", false);
			outputText("  Slowly, you pull her cock out of your mouth while Katherine smiles at you and purrs gratefully.\n\n", false);
		}
		//(Demon tongue)
		else {
			outputText("You separate the place where the knot should appear with your own fingers and dive down her shaft.  You're going to pleasure most of her anyway, as you repeat your trick, wrapping your demonic appendage around the base of her cock with your other hand as your long tongue slides out to lick and play with her balls.  Sliding it along her testicles seems to start igniting her orgasm - the bulge of her knot gets bigger, although it seems you have a few moments.  You slide down further, rolling her balls and then lifting them to push the tip of your tongue inside her pussy.  You can taste her feminine juices dripping out as her vagina starts to clench, her inner walls twitching and her knot bulging to full size", false);
			//([If 6 inches knot]
			if(flags[kFLAGS.KATHERINE_KNOT_THICKNESS] >= 6) outputText(", even making it hard for you to keep your tongue buried all the way inside", false);
			outputText(".\n\n", false);
	
			outputText("With a loud yowl, she cums, her pussy clenching around your demonic appendage and her penis twitching in your mouth.\n\n", false);
	
			//([Katherine has 1 inch balls] 
			if(flags[kFLAGS.KATHERINE_BALL_SIZE] <= 1) outputText("She practically thrashes around in orgasm as you tease her balls with your tongue, your mouth milking her and devouring the cum she releases quite easily.", false);
			else if(flags[kFLAGS.KATHERINE_BALL_SIZE] <= 2) outputText("Your tongue has no problems sliding across and teasing her balls as your mouth drinks her dick-milk.  There is quite a lot of it, but you don't complain.", false);
			else outputText("Katherine's large testicles quiver on your tongue as they discharge their load.  You can feel it seeping inside you, slightly stretching your belly as you struggle to swallow it all.", false);
			outputText("  All the while, her pussy rhythmically squeezes your tongue and covers it with girl-cum.\n\n", false);
	
			outputText("Once she's done climaxing, you allow her member to slide out of your mouth before rolling your tongue along her pussy, drinking her feminine juices.  Her initial yowl turns into soft purring as you delicately finish her up.\n\n", false);
		}
		// All scenes end here/
		outputText("The deed done, you straighten your back and wink at the cat-girl.  Katherine purrs as she jumps down next to you and pulls you in for a kiss.\n\n", false);
	
		outputText("\"<i>You were amazing!</i>\" she exclaims, still short on breath.  ", false);
		if(player.tongueType == TONUGE_DEMONIC) outputText("She runs her fingers along your lips.  \"<i>I think I might be falling in love with the monster inside that pretty cave.</i>\"", false);
		else outputText("\"<i>I hope that if I ever get to repay the favor, I can do as well as you.</i>\"", false);
		outputText("\n\n", false);
	
		outputText("She kisses you again, her hands running down your back.  You worry that if this keeps going you may end up going another round immediately, but you don't have that much time to lose.  Parting yourself from the cat-herm with a kiss, you go your separate ways.", false);
	}
	//Double Cock Scene
	else {
		outputText("With a small grin, you tell Katherine that you wouldn't mind satisfying her orally.\n\n", false);

		outputText("\"<i>But... " + player.short + ", are you sure?  I mean, with the knots... I mean, now that I have two cocks, that's a lot to work with... and I don't want to leave you with nothing, either...</i>\"\n\n", false);

		outputText("You reassure her that you don't mind at all - in fact, you want to do this and probably will enjoy it.\n\n", false);

		outputText("Avoiding eye contact and apparently blushing under the fur, Katherine answers, \"<i>Okay.  If this is really what you want.  Just please, be careful, especially for your own good, okay?</i>\"\n\n", false);

		outputText("You motion for her to half-sit on a nearby ", false);
		if(!player.isTaur() && player.tallness < 102) outputText("empty crate", false);
		else outputText("broad stone wall", false);
		outputText(".  Contrary to what she said, she seems pretty eager and, in just a few moments, you have a visual on and access to both of her cocks as well as her already-wet vagina", false);
		//[(katballs=5</i>\")
		if(flags[kFLAGS.KATHERINE_BALL_SIZE] >= 5) outputText(", obscured somewhat by her pendulous scrotum", false);
		outputText(".\n\n", false);

		outputText("Seeing one of her cocks bob and twitch as your face gets closer you decide to reward the eagerness and start with it.  You open your lips and lick the tip before slowly sliding down her crown and then lower, onto the shaft and down to the base.  Then, you pull your lips up, assaulting her with your tongue all along the way.  Her canine cock leaves your mouth with a loud slurp and you quickly go down the other one.  Katherine strokes your " + hairDescript() + ", very gently helping push you down her shaft.\n\n", false);

		outputText("Her hands are actually in the way of what you have planned; with a glare you quickly tell her to let you do it your way.  Katherine mewls apologetically as you grab her erections with both hands and rub them up, down, and together, licking the touching tips with your tongue.", false);
		if(player.tongueType == TONUGE_SNAKE || player.tongueType == TONUGE_DEMONIC) outputText("  Said tongue wraps around one erection and then the other, stroking gently with its long, flexible length.", false);
		outputText("\n\n", false);

		outputText("Next you move down from her erections, giving her balls a teasing lick before sucking one of them inside your mouth.", false);
		if(player.tongueType == TONUGE_SNAKE || player.tongueType == TONUGE_DEMONIC) outputText("  Your long, flexible tongue once again slides out as you gently lift her testes up, easily dipping inside her wet pussy and stroking her inner walls as you suck.", false);
		outputText("  You continue to minister to her balls, wrapping your fingers around her straining cocks, jerking them off slowly before nudging the balls up and diving into her wet pussy.\n\n", false);

		outputText("Your work here starts with soft kisses on her lower lips, and then slowly moves up to her clit.  Katherine's thighs gently bend as her feet rest on your shoulders, egging you on to give more attention to her drenched pussy.  You humor her, tongue sliding inside her as you suck on her clit while slowly jerking off both of her erections.  Her feminine juices start flowing even more freely - you find yourself suffused with almost as much taste as sound from her soft panting and moaning.\n\n", false);
		
		//([Demon tongue]
		if(player.tongueType == TONUGE_DEMONIC) outputText("The opportunity for some extra service doesn't escape you; you suck her clit in with your lips as the long, prehensile organ you house in your mouth slides up against her balls, rolling them and assaulting the base of one of her erections, slowly wrapping around it.  After getting a good tongue-grip on it, you slither further around and past it to do the same to her other cock.  Then, slowly, you start to stroke the twin canine penises with the wet muscle, causing Katherine to shake with helpless pleasure.  Continuing to suck on her clit meanwhile, your large flexible tongue also gives her twin penises a dream jerk-off.\n\n", false);

		outputText("Slowly, you draw away from her, admiring your handiwork.  Katherine's erections are leaking pre-cum generously, while her pussy is drenching her seat and trickling copious fluid onto the underside of her balls.  Her thighs are gently shaking and her stare lacks focus.\n\n", false);

		outputText("\"<i>Umm... please, continue.  I'm so close...</i>\"\n\n", false);

		outputText("You press your fingers against her pussy and start to finger her, at first gently, then at an increasing pace.  Then, you bend down to again suck on a throbbing erection as you gently stroke her members, alternating between one and the other.  You lift your lips from one penis and then dive down the other, going down and down, massaging her member with your throat muscles while sliding your tongue across the back of her penis.  While deepthroating, you suddenly feel something press against your jaw. Quickly, you withdraw before the knot bulges out of control.  It swells as you pull out, but slows down, lacking the stimulation to reach ejaculation and therefore maximum size.\n\n", false);

		outputText("She pants and whimpers at the lost stimulation, hands barely restrained from grabbing the reins herself and capping your efforts.  \"<i>P... please!  I'm almost there!</i>\"  Not willing to make her suffer, you decide to finish the job and make your kitten cum.\n\n", false);

		//([Normal/Naga Tongue] 
		if(player.tongueType <= TONUGE_SNAKE) {
			outputText("You wrap both your hands around her members just above the knot and start stroking her off, aiming at your mouth as you lick the tips.  Her knots swell to full size as she starts panting.", false);
			//([If the character has a naga lower body or a demon tail] 
			if(player.isNaga() || player.tailType == TAIL_TYPE_DEMONIC) outputText("  Wanting to grant her maximum stimulation and complete release, you slip the tip of your tail inside the cat-girl, feeling her pussy gratefully squeeze it.", false);
			outputText("\n\n", false);
		}

		outputText("Moments later, Katherine finally ejaculates, over your face and inside your mouth.", false);
		//([Katballs =5</i>\"]
		if(flags[kFLAGS.KATHERINE_BALL_SIZE] >= 5) outputText("  There's quite a lot of it, so you manage to get both a kinky bath and a decent warm drink.", false);
		outputText("\n\n", false);

		if(player.tongueType == TONUGE_DEMONIC) outputText("Your tongue quickly slides out of your mouth, twitching sinuously as Katherine's eyes go wide at the sight of it easily wrapping around both her erections.  Your hand starts playing with her balls as the other fingers her dripping wet cunt, pumping in and out as you feel her knots swell larger under your tongue.\n\n", false);
		
		outputText("Her erections release in unison, and thick rivulets of semen cover your face, tongue and even the inside of your mouth.  Her testicles twitch and pulse in your hand as her cunt grabs tightly at your fingers, covering them with her girlcum.", false);
		//([Katherine has five inch balls]
		if(flags[kFLAGS.KATHERINE_BALL_SIZE] >= 5) outputText("  The two of you are liberally coated with her spunk, your stroking tongue unable to catch all of it as she shoots off.", false);
		outputText("\n\n", false);

		outputText("The deed is done and you straighten your back, winking at the cat-girl.  Katherine purrs as she jumps down next to you and pulls you in for a kiss.  \"<i>You were amazing!</i>\" she exclaims, still short on breath.", false);
		//([If demon tongue]
		if(player.tongueType == TONUGE_DEMONIC) outputText("  She runs her fingers along your lips.  \"<i>I think I might be falling in love with the monster inside that pretty cave.</i>\"", false);
		else outputText("  \"<i>I hope that if I ever get to repay the favor, I can do good as well as you.</i>\"", false);
		outputText("\n\n", false);

		outputText("She kisses you again, her hands running down your back.  You worry that if this keeps going you may end up going another round immediately; separating yourself from the cat-herm with an excusatory kiss, you go on your way.", false);
	}
	//minus lust, slimefeed, Player returns to camp
	flags[kFLAGS.KATHERINE_TIMES_SEXED]++;
	player.slimeFeed();
	dynStats("lus", 25);
	doNext(13);
}

//Katherine performs Oral on PC:
private function katherineGivesPCOralAllDayLongDotJPG():void {
	outputText("", true);
	outputText("You tell Katherine you'd like to see what she can do with her tongue.  The black cat blinks in surprise, then grins widely.  \"<i>Well, that can be arranged...</i>\"  She purrs, taking you by the arm and leading you around to a specific crate.  Once you are seated and both of you are naked, she kneels in front of you.  \"<i>Now, let's see what you have, my dear...</i>\" she says, tail waving in the way that only a happy cat's does.\n\n", false);
	if(player.hasCock() && (player.gender == 1 || rand(2) == 0)) doNext(katherineLicksAllTheBoyPenises);
	else doNext(katherineGoesDownOnTheGirlsOhYahBabyLesbo);
	
}
//[Female]
private function katherineGoesDownOnTheGirlsOhYahBabyLesbo():void {
	outputText("", true);
	outputText("She gently strokes the lips of your " + vaginaDescript() + ", then leans in and gives it a deep, wet lick.  You can't restrain a shiver at the sensation; Katherine's tongue is unlike anything you've seen in this world so far, broad and bristly, but not so hard that it hurts.  It's like lots of little tongues all licking you at the same time.\n\n", false);

	outputText("Without hesitation, she licks you again, and again, deep strokes that slide up from the very base of your cunny all the way to the tip, lingering on your " + clitDescript() + " and teasing your lovebutton.  You can't help but wrap your " + player.legs() + " around her head and pull her into your crotch, thrusting her face right into your cunt.\n\n", false);

	outputText("If this bothers Katherine, though, she gives no sign; she just keeps licking and lapping, eagerly slurping her way into your depths.  You buck and thrash at her ministrations; the sensations of that rough tongue all over your insides are indescribable; like rough fingertips but hundreds of times more probing!  Finally, you can't hold it any more and cry out as orgasm washes through you, deluging femcum into Katherine's thirsty maw, even as she strives to lap it up like a cat with a bowl of cream.\n\n", false);

	outputText("Your pleasure finished, you release her, gasping for breath as she daintly wipes her face clean with her fingers.  \"<i>Was it good for you?</i>\" she asks, mischief in her eyes.  When you reply, she smirks. \"<i>Did you expect a pussy to be good at eating a pussy?</i>\"\n\n", false);

	outputText("You simply groan at the absolutely terrible pun and get back up, redressing yourself and heading back into the streets after a quick peck to thank her for the time.", false);
	doNext(13);
	flags[kFLAGS.KATHERINE_TIMES_SEXED]++;
	dynStats("lus=", 0);
}
//[Male/Herm]
private function katherineLicksAllTheBoyPenises():void {
	var x:Number = player.biggestCockIndex();
	outputText("", true);
	outputText("She takes your shaft eagerly, gently stroking it with her fingers to coax it erect, then leaning in to lick the head with her softly bristled tongue, caressing and suckling at the " + cockHead(x) + ".", false);
	if(player.hasVagina()) {
		outputText("  One of her hands slides down your shaft", false);
		if(player.balls > 0) outputText(", past your " + ballsDescriptLight() + ",", false);
		outputText(" and gently begins to stroke your cunny, twiddling her fingers to heighten your pleasure by manipulating both sets of organs at once.", false);
	}
	outputText("\n\n", false);

	outputText("Once your pre starts to flow, she fully leans in and swallows as much of your shaft as she can, her inhuman tongue stroking and caressing in ways you couldn't have imagined.", false);
	if(player.hasVagina()) {
		outputText("  She plunges her fingers into your cunt at the same time, to heighten the experience.", false);
	}
	outputText("  With a surprising amount of skin in her mouth, she starts to bob and suckle, confining your member in the hot, tight, wetness, her tongue keeping up its ministrations.  She starts to purr with delight, sending the most delicious vibrations rippling through your member.", false);
	if(player.hasVagina()) {
		outputText("  Her fingers stroke and piston inside you with the synchronicity only another hermaphrodite could have perfected, rolling your " + clitDescript() + " and sending further sparks of pleasure coursing through your brain.", false);
	}
	outputText("\n\n", false);

	outputText("Your resistance is minimal in the face of such pleasure; all too soon, you feel your ", false);
	if(player.balls == 0) outputText("cock tingling", false);
	else outputText("balls tightening", false);
	outputText(" as your release becomes imminent.  Without further ado, you erupt inside the eager cat-herm's mouth, making her hungrily gulp down as much of your seed as she can.", false);
	if(player.cumQ() <= 250) outputText("  She drinks every last drop with relief, popping wetly off of your cock and licking her lips, audibly purring with delight.", false);
	else if(player.cumQ() <= 600) outputText("  She gulps it down desperately, stomach swelling with the influx of spunk, but manages to avoid spilling anything, popping her head free and gasping for breath as soon as she thinks you're done.", false);
	else outputText("  You can see a hint of panic in her eyes at the titanic cascade of fluids coming from your " + cockDescript(x) + ", but it's drowned out by her determination to drink every last drop.  Her belly swells out like a waterskin being held in a waterfall, rivulets of cum flooding from her overwhelmed mouth, but she manages to hold on without taking the cock out of her mouth before you're finished.  Afterward, she detaches herself breathlessly from your cock and gives you a triumphant expression, and a faint burp.", false);
	outputText("\n\n", false);
	
	outputText("Weakly, she collapses onto her furry behind on the ground, smiling up at you.  \"<i>I take it you enjoyed that?</i>\" she teases.  You admit she did very well, helping her up and to her own 'bed', then get dressed and head back out into Tel'Adre's streets.", false);
	//lust -100 regardless of sex, return to wherever
	dynStats("lus=", 0);
	flags[kFLAGS.KATHERINE_TIMES_SEXED]++;
	doNext(13);
}

//Double Helix
private function katDoubleHelixCraziness():void {
	var x:Number = player.cockThatFits(70);
	if(x < 0) x = 0;
	outputText("", true);
	//PC must have a cock and a vagina and not be a centaur
	outputText("You give the matter some choice... your partner here has both male and female sexual organs; which to choose...?  Then, recalling you have the same sort of sex arrangement, you feel a kinky idea coming on.  Gently, you ask if Katherine thinks she's flexible enough to use both her parts at the same time.\n\n", false);

	outputText("Katherine grins and sits on the floor; then bends over in a way that looks like she could lick her butt.  \"<i>Flexible enough for you?</i>\"\n\n", false);

	outputText("You can't resist a laugh; it looks like she is.  Carefully removing and setting your " + player.armorName + " aside, you then realise the problem, and voice it aloud: how are you supposed to penetrate each other's pussy at the same time?\n\n", false);

	outputText("Katherine gets the cue and begins undressing herself.  \"<i>Just lay down on your side and spread yourself for me.</i>\"\n\n", false);

	outputText("You do as she says, ", false);
	if(player.isNaga()) outputText("curling your naga tail back", false);
	else if(player.isGoo()) outputText("shifting your gooey blob", false);
	else outputText("lifting your " + player.leg() + " up", false);
	outputText(" so she has access to both your " + vaginaDescript(0) + " and your " + cockDescript(x) + ".\n\n", false);
	
	outputText("Katherine lies down across from you and wraps her legs around your own lower body, her honeypot aligned with your own.  \"<i>Okay... now push your dick down like this...</i>\" she says, shoving ", false);
	if(flags[kFLAGS.KATHERINE_DICK_COUNT] > 1) outputText("one of ", false);
	outputText("her own canine-pecker", false);
	if(flags[kFLAGS.KATHERINE_DICK_COUNT] > 1) outputText("s", false);
	outputText(" towards your " + vaginaDescript() + ", slowly teasing you with the tip.\n\n", false);

	outputText("You repeat the gesture, pointing the tip of your " + cockDescript(x) + " to her drooling cunt.  You can hear her breathing softly, keeping herself calm, and try to do the same... which is when something occurs to you, and you ask her what the two of you are supposed to do about her knot.  You're not sure that the two of you tying yourselves in this position would be such a good idea, after all.\n\n", false);

	outputText("\"<i>Oh, um... I guess it would be pretty awkward, yes... all right, I promise I won't push my knot in,</i>\" she replies.\n\n", false);

	outputText("Katherine flexes her legs and pulls you inside her, penetrating you as well.  She yowls in pleasure as she feels the simultaneous pleasure of penetrating and being penetrated.  \"<i>Ah... just move your hips - mmm - with me.</i>\"\n\n", false);

	outputText("Shivering with delight as her hot, soaking wet walls envelop your " + Appearance.cockNoun(CockTypesEnum.HUMAN) + " and her rubbery, pointy dog-cock slides into your " + vaginaDescript() + ", you need no further encouragement, eagerly pumping your hips against hers, trying to push into her and push her into you without letting either cock slip free of its appointed hole.  Katherine gyrates her hips, attempting to stimulate both your parts, panting in pleasure.\n\n", false);

	outputText("You whine and whimper at the stimulus, moving your own hips likewise in an effort to intensify the sensations without accidentally enveloping her knot in your cunt.  Katherine mewls and yowls in pleasure in response, voicing her approval and pulling you dangerously closer to her knot in an attempt to feel more of you.  Barely coherent of what's happening, your world shrinks down to the feeling of cock in cunt... then with a wet SCHLUCK Katherine's half-swollen knot slips inside your pussy and your hips collide.", false);
	player.cuntChange(flags[kFLAGS.KATHERINE_DICK_LENGTH] * 2,true,true,false);
	outputText("\n\n", false);

	outputText("You gasp as you find yourself filled so full, with your cock sheathed to the hilt in her hot, wet depths.  The sensations are almost overwhelming... but you manage to stave them off and gasp out that she's knotted you.\n\n", false);

	outputText("\"<i>S-Sorry...</i>\" Katherine replies, holding back a moan and a thrust.  She pushes herself away just enough to let her knot slip free and continues gyrating her hips.  You resume working yours in turn, matching her pace so that her cock slides fully inside you and you can slide your cock fully inside her - at least, as fully as possible without once again taking in her knot... or not.  Katherine gasps and pulls you all the way inside her once more, once again slipping her knot inside you.  You cry out in pleasure; you can't bring yourself to care that you've been knotted once again, you're just too delighted to be truly full at last, to be fully sheathed at last - it's indescribable!\n\n", false);

	outputText("\"<i>S-Sorry " + player.short + ", I just can't... ah... I promise I'll pull out before we tie,</i>\" Katherine says, doing her best to bump against you with all the strength she can muster.  You just automatically tell her it's all right, too lost in thrusting back against her with all your strength, mashing pelvis against pelvis with bestial desire, spurred on by instincts older than humanity.  With a final yowl of pleasure, you feel Katherine's knot swell inside you and her pussy clench around your " + cockDescript(x) + ".  Then a flood of feline cum and juices splashes in and against you, prompting a cry of your own; you surrender to your own climax, cum ", false);
	if(player.cumQ() <= 50) outputText("surging", false);
	else if(player.cumQ() <= 250) outputText("gushing", false);
	else outputText("thundering", false);
	outputText(" from your cock and femcum ", false);
	if(player.wetness() <= 3) outputText("drizzling", false);
	else if(player.wetness() <= 4) outputText("spurting", false);
	else outputText("gushing", false);
	outputText(" from your cunt, striving to milk your anthropomorphic lover and be milked by her in turn.\n\n", false);

	//(Katherine Medium Cum Amount)
	if(flags[kFLAGS.KATHERINE_BALL_SIZE] <= 1) {
		outputText("You feel your belly beginning to bloat slightly as Katherine dumps her load inside you.", false);
	}
	//(Katherine High Cum Amount)
	else if(flags[kFLAGS.KATHERINE_BALL_SIZE] <= 2) {
		outputText("You feel your belly beginning to bloat while Katherine fills you with her jism.  Her knot works to keep all of her cum inside you and as a result, by the time she's stopped you look at least a few months pregnant.", false);
	}
	//(Katherine Very High Cum Amount)
	else {
		outputText("You feel your belly beginning to rapidly bloat while Katherine fills you with her jism.  Not even her knot is equal to the task of keeping all of her cum inside you, as the backflow stretches your lips even wider to spill gouts of semen against Katherine's crotch.  By the time she's stopped cumming, you look like you're carrying multiple litters of kittens.", false);
	}
	outputText("  ", false);
	//PC Medium Cum Amount)
	if(player.cumQ() < 100) outputText("You pay Katherine back in kind though, dumping your considerable load inside the eager cat and giving her a round belly of her own as you spurt thick gobs of semen inside her.", false);
	//(PC High Cum Amount)
	else if(player.cumQ() <= 500) outputText("You pay Katherine back in kind though, dumping your massive load inside the eager cat, bloating her belly until she looks a few months pregnant and is unable to take any more cum.  Some of it flows back to splatter against you, pooling beneath both of you in a messy pool of hot white jism.", false);
	//(PC Very High Cum Amount)
	else outputText("You pay Katherine back in kind though, dumping your massive load inside the eager cat, bloating her belly until she looks a few months pregnant and is unable to take any more cum.  Some of it flows back to splatter against you, pooling beneath both of you in a messy pool of hot white jism.  Yet it doesn't seem likely to stop anytime soon; if it weren't for Katherine's knot you're pretty sure you'd have sent the cat rocketing straight off of your cock.  Katherine trembles and her pussy walls clench as if to hold more of your cum inside her, and indeed she inflates beyond her capacity for a while, until she relaxes and your load pours out of her.", false);
	outputText("\n\n", false);
	
	outputText("You gasp for breath, mind still reeling from the earth-shaking pleasure you've experienced.  Your first instinct is to try to move, but you find you can't get up", false);
	if(flags[kFLAGS.KATHERINE_BALL_SIZE] >= 4) outputText(", and not because your swollen stomach is weighing you down, either", false);
	outputText(".  Katherine's knotty cock has locked her into your " + vaginaDescript() + ", leaving you tied together like a dog and his bitch.  With roughly equal parts exasperation and amusement, you comment that you thought she'd promised to slip free before her knot bound you both together.\n\n", false);

	outputText("Katherine gulps audibly.  \"<i>S-Sorry " + player.short + ".  It's just that... it felt so good... and I got carried away... sorry...</i>\"  You tell her it's a bit disappointing, but you'll both live. Besides, it's not as if it wasn't enjoyable.\n\n", false);

	outputText("Katherine smiles and says, \"<i>Sorry... I promise I'll make it up to you somehow.</i>\"  Propping yourself up on an elbow, you ask her with sincere curiosity what she has in mind.  \"<i>Just wait for a while and let my knot shrink,</i>\" she says, with a sly glance.  Seeing that she isn't going to talk, you settle back down and wait for just that to happen.\n\n", false);

	outputText("With the sensation of your full pussy as your guide, it's easy to know when it's finally possible for her to slip free without hurting you; Katherine pulls away and stands on shaky feet.  The jism contained within you spills out in a satisfying cascade of white, that's when you feel a pair of lips touch your sensitive snatch.  Moments later a cat's tongue licks your labia and latches onto it, sucking the jism straight out of you.  You gasp in delight, but keep still, wondering what your lover has in mind.\n\n", false);

	outputText("Once she's done with your pussy, she moves on to your " + cockDescript(x) + ", taking the tip into her mouth and suckling on it to drain the last bits of cum from your shaft, then she lets go of your " + cockHead(x) + " and begins licking the shaft, cleaning you all the way from the base up", false);
	if(player.balls > 0) outputText(", and even licking your " + ballsDescriptLight() + " clean", false);
	outputText(".  You moan and shudder and buck your hips at her ministrations; your ", false);
	if(player.balls > 0) outputText("balls are still depleted", false);
	else outputText("cock is still almost totally empty", false);
	outputText(", but you're confident she could coax another orgasm from you if she keeps this up.\n\n", false);

	outputText("Realizing your cock is hardening up again, Katherine gives you a mischievous grin and opens her maw to take in all of you deep into her throat, giving your " + cockDescript(x) + " a loud, wet slurp before sucking on you sharply.\n\n", false);

	outputText("You voice a hollow groan; you didn't know she had this in her!  Reaching out with your hands, you take hold of her head just below the ears; too weak to push her down (not that it's necessary anyway), you settle for just holding her in place.\n\n", false);

	outputText("Of course, with the state you're in, it's barely minutes before you explode again, cum rushing from your oversensitive cock and into her suckling maw.  Katherine drinks you up, drawing all of your cum in and releasing your cock with a POP; leaving your throbbing mast sparkling with saliva.  \"<i>So I take it you liked my little tongue-bath?</i>\" she teases, licking her lips.\n\n", false);

	outputText("You can only nod weakly at her.\n\n", false);

	outputText("\"<i>Want me to give you a more thorough one?</i>\"\n\n", false);

	outputText("You nod again unthinkingly.\n\n", false);

	outputText("Katherine rolls you on your back and begins licking your belly, cleaning you of the sweat produced by your vigorous fucking earlier.  She moves through your " + chestDesc() + ", stopping shortly to give each of your " + nippleDescript(0) + "s a little peck.  Then she continues to your neck and face.\n\n", false);

	outputText("You simply lie back and enjoy her attentions; while pleasurable, they aren't as sexual as her previous efforts, and you find the experience more soothing than arousing. It takes a while, but finally with one last lick on ", false);
	if(player.isNaga() || player.tailType == TAIL_TYPE_DEMONIC) outputText("the tip of your tail", false);
	else outputText("your " + buttDescript(), false);
	outputText(", she finishes.  Katherine grins and happily declares, \"<i>There you go, you're clean now!  Sorry for breaking my promise and knotting you.</i>\"\n\n", false);

	outputText("Sitting up, you can't resist reaching over and ruffling her ears in a way that the cats you've met always liked, telling her that if this is how she'll apologise for it, you don't mind her doing so again.\n\n", false);

	outputText("She leans against your hand, purring.  \"<i>Hmm... I'll keep that in mind.</i>\"\n\n", false);

	outputText("Righting and redressing yourself, you say goodbye to the charming kitty, then head back to camp, still feeling rather drained.\n\n", false);
	//Player returns to camp without his lust, slimefeed
	player.slimeFeed();
	flags[kFLAGS.KATHERINE_TIMES_SEXED]++;
	dynStats("lib", -1, "sen", -1, "lus=", 0);
	doNext(13);
}

//Suckle
//PC must lactate to have this option
private function suckleTacularKats():void {
	outputText("", true);
	outputText("Feeling your " + chestDesc() + " and the milky goodness within, you ask Katherine if she likes milk the way her fellows do.  When the cat-morph gives you a puzzled look, you remove the upper part of your " + player.armorName + " and, fondling your tits with a smirk, tell her that you could use a little relief.\n\n", false);

	outputText("Katherine's eyes widen with shock, and she smiles in disbelieving delight, quickly striding over and waiting, impatiently, as you find a comfortable position and sit down.  Once you have, she wastes no time in plopping down in front of you. She nuzzles her cheek against your breast but then, to your amazement, shyly backs away.\n\n", false);

	outputText("\"<i>I... um... is this really okay?</i>\" she asks, her voice barely above a whisper.  With a hint of exasperation you roll ", false);
	if(player.eyeType > EYES_FOUR_SPIDER_EYES) outputText("both sets of ", false);
	outputText("your eyes and gently take her by the cheeks, insistently bringing her head close so that her lips are bumping right against your " + nippleDescript(0) + "s.  She takes the obvious hint and eagerly swallows it, eyes closing as she leans in and starts to suckle.  Purring with contentment, she sends the most delicious vibrations into your breasts, her rough, bristly tongue stroking and caressing to help coax your body into giving up its sweet, rich milk.\n\n", false);
	
	outputText("You're not sure how long you sit there with her in your arms, just listening to her purr as she quietly sucks and slurps, drinking everything you have to give.  She ", false);
	if(player.hasPerk("Feeder") < 0 && player.lactationQ() < 1000) outputText("empties", false);
	else outputText("does her best to empty", false);
	outputText(" your first breast, and then moves to the next one.  Finally, she's ", false);
	if(player.hasPerk("Feeder") < 0 && player.lactationQ() < 1000) outputText("drunk you dry", false);
	else outputText("drunk so much of your seemingly inexhaustible supply of milk that she's physically incapable of drinking any more", false);
	outputText(", and she lets your nipple go with a loud pop.", false);
	if(player.lactationQ() < 500) {}
	else if(player.lactationQ() < 1000) outputText("  She is sporting an unmistakable milk-belly from all she's drunk.", false);
	else if(player.lactationQ() < 2000) outputText("  She looks almost pregnant with how much she's drunk, but she doesn't seem to care.", false);
	else outputText("  Katherine looks more like a balloon than a cat, her belly swollen hugely from her titanic liquid repast.  You can hear her stomach's contents sloshing softly around inside her when she moves and thusly jostles them.", false);
	outputText("  With a smirk, you ask if she feels good from having helped you with your little milk problem.\n\n", false);

	outputText("The cat herm stirs herself from your grip and cuddles up to you, nuzzling against your neck and tucking her chin into your shoulder.  Then she lets out a burp that echoes off the alley walls.  \"<i>I feel great,</i>\" she tells you, totally unabashed.  \"<i>I must say, I've drunk from people before... but nobody makes milk as wonderful as yours... except maybe that nun!</i>\"\n\n", false);

	outputText("Smiling at the flattery, you help the very well-fed cat out of your lap, then quietly put your clothes back on and head out into the streets.\n\n", false);
	//some lust loss, satisfy feeder, Player returns to Tel'Adre Menu Screen or to camp, if code insists on it
	dynStats("sen", -2, "lus", -40);
	flags[kFLAGS.KATHERINE_TIMES_SEXED]++;
	doNext(13);
	//You've now been milked, reset the timer for that
	player.addStatusValue("Feeder",1,1);
	player.changeStatusValue("Feeder",2,0);
}
	}
}
