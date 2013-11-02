/* Written by Nonesuch and PKD, edited by Abraxas, Anzuaz, 05095coc and some helpful anons; ideas suggested by Abraxas, G3 and some helpful anons. */

//const DECLINED_TO_VISIT_REBECCS_VILLAGE:int = 500;
//const TIMES_IN_DEMON_PIT:int = 501;
//const TIMES_REFUSED_REBECCS_OFFER:int = 502;
//const OWCAS_ATTITUDE:int = 503;
//const VAPULA_SUBMISSIVENESS:int = 504;
//const DAYS_SINCE_LAST_DEMON_DEALINGS:int = 505;
//const OWCA_UNLOCKED:int = 506;
//const REBECCS_LAST_PLEA:int = 507;
//const OWCA_ANGER_DISABLED:int = 508;

//const VAPULA_HAREM_FUCK:int = 546;
//const VAPULA_THREESOMES:int = 547;
//const OWCA_SACRIFICE_DISABLED:int = 548;
//const VAPULA_FOLLOWER:int = 549;
//const VAPULA_DAYS_SINCE_FED:int = 551;
//const VAPULA_TEASE_COUNT:int = 552;
//const VAPULA_EARNED_A_SPANK:int = 634;

function vapulaSlave():Boolean {
	if(flags[VAPULA_FOLLOWER] == 1) return true;
	return false;
}

function gangbangVillageStuff():void {
	clearOutput();
	if(flags[OWCA_UNLOCKED] == 1) owcaMainScreenOn();
	else gangbangVillageFirstGoRound()
}
//First encounter (Z)
function gangbangVillageFirstGoRound():void {
	clearOutput();
	/*if(flags[OWCAS_ATTITUDE] < 5) {
		desperateVillages();
		return;
	}*/
	if(flags[DECLINED_TO_VISIT_REBECCS_VILLAGE] == 0 && flags[TIMES_REFUSED_REBECCS_OFFER] == 0 && flags[TIMES_IN_DEMON_PIT] == 0) {
		//[Attitude is set to 50]
		flags[OWCAS_ATTITUDE] = 50;
		flags[VAPULA_SUBMISSIVENESS] = 50;
		outputText("You wander for quite a while in an endless field of grass before spotting a commotion in the distance.  A myriad of creatures have gathered in the path ahead, waving to you enthusiastically, some still holding tightly to their farm tools.  It's quite an odd sight, all these happy farmhands extending a warm welcome.  You simply accept it as a gesture of kindness and make your way toward the crowd of smiling faces.");
		outputText("\n\nA female emerges from the group to greet you and tries to communicate her intentions, holding up a peace sign.  As she approaches, her features become more apparent.  Her appearance is strikingly similar to that of a human.   Her face is pale, with the appearance of porcelain.  Gazing lower, you see that she possesses a bountiful bosom that bulges against her crude peasant dress and hips that sway with grace as she approaches nonchalantly.  Only the two little nubs on her forehead and the long, white woolen mound of her hair suggest she's anything more than a stray village girl from a human town like your own.  The rest of the crowd is of similar appearance, and they begin to follow her lead, walking towards you.  Is this a herd of sheep people?  Or, if you could dare bring yourself to say it... sheeple?");
		outputText("\n\nThe girl closes the distance between you with three quick strides, and swiftly plants a peck on your cheek.  You straighten up a bit in surprise at such a friendly greeting from the inhabitants of this land.  Her cool breath smells like fresh dairy milk and her eyes are glinting as she speaks.  \"<i>Greetings!  You're not from this world, are you?  We've seen many a vagabond adventurer in this land.  My name's Rebecc, and we're always happy to meet your kind!</i>\"");
		outputText("\n\nYour curiosity gets the better of your caution, and you admit that you're indeed a traveller from another world, then introduce yourself.");
		outputText("\n\n\"<i>Of course, of course.  Why don't you follow us, valiant warrior?  We were just about to return home; we could use a little company.</i>\"  As she talks you can't help but notice she keeps readjusting her dress, subtly revealing a bit more of her cleavage at every shift.  You see she also takes repeated glances at your crotch, probably thinking she's being discreet enough.  Her nipples are hardening through her dress, her smile is teasing you; her entire body language seems to be an open invitation as well as a display of seduction.");
		outputText("\n\nDo you follow her?");
		doYesNo(agreeToFollowRebecFirstTime,dontGoToZeVillage);
	}
	//As long as you don't follow her once, display this on subsequent encounters (Z)
	else if(flags[TIMES_IN_DEMON_PIT] == 0) {
		outputText("After wandering across the plains for a while, you spot Rebecc, the girl you met before, amongst a group of fellow farmers; she calls out to you.  \"<i>Hello again, traveler!  You seem lost... would you mind spending some time with us at our village?</i>\"");
		outputText("\n\nAs before, you notice while speaking with her that she keeps glancing at your crotch for a few seconds at a time.  She puts on a sultry smile as she nudges the edges of her dress, revealing more and more cleavage each time.  She's a bit shaky as well; it's almost as if she's attempting to seduce you, but is only with difficulty able to contain herself.  Will you spend time with her in the village?");
		//Yes/No
		doYesNo(agreeToFollowRebecFirstTime,dontGoToZeVillage);
	}
	//Second (and subsequent) encounter; only happens once PC accepted being sacrificed once (Z)
	else {
		outputText("Using the vivid memory of your last encounter, you easily find Owca village; the first houses are in sight when you spot someone rushing to you.  You recognize Rebecc, the girl you first met in the plains and who begged you for your help.  She is smiling, her arms open for a welcoming embrace.  Before you even try to say something she is already hugging you, pressing her warm body against yours as she takes you in her arms.  She holds you tightly for a minute before kissing you everywhere affectionately; you haven't said a single word and your cheeks and lips are already bearing the mark of her lipstick.");
		outputText("\n\n\"<i>Thank you!  Thank you so much, " +player.short+ "!  You are a wonderful person!  What you did was noble and selfless.  Our people will remember you for years to come!</i>\"");
		//[if corr >= 50] 
		if(player.cor > 50) outputText("  You can't help but smile internally.  Let her think that, if she wants.");
		outputText("\n\nShe grabs your hand and drags you to her village, hopping joyfully as she keeps thanking you for your heroic gesture.  You finally reach her home; a handful of people join you, attracted by the noise she's been making.  People are everywhere showing unconditional gratitude, bowing down and muttering thankful words as you go by; it's almost as if they were intimidated - or ashamed - by someone worthier than them.  Eventually you are left alone with the charming farmer girl.");
		outputText("\n\n\"<i>My home is yours, hero; alongside everyone else's.  You will always be welcome here.  Don't hesitate to come to my place; you must feel all dirty and sullied from these corrupted monsters.  Don't worry, I'll clean you up.</i>\"  She winks at you and walks into her house, leaving her door open as an invitation.");
		outputText("\n\n(<b>Owca Village added to your 'Places' menu.</b>)");
		flags[OWCA_UNLOCKED] = 1;
		doNext(gangbangVillageStuff);
	}
}
function dontGoToZeVillage():void {
	clearOutput();
	flags[DECLINED_TO_VISIT_REBECCS_VILLAGE]++;
	eventParser(13);
}
//First plea (Z)
function agreeToFollowRebecFirstTime():void {
	clearOutput();
	if(flags[TIMES_REFUSED_REBECCS_OFFER] == 0) {
		outputText("How could you refuse an invitation from such an alluring girl?  You eagerly agree to go to her village; everyone sets out at once, chatting with each other jovially, but your attention is squarely focused on Rebecc.  She seems impressed by the tales of your adventures and has nothing but praise for your endless bravery, delivered while clinging to your arm and pressing her body against yours.  Her sweet scent is invigorating, and a significant amount of blood flows toward your ");
		if(player.gender == 0) outputText("regretfully bare ");
		outputText("groin as you feel the contact of her tender curves against your body.  Taking advantage of the effect you seem to have on her, you start questioning her about her village, her people and how she was affected by demons.");
		outputText("\n\n\"<i>There, we've almost arrived at Owca, our village; you can see the first houses.  As for demons... well, you know, they are the reason we wanted you to follow us.  You see, a large group of them have been harassing us.  At first they were just scavenging for food and various supplies, but soon they started claiming... another kind of prize.  You know these creatures, you know what they do.  There have been many battles to protect our rightful clay and hard-earned food, but there were simply too many of them.  Besides, they often use some kind of... black magic in order to subdue their foes and turn them into obedient slaves.  ");
		//[if silly mode on]
		if(silly()) outputText("I-I don't think there's a single grown man or woman in our village that still has their anal virginity.");
		//[if silly mode off]
		else outputText("Th-they abused us.  They mistreated us.  They would gather in circles and... use us in every possible way.");
		outputText("</i>\"");
		//[if Corr < 20]
		if(player.cor < 20) {
			outputText("\n\nYou are shocked by this revelation. You wrap your arms around Rebecc's shoulders protectively, and tell her in a reassuring tone that ");
			//[[if silly mode on]
			if(silly()) outputText("she'll never have to worry about her asshole again.");
			//[if silly mode off] 
			else outputText("she will never be abused again.");
			outputText("  If there's anything that can be done to hold off these evil creatures, you will do it.");
		}
		//[else if corr and libido both > 60]
		else if(player.cor > 60 && player.lib > 60 && player.hasCock()) {
			//[if silly mode on and presence of penis]
			if(silly()) outputText("\n\nYou can't help but pop an enormous boner.  [EachCock] is pressing so hard against your [armor] that you're afraid that one or the other might break.  ");
			//end of local silly willy condition
			else outputText("\n\n");
			outputText("You are uncontrollably turned on by this revelation; your genitals actually hurt at your absurd level of arousal.  Just imagining groups of demons gathered around the helpless villagers, sometimes taking turns with each one and sometimes taking someone all at once, turns you on way more than it should.  You stupidly grin for a few seconds as your mind pictures vivid and lecherous scenes of collective ass-rape, but then you remember this is supposed to be bad news; you quickly recompose yourself and put on a false expression of worry.  Luckily she didn't notice the lust that temporarily filled your eyes; neither does she spot the massive tent growing in your " +player.armorName+ ".  You ask her if there's anything you can do to meet these demons and 'handle' them on your own.");
			//end of condition about PC's corruption
		}
		outputText("\n\n\"<i>Well, a man from our village decided to go meet these demons at their camp in order to negotiate with them.  They agreed to a deal.  As you may guess, it was a... special kind of deal.</i>\"");
		outputText("\n\nYou know what kind of deal should be expected from these wicked creatures, but you let her take her time explaining.");
		outputText("\n\n\"<i>At the end of every week, one of us must be chained and left at the demons' disposal for the full night.  It must be someone different every night.  Chosen people usually come back battered and sore, and they have dirty fluids and unthinkable mixtures leaking from every hole of their body.  It's a difficult thing to think about, but it's necessary for our community.  But then...</i>\"  She wavers for a moment, before looking back to you with a desperate plea in her eyes.  \"<i>You're a brave, courageous adventurer; you just said you were willing to handle these demons!  It would almost be a blessing to us if you could help - not that you have to, but... it seems like we're beyond saving.</i>\"  The girl looks despondent, but then changes her composure when she turns back to the village.  \"<i>I might be being selfish, but you'd have my eternal gratitude if you helped.</i>\"");
		//[if corr < 50 and int >= 50]
		if(player.cor < 50 && player.inte >= 50) {
			outputText("\n\nSo this is what it has come to.  Her playfulness, her enticing gestures, her seductive play... she had been planning it all along.  She must have put on the same act for many people before you.  You feel slightly angry at yourself for having been fooled that easily; you feel angrier at her because she tried to use you as a mere disposable victim to be toyed with and manipulated; but you feel angriest at these demons for forcing honest folks to resort to infamous practices and deceptive seduction so they can live their lives as usual.");
			outputText("\n\nBut on second thought, she's right.  You're the champion of your own village; you're supposed to be selfless and resolute.  You were sent to this cursed land to prevent further corruption; your own physical integrity does not matter when other people are at stake.  Giving in to her demands would be certainly a noble and difficult act, something your elders would be proud of.  Of course it would seem like you had fallen for her trick, but do you really care?  You ponder your choices, thinking deeply");
			if(player.lib > 50) outputText("... and considering what Rebecc meant by 'gratitude'");
			outputText(".  Maybe it wasn't all an act?");
		}
		//[if corr < 50 and int < 50]
		else if(player.cor < 50) {
			outputText("\n\nYour eyes widen in surprise when you understand what she's asking of you, but after all, why not?  You're the champion; you're supposed to be selfless and resolute.  You were sent to this cursed land to prevent further corruption; your own physical integrity does not matter when other people are at stake.  Giving in to her demands would be certainly a noble and difficult act, something your elders would be proud of.  Of course it would seem like you had fallen for her trick, but do you really care?  You consider your choices");
			if(player.lib > 50) outputText("... and considering what Rebecc meant by 'gratitude'");
			outputText(".  Maybe it wasn't all an act?");
		}
		//[if corr >= 50]
		else {
			outputText("\n\nSo this is what it has come to.  Her playfulness, her enticing gestures, her seductive acting... she had been planning it all along.  She was doing it all on purpose, teasing you and tricking you into accepting her offer.  She must have put on the same act for many people before you.  You feel slightly angry at yourself for having been fooled that easily; you feel angrier at her because she tried to use you as a mere disposable victim to be toyed with and manipulated.  Well, if it comes down to that, you could probably agree and either beat the demons to take their place, or help them 'renegotiate' with the villagers...");
			//[[lib>=50]
			if(player.lib >= 50) {
				outputText("\n\nOn second thought, the prospect of meeting a full horde of horny, sexually-exploratory demons has appeal all on its own.  Your mind wanders a bit, thinking of all the luscious things they could do with your body; oh, the feeling of a half-dozen cocks and pussies working your every hole and pumping fluids in and out of you... perhaps you could even take a dominant position and fuck the demons until they pass out.");
			}
		}
		outputText("\n\nDo you accept?");
	}
	//Subsequent pleas upon first refusal (Z)
	else {
		outputText("\"<i>So, have you changed your mind yet?  Will you help us?  The demons will want another sacrifice soon, and we are afraid of what might happen if we don't comply!  Please, do accept this time!</i>\"");
		outputText("\n\nYou know very well what these people want: some meat to appease the demons.  Will you help them?");
	}
	//Yes/No
	if(flags[TIMES_IN_DEMON_PIT] == 0) doYesNo(3607,declineRebeccsPlea);
	else doYesNo(3608,declineRebeccsPlea);
}
//Refuse plea (Z)
function declineRebeccsPlea():void {
	clearOutput();
	outputText("You can't give in to her demand; you are a proud warrior fighting demons.  You were certainly not meant to serve as a scapegoat or sex-toy.  She sighs in disappointment.  \"<i>Well, I should have expected that.  I wasn't full of hope either.  No hard feelings.</i>\"  Everyone is looking at you with sad or apathetically hostile eyes, making you feel uncomfortable.  You quickly leave the village and return to your camp.");
	//[if more than 40 int, a warning after 4 consecutive refusals]
	//if(flags[TIMES_REFUSED_REBECCS_OFFER] >= 3 && player.inte >= 40) outputText("\n\nThe villagers are growing impatient of your repeated refusals; you can hear them exchange hushed whispers as you depart.  Failing to grant their request again will probably anger them considerably.");
	//[Attitude is set to 50]
	if(flags[OWCAS_ATTITUDE] > 5) flags[OWCAS_ATTITUDE] -= 5;
	flags[TIMES_REFUSED_REBECCS_OFFER]++;
	doNext(13);
}
//Accept plea (Z)
function acceptRebeccsPlea(firstTime:Boolean = false, sacrificed:Boolean = false):void {
	clearOutput();
	flags[OWCAS_ATTITUDE] += 10;
	if(flags[OWCAS_ATTITUDE] > 100) flags[OWCAS_ATTITUDE] = 100;
	outputText("You tell the desperate girl that you're going to do as she asks.  As soon as you finish speaking, everyone cheers and applauds you, praising you as their savior.  Rebecc grabs hold of your shoulders and gives you a soft kiss on your lips; she whispers, \"<i>Thank you, champion.  We all owe you.  I promise that you will be rewarded for the heroic deed you're about to undertake.</i>\"");
	outputText("\n\nA group of the farmers then proceeds to lead you across the village to a strange circle-shaped pit.  It's about one meter deep and ten meters in diameter.  At the center of the pit stands a tall wooden pole, adorned with several dangling ropes and chains.  You grimace as you realize you will be tied up and bound to the crudely fashioned post in order to make sure you don't escape before the demons show up.");
	//if(player.armorName != "comfortable clothes") outputText("  The farmers almost eagerly help you out of your " +player.armorName+ ", supplying you with a set of shabby but comfortable peasant clothes.");
	//[[if corr >70 and have gender]
	if(player.cor > 70 && player.gender > 0) {
		outputText("\n\nYou lick your lips in anticipation, your ");
		if(player.hasVagina()) outputText(vaginaDescript(0));
		if(player.hasVagina() && player.hasCock()) outputText(" and ");
		if(player.hasCock()) outputText(multiCockDescriptLight());
		outputText(" already slickening with sexual juices; the sight of these restraints brings all kinds of perverted thoughts to your mind: dozens of ways to be used and deliciously abused like a sex-toy by wretched and well-endowed beings.");
	}
	//[else]
	else outputText("\n\nYou shrug and tell yourself it was to be expected; after all, they barely know you and must be afraid that you may flee at the last moment.  Maybe some previous victims had already done so, with disastrous consequences for the village folks.");
	//end of condition
	outputText("\n\nThis vivid thought only helps strengthen your determination and you resolutely march toward the pit and the tall pole at the center.  As you drop into it, you notice the ground is soft, wet and has slightly whitish stains here and there.  Your nose is immediately assaulted by a strong musk that you instantly recognize – the smell of semen.  The villagers, used as they must be to working on sullied land, seem unfazed by these details.  You decide it's wiser not to make any comment and let them chain you to the pole.  They silently work for a few minutes, being careful not to knot the ropes too tightly so they don't hurt you.  At last, they give you a few encouraging pats on your shoulder; some females give you chaste kisses on your head, others wish you good luck and give you a last thankful wave, and a few seconds later they're all gone. You're left alone and naked in a sex-scented pit, bound to a post, waiting for the arrival of lustful, soulless creatures.  The villagers have retained all of your equipment in the name of keeping it safe, assuring you that it'll be returned to you the next morning.");
	outputText("\n\nPutting your dread aside, you close your eyes and attempt to sleep, vowing to save your strength for the ordeal that awaits you tonight.");
	//Dusk transition text (Z)
	doNext(3610);
}
function intoTheDemonPit(sacrifice:Boolean = true):void {
	clearOutput();
	//N is the number of hours left before night
	if(hours < 21) {
		outputText("<b>" + Num2Text(21-hours) + " hours pass...</b>\n");
		hours = 21;
		statScreenRefresh();
	}
	outputText("You are awakened by a sudden cackling, and open your eyes; you are almost entirely surrounded by darkness, and the dim light provided by the menacing red moon only makes the landscape bleaker.");
	outputText("\n\nYou look around, puzzled.  Nothing seems to break the ever-present, nightly silence.  Then, as if to tease you, the cackling is heard again, this time behind you.  You turn around and eventually spot its origin: a crowd of silhouettes, all rushing in your direction, tittering and giggling like a bunch of naughty kids about to play a dirty trick.  As they get closer and closer to the pit, their colorful bodies and alien features are given a shining outline by the bloody moon; it seems that they are all full demons, sporting horns, claws, tails and wings.  Most of them are naked, shamelessly displaying gigantic erections or cavernous pussies as well as watermelon-sized, milk-dribbling tits.  Some of them are wearing leather straps that barely cover their taboo parts, as if to mock all notions of human prudishness.  You even spot an imp wearing a weird greenish vine like a belt; you stare at him for a few seconds, knowing something is out of place, then realize the belt is actually the imp's very flexible tentacle dick.");
	outputText("\n\nSoon, they are all gathered in the pit, surrounding you completely and eyeing you with gleeful lust; whatever plans these demons have in mind, they must be dirty.");
	outputText("\n\nA tall purple demoness walks up to you as you stand there");
	if(sacrifice) outputText(", tangled in your restraints");
	outputText(".  She leans down and coos, ");
	//[if first time]
	if(flags[TIMES_IN_DEMON_PIT] == 0) outputText("\"<i>Awww, look at the poor little thing!  So this is what they gave us this time... Look at [him], everyone!  Do you know you'd be a cute pet?  People here call me Vapula, and I don't think you'll forget that name any time soon.</i>\"");
	//[else if Vapula Submissiveness >50]
	else if(flags[VAPULA_SUBMISSIVENESS] > 50) outputText("\"<i>You again?  By Lethice, you must really enjoy it!  You love being a bitch for Vapula, don't you?  Yes you do!</i>\"");
	//[else]
	else outputText("\"<i>Fuck, you again?  Tell me it's so!  I've been looking forward to putting you in your place as my newest slut!</i>\"");
	//[(if sacrificed)
	if(sacrifice) {
		//[if str >= 80]
		if(player.str >= 80) {
			outputText("\n\nYou test the chains holding you to the pole; they're slack enough that you have room to flex and you could probably break them if you decided to fight...");
		}
		else if(player.spe >= 80) {
			outputText("\n\nYou test the chains holding you to the pole; they're slack enough that you could probably make use of your incredible dexterity to slip free...");
		}
		//[else]
		else outputText("\n\nThe chains binding you aren't very tight or of the finest craftsmanship, but they're sufficient to hold you more or less in place; though you can probably twist to avoid a few attacks, you won't be able to make any of your own if you decide to resist... at least, not physically.");
		outputText("  You're once again feeling the regret over letting the villagers hold your equipment, but there's nothing for it now.");
	}
	flags[TIMES_IN_DEMON_PIT]++;
	flags[DAYS_SINCE_LAST_DEMON_DEALINGS] = 0;
	if(sacrifice) simpleChoices("Submit",loseOrSubmitToVapula,"Fight",3612,"",0,"",0,"",0);
	else simpleChoices("Submit",loseOrSubmitToVapula,"Fight",3613,"",0,"",0,"",0);
}
//Submit/Fight
function fightZeDemons(sacrifice:Boolean = true):void {
	clearOutput();
	//Fight leads to the Horde Fight
	//When acting as sacrifice, Item button is disabled; Fight, Run, and Phys Special buttons are disabled unless PC has str >= 80; Run is furthermore prevented entirely if PC is non-winged; outputs text: \"<i>You'd like to run, but you can't scale the walls of the pit with so many demonic hands pulling you down!</i>\"
	//PC's weapon is temporarily set to fists and armor to comfortable clothes during a Horde Fight if he triggered it in response to a sacrifice request, but not if triggered through volunteering to guard the pit later once the village is unlocked
	startCombat(7);
	if(sacrifice) {
		//Remove weapon
		player.createStatusAffect("Disarmed",0,0,0,0);
		flags[UNKNOWN_FLAG_NUMBER_00268] = player.weaponName;
		player.weaponName = "fists";
		player.weaponAttack = 0;
		monster.createStatusAffect("Bow Disabled",0,0,0,0);
		if(player.str < 80 && player.spe < 80) {
			monster.createStatusAffect("Attack Disabled",0,0,0,0);
			monster.createStatusAffect("Run Disabled",0,0,0,0);
			monster.createStatusAffect("Physical Disabled",0,0,0,0);
		}
		else {
			if(!player.canFly()) monster.createStatusAffect("Run Disabled",0,0,0,0);
		}
	}
	monster.createStatusAffect("Vapula",0,0,0,0);
	monster.short = "lusty demons";
	monster.long = "You're facing a group of thirty demons of various kinds.  Imps, incubi and succubi of all sizes and colors are encircling you, doing their best to show their genitals or their gigantic rows of breasts, often both.  You can see an impressive number of towering cocks, drooling pussies, and jiggling tits wiggle around as they move.  Most of the genitalia are monstrous, ridiculously disproportionate to the actual demons sporting them - to say nothing of the imps!  Some of the succubi are winking at you, blowing invisible kisses as they dance in circles around your pole.  Among them, you can easily spot the tallest demoness of the horde, Vapula; her perfect purple-skinned body, big perky boobs, luscious buttocks, fleshy lips, and seductive stare draw your attention like a magnet.  She's sporting a pair of magnificent wings and her abundant hair gives her face a fierce, lion-like appearance.  While her eyes ravage you with an insatiable hunger, she gives orders with the assurance of a well-established dominatrix.";
	//6 attacks: 5 from demons (10 damage each), 1 from Vapula (80 damage), 200 gems, 200 xp, 700 hp*/
	monster.bonusHP = 680;
	monster.lustVuln = .3;
	monster.HP = eMaxHP();
	monster.gems = 150 + rand(100);
	monster.level = 14;
	monster.XP = totalXP();
	eventParser(1);
}

function vapulaAI():void {
	monster.str = 40;
	monster.weaponAttack = 10;
	monster.createStatusAffect("attacks",4,0,0,0);
	eAttack();
	monster.str = 80;
	monster.weaponAttack = 40;
	eAttack();
	combatRoundOver();
}

	
//Loss scene/Submit (gangrape) (Z)
function loseOrSubmitToVapula():void {
	clearOutput();
	outputText("Vapula taunts you as she circles around you.  \"<i>Look at the slutty pet!  Ain't you a slutty pet?  Yes, you are!  Don't pretend you're not hungry for some fat demon cock, I know you are.</i>\"  As she speaks, the crowd gathers closer.  A few creatures show some temerity, giving you pinches and gropes as they near.  The cock-belted imp unties his tentacle; the horror wriggles and squirms as it drops to the ground and slithers toward you.  The tip of the absurdly long pecker inspects your body, pressing itself against your flesh, massaging you in the most sensual places, wetting you with sap-like pre-cum and teasingly grinding itself against your mouth, and then your " +assholeDescript());
	if(player.hasVagina()) outputText(", followed by your "+vaginaDescript(0));
	if(player.hasCock()) outputText(", before finally wrapping around your " +cockDescript(0)+ " and stroking it; the friction uncontrollably arouses you, and you find yourself reaching full erectness");
	outputText(".  As more and more hands start playing with your flesh, the succubus grabs your head and gives you a fierce kiss, literally crushing your lips under hers; her mouth tastes like wine and her tongue is driving you over the edge as it intertwines with yours.  Her strong natural scent makes you dizzy and you gradually lose control over your body.  \"<i>Don't worry, darling, it'll be all right...</i>\"");
	outputText("\n\nSoon you find yourself completely overwhelmed by hot demon hands and dicks touching every part of your body.  In no time at all two imps bend you over and forcefully ram your " +assholeDescript()+ " with their mammoth peckers.");
	//[ass stretching check]
	buttChange(60,true,true,false);
	outputText("  The double penetration is brutal, unexpected and painful.  Your insides are protesting vigorously against this rough treatment, even though you feel a tingle of pleasure gently tickling your colon at every thrust.  ");
	//[(no Buttslut)
	if(player.hasPerk("Buttslut") < 0) outputText("No!  You aren't supposed to enjoy it...  ");
	outputText("You try to cry out but as soon as your mouth opens it is filled with another dick, then a second one.  A third tries to push its way between the first two, stretching your cheeks and making you drool.  Seeing that the monstrous dong won't fit in your already double-stuffed mouth, its owner groans in frustration and proceeds to slap your cheek with it.  He is soon joined by other demons who find the idea very entertaining.");
	outputText("\n\nIt's a matter of minutes before a dozen hungry omnibuses and incubi are repeatedly cock-slapping your entire body, hitting every part of you with their heavy meat, grinding their rods against every fold and curve of your flesh and staining it with seminal fluids.  Your poor " +buttDescript()+ ", already abused by two giant pricks thrusting back and forth at an unnatural pace, is now the prey of numerous hands and full, erect dicks slapping it in every possible way, smearing it with pre-cum and sweat as they run across your tender skin.  You can't see anything: your eyesight has been blocked by a never-ending row of wriggling cocks.  Nor can you hear anything over the sound of a full horde of libidinous demons panting and moaning as they abuse their fuck-toy in an overwhelming orgy of pleasure; besides, a pair of imps are rubbing the tips of their dongs against your ears, as if they wanted to fill them with seed.");
	outputText("\n\nYou can't talk, muted as you are by a pair of fat red peckers stuffing your mouth and bumping against your throat as you unwillingly suck them off.  Your jaw hurts, your itching insides are driving you mad; your whole body is being bruised from the cock-slaps, your palms are forced to rub four shafts at the same time, and even as you pump, your fingers are occasionally grabbed and stuffed into wet fuck-holes, making a few succubi moan.  A tentacle dick brushes against you, then wraps around your limbs, slithering against your skin and leaving behind a trail of pre-cum on your torso and belly.");
	if(player.hasCock()) outputText("  It wraps around [eachCock] for a while, jerking it for a bit and rubbing its tip against yours.");
	//[if antennae]
	if(player.antennae > 0) outputText("  Your antennae are being harshly pulled and twisted; some imps, in a crazy show of libertinism, start inserting your sensitive peduncles down their bloated urethrae. The intimate friction and the sudden jolts when the internal walls slather your appendages in slick, hot pre-cum are driving you mad with irregular shots of unbearable pleasure.");
	//[if horns]
	if(player.horns > 0) outputText("  You feel your horns being used as leverage to slap your head with even more rock-hard dick.  The impacts stun you until your whole forehead feels numb and coated with a mixture of ballsweat and pre-cum.");
	//[if vagina
	if(player.hasVagina()) {
		outputText("\n\nYou suddenly feel a sharp sensation: your womanhood is finally being penetrated.");
		cuntChange(60,true,true,false);
		outputText("  A dick found a way into your " +vaginaDescript(0)+ " and is pushing further inside.  Wait, what's this?  A second, and then a third!  There's no way these titanic columns of flesh will... this is too much... you fear you will be torn in half, but at the last moment, you feel someone spilling the content of a flask over your nether-lips.  As if you had lost control of your " +vaginaDescript(0)+ ", it automatically starts leaking girl-cum in prodigious amounts, and you let out a stifled moan as a delicious shiver runs teasingly across your body.  Your fuck-hole widens under the corrupting effect of the weird mixture you were administered.  ");
		//[set vagstretch up a few levels]
		if(player.hasStatusAffect("Bonus vCapacity") < 0) player.createStatusAffect("Bonus vCapacity",0,0,0,0);
		if(player.statusAffectv1("Bonus vCapacity") < 200) player.addStatusValue("Bonus vCapacity", 1, 15);
		outputText("As soon as new space is created, it is immediately filled by a pussy-hungry cock.  The three cocks slide effortlessly inside you and start thrusting energetically, vying in intensity and ferocity with the peckers ramming your " +assholeDescript()+ ".  The penetration of both holes is almost too much too handle, but you finally get used to it as your own anal and vaginal muscles try their best to milk as much spunk as possible from these cum-tubes.  Even though you are being violated in every hole, the raw and powerful sensation is quite pleasurable; it feels so right to be used this way, so full of demon wang.  You don't have to focus on anything, just to enjoy the sheer amazing feeling of being pounded by many pistons at once.  You squirt over and over again as the dicks and the fluid force you into a series of wild female orgasms.");
		//[crank up vaginal wetness one level, why not?]
		if(player.wetness() < 5) player.vaginas[0].vaginalWetness++;
	}
	//[if cocks]
	if(player.hasCock()) {
		outputText("\n\nA soft brush against your " +cockDescript(0)+ " warns you that your crotch is going to get some more love.  At least four hands are caressing it, helping you rise and thicken until it can't grow anymore.  After a while of playful stroking, the hands are suddenly gone, only to be replaced by a fluid-gushing cunt.  It impales itself on your " +cockDescript(0)+ " at full force, driving a very whorish and high-pitched cry from its owner.");
		//[if more than 1 and less than 4 cocks]
		if(player.cockTotal() > 1) outputText("  She is soon joined by other horny girls, too eager to wait for a piece of your crotch to play with.  They all comfortably position themselves, positioning their pussy or anus atop each of your cocks before riding you like there's no tomorrow.");
		//[if 4 to 7 cocks]
		if(player.cockTotal() >= 4) outputText("  Nevertheless, they aren't satisfied with a single insertion and most grab hold of one of your extra cocks before forcefully stuffing it in their other hole, howling and thrashing all the more as they are penetrated a second time.");
		//[if 7 cocks or more]
		if(player.cockTotal() >= 7) {
			outputText("  Sadly, surrounded as you are, no one will be able to find extra room to ride your remaining cocks; fortunately, you feel  warm, long demonic tongues being pressed against your " +cockDescript(6));
			if(player.cockTotal() > 8) outputText(" as well as your remaining pricks");
			outputText(".  The tongues expertly lick your meat and wrap themselves around it, and questing lips give it multiple kisses before one pair suddenly loses patience and deepthroats you with voracity; the tightness of these lips makes them feel like a very efficient cock-ring.  However, it is hard to focus on the sweet warmth provided by these avid mouths when all your other cocks are being clamped by powerful, inhuman vaginal muscles.");
		}
		outputText("\n\nBetween every thrust, you feel hands working and polishing your shaft");
		if(player.cockTotal() > 1) outputText("s");
		outputText(", as if every inch had to be taken care of at every instant.  As you slide back into the pussy, the hands return to crawling over your body, caressing your groin and staining your belly with pre-cum - yours and others.");
		outputText("\n\nYou are ridden for a while, the hell-girls thrashing wildly and yelling in pure ecstasy as they reach their climax.  They release so many powerful orgasms you stop keeping track of them.");
	}
	//[if lactating breasts]
	if(player.lactationQ() > 0) outputText("\n\nLost in your feverish state of arousal, you feel your nipples harden and a thin trickle of milk comes out.  A couple of demons spot this new source of fluids and rush to your " +allBreastsDescript()+ ", wolfishly suckling them.  Their dexterous tongues keep teasing your nipples, stimulating you further as they drink your essence.  Your milk-udders are being roughly groped and licked by these careless creatures, oblivious of everything but your mounds.");
	outputText("\n\nEventually, your insane mix of violation-induced pleasure and pain proves too much for your wrecked body and your whole consciousness winds up as you brace yourself for your incoming climax.  Your eventual spasm is so strong that some of the demons lose the grip they have on you.  Your hands twitch, unintentionally squeezing the cocks pressing against them.  Your head bumps against a wall of dicks, and your nose lodges itself in a miraculously free pussy that was waiting its turn near your mouth.  You even manage to liberate your mouth from that duo of monster-sized members; as you gasp for some air, you can't help but let out a shrilling cry of pleasure.  You scream aimlessly; all the violations you've endured, every sensation inflicted upon your body is expressed in that helpless shriek.  Of course, you can't hear yourself screaming because of all the cum that has been unloaded onto your ears, but you don't care.  Your body is becoming a nexus of pleasure in this show of debauchery as unholy liquids are pumped in and out of it.  As you scream, your groin clenches and you climax with unequaled intensity.");
	//[if cocks]
	if(player.hasCock()) {
		outputText("  " + SMultiCockDesc() + " pulsates and throbs");
		//[[if balls]
		if(player.balls > 0) outputText(", and your balls swell and boil");
		outputText("; a gigantic spooge-flow pushes its way up your urethra and spurts outside in the waiting love-tunnels");
		if(player.cockTotal() > 7) outputText(" and mouths");
		outputText(".  The violent cumshot almost instantly produces a shiver of orgasm once again and vaginal walls contract furiously, determined to absorb as much of your baby-batter as possible.");
		//[if cum production is massive]
		if(player.cumQ() > 1500) outputText("  The effort appears to be vain, as the absurdly high volume you've ejected is enough to completely pack every hole; the remaining jism spills on the tainted ground, soaking it further.");
	}
	outputText("\n\nAfter what seems like hours of forceful penetration, the gigantic members inside you release a milky torrent of corrupted seed, completely packing your colon through your " +assholeDescript());
	if(player.hasVagina()) outputText(" and filling your womb to its maximum capacity");
	outputText(".  The remaining cum spurts outside and dribbles onto your [legs].  Your asshole clenches, squeezing the dongs inside you and milking their very last drops of spunk.");
	//[if vagina]
	if(player.hasVagina()) outputText("\n\nYour own " +vaginaDescript(0)+ " clenches too, doing its best to waste as little semen as possible.  Your muscles quiver as they feel the incoming last release.  Then, in climax, you squirt your own girl-cum, splattering the demon dicks with your juice.");
	//[if lactating breasts]
	if(player.lactationQ() > 0) outputText("\n\nThe combined efforts of a dozen demons proves too much for your poor " +chestDesc()+ " and your nipples let out a white creamy flood, which is immediately gobbled by thirsty imps.  ");
	else outputText("\n\n");
	outputText("Everywhere around you, people keep cumming and shooting ropes of jism.  In no time your entire body is drenched with spooge.  Your eyes and ears are completely covered with sticky goo, preventing you from hearing and seeing.  Still, you can feel penises being stuffed into your mouth again as they unload their unholy swill.  The taste is strong, hot, and salty, but not unpleasant.  You swallow until your belly swells, but you don't care; temporarily reduced to the instincts of breeding stock, you want more spunk and you suck it up as if your life depended on it.");
	outputText("\n\nYou keep oozing out fluids until you reach your own body's capacity.  When the flow of various juices starts to ebb, you relax, completely exhausted.  You simply lie there in a bed of cocks and naked flesh, abandoning all hope of struggling against the demons' will.  Of course, they aren't done yet.  A few seconds later - the time needed for everyone to switch positions - and they're at it again.  You are touched and caressed, filled and used again, and again, and again.  You black out.");
	//[Vapula Submissiveness raises by 10. If it reaches 100 or more, go on to the Vapula Slave Bad End. Otherwise Wake up scene. Additionally, if it is raised to 90 or more this way, display warning:]
	flags[VAPULA_SUBMISSIVENESS] += 10;
	if(flags[VAPULA_SUBMISSIVENESS] >= 90 && flags[VAPULA_SUBMISSIVENESS] < 100) outputText("\n\n<b>You're starting to get dangerously used to this kind of treatment.  Your holes are being stretched to accommodate monstrous sizes and don't hurt that much anymore.  You feel like you could stand this as long as you need to with ease... maybe it's time to stop volunteering?</b>");
	if(flags[VAPULA_SUBMISSIVENESS] >= 100) doNext(slaveToVapulaBadEnd);
	else if(player.hasStatusAffect("lostVillagerSpecial") >= 0) doNext(morningAfterRape);
	else doNext(wakeUpAfterDemonGangBangs);//WAKE UP
	stats(0,0,0,0,1,2,-100,3);
}

