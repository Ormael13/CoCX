//const TIMES_ENCOUNTERED_FROG:int = 1017;
//Intro
function findTheFrogGirl():void {
	clearOutput();
	if(flags[TIMES_ENCOUNTERED_FROG] == 0) {
		outputText("You begin your trudge through the bog, slogging through the soupy muck.  Insects buzz by every second, spinning in hectic spirals around your head.");
		outputText("\n\nYou soon become aware of a new sound behind the buzzing—a musical chirping.  Step by step, you move toward it, pushing aside hanging curtains of gray moss until the dark trees of the swamp give way to the wide roots of mangroves.  The sporadic notes trickle into your ears, and you feel unusually relaxed as you move toward their source.");
		outputText("\n\nThe wide roots of the trees create separate, tiny ponds, where its looks like condensed water has collected into pools of pristine, blue water.  The chirping echoes from the high walls of mangrove roots, coming from a slim figure seated in the largest pool.  Vaguely feminine, it sits cross-legged and waist-deep in the pool, arms open wide and welcoming.  Light glints off the smooth skin of the lithe form as her lips part, issuing out another stream of alluring, musical notes.");
		outputText("\n\nYou move closer, climbing up a low terrace of crystal-clear pools, your [feet] knocking against the chalk-white wood of the mangrove.  Nearer to the source, the sunlit glare is less intense and the singer comes into sudden focus.");
		outputText("\n\nWith lime green skin and a white underbelly, she most resembles a frog, even down to a slippery sheen coating her from head to toe.  Despite a clearly feminine frame, her pearly-white chest is completely flat and bereft of nipples.  Yellow and red marks pattern her, spotting their way down her limbs.  Her arms end in oddly-wide hands, with broadened circular tips.  One set of fingers tugs back a hanging fringe of pink hair, and large yellow eyes blink brightly at you from beneath it.");
		outputText("\n\nShe purses her lips, blowing out another stream of oddly alluring notes, and they float through the air, wrapping around you head and submerging you in a heady, musical fog.  Despite yourself, you feel your eyes half-close as the musical notes ripple through your brain.");
		outputText("\n\nShe smiles, a three-foot tongue uncoiling from her mouth, trailing down over her flat chest, a patina of slime smearing across her torso.  With one upraised hand, she crooks a finger towards you, beckoning you closer to her pool.");
	}
	else {
		outputText("\n\nWhile exploring the bog, you become aware of a familiar sound behind the buzzing—a musical chirping.  Step by step, you move toward it, pushing aside hanging curtains of gray moss until the dark trees of the swamp give way to the wide roots of mangroves.  The sporadic notes trickle into your ears, and you feel unusually relaxed as you move toward their source.");
		outputText("\n\nThe wide roots of the trees create separate, tiny ponds, where its looks like condensed water has collected into pools of pristine, blue water.  The chirping echoes from the high walls of mangrove roots, coming from a slim, familiar figure seated in the largest pool.  The frog-girl sits cross-legged and waist-deep in the pool, arms open wide and welcoming.  Light glints off the smooth skin of the lithe form as her lips part, issuing out another stream of alluring, musical notes.");
		outputText("\n\nYou move closer, climbing up a low terrace of crystal-clear pools, your [feet] knocking against the chalk-white wood of the mangrove.  Nearer to the source, the sunlit glare is less intense and the singer comes into sudden focus.");
		outputText("\n\nShe purses her lips, blowing out another stream of oddly alluring notes, and they float through the air, wrapping around you head and submerging you in a heady, musical fog.  Despite yourself, you feel your eyes half-close as the musical notes ripple through your brain.");
		outputText("\n\nShe smiles, a three-foot tongue uncoiling from her mouth, trailing down over her flat chest, a patina of slime smearing across her torso.  With one upraised hand, she crooks a finger towards you, beckoning you closer to her pool.");
	}
	flags[TIMES_ENCOUNTERED_FROG]++;
	outputText("\n\nDo you follow the music into the arms of the frog girl, or resist her melody?");
	menu();
	addButton(0,"Follow",followDatFrog);
	addButton(1,"Resist",resistDatFrog);
}

