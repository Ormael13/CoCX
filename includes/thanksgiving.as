//Turkey Girl Thanksgiving Special
//By: Savin


/*
Requirements:
Introduction:
Shoo her Off
Let her Approach
Baste Her
Stuff Her
SPITROAST HER! GangHel Style*/

/*Requirements:

-PC has a Dick
-PC has (Dick'd)Izma or Ceraph in camp (to get the Spit Roast scene only)
-Scene proc's at 12:00, overriding other scenes

Note on progression:
   The PC has, after each scene (Baste, Stuff, Spitroast) the option to say \"<i>That's Enough</i>\" or continue on to the next scene -- the scenes must be done in order, however.*/
   
//const TURKEY_FUCK_YEAR_DONE:int = 566;

function isThanksgiving():Boolean {
	return ((date.date >= 21 && date.month == 10) && (date.date < 30 && date.month == 10));
}
   
//Introduction: -McGirt
function datTurkeyRumpMeeting():void {
	flags[TURKEY_FUCK_YEAR_DONE] = date.fullYear;
	outputText("\nYou sit down by your fire pit, looking at the meager provisions you've managed to gather up in the days leading up to the Feast for the Thankful, your village's largest annual feast day.  Right now through the portal, your friends and loved ones from Ingnam are sitting down to a mighty banquet, holding hands in prayer before devouring more food than they can possibly stand.  A pang of homesickness sweeps through you as you look at the small meal before you.  With a sigh, you pick up your fork and prepare to dig in.");
	outputText("\n\nSomething stirs at the edge of camp.");
	
	outputText("\n\nYou jump to your feet, readying your [weapon] for battle as you scan the perimeter.  A moment later, and you see a ponderous figure step out of the shadows behind a large rock.  At first glance, it looks like a normal girl dressed in a simple deerskin poncho, her bright red hair falling past her shoulders to rest on a pair of absolutely massive breasts.  Timidly, she steps forward, giving you a good look at her less human attributes: a pair of avian legs stick out beneath the hem of her clothes, and a large plume of feathers stick up from her big bubble-butt, each red feather nearly reaching the back of her head.  And her breasts... each easily the size of a goblin, so massive that it seems she can barely wobble along.");
	
	outputText("\n\n\"<i>G-gobble?</i>\"  she asks quietly, her big blue eyes pleading at you.");
	
	//[Shoo her Off] [Let her Approach]
	simpleChoices("Let Approach",letZeTurkeyApproach,"Shoo Away",shooTurkeyAway,"",0,"",0,"",0);
}

//Shoo her Off -McGirt
function shooTurkeyAway():void {
	clearOutput();
	outputText("You scowl and wave your arm at the strange turkey-girl, telling her to get lost.");
	
	outputText("\n\n\"<i>G-gobble?</i>\"  she repeats, cocking her head to the side.");
	
	outputText("\n\nRolling your eyes, you yell at the strange girl until she finally gets the idea and; with a few more sorrowful gobbles, she wobbles off again, looking for someone else to bother.");
	
	outputText("\n\nShaking your head, you sit back down and eat.");
	doNext(1);
}

//Let her Approach
function letZeTurkeyApproach():void {
	if(player.gender == 2 || (player.gender == 3 && rand(2) == 0)) {
		femaleLetZeTurkeyGalApproach();
		return;
	}
	clearOutput();
	outputText("Considering her ponderous form, the girl obviously poses no threat.  You wave her over, telling her to come on into camp.  With a huge grin, the turkey-girl wobbles over, her gigantic breasts swaying underneath her moccasins until she plops down beside you.  You try saying hello and introducing yourself, but the girl simply cocks her head to the side and murmurs, \"<i>Gobble?</i>\"");
	
	outputText("\n\nYou raise an eyebrow.  Is that all she can say?");
	
	outputText("\n\n\"<i>Gobble?</i>\"  she asks again, her hand drifting onto your leg.  You feel [eachCock] involuntarily stiffening as her slender, alabaster fingers slide along your thigh.  \"<i>Gobble,</i>\" she repeats, brushing your stiffening prick through your [armor].  Oh, is that what she wants?  Well then....");
	
	//(Baste Her) (That's Enough)
	simpleChoices("Baste Her",basteThatTurkeyBooty,"No Thanks",noThanksTurkeyGal,"",0,"",0,"",0);
}