function wakeUpAfterDemonGangBangs():void {
	clearOutput();
	hours = 7;
	days++;
	outputText("When you wake up, you are alone, and your restraints are broken.  You are sloshing in a pool of stinky juices; your mouth and ears are still full of it.  Your whole body is covered with a thin white layer that must certainly be dried spooge.  Underneath, you're nothing but bruises and every movement seems to hurt.  A few meters away, outside the pit, you notice your items and your gear.  The village itself appears to be empty... your best assumption is that the residents are hiding, either from shame at having sacrificed you or from awkwardness at the prospect of talking to a sloshing, crusty cumdumpster.  Wearily, you head back to your camp.");
	//+med-high corruption, - libido, - toughness, - strength, +20 fatigue, high imp preg chance, slimefeed
	fatigue(20);
	slimeFeed();
	stats(-2,-2,-1,-1,1,1,100,3);
	if(inCombat()) eventParser(5007);
	else doNext(13);
	//PC is redirected to camp, next morning. No nightly camp scenes or dreams.
}
	
//Victory (Z)
function defeetVapulasHorde():void {
	clearOutput();
	if(flags[VAPULA_SUBMISSIVENESS] <= 0) {
		subdueVapula();
		return;
	}
	//Sacrificed and bound
	if(monster.hasStatusAffect("Attack Disabled") >= 0) {
	   if(monster.HP < 1) outputText("You grin wickedly as the last demons fall, defeated.  Some of the errant blows have broken and mangled the links of your chains, and you find you can get free with a bit of additional effort.");
		//[if won by Lust]
		else outputText("You grin wickedly as the demons give up the fight, too turned on to care about you.  One even begins unfastening your bindings, hopeful desperation glinting in her eyes as she attempts to entice you with her long, thick nipples and enormous, dripping gash.");
	}
	//Not
	else {
		if(monster.HP < 1) outputText("You grin wickedly as the last demons fall, defeated.");
		//[if won by Lust]
		else outputText("You grin wickedly as the demons give up the fight, too turned on to care about you.  One even has hopeful desperation glinting in her eyes as she attempts to entice you with her long, thick nipples and enormous, dripping gash.");
	}
	//[(requires genitals and and corr >60)
	if(player.cor > 60 && player.gender > 0) {
		outputText("\n\nDo you take advantage of them?");
		doYesNo(rapeZeVapula,noVapulaSex);
		return;
	}
	else {
		outputText("\n\nThough the display as they explore each other is somewhat arousing, you can't really get into it as you are, and simply use your new-found freedom to climb out of the hole.  It's too dark to return to the village now, so you head back to camp.");
		flags[VAPULA_SUBMISSIVENESS] -= 5;
		eventParser(5007);
	}
	
}
function noVapulaSex():void {
	clearOutput();
	flags[VAPULA_SUBMISSIVENESS] -= 5;
	eventParser(5007);
}
//Yes/
//[Yes: submissiveness is lowered by 10. No or auto-reject: submissiveness is lowered by 5.]
function rapeZeVapula():void {
	flags[VAPULA_SUBMISSIVENESS] -= 10;
	//Victory rape with penis [Anal Orgy and Bukkake] (NTR Vapula) (Z)
	if(player.hasCock()) {
		clearOutput();
		outputText("The demon horde struggles before you.  With a disdainful smile, you fully expose your genitals for everyone to see.  ");
		//[if cocks]
		if(player.hasCock()) outputText("\n\nYou gently stroke your " +cockDescript(0)+ ", bringing it to full erectness.  ");
		//[if vagina]
		if(player.hasVagina()) outputText("You stick a finger in your own " +vaginaDescript()+ " in order to lubricate it.  ");
		outputText("The defeated horde watches you touch yourself with avid, almost desperate eyes.  You keep teasing yourself, saving your lust for the torrid storm of rape you're about to unleash on the poor creatures who dared attack you.  You walk among the battered bodies, looking for the prey that will best suit you; then you find her.  Vapula is lying here, her purple skin masking ");
		if(monster.HP < 1) outputText("the many bruises she's received");
		else outputText("the constant flushing due to intense arousal");
		outputText(".  You harshly grab her hand and grunt, \"<i>On your feet, cunt.</i>\"  She is too stunned to protest and weakly stands up, her leather straps torn to completely reveal her voluptuous body.  You feel the sudden urge to take her right now and fuck her like a ");
		if(player.hasVagina()) outputText("bitch in heat");
		else outputText("centaur in rut, abusing and filling her teasing cunt and ass with every protuberance you have");
		outputText(".  However, you have better plans for her.");
		
		outputText("\n\nYou yank on her arm and lead her to the pole you were previously attached to.  Using the lashings and her own straps, you chain her in such a way that she's forced to stand up and look at you, then tie up her arms and legs to forbid escape.  When you're done, she is facing you, a glint of defiance in her eyes.  Her tender H-cups tits stand firmly as if to provoke you, and her woefully exposed nether-lips seem to be only waiting for you.  Gods, this succubus is clearly begging to be taken!");
		outputText("\n\nFor a moment as she tries her best to be as proud as possible in such an uncomfortable situation; you savor her helplessness, then decide to tease her a bit; first, a fiery kiss, probing the inside of her mouth with your tongue.  Next, you toy with her nipples, slap her plush ass and cup her tits, enjoying the supple texture of her tender flesh.  You keep molesting her body until she can't help but moan like a whore under your dexterous ministrations.  Her vagina is now freely spilling its juice; she keeps squirming against her restraints, uncontrollably shaken by her arousal.");
		outputText("\n\n\"<i>What are you waiting for?</i>\" she moans.  \"<i>Fuck me already, you dirty bastard.  Go ahead, stuff me.  Why don't you get down to business?  Are you afraid that you might last only a minute?  What are you, a poor little sissy with no stamina?  You innocent little " + player.mf("manlet","maiden") + ", I will–</i>\"");
		outputText("\n\nSLAP!  The back of your hand impacts her cheek, muting her for a moment and opening the way for your own comment.  \"<i>Shut up, whore.  I'm the one deciding who fucks who here.  You want sex?  Don't worry, you'll see plenty soon.</i>\"");
		outputText("\n\nWith lazy nonchalance you grab hold of another demon crawling at your feet, another succubus; although not so tall or big-breasted as Vapula, her provocative curves are a delight to your eyes.  You bend her over and, without ceremony, start working her tight pucker, filling her insides with your " +cockDescript(0)+ ".");
		if(player.cockTotal() > 1) outputText("  Seeing that she has extra room left, you grab another of your dongs and put it at the entrance of her dripping cunt before forcing it in.");
		outputText("\n\nYou keep thrusting back and forth, treating the worthless horned-girl like a disposable cock-sleeve. As you pump in and out of her, you look at Vapula, warning her.  \"<i>Don't turn your head.  If you ever look away or close your eyes, you will regret it.</i>\"  Overwhelmed by your dominance and subdued by the defeat, Vapula can only nod.  You work the succubus's lush hole");
		if(player.cockTotal() > 1) outputText("s");
		outputText(" in front of the once-powerful dominatrix, grunting and panting as you accelerate the pace, until you finally reach your climax and release rope after rope of jism in your fuck-toy, completely packing her backdoor");
		if(player.cockTotal() > 1) outputText(" and her love-tunnel");
		outputText(".");
		//[if massive cum production]
		if(player.cumQ() > 1000) outputText("  Some of it spurts by little jets outside of her, even as she instinctively contracts her muscles to keep as much spooge as possible and her belly accomodates by bloating out absurdly.");
		outputText("  Needless to say, watching this rough ");
		if(player.cockTotal() == 1) outputText("anal");
		else outputText("double-penetration");
		outputText(" session has brought Vapula to a new level of arousal; she is struggling to free her arms and finger herself, but her tight restraints only allow her to wriggle uncomfortably.  Her pussy is gushing of its own and she whimpers from time to time, unable to control her lust.");
		outputText("\n\nYou throw away your expendable");
		if(player.cumQ() > 1000) outputText(", expandable");
		outputText(" cumdumpster and grab another slut.  This time you feel like you could use a blowjob to clean off the demonic sweat and slime from your cock; you forcefully open her jaw and shove your " +cockDescript(0)+ " down her throat without any care.  The sudden influx of dickflesh blocking her air-flow makes her choke and cough, but a withdrawal and a good cock-slap reminds her of her place.  \"<i>You fucking bitch!  You goddamn worthless slut!  What good are you if you can't even give proper head?  Lick, you whore!  I want your tongue all over my crotch!  You can breathe when you've properly moistened my ");
		if(player.balls > 0) outputText("balls");
		else outputText(player.skin());
		outputText("!</i>\"  The poor demoness, cheek stained with semen, mutters an apology and proceeds to lick your " +cockDescript(0)+ ", suckling the tip, ");
		if(player.balls > 0) outputText("fondling your " +ballsDescriptLight()+ ", ");
		//[if multicocks] 
		if(player.cockTotal() > 1) outputText("alternatively deepthroating or jerking every cock of yours, ");
		outputText("warming up your dickflesh with her demonic tongue.  You enjoy her ministrations while staring Vapula in the eyes; she has trouble looking back at you as her body trembles and her eyes widen at your sheer display of depravity.  Your semen-dribbling shaft");
		if(player.cockTotal() > 1) outputText("s harden and thicken ");
		else outputText(" hardens and thickens ");
		outputText("again as the demoness sucks you off; Vapula can't help but take a quick glance at it, but you pretend not to notice.  After all, she's only teasing herself for you.");
		outputText("\n\n\"<i>Please... take me,</i>\" she whimpers.  \"<i>I don't care if I only get your leftovers.  Take me in any way you like.  I'll give you head, I'll give you my ass, anything.  Just fuck me!  My pussy is so horny it hurts!</i>\"");
		outputText("\n\n\"<i>Piss off, bitch.</i>\"");
		outputText("\n\nYou seize your fuck-toy by the waist and, turning her, gratuitously ram her asshole, her face right next to Vapula's pussy and staring at it with timid yet longing eyes.  She cries in pleasure and darts her tongue out; your toy almost manages to take a lick before you impale her all the way back on your " +cockDescript(0)+ ".  After a few more mad thrusts, you feel another wave of seed flooding your urethra and spurting inside the slut's colon.  But this time, you pull out your cream-spraying pecker");
		if(player.cockTotal() > 1) outputText("s");
		outputText(" and aim at Vapula, splattering her body with your spunk.  Words cannot describe the sheer triumph you feel.  You burst into laughter as you drench that unworthy bitch with your seed.");
		outputText("\n\nGods, this is only the beginning.  Your next target is an unconscious imp with a monstrously thick pecker.  You lift him by his arms and jam his little pucker on your " +cockDescript(0)+ ", making sure his own cock points toward Vapula.  The sudden anal penetration wakes him up and makes his dick, already half-mast from his perverted imp dreams, instantly rock hard.  You begin stroking his dick with enthusiasm as you violate his insides, your own cum serving as lube for the rough anal penetration.  The tight confines of the little red creature as well as your furious handjob prove too much for both of you and in no time you are both ejaculating in chorus.  Milky torrents burst from his mammoth member, further soaking the horny ex-dominatrix.");
		outputText("\n\nBut you're not satiated yet.  You grab another demon, fuck it rough and fast; when you know you're about to reach another orgasm, you pull out before cumming what your body can manage on Vapula's body.  You fuck another creature this way.  And another, and another...  When whatever you're fucking happens to have a cock, you ruthlessly rub it until it squirts everything it has on the tied succubus.  ");
		if(player.cockTotal() > 1) outputText("In an unholy sex-frenzy, you want more; you start grabbing creatures by groups and alternatively pump in and out of their asses with your " +cockDescript(0)+ ", always hungry for more anal.");
		outputText("\n\nVapula is now entirely covered in a thick white liquid blanket.  The contact of all this hot seed against her untouched skin is driving her crazy; after some futile squirming in a desperate attempt to quench her burning pussy, she is now openly sobbing in frustration.");
		outputText("\n\n\"<i>You're... you violate my pets, yet you won't deign to touch me.  Why?  D-don't you like my body?  Don't you like my cunt?  Look, it's aching for a cock like yours.  It needs you.  I need your meat inside of me, please fuck me fuck me fuck me fuckmefuckme... <b>why won't you fuck me?  Please, I need to cum! Please!</b></i>\"");
		outputText("\n\nHa!  Without a word, you keep thrusting your " +cockDescript(0)+ " inside your current hot hole while staring at her.  You resolutely ignore her, determined to let her see you fuck the entirety of her horde.  The various demons in your grasp appear resigned to be used as mere fuck-toys for your sole enjoyment – and their mistress' torment.  Most of them barely struggle as you ferociously stretch their interior; instead, they moan like the bunch of bitches they truly are, letting their mistress know that a dominant stud is giving them more pleasure than she ever did.");
		outputText("\n\nAt last, you reach the limit of your prodigious stamina.  When you're done pounding the last untouched hole in the pit, when your " +cockDescript(0)+ " is done squirting its ultimate drop of goo over the wanton succubus, you relax and drop the fuck-toy you were using.  Your " +cockDescript(0)+ " is finally softening and you have no further use of any broken toy in the pit.  All but one...");
		outputText("\n\nWhen you walk up to Vapula, she is barely recognizable. Her will is utterly broken and she seems considerably mollified.  Your repeated denials made her mind collapse; she's but an empty shell driven crazy by her burning unsatisfied lust.  With a content smirk, you lean down and give her a tender kiss, enjoying the taste of secondhand sexual juices coating her lips.  You whisper to her, \"<i>Good night, beauty.</i>\"  She doesn't seem to hear your taunt.");
		outputText("\n\nA few meters away, outside the pit, you notice your items and your gear.  The village appears to be deserted.  Considering these demons will have a hard time threatening anyone with white goo oozing out of their absurdly stretched holes, you let them rest, wallowing in a pool of mixed spunk.  You pick up your belongings and head back to camp.");
		if(silly()) outputText("  As you look back, you snicker, \"<i>Ass for ass, assholes.</i>\"");
		//+med-high corruption, + strength/cons, -10 libido
		stats(1,1,0,0,-4,0,-100,4);
	}
	//Victory rape using vagina/anus [Take Dicks in All Holes](Z)
	else {
		clearOutput();
		outputText("The demon horde struggles before you.  With a disdainful smile, you fully expose your genitals for everyone to see.  ");
		//[if cocks]
		if(player.hasCock()) outputText("\n\nYou gently stroke your " +cockDescript(0)+ ", bringing it to full erectness.  ");
		//[if vagina]
		if(player.hasVagina()) outputText("You stick a finger in your own " +vaginaDescript()+ " in order to lubricate it.  ");
		outputText("The defeated horde watches you touch yourself with avid, almost desperate eyes.  You keep teasing yourself, saving your lust for the torrid storm of rape you're about to unleash on the poor creatures who dared attack you.  You walk among the battered bodies, looking for the prey that will best suit you; then you find her.  Vapula is lying here, her purple skin masking ");
		if(monster.HP < 1) outputText("the many bruises she's received");
		else outputText("the constant flushing due to intense arousal");
		outputText(".  You harshly grab her hand and grunt, \"<i>On your feet, cunt.</i>\"  She is too stunned to protest and weakly stands up, her leather straps torn to completely reveal her voluptuous body.  You feel the sudden urge to take her right now and fuck her like a ");
		if(player.hasVagina()) outputText("bitch in heat");
		else outputText("centaur in rut, abusing and filling her teasing cunt and ass with every protuberance you have");
		outputText(".  However, you have better plans for her.");
		
		outputText("\n\nYou yank on her arm and lead her to the pole you were previously attached to.  Using the lashings and her own straps, you chain her in such a way that she's forced to stand up and look at you, then tie up her arms and legs to forbid escape.  When you're done, she is facing you, a glint of defiance in her eyes.  Her tender H-cups tits stand firmly as if to provoke you, and her woefully exposed nether-lips seem to be only waiting for you.  Gods, this succubus is clearly begging to be taken!");
		outputText("\n\nFor a moment as she tries her best to be as proud as possible in such an uncomfortable situation; you savor her helplessness, then decide to tease her a bit; first, a fiery kiss, probing the inside of her mouth with your tongue.  Next, you toy with her nipples, slap her plush ass and cup her tits, enjoying the supple texture of her tender flesh.  You keep molesting her body until she can't help but moan like a whore under your dexterous ministrations.  Her vagina is now freely spilling its juice; she keeps squirming against her restraints, uncontrollably shaken by her arousal. The rest of the defeated horde watch, barely daring to breathe.");
		outputText("\n\n\"<i>What are you waiting for?</i>\" Vapula snarls.  \"<i>Use me already, you filthy bitch.  Shove your pussy into my face, let me lick your nasty juices, rub it all over me if that's the best you can do.  You haven't thought the logistics of this through, have you, cunt?  Or maybe you're too afraid.   Maybe you just need some cock up you, to remind you who-\"</i>");
		outputText("\n\nSLAP!  The back of your hand hits her across her face, muting her for the moment you need to lay down the rules.  \"<i>Shut up, whore.  I'm the one deciding who fucks who here.  And what an interesting idea you've given me.  Let's find out who wants what, shall we?</i>\"");
		outputText("\n\nWith lazy nonchalance you grab hold of another demon crawling at your feet, an incubus; shorter and younger than Vapula, his tight, pert body is a delight to your eyes.  Without ceremony you shove him to the ground and grind your " +vaginaDescript()+ " into his crotch.  He looks at you, semi-comatose and bewildered, as you get a rise out of his dick, which hardens against your damp strokes.  You pin him down as you sink onto his red length, sighing as you rapidly engulf him, then begin to ride him ruthlessly.  ");
		cuntChange(40,true,true,false);
		if(player.vaginalCapacity() > 80) outputText("His cock is lost in your vast cunt and you work him as hard as you can to feel him against your walls, his body convulsing and dazed eyes rolling against the wet, savage rape.  ");
		outputText("You keep thrusting back and forth, treating the worthless horned boy like a disposable dildo.  As you pump him, you look at Vapula, warning her, \"<i>Don't turn your head.  If you ever look away or close your eyes you will regret it.</i>\" Overwhelmed by your dominance and subdued by the defeat, Vapula can only nod.");
		outputText("\n\nYou keep working the incubus's hot cock in front of the once-powerful dominatrix, panting as you accelerate the pace until you finally reach your climax, clenching your thighs tightly to his fit body as your " +vaginaDescript()+ " clenches and spasms.  ");
		//[if squirter] 
		if(player.wetness() >= 5) outputText("The sound of spattering fluid fills the air as your cunt spurts its juices around the incubus's cock, coating him in your fragrant slime.  ");
		outputText("Against your relentless milking pressure he stands no chance and he moans raggedly as he cums in tandem, still incapable of moving his body as your mixed juices dribble down him.");
		outputText("\n\nNeedless to say, watching this rough session has brought Vapula to a new level of arousal; she is struggling to free her arms and finger herself, but her tight restraints only allow her to wriggle uncomfortably.  Her pussy is gushing of its own accord and she whimpers from time to time, unable to control her lust.");
		outputText("\n\nYou throw your expendable cock toy to one side and grab another slut, this time a succubus.  Your semen-dribbling cunt is now in need of a cleaning, and without any ado you sit yourself straight down onto her face, banging the back of her head against the ground.  She whines into your " +vaginaDescript()+ ", to which you respond by pulling her hair.  \"<i>You fucking bitch!  You worthless slut!  What good are you if you can't even munch rug properly?  Lick, you whore!  I want your tongue to clean up what your useless fuckhead of a friend couldn't keep to himself.</i>\"  The poor demoness mutters an apology and proceeds to lap up the juices drooling out of your hole, licking your labia and mons clean of what the incubus left, darting her wet muscle across your " +clitDescript()+ " before reaching into your vagina, carefully teasing out and drinking every drop of jizz she can find, making your own juices run afresh.  You enjoy her ministrations while staring Vapula in the eyes; she has trouble looking back at you as her body trembles and her eyes widen at your sheer display of depravity.  Your " +nippleDescript(0)+ "s harden");
		if(player.biggestTitSize() >= 2) outputText(" and your " +breastDescript(0)+ " bounce gently");
		outputText(" as you grind your snatch into the succubus's face; Vapula can't help but take a quick glance at your oozing, slippery cunt, but you pretend not to notice.  After all, she's only teasing herself for you.");
		outputText("\n\n\"<i>Please...take me,</i>\" the tied demon whines.  \"<i>I don't care if I only get your leftovers.  Take me in any way you like.  I'll lick your cunt, I'll scissor you, I'll magic you a strap-on, anything.  Just fuck me; my pussy is so horny it hurts!</i>\"");
		outputText("\n\n\"<i>Piss off, bitch.</i>\"");
		outputText("\n\nYou feel another high coming as you thrust harder and harder into the succubus's mouth; her eyes look timidly at an upside down Vapula as you ride her slippery tongue to another clenching climax.  Rather than sit down for it this time you raise yourself up and stare gloatingly at the dominatrix as a small torrent of semen-mingled girlcum gushes out of you and spatters all over the tied succubus.  The demon is so far past it she drinks and chokes over what you give her.  What is in Vapula's eyes as she watches this is something between total horror and raging thirst, and it fills you with incredible triumph.");
		outputText("\n\nGods, this is only the beginning.  You sashay into a beaten huddle of incubi and imps.  One of the more aware ones even tries to crawl away at your approach; you put an immediate stop to this by grabbing his bulging quartet of balls.  Holding him entirely at your mercy this way, you use your other hand to rub his monstrously thick pecker, quickly making it bulge with pressure.  Again you push the gasping, quaking incubus onto his back and guide him into your gaping pussy; your eyes catch those of an imp whose mouth is open with disbelief and whose dog dick is standing to attention.");
		outputText("\n\n\"<i>You!</i>\" you snap. \"<i>Fuck my ass.  Do a good job or I'll wring your neck.  The rest of you worthless spare pricks... gather around.</i>\"  You grip the incubus beneath you with your " +hipDescript()+ " as small, uncertain hands grasp you around your waist and something hot oozes moisture into your " +assholeDescript()+ ".  You thrust forwards and then backwards, simultaneously working the incubus cock whilst driving the imp's meat into your bowels.");
		buttChange(60,true,true,false);
		outputText("  Around you more dicks present themselves as other demons slowly draw closer, and with the cock inside you rubbing your sensitive inner walls backwards and forwards you enthusiastically grab two other turgid members and pump them in tandem.  One of the dicks you have grabbed is a sensitive cat dick and the owner is quickly moaning as you fingers brush his hooks; as you feel him reach his peak you ruthlessly jerk him around so he is facing Vapula, and he helplessly spurts his load onto her jiggling frame.  The imp begins to pump harder as he finds his rhythm, stretching your ass wide as he takes you to his plug, rubbing against the huge incubus cock trapped in your " +vaginaDescript(0)+ ".  You laugh breathlessly and manically as the other demon in your grasp helplessly falls over his own peak, further soaking the horny ex-domniatrix.");
		//[cunt nipples] 
		if(player.hasFuckableNipples()) outputText("  Your freakish nipples moisten with excitement to the smell of man juice, and you feel your libido ratcheting up even higher.  Bending forward, you grab two other imps with smaller dicks, quickly guiding their lengths into your nipplecunts; they are small enough that you can mash their bodies against your soft flesh, doing all the work for them as your sensitive nubs are penetrated.");
		outputText("\n\nVapula stares at you through the creamy liquid which now covers her face and tits.  The contact of all this hot demon seed against her untouched body is driving her crazy; after some futile squirming in a desperate attempt to quench her burning pussy, she is now openly sobbing in frustration.");
		outputText("\n\n\"<i>You're.. you violate my pets... yet you won't deign to touch me.  Why?  D-don't you like my body?  Don't you like my cunt?  Please fuck me fuck me fuck me fuckmefuckme....<b>why won't you fuck me?  Please, I need to cum! Please!</b></i>\"");
		outputText("\n\nUnable to break your gaze, she stares at you as with slow, gloating exaggeration you put your sticky fingers into your mouth and moan, clenching down on the dicks deep in your holes as you do.  The incubus and imp");
		if(player.hasFuckableNipples()) outputText("s");
		outputText(" gasp as they spurt their loads, filling you with inhuman warmth; four balls push into overload and the incubus beneath you spasms his hips uncontrollably as he releases surge after surge of cum until your gushing quim begins dribbling the fluid back onto him.  You sigh and clench your muscles to hold as much of the delicious hot fluid in as possible before lifting yourself off the insensate incubus and sashaying towards Vapula.  You stroke the line of her jaw and gently touch her inner thigh as you begin to loosen her bonds.  She sobs with relief as you go about the task.");
		outputText("\n\n\"<i>Oh thank you, thank you... please do it to me now!  I've been bad, I know, I've had my punishment now and I want to be good for you, and... wait, what are you doing?</i>\"  Freed of the chains, she's only shoved onto her knees; you pin her hands behind her whilst standing over her head, and then, with a blissful sigh, release your muscles.  Vapula weeps openly as you pour an unholy mixture of demonic cum and your own juices out of your cunt");
		if(player.hasFuckableNipples()) outputText(", teats, ");
		else outputText(" ");
		outputText("and ass onto her, the copious tainted seed mixing with her tears.  Once it's all gone you wipe yourself with her hair, hoist her back into position and lash the restraints back into place.  Frankly, the process and the sight of her have made you even more turned on.  You lick your lips and turn back to the subdued demonic horde at your disposal.");
		outputText("\n\nWithout a word, you mercilessly fuck every demon you can lay your hands on, riding faces, sucking manpoles dry with your insatiable holes, pumping more and more spooge onto Vapula with your grasping hands and pussy.  The various demons in your power appear resigned to be used as mere fuck-toys for your sole enjoyment – and their mistress' torment.  Most of them barely struggle as you ferociously milk them; instead, they moan like the bunch of bitches they truly are, letting their mistress know what a beta female she is in comparison to you.  You repeat the shower once, twice, thrice; by the end Vapula's hair is a sopping mat of white.");
		outputText("\n\nAt last, you reach the limit of your prodigious stamina.  When you're done working the last untouched cock in the pit, when your " +vaginaDescript()+ " is done squirting its ultimate drop of fluid over a wanton succubus, you relax.  Your gaping cunt aches pleasantly and you have no further use of any broken toy in the pit.  All but one...");
		outputText("\n\nWhen you walk up to Vapula, she is barely recognizable.  Her will is utterly broken and she seems considerably mollified.  Your repeated denials made her mind collapse; she's but an empty shell driven crazy by her burning unsatisfied lust.  With a content smirk, you lean down and give her a tender kiss, enjoying the taste of secondhand sexual juices coating her lips.  You whisper to her, \"<i>Good night, beauty.</i>\"  She doesn't seem to hear your taunt.");
		outputText("\n\nA few meters away, outside the pit, you notice your items and your " +player.armorName+ ". The village appears to be deserted. Considering these demons will have a hard time threatening anyone with white goo oozing out of their absurdly milked urethras, you let them rest, wallowing in their pool of mixed spunk.  You pick up your belongings and head back to camp.");
		//+med-high corruption, + strength/cons, -10 libido, slimefeed, imp preg check
		stats(1,1,0,0,-4,0,-100,4);
		slimeFeed();
		player.knockUp(1,432);
	}
	//PC is redirected to camp, next morning. No nightly camp scenes. 
	hours = 7;
	days++
	eventParser(5007);
}

//Main Owca Village menu (Z)
//[displayed after the second encounter text and right away in subsequent encounters]
function owcaMainScreenOn():void {
	clearOutput();
	if(flags[REBECCS_LAST_PLEA] == 1 && !vapulaSlave()) {
		rebeccsLastPlea();
		return;
	}
	if(flags[OWCAS_ATTITUDE] <= 5 && flags[OWCA_ANGER_DISABLED] == 0 && flags[OWCA_SACRIFICE_DISABLED] == 0) {
		desperateVillages();
		return;
	}
	//Desperate plea
	if(rand(10) <= 2 && flags[DAYS_SINCE_LAST_DEMON_DEALINGS] >= 7 && flags[OWCA_SACRIFICE_DISABLED] == 0) {
		//(30% chance of spawning upon going to the village once a week has passed since last demon fight)
		//should happen instead of the normal village menu every week
		outputText("The village shows unusual signs of activity.  As you walk down the main road, people are all looking at you uncomfortably.  Some try to approach you but back off awkwardly at the last moment.  You don't understand until you stumble upon Rebecc, who seems on better terms with you than the rest of the village; she is displaying a worried face.");
		outputText("\n\n\"<i>" +player.short+ ", this is a difficult thing to request, especially when you've done so much for us already.  But... the demons are insatiable, of course.  They want a sacrifice every now and then, you know.</i>\"  As you slowly come around to what must be next, she grows more and more anxious.  \"<i>Could you... this time too, please?  Oh, I know I'm asking too much, but it's not us... it's them.  Please, we need your help again!</i>\"");
		outputText("\n\nThis time you fully understand the consequences of another sacrifice.  Do you comply?");
		//Yes: Leads to Accept Plea scene. Attitude is raised by 5.
		//No: Leads to Refuse Plea scene. Attitude is lowered by 10.
		doYesNo(3608,declineRebeccsPlea);
		return;
	}
	//[if attitude > 80]
	if(flags[OWCAS_ATTITUDE] > 80) outputText("Villagers greet you as you arrive, praising your courage and your heroism.  People shake your hands or ask you to kiss them, as if they hoped your nobility were somehow contagious.  Once they're done complimenting and flattering you in every way possible, they leave you to your business.");
	//[if 60<=attitude<80]
	else if(flags[OWCAS_ATTITUDE] > 60) outputText("Villagers greet you with a friendly smile as you arrive.  Some approach you and thank you for what you've done, before leaving awkwardly.  They're obviously not used to strangers.");
	//[if 40<=attitude<60]
	else if(flags[OWCAS_ATTITUDE] > 40) outputText("Villagers seem to accept your presence without comment now; though none go out of their way to greet you, neither do they avoid doing so when you pass by.");
	//[if 20<attitude <= 40]
	else if(flags[OWCAS_ATTITUDE] > 20) outputText("Villagers keep looking at you uncomfortably; no one seems to be willing to talk to you apart from Rebecc, your friend.");
	//[if attitude <= 20]
	else outputText("Villagers here appear to be openly hostile.  You keep hearing muffled whispers as you pass by, and people look at you rancorously.  They don't bother you, though.");
	//end variable display
	outputText("  The village is rather small.  A dozen humble thatched cottages are standing here and there, linked by dirt tracks and enclosed with small palisades.  There seems to be very little activity.");
	outputText("\n\nAt the end of the main road you notice the pit and the pole standing at the middle of it.  It looks rather sinister, reminding you of the permanent curse that lies on the villagers.  It is still unguarded.");
	//[if a week has passed since last sacrifice]
	if(flags[DAYS_SINCE_LAST_DEMON_DEALINGS] == 7 && flags[OWCA_SACRIFICE_DISABLED] == 0) outputText("  A week");
	else if(flags[DAYS_SINCE_LAST_DEMON_DEALINGS] > 7 && flags[OWCA_SACRIFICE_DISABLED] == 0) outputText("  More than a week");
	if(flags[DAYS_SINCE_LAST_DEMON_DEALINGS] >= 7 && flags[OWCA_SACRIFICE_DISABLED] == 0) outputText(" has passed since the last offering to the demons; guarding the pit would certainly help improve your relations with the little town's denizens.");
	//Option: 
	var pit:int = 0;
	var herd:int = 0;
	var tavern:int = 0;
	if(hours >= 16 && flags[OWCA_SACRIFICE_DISABLED] == 0) {
		//Pit. Requires 16:00 or later. Leads to the night gangbang (with possible fight) scene, this time fully equipped and clothed. Attitude is raised by 3.
		pit = 3625;
	}
	if(flags[OWCAS_ATTITUDE] >= 50) {
		outputText("\n\nBeyond the tiny hamlet you see herders guarding a considerable amount of sheep.  You could probably join them and ask them for work.");
		herd = 3624;
		//Option: Herds, needs 50 attitude.
	}
	outputText("\n\nRebecc's house is nearby, and her door is open. She would probably welcome the chance to wash away any taint you've received from your time in the pit.");
	//Option: Rebecc. Leads to Rebecc Menu
	if(flags[OWCAS_ATTITUDE] >= 10) {
		outputText("\n\nA tavern appears to be open; various Owca folk are drinking and chatting in it.  They give you friendly waves when you make eye contact.");
		//Option: Tavern. Leads to the Tavern, needs 10 attitude
		tavern = 3618;
	}
	//[Pit][Herds][Rebecc][Tavern]
	simpleChoices("Pit",pit,"Herds",herd,"Rebecc",rebeccMenu,"Tavern",tavern,"Leave",13);
}
//Tavern (Z)
function owcaTavern():void {
	clearOutput();
	outputText("The tavern is nice and cozy; there are a few tables and chairs scattered around in no ordered pattern, and most clients here appear to belong to the same species.  By the crude wooden bar, you see a list of all the current drinks on sale:\n<i>");
	//SheepMk
	var milk:Number = 3637;
	outputText("\nSheep Milk Bottle: " + (180 - flags[OWCAS_ATTITUDE]) + " gems");
	if((180 - flags[OWCAS_ATTITUDE]) > player.gems) milk = 0;
	
	var goblin:Number = 3635;
	outputText("\nGoblin Ale: " + (60 - Math.round(flags[OWCAS_ATTITUDE]/2)) + " gems");
	if((60 - Math.round(flags[OWCAS_ATTITUDE]/2)) > player.gems) goblin = 0;
	
	var brew:Number = 3636;
	if(rand(10) > flags[OWCAS_ATTITUDE]/10) {
		outputText("\nBro Brew: 2000 gems");
		if((2000) > player.gems) brew = 0;
	}
	else brew = 0;
	
	var cum:Number = 3634;
	outputText("\nMinotaur Cum: " + (300 - flags[OWCAS_ATTITUDE]) + " gems");
	if((300 - flags[OWCAS_ATTITUDE]) > player.gems) cum = 0;
	outputText("</i>");
	simpleChoices("Sheep Milk",milk,"Goblin Ale",goblin,"Bro Brew",brew,"MinotaurCum",cum,"Back",gangbangVillageStuff);
}