//Follow:
function followDatFrog():void {
	clearOutput();
	outputText("You splash your way up the terrace of pools, shedding your [armor] as you do so, leaving your gear draped over the mangrove ridges.  She holds her arms out to you as you step naked into her pool.  She rises to meet you, and you notice that the water concealed a swollen, pregnant belly.");
	outputText("\n\nHer skin is slimy to the touch, and as she pulls you in close, she leaves her ichor on your arms and [chest].  It tingles where it touches you, and the sunlight seems to grow a bit brighter around you.  Her song continues, and you swear that you can see the music floating in the air, every different note a different neon light drifting through the air.  Half focused, your eyes dart back and forth, tracking the tiny motes of light.");
	outputText("\n\nHer round belly rubs against ");
	if(player.hasCock()) outputText("[eachCock]");
	else if(player.hasVagina()) outputText("your [vagina]");
	else outputText("your bare but sensitive groin");
	outputText(" as she raises her fingertips to your lips.  Entranced by her song, you open your mouth, taking her in.  The thin layer of slime on it tastes citrusy and sweet, and another heady rush clouds your conscious mind.  The colors of her song drift more intensely through the air, and you smile bemusedly as she pushes you back, letting you rest against the root wall, floating comfortably in the water.");
	outputText("\n\nYour arms drape over the lip of the pool as she smiles, stroking your cheek, sending another rush of colors and lights through your head.  Drugged and relaxed, you let your [legs] drift lazily in the pool as the frog girl smiles, biting her lower lip mischievously.");
	outputText("\n\n\"<i>Sorry about the bait and switch, Sparkles, but I need someone else to carry these for me...</i>\" she says, patting her heavy, pregnant belly.  \"<i>But I’m sure you’ll love every minute of it.</i>\"");
	outputText("\n\nHer words raise red flags, and you try to push up against her.");
	outputText("\n\n\"<i>Nope nope nope...</i>\" she coos, her slick hands splayed across your [chest].  Her cool, slippery lips press against yours, and her tongue, slathered in even more hallucinogenic ooze, forces its way into your surprised mouth.  The ridiculously-long organ pushes deep into you, sliding its way down your throat.  You swallow reflexively, taking in a startling large helping of her slimy goo.");
	outputText("\n\nShe pulls away from the kiss, leaving a long strand of saliva between her lips and yours.  The frog girl smirks, and you giggle, wanting to ask her what’s so funny.  Before you can, though, an intense wave of shuddering pleasure roars through you.  Beginning in your [feet], it thunders up through your body, feeling like an orgasm for every nerve ending.  It could be seconds or hours before it reaches your drug-addled brain, but you’re so far beyond counting or caring.");
	outputText("\n\nYou lay back, shuddering in the water, mouth agape as your eyes focus loosely on the frog girl over you.  Your vision is full of colors and as she opens her mouth to sing again, nebulas of colors and sounds saturating the very air.");
	outputText("\n\n\"<i>Feeling better now?</i>\" she asks, as the world dissolves into colors with no name.  Her bizarrely echoes across the surface of the pool.");
	outputText("\n\nCompletely lost in sensation, you pant as you feel slick fingers working at your [asshole], under the water.  Lovely, fluttery sensations accent your high as the frog girl takes a position between your legs.  A cool softness presses against your asshole, and some kind of thick goo adheres it to your twitching hole.");
	outputText("\n\nYou cross and uncross your eyes, trying to focus on the frog girl as she grips your hips adjusting herself.  She’s in some kind of scissoring pose, her pussy glued to your asshole.  With a grunt, she wraps her arms around her pale belly, hugging herself.  You feel her soft pussy twitching against you as something gooey and large pushes against your bud.");
	outputText("\n\n\"<i>Anh!  Unnnh!</i>\" she moans, shuddering and bearing down on her pregnant belly.  A round, gooey mass oozes from her cunt, stretching your asshole as it moves into you.");
	buttChange(30,true,true,false);
	outputText("\n\nYou giggle drunkenly to yourself as a frog egg the size of an apple squeezes inside you.  If you weren’t so lost in mind-bending pleasure, you might be concerned at the pressure.  Instead, you just feel more dizzy - those eggs must be lubed with the frog girl’s slime - and with one inside you, the world begins to spin.");
	outputText("\n\n\"<i>One down...</i>\" the frog girl hisses through gritted teeth.  But you can’t find the wherewithal to even raise an eyebrow at her words.  Pressure builds again against your asshole, and the frog girl pushes another massive, squishy egg into you.  \"<i>Unff!</i>\" she grunts, shaking with the effort of forcing her eggs into your body.");
	outputText("\n\nYou giggle again, loving the way the world spins with every egg fed into you.  Egg after egg, she lays into you.  It’s finally too much for you and your mind collapses.  The world completely dissolves into a swirling collage of color, sensation, and sound.");
	stats(0,0,0,0,0,1,-100,0);
	menu();
	addButton(0,"Next",getFrogButtFilled);
}
function getFrogButtFilled():void {
	clearOutput();
	outputText("You wake up an hour later and it takes a while for you remember anything.  Gradually, you piece the last hour together, remembering the frog girl, her hypnotic song, and hallucinogenic slime.  You’re floating on your back in a crystal-clear pool, and above you, between the mangrove canopies, Mareth’s sky drifting lazily far overhead.");
	outputText("\n\nAnd the eggs.  Oh hell, the eggs!  You splash in the water, righting yourself and looking down at your swollen belly.  You look nine months pregnant!  The frog girl filled you with her eggs and took off leaving you to birth them.  You can’t seem to force them out, either - it looks like you’ll just have to carry these eggs to term.");
	outputText("\n\nWrapping your arms under your heavy belly, you clamber out of the pool.  Water sluices down your naked body, leaving the last of the slime behind you in the no-longer pristine water.");
	outputText("\n\nYou don your [armor] with some difficulty over your massive stomach, and venture back towards your camp, a little sore, but wiser for the ordeal.");
	stats(0,0,0,1,0,0,0,0);
	player.buttKnockUp(23,30,1,1);
	doNext(14);
}