function noThanksTurkeyGal():void {
	clearOutput();
	outputText("You reluctantly push her away.  You've no need to ram your dick down some new monstrosity's gullet.  The girl forlornly gobbles one last time, then prances off into the fading evening light, globular ass jiggling.");
	doNext(1);
}
//Baste Her -McGirt, reluctantly
function basteThatTurkeyBooty():void {
	clearOutput();
	outputText("You let your cock slip free of your [armor], and immediately the turkey-girl takes it in hand, wrapping her fingers around your thick shaft and giving it a few long, languid strokes.  \"<i>Gobble?</i>\"  she asks, and this time you nod as she leans down toward your cock, her long tongue flicking out to run across the [cockHead], tickling the slit of your urethra as she continues to pump your prick.");
	
	outputText("\n\nHer huge tits pop free as you toss her deerskin poncho aside, the massive orbs falling into your lap around your [cock].  The turkey lowers herself onto your rock-hard rod, wrapping her full red lips around the crown and slurping it up.  You run your fingers through her red hair, guiding her head down along your shaft, pushing more and more of your length past her rosy lips and into the wet vice of her throat.  She gags a moment as your tip brushes past her tonsils, but relaxes in your grip, content to let you slowly stuff the entire length of your cock into her pliant mouth.");
	
	outputText("\n\nWith your [cock] shoved fully into the turkey-girl's mouth, you let her begin to blow you, moving her head up and down your length, her tongue lapping hungrily as the underside of her throat contracts around the shaft, trying to gobble it all up.  You stroke her hair, urging her onwards, enjoying the pleasant tightness of her throat and the ministrations of her tongue.  You let the turkey-girl carry on for a few rapturous minutes, shuddering as her coarse tongue slathers your [cock] with her warm saliva, her lips pressed firmly around the inches of your prick she takes in and out of her mouth, always keeping the thick crown in her mouth, lavishing it with throat-kisses and gentle suckling.");
	
	outputText("\n\nAn idea comes to mind as you begin to feel a knot forming in your [balls].  You grab the turkey-girl's bare, supple shoulders and push her up onto her knees, leaving her kneeling in front of you, a surprised \"<i>Gobble?</i>\"  escaping her lips as your cock pops free.  Time to baste this turkey.");
	
	outputText("\n\nYou stand and grab her titanic tits, hefting them up and pushing them together around your stiff [cock].  You start to buck your [hips] into her soft, yielding titflesh, using her massive mammaries to get yourself off.  Quickly, thick rivulets of pre begin to leak from your crown, smearing onto her breasts as you titfuck the hapless girl.  She lets out a series of alarmed gobbles as you thrust into her chest, but finally gets the idea as your leaking head pokes out from between her mounds and, like a good little cock-gobbler, slurps it back up into her eager mouth.");
	
	outputText("\n\nYou move faster and faster, willing the potent seed surging through your loins out and onto the strange turkey, humping her tits until with a roar of ecstasy you pull out of her mouth and cum. Thick globs of spunk shoot out of you, smearing the turkey-girl's face, the tops of her huge breasts and, from there, leaking down onto her flat stomach and bare thighs.  You continue to thrust between her tits, spurting out the last of your climax onto her neck and chest, utterly covering the turkey-girl with your seed.");
	
	outputText("\n\n\"<i>Gobble!</i>\"  she cries ecstatically, a huge smile playing across her face as she licks up a bit of your cum from her cheek, drinking it up without inhibition.  With a sigh, you let the girl's bosom fall free, leaving your wilting prick in the warm air, content with the powerful face-fucking you've given the eager slut.  You run your hand through her hair again, telling her what a good cock-gobbler she is.");
	
	outputText("\n\n\"<i>G-gobble?</i>\"");
	
	outputText("\n\nThe turkey-girl smiles at you and flops onto her back, spreading her meaty thighs to give you a good look at the trimmed red bush between her legs, and the glistening slit of her vagina.  It looks like she wants some stuffing....");
	stats(0,0,0,0,0,-1,-100,0);
	simpleChoices("Stuff Her",3803,"",0,"",0,"",0,"That'll Do",3805);
}

