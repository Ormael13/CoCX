const RUBI_AFFECTION:int = 604;
const RUBI_DISABLED:int = 605;

//0 = not admitted (she), 1 = "he", 2 = "she"
const RUBI_ADMITTED_GENDER:int = 606;
const RUBI_INTRODUCED:int = 607;
const RUBI_BLU_BALLS:int = 608;
const RUBI_ORGASM_DENIAL:int = 609;
const RUBI_BIMBO:int = 610;
const RUBI_INCUBUS_PROGRESS:int = 611;
const RUBI_SUITCLOTHES:int = 612;
const RUBI_FETISH_CLOTHES:int = 613;
const RUBI_GREEN_ADVENTURER:int = 614;
const RUBI_TUBE_TOP:int = 615;
const RUBI_BODYSUIT:int = 616;
const RUBI_LONGDRESS:int = 617;
const RUBI_TIGHT_PANTS:int = 618;
const RUBI_NURSE_CLOTHES:int = 619;
const RUBI_SWIMWEAR:int = 620;
const RUBI_PROSTITUTION:int = 621;
const RUBIS_HOUSE_FIRST_TIME:int = 622;
const RUBI_GOT_BIMBO_SKIRT:int = 623;
const RUBI_PROFIT:int = 624;
const RUBI_BIMBO_MINIDRESS:int = 625;
const TIMES_RUBI_MASSAGED:int = 832;

function rubiBimbo():Boolean {
	return (flags[RUBI_BIMBO] > 0);
}
function rubiIncubus():Boolean {
	return (flags[RUBI_INCUBUS_PROGRESS] == 3);
}


function rubiAffection(delt:Number = 0):Number {
	if(delt == 0) return flags[RUBI_AFFECTION];
	flags[RUBI_AFFECTION] += delt;
	if(flags[RUBI_AFFECTION] > 100) flags[RUBI_AFFECTION] = 100;
	else if(flags[RUBI_AFFECTION] < 0) flags[RUBI_AFFECTION] = 0;
	return flags[RUBI_AFFECTION];
}
//Major notes
//Rubi has a relationship rating, which goes from 0 to 40.  Players start at 0.  There are no ways to decrease relationship with Rubi currently.

//Potential future additions might allow the player to begin stalking Rubi after rejecting him.
//At relationship 0-9, the PC is a stranger to Rubi, and in fact thinks he is a she.
//At relationship 10-19, Rubi is warming up to the PC, and has more flirty dialogue.
//At relationship 20-39, Rubi is a friend and lover of the PC.  At this stage you can give him certain sets of clothing, which he'll randomly wear while working at the Bakery.
//At relationship 40, Rubi is in love with the PC, and the PC can talk him into damn near anything.  At this stage, the PC can give him bimbo liqueur or incubus drafts.
 
//Rubi can be found in the Tel'Adre bakery from 12:00 to 20:00.  He is available to everyone, regardless of gender, corruption or transformation.  Rubi, however, is not interested in Centaurs, Naga or Driders (as of yet), and such PCs won't be able to advance beyond Relationship 19.  If players gain such bodies after reaching this level, the option to go home with Rubi won't be available.

//When the player reaches Relationship 50, a special scene is triggered.
function specialRelationship20scene():void {
	clearOutput();
	outputText("As you're leaving the bakery, you hear the clicking of heels behind you.  Turning back you see Rubi rushing towards you shouting, \"<i>Hey, wait a second!</i>\"  You do, and wait for her to catch up.  Stopping in front of you, she puts her hands on her dainty knees and catches her breath.");
	
	outputText("\n\n\"<i>Phew, sorry I didn't catch you as you were leaving.  You were gone so fast,</i>\" she takes a deep breath.  \"<i>Look, I-I like you.</i>\"  Her face flushes brightly.  \"<i>But I need to tell you something.  Something about me.</i>\"");
	
	outputText("\n\nYou ask if it's about her being part demon and she shakes her head.  \"<i>No, it's not about that.</i>\"  You urge her to continue.");
 
	outputText("\n\nShe looks unsure for a moment, opening and closing her ruby red lips without speaking.  You notice she's clenched one hand in the other tight enough to make it go white, and her legs are trembling like trees in a storm.  Stepping forward, you put your hands on her shoulders firmly, look her straight in the eyes and say that she can tell you anything.");
	
	outputText("\n\nNodding, slightly relieved, Rubi continues, \"<i>I-I'm a... I've liked pretty dresses and heels and all that since I was a kid.  So when I came to Tel'Adre, I saw it as my chance to reinvent myself.  But it's been... hard to reveal my true self.  So what I mean to say is: I'm a boy.</i>\"  Her... HIS already flushed face seems to turn an even deeper shade of scarlet.");
	
	outputText("\n\nYou're a little surprised, but it does make sense.  She... he is pretty flat-chested, and you'd often wondered if you'd seen a bulge of some sort in her skirt from time to time...");
	flags[RUBI_ADMITTED_GENDER] = 1;
	//(Accept) or (Reject)
	simpleChoices("Accept",3891,"Reject",3892,"",0,"",0,"",0);
}
//[If Accept]
function acceptRubi():void {
	clearOutput();
	outputText("You wrap your arms around and pull him into a hug.  You declare that you like him no matter what sort of genitals he happened to be born with.");
	
	outputText("\n\nHe wipes a tear from his eye and smiles, clutching you tightly.  \"<i>Oh thank Marae, I was so worried you'd hate me after that.</i>\"");
	
	outputText("\n\nYou wonder curiously how anyone could hate such a cute and bubbly creature such as he, and tell him so.  He pulls back slightly from you and his smile widens.");
	
	outputText("\n\n\"<i>I—Thank you, [name].  Just don't tell anyone about my secret, OK?  No sense in complicating my life here any further.</i>\"  You nod, and swear to keep his secret.");
 
	outputText("\n\nRubi gives you one last hug and walks back towards the bakery, his devilish tail swishing happily behind him.  \"<i>See you soon... babe,</i>\" he says, trying the name on for size.  You smile, and continue your journey back to camp.");
	rubiAffection(3);
	doNext(13);
}
 
//[If Reject]
function rejectRubi():void {
	clearOutput();
	outputText("With your hands on his shoulders you carefully keep him at arm's length.  Putting it as delicately as you can, you tell him that you're just not interested in him <i>that</i> way, not anymore at least.");
	outputText("\n\nRubi's eyes tear up, and you can see his lip quivering, but he puts on a brave face.  \"<i>I understand.  I just had to tell you.  Look, don't tell anyone else about this, OK?  I don't want my secret to get out.</i>\"  You confirm that you won't out him, and he gives you a small smile.");
	outputText("\n\nSniffing slightly, Rubi turns away and returns to the bakery, his devilish tail sullenly drooping behind him.");
	//(Will no longer encounter Rubi at the bakery.)
	flags[RUBI_DISABLED] = 1;
	doNext(13);
}
 

//Bakery Intro scenes
function rubiIntros():Number {
	if(flags[RUBI_DISABLED] > 0 || flags[RUBI_PROSTITUTION] == -2) return 0;
	outputText("\n");
	//(Haven't met yet)
	if(flags[RUBI_INTRODUCED] == 0) outputText("A cute human girl moves from table to table, bussing the empty ones and serving drinks to the occupied.  She's pretty flat-chested, and wears a pink and white frilly waitress uniform with an apron.  When she turns her back to you, you can tell she's not <i>entirely</i> human, what with the long red spaded tail coming out from under her dress.");
	//(Have met, relationship 0-19)
	else if(rubiAffection() < 30) outputText("Rubi is here, moving from table to table efficiently clearing the empty ones and serving new customers.  Her long red tail swishes back and forth, sometimes lifting her dress enough to get a peek at her panties.");
	//(Have met, relationship 40, Bimbo Rubi; cheating scene)
	else if(rubiBimbo() && flags[RUBI_PROSTITUTION] == 0 && rand(9) == 0) {
		outputText("Strangely, even though you know it's time for Rubi's shift, she's not here.\n");
		//(Rubi button still active, goes to \"<i>Cheating Rubi</i>\" scene)
		//(Have met, relationship 40, Bimbo Rubi)
		return 3893;
	}
	else if(rubiBimbo()) outputText("Rubi is here, moving from table to table, not quite as efficiently as she used to, but with a lot more exuberance.  Her long red tail swishes around, seemingly drawn towards the crotch of patrons and co-workers alike.");
	//(Have met, relationship 40, Incubus Rubi)
	else if(rubiIncubus()) outputText("Rubi is here, moving from table to table efficiently clearing the empty ones and serving new customers.  His long red tail curls sensuously down his leg, or the leg of whoever is nearby.");
 	//(Have met, relationship 20+)
	else outputText("Rubi is here, moving from table to table efficiently clearing the empty ones and serving new customers.  His long red tail swishes back and forth excitedly.");
	outputText("\n");
	return 3894;
}

