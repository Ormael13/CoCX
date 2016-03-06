package classes.Scenes.Places{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.Items.WeaponLib;
	import classes.Scenes.Places.Owca.*;

	public class Owca extends BaseContent{

	public function Owca()
	{
	}

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


public function gangbangVillageStuff():void {
	clearOutput();
	if (flags[kFLAGS.OWCA_UNLOCKED] == 1) owcaMainScreenOn();
	else gangbangVillageFirstGoRound()
}
//First encounter (Z)
private function gangbangVillageFirstGoRound():void {
	clearOutput();
	/*if (flags[kFLAGS.OWCAS_ATTITUDE] < 5) {
		desperateVillages();
		return;
	}*/
	if (flags[kFLAGS.DECLINED_TO_VISIT_REBECCS_VILLAGE] == 0 && flags[kFLAGS.TIMES_REFUSED_REBECCS_OFFER] == 0 && flags[kFLAGS.TIMES_IN_DEMON_PIT] == 0) {
		//[Attitude is set to 50]
		flags[kFLAGS.OWCAS_ATTITUDE] = 50;
		flags[kFLAGS.VAPULA_SUBMISSIVENESS] = 50;
		outputText("You wander for quite a while in an endless field of grass before spotting a commotion in the distance.  A myriad of creatures have gathered in the path ahead, waving to you enthusiastically, some still holding tightly to their farm tools.  It's quite an odd sight, all these happy farmhands extending a warm welcome.  You simply accept it as a gesture of kindness and make your way toward the crowd of smiling faces.");
		outputText("\n\nA female emerges from the group to greet you and tries to communicate her intentions, holding up a peace sign.  As she approaches, her features become more apparent.  Her appearance is strikingly similar to that of a human.   Her face is pale, with the appearance of porcelain.  Gazing lower, you see that she possesses a bountiful bosom that bulges against her crude peasant dress and hips that sway with grace as she approaches nonchalantly.  Only the two little nubs on her forehead and the long, white woolen mound of her hair suggest she's anything more than a stray village girl from a human town like your own.  The rest of the crowd is of similar appearance, and they begin to follow her lead, walking towards you.  Is this a herd of sheep people?  Or, if you could dare bring yourself to say it... sheeple?");
		outputText("\n\nThe girl closes the distance between you with three quick strides, and swiftly plants a peck on your cheek.  You straighten up a bit in surprise at such a friendly greeting from the inhabitants of this land.  Her cool breath smells like fresh dairy milk and her eyes are glinting as she speaks.  \"<i>Greetings!  You're not from this world, are you?  We've seen many a vagabond adventurer in this land.  My name's Rebecc, and we're always happy to meet your kind!</i>\"");
		outputText("\n\nYour curiosity gets the better of your caution, and you admit that you're indeed a traveller from another world, then introduce yourself.");
		outputText("\n\n\"<i>Of course, of course.  Why don't you follow us, valiant warrior?  We were just about to return home; we could use a little company.</i>\"  As she talks you can't help but notice she keeps readjusting her dress, subtly revealing a bit more of her cleavage at every shift.  You see she also takes repeated glances at your crotch, probably thinking she's being discreet enough.  Her nipples are hardening through her dress, her smile is teasing you; her entire body language seems to be an open invitation as well as a display of seduction.");
		outputText("\n\nDo you follow her?");
		doYesNo(agreeToFollowRebecFirstTime,dontGoToZeVillage);
	}
	//As long as you don't follow her once, display this on subsequent encounters (Z)
	else if (flags[kFLAGS.TIMES_IN_DEMON_PIT] == 0) {
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
		if (player.cor > 50) outputText("  You can't help but smile internally.  Let her think that, if she wants.");
		outputText("\n\nShe grabs your hand and drags you to her village, hopping joyfully as she keeps thanking you for your heroic gesture.  You finally reach her home; a handful of people join you, attracted by the noise she's been making.  People are everywhere showing unconditional gratitude, bowing down and muttering thankful words as you go by; it's almost as if they were intimidated - or ashamed - by someone worthier than them.  Eventually you are left alone with the charming farmer girl.");
		outputText("\n\n\"<i>My home is yours, hero; alongside everyone else's.  You will always be welcome here.  Don't hesitate to come to my place; you must feel all dirty and sullied from these corrupted monsters.  Don't worry, I'll clean you up.</i>\"  She winks at you and walks into her house, leaving her door open as an invitation.");
		outputText("\n\n(<b>Owca Village added to your 'Places' menu.</b>)");
		flags[kFLAGS.OWCA_UNLOCKED] = 1;
		doNext(gangbangVillageStuff);
	}
}
private function dontGoToZeVillage():void {
	clearOutput();
	flags[kFLAGS.DECLINED_TO_VISIT_REBECCS_VILLAGE]++;
	camp.returnToCampUseOneHour();
}
//First plea (Z)
private function agreeToFollowRebecFirstTime():void {
	clearOutput();
	if (flags[kFLAGS.TIMES_REFUSED_REBECCS_OFFER] == 0) {
		outputText("How could you refuse an invitation from such an alluring girl?  You eagerly agree to go to her village; everyone sets out at once, chatting with each other jovially, but your attention is squarely focused on Rebecc.  She seems impressed by the tales of your adventures and has nothing but praise for your endless bravery, delivered while clinging to your arm and pressing her body against yours.  Her sweet scent is invigorating, and a significant amount of blood flows toward your ");
		if (player.gender == 0) outputText("regretfully bare ");
		outputText("groin as you feel the contact of her tender curves against your body.  Taking advantage of the effect you seem to have on her, you start questioning her about her village, her people and how she was affected by demons.");
		outputText("\n\n\"<i>There, we've almost arrived at Owca, our village; you can see the first houses.  As for demons... well, you know, they are the reason we wanted you to follow us.  You see, a large group of them have been harassing us.  At first they were just scavenging for food and various supplies, but soon they started claiming... another kind of prize.  You know these creatures, you know what they do.  There have been many battles to protect our rightful clay and hard-earned food, but there were simply too many of them.  Besides, they often use some kind of... black magic in order to subdue their foes and turn them into obedient slaves.  ");
		//[if silly mode on]
		if (silly()) outputText("I-I don't think there's a single grown man or woman in our village that still has their anal virginity.");
		//[if silly mode off]
		else outputText("Th-they abused us.  They mistreated us.  They would gather in circles and... use us in every possible way.");
		outputText("</i>\"");
		//[if Corr < 20]
		if (player.cor < 20) {
			outputText("\n\nYou are shocked by this revelation. You wrap your arms around Rebecc's shoulders protectively, and tell her in a reassuring tone that ");
			//[[if silly mode on]
			if (silly()) outputText("she'll never have to worry about her asshole again.");
			//[if silly mode off] 
			else outputText("she will never be abused again.");
			outputText("  If there's anything that can be done to hold off these evil creatures, you will do it.");
		}
		//[else if corr and libido both > 60]
		else if (player.cor > 60 && player.lib > 60 && player.hasCock()) {
			//[if silly mode on and presence of penis]
			if (silly()) outputText("\n\nYou can't help but pop an enormous boner.  [EachCock] is pressing so hard against your [armor] that you're afraid that one or the other might break.  ");
			//end of local silly willy condition
			else outputText("\n\n");
			outputText("You are uncontrollably turned on by this revelation; your genitals actually hurt at your absurd level of arousal.  Just imagining groups of demons gathered around the helpless villagers, sometimes taking turns with each one and sometimes taking someone all at once, turns you on way more than it should.  You stupidly grin for a few seconds as your mind pictures vivid and lecherous scenes of collective ass-rape, but then you remember this is supposed to be bad news; you quickly recompose yourself and put on a false expression of worry.  Luckily she didn't notice the lust that temporarily filled your eyes; neither does she spot the massive tent growing in your " +player.armorName+ ".  You ask her if there's anything you can do to meet these demons and 'handle' them on your own.");
			//end of condition about PC's corruption
		}
		outputText("\n\n\"<i>Well, a man from our village decided to go meet these demons at their camp in order to negotiate with them.  They agreed to a deal.  As you may guess, it was a... special kind of deal.</i>\"");
		outputText("\n\nYou know what kind of deal should be expected from these wicked creatures, but you let her take her time explaining.");
		outputText("\n\n\"<i>At the end of every week, one of us must be chained and left at the demons' disposal for the full night.  It must be someone different every night.  Chosen people usually come back battered and sore, and they have dirty fluids and unthinkable mixtures leaking from every hole of their body.  It's a difficult thing to think about, but it's necessary for our community.  But then...</i>\"  She wavers for a moment, before looking back to you with a desperate plea in her eyes.  \"<i>You're a brave, courageous adventurer; you just said you were willing to handle these demons!  It would almost be a blessing to us if you could help - not that you have to, but... it seems like we're beyond saving.</i>\"  The girl looks despondent, but then changes her composure when she turns back to the village.  \"<i>I might be being selfish, but you'd have my eternal gratitude if you helped.</i>\"");
		//[if corr < 50 and int >= 50]
		if (player.cor < 50 && player.inte >= 50) {
			outputText("\n\nSo this is what it has come to.  Her playfulness, her enticing gestures, her seductive play... she had been planning it all along.  She must have put on the same act for many people before you.  You feel slightly angry at yourself for having been fooled that easily; you feel angrier at her because she tried to use you as a mere disposable victim to be toyed with and manipulated; but you feel angriest at these demons for forcing honest folks to resort to infamous practices and deceptive seduction so they can live their lives as usual.");
			outputText("\n\nBut on second thought, she's right.  You're the champion of your own village; you're supposed to be selfless and resolute.  You were sent to this cursed land to prevent further corruption; your own physical integrity does not matter when other people are at stake.  Giving in to her demands would be certainly a noble and difficult act, something your elders would be proud of.  Of course it would seem like you had fallen for her trick, but do you really care?  You ponder your choices, thinking deeply");
			if (player.lib > 50) outputText("... and considering what Rebecc meant by 'gratitude'");
			outputText(".  Maybe it wasn't all an act?");
		}
		//[if corr < 50 and int < 50]
		else if (player.cor < 50) {
			outputText("\n\nYour eyes widen in surprise when you understand what she's asking of you, but after all, why not?  You're the champion; you're supposed to be selfless and resolute.  You were sent to this cursed land to prevent further corruption; your own physical integrity does not matter when other people are at stake.  Giving in to her demands would be certainly a noble and difficult act, something your elders would be proud of.  Of course it would seem like you had fallen for her trick, but do you really care?  You consider your choices");
			if (player.lib > 50) outputText("... and considering what Rebecc meant by 'gratitude'");
			outputText(".  Maybe it wasn't all an act?");
		}
		//[if corr >= 50]
		else {
			outputText("\n\nSo this is what it has come to.  Her playfulness, her enticing gestures, her seductive acting... she had been planning it all along.  She was doing it all on purpose, teasing you and tricking you into accepting her offer.  She must have put on the same act for many people before you.  You feel slightly angry at yourself for having been fooled that easily; you feel angrier at her because she tried to use you as a mere disposable victim to be toyed with and manipulated.  Well, if it comes down to that, you could probably agree and either beat the demons to take their place, or help them 'renegotiate' with the villagers...");
			//[[lib>=50]
			if (player.lib >= 50) {
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
	if (flags[kFLAGS.TIMES_IN_DEMON_PIT] == 0) doYesNo(createCallBackFunction2(acceptRebeccsPlea,true, true),declineRebeccsPlea);
	else doYesNo(createCallBackFunction2(acceptRebeccsPlea,false, true),declineRebeccsPlea);
}
//Refuse plea (Z)
private function declineRebeccsPlea():void {
	clearOutput();
	outputText("You can't give in to her demand; you are a proud warrior fighting demons.  You were certainly not meant to serve as a scapegoat or sex-toy.  She sighs in disappointment.  \"<i>Well, I should have expected that.  I wasn't full of hope either.  No hard feelings.</i>\"  Everyone is looking at you with sad or apathetically hostile eyes, making you feel uncomfortable.  You quickly leave the village and return to your camp.");
	//[if more than 40 int, a warning after 4 consecutive refusals]
	//if (flags[kFLAGS.TIMES_REFUSED_REBECCS_OFFER] >= 3 && player.inte >= 40) outputText("\n\nThe villagers are growing impatient of your repeated refusals; you can hear them exchange hushed whispers as you depart.  Failing to grant their request again will probably anger them considerably.");
	//[Attitude is set to 50]
	if (flags[kFLAGS.OWCAS_ATTITUDE] > 5) flags[kFLAGS.OWCAS_ATTITUDE] -= 5;
	flags[kFLAGS.TIMES_REFUSED_REBECCS_OFFER]++;
	doNext(camp.returnToCampUseOneHour);
}
//Accept plea (Z)
private function acceptRebeccsPlea(firstTime:Boolean = false, sacrificed:Boolean = false):void {
	clearOutput();
	flags[kFLAGS.OWCAS_ATTITUDE] += 10;
	if (flags[kFLAGS.OWCAS_ATTITUDE] > 100) flags[kFLAGS.OWCAS_ATTITUDE] = 100;
	outputText("You tell the desperate girl that you're going to do as she asks.  As soon as you finish speaking, everyone cheers and applauds you, praising you as their savior.  Rebecc grabs hold of your shoulders and gives you a soft kiss on your lips; she whispers, \"<i>Thank you, champion.  We all owe you.  I promise that you will be rewarded for the heroic deed you're about to undertake.</i>\"");
	outputText("\n\nA group of the farmers then proceeds to lead you across the village to a strange circle-shaped pit.  It's about one meter deep and ten meters in diameter.  At the center of the pit stands a tall wooden pole, adorned with several dangling ropes and chains.  You grimace as you realize you will be tied up and bound to the crudely fashioned post in order to make sure you don't escape before the demons show up.");
	//if (player.armorName != "comfortable clothes") outputText("  The farmers almost eagerly help you out of your " +player.armorName+ ", supplying you with a set of shabby but comfortable peasant clothes.");
	//[[if corr >70 and have gender]
	if (player.cor > 70 && player.gender > 0) {
		outputText("\n\nYou lick your lips in anticipation, your ");
		if (player.hasVagina()) outputText(player.vaginaDescript(0));
		if (player.hasVagina() && player.hasCock()) outputText(" and ");
		if (player.hasCock()) outputText(player.multiCockDescriptLight());
		outputText(" already slickening with sexual juices; the sight of these restraints brings all kinds of perverted thoughts to your mind: dozens of ways to be used and deliciously abused like a sex-toy by wretched and well-endowed beings.");
	}
	//[else]
	else outputText("\n\nYou shrug and tell yourself it was to be expected; after all, they barely know you and must be afraid that you may flee at the last moment.  Maybe some previous victims had already done so, with disastrous consequences for the village folks.");
	//end of condition
	outputText("\n\nThis vivid thought only helps strengthen your determination and you resolutely march toward the pit and the tall pole at the center.  As you drop into it, you notice the ground is soft, wet and has slightly whitish stains here and there.  Your nose is immediately assaulted by a strong musk that you instantly recognize – the smell of semen.  The villagers, used as they must be to working on sullied land, seem unfazed by these details.  You decide it's wiser not to make any comment and let them chain you to the pole.  They silently work for a few minutes, being careful not to knot the ropes too tightly so they don't hurt you.  At last, they give you a few encouraging pats on your shoulder; some females give you chaste kisses on your head, others wish you good luck and give you a last thankful wave, and a few seconds later they're all gone. You're left alone and naked in a sex-scented pit, bound to a post, waiting for the arrival of lustful, soulless creatures.  The villagers have retained all of your equipment in the name of keeping it safe, assuring you that it'll be returned to you the next morning.");
	outputText("\n\nPutting your dread aside, you close your eyes and attempt to sleep, vowing to save your strength for the ordeal that awaits you tonight.");
	//Dusk transition text (Z)
	doNext(createCallBackFunction(intoTheDemonPit,true));
}
private function intoTheDemonPit(sacrifice:Boolean = true):void {
	clearOutput();
	//N is the number of hours left before night
	if (model.time.hours < 21) {
		var passed:int = 21 - model.time.hours;
		outputText("<b>" + Num2Text(passed) + " " + (passed > 1 ? "hours pass" : "hour passes") + "...</b>\n");
		model.time.hours = 21;
		statScreenRefresh();
	}
	outputText("You are awakened by a sudden cackling, and open your eyes; you are almost entirely surrounded by darkness, and the dim light provided by the menacing red moon only makes the landscape bleaker.");
	outputText("\n\nYou look around, puzzled.  Nothing seems to break the ever-present, nightly silence.  Then, as if to tease you, the cackling is heard again, this time behind you.  You turn around and eventually spot its origin: a crowd of silhouettes, all rushing in your direction, tittering and giggling like a bunch of naughty kids about to play a dirty trick.  As they get closer and closer to the pit, their colorful bodies and alien features are given a shining outline by the bloody moon; it seems that they are all full demons, sporting horns, claws, tails and wings.  Most of them are naked, shamelessly displaying gigantic erections or cavernous pussies as well as watermelon-sized, milk-dribbling tits.  Some of them are wearing leather straps that barely cover their taboo parts, as if to mock all notions of human prudishness.  You even spot an imp wearing a weird greenish vine like a belt; you stare at him for a few seconds, knowing something is out of place, then realize the belt is actually the imp's very flexible tentacle dick.");
	outputText("\n\nSoon, they are all gathered in the pit, surrounding you completely and eyeing you with gleeful lust; whatever plans these demons have in mind, they must be dirty.");
	outputText("\n\nA tall purple demoness walks up to you as you stand there");
	if (sacrifice) outputText(", tangled in your restraints");
	outputText(".  She leans down and coos, ");
	//[if first time]
	if (flags[kFLAGS.TIMES_IN_DEMON_PIT] == 0) outputText("\"<i>Awww, look at the poor little thing!  So this is what they gave us this time... Look at [him], everyone!  Do you know you'd be a cute pet?  People here call me Vapula, and I don't think you'll forget that name any time soon.</i>\"");
	//[else if Vapula Submissiveness >50]
	else if (flags[kFLAGS.VAPULA_SUBMISSIVENESS] > 50) outputText("\"<i>You again?  By Lethice, you must really enjoy it!  You love being a bitch for Vapula, don't you?  Yes you do!</i>\"");
	//[else]
	else outputText("\"<i>Fuck, you again?  Tell me it's so!  I've been looking forward to putting you in your place as my newest slut!</i>\"");
	//[(if sacrificed)
	if (sacrifice) {
		//[if str >= 80]
		if (player.str >= 80) {
			outputText("\n\nYou test the chains holding you to the pole; they're slack enough that you have room to flex and you could probably break them if you decided to fight...");
		}
		else if (player.spe >= 80) {
			outputText("\n\nYou test the chains holding you to the pole; they're slack enough that you could probably make use of your incredible dexterity to slip free...");
		}
		//[else]
		else outputText("\n\nThe chains binding you aren't very tight or of the finest craftsmanship, but they're sufficient to hold you more or less in place; though you can probably twist to avoid a few attacks, you won't be able to make any of your own if you decide to resist... at least, not physically.");
		outputText("  You're once again feeling regret over letting the villagers hold your equipment, but there's nothing for it now.");
	}
	if (flags[kFLAGS.CODEX_ENTRY_SUCCUBUS] <= 0) {
		flags[kFLAGS.CODEX_ENTRY_SUCCUBUS] = 1;
		outputText("\n\n<b>New codex entry unlocked: Succubus!</b>")
	}
	flags[kFLAGS.TIMES_IN_DEMON_PIT]++;
	flags[kFLAGS.DAYS_SINCE_LAST_DEMON_DEALINGS] = 0;
	if (sacrifice) simpleChoices("Fight",createCallBackFunction(fightZeDemons,true),"Submit",loseOrSubmitToVapula, "", null, "", null, "", null);
	else simpleChoices("Fight",createCallBackFunction(fightZeDemons,false),"Submit",loseOrSubmitToVapula, "", null, "", null, "", null);
}
//Submit/Fight
private function fightZeDemons(sacrifice:Boolean = true):void {
	clearOutput();
	//Fight leads to the Horde Fight
	//When acting as sacrifice, Item button is disabled; Fight, Run, and Phys Special buttons are disabled unless PC has str >= 80; Run is furthermore prevented entirely if PC is non-winged; outputs text: \"<i>You'd like to run, but you can't scale the walls of the pit with so many demonic hands pulling you down!</i>\"
	//PC's weapon is temporarily set to fists and armor to comfortable clothes during a Horde Fight if he triggered it in response to a sacrifice request, but not if triggered through volunteering to guard the pit later once the village is unlocked
	startCombat(new LustyDemons());
	if (sacrifice) {
		//Remove weapon
		player.createStatusEffect(StatusEffects.Disarmed, 0, 0, 0, 0);
		flags[kFLAGS.PLAYER_DISARMED_WEAPON_ID] = player.weapon.id;
		player.setWeapon(WeaponLib.FISTS);
		monster.createStatusEffect(StatusEffects.BowDisabled, 0, 0, 0, 0);
		if (player.str < 80 && player.spe < 80) {
			monster.createStatusEffect(StatusEffects.AttackDisabled, 0, 0, 0, 0);
			monster.createStatusEffect(StatusEffects.RunDisabled, 0, 0, 0, 0);
			monster.createStatusEffect(StatusEffects.PhysicalDisabled, 0, 0, 0, 0);
		}
		else {
			if (!player.canFly()) monster.createStatusEffect(StatusEffects.RunDisabled, 0, 0, 0, 0);
		}
	}
	playerMenu(); //Avoid showing the next button. Must call it here, after setting up all the statuses, so the first round combat menu is correct
}


	
//Loss scene/Submit (gangrape) (Z)
public function loseOrSubmitToVapula():void {
	clearOutput();
	outputText("Vapula taunts you as she circles around you.  \"<i>Look at the slutty pet!  Ain't you a slutty pet?  Yes, you are!  Don't pretend you're not hungry for some fat demon cock, I know you are.</i>\"  As she speaks, the crowd gathers closer.  A few creatures show some temerity, giving you pinches and gropes as they near.  The cock-belted imp unties his tentacle; the horror wriggles and squirms as it drops to the ground and slithers toward you.  The tip of the absurdly long pecker inspects your body, pressing itself against your flesh, massaging you in the most sensual places, wetting you with sap-like pre-cum and teasingly grinding itself against your mouth, and then your " + player.assholeDescript());
	if (player.hasVagina()) outputText(", followed by your "+ player.vaginaDescript(0));
	if (player.hasCock()) outputText(", before finally wrapping around your " + player.cockDescript(0) + " and stroking it; the friction uncontrollably arouses you, and you find yourself reaching full erectness");
	outputText(".  As more and more hands start playing with your flesh, the succubus grabs your head and gives you a fierce kiss, literally crushing your lips under hers; her mouth tastes like wine and her tongue is driving you over the edge as it intertwines with yours.  Her strong natural scent makes you dizzy and you gradually lose control over your body.  \"<i>Don't worry, darling, it'll be all right...</i>\"");
	outputText("\n\nSoon you find yourself completely overwhelmed by hot demon hands and dicks touching every part of your body.  In no time at all two imps bend you over and forcefully ram your " + player.assholeDescript() + " with their mammoth peckers.");
	//[ass stretching check]
	player.buttChange(60,true,true,false);
	outputText("  The double penetration is brutal, unexpected and painful.  Your insides are protesting vigorously against this rough treatment, even though you feel a tingle of pleasure gently tickling your colon at every thrust.  ");
	//[(no Buttslut)
	if (player.findPerk(PerkLib.Buttslut) < 0) outputText("No!  You aren't supposed to enjoy it...  ");
	outputText("You try to cry out but as soon as your mouth opens it is filled with another dick, then a second one.  A third tries to push its way between the first two, stretching your cheeks and making you drool.  Seeing that the monstrous dong won't fit in your already double-stuffed mouth, its owner groans in frustration and proceeds to slap your cheek with it.  He is soon joined by other demons who find the idea very entertaining.");
	outputText("\n\nIt's a matter of minutes before a dozen hungry omnibuses and incubi are repeatedly cock-slapping your entire body, hitting every part of you with their heavy meat, grinding their rods against every fold and curve of your flesh and staining it with seminal fluids.  Your poor " + player.buttDescript() + ", already abused by two giant pricks thrusting back and forth at an unnatural pace, is now the prey of numerous hands and full, erect dicks slapping it in every possible way, smearing it with pre-cum and sweat as they run across your tender skin.  You can't see anything: your eyesight has been blocked by a never-ending row of wriggling cocks.  Nor can you hear anything over the sound of a full horde of libidinous demons panting and moaning as they abuse their fuck-toy in an overwhelming orgy of pleasure; besides, a pair of imps are rubbing the tips of their dongs against your ears, as if they wanted to fill them with seed.");
	outputText("\n\nYou can't talk, muted as you are by a pair of fat red peckers stuffing your mouth and bumping against your throat as you unwillingly suck them off.  Your jaw hurts, your itching insides are driving you mad; your whole body is being bruised from the cock-slaps, your palms are forced to rub four shafts at the same time, and even as you pump, your fingers are occasionally grabbed and stuffed into wet fuck-holes, making a few succubi moan.  A tentacle dick brushes against you, then wraps around your limbs, slithering against your skin and leaving behind a trail of pre-cum on your torso and belly.");
	if (player.hasCock()) outputText("  It wraps around [eachCock] for a while, jerking it for a bit and rubbing its tip against yours.");
	//[if antennae]
	if (player.antennae > ANTENNAE_NONE) outputText("  Your antennae are being harshly pulled and twisted; some imps, in a crazy show of libertinism, start inserting your sensitive peduncles down their bloated urethrae. The intimate friction and the sudden jolts when the internal walls slather your appendages in slick, hot pre-cum are driving you mad with irregular shots of unbearable pleasure.");
	//[if horns]
	if (player.horns > 0) outputText("  You feel your horns being used as leverage to slap your head with even more rock-hard dick.  The impacts stun you until your whole forehead feels numb and coated with a mixture of ballsweat and pre-cum.");
	//[if vagina
	if (player.hasVagina()) {
		outputText("\n\nYou suddenly feel a sharp sensation: your womanhood is finally being penetrated.");
		player.cuntChange(60,true,true,false);
		outputText("  A dick found a way into your " + player.vaginaDescript(0) + " and is pushing further inside.  Wait, what's this?  A second, and then a third!  There's no way these titanic columns of flesh will... this is too much... you fear you will be torn in half, but at the last moment, you feel someone spilling the content of a flask over your nether-lips.  As if you had lost control of your " + player.vaginaDescript(0) + ", it automatically starts leaking girl-cum in prodigious amounts, and you let out a stifled moan as a delicious shiver runs teasingly across your body.  Your fuck-hole widens under the corrupting effect of the weird mixture you were administered.  ");
		//[set vagstretch up a few levels]
		if (player.findStatusEffect(StatusEffects.BonusVCapacity) < 0) player.createStatusEffect(StatusEffects.BonusVCapacity,0,0,0,0);
		if (player.statusEffectv1(StatusEffects.BonusVCapacity) < 200) player.addStatusValue(StatusEffects.BonusVCapacity, 1, 15);
		outputText("As soon as new space is created, it is immediately filled by a pussy-hungry cock.  The three cocks slide effortlessly inside you and start thrusting energetically, vying in intensity and ferocity with the peckers ramming your " + player.assholeDescript() + ".  The penetration of both holes is almost too much too handle, but you finally get used to it as your own anal and vaginal muscles try their best to milk as much spunk as possible from these cum-tubes.  Even though you are being violated in every hole, the raw and powerful sensation is quite pleasurable; it feels so right to be used this way, so full of demon wang.  You don't have to focus on anything, just to enjoy the sheer amazing feeling of being pounded by many pistons at once.  You squirt over and over again as the dicks and the fluid force you into a series of wild female orgasms.");
		//[crank up vaginal wetness one level, why not?]
		if (player.wetness() < 5) player.vaginas[0].vaginalWetness++;
	}
	//[if cocks]
	if (player.hasCock()) {
		outputText("\n\nA soft brush against your " + player.cockDescript(0) + " warns you that your crotch is going to get some more love.  At least four hands are caressing it, helping you rise and thicken until it can't grow anymore.  After a while of playful stroking, the hands are suddenly gone, only to be replaced by a fluid-gushing cunt.  It impales itself on your " + player.cockDescript(0) + " at full force, driving a very whorish and high-pitched cry from its owner.");
		//[if more than 1 and less than 4 cocks]
		if (player.cockTotal() > 1) outputText("  She is soon joined by other horny girls, too eager to wait for a piece of your crotch to play with.  They all comfortably position themselves, positioning their pussy or anus atop each of your cocks before riding you like there's no tomorrow.");
		//[if 4 to 7 cocks]
		if (player.cockTotal() >= 4) outputText("  Nevertheless, they aren't satisfied with a single insertion and most grab hold of one of your extra cocks before forcefully stuffing it in their other hole, howling and thrashing all the more as they are penetrated a second time.");
		//[if 7 cocks or more]
		if (player.cockTotal() >= 7) {
			outputText("  Sadly, surrounded as you are, no one will be able to find extra room to ride your remaining cocks; fortunately, you feel warm, long demonic tongues being pressed against your " + player.cockDescript(6));
			if (player.cockTotal() > 8) outputText(" as well as your remaining pricks");
			outputText(".  The tongues expertly lick your meat and wrap themselves around it, and questing lips give it multiple kisses before one pair suddenly loses patience and deepthroats you with voracity; the tightness of these lips makes them feel like a very efficient cock-ring.  However, it is hard to focus on the sweet warmth provided by these avid mouths when all your other cocks are being clamped by powerful, inhuman vaginal muscles.");
		}
		outputText("\n\nBetween every thrust, you feel hands working and polishing your shaft");
		if (player.cockTotal() > 1) outputText("s");
		outputText(", as if every inch had to be taken care of at every instant.  As you slide back into the pussy, the hands return to crawling over your body, caressing your groin and staining your belly with pre-cum - yours and others.");
		outputText("\n\nYou are ridden for a while, the hell-girls thrashing wildly and yelling in pure ecstasy as they reach their climax.  They release so many powerful orgasms you stop keeping track of them.");
	}
	//[if lactating breasts]
	if (player.lactationQ() > 0) outputText("\n\nLost in your feverish state of arousal, you feel your nipples harden and a thin trickle of milk comes out.  A couple of demons spot this new source of fluids and rush to your " + player.allBreastsDescript() + ", wolfishly suckling them.  Their dexterous tongues keep teasing your nipples, stimulating you further as they drink your essence.  Your milk-udders are being roughly groped and licked by these careless creatures, oblivious of everything but your mounds.");
	outputText("\n\nEventually, your insane mix of violation-induced pleasure and pain proves too much for your wrecked body and your whole consciousness winds up as you brace yourself for your incoming climax.  Your eventual spasm is so strong that some of the demons lose the grip they have on you.  Your hands twitch, unintentionally squeezing the cocks pressing against them.  Your head bumps against a wall of dicks, and your nose lodges itself in a miraculously free pussy that was waiting its turn near your mouth.  You even manage to liberate your mouth from that duo of monster-sized members; as you gasp for some air, you can't help but let out a shrilling cry of pleasure.  You scream aimlessly; all the violations you've endured, every sensation inflicted upon your body is expressed in that helpless shriek.  Of course, you can't hear yourself screaming because of all the cum that has been unloaded onto your ears, but you don't care.  Your body is becoming a nexus of pleasure in this show of debauchery as unholy liquids are pumped in and out of it.  As you scream, your groin clenches and you climax with unequaled intensity.");
	//[if cocks]
	if (player.hasCock()) {
		outputText("  " + player.SMultiCockDesc() + " pulsates and throbs");
		//[[if balls]
		if (player.balls > 0) outputText(", and your balls swell and boil");
		outputText("; a gigantic spooge-flow pushes its way up your urethra and spurts outside in the waiting love-tunnels");
		if (player.cockTotal() > 7) outputText(" and mouths");
		outputText(".  The violent cumshot almost instantly produces a shiver of orgasm once again and vaginal walls contract furiously, determined to absorb as much of your baby-batter as possible.");
		//[if cum production is massive]
		if (player.cumQ() > 1500) outputText("  The effort appears to be vain, as the absurdly high volume you've ejected is enough to completely pack every hole; the remaining jism spills on the tainted ground, soaking it further.");
	}
	outputText("\n\nAfter what seems like hours of forceful penetration, the gigantic members inside you release a milky torrent of corrupted seed, completely packing your colon through your " + player.assholeDescript());
	if (player.hasVagina()) outputText(" and filling your womb to its maximum capacity");
	outputText(".  The remaining cum spurts outside and dribbles onto your [legs].  Your asshole clenches, squeezing the dongs inside you and milking their very last drops of spunk.");
	//[if vagina]
	if (player.hasVagina()) outputText("\n\nYour own " + player.vaginaDescript(0) + " clenches too, doing its best to waste as little semen as possible.  Your muscles quiver as they feel the incoming last release.  Then, in climax, you squirt your own girl-cum, splattering the demon dicks with your juice.");
	//[if lactating breasts]
	if (player.lactationQ() > 0) outputText("\n\nThe combined efforts of a dozen demons proves too much for your poor " + player.chestDesc() + " and your nipples let out a white creamy flood, which is immediately gobbled by thirsty imps.  ");
	else outputText("\n\n");
	outputText("Everywhere around you, people keep cumming and shooting ropes of jism.  In no time your entire body is drenched with spooge.  Your eyes and ears are completely covered with sticky goo, preventing you from hearing and seeing.  Still, you can feel penises being stuffed into your mouth again as they unload their unholy swill.  The taste is strong, hot, and salty, but not unpleasant.  You swallow until your belly swells, but you don't care; temporarily reduced to the instincts of breeding stock, you want more spunk and you suck it up as if your life depended on it.");
	outputText("\n\nYou keep oozing out fluids until you reach your own body's capacity.  When the flow of various juices starts to ebb, you relax, completely exhausted.  You simply lie there in a bed of cocks and naked flesh, abandoning all hope of struggling against the demons' will.  Of course, they aren't done yet.  A few seconds later - the time needed for everyone to switch positions - and they're at it again.  You are touched and caressed, filled and used again, and again, and again.  You black out.");
	//[Vapula Submissiveness raises by 10. If it reaches 100 or more, go on to the Vapula Slave Bad End. Otherwise Wake up scene. Additionally, if it is raised to 90 or more this way, display warning:]
	flags[kFLAGS.VAPULA_SUBMISSIVENESS] += 10;
	if (flags[kFLAGS.VAPULA_SUBMISSIVENESS] >= 90 && flags[kFLAGS.VAPULA_SUBMISSIVENESS] < 100) outputText("\n\n<b>You're starting to get dangerously used to this kind of treatment.  Your holes are being stretched to accommodate monstrous sizes and don't hurt that much anymore.  You feel like you could stand this as long as you need to with ease... maybe it's time to stop volunteering?</b>");
	if (flags[kFLAGS.VAPULA_SUBMISSIVENESS] >= 100) doNext(slaveToVapulaBadEnd);
	else if (player.findStatusEffect(StatusEffects.LostVillagerSpecial) >= 0) doNext(morningAfterRape);
	else doNext(wakeUpAfterDemonGangBangs);//WAKE UP
	player.orgasm();
	dynStats("lib", 1, "sen", 2, "cor", 3);
	flags[kFLAGS.REBECCS_LAST_PLEA] = 0;
}

private function wakeUpAfterDemonGangBangs():void {
	clearOutput();
	model.time.hours = 7;
	model.time.days++;
	outputText("When you wake up, you are alone, and your restraints are broken.  You are sloshing in a pool of stinky juices; your mouth and ears are still full of it.  Your whole body is covered with a thin white layer that must certainly be dried spooge.  Underneath, you're nothing but bruises and every movement seems to hurt.  A few meters away, outside the pit, you notice your items and your gear.  The village itself appears to be empty... your best assumption is that the residents are hiding, either from shame at having sacrificed you or from awkwardness at the prospect of talking to a sloshing, crusty cumdumpster.  Wearily, you head back to your camp.");
	//+med-high corruption, - libido, - toughness, - strength, +20 fatigue, high imp preg chance, slimefeed
	player.changeFatigue(20);
	player.slimeFeed();
	dynStats("str", -2,"tou", -2, "spe", -1, "int", -1, "lib", 1, "sen", 1, "lus=", 100, "cor", 3);
	if (getGame().inCombat)
		combat.cleanupAfterCombat();
	else doNext(camp.returnToCampUseOneHour);
	//PC is redirected to camp, next morning. No nightly camp scenes or dreams.
}
	
//Victory (Z)
public function defeetVapulasHorde():void {
	clearOutput();
	flags[kFLAGS.REBECCS_LAST_PLEA] = 0;
	if (flags[kFLAGS.VAPULA_SUBMISSIVENESS] <= 0) {
		subdueVapula();
		return;
	}
	//Sacrificed and bound
	if (monster.findStatusEffect(StatusEffects.AttackDisabled) >= 0) {
	   if (monster.HP < 1) outputText("You grin wickedly as the last demons fall, defeated.  Some of the errant blows have broken and mangled the links of your chains, and you find you can get free with a bit of additional effort.");
		//[if won by Lust]
		else outputText("You grin wickedly as the demons give up the fight, too turned on to care about you.  One even begins unfastening your bindings, hopeful desperation glinting in her eyes as she attempts to entice you with her long, thick nipples and enormous, dripping gash.");
	}
	//Not
	else {
		if (monster.HP < 1) outputText("You grin wickedly as the last demons fall, defeated.");
		//[if won by Lust]
		else outputText("You grin wickedly as the demons give up the fight, too turned on to care about you.  One even has hopeful desperation glinting in her eyes as she attempts to entice you with her long, thick nipples and enormous, dripping gash.");
	}
	//[(requires genitals and and corr >60)
	if ((player.cor > (60 - player.corruptionTolerance()) || flags[kFLAGS.MEANINGLESS_CORRUPTION] >= 1) && player.gender > 0) {
		outputText("\n\nDo you take advantage of them?");
		doYesNo(rapeZeVapula,noVapulaSex);
	}
	else {
		outputText("\n\nThough the display as they explore each other is somewhat arousing, you can't really get into it as you are, and simply use your new-found freedom to climb out of the hole.  It's too dark to return to the village now, so you head back to camp.");
		flags[kFLAGS.VAPULA_SUBMISSIVENESS] -= 5;
		combat.cleanupAfterCombat();
	}
	
}
private function noVapulaSex():void {
	clearOutput();
	flags[kFLAGS.VAPULA_SUBMISSIVENESS] -= 5;
	combat.cleanupAfterCombat();
}
//Yes/
//[Yes: submissiveness is lowered by 10. No or auto-reject: submissiveness is lowered by 5.]
private function rapeZeVapula():void {
	flags[kFLAGS.VAPULA_SUBMISSIVENESS] -= 10;
	//Victory rape with penis [Anal Orgy and Bukkake] (NTR Vapula) (Z)
	if (player.hasCock()) {
		clearOutput();
		outputText("The demon horde struggles before you.  With a disdainful smile, you fully expose your genitals for everyone to see.  ");
		//[if cocks]
		if (player.hasCock()) outputText("\n\nYou gently stroke your " + player.cockDescript(0) + ", bringing it to full erectness.  ");
		//[if vagina]
		if (player.hasVagina()) outputText("You stick a finger in your own " + player.vaginaDescript() + " in order to lubricate it.  ");
		outputText("The defeated horde watches you touch yourself with avid, almost desperate eyes.  You keep teasing yourself, saving your lust for the torrid storm of rape you're about to unleash on the poor creatures who dared attack you.  You walk among the battered bodies, looking for the prey that will best suit you; then you find her.  Vapula is lying here, her purple skin masking ");
		if (monster.HP < 1) outputText("the many bruises she's received");
		else outputText("the constant flushing due to intense arousal");
		outputText(".  You harshly grab her hand and grunt, \"<i>On your feet, cunt.</i>\"  She is too stunned to protest and weakly stands up, her leather straps torn to completely reveal her voluptuous body.  You feel the sudden urge to take her right now and fuck her like a ");
		if (player.hasVagina()) outputText("bitch in heat");
		else outputText("centaur in rut, abusing and filling her teasing cunt and ass with every protuberance you have");
		outputText(".  However, you have better plans for her.");
		
		outputText("\n\nYou yank on her arm and lead her to the pole you were previously attached to.  Using the lashings and her own straps, you chain her in such a way that she's forced to stand up and look at you, then tie up her arms and legs to forbid escape.  When you're done, she is facing you, a glint of defiance in her eyes.  Her tender H-cups tits stand firmly as if to provoke you, and her woefully exposed nether-lips seem to be only waiting for you.  Gods, this succubus is clearly begging to be taken!");
		outputText("\n\nFor a moment as she tries her best to be as proud as possible in such an uncomfortable situation; you savor her helplessness, then decide to tease her a bit; first, a fiery kiss, probing the inside of her mouth with your tongue.  Next, you toy with her nipples, slap her plush ass and cup her tits, enjoying the supple texture of her tender flesh.  You keep molesting her body until she can't help but moan like a whore under your dexterous ministrations.  Her vagina is now freely spilling its juice; she keeps squirming against her restraints, uncontrollably shaken by her arousal.");
		outputText("\n\n\"<i>What are you waiting for?</i>\" she moans.  \"<i>Fuck me already, you dirty bastard.  Go ahead, stuff me.  Why don't you get down to business?  Are you afraid that you might last only a minute?  What are you, a poor little sissy with no stamina?  You innocent little " + player.mf("manlet","maiden") + ", I will–</i>\"");
		outputText("\n\nSLAP!  The back of your hand impacts her cheek, muting her for a moment and opening the way for your own comment.  \"<i>Shut up, whore.  I'm the one deciding who fucks who here.  You want sex?  Don't worry, you'll see plenty soon.</i>\"");
		outputText("\n\nWith lazy nonchalance you grab hold of another demon crawling at your feet, another succubus; although not so tall or big-breasted as Vapula, her provocative curves are a delight to your eyes.  You bend her over and, without ceremony, start working her tight pucker, filling her insides with your " + player.cockDescript(0) + ".");
		if (player.cockTotal() > 1) outputText("  Seeing that she has extra room left, you grab another of your dongs and put it at the entrance of her dripping cunt before forcing it in.");
		outputText("\n\nYou keep thrusting back and forth, treating the worthless horned-girl like a disposable cock-sleeve. As you pump in and out of her, you look at Vapula, warning her.  \"<i>Don't turn your head.  If you ever look away or close your eyes, you will regret it.</i>\"  Overwhelmed by your dominance and subdued by the defeat, Vapula can only nod.  You work the succubus's lush hole");
		if (player.cockTotal() > 1) outputText("s");
		outputText(" in front of the once-powerful dominatrix, grunting and panting as you accelerate the pace, until you finally reach your climax and release rope after rope of jism in your fuck-toy, completely packing her backdoor");
		if (player.cockTotal() > 1) outputText(" and her love-tunnel");
		outputText(".");
		//[if massive cum production]
		if (player.cumQ() > 1000) outputText("  Some of it spurts by little jets outside of her, even as she instinctively contracts her muscles to keep as much spooge as possible and her belly accomodates by bloating out absurdly.");
		outputText("  Needless to say, watching this rough ");
		if (player.cockTotal() == 1) outputText("anal");
		else outputText("double-penetration");
		outputText(" session has brought Vapula to a new level of arousal; she is struggling to free her arms and finger herself, but her tight restraints only allow her to wriggle uncomfortably.  Her pussy is gushing of its own and she whimpers from time to time, unable to control her lust.");
		outputText("\n\nYou throw away your expendable");
		if (player.cumQ() > 1000) outputText(", expandable");
		outputText(" cumdumpster and grab another slut.  This time you feel like you could use a blowjob to clean off the demonic sweat and slime from your cock; you forcefully open her jaw and shove your " + player.cockDescript(0) + " down her throat without any care.  The sudden influx of dickflesh blocking her air-flow makes her choke and cough, but a withdrawal and a good cock-slap reminds her of her place.  \"<i>You fucking bitch!  You goddamn worthless slut!  What good are you if you can't even give proper head?  Lick, you whore!  I want your tongue all over my crotch!  You can breathe when you've properly moistened my ");
		if (player.balls > 0) outputText("balls");
		else outputText(player.skin());
		outputText("!</i>\"  The poor demoness, cheek stained with semen, mutters an apology and proceeds to lick your " + player.cockDescript(0) + ", suckling the tip, ");
		if (player.balls > 0) outputText("fondling your " + player.ballsDescriptLight() + ", ");
		//[if multicocks] 
		if (player.cockTotal() > 1) outputText("alternatively deepthroating or jerking every cock of yours, ");
		outputText("warming up your dickflesh with her demonic tongue.  You enjoy her ministrations while staring Vapula in the eyes; she has trouble looking back at you as her body trembles and her eyes widen at your sheer display of depravity.  Your semen-dribbling shaft");
		if (player.cockTotal() > 1) outputText("s harden and thicken ");
		else outputText(" hardens and thickens ");
		outputText("again as the demoness sucks you off; Vapula can't help but take a quick glance at it, but you pretend not to notice.  After all, she's only teasing herself for you.");
		outputText("\n\n\"<i>Please... take me,</i>\" she whimpers.  \"<i>I don't care if I only get your leftovers.  Take me in any way you like.  I'll give you head, I'll give you my ass, anything.  Just fuck me!  My pussy is so horny it hurts!</i>\"");
		outputText("\n\n\"<i>Piss off, bitch.</i>\"");
		outputText("\n\nYou seize your fuck-toy by the waist and, turning her, gratuitously ram her asshole, her face right next to Vapula's pussy and staring at it with timid yet longing eyes.  She cries in pleasure and darts her tongue out; your toy almost manages to take a lick before you impale her all the way back on your " + player.cockDescript(0) + ".  After a few more mad thrusts, you feel another wave of seed flooding your urethra and spurting inside the slut's colon.  But this time, you pull out your cream-spraying pecker");
		if (player.cockTotal() > 1) outputText("s");
		outputText(" and aim at Vapula, splattering her body with your spunk.  Words cannot describe the sheer triumph you feel.  You burst into laughter as you drench that unworthy bitch with your seed.");
		outputText("\n\nGods, this is only the beginning.  Your next target is an unconscious imp with a monstrously thick pecker.  You lift him by his arms and jam his little pucker on your " + player.cockDescript(0) + ", making sure his own cock points toward Vapula.  The sudden anal penetration wakes him up and makes his dick, already half-mast from his perverted imp dreams, instantly rock hard.  You begin stroking his dick with enthusiasm as you violate his insides, your own cum serving as lube for the rough anal penetration.  The tight confines of the little red creature as well as your furious handjob prove too much for both of you and in no time you are both ejaculating in chorus.  Milky torrents burst from his mammoth member, further soaking the horny ex-dominatrix.");
		outputText("\n\nBut you're not satiated yet.  You grab another demon, fuck it rough and fast; when you know you're about to reach another orgasm, you pull out before cumming what your body can manage on Vapula's body.  You fuck another creature this way.  And another, and another...  When whatever you're fucking happens to have a cock, you ruthlessly rub it until it squirts everything it has on the tied succubus.  ");
		if (player.cockTotal() > 1) outputText("In an unholy sex-frenzy, you want more; you start grabbing creatures by groups and alternatively pump in and out of their asses with your " + player.cockDescript(0) + ", always hungry for more anal.");
		outputText("\n\nVapula is now entirely covered in a thick white liquid blanket.  The contact of all this hot seed against her untouched skin is driving her crazy; after some futile squirming in a desperate attempt to quench her burning pussy, she is now openly sobbing in frustration.");
		outputText("\n\n\"<i>You're... you violate my pets, yet you won't deign to touch me.  Why?  D-don't you like my body?  Don't you like my cunt?  Look, it's aching for a cock like yours.  It needs you.  I need your meat inside of me, please fuck me fuck me fuck me fuckmefuckme... <b>why won't you fuck me?  Please, I need to cum! Please!</b></i>\"");
		outputText("\n\nHa!  Without a word, you keep thrusting your " + player.cockDescript(0) + " inside your current hot hole while staring at her.  You resolutely ignore her, determined to let her see you fuck the entirety of her horde.  The various demons in your grasp appear resigned to be used as mere fuck-toys for your sole enjoyment – and their mistress' torment.  Most of them barely struggle as you ferociously stretch their interior; instead, they moan like the bunch of bitches they truly are, letting their mistress know that a dominant stud is giving them more pleasure than she ever did.");
		outputText("\n\nAt last, you reach the limit of your prodigious stamina.  When you're done pounding the last untouched hole in the pit, when your " + player.cockDescript(0) + " is done squirting its ultimate drop of goo over the wanton succubus, you relax and drop the fuck-toy you were using.  Your " + player.cockDescript(0) + " is finally softening and you have no further use of any broken toy in the pit.  All but one...");
		outputText("\n\nWhen you walk up to Vapula, she is barely recognizable. Her will is utterly broken and she seems considerably mollified.  Your repeated denials made her mind collapse; she's but an empty shell driven crazy by her burning unsatisfied lust.  With a content smirk, you lean down and give her a tender kiss, enjoying the taste of secondhand sexual juices coating her lips.  You whisper to her, \"<i>Good night, beauty.</i>\"  She doesn't seem to hear your taunt.");
		outputText("\n\nA few meters away, outside the pit, you notice your items and your gear.  The village appears to be deserted.  Considering these demons will have a hard time threatening anyone with white goo oozing out of their absurdly stretched holes, you let them rest, wallowing in a pool of mixed spunk.  You pick up your belongings and head back to camp.");
		if (silly()) outputText("  As you look back, you snicker, \"<i>Ass for ass, assholes.</i>\"");
		//+med-high corruption, + strength/cons, -10 libido
		player.orgasm();
		dynStats("str", 1,"tou", 1, "lib", -4, "cor", 4);
	}
	//Victory rape using vagina/anus [Take Dicks in All Holes](Z)
	else {
		clearOutput();
		outputText("The demon horde struggles before you.  With a disdainful smile, you fully expose your genitals for everyone to see.  ");
		//[if cocks]
		if (player.hasCock()) outputText("\n\nYou gently stroke your " + player.cockDescript(0) + ", bringing it to full erectness.  ");
		//[if vagina]
		if (player.hasVagina()) outputText("You stick a finger in your own " + player.vaginaDescript() + " in order to lubricate it.  ");
		outputText("The defeated horde watches you touch yourself with avid, almost desperate eyes.  You keep teasing yourself, saving your lust for the torrid storm of rape you're about to unleash on the poor creatures who dared attack you.  You walk among the battered bodies, looking for the prey that will best suit you; then you find her.  Vapula is lying here, her purple skin masking ");
		if (monster.HP < 1) outputText("the many bruises she's received");
		else outputText("the constant flushing due to intense arousal");
		outputText(".  You harshly grab her hand and grunt, \"<i>On your feet, cunt.</i>\"  She is too stunned to protest and weakly stands up, her leather straps torn to completely reveal her voluptuous body.  You feel the sudden urge to take her right now and fuck her like a ");
		if (player.hasVagina()) outputText("bitch in heat");
		else outputText("centaur in rut, abusing and filling her teasing cunt and ass with every protuberance you have");
		outputText(".  However, you have better plans for her.");
		
		outputText("\n\nYou yank on her arm and lead her to the pole you were previously attached to.  Using the lashings and her own straps, you chain her in such a way that she's forced to stand up and look at you, then tie up her arms and legs to forbid escape.  When you're done, she is facing you, a glint of defiance in her eyes.  Her tender H-cups tits stand firmly as if to provoke you, and her woefully exposed nether-lips seem to be only waiting for you.  Gods, this succubus is clearly begging to be taken!");
		outputText("\n\nFor a moment as she tries her best to be as proud as possible in such an uncomfortable situation; you savor her helplessness, then decide to tease her a bit; first, a fiery kiss, probing the inside of her mouth with your tongue.  Next, you toy with her nipples, slap her plush ass and cup her tits, enjoying the supple texture of her tender flesh.  You keep molesting her body until she can't help but moan like a whore under your dexterous ministrations.  Her vagina is now freely spilling its juice; she keeps squirming against her restraints, uncontrollably shaken by her arousal. The rest of the defeated horde watch, barely daring to breathe.");
		outputText("\n\n\"<i>What are you waiting for?</i>\" Vapula snarls.  \"<i>Use me already, you filthy bitch.  Shove your pussy into my face, let me lick your nasty juices, rub it all over me if that's the best you can do.  You haven't thought the logistics of this through, have you, cunt?  Or maybe you're too afraid.   Maybe you just need some cock up you, to remind you who-\"</i>");
		outputText("\n\nSLAP!  The back of your hand hits her across her face, muting her for the moment you need to lay down the rules.  \"<i>Shut up, whore.  I'm the one deciding who fucks who here.  And what an interesting idea you've given me.  Let's find out who wants what, shall we?</i>\"");
		outputText("\n\nWith lazy nonchalance you grab hold of another demon crawling at your feet, an incubus; shorter and younger than Vapula, his tight, pert body is a delight to your eyes.  Without ceremony you shove him to the ground and grind your " + player.vaginaDescript() + " into his crotch.  He looks at you, semi-comatose and bewildered, as you get a rise out of his dick, which hardens against your damp strokes.  You pin him down as you sink onto his red length, sighing as you rapidly engulf him, then begin to ride him ruthlessly.  ");
		player.cuntChange(40,true,true,false);
		if (player.vaginalCapacity() > 80) outputText("His cock is lost in your vast cunt and you work him as hard as you can to feel him against your walls, his body convulsing and dazed eyes rolling against the wet, savage rape.  ");
		outputText("You keep thrusting back and forth, treating the worthless horned boy like a disposable dildo.  As you pump him, you look at Vapula, warning her, \"<i>Don't turn your head.  If you ever look away or close your eyes you will regret it.</i>\" Overwhelmed by your dominance and subdued by the defeat, Vapula can only nod.");
		outputText("\n\nYou keep working the incubus's hot cock in front of the once-powerful dominatrix, panting as you accelerate the pace until you finally reach your climax, clenching your thighs tightly to his fit body as your " + player.vaginaDescript() + " clenches and spasms.  ");
		//[if squirter] 
		if (player.wetness() >= 5) outputText("The sound of spattering fluid fills the air as your cunt spurts its juices around the incubus's cock, coating him in your fragrant slime.  ");
		outputText("Against your relentless milking pressure he stands no chance and he moans raggedly as he cums in tandem, still incapable of moving his body as your mixed juices dribble down him.");
		outputText("\n\nNeedless to say, watching this rough session has brought Vapula to a new level of arousal; she is struggling to free her arms and finger herself, but her tight restraints only allow her to wriggle uncomfortably.  Her pussy is gushing of its own accord and she whimpers from time to time, unable to control her lust.");
		outputText("\n\nYou throw your expendable cock toy to one side and grab another slut, this time a succubus.  Your semen-dribbling cunt is now in need of a cleaning, and without any ado you sit yourself straight down onto her face, banging the back of her head against the ground.  She whines into your " + player.vaginaDescript() + ", to which you respond by pulling her hair.  \"<i>You fucking bitch!  You worthless slut!  What good are you if you can't even munch rug properly?  Lick, you whore!  I want your tongue to clean up what your useless fuckhead of a friend couldn't keep to himself.</i>\"  The poor demoness mutters an apology and proceeds to lap up the juices drooling out of your hole, licking your labia and mons clean of what the incubus left, darting her wet muscle across your " + player.clitDescript() + " before reaching into your vagina, carefully teasing out and drinking every drop of jizz she can find, making your own juices run afresh.  You enjoy her ministrations while staring Vapula in the eyes; she has trouble looking back at you as her body trembles and her eyes widen at your sheer display of depravity.  Your " + player.nippleDescript(0) + "s harden");
		if (player.biggestTitSize() >= 2) outputText(" and your " + player.breastDescript(0) + " bounce gently");
		outputText(" as you grind your snatch into the succubus's face; Vapula can't help but take a quick glance at your oozing, slippery cunt, but you pretend not to notice.  After all, she's only teasing herself for you.");
		outputText("\n\n\"<i>Please... take me,</i>\" the tied demon whines.  \"<i>I don't care if I only get your leftovers.  Take me in any way you like.  I'll lick your cunt, I'll scissor you, I'll magic you a strap-on, anything.  Just fuck me; my pussy is so horny it hurts!</i>\"");
		outputText("\n\n\"<i>Piss off, bitch.</i>\"");
		outputText("\n\nYou feel another high coming as you thrust harder and harder into the succubus's mouth; her eyes look timidly at an upside down Vapula as you ride her slippery tongue to another clenching climax.  Rather than sit down for it this time you raise yourself up and stare gloatingly at the dominatrix as a small torrent of semen-mingled girlcum gushes out of you and spatters all over the tied succubus.  The demon is so far past it she drinks and chokes over what you give her.  What is in Vapula's eyes as she watches this is something between total horror and raging thirst, and it fills you with incredible triumph.");
		outputText("\n\nGods, this is only the beginning.  You sashay into a beaten huddle of incubi and imps.  One of the more aware ones even tries to crawl away at your approach; you put an immediate stop to this by grabbing his bulging quartet of balls.  Holding him entirely at your mercy this way, you use your other hand to rub his monstrously thick pecker, quickly making it bulge with pressure.  Again you push the gasping, quaking incubus onto his back and guide him into your gaping pussy; your eyes catch those of an imp whose mouth is open with disbelief and whose dog dick is standing to attention.");
		outputText("\n\n\"<i>You!</i>\" you snap. \"<i>Fuck my ass.  Do a good job or I'll wring your neck.  The rest of you worthless spare pricks... gather around.</i>\"  You grip the incubus beneath you with your " + player.hipDescript() + " as small, uncertain hands grasp you around your waist and something hot oozes moisture into your " + player.assholeDescript() + ".  You thrust forwards and then backwards, simultaneously working the incubus cock whilst driving the imp's meat into your bowels.");
		player.buttChange(60,true,true,false);
		outputText("  Around you more dicks present themselves as other demons slowly draw closer, and with the cock inside you rubbing your sensitive inner walls backwards and forwards you enthusiastically grab two other turgid members and pump them in tandem.  One of the dicks you have grabbed is a sensitive cat dick and the owner is quickly moaning as your fingers brush his hooks; as you feel him reach his peak you ruthlessly jerk him around so he is facing Vapula, and he helplessly spurts his load onto her jiggling frame.  The imp begins to pump harder as he finds his rhythm, stretching your ass wide as he takes you to his plug, rubbing against the huge incubus cock trapped in your " + player.vaginaDescript(0) + ".  You laugh breathlessly and manically as the other demon in your grasp helplessly falls over his own peak, further soaking the horny ex-domniatrix.");
		//[cunt nipples] 
		if (player.hasFuckableNipples()) outputText("  Your freakish nipples moisten with excitement to the smell of man juice, and you feel your libido ratcheting up even higher.  Bending forward, you grab two other imps with smaller dicks, quickly guiding their lengths into your nipplecunts; they are small enough that you can mash their bodies against your soft flesh, doing all the work for them as your sensitive nubs are penetrated.");
		outputText("\n\nVapula stares at you through the creamy liquid which now covers her face and tits.  The contact of all this hot demon seed against her untouched body is driving her crazy; after some futile squirming in a desperate attempt to quench her burning pussy, she is now openly sobbing in frustration.");
		outputText("\n\n\"<i>You're.. you violate my pets... yet you won't deign to touch me.  Why?  D-don't you like my body?  Don't you like my cunt?  Please fuck me fuck me fuck me fuckmefuckme....<b>why won't you fuck me?  Please, I need to cum! Please!</b></i>\"");
		outputText("\n\nUnable to break your gaze, she stares at you as with slow, gloating exaggeration you put your sticky fingers into your mouth and moan, clenching down on the dicks deep in your holes as you do.  The incubus and imp");
		if (player.hasFuckableNipples()) outputText("s");
		outputText(" gasp as they spurt their loads, filling you with inhuman warmth; four balls push into overload and the incubus beneath you spasms his hips uncontrollably as he releases surge after surge of cum until your gushing quim begins dribbling the fluid back onto him.  You sigh and clench your muscles to hold as much of the delicious hot fluid in as possible before lifting yourself off the insensate incubus and sashaying towards Vapula.  You stroke the line of her jaw and gently touch her inner thigh as you begin to loosen her bonds.  She sobs with relief as you go about the task.");
		outputText("\n\n\"<i>Oh thank you, thank you... please do it to me now!  I've been bad, I know, I've had my punishment now and I want to be good for you, and... wait, what are you doing?</i>\"  Freed of the chains, she's only shoved onto her knees; you pin her hands behind her whilst standing over her head, and then, with a blissful sigh, release your muscles.  Vapula weeps openly as you pour an unholy mixture of demonic cum and your own juices out of your cunt");
		if (player.hasFuckableNipples()) outputText(", teats, ");
		else outputText(" ");
		outputText("and ass onto her, the copious tainted seed mixing with her tears.  Once it's all gone you wipe yourself with her hair, hoist her back into position and lash the restraints back into place.  Frankly, the process and the sight of her have made you even more turned on.  You lick your lips and turn back to the subdued demonic horde at your disposal.");
		outputText("\n\nWithout a word, you mercilessly fuck every demon you can lay your hands on, riding faces, sucking manpoles dry with your insatiable holes, pumping more and more spooge onto Vapula with your grasping hands and pussy.  The various demons in your power appear resigned to be used as mere fuck-toys for your sole enjoyment – and their mistress' torment.  Most of them barely struggle as you ferociously milk them; instead, they moan like the bunch of bitches they truly are, letting their mistress know what a beta female she is in comparison to you.  You repeat the shower once, twice, thrice; by the end Vapula's hair is a sopping mat of white.");
		outputText("\n\nAt last, you reach the limit of your prodigious stamina.  When you're done working the last untouched cock in the pit, when your " + player.vaginaDescript() + " is done squirting its ultimate drop of fluid over a wanton succubus, you relax.  Your gaping cunt aches pleasantly and you have no further use of any broken toy in the pit.  All but one...");
		outputText("\n\nWhen you walk up to Vapula, she is barely recognizable.  Her will is utterly broken and she seems considerably mollified.  Your repeated denials made her mind collapse; she's but an empty shell driven crazy by her burning unsatisfied lust.  With a content smirk, you lean down and give her a tender kiss, enjoying the taste of secondhand sexual juices coating her lips.  You whisper to her, \"<i>Good night, beauty.</i>\"  She doesn't seem to hear your taunt.");
		outputText("\n\nA few meters away, outside the pit, you notice your items and your " +player.armorName+ ". The village appears to be deserted. Considering these demons will have a hard time threatening anyone with white goo oozing out of their absurdly milked urethras, you let them rest, wallowing in their pool of mixed spunk.  You pick up your belongings and head back to camp.");
		//+med-high corruption, + strength/cons, -10 libido, slimefeed, imp preg check
		player.orgasm();
		dynStats("str", 1,"tou", 1, "lib", -4, "cor", 4);
		player.slimeFeed();
		player.knockUp(PregnancyStore.PREGNANCY_IMP, PregnancyStore.INCUBATION_IMP);
	}
	//PC is redirected to camp, next morning. No nightly camp scenes. 
	model.time.hours = 7;
	model.time.days++;
	combat.cleanupAfterCombat();
}

//Main Owca Village menu (Z)
//[displayed after the second encounter text and right away in subsequent encounters]
private function owcaMainScreenOn():void {
	clearOutput();
	
	if (flags[kFLAGS.REBECCS_LAST_PLEA] == 1 && !kGAMECLASS.vapula.vapulaSlave()) {
		rebeccsLastPlea();
		return;
	}
	if (flags[kFLAGS.OWCAS_ATTITUDE] <= 5 && flags[kFLAGS.OWCA_ANGER_DISABLED] == 0 && flags[kFLAGS.OWCA_SACRIFICE_DISABLED] == 0) {
		desperateVillages();
		return;
	}
	//Desperate plea
	if (rand(10) <= 2 && flags[kFLAGS.DAYS_SINCE_LAST_DEMON_DEALINGS] >= 7 && flags[kFLAGS.OWCA_SACRIFICE_DISABLED] == 0) {
		//(30% chance of spawning upon going to the village once a week has passed since last demon fight)
		//should happen instead of the normal village menu every week
		outputText("The village shows unusual signs of activity.  As you walk down the main road, people are all looking at you uncomfortably.  Some try to approach you but back off awkwardly at the last moment.  You don't understand until you stumble upon Rebecc, who seems on better terms with you than the rest of the village; she is displaying a worried face.");
		outputText("\n\n\"<i>" +player.short+ ", this is a difficult thing to request, especially when you've done so much for us already.  But... the demons are insatiable, of course.  They want a sacrifice every now and then, you know.</i>\"  As you slowly come around to what must be next, she grows more and more anxious.  \"<i>Could you... this time too, please?  Oh, I know I'm asking too much, but it's not us... it's them.  Please, we need your help again!</i>\"");
		outputText("\n\nThis time you fully understand the consequences of another sacrifice.  Do you comply?");
		//Yes: Leads to Accept Plea scene. Attitude is raised by 5.
		//No: Leads to Refuse Plea scene. Attitude is lowered by 10.
		doYesNo(createCallBackFunction2(acceptRebeccsPlea,false, true),declineRebeccsPlea);
		return;
	}
	outputText(images.showImage("location-owca"));
	//[if attitude > 80]
	if (flags[kFLAGS.OWCAS_ATTITUDE] > 80) outputText("Villagers greet you as you arrive, praising your courage and your heroism.  People shake your hands or ask you to kiss them, as if they hoped your nobility were somehow contagious.  Once they're done complimenting and flattering you in every way possible, they leave you to your business.");
	//[if 60<=attitude<80]
	else if (flags[kFLAGS.OWCAS_ATTITUDE] > 60) outputText("Villagers greet you with a friendly smile as you arrive.  Some approach you and thank you for what you've done, before leaving awkwardly.  They're obviously not used to strangers.");
	//[if 40<=attitude<60]
	else if (flags[kFLAGS.OWCAS_ATTITUDE] > 40) outputText("Villagers seem to accept your presence without comment now; though none go out of their way to greet you, neither do they avoid doing so when you pass by.");
	//[if 20<attitude <= 40]
	else if (flags[kFLAGS.OWCAS_ATTITUDE] > 20) outputText("Villagers keep looking at you uncomfortably; no one seems to be willing to talk to you apart from Rebecc, your friend.");
	//[if attitude <= 20]
	else outputText("Villagers here appear to be openly hostile.  You keep hearing muffled whispers as you pass by, and people look at you rancorously.  They don't bother you, though.");
	//end variable display
	outputText("  The village is rather small.  A dozen humble thatched cottages are standing here and there, linked by dirt tracks and enclosed with small palisades.  There seems to be very little activity.");
	outputText("\n\nAt the end of the main road you notice the pit and the pole standing at the middle of it.  It looks rather sinister, reminding you of the permanent curse that lies on the villagers.  It is still unguarded.");
	//[if a week has passed since last sacrifice]
	if (flags[kFLAGS.DAYS_SINCE_LAST_DEMON_DEALINGS] == 7 && flags[kFLAGS.OWCA_SACRIFICE_DISABLED] == 0) outputText("  A week");
	else if (flags[kFLAGS.DAYS_SINCE_LAST_DEMON_DEALINGS] > 7 && flags[kFLAGS.OWCA_SACRIFICE_DISABLED] == 0) outputText("  More than a week");
	if (flags[kFLAGS.DAYS_SINCE_LAST_DEMON_DEALINGS] >= 7 && flags[kFLAGS.OWCA_SACRIFICE_DISABLED] == 0) outputText(" has passed since the last offering to the demons; guarding the pit would certainly help improve your relations with the little town's denizens.");
	//Option: 
	var pit:Function = null;
	var herd:Function = null;
	var tavern:Function = null;
	if (model.time.hours >= 16 && flags[kFLAGS.OWCA_SACRIFICE_DISABLED] == 0) {
		//Pit. Requires 16:00 or later. Leads to the night gangbang (with possible fight) scene, this time fully equipped and clothed. Attitude is raised by 3.
		pit = zePit;
	}
	if (flags[kFLAGS.OWCAS_ATTITUDE] >= 50) {
		outputText("\n\nBeyond the tiny hamlet you see herders guarding a considerable amount of sheep.  You could probably join them and ask them for work.");
		herd = herds;
		//Option: Herds, needs 50 attitude.
	}
	outputText("\n\nRebecc's house is nearby, and her door is open. She would probably welcome the chance to wash away any taint you've received from your time in the pit.");
	//Option: Rebecc. Leads to Rebecc Menu
	if (flags[kFLAGS.OWCAS_ATTITUDE] >= 10) {
		outputText("\n\nA tavern appears to be open; various Owca folk are drinking and chatting in it.  They give you friendly waves when you make eye contact.");
		//Option: Tavern. Leads to the Tavern, needs 10 attitude
		tavern = owcaTavern;
	}
	//[Pit][Herds][Rebecc][Tavern]
	simpleChoices("Pit",pit,"Herds",herd,"Rebecc",rebeccMenu,"Tavern",tavern,"Leave",camp.returnToCampUseOneHour);
}
//Tavern (Z)
public function owcaTavern():void {
	clearOutput();
	outputText(images.showImage("location-owca-tavern"));
	outputText("The tavern is nice and cozy; there are a few tables and chairs scattered around in no ordered pattern, and most clients here appear to belong to the same species.  By the crude wooden bar, you see a list of all the current drinks on sale:\n<i>");
	//SheepMk
	var milk:Function = createCallBackFunction(owcaBuySetup,consumables.SHEEPMK);
	outputText("\nSheep Milk Bottle: " + (180 - flags[kFLAGS.OWCAS_ATTITUDE]) + " gems");
	if ((180 - flags[kFLAGS.OWCAS_ATTITUDE]) > player.gems) milk = null;
	
	var goblin:Function = createCallBackFunction(owcaBuySetup,consumables.GOB_ALE);
	outputText("\nGoblin Ale: " + (60 - Math.round(flags[kFLAGS.OWCAS_ATTITUDE]/2)) + " gems");
	if ((60 - Math.round(flags[kFLAGS.OWCAS_ATTITUDE]/2)) > player.gems) goblin = null;
	
	var brew:Function = createCallBackFunction(owcaBuySetup,consumables.BROBREW);
	if (rand(10) > flags[kFLAGS.OWCAS_ATTITUDE]/10) {
		outputText("\nBro Brew: 2000 gems");
		if ((2000) > player.gems) brew = null;
	}
	else brew = null;
	
	var cum:Function = createCallBackFunction(owcaBuySetup,consumables.MINOCUM);
	outputText("\nMinotaur Cum: " + (300 - flags[kFLAGS.OWCAS_ATTITUDE]) + " gems");
	if ((300 - flags[kFLAGS.OWCAS_ATTITUDE]) > player.gems) cum = null;
	outputText("</i>");
	simpleChoices("Sheep Milk",milk,"Goblin Ale",goblin,"Bro Brew",brew,"MinotaurCum",cum,"Back",gangbangVillageStuff);
}

private function owcaBuySetup(item:ItemType):void {
	if (item == consumables.SHEEPMK) buyOwcaShit(item,(180 - flags[kFLAGS.OWCAS_ATTITUDE]));
	else if (item == consumables.GOB_ALE) buyOwcaShit(item,(60 - Math.round(flags[kFLAGS.OWCAS_ATTITUDE]/2)));
	else if (item == consumables.BROBREW) buyOwcaShit(item,2000);
	else buyOwcaShit(item,(300 - flags[kFLAGS.OWCAS_ATTITUDE]));
}

private function buyOwcaShit(bleh:ItemType,price:Number = 0):void {
	clearOutput();
	player.gems -= price;
	statScreenRefresh();
	outputText("The bartender hands you a bottle and grabs your gems before attending other clients, leaving you to your own business.\n\n");
	inventory.takeItem(bleh, owcaTavern);
}
	
//Herds (Z)
private function herds():void {
	clearOutput();
	outputText("The herders greet you warmly.  \"<i>Welcome, champion!  It is indeed a pleasure to have the honor to talk to such a noble and revered hero.</i>\"  You reply with equal grace and ask in a more formal tone if there's anything you can do to help them out.");
	outputText("\n\n\"<i>Well, our sheep badly need to be sheared and we could really use an extra pair of hands to get the work done.</i>\"  The herder proceeds to hand you some tools, and redirects you to a group of villagers working actively.  You rapidly join them and soon enough you are having a pleasant conversation, chatting and laughing as you collect the wool, so much so that you don't see where time goes; in what seems like minutes you're already done.");
	//attitude +5, int +1
	flags[kFLAGS.OWCAS_ATTITUDE] += 5;
	if (flags[kFLAGS.OWCAS_ATTITUDE] > 100) flags[kFLAGS.OWCAS_ATTITUDE] = 100;
	dynStats("int", 1);
	//[if attitude > 70]
	if (flags[kFLAGS.OWCAS_ATTITUDE] > 70) {
		outputText("\n\nThe villagers thank you for your hard work and one of them hands you a bottle of sheep milk.  \"<i>'Tis good for your health.  Don't worry, it won't... mutate you.</i>\"\n\n");
		inventory.takeItem(consumables.SHEEPMK, camp.returnToCampUseOneHour);
	}
	else doNext(camp.returnToCampUseOneHour);
}

//Pit (Z)
private function zePit():void {
	clearOutput();
	outputText("You announce to all the villagers present that you're going to guard the pit as well as the village's entrance against the demons, trusting them to spread the news; they seem glad that you took this initiative on your own.  Checking your equipment, you head toward the pit, ready to stand your ground against the lewd horde.");
	//Redirects to the Dusk Transition Scene, then to a combat with full equipment and weapons. Loss/Victory scenes as usual.
	doNext(createCallBackFunction(intoTheDemonPit,false));
}

//Rebecc Menu (Z)
private function rebeccMenu():void {
	clearOutput();
	outputText("You knock and step into the old shack, accustoming yourself to the meager light.  As soon as you close the door behind you, you spot Rebecc stepping out of a little backroom.");
	outputText("\n\n\"<i>"+player.short+ "!  You came!  I was just preparing a hot bath.  My poor darling, you must have gone through a really perilous ordeal.  Here, do you want to get cleaned up?</i>\"");
	//Option: Appearance: Leads to Rebecc Descrpition.
	//Option: Bath: Leads to Rebecc Bath Scene.
	//Option: Rape: Leads to Rebecc Rape scene. Ends the quest. Requires sizable corruption score.
	//Option: Leave: Redirects PC to Owca Village.
	//[Appearance][Bath][Leave][Surprise Sex!]
	var sex:Function = null;
	if (player.cor >= 66) {
		sex = createCallBackFunction(rapeRebecc,false);
		outputText("\n\nYou could try and force yourself on her, but you might not be welcome in town after...");
	}
	simpleChoices("Appearance", rebeccAppearance, "Bath", rebeccBathScene, "", null, "Surprise Sex", sex, "Back", gangbangVillageStuff);
}
//Rebecc Appearance (Z)
private function rebeccAppearance():void {
	clearOutput();
	outputText("Rebecc is a 5-foot, 7-inch sheep-girl, with a cute human visage decorated by two little nubby horn protrusions and plush and fuzzy curled white hair that cascades down over her shoulders.  Her face is expressive, with her glinting blue eyes and avid mouth accurately reflecting her whole range of emotions.  Her complexion is extremely pale, although the exposed parts of her body are rather tanned due to hours of labor under the scorching sun.  She is currently wearing a coarse peasant dress, a layer of thin white cloth that clearly outlines her appealing curves.  Her fine hips and legs sway with elegance when she walks and you can guess a bountiful wiggly rump hides behind the back of her gown.");
	outputText("\n\nShe has a pair of ample, barely concealed breasts.  Although you can't see them outright, her thin clothing leaves little doubt that they're D-cups.  Her 0.5 inch nipples point through her dress whenever she's aroused.");
	outputText("\n\nShe has a pussy of dubious virginity but copious wetness between her legs.  Occasionally a damp patch will appear on her dress, betraying her arousal.");
	outputText("\n\nYou can't see her asshole, but it's safe to assume it's placed between her squeezable buttocks, right where it belongs.");
	doNext(rebeccMenu);
}
//Rebecc Bath scene (Z)
private function rebeccBathScene():void {
	clearOutput();
	outputText("She grabs your hand and leads you to her bathroom, a tiny place almost entirely occupied by an enormous circular container acting as a bathtub, full of hot steaming milk.  You watch her, puzzled.");
	outputText("\n\n\"<i>What?  Don't you bathe in milk in your village?  We have plenty of it here in Owca, you know; more than clean water.  We use it for everything; it has curing properties.</i>\"  Whispering seductively, she adds, \"<i>It's also ideal for purging brave demon fighters from any taint they may have caught.</i>\"");
	outputText("\n\nShe stares at you with insistent and playful eyes.  \"<i>Now come on, you know where I'm going with this.  Let me help you out of your clothes.</i>\"");
	outputText("\n\nYou don't resist, grinning as she enthusiastically removes your " + player.armorName + "; in her haste she gets tangled up until you hold her hand and help her with the fastenings.  A few seconds later you're completely naked and she covers your face and torso with soft kisses as she strips off.  You both giggle as she tries to squeeze both of you into the bathtub; at last she makes you sit in it, laughing and splashing milk everywhere.");
	outputText("\n\n\"<i>There.  Now let me wash you clean.</i>\"");
	outputText("\n\nShe grabs hold of a nearby soap and starts lathering it all over your naked body.  You can't see her hands under the moving milky surface but you feel very pleasant tingles in the most intimate places.  She tickles you a bit and you can't help but giggle some more as you feel her delicate hands working you over.");
	outputText("\n\n\"<i>Shhh... Relax now, soldier.  I'll take care of everything.</i>\"");
	outputText("\n\nShe first softly brushes your hair with her fingers and strokes your head, then massages every tense muscle at the edge of your face, making you sigh and moan in relief.  Before you even notice, her hands are squeezing and pinching the nape of your neck, completely releasing your tension.  You don't know where she learned to be so good at this, but it just feels so right.  Now her hands are moving downards...  Gods, she is so sweet, so delicate.  You let out another moan, making her chortle.  Putting her head just above yours, her perky tits press against your back.  You can feel her erect nipples gently scratching you as she slowly rubs her appreciable bosom against you; her expert ministrations are arousing you little by little");
	if (player.gender == 0) outputText("."); 
	else {
		//[if cock]
		if (player.hasCock()) outputText("; your " + player.cockDescript(0) + " grows to full erect size");
		if (player.hasVagina() && player.hasCock()) outputText(" and ");
		else if (player.hasVagina()) outputText("; ");
		if (player.hasVagina()) outputText("your " + player.vaginaDescript() + " leaks a little trickle of girl-juice");
		outputText(".  She doesn't seem to notice the effect she has on you - or so you think.  Suddenly, you feel a hand darting between your legs.");
	}
	outputText("\n\n\"<i>Oooh, so you really like this, don't you?</i>\"");
	outputText("\n\nYou blush and groan in response as she keeps teasing you with her graceful hands.  Caught flat-footed, you feel yourself deflating in shame until she begins whispering tender reassurance in your ear.  \"<i>It's all right, dear.  I want to make sure you're enjoying it thoroughly.  You deserve it.</i>\"");
	outputText("\n\nHer hands stimulate and arouse you ever so slightly, until you tell her desperately you must be completely clean of any demon soiling by now.  You both laugh together awkwardly as you rise from the bathtub; she watches you greedily as you slowly don your [armor].  You eventually leave her, a little saddened.  Rebecc gives you a chaste kiss on your cheek before bidding you farewell.  \"<i>And be sure to come back, hero.  I can't wait to clean you up again.</i>\"");
	//Lust +30, Corr -2, Lib +1, slimefeed
	dynStats("lib", 1, "lus", 30, "cor", -2);
	player.slimeFeed();
	doNext(camp.returnToCampUseOneHour);
}
//Rebecc Rape scene (for discerning penises) (Z)
private function rapeRebecc(outside:Boolean = false):void {
	clearOutput();
	if (player.hasCock()) {
		outputText("Within three strides you are upon Rebecc; you slap her twice on her cheeks, brutally yank her hair and in a harsh gesture, you turn her around.  The woman yells, \"<i>W-what are you doing?  No, please stop!</i>\"  Completely caught unaware, she gasps and jolts in surprise, crying loudly until you slap her again to shut her up.");
		outputText("\n\nYou quickly proceed to denude her, tearing her peasant dress to reveal her bountiful, jiggling breasts.  This enormous rack is begging to be touched; you ruthlessly grope them, forcefully bringing her nipples into their erect state.  She tries to struggle away but you hold her tight, her resistance and endless writhing making [eachCock] harder; to better please yourself, you pull it free of your [armor].  You grind against her plush butt through the coarse cloth of her dress until it is completely drenched with pre-cum, then feverishly remove it, tearing the poor girl's gown to rags in the process to give you a clear view of her ample buttocks.  Pressing yourself on her more, you thoroughly enjoy the soft touch of her healthy rump.  You pinch and grope her fat butt repeatedly, making her whimper in humiliation, until it goes red from your rough treatment.  Gods, this girl has a fine ass; you give it a few slaps here and there as it jiggles in the most enticing way.");
		outputText("\n\nThe sight of her glorious rear is too tempting a target to resist, and you quickly shove the tip of your " + player.cockDescript(0) + " between her plush cheeks, bracing yourself for torrid anal penetration.  She keeps whining, unable to break free of your iron grasp.  In her constant struggles you notice an opening between her buttocks - you thrust inside with all your might, devastating her backdoor entrance, stretching her holes, tearing her insides and grinding against her rugged anal walls in a extremely rough way.");
		//[if cock is too long, >12 inches]
		if (player.cocks[0].cockLength > 12) outputText("  You keep burying more of your " + player.cockDescript(0) + " deep inside her rectum until you reach her limit and can't fit more cock in.");
		else outputText("  Eventually the entirety of your prick is lodged inside her lush asshole.");
		outputText("  She trills and bleats in pain and flounders about in your arms, futilely trying to avoid the incoming butt-rape.  You lock her arms with yours, implacably kneading her tits, and her shivering flesh brings the most exquisite contact to your fingers; you toy with her nipples as well, making her scream savagely in forced pleasure.");
		outputText("\n\nAfter a few minutes of resistance, her body tenses up and you ease yourself into effectively butt-fucking her.  You pull her white fuzzy hair, seize her squeezable hips for more leverage and start raping her ass; the thrusts come hard and fast, almost bringing your " + player.cockDescript(0) + " out before jamming it all the way inside again.  This forceful and tigerish motion makes her shriek in excruciating ecstasy; she groans and moans rhythmically at the pace of your regular ass-pounding.  The torment you're inflicting on her poor interior walls is too much to bear and she twists violently to escape the dick-beast dominating her pucker; however, all she can do is wave her appreciable butt, bringing extra sensations to your " + player.cockDescript(0) + " and adding extra spice to your already ardent anal-rape.");
		outputText("\n\nThe cadenced wobbling of her rump as well as your constant pumping is bringing you to a higher state of pleasure; the heavenly tingle your " + player.cockDescript(0) + " is receiving is making you heedless of anything else but the burning heat of her insides cooking your meat.  You feel your lust rise as you keep riding the buttslut below you, ignoring her muffled complaints and whining, her tight confines gradually taking over any control you have over your rod.  You pound Rebecc's ass as if your life depended on it, clutching her curvy hips instinctively like an imp in rut.  Your groin impacts her buttocks with a loud SLAP at every thrust");
		//[if balls]
		if (player.balls > 0) outputText(", and your " + player.ballsDescriptLight() + " almost feel sore from colliding with her dribbling cunt");
		outputText(".  Finally, when you think you're about to pass out from exhaustion, you cum in a powerful jet, literally blasting Rebecc's ass with your spooge, globs of  goo being propelled like projectiles into her colon and splattering her backside with huge white smears.");
		if (player.cumQ() > 1500) outputText("  After completely filling up her rectum, your baby-batter erupts in thick spurts from her anus despite her instinctive ass-clenching efforts to hold as much semen as possible inside.  The sheer might of your cumshot is enough to send Rebecc over the edge, and she releases an absolutely torrential stream of girl-cum, squirting against her will all over your groins and mixing her own fluids with yours in a pathetic show of sluttiness.");
		outputText("  She unconsciously milks you of all your spunk, her anal muscles working on their own to massage your meat and extract every drop from your urethra.");
		outputText("\n\nWith a last, satisfied sigh, you fall over, " + player.cockDescript(0) + " deeply buried inside Rebecc's butt as you feel her warm, curvy body slowly waggling below you.  ");
		if (outside) outputText("Some of the villagers are apathetically watching you, too stunned and bruised to intervene.  ");
		outputText("You silently remove your prick from your girl's ass, watch her contentedly as her exposed rectum is literally oozing with spooge and walk back to your camp.");
		outputText("\n\nThis is a more-than-appropriate goodbye gift");
		if (outside) outputText(" to these miserable people, and even moreso");
		outputText(" to the manipulative slut who kept teasing you.  Serves her right, to use her body in the most provocative ways and never let you actually have your way with her.  You're unlikely to ever see her again.");
		//minus lust, minus libido, plus corruption, Remove Owca Village from 'Places' menu.
		outputText("\n\n(<b>Owca removed from the places menu.</b>)");
	}
	//Rebecc Female Rape Scene (Z)
	else {
		//Requires: PC female and biped
		outputText("Within three strides you are upon Rebecc; you slap her twice on her cheeks, brutally yank her hair and in a harsh gesture, you turn her around.  The woman yells, \"<i>W-what are you doing?  No, please stop!</i>\"  Completely caught unaware, she gasps and jolts in surprise, crying loudly until you slap her again to shut her up.");
		outputText("\n\nYou quickly proceed to undress her, tearing her coarse peasant dress in order to reveal her bountiful, jiggling breasts.  This enormous rack is begging to be touched; you ruthlessly grope it, forcefully bringing her nipples into their erect state.  She tries to struggle away but you hold her tight, her resistance and endless writhing making your " + player.vaginaDescript() + " moist.");
		outputText("\n\nYou keep rubbing against her plush butt through her ragged cloth and your " + player.armorName + " until it is completely drenched with your juices; you feverishly remove them, tearing the poor girl's gown to rags in the process to give you a clear view of her ample buttocks.  You enjoy the soft touch of her healthy rump against your own skin, glorying in the other girl's helplessness to stop you from touching her however you want.  You pinch and grope her fat butt repeatedly, making her whimper in humiliation, until it goes red from your rough treatment.");
		if (player.tone > 75) outputText("  The sheep girl's plush softness against your own toughened, toned physique manages to both arouse and anger you.  \"<i>This is what you were bred to be, isn't it bitch?</i>\" you hiss, your hands roaming over her inviting curves.  \"<i>Your fat ass hasn't had to work a day in its life.  The town whore, the cock-tease they wheel out when your people need a dupe, that's what you are.  How does it feel to be in the hands of a real woman?</i>\"");
		else outputText("  Gods, this girl has a fine ass; you give it a few slaps here and there as it jiggles in the most enticing way.");
		outputText("  Rebecc doesn't say anything as you continue to grope her; she simply quivers with her eyes tightly shut, apparently unwilling to believe this is even happening.");
		outputText("\n\nYou shove her tits-first to the floor, grinning at the pained squeal this draws from the sheep girl and the wave of motion it sends across her soft body, then stand over her.  She struggles pitifully as you slowly prise her legs open, but the weakling is no match for you and you soon have her spread wide, helplessly presenting her cute, pink pudenda to you.   The sight stokes your raging lust and you sink one finger roughly through her lips into her moist hole, testing her depths as you lower yourself onto her.   Rebecc whimpers again at the abrasive treatment, and with one last meek show of resistance closes her legs and turns away from you.  You grasp her shoulder and backhand her hard, being sure to wipe her own juices onto her face on the return stroke.  She ceases struggling as you slide one of your " + player.hipDescript() + " over her own plump thigh, clinch her other lamb chop with your arm, and, having thus entrapped her with your burning body, lower your " + player.vaginaDescript() + " onto hers and begin to buck against her.");
		outputText("\n\nWet sounds fill the air as you thrust your needy cunt into Rebecc's own, your juices dribbling onto and into her, lubricating your unwilling toy.  She whines and again tries to struggle out of the merciless grip you have her in; the effect is to make her own cunt buck and thrust into yours, your slimy lips kissing and moving against each other, heightening your own pleasure and making you scissor into her all the more savagely, already working yourself to a high.  You shove her leg up ruthlessly high so you can really grind into her; you feel her tiny clit bump into your own " + player.clitDescript() + " and suck in your breath as Rebecc squeals.  Irritated with her constant noise, you bend into the prostrate sheep girl and slap her again, before roaming your hand down her lush front, your fingers landing upon a dark nipple.  You squeeze it as you rub your clits together, her warm flesh wobbling against yours, her own juices dribbling now as you push her relentlessly along the boundary between pain and pleasure until she arches her back and moans in miserable ecstasy, her cunt spasming a gush of girlcum onto you.  You reward her with another slap as she twists in her involuntary orgasm, so that your red hand mark has a partner upon the other side of her face.  It's a good look for her.");
		//[big clit]
		if (player.clitLength > 3) outputText("\n\nYou aren't done yet.  Your own clit has long since pushed out of its hood and is bulging with obscene need.  You rotate your hips, teasing Rebecc's dribbling entrance with it whilst immersing yourself in pleasure, rubbing every inch of your sensitive femcock over her lips and hole before forcing yourself against her own tiny pleasure button, making her twitch and moan.  Your lust stoked to incredible heights by the slick pressure on your clit and the sight and feeling of your yielding, insensate victim, you finally thrust it into her slick hole, eager for release.  Clutching her gelatinous ass and firm neck as you fuck her like a man, you're forced to grit your teeth against the unbearably pleasurable sensation of your clit rubbing on her tender inner walls.  Your " + player.vaginaDescript() + " drools in sympathy as you push your " + player.hipDescript() + " into the sheep girl and drive her into the ground, fucking her with your clit-dick as hard as you can.   Your pelvises beat a rough staccato against each other as you bring yourself all the way out and then thrust yourself in again, spattering your mixed juices everywhere as you pick up the pace.  Your " + player.allBreastsDescript() + " are pushed into her own soft pillows as you rub every inch of yourself over her, determined in your lust craze to violate all of this slut's teasing body.");
		//[other] 
		else {
			outputText("\n\nYou aren't done yet.  Your own clit has long since pushed out of its hood and is bulging with need.   You rotate your hips, teasing Rebecc's dribbling entrance with it whilst immersing yourself in pleasure, rubbing every inch of your sensitive female nub over her lips and hole before forcing yourself against her own tiny pleasure button, making her twitch and moan.  Casually you slap her face again, making her start; the movement translates through her body into your own needy sex as her lips involuntary shrink and rub against yours.  What a lovely sensation!  Your lust stoked to incredible heights by the slick pressure on your clit and the sight and feeling of your yielding, insensate victim, you thrust against her slick hole, eager for your own release.  You scissor her as hard and as violently as you can, slapping into her brutalized sex a few times before embedding yourself and rotating, striking her face carelessly again and again and again.  Her shuddering and sobbing only serves to heighten your pleasure.");
		}
		outputText("\n\nEventually you reach your high.  You clutch Rebecc painfully hard as your pussy spasms around hers, soaking her with your juices.  The crashing orgasm just seems to go on and on and you ride it into your slutty victim, forcing her to feel what you are feeling.  Once the ecstatic contractions have murmured down to a warm buzz, you sigh and crawl onto your prone victim, who is crying quietly.  You are sure to wipe your drooling sex all along her belly, breasts, and finally face; the sheen of femcum and the red hand marks on her tearstained cheeks doubly mark her as your spent, worthless sex toy.  ");
		if (outside) outputText("Some of the villagers are apathetically watching you, too stunned and bruised to intervene.  ");
		outputText("You silently pick yourself up and dress, admiring the quivering, crying handiwork at your feet, before walking back to your camp.  This is a more-than-appropriate goodbye gift");
		if (outside) outputText(" to these miserable people, and even moreso");
		outputText(" to the manipulative slut who kept teasing you.  Serves her right, to use her body in the most provocative ways and never let you actually have your way with her.  You're unlikely to ever see her again.");
		outputText("\n\n(<b>Owca removed from the places menu.</b>)");
	}
	//minus lust, minus libido, plus corruption, remove village from places
	player.orgasm();
	dynStats("lib", -2, "cor", 5);
	flags[kFLAGS.OWCA_UNLOCKED] = -1;
	
	if (getGame().inCombat)
		combat.cleanupAfterCombat();
	else doNext(camp.returnToCampUseOneHour);
}

//Desperate Villagers (Z)
//[Dialogue once Attitude reaches 0 or less, pops automatically as you go to the village]
private function desperateVillages():void {
	clearOutput();
	outputText("As you approach the group of huts, you hear a vague rumble, as if many people were talking at the same time.  Walking closer, you see all the villagers gathering outside and arguing violently; among them you spot your friend, Rebecc.  As soon as she sees you she hurries over with desperate, wet eyes.");
	outputText("\n\n\"<i>They want to put you back into the pit by force!  I and some others have tried arguing with them but they won't hear anything!  The demons have been harassing us a lot due to the lack of sacrifices, please do something!</i>\"");
	outputText("\n\nShe is rudely pushed aside by a tall muscular man with a pitchfork in his hand.  He starts talking in a slow, harsh voice.  \"<i>You supposed to be brave.  Go ahead.  Make sacrifice.  Or do we need to make you brave, be it against your own will?</i>\""); 
	outputText("\n\nIt seems that these villagers have grown weary of your repeated refusals; they are likely to react angrily if you deny them another sacrifice.");
	outputText("\n\nDo you submit?");
	//Yes/No. Yes leads to Accept Plea, Attitude raised by 10. No to Villagers Fight
	doYesNo(createCallBackFunction2(acceptRebeccsPlea,false, true),fightZeVillagers);
}
//Villagers Fight (Z, but pretty barebones)
private function fightZeVillagers():void {
	clearOutput();
	//You are fighting the villagers (level 14):
	startCombat(new Farmers());
	monster.createStatusEffect(StatusEffects.GenericRunDisabled,0,0,0,0);
	playerMenu();
	//~500 HP, 6 different attacks at 20 hp, can't run, 100% lust resistance (can't arouse), ~200 xp
}



//Defeat Villagers (only displayed if corruption >= 60ish) (Z)
public function beatUpOwca():void {
	clearOutput();
	outputText("The last of the villagers drops his improvised weapon.  They are all lying defenseless before you.  At last, you notice Rebecc, the only one still conscious, curled up as she weeps uncontrollably.  She is clearly oblivious of her surroundings, undoubtedly shocked by the violent fight.  Even if she calls herself your friend, you don't think you'd be able to reason with her after pummeling her kin.  What do you do?");
	//Rape Rebbecc/Torch Village (needs Akbal's fire or Whitefire)/Leave
	var torch:Function = null;
	if (player.findStatusEffect(StatusEffects.KnowsWhitefire) >= 0 || player.findPerk(PerkLib.FireLord) >= 0 || player.findPerk(PerkLib.Hellfire) >= 0 || player.findPerk(PerkLib.Dragonfire) >= 0)
		torch = torchOwcaMotherFuckers;
	var rape:Function = null;
	if (player.cor >= 60 && player.gender > 0 && player.lust >= 33) rape = createCallBackFunction(rapeRebecc,true);
	simpleChoices("Rape Rebecc", rape, "Torch Village", torch, "", null, "", null, "Leave", leaveOwcaAfterWhupping);
}

//"Leave" redirects the PC to camp; next encounter is Rebecc's Last Plea.
private function leaveOwcaAfterWhupping():void {
	//tag for calling last plea
	flags[kFLAGS.REBECCS_LAST_PLEA] = 1;
	combat.cleanupAfterCombat();
}
//Village Torching scene - requires a fire skill (Z)
private function torchOwcaMotherFuckers():void {
	clearOutput();
	outputText("These ignorant folks deserve to be punished for trying to take you by force.  You muster your strength and release a wave of magical flame.  The raw heat and energy is enough to set entire thatched roofs ablaze.  You ignite house after house, the poor constructions unable to withstand your fiery might, until there are enough burning that the wind can carry the flames to all other buildings nearby.  A few minutes later, the entire village is ablaze; hovels are crumbling under their own weight and the crude roads are being littered with fallen debris.  You watch Owca burn silently, arms crossed.  Finally, when the last building has been thoroughly reduced to a pile of rubble and ashes, you quickly search for any valuables among the villagers' belongings.  Fortunately their gems haven't been melted; you pack a substantial amount of them away before leaving.  You cast a thoughtful glance at the remains of what used to be a peaceful village; ironically enough, the only structure you preserved was the pole in the pit, an ultimate mockery of their futile struggles against forces that ridiculously outmatch them.");
	player.gems += 900 + rand(150);
	flags[kFLAGS.OWCA_UNLOCKED] = -1;
	dynStats("cor", 15);
	if (player.cor >= 60 && player.gender > 0 && player.lust >= 33) {
		outputText("You notice Rebecc is still weeping among the scattered bodies of the beaten villagers.  Do you abuse her?");
		simpleChoices("Abuse Her",createCallBackFunction(rapeRebecc,true),
				"", null, "", null, "", null, "Leave", torchUpVillagersAndLeave);
	}
	else doNext(torchUpVillagersAndLeave);
}
	
//Fuck off village
private function torchUpVillagersAndLeave():void {
	clearOutput();
	outputText("You don't think you're going to see these villagers again, and you don't really want to.");
	//Corruption +15 (plus extra for rape), ~ 1000 gems, fatigue set to 100
	player.changeFatigue(100);
	statScreenRefresh();
	combat.cleanupAfterCombat();
}
//End of quest
//Lose to Villagers (Z)
public function loseToOwca():void {
	clearOutput();
	outputText("You kneel down and then fall, overwhelmed by the villagers' fury and numbers.  Without hesitation, the angry mob jumps on you; you recoil in terror, persuaded that you're going to be beaten to death.  Instead, you are carelessly lifted and completely stripped off; ");
	if (player.weaponName != "fists") outputText("your " + player.weaponName + " is taken away and ");
	outputText("you are being uncomfortably transported to a destination you can guess easily.  Too dazed to resist or even worry about it; you are promptly brought to the dreaded pit, where the villagers tie you up and rudely shackle you.  Then, before you even realize how desperate your situation is, they're all gone.  Your numerous bruises and fatigue get the better of you and you quickly fall asleep.");
	//redirect to dusk transition text, restore hp/fat consonant with sleeping until nightfall
	HPChange(50,false);
	player.changeFatigue(-30);
	//after nightly scene, next encounter is Post-Mob Encounter
	doNext(loseOrSubmitToVapula);
	player.createStatusEffect(StatusEffects.LostVillagerSpecial,0,0,0,0);
}
//Post-Mob Encounter (Z)
private function morningAfterRape():void {
	player.removeStatusEffect(StatusEffects.LostVillagerSpecial);
	clearOutput();
	outputText("The village is utterly silent and almost deserted.  The few people you see look away when they spot you, probably ashamed of what they did last time.  Doors are locked and windows are closed as you pass by; everyone is obviously afraid of directly confronting their victim.  You head toward Rebecc's house, your last friend.  As you open her door, you hear a muffled wail; you recognize the pretty farmer's voice.  She is laying on her bed, weeping uncontrollably; once she finally notices your presence, she looks up to you with tear-filled eyes, sobbing convulsively as she talks.");
	outputText("\n\n\"<i>T-they forced you to be abused... I promise I didn't want that!  I tried to convince them... they wouldn't listen... they threw you to the pit... at least I made them give you back your belongings as usual... now you must hate me, don't you?  Oh, I'm so sorry!  It's all my fault!</i>\"");
	outputText("\n\nWhat do you do?");
	//Option: Forgive. Sets Attitude to 50, quest goes back to normal.
	//Option: Rape. Leads to Rebecc Rape scene and ends the quest. 
	//Option: Leave. Redirects PC to camp, next encounter leads to Rebecc's Last Plea
	simpleChoices("Forgive",forgiveOwca,
			"Rape", createCallBackFunction(rapeRebecc, false), "", null, "", null, "Leave", fuckThisShit);
}
//Option: Forgive (Z)
private function forgiveOwca():void {
	clearOutput();
	outputText("Swallowing your pride, you tell her that it's all right and that you hold no grudge against her; the villagers were obviously desperate, to have resorted to such extreme measures.  You assure her");
	if (player.cor >= 50) outputText(", lying through your teeth,");
	outputText(" that you don't feel any resentment at all; she tried her best to help you, and you're grateful to her.");
	outputText("\n\nRebecc's face is overcome with joy as you speak.  \"<i>Thank you, thank you!  I've been filled with remorse and sorrow since this last awful encounter, you can't believe how relieved I am!</i>\"  You take her in your arms and hold her tight until the last of her tears finally dries up.  \"<i>I'm going to tell everyone in the village how great a person you are!  You will be acclaimed as our hero!</i>\"");
	//Corruption -8, Int +2, Attitude raised to 60, will never shrink below 1 (i.e. villagers won't get angry at you again)
	dynStats("int", 2, "cor", -8);
	flags[kFLAGS.OWCAS_ATTITUDE] = 60;
	flags[kFLAGS.OWCA_ANGER_DISABLED] = 1;
	//To main owca menu
	if (getGame().inCombat)
		combat.cleanupAfterCombat(gangbangVillageStuff);
	else doNext(gangbangVillageStuff);
}
//Option: Leave (Z)
private function fuckThisShit():void {
	clearOutput();
	outputText("You stare at the wretched, whimpering creature before you for a moment.  There's nothing to say.  Without a word, you head back to your camp, carefully closing Rebecc's door behind you as you leave.");
	flags[kFLAGS.REBECCS_LAST_PLEA] = 1;
	if (getGame().inCombat)
		combat.cleanupAfterCombat();
	else doNext(camp.returnToCampUseOneHour);
}
//Rebecc's Last Plea (Z)
private function rebeccsLastPlea():void {
	clearOutput();
	outputText("As you arrive on the border of the cursed village, you see someone is running in your direction.  You recognize Rebecc instantly; she seems to stumble and stagger at every step, and her face is tear-stricken.  Intrigued, you catch the crying woman by the waist as she runs past you sightlessly; she falls into your arms, nearly tripping as she abandons herself to your embrace.  Unsure of what to do, you ask her why she is panicking, though it takes a while before your words reach her.");
	outputText("\n\n\"<i>They... they chose me!</i>\" she wails, choking back.  \"<i>They voted and I was chosen to be thrown in the pit!  They're angry at me for befriending you and I was blamed for the recent troubles with the demons!  They think you've abandoned us and I'm responsible for all this... they hate me!  They hate you too!  I'm going to be tied up, abused and broken... and everyone will pretend nothing happened!  I don't want to go to the pit; I don't know what to do!</i>\"");
	outputText("\n\nWhat do you do?");
	//(You could rape her.) //Leads to Rebecc Rape scene. 
	//(You could face the villagers and demons in her stead.) 
	//(You could leave.) //End of quest.
	simpleChoices("Rape Her",createCallBackFunction(rapeRebecc,true),
			"Face Them All", faceDownHordes, "", null, "", null, "Leave", leaveRebeccToBeRaped);
}
//Option: Leave (Z)
private function leaveRebeccToBeRaped():void {
	clearOutput();
	outputText("You tell Rebecc you don't want to have anything to do with her or her sick people and promptly turn around.  She wails and begs you at first but you're faster than the tear-blinded girl, and she soon falls behind.  Your safe, simple camp looms large in your thoughts, pushing out any desire to return to this wicked village and its wicked people.");
	//[Owca Village removed from "Places" menu.]
	outputText("\n\n(Owca has been removed from the places menu.)");
	flags[kFLAGS.OWCA_UNLOCKED] = -1;
	doNext(camp.returnToCampUseOneHour);
}
//Option: Face Down the World (Z)
private function faceDownHordes():void {
	clearOutput();
	outputText("You tell Rebecc to go hide on the plains; you're going to handle the villagers as well as the demon horde on your own.  She cries, \"<i>But " + player.short + "!  You stand no chance against this ruthless horde!  Besides, the villagers won't trust you.  They'll think you want to cheat them... they'll tie you up to prevent you from getting away!</i>\"");
	outputText("\n\nYou tell her not to worry and before her whining protestations can begin, you're already marching toward the village.  As you walk between the tiny houses, people keep staring at you with hostile or even despising eyes.  Some start following you as you walk to the pit, ignoring all the whispers and rumours rumbling about you.  When you're finally standing before the pole, with the whole town gathered around you, you speak in a loud, clear voice.");
	outputText("\n\n\"<i>It is unfair that a young innocent woman should suffer from the cowardice of her townsfolk.  Since you are all too reluctant to defend her yourselves, I'll do it for you.  Don't worry, you meek sheep.  No demon will abuse your kind on my watch.</i>\"  You then ready yourself in a combat stance and wait.");
	outputText("\n\nThe villagers keep staring at you, defiance as well as cautiousness reflected in their pondering eyes.  Caution wins out and they leave you, abandoning to your fate - and the horde.  It's time for you to prove your worth.");
	//Redirects to the Dusk Transition Scene, then to a combat with full equipment and weapons. Loss sets Submissiveness to 100 and gives Bad End.  Victory sets Attitude to 60 and it can never shrink below 1.
	doNext(createCallBackFunction(fightZeDemons,false));
}
//Slave to Vapula - Bad End (Z)
private function slaveToVapulaBadEnd():void {
	clearOutput();
	//[Displayed if Vapula Submissiveness reaches 100]
	outputText("When you wake up, you find yourself tied and gagged in a strange cave.  A pair of smelly red fruits dangle before your eyes, dripping sap.  Chattering and moaning sounds come from everywhere, and your crotch feels numb.  You come back to your senses and realize your mouth is full of cock - the red 'fruits' are actually an imp's balls, and the 'sap' the drippings of a pussy just behind them!  You struggle to remove the rod of dickflesh but there's not much you can do, bound as you are.  Your constant writhing only makes the hermaphrodite imp harder and she grabs a fistful of your hair as she cums, hard.  Her balls shrink even as the sticky vaginal wetness running along their underside swells, and you can feel the veins in her dong pulsate as she unloads an enormous deposit of spooge in your throat; you are forced to swallow the unnaturally hot globs just to clear room to breathe.  Gods, it is so humiliating... yet, somehow, it's also strangely habit-forming.  Each gulp is easier than the last.  You hear an inhuman snicker as the shaft is pulled out, wiped clean of any residual cum by your lips.  The glittering pair of balls is removed from your sight as the imp is pushed aside.");
	outputText("\n\n\"<i>Sooo... my little pet has just woken up.  Are you done gobbling cock yet?</i>\"");
	outputText("\n\nYou sit up uncomfortably, only to see two succubi caressing your crotch and another imp gently licking your " + player.assholeDescript() + "; your vision is suddenly masked by a pair of gratuitous, squishy lips.  They squeeze your own, literally tongue-fucking your mouth.  You abandon yourself to the sweet kiss before recognizing the face behind these gorgeous lips: this is Vapula, the vicious dominatrix from the demon horde!");
	outputText("\"<i>Hmm, so tasty... so tender.  You will make an excellent fuck-pet.</i>\"  She snaps her fingers and in no time you are lifted and carried to a pole very similar to the one in the village, then quickly shackled and bound.  Before you can move, your mouth and your " + player.assholeDescript() + " are already rammed with towering fuck-sticks.  You flutter and tremble, unable to control your body under the intense pleasure you're receiving.  You squirm, you writhe; all you want is more cock to fill you, more cum to be injected in your body.  It feels so right... so powerful to be used like that.  In the back of your mind you see Vapula shuffling the contents of several vials together, preparing some kind of boiling orange mixture.  These rational thoughts are however quickly replaced with dreams of more dickflesh stuffing your insides.");
	outputText("\n\nThe captivating purple succubus approaches you in a sexy manner, doing her best to display her wondrous curves, her appreciable tits and her drooling pussy.  With a disarming smirk, she holds up the vial with her mixture, shaking it before your eyes.");
	outputText("\n\n\"<i>Enough.  Remove that dick from my pet's mouth, I want to talk to " + player.mf("him","her") + " for a second.</i>\"");
	outputText("\n\nYou gasp for air as the imp complies to his mistress's orders, withdrawing his monstrous member to jerk it with his hand instead.");
	outputText("\n\n\"<i>You liked that, didn't you?  I know you did.  Now, you'd better listen to my offer, as it is probably the last question you'll ever have to answer in your new life as a dicksleeve.  Do you want to be a permanent cock-slut?  Do you want to be transformed into a whore, even hungrier for cum than you actually are?  Do you want your every hole to be pumped with more spunk that you'll ever dream of?  Speak, bitch!</i>\"");
	outputText("\n\nWith a violent thrust, the cock ramming your " + player.assholeDescript() + " shoves you into Vapula's arms; you bounce off her delightful tits but she holds you tight, forcibly locking you into an unholy embrace.  Unable to see anything but a pair of voluminous breasts and your nose being impregnated with the sweet, entrancing scent of the succubus' aura, you stare blankly at her, then give the slightest tremble of a nod.");
	outputText("\n\n\"<i>What?  I didn't hear you.  Do you want to have more sex in one hour than some people will ever have in their lifetime?  Do you want your future to be filled with pussy, cock, and boobs?  Do you want it?</i>\"");
	outputText("\n\nYou finally pull your head back from her bosom and manage to mutter a feeble \"<i>Y-yes...</i>\"");
	outputText("\n\n\"<i>What?  I can't hear you.  Say it!  Say it aloud!</i>\"");
	outputText("\n\n\"<i>Yes...</i>\"");
	outputText("\n\n\"<i>Yes what?  Say it!  Say that you want to be my personal cumslut!  Do it!  I want everyone to know that you're willing to be a cum-slave forever!</i>\"");
	outputText("\n\n\"<i>Yes!  YES!  Mistress Vapula, please take me as your slut!  I'm your plaything, your toy!  Please use me in any way you like!  I want nothing more in life than a nice cock in my hole and a drooling pussy to please!  I need cum!  I'm so horny I think my ass is going to explode!</i>\"");
	outputText("\n\nThese spontaneous, dirty words make the imp fucking you from behind instantly cum; with a powerful last push, he blasts you with his seed, filling and soaking your backside with thick white goo.  You reach for Vapula, helplessly hugging her tits and suckling her nipples as you sob in pleasure-induced humiliation.");
	outputText("\n\n\"<i>Very well, slut.  Your former life as a villager is over.  It's time to move on to your new life; and trust me, it's going to be much more exciting.  Actually, I don't think you'll be willing to ever leave this place...</i>\"");
	outputText("\n\nYou furiously nod in approval.");
	getGame().gameOver();
}

//Subdue Vapula Scene - begins Vapula Follower Content(Z)
//[Triggered if submissiveness reaches 0 when beating the horde.] 
private function subdueVapula():void {
	clearOutput();
	outputText("At last, the final demon falls, ");
	if (monster.HP < 1) outputText("overwhelmed by your might");
	else outputText("rendered insensate by his own lust");
	outputText(".  As usual, you walk among the forlorn bodies of your enemies.  Vapula is groveling on the floor again, looking up to you with imploring eyes.  Even beaten and broken, the luscious succubus remains the most preeminent figure of the motley rabble.");
	outputText("\n\nYou grip her by the shoulders and stare at her, asserting your dominance.  Your vanquished foe casts her gaze down but maintains eye contact; she looks solemn and reflective, probably knowing that her fate will depend on your next decision.");
	outputText("\n\nBy now, you've completely broken the back of the rapacious demon horde.  Their leader is starting to get used to her repeated defeats; it's time for you to make a decision... what do you do?");
	//choices: [Disband the horde]/[Enslave Vapula(requires cock or non-centaur vagina, D2 completion, libido >= 60, and corr >= 70)]
	var fuck:Function = null;
	if (player.gender > 0 && (player.lust >= 33 - player.corruptionTolerance())) fuck = rapeZeVapula;
	var enslave:Function = null;
	if (player.gender > 0 && (player.cor >= 66 - player.corruptionTolerance())) enslave = enslaveVapulaWithYourWang;
	simpleChoices("Disband", disbandHorde, "EnslaveVapula", enslave, "JustFuckEm", fuck, "", null, "Skip Out", combat.cleanupAfterCombat);
}
//Option: Disband (Z)
private function disbandHorde():void {
	clearOutput();
	outputText("You start speaking in a calm, measured voice.  \"<i>Here we are again.  I cannot count how often we've been in this same situation: you struggling before me, powerless.  How often do you need to be reminded your place?  Back off.  We don't want your kind here.  Go find some other prey; fuck each other for all I care.  Just stop bothering us.  If I see you or your minions hanging around this village again, you will regret it.  All of you.</i>\"");
	
	outputText("\n\nHer eyes are progressively filling with fear as you deliver your ultimatum, conscious of finding someone with more power than her.  She squirms uncomfortably in your grasp and nods feebly.");
	outputText("\n\nYou give the wanton succubus a loud slap for good measure and discard her.");
	outputText("\n\n\"<i>Begone.  Leave, all of you.  Out of my sight.</i>\"");
	outputText("\n\nShe nods again in acknowledgement and starts shaking her pets out of their torpor.  The imps quickly awaken each other, giving you a few frightened glances every now and then.  Then, a bit pathetically, Vapula gives the retreat signal.  In no time the once-proud bunch disappears, probably gone for good.  Hopefully, the demons have learned from their mistakes and won't bother the village again.");
	//Attitude set to 100
	flags[kFLAGS.OWCAS_ATTITUDE] = 100;
	flags[kFLAGS.OWCA_SACRIFICE_DISABLED] = 1;
	combat.cleanupAfterCombat();
}
//Option: Enslave - penis version (requires D2 completion and libido >= 60 and corr >= 70) (Z)
private function enslaveVapulaWithYourWang():void {
	clearOutput();
	if (!player.hasCock()) {
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
	flags[kFLAGS.VAPULA_FOLLOWER] = 1;
	flags[kFLAGS.OWCAS_ATTITUDE] = 100;
	flags[kFLAGS.VAPULA_HAREM_FUCK] = 1;
	flags[kFLAGS.OWCA_SACRIFICE_DISABLED] = 1;
	//Chance to trigger imp gangbang is increased by 7%!
	//Attitude set to 100, sacrifices will never be asked again. Lust set to 80 if below.
	if (player.lust < 80) player.lust = 80;
	dynStats("lus", 0.1);
	combat.cleanupAfterCombat();
}
//Option: Enslave - vagina version (requires D2 completion and libido >= 60 and corr >= 70 and, apparently, no centaurs)(Z)
//NOTE: No Centaurs. Fuck Centaurs.
private function enslaveVapulaAsACuntWielder():void {
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
	flags[kFLAGS.VAPULA_FOLLOWER] = .5;
	//VILLAGE LOVES YOU + NO MORE SACRIFICES
	flags[kFLAGS.OWCAS_ATTITUDE] = 100;
	flags[kFLAGS.OWCA_SACRIFICE_DISABLED] = 1;
	//Chance to trigger imp gangbang is increased by 7%!
	combat.cleanupAfterCombat();
}
	
}
}