//Stuff Her -McGirt, this is awful by the way.
function stuffDatTurkeyWithSpoo():void {
	clearOutput();
	outputText("Even though you just came, the sight of such an inviting pussy causes your cock to begin to stiffen again.  You move between the turkey legs, tossing them over your shoulders to give you the best angle on her slick snatch.  You give her an experimental lick, running your tongue across her outer folds.  The girl shivers slightly, a tiny gasp passing her lips as you flick your tongue across her tiny bud.  Spurred on by her cute reactions, you bury yourself between her thighs, lapping at her cunt and clit.  Soon, she's nice and ready, her slit practically leaking her lubricants as you orally assault her, preparing her passage for your stuffing.");
	
	outputText("\n\n\"<i>Gobble?</i>\"  she coos, her fingers slipping down to spread her lips wide as you withdraw, giving you a perfect look at the waiting hole for you fill.  You grin at her and, straightening yourself out, let your [cock] flop onto her crotch, the shaft resting between the lips of her womanhood.  You slide back, letting the [cockHead] of your prick line up with the turkey-girl's tunnel.");
	
	outputText("\n\nAnchoring your fingers around her thick thighs, you ease yourself into the turkey-girl.  A ragged gasp escapes her lips as your turgid [cock] parts her lower lips, sliding through the spit-lubed channel of her cunt with agonizing slowness.  You revel in the tight, slick muscles of her cunt contracting around you, her pussy squeezing down on your invading member as you push further and further into her, nearly tearing her tight slit apart until your crotch presses against hers.");
	
	outputText("\n\n\"<i>G-gobble?</i>\"  the girl asks plaintively, looking over the massive mounds of her breasts to watch the final inches slide into her.  Oh, those do look like inviting targets....");

	outputText("\n\nYou begin to move your hips, slowly rocking a few inches of your cock out and back into the turkey's vice-like sheathe.  Yet your attention turns to the huge, soft orbs of her tits, so large that all but the top of her head is obscured by titflesh.  You reach up, sinking your fingers into one of the huge mounds, angling the large, pink nipple towards you.  A moment passes, your fingers kneading her sensitive breast as you push your cock into her to the hilt.");

	outputText("\n\n\"<i>Gobble,</i>\" the turkey-girl suggests, pushing her mountainous breast toward you, the little nub of her nipple practically brushing your cheek.  You lick your lips and accept the proffered teat, locking your mouth around her large, pale areola.  You run your tongue around the turkey-girl's teat, swirling around the delicate outer flesh before running across the ridges of her stiff nipple.");
	
	outputText("\n\nTo your surprise, something comes out as you suckle from the turkey-girl!  For a moment, you prepare to feast upon a stream of milk from the strange avian, but... it's much too thick, and whatever she's lactating into your mouth tastes like... wait, no.  No way it's actually...");
	
	outputText("\n\n...Gravy?");
	
	outputText("\n\nYou gag a bit as a thick trickle of gravy spills down your throat, now pouring freely from the girl's heavy-laden teats.  She sighs contentedly as you swallow another mouthful of tit-gravy, starting to form a rhythm of sucking sharply between steadily quickening thrusts into her sodden vagina.");

	outputText("\n\nSoft moans begin to echo through the air as you thrust harder and faster into the turkey-girl, lapping up half a gallon of gravy from one of her huge tits before switching to the other, giving her neglected nip the attention it deserves.  You hammer into her, thrusting with enough force to let loose spurts and trickles of femcum and your own pre as the turkey-girl throws her head back in rapture, overwhelmed by the dual sensations.");
	
	outputText("\n\nWith a laugh, you let go of the turkey's tit and bury your face between her mounds, burying yourself in her expansive flesh as ");
	if(player.cumQ() < 1000) outputText("you let loose another load of seed, this time deep into her cunt.  You grunt and growl animalistically, pumping thick gobs of spunk into her until the turkey's womb is practically painted white with your cum.  Each roar sends shudders through her teats, waves of the fatty flesh forming as you cry out into her chest.  You steady yourself between orgasmic thrusts by grabbing onto her melons, your sudden grasp harsh enough to elicit a stream of titgravy from inside her.");
	else outputText("your [cock] distends and bulges.  A startled gasp catches in her throat as the hapless fowl's fuckhole is stretched wider by the oncoming storm.  No sooner has your shaft unloaded a monstrous surge of virile spunk deep inside her cunt than a familiar pressure signals yet another load is on the way.  As you continue to stuff the bitch with baby batter, her once-taut stomach swells outwards, jiggling and gurgling with each fresh load.  Your grunts and growls intermingle with the overstuffed turkey's moans of mindless lust.  Each roar sends shudders through her teats, waves of the fatty flesh forming as you cry out into her chest. You steady yourself between orgasmic thrusts by grabbing onto her melons, your sudden grasp harsh enough to elicit a stream of titgravy from inside her.");
	
	outputText("\n\nSoon, between your kneading out the thick gravy from her breasts and the spunk leaking out from her loins, mixing with what you splattered across her minutes earlier, the poor turkey is absolutely filthy, covered in the remnants of your rough fucking.  Slowly, languidly, you pull out from inside her, your cock still dribbling little rivulets of cum onto the musky girl's thighs.  The air around you now reeks of sex and a warm meal, her strange breastmilk creating a strong aroma of its own below that of drying spooge.");
	stats(0,0,0,0,0,-1,-100,0);
	if(flags[HEL_FUCKBUDDY] == 1 && flags[HEL_REDUCED_ENCOUNTER_RATE] == 0) {
		outputText("\n\nAs you lay atop the turkey, you hear a faint, almost pleading, \"<i>Gobble?</i>\"  from her. Furrowing your brow, you pick yourself up to look at the cum-slathered turkey.  As soon as you're off her, she rolls over onto her hands and knees, her big bubble butt sticking up in the air for you, her plume of feathers tickling your cheeks.  She... still wants more?</i>\"");
		simpleChoices("Spit-Roast",3804,"",0,"",0,"",0,"That's Enough",3805);
	}
	else doNext(thatllDoTurkey);
}