//Approach Rubi scenes
function approachRubiScenes():void {
	clearOutput();
	//(First time)
	if(flags[RUBI_INTRODUCED] == 0) {
		outputText("You take a seat at a table and within seconds a young girl is at your side.  She hooks a finger around her ear, pulling her short black hair back and wedging a pencil behind the ear.  Smoothing down the front of her pink and white waitress uniform, she gives you a chipper smile.  \"<i>Hey hun, welcome to the Tel'Adre Bakery, I'm Rubi,</i>\" she says, giving a little curtsey.  \"<i>If you want any pastries or anything, just head on up to the counter and they'll take care of you.  If you need anything to drink: milk, tea or coffee, just flag me down and I'd be happy to help.</i>\"");
		outputText("\n\n\"<i>Our milk goes excellently with the cookies and brownies, and we get it fresh every day.  We can serve it warm or cold, however you want it.  We have several fine teas and coffees available as well.  They just help melt the stress away.  Anyway, here's a list of what we have today,</i>\" she hands you a small paper menu, and you take note of her perfectly manicured nails painted pastel blue.  \"<i>Give me a shout if you need anything!</i>\"  she says and heads off to give the same speech to another table, her black heels clicking on the stone floor with wonderful tak-tak noises.");
		flags[RUBI_INTRODUCED]++;
	}
	//(Approach repeat, relationship 0-19)
	else if(rubiAffection() < 30) {
		outputText("You take a seat and within seconds Rubi's there, handing you a menu and going over the day's specials.  She gives you a chipper smile, then quickly heads off to do the same with two more tables.");
	}
	//(Approach repeat, relationship 20+.  At this stage, randomly select an outfit from what the PC has given him, plus his waitress outfit.  Variants included for Bimbo /Incubus Rubi.)
	else {
		var choices:Array = new Array();
		choices[choices.length] = 1;
		if(flags[RUBI_SUITCLOTHES] == 1) choices[choices.length] = 2;
		if(flags[RUBI_FETISH_CLOTHES] == 1) choices[choices.length] = 3;
		//(Green Adventurer's Clothing (Normal)
		if(flags[RUBI_GREEN_ADVENTURER] == 1) choices[choices.length] = 4;
		//(Tube Top (Normal))
		if(flags[RUBI_TUBE_TOP] == 1) choices[choices.length] = 5;
		//(Bodysuit (Normal))
		if(flags[RUBI_BODYSUIT] == 1) choices[choices.length] = 6;
		//(Long Dress (Normal))
		if(flags[RUBI_LONGDRESS] == 1) choices[choices.length] = 7;
		//(Tight Leather Pants (Normal))
		if(flags[RUBI_TIGHT_PANTS] == 1) choices[choices.length] = 8;
		//(Nurse Clothes (Normal))
		if(flags[RUBI_NURSE_CLOTHES] == 1) choices[choices.length] = 9;
		//(Slutty Swimwear (Normal))
		if(flags[RUBI_SWIMWEAR] == 1) choices[choices.length] = 10;
		if(flags[RUBI_BIMBO_MINIDRESS] == 1) choices[choices.length] = 11;
		var select:int = choices[rand(choices.length)];	
		
		//(Random outfit selection: Waitress Outfit (Normal))
		if(select == 1) {
			//(Waitress Outfit (Bimbo))
			if(rubiBimbo()) {
				outputText("You take a seat at a table, and within seconds Rubi jumps into your lap with a giggle.  She wraps her arms around your neck and says, \"<i>Hiii baby.  You're always visiting me at work, you're like the best " + player.mf("boyfriend","girlfriend") + " EVER.</i>\"  She laughs and cuddles with you for a while, until you hear someone behind the counter clear their throat loudly.  Annoyed, Rubi gets off your lap and hands you the usual menu, \"<i>Like, look over the menu and I'll be right back.</i>\"");
				outputText("\n\nShe moves off to clear a nearby table, bending over enough to let everyone behind her see her completely naked ass.");
			}
			//(Waitress Outfit (Incubus))
			else if(rubiIncubus()) {
				outputText("You take a seat at a table, and within seconds Rubi pulls up a chair next to you.  He puts his hand on your knee and says, \"<i>Hey sweetness.  Back again for some... milk?</i>\"  He lets the pause sink in and laughs lightly.  \"<i>Here's the menu, but I'll bet you've already made up your mind.  Still, think about it, because there's sooo much you could drink.  Let me know when you're ready.</i>\"");
 				outputText("\n\nHe stands and moves to clean off a nearby table... bending over just far enough, and lifting his tail just high enough to give you a clear look at his panties with a clear bulge in the crotch.");
			}
			else {
				outputText("You take a seat at a table, and within seconds Rubi pulls up a chair next to you.  He puts a hand on your arm and says, \"<i>Hey babe.  Back for some more of my milk?</i>\"  He gives a light laugh and smiles.  \"<i>Here's the menu, but I'll bet you've already made up your mind.  Still, think about it, and let me know when you're ready.</i>\"");
				outputText("\n\nHe stands up and moves to clean off a nearby table... bending over just far enough, and lifting his tail just high enough to give you a clear look at his panties with the slight bulge.");
			}
		}
		//(Suit Clothes (Normal))
		else if(select == 2) {
			//(Suit Clothes (Bimbo))
			if(rubiBimbo()) {
				outputText("You take a seat at a table, and within seconds Rubi jumps into your lap with a giggle.  Only today she's dressed differently.  She's wearing a smart black and white suit with a loose tie, though she's still wearing the waitress uniform hairband.  In a sexy sort of way, she looks like a girl dressed in her boyfriend's clothes.  Her prodigious bosom prevents it from being buttoned all the way up, so you get a face full of cleavage with the tie buried between them.  She wraps her arms around your neck and says \"<i>Hiii baby.  You're always visiting me at work, you're like the best " + player.mf("boyfriend","girlfriend") + " EVER.</i>\"  She laughs and cuddles with you for a while, until you hear someone behind the counter clear their throat loudly.  Annoyed, Rubi gets off your lap and hands you the usual menu, \"<i>Like, look over the menu and I'll be right back.</i>\"");
				outputText("\n\nShe moves to clean off a nearby table, her red spaded tail swishing behind " + rubiMF("her","him") + ".  While the pants are not very flattering, her impressively shaped ass fills them out nicely when she bends over.");
			}
			//(Suit Clothes (Incubus))
			else if(rubiIncubus()) {
				outputText("You take a seat at a table, and within seconds Rubi pulls up a chair next to you.  Only today he's dressed differently.  He's wearing a smart black and white suit with a loose tie, though he's still wearing the waitress uniform headband just behind the pair of black horns protruding from his forehead.  In a silly sort of way, he looks like a girl dressed in her boyfriend's clothes.  Combined with his exotic skin, eyes and tail, it's a strange look, but oh-so sexy.  He puts his hand on your knee and says, \"<i>Hey sweetness.  Back again for some... milk?</i>\"  He lets the pause sink in and laughs lightly.  \"<i>Here's the menu, but I'll bet you've already made up your mind.  Still, think about it, because there's sooo much you could drink.  Let me know when you're ready.</i>\"");
				outputText("\n\nHe stands and moves to clean off a nearby table, his red spaded tail swishing behind him.  Unfortunately, the suit pants are a bit too baggy to get a good look at his ass, but still, the overall effect is very nice.");
			}
			else {
				outputText("You take a seat at a table, and within seconds Rubi pulls up a chair next to you.  Only today he's dressed differently.  He's wearing a smart black and white suit with a loose tie, though he's still wearing the waitress uniform hairband.  In a silly sort of way, he looks like a girl dressed in her boyfriend's clothes.  It's a strange look, but oh-so sexy on Rubi.  He puts a hand on your arm and says, \"<i>Hey babe.  Like the outfit?  Thought I'd switch things up today.</i>\"  He hands you the usual menu and says, \"<i>Here's your menu.  but I'll bet you've already made up your mind.  Still, think about it, and let me know when you're ready.</i>\"");
				outputText("\n\nHe stands and moves to clean off a nearby table, his red spaded tail swishing behind him.  Unfortunately, the suit pants are a bit too baggy to get a good look at his ass, but still, the overall effect is very nice.");
			}
		}
		else if(select == 3) {
			//(Rubber Fetish Outfit (Bimbo))
			if(rubiBimbo()) {
				outputText("You take a seat at a table, and within seconds Rubi jumps into your lap with a giggle.  Only today she's dressed differently.  She's wearing a tight black rubber shirt with holes cut out for her nipples (which stand at attention in the cool air), along with a black rubber skirt and rubber stockings.  Rubber straps adorn the outfit in strange places, and she looks like something you'd find in a sex dungeon.  The outfit seems to draw attention to her impressive bosom.  Overall, she looks like some sort of doll one might buy for those lonely nights.  She wraps her arms around your neck and says \"<i>Hiii baby.  You're always visiting me at work, you're like the best " + player.mf("boyfriend","girlfriend") + " EVER.</i>\"  She laughs and cuddles with you for a while, until you hear someone behind the counter clear their throat loudly.  Annoyed, Rubi gets off your lap with a squeak and hands you the usual menu, \"<i>Like, look over the menu and I'll be right back.</i>\"");
				outputText("\n\nShe then moves to clean off a nearby table, rubber squeaking as she goes.  She bends over just far enough, and lifting her tail just high enough to give you a clear look at her naked ass and moist pussy.");
			}
			//(Rubber Fetish Outfit (Incubus))
			else if(rubiIncubus()) {
				outputText("You take a seat at a table, and within seconds Rubi pulls up a chair next to you.  Only today he's dressed differently.  He's wearing a tight black rubber shirt with holes cut out for his nipples, along with a black rubber skirt and rubber stockings.  Rubber straps adorn the outfit in strange places, and he looks like something you'd find in a sex dungeon.  The outfit seems to draw attention to his flat chest, but with the rest of his figure, it's hard to imagine him as anything but a girl.  He puts his hand on your knee and says, \"<i>Hey sweetness.  Back again for some... milk?</i>\"  He lets the pause sink in and laughs lightly.  \"<i>Here's the menu, but I'll bet you've already made up your mind.  Still, think about it, because there's sooo much you could drink.  Let me know when you're ready.</i>\"")
				outputText("\n\nHe stands and moves to clean off a nearby table, rubber squeaking as he goes.  He bends over just far enough, and lifting his tail just high enough to give you a clear look at his rubber-pantied ass, with a sizable bulge in the crotch.");
			}
			//(Rubber Fetish Outfit (Normal))
			else {
				outputText("You take a seat at a table, and within seconds Rubi pulls up a chair next to you.  Only today he's dressed differently.  He's wearing a tight black rubber shirt with holes cut out for his nipples, along with a black rubber skirt and rubber stockings.  Rubber straps adorn the outfit in strange places, and he looks like something you'd find in a sex dungeon.  The outfit seems to draw attention to his flat chest, but with the rest of his figure, it's hard to imagine him as anything but a girl.  He puts a hand on your arm and says, \"<i>Hey babe.  Like the outfit?  Thought I'd switch things up today.</i>\"  He hands you the usual menu and says, \"<i>Here's your menu.  but I'll bet you've already made up your mind.  Still, think about it, and let me know when you're ready.</i>\"");
				outputText("\n\nHe stands and moves to clean off a nearby table, rubber squeaking as he goes.  He bends over just far enough, and lifting his tail just high enough to give you a clear look at his rubber-pantied ass.");
			}
		}
		else if(select == 4) {
			//(Green Adventurer's Clothing (Bimbo))
			if(rubiBimbo()) {
				outputText("You take a seat at a table, and within seconds Rubi jumps into your lap with a giggle.  Only today she's dressed differently.  She's wearing a large green tunic which, thanks to her impressive bosom, prevents the tunic from reaching much further than her waist, along with brown tights and a pointed green hat.  At her waist is a wooden sword alongside her normal notepad.  In an odd sort of way, she looks like an adventurer on the wrong end of a witch's curse.  She wraps her arms around your neck and says \"<i>Hiii baby.  You're always visiting me at work, you're like the best " + player.mf("boyfriend","girlfriend") + " EVER.</i>\"  She laughs and cuddles with you for a while, until you hear someone behind the counter clear their throat loudly.  Annoyed, Rubi gets off your lap with a squeak and hands you the usual menu, \"<i>Like, look over the menu and I'll be right back.</i>\"");
				outputText("\n\nShe moves to clean off a nearby table... bending over just far enough to give you a clear look at her ass.  You can even spy a moist patch in her crotch, which she must have a hard time hiding... if she even bothers to try.");
			}
			//Green Adventurer's Clothing (Incubus))
			else if(rubiIncubus()) {
				outputText("You take a seat at a table, and within seconds Rubi pulls up a chair next to you.  Only today he's dressed differently.  He's wearing a large green tunic which looks more like a tress on him, along with brown tights and a pointed green hat.  At his waist is a wooden sword alongside his normal notepad.  Were Rubi a bit more masculine, he might look like an adventurer of some kind, but in reality he looks rather like a demon poorly masquerading as one.  He puts his hand on your knee and says, \"<i>Hey sweetness.  Back again for some... milk?</i>\"  He lets the pause sink in and laughs lightly.  \"<i>Here's the menu, but I'll bet you've already made up your mind.  Still, think about it, because there's sooo much you could drink.  Let me know when you're ready.</i>\"");
				outputText("\n\nHe stands up and moves to clean off a nearby table... bending over just far enough, and lifting his tail just high enough to give you a clear look at his ass, subtly emphasized by the tights.");
			}
			//(Green Adventurer's Clothing (Normal))
			else {
				outputText("You take a seat at a table, and within seconds Rubi pulls up a chair next to you.  Only today he's dressed differently.  He's wearing a large green tunic which looks more like a dress on him, along with brown tights and a pointed green hat.  At his waist is a wooden sword alongside his normal notepad.  Were Rubi more masculine, he might look like an adventurer of some kind, but in reality he looks like a normal girl with a strange hat.  He puts a hand on your arm and says, \"<i>Hey babe.  Like the outfit?  Thought I'd switch things up today.</i>\"  He hands you the usual menu and says, \"<i>Here's your menu.  but I'll bet you've already made up your mind.  Still, think about it, and let me know when you're ready.</i>\"");
				outputText("\n\nHe stands up and moves to clean off a nearby table... bending over just far enough, and lifting his tail just high enough to give you a clear look at his ass, subtly emphasized by the tights.");
			}
		}
 		
		else if(select == 5) {
			//(Tube Top (Bimbo))
			if(rubiBimbo()) {
				outputText("You take a seat at a table, and within seconds Rubi jumps into your lap with a giggle.  Only today she's dressed differently.  She's wearing a neon pink tube top which really struggles to keep her massive breasts in place, along with a pair of tiny denim shorts which look to be in danger of becoming lost between her ass cheeks.  If you weren't in a bakery, you'd assume she was a hooker of some sort.  Hell, even in the bakery you get an overwhelming hooker vibe.  She wraps her arms around your neck and says \"<i>Hiii baby.  You're always visiting me at work, you're like the best " + player.mf("boyfriend","girlfriend") + " EVER.</i>\"  She laughs and cuddles with you for a while, until you hear someone behind the counter clear their throat loudly.  Annoyed, Rubi gets off your lap with a squeak and hands you the usual menu, \"<i>Like, look over the menu and I'll be right back.</i>\"");
				outputText("\n\nShe moves to clean off a nearby table, bending over and lifting her tail surreptitiously to give you a good look at her ass, emphasized by the shorts.");
			}
			//(Tube Top (Incubus))
			else if(rubiIncubus()) {
				outputText("You take a seat at a table, and within seconds Rubi pulls up a chair next to you.  Only today he's dressed differently.  He's wearing a neon pink tube top across his flat chest, along with a pair of tiny denim shorts.  His bulge is fairly well concealed, but you have no problem spotting it and idly wonder if those shorts might have been a bad idea.  The pink of the tube top also clashes with his cherry red skin, but he somehow pulls it off.  If you weren't in a bakery you'd assume he was an exotic hooker of some sort.  He puts his hand on your knee and says, \"<i>Hey sweetness.  Back again for some... milk?</i>\"  He lets the pause sink in and laughs lightly.  \"<i>Here's the menu, but I'll bet you've already made up your mind.  Still, think about it, because there's sooo much you could drink.  Let me know when you're ready.</i>\"");
				outputText("\n\nHe stands up and moves to clean off a nearby table... bending over and lifting his tail surreptitiously to give you a good look at his ass, emphasized by the shorts.");
			}
			//(Tube Top (Normal))
			else {
				outputText("You take a seat at a table, and within seconds Rubi pulls up a chair next to you.  Only today he's dressed differently.  He's wearing a neon pink tube top across his flat chest, along with a pair of tiny denim shorts.  His bulge is fairly well concealed, but you can tell it's there if you know what to look for.  If you weren't in a bakery, you'd assume he was a hooker of some sort.  He puts a hand on your arm and says, \"<i>Hey babe.  Like the outfit?  Thought I'd switch things up today.</i>\"  He hands you the usual menu and says, \"<i>Here's your menu.  but I'll bet you've already made up your mind.  Still, think about it, and let me know when you're ready.</i>\"");
				outputText("\n\nHe stands up and moves to clean off a nearby table... bending over and lifting his tail surreptitiously to give you a good look at his ass, emphasized by the shorts.");
			}
		}
		else if(select == 6) {
			//(Bodysuit (Bimbo))
			if(rubiBimbo()) {
				outputText("You take a seat at a table, and within seconds Rubi jumps into your lap with a giggle.  Only today she's dressed differently.  She's wearing an almost sheer bodysuit from the groin up to the neck.  The lacy material is patterened with flowers and swirling decorations.  Strategically placed blossoms cover her groin and attempt to cover her nipples, but fail in that regard.  The bodysuit is paired with long lacy stockings, which accent her legs excellently.  She wraps her arms around your neck and says \"<i>Hiii baby.  You're always visiting me at work, you're like the best " + player.mf("boyfriend","girlfriend") + " EVER.</i>\"  She laughs and cuddles with you for a while, until you hear someone behind the counter clear their throat loudly.  Annoyed, Rubi gets off your lap with a squeak and hands you the usual menu, \"<i>Like, look over the menu and I'll be right back.</i>\"");
				outputText("\n\nShe moves to clean off a nearby table... bending over and lifting her tail surreptitiously to give you a good look at her ass, emphasized by the tight lace bodysuit.");
			}
			//(Bodysuit (Incubus))
			else if(rubiIncubus()) {
				outputText("You take a seat at a table, and within seconds Rubi pulls up a chair next to you.  Only today he's dressed differently.  He's wearing an almost sheer bodysuit from the groin up to the neck.  The lacy material is patterned with flowers and swirling decorations.  Strategically placed blossoms cover his nipples and groin.  Of course, with an outfit this tight, one has to wonder whether his secret could be kept for long.  He puts his hand on your knee and says, \"<i>Hey sweetness.  Back again for some... milk?</i>\"  He lets the pause sink in and laughs lightly.  \"<i>Here's the menu, but I'll bet you've already made up your mind.  Still, think about it, because there's sooo much you could drink.  Let me know when you're ready.</i>\"");
				outputText("\n\nHe stands and moves to clean off a nearby table... bending over and lifting his tail surreptitiously to give you a good look at his ass, emphasized by the tight lace bodysuit.");
			}
			//(Bodysuit (Normal))
			else {
				outputText("You take a seat at a table, and within seconds Rubi pulls up a chair next to you.  Only today he's dressed differently.  He's wearing an almost sheer bodysuit from the groin up to the neck.  The lacy material is patterned with flowers and swirling decorations.  Strategically placed blossoms cover his nipples and groin.  Of course, with an outfit this tight, one has to wonder whether his secret could be kept for long.  He puts a hand on your arm and says, \"<i>Hey babe.  Like the outfit?  Thought I'd switch things up today.</i>\"  He hands you the usual menu and says, \"<i>Here's your menu.  but I'll bet you've already made up your mind.  Still, think about it, and let me know when you're ready.</i>\"");
				outputText("\n\nHe stands and moves to clean off a nearby table... bending over and lifting his tail surreptitiously to give you a good look at his ass, emphasized by the tight lace bodysuit.");
			}
		}
		else if(select == 7) {
			//(Long Dress (Bimbo))
			if(rubiBimbo()) {
				outputText("You take a seat at a table, and within seconds Rubi jumps into your lap with a giggle.  Only today she's dressed differently.  She's wearing an elegant sequin-adorned ballroom gown... which she's apparently modified with fake gems and a slit up the side to show off her leg.  The gown must also come with a padded bra, as Rubi's already impressive bust looks even larger.  The overall effect is stunning.  She'd look great at a fancy ball... well, a slightly fancy ball with the modifications, but here at the bakery she looks very out of place, especially for a waitress.  She wraps her arms around your neck and says \"<i>Hiii baby.  You're always visiting me at work, you're like the best " + player.mf("boyfriend","girlfriend") + " EVER.</i>\"  She laughs and cuddles with you for a while, until you hear someone behind the counter clear their throat loudly.  Annoyed, Rubi gets off your lap with a squeak and hands you the usual menu, \"<i>Like, look over the menu and I'll be right back.</i>\"");
				outputText("\n\nShe moves to clean off a nearby table with graceful sweeping movements that make it look like she's dancing with an invisible partner.  Then she begins to shake her ass and makes spanking motions, effectively ruining the air of sophistication.");
			}
			//Long Dress (Incubus))
			else if(rubiIncubus()) {
				outputText("You take a seat at a table, and within seconds Rubi pulls up a chair next to you.  Only today he's dressed differently.  He's wearing an elegant sequin-adorned ballroom gown... which he's apparently modified, dyeing the garment black and deep purple.  The gown apparently comes with a padded bra, because you're amazed to see Rubi appears to have breasts!  The overall effect is stunning.  He'd look great at a fancy ball, even with the darker colors, but here at the bakery he looks very out of place, especially for a waitress.  He puts his hand on your knee and says, \"<i>Hey sweetness.  Back again for some... milk?</i>\"  He lets the pause sink in and laughs lightly.  \"<i>Here's the menu, but I'll bet you've already made up your mind.  Still, think about it, because there's sooo much you could drink.  Let me know when you're ready.</i>\"");
				outputText("\n\nHe stands and moves to clean off a nearby table with graceful sweeping movements that make it look like he's dancing with an invisible partner.");
			}
			//(Long Dress (Normal))
			else {
				outputText("You take a seat at a table, and within seconds Rubi pulls up a chair next to you.  Only today he's dressed differently.  He's wearing an elegant sequin-adorned ballroom gown.  The gown apparently comes with a padded bra, because you're amazed to see Rubi appears to have breasts!  The overall effect is stunning.  He'd look great at a fancy ball, but here at the bakery he looks very out of place, especially for a waitress.  He puts a hand on your arm and says, \"<i>Hey babe.  Like the outfit?  Thought I'd switch things up today.</i>\"  He hands you the usual menu and says, \"<i>Here's your menu.  but I'll bet you've already made up your mind.  Still, think about it, and let me know when you're ready.</i>\"");
 				outputText("\n\nHe stands and moves to clean off a nearby table with graceful sweeping movements that make it look like he's dancing with an invisible partner.");
			}
		}
		else if(select == 8) {
			//(Tight Leather Pants (Bimbo))
			if(rubiBimbo()) {
				outputText("You take a seat at a table, and within seconds Rubi jumps into your lap with a giggle.  Only today she's dressed differently.  She's wearing a loose silk white shirt along with tight black leather pants.  She's incredibly sexy in it, and looks rather like a busty pirate.  The top is in clear danger of bursting open thanks to her ample bosom.  You're certain that one wrong move could send a button flying across the room.  She wraps her arms around your neck and says \"<i>Hiii baby.  You're always visiting me at work, you're like the best " + player.mf("boyfriend","girlfriend") + " EVER.</i>\"  She laughs and cuddles with you for a while, until you hear someone behind the counter clear their throat loudly.  Annoyed, Rubi gets off your lap with a squeak and hands you the usual menu, \"<i>Like, look over the menu and I'll be right back.</i>\"");
				outputText("\n\nShe moves to clean off a nearby table... bending over and lifting her tail surreptitiously to give you a good look at her ass, emphasized by the tight leather.");
			}
			//(Tight Leather Pants (Incubus))
			else if(rubiIncubus()) {
				outputText("You take a seat at a table, and within seconds Rubi pulls up a chair next to you.  Only today he's dressed differently.  He's wearing a loose silk white shirt along with tight black leather pants.  He's incredibly sexy in it, but you actually wonder if he looks a bit too... recognizable as a man in that outfit.  Granted, a rather effeminate man with an exotic skin tone, but still male.  You hope his secret stays safe, if only to keep him for yourself.  He puts his hand on your knee and says, \"<i>Hey sweetness.  Back again for some... milk?</i>\"  He lets the pause sink in and laughs lightly.  \"<i>Here's the menu, but I'll bet you've already made up your mind.  Still, think about it, because there's sooo much you could drink.  Let me know when you're ready.</i>\"");
				outputText("\n\nHe stands and moves to clean off a nearby table... bending over and lifting his tail surreptitiously to give you a good look at his ass, emphasized by the tight leather.");
			}
			//(Tight Leather Pants (Normal))
			else {
				outputText("You take a seat at a table, and within seconds Rubi pulls up a chair next to you.  Only today he's dressed differently.  He's wearing a loose silk white shirt along with tight black leather pants.  He's incredibly sexy in it, but you actually wonder if he looks a bit too... recognizable as a man in that outfit.  Granted, a rather effeminate man, but still male.  You hope his secret stays safe.  He puts a hand on your arm and says, \"<i>Hey babe.  Like the outfit?  Thought I'd switch things up today.</i>\"  He hands you the usual menu and says, \"<i>Here's your menu.  but I'll bet you've already made up your mind.  Still, think about it, and let me know when you're ready.</i>\"");
				outputText("\n\nHe stands and moves to clean off a nearby table... bending over and lifting his tail surreptitiously to give you a good look at his ass, emphasized by the tight leather.");
			}
		}
		if(select == 9) {
			//(Nurse Clothes (Bimbo))
			if(rubiBimbo()) {
				outputText("You take a seat at a table, and within seconds Rubi jumps into your lap with a giggle.  Only today she's dressed differently.  She's wearing a tight one piece white dress with a red cross over the breast pocket, as well as a little white hat with the same red cross.  She looks like some sort of nurse you'd expect to see in your dirty dreams, and you wonder how many people came into the bakery confused today.  She wraps her arms around your neck and says \"<i>Hiii baby.  You're always visiting me at work, you're like the best " + player.mf("boyfriend","girlfriend") + " EVER.</i>\"  She laughs and cuddles with you for a while, until you hear someone behind the counter clear their throat loudly.  Annoyed, Rubi gets off your lap with a squeak and hands you the usual menu, \"<i>Like, look over the menu and I'll be right back.</i>\"");
				outputText("\n\nShe moves to clean off a nearby table... bending over just far enough and lifting her tail just high enough to give you a clear look at her naked ass and pussy.");
			}
			//(Nurse Clothes (Incubus))
			else if(rubiIncubus()) {
				outputText("You take a seat at a table, and within seconds Rubi pulls up a chair next to you.  Only today he's dressed differently.  He's wearing a tight one piece white dress with a red cross over the breast pocket, as well as a little white hat with the same red cross.  He looks like the sort of nurse you'd expect to see in your dirty dreams, and you wonder how many people came into the bakery confused today.  He puts his hand on your knee and says, \"<i>Hey sweetness.  Back again for some... milk?</i>\"  He lets the pause sink in and laughs lightly.  \"<i>Here's the menu, but I'll bet you've already made up your mind.  Still, think about it, because there's sooo much you could drink.  Let me know when you're ready.</i>\"");
				outputText("\n\nHe stands and moves to clean off a nearby table... bending over just far enough and lifting his tail just high enough to give you a clear look at his panties with a not-insignificant bulge in the crotch.");
			}
			//(Nurse Clothes (Normal))
			else {
				outputText("You take a seat at a table, and within seconds Rubi pulls up a chair next to you.  Only today he's dressed differently.  He's wearing a tight one piece white dress with a red cross over the breast pocket, as well as a little white hat with the same red cross.  He looks like the sort of nurse you'd expect to see in your dirty dreams, and you wonder how many people came into the bakery confused today.  He puts a hand on your arm and says, \"<i>Hey babe.  Like the outfit?  Thought I'd switch things up today.</i>\"  He hands you the usual menu and says, \"<i>Here's your menu.  but I'll bet you've already made up your mind.  Still, think about it, and let me know when you're ready.</i>\"");
				outputText("\n\nHe stands up and moves to clean off a nearby table... bending over just far enough, and lifting his tail just high enough to give you a clear look at his panties with the slight bulge.");
			}
		}
		//(Slutty Swimwear (Normal))
		else if(select == 10) {
			//(Slutty Swimwear (Bimbo))
			if(rubiBimbo()) {
				outputText("You take a seat at a table, and within seconds Rubi jumps into your lap with a giggle.  Only today she's dressed differently.  She's wearing an impossibly skimpy black bikini.  The top barely has enough to cover her nipples, let alone her impressive bosom, and the bottoms are in danger of being lost in Rubi's ass crack.  All in all, she looks ready for the beach, not for serving drinks at a bakery.  She wraps her arms around your neck and says \"<i>Hiii baby.  You're always visiting me at work, you're like the best " + player.mf("boyfriend","girlfriend") + " EVER.</i>\"  She laughs and cuddles with you for a while, until you hear someone behind the counter clear their throat loudly.  Annoyed, Rubi gets off your lap with a squeak and hands you the usual menu, \"<i>Like, look over the menu and I'll be right back.</i>\"");
				outputText("\n\nShe moves to clean off a nearby table... bending over and lifting her tail surreptitiously to give you a good look at her ass, emphasized by the bikini bottoms.");
			}
			//(Slutty Swimwear (Incubus))
			else if(rubiIncubus()) {
				outputText("You take a seat at a table, and within seconds Rubi pulls up a chair next to you.  Only today he's dressed differently.  He's wearing an impossibly skimpy black bikini.  The top only emphasizes Rubi's flat chest, but unless you know what to look for, the bottom looks rather nice.  All in all, he looks ready for the beach, not for serving drinks at a bakery.  He puts his hand on your knee and says, \"<i>Hey sweetness.  Back again for some... milk?</i>\"  He lets the pause sink in and laughs lightly.  \"<i>Here's the menu, but I'll bet you've already made up your mind.  Still, think about it, because there's sooo much you could drink.  Let me know when you're ready.</i>\"");
				outputText("\n\nHe stands up and moves to clean off a nearby table... bending over and lifting his tail surreptitiously to give you a good look at his ass, emphasized by the bikini bottoms.");
			}
			else {
				outputText("You take a seat at a table, and within seconds Rubi pulls up a chair next to you.  Only today he's dressed differently.  He's wearing an impossibly skimpy black bikini.  The top only emphasizes Rubi's flat chest, but unless you know what to look for, the bottom looks rather nice.  All in all, he looks ready for the beach, not for serving drinks at a bakery.  He puts a hand on your arm and says, \"<i>Hey babe.  Like the outfit?  Thought I'd switch things up today.</i>\"  He hands you the usual menu and says, \"<i>Here's your menu.  but I'll bet you've already made up your mind.  Still, think about it, and let me know when you're ready.</i>\"");
				outputText("\n\nHe stands up and moves to clean off a nearby table... bending over and lifting his tail surreptitiously to give you a good look at his ass, emphasized by the bikini bottoms.");
			}
		}
		//(Minidress Outfit (Bimbo))
		else if(select == 11) {
			outputText("You take a seat at a table, and within seconds Rubi jumps into your lab with a giggle.  Only today she's dressed differently.  She's wearing an impossibly short strapless pink mini-dress.  The top barely comes up enough to cover her nipples, and you're sure she has to adjust her bust constantly to keep from popping out.  The bottom is so short she's certainly giving a show to anyone behind her whenever she so much as leans forwards.  It looks like she's ready for a night out dancing, rather than waiting tables.  She wraps her arms around your neck and says \"Hiii baby.  You're always visiting me at work, you're like the best " + player.mf("boyfriend","girlfriend") + " EVER.</i>\"  She laughs and cuddles with you for a while, until you hear someone behind the counter clear their throat loudly.  Annoyed, Rubi gets off your lap with a squeak and hands you the usual menu, \"Like, look over the menu and I'll be right back.\"");
			outputText("\n\nShe moves to clean off a nearby table… bending over and lifting her tail surreptitiously to give you a good look at her ass, and you're somehow not surprised at all to see she's not wearing panties.");
		}
	}
	//(add to the bottom of all:)
	outputText("\n\nYou look over the menu... what do you want?\n-----------------------\nMilk: 3 gems\nTea: 6 gems");
	var place:int = 0;
	var tea:int = 0;
	var milk:int = 0;
	if(player.gems >= 6) tea = 3896;
	else outputText("\n<b>You cannot afford tea.</b>");
	if(player.gems >= 3) milk = 3895;
	else outputText("\n<b>You cannot afford milk.</b>");
	if(flags[RUBI_ADMITTED_GENDER] >= 1) place = 3898;
	//[Milk] [Tea] [Chat] [Rubi's Place (Relationship 20+)] [Leave]
	simpleChoices("Milk",milk,"Tea",tea,"Chat",3897,"Rubi's Place",place,"Leave",2836);	
}