function owcaBuySetup(item:String = "MinoCum"):void {
	if(item == "SheepMk") buyOwcaShit(item,(180 - flags[OWCAS_ATTITUDE]));
	else if(item == "Gob.Ale") buyOwcaShit(item,(60 - Math.round(flags[OWCAS_ATTITUDE]/2)));
	else if(item == "BroBrew") buyOwcaShit(item,2000);
	else buyOwcaShit(item,(300 - flags[OWCAS_ATTITUDE]));
}
function buyOwcaShit(bleh:String = "MinoCum",price:Number = 0):void {
	clearOutput();
	player.gems -= price;
	statScreenRefresh();
	outputText("The bartender hands you a bottle and grabs your gems before attending other clients, leaving you to your own business.\n\n");
	shortName = bleh;
	menuLoc = 25;
	takeItem();
}
	
//Herds (Z)
function herds():void {
	clearOutput();
	outputText("The herders greet you warmly.  \"<i>Welcome, champion!  It is indeed a pleasure to have the honor to talk to such a noble and revered hero.</i>\"  You reply with equal grace and ask in a more formal tone if there's anything you can do to help them out.");
	outputText("\n\n\"<i>Well, our sheep badly need to be sheared and we could really use an extra pair of hands to get the work done.</i>\"  The herder proceeds to hand you some tools, and redirects you to a group of villagers working actively.  You rapidly join them and soon enough you are having a pleasant conversation, chatting and laughing as you collect the wool, so much so that you don't see where time goes; in what seems like minutes you're already done.");
	//attitude +5, int +1
	flags[OWCAS_ATTITUDE] += 5;
	if(flags[OWCAS_ATTITUDE] > 100) flags[OWCAS_ATTITUDE] = 100;
	stats(0,0,0,1,0,0,0,0);
	//[if attitude > 70]
	if(flags[OWCAS_ATTITUDE] > 70) {
		outputText("\n\nThe villagers thank you for your hard work and one of them hands you a bottle of sheep milk.  \"<i>'Tis good for your health.  Don't worry, it won't... mutate you.</i>\"\n\n");
		shortName = "SheepMk";
		menuLoc = 2;
		takeItem();
	}
	else doNext(13);
}

//Pit (Z)
function zePit():void {
	clearOutput();
	outputText("You announce to all the villagers present that you're going to guard the pit as well as the village's entrance against the demons, trusting them to spread the news; they seem glad that you took this initiative on your own.  Checking your equipment, you head toward the pit, ready to stand your ground against the lewd horde.");
	//Redirects to the Dusk Transition Scene, then to a combat with full equipment and weapons. Loss/Victory scenes as usual.
	doNext(3611);
}

//Rebecc Menu (Z)
function rebeccMenu():void {
	clearOutput();
	outputText("You knock and step into the old shack, accustoming yourself to the meager light.  As soon as you close the door behind you, you spot Rebecc stepping out of a little backroom.");
	outputText("\n\n\"<i>"+player.short+ "!  You came!  I was just preparing a hot bath.  My poor darling, you must have gone through a really perilous ordeal.  Here, do you want to get cleaned up?</i>\"");
	//Option: Appearance: Leads to Rebecc Descrpition.
	//Option: Bath: Leads to Rebecc Bath Scene.
	//Option: Rape: Leads to Rebecc Rape scene. Ends the quest. Requires sizable corruption score.
	//Option: Leave: Redirects PC to Owca Village.
	//[Appearance][Bath][Leave][Surprise Sex!]
	var sex:int = 0;
	if(player.cor >= 66) {
		sex = 3629;
		outputText("\n\nYou could try and force yourself on her, but you might not be welcome in town after...");
	}
	simpleChoices("Appearance",rebeccAppearance,"Bath",rebeccBathScene,"",0,"Surprise Sex",sex,"Back",gangbangVillageStuff);
}
//Rebecc Appearance (Z)
function rebeccAppearance():void {
	clearOutput();
	outputText("Rebecc is a 5-foot, 7-inch sheep-girl, with a cute human visage decorated by two little nubby horn protrusions and plush and fuzzy curled white hair that cascades down over her shoulders.  Her face is expressive, with her glinting blue eyes and avid mouth accurately reflecting her whole range of emotions.  Her complexion is extremely pale, although the exposed parts of her body are rather tanned due to hours of labour under the scorching sun.  She is currently wearing a coarse peasant dress, a layer of thin white cloth that clearly outlines her appealing curves.  Her fine hips and legs sway with elegance when she walks and you can guess a bountiful wiggly rump hides behind the back of her gown.");
	outputText("\n\nShe has a pair of ample, barely concealed breasts.  Although you can't see them outright, her thin clothing leaves little doubt that they're D-cups.  Her 0.5 inch nipples point through her dress whenever she's aroused.");
	outputText("\n\nShe has a pussy of dubious virginity but copious wetness between her legs.  Occasionally a damp patch will appear on her dress, betraying her arousal.");
	outputText("\n\nYou can't see her asshole, but it's safe to assume it's placed between her squeezable buttocks, right where it belongs.");
	doNext(rebeccMenu);
}
//Rebecc Bath scene (Z)
function rebeccBathScene():void {
	clearOutput();
	outputText("She grabs your hand and leads you to her bathroom, a tiny place almost entirely occupied by an enormous circular container acting as a bathtub, full of hot steaming milk.  You watch her, puzzled.");
	outputText("\n\n\"<i>What?  Don't you bathe in milk in your village?  We have plenty of it here in Owca, you know; more than clean water.  We use it for everything; it has curing properties.</i>\"  Whispering seductively, she adds, \"<i>It's also ideal for purging brave demon fighters from any taint they may have caught.</i>\"");
	outputText("\n\nShe stares at you with insistent and playful eyes.  \"<i>Now come on, you know where I'm going with this.  Let me help you out of your clothes.</i>\"");
	outputText("\n\nYou don't resist, grinning as she enthusiastically removes your " + player.armorName + "; in her haste she gets tangled up until you hold her hand and help her with the fastenings.  A few seconds later you're completely naked and she covers your face and torso with soft kisses as she strips off.  You both giggle as she tries to squeeze both of you into the bathtub; at last she makes you sit in it, laughing and splashing milk everywhere.");
	outputText("\n\n\"<i>There.  Now let me wash you clean.</i>\"");
	outputText("\n\nShe grabs hold of a nearby soap and starts lathering it all over your naked body.  You can't see her hands under the moving milky surface but you feel very pleasant tingles in the most intimate places.  She tickles you a bit and you can't help but giggle some more as you feel her delicate hands working you over.");
	outputText("\n\n\"<i>Shhh... Relax now, soldier.  I'll take care of everything.</i>\"");
	outputText("\n\nShe first softly brushes your hair with her fingers and strokes your head, then massages every tense muscle at the edge of your face, making you sigh and moan in relief.  Before you even notice, her hands are squeezing and pinching the nape of your neck, completely releasing your tension.  You don't know where she learned to be so good at this, but it just feels so right.  Now her hands are moving downards...  Gods, she is so sweet, so delicate.  You let out another moan, making her chortle.  Putting her head just above yours, her perky tits press against your back.  You can feel her erect nipples gently scratching you as she slowly rubs her appreciable bosom against you; her expert ministrations are arousing you little by little");
	if(player.gender == 0) outputText("."); 
	else {
		//[if cock]
		if(player.hasCock()) outputText("; your " + cockDescript(0) + " grows to full erect size");
		if(player.hasVagina() && player.hasCock()) outputText(" and ");
		else if(player.hasVagina()) outputText("; ");
		if(player.hasVagina()) outputText("your " + vaginaDescript() + " leaks a little trickle of girl-juice");
		outputText(".  She doesn't seem to notice the effect she has on you - or so you think.  Suddenly, you feel a hand darting between your legs.");
	}
	outputText("\n\n\"<i>Oooh, so you really like this, don't you?</i>\"");
	outputText("\n\nYou blush and groan in response as she keeps teasing you with her graceful hands.  Caught flat-footed, you feel yourself deflating in shame until she begins whispering tender reassurance in your ear.  \"<i>It's all right, dear.  I want to make sure you're enjoying it thoroughly.  You deserve it.</i>\"");
	outputText("\n\nHer hands stimulate and arouse you ever so slightly, until you tell her desperately you must be completely clean of any demon soiling by now.  You both laugh together awkwardly as you rise from the bathtub; she watches you greedily as you slowly don your [armor].  You eventually leave her, a little saddened.  Rebecc gives you a chaste kiss on your cheek before bidding you farewell.  \"<i>And be sure to come back, hero.  I can't wait to clean you up again.</i>\"");
	//Lust +30, Corr -2, Lib +1, slimefeed
	stats(0,0,0,0,1,0,30,-2);
	slimeFeed();
	doNext(13);
}
//Rebecc Rape scene (for discerning penises) (Z)
function rapeRebecc(outside:Boolean = false):void {
	clearOutput();
	if(player.hasCock()) {
		outputText("Within three strides you are upon Rebecc; you slap her twice on her cheeks, brutally yank her hair and in a harsh gesture, you turn her around.  The woman yells, \"<i>W-what are you doing?  No, please stop!</i>\"  Completely caught unaware, she gasps and jolts in surprise, crying loudly until you slap her again to shut her up.");
		outputText("\n\nYou quickly proceed to denude her, tearing her peasant dress to reveal her bountiful, jiggling breasts.  This enormous rack is begging to be touched; you ruthlessly grope them, forcefully bringing her nipples into their erect state.  She tries to struggle away but you hold her tight, her resistance and endless writhing making [eachCock] harder; to better please yourself, you pull it free of your [armor].  You grind against her plush butt through the coarse cloth of her dress until it is completely drenched with pre-cum, then feverishly remove it, tearing the poor girl's gown to rags in the process to give you a clear view of her ample buttocks.  Pressing yourself on her more, you thoroughly enjoy the soft touch of her healthy rump.  You pinch and grope her fat butt repeatedly, making her whimper in humiliation, until it goes red from your rough treatment.  Gods, this girl has a fine ass; you give it a few slaps here and there as it jiggles in the most enticing way.");
		outputText("\n\nThe sight of her glorious rear is too tempting a target to resist, and you quickly shove the tip of your " + cockDescript(0) + " between her plush cheeks, bracing yourself for torrid anal penetration.  She keeps whining, unable to break free of your iron grasp.  In her constant struggles you notice an opening between her buttocks - you thrust inside with all your might, devastating her backdoor entrance, stretching her holes, tearing her insides and grinding against her rugged anal walls in a extremely rough way.");
		//[if cock is too long, >12 inches]
		if(player.cocks[0].cockLength > 12) outputText("  You keep burying more of your " + cockDescript(0) + " deep inside her rectum until you reach her limit and can't fit more cock in.");
		else outputText("  Eventually the entirety of your prick is lodged inside her lush asshole.");
		outputText("  She trills and bleats in pain and flounders about in your arms, futilely trying to avoid the incoming butt-rape.  You lock her arms with yours, implacably kneading her tits, and her shivering flesh brings the most exquisite contact to your fingers; you toy with her nipples as well, making her scream savagely in forced pleasure.");
		outputText("\n\nAfter a few minutes of resistance, her body tenses up and you ease yourself into effectively butt-fucking her.  You pull her white fuzzy hair, seize her squeezable hips for more leverage and start raping her ass; the thrusts come hard and fast, almost bringing your " + cockDescript(0) + " out before jamming it all the way inside again.  This forceful and tigerish motion makes her shriek in excruciating ecstasy; she groans and moans rhythmically at the pace of your regular ass-pounding.  The torment you're inflicting on her poor interior walls is too much to bear and she twists violently to escape the dick-beast dominating her pucker; however, all she can do is wave her appreciable butt, bringing extra sensations to your " + cockDescript(0)+ " and adding extra spice to your already ardent anal-rape.");
		outputText("\n\nThe cadenced wobbling of her rump as well as your constant pumping is bringing you to a higher state of pleasure; the heavenly tingle your " + cockDescript(0) + " is receiving is making you heedless of anything else but the burning heat of her insides cooking your meat.  You feel your lust rise as you keep riding the buttslut below you, ignoring her muffled complaints and whining, her tight confines gradually taking over any control you have over your rod.  You pound Rebecc's ass as if your life depended on it, clutching her curvy hips instinctively like an imp in rut.  Your groin impacts her buttocks with a loud SLAP at every thrust");
		//[if balls]
		if(player.balls > 0) outputText(", and your " + ballsDescriptLight() + " almost feel sore from colliding with her dribbling cunt");
		outputText(".  Finally, when you think you're about to pass out from exhaustion, you cum in a powerful jet, literally blasting Rebecc's ass with your spooge, globs of  goo being propelled like projectiles into her colon and splattering her backside with huge white smears.");
		if(player.cumQ() > 1500) outputText("  After completely filling up her rectum, your baby-batter erupts in thick spurts from her anus despite her instinctive ass-clenching efforts to hold as much semen as possible inside.  The sheer might of your cumshot is enough to send Rebecc over the edge, and she releases an absolutely torrential stream of girl-cum, squirting against her will all over your groins and mixing her own fluids with yours in a pathetic show of sluttiness.");
		outputText("  She unconsciously milks you of all your spunk, her anal muscles working on their own to massage your meat and extract every drop from your urethra.");
		outputText("\n\nWith a last, satisfied sigh, you fall over, " + cockDescript(0) + " deeply buried inside Rebecc's butt as you feel her warm, curvy body slowly waggling below you.  ");
		if(outside) outputText("Some of the villagers are apathetically watching you, too stunned and bruised to intervene.  ");
		outputText("You silently remove your prick from your girl's ass, watch her contentedly as her exposed rectum is literally oozing with spooge and walk back to your camp.");
		outputText("\n\nThis is a more-than-appropriate goodbye gift");
		if(outside) outputText(" to these miserable people, and even moreso");
		outputText(" to the manipulative slut who kept teasing you.  Serves her right, to use her body in the most provocative ways and never let you actually have your way with her.  You're unlikely to ever see her again.");
		//minus lust, minus libido, plus corruption, Remove Owca Village from 'Places' menu.
		outputText("\n\n(<b>Owca removed from the places menu.</b>)");
	}
	//Rebecc Female Rape Scene (Z)
	else {
		//Requires: PC female and biped
		outputText("Within three strides you are upon Rebecc; you slap her twice on her cheeks, brutally yank her hair and in a harsh gesture, you turn her around.  The woman yells, \"<i>W-what are you doing?  No, please stop!</i>\"  Completely caught unaware, she gasps and jolts in surprise, crying loudly until you slap her again to shut her up.");
		outputText("\n\nYou quickly proceed to undress her, tearing her coarse peasant dress in order to reveal her bountiful, jiggling breasts.  This enormous rack is begging to be touched; you ruthlessly grope it, forcefully bringing her nipples into their erect state.  She tries to struggle away but you hold her tight, her resistance and endless writhing making your " + vaginaDescript() + " moist.");
		outputText("\n\nYou keep rubbing against her plush butt through her ragged cloth and your " + player.armorName + " until it is completely drenched with your juices; you feverishly remove them, tearing the poor girl's gown to rags in the process to give you a clear view of her ample buttocks.  You enjoy the soft touch of her healthy rump against your own skin, glorying in the other girl's helplessness to stop you from touching her however you want.  You pinch and grope her fat butt repeatedly, making her whimper in humiliation, until it goes red from your rough treatment.");
		if(player.tone > 75) outputText("  The sheep girl's plush softness against your own toughened, toned physique manages to both arouse and anger you.  \"<i>This is what you were bred to be, isn't it bitch?</i>\" you hiss, your hands roaming over her inviting curves.  \"<i>Your fat ass hasn't had to work a day in its life.  The town whore, the cock-tease they wheel out when your people need a dupe, that's what you are.  How does it feel to be in the hands of a real woman?</i>\"");
		else outputText("  Gods, this girl has a fine ass; you give it a few slaps here and there as it jiggles in the most enticing way.");
		outputText("  Rebecc doesn't say anything as you continue to grope her; she simply quivers with her eyes tightly shut, apparently unwilling to believe this is even happening.");
		outputText("\n\nYou shove her tits-first to the floor, grinning at the pained squeal this draws from the sheep girl and the wave of motion it sends across her soft body, then stand over her.  She struggles pitifully as you slowly prise her legs open, but the weakling is no match for you and you soon have her spread wide, helplessly presenting her cute, pink pudenda to you.   The sight stokes your raging lust and you sink one finger roughly through her lips into her moist hole, testing her depths as you lower yourself onto her.   Rebecc whimpers again at the abrasive treatment, and with one last meek show of resistance closes her legs and turns away from you.  You grasp her shoulder and backhand her hard, being sure to wipe her own juices onto her face on the return stroke.  She ceases struggling as you slide one of your " + hipDescript() + " over her own plump thigh, clinch her other lamb chop with your arm, and, having thus entrapped her with your burning body, lower your " + vaginaDescript() + " onto hers and begin to buck against her.");
		outputText("\n\nWet sounds fill the air as you thrust your needy cunt into Rebecc's own, your juices dribbling onto and into her, lubricating your unwilling toy.  She whines and again tries to struggle out of the merciless grip you have her in; the effect is to make her own cunt buck and thrust into yours, your slimy lips kissing and moving against each other, heightening your own pleasure and making you scissor into her all the more savagely, already working yourself to a high.  You shove her leg up ruthlessly high so you can really grind into her; you feel her tiny clit bump into your own " + clitDescript() + " and suck in your breath as Rebecc squeals.  Irritated with her constant noise, you bend into the prostrate sheep girl and slap her again, before roaming your hand down her lush front, your fingers landing upon a dark nipple.  You squeeze it as you rub your clits together, her warm flesh wobbling against yours, her own juices dribbling now as you push her relentlessly along the boundary between pain and pleasure until she arches her back and moans in miserable ecstasy, her cunt spasming a gush of girlcum onto you.  You reward her with another slap as she twists in her involuntary orgasm, so that your red hand mark has a partner upon the other side of her face.  It's a good look for her.");
		//[big clit]
		if(player.clitLength > 3) outputText("\n\nYou aren't done yet.  Your own clit has long since pushed out of its hood and is bulging with obscene need.  You rotate your hips, teasing Rebecc's dribbling entrance with it whilst immersing yourself in pleasure, rubbing every inch of your sensitive femcock over her lips and hole before forcing yourself against her own tiny pleasure button, making her twitch and moan.  Your lust stoked to incredible heights by the slick pressure on your clit and the sight and feeling of your yielding, insensate victim, you finally thrust it into her slick hole, eager for release.  Clutching her gelatinous ass and firm neck as you fuck her like a man, you're forced to grit your teeth against the unbearably pleasurable sensation of your clit rubbing on her tender inner walls.  Your " + vaginaDescript() + " drools in sympathy as you push your " + hipDescript() + " into the sheep girl and drive her into the ground, fucking her with your clit-dick as hard as you can.   Your pelvises beat a rough staccato against each other as you bring yourself all the way out and then thrust yourself in again, spattering your mixed juices everywhere as you pick up the pace.  Your " + allBreastsDescript() + " are pushed into her own soft pillows as you rub every inch of yourself over her, determined in your lust craze to violate all of this slut's teasing body.");
		//[other] 
		else {
			outputText("\n\nYou aren't done yet.  Your own clit has long since pushed out of its hood and is bulging with need.   You rotate your hips, teasing Rebecc's dribbling entrance with it whilst immersing yourself in pleasure, rubbing every inch of your sensitive female nub over her lips and hole before forcing yourself against her own tiny pleasure button, making her twitch and moan.  Casually you slap her face again, making her start; the movement translates through her body into your own needy sex as her lips involuntary shrink and rub against yours.  What a lovely sensation!  Your lust stoked to incredible heights by the slick pressure on your clit and the sight and feeling of your yielding, insensate victim, you thrust against her slick hole, eager for your own release.  You scissor her as hard and as violently as you can, slapping into her brutalized sex a few times before embedding yourself and rotating, striking her face carelessly again and again and again.  Her shuddering and sobbing only serves to heighten your pleasure.");
		}
		outputText("\n\nEventually you reach your high.  You clutch Rebecc painfully hard as your pussy spasms around hers, soaking her with your juices.  The crashing orgasm just seems to go on and on and you ride it into your slutty victim, forcing her to feel what you are feeling.  Once the ecstatic contractions have murmured down to a warm buzz, you sigh and crawl onto your prone victim, who is crying quietly.  You are sure to wipe your drooling sex all along her belly, breasts, and finally face; the sheen of femcum and the red hand marks on her tearstained cheeks doubly mark her as your spent, worthless sex toy.  ");
		if(outside) outputText("Some of the villagers are apathetically watching you, too stunned and bruised to intervene.  ");
		outputText("You silently pick yourself up and dress, admiring the quivering, crying handiwork at your feet, before walking back to your camp.  This is a more-than-appropriate goodbye gift");
		if(outside) outputText(" to these miserable people, and even moreso");
		outputText(" to the manipulative slut who kept teasing you.  Serves her right, to use her body in the most provocative ways and never let you actually have your way with her.  You're unlikely to ever see her again.");
		outputText("\n\n(<b>Owca removed from the places menu.</b>)");
	}
	//minus lust, minus libido, plus corruption, remove village from places
	stats(0,0,0,0,-2,0,-100,5);
	flags[OWCA_UNLOCKED] = -1;
	doNext(13);
}

//Desperate Villagers (Z)
//[Dialogue once Attitude reaches 0 or less, pops automatically as you go to the village]
function desperateVillages():void {
	clearOutput();
	outputText("As you approach the group of huts, you hear a vague rumble, as if many people were talking at the same time.  Walking closer, you see all the villagers gathering outside and arguing violently; among them you spot your friend, Rebecc.  As soon as she sees you she hurries over with desperate, wet eyes.");
	outputText("\n\n\"<i>They want to put you back into the pit by force!  I and some others have tried arguing with them but they won't hear anything!  The demons have been harassing us a lot due to the lack of sacrifices, please do something!</i>\"");
	outputText("\n\nShe is rudely pushed aside by a tall muscular man with a pitchfork in his hand.  He starts talking in a slow, harsh voice.  \"<i>You supposed to be brave.  Go ahead.  Make sacrifice.  Or do we need to make you brave, be it against your own will?</i>\""); 
	outputText("\n\nIt seems that these villagers have grown weary of your repeated refusals; they are likely to react angrily if you deny them another sacrifice.");
	outputText("\n\nDo you submit?");
	//Yes/No. Yes leads to Accept Plea, Attitude raised by 10. No to Villagers Fight
	doYesNo(3608,fightZeVillagers);
}
//Villagers Fight (Z, but pretty barebones)
function fightZeVillagers():void {
	clearOutput();
	//You are fighting the villagers (level 14):
	startCombat(52);
	monster.createStatusAffect("Generic Run Disabled",0,0,0,0);
	eventParser(1);
	//~500 HP, 6 different attacks at 20 hp, can't run, 100% lust resistance (can't arouse), ~200 xp
}
function farmersAI():void {
	monster.createStatusAffect("attacks",4,0,0,0);
	eAttack();
	combatRoundOver();
}


//Defeat Villagers (only displayed if corruption >= 60ish) (Z)
function beatUpOwca():void {
	clearOutput();
	outputText("The last of the villagers drops his improvised weapon.  They are all lying defenseless before you.  At last, you notice Rebecc, the only one still conscious, curled upas she weeps uncontrollably.  She is clearly oblivious of her surroundings, undoubtedly shocked by the violent fight.  Even if she calls herself your friend, you don't think you'd be able to reason with her after pummeling her kin.  What do you do?");
	//Rape Rebbecc/Torch Village (needs Akbal's fire or Whitefire)/Leave
	var torch:Number = 0;
	if(player.hasStatusAffect("Knows Whitefire") >= 0 || player.hasPerk("Fire Lord") >= 0 || player.hasPerk("Hellfire") >= 0)
		torch = 3639;
	var rape:Number = 0;
	if(player.cor >= 60 && player.gender > 0 && player.lust >= 33) rape = 3630;
	simpleChoices("Rape Rebbecc",rape,"Torch Village",torch,"",0,"",0,"Leave",leaveOwcaAfterWhupping);
}
//"Leave" redirects the PC to camp; next encounter is Rebecc's Last Plea.
function leaveOwcaAfterWhupping():void {
	//tag for calling last plea
	flags[REBECCS_LAST_PLEA] = 1;
	eventParser(5007);
}
//Village Torching scene - requires a fire skill (Z)
function torchOwcaMotherFuckers():void {
	clearOutput();
	outputText("These ignorant folks deserve to be punished for trying to take you by force.  You muster your strength and release a wave of magical flame.  The raw heat and energy is enough to set entire thatched roofs ablaze.  You ignite house after house, the poor constructions unable to withstand your fiery might, until there are enough burning that the wind can carry the flames to all other buildings nearby.  A few minutes later, the entire village is ablaze; hovels are crumbling under their own weight and the crude roads are being littered with fallen debris.  You watch Owca burn silently, arms crossed.  Finally, when the last building has been thoroughly reduced to a pile of rubble and ashes, you quickly search for any valuables among the villagers' belongings.  Fortunately their gems haven't been melted; you pack a substantial amount of them away before leaving.  You cast a thoughtful glance at the remains of what used to be a peaceful village; ironically enough, the only structure you preserved was the pole in the pit, an ultimate mockery of their futile struggles against forces that ridiculously outmatch them.");
	flags[OWCA_UNLOCKED] = -1;
	stats(0,0,0,0,0,0,0,15);
	if(player.cor >= 60 && player.gender > 0 && player.lust >= 33) {
		outputText("You notice Rebecc is still weeping among the scattered bodies of the beaten villagers.  Do you abuse her?");
		simpleChoices("Abuse Her",3630,"",0,"",0,"",0,"Leave",torchUpVillagersAndLeave);
	}
	else doNext(torchUpVillagersAndLeave);
}
	
//Fuck off village
function torchUpVillagersAndLeave():void {
	clearOutput();
	outputText("You don't think you're going to see these villagers again, and you don't really want to.");
	//Corruption +15 (plus extra for rape), ~ 1000 gems, fatigue set to 100
	player.gems += 900 + rand(150);
	fatigue(100);
	statScreenRefresh();
	eventParser(5007);
}
//End of quest
//Lose to Villagers (Z)
function loseToOwca():void {
	clearOutput();
	outputText("You kneel down and then fall, overwhelmed by the villagers' fury and numbers.  Without hesitation, the angry mob jumps on you; you recoil in terror, persuaded that you're going to be beaten to death.  Instead, you are carelessly lifted and completely stripped off; ");
	if(player.weaponName != "fists") outputText("your " + player.weaponName + " is taken away and ");
	outputText("you are being uncomfortably transported to a destination you can guess easily.  Too dazed to resist or even worry about it; you are promptly brought to the dreaded pit, where the villagers tie you up and rudely shackle you.  Then, before you even realize how desperate your situation is, they're all gone.  Your numerous bruises and fatigue get the better of you and you quickly fall asleep.");
	//redirect to dusk transition text, restore hp/fat consonant with sleeping until nightfall
	HPChange(50,false);
	fatigue(-30);
	//after nightly scene, next encounter is Post-Mob Encounter
	doNext(loseOrSubmitToVapula);
	player.createStatusAffect("lostVillagerSpecial",0,0,0,0);
}
//Post-Mob Encounter (Z)
function morningAfterRape():void {
	player.removeStatusAffect("lostVillagerSpecial");
	clearOutput();
	outputText("The village is utterly silent and almost deserted.  The few people you see look away when they spot you, probably ashamed of what they did last time.  Doors are locked and windows are closed as you pass by; everyone is obviously afraid of directly confronting their victim.  You head toward Rebecc's house, your last friend.  As you open her door, you hear a muffled wail; you recognize the pretty farmer's voice.  She is laying on her bed, weeping uncontrollably; once she finally notices your presence, she looks up to you with tear-filled eyes, sobbing convulsively as she talks.");
	outputText("\n\n\"<i>T-they forced you to be abused... I promise I didn't want that!  I tried to convince them... they wouldn't listen... they threw you to the pit... at least I made them give you back your belongings as usual... now you must hate me, don't you?  Oh, I'm so sorry!  It's all my fault!</i>\"");
	outputText("\n\nWhat do you do?");
	//Option: Forgive. Sets Attitude to 50, quest goes back to normal.
	//Option: Rape. Leads to Rebecc Rape scene and ends the quest. 
	//Option: Leave. Redirects PC to camp, next encounter leads to Rebecc's Last Plea
	simpleChoices("Forgive",forgiveOwca,"Rape",3629,"",0,"",0,"Leave",fuckThisShit);
}
//Option: Forgive (Z)
function forgiveOwca():void {
	clearOutput();
	outputText("Swallowing your pride, you tell her that it's all right and that you hold no grudge against her; the villagers were obviously desperate, to have resorted to such extreme measures.  You assure her");
	if(player.cor >= 50) outputText(", lying through your teeth,");
	outputText(" that you don't feel any resentment at all; she tried her best to help you, and you're grateful to her.");
	outputText("\n\nRebecc's face is overcome with joy as you speak.  \"<i>Thank you, thank you!  I've been filled with remorse and sorrow since this last awful encounter, you can't believe how relieved I am!</i>\"  You take her in your arms and hold her tight until the last of her tears finally dries up.  \"<i>I'm going to tell everyone in the village how great a person you are!  You will be acclaimed as our hero!</i>\"");
	//Corruption -8, Int +2, Attitude raised to 60, will never shrink below 1 (i.e. villagers won't get angry at you again)
	stats(0,0,0,2,0,0,0,-8);
	flags[OWCAS_ATTITUDE] = 60;
	flags[OWCA_ANGER_DISABLED] = 1;
	//To main owca menu
	doNext(gangbangVillageStuff);
}
//Option: Leave (Z)
function fuckThisShit():void {
	clearOutput();
	outputText("You stare at the wretched, whimpering creature before you for a moment.  There's nothing to say.  Without a word, you head back to your camp, carefully closing Rebecc's door behind you as you leave.");
	flags[REBECCS_LAST_PLEA] = 1;
	doNext(13);
}
//Rebecc's Last Plea (Z)
function rebeccsLastPlea():void {
	clearOutput();
	outputText("As you arrive on the border of the cursed village, you see someone is running in your direction.  You recognize Rebecc instantly; she seems to stumble and stagger at every step, and her face is tear-stricken.  Intrigued, you catch the crying woman by the waist as she runs past you sightlessly; she falls into your arms, nearly tripping as she abandons herself to your embrace.  Unsure of what to do, you ask her why she is panicking, though it takes a while before your words reach her.");
	outputText("\n\n\"<i>They... they chose me!</i>\" she wails, choking back.  \"<i>They voted and I was chosen to be thrown in the pit!  They're angry at me for befriending you and I was blamed for the recent troubles with the demons!  They think you've abandoned us and I'm responsible for all this... they hate me!  They hate you too!  I'm going to be tied up, abused and broken... and everyone will pretend nothing happened!  I don't want to go to the pit; I don't know what to do!</i>\"");
	outputText("\n\nWhat do you do?");
	//(You could rape her.) //Leads to Rebecc Rape scene. 
	//(You could face the villagers and demons in her stead.) 
	//(You could leave.) //End of quest.
	simpleChoices("Rape Her",3630,"Face Them All",faceDownHordes,"",0,"",0,"Leave",leaveRebeccToBeRaped);
}
//Option: Leave (Z)
function leaveRebeccToBeRaped():void {
	clearOutput();
	outputText("You tell Rebecc you don't want to have anything to do with her or her sick people and promptly turn around.  She wails and begs you at first but you're faster than the tear-blinded girl, and she soon falls behind.  Your safe, simple camp looms large in your thoughts, pushing out any desire to return to this wicked village and its wicked people.");
	//[Owca Village removed from "Places" menu.]
	outputText("\n\n(Owca has been removed from the places menu.)");
	flags[OWCA_UNLOCKED] = -1;
	doNext(13);
}
//Option: Face Down the World (Z)
function faceDownHordes():void {
	clearOutput();
	outputText("You tell Rebecc to go hide on the plains; you're going to handle the villagers as well as the demon horde on your own.  She cries, \"<i>But " + player.short + "!  You stand no chance against this ruthless horde!  Besides, the villagers won't trust you.  They'll think you want to cheat them... they'll tie you up to prevent you from getting away!</i>\"");
	outputText("\n\nYou tell her not to worry and before her whining protestations can begin, you're already marching toward the village.  As you walk between the tiny houses, people keep staring at you with hostile or even despising eyes.  Some start following you as you walk to the pit, ignoring all the whispers and rumours rumbling about you.  When you're finally standing before the pole, with the whole town gathered around you, you speak in a loud, clear voice.");
	outputText("\n\n\"<i>It is unfair that a young innocent woman should suffer from the cowardice of her townsfolk.  Since you are all too reluctant to defend her yourselves, I'll do it for you.  Don't worry, you meek sheep.  No demon will abuse your kind on my watch.</i>\"  You then ready yourself in a combat stance and wait.");
	outputText("\n\nThe villagers keep staring at you, defiance as well as cautiousness reflected in their pondering eyes.  Caution wins out and they leave you, abandoning to your fate - and the horde.  It's time for you to prove your worth.");
	//Redirects to the Dusk Transition Scene, then to a combat with full equipment and weapons. Loss sets Submissiveness to 100 and gives Bad End.  Victory sets Attitude to 60 and it can never shrink below 1.
	doNext(3613);
}
//Slave to Vapula - Bad End (Z)
function slaveToVapulaBadEnd():void {
	clearOutput();
	//[Displayed if Vapula Submissiveness reaches 100]
	outputText("When you wake up, you find yourself tied and gagged in a strange cave.  A pair of smelly red fruits dangle before your eyes, dripping sap.  Chattering and moaning sounds come from everywhere, and your crotch feels numb.  You come back to your senses and realize your mouth is full of cock - the red 'fruits' are actually an imp's balls, and the 'sap' the drippings of a pussy just behind them!  You struggle to remove the rod of dickflesh but there's not much you can do, bound as you are.  Your constant writhing only makes the hermaphrodite imp harder and she grabs a fistful of your hair as she cums, hard.  Her balls shrink even as the sticky vaginal wetness running along their underside swells, and you can feel the veins in her dong pulsate as she unloads an enormous deposit of spooge in your throat; you are forced to swallow the unnaturally hot globs just to clear room to breathe.  Gods, it is so humiliating... yet, somehow, it's also strangely habit-forming.  Each gulp is easier than the last.  You hear an inhuman snicker as the shaft is pulled out, wiped clean of any residual cum by your lips.  The glittering pair of balls is removed from your sight as the imp is pushed aside.");
	outputText("\n\n\"<i>Sooo... my little pet has just woken up.  Are you done gobbling cock yet?</i>\"");
	outputText("\n\nYou sit up uncomfortably, only to see two succubi caressing your crotch and another imp gently licking your " + assholeDescript() + "; your vision is suddenly masked by a pair of gratuitous, squishy lips.  They squeeze your own, literally tongue-fucking your mouth.  You abandon yourself to the sweet kiss before recognizing the face behind these gorgeous lips: this is Vapula, the vicious dominatrix from the demon horde!");
	outputText("\"<i>Hmm, so tasty... so tender.  You will make an excellent fuck-pet.</i>\"  She snaps her fingers and in no time you are lifted and carried to a pole very similar to the one in the village, then quickly shackled and bound.  Before you can move, your mouth and your " + assholeDescript() + " are already rammed with towering fuck-sticks.  You flutter and tremble, unable to control your body under the intense pleasure you're receiving.  You squirm, you writhe; all you want is more cock to fill you, more cum to be injected in your body.  It feels so right... so powerful to be used like that.  In the back of your mind you see Vapula shuffling the contents of several vials together, preparing some kind of boiling orange mixture.  These rational thoughts are however quickly replaced with dreams of more dickflesh stuffing your insides.");
	outputText("\n\nThe captivating purple succubus approaches you in a sexy manner, doing her best to display her wondrous curves, her appreciable tits and her drooling pussy.  With a disarming smirk, she holds up the vial with her mixture, shaking it before your eyes.");
	outputText("\n\n\"<i>Enough.  Remove that dick from my pet's mouth, I want to talk to " + player.mf("him","her") + " for a second.</i>\"");
	outputText("\n\nYou gasp for air as the imp complies to his mistress's orders, withdrawing his monstrous member to jerk it with his hand instead.");
	outputText("\n\n\"<i>You liked that, didn't you?  I know you did.  Now, you'd better listen to my offer, as it is probably the last question you'll ever have to answer in your new life as a dicksleeve.  Do you want to be a permanent cock-slut?  Do you want to be transformed into a whore, even hungrier for cum than you actually are?  Do you want your every hole to be pumped with more spunk that you'll ever dream of?  Speak, bitch!</i>\"");
	outputText("\n\nWith a violent thrust, the cock ramming your " + assholeDescript() + " shoves you into Vapula's arms; you bounce off her delightful tits but she holds you tight, forcibly locking you into an unholy embrace.  Unable to see anything but a pair of voluminous breasts and your nose being impregnated with the sweet, entrancing scent of the succubus' aura, you stare blankly at her, then give the slightest tremble of a nod.");
	outputText("\n\n\"<i>What?  I didn't hear you.  Do you want to have more sex in one hour than some people will ever have in their lifetime?  Do you want your future to be filled with pussy, cock, and boobs?  Do you want it?</i>\"");
	outputText("\n\nYou finally pull your head back from her bosom and manage to mutter a feeble \"<i>Y-yes...</i>\"");
	outputText("\n\n\"<i>What?  I can't hear you.  Say it!  Say it aloud!</i>\"");
	outputText("\n\n\"<i>Yes...</i>\"");
	outputText("\n\n\"<i>Yes what?  Say it!  Say that you want to be my personal cumslut!  Do it!  I want everyone to know that you're willing to be a cum-slave forever!</i>\"");
	outputText("\n\n\"<i>Yes!  YES!  Mistress Vapula, please take me as your slut!  I'm your plaything, your toy!  Please use me in any way you like!  I want nothing more in life than a nice cock in my hole and a drooling pussy to please!  I need cum!  I'm so horny I think my ass is going to explode!</i>\"");
	outputText("\n\nThese spontaneous, dirty words make the imp fucking you from behind instantly cum; with a powerful last push, he blasts you with his seed, filling and soaking your backside with thick white goo.  You reach for Vapula, helplessly hugging her tits and suckling her nipples as you sob in pleasure-induced humiliation.");
	outputText("\n\n\"<i>Very well, slut.  Your former life as a villager is over.  It's time to move on to your new life; and trust me, it's going to be much more exciting.  Actually, I don't think you'll be willing to ever leave this place...</i>\"");
	outputText("\n\nYou furiously nod in approval.");
	eventParser(5035);
}

