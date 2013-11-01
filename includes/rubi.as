//const RUBI_AFFECTION:int = 604;
//const RUBI_DISABLED:int = 605;

//0 = not admitted (she), 1 = "he", 2 = "she"
//const RUBI_ADMITTED_GENDER:int = 606;
//const RUBI_INTRODUCED:int = 607;
//const RUBI_BLU_BALLS:int = 608;
//const RUBI_ORGASM_DENIAL:int = 609;
//const RUBI_BIMBO:int = 610;
//const RUBI_INCUBUS_PROGRESS:int = 611;
//const RUBI_SUITCLOTHES:int = 612;
//const RUBI_FETISH_CLOTHES:int = 613;
//const RUBI_GREEN_ADVENTURER:int = 614;
//const RUBI_TUBE_TOP:int = 615;
//const RUBI_BODYSUIT:int = 616;
//const RUBI_LONGDRESS:int = 617;
//const RUBI_TIGHT_PANTS:int = 618;
//const RUBI_NURSE_CLOTHES:int = 619;
//const RUBI_SWIMWEAR:int = 620;
//const RUBI_PROSTITUTION:int = 621;
//const RUBIS_HOUSE_FIRST_TIME:int = 622;
//const RUBI_GOT_BIMBO_SKIRT:int = 623;
//const RUBI_PROFIT:int = 624;
//const RUBI_BIMBO_MINIDRESS:int = 625;
//const TIMES_RUBI_MASSAGED:int = 832;
//Third's horrible new shit
//const RUBI_BREAST_SIZE:int = 984;
//const RUBI_COCK_SIZE:int = 985;
//const RUBI_COCK_TYPE:int = 986;
//const RUBI_LOWERBODY:int = 987;
//const RUBI_HORNTYPE:int = 988; 
//0 = normal, 1 = black
//const RUBI_NIPPLETYPE:int = 989;
//const RUBI_NO_CUNT:int = 990;
//const RUBI_CUNTTYPE:int = 991;
//const RUBI_EYE_DESCRIPT:int = 992;
//const RUBI_EYE_TYPE:int = 993;
//const RUBI_SKIN:int = 994;
//const RUBI_HAIR:int = 995;
//const RUBI_HAIR_LENGTH:int = 996;
//const RUBI_BALLS_TYPE:int = 997;
//const RUBI_EAR_TYPE:int = 998;
//const RUBI_HANDS:int = 999;
//const RUBI_WHISKERS:int = 1000;
//const RUBI_FEET:int = 1001;
//const RUBI_DEBIMBO:int = 1002;
//const RUBI_NIPPLE_TYPE:int = 1003;
//HE/SHE
//const RUBI_SHE:int = 1004;
//const TIMES_DISCUSSED_RUBIS_IDENTITY:int = 1005;
//const RUBI_ICECREAM_CONFESSION:int = 1006;
//const TIMES_RUBI_DATED:int = 1007;
//const RUBI_FANCY_CONFESSION:int = 1008;
//const RUBI_BAR_CONFESSION:int = 1009;
//const RUBI_TIMES_ANALLY_TRAINED:int = 1010;
//const RUBI_TIMES_GIVEN_AN_ITEM:int = 1011;
//const RUBI_BONDAGE_STRAPS:int = 1012;
//const RUBI_INQUISITORS_CORSET:int = 1013;
//const RUBI_SETUP:int = 1014;

function initializeRubi():void {
	if(flags[RUBI_BIMBO] == 0) {
		flags[RUBI_BREAST_SIZE] = 0;
		flags[RUBI_COCK_SIZE] = 5;
		flags[RUBI_NO_CUNT] = 1;
	}
	else {
		flags[RUBI_BREAST_SIZE] = 7;
		flags[RUBI_NO_CUNT] = 0;
		flags[RUBI_COCK_SIZE] = 0;
		flags[RUBI_SHE] = 1;
		flags[RUBI_HAIR] = 1;
	}
	flags[RUBI_SETUP] = 1;
}
function rubiBalls():String {
	return "normal";
	return "swollen";
	return "massively engorged";
}

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