function rubiMF(man:String,woman:String):String {
	if(rubiBimbo()) return woman;
	else if(rubiIncubus()) return man;
	else if(flags[RUBI_ADMITTED_GENDER] == 1) return man;
	else return woman;	
}

//Choose Milk?
function buyRubiMilk():void {
	clearOutput();
	//(Increase thickness by a small amount?  +1 relationship)
	//(Relationship 0-19)
	if(rubiAffection() < 30) {
		outputText("You flag down Rubi and tell " + rubiMF("him","her") + " you'd like to order some milk.  " + rubiMF("He","She") + " nods and soon you're holding a glass of sweet smelling milk.  \"<i>We get it fresh every day,</i>\" " + rubiMF("he","she") + " says as you take a drink.  It is quite delicious.  You gulp it down, and find another glass placed in front of you.  \"<i>Free refills, hun.</i>\"");
		outputText("\n\nYou take it easier on the next couple glasses.  You chat with Rubi whenever " + rubiMF("he","she") + " comes by to top you off, and after a little while you find you've gotten to know " + rubiMF("him","her") + " a bit better.  Feeling full enough, you excuse yourself and head back to camp.");
		//(Increase thickness by a small amount?  +1 relationship)
	}
	//(Bimbo Rubi)
	else if(rubiBimbo()) {
		outputText("You flag down Rubi and tell her you'd like to order some milk.  She nods and soon you're holding a glass of sweet smelling milk.  \"<i>We like, get it fresh every day,</i>\" she says and giggles as you take a drink.  It is quite delicious.  You gulp it down, and find another glass placed in front of you.  \"<i>Free refills, baby.</i>\"");
		outputText("\n\nYou take it easier on the next couple of glasses.  You chat with Rubi whenever she comes by to top you off, and it's not long before she's sitting on your lap and giggling as you make terrible jokes.  After a while, you excuse yourself and head back to camp.");
	}
	//(Incubus Rubi)
	else if(rubiIncubus()) {
		//(+1 Corruption)
		stats(0,0,0,0,0,0,0,.3);
		outputText("You flag down Rubi and tell him you'd like to order some milk.  He nods and soon you're holding a glass of sweet smelling milk.  \"<i>We get it fresh every day,</i>\" he says, emphasizing the word 'fresh' in such a way that you feel a little aroused.  You take a drink, and it is quite delicious.  You gulp it down, and soon find another glass placed in front of you.  \"<i>Free refills... drink as much as you want, sweetness.</i>\"");
		outputText("\n\nYou take it easier on the next couple of glasses.  You chat with Rubi whenever he comes by to top you off, and it's not long before he's sitting with you, shamelessly flirting and running his hands along your body.  After a while, you excuse yourself and head back to camp.");
	}
	//(Relationship20+, normal Rubi)
	else {
		outputText("You flag down Rubi and tell " + rubiMF("him","her") + " you'd like to order some milk.  " + rubiMF("He","She") + " nods and soon you're holding glass of sweet smelling milk.  \"<i>We get it fresh every day,</i>\" " + rubiMF("he","she") + " says as you take a drink.  It is quite delicious.  You gulp it down, and find another glass placed in front of you.  \"<i>Free refills, babe.</i>\"");
		outputText("\n\nYou take it easier on the next couple glasses.  You chat with Rubi whenever " + rubiMF("he","she") + " comes by to top you off, it's not long before " + rubiMF("he","she") + "'s sitting with you and laughing as you make terrible jokes.  After a while, you excuse yourself and head back to camp.");
	}
	player.gems -= 3;
 	rubiAffection(3);
	player.modThickness(100,1);
	if(rubiAffection() >= 30 && flags[RUBI_ADMITTED_GENDER] == 0) doNext(3890);
	else doNext(13);
}
 
//Choose Tea?
function getTeaFromRubi():void {
	clearOutput();
	//(Reduce arousal and fatigue slightly?  +1 relationship)
	//(Relationship 0-19)
	if(rubiAffection() < 30) {
		outputText("You flag Rubi down and tell her you'd like to order a cup of tea.  She nods and soon you've got a piping hot cup of fragrant tea in front of you.  \"<i>It's our relaxing blend, soothes the body and mind,</i>\" she says.  You take a sip and sigh.  It is indeed relaxing.");
		outputText("\n\nYou find yourself almost drifting off as you drink, but Rubi comes by to chat and check on you.  After a while you feel like you've gotten to know her a bit better.  Feeling relaxed enough, you excuse yourself and head back to camp.");
	}
	//(Bimbo Rubi)
	else if(rubiBimbo()) {
		outputText("You flag Rubi down and tell her you'd like to order a cup of tea.  She nods and soon you've got a piping hot cup of fragrant tea in front of you.  \"<i>It's like, our relaxing blend.  Supposed to sooth the body and mind or something,</i>\" she says and giggles.  You take a sip and sigh.  It is indeed relaxing.");
		outputText("\n\nYou find yourself almost drifting off as you drink, but Rubi comes by to gossip and check on you.  She even takes a break to give you a sensual shoulder massage, often pressing her large chest into your back.  Feeling relaxed enough, you excuse yourself and head back to camp.");
	}
	//(Incubus Rubi)
	else if(rubiIncubus()) {
		//(+1 Corruption)
		stats(0,0,0,0,0,0,0,.5);
		outputText("You flag Rubi down and tell him you'd like to order a cup of tea.  He nods and soon you've got a piping hot cup of fragrant tea in front of you.  \"<i>It's our relaxing blend... with a bit of extra cream, if you know what I mean,</i>\" he says.  Arching an eyebrow you take a sip and sigh.  It is indeed relaxing, though you can't taste the 'extra cream.'");
		outputText("\n\nYou find yourself almost drifting off as you drink, but Rubi comes by to chat and check on you.  He even takes a break to give you a sensual shoulder massage, though his hands roam far beyond your shoulders.  Feeling relaxed enough, you excuse yourself and head back to camp.");
	}
	//(Relationship 20+, normal Rubi)
	else {
		outputText("You flag Rubi down and tell him you'd like to order a cup of tea.  He nods and soon you've got a piping hot cup of fragrant tea in front of you.  \"<i>It's our relaxing blend, soothes the body and mind,</i>\" he says.  You take a sip and sigh.  It is indeed relaxing.");
		outputText("\n\nYou find yourself almost drifting off as you drink, but Rubi comes by to chat and check on you.  He even takes a small break to give your temples a brief massage.  Feeling relaxed enough, you excuse yourself and head back to camp.");
	}
	player.gems -= 6;
	rubiAffection(5);
	fatigue(-25);
	if(rubiAffection() >= 30 && flags[RUBI_ADMITTED_GENDER] == 0) doNext(3890);
	else doNext(13);
}
 
//Choose Chat?
function chatWithRubi():void {
	clearOutput();
	//(+1 relationship)
	rubiAffection(2);
	//(Relationship 0-9)
	if(rubiAffection() < 15) {
		outputText("You decide not to order anything to drink, instead taking the chance to talk with your waitress, Rubi, whenever she's available.  You talk of pleasant but inconsequential things.  Rubi talks of growing up in a town far away, an actual human village, which was later raided by demons.  She lived off the land for a while, drinking down one too many bottles of mysterious milk which gave her the tail she now possesses.  She eventually found Tel'Adre and was taken in by a kindly trio of ferretmorphs.  She talks wistfully of home, and her green eyes shimmer with a faraway look for a moment before she snaps back to reality.");
		outputText("\n\nExcusing herself, she moves to attend with other tables.  You decide this is a good time to head back to camp as well.");
	}
	//(Relationship 10-19)
	else if(rubiAffection() < 30) {
		rubiAffection(8);
		outputText("You decide not to order anything to drink, instead taking the chance to talk with Rubi whenever she's available.  You talk of pleasant but inconsequential things.  Rubi spends some time describing her life living outside the safety of Tel'Adre.  She'd never been caught by the various creatures, but there have been close calls.  She met several people who helped her out, however.  She talks highly of a dogmorph that runs a farm not far away, and of an otter-girl that fishes along a nearby lake.  She laughs and reminisces about how good the otter-girl's cooking was, and that even now she still can't find a decent fish filet.");
		outputText("\n\nEventually you run out of topics to discuss, and excuse yourself, heading back to camp.");
	}
	//(Relationship 20-39)
	else if(rubiAffection() < 100) {
		outputText("You decide not to order anything to drink, instead taking the opportunity to hang out with Rubi whenever he has a free moment.  You talk of pleasant but inconsequential things.  Rubi spends some time describing life with his three adoptive ferret parents.  Two males and a female, apparently, all lovers.  Rubi was taken in by them several years ago, and though " + rubiMF("he","she") + "'s since moved out, he still keeps in contact with them.  " + rubiMF("He","She") + " blushes and tells you of the times " + rubiMF("he","she") + "'s been unable to sleep, hearing the three of them going at it for hours on end.");
		outputText("\n\nEventually you run out of topics to discuss and excuse yourself, giving Rubi a kiss on the cheek before heading back to camp.");
	}
	//(Relationship 40, Bimbo Rubi)
	else if(rubiBimbo()) {
		outputText("You decide not to order anything to drink, instead taking the opportunity to hang out with Rubi whenever she has a free moment.  You talk of pleasant but inconsequential things.  Rubi spends some time discussing the fashion movements of Tel'Adre and how they're nothing like the fashion in her home village, an honest-to-goodness human village.  She mentions how everyone back 'home' dressed so conservatively, not like the sexy body-baring fashions here.  Rubi even says how glad she is that demons attacked those years ago, so that she could come here and start her new life with hot new clothes and a new body.");
		outputText("\n\nEventually you run out of topics to discuss and excuse yourself, giving Rubi a passionate kiss on the lips before heading back to camp.");
	}
	//(Relationship 40, Incubus Rubi)
	else if(rubiIncubus()) {
		outputText("You decide not to order anything to drink, instead taking the opportunity to hang out with Rubi whenever he has a free moment.  You talk of pleasant but inconsequential things.  Rubi spends some time discussing his old village, an honest-to-goodness human village.  Life there was good, but boring.  They had plenty of farms bringing in food, but there was very little corruption to contend with.  The few residents with inhuman features achieved them willingly.  Then, thankfully (according to Rubi), a detachment of incubi, succubi and imps invaded.  Rubi along with a handful of others escaped, but got split up along the way.  As far as Rubi knows, everyone else either perished or was corrupted in the aftermath.  He gets a little excited talking about his friends and family being corrupted, and you see a glint of hope in his eyes.");
		outputText("\n\nEventually you run out of topics to discuss and excuse yourself, giving Rubi a kiss on the lips before heading back to camp.");
	}
	//(Relationship 40, normal Rubi)
	else {
		outputText("You decide not to order anything to drink, instead taking the opportunity to hang out with Rubi whenever he has a free moment.  You talk of pleasant but inconsequential things.  Rubi spends some time discussing his old village, an honest-to-goodness human village.  Life there was good, they had plenty of farms bringing in food, and very little corruption to contend with.  There were some residents with inhuman features, usually achieved willingly, but the majority were pureblood humans.  That changed years ago when a detachment of incubi, succubi and imps attacked.  Rubi and a handful made it out fine, but got split up along the way.  As far as Rubi knows, everyone else either perished or was corrupted in the aftermath.");
		outputText("\n\nEventually you run out of topics to discuss and excuse yourself, giving Rubi a kiss on the lips before heading back to camp.");
	}
	if(rubiAffection() >= 30 && flags[RUBI_ADMITTED_GENDER] == 0) doNext(3890);
	else doNext(13);
}
 