//SPITROAST HER! GangHel Style 
//(Needs friendly/lover Hel)
function spitRoastThatTurkey():void {
	clearOutput();
	outputText("As you contemplate what to do with the insatiable turkey-girl, you hear another rustling at the edge of camp.  For a moment both worried and aroused by the thought of a whole flock of these sluts, you glance up in time to see a certain salamander poking her way through your bevy of traps.");
	
	outputText("\n\n\"<i>Here, Cockgobbler!  Here girl!</i>\" she calls, letting out a sharp whistle that echoes through the camp. \"<i>C'mon out, girl, I know you're --- on hey, lover mine!  Don't suppose you... oh, I see you met my little Cockgobbler,</i>\" Hel laughs, sauntering over.");
	
	outputText("\n\n\"<i>Aww, did you find a juicy little cock, girl?  Was that lots of fun?</i>\" she laughs, scratching the little turkey girl under the chin, talking down to her like a pet.  Looking up to you, she adds, \"<i>Guess she found the best cock around, huh?  Been tracking this little cutey for a couple of days, now.  Real sweetheart; not too bright, though.  Couldn't tell the difference between a gnoll slut and a real cock.  Might just not be too picky, though.  Either way. So, I don--- hey!</i>\"");
	
	outputText("\n\nBefore Hel can finish her sentence, the turkey-girl reaches out and nabs the salamander's tail between her teeth, grabbing it like a worm off the ground.  Though she flails around in confusion for a moment, Hel soon lets out an involuntary shudder as the turkey-girl applies her oral talents to Hel's sensitive tail-end.  \"<i>W-well, if you insist...</i>\"");
	
	outputText("\n\n\"<i>Gobble,</i>\" the turkey says, muffled by the thick tail stuffed in her mouth.");
	
	outputText("\n\nAs Hel moves to straddle the turkey's shoulders, planting her own cunt in front of the avian girl's face, you decide to join in on the fun.  You sink your fingers into the cockgobbler's plump buttocks, kneading her plush ass as you had her tits before.  You give her a little push, letting her rest upon her massive gravytits as you spread her cheeks out, getting a good look at her last unviolated hole.  Grinning, you slip a finger into your mouth, slathering it with as much saliva as you can before pressing the tip against the tight ring of her ass.");
	
	outputText("\n\n\"<i>Mrh?</i>\" the girl mumbles, looking over her shoulder for a split second before Hel grabs her by the hair and puts her back to work. With your partner helpless to stop you, you push in, parting her sphincter with the very tip of your finger before sliding the well-lubricated digit in.  She lets out a muffled gasp, squealing around your lover's mouth-filling member as you push your finger in to the last knuckle, swirling it around in little circles inside her ass.");
	
	outputText("\n\nWhen you've given her all the lubrication you can, you slowly withdraw your finger and grab your [cock], pushing it up between her full buttcheeks.  The turkey-girl makes a pitiful squeak of a \"<i>Gobble!?</i>\" as you press the [cockHead] against her lightly-stretched anus, giving it an extra gob of spittle on the tip as you start to push into her. She's incredibly tight, her poor, defenseless sphincter clamping down hard around your intruding cock as you press the first inches into her, gently guiding yourself into her backdoor.");
	
	outputText("\n\nThe turkey squirms and writhes as you start to slowly buttfuck her, shuddering and mewling at the strange sensations.  Yet every time she tries to move, Hel locks the girl's head back between her legs, keeping the little slut occupied with sucking her tail. Free to continue, you grab the turkey's wide, egg-layer hips and start to fuck her properly, picking up the pace to a powerful rut, pounding her butt with only her jiggly ass to ablate the force of the buttfuck.");
	
	outputText("\n\nYou hammer the turkey-girl's ass, fucking her until she cries out around Hel's tail, screaming an ecstatic combination of lusty moan and her only word.  Now she's getting into it! You grab her auburn hair, yanking her head back as you land a thrust hard enough to send wobbles through her whole body, ripples running through her bubble butt and goblin-sized jugs.  Over her plumage, you hear Hel give out a sharp yelp, and for a moment fear you've made the poor turkey bite down on her -- until you see Hel's eyes rolled back in her head, one hand ravaging her tits and the other furiously masturbating.");

	outputText("\n\nWith a roar, you give the turkey a hard slap on the ass and, with her last violent contraction around your prick, cum.  Thrice already in the last hour, but you manage, pouring another hot load of semen into the turkey's abused anus.  She cries out as you slap her butt, but her scream turns into a long, lewd moan as she feels your seed filling her bum, your prick packing it in until trickles of spooge pour out around your shaft.");
	
	outputText("\n\nYou pull out of her with a wet squelch, grinning as a flood of your spunk starts to pour from her abused asshole, mixing in with the titgravy and two other loads you blew on her previously.  Supported by her huge tits, the turkey-girl goes limp, finally contented by the third fucking, her body stained and completely covered in your cum.  Looking around her, you see Hel lying on her back, snoring quietly after her own tail-based orgasm, her own body coated liberally with femcum and globs of your own spunk that rubbed off on her.");
	stats(0,0,0,0,0,-1,-100,0);
	doNext(thatllDoTurkey);
}

function thatllDoTurkey():void {
	clearOutput();
	outputText("Running your hand through the turkey-girl's hair, you whisper what a good little cockgobbler she is. However, you soon find that the poor thing's passed out, your rut finally over with.  You give her a gentle push over her back, giving you a nice soft tit-pillow to lay your head down upon as you pick up the lunch you'd been preparing to eat before the eager slut arrived.");
	
	outputText("\n\n\"<i>That'll do, turkey,</i>\" you say, patting her jiggling tit. \"<i>That'll do.</i>\"");
	if(player.hasPerk("Pilgrim's Bounty") < 0) {
		player.createPerk("Pilgrim's Bounty",0,0,0,0);
		outputText("\n\n(<b>Perk Gained: Pilgrim's Bounty - Lower lust values no longer reduce the size of your orgasm.</b>)");
	}
	doNext(1);
}