//Subdue Vapula Scene - begins Vapula Follower Content(Z)
//[Triggered if submissiveness reaches 0 when beating the horde.] 
function subdueVapula():void {
	clearOutput();
	outputText("And at last, the final demon falls, ");
	if(monster.HP < 1) outputText("overwhelmed by your might");
	else outputText("his own lust");
	outputText(".  As usual, you walk among the forlorn bodies of your enemies.  Vapula is grovelling on the floor again, looking up to you with imploring eyes.  Even beaten and broken, the luscious succubus remains the most preeminent figure of the motley rabble.");
	outputText("\n\nYou grip her by the shoulders and stare at her, asserting your dominance.  Your vanquished foe casts her gaze down but maintains eye contact; she looks solemn and reflective, probably knowing that her fate will depend on your next decision.");
	outputText("\n\nBy now, you've completely broken the back of the rapacious demon horde.  Their leader is starting to get used to her repeated defeats; it's time for you to make a decision... what do you do?");
	//choices: [Disband the horde]/[Enslave Vapula(requires cock or non-centaur vagina, D2 completion, libido >= 60, and corr >= 70)]
	var fuck:int = 0;
	if(player.gender > 0 && player.lust >= 33) fuck = 3617;
	var enslave:int = 0;
	if(player.gender > 0 && player.cor >= 66) enslave = 3748;
	simpleChoices("Disband",disbandHorde,"EnslaveVapula",enslave,"JustFuckEm",fuck,"",0,"Skip Out",5007);
}
//Option: Disband (Z)
function disbandHorde():void {
	clearOutput();
	outputText("You start speaking in a calm, measured voice.  \"<i>Here we are again.  I cannot count how often we've been in this same situation: you struggling before me, powerless.  How often do you need to be reminded your place?  Back off.  We don't want your kind here.  Go find some other prey; fuck each other for all I care.  Just stop bothering us.  If I see you or your minions hanging around this village again, you will regret it.  All of you.</i>\"");
	
	outputText("\n\nHer eyes are progressively filling with fear as you deliver your ultimatum, conscious of finding someone with more power than her.  She squirms uncomfortably in your grasp and nods feebly.");
	outputText("\n\nYou give the wanton succubus a loud slap for good measure and discard her.");
	outputText("\n\n\"<i>Begone.  Leave, all of you.  Out of my sight.</i>\"");
	outputText("\n\nShe nods again in acknowledgement and starts shaking her pets out of their torpor.  The imps quickly awaken each other, giving you a few frightened glances every now and then.  Then, a bit pathetically, Vapula gives the retreat signal.  In no time the once-proud bunch disappears, probably gone for good.  Hopefully, the demons have learned from their mistakes and won't bother the village again.");
	//Attitude set to 100
	flags[OWCAS_ATTITUDE] = 100;
	flags[OWCA_SACRIFICE_DISABLED] = 1;
	eventParser(5007);
}
//Option: Enslave - penis version (requires D2 completion and libido >= 60 and corr >= 70) (Z)
function enslaveVapulaWithYourWang():void {
	clearOutput();
	if(!player.hasCock()) {
		enslaveVapulaAsACuntWielder();
		return;
	}
	outputText("You speak in a feverish voice.  \"<i>You're such a bitch.  Damn, why did you ever think you were going to make me your slut?  How many times do you need to be shown that I'm not the bottom in our relationship?  You deserve to be turned in to Lethice so she can make you her personal fuck-toy; at least you'll remember your place.</i>\"");
	outputText("\n\nAs soon as you mention the name of the demon queen, the struggling woman in your grasp recoils, her purple eyes widening in fright.  She whimpers, terrified, \"<i>Please don't!  You don't know her!  She's going to kill me, or worse!  She hates me!  If you do this, she will... she will...</i>\"  Her voice breaks as she keeps muttering unintelligible words, half-paralyzed in horror.");
	outputText("\n\n\"<i>So you're a renegade, huh?  Very interesting.  I guess that's why a proud succubus is now forced to rely on marauding and scavenging.  But surely it wasn't Lethice who forced you to gang-rape a villager every week, right?</i>\"");
	outputText("\n\n\"<i>W-we had a reputation to maintain... what would people think if we behaved?  We were just having a little bit of fun, it didn't harm anyone.  I bet they all enjoyed it even if they won't admit it... fuck, it's in our nature to have sex with everyone. You can't change us.</i>\"");
	outputText("\n\nYou laugh at her in derision.  \"<i>At least you have the merit to acknowledge you're nothing more than a cock-hungry slut.  It would be a shame to waste such a body, you know.  You're going to be my slut!  It wouldn't change much from your ordinary life as a sex-horny bitch.  It's that or Lethice.</i>\"");
	outputText("\n\nThe succubus's eyes widen.  \"<i>Champion, I want nothing more than to please you!  Please take me!  Just... don't abandon me to her.  I'll do things to your genitals you cannot even conceive of.  We will both literally drown in cum.  You will scream in pleasure.  Please take me, you won't regret it!</i>\"");
	outputText("\n\n\"<i>Very well; I'm sure we will both have a lot of fun.  Tell your minions to go away, I don't want their kind.</i>\"");
	outputText("\n\n\"<i>Champion, they will likely follow regardless.  Of course, they will be too afraid to bother you... but expect them to hang around your camp.</i>\"");
	outputText("\n\n\"<i>As long as they don't disturb me while I fuck your brains out, I don't care.</i>\"");
	outputText("\n\nYou lend a hand to your newly-acquired succubus slut and help her to her feet.  She stumbles at first, still stunned by the recent fight; she quickly follows you though, firmly lead by your iron grip.  Hand in hand, you walk away from the pit and the scattered bodies without a look back.  On your way to the camp, you don't hesitate to give your succubus toy a few gropes to her boobs and buttocks, making her giggle; she playfully returns the favor, and by the time you reach your camp you are already stroking each other's crotches, your fingers softly probing her vaginal entrance until she openly moans in delight.  You stop teasing her and dismiss her at last.");
	outputText("\n\n(<b>The demon Vapula has been added to your slaves.</b>)");
	//[Vapula added as follwer.]
	flags[VAPULA_FOLLOWER] = 1;
	flags[OWCAS_ATTITUDE] = 100;
	flags[VAPULA_HAREM_FUCK] = 1;
	flags[OWCA_SACRIFICE_DISABLED] = 1;
	//Chance to trigger imp gangbang is increased by 7%!
	//Attitude set to 100, sacrifices will never be asked again. Lust set to 80 if below.
	if(player.lust < 80) player.lust = 80;
	stats(0,0,0,0,0,0,0.1,0);
	eventParser(5007);
}
//Option: Enslave - vagina version (requires D2 completion and libido >= 60 and corr >= 70 and, apparently, no centaurs)(Z)
//NOTE: No Centaurs. Fuck Centaurs.
function enslaveVapulaAsACuntWielder():void {
	clearOutput();
	outputText("You speak in a feverish voice.  \"<i>You're such a bitch.  Damn, why did you ever think you were going to make me your slut?  How many times do you need to be shown that I'm not the bottom in our relationship?  You deserve to be turned in to Lethice so she can make you her personal fuck-toy; at least you'll remember your place.</i>\"");
	outputText("\n\nAs soon as you mention the name of the demon lord, the struggling woman in your grasp recoils, her purple eyes widening in fright.  She whimpers, terrified, \"<i>Please don't!  You don't know her!  She's going to kill me, or worse!  She hates me!  If you do this, she will... she will...</i>\"  Her voice breaks as she keeps muttering unintelligible words, half-paralyzed in horror.");
	outputText("\n\n\"<i>So you're a renegade, huh?  Very interesting.  I guess that's why a proud succubus is now forced to rely on marauding and scavenging.  But surely it wasn't Lethice who forced you to gang-rape a villager every week, right?</i>\"");
	outputText("\n\n\"<i>W-we had a reputation to maintain... what would people think if we behaved?  We were just having a little bit of fun, it didn't harm anyone.  I bet they all enjoyed it even if they won't admit it... fuck, it's in our nature to have sex with everyone. You can't change us.</i>\"");
	outputText("\n\nYou laugh at her in derision.  \"<i>At least you have the merit to acknowledge you're nothing more than a cock-hungry slut.  It would be a shame to waste such a body, you know.  You're going to  be my slut!  It wouldn't change much from your ordinary life as a sex-horny bitch.  It's that or Lethice.</i>\"");
	outputText("\n\nVapula's face lights up with desire at first... but her evident arousal trades with cringing fear and doubt as you finish.  She struggles with herself for a moment, then speaks.");
	outputText("\n\n\"<i>Ch-champion, I want nothing more than to please you, I want to lick every inch of you, but... I'm a succubus.  I need manjuice to live and you don't... you know... have the right equipment.</i>\"  She giggles nervously.  \"<i>If you let me bring my servants, or if you have other toys I could milk, then...</i>\"  She trails off as she catches your expression.");
	outputText("\n\n\"<i>That isn't good enough, slut.  Why would I want to own you if all you're going to do is suck off other worthless bitches?  So I can smell cock on your breath when I'm making you squeal?  Think again.</i>\"");
	outputText("\n\n\"<i>I- wait!  Please don't hand me in to Lethice!</i>\" Vapula wails.  \"<i>I can work something out!  Just, just give me a bit of time!</i>\"");
	outputText("\n\nYou leave her hanging for a moment, then give her a curt nod.  \"<i>Go, then.  Don't forget who owns you now, slut.  If you betray my confidence in you, I will hunt you down and make you wish I gave you in to Lethice.</i>\"");
	outputText("\n\nVapula wags her head, ecstatic with relief; she quickly stumbles to her feet and scurries off, pushing through her defeated horde as if they weren't there.  You watch her bouncing ass, wondering if it was a wise thing to trust a demon.  You suppose it's no skin off your nose if she doesn't come back, but there is no doubting the attraction of being able to dig into that luscious body of hers whenever you want.  You shrug and slowly make your way back to camp, absentmindedly kicking a comatose imp out of the way as you do.");
	//[QUE VAPULA NIGHT MEETING]
	flags[VAPULA_FOLLOWER] = .5;
	//VILLAGE LOVES YOU + NO MORE SACRIFICES
	flags[OWCAS_ATTITUDE] = 100;
	flags[OWCA_SACRIFICE_DISABLED] = 1;
	//Chance to trigger imp gangbang is increased by 7%!
	eventParser(5007);
}
	
//Two nights after "vagina enslave", if PC still meets initial requirements (else defer until she does)(Z)
function femaleVapulaRecruitmentPartII():void {
	outputText("\nYou are awoken by long fingers inching up your inner thighs, testing and caressing your soft flesh. You sigh, open your eyes, and are confronted by an excited, purple face looming over you.");
	outputText("\n\n\"<i>I have found you, mistress,</i>\" Vapula whispers.  \"<i>And I have done what I promised!  Look.</i>\"  She proudly produces an obscene-looking device, replete with rounded nodules and hanging straps.");
	outputText("\n\nYou rub your eyes, accept the thing off the succubus and examine it.  It's a double dildo fitted with a harness: a strap-on that is evidently designed to fuck the user whilst they themselves are fucking. One end is relatively small, pink and fleshy-looking, the other is an eight inch purple monster covered in ludicrous orange leopard spots.  Vapula draws in close to you and eagerly points out its features as you turn it around in your hands.");
	outputText("\n\n\"<i>There aren't many strap-ons around like this, mistress; Lethice would kill me twice if she knew I had taken it.  The big end has a reservoir of spunk that refills itself - so you can feed me whenever you want.  The other end can be controlled with your mind to be any size you wish.  So you can pack your love tunnel out when you're fucking me, making yourself stupid with lust, or fill it just big enough to tease ever so slightly at that sexy little button you've got down there.</i>\"  Vapula is practically panting when she finishes, her hot breath rolling over you as she stares into your eyes.  Your new slave has done well here, perhaps better than she imagines.  If it works like she says it does, then you can have total say over the succubus's cum intake without being beholden to your own urges - giving you a huge amount of control over her.  The thought makes you bend into Vapula and kiss her hungrily, quickly pushing past her soft lips and sharp fangs to roughly tongue-fuck her.  She moans, sending pleasurable vibrations through your face, and wraps her own long tongue around yours, your saliva and warm muscle melding into one.  After a long minute you slowly pull away, trailing saliva from her lips.");
	outputText("\n\n\"<i>Well done, my slave,</i>\" you purr, caressing her face.  \"<i>I will be sure to reward you with this item of yours, in the fullness of time.  Repeatedly.</i>\"  Vapula grins with barely contained enthusiasm, before rising and slowly walking away from your bed, beading a trail of juices from her cunt as she goes.");
	//[Vapula added]
	flags[VAPULA_FOLLOWER] = 1;
	flags[VAPULA_HAREM_FUCK] = 1;
	//[Demonic dildo added]
	player.createKeyItem("Demonic Strap-On",0,0,0,0);
	outputText("\n\n(<b>Gained Item: Demonic Strap-On</b>)");
	doNext(1);
}

function vapulaGivesPCAPresent():void {
	outputText("\nVapula walks up to you and frowns, clearly disappointed.  \"<i>Since you got rid of the only way you could properly feed me, I got you this.</i>\"\n\nShe drops a strap-on into your hand as she explains, \"<i>It can convert the lust of a woman into something that will be palatable to my... appetites.  You're welcome.</i>\"");
	outputText("\n\nShe walks away without another word.  It might be time for some discipline.");
	player.createKeyItem("Demonic Strap-On",0,0,0,0);
	outputText("\n\n(<b>Gained Item: Demonic Strap-On</b>)\n");
}


//Slave Vapula
//Camp lines
function vapulaSlaveFlavorText():void {
	var choice:int = rand(11);
	if(choice == 0) outputText("Vapula is currently resting on a very rough bed of leaves she's gathered herself.  She sleeps quietly, her hand absent-mindedly laid on her vagina and the other one resting on her breasts.  A thin trickle of her juice is leaking out of her crotch.");
	if(choice == 1) outputText("Your succubus slut, Vaplua, is furiously stroking herself on her bed of leaves, her purple body shining in sweat.  She moans raggedly, often looking up to you with lust-consumed eyes.");
	if(choice == 2) {
		if(flags[VAPULA_HAREM_FUCK] == 0) choice = 3;
		else outputText("Vapula is currently absent, probably getting screwed by some of the imps surrounding your camp in order to get her semen rations.  You're sure she would come back instantly if you ever needed to give her YOUR cum instead.");
	}
	if(choice == 3) outputText("Vapula is busy drinking a vial of milk that looks very much like the kind you'd usually find on imps.  Her purple cheeks seem to blush darker when she sees you; she awkwardly gulps the rest of the bottle, hiccups, and giggles softly, eyeing you with a coy smile and a lust-filled gaze.  The potion seems to have made her even more aroused than usual.");
	if(choice == 4) {
		outputText("Vapula is currently toying with ");
		if(player.hasKeyItem("Deluxe Dildo") >= 0) outputText("your deluxe dildo");
		else outputText("a dildo");
		outputText(", pumping as fast as she can.  In her feverish display of lust she doesn't even notice you.");
	}
	if(choice == 5) {
		if(flags[VAPULA_HAREM_FUCK] == 0 || !(bimboSophie())) choice = 6;
		//if harem fucking is on)
		else outputText("Vapula is fingering herself while eating out Sophie, your harpy slut.  The dumb avian matron keeps moaning like she's in heat while the succubus furiously assaults her lush fuck-hole; both of their pair of wings flap in rhythm as they feel their pleasure rising in waves.");
	}
	if(choice == 6) {
		if(flags[VAPULA_HAREM_FUCK] == 0 || flags[IZMA_NO_COCK] > 0 || !izmaFollower()) choice = 7;
		//if Izma has cock and harem fucking is on)
		else outputText("Your succubus is currently very busy with Izma, your tigershark lover.  Izma is standing and hiding Vapula from your sight and you don't notice what Vapula is doing to her until you see her frantic bobbing movements, and hear Izma's hisses and growls of pleasure.  Obviously your succubus must get the cum she needs from somewhere.");
	}
	if(choice == 7) {
		//if C. Jojo and harem fucking is on)
		if(flags[VAPULA_HAREM_FUCK] == 0 || !campCorruptJojo()) choice = 8;
		else {
			outputText("You routinely hear screams of pleasure outside the camp, as well as some frantic male squeaks coming from Jojo, your ");
			if(tentacleJojo()) outputText("tentacled ");
			outputText("mouse pet.  Vapula seems to be having a lot of fun with your fuck-toy!");
		}
	}
	if(choice == 8) {
		if(flags[VAPULA_HAREM_FUCK] == 0 || !(amilyFollower() && amilyCorrupt())) choice = 9;
		//if C. Amily and harem fucking on)
		else outputText("Vapula is busy caressing your corrupted mousette, Amily while softly kissing her breasts.  Her fingers are buried in your fuck-toy's pussy, and Amily is moaning whorishly and doesn't even bother to stop when she looks at you, her helpless eyes betraying her lack of control over her own lust.");
	}
	if(choice == 9) {
		if(player.hasStatusAffect("Camp Rathazul") < 0) choice = 10;
		else outputText("Vapula is having a very active conversation with Rathazul, the alchemist.  They seem to be discussing the chemical properties of demonic mixtures and the various taints that could occur from their ingestion.  The succubus is holding a bottle of a purplish white fluid that appears to be her own milk, probably waiting for an analysis.");
	}
	if(choice == 10) outputText("Vapula is resting on her stomach, a buttplug shoved into her ass.  She doesn't seem to notice you watching her butt jiggle under the effect of her unconscious anal contractions.");
}




//Vapula-Followers interaction: Puru Puru Mouse (Z)
//switch follower names depending on conditions
function mouseWaifuFreakout(amily:Boolean = false, jojo:Boolean = false) {
	clearOutput();
	if(amily) {
		outputText("Amily ");
		if(jojo) outputText("and ");
	}
	if(jojo) outputText("Jojo ");
	outputText("walk");
	if(!(amily && jojo)) outputText("s");
	outputText(" up to you, worried, as Vapula struts around the camp.");
	outputText("\n\n\"<i>" + player.short + ", what is this? Am I dreaming or did you actually bring a demon to your camp? What in the world is wrong with you?</i>\"");
	outputText("\n\n\"<i>Relax,</i>\" you answer.  \"<i>Yes, she's a demon, but she's MY demon. She's under control, aren't you, honey?</i>\"  The succubus simpers softly and nods.");
	outputText("\n\n\"<i>But...but this is insane!  You're supposed to be fighting demons, not joining them!  Did the taint of this cursed land somehow get the better of you?  Did you lose your soul yet?  These monsters are the same ones who destroy and corrupt innocents, and you invite one of them to camp?  This is madness!</i>\"");
	outputText("\n\nYou try your best to explain that Vapula is a renegade, that she fears Lethice.");
	outputText("\n\n\"<i>She's still a demon!  A succubus!  She'll suck the living soul out of you!</i>\"");
	//[if libido >=50]
	if(player.lib >= 50) outputText("\"<i>Well, as long as she swallows, I don't care,</i>\" you quip.");
	outputText("\n\n\"<i>That's it!</i>\"  The ");
	if(jojo && amily) outputText("mice are");
	else outputText("mouse is");
	outputText(" raving.  \"<i>You've clearly given in to her demonic lust.</i>\"");
	if(jojo) {
		outputText("\n\n\"<i>I'm leaving, " + player.short + ",</i>\" Jojo says.  \"<i>I only hope for your sake that you come to your senses soon... I will return to my place in the forest when you require assistance in freeing your soul of taint.</i>\"");
		flags[JOJO_MOVE_IN_DISABLED] = 1;
		player.removeStatusAffect("JojoNightWatch");
		player.removeStatusAffect("PureCampJojo");
	}
	if(amily) {
		outputText("\n\nAmily shakes her head.  \"<i>Goodbye, [name].  You've changed.  What you did is pure folly.</i>\"");
		//Set - amily flipped her shit
		flags[AMILY_FOLLOWER] = 0;
		//Enable village encounters
		flags[AMILY_VILLAGE_ENCOUNTERS_DISABLED] = 0;
		//Change to plain mouse birth!
		if(player.pregnancyType == 11) player.pregnancyType = 4;
		//FLAG THAT THIS SHIT WENT DOWN
		flags[AMILY_CORRUPT_FLIPOUT] = 1;
		//Make sure the camp warning thing is off so she never moves back in.  Bitch be mad.
		flags[UNKNOWN_FLAG_NUMBER_00173] = 0;
	}
	//[(if PC corr > 70)
	if(player.cor > 70) outputText("\n\n\"<i>Fine. Go fuck off then, I don't need you.  I have a much better and hotter slut now. Don't hesitate to come back if you want some sweet pussy, though.</i>\"");
	outputText("\n\n");
	if(jojo) outputText("Jojo");
	if(amily && jojo) outputText(" and ");
	if(amily) outputText("Amily");
	if(amily && jojo) outputText(" have ");
	else outputText(" has ");
	outputText("moved out.");
	outputText("\n\nMaybe it's past time you brought them around to way your way of thinking?");
	//Amily and Jojo removed from followers. Amily is encounterable again in the Village Place through the corrupted route and Jojo can still meditate with you.]
	doNext(1);
}

//tion camp
//Follower Summoning text (Z)
function callSlaveVapula(output:Boolean = true):void {
	if(output) {
		clearOutput();
		outputText("You gently tap Vapula on her shoulder and tell her you intend to put her goddess-like body to use.  She grunts at first but quickly smiles at you kinkily, letting you see her fangs as she voraciously stares at your crotch. You tear open the rags she's stitched together and cup her bouncy breasts. She swiftly responds with a passionate kiss, moaning in lust and quickly undressing you as you literally tongue-fuck each other. One of her hands darts at your crotch, slowly massaging it as she presses her body against your own, letting you feel the warmth of her jiggly bosom against your chest. You decide to return the favor; moving your own hands down, you slap her firm-yet-ample ass, getting a good grope of her purple flesh; your other hand starts exploring the depth of her vaginal recesses. She pulls back and openly cries in pleasure, her whole body shaking between your arms, a trickle of delicious succubus-saliva hanging between your lips.  After a few minutes of playful teasing, you release her; she stares at you with longing and flirtatious eyes.");
		outputText("\n\n\"<i>Want to have some fun, " + player.short + "?</i>\"");
	}
	//Option: Appearance
	//Option: Talk
	//Option: Feed (cocks only for now)
	//Option: Threesome 
	//Option: Leave
	var mFeed:int = 0;
	var fFeed:int = 0;
	if(player.hasCock()) {
		if(player.lust >= 33) mFeed = 3754;
		else if(output) outputText("\n\nYou aren't suitably aroused to feed Vapula right now.");
	}
	if(player.hasVagina() && player.hasKeyItem("Demonic Strap-On") >= 0) {
		if(player.lust >= 33) fFeed = 3769;
		else if(output && !player.hasCock()) outputText("\n\nYou aren't suitably aroused to feed Vapula right now.");
	}
	var threesome:int = 0;
	if(player.lust < 33) {
		if(output) outputText("\n\nYou aren't much interested in any of the threesomes Vapula seems poised to suggest.");
	}
	var spank:int = 0;
	//Spank Vapula for misbehaving.
	//Requires Vapula force herself on you for food.
	//Requires bipedal-ness
	if(flags[VAPULA_EARNED_A_SPANK] > 0 && !player.isTaur() && !player.isDrider()) spank = 3959;
	else threesome = 3768;
	choices("Appearance",3750,"Talk",3751,"Feed",mFeed,"Feed(Dildo)",fFeed,"Threesome",threesome,"Spank",spank,"",0,"",0,"",0,"Leave",campSlavesMenu);
}

//Vapula Appearance - this bitch is purpler than a Nigerian (Z)
function fapulaFapfapfapAppearance():void {
	clearOutput();
	outputText("Vapula is a 6 foot 1 inch-tall succubus with a voluptuously curvy build.  Her entire skin is purple, only growing darker whenever she's aroused.  She has a fairly human face with a surprising lack of horns; were it not for her skin, the only sign betraying her demonic origins would be her pair of fangs that are revealed whenever she smiles.  Her eyes are purple as well, often glinting with lust.  Her dark-purple hair grows luxuriously around her head, giving her a fierce, almost lion-like aspect, but it's offset by her majestic aquiline wings, leaving you wondering about her origins.  Two normal, well-formed legs grow down from her squeezable hips, swaying hypnotically as she walks.  She is wearing rags that cover only a tiny fraction of her body, concealing just her naughty bits to make the whole display more erotic.");
	outputText("\n\nShe has a pair of jiggly, perky H-cup breasts, each one adorned with a 1-inch nipple.");
	outputText("\n\nShe has a pink, wet pussy, although you know it can be stretched to take members of any size.  Drops of fem-juice often drip from her lush fuck-hole, leaving a trail behind her as she walks.");
	outputText("\n\nVapula has a tight asshole, placed right between her plush buttcheeks where it belongs.");
	stats(0,0,0,0,0,0,10,0);
	callSlaveVapula(false);
}
//Talk (Z)
function talkToVapulaForSomeReason():void {
	clearOutput();
	outputText("\"<i>You want to talk?  Well it's quite rare to see " + player.mf("studs","girls") + " looking for conversation with the likes of me, but go ahead.  What do you want to talk about?</i>\"");
	//Option: Stop Fucking Harem OR Fucking Harem OK (if toggled on off)
	//Option: Cerulean Threesome On/Off
	var threesomeT:String = "";
	var threesomeB:int = 0;
	var haremT:String = "";
	var haremB:int = 3753;
	if(flags[VAPULA_HAREM_FUCK] == 0) {
		outputText("\n\nVapula will not currently fuck anyone else in your camp without permission.");
		haremT = "FuckFollowers";
	}
	else {
		outputText("\n\nVapula will fuck any willing partners you may have around camp.");
		haremT = "Don'tFuck";
	}
	//IF PC has cerulean succubused before
	if(player.hasStatusAffect("repeatSuccubi") >= 0) {
		if(flags[VAPULA_THREESOMES] == 0) {
			outputText("\n\nShe won't currently assist the cerulean succubus if you invite her over.");
			threesomeT = "Assist On";
		}
		else {
			outputText("\n\nIf you call the cerulean succubus, Vapula will assist her in pleasuring you.");
			threesomeT = "Assist Off";
		}
		threesomeB = 3752;
	}
	simpleChoices(haremT,haremB,threesomeT,threesomeB,"",0,"",0,"Back",callSlaveVapula);
}

function toggleCeruleanVapulaAssist():void {
	clearOutput();
	//Cerulean Threesome On (Z)
	if(flags[VAPULA_THREESOMES] == 0) {
		outputText("You inform Vapula that a succubus might join you in the following nights, and you want her to join the party; after all, if there's enough cum to feed one, there should be extra to feed another one.  Vapula wiggles and chortles, excited at the perspective of meeting a fellow creature to have a good fuck.  You warn her that she'll have to be very skilled if she doesn't want to be replaced.  Vapula smiles at you seductively and gently fondles your crotch, then says, \"<i>Don't worry; I know that deep down inside, you prefer giving your cum to me, right?</i>\"  The tingle is very pleasant, and you give your slut a soft kiss before sending her on her way.  You look forward to the incoming threesome.");
		flags[VAPULA_THREESOMES] = 1;
	}
	//Turn off
	else {
		//Cerulean Threesome Off (Z)
		outputText("You inform Vapula that you don't want her to meddle with your night fucks anymore.  Your succubus shrugs.  \"<i>Whatever.  As long as I get regular cum rations, I don't care much.  I'll do as you say.</i>\"");
		flags[VAPULA_THREESOMES] = 0;
	}
	//Return to talk menu
	doNext(talkToVapulaForSomeReason);
}
function toggleVapulaHaremFucks():void {
	clearOutput();
	//Stop Fucking Harem
	if(flags[VAPULA_HAREM_FUCK] == 1) {
		outputText("You tell Vapula that you're fed up with seeing her fucking nearly everyone at camp and getting screwed by any living creature in its surroundings.  She's supposed to be YOUR succubus, and no one else's. You insist that you don't want to see anything near her pussy but your own genitals. You're her [master], after all, and her body is yours.");
		outputText("\n\nVapula protests, \"<i>But how am I supposed to feed? It's in my nature to get other people's spunk; I need it, just like you need to eat and breathe.</i>\"");
		outputText("\n\nYou assure her that your own cum production will be enough to satiate her needs. You just don't want her to feed off anyone else's.");
		outputText("\n\n\"<i>Ah, you're a possessive [master]... I see. Very well, from now on I will only live on your own semen. But I'm warning you: I have very big needs, and I can get quite... impulsive when I'm hungry. If you don't feed me enough I'm afraid I might get what I rightfully deserve by force.</i>\"");
		outputText("\n\nYou pretend not to understand her semi-hidden rape threats, confident that you'll be able to drown her futile menaces with cum when the time comes.");
		flags[VAPULA_HAREM_FUCK] = 0; 
	}
	else {
		//Fucking Harem OK
		outputText("You tell Vapula that you don't care anymore about where she gets her cum. From now on she might as well fuck whoever she wants as long as she remains available when you need to use her body. The succubus replies joyfully, \"<i>Yay! I was hungry!</i>\" and kisses you before storming off in the thick jungle. Knowing her, she is probably hunting for some potent imp to milk. You sigh and return to your campfire.");
		flags[VAPULA_HAREM_FUCK] = 1; 
	}
	//Return to talk menu
	doNext(talkToVapulaForSomeReason);
}
//Feed
function feedVapulaACupOfJizz():void {
	clearOutput();
	outputText("You tell Vapula you're going to reward her for being such a good slut; idly stroking [oneCock] into erection, you command her to get on her knees so she can receive her meal.  The demoness eagerly complies and grabs hold of [oneCock].  She then proceeds to lick it, coating the entirety of your junk with her warm, sweet saliva. With an expert precision, she massages all your most sensitive points, pumping pre-cum up your urethra with ruthless efficiency.  As drops of your juices dribble from the tip of your " + cockDescript(0) + " she voraciously slurps them with a gourmand's smile.");
	outputText("\n\nHer ministrations feel good, but she keeps tickling you with her soft hands and pulpy lips, and her flexible tongue gives you the most infuriating tingles of pleasure.  With a groan of impatience, you grab her head and stuff your whole " + cockDescript(0) + " into her mouth, literally stuffing her full of your junk.  She nearly chokes at first but her old reflexes acquired from a whole life devoted to lewdness and licentiousness start kicking in; Vapula gluttonously deepthroats your meat, softly moaning as she fingers herself with one hand and caresses your ");
	if(player.balls > 0) outputText(ballsDescriptLight());
	else outputText("groin");
	outputText(" with the other.  She sucks like a cock-hungry whore, treating your shaft like a straw as she aspires your juices; her demonic throat feels incredibly hot and her saliva seems to make your " + cockDescript(0) + " grow even harder; her lips squeeze your meat in the most exquisite manner, sending you into short spasms of pleasure every time.");
	outputText("\n\nShe works on it for what seems like hours.  You look down at your slut; she keeps staring at you with avid yet playful eyes, never breaking eye contact as she relentlessly throatfucks herself; you feel her lips curve a little as the shape of a ravenous smile appears on her face, and her eyes glitter with an insatiable need.  The naughty bitch! She knows she's going to get what she wants, whether you like it or not.  You wish you were able to control yourself, but the covetous succubus never lets go of your " + cockDescript(0) + ", clinging to it like an animal.");
	outputText("\n\nYour stamina is rapidly overwhelmed and you decide to reward her effort; you savagely press Vapula's head against your groin, effectively burying all " + num2Text(Math.round(player.cocks[0].cockLength)) + " inches of your " + cockDescript(0) + " in her waiting throat; her tongue keeps teasing your rod for a few seconds, and then you cum, brutally.  ");
	if(player.balls > 0) outputText("Your " + ballsDescriptLight() + " churn");
	else outputText("Your " + cockDescript(0) + " twitches");
	outputText(" as you release a sticky spooge fountain in her stomach.  Her lips keep squeezing your junk in order to milk everything you've got, and in your shuddering orgasm you're too eager to comply.  With a surrendering sigh, you abandon yourself to your climax and keep cumming, squirting your baby-batter to the last drop as the succubus keeps gulping it.  Her eyes are closed in an expression of complete satisfaction; she enjoys her meal to its full extent, filling her belly with your spooge");
	if(player.cumQ() >= 1500) outputText(" until she looks six months pregnant");
	outputText(".  At last, the cum-flow spilling through your urethra starts to ebb and your " + cockDescript(0) + " stops throbbing; only then does she removes your junk from her mouth with a loud POP.  Your " + cockDescript(0) + " appears to be clean of any spooge: your cock-slut did a very good job.  Satisfied, you pat her head with your cock and let her digest her lavish meal.");
	stats(0,0,0,0,0,0,-100,.5);
	flags[VAPULA_DAYS_SINCE_FED] = 0;
	flags[VAPULA_TEASE_COUNT] = 0;
	doNext(13);
}