//Choose Rubi's Place?
function rubisFuckingHouseYouPervert():void {
	clearOutput();
	//(Not available to those with a centaur, naga or drider body.)
	//(First Time?)
	if(flags[RUBIS_HOUSE_FIRST_TIME] == 0) {
		outputText("Rather than order anything, you stop Rubi as he's going by your table and pull " + rubiMF("him","her") + " close.  \"<i>How about we get out of here?</i>\" you whisper into " + rubiMF("his","her") + " ear.");
		outputText("\n\n" + rubiMF("He","She") + " blushes slightly and his tail swishes excitedly behind " + rubiMF("him","her") + ".  \"<i>Just,</i>\" " + rubiMF("he","she") + " looks around quickly, \"<i>Just let me find someone to cover my shift.</i>\"  " + rubiMF("He","She") + " promptly heads off into the back room, returning minutes later with a young canine girl in a waitress uniform.  Rubi points out a few tables, says some things to his replacement and then returns to your side.");
		outputText("\n\n" + rubiMF("He","She") + " clutches your arm tightly and says, \"<i>My place isn't far away, let's go.</i>\"   You stand and " + rubiMF("he","she") + " takes you by the arm through the streets of Tel'Adre.  " + rubiMF("He","She") + " leads you over a couple blocks into a rather nice looking neighborhood, and up to a row of tightly packed houses.  The two of you continue through a carefully tended garden and through the front door.");
		outputText("\n\nRubi relinquishes " + rubiMF("his","her") + " grip on your arm and says, \"<i>Make yourself at home!</i>\"  as " + rubiMF("he","she") + " rushes off into another room.  You take this opportunity to look around.  The place seems tastefully decorated, with lots of cushions and pillows to sit or lay on, in a variety of colors.  On the mantel above the fireplace sits a slightly scorched portrait of two happy-looking humans with a very young boy.  You'd guess that's Rubi and " + rubiMF("his","her") + " family, before the demon attack.");
		outputText("\n\nYou don't have to wait for Rubi long, as " + rubiMF("he","she") + " comes back holding two glasses of wine.  " + rubiMF("He","She") + " hands you one, and you take a sip, slightly surprised at the elegant flavors and delightful aroma.  The two of you drink and chat for a while, but then Rubi looks you in the eye and says, \"<i>So... You've got me alone.  What did you have in mind?</i>\"");
		flags[RUBIS_HOUSE_FIRST_TIME]++;
	}
	//Bimbo Shopping!
	else if(rubiBimbo() && (player.hasPerk("Bimbo Brains") >= 0 || player.hasPerk("Futa Faculties") >= 0) && rand(7) == 0) {
		flags[RUBI_BIMBO_MINIDRESS] = 1;
		outputText("Rather than order anything, you stop Rubi as she's going by your table and pull her close.  \"<i>How about we get out of here?</i>\"  you whisper into her ear.");
		outputText("\n\nRubi's mouth pulls into a Cheshire-like grin and she nods.  \"<i>Like, for sure!  Just let me get Dia to cover my tables, kay?</i>\"  She promptly heads off into the back room, returning minutes later with the young canine waitress behind her.  Rubi points out a few tables, says some things to her replacement, and then returns to your side.");
		outputText("\n\n\"<i>Let's totally blow this joint,</i>\" she says and you head off towards her place.  However, you don't make it too far.  On your way to the neighborhood Rubi lives in, you pass a little tailor's shop with the cutest little outfit in the window.  Giggling to yourselves, and completely forgetting what you were doing, you enter the shop.");
		outputText("\n\nPretty fabrics are laid out on every surface, pinks and pastels, with frills and lace.  Cute little tops and matching bottoms hang up, and Rubi immediately darts to one section, going through the racks with gleeful abandon.  You can't help but giggle and join her, going through outfit after outfit, and comparing it to yourself or your airheaded companion.");
		outputText("\n\nAfter about a half hour of trying on various outfits, Rubi picks out a gorgeous little outfit and purchases it.");
		//(10% chance of finding the Bimbo Skirt; only happens once) 
		if(flags[RUBI_GOT_BIMBO_SKIRT] == 0) {
			outputText("\n\nMeanwhile, nothing really catches your eye... that is until you spot a pink, pleated skirt, with a pink and white halter top.  You squeal with delight as you pick it out.  It's just your size!");
			outputText("\n\n\"<i>Ooh, that looks so sexy, babe.  Let me get that for you.  My treat, for such a sexy beast,</i>\" Rubi exclaims, and passes the money to the tailor.  As you leave the shop, you thank your lover profusely, and then head back to camp.");
			outputText("\n\nIt's only once you get back tbat you realize you meant to fuck Rubi while you were in town!  You giggle and curse your airheadedness.  Oh well, you can always go into town again, there's always more shopping to be done!");
			//(Add Bimbo Skirt to inventory)
			menuLoc = 2;
			shortName = "BimboSk";
			takeItem();
			return;
		}
		//(If Bimbo Skirt not found) 
		else {
			outputText("\n\nMeanwhile, nothing really catches your eye, and you end up leaving the shop feeling rather unfulfilled.  Your lover gives you a quick peck on the cheek and thanks you for a great time, and you go your separate ways again.");
			outputText("\n\nIt's only once you get back to camp that you realize you meant to fuck Rubi while you were in town!  You giggle and curse your airheadedness.  Oh well, you can always go into town again, there's always more shopping to be done!");
		}
	}
	//(Repeat, Bimbo Rubi)
	else if(rubiBimbo()) {
		//(If PC is also a Bimbo, there is a small chance to get the Bimbo Shopping encounter instead)
		outputText("Rather than order anything, you stop Rubi as she's going by your table and pull her close.  \"<i>How about we get out of here?</i>\"  you whisper into her ear.");
		outputText("\n\nRubi's mouth pulls into a Cheshire-like grin and she nods.  \"<i>Like, for sure!  Just let me get Dia to cover my tables, kay?</i>\"  She promptly heads off into the back room, returning minutes later with the young canine waitress behind her.  Rubi points out a few tables, says some things to her replacement, and then returns to your side.");
		outputText("\n\n\"<i>Let's totally blow this joint,</i>\" she says and you head off towards her place.  The two of you settle into her newly redecorated home.  It seems she replaced the originally colorful pillows and curtains with various shades of pink, and her family portrait has been painted over in spots, now showing a happy human couple and their daughter all dressed up in pink.");
		//(If PC is Pimping Bimbo Rubi AND it's been a day since last seeing Rubi) 
		if(flags[RUBI_PROSTITUTION] == 2 && flags[RUBI_PROFIT] > 0) {
			outputText("\n\nYour little fuckslut scampers over to a little bejeweled lockbox and opens it, retrieving a sackful of money.  \"<i>Here's your cut for my little side job,</i>\" she giggles.");
			//(Produces money daily?  Not too much, Rubi's a dumb blonde, and we don't want the PC to have a gem farm.  Enough to make it useful, not enough to make it mandatory.)
			player.gems += flags[RUBI_PROFIT];
			flags[RUBI_PROFIT] = 0;
			statScreenRefresh();
		}
		outputText("\n\n\"<i>So baby, what do you wanna do to me?</i>\" she whispers into your ear.");
	}
	//(Repeat, Incubus Rubi)
	else if(rubiIncubus()) {
		outputText("Rather than order anything, you stop Rubi as he's going by your table and pull him close.  \"<i>How about we get out of here?</i>\" you whisper into his ear.");
		outputText("\n\nRubi's mouth pulls into a Cheshire-like grin and he nods.  \"<i>Oh, you bet.  Just let me get the bitch to cover for me.</i>\"  He promptly heads off into the back room, returning minutes later with the young canine waitress behind him.  Rubi points out a few tables, says some things to his replacement, and then returns to your side.");
		outputText("\n\n\"<i>Let's get out of here,</i>\" he says and you head off towards his place.  The two of you settle into his newly redecorated home.  It seems he replaced all the cushions and curtains with more subdued colors, and his family portrait is curiously missing from the mantelpiece.  \"<i>So sweetness, what do you want to do to me?</i>\"");
	}
	//(Repeat, normal Rubi)
	else {
		outputText("Rather than order anything, you stop Rubi as he's going by your table and pull him close.  \"<i>How about we get out of here?</i>\"  you whisper into his ear.");
		outputText("\n\nHe blushes and his tail swishes excitedly behind him.  \"<i>Again?</i>\"  he looks around furtively, \"<i>Let me get Dia to cover my shift.</i>\"  He promptly heads off into the back room, returning minutes later with the young canine waitress behind him.  Rubi points out a few tables, says some things to his replacement, and then returns to your side.");
		outputText("\n\n\"<i>Let's go,</i>\" he whispers and you head off towards his place.  It doesn't take long for the two of you to settle in, and he asks, \"<i>So, what did you have in mind?</i>\"");
	}
	//[Fuck Rubi (if player has cock, OR at least a 4</i>\" clit)] [Dildo Fuck (If player has Deluxe Dildo)] [Tease] [Release (Only if Normal or Incubus Rubi who has been teased)] [Titfuck (Bimbo Rubi only)] [Give Item]
	var fuck:int = 0;
	var dildo:int = 0;
	var releas:int = 0;
	var titfuck:int = 0;
	var give:int = 0;
	if(player.lust >= 33) {
		if(player.hasCock() || (player.hasVagina() && player.clitLength >= 4)) fuck = 3899;
		if(player.hasKeyItem("Deluxe Dildo") >= 0) dildo = 3900;
		//if(player.hasCock() && rubiBimbo()) titfuck = 9999;
	}
	else outputText("\n\nYou aren't aroused enough to fuck Rubi right now.");
	if(flags[RUBI_BLU_BALLS] > 0 && flags[RUBI_ORGASM_DENIAL] > 0 && !rubiBimbo()) releas = 3902;
	
	//choices("Fuck",fuck,"Dildo Fuck",dildo," Tease ",3901,"Release",releas,"Titfuck",0,"Give Item",3903,"",0,"",0,"",0,"Leave",13);
	menu();
	if(fuck > 0) addButton(0,"Fuck",eventParser,fuck);
	if(dildo > 0) addButton(1,"Dildo Fuck",eventParser,dildo);
	addButton(2," Tease ",eventParser,3901);
	if(releas > 0) addButton(3,"Release",eventParser,releas);
	addButton(5,"Give Item",eventParser,3903);
	addButton(9,"Leave",eventParser,13);
	if(rubiAffection() >= 50 && !rubiBimbo()) {
		//First Time:
		if(flags[TIMES_RUBI_MASSAGED] == 0) outputText("\n\nRubi gestures to some bottles and a box from the bakery before mentioning, \"<i>You look awful tense, babe.  I know you've got it hard out there, and well, I-I thought maybe I could really pamper you today, if you'd like.</i>\"");
		else outputText("\n\nRubi nods towards the bottles and box in the corner and gives you a sly wink.  \"<i>Want another massage?</i>\"");
		addButton(4,"Massage",chocoRubiMassage);
	}
}
	
//Sex Scenes Ahoy!  
//There are variants for Normal, Bimbo and Incubus Rubi, as well as smaller variations if you're currently teasing him or not.
//Fuck Rubi
//(available for players with cocks or large clits (at least 4</i>\")) (If Orgasm Denial is activated, adds 1 to Blue Balls)
function fuckRubi():void {
	var x:int = player.cockThatFits(24);
	if(x < 0) x = player.biggestCockIndex();
	clearOutput();
	//(-100 Arousal)
	outputText("You take Rubi by the hand and head into the bedroom, clutching " + rubiMF("him","her") + " close.  You sit on the edge of the soft fluffy bed and pull the little demon " + rubiMF("boy","girl") + " onto your lap.  The two of you kiss, letting your tongue explore the depths of your partner's mouth.");
	outputText("\n\nRunning your hands along Rubi's body, you pull and tear at the clothes keeping you apart.  Garments fly as you ravish each other, and it isn't long before you're both naked, with Rubi straddling your waist.  " + rubiMF("He giggles and reaches between his legs","She giggles and reaches between her legs") + ", wrapping slender fingers around your ");
	if(player.hasCock()) outputText(cockDescript(x));
	else outputText(clitDescript());
	outputText(".");
	
	var size:int = 0;
	var cock:Boolean = player.hasCock();
	//(If player cock/clit at or under 4</i>\")
	if(player.hasCock()) {
		if(player.cocks[x].cockLength <= 4) size = 0;
		else if(player.cocks[x].cockLength <= 12) size = 1;
		else size = 2;
	}
	else {
		if(player.clitLength <= 4) size = 0;
		else if(player.clitLength <= 12) size = 1;
		else size = 2;
	}
	if(size == 0) {
	   outputText("\n\n\"<i>Oh, not packing much here, hm?</i>\"  Rubi asks, smiling, \"<i>");
	   if(!rubiBimbo() && !rubiIncubus()) outputText("I guess we're in the same boat.");
	   else if(rubiBimbo()) outputText("That's too bad, I was soooo looking forward to a real fucking.");
	   else outputText("It really is quite sad, so I guess I will take pity on you.");
	   outputText("</i>\"");
	}
	
	else if(size == 1) outputText("\n\n\"<i>Oh wow, you're quite the stud,</i>\" Rubi says, eyes sparkling with anticipation.");
	//(If too big, dick/clit area above 24) 
	else outputText("\n\n\"<i>Oh by Marae... there's no way I could fit this inside me... but there are other things we can do with this.</i>\"");
	
	outputText("\n\nRelinquishing the hold on your ");
	if(player.hasCock()) outputText("cock");
	else outputText("clit");
	outputText(", Rubi slips off your lap and kneels on the floor.  ");
	//(Normal Rubi) 
	if(!rubiBimbo() && !rubiIncubus()) {
		outputText("He pauses a moment, taking in your ");
		if(player.hasCock()) outputText(cockDescript(x));
		else outputText(clitDescript());
		outputText(" with his eyes before leaning in and giving it a tentative lick, which sends a shiver up your spine.  Seeing that, he gives a little smile and licks again, running his smooth tongue all along the length of your ");
		if(player.hasCock()) outputText("swollen member");
		else outputText("impressive love button");
		outputText(".  Rubi's mouth dances along its length, at times flicking delicately and at others slurping loudly.");
	}
	//(Bimbo Rubi) 
	else if(rubiBimbo()) {
		outputText("She pauses a moment, taking in your ");
		if(player.hasCock()) outputText(cockDescript(0));
		else outputText(clitDescript());
		outputText(" with her eyes before giggling and diving right in, planting her plump lips on the head and taking in as much as she can.  Her tongue ripples along the underside of ");
		if(player.hasCock()) outputText("your cockhead");
		else outputText("the tip of your clit");
		outputText(", sending shivers of pleasure up your spine.");
	}
	//(Incubus Rubi)
	else {
		outputText("He pauses a moment, taking in your ");
		if(player.hasCock()) outputText(cockDescript(0));
		else outputText(clitDescript());
		outputText(" with his eyes before a sly grin crosses his face and he leans in, running his tongue along ");
		if(player.hasCock()) outputText("your cockhead");
		else outputText("the tip of your clit");
		outputText(".  His lips wrap around the tip and suck lightly while he runs a finger along your entire length, teasing and taunting you with his nails.");
	}
	//(If Cock) 
	if(player.hasCock()) outputText("  You can't hold yourself in much longer, and begin to tense up, but at the last minute you pull yourself away from Rubi's grip and lips, halting yourself before you can cum.");
	
	//(These two paragraphs for cocks under 24 area)
	if(size < 2) {
		//(Normal/Incubus Rubi) 
		if(!rubiBimbo()) {
			outputText("\n\nFiguring he's had enough time in charge, you stand and get behind Rubi, pushing him so that his chest and head are resting on the edge of the bed.  You lift his tail and place your ");
			if(player.hasCock()) outputText(cockDescript(x));
			else outputText(clitDescript());
			outputText(" at his tight tailhole, rubbing his saliva and your juices into his rump to get him suitably lubricated before the real fun begins.");
		}
		//(Bimbo Rubi) 
		else {
			outputText("\n\nFiguring she's had enough time in charge, you stand and get behind Rubi, pushing her so that her breasts and head are resting on the edge of the bed.  You lift her tail and place your ");
			if(player.hasCock()) outputText(cockDescript(x));
			else outputText(clitDescript());
			outputText(" at her tight cunt, rubbing her saliva and your juices onto her lips, not that she needs the extra lubrication, as she's practically dripping like a faucet.");
		}
		outputText("  You press forward, sinking your entire length into Rubi's depths, which clench and unclench sensually.  Aided by the additional lubrication, you slip easily in and out, pumping slowly at first.");
	}
	//(These two paragraphs for cocks over 24 area)
	else {
		//(Normal/Incubus Rubi) 
		if(!rubiBimbo()) outputText("\n\nFiguring he's had enough time in charge, you stand and get behind Rubi, pushing him so that his chest and head are resting on the edge of the bed.  You lift his tail, press his legs together, and place your " + cockClit(x) + " at the space just below his balls, rubbing his saliva and your juices into his legs to get him suitably lubricated before the real fun begins.");
		//(Bimbo Rubi)
		else outputText("\n\nFiguring she's had enough time in charge, you stand and get behind Rubi, pushing her so that her breasts and head are resting on the edge of the bed.  You lift her tail, press her legs together, and place your " + cockClit(x) + " at the space just below her cunt, rubbing her saliva and your juices onto her legs, not that she needs the extra lubrication, as she's practically dripping like a faucet, which dribbles down her legs suitably enough.");
		outputText("  You press forward, your enormous cock slipping between Rubi's thighs, which grip you tightly.");
	}
	//(Normal/Incubus Rubi) 
	if(!rubiBimbo() && size >= 2) {
		outputText("\n\nYou feel his hard cock pressing against the top of ");
		if(player.hasCock()) outputText("yours");
		else outputText("your clit");
		outputText(", and know that with every thrust you give, he'll get a good thrill too.");
	}
	//imbo Rubi) 
	else if(rubiBimbo()) {
		outputText("\n\nYou can feel her stiff clit pressing against the top of ");
		if(player.hasCock()) outputText("your cock");
		else outputText("yours");
		outputText(", and know that with every thrust, she'll get quite the experience too.");
	}
	outputText("\n\nThrusting deeper and deeper, you pick up the pace slowly.  Rubi clutches at the blankets, eyes closed, biting " + rubiMF("his","her") + " lip.");
	//(If Orgasm Denial is activated)
	if(flags[RUBI_ORGASM_DENIAL] > 0 && !rubiBimbo()) outputText("  You give Rubi's ass a hard smack and remind him that no matter what happens, he still can't cum yet.  His eyes flutter open and he actually whimpers a little, but can't form the words to object.");
	//(If Orgasm Denial is NOT activated; Normal/Incubus Rubi) 
	else if(!rubiBimbo()) outputText("  Rubi's body shivers and trembles, and almost collapses.  He grasps at the blankets with wild abandon as ropes of pearly white cum erupt from his cock, splattering against his chest and the blankets.");
	//(Bimbo Rubi) 
	else outputText("  Rubi's body shivers and trembles, and she almost collapses.  She grasps at the blankets with wild abandon and gives an orgasmic scream as her cunt clenches and unclenches fiercely.  A spray of fem-juices erupts outwards from her, coating your crotch and dripping down both yours and her legs.");
 
	outputText("\n\nYou keep this up for as long as you can, steeling yourself until you just can't take any more.  With a final, deep thrust, you groan and let your mind blank as the orgasm overtakes you.  ");
	//(Player has cock under 24 area?) 
	if(size < 2 && player.hasCock()) {
		outputText("Your " + cockDescript(x) + " engorges for a second before erupting deep inside your fucktoy.  ");
		if(player.cumQ() < 250) outputText("Cum dribbles out from " + rubiMF("his ass ","her folds ") + "as you give a couple extra thrusts.");
		else if(player.cumQ() < 1000) outputText("A generous amount of cum trickles from " + rubiMF("his ass ","her folds ") + "as you give a couple extra thrusts.");
		else if(player.cumQ() < 2000) outputText("Cum practically floods from " + rubiMF("his abused ass ","her abused cunt ") + "as you give a couple extra thrusts.");
	}
	else if(player.hasCock()) {
		outputText("Your " + cockDescript(x) + " engorges for a second before erupting beneath Rubi, splattering " + rubiMF("him","her") + " and the blankets ");
		if(player.cumQ() < 250) outputText("with a fair amount of your seed.");
		else if(player.cumQ() < 1000) outputText("with a generous amount of your spunk.");
		else outputText("with a veritable torrent of potent pearlescent spooge.");
	}
	//(Player has clit?) 
	else outputText("  Your " + clitDescript() + " throbs and engorges briefly as your " + vaginaDescript(0) + " reflexively contracts and a warm feeling rocks through your entire body.  Femjuices run down your legs and relief overtakes you.");
	
	outputText("\n\nYou stumble backwards, pulling your " + cockClit(x) + " out of Rubi and collapse on the bed next to " + rubiMF("him","her") + ".  ");
	//(Normal Rubi) 
	if(!rubiBimbo() && !rubiIncubus()) outputText("He cuddles up next to you, in a puddle of spunk, and hugs you close.  \"<i>That was fantastic babe,</i>\" he murmurs before drifting off into a light nap.");
	//(Incubus Rubi) 
	else if(rubiIncubus()) outputText("He cuddles up next to you, in a puddle of spunk, and hugs you close, dry humping absently.  \"<i>That was amazing sweetness,</i>\" he murmurs before drifting off into a sex-filled dreamland.");
	else outputText("She cuddles up next to you, in a puddle of various juices and hugs you close.  \"<i>That was like, so totally amazing baby,</i>\" she murmurs before drifting off into a sex-filled haze.");
	
	outputText("\n\nYou're tempted to drift off as well, but as they say, you've got things to see and people to do.  So you peel yourself away from Rubi, grab a quick shower, and head off back to camp.");
	stats(0,0,0,0,0,0,-100,0);
	doNext(13);
	rubiAffection(1);
	if(flags[RUBI_ORGASM_DENIAL] > 0) flags[RUBI_BLU_BALLS]++;
}