//Let her Approach:
function femaleLetZeTurkeyGalApproach():void {
	clearOutput();
	outputText("Considering her ponderous form, the girl obviously poses no threat.  You wave her over, trying to welcome her to the camp.  With a huge grin the turkey-girl wobbles over, her gigantic breasts heaving beneath her poncho until she plops down beside you.  You try saying hello and introducing yourself, but the girl simply cocks her head to the side.");
	
	outputText("\n\n\"<i>Gobble?</i>\"");
	
	outputText("\n\nYou raise an eyebrow.  Is that all she can say?");
	
	outputText("\n\n\"<i>Gobble?</i>\" This time her question is punctuated by her hand drifting onto your leg.  You feel your body warming slightly as her slender, alabaster fingers slide along your thigh.  \"<i>Gobble.</i>\" She repeats, fingertips brushing against the crotch of your [armor] as she squeezes your thigh gently.");
	
	outputText("\n\nIt looks like you've found yourself a dinner guest...");
	//[Appetiser] [Main Course] [Dessert]
	simpleChoices("Appetiser",turkeyAppetizer,"Main Course",femaleAndTurkeyMainCourse,"Dessert",haveTurkeyGirlDesertInYourCunt,"",0,"",0);
}

//Appetiser:
function turkeyAppetizer():void {
	clearOutput();
	outputText("Biting back a moan as the girl continues to tease you, your own hands reach out to her wrists, reluctantly pulling her hands away and placing them on her own thighs.  She seems disappointed as you shift in your seat, but before she can voice her displeasure you slide up to her, snaking an arm around her back as you start to play with her oversized rack.  She gasps slightly as you heft her plush breasts, kneading and squeezing them as your fingers circle around her hardening nipples.");
	
	outputText("\n\nShe shivers at your attentions, starting to grind her thighs together as you press yourself into her side.  Your fingertips pinch at her nipples, staining the thin clothing covering them with dark, damp patches that slowly spread as you increase the pressure.  She coos as you start to nuzzle her neck, kissing and nipping at her ear as you press yourself harder against her.  She cranes her neck as your tongue traces her earlobe, going limp in your arms as a particularly large dollop of fluid starts to soak completely through her poncho, covering your fingers.");
	
	outputText("\n\nYou groan into the girl's ear as warm fluid drips over your hands, slowly nudging her until she flops backwards atop the log, her legs splaying to lie either side of the wood.  Still sitting upright, you look down at her as you bring a hand to your mouth, eager to taste her milk.  However, as your tongue swirls around your fingers, your eyes go wide; this isn't milk!  The taste is far too savoury, although it is probably one of the best things you've tasted since you entered this realm.  Your brow furrows as you slurp another finger clean of the thick, delicious fluid.  If you didn't know better, you'd have to say that it was some kind of gravy! Then again, considering where you are, maybe that's not so implausible.");

	outputText("\n\nA choked moan rips your attention away from your new discovery and you look back at the source of both the sound and the delicious goo covering your hands.  The turkeygirl has sprawled herself out on the log, the bottom of her poncho flipped up to reveal her severe lack of undergarments.  One hand sits atop her exposed pussy, slowly rubbing in languid circles around her clit whilst her free hand plays with a still-leaking breast.");
	
	outputText("\n\nIt's the sight of her big, beautiful rear that snaps you back into action and you quickly position yourself over the girl, placing a knee between her legs as your hands slide up her juicy thighs.  She coos softly as your knee grinds against her cleft, one of your hands pulling hers away, relocating the reluctant limb to her heaving chest.  Your other hand strokes up and down her feathered thigh, rubbing teasingly close to her needy clit, drawing another low groan from the aroused avian.");
	
	outputText("\n\nHer breathing grows ragged as you press your leg harder into her crotch, feeling her engorging lips beginning to spread slightly at the increased pressure.  Beneath the poncho, her enormous tits jiggle and bounce as her hands furiously tease and squeeze them, plucking at her erect nipples whilst your own hand starts to snake its way under her clothing, trying to get better access to more of her delicious gravy.  As your hand traces its way across her taut stomach her hips start to hump slowly against your leg, rolling back and forth as she tries to brush her throbbing clit against your armoured limb, desperate to relieve her growing lust.");
	
	outputText("\n\nFeeling a little sorry for the horny girl, you slide your thumb briefly over her needy button, her back arching as she cries out at the sudden rush of pleasure.  Her breast strains against the thin poncho as she quivers in excitement, her oversized bust seemingly threatening to burst right out of her modest clothing.  Smirking to yourself, you withdraw your knee from between her legs.  Her hands almost unconsciously start to make the move to her now-neglected netherlips, a low cry of displeasure rumbling out of her mouth, a harsh contrast to her previous, high pitched moan.  However, before her hands can even leave her chest you dart your own in, splaying your fingers across her moist slit.  She bites her lip as your hand slowly starts to circle her aching pussy, her fingers tweaking at her nipples as you spread her own femspunk around her entrance.");

	outputText("\n\nMaking sure to stay away from her erect clit, you continue to tease her entrance.  Her hips once again try to hump against you, but your other hand presses down on her stomach with enough force to hold her back.  Lifting her head to look at you, she whines in displeasure as you keep denying her, her breasts still leaking as she plays with herself.  Your eyes lock with hers and you see the need burning behind them.  Without looking away, you slide two fingers into her warm, wet hole.");
	
	outputText("\n\nShe cries out at the penetration and you feel her tunnel grip your fingers as they try to go deeper inside her.  She stiffens up, moaning and groaning as an orgasm wracks her body, her thighs quaking with pleasure and hands going and breasts bouncing as she gasps in air.  You rest your thumb on her clit as she cums, rapidly rolling over the nub and her hips thrust into your hand, desperate to feel your fingers touch as much of her as they can.  Her nipples jut out through the poncho as she contorts herself, her fingers clamping down on them harshly as the pleasure overwhelms her, causing what could only be called an eruption from each nub.  Gravy spurts out, splattering against her already sodden clothing as you feel the tasty liquid streaking down her body beneath the material.  The warmth spreads across your hand, though it is no match for the heat between your legs as you watch the girl writhing in pleasure.");
	
	outputText("\n\nUnable to stop yourself, you wrench your hand out from beneath her garment and before the girl can tell what's happening, you start to pull it up over her head, finally unleashing those fantastic breasts to the fresh air.  She nearly squawks as you drag her up from her relaxed position to free the material trapped beneath her, but calms down once you manage to get the thing over her head, throwing the soaked cloth out of the way.");
	
	stats(0,0,0,0,0,0,-100,0);
	doNext(femaleAndTurkeyMainCourse);
}