//[Anal stretch +1/Anal Moistness +1, sensitivity +1, int +1]

//Resist:
function resistDatFrog():void {
	clearOutput();
	outputText("You shake your head and drop to the ground, dunking your head in one of the crystal clear pools.  You emerge with your head clear, cold water dripping from your [hair], frowning at the frog girl.");
	outputText("\n\nRealizing that you’ve shaken off her hypnosis, the frog girl gulps, the action producing the curious croaking noise.  As you stomp up the terrace, she scrambles up out of the pool, or at least attempts to.");
	outputText("\n\nShe’s weighed down by a massively pregnant belly, the size of a beachball, pale as the moon and glistening with amphibian slime.  She hauls herself out of deep pool, only to slip back down into it with a splash.");
	outputText("\n\nYou stand at the lip of the pool, and glare down at her, demanding an explanation.");
	outputText("\n\n\"<i>Okay, geeze, sorry,</i>\" she says, holding up her wide-fingered palms.  \"<i>Sorry - I’m done, no harm, no foul.  Be on your way</i>\"");
	outputText("\n\nShe wrinkles up her noseless face and slouches down into the water, sinking down until it reaches the bottoms of her eyes, huffing out a bubbling sigh.");
	outputText("\n\nYou admit to being a bit curious as to Why she attempted to lure you in, but you do have your own tasks at hand.  On the other hand, she did just try to lure you in for unwanted sex.  Are you just going to let her get away with that?  Do you question the frog girl, continue on your way, or teach her a lesson?");
	menu();
	addButton(0,"Question",questDatFrogGirl);
	addButton(1,"TeachLesson",teachDatFrogALesson);
	addButton(4,"Leave",leaveFrogBe);
	
}
//Leave her be:
function leaveFrogBe():void {
	clearOutput();
	outputText("You shrug and leave the pouting frog girl in her pond, hopping back down the terrace of pools and walking back towards your camp, hoping that your [hair] will dry by the time you get back.");
	doNext(13);
}
//Question the frog girl:
function questDatFrogGirl():void {
	clearOutput();
	outputText("You decide to question the pouting amphibian and take a seat at the edge of her pool, asking her why she just tried to lure you in.");
	outputText("\n\n\"<i>I’m pregnant,</i>\" she bubbles shortly, still half-sunk in the pool.  She purses her lips to one side, eyes shifting away from you.");
	outputText("\n\nYou raise an eyebrow, requesting more information than just that.");
	outputText("\n\nShe pulls herself higher out of the water, sliding back down at least twice in the process.  \"<i>Hhhhhhhhhh!</i>\" she sighs, exasperated, reaching behind herself, grabbing the lip of the pool, and lifting herself until the bulge of her stomach rises up like a tiny island.  \"<i>I’m pregnant, and I’m sick of it!</i>\" she snaps, frowning at her belly.");
	outputText("\n\nYou gesture for more information from the cranky, flat-chested mother-to-be.");
	outputText("\n\n\"<i>I produce eggs WAY too quickly,</i>\" she says, idly splashing water over her massive stomach.  \"<i>And they’re always filling me up, and I HATE being heavy and slow.  I can’t even get out of my own pool.</i>\"");
	outputText("\n\n\"<i>So I was gonna...</i>\" she shifts her eyes from side to side quickly, \"<i>...drug you...and then fill up your ass with my eggs.</i>\"  She mumbles the last part quickly, apparently, hoping that you won’t hear it.");
	outputText("\n\nBefore you can react, she adds quickly, \"<i>It wouldn’t hurt you - or the eggs - you’d just carry them for a few days until they hatch.  And then I wouldn’t have to deal with them.  It’s win-win, really!</i>\"");
	outputText("\n\nYou wonder what it would be like to carry the massive load of eggs. Do you want to offer to carry the frog’s eggs or continue on your way?");
	menu();
	addButton(4,"Leave",continueOnYourWay);
	addButton(0,"Carry",carryBeeGirlsEggsVoluntarilyYouButtSlut);
}