//Dildo Fuck
//(If the PC has the Deluxe Dildo) (If Orgasm Denial is activated, adds +2 to Blue Balls (Yay arousal drugs!))
function dildoFuckRubi():void {
	clearOutput();
	//(If PC has no cock) 
	if(!player.hasCock()) outputText("You don't have the equipment to give Rubi a good fucking, but there is one thing you do have.");
	//(If PC has cock)
	else outputText("While you do have the requisite equipment to give Rubi a good fucking, you'd much rather use something else.");
	//(Add) 
	outputText("  You produce the goblin-made dildo from your pack, and Rubi's eyes immediately go wide.  \"<i>Wow,</i>\" " + rubiMF("he","she") + " says, reaching out to touch it.  " + rubiMF("He runs his","She runs her") + " hands along its length, marveling at its color, shape and size.");
	
	outputText("\n\n\"<i>Do... do we get to use it?</i>\"  Rubi asks with apprehension.  You nod, and the grin that crosses " + rubiMF("his","her") + " face can only be described as manic.  The two of you begin to disrobe quickly, until you're both wearing nothing but your birthday suits.");
 
	outputText("\n\nYou turn the dildo on yourself first, running the tip along your body as it begins to produce its marvelous arousing substance.  ");
	//(If PC has a cunt) 
	if(player.hasVagina()) outputText("You press the tip into your cunt quickly, giving it a taste of what is to come.  The brief contact is enough to make you shudder slightly with pleasure.  ");
	//(If PC has fuckable nipples) 
	if(player.hasFuckableNipples()) outputText("You let the dildo meander up your body until it reaches your breasts, and with a bit of a grin you insert the tip right into one nipple, enjoying the feeling of your breasts swell up with arousal.  You do the same with the other nipple, and take a minute going back and forth.  ");
	outputText("Finally you bring the dildo up to your mouth, licking the juices off of it, eagerly downing the goblin sex-drug.");
	
	//(Normal/Incubus Rubi)
	if(!rubiBimbo()) {
		outputText("\n\nRubi looks on in rapt silence, and you can tell he's eagerly waiting his turn.  You get on your hands and knees and crawl over him, pressing the dildo against his skin, letting the drug do its magic.  His skin flushes and he curls his spine impulsively.");
	}
	//(Bimbo Rubi) 
	else {
		outputText("\n\nRubi looks on in rapt silence, and you can tell she's eagerly waiting her turn.  You get on your hands and knees and crawl over her, pressing the dildo against her skin, letting the drug do its magic.  Her skin flushes and she curls her spine impulsively.");
	}
 	
	//(Normal/Incubus Rubi) 
	if(!rubiBimbo()) outputText("\n\nLoving the effects it has on Rubi, you take it slow, first letting him get a taste by pressing the tip against those luscious ruby red lips.  They part shakily and his tongue reaches out to taste the dildo.  He apparently finds it pleasing, because he immediately wraps his lips around the tip, sucking and bobbing on it like it was a real cock.");
	//(Bimbo Rubi) 
	else outputText("\n\nLoving the effects it has on Rubi, you take it slow, first letting her get a taste by pressing the tip against those luscious ruby red lips.  They easily part, and her tongue takes a long slurp, just to taste the dildo.  She apparently finds it pleasing, because she immediately wraps her lips around the tip, sucking and bobbing on it like it was a real cock.");
	
	outputText("\n\nYou actually have to yank it out of Rubi's mouth, and tell " + rubiMF("him","her") + " that there's one way you can both get a little pleasure out of this.  You urge Rubi to lie down, and you reach down, pressing the tip of the dildo ");
	if(!rubiBimbo()) outputText("against his tight ass");
	else outputText("against her tight pussy");
	outputText(", which resists a little at first, but once the drug has a moment to work, it slips right in.  Rubi actually coos a little as it slips inside.");
	
	outputText("\n\nYou also lie down, and align the other end with your [vagOrAss], and slip it inside.  Warmth radiates outwards as the drug takes full effect, your whole body becoming aroused.");
	//(If player has pussy) 
	if(player.hasVagina()) outputText("  Your " + clitDescript() + " stiffens, aching for attention.  It peeks from your folds like a shy little lewd faerie.");
	//(If player has a cock)
	if(player.hasCock()) outputText("  Meanwhile, [eachCock] stiffens, throbbing as the drug overtakes it.");
	if(player.lactationQ() > 0) outputText("  As the warmth spreads up your body, not even your breasts are left alone.  Your nipples harden and begin leaking milk, which pours down the sides of your body and is soaked up into the cushions beneath you.");
	//(Virginity/stretch check!)
	cuntChange(30,true,true,false);
	
	outputText("\n\nYou let the dildo inch further inside the both of you as you wiggle your way closer to Rubi.  Your little demon partner \"<i>oohs</i>\" and \"<i>aahs</i>\" with every little movement.  You feel the thickness of the toy increasing as more of your bodily juices seep into it.  Wanting a little extra, you reach down and grab the middle of the toy, rocking it back and forth, fucking both you and Rubi at the same time.");
	
	outputText("\n\nYour body shudders as the warmth grows warmer.  Your body feels so hot, like it's on fire and the only way to quench that fire is orgasm.  Rubi is clutching at pillows, rocking " + rubiMF("himself","herself") + " on the fake pink dong, which only adds fuel to your fire.");
	//(Orgasm Denial on?)
	if(flags[RUBI_ORGASM_DENIAL] > 0) outputText("\n\nIn a sudden moment of clarity, you raise your head and look straight at Rubi, shouting that " + rubiMF("he","she") + "'d better not cum during all this, or else you'll be quite upset.  " + rubiMF("His","Her") + " eyes go wide, \"<i>W—What?  I need to cum, " + player.mf("sir","miss") + "!  My body, it's so hot!</i>\"  You growl that it's expressly forbidden, and that " + rubiMF("he","she") + "'d better learn to control " + rubiMF("him","her") + "self, or else.");
	//(Normal/Incubus Rubi, Orgasm Denial off) 
	else if(!rubiBimbo()) {
		outputText("\n\nHis body shudders and convulses, and his ");
		if(!rubiIncubus()) outputText("little cock");
		else outputText("demonic cock");
		outputText(" twitches, launching jets of cum onto his stomach, chest and face.  In his sex-filled stupor, he eagerly swallows down whatever lands in his mouth, and actually uses his fingers to collect the rest , gulping that down as well.");
	}
	//(Bimbo Rubi)
	else {
		outputText("\n\nHer body shudders and convulses, and though you can't see or feel it, you're confident her pussy is clenching down tightly on the dildo, as it suddenly becomes very hard to thrust into her with it.  With an orgasmic scream of \"<i>Oh yes!  Yes!</i>\"  and a spray of femjuices, Rubi collapses, exhausted.");
	}
	
	outputText("\n\nBut you're not done yet.  You frantically pump the dildo faster and faster.  You can feel something welling up inside you, something to quench the flames burning throughout your body.  Soon the double dong between you grows too big to properly thrust, so in desperation your hands move towards ");
	//(PC has cock?) 
	if(player.hasCock()) outputText("[eachCock], stroking it fervently, in desperate need of release.");
	//(PC doesn't have cock, but has pussy?) 
	else if(player.hasVagina()) outputText("your " + clitDescript() + ", rubbing it frantically, in desperate need of release.");
	//(PC doesn't have either, but breasts above A-cup?)
	else outputText("your [chest], rubbing your nipples vigorously, in desperate need of release.");
	//(Bonus, fuckable nipples?) 
	if(player.hasFuckableNipples()) outputText("  You fingers easily slip inside each nipple, pumping in and out like little cocks.");
	//(No cock, no pussy, no breasts?) 
	if(player.gender == 0 && player.biggestTitSize() == 0) outputText("  Your hands roam all along your body, from your bare crotch to your nipples, even through your hair, all in search of something to give you the release you so desperately crave.");
	
	outputText("\n\nFinally, mercifully, the orgasm welling up inside you rolls over you like a tidal wave, quenching the fires of lust that burned within.  Your lips contort into an \"<i>O</i>\" and a long groan escapes your lips.");
	//(PC has cock?)
	if(player.hasCock()) {
		outputText("  [EachCock] twitches and shudders, loosing several jets of cum onto your body, ");
		if(player.cumQ() < 250) outputText("splattering messily");
		else if(player.cumQ() < 500) outputText("coating you lightly");
		else if(player.cumQ() < 1000) outputText("covering you in a copious layer of cum");
		else outputText("covering you in a thick layer of your potent seed");
		outputText(".");
	}
	//(PC has pussy?) 
	if(player.hasVagina()) outputText("  Your " + vaginaDescript(0) + " clenches down on the enormous invader, which at this point feels like an enormous steel rod lodged firmly inside you, and a spray of fem-juices erupts from your nethers, coating the already slick dildo and Rubi.");
	//(PC lactating?) 
	if(player.lactationQ() > 0) outputText("  Your breasts shudder and quake as the orgasmic tsunami washes over them, spraying your sweet smelling milk all over yourself, Rubi and the couch.");
	
	outputText("\n\nAbsolutely exhausted, you lay there limply, as does Rubi, as if you're both afraid to move and potentially awaken the monstrous dildo again.  With a satisfied sigh, however, you sit up and carefully pull out the shrinking dildo from the both of you.  A pink, cum-like liquid pours from both of your abused holes, pooling together into one puddle between you.");
	
	outputText("\n\nRubi rubs " + rubiMF("his asshole","her pussy") + " with a slight smile on " + rubiMF("his","her") + " face, and says, \"<i>Well, that was interesting.</i>\"  You laugh at the understatement of the century, and stand, helping Rubi up off the couch as well.");
	
	outputText("\n\nThe two of you head to the bathroom, leaking pink cum as you go, and share a quick shower, before getting to the task of cleaning up the evidence of your playtime.  Once it's been satisfactorily cleaned, you give Rubi a little kiss and head off back to camp, supremely sated.");
	stats(0,0,0,0,0,0,-100,0);
	rubiAffection(1);
	if(flags[RUBI_ORGASM_DENIAL] > 0) flags[RUBI_BLU_BALLS] += 2;
	doNext(13);
}

//Tease
function teaseRubi():void {
	clearOutput();
	//(Normal and Incubus Rubi.  Activates Orgasm Denial and adds 1 to Blue Balls.)
	flags[RUBI_ORGASM_DENIAL] = 1;
	if(!rubiBimbo()) {
		outputText("Having something quite different in mind, you order Rubi to strip down.  With a curious look on his face, he does so, slowly.  Each garment he peels from his soft ");
		if(!rubiIncubus()) outputText("pale");
		else outputText("red");
		outputText(" skin seems to take an eternity, until finally he's standing in front of you in naught but his panties.");
		outputText("  His ");
		if(!rubiIncubus()) outputText("tiny pecker");
		else outputText("demonic rod");
		outputText(" seems to strain at the panties, aching to be let free.  Standing, you move behind Rubi and sensually whisper into his ear, nibbling and kissing his neck between words.  You tell him that, until you specify otherwise, he is not to cum under any circumstances.  If he does, he'll be severely punished.  Rubi visibly gulps and nods his assent.");
		
		//(Taller than 5') 
		if(player.tallness > 60) outputText("\n\nYou smile and let your hands drape over Rubi's shoulders, letting your fingers trace invisible lines all along his tender chest and stomach.  One hand casually takes hold of a nipple, while the other drifts downwards, grasping the growing bulge in his panties.");
		//(Under 5')
		else outputText("\n\nYou smile and wrap your arms around Rubi's midsection, letting your fingers trace invisible lines all along his tender chest and stomach.  One hand casually reaches up and takes hold of a nipple, while the other drifts downwards, grasping at the growing bulge in his panties.");
		
		//(Normal Rubi) 
		if(!rubiIncubus()) outputText("\n\n\"<i>Ahh, not there,</i>\" Rubi gasps.  Your hand grips him tight, making him give a little yelp.");
		//(Incubus Rubi) 
		else outputText("\n\n\"<i>Ooh, right there,</i>\" Rubi gasps.  Your hand grips him tight, making him shiver a little with pleasure.");
		
		outputText("\n\nYou kneel down behind your little demon toy, and make him bend over so that his hands rest on the couch.");
		//(Normal Rubi)
		if(!rubiIncubus()) outputText("  He blushes, looking back at you with a curious expression.  He gulps and lifts his tail, giving you free access to his pantied rump.");
		else outputText("  He smiles, looking back at you with an expression of lust.  He lifts his tail, giving you free access to his pantied rump.");
		outputText("\n\nGrasping his panties firmly you shimmy them down until they're at his ankles.  He steps out of them, and, a moment after the thought crosses your mind, immediately shove them into Rubi's mouth.  He mumbles his objections, but doesn't remove them.");
		
		outputText("\n\nWith Rubi's bare ass laid out in front of you, it takes all your willpower not to just bury your face in it.  But you stand fast, and take care to remember your plans.  Instead, you wrap your fingers carefully around his stiffening manhood.  You grip it tight, feeling his pulse run through it.  With slow, steady movements you begin to stroke.");
		outputText("\n\n\"<i>Nnng,</i>\" Rubi grunts, gripping the couch cushions.  You make sure to remind him he can't cum under any circumstances.  He nods, and says, \"<i>Y—Yes " + player.mf("sir","miss") + ".</i>\"");
		
		outputText("\n\nSlightly quickening the pace of your strokes, you also lean in, resting your nose right against Rubi's tail, with your lips against his tight butthole.  You let your tongue out, letting it run circles around his ring.  You pull away, marveling at how the saliva makes his puckering hole look like a jewel in the rough.");
		
		outputText("\n\nAllowing a devious smile to cross your face, you extend two fingers and place them at Rubi's now wet entrance and slide them in.  A look of surprise briefly flashes over his face, but it's replaced by a satisfied smile.  You curve your fingers down, searching for his prostate.  He suddenly jerks and his dick stiffens even more in your hand, and you know you've found it.  Your fingers rub little circles in it, Rubi squirming with every loop.");
		
		outputText("\n\n\"<i>Aah, " + player.mf("sir","miss") + ", I can't take much more of this,</i>\" he says, half way between a whisper and a moan.");
		
		outputText("\n\nYou give his cock a squeeze and remind him that if he cums, he's in for a punishment.  He gulps and nods, closing his eyes.  His whole body seems to stiffen.  He's right, he really can't take much more of this.  You take this cue to pull your fingers out and relinquish your hold on Rubi's penis.  He sighs and almost collapses onto the couch.");
		outputText("\n\nYou lick your fingers clean of his pre-cum and kiss him, letting him taste his own juices.  Then you tell him that he's not to masturbate in any way until you allow him his release.");
		
		outputText("\n\nWith your devious fun accomplished, you stand, make yourself look presentable, and head out the door.  Your last sight of Rubi is that of him sitting on the couch with a pitiful look on his face as he eyes his raging erection.");
		if(flags[RUBI_ORGASM_DENIAL] > 0) flags[RUBI_BLU_BALLS]++;
	}
	//(Bimbo Rubi.  Doesn't activate Orgasm Denial (Controlling a Bimbo's Orgasms?!  Good luck!))
	else {
		outputText("\n\nHaving something quite different in mind, you order Rubi to strip down.  With a curious look on her face, she does so, eagerly.  Each garment she peels from her soft pale skin seems to take an eternity.  In fact, she seems to take great delight in stripping, giving little twirls and tossing her clothes towards you, until she's standing in front of you in naught but her birthday suit.");
		outputText("\n\nHer snatch glistens with arousal, which doesn't surprise you.  She seems to be horny 24/7 nowadays.  Standing, you move behind Rubi and sensually whisper into her ear, nibbling and kissing between words.  You tell her that, until you specify otherwise, she is not to cum under any circumstances.  And if she does, there will be serious consequences.  She giggles, but nods her assent.");
		//(Taller than 5') 
		if(player.tallness > 60) outputText("\n\nYou smile and let your hands drape over Rubi's shoulders, letting your fingers trace invisible lines all along her supple breasts and stomach.  One hand casually takes hold of a nipple, while the other drifts downwards, slipping into her soft, delicate folds.");
		//(Under 5') 
		else outputText("\n\nYou smile and wrap your arms around Rubi's midsection, letting your fingers trace invisible lines all along her supple chest and stomach.  One hand casually reaches up and takes hold of a nipple, while the other drifts downwards, slipping into her soft, delicate folds.");
		outputText("  \"<i>Ooh, YES, right there,</i>\" Rubi gasps.  Your hand pinches her clit tight, eliciting a yelp and a coo of pleasure at the same time.");
		
		outputText("\n\nYou kneel down behind your little demoness and make her bend over so that her hands rest on the couch.  She looks back at you, hair wild like she's already been fucked several times, giving you such a look of lust that you find yourself getting turned on almost as much as she is.  She lifts her tail, giving you free access to her rump and cunt, and then waggles it in your face, like someone taunting a pet dog.  You raise a hand and bring it down onto her pale ass with a SMACK, letting her know just who the pet is in this situation, and smirk at her.");
		
		outputText("\n\nWith Rubi's bare ass laid out in front of you, it takes all your willpower not to just bury your face in that delicious wet pussy.  But you stand fast, and take care to remember your plans.  Instead, you insert your thumb up into her hungry cunt, with your index and middle fingers on either side of her clit, rubbing it with slow, steady movements.");
		
		outputText("\n\n\"<i>Nnng,</i>\" Rubi moans, gripping the couch cushions.  You make sure to remind her that she can't cum under any circumstances, but before you get through the sentence, her pussy grips your thumb tightly and a spray of fem-juices erupts, coating your hand and face.  Well, so much for that plan.  You guess trying to control the orgasms of a girl this sensitive is pretty much impossible.  But you can still tease her.");
		
		outputText("\n\nSlightly quickening the pace of your fingers, you also lean in, resting your nose right against Rubi's tail hole, with your lips against her muff.  You let your tongue out, letting it run rampant across her netherlips, around your finger.  You pull away and lick your lips, marveling at the taste.");
		
		outputText("\n\nAllowing a devious smile to cross your face, you pull your free hand into a conical shape and press it into Rubi's drenched cunt.  A look of bliss crosses her face, and you're quite certain her eyes rolled back into her head.  You curl your fingers together, forming a fist, and pulse it back and forth inside her.  Meanwhile, you pull out the thumb of your other hand and put it to work on Rubi's love button, tweaking, rubbing and tormenting it mercilessly.");
		
		outputText("\n\n\"<i>Ohh gods,</i>\" Rubi says, half way between a whisper and a moan, \"<i>I'm gonna... I'm gonna like, cum!</i>\"");
		
		outputText("\n\nYou push your fist in as far as it will go as Rubi's legs tremble and almost give out on her.  An earth-shattering scream erupts from her lips as another jet of femjuices spray out, dousing you again.  Rubi slumps forwards onto the couch, her vaginal muscles nearly taking you with her.  But you manage to pull your fist out before falling over with her.");
		outputText("\n\nYou slowly lick your fingers clean and kiss her, letting her taste her own juices.  She giggles and licks your face clean as well, until not a drop remains.");
		outputText("\n\nWith your devious fun accomplished, you stand, make yourself look presentable, and head out the door.  Your last sight of Rubi is that of her sitting spread eagle on the couch with a supremely satisfied look on her face.");
	}
	stats(0,0,0,0,0,0,5+player.lib/10,0);
	doNext(13);
}
 