//Threesome
function vapulaThreesomeMenu():void {
	clearOutput();
	outputText("Who do you invite?");
	//Option: Amily
	var amily:int = 0;
	//Option: Ceraph
	var ceraph:int = 0;
	//Option: Sophie
	var sophie:int = 0;
	//Option: Jojo
	var jojo:int = 0;
	//Option: Izma
	var izma:int = 0;
	if(player.hasCock() || (player.hasVagina() && player.hasKeyItem("Demonic Strap-On") >= 0)) {
		if(campCorruptJojo()) jojo = 3759;
		if(amilyFollower() && amilyCorrupt() && player.hasCock()) amily = 3761;
		if(ceraphIsFollower() && player.hasCock()) ceraph = 3767;
		if(bimboSophie()) sophie = 3764;
		if(izmaFollower() && flags[IZMA_NO_COCK] == 0) izma = 3757;
	}
	choices("Amily",amily,"Ceraph",ceraph,"Sophie",sophie,"Jojo",jojo,"Izma",izma,"",0,"",0,"",0,"",0,"Back",callSlaveVapula);
}

//Vapula-Ceraph threesome
function vapulaCeraphThreesome():void {
	clearOutput();
	outputText("Using your magical talisman you summon Ceraph, your omnibus slut; she seems to appear out of nowhere and gleefully strides toward you as you are lasciviously holding Vapula in your arms and caressing her. The naked omnibus watches your unholy embrace, bemused: \"<i>I see you're quite busy, " + player.mf("Master","Mistress") + ". I won't disturb you further.</i>\"  You point a finger at Ceraph while your other hand keeps stroking Vapula's tender ass and tell her to come immediately, your voice sounding almost breathless in your lust.  Startled by the imperiousness of your tone, the omnibus comes closer, not sure what to do as you keep toying with your purple wanton bitch.  You impatiently yank Ceraph's arm and pull her closer to Vapula in such a way that both hell-girls are now practically pressing their lush bodies against each other.  You tell your sluts that you will have your way with both of them; you feel your ");
	if(player.hasCock()) outputText("dick");
	else outputText("pussy");
	outputText(" deserves a special kind of treatment.  Vapula and Ceraph are both thrilled in excitement.");
	outputText("\n\nHow will you take them?");
	//Plz both - requires dick
	//Option: Butt-fuck train. Requires Ceraph to be herm.
	simpleChoices("Please Both",vapulaCeraphThreesomePleaseBoth,"AnalTrain",vapulaAndCeraphButtfuckTrainYeehaw,"",0,"",0,"",0);
}
//Option: Please both.
function vapulaCeraphThreesomePleaseBoth():void {
	clearOutput();
	var x:int = player.cockThatFits(100);
	if(x < 0) x = player.smallestCockIndex();
	outputText("You order your girls to turn around; you want to give them a good dicking.  They comply while giggling like a pair of whores, eager to get some cock up their holes.");
	outputText("\n\nYou push Vapula onto the floor, making her fall on her back, legs spread.  You then grab hold of Ceraph shoulders and put her on all fours, her warm snatch facing Vapula's.  Already moist, the succubus and the omnibus all naturally start caressing each other, kissing and groping each other's breasts.  You watch them giving in to their own depravity before joining the show; grabbing Ceraph's plump butt, you press the tip of your " + cockDescript(x) + " against her backdoor.  The unexpected intrusion makes the omnibus cry, her gasps of joy only enticing you to push further, even at the cost of stretching her anal ring.  A few seconds later you're all the way in, enjoying the boiling and tight recesses of her pucker.  You roughly seize Ceraph's fuck-pillows and proceed to relentlessly assault her ass, making her yell under the conjugated efforts of your throbbing junk and the hot succubus fingering her from below.  Completely dominated by the pleasure you're inflicting on her, your slut starts muttering dirty words, often interrupted by sudden screams, \"<i>Fuck... fuck... fuck my ass... " + player.mf("Master","Mistress") + "...feels so- AAAAAH! Oh FUCK YEAH! Harder, " + player.mf("Master","Mistress") + "! Fuck your bitch!</i>\"");
	
	outputText("\n\nAnnoyed by the noise she's making, you slap her firm rump repeatedly, your hands imprinting marks on her red ass-cheeks.  Your buttslut doesn't seem to care, completely blissful from being used by her rightful " + player.mf("Master","Mistress") + ".  She groans, grinds harder and squirms in Vapula's embrace in her efforts to impale herself further on your " + cockDescript(x) + ".  The sight of your sluts' love-tunnels mixing their fluids together as they squirt as well as the insane motion of Ceraph's wobbling ass sending the sweetest sensations to your rod prove too much for you; despite your best efforts to hold back, you blast Ceraph's ass with your baby-batter, the globs effectively packing her anal entrance");
	if(player.cumQ() >= 1500) outputText(" and swelling her belly until she looks ready to give birth to a full horde of imps");
	outputText(".");
	outputText("\n\nYou feel your ");
	if(player.balls > 0) outputText(ballsDescriptLight() + " twitch and your " + cockDescript(x) + " pulsate as they unload their");
	else outputText("your " + cockDescript(x) + " twitch and pulsate as it unloads its");
	outputText(" essence into your omnibus pet, bringing her to orgasm as she blubbers incoherently, \"<i>Oh yessssssssss, just like that... Yeah...my ass...cum...yessssssssss...</i>\"  Her voice goes so high pitched it trails off, letting you hear Vapula's soft moans below.  You quickly pull out your " + cockDescript(x) + ", still orgasming.  You hear Ceraph feebly protest at the sudden lack of cock filling her hole, \"<i>What are you doing? Put it back! Put it back already!</i>\"");
	outputText("\n\nWith another slap you tell her to shut up and learn to share; her partner hasn't received any cock yet, and you intend to remedy it.  Grabbing Vapula's thighs this time, you lunge toward her wet fuck-hole and bury your " + cockDescript (x) + " to the hilt, ");
	if(player.balls > 0) outputText(ballsDescriptLight() + " hitting her butt-hole with a faint thud");
	else outputText("thudding up against her cushy butt-cheeks");
	outputText(".  The purple sex-goddess squeals, your abrupt dick-digging utterly ravaging her cunt; her unholy warmth and impossibly tight confines are almost enough to make you cum instantly as her vaginal walls wrap in the most sensitive way around your rod, but you manage to hold off the flow of semen churning in your groin.");
	//[if 2nd cock]
	if(player.cockTotal() > 1) outputText("\n\nDeciding to put some of your junk to use, you eagerly grab your next dick and grind it against Ceraph's buttocks, bracing her for a second round of butt-fucking.  \"<i>No, not again! Please fuck another ho-OOOOOH!</i>\" her protests are quickly silenced as you easily slide your extra cock through her already stretched anal entrance, the penetration made easier due to your previous butt-fuck.  The sensation of having two cocks buried deep in hot, tight demon holes is incredibly exalting; you rest there for a moment, feeling the warm body of your sluts writhing against you as they try to milk you of your seed.");
	//[if 3rd cock]
	if(player.cockTotal() > 2) outputText("\n\nBut there is still extra room left. You toy with your third member, wondering which hole shall be pierced next.  You finally choose to honor Vapula's tight butthole, just to spite that egotistical omnibus bitch who begged for more cock when she had received a fair ass-dicking earlier.  Besides, Vapula could really use a good butt-fuck.  Teasing the purple's succubus anal entrance with your fingers, you slowly stretch her muscles, opening her rectum little by little and making her shrill in pain and pleasure mixed; then, when you think the opening is wide enough, you slam all of your hardness inside, plowing her interior and knocking at the back of her colon.  Her ear-piercing thrill turns into a loud, low-pitched growl.  Her demon-hot anus is so tight it nearly crushes your cock!  The rough friction of your junk grinding against her interior sends all kinds of tickles into your throbbing erection, tearing your mind into pieces as it abandons itself to raw pleasure.");
	//[if 4th cock]
	if(player.cockTotal() > 3) outputText("\n\nThe sight of Ceraph's moist, shiny nether-lips is too tempting for you to resist; even though you don't want to give in to your bitch's desires that easily, your fourth penis is trembling and aching with need, and ignoring it when there's a vacant hole is just plain stupid.  You decide to give her the dick she's been begging for, and with a rude, hard trust you plunge your rod down her baby-maker.  You pant, thrilled in ecstasy as four amazing demonic holes contract and clasp around your many manhoods, milking them of all your spooge.  You crouch around your sluts, groping some hot succubi tit-flesh and drooling on Ceraph's hair as you abandon yourself to your their lush depths.  You thrust like a possessed minotaur, unable to control anything but the pace of your hips as they simultaneously pound every fuck-hole.");
	if(player.cockTotal() > 4) outputText("  Sadly, your extra junk does not have any hole left to fill.  It just hangs there, rubbing against Ceraph's backside and teasing her all the more.");
	//[if less than 4 cocks] 
	if(player.cockTotal() < 4) outputText("\n\nYou keep thrusting fast and rough, paying little attention to the damage your hard fucking may cause to your girls' internal walls.  Once you get a bit tired, you switch holes.  Ceraph's snatch needs some love too, after all.  You furiously impale your sluts with all your might, groaning in effort and clawing their soft flesh in your ferocious grip.  You alternatively mash your groin against Vapula's, then Ceraph's, then Vapula's again.  Every time you pull out one of them starts mewling like a goblin in heat but you don't care; you keep pumping in and out of each hole, savoring every second of this stunning hard fuck-session.");
	//end of condition
	outputText("\n\nYou keep fucking your girls, making them moan alternatively.  The high-pitched screeches from Ceraph intertwine with the lewd, continuous rattles of Vapula as you pound her ass.  Combined with your periodic grunts, their pleasure-filled cries resound into a lustful song of depravity.  You're sure everyone must hear you but you keep going, only obsessed by the thought of filling your purple whores with more dick, more dick, and more dick.  You feel the warm and undulating body of Ceraph as well as the iron clasp of Vapula as she drags you into this infernal embrace; the cock-hungry whores below you have orgasmed so many times you have lost the count, their fem-cum accumulating in a thick puddle below Vapula's ass as they keep shuddering and trembling in turns.  Their unholy, demonic musk invades your nostrils and invigorates you all the more.  Your [feet] slip as you try your best to stuff as much of your junk as possible in their warm wet holes.");
	outputText("\n\nAt last, you can't keep up with this insane fucking rhythm.  Your blood is boiling with primal lust; your whole body is sweating and polluted with the vaginal squirting of your demon pets.  Once again, your balls swell and churn, ready to unload another glorious deposit of your seed inside your sluts' tight confines.  Feeling the release coming soon, you pump harder, determined to drain both girls of their stamina before they drain you of your spunk.  And before you even think of it, you cum.  A powerful jet escapes from the tip of [eachCock], literally drenching their bodies with your fluids.  In your mad and violent thrusting, you don't even know whose hole had the privilege of being fully stuffed with your baby-batter, but the insanely hot, tight and deliciously rough friction makes you think you just blasted an ass with jism.  Satisfied, you quickly remove your still pulsating dick and dive it into another hole, letting your succubus as well as your omnibus bitch enjoy a last intrusion as your junk spurts its last globs of semen.  Their vaginal walls are still contracting on their own and release another powerful spray of girl-juice, almost at the same time.  With a last, orgasming unison-moan, they relax, exhausted.  You promptly fall to the side, [eachCock] half-erect, coated with vaginal fluids, and still dribbling their residual cum. Completely soaked with dirt and spunk, your sluts just lie there, oblivious of their surroundings.");
	outputText("\n\nBut you're not done with these sluts yet.  Shaking Ceraph's shoulders, you remind her she still has a job to do.  The omnibus awkwardly squishes in the puddle of cum as she tries to stand up, but you quickly interrupt her and brutally shove your genitals in front of her face, looking at her impatiently.  Obviously knowing what you expect her to do, she proceeds to lick your cum-stained cock clean, suckling on the tip and carefully squeezing your dickflesh to extract as much remaining spunk as she can.");
	//[if multicocks]
	if(player.cockTotal() > 1) outputText("  She expertly jerks each of your rods in turn, gently polishing them as they grow back into an erect state.");
	outputText("  She's obviously used to this kind of practice; even though [eachCock] felt numb after cumming so hard, you feel your lust build up again as your genitals throb once more with need.  You grab Ceraph's head and impale her on your crotch, forcefully throat-fucking her.");
	outputText("\n\nWhile enjoying Ceraph's sweet and skilled blowjob, you lend a hand to your purple succubus, her beautiful body shining from all the sexual filth coating her.  You help her to her feet and pull her, pressing her melon-sized tits against you and kissing her savagely.  Still exhausted from the hard fuck, she weakly moans and hugs you tighter.  She places herself behind your back and starts rubbing her big, perky tits against you, her tall form wrapped around your chest.  She caresses you expertly, her adept hands running sensually over your sensitive points as she grinds her nipples against your back.  From time to time you turn your head and give her another passionate kiss, enjoying the delectable taste of her mouth.");
	//[if multicocks]
	if(player.cockTotal() > 1) outputText("\n\nYou tell Vapula to join Ceraph and help her out.  She looks puzzled at first, then quickly understands as you grab hold of her head and wave your second member at her.  She nods excitedly and rapidly starts sucking you off as well, her adroit lips and deft tongue entirely enveloping your meat.  She's as good at blowjobs as Ceraph, if not more.");
	outputText("  Your thoughts are quickly drowned in waves of pleasure, and soon your only thought is to ram more of your " + cockDescript(x) + " down your sluts' throats, pumping their heads alternatively around your shaft");
	if(player.cockTotal() > 1) outputText("s");
	if(player.balls > 0) outputText(" as the girls keep fondling your " + ballsDescriptLight());
	outputText(", bringing you extra tingles of pleasure to your body.");
	
	outputText("\n\nAt last, the sweet ministrations of your pair of hell-girls prove too much for your cum-stained body and you spurt a third load of spooge, [eachCock] quivering and trembling as it unloads its ultimate shot of semen directly in a waiting stomach.  The hell-girls cling to your dick");
	if(player.cockTotal() > 1) outputText("s");
	outputText(", their lips doing their best to milk ");
	if(player.cockTotal() == 1) outputText("it");
	else outputText("them");
	outputText(" of all ");
	if(player.cockTotal() == 1) outputText("its ");
	else outputText("their ");
	outputText("creme.  Once your junk feels completely empty, [oneCock] is released with a loud POP.");
	outputText("\n\nSatisfied, you kiss both of your sluts.  \"<i>Thank you " + player.mf("Master","Mistress") + ".</i>\" they say in unison, before you pat their heads and send them on their way; they will probably need to rest in order to digest their heavy meal.");
	//lust set to 0
	stats(0,0,0,0,0,0,-100,1);
	if(player.lib > 10) stats(0,0,0,0,-1,0,0,0);
	if(player.lib > 50) stats(0,0,0,0,-1,0,0,0);
	if(player.lib > 70) stats(0,0,0,0,-1,0,0,0);
	flags[VAPULA_DAYS_SINCE_FED] = 0;
	flags[VAPULA_TEASE_COUNT] = 0;
	doNext(13);
}
//Option: Butt-fuck train. Requires Ceraph to be herm.
//Ceraph-Vapula Buttfuck train
function vapulaAndCeraphButtfuckTrainYeehaw():void {
	clearOutput();
	var x:int = player.cockThatFits(100);
	if(x < 0) x = player.smallestCockIndex();
	outputText("Grinning lewdly, you dispose your omnibus and your succubus in a front line such that Ceraph's cock points toward Vapula's anus.  Ceraph pants expectantly.  \"<i>What do you have in mind this time, Master?</i>\" Without a word, you place yourself behind Ceraph's back and start stroking [eachCock] against her butt-cheeks, your tip dribbling pre-cum teasingly; you shove a few fingers into Ceraph's warm snatch, stimulating her until she lets out a muffled moan as her own cock grows to full erectness.  At last, you ready yourself, your cock knocking on Ceraph's backside.  You gently explain to your girls that you're going to initiate a butt-fuck train.  Vapula giggles softly, \"<i>Ooooh, I love this!  But... wait, I'm in the front of the -</i>\"");
	outputText("\n\nWithout any warning, you harshly push your " + cockDescript(x) + " in Ceraph's tight anal recesses, making her clench and tense in arousal.  She immediately responds by grasping Vapula's squeezable thighs and digs her own, broad prick inside the succubus' colon.  The totally unexpected rectal assault makes both hell-girls scream in surprise and pleasure mixed, their anal walls saturated with intense dick-friction.  You stand here comfortably, easily lodging your " + cockDescript(x) + " inside Ceraph's backdoor while letting her have a better grip on Vapula's buttocks.  The omnibus' pucker is insanely hot!  Your rod of flesh feels like it's going to melt under her demonic warmth, and her astonishingly narrow colon squeezes it in the most harsh and delightful way.  You decide to speed up the pace and start sliding back and forth, ");
	if(silly()) outputText("screaming at the top of your lungs: \"<i>BUTT-FUCK! BUTT-FUCK! BUTT-FUCK!</i>\", soon joined by your horny anal partners");
	else outputText("groaning and panting as you ravage Ceraph's pucker with your junk");
	outputText(".\n\n");
	outputText("Between two mad thrusts, you order Ceraph to imitate you in every movement, treating Vapula the same way you treat her.  You start slapping her jiggly ass, sending ripples across her red shivering flesh.  Entranced by your violent ministrations, the omnibus complies to your orders, spanking Vapula as hard as she can.  Soon moans are heard all across the butt-fuck train; the more you slap and thrust, the harder Ceraph hits the purple sex-goddess, as if she wanted to prove she was a better servant, worthier of your " + cockDescript(x) + ".  You reach around and knead Ceraph's tits, playing with her nipples as you devastate her backdoor with ferocious dick assaults, and she hesitantly grasps Vapula's bouncy tits, unable to match your thrusts in intensity.  She jerks her head backwards and moans, almost forgetting her own prick impaling the poor succubus in front of her.  Seeing that the poor bitch has lost all control over her own body, you stretch your arms further and reach Vapula's breasts.  The succubus is literally drooling in ecstasy; forced to feel the mighty thrusts of a strong omnibus as well as yours, she is bent over submissively, her tongue hanging and her eyes rolling under the combined strength of your anal-dickings.  You pound harder, squeezing her tits at each cock-nudge and muffling her pleasure-filled shrieks when you can.");
	
	outputText("\n\nAs for Ceraph, the poor thing isn't even able to think anymore.  Her rhythmical moans have been gradually replaced with some incoherent dirty babble, \"<i>Oh fuckfuckfuck... good.. fuck...  YES! Fuck... yes... fuckfuckfu-aaaAAAAAH!</i>\"  You keep impaling the omnibus' butthole with your " + cockDescript(x) + ", pounding harder in hope the anal tearing will shut her up, but she only seems to get even more pleasure from such a violation of her insides.  Her mind isn't able to reason properly, torn between her ferocious butt-penetration and the pleasure her own cock is getting as it moves of its own volition in and out of Vapula's tight little pucker.");
	
	outputText("\n\nYou pump more and more, growing more impatient and vicious as you feel your climax approaching.  You slap Ceraph's face, you toy with her nipples, you pinch Vapula's butt, you block Ceraph's thrusts midway, making both demonesses whimper in frustrated desire.  And all the while, you keep butt-fucking Ceraph at a crazy pace, yelling like a " + player.mf("man","herm") + " possessed as you claim her impossibly tight confines with unequaled intensity.  You ride the butt-fuck train, submitting both girls to your will as their anal entrances keep being assaulted over and over again.  Their warm love-tunnels are literally steaming in arousal and their feminine juices are being spilled in a free flow of lust.");
	//[if balls] 
	if(player.balls > 0) outputText("  As you relentlessly smash your groin against Ceraph's plump rump, your " + ballsDescriptLight() + " repeatedly hit her quivering vagina; they are soon utterly coated in fem-spunk.");
	outputText("  The entirety of your crotch ends up drenched with a various mix of sexual juices, and your " + cockDescript(x) + " makes squelching noises at each thrust in and out of your omnibus' little ass.");
	
	outputText("\n\nEventually, you feel your stamina decreasing as a pressure builds in your loins and you brace yourself for the imminent cumshot. With a savage, desperate last thrust, you thoroughly impale the purple demoness on your junk and paint her interior walls with an explosion of spooge.  A mighty spray of cum spurt out of your " + cockDescript(x) + ", completely stuffing Ceraph with your seed.");
	if(player.cumQ() >= 1500) outputText("  She automatically clenches her anus in order to keep as much of your baby-batter inside, but to no avail; torrents of white goo start spurting out of her rectum, splattering her legs and your groin.");
	outputText("  This sudden extra pressure on her colon send Ceraph over the edge, and she cums too; bleating in ecstasy, she grabs Vapula's hips and shoves her cock all the way inside her backdoor as she releases a milky flood of her own.  For several seconds you all stand there, fluids steadily flowing in and out of Ceraph as you both climax.  Vapula, literally mindbroken by the intense butt-fuck, utterly abandons herself to her pleasure and her pussy explodes in an abundant spray of fem-juices.  Ceraph's pussy quivers and convulses, her mad arousal making her squirt juices in thick torrents from her feminine counterpart.  The whole wagon of peckers and butts stands still, frozen in pure ecstasy as fluids keep dripping of every hole and dick.  A dirty puddle, formed by all the sexual juices spurted by your depraved embrace, grows and thickens as your " + cockDescript(x) + " as well as Ceraph's keep pulsating in orgasm. At last, when every cock has been milked of all its seed, you relax.");
	outputText("\n\nYou dump your buttsluts, letting them splash in the cum-puddle, exhausted. Triumphantly exhibiting your " + cockDescript(x) + ", you tell them to finish their job.  Vapula and Ceraph growl reluctantly as they grovel in the spunk-tainted mud and crawl toward your junk before licking it with delectation.  You let them enjoy their meal, groaning in pleasure as they squeeze their pittance out of your " + cockDescript(x) + " and suck out the last globs of semen out of your urethra.  When you're all absolutely positive that no residual cum has been wasted, you smirk in satisfaction; you give your sluts a hard cock-slap for good measure and send them away.");
	//Lust set to 0
	stats(0,0,0,0,0,-2,-100,1);
	flags[VAPULA_DAYS_SINCE_FED] = 0;
	flags[VAPULA_TEASE_COUNT] = 0;
	doNext(13);
}

