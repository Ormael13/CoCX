package classes.Scenes.Areas.Swamp{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.Scenes.Places.TelAdre;

	public class Rogar extends BaseContent{

	public function Rogar()
	{
	}

	private function get telAdre():TelAdre{
		return kGAMECLASS.telAdre;
	}

	/*Ro'gar encounter in the swamp; Ro'gar phase flag = 0 (edited)
((Second Encounter, Ro'gar phase = 1)) (edited)
((Third encounter; Ro'gar phase = 2)) (edited)
((Fourth Encounter)) ([Cloaked Figure] button in Wet Bitch; Ro'gar phase = 3) (edited)
((Fifth encounter, repeatable; Ro'gar phase = 4. Once per day.)) (edited)
[No Thanks]
(([Get Anal], Scenario 1a: give up the buttcherry (buttvirgins only)))
(([Get Anal] Scenario 1b: Get fucked (normal)))
((Scenario 2, [Give Anal]: Fuck Ro'gar))
((Scenario 3, [Drink! (sorta)]: Fun with Bro Brew(Requires one bro brew per visit, uses it and turns player into a Bro)))
((Scenario 4, [Frot]))*/


//flag list:
//Ro'gar phase flag: state 0 - zero phase, initial encounter; 1 - phase 1, bath/BJ chance; 2 - phase 2, Ro'gar begins the move; 3 - phase 3, Ro'gar is a [Cloaked Figure] in the Wet Bitch; 4 - phase 4 repeatables in the bar as [Ro'gar]
//const ROGAR_PHASE:int = 407;
//Dirt Mc Girt flag: state 0 - player has not had the opportunity to tongue-bathe Ro'; 1 - player gently turned down the chance to bathe him; 2 - player bathed Ro'
//Dirt Mc Girt flag legend: 2 = gave tongue bath; 1 = declined to give tongue bath; 0 = was not given the option to tongue bathe; default setting 0
//const ROGAR_DIRT:int = 408;
//Ro'roh Raggy flag: state 0 - Ro'gar perceives player as masculine or androgynous; 1 - Ro'gar perceives player as feminine
//const ROGAR_WARNING:int = 409;
//Crying Game flag: state 0 - Ro'gar events can trigger; 1 - Ro'gar is put off by the PC and will no longer appear
//const ROGAR_DISABLED:int = 410;
//unnamed phase 4 timing flag: measures how long it's been since player last saw Ro'gar once he enters phase 4, to enforce a once-per-day sex limit
//const ROGAR_FUCKED_TODAY:int = 411;

//notes: I'm using the Crying Game flag as an all-purpose Ro'gar lockout, so check it before every possible Ro'gar meeting and prevent swamp scenes and the bar button from loading if present; if Crying Game = 1, no Ro'gar scenes, period
//the reference originates from the half-scene in phase 4 where he can discover you're female or unsexed after already having gotten a BJ from you

//Phase 0: Ro'gar initial encounter in the swamp; Ro'gar phase flag = 0 (edited)
public function encounterRogarSwamp():void {
	clearOutput();
	spriteSelect(86);
	if (flags[kFLAGS.ROGAR_PHASE] == 0) {
		outputText("While wandering through the swamp you hit a patch of soft ground; struggling with your balance, you topple over and find yourself falling face-first into the sodden peat and breaking through.  With a dissatisfied grunt, you manage to squirm upright in the filth, your mud-covered head and arms breaking the surface of the heavy gunk again." + (player.armorDescript() != "gear" ? "You can feel the wet seeping through your clothes, making the fabric stick to your form.  " : "") + "  Before you can wipe the mess from your eyes, the sound of footsteps squelching through the muck draws near, and soon a rough, green hand grips you by the shoulder and pulls you from the bog.  You cough and sputter to get the filth from your mouth, and a large hand pats your back to help.  Through the coughing, you wipe your eyes enough to make out your 'rescuer'.  There stands a hulking figure with olive green skin; he must be easily over seven feet tall, his bald face eyeing you up and down with an expression of interest.  \"<i>Aww, look at'cha.  Didn't like suckin' dirt?</i>\"  The man teases you through a grin that shows off rows of sharp teeth, complete with small tusks that jut over his upper lip.  Despite the grin and hand patting your back, he is far more intimidating than charming.  His strong, large hands move to rest on his hips just above his ragged shorts, puffing his bare chest out proudly.  Your eyes drop from his grin to pass over the swell of his pectorals and clenched muscle-gut, his bulging abdominals like fat fish swimming beneath a sea of green skin.  Further you look, trailing down his body.  Even his bare legs are thick with muscle, and as your eyes pass over his calves the man's voice rumbles from deep within his chest.  \"<i>Ain't ya seen a orc a'fore?</i>\" Even the laugh following resounds with masculinity.  \"<i>I'm Ro'gar, an' I live in this here swamp.  I've lived here most've m'life.  I used ta wrestle gators 'fore they got harder to find.</i>\"\n\n", false);
 		if (flags[kFLAGS.CODEX_ENTRY_ORCS] <= 0) {
			flags[kFLAGS.CODEX_ENTRY_ORCS] = 1;
			outputText("<b>New codex entry unlocked: Orcs!</b>\n\n")
		}	
		//((Corruption less than 70))
		if (player.cor < 70) outputText("You nod at him, wiping at the sludge on your body before frowning at yourself.  Ro'gar rumbles thoughtfully, eyeing you over again.  \"<i>My house's over yonder.  Ain't nobody but m'self 'round here, but I kin find ya somethin' to wipe yer face with.</i>\"  Ro'gar offers his friendly smile again, his formidable rows of teeth defeating the gesture.  Though vainly, you try to ignore the teeth and smile back at the generosity.  Ro'gar's thick finger points to the ground.  \"<i>Ya jus' wait right here an' I'll be back,</i>\" he says as he turns, trotting through the mud casually.  Should you really wait for him?\n\n", false);
 
		//((Corruption 70 or more))
		else {
			outputText("You smile sweetly through the sludge on your face, leaning closer to him.  The orc gives you a confused look as he follows your line of sight.  You couldn't help but notice the equally formidable bulge stretching his ragged shorts obscenely.  It's easy to tell he's still only flaccid yet, as the thick shaft curves over the dark shadow of a cum-swollen sack beneath the damp cloth.  Ro'gar rubs the back of his neck uncomfortably and, despite the awkward exchange, the outline in his shorts begins to lengthen and thicken as he speaks.  \"<i>Listen... yer mighty dirty, an' I reckon I could get you something to clean yerself off with if'n you wait here.</i>\"  Ro'gar's finger points at the ground where you stand.  \"<i>I'll be right back.  You jus' wait.</i>\"  He turns, making his exit quickly.", false);
			if (player.isNaga() || player.tailType > TAIL_TYPE_NONE) outputText("  Your tail flicks about happily.", false);
			outputText("  Should you really wait for him?", false);
		}
		doYesNo(waitForChunkyOrcLoe,dontWaitForRogar);
	}
		//((Ro'gar phase = 1)) (edited)
	else if (flags[kFLAGS.ROGAR_PHASE] == 1) {
		outputText("With map in hand you wander the swamp for some time, squinting at the rough scrawls Ro'gar had scribed for you.  You can't help but stop and scratch your head as you begin to wonder if you are hopelessly lost.\n\n", false);
 
		//((intellect less than 30))
		if (player.inte <= 30) {
			outputText("As hours pass with continued efforts bearing no fruit it becomes clear that you are, in fact, completely lost.  As you wade through some deeper water, the sound of loud splashes and grunting grow louder.  The sound of violence makes your hair stand on end.  You come to a clearing in the swamp, and as you round a large tree trunk you can see two men thrashing in the swamp water.  Both are soaked with filth that drips over every inch of their bodies.  One has his arms locked around the other's neck, and the pinned one snarls and thrashes to get free.  Your eyes widen as you watch the pair wrestle.  During the course of the match you get a wonderful view of the bestial strength each uses to try to make the other submit.  With water making their thickly built bodies slick, your eyes can't help but trace each rivulet of water cascading from their biceps, between clenched abdominals, and down the musculature of their broad backs.  Their massive muscles strain as they grunt and struggle to pin each other down.\n\n", false);
 
			outputText("Eventually one comes out on top, pinning the other to force it to lie down and remain still.  They pant heavy breaths as the overpowered man's exhausted body finally gives in to the victor.  With a nasty snarl the victor grips the defeated body, tossing him a few feet to land in the mud with a splash.  The defeated man slowly struggles to his feet as the winner points his finger and shouts authoritatively.\n\n", false);

			outputText("\"<i>GIT!</i>\"\n\n", false);

			outputText("Your eyes widen as you recognize that voice!  You move from your hiding spot to get closer.  \"<i>Ro'gar?</i>\" You call out as you approach, but slip on a wet root and stumble forward.  Before you feel the wet embrace of mud, strong hands grip you around the chest and right you.\n\n", false);

			outputText("\"<i>Easy there.</i>\"  Ro'gar snickers, letting you go once you're stable.  \"<i>You uh... saw all that?</i>\" he asks, a hint of bashfulness wavering in his voice.  You nod, eyes flicking down across his body just enough to spy something that makes your face flush.  Ro'gar apparently enjoyed the wrestling, enough so that his shorts have tented from his large and full erection, the soaked cloth stretched thin enough you can make out the olive color of his shaft bent painfully in the shorts.  You must have been staring too long, as Ro'gar gives a harsh cough to pull your attention away.  \"<i>It's jus'... territory business.</i>\"  He grunts as he gives you a toothy smile of reassurance.  \"<i>Were ya comin' ta find me?</i>\"\n\n", false);

			outputText("You nod, explaining your situation.  Ro'gar gives a hearty laugh, his stomach shaking with mirth.  \"<i>Poor thing.  Come on, then.  This way.</i>\"  He leads you off in what could be the direction of his hut.  Unfortunately his blatant erection dies down on the way.  You notice his shorts fit much more loosely again by the time you both make it to his hut.\n\n", false);
		}
		//((intellect 30 or more))
		else {
			outputText("It takes some time but you eventually find a hut hidden away in the depths of the swamp.  As you get a good look around it, you see some basic camouflage is being used to hide from the other beasts that lurk the swamp.  If you didn't have the map to know it was here you could have easily passed by it and kept wandering for hours.  You approach the hut, rapping your knuckles against a crude door that seems to be the entrance.  A while passes without answer and with curiosity you try to open the door.  To your surprise, it swings free!\n\n", false);

			outputText("\"<i>Ro'gar?</i>\" you call out into the hut, slowly stepping inside and making sure to close the door behind you.  Despite being in the center of a swamp, there is a familial sense of warmth within the hut.  In a word, it is cozy.  The hut is furnished with basic wooden furniture such as a table, chairs, and a bed.  Though the accoutrements are all crudely made, they certainly appear sturdy.  As you make yourself at home, you run your hand over the smooth surface of the table while you pass it, smelling the smoke of oil candles filling the air as they illuminate the room.  As you move closer to look over the bed, you find it covered in rough cloth.  It looks comfortable, though is noticeably dirty.  Cum stains litter the edge of the bed, matted with thick blotches of dried spunk.  You can still smell the stench of a recent load.", false);
			
			//[(lib > 50)
			if (player.lib >= 50) outputText("  Your loins burn", false);
			else outputText("  Your nose crinkles", false);
			outputText(" at the remains of Ro'gar's pleasure, and you make a mental note that the orc must be lonely.  You figure someone spends many nights entertaining himself here, alone.\n\n", false);
 
			outputText("The door slams open behind you.  With a startled cry you turn to face a very angry Ro'gar in the entrance.  The orc bellows in your direction.  \"<i>WHO- Oh!  It's you!</i>\" His voice slowly dies down as he recognizes you.  \"<i>You... you came?</i>\" he asks, sounding shocked.  You explain how you got here through a startled voice, but the longer you stay in Ro'gar's presence the more comfortable you feel.  By the end of your explanation Ro'gar is grinning wide.  \"<i>Too clever for m'tricks, ain'tcha?  Good ta see ya again.</i>\"\n\n", false);
		}
		//((Intellect paths combine))
		outputText("\"<i>Welcome to my li'l getaway.</i>\"  Ro'gar extends his arms out inside the hut as he welcomes you.  You smile and politely compliment Ro'gar on his cozy domicile.  The orc grins happily before reaching out to grab your shoulders in his strong hands.  \"<i>Have yerself a seat.</i>\"  He pulls out a chair and plops you into it before you can protest.  Once you are successfully plopped, the orc turns to rummage around with things on the other side of the small table.  \"<i>There she is....</i>\"  His deep tone rumbles as he pulls out a large bottle of dark liquid and two mugs.  He sets them on the table with a thud and pops the cork from the bottle, pouring two generous servings before sliding one towards you.  \"<i>Ain't the finest but s'all I got.</i>\"  He nervously smiles, holding his own mug as he watches you.  Whether to appear polite or because you suddenly remember your thirst, you take the mug and sip.  The strong flavor hits your tongue and burns your throat.  You barely refrain from coughing and swallow hard with a gasp.  Ro'gar grins and knocks back his mug with ease as he walks over and sits down on the edge of his bed to face you.  \"<i>It just occurs ta me that I cain't recall yer name.  All this time an' it's slipped my mind ta ask ya.</i>\"  You tell him, and he grins toothily.  \"<i>" + player.short + ", huh?  Nice ta meet'cha.</i>\"\n\n", false);
 
		//((high femininity or breasts >=B-cup, libido 50 or more))
		if (player.biggestTitSize() >= 2 && player.lib >= 50) {
			outputText("As you drink more your mind wanders.  ", false);
			//(Int<30)
			if (player.inte <= 30) {
				outputText("You can feel a heat rising in your groin at the memory of Ro'gar so aroused before.", false);
				if (player.hasVagina()) outputText("  When you witnessed him make that other beast submit with strength alone it created a demanding need in your " + player.vaginaDescript() + " during the match, and the memory is doing much the same now.", false);
				//((if player has cock(s))
				if (player.hasCock()) outputText("  You feel " + player.sMultiCockDesc() + " shift as you remember how hard you got from behind the tree, finding yourself absent mindedly stroking yourself with an open palm as pre-cum soaks through your clothing.", false);
				outputText("  You begin to pleasure yourself discreetly as the memory of the two fighting burns through your mind, trying not to squirm too obviously.  \"<i>Sorry ya had ta see that before.</i>\"  Ro'gar's face flushes lime green as you smile distractedly at him.  \"<i>He was wanderin' too close so I had ta get him ta back off.</i>\"  Ro'gar drinks again from his mug and you reassure him, sliding from your chair and setting your mug upon the table.  Your lips curl into a grin as you ask for a private match...\n\n", false);
			}
			//(int>=30) 
			else {
				outputText("You can see the dried cum stains on the bed from where you sit.  They were thick in the fabric, so much so they could only have been left behind by huge, creamy globs of spunk, the kind you can feel sliding down your throat after a hot, lengthy blowjob.  \"<i>You didn't see much while you was here a'fore me, didj'a?</i>\" Ro'gar asks slowly, his blue eyes peering at you searchingly.  Your own flick to the filthy sheets as you grin, and he coughs in mid-sip of his drink.  \"<i>Been meanin' to clean 'em...</i>\" he says, embarrassed.  You shake your head slowly, rising from your chair to sit next to him, leaning closer and sliding a hand along his powerful leg.  With a devious grin, you ask Ro'gar if he could make you dirty, too.\n\n", false);
			}
			//((lib>50 paths combine, new PG))
			outputText("Ro'gar looks at you and blinks.  He sets his mug aside and smiles.  \"<i>Sorry, honey, but you're not my type.  Mighty kind of ya though.</i>\"  You furrow your brow in disappointment at his rejection.  \"<i>Ya ain't the drinking type are ya?</i>\" he continues.  \"<i>Should'a known this would'a been too strong.  'Pologies.  You should sleep it off.</i>\"  Blinking, you find yourself being gently but quickly removed from Ro'gar's hut.  The door closes behind you with a \"<i>Take care now,</i>\" and you're left standing in the swamp with a bewildered look on your face.  Maybe you did have too much to drink.  You stumble a bit as you make your way to camp, earning another faceful of mud and disappointment on the way.\n\n", false);
			//set Ro'gar phase = 2
			flags[kFLAGS.ROGAR_PHASE] = 2;
			dynStats("lus", 30);
			doNext(camp.returnToCampUseTwoHours);
			return;
		}
		//((high femininity or breasts >=B-cup, libido less than 50))
		else if (player.biggestTitSize() >= 2) {
			outputText("You grin as you chat with Ro'gar mindlessly.  ", false);
			//[(int <30) 
			if (player.inte < 30) outputText("Ro'gar apologizes for wrestling for his territory in your sight.", false);
			//(int>=30) 
			else outputText("Ro'gar apologizes for how messy his hut is.", false);
			outputText("  You just grin and shake your head at his politeness.  \"<i>It's been too long since I got ta talk with any decent folk.</i>\" Ro'gar says, grinning.  Soon you both have empty mugs.  You can't help but sway where you sit from the alcohol, stronger than anything you've had before.  Ro'gar gives a hearty laugh at you, clearly enjoying your inebriated state.  \"<i>You don't look the heavy drinkin' type.</i>\" Ro'gar smirks, as you sway.  Frowning, you assure him that you can handle it, all the while punctuating your sentences with small hiccups which cause the both of you to break out in laughter.  \"<i>Ya know, I've been in this swamp here for so long.  I'm getting' the itch ta go out inta the world and find greener grass, if'n ya know what I'm sayin'.  Listenin' to yer stories about yer travels ain't helpin' none, either.</i>\"  His tone of voice is distant, almost sounding disappointed with himself.  He gets to his feet with a grunt as he rises.  \"<i>Yer lookin' like yer needin' some shut eye.</i>\"  He helps you to your feet; you manage to get your balance somehow and walk to the door.  \"<i>Y'alright?</i>\" he asks, looking you over.  Through a dumb grin you manage to assure him that you're fine.  \"<i>Well allll-right.</i>\"  Ro'gar nods at you as you turn to leave.  \"<i>Ya take care now.</i>\"  He watches you walk off with concern in his eyes, but you make it back to camp just fine.\n\n", false);
			//set Ro'gar phase = 2
			flags[kFLAGS.ROGAR_PHASE] = 2;
			doNext(camp.returnToCampUseTwoHours);
			return;
		}
		//((androgynous or masculine and breasts <= A-cup, libido less than 50))
		else if (player.lib < 50) {
			outputText("You grin as you chat with Ro'gar mindlessly.  ", false);
			//[(int<30)
			if (player.inte < 30) outputText("Ro'gar apologizes for wrestling for his territory in your sight.", false);
			else outputText("Ro'gar apologizes for how messy his hut is.", false);
			outputText("  You just grin and shake your head at his politeness.  \"<i>It's been too long since I got ta talk with any decent folk.</i>\"  Ro'gar says, grinning.  Soon you both have empty mugs.  You can't help but sway where you sit from the alcohol, stronger than anything you've had before.  Ro'gar gives a hearty laugh at you, clearly enjoying your inebriated state.  \"<i>You don't look the heavy drinkin' type.</i>\" Ro'gar smirks, as you sway.  Frowning, you assure him that you can handle it, all the while punctuating your sentences with small hiccups which cause the both of you to break out in laughter.  \"<i>Ya know, I've been in this swamp here for so long.  I'm getting' the itch ta go out inta the world and find greener grass, if'n ya know what I'm sayin'.  Listenin' to yer stories about yer travels ain't helpin' none, either.</i>\" Ro'gar leans back on the bed, lounging as he relaxes.\n\n", false);
 
			outputText("As you look around the hut you notice something you hadn't seen before.  A bucket and towel has been tucked into a corner on the floor.  Reminded of your first encounter by it, you turn to Ro'gar and thank him for helping you out before, which makes him grin in turn.  \"<i>S'no problem at all.  It's easy to make a mess of yerself in this swamp.</i>\"  Ro'gar chuckles softly.  Your eyes wander over the filth caked on his skin; ", false);
			if (player.inte < 30) outputText("leftovers from that fight in the swamp still linger on his body.", false);
			else outputText("it makes you wonder what Ro'gar was up to.", false);
			outputText("  Ro'gar follows your gaze, then his eyes glint oddly as he snickers.  \"<i>Care ta... return the favor?</i>\"  He slyly winks at you, eyes flicking from you to the bucket and back again.", false);
			//goto sexy choices
		}
 		//((androgynous or masculine and breasts <= A-cup, libido >= 50))
		else {
			outputText("As you drink more your mind wanders.  ", false);
			//(int <30) 
			if (player.inte < 30) {
				outputText("You can feel a heat rising in your groin at the memory of Ro'gar so aroused before.", false);
				if (player.hasVagina()) outputText("  When you witnessed him make that other beast submit with strength alone it created a demanding need in your " + player.vaginaDescript() + " during the match, and the memory is doing much the same now.", false);
				if (player.hasCock()) outputText("  You feel " + player.sMultiCockDesc() + " shift as you remember how hard you got from behind the tree, finding yourself absent mindedly stroking yourself with an open palm as pre-cum soaks through your clothing.", false);
				outputText("  You begin to pleasure yourself discreetly as the memory of the two fighting burns through your mind, trying not to squirm too obviously.  \"<i>Sorry ya had ta see that before.</i>\"  Ro'gar's face flushes lime green as you smile distractedly at him.  \"<i>He was wanderin' too close so I had ta get him ta back off.</i>\"   Ro'gar drinks again from his mug, and you explain that it's no problem and shift in your chair before setting your mug on the table.  \"<i>How's about you give me a rubdown then, and I'll give you yer own 'private match'?</i>\"  Ro'gar punctuates this strange request with an odd grin and a rumble in his chest.\n\n", false);
			}
			//(int >=30) 
			else {
				outputText("You can see the dried cum stains on the bed from where you sit.  They were thick in the fabric, so much so they could only have been left behind by huge, creamy globs of spunk, the kind you can feel sliding down your throat after a hot, lengthy blowjob.  \"<i>You didn't see much while you was here a'fore me, didj'a?</i>\" Ro'gar asks slowly, his blue eyes peering at you searchingly.  Your own flick to the filthy sheets as you grin, and he coughs in mid-sip of his drink.  \"<i>Been meanin' to clean 'em...</i>\" he says, embarrassed.  You shake your head slowly and reassure him, which seems to embolden him enough to make the next suggestion.  \"<i>You clean me up a bit, then how's about I get you dirty?</i>\"  Ro'gar's long, orcish tongue flicks over his lips invitingly.\n\n", false);
			}//goto sexy choices
		}
		//SEXY CHOICES
		sexyChoices();
	}
	//Not sure what determines this yet
	else if (flags[kFLAGS.ROGAR_PHASE] == 2) {
		//((high femininity or breasts >=B-cup))
		if (player.biggestTitSize() >= 2) {
			outputText("You travel to Ro'gar's hut using the map again, your memory of the earlier trip making the passage much smoother.  When you knock on the door, though, you receive no answer.  In fact, the hut is eerily silent.  Trying the handle, you find the door unlatched.  You peer inside and discover that not only is it quiet and dark, quite a bit is missing.  Ro'gar is nowhere to be found, along with most of his belongings.  Looking around, you find no sign of distress or struggle.  It doesn't seem like anything happened to him.  Perhaps he moved?  Either way, he's not here now and it doesn't look like he's coming back anytime soon.  As you head back to camp you wonder if you'll ever see him again.", false);
			doNext(camp.returnToCampUseOneHour);
			//move Ro'gar to Wet Bitch, set Ro'gar phase = 3
			flags[kFLAGS.ROGAR_PHASE] = 3;
		}
		//((androgynous or masculine and breasts <= A-cup))
		else {
			outputText("Remembering your way from memory, you find yourself on Ro'gar's doorstep. You gently knock with your fist, and soon you hear footsteps on the other side of the crude door. It opens with a snap and you are greeted with a wide grin of jagged, razor-like teeth.\n\n", false);
			//(Dirt Mc Girt = 2)
			if (flags[kFLAGS.ROGAR_DIRT] == 2) outputText("\"<i>" + player.short + ", y'all took off on me real quick like,</i>\" he says through a snicker.  The joke falls flat and the orc seems to blush lime green as you stare at him uncomprehendingly.  He rubs the back of his neck with a hand before continuing.  \"<i>Sorry about that.  I was plumb tuckered out afterwards.</i>\"\n\n", false);
			//(merge sex and non-sex, new PG)
			outputText("\"<i>Come on in.</i>\"  Ro'gar extends a hand, welcoming you inside.  You quickly take a seat and fold your arms", false);
			if (player.lib > 50) {
				outputText(" over your musk-fueled, growing ", false);
				if (player.hasCock()) outputText("bulge", false);
				else outputText("nipples", false);
			}
			outputText(".  \"<i>I been meanin' ta speak with ya,</i>\" Ro'gar starts, from across the table.  He rests his arms on it and turns his head to face you before he continues.  \"<i>I've been plannin' to git away from this here place for some time now, an' I reckon if'n you didn't come along I'd have just taken off without a clue.</i>\"  He lets out a sigh before continuing. \"<i>I've just been lookin' fer a place to settle in an' be around people that'd be acceptin' of a feller like me.  Y'ever find a place like that?</i>\"  Ro'gar turns his whole body to face you, an expectant look in his eyes.\n\n", false);
			//(If player hasn't been to Tel'Adre)
			if (player.statusEffectv1(StatusEffects.TelAdre) <= 0) {
				outputText("You apologize to Ro'gar; your mind draws a complete blank on the question.  The orc pouts with disappointment.  \"<i>I reckon I could just wander until I find somewhere...</i>\"  You shake your head and suggest he wait here where he's already established, but promise you'll be keeping an eye out for anywhere that might suit him.  Ro'gar beams at the reassurance, his pout twisting into a grin.  \"<i>Mighty fine of you!</i>\"  His thick arms wrap around you in a bear hug over the table.  You spend the rest of your visit chatting with the burly orc, careful to avoid any topics that might stir his wanderlust.\n\n", false);
				//end scene without updating Ro'gar phase
				doNext(camp.returnToCampUseOneHour);
			}
			//(if player has been to Tel'Adre)
			else {
				outputText("You mention a city you have visited before, one that you think a large guy like Ro'gar would fit right into.  As you describe the city of Tel'Adre to him, his face grows more pensive as a large hand wraps around his chin.  \"<i>That's soundin' like a mighty fine place you've been to, though there ain't much water around, huh?</i>\"  You nod your head, somewhat unsettled by the question.  The city is in the middle of a desert, which clearly troubles him despite the determined set of his eyes.  \"<i>Ya reckon I could make the trip?</i>\" \n\n", false);
				//((intellect 30 or more))
				if (player.inte >= 30) {
					outputText("After brainstorming for a few moments you are struck by an idea on how to help him cross the desert.  You explain how the more sensitive natives wear cloaks with hoods to protect themselves from the harsh sun.  \"<i>That's brilliant!</i>\" Ro'gar exclaims, getting to his feet and wrapping his large arms around you in a tight bear hug.  You give out a slight wheeze as he crushes you with excitement.  He eventually lets you go, though your spine tingles from the scent of musky sweat.\n\n", false);
					//<Lust increased very slightly.>
					dynStats("lus", 15);
				}
				//((Intellect less than 30))
				else {
					outputText("Finding yourself stumped for bright ideas you frown.  Ro'gar grunts as fingers thoughtfully rake over his smooth head.  \"<i>If'n I could just avoid the sun...</i>\"  His arms cross over his chest, thick biceps flexing from frustration.  Suddenly you smack your forehead with an open palm as an idea comes to mind!  You suggest Ro'gar travel only at night to avoid the harsh sun.  The orc frowns at you, almost looks like he's considering you to be stupid.  \"<i>I dunno if'n I can travel that fast...  Can't I just wear sumthin' ta keep me in the shade?</i>\"  Well, you have seen some of the city's residents wearing loose, hooded cloaks, which you suggest next.\n\n", false);
				}
				//((int Paths combine here))
				outputText("\"<i>I'll just make me one of those, then.  Err...</i>\"  He gets up from his chair to move around the hut, rummaging through his possessions.  \"<i>I reckon I could fix somethin' up with this....</i>\"  He pulls out a spare pair of bed sheets and begins to cut them crudely with a knife.  You wonder if he intentionally makes everything crudely, or if he doesn't possess the manual dexterity to fashion anything pleasing to the eye.  \"<i>Stupid fabric...  Care to gimme a hand?</i>\" the orc says, coyly smiling in your direction.  Some time passes as you help him, and after quite a bit of sewing, cutting, and teasing, the pair of you make a hooded cloak large enough for Ro'gar's massive frame.  \"<i>How do I look?</i>\" He poses as he tries it on, flexing his muscles as he stands there.  Despite Ro'gar's goofy modeling, the crude mantle makes him look mysterious beneath the fabric, the hood resting just enough over his eyes that it would be hard to tell him apart in a crowd.  The large orc chuckles as you stare at him, and soon you both are laughing.\n\n", false);

				outputText("\"<i>You'll come an' find me, right?  After I get there?</i>\" Ro'gar asks as he puts a hand on your shoulder.  You nod quickly. \"<i>Good, then I'll be seein' you there.</i>\"\n\n", false);
				
				//(if Dirt Mc Girt = 1)
				if (flags[kFLAGS.ROGAR_DIRT] == 1) {
					outputText("You leave Ro'gar to finish packing his things for now.", false);
					//set Ro'gar phase = 3
					flags[kFLAGS.ROGAR_PHASE] = 3;
					doNext(camp.returnToCampUseOneHour);
				}
				//(if Dirt Mc Girt = 2) 
				else {
					outputText("As you exit the door you suddenly feel a strong grip on your wrist, making you turn around.", false);
					//(if player height is shorter than 4 feet) 
					if (player.tallness < 48) outputText("  Hands hook under your armpits to lift you up gently.", false);
					//(if player height is taller than 7 feet)
					if (player.tallness >= 84) outputText("  A hand on your shoulder tugs you to lower your head.", false);
					outputText("  Lips press to yours and you taste Ro'gar's long, orcish tongue flicking out, trying to coax its way into your mouth.  With a faint moan you open wide, locking tongues with him as your eyes close in bliss.  You wrap your arms around the orc's neck in embrace, your hands curling around to hold him near.  His own strong hands carefully settle at your " + player.hipDescript() + " roughly clenching down as his fingertips press over your " + player.buttDescript() + ".  The two tongues wrestle in your mouth before Ro'gar slowly pulls away.  \"<i>Thanks fer everythin', " + player.short + ".  Y'all take care.  I'll be keepin' my eyes peeled for ya.</i>\"  With his usual toothy grin he waves you off.\n\n", false);
				
					outputText("You wander toward your camp through the swamp, making it there without any problems beside the heat in your loins.", false);
				
					//+lust, set Ro'gar phase = 3
					dynStats("lus", 30);
					flags[kFLAGS.ROGAR_PHASE] = 3;
					doNext(camp.returnToCampUseOneHour);
				}
			}
		}
	}
}
 
//((No))
private function dontWaitForRogar():void {
	clearOutput();
	spriteSelect(86);
	outputText("Time passes with no sign of Ro'gar.  You decide it would be a waste of time to sit and wait for him, and head off in hopes of finding something interesting.\n\n", false);
	
	outputText("Instead, you find only more mud.  You return to camp.", false);
	//<set Crying Game = 1>
	flags[kFLAGS.ROGAR_DISABLED] = 1;
	doNext(camp.returnToCampUseOneHour);
}
 
//((Yes))
private function waitForChunkyOrcLoe():void {
	clearOutput();
	spriteSelect(86);
	if (flags[kFLAGS.ROGAR_PHASE] == 0) {
		outputText("It feels like several hours pass with no sign of Ro'gar, but you decide to wait and use what little cloth you have to clean yourself off.  Eventually you hear the slow trod of heavy footsteps as Ro'gar comes into view with a smile on his face and a bucket and towel in his hands.  He sets the steaming bucket down as he draws near.  \"<i>Here ya go!</i>\" he says with a grunt, dipping the towel in the bucket.  He rubs your body with the towel to wipe away the mud for you, seeming not to realize - or perhaps, not minding - the intimacy of the gesture.\n\n", false);
 
		//((If libido is less than 50))
		if (player.lib < 50) outputText("The hulking orc is surprisingly gentle as he cleans you like a young child.  The warm waters and careful touch soothe your tired muscles.  Your skin becomes textured with goose bumps as the tickles of droplets roll down your body and the filth is washed down to the waters below.  You find yourself sighing in relaxation from the treatment.  A smile curls your lips as you look down at Ro'gar, and he returns the pleased look with a toothy smirk.\n\n", false);
		//((If libido is 50 or more))
		else {
			outputText("  Something about the burly orc rubbing you down with warm water excites you.", false);
			if (player.hasVagina()) {
				outputText("  Your " + player.vaginaDescript(0) + " starts to quiver as the warm water rolls over its lips, moistening in excitement as your skin is rubbed over by strong hands.  Your chest heaves as it relaxes to his touch, your " + player.nippleDescript(0) + "s becoming stiff under his rubbing.", false);
				outputText("  Even your " + player.feet() + " and fingers curl as you smell the sweat and musk of Ro'gar's closeness, the animalistic scent arousing you.", false);
			}
			else if (player.hasCock()) outputText("  " + player.SMultiCockDesc() + " stirs to life, making it obvious how much you are enjoying the rub down, then begins to drool with lust.  Through lidded eyes you faintly make out Ro'gar's toothy smirk becoming a hungry grin.", false);
			dynStats("lus", 5 + player.lib/20 + player.sens/20);
			outputText("\n\n", false);
		}
		outputText("\"<i>Clean as a whistle.</i>\"  Ro'gar chuckles as he drops the towel in the bucket with a splash.  His face beams with pride at his work, chest puffing out as he looks you over.  He eyes you up and down again, and your curious look just makes him snicker.  \"<i>Don't meet too many friendly folk 'round here, but it would be nice to have a " + player.mf("feller","lass") + " to talk with.</i>\"  After a few moments of awkward rummaging through his pocket he pulls out a scrunched up piece of paper and hands it to you.  \"<i>This's so you can find me.</i>\"  Ro'gar grins from ear to pointy ear.  You unfold the paper, and see a crudely drawn map that vaguely explains how to get to Ro'gar's hut.  You wonder if making this map was why he took so long.  \"<i>Y'all take care now, y'hear!</i>\" he hollers, turning summarily and walking away, waving over his shoulder at you as he tromps through his natural habitat.  You wander back to your camp, wondering if you should see him again.\n\n", false);
	 
		outputText("<b>You can now find Ro'gar's hut when wandering the swamp occasionally!</b>", false);
		//pass 2 hours, set Ro'gar phase flag = 1
		flags[kFLAGS.ROGAR_PHASE] = 1;
		doNext(camp.returnToCampUseTwoHours);
	}
}

//sexy choices
private function sexyChoices():void {
	spriteSelect(86);
	simpleChoices("Ewww", ewwwRogarIsGay, "NoThnxBro", noSlowBroIDontWantPokeSex, "Lick Clean", okayBroLetsHaveAGayCarwash, "", null, "", null);
}
//((Ewww))
private function ewwwRogarIsGay():void {
	clearOutput();
	spriteSelect(86);
	outputText("Declining in a clipped manner, you get to your feet and make for the door, doing your best to ignore Ro'gar's disappointed face.  He calls out to you, but it only falls on deaf ears as you shut the door quickly behind you, your legs powering through the swamp as you run with all the speed you can muster.  Only once you get back to camp do you realize you've lost the crude map... either in Ro'gar's hut or in the trackless swamp.", false);
	//<set Crying Game = 1>
	flags[kFLAGS.ROGAR_DISABLED] = 1;
	doNext(camp.returnToCampUseTwoHours);
}
 
//((No thanks bro))
private function noSlowBroIDontWantPokeSex():void {
	clearOutput();
	spriteSelect(86);
	outputText("You give a nervous chuckle and politely decline.  Ro'gar's face suddenly droops with disappointment as you explain he's not your type.  \"<i>S'alright.</i>\"  The pair of you share an awkward moment before Ro'gar gives you a toothy grin.  \"<i>Yer always welcome to chat and drink if'n ya want.</i>\"  You smile in return, and the pair of you chat while enjoying a second round of drinks.  Time passes and you decide to leave.  Ro'gar waves you off as you trek through the swamp and back to camp.\n\n", false);
	//<Continue without sex, set Dirt Mc Girt flag = 1 and Ro'gar phase = 2>
	flags[kFLAGS.ROGAR_DIRT] = 1;
	flags[kFLAGS.ROGAR_PHASE] = 2;
	doNext(camp.returnToCampUseTwoHours);
}
 
//((Ok))
private function okayBroLetsHaveAGayCarwash():void {
	clearOutput();
	spriteSelect(86);
	outputText("With haste you retrieve the bucket of water and towel in the corner of the room.  Wasting no time, you dip the towel into the clear water and trail it over the orc's body.  Ro'gar leans back fully, laying over the bed.  He stretches his arms up and tucks them under his head, the hands like large pillows beneath his head as he watches you intently.  Ro'gar's olive skin is caked with the grime of the swamp, though as you drag the wet towel over his body the muck washes away easily.  His chest rumbles a deep, purring tone of pleasure as you work over his abdominal muscles.  Between the dips of his defined six pack and the cleavage of his pectorals you can see the crystalline water collecting.  You audibly gulp, resisting the temptation to lean forward and lick the dribbles of water from his now-clean skin.  \"<i>Careful ya don' touch my skin too much, now...</i>\" Ro'gar rumbles as you work.  Blinking in confusion, you ask why, your hand rubbing the towel over a pectoral of its own volition.  His chest visibly tenses and flexes beneath your thorough hand.  \"<i>Ya really ain't seen many men of the swamp.  There's somethin' in the water  and if'n you spend too much time in it, like myself, it starts ta change yer body.  Ya start leakin' this slime from yer skin.  It's strong stuff.</i>\"  You begin to work over Ro'gar's arm, more conscious of where you touch him, though the rigid protrusion in your groin making it hard to concentrate on anything BUT touching him.  \"<i>Don' worry.  It ain't dangerous.  Jus'...  Well, actually, how's about I give you a taste?</i>\"  Ro'gar looks down at you, his blue eyes unquestionably predatory.\n\n", false);
 
	outputText("You set the towel down with Ro'gar's clean, slick body in front of you.  As you watch the droplets of water travel over his sculpted body, you lean your head down to get a better look.  Up close, his pores can be seen secreting an oil-like liquid over his skin.  Licking your lips, you give his green skin a perfunctory kiss.  His musk is strong, only serving to excite you further as your tongue glides over his flesh, tasting the pheromone-laden oil.  Your eyes widen as the heat hits your mouth, making you pant; you feel your skin tingle and your hair stand on end.  Soon, it hits your loins and you can feel yourself growing painfully aroused" + (player.armorDescript() != "gear" ? " beneath your clothes" : "") + ".  Ro'gar gives you a knowing grin.  \"<i>Go on, there's plenty more where that came from.</i>\"  Arching his back to brush his stomach more over your " + player.face() + ", the slime clings to your skin and causes it to flush with heat.  You let out a moan, feeling its effect and uncontrollably shuddering at the increased sensations across your body.  All of this stirs a hunger deep inside as you lean over to lick your tongue over his abs, coaxing low groans from the orc above.  Your lips caress and kiss over his slick skin, your tongue tracing each twitching muscle.  You know no boundary, tongue digging between each hard bulge.  Your hands reach over to press against his skin, feeling the heat under your fingertips as you rub his built body.  Saliva gleams across his skin in the trails your tongue leaves behind, sliding along his core and toward his pecs.  You lick with hunger between his flexing breasts, hands cupping each one as you massage them under your fingers.  Ro'gar urges you on with deep, guttural moans as you kiss along each twitching mound of muscle.  You suckle and lick over his nipple, causing it to stiffen under your attention.  \"<i>F-fuck yeah. Make it shine, filthy bitch,</i>\" Ro'gar growls as you glance over to notice the swelling bulge in his shorts.  You alternate between lapping at one nipple and flicking and pinching the other with your fingers, driving the orc under you wild.  Looking up at his lust-ridden face makes you smirk.  Spying his exposed arms and pits thrills you further, and you crawl over to dip your face into his armpit and begin to lick around.  Ro'gar gives a surprised gasp, and soon his lips curl into a wicked grin. \"<i>Nasty piggy, give my sweaty pit a big ol' tongue bath.</i>\"  Each breath is a moan into his pit, your mouth and tongue tending to Ro'gar's body dutifully, licking off all of the salty sweat and slime you can find.  Ro'gar's hands slide from behind his head and grip onto the back of yours, nestling into your " + player.hairDescript() + ".\n\n", false);
 
	outputText("\"<i>Ya missed a spot.</i>\"  He shoves your head down to rub your " + player.face() + " over his groin, his tented shorts pressed against your cheek as you moan and lick over the bulge.  Every lick brings another needy groan from Ro'gar, until finally his patience wears thin.  \"<i>Time to get you dirty, pig.</i>\"  He snarls as his free hand yanks down his shorts, kicking them off and exposing himself.  His massive green girth slaps against your " + player.face() + ".  The fat member is thick and easily ten inches long.  He grips the hilt of his gigantic shaft and begins to slap your cheeks with his erection.  \"<i>Piggy's not doing his job.  Gotta clean every last inch of me,</i>\" he teases, smearing his drooling cockhead over your cheeks as your tongue sticks out to catch the dripping length.  You can't help but feel like a hungry whore as you chase Ro'gar's orc cock.", false);
	//[(if player has tail) 
	if (player.hasLongTail() > 0 || player.isNaga()) outputText("  Your tail brushes along Ro'gar's legs eagerly, tickling his thighs as you service him.", false);
	outputText("  Ro'gar presses his fat length against your lips and you immediately dive onto it, licking over the uncut head and kissing along the hefty shaft.  You slip your tongue between his bulbous head and folded flaps of skin, collecting the salty pre-cum pooling there and dipping down to lick over Ro'gar's heavy and swollen cum factories.  You warm them with your mouth as you feel pre-cum dripping down over your " + player.face() + ".  You slide your tongue up to the tip of Ro'gar's cock, taking it into your mouth to suckle on it.  More and more passes your lips as salty pre-cum begins to fill your mouth.  \"<i>Mmf, fuck,</i>\" Ro'gar hisses as your mouth goes down over his meaty length.  He holds your head firmly in place, shifting his hips and thrusting upward as he starts to facefuck you, slapping his pent-up sack against your chin.  He thrusts into your mouth relentlessly, and it's all you can do to keep your lips wrapped tightly around his shaft.  You reach down to touch yourself" + (player.armorDescript() != "gear" ? " under your clothes" : "") + ", rubbing over ", false);
	if (player.hasCock()) outputText(player.sMultiCockDesc(), false);
	else if (player.hasVagina()) outputText("your " + player.vaginaDescript(0), false);
	else outputText("your " + player.assholeDescript(), false);
	outputText(" as Ro'gar penetrates your mouth.  Soon the orc gives out a low groan and slams his cock down your throat, holding you impaled on the green monster as he begins pumping you full of thick seed.  You can feel the heavy spunk sliding down your throat and filling your stomach with each throatful of cum he pumps into you.  Eventually his member slips out of your soaked mouth and blasts the last few ropes out over your " + player.face() + ", 'dirtying' you with a starchy load as he promised.\n\n", false);
	
	outputText("\"<i>F-fuck, yer amazin', " + player.short + "!</i>\" Ro'gar pants heavily as his body lays out on the bed with eyes shut.  Your tongue flicks out against his spent orc cock, licking clean what you can, then you rub the globs of spooge from your " + player.face() + " before popping your cumslicked fingers into your mouth one by one.  You swirl the cum in your mouth before swallowing, the taste of the thick seed clinging to your tongue.  After you're done cleaning yourself and Ro'gar's mess, you notice the orc is snoring.  You chuckle, realizing just how exhausted he must have been.", false);
	//(int <30)
	if (player.inte < 30) outputText("  That fight between him and his opponent went on for quite a while, so it makes some sense.", false);
	outputText("  You smile warmly and plant a kiss wet with cum on Ro'gar's forehead, deciding to let him rest while you collect your things and head back to camp.  Your needy ", false);
	if (player.hasCock()) outputText("erection", false);
	else if (player.hasVagina()) outputText("pussy", false);
	else outputText("ass", false);
	outputText(" aches, each step of the way rubbing the sensitive", false);
	if (player.gender > 0) outputText(", drooling", false);
	outputText(" parts against" + (player.armorDescript() != "gear" ? " the fabric of your clothes" : " your hand") + ".\n\n", false);
	//<Lust increased, slimefeed,
	player.slimeFeed();
	dynStats("lus", 40);
	// set Dirt Mc Girt flag = 2 and Ro'gar phase = 2>
	flags[kFLAGS.ROGAR_DIRT] = 2;
	flags[kFLAGS.ROGAR_PHASE] = 2;
	if (player.inte < 30) doNext(camp.returnToCampUseTwoHours);
	//lose 3 hours instead of 1 if int<30
	else doNext(camp.returnToCampUseOneHour);
}

//((Third phase)) ([Cloaked Figure] button in Wet Bitch; Ro'gar phase = 3) (edited)
public function rogarThirdPhase():void {
	clearOutput();
	spriteSelect(86);
	//Ro'roh Raggy flag is set by how Ro' perceives the PC; in other words, it's toggled by whether the PC is feminine
		
	//((high femininity or breasts >=B-cup, Ro'roh Raggy flag = 0))
	if ((player.biggestTitSize() >= 2)) {
		if (flags[kFLAGS.ROGAR_WARNING] == 0) {
			outputText("Judging the patron's figure based on how imposingly filled out the cloak is, he or she is clearly very muscled.  You spy a green hand reach for a can and a spark of recognition hits you.  You're completely unsure how to break the ice, but tug on the hem of the cloak.  The figure turns toward you, and you're greeted with the green, toothy smile of Ro'gar, the orc from the swamp!  \"<i>H'lo, " + player.short + "!  I'm s'rprised to see ya here...</i>\"\n\n", false);
			if (flags[kFLAGS.CODEX_ENTRY_ORCS] <= 0) {
				flags[kFLAGS.CODEX_ENTRY_ORCS] = 1;
				outputText("<b>New codex entry unlocked: Orcs!</b>\n\n")
			}		
			outputText("You greet him warmly, but he seems a bit nervous around you.  \"<i>Well... after all ya tol' me about yer adventures, I, ah, thought I'd hit the road m'self.  An' so ya find me here.  Good ta see ya again, but I'm just finishin' up my drink afore I head on out.</i>\"  With this, he tips back the contents of his can and flashes you his standard grin, then departs.  He seemed a bit uneasy around you.", false);
			//set Ro'roh Raggy flag to 1
			flags[kFLAGS.ROGAR_WARNING] = 1;
		}
		//(high fem or breasts >=B-cup and Ro'roh Raggy =1)
		else {
			outputText("Ro'gar the orc is here drinking again, but as you catch his eye, a pained expression flashes across his face.  It's clear he doesn't relish the prospect of talking to you right now, but knowing him, he's too polite to say so.  The wind spills from your sails and your icebreaker slips from your mind - answering him with a simple glance of resignation is the most you can manage.  He gives you a weak smile and returns to his drink.\n\n", false);
		}
		
		//return to bar menu
		doNext(telAdre.barTelAdre);
	}
	//((androgynous or masculine and breasts <= A-cup))
	else {
		outputText("After taking a few moments to look over the familiar cloth of the cloak, your lips curl into a small smile.  Walking up quietly, ", false);
		//[(if Ro'roh Raggy flag >=1)
		if (flags[kFLAGS.ROGAR_WARNING] >= 1) {
			outputText("you tap him on the shoulder.  He turns around, then assumes a pleasant smile.  \"<i>Well, h'lo.  Who might you be?</i>\"  Momentarily confused, it quickly comes to you that you were quite different at your prior meetings; you reintroduce yourself with a small bow.  \"<i>Wow.  " + player.short + ", ya look completely different than before!</i>\"  You nod, slightly abashed at having so much attention drawn to your changes, and point out that this world can have some unusual effects on people.  He nods eagerly.  \"<i>Well, ya look jus' great.  How 'bout havin' a sit and chattin' with me fer a while?</i>\"\n\n", false);
		}
		//(else if Ro'roh Raggy < 1 and player height >= 5 feet)
		else if (player.tallness >= 60) {
			outputText("you carefully wrap your arms around the figure's head and cover his eyes with your hands.  A playful giggle escapes your lips as you murmur for him to \"<i>guess who.</i>\"  A familiar voice growls, but quickly relaxes as orcish hands cup over yours.  \"<i>Dag nabbit " + player.short + ", don't sneak up on a feller like that.</i>\"  Ro'gar's low tone fills your ears as he turns to face you with a wide grin.\n\n", false);
		}
		//else if Ro'roh Raggy < 1 and player height < 5 feet)
		else {
			outputText("you gently tug on the figure's cloak, mentioning aloud that it seemed to have held up all right with your sewing job.  The figure's back straightens sharply and a deep snicker is heard.  \"<i>Ya did a mighty fine job, " + player.short + ".  Been waitin' for ya.</i>\"  Ro'gar turns and grins at you.\n\n", false);
		}
		if (flags[kFLAGS.CODEX_ENTRY_ORCS] <= 0) {
			flags[kFLAGS.CODEX_ENTRY_ORCS] = 1;
			outputText("<b>New codex entry unlocked: Orcs!</b>\n\n")
		}	
		//((Paths combine here))
		outputText("Returning the grin with your own, you take a seat next to Ro'gar.  \"<i>It was some trip hoofin' it all the way here, but I reckon it was worth it.</i>\"  His deep, familiar tone soothes your mind.  Ro'gar grips the can off the bar and drinks heavily before exhaling loudly, the container thudding as he rests it on the counter. \"<i>Would have dried up in that sun if not fer this here cloak.</i>\"  His head turns to flash a grin from under the hood.  You carefully reach a hand up to pull it back, wanting to see his face.  Ro'gar flushes lime green at that and turns his head away to scratch at his cheek with a calloused finger.", false);
		//[(if playerskincolor = green)
		if (player.skinTone == "green") outputText("  \"<i>Hey... Have y'ever had somebody randomly run up an' ask ya ta 'Waaagh!'?</i>\" he mutters quietly.  You give him a perplexed look.  The orc laughs off your confusion dismissively.  \"<i>Nothin', nothin'.</i>\"", false);
		outputText("\n\n", false);
		
		outputText("\"<i>Things've been really swell since I got here,</i>\" he continues, artlessly changing the subject.  \"<i>Got my own place, been workin' mah rear off... not to mention the gym.  I've been hittin' that baby when I'm not drinkin' here.</i>\"  He shifts the cloak behind himself and begins flexing for you, confident in his stature as he gives you a show.  It's apparent as he flexes that he's even bigger than he was in the swamp.\n\n", false);

		//variable ending
		//[(if Dirt Mc Girt = 0)
		if (flags[kFLAGS.ROGAR_DIRT] == 0) {
			outputText("You chat for a while longer before separating.  Ro'gar extracts a promise from you to come drink with him again before waving you off with his standard grin.", false);
			//set Ro'gar phase = 4 and Ro'roh Raggy = 0
			flags[kFLAGS.ROGAR_PHASE] = 4;
			flags[kFLAGS.ROGAR_WARNING] = 0;
			doNext(camp.returnToCampUseOneHour);
		}
		//(else if Dirt Mc Girt = 1)
		else if (flags[kFLAGS.ROGAR_DIRT] == 1) {
			outputText("Ro'gar gives a satisfied huff, relaxing his body as he takes another drink from his can.  \"<i>You been nothin' but good ta me ever since I met ya, " + player.short + ".  I do ya one favor and you been a real friend ever since.</i>\"  Ro'gar's tone grows lower and more serious as a calloused finger rubs over his damp can.  You rest your arms against the polished wood of the bar as you listen.  \"<i>Yer special ta me,</i>\" he mutters quietly, just loud enough for you to hear him.  You smile warmly and rest a hand against his arm, coaxing him to turn his head to look at you.  \"<i>Here, I got ya sumthin.</i>\" Ro'gar digs through his pants pocket and pulls out a tin can.  Tugging your hand closer, he puts it in your palm and grins widely at you.  \"<i>It's what I'm drinking now.</i>\"  He taps his can.  \"<i>One've my favorites.  Thanks, " + player.short + ".  You kin drink with me any time.</i>\"  The pair of you spend some time together at the bar, drinking and laughing as you empty mugs.  Eventually you part ways and wander back into the city.\n\n", false);
			//set Ro'gar phase = 4 and Ro'roh Raggy = 0, Acquire 1x Bro Brew
			flags[kFLAGS.ROGAR_PHASE] = 4;
			flags[kFLAGS.ROGAR_WARNING] = 0;
			inventory.takeItem(consumables.BROBREW, camp.returnToCampUseOneHour);
		}
		//(else if Dirt Mc Girt = 2)
		else {
			outputText("Your heart flutters as you realize he is still only wearing the ragged shorts beneath his hooded cloak, and your eyes rake over his musculature as he models.  \"<i>How's about you an' I go visit the baths sometime?</i>\"  Ro'gar asks coyly, relaxing his body as he takes another drink.  \"<i>You been nothin' but good ta me ever since I met ya, " + player.short + ".  I do ya one favor and you been a real friend ever since.</i>\"  Ro'gar's tone grows lower and more serious as a calloused finger rubs over his damp can.  You rest your arms against the polished wood of the bar as you listen.  \"<i>Yer special ta me.</i>\" he mutters quietly, just loud enough for you to hear him.  You smile warmly and rest a hand against his arm, coaxing him to turn his head to look at you.  His tongue slides over his lips as he gives you a seductive stare, with his hand reaching between your legs.", false);
			//[(female or unsexed)
			if (player.gender == 2 || player.gender == 0) {
				outputText("  It stops on your bare mons, and Ro'gar's eyes widen.  \"<i>Wh-wha... there's nothin' here!</i>\"  You color and nod.  His mouth hangs open for a long minute, then he masters himself.  \"<i>Well... I, uh, guess it was good t' see ya again...</i>\" he stammers.  \"<i>Hey, I'm sure you've got things to be doin' so I won't hold you up.</i>\"  As you attempt to protest, he chugs his drink and makes a show of slamming the can down, noisily and forcefully, on the bar.  Nodding at you, he pulls the cloak over his head and leaves the bar.  Apparently it was quite a shock to him.  You wonder if he'll avoid you from now on...", false);
				flags[kFLAGS.ROGAR_DISABLED] = 1;
				doNext(camp.returnToCampUseOneHour);
			}
			else {
				outputText("  " + player.SMultiCockDesc() + " gets a caress from him as he explores, arousing it to mild stiffness.  \"<i>" + player.short + ",</i>\" he grunts.  \"<i>Ah hope ah'll be seein' more of ya.</i>\"  Ro'gar breaks the contact and tips back the remains of his drink while you ", false);
				if (player.cor < 50) outputText("blush", false);
				else outputText("fantasize about those strong hands touching every part of you", false);
				outputText(".  I drink here whenever I'm not werkin' out or on a job.  I'll be waitin' for you.</i>\"  He lowers his eyelids suggestively at you, then gets up; you smile dumbly as he leaves the bar, watching him go with a blush in your cheeks", false);
				//[(If player has a tail)
				if (player.hasLongTail() > 0 && player.isNaga()) outputText(", and you feel your tail flicking rapidly in excitement", false);
				outputText(".\n\n", false);
				//Lust increased, set Ro'gar phase = 4 and Ro'roh Raggy = 0 if M or H, set Crying Game to 1 if F or U]
				flags[kFLAGS.ROGAR_PHASE] = 4;
				flags[kFLAGS.ROGAR_WARNING] = 0;
				dynStats("lus", 30);
				doNext(camp.returnToCampUseOneHour);
			}
		}
	}
}
//((Phase four, repeatable; Ro'gar phase flag = 4. Once per day.)) (all edited)
public function rogarPhaseFour():void {
	if (flags[kFLAGS.CODEX_ENTRY_ORCS] <= 0) {
		flags[kFLAGS.CODEX_ENTRY_ORCS] = 1;
		outputText("<b>New codex entry unlocked: Orcs!</b>\n\n")
	}	
	clearOutput();
	spriteSelect(86);
	//(if high femininity or breasts <=B-cup and Ro'roh Raggy = 0)
	if ((player.biggestTitSize() >= 2) && flags[kFLAGS.ROGAR_WARNING] == 0) {
		outputText("Ro'gar the orc is drinking at the bar again, two crushed cans sitting by his half-empty one.  The bartender is casting irritated glances at them as though she'd like to throw them away, but doesn't dare take them from the enormous, burly orc until he finishes or leaves.  You tug on his cloak as you take a seat next to him, and he turns to you with a toothy smile.  That smile dims to a frown as he looks you over, eyes lingering on the womanly contours of your face", false);
		if (player.biggestTitSize() >= 2) outputText(" and your " + player.chestDesc(), false);
		outputText(".  \"<i>Gee, ya look... different.  Been samplin' some of the local foods, huh?</i>\"  You agree cautiously, and he flags the bartender over and buys you a drink.  \"<i>I'm just bein' polite since we're pals,</i>\" the orc ventures.  \"<i>Ya kin pay me back another time.</i>\"  You nod, sip your drink, and converse reservedly with him for a while, then go on your way.", false);
		//set Ro'roh Raggy = 1
		flags[kFLAGS.ROGAR_WARNING] = 1;
		doNext(camp.returnToCampUseOneHour);
	}
	//(high fem or breasts >=B-cup and Ro'roh Raggy =1)
	else if ((player.biggestTitSize() >= 2) && flags[kFLAGS.ROGAR_WARNING] == 1) {
		outputText("Ro'gar the orc is here drinking again, but as you catch his eye, a pained expression flashes across his face as he looks over your form.  It's clear he doesn't relish the prospect of talking to you right now, but knowing him, he's too polite to say so.  The wind spills from your sails and your icebreaker slips from your mind - answering him with a simple glance of resignation is the most you can manage.  He gives you a weak smile and returns to his drink.", false);
		//return to bar menu
		doNext(telAdre.barTelAdre);
	}
	//(andro or masculine with tits <= A)
	else {
		outputText("Ro'gar is tipping his drink back when he catches sight of you, and waves you over.  \"<i>Ah, good ta see ya, " + player.short + "!", false);
		//[(Ro'roh Raggy = 1)
		if (flags[kFLAGS.ROGAR_WARNING] == 1) {
			outputText("Yer lookin' much better today; ya been workin' out?</i>\"  You smile at the compliment, and ", false);
		}
		else outputText("</i>\"  You ", false);
		outputText("wave the bartender over for another round.  \"<i>So,</i>\" he begins once you've finished your drinks and she's out of earshot, \"<i>I was wonderin' if ya would like to hang out at my place later?  It ain't much, but it'd be a lot more... private... than here.</i>\"  He colors slightly and waggles an eyebrow at you, then slides a hand into your groin.", false);
		//[(if F or U)
		if (player.gender == 2 || player.gender == 0) {
			outputText("  It reaches the center without interruption, and Ro'gar colors deeper.  \"<i>Uh... ferget it,</i>\" he mumbles.  \"<i>Didn't mean ta be indecent with you or anythin', miss.</i>\"  He nods to you and quickly departs before you can recover from the surprise.", false);
			doNext(camp.returnToCampUseOneHour);
		}
		else {
			outputText("  " + player.SMultiCockDesc() + " trembles under his strong touch, as he increases the pressure and looks into your eyes meaningfully.  ", false);
			//[(if Dirt Mc Gurt flag = 1)
			if (flags[kFLAGS.ROGAR_DIRT] == 1) outputText("</i>\"I know ya probably ain't ever imagined hangin' out with a feller like me, but... I could really use the company tonight.</i>\"  ", false);
			outputText("He's clearly in the mood for some fun; do you want to head back to his place and do something?", false);
			//+ lust, if M or H, set Ro'roh Raggy = 0
			flags[kFLAGS.ROGAR_WARNING] = 0;
			//and give choices 
			//[Get Anal][Give Anal][Frot][Drink with your Bro! (requires 1x Bro Brew)][No Thanks]
			rogarFuckMenu();
			dynStats("lus", 10);
		}
	}
}

private function rogarFuckMenu():void {
	spriteSelect(86);
	var getAnal:Function = null;
	var giveAnal:Function = null;
	var frot:Function = null;
	var brodown:Function = null;
        var getTied:Function = null;
	var rubdub:Function = null;
	
	if (player.hasItem(consumables.BROBREW)) brodown = brobrobrobro;
	if (player.hasCock()) {
		giveAnal = fuckRogarsButtPussyBoyCuntManMoundSissySlitQueerQuim;
		getAnal = loseButtGinity;
		frot = frotWithRogar;
		getTied = kinkyWithDaOrc;
		rubdub = rubdubWithDaOrcWithoutDucky;
	}
	menu();
	addButton(0, "GetAnal", getAnal);
	addButton(1, "GiveAnal", giveAnal);
	addButton(2, "Frot", frot);
	addButton(3, "BroDrink", brodown);
	addButton(4, "GetTiedAnal", getTied);
	addButton(5, "OrcRubDown", rubdub);
	addButton(6, "No Thanks", noTHanksRogarIAintGayDudeIjustLickedThatMudToBeNice);
}

//[No Thanks]
private function noTHanksRogarIAintGayDudeIjustLickedThatMudToBeNice():void {
	clearOutput();
	spriteSelect(86);
	outputText("You smile at the orc, but tell him that you're not really in the mood to hang out right now.  He looks crestfallen, but nods at you.  \"<i>Well, I understan'.  I'll be seein' ya later, then.</i>\"", false);
	//Bar menu!
	doNext(telAdre.barTelAdre);
}

//(([Get Anal], Scenario 1a: give up the buttcherry (buttvirgins only)))
private function loseButtGinity():void {
	flags[kFLAGS.ROGAR_FUCKED_TODAY] = 1;
	clearOutput();
	spriteSelect(86);
	//BUTTCHERRIES
	if (player.ass.analLooseness == 0) {
		outputText("You nod eagerly, and the orc rewards you with another caress.  \"<i>Well then... let's head on out,</i>\" he says.  The two of you walk down the desert city's streets until you reach a discrete, out-of-the-way building labeled 'Steel Hogan Apartments'.  \"<i>This here's where I'm stayin',</i>\" Ro'gar says, handing you through the doorway.  He leads you down a hallway to his own lodgings, then pushes open the door for you; you step ", false);
		if (player.cor < 33) outputText("shyly ", false);
		else if (player.cor > 66) outputText("eagerly ", false);
		outputText("over the threshold, and then look around the apartment.  He points out the small kitchen area and then, rather sheepishly, the bedroom.  You're examining it when something catches your eye...\n\n", false);
	
		outputText("You bend over the bed to grip a small bottle lying in the soft fabric of the sheets.  Turning it over, you tilt your head as you read the label.  It's... a bottle of lubricant.  Suddenly, there is a loud thud behind you and the bottle drops from your hand as your torso is pressed into the cushioned surface of the bed.  Something presses into your back.  \"<i>Gotcha...</i>\" the familiar voice snickers in your ear.  Ro'gar's head leans over your shoulder and a long, orcish tongue licks your cheek.  \"<i>Was waitin' for this...</i>\" he purrs; the resonance of his voice rumbles against your ear.  Ro'gar chuckles and grips around your wrists.  \"<i>Now that yer here, it's time ta break in this here new bed with sumthin' I've been cravin' since I washed ya down in that swamp, boy.</i>\"  Ro'gar's tone suddenly takes a demanding, hissing tone.  His tongue flicks over your ear as he speaks.  Your skin begins to grow goosebumps as shivers crawl down your spine.\n\n", false);

		outputText("He yanks your wrists behind your back, ignoring your faint gasps.  With a rustle of cloth, your wrists are bound together behind your back tightly; your fingers feel over the bonds but you struggle against them in vain.  Looking over your shoulder in confusion at Ro'gar, you only see his lust-ridden face dipping down to kiss at your lips.  His tusks press against your cheeks with a demanding snarl and his tongue into your mouth; your " + player.buttDescript() + " receives a smack, forcing you to yelp.  His tongue quickly invades, and his free hand unfastens your " + player.armorName + " to strip you forcefully.  Rough, calloused fingers dance over your body and fasten onto your " + player.nippleDescript(0) + "s, coaxing moans from your throat with each pinch.  Your pleased noises are muffled by Ro'gar's mouth, his tongue and lips hushing each whimper and gasp you breathe.  A bare, firm chest presses against your exposed back, and you pant as the heat from his body burns against you, only intensified by the thin layer of oil on his skin.  Ro'gar's blue eyes watch you like a predator as your face flushes.  He breaks the kiss and cups his hands under your chin to hold your face in place.  \"<i>Such a perdy face yer makin', " + player.short + ".  Yer lookin' at me like a proper slut, an' it's makin' me hard seein' ya so needy to be bred.</i>\"  He growls in his throat as his mouth nips over your neck, leaving red marks along your skin where his tusks rub against you.  You can feel the oil and sweat smearing over your back, and your senses go wild.  The room is soon filled with your needy whimpers as " + player.sMultiCockDesc() + " oozes and throbs against the sheets, making the fabric damp with your lust.\n\n", false);
		
		outputText("With an abrupt grunt you feel hands gripping your " + player.hipDescript() + " and pulling your rear into the air, making you balance on your face and knees.  Ro'gar begins to play with your " + player.buttDescript() + "; each hand massages a cheek between his fingers, squeezing and kneading them apart.  A finger rubs over your sensitive entrance and you shudder softly.  The orc tests its resistance with his finger, pressing in and threatening to penetrate, rubbing harder around the tight, puckered flesh.  Your virgin hole's taut flesh remains resistant to all the coaxing Ro'gar's finger lavishes on it. \"<i>Tarnation, " + player.short + ".  You're so tight...</i>\"  You feel your cheeks blush with bright color and in a low voice you admit you've never had anyone inside you.\n\n", false);
 
		outputText("It's as if time freezes: everything stops, including your erstwhile lover.  The only sound in the room is your own breath for almost half a minute, until Ro'gar rolls you over by your " + player.hipDescript() + ", forcing your body to lay out over your back.  The orc's face comes down close enough that you feel his breath washing over your skin.  \"<i>You serious?</i>\" he asks with eagerness you've never seen before.  Caught off guard, you simply nod your head as his eyes go wide.  With a rip you hear the shorts torn from Ro'gar's body.  You feel his hot, throbbing length grinding over your " + player.buttDescript () + " before you see it, the deep green head towering over your groin menacingly, each vein pulsing as the mammoth cock belches pre-cum to leak down the orcish shaft.  Your skin is soon slick with his spurting pre as he groans out.  \"<i>Oh fuck... a bona-fied virgin ass.  Pure an' untainted, ripe for the pluckin'... or maybe the fuckin'.</i>\"  Ro'gar's breath becomes labored as he pants heavily and eagerly, his green length humping against your virgin rosebud, making you moan out in an excess of sensation.  His hands hold your cheeks apart with a strong grip as you begin to leak your own pre-cum onto your stomach.", false);
		//(if player has balls) 
		if (player.balls > 0) outputText("  Ro'gar's dark green cockhead rubs over your " + player.ballsDescriptLight() + " and coats the plump sack in his musky goo, like an alpha male marking his territory.", false);
		outputText("\n\n", false);
 
		outputText("Deep, guttural hisses echo out from the orc.  \"<i>Easy fella...</i>\" Ro'gar mutters, trying to restrain himself from ripping you apart with his fat cock.  He leans down and kisses you softly before continuing.  \"<i>I'll give ya a proper first time, all gentleman-like.</i>\"  With a playful wink he gets down on his knees, squatting near the foot of the bed.  His hand hoists your " + player.hipDescript() + " up to his mouth.  You can feel him kiss your tight ring, and soon a warm sensation shoots up your spine, causing you to moan.  His hot, slick tongue swirls over your puckered flesh, slathering your hole while his tusks rub along your cheeks.  You're left panting out hot, needy breaths as Ro'gar works over your virgin anus, his tongue gently easing your tight ring of flesh open.  The pleasure makes your legs go limp over his shoulders and your eyes shut in a blissful daze.  Ro'gar's wet slurps and growls make your ears twitch, and you feel him slowly press in with his orcish tongue, beginning to tonguefuck your entrance forcefully.  With patience, your pucker gives in under Ro'gar's touch and his tongue slides into your untouched confines.  You give a sharp gasp, this strange feeling overwhelming you as you flick your eyes open.  Your " + player.buttDescript() + " wriggles in pleasure around his tongue, and the orc gives a pleased grunt as his tongue swirls around your inner walls, sliding out to pull your lime flavor into his mouth before roughly thrusting back in.  Your back arches as you cry out a surprised moan.", false);
		if (player.hasLongTail() || player.isNaga()) outputText("  Your tail wraps around Ro'gar's arm for some sort of stability, the tip flicking lazily as it coils and squeezes around a bicep.", false);
		outputText("\n\n", false);
		
		outputText("Ro'gar produces harsh snarls, eagerly tonguefucking you, eating you out as his lips work over your ass.  His fingers grip your " + player.hipDescript() + " roughly as he ravages your hole in a manner beyond your wildest dreams.  You hear slapping as Ro'gar's hips smack involuntarily against the side of the bed.  His aching erection drools globs of thick slime over the sheets, barely restraining his desire to fuck you senseless.  \"<i>Relax!</i>\" Ro'gar barks in a commanding tone that shocks you.  You try to comply with a whimper, feeling something pressed against you.  Ro'gar's fat finger prods your spit-slicked pucker, slipping in with a wet shlick.  You shudder as his digit slides into you with some resistance, but the relentless finger rubs over your walls as he begins to pull your rim open, forcing another finger inside and making you bite your lip from the stinging sensation.  Working the pair of fingers together inside of you, he slowly moves them apart and stretches your hole wide.", false);
		outputText("  Fingers and " + player.feet() + " curl in pleasure as your previously untouched boycunt is forced open by Ro'gar's steady coaxing.", false);
		outputText("  You hear the pop of a corked bottle, and soon the cool, slippery lubricant pours over your puckered entrance and taint.  After the twin fingers have worked you loose enough a third slides in, the three digits picking up speed as they push in deeper and open you wide.  The strange feeling drives you wild for reasons you don't understand. It just feels so good and new, and your seed pools on your stomach, drolling down your sides to stain the sheets below.  Ro'gar gets up on the bed, looming over your aroused form as his fingers continue pumping into you.  You glance down through the haze of pleasure to see his massive erection.  It seems bigger than you remember, the head leaking a steady stream of spunk to hint at his production.  \"<i>Ready fer yer cherry poppin', boy?  I got you nice and spread.</i>\"  Blue eyes look over your arousal, and you can only shiver under his gaze.  \"<i>I reckon yer enjoyin' yerself,</i>\" he says with a growl, and continues to drive your body wild with lust and strange, new sensations.  \"<i>I've been bidin' my time now, but I'll take that cherry of yers, an' I'm goin' to savor every last drop until ya burst.</i>\"\n\n", false);
		
		outputText("A groan escapes your lips as his fingers slide from your pucker.  His strong hands lift your backside, raising your lubricated hole to a suitable level; you lay completely exposed before him as he shifts his hips to line himself up with your virgin pucker.  The head of his monstrous cock presses against your loosened boycunt, dripping with need as he steadily forces the tight hole.  Your teeth clench as he stretches you wide around his length, though he continues without hesitation, and finally you cry out with the sting of the bulbous head squeezing into your tiny hole, though it falls on deaf ears as Ro'gar merely groans at your virgin tightness.", false);
		player.buttChange(25,true,true,false);
		outputText("  Another whimper escapes your lips as you feel the orc's gigantic cock stretch you much farther than his tongue or fingers.  Despite the pain, your body submits under the girthy cock without a choice, and soon your once-virgin hole is large enough for what will ensue.  \"<i>When I'm done with you, you'll be a proper cock sleeve, boy.  Perfect fer me to breed.</i>\"  He chuckles and licks your face with his warm tongue.  With most of his thick length nestled in you, Ro'gar pulls back to his cockhead only to thrust in again, steadily working more and more of himself inside.  Your whimpers begin to die down and the sting fades with them.  The heat and feeling of his dripping spunk, warm against your walls begin to overwhelm you.  Feeling him claim your untouched insides makes you moan out in bliss.\n\n", false);
 
		outputText("Your mind races with Ro'gar's words as they seemed to be coming true.  You can't help but focus on the wonderful feeling of Ro'gar's cock throbbing within you.  Maybe this is where you belong?  With your tight ass impaled on Ro'gar's massive tool?  You moan loudly as Ro'gar picks up the pace, hips ramming into you with enough force to shift your body over the sheets.  He really starts to break in your hole with huffed grunts and groans as he hilts in you; his cockhead prods your prostate with each thrust, causing you to cry out as electric shocks shoot up your spine.  Every nerve in your body lights up like a Christmas tree and make your entire body squirm with pleasure.  You feel spurts of cum begin to leak from your " + player.multiCockDescriptLight() + " and glaze your belly with pre-cum.", false);
		if (player.hasLongTail() > 0 || player.isNaga()) outputText("  Your tail, still gripping Ro'gar's arm, squeezes tight.", false);
		//(If player has balls) 
		if (player.balls > 0) outputText("  Your " + player.ballsDescriptLight() + " clench sharply as you feel your climax nearing.  \"<i>Found your button, boy,</i>\" Ro'gar snickers as he rubs his cock over your prostate, the hot meat working over your body in ways you didn't even know about.  You feel completely at the large orc's mercy.  \"<i>Cum for me,</i>\" he growls as his lips press over yours, opening your mouth wide as he invades and thrusts his tongue in fellowship with his dick.  His hips pound against you, ballsack slapping your upturned cheeks with each thrust as he rams your trigger over and over.  You moan into the orc's mouth and coat yourself in your own spunk, your brain hazy from the blissful, oozing orgasm.  Your front is dripping with your cum, as Ro'gar continues to abuse your broken-in boycunt.\n\n", false);
		
		outputText("\"<i>So fuckin' tight...</i>\" Ro'gar snarls as he nears his limit.  \"<i>Time fer yer first proper breedin', boy!</i>\"  His voice makes his chest rumble as he pants hot breath that caresses your face.  The sound of smacking skin rings in your ears, and you briefly note that your " + player.buttDescript() + " feels red and sore from Ro'gar's hips beating against them before closing your eyes to another pleasurable thrust.  With a harsh snarl his jaw bites down on your shoulder possessively as his swollen sack tightens.  Soon your lower body is flooded with a warmth you've never felt before.  Ro'gar's seed fills you completely as the musky load coats and stains your once-pure hole.  A pressure builds within you, the wet spunk spurting from your rim to drip down your upturned ass cheeks.  Ro'gar's huffs exit through his clenched teeth as he rides out his orgasm, pumping into you a few more times until he's deposited every last drop from his heavy balls.\n\n", false);
		
		outputText("With a sigh of exhaustion his jaw unlatches from your shoulder and he lies on the bed next to you.  The pair of you take a moment to catch your breath.  The only sounds you hear are the sounds of labored exhalation until Ro'gar sits up.  You hear a clicking nearby and you raise your head to see Ro'gar drinking from a tin can.  Sitting up yourself causes Ro'gar turn to meet your gaze.  \"<i>You don't hafta say anything.  I tend ta get carried away with these kinds'a things.  Hearing 'bout yer virgin ass...  Hoo-wee!</i>\"  He gives a nervous chuckle as you answer with a tired grin.  He unties your hands and takes another sip of his drink.  \"<i>So uh... did ya-</i>\"  The question is interrupted as you peck an affectionate kiss against his tusk, then his lips.  \"<i>Right,</i>\" he laughs and then rubs the back of his neck with a hand.  \"<i>No need for mushy talk then.  You hafta go.  Don't worry, I understand.</i>\" Ro'gar helps you get up and round up your gear, so hastily scattered in his fervor.  He follows you to the door.  \"<i>Take care now, y'hear?  And, " + player.short + "... come see me soon, alright?</i>\"  Ro'gar smiles from the door and waves a hand, watching you leave.  You wander back into the city exhausted.\n\n", false);
		//<Lust sated, slimefeed>
	}
	//(([Get Anal] Scenario 1b: Get fucked (normal)))
	else {
		outputText("You nod eagerly, and the orc rewards you with another caress.  \"<i>Well then... let's head on out,</i>\" he says.  The two of you walk down the desert city's streets until you reach a discrete, out-of-the-way building labeled 'Steel Hogan Apartments'.  \"<i>S'about time you came home with me, " + player.short + ".</i>\"  He pushes the door open and steps inside, disappearing down a hallway.  \"<i>How's about you come siddown?</i>\" he calls, and you follow the sound of his voice.  One of his large hands rests against his leg, which parts from the other to draw your gaze between them.  The orc is already bereft of his tiny shorts, his nude body nestled in a couch and beckoning you over.  His exposed member hangs limp over his impressive sack.  You press your lips together in thought, feeling warmth grow in your loins.\n\n", false);
		outputText("You can't help but feel hesitant as you draw near, but your lusts aren't willing to refuse the offer. You sit astride Ro'gar's leg, with your thighs clasping the mighty muscle that makes up his.  Ro'gar snakes an arm around your waist and tugs you closer, pressing you against his chest.  \"<i>That's a good boy.  Now how's about a kiss?</i>\"  He chuckles as he reaches a hand under your chin, tilting your face to meet his.", false);
		if (player.tallness >= 84) outputText("  You lean down as Ro'gar tilts up, your lips connecting with his, both mouths open to let tongues wrestle.", false); 
		//(If player height is less than 7 feet)
		if (player.tallness < 84) outputText("  You lean up into Ro'gar's mouth, his hand caressing your cheek.", false);
		outputText("  You can feel his demanding tongue pressing into your mouth and coaxing moans from the wanton entrance.  His hand slides down your waist to cup your " + player.buttDescript() + " in his strong grip.  Ro'gar breaks the kiss with a devious grin.  " + (player.armorDescript() != "gear" ? "\"<i>Let's get you out of these clothes.</i>\"  His voice rumbles deep in his chest, the resonations vibrating against your skin.  He takes the initiative and pulls off your garments, leaving you completely nude in his lap.  " : "") + "One of the orc's hands wanders over your body, playing with your nipples while the other slides down toward your " + player.multiCockDescriptLight() + ".  Ro'gar's head nestles in the nape of your neck, gently nipping at your skin and reddening it with a slight sting.  Where he nibbles he quickly follows with a tender lap of warm tongue over the abused flesh, bringing slight shudders through your body as his smooth tusks rub over you.\n\n", false);
		
		outputText("You are left panting for breath from Ro'gar's continued teasing, your skin on fire from every touch as his thin oil smears over it.  You spread your legs lewdly on Ro'gar's lap, blood rushing south as you feel yourself stiffen and throb - though you aren't the only one sporting wood, as you soon feel Ro'gar's hot manhood pressed up to your side.  He groans into your shoulder, bucking his hips to hump your flesh.  Pre-cum dribbles from Ro'gar's swollen cockhead and smears you in his need.  \"<i>Come here,</i>\" he whispers directly into your ear.  His hands grip your bottom as he pulls you closer to face him.  Your chest presses to his as you straddle Ro'gar's hips.  Ro'gar's throbbing ten inches of man meat tucks between the cheeks of your " + player.buttDescript() + ". He gives you a playful wink, bucking his hips to bounce you in his lap.  The feeling of his hot, thick length rubbing over your " + player.assholeDescript() + "  and wetting it with copious pre makes you gasp like a bitch in heat.  The dripping orc spooge snakes down in between your cheeks, and you feel your body shudder with anticipation; Ro'gar lets the liquid pour over his own hard-on.  \"<i>My favorite boy ready for the ride of his life?</i>\"  He grins impishly as he grips the head of his thick, uncut orc cock and pushes it against your boy cunt.  A gasp of pleasure escapes your lips and your hands clasp onto Ro'gar's shoulders, wriggling your " + player.buttDescript() + " over the green mile.\n\n", false);
		
		outputText("With a buck of Ro'gar's hips his slick cockhead slips into your " + player.assholeDescript() + ".  Your lips part wide, letting out a sharp gasp as he nestles within you.  \"<i>Git ridin', boy!</i>\" he barks, with a hard smack against your " + player.buttDescript() + ".  You yelp at the rough treatment, easing yourself down slowly to slide Ro'gar's stiff flesh further into you, and feel yourself growing hard as the throbbing manhood stretches you open.  " + player.SMultiCockDesc() + " swells with blood as it brushes against Ro'gar's stomach, and the sensitive urethra picks up a thin layer of his slime from his skin, making you burn with sensitivity.  Your hips shift into Ro'gar's body more, rubbing your " + player.multiCockDescriptLight() + " tightly against him.", false);
		if (player.cockTotal() > 1) {
			outputText("Lines of pre-cum are drawn with your erections, adulterating the sweat and oil on Ro'gar's body as you bob your hips along Ro'gar's mast.   ", false);
		}
		outputText("Your spunk dribbles over Ro'gar's green skin and collects in his navel as his mouth attacks your neck with an assault of nips and licks, each nibble rubbing his tusks over your sensitized skin.  Hands roughly grip your " + player.buttDescript() + ", spreading your cheeks apart manually and kneading the flesh like dough.  He coaxes you to move faster with demanding nudges of your hips, growling deeply with each thrust of his cock inside you.  Hot fluid sticks to your inner walls, arousal making you buck your hips helplessly as you become more and more sensitive with each thrust.  You're soon bouncing up and down on Ro'gar's prick, and to further your wild ride, Ro'gar begins bucking his hips up to meet your " + player.buttDescript() + ".\n\n", false);
	
		//[(If player is fat or has very defined muscles)
		if ((player.thickness >= 75 && player.tone < 33) || player.tone >= 75) {
			outputText("Riding Ro'gar's stiff manhood as fast as you can muster, you drive the orc man wild with need.  His thick girth stretches your " + player.assholeDescript() + " wide around it, making you a wonderful sleeve for his orc cock.  He hilts within you, and you cry out in pleasure as his cockhead rams your prostate.  Ro'gar wrests control from you as he hears you cry out like a bitch in heat.  His strong hands at your " + player.hipDescript() + " hold you in place as he pounds your " + player.assholeDescript() + ", ramming against you with brutal force and making you moan loud enough that your voice grows a little hoarse.  " + player.SMultiCockDesc() + " twitches from the abuse to your trigger", false);
			if (player.balls > 0) outputText(" and your " + player.ballsDescriptLight() + " clench tight as you feel your limit reached", false);
			outputText(".", false);
			//[(if player has toes)
			outputText("  You curl your fingers and " + player.feet() + " in ecstasy as Ro'gar drives you over the edge.", false);
			outputText("  Your bucks become ragged, and the orc takes over as " + player.sMultiCockDesc() + " jerks and spasms, shooting out countless ropes of sticky spunk onto the glistening green skin, painting the orc white with your lust.  With a low, deep, tone, Ro'gar groans out as you feel his warmth overtake your lower body, flooding you full of his fertile man cream.  Ro'gar continues to fuck you with decreasing vigor, slowing to a stop as his spent cock pops from your drooling pucker.  His spunk floods out of your filled boycunt, the spooge running down Ro'gar's half-hard cock to drip onto the floor lewdly.\n\n", false);
		}
		//(else)
		else {
			outputText("\"<i>Enough horsin' around.</i>\"  Ro'gar snarls as his arms quickly yank back, sneaking under your legs and hoisting you up as he gets to his feet.  You grip Ro'gar's shoulders tight as he lifts you with a strained grunt.  You delight with sharp little moans as he begins to fuck you skyward, bouncing you off of his hips with each slam of his cock into you.  Slowly Ro'gar steps towards a wall, taking his time to be sure not to drop you, and you soon feel the cool surface pressed to your back.  Caught between a cock and a hard place, you stare into Ro'gar's predatory gaze as he holds you hoisted in the air and pinned, making you feel vulnerable.  The orc takes advantage of you and begins to abuse your " + player.assholeDescript() + ", making your head tilt back to moan out helplessly.", false);
			outputText("  " +  player.SMultiCockDesc() + " lays out over your chest, dribbling pre-cum on your skin as you make a mess of your torso in lust.", false);
			//[(if player has tail) 
			if (player.hasLongTail() > 0 || player.isNaga()) outputText("  Your tail flicks helplessly below you, urgently wrapping around Ro'gar's thigh and trying to pull him deeper into you.", false);
			outputText("  You cry out as Ro'gar finds your sweet spot.  \"<i>Now I got yer button, boy,</i>\" he snickers, wearing his usual predatory grin, the sharp, jagged teeth on full display as you shudder from the relentless pounding against your " + player.buttDescript() + ".  The sound of flesh smacking flesh is loud in your ears as you squirm from Ro'gar's cock.  Each thrust drives you mad with pleasure, your mind in a lust-induced haze as your prostate is prodded and poked.", false);
			//[(If player has balls) 
			if (player.balls > 0) outputText("  You feel your " + player.ballsDescriptLight() + " pull up tight in your sack as your labored breath comes out in pants.", false);
			outputText("  Ro'gar continues his savage thrusts, impaling you fully on his length; soon you cry out in ecstasy as his urgent pounding brings you to climax, spraying yourself with your own thick spunk.  Your chest is quickly coated in ropes of your own cum, glazing your torso like a delectable treat to be licked off.   Your orgasm spurs him onward, and Ro'gar crushes you between himself and the wall with each powerful thrust.  A maddened hiss sounds as he breathes through his clenched teeth, impaling you with a few sharp smacks of hips against ass, and snarls issue from the orc as you are suddenly flooded with cum.  He seems to ejaculate for an eternity, each urgent thrust pumping another bucket of jizz into your ass. Your stomach distends as cum begins to overflow and run from your ass to drip from the orc's bouncing, fat balls and make a puddle on the floor.  You moan in exhaustion as he plants his seed inside you.\n\n", false);
		}
		//((Paths combine here))
		outputText("With exhausted panting the only sound from both Ro'gar and yourself, you take a few moments to catch your breath.  Ro'gar affectionately nuzzles you before letting you get to your feet, holding you until he's sure you can stand easily.  The pair of you share a knowing look and Ro'gar grins at you.  \"<i>You're amazin', " + player.short + ".  You're welcome anytime ya like.</i>\"  He gives you a tender embrace as you collect your things and walk on wobbly legs toward the door, still feeling cum running down your legs" + (player.armorDescript() != "gear" ? " beneath your garments" : "") + ".  The orc sees you off with a wave and a toothy grin.\n\n", false);
		//<Lust sated, slimefeed>
	}
	player.orgasm();
	dynStats("sen", 2);
	player.slimeFeed();
	doNext(camp.returnToCampUseOneHour);
}

//((Scenario 2, [Give Anal]: Fuck Ro'gar))
private function fuckRogarsButtPussyBoyCuntManMoundSissySlitQueerQuim():void {
	flags[kFLAGS.ROGAR_FUCKED_TODAY] = 1;
	clearOutput();
	spriteSelect(86);
	outputText("You nod eagerly, and the orc rewards you with another caress.  \"<i>Well then... let's head on out,</i>\" he says.  The two of you walk down the desert city's streets until you reach a discrete, out-of-the-way building labeled 'Steel Hogan Apartments', and Ro'gar leads you up to his room.  He opens the door and holds it for you, but with a gesture, you allow him to enter first.  As he walks in, you pull the door sharply behind you.  With a slam behind you and a startled look from the burly orc, you fix your eyes on him and tell him it's time he finds out who the boy really is in this relationship.  A confused look appears on Ro'gar's face.  ", false);
	//[(If player is shorter than 6 feet)
	if (player.tallness < 72) outputText("You reach a hand up to cup his chin, yanking it roughly towards your face as you plant a kiss on his lips.", false);
	//(If player is taller than 7 feet)
	else if (player.tallness > 84) outputText("You reach down and cup Ro'gar's chin, roughly yanking it up to crash his lips against yours.  ", false);
	outputText("Your tongue presses against his lips insistently, and the orc man moans and urges you on further as you slide your free hand down to grope his groin, feeling up his bulge shamelessly.  Ro'gar blushes lime green in his cheeks at how direct you are.  \"<i>" + player.short + "...</i>\" Ro'gar breaks the kiss to whisper more meekly than you've ever heard him, though you shush him with a finger to his lips.  You slip your hand into Ro'gar's shorts and lewdly grope Ro'gar's cock and balls, feeling the green, monstrous member begin to swell beneath your hand.  Your sights are on something lower though, and as you slide your hand under Ro'gar's heavy sack and between his legs you find his tight little orc hole.  You rub your fingertips over it with a loud growl, your kiss meanwhile becoming rougher.  You bite down on his lower lip as your fingers start to urgently press against the hole; the orc shivers under your touch.  You nudge him slowly into the bedroom and undress each other quickly. \"<i>I ain't ever seen you like this...</i>\" Ro'gar speaks, but you interrupt him with a forceful grunt and shove him onto the bed.\n\n", false);
	
	outputText("Pushing your hands against Ro'gar's body, and feeling the slime under your fingertips burning against your skin, you crawl over the prone orc to sit on his chest and point your groin toward his face.  With a grip on the back of his smooth head, you shove his face between your spread legs and let out a loud and satisfied moan.\n\n", false);
	//[(If player has vagina and over 70 corruption)
	if (player.cor > 70 && player.hasVagina()) outputText("Ro'gar flicks his tongue toward your " + player.multiCockDescriptLight() + ", but you have a better idea and nudge him lower to guide him to your " + player.vaginaDescript() + ".  His eyes look up at you in confusion.  You can tell he'd rather not have his face buried there by the way he moves his mouth away, but you urge him on; telling him to get licking, you push your hips down over his face.  With his head caught between your legs and the bed his mouth presses to your " + player.vaginaDescript (0) + "without a choice.  His whimpers of displeasure bring a grin to your face as you rub over his mouth with your netherlips.  He reluctantly flicks his tongue out to lap over your mound.  You shiver at the attention, growing moist and slick as you drip over Ro'gar's mouth.  The orc gives a whine of disgust as you rudely force him to pleasure your pussy, and you let out a loud moan as his unwilling licks turn you on; excited, you stroke your " + player.cockDescript(0) + ".  Ro'gar focuses his attention on that instead, watching you grow stiff and swollen, his eyes following your pumping hand.  You generously rub the slick, drooling pre-cum over " + player.sMultiCockDesc() + ", your vaginal walls clenching around his tongue as you pleasure yourself, working the goo over your flesh with your hand.  You look down and grin devilishly at him.\n\n", false);
	//(If player doesn't have vagina but has 70+ corruption)
	else if (player.cor > 70) outputText("Ro'gar flicks his tongue over your " + player.multiCockDescriptLight() + ", but you have a better idea and nudge him lower to guide him to your " + player.assholeDescript() + " .  With a lusty growl Ro'gar attacks your pucker, tongue swirling over the surface and coaxing a pleased moan from your lips.  You grow stiff with arousal, bringing a hand down your shaft to answer your burning lust with a few teasing strokes.  You smear the pre-cum pouring out of your " + player.multiCockDescriptLight() + " into an even coating of spunk as you work your hand.  Ro'gar looks over at the pumping hand and soon becomes distracted from his work, his tongue pressed lazily against your " + player.assholeDescript() + ".  You look down and grin devilishly at him.\n\n", false);
	
	outputText("Pulling back off of Ro'gar's face, you feel your entire body twitch in anticipation.  You press your " + player.hipDescript() + " against his muscled ass, lining your aroused member up against his tight rear while your hands grope over the firm muscled cheeks, spreading them apart eagerly.\n\n", false);
	
	//[((If biggest cock is less than 4 inches))
	if (player.longestCockLength() < 4) {
		outputText("\"<i>Yer serious?</i>\" Ro'gar asks with a quirked eyebrow.  You blink as he suddenly gets up to stare you in the eyes.  \"<i>Not to be rude, " + player.short + ", but I ain't gonna feel nothin'.</i>\"  You can't help but feel a little offended, saying something about motions of large bodies of water.  Ro'gar doesn't seem convinced as he buries his forehead in a palm.  \"<i>Listen, this ain't a really good time for this.  I'm already losin' my mojo.  You come back another time, okay?</i>\"  With that, you are ushered out as politely as possible.  You can't help but feel a little embarrassed as you walk the city streets like this is some sort of walk of shame.", false);
		doNext(camp.returnToCampUseOneHour);
		return;		//end if too small
	}
	//((else If smallest cock is over 18 inches))
	else if (player.shortestCockLength() > 18) {
		outputText("\"<i>E-easy there...</i>\" Ro'gar actually stutters, looking at you with concern.  You are impossibly huge for him, and despite your titanic head rubbing pre-cum over Ro'gar's green hole it just won't fit.  You let out an annoyed grumble and begin to rub your length over Ro'gar's body and orc cock.  With lustful grunts Ro'gar bucks his hips into your " + player.multiCockDescriptLight() + ", grinding the stiff masts together as they leak and drool over one another.\n\n", false);
		//[(If multiple cock)
		if (player.cockTotal() > 1) outputText(player.SMultiCockDesc() + " grinds over every inch of Ro'gar's front, and his dark olive skin soaks in your glistening fluids.  Ro'gar's length is lost in the forest of your meat.  With his green monster assaulted by multiple angles and dwarfed in size he whimpers softly.  \"<i>Ain't never felt nothin' like this.  Almost like fuckin' a dick.</i>\"", false);
		//(else If single cock)
		else outputText("Your " + player.multiCockDescriptLight() + " bucks against Ro'gar's orcish pride.  The pair of hard cocks press tightly together as you dwarf Ro'gar in size.  You hump his orc sex with your " + player.multiCockDescriptLight() + " and grunt in strain; your hands reach down to grip the pair of manhoods tightly, jerking them fast with squeezed pumps.", false);
		//(If player has balls) 
		if (player.balls > 0) outputText("  Ro'gar squirms under you, his chest heaving with labored breath while his musky scrotum presses against your own.", false);
		outputText("  He reaches down, sweaty palm wrapping around his meaty length and roughly choking it, then strokes along his orchood hastily as he groans out, spunk spilling over " + player.sMultiCockDesc() + " and leaving it sopping wet with hot seed.  Your own hands rub Ro'gar's strong smelling sperm over yourself, coating your " + player.multiCockDescriptLight() + " in his lust.  The sight of the heaving orc beneath you drives you over the edge,and your pent-up load splatters over Ro'gar's sweaty body and covers the orc in your thick volleys of cum.", false);
		outputText("\n\n", false);
	}
	//((If cock is between 18 and 4 inches))
	else {
		outputText("\"<i>E-easy there.</i>\"  Ro'gar actually stutters, looking at you with concern. Your lips curl into a devious grin as you roughly press into Ro'gar's puckered hole.  You slide in with an abrupt grunt, ignoring Ro'gar's yelps of pain at the sudden entry and reasoning that it couldn't have hurt too much, judging by how your " + player.cockDescript(0) + " was literally coated in pre-cum.  But still, you find it amusing to push the orc's button and make him squirm for once.  Slipping in further, you bury yourself in Ro'gar's hole until he groans out and prematurely spurts more orc cum onto his stomach.", false);
		//[(If using feline cock)
		if (player.cocks[0].cockType == CockTypesEnum.CAT) outputText("  You grind around in his green pucker, the barbs working over Ro'gar's inner walls.  \"<i>W-what in tarnation?</i>\" Ro'gar grunts as you watch him squirm under you.  You buck your hips, digging deeper into orcflesh with each thrust, his muscled ass tensing with each slam of your hips.", false);
		//(If horse cock)
		else if (player.cocks[0].cockType == CockTypesEnum.HORSE) outputText("  The flared head of your " + player.cockDescript(0) + " nestles in Ro'gar's hole.  His breath quickens as you push in, the girthy, flared head stretching Ro'gar's insides impossibly.  You simply thrust and buck you way deeper within the green pucker to force more of your lengthy shaft past that olive rosebud each time.\n\n", false);
		//(If dog cock)
		else if (player.hasKnot(0)) outputText("  Your pointed tip slips in easily and you begin to plunge into Ro'gar's depths, and the burly orc gives satisfied grunts as his strong hand reaches down to touch himself.  You begin to fill his orc hole, the pre-slicked cock working as a lubing tool as you begin to build a nice rhythm within Ro'gar.  Your knot bulges as your climax approaches and begins to ram into Ro'gar's green pucker, the tight ring unable to allow entry as you swell bigger and bigger.", false);
		//(If other cock)
		else outputText("  Breaking Ro'gar's orc hole open, you thrust deep within his hot, tight depths.  The burly orc pants with heated breaths, humid air fluttering out of his tusked mouth.  His musclegut heaves, each breath punctuating the thrusts of your hips.  You plow his ass roughly, pulling out until only the head remains inside him before plunging back in further than before.  Ro'gar grunts low in his chest with each bit of progress made, his strong, calloused hand stroking his drooling cock.  \"<i>Mmmf, " + player.short + ",</i>\" he groans as you finally hilt yourself within him.", false);
		//end racialdicks, still inside right fit path
		
		outputText("\n\nYou grip his hips and begin a steady pace, slapping flesh loudly against his muscled ass.  His thick, powerful legs twitch in the air as you pound into his orcish hole, and the orc's toes curl visibly with each brutal thrust you make into him.  You groan as his musk makes your " + player.multiCockDescriptLight() + " throb all the more within him.  To further his humiliation, you whisper in his pointed ear how good he feels wrapped around your length.  He blushes a lime green before you make him groan out your name with a rough smack over his ass.", false);
		if (player.cockTotal() > 2) outputText("  Your other cocks grind over that firm orc rump, drooling over his skin and making his rear glisten with your sex.", false);
		else if (player.cockTotal() > 1) outputText("  Your other cock grinds over that firm orc rump, drooling over his skin and making his rear glisten with your sex.", false);
		outputText("You decide to see how loud you can make him moan and begin ramming deep within him.  The thrusts slam hard enough to make Ro'gar's back arch, your bulbous cockhead prodding his buried prostate with each hilt.  His big hand beats furiously at his massive orc cock, strained groans bellowing out loudly as his heavy sack clenches tight against the base of his green rod.  Orc spunk flies out over his chest, hitting his chin and splattering over his heaving pecs.  His cum collects between his bulging muscles and splashes over his head.  Ro'gar's anal walls clench down tight around you as you pick up the pace of your brutal fuck; your " + player.cockDescript(0) + " is milked hard as you feel your climax rapidly approaching.  Sweat drips from your body onto Ro'gar's skin, and you finally feel yourself hit the edge.  With a burst of ecstasy you hilt completely within your orc fuck toy.", false);
		//[(If dog cock)
		if (player.hasKnot(0)) outputText("  Your knot forces past Ro'gar's tight, anal ring to pulse inside him, joining the pair of you together.", false);
		//[(if player has balls)
		if (player.balls > 0) outputText("  With short jerks of your hips, you begin to unload your pent up orbs into the orc's innards.", false);
		outputText("  Wave after wave of thick seed spills from your cock into Ro'gar as his head falls back at the blissful sensation.", false);
		//[(if multiple cock)
		if (player.cockTotal() > 1) outputText("  The other meat rubbing over his olive skin outside adds to the coating of spunk, making a giant mess of Ro'gar's body.  In seconds he resembles a well-paid whore beneath your " + player.multiCockDescriptLight() + ".", false);
		outputText("\n\n", false);
	}
	//end right fit path
	//((Combine too big, and right size paths))
	outputText("Ro'gar's cum-coated body lies panting under you.  You slowly soften and lay limp against his olive skin, then pull away and clean yourself off.  Ro'gar stirs slowly, only rising to a seated position" + (player.armorDescript() != "gear" ? " by the time you are dressed" : "") + ".  \"<i>That was really... something.  I don't really know what got inta ya, " + player.short + ", but ya really know how ta surprise a feller.</i>\"  With a sly smirk you intone that he had it coming" + (player.armorDescript() != "gear" ? " and finish putting on your clothes" : "") + ", then walk over to smack Ro'gar's cum-covered ass with your hand.  The giant orc looks stunned a moment before giving a playful grin.  \"<i>Frisky, aren't'cha?</i>\"  He snickers low in his rumbling chest, then gets up to wave you off, but you're already out the door and heading back into the city with a spritely skip added to your step.", false);
	//<Lust sated>
	player.orgasm();
	dynStats("sen", -1);
	doNext(camp.returnToCampUseOneHour);
}
 
//((Scenario 3, [Drink! (sorta)]: Fun with Bro Brew(Requires one bro brew per visit, uses it and turns player into a Bro)))
private function brobrobrobro():void {
	clearOutput();
	spriteSelect(86);
	outputText("You follow Ro'gar home and walk into the apartment, draping your arm around the orc man in a tight hug. \"<i>Glad ta see you too.  What's that you got?</i>\"  Ro'gar looks at the can in your pack.  \"<i>Bro Brew!  Love the stuff.  That for me?</i>\"  He snickers and snags it before you can object, then plays keepaway with you, yanking the can out of reach.  Did you want to keep that?  His dangerous, playful expression would suggest he means to make mischief for you if you try to grab it, and it may get spilled - on you!\n\n", false);
	//[Fukkin' Grab It!][Reverse Psychology]
	simpleChoices("FukkinGrabIt", takeDatBroBrewFromDaBigMeanOlOrc, "ReversePsych", rogarIsDumb, "", null, "", null, "", null);
}
//[reverse psychology]
private function rogarIsDumb():void {
	clearOutput();
	spriteSelect(86);
	outputText("You relinquish the can with a smile, slyly telling Ro'gar he can have it, then put your hands behind your back innocently.  He narrows his eyes, then shifts them to the can.  After a careful inspection, he thrusts the can toward you.  \"<i>Don't want it.  Ya probably put bimbo liqueur in it or somethin', ya sneaky devil.</i>\"\n\n", false);

	outputText("The playful mood broken, you hang out for a while and shoot the breeze, then head back.", false);
	//end
	doNext(camp.returnToCampUseOneHour);
}

//[Fukkin' Grab It!]
private function takeDatBroBrewFromDaBigMeanOlOrc():void {
	flags[kFLAGS.ROGAR_FUCKED_TODAY] = 1;
	player.consumeItem(consumables.BROBREW);
	var changed:Boolean = false;
	var cocked:Boolean = false;
	clearOutput();
	spriteSelect(86);
	outputText("Reaching for the can and insisting he return your property only makes things worse, and you hear the telltale pop and hiss of the can opening.  \"<i>You'll have ta get it from my belly in a moment,</i>\" Ro'gar grunts as he tips the can near his open maw to drink. You resort to drastic measures and wriggle your fingers over Ro'gar's sides!  He gags on the brew as you tickle him, bursting into laughter as he coughs up liquid on his exposed chest. The drink drips from his pectorals and runs down his abdominals, leaving him soaking wet and smelling like a malt beverage.  \"<i>Q-quit it!</i>\" he barks between snorted giggles.  You find yourself distracted by how the liquid runs over Ro'gar's body and traces his muscles.  A smile forms on your face as you get an idea.\n\n", false);
	
	outputText("You dip your head down sharply and lap your tongue over Ro'gar's soaked chest, curving along a pectoral to lick his orcish nipple clean.  Ro'gar gives a surprised gasp and grunts as your hot tongue licks over his body, temperatures mixing as the cool liquid is lifted.  Your hands remain still at Ro'gar's sides to keep your balance as your mouth migrates over the orc's body.  The scent is enticing; a mixture of musk and drink, the slime, sweat, and brew all combining into a beefcake slurry that reeks of testosterone.  Ro'gar stands quite still, though his legs slowly buckle and he falls to the floor.  His bulge swells rapidly between his spread legs as your tongue teases and tastes him.  \"<i>Alright, " + player.short + ", you win.  I won't drink it... but </i>you<i> gotta.</i>\"  He grins deviously and slowly tips the can to spill tiny streams of brew down his heaving chest.  You move to catch each one, your mouth letting no drop escape your eager lips as you kiss and suckle his flesh.  Your hands drop from his sides to stroke over the swelling bulge, fingers curving over the trapped orchood and pressing your palm into the stiff shaft through the damp fabric of his shorts.  With a sharp grunt Ro'gar spills a large wave of brew over himself.  The drink washes over your mouth and soaks the fabric over his groin. The damp cloth now clings to his hard orc cock, translucent and form-fitting with the weight of the liquid.  \"<i>Fuck, " + player.short + "...</i>\" Ro'gar moans and grinds his crotch into your hand.  You move it away and quickly replace it with your mouth.\n\n", false);

	outputText("Your face presses into Ro'gar's beer-soaked crotch, and you wrap your lips around the cock as you suckle the mixture of brew and pre-cum from the cloth.  " + player.SMultiCockDesc() + " is already stiff in your clothing as you feel intense heat take effect from tasting the oil-coated skin.  You pant over Ro'gar's confined erection, your body twitching and jerking while " + player.sMultiCockDesc() + " swells with blood.  Your muscles begin to expand under your skin; letting out a deep grunt, you feel yourself growing more masculine as your mind is shrouded in lust and... something else.  It frustrates you briefly, though you quickly forget the mysterious haze and unzip the orc's shorts.  \"<i>Don't waste a drop now...</i>\" Ro'gar purrs, his fat cock exposed before you.  You wrap your lips around the head immediately, eagerly sucking away at the green length.  Ro'gar tips his head back to bellow out, his hand dumping more brew over his cock to soak your lips and his balls.  You smile to yourself, thinking how much you love cock.  Your cock, other guys' cocks, your bro's cock.  It doesn't matter to you, as they all feel so good to suck off.  Your mouth disengages and wraps around Ro'gar's plump sack, filled by orbs heavy with cum.  Sucking the brew off your bro's balls while stroking your own meat is great.  Nothing else matters to you anymore.  You are unable to comprehend how muddled your mind and body are, becoming lost in the sensations of lust as you stroke your suddenly much bigger " + player.multiCockDescriptLight() + ".  Your head bobs along Ro'gar's thick orc meat as you drink your bro brew from your bro's giant dick.  Which is like, the hottest thing you can think of.  No homo, of course.  The only thing that could make it better would be... you lose your easily derailed train of thought as Ro'gar's hand grabs your head, forcefully bucking his hips into your wet mouth and letting out a hiss.  \"<i>Open wide!</i>\"  A loud groan follows as he spills his massive load down your throat.  Totally sweet, you think to yourself as you gulp down the thick seed like shots. You feel your bro's load fill your gut with each pump of cum, drinking it all and savoring the taste as you milk every last drop before his spent cock slips from your maw.\n\n", false);
	
	outputText("Getting to your feet, you wipe the clinging cum and brew from your lips with your tongue.  You compliment Ro'gar's load while referring to him as 'dude'.  Ro'gar looks a bit perplexed but gives you a wide grin.  \"<i>You get any more of those an' you should bring 'em over.  We'll 'drink' ta the occasion.</i>\"  He punctuates his sentence with a wink that makes you grin.  Leaning forward, you press your lips to his.  His tongue pushes yours as they wrestle against each other.  You kissed a dude, and you liked it.  Yes homo.\n\n", false);
	
	outputText("Leaving Ro'gar's apartment you wander out into the streets.", false);
	if (player.findPerk(PerkLib.BroBody) < 0) {
		if (player.balls == 0) {
			player.balls = 2;
			player.ballSize = 3;
		}
		if (player.inte > 35) {
			player.inte = 35;
			dynStats("int", -0.1);
		}
		if (player.lib < 50) {
			player.lib = 50;
			dynStats("lib", .1);
		}
		outputText("\n\n", false);
		//(Tits b' gone) 
		if (player.biggestTitSize() >= 1) {
			if (player.breastRows.length > 1) {
				while(player.breastRows.length > 1) {
					player.removeBreastRow(player.breastRows.length-1,1);
				}
			}
			player.breastRows[0].breastRating = 0;
			player.breastRows[0].nipplesPerBreast = 1;
			player.breastRows[0].fuckable = false;
			if (player.nippleLength > .5) player.nippleLength = .25;
			player.breastRows[0].lactationMultiplier = 0;
		}
		if (player.hasCock()) {
			if (player.cocks[0].cockLength < 10) {
				if (player.cocks[0].cockThickness < 2.75) {
					player.cocks[0].cockThickness = 2.75;
				}
				cocked = true;
				player.cocks[0].cockLength = 10;
			}
			if (player.balls == 0) {
				player.balls = 2;
				player.ballSize = 3;
			}
		}
		//(Pussy b gone) 
		if (player.hasVagina()) {
			player.removeVagina(0,1);
		}
		player.genderCheck();
		//(below max masculinity)
		if (player.femininity > 0) {
			player.modFem(0,100);
		}
		//max tone.  Thickness + 50
		if (player.tone < 100) {
			player.modTone(100,100);
		}
		if (player.thickness < 100) {
			player.modThickness(100,50);
		}
		if (player.inte > 21) player.inte = 21;
		dynStats("str", 33,"tou", 33, "int", -1, "lib", 4, "lus", 40);
		changed = true;
		player.removePerk(PerkLib.Feeder);
	}
	//[(if player received a change from brew)
	if (changed) {
		outputText("  You realize you look much stronger, bigger, and sexier", false);
		//(if dick grew)
		if (cocked) outputText(", and you smile to yourself as your now-larger endowment" + (player.armorDescript() != "gear" ? " rubs against garments not suited to it" : " flops freely in the air") + "", false);
		outputText(".  Who needs book smarts anyway?  Nerds.", false);
		//lose lust, gain bro traits, slimefeed
		player.createPerk(PerkLib.BroBrains,0,0,0,0);
		player.createPerk(PerkLib.BroBody,0,0,0,0);
		outputText("<b>(Bro Body - Perk Gained!)\n", false);
		outputText("(Bro Brains - Perk Gained!)</b>\n", false);//int to 20.  max int 50)
		if (player.findPerk(PerkLib.Feeder) >= 0) {
			outputText("<b>(Perk Lost - Feeder!)</b>\n", false);
			player.removePerk(PerkLib.Feeder);
		}
	}
	player.orgasm();
	player.slimeFeed();
	doNext(camp.returnToCampUseOneHour);
}

//((Scenario 4, [Frot]))
private function frotWithRogar():void {
	flags[kFLAGS.ROGAR_FUCKED_TODAY] = 1;
	clearOutput();
	spriteSelect(86);
	outputText("You allow yourself to be led into Ro'gar's apartment and look around the modestly furnished lounge. Ro'gar seats himself in a cushioned chair.  \"<i>Thanks fer comin'.  I missed ya.</i>\"  He snickers, and you draw closer. His calloused hand reaches down to cup your " + player.buttDescript() + ".  He smirks at you, the frisky orc chuckling deeply and firmly squeezing.  You retaliate with a hard smack against Ro'gar's muscled rump.  He growls low, answering the challenge and crashing his lips into your own.  Muffled grunts and groans issue from both of you as you undress each other.  Soon you are standing in the nude and Ro'gar's hefty cock presses against your " + player.multiCockDescriptLight() + ".\n\n", false);
	//(If multiple cocks)
	if (player.cockTotal() > 1) {
		outputText("Feeling your lengths stiffen against Ro'gar's hard green monster, you buck against Ro'gar's hard need, enveloping it in your cocks and coaxing a lewd groan from the orc.  Ro'gar growls as he feels his orc length surrounded, his green member being slathered with your pre-cum from multiple directions.  His arms wrap around you as he fucks your " + player.multiCockDescriptLight() + ", grinding his orc cock between all your lengths; he presses his tusks against your neck and suckles, teeth grating the flesh while his tongue passes over the indentations they leave behind.  Ro'gar backs you up and you feel a hard wall behind you.  His oil-coated body rubs over your own, smearing onto your chest, arms, and hips.  Your hands grip tightly to Ro'gar's back as you grind into him with your " + player.multiCockDescriptLight() + ".  Ro'gar reaches his hand down, wrapping his fingers around his length and the nearest cock to it, then strokes them slowly.  Hot breath washes over your face as he stares deep into your eyes, the deep blue pools hazed with lust as you fuck against each other's loins.  Your two bodies mingle with sweat and pre-cum, and soon your groins are sticky and glazed.  You fuck your cocks together, the strong scent of man musk filling your nose and sending a shudder down your spine and a thrill through your groin.  Ro'gar suddenly moans, his orc cock caught between your " + player.multiCockDescriptLight() + " as he unloads over your chest.  His heavy sack clenches tight beneath his cock as he spills his thick seed onto you, coating you in his countless ropes.  The heat warms your skin as you reach your limit; each of your " + player.multiCockDescriptLight() + " twitches, hot and sticky spunk splashing over Ro'gar's olive skin.\n\n", false);
	}
	//(If single cock)
	else {
		outputText("Your cock presses tight against Ro'gar's fat orc cock. He growls low as he grinds himself over you, his thick, globbing pre-cum drooling onto your " + player.multiCockDescriptLight() + ".  Muffled groans escape Ro'gar's mouth as you kiss him roughly, tongues locked all the while in writhing combat.  ", false);
		//[(If player has balls)
		if (player.balls > 0) outputText("Your " + player.ballsDescriptLight() + " slap audibly against Ro'gar's heavy green sack.  ", false);
		outputText("Each thrust is slicker and better than the last as your cockheads drip out copious amounts of pre-cum over each other's lengths, the two manhoods slick and bucking toward the other in hard, bestial rut.  Ro'gar backs you up and you feel a hard wall behind you.  His oily body rubs over your own, smearing onto your chest, arms, and hips, and your hands grip tightly to Ro'gar's back as you grind into the orc.  Ro'gar reaches his hand down, wrapping his fingers around his length and yours.  He strokes along them with his rough, calloused hand, and hot breath washes over your face as he stares deep into your eyes.  The deep blue pools are hazed with lust as you fuck against each other's loins.  Your two bodies mingle with sweat and pre-cum, and soon your groins are sticky and glazed.  You fuck your cocks together, the strong scent of man musk filling your nose.  Ro'gar suddenly moans, his orc cock caught against you as he unloads over your chest.  His heavy sack clenches tight beneath his cock as he spills his thick seed, coating you in his countless ropes of jizz.  The heat warms your skin as you reach your limit; your " + player.multiCockDescriptLight() + " twitches and hot and sticky spunk splashes over Ro'gar's olive skin.\n\n", false);
	}
	//(( Paths combine here))
	outputText("The pair of you pant as you lean against the wall.  You manage to pick your head up to smile at the orc and rub Ro'gar's cum-covered chest, smearing your own spooge with your finger; the orc does the same with his cum on your chest.  You dip your cum-coated finger into his mouth as he mirrors the action with you, before falling into a lust-driven make-out session flavored with cum and saliva.  As you break the sloppy kiss, you can feel your slick, cum-covered, flaccid cocks pressing against each other.  With a laugh, you break the embrace.  Pleased grins flash back and forth as you get dressed and ready to leave.  Ro'gar remains nude and waves you off from the doorway, still covered in cum.", false);
	//lose 100 lust, gain a little back, slimefeed?
	player.orgasm();
	dynStats("lus", 20);
	doNext(camp.returnToCampUseOneHour);
}

//(([Get Tied Up], copy of Scenario 1a))
private function kinkyWithDaOrc():void {
	flags[kFLAGS.ROGAR_FUCKED_TODAY] = 1;
	clearOutput();
	spriteSelect(86);
	outputText("You nod eagerly, and the orc rewards you with another caress.  \"<i>Well then... let's head on out,</i>\" he says.  The two of you walk down the desert city's streets until you reach a discrete, out-of-the-way building labeled 'Steel Hogan Apartments'.  \"<i>This here's where I'm stayin',</i>\" Ro'gar says, handing you through the doorway.  He leads you down a hallway to his own lodgings, then pushes open the door for you; you step ", false);
	if (player.cor < 33) outputText("shyly ", false);
	else if (player.cor > 66) outputText("eagerly ", false);
	outputText("over the threshold, and then look around the apartment.  He points out the small kitchen area and then, rather sheepishly, the bedroom.  You're examining it when something catches your eye...\n\n", false);	
	outputText("You bend over the bed to grip a small bottle lying in the soft fabric of the sheets.  Turning it over, you tilt your head as you read the label.  It's... a bottle of lubricant.  Suddenly, there is a loud thud behind you and the bottle drops from your hand as your torso is pressed into the cushioned surface of the bed.  Something presses into your back.  \"<i>Gotcha...</i>\" the familiar voice snickers in your ear.  Ro'gar's head leans over your shoulder and a long, orcish tongue licks your cheek.  \"<i>Was waitin' for this...</i>\" he purrs; the resonance of his voice rumbles against your ear.  Ro'gar chuckles and grips around your wrists.  \"<i>Now that yer here, it's time ta break in this here new bed with sumthin' I've been cravin' since I washed ya down in that swamp, boy.</i>\"  Ro'gar's tone suddenly takes a demanding, hissing tone.  His tongue flicks over your ear as he speaks.  Your skin begins to grow goosebumps as shivers crawl down your spine.\n\n", false);
	outputText("He yanks your wrists behind your back, ignoring your faint gasps.  With a rustle of cloth, your wrists are bound together behind your back tightly; your fingers feel over the bonds but you struggle against them in vain.  Looking over your shoulder in ", false); 
	if (player.lib < 33) outputText("feigned confusion ", false);
	else if (player.lib > 66) outputText("clear lust ", false);
	outputText("at Ro'gar, you only see his lust-ridden face dipping down to kiss at your lips.  His tusks press against your cheeks with a demanding snarl and his tongue into your mouth; your " + player.buttDescript() + " receives a smack, forcing you to yelp.  His tongue quickly invades, and his free hand unfastens your " + player.armorName + " to strip you forcefully.  Rough, calloused fingers dance over your body and fasten onto your " + player.nippleDescript(0) + "s, coaxing moans from your throat with each pinch.  Your pleased noises are muffled by Ro'gar's mouth, his tongue and lips hushing each whimper and gasp you breathe.  A bare, firm chest presses against your exposed back, and you pant as the heat from his body burns against you, only intensified by the thin layer of oil on his skin.  Ro'gar's blue eyes watch you like a predator as your face flushes.  He breaks the kiss and cups his hands under your chin to hold your face in place.  \"<i>Such a perdy face yer makin', " + player.short + ".  Yer lookin' at me like a proper slut, an' it's makin' me hard seein' ya so needy to be bred.</i>\"  He growls in his throat as his mouth nips over your neck, leaving red marks along your skin where his tusks rub against you.  You can feel the oil and sweat smearing over your back, and your senses go wild.  The room is soon filled with your needy whimpers as " + player.sMultiCockDesc() + " oozes and throbs against the sheets, making the fabric damp with your lust.\n\n", false);
		
	outputText("With an abrupt grunt you feel hands gripping your " + player.hipDescript() + " and pulling your rear into the air, making you balance on your face and knees.  Ro'gar begins to play with your " + player.buttDescript() + "; each hand massages a cheek between his fingers, squeezing and kneading them apart.  A finger rubs over your sensitive entrance and you shudder softly.  The orc tests its resistance with his finger, pressing in and threatening to penetrate, rubbing harder around the tight, puckered flesh.  You moan like a whole in heat thanks to the coaxing Ro'gar's finger lavishes on it. ", false);
	if (player.ass.analLooseness < 3) outputText("\"<i>Tarnation, " + player.short + ".  You're so tight...</i>\"\n\n", false);
	else if (player.ass.analLooseness < 5) outputText("\"<i>My favorite boy ready for the ride of his life?</i>\"\n\n", false);
		
	outputText("Ro'gar rolls you over by your " + player.hipDescript() + ", forcing your body to lay out over your back.  The orc's face comes down close enough that you feel his breath washing over your skin.  With a rip you hear the shorts torn from Ro'gar's body.  You feel his hot, throbbing length grinding over your " + player.buttDescript () + " before you see it, the deep green head towering over your groin menacingly, each vein pulsing as the mammoth cock belches pre-cum to leak down the orcish shaft.  Your skin is soon slick with his spurting pre as he groans out. \"That's much better.\"  Ro'gar's breath becomes labored as he pants heavily and eagerly, his green length humping against your rosebud, making you moan out in an excess of sensation.  His hands hold your cheeks apart with a strong grip as you begin to leak your own pre-cum onto your stomach.", false);
	//(if player has balls) 
	if (player.balls > 0) outputText("  Ro'gar's dark green cockhead rubs over your " + player.ballsDescriptLight() + " and coats the plump sack in his musky goo, like an alpha male marking his territory.", false);
	outputText("\n\n", false);
 
	outputText("Deep, guttural hisses echo out from the orc.  \"<i>Easy fella...</i>\" Ro'gar mutters, trying to restrain himself from ripping you apart with his fat cock.  He leans down and kisses you softly before continuing.  \"<i>I'll give ya a kinky fun ya won't forget.</i>\"  With a playful wink he gets down on his knees, squatting near the foot of the bed.  His hand hoists your " + player.hipDescript() + " up to his mouth.  You can feel him kiss your tight ring, and soon a warm sensation shoots up your spine, causing you to moan.  His hot, slick tongue swirls over your puckered flesh, slathering your hole while his tusks rub along your cheeks.  You're left panting out hot, needy breaths as Ro'gar works over your anus, his tongue gently easing your tight ring of flesh open.  The pleasure makes your legs go limp over his shoulders and your eyes shut in a blissful daze.  Ro'gar's wet slurps and growls make your ears twitch, and you feel him slowly press in with his orcish tongue, beginning to tonguefuck your entrance forcefully.  With patience, your pucker gives in under Ro'gar's touch and his tongue slides into your untouched confines.  You give a sharp gasp, this strange feeling overwhelming you as you flick your eyes open.  Your " + player.buttDescript() + " wriggles in pleasure around his tongue, and the orc gives a pleased grunt as his tongue swirls around your inner walls, sliding out to pull your lime flavor into his mouth before roughly thrusting back in.  Your back arches as you cry out a surprised moan.", false);
	if (player.hasLongTail() || player.isNaga()) outputText("  Your tail wraps around Ro'gar's arm for some sort of stability, the tip flicking lazily as it coils and squeezes around a bicep.", false);
	outputText("\n\n", false);
		
	outputText("Ro'gar produces harsh snarls, eagerly tonguefucking you, eating you out as his lips work over your ass.  His fingers grip your " + player.hipDescript() + " roughly as he ravages your hole in a manner beyond your wildest dreams.  You hear slapping as Ro'gar's hips smack involuntarily against the side of the bed.  His aching erection drools globs of thick slime over the sheets, barely restraining his desire to fuck you senseless.  \"<i>Relax!</i>\" Ro'gar barks in a commanding tone that shocks you.  You try to comply with a whimper, feeling something pressed against you.  Ro'gar's fat finger prods your spit-slicked pucker, slipping in with a wet shlick.  You shudder as his digit slides into you", false); 
	if (player.ass.analLooseness < 3) 
	outputText(" with some resistance, but the relentless finger rubs over your walls as he begins to pull your rim open, forcing another finger inside and making you bite your lip from the stinging sensation.  Working the pair of fingers together inside of you, he slowly moves them apart and stretches your hole wide.", false);
	else if (player.ass.analLooseness < 5) 
	outputText(" and rubs over your walls as he pulls your rim open, forcing another finger inside and making you moan like a bitch in heat.  Working the pair of fingers together inside of you, he slowly moves them apart and stretches your hole wide.", false);
		
	outputText("  Fingers and " + player.feet() + " curl in pleasure as your boycunt is forced open by Ro'gar's steady coaxing.", false);
	outputText("  You hear the pop of a corked bottle, and soon the cool, slippery lubricant pours over your puckered entrance and taint.  After the twin fingers have worked you loose enough a third slides in, the three digits picking up speed as they push in deeper and open you wide.  The strange feeling drives you wild. It just feels so good and right, and your seed pools on your stomach, drolling down your sides to stain the sheets below.  Ro'gar gets up on the bed, looming over your aroused form as his fingers continue pumping into you.  You glance down through the haze of pleasure to see his massive erection.  It seems bigger than you remember, the head leaking a steady stream of spunk to hint at his production.  \"<i>Ready fer yer ride, boy?  I got you nice and spread.</i>\"  Blue eyes look over your arousal, and you can only shiver under his gaze.  \"<i>I reckon yer enjoyin' yerself,</i>\" he says with a growl, and continues to drive your body wild with lust and arousing sensations.  \"<i>I've been bidin' my time now, but I'm goin' to savor every last drop until ya burst.</i>\"\n\n", false);
		
	outputText("A groan escapes your lips as his fingers slide from your pucker.  His strong hands lift your backside, raising your lubricated hole to a suitable level; you lay completely exposed before him as he shifts his hips to line himself up with your pucker.  The head of his monstrous cock presses against your loosened boycunt, dripping with need as he steadily forces ", false); 
	if (player.ass.analLooseness < 3) outputText("the tight hole.  Your teeth clench as he stretches you wide around his length, though he continues without hesitation, and finally you cry out with the sting of the bulbous head squeezing into your tiny hole, though it falls on deaf ears as Ro'gar merely groans at your tightness.", false);
	else if (player.ass.analLooseness < 5) outputText("your well-used hole. You moan with need as he stretches you wide around his length, continuing without hesitation until he's inside.", false);
	player.buttChange(25, true, true, false);
	
	outputText("  Another whimper escapes your lips as you feel the orc's gigantic cock stretch you so wide.  \"<i>You're a proper cock sleeve, boy.  Perfect fer me to breed.</i>\"  He chuckles and licks your face with his warm tongue.  With most of his thick length nestled in you, Ro'gar pulls back to his cockhead only to thrust in again, steadily working more and more of himself inside.  The heat and feeling of his dripping spunk, warm against your walls begin to overwhelm you.  Feeling him claim your insides makes you moan out in bliss.\n\n", false);
 
	outputText("You can't help but focus on the wonderful feeling of Ro'gar's cock throbbing within you.  Maybe this is where you belong?  With your ass impaled on Ro'gar's massive tool?  You moan loudly as Ro'gar picks up the pace, hips ramming into you with enough force to shift your body over the sheets.  He really starts to pound your hole with huffed grunts and groans as he hilts in you; his cockhead prods your prostate with each thrust, causing you to cry out as electric shocks shoot up your spine.  Every nerve in your body lights up like a Christmas tree and make your entire body squirm with pleasure.  You feel spurts of cum begin to leak from your " + player.multiCockDescriptLight() + " and glaze your belly with pre-cum.", false);
	if (player.hasLongTail() > 0 || player.isNaga()) outputText("  Your tail, still gripping Ro'gar's arm, squeezes tight.", false);
	//(If player has balls) 
	if (player.balls > 0) outputText("  Your " + player.ballsDescriptLight() + " clench sharply as you feel your climax nearing.  \"<i>Found your button, boy,</i>\" Ro'gar snickers as he rubs his cock over your prostate, the hot meat working over your body in ways you adore.  You feel completely at the large orc's mercy.  \"<i>Cum for me,</i>\" he growls as his lips press over yours, opening your mouth wide as he invades and thrusts his tongue in fellowship with his dick.  His hips pound against you, ballsack slapping your upturned cheeks with each thrust as he rams your trigger over and over.  You moan into the orc's mouth and coat yourself in your own spunk, your brain hazy from the blissful, oozing orgasm.  Your front is dripping with your cum, as Ro'gar continues to abuse your boycunt.\n\n", false);
		
	if (player.ass.analLooseness < 3) outputText("\"<i>So fuckin' tight...</i>\" Ro'gar snarls as he nears his limit. ", false);  
	else if (player.ass.analLooseness < 5) outputText("\"<i>Time fer yer proper breedin', boy!</i>\"  His voice makes his chest rumble as he pants hot breath that caresses your face.  The sound of smacking skin rings in your ears, and you briefly note that your " + player.buttDescript() + " feels red and sore from Ro'gar's hips beating against them before closing your eyes to another pleasurable thrust.  With a harsh snarl his jaw bites down on your shoulder possessively as his swollen sack tightens.  Soon your lower body is flooded with a warmth you've grew to adore.  Ro'gar's seed fills you completely as the musky load coats and stains your hole.  A pressure builds within you, the wet spunk spurting from your rim to drip down your upturned ass cheeks.  Ro'gar's huffs exit through his clenched teeth as he rides out his orgasm, pumping into you a few more times until he's deposited every last drop from his heavy balls.\n\n", false);
		
	outputText("With a sigh of exhaustion his jaw unlatches from your shoulder and he lies on the bed next to you.  The pair of you take a moment to catch your breath.  The only sounds you hear are the sounds of labored exhalation until Ro'gar sits up.  With exhausted panting the only sound from both Ro'gar and yourself, you take a few moments to catch your breath.  Ro'gar affectionately nuzzles you before letting you get to your feet, holding you until he's sure you can stand easily.  The pair of you share a knowing look and Ro'gar grins at you.  \"<i>You're amazin', " + player.short + ".  You're welcome anytime ya like.</i>\"  He gives you a tender embrace as you collect your things and walk on wobbly legs toward the door, still feeling cum running down your legs" + (player.armorDescript() != "gear" ? " beneath your garments" : "") + ".  The orc sees you off with a wave and a toothy grin.\n\n", false);
	player.orgasm();
	dynStats("sen", 2);
	player.slimeFeed();
	doNext(camp.returnToCampUseOneHour);
}

//(([Orc Rub Down], get some fun with oils))
private function rubdubWithDaOrcWithoutDucky():void {
	flags[kFLAGS.ROGAR_FUCKED_TODAY] = 1;
	clearOutput();
	spriteSelect(86);
	outputText("By the time you reach Ro'gar he has already reached his bedroom, his shorts on the floor. You eye over his olive green skin, all of it laid bare before you including his limp orc cock hanging over his hefty nutsack.\n\n", false);
	outputText("\"<i>I purchased these oils to relax my muscles after spending so much time in the gym.</i>\" Your orc lover motions to a few bottle of oils on his night stand. \"<i>How about you give me a hand... or two.</i>\" Ro'gar grins at you, his eyebrows twitching suggestively. You need no further provocation as you strip from your " + player.armorName + ", you let it fall into a pile on the floor as you make for the bottle. Ro'gar grins and rolls onto his stomach.\n\n", false);
	outputText("The bottles pop open easily and you pour a generous amount over your hand, you spill even more over Ro'gar back. He gasps feeling the cool liquid crawl down the spine of his back. Though it's not long after you warm his skin with your hands. Your fingers spread and smear the oils over his damp skin. You crawl up and straddle Ro'gar's hips, sitting on his muscled ass as you begin to rub the oils in.\n\n", false);
	outputText("Ro'gar's skin under your fingertips feels stiff, his muscles resisting your insistent touches. Slowly you can feel them relax, they smooth out and grow warm under your palms. It's not long until Ro'gar is purring loud enough for you to hear. With a pleased growl Ro'gar shifts under your body briefly before letting you continue.\n\n", false);
        outputText("\"<i>That's the spot.</i>\" Ro'gar grunts as you work your thumbs over a certain spot near his shoulders. You curve your fingers around his broad shoulder and gently pull the muscles to stretch away from the neck. Ro'gar's mouth bellows a moan as his head falls to the sheets. The oils mixing with the strange liquid secreted from the orc's skin making a curious concoction. You can feel your hands feeling so warm and soothed, the muscles in your hands relaxed and comforted. As you look along Ro'gar glistening back you wonder how it would feel to have such a large area affected by the slurry.\n\n", false);
	outputText("You ask Ro'gar to flip over as you get off of his hips to get more oils. By the time you turn around your orc lover has already laid out on his back. Your eyes take in the sight of your muscled lover laid out for you, his muscled limbs bulging in anticipation, his swollen cock growing larger before your eyes. He grins at you as you pour oils over his chest, the cool liquid making him shiver as it drips down along his center. The clear oil crawling in between his pectorals, down his treasure trail and dipping into his navel before filling the gaps in his abdominals.\n\n", false); 
	outputText("Without any hesitation you straddle the orc's hips again, his engorged orc cock brushing against the bare skin of your " + player.buttDescript () + ". Your hands get to work smearing the relaxing oil over Ro'gar's body. The orc stares at you with a lurid gaze as you massage his bulging pectorals, teasing his darkened nipples with your fingers. You grin feeling Ro'gar's thick cock pressing more against your " + player.buttDescript () + " as his chest rumbles under your hands.\n\n", false);
        outputText("\"<i>You're good at this " + player.short + ", have you done this before?</i>\" Ro'gar purrs as you work over his abdominals, tracing over every gap with your fingertips, the oils glistening over your lover's body. Ro'gar's hips buck gently, bumping your " + player.buttDescript () + " with his throbbing cock with a chuckle, his mouth curls into a coy smile. You watch as Ro'gar reaches his arms back, resting his head on his hands as he bares his underarm and pits.\n\n", false);
	//[Play with pits][Ignore pits]
	simpleChoices("Play with pits", sexyOrcPitsAreSexy, "Ignore pits", lickSomeMoreOrcButNoPits, "", null, "", null, "", null);
}
//[Play with pits]
private function sexyOrcPitsAreSexy():void {
	clearOutput();
	spriteSelect(86);
	outputText("You lean forward enticed by Ro'gar's arm pits. The smile on his lips grows broader as your tongue sinks into his musky sweat centers. You can feel his fat orc dick drooling precum as you lap your tongue over the wet olive skin.\n\n", false);
	outputText("\"<i>Ohhhh, you ain't afraid to get a little dirty. One of your best qualities.</i>\" Ro'gar leans back and lets you go to town, you wash the arm pits out thoroughly with your mouth. Your lips kissing at the skin and mixing your saliva with the sweat and masculine musk. The strong overpowering scent of your lover's scent drowning your nose, the tang of his masculinity dripping from your mouth as you swirl the taste in your mouth.\n\n", false);
	outputText("With a tilt of your head you press your mouth to Ro'gar's. His lips part for yours and your tongue dances with his, his hand stroking your sides as he growls low in need into your mouth. His hot lips and tongue pressing hard to your own. He tries to dominate your mouth, his tongue wrestling with yours to push it where he wills. His teeth catch and nip your bottom lip with a low possessive growl.\n\n", false);
	outputText("\"<i>So skilled with your mouth and hands, care to give me a good finish? I'll be sure to tip.</i>\" He winks playfully. With a smile on your face you back up a bit, dragging your " + player.multiCockDescriptLight() + " over his own. Abruptly Ro'gar blurts out a moan, his breath labored as his fat green dick humps your own " + player.multiCockDescriptLight() + ". An idea fresh in your mind as you hump back, driving the orc male wild as he grunts and pants. His slime and oil slick body madly rubbing over your own. A gasping and moaning mess of muscle and orc flesh, he is left writhing under you, his mouth hung open in needy groans desperate for your touch, your warmth, your body.\n\n", false);
	outputText("After creating a overflowing pool of orc precum mixed with your own, the slurry dripping from Ro'gar's stomach, you return to moving backwards. Ro'gar's throbbing pillar of orc manhood in front of your face as your hands make it stand tall. Your orc lover pants breathlessly as you pump his fat dick in your hands, they are still slick with oil and slime. The reward waiting for you is copious amount of thick orcish precum dripping down over your fingers and palms. The hot liquid pearling at his darkened cockhead, your lips planting a kiss to the tip of your lover's massive prick. His strong scented seed smeared over your lips, perfect for your tongue to snake out and collect as Ro'gar watches on with lust filled eyes.\n\n", false);
	outputText("As one hand pumps Ro'gar's massive cock you press your lips it his heavy ball sack, your tongue lavishing warm slippery affections onto his cum filled orbs. You can hear his body shuddering as you drive him mad, your free hand rubbing over his puckered hole as you pleasure his manhood with hand and mouth. With a wet slurping sound you take in a mouthfull of your orc lover's hefty sack, the tang of his musk drowning your tongue as you suckle on his jewels. Shortly after you slip a finger into Ro'gar's hole, the slick digit wiggling past the orc's resistance and stretching the tight flesh a little.\n\n", false);
	outputText("\"<i>" + player.short + " you are just... too much...</i>\" Ro'gar is left almost speechless as you drag your tongue up along his fat, green shaft. Without missing a beat you wrap your lips around his needly cockhead, the drooling precum hot against your tongue as you drink his seed right from the tap. Your orc lover lays out on the bed, his legs spread wide, his loins bare to your relentless teasing touches. Soon you head is bobbing along Ro'gar orc cock, a second finger slipping into Ro'gar asshole. You time your mouth movements to the bobbing of your head. The length hilting into your mouth as you deepthroat the orcish manhood, your free hand massages Ro'gar's balls as you force a third finger to thrust in Ro'gar's pucker.\n\n", false);
	outputText("\"<i>Raaa..</i>\" Ro'gar strains his face, you can tell why as you feel his heavy balls clench. Swiftly you pull your head back and brace yourself as you get your generous tip. Ro'gar roars out in pleasure as his fat dick pumps your mouth full of his hot orc spunk. The thick load gushing out of his cockhead splashing and filling your mouth making it burst from your lips despite your attempts to keep up. You can feel the orc spunk dribble down your chin as you gulp down the creamy seed. You continue to suckle on Ro'gar massive orc dick as it softens, cleaning the thick cum clinging to it until it's flaccid and spent.\n\n", false);
	outputText("\"<i>Come here you..</i>\" Ro'gar bends forward to tug you into his warm embrace. \"<i>You are too good at that... couldn't last long at all. Y'all put my endurance ta shame " + player.short + ".</i>\" he purrs as you wraps you in his arms. You chuckle and smile as you rest against his warm body, the pair of you laying out over the soft bed sheets. He seems to hold you very tight, almost unwilling to let you go even if you wiggle. You decide to just lay with your orc lover as you rest your eyes. Ro'gar rumbling snore makes you blink open your eyes and snicker. How very like him to get so worked up that he crashes shortly after. His arms holding you close and snuggling with you as if you were his treasured plush toy probably relaxed him until he drifted off... the oils might have helped too. With a yawn you decide to rest yourself, closing your eyes and drifting off surrounded by the warm affection of your orcish lover like a blanket.\n\n", false);
        player.orgasm();
        dynStats("sen", 2);
	player.slimeFeed();
	//end
	doNext(camp.returnToCampUseOneHour);
}
//[Ignore pits]
private function lickSomeMoreOrcButNoPits():void {
	clearOutput();
	spriteSelect(86);
	outputText("With a tilt of your head you press your mouth to Ro'gar's. His lips part for yours and your tongue dances with his, his hand stroking your sides as he growls low in need into your mouth. His hot lips and tongue pressing hard to your own. He tries to dominate your mouth, his tongue wrestling with yours to push it where he wills. His teeth catch and nip your bottom lip with a low possessive growl.\n\n", false);
	outputText("\"<i>So skilled with your mouth and hands, care to give me a good finish? I'll be sure to tip.</i>\" He winks playfully. With a smile on your face you back up a bit, dragging your " + player.multiCockDescriptLight() + " over his own. Abruptly Ro'gar blurts out a moan, his breath labored as his fat green dick humps your own " + player.multiCockDescriptLight() + ". An idea fresh in your mind as you hump back, driving the orc male wild as he grunts and pants. His slime and oil slick body madly rubbing over your own. A gasping and moaning mess of muscle and orc flesh, he is left writhing under you, his mouth hung open in needy groans desperate for your touch, your warmth, your body.\n\n", false);
	outputText("After creating a overflowing pool of orc precum mixed with your own, the slurry dripping from Ro'gar's stomach, you return to moving backwards. Ro'gar's throbbing pillar of orc manhood in front of your face as your hands make it stand tall. Your orc lover pants breathlessly as you pump his fat dick in your hands, they are still slick with oil and slime. The reward waiting for you is copious amount of thick orcish precum dripping down over your fingers and palms. The hot liquid pearling at his darkened cockhead, your lips planting a kiss to the tip of your lover's massive prick. His strong scented seed smeared over your lips, perfect for your tongue to snake out and collect as Ro'gar watches on with lust filled eyes.\n\n", false);
	outputText("As one hand pumps Ro'gar's massive cock you press your lips it his heavy ball sack, your tongue lavishing warm slippery affections onto his cum filled orbs. You can hear his body shuddering as you drive him mad, your free hand rubbing over his puckered hole as you pleasure his manhood with hand and mouth. With a wet slurping sound you take in a mouthfull of your orc lover's hefty sack, the tang of his musk drowning your tongue as you suckle on his jewels. Shortly after you slip a finger into Ro'gar's hole, the slick digit wiggling past the orc's resistance and stretching the tight flesh a little.\n\n", false);
	outputText("\"<i>" + player.short + " you are just... too much...</i>\" Ro'gar is left almost speechless as you drag your tongue up along his fat, green shaft. Without missing a beat you wrap your lips around his needly cockhead, the drooling precum hot against your tongue as you drink his seed right from the tap. Your orc lover lays out on the bed, his legs spread wide, his loins bare to your relentless teasing touches. Soon you head is bobbing along Ro'gar orc cock, a second finger slipping into Ro'gar asshole. You time your mouth movements to the bobbing of your head. The length hilting into your mouth as you deepthroat the orcish manhood, your free hand massages Ro'gar's balls as you force a third finger to thrust in Ro'gar's pucker.\n\n", false);
	outputText("\"<i>Raaa..</i>\" Ro'gar strains his face, you can tell why as you feel his heavy balls clench. Swiftly you pull your head back and brace yourself as you get your generous tip. Ro'gar roars out in pleasure as his fat dick pumps your mouth full of his hot orc spunk. The thick load gushing out of his cockhead splashing and filling your mouth making it burst from your lips despite your attempts to keep up. You can feel the orc spunk dribble down your chin as you gulp down the creamy seed. You continue to suckle on Ro'gar massive orc dick as it softens, cleaning the thick cum clinging to it until it's flaccid and spent.\n\n", false);
	outputText("\"<i>Come here you..</i>\" Ro'gar bends forward to tug you into his warm embrace. \"<i>You are too good at that... couldn't last long at all. Y'all put my endurance ta shame " + player.short + ".</i>\" he purrs as you wraps you in his arms. You chuckle and smile as you rest against his warm body, the pair of you laying out over the soft bed sheets. He seems to hold you very tight, almost unwilling to let you go even if you wiggle. You decide to just lay with your orc lover as you rest your eyes. Ro'gar rumbling snore makes you blink open your eyes and snicker. How very like him to get so worked up that he crashes shortly after. His arms holding you close and snuggling with you as if you were his treasured plush toy probably relaxed him until he drifted off... the oils might have helped too. With a yawn you decide to rest yourself, closing your eyes and drifting off surrounded by the warm affection of your orcish lover like a blanket.\n\n", false);
	player.orgasm();
	dynStats("sen", 2);
	player.slimeFeed();
	//end
	doNext(camp.returnToCampUseOneHour);
}
}
}