//Release
function releaseRubi():void {
	clearOutput();
	//Will deactivate Orgasm Denial.  To start Denying again, the PC will have to Tease.
	flags[RUBI_ORGASM_DENIAL] = 0;
	outputText("You order Rubi to strip down.  Knowing the drill, he does so slowly.  There's no striptease, no show, he just disrobes as quickly as possible until he's standing in naught but his panties.  ");
	if(!rubiIncubus()) outputText("His little penis strains at the fabric, feebly trying to escape.");
	else outputText("His demonic cock strains at the fabric, the dark red tip protruding from the band at the top.");
	
	outputText("\n\nKneeling in front of him, you grip both sides of his undies and strip them off yourself, revealing his rock-hard cock.");
	//(If Blueballs 1-3) 
	if(flags[RUBI_BLU_BALLS] <= 3) outputText("  Not to mention his tiny balls, which you think have swelled somewhat, although you haven't been teasing him long.");
	//(if Blueballs 4-9) 
	else if(flags[RUBI_BLU_BALLS] <= 9) outputText("  Not to mention his sizeable balls, which seem to have swelled up to twice their normal size, thanks to your relentless teasing.  They even have a slight bluish tinge to them, although it's not immediately visible.");
	else outputText("  Not to mention his enormous balls, which, thanks to your endless teasing, are seemingly the size of baseballs.  They even have a noticeable blue tinge to them, obviously aching for relief.");
	
	outputText("\n\nYou direct him to sit on the nearby coffee table, and he does so.  Wrapping your fingers around his member, you begin to stroke it slowly, reminding him that he can't cum.  He whimpers but nods.  You can tell he's fighting his body every step of the way, eager for the release that only your command can bring.");
	
	outputText("\n\nBut that's not going to happen yet.  You've still got a lot of work to do.  Without removing your grip on him, you push him back so that he's lying on the table, his legs dangling off the end.  You take two fingers, collect some pre-cum that's dribbling down his cock and your hand, and massage it into the tight little tailhole behind his ");
	if(flags[RUBI_BLU_BALLS] <= 3) outputText("swollen");
	else if(flags[RUBI_BLU_BALLS] <= 9) outputText("slightly blue");
	else outputText("incredibly swollen blue");
	outputText(" balls.  Once it's properly lubed up, you press two fingers inside.");
	
	outputText("\n\nRubi's face contorts briefly into an expression of surprise, which quickly morphs into lust.  He pants loudly, tongue out.  Behind the ever growing lust present in his face, however, you see supreme concentration.  No matter what, he's determined not to let you down.  If you told him he couldn't cum ever again, you're certain he'd take it to heart and he'd never let it happen.  Good thing for him you're not THAT cruel.");
	
	outputText("\n\nYour fingers worm around inside him, searching for the P-spot.  When Rubi jerks and wiggles involuntarily, you know you've found it.  Pre-cum begins leaking from Rubi's ");
	if(!rubiIncubus()) outputText("tiny");
	else outputText("demonic");
	outputText(" cock in copious amounts, running down your hand and arms, and forming a puddle on the coffee table.  Rubi's body trembles and shakes, wriggling on the table like a fish out of water.");
 
 	outputText("\n\nFeeling a little more adventurous, you slip a third finger into the little demon boy's rectum.  With all three fingers you press and massage his prostate, increasing the amount of pre-cum flowing from his ");
	if(!rubiIncubus()) outputText("pink");
	else outputText("dark red");
	outputText(" tip.");
 	outputText("\n\nFinally, you think you've had enough.  You retrieve your fingers from his ass and cup his balls instead, squeezing them until Rubi squeaks in discomfort.  You pump his cock faster, and order him to cum, squeezing his balls with every word.");
	outputText("\n\nRelief crosses Rubi's face, followed by arousal.  He's been waiting for this moment for a long time.  You give his balls another squeeze and his lips form a tight O as a rope of cum lances outwards, flying up before splattering onto his chest.");
	//(Blueballs 1-3) 
	if(flags[RUBI_BLU_BALLS] <= 3) outputText("  It's quickly followed by another, less forceful jet of pearly white cum, which lands on his face, and several even smaller jets which splatter the area around him.  His cock twitches and spasms, then slowly softens.");
	//(Blueballs 4-5) 
	else if(flags[RUBI_BLU_BALLS] <= 5) outputText("  It's quickly followed by another, less forceful jet of pearly white cum, then another, and another, each landing closer to his face.  Finally, it gives a few more token jerks, spurting out tiny globules of cum onto the surrounding area.  His cock twitches and spasms, squirting nothing but air, as if his body is still craving release.");
	//(Blueballs 6-7) 
	else if(flags[RUBI_BLU_BALLS] <= 7) outputText("  It's quickly followed by another, more forceful jet of pearly white cum which splatters against the ceiling, dripping down onto the both of you.  Another spurt of cum bursts forth, then another, and another, each one liberally covering Rubi's stomach, chest and face.  His cock finally gives a few last twitches and spasms, squirting nothing but air, as if his body is still craving release.");
	//(Blueballs 8-9) 
	else if(flags[RUBI_BLU_BALLS] <= 9) outputText("  It's quickly followed by another, more forceful jet of pearly white cum, which splatters against the ceiling, dripping down onto the both of you, and then another, and another.  It isn't long before the ceiling has a huge white cum-covered blotch right above you, drizzling down on you like dew dripping from trees.  Rubi's cock doesn't stop there, however, it continues twitching and spurting his seed until he is completely covered in the stuff.  Finally, mercifully, it ends, though his cock continues to spasm, squirting nothing but air, as if his body is still craving release.");
	//(Blueballs 10+) 
	else outputText("  It's quickly followed by another, more powerful jet of pearly white cum, which splatters against the ceiling, dripping down onto the both of you, and then another, and another.  It isn't long before the ceiling has a huge white cum-covered blotch right above you, drizzling down on you like dew dripping from the trees.  Rubi's cock doesn't stop there, however, it continues twitching and spurting his seed, liberally covering himself, you and the surrounding area until everything appears to be in a white haze.");
	
	outputText("\n\nRubi's body visibly relaxes and his limbs go limp, along with his cock, albeit more slowly.  You lick your hands clean and give Rubi a sloppy smooch, to which he coos thankfully.  The release he so desired achieved, he drifts off into an orgasm-induced dream.");
	
	outputText("\n\nYou stand and decide to let him sleep.  ");
	//(Blueballs 1-5) 
	if(flags[RUBI_BLU_BALLS] <= 5) outputText("You clean yourself up, leave Rubi a little \"<i>See you next time</i>\" note, and head out the door, back to camp.");
	//(Blueballs 6-9) 
	else if(flags[RUBI_BLU_BALLS] <= 9) outputText("You head into the bathroom and wash the cum off you, taking a short shower.  Afterwards, you dry up, leave Rubi a little \"<i>See you next time</i>\" note, and head out the door, back to camp.");
	//(Blueballs 10+) 
	else outputText("You head into the bathroom and wash the cum off you, no easy feat to be sure.  Afterwards, you dry up, leave Rubi a little \"<i>See you next time</i>\" note, and head out the door, back to camp.  You certainly don't want to be there when he wakes up, lest you have to clean the entire house with him.");
	rubiAffection(flags[RUBI_BLU_BALLS]);
	flags[RUBI_BLU_BALLS] = 0;
	flags[RUBI_ORGASM_DENIAL] = 0;
	doNext(13);
}
	
//Give Item.
function giveRubiAHamSandwichDontTellLottie():void {
	clearOutput();
	var closet:Array = new Array();
	var gifts:Array = new Array();
	if(flags[RUBI_SUITCLOTHES] == 1) closet[closet.length] = "Suitclothes";
	else gifts[gifts.length] = "Suitclothes";
	if(flags[RUBI_FETISH_CLOTHES] == 1) closet[closet.length] = "Rubber Fetish Clothes";
	else gifts[gifts.length] = "Rubber Fetish Clothes";
	if(flags[RUBI_GREEN_ADVENTURER] == 1) closet[closet.length] = "A Green Adventurer's Outfit";
	else gifts[gifts.length] = "Green Adventurer's Outfit";
	if(flags[RUBI_TUBE_TOP] == 1) closet[closet.length] = "A Tube Top";
	else gifts[gifts.length] = "A Tube Top";
	if(flags[RUBI_BODYSUIT] == 1) closet[closet.length] = "A Sheer Bodysuit";
	else gifts[gifts.length] = "A Sheer Bodysuit";
	if(flags[RUBI_LONGDRESS] == 1) closet[closet.length] = "A Long Dress";
	else gifts[gifts.length] = "A Long Dress";
	if(flags[RUBI_TIGHT_PANTS] == 1) closet[closet.length] = "A Dashing Outfit With Tight Leather Pants";
	else gifts[gifts.length] = "A Dashing Outfit With Tight Leather Pants";
	if(flags[RUBI_NURSE_CLOTHES] == 1) closet[closet.length] = "Nurse's Clothes";
	else gifts[gifts.length] = "Nurse's Clothes";
	//(Slutty Swimwear (Normal))
	if(flags[RUBI_SWIMWEAR] == 1) closet[closet.length] = "Slutty Swimwear";
	else gifts[gifts.length] = "Slutty Swimwear";
	if(flags[RUBI_BIMBO_MINIDRESS] == 1) closet[closet.length] = "A Bimbo Minidress";
	if(closet.length > 0) {
		outputText("<b>Rubi's Closet:</b>\n");
		temp = 0;
		while(temp < closet.length) {
			outputText(closet[temp] + "\n");
			temp++;
		}
		outputText("\n");
	}
	if(gifts.length > 0) {
		outputText("After a quick glance around Rubi's things, you bet " + rubiMF("he","she") + " could really use... " + gifts[rand(gifts.length)] + ".\n\n");
	}
	else {
		outputText("You've given Rubi all the clothes " + rubiMF("he","she") + " would want to make use of.");
		if(silly()) outputText("  (Achievement Unlocked: Dress-tacular)");
		outputText("\n\n");
	}
	if(!rubiBimbo() && !rubiIncubus() && rubiAffection() >= 100) {
		outputText("You could give Rubi some incubi draft to make him a little more manly but corrupt, or you could give Rubi a Bimbo Draft to turn him into a smoking hot, female sex-bomb.");
	}
	outputText("What will you give " + rubiMF("him","her") + "?");
	//The following items can be given to Rubi at Relationship 20+: Suit Clothes, Rubber Fetish Outfit, Green Adventurer's Clothing, Tube Top, Bodysuit, Long Dress, Tight Leather Pants, Nurse Clothes, Slutty Swimwear.  Only once per item.
	//The following items can be given to Rubi at Relationship 40+: Bimbo Liqueur (once), Incubus Draft (up to three times).  Incubus Rubi can't be given Bimbo Liqueur, and likewise Bimbo Rubi can't be given Incubus Draft.
	var events:Array = new Array();
	if(hasItem("ClssyCl",1) && flags[RUBI_SUITCLOTHES] == 0) events[events.length] = 3879;
	trace("EVENTS: " + events.length);
	if(hasItem("RbbrClt",1) && flags[RUBI_FETISH_CLOTHES] == 0) events[events.length] = 3880;
	trace("EVENTS: " + events.length);
	if(hasItem("AdvClth",1) && flags[RUBI_GREEN_ADVENTURER] == 0) events[events.length] = 3881;
	trace("EVENTS: " + events.length);
	if(hasItem("TubeTop",1) && flags[RUBI_TUBE_TOP] == 0) events[events.length] = 3882;
	trace("EVENTS: " + events.length);
	if(hasItem("T.BSuit",1) && flags[RUBI_BODYSUIT] == 0) events[events.length] = 3883;
	trace("EVENTS: " + events.length);
	if(hasItem("B.Dress",1) && flags[RUBI_LONGDRESS] == 0) events[events.length] = 3884;
	trace("EVENTS: " + events.length);
	if(hasItem("LthrPnt",1) && flags[RUBI_TIGHT_PANTS] == 0) events[events.length] = 3885;
	trace("EVENTS: " + events.length);
	if(hasItem("NurseCl",1) && flags[RUBI_NURSE_CLOTHES] == 0) events[events.length] = 3886;
	trace("EVENTS: " + events.length);
	if(hasItem("S.Swmwr",1) && flags[RUBI_SWIMWEAR] == 0) events[events.length] = 3887;
	trace("EVENTS: " + events.length);
	
	if(hasItem("BimboLq",1) && !rubiBimbo() && !rubiIncubus()) events[events.length] = 3888;
	if(hasItem("IncubiD",1) && !rubiBimbo() && !rubiIncubus()) events[events.length] = 3889;
	while(events.length < 10) {
		events[events.length] = 0;
	}
	var eventNames:Array = new Array();
	temp = 0;
	while(temp < 10) {
		if(events[temp] == 3879) eventNames[eventNames.length] = "Suitclothes";
		else if(events[temp] == 3880) eventNames[eventNames.length] = "Rubberclothes";
		else if(events[temp] == 3881) eventNames[eventNames.length] = "Green Clothes";
		else if(events[temp] == 3882) eventNames[eventNames.length] = "Tube Top";
		else if(events[temp] == 3883) eventNames[eventNames.length] = "Bodysuit";
		else if(events[temp] == 3884) eventNames[eventNames.length] = "Long Dress";
		else if(events[temp] == 3885) eventNames[eventNames.length] = "Leather Pants";
		else if(events[temp] == 3886) eventNames[eventNames.length] = "Nurse Clothes";
		else if(events[temp] == 3887) eventNames[eventNames.length] = "SluttySwim";
		else if(events[temp] == 3888) eventNames[eventNames.length] = "Bimbo Liq";
		else if(events[temp] == 3889) eventNames[eventNames.length] = "Incubi Draft";
		else eventNames[eventNames.length] = "FUCKIN TRAP";
		temp++;
	}
	trace(eventNames.length + " " + events.length);
	choices(eventNames[0],events[0],eventNames[1],events[1],eventNames[2],events[2],eventNames[3],events[3],eventNames[4],events[4],eventNames[5],events[5],eventNames[6],events[6],eventNames[7],events[7],eventNames[8],events[8],"Back",3898);
}
	
//(Give Clothes)
function giveRubiClothes(short:String = ""):void {
	clearOutput();
	outputText("You hand over the spare set of clothes, and Rubi's eyes light up.  \"<i>For me?</i>\"  the little demon practically screams, ecstatic.  \"<i>ThankyouthankyouthankyouTHANKYOU!</i>\"");
	outputText("\n\nRubi holds the outfit up to " + rubiMF("his","her") + " body and grins, \"<i>Ooooh, I just love it!  I mean, I'll have to take it to the tailors to get fitted, but I absolutely adore it!</i>\"");
	outputText("\n\nYou wonder how " + rubiMF("he","she") + " could get so excited over it, after all it's just clothes, but you smile and nod along, happy to make " + rubiMF("him","her") + " happy.");
	consumeItem(short,1);
	if(short == "ClssyCl") flags[RUBI_SUITCLOTHES] = 1;
	else if(short == "RbbrClt") flags[RUBI_FETISH_CLOTHES] = 1;
	else if(short == "AdvClth") flags[RUBI_GREEN_ADVENTURER] = 1;
	else if(short == "TubeTop") flags[RUBI_TUBE_TOP] = 1;
	else if(short == "T.BSuit") flags[RUBI_BODYSUIT] = 1;
	else if(short == "B.Dress") flags[RUBI_LONGDRESS] = 1;
	else if(short == "LthrPnt") flags[RUBI_TIGHT_PANTS] = 1;
	else if(short == "NurseCl") flags[RUBI_NURSE_CLOTHES] = 1;
	else if(short == "S.Swmwr") flags[RUBI_SWIMWEAR] = 1;
	rubiAffection(20);
	doNext(3898);
}
 