//Continue on your way:
function continueOnYourWay():void {
	clearOutput();
	outputText("You nod in sympathy, patting the frog girl on her head, but decide not to inquire any further.  She sighs and sinks down further into the water, resigned to her maternal duties.");
	outputText("\n\nYou leave down the terrace of pools, heading back to your camp.");
	doNext(13);
}

//Offer to carry her eggs:
function carryBeeGirlsEggsVoluntarilyYouButtSlut():void {
	clearOutput();
	outputText("Feeling sympathy for the frog girl, you volunteer to help with her burden.");
	outputText("\n\n\"<i>Omigosh, really?</i>\" she says, lunging forward with a splash.  She throws her arms around your shoulders.  \"<i>I promise to make it absolutely amazing for you.</i>\"");
	outputText("\n\nThe slime on her arms tingles against you, and as she undresses you, peeling away your [armor], she leaves slimy, tingly prints on your arms, stomach, and [chest].  As you watch her, her movements seem to leave trails of light, and the sunlight seems to grow a bit brighter around you.  She hums to herself, and you swear that you can see the music floating in the air, every different note a different neon light drifting through the air.  Half focused, your eyes dart back and forth, tracking the tiny motes of light.");
	outputText("\n\nHer round belly rubs against ");
	if(player.hasCock()) outputText("[eachCock]");
	else if(player.hasVagina()) outputText("your [vagina]");
	else outputText("your bare but sensitive groin");
	outputText(" as she raises her fingertips to your lips.  Entranced by her song, you open your mouth, taking her in.  The thin layer of slime on it tastes citrusy and sweet, and another heady rush clouds your conscious mind.  The colors of her song drift more intensely through the air, and you smile bemusedly as she pushes you back, letting you rest against the root wall, floating comfortably in the water.");
	outputText("\n\nYour arms drape over the lip of the pool as she smiles, stroking your cheek, sending another rush of colors and lights through your head.  Drugged and relaxed, you let your [legs] drift lazily in the pool as the frog girl smiles, biting her lower lip mischievously.");
	outputText("\n\n\"<i>I really do appreciate this...</i>\" she says, massaging her heavy, pregnant belly.  \"<i>And if you end up liking this, I’ll have another batch ready for you in a few days.</i>\"");
	outputText("\n\nHer slick hands splayed across your [chest]. Her cool, slippery lips press against yours, and her tongue, slathered in even more hallucinogenic ooze, forces its way into you waiting mouth.  The ridiculously-long organ pushes deep into you, sliding its way down your throat.  You swallow reflexively, taking in a startling large helping of her slimy goo.");
	outputText("\n\nShe pulls away from the kiss, leaving a long strand of saliva between her lips and yours.  The frog girl smirks, and you giggle, wanting to ask her what’s so funny.  Before you can, though, an intense wave of shuddering pleasure quakes through you.  Beginning in your [feet], it thunders up through your body, feeling like an orgasm for every nerve ending.  It could be seconds or hours before it reaches your drug-addled brain, but you’re so far beyond counting or caring.");
	outputText("\n\nYou lay back, shuddering in the water, mouth agape as your eyes focus loosely on the frog girl over you.  Your vision is full of colors and as she opens her mouth to sing again, nebulas of colors and sounds saturating the very air.");
	outputText("\n\n\"<i>Oooh, you liked that, didn’t you?</i>\" she asks, as the world dissolves into colors with no name.  Her bizarrely echoes across the surface of the pool.");
	outputText("\n\nCompletely lost in sensation, you pant as you feel slick fingers working at your [asshole], under the water.  Lovely, fluttery sensations accent your high as the frog girl takes a position between your legs.  A cool softness presses against your asshole, and some kind of thick goo slathers across your twitching hole.");
	buttChange(20,true,true,false);
	outputText("\n\nYou cross and uncross your eyes, trying to focus on the frog girl as she grips your hips adjusting herself.  She’s in some kind of scissoring pose, her pussy glued to your asshole.  With a grunt, she wraps her arms around her pale belly, hugging herself.  You feel her soft pussy twitching against you as something gooey and large pushes against your bud.");
	outputText("\n\n\"<i>Anh!  Unnnh!</i>\" she moans, shuddering and bearing down on her pregnant belly.  A round, gooey mass oozes from her cunt, stretching your asshole as it moves into you.");
	outputText("\n\nYou giggle drunkenly to yourself as a frog egg the size of an apple squeezes inside you.  If you weren’t so lost in mind-bending pleasure, you might be concerned at the pressure.  Instead, you just feel more dizzy - those eggs must be lubed with the frog girl’s slime - and with one inside you, the world begins to spin.");
	outputText("\n\n\"<i>One down...</i>\" the frog girl hisses through gritted teeth.  But you can’t find the wherewithal to even raise an eyebrow at her words.  Pressure builds again against your asshole, and the frog girl pushes another massive, squishy egg into you.  \"<i>Unff!</i>\" she grunts, shaking with the effort of forcing her eggs into your body.");
	outputText("\n\nYou giggle again, loving the way the world spins with every egg fed into you.  Egg after egg, she lays into you.  It’s finally too much for you and your mind collapses.  The world completely dissolves into a swirling collage of color, sensation, and sound.");
	stats(0,0,0,0,0,1,-100,0);
	menu();
	addButton(0,"Next",voluntarilyGetEggedEpilogue);
}
//**
function voluntarilyGetEggedEpilogue():void {
	clearOutput();
	outputText("You wake up an hour later and it takes a while for you remember anything.  Gradually, you piece the last hour together, remembering the frog girl, her hypnotic song, and hallucinogenic slime.  You’re floating on your back in a crystal-clear pool, and above you, between the mangrove canopies, Mareth’s sky drifting lazily far overhead.");
	outputText("\n\nAnd the eggs.  Oh hell, the eggs!  You splash in the water, righting yourself and looking down at your swollen belly.  You look nine months pregnant!  The frog girl really took you up on your offer and you belly bulges out uncomfortably.  You can’t seem to force them out, either - it looks like you’ll just have to carry these eggs to term.");
	outputText("\n\nWrapping your arms under your heavy belly, you clamber out of the pool.  Water sluices down your naked body, leaving the last of the slime behind you in the no-longer pristine water.");
	outputText("\n\nYou don your [armor] with some difficulty over your massive stomach, and venture back towards your camp, feeling a little sore, but proud of yourself for helping out a mother in need.");
	//[Anal stretch +1/Anal Moistness +1, sensitivity +1, corruption -1]
	player.buttKnockUp(23,30,1,1);
	stats(0,0,0,0,0,1,0,-1);
	doNext(13);
}
//Teach Her a Lesson
function teachDatFrogALesson():void {
	clearOutput();
	outputText("This frog bitch needs to be careful about who she lures in.");
	outputText("\n\nYou say so, and hop down into the water, sinking waist-deep, striding  forward toward the frog girl, grabbing her by the wrist.  Slowed down by her pregnancy, it seems that she can do little to resist.");
	outputText("\n\nYour hand tingles, but that’s not going to stop you from bending this frog girl over and fucking her hard in the purple-orange water... under the trees made out of bread... and with dildos?");
	outputText("\n\nYou stagger back, clutching your head, accidentally smearing the slime on your hand across your face.  Why can you... hear colors?");
	outputText("\n\nThe frog girl glowers at you from across the pool.  She looks like a kaleidoscope of angry colors, all swirling around.  Faster than your eyes can follow, her tongue lashes through the air, slapping wetly into your face.");
	outputText("\n\nThere’s no actual pain to it, just more slime, and you grasp at the edge of the tree pool to steady yourself as the world turns sideways.  You close your eyes for a moment to try to make the world stop spinning, and sink down in the pool.");
	outputText("\n\nWhen you open your eyes again, the frog girl is standing over you.  The sky behind her looks like it’s on fire, and she’s covered in spinning lights.  \"<i>Okay, I’ll admit, I’m a terrible mother, but I’m pretty sure you’d be worse,</i>\" she huffs, slapping her tongue against your face once more.");
	outputText("\n\nColors, lights, and sounds erupt, and you black out, unable to take any more.");
	menu();
	addButton(0,"Next",lessonFollowup);
}

