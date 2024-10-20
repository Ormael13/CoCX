﻿package classes.Scenes.NPCs{
import classes.*;
import classes.BodyParts.Horns;
import classes.BodyParts.Tongue;
import classes.BodyParts.Wings;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.SceneLib;
import classes.display.SpriteDb;

public class IsabellaScene extends NPCAwareContent implements TimeAwareInterface {
//Isabella Flags:
//256	PC decided to approach Isabella's camp yet? 1
//257	Met Isabella?
//258	Is Isabella okay with tall folks?
//259	Has Isabella ever met the PC while PC is short?
//260	Isabella angry counter
//261  Times Izzy sleep-raped the PC?
//-Has PC raped her?

		public function IsabellaScene()
		{
			pregnancy = new PregnancyStore(kFLAGS.ISABELLA_PREGNANCY_TYPE, kFLAGS.ISABELLA_PREGNANCY_INCUBATION, 0, 0);
			pregnancy.addPregnancyEventSet(PregnancyStore.PREGNANCY_PLAYER, 2160, 1920, 1680, 1440, 1200, 960, 720, 480, 240);
			EventParser.timeAwareClassAdd(this);
		}

		private var checkedIsabella:int; //Make sure we test this event just once in timeChangeLarge

		public var pregnancy:PregnancyStore;
		public var isabellaOffspringData:Array = [];

		public static const OFFSPRING_HUMAN_BOYS:int = 1;
		public static const OFFSPRING_HUMAN_GIRLS:int = 2;
		public static const OFFSPRING_HUMAN_HERMS:int = 3;
		public static const OFFSPRING_COWGIRLS:int = 4;
		public static const OFFSPRING_COWFUTAS:int = 5;

		//Implementation of TimeAwareInterface
		public function timeChange():Boolean
		{
			checkedIsabella = 0;
			if (flags[kFLAGS.ISABELLA_ANGRY_AT_PC_COUNTER] > 0) { //Isabella is angry at the player
				flags[kFLAGS.ISABELLA_ANGRY_AT_PC_COUNTER]--;
				if (flags[kFLAGS.ISABELLA_ANGRY_AT_PC_COUNTER] > 300) flags[kFLAGS.ISABELLA_ANGRY_AT_PC_COUNTER] = 300;
				if (flags[kFLAGS.ISABELLA_ANGRY_AT_PC_COUNTER] < 0) flags[kFLAGS.ISABELLA_ANGRY_AT_PC_COUNTER] = 0;
			}
			if (flags[kFLAGS.ISABELLA_MILK_COOLDOWN] > 0) {
				flags[kFLAGS.ISABELLA_MILK_COOLDOWN]--;
				if (flags[kFLAGS.ISABELLA_MILK_COOLDOWN] < 0) flags[kFLAGS.ISABELLA_MILK_COOLDOWN] = 0;
			}
			if (flags[kFLAGS.ISABELLA_ACCENT_TRAINING_COOLDOWN] > 1) {
				flags[kFLAGS.ISABELLA_ACCENT_TRAINING_COOLDOWN]--;
			}
			if (isabellaFollower()) {
				if (flags[kFLAGS.ISABELLA_COUNTDOWN_TO_CONTRACEPTIONS] > 0) {
					flags[kFLAGS.ISABELLA_COUNTDOWN_TO_CONTRACEPTIONS]--;
				}
				if (flags[kFLAGS.ISABELLA_COUNTDOWN_TO_CONTRACEPTIONS] == 0 && player.hasCock()) {
					isabellaFollowerScene.isabellaTalksAboutPotentialPregnancy();
					return true;
				}
			}
			if (pregnancy.isPregnant) {
				pregnancy.pregnancyAdvance();
				if (pregnancy.incubation == 0) {
					isabellaFollowerScene.isabellaGivesBirth();
					return true;
				}
			}
			if (model.time.hours > 23) {
				if (flags[kFLAGS.FOUND_ISABELLA_AT_FARM_TODAY] == 1) flags[kFLAGS.FOUND_ISABELLA_AT_FARM_TODAY] = 0;
				if (SceneLib.isabellaFollowerScene.isabellaFollower() && flags[kFLAGS.ISABELLA_MILKED_YET] >= 0 && flags[kFLAGS.FOLLOWER_AT_FARM_ISABELLA] == 0) {
					flags[kFLAGS.ISABELLA_MILKED_YET]++;
				}
			}
			return false;
		}

		public function timeChangeLarge():Boolean {
			if (checkedIsabella++ == 0 && model.time.hours == 6 && isabellaFollowerScene.isabellaFollower() && flags[kFLAGS.FOLLOWER_AT_FARM_ISABELLA] == 0 && flags[kFLAGS.ISABELLA_BLOWJOBS_DISABLED] == 0 && player.hasCock() && (model.time.days % 2 == 0 || !player.hasPerk(PerkLib.MarblesMilk)) && player.shortestCockLength() <= 9) {
				spriteSelect(SpriteDb.s_isabella);
				isabellaFollowerScene.isabellaMorningWakeupCall();
				return true;
			}
			return false;
		}
		//End of Interface Implementation

		public function totalIsabellaChildren():int {
			return (isabellaOffspringData.length / 2);
		}

		public function getIsabellaChildType(type:int):int {
			//1: Human boys
			//2: Human girls
			//3: Human herms
			//4: Cowgirls
			//5: Cowfutas
			var count:int = 0;
			for (var i:int = 0; i < isabellaOffspringData.length; i += 2) {
				if (isabellaOffspringData[i] == type) count++;
			}
			return count;
		}

public function isabellaGreeting():void {
	spriteSelect(SpriteDb.s_isabella);
	clearOutput();
	sceneHunter.print("I'll just say it here - a LOT of her scenes have difference for people taller and shorter than 6'6\". And also she prefers small cocks and would like to suck one.");
	var suck:Function = null;
	//Not approached yet - the prequel!
	if(flags[kFLAGS.ISABELLA_CAMP_APPROACHED] == 0) {
		outputText("While walking through the high grasses you hear a rich, high voice warbling out a melodious tune in a language you don't quite understand.  Do you approach or avoid it?");
		//[Approach – to meeting] [Avoid – camp] – dont flag as met yet
		//Approach - sets flags[kFLAGS.ISABELLA_CAMP_APPROACHED] to 1 and calls this function
		simpleChoices("Approach", isabellaGreetingFirstTime, "", null, "", null, "", null, "Leave", explorer.done);
		return;
	}
	//CAMP MEETING – UMAD BRAH!?
	if(flags[kFLAGS.ISABELLA_ANGRY_AT_PC_COUNTER] > 0) {
		outputText("You unintentionally wind up in Isabella's camp, and the cow-girl still seems pretty steamed at you.  She charges towards you, sliding her arm through the straps on her shield as she approaches.  It's a fight!");
		startCombat(new Isabella());
		isabellaFollowerScene.isabellaAffection(-10);
		spriteSelect(SpriteDb.s_isabella);
		return;
	}
	//[Camp Meeting First Time]
	if(flags[kFLAGS.ISABELLA_MET] == 0) {
		flags[kFLAGS.ISABELLA_MET]++;
		outputText("You stumble through a break in the tall foliage to discover a small, barren clearing.  While it looks like grass once grew here, it's long since been trampled into the dirt.  Looking closer, it reminds you of some of the old straw that was constantly packed into the hard earth of your neighbor's barn when you were growing up.  There are a few sizable chests secured with heavy iron locks and draped with comfortable-looking blankets.  The heavy boxes are grouped in a half-circle surrounding a chair that currently holds the camp-owner's sizable backside.  It reminds you of a cruder version of your own camp.\n\n");

		outputText("Even seated, the occupant of this unsheltered settlement is imposing.  Standing up she'd have to be at least seven feet tall, maybe even eight.  You're looking at her from the back, and aside from the obvious femininity of her figure and lilting voice, all you see is the red tangles of her unruly red locks.  The woman's voice peaks, finishing her unusual song with such a high-pitched tone that you expect the iron locks and rivets on her chests to crack.  Thankfully her song's crescendo is quite brief, and her voice drops to a quiet warble before trailing off into silence.  She stands up, glances over her shoulder, and jumps back with her eyes wide in shock as she notices you.\n\n");
		outputText("She's a cow-girl!  Well, not completely anyways.  ");
		if(player.hasStatusEffect(StatusEffects.Marble)) outputText("She's like Marble - she has a human face with horns and cow-like ears.");
		else outputText("She has a human face, but the top of her head is also adorned with a pair of stubby, bovine horns and floppy cow-ears.");
		outputText("  Her skin is tanned dark, practically milk-chocolate brown, but a few rounded spots of white, pearly skin break up the uniformity.  The cow-girl is wearing a diaphanous silk shirt supported by a black leather corset and red lace.  She also wears a plain, olive-toned skirt that barely protects her modesty, and nearly fails in its purpose with every subtle breeze.  Her wide hips flare into spacious thighs before disappearing under a layer of shaggy, auburn fur that grows thicker and thicker the closer it gets to her hooves.\n\n");
		sceneHunter.print("And here go some tallness checks. Not that they block anything, but being taller or shorter than 6'6\" may open some nice scene variations.");
		//(tall PC's 6'6</i>\"+)
		if(player.tallness > 78) {
			sceneHunter.print("Check failed... or not? You're taller than she <i>usually</i> likes.");
			outputText("The cow-girl narrows her eyebrows in irritation as she sizes up your impressively large form.  She speaks with a strange accent, \"<i>Who are you and vat are you doing here?</i>\"\n\n");
			outputText("You answer and begin to explain yourself, but she interrupts, \"<i>Get out!  Zis is mein camp and I vill not tolerate you here!</i>\"\n\n");
			outputText("A bit taken aback by her violent reaction, you blink in confusion as she pulls a titanic shield from behind her chair and slides her arm comfortably into the strap.  What do you do?\n\n");
			//[Talk] [Fight] [Leave]
			simpleChoices("Try to Talk", tryToTalkDownAngryCow, "Fight", unwelcomeFightCowGal, "", null, "", null, "Leave", leaveAngryIzzy);
		}
		//(Shorter PC's)
		else {
			if(flags[kFLAGS.ISABELLA_MET_SHORT_PC] < 0) flags[kFLAGS.ISABELLA_MET_SHORT_PC]++;
			outputText("The cow-girl's big brown eyes soften as she regards your relatively diminutive form.  She smiles and coos, \"<i>Awww, you're zuch a cutey!  Izabella could never turn avay someone like you.  Come here, vould you like a drink?</i>\"");
			outputText("\n\nYou approach and exchange introductions with the friendly woman, still a bit taken aback by her eagerness.");
		    isabellaFollowerScene.isabellaAffection(5); //she prefers short ones
			//(Male PC's)
			if(player.hasCock()) {
				outputText("  She sniffs the air and immediately glances towards your groin.");
				if(player.cocks[player.shortestCockIndex()].cockLength < 9) {
					outputText("The cow's eyes practically fog with lust when she sees the size of your diminutive bulge.  Isabella begs, \"<i>V-vould you come closer?  I-ah have a fondness for 'small' lovers, and I like to... 'lick'.</i>\"  To emphasize, she rolls out her tongue, showing you nearly eight inches of flat, wide, and pink flesh.");
					suck = izzyGivesSmallWangsFreeOral;
				}
				else outputText("  The cow's eyes close, disappointment visible on her face when she sees the sheer size of your bulge.");
			}
			//[Talk – real conversations] [Drink – leads to breastfeeding] [Get Licks – leads to oral for small fries] [Rape?]
			simpleChoices("Talk", talkWithIsabella, "Drink", nomOnMommaIzzysTits, "Get Licked", suck, "Fight", fightIsabella, "Leave", explorer.done);
		}
		return;
	}
	//Camp Meeting – Repeat Unwelcome
	else if(player.tallness > 78 && flags[kFLAGS.ISABELLA_OKAY_WITH_TALL_FOLKS] == 0) {
		sceneHunter.print("Check failed... or not? You're taller than she <i>usually</i> likes.");
		outputText("You stumble through the grass, nearly tripping as it parts to reveal the now-familiar sight of Isabella's camp.  The cow-girl spots you instantly and snarls, \"<i>Begone!  I varned you once already!</i>\"");
        isabellaFollowerScene.isabellaAffection(-5);
		//[Talk] [Fight] [Leave]
		//Leave goes to special variation, see below.
		simpleChoices("Try To Talk", tryToTalkDownAngryCow, "Fight", fightIsabella, "", null, "", null, "Leave", leaveAngryIzzy);
		return;
	}
	//Camp Meeting – Was welcome tall, but not short yet!
	else if(flags[kFLAGS.ISABELLA_OKAY_WITH_TALL_FOLKS] > 0 && flags[kFLAGS.ISABELLA_MET_SHORT_PC] == 0 && player.tallness <= 78) {
		flags[kFLAGS.ISABELLA_MET_SHORT_PC]++;
		outputText("You stumble through a wall of tall grasses back into Isabella's camp!  It's amazing how much taller they've become since your last visit.  Or perhaps it just seems that way due to the change in height.  You look for Isabella, and the fiery, red-headed cow-girl is charging right at you, bellowing, \"<i>Awwww, you're so much cuter!  Iz vonderful to have such tiny, adorable friends!  Did you come back for one of mein special drinks?</i>\"  She envelops you in a hug that crushes you against jiggling breast-flesh, and in seconds you're cradled in her arms as she marvels at your new size.\n\n");
        isabellaFollowerScene.isabellaAffection(10); //happy!!
		if(player.hasCock()) {
			outputText("Her nose twitches and ");
			if(player.cocks[player.shortestCockIndex()].cockLength < 9) {
				outputText("she glances down at your small bulge.  Isabella's lips curl into a lewd smile as her voice grows husky.  \"<i>Maybe you could... pull it out for me?  I just vant to lick it a little.</i>\"");
				suck = izzyGivesSmallWangsFreeOral;
			}
			else {
				outputText("she glances down at your ");
				if(player.cocks[player.shortestCockIndex()].cockLength < 20) outputText("large");
				else outputText("gigantic");
				outputText(" bulge.  Isabella sighs and mumbles something about it being too big to be any fun.");
			}
			outputText("\n\n");
		}
		outputText("The cow-girl's dusky cheeks color pink with embarrassment before she sets you down and apologizes, saying, \"<i>I am so sorry.  It iz so lonely here in ze plains, and well, feeding someone is how do you say... more fun when you can cuddle them in your arms!</i>\"\n\n");
		outputText("What do you want to do with Isabella today?");
	}
	//Camp Meeting – Welcomed Short but Not Tall
	else if(flags[kFLAGS.ISABELLA_MET_SHORT_PC] > 0 && flags[kFLAGS.ISABELLA_OKAY_WITH_TALL_FOLKS] == 0 && player.tallness > 78) {
		sceneHunter.print("Check failed... or not? You're taller than she <i>usually</i> likes.");
		outputText("You easily brush through the tall grasses and stride into Isabella the cow-girl's camp.  It looks like she was sitting in her chair mending a blanket when you arrived, and you take a moment to watch her hunched posture squeeze her breasts tightly against the gauzy silk top she's so fond of wearing.  The outline of a single areola is clearly visible through the diaphanous material, but most striking is that each areola has four VERY prominent nipple-tips.  She looks at you, first in fright, and then in embarrassment as she recognizes you AND realizes what you were doing in a single instant.\n\n");
		//(+lust!)
		dynStats("lus", 10+rand(10), "scale", false);
		outputText("Isabella complains, \"<i>Vere you just checking me out?  Vell, I must confess, I liked you better ven you were shorter.  Maybe if you ask nicely I might give you a peak and a drink.  That vould be nice, nein?\n\n");
        isabellaFollowerScene.isabellaAffection(-5); //unhappy, but she knows you already
		flags[kFLAGS.ISABELLA_OKAY_WITH_TALL_FOLKS]++;
		if(player.hasCock()) {
			outputText("She sniffs and gives your crotch a glance ");
			if(player.cocks[player.shortestCockIndex()].cockLength >= 9) outputText("before sighing wistfully.");
			else {
				outputText("before offering something else.  \"<i>Perhaps you could undress?  I like to play vith my tongue if you know vat I mean.</i>\"");
				suck = izzyGivesSmallWangsFreeOral;
			}
		}
	}
	//Follower go!
	else if (flags[kFLAGS.ISABELLA_CAMP_DISABLED] == 0 && flags[kFLAGS.ISABELLA_FOLLOWER_ACCEPTED] == 0 && isabellaFollowerScene.isabellaAffection() >= 100) {
		isabellaFollowerScene.isabellaMoovesInGreeting();
		return;
	}
	//[Standard welcome options]
	//Camp Meeting – Standard Repeat
	else {
		if(flags[kFLAGS.ISABELLA_MET_SHORT_PC] < 0) flags[kFLAGS.ISABELLA_MET_SHORT_PC]++;
		outputText("While making your way through the tall grasses you hear a familiar voice lilting in a high-pitched foreign song.  It sounds like Isabella the cow-girl is at it again.  You meander towards the melodic tune, smiling as it rises in pitch and volume through your journey.  A short time later you break through the edge of the grasses in time to watch Isabella finish her song and the curvy cow-girl seems completely oblivious to your presence, enraptured by the music of her homeland.\n\n");
		outputText("You wait patiently, watching her curvy body shift and her large, milk-swollen breasts wobble dangerously inside her near-transparent shirt.  Her quad-tipped areolas are plainly on display, clearly engorged and ready to leak.  If you weren't here, in this strange place, you'd be amazed by how her breasts are basically humanized udders.  In this place, it's just another thing that adds to her exotic appeal.\n\n");
		outputText("Isabella finishes her song and turns to you with a twinkling smile as she asks, \"<i>Did you come back for some of ze milk?</i>\"");
        //no changes
		if(player.hasCock()) {
			outputText("  She takes a long sniff and glances between your [legs] at your groin");
			if(player.cocks[player.shortestCockIndex()].cockLength >= 9) outputText(", sighing wistfully. Seems like it's too big for her.");
			else {
				outputText(".  Her tongue inadvertently licks her lips before she asks, \"<i>Mmmm, just the right size.  Might I give it a lick?</i>\"");
				suck = izzyGivesSmallWangsFreeOral;
			}
		}
	}
	choices("Talk", talkWithIsabella, "Drink", nomOnMommaIzzysTits, "Get Licked", suck, "Fight 4 Rape", fightIsabella, "Offer Oral", volunteerToSlurpCowCunt,
		"", null, "", null, "", null, "", null, "Leave", explorer.done);
	//outputText("ISABELLA HAS BROKEN.  PLEASE TELL FENOXO.", true);
}

private function isabellaGreetingFirstTime():void {
	flags[kFLAGS.ISABELLA_CAMP_APPROACHED] = 1;
	isabellaGreeting();
}

//Leave]
public function leaveAngryIzzy():void {
	spriteSelect(SpriteDb.s_isabella);
	clearOutput();
	outputText("You shrug and make it quite clear you're leaving.  Crazy cow.  She shouts, \"<i>And stay avay, demon!  Izabella has no need of your foul tricks!</i>\"");
	endEncounter();
}
//[Fight]
public function unwelcomeFightCowGal():void {
	clearOutput();
	outputText("You ready your [weapon] and adopt a fighting pose.  No cow is going to chase you away!");
	isabellaFollowerScene.isabellaAffection(-20); //this is NOT fine
	startCombat(new Isabella());
	flags[kFLAGS.ISABELLA_ANGRY_AT_PC_COUNTER] = 72;
	spriteSelect(SpriteDb.s_isabella);
	doNext(playerMenu);
}
//Fuck-fight
public function fightIsabella():void {
	clearOutput();
	isabellaFollowerScene.isabellaAffection(-15); //this is NOT fine
	outputText("You smirk at Isabella, and ready your [weapon], telling her you intend to have you way with her.  She turns beet red and grabs her shield, announcing, \"<i>You von't find me such easy prey, and I vill punish you for being so naughty!</i>\"");
	startCombat(new Isabella());
	flags[kFLAGS.ISABELLA_ANGRY_AT_PC_COUNTER] = 72;
	spriteSelect(SpriteDb.s_isabella);
	doNext(playerMenu);
}
//[Talk]
public function tryToTalkDownAngryCow():void {
	clearOutput();
	spriteSelect(SpriteDb.s_isabella);
	//(int below 25)
	if(player.inte < 25) {
		outputText("You open your mouth and tell her you won't be leaving until she understands that you aren't her enemy.  She snorts and taunts, \"<i>You zink Izabella vould fall for zuch trickery? HAH!</i>\"\n\n");
		outputText("Your reply is blotted out by the thundering of her hooves as she lowers her shield and charges.\n\n");
		startCombat(new Isabella());
		isabellaFollowerScene.isabellaAffection(-10); //ur stupid
        SceneLib.combat.enemyAIImpl();
    }
	//(int below 50)
	else if(player.inte < 50) {
		outputText("You start to try to explain your reasons for coming here, stuttering slightly in haste as the angry cow-girl looks to be paying less and less attention.  She snorts and lowers her shield, shouting, \"<i>You zink Izabella vould fall for zuch nonzense? HAH!  Prepare to face mein fury!</i>\"");
		isabellaFollowerScene.isabellaAffection(-5); //bruh
		//(start combat)
		startCombat(new Isabella());
	}
	//(Int below 75)
	else if(player.inte < 75) {
		outputText("You do your best to explain the situation, but even giving her such a concise, well-explained argument doesn't seem to help you.  She snorts dismissively and says, \"<i>Shut up.  I have no patience for ze mutants of this land.  Now, if you truly mean no harm, you'd best find a way out of mein clearing before Izabella's shield breaks your noggin!</i>\"");
		isabellaFollowerScene.isabellaAffection(-2); //R YOU FUCKING STUPID
		//(Start combat)
		startCombat(new Isabella());
	}
	//(Else)
	else {
		if(player.weaponName != "fists") outputText("You toss aside your [weapon] and");
		else outputText("You");
		outputText(" hold your hands up in a gesture of peace and calmly state that you mean her no harm, but you would like to at least speak with her.  She looks you up and down and snorts, \"<i>Very vell, Izabella vill listen to your words.</i>\"\n\n");
		outputText("You sit down in the dirt and impart your tale, explaining how you came here as a 'champion', chosen by your village.  You go on to speak of your encounters and how strange everything is here, and Isabella nods quite knowingly as you go on and on.  Now that you've begun to tell your tale, the words fall out of your mouth, one after another.  Like an unbroken chain, they spool out of your maw until nearly an hour later, you finally run out of things to say.  You rub your jaw, your throat a little sore from the diatribe, and look on to Isabella to see how she reacts.\n\n");
		outputText("The busty cow-girl has moisture glimmering in the corners of her big brown eyes, and she nods emphatically to you as she vocalizes her feelings, \"<i>I, too, know how you feel, Champion [name].  Mein own story is similar, though mein fate vas not thrust upon me so.  Perhaps I vill tell you sometime, but for now, ve should part.  You are velcome to return in ze future.</i>\"\n\n");
		outputText("You smile to yourself, glad to have made a friend.\n\n");
		endEncounter();
		isabellaFollowerScene.isabellaAffection(10); //yay
		flags[kFLAGS.ISABELLA_OKAY_WITH_TALL_FOLKS]++;
	}
}


public function nomOnMommaIzzysTits():void {
	clearOutput();
	spriteSelect(SpriteDb.s_isabella);
	var x:Number = player.cockThatFits(20);
	//[Voluntary Nursing – PC is a big one or taur]
	if(player.tallness > 78 || player.isTaur()) {
		sceneHunter.print("Check failed... or not? You're taller than she <i>usually</i> likes.");
		outputText("Isabella's face lights up when you let her know that you could use a drink.  She grabs one of her blankets from atop a chest and throws it out over the ground.  The fabric of her intricately-patterned spread settles over the dirt, amazing you with its quality and size.  It's well over 10 feet from edge to edge and does a fantastic job of making the patch of dirt feel a lot more comfortable.  The busty cow-girl walks onto it, almost like a carpet, but then she lies down on her side and begins casually unlacing the red cord from her black corset.  Her mountainous mammaries wobble dangerously with each tug, and then she's tossing the corset aside.  With it out of the way, there's nothing between you and the cow-girl's glistening, sun-kissed skin except for a gauzy layer of silk.\n\n");

		outputText("You approach, salivating slightly in anticipation of the taste of the cow-girl's milk and unintentionally growing more and more aroused by her 'concealed' and yet totally exposed breasts.  ");
		if(player.hasCock()) {
			outputText("Your [armor] tents ");
			if(player.biggestCockArea() > 40) outputText("hard, barely constraining " + sMultiCockDesc() + ".");
			else outputText("visibly from " + sMultiCockDesc() + ".");
			outputText("  ");
		}
		if(player.hasVagina()) {
			if(player.hasCock()) outputText("Even y");
			else outputText("Y");
			outputText("our " + vaginaDescript(0) + " ");
			if(player.wetness() < 3) outputText("glistens with ");
			else if(player.wetness() < 5) outputText("drips ");
			else outputText("streams ");
			outputText("moisture, reacting to the erotic vision.  ");
		}
		outputText("Isabella's weighty chest heaves with each heavy breath she takes, and she motions for you to lie down next to her.  Her dusky lips part to say, ");
		if(isabellaAccent()) outputText("\"<i>Come closer, I do not bite.  Ve both know how very thirsty you are. Izabella vill sate you,</i>\" as she pulls the tightly stretched silk over the curve of her deliciously bronzed mounds.\n\n");
		else outputText("\"<i>Come closer, I don't bite.  We both know how thirsty you are.  Isabella will sate you,</i>\" as she pulls the tightly stretched silk over the curve of her deliciously bronzed mounds.\n\n");

		outputText("Her areolae are large, maybe two or three inches across, though perched as they are atop such glorious globes, they still seem small.  Each of them has four nipples protruding nearly an inch up from the surface, and each of them is starting to bead with tiny drops of milk.  You lean closer, a little hesitantly, and watch the beads slowly grow to droplets before they roll down the dark-skinned arc of the cow-girl's chest.  It smells very sweet... sweeter than you'd expect, but there is another smell in the air coming from lower on Isabella's body that indicates a whole other type of need.  There are faint, muffled wet squelches at the edge of your hearing, and it's then that you notice one of her hands has disappeared below her skirt.\n\n");

		outputText("Before you can comment, her other hand is grabbing ");
		if(player.horns.count > 0 && player.horns.type > Horns.NONE) outputText("your horns");
		else outputText("the back of your head");
		outputText(" and smashing your face into her leaky milk-spouts.  You react fast enough to open wide, and all four of the nipples slide into your mouth.  Their tips press together and leave a steady stream of milk on your tongue as you lick and slurp around the needy nipples, relieving Isabella's desire to breastfeed while sating your own thirst.  The surface of the large, rounded breast wraps around most of your head, practically molding to your face from how hard Isabella's pulling on you.  Without light, you close your eyes and drink, sucking deeply as the flow intensifies.  It even seems to get sweeter with each gulp of the cow-girl's breast-milk.\n\n");

		outputText("You get rather absorbed in your task and lose track of time as you pull harder, trying to see just how far her supply of the stuff goes.  A flood of creamy sweetness nearly drowns you in response, and you're forced to chug for a few seconds to keep up with the flood.  Even without your suction, the flow of milk is much stronger than before, and it slakes your thirst quite effectively.  Isabella's song-strengthened voice begins moaning out loud, and though you can't make out the exact words due to her thick accent and lapses into a strange tongue, the meaning is quite clear: \"<i>Good " + player.mf("boy","girl") + "... (unintelligable moans)... yes, keep drinking... (more moaning)</i>\"\n\n");

		outputText("You're roughly yanked away from the milk spouting breast and pulled up to Isabella's face.  The cow-girl's bronzed visage is flushed darker, and even one of the white patches on her neck is crimson-tinged with lust.  She licks the creamy milk from your lips with an exceptionally wide, smooth tongue and then passionately french-kisses you, squirting more of her milk onto your " + chestDesc() + " the entire time.");
		if(player.hasCock()) outputText("  " + SMultiCockDesc() + " twitches and drips from the intensity of the kiss, but you had completely forgotten about your sexual needs while you were drinking.");
		else if(player.hasVagina()) outputText("  Your " + vaginaDescript(0) + " aches with need and desire from the intensity of the kiss, but you had completely forgotten it during the feeding.");
		outputText("  The kiss doesn't last long anyway.  Once her strangely flexible tongue has lapped the milk residue from your mouth, you're pulled towards the other, leaky tit.\n\n");

		outputText("Milk runs down the curvature of the unused tit in a slow waterfall until your lips are sealed around the 'spring'.  Just like before, she pushes harder and harder until her milk is squirting into your throat and the blushing bronzed tit is wrapped around you.  The cow-girl's delicious nectar is better than you remember, and it's still getting sweeter!  Her flared hips and curvy thighs keep bumping you, getting faster and harder as the noise of Isabella's masturbation grows louder.  Yet rather than being roused by the racket, you block it out and continue to drink deeply, savoring the thickening milk as it blasts into your throat.\n\n");

		outputText("Isabella lets out a thunderous scream of pleasure, but you just sigh in between swallows, devouring the thick, candy-sweet cream she's pouring into you.  Her arms wrap around your shoulders");
		if(player.wings.type > Wings.NONE) outputText(" and stroke your wings");
		outputText(", lulling you into a state of peaceful relaxation where the only things you feel are her soft flesh enveloping you and her wonderful cream filling your belly until it's fit to burst.  You pop off with a sigh and snuggle into her neck, starting to doze as she croons hypnotically into your ear.\n\n");

		//(Male and it fits end)
		if(player.hasCock() && x >= 0) {
			outputText("You wake after an hour of highly erotic dreams to find yourself snuggled against Isabella, held tightly in the crook of her arm.  She's snoring soundly, so you quietly extricate yourself from underneath her limb and cover her back up with her blanket.  As you stretch, you realize you're completely naked, your crotch is sore, and you absolutely reek of feminine lust.");
			if(flags[kFLAGS.ISABELLA_SLEEP_RAPES] == 0) outputText("  S-she fucked you in your sleep?  That explains how good your dreams were.  On one hand you feel a little violated, but on the other you have to wonder how long this woman has held her camp against the demons with nothing to please her.");
			else outputText("  It looks like she fucked you in your sleep again.  You wish you wouldn't fall asleep so soundly after drinking her milk so that you could contribute to the sex, but you wake so COMPLETELY SATED in every way that you know it's going to be hard to ever turn her down.");
			//(no lust!, minus 50 fatigue)
			player.sexReward("milk");
			fatigue(-50);
			//increment sleep rape counter
			flags[kFLAGS.ISABELLA_SLEEP_RAPES]++;
		}
		//(Generic End)
		else {
			outputText("You wake an hour later snuggled into a few of Isabella's blankets and feeling quite content.  The cow-girl is sitting in her chair, honing the bottom edge of her shield into a razor-sharp cutting surface.  She looks back at you and smiles, pausing her work to ask, ");
			if(isabellaAccent()) outputText("\"<i>Did you enjoy mein snack?  I think ve both needed ze drink, no?</i>\" You nod, stand up stretch, feeling energized and awake.");
			else outputText("\"<i>Did you enjoy the snack?  I think we both needed the drink, no?</i>\" You nod, stand up stretch, feeling energized and awake.");
			//(-65 fatigue)
			fatigue(-65);
		}
	}
	//Voluntary Nursing (Small Characters)
	else {
		outputText("You are quite thirsty, and make no secret of it to Isabella, whose face broadens into a knowing smile as she replies, ");
		if(isabellaAccent()) outputText("\"<i>Vell, you are in luck then!  I have ze most delicious milk you'll find anywhere.  Come here little one, and Isabella vill give you all you need.</i>\"\n\n");
		else outputText("\"<i>Well, you're in luck then!  I have the most delicious milk you'll find anywhere.  Come here little one, and Isabella will give you all you need.</i>\"\n\n");

		outputText("The large-chested cow-girl carelessly begins to unlace her corset, jiggling her barely-covered melons with each hard tug.  You lurch forward, licking slightly chapped lips, already ensnared in Isabella's inadvertent strip-tease.  With one final, sharp tug, the dark-skinned beauty removes the offending garment, setting it on a nearby blanket.  Her breasts bounce and sway pendulously without the corset's added support, dragging a multitude of hard, damp nipples across the silken prison of her top.  A moment later, tanned olive-toned hands are pulling the offending garment up and out of your view.  There's nothing left between you and Isabella's exquisite mammaries but empty air.\n\n");

		outputText("You stop and look at them, just look, leaving nothing in the air but a long, pregnant pause that seems to go on and on.  Isabella coughs, snapping you from your reverie – you're standing a foot away from those sweat-glazed orbs, and you jerk your head back.  If you leaned any further forward, her prominent, quad-tipped areola would be in your mouth.  The cow-girl laughs and scoops you up in her arms before you can hesitate further.  Your cheek is crushed against a white spot on the side of her left tit, and your [butt] comes to rest on the short fur that sprouts from her thick thighs.  Isabella coos, \"<i>Relax, [name], and let Izabella sate your thirst.  You vill love it.</i>\"\n\n");

		outputText("She forcefully shifts your position, angling her left arm to cradle your back as you're dragged off the creamy part of her chest and onto the darker portions of her mounds.  A three inch wide nipple looms at the bottom of your vision, and moist sweetness brushes over your lips.  You're struck by how very much this entire situation is out of your control.  Confident hands have you locked in their embrace while you curl on Isabella's lap in the most helpless way, and there's not a lot you can do to stop it, even if you wanted to.  Your mouth yields to her insistently pressing nipples, letting all four tips slide through your puckered gateway and press together over your tongue.\n\n");

		outputText("Perhaps it's your thirst, the large cow-girl's aura, or some hidden instinct, but you find yourself starting to swirl your tongue about the grouped nipples and suckle.  Isabella groans happily and rewards your hunger with a steady flow of sweet, warm milk.  The flow is still slow - more a constant trickle from all four nipples that combines into a decent stream - but, thirsty as you are, you suckle and swallow all the same.  The cradling arm shifts slightly, pressing you harder against her bronze skin until you're practically smothered in smooth brown tit-flesh.  You suckle a little harder and the trickle becomes a stream, easily filling your mouth with such speed that you barely have to suck.  With the caramel mound blocking your vision, you go ahead and close your eyes, letting them rest as you gulp down another mouthful of increasingly sweet breast-milk.\n\n");

		outputText("You sigh and nuzzle Isabella affectionately, drinking calmly of her milk, unaware of the increasing warmth and pink tinges that bloom on her skin.  Nectar-flavored milk and the constant rhythm of sucking, swallowing, and breathing become your world as you let yourself lean harder on the pillowy cow-tits.  The air grows hot and humid from having two bodies entwined so close together, and a tangy, familiar smell bubbles up in the air, accompanied by the faint squish of Isabella's free hand.  You can feel it brushing your [butt] with each pumping motion, masturbating the cow-girl's lust-swollen snatch with powerful strokes.\n\n");

		outputText("The ordinarily arousing noises don't have much of an effect on you, busy as you are.  In fact, the repeated schlicking is soothing in its own way, a constant background thrum that lulls your troubled mind.  Through rapidly fading thirst, you start to suck hard, curious how long it'll take her milk-squirting cow-tits to drain.  The white fluid gushes over your tongue and into your throat, nearly drowning you and forcing you to gulp it down in huge swallows or let go, and you don't want to let go.  Your fingers dig into the soft breast, squeezing it as you truly latch on and ride the tidal wave of white until it finally exhausts itself and slows to a trickle.\n\n");

		if (isabellaAccent())
		{
			outputText("Isabella pants as she pulls you back, giving you your first glimpse of just how rosy her tanned skin has gotten, but then you're moving across her chest towards an untapped reservoir of pale nectar.  You start to mention that you've had enough, but Isabella shushes you in between low, lurid moans.  \"<i>Nein, drink up mein friend.  We don't vant you to suffer heat-stroke");

			if (!isabellaFollower()) outputText(" on the vay back!");
			else outputText(" vhile you are aus und über!");

			outputText("Ooooh... </i>\" she groans as she presses your mouth into the milk - dripping waterfall that is her other breast.  You mumble a reply, but it turns into a messy burble as nipples and milk fill your opened mouth.  Immediately you begin to suckle anew, your protests washed away in syrupy - sweetness.\n\n");
		}
		else
		{
			outputText("Isabella pants as she pulls you back, giving you your first glimpse of just how rosy her tanned skin has gotten, but then you're moving across her chest towards an untapped reservoir of pale nectar.  You start to mention that you've had enough, but Isabella shushes you in between low, lurid moans.  \"<i>No, drink up my friend.  We don't want you to suffer heat-stroke");

			if (!isabellaFollower()) outputText(" on the way back!");
			else outputText(" while you're out and about!");

			outputText(" Ooooh...</i>\" she groans as she presses your mouth into the milk-dripping waterfall that is her other breast.  You mumble a reply, but it turns into a messy burble as nipples and milk fill your opened mouth.  Immediately you begin to suckle anew, your protests washed away in syrupy-sweetness.\n\n");
		}

		outputText("The cow-girl's dusky flesh mashes against you as her constant groin-pumping increases in tempo.  Coupled with an increase in the pitch and volume of her wanton moans, you can tell she's about to orgasm.  The milk gets sweeter, then thicker.  It changes in seconds to a rich, heavy cream that makes your tongue sing and your overfilled belly gurgle.  You suck harder, lost in the moment and the comfort of Isabella's plush embrace, and her moaning, moo-studded orgasm floods your mouth with even more cream.  Lost in swallowing ambrosia, you guzzle it down for as long as it flows and zone out completely.  The constant milk-filling swells your belly until it feels close to bursting, but you keep drinking anyway.\n\n");

		outputText("Sometime later you burp loudly and snuggle against the perfect, soft chest in front of you, sighing with happiness as a hand strokes your " + hairDescript() + ".  Isabella croons soft nothings into your ear and you drift into a dreamless, restful slumber.\n\n");

		//(Mandiggity!)
		//(Male and it fits end)
		if(player.hasCock() && x >= 0) {
			outputText("You wake up an hour later in a massive sprawl of blankets.  There's a soft pillow below you and another one above, and you struggle to dig your way out until a pair of arms wrap around you.  Those aren't pillows – you're trapped between the cow-girl's breasts!  You carefully slide downwards, giving her large, leaking nipples a longing look as you extricate yourself from the embrace with care.  She snores on, blissfully ignorant of your departure as you find your [armor] and re-dress.  There's a hint of tight soreness in your groin, and after reaching down to adjust yourself, your hand comes up reeking of feminine cow-girl.  ");
			if(flags[kFLAGS.ISABELLA_SLEEP_RAPES] == 0) {
				outputText("S-she raped you in your sleep?  You aren't sure how she pulled it off, but your ");
				if(player.hasBalls()) outputText("balls feel");
				else outputText("body feels");
				outputText(" so empty and sated you must have gotten off a few times.  Well, all things considered you feel quite rested, even if you got a bit more than you asked for.  Maybe next time you'll at least stay awake for the fun parts!");
			}
			else {
				outputText("She sleep-fucked you again!  You sigh and wipe your hand off on your [leg], bemused by the cow-girl who seems too shy to sleep with someone who's awake.  Still, you feel completely sated in every way.  It's going to be a good ");
			   if(model.time.hours < 12) outputText("day");
				else if(model.time.hours < 4) outputText("afternoon");
				else outputText("evening");
				outputText(".");
			}
			//(no lust!, minus 50 fatigue)
			player.sexReward("vaginalFluids");
			fatigue(-50);
			//increment sleep rape counter
			flags[kFLAGS.ISABELLA_SLEEP_RAPES]++;
		}
		//(GENERIC)
		else {
			if(isabellaAccent()) outputText("You wake an hour later in a pile of blankets on the ground, feeling quite sated and rested.  Isabella is humming a pretty tune a few feet away and sharpening the bottom edge of a massive shield with a whetstone.  She stops when she notices you and sets the massive metal object aside with a noisy 'thunk'.  She reaches down for you with surprising quickness and lifts you up to kiss you on the forehead, saying, \"<i>Did you have a gud nap?  Ya?  Thanks for being such a thirsty drinker, I haven't felt this light in days.</i>\"  Isabella sets you back on your feet and you stretch, feeling remarkably energized.");
			else outputText("You wake an hour later in a pile of blankets on the ground, feeling quite sated and rested.  Isabella is humming a pretty tune a few feet away and sharpening the bottom edge of a massive shield with a whetstone.  She stops when she notices you and sets the massive metal object aside with a noisy 'thunk'.  She reaches down for you with surprising quickness and lifts you up to kiss you on the forehead, saying, \"<i>Did you have a good nap?  Ya?  Thanks for being such a thirsty drinker, I haven't felt this light in days.</i>\"  Isabella sets you back on your feet and you stretch, feeling remarkably energized.");
			//(-65 fatigue)
			fatigue(-65);
		}
	}
	//Follower stuff
	isabellaFollowerScene.isabellaAffection(10); //she likes that
	//Decrease 'time since milked' count
	if(flags[kFLAGS.ISABELLA_MILKED_YET] > 0) flags[kFLAGS.ISABELLA_MILKED_YET] = 0;
	player.slimeFeed();
	player.refillHunger(40);
	//(Chance of thickening body to 75, chance of softening body if PC has a vag)
	if(rand(2) == 0) outputText(player.modThickness(75,4));
	if(rand(2) == 0 && player.hasVagina()) outputText(player.modTone(0,4));
	endEncounter();
}

//[GET ORAL'ED AS A SMALL MALE]
public function izzyGivesSmallWangsFreeOral():void {
	spriteSelect(SpriteDb.s_isabella);
	var x:Number = player.smallestCockIndex();
	clearOutput();
	outputText("You ");
	if(player.cor < 33) outputText("blush hard and tell Isabella that she can lick if she wants to.");
	else if(player.cor < 66) outputText("blush and tell Isabella that she can definitely give you a lick.");
	else outputText("pose lewdly and trace a finger over your bulge as you inform Isabella just how happy you'd be to feel her tongue on your " + cockDescript(x) + ".");
	outputText("  The cow-girl blushes hard enough to color her dusky cheeks with a hint of rose, but her chest heaves with barely-contained excitement.  She drops out of the chair onto her knees and licks her lips hungrily, like a child eying a favorite treat.  Her hands dart forward and grab you by the " + hipDescript() + ", dragging you into a breast-padded hug.\n\n");

	outputText("Isabella goes to work immediately, undoing the lower portions of your [armor] with strong, forceful motions that shake your [ass] as she forcibly disrobes you.  Free at last, your " + cockDescript(x) + " flops out");
	if(player.cockTotal() > 1) {
		outputText(" along with the rest of your unusual package, though Isabella ");
		if(player.biggestCockArea() > 50) {
			outputText("shoves the larger, less desirable member");
			if(player.cockTotal() > 2) outputText("s");
			outputText(" to the side");
		}
		else {
			outputText("pushes the extra");
			if(player.cockTotal() > 2) outputText("s");
			outputText(" to the side");
		}
	}
	else outputText(", trembling weakly in the cow-girl's strong fingers");
	if(isabellaAccent()) outputText(".  The busty redhead gleefully squeals, \"<i>Oooh it's so cute!  Even ven it's hard like this, it looks sort of like something that vould go on a girl.</i>\"  She pulls on it, leading you around by your " + cockDescript(x) + " until you're in front of her chair, and then she pushes you back onto the seat, still warm from the cow-girl's bountiful ass.  She asks, \"<i>How long do you think it vill last, hrmm?  I vonder what its milk tastes like...</i>\"\n\n");
	else outputText(".  The busty redhead gleefully squeals, \"<i>Oooh it's so cute!  Even when it's hard like this, it looks sort of like something that would go on a girl.</i>\"  She pulls on it, leading you around by your " + cockDescript(x) + " until you're in front of her chair, and then she pushes you back onto the seat, still warm from the cow-girl's bountiful ass.  She asks, \"<i>How long do you think it will last, hrmm?  I wonder what its milk tastes like...</i>\"\n\n");

	outputText("The cow-girl pulls down on her neckline, giving you a tantalizing view of her cream and caramel cleavage.  She leans forwards and presses her milk-swollen tits against your [legs], rocking up and down so that you can feel each of the soft orbs squeezing around you.  Isabella's tongue slides out... and out... and out, until you see at least seven inches of tongue hovering over your " + cockDescript(x) + ".  Her warm spittle drips from the pulsing, smooth pink exterior of her tantalizing tongue while it lashes back and forth, less than an inch away from your " + player.cockHead(x) + ".  Each drop of fallen cow-girl spit that lands on your " + player.cockHead(x) + " only turns you on more, until you're grunting and panting at her, begging like an animal with a needy expression on your face.\n\n");

	outputText("Isabella smirks knowingly and caresses the sensitive underbelly of your " + cockDescript(x) + " while she coos, \"<i>");
	if(isabellaAccent()) outputText("You like, yes?  Mmmmhmm, Izabella knows.  I can see it on your face.  You aren't one of those perverts, are you?  I think you might be, but ve vill have to see, yes?  If you are one of them you'll be squirting all over Isabella's tongue in no time.  I dearly hope you'll prove me wrong.");
	else outputText("You like, yes?  Mmmmhmm, Izabella knows.  I can see it on your face.  You aren't one of those perverts, are you?  I think you might be, but we will have to see, yes?  If you're one of them you'll be squirting all over my tongue in no time.  I dearly hope you'll prove me wrong.");
	outputText("</i>\"  To emphasize her point, the well-endowed cow-girl leans down and shows you just how flexible she can be.  The hot, wet slipperiness of her oral organ turns sideways, mashing against the side of your " + player.cockHead(x) + ".  A split-second later, it slides down, and her tongue makes another loop around your " + cockDescript(x) + ".  The process continues on and on, girding your manhood in wide, spit-lubed cow-tongue until the entire thing is cocooned inside Isabella's velvet embrace.\n\n");

	outputText("It feels so damned good!  You groan out loud ");
	if(player.cor < 50) outputText("before blushing, ashamed by your wanton behavior but not really wanting it to end.");
	else outputText("before sighing blissfully, absorbed in the feel of her tongue, never wanting it to end.");
	outputText("  The strength ebbs from your body while Isabella corkscrews her tongue around you, and the warm, sticky wetness that envelops your " + cockDescript(x) + " grows hotter and hotter.  The contentment you've been feeling melts away like ice-cream on a sunny day while you adjust to the sensation.  Your body craves more, and Isabella obliges, opening her lips wide to engulf you wholly with her mouth.\n\n");

	outputText("The feeling is something like a strange hybrid between a vagina and a blowjob, bathing your entire length with syrupy, warm sensations.  ");

	sceneHunter.print("Lust check: 50%")
	//(Low sensitivity success!)
	if(player.lust < 0.5 * player.maxLust()) {
		outputText("You moan happily, hips rocking instinctively against the cow-girl's vacuum-tight tongue-job as she cranks up her efforts to the maximum in an effort to make you blow already.  Panting lustily, you grab her horns and pull her face partway back, then slam it down while your " + cockDescript(x) + " drips pre-cum onto the top of her tongue.  She flaps it back and forth, smearing your " + player.cockHead(x) + " with the slippery stuff and torturing you with exquisite sensations that would have lesser individuals spurting in seconds.\n\n");
		if(isabellaAccent()) outputText("Isabella grunts and pulls back, pulling her horns from your pleasure-weakened fingers and panting heavily.  She groans, \"<i>Nein, I cannot believe it!  Such a small, hard little cock and I couldn't make it spurt, not even vith mein special techniques!</i>\"  She looks up at you with her flushed, breathy face and coos, \"<i>You are NOT a pervert after all.  Not a " + player.mf("boy","maid") + ", but a " + player.mf("man","woman") + " with a beautiful, succulent little cock for Isabella to suck.  How lucky I am!</i>\"\n\n");
		else outputText("Isabella grunts and pulls back, pulling her horns from your pleasure-weakened fingers and panting heavily.  She groans, \"<i>No, I can't believe it!  Such a small, hard little cock and I couldn't make it spurt, not even with my special techniques!</i>\"  She looks up at you with her flushed, breathy face and coos, \"<i>You aren't a pervert after all.  Not a " + player.mf("boy","maid") + ", but a " + player.mf("man","woman") + " with a beautiful, succulent little cock for Isabella to suck.  How lucky I am!</i>\"\n\n");
		outputText("The cow-girl returns to her task with gusto, snaring your " + cockDescript(x) + " with her tongue, but instead of going all-out with her corkscrew technique, she's pumping it, sliding her hot wetness up and down your shaft with practiced ease.  ");
		if(player.hasBalls()) outputText("She cups your [balls] and begins caressing the twitching orbs, giving them gentle squeezes each time the pleasure forces them to involuntarily contract towards your groin.");
		else if(player.hasVagina()) {
			outputText("She probes your " + vaginaDescript() + " with her fingers, running them over your engorged lips and giving your " + clitDescript() + " ");
			if(player.clitLength < 3) outputText("gentle squeezes");
			else outputText("firm pumps");
			outputText(".");
		}
		else {
			outputText("She runs one finger from the ");
			if(player.hasSheath()) outputText("sheath");
			else outputText("base");
			outputText(" of your " + cockDescript(x) + " to your " + assholeDescript() + ", teasing the sensitive skin with light touches of her fingernail.");
		}
		outputText("  You latch onto her horns again and pull her back into position, and the sultry cow-maid wastes no time adding the suction of her puckered lips back to the mix.\n\n");

		outputText("Isabella doesn't protest as you force her to take different positions, using her horns to guide the orally fixated cow-girl's lips up and down, face-fucking her even while she gives you a lewd-sounding tongue-fuck.  The entire time she's looking up at you with delight, perhaps turned on by being used in such a base manner by one with such a small implement of pleasure.  Her eyes sparkle with amusement even as the rest of her countenance blushes with lust, and you pick up the pace, trying to surprise her.  It doesn't work, she just continues to watch you while you brutally face-fuck her and fill the air with the sloppy sounds of oral sex.\n\n");

		outputText("It continues like this for who knows how long, until you're both breathing hard and covered in a fine sheen of sweat.  Isabella finally closes her eyes, and at once her tongue goes crazy, corkscrewing and stroking at the same time.  It's pure heaven!  With strength born of orgasmic need, you pull hard on her horns, mashing her puckered lips into your ");
		if(player.hasSheath()) outputText("sheath");
		else outputText("body");
		outputText(" while her tongue spins and pumps your " + cockDescript(x) + " to an inevitable release.  Your eyes cross as you try to hold out, but in seconds the telltale warmth begins to build inside you.  Finally, you give in and submit, feeling the cum welling in the cow-girl's suckling fuck-hole.\n\n");

		outputText("Isabella pulls her tongue tight, squeezing against you even as ");
		if(player.cumQ() >= 500) outputText("fat ");
		outputText("bulges of cum squeeze through your urethra.  With such vise-like tightness squeezing down, release seems nigh impossible, and it feels like more and more cum is backing up inside your urethra.  Isabella looks up, winks, and relaxes, and at once you blow the biggest cum-rope you can possibly produce down her throat.  The sultry cow-girl puts her tongue back to work, pumping it up and down your length as ");
		if(player.cumQ() < 100) outputText("spurts");
		else if(player.cumQ() < 1000) outputText("torrents");
		else outputText("eruptions");
		outputText(" of jism splatter from your spasming cum-tube.  You ");
		if(player.cumQ() < 250) outputText("empty the last of your load all over her tongue and pull out.");
		else if(player.cumQ() < 500) outputText("empty the last of your load into her belly and leak all over her waiting tongue as you pull out.");
		else if(player.cumQ() < 1500) outputText("empty huge batches of spunk into her belly until it's gurgling and full, and as you pull out you dribble enough to completely soak her tongue.");
		else outputText("empty enough cum inside the cow-girl for it to fill her belly and back up her throat.  By the time you pull out, she's got runners of sperm leaking from both sides of her mouth and dripping onto her tits, staining her dusky skin white.");
		outputText("\n\n");

		outputText("Isabella pulls back and licks her lips, leaving you to realize that your [legs] have been completely soaked with the cow-girl's own sweet cream.  ");
		if(player.isGoo()) player.slimeFeed();
		if(isabellaAccent()) {
			outputText("She sighs and looks up at the sky, uttering a completely contented 'moo'.  Your own exhalation of pleasure is a bit more muted, but truly, you feel utterly satiated.  Isabella looks over and gleefully says, \"<i>You aren't a pervert!  Oh Izabella is so happy for you!  It's so much fun having someone who knows how to handle my tongue, particularly when they have such a succulent... compact little package for me to suck!</i>\"\n\n");

			outputText("The feisty redhead happily helps you back into your [armor] and gives you an unceremonious smack on the [butt] before saying her goodbyes, \"<i>Come back soon, [name]!  You are quite ze " + player.mf("man","woman") + ", even if your tasty penis is tiny.  Oh don't look like zat, it makes such tasty salt-milk!  I'll lick it up any time.  Now go, I'm sure you have much to do!</i>\"\n\n");
		}
		else {
			outputText("She sighs and looks up at the sky, uttering a completely contented 'moo'.  Your own exhalation of pleasure is a bit more muted, but truly, you feel utterly satiated.  Isabella looks over and gleefully says, \"<i>You aren't a pervert!  Oh I'm so happy for you!  It's so much fun having someone who knows how to handle my tongue, particularly when they have such a succulent... compact little package for me to suck!</i>\"\n\n");

			outputText("The feisty redhead happily helps you back into your [armor] and gives you an unceremonious smack on the [butt] before saying her goodbyes, \"<i>Come back soon, [name]!  You are quite the " + player.mf("man","woman") + ", even if your tasty penis is tiny.  Oh don't look like that, it makes such tasty salt-milk!  I'll lick it up any time.  Now go, I'm sure you have much to do!</i>\"\n\n");
		}
		isabellaFollowerScene.isabellaAffection(12); //she's happy
	}
	//(High sensitivity fail!)
	else {
		outputText("You try to fight the heaven around your " + cockDescript(x) + ", but it's too much for your poor, sensitive body to endure.  Giving up, you relax, hips pistoning instinctively into her mouth as the warm tightness of an orgasm rises inside you.  Isabella's eyes stare up at your face, watching intently while she keeps her lips wrapped tightly ");
		if(player.hasSheath()) outputText("around your sheath");
		else if(player.hasBalls()) outputText("above your balls");
		else outputText("around your base");
		outputText(".  She keeps her position, rocking with each of your involuntarily movements, ");
		if(player.hasBalls()) outputText("her hand stroking and gently squeezing at your [balls] as if she could milk a bigger load from them that way.");
		else if(player.cockTotal() > 1) outputText("her hand stroking and squeezing your neglected " + cockDescript(1) + " almost as an afterthought.");
		else outputText("her hand stroking in an effort to milk your load from you.");
		outputText("\n\n");

		outputText("Isabella pulls her tongue tight, squeezing against you even as ");
		if(player.cumQ() >= 500) outputText("fat ");
		outputText("bulges of cum squeeze through your urethra.  With such vice-like tightness squeezing down, release seems nigh impossible, and it feels like more and more cum is backing up inside your urethra.  Isabella winks and relaxes, and at once you blow the biggest cum-rope you can possibly produce into her throat.  The sultry cow-girl puts her tongue back to work, pumping it up and down your length as ");
		if(player.cumQ() < 100) outputText("spurts");
		else if(player.cumQ() < 1000) outputText("torrents");
		else outputText("eruptions");
		outputText(" of jism splatter from your spasming cum-tube.  You ");
		if(player.cumQ() < 250) outputText("empty the last of your load all over her tongue and pull out.");
		else if(player.cumQ() < 500) outputText("empty the last of your load into her belly and leak all over her waiting tongue as you pull out.");
		else if(player.cumQ() < 1500) outputText("empty huge batches of spunk into her belly until it's gurgling and full, and as you pull out you dribble enough to completely soak her tongue.");
		else outputText("empty enough cum inside the cow-girl for it to fill her belly and back up her throat.  By the time you pull out, she's got runners of sperm leaking from both sides of her mouth and dripping onto her tits, staining her dusky skin white.");
		outputText("\n\n");

		outputText("Isabella pulls back and licks her lips, leaving you to realize that your [legs] have been completely soaked with the cow-girl's own sweet cream.  ");
		if(player.isGoo()) player.slimeFeed();
		if(isabellaAccent()) {
			outputText("You sigh nervelessly as the cow-girl waggles her tongue at you teasingly, making your " + cockDescript(x) + " jump from the memory of pleasure.  The redhead moans, \"<i>Oooh I knew it!  You are a pervert!  I just vanted to do a little licking and you got me all vet with your salty... mmm... cream.</i>\"  She pauses to lick her lips again before giving a gentle moo of contentment.  At least she doesn't seem mad at you!\n\n");

			outputText("The tanned woman looks down at you with disappointment and says, \"<i>You should get going, my tiny-cocked, pervert friend.  Perhaps you vill have some sex and learn how not to submit at ze first hint of pleasure?</i>\"  You go red with indignation, but she fondles your half-limp " + cockDescript(x) + " the entire time, a knowing smile spread across her lips.  Isabella helps you get dressed and gives you a firm smack on the [butt] as she says goodbye, \"<i>Don't change too much " + player.mf("boy","maid") + "!  I just hope ven you come back you've learned how not to cum ven I touch your buttons!</i>\"\n\n");
		}
		else {
			outputText("You sigh nervelessly as the cow-girl waggles her tongue at you teasingly, making your " + cockDescript(x) + " jump from the memory of pleasure.  The redhead moans, \"<i>Oooh I knew it!  You are a pervert!  I just wanted to do a little licking and you got me all wet with your salty... mmm... cream.</i>\"  She pauses to lick her lips again before giving a gentle moo of contentment.  At least she doesn't seem mad at you!\n\n");

			outputText("The tanned woman looks down at you with disappointment and says, \"<i>You should get going, my tiny-cocked, pervert friend.  Perhaps you will have some sex and learn how not to submit at the first hint of pleasure?</i>\"  You go red with indignation, but she fondles your half-limp " + cockDescript(x) + " the entire time, a knowing smile spread across her lips.  Isabella helps you get dressed and gives you a firm smack on the [butt] as she says goodbye, \"<i>Don't change too much " + player.mf("boy","maid") + "!  I just hope when you come back you've learned how not to cum when I touch your buttons!</i>\"\n\n");
		}
		isabellaFollowerScene.isabellaAffection(7); //disappointed, but anyway..
	}
	player.sexReward("saliva", "Dick");
	endEncounter();
}

//[Give Isy Oral]
public function volunteerToSlurpCowCunt():void {
	spriteSelect(SpriteDb.s_isabella);
	clearOutput();
	outputText("You indicate to Isabella that you're actually more interested in tasting HER, not her milk.  The dusky cow-girl looks at you dumbly, not comprehending what you mean.  Before you can explain, her cheeks bloom with crimson - she finally figured out what you meant.  The red-head quietly asks, ");
	if(isabellaAccent()) outputText("\"<i>You mean to lick me, down zere?</i>\"  Once again, Isabella preempts your words, though this time she does it with an uplifted skirt-hem and slowly-spreading thighs.  The shadow of the garment conceals the treasure inside, but a faint, feminine smell hits your nose, assuring you that she's looking forward to it as much as you.\n\n");
	else outputText("\"<i>You mean to lick me there?</i>\"  Once again, Isabella preempts your words, though this time she does it with an uplifted skirt-hem and slowly-spreading thighs.  The shadow of the garment conceals the treasure inside, but a faint, feminine smell hits your nose, assuring you that she's looking forward to it as much as you.\n\n");

	outputText("Isabella pulls the trappings of her clothing higher still, folding the skirt back against her corset to give you a completely unimpeded view at her womanhood.  Her sex is framed by the bronzed skin of her curvy thighs, displaying her femininity perfectly.  A thatch of bright red pubic hair sits above it, trimmed into a neat little teardrop shape that compliments the puffy, arousal-flushed skin of her vulva perfectly.  As you lower yourself down and slide in-between her legs, you're treated to the sight of her nether-lips growing puffier, and then slowly parting with each lusty gasp the cow-girl makes.  The slightly sticky juice she's starting to leak hangs between the parting lips like a slowly-stretching gossamer veil.\n\n");

	if(player.cor < 33) outputText("Hesitantly, you start to lean closer and closer until you're mere inches from the cow-girl's slick box.  The air practically fogs with her anticipation.  A strong, impatient hand grabs you by the back of the head and pushes you forward, burying your nose and lips into her wet, squelching lips.");
	else if(player.cor < 66) outputText("Eagerly, you start to lean further and further forward until you're less than an inch from the cow-girl's slick folds, and the air fogs with lusty anticipation.  Before you can dive in, her hand grips the back of your head and FORCES you inside her.  Her greedy lips swallow your nose and lips with one wet squelch.");
	else outputText("Unabashedly, you dive right into the cow-girl's lust-slicked snatch.  Her greedy lips swallow your nose and lips with one wet squelch, but the cow-girl doesn't seem quite satisfied until her hand is on the back of your head, mashing your [face] roughly over her sex.");
	outputText("  You smile against her quivering labia and open up, swallowing her love-button into your mouth and letting your tongue begin to rove drunkenly through her channel.  The red-head's thighs provide the perfect place for you to curl your arms and hands around, and as your fingers dig into the supple flesh, you fall into a rhythm of alternating slurps, licks, and humming over her growing clitty.\n\n");

	if(isabellaAccent()) {
		outputText("Isabella moans out, \"<i>Ohhhh ja... you're good at zis.  Mmmm, keep licking, ");
		if(player.tallness < 60) outputText("little ");
		else if(player.tallness > 80) outputText("big ");
		outputText(player.mf("boy","girl") + ".</i>\"  As if you needed any encouragement.  Her taste is surprisingly sweet and fresh, with only a hint of the tang one would expect from such a powerfully built woman.  Her hand relaxes its grip on you as you tongue more aggressively, pressing your lips hard against her vulva and letting your tongue explore the crevices of her labia.  The cow-girl's budding clit continues to expand in your maw throughout, and you suck on it every chance you get until it reaches its full one-and-a-half-inch size.\n\n");

		outputText("\"<i>Don't stop!  Yes, lick momma Izabella's clitty! Ja-yes! YES!</i>\" grunts the dark-skinned woman.  Her thick thighs scissor shut, locking you into your position with soft but vice-like pressure.  Rivulets of honeyed female cum trickle into your tongue with every slurp you give her plus-sized feminine organ.  It pulsates between your lips, and Isabella's legs pull tight with each trembling grunt or barely-articulated moan that escapes the cow-girl's lips.  She pants, \"<i>Such a good tongue-fucker... I – oooohhhhh... I think I shouldn't let you go, ja?  Keep you vhere you belong, right between Izabella's thighs – an oral tongue-pet.</i>\"\n\n");
	}
	else {
		outputText("Isabella moans out, \"<i>Ohhhh yeah... you're good at this.  Mmmm, keep licking, ");
		if(player.tallness < 60) outputText("little ");
		else if(player.tallness > 80) outputText("big ");
		outputText(player.mf("boy","girl") + ".</i>\"  As if you needed any encouragement.  Her taste is surprisingly sweet and fresh, with only a hint of the tang one would expect from such a powerfully built woman.  Her hand relaxes its grip on you as you tongue more aggressively, pressing your lips hard against her vulva and letting your tongue explore the crevices of her labia.  The cow-girl's budding clit continues to expand in your maw throughout, and you suck on it every chance you get until it reaches its full one-and-a-half-inch size.\n\n");

		outputText("\"<i>Don't stop!  Yes, lick momma Izabella's clitty! Yes! YES!</i>\" grunts the dark-skinned woman.  Her thick thighs scissor shut, locking you into your position with soft but vice-like pressure.  Rivulets of honeyed female cum trickle into your tongue with every slurp you give her plus-sized feminine organ.  It pulsates between your lips, and Isabella's legs pull tight with each trembling grunt or barely-articulated moan that escapes the cow-girl's lips.  She pants, \"<i>Such a good tongue-fucker... I – oooohhhhh... I think I shouldn't let you go, huh?  Keep you where you belong, right between Izabella's thighs – an oral tongue-pet.</i>\"\n\n");
	}

	if(player.cor < 33) outputText("You blush at her words and hope she's just talking dirty.");
	else if(player.cor < 66) outputText("You blush at her words and wonder what it would be like if she wasn't talking dirty.");
	else outputText("Despite knowing she's probably just getting into the moment, you see the appeal of the idea, but perhaps it would be hotter if the roles were reversed?");
	outputText("  Something splatters over your [armor] and runs down your back.  It's warm, body temperature, and wet.  Is she starting to leak milk just from a little cunnilingus?  Curious about just how much she's going to drip on you, you turn back to your task.  She's nearly as juicy down below as above, and you find yourself having to swallow mouthfuls of her fem-cum from time to time while you work her box over.\n\n");

	outputText("Isabella's heavily accented voice cries out in pleasure, jumping to near-painful octaves as her thighs and pussy begin spasming around you.  It isn't quite painful, but the disconcerting notion of being surrounded by heaving bronze oceans comes unbidden to your mind.  Incredibly thick milk splatters over your head and back, pouring out like water from a faucet.  Meanwhile, the scent of her need grows even stronger, making you dizzy while steady flows of girl-juice force you to swallow or drown.  So lost are you in the steady swallowing that you barely notice when the milk splatters trail off and the thighs disengage themselves from your ears.\n\n");

	outputText("The strong hand on your head gives you one last push forward, smearing your face with cow-girl cum before you're pulled back and hauled to your feet.  Isabella's eyes are lidded and tired.  Her top is completely soaked with thick, sweet-smelling cream, and you can even see small lakes of the stuff that can't escape her jiggling cleavage.  The cow-girl pulls you forward and mashes her lips into yours, kissing you roughly and wetly, her long, flat tongue sliding over your lips and face to clean her juices from it.  She lets you go, giggling as you stumble back with a strand of cummy-spit dangling between your mouths.\n\n");

	if(!isabellaAccent()) {
		outputText("Isabella sighs contentedly and says, \"<i>Thank you, [name].  You're a vonderful licker of the pussy.  Perhaps one of zese times I vill keep you for myself, ja?  I kid, I kid.</i>\"  She blushes heavily, as if realizing what she just said and turns to busy herself with cleaning up.  You get dressed, having some difficulty hiding the lust the act inspired in you.\n\n");
	}
	else {
		outputText("Isabella sighs contentedly and says, \"<i>Thank you, [name].  You're a wonderful pussy licker.  Perhaps one of these times I will keep you for myself, huh?  I kid, I kid.</i>\"  She blushes heavily, as if realizing what she just said and turns to busy herself with cleaning up.  You get dressed, having some difficulty hiding the lust the act inspired in you.\n\n");
	}
	//(+lots of lust)
	dynStats("lus", (10+player.lib/10), "scale", false);
	player.slimeFeed();
	if(player.hasCock()) {
		outputText("The cow-girl suddenly glances back at your crotch ");
		if(player.cocks[player.shortestCockIndex()].cockLength >= 9) outputText("before sighing wistfully.");
		else {
			outputText("before offering something else.  \"<i>Perhaps you could undress?  I ");
			if(isabellaAccent()) outputText("vould like to return ze favor.</i>\"");
			else outputText("would like to return the favor.</i>\"");
			doYesNo(izzyGivesSmallWangsFreeOral,explorer.done);
			return;
		}
	}
	isabellaFollowerScene.isabellaAffection(15); //thankful!
	if(!isabellaFollower() || !player.hasVagina() || player.biggestTitSize() < 1) {
		sceneHunter.print("Check failed: Isabella follower, vagina, tits.");
		endEncounter();
	}
	else {
		//(Change the ending of the \"Service Her\" option on an affectionate Isabella to the following; PC must NOT have a dick that suits her and MUST have a vagina)
		if(!isabellaAccent()) outputText("Seeing the ardent desire your sexual service has so visibly inspired in your body - in your slick, ready cunt and erect nipples - the cow-girl smiles slightly, and asks, \"<i>Perhaps you would like me to return the favor?  It seems only fair...</i>\"");
		else outputText("Seeing the ardent desire your sexual service has so visibly inspired in your body - in your slick, ready cunt and erect nipples - the cow-girl smiles slightly, and asks, \"<i>Perhaps you vould like me to return ze favor?  It seems only fair...</i>\"");
		//[Leave] [Get Cowlicked]
		simpleChoices("Get Licked", isabellaFollowerScene.receiveAllTheCowTOngues, "Leave", explorer.done, "", null, "", null, "", null);
	}
}

public function IsabellaWinsAndSpanks():void {
	clearOutput();
	//[Lose and get Spanked - Small]
	if(player.tallness <= 78) {
		if(player.HP < 1) outputText("You collapse at Isabella's feet, nearly senseless from all the damage you've taken.");
		else outputText("You collapse at Isabella's feet, masturbating pathetically as she glares down at you.");
		outputText("  A hand grabs hold of the back of your [armor] and lifts you up, placing you firmly over the cow-girl's fur-covered knee.  You can feel the transition from fur to skin underneath your belly, at the midpoint of her thigh.  ");
		if(player.lust >= player.maxOverLust()) outputText("You start trying to hump and grind, but the angry cow will have none of it.  ");
		outputText("SMACK!  A powerful impact slams into your [ass], making you gasp out in pain");
		if(player.hasPerk(PerkLib.Masochist)) outputText(" and pleasure");
		outputText(".  The next blow follows shortly after, equally hard but placed upon your other, yet-unbruised butt-cheek.");
		if(player.hasPerk(PerkLib.Masochist)) {
			outputText("  You gasp and ");
			if(player.hasCock()) outputText("squirt pre-cum ");
			else if(player.hasVagina()) outputText("slick your thighs ");
			else outputText("tremble ");
			outputText("with masochistic pleasure.");
		}
		outputText("\n\n");

		if (isabellaAccent()) outputText("Isabella grunts, \"<i>Look at you, acting like one of ze demons!  Now Izabella vill have to beat ze corruption out of you!</i>\"  You groan ");
		else outputText("Isabella grunts, \"<i>Look at you, acting like one of the demons!  Now I will have to beat the corruption out of you!</i>\"  You groan ");
		if(player.hasPerk(PerkLib.Masochist)) outputText("excitedly, wondering just how many more smacks you'll get to take");
		else outputText("piteously");
		outputText(" while Isabella cocks her elbow for another spank.  SLAP!  It hits hard enough to send ripples through every soft part of your body.  A bird takes flight somewhere in the distance");
		if(player.hasPerk(PerkLib.Masochist)) outputText(" while you swoon and moan, wiggling your rump");
		outputText(".  The cow-girl picks up the pace, scolding you in between each heavy-handed hit to your bottom.\n\n");

		outputText("\"<i>Bad <SMACK> " + player.mf("boy","girl") + "! <CRACK> Learn <SLAP> your <SWAT> lesson!</i>\"  Her sentence is punctuated with one bone-jarring blow that ");
		if(!player.hasPerk(PerkLib.Masochist)) outputText("draws a scream from your lips, pushing you past the bounds of consciousness.  Isabella hefts your limp form like a wet noodle and grasses sway behind you as you're carried off.");
		else {
			outputText("pushes you past your limit.");
			if(player.hasCock()) {
				outputText("  You cum like a cannon, blasting your thick seed all over Isabella's fuzzy knee");
				if(player.cumQ() >= 50) outputText(", moistening the fur");
				if(player.cumQ() >= 250) outputText(" and dripping down to her hooves");
				if(player.cumQ() >= 1000) outputText(" until you've created a puddle underneath her");
				outputText(".");
			}
			if(player.hasVagina()) {
				outputText("  Your " + vaginaDescript() + " quivers and ");
				if(player.wetness() < 5) outputText("drips");
				else outputText("squirts, splashing girl-cum over the cow's ankle and hoof");
				outputText(".");
			}
			outputText("  The feeling of climaxing from pain alone leaves you weak and exhausted.  Your eyes drift closed as Isabella hefts you and begins to carry you somewhere.");
		}
		outputText("\n\n");
		outputText("<b>Some time later...</b>\n");

		outputText("You crack your eyes to the sound of noisy swallowing.  The dark, tanned skin of Isabella's left breast completely fills your view, just as her quad-tipped nipple completely fills your mouth.  She's rubbing your cheek with a knuckle, and you're swallowing down her oh-so-sweet milk.  The warmth of her breast-milk fills your battered and bruised body, but from the gurgling of your belly, it's been filling you for some time already.  From how badly your [ass] is smarting, you're thankful she's cradling you the way she is.  The cow-girl coos,");
		if (isabellaAccent()) outputText("\"<i>Zere zere little one, just lie zere and drink.  Ve'll forget about all that earlier nastiness.  I'd feel bad leaving you out here all alone to be brutalized and raped by some monster!</i>\"\n\n ");
		else outputText("\"<i>There there little one, just lie there and drink.  we'll forget about all that earlier nastiness.  I'd feel bad leaving you out here all alone to be brutalized and raped by some monster!</i>\"\n\n ");

		outputText("In spite of your better judgment, you find yourself continuing to suckle, your arms reaching up to grab the swell of her mountainous orb and cuddle against it.  Isabella titters but even that turns into a pleasured gasp as you start suckling harder, pulling more and more milk from her heavy breast.  She shifts her grip on you slightly, but you lie there and continue to drink.  Your eyes slowly drift closed, though you stay awake for a time, sucking and tasting the milk as it grows ever sweeter.  Something begins squelching wetly nearby, but you're too intent on the cream-like taste in your maw and too tired to find out what it is.\n\n");

		outputText("You go back to sleep, your backside bruised and your belly full of Isabella's milk.\n\n");
		//(+4 sensitivity, -100 lust if masochist, -40 fatigue)
		player.refillHunger(30);
		fatigue(-40);
		dynStats("sen", 4);
		if(player.hasPerk(PerkLib.Masochist)) player.orgasm();
	}
	//[Lose And Get Spanked – Tall]
	else {
		if(player.HP < 1) outputText("You collapse at Isabella's feet, nearly senseless from all the damage you've taken.");
		else outputText("You collapse at Isabella's feet, masturbating pathetically as she glares down at you.");
		outputText("  A hand grabs hold of the back of your [armor] and props you up, ass in the air.  ");
		if(player.lust >= player.maxOverLust()) outputText("You start trying to masturbate yourself, but the angry cow will have none of it.  ");
		outputText("SMACK!  A powerful impact slams into your [ass], making you gasp out in pain");

		if(player.hasPerk(PerkLib.Masochist)) outputText(" and pleasure");
		outputText(".  The next blow follows shortly after, equally hard but placed upon your other, yet-unbruised butt-cheek.");
		if(player.hasPerk(PerkLib.Masochist)) {
			outputText("  You gasp and ");
			if(player.hasCock()) outputText("squirt pre-cum");
			else if(player.hasVagina()) outputText("slick your thighs");
			else outputText("tremble");
			outputText(" with masochistic pleasure.");
		}
		outputText("\n\n");

		if (isabellaAccent()) outputText("Isabella grunts, \"<i>Look at you, acting like one of ze demons!  Now Izabella vill have to beat ze corruption out of you!</i>\"  You groan ");
		else outputText("Isabella grunts, \"<i>Look at you, acting like one of thee demons!  Now I will have to beat the corruption out of you!</i>\"  You groan ");
		if(!player.hasPerk(PerkLib.Masochist)) outputText("piteously");
		else outputText("excitedly, wondering just how many more smacks you'll get to take");
		outputText(" while Isabella cocks her elbow for another spank.  SLAP!  It hits hard enough to send ripples through every soft part of your body and grind your chin into the dirt.  A bird takes flight somewhere in the distance");
		if(player.hasPerk(PerkLib.Masochist)) outputText(" while you swoon and moan, wiggling your rump");
		outputText(".  The cow-girl picks up the pace, scolding you in between each heavy-handed hit to your bottom.\n\n");

		outputText("\"<i>Bad <SMACK> " + player.mf("boy","girl") + "! <CRACK> Learn <SLAP> your <SWAT> lesson!</i>\"  Her sentence is punctuated with one bone-jarring blow that");
		if(player.hasPerk(PerkLib.Masochist)) outputText(" draws a scream from your lips, pushing you past the bounds of consciousness.  Isabella hefts your limp form heavily, dragging you through the dirt as your eyes close.");
		else {
			outputText(" pushes you past your limit.");
			if(player.hasCock()) {
				outputText("  You cum like a cannon, blasting your thick seed all over your neck and face");
				if(player.cumQ() > 100) outputText(", moistening your hair");
				if(player.cumQ() > 250) outputText(" and dripping down to the ground");
				if(player.cumQ() > 1000) outputText(" until you've created a puddle around yourself");
				outputText(".");
			}
			if(player.hasVagina()) {
				outputText("  Your " + vaginaDescript() + " quivers and ");
				if(player.wetness() < 5) outputText("drips");
				else outputText("squirts, splashing girl-cum over the dirt");
				outputText(".");
			}
			outputText("  The feeling of climaxing from pain alone leaves you weak and exhausted.  Your eyes drift closed as Isabella grabs you by the ankles, rolls you over, and starts dragging you through the grass.");
		}
		outputText("\n\n");
		outputText("<b>Some time later...</b>\n");
		outputText("You crack your eyes to the sound of noisy swallowing.  The dark, tanned skin of Isabella's left breast completely fills your view, just as her quad-tipped nipple completely fills your mouth.  She's rubbing your cheek with a knuckle, and you're swallowing down her oh-so-sweet milk.  The warmth of her breast-milk fills your battered and bruised body, but from the gurgling of your belly, it's been filling you for some time already.  From how badly your [ass] is smarting, she gave you quite the beating earlier, and you wish you weren't sitting on such rough ground.  The cow-girl coos,");
		if (isabellaAccent()) outputText("\"<i>Zere zere big " + player.mf("boy", "girl") + ", just lie zere and drink.  Ve'll forget about all that earlier nastiness.  I'd feel bad leaving you out here all alone – you'd probably turn into one of ze monsters!</i>\"\n\n");
		else outputText("\"<i>There there big " + player.mf("boy","girl") + ", just lie there and drink.  we'll forget about all that earlier nastiness.  I'd feel bad leaving you out here all alone – you'd probably turn into one of the monsters!</i>\"\n\n");

		outputText("In spite of your better judgment, you find yourself continuing to suckle, your arms reaching up to grab the swell of her mountainous orb and cuddle against it.  Isabella titters but even that turns into a pleasured gasp as you start suckling harder, pulling more and more milk from her heavy breast.  She shifts her grip on you slightly, but you lie there and continue to drink.  Your eyes slowly drift closed, though you stay awake for a time, sucking and tasting the milk as it grows ever sweeter.  Something begins squelching wetly nearby, but you're too intent on the cream-like taste in your maw and too tired to find out what it is.\n\n");

		outputText("You go back to sleep, your backside bruised and your belly full of Isabella's milk.");
		//(+4 sensitivity, -100 lust if masochist, -40 fatigue)
        //she doesn't like you
		player.refillHunger(30);
		fatigue(-40);
		dynStats("sen", 4);
		if(player.hasPerk(PerkLib.Masochist)) player.orgasm();
	}
	isabellaFollowerScene.isabellaAffection(4); //not like you're redeemed, but she had her fun
	flags[kFLAGS.ISABELLA_ANGRY_AT_PC_COUNTER] = 0; //She's already nice to you.
	if(player.hasCock() && player.shortestCockLength() < 9)
		doNext(IsabellaPostSpankFeedSex);
	else sceneHunter.print("Check failed: you need a short cock!");
	cleanupAfterCombat();
}

//[Isabella rapes you with her ass]
public function isabellaRapesYouWithHerAss(x:int):void {

	if(player.HP < 1) outputText("You collapse at Isabella's feet, nearly senseless from all the damage you've taken.");
	else outputText("You collapse at Isabella's feet, masturbating pathetically as she glares down at you.");
	outputText("  The cow-girl plants a hoof on your chest, pinning you into the dusty sod of her camp while she looks you up and down.  The victorious redhead leers at your groin while she begins to tear off your [armor].  It doesn't take her more than a few seconds to expose your [cocks].");
	if(player.lust >= player.maxOverLust())
	{
		outputText("  Your twitching hardness brings a smile to Isabella's face as she coos, \"");
		if(isabellaAccent()) outputText("<i>Oooh, so eager to be taught a lesson, ja?  Very vell, Izabella vill give you your punishment!</i>\"\n\n");
		else outputText("<i>Oooh, so eager to be taught a lesson, huh?  Very vell, I'll give you your punishment!</i>\"\n\n");
	}
	else
	{
		outputText("  Her bronzed skin caresses your flesh, quickly teasing it to full hardness.  A knowing, almost cruel smile grows on Isabella's face as she asks, \"<i>");
		if(isabellaAccent()) outputText("Already you vant your lesson, ja?  Very vell, Izabella can punish the naughty little [boy].</i>\"\n\n");
		else outputText("Already want your lesson, huh?  Very vell, I can punish you, you naughty little [boy].</i>\"\n\n");
	}

	outputText("What's she going to do with you?  She seemed so mad earlier, but this... this just sounds like you're about to get laid.  The cow-girl steps over you, her olive skirt rustling like the nearby plains grasses, barely concealing the treasures it conceals from your sight while she positions herself above your groin.  With her hips swiveling slightly, the busty redhead flexes her thick thighs and lowers herself down.  Each second of waiting is agonizing, and the feel of her sweat-slicked bubble-butt brushing your " + player.cockHead(x) + " is maddening.");
	if(player.cockTotal() > 1) {
		if(player.cockTotal() > 2)
		{
			outputText("  The bovine bitch reaches down to swat at some of your " + Appearance.cockNoun(CockTypesEnum.HUMAN) + "s, pushing them out of the way.  \"<i>So gross.  Why ");
			if(isabellaAccent()) outputText("vould you vant so many penises?</i>\"");
			else outputText("would you want so many penises?</i>\"");
		}
		else
		{
			outputText("  The bovine bitch reaches down to stroke your " + cockDescript(x) + ".  \"<i>So ready, ");
			if(isabellaAccent()) outputText("ja?  Vhy are you so eager to be punished?</i>\"");
			else outputText("huh?  Why are you so eager to be punished?</i>\"");
		}
	}
	outputText("\n\n");

	outputText("Isabella drops an inch lower, mashing your " + player.cockHead(x) + " against the tight ring of her pucker.  She grinds and flexes, squeezing her butt-cheeks to surround your member in a sweat-slickened vice.  You moan out loud and reach up to squeeze a handful of bronzed heaven, but the thick-thighed victor is having none of it.  One hard slap effectively rings your bell and nearly dislocates your jaw.  Isabella scolds, \"<i>");
	if(isabellaAccent()) outputText("Nein!  You are being punished!");
	else outputText("No! You're being punished!");
	outputText("</i>\"  You drop your hand and groan miserably, leaking pre over the slutty cow-girl's asshole while she continues to deny you penetration.\n\n");

	outputText("What is she doing!?  Her ass is just squeezing and bouncing along your shaft, teasing you with thoughts of penetration while her tight, pre-glazed sphincter stays closed to your " + cockDescript(x) + ".  The cow abruptly changes the tempo, beginning to alternate each flex of her feminine ass-cheeks, using them to caress each side of your " + cockDescript(x) + " with alternating strokes, bending and flexing it slightly from the ever-changing pressure. It feels good, great even, but it's not enough – not enough to make you cum.  Isabella laughs at your pained, hungry expression as she titters, \"<i>Are you sorry for being a naughty, evil [boy]?</i>\"\n\n");

	outputText("It's not fair!  You cry out plaintively, asking her just what she wants you to do, but Isabella looks more disappointed than ever.  \"<i>Isn't it obvious?</i>\" she questions, \"<i>");
	if(isabellaAccent()) outputText("I vant you to apologize for being so wicked and nasty from the bottom of your heart.  Until you do, I'll keep squeezing and rubbing with mein heiny!");
	else outputText("I want you to apologize for being so wicked and nasty - from the bottom of your heart! Until you do, I'll keep squeezing and rubbing!");
	outputText("</i>\"  You close your eyes and try to focus on the limited pleasure she's giving you – maybe you can get off without having to apologize?  The cow-girl will have none of it, and each time you feel the telltale warmth of an approaching orgasm");
	if(player.hasBalls()) outputText(" or the tightening of your " + sackDescript() + " as it pulls your "+ ballsDescriptLight());
	outputText(", she eases up, denying you your sloppy prize.  You try to earn more friction with subtle lifts of your hips, but that gets you another ear-ringing slap.\n\n");

	outputText("There's no choice.  You're getting so hard it hurts, and Isabella is a relentless tease.  Whenever you close your eyes, she squirts your face with milk, and by the time you blink her cream from your eyes, she's pulled her gauzy top back into place.  Still, you can see the outline of her quad-tipped areola through the milk-wet fabric, and it only enhances the flow of blood to your already painfully-erect prick.  There's no way around it.  You swallow your pride, trying to ignore the teardrops running from your eyes, and beg as earnestly as you can, \"<i>Okay okay, I'm sorry!  I'll be good. I promise.  Just let me cum!  It hurrrrts!</i>\"\n\n");

	outputText("Isabella looks thoughtful, but she shakes her head with disdain.  \"<i>");
	if(isabellaAccent()) outputText("No, zat is not sorrow.  You are sorry you can't cum, not sorry for being such a beast.  You must convince me!");
	else outputText("No, that's not sorrow. You're sorry that you can't cum, not for being such a beast.");
	outputText("</i>\" she commands.  You stick out your lower lip and look up pathetically, determined to earn your orgasm from the cruel cow.  You whine, \"<i>Please Isabella, I've been a very bad [boy]!  My naughty");
	if(player.cockArea(x) < 38) outputText(" little");
	else outputText(", nasty");
	outputText(" cock is so hard and swollen and I promise to be good for you if you just let me cum.  Please! I'll drink your milk and lick your cunt whenever you want.  I'll do anything!</i>\"\n\n");

	outputText("The cow-girl grins like a cat with a mouthful of cream, though in this case the 'cat' makes plenty of her own.  She coos, \"<i>Mmmm, that's a good [boy], and I like to give my good [boy]s lots of treats.  Are you ready for momma Izabella to make you feel so good?</i>\"  You nod with enough enthusiasm to strain your neck, getting a cute giggle from the redhead.  ");
	//(FORK – too big or small enough)
	//[GOOD FIT]
	if(player.cockArea(x) < 38) {
		outputText("She slides her plump ass back down, arching her back to press your " + player.cockHead(x) + " firmly against her tight, pre-moistened anus.  The cow-girl relaxes slowly, letting her muscles dilate to allow your member inside. The tight ring of muscle slides over your tip, clenching just under the head for a moment before the tension oozes back out of her muscles.  Her large, rounded ass-cheeks flex involuntarily as inch after inch of your " + cockDescript(x) + " is devoured by her anal passage.  The process is excruciating, but eventually the redhead is pressing her plush bottom against your groin");
		if(player.cockTotal() > 1) outputText(", smushing against your other dick");
		if(player.cockTotal() > 2) outputText("s");
		outputText(".\n\n");

		outputText("After a brief period of accommodation, Isabella begins to rock up and down, panting and grunting as your " + cockDescript(x) + " coats her inner walls with drippy pre-cum.  The rounded, bronzed cow-butt slaps against you with every lewd, cock-slurping butt-fuck.  You groan, delirious from the crushing tightness of the muscular cow-woman's back-door and the torturous foreplay.  For her part, the bovine broad is busy licking her lips and tugging her nipples, splashing you with a constant downpour of mother's milk that ebbs and flows in time with her bouncing butt.\n\n");

		outputText("You can't hold back – not after all that teasing!  The tightness in your loins is palpable, surging to newer, greater heights with each passing second.  ");
		if(player.hasBalls()) outputText("Involuntary muscles contract, tugging your " + sackDescript() + " up against your crotch while your [balls] visibly contract, loading your body full of liquid lust that's about to explode.");
		else outputText("Involuntary muscles contract, clenching inside you as your prostate loads your urethra with liquid lust that's about to explode.");
		outputText("  In one violent, cock-swelling twitch, you blast the first thick ropes of seed into the cow-girl's waiting hole.  Her tail, displaying a surprising amount of control, curls around your ");
		if(!player.hasSheath()) outputText("base");
		else outputText("sheath");
		outputText(", squeezing it affectionately as you pump out the next dollop of love-cream.  You grunt, moan, and sigh as her body's tight orifice milks your cum from you.");
		if(player.cumQ() >= 1000) {
			outputText("  It goes on for some time, even making Isabella grunt in fluid-filled discomfort");
			if(player.cumQ() >= 1500) outputText(", but your " + cockDescript(x) + " won't let up.  She cries and moans, jism pouring out around your shaft");
			if(player.cumQ() >= 2500) outputText(", yet you manage to keep going, drooling thick spunk until even the ground is soaked with it");
		}
		outputText(".");
		if(player.cockTotal() > 1) {
			outputText("Meanwhile, your chest is glazed by the poor, pinned prick");
			if(player.cockTotal() > 2) outputText("s");
			outputText(" trapped under the cow-cunt's sweaty body.");
		}
		outputText("\n\n");

		outputText("Isabella sighs, panting lightly from the effort as she pulls off, dripping gobs of goopey spooge all over.  She smiles as she watches the tension drain from your face and says, \"<i>Such a good [boy] to let it all out.  All that nasty, vile stuff just pouring out of your body for me... yes, you are my good boy.</i>\"  The cow-girl kisses you full on the lips, slipping her wide, flat tongue through your own.  You sigh, but she breaks it and stretches languidly.  Overcome by exhaustion, you slip into a restful slumber, interrupted only by the feel of your body swaying as it's moved.");
	}
	//[TOOBIG]
	else {
		outputText("She slides her plump ass all the way down to your ");
		if(!player.hasSheath()) outputText("base");
		else outputText("sheath");
		outputText(", getting a nice low moan to slip from your lips.  Then she flexes her thighs and pulls up, dragging the dusky, sweaty butt-cheeks back up your length, squeezing her muscles to tighten and loosen the grip of her cheek-fucking. Up and down she goes, clenching and bouncing her plush bottom for your " + cockDescript(x) + ".");
		if(player.cockTotal() > 1) {
			if(player.cockTotal()) outputText("Even though they're being ignored, each time her cheeks crush against your other cocks, they squeeze out a few spurts of pre-cum.");
			else outputText("Even though they're being ignored, each time her cheeks crush against your other cock, it squeezes out a spurt of pre-cum.");
		}
		outputText("\n\n");

		outputText("After so much teasing and torture, you cum brutally hard.  ");
		if(player.hasBalls()) outputText("Your " + sackDescript() + " pulls tight against your body, each of your [balls] quivering and pushing its load through you.");
		else outputText("Your body seems to pull tight, like a violin string, and you feel your organs quivering and working to push your load through you.");
		outputText("  Warm pressure builds higher and higher, and then at once you're shooting, spraying ropes of jism a half-dozen feet into the air.  Your urethra bulges, and you spurt out the next batch to splatter on Isabella's back.  Some of it lands on her black leather corset, glazing it with an off-white sheen.");
		if(player.cockTotal() > 1) {
			outputText("  Semen sprays onto your chest, fired by your forgotten extra cock");
			if(player.cockTotal() > 2) outputText("s");
			outputText(", but it's weaker, almost an afterthought.  ");
		}
		outputText("You keep squirting until your body is completely empty, leaving your " + cockDescript(x) + " to twitch and clench, trying to unload phantom seed.\n\n");

		outputText("You uncross your eyes and look at your handy-work. Isabella's clothes are smeared with a thick layer of slime.  It drips down her bronzed butt and oozes over your ");
		if(player.balls == 0) outputText("crotch");
		else outputText("balls");
		outputText(", pooling around your [legs] on the ground.");
		if(player.cumQ() >= 1000) outputText("  Ropes of it drip from Isabella's crimson locks, plastering her hair to her neck and dripping onto her shirt.  All around you the dirt has turned to a slimy, soupy mud, nearly white in color from your copious leavings.");
		if(player.cumQ() >= 2000) outputText("  The spooge completely soaks you both, surprising even you with its volume and quantity.");
		outputText("\n\n");

		outputText("Isabella sighs, panting lightly from the effort as she watches the tension drain from your face.  \"<i>Such a good [boy] to let it all out.  All that nasty, vile stuff just pouring out of your body for me... yes, you are my good boy.</i>\"  The cow-girl kisses you full on the lips, slipping her wide, flat tongue through your own.  You sigh, but she breaks it and stretches languidly.  Overcome by exhaustion, you slip into a restful slumber, interrupted only by the feel of your body swaying as it's moved.");
	}
	isabellaFollowerScene.isabellaAffection(6); //not like you're redeemed, but she has her fun
	flags[kFLAGS.ISABELLA_ANGRY_AT_PC_COUNTER] = 0; //She's already nice to you.
	player.sexReward("vaginalFluids", "Dick");
	dynStats("sen", 2);
	cleanupAfterCombat();
}

//[OPTIONAL GET RAPED AFTER SPANKING/FEEDING]
public function IsabellaPostSpankFeedSex():void {
	var x:Number = player.smallestCockIndex();
	clearOutput();
	outputText("<b>Squish... squish... squish...</b>\n");
	outputText("<i>Waaa?</i>  You groan, cracking your eyes as something rouses you from your slumber.  Something's slapping you, and you're so warm and WET.  Something else is off – you feel good, very very good.  You try to sit up, but sweat-soaked flesh slams into your gut, leveling you while simultaneously knocking the wind from your lungs.  Your eyes finally open wide from the sudden onset of pressure and pain, revealing the source of your disorientation even as a jolt of lust travels to your soaked groin.\n\n");

	outputText("Sweat beads on naked, milk-swollen melons while they bounce and squirt above you, occasionally blocking your view of everything but the four milk-dripping nipple-tips.  Attached to the glorious orbs is a delirious-looking Isabella, tongue hanging down past her chin as she grunts and rides you with you a far-away look in her eyes.  Her pussy is completely exposed; hairless, cum-slicked lips, puffy as they slide over your " + cockDescript(x) + ", devouring it like a snake engulfing its prey.  The teardrop-shaped tuft of red hair above her prominent button is equally soaked with white-tinged love-mess, making it quite clear that you've already gotten off once.\n\n");

	outputText("Isabella's eyes are tiny, insane pin-pricks that focus on you as she realizes you're awake.  She moans,");
	if (isabellaAccent()) outputText(" \"<i>Das is good [boy]!  Don't move!  Iz impolite to interrupt your elder's pleasure, and your tiny cock is so small and unique.  You vill lie there until momma has had her fill, ja?</i>\" To emphasize her point she puts a hand ");
	else outputText(" \"<i>There's a good [boy]!  Don't move!  Its impolite to interrupt your elder's pleasure, and your tiny cock is so small and unique.  You will lie there until momma has had her fill, yes?</i>\" To emphasize her point she puts a hand ");
	if(player.biggestTitSize() < 1) outputText("on your chest");
	else outputText("in between your " + allBreastsDescript());
	outputText(", pushing your torso so hard it sinks an inch or two into mud that reeks of Isabella's sex-juices.  You lie there, immobilized and defeated while you're forcibly raped, used like a small, disposable dildo.\n\n");

	outputText("The cow-girl lets some of the pressure off in order to tweak one of your " + nippleDescript(0) + "s, but as you gasp, her tongue is forced into your mouth, smothering your ");
	if(player.tongue.type == Tongue.HUMAN) outputText("smaller");
	else outputText("longer");
	outputText(" one with the slippery smoothness of her cow-like organ.  It slides over the top, curls around squeezing, and then it's underneath yours, beckoning you to venture past Isabella's naturally darker lips.  Her fingers find her way into your hair, pulling on it to keep you exactly where she wants you, like a dog on a leash.  You groan helplessly into her mouth, your voice melding with her frenzied moans as she splatters mud, milk, and girl-cum from each thigh-jiggling impact.\n\n");

	outputText("It feels so good, so very good, but you struggle with the pleasure.  It SHOULDN'T feel this good to be held down by and raped until you're sinking into sex-scented mud, yet your " + cockDescript(x) + " is twitching inside Isabella's muscular folds, growing so hard you feel like a nail being driven through butter.  The cow-girl's milk-fountains don't help, soaking your belly and " + chestDesc() + " with sweet, thickening cream and adding more whorls of white to the dirty slurry.  Isabella's back arches and she screams,");
	if (isabellaAccent()) outputText("\"<i>MooooOOOOOooooooh jaaaaaaaaaaa!</i>\"");
	else outputText("\"<i>MooooOOOOOooooooh yeeeeeeesssss!</i>\"");
	outputText(" Thick waves of white burst from her blushing milk - spouts, rolling over your body.  A few droplets even land in your recently vacated mouth to remind you of a chilled treat your parents sometimes made during the spring thaw, while ice was still in the river.\n\n");

	outputText("Her pussy tightens, clamping down and feeling smaller and smaller.  It's inhuman, squeezing more than a clenched fist - only this grip is made of syrupy-slipperiness and velvet cushions.  You can't resist the pleasure any longer, and you arch your back, digging yourself deeper into the mud in order to push your " + cockDescript(x) + " a tiny bit further into Isabella's spasming embrace.  Spooge boils up from your [balls], ");
	if(player.cumQ() < 50) outputText("spurting into Isabella's hungry, constricting snatch.");
	else if(player.cumQ() < 250) outputText("spurting into Isabella's suddenly-tight cunny with such thick streams that drops of it run from her lips.");
	else if(player.cumQ() < 1000) outputText("bursting into Isabella's constricting cunny and soaking every inch of her passage with your copious spooge.");
	else if(player.cumQ() < 2000) outputText("bursting into Isabella's constricting cunt, filling her womb, and leaving her belly with a little bit of a spunk-paunch.");
	else outputText("exploding into Isabella's constricting cunt in huge waves.  You feel her passage fill around you, then her womb, and then the next pump bulges her belly, giving her a spunk-paunch.  She moans as each successive deposit of seed fills her until her belly is pregnant with spooge, and her nether-lips are glazed white and dripping.");
	if(player.cumQ() >= 10000) outputText("So much leaks out that the mud lightens and thickens, taking on a cum-like viscosity.");
	outputText("\n\n");

	outputText("Once you've emptied the last of your submission into Isabella, she rolls off of you, panting heavily.");
	if (isabellaAccent()) outputText("\"<i>Das vas a very good [boy]!  I hope I taught you some manners.  Maybe come visit me some time, but be polite for me or I'll have to give you another spanking!</i>\"");
	else outputText("\"<i>You're a very good [boy]! I hope I taught you some manners. Maybe you should come and visit me some time, but be polite for me or I'll have to give you another spanking!</i>\"");
	outputText(" She climbs up on woozy legs and walks off, leaving you to doze in the defiled well of earth like a discarded tissue.\n\n");
	isabellaFollowerScene.isabellaAffection(4); //some more for small ones
	player.sexReward("saliva", "Dick");
}

//LOSS
public function isabellaDefeats():void {
	if(monster.statusEffectv1(StatusEffects.Sparring) <= 1) {
		sceneHunter.selectLossMenu([
				[0, "Fuck", curry(sceneHunter.callFitNofit, isabellaRapesYouWithHerAss, 38), "Req. a cock.", player.hasCock()],
				[1, "Spanking", IsabellaWinsAndSpanks],
			],
			"Seems like the cow-girl is going to teach you a lesson.. how exactly?\n\n"
		);
	}
	else {
		cleanupAfterCombat();
	}
}

//[VICTORY!]
public function defeatIsabella():void {
	clearOutput();
	if (flags[kFLAGS.SPARRABLE_NPCS_TRAINING] == 2 && flags[kFLAGS.ISABELLA_FOLLOWER_ACCEPTED] == 1) {
		if (flags[kFLAGS.ISABELLA_DEFEATS_COUNTER] >= 1) flags[kFLAGS.ISABELLA_DEFEATS_COUNTER]++;
		else flags[kFLAGS.ISABELLA_DEFEATS_COUNTER] = 1;
		if (flags[kFLAGS.ISABELLA_LVL_UP] < 16 &&  flags[kFLAGS.ISABELLA_DEFEATS_COUNTER] >= flags[kFLAGS.ISABELLA_LVL_UP] + 6) {
			var vAdd:int = player.statusEffectv1(StatusEffects.TrainingNPCsTimersReduction) * flags[kFLAGS.ISABELLA_DEFEATS_COUNTER];
			if (player.hasStatusEffect(StatusEffects.CampSparingNpcsTimers1)) player.addStatusValue(StatusEffects.CampSparingNpcsTimers1, 2, vAdd);
			else player.createStatusEffect(StatusEffects.CampSparingNpcsTimers1, 0, vAdd, 0, 0);
			flags[kFLAGS.ISABELLA_DEFEATS_COUNTER] = 0;
			++flags[kFLAGS.ISABELLA_LVL_UP];
		}
	}
	if(monster.statusEffectv1(StatusEffects.Sparring) == 2) {
		outputText("You give the ");
		if(monster.HP <= monster.minHP()) outputText("damage-dazed");
		else outputText("arousal-addled");
		outputText(" cow-girl a push, and she immediately slumps down, defeated.  Since this was just a light-hearted sparring match, you help her up and back to camp, where she can ");
		if(monster.HP <= monster.minHP()) outputText("recuperate.");
		else outputText("take care of her needs (or be taken care of).");
		cleanupAfterCombat();
		return;
	}
	outputText("You push the ");
	if(monster.HP <= monster.minHP()) outputText("damage-dazed");
	else outputText("arousal-addled");
	outputText(" cow-bitch, feeling your hand sink into one of her pillowy tits for a half-second before she tips and falls squarely onto her wide ass.  Isabella ");
	if(monster.HP <= monster.minHP()) outputText("gr");
	else outputText("m");
	outputText("oans, \"<i>");
	if (monster.HP < 1) {
		if (isabellaAccent()) outputText("Vhy must you be so like them?  You act like a demon!  Stay away from mein milk!");
		else outputText("Why must you be so like them? You act just like a demon! Stay away from my milk!");

	} else {
		if (isabellaAccent()) outputText("I didn't vant this!  ...but, please, I have so much milk... drink my moOOOO-ilk!");
		else outputText("I didn't want this! Please, I have so much milk... dink my moOOO-ilk!");
	}
	outputText("</i>\"  ");
	if(monster.HP <= monster.minHP()) outputText("She acts so haughty, but she can't hide how her nipples are tenting her sheer top.");
	else outputText("She acts like all she needs is a milking, but you can smell the dampness she's trickling from 'down under'.");
	if (player.lust < 33) {
		outputText("\n\nSadly, you're not aroused anough to fuck her.")
		cleanupAfterCombat();
		return;
	}
	menu();
	addButton(0, "Lactation69", victoryLactation69)
		.disableIf(player.biggestLactation() < 1, "You don't lactate enough!");
	addButton(1, "Buttsex", PCVictoryOnIsabellaButtsex)
		.disableIf(player.cockThatFits(monster.analCapacity()) < 0, "Req. a cock fitting "+monster.analCapacity()+" capacity.");
	addButton(2, "Sixty-Nine", curry(sceneHunter.selectGender,
		curry(sceneHunter.callFitNofit, victoryAgainstIzzzzzySixtyNine, 38),
		curry(victoryAgainstIzzzzzySixtyNine, -1)
	)).disableIf(player.isGenderless(), "Req. a gender.");
	addButton(3, "Vaginal", vaginalProdNPokeIsabella)
		.disableIf(player.cockThatFits(monster.vaginalCapacity()) < 0, "Req. a cock fitting "+monster.vaginalCapacity()+" capacity.");
	addButton(4, "Big Titfuck", tooBigVictoryTittyFuckingFuntimesWithMilk)
		.disableIf(!player.hasCock() || player.biggestCockArea() < 70, "Req. a cock with area larger than 70.");
	addButton(5, "Small Titfuck", tinyVictoryTittyFuckingFuntimesWithMilk)
		.disableIf(!player.hasCock() || player.shortestCockLength() >= 9, "Req. a cock shorter than 9 inches.");
	addButton(14, "Leave", cleanupAfterCombat);
}
//[LACTATION 69]
public function victoryLactation69():void {
	clearOutput();
	outputText("Well, now that she's mentioned milk, your [allbreasts] do feel a little full, swollen with the weight of your own lactic cargo.  Even your " + nippleDescript(0) + "s feel bloated and ready to be suckled.  With a devilish grin, you pace around the prone, bovine belle and taunt her, suggesting quite lewdly how you'll drain her tits dry while forcing her to guzzle your own pearly liquid.  Her eyes go wide, first with shock, then with increasing lust.  The cow-girl's features soften into submissive acceptance when you stop at her head and undo the bindings of your [armor].\n\n");

	outputText("Isabella mumbles, ");
	if (isabellaAccent()) outputText("\"<i>Moo-milk?  Vell, it does sound kind of ni...</i>\"");
	else outputText("\"<i>Moo-milk? Well it does sound kind of ni...</i>\"");
	outputText(" A bovine tongue slides over her dusky lips, cutting off her rambles while it whets her lips for her coming feast.  This cow - cunt feigns modesty, but she's every bit the hungry slut underneath – just look at her spit-lubed lips, heaving, barely-concealed chest, and needy, begging eyes.  She wants this.  You pull at her top, but it stretches rather than rips.  Inspired by the flexible fabric, you pull it down, loosening her corset as you bunch her shirt up underneath the swell of Isabella's plush tits.\n\n");

	outputText("Unbidden, drops of milk begin to form at the tips of your " + nippleDescript(0) + "s, and you take this for a sign that your body is ready to teach Isabella her place.  Leaning down, you let your ");
	if(player.breastRows.length > 1) outputText("top row of ");
	outputText(breastDescript(0) + " hang around Isabella's head, but her horns poke and prod at your tits uncomfortably.  You arch your back a little and reposition yourself so that just one of your rounded melons is pressing down on the bovine broad's face, the nipple leaking milk down her cheek.  Her well-rounded tit is an inch or two below you, smelling pleasantly of sweetness and cream.\n\n");

	outputText("Isabella latches on almost immediately, suckling hard to get your milk flowing and drinking deeply.  One of her hands squeezes her bronzed mammary to push her areola higher, right into the surprised 'o' of your mouth.  It tastes warm and sweet, just like the milk that starts to squirt from the four nipple-tips into your throat.  You swallow it easily, instinctively even, and you start to suck after each swallow, refilling your mouth with larger and larger volumes of creamy cow-milk.  The busty redhead's lips suck and suck, only pausing for her tongue to slurp the milk from your " + nippleDescript(0) + ".\n\n");

	outputText("You feel like you've lost control of the situation, or at least given some of it up in exchange for shared lactic bliss. Oh well, there're worse things than having your mouth wrapped around bloated nipples while a hungry milk-slut drains that aching pressure from your swollen mammary.  You can feel the ebb and flow as it escapes your " + nippleDescript(0) + ", slowly replacing bottled-up discomfort with a sensual, almost erotic release.  Heavy eyelids flutter closed as you fixate completely on your mouth and chest, sucking and squirting in a perfect, milky rhythm with your 'victim'.\n\n");

	outputText("The air grows thick with the aroma of cream and lust.  Isabella squirms underneath you, the human parts of her thighs getting slick and slippery with sweat and girl-cum.  She squirms, digging her free hand up under the hem of her fluid-darkened skirt to seek release.");
	outputText("  You follow her lead, reaching back to ");
	if(player.hasCock()) outputText("squeeze " + sMultiCockDesc() + " gently, feeling the heavy, turgid mass pulsating with each beat of your heart.");
	else if(player.hasVagina()) outputText("rub your fingers over the puffy lips of your pussy, feeling your vulva spread to give the juice-lubed digits access.");
	else outputText("rub your fingers up your taint to your clenched pucker, circling the clenching asshole with a digit before you bury it inside.");
	outputText("\n\n");

	outputText("The increasingly sugary taste of Isabella's milk cuts off just as your chest is emptied, and the two of you switch to the next tit simultaneously, synchronized by some unspoken cooperation.\n\n");

	outputText("With your bellies filling, the conflict that started it all seems like a distant dream that's washing away with each burst of sexual relief and swallow of pearlescent milk.  Isabella's moos of pleasure vibrate your " + nippleDescript(0) + ", adding to your own");
	if(player.breastRows.length > 1) outputText(", while your other " + breastDescript(1) + " plasters her crimson hair into her scalp");
	outputText(".  Her hips buck and writhe off the ground, the squelching of her masturbation filling the air just as her pumping digits fill her box.");
	if(player.hasVagina()) outputText("  Of course, you're pumping at your own quim nearly as hard, but the messy cow-girl's efforts still manage to drown you out.");
	else if(player.hasCock()) outputText("  Of course, you're pumping at " + sMultiCockDesc() + " just as hard, but the sounds of your fapping are easily drowned out by the enthusiastic cow-girl.");
	else outputText("  Of course, you're fingering your " + assholeDescript() + " just as hard, but that muscular hole barely makes a sound as you violate it.");
	outputText("  The cow-girl shudders from head to toe with her climax, the milk thickening into sweet-cream as she sprays it from all four of her nipple-tips onto your tongue.\n\n");

	outputText("After a few moments of guzzling Isabella's orgasmic cream, your own climax starts to build, radiating from your squirting " + nippleDescript(0) + " and ");
	if(player.hasCock()) outputText(multiCockDescriptLight());
	else if(player.hasVagina()) outputText(vaginaDescript());
	else outputText(assholeDescript());
	outputText(".  You arch your back, crushing the cow-girl's face with the swell of your jiggling breast while you drain the last of your milky reserves into her, using her as your personal breast-pump.");

	//(Cuntnips)
	if(player.hasFuckableNipples()) outputText("  Isabella thrusts her tongue at your " + nippleDescript(0) + ", burrowing it deep into the unusual passage to get at the last of your liquid bounty and inadvertently intensifying your pleasure.  Your arm gives out and you drop on top of her, burying her in tit while hers serve as your pillows.");
	//(Cock & Puss)
	if(player.gender == 3) {
		if(player.wetness() == 5) outputText("  The juices that splatter from your " + vaginaDescript() + " almost seems an afterthought, but when you cum, you cum <i>allll</i> over.");
		else if(player.wetness() > 3) outputText("  The juices that drip from your " + vaginaDescript() + " almost seems an afterthought, but when you cum, you cum all over.");
		else outputText("  The clenching of your " + vaginaDescript() + " almost seems an afterthought, but when you cum you cum all over.");
	}
	//(Cock)
	if(player.hasCock()) {
		outputText("  With a few more solid pumps " + sMultiCockDesc() + " goes rock hard");
		if(player.hasBalls()) outputText(", your [balls] pulling tight against your groin");
		outputText(".  Warmth spreads from your groin as ropes of spunk shoot and spray over the dirt, a few even hitting Isabella's head.  She doesn't give any sign of knowing or caring, so intent is she on your milk.");
		if(player.cumQ() >= 1000) outputText("  You squirt and drip for ages, making a nice big puddle around both of you.");
	}
	//(Puss only)
	if(player.gender == 2) {
		outputText("  The constant fingering of your " + vaginaDescript() + " accomplishes its goal, making your velvet tunnel clench vise-tight against the intruding digit.  ");
		if(player.wetness() >= 4) outputText("Juice squirts from your hole, splattering onto the dirt.");
		else if(player.wetness() >= 2) outputText("Girlcum drips from the hole, absorbing into the dirt.");
		else outputText("Girlcum soaks your lips, filling the air with female lust.");
		outputText("  Your " + clitDescript() + " pulses and jumps with each brush of your thumb, and you nearly lose yourself in the hedonistic self-pleasure.");
	}
	//(butt)
	if(player.gender == 0) outputText("  The constant fingering of your " + assholeDescript() + " finally comes to fruition, sending bolts of pleasure from your anal passage.  The star clenches tight around your digits, contracting involuntarily around the invader.");
	outputText("\n\n");

	outputText("Empty and sore-nippled, you roll sideways and lie with Isabella on the dirt");
	if(!isabellaFollower()) outputText(" of her camp");
	outputText(".  The two of you look each other over, licking the last of the milk from your lips and sharing a moment.  She speaks first, mouthing, ");
	if (isabellaAccent()) outputText("\"<i>Zat vas nice... a good way to cool down angry hearts.  Let's... do zis next time ve fight!</i>\"");
	else outputText("\"<i>That was nice... a good way to cool down angry hearts. Let's... do this next time we fight!</i>\"");
	outputText(" You nod as the blissed-out cow-girl closes her eyes, contented and cradling the slight paunch you've given her.  A moment later you've regained your strength, but you have trouble fitting back into your [armor] with all the milk in your system.");
	isabellaFollowerScene.isabellaAffection(12); //she's better
	//(slimefeed, -lust, +thickness & -tone?)
	player.slimeFeed();
	//You've now been milked, reset the timer for that
	player.addStatusValue(StatusEffects.Feeder,1,1);
	player.changeStatusValue(StatusEffects.Feeder,2,0);
	//Reset anger
	flags[kFLAGS.ISABELLA_ANGRY_AT_PC_COUNTER] = 0;
	player.sexReward("milk", "Lips");
	cleanupAfterCombat();
}
//[VICTORY BUTTSEX]
public function PCVictoryOnIsabellaButtsex():void {
	var x:Number = player.cockThatFits(monster.analCapacity());
	var y:Number = player.cockThatFits2(monster.vaginalCapacity());
	clearOutput();
	if (y < 0) sceneHunter.print("You could use another one!");
	outputText("Milk, huh?  No, that won't do.  You tell the ");
	if(monster.lust >= monster.maxOverLust()) outputText("horny ");
	outputText("cow-slut to roll over and get on all fours.  ");
	if(monster.HP <= monster.minHP()) outputText("She struggles to comply, heaving her hefty body until she's wobbling on all fours, nearly falling into the dirt.");
	else outputText("She struggles to comply, pulling her hands away from her erogenous zones as she wobbles onto shaky hands and knees.");
	outputText("  You circle her, eyeing her like a predator salivating over a raw steak.  She shivers, sending ripples of motion through her plump, sun-kissed backside and swinging melons.  Her skirt rides high, ruffled and pushed up on her back, but Isabella dares not lower it under your watchful gaze.\n\n");

	outputText("You shrug out of your [armor] and expose " + sMultiCockDesc() + " to the warm, breezy air");
	if(player.lust < 70) {
		outputText(", allowing ");
		if(player.cockTotal() == 1) outputText("it ");
		else outputText("them ");
		outputText("to harden precipitously.  The turgid flesh of " + sMultiCockDesc() + " grows harder and harder, egged on by the sight of Isabella's dark pucker and juicy, leaking cunt");
	}
	else {
		outputText(", the wind teasing over the hardness of your length");
		if(player.cockTotal() == 1) outputText(".  It seems");
		else outputText("s.  They seem");
		outputText(" to grow harder and harder, the tumescent flesh engorging beyond measure while you eye the sight of Isabella's dark pucker and juicy, leaking cunt");
	}
	outputText(".  Isabella looks back with a mixture of fear and primal lust.  She doesn't seem to realize she's begun to wiggle her hips back and forth, teasing you with the plump, sweat-soaked curves of ass and the snake-like motions of her tail.\n\n");

	outputText("Isabella moans");
	if(monster.HP <= monster.minHP()) outputText(", forgetting her wounds between the sight of your naked body and her lewd, compromised position");
	else outputText(" lustily, begging to be penetrated with her body while her voice tries to make love to your ears");
	if (isabellaAccent()) outputText(".  \"<i>Vould you... put it inside me?  Please, I'm so sorry I didn't let you ravish me.  Take me, violate me vith your spear of lust!</i>\"");
	else outputText(".  \"<i>Would you... put it inside me? Please, I'm so sorry I didn't let you ravish me. Take me, violate me with your spear of lust!</i>\"");
	outputText(" she pleads.  Her attempt to talk dirty is so bad it nearly makes you cringe.  She was better off moaning and mooing like a beast in heat, and perhaps it would be best to treat her like one.\n\n");

	outputText("You advance and grab her tail, yanking the bovine appendage back to pull those glorious ass-cheeks closer to your " + cockDescript(x) + ".  ");
	if(player.cockTotal() > 1) {
		outputText("It's probably the best suited to the task, out of your [cocks]");
		if(y >= 0) outputText(", and your " + cockDescript(y) + " may as well go into that sloppy cow-cooch");
		outputText(".  ");
	}
	outputText("Isabella's eyes widen with from the sudden pressure of your " + player.cockHead(x));
	if(y >= 0) outputText(" and other " + player.cockHead(y) + " pressing against her holes");
	else outputText(" pressing against her dark pucker");
	outputText(", and she voices a moo of discomfort when you slap her moist backside.  You ignore it and pull harder on her tail, forcing her anus to devour your entire " + cockDescript(x) + " in a single stroke");
	if(y>= 0) outputText(" while her pussy sheaths your other member in dick-melting warmth");
	outputText(".\n\n");

	outputText("The over-endowed redhead shudders underneath you, her muscles clamping involuntarily with such force that you're immobilized mid-thrust.  Somehow she holds you like that, squeezing with enough force that your [cockhead] feels like it could pop.  You slap her ass hard enough to leave a handprint on her plump posterior, the spreading shock pursing Isabella's lips just as it dilates her anal ring.  She grunts wordlessly, too far gone to give voice to her complaints.  You slam back into her sweltering embrace");
	if(y >= 0) outputText("s");
	outputText(" hard enough to make the clap echo off some distant landmark.\n\n");

	outputText("Milk audibly 'drip-drip-drip's in the dirt, disgorged by the cow's wobbling udders.  Isabella's loud grunts begin to change with each prick-sheathing thrust, adding a low whimper of lust to her voice until the cow-girl is letting out long moos of contented desire.  You let go of her tail and grab hold of her waist.  Fingers dig into the red lace of her corset with every pull, dragging the red-head's near-heifer-sized cheeks into your " + hipDescript() + ".  She still squeezes around your ");
	if(y >= 0) outputText("members");
	else outputText(cockDescript(x));
	outputText(" but not with the dick-crushing tension she exerted before.\n\n");

	outputText("You pull on her hair, twisting the short red tangles in your finger to arch her neck and hold her still.  Her pussy ");
	if(y>= 0) outputText("contracts around your " + cockDescript(y) + " and squeezes a flow of heated pussy-juice over the penis, cocooning it with enough warm heat and wetness to make you feel as if you're melting.");
	else outputText("spews out a few strands of girl-juice that cling to your [legs], hanging and stretching with every sticky slap against her body.");
	outputText("  The rising pitch and volume of Isabella's moo is the only warning you have, and even that doesn't prepare you for the force of her orgasm.  Her body convulses from hoof to crown, starting with her bronzed thighs, and then moving to her sweat-soaked ass-pillows.  Finally it spreads through her arms and swinging udders, unleashing a torrent of sweet-smelling breast-cream.\n\n");

	outputText("The twitching, squeezing spasms of the cow-girl's passage");
	if(y >= 0) outputText("s");
	outputText(" shoot fireworks of pleasure up your spine to burst in your brain.  You grunt and rut, pounding Isabella's pre-cum oozing hole");
	outputText(" and feeling the cum build up inside your [balls].");
	if(y < 0) outputText("  Though you could never impregnate such an orifice, your instinct to fill her tightness with male essence has taken over, and you won't be satisfied until her asshole is leaking your seed.");
	else outputText("  Though you know that at least half your load will be wasted, your instinct to fill her has taken over, and you won't be satisfied until every single one of the cow-cunt's vacancies are leaking sperm.");
	outputText("  Heat wells up from your [balls], signaling the time to teach the haughty broad a lesson, at last.\n\n");

	outputText("Isabella's short red hairs slip through your climax-weakened fingertips, but focused as you are in the feeling of orgasm boiling from your urethra, you don't care.  Jism erupts inside her, spouting from your dilated cum-slit into the cow-girl's deepest, darkest recesses.  ");
	if(y >= 0) outputText("Your " + cockDescript(y) + " emulates its brother, shooting ropes of semen into the cow-girl's drippy pussy.  ");
	outputText("Isabella's full-body orgasm had been winding down, but the feel of being packed with your spooge sets her off all over again.  Her arms give out and she lies down in a milky puddle of her own creation, squirting mud and cream from the edges of her now-pressurized tits.");
	if(player.cumQ() >= 750) {
		outputText("  You keep at it, packing her bottom");
		if(y >= 0) outputText(" and drippy puss");
		outputText(" with more spunk, enough to balloon her back-door and remove most of the sensation from your " + cockDescript(x) + ".");
		if(player.cumQ() < 2000) {
			outputText("  Her belly distends slightly by the time you finish, but her exhausted, half-crossed eyes don't seem to mind.");
		}
		else outputText("  White goo sprays out from her flooded backside, forced out by the pressure of your incessant jizz-jets.  By the time you finish, her belly looks pregnant with your goo, but her blissful, cross-eyed expression shows just how little she minds.");
	}
	outputText("\n\n");

	outputText("Spent at last, you give her rump a solid smack and draw back from her sloppy, smutted sheath");
	if(y >= 0) outputText("s");
	outputText(".  Isabella slumps down and closes her eyes, though her rump stays pointed up in the air, displaying the seed you left puddling in her rectum.  Amazingly, the milk she was leaking in the mud seems to have been absorbed already, leaving the earth dry and dusty once again.\n\n");

	outputText("You get dressed and set off, feeling quite proud of how you handled the haughty foreign bovine.");
	player.sexReward("Default", "Dick", true,false);
	cleanupAfterCombat();
}

//[Victory 69]
public function victoryAgainstIzzzzzySixtyNine(x:int):void {
	clearOutput();
	outputText("You aren't interested in her milk though.  You came for a different sort of relief, and Isabella should be thankful you plan to share it.  The confused, beaten cow watches you with wide, helpless eyes as you disrobe, dropping your [armor] heavily on some of her rugs.  Her skirt shouldn't pose a problem; a quick push has it bunched up around Isabella's waistline.  With the offending garment moved, you can get a good look at a sight you plan to get <b>intimately</b> familiar with for the next fifteen minutes or so.\n\n");

	outputText("Before you are the ");
	if(!player.hasStatusEffect(StatusEffects.Edryn)) outputText("plumpest, juiciest set of pussy lips you've ever had the chance to lick.");
	else outputText("plumpest, juiciest vulva you've seen on a pussy since you met Edryn.");
	outputText("  It doesn't surprise you that they glisten, or that her nethers are slowly parting to reveal her pinky-sized clit and moist canal, but what does surprise you is the sweet, pleasant scent the red-head's lips exude.  After watching the teasing display with such rapt attention, you finally notice the teardrop-shaped thatch of red pubes above her entrance.  It seems to match her blooming 'flower' perfectly, undulating with the cow-cunt's incessant, nervous squirming.\n\n");

	outputText("You twist sinuously, sliding your " + hipDescript() + " over Isabella until your groin is hovering over her mouth and your [legs] are brushing her ears.  She tentatively opens her mouth, spreading her dusky lips wide as her tongue licks them.  The cow-girl grabs hold of your [ass], knowing full well what's expected of her, and pulls up to ");
	if(x < 0) outputText("nuzzle your " + vaginaDescript(0) + ", smearing your vulva with her lips even she spreads the folds to access your " + clitDescript());
	else if(player.cockArea(x)) outputText("swallow your " + cockDescript(x) + " whole, plying her smooth, spit-covered tongue over every inch of it");
	else outputText("lick your " + cockDescript(x) + ", fondling it with her long, smooth tongue in ways that no human could");
	outputText(".\n\n");

	outputText("The bovine beauty pauses her attentions, blowing hot air on your genitals as she awaits reciprocation.  For someone who just lost a fight, she sure is full of herself.  You dive down on her muff, feeling the surprisingly soft hairs above her pubic mound tickling on your chin.  The velvet folds draw back like a curtain, and you lash your tongue over them, just barely sinking the tip into her channel to taste her.  She tastes as sweet as she smells, with only a hint of tang that clings to your tongue.  For now you avoid her swollen clit – this bitch is going to have to earn whatever pleasure that big bud is going to get.\n\n");

	//(VAGOOZLES)
	if(x < 0) {
		outputText("Isabella returns to her task with gusto, muff-diving deep and hard to plant her exquisitely long tongue far inside you.  Her lips circle your " + clitDescript() + ", ");
		if(player.clitLength >= 5) outputText("struggling with the cock-like appendage");
		else if(player.clitLength >= 2) outputText("suckling the large button with slow, measured inhalations");
		else outputText("devouring the tiny bud");
		outputText(" even as the smooth skin of her tongue inadvertently caresses it.  You writhe against her with your juices ");
		if(player.wetness() < 3) outputText("coating her tongue");
		else if(player.wetness() < 4) outputText("sloppily leaking everywhere");
		else outputText("squirting each time she hits a particularly sensitive spot");
		outputText(".  Curling into a tube-like shape, Isabella's tongue begins pistoning in and out of you, fucking you as hard as any cock while still maintaining the flexibility to arch inside and press every button you've got.  You tremble from her masterful technique, bombarded with hellish levels of sensation.");
	}
	//(WANGS - fits)
	else if(player.cockArea(x) < 38) {
		outputText("Isabella resumes her task with gusto, wrapping her lips around your ");
		if(player.hasSheath()) outputText("sheath");
		else outputText("base");
		outputText(" and suckling until her cheeks hollow from the vacuum.  Meanwhile, her tongue lashes around " + cockDescript(x) + ", slurping even as it curls around your manhood.  It circles it slowly, gradually building a tight, tongue-based cocoon that squeezes even as it slides around you, throwing off hellish amounts of pleasure.");
		if(player.cockTotal() > 1) {
			outputText("  She ignores your other dick");
			if(player.cockTotal() > 2) outputText("s as they smear her cheeks, focusing on this one, perfectly-matched specimen.");
			else outputText(" as it smears her cheeks, focusing on this one, perfectly-matched specimen.");
		}
	}
	//(WANGS – no fit)
	else {
		outputText("Isabella resumes her task with gusto, wrapping her tongue around the ");
		if(player.hasSheath()) outputText("sheath");
		else outputText("base");
		outputText(" numerous times before bobbing her head up and down.  She's using her tongue like some kind of onahole, and the warm, slippery pressure makes your " + cockDescript(x) + " want to melt with pleasure.  The cow-girl slides all the way to the tip");
		if(player.cocks[x].cockType == CockTypesEnum.HORSE) outputText(", getting stuck at the medial ring");
		else if(player.cocks[x].cockType == CockTypesEnum.DEMON) outputText(", slowed by all the nubs");
		else if(player.cocks[x].cockType == CockTypesEnum.CAT) outputText(", slowed by all the spines");
		else if(player.cocks[x].cockType == CockTypesEnum.TENTACLE) outputText(", stopping under the mushroom-like head");
		else if(player.cocks[x].cockType == CockTypesEnum.ANEMONE) outputText(", giggling from the 'stings' your anemone-like prick gave her");
        else if(player.hasKnot(x)) outputText(", struggling with the knot");
		else outputText(", rubbing her mouth against your urethral bulge");
		outputText(" before she plants a kiss on your opening.  She tenderly kisses the cum-slit, all the while keeping her tongue-sheath securely around your member.  You tremble from her masterful technique, bombarded with hellish levels of sensation.");
	}
	outputText("\n\n");

	outputText("With such talent working your groin, you're scared she might get you off first – who knows what sort of revenge her clever mind would concoct while you're weakened by orgasm!  You redouble your efforts, licking over her labia, suckling her clit, and pressing your entire face against her hard enough to feel her folds part around your nose.  ");
	if(player.hasMuzzle()) outputText("It gives you an idea, and you shift and close your mouth.  A moment later you plunge down, burying your muzzle deep inside the sloppy cunt.  It stretches pleasantly around you, and you feel moans vibrate through your crotch.  ");
	else outputText("Her clit bumps your nose, and you decide it's time to subdue Isabella once and for all.  You suck the bulb into your mouth and raise one hand.  Then, with a simultaneous blur of motion, you plunge your fist into her open gash and attack her clit with a frenzied series of licks.  You feel moans vibrate through your groin in response.  ");
	outputText("Thick, viscous cream fountains from under you, sliming your belly with the first few blasts before the fountains turn into milky fire-hoses.\n\n");

	//(Vagoo)
	if(x < 0) {
		outputText("Even as you exult in victory, the humming pleasure-squeals of Isabella's orgasm vibrate through her lips and tongue, straight up your " + clitDescript() + ".  Orgasm hits you hard enough to knock the strength from your arms, and you collapse on top of the cow-girl, reflexively grinding your " + hipDescript() + " into her face.  Your " + vaginaDescript() + " ripples and clenches, squeezing Isabella's tongue as if it could milk some kind of cum from it.  The mouthful of pussy you have doesn't stop you from giving voice to your climax, and as you ");
		if(player.wetness() < 5) outputText("squirt");
		else outputText("drip");
		outputText(" into Isabella's mouth, she's screaming into yours with equal intensity.  It takes some time for your sweaty bodies to stop shaking with pleasure.");
	}
	//(Dick Fitzwell)
	else if(player.cockArea(x) < 38) {
		outputText("Even as you exult in your victory, the humming pleasure-squeals from Isabella vibrate your entire " + cockDescript(x) + ".  The tongue-sleeve tremors and convulses, losing cohesion as you lose control.  Seed bubbles from your tip, slathering Isabella's tongue, throat, and cheeks with the stuff before she can gulp it down.  One long swallow later, she's devoured ");
		if(player.cumQ() >= 250) {
			outputText("it, but you're just warming up.  The next rope fills the cow-girl's mouth with cream, and the one after nearly chokes her.  She devours every salty drop");
			if(player.cumQ() >= 500) outputText(", but you keep cumming, pumping more and more spooge inside her oral cavity with every eruption");
			if(player.cumQ() >= 1000) outputText(".  She gives up after her belly fills and pulls back to let you blow the rest on her face");
			if(player.cumQ() >= 1500) outputText(".  Her tan visage is coated in a generous helping of spunk when you finish");
		}
		else outputText("your entire load");
		outputText(".");
	}
	//(Dick + No fit)
	else {
		outputText("Even as you exult in victory, the humming pleasure-squeals of Isabella's orgasm vibrate through her lips and tongue, spreading down your shaft.  The effect is profound and immediate, and even as Isabella loses control of her oral onahole, orgasm wracks your " + cockDescript(x) + ".  It trembles and pulsates a second before the first load bursts from the tip and splatters on Isabella's thin, white blouse.  The next doesn't fly as far, and drops on her neckline.  After that, you pour a few bursts onto her face.");
		if(player.cumQ() > 250) {
			outputText("  Far from finished, you dump enough spooge on her chest and head to glaze them both equally");
			if(player.cumQ() > 500) {
				if(player.cumQ() > 1000) outputText(", and somehow, your orgasm drags on, creating a lake of spunky mud for Isabella to lie in");
				else outputText(".  Her top clings to her, revealing every curve of her chest and the many tips of her exotic nipples");
			}
			outputText(".");
		}
	}
	//(Extra dicks? - no new pg)
	if(player.cockTotal() > 1) {
		outputText("  Throughout it all you feel like a one-man bukkake show, spurting jism from your [cocks] over the cumming cow-girl.");
	}
	outputText("\n\n");

	outputText("Finally and completely sated, you roll off, ");
	if(x >= 0) outputText("twitching as your member disentangles itself from her tongue.");
	else outputText("twitching weakly as your clit catches her tongue one last time.");
	outputText("  It takes you a moment to catch your breath, but once you do, you stand with renewed vigor and satisfaction – Isabella is delirious and panting.  You lean down to listen and she whispers, \"<i>..love you.  Lick lick lick slurp slurp cum cum! Fun fun cum cum...</i>\"  The poor girl is completely blissed out!  Hell, it sounds like she's already forgiven you for the rough treatment, just as she should.\n\n");
	outputText("You get dressed and leave with a smile.");
	//(slimefeed + izzy unmad!)
	player.sexReward("saliva", "Default");
	isabellaFollowerScene.isabellaAffection(15); //okay, redeemed)
	flags[kFLAGS.ISABELLA_ANGRY_AT_PC_COUNTER] = 0;
    if (CoC.instance.inCombat) cleanupAfterCombat();
    else endEncounter();
}

//['Too Big' Victory Titfucking Funtimes With Milk]
public function tooBigVictoryTittyFuckingFuntimesWithMilk():void {
	var x:Number = player.biggestCockIndex();
	clearOutput();
	outputText("You toss aside your [armor] to reveal your " + cockDescript(x) + " to the ");
	if(monster.lust >= monster.maxOverLust()) outputText("lusty");
	else outputText("weakened");
	outputText(" cow-girl.  Her eyes go wide as she beholds the full, revealed length, watching it ");
	if(player.lust >= (player.maxLust() * 0.7)) outputText("pulsate with your raging lust");
	else outputText("slowly fill with blood from your growing lust");
	outputText(".  You stroke with each closing movement until you're standing over her and looking down the cleavage of her gratuitous bosom.  Isabella begins to pout while you explain her task to her – she's going to tit-fuck you with those tremendous tits");
	if(player.cockThatFits(monster.vaginalCapacity()) == -1) outputText(" since there's no way you'll be able to cram it in her cunt or asshole.\n\n");
	else outputText(".\n\n");

	if(isabellaAccent()) outputText("The cow-girl whines, \"<i>B-but I don't vant it in mein milkers!  Your thing... it is big and gross and nasty, like a demon's!</i>\"\n\n");
	else outputText("The cow-girl whines, \"<i>B-but I don't want that!  Your cock... it's big and gross... and nasty, like a demon's!</i>\"\n\n");

	outputText("\"<i>");
	if(player.cor < 33) outputText("I'm sorry, but you're too hot to resist, and it's better I do this than try to force it in a hole that could never accept it,");
	else if(player.cor < 66) {
		outputText("This isn't up for discussion.  ");
		if(monster.lust >= monster.maxOverLust()) outputText("You're so drippy that you want this anyway,");
		else outputText("You lost and you've got to deal with the consequences,");
	}
	else outputText("Tough shit,");
	outputText("</i>\" you answer.  To emphasize your point, you reach down to her corset and pop the laces, one at a time.  Each snapping string starts an avalanche in Isabella's massive tits, bouncing the two mountainous mounds with every sudden release of pressure.  She shudders with an expression of disgust on her face, but you can see her nipples straining her transparent top even tighter.\n\n");

	outputText("Isabella is getting off on being disrobed!  You don't stop at her corset either; every bit of clothing above her waist is pulled off and discarded, saving the silken shirt for last.  ");
	if(player.cor < 33) outputText("You take care to remove it without damaging the garment, as if respect for property will make up for slaking your lusts on her unwilling body.");
	else if(player.cor < 66) outputText("You remove the garment without much care for its condition, not damaging it too much as you wrench it free.");
	else outputText("You tear off the offending garment without a single care for the cow-girl's property.");
	outputText("  She looks up at you with teary brown eyes and asks, \"<i>Please be gentle with me");
	if(isabellaAccent()) outputText(", ja?");
	else outputText(".");
	outputText("</i>\"\n\n");

	outputText("Your gaze is so intently focused on the quad-tipped areolae that you barely acknowledge her request.  A slight grunt escapes your lips while you fondle your shaft, squeezing it gently with both hands.  You take a half-step forward and aim your " + player.cockHead(x) + " between Isabella's breasts.  The first dollop of pre-cum oozes from the tip just in time to smear into the valley of cleavage, lubricating the sweaty skin even further.  Her body is hot from the recent combat, and the warm, wet embrace of the cow-girl's bosom feels absolutely heavenly as you slide home through the valley of chest.\n\n");

	outputText("Sighing blissfully, you grab hold of Isabella's breasts by the prominent nipples and pull them together, finishing the titillating encapsulation of your member.  She moans loudly at the forceful tug as she watches you violating her tits.  The " + player.cockHead(x) + " of your " + cockDescript(x) + " bursts from between the pillowy mounds to leak on the cow-girl's chest, and the bovine beauty can only manage a dark blush in response.  You're already leaking a steady trickle of pre-cum from your crown from the hot tightness of Izzy's tits; orgasm isn't too far.\n\n");

	outputText("The cow-girl utters a pleasured moo in response to the tight nipple tension.  Holding tightly, you roll the four tips between your fingers as you slowly begin to fuck the cow-girl, ignoring the wetness that begins to squirt between them.  Isabella's hips seem to squirm of their own volation, and the cow-girl's legs spread wide to grind her skirt-girded loins against your [legs].  You respond by turning your gentle thrusts into rough, pistoning motions that shake the jiggling melons violently around your " + cockDescript(x) + ", but it only seems to please the milk-spurting cow.\n\n");

	outputText("Isabella grinds against you in a frenzy, thrashing wildly against your [legs].  Her motions only exacerbate the tightness of the tit-sleeve milking your " + cockDescript(x) + ", and as you look down at the convulsing cow-girl's blissful expression, you feel a telltale welling of pressure in your [balls].  You wait for her mouth to gape particularly wide before thrusting forward, ");
	if(player.cocks[x].cockLength < 50) outputText("burying the top few inches of your length into her mouth");
	else outputText("pushing your cock across her puckered lips and past her forehead");
	outputText(".  Milk splatters off your palms, spraying out in a fan that drenches the titty monster in her own cream.  You try to ignore it, but the sight before you is so utterly erotic that you know you have no chance of holding back your orgasm.\n\n");

	outputText("Your " + cockDescript(x) + " is laid out over a busty, milk-spewing cow-girl, pressing up all the way ");
	if(player.cocks[x].cockLength < 50) outputText("to her mouth");
	else outputText("to smother her face in heavy dick-flesh");
	outputText(".  Meanwhile, Isabella's expression is one of unthinking, overwhelming pleasure.  Even her eyes seem unfocused and slightly crossed - she's getting off on being titty-fucked!  There's actually a growing  puddle of slippery girl-jizz deepening around your [foot] as it leaks from Isabella's plush-lipped pussy.");
	if(player.hasBalls()) outputText("  Your balls pull tight to your loins, accompanied by a burst of warmth");
	else outputText("  A bubble of warmth grows in your loins");
	outputText(", and you know there's no stopping your climax now.\n\n");

	outputText("Starting at the ");
	if(player.hasSheath()) outputText("sheath");
	else outputText("base");
	outputText(", a distorted bulge plumps up your urethra as it presses forward, pausing at the tight valley of Isabella's cleavage before it squeezes into the sweaty breast-embrace.  You groan loud enough to drown out the cow-girl's moans of exquisite pleasure, and the next pump of cum begins its journey towards release, even before you release the first.  She ");
	if(player.cocks[x].cockLength < 50) outputText("leans forward to swallow more of your cock just before");
	else outputText("leans back to swallow your " + player.cockHead(x) + " and lick it, just before");
	outputText(" it explodes in her mouth.  ");
	if(player.cumQ() < 25) outputText("A single gulp demolishes your meager output.");
	else if(player.cumQ() < 150) outputText("A slight change in the shape of her cheeks is the only reaction you get to the size of your load.  A noticeable swallow empties her maw.");
	else if(player.cumQ() < 250) outputText("A runnel of cum escapes from the bovine beauty's mouth while her distended cheeks slowly narrow. She audible gulps down the heavy load.");
	else outputText("A torrent of seed runs down her chin, but the bovine beauty gulps and swallows, trying her best to keep up.");
	outputText("  The next pulse is even larger than the first, and Isabella's eyes give you an unfocused but loving look while she devours your seed. Her erupting milk's consistency thickens to a heavy cream, and you gently pull her four-pointed nipples up and down while the two of you cum together.\n\n");

	outputText("Like all good things, your climax eventually ends.  As you admire your handiwork, however, you feel a happy throb from your [cocks].  It was a truly magnificent coupling of penis and breast.  Isabella's hefty mounds still bear traces of your seed - after the first few spurts you pulled out and allowed the rest of your load to ");
	if(player.cumQ() < 500) outputText("spurt on");
	else outputText("soak");
	outputText(" her breasts.  She's mooing contentedly and tugging on her teats now, squeezing the last of her cream out while you watch.  The cow-girl barely seems conscious of your presence at this point.\n\n");
	isabellaFollowerScene.isabellaAffection(6); //happier
	outputText("Shrugging, you wipe " + sMultiCockDesc() + " off on her lips and get dressed.  This cow is one marvelous cum-dump.");
	player.sexReward("milk", "Dick");
	cleanupAfterCombat();
}

//[VAGINAL PROD N' POKE]
public function vaginalProdNPokeIsabella():void {
	var x:Number = player.cockThatFits(monster.vaginalCapacity());
	if(x < 0) x = 0;
	clearOutput();
	outputText("You smirk down at Isabella as you tell her that milk is the least of your concerns.  The ");
	if(monster.lust >= monster.maxOverLust()) outputText("lusty");
	else outputText("defeated");
	outputText(" cow-girl pales and asks, ");
	if (isabellaAccent()) outputText("\"<i>But vhy not?  Mein milk is so gooood.</i>\"");
	else outputText("\"<i>But why not? My milk is so goood.</i>\"");
	outputText(" The last word emphasizes the 'o's so much that it comes out almost like a moo.  You push her legs apart and flip up her skirt to reveal the cleft of her womanhood.  She didn't even bother with panties, so there's nothing to protect her ");
	if(monster.HP <= monster.minHP()) outputText("slowly-engorging");
	else outputText("juice-slicked");
	outputText(" pussy-lips.  You look up at her and comment on the state of her vagina, asking if she's sure she didn't want it this way.\n\n");

	if (isabellaAccent()) outputText("\"<i>Nein! I... I never vanted to have to fight you!  And I definitely didn't vant to vind up on my keister vith my legs spread while a handsome " + player.mf("man","woman") + " ogles my vagina!</i>\" exclaims the cow-girl.\n\n");
	else outputText("\"<i>No! I... I never wanted to have to fight you!  And I definitely didn't want to wind up on my butt with my legs spread while a handsome " + player.mf("man","woman") + " ogles my vagina!</i>\" exclaims the cow-girl.\n\n");

	outputText("You reach down to touch the skin around her loins, circling her puffy pussy-lips without actually touching any part of her moist slit.  Isabella moans out loud and spreads her softly-furred thighs apart, subconsciously welcoming your probing ministrations.  The dewy muff visibly plumps with each teasing circle your fingers make, until her vagina gradually begins to bloom like a flower; if flowers were pulsating pink tunnels of sweltering lust. Still, the spreading of her labia is an entrancing, if arousing sight.  A pudgy, fat little clit sprouts near the top and gradually swells until it reaches its full size.  Throughout it all, you deny her pussy the touch it so craves, circling a digit around the circumference of her box with constant, even strokes.\n\n");

	outputText("\"<i>Are you sure?</i>\" you ask.  Isabella bites her lip petulantly, but you brush the sensitive skin of her inner thigh and the dusky cow-girl moans, ");
	if (isabellaAccent()) outputText("\"<i>Fine!  I-I vant it in my pussy!  Fuck me!  Fuck mein cunt...</i>\"");
	else outputText("\"<i>Fine!  I-I want it in my pussy!  Fuck me!  Fuck my cunt...</i>\"");
	outputText(" She trails off into half-cries, half-moans in between shudders of inadvertent pleasure.  Her hips twitch at you, begging for more stimulation, more pleasure; anything to satisfy the aching need you've stoked betwixt her thighs.\n\n");

	outputText("You step back to undress. Isabella takes the opportunity to reach for her sodden snatch, but you brush her questing fingers away with your [foot].  She glares at you a moment before she resumes her slutty gyrations, the need for satisfaction overwhelming her irritation at being denied.  You " + player.mf("chuckle","giggle") + " down at her as you pull out your [cocks].  Wide-eyed, the red-head watches you stroke " + sMultiCockDesc() + " and licks her lips.\n\n");

	outputText("Approaching with as much sensual exaggeration as possible, you lean over the busty bitch and let " + oMultiCockDesc() + " prod at the dilated quim.  Isabella moos at the hint of vaginal penetration while milk begins to bead atop her nipples, soaking through the taut fabric of her chemise.  You smirk and squeeze one of the dusky tits, expressing four small squirts of milk simultaneously.  Amazingly, the creamy pulses continue even once you release the sloshing cow-teat.  You press on anyway, hilting yourself in the girl-cum-oozing tunnel with one smooth movement while the lactating woman's soaked top starts to cling to her well-endowed torso.\n\n");

	outputText("\"<i>");
	if (isabellaAccent())
	{
		if(player.cockArea(x) > monster.vaginalCapacity()) outputText("Oh! Ze cock! It is too big for meeee!  I... am being stretched so mooo-uch!");
		else if(player.cockArea(x) > 13) outputText("Oh, such a nice cock you have!  It is rubbing mein pussy so good!");
		else outputText("Oh, what a surprise!  Ze cock, it is nice and comfortable in my pussy.  I love cute little dicks ze best!");
		outputText("</i>\" screams Isabella with heavily-accented, awkward words.\n\n");
	}
	else
	{
		if(player.cockArea(x) > monster.vaginalCapacity()) outputText("Oh! The cock! It's too big for me!  It's... stretching me so mooo-uch!");
		else if(player.cockArea(x) > 13) outputText("Oh, such a nice cock you have!  It's rubbing my pussy so well!");
		else outputText("Oh, what a surprise!  Your cock is nice and comfortable in my pussy.  I love cute little dicks the best!");
		outputText("</i>\" screams Isabella with lightly-accented, awkward words.\n\n");
	}


	outputText("You smirk and slap at one of the cow-girl's breasts in response, setting off a geyser of lactic fluid that rains down on both of you.  Now that Isabella's tits have started to let down her milk, there's no stopping the alabaster flow.  Her spray of lactation covers her, you, and her belongings, unfettered by the sopping-wet shirt plastered tightly to her chocolate-toned mounds.  You lick a few droplets from your lips and marvel at the sweetness.  She's absolutely delicious.\n\n");

	outputText("In spite of the distracting milk-fountains, your main focus remains on her cunt, and how wonderful that hot little box feels around your " + cockDescript(x) + ".  ");
	if(player.cockTotal() > 1) {
		outputText("You wish you had room for ");
		if(player.cockTotal() > 2) outputText("another " + oMultiCockDesc());
		else outputText("your other penis");
		outputText(" inside her, but her arousal-slicked lips are squeezing too tightly on you for you to cram anything else into that hole, and at this angle, anal sex would be nigh impossible.  ");
	}
	outputText("Isabella's cunt squelches wetly every time her hips rock against you, bubbling and frothing her copious fem-cum while her prominent love-button bumps into your loins at the apex of each motion.  You return the favor, grunting and hilting yourself harder and harder, spurred on by half-understood male instincts that drive you to bury every inch of your cock into her squishy honeypot.\n\n");

	outputText("A spurt of cow-cream catches you in the eye.  Thankfully it doesn't sting; you blink the offending fluid away and glare down at your conquest for a moment before deciding to take matters into your own hands.  Reaching down to the cow's heaving bosom, you grab her multifaceted nipples in your hands and pinch hard, shutting down the flow of milk with intense pressure.  Isabella throws back her head and cums instantly from the powerful stimulation, but as she begins to thrash underneath you, your grip locks around her teats in spite of the milk hammering against you, trying to squirt out.  You can actually hear her tits sloshing with every second that passes, growing larger and larger in your hands.\n\n");

	outputText("Her legs wrap around you and squeeze so tightly ");
	if(player.tou > 80) outputText("that they'd damage a lesser person");
	else if(player.tou > 50) outputText("that it actually hurts");
	else outputText("that you worry she'll crush your pelvis");
	outputText(".  Your " + cockDescript(x) + " is wrung with equal tightness, nearly crushed inside Isabella's muscular pussy as her blissfully hot cunt convulses wildly.  The painful tightness is unpleasant, but at the same time your dick feels harder than ever.  Rippling, muscular contractions pull on your dick repeatedly, milking your poor member as if it were simple livestock, and you give in to the powerful pulses after only a few moments, throwing your head back and ramming yourself into her with all your strength.\n\n");

	outputText("Cum bubbles up " + sMultiCockDesc() + ", robbing you of your tension. As you lose your grip on the cow-woman's nipples, milk erupts from the dark-skinned teats in a torrential outpouring of white fluid.  It rains over you in heavy drops, and at least one such drop manages to land in your mouth.  It's thick and sweet as candy, a heavenly cream that makes your head swim with its flavor while your whole body clenches in orgasmic bliss.  Your release is stymied by the tightly contracting velvet sheath, and the waves of jism stop up inside you, almost painfully, before she finally relaxes and allows you to fill her with one long, hip-humping ejaculation.");
	if(player.cumQ() >= 1000) {
		if(player.cumQ() < 1500) outputText("  Isabella's belly pudges out from all the semen in her womb by the time you finish; visible proof of your fertility.");
		else if(player.cumQ() < 2500) outputText("  Isabella's belly distends massively by the time you finish, showing visible proof of your obscene fertility.");
		else outputText("  Isabella's massively distended belly and cum-squirting cunt are all the proof of your fertility you would ever need.");
		if(player.cumQ() >= 1500) outputText("  The huge puddle you leave behind is a nice bonus though.");
	}
	outputText("  You pull out with a happy sigh, barely noticing how completely covered in Isabella's creamy milk you are.  Glancing back at her, you note her glazed expression and still-dripping nipples.  She still wears a dopey grin, and you doubt she'll get too mad about this once she remembers how good she felt.  You toss on your [armor] and stop at the lake to clean up on your way back, though for most of the trip you're busy licking up her tasty milk-deposits.\n\n");
	//Reset anger
	flags[kFLAGS.ISABELLA_ANGRY_AT_PC_COUNTER] = 0;
	isabellaFollowerScene.isabellaAffection(9); //yep. redeemed
	cleanupAfterCombat();
	player.sexReward("vaginalFluids", "Dick");
}

//[Small dick tit-fucking] (Dicks less than 9 inches)
public function tinyVictoryTittyFuckingFuntimesWithMilk():void {
	var x:Number = player.smallestCockIndex();
	clearOutput();
	outputText("You toss aside your [armor] to reveal your " + cockDescript(x) + " to the ");
	if(monster.lust >= monster.maxOverLust()) outputText("lusty");
	else outputText("weakened");
	outputText(" cow-girl.  She squeals in delight at the sight of your " + multiCockDescriptLight());
	if(player.cockTotal() > 1) outputText(", singling the smallest one out for some reason");
	if (isabellaAccent()) outputText(".  \"<i>Is zat vant you vanted from me?  Oooh baby, you could have just asked!  Mamma Isabella loves sucking on cute little penises like yours, particularly ones like zat little guy, right zere.</i>\"\n\n");
	else outputText(".  \"<i>Is that what you wanted from me?  Oooh baby, you could have just asked!  Momma Isabella loves sucking on cute little dicks like yours, particularly ones like that little guy, right there.</i>\"\n\n");

	outputText("The cow-girl grabs hold of your " + cockDescript(x) + " for emphasis and begins to stroke it enthusiastically.  Having her large (but still feminine) hand wrapped around you makes your dick look positively tiny in comparison, ");
	if(player.cor < 33) outputText("bringing a shameful blush to your cheeks");
	else if(player.cor < 66) outputText("bringing a tiny blush to your cheeks");
	else outputText("but you aren't really bothered by it in the slightest");
	outputText(".  You clear your throat and try to regain control of the situation by demanding that she service you with her breasts.  Isabella happily accedes, even going so far as to clap excitedly as she sheds her top.  She seems to genuinely relish the idea, to a degree that makes her forget ");
	if(monster.lust >= monster.maxOverLust()) outputText("her own needs.");
	else outputText("her wounds.");
	outputText("\n\n");

	outputText("Pulling herself up to lean against your groin, Isabella holds her hefty breasts in her hands and presses them around your " + cockDescript(x) + ".  The squishy-soft mammaries utterly envelops your penis in their warm, sweat-lubricated embrace");
	if(player.cockTotal() > 1) {
		outputText(", but she completely ignores the other one");
		if(player.cockTotal() > 2) outputText("s");
	}
	outputText(".  Isabella smirks up at you as she begins to jiggle her boobs back and forth while saying,");
	if (isabellaAccent()) outputText(" \"<i>Does your cute little cock like zis?  Ooooh, I zink it does.  It vants to squirt into my cleavage like a good little dick, ja?</i>\"");
	else outputText(" \"<i>Does your cute little cock like this?  Ooooh, I think it does.  It wants to squirt into my cleavage like a good little dick doesn't it?</i>\"");
	outputText(" You start to nod before you catch yourself and arrest the motion.  You're the one in control, not her!\n\n");

	outputText("Isabella doesn't even seem to notice your conflict, as she's become utterly transfixed by the feeling of your " + cockDescript(x) + " pulsing inside her tits, drooling pre-cum obediently as if trying to make her words a reality.  You slowly slump down to the ground and begin to pant weakly, allowing Isabella to utterly dominate your tiny dick with her tits.  Sweat and beads of milk drip from her nipples as she works, and you begin to smell the scent of her arousal growing ever more pungent in the air.\n\n");

	outputText("Your whole body starts to blush before long, your tiny cock unable to cope with the teasing cow-girl's ministrations.  She looks you in the eye and begins to bob her whole body up and down, shaking her tits while she asks,");
	if (isabellaAccent()) outputText(" \"<i>Are you going to cum for me soon?  I vant zat tiny cock to spurt all its meek little cum over my breasts until it's limp.  Isn't zat vat you want?</i>\"");
	else outputText(" \"<i>Are you going to cum for me soon?  I want that tiny cock to spurt all of your meek little load of cum over my breasts until it's limp.  Isn't that what you want?</i>\"");
	outputText(" Her sultry teases arouse you past the tipping point, and you feel your cock begin to release ");
	if(player.cumQ() < 50) outputText("its pathetic little load");
	else if(player.cumQ() < 250) outputText("a nice gooey load");
	else if(player.cumQ() < 500) outputText("its hefty, tit-drenching load");
	else outputText("its massive, body-soaking load");
	outputText(" into Isabella's cleavage.");
	if(player.cumQ() >= 1000) outputText("  It pumps and pumps, blotting out her chest and face, turning her expression to one of ecstatic shock.");
	if (isabellaAccent()) outputText(" \"<i>Oh my!  Such an obedient little cock!  Zat's right; cover me vis your seed, my adorable little weenie!</i>\"");
	else outputText(" \"<i>Oh my!  Such an obedient little cock!  That's right; cover me with your seed, my adorable little dick!</i>\"");
	outputText("  You shake and squirm against her, your body going weak with every pump of seed until you fall flat on your back and spurt the last of your cum onto your belly.\n\n");

	outputText("Isabella dutifully cleans you with her tongue before delving back into her chest and beginning to scoop the seed from her milk-dripping tits.  You watch her for a time until you feel recovered, then get dressed and depart, wobbling unsteadily on your [legs].  Isabella's noisy swallows are followed by a catcall.");
	if (isabellaAccent()) outputText("  \"<i>Come back soon!  You have ze tastiest little dick and I vant to play with it more, ja?</i>\"");
	else outputText("  \"<i>Come back soon!  You have the tastiest little dick and I want to play with it more!</i>\"");
	//Reset anger
	isabellaFollowerScene.isabellaAffection(12); //she LOVES it
	flags[kFLAGS.ISABELLA_ANGRY_AT_PC_COUNTER] = 0;
	cleanupAfterCombat();
	player.sexReward("milk", "Dick");
}

//[Discuss Isabella]
public function talkWithIsabella():void {
	spriteSelect(SpriteDb.s_isabella);
	clearOutput();
	if(flags[kFLAGS.ISABELLA_TALKS] == 0) {
		outputText("You tell Isabella your own tale before asking if she'd share how she came to be in her present situation. The normally feisty red-head sighs and responds, \"<i>Yes, it is only fair I suppose.</i>\"\n\n");
		outputText("She clears her throat nervously before she begins, \"<i>I vas an adventurer in mein homeland. I vould roam the vilds vith nothing but mein shield, mein skills, and mein viits to back me up. It vas vunderbar. I had amassed a small fortune between doing mercenary vork and dungeoneering, but one day I delved too deep. There was a fluttering pink portal, and with the thought of riches filling mein noggin, I stepped through.</i>\"\n\n");
		outputText("Isabella looks at you with tears welling in her eyes. \"<i>The portal vouldn't let me back through. I got stuck here, away from mein friends and family, vith nothing but sex-perverts for company. Zankfully, most of zem couldn't handle mein shield.</i>\"\n\n");
		outputText("You look at her curiously, asking if she was always so... bovine in appearance. She smirks and replies, \"<i>I suppose I had zat one coming. Still, I vas not always as you see. Some of ze foes I defeated dropped some potions. And... ze bova ones were sooo delicious. I couldn't help meinself. I even mixed a few different kinds together to see vhat vould happen. It made mein m-m-milk so strange und sweet.</i>\"\n\n");
		outputText("Isabella brightens as she continues, \"<i>But I've made a nice little home here, and from time to time, I do manage to make some friends.</i>\"\n\n");
		outputText("The busty cow-girl leans forward to crush you in a tight hug, squeezing you against her tits before informing you she's got some work to do around her camp. You nod and leave.\n\n");
		isabellaFollowerScene.isabellaAffection(10); //bigger increase first time
	}
	//[Discuss Isabella Repeat]
	else {
        outputText("You sit down with Isabella and share tales of your recent adventures.  While the companionship is nice, after an hour or so of discussion you decide to go your separate ways.");
        isabellaFollowerScene.isabellaAffection(5); //smaller later
    }
	flags[kFLAGS.ISABELLA_TALKS]++;
	endEncounter();
}
	}
}