function rubiCock():String {
	return NPCCockDescript(flags[RUBI_COCK_TYPE], flags[RUBI_COCK_SIZE], 50);
}
function rubiBreasts():String {
	var ret:String = "pair of ";


	if(flags[RUBI_BREAST_SIZE] < 1)
		ret = "chest";
	else
	{
		ret += breastCup(flags[RUBI_BREAST_SIZE]);
		ret += " ";
		ret += npcBreastDescript(flags[RUBI_BREAST_SIZE]);
	}

	return ret;
}
function rubiChest():String {
	return rubiBreasts();
}
function rubiCapacity():Number {
	var bonus:int = flags[RUBI_TIMES_ANALLY_TRAINED]*10;
	if(bonus > 76) bonus = 76;
	if (flags[HYPER_HAPPY])
		bonus += 200;		// MAKE IT FIT
	return 24 + bonus;
}
function rubiMF(man:String,woman:String):String {
	if(flags[RUBI_ADMITTED_GENDER] < 1) return woman;
	else {
		if(flags[RUBI_SHE] == 1) return woman;
		else return man;
	}
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
	simpleChoices("Accept",acceptRubi,"Reject",rejectRubi,"",0,"",0,"",0);
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
	if(flags[RUBI_SETUP] == 0) {
		initializeRubi();
	}
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
	else if(rubiBimbo() && flags[RUBI_DEBIMBO] == 0) outputText("Rubi is here, moving from table to table, not quite as efficiently as " + rubiMF("he","she") + " used to, but with a lot more exuberance.  " + rubiMF("His","Her") + " long red tail swishes around, seemingly drawn towards the crotch of patrons and co-workers alike.");
	else outputText("Rubi is here, moving from table to table efficiently clearing the empty ones and serving new customers.  " + rubiMF("His","Her") + " long red tail swishes back and forth excitedly.");
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
		outputText("You take a seat at a table, and within seconds Rubi pulls up a chair next to you.  ");
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
		if(flags[RUBI_BONDAGE_STRAPS] == 1) choices[choices.length] = 12;
		if(flags[RUBI_INQUISITORS_CORSET] == 1) choices[choices.length] = 13;
		//RIsque waitress uniform
		if(flags[RUBI_AFFECTION] >= 100) choices[choices.length] = 14;
		
		var select:int = choices[rand(choices.length)];
		
		
		
		//(Random outfit selection: Waitress Outfit (Normal))
		if(select == 1) {
			//(Waitress Outfit (Bimbo))
			outputText(rubiMF("He","She") + "'s dressed in " + rubiMF("his","her") + " usual waitress uniform: a pink blouse and skirt covered by a frilly white apron.");
			if(flags[RUBI_BREAST_SIZE] >= 4) outputText("  Rubi's breasts strain against the tight blouse, threatening to pop a button at any moment.");
			if(flags[RUBI_COCK_SIZE] >= 9) outputText("  You notice Rubi holds " + rubiMF("himself","herself") + " a little awkwardly, and it's only when " + arianMF("he","she") + " sits down that you spy the slight bulge in " + arianMF("his","her") + " skirt.");
		}
		//(Suit Clothes (Normal))
		else if(select == 2) {
			//(Suitclothes)
			outputText(rubiMF("He","She") + "'s dressed differently today, having foregone the normal waitress uniform for a professional black and white suit with a loose tie, though " + rubiMF("he","she") + " still wears the waitress headband");
			if(flags[RUBI_HORNTYPE] > 0) outputText("just behind the horns");
			outputText(".  In a sexy sort of way, " + rubiMF("he","she") + " looks like a girl dressed in her boyfriend's clothes");
			if(flags[RUBI_BREAST_SIZE] >= 4) outputText(", though with " + rubiMF("his","her") + " large bosom, " + rubiMF("he","she") + " can't quite button up all the way, giving the appearance of a sexy secretary");
			outputText(".");
		}
		else if(select == 3) {
			//(Rubber Fetish Outfit (Bimbo))
			//(Rubber Fetish Clothes)
			outputText("" + rubiMF("He","She") + "'s dressed differently today, having foregone the normal waitress uniform for a tight, black, rubber shirt, along with a skirt, and stockings.  The holes cut into the skirt, proudly displaying Rubi's ");
			if(flags[RUBI_NIPPLE_TYPE] > 0) outputText("black ");
			outputText("nipples, which stand at perky attention in the cool air.  Rubber straps crisscross the outfit in odd places, and the whole ensemble looks like something out of one of Mareth's many fetish dungeons.  The outfit draws attention to " + rubiMF("his","her") + "");
			if(flags[RUBI_BREAST_SIZE] >= 4) outputText(" impressive bosom, and sort of makes " + rubiMF("him","her") + " look like the kind of rubber doll one might buy for those lonely nights.");
			else outputText(" relatively flat chest, though with the rest of " + rubiMF("his","her") + " figure, it's hard to imagine " + rubiMF("him","her") + " as anything but a woman.");
		}
		else if(select == 5) {
			//(Tube Top)
			outputText("" + rubiMF("He","She") + "'s dressed differently today, having foregone the normal waitress uniform for a neon pink tube top and a pair of tiny denim shorts.");
			//(D breasts or higher)
			if(flags[RUBI_BREAST_SIZE] >= 4) outputText("  " + rubiMF("His","Her") + " breasts strain the fabric of the tube top, any wrong move threatening to have them burst forth.");
			//(dick 9" or higher)
			if(flags[RUBI_COCK_SIZE] >= 4) outputText("  " + rubiMF("His","Her") + " rather large bulge can't be concealed, however, and you sometimes catch Rubi holding " + rubiMF("his","her") + " notepad down across " + rubiMF("his","her") + " crotch when " + rubiMF("he","she") + " moves from table to table.");
			else outputText("" + rubiMF("His","Her") + " bulge is well concealed at least.  You're sure it would take a skilled eye, or someone who knew what to look for, to notice Rubi's little package.");
		}
		else if(select == 6) {
			//(Bodysuit)
			outputText("" + rubiMF("He","She") + "'s dressed differently today, having foregone the normal waitress uniform for an almost sheer bodysuit covering " + rubiMF("him","her") + " from the groin up to the neck.  The lacy outfit is covered with flowers and swirling, colorful decorations in strategically placed locations.");
			if(flags[RUBI_COCK_SIZE] >= 9) outputText("  However, with an outfit this tight, it's almost impossible for " + rubiMF("him","her") + " to hide " + rubiMF("his","her") + " impressive package.  Rubi's cock pokes straight upwards, creating a bulge from " + rubiMF("his","her") + " crotch up towards " + rubiMF("his","her") + " belly button.");
			else if(flags[RUBI_COCK_SIZE] > 0) outputText("  However, with an outfit this tight you can see a slight outline where " + rubiMF("his","her") + " small package is tucked away.  You wonder how many other patrons have noticed the same thing.");
		}
		else if(select == 7) {
			//(Long Dress (Bimbo))
			outputText("" + rubiMF("He","She") + "'s dressed differently today, having foregone the normal waitress uniform for an elegant, sequined ballroom gown.");
			if(rubiBimbo()) outputText("  " + rubiMF("He","She") + "'s even modified the dress with false gems and a slit up the side to show off " + rubiMF("his","her") + " leg.");
			outputText("  You are stunned by the breathtaking combination of classy and carnal.  You're sure " + rubiMF("he","she") + " would look great at a fancy ball, but here at the bakery " + rubiMF("he","she") + " looks out of place, especially as a waitress.");
			//(Breasts flat or A cup)
			if(flags[RUBI_BREAST_SIZE] <= 1) outputText("  The dress must have come with a padded bra, because you're surprised to see Rubi with  breasts.  Though small, they help to accentuate " + rubiMF("his","her") + " feminine figure.");
		}
		else if(select == 8) {
			//(Tight Leather Pants (Bimbo))
			outputText(rubiMF("He","She") + "'s dressed differently today, having foregone the normal waitress uniform for a loose silk white shirt with tight black leather pants.");
			if(flags[RUBI_BREAST_SIZE] >= 4) outputText("  With " + rubiMF("his","her") + " large rack, " + rubiMF("he","she") + " looks much like a busty piratess.  From the way " + rubiMF("his","her") + " breasts strain at the top, you're certain that one wrong breath could send a button flying across the room.");
			else outputText("  With " + rubiMF("his","her") + " relatively flat chest, however, you wonder if perhaps it makes " + rubiMF("him","her") + " look a bit too much like a man.  An effeminate man, but a man nonetheless.");
			//Cock variants: 
			//(9" or higher)
			if(flags[RUBI_COCK_SIZE] >= 9) outputText("  " + rubiMF("His","Her") + " generous cock is on display, much to " + rubiMF("his","her") + " chagrin, as a bulge running down the length of one pant leg.");
			else outputText("Luckily, given " + rubiMF("his","her") + " relatively small package, " + rubiMF("his","her") + " bulge is kept nice and secret even with the tightness of the clothing.");
		}
		else if(select == 9) {
			//(Nurse Clothes (Bimbo))
			outputText("" + rubiMF("He","She") + "'s dressed differently today, having foregone the normal waitress uniform for a tight, one-piece white dress with a red cross over the breast pocket, and atop her head is perched a little white hat with the same red cross.  " + rubiMF("He","She") + " looks like the kind of nurse you'd expect to see in your dirty dreams, and you wonder how many bakery customers were thrown by Rubi's odd, albeit sexy, appearance today.");
			//(D breasts or higher)
			if(flags[RUBI_BREAST_SIZE] >= 4) outputText("  Rubi's large breasts strain the fabric, drawing the dress further up " + rubiMF("his","her") + " body and showing off more of " + rubiMF("his","her") + " legs and ass.");
		}
		//(Slutty Swimwear (Normal))
		else if(select == 10) {
			//(Slutty Swimwear)
			outputText("" + rubiMF("He","She") + "'s dressed differently today, having foregone the normal waitress uniform for an impossibly skimpy black bikini.  It's a cute swimsuit, and Rubi looks damn sexy in it, but you can't help but think it's more suited for a day at the beach and not a day working in a bakery.");
			//(D breasts or higher)
			if(flags[RUBI_BREAST_SIZE] >= 4) outputText("  Rubi's tremendous cleavage threatens to spill out of the skimpy bikini top with every movement, and from the red faces around the bakery, you wonder if that's already happened.");
			else if(flags[RUBI_BREAST_SIZE] <= 1) outputText("  The top only emphasizes Rubi's relatively flat chest, though with the rest of " + rubiMF("his","her") + " figure, " + rubiMF("he","she") + " still looks extremely feminine.");
		}
		//(Minidress Outfit (Bimbo))
		else if(select == 11) {
			outputText("" + rubiMF("He","She") + "'s dressed differently today, having foregone the normal waitress uniform for an impossibly short strapless pink mini-dress.  The top barely comes up to cover " + rubiMF("his","her") + " nipples, and you're sure " + rubiMF("he","she") + " has to adjust it constantly to avoid any wardrobe malfunctions.  The bottom is so short " + rubiMF("he","she") + "'s certainly giving a show to anyone behind " + rubiMF("him","her") + " whenever " + rubiMF("he","she") + " leans forward.  All in all, Rubi looks like " + rubiMF("he","she") + "'s ready for a night on the town and not a day waiting tables.");
			if(flags[RUBI_COCK_SIZE] > 0) outputText("  " + rubiMF("His","Her") + " skirt rides so high you catch glimpses of " + rubiMF("his","her") + " unsurprisingly unpantied crotch, and the enticing package held within.  You wonder how many people have gotten a surprise with their drinks today!");
		}
		//(Bondage Straps)
		else if(select == 12) {
			outputText("" + rubiMF("He","She") + "'s dressed differently today, having foregone the normal waitress uniform for a series of leather straps and hooks.  A series of leather belts cross " + rubiMF("his","her") + " body, covering strategic areas with thicker, more pliable straps.  You wonder how comfortable such an outfit could be, and as you do so you notice Rubi dig out a wedgie when " + rubiMF("he","she") + " thinks no one's looking.  How Rubi can continue to work at the bakery wearing this, you'll never know.");
		}
		//(Inquisitor's Corset)
		else if(select == 13) {
			outputText("" + rubiMF("He","She") + "'s dressed differently today, having foregone the normal waitress uniform for a tight red and gold corset, connected with garter straps to a pair of sheer black stockings.  The corset really enhances Rubi's naturally feminine figure, though you can't imagine it being too comfortable.  The black, opaque stockings come up to " + rubiMF("his","her") + " thighs have an inlaid gold corset pattern on the back, which lead up to a pair of bows that bounce perkily as Rubi walks.");
		}
		//(Risque Waitress Uniform)
		else if(select == 14) {
			outputText("" + rubiMF("He","She") + "'s dressed differently today, having foregone the normal waitress uniform for an extremely modified version.  The skirt wrapped around " + rubiMF("his","her") + " waist could be confused for a belt, and the apron (the only other thing covering " + rubiMF("his","her") + " torso) doesn't extend much further.  Any time Rubi takes a step or bends in any direction, anyone within sight is sure to get a good look at " + rubiMF("his","her") + " ");
			if(flags[RUBI_COCK_SIZE] > 0) outputText(NPCCockDescript(flags[RUBI_COCK_TYPE],flags[RUBI_COCK_SIZE], 33) + ", clad in a cute little frilly pink cocksock");
			if(flags[RUBI_NO_CUNT] == 0 && flags[RUBI_COCK_SIZE] > 0) outputText(" and ");
			if(flags[RUBI_NO_CUNT] == 0) {
				outputText("feminine mound trapped beneath a pair of pink panties");
				//(if Bimbo Brain)
				if(rubiBimbo() && flags[RUBI_DEBIMBO] == 0) outputText(" trimmed feminine mons, free and open to the air");
			}
			outputText(".");
			//(D breasts or higher)
			if(flags[RUBI_BREAST_SIZE] >= 4) outputText("  Rubi's breasts, large as they are, show off a decent amount of sideboob and threaten to spill out at any moment.  Judging by the flushed faces of some customers, this may have already happened.");
			outputText("  This outfit, as risque as it is, is clearly something Rubi never would have worn before " + rubiMF("he","she") + " met you.  " + rubiMF("He","She") + " must be really comfortable in " + rubiMF("his","her") + " body now!");
		}
		outputText("\n\n" + rubiMF("He","She") + " hands you the usual menu and says, \"<i>");
		if(rubiBimbo() && !flags[RUBI_DEBIMBO] == 0) outputText("Like, h");
		else outputText("H");
		outputText("ere's the menu, babe.  Think about what you want and let me know when you're ready.</i>\"  " + rubiMF("He","She") + " stands and moves to clean off a nearby table, " + rubiMF("his","her") + " red spaded tail swishing behind " + rubiMF("him","her") + " sensually.");
	
		//(Adventurer's Outfit)
		if(select == 15) {
			 outputText("" + rubiMF("He","She") + "'s dressed differently today, having foregone the normal waitress uniform for a large green tunic which looks more like a dress on " + rubiMF("him","her") + ", along with brown tights and a pointed green hat.  At " + rubiMF("his","her") + " waist is a wooden sword alongside " + rubiMF("his","her") + " normal notepad.  Were Rubi more masculine, you might think " + rubiMF("he","she") + " looks like an adventurer of some kind, but in reality " + rubiMF("he","she") + " looks like a normal girl in a strange hat.");
			if(flags[RUBI_BREAST_SIZE] >= 4) outputText("  In an odd sort of way, " + rubiMF("he","she") + " looks like an adventurer who met the wrong end of a witch's curse.");
		}
		//(Default Waitress Uniform)
		if(select == 1) {
			outputText("\n\nAs " + rubiMF("he","she") + " bends over, you get a good look up " + rubiMF("his","her") + " skirt, ");
			if(rubiBimbo() && !flags[RUBI_DEBIMBO] == 0) {
				outputText("surprised to see " + rubiMF("he","she") + "'s wearing nothing at all underneath, showing off " + rubiMF("his","her") + " asshole");
				if(flags[RUBI_NO_CUNT] == 0 && flags[RUBI_COCK_SIZE] == 0) outputText(" and wet cunt");
				else if(flags[RUBI_NO_CUNT] > 0 && flags[RUBI_COCK_SIZE] > 0) outputText(" and limp cock");
				else outputText(", wet cunt, and limp cock");
				outputText(" to anyone behind " + rubiMF("him","her") + "");
			}
			else outputText("excited to see Rubi's choice of frilly pink panties clinging to " + rubiMF("his","her") + " supple ass");
			outputText(".");
		}
		//(Dashing Outfit)
		else if(select == 8) outputText("\n\nAs " + rubiMF("he","she") + " bends over, you get a good look at " + rubiMF("his","her") + " ass, emphasized by the tight leather pants.");
		//(Adventurer's Outfit)
		else if(select == 15) {
			outputText("\n\nAs " + rubiMF("he","she") + " bends over, you get a good look up " + rubiMF("his","her") + " dress-like tunic, enjoying the sight of " + rubiMF("his","her") + " round ass emphasized by the dark tights.");
			//If Bimbo Body:
			if(rubiBimbo()) outputText("  You even spy a wet patch in the crotch, with rivulets of moisture running down the legs, which " + rubiMF("he","she") + " must have trouble hiding... if " + rubiMF("he","she") + " even bothers to try.");
		}
		//(Long Dress)
		else if(select == 7) {
			outputText("\n\nAs " + rubiMF("he","she") + " moves to another table, Rubi sways back and forth, as if dancing with an invisible partner.  ");
			if(rubiBimbo() && flags[RUBI_DEBIMBO] == 0) outputText("And then " + rubiMF("he","she") + " begins to shake " + rubiMF("his","her") + " ass, making spanking motions and effectively ruining the air of sophistication.");
		}
		//(Nurse Uniform)
		else if(select == 9) {
			outputText("\n\nAs " + rubiMF("he","she") + " bends over, you get a good look up " + rubiMF("his","her") + " skirt, ");
			if(rubiBimbo() && !flags[RUBI_DEBIMBO] == 0) {
				outputText("surprised to see " + rubiMF("he","she") + "'s wearing nothing at all underneath, showing off " + rubiMF("his","her") + " asshole");
				if(flags[RUBI_NO_CUNT] == 0 && flags[RUBI_COCK_SIZE] == 0) outputText(" and wet cunt");
				else if(flags[RUBI_NO_CUNT] > 0 && flags[RUBI_COCK_SIZE] > 0) outputText(" and limp cock");
				else outputText(", wet cunt, and limp cock");
				outputText(" to anyone behind " + rubiMF("him","her") + "");
			}
			else outputText("excited to see Rubi's choice of frilly white panties clinging to " + rubiMF("his","her") + " supple ass");
			outputText(".");
		}
		//(Rubber Fetish Outfit)
		else if(select == 3) {
			outputText("\n\nAs " + rubiMF("he","she") + " bends over, you get a good look up " + rubiMF("his","her") + " skirt, ");
			if(rubiBimbo() && !flags[RUBI_DEBIMBO] == 0) {
				outputText("surprised to see " + rubiMF("he","she") + "'s wearing nothing at all underneath, showing off " + rubiMF("his","her") + " asshole");
				if(flags[RUBI_NO_CUNT] == 0 && flags[RUBI_COCK_SIZE] == 0) outputText(" and wet cunt");
				else if(flags[RUBI_NO_CUNT] > 0 && flags[RUBI_COCK_SIZE] > 0) outputText(" and limp cock");
				else outputText(", wet cunt, and limp cock");
				outputText(" to anyone behind " + rubiMF("him","her") + "");
			}
			else outputText("excited to see a pair of translucent rubber panties clinging to " + rubiMF("his","her") + " supple ass");
			outputText(".");
		}
		//(Suitclothes)
		else if(select == 2) {
			outputText("\n\nAs " + rubiMF("he","she") + " bends over, you get a good look at " + rubiMF("his","her") + " ass, despite the less-than-flattering cut of the trousers.");
		}
		//(Tube Top)
		else if(select == 5) {
			outputText("\n\nAs " + rubiMF("he","she") + " bends over, you get a good look at " + rubiMF("his","her") + " ass, emphasized by the tight denim shorts.");
		}
		//(Slutty Swimwear)
		else if(select == 10) {
			outputText("\n\nAs " + rubiMF("he","she") + " bends over, you get a good look at " + rubiMF("his","her") + " ass, emphasized by the tight bikini bottoms.");
		}
		//(Bimbo Minidress)
		else if(select == 11) {
			outputText("\n\nAs " + rubiMF("he","she") + " bends over, you get a good look up " + rubiMF("his","her") + " dress, ");
			if(rubiBimbo() && !flags[RUBI_DEBIMBO] == 0) {
				outputText("surprised to see " + rubiMF("he","she") + "'s wearing nothing at all underneath, showing off " + rubiMF("his","her") + " asshole");
				if(flags[RUBI_NO_CUNT] == 0 && flags[RUBI_COCK_SIZE] == 0) outputText(" and wet cunt");
				else if(flags[RUBI_NO_CUNT] > 0 && flags[RUBI_COCK_SIZE] > 0) outputText(" and limp cock");
				else outputText(", wet cunt, and limp cock");
				outputText(" to anyone behind " + rubiMF("him","her") + "");
			}
			else outputText("excited to see a cute, little thong wedged into " + rubiMF("his","her") + " supple ass");
			outputText(".");
		}
		//(Bodysuit)
		else if(select == 6) {
			outputText("\n\nAs " + rubiMF("he","she") + " bends over, you get a good look at " + rubiMF("his","her") + " ass, emphasized by the tight lace bodysuit.");
			//If Bimbo Body:
			if(rubiBimbo()) outputText("  You even spy a moist patch in the crotch, which must be impossible to hide... if " + rubiMF("he","she") + " even bothers to try.");
		}
		//(Bondage Straps)
		else if(select == 12) {
			outputText("\n\nAs " + rubiMF("he","she") + " bends over, you get a good look at " + rubiMF("his","her") + " ass, emphasized by a thick leather strap which runs between " + rubiMF("his","her") + " asscheeks like a thong.");
		}
		//(Inquisitor's Corset) 
		else if(select == 13) {
			outputText("\n\nAs " + rubiMF("he","she") + " bends over, you get a good look at " + rubiMF("his","her") + " ass, emphasized by the gold-laced red panties.");
		}
		//(Risque Waitress Uniform)
		else if(select == 14) {
			outputText("\n\nAs " + rubiMF("he","she") + " bends over, you get a good look up " + rubiMF("his","her") + " sad excuse for a skirt, ");
			if(rubiBimbo() && !flags[RUBI_DEBIMBO] == 0) {
				outputText("surprised to see " + rubiMF("he","she") + "'s wearing nothing at all underneath, showing off " + rubiMF("his","her") + " asshole");
				if(flags[RUBI_NO_CUNT] == 0 && flags[RUBI_COCK_SIZE] == 0) outputText(" and wet cunt");
				else if(flags[RUBI_NO_CUNT] > 0 && flags[RUBI_COCK_SIZE] > 0) outputText(" and limp cock");
				else outputText(", wet cunt, and limp cock");
				outputText(" to anyone behind " + rubiMF("him","her") + "");
			}
			else outputText("excited to see a pair of pink frilly panties clinging to " + rubiMF("his","her") + " supple ass");
			outputText(".");
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
	//(Relationship20+, normal Rubi)
	else {
		outputText("You flag down Rubi and tell " + rubiMF("him","her") + " you'd like to order some milk.  " + rubiMF("He","She") + " nods and soon you're holding glass of sweet smelling milk.  \"<i>We get it fresh every day,</i>\" " + rubiMF("he","she") + " says as you take a drink.  It is quite delicious.  You gulp it down, and find another glass placed in front of you.  \"<i>Free refills, babe.</i>\"");
		outputText("\n\nYou take it easier on the next couple glasses.  You chat with Rubi whenever " + rubiMF("he","she") + " comes by to top you off, it's not long before " + rubiMF("he","she") + "'s sitting with you and laughing as you make terrible jokes.  After a while, you excuse yourself and head back to camp.");
	}
	player.gems -= 3;
 	rubiAffection(3);
	player.modThickness(100,1);
	if(rubiAffection() >= 30 && flags[RUBI_ADMITTED_GENDER] == 0) doNext(specialRelationship20scene);
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
	//(Relationship 20+, normal Rubi)
	else {
		outputText("You flag Rubi down and tell " + rubiMF("him","her") + " you'd like to order a cup of tea.  " + rubiMF("He","She") + " nods and soon you've got a piping hot cup of fragrant tea in front of you.  \"<i>It's our relaxing blend, soothes the body and mind,</i>\" " + rubiMF("he","she") + " says.  You take a sip and sigh.  It is indeed relaxing.");
		outputText("\n\nYou find yourself almost drifting off as you drink, but Rubi comes by to chat and check on you.  " + rubiMF("He","She") + " even takes a small break to give your temples a brief massage.  Feeling relaxed enough, you excuse yourself and head back to camp.");
	}
	player.gems -= 6;
	rubiAffection(5);
	fatigue(-25);
	if(rubiAffection() >= 30 && flags[RUBI_ADMITTED_GENDER] == 0) doNext(specialRelationship20scene);
	else doNext(13);
}
 
//Choose Chat?
function chatWithRubi():void {
	clearOutput();
	//(+1 relationship)
	rubiAffection(2);
	//(Relationship 0-9)
	if(rubiAffection() < 15) {
		outputText("You decide not to order anything to drink, instead taking the chance to talk with your waitress, Rubi, whenever " + rubiMF("he","she") + "'s available.  You talk of pleasant but inconsequential things.  Rubi talks of growing up in a town far away, an actual human village, which was later raided by demons.  " + rubiMF("He","She") + " lived off the land for a while, drinking down one too many bottles of mysterious milk which gave " + rubiMF("him","her") + " the tail she now possesses.  " + rubiMF("He","She") + " eventually found Tel'Adre and was taken in by a kindly trio of ferret-morphs.  " + rubiMF("He","She") + " talks wistfully of home, and " + rubiMF("his","her") + " green eyes shimmer with a faraway look for a moment before " + rubiMF("he","she") + " snaps back to reality.");
		outputText("\n\nExcusing herself, " + rubiMF("he","she") + " moves to attend with other tables.  You decide this is a good time to head back to camp as well.");
	}
	//(Relationship 10-19)
	else if(rubiAffection() < 30) {
		rubiAffection(8);
		outputText("You decide not to order anything to drink, instead taking the chance to talk with Rubi whenever " + rubiMF("he","she") + "'s available.  You talk of pleasant but inconsequential things.  Rubi spends some time describing " + rubiMF("his","her") + " life living outside the safety of Tel'Adre.  " + rubiMF("He","She") + "'d never been caught by the various creatures, but there have been close calls.  " + rubiMF("He","She") + " met several people who helped her out, however.  " + rubiMF("He","She") + " talks highly of a dogmorph that runs a farm not far away, and of an otter-girl that fishes along a nearby lake.  " + rubiMF("He","She") + " laughs and reminisces about how good the otter-girl's cooking was, and that even now " + rubiMF("he","she") + " still can't find a decent fish filet.");
		outputText("\n\nEventually you run out of topics to discuss, and excuse yourself, heading back to camp.");
	}
	//(Relationship 20-39)
	else if(rubiAffection() < 100) {
		outputText("You decide not to order anything to drink, instead taking the opportunity to hang out with Rubi whenever " + rubiMF("he","she") + " has a free moment.  You talk of pleasant but inconsequential things.  Rubi spends some time describing life with " + rubiMF("his","her") + " three adoptive ferret parents.  Two males and a female, apparently, all lovers.  Rubi was taken in by them several years ago, and though " + rubiMF("he","she") + "'s since moved out, " + rubiMF("he","she") + " still keeps in contact with them.  " + rubiMF("He","She") + " blushes and tells you of the times " + rubiMF("he","she") + "'s been unable to sleep, hearing the three of them going at it for hours on end.");
		outputText("\n\nEventually you run out of topics to discuss and excuse yourself, giving Rubi a kiss on the cheek before heading back to camp.");
	}
	//(Relationship 40, Bimbo Rubi)
	else if(rubiBimbo() && flags[RUBI_DEBIMBO] == 0) {
		outputText("You decide not to order anything to drink, instead taking the opportunity to hang out with Rubi whenever " + rubiMF("he","she") + " has a free moment.  You talk of pleasant but inconsequential things.  Rubi spends some time discussing the fashion movements of Tel'Adre and how they're nothing like the fashion in " + rubiMF("his","her") + " home village, an honest-to-goodness human village.  " + rubiMF("He","She") + " mentions how everyone back 'home' dressed so conservatively, not like the sexy body-baring fashions here.  Rubi even says how glad " + rubiMF("he","she") + " is that demons attacked those years ago, so that " + rubiMF("he","she") + " could come here and start her new life with hot new clothes and a new body.");
		outputText("\n\nEventually you run out of topics to discuss and excuse yourself, giving Rubi a passionate kiss on the lips before heading back to camp.");
	}
	//(Relationship 40, normal Rubi)
	else {
		outputText("You decide not to order anything to drink, instead taking the opportunity to hang out with Rubi whenever " + rubiMF("he","she") + " has a free moment.  You talk of pleasant but inconsequential things.  Rubi spends some time discussing " + rubiMF("his","her") + " old village, an honest-to-goodness human village.  Life there was good, they had plenty of farms bringing in food, and very little corruption to contend with.  There were some residents with inhuman features, usually achieved willingly, but the majority were pureblood humans.  That changed years ago when a detachment of incubi, succubi and imps attacked.  Rubi and a handful made it out fine, but got split up along the way.  As far as Rubi knows, everyone else either perished or was corrupted in the aftermath.");
		outputText("\n\nEventually you run out of topics to discuss and excuse yourself, giving Rubi a kiss on the lips before heading back to camp.");
	}
	if(rubiAffection() >= 30 && flags[RUBI_ADMITTED_GENDER] == 0) doNext(specialRelationship20scene);
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
	//Repeat unirubi variant
	else {
		outputText("Rather than order anything, you stop Rubi as " + rubiMF("he","she") + "'s going by your table and pull " + rubiMF("him","her") + " close.  \"<i>How about we get out of here?</i>\" you whisper into " + rubiMF("his","her") + " ear.");
		outputText("\n\nThe little demon-" + rubiMF("boy","girl") + " blushes and " + rubiMF("his","her") + " tail swishes excitedly behind " + rubiMF("him","her") + ".  \"<i>Again?</i>\" " + rubiMF("he","she") + " asks, looking around furtively, \"<i>let me get Dia to cover my shift.</i>\"  " + rubiMF("He","She") + " promptly heads off into the back room, returning minutes later with the young canine waitress behind " + rubiMF("him","her") + ".  Rubi points out a few tables, says some things to " + rubiMF("his","her") + " replacement, and then returns to your side.");
		outputText("\n\n“<i>Let's go</i>,” " + rubiMF("he","she") + " whispers and you head off towards " + rubiMF("his","her") + " place.  It doesn't take long for the two of you to make your way through the streets of Tel'Adre and up through Rubi's well tended garden.");
		outputText("\n\nBefore you know it, you're once again standing in Rubi's tastefully decorated living room.  Lots of pillows and cushions are strewn about the room to sit or lay on, and a large plush couch sits opposite a fireplace. On the mantel above the fireplace sits a slightly scorched portrait of a happy-looking human couple with a young boy.  You'd guess that's Rubi's family from before the demons attacked " + rubiMF("his","her") + " village.");
		outputText("\n\nRubi stretches out on the couch and says,  \"<i>So babe, now that you've got me here, what do you want to do?</i>\"");
	}
	//[Fuck Rubi (if player has cock, OR at least a 4</i>\" clit)] [Dildo Fuck (If player has Deluxe Dildo)] [Tease] [Release (Only if Normal or Incubus Rubi who has been teased)] [Titfuck (Bimbo Rubi only)] [Give Item]
	menu();
	addButton(0,"Sex",rubiSexMenu);
	addButton(1,"Closet",goInRubisClosetSoThatYouCanComeOutOfTheCloset);
	addButton(2,"Talk",talkToRubiInHouse);
	if(rubiAffection() >= 50 && !rubiBimbo() && flags[RUBI_COCK_SIZE] > 0 && (!rubiBimbo() || flags[RUBI_DEBIMBO] > 0) && flags[RUBI_SHE] == 0) {
		//First Time:
		if(flags[TIMES_RUBI_MASSAGED] == 0) outputText("\n\nRubi gestures to some bottles and a box from the bakery before mentioning, \"<i>You look awful tense, babe.  I know you've got it hard out there, and well, I-I thought maybe I could really pamper you today, if you'd like.</i>\"");
		else outputText("\n\nRubi nods towards the bottles and box in the corner and gives you a sly wink.  \"<i>Want another massage?</i>\"");
		addButton(4,"Massage",chocoRubiMassage);
	}
	addButton(9,"Leave",eventParser,13);
}

function rubiSexMenu():void {
	//[Fuck Rubi (if player has cock, OR at least a 4</i>\" clit)] [Dildo Fuck (If player has Deluxe Dildo)] [Tease] [Release (Only if Normal or Incubus Rubi who has been teased)] [Titfuck (Bimbo Rubi only)] [Give Item]
	var fuck:int = 0;
	var dildo:int = 0;
	var releas:int = 0;
	var titfuck:int = 0;
	var give:int = 0;
	if(player.lust >= 33) {
		if(player.hasCock() || (player.hasVagina() && player.clitLength >= 4)) fuck = 3899;
		if(player.hasKeyItem("Deluxe Dildo") >= 0) dildo = 3900;
	}
	if(flags[RUBI_BLU_BALLS] > 0 && flags[RUBI_ORGASM_DENIAL] > 0 && !rubiBimbo()) releas = 3902;
	
	menu();
	if(fuck > 0) addButton(0,"Fuck",eventParser,fuck);
	if(dildo > 0) addButton(1,"Dildo Fuck",eventParser,dildo);
	addButton(2," Tease ",eventParser,3901);
	if(releas > 0 && flags[RUBI_COCK_SIZE] > 0) addButton(3,"Release",eventParser,releas);
	if(flags[RUBI_AFFECTION] >= 75 && rubiCapacity() < player.biggestCockArea() && player.hasCock()) addButton(4,"Train",anallyTrainYourBitchBoySlutHowToBeAnalForDCL);
	//Get Fucked
	//PC gets fucked by Rubi
	//Rubi must have at least a 5" cock
	//Requires 75 Affection
	if(flags[RUBI_AFFECTION] >= 75 && flags[RUBI_COCK_SIZE] >= 5) addButton(5,"Get Fucked",getFuckedByRubi);
	//Hotdogging
	//PC hotdogs Rubi's ass
	//PC must have a penis
	if(player.hasCock()) addButton(6,"Hotdogging",rubiHotdogging);
	addButton(9,"Back",rubisFuckingHouseYouPervert);
}


//Talk
function talkToRubiInHouse():void {
	clearOutput();
	outputText("You just want to talk with Rubi for now.  What do you want to talk about?");
	menu();
	addButton(0,"Identity",rubiIdentity);
}

function rubiIdentity():void {
	clearOutput();
	//Identity
	if(flags[TIMES_DISCUSSED_RUBIS_IDENTITY] == 0) {
		outputText("You've noticed Rubi always refers to himself as a \"he\", despite ");
		if(flags[RUBI_NO_CUNT] == 1) 
			outputText("his attempts to appear otherwise");
		else 
			outputText("his relatively recent transformation to the contrary");
		outputText(".  Questioning him about it, he simply blushes.");
		outputText("\n\n\"<i>Oh, that… Um, I guess I never really figured I was a girl, you know?  I really love pretty clothes and other things people call girly, but I never necessarily wanted to be a girl.");
		if(flags[RUBI_NO_CUNT] == 0) 
			outputText("  Though now that I am, I absolutely love it!");
		outputText("</i>\" he confides, fidgeting slightly.  \"<i>If you wanted to call me a \"she\", I'd be OK with that, just so you know.</i>\"");
		outputText("\n\nWhich type of pronoun would you prefer Rubi to use?");
	}
	//(Repeating?)
	else {
		outputText("You talk with Rubi at length about " + rubiMF("his","her") + " gender identity again.  All in all, " + rubiMF("he","she") + " seems pretty open to being either gender, with no real preference one way or another as long as " + rubiMF("he","she") + " gets " + rubiMF("his","her") + " pretty dresses.");
		outputText("\n\nWhich type of pronoun would you prefer Rubi to use?");
	}
	flags[TIMES_DISCUSSED_RUBIS_IDENTITY]++;
	//[He] [She]
	menu();
	addButton(0,"He",rubiIsAHe);
	addButton(1,"She",rubiIsAShe);
}

//He
function rubiIsAHe():void {
	clearOutput();
	flags[RUBI_SHE] = 0;
	outputText("Rubi nods, and will refer to himself as a \"he\" from now on.");
	menu();
	addButton(9,"Back",rubisFuckingHouseYouPervert);
}
//She
function rubiIsAShe():void {
	clearOutput();
	flags[RUBI_SHE] = 1;
	outputText("Rubi nods, and will refer to herself as a \"she\" from now on.");
	menu();
	addButton(9,"Back",rubisFuckingHouseYouPervert);
}
//Sex Scenes Ahoy!  
//There are variants for Normal, Bimbo and Incubus Rubi, as well as smaller variations if you're currently teasing him or not.
//Fuck Rubi
//(available for players with cocks or large clits (at least 4</i>\")) (If Orgasm Denial is activated, adds 1 to Blue Balls)
function fuckRubi():void {
	var x:int;
	x = player.cockThatFits(rubiCapacity());
	if(x < 0) 
		x = player.biggestCockIndex();
	clearOutput();
	//(-100 Arousal)
	outputText("You take Rubi by the hand and head into the bedroom, clutching " + rubiMF("him","her") + " close.  You sit on the edge of the soft fluffy bed and pull the little demon " + rubiMF("boy","girl") + " onto your lap.  The two of you kiss, letting your " + tongueDescript() + " explore the depths of your partner's mouth.");
	outputText("\n\nRunning your hands along Rubi's body, you pull and tear at the clothes keeping you apart.  Garments fly as you ravish each other, and it isn't long before you're both naked, with Rubi straddling your waist.  " + rubiMF("He giggles and reaches between his legs","She giggles and reaches between her legs") + ", wrapping slender fingers around your ");
	if(player.hasCock()) 
	{
		// trace("Rubi - PlayerHasCock");
		outputText(cockDescript(x), false);
	}
	else 
		outputText(clitDescript(), false);
	outputText(".");
	
	var size:int = 0;
	var cock:Boolean = player.hasCock();
	//(If player cock/clit at or under 4</i>\")
	if(player.hasCock()) {
		if(player.cocks[x].cockLength <= 4) size = 0;
		else if(player.cockThatFits(rubiCapacity()) >= 0) size = 1;
		else size = 2;
	}
	else {
		if(player.clitLength <= 4) size = 0;
		else if(player.clitLength <= 12 || flags[HYPER_HAPPY]) size = 1;
		else size = 2;
	}
	if(size == 0) {
		outputText("\n\n\"<i>Oh, not packing much here, hm?</i>\"  Rubi asks, smiling, \"<i>");
		if(flags[RUBI_COCK_SIZE] <= 5) outputText("I guess we're in the same boat.</i>\"");
		else if(rubiBimbo() && flags[RUBI_DEBIMBO] == 0) outputText("That's too bad, I was soooo looking forward to a real fucking.</i>\"");
		else outputText("That's pretty sad, getting shown up by a dainty little thing like me...</i>\"");
	}
	
	else if(size == 1) outputText("\n\n\"<i>Oh wow, you're quite the stud,</i>\" Rubi says, eyes sparkling with anticipation.");
	//(If too big, dick/clit area above 24) 
	else outputText("\n\n\"<i>Oh by Marae... there's no way I could fit this inside me... but there are other things we can do with this.</i>\"");
	
	outputText("\n\nRelinquishing the hold on your ");
	if(player.hasCock()) outputText("cock");
	else outputText("clit");
	outputText(", Rubi slips off your lap and kneels on the floor.  " + rubiMF("He","She") + " pauses a moment, taking in your ");
	if(player.hasCock()) outputText(cockDescript(x));
	else outputText("[clit]");
	outputText(" with " + rubiMF("his","her") + " eyes before leaning in and giving it a tentative lick, which sends a shiver up your spine.  Seeing that, " + rubiMF("he","she") + " gives a little smile and licks again, running " + rubiMF("his","her") + " smooth tongue all along the length of your ");
	if(player.hasCock()) outputText("swollen member");
	else outputText("impressive love button");
	outputText(".  Rubi's mouth dances along its length, at times flicking delicately and at others slurping loudly.  " + rubiMF("His","Her") + " tongue ripples along the underside of ");
	if(player.hasCock()) outputText("your cockhead");
	else outputText("the tip of your clit");
	outputText(", sending shivers of pleasure up your spine.");
	//(If Cock) 
	if(player.hasCock()) outputText("  Amazingly, with the expert ministrations of your lover's mouth, you can't hold yourself in much longer, and begin to tense up, but at the last minute you pull yourself away from Rubi's grip and lips, halting yourself before you can cum.");
	
	//(These two paragraphs for cocks under 24 area)
	if(size < 2) {
		//(Normal/Incubus Rubi) 
		outputText("\n\nFiguring " + rubiMF("he","she") + "'s had enough time in charge, you stand and get behind Rubi, pushing " + rubiMF("him","her") + " so that " + rubiMF("his","her") + " chest and head are resting on the edge of the bed.  You lift " + rubiMF("his","her") + " tail and place your ");
		if(player.hasCock()) outputText(cockDescript(x));
		else outputText("[clit]");
		outputText(" at " + rubiMF("his","her") + " tight ");
		if(flags[RUBI_NO_CUNT] > 0) outputText("tailhole");
		else outputText("pussy");
		outputText(", rubbing the mixture of " + rubiMF("his","her") + " saliva and your juices into " + rubiMF("his","her") + " cleft to get " + rubiMF("him","her") + " suitably lubricated before the real fun begins");
		if(rubiBimbo()) outputText(", not that " + rubiMF("he","she") + " needs the extra lubrication, as " + rubiMF("he","she") + "'s practically dripping like a faucet");
		outputText(".");
		outputText("  You press forward, sinking your entire length into Rubi's depths, which clench and unclench sensually.  Aided by the additional lubrication, you slip easily in and out, pumping slowly at first.");
	}
	//(These two paragraphs for cocks over 24 area)
	else {
		outputText("\n\nFiguring " + rubiMF("he","she") + "'s had enough time in charge, you stand and get behind Rubi, pushing " + rubiMF("him","her") + " so that " + rubiMF("his","her") + " chest and head are resting on the edge of the bed.  You lift " + rubiMF("his","her") + " tail, press " + rubiMF("his","her") + " legs together, and place your ");
		if(player.hasCock()) outputText(cockDescript(x));
		else outputText("[clit]");
		outputText(" at the space just below " + rubiMF("his","her") + " ");
		if(flags[RUBI_NO_CUNT] > 0) outputText("balls");
		else outputText("cunt");
		outputText(", rubbing the mixture of " + rubiMF("his","her") + " saliva and your juices into " + rubiMF("his","her") + " legs to get " + rubiMF("him","her") + " suitably lubricated before the real fun begins");
		//(if bimbo)
		if(rubiBimbo()) outputText(", not that " + rubiMF("he","she") + " needs the extra lubrication, as she's practically dripping like a faucet, which dribbles down " + rubiMF("his","her") + " legs suitably enough");
		outputText(".");
		outputText("\n\nYou press forward, your enormous ");
		if(player.hasCock()) outputText(cockDescript(x));
		else outputText("[clit]");
		outputText(" slipping between Rubi's thighs, which grip you tightly.  You feel " + rubiMF("his","her") + " ");
		if(flags[RUBI_COCK_SIZE] > 0) outputText("hard cock");
		else outputText("stiff clit");
		outputText(" pressing against the top of ");
		if(player.hasCock()) outputText("your dick");
		else outputText("your clit");
		outputText(", and know that with every thrust you give, " + rubiMF("he","she") + "'ll get a good thrill too.");
	}
	outputText("\n\nThrusting deeper and deeper, you pick up the pace slowly.  Rubi clutches at the blankets, eyes closed, biting " + rubiMF("his","her") + " lip.");
	//(If Orgasm Denial is activated)
	if(flags[RUBI_ORGASM_DENIAL] > 0 && !rubiBimbo()) outputText("  You give Rubi's ass a hard smack and remind " + rubiMF("him","her") + " that no matter what happens, " + rubiMF("he","she") + " still can't cum yet.  " + rubiMF("His","Her") + " eyes flutter open and " + rubiMF("he","she") + " actually whimpers a little, but can't form the words to object.");
	//(If Orgasm Denial is NOT activated; male/herm Rubi) 
	else if(flags[RUBI_COCK_SIZE] > 0) outputText("  Rubi’s body shivers and trembles, and almost collapses.  " + rubiMF("He","She") + " grasps at the blankets with wild abandon as ropes of pearly white cum erupt from " + rubiMF("his","her") + " cock, splattering against " + rubiMF("his","her") + " chest and the blankets.");
	//(Female Rubi)
	else outputText("  Rubi's body shivers and trembles, and " + rubiMF("he","she") + " almost collapses.  " + rubiMF("He","She") + " grasps at the blankets with wild abandon and gives and orgasmic scream as " + rubiMF("his","her") + " cunt clenches and unclenches fiercely.  A spray of femjuices erupts outwards from " + rubiMF("him","her") + ", coating your crotch and dripping down both yours and " + rubiMF("his","her") + " legs.");

 
	outputText("\n\nYou keep this up for as long as you can, steeling yourself until you just can't take any more.  With a final, deep thrust, you groan and let your mind blank as the orgasm overtakes you.  ");
	//(Player has cock under 24 area?) 
	if(player.hasCock() && player.cockArea(x) <= rubiCapacity()) {
		outputText("Your " + cockDescript(x) + " engorges for a second before erupting deep inside your demonic little fucktoy.  ");
		if(player.cumQ() < 250) outputText("Cum dribbles out from " + rubiMF("his","her") + " hole as you give a couple extra thrusts.");
		else if(player.cumQ() < 1000) outputText("A generous amount of cum trickles from " + rubiMF("his","her") + " depths as you give a couple extra thrusts.");
		else if(player.cumQ() < 2000) {
			outputText("Cum practically floods from  " + rubiMF("his","her") + " abused ");
			if(flags[RUBI_NO_CUNT] > 0) outputText("ass");
			else outputText("cunt");
			outputText(" as you give a couple extra thrusts.");
		}
	}
	else if(player.hasCock()) {
		outputText("Your " + cockDescript(x) + " engorges for a second before erupting beneath Rubi, splattering " + rubiMF("him","her") + " and the blankets ");
		if(player.cumQ() < 250) outputText("with a fair amount of your seed.");
		else if(player.cumQ() < 1000) outputText("with a generous amount of your spunk.");
		else outputText("with a veritable torrent of potent pearlescent spooge.");
	}
	//(Player has clit?) 
	else outputText("  Your " + clitDescript() + " throbs and engorges briefly as your " + vaginaDescript(0) + " reflexively contracts and a warm feeling rocks through your entire body.  Femjuices run down your [legs] and relief overtakes you like a powerful wave upon a beach.");
	
	outputText("\n\nYou stumble backwards, pulling your " + cockClit(x) + " out of Rubi and collapse on the bed next to " + rubiMF("him","her") + ".  " + rubiMF("He","She") + " cuddles up next to you, in a mixed puddle of spunk, and hugs you close.  \"<i>That was absolutely fantastic babe,</i>\" " + rubiMF("he","she") + " murmurs before drifting off into a sex-filled dreamland.");
	
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
	else if(flags[RUBI_COCK_SIZE] > 0) {
		outputText("\n\n" + rubiMF("His","Her") + " body shudders and convulses, and " + rubiMF("his","her") + " ");
		if(!rubiIncubus()) outputText("little cock");
		else outputText("demonic cock");
		outputText(" twitches, launching jets of cum onto " + rubiMF("his","her") + " stomach, chest and face.  In " + rubiMF("his","her") + " sex-filled stupor, " + rubiMF("he","she") + " eagerly swallows down whatever lands in " + rubiMF("his","her") + " mouth, and actually uses " + rubiMF("his","her") + " fingers to collect the rest , gulping that down as well.");
	}
	//(Bimbo Rubi)
	else {
		outputText("\n\n" + rubiMF("His","Her") + " body shudders and convulses, and though you can't see or feel it, you're confident " + rubiMF("his","her") + " pussy is clenching down tightly on the dildo, as it suddenly becomes very hard to thrust into " + rubiMF("him","her") + " with it.  With an orgasmic scream of \"<i>Oh yes!  Yes!</i>\"  and a spray of femjuices, Rubi collapses, exhausted.");
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
	if(flags[RUBI_COCK_SIZE] > 0) {
		outputText("Having something quite different in mind, you order Rubi to strip down.  With a curious look on " + rubiMF("his","her") + " face, " + rubiMF("he","she") + " does so, slowly.  Each garment " + rubiMF("he","she") + " peels from " + rubiMF("his","her") + " soft ");
		if(flags[RUBI_SKIN] == 0) outputText("pale");
		else if(flags[RUBI_SKIN] == 2) outputText("fur-covered");
		else outputText("red");
		outputText(" skin seems to take an eternity, until finally " + rubiMF("he","she") + "'s standing in front of you in naught but " + rubiMF("his","her") + " panties.");
		outputText("  " + rubiMF("His","Her") + " " + rubiCock() + " seems to strain at the panties, aching to be let free.  Standing, you move behind Rubi and sensually whisper into " + rubiMF("his","her") + " ear, nibbling and kissing " + rubiMF("his","her") + " neck between words.  You tell " + rubiMF("him","her") + " that, until you specify otherwise, " + rubiMF("he","she") + " is not to cum under any circumstances.  If " + rubiMF("he","she") + " does, " + rubiMF("he","she") + "'ll be severely punished.  Rubi visibly gulps and nods " + rubiMF("his","her") + " assent.");
		
		//(Taller than 5') 
		if(player.tallness > 60) outputText("\n\nYou smile and let your hands drape over Rubi's shoulders, letting your fingers trace invisible lines all along " + rubiMF("his","her") + " tender chest and stomach.  One hand casually takes hold of a nipple, while the other drifts downwards, grasping the growing bulge in " + rubiMF("his","her") + " panties.");
		//(Under 5')
		else outputText("\n\nYou smile and wrap your arms around Rubi's midsection, letting your fingers trace invisible lines all along " + rubiMF("his","her") + " tender chest and stomach.  One hand casually reaches up and takes hold of a nipple, while the other drifts downwards, grasping at the growing bulge in " + rubiMF("his","her") + " panties.");
		
		//(Normal Rubi) 
		outputText("\n\n\"<i>Ahh, not there,</i>\" Rubi gasps.  Your hand grips " + rubiMF("him","her") + " tight, making " + rubiMF("him","her") + " give a little yelp.");
		
		outputText("\n\nYou kneel down behind your little demon toy, and make " + rubiMF("him","her") + " bend over so that " + rubiMF("his","her") + " hands rest on the couch.");
		//(Normal Rubi)
		outputText("  " + rubiMF("He","She") + " blushes, looking back at you with a curious, yet lustful expression.  " + rubiMF("He","She") + " gulps and lifts " + rubiMF("his","her") + " tail, giving you free access to " + rubiMF("his","her") + " pantied rump.");
		outputText("\n\nGrasping " + rubiMF("his","her") + " panties firmly you shimmy them down until they're at " + rubiMF("his","her") + " ankles.  " + rubiMF("He","She") + " steps out of them, and, a moment after the thought crosses your mind, you immediately shove them into Rubi's mouth.  " + rubiMF("He","She") + " mumbles " + rubiMF("his","her") + " objections, but doesn't remove them.");
		
		outputText("\n\nWith Rubi's bare ass laid out in front of you, it takes all your willpower not to just bury your face in it.  But you stand fast, and take care to remember your plans.  Instead, you wrap your fingers carefully around " + rubiMF("his","her") + " stiffening manhood.  You grip it tight, feeling " + rubiMF("his","her") + " pulse run through it.  With slow, steady movements you begin to stroke.");
		outputText("\n\n\"<i>Nnng,</i>\" Rubi grunts, gripping the couch cushions.  You make sure to remind " + rubiMF("him","her") + " " + rubiMF("he","she") + " can't cum under any circumstances.  " + rubiMF("He","She") + " nods, and says, \"<i>Y—Yes " + player.mf("sir","miss") + ".</i>\"");
		
		outputText("\n\nSlightly quickening the pace of your strokes, you also lean in, resting your nose right against Rubi's tail, with your lips against " + rubiMF("his","her") + " tight butthole.  You let your tongue out, letting it run circles around " + rubiMF("his","her") + " ring.  You pull away, marveling at how the saliva makes " + rubiMF("his","her") + " puckering hole look like a jewel in the rough.");
		
		outputText("\n\nAllowing a devious smile to cross your face, you extend two fingers and place them at Rubi's now wet entrance and slide them in.  A look of surprise briefly flashes over " + rubiMF("his","her") + " face, but it's replaced by a satisfied smile.  You curve your fingers down, searching for " + rubiMF("his","her") + " prostate.  " + rubiMF("He","She") + " suddenly jerks and his dick stiffens even more in your hand, and you know you've found it.  Your fingers rub little circles in it, Rubi squirming with every loop.");
		
		outputText("\n\n\"<i>Aah, " + player.mf("sir","miss") + ", I can't take much more of this,</i>\" " + rubiMF("he","she") + " says, half way between a whisper and a moan.");
		
		outputText("\n\nYou give " + rubiMF("his","her") + " cock a squeeze and remind " + rubiMF("him","her") + " that if " + rubiMF("he","she") + " cums, " + rubiMF("he","she") + "'s in for a punishment.  " + rubiMF("He","She") + " gulps and nods, closing " + rubiMF("his","her") + " eyes.  " + rubiMF("His","Her") + " whole body seems to stiffen.  " + rubiMF("He","She") + "'s right, " + rubiMF("he","she") + " really can't take much more of this.  You take this cue to pull your fingers out and relinquish your hold on Rubi's penis.  " + rubiMF("He","She") + " sighs and almost collapses onto the couch.");
		outputText("\n\nYou lick your fingers clean of " + rubiMF("his","her") + " pre-cum and kiss " + rubiMF("him","her") + ", letting " + rubiMF("him","her") + " taste " + rubiMF("his","her") + " own juices.  Then you tell " + rubiMF("him","her") + " that " + rubiMF("he","she") + "'s not to masturbate in any way until you allow " + rubiMF("him","her") + " " + rubiMF("his","her") + " release.");
		
		outputText("\n\nWith your devious fun accomplished, you stand, make yourself look presentable, and head out the door.  Your last sight of Rubi is that of " + rubiMF("him","her") + " sitting on the couch with a pitiful look on " + rubiMF("his","her") + " face as " + rubiMF("he","she") + " eyes " + rubiMF("his","her") + " raging erection.");
		if(flags[RUBI_ORGASM_DENIAL] > 0) flags[RUBI_BLU_BALLS]++;
	}
	//Girl Rubi!
	else {
		outputText("\n\nHaving something quite different in mind, you order Rubi to strip down.  With a curious look on " + rubiMF("his","her") + " face, " + rubiMF("he","she") + " does so, eagerly.  Each garment " + rubiMF("he","she") + " peels from " + rubiMF("his","her") + " soft ");
		if(flags[RUBI_SKIN] == 0) outputText("pale");
		else if(flags[RUBI_SKIN] == 1) outputText("crimson");
		else if(flags[RUBI_SKIN] == 2) outputText("furred");
		else outputText("striped");
		outputText(" skin seems to take an eternity.  In fact, " + rubiMF("he","she") + " seems to take great delight in stripping, giving little twirls and tossing " + rubiMF("his","her") + " clothes towards you, until " + rubiMF("he","she") + "'s standing in front of you in naught but " + rubiMF("his","her") + " birthday suit.");
		outputText("\n\"" + rubiMF("His","Her") + " snatch glistens with arousal, which doesn't surprise you.  " + rubiMF("He","She") + " seems to be horny 24/7 nowadays.  Standing, you move behind Rubi and sensually whisper into " + rubiMF("his","her") + " ear, nibbling and kissing between words.  You tell " + rubiMF("him","her") + " that, until you specify otherwise, " + rubiMF("he","she") + " is not to cum under any circumstances.  And if " + rubiMF("he","she") + " does, there will be serious consequences.  " + rubiMF("He","She") + " giggles, but nods " + rubiMF("his","her") + " assent.");
		//(Taller than 5') 
		if(player.tallness > 60) outputText("\n\nYou smile and let your hands drape over Rubi's shoulders, letting your fingers trace invisible lines all along " + rubiMF("his","her") + " " + rubiBreasts() + " and stomach.  One hand casually takes hold of a nipple, while the other drifts downwards, slipping into her soft, delicate folds.");
		//(Under 5') 
		else outputText("\n\nYou smile and wrap your arms around Rubi's midsection, letting your fingers trace invisible lines all along " + rubiMF("his","her") + " " + rubiBreasts() + " and stomach.  One hand casually reaches up and takes hold of a nipple, while the other drifts downwards, slipping into her soft, delicate folds.");
		outputText("  \"<i>Ooh, YES, right there,</i>\" Rubi gasps.  Your hand pinches " + rubiMF("his","her") + " clit tight, eliciting a yelp and a coo of pleasure at the same time.");
		
		outputText("\n\nYou kneel down behind your little " + rubiMF("demon","demoness") + " and make " + rubiMF("him","her") + " bend over so that " + rubiMF("his","her") + " hands rest on the couch.  " + rubiMF("He","She") + " looks back at you, hair wild like " + rubiMF("he","she") + "'s already been fucked several times, giving you such a look of lust that you find yourself getting turned on almost as much as " + rubiMF("he","she") + " is.  " + rubiMF("He","She") + " lifts " + rubiMF("his","her") + " tail, giving you free access to " + rubiMF("his","her") + " rump and cunt, and then waggles it in your face, like someone taunting a pet dog.  You raise a hand and bring it down onto " + rubiMF("his","her") + " pale ass with a SMACK, letting " + rubiMF("him","her") + " know just who the pet is in this situation, and smirk at " + rubiMF("him","her") + ".");
		
		outputText("\n\nWith Rubi's bare ass laid out in front of you, it takes all your willpower not to just bury your face in that delicious wet pussy.  But you stand fast, and take care to remember your plans.  Instead, you insert your thumb up into " + rubiMF("his","her") + " hungry cunt, with your index and middle fingers on either side of " + rubiMF("his","her") + " clit, rubbing it with slow, steady movements.");
		
		outputText("\n\n\"<i>Nnng,</i>\" Rubi moans, gripping the couch cushions.  You make sure to remind " + rubiMF("him","her") + " that " + rubiMF("he","she") + " can't cum under any circumstances, but before you get through the sentence, " + rubiMF("his","her") + " pussy grips your thumb tightly and a spray of fem-juices erupts, coating your hand and face.  Well, so much for that plan.  You guess trying to control the orgasms of a girl this sensitive is pretty much impossible.  But you can still tease " + rubiMF("him","her") + ".");
		
		outputText("\n\nSlightly quickening the pace of your fingers, you also lean in, resting your nose right against Rubi's tail hole, with your lips against " + rubiMF("his","her") + " muff.  You let your tongue out, letting it run rampant across " + rubiMF("his","her") + " netherlips, around your finger.  You pull away and lick your lips, marveling at the taste.");
		
		outputText("\n\nAllowing a devious smile to cross your face, you pull your free hand into a conical shape and press it into Rubi's drenched cunt.  A look of bliss crosses " + rubiMF("his","her") + " face, and you're quite certain " + rubiMF("his","her") + " eyes rolled back into " + rubiMF("his","her") + " head.  You curl your fingers together, forming a fist, and pulse it back and forth inside " + rubiMF("him","her") + ".  Meanwhile, you pull out the thumb of your other hand and put it to work on Rubi's love button, tweaking, rubbing and tormenting it mercilessly.");
		
		outputText("\n\n\"<i>Ohh gods,</i>\" Rubi says, half way between a whisper and a moan, \"<i>I'm gonna... I'm gonna ");
		if(rubiBimbo() && flags[RUBI_DEBIMBO] == 0) outputText("like, ");
		outputText("cum!</i>\"");
		
		outputText("\n\nYou push your fist in as far as it will go as Rubi's legs tremble and almost give out on " + rubiMF("him","her") + ".  An earth-shattering scream erupts from " + rubiMF("his","her") + " lips as another jet of femjuices spray out, dousing you again.  Rubi slumps forwards onto the couch, " + rubiMF("his","her") + " vaginal muscles nearly taking you with " + rubiMF("him","her") + ".  But you manage to pull your fist out before falling over with " + rubiMF("him","her") + ".");
		outputText("\n\nYou slowly lick your fingers clean and kiss " + rubiMF("him","her") + ", letting " + rubiMF("him","her") + " taste her own juices.  " + rubiMF("He","She") + " giggles and licks your face clean as well, until not a drop remains.");
		outputText("\n\nWith your devious fun accomplished, you stand, make yourself look presentable, and head out the door.  Your last sight of Rubi is that of " + rubiMF("him","her") + " sitting spread eagle on the couch with a supremely satisfied look on " + rubiMF("his","her") + " face.");
	}
	stats(0,0,0,0,0,0,5+player.lib/10,0);
	doNext(13);
}
 
//Release
function releaseRubi():void {
	clearOutput();
	//Will deactivate Orgasm Denial.  To start Denying again, the PC will have to Tease.
	flags[RUBI_ORGASM_DENIAL] = 0;
	outputText("You order Rubi to strip down.  Knowing the drill, " + rubiMF("he","she") + " does so slowly.  There's no striptease, no show, " + rubiMF("he","she") + " just disrobes as quickly as possible until " + rubiMF("he","she") + "'s standing in naught but " + rubiMF("his","her") + " panties, ");
	if(flags[RUBI_COCK_SIZE] > 0) outputText("" + rubiMF("his","her") + " " + rubiCock() + " straining at the seams, trying to break free.");
	else outputText("clinging tight to " + rubiMF("his","her") + " flat little mound.");
		
	outputText("\n\nKneeling in front of " + rubiMF("him","her") + ", you grip both sides of " + rubiMF("his","her") + " undies and strip them off yourself, revealing his rock-hard cock.");
	//(If Blueballs 1-3) 
	if(flags[RUBI_BLU_BALLS] <= 3) {
		outputText("  Not to mention " + rubiMF("his","her") + " tiny balls");
		if(flags[RUBI_BALLS_TYPE] == 1) outputText(", trapped in their little sissy sack");
		outputText(", which you think have swelled somewhat, although you haven't been teasing " + rubiMF("him","her") + " long.");
	}
	//(if Blueballs 4-9) 
	else if(flags[RUBI_BLU_BALLS] <= 9) outputText("  Not to mention " + rubiMF("his","her") + " sizeable balls, which seem to have swelled up to twice their normal size, thanks to your relentless teasing.  They even have a slight bluish tinge to them, although it's not immediately visible.");
	else outputText("  Not to mention " + rubiMF("his","her") + " enormous balls, which, thanks to your endless teasing, are seemingly the size of baseballs.  They even have a noticeable blue tinge to them, obviously aching for relief.");
	
	outputText("\n\nYou direct " + rubiMF("him","her") + " to sit on the nearby coffee table, and " + rubiMF("he","she") + " does so.  Wrapping your fingers around " + rubiMF("his","her") + " member, you begin to stroke it slowly, reminding " + rubiMF("him","her") + " that " + rubiMF("he","she") + " can't cum.  " + rubiMF("He","She") + " whimpers but nods.  You can tell " + rubiMF("he","she") + "'s fighting " + rubiMF("his","her") + " body every step of the way, eager for the release that only your command can bring.");
	
	outputText("\n\nBut that's not going to happen yet.  You've still got a lot of work to do.  Without removing your grip on " + rubiMF("him","her") + ", you push " + rubiMF("him","her") + " back so that " + rubiMF("he","she") + "'s lying on the table, " + rubiMF("his","her") + " legs dangling off the end.  You take two fingers, collect some pre-cum that's dribbling down " + rubiMF("his","her") + " cock and your hand, and massage it into the tight little tailhole behind " + rubiMF("his","her") + " ");
	if(flags[RUBI_BLU_BALLS] <= 3) outputText("swollen");
	else if(flags[RUBI_BLU_BALLS] <= 9) outputText("slightly blue");
	else outputText("incredibly swollen blue");
	outputText(" balls.  Once it's properly lubed up, you press two fingers inside.");
	
	outputText("\n\nRubi's face contorts briefly into an expression of surprise, which quickly morphs into lust.  " + rubiMF("He","She") + " pants loudly, tongue out.  Behind the ever growing lust present in " + rubiMF("his","her") + " face, however, you see supreme concentration.  No matter what, " + rubiMF("he","she") + "'s determined not to let you down.  If you told " + rubiMF("him","her") + " he couldn't cum ever again, you're certain " + rubiMF("he","she") + "'d take it to heart and " + rubiMF("he","she") + "'d never let it happen.  Good thing for " + rubiMF("him","her") + " you're not THAT cruel.");
	
	outputText("\n\nYour fingers worm around inside " + rubiMF("him","her") + ", searching for the ");
	if(flags[RUBI_COCK_SIZE] > 0) outputText(rubiMF("P-spot","G-spot"));
	else outputText("most sensitive spot");
	outputText(".  When Rubi jerks and wiggles involuntarily, you know you've found it.  Pre-cum begins leaking from Rubi's " + rubiCock() + " in copious amounts, running down your hand and arms, and forming a puddle on the coffee table.  Rubi's body trembles and shakes, wriggling on the table like a fish out of water.");
 
 	outputText("\n\nFeeling a little more adventurous, you slip a third finger into the little demon " + rubiMF("boy","girl") + "'s rectum.  With all three fingers you press and massage " + rubiMF("his","her") + " prostate, increasing the amount of pre-cum flowing from " + rubiMF("his","her") + " tip.");
 	outputText("\n\nFinally, you think you've had enough.  You retrieve your fingers from " + rubiMF("his","her") + " ass and cup " + rubiMF("his","her") + " balls instead, squeezing them until Rubi squeaks in discomfort.  You pump " + rubiMF("his","her") + " cock faster, and order " + rubiMF("him","her") + " to cum, squeezing " + rubiMF("his","her") + " balls with every word.");
	outputText("\n\nRelief crosses Rubi's face, followed by arousal.  " + rubiMF("He","She") + "'s been waiting for this moment for a long time.  You give " + rubiMF("his","her") + " balls another squeeze and " + rubiMF("his","her") + " lips form a tight O as a rope of cum lances outwards, flying up before splattering onto " + rubiMF("his","her") + " chest.");
	//(Blueballs 1-3) 
	if(flags[RUBI_BLU_BALLS] <= 3) outputText("  It's quickly followed by another, less forceful jet of pearly white cum, which lands on " + rubiMF("his","her") + " face, and several even smaller jets which splatter the area around " + rubiMF("him","her") + ".  " + rubiMF("His","Her") + " cock twitches and spasms, then slowly softens.");
	//(Blueballs 4-5) 
	else if(flags[RUBI_BLU_BALLS] <= 5) outputText("  It's quickly followed by another, less forceful jet of pearly white cum, then another, and another, each landing closer to " + rubiMF("his","her") + " face.  Finally, it gives a few more token jerks, spurting out tiny globules of cum onto the surrounding area.  " + rubiMF("His","Her") + " cock twitches and spasms, squirting nothing but air, as if " + rubiMF("his","her") + " body is still craving release.");
	//(Blueballs 6-7) 
	else if(flags[RUBI_BLU_BALLS] <= 7) outputText("  It's quickly followed by another, more forceful jet of pearly white cum which splatters against the ceiling, dripping down onto the both of you.  Another spurt of cum bursts forth, then another, and another, each one liberally covering Rubi's stomach, chest and face.  " + rubiMF("His","Her") + " cock finally gives a few last twitches and spasms, squirting nothing but air, as if " + rubiMF("his","her") + " body is still craving release.");
	//(Blueballs 8-9) 
	else if(flags[RUBI_BLU_BALLS] <= 9) outputText("  It's quickly followed by another, more forceful jet of pearly white cum, which splatters against the ceiling, dripping down onto the both of you, and then another, and another.  It isn't long before the ceiling has a huge white cum-covered blotch right above you, drizzling down on you like dew dripping from trees.  Rubi's cock doesn't stop there, however, it continues twitching and spurting " + rubiMF("his","her") + " seed until " + rubiMF("he","she") + " is completely covered in the stuff.  Finally, mercifully, it ends, though " + rubiMF("his","her") + " " + rubiCock() + " continues to spasm, squirting nothing but air, as if " + rubiMF("his","her") + " body is still craving release.");
	//(Blueballs 10+) 
	else outputText("  It's quickly followed by another, more powerful jet of pearly white cum, which splatters against the ceiling, dripping down onto the both of you, and then another, and another.  It isn't long before the ceiling has a huge white cum-covered blotch right above you, drizzling down on you like dew dripping from the trees.  Rubi's cock doesn't stop there, however, it continues twitching and spurting " + rubiMF("his","her") + " seed, liberally covering " + rubiMF("him","her") + "self, you and the surrounding area until everything appears to be in a white haze.");
	
	outputText("\n\nRubi's body visibly relaxes and " + rubiMF("his","her") + " limbs go limp, along with " + rubiMF("his","her") + " cock, albeit more slowly.  You lick your hands clean and give Rubi a sloppy smooch, to which " + rubiMF("he","she") + " coos thankfully.  The release " + rubiMF("he","she") + " so desired achieved, " + rubiMF("he","she") + " drifts off into an orgasm-induced dream.");
	
	outputText("\n\nYou stand and decide to let " + rubiMF("him","her") + " sleep.  ");
	//(Blueballs 1-5) 
	if(flags[RUBI_BLU_BALLS] <= 5) outputText("You clean yourself up, leave Rubi a little \"<i>See you next time</i>\" note, and head out the door, back to camp.");
	//(Blueballs 6-9) 
	else if(flags[RUBI_BLU_BALLS] <= 9) outputText("You head into the bathroom and wash the cum off you, taking a short shower.  Afterwards, you dry up, leave Rubi a little \"<i>See you next time</i>\" note, and head out the door, back to camp.");
	//(Blueballs 10+) 
	else outputText("You head into the bathroom and wash the cum off you, no easy feat to be sure.  Afterwards, you dry up, leave Rubi a little \"<i>See you next time</i>\" note, and head out the door, back to camp.  You certainly don't want to be there when " + rubiMF("he","she") + " wakes up, lest you have to clean the entire house with " + rubiMF("him","her") + ".");
	rubiAffection(flags[RUBI_BLU_BALLS]);
	flags[RUBI_BLU_BALLS] = 0;
	flags[RUBI_ORGASM_DENIAL] = 0;
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
	simpleChoices("Interrupt",interruptTheNTRsYouCrazyFool,"Watch n Wait",waitAndGetNTRedLikeTheBoyBitchYouAre,"",0,"",0,"",0);
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
	doNext(NTRbimboBitchResolution);
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
	doNext(NTRbimboBitchResolution);
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
	simpleChoices("No",noBimboNTR,"Yes",yesBimboNTR,"Break Up",breakUpWithRubi,"Pimp",pimpOutRubi,"",0);
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
//Offer
//First Time:
//	Rubi gestures to some bottles and a box from the bakery before mentioning, \"<i>You look awful tense, babe.  I know you've got it hard out there, and well, I-I thought maybe I could really pamper you today, if you'd like.</i>\"
//Repeat:
//	Rubi nods towards the bottles and box in the corner and gives you a sly wink.  \"<i>Want another massage?</i>\"

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
	
//Closet
function goInRubisClosetSoThatYouCanComeOutOfTheCloset():void {
	clearOutput();
	outputText("You ask to see Rubi's wardrobe.  " + rubiMF("His","Her") + " eyes light up and " + rubiMF("he","she") + " claps " + rubiMF("his","her") + " hands together excitedly.  \"<i>");
	if(rubiBimbo() && flags[RUBI_DEBIMBO] == 0) outputText("Oh my god!  ");
	outputText("Really?  It's right over here!</i>\"  Rubi clasps your hand and drags you into the bedroom, then through another doorway.");
	outputText("\n\nYou struggle to keep your jaw from hitting the floor.  Rubi's closet must be the size of " + rubiMF("his","her") + " bedroom!  Various pants, blouses, dresses, bottoms, and tops hang from racks on either side of the room, under which are small dressers or racks of shoes of all types.  Flats, heels, boots, ballet slippers.  Almost any shoe imaginable seems to be here, in any color possible.  The majority of the opposite wall is taken up by an enormous vanity table, with a large ornate mirror and more cosmetics covering its surface than you know what to do with.  Full length mirrors are scattered around the remaining empty spaces along the wall, while the middle is left completely open.");
	
	outputText("\n\nRubi twirls around in the center of the room, clearly happy to be in here.  Before you can say anything, Rubi strips out of " + rubiMF("his","her") + " current outfit, setting it aside in a neatly folded pile before standing proud with " + rubiMF("his","her") + " hands on " + rubiMF("his","her") + " hips.  \"<i>So, you want me to wear something?</i>\"");
	//(Go To Appearance)
	menu();
	addButton(0,"Next",rubiAppearance);
	
}

//Appearance
function rubiAppearance():void {
	clearOutput();
	outputText("You look over your naked, demon-morph lover.");
	outputText("\n\nRubi is about five feet tall, with a very lithe, feminine body.  " + rubiMF("His","Her") + " skin is ");
	
	if(flags[RUBI_SKIN] == 0) outputText("pale, almost like porcelain");
	else if(flags[RUBI_SKIN] == 1) outputText("an exotic cherry red");
	else if(flags[RUBI_SKIN] == 2) outputText("covered with a fine layer of silky-smooth pink fur");
	else outputText("an exotic cherry red which contrasts well with a grey belly and stripes that run up and down " + rubiMF("his","her") + " legs and arms");
	
	if(flags[RUBI_SKIN] != 2) outputText(" and completely hairless, except for " + rubiMF("his","her") + "");
	else outputText(", and " + rubiMF("he","she") + " sports");
	
	if(flags[RUBI_HAIR_LENGTH] == 0) outputText(" short");
	else if(flags[RUBI_HAIR_LENGTH] == 1) outputText(" shoulder-length");
	else outputText(" long");
	if(flags[RUBI_HAIR] == 0) outputText(" black");
	else outputText(" blonde");
	outputText(" hair, which " + rubiMF("he","she") + " keeps cut in a cute, feminine style.  Rubi's face is soft and rounded");
	if(flags[RUBI_WHISKERS] > 0) outputText(", with a cute set of whiskers sprouting from " + rubiMF("his","her") + " cheeks");
	outputText(", " + rubiMF("his","her") + " lips painted a ");
	//(normal/furry skin)
	if(flags[RUBI_SKIN] == 0 || flags[RUBI_SKIN] == 2) outputText("crimson red");
	//(red/siren skin)
	else outputText("dusky black");
	outputText(", " + rubiMF("his","her") + " ");
	if(flags[RUBI_EYE_TYPE] == 1) outputText("slitted ");
	if(flags[RUBI_EYE_TYPE] == 0 || rubiBimbo()) outputText("green");
	else if(flags[RUBI_EYE_TYPE] == 1) outputText("purple");
	else outputText("black");
	outputText(" eyes framed with eyeliner, belying " + rubiMF("his","her") + " masculine origins.  ");
	if(flags[RUBI_HORNTYPE] > 0) outputText("Two tiny horns extend upwards from " + rubiMF("his","her") + " hairline, solid black in color.  ");
	outputText("A pair of ");
	if(flags[RUBI_EAR_TYPE] == 0) outputText("cute, normal ears protrude from the sides of " + rubiMF("his","her") + " head, each one pierced with a small dangling earring");
	else if(flags[RUBI_EAR_TYPE] == 1) outputText("cute, cat-like ears pop up from the top of " + rubiMF("his","her") + " head, each one seemingly able to move independently");
	else if(flags[RUBI_EAR_TYPE] == 2) outputText("feathered ears protrude from the sides of " + rubiMF("his","her") + " head, each one fluttering cutely from time to time, and each pierced with a small dangling earring");
	outputText(".");
	
	outputText("\n\n" + rubiMF("He","She") + " has a ");
	if(flags[RUBI_BREAST_SIZE] < 1) outputText("flat-chest ");
	else outputText(rubiBreasts());
	outputText(" supporting two perky ");
	if(flags[RUBI_NIPPLE_TYPE] == 1) outputText("black ");
	outputText("nipples.");

	outputText("\n\nBetween " + rubiMF("his","her") + " legs is a ");
	if(flags[RUBI_COCK_SIZE] > 0) {
		outputText(rubiCock() + ", which starts to perk up under your scrutiny, under which sways a set of ");
		if(flags[RUBI_BLU_BALLS] >= 4 && flags[RUBI_BLU_BALLS] < 9) outputText("cum-swollen ");
		else if(flags[RUBI_BLU_BALLS] >= 9) outputText("engorged, blue-tinged ");
		outputText("testicles");
		if(flags[RUBI_BALLS_TYPE] == 1) outputText(", which cling tight to " + rubiMF("his","her") + " body in a cute spherical pouch");
	}
	if(flags[RUBI_COCK_SIZE] > 0 && flags[RUBI_NO_CUNT] == 0) outputText(" and a ");
	if(flags[RUBI_NO_CUNT] == 0) {
		outputText("cute ");
		if(flags[RUBI_CUNTTYPE] > 0) outputText("black ");
		outputText("pussy topped off by a little love button");
		outputText(".  Though you can't see it, you know Rubi's got a perfect little asshole, between " + rubiMF("his","her") + " buttcheeks, right where it belongs.");
	}
	
	outputText("\n\nSwaying behind " + rubiMF("him","her") + " is a red spaded tail, which coils around " + rubiMF("his","her") + " leg occasionally.  ");
	if(flags[RUBI_FEET] == 1) outputText("Finally, Rubi stands on a long black spike that makes " + rubiMF("him","her") + " walk as though " + rubiMF("he","she") + " were wearing high heels.");
	
	//[Give Item] [Get Dressed] [Back]
	menu();
	addButton(0,"Give Item",pickAnItemToFeedRubi);
	addButton(1,"Get Dressed",playDressUp);
	addButton(4,"Back",rubisFuckingHouseYouPervert);
}

//Get Dressed
function playDressUp():void {
	clearOutput();
	outputText("You look over Rubi's vast collection of clothes.  What outfit would you like Rubi to put on?\n\n");
	menu();
	var closet:Array = new Array();
	var buttonNames:Array = new Array();
	if(flags[RUBI_SUITCLOTHES] == 1) {
		closet[closet.length] = "Suitclothes";
		buttonNames[buttonNames.length] = "Suit";
	}
	if(flags[RUBI_FETISH_CLOTHES] == 1) {
		closet[closet.length] = "Rubber Fetish Clothes";
		buttonNames[buttonNames.length] = "Rubber";
	}
	if(flags[RUBI_GREEN_ADVENTURER] == 1) {
		closet[closet.length] = "A Green Adventurer's Outfit";
		buttonNames[buttonNames.length] = "Green Outfit";
	}
	if(flags[RUBI_TUBE_TOP] == 1) {
		closet[closet.length] = "A Tube Top";
		buttonNames[buttonNames.length] = "Tube Top";
	}
	if(flags[RUBI_BODYSUIT] == 1) {
		closet[closet.length] = "A Sheer Bodysuit";
		buttonNames[buttonNames.length] = "Bodysuit";
	}
	if(flags[RUBI_LONGDRESS] == 1) {
		trace("PRE-CRASH");
		closet[closet.length] = "A Long Dress";
		buttonNames[buttonNames.length] = "Long Dress";
	}
	if(flags[RUBI_TIGHT_PANTS] == 1) {
		closet[closet.length] = "A Dashing Outfit With Tight Leather Pants";
		buttonNames[buttonNames.length] = "DashingOutfit";
	}
	if(flags[RUBI_NURSE_CLOTHES] == 1) {
		closet[closet.length] = "Nurse's Clothes";
		buttonNames[buttonNames.length] = "Nurse'sClothes";
	}
	//(Slutty Swimwear (Normal))
	if(flags[RUBI_SWIMWEAR] == 1) {
		closet[closet.length] = "Slutty Swimwear";
		buttonNames[buttonNames.length] = "Swimwear";
	}
	if(flags[RUBI_BIMBO_MINIDRESS] == 1) {
		closet[closet.length] = "A Bimbo Minidress";
		buttonNames[buttonNames.length] = "Bimbo Dress";
	}
	if(flags[RUBI_BONDAGE_STRAPS] == 1) {
		closet[closet.length] = "Bondage Straps";
		buttonNames[buttonNames.length] = "Bondage Straps";
	}
	if(flags[RUBI_INQUISITORS_CORSET] == 1) {
		closet[closet.length] = "An Inquisitor's Corset";
		buttonNames[buttonNames.length] = "Corset";
	}
	//RIsque waitress uniform
	if(flags[RUBI_AFFECTION] >= 100) {
		closet[closet.length] = "A Risque Waitress's Uniform";
		buttonNames[buttonNames.length] = "RisqueUniform";
	}
	if(closet.length > 0) {
		outputText("<b>Rubi's Closet Contains:</b>\n");
		temp = 0;
		while(temp < closet.length) {
			outputText(closet[temp] + "\n");
			temp++;
		}
		outputText("\n");
	}
	var button:int = 0;
	trace("STARTING LOOP");
	while(button < 9 && button < closet.length) {
		if(button < 8 || closet.length < 9) addButton(button,buttonNames[button],dressUpRouter,closet[button]);
		else addButton(8,"More",playDressUp2);
		trace("LOOPED ONCE");
		button++;
	}
	addButton(9,"Back",rubiAppearance);
}
function playDressUp2():void {
	clearOutput();
	outputText("You look over Rubi's vast collection of clothes.  What outfit would you like Rubi to put on?\n\n");
	menu();
	var closet:Array = new Array();
	var buttonNames:Array = new Array();
	if(flags[RUBI_SUITCLOTHES] == 1) {
		closet[closet.length] = "Suitclothes";
		buttonNames[buttonNames.length] = "Suit";
	}
	if(flags[RUBI_FETISH_CLOTHES] == 1) {
		closet[closet.length] = "Rubber Fetish Clothes";
		buttonNames[buttonNames.length] = "Rubber";
	}
	if(flags[RUBI_GREEN_ADVENTURER] == 1) {
		closet[closet.length] = "A Green Adventurer's Outfit";
		buttonNames[buttonNames.length] = "Green Outfit";
	}
	if(flags[RUBI_TUBE_TOP] == 1) {
		closet[closet.length] = "A Tube Top";
		buttonNames[buttonNames.length] = "Tube Top";
	}
	if(flags[RUBI_BODYSUIT] == 1) {
		closet[closet.length] = "A Sheer Bodysuit";
		buttonNames[buttonNames.length] = "Bodysuit";
	}
	if(flags[RUBI_LONGDRESS] == 1) {
		closet[closet.length] = "A Long Dress";
		buttonNames[buttonNames.length] = "Long Dress";
	}
	if(flags[RUBI_TIGHT_PANTS] == 1) {
		closet[closet.length] = "A Dashing Outfit With Tight Leather Pants";
		buttonNames[buttonNames.length] = "DashingOutfit";
	}
	if(flags[RUBI_NURSE_CLOTHES] == 1) {
		closet[closet.length] = "Nurse's Clothes";
		buttonNames[buttonNames.length] = "Nurse'sClothes";
	}
	//(Slutty Swimwear (Normal))
	if(flags[RUBI_SWIMWEAR] == 1) {
		closet[closet.length] = "Slutty Swimwear";
		buttonNames[buttonNames.length] = "Swimwear";
	}
	if(flags[RUBI_BIMBO_MINIDRESS] == 1) {
		closet[closet.length] = "A Bimbo Minidress";
		buttonNames[buttonNames.length] = "Bimbo Dress";
	}
	if(flags[RUBI_BONDAGE_STRAPS] == 1) {
		closet[closet.length] = "Bondage Straps";
		buttonNames[buttonNames.length] = "Bondage Straps";
	}
	if(flags[RUBI_INQUISITORS_CORSET] == 1) {
		closet[closet.length] = "An Inquisitor's Corset";
		buttonNames[buttonNames.length] = "Corset";
	}
	//RIsque waitress uniform
	if(flags[RUBI_AFFECTION] >= 100) {
		closet[closet.length] = "A Risque Waitress's Uniform";
		buttonNames[buttonNames.length] = "RisqueUniform";
	}
	if(closet.length > 0) {
		outputText("<b>Rubi's Closet Contains:</b>\n");
		temp = 0;
		while(temp < closet.length) {
			outputText(closet[temp] + "\n");
			temp++;
		}
		outputText("\n");
	}
	var button:int = 7;
	while(button-7 < 9 && button < closet.length) {
		if(button == 7) addButton(0,"Previous",playDressUp);
		else if(button <= closet.length) addButton(button-7,buttonNames[button],dressUpRouter,closet[button]);
		button++;
	}
	addButton(9,"Back",rubiAppearance);
}

function dressUpRouter(arg:String):void {
	clearOutput();
	if(arg == "Suitclothes") putOnASuitYouSlut();
	else if(arg == "A Waitress's Uniform") putRubiInAWaitressUniform();
	else if(arg == "Rubber Fetish Clothes") rubiHasARubberFetish();
	else if(arg == "A Green Adventurer's Outfit") goOnAnAnalAdventureRubiNotReallyJustAnAdventurersOutfit();
	else if(arg == "A Tube Top") putOnATubeTopYouWhore();
	else if(arg == "A Sheer Bodysuit") putOnMyBodysuitYouWhore();
	else if(arg == "A Long Dress") giveRubiALongDressToHideHerHideousBody();
	else if(arg == "A Dashing Outfit With Tight Leather Pants") putOnADashingOutfitYouWhore();
	else if(arg == "Nurse's Clothes") rubiPutsOnNursesClothesSoSheCanCheckYourTemperature();
	else if(arg == "Slutty Swimwear") putOnSluttySwimwearYouSkank();
	else if(arg == "A Bimbo Minidress") putOnADressYouBimbo();
	else if(arg == "Bondage Straps") putOnBondageStrapsYouBondageTrap();
	else if(arg == "An Inquisitor's Corset") whyTheFuckIsRubiWearingAnInquisitorsCorset();
	else if(arg == "A Risque Waitress's Uniform") putOnAWaitressUniformYouWhore();
	else if(arg == "An Adventurer's Outfit") goOnAnAnalAdventureRubiNotReallyJustAnAdventurersOutfit();

}

//Waitress Uniform
function putRubiInAWaitressUniform():void {
	clearOutput();
	outputText("You tell Rubi you'd like to see " + rubiMF("him","her") + " in the waitress uniform.  \"<i>Hm, well all right, but it's just my work clothes,</i>\" " + rubiMF("he","she") + " replies.");
	outputText("\n\nRubi starts off with a white bra trimmed with lace");
	if(flags[RUBI_BREAST_SIZE] < 1) outputText(", though it's obvious " + rubiMF("he","she") + " doesn't need it with " + rubiMF("his","her") + " flat-chest");
	outputText(".  " + rubiMF("He","She") + " slips " + rubiMF("his","her") + " arms through the holes and expertly latches the back.  Next " + rubiMF("he","she") + " takes a black garter belt and slips it up " + rubiMF("his","her") + " slender ");
	if(flags[RUBI_SKIN] != 2) outputText("hairless");
	else outputText("furred");
	outputText(" legs, until it rests snugly around " + rubiMF("his","her") + " waist.  A matching pair of sheer stockings quickly follow, held up by the garter.");
	
	if(!rubiBimbo() || flags[RUBI_DEBIMBO] > 0) outputText("\n\nYour demon-morphed lover next trots over to a chest of drawers and rummages through it until " + rubiMF("he","she") + " produces a pair of frilly pink panties, complete with a little bow on the front.  " + rubiMF("He","She") + " steps into the underwear one stocking-clad leg at a time and pulls them up until they fit snugly around " + rubiMF("his","her") + " round ass and " + rubiCock() + ".");
	else outputText("\n\nNow is when you'd expect " + rubiMF("him","her") + " to put on a pair of panties, but it seems " + rubiMF("his","her") + " bimbo-addled mind has completely forgotten them.");
	outputText("  Rubi approaches a rack of clothes, searching quietly for a moment before picking two hangars off it: a pink blouse and a matching pink skirt.");
	
	outputText("\n\nThe blouse goes on first, followed by the skirt.  Rubi only buttons the blouse about half way up");
	if(flags[RUBI_BREAST_SIZE] < 1) outputText(", showing off some of " + rubiMF("his","her") + " flat chest");
	else outputText(", showing off a generous portion of cleavage");
	outputText(", and tucks the hem of the blouse into the skirt.  Finally, Rubi selects a pair of ");
	if(flags[RUBI_FEET] == 1) outputText("what appears to be flats, with a hole in the heel for " + rubiMF("his","her") + " demonic heels");
	else outputText("short heels");
	outputText(" and slips them on.  " + rubiMF("He","She") + " gives a little twirl in the waitress uniform, and bends over several times to show off " + rubiMF("his","her") + " ");
	if(!rubiBimbo() || flags[RUBI_DEBIMBO] > 0) outputText("girly panties");
	else outputText("naked nethers");
	outputText(".");
	
	outputText("\n\n\"<i>There we go!  How do I look?</i>\"  You grin and tell " + rubiMF("him","her") + " that " + rubiMF("he","she") + " looks great, and that you never could resist a " + rubiMF("man","woman") + " in uniform.");
	
	outputText("\n\nNow that Rubi is dressed up, what do you want to do?");
	
	//[Date (go to Ice Cream date)] [Back]
	menu();
	addButton(0,"Date",dateIntro,iceCreamDate);
	addButton(4,"Back",rubiAppearance);
}
//Dashing Outfit
function putOnADashingOutfitYouWhore():void {
	clearOutput();
	outputText("You tell Rubi you'd like to see " + rubiMF("him","her") + " in the dashing outfit.  \"<i>Ohh, feeling like plundering a little booty today?</i>\" " + rubiMF("he","she") + " asks with a coy smile.");
	
	outputText("\n\nRubi starts off with what seems to be the skimpiest g-string you've ever seen.  " + rubiMF("He","She") + " steps into the tiny underwear and pulls them up, ");
	if(flags[RUBI_COCK_SIZE] > 0) outputText("tucking " + rubiMF("his","her") + " cock firmly into the triangular strip of cloth covering " + rubiMF("his","her") + " crotch, while ");
	outputText("the string gets firmly lodged between Rubi's butt cheeks.  The next thing Rubi picks out is a pair of impossibly small leather pants.  " + rubiMF("He","She") + " puts them on one leg at a time, and struggles to pull the tight pants up " + rubiMF("his","her") + " smooth thighs and shapely ass.  You get involved at some point, helping to hoist the pants up while Rubi buttons them properly.  The end result is a pair of leather pants that cling to Rubi's legs like a second skin, showing off every curve of " + rubiMF("his","her") + " ass, thighs and calves");
	if(flags[RUBI_COCK_SIZE] > 0) outputText(", not to mention the sizeable package in " + rubiMF("his","her") + " crotch");
	outputText(".");
	
	outputText("\n\nYour demon-morphed lover picks out a garment from the nigh-endless racks around you, a white silk shirt.  Foregoing the usual bra, " + rubiMF("he","she") + " slips on the shirt and, seeing as there are no buttons on it, knots up the bottom.  The outfit as a whole is damned sexy, showing off " + rubiMF("his","her") + " midriff and baring the valley running down " + rubiMF("his","her") + " " + rubiChest() + ".");
	if(flags[RUBI_COCK_SIZE] > 0) outputText("  Combined with the sizeable bulge in the crotch, Rubi looks like quite the dashing, if slutty, piratess.");
	
	outputText("\n\nNow that Rubi is dressed up, what do you want to do?");
	//[Date (go to Ice Cream date)] [Back]
	menu();
	addButton(0,"Date",dateIntro,iceCreamDate);
	addButton(4,"Back",rubiAppearance);
}

//Adventurer's Outfit
function goOnAnAnalAdventureRubiNotReallyJustAnAdventurersOutfit():void {
	clearOutput();
	outputText("You tell Rubi you'd like to see " + rubiMF("him","her") + " in the adventurer's outfit.  \"<i>Ah yes, am I going to be the Champion now?</i>\" Rubi asks, balling up " + rubiMF("his","her") + " dainty hands and putting them on " + rubiMF("his","her") + " hips.  \"<i>Rubi, Champion of Mareth!  Slayer of demons and ");
	if(silly()) outputText("collector of waifus!");
	else outputText("layer of ladies");
	outputText("!  Has a bit of a ring to it doesn't it?</i>\"  " + rubiMF("He","She") + " giggles for a moment and then gathers up the clothes.");
	
	outputText("\n\n" + rubiMF("He","She") + " starts with a simple, only slightly lacy white bra");
	if(flags[RUBI_BREAST_SIZE] < 1) outputText(", though it's obvious " + rubiMF("he","she") + " doesn't need it with " + rubiMF("his","her") + " flat-chest");
	outputText(".  " + rubiMF("He","She") + " slips " + rubiMF("his","her") + " arms through the holes and expertly latches the back.  Following that is a matching pair of panties that " + rubiMF("he","she") + " slips up " + rubiMF("his","her") + " long, smooth legs.  " + rubiMF("He","She") + " pulls them up so that they hug " + rubiMF("his","her") + " round, cute ass tightly.");
	
	outputText("\n\nThe next thing to go on is a pair of brown leggings.  Rubi rolls them up first before sitting down on the seat in front of the vanity and slips one leg in, unrolling the leggings up to the knee before doing the same with the other leg.  Then " + rubiMF("he","she") + " stands and pulls them up the rest of the way.  The way they cling to " + rubiMF("his","her") + " legs and ass just makes it look more shapely, and you can't help but lick your lips.");
	
	outputText("\n\nA dark green tunic is the last garment to go on, which Rubi simply tosses on over " + rubiMF("his","her") + " head and fastens in place with a leather belt.  " + rubiMF("He","She") + " pulls on a matching green pointed cap that tapers to a point");
	if(flags[RUBI_EAR_TYPE] == 1) outputText(", covering " + rubiMF("his","her") + " feline ears");
	outputText(".  The boots that go with the outfit are mid-calf length and made of supple, fine leather");
	if(flags[RUBI_FEET] == 1) outputText(" with a hole cut out in the heel, apparently for Rubi's demonic heels to fit through");
	outputText(".  Once those are on, Rubi completes the look by retrieving a wooden sword from somewhere while you were too distracted by " + rubiMF("his","her") + " ass.");
	
	outputText("\n\nNow that Rubi is dressed up, what do you want to do?");
	
	//[Date (go to Ice Cream date)] [Back]
	menu();
	addButton(0,"Date",dateIntro,iceCreamDate);
	addButton(4,"Back",rubiAppearance);
}

//Long Dress
function giveRubiALongDressToHideHerHideousBody():void {
	clearOutput();
	outputText("You tell Rubi you'd like to see " + rubiMF("him","her") + " in the long dress.  \"<i>Oohh, I just </i>love<i> that one! One second!</i>\" " + rubiMF("he","she") + " says as " + rubiMF("he","she") + " pulls out the dress and several accessories.");
	outputText("\n\nRubi starts with an off-pink strap-less bra");
	if(flags[RUBI_BREAST_SIZE] < 1) outputText(", despite the fact that " + rubiMF("he","she") + " clearly doesn't need one");
	outputText(", which " + rubiMF("he","she") + " expertly fastens behind " + rubiMF("him","her") + "");
	outputText(".  Next, " + rubiMF("he","she") + " takes a white garter belt and slips it up " + rubiMF("his","her") + " slender ");
	if(flags[RUBI_SKIN] != 2) outputText("hairless");
	else outputText("furred");
	outputText(" legs, until it rests snugly around " + rubiMF("his","her") + " waist.  A matching pair of white stockings quickly follow, held up by the garter.  The next thing is an off-pink pair of panties that " + rubiMF("he","she") + " slides up " + rubiMF("his","her") + " legs and pulls up so that they cling tightly to " + rubiMF("his","her") + " ample rump.");
	
	outputText("\n\nFinally Rubi takes the strapless dress into " + rubiMF("his","her") + " arms, twirling and making dancing motions for a moment before " + rubiMF("he","she") + " suddenly seems to remember you're in the room with " + rubiMF("him","her") + ".  " + rubiMF("His","Her") + " face goes scarlet");
	if(flags[RUBI_SKIN] == 1 || flags[RUBI_SKIN] == 3) outputText(" (or darkens at least)");
	outputText(", and " + rubiMF("he","she") + " returns to the task at hand.  The dress goes on neatly, and once it's in place you help to pull the strings on the built-in corset, tying them off with a neat little bow in back. To top it all off is a pair of pink pumps");
	if(flags[RUBI_FEET] == 1) outputText(" with the heels cut off and a hole for Rubi's demonic heel to fit through");
	outputText(", which " + rubiMF("he","she") + " slips on quickly.");
	outputText("\n\nAll in all, " + rubiMF("he","she") + " looks ready for a night at some kind of fancy ball.");
	outputText("\n\nNow that Rubi is dressed up, what do you want to do?");
	//[Date (go to fancy dinner date)] [Back]
	menu();
	addButton(0,"Date",dateIntro,fancyDate);
	addButton(4,"Back",rubiAppearance);
}

//Nurse's Clothes
function rubiPutsOnNursesClothesSoSheCanCheckYourTemperature():void {
	clearOutput();
	outputText("You tell Rubi you'd like to see " + rubiMF("him","her") + " in the nurse's uniform.  \"<i>Ohh, coming down with a bit of a fever?  Do you need a sponge bath?</i>\" " + rubiMF("he","she") + " says coyly, before gathering up the clothing.");
	outputText("\n\n" + rubiMF("He","She") + " starts with a simple, only slightly lacy white bra");
	if(flags[RUBI_BREAST_SIZE] < 1) outputText(", though it's obvious " + rubiMF("he","she") + " doesn't need it with " + rubiMF("his","her") + " flat-chest");
	outputText(".  " + rubiMF("He","She") + " slips " + rubiMF("his","her") + " arms through the holes and expertly latches the back.  Next " + rubiMF("he","she") + " takes a white garter belt and slips it up " + rubiMF("his","her") + " slender ");
	if(flags[RUBI_SKIN] == 2) outputText("furred ");
	else outputText("hairless ");
	outputText("legs, until it rests snugly around " + rubiMF("his","her") + " waist.  A matching pair of white fishnet stockings quickly follow, held up by the garter.  The next thing is a pair of white cotton panties that " + rubiMF("he","she") + " slides up " + rubiMF("his","her") + " legs and pulls up so that they cling tightly to " + rubiMF("his","her") + " ample rump.");
	
	outputText("\n\nNext it's time for the actual dress.  Rubi holds up the white dress for a moment before slipping it on.  The slinky white dress clings tightly to " + rubiMF("his","her") + " body, with a little red cross resting right above " + rubiMF("his","her") + " ");
	if(flags[RUBI_BREAST_SIZE] < 1) outputText("heart");
	else outputText("left breast");
	outputText(".  " + rubiMF("He","She") + " places the matching hat on " + rubiMF("his","her") + " head and adjusts it before putting on a pair of white pumps");
	if(flags[RUBI_FEET] > 0) outputText(" with the heels removed and a hole for " + rubiMF("his","her") + " demonic heels");
	outputText(".");
	
	outputText("\n\nNow that Rubi is dressed up, what do you want to do?");
	//[Date (go to ice cream date)] [Back]
	menu();
	addButton(0,"Date",dateIntro,iceCreamDate);
	addButton(4,"Back",rubiAppearance);
}

//Rubber Fetish Clothes
function rubiHasARubberFetish():void {
	clearOutput();
	outputText("You tell Rubi you'd like to see " + rubiMF("him","her") + " in the rubber fetish outfit.  \"<i>Ohoh,</i>\" " + rubiMF("he","she") + " giggles and quirks an eyebrow at you, \"</i>feeling a bit kinky are we?</i>\"");
	outputText("\n\nRubi starts off, not with any clothing, but with a small dispenser of oil and lotion.  " + rubiMF("He","She") + " takes a small handful of the stuff, which smells slightly like lilacs, rubs " + rubiMF("his","her") + " hands together and begins applying it to " + rubiMF("his","her") + " ");
	if(flags[RUBI_SKIN] != 2) outputText("skin");
	else outputText("furred body");
	outputText(", starting with " + rubiMF("his","her") + " legs and moving up to the torso and arms.  Once Rubi's ");
	if(flags[RUBI_SKIN] != 2) outputText("skin ");
	else outputText("fur ");
	outputText("glistens with the oils it's time to put on the actual clothes.  ");
	//(If Not Bimbo)
	if(!rubiBimbo() || flags[RUBI_DEBIMBO] > 0) outputText("" + rubiMF("He","She") + " first takes a pair of transparent rubber panties and slides them up " + rubiMF("his","her") + " legs until they lovingly cling around " + rubiMF("his","her") + " ass.  ");
	outputText("Rubi next slides into a transparent latex shirt, long sleeved, with holes cut out to accommodate " + rubiMF("his","her") + " nipples.  It takes some work, and you have to help Rubi to put on the difficult garment, but once it's on, it looks fantastic, clinging to " + rubiMF("his","her") + " body like a second skin.");
	
	outputText("\n\nNext goes the skirt, a relatively simple affair compared to the shirt.  The matching stockings, however, are a pain.  Rubi has to sit down on the floor as you muscle them up " + rubiMF("his","her") + " ");
	if(flags[RUBI_SKIN] == 2) outputText("furred ");
	outputText("legs.  You wonder how " + rubiMF("he","she") + " does this when you're not around!  Finally, Rubi slips on a pair of heels");
	if(flags[RUBI_FEET] == 1) outputText(", the actual heel cut off to make room for " + rubiMF("his","her") + " demonic heel,");
	outputText(" to complete the look.  All in all, " + rubiMF("he","she") + " looks ready for a night in the dungeons.");
	outputText("\n\nNow that Rubi is dressed up, what do you want to do?");
	//[Date (go to bar date)] [Back]
	menu();
	addButton(0,"Date",dateIntro,barDate);
	addButton(4,"Back",rubiAppearance);
}

//Suitclothes
function putOnASuitYouSlut():void {
	clearOutput();
	outputText("You tell Rubi you'd like to see " + rubiMF("him","her") + " in the suit.  \"<i>Oh, really?  It looks nice, but you don't think it's too manly?</i>\"");
	outputText("\n\nRubi starts with a black, lacy bra");
	if(flags[RUBI_BREAST_SIZE] < 1) outputText(", despite the fact that " + rubiMF("he","she") + " clearly doesn't need one");
	outputText(", which " + rubiMF("he","she") + " expertly fastens behind " + rubiMF("him","her") + ".  Next, " + rubiMF("he","she") + " takes a black garter belt and slips it up " + rubiMF("his","her") + " slender ");
	if(flags[RUBI_SKIN] != 2) outputText("hairless");
	else outputText("furred");
	outputText(" legs, until it rests snugly around " + rubiMF("his","her") + " waist.  A matching pair of black stockings quickly follow, held up by the garter.  The next thing is a black pair of panties that " + rubiMF("he","she") + " slides up " + rubiMF("his","her") + " legs and pulls up so that they cling tightly to " + rubiMF("his","her") + " ample rump.  You wonder what all this has to do with a suit, but then you remember who you're dealing with.");
	
	outputText("\n\nFinally Rubi begins to put on the actual suit, beginning with a simple white, button-up shirt.  Slacks follow behind, and Rubi tucks the shirt into the pants neatly.  A black jacket goes on last, fitting rather loosely over " + rubiMF("his","her") + " frame.  Rubi slips into a pair of heels");
	if(flags[RUBI_FEET] == 1) outputText(", with the actual heel cut off to make room for " + rubiMF("his","her") + " demonic heel,");
	outputText(" and quickly combs back " + rubiMF("his","her") + " hair.  All in all, " + rubiMF("he","she") + " looks like a girl dressed in her boyfriend's clothes... which is to say, quite sexy.");
	outputText("\n\nNow that Rubi is dressed up, what do you want to do?");
	//[Date (go to fancy date)] [Back]
	menu();
	addButton(0,"Date",dateIntro,fancyDate);
	addButton(4,"Back",rubiAppearance);
}

//Tube-Top
function putOnATubeTopYouWhore():void {
	clearOutput();
	outputText("You tell Rubi you'd like to see " + rubiMF("him","her") + " in the tube top and shorts.  \"<i>Ooh, I like that one.  It's a little risque, but so cute!</i>\"");
	outputText("\n\nRubi starts off with what seems to be the skimpiest g-string you've ever seen.  " + rubiMF("He","She") + " steps into the tiny underwear and pulls them up, ");
	if(flags[RUBI_COCK_SIZE] > 0) outputText("tucking " + rubiMF("his","her") + " cock firmly into the triangular strip of cloth covering " + rubiMF("his","her") + " crotch, while ");
	outputText("the string gets firmly lodged between Rubi's butt cheeks.  This is followed up by an impossibly small pair of denim shorts which slide up " + rubiMF("his","her") + " slender legs and barely cover the g-string already worn.  Rubi pulls at the side strings of the skimpy underwear, making sure they're plainly visible over the denim shorts.");
	
	outputText("\n\nNext " + rubiMF("he","she") + " takes the tube top, little more than a rectangular strip of cloth, and pulls it on over " + rubiMF("his","her") + " head, setting it into place over top of " + rubiMF("his","her") + " " + rubiChest());
	if(flags[RUBI_BREAST_SIZE] > 2) outputText(", which strain the flimsy piece of material");
	outputText(".  Completing the look is a simple pair of sandals");
	if(flags[RUBI_FEET] == 1) outputText(", with a hole cut in the sole to make room for Rubi's demonic heels");
	outputText(".");
	outputText("\n\nNow that Rubi is dressed up, what do you want to do?");
	//[Date (go to exhibitionist date)] [Back]
	menu();
	addButton(0,"Date",dateIntro,exhibitionistDate);
	addButton(4,"Back",rubiAppearance);
}

//Slutty Swimwear
function putOnSluttySwimwearYouSkank():void {
	clearOutput();
	outputText("You tell Rubi you'd like to see " + rubiMF("him","her") + " in the swimsuit.  \"<i>Oh, but there's no pool or lake nearby.  Or do you just want to see me in a bikini?</i>\"  Rubi giggles a moment.");
	
	outputText("\n\nRubi starts off with the bikini bottoms, which consists of a strip of cloth that can barely be considered clothing.  " + rubiMF("He","She") + " pulls it up " + rubiMF("his","her") + " legs and lets it cling tightly to " + rubiMF("his","her") + " ample ass before turning around and waggling it at you.  Next comes the top, a halter-style bikini top that " + rubiMF("he","she") + " slips over " + rubiMF("his","her") + " head and ties up behind " + rubiMF("his","her") + " back.  The two triangular pieces of fabric");
	if(flags[RUBI_BREAST_SIZE] < 3) outputText(" sit loosely over Rubi's small chest");
	else outputText("strain thanks to Rubi's ample busom");
	outputText(".");
	
	outputText("\n\nTopping it off, your demonic lover slips on a pair of sandals");
	if(flags[RUBI_FEET] > 0) outputText(", with a hole in the sole to make room for " + rubiMF("his","her") + " demonic heels");
	outputText(".");
	
	outputText("\n\nNow that Rubi is dressed up, what do you want to do?");
	//[Date (go to exhibitionist date)] [Back]
	menu();
	addButton(0,"Date",dateIntro,exhibitionistDate);
	addButton(4,"Back",rubiAppearance);
}	
	
//Bimbo Minidress
function putOnADressYouBimbo():void {
	clearOutput();
	outputText("You tell Rubi you'd like to see " + rubiMF("him","her") + " in the minidress.  \"<i>Oh that cute little thing we picked up together?  For sure!  It's so cute!</i>\"");
	outputText("\n\nIt seems there's not much to this strapless pastel pink dress at all, as Rubi simple pulls out the short, hollow tube of fabric and slips it up " + rubiMF("his","her") + " body, adjusting it momentarily around " + rubiMF("his","her") + " " + rubiBreasts() + ", and pulling it down enough to maintain some level of modesty, though you're certain that won't last long.  After all, " + rubiMF("he","she") + " didn't put on any kind of bra or panties.  Rubi does, however, add a pair of pink pumps");
	if(flags[RUBI_FEET] > 0) outputText(", with the heels removed to make room for " + rubiMF("his","her") + " own demonic heels");
	outputText(".");
	
	outputText("\n\nRubi poses several times afterwards, giving you a good show of " + rubiMF("his","her") + " barely-covered body.");
	
	outputText("\n\nNow that Rubi is dressed up, what do you want to do?");
	
	//[Date (go to exhibitionist date)] [Back]
	menu();
	addButton(0,"Date",dateIntro,exhibitionistDate);
	addButton(4,"Back",rubiAppearance);
}	

//Bodysuit
function putOnMyBodysuitYouWhore():void {
	clearOutput();
	outputText("You tell Rubi you'd like to see " + rubiMF("him","her") + " in the bodysuit.  \"<i>Oh, that thing is pretty cute,</i>\" " + rubiMF("he","she") + " says, \"<i>Though there's not much to it.  But I suppose that's the point, huh?</i>\"");
	
	outputText("\n\nRubi giggles for a moment and retrieves the bodysuit from its hangar.  It's almost sheer, though with a few strategically placed opaque, flowery decorations you know it'll preserve Rubi's modesty... just barely, anyway.  Rubi sits on the edge of " + rubiMF("his","her") + " vanity's seat as " + rubiMF("he","she") + " slips the suit up " + rubiMF("his","her") + " ");
	if(flags[RUBI_SKIN] != 2) outputText("smooth");
	else outputText("furred");
	outputText(" legs, then up the rest of " + rubiMF("his","her") + " body until " + rubiMF("he","she") + " slips " + rubiMF("his","her") + " arms into the long, sheer sleeves.  After a few adjustments, making sure ");
	if(flags[RUBI_COCK_SIZE] > 0) outputText("" + rubiMF("his","her") + " package is neatly tucked away");
	else outputText("a red rose is neatly covering up " + rubiMF("his","her") + " pubic mound");
	outputText(", and the butt of the suit is clinging perfectly to " + rubiMF("his","her") + " own, " + rubiMF("he","she") + " poses for you.");
	
	outputText("\n\nNow that Rubi is dressed up, what do you want to do?");
	
	//[Date (go to bar date)] [Back]
	menu();
	addButton(0,"Date",dateIntro,barDate);
	addButton(4,"Back",rubiAppearance);
}
//Bondage Straps
function putOnBondageStrapsYouBondageTrap():void {
	clearOutput();
	outputText("You tell Rubi you'd like to see " + rubiMF("him","her") + " in the bondage straps.  \"<i>Oh!  That outfit, huh?</i>\"  Rubi blushes brightly");
	if(flags[RUBI_SKIN] > 0) outputText(", or so you imagine");
	outputText(".  \"<i>That one's so embarrassing... but for you, I'll wear it.</i>\"");
	
	outputText("\n\nThe little demon " + rubiMF("boy","girl") + " retrieves the leather straps from a chest filled with other leather accoutrements.  Rubi fumbles with the tangled web of straps until you step in to help out.  With your help, the two of you manage to figure out which end is which, and Rubi slips " + rubiMF("his","her") + " legs into the bottom.  You pull the mess of leather up " + rubiMF("his","her") + " legs and fasten it in place.  Pulling the rest of the garment up, you tighten and fasten it up further.");
	outputText("\n\nEventually you've fastened the whole thing up Rubi's torso and arms, including a thick collar around " + rubiMF("his","her") + " neck.  You've cinched up the whole thing in such a way that Rubi's movements are slightly restricted, though " + rubiMF("he","she") + " is fully able to get out of it later.");
	outputText("\n\nNow that Rubi is dressed up, what do you want to do?");
	//[Date (go to exhibitionist date)] [Back]
	menu();
	addButton(0,"Date",dateIntro,exhibitionistDate);
	addButton(4,"Back",rubiAppearance);
}

//Inquisitor's Corset
function whyTheFuckIsRubiWearingAnInquisitorsCorset():void {
	clearOutput();
	outputText("You tell Rubi you'd like to see " + rubiMF("him","her") + " in the inquisitor's corset.  \"<i>Oh my, I really love that one.  It's so pretty and lacy!</i>\"");
	
	outputText("\n\nRubi starts with a black bra with red lace accents");
	if(flags[RUBI_BREAST_SIZE] < 1) outputText(", despite the fact that " + rubiMF("he","she") + " clearly doesn't need one");
	outputText(", which " + rubiMF("he","she") + " expertly fastens behind " + rubiMF("him","her") + ".  Next " + rubiMF("he","she") + " takes a black garter belt and slips it up " + rubiMF("his","her") + " slender ");
	if(flags[RUBI_SKIN] != 2) outputText("hairless");
	else outputText("furred");
	outputText(" legs, until it rests snugly around " + rubiMF("his","her") + " waist.  A matching pair of fishnet stockings quickly follow, held up by the garter.  They're black, but on the back is a gold-inlaid corset pattern, leading up to a pair of floppy crimson bows.  The next thing is a red pair of panties accented with gold that " + rubiMF("he","she") + " slides up " + rubiMF("his","her") + " legs and pulls up so that they cling tightly to " + rubiMF("his","her") + " ample rump.");
	
	outputText("\n\nNext comes the actual corset, a red and gold work of art with intricate golden runes stitched into it.  Rubi loosens up the lacing in the back and slips into it, pulling it up " + rubiMF("his","her") + " body.  " + rubiMF("He","She") + " struggles to tighten it up for a moment before you step in, taking the strings and tightening it all the way up, shrinking Rubi's waistline several sizes.  You finish it off with a delicate little bow.  Afterwards, Rubi slips on a pair of black heels");
	if(flags[RUBI_FEET] == 1) outputText(", with the heels removed to make room for " + rubiMF("his","her") + " own demonic heels");
	outputText(".");
	outputText("\n\nNow that Rubi is dressed up, what do you want to do?");
	//[Date (go to bar date)] [Back]
	menu();
	addButton(0,"Date",dateIntro,barDate);
	addButton(4,"Back",rubiAppearance);
}

//Risque Waitress Uniform
function putOnAWaitressUniformYouWhore():void {
	clearOutput();
	outputText("You tell Rubi you'd like to see " + rubiMF("him","her") + " in the risque version of " + rubiMF("his","her") + " normal waitress uniform.  \"<i>Oh, you like that outfit, huh?  I thought you might,</i>\" Rubi says with a giggle.");
	outputText("\n\nOf course, there's not much to this outfit, which starts off with a skirt so short it could be confused for a belt.  ");
	//(not bimbo) 
	if(!rubiBimbo() || flags[RUBI_DEBIMBO] > 0) {
		outputText("Next " + rubiMF("he","she") + " slips on a pair of pink frilly panties, sliding them up " + rubiMF("his","her") + " slender legs until they come up to cling to " + rubiMF("his","her") + " ample ass.  ");
		if(flags[RUBI_COCK_SIZE] > 0) outputText("Oddly enough, these panties only seem to cover Rubi's balls, leaving " + rubiMF("his","her") + " cock right out in the open.  ");
	}
	outputText("Taking a simple white apron, Rubi throws that on next, looping the halter-like top over " + rubiMF("his","her") + " neck and tying off the straps around " + rubiMF("his","her") + " waist.");
	if(flags[RUBI_COCK_SIZE] > 0) outputText("  To top it all off, Rubi takes a pink lacy cocksock and slips it down " + rubiMF("his","her") + " " + rubiCock() + ", fastening it into place with a pink ribbon that " + rubiMF("he","she") + " ties into a bow around the base of " + rubiMF("his","her") + " cock.");
	
	outputText("\n\nAfter all that, " + rubiMF("he","she") + " simply puts on a pair of black, open-toed heels");
	if(flags[RUBI_FEET] == 1) outputText(", with the heels removed to make room for " + rubiMF("his","her") + " own demonic heels");
	outputText(", and poses for you in the skimpy outfit.");
	outputText("\n\nNow that Rubi is dressed up, what do you want to do?");
	//[Date (go to cooking date)] [Back]
	menu();
	addButton(0,"Date",dateIntro,cookingDate);
	addButton(4,"Back",rubiAppearance);
}
function cookingDate():void {
	outputText("\n\n<b>Third forgot to write this one!</b>");
	doNext(13);
}

//Dates
function dateIntro(date):void {
	clearOutput();
	//(First Time)
	if(flags[TIMES_RUBI_DATED] == 0) {
		outputText("An idea strikes you.  While you have talked with Rubi and gotten to know " + rubiMF("him","her") + " at work, you haven't really been out with " + rubiMF("him","her") + " anywhere else.  You wonder, and ask if Rubi would like to go out somewhere, maybe to pick up some food and talk.");
		outputText("\n\nRubi's eyes light up and " + rubiMF("he","she") + " nods vehemently.  \"<i>Like a date?  Of course!  I've always wanted to go on a date with you, but you're so busy with your champion duties and all... I never had the courage to ask you!</i>\"  Rubi loops an arm around yours and clings to you.  \"<i>So, where are we going?</i>\"");
	}
	//(Repeats)
	else {
		outputText("Seeing Rubi all dressed up like this, you figure it might be time to go on another date.  You ask, and Rubi predictably makes a gleeful sound and assents.");
	}
	flags[TIMES_RUBI_DATED]++;
	if(date == iceCreamDate) {
		if(player.gems < 2) {//Can't Afford It?
			outputText("\n\nYou think you'd love to take Rubi out for a quick dessert… but you're far too certain you wouldn't be able to afford it at the moment.");
			outputText("\n\nSeriously, you're the Champion. You shouldn't be this broke.");
			menu();
			addButton(0,"Next",rubiAppearance);
			return;
		}
	}
	date();
}

//Ice-Cream Date
//For Waitress Uniform, Dashing Outfit, Adventurer's Outfit, Nurse Uniform
//Costs 2 gems.
function iceCreamDate():void {
	player.gems -= 2;
	statScreenRefresh();
	outputText("\n\nYou take your freshly dressed-up lover and head out of the little house.  Hand-in-hand you head down the streets of Tel'Adre, looking for a good place to have a quiet meal.  Past the bakery where Rubi works, you spot a small shop labelled as a \"Ice Cream Parlour\".  Rubi looks inside, " + rubiMF("his","her") + " eyes wide as " + rubiMF("he","she") + " asks, \"<i>Oh!  Can we stop in here?</i>\"");
	outputText("\n\nNodding, the two of you head inside.  It's a small shop, with only a few tables, most of which are empty.  There's a counter at the far end of the store, behind which you can see several buckets filled with icy, creamy goodness.  A male fox standing behind the counter tells you to sit anywhere, and that he'll come by for your orders momentarily.  You take Rubi over to a table next to the window and sit, chatting idly until the fox approaches.");
	outputText("\n\n\"<i>Ah, I'll have a parfait!  Thanks!</i>\"  Rubi says immediately.  You order one for yourself as well, and in no time the fox returns, setting two parfaits down on your table.");
	outputText("\n\nRubi's eyes grow as big as saucers as " + rubiMF("he","she") + " picks up " + rubiMF("his","her") + " spoon and digs in, as do you.  \"<i>I love coming here,</i>\" " + rubiMF("he","she") + " says, \"<i>it's one of the only places in Tel'Adre that has ice cream and cold desserts.  It's so great.  I just come in here and people watch sometimes.  I used to do that back in my village too, with my parents...</i>\"  Rubi suddenly gets very quiet, but when " + rubiMF("he","she") + " turns to you, " + rubiMF("he","she") + " bursts out in a fit of giggles.");
	
	outputText("\n\nPerplexed, you ask what's so funny.  \"<i>You've got a bit of ice cream on you,</i>\" " + rubiMF("he","she") + " says between giggles.  You wipe at your face and nose, trying to rid yourself of the sugary sweets.");
	
	outputText("\n\nJust when you're certain you've gotten it all, Rubi stops " + rubiMF("his","her") + " giggling and says, \"<i>You missed a spot.</i>\"  Before you can ask where, Rubi leans over the table and kisses you full on the lips, sucking off a dollop of ice cream that you're not even sure existed in the first place.  Blushing bright red, Rubi sits back in " + rubiMF("his","her") + " seat and mutters, \"<i>Got it.</i>\"");
	outputText("\n\nThe two of you pass the rest of your date watching the people outside, occassionally coming up with life stories, goals and relationships for them.  Rubi's hopeless romantic side blossoms here.  Everyone, it seems, is pining for someone else in " + rubiMF("his","her") + " imagination.  There's unrequited love, love triangles, love quadrangles, affairs and more.  Each person that passes by the window seems to be head-over-heels for someone, or multiple people.  Rubi invents entire backstories, first dates, first kisses overlooking a sunset, and their first nights together.");
	
	//(if Relationship 100, happens once)
	if(flags[RUBI_AFFECTION] >= 100 && flags[RUBI_ICECREAM_CONFESSION] == 0) {
		outputText("\n\n" + rubiMF("He","She") + " looks over at you during all this, places a hand on yours and says very earnestly, \"<i>I... Thank you for this.  It means a lot to me.  I did this with my mom and dad a lot.  You know, before the demons attacked.  Even though they're not with me any more, it means a lot that I can do this with someone else again.</i>\"");
		flags[RUBI_ICECREAM_CONFESSION]++;
	}
	
	outputText("\n\nYour parfaits are not infinite, however, and once you've depleted your layered frozen treats it seems it's time to head back.  The two of you clasp hands once more and head out of the shop, heading back to Rubi's place in silence, content to be in each other's presence.");

	outputText("\n\nOnce you're back in the house, Rubi sprawls out on the couch, a devilish grin on " + rubiMF("his","her") + " face.  \"<i>So, you plan on giving me a good \"kiss\" good night?\"");
	//[Go to Sex menu]
	rubiSexMenu();
	addButton(9,"Leave",eventParser,13);
}

//Fancy Dinner Date
//For Suitclothes, Long Dress.
function fancyDate():void {
	//Costs 10 gems
	if(player.gems >= 10) {
		player.gems -= 10;
		statScreenRefresh();
		outputText("\n\nSince your lover is dressed up for a night on the town, you decide to take " + rubiMF("him","her") + " to the fanciest restaurant in all of Tel'Adre.  Together, hand in hand, the two of you strike out of Rubi's small, yet cozy home, and head off in search of the best eatery in town.  Rubi directs you over a few streets, and you find yourself in front of \"Bigby's Cafe\", a large, imposing restaurant front.  Columns of fine marble flank the entrance to this impeccable shop.");
		outputText("\n\nYou offer Rubi your arm, like a " + rubiMF("gentleman","lady") + " should, which " + rubiMF("he","she") + " accepts graciously, and you escort " + rubiMF("his","her") + " inside.  A well-dressed bunny-boy meets you inside and escorts you to a table before handing you each a menu.  He bows and mentions that your waiter will be right with you.  You glance over your menu briefly, only recognizing a few entrees.  Many of the dishes seem to be foreign, at least to you.");
		
		outputText("\n\nYour waiter, a broad-shouldered wolf man who wouldn't look out of place in a guard's uniform, arrives moments later.  Rubi orders a fillet of fish, claiming that " + rubiMF("he","she") + " is feeling a bit nostalgic.  You decide to order the same thing, as you're certain you could only understand what a fraction of the things on the menu were.  The waiter nods, retrieves your menus, and heads back to the kitchen.");
		outputText("\n\nThis gives you and Rubi a chance to watch the other people in the restaurant.  Despite its fancy exterior, many of the patrons are dressed simply.  You wouldn't be surprised to see these people at the bakery, or the Wet Bitch for that matter.  You wonder briefly if Rubi is overdressed, though with how happy " + rubiMF("he","she") + " looks in that outfit, you're certain " + rubiMF("he","she") + " wouldn't care.");
		outputText("\n\nThe two of you people watch for some time, your mutual gazes eventually settling on a pair of foxes alone in a corner.  They're both clasping each other's hands, talking indistinctly to one another.");
		outputText("\n\n\"<i>Oh, but Fabius, I love you so much my dear,</i>\" says Rubi, suddenly.  You're confused for a moment before you realize that " + rubiMF("his","her") + " hopeless romantic side has taken over, and " + rubiMF("he","she") + "'s just dramatizing the foxes' conversation.");
		outputText("\n\n\"<i>I know my sweet Carmilla, but we must keep this a secret, for if our families knew then we could not be together,</i>\" " + rubiMF("he","she") + " continues, in a mock masculine voice.  You notice with a smile that even when attempting a male voice, " + rubiMF("he","she") + " can't help but sound like an innocent young girl.");
		
		outputText("\n\nAs the dramatization continues, you find yourself concentrating less upon the couple, and more on Rubi and " + rubiMF("his","her") + " story.  " + rubiMF("He","She") + " seems to adore the idea of forbidden love, especially true love, that must be kept hidden lest it tear families asunder.  The idea of two people who seem by all means to be destined for one another, and who must remain apart for one reason or another, really strikes a chord within Rubi, and you realize that " + rubiMF("he","she") + " has been tearing up as the fiction continues.");
		
		//(If Relationship 100, only happens once)
		if(flags[RUBI_AFFECTION] >= 100 && flags[RUBI_FANCY_CONFESSION] == 0) {
			outputText("\n\nToward the end of the faux lip-reading, Rubi suddenly stops and looks over at you.  \"<i>I… They're kind of like us, aren't they?  You can't stay here with me, and I can't go with you.  But we still find our moments, here and now, with each other, don't we?  That's what I look forward to the most.  The few moments I get to spend with you,</i>\" " + rubiMF("he","she") + " confesses, dead serious, the tears forming in " + rubiMF("his","her") + " eyes.");
			flags[RUBI_FANCY_CONFESSION]++;
		}
		outputText("\n\nEventually, though, your food comes around, and Rubi dabs a napkin at " + rubiMF("his","her") + " eyes, careful not to smudge the elegant makeup " + rubiMF("he","she") + " put on for this event.  \"<i>Well, that's enough of that,</i>\" " + rubiMF("he","she") + " says with a giggle.  \"<i>Let's try this fish out.  I wonder if it's better than…</i>\" Rubi's voice trails off as " + rubiMF("he","she") + " tries a bite.  \"<i>Nope, definitely not,</i>\" " + rubiMF("he","she") + " concludes, through a mouthful of fish.");
		outputText("\n\nYou too try your fish.  It's quite good");
		//(if PC has met Callu)
		if(flags[MET_OTTERGIRL] == 1) outputText(" though not as good as Callu's, the ottergirl fisherman you met at the lake.");
		else outputText(", which makes you wonder who Rubi is thinking about.  Perhaps one of " + rubiMF("his","her") + " parents?");
		
		outputText("\n\nOnce the two of you finish off your respective meals, you pay for the dinner and escort your lovely date back to " + rubiMF("his","her") + " place, enjoying each other's company on the quiet walk.");
		
		outputText("\n\nOnce you're back in the house, Rubi sprawls out on the couch, a devilish grin on " + rubiMF("his","her") + " face.  \"<i>So, you plan on giving me a good \"kiss\" good night?\"");
		//[to sex menu]
		rubiSexMenu();
		addButton(9,"Leave",eventParser,13);
		return;
	}
	//Can't Afford It?
	else {
		outputText("\n\nYou think you'd love to take Rubi out for a fancy meal, but you're certain you wouldn't be able to afford it at the moment.");
		outputText("\n\nSeriously, you're the Champion. You shouldn't be this broke.");
		menu();
		addButton(0,"Next",rubiAppearance);
	}
}

//Exhibitionist Date
///For Tube Top, Slutty Swimwear, Bimbo Minidress, Bondage Straps.
function exhibitionistDate():void {
	outputText("\n\nYou think carefully as to where you could go.  With " + rubiMF("him","her") + " dressed up as sluttily as " + rubiMF("he","she") + " is, you think a nice dinner is out of the question.  However, perhaps you can have a bit of fun taking a walk around town.  You wrap your arm around your lover's waist and together the two of you strike out into the warm Tel'Adran air.");
	outputText("\n\nYou head away from the more populated avenues of the city.  Rubi fidgets slightly, not used to being so… exposed on the streets.  You whisper words of encouragement in " + rubiMF("his","her") + " ear, saying how sexy " + rubiMF("he","she") + " is looking, that " + rubiMF("he","she") + " shouldn't feel bad about flaunting it.  In fact, you suggest, " + rubiMF("he","she") + " might even like to show off a bit more to the random people you pass.");
	outputText("\n\nRubi gulps visibly, then nods and follows your suggestion, pulling aside " + rubiMF("his","her") + " clothes and flashing " + rubiMF("his","her") + " " + rubiBreasts() + " at the next person to pass you by.  The feline male's eyes widen in surprise.  You swiftly pass him by, eager to get out of sight just in case his reaction is less than friendly.  Luckily, as he looks back, you see a small smirk on his face… it seems Rubi just made his day.");
	outputText("\n\nYou run your hand along your lover's body and squeeze " + rubiMF("his","her") + " buttocks firmly, assuring " + rubiMF("him","her") + " that the feline man enjoyed the show… and that " + rubiMF("he","she") + " should show off to the next person you pass as well.  An equine woman, quite physically fit and powerful-looking, begins to saunter by, looking curiously at Rubi and " + rubiMF("his","her") + " outrageous getup.  Just as the three of you begin to pass one-another, Rubi pulls aside " + rubiMF("his","her") + " clothes to reveal " + rubiMF("his","her") + " ");
	if(flags[RUBI_COCK_SIZE] > 0) outputText(rubiCock());
	else outputText("glistening, wet pussy");
	outputText(".");
	
	outputText("\n\nThe female equine's jaw drops slightly and her eyes dart between the demon-" + rubiMF("boy","girl") + "'s crotch, and both you and Rubi's faces.  The two of you rush past quickly, until the latest target of your your lover's exhibitionism is out of sight.");
	
	outputText("\n\nRubi begins giggling madly once the two of you duck into an alleyway.  \"<i>That was so great!  Did you see her face?  Aaaah, I love it!</i>\"  It takes several minutes for Rubi to calm down, and by the time " + rubiMF("he","she") + "'s done, " + rubiMF("he","she") + "'s practically dragging you back out onto the streets.  \"<i>Come on, I wanna flash some more people,</i>\" " + rubiMF("he","she") + " says, simply.  Looks like " + rubiMF("he","she") + "'s really enjoying " + rubiMF("him","her") + "self.");
	
	outputText("\n\nRubi flashes several people throughout your \"date\", sometimes even walking around topless, or bottomless.  It seems that " + rubiMF("he","she") + " has no sense of modesty, at least at the moment.  Thoughts of keeping " + rubiMF("his","her") + " \"secret\" are long gone, it seems.");
	
	outputText("\n\nBy the time the two of you loop back to Rubi's house, you estimate " + rubiMF("he","she") + " has flashed " + rubiMF("his","her") + " body off to at least a dozen people, all of whom seemed to get a thrill out of it themselves.  None more so than Rubi, however, whose body is simply trembling as you cross the threshold into " + rubiMF("his","her") + " home.");
	
	outputText("\n\n" + rubiMF("He","She") + " grips your arm and gives you a wild kiss on the lips, saying, \"<i>Oh gods that was so exhilarating, babe.  I can't wait until we do that again.  It got me really, </i>really<i> hot… what are you going to do about it?</i>\"");
	
	//[Go to sex menu]
	rubiSexMenu();
	addButton(9,"Leave",eventParser,13);
}

//Bar Date
//For Rubber Fetish Clothes, Bodysuit, Inquisitor's Corset.
function barDate():void {
	outputText("\n\nYou think carefully about where you could go.  Your companion is not quite dressed well enough for any kind of fancy dinner, but you think you could head down to the local bar for a drink or two.  You wrap your arm around Rubi's waist and together the two of you head out onto the streets of Tel'Adre.  You head from street to street until you come upon the local bar, the \"Wet Bitch\".");
	
	outputText("\n\nYou slip inside with your date and find a place up at the bar.  When the bartender moves down to your side of the bar, Rubi brushes brightly and asks, \"<i>Oh, can I get a sex on the beach?</i>\"  You laugh to yourself and order one as well.  The bartender nods and begins mixing the two drinks up.  Meanwhile, Rubi turns around on the stool to watch the rest of the bar.");
	
	outputText("\n\n\"<i>This place is great,</i>\" " + rubiMF("he","she") + " comments as you turn around as well.  \"<i>Almost everyone comes by here at some point.  It's a great place to people watch.  See, check those two out,</i>\" " + rubiMF("he","she") + " says, pointing out a pair of young spider-morph females.  \"<i>When I started coming to the bar, they hadn't even met.  I've managed to see their first meeting, their first date, and several of them down the road.  They make such a cute couple, don't they?</i>\"");
	
	outputText("\n\nYou follow Rubi's gaze and look at the pair of girls cuddling together in one side of a bench.  The smaller one nuzzles into the larger one's chest as they sip at a pair of drinks.  Rubi smiles contentedly.  \"<i>True love, it's so romantic.</i>\"");
	
	outputText("\n\n\"<i>A double dose of sex on a beach,</i>\" comes the voice of the bartender behind you, and the two of you turn to find a pair of drinks set in front of you.  Rubi grasps " + rubiMF("his","her") + " drink and holds it up, \"<i>To true love!</i>\"");
	
	outputText("\n\nYou hold up your drink as well and tap it against Rubi's before taking a drink.  Rubi comments on several other patrons, mostly remarking on their love lives.  It seems that, before Rubi met you, " + rubiMF("he","she") + "'d been too embarrassed to date anyone, and settled on living vicariously through others.  It's surprising how many happy couples Rubi can point out, though there is a fair share of heartbreak as well.");
	
	//(If Relationship 100, happens once) 
	if(flags[RUBI_AFFECTION] >= 100 && flags[RUBI_BAR_CONFESSION] == 0) {
		outputText("\n\n\"<i>Babe… Thanks for all of this.  I know you've got your hands full trying to save the world and all that, but thanks,</i>\" Rubi says suddenly, leaning " + rubiMF("his","her") + " head on your shoulder.  \"<i>I hope one day someone sees us and thinks the same things I used to think.</i>\"");
		flags[RUBI_BAR_CONFESSION]++;
	}
	outputText("\n\nAfter a few drinks Rubi is quite amorous with you, practically sitting on your lap as you discuss the other patrons of the bar as usual.  You smile at " + rubiMF("him","her") + " concernedly, and suggest that maybe " + rubiMF("he","she") + "'s had enough to drink.  " + rubiMF("He","She") + " waves " + rubiMF("his","her") + " hand dismissively for a moment, before almost toppling off the barstool.  After righting " + rubiMF("him","her") + "self, " + rubiMF("he","she") + " nods briefly to you.  \"<i>Maybe it's best we head back,</i>\" " + rubiMF("he","she") + " suggests.");
	
	outputText("\n\nYou nod in agreement and grasp Rubi around the shoulders, holding " + rubiMF("him","her") + " close as you start walking back to " + rubiMF("his","her") + " place.  It doesn't take long, but Rubi remains frisky the entire way, unable to keep " + rubiMF("his","her") + " hands to " + rubiMF("him","her") + " self.");
	
	outputText("\n\nBy the time you enter Rubi's bedroom, " + rubiMF("his","her") + " lips are locked with yours.  \"<i>So babe, what are we going to do about this?</i>\"");
	//[Goto Sex menu]
	rubiSexMenu();
	addButton(9,"Leave",eventParser,13);
}

//Anal Training
//Requires 75 Affection.
//Must have a cock larger than Rubi's capacity.
//Repeatable
//Must have a cock greater than Rubi's capacity.
//Rubi's capacity won't go larger than 100.
function anallyTrainYourBitchBoySlutHowToBeAnalForDCL():void {
	clearOutput();
	flags[RUBI_TIMES_ANALLY_TRAINED]++;
	//First Time
	if(flags[RUBI_TIMES_ANALLY_TRAINED] == 1) {
		outputText("You sit down on the couch next to Rubi, making small talk.  After a few minutes the two of you are laughing comfortably as you lounge on the cushions, discussing everything from life in Tel'Adre to your adventuring exploits.  Eventually the topic of conversation circles back to sex, and how you're a bit too much for " + rubiMF("him","her") + " to handle at the moment.");
		outputText("\n\nRubi gulps visibly and nods, \"<i>I can't help it, babe.  That cock of yours looks so ");
		if(rubiBimbo() || flags[RUBI_DEBIMBO] == 0) outputText("totally ");
		outputText("delicious, but I'm afraid it's too big!  I couldn't possibly fit that entire thing inside me... not comfortably at least.</i>\"");
		outputText("\n\nYou frown.  Naturally you don't want to hurt " + rubiMF("him","her") + ", but the situation can't be hopeless, can it?  This is Mareth after all, where everything AND its mother has a gigantic penis.  Out loud, you assert that there must be some solution to the problem.");
		outputText("\n\nThe adorable demon morph beside you looks sheepish for a moment before saying, \"<i>Well, I kinda-sorta might be ahead of you on that...</i>\"  Perplexed, you ask what " + rubiMF("he","she") + " means by that.  Rather than explain, Rubi stands up, takes you by the hand, and leads you into " + rubiMF("his","her") + " bedroom.  After that " + rubiMF("he","she") + " kneels down by the bed, reaches under it, and slides out a large black and pink chest.");
		outputText("\n\nRubi pauses for a moment, taking a deep breath to collect " + rubiMF("him","her") + "self before opening the chest.  There, laid out in the chest, is a veritable cornucopia of dildos, dongs, vibrators and a variety of other phallic toys.  They come in all shapes and sizes, from a small pink vibrator all the way up to a mammoth equine dildo as big as Rubi's arm.  Rubi's skin flushes red");
		if(flags[RUBI_SKIN] == 1 || flags[RUBI_SKIN] == 3) outputText(", or redder at least");
		else outputText(", what little of it you can see");
		outputText(", and " + rubiMF("he","she") + " sits knock-kneed behind the chest.");
		
		outputText("\n\n\"<i>Well I've kind of had these for a while.  I thought maybe I could work my way up to your size, but I haven't actually used any yet.  Would you... would you like me to?</i>\" " + rubiMF("he","she") + " asks, fidgeting slightly.");
		
		outputText("\n\nYou survey the wide array of saucy toys in the chest.  Well, if it means stretching " + rubiMF("him","her") + " out enough for you to finally get your dick in there, why not?  You nod and voice your approval of this plan.  Rubi smiles, stands, and sprints off into the closet, " + rubiMF("his","her") + " demonic tail swishing excitedly behind " + rubiMF("him","her") + ".");
		
		outputText("\n\nYou cock an eyebrow, wondering what " + rubiMF("he","she") + " could possibly be doing in there.  After a few minutes " + rubiMF("he","she") + " returns, wearing a see-through, skimpy, black negligee.  \"<i>There, how do I look?</i>\" " + rubiMF("he","she") + " asks, twirling around.  As " + rubiMF("he","she") + " does, the hem of the negligee flutters up to expose " + rubiMF("his","her") + " naked butt and crotch");
		if(flags[RUBI_COCK_SIZE] > 0) outputText(", " + rubiMF("his","her") + " dick wobbling enticingly");
		outputText(".");
		
		outputText("\n\nLicking your lips, you agree " + rubiMF("he","she") + " looks good enough to fuck.  Rubi giggles, minces over and plants a kiss on your cheek.  \"<i>Well that </i>IS<i> the idea... but before that, I'm going to have to do some work,</i>\" " + rubiMF("he","she") + " says, taking up a small, human-sized dildo from the chest along with a bottle of what you assume to be lubricant.  \"<i>I may as well give you a little show. Can't let me have all the fun.</i>\"");
		
		outputText("\n\nRubi urges you to sit on the edge of the bed, while " + rubiMF("he","she") + " moves a bit further away, laying down on the plush carpet covering the room.  Setting the dildo and lube aside for now, " + rubiMF("his","her") + " hands explore " + rubiMF("his","her") + " tender body, focusing just for a moment on " + rubiMF("his","her") + " " + rubiChest() + " and ");
		if(flags[RUBI_NIPPLE_TYPE] == 1) outputText("black ");
		outputText("nipples, which jut straight up, straining against the sheer fabric of the negligee.  A soft gasp escapes Rubi's soft lips as " + rubiMF("he","she") + " pinches one ");
		if(flags[RUBI_NIPPLE_TYPE] == 1) outputText("ebon ");
		outputText("nipple, while " + rubiMF("his","her") + " other hand flutters down between " + rubiMF("his","her") + " thighs to stroke " + rubiMF("his","her") + "");
		if(flags[RUBI_COCK_SIZE] > 0) outputText(rubiCock());
		else outputText("quickly dampening pussy");
		outputText(".");
		
		outputText("\n\n" + rubiMF("His","Her") + " hands don't remain there for long, however, as " + rubiMF("he","she") + " seems eager to get on to the main show.  After a minute of stroking, Rubi brings " + rubiMF("his","her") + " fingers up to " + rubiMF("his","her") + " ");
		if(flags[RUBI_SKIN] == 0 || flags[RUBI_SKIN] == 2) outputText("crimson red");
		else outputText("dusky black");
		outputText(" lips, licking the ");
		if(flags[RUBI_COCK_SIZE] > 0) outputText("pre-cum");
		else outputText("juices");
		outputText(" off of them with a smile.  " + rubiMF("His","Her") + " newly cleaned fingers move to the bottle of lube sitting nearby.  After pumping a handful into " + rubiMF("his","her") + " palm, the rich scent of raspberries seems to fill the air, making your nostrils twitch.  Scented lube?");
		
		outputText("\n\nWith " + rubiMF("his","her") + " other hand, Rubi grasps the dildo and brings it up to " + rubiMF("his","her") + " lips, taking it in slowly.  Within seconds the small, wobbly dildo is buried deep in the demon-morph's throat, and when it emerges, it glistens with saliva.  With another handful of raspberry-scented lube, Rubi adds to the slick, goopy layer covering the fake cock and, with a little hesitation, lowers it between " + rubiMF("his","her") + " legs to press the spongy mushroom-like glans of the dildo against " + rubiMF("his","her") + " ");
		if(flags[RUBI_COCK_SIZE] == 0) outputText("slick vagina");
		else outputText("hungry asshole");
		outputText(".");
		
		outputText("\n\nRubi's lips form an O-shape as the tip of the dildo slips inside " + rubiMF("his","her") + " tight hole.  You slip forward on the edge of the bed, eyes drawing in the scene before you.  With this erotic display, you're not surprised to find yourself getting quite turned on as well.  Your lover's demonic tail flutters forward, slithering around the dildo while Rubi presses it in deeper, " + rubiMF("his","her") + " ");
		if(flags[RUBI_COCK_SIZE] == 0) outputText("cunt");
		else outputText("asshole");
		outputText(" clinging so tightly to the toy you imagine it must be like a vice.");
		
		outputText("\n\nThe sweet little creature before you moans lightly as more of the dildo's length presses inside, until " + rubiMF("he","she") + " finds " + rubiMF("he","she") + "'s bottomed out, reaching the large flared bottom of the dildo.  Rubi's soft rosy lips curl upwards in a proud smile.  " + rubiMF("His","Her") + " hand and tail take a renewed grip on the fake cock, and " + rubiMF("he","she") + " lifts " + rubiMF("his","her") + " hips a few inches before slamming them back down onto the dildo.");
		
		outputText("\n\nYou bite your lip and find [eachCock] straining against your [armor] and close your eyes for a moment, letting your imagination take over.  You imagine Rubi astride your naked body, your hands moving up " + rubiMF("his","her") + " own.  The sensations of thrusting inside your lover overtake you like a breath of fresh air.  Rubi's hips gyrate atop you, and you can feel a powerful urge building inside of you....");
		
		outputText("\n\nYou're brought back to reality by a sudden moan from Rubi.  Your eyes bolt open and focus on the demon-" + rubiMF("boy","girl") + "'s slender frame, which is quivering madly.  " + rubiMF("His","Her") + " ");
		if(flags[RUBI_COCK_SIZE] > 0) outputText(rubiCock() + " is standing at full attention, bobbing up and down as Rubi fucks " + rubiMF("himself","herself") + " on the dildo");
		if(flags[RUBI_COCK_SIZE] > 0 && flags[RUBI_NO_CUNT] == 0) outputText(", and " + rubiMF("his","her") + " ");
		if(flags[RUBI_NO_CUNT] == 0) outputText("cunt lips are glistening red with arousal, just begging for attention");
		outputText(".  Rubi's cries grow louder, " + rubiMF("his","her") + " lips parting and " + rubiMF("his","her") + " tongue lolling out as " + rubiMF("he","she") + " pants for breath.  You can tell " + rubiMF("he","she") + "'s building up to something, something powerful at that.");
		
		outputText("\n\n" + rubiMF("His","Her") + " hips spin and oscillate, working vigorously to keep " + rubiMF("his","her") + " ");
		if(flags[RUBI_NO_CUNT] == 1) outputText("backside");
		else outputText("fuck hole");
		outputText(" filled with dick, however fake it may be.  The slender, feminine demon's voice is so suffused with lustful fervor that it's virtually palpable in the warm air permeating the area.  Each near-orgasmic tone that worms its ways from " + rubiMF("his","her") + " throat just drips with euphoria and writhes its way into your ears, filling your body with a portion of " + rubiMF("his","her") + " passion.");
		
		outputText("\n\nUltimately, however, Rubi can't hold out.  " + rubiMF("His","Her") + " muscles contract, arms pulling in and covering " + rubiMF("his","her") + " chest as though " + rubiMF("he","she") + " were suddenly aware of the revealing nature of " + rubiMF("his","her") + " lingerie.  " + rubiMF("His","Her") + " deliciously ");
		if(flags[RUBI_SKIN] != 2) outputText("bare");
		else outputText("furred");
		outputText(" legs buckle, one jerking like mad, causing " + rubiMF("him","her") + " to impale " + rubiMF("himself","herself") + " fully onto the imitation shaft of man meat.  Amid the chaos of spasming limbs and newfound modesty, Rubi loses " + rubiMF("his","her") + " breath, making small gasping noises when " + rubiMF("he","she") + " isn't moaning for more.");
		
		if(flags[RUBI_COCK_SIZE] > 0) outputText("\n\nRubi's cock spasms along with " + rubiMF("him","her") + " suddenly loosing a spray of pearly white cum into the air.  It doesn't stop with just one spurt however, instead turning " + rubiMF("his","her") + " crotch into some kind of lewd sprinkler, covering nearly every surface within the immediate vicinity with " + rubiMF("his","her") + " love juices.");
		if(flags[RUBI_NO_CUNT] == 0) outputText("\n\nWith a clear look at Rubi's crotch, you can see " + rubiMF("his","her") + " pussylips contract around the artificial vaginal invader, " + rubiMF("his","her") + " clitoris sinking into the flesh for a moment before pushing right back out.  " + rubiMF("His","Her") + " little love button pulses like this several times, the next one more languid than the last.");
		
		outputText("\n\nWith " + rubiMF("his","her") + " orgasm subsiding, Rubi slouches back against the wall, the small human-like dildo taking this opportunity to slip about halfway out of " + rubiMF("his","her") + " ");
		if(flags[RUBI_NO_CUNT] == 1) outputText("asshole");
		else outputText("cunt");
		outputText(", seeking freedom from its sweet, fleshy prison.  A long supine sigh escapes your slender lover's mouth.  " + rubiMF("He","She") + "'s clearly exhausted and happy for this rapturous release.");
		
		outputText("\n\nYou slip off the bed, moving forward to inspect the object of your voyeuristic fantasy, whose eyes are half-way closed.  " + rubiMF("He","She") + " motions to the bed and whispers, \"<i>I think I need some rest after that.</i>\"  Grinning, you oblige your submissive lover and pick " + rubiMF("him","her") + " up, letting the dildo flop completely out, and carry " + rubiMF("him","her") + " over to the bed, placing " + rubiMF("him","her") + " on the sheets.  Rubi murmurs " + rubiMF("his","her") + " appreciation, and cuddles up with a particularly fluffy pillow.");
		
		outputText("\n\nYou turn to make your way out of the room, when you see the toy chest again.  You hunch down, poking through the chest until you spot it... a glistening metal buttplug with a gemstone set in the bottom.  A sly grin creeps across your face as you retrieve the plug and sidle into the bed behind Rubi.  " + rubiMF("He","She") + " hums slightly at your presence.  You run a hand along " + rubiMF("his","her") + " body and dip it between " + rubiMF("his","her") + " legs, slipping a finger inside " + rubiMF("his","her") + " slightly gaping ");
		if(flags[RUBI_NO_CUNT] == 1) outputText("ass");
		else outputText("pussy");
		outputText(".");
		
		outputText("\n\nWhen Rubi turns " + rubiMF("his","her") + " head around to question your actions, you smirk and slip the plug inside " + rubiMF("him","her") + ".  Rubi's eyes shut tight and " + rubiMF("he","she") + " stifles a moan, any question or comment forgotten.  You whisper into " + rubiMF("his","her") + " ");
		if(flags[RUBI_EAR_TYPE] == 0) outputText("ear");
		else if(flags[RUBI_EAR_TYPE] == 1) outputText("feline ear");
		else outputText("feathered ear");
		outputText(" that " + rubiMF("he","she") + " should keep that in for a few hours, just to make sure this training takes hold.  Rubi gives you a small smile in response along with a small peck on the cheek before slipping under the sheets for a quick nap.");
		
		outputText("\n\nYou decide this is the best time to head out as well, and make your way out of the apartment and back to camp.");
		stats(0,0,0,0,0,0,20+player.lib/5,0,false);
	}
	//Repeatable
	//Must have a cock greater than Rubi's capacity.
	//Rubi's capacity won't go larger than 100.
	else {
		outputText("You bring up the subject of training Rubi's ass again.  " + rubiMF("He","She") + " looks up at you with a sheepish smile on " + rubiMF("his","her") + " face and confesses, \"<i>I was hoping you'd say that, babe.  I've actually been practicing a little bit on my own.  I… Well, I've been itching to get that bad boy you've got inside me.</i>\"");
		
		outputText("\n\nYou grin in response, and say that, with enough training maybe soon " + rubiMF("he","she") + " can.");
		
		outputText("\n\nRubi stands up from the couch and slowly makes " + rubiMF("his","her") + " way to the bedroom, giving " + rubiMF("his","her") + " hips and tail a sexy sashay that you're certain is an invitation.  You rise, in more ways than one, and follow quickly behind the demonic little minx.  " + rubiMF("He","She") + " motions to the plush, soft bed as the two of you enter, and " + rubiMF("he","she") + " says, \"<i>Make yourself comfortable.  I'll go slip into something a little… less comfortable,</i>\"");
		
		outputText("\n\nWith the stupid grin still plastered across your face, you take a seat at the edge of Rubi's bed, a fluffy white monster with a lilac-colored bedspread laid across it.  You get comfortable as your demon-tailed lover disappears into the bathroom. Almost ten minutes later, " + rubiMF("he","she") + " reemerges, posing in the doorway.");
		
		outputText("\n\nWith one arm raised " + rubiMF("he","she") + " leans against the frame of the door, showing off " + rubiMF("his","her") + " powder blue babydoll.  The skimpy, sheer lingerie barely covers Rubi's body, and in fact leaves " + rubiMF("his","her") + " " + rubiBreasts() + " completely open, framed by a triangle of white lace.  The wavy hem of the babydoll drapes low, but not low enough to cover " + rubiMF("his","her") + " crotch.  Rubi's ");
		if(flags[RUBI_COCK_SIZE] > 0) outputText(rubiCock());
		else outputText("sweet pussy");
		outputText(" is readily on display, and it's all for you.  Rubi's makeup is less than subtle, with bright red lips and a light dusting of silver eyeshadow, enough to make " + rubiMF("his","her") + " eyes pop and not clash with the outfit.  Completing the look is a pair of white fishnet stockings that go up " + rubiMF("his","her") + " legs, ending about mid-thigh.");
		
		outputText("\n\nYou lick your lips hungrily.  \"<i>Oh?</i>\" Rubi asks, sauntering over to you.  The way " + rubiMF("his","her") + " hips sway with each step makes your heart flutter ever so slightly.  \"<i>Would you,</i>\" " + rubiMF("he","she") + " leans down, " + rubiMF("his","her") + " half-closed eyes giving " + rubiMF("him","her") + " a sultry look.  " + rubiMF("His","Her") + " lips brush past your own, the briefest of contact, but nonetheless electric in its sensations. \"<i>Like a,</i>\" " + rubiMF("he","she") + " puckers " + rubiMF("his","her") + " lips as they meet with yours in a wet, steamy kiss that leaves you breathless.  \"<i>Taste?</i>\" " + rubiMF("he","she") + " concludes, breaking away from your mouth with a small, feminine gasp.");
		
		outputText("\n\nYou're left breathless as Rubi pulls away, giggling.  \"<i>Sorry, babe, you just look so awestruck.  I couldn't help but tease you a little.</i>\"  You laugh, then wrap your arm around " + rubiMF("his","her") + " waist, pulling " + rubiMF("him","her") + " onto your lap with ease.  Your lips lock once again and Rubi just melts in your embrace.  Meeting no resistance, your tongue invades the " + rubiMF("demon","demoness"));
		outputText("'s mouth, exploring every inch and entwining with Rubi's own.");
		
		outputText("\n\nWhen you break away, it's Rubi that's left breathless.  " + rubiMF("His","Her") + " mouth gapes slightly, and " + rubiMF("his","her") + " eyes remain closed for several seconds, until your light chuckling snaps " + rubiMF("him","her") + " out of it.  Rubi's cheeks ");
		if(flags[RUBI_SKIN] == 0) outputText("go bright red");
		else if(flags[RUBI_SKIN] == 1 || flags[RUBI_SKIN] == 3) outputText("go a vivid purple");
		else outputText("would be blushing bright red now, were it not for the fine layer of fur");
		outputText(", and " + rubiMF("he","she") + " snaps back to the present.  \"<i>Eheh… I guess I deserved that.</i>\"");
		
		outputText("\n\nRubi sits upon your leg, awkwardly staring into your eyes for a minute, before " + rubiMF("he","she") + " seems to realize why " + rubiMF("he","she") + " invited you back here in the first place.  \"<i>Right, right!  I do believe it's time for a little more </i>training,\" " + rubiMF("he","she") + " says, putting a heavy emphasis on the word.  Rubi shimmies off your leg and retrieves the black and pink chest of toys from under the bed.  Your girly little lover pops the top on the chest and rummages through, until " + rubiMF("his","her") + " eyes light up.");
		
		outputText("\n\nWhat " + rubiMF("he","she") + " produces from the box causes your eyes to widen as well.  A twelve inch tall purple and black mottled horsecock.  But that's not the most disconcerting thing… it's the rounded area just above the base of the wobbling dildo.  Something that reminds you of a canine knot.");
		
		outputText("\n\nRubi beams as " + rubiMF("he","she") + " holds it up.  \"<i>This bad boy will get the job done, that's for sure!  See, it's got this little pump here,</i>\" " + rubiMF("he","she") + " says, holding up a small, hand-held air-pump connected to the dildo by a long tube.  \"<i>That inflates the knot by the base… which will certainly stretch me wide open for you, babe.</i>\"  Rubi giggles and places the dildo on the floor in front of you and hands you the pump with a wink.  \"<i>You take this, and just give it a pump whenever, OK?  Now lets get this tasty treat all warmed up.</i>\"");
		
		outputText("\n\n" + rubiMF("He","She") + " retrieves a bottle from the chest.  It appears to be a small, sealed flagon with a picture of a smiling, and quite naked, goblin on it.  \"<i>It's a brand of lubricant I saw at the goblin market the other day, while I was out shopping for this little babydoll.  It's supposed to help with the whole \"stretching\" thing,</i>\" Rubi explains, popping the top off of the flagon.  " + rubiMF("He","She") + " tips it over the rubbery dong, letting a generous amount of the carmelly liquid splash down onto the flared tip.");
		
		outputText("\n\nThe smell of peaches and alcohol fill the room, reminding you of peach schnapps, or perhaps a peach margarita.  The scent alone is almost intoxicating.  Setting the bottle of lube aside, Rubi runs " + rubiMF("his","her") + " well-manicured fingers along the horsecock's length, spreading the thick, fruity substance around until the entire length is coated in it.  " + rubiMF("He","She") + " pours another dollop of the peach margarita-scented lube into " + rubiMF("his","her") + " palm, leans forward and spreads it across " + rubiMF("his","her") + " ");
		if(flags[RUBI_NO_CUNT] == 1) outputText("asshole");
		else outputText("pussy");
		outputText(", making sure to cover every inch.  You're certain you even see a few fingers press inside " + rubiMF("his","her") + " hole.");
		
		outputText("\n\nWith everything prepped and ready to go, Rubi stands up and hovers over the dildo.  One of " + rubiMF("his","her") + " lube covered hands reaches forwards, pulling you close, while the other reaches beneath " + rubiMF("him","her") + ", making sure the dildo is positioned correctly.  " + rubiMF("His","Her") + " lips meet yours again just as " + rubiMF("he","she") + " lowers " + rubiMF("him","her") + "self down onto the rubbery horsecock.  What follows is the most passionate moan you've ever heard from Rubi, directed into your mouth.");
		
		outputText("\n\n\"<i>Mmm, oh gods,</i>\" " + rubiMF("he","she") + " exclaims, your lips parting from one another.  \"<i>It's so </i>big!\"  Rubi sinks down another couple inches, " + rubiMF("his","her") + " face somewhere between torture and ecstasy.  " + rubiMF("He","She") + " backs away from you, enough so that you can see the huge, slick rod currently impaling your lover.");
		
		if(flags[RUBI_COCK_SIZE] > 0) outputText("\n\nRubi's " + rubiCock() + " twitches, rising from its state of semi-hardness.  Within a minute it's standing straight up, creating a noticeable tent in the pale blue, sheer fabric covering your lover's body.  ");
		else outputText("\n\n");
		outputText("It takes another minute or so for Rubi to sink all the way down onto the cock, a huge feat in and of itself… but then, of course, there's the knot.  Even now with it deflated, you're not sure your demonic little vixen could handle it.  In fact, " + rubiMF("he","she") + " struggles with it for quite a while, until you lean over and whisper words of encouragement into " + rubiMF("his","her") + " ear.  Naughty words saying what you'll do to that ");
		if(flags[RUBI_COCK_SIZE] > 0) outputText("ass");
		else outputText("pussy");
		outputText(" once it's been properly trained.");
		
		outputText("\n\nNeeding no more encouragement, Rubi pushes " + rubiMF("him","her") + "self down further.  " + rubiMF("His","Her") + " eyes rolling up into their sockets in delight as " + rubiMF("his","her") + " ");
		if(flags[RUBI_COCK_SIZE] > 0) outputText("asshole");
		else outputText("cunt");
		outputText(" is stretched nearly to its limits.  Finally " + rubiMF("he","she") + " lets out a sigh of relief as the knot pops completely into place.  \"<i>Oh… fuck me it's so big,</i>\" " + rubiMF("he","she") + " squeals, " + rubiMF("his","her") + " body visibly shaking.  Rubi's tongue lolls out, dripping a bit of spittle down " + rubiMF("his","her") + " chin.");
		
		outputText("\n\nRubi's breath grows more and more ragged as " + rubiMF("he","she") + " gyrates " + rubiMF("his","her") + " hips around on the dildo.  Breathy, primal moans escape " + rubiMF("his","her") + " lips.  You've never seen " + rubiMF("him","her") + " this turned on before.  It must be something in the lube, or maybe " + rubiMF("he","she") + " is really just an exhibitionist, getting off by putting this show on for you.  Either way, you're not exactly complaining, especially when " + rubiMF("his","her") + " hands suddenly dart towards your [armor] grasping madly for the prize hidden within.");
		
		outputText("\n\nNot one to disappoint, especially such an eager slut, you disrobe as quickly as you can manage, settling back into position in front of Rubi.  [EachCock] bobs to attention immediately.  " + rubiMF("He","She") + " wastes no time.  Leaning forward, " + rubiMF("he","she") + " grasps the base with one hand, while guiding the [cockHead biggest] to " + rubiMF("his","her") + " mouth with the other.");
		
		outputText("\n\nA warm sensation rolls over you as the demon-morph's tongue makes contact.  Soft and wet, it rolls around the tip of your cock like a wave.  A sex-starved, hungry wave.  The sensual, velvety wave is followed up by a pair of lips wrapping around your tremendous manhood, clamping down like a vice.  Rubi sucks, drawing what seems like all the blood from your body right to the tip of your dick, enhancing all the sensations assaulting your brain a hundred fold.");
		
		outputText("\n\nAs the wanton slut between your legs goes to work, you notice the small air pump for " + rubiMF("his","her") + " dildo laying next to you.  A devilish smile crosses your face.  With Rubi's eyes closed, " + rubiMF("his","her") + " head bobbing up and down on your [cock biggest], " + rubiMF("he","she") + " doesn't notice you take hold of it.  " + rubiMF("He","She") + " does notice, however, when you give it a light squeeze.  No doubt the knot firmly lodged in " + rubiMF("his","her") + " ");
		if(flags[RUBI_NO_CUNT] == 1) outputText("anus");
		else outputText("cunt");
		outputText(" just widened slightly.  Rubi's eye go wide as " + rubiMF("he","she") + " looks up at you with a mouth full of cock, moaning something you can't understand.");
		
		outputText("\n\nYou wonder if " + rubiMF("he","she") + " wants you to pump it again.  So you do.  Rubi's mouth vibrates around your cock as " + rubiMF("he","she") + " moans louder, " + rubiMF("his","her") + " eyes beginning to roll back into " + rubiMF("his","her") + " head.  Another pump.  ");
		if(flags[RUBI_COCK_SIZE] > 0) outputText("You can feel your lover's cock straining against your leg, aching for some release.  You idly press your foot against it, feeling a slick layer of precum coating it from top to bottom already.  ");
		outputText("A pleading look enters Rubi's eyes.  You hold up the pump and ask " + rubiMF("him","her") + " if " + rubiMF("he","she") + " wants you to use it again.  " + rubiMF("He","She") + " gives " + rubiMF("his","her") + " head a quick nod of assent, and reaffirms this by taking your [cock biggest] even deeper into " + rubiMF("his","her") + " mouth.");
		
		outputText("\n\nYou give it a quick pump, followed by a second, final one.  Rubi's ");
		
		if(flags[RUBI_EYE_TYPE] == 0 || rubiBimbo()) outputText("green");
		else if(flags[RUBI_EYE_TYPE] == 1) outputText("purple");
		else outputText("shiny black");
		outputText(" eyes close tight as " + rubiMF("he","she") + " succumbs to a brain-melting orgasm.  " + rubiMF("His","Her") + " entire body trembles, from " + rubiMF("his","her") + " curling toes right up " + rubiMF("his","her") + " twitching, painted fingers.");
		if(flags[RUBI_COCK_SIZE] > 0) outputText("  Even, no, <i>especially</i> " + rubiMF("his","her") + " cock twitches and spasms jerking upwards and splattering globules of sticky white goo against the inside of Rubi's babydoll before dripping down onto the floor between " + rubiMF("his","her") + " legs, creating a rapidly growing puddle.");
		
		outputText("\n\nYou don't last much longer either.  Even as Rubi experiences that mind-altering climax, " + rubiMF("he","she") + " continues to suck and lick your large dick until you feel the warm fires of ecstasy growing in your veins.  You imagine what it will be like to finally plunge this meaty cock inside Rubi's ");
		if(flags[RUBI_NO_CUNT] > 0) outputText("ass");
		else outputText("cunt");
		outputText(", to make " + rubiMF("him","her") + " squeal from your actions, and not that of a lifeless dildo.  You imagine the " + rubiMF("demon","demoness") + "'s hot, wet walls clamped around you, milking you for everything you've got.");
		
		outputText("\n\nAnd that's enough to push you over.  You grip the soft sheets of the bed and stifle a moan of your own.  The heat in your body rises, centering around the cock you have half-buried in Rubi's throat.  You can feel the intensity building, and do your best to hold it back, but to no avail.  With a loud grunt you cum, loosing one spray of pearlescent jizz after another deep into your lover's gullet.  " + rubiMF("He","She") + " gulps it all down eagerly, trying not to waste a drop.");
		
		outputText("\n\nRubi pulls " + rubiMF("his","her") + " head back finally, just in time for two last jets of cum to blast " + rubiMF("him","her") + " in the face.  " + rubiMF("He","She") + " just gives you a sultry smile, however, and scoops up the remaining mass of sweet semen with " + rubiMF("his","her") + " fingers before licking them clean.  You collapse back onto the bed, completely spent.  You hadn't expected things to go that way.  Not that you're complaining of course.");
		
		outputText("\n\nYou hear a soft popping sound, and are soon joined by Rubi on the bed.  \"<i>Mmm, I'm glad you enjoyed that, babe,</i>\" " + rubiMF("he","she") + " says, still licking " + rubiMF("his","her") + " hands clean.  \"<i>I hope we can do it again soon.</i>\"  " + rubiMF("He","She") + " wraps an arm around you and begins drifting off to sleep.  " + rubiMF("He","She") + " was obviously exhausted after that powerful stretching session.");
		
		outputText("\n\nYou stay with " + rubiMF("him","her") + " for a good ten minutes before slipping out of " + rubiMF("his","her") + " grasp, and putting a pillow in your place, which Rubi gratefully hugs.  You turn to make your way out of the room, when you see the toy chest again.  You hunch down, poking through the chest until you spot it... a huge, black rubbery buttplug.  A sly grin creeps across your face as you retrieve the plug and sidle into the bed behind Rubi.  " + rubiMF("He","She") + " hums slightly at your presence.  You run a hand along " + rubiMF("his","her") + " body and dip it between " + rubiMF("his","her") + " legs, slipping a finger inside " + rubiMF("his","her") + " slightly gaping ");
		if(flags[RUBI_NO_CUNT] == 1) outputText("ass");
		else outputText("pussy");
		outputText(".");
		
		outputText("\n\nWhen Rubi turns " + rubiMF("his","her") + " head around to question your actions, you smirk and slip the plug inside " + rubiMF("him","her") + ".  Rubi's eyes shut tight and " + rubiMF("he","she") + " stifles a moan, any question or comment forgotten.  You whisper into " + rubiMF("his","her") + " ");
		if(flags[RUBI_EAR_TYPE] == 0) outputText("ear");
		else if(flags[RUBI_EAR_TYPE] == 1) outputText("feline ear");
		else outputText("feathered ear");
		outputText(" that " + rubiMF("he","she") + " should keep that in for a few hours, just to make sure this training takes hold.  Rubi gives you a small smile in response along with a small peck on the cheek before slipping under the sheets for a quick nap.");
		outputText("\n\nYou decide this is the best time to head out as well, and make your way out of the apartment and back to camp.");
		stats(0,0,0,0,0,0,-100,0);
	}
	doNext(13);
}

//Get Fucked
//PC gets fucked by Rubi
//Rubi must have at least a 5" cock
//Requires 75 Affection
function getFuckedByRubi():void {
	clearOutput();
	outputText("Rather than wait for you to initiate something, Rubi takes you by the hands and leads you into the bedroom.  " + rubiMF("He","She") + " puts one arm on your shoulder and runs " + rubiMF("his","her") + " fingers up through the hair on the back of your head before pulling you into a deep kiss.  Rubi's ");
	//(normal/furry skin)
	if(flags[RUBI_SKIN] == 0 || flags[RUBI_SKIN] == 2) outputText("red");
	else outputText("black");
	outputText(" lips feel so delicate against yours, but they quickly part as " + rubiMF("his","her") + " tongue slithers between them, exploring the depths of your warm, wet mouth.");
	
	outputText("\n\nRubi smiles after you break the kiss, looking at you a little sheepishly.  \"<i>I'm sorry babe, I just...  I've been wanting to do this for so long,</i>\" " + rubiMF("he","she") + " says, " + rubiMF("his","her") + " hand slipping between " + rubiMF("his","her") + " legs, where you notice a sizeable bulge in " + rubiMF("his","her") + " clothing.  " + rubiMF("His","Her") + " dainty hands grip your arms and " + rubiMF("he","she") + " pushes you backwards onto the bed, though your [legs] dangle off the end.");
	
	outputText("\n\nDespite this uncharacteristic shift, " + rubiMF("his","her") + " movements are insistent, but not forceful.  " + rubiMF("His","Her") + " glittering ");
	if(flags[RUBI_EYE_TYPE] == 0 || rubiBimbo()) outputText("green");
	else if(flags[RUBI_EYE_TYPE] == 1) outputText("purple");
	else outputText("black");
	if(flags[RUBI_EYE_TYPE] > 0) outputText(" slitted");
	outputText(" eyes constantly meet yours, looking for approval, before and after every act.  You're certain you're still the one in charge here... but you're simply letting Rubi take the lead.");
	
	outputText("\n\nThe young demon-morph hurriedly strips you out of your [armor] and licks " + rubiMF("his","her") + " lips at the sight of your naked, prone form.  " + rubiMF("He","She") + " slips down to " + rubiMF("his","her") + " knees and whispers, \"<i>Let's get this ");
	if(!player.hasVagina()) outputText("asshole");
	else outputText("cunt");
	outputText(" of yours all ready for me.</i>\"  Rubi's head descends between your legs");
	if(player.hasCock()) outputText(", ignoring your " + multiCockDescriptLight() + " completely,");
	outputText(" and presses " + rubiMF("his","her") + " face into your [vagOrAss], inhaling deeply.  " + rubiMF("His","Her") + " lips pucker as " + rubiMF("he","she") + " plants a kiss directly onto your ");
	if(!player.hasVagina()) outputText("ass");
	else outputText("moistening pussy");
	outputText(".  You let out a small moan and lean backwards, taking your eyes off the ");
	if(flags[RUBI_HAIR] == 0) outputText("black-haired");
	else outputText("blonde");
	outputText(" head betwixt your thighs and taking in the sensations.");
	
	outputText("\n\nRubi wraps " + rubiMF("his","her") + " lips around your [vagOrAss] and flicks " + rubiMF("his","her") + " tongue along the sensitive flesh.  You shiver and sprawl out on the bed, taking it all in.  Rubi lavishes your tight hole with " + rubiMF("his","her") + " lips and tongue, lapping and slurping messily, all in preparation for what is to come, no doubt.  But " + rubiMF("he","she") + " doesn't get ahead of " + rubiMF("him","her") + "self, and takes " + rubiMF("his","her") + " time to make sure you're good and ready.  " + rubiMF("His","Her") + " perfectly manicured fingers trace patterns only " + rubiMF("he","she") + " can decipher on your inner thigh, movements so delicate and precise that your body quivers of its own accord.  " + rubiMF("His","Her") + " other hand slips up your stomach, inching along and teasing your flesh with the same arcane movements of " + rubiMF("his","her") + " fingers.");
	
	outputText("\n\nWith your crotch freshly lubricated, Rubi stands and quickly disrobes, adding to the pile of clothing on the floor.  " + rubiMF("His","Her") + " feminine hands run down " + rubiMF("his","her") + " body and grasp at the " + rubiCock() + " sprouting from " + rubiMF("his","her") + " groin, stroking it to its full length.  Its ");
	if(flags[RUBI_COCK_TYPE] == CockTypesEnum.legacySuportLoadCockType("HUMAN")) outputText("pink, mushroom-like tip");
	else if(flags[RUBI_COCK_TYPE] == CockTypesEnum.legacySuportLoadCockType("DEMON")) outputText("purple, nodule-laden tip");
	else if(flags[RUBI_COCK_TYPE] == CockTypesEnum.legacySuportLoadCockType("HORSE")) outputText("blunted, musky tip");
	else if(flags[RUBI_COCK_TYPE] == CockTypesEnum.legacySuportLoadCockType("TENTACLE")) outputText("tentacle-ringed crown");
	outputText(" emerges from the foreskin surrounding it as " + rubiMF("his","her") + " cock strains, aching for something, anything to fill.");

	outputText("\n\nWith a look into your eyes, confirming " + rubiMF("his","her") + " desires, " + rubiMF("he","she") + " gives " + rubiMF("his","her") + " cock what it wants.  One swift motion is all it takes as Rubi sinks " + rubiMF("his","her") + " dick inside you several inches.  The feeling of penetration makes you moan suddenly, louder than you wanted to.  Rubi smiles, pulls out a few inches, and pushes back inside, just a little deeper.  This time it's your demonic lover's turn to moan as you clamp your [vagOrAss] around " + rubiMF("his","her") + " invading member, tightening around " + rubiMF("him","her") + " like a vice.");
	if(!player.hasVagina()) buttChange(flags[RUBI_COCK_SIZE] * flags[RUBI_COCK_SIZE]/6,true,true,false);
	else cuntChange(flags[RUBI_COCK_SIZE] * flags[RUBI_COCK_SIZE]/6,true,true,false);

	outputText("\n\nRubi takes hold of one of your legs, lifting it up onto " + rubiMF("his","her") + " shoulder and thrusts in just a little bit deeper.  The movement is just right, rubbing your ");
	if(!player.hasVagina()) outputText("prostate");
	else outputText("g-spot");
	outputText(" briefly, but enough to send a hot shiver up your spine.  Seeing this reaction, Rubi's smile widens into a grin and begins to thrust in and out at a slow pace.  Every thrust brushes past your sensitive ");
	if(!player.hasVagina()) outputText("prostate");
	else outputText("g-spot");
	outputText(", and one by one your limbs start to tingle.  In and out, " + rubiMF("he","she") + " goes, and you can feel something building inside you.");

	outputText("\n\nYour arms tingle, hands gripping at the sheets in an attempt to anchor yourself.  Your [legs] shiver as goose bumps rise on your flesh.  One leg spasms wildly, unwilling to follow your brain's commands in the face of this rising pleasure.  Your head spins, awash in feelings of bliss and something else... could it be love?  You bite your lip, your face contorting into a look of needful desperation.  Love for this demon-tainted " + rubiMF("boy","girl") + ", for this person who's shared their secrets, their life with you?  Your mind grows foggy, and at this point not even you are certain of the true answer buried under all of these sensations.  The look on Rubi's face, however, is as plain as day.  Adoration pours from " + rubiMF("him","her") + " as " + rubiMF("he","she") + " pounds away, fucking your [vagOrAss] faster and faster with each measure, careful thrust.");
	
	outputText("\n\nSeveral things happen in quick succession.  First, your lover glances down at you with that same look " + rubiMF("he","she") + "'s used all day.  That questioning, submissive look, the look that just minutes ago said, \"<i>Can I fuck you?\</i>\"  Now it says, through the guise of those sparkling ");
	if(flags[RUBI_EYE_TYPE] == 0 || rubiBimbo()) outputText("green");
	else if(flags[RUBI_EYE_TYPE] == 1) outputText("purple");
	else outputText("black");
	if(flags[RUBI_EYE_TYPE] > 0) outputText(" slitted");
	outputText(" eyes, \"<i>Can I come inside you?</i>\"");
	
	outputText("\n\nSecond, your heart skips a beat.  Third, a lump forms in your throat.  You swallow hard, attempting to rid yourself of it, but it persists.  Your stomach churns, as if butterflies were swarming around inside of it.  Fourth, without really thinking about it... you nod.  It's a short, almost imperceptible movement, but Rubi picks up on it.");
	
	outputText("\n\n" + rubiMF("His","Her") + " cock plunges in, putting a new, renewed pressure on your ");
	if(!player.hasVagina()) outputText("prostate");
	else outputText("g-spot");
	outputText(".  Orgasmic energy suddenly bursts outwards from your crotch.  The tingling, needful sensations in your limbs explode in turn, showering your nerves with cool euphoria.  It washes over you like a tidal wave, causing your body to tense, your back arching and limbs jerking violently.  Your mouth parts and you can't help but scream, \"<i>Yes, yes!</i>\" repeatedly, not caring who could possibly hear you.  Rubi gives one last thrust, causing another miniature orgasm to rock across you, and giving you the acute sensation of being filled, as " + rubiMF("his","her") + " body joins yours in its sex rapture.");
	
	outputText("\n\nRubi's " + rubiCock() + " surges inside you, releasing one jet after another of warm, sticky jism into your needy ");
	if(!player.hasVagina()) outputText("bowels");
	else outputText("womb");
	outputText(".  ");
	
	//(Blueballs 4-6)
	if(flags[RUBI_BLU_BALLS] < 4) {}
	else if(flags[RUBI_BLU_BALLS] <= 6) {
		outputText("There's so much of it that it oozes out from your abused ");
		if(!player.hasVagina()) outputText("ass");
		else outputText("cunt");
		outputText(", dribbling down your buttcheeks and pooling onto the bed and floor below.  ");
	}
	//(Blueballs 6-9)
	else if(flags[RUBI_BLU_BALLS] <= 9) {
		outputText("Your insides rumble suddenly as Rubi's impressive load begins to fill you up, " + rubiMF("his","her") + " seed slipping into every available nook and cranny.  What doesn't fit slips out of your abused ");
		if(!player.hasVagina()) outputText("ass");
		else outputText("cunt");
		outputText(" in a small torrent, pooling onto the bed and floor below.  ");
	}
	//(Blueballs 10)
	else outputText("Your insides rumble dangerously and your stomach actually swells up, gaining a noticeable paunch as Rubi's lavish load coats your insides, filling every available nook and cranny and even creating new ones.  What doesn't fit slips out of your abused hole in a flood, coating the bed and floor beneath you in a slick, white glaze.  ");
	outputText("Rubi doesn't stop there, however, " + rubiMF("he","she") + " continues to assail your [vagOrAss], bringing you to several more miniature, body-shaking orgasms, until " + rubiMF("he","she") + " just can't handle any more, and " + rubiMF("he","she") + " pulls out, " + rubiMF("his","her") + " cock still rather erect and looking cozy in its jacket-like foreskin.");
	
	outputText("\n\nYou waggle a finger at " + rubiMF("him","her") + " hazily, and " + rubiMF("he","she") + " climbs up onto the bed next to you.  You wrap your arms around " + rubiMF("him","her") + " and kiss " + rubiMF("him","her") + " passionately before pulling " + rubiMF("him","her") + " into a cuddling hug.  The two of you drift off into a short nap, contentedly wrapped up in each other's arms.");
	stats(0,0,0,0,0,2,-100,0);
	doNext(13);
}

//Hotdogging
//PC hotdogs Rubi's ass
//PC must have a penis
//If Rubi is being teased, adds +1 to blueballs
//-100 arousal for PC
function rubiHotdogging():void {
	clearOutput();
	outputText("You sit on the couch next to your sexy lover and pull " + rubiMF("him","her") + " onto your lap with one smooth motion.  Rubi giggles, wiggling in place for a moment before leaning down to kiss you on the lips.  You put one hand on " + rubiMF("his","her") + " supple ass, and another on " + rubiMF("his","her") + " back between " + rubiMF("his","her") + " shoulders and pull " + rubiMF("him","her") + " close, pressing your [tongue] into " + rubiMF("his","her") + " mouth.  You sensually explore your partner's mouth as " + rubiMF("he","she") + " closes " + rubiMF("his","her") + " eyes and moans.");
	outputText("\n\nThe two of you break the kiss long enough to gasp for breath, and go at it once more.  In your lip-locked escapade you blindly grasp at Rubi's clothing, stripping " + rubiMF("him","her") + " down, layer by layer until the ");
	if(flags[RUBI_SKIN] == 0) outputText("pale skinned");
	else if(flags[RUBI_SKIN] == 1 || flags[RUBI_SKIN] == 3) outputText("red skinned");
	else outputText("fur-covered");
	outputText(" " + rubiMF("boy","girl") + " lays naked on your lap.  Rubi giggles and dips a hand between " + rubiMF("his","her") + " thighs ");
	if(flags[RUBI_COCK_SIZE] > 0) outputText("taking hold of " + rubiMF("his","her") + " cock");
	else outputText("rubbing a finger along " + rubiMF("his","her") + " clit");
	outputText(" while " + rubiMF("he","she") + " says, \"<i>So babe, what do you intend to do?  Are you going to hold me down and ravish me?  What will it be?</i>\"");
	
	outputText("\n\nRubi wiggles " + rubiMF("his","her") + " hips, eagerly awaiting your reply while your lips curl into a smirk.  Well, " + rubiMF("he","she") + "'s sure getting antsy, isn't " + rubiMF("he","she") + "?");
	
	outputText("\n\nRubi responds with a giggle and a nod of " + rubiMF("his","her") + " head.  \"<i>Oh yes, I'm positively </i>aching<i> for you, babe,</i>\" " + rubiMF("he","she") + " says, slipping off your lap and onto " + rubiMF("his","her") + " knees at your feet.");
	
	outputText("\n\nYou grunt in approval at this show of submission and lean back on the couch, stretching your arms wide along the back.  You tell the little minx at your feet to get you ready first, before " + rubiMF("he","she") + " gets " + rubiMF("his","her") + " needs met.  " + rubiMF("His","Her") + " ruby red lips morph into a grin, and " + rubiMF("he","she") + " wastes no time in freeing your [cock biggest] from its trappings.  Rubi smacks " + rubiMF("his","her") + " lips and descends upon your half-hard cock, planting a kiss on its tip, and down each and every inch.");
	
	outputText("\n\nYou sigh happily and sink deeper into the soft cushions of the couch, exulting as the fiery slut betwixt your legs goes to work.  " + rubiMF("His","Her") + " lips pucker around the outside of your shaft, leaving a hazy reddish smudge of lipstick behind.  It isn't long until more such blotches join it, creating a \"crown\" of lipstick marks wreathing your [cockHead biggest].  Your [cock biggest] throbs almost painfully, oozing precum from its cumslit, which Rubi eagerly laps at, letting it roll over " + rubiMF("his","her") + " tongue and then down " + rubiMF("his","her") + " throat.");
	
	outputText("\n\nAs content as you are to just sit back and wait until you pop in Rubi's mouth, you've got other, more devilish plans.  You wave " + rubiMF("him","her") + " off and stand up.  The little demon " + rubiMF("boy","girl") + " looks a little disappointed at first, but the prospect of something more causes " + rubiMF("him","her") + " to smile up at you expectantly.  You have Rubi climb up onto the couch and kneel with " + rubiMF("his","her") + " back to you.");
	
	outputText("\n\n" + rubiMF("He","She") + " shudders as you run a hand down " + rubiMF("his","her") + " back, down " + rubiMF("his","her") + " spine and lightly circling the base of " + rubiMF("his","her") + " tail.  You run the tip of your fingers along " + rubiMF("his","her") + " sides, just barely touching " + rubiMF("his","her") + " soft, ");
	if(flags[RUBI_SKIN] != 2) outputText("tender skin");
	else outputText("silky fur");
	outputText(".  Rubi's back arches and a soft gasp escapes " + rubiMF("his","her") + " lips.  " + rubiMF("His","Her") + " body reflexively jerks towards your hand, hoping for more than a simple teasing touch, but you pull your hand away and give " + rubiMF("his","her") + " round ass a playful smack, chastising " + rubiMF("him","her") + ".");
	
	outputText("\n\n\"<i>S-Sorry, babe,</i>\" " + rubiMF("he","she") + " says, " + rubiMF("his","her") + " voice shaky, \"<i>It's just that it feels so good, I can't help myself.</i>\"  You forgive " + rubiMF("him","her") + " easily, but say that if " + rubiMF("he","she") + " wants to cum at the end of all this, " + rubiMF("he","she") + "'s going to have to remain still and follow your every command.  Rubi swallows hard, but nods happily,  \"<i>Ooh, really taking charge, hm?  Do your worst, babe.</i>\"  You shoot " + rubiMF("him","her") + " back a malevolent grin and assure " + rubiMF("him","her") + " that you will.");
	
	outputText("\n\nYour fingers return to the spellbound demon before you, tantalizing " + rubiMF("his","her") + " flesh with the slightest of touches.  It does its job, as between " + rubiMF("his","her") + " legs you can see " + rubiMF("his","her") + " ");
	if(flags[RUBI_NO_CUNT] == 0) outputText("cunt moistening");
	if(flags[RUBI_NO_CUNT] == 0 && flags[RUBI_COCK_SIZE] > 0) outputText(" and ");
	if(flags[RUBI_COCK_SIZE] > 0) outputText("cock hardening");
	outputText(".  " + rubiMF("He","She") + " obviously enjoys this light, playful teasing.  You give Rubi's ass another playful smack, watching " + rubiMF("his","her") + " ");
	if(flags[RUBI_SKIN] == 0) outputText("pale skin");
	else if(flags[RUBI_SKIN] == 1|| flags[RUBI_SKIN] == 3) outputText("crimson skin");
	else outputText("fur-covered flesh");
	outputText(" jiggle with a smile.");
	
	outputText("\n\nThe teasing doesn't end there, however.  You grasp your lipstick-smudged cock, which hasn't softened one bit, and slip it between Rubi's ass cheeks, eliciting a soft, feminine \"<i>oooh</i>\" from your partner.  You rub the head of your [cock biggest] up and down Rubi's sensuous backdoor, smearing it with your pre-cum, but don't penetrate at all.  Instead, you grab hold of Rubi's buns and squeeze them together, pressing them against your shaft.  You give a light grunt, relishing the feeling of " + rubiMF("his","her") + " silky ");
	if(flags[RUBI_SKIN] != 2) outputText("skin");
	else outputText("coat");
	outputText(" against your manhood as you slowly begin to pump in and out of Rubi's ass cheeks.");
	
	outputText("\n\nRubi, for " + rubiMF("his","her") + " part, groans in frustration at this ultimate tease, but, continuing to follow your instructions, remains stock-still as you plow away at " + rubiMF("his","her") + " plump booty.  As you grunt with every thrust, you start to notice Rubi's arms and legs trembling, and hushed sighs escape from " + rubiMF("his","her") + " lips as well.  This must really be turning " + rubiMF("him","her") + " on!  Without breaking your rhythm, you reach down between " + rubiMF("his","her") + " legs, and slip your thumb into " + rubiMF("his","her") + " ");
	if(flags[RUBI_NO_CUNT] == 1) outputText("asshole");
	else outputText("pussy");
	outputText(", while your index and middle fingers rub slowly around " + rubiMF("his","her") + " ");
	if(flags[RUBI_NO_CUNT] == 0) outputText("clit");
	else outputText("perineum");
	outputText(".");
	
	outputText("\n\nYou think to yourself.  You could keep teasing " + rubiMF("him","her") + " like this, without letting " + rubiMF("him","her") + " cum, as " + rubiMF("he","she") + " obviously delights in the feelings.  Or you could be generous and let " + rubiMF("him","her") + " pop " + rubiMF("his","her") + " load right now... Which will it be?");
	stats(0,0,0,0,0,0,100,0,false);
	menu();
	//[Tease] [Pop]
	addButton(0,"Tease Rubi",teaseButtjobs);
	addButton(1,"Pop",popButtjobs);
}

//Tease
function teaseButtjobs():void {
	clearOutput();
	outputText("Grinning to yourself, you decide to tease the little demon " + rubiMF("boy","girl") + " a little further.  You plunge your thumb further into " + rubiMF("his","her") + " ");
	if(flags[RUBI_NO_CUNT] == 1) outputText("ass");
	else outputText("pussy");
	outputText(", finding " + rubiMF("his","her") + " ");
	if(flags[RUBI_NO_CUNT] == 1) outputText("prostate");
	else outputText("g-spot");
	outputText(" and rubbing circles around it, drawing out a long moan from Rubi's smeared lips.  With every thrust into Rubi's soft ass-pillows you draw another loop around " + rubiMF("his","her") + " most sensitive spot with your digit, until you can feel " + rubiMF("his","her") + " body start to tense up.");
	
	outputText("\n\nAs familiar you are with your lover's body, you can tell when " + rubiMF("he","she") + "'s about to climax, and you wait for that perfect moment, where " + rubiMF("his","her") + " body is at its tensest, " + rubiMF("his","her") + " back arched, toes curled, mouth pulled into that perfect O-shape with " + rubiMF("his","her") + " cock-sucking lips quivering, teetering that edge of orgasm.  And, just like that, you withdraw your thumb and smack " + rubiMF("his","her") + " ass, a little harder than you have before.  " + rubiMF("His","Her") + " body tenses further, and " + rubiMF("he","she") + " bites " + rubiMF("his","her") + " lip, but there's no relief, no blissful release that " + rubiMF("he","she") + " so desired.  You chastise the slutty little doll before you, saying that the only way " + rubiMF("he","she") + "'s going to cum is when you allow it.  Rubi whines slightly, looking back at you with sad, lustful eyes, but " + rubiMF("he","she") + " nods understandingly.");
	
	outputText("\n\nYou feel your orgasm coming on, fueled by Rubi's display of submission.  No matter how you tease " + rubiMF("him","her") + ", " + rubiMF("he","she") + " remains stock-still, with only a shudder and a longing sigh to mark the pleasurable feelings no doubt coursing through " + rubiMF("his","her") + " body.  You grip one buttcheek hard and thrust upwards as much as you can as a dam suddenly breaks within you.  Your [balls] churns pleasurably, your [cock biggest] stiffens suddenly, and you let loose a long, drawn-out sigh as your dick erupts, jetting cum upwards, which immediately splatters against Rubi's tail and back before dripping down " + rubiMF("his","her") + " bountiful asscheeks.");
	
	outputText("\n\nYou immediately spin Rubi around, and " + rubiMF("he","she") + ", getting the idea, wraps " + rubiMF("his","her") + " already cock-smeared lips around the [cockHead biggest] as your cock spasms wildly, loosing spray after spray of sweet jism into Rubi's waiting mouth.  " + rubiMF("He","She") + " gulps it all down ");
	if(player.cumQ() <= 50) outputText("in one go, with a small, proud look on " + rubiMF("his","her") + " face");
	else if(player.cumQ() <= 150) outputText("with one, throat-straining swallow, a small, proud smile taking " + rubiMF("his","her") + " face when " + rubiMF("he","she") + " stops panting for breath");
	else outputText("as it comes, mouthful after mouthful of cum practically injected straight into " + rubiMF("his","her") + " stomach. There's so much of it, " + rubiMF("he","she") + " can't help but smile mid-way through, proud to take such a huge load");
	if(player.cumQ() >= 1000) outputText(".  After guzzling down so much, you're certain Rubi's actually sporting a bit of a belly now, almost as if " + rubiMF("he","she") + " were several months pregnant");
	outputText(".");
	
	outputText("\n\nFinally, with one final spurt of cum that lands on your lover's face, you slip sideways onto the comfortable couch, completely spent.  Rubi, however, seems to have plenty of energy left, and spends the next few minutes dutifully licking over your [cock biggest], cleaning it of your juices until it sits, shiny and pristine, in your lap.");
	
	outputText("\n\nYou laugh and give the demon-" + rubiMF("boy","girl") + " a kiss, remarking how lucky you are to be with " + rubiMF("him","her") + ".");
	
	outputText("\n\n\"<i>No, babe, I'm lucky to have found you,</i>\" " + rubiMF("he","she") + " says, snuggling " + rubiMF("his","her") + " naked body up against yours as the two of you drift off into a lazy, sex-induced nap.");
	flags[RUBI_BLU_BALLS]++;
	flags[RUBI_ORGASM_DENIAL] = 1;
	stats(0,0,0,0,0,0,-100,0);
	doNext(13);
}

//Pop
function popButtjobs():void {
	clearOutput();
	outputText("No, you figure Rubi has been so great lately " + rubiMF("he","she") + " definitely deserves to cum.  You plunge your thumb further into " + rubiMF("his","her") + " ");
	if(flags[RUBI_NO_CUNT] == 1) outputText("ass");
	else outputText("pussy");
	outputText(", finding " + rubiMF("his","her") + " ");
	if(flags[RUBI_NO_CUNT] == 1) outputText("prostate");
	else outputText("g-spot");
	outputText(" and rubbing circles around it, drawing out a long moan from Rubi's smeared lips.  With every thrust into Rubi's soft ass-pillows you draw another loop around " + rubiMF("his","her") + " most sensitive spot with your digit, until you can feel " + rubiMF("his","her") + " body start to tense up.");
	
	outputText("\n\nAs familiar you are with your lover's body, you can tell when " + rubiMF("he","she") + "'s about to climax, and you wait for that perfect moment, where " + rubiMF("his","her") + " body is at its tensest, " + rubiMF("his","her") + " back arched, toes curled, mouth pulled into that perfect O-shape with " + rubiMF("his","her") + " cock-sucking lips quivering, teetering that edge of orgasm.  At just the right moment, you press down hard on that most tender of points, pushing " + rubiMF("him","her") + " over the edge, hard.  Rubi cries out, a high, feminine shout before biting " + rubiMF("his","her") + " lip.");
	
	outputText("\n\nRubi's ");
	if(flags[RUBI_NO_CUNT] == 0) outputText("cunt clamps down on your thumb and gushes, coating your hand in " + rubiMF("his","her") + " slick juices");
	else outputText("asshole quivers and attempts to suck in more of your thumb before clamping down, leaking slick fluids all over your hand");
	outputText(".  " + rubiMF("His","Her") + " entire body spasms as the climax wracks it, one sexy leg suddenly jerking back and forth uncontrollably.  Rubi grips at a pillow, biting it and stifling another orgasmic moan.");
	//(If Rubi has Penis)
	if(flags[RUBI_COCK_SIZE] > 0) outputText("  Beneath " + rubiMF("him","her") + ", " + rubiMF("his","her") + " cock jerks and twitches, loosing a spray of pearly white cum which splatters against the couch below");
	if(flags[RUBI_BLU_BALLS] < 4) {}
	//((blueballs 4-5)
	else if(flags[RUBI_BLU_BALLS] <= 5) outputText(" which is quickly followed by another, more powerful stream of cum, which splashes against " + rubiMF("his","her") + " stomach, coating " + rubiMF("his","her") + " " + rubiBreasts() + " in semen");
	else if(flags[RUBI_BLU_BALLS] <= 7) outputText(" which is quickly followed by another, more powerful stream of cum, and a third, and a fourth.  Before you know it, Rubi's entire torso, including " + rubiMF("his","her") + " " + rubiBreasts() + " are practically glazed with cum");
	else if(flags[RUBI_BLU_BALLS] <= 9) outputText(" which is followed up by several more, each seemingly more poweful than the one previous.  Rubi's body twitches and shudders with every jet, until " + rubiMF("his","her") + " entire torso, and the couch, is covered in the musky jizz");
	else outputText(" which is followed by a dozen more, each one thicker and more powerful than the last.  Rubi's cock twitches uncontrollably, just like " + rubiMF("his","her") + " body, as it coats the entire couch, " + rubiMF("his","her") + " entire upper body, and even some of the wall five feet away in the musky stuff");
	outputText(".");

	outputText("\n\nYou feel your orgasm coming on, fueled by Rubi's own intense-looking one.  " + rubiMF("His","Her") + " body lays face down on the couch, ass high into the air as you rub your cock between " + rubiMF("his","her") + " supple ass.  Small aftershocks of bliss ripple through " + rubiMF("his","her") + " body as you grip one buttcheek hard and thrust upwards as much as you can as a dam suddenly breaks within you.  Your [balls] ");
	if(player.balls > 1) outputText("churn");
	else outputText("churns");
	outputText(" pleasurably, your [cock biggest] stiffens suddenly, and you let loose a long, drawn-out sigh as your dick erupts, jetting cum upwards, which immediately splatters against Rubi's tail and back before dripping down " + rubiMF("his","her") + " bountiful asscheeks.");
	
	outputText("\n\nYou immediately spin Rubi around, and though " + rubiMF("he","she") + "'s still recovering from " + rubiMF("his","her") + " own mind-wracking orgasm, " + rubiMF("he","she") + " seems to get the idea, and wraps " + rubiMF("his","her") + " already cock-smeared lips around the [cockHead biggest] as your cock spasms wildly, loosing spray after spray of sweet jism into Rubi's waiting mouth.  " + rubiMF("He","She") + " gulps it all down ");
	if(player.cumQ() <= 50) outputText("in one go, with a small, proud look on " + rubiMF("his","her") + " face");
	else if(player.cumQ() <= 150) outputText("with one, throat-straining swallow, a small, proud smile taking " + rubiMF("his","her") + " face when " + rubiMF("he","she") + " stops panting for breath");
	else outputText("as it comes, mouthful after mouthful of cum practically injected straight into " + rubiMF("his","her") + " stomach. There's so much of it, " + rubiMF("he","she") + " can't help but smile mid-way through, proud to take such a huge load");
	if(player.cumQ() >= 1000) outputText(".  After guzzling down so much, you're certain Rubi's actually sporting a bit of a belly now, almost as if " + rubiMF("he","she") + " were several months pregnant");
	outputText(".");
	
	outputText("\n\nFinally, with one final spurt of cum that lands on your lover's face, you slip sideways onto the comfortable couch, completely spent.  Rubi, however, seems to have plenty of energy left, and spends the next few minutes dutifully licking over your [cock biggest], cleaning it of your juices until it sits, shiny and pristine, in your lap.");

	outputText("You laugh and give the demon-" + rubiMF("boy","girl") + " a kiss, remarking how lucky you are to be with " + rubiMF("him","her") + ".");
	
	outputText("\n\n\"<i>No, babe, I'm lucky to have found you,</i>\" " + rubiMF("he","she") + " says, snuggling " + rubiMF("his","her") + " naked body up against yours as the two of you drift off into a lazy, sex-induced nap.");
	stats(0,0,0,0,0,0,-100,0);
	doNext(13);
}

//Give Item
//(Can give him Purified Succubus Milk, grows boobs, shrinks penis.)
//(Can give him Purified Incubus Draft, shrinks boobs, grows penis.)
//(Can give him Gro+ to grow either one.)
function giveRubiATFItem(short:String):void {
	clearOutput();
	//First Time Giving a TF Item
	if(flags[RUBI_TIMES_GIVEN_AN_ITEM] == 0) {
		outputText("Rubi looks at the offered item, curiously.  " + rubiMF("He","She") + " turns it over in " + rubiMF("his","her") + " hands, carefully examining the liquid within.  Finally " + rubiMF("he","she") + " asks apprehensively, \"<i>Is this going to... change my body?</i>\"");
		outputText("\n\nYou nod slowly, explaining its effects to the young demon-morph.  Rubi absently bobs " + rubiMF("his","her") + " head along as you explain its effects.  \"<i>So, you want me to change?</i>\" " + rubiMF("he","she") + " says when you're done.  \"<i>I mean... I'm fine the way I am, but if you want me to change...</i>\"  Rubi looks up at you, with love shining in " + rubiMF("his","her") + " eyes.  \"<i>If you want me to change I'll gladly do it.</i>\"\n\n");
	}
	flags[RUBI_TIMES_GIVEN_AN_ITEM]++;
	//[go to TF scene]
	//Succubus Milk
	if(short == "SucMilk" || short == "P.S.Mlk") {
		if(short == "SucMilk") {
			//Increase bust size by 1.
			//Decrease penis size by 1.
			//Random chance to give vagina (will always give it if Rubi has no penis or penis is just removed).
			//Random chance to give demonic high heels.
			//Random chance to give horns.
			//Random chance to give red skin.
			outputText("You hand over the bottle of milky white fluids to Rubi.  " + rubiMF("He","She") + " takes a moment to read over the pink label before pulling out the cork and downing the whole bottle in one gulp.");
		}
		else {
			//Purified Succubus Milk
			//Increase bust size by 1. (See Succubus Milk)
			//Decrease penis size by 1. (See Succubus Milk)
			//Random chance to give vagina (will always give it if Rubi has no penis or penis is just removed). (See Succubus Milk)
			outputText("You hand over the bottle of purified milky white fluids to Rubi.  " + rubiMF("He","She") + " takes a moment to read over the pink label before pulling out the cork and downing the whole bottle in one gulp.");
		}
		//(If Bust size increases)
		if(flags[RUBI_BREAST_SIZE] < 7 || (flags[RUBI_BREAST_SIZE] < 30 && flags[HYPER_HAPPY])) {
			outputText("\n\nRubi gasps a little and " + rubiMF("his","her") + " hands immediately dart to " + rubiMF("his","her") + " chest.  Before your eyes, Rubi's breasts begin to swell, growing an entire cup size.  Rubi cups " + rubiMF("his","her") + " breasts experimentally, getting used to their new weight.");
			flags[RUBI_BREAST_SIZE]++;
		}		
		//(If Penis size decreases)
		if((flags[RUBI_COCK_SIZE] > 4) && (!flags[HYPER_HAPPY])) {
			outputText("\n\nRubi's " + rubiCock() + " swells up suddenly, growing painfully hard.  " + rubiMF("He","She") + " grasps it and moans suddenly as it begins to dwindle in size, shrinking down by at least an inch, leaving " + rubiMF("him","her") + " with a ");
			flags[RUBI_COCK_SIZE]--;
			outputText(Math.round(flags[RUBI_COCK_SIZE]*10)/10 + "-inch penis.");
		}
		//(If Penis is removed) 
		else if(flags[RUBI_COCK_SIZE] <= 4 && flags[RUBI_COCK_SIZE] > 0) {
			outputText("\n\nRubi's cock swells up slightly, its inch-long hardness reminding you of a large clitoris at this point.  However, it doesn't remain for long.  The inch-long dick begins to dwindle away, retracting into the demon-morph's groin until it shrivels into nothingness.  Rubi's hand dives between " + rubiMF("his","her") + " thighs, grasping for " + rubiMF("his","her") + " lost manhood, but to no avail.");
			flags[RUBI_COCK_SIZE] = 0;
			//if Penis is removed AND no vagina exists; add
			if(flags[RUBI_NO_CUNT] == 1) {
				outputText("\n\nRubi shudders suddenly, a soft moan escaping " + rubiMF("his","her") + " lips.  " + rubiMF("His","Her") + " fingers dive deeper, seemingly going inside " + rubiMF("his","her") + " body!  Although it seems strange, you're certain that <b>Rubi has grown a brand new vagina</b>.");
				flags[RUBI_NO_CUNT] = 0;
				flags[RUBI_SHE] = 1;
				flags[RUBI_CUNTTYPE] = 0;
			}
		}
		//(If Rubi randomly gets vagina)
		if(rand(3) == 0 && flags[RUBI_NO_CUNT] > 0) {
			outputText("\n\nRubi shudders suddenly, a soft moan escaping " + rubiMF("his","her") + " lips.  " + rubiMF("His","Her") + " fingers dive between " + rubiMF("his","her") + " thighs, seemingly going inside " + rubiMF("his","her") + " body!  Although it seems strange, you're certain that <b>Rubi has grown a brand new vagina</b>.  \"<i>Oooh,</i>\" Rubi says, " + rubiMF("his","her") + " body quivering.  \"<i>It's so sensitive!</i>\"");
			flags[RUBI_NO_CUNT] = 0;
			flags[RUBI_SHE] = 1;
		}
		//(If Rubi gets demonic heels)
		if(flags[RUBI_FEET] == 0 && rand(3) == 0 && short == "SucMilk") {
			outputText("\n\nRubi suddenly hops from foot to foot, breathing in sharply.  \"<i>Ow, ow, ow!</i>\" " + rubiMF("he","she") + " exclaims, dropping down onto " + rubiMF("his","her") + " naked butt.  " + rubiMF("He","She") + " lifts one foot gingerly, inspecting the heel and sole.  Rubi rocks back and forth, craddling " + rubiMF("his","her") + " foot as a pronounced bulge appears on the heel.  Soon, it splits as a sharp black horn grows out, pointing downwards.  After a minute of this, Rubi suddenly sighs with relief as the painful growth seems to subside.  " + rubiMF("He","She") + " gets to " + rubiMF("his","her") + " feet, the horn making " + rubiMF("him","her") + " stand and walk as if " + rubiMF("he","she") + " were wearing high heels.");
			flags[RUBI_FEET] = 1;
		}
		//(If Rubi gets horns)
		if(rand(3) == 0 && flags[RUBI_HORNTYPE] == 0 && short == "SucMilk") {
			outputText("\n\nRubi's hands suddenly dart up, clutching " + rubiMF("his","her") + " head as though " + rubiMF("he","she") + " has a massive headache.  " + rubiMF("He","She") + " feels around blindly, trying to locate the source of the pain, and then you see it.  Two small bulges appear on " + rubiMF("his","her") + " forehead, just at the hairline.  They grow larger and larger until the skin splits cleanly open revealing shiny black bone.  Horns.  They grow up and backwards, forming light ridges.  They don't quite grow completely past " + rubiMF("his","her") + " head, however, before the growth stops.  Rubi calms and stands.  " + rubiMF("His","Her") + " hands roam over every inch of " + rubiMF("his","her") + " new addition as glances in the mirror, marveling at " + rubiMF("his","her") + " demonic appearance.");
			flags[RUBI_HORNTYPE] = 1;
		}
		//(If Rubi gets red skin)
		if(rand(3) == 0 && flags[RUBI_SKIN] != 1 && short == "SucMilk") {
			outputText("\n\nRubi clutches " + rubiMF("his","her") + " stomach suddenly as you notice red spots appearing on " + rubiMF("his","her") + " ");
			if(flags[RUBI_SKIN] != 2) outputText("skin");
			else outputText("coat of fur");
			outputText(".  The blotches soon spread, rapidly overtaking " + rubiMF("his","her") + " body.  ");
			if(flags[RUBI_SKIN] == 2) outputText("Meanwhile the silky soft fur that covered " + rubiMF("his","her") + " body seems to be falling out as this red menace takes over.  ");
			outputText("In no time at all, " + rubiMF("his","her") + " smooth, hairless skin now appears to be a deep crimson, matching the color of " + rubiMF("his","her") + " spade tail that " + rubiMF("he","she") + " received long ago.");
			flags[RUBI_SKIN] = 1;
		}
	}
	else if(short == "IncubiD" || short == "P.Draft") {
		//Incubus Draft
		//Decrease bust size by 1.
		//Increase penis size by 1 (will grow a 5" penis if none exists).
		//Random chance to remove vagina.
		//Random chance to give demonic high heels. (See Succubus Milk)
		//Random chance to give large horns. (See Succubus Milk)
		//Random chance to give red skin. (See Succubus Milk)
		if(short == "IncubiD") outputText("You hand over the bottle of milky white fluids to Rubi.  " + rubiMF("He","She") + " takes a moment to read over the label before pulling out the cork and downing the whole bottle in one gulp.");
		//Purified Incubus Draft
		//Decrease bust size by 1. (See Incubus Draft)
		//Increase penis size by 1 (will grow a penis if none exists). (See Incubus Draft)
		//Random chance to remove vagina. (See Incubus Draft)
		else outputText("You hand over the bottle of purified milky white fluids to Rubi.  " + rubiMF("He","She") + " takes a moment to read over the pink label before pulling out the cork and downing the whole bottle in one gulp.");
		
		//(If Bust size decreases)
		if((flags[RUBI_BREAST_SIZE] > 0) && (!flags[HYPER_HAPPY])){
			outputText("\n\nRubi gasps a little and " + rubiMF("his","her") + " hands immediately dart to " + rubiMF("his","her") + " chest.  Before your eyes, Rubi's breasts begin to dwindle, shrinking down an entire cup size.  Rubi cups " + rubiMF("his","her") + " breasts experimentally, getting used to their new, reduced, weight.");
			flags[RUBI_BREAST_SIZE]--;
			if(flags[RUBI_BREAST_SIZE] < 0) flags[RUBI_BREAST_SIZE] = 0;
		}
		//(If Penis size increases)
		if(flags[RUBI_COCK_SIZE] > 0 && ((flags[RUBI_COCK_SIZE] < 12 || (flags[RUBI_COCK_TYPE] == CockTypesEnum["human"] && flags[RUBI_COCK_SIZE] < 20)) ||
										(flags[RUBI_COCK_SIZE] < 30 && flags[HYPER_HAPPY]) ) )
		{
			outputText("\n\nRubi's " + rubiCock() + " swells up suddenly, growing painfully hard.  " + rubiMF("He","She") + " grasps it and moans suddenly as it begins to pulse, growing larger with every throb, increasing in size by at least an inch, leaving " + rubiMF("him","her") + " with a ");
			flags[RUBI_COCK_SIZE]++;
			outputText(Math.round(flags[RUBI_COCK_SIZE]*10)/10 + "-inch penis.");
		}
		//(If Rubi has no penis; instead) 
		else if(flags[RUBI_COCK_SIZE] == 0){
			outputText("\n\nRubi gasps and " + rubiMF("his","her") + " hands dart between " + rubiMF("his","her") + " legs, grasping frantically for something.  Between " + rubiMF("his","her") + " fingers you spot it, a fleshy ");
			if(flags[RUBI_SKIN] == 1 || flags[RUBI_SKIN] == 3) outputText("red");
			else outputText("pink");
			outputText(" protrusion... a brand new cock!  Rubi shudders, " + rubiMF("his","her") + " delicate little fingers wrapped around the new, five-inch cock.");
			flags[RUBI_COCK_SIZE] = 5;
		}
		//(If Vagina removed)
		if(flags[RUBI_NO_CUNT] == 0 && rand(3) == 0) {
			outputText("\n\nRubi trembles, " + rubiMF("his","her") + " hand dipping between " + rubiMF("his","her") + " thighs, searching around for something.  " + rubiMF("He","She") + " pokes around madly, apparently finding nothing.  \"<i>It... It's gone!</i>\" " + rubiMF("he","she") + " says with a shaky voice.  \"<i>My vagina's gone!</i>\"");
			flags[RUBI_NO_CUNT] = 1;
			flags[RUBI_SHE] = 0;
			flags[RUBI_CUNTTYPE] = 0;
		}
	}
	//Gro+
	//Can choose Boobs or Penis. Grow that body part by 2.
	else if(short == "GroPlus") {
		outputText("\n\nWhere would you like to inject the Gro+?");
		//[Breasts] [Penis (if present)] [Back]
		menu();
		addButton(0,"Breast",rubiGrowPlusBreasts);
		addButton(1,"Penis",rubiPenisGroPlus);
		addButton(4,"Back",pickAnItemToFeedRubi);
		return;
	}
	else if(short == "Reducto") {
		//Reducto
		//Can choose Penis or Boobs. Reduces that body part by 1. (Won't reduce below E-cup (5) if Rubi has bimbo body)
		//Won't remove penises.
		//Can't give it to him if breasts/penis already at minimum.
		outputText("\n\nWhere would you like Rubi to use the reducto?");
		//[Breasts] [Penis (if present)] [Back]
		menu();
		addButton(0,"Breasts",rubiBoobsReducto);
		addButton(1,"Penis",rubiPenisReducto);
		addButton(4,"Back",pickAnItemToFeedRubi);
		return;
	}
	//Bimbo Liqueur (Modified for variant genders)
	else if(short == "BimboLq") {
		outputText("You hold out the bottle of Bimbo Liqueur.  Rubi takes it, and looks it over tentatively.  \"<i>Bimbo... liqueur?</i>\" " + rubiMF("he","she") + " asks, quirking an eyebrow at you.  \"<i>But what does this do?  There's a huge warning label right here.  Effects are permanent, strong...</i>\" " + rubiMF("his","her") + " voice drifts off as " + rubiMF("he","she") + " reads.");
		outputText("\n\nYou explain that this liqueur will give " + rubiMF("him","her") + " the fresh start " + rubiMF("he","she") + " so desired when " + rubiMF("he","she") + " came to Tel'Adre.  That before " + rubiMF("he","she") + " was simply wearing a mask, now " + rubiMF("he","she") + " can become the mask.  " + rubiMF("He","She") + " nods along with you, but still frowns.");
		outputText("\n\n\"<i>Are you sure?  I'm fine with my body how it is... but if you want me to change, I'll do it,</i>\" " + rubiMF("he","she") + " says, clutching the bottle tight, suddenly looking very serious.");
		outputText("\n\nYou nod, and tell " + rubiMF("him","her") + " this is exactly what you want.");
		outputText("\n\n\"<i>If it's what you want, then it's what I want, babe.</i>\" " + rubiMF("He","She") + " takes a deep breath, opens the bottle and closes " + rubiMF("his","her") + " eyes.  In one swift motion, " + rubiMF("he","she") + " puts the bottle to " + rubiMF("his","her") + " lips and downs its contents.");
		outputText("\n\nIt takes a moment for the effects to hit, but once they do, they come in rapid succession.  Rubi doubles over, clutching " + rubiMF("his","her") + " stomach in pain.  " + rubiMF("He","She") + " looks down, " + rubiMF("his","her") + " eyes as wide as they can be, to see the changes first hand.  Bones crack, shift, and wobble as Rubi's waist shrinks and " + rubiMF("his","her") + " hips grow outwards.  " + rubiMF("His","Her") + " entire body seems to shrink before your eyes, growing more slender.  " + rubiMF("His","Her") + " ");
		if(flags[RUBI_HAIR_LENGTH] == 0) outputText("short");
		else if(flags[RUBI_HAIR_LENGTH] == 1) outputText("shoulder-length");
		else outputText("long");
		outputText(" hair suddenly bursts outwards, long platinum blonde locks flow past " + rubiMF("his","her") + " shoulders like a waterfall.  " + rubiMF("His","Her") + " already dainty hands grow more feminine, as do " + rubiMF("his","her") + " feet.");
		flags[RUBI_HAIR_LENGTH] = 2;
 
		//(If Rubi has a Penis)
		if(flags[RUBI_COCK_SIZE] > 0) {
			outputText("\n\nWith a wide eyed moment of trepidation, Rubi clutches at " + rubiMF("his","her") + " crotch, " + rubiMF("his","her") + " hands slipping between " + rubiMF("his","her") + " thighs as " + rubiMF("his","her") + " dick shrivels away, leaving Rubi with ");
			if(flags[RUBI_NO_CUNT] == 0) outputText("" + rubiMF("his","her") + " vagina");
			else outputText("a pristine new vagina");
			outputText(".  It's pretty clear, this former male is now completely female.  Rubi collapses backwards onto the couch, the transformations seemingly done.");
			flags[RUBI_COCK_SIZE] = 0;
			flags[RUBI_NO_CUNT] = 0;
			flags[RUBI_SHE] = 1;
		}
		outputText("\n\n\"<i>Like, oh.  My.  Gods.  That was so wild,</i>\" " + rubiMF("he","she") + " says, and suddenly grips " + rubiMF("his","her") + " throat.  \"<i>Whoa, like, my voice is different!</i>\"  Though " + rubiMF("he","she") + " had a very feminine voice to begin with, it is noticeably more girly.  Not high pitched, just... girly, and tinged with a hint of a ditzy accent.");
		
		//(if boobs <E)
		if(flags[RUBI_BREAST_SIZE] < 7) {
			outputText("\n\n" + rubiMF("He","She") + " looks down at " + rubiMF("his","her") + " chest, and a look of disappointment crosses " + rubiMF("his","her") + " face.  \"<i>Aww, I get this totally killer bod, but no tits?</i>\" " + rubiMF("he","she") + " exclaims, visibly upset.");
			//(boobgrowth continues) 
			outputText("\n\nAs if on cue, the flesh around " + rubiMF("his","her") + " ");
			if(flags[RUBI_NIPPLE_TYPE] > 0) outputText("black ");
			outputText("nipples begins to tremble and then expand.  You swear you hear a whooshing sound, like someone is blowing up a balloon.");
			//(if flat-chested)
			if(flags[RUBI_BREAST_SIZE] == 0) outputText("  Within seconds, Rubi has the chest of a pubescent girl, within a minute they're at least a B-cup.");
			outputText("  You both sit with morbid curiosity, watching the flesh grow outwards, bit by bit and cup by cup.  After five minutes the growth stops, and Rubi carefully cradles " + rubiMF("his","her") + " new enormous E-cup breasts.");
		}
		outputText("\n\nThe silence is broken when Rubi shouts, \"<i>Oh fuck yes, this is more like it!</i>\"  " + rubiMF("He","She") + " stands and dances what can only be called the titty-dance, squeezing one breast and then the other in quick succession to some tune that exists only in " + rubiMF("his","her") + " head.  It seems that, in addition to a new body, the liqueur also granted Rubi excessive amounts of energy!");
			
		outputText("\n\nSuddenly remembering you're here, " + rubiMF("he","she") + " stops and gives you a great big hug, pressing " + rubiMF("his","her") + " breasts against ");
		if(player.biggestTitSize() < 1) outputText("yours");
		else outputText("you");
		outputText(".  \"<i>Like, thank you so much baby!  You're the freaking best!  Now... you want to break this body in?</i>\"");
		
		outputText("\n\nYou grin and say, \"<i>Of course.</i>\"  After all, you're always happy to help!");
		//(Go to sex menu)
		consumeItem("BimboLq",1);
		flags[RUBI_SHE] = 1;
		flags[RUBI_BIMBO] = 1;
		flags[RUBI_HAIR] = 1;
		rubiSexMenu();
		addButton(9,"Leave",eventParser,13);
		return;
	}
	//Equinum
	//Gives horsecock.
	//Grows cock. (As Incubus Draft above)
	else if(short == "Equinum") {
		outputText("You hand over the vial of milky white fluids.  Rubi looks it over and gives you an odd look.  \"<i>Horses?  Really?  What, do you like the giant cocks?</i>\" " + rubiMF("he","she") + " asks, incredulously.  Nevertheless, " + rubiMF("he","she") + " pops the cork out of the vial and puts " + rubiMF("his","her") + " lips to the flared opening, downing the transformative drink in one swallow.");
		if(flags[RUBI_COCK_SIZE] == 0) {
			outputText("\n\nRubi gasps and " + rubiMF("his","her") + " hands dart between " + rubiMF("his","her") + " legs, grasping frantically for something.  Between " + rubiMF("his","her") + " fingers you spot it, a fleshy ");
			if(flags[RUBI_SKIN] == 1 || flags[RUBI_SKIN] == 3) outputText("red");
			else outputText("pink");
			outputText(" protrusion... a brand new cock!  Rubi shudders, " + rubiMF("his","her") + " delicate little fingers wrapped around the new, five-inch cock.");
			flags[RUBI_COCK_SIZE] = 5;
		}
		//(If Rubi gets Horsecock)
		if(flags[RUBI_COCK_TYPE] != CockTypesEnum["human"]) {
			outputText("\n\nFor a few moments nothing happens.  Then Rubi suddenly doubles over, clutching " + rubiMF("his","her") + " stomach in pain.  With one hand clamped firmly around " + rubiMF("his","her") + " midsection, " + rubiMF("his","her") + " other hand reaches down to grasp at " + rubiMF("his","her") + " " + rubiCock() + ".  The flesh on " + rubiMF("his","her") + " cock ripples, veins suddenly bulging.  A low moan wrestles its way out of Rubi's throat as " + rubiMF("his","her") + " cock morphs, the pink head flattening all of a sudden and flaring outwards.");
			flags[RUBI_COCK_TYPE] = CockTypesEnum["human"];
			outputText("\n\nRubi's dick thickens in " + rubiMF("his","her") + " hand, gaining at least an inch of width as it continues to change.  A thick, fleshy ring bulges out near the base of the cock... the beginnings of a sheathe, no doubt.  As you watch on in awe, the flesh at the base of Rubi's cock begins to darken, slowly become a dusky grey-black, which also overtakes " + rubiMF("his","her") + " ");
			if(flags[RUBI_BLU_BALLS] >= 4 && flags[RUBI_BLU_BALLS] < 9) outputText("swollen ");
			else if(flags[RUBI_BLU_BALLS] >= 9) outputText("engorged ");
			if(flags[RUBI_BALLS_TYPE] == 1) outputText("tight, trappy ");
			outputText("ballsack.  The colors move forward, seemingly stopping at the thick ring that marks the edge of " + rubiMF("his","her") + " sheathe... except patches of  dusky gray appear along the next few inches of " + rubiMF("his","her") + " length, creating a nice contrast and pattern with the bright pink of " + rubiMF("his","her") + " cockflesh.");
			
			outputText("\n\nSighing suddenly, Rubi relinquishes " + rubiMF("his","her") + " stomach and cock, recovering for a moment before looking down in wonderment at " + rubiMF("his","her") + " new horsecock.  \"<i>Oh wow,</i>\" " + rubiMF("he","she") + " says, running " + rubiMF("his","her") + " fingers along the spongy new ridge at its tip.  \"<i>Ah, this is going to take some getting used to...</i>\"");
			flags[RUBI_COCK_SIZE] += 3 + rand(5);
		}
	}
	//Trap Oil
	else if(short == "TrapOil") {
		//Decrease bust size by 1 if above 1. (See Incubus Draft)
		//Increase bust size by 1 if below 1. (See succubus milk)
		//Decrease penis size by 1 if above 3. (See succubus milk)
		//Random chance to give trap ballsack.
		//Random chance to give black eyes.
		//Random chance to give black nipples.
		outputText("You twirl the little bottle of oil in one hand and pull Rubi out of the closet.  For what you have in mind, " + rubiMF("he","she") + " will need somewhere comfortable to lay.  The two of you return to the bedroom, and you instruct Rubi to rest on the bed face down.  " + rubiMF("He","She") + " flattens the bedspread out before eagerly doing so.");
		outputText("\n\nYour eyes run over the sight before you.  Rubi, face down on what must be the softest and most girly bed ever constructed.  " + rubiMF("His","Her") + " supple flesh lays bare to you, with its pert, heart-shaped ass, creamy thighs, and tender feet.  Not to mention the sinuous tail that flutters from side to side.  You can't help but grin as you climb on top of Rubi's prone form, popping the top off the bottle as you do so.");
		outputText("\n\nSettling down on Rubi's thighs, with " + rubiMF("his","her") + " perky ass and back laid out before you, you upturn the bottle just a bit, letting a fair dollop of the semi-thick oil to cascade down " + rubiMF("his","her") + " spine.  It forms a puddle in the small of " + rubiMF("his","her") + " back.  You splash your hands with some of the oil, and then set the bottle aside.  Giving your hands a good stretch beforehand, you dive right in, pressing your fingers into Rubi's flesh.");
		outputText("\n\nYour fingers search for the knots in the muscles, working from " + rubiMF("his","her") + " shoulders all the way down to " + rubiMF("his","her") + " lower back, lingering longer than needed on " + rubiMF("his","her") + " ass.  You likewise assault the muscles in " + rubiMF("his","her") + " arms and legs, massaging the tension from every pore as Rubi moans delightfully into the bedspread.");
		outputText("\n\nBefore long you have " + rubiMF("him","her") + " flip over, and return to your stance just above " + rubiMF("his","her") + " thighs.  Rubi's toned midsection heaves, as " + rubiMF("his","her") + " breath comes labored.");
		if(flags[RUBI_COCK_SIZE] > 0) {
			outputText("  Rubi's " + rubiCock() + " twitches, already leaking precum from its tip as it attempts to reach the skies above");
		}
		else outputText("  Rubi's cunt glistens, soaked through entirely thanks to your ministrations");
		if(flags[RUBI_BREAST_SIZE] > 0) outputText(", while " + rubiMF("his","her") + " " + rubiBreasts() + " gently rock up and down with the motions of " + rubiMF("his","her") + " breathing");
		outputText(".");
		
		outputText("\n\nYou repeat the process here, applying a generous dollop of the oils to your lover's body, which arches appreciatively at your touch.  Your fingers dive right back in, no longer focusing on working out the knots in Rubi's body, but instead focusing on " + rubiMF("his","her") + " nipples, belly, and groin.  You love the way " + rubiMF("he","she") + " reacts to every little touch, from the curling of " + rubiMF("his","her") + " toes as you brush past " + rubiMF("his","her") + " inner thighs, to the cute lip-bite you see as your fingers tantalize " + rubiMF("his","her") + " underarms.");
		
		outputText("\n\nWith Rubi finally covered from the neck down in the oils, you stand back and smile, waiting for the transformations to kick in.");
		//(If Bust size decreases)
		if((flags[RUBI_BREAST_SIZE] > 1) && (!flags[HYPER_HAPPY])) {
			outputText("\n\nRubi gasps a little and " + rubiMF("his","her") + " hands immediately dart to " + rubiMF("his","her") + " chest.  Before your eyes, Rubi's breasts begin to dwindle, shrinking down an entire cup size.  Rubi cups " + rubiMF("his","her") + " breasts experimentally, getting used to their new, reduced, weight.");
			flags[RUBI_BREAST_SIZE]--;
			if(flags[RUBI_BREAST_SIZE] < 1) flags[RUBI_BREAST_SIZE] = 1;
		}
		//(If Bust size increases)
		else if(flags[RUBI_BREAST_SIZE] < 1) {
			outputText("\n\nRubi gasps a little and " + rubiMF("his","her") + " hands immediately dart to " + rubiMF("his","her") + " chest.  Before your eyes, Rubi's breasts begin to swell, growing an entire cup size.  Rubi cups " + rubiMF("his","her") + " breasts experimentally, getting used to their new weight.");
			flags[RUBI_BREAST_SIZE]++;
			if(flags[RUBI_BREAST_SIZE] > 1) flags[RUBI_BREAST_SIZE] = 1;
		}
		//(If Penis size decreases)
		else if((flags[RUBI_COCK_SIZE] > 3) && (!flags[HYPER_HAPPY])) {
			outputText("\n\nRubi's " + rubiCock() + " swells up suddenly, growing painfully hard.  " + rubiMF("He","She") + " grasps it and moans suddenly as it begins to dwindle in size, shrinking down by at least an inch, leaving " + rubiMF("him","her") + " with a ");
			flags[RUBI_COCK_SIZE]--;
			if(flags[RUBI_COCK_SIZE] < 3) flags[RUBI_COCK_SIZE] = 3;
			outputText(Math.round(flags[RUBI_COCK_SIZE]*10)/10 + "-inch penis.");
		}
		//(Trappy ballsack)
		else if(flags[RUBI_BALLS_TYPE] > 0) {
			outputText("\n\nThe oils seem to seep into Rubi's skin, giving it a glossy, almost insectile shine for a moment.  However, your eyes seem drawn, not to " + rubiMF("his","her") + " lustrous skin, but rather to " + rubiMF("his","her") + " crotch, " + rubiMF("his","her") + " testicles in particular.  The sack itself seems to contort oddly, and you realize it's shrinking!  Rubi makes a panicked noise as the sack constricts and pulls upwards, but thankfully it does not disappear.  Rather, it seems to have tightened up.  You rest your fingers on " + rubiMF("his","her") + " new sack experimentally, pleased to note that " + rubiMF("he","she") + " still has two testicles, though it looks like " + rubiMF("he","she") + " only has one: trapped in a cute little package that seems to pull upwards, rather than dangle down.");
			flags[RUBI_BALLS_TYPE] = 1;
		}
		//(Black Nipples)
		else if(flags[RUBI_NIPPLE_TYPE] != 1) {
			outputText("\n\nRubi's hands quickly dart to " + rubiMF("his","her") + " nipples, which perk up as if the temperature had dropped by twenty degrees.  " + rubiMF("He","She") + " can't help but giggle as though " + rubiMF("he","she") + " were being tickled as the nipples begin to darken, starting at the edge of the areola and working their way in.  In no time at all, Rubi's nipples have turned an enticing onyx black.");
			flags[RUBI_NIPPLE_TYPE] = 1;
		}
		//(Black Eyes)
		else if(flags[RUBI_EYE_TYPE] != 1) {
			outputText("\n\nRubi blinks, then blinks again, as if something is trapped in " + rubiMF("his","her") + " eyes.  " + rubiMF("He","She") + " brings a hand up to them, but you can already see the cause of this discomfort.  Some inky, black substance seems to be coating " + rubiMF("his","her") + " eyes, starting from the outside and working its way in. In no time it's covered the sclera, and then the iris.  Rubi holds " + rubiMF("his","her") + " eyes closed for a minute and then opens them, revealing " + rubiMF("his","her") + " new, solid black eyes.  " + rubiMF("He","She") + " quickly rushes off into the closet to check them out in a mirror.");
			flags[RUBI_EYE_TYPE] = 1;
		}
		else outputText("\n\nSadly, however, nothing seems to happen.  Perhaps there's nothing left to transform, or you got a dud bottle.  Regardless, Rubi seems to be quite happy with the massage, and is content to lie on the bed for several minutes before cleaning " + rubiMF("him","her") + "self up and returning to the closet.");
	}
	//Whisker Fruit
	//Progression of furriness: cat ears, then whiskers and paws, then cat penis, then furry body.
	else if(short == "W.Fruit") {
		outputText("You hand over the tiny peach-like fruit to Rubi.  " + rubiMF("He","She") + " turns it over in " + rubiMF("his","her") + " hands and remarks, \"<i>How can you like these things?  They're so... furry!  Well, to each their own I suppose.</i>\"  Rubi gulps visibly, preparing " + rubiMF("him","her") + "self for the whiskery fruit before biting down.  Apparently, it's not as bad as " + rubiMF("he","she") + " thought it was, as " + rubiMF("he","she") + " makes an appreciative grunt and consumes the fruit down to the pit.");
		
		//(Gaining Cat Ears) 
		if(flags[RUBI_EAR_TYPE] != 1) {
			outputText("\n\nRubi's hands dart to " + rubiMF("his","her") + " head and " + rubiMF("he","she") + " kneels down in pain.  For a moment, you're not sure what's wrong, and then you see it: " + rubiMF("his","her") + " ears twist and elongate, suddenly sprouting a fine layer of white fur.  They slowly form into a triangular shape and migrate up Rubi's head until they stop, perching on top like... well like a pair of cat's ears.");
			flags[RUBI_EAR_TYPE] = 1;
		}
		//(Gaining Whiskers and Paws)
		else if(flags[RUBI_WHISKERS] != 1 || flags[RUBI_HANDS] != 1) {
			outputText("\n\nRubi's hands dart to " + rubiMF("his","her") + " face this time as a number of whiskers sprout from " + rubiMF("his","her") + " cheeks.  They twitch cutely at " + rubiMF("his","her") + " touch, but that's not the full extend of the changes.  Rubi looks at " + rubiMF("his","her") + " hands and gasps, marveling as they sprout a fine layer of white fur and morph.  Patches of skin on " + rubiMF("his","her") + " palms and fingers brighten, becoming pink in colour, as the white fur overtakes the rest.  In the end, Rubi is left with a pair of paw-like hands.");
			flags[RUBI_WHISKERS] = 1;
			flags[RUBI_HANDS] = 1;
		}
		else if(flags[RUBI_LOWERBODY] != 1) {
			outputText("\n\nRubi then sits down as a shooting pain seems to go up " + rubiMF("his","her") + " legs.  " + rubiMF("He","She") + " cradles one leg as a similar process happens there, the foot being overtaken by white fur while pink pads form on the soles and toes.  " + rubiMF("His","Her") + " heel lengthens as well, drawing itself away from the toes and forming what you're sure is a digitigrate structure.  Sure enough, when the transformation is over and Rubi takes a few tentative steps on " + rubiMF("his","her") + " new legs, " + rubiMF("he","she") + " is forced to walk on tip-toes, which really helps accentuate " + rubiMF("his","her") + " ass.");
			flags[RUBI_LOWERBODY] = 1;
		}
		//(Gaining Cat Penis)
		else if(flags[RUBI_COCK_TYPE] != CockTypesEnum["cat"] && flags[RUBI_COCK_SIZE] > 0) {
			outputText("\n\nFor a few moments nothing happens.  Then Rubi suddenly doubles over, clutching " + rubiMF("his","her") + " stomach in pain.  With one hand clamped firmly around " + rubiMF("his","her") + " midsection, " + rubiMF("his","her") + " other hand reaches down to grasp at " + rubiMF("his","her") + " " + rubiCock() + ".  The flesh on " + rubiMF("his","her") + " cock ripples, veins suddenly bulging.  A low moan wrestles its way out of Rubi's throat as " + rubiMF("his","her") + " cock morphs, its tip lengthening out while a number of barb-like protrusions sprout from the head.  Before your eyes the barbs quiver and then go flush against " + rubiMF("his","her") + " cock.  They don't seem sharp, more like they're ready to stimulate a potential mate.");
			flags[RUBI_COCK_TYPE] = CockTypesEnum["cat"];
		}
		//(Gaining Fur)
		else if(flags[RUBI_SKIN] != 2) {
			outputText("\n\nRubi clutches " + rubiMF("his","her") + " stomach suddenly as you notice white spots appearing on " + rubiMF("his","her") + " skin.  You notice it's not simply a skin tone change, but rather a fine layer of white fur has sprouted from " + rubiMF("his","her") + " flesh and is taking over at a rapid pace!  The blotches of fur quickly overtake " + rubiMF("his","her") + " torso, leaving the nipples unchanged, then the arms and legs, and finally the face, leaving " + rubiMF("him","her") + " with a cute little button nose.");
			flags[RUBI_SKIN] = 2;
		}
	}
	//Purity Peach
	if(short == "PurPeac") {
		//Requires 5 Purity Peaches
		//Consumes 1 hour
		//Gives Anemone Penis.
		//Feathery ears.
		//Striped, shark-like skin.
		outputText("Though you know these peaches alone don't cause any kind of transformation, you wonder if together they might do something to someone like Rubi.  You hand over the five peaches and mention how these might taste good in a pie.  Rubi's eyes light up and " + rubiMF("he","she") + " nods, \"<i>Oh!  I could give that a try, sure!");
		outputText("\n\nRubi takes an apron off of a hangar and ties it around " + rubiMF("his","her") + " body, not bothering to put on anything else, as " + rubiMF("he","she") + " heads into the kitchen.  You follow and watch as " + rubiMF("he","she") + " gets to work, first preheating the little oven, then retrieving a pie pan and lining it with a fresh pie crust.  " + rubiMF("He","She") + " cuts up the peaches and throws some other ingredients in that you don't register.  Truth be told your gaze is focusing more on Rubi's shapely naked ass as it wiggles to and fro.");
		outputText("\n\nBefore you know it, there's an entire pie baking in the oven and Rubi is pushing you onto the couch.  " + rubiMF("He","She") + " climbs on top and then lays down on you, holding you close.  The two of you spend the next half-hour or so snuggling on the couch like this, Rubi's half-naked body clutched against yours.  Eventually, though, the timer by the oven goes off, and Rubi springs up out of your grasp like a cat threatened with water.  " + rubiMF("He","She") + " sprints over to the oven, and, donning a comically large oven mitt, retrieves the fresh baked pie from its depths.");
		outputText("\n\n" + rubiMF("He","She") + " inhales deeply and sighs.  \"<i>Mmm, this smells good! Do you want a fresh slice?</i>\"");
		
		outputText("\n\nYou decline, saying you brought these peaches for " + rubiMF("him","her") + ", and that you can get some more any time.  " + rubiMF("He","She") + " nods and cuts " + rubiMF("him","her") + "self a wedge of the pie, letting it cool off slightly before taking a bite.  " + rubiMF("His","Her") + " lips immediately curl up into a smile, and you swear you hear a small moan of delight muscle its way out of " + rubiMF("his","her") + " closed lips.  Before you know it, that slice is gone, followed by a second, and then half the pie has seemingly disappeared.");
		
		outputText("\n\n\"<i>Oh my that's good,</i>\" Rubi says, making " + rubiMF("his","her") + " way back to the couch and slumping into the cushions.  " + rubiMF("He","She") + " removes the apron, revealing the naked ");
		if(flags[RUBI_SKIN] == 0) outputText("skin");
		else if(flags[RUBI_SKIN] == 1) outputText("red skin");
		else if(flags[RUBI_SKIN] == 2) outputText("furred skin");
		else outputText("striped skin");
		outputText(" underneath.  The demon-marked " + rubiMF("boy","girl") + " rubs " + rubiMF("his","her") + " stomach appreciatively.  \"<i>Those were some great peaches, babe.</i>\"");
		
		//(Any changes? Yes)
		if(flags[RUBI_EAR_TYPE] != 2 || flags[RUBI_SKIN] != 3 || (flags[RUBI_COCK_SIZE] > 0 && flags[RUBI_COCK_TYPE] != CockTypesEnum.legacySuportLoadCockType(7))) {
			outputText("\n\nRubi's eyes suddenly dart open and " + rubiMF("he","she") + " clutches " + rubiMF("his","her") + " stomach.  \"<i>Oh gods…  My belly feels so warm all of a sudden.</i>\"");
			//(Feathery ears)
			if(flags[RUBI_EAR_TYPE] != 2) {
				outputText("\n\n" + rubiMF("His","Her") + " hands don't dally there long before darting up to " + rubiMF("his","her") + " head, as " + rubiMF("his","her") + " ears seem to shimmer and morph right before your eyes.  " + rubiMF("His","Her") + " ");
				if(flags[RUBI_EAR_TYPE] == 0) outputText("normal");
				else outputText("feline");
				outputText(" ears seem to pull into " + rubiMF("his","her") + " skull before disappearing, leaving nothing but skin and hair behind.  You wonder if Rubi's lost " + rubiMF("his","her") + " ears permanently, but as the thought finishes crossing your mind you notice two small nubs growing where normal ears would be.");
				
				outputText("\n\nThey quickly blossom outward, growing into something vaguely ear-shaped.  And then a number of bright feathers sprout, covering the entire ear in pink and orange down.");
				outputText("\n\n" + rubiMF("His","Her") + " hands pull away, as " + rubiMF("he","she") + " gives the ears a few experimental pokes.  They twitch cutely, and Rubi rushes off to check " + rubiMF("him","her") + "self out in a mirror.");
				flags[RUBI_EAR_TYPE] = 2;
			}
			//(Shark Skin)
			else if(flags[RUBI_SKIN] != 3) {
				outputText("\n\n" + rubiMF("His","Her") + " hands firmly clamp down on the naked flesh of " + rubiMF("his","her") + " stomach.  Amazingly, you notice, " + rubiMF("his","her") + " skin seems to be taking on a different hue.  At first it darkens, ");
				if(flags[RUBI_SKIN] == 0) outputText("its normal paleness replaced with a vibrant cherry red");
				else if(flags[RUBI_SKIN] ==1 ) outputText("which is barely noticeable on " + rubiMF("his","her") + " already cherry red flesh");
				else if(flags[RUBI_SKIN] == 2) outputText("the fur rapidly retreating and replaced with bright red flesh underneath");
				outputText(", but it doesn't seem to be even.  The majority of Rubi's body is cherry red, while " + rubiMF("his","her") + " belly actually lightens, becoming a sweet, silvery gray.  A number of similarly silver stripes appear, seemingly at random, up and down Rubi's arms and legs, and even down " + rubiMF("his","her") + " demonic tail, amazingly enough.");
				outputText("\n\nWhen the changes seem to stop, or at least slow, Rubi calmly relinquishes " + rubiMF("his","her") + " hold on " + rubiMF("his","her") + " stomach and goes to check " + rubiMF("him","her") + "self out in the mirror.");
				flags[RUBI_SKIN] = 3;
			}
			//(Anemone Penis, must have a penis)
			else if(flags[RUBI_COCK_SIZE] > 0 && flags[RUBI_COCK_TYPE] != CockTypesEnum.legacySuportLoadCockType(7)) {
				outputText("\n\n" + rubiMF("His","Her") + " hands don't dally there long before darting down to " + rubiMF("his","her") + " crotch, groping at the " + rubiCock() + " betwixt " + rubiMF("his","her") + " legs.  The flesh seems to  ripple, with veins suddenly bulging.  A low, husky groan wrestles its way out of Rubi's throat as " + rubiMF("his","her") + " cock morphs");
				if(flags[RUBI_COCK_TYPE] != CockTypesEnum.legacySuportLoadCockType(0)) outputText(", first shifting towards a more human-like appearance");
				outputText(".  Small nodules appear, around the crown of the penis, and around its base.  Rubi's delicate hands run across two of the nodules, and " + rubiMF("his","her") + " cock suddenly stiffens, harder than you've ever seen it!  Whatever those things are, they're quite sensitive.");
				
				outputText("\n\nThe little nubs quickly grow outwards, lengthening into tiny, anemone-like tentacles.  When the changes finally stop, Rubi gazes down with no small amount of trepidation, as the four tentacles around the head of " + rubiMF("his","her") + " penis and the four at its base wriggle and writhe of their own accord.");
				
				outputText("\n\n\"<i>Oh... Oh my.</i>\"  It's all " + rubiMF("he","she") + " can say as " + rubiMF("he","she") + " wraps a hand around this newly modified appendage.  The tentacles likewise attempt to wrap themselves around Rubi's hand, clearly having a mind of their own.  You're fairly certain this will take a little while to adapt to.");
			}
			flags[RUBI_COCK_TYPE] = CockTypesEnum.legacySuportLoadCockType(7);
		}
		//(No)
		else {
			outputText("\n\nYou monitor Rubi carefully, but it seems this batch of peaches has no effect other than filling " + rubiMF("his","her") + " stomach.  Or perhaps there's nothing more to change.");
		}
		consumeItem(short,1);
		consumeItem(short,1);
		consumeItem(short,1);
		consumeItem(short,1);
	}
	consumeItem(short,1);
	menu();
	addButton(0,"Next",pickAnItemToFeedRubi);
	//Go back to give item menu.
}

//GRO+/REDUCTO
function rubiGrowPlusBreasts():void {
	clearOutput();
	outputText("You hand over the vial of blueish liquid.  Rubi takes a moment to look it over, before taking a deep breath and injecting half of the vial into one breast and the rest into " + rubiMF("his","her") + " other breast.");
	
	//(If breast increase)
	if(flags[RUBI_BREAST_SIZE] < 7) {
		outputText("\n\nRubi's breasts suddenly wobble of their own accord, swelling up like they're being inflated.  The little demon-morph shivers as pleasure wracks " + rubiMF("his","her") + " body, with " + rubiMF("his","her") + " breasts growing at least two cup sizes.  " + rubiMF("His","Her") + " fingers absently grope at " + rubiMF("his","her") + " new endowments, tweaking the flushed, sensitive flesh until the erotic heat from the transformation eventually dissipates, leaving " + rubiMF("him","her") + " panting on the floor before you.");
		flags[RUBI_BREAST_SIZE] += 2 + rand(2);
		if(flags[RUBI_BREAST_SIZE] > 7) flags[RUBI_BREAST_SIZE] = 7;
	}
	//(If breasts already maxed)
	else outputText("\n\nSadly, apart from making " + rubiMF("his","her") + " nipples particularly perky, they don't seem to have much effect on Rubi's already enormous rack.");
	consumeItem("GroPlus",1);
	menu();
	addButton(0,"Next",pickAnItemToFeedRubi);
	//Go back to give item menu.
}
//(If Penis)
function rubiPenisGroPlus():void {
	clearOutput();
	outputText("You hand over the vial of greenish liquid.  Rubi takes a moment to look it over before, before taking a deep breath and injecting the entire thing into the base of " + rubiMF("his","her") + " " + rubiCock() + ".");
	
	//(If Penis increase)
	if(flags[RUBI_COCK_SIZE] < 12 || (flags[RUBI_COCK_TYPE] == CockTypesEnum.legacySuportLoadCockType(1) && flags[RUBI_COCK_SIZE] < 20)) {
		outputText("\n\nRubi grips " + rubiMF("his","her") + " cock as it suddenly hardens, visibly throbbing in " + rubiMF("his","her") + " grasp.  It surges, growing larger, gaining about two inches right before your eyes.");
		flags[RUBI_COCK_SIZE] += 2 + rand(2);
		if(flags[RUBI_COCK_TYPE] != CockTypesEnum.legacySuportLoadCockType(1)) {
			if(flags[RUBI_COCK_SIZE] > 12) flags[RUBI_COCK_SIZE] = 12;
		}
		else {
			if(flags[RUBI_COCK_SIZE] > 20) flags[RUBI_COCK_SIZE] = 20;
		}
	}
	else {
		outputText("\n\nSadly, apart from making " + rubiMF("his","her") + " cock hard, it doesn't seem to have much of an effect on Rubi's ");
		if(flags[RUBI_COCK_TYPE] == CockTypesEnum.legacySuportLoadCockType(1)) outputText("sheath-stuffing horse-dick");
		else outputText("foot-long dick.");
	}
	consumeItem("GroPlus",1);
	menu();
	addButton(0,"Next",pickAnItemToFeedRubi);
	//Go back to give item menu.
}
//(If Breasts)
function rubiBoobsReducto():void {
	clearOutput();
	outputText("You hand over the jar of paste.  Rubi looks it over and, after giving it a sniff, uses two fingers to scoop up some of the pale substance, smearing it over " + rubiMF("his","her") + " breasts.  Before long, the jar is empty and " + rubiMF("his","her") + " " + rubiBreasts() + " are covered in the stuff.");
	if(flags[RUBI_BREAST_SIZE] > 0) {
		outputText("\n\nIt seems to take a moment for the effects to kick in, and soon you see Rubi shiver while " + rubiMF("his","her") + " breasts seem to quake, shrinking rapidly in size.  When the process is done, you're certain " + rubiMF("he","she") + "'s lost an entire cup size, and the paste has been completely absorbed in the process.");
		flags[RUBI_BREAST_SIZE]--;
	}
	consumeItem("Reducto",1);
	menu();
	addButton(0,"Next",pickAnItemToFeedRubi);
	//Go back to give item menu.
}

//(If Penis)
function rubiPenisReducto():void {
	clearOutput();
	outputText("You hand over the jar of paste.  Rubi looks it over and, after giving it a sniff, uses two fingers to scoop up some of the pale substance, smearing it over " + rubiMF("his","her") + " penis.  Before long, the jar is empty and " + rubiMF("his","her") + " " + rubiCock() + " is covered in the stuff.");
	if(flags[RUBI_COCK_SIZE] >= 3) {
		outputText("\n\nIt seems to take a moment for the effects to kick in, and soon you see Rubi shiver while " + rubiMF("his","her") + " " + rubiCock() + " stiffens and then shrinks rapidly in size.  When the process is done, you're certain " + rubiMF("he","she") + "'s lost an entire inch, and the paste has been completely absorbed in the process.");
	}
	else {
		outputText("\n\nIt doesn't seem to have any effect.");
	}
	consumeItem("Reducto",1);
	menu();
	addButton(0,"Next",pickAnItemToFeedRubi);
	//Go back to item giving menu!
}

//Give Item.
function pickAnItemToFeedRubi():void {
	clearOutput();
	var closet:Array = new Array();
	var gifts:Array = new Array();
	
	var buttonNames:Array = new Array();
	if(flags[RUBI_SUITCLOTHES] == 1) {
		closet[closet.length] = "Suitclothes";
		buttonNames[buttonNames.length] = "Suit";
	}
	if(flags[RUBI_FETISH_CLOTHES] == 1) {
		closet[closet.length] = "Rubber Fetish Clothes";
		buttonNames[buttonNames.length] = "Rubber";
	}
	if(flags[RUBI_GREEN_ADVENTURER] == 1) {
		closet[closet.length] = "A Green Adventurer's Outfit";
		buttonNames[buttonNames.length] = "Green Outfit";
	}
	if(flags[RUBI_TUBE_TOP] == 1) {
		closet[closet.length] = "A Tube Top";
		buttonNames[buttonNames.length] = "Tube Top";
	}
	if(flags[RUBI_BODYSUIT] == 1) {
		closet[closet.length] = "A Sheer Bodysuit";
		buttonNames[buttonNames.length] = "Bodysuit";
	}
	if(flags[RUBI_LONGDRESS] == 1) {
		trace("PRE-CRASH");
		closet[closet.length] = "A Long Dress";
		buttonNames[buttonNames.length] = "Long Dress";
	}
	if(flags[RUBI_TIGHT_PANTS] == 1) {
		closet[closet.length] = "A Dashing Outfit With Tight Leather Pants";
		buttonNames[buttonNames.length] = "DashingOutfit";
	}
	if(flags[RUBI_NURSE_CLOTHES] == 1) {
		closet[closet.length] = "Nurse's Clothes";
		buttonNames[buttonNames.length] = "Nurse'sClothes";
	}
	//(Slutty Swimwear (Normal))
	if(flags[RUBI_SWIMWEAR] == 1) {
		closet[closet.length] = "Slutty Swimwear";
		buttonNames[buttonNames.length] = "Swimwear";
	}
	if(flags[RUBI_BIMBO_MINIDRESS] == 1) {
		closet[closet.length] = "A Bimbo Minidress";
		buttonNames[buttonNames.length] = "Bimbo Dress";
	}
	if(flags[RUBI_BONDAGE_STRAPS] == 1) {
		closet[closet.length] = "Bondage Straps";
		buttonNames[buttonNames.length] = "Bondage Straps";
	}
	if(flags[RUBI_INQUISITORS_CORSET] == 1) {
		closet[closet.length] = "An Inquisitor's Corset";
		buttonNames[buttonNames.length] = "Corset";
	}
	//RIsque waitress uniform
	if(flags[RUBI_AFFECTION] >= 100) {
		closet[closet.length] = "A Risque Waitress's Uniform";
		buttonNames[buttonNames.length] = "RisqueUniform";
	}
	
	
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
	if(flags[RUBI_BONDAGE_STRAPS] == 1) closet[closet.length] = "Bondage Straps";
	else gifts[gifts.length] = "Bondage Straps";
	if(flags[RUBI_INQUISITORS_CORSET] == 1) closet[closet.length] = "An Inquisitor's Corset";
	else gifts[gifts.length] = "An Inquisitor's Corset";
	if(flags[RUBI_AFFECTION] >= 100) closet[closet.length] = "A Risque Waitress's Uniform";
	else gifts[gifts.length] = "A Risque Waitress's Uniform";
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
		outputText("You could give Rubi some incubi draft to make " + rubiMF("him","her") + " a little more manly but corrupt, or you could give Rubi a Bimbo Draft to turn " + rubiMF("him","her") + " into a smoking hot, female sex-bomb.\n\n");
	}
	outputText("What will you give " + rubiMF("him","her") + "?");
	//The following items can be given to Rubi at Relationship 20+: Suit Clothes, Rubber Fetish Outfit, Green Adventurer's Clothing, Tube Top, Bodysuit, Long Dress, Tight Leather Pants, Nurse Clothes, Slutty Swimwear.  Only once per item.
	//The following items can be given to Rubi at Relationship 40+: Bimbo Liqueur (once), Incubus Draft (up to three times).  Incubus Rubi can't be given Bimbo Liqueur, and likewise Bimbo Rubi can't be given Incubus Draft.
	var events:Array = new Array();
	var functions:Array = new Array();
	if(hasItem("ClssyCl",1) && flags[RUBI_SUITCLOTHES] == 0) {
		events[events.length] = 3879;
		functions[functions.length] = eventParser;
	}
	if(hasItem("RbbrClt",1) && flags[RUBI_FETISH_CLOTHES] == 0) {
		events[events.length] = 3880;
		functions[functions.length] = eventParser;
	}
	if(hasItem("AdvClth",1) && flags[RUBI_GREEN_ADVENTURER] == 0) {
		events[events.length] = 3881;
		functions[functions.length] = eventParser;
	}
	if(hasItem("TubeTop",1) && flags[RUBI_TUBE_TOP] == 0) {
		events[events.length] = 3882;
		functions[functions.length] = eventParser;
	}
	if(hasItem("T.BSuit",1) && flags[RUBI_BODYSUIT] == 0) {
		events[events.length] = 3883;
		functions[functions.length] = eventParser;
	}
	if(hasItem("B.Dress",1) && flags[RUBI_LONGDRESS] == 0) {
		events[events.length] = 3884;
		functions[functions.length] = eventParser;
	}
	if(hasItem("LthrPnt",1) && flags[RUBI_TIGHT_PANTS] == 0) {
		events[events.length] = 3885;
		functions[functions.length] = eventParser;
	}
	if(hasItem("NurseCl",1) && flags[RUBI_NURSE_CLOTHES] == 0) {
		events[events.length] = 3886;
		functions[functions.length] = eventParser;
	}
	if(hasItem("S.Swmwr",1) && flags[RUBI_SWIMWEAR] == 0) {
		events[events.length] = 3887;
		functions[functions.length] = eventParser;
	}
	if(hasItem("BonStrp",1) && flags[RUBI_BONDAGE_STRAPS] == 0) {
		events[events.length] = "BonStrp";
		functions[functions.length] = giveRubiClothes;
	}
	if(hasItem("I.Corst",1) && flags[RUBI_INQUISITORS_CORSET] == 0) {
		events[events.length] = "I.Corst";
		functions[functions.length] = giveRubiClothes;
	}
	
	if(hasItem("BimboLq",1) && !rubiBimbo()) {
		events[events.length] = "BimboLq";
		functions[functions.length] = giveRubiATFItem;
	}
	if(hasItem("IncubiD",1)) {
		events[events.length] = "IncubiD";
		functions[functions.length] = giveRubiATFItem;
	}
	if(hasItem("P.Draft",1)) {
		events[events.length] = "P.Draft";
		functions[functions.length] = giveRubiATFItem;
	}
	if(hasItem("SucMilk",1)) {
		events[events.length] = "SucMilk";
		functions[functions.length] = giveRubiATFItem;
	}
	if(hasItem("P.S.Mlk",1)) {
		events[events.length] = "P.S.Mlk";
		functions[functions.length] = giveRubiATFItem;
	}
	if(hasItem("PurPeac",5)) {
		events[events.length] = "PurPeac";
		functions[functions.length] = giveRubiATFItem;
	}
	if(hasItem("Equinum",1)) {
		events[events.length] = "Equinum";
		functions[functions.length] = giveRubiATFItem;
	}
	if(hasItem("W.Fruit",1)) {
		events[events.length] = "W.Fruit";
		functions[functions.length] = giveRubiATFItem;
	}
	if(hasItem("Reducto",1)) {
		events[events.length] = "Reducto";
		functions[functions.length] = giveRubiATFItem;
	}
	if(hasItem("GroPlus",1)) {
		events[events.length] = "GroPlus";
		functions[functions.length] = giveRubiATFItem;
	}
	if(hasItem("TrapOil",1)) {
		events[events.length] = "TrapOil";
		functions[functions.length] = giveRubiATFItem;
	}
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
		else if(events[temp] == "BimboLq") eventNames[eventNames.length] = "Bimbo Liq";
		else if(events[temp] == "IncubiD") eventNames[eventNames.length] = "Incubi Draft";
		else if(events[temp] == "BonStrp") eventNames[eventNames.length] = "Bondage S.";
		else if(events[temp] == "I.Corst") eventNames[eventNames.length] = "I. Corset";
		else if(events[temp] == "P.Draft") eventNames[eventNames.length] = "P.Draft";
		else if(events[temp] == "SucMilk") eventNames[eventNames.length] = "SucMilk";
		else if(events[temp] == "P.S.Mlk") eventNames[eventNames.length] = "P.S.Mlk";
		else if(events[temp] == "PurPeac") eventNames[eventNames.length] = "PurPeac";
		else if(events[temp] == "Equinum") eventNames[eventNames.length] = "Equinum";
		else if(events[temp] == "W.Fruit") eventNames[eventNames.length] = "W.Fruit";
		else if(events[temp] == "Reducto") eventNames[eventNames.length] = "Reducto";
		else if(events[temp] == "GroPlus") eventNames[eventNames.length] = "GroPlus";
		else if(events[temp] == "TrapOil") eventNames[eventNames.length] = "TrapOil";
		else {
			eventNames[eventNames.length] = "FUCKIN TRAP: " + events[temp];
			trace("FUCKIN TRAP: " + events[temp]);
		}
		temp++;
	}
	trace(eventNames.length + " " + events.length);
	var counter:int = 0;
	menu();
	while(counter < events.length-1) {
		if(events[counter] != 0) addButton(counter,eventNames[counter],functions[counter],events[counter]);
		counter++;
	}
	addButton(9,"Back",rubiAppearance);
		//choices(eventNames[0],events[0],eventNames[1],events[1],eventNames[2],events[2],eventNames[3],events[3],eventNames[4],events[4],eventNames[5],events[5],eventNames[6],events[6],eventNames[7],events[7],eventNames[8],events[8],"Back",3898);
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
	else if(short == "I.Corst") flags[RUBI_INQUISITORS_CORSET] = 1;
	else if(short == "BonStrp") flags[RUBI_BONDAGE_STRAPS] = 1;
	rubiAffection(20);
	doNext(rubisFuckingHouseYouPervert);
}