function lessonFollowup():void {
	clearOutput();
	outputText("You wake up two hours later, floating alone in the pool, with a migraine and soggy clothes.  You slog your way out, clutching you head, and head back to camp.");
	//[Toughness -1]
	stats(0,-1,0,0,0,0,0,0);
	doNext(14);
}

//Laying the Eggs
function birthFrogEggsAnal():void {
	outputText("\n<b>Oh no...</b>\nYou groan, feeling a shudder from deep inside, a churning from your gut.  A trickle of slime leaks from your [asshole] down your [legs] and you feel a pressure from deep inside.");
	outputText("\n\nWater - you need to be near water!  The instinct is sudden and clear, and you stagger toward the small creek near your camp.  You crouch low on the river bank, hands on the ground, and knees angled up in an oddly frog-like pose.");
	outputText("\n\nSlime pools beneath you, running down into the water as he first egg begins shoving out of you.  It feels...weird.  The pressure isn’t as intense as some of the things you’ve encountered in Mareth, but it’s still incredibly large.  Your asshole stretches wide, numbed a bit by the slime, but still far larger than you would have thought possible.  As the egg squelches to the ground, you realize that the eggs are jelly-like, and pliant enough to give you some leeway in laying them.");
	outputText("\n\nThe first egg rolls down into the water, anchored by the pooling slime, but you can’t spare it more than a moment’s glance.  The next egg pushes against you, and you groan, shuddering and panting as you try to force it out.  Your asshole aches with every lurch of your body, but finally, the second watermelon-sized egg wobbles free from your ass.  You’re already exhausted as you feel the next one coming, but you manage to force this one out, too, collapsing face-forward onto the ground.");
	buttChange(80,true,true,false);
	outputText("\n\nNature pushes onward, though, and your body works to push the next egg out.  You moan, only half conscious, the frog slime on your skin once again lifting you into a state of hazy awareness as egg after egg pushes out of your body.");
	outputText("\n\n<b>Later, you wake up to the sound of splashing....</b>\nIn the river are a dozen tiny figures, each no more than a foot long, and each one a mirror of the frog girl from the waist-up, but oddly featureless from the waist-down. Their lower halves ending in vaguely-finned tails, like tadpoles.");
	outputText("\n\nThe tadgirls splash each other, playing in the water, but take notice as you wake up.  It seems that they were waiting for you - displaying a level of concern that their original mother lacked.  Maybe they got that from you?  They wave and swim away downstream, and you notice that a few of them have a few unusual splashes of color in their hair and skin, looking a bit more like you than their mother.");
	outputText("\n\nYou nod to yourself, happy to be finished with that ordeal.  As you stand, you notice a bit of heaviness to your hips, and some added slickness to your asshole.\n");
	//[Anal moistness +2, Hips +1]
	player.hipRating++;
	player.ass.analWetness += 1;
	stats(0,0,0,0,0,1,-100,0);
}