//(Give Bimbo Liqueur)
function giveRubiBimboLiquer():void {
	clearOutput();
	outputText("You hold out the bottle of Bimbo Liqueur.  Rubi takes it, and looks it over tentatively.  \"<i>Bimbo... liqueur?</i>\"  he asks, quirking an eyebrow at you.");
	outputText("\n\nYou tell him how you acquired it in your journeys, a tale which he listens with rapt fascination.  Eventually you have to go over your entire adventure, just to sate his curiosity.  But when you finish, he looks at you with admiration.");
	outputText("\n\n\"<i>Wow,</i>\" he says, before turning his attention back to the bottle.  \"<i>But what does this actually do?  There's a huge warning label right here.  Effects are permanent, strong...</i>\" his voice drifts off as he reads.");
	outputText("\n\nYou explain that this liqueur will give him the fresh start he so desired when he came to Tel'Adre.  That before he was simply wearing a mask, now he can become the mask.  He nods along with you, but still frowns.");
	outputText("\n\n\"<i>Are you sure?  I'm fine with my body how it is... but if you want me to change, I'll do it,</i>\" he says, clutching the bottle tight, suddenly looking very serious.");
	outputText("\n\nYou nod, and tell him this is exactly what you want.");
	outputText("\n\n\"<i>If it's what you want, then it's what I want, babe,</i>\" he takes a deep breath, opens the bottle and closes his eyes.  In one swift motion, he puts the bottle to his lip and downs its contents.");
	outputText("\n\nIt takes a moment for the effects, to hit, but once they do, they come in rapid succession.  Rubi doubles over, clutching his stomach in pain.  He rips open his blouse to see the changes with his own eyes.  Bones crack, shift and wobble as Rubi's waist shrinks and his hips grow outwards.  His entire body seems to shrink before your eyes, growing more slender.  His normally short black hair suddenly bursts outwards, long platinum blonde locks flowing past his shoulders like a waterfall.  His already dainty hands grow more feminine, as do his feet.");
	outputText("\n\nWith a wide eyed moment of trepidation, Rubi clutches at his crotch, lifting his skirt to reveal a bare mound in his panties where his cock used to be.  It's pretty clear, he is now a she.  Rubi collapses backwards onto the couch, the transformations seemingly done.");
	outputText("\n\n\"<i>Like, oh.  My.  Gods.  That was so wild,</i>\" she says, and suddenly grips her throat.  \"<i>Whoa, like, my voice is different!</i>\"  Though he had a very feminine voice to begin with, it is noticeably more girly.  Not high pitched, just... girly.");
	outputText("\n\nShe looks down at her chest, and a look of disappointment crosses her face.  \"<i>Aww, I get this totally killer bod, but no tits?</i>\" she exclaims, visibly upset.");
	outputText("\n\nAs if on cue, the flesh around her nipples begins to bubble and then expand.  You swear you heard a WOOSHing sound, like someone is blowing up balloons.  She grips her chest, tearing off the bra, allowing you a better look at the changes.  Within seconds, Rubi has the chest of a pubescent girl, within a minute they're at least a B-cup.  You both sit with morbid curiosity, watching the flesh grow outwards, bit by bit.  After five minutes the growth stops, and Rubi carefully cradles her new enormous E-cup breasts.");
	outputText("\n\nThe silence is broken when Rubi shouts, \"<i>Oh fuck yes, this is more like it!</i>\"  She stands and dances what can only be called the titty-dance, squeezing one breast and then the other in quick succession to some tune that exists only in her head.");
 	outputText("\n\nSuddenly remembering you're here, she stops and gives you a great big hug, pressing her breasts against ");
	if(player.biggestTitSize() == 0) outputText("you");
	else outputText("yours");
	outputText(".  \"<i>Like, thank you so much baby!  You're the freaking best!  Now I just got to get used to these bad boys... wanna help?</i>\"");
	outputText("\n\nYou grin and oblige, happy to help.");
	outputText("\n\nAfter several more minutes of fondling, Rubi says she wants to get some self-exploration done, and ushers you out the door.  You frown, a little upset you don't get to participate in this, but you vow you'll be back to get your taste soon enough.");
	outputText("\n\nFantasies and plans developing in your mind, you head back to camp, a wicked grin forming on your face.");
	doNext(13);
	consumeItem("BimboLq",1);
	flags[RUBI_BIMBO] = 1;
}

function giveIncubusDraftRubi():void {
	clearOutput();
	//(Give Incubus Draft, First Time)
	if(flags[RUBI_INCUBUS_PROGRESS] == 0) {
		outputText("You hold out a bottle of Incubus Draft.  Rubi takes it, and looks it over tentatively.  \"<i>Huh?  What's this?  It looks familiar,</i>\" he says, quirking an eyebrow at you.");
		outputText("\n\nYou explain what it is, and tell him that it'll get him more in touch with his inner self.");
		outputText("\n\nA look of recognition crosses his face, \"<i>This is that incubus stuff, isn't it?  I had to drink some of this to survive outside Tel'Adre... why would you give me this?  Do you want me to become a full-fledged demon?</i>\"");
		outputText("\n\nTaking him by the shoulders, you explain that he'll only become a full demon if he takes too much and loses himself in it.  You say that you think he'd be able to control himself just fine, and that this is his chance to do what he wanted in Tel'Adre: start fresh.  That he's been wearing a mask here so long, this might be his chance to let his true face out.");
		outputText("\n\nHe gulps, looking unsure.  \"<i>Are you sure?  I'm fine with how my body is now... but if you want me to change, I'll do it,</i>\" he says, clutching the bottle tight, suddenly looking very serious.");
		outputText("\n\nYou nod, and tell him this is exactly what you want.");
		outputText("\n\n\"<i>If it's what you want, then it's what I want, baby,</i>\" he takes a deep breath, uncorks the bottle and closes his eyes.  In one swift motion, he puts the bottle to his lip and downs its contents.");
		outputText("\n\nNothing seems to happen at first, but then Rubi doubles over in pain, clutching his stomach.  He scrambles onto the couch, scrabbling at his feet, tearing his shoes off.  Once they're off, he stares in horror as a sharp bone-like horn erupts from the sole of his foot.  He curls up into a fetal position, clutching his legs for another minute before he sighs in relief, the changes apparently over.");
		outputText("\n\nHe stands uncertainly on his new feet, and looks surprised to find no problems.  They seem to make him stand like he would with high heels, and you notice it definitely makes his ass look more shapely.  He takes a few experimental steps across the room, and is soon striding around like he'd been wearing high heels all his life.");
		outputText("\n\n\"<i>I'm still kind of unsure about this,</i>\" he says, looking at his feet with no small amount of trepidation, \"<i>but I'll give it a go.</i>\"");
		outputText("\n\nYou smile happily, and take this as your cue to leave, to let him get more acquainted with his new feet.");
	}
	//(Incubus Draft, Second Time)
	else if(flags[RUBI_INCUBUS_PROGRESS] == 1) {
		outputText("You present Rubi with another Incubus Draft.  He takes it and gives you a half-smile, \"<i>I don't know about another draft.  I mean, don't get me wrong, I love my new feet,</i>\" he says, showing off his demonic high heels, \"<i>but what would another drink do?</i>\"");
		outputText("\n\nYou tell him that this is what you really want, and he nods.");
		outputText("\n\n\"<i>All right.  Down the hatch it goes!</i>\"  He closes his eyes, takes a breath, and downs the bottle.");
		outputText("\n\nAgain, it takes a moment for the changes to occur.  In preparation for the pain, Rubi sits on the couch, just in time, too, as he clutches his belly in pain.  Then his hands move to his head, as though he has a massive headache.  He feels around blindly trying to locate the source of the pain, and then you see it.");
		outputText("\n\nTwo small bulges appear on his forehead, just at the hairline.  They grow larger and larger until the skin splits cleanly open revealing shiny black bone.  Horns.  They grow up and backwards, forming light ridges.  They don't quite grow completely past his head, however, before the growth stops.  Rubi calms and stands.  His hands roam over every inch of his new bodyparts as he rushes to find a mirror.  You follow along, eager to see how he'll take to this.");
		outputText("\n\n\"<i>Wow, they actually look pretty damn good,</i>\" he says, admiring the look in the shiny silver above his bathroom sink.");
		outputText("\n\n\"<i>I tell you what, I'm growing pretty attached to this new look,</i>\" he says and laughs at the joke.  It takes you a moment for both of you to realize his eyes also changed, from his normal green to a deep purplish color.");
		outputText("\n\nYou smile happily, and head out the door and back to camp, letting him get more acquainted with his new head.");
	}
	//(Incubus Draft, Third and final time)
	else {
		outputText("You present Rubi with another Incubus Draft.  He doesn't even say anything, he just grins and snatches it from your hands.  Uncorking the bottle, he downs it in one fell swoop.");
		outputText("\n\nThis time, the changes don't take long at all.  Rubi clutches his belly, expecting pain, but this time, it doesn't happen.  Red blotches appear across his flesh, appearing first as dots, like chickenpox, but spreading  out quickly.  His skin rapidly changes color to red, matching the spade-tipped tail he received long ago.  When his hands change color, his fingernails suddenly shift, darkening until they become black, and then elongating and sharpening into claws.");
		outputText("\n\nFinally, Rubi scrabbles at his skirt, lifting it up and pulling his panties down just in time to see his normally small pecker quiver and shift, growing longer and thicker, as small hard nodules begin to appear along its length.  For a moment it's normal colored, and then the red blotches reach it, turning the whole thing a bright red color, with a deep crimson tip.  You have to admit, it looks delicious.");
		outputText("\n\n\"<i>Oh gods, this feels so GOOD,</i>\" he groans, his voice growing deeper and huskier.  Still feminine, but somehow sexier than before.");
		outputText("\n\nYou give him a good once over.  Red skin, demon tail, horns, claws, sexy organic high heels... he's the perfect little incubus.  Ready to trap whatever innocent little thing should come his way.  You grin, letting your imagination run wild.");
		outputText("\n\nAfter a moment, Rubi suddenly realizes you're still here, and ushers you out the door.  \"<i>I, uh, want to give this a test drive.  Come back later, sweetness, and you can too,</i>\" he purrs before shutting the door behind you.");
		outputText("\n\nYou frown, a little upset at getting kicked out like this.  But you swear to yourself you'll get your taste soon enough.");
	}
	consumeItem("IncubiD",1);
	flags[RUBI_INCUBUS_PROGRESS]++;
	doNext(13);
}

//Cheating Rubi
function cheatingRubi():void {
	clearOutput();
	//(Selecting the Rubi button at the Bakery while she's not there)
	outputText("You take a seat at a table, expectantly waiting for Rubi to slide into your lap...  but she never does.  You look around the place for her, but again, there's no sight of her.  You flag down Dia, the caninemorph waitress, who looks haggard, and inquire as to the location of her co-worker.");
	outputText("\n\nShe gives you an exasperated sigh and says, \"<i>I dunno, she took off again, like she does with you.  Some guy came in, she got all giggly, and they got out of here.  If you see her, let her know I'm taking all of today's tips again.</i>\"  With that she turns to service another table.");
	outputText("\n\nSo your bimboified slut is seeing someone else?  What will you do about this?");
	//[Find Her] [Don't Care]
	simpleChoices("Find Her",3905,"Don't Care",3904,"",0,"",0,"",0);
}

//(Don't Care)
function dontCareAboutNoCheatingRubis():void {
	clearOutput();
	outputText("You shrug your shoulders.  It's not really your problem, is it?  You're free to fuck who you choose, and so is she.");
	outputText("\n\nYou stand up and leave the bakery, deciding to wander around Tel'Adre a bit more.");
	//(Kicks PC back out to Tel'Adre; PC can still get the Cheating Rubi event)
	doNext(13);
}

//(Find Her)
function findBimboCheatster():void {
	clearOutput();
	outputText("You let out a disgruntled sigh.  Rubi's seeing someone else?!  Not on your watch!  You leave the bakery and make your way towards her neighborhood.  It doesn't take long, you've gone with her there enough times to memorize the path, even without her leading.");
	outputText("\n\nCreeping into her front yard, you make your way through the garden.  Where once fruits, vegetables and herbs grew are now flowers reflecting every color of the rainbow.  An odd sound makes you stop for a moment just to make sure you weren't caught.  You hear the sound again, and realize it's coming from an open window.  Sneaking forward, you peer inside for the source.");
	outputText("\n\nThere she is, Rubi, splayed out on the couch, naked with two fingers buried deep inside her pussy.  You shift around a bit, and see nearby her a tanned man in the process of taking off his shirt.  So, you got to them before they did anything.  Rubi moans, running a hand through her platinum blonde hair and staring at the tanned man.");
	outputText("\n\nYou could interrupt them before they go any further, or wait until it's over.");
	//[Interrupt] [Wait]
	simpleChoices("Interrupt",3906,"Watch n Wait",3907,"",0,"",0,"",0);
}
//(Interrupt)
function interruptTheNTRsYouCrazyFool():void {
	clearOutput();
	outputText("No one's sticking their dick in your ");
	if(silly()) outputText("waifu");
	else outputText("slut");
	outputText(" if you've got a say in it!  You get out of your hiding place, shout a word of warning and burst inside the vibrant pink house.");
	outputText("\n\nRubi jumps a little, and sits up, but her fingers remain buried deep in her snatch.  The man, on the other hand, turns around and looks you over appraisingly.  Not surprisingly, he's not human.  Though he has a human face, you see wolf-like ears perched on his head, and a fluffy white and grey tail extends from a hole in his trousers.  The wolfman scoffs dismissively, \"<i>Go on, get out of here.  I got things to see and people to do.</i>\"");
	
	//Strength 61+)
	if(player.str >= 61) outputText("\n\nAngered by this blow off, you take a swing at the man.  Catching him off guard, you send him to the ground with a loud THUMP.  He holds his head in his hands for a moment.  You nudge him in the stomach with a [foot] and tell him to get lost.  He grumbles, grabs his shirt and scampers away without looking back.");
	else {
		outputText("\n\nAngered by this blow off, you take a swing at the man.  Your punch lands square in the jaw and he stumbles back a step.  He looks at you in surprise for a second, and then laughs, \"<i>You got spunk, kid, but let me show you how a real man does it.</i>\"");
		//(Strength <61 and Speed <61)
		if(player.spe < 61) {
			outputText("\n\nThe wolfman brings a right hook in your direction, which you try to duck, but it ends up clipping you right in the jaw.  You go down like a sack of potatoes, your vision swimming.  As you struggle to get upright, you see Rubi get off the couch in a furious rage, throwing item after item at your assailant.  You can barely make out what they are, until a black equine-style dildo rolls past you.");
			outputText("\n\nThe wolfman shields himself and you hear, \"<i>All right, all right, I'm going!  Crazy bitch!</i>\"  as he runs out the door.  After you hear the door shut, you feel hands on your arm as Rubi helps you up onto the couch.  After a moment to collect yourself, your vision is back and you feel none the worse for wear.");
			//[Leads to Resolution]
		}
		//(Strength <61 and  Speed 60+)
		else {
			outputText("\n\nThe wolfman brings a right hook in your direction, but you easily dodge under it and sweep his legs while he's off balance.  He goes tumbling down like a sack of potatoes.  You grin and nudge him in the stomach, telling him to get lost.  He grumbles, grabs his shirt and scampers away without looking back.");
			
		}
	}
	//[Leads to Resolution]
	doNext(3908);
}

//(Wait)
function waitAndGetNTRedLikeTheBoyBitchYouAre():void {
	clearOutput();
	outputText("You decide to wait and see how this plays out.  The man fully disrobes and it's not at all surprising to you that he's not fully human.  A pair of wolf-like ears are perched upon his head, while a fluffy white and grey tail extends from his waist.  The wolfman opens his mouth to speak, but you can't hear what he says from out here.  Whatever it was, it certainly got Rubi's attention.");
	outputText("\n\nThe blonde airhead moves from her position on the couch and kneels in front of the wolfman, whose back is to you.  From what you can see, you're certain she's sucking his cock.  Arousal and a twinge of jealousy well up inside you, and you find yourself moving around the side of the house to find a better vantage point.");
	outputText("\n\nPeering in a new window, you see Rubi's glittering red lips wrapped around the wolfman's canine cock.  She slips up and down at a sensuously slow speed, her tongue darts out every few seconds almost as if it's taunting you.  Her head bobs with increasing speed, and you note that her fingers have descended to her nethers, which are unfortunately obscured by her legs from this angle.");
	outputText("\n\nAs you contemplate moving to another window, you see the wolfman speak.  Rubi relinquishes her lip locked grip on his cock and smiles.  You see she's giggling and laughing, and she crawls onto the couch on all fours, presenting herself to her canine compatriot, and inadvertently to you as well.  You can see her cunt is slick with juices, and her tail swishes from side to side in a hypnotizing, catlike fashion.  Saying the man has a wolfish grin would be a disservice as his grin stretches from ear to ear.  He climbs onto the couch on his knees behind your bimbo lover.  Curses, your view is ruined again!");
	outputText("\n\nMaking your way back to the front window with shaking knees, you see the wolfman's glistening red canine cock just slide right inside Rubi's eager hole.  Her mouth opens, and you can just imagine the low moan that rumbles out, since you've heard her make that noise on several occasions.  A small pang of jealousy arises within you that this man gives her the same reaction.  As Rubi's wolfish lover begins to assail this new territory, more \"<i>oohs</i>\" and \"<i>aahs</i>\" roll out of her mouth and into your imagination.  You're a little ashamed of yourself, but you have to admit this is turning you on.");
	if(!player.isTaur()) {
		outputText("\n\nAs the lovemaking continues, you find your hand descending into your [armor] to fondle ");
		if(player.hasVagina()) outputText("your " + vaginaDescript());
		else if(player.hasCock()) outputText("[eachCock]");
		outputText(".  ");
	}
	else outputText("\n\n");
	outputText("The two go on like this for five minutes, then ten, then fifteen.  Each position, you find, is more intriguing than the last.  ");
	if(silly()) outputText("They're even doing positions that aren't available in the game!  ");
	outputText("Half an hour later, Rubi and the wolfman sit exhausted on the couch, his seed pouring from each of her holes.");
	
	outputText("\n\nThe male grins at her, but to your surprise she only gives a polite little smile and says a few words.  The man looks a little taken aback, but begins re-dressing almost immediately.  As he's doing that, you move to a window around the side of the house, so as not to get caught by this fleeing stud.  A minute later, you see the wolfman exit the house and take off walking down the street, mumbling something like \"<i>insatiable bitch.</i>\"");
	outputText("\n\nWell, this is as good of a time as any to confront her...  You stand up, adjust your clothing, and walk inside as a naked Rubi cleans herself off with a moist towel.");
	outputText("\n\nShe spots you and lights up, \"<i>Oh baby!  Like, I didn't know you'd be coming by!</i>\"  She then seems to realize that she's stark naked, mostly covered in cum, and that you came in just seconds after her previous lover left.  \"<i>Oh.  Yeah.</i>\"");
	//[leads to Resolution]
	doNext(3908);
}