//Main Course:
function femaleAndTurkeyMainCourse():void {
	clearOutput();
	outputText("Fully disrobed, the girl runs her hands down her chest, fingers clamping around her dribbling nipples once again.  Another squeeze gravy is rolling down her chest once more, slathering her fingers with her own mouthwatering juices.  Unable to hold yourself back, your mouth clamps onto her breast, hands shooting to her soft, plush rear as you pull her bodily into your lap.  Her eyes almost light up in her new position, her hands running through your [hair] as you suck for all you're worth.  Her thick, rich gravy fills your mouth with its delicious mix of flavours.  There's so many different, wonderful tastes mixing together that you could almost believe you were back in Ingnam, gorging yourself on the gigantic spread that the village always strives to put on, regardless of how well the harvest went.");
	
	outputText("\n\nYour tongue plays with her nipple as you drink, flicking it to make the girl moan softly whilst your other hand plays with her unattended breast.  Despite her recent orgasm, she still tries to press her dripping pussy against your stomach as you drain her, her head thrown back in bliss as you nibble gently on the hard nub in your mouth.  Feeling your own [vagina] awash with pleasure too, you are, for a moment, torn between continuing to suckle the girl and pulling your lips away to beg her for some attention.  Luckily, as if she can read your mind, one of the turkeygirl's hands extracts itself from your hair and starts to makes its way down your body, cupping your [chest] as she goes.  You moan into her tit as her fingers slip under your waistband, brushing their way tantalizingly across your entrance as she brings her head to rest on your shoulder.");
	
	outputText("\n\nGravy dribbles down your chin as her fingers seek out your slit, teasing you in much the same way you had done to her, something you suddenly find yourself regretting.  Her lithe digits prod at your needy hole, nearly making you thrust against her hand in an attempt to get some contact.  However, the weight of her on you prevents you from making a move, forcing you to withstand her teasing touches as you continue to gorge yourself.  The steady stream of delicious goo starts to wane slightly, the turkeygirl's massive mammaries apparently struggling to keep up with your copious consumption.  You fingers tweak her other nipple absentmindedly, forcing another burst of gravy out of her.  Deciding that it just isn't fair to leave her other tit so very unattended, you move your mouth to the hard, leaking nub, gulping and sucking hard as the liquid fills your mouth once more.");
	
	outputText("\n\nYour stomach begins to swell slightly as her gravy keeps filling you up, giving her body better purchase and making it much easier for her to rub her crotch against you.  The girl begins to moan again at the double sensation of her still-trembling lips rubbing against you and your slight less lewd lips locked firmly onto her sensitive nipple.  Her teasing becomes slightly more insistent as she grinds her slit into you, fingers sliding between your lips with an ever-increasing pace.");
	
	outputText("\n\nHowever, she continues to deny your aching clit, darting around your opening and occasionally dragging a fingertip across your swollen entrance.  Her crotch keeps thrusting into you, each stroke a little harder than the last.  Her arousal clearly has an effect on her breasts, streams of fluid drip from your soaked chin and splatter across her mound as you struggle to contain her delicious lactate, the girl groaning wantonly as warm juice drizzles over her sensitive clit.  Her moans get faster and higher with each thrust against you, her fingers becoming more adventurous, spreading and squeezing you labia, but never dipping into you.");
	
	outputText("\n\nOne of her fingers gently grazes your clit and you almost climax on the spot, your mouth nearly breaking its seal on her nipple.  Gravy spills out of the corners of your mouth as you cry out into her chest, shaking slightly as you struggle to contain yourself.  The girl grunts as you pull her hard against you, her pussy pressing into your stomach hard enough for her clitoris to brush over your armor.  Her grunt explodes into a moan as her body tightens up again, hips thrusting wildly against you as she orgasms a second time, coating your stomach with thick femspunk as her quivering quim drenches you.");
	
	outputText("\n\nThe hand still entwined in your hair pushes your face into her soft, smooth boob, the point of her nipple nearly touching the back of your throat as your maw is filled with titflesh.  Your tongue flicks across her nub, making her still-cumming body shudder with the overload of pleasure.  The fingers between your twitch and form a fist as her body is wracked with sensation, her knuckles sliding against your lips as she struggles to maintain control, keeping away from your needy button but leaving you panting all the same.");
	
	outputText("\n\nYour hands pull her tightly against you, stopping her mad thrusts as her vagina continues to spasm against your taut belly, the contractions so powerful that you can feel them even through your [armor].  She cranes her head back and moans indecently into the air as her legs grip you, almost making you feel like you're about to burst with the pressure.");
	
	outputText("\n\nFinally though, her climax begins to die down.  She holds you close for a few moments, gulping down air after her body-shaking finish.  You continue to drain her breast, though you feel your [vagina] starting to leave a damp patch on the inside of your armour, dripping down your thighs to soak into the log beneath you.  The hand on your head begins to move its way out of your hair, trailing down your neck almost lovingly as her breathing starts to return to normal.  Her touch is almost electric against your skin and you suddenly find yourself very aware of how much your body has been reacting whilst your brain was fixated on her mind-numbingly good goo.");
	
	outputText("\n\nFinally, unable to withstand it any longer, you break you lips away from her teat and push the girl to the ground, your hunger for her body finally having overcome your hunger for her gravy.  She looks up at you with a confused expression to begin with, but once she sees your hands darting to the clasps of your armour, a much more sultry look crosses her features.");
	stats(0,0,0,0,0,0,30,0);
	doNext(haveTurkeyGirlDesertInYourCunt);
}
	