//Vapula-Sophie threesome
function vapulaSophieThreesomeSelect():void {
	if(player.hasCock()) vapulaSophieThreeSome();
	else vapulaSophieThreesomeCunts();
}
function vapulaSophieThreeSome():void {
	clearOutput();
	outputText("You call Sophie insistently, panting in anticipation.  The blond-feathered bimbo doesn't come at first - perhaps the dumb slut forgot her name again - but as you grow more impatient you finally notice the platinum-headed woman, her enormous boobs bouncing hypnotically and her luscious thighs swaying lustfully as she walks.  She grins beatifically and coos: \"<i>Yes?  Is there anything I can, like, do for...ooooh, but who's this?  She's sooooooo beautiful!  She's got, like, big boobs and stuff!</i>\"  Vapula sighs in consternation.  \"<i>What can you do with her, " + player.short + "? I'm sure she's going to forget my presence by next hour.</i>\"");
	outputText("\n\nYou hush her up and tell to follow you.  You walk toward the harpy bimbo as she idly fingers her twat; her eyes lighten up as you approach, always longing for some action.  \"<i>Wanna fuck?</i>\" You smirk and lunge toward your bird slut, engulfing your head in her bountiful bosom and sucking on her hard nipples.  Sophie moans softly and starts stroking your head;  you move your head up and kiss her gluttonously, enjoying the potent effect of her lipstick as it flows through your veins and brings [eachCock] to a fully aroused state.  You pull back and stare at Sophie for a moment, her eyes gleaming in adoration as she giggles and kisses you everywhere, invigorating you more and more.  You tell Vapula to come over and help you out.  With a mighty torsion, you both turn over that bountiful avian body, forcibly putting her on all fours and ignoring her complaints.  Her enormous ass is now fully exposed, wobbling and blushing in arousal, and her blond wings keep flapping aimlessly as the bimbo croons in incomprehension.  You dig Sophie's plush ass-cheeks with your fingers, bracing yourself for an imminent butt-fucking.");
	outputText("\n\nVapula comments, \"<i>Well, that's one air-brained bimbo.  I've rarely had the chance to have my way with one of these bird-bitches; they're at war with Lethice, you know.  Could I get a taste of this fine ass?</i>\"  You silence her and remind her that this feathered slut is yours; you have the right to lay claims on her ass, and by the Gods you intend to use that right to its full extent.  Meanwhile, Sophie keeps simpering whorishly below you, \"<i>Hey, hey, what are you doing?  Are you, like, talking about me or something?</i>\"");
	outputText("\n\nCompletely ignoring her, you keep arguing with Vapula about that sumptuous yet controversed rump.  Vapula is complaining, \"<i>But if you take her and blow your load inside her, where will I get my meal from? She's just a dumb harpy bitch, she doesn't need your dick; I do, I need to feed!</i>\"");
	outputText("\n\nYou laugh at the purple succubus and reassure her: seeing the sheer amount of lipstick you've just absorbed, you're pretty much loaded to satiate an entire horde of horny goblins.  With a pressing tone, you command her to sit on Sophie's back, just between her wings and you, such that she directly faces you and her pussy grinds against the harpy's generous buttocks.  You explain your plan, \"<i>I'm going to butt-fuck this bimbo, like it or not.  Now your job is to please me.  Butt-fucking people is a hard and tedious task and I'm going to need a lot of comfort to keep going.  You have no idea how much comfort I may need.  Do your best, and if you're good enough I'll let you taste my cum.  Understood?</i>\"");
	outputText("\n\nVapula nods and smirks as she accepts the challenge you've put out on her.  Sophie agitates below the two of you: \"<i>Hey guys, what's going on? Someone's just sitting on my ass and it feels, like, all hot and stuUUFFFFFF!</i>\"");
	outputText("\n\nWithout ceremony you grab the avian slut's fuckpillows and eagerly sandwich your meat between them, pressing the tip of your " + cockDescript(x) + " against her tight anus.  As soon as the first inches start sliding in, the bimbo slut flaps her wings frenetically as she squawks in pleasure, her anal muscles contracting on their own as an invitation to slide in further.  Before you even think of it ");
	if(player.cockArea(x) > 75) outputText("you've filled the entirety of her colon");
	else outputText("your cock is already buried to the hilt, its mammoth girth bulging between her broad hips");
	outputText("; the bulge even grinds a bit against Vapula's own butt and the succubus reaches toward you, entranced with lust.  She wraps her arms around you, letting you feel her tender boobs being squeezed against your [chest] as she gives you a mad kiss filled with passion.  Your lips remain locked for a while as you explore each other's mouths with your tongues; you almost forget the burning hot and roughly tight hole.  It entraps your " + cockDescript(x) + " as it continues massaging with the harpy's vice-like anal muscles.  The bimbo keeps wriggling arond your rod in order to get more of it inside, pleasantly smashing her fat rear against your groin.");
	outputText("\n\nStill not breaking the kiss, you groan silently and pull out your " + cockDescript(x) + ", all smeared in pre-cum.  Sophie whimpers and wails softly until you thrust all the way back in, literally jamming her with your junk.  Her pupils widen, her mouth opens and her gigantic tits keep swinging in the dirt as her whole body trembles and shudders from the brutal anal violation.  Her cry of pleasure is so high-pitched you barely hear her subsequent moan; satisfied, you start thrusting at a more convenient rhythm, enjoying the lush depths of the avian slut as the succubus keeps making out with you.  You keep butt-fucking Sophie, unable to focus on the ministrations of the expert succubus or the extremely warm recesses of the harpy's interior.  You regularly slap her plush, fat buttocks, sending ripples across her whole fleshy body. Needless to say, the bimbo's pussy is completely drenched in fem-spunk, her wide pussy drooling trickles after trickles of her juices, betraying her utter arousal.");
	//[if 2nd cock]
	if(player.cockTotal() > 1) outputText("\n\nIt would be a shame to waste such a welcoming love-tunnel.  Grabbing hold of your second prick, you push it down her vaginal entrance, effectively double-penetrating her.  Sophie moans all the more from the unexpected intrusion, and with such a lush hole, you easily slide the rest of your prick inside.  Her wings keep flapping in irregular motions as you fuck each of her holes at the same time with both of your cocks.  You pump at her entrances with nigh inhuman intensity, each prick vying with the other in a contest of licentiousness.");
	outputText("\n\nVapula is now taking care of your groin.  Darting a hand at your crotch, she gently fondles your ");
	if(player.balls > 0) outputText("balls and massages your ");
	outputText(buttDescript() + ".");
	//[if third cock]
	if(player.totalCocks() > 2) outputText("  Using her extra flexibility, she bends over and start jerking your third pole, the sweet handjob adding to your pure cocktail of pleasure.");
	outputText("  You can feel her hard nipples poke at your skin as they gently scrape across your torso.  Vapula hardly ever interrupts her embrace, only pulling back from your lips to take care of other intimate parts of your body.  You keep riding the bimbo senseless, making her squirm and squawk in ecstasy as your own cries of pleasure are muffled by Vapula's voracious lips.");
	outputText("\n\nVapula's expert stimulation as well as Sophie's uncontrollably hot ass eventually drain your stamina and you feel [eachCock] flutter and twinge as it releases its milky load.  Sophie climaxes and squirts a copious amount of her juice as you deliver rope after rope of jism into her tight confines.  Remembering your succubus slut, you ");
	if(player.cockTotal() < 3) outputText("hastily pull out and ");
	outputText("wave ");
	if(player.cockTotal() >= 3) outputText("one of ");
	outputText("your still pulsing dick");
	if(player.cockTotal() >= 3) outputText("s");
	outputText(" at Vapula, spraying her purple body with white paint.  She welcomes the cum-rain with a happy squeal that turns into a demonic cry of pleasure when you stuff your protruding rod inside her steaming love-tunnel, directly injecting your seed in her womb.  She pulls your head between her chest orbs, screaming in delight as you feed her.  \"<i>Yes!  YES!  Give it to me!  Aaaaaaaaaaaaaaahhh....</i>\" she growls in utter bliss and satiation as you fill her with even more spunk.  The poor bimbo below you is still busy squirting unbelievable amounts of girl-juices, literally flooding a large perimeter with a mix of various sexual fluids as her large pussy muscles keep contracting on their own.");
	outputText("\n\nWhen you're all done, you dismount.  Your mouth is filled with the succubus' essence, and Gods it tastes good.  You tell Vapula to get off Sophie's butt too; as soon as she does the bimbo completely clenches and relaxes before falling into a deep slumber, her stretched anus still exposed as she snores and wallows in a pool of juices, mostly her own.  \"<i>Finish your meal</i>\", you tell Vapula.  The tired succubus complies and proceeds to suck the last remaining bits of escaping goo from the harpy's tight anal contraction.  Then, she keeps licking and squeezing your " + cockDescript(x) + " until it shines, completely polished with succubus saliva.");
	outputText("\n\n\"<i>Enough. You should rest now.</i>\"  Nodding, Vapula heads toward her leaf-bed in order to recover from the intense threesome and digest her copious meal.");
	//lust set to 50, lipstick affect (if no adaptation)
	luststickApplication(10);
	stats(0,0,0,0,0,0,-100,2);
	flags[VAPULA_DAYS_SINCE_FED] = 0;
	flags[VAPULA_TEASE_COUNT] = 0;
	if(player.lust < 50) player.lust = 50;
	doNext(13);
}
//Vapula-Sophie threesome (as female)
function vapulaSophieThreesomeCunts():void {
	clearOutput();
	outputText("You call Sophie insistently, panting in anticipation as you slide into your strap-on's harness.  The blond-feathered bimbo doesn't show at first - perhaps the dumb slut forgot her name again - but as you grow more impatient you finally notice the platinum-headed woman, her enormous boobs bouncing hypnotically and her luscious thighs swaying lustfully as she walks.  She grins beatifically and coos, \"<i>Yes? Is there anything I can, like, do for... ooooh, but who's this?  She's sooooooo beautiful!  She's got, like, big boobs and stuff!</i>\"  She claps her hands with even greater excitement as she turns her attention to you, or rather your crotch.  \"<i>And you've grown a cock!  I've made a new friend and I've, like, got a nice big cock to play with!  This is the best day of my life!</i>\" You think she genuinely means it.");
	outputText("\n\nVapula sighs in consternation.  \"<i>What can you do with her, " + player.short + "? I'm sure she's going to forget who I am in an hour.</i>\"");
	outputText("\n\nYou hush her up and tell her to follow you.  You walk toward the harpy bimbo as she idly fingers her twat; her eyes lighten up as you approach, always longing for some action.  \"<i>Wanna fuck?</i>\"  You smirk and lunge toward your bird slut, engulfing your head in her bountiful bosom and sucking on her hard nipples.  Sophie moans softly and starts stroking your head; you straighten up and with little encouragement get her to kneel, eagerly licking and kissing the purple dildo until it glitters with wet gold.  As she works it, you tell Vapula to come over and help you out.  With a mighty torsion, you both turn over that bountiful avian body, forcibly putting her on all fours and ignoring her complaints.  Her enormous ass is now fully exposed, wobbling and blushing in arousal, and her blond wings keep flapping aimlessly as the bimbo croons in incomprehension.  You dig Sophie's plush ass-cheeks with your fingers, rubbing the purple dildo between them, sighing with pleasure as you rotate your own hips, turning the pink end around in your wet depths, building yourself into the kind of lust maddened state sufficient to hand out the butt-fucking your poor dumb bird-bitch deserves.");
	
	outputText("\n\n\"<i>That's one air-headed bimbo,</i>\" Vapula comments, lazily fingering herself as she watches you.  \"<i>I've rarely had the chance to have my way with one of these bird-bitches; they're at war with Lethice, you know. Could I get a taste of this fine ass?</i>\" You silence her and remind her that this feathered slut is yours; you have the right to lay claims on her ass, and by the Gods you intend to use that right to its full extent.  Meanwhile, Sophie keeps simpering whorishly below you: \"<i>Hey, hey, what are you doing? Are you, like, talking about me or something?</i>\"  Completely ignoring her, you keep arguing with Vapula over the former's sumptuous yet disputed rump.");
	outputText("\n\nVapula is complaining, \"<i>But if you take her and blow your load inside her, where will I get my meal from?  She's just a dumb harpy bitch, she doesn't need the strap-on; I do, I need to feed!</i>\"  You laugh at the purple succubus and reassure her: you don't know quite how the strap-on functions, but given the sheer amount of lipstick it's just absorbed, you reckon that it is straining as tight as a crossbow.  With a pressing tone, you command her to sit on Sophie's back, just between her wings and you, such that she directly faces you and her pussy grinds against the harpy's generous buttocks.");
	outputText("\n\n\"<i>I'm going to buttfuck this bimbo so hard she won't be able to sit down for a week.  It's not for my benefit,</i>\" you go on, in an arch tone.  \"<i>I don't get anything from reaming this dick in and out of her ass; it's just what she needs and deserves.  You are my entertainment whilst I go about this Gods-given task.  Make it pleasing for me, and who knows, Maybe I'll give you what YOU need and deserve.</i>\""); 
	outputText("\n\nVapula licks her lips and smirks as she accepts the challenge you've laid out for her.  Sophie agitates below the two of you.  \"<i>Hey guys, what's going on? Someone's just sitting on my ass and it feels, like, all hot and stuUUFFFFFF!</i>\"");
	outputText("\n\nWithout ceremony you grab the avian slut's fuckpillows and eagerly sandwich your dildo between them, pressing the tip of it against her tight anus.  As soon as the first inches start sliding in, the bimbo slut flaps her wings frenetically as she squawks in pleasure, her anal muscles contracting on their own as an invitation to slide in further.  Before you even think of it your strap-on is already buried to its leather hilt, its mammoth erection bulging between her broad hips; the bulge even grinds a bit against Vapula's own butt and the succubus reaches toward you, entranced with lust. She wraps her arms around you, her tender boobs against your own " + allBreastsDescript() + " as she gives you a mad kiss filled with passion. Your lips remain locked for a while as you explore each other's mouths with your tongue; you almost forget the tight hole wrapped around your dildo.  You are brought back to it by the bimbo wriggling around the rod rammed in her rear in an attempt to squeeze more of it into her, twisting your end around in your sopping " + vaginaDescript(0) + " as she pleasantly mashes her fat rear against your groin.");
	outputText("\n\nStill not breaking the kiss, you groan silently and pull out your bulging dildo, already drooling its payload.  Sophie whimpers and wails softly until you thrust all the way back in, literally jamming her with your false junk.  Her pupils widen, her mouth opens and her gigantic tits keep swinging in the dirt as her whole body trembles and shudders from the brutal anal violation.  Her cry of pleasure is so high-pitched you barely hear her moan; satisfied, you start thrusting at a more convenient rhythm, enjoying the avian slut thrusting your strap-on back into you as your succubus keeps lavishly making out with you.  You regularly slap Sophie's plush, fat buttocks, sending ripples across her whole fleshy body.  Needless to say, the bimbo's pussy is completely drenched in fem-spunk, her wide pussy drooling trickle after trickle of her juices, betraying her deep arousal.");
	outputText("\n\nVapula shifts her attention to your breasts, her long tongue running lasciviously over your " + nippleDescript(0) + "s, tightly circling and gently teasing their tips until they are as sensitive and erect as any clitoris.  Her soft lips edge you further and further into your fuck daze, riding the bimbo senseless, making her squirm and squawk in ecstasy as your own cries of pleasure are muffled by Vapula's voracious lips.");
	outputText("\n\nVapula's expert stimulation as well as Sophie uncontrollably hot ass eventually drain your stamina and you buck into the harpy as hard as you can, helplessly eager for the return thrusts which push you towards orgasm.  You thrust your tongue deep into the succubus's mouth as you reach it, your pussy spasming around the hot, soft, vibrating mass buried within it.  Dimly, you are aware of the other end of the strap-on fluttering, twinging, and then releasing its milky load.  Sophie climaxes and squirts a copious amount of her juice as you deliver rope after rope of jism into her tight confines.  Remembering your succubus slut, you hastily pull out and wave the over-stimulated cum producer at Vapula, spraying her purple godly body with white paint.  She welcomes the rain with a happy squeal that turns into a demonic cry of pleasure when you stuff it crudely inside her steaming love-tunnel, directly injecting your seed in her womb.  She pulls your head between her chest orbs, screaming in delight as you feed her.  \"<i>Yes! YES! Give it to me! Aaaaaaaaaaaaaaahhh....</i>\"  She growls in utter bliss and satiation as you fill her with even more spunk.  The poor bimbo below you is still busy squirting unbelievable amounts of girl-juices, flooding the immediate area with a mix of various sexual fluids as her large pussy muscles keep contracting on their own.");
	outputText("\n\nAt last, when you're all done, you dismount.  Your mouth is filled with the succubus' essence, and Gods it tastes good. You tell Vapula to get off Sophie's butt too; as soon as she does the bimbo completely clenches and relaxes before falling into a deep slumber, her stretched anus still exposed as she snores and wallows into a pool of juices, mostly her own.  \"<i>Finish your meal</i>\", you tell Vapula, sighing as you peel out of the strap-on.  The tired succubus complies and proceeds to gently eat both the strap-on and your sex clean of the aftermath of your demented threesome.  She keeps licking at your pleasantly aching " + vaginaDescript(0) + " until it is completely clean, polished with succubus saliva.  \"<i>Enough. You should rest now.</i>\"  Nodding, Vapula heads toward her leaf-bed in order to recover from the intense threesome and digest her copious meal.");
	stats(0,0,0,0,0,0,-100,2);
	flags[VAPULA_DAYS_SINCE_FED] = 0;
	flags[VAPULA_TEASE_COUNT] = 0;
	doNext(13);
}
//Vapula-Amily threesome
function vapulaAndAmilyThreesome():void {
	clearOutput();
	var x:int = player.cockThatFits(100);
	if(x < 0) x = player.smallestCockIndex();
	outputText("\"<i>Amily!</i>\" you yell.  In no time a purplish blur rushes towards you; skidding to a halt, she kneels before you, hands behind her back, fully exposed.  \"<i>Yes my " + player.mf("Master","Mistress") + "?</i>\"  Amily says seductively, licking her lips.");
	outputText("\n\n\"<i>Oh but... you're not alone!  This is-</i>\"");
	outputText("\n\n\"<i>This is Vapula, another of my sluts; but for you, she's going to be your mistress. You will be her personal fuck-toy and you will please her in every way as you would please me. Is that clear?</i>\"");
	outputText("\n\nThe little mousy looks down awkwardly, intimidated by the towering succubus.  \"<i>Y-yes " + player.mf("Master","Mistress") + "...</i>\"");
	outputText("\n\nYou order Amily to get on her hands and knees and get ready for your dick. As the mousy cumdumpster braces herself for her imminent pounding, you tell your purple fuckbuddy to stand before Amily's mouth to be eaten out");
	if(player.balls > 0) outputText(": her drooling pussy needs to be prepared because you're going to take her next");
	outputText(".  Vapula smirks in excitement and eagerly shoves her tumescent pussy in front of the mousette's waiting lips; Amily keeps wagging her butt impatiently, looking forward to being used as a disposable anal-toy.  You wink at Vapula; she's going to like it.");
	outputText("\n\nGrabbing hold of your mouse's plush buttcheeks, you stretch her anal opening and in a brutal, powerful thrust, you slide all of your " + cockDescript(x) + " down her interior.  Amily immediately squeaks, her mouth drooling and her whole body twitching as she adapts to the erect prick inside her.  Her cries of pleasure are suddenly muffled as Vapula, too turned on to care about your mousette, brutally grabs her head and squeezes her face between her legs.  In the meantime, you start pumping at her ass, effortlessly moving your hips backwards and forwards as your " + cockDescript(x) + " ravages the mousegirl's insides.  The poor creature, already driven over the edge by your relentless anal pounding, is now forced to lick the succubus' luscious pussy, her tongue being forced into probing her lush depths at each thrust received from behind.  She keeps moving back and forth between Vapula and you, roughly mishandled as both ends of her body are being abused.  However, this does not seem to decrease in the least the pleasure she's getting. She joyfully slams back her ass against your groin at every thrust, her insides always hungry for more dickflesh.  Your hips are quasi-immobile as she impales herself on her own in an insatiable cock-hunger.");
	outputText("\n\nHer tongue appears to have magical effects on Vapula: the horny succubus keeps moaning, fondling her breasts with one hand while the other keeps pressing the mousette's head against her crotch.  Amily keeps exploring the succubus' love-tunnel with her tongue, her enthusiasm making up for her lack of experience.  She slurps and swallows every drop of fem-juice dribbling out of Vapula's cunt, making the demoness squirm; her face displays nothing but utter bliss.");
	outputText("\n\nAs your " + cockDescript(x) + " effortlessly slides deeper down your mousegirl's colon, your pre-cum acting as a slick lube against her tight anal ring, you decide to spice up things a little.  Leaning down on Amily's back, you reach over and start toying with her huge tits.  You knead her voluptuous orbs and pinch her nipples, making her whole body tremble in extreme arousal.  The purple hell-girl on the other side leans down too, quickly catching up on your intention; you kiss her ardently, the two of you locked into a demonic embrace, utterly oblivious of the cumslut undulating below you as her holes are being negligently used.");
	outputText("\n\nThis mad triangle of lust eventually breaks as Vapula pulls back feverishly and screams, her body taken by a series of shivering orgasms.  You watch in fascination as the succubus jerks and twitches hypnotically, her lustrous vagina delivering torrent after torrent of fem-spunk.  Amily's upper body is soon wholly drenched, despite her best efforts to waste as little of the succubus' juices as possible.  She keeps gulping at Vapula's baby-maker in a ravenous display of lust.");
	outputText("\n\nAs Amily drinks, you can't help but notice her body is slowly being transformed by Vapula's essence.  Her horns start growing, her hips widen; her tits keep burgeoning");
	//[if not defurred]
	if(flags[AMILY_NOT_FURRY] == 0) outputText(" and her fur starts shrinking, letting her rosy skin shine below");
	outputText(".  By Lethice, your succubus is literally warping your cumslut into a replica of herself!  All the more aroused by this obscene show of corruption, you pound harder, grabbing hold of her horns for better leverage.  At last, your " + cockDescript(x) + " is suddenly squeezed as Amily's ample butt swells under the taint of Vapula's juice; this extra pressure is enough to make you cum, your loins churning and your junk bulging as you shoot your load through Amily's anus.  The poor cumslut starts fainting from the sheer flow of spunk flooding her interior as well as her mouth; with a pathetic squirting orgasm, she goes limp and moans pitifully.  You pump ragingly as you reach your climax, making entire ropes of jism spurt in and out of her ass and slathering her backside.  Once your orgasm begins to falter, you carelessly drop your mousy slut, letting her crawl in a small pool of mixed juices.  Vapula lets go of Amily's jaw, discarding her disposable fuck-toy, satiated.");
	//[if balls]
	if(player.balls > 0) {
		outputText("\n\nYou speak in a hoarse, breathless voice, \"<i>It's not over.</i>\"  You shake the tired mousette, telling her she'd better get ready for another round.  Amily whimpers and squeaks feebly, but you pay no attention as you grab her shoulders and give her a perfect view of your dangling, cum-dripping " + ballsDescriptLight() + ".  You order, \"<i>Lick.</i>\"  As your mousy cumslut complies and starts tickling your gonads with her demonic tongue, you pull Vapula, bringing her close to you; she is still recovering from her intense orgasm and doesn't say anything as you spread her legs, darts your hand at her vagina, testing her wetness. Once you've teased her enough, you grab her hips, lift her and impale her dripping cunt on your " + cockDescript(x) + " with all your might.  The powerful intrusion makes the succubus moan, but you don't stop there; enclosing her with your arms, you savagely lift her up and down on your dicks, enjoying her fresh, wet warmth as you let her bounce atop you.  You hug her tightly as she twists wildly against your body, unable to restrain herself under your merciless ploughing.");
		outputText("\n\nAmily keeps sucking on your " + ballsDescriptLight() + ", her tongue absorbing any drop of semen dribbling from the vigorous clash of genitals above her.  Her repeated slurping and fondling makes your cum-receptacles swell again as your rising lust keeps loading them with more seed.  You feel a familiar pressure building at your crotch, your urethra inflating and pulsing as you keep pumping at Vapula's fuck-hole.  You keep up this crazy pace until your " + cockDescript(x) + " starts twitching on its own, releasing a milky stream directly into the succubus' waiting womb.");
		//[if cum production massive]
		if(player.cumQ() >= 1500) outputText("  Sticky globs of white goo are shot from the tip of your rod, effectively stuffing Vapula so full of your spooge that some of it drips out and rains down on Amily's face, sopping her with fluids. The succubus quivers in your arms, giving in to her lust before squirting a powerful spray of fem-spooge, splattering Amily even more.");
		outputText("  Once your orgasm starts fading, you drop Vapula and tell her to imitate Amily; the dilligent succubus gets on her knees and quickly licks your " + cockDescript(x) + ", feeding her cum-thirst as she cleans your junk of its spooge.  Your two sluts work quickly, easily sucking up every bit of goo until your " + cockDescript(x) + " eventually shrinks to a half-erect state, your lust consumed.");
	}
	outputText("\n\nYou give a pat to Amily's head, telling her she's been an excellent buttslut. The mousette blushes in contentment under the bemused eyes of Vapula; you give your demon pet a last kiss, telling her Amily is hers for the remainder of the hour.  Knowing how insatiable the succubus is, she'll probably try to suck out your cum out of Amily's ass.  You keep musing these perverse thoughts as you leave your sluts to their business.");
	stats(0,0,0,0,0,0,-100,2);
	flags[VAPULA_DAYS_SINCE_FED] = 0;
	flags[VAPULA_TEASE_COUNT] = 0;
	doNext(13);
}

//Vapula/Night Succubus
function vapulaAssistsCeruleanSuccubus():void {
	var x:int = player.cockThatFits(100);
	if(x < 0) x = player.smallestCockIndex();
	//[automatically triggers once the option Night Fuck is toggled and Cerulean potion is drunk, can't be selected from menu. Requires Cerulean potion to have been drunk once]
	outputText("\n<b>That night...</b>\nYou wake up Vapula, telling her to get ready for your \"guest\". You expose your " + cockDescript(x) + ", ordering your succubus slut to work you up into a proper aroused state.  The sleepy purple girl yawns a bit, still half-conscious from her dirty dreams, and you profit from the opening to shove your junk between her lips.  Clearly getting the message, Vapula starts licking it, her expert mouth taking all your length without even thinking of it.  She deepthroats you for a while, until you hear steps from outside the camp. In the moonlight you can make out a tall silhouette: the night succubus has come back.");
	outputText("\n\n\"<i>Ah, there you are. Come in, we were just waiting for you.</i>\"");
	outputText("\n\nA little surprised by the sight of Vapula, her mouth full of dick as you pump more and more inside her, the blue succubus clears her throat and cautiously walks toward you, not expecting this turn of events.  \"<i>So you're getting your own slut to release you of your cum?  What am I going to do then?  You drunk from me; it is only legitimate that I should drink from you too.</i>\"");
	outputText("\n\nYou tell the blue woman not to worry about that and gently pat Vapula's head; the purple demoness coughs as she interrupts her divine blowjob and giggles when she notices one of her own kind.  She slowly gets up and is soon joined by your demon guest, awaiting your next orders.  The blue succubus and the purple succubus stand before you, their eyes filled with voracious lust and impatient need.  Two girls are eager for your cum, and there's only one " + player.mf("man","herm") + " to satisfy them both... You don't know if you'll be up to the task, but it sure can't hurt to try.  Smiling to both, you remove your " + player.armorName + " and lazily lie down, your erect " + cockDescript(x) + " standing provocatively.  \"<i>Well, come on ladies.  Please me.  Can't you see I need some satisfaction?</i>\"");
	outputText("\n\nAt this invitation, both luscious creatures practically jump you.  In no time you're covered with blue and purple flesh, arms and lips caressing you everywhere but focusing on your most sensitive spots.  You shiver several times as the hell-girls give you tingles of pleasure that tease you almost unbearably.  You feel hands and tongues being pressed against your " + cockDescript(x) + " and smearing it with saliva and pre-cum; you are kissed several times, your mouth is being padded with a flexible demonic tongue as your palate is filled with a sweet unholy taste; the scent of horny succubi makes you giddy and all the more aroused.  You feel nipples being stuffed in your mouth and you instinctively suck, gulping the succubi's essences like a newborn.");
	outputText("\n\nDrops of some fluid start falling on your face; looking up, you see nothing but a drooling, gushing pink pussy being lowered down.  Idly wondering whose it might be, you start probing your tongue into that moist vagina, eagerly sucking and licking as the whore atop you moans and bucks wildly; from her hoarse, ragged voice you can recognize Vapula.  Gods, she's such a horny succubus slut!  You keep eating her out until she screeches madly in pleasure, probably waking up every living creature around your camp.  At the same time, you feel your " + cockDescript(x) + " is being handled and inserted into a nice warm snatch.  The brutal temperature change and amazing tightness drives you near the edge, and you actually feel your spooge flowing up and down your urethra as you contract your hips in a desperate effort to control yourself.  Your groin harshly hits the blue succubus', and your " + cockDescript(x) + " digs even deeper in her innermost depths.  She sighs in contentment and slowly whispers, \"<i>Guests first.</i>\"");
	outputText("\n\nShe starts riding you ferociously, clamping you down and gripping your hips with claw-like hands.  Her vaginal muscles implacably contract around your " + cockDescript(x) + ", acting as an boiling-hot and inescapable cock-ring.  Still trying your best to explore Vapula's love-tunnel, you reach around to get some of her tits, only to find the blue succubus' hands pinching your slut's nipples, making her shriek in torturesome pleasure.  You both keep groping her voluptuous body, making her shudder under your abusive massages.  Your head is now entirely soaked with Vapula's juices - that whore seems to orgasm ridiculously often.  Every time you consider pulling back your tongue and gasping for some fresh air, her twat squirts another crazy jet of fem-spunk down your face, making your vision blurry and leaving you with no choice but to lick her interior clean.  However, your efforts only stimulate her all the more, leading you to wonder how she can generate such an absurd amount of vaginal juices.");
	//[if multicock]
	if(player.cockTotal() > 1) outputText("  She suddenly seems to have an idea: leaning down to reach your second cock, she starts licking it, accompanying the savage thrusting of the blue demoness as she slurps your extra junk, giving you even more pleasure.");
	else outputText("  The blue demoness leans down and starts licking Vapula's moist pussy, intertwining her flexible tongue with yours and pleasuring the purple slut even more.");
	
	outputText("\n\nBoth hell-girls keep riding you relentlessly, thrashing back and forth as they impale themselves on your bodily appendages.  Their combined efforts are driving you mad with pleasure and with a deep sigh, you release your seed into your blue lover's waiting womb.  Her vaginal walls are furiously at work, doing their best to milk you as hard as they can and pumping glob after glob of spooge inside her.  The succubus utters a deep growl of pleasure as she is finally being fed, her eyes staring into nothingness and her pussy working on its own to keep all of your spunk.  As you keep thrusting in and out of the blue girl's depths, you feel Vapula trembling atop you, her buttocks grinding against your head in the most agreeable way before she releases a powerful shot of her own juice, splattering your neck and chest.  She then abandons herself to the arms of her blue fellow, who idly caresses her while still milking you.  As the last jet of semen forces its way inside her, her vaginal muscles eventually relax.  Both sluts sigh, winded; they collapse to the side, holding each other in their arms.");
	outputText("\n\nMaybe because you've drunk an appreciable amount of succubi juices, your " + cockDescript(x) + " is still half-erect, and you don't feel totally satisfied.  You give repeated cock-slaps to your lovers until they finally wake up.  Showing your still cum-dribbling cock, you tell them you still aren't satiated and you still have baby-batter to give away.  The simple mention of more available spooge is enough to get them all ready and waiting, their tongues hanging like hungry dogs.  You tell your blue guest to lie down and order Vapula to perform a good sixty-nine so she can lick your semen out of her colleague's cunt.  Exhausted from the intense threesome, they meekly comply and start eating each other out.  You place yourself behind Vapula's jiggly rump and start squeezing her fat buttocks, stretching them to reveal her tight anal opening.  Her whole body tenses at the realization of what she's going to receive, but before she can protest, you brutally jam all of your " + cockDescript(x) + " inside her colon.  Grunting in effort, you grab hold of her hips and thrust in and out relentlessly, smearing her anal walls with your residual semen.  Her tight confines and unbelievable hotness are more than enough to build up your lust back, and your " + cockDescript(x) + " only gets harder as it pounds Vapula's hot ass repeatedly.  The purple succubus, being taken in every orifice, keeps twisting in intolerable ecstasy and the blue wet cunt stuffing her mouth barely conceals her whorish moans.");
	//[if second cock]
	if(player.cockTotal() > 1) outputText("\n\nSince there seems to be an available hole, you quickly insert your second penis into Vapula's drooling twat, bumping the blue succubus' tongue out of its way.  \"<i>Make room for me, slut.</i>\"  You feel the tongue being quickly removed and slowly massaging your junk instead.  Your efforts being facilitated by the blue demoness smearing juices all over your dickflesh, you thrust at full force inside Vapula's snatch.  The subtle feeling of a demonic tongue probing her interior is replaced by the mad pushes of a big hard cock is enough to make her squirt.  Cum rains down your hips and the blue succubus' mouth as you double-penetrate your purple pet, ravaging her from both holes.");
	//[if third cock]
	if(player.cockTotal() > 2) outputText("\n\nIt feels good, but your guest's tongue feels redundant around your second cock since it already has a warm place to be lodged in.  Picking your third tool, you tell your blue slut to open her mouth wide so she can get her dessert.  Shoving all your length in her throat, you stand still, the thrilling sensation of penetrating three succubi holes at once making you laugh triumphantly.  The whole situation appears comical to you.  These powerful creatures, responsible for the fall of an entire land, now begging for their holes to be filled...  You laugh as you pump back and forth, your mad state of arousal quickening your incoming release.  The succubus' mouth doesn't feel as deliciously rough as Vapula's ass, and not as tight as her warm cunt, but sweet nonetheless, her mouth and lips doing an excellent job at driving you crazy with lust.");
	outputText("\n\nYou keep pounding away, coating your succubi with a mix of newly formed pre-cum, old cum from your previous ejaculation and vaginal juices being spilled all over your " + cockDescript(x) + ".  The succubus' inhuman recesses start to feel too hot for you, and with another powerful shot, you cum.  The contact of your globs of spooge hitting Vapula's backdoor makes her squirt another of her insane orgasms, but you keep releasing your milk inside her.");
	//[if second cock]
	if(player.cockTotal() > 1) {
		outputText("  You pack her tight snatch ");
		//[if third cock]
		if(player.cockTotal() > 2) outputText("and your blue lover's mouth ");
		outputText("likewise.");
	}
	outputText("  Jism is being spilled all over Vapula's backside and spurts in sticky jets down her baby-maker and the blue slut's waiting mouth.  Vapula's holes tremble and contract in order to keep as much spooge as possible, and the blue succubus tries to feed as well, frustrated to feel her own semen being eaten by Vapula's gluttonous tongue.  Cum keeps circulating in and out of the hell-girls, with your " + cockDescript(x) + " as a source.  Due to their mouths being occupied gulping semen from some hole, they only utter slow, lewd moans as they release their own juices in orgasm. The echo of your trio of bodies abandoning themselves to this debauched orgy is resonating all around your camp.  It should be wiser to end this quickly, lest you attract a horde of horny imps willing to join the party.");
	outputText("\n\nYou abruptly pop out your " + cockDescript(x) + " and rudely order your sluts to finish their work.  Still recovering from the hard fuck, they lazily obey and lick all the cum from your soaked junk.  They work quickly, not willing to let any drop of cum be stolen by their concurrent.  Sometimes their tongues will claim the same deposit of spooge and they will fight over it, their tongues entwining until they lewdly kiss each other.  The display is quite erotic but you'd prefer they'd kiss your " + cockDescript(x) + ", so you call them to order every time it happens.  When they're finally done emptying you from all your sperm, you give your lovers a tender kiss, thanking them for your efforts.  The blue succubus, still dazed by this intense session, hands you distractedly a bottle of her own milk.  \"<i>Woah.  That was... amazing. I don't know what she does to you but you taste much, much better when you keep this girl around.  We should definitely repeat this soon.</i>\"  Giving your dick a goodbye kiss, she staggers out of your camp, probably drunk from your huge cumload.");
	outputText("\n\nYou ask Vapula if she agrees with what the blue succubus said. As a response, your pet hugs you tightly");
	if(player.tallness < 60) outputText(", enclosing your head in her cleavage");
	outputText(".  \"<i>That was fun! I can't wait to have another party like this! You should invite her more often!</i>\"");
	outputText("\n\nYou know you definitely will.");
	//standard night succubus stat increases
	flags[VAPULA_DAYS_SINCE_FED] = 0;
	flags[VAPULA_TEASE_COUNT] = 0;
	shortName = "Cerul P";
	stats(rand(2), rand(2), rand(2), rand(2), 0, 0, -100, 2.5);
	menuLoc = 14;
	takeItem();
}
//Vapula/Jojo threesome
function vapulaJojoThreesomes():void {
	clearOutput();
	outputText("You call out in the jungle, \"<i>Slut!</i>\"  Vapula snickers, \"<i>I'm here, you know.</i>\"  You slap her ass to shut her up and quickly explain that you don't call her slut because she doesn't care, being a succubus.  There is only one fucktoy you call by that name, because he's in denial.  By Lethice you intend to have your way with him, and Vapula will get to participate too.  As she eagerly listens to you, her tongue inadvertently licking her lips, you hear soft steps behind you.  You look back and see Jojo walking hesitantly, intimidated by your unholy presence and the towering ex-dominatrix.  \"<i>You were right, he's such a cute shy slut.  I bet he secretly wants some nice cock to ram his every hole.  Don't you, little pet?</i>\"  The mousy monk huddles up little by little, bowing his head uncomfortably.");
	outputText("\n\nYou walk up to Jojo and slap him in the face, making him whimper.  \"<i>Hey, your mistress Vapula is talking to you.  Show some respect, look at her and answer.</i>\"");
	outputText("\n\nJojo only manages to mutter some terrified words.  From his mumbles, you understand that he's begging you not to abandon him to a demon and keep him with you.  You chortle cruelly: this poor slut must be really scared of Vapula.  \"<i>Ha ha, so you acknowledge you prefer my junk to this hot body standing before you?  What a cum-craving buttslut.   I'm sorry, Vapula, but even your luscious charms aren't enough to- wait, why are you keeping your hands in front of your crotch like that?  Don't pretend to be ashamed, bitch!  Show your beautiful mouse cock to us!  There's no need to be afraid, we're all friends.</i>\"  Seeing that Jojo won't comply, you forcibly grab hold of his arms, revealing what Jojo was trying to hide: a raging erection, his throbbing 13 inch long rodent prick pointing at Vapula's naked body and dribbling pre-cum. He tries his best to look away from her but his cock stands as proud as he feels ashamed.");
	outputText("\n\n\"<i>Awww, look at that!  Looks like our little pet has a crush on you!  Look at how hard he is!</i>\"");
	outputText("\n\n\"<i>You're right!  He really likes me!  Is that the effect I have on you, little boy?</i>\"");
	outputText("\n\n\"<i>You should be ashamed of displaying your lust so shamelessly.  It's not polite to be that hard for your mistress.  Have a little self-respect for gods' sake.</i>\"");
	outputText("\n\nYou both keep taunting the poor mouse, laughing at him and making him feel all the more ashamed; but if anything, his arm-length cock only grows bigger and harder.  You smirk - that slut is really getting off on being abused! Well, you're going to give him a treatment he won't forget.");
	outputText("\n\n<b>How will you use your fucktoy?</b>");
	outputText("\n\nYou could fuck Vapula in front of him; it would serve him right for displaying an erection for your succubus lover without your consent.");
	if(player.hasCock()) outputText("\n\nYou could initiate a butt-fuck train, and ram his asshole while he fucks Vapula's; this way he would get what he clearly wants.");
	var tease:Number = 0;
	var train:Number = 0;
	if(player.hasVagina() || player.hasKeyItem("Demonic Strap-On") >= 0) tease = 3760
	if(player.hasCock()) {
		tease = 3760;
		train = 3758;
	}
	simpleChoices("Tease Jojo",tease,"ButtfuckTrain",train,"",0,"",0,"",0);
}