//(Resolution)
function NTRbimboBitchResolution():void {
	clearOutput();
	outputText("You look at Rubi and say that you're definitely going to have to talk about what just happened.");
	outputText("\n\nShe nods and sits, covering her naked body with one of the pastel pink cushions that lie around the place.  \"<i>Like, I know...  I really shouldn't have.  I love you baby, I really do.  But ever since...  this,</i>\" she removes the cushion for a second, motioning down at her bombshell of a body, \"<i>It's just...</i>\"  She bites her lip, deep in thought as she wracks her brain for the right words to say.");
	outputText("\n\n\"<i>I love this body, I love you for giving it to me... but it has needs, you know?  I get so hot thinking about you, thinking about others, I just can't con-, can't cont-, I can't stop myself.  That guy means nothing to me, I'd only just met him.  Like, I totally wish you were here for me all the time, you know?  We could take care of these...  urges,</i>\" she languishes over the word, \"<i>daily.  Or several times a day... but we can't.  You're the cha-, the cham-, the hero guy, and I'm just a waitress in this city.  Like, I totes can't keep you from your mission.</i>\"");
	outputText("\n\nShe watches your face for a moment, biting her ruby red lip again, then says, \"<i>Like, I'll totally try to con-, to stop myself if you want.  I've got more sexy fun time toys in here than a goblin's treasure room.  If you want me just to yourself, I'll for sure stick to it.  But if you felt otherwise...  I think it'd totally be easier to keep these urges under control with a real cock to suck or a pussy to lick.</i>\"");
	outputText("\n\nRubi hugs the cushion close, apparently done with her speech.  So how do you react?");
	outputText("\n\nYou could tell her no, forbidding her to see anyone else.  Or you could say yes, letting her sleep with anyone.  You could always break up with her.  Or there might be a fourth option...");
	//[No] [Yes] [Break Up] [Pimp]
	simpleChoices("No",3909,"Yes",3910,"Break Up",3911,"Pimp",3912,"",0);
}

//(No)
function noBimboNTR():void {
	clearOutput();
	outputText("Folding your arms, you shake your head.  You tell her that if this is going to work out, she has to remain faithful to you.  Sex toys and masturbation will have to do to keep her \"<i>urges</i>\" under control.  She looks a little sad, but nods as you speak.");
	outputText("\n\n\"<i>Of course, baby.  Whatever you say,</i>\" then she giggles, \"<i>At least I'll have you to look forward to, whenever you roll into town.</i>\"");
	outputText("\n\nThat's that then, Rubi will refrain from sleeping around.  With that settled, you decide to let her get dressed and mull it over.  You head out of the house, and make your way back to camp.");
	flags[RUBI_PROSTITUTION] = -1;
	doNext(13);
}
//(Yes)
function yesBimboNTR():void {
	clearOutput();
	outputText("You contemplate it for a moment, and then slowly nod your head.  What's the harm in letting her blow off steam?  You know she'll always come back to you.  You assent to her wishes, to which she squeals and hugs you tightly, tossing the pink cushion aside.");
	outputText("\n\n\"<i>Ohh baby I love you so much!</i>\"  She plants a fury of kisses all over your face, giggling constantly.  \"<i>None of them could ever compare to you, but they will help.</i>\"");
	outputText("\n\nThat's that then, Rubi will be free to sleep with anyone, just as you are.  With that settled, you decide to let her get dressed.  You head out of the house, and make your way back to camp.");
	flags[RUBI_PROSTITUTION] = 1;
	doNext(13);
}

//(Break Up)
function breakUpWithRubi():void {
	clearOutput();
	outputText("You think about it for a long moment and then sigh sadly.  You look Rubi dead in the eyes and explain you can't be with a woman who wants to cheat on her partner.  Tears form in her eyes as she sniffles, but she nods with you.");
	outputText("\n\nAfter a moment of silence a faint whisper escapes her ruby red lips, \"<i>Get.  Out.</i>\"  You shrug, getting up, but as you start to leave the house, Rubi's voice screeches after you.  \"<i>You MONSTER!  I let you turn me into this because I loved you!  I could like, live with the con- the results, but I guess the hero couldn't!  You're desp-</i>\" she struggles with her bimbo-addled brain.  \"<i>You're totally DESPICABLE,</i>\" she finally says with a smirk.");
	outputText("\n\nAnd with that, she slams the door behind you.  Well, that could have gone better.  With an exasperated sigh you head back to your camp.");
	flags[RUBI_PROSTITUTION] = -2;
	flags[RUBI_DISABLED] = 1;
	doNext(13);
}
//(Pimp)
function pimpOutRubi():void {
	clearOutput();
	outputText("You think about it for a long while, mulling over all the possibilities.  Then something else occurs to you. She wants help controlling her urges, why not make a little money in the meantime?  You explain that she's free to sleep with whoever she wants, but that she could charge them for her time.  After all, if you're going to do what you love, you may as well get paid for it.");
	outputText("\n\nRubi thinks it over and finally nods happily, \"<i>Oh, it's such a great idea, baby!  I'll be like Edryn then!  And I'll give you your 'cut' whenever you come by as well.</i>\"  She giggles and plants a kiss right on your lips.  \"<i>Oooh, I'll need more outfits, and make up, and...</i>\" her voice trails off as she excitedly hurries off to her bedroom.");
	outputText("\n\nThat's that then, Rubi will officially prostitute herself and share the profits with you.  With that settled, you decide to let her go through her wardrobe in peace.  You head out of the house, and make your way back to camp.");
	flags[RUBI_PROSTITUTION] = 2;
	doNext(13);
}

//Chocolate Covered Strawberries, Oil, Massage?
//Rubi
//Kinda shy but eager to do it.
//Wants to please the PC.
//Calls PC Babe.
//Has red demon tail
/*Offer
First Time:
	Rubi gestures to some bottles and a box from the bakery before mentioning, \"<i>You look awful tense, babe.  I know you've got it hard out there, and well, I-I thought maybe I could really pamper you today, if you'd like.</i>\"
Repeat:
	Rubi nods towards the bottles and box in the corner and gives you a sly wink.  \"<i>Want another massage?</i>\"
*/
//Actual Scene:
function chocoRubiMassage():void {
	clearOutput();
	outputText("You look over his supplies and decide that a pampered day at Rubi's \"spa\" is just what you need.  Allowing him to escort you to his bed, you catch a few peeps of a pint-sized pup-tent in Rubi's bottoms.  He doesn't seem aware of your prying gaze, but he's blushing nonetheless, perhaps lost in his own less-than-pure thoughts as he guides you to the corner of his room.");
	
	outputText("\n\n\"<i>Babe, you'll need to... ah, take off your equipment for this,</i>\" Rubi instructs, holding a bottle full of shimmering fluid as he prances around the room.  You arch an eyebrow at him questioningly as you take in his eager expression, waiting until he starts to gnaw at his bottom lip before you ");
	if(player.cor >= 66) outputText("start sensually undressing, turning the simple act into a seductive show that causes Rubi's petite boner to jerk unpredictably beneath his clothes.  A small, damp stain appears at the tip by the time you finish your salacious tease.");
	else if(player.cor >= 33) outputText("get undressed without much pause or fanfare.  Rubi makes a show of turning his head, but you can see him peeping glimpses out of the corners of his eyes, and his boner seems to be bigger and harder than it was moments before.");
	else {
		outputText("make him turn around while you undress.  You quickly shuck your clothes and ask him what to do next, holding a hand across your [chest] and groin");
		if(player.biggestCockArea() >= 40 || player.biggestTitSize() >= 8) outputText(", not that it does much good");
		outputText(".");
	}
	
	outputText("\n\nRubi politely holds a towel between you as you climb into the bed face down, your head coming to rest on a down-filled pillow.  The fluffy fabric barrier is draped across your [butt], though your feminine boyfriend is sure to fold it so that your [legs] are fully exposed.  The box is placed in front of your " + player.face() + " and opened.  Inside is a candied, fruity treasure - chocolate covered strawberries.  Rubi's slender fingers pluck up one of the delectable treats and press it into your yielding lips, the sweet treat gliding onto your tongue whereupon it goes to work releasing starbursts of flavor.  You hum contently as you devour the confectionary gift, already feeling much more relaxed than you had been.  The rest are within easy reach, and you languidly set to snacking on them.");
	
	outputText("\n\nMeanwhile, you hear Rubi's clothing falling by the wayside.  You aren't sure what else you expected from the sexy little trap.  When you turn to look at him, you're treated to the sight of him all dolled up for you.  He has a crotchless set of panties clinging to his ");
	if(flags[RUBI_BLU_BALLS] < 3) outputText("small");
	else if(flags[RUBI_BLU_BALLS] < 8) outputText("big");
	else outputText("huge, stretched");
	outputText(" scrotum while allowing his delicate, aroused maleness to hang out freely, bouncing up in excitement as soon as you lay eyes on it.  Clinging to his svelte torso, a lacy corset compresses his middle slightly and amplifies his next-to-nonexistent chest, giving him an even greater appearance of femininity than before.");
	
	outputText("\n\n" + player.mf("Giggling","Smiling") + " appreciatively, you lick some half-melted chocolate from your upper lip.  You flick your gaze back to his dong in time to see a pearl of clear pre-cum bead on his cute cock's crown.  Rubi clenches his knees together, a little embarrassed, but he musters his courage and climbs into bed with you, his pert bottom coming to rest on your own.  Chastity is maintained, of course, by the fluffy, white towel between your (mostly) nude bodies.  His weight is noticeable but not uncomfortable, and he begins to work on your shoulders almost immediately, squeezing the right one while his left pops the cap on a bottle of oil.");
	
	outputText("\n\nOhhhh, that's cold!  The slippery glaze rubs down your spine as he pours it out all over your back, and you shiver from the difference between his hands and the slick fluid.  He sets the bottle aside after your top half has a generous coating and apologizes, \"<i>Sorry, I'll get you warmed up in a second, babe.</i>\"  It's clear from his tone that he seems genuinely penitent for the slip-up, but when his fingers begin to knead your " + player.skinFurScales() +", all is immediately forgiven.  You moan while Rubi puts his girlish palms to work on your muscles.  His touches are electric, and each contact releases tension that you didn't even know you had.  Lubricating the whole process, the oil is enhancing the touches, warming nicely from the heat of two bodies so close together.");
	
	outputText("\n\nGrunting as he exerts himself for your pleasure, the girlish brunette leans down to tend to a particularly stubborn knot, inadvertently pressing his tumescent organ into your crack along with the intervening fabric.  You both groan out loud at the same time - him from the pressure on his most sensitive, erotic spot, and you from the relief his hands are doling out.  You slowly drag another strawberry to your lips and begin to lick and suck on the tip, slowly melting the layers of chocolate until the red tip is revealed, pushing in and out of your lips teasingly.  Rubi is barely able to handle the display.  He's breathing heavily and barely stopping himself from humping you through the towel.");
	outputText("\n\nRubi whimpers, \"<i>I-uh... ummm, [name], I'm getting c-c-close,</i>\" without stopping.  His tail is slowly rubbing on your [leg] as he tries to keep his rebellious hips in place, but they jerk and stutter again and again, pressing his hot little tool into the towel.  You're totally and completely relaxed, and he's wound tighter than a spring.");
	
	outputText("\n\nDo you let him release or force him to stay all bottled up?  He has been awful nice...");
	fatigue(-40);
	stats(0,0,0,0,-1,0,5,0);
	flags[TIMES_RUBI_MASSAGED]++
	//[Release] [Nope]
	//{Not Pent Up: Go to release}
	menu();
	addButton(0,"Release",releaseRubiMassage);
	addButton(1,"Bottle Up",bottleUpRubiMassage);
}

//Bottle Up:
function bottleUpRubiMassage():void {
	clearOutput();
	outputText("You bite the strawberry in half and mouth, \"<i>No, not yet.  Just let it build up.</i>\"  He whines plaintively, but you cock your head to the side and say, \"<i>Come on, do it for me.  Just, don't let any out....  Here, come off of there and come into bed with me.  We can snuggle and let you relax a bit.</i>\"");
	outputText("\n\nYou pat the bed next to your hip and assist Rubi in snuggling against you, making sure you don't accidentally brush his boner - no point in letting him spill it all out after you've kept him on edge so long.  He slowly relaxes into your shoulder, and you share a kiss with him before feeding him the rest of the strawberries.");
	outputText("\n\nHe gratefully says, \"<i>Thanks, babe,</i>\" and though his body is still warm with almost feverish desire, he won't be cumming any time soon.");
	flags[RUBI_ORGASM_DENIAL] = 1;
	flags[RUBI_BLU_BALLS]++;
	doNext(14);
}

//Release/Not Pent Up
function releaseRubiMassage():void {
	clearOutput();
	outputText("You figure after all the pampering he did, he deserves a treat.");
	outputText("\n\nPushing the strawberry deeper, you bring its widest point to your oral entrance and let your tongue play across the chocolaty surface, melting the mocha-hued shell as your eyes lock with Rubi's.  He groans as he drinks in the oral feast.  Bubbling pre-cum freely, his short, girly cock looks like it's about ready to explode.  It almost looks like an overinflated sausage except this one is dangerously close to letting loose.  He manages to hold it back though, waiting for your permission to cum since he is on your backside after all.");
	outputText("\n\nYou push the strawberry into your mouth and swallow it, noisily smacking your lips before saying, \"<i>Come on Rubi, don't keep me waiting.  You deserve to release some tension too.</i>\"");
	
	outputText("\n\nAt your proclamation, Rubi bites down on his lower lip and his eyelids flutter down low, uncontrolled.  He moans, \"<i>Ohhh-okay!</i>\" and grabs hold of your towel-wrapped buns, pushing them together around his length.  You feel his turgid phallus bounce against your bottom once, twice, thrice, and then your lover's high-pitched voice is luridly moaning, accompanied by a sensation of dampness on your bottom.");
	//Not pent up or <= 3
	if(flags[RUBI_BLU_BALLS] <= 3) outputText("\n\nBubbling spurts of semen boil out of his petite sack, quickly soaking into the fluffy fabric as Rubi exhausts himself.  Soon, he's barely letting out a single drop of cum, but his boner is dutifully convulsing as if it could keep cumming forever.  The look of relief on his face is adorable, and you pull Rubi down into a snuggle while the cum-rag handles his lurid ejaculation.");
	//<= 5
	else if(flags[RUBI_BLU_BALLS] <= 5) outputText("\n\nThick lances of hot cum splatter wetly into the fluffy fabric as Rubi's backed-up balls do their best to empty the hot load you forced them to hold in.  His warm jism quickly soaks into the towel and puddles in the dick-shaped depression he's molded into your ass-cleavage, slowly dripping through the barrier onto your bottom.  His tongue drools out of his mouth in a display of palpable relief as he empties, eventually collapsing onto your back as the last of his load drools out of him.\n\nYou pull him off of you and into a snuggle as he slowly calms, kissing him and thanking him for the wonderful evening.");
	//<= 7
	else if(flags[RUBI_BLU_BALLS] <= 7) {
		outputText("\n\nHis cum shoots out hard enough to go right through the towel and into your crack.  Numerous spurts erupt out of his tiny cock, firing so fast and hard that the fabric turns into a sloppy mess, and your [butt] becomes moist with his sticky boy-goo.  Rubi's voluminous ejaculations abruptly lance up onto your back as he changes position, tongue hanging out in a display of complete relief and rapture, his eyes rolled most of the way as he completely loses himself to his thunderous climax.  Gurgling as they shrink, the femboy's balls convulse with each shot until they return to their normal size.  Your back has already been treated to a one-man bukkake show at that point, however.");
		outputText("\n\nRubi abruptly shudders, squirting a few weak strands of cream into the sopping-wet towel before he flops down atop you into his own mess.  You pull him to the side for a snuggle and rouse him with a kiss.  When he seems sane enough to understand you again, you thank him for the wonderful time.  Rubi blushes at that before apologizing for the mess and helping to clean you up before you go.  More than one towel has fallen prey to your boy-toy's backed up virility this day.");
	}
	//<= 9 
	else {
		outputText("\n\nHis cum rolls out of him in a thick, white wave, forcefully enough to immediately seep through the towel and voluminous enough that by his third squirt semen is dripping from the fringes of the sodden fabric.  Moaning like a whore, his hands knead your soaked bottom as his body is wracked by paroxysms of pleasure.  Muscles the femboy didn't even know he had are working triple-time to spray his bounty of liquid love out, and as his back arches involuntarily, his spurting jizz-fountain lifts to hose down your back, the cum beading on the oil like rain on glass.  His balls are shrinking by the second, but the bed is turning into a hot, wet mess along with your body.  You watch as his eyes roll the whole way back, and his tongue lolls from his mouth - Rubi's brain has shut down under the onslaught of his pleasure, leaving his body to jizz on autopilot until he goes dry.");
		outputText("\n\nSlowly, the flood dies down to a lazy drip, and then, with a whimper, it ends.  Rubi splashes down on your jizz-stained back nervelessly, his hands sinking into the puddles he's turned the mattress into on either side of you.  You teasingly roll your cheeks from side to side, earning a few last twitches from his spent erection before you pull the exhausted femboy down beside you.  Rubi whimpers as you hug him close and kiss him, ignoring the mess he's made so that you can simply enjoy the tender moment with your lover.  It looks like you both got what you needed today, though Rubi's going to go through a few more towels before you're fit to depart...");
	}
	flags[RUBI_ORGASM_DENIAL] = 0;
	flags[RUBI_BLU_BALLS] = 0;
	doNext(14);
}
	
	