//DESERT
function haveTurkeyGirlDesertInYourCunt():void {
	clearOutput();
	outputText("Barely able to contain yourself, you nearly tear your [armor] from your burning body, desperate to feel the girl with your bare flesh.  She reclines lazily on the ground, legs spreading wide as a hand moves from her dribbling tits, sliding its way down her toned stomach to her swollen lips.  She continues to tease herself whilst you struggle with your clothes, little moans and grunts of pleasure leaving you weak at the knees as she dreamily circles her reddening snatch with a finger.  Her other hand busies itself with her chest, pinching and squeezing just hard enough to release another spurt of gravy that rolls its way down the curve of her breast, dripping onto her belly in a thick glob.");
	
	outputText("\n\nYou finally free yourself of your damned armour, throwing it haphazardly to the ground as your skin finally feels the cool air flow over it, though it does nothing to sate the burning feeling that still threatens to consume you.  The girl's eyes noticeably widen as she takes in your nude body, her reaction making you blush even though it barely affects on your flushed cheeks.  Deciding to put on a little show for your avian acquaintance you drag your hands up from your hips, moving them across your stomach so that they can cup your [chest], tweaking your nipples between the fingers as they slide past.  You moan as you grip the hard nubs, throwing your head back in an exaggerated fashion as your hands keep on going, slipping up your neck to run sensuously through your [hair].  Finally, you turn you eyes back down to the fuckable fowl, shooting her a smouldering look, biting your lip for added effect as a low groan rumbles in your throat.");
	
	outputText("\n\nHer face is as red as yours, hands motionless as she takes in your display.  You can't help but smile at her response, the fact that she's so into your little show having a considerable effect on your own body.  Shifting your hips, you swagger over to her, letting your hands slip down to your nipples once more as you approach.  Your thighs are soaked with your own juices and each step you take brushes them against each other just hard enough to send a shiver of excitement up your back.  You reach the girl and crouch down in between her spread thighs, making sure to stretch your own legs as far apart as possible, eager to display your quivering slit to her as lewdly as you can manage.");
	
	outputText("\n\nShe's panting at you display, her pussy dripping with moisture as you advance on the girl, swinging your legs over her head and spreading her thighs as wide as you can as you come down above her.  She gets the message pretty quickly, her stiff little tongue shooting out to slip across your snatch, a grunt bursting from your mouth just before you can dig into the girl's own moist little hole.");
	
	outputText("\n\nYou recover, though her frantic assault keeps your body wracked with pleasure as you zero in on her pussy.  Your hands keep pushing her thighs apart as they move closer to her snatch, thumbs gently pulling the flushed lips apart to give you a perfect view of her passage.  She moans into you as a breeze blows against her entrance, humping at the air as she whines for you to dig in.");
	
	outputText("\n\nWell, with an offer like that, who could refuse?  Your head dips, tongue digging into her flesh as you give her one obscenely long lick, taking in as much of her taste as possible in one stroke.  Instead of the expected taste of sweat and cum, you find yourself licking your lips as the sweet taste of fresh pumpkin pie assails you.  A few hours ago, this would probably have given you pause, but after gorging yourself on her gravy you simply find yourself digging back into her slit, eager to sample as much of her as you can.");
	
	outputText("\n\nShe moans under your rapid strokes, though her own tongue hardly relents on you entrance, short jabs finally penetrating you as her fingers try to spread your lips as widely as they can, exposing as much of your [vagina] as possible.  You respond in kind, hands sliding under her thighs to come below her drooling slit, spreading wide whilst your pinky fingers tease her tight ring.  She groans in ecstasy as you dig in, her delightful flavour the perfect complement to the savoury soup that even now leaks from her, coating your lower stomach as it rests on her bosom.");
	
	outputText("\n\nHer fingers snake their way around your hips until you can feel them resting just above your clit, poised to strike at any moment.  You realise that even one tap could probably finish you off now and begin to slurp at the turkeygirl's own nub, tongue lapping up as much of her sweet juice as it can manage.  You <b>need</b> to get as much of it as possible before she makes you cum, your mouth clamping down on her vagina, getting right to the source and trying to suck it straight out of her as you swirl your tongue around her button in hopes of making her leak even more.");
	
	outputText("\n\nHowever, the girl must be close and she decides to try and finish you off at the same time.  Her fingers suddenly grasp your clit, pinching it softly whilst her tongue dives deeper than ever before.  You cum almost instantly, you passage quivering around her orgasmic organ, humping against her face as you scream into her mound.  As the sound washes over her entrance, she too starts to cry out, both her holes spasming and you take the opportunity to slip a couple of fingers into her tight rear.");
	
	outputText("\n\nThe intrusion completely pushes her over the edge, leaving the pair of you screaming and humping unashamedly into one another, two tangled, sweat-slicked bodies writhing on the ground and groaning blissfully.  Her pussy covers your face with femspunk, which you waste no time in trying to lick up as you feel your own snatch [if (isSquirter = true) \"drench her face, a muffled 'meep' sounding out from between your legs as the girl weathers a vertiable flood from your twitching tunnel\"][if (isSquirter = false) \"tremble and coat her tongue with fluid, which she quickly drinks down before returning to your soaked hole\"].");
	
	outputText("\n\nAs your orgasm starts to fade, you manage to roll your exhausted body off the turkeygirl, your chest heaving as you try to catch your breath.  You lie there for a few moments, your stretched stomach a testament to how delicious the girl was.  Out of the corner of your eye you notice her shifting and, to your surprise, she lifts herself up from the sodden ground beneath her.  Her body is dripping with remnants of your encounter, but she seems to be no worse the wear after no less than three orgasms!");
	
	outputText("\n\nShe looks down at you, her big eyes sparkling as your own start to close, the exertion of such a vigorous round of sex too much for your stuffed body to take.  Kneeling down beside you, her mouth locks onto yours, kissing you deeply as you push back with your mouth, though even the effort of raising your head is almost too much for you.  One of her hands starts to gently stroke your bulging stomach, slowly circling the tight skin and kneading your sensitive flesh with soft, slow caresses.  Your eyes start to flutter and your head falls back to the ground, breaking the kiss.  Unperturbed, she coos softly at your dazed expression, her head nuzzling into the crook of your neck as her soft touch starts to calm your overworked body down.");
	
	outputText("\n\nHer mouth nips at your neck, tongue flicking your earlobe whilst she continues to moan quietly, your eyes glancing down her body to see her other hand buried firmly between her legs.  Your mouth curls into a smile as you relax completely, feeling safe and content under the caresses of the turkeygirl.  Somehow you can guess that she won't be here when you wake up, but your body is far too relaxed to do anything about it.");
	
	outputText("\n\n<b>One hour later...</b>");
	
	outputText("\nYour eyes crack open, mind still foggy as sleep still clings to the corners of your eyes.  Memories of the insatiable turkeygirl flood back as you start to sit up, dreading the inevitable clean-up after so much spilled fluid.  However, you quickly realise that you're already redressed! In fact, it seems like someone not only dressed you, but both your body and your [armor] are completely spotless, not even a trace of the girl remaining on your person.  Looking around you notice that your campfire still burns brightly, as if someone stoked it recently.  Even your stomach has returned to its previous state, leaving no sign of the massive amount of gorgeous gravy you guzzled not an hour ago.");
	
	outputText("\n\nLurching to your feet, you stretch your arms, feeling completely refreshed after the short nap.  If it wasn't for the sweet taste of pumpkin still lingering on your lips, you'd be prepared to call what had just happened one of the weirdest dreams you've had since arriving in Mareth.");
	
	outputText("\n\nThen again, you have to admit that it would also class as one of the most fun...");
	if(player.hasPerk("Cornucopia") < 0) {
		outputText("\n\n(<b>Gained Perk: Cornucopia - increases vaginal and anal capacities by 30.</b>)");
		player.createPerk("Cornucopia",0,0,0,0,"Get out of here, you dirty hobo!");
	}
	//HP set to full, fatigue to 0?
	fatigue(-100);
	HPChange(3000,false);
	doNext(1);
}
	