//Netorare
//Butt-fuck train
//Vapula/Jojo Netorare
function NTRSomeJojos():void {
	clearOutput();
	if(player.hasCock()) {
		var x:int = player.cockThatFits(100);
		if(x < 0) x = player.smallestCockIndex();
		outputText("\"<i>Admit it, you'd love to use that smoking hot body, wouldn't you?  Don't lie to me.  You'd give up your soul in order to fuck her brains out.  Don't you want to plunge your dick inside her?  Don't you want to fuck my beautiful succubus wife?</i>\"");
		outputText("\n\nJojo shakes his head in denial, but he can hardly keep any shred of credibility when his rock-hard mouse cock speaks for him.");
		outputText("\n\n\"<i>That's only natural. After all, who wouldn't want to get a good grope of this fine ass...</i>\"  You punctuate the end of your sentence with a hard slap on Vapula's butt, making her jolt.");
		outputText("\n\n\"<i>These perky tits...</i>\"  You reach around and knead her twin orbs, paying special attention to her nipples.  Vapula openly moans from your titillation, and Jojo's eyes are glowing in lust and shame mixed.");
		outputText("\n\n\"<i>These pulpy lips...</i>\" You turn her head and give her a lewd, passionate kiss, taking frequent peeks at Jojo in order to make sure he doesn't miss anything.  You pull back with a groan and smirk at him, \"<i>Hmmm...she's delicious.  I bet you've never tasted a succubus before... I pity you.  She's so good...</i>\"  You kiss Vapula again, enjoying the contact of her lips against yours as much as Jojo's raging envy.");
		outputText("\n\n\"<i>This wet pussy...</i>\"  You dart a hand to Vapula's crotch from behind and start fingering her; she wiggles and twists in your arms, and the erotic display is making Jojo blush in arousal.  His eyes seem to be locked as they bulge more and more out of their orbits; he can't help but gaze at object of his lust being roughly manhandled by his master.  You stare back at him, your hands working on their own as they caress and abuse the succubus' sensitive flesh.");
		outputText("\n\n\"<i>These hips... these thighs...</i>\"  Grabbing hold of Vapula's waist, you shove your " + cockDescript(x) + " between her legs and start grinding your junk against her vaginal entrance, teasing her in the most lustful manner. You keep grinding until your purple slut utters a lubricious moan.");
		outputText("\n\n\"<i>No, really, her whole body is perfect.</i>\"  You run your hands all over the succubus curves, pinching here and caressing here.  \"<i>And gods, that tight anus!  Oh, Jojo, if you knew how cock-hungry she is...</i>\"  With a wicked, wanton smile, you rail Vapula's ass with your " + cockDescript(x) + ", filling the entirety of her interior with your dickflesh as you watch the monk.  The poor mousy slut has completely given in to his lust; he has fallen on his knees and is now stroking himself feverishly, unable to break your gaze.  You start pounding Vapula's butt; with each thrust you grunt ostensibly, letting your mouse pet know how much you enjoy it.  As for Vapula, the slutty demoness is clearly enjoying her anal treatment, the sight of a poor bitch masturbating to her being all the more arousing to her.  She also stares at him with longing eyes, as if to provoke him with her nude, horny body being fucked by someone else.  Soon she is screaming in utter ecstasy and starts babbling meaningless dirty talk, \"<i>Fuckfuck me... oh yessssssssssssss... more!  MORE!</i>\"  She's clearly acting as a naughty bitch!  You wonder if the presence of a shy creature is not helping release her inner wantonness... Shrugging it off, you decide to focus on the nice purple body impaling itself on your " + cockDescript(x) + " and pound her harder, your meat releasing streams of sex juices as it pounds in and out of Vapula's pucker.");
		if(player.cockTotal() > 1) {
			outputText("\n\nYou decide to add some more depravity to this sheer show of lewdness.  Grabbing your second turgid shaft, you knock at Vapula's vaginal entrance, your tip slowly rubbing her nether-lips.  Then, at the moment she least expects, you ram it in, effectively double-penetrating her.");
			//[if third cock]
			if(player.cockTotal() > 2) outputText("  Since the horny slut has a demonic vaginal capacity, you might as well fit more dick in it: in no time your third dick joins its colleague in this infernal vaginal assault.");
			outputText("  ");
		}
		else outputText("\n\n");
		outputText("You push in and out of her, claiming both her holes and snickering at the poor mouse thing that can get neither. With a mighty push, you put Vapula on all fours and lean down in order to touch more of her supple body.  Your purple slut is now dying with pleasure, her tongue hanging and her eyes staring behind Jojo as the monk squeaks pitifully in his pathetic self-stroking.");
		outputText("\n\nStill looking at Jojo, you keep taunting him as you ravage Vapula's anus.  \"<i>Do you want to know if she feels good?  Because I can tell you she does.  Gods, her ass is so... hot... my cock is about to melt... fuck...  Do you want to know if I feel good to her?  Darling, tell our mouse pet how good you feel.</i>\"");
		outputText("\n\n\"<i>Oh, yes... YES!  Like that!  Deeper!  YES!  Harde-aargh....</i>\"  Unable to think properly under the intense butt-fucking she's receiving, her eyes roll and she becomes oblivious of everything but her hole");
		if(player.cockTotal() > 1) outputText("s");
		outputText(" being filled with cock.");
		
		outputText("\n\nIncapable of bearing such a teasing treatment, Jojo starts to weep sofly as he ragingly tries to get rid of his shameful erection.  He strokes his broad mouse dong with unusual ferocity, his eyes consumed with frustrated lust and humiliation.  His eyes bulge, his balls swell, his hips rock back and forth, ");
		if(tentacleJojo()) outputText("his tentacles start flying toward his ass, ");
		outputText("his-");
		outputText("\n\n\"<i>No.</i>\"");
		
		outputText("\n\nStartled by your command, unexpectedly coming from someone busy pounding some succubus ass, Jojo stares at you, puzzled.");
		outputText("\n\n\"<i>Don't cum before me, slut.  Me first and her first.</i>\"");
		outputText("\n\nToo scared to disobey, the rodent monk only meekly nods and releases his iron grip on his erect prick, his tail wagging in despair.  He can only watch helplessly as you finish butt-fucking Vapula, his dick vibrating on its own at this pure display of anal sluttery.  The succubus' lush recesses finally drain your stamina completely and with a loud groan, you cum, fully loading your purple slut's backdoor with seed.  Her ass avidly devours your baby-batter as she screams like a whore in heat, visibly welcoming her new ration of spooge.");
		//[if second cock]
		if(player.cockTotal() > 1) outputText("  Your extra junk shoved down her love-tunnel also explodes in a milky torrent, blasting her fuck-hole full of spooge too.");
		outputText("  Her anal walls milk you with ruthless efficiency; you wouldn't have expected less from an experienced demon, but the feeling is amazing.  Your meat is being squeezed and clamped as [eachCock] releases its full load of sperm.  As you watch the poor mouse slut being denied an orgasm, his desperately aroused state only turns you on all the more.  Removing your " + cockDescript(x) + " from Vapula's warm and tight pucker, you wave it at your monk pet, spraying him with your spooge.  Since you haven't given him the authorization to get off yet, the fucktoy is forced to endure your white rain as well as the squirts of an orgasming succubus he never got to touch.  Tears mix with your seed as they dribble down his face and stain his fur, but you don't care; if anything, you are only compelled to pollute him with even more thick ropes of jism.");
		outputText("\n\nWhen the mouse slut is completely soiled, you order him to place himself behind Vapula.  You want him to lick your cum off her ass while she sucks your dick.  Excited at the perspective of giving and receiving pleasure at the same time, Vapula eagerly does as she told, suckling from your " + cockDescript(x) + " and presenting her purple, cum-stuffed backside to your other slut.  Whimpering in humiliation, treated as a sex-slave unworthy of getting your cum firsthand, Jojo proceeds to lick the succubus' gaping asshole, sobbing and sniffing every now and then as he loudly slurps your cum.  Not caring in the least about the cumslut wiping her ass clean, your purple demon lover distractedly enjoys her dessert, satiating her craving for semen as she milks the last globs of goo still present in your body.");
		outputText("\n\nWhen you're both completely empty, you help Vapula to her feet; as the succubus kisses you and thanks you for her meal, you notice that Jojo is still sitting before you, curled up and waiting for your next orders.  You laugh with your succubus companion at his submissive posture; Vapula kicks his butt and snickers, \"<i>Can't you see we're busy?  Piss off, slut.</i>\" You approve.  \"<i>You heard what she said.  Go get fucked elsewhere.</i>\"  Still terrified by the unholy couple you both form, Jojo nods feebly and quickly disappears into the jungle.");
	}
	//Jojo NTR (as female)
	else {
		outputText("You call out in the jungle, \"<i>Slut!</i>\"  Vapula snickers, \"<i>I'm here, you know.</i>\"  You slap her ass to shut her up and quickly explain about your mousey fucktoy in denial; how pleasing it is to humiliate a sex slave who cannot face who he is, and how you intend to use her to further his debasement.  As she eagerly listens to you, her tongue inadvertently licking her lips, you hear soft steps behind you.  You look back and see Jojo walking hesitantly, intimidated by your unholy presence and the towering ex-dominatrix.  \"<i>You were right, he's such a cute shy slut.  I bet he secretly wants some nice cock to ram his every hole.  Don't you, little pet?</i>\"  The mousy monk huddles up little by little, bowing his head uncomfortably.");
		outputText("\n\nYou walk up to Jojo and slap him in the face, making him whimper.  \"<i>Hey, your mistress Vapula is talking to you.  Show some respect, look at her and answer.</i>\"");
		outputText("\n\nJojo only manages to mutter some terrified words.  From his mumbles, you understand that he's begging you not to abandon him to a demon and keep him with you. You chortle cruelly: this poor slut must be really scared of Vapula.  \"<i>Ha ha, so you acknowledge you prefer what I do to you to this hot body standing before you?  What a craven little sissy.  I'm sorry, Vapula, but even your luscious charms aren't enough to- wait, why are you keeping your hands in front of your crotch like that?  Don't pretend to be ashamed, bitch!  Show your beautiful mouse cock to us!  There's no need to be afraid, we're all friends.</i>\"  Seeing that Jojo won't comply, you forcibly grab hold of his arms, revealing what Jojo was trying to hide: a raging erection, his throbbing 13 inch long rodent prick pointing at Vapula's naked body and dribbling pre-cum.  He tries his best to look away from her but his cock stands as proud as he is ashamed.");
		outputText("\n\n\"<i>Awww, look at that!  Looks like our little pet has a crush for you! Look at how hard he is!</i>\"");
		outputText("\n\n\"<i>You're right!  He really likes me!  Is that the effect I have on you, little boy?</i>\"");
		outputText("\n\n\"<i>You should be ashamed of displaying your lust so wantonly.  It's not polite to be that hard for your mistress.  Have a little self-respect for gods' sake.</i>\"");
		outputText("\n\nYou both keep taunting the poor mouse, laughing at him and making him feel all the more ashamed; but if anything, his arm-length cock only grows bigger and harder.  You smirk - the sissy is really getting off on being abused!  Well, you're going to give him a treatment he won't forget.  You buckle into your strap-on, sighing lasciviously as you slide the pink dildo end into your " + vaginaDescript(0) + ", smiling wickedly as Jojo's breath quickens.");
		outputText("\n\n\"<i>Admit it, you'd love to use that smoking hot body, wouldn't you?  Don't lie to me.  You'd give up your soul in order to fuck her brains out.  Don't you want to plunge your dick inside her?  Don't you want to fuck my beautiful succubus wife?</i>\"");
		outputText("\n\nJojo shakes his head in denial, but he can hardly keep any shred of credibility when his rock- hard mouse cock speaks for him.");
		outputText("\n\n\"<i>That's only natural.  After all, who wouldn't want to get a good grope of this fine ass...</i>\"  You punctuate the end of your sentence with a hard slap on Vapula's butt, making her jolt.");
		outputText("\n\n\"<i>These perky tits...</i>\"  You reach around and knead her twin orbs, paying special attention to her nipples.  Vapula openly moans from your titillation, and Jojo's eyes are glowing in lust and shame mixed.");
		outputText("\n\n\"<i>These pulpy lips...</i>\" You turn her head and give her a lewd, passionate kiss, taking frequent peeks at Jojo in order to make sure he doesn't miss anything.  You pull back with a groan and smirk at him.");
		outputText("\n\n\"<i>Hmmm... she's delicious.  I bet you've never tasted a succubus before...  I pity you.  She's so good...</i>\"");
		outputText("\n\nYou kiss Vapula again, enjoying the contact of her lips against yours as much as Jojo's raging envy.");
		outputText("\n\n\"<i>This wet pussy...</i>\"  You dart a hand to Vapula's crotch from behind and start fingering her; she wiggles and twists in your arms, and the erotic display is making Jojo blush in arousal.  His eyes seem to be locked as they bulge more and more out of their orbits; he can't help but gaze at the object of his lust being roughly manhandled by his mistress.  You stare back at him, your hands working on their own as they caress and abuse the succubus' sensitive flesh.");
		outputText("\n\n\"<i>These hips... these thighs...</i>\"  Grabbing hold of Vapula's waist, you shove the purple end of your strap-on between her legs and start grinding against her vaginal entrance, teasing her in the most lustful manner.  You keep grinding until your purple slut utters a lubricious moan.");
		outputText("\n\n\"<i>No, really, her whole body is perfect.</i>\"  You run your hands all over the succubus curves, pinching here and caressing here.");
		outputText("\n\n\"<i>And gods, that tight anus!  Oh, Jojo, if you knew how cock-hungry she is...</i>\" And with a wicked, wanton smile, you rail Vapula's ass with your artificial cock, filling the entirety of her interior with dick substitute as you watch the monk.  The poor mousy slut has completely given in to his lust; he has fallen on his knees and is now stroking himself feverishly, unable to break your gaze.  You start pounding Vapula's butt; with each thrust you moan as your end saws into your dripping hole, letting your mouse pet know how much you enjoy it.  As for Vapula, the slutty demoness is clearly enjoying her anal treatment, the sight of a poor bitch masturbating to her being all the more arousing to her.  She also stares at him with longing eyes, as if to provoke him with her nude, horny body being fucked by someone else.  Soon she is screaming in utter ecstasy and starts babbling meaningless dirty talk.  \"<i>Fuckfuck me...oh yessssssssssssss...more! MORE!</i>\"  She's clearly acting as a naughty bitch!  You wonder if the presence of a shy creature is not helping release her inner wantonness.  Shrugging it off, you decide to focus on the nice purple body impaling itself on your dildo and pound her harder, the obscene device releasing streams of its sap as it surges in and out of Vapula's pucker.  With a mighty push, you put Vapula on all fours and lean down in order to touch more of her supple body, grabbing hold of her plump breasts, pinching her hard nipples between the gaps in your fingers as you begin to batter into her as hard as you can.  Your purple slut is now dying with pleasure, her tongue hanging and her eyes staring behind Jojo as the monk squeaks pitifully in his pathetic self-stroking.");
		outputText("\n\nStill looking at Jojo, you keep taunting him as you ravage Vapula's anus.  \"<i>Do you want to know if I feel good to her? Darling, tell our mouse pet how good you feel.</i>\"\n\n\"<i>Oh, yes... YES! Like that! Deeper! YES! Harde-aargh...</i>\"  Unable to think properly under the intense butt-fucking she's receiving, her eyes roll and she becomes oblivious of everything but being filled with cock.  Incapable of bearing such a teasing treatment, Jojo starts to weep sofly as he ragingly tries to get rid of his shameful erection.  He strokes his broad mouse dong with unusual ferocity, his eyes consumed with frustrated lust and humiliation. His eyes bulge, his balls swell, his hips rock back and forth, ");
		if(tentacleJojo()) outputText("his tentacles start flying toward his ass, ");
		outputText("his-");
		outputText("\n\n\"<i>No.</i>\"");
		
		outputText("\n\nStartled by your command, unexpectedly coming from someone busy pounding some succubus ass, Jojo stares at you, puzzled.");
		outputText("\n\n\"<i>Don't cum before me, slut. Me first and her first.</i>\"");
		outputText("\n\nToo scared to disobey, the rodent monk only meekly nods and releases his iron grip on his erect prick, his tail wagging in despair.  He can only watch helplessly as you finish butt-fucking Vapula, his dick vibrating on its own at this pure display of anal sluttery.  With a loud moan, you clench down upon your vibrating sex tool and cum, releasing the other end fully as you do, loading your purple slut's backdoor with seed.  Her ass avidly devours the liquid surge as she screams like a whore in heat, visibly welcoming her new ration of baby-batter.  She eagerly thrusts back against you, making your end of the strap-on rub your walls delightfully, and the two of you continue to rut into each other eagerly even as demonic jizz spurts around the dildo and paints Vapula's ass cheeks.  As you watch the poor mousy slut being denied an orgasm, his desperately aroused state only turns you on all the more: removing the strap-on from Vapula's warm and tight pucker, you wave it at your monk pet, spraying him with spooge.");
		outputText("\n\nSince you haven't given him the authorization to get off yet, the fucktoy is forced to endure your white rain as well as the squirts of an orgasming succubus he never got to touch.  Tears mix with your seed as they dribble down his face and stain his fur, but you don't care; if anything, you are only compelled to pollute him with even more thick ropes of demon jism.  When the mousy slut is completely soiled, you order him to place himself behind Vapula; you want him to lick the cum off her ass while she eats you out.  Excited at the perspective of giving and receiving pleasure at the same time, Vapula does as she's told; kneeling before you she sends her long tongue eagerly searching into your leaking twat, flicking at your " + clitDescript()+ " whilst presenting her purple, cum-packed backside to your other slut.  Whimpering in humiliation, treated as a sex-slave unworthy of getting cum firsthand, Jojo proceeds to lick the succubus' gaping asshole, sobbing and sniffing every now and then as he loudly slurps your cum.  Not caring in the least about the cumslut wiping her ass clean, your purple demon lover distractedly enjoys her dessert, exploring every crevice of your sex and teasing out every last drop of sweet girl cum.  When you're both completely clean, you help Vapula to her feet; as the succubus kisses you and thanks you for her meal, you notice that Jojo is still sitting before you, curled up and waiting for your next orders.");
		outputText("\n\nYou laugh with your succubus companion at his submissive posture.  Vapula kicks his butt and snickers, \"<i>Can't you see we're busy? Piss off, slut.</i>\" You approve: \"<i>You heard what she said. Go get fucked elsewhere.</i>\"  Still terrified by the unholy couple you both form, Jojo nods feebly and quickly disappears into the jungle.");
	}
	flags[VAPULA_DAYS_SINCE_FED] = 0;
	flags[VAPULA_TEASE_COUNT] = 0;
	stats(0,0,0,0,0,-2,-100,4);
	doNext(13);
}

//Vapula/Jojo Butt-fuck train
function jojoButtFuckTrain():void {
	clearOutput();
	var x:int = player.cockThatFits(100);
	if(x < 0) x = player.smallestCockIndex();
	outputText("You tell Jojo it's his lucky day - you're going to have a joyful butt-fuck session with him and your purple pet.");
	outputText("\n\n\"<i>Admit it, you'd love to use that smoking hot body, wouldn't you?  Don't lie to me.  You'd give up your soul in order to fuck her brains out.  Don't you want to plunge your dick inside her?  Don't you want to fuck my beautiful succubus wife?</i>\"");
	outputText("\n\nJojo shakes his head in denial, but he can hardly keep any shred of credibility when his rock-hard mouse cock speaks for him.");
	outputText("\n\n\"<i>Don't worry, you're going to get a hot piece of her ass soon enough.</i>\"  You tell Vapula to place herself in front of your mousy pet such that the tip of his erect cock points toward her little pucker.  You point your own cock toward Jojo's slutty ass and give him a last warning.");
	outputText("\n\n\"<i>Remember: you get to use her butt temporarily but only because I say so.  Other than that, she's mine.  You have no right on her pussy, tits or even face.  You are allowed to fuck her butt only because it turns me on to see her at the end of a butt-fuck train, but don't you dare take advantage of the situation.  You're a mindless dick, nothing else.  If I order you to stop fucking her, you will stop fucking her right away.  Your whole body is mine, and hers too. Do you understand?</i>\"");
	outputText("\n\nJojo mumbles a few words, you can't understand all of them but you think he's gotten the message.");
	outputText("\n\n\"<i>All right! Let's get going!</i>\"");
	outputText("\n\nYou seize your " + cockDescript(x) + " and press its tip against the mouse's sphincter, slowly pushing.  Startled by the sudden anal invasion, Jojo reflexively grabs Vapula's hips and inserts is own rodent prick inside her.  The simultaneous penetrations make your sluts squeak and moan in ecstasy, their bodies entranced as their anal walls provide them one thousand subtle sensations.  You grip his arms, using him as leverage to pull out, and slam it back home again.  Used like the fucktoy he truly is, Jojo doesn't resist; his dick moves of its own volition in and out of Vapula's interior as you relentlessly push him back and forth.  You secretly rejoice: his tight little ass is clearly adapting to your " + cockDescript(x) + " and it somehow feels even better than usual.  You pound hard, making him groan and beg for more; you eagerly give him what he wants and stuff him full of your dickflesh.");
	if(player.cockArea(x) > 100) outputText("  You can actually feel his internal organs being bumped against your meat as your " + cockDescript(x) + " stretches his colon beyond its normal size and thrusts in and out like a charging mammoth.");
	outputText("\n\nYou pump him full of your junk as he does the same to the buttslut in front of him.  You can't tell who yelps louder, but these bitches seem to enjoy the butt-fucking they're receiving.  This only entices you to fuck Jojo harder, knowing that the might of your thrusts will propagate down Vapula's butt; you ruthlessly smash your groin against Jojo's butt, pulling his arms harder at each thrust and oblivious of the mouse's pain in your passionate embrace.  Besides, the monk slut is probably getting off on getting manhandled like that.  You reach around and grab Vapula's breasts, holding her tight and crushing Jojo between the two of you as you keep ravaging his butt with repeated assaults.");
	//[if tentacle Jojo]
	if(tentacleJojo()) {
		outputText("\n\nBetween two butt-assaults, you order your pet to put his pretty appendages to some use for once: your ass needs to be taken care of too.  Jojo doesn't seem to react.  You first think he didn't hear you over Vapula's screams and the mad thuds of groins being clasped against butts, but you are soon relieved as you feel some tubular appendage tickling your buttocks.  Encouraging him, you thrust deeper in his own butt, inviting him to return the favor.  Your efforts are rewarded as you feel your own anus being savagely violated by some fat penile flora, sap-like slime being spilled down your legs.  The cock fucks you hard and rough, speeding up and slowing down irregularly as Jojo tries to muster his stamina.  At the same time, another of these green rods finds its way toward your mouth; you eagerly suck the tip like a popsickle and it immediately shoves itself down your throat.  Your neck bulges obscenely from the huge dick-intrusion, but you don't care; his cock tastes too sweet.");
		//[if vagina]
		if(player.hasVagina()) outputText("  Last but not least, a soft cock-knock at the entrance of your " + vaginaDescript() + " signals an incoming intrusion.  If your mouth weren't so full of cock you would sigh in relief as your aching pussy is thoroughly penetrated.");
	}
	//[if PC has extra long tentacle cock, variable is n1]
	var n1:int = -1;
	var n2:int = -1;
	var n3:int = -1;
	temp = player.cockTotal();
	while(temp > 0) {
		temp--;
		if(player.cocks[temp].cockType == CockTypesEnum.TENTACLE && temp != x) {
			if(n1 == -1) n1 = temp;
			else if(n2 == -1) n2 = temp;
			else if(n3 == -1) n3 = temp;
			break;
		}
	}
	if(n1 >= 0) outputText("\n\nA deliciously depraved idea crosses your mind; using your dick muscles, you move your " + cockDescript(n1) + " toward Vapula.  It squirms for a moment as you look for her wet snatch, poking her everywhere with your tip and teasing her with your accidental ministrations, but at last you find her vaginal entrance.  Using the rubbery flexibility of your plant-like prick, you brutally shove it down her love-tunnel, trying to force inside as many inches as you can.  You can feel her instinctively altering her own body in order to accommodate more dickflesh inside her, and you keep pushing until your " + cockDescript(n1) + " is stretched to maximum capacity.  Somehow your tentacle rod is entirely buried in Vapula's warm depths, and her unbelievable tightness is driving you mad with lust.  It twists on its on volition inside her, its vegetable-like texture being more sensitive and receptive to pleasure than a normal prick and the sensations it sends to you are abnormally exquisite.  You almost forgot the asshole you were pounding with your " + cockDescript(x) + " but the way Jojo wriggles against it in order to fit more of your length inside him reminds you of your job.");
	//[if PC has another tentacle cock, variable is n2]
	if(n2 >= 0) outputText("\n\nSince your sluts still have free holes left, you decide to fill some more fuck-hole with your junk.  Guiding  your " + cockDescript(n2) + " toward Vapula's mouth, you think you could use a proper blowjob from a trained succubus and wait for her to let out another moan before filling your junk completely and thrusting up and down brutally, literally mouth-fucking her and treating her lips as a tight cock-ring.  Her expert tongue wraps around your girth, squeezing it and clinging to it like it's the most precious thing in her life.  She keeps jerking back and forth due to the hard butt-fucking she's receiving, and the jolts are transmitted to your " + cockDescript(n2) + " in the most teasing manner.");
	//[if PC has another tentacle cock, variable is n3]
	if(n3 >= 0) outputText("\n\nSince Vapula is already sucking you off, why not Jojo?  You still have appropriate junk left after all.  You promptly send your wriggling " + cockDescript(n3) + " and push it between the mousey's lips.  But the slut won't open them!  You pound him ragingly, slamming the entirety of your " + cockDescript(x) + " down his colon and bruising his firm butt until he lets out a deep howl of pleasure and pain mixed; you profit from the opening and stuff his mouth so full of your " + cockDescript(n3) + " you think he's going to choke.  However, his mouth seems to be accustomed to take monstrous lengths - probably a side-effect of his corruption - and he quickly accommodates to your size.  Although he can't provide a blowjob as sweet as Vapula, you can definitely tell he's skilled at sucking dick.  The cute little slut!  You ram his asshole faster to reward him; this increased butt-fucking pace seems to have the desired effect, and soon your " + cockDescript(n3) + " is throbbing in need as is bathes in the mousey's saliva.");
	//[add this at the end of any tentacle multicock text]
	if(n1 >= 0) {
		outputText("\n\nYou pound Vapula and Jojo harder than ever, riding the butt-fuck wave and creating delightful disruptions in the whole train as you fill both sluts with your junk over and over again.  You keep pumping, the tightness of either hole threatening to send you over the edge at every thrust.");
		//[if Jojo has tentacle dicks]
		if(tentacleJojo()) outputText("  You enjoy this absolutely crazy display of corrupted debauchery: you, getting dick and giving dick to the same creature as well as indirectly and directly violating multiple holes with your junk.  An endless circle of loop-fuck feeding itself through lust and dicklesh.  How weird the three of you would provide to an external observer, locked as you are in this train of penetrating dicks!  None of you can moan to express the sheer bliss you're all feeling, as your mouths are filled with dick; you can't slow down, as both your sluts are taken in an insane frenzy, always willing to fill more cock in some hole.  All you can do is pump faster and faster until the final release.");
	}
	outputText("\n\nYou wish this blissful state of mind and pleasure would last forever, and you're sure both your butt-fuck partners are feeling the same way; sadly, your stamina has a limit, and theirs does too.  You feel your spooge flowing all through your genitals, ready to be unloaded.  With a silent groan, you give Jojo one last pound before utterly blasting him with spunk.  You paint his anal walls white");
	//[if second multicock] 
	if(n1 >= 0) outputText(", as well as Vapula's love-tunnel");
	if(n2 >= 0) outputText(" and throat, ");
	if(n3 >= 0) outputText("and Jojo's too");
	outputText(".  You feel that Jojo's release is coming too.  With a powerful thrust, he squirts his own mouse semen down Vapula's waiting ass");
	//[if tentacle Jojo]
	if(tentacleJojo()) outputText("; his tentacles absolutely drench your every hole with greenish mousey-cum");
	outputText(".  Vapula's own orgasm also starts kicking in, the feeling of hot cum flooding her interior being too much for her horny body to bear.");
	outputText("\n\nYou all spend a few minutes in utter ecstasy, thinking of nothing but the steady flow of sexual juices flowing in and out of various bodies.  You all focus on two things: giving everything you've got and keeping everything you're receiving.  Jojo, the nexus of this network of cum-flows, thrashes savagely as his genitals throb with need and his ass spasms reflexively; the poor thing is clearly getting unbearable pleasure and can't control his own movements anymore.  Your own orgasm brings you to a new level of ecstasy as your " + cockDescript(x) + " keeps pulsating and releasing torrents of baby-batter.  At last, when the cum-flow finally ebbs, you rest on Jojo's back for a while, cock buried deep in his ass.  He does the same to Vapula, but you're too exhausted to care.  Besides, the naughty little pet deserved a reward.  You all fall over, sloshing in a newly-formed puddle of thick sexual fluids, and rest for a while.  As you're about to fall asleep you whisper in Jojo's ear, \"<i>Good job slut...</i>\"  Your last vision is the mouse's head nodding in contentment.");
	outputText("\n\nWhen you wake up, Jojo is gone, and Vapula is still snoring deep in the cum puddle, her body entirely coated with dried semen.  You cock-slap the purple succubus to wake her and tell her she might as well clean your " + cockDescript(x) + " since the cowardly mouse left.  She nods weakly and her mouth opens, visibly waiting for your sloppy dick to fill her since she's too tired to sit up.  Sighing, you lower your junk into a proper sucking position; her tongue seems to be working on its own as it licks your meat clean of any dirty juice left.  You try to shove more dickflesh inside her throat but you can see she's too winded to perform any elaborate blowjob.  Shrugging in mild disappointment, you leave the purple slut as she carelessly wallows in the cum puddle; you head toward a stream to get cleaned up.");
	stats(0,0,0,0,-1,-2,-100,2);
	flags[VAPULA_DAYS_SINCE_FED] = 0;
	flags[VAPULA_TEASE_COUNT] = 0;
	doNext(13);
}


function vapulaAndIzmaThreeSome():void {
	clearOutput();
	if(player.hasCock()) vapulaAndIzma(false);
	else vapulaAndIzma(true);
}
//Vapula/Izma threesome(F)
function vapulaAndIzma(girls:Boolean = true):void {
	clearOutput();
	if(!girls) {
		outputText("You call your beta tigershark, telling her you'll have some use for her body.  Izma eagerly approaches you, although she frowns a bit when she sees the towering succubus accompanying you.  \"<i>What can I do for my alp-...wait, what are you doing with her?</i>\"  Vapula only smirks at Izma's puzzled reaction.");
		outputText("\n\nYou gently explain that you intend to have some extra fun, that's why you brought this gorgeous creature to please you both.  Izma isn't really convinced, but still walks up to you, not willing to antagonize her alpha.  You tell to remove her cloth and turn around so you can have a clear view of her toned butt.  \"<i>What do you have in mind, " + player.short + "?</i>\"\n\n\"<i>Shhh... just do as I say.</i>\"  With a discreet gesture, you order Vapula to get on her knees in front of Izma; she's going to feed from your tigershark this time.  With a conniving smile, Vapula obeys and before your shark lover can react, you're already grinding your " + cockDescript(x) + " against her muscular butt-cheeks while the purple succubus grabs hold of her 15 inch long pecker.  You rub the tip of your " + cockDescript(x) + " against her butt crack.  \"<i>B-but wait! What are you guys doing? Are you going to fuck my... I don't want to-</i>\"");
		outputText("\n\n\"<i>Relax, love.  I'm just going to rail your little pucker while my trained fucktoy will take care of your junk, so you'll be pleased from both sides.  Admit you are being turned on. Don't you like a good dicking?</i>\"");
		outputText("\n\n\"<i>I... just... I'm not used to-</i>\"");
		outputText("\n\n\"<i>Ha ha, as if you had any choice in the matter!  You're my beta, remember that.  Bend over, lift your tail and take it, I'm sure you'll love it as much as I will.</i>\"");
		outputText("\n\nIzma tries to struggle but she's no match to your superior strength; you forcibly seize her arms and incline her back, fully exposing her butt to you.  Her initial resolution fades quickly when Vapula takes a good portion of her beast-like prick in her mouth, sucking it with expert precision and fondling her balls with care.  Izma's cries of protestation quickly turn into moans: the poor tigershark can't possibly resist a succubus' blowjob.  Meanwhile, you keep groping the tigershark's butt, giving it rough slaps for good measure.");
		outputText("\n\n\"<i>If you knew for how long I've been wanting to do this... Such a fine ass isn't to be neglected. So fit... so muscular... do you know how often you've teased me with it?  It's time to take the dick you're clearly begging to be filled with.</i>\"");
		outputText("\n\nYour taunts don't seem to affect Izma; if anything, they only turn her on all the more.  You tease Izma's butthole with your hands and " + cockDescript(x) + ", stretching her fuckpillows to make room for your incoming junk.  The poor tigershark doesn't even resist anymore, completely overwhelmed by your teasing ministrations and Vapula's dexterous fondling.  Her shark tail is wagging in apprehension and excitement; her loose pussy is now freely gushing juices and her tight asshole is occasionally leaking some lubricant.  She's finally getting ready!");
		outputText("\n\nWith a roar of triumph, you grab her toned hips and force your " + cockDescript(x) + " inside her, tearing her asshole and stretching it further.  Izma screeches, obviously not used to anal violation.  Her shark tail twists and wriggles nervously above her ass, nearly hitting you.  With one hand, you immobilize her inconvenient appendage; with your free hand, you grasp again on her toned buttocks, gripping the hard muscles as your herm lover contracts them; her anal walls are squeezing your " + cockDescript(x) + " so tightly it actually hurts.  You tell Vapula to suck harder in order to relieve your tigershark's tension.  Your skilled succubus nods and starts clamping her pink lips around Izma's mammoth prick, effectively trapping it in an organic cock-ring.  At last you feel some of the intense pressure on your " + cockDescript(x) + " being released, allowing you to pull out and slam back, almost bruising your groin as it mashes against her hard butt-muscles.  This time her ass completely gives in to your ferocious dick-assault.  You pull back and stuff her again, increasing the pace of your repeated thrusts as the both of you gain confidence.  Soon you're butt-fucking her senseless, devastating her rectal entrance with your towering rod.");
		outputText("\n\nNeedless to say, Izma's mind is being torn in pleasure; the sweet blowjob she's receiving from your voracious succubus contrasts with your rough anal ploughing and brings her the weirdest mix of sensation. She growls and moans, her hands grasping Vapula's head as its bobs up and down the length of her long prick.  Her pussy is dripping drops after drops of fem-juice.  You notice her asshole is getting wetter and wetter as you keep penetrating it; could it be that your tigershark lover is a buttslut in denial?  Excited at the idea of turning the prude tigershark into an eager anal beta, you intensify the pace of your butt-fucking, determined to bring her to ecstasy by the sole power of your " + cockDescript(x) + ". You want her to cum from her butt being devastated, certainly not from a petty blowjob, even from a succubus.  Vapula rapidly takes note of your sudden change of rhythm; she grins wickedly and starts taking Izma's whole dickflesh into her mouth, effortlessly deepthroating her.  Izma, being utterly crushed between her two lovers, squirms and thrashes savagely; it won't be long before she cums from your combined throat- and butt-fucking.");
		outputText("\n\nAs you give your tigershark lover another raging thrust, her groin hits Vapula's face, and the monstrously thick rod bumps against the back of her throat, making her cough unintentionally.  With a triumphal cry, you seize Izma's breasts, kneading them harshly as you pinch her nipples, caring little about her comfort in your fiery passion.  The extra stimulation is enough to make the tigershark cum, and her gaping pussy releases torrent of fem-spunk, soaking wet the floor with her juices.  Her orgasm is sending shivers across all her body and the way her body is trembling in your arms is enough to send you over the edge: you release a milky flood in her anus, packing her interior with seed; the contact of your goo being shot across her colon triggers her masculine orgasm, and she lets out a torrent of her own spunk into the succubus' waiting stomach, unloading her load into your purple slut as you unload yours into her.  The flow of fluids flowing in and out of her body makes her thrill in ecstasy until your " + cockDescript(x) + " stops vibrating, running out of spooge to shoot. Vapula keeps gluttonously sucking her subsistence out of Izma's traitorously long cock, squeezing her balls in order to extract as much semen as she can.");
		outputText("\n\nNodding in approval, you pull out your own " + cockDescript(x) + " out of your tigershark's ass and tell Vapula to keep going.  With your rod still in hand, you walk around Vapula and grab hold of her plush, jiggly ass; without warning, you plunge your still-dripping rod into her tight entrance.  Unsurprisingly, the anal penetration is much easier with the purple succubus.  She jolts a bit but this doesn't reduce in the least the intensity of her ministrations; her tainted saliva appears to have an aphrodisiac effect on Izma's cock, never letting go completely soft.  You pump your " + cockDescript(x) + " in and out of Vapula's plump rump while she still sucks off your tigershark lover, letting her balls fill back with cum.  The three of you go at it for what seems like hours, Vapula wobbling back and forth between your hard butt-fuck and Izma's dick.  Her asshole is somehow as tight as Izma's, but so wonderfully hot!  The sudden change of temperature is making you shiver in pleasure.  You keep pounding away, not really caring about a slutty creature used to butt-dickings.");
		outputText("\n\nYou stare at Izma, the two of you keeping eye contact as you both penetrate your fucktoy from both ends.  Then, at last, you wink at Izma  as you both cum a second time, releasing simultaneously streams of spunk in the succubus' horny body.  She happily devours all you've got, her lips and anal-lips contracting mercilessly in order to milk both cock from new fresh baby-batter.  You cum and cum, your " + cockDescript(x) + " and Izma's pulsating in rhythm as they paint the succubus' inner depths white.  You then pull out of her ass and walk toward Izma.  The poor tigershark is completely drained from the double-blowjob, and staggers her way toward the stream to get hydrated, pulling back her dick with a loud POP as it escapes from Vapula's needy lips.  The succubus looks disappointed to see her new sperm feeder running away, but you remind her your own " + cockDescript(x) + " still needs to be cleaned. With a happy sigh, she works on your junk for a while, tingling you in the most pleasant way as her tongue runs across your dickflesh and slurps all the remaining goo. When you're as empty as she's full, you both rest side to side, recovering from the intense fuck.");
	}
	//Vapula/Izma threesome (as female)
	else {
		outputText("You call your beta tigershark, telling her you'll have some use for her body.  Izma eagerly approaches you as you slip into your strap-on, only starting to frown when she sees the towering succubus accompanying you.  \"<i>What can I do for my alp-... wait, what are you doing with her?</i>\"  Vapula only smirks at Izma's puzzled reaction.");
		outputText("\n\nYou gently explain that you intend to have some extra fun, and you've brought this gorgeous creature to please you both.  Izma isn't really convinced, but still walks up to you, not willing to antagonize her alpha. You tell to remove her cloth and turn around so you can have a clear view of her toned butt.  \"<i>What do you have in mind, " + player.short + "?</i>\"\n\n\"<i>Shhh...just do as I say.</i>\"  With a discreet gesture, you order Vapula to get on her knees in front of Izma; she's going to feed from your tigershark this time.  With a conniving smile, Vapula obeys and before your shark lover can react, you're already grinding your obscene dildo against her muscular butt- cheeks while the purple succubus grabs hold of her 15 inch long pecker.  You rub the tip of your strap-on against her butt crack, sighing as the movement sends pleasurable vibrations down into your end.");
		outputText("\n\n\"<i>B-but wait! What are you guys doing? Are you going to fuck my... I don't want to-</i>\"");
		outputText("\n\n\"<i>Relax, love.  I'm just going to rail your little pucker while my trained fucktoy will take care of your junk, so you'll be pleased from both sides.  Who don't you admit you are being turned on.  Don't you like the idea of your alpha giving you a good dicking?</i>\"");
		outputText("\n\n\"<i>I.. just... I'm not used to-</i>\"");
		outputText("\n\n\"<i>Ha ha, as if you had any choice in the matter!  You're my beta, remember that.  Bend over, lift your tail and take it, I'm sure you'll love it as much as I will.</i>\"");
		outputText("\n\nIzma tries to struggle but you forcibly seize her arms and incline her back, fully exposing her butt to you.  Her initial resolution fades quickly when Vapula takes a good portion of her beast-like prick in her mouth, sucking it with expert precision and fondling her balls with care.  Izma's cries of protestation quickly turn into moans: the poor tigershark can't possibly resist a succubus' blowjob.  Meanwhile, you keep groping the tigershark's butt, giving it rough slaps for good measure.");
		outputText("\n\n\"<i>So fit... so muscular... </i>\" you sigh.  \"<i>Do you know how often you've teased me with it? Perhaps you thought you could get away with it.  Perhaps you thought your alpha would only ever want your cock, that she'd never be able to dish out what you can.  Well guess what, beta- the dick's on the other shoe now!</i>\"");
		outputText("\n\nYour taunts don't seem to affect Izma; if anything, they only turn her on all the more.  You tease Izma's butthole with your hands and dildo, stretching her fuckpillows to make room for your incoming junk.  The poor tigershark doesn't even resist anymore, completely overwhelmed by your teasing ministrations and Vapula's dexterous fondling.  Her shark tail is wagging in apprehension and excitement; her loose pussy is now freely gushing juices and her tight asshole is occasionally leaking some lubricant.  She's finally getting ready!");
		outputText("\n\nWith a roar of triumph, you grab her toned hips and force your artificial length inside her, widening her asshole and stretching it further.  Izma screeches, obviously not used to anal violation.  Her shark tail twists and wriggles nervously above her ass, nearly hitting you.  With one hand, you immobilize her inconvenient appendage; with your free hand, you grasp again on her toned buttocks, gripping the hard muscles as your herm lover contracts them; her anal walls are squeezing the dildo so tightly you can't even move it.  You tell Vapula to suck harder in order to relieve your tigershark's tension.");
		outputText("\n\nYour skilled succubus nods and starts clamping her pink lips around Izma's mammoth prick, effectively trapping it in an organic cock-ring.  At last you feel some of the intense pressure on your strap-on being released, allowing you to pull out and slam back, almost bruising your groin as it mashes against her hard butt-muscles. This time her ass completely gives in to your ferocious dick-assault.  You pull back and stuff her again, increasing the pace of your repeated thrusts as the both of you gain confidence.  You pant and bead sweat from the intense fuck, each outward pull sucking the malleable pink end of your strap-on further into your " + vaginaDescript(0) + ".");
		outputText("\n\nNeedless to say, Izma's mind is being torn in pleasure; the sweet blowjob she's receiving from your voracious succubus contrasts with your rough anal ploughing and brings her the weirdest mix of sensation.  She growls and moans, her hands grasping Vapula's head as its bobs up and down the length of her long prick.  Her pussy is dripping drops after drops of fem-juice.  You notice her asshole is getting wetter and wetter as you keep penetrating it; could it be that your tigershark lover is a buttslut in denial?  Excited at the idea of turning the prude tigershark into an eager anal beta, you intensify the pace of your butt-fucking, determined to bring her to ecstasy by the sole power of your artificial dick.");
		outputText("\n\nYou want her to cum from her butt being devastated, certainly not from a petty blowjob, even from a succubus.  Vapula rapidly takes note of your sudden change of rhythm; she grins wickedly and starts taking Izma's whole dickflesh into her mouth, effortlessly deepthroating her.  Izma, being utterly crushed between her two lovers, starts to squirm and thrash savagely; it won't be long before she cums from your combined throat - and butt-fucking.  As you give your tigershark lover another deep thrust, her groin hits Vapula's face, and the monstrously thick rod bumps against the back of the succubus's throat, making her cough unintentionally.  With a triumphal cry, you seize Izma's breasts, kneading them harshly as you pinch her nipples, caring little about her comfort in your fiery passion.");
		outputText("\n\nThe extra stimulation is enough to make the tigershark cum, and her gaping pussy releases torrent of fem-spunk, soaking wet the floor with her juices.  The sound of spattering fluid and her wail are enough to push you to your own peak; you grunt and groan as contraction after contraction slams into you as you deliriously continue to fuck the tiger-girl's ass, fucking yourself as you do.  Your orgasm triggers the purple end of the dildo: demonic semen floods Izma's anus, packing her interior with seed.  The contact of your goo being shot across her colon triggers her masculine orgasm, and she lets out a torrent of her own spunk into the succubus' waiting stomach, unloading her load into your purple slut as you unload yours into her.  The flow of fluids flowing in and out of her body makes her thrill in orgasm until your dildo stops vibrating, running out of spooge to shoot.  Vapula keeps gluttonously sucking her subsistence out of Izma's traitorously long cock, squeezing her balls in order to extract as much semen as she can.");
		outputText("\n\nNodding in approval, you pull the dildo out of your tigershark's ass with a wet pop and tell Vapula to keep going.  With your rod still in hand, you walk around Vapula and grab hold of her plush, jiggly ass and without warning stuff your still-dripping strap-on in her ass; unsurprisingly, the anal penetration is much easier with the purple succubus.  She jolts a bit but this doesn't reduce in the least the intensity of her ministration; her tainted saliva appears to have an aphrodisiac effect on Izma's cock, never letting her get completely soft.  You pump your dildo in and out of Vapula's plump rump, enjoying the pink end stroking your dripping " +vaginaDescript(0) + " while she still sucks off your tigershark lover, letting her balls fill back with cum.");
		outputText("\n\nThe three of you go at it for what seems like hours, Vapula wobbling back and forth between your hard butt-fuck and Izma's dick.  Heat seems to radiate off the succubus, which is unsurprising; the taste of semen and your rough dildo-ing have pushed the sexual creature deep into rut.  You pound away with abandon at her, not really caring about a slut used to butt- dickings.  You stare at Izma, the two of you keeping eye contact as you both penetrate your fucktoy from both ends.  Then, at last, you wink at Izma as you both cum a second time, releasing simultaneously streams of spunk in Vapula's burning body.");
		outputText("\n\nShe happily devours all you've got, her lips and nether-lips contracting mercilessly in order to milk both cocks for fresh baby-batter.  The sight of the shameless cumbucket getting what she wants pushes you to a new height and you orgasm and orgasm, your end of the strap-on vibrating furiously in your streaming depths as the other end and Izma pulsate in rhythm and paint the succubus' inner depths white.  You then pull out of her ass and walk toward Izma. The poor tigershark is completely drained from the double-blowjob, and staggers her way toward the stream to get hydrated, pulling back her dick with a loud POP as it escapes from Vapula's needy lips.  The succubus looks disappointed to see her new sperm feeder running away, but you remind her you still need to be cleaned.  With a happy sigh, she works on your " + vaginaDescript(0) + " for a while, tingling you in the most pleasant way as her tongue runs slowly across your drooling sex and slurps up all the girl slime she can possibly tease out of you.  When you're as dry as she is full, you both rest side to side, recovering from the intense fuck.");
	}
	stats(0,0,0,0,0,-2,-100,2);
	flags[VAPULA_DAYS_SINCE_FED] = 0;
	flags[VAPULA_TEASE_COUNT] = 0;
	doNext(13);
}
//Feed (as female)
function chixFeedVapulaBlehblehIVantToZuckYourSpooo():void {
	clearOutput();
	outputText("You produce the demonic dildo and hold it by the hilt of its giant purple end, wagging it lazily by your side with a playful grin.  Vapula knows what that means; she is on her knees in an instant, staring at you with wolfish anticipation.");
	//Feed/Tease
	var tease:int = 0;
	if(flags[VAPULA_HAREM_FUCK] == 0) tease = 3771;
	simpleChoices("Feed",chicksFeedVapula,"Tease",tease,"",0,"",0,"",0);
}
//Tease
function teaseVapula():void {
	clearOutput();
	//Requires: Vapula not fucking harem
	if(flags[VAPULA_HAREM_FUCK] == 0 && (flags[VAPULA_DAYS_SINCE_FED] == 0)) {
		outputText("You decide you aren't going to give her what she wants so easily . You're also genuinely curious about how badly she needs cum, and how far you can push her.  You don't say anything as you slowly buckle the strap-on, sighing as you slip the small, pink end into your " + vaginaDescript(0)+ ".  You make Vapula wait as you close your eyes and make the dildo pulse inside you, slowly filling you up and then withdrawing, letting it push up against your " + clitDescript() + ".");
		outputText("\n\nYou open your eyes to find Vapula is biting her lip fretfully from watching you, a small pool of liquid arousal collecting beneath her.  You smile lazily as you stand over her and brush the purple end against her face; the way this makes the end wedged inside of you push to and fro against your sensitive walls makes you coo.  Vapula follows the bulbous tip like a cat and a string; as it brushes against her mouth she tries to wrap her lips around it, but you tut mockingly and pull it out of reach. With an evidently huge force of will the succubus makes herself be still again, and you resume stroking her face with your artificial cock.");
		outputText("\n\n\"<i>How badly do you want this, slut?</i>\" you ask.");
		outputText("\n\n\"<i>Very badly, mistress.</i>\" she replies.");
		outputText("\n\n\"<i>Perhaps you could describe it to me.</i>\"");
		outputText("\n\n\"<i>Like... like being thirsty, hungry and horny at the same time.  But mostly horny. It- it makes me salivate.</i>\"  She swallows as if to prove this point.  You smirk and continue to gently rub the cock against her face, gently pleasuring yourself as you do.");
		outputText("\n\n\"<i>How interesting. Do all succubae get like this?</i>\"");
		outputText("\n\n\"<i>Please give me my fix, mistress, then we'll discuss this all you want,</i>\" grits Vapula through pointed teeth.  \"<i>I'm fucking dying here!</i>\"  Your face falls mockingly, and you slowly step backwards.");
		outputText("\n\n\"<i>Ohh.  Now you've said a rude word to your mistress.  I guess you don't want it so badly after all.</i>\"  Vapula watches the cock recede with almost comical despair.");
		outputText("\n\n\"<i>Wait, no...  I didn't mean it!  Please don't...</i>\"");
		outputText("\n\n\"<i>You'll talk about it tomorrow, my hungry little cumslut.  If you're good.</i>\" You turn and stride away, laughing as you slowly unbuckle the strap-on.  The expression on Vapula's face as you leave is going to keep you very warm tonight.");
		stats(0,0,0,0,0,0,(10+player.sens/10),0);
		flags[VAPULA_TEASE_COUNT]++;
	}
	//Second Tease
	//Requires: Vapula not fucking harem, teased the day before
	else if(flags[VAPULA_HAREM_FUCK] == 0 && flags[VAPULA_DAYS_SINCE_FED] == 1) {
		outputText("You smile as once again Vapula takes up the position on her knees, and you buckle on the strap- on and stand over her.  This time you make the pink end grow long, closing your eyes as it inches up your tunnel, before slowly thrusting your " + hipDescript() + " backwards and forwards in front of your succubus, letting it shrink and grow so it climbs up and down your wet walls.");
		outputText("\n\nBreathing heavily, you open your eyes to find Vapula is struggling to stop herself from openly drooling, her eyes shooting from you back to the tip of the purple dildo in front of her as she licks her lips and swallows continuously.");
		outputText("\n\n\"<i>You must be very hungry by now, slut,</i>\" you tease.");
		outputText("\n\n\"<i>You have no idea,</i>\" she replies wetly. Once again you begin to rub the dildo across her beautiful face.");
		outputText("\n\n\"<i>It must be hard knowing that no matter how good you are at milking dick, it has no effect upon whether the person who owns you will give you cum.  And that you gave me this power over you.  How does that feel?</i>\"");
		outputText("\n\n\"<i>It has given me a valuable insight into cruelty, certainly,</i>\" Vapula growls.  She is having trouble concentrating, her lips instinctively reaching for your dildo's crown.  \"<i>It amazes me you still have a soul.</i>\"");
		outputText("\n\n\"<i>That's not a very nice thing to say,</i>\" you purr, stopping your ministrations for a moment and pulling away slightly.  A look of anguish appears on Vapula's face.  \"<i>What would you do for me now, just to get your fix?</i>\"");
		//[Hooves: 
		if(player.lowerBody == 1 || player.isTaur()) outputText("\"<i>I would worship your feet, mistress.  I would clean your hooves with my tongue to a shine, tease out every scrap of dirt from every crevice.  And I would thank you for the privilege.</i>\"");
		//[Naga: 
		else if(player.isNaga()) outputText("\n\n\"<i>I would worship your scales, mistress.  I would buff every single one with my tongue so it shone, lick every inch of your tail, deep throat you all the way down into my belly.  And I would thank you for the privilege.</i>\"");
		//[Drider: 
		else if(player.isDrider()) outputText("\n\n\"<i>I would be your egg dump, mistress.  I would take your dripping ovipositor in every hole, my cunt, my ass, my mouth, then clean it with my tongue afterwards.  I would find and feed you ovi-potions just so you could keep me stuffed with your essence constantly.  And I would thank you for the privilege.</i>\"");
		//[Goo: 
		else if(player.isGoo()) outputText("\n\n\"<i>I would let you engulf me, mistress.  I would let you push yourself into my every hole and crevice, drown me in your essence, fuck me so completely I wouldn't know where I started and you began.  And I would thank you for the privilege.</i>\"");
		else if(player.lowerBody == 2 || player.lowerBody == 9 || player.lowerBody == 10 || player.lowerBody == 14 || player.lowerBody == 17) outputText("\n\n\"<i>I would worship your feet, mistress.  I would lick every inch of your claws, massage your soft undersides with my tongue.  I would pare all of your claws to needle sharpness and then let you test them on my backside.  And I would thank you for the privilege.</i>\"");
		//[Insect: 
		else if(player.lowerBody == 7 || player.lowerBody == 15) outputText("\n\n\"<i>I would worship your feet, mistress.  I would lick every inch of your boots, clean your soles with my tongue.  I wouldn't stop until they shone. And I would thank you for the privilege.</i>\"");
		//[Human/demonic feet: 
		else outputText("\n\n\"<i>I would worship your feet, mistress.  I would lick every inch of them, clean your soles with my tongue, between your toes, lavish each of your pinkies with attention as if they were ten cocks belonging to you.  And I would thank you for the privilege.</i>\"");
		
		outputText("\n\nShe speaks feverishly, without stopping for a moment's thought.  You laugh at her earnestness.");
		
		outputText("\n\n\"<i>You've got such a fertile imagination on you when you're hungry, slut.  Makes me wonder what else you could come up with if I left you a little while longer.</i>\"  You pause as you run your fingers through her hair, before once again bucking your hips towards her face, the tip of the purple dildo inches away from her face.  You lavishly lengthen your dildo, packing your tunnel and working it back and forth as the thought of what you're doing to Vapula and her colourful words fizzle in your mind.  You open your mouth, arch your back and then exhale with deep satisfaction as you reach a small but perfectly formed high, your " + vaginaDescript(0) + " dribbling juices around your harness.  You smile down sweetly at Vapula, who doesn't look like she's blinked in a while, and slowly step away, leading the dildo away from her bit by bit.");
		outputText("\n\n\"<i>I guess we'll find out, won't we? Same time tomorrow.</i>\"");
		outputText("\n\nYou turn and walking away, your mouth curling into a wicked grin as a despairing wail reaches you from behind...");
		flags[VAPULA_TEASE_COUNT]++;
	}
	//Third Tease
	else {
		//Requires: Vapula not fucking harem, teased two days in a row
		outputText("Once again you buckle up, sighing with pleasure as you sink the pink dildo into your moist hole, and once again you wait until Vapula gets onto her knees before you.  She looks at you silently and sullenly as you droop the monstrous purple end over her face.");
		outputText("\n\n\"<i>How are we feeling today then, slut?</i>\"  By way of answer, Vapula simply opens her mouth.  A small waterfall of drool cascades out of her mouth, quickly forming an impressive pool of the stuff in front of her.  She closes it again, still oozing saliva, and waits, staring upwards at you hollowly.  You giggle, amazed and perversely proud of how far you've managed to push your succubus slave.");
		outputText("\n\n\"<i>Cute. But where are your manners, slut?  I think maybe you need to clean up after yourself before we can talk about giving you a meal.  I think maybe-</i>\"  Vapula surges forwards, faster than you would have given her credit for, latching onto the dildo before you can pull it away from her.  She pushes into it, growling with ferocious need, so hard you lose your balance and fall onto your back.  Immediately the succubus is on you, your artificial cock swiftly disappearing between her purple lips.");
		outputText("\n\nSwallowing it up to the hilt she begins to work it savagely, slurping and grunting obscenely.  Before you can properly react, she catches the base of the dildo with her teeth and pushes it into you as hard as you can.  You gasp as the pink end responds, growing by several inches and sliding further into your moist cunt. In and out Vapula drags the dildo, slapping it into your groin as she fucks you whilst blowing the purple end for all she is worth, her overflowing saliva spattering upon your thighs.  For a moment you think about getting up, asserting your authority and making her stop... but then the warm length wedged in your depths makes you arch your back with pleasure as Vapula shakes the cock in her mouth around like a bear with a salmon, making your end twist and spasm delightfully.");
		outputText("\n\nDeciding it is worth taking advantage of the insane hunger you've managed to stoke in your bitch, ");
		//Naga: 
		if(player.isNaga()) outputText("you slide your tail under and over her trunk, wrapping your coils around her and drawing her face into your stuffed crotch.");
		//Other: 
		else if(player.isTaur() || player.isGoo() || player.isDrider()) outputText("you sit the monstrous half of your body down comfortably and draw her face into your stuffed cotch.");
		else outputText("you open your [legs] and wrap them around her head, drawing her face into your stuffed crotch.");
		
		outputText("\n\nShe works on it for what seems like hours.  You look down at your slut; she keeps staring at you with avid yet playful eyes, never breaking eye contact as she relentlessly throatfucks herself; you feel her lips curve a little as the shape of a ravenous smile appears on her face, and her eyes are glittering with an insatiable need.  The naughty bitch!  She knows she's going to get what she wants, whether you like it or not.  You wish you were able to control yourself, but through the sheer force of her obscene hunger the succubus is somehow able to control your end of the strap-on, making the dildo shrink, pulsate and push into your " + vaginaDescript(0)+ " involuntary, which soon has you panting, groaning, and thrusting back into her to sate your own growing need.");
		outputText("\n\nYour stamina is rapidly overwhelmed and you decide to reward her effort; you savagely press Vapula's head against your groin, burying all eight inches of your false cock into her waiting throat; in symphony the two of you will your throbbing dildo to expand to pack you mercilessly tight, making you cum brutally.  Your " + clitDescript() + " pulses as your vagina contracts ecstatically around the bulging sex toy; vaguely you feel release at the other end, and you hear Vapula loudly and shamelessly enjoy what the dildo pumps out.  You abandon yourself to the climax and keep thrusting your " + hipDescript() + " into her face, girlcum spurting around your harness.");
		outputText("\n\nAfter a long haze of mindless bliss, you feel long fingers undoing the strap-on and lifting it away, before curling around your thighs.  You peacefully look down to find Vapula bending into your crotch, her warm, slimy tongue touching your belly. She looks about six months pregnant with the amount of spooge she has managed to milk from the dildo, but she is still intent upon licking you clean.  You sigh and let her, her tongue expertly gliding across your skin and exploring every corner and fold of your dripping sex; she smacks her lips and happily hums as she goes about it, evidently enjoying you like a dessert to the fine main course she just received.  Eventually she finishes her mutually pleasurable task, and the two of you slowly get to your feet.  You want to be angry with her but you are too satiated to properly feel it; you can see in her smiling eyes that she knows it.");
		outputText("\n\n\"<i>You're a bad, filthy little cumslut,</i>\" you say, as sternly as you can.");
		outputText("\n\n\"<i>That's what you train me to be, mistress,</i>\" she murmurs.  You send her on her way to digest her lavish meal with a slap on the ass.");
		stats(0,0,0,0,0,0,-100,0);
		flags[VAPULA_DAYS_SINCE_FED] = 0;
		flags[VAPULA_TEASE_COUNT] = 0;
	}
	stats(0,0,0,0,0,0,0,1);
	doNext(13);
}
	
//Feed (as female)
function chicksFeedVapula():void {
	clearOutput();
	//[Teased once or twice: 
	if(flags[VAPULA_TEASE_COUNT] > 1) {
		outputText("You push the pink end of the dildo into you with a sigh, then strap yourself into the harness so that the monstrous purple end bobs out in front of you.  You stand over a tense Vapula and tease her with it first, lightly brushing her face with the tip for a while.  She swallows thickly and licks her lips as you caress her with your cum fountain, but makes no movements towards it.  Eventually you giggle at her furious concentration and tell her you're going to reward her for being such a good slut, before pushing the end against her lips.  A flood of ecstatic thank-you-mistresses are swiftly muffled out as the dildo disappears into her mouth.");
	}
	else {
		outputText("You tell Vapula you're going to reward her for being such a good slut; pushing the pink end of the dildo into you with a sigh, you strap yourself into the harness so that the monstrous purple end bobs out in front of you.  You giggle as Vapula grabs hold of it and proceeds to lick it, coating the entirety of your artificial junk with her warm, sweet saliva.");
	}
	outputText("\n\nShe voraciously slurps the end and smiles up at you, making you laugh even harder.  This bizarre ritual is giving you a good insight into why guys like blowjobs so much; although you can't feel what your succubus slut is doing, it certainly feels very good to see her on her knees like this in front of you, slurping away at you with such evident enjoyment.  Hell, the fact you can't feel it almost makes it better; you could stand here and make her debase herself like this all day if you wanted to.");
	outputText("\n\nVapula evidently has other ideas, however. Her smooth fingers trail across your " + buttDescript() + ", clasping you for a time as you run your fingers through her long hair, before inching inwards, sinking one and then two fingers into your " + assholeDescript() + ".  You close your eyes and flex your mind, making your end of the dildo twitch and then pulse, making it grow and then ebb, grow and then ebb, slowly working your tunnel until it feels wide and soaked with arousal.  Still looking cheekily upwards, Vapula crooks her fingers inwards, stroking at your dildo through your walls.  With a groan of impatience, you grab her head and drive the whole of the purple dildo into her mouth, stuffing her full of the warm, artificial dick.  She nearly chokes at first but her old reflexes acquired from a whole life devoted to lewdness and licentiousness start kicking in; Vapula gluttonously deepthroats it, softly moaning as she fingers herself with one hand and finger fucks your ass with the other.  She sucks like a whore, her lips and throat squeezing the dildo expertly, apparently oblivious to the fact it can't feel her.");
	outputText("\n\nYou shake your head in wonder at your succubus slave; she really is just hungry for dick.  You decide to give her what she evidently needs, take hold of her hair and piston into her, driving down her tight throat and then back out again, using the outward pull to thrust your end further into yourself, sending rivulets of girlcum down your thighs.");
	outputText("\n\nShe works on it for what seems like hours.  You look down at your slut; she keeps staring at you with avid yet playful eyes, never breaking eye contact as she relentlessly throatfucks herself; you feel her lips curve a little as the shape of a ravenous smile appears on her face, and her eyes are glittering with an insatiable need.  The sight is enough to increase your own arousal, and you begin to move your dildo around more freely, sawing into her face as you push it backwards, forwards, grow it, shrink it, and then eventually just make it vibrate with violent force.  Your stamina is rapidly overwhelmed and you decide to reward her effort; you savagely press Vapula's head against your groin, burying all eight inches of your false cock into her waiting throat; deliriously you will your throbbing dildo to expand to pack you mercilessly tight, finally pushing you over the edge.  Your " + clitDescript() + " throbs as your vagina spasms ecstatically around the bulging sex toy; vaguely you feel release at the other end, and you hear Vapula loudly and shamelessly enjoy what the dildo pumps out.  You abandon yourself to the climax and keep thrusting your " + hipDescript() + " into her face, girlcum spurting around your harness.");
	outputText("\n\nAfter a long haze of mindless bliss, you feel long fingers undoing the strap-on and lifting it away, before curling around your thighs.  You peacefully look down to find Vapula bending into your crotch, her warm, slimy tongue touching your belly.  She looks about six months pregnant with the amount of spooge she has managed to milk from the dildo, but she is still intent upon licking you clean.  You sigh and let her, her tongue expertly gliding across your skin and exploring every corner of your dripping sex; she smacks her lips and happily hums as she goes about it, evidently enjoying you like a dessert to the fine main course she just received.  Eventually she finishes her mutually pleasurable task, and the two of you slowly get to your feet. Without a word you send her on her way to digest her lavish meal with a slap on the ass.");
	doNext(13);
	stats(0,0,0,0,0,0,-100,0);
	flags[VAPULA_DAYS_SINCE_FED] = 0;
	flags[VAPULA_TEASE_COUNT] = 0;
}

//Forcefeed
function vapulaForceFeeds():void {
	if(player.hasVagina() && player.hasKeyItem("Demonic Strap-On") >= 0 && !player.hasCock()) {
		outputText("\n<b>In the night...</b>\nArousal blooms in your dreams, and you are relentlessly pushed into increasingly juicier and filthier fantasies; feeling hopelessly wet, you half awaken and hazily slide a hand down towards your crotch, to try and find release and rest.  Your fingers touch leather and latex where your vagina should be; bewildered, you rise to see Vapula working around your crotch, tightening the final harnesses of your strap-on, locking you into the pink dildo throbbing in your " + vaginaDescript(0) + " whilst she licks hungrily at the tip of the opposite end.  You try to sit up but the ferocious succubus pins you down ruthlessly, her strength increased by her state of hunger.  She smirks at you wickedly and whispers, \"<i>So you don't want me to use any dick but the one I gave you, yet you won't feed me?  That's very bad of you, " + player.short + "... really, really bad...  Do you want to starve me?  Do you want me to beg you for cum?  You naughty slut, you better be ready because I'm going to get what is rightfully mine.  I'm HUNGRY!</i>\"");
		outputText("\n\nWith a wolfish groan she swallows the purple dildo up to the hilt and begins to work it savagely, slurping and grunting obscenely.  Before you can properly react, she catches the base of the dildo with her teeth and pushes it into you as hard as you can.  You gasp as the pink end reacts, growing by several inches and sliding further into your moist cunt.  In and out Vapula drags the dildo, slapping it into your groin as she fucks you whilst blowing the purple end for all she is worth, her saliva running down your thighs.  For a moment you think about getting up, asserting your authority and making her stop... but then the warm length wedged in your depths makes you coo with pleasure as Vapula shakes the cock in her mouth around like a bear with a salmon, making your end twist and spasm delightfully.  Deciding it is worth taking advantage of her insane hunger, ");
		//Naga: 
		if(player.isNaga()) outputText("you slide your tail under and over her trunk, wrapping your coils around her and drawing her face into your stuffed crotch.");
			//Other: 
		else if(player.isTaur() || player.isGoo() || player.isDrider()) outputText("you sit the monstrous half of your body down comfortably and draw her face into your stuffed cotch.");
		else outputText("you open your [legs] and wrap them around her head, drawing her face into your stuffed crotch.");
			
		outputText("\n\nShe works on it for what seems like hours.  You look down at your slut; she keeps staring at you with avid yet playful eyes, never breaking eye contact as she relentlessly throatfucks herself; you feel her lips curve a little as the shape of a ravenous smile appears on her face, and her eyes are glittering with an insatiable need.  The naughty bitch! She knows she's going to get what she wants, whether you like it or not.  You wish you were able to control yourself, but through the sheer force of her obscene hunger the succubus is somehow able to control your end of the strap-on, making the dildo shrink, pulsate and push into your " + vaginaDescript(0) + " involuntary, which soon has you panting, groaning, and thrusting back into her to sate your own growing need.");
		outputText("\n\nYour stamina is rapidly overwhelmed and you decide to reward her effort; you savagely press Vapula's head against your groin, burying all eight inches of your false cock into her waiting throat; in symphony the two of you will your throbbing dildo to expand to pack you mercilessly tight, making you cum brutally.  Your " + clitDescript() + " pulses as your vagina contracts ecstatically around the bulging sex toy; vaguely you feel release at the other end, and you hear Vapula loudly and shamelessly enjoy what the dildo pumps out.  You abandon yourself to the climax and keep thrusting your " + hipDescript() + " into her face, girlcum spurting around your harness.");
		outputText("\n\nAfter a long haze of mindless bliss, you feel long fingers undoing the strap-on and lifting it away, before curling around your thighs.  You peacefully look down to find Vapula bending into your crotch, her warm, slimy tongue touching your belly.  She looks about six months pregnant with the amount of spooge she has managed to milk from the dildo, but she is still intent upon licking you clean.  You sigh and let her, her tongue expertly gliding across your skin and exploring every corner of your dripping sex; she smacks her lips and happily hums as she goes about it, evidently enjoying you like a dessert to the fine main course she just received.  Eventually she finishes her mutually pleasurable task, and the two of you slowly get to your feet. You want to be angry with her but you are too satiated to properly feel it; you can see in her smiling eyes that she knows it.  Without a word you send her on her way to digest her lavish meal with a slap on the ass, and return to your bed.");
		stats(0,0,0,0,0,0,-100,1);
		flags[VAPULA_DAYS_SINCE_FED] = 0;
		flags[VAPULA_TEASE_COUNT] = 0;
		flags[VAPULA_EARNED_A_SPANK] = 1;
	}
	//[if no fuck harem is on and PC hasn't fed/fucked Vapula for 5 days that scene will trigger at night]
	else if(player.hasCock()) {
		outputText("You are suddenly awakened by a gentle tingle at the base of your crotch.  As you open your eyes, you slowly make out in the surrounding darkness a purple shape bobbing up and down leisurely.  You realize that Vapula has profited from your unconsciousness to take your genitals by force!  You try to sit up but the ferocious succubus pins you down ruthlessly, her strength increased by her state of hunger.  She releases your junk with a wet POP and starts licking her lips, slurping back any drop of pre-cum that might have escaped her voracious mouth.  She smirks at you wickedly and whispers, \"<i>So you don't want me to use any dick but yours, yet you won't feed me?  That's very bad of you, " + player.short + "... really, really bad... Do you want to starve me?  Do you want me to beg you for your cum?  You naughty stud, you better be ready because I'm going to get what is rightfully mine.  I'm HUNGRY!</i>\"  With a wolfish groan, she starts sucking you off again, still pinning you down with one hand while the other tickles your crotch.");
		outputText("\n\nShe works on it for what seems like hours. You look down at your slut; she keeps staring at you with avid yet playful eyes, never breaking eye contact as she relentlessly throatfucks herself; you feel her lips curve a little as the shape of a ravenous smile appears on her face, and her eyes are glittering with an insatiable need. The naughty bitch!  She knows she's going to get what she wants, whether you like it or not.  You wish you were able to control yourself, but the covetous succubus never lets go of your " + cockDescript(x) + ", clinging to it like an animal.");
		outputText("\n\nYour stamina is rapidly overwhelmed and you decide to reward her effort; you savagely press Vapula's head against your groin, effectively burying all of your " + cockDescript(x) + " in her waiting throat; her tongue keeps teasing your rod for a few seconds, and then you cum, brutally.");
		if(player.balls > 0) outputText("  Your " + ballsDescriptLight() + " churn");
		else outputText("  Your " + cockDescript(x) + " twitches");
		outputText(" as you release a sticky spooge fountain in her stomach.");
		outputText("\n\nHer lips keep squeezing your junk in order to milk everything you've got, and in your shuddering orgasm you're too eager to comply.  With a surrendering sigh, you abandon yourself to your climax and keep cumming, squirting your baby-batter to the last drop as the succubus keeps gulping it.  Her eyes are closed in an expression of complete satisfaction; she enjoys her meal to its full extent, filling her belly with your spooge");
		//[if cum production is massive]
		if(player.cumQ() >= 1500) outputText(" until she looks 6 months pregnant.  At last, the cum-flow spilling through your urethra starts to ebb and your " + cockDescript(x) + " stops throbbing; only then does she removes your junk from her mouth with a loud POP.  Your tool appears to be clean of any spooge: your cock-slut did a very good job.  Satisfied, you pat her head with your cock and let her digest her lavish meal.");
		stats(0,0,0,0,0,0,-100,1);
		flags[VAPULA_DAYS_SINCE_FED] = 0;
		flags[VAPULA_TEASE_COUNT] = 0;
		flags[VAPULA_EARNED_A_SPANK] = 1;
	}
	doNext(1);
}


//Spank Vapula for misbehaving.
//Requires Vapula force herself on you for food.
//Requires dick or vapula dildo!
//Requires bipedal-ness
function spankVapulaLikeABoss():void {
	clearOutput();
	outputText("Without any warning, you grab the lusty succubus by the wrists and pull her into you, easily manhandling her surprised form until she's bent over your [leg], vulnerable and squealing like the gutter-slut she is.  Her wings batter at your face and chest, but after a little wrangling, you pin them flat against her back.  The best she can manage now is a few weak twitches at her wing-tips.  Her large, well-formed breasts jiggle and shake as she struggles, but all the trembling purple mountains accomplish is bringing a ready flush to your " + player.skin());
	if(player.hasCock()) outputText(" and a healthy surge of blood to [eachCock]");
	else if(player.hasVagina()) outputText(" and a teltale moistness to your nethers");
	outputText(".");
	outputText("\n\n\"<i>Be still, you whimpering, useless excuse for a demon!</i>\" you command.  Unsurprisingly, she continues to struggle.");
	outputText("\n\nVapula cries,  \"<i>Lemme go!  Can't we just go double team some people and forget about all this?</i>\"  Her violet eyes crane hopefully towards you, and she wears a winning smile across the smooth curves of her lips.  For a moment, you reconsider your plans, but then again, she earned this when she forced herself on you.  Upon seeing the resolve in your gaze, her struggles start anew, but you have her firm - she's not going anywhere.");
	outputText("\n\nOnce you have the rebellious succubus well in hand, you lift your right palm high in the air, upraised and ready to drop.  The moment seems to drag on for a while, and once your female slave is trembling with worry, you bring it down hard.  SMACK!  The hit rings out through your camp");
	if(companionsCount() > 2) outputText(", drawing the eyes of your other companions.");
	else if(companionsCount() == 2) outputText(", drawing the attention of your other companion.");
	else outputText(", echoing off the sentinel-like rocks that seem to ring your encampment.");
	outputText("  Her tail goes wild at the impact, whipping around in a frenzy and actually managing to slap your cheek!  That bitch!");
	outputText("\n\nThis time, your hand cocks and releases in a split-second, coming down with even more force than before.  Vapula screams, \"<i>Ow! Stop it, by Lethice, please!</i>\"  This time, her thrashing, spaded tail stays obediently low, harmlessly cutting through the air so as not to irritate you.");
	outputText("\n\n\"<i>That's better,</i>\" you growl as you admire her gradually reddening bottom.  It's certainly unusual to watch a purple behind turn red, quite the opposite of how it would look on a normal person.  Still, two red handprints quickly become apparent on the closest cheek, one laid over top of the other.  \"<i>Now hold still and take your punishment,</i>\" you order, \"<i>I expect a demon like you ought to be enough of a pain-loving masochist to get off before I finish.  Isn't that right?</i>\"  You smack her other, untouched cheek for a bit of audible punctuation and smile at the high pitched peep of pain that she makes.");
	if(player.hasPerk("Sadist") >= 0) outputText("  Dishing out all this suffering is getting you a little hot under the collar, and you squirm a bit in place in anticipation of the pain to come.");
	outputText("\n\nVapula scrunches her eyes shut and shakes her purple hair around, barely making a sound outside of her instinctive peep at the hit.  You lift your palm again and bring it down in another spank, not quite as hard as the last but in the same place.  She bites her lip but stays blissfully silent.  Well, at least she's not calling every imp in a five mile radius to come bother you.  You paddle her again, finding some untouched lavender flesh to abuse while you watch the new handprints appear on her shapely behind.  Tears well up at the corners of the succubus's eyes, and she makes a start at talking.");
	outputText("\n\nYou interrupt, scolding, \"<i>Don't even start.  You swore to obey me as your [master] and you broke that promise.  Now you have to endure this.  Buckle up, sweatheart.</i>\"");
	outputText("\n\nYou begin to attack her bottom with a barrage of quick slaps, bouncing the purple derriere back and forth from the hard-hitting strikes.  You don't spend too much time in any one place, instead trying to make sure you hit every untouched, unmarked portion of that beautiful butt.  Soon your slave's bouncy cheeks are tanned to the point where they seem to glow a rosy red, tender and sore.  Vapula bites her lips with each impact and tries to hold back her tears, but they flow on, unabated.");
	outputText("\n\nThe succubus is panting, gasping really, and while you assume it to be pain at first, when you touch her warm, flushed skin to dab away one of her tears, you realize that she's actually turned on.  The bitch IS getting off on it.  You aren't sure if she's actually a natural painslut or just obeying your masochistic suggestions, but a quick dip into the violet crevasse between her legs confirms the presence of copious lubricants and a hard, aroused clitty.  Vapula shudders when you stroke her pussy and begs, \"<i>Please, let's fuck!  I'm so wet for you!  You can spank me while we fuck until my ass is bruised and swollen!  Don't you wanna feel my pussy clench each time you punish me for being a disobedient little skank?</i>\"");
	outputText("\n\nWhile that's certainly an appealing offer, it would defeat the point of this little exercise.  You shake your head sadly, ignoring the heat in your ");
	if(player.hasCock()) outputText("maleness");
	else if(player.hasVagina()) outputText("vagina");
	else outputText("tingling anus");
	outputText(", and bring your palm back down again to start a fresh wave of punishment.  Vapula actually does begin to make vocalizations at this point, but they sound closer to moans and whimpers of pleasure than cries of pain.  As a matter of fact, you can feel the hard nubs of her nipples dragging across your [leg] every time she contorts in pain.  A few blows later and stray drops of feminine lubricants spatter off your [foot].  Vapula's tail stabs towards her vulnerable sex, but you immediately yank it away and give her a harder than usual slap for punishment.");
	outputText("\n\nIf she's going to cum, it's going to be because of you.  There's no masturbating your way out of punishment.  You pound away at that reddened bottom with renewed vigor, and soon, those drops of enjoyment turn into a tide of lubricated pleasure.  Vapula's head begins to thrash with each spank, and her body quakes, not from orgasm but from being on the edge for so long.  You double the pace, and as the entirety of her bottom goes red, Vapula cums, unleashing a tide of succubus-spunk to stain your [leg].  You give her a few gentle swats to see her orgasm through and release her once it's over.");
	outputText("\n\nThe demoness nervelessly flops off you and onto the ground, moaning in pain and pleasure, rubbing her abused bottom.  Hopefully she learned her lesson, and if not, you can always teach it to her again, next time.");
	//{+20ish lust}
	stats(0,0,0,0,0,0,(10+player.lib/7),0);
	//{Sadist: + 20 lust}
	if(player.hasPerk("Sadist") >= 0) stats(0,0,0,0,0,0,(10+player.lib/7),0);
	flags[VAPULA_EARNED_A_SPANK] = 0;
	doNext(13);
